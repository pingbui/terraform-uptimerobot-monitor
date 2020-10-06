terraform {
  required_version = ">= 0.12.29, < 0.14"

  required_providers {
    uptimerobot = {
      source = "louy/uptimerobot"
      version = "0.5.1"
    }
  }
}
