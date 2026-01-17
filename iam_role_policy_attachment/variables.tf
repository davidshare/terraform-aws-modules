variable "role" {
  description = "The name of the IAM role to which the managed policy will be attached."
  type        = string
}

variable "policy_arn" {
  description = "The ARN of the IAM managed policy to attach to the role."
  type        = string
}
