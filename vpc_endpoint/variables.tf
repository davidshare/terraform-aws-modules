variable "vpc_id" {
  description = "(Required) The ID of the VPC in which to create the endpoint."
  type        = string
}

variable "service_name" {
  description = "(Optional) The service name for AWS services (e.g., com.amazonaws.us-west-2.s3). Mutually exclusive with resource_configuration_arn and service_network_arn."
  type        = string
  default     = null
}

variable "resource_configuration_arn" {
  description = "(Optional) ARN of a VPC Lattice Resource Configuration. Mutually exclusive with others."
  type        = string
  default     = null
}

variable "service_network_arn" {
  description = "(Optional) ARN of a VPC Lattice Service Network. Mutually exclusive with others."
  type        = string
  default     = null
}

variable "vpc_endpoint_type" {
  description = "(Optional) The type of endpoint: Gateway, Interface, GatewayLoadBalancer, Resource, or ServiceNetwork."
  type        = string
  default     = "Gateway"

  validation {
    condition     = contains(["Gateway", "Interface", "GatewayLoadBalancer", "Resource", "ServiceNetwork"], var.vpc_endpoint_type)
    error_message = "Valid values: Gateway, Interface, GatewayLoadBalancer, Resource, ServiceNetwork."
  }
}

variable "auto_accept" {
  description = "(Optional) Accept the VPC endpoint automatically (same account only)."
  type        = bool
  default     = null
}

variable "policy" {
  description = "(Optional) JSON policy document to attach to the endpoint."
  type        = string
  default     = null
}

variable "private_dns_enabled" {
  description = "(Optional) Whether to associate a private hosted zone (Interface endpoints only)."
  type        = bool
  default     = null
}

variable "ip_address_type" {
  description = "(Optional) IP address type: ipv4, dualstack, ipv6."
  type        = string
  default     = null
}

variable "service_region" {
  description = "(Optional) Region of the endpoint service (for cross-region Interface endpoints)."
  type        = string
  default     = null
}

variable "route_table_ids" {
  description = "(Optional) List of route table IDs to associate (Gateway endpoints only)."
  type        = set(string)
  default     = null
}

variable "subnet_ids" {
  description = "(Optional) List of subnet IDs for Interface/GatewayLoadBalancer/Resource/ServiceNetwork endpoints."
  type        = set(string)
  default     = null
}

variable "security_group_ids" {
  description = "(Optional) List of security group IDs for Interface endpoints."
  type        = set(string)
  default     = null
}

variable "dns_options" {
  description = "(Optional) DNS options for Interface endpoints."
  type = object({
    dns_record_ip_type                             = optional(string)
    private_dns_only_for_inbound_resolver_endpoint = optional(bool, false)
  })
  default = null
}

variable "subnet_configuration" {
  description = "(Optional) Per-subnet custom IP assignments for Interface endpoints."
  type = list(object({
    subnet_id = string
    ipv4      = optional(string)
    ipv6      = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "(Optional) Additional tags to apply to the endpoint."
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "Timeout for create operations."
  type        = string
  default     = "10m"
}

variable "update_timeout" {
  description = "Timeout for update operations."
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Timeout for delete operations."
  type        = string
  default     = "10m"
}