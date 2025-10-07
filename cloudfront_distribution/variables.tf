variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "comment" {
  description = "Any comments you want to include about the distribution"
  type        = string
  default     = null
}

variable "default_root_object" {
  description = "The object that you want CloudFront to return when an end user requests the root URL"
  type        = string
  default     = null
}

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "The price class for this distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "origin" {
  description = "One or more origins for this distribution"
  type        = any
}

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = any
}

variable "ordered_cache_behavior" {
  description = "An ordered list of cache behaviors resource for this distribution"
  type        = any
  default     = []
}

variable "custom_error_response" {
  description = "One or more custom error response elements"
  type        = any
  default     = []
}

variable "restrictions" {
  description = "The restriction configuration for this distribution"
  type        = any
  default     = {}
}

variable "viewer_certificate" {
  description = "The SSL configuration for this distribution"
  type        = any
}

variable "web_acl_id" {
  description = "If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}