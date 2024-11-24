output "id" {
  description = "The ID of the subnet"
  value       = aws_subnet.this.id
}

output "arn" {
  description = "The ARN of the subnet"
  value       = aws_subnet.this.arn
}

output "ipv6_cidr_block_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = aws_subnet.this.ipv6_cidr_block_association_id
}

output "owner_id" {
  description = "The ID of the AWS account that owns the subnet"
  value       = aws_subnet.this.owner_id
}