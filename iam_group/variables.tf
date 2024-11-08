variable "name" {
  description = "The name of the IAM group"
  type        = string
}

variable "path" {
  description = "Path in which to create the group"
  type        = string
  default     = "/"
}

variable "users" {
  description = "List of IAM users to add to the group"
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "List of IAM policies to attach to the group"
  type        = list(string)
  default     = []
}