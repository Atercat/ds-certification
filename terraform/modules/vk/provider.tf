terraform {
  required_providers {
    vkcs = {
      source  = "vk-cs/vkcs"
      version = "0.1.6"
    }
  }
}

provider "vkcs" {
    region = "RegionOne"
}