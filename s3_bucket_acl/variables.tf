variable "bucket" {
  description = "The name of the bucket to apply the ACL to"
  type        = string
}

variable "acl" {
  description = "The canned ACL to apply to the bucket. Conflicts with access_control_policy. Valid values: private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, bucket-owner-full-control, log-delivery-write"
  type        = string
  default     = null

  validation {
    condition     = var.acl == null || contains(["private", "public-read", "public-read-write", "aws-exec-read", "authenticated-read", "bucket-owner-read", "bucket-owner-full-control", "log-delivery-write"], var.acl)
    error_message = "ACL must be one of the valid values: private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, bucket-owner-full-control, log-delivery-write."
  }
}

variable "access_control_policy" {
  description = "Configuration block for custom ACL permissions using grants. Conflicts with acl parameter."
  type = object({
    grants = list(object({
      permission = string
      grantee = object({
        type          = string
        email_address = optional(string)
        id            = optional(string)
        uri           = optional(string)
      })
    }))
    owner = object({
      id           = string
      display_name = optional(string)
    })
  })
  default = null

  validation {
    condition = var.access_control_policy == null ? true : alltrue([
      for grant in var.access_control_policy.grants : contains(["FULL_CONTROL", "WRITE", "WRITE_ACP", "READ", "READ_ACP"], grant.permission)
    ])
    error_message = "Grant permissions must be one of: FULL_CONTROL, WRITE, WRITE_ACP, READ, READ_ACP."
  }

  validation {
    condition = var.access_control_policy == null ? true : alltrue([
      for grant in var.access_control_policy.grants : contains(["CanonicalUser", "AmazonCustomerByEmail", "Group"], grant.grantee.type)
    ])
    error_message = "Grantee type must be one of: CanonicalUser, AmazonCustomerByEmail, Group."
  }
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null

  validation {
    condition     = var.expected_bucket_owner == null || can(regex("^[0-9]{12}$", var.expected_bucket_owner))
    error_message = "Expected bucket owner must be a valid 12-digit AWS account ID."
  }
}