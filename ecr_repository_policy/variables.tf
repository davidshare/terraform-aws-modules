variable "repository" {
  description = "The name of the ECR repository to apply the policy to."
  type        = string
}

variable "statements" {
  description = "List of policy statements to apply to the repository."
  type = list(object({
    sid        = optional(string)
    effect     = string
    actions    = list(string)
    resources  = optional(list(string), ["*"])
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
  }))
}