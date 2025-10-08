variable "bucket" {
  description = "Name of the bucket for which to configure transfer acceleration"
  type        = string
}

variable "status" {
  description = "Transfer acceleration state of the bucket. Valid values: `Enabled` or `Suspended`"
  type        = string
  validation {
    condition     = contains(["Enabled", "Suspended"], var.status)
    error_message = "Status must be either 'Enabled' or 'Suspended'."
  }
}

variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = null
  validation {
    condition     = var.expected_bucket_owner == null || can(regex("^[0-9]{12}$", var.expected_bucket_owner))
    error_message = "The expected_bucket_owner must be a valid 12-digit AWS account ID."
  }
}