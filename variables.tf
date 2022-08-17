variable "api_key" {
  description = "The API Key of the UptimeRobot account"
  type        = string
}

variable "contacts" {
  description = "The list of contacts"
  type        = list(map(string))
  default     = []
}

variable "monitors" {
  description = "The list of UptimeRobot monitors"
  type        = list(map(string))
  default     = []
}
