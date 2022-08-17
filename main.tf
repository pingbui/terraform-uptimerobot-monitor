provider "uptimerobot" {
  api_key = var.api_key
}

resource "uptimerobot_alert_contact" "this" {
  for_each      = { for c in var.contacts : c.friendly_name => c }
  friendly_name = try(each.value.friendly_name, "default")
  type          = try(each.value.type, "e-mail")
  value         = try(each.value.value, null)
}

locals {
  alert_contacts = try(uptimerobot_alert_contact.this[*].id, [])
}

resource "uptimerobot_monitor" "this" {
  for_each = { for m in var.monitors : m.friendly_name => m }

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
      id = try(alert_contact.value, null)
      # threshold  = 0  # pro only
      # recurrence = 0  # pro only
    }
  }

}
