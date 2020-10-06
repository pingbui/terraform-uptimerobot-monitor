terraform {
  required_version = ">= 0.13.0, < 0.14"

  required_providers {
    uptimerobot = {
      source = "louy/uptimerobot"
      version = "0.5.1"
    }
  }
}
