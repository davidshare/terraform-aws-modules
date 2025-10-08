variable "bucket" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null
}

variable "mfa" {
  description = "Concatenation of the authentication device's serial number, a space, and the value displayed on your authentication device. Required if mfa_delete is enabled"
  type        = string
  default     = null
}

variable "versioning_configuration" {
  description = "Configuration block for versioning parameters"
  type = object({
    status     = string
    mfa_delete = string
  })
  default = {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }

  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning_configuration.status)
    error_message = "Status must be one of: Enabled, Suspended, or Disabled."
  }

  validation {
    condition     = contains(["Enabled", "Disabled"], var.versioning_configuration.mfa_delete)
    error_message = "MFA delete must be either Enabled or Disabled."
  }
}