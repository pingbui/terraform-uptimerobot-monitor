terraform {
  required_version = ">= 0.13.0"

  required_providers {
    uptimerobot = {
      source  = "vexxhost/uptimerobot"
      version = "0.8.2"
    }
  }
}
