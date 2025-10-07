variable "name" {
  description = "Desired name for the IAM user"
  type        = string
}

variable "path" {
  description = "Desired path for the IAM user"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  type        = bool
  default     = false
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to IAM user resource"
  type        = map(string)
  default     = {}
}