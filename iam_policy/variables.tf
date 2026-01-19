variable "name" {
  description = "Name of the IAM policy. If omitted, Terraform assigns a random, unique name. Forces new resource."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with `name`. Forces new resource."
  type        = string
  default     = null
}

variable "path" {
  description = "Path in which to create the policy."
  type        = string
  default     = "/"
}

variable "description" {
  description = "Description of the IAM policy. Forces new resource."
  type        = string
  default     = null
}

variable "policy" {
  description = <<EOT
The policy document as a JSON-formatted string.

Strongly recommended to use:
- jsonencode()
- aws_iam_policy_document

This avoids formatting, whitespace, and ordering issues.
EOT
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the IAM policy."
  type        = map(string)
  default     = {}
}

variable "delay_after_policy_creation_in_ms" {
  description = <<EOT
Number of milliseconds to wait after creating the policy before setting its version as default.

This may be required in environments with very high S3 or IAM API throughput,
where AWS exhibits eventual consistency delays.
EOT
  type        = number
  default     = null
}
