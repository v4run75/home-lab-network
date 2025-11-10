# unifi_wlan.home:
resource "unifi_wlan" "home" {
    ap_group_ids              = [
        "6608899da6744604ed928ad3",
    ]
    bss_transition            = true
    fast_roaming_enabled      = false
    hide_ssid                 = false
    is_guest                  = false
    l2_isolation              = false
    mac_filter_enabled        = false
    mac_filter_list           = []
    mac_filter_policy         = "deny"
    minimum_data_rate_2g_kbps = 1000
    minimum_data_rate_5g_kbps = 6000
    multicast_enhance         = false
    name                      = "Voidd"
    network_id                = "6608899da6744604ed928ac9"
    no2ghz_oui                = true
    passphrase                = var.home_wlan_pass
    pmf_mode                  = "disabled"
    proxy_arp                 = false
    radius_profile_id         = null
    security                  = "wpapsk"
    site                      = "default"
    uapsd                     = false
    user_group_id             = "6608899da6744604ed928aca"
    wlan_band                 = "both"
    wpa3_support              = false
    wpa3_transition           = false
}

# unifi_wlan.server:
resource "unifi_wlan" "server" {
    ap_group_ids              = [
        "6608899da6744604ed928ad3",
    ]
    bss_transition            = true
    fast_roaming_enabled      = false
    hide_ssid                 = false
    is_guest                  = false
    l2_isolation              = false
    mac_filter_enabled        = false
    mac_filter_list           = []
    mac_filter_policy         = "deny"
    minimum_data_rate_2g_kbps = 0
    minimum_data_rate_5g_kbps = 0
    multicast_enhance         = false
    name                      = "Zodiac"
    network_id                = "660890a836fdac041bcbe23e"
    no2ghz_oui                = true
    passphrase                = var.server_wlan_pass
    pmf_mode                  = "disabled"
    proxy_arp                 = false
    radius_profile_id         = null
    security                  = "wpapsk"
    site                      = "default"
    uapsd                     = false
    user_group_id             = "6608899da6744604ed928aca"
    wlan_band                 = "both"
    wpa3_support              = false
    wpa3_transition           = false
}

# unifi_wlan.iot:
resource "unifi_wlan" "iot" {
    ap_group_ids              = [
        "6608899da6744604ed928ad3",
    ]
    bss_transition            = true
    fast_roaming_enabled      = false
    hide_ssid                 = false
    is_guest                  = false
    l2_isolation              = false
    mac_filter_enabled        = false
    mac_filter_list           = []
    mac_filter_policy         = "deny"
    minimum_data_rate_2g_kbps = 0
    minimum_data_rate_5g_kbps = 0
    multicast_enhance         = false
    name                      = "IOT"
    network_id                = "6611b98a39329a2ec51f76c3"
    no2ghz_oui                = true
    passphrase                = var.iot_wlan_pass
    pmf_mode                  = "disabled"
    proxy_arp                 = false
    radius_profile_id         = null
    security                  = "wpapsk"
    site                      = "default"
    uapsd                     = false
    user_group_id             = "6608899da6744604ed928aca"
    wlan_band                 = "2g"
    wpa3_support              = false
    wpa3_transition           = false
}

# unifi_wlan.guest:
resource "unifi_wlan" "guest" {
    ap_group_ids              = [
        "6608899da6744604ed928ad3",
    ]
    bss_transition            = true
    fast_roaming_enabled      = false
    hide_ssid                 = false
    is_guest                  = false
    l2_isolation              = false
    mac_filter_enabled        = false
    mac_filter_list           = []
    mac_filter_policy         = "deny"
    minimum_data_rate_2g_kbps = 0
    minimum_data_rate_5g_kbps = 0
    multicast_enhance         = false
    name                      = "1211_Guest"
    network_id                = "6611a75739329a2ec51f752d"
    no2ghz_oui                = true
    passphrase                = var.guest_wlan_pass
    pmf_mode                  = "disabled"
    proxy_arp                 = false
    radius_profile_id         = null
    security                  = "wpapsk"
    site                      = "default"
    uapsd                     = false
    user_group_id             = "6608899da6744604ed928aca"
    wlan_band                 = "both"
    wpa3_support              = false
    wpa3_transition           = false
}

