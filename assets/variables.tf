variable "username" {
    description = "Unifi Username"
    type = string
}

variable "password" {
    description = "Unifi Password"
    type = string
}

variable "controller_url" {
    description = "Controller URL"
    type = string
}

variable "unifi_site" {
    description = "Home Site"
    type = string
    default = "default"  
}

variable "allow_insecure" {
    default = true
    description = "Allow insecure SSL connections to the API"
    type = bool
}

# WIFI PASSWORDS
variable "home_wlan_pass" {
    description = "Home's Password"
    type = string
}

variable "server_wlan_pass" {
    description = "Server's Password"
    type = string
}

variable "iot_wlan_pass" {
    description = "IOT's Password"
    type = string
}

variable "guest_wlan_pass" {
    description = "Guest's Password"
    type = string
}

variable "site_id" {
    description = "Default Site ID"
    type = string
}

# Network Configuration Variables
variable "networks" {
    description = "Network configurations"
    type = map(object({
        name                         = string
        subnet                       = string
        vlan_id                      = number
        purpose                      = string
        network_group                = optional(string, "LAN")
        dhcp_enabled                 = optional(bool, true)
        dhcp_start                   = optional(string)
        dhcp_stop                    = optional(string)
        dhcp_lease                   = optional(number, 86400)
        dhcp_dns                     = optional(list(string), [])
        internet_access_enabled      = optional(bool, true)
        intra_network_access_enabled = optional(bool, true)
        igmp_snooping                = optional(bool, false)
        multicast_dns                = optional(bool, false)
        ipv6_interface_type          = optional(string, "none")
        ipv6_pd_interface            = optional(string)
        ipv6_pd_start                = optional(string)
        ipv6_pd_stop                 = optional(string)
        ipv6_ra_enable               = optional(bool, false)
        ipv6_ra_valid_lifetime       = optional(number, 0)
        dhcp_v6_start                = optional(string)
        dhcp_v6_stop                 = optional(string)
    }))
}

variable "wan_network" {
    description = "WAN network configuration"
    type = object({
        name                      = string
        wan_type                  = string
        wan_type_v6               = optional(string)
        wan_dns                   = optional(list(string), [])
        wan_networkgroup           = optional(string, "WAN")
        wan_dhcp_v6_pd_size       = optional(number, 56)
        dhcp_lease                = optional(number, 0)
        dhcp_v6_dns_auto          = optional(bool, false)
        dhcp_v6_lease             = optional(number, 0)
        ipv6_ra_preferred_lifetime = optional(number, 0)
        ipv6_ra_valid_lifetime    = optional(number, 0)
    })
}