variable "vpc_endpoint_id" {
  description = "(Required) Identifier of the VPC Endpoint with which the EC2 Route Table will be associated."
  type        = string
}

variable "route_table_id" {
  description = "(Required) Identifier of the EC2 Route Table to be associated with the VPC Endpoint."
  type        = string
}