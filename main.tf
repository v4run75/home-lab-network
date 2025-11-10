terraform {
  required_providers {
    unifi = {
      source  = "paultyng/unifi"
      version = "~> 0.41.0"  
    }
  }
}

provider "unifi" {
  username = var.username
  password = var.password
  api_url = var.controller_url
  allow_insecure = var.allow_insecure 
  site = var.unifi_site  
}
