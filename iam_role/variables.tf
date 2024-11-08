variable "name" {
  description = "Name of the role"
  type        = string
}

variable "assume_role_policy" {
  description = "Policy that grants an entity permission to assume the role"
  type        = string
}

variable "policies" {
  description = "List of IAM policies to attach to the role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to the role"
  type        = map(string)
  default     = {}
}