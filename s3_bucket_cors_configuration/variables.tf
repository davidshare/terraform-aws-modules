variable "bucket" {
  description = "The name of the bucket to configure CORS for"
  type        = string
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner (for cross-account scenarios)"
  type        = string
  default     = null

  validation {
    condition     = var.expected_bucket_owner == null || can(regex("^[0-9]{12}$", var.expected_bucket_owner))
    error_message = "Expected bucket owner must be a valid 12-digit AWS account ID."
  }
}

variable "cors_rules" {
  description = "List of CORS rules to apply to the bucket. You can configure up to 100 rules."
  type = list(object({
    id              = optional(string)
    allowed_headers = optional(list(string))
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.cors_rules :
      alltrue([
        for method in rule.allowed_methods :
        contains(["GET", "PUT", "HEAD", "POST", "DELETE"], method)
      ])
    ])
    error_message = "Allowed methods must be one or more of: GET, PUT, HEAD, POST, DELETE."
  }

  validation {
    condition = length(var.cors_rules) <= 100
    error_message = "You can configure up to 100 CORS rules maximum."
  }
}