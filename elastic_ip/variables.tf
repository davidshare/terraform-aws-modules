variable "domain" {
  description = "Indicates if this EIP is for use in VPC (use 'vpc')"
  type        = string
  default     = "vpc"
}

variable "instance_id" {
  description = "EC2 instance ID (optional)"
  type        = string
  default     = null
}

variable "network_interface" {
  description = "Network interface ID to associate with (optional)"
  type        = string
  default     = null
}

variable "associate_with_private_ip" {
  description = "User-specified primary or secondary private IP address to associate with the Elastic IP address"
  type        = string
  default     = null
}

variable "customer_owned_ipv4_pool" {
  description = "ID of a customer-owned address pool (optional)"
  type        = string
  default     = null
}

variable "ipam_pool_id" {
  description = "The ID of an IPAM pool to allocate the IP from (optional)"
  type        = string
  default     = null
}

variable "network_border_group" {
  description = "Location from which the IP address is advertised (optional)"
  type        = string
  default     = null
}

variable "public_ipv4_pool" {
  description = "EC2 IPv4 address pool identifier (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to the EIP"
  type        = map(string)
  default     = {}
}
