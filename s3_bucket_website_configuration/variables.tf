variable "bucket" {
  description = "Name of the bucket"
  type        = string
}

variable "expected_bucket_owner" {
  description = "Account ID of the expected bucket owner"
  type        = string
  default     = null
}

variable "index_document" {
  description = "Configuration for the index document"
  type = object({
    suffix = string
  })
  default = null
}

variable "error_document" {
  description = "Configuration for the error document"
  type = object({
    key = string
  })
  default = null
}

variable "redirect_all_requests_to" {
  description = "Configuration for redirecting all requests"
  type = object({
    host_name = string
    protocol  = optional(string)
  })
  default = null
}

variable "routing_rule" {
  description = "List of individual routing rules"
  type = list(object({
    condition = optional(object({
      http_error_code_returned_equals = optional(string)
      key_prefix_equals               = optional(string)
    }))
    redirect = object({
      host_name               = optional(string)
      http_redirect_code      = optional(string)
      protocol                = optional(string)
      replace_key_prefix_with = optional(string)
      replace_key_with        = optional(string)
    })
  }))
  default = []
}

variable "routing_rules" {
  description = "JSON string containing routing rules"
  type        = string
  default     = null
}