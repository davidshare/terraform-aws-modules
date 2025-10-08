variable "bucket" {
  description = "The name of the bucket to configure request payment for"
  type        = string
}

variable "payer" {
  description = "Specifies who pays for the download and request fees. Valid values: BucketOwner, Requester"
  type        = string

  validation {
    condition     = contains(["BucketOwner", "Requester"], var.payer)
    error_message = "Payer must be either 'BucketOwner' or 'Requester'."
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