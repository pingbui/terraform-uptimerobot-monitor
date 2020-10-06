variable "api_key" {
  description = "The API Key of the UptimeRobot account"
  type        = string
}

variable "slack_friendly_name" {
  description = "The friendly name of Slack Webhook"
  type        = string
  default     = "Slack Alert"
}

variable "slack_url" {
  description = "The Slack Webhook link"
  type        = string
}

variable "monitors" {
  description = "The list of UptimeRobot monitors"
  type        = list(map(string))
  default     = []
}