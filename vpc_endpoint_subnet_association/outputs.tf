output "id" {
  description = "The unique ID of the VPC endpoint subnet association (format: vpce-xxx/subnet-yyy)."
  value       = aws_vpc_endpoint_subnet_association.this.id
}

output "vpc_endpoint_id" {
  description = "The ID of the associated VPC endpoint."
  value       = aws_vpc_endpoint_subnet_association.this.vpc_endpoint_id
}

output "subnet_id" {
  description = "The ID of the associated subnet."
  value       = aws_vpc_endpoint_subnet_association.this.subnet_id
}