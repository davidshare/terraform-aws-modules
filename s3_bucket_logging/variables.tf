variable "bucket" {
  description = "The name of the source bucket to enable logging for"
  type        = string
}

variable "target_bucket" {
  description = "The name of the target bucket where logs will be delivered"
  type        = string
}

variable "target_prefix" {
  description = "The prefix for all log object keys"
  type        = string
  default     = ""
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null
}

variable "target_grants" {
  description = "List of target grants for fine-grained permissions control"
  type = list(object({
    permission = string
    grantee = object({
      type          = string
      email_address = optional(string)
      id            = optional(string)
      uri           = optional(string)
    })
  }))
  default = []

  validation {
    condition = alltrue([
      for grant in var.target_grants : contains(["FULL_CONTROL", "READ", "WRITE"], grant.permission)
    ])
    error_message = "Target grant permissions must be one of: FULL_CONTROL, READ, WRITE."
  }

  validation {
    condition = alltrue([
      for grant in var.target_grants : contains(["CanonicalUser", "AmazonCustomerByEmail", "Group"], grant.grantee.type)
    ])
    error_message = "Grantee type must be one of: CanonicalUser, AmazonCustomerByEmail, Group."
  }
}

variable "target_object_key_format" {
  description = "Configuration for the target object key format"
  type = object({
    partitioned_prefix = optional(object({
      partition_date_source = string
    }))
    simple_prefix = optional(object({}))
  })
  default = null

  validation {
    condition = var.target_object_key_format == null ? true : (
      (try(var.target_object_key_format.partitioned_prefix, null) != null) !=
      (try(var.target_object_key_format.simple_prefix, null) != null)
    )
    error_message = "Either partitioned_prefix or simple_prefix must be specified, but not both."
  }
}

variable "attach_log_delivery_policy" {
  description = "Whether to attach a bucket policy for log delivery permissions (recommended)"
  type        = bool
  default     = true
}

variable "source_bucket_arn" {
  description = "The ARN of the source bucket for policy conditions"
  type        = string
  default     = null
}

variable "target_bucket_arn" {
  description = "The ARN of the target bucket for policy conditions"
  type        = string
  default     = null
}

variable "source_account_id" {
  description = "The source account ID for policy conditions"
  type        = string
  default     = null
}