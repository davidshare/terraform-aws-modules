variable "statement" {
  description = "Policy statement"
  type = list(object({
    sid       = string
    effect    = string
    actions   = list(string)
    resources = list(string)
    condition = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
}

variable "policy_id" {
  description = "An ID for the policy document"
  type        = string
  default     = null
}

variable "version" {
  description = "IAM policy document version"
  type        = string
  default     = "2012-10-17"
}