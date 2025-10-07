variable "aws_region" {
  description = "The AWS region where resources will be managed."
  type        = string
  default     = "us-west-2"
}

variable "version" {
  description = "IAM policy document version. Defaults to 2012-10-17."
  type        = string
  default     = "2012-10-17"
}

variable "statements" {
  description = "List of IAM policy statements to include in the policy document."
  type = list(object({
    sid                = string
    actions            = list(string)
    effect             = string
    resources          = list(string)
    not_actions        = list(string)
    not_resources      = list(string)
    not_principals     = list(string)
    condition_test     = string
    condition_variable = string
    condition_values   = list(string)
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
  }))
  default = []
}

variable "source_policy_documents" {
  description = "List of source IAM policy documents to be merged."
  type        = list(string)
  default     = []
}

variable "override_policy_documents" {
  description = "List of override IAM policy documents."
  type        = list(string)
  default     = []
}
