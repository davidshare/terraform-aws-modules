variable "name" {
  description = "The name of the IAM instance profile."
  type        = string
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with 'name'."
  type        = string
  default     = null
}

variable "path" {
  description = "The path to the instance profile. Defaults to `/`."
  type        = string
  default     = "/"
}

variable "role" {
  description = "The name of the IAM role to associate with the instance profile."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the instance profile."
  type        = map(string)
  default     = {}
}
