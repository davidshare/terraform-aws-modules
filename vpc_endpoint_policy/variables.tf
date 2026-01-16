variable "vpc_endpoint_id" {
  description = "(Required) The ID of the VPC Endpoint to attach the policy to."
  type        = string
}

variable "policy" {
  description = <<-EOT
    (Optional) The policy document as a JSON string.
    If null or omitted, AWS applies the default full-access policy.
    See: https://docs.aws.amazon.com/vpc/latest/privatelink/vpc-endpoints-access.html
  EOT
  type        = string
  default     = null

  validation {
    condition = (
      var.policy == null ||
      can(jsondecode(var.policy))
    )
    error_message = "The 'policy' variable must be valid JSON if provided."
  }
}

variable "endpoint_name" {
  description = "(Optional) Friendly name for the endpoint (used in error messages or tagging context)."
  type        = string
  default     = null
}

variable "enable_strict_validation" {
  description = "(Optional) Enable strict validation of policy structure (Version and Statement presence)."
  type        = bool
  default     = true
}