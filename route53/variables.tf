variable "zone_name" {
  description = "This is the name of the hosted zone"
  type        = string
}

variable "comment" {
  description = "A comment for the hosted zone"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID to associate with a private hosted zone"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Whether to destroy all records in the zone when destroying the zone"
  type        = bool
  default     = false
}

variable "records" {
  description = "List of maps of DNS records"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}