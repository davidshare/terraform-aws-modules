variable "name" {
  description = "The name of the DB parameter group. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "family" {
  description = "The family of the DB parameter group."
  type        = string
}

variable "description" {
  description = "The description of the DB parameter group. Defaults to 'Managed by Terraform'."
  type        = string
  default     = "Managed by Terraform"
}

variable "parameters" {
  description = <<EOT
A list of parameters to apply to the DB parameter group. Each parameter object must have the following structure:
- name: (Required) The name of the DB parameter.
- value: (Required) The value of the DB parameter.
- apply_method: (Optional) The apply method for the parameter. Default is 'immediate'.
EOT
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "immediate")
  }))
  default = []
}

variable "skip_destroy" {
  description = "Set to true to prevent the parameter group from being deleted at destroy time."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}