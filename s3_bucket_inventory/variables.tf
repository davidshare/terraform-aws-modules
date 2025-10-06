variable "bucket" {
  type = string
}

variable "name" {
  type = string
}

variable "enabled" {
  type    = bool
  default = true
}

variable "included_object_versions" {
  type        = string
  description = "All or Current"
  validation {
    condition     = contains(["All", "Current"], var.included_object_versions)
    error_message = "Must be 'All' or 'Current'"
  }
}

variable "optional_fields" {
  type    = list(string)
  default = []
}

variable "destination" {
  type = object({
    bucket = object({
      format     = string
      bucket_arn = string
      prefix     = optional(string)
      account_id = optional(string)
      encryption = optional(object({
        sse_kms = optional(object({ key_id = string }))
        sse_s3  = optional(bool)
      }))
    })
  })
}

variable "schedule" {
  type = object({
    frequency = string # Daily or Weekly
  })
  default = null
}