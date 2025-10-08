variable "bucket" {
  description = "The name of the bucket to configure server-side encryption for"
  type        = string
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

variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use. Valid values: AES256, aws:kms, aws:kms:dsse"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms", "aws:kms:dsse"], var.sse_algorithm)
    error_message = "SSE algorithm must be one of: AES256, aws:kms, aws:kms:dsse."
  }
}

variable "kms_master_key_id" {
  description = "AWS KMS master key ID used for SSE-KMS encryption. Required when sse_algorithm is aws:kms or aws:kms:dsse"
  type        = string
  default     = null
}

variable "bucket_key_enabled" {
  description = "Whether to use Amazon S3 Bucket Keys for SSE-KMS to reduce AWS KMS request costs"
  type        = bool
  default     = false
}