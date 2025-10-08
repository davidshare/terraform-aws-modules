variable "bucket" {
  description = "The name of the bucket to configure Object Lock for"
  type        = string
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null
}

variable "object_lock_enabled" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled. Defaults to Enabled"
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled"], var.object_lock_enabled)
    error_message = "Object Lock enabled must be 'Enabled' if specified."
  }
}

variable "rule" {
  description = "Configuration block for specifying the Object Lock rule"
  type = object({
    default_retention = object({
      days  = optional(number)
      mode  = string
      years = optional(number)
    })
  })
  default = null

  validation {
    condition = var.rule == null ? true : (
      (var.rule.default_retention.days != null) != (var.rule.default_retention.years != null)
    )
    error_message = "Either days or years must be specified in default_retention, but not both."
  }

  validation {
    condition = var.rule == null ? true : contains(["COMPLIANCE", "GOVERNANCE"], var.rule.default_retention.mode)
    error_message = "Retention mode must be either 'COMPLIANCE' or 'GOVERNANCE'."
  }
}