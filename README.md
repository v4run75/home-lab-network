# UniFi Home Lab Terraform Configuration

This Terraform project manages UniFi network infrastructure for a home lab environment. It provisions networks, wireless LANs (WLANs), and site configurations using the UniFi Controller API.

## Overview

This configuration manages:
- **4 Networks**: Home, Servers, IoT, and Guest networks with VLAN segmentation
- **4 WLANs**: Home, Server, IoT, and Guest wireless networks
- **Site Configuration**: UniFi site setup

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- Access to a UniFi Controller (tested with UniFi Controller API)
- UniFi Controller credentials with appropriate permissions

## Provider

This project uses the `paultyng/unifi` Terraform provider (version ~> 0.41.0).

## Configuration

### Required Variables

Create a `terraform.tfvars` file with the following variables:

```hcl
controller_url = "https://your-unifi-controller-ip"
username       = "your-unifi-username"
password       = "your-unifi-password"
unifi_site     = "default"  # Optional, defaults to "default"
site_id        = "your-site-id"

# WLAN Passwords
home_wlan_pass   = "your-home-wlan-password"
server_wlan_pass = "your-server-wlan-password"
iot_wlan_pass    = "your-iot-wlan-password"
guest_wlan_pass  = "your-guest-wlan-password"
```

### Network Configuration

The project creates the following networks:

| Network Name | Subnet | VLAN ID | Purpose | Description |
|-------------|--------|---------|---------|-------------|
| Home | 192.168.X.X/24 | 0 | Corporate | Main home network |
| Servers | 192.168.X.X/24 | 2 | Corporate | Server network |
| IOT | 192.168.X.X/24 | 4 | Corporate | IoT device network |
| Guest | 192.168.X.X/24 | 3 | Guest | Guest network |
| Internet 1 | - | 0 | WAN | WAN connection |

### WLAN Configuration

The project creates the following wireless networks:

| SSID | Network | Band | Security |
|------|---------|------|----------|
| Redacted | Home | Both (2.4GHz & 5GHz) | WPA2-PSK |
| Redacted | Servers | Both (2.4GHz & 5GHz) | WPA2-PSK |
| Redacted | IOT | 2.4GHz only | WPA2-PSK |
| Redacted | Guest | Both (2.4GHz & 5GHz) | WPA2-PSK |


_*Note*_: Firewall is currently managed directly via Unifi Console

## Usage

### Initial Setup

1. Clone this repository
2. Copy `terraform.tfvars.example` to `terraform.tfvars` (if you have one) or create your own
3. Fill in your UniFi Controller credentials and configuration

### Initialize Terraform

```bash
terraform init
```

### Plan Changes

Review what Terraform will create or modify:

```bash
terraform plan -var-file terraform.tfvars
```

### Apply Configuration

Apply the configuration to your UniFi Controller:

```bash
terraform apply -var-file terraform.tfvars
```

### Destroy Resources

To remove all managed resources:

```bash
terraform destroy -var-file terraform.tfvars
```

## Project Structure

```
.
├── main.tf              # Provider configuration
├── variables.tf         # Variable definitions
├── site.tf              # UniFi site configuration
├── unifi_network.tf     # Network resource definitions
├── unifi_wlan.tf        # WLAN resource definitions
├── terraform.tfvars     # Contains secrets and Network configs (Personal note: Available in secrets vault)

```

## Security Notes


**Recommendations:**

1. Use environment variables or a secrets management system for production
2. Consider using Terraform Cloud or similar for secure variable storage
3. Never commit `terraform.tfvars` to version control

## Features

- **VLAN Segmentation**: Separate networks for different device types
- **DHCP Configuration**: Automatic IP address assignment with custom DNS servers
- **IPv6 Support**: IPv6 configuration for networks (where applicable)
- **Guest Network**: Isolated guest network with internet access
- **Network Isolation**: Configurable inter-network access controls
- **Multicast DNS**: mDNS support for device discovery (where enabled)

## Customization

To customize networks or WLANs, edit the respective `.tf` files:
- `unifi_network.tf` - Modify network configurations
- `unifi_wlan.tf` - Modify wireless network settings

## Troubleshooting

### Provider Connection Issues

If you encounter SSL certificate issues, the provider is configured with `allow_insecure = true`. For production, ensure proper SSL certificates are configured.

### Site ID

If you have multiple sites, ensure the `site_id` variable matches your target site. You can find the site ID in the UniFi Controller URL or API.

## Resources

- [UniFi Terraform Provider Documentation](https://registry.terraform.io/providers/paultyng/unifi/latest/docs)
- [UniFi Controller Documentation](https://help.ui.com/hc/en-us/articles/360012282453)

## License

This project is for personal/home lab use. Modify as needed for your environment.



