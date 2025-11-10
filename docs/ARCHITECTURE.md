# Terraform Backend Git Architecture

## System Architecture

```mermaid
graph TB
    subgraph "Local Development"
        A[Developer] -->|Runs| B[tf-init.sh<br/>tf-plan.sh<br/>tf-apply.sh<br/>tf-destroy.sh]
        B -->|Executes| C[terraform-backend-git<br/>git terraform]
        C -->|Starts| D[HTTP Backend Server<br/>127.0.0.1:6061]
        C -->|Runs| E[Terraform CLI]
    end
    
    subgraph "Backend Server"
        D -->|Manages| F[State Locking]
        D -->|Stores/Retrieves| G[State File]
    end
    
    subgraph "Git Repository"
        G -->|Push/Pull| H[GitHub Repository<br/>user/<br/>repository-name.git]
        H -->|Branch| I[main branch]
        I -->|File| J[terraform.tfstate]
    end
    
    subgraph "UniFi Infrastructure"
        E -->|Manages| K[UniFi Controller<br/>192.168.X.X]
        K -->|Configures| L[Networks<br/>WLANs<br/>Sites]
    end
    
    style A fill:#e1f5ff
    style B fill:#fff4e1
    style C fill:#ffe1f5
    style D fill:#e1ffe1
    style H fill:#f5e1ff
    style K fill:#ffe1e1
```

## Workflow Diagram

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Script as tf-*.sh Script
    participant Backend as terraform-backend-git
    participant HTTP as HTTP Server<br/>(localhost:6061)
    participant Git as GitHub Repository
    participant Terraform as Terraform CLI
    participant UniFi as UniFi Controller

    Dev->>Script: Execute script (init/plan/apply/destroy)
    Script->>Backend: terraform-backend-git git terraform
    Backend->>HTTP: Start HTTP server
    HTTP-->>Backend: Server ready
    
    Backend->>Git: Clone/Pull repository
    Git-->>Backend: State file (if exists)
    
    Backend->>HTTP: Register backend endpoints
    Backend->>Terraform: Execute terraform command
    
    Terraform->>HTTP: GET /terraform_state (read state)
    HTTP->>Git: Fetch latest state
    Git-->>HTTP: Return state file
    HTTP-->>Terraform: State data
    
    Terraform->>HTTP: POST /terraform_lock (acquire lock)
    HTTP->>Git: Create lock file
    Git-->>HTTP: Lock acquired
    
    Terraform->>UniFi: Apply configuration changes
    UniFi-->>Terraform: Configuration applied
    
    Terraform->>HTTP: PUT /terraform_state (save state)
    HTTP->>Git: Commit & push state
    Git-->>HTTP: State saved
    
    Terraform->>HTTP: DELETE /terraform_lock (release lock)
    HTTP->>Git: Remove lock file
    Git-->>HTTP: Lock released
    
    Backend->>HTTP: Stop server
    Backend-->>Script: Command completed
    Script-->>Dev: Results
```

## Component Relationships

```mermaid
graph LR
    subgraph "Configuration Files"
        A[terraform-backend-git.hcl<br/>Repository config]
        B[main.tf<br/>Terraform config]
        C[terraform.tfvars<br/>Variables]
        D[variables.tf<br/>Variable definitions]
    end
    
    subgraph "Scripts"
        E[tf-init.sh]
        F[tf-plan.sh]
        G[tf-apply.sh]
        H[tf-destroy.sh]
    end
    
    subgraph "Backend"
        I[terraform-backend-git<br/>CLI Tool]
        J[HTTP Server<br/>Port 6061]
        K[git_http_backend.auto.tf<br/>Auto-generated]
    end
    
    subgraph "State Storage"
        L[GitHub Repository]
        M[terraform.tfstate<br/>State file]
    end
    
    A --> I
    B --> I
    C --> E
    C --> F
    C --> G
    C --> H
    D --> B
    
    E --> I
    F --> I
    G --> I
    H --> I
    
    I --> J
    I --> K
    J --> L
    L --> M
    
    style A fill:#e1f5ff
    style I fill:#ffe1f5
    style J fill:#e1ffe1
    style L fill:#f5e1ff
```

## State Management Flow

```mermaid
stateDiagram-v2
    [*] --> LocalState: Initial Setup
    LocalState --> GitBackend: tf-init.sh
    GitBackend --> LockAcquired: Start Operation
    LockAcquired --> StateRead: Read from Git
    StateRead --> StateModified: Terraform Changes
    StateModified --> StateWritten: Write to Git
    StateWritten --> LockReleased: Release Lock
    LockReleased --> [*]: Operation Complete
    
    note right of GitBackend
        State stored in:
        GitHub Repository
        Branch: main
        File: terraform.tfstate
    end note
```

## Script Execution Flow

```mermaid
flowchart TD
    Start([User runs script]) --> Check{Which script?}
    
    Check -->|tf-init.sh| Init[Initialize Backend]
    Check -->|tf-plan.sh| Plan[Plan Changes]
    Check -->|tf-apply.sh| Apply[Apply Changes]
    Check -->|tf-destroy.sh| Destroy[Destroy Resources]
    
    Init --> StartBackend[Start terraform-backend-git]
    Plan --> StartBackend
    Apply --> StartBackend
    Destroy --> StartBackend
    
    StartBackend --> ConnectGit[Connect to Git Repository]
    ConnectGit --> LoadState{State exists?}
    
    LoadState -->|Yes| UseExisting[Use existing state]
    LoadState -->|No| CreateNew[Create new state]
    
    UseExisting --> RunTerraform[Run Terraform Command]
    CreateNew --> RunTerraform
    
    RunTerraform --> LockState[Acquire State Lock]
    LockState --> Execute[Execute Terraform Operation]
    Execute --> UpdateState[Update State in Git]
    UpdateState --> ReleaseLock[Release State Lock]
    ReleaseLock --> StopBackend[Stop Backend Server]
    StopBackend --> End([Complete])
    
    style Start fill:#e1f5ff
    style StartBackend fill:#ffe1f5
    style ConnectGit fill:#f5e1ff
    style Execute fill:#ffe1e1
    style End fill:#e1ffe1
```

## Network Topology

### Infrastructure Network Diagram

```mermaid
graph TB
    subgraph "Internet"
        WAN[Internet<br/>WAN Connection<br/>DHCP/DHCPv6]
    end
    
    subgraph "UniFi Controller"
        UC[UniFi Controller<br/>Controller IP<br/>Site: default]
    end
    
    subgraph "Home Network - VLAN 0"
        HN[Home Network<br/>Subnet: 192.168.X.0/24<br/>VLAN: 0<br/>DHCP Range: X.6-X.254]
        HN_WLAN[WLAN: Home<br/>2.4GHz + 5GHz<br/>WPA2-PSK]
        HN_DEV[Home Devices<br/>Laptops, Phones, etc.]
    end
    
    subgraph "Servers Network - VLAN 2"
        SN[Server Network<br/>Subnet: 192.168.X.0/24<br/>VLAN: 2<br/>DHCP Range: X.6-X.254]
        SN_WLAN[WLAN: Server<br/>2.4GHz + 5GHz<br/>WPA2-PSK]
        SN_DEV[Server Devices<br/>Servers, VMs]
        DNS[DNS Server<br/>Internal DNS IP]
    end
    
    subgraph "IoT Network - VLAN 4"
        IN[IoT Network<br/>Subnet: 192.168.X.0/24<br/>VLAN: 4<br/>DHCP Range: X.6-X.254]
        IN_WLAN[WLAN: IoT<br/>2.4GHz Only<br/>WPA2-PSK]
        IN_DEV[IoT Devices<br/>Smart Home, Sensors]
    end
    
    subgraph "Guest Network - VLAN 3"
        GN[Guest Network<br/>Subnet: 192.168.X.0/24<br/>VLAN: 3<br/>DHCP Range: X.6-X.254]
        GN_WLAN[WLAN: Guest<br/>2.4GHz + 5GHz<br/>WPA2-PSK]
        GN_DEV[Guest Devices<br/>Visitors, BYOD]
    end
    
    subgraph "UniFi Access Points"
        AP[UniFi APs<br/>AP Group]
    end
    
    WAN -->|Internet Access| UC
    UC -->|Manages| HN
    UC -->|Manages| SN
    UC -->|Manages| IN
    UC -->|Manages| GN
    
    HN --> HN_WLAN
    SN --> SN_WLAN
    IN --> IN_WLAN
    GN --> GN_WLAN
    
    HN_WLAN --> AP
    SN_WLAN --> AP
    IN_WLAN --> AP
    GN_WLAN --> AP
    
    AP -->|Wireless| HN_DEV
    AP -->|Wireless| SN_DEV
    AP -->|Wireless| IN_DEV
    AP -->|Wireless| GN_DEV
    
    SN --> DNS
    HN -.->|DNS Query| DNS
    SN -.->|DNS Query| DNS
    
    HN -->|Internet Access| WAN
    SN -->|Internet Access| WAN
    IN -->|Internet Access| WAN
    GN -->|Internet Access| WAN
    
    style UC fill:#ffe1e1
    style HN fill:#e1f5ff
    style SN fill:#fff4e1
    style IN fill:#e1ffe1
    style GN fill:#f5e1ff
    style AP fill:#ffe1f5
    style WAN fill:#e1e1e1
    style DNS fill:#ffffe1
```

### Network Segmentation Diagram

```mermaid
graph LR
    subgraph "Network Segments"
        direction TB
        V0[VLAN 0<br/>Home Network<br/>Subnet: 192.168.X.0/24]
        V2[VLAN 2<br/>Server Network<br/>Subnet: 192.168.X.0/24]
        V3[VLAN 3<br/>Guest Network<br/>Subnet: 192.168.X.0/24]
        V4[VLAN 4<br/>IoT Network<br/>Subnet: 192.168.X.0/24]
    end
    
    subgraph "Wireless Networks"
        direction TB
        W1[Home WLAN<br/>Home Network]
        W2[Server WLAN<br/>Server Network]
        W3[Guest WLAN<br/>Guest Network]
        W4[IoT WLAN<br/>IoT Network]
    end
    
    subgraph "Features"
        direction TB
        F1[Internet Access<br/>All Networks]
        F2[Intra-Network Access<br/>Enabled]
        F3[IGMP Snooping<br/>Home, IoT, Guest]
        F4[Multicast DNS<br/>Home, IoT, Guest]
    end
    
    V0 --> W1
    V2 --> W2
    V3 --> W3
    V4 --> W4
    
    V0 --> F1
    V2 --> F1
    V3 --> F1
    V4 --> F1
    
    V0 --> F2
    V2 --> F2
    V3 --> F2
    V4 --> F2
    
    V0 --> F3
    V3 --> F3
    V4 --> F3
    
    V0 --> F4
    V3 --> F4
    V4 --> F4
    
    style V0 fill:#e1f5ff
    style V2 fill:#fff4e1
    style V3 fill:#f5e1ff
    style V4 fill:#e1ffe1
    style W1 fill:#e1f5ff
    style W2 fill:#fff4e1
    style W3 fill:#f5e1ff
    style W4 fill:#e1ffe1
```

### Data Flow Diagram

```mermaid
sequenceDiagram
    participant Device as Client Device
    participant AP as UniFi Access Point
    participant Controller as UniFi Controller
    participant Network as Network Segment
    participant DNS as DNS Server
    participant Internet as Internet
    
    Device->>AP: Connect to WLAN (SSID)
    AP->>Controller: Authenticate & Assign Network
    Controller->>Network: Assign IP via DHCP
    Network-->>Device: IP Address (DHCP)
    
    Device->>DNS: DNS Query
    DNS-->>Device: IP Resolution
    
    Device->>Network: Data Traffic
    Network->>Internet: Internet Access (if enabled)
    Internet-->>Network: Response
    Network-->>Device: Data
    
    Note over Device,Network: Intra-network access enabled<br/>for all networks
    Note over Network,Internet: Internet access enabled<br/>for all networks
```

