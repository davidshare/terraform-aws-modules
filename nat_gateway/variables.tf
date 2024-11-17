variable "allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "The Subnet ID of the subnet in which to place the gateway"
  type        = string
}

variable "connectivity_type" {
  description = "Connectivity type for the gateway. Valid values are private and public"
  type        = string
  default     = "public"
}

variable "private_ip" {
  description = "The private IP address of the NAT Gateway"
  type        = string
  default     = null
}

variable "secondary_allocation_ids" {
  description = "The secondary EIP allocation IDs for the NAT Gateway"
  type        = list(string)
  default     = null
}

variable "secondary_private_ip_address_count" {
  description = "The number of secondary private IP addresses to assign to the NAT Gateway"
  type        = number
  default     = null
}

variable "secondary_private_ip_addresses" {
  description = "The secondary private IP addresses to assign to the NAT Gateway"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}