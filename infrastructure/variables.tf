variable "domain" {
  type        = string
  description = "The domain of the project"
}

variable "name" {
  type        = string
  description = "The project name"
}

variable "tags" {
  type = object({
    project = string
  })
  description = "Tags"
}

variable "zone_id" {
  type        = string
  description = "Route53 Zone ID"
}
