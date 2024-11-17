variable "route_table_id" {
  description = "The ID of the route table to associate the route with."
  type        = string
}

variable "destination_cidr_block" {
  description = "The destination CIDR block for the route."
  type        = string
  default     = null
}

variable "destination_ipv6_cidr_block" {
  description = "The destination IPv6 CIDR block for the route."
  type        = string
  default     = null
}

variable "destination_prefix_list_id" {
  description = "The ID of a managed prefix list for the route destination."
  type        = string
  default     = null
}

variable "carrier_gateway_id" {
  description = "Identifier of a carrier gateway."
  type        = string
  default     = null
}

variable "core_network_arn" {
  description = "The Amazon Resource Name (ARN) of a core network."
  type        = string
  default     = null
}

variable "egress_only_gateway_id" {
  description = "Identifier of a VPC Egress Only Internet Gateway."
  type        = string
  default     = null
}

variable "gateway_id" {
  description = "Identifier of a VPC internet gateway or a virtual private gateway."
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = "Identifier of a VPC NAT gateway."
  type        = string
  default     = null
}

variable "local_gateway_id" {
  description = "Identifier of an Outpost local gateway."
  type        = string
  default     = null
}

variable "network_interface_id" {
  description = "Identifier of an EC2 network interface."
  type        = string
  default     = null
}

variable "transit_gateway_id" {
  description = "Identifier of an EC2 Transit Gateway."
  type        = string
  default     = null
}

variable "vpc_endpoint_id" {
  description = "Identifier of a VPC Endpoint."
  type        = string
  default     = null
}

variable "vpc_peering_connection_id" {
  description = "Identifier of a VPC peering connection."
  type        = string
  default     = null
}
