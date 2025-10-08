variable "bucket" {
  description = "Name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  type        = string
  default     = null
  validation {
    condition     = var.bucket == null ? true : can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket))
    error_message = "Bucket name must be DNS-compliant: lowercase alphanumeric characters, hyphens, and periods, starting and ending with alphanumeric, 3-63 characters."
  }
}

variable "bucket_prefix" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Boolean that indicates all objects should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "object_lock_enabled" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}