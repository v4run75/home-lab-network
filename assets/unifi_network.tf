# Home Network
resource "unifi_network" "home" {
    name                         = var.networks.home.name
    subnet                       = var.networks.home.subnet
    vlan_id                      = var.networks.home.vlan_id
    purpose                      = var.networks.home.purpose
    network_group                = var.networks.home.network_group
    site                         = var.unifi_site
    
    dhcp_enabled                 = var.networks.home.dhcp_enabled
    dhcp_start                   = var.networks.home.dhcp_start
    dhcp_stop                    = var.networks.home.dhcp_stop
    dhcp_lease                   = var.networks.home.dhcp_lease
    dhcp_dns                     = var.networks.home.dhcp_dns
    
    internet_access_enabled      = var.networks.home.internet_access_enabled
    intra_network_access_enabled = var.networks.home.intra_network_access_enabled
    igmp_snooping                = var.networks.home.igmp_snooping
    multicast_dns                = var.networks.home.multicast_dns
    
    ipv6_interface_type          = var.networks.home.ipv6_interface_type
    ipv6_pd_start                 = var.networks.home.ipv6_pd_start
    ipv6_pd_stop                  = var.networks.home.ipv6_pd_stop
    ipv6_ra_enable                = var.networks.home.ipv6_ra_enable
    ipv6_ra_preferred_lifetime    = 14400
    ipv6_ra_priority              = "high"
    ipv6_ra_valid_lifetime        = var.networks.home.ipv6_ra_valid_lifetime
    dhcp_v6_start                 = var.networks.home.dhcp_v6_start
    dhcp_v6_stop                  = var.networks.home.dhcp_v6_stop
}

# Servers Network
resource "unifi_network" "servers" {
    name                         = var.networks.servers.name
    subnet                       = var.networks.servers.subnet
    vlan_id                      = var.networks.servers.vlan_id
    purpose                      = var.networks.servers.purpose
    network_group                = var.networks.servers.network_group
    site                         = var.unifi_site
    
    dhcp_enabled                 = var.networks.servers.dhcp_enabled
    dhcp_start                   = var.networks.servers.dhcp_start
    dhcp_stop                    = var.networks.servers.dhcp_stop
    dhcp_lease                   = var.networks.servers.dhcp_lease
    dhcp_dns                     = var.networks.servers.dhcp_dns
    
    internet_access_enabled      = var.networks.servers.internet_access_enabled
    intra_network_access_enabled = var.networks.servers.intra_network_access_enabled
    igmp_snooping                = var.networks.servers.igmp_snooping
    multicast_dns                = var.networks.servers.multicast_dns
    
    ipv6_interface_type          = var.networks.servers.ipv6_interface_type
    ipv6_pd_interface            = var.networks.servers.ipv6_pd_interface
    ipv6_pd_start                = var.networks.servers.ipv6_pd_start
    ipv6_pd_stop                 = var.networks.servers.ipv6_pd_stop
    ipv6_ra_enable               = var.networks.servers.ipv6_ra_enable
    ipv6_ra_preferred_lifetime   = 14400
    ipv6_ra_priority             = "high"
    ipv6_ra_valid_lifetime       = var.networks.servers.ipv6_ra_valid_lifetime
    dhcp_v6_start                = var.networks.servers.dhcp_v6_start
    dhcp_v6_stop                 = var.networks.servers.dhcp_v6_stop
}

# IoT Network
resource "unifi_network" "iot" {
    name                         = var.networks.iot.name
    subnet                       = var.networks.iot.subnet
    vlan_id                      = var.networks.iot.vlan_id
    purpose                      = var.networks.iot.purpose
    network_group                = var.networks.iot.network_group
    site                         = var.unifi_site
    
    dhcp_enabled                 = var.networks.iot.dhcp_enabled
    dhcp_start                   = var.networks.iot.dhcp_start
    dhcp_stop                    = var.networks.iot.dhcp_stop
    dhcp_lease                   = var.networks.iot.dhcp_lease
    dhcp_dns                     = var.networks.iot.dhcp_dns
    
    internet_access_enabled      = var.networks.iot.internet_access_enabled
    intra_network_access_enabled = var.networks.iot.intra_network_access_enabled
    igmp_snooping                = var.networks.iot.igmp_snooping
    multicast_dns                = var.networks.iot.multicast_dns
    
    ipv6_interface_type          = var.networks.iot.ipv6_interface_type
    ipv6_pd_start                = var.networks.iot.ipv6_pd_start
    ipv6_pd_stop                 = var.networks.iot.ipv6_pd_stop
    ipv6_ra_enable               = var.networks.iot.ipv6_ra_enable
    ipv6_ra_preferred_lifetime   = 14400
    ipv6_ra_priority             = "high"
    ipv6_ra_valid_lifetime       = var.networks.iot.ipv6_ra_valid_lifetime
    dhcp_v6_start                = var.networks.iot.dhcp_v6_start
    dhcp_v6_stop                 = var.networks.iot.dhcp_v6_stop
}

# Guest Network
resource "unifi_network" "guest" {
    name                         = var.networks.guest.name
    subnet                       = var.networks.guest.subnet
    vlan_id                      = var.networks.guest.vlan_id
    purpose                      = var.networks.guest.purpose
    network_group                = var.networks.guest.network_group
    site                         = var.unifi_site
    
    dhcp_enabled                 = var.networks.guest.dhcp_enabled
    dhcp_start                   = var.networks.guest.dhcp_start
    dhcp_stop                    = var.networks.guest.dhcp_stop
    dhcp_lease                   = var.networks.guest.dhcp_lease
    dhcp_dns                     = var.networks.guest.dhcp_dns
    
    internet_access_enabled      = var.networks.guest.internet_access_enabled
    intra_network_access_enabled = var.networks.guest.intra_network_access_enabled
    igmp_snooping                = var.networks.guest.igmp_snooping
    multicast_dns                = var.networks.guest.multicast_dns
    
    ipv6_interface_type          = var.networks.guest.ipv6_interface_type
    ipv6_pd_start                = var.networks.guest.ipv6_pd_start
    ipv6_pd_stop                 = var.networks.guest.ipv6_pd_stop
    ipv6_ra_enable               = var.networks.guest.ipv6_ra_enable
    ipv6_ra_preferred_lifetime   = 14400
    ipv6_ra_priority             = "high"
    ipv6_ra_valid_lifetime       = var.networks.guest.ipv6_ra_valid_lifetime
    dhcp_v6_start                = var.networks.guest.dhcp_v6_start
    dhcp_v6_stop                 = var.networks.guest.dhcp_v6_stop
}

# WAN Network
resource "unifi_network" "wan" {
    name                      = var.wan_network.name
    purpose                   = "wan"
    site                      = var.unifi_site
    
    wan_type                  = var.wan_network.wan_type
    wan_type_v6               = var.wan_network.wan_type_v6
    wan_dns                   = var.wan_network.wan_dns
    wan_networkgroup          = var.wan_network.wan_networkgroup
    wan_dhcp_v6_pd_size       = var.wan_network.wan_dhcp_v6_pd_size
    dhcp_lease                = var.wan_network.dhcp_lease
    dhcp_v6_dns_auto          = var.wan_network.dhcp_v6_dns_auto
    dhcp_v6_lease             = var.wan_network.dhcp_v6_lease
    ipv6_ra_preferred_lifetime = var.wan_network.ipv6_ra_preferred_lifetime
    ipv6_ra_valid_lifetime    = var.wan_network.ipv6_ra_valid_lifetime
}
