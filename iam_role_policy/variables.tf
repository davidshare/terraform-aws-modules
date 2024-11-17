variable "name" {
  description = "The name of the role policy. If omitted, a random, unique name will be assigned."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with 'name'."
  type        = string
  default     = null
}

variable "role" {
  description = "The name of the IAM role to attach to the policy."
  type        = string
}

variable "policy" {
  description = <<EOT
The inline policy document as a JSON formatted string. 
Use Terraform's jsonencode() function or the aws_iam_policy_document data source to build this document.
EOT
  type        = string
}
