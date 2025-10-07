variable "name" {
  description = "The name of the DB subnet group. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with 'name'."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the DB subnet group. Defaults to 'Managed by Terraform'."
  type        = string
  default     = "Managed by Terraform"
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
