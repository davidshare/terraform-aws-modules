variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "ipv4_ipam_pool_id" {
  description = "The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR"
  type        = string
  default     = null
}

variable "ipv4_netmask_length" {
  description = "The netmask length of the IPv4 CIDR you want to allocate to this VPC"
  type        = number
  default     = null
}

variable "ipv6_cidr_block" {
  description = "IPv6 CIDR block to request from an IPAM Pool"
  type        = string
  default     = null
}

variable "ipv6_ipam_pool_id" {
  description = "IPAM Pool ID for a IPv6 pool"
  type        = string
  default     = null
}

variable "ipv6_netmask_length" {
  description = "Netmask length to request from IPAM Pool"
  type        = number
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  description = "By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC"
  type        = string
  default     = null
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_network_address_usage_metrics" {
  description = "Indicates whether Network Address Usage metrics are enabled for your VPC"
  type        = bool
  default     = false
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}