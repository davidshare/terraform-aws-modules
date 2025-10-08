variable "bucket" {
  description = "The name of the bucket for the lifecycle configuration"
  type        = string
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null
}

variable "rules" {
  description = "List of lifecycle rules for the bucket"
  type = list(object({
    id      = string
    status  = string
    filter = optional(object({
      prefix                   = optional(string)
      object_size_greater_than = optional(number)
      object_size_less_than    = optional(number)
      tag = optional(object({
        key   = string
        value = string
      }))
      and = optional(object({
        prefix                   = optional(string)
        object_size_greater_than = optional(number)
        object_size_less_than    = optional(number)
        tags                     = optional(map(string))
      }))
    }))
    expiration = optional(object({
      date                         = optional(string)
      days                         = optional(number)
      expired_object_delete_marker = optional(bool)
    }))
    transitions = optional(list(object({
      date          = optional(string)
      days          = optional(number)
      storage_class = string
    })), [])
    noncurrent_version_expiration = optional(object({
      newer_noncurrent_versions = optional(number)
      noncurrent_days           = number
    }))
    noncurrent_version_transitions = optional(list(object({
      newer_noncurrent_versions = optional(number)
      noncurrent_days           = number
      storage_class             = string
    })), [])
    abort_incomplete_multipart_upload = optional(object({
      days_after_initiation = number
    }))
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.rules : contains(["Enabled", "Disabled"], rule.status)
    ])
    error_message = "Rule status must be either 'Enabled' or 'Disabled'."
  }

  validation {
    condition = alltrue([
      for rule in var.rules : can(regex("^[a-zA-Z0-9-_]{1,255}$", rule.id))
    ])
    error_message = "Rule ID must be alphanumeric and between 1-255 characters."
  }
}