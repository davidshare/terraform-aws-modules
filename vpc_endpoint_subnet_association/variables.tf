variable "vpc_endpoint_id" {
  description = "(Required) The ID of the VPC endpoint to associate with the subnet."
  type        = string

  validation {
    condition     = can(regex("^vpce-[0-9a-f]{8,17}$", var.vpc_endpoint_id))
    error_message = "vpc_endpoint_id must be a valid VPC endpoint ID (e.g., vpce-1234567890abcdef0)."
  }
}

variable "subnet_id" {
  description = "(Required) The ID of the subnet to associate with the VPC endpoint."
  type        = string

  validation {
    condition     = can(regex("^subnet-[0-9a-f]{8,17}$", var.subnet_id))
    error_message = "subnet_id must be a valid subnet ID (e.g., subnet-1234567890abcdef0)."
  }
}

variable "create_timeout" {
  description = "Timeout for association creation."
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Timeout for association deletion."
  type        = string
  default     = "10m"
}