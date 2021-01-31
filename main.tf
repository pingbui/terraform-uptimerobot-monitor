provider "uptimerobot" {
  api_key = var.api_key
}

data "uptimerobot_account" "account" {}

data "uptimerobot_alert_contact" "default" {
  friendly_name = data.uptimerobot_account.account.email
}

resource "uptimerobot_alert_contact" "slack" {
  friendly_name = var.slack_friendly_name
  type          = "slack"
  value         = var.slack_url
}

locals {
  alert_contacts = [
    {
      name = "slack"
      id   = uptimerobot_alert_contact.slack.id
    },
    {
      name = "default"
      id   = data.uptimerobot_alert_contact.default.id
    }
  ]
}

resource "uptimerobot_monitor" "this" {
  for_each = {for m in var.monitors: m.friendly_name => m}

  friendly_name = lookup(each.value, "friendly_name")
  type          = lookup(each.value, "type")
  sub_type      = lookup(each.value, "sub_type", null)
  url           = lookup(each.value, "url")
  port          = lookup(each.value, "port", null)
  interval      = lookup(each.value, "interval", "300") // pro allows 60 seconds
  http_password = lookup(each.value, "http_password", null)
  http_username = lookup(each.value, "http_username", null)

  dynamic "alert_contact" {
    for_each = toset(local.alert_contacts)

    content {
      id = lookup(alert_contact.value, "id")
      # threshold  = 0  # pro only
      # recurrence = 0  # pro only
    }
  }

}