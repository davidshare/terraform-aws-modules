variable "bucket" {
  description = "The name of the bucket."
  type        = string
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred, ObjectWriter."
  type        = string
  validation {
    condition     = contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "Valid values are: BucketOwnerEnforced, BucketOwnerPreferred, ObjectWriter."
  }
}