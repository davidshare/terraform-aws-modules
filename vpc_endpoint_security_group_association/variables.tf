variable "vpc_endpoint_id" {
  description = "(Required) The ID of the VPC endpoint with which the security group will be associated."
  type        = string
}

variable "security_group_id" {
  description = "(Required) The ID of the security group to be associated with the VPC endpoint."
  type        = string
}

variable "replace_default_association" {
  description = <<-EOT
    (Optional) Whether this association should replace the association with the VPC's default security group 
    that is created when no security groups are specified during VPC endpoint creation. 
    At most 1 association per-VPC endpoint should be configured with replace_default_association = true. 
    false should be used when importing resources.
  EOT
  type        = bool
  default     = false
}