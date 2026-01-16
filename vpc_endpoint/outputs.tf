output "id" {
  description = "The ID of the VPC endpoint."
  value       = aws_vpc_endpoint.this.id
}

output "arn" {
  description = "The ARN of the VPC endpoint."
  value       = aws_vpc_endpoint.this.arn
}

output "state" {
  description = "The state of the VPC endpoint."
  value       = aws_vpc_endpoint.this.state
}

output "owner_id" {
  description = "The ID of the AWS account that owns the VPC endpoint."
  value       = aws_vpc_endpoint.this.owner_id
}

output "prefix_list_id" {
  description = "Prefix list ID (Gateway endpoints only)."
  value       = aws_vpc_endpoint.this.prefix_list_id
}

output "cidr_blocks" {
  description = "List of CIDR blocks for the service (Gateway endpoints)."
  value       = aws_vpc_endpoint.this.cidr_blocks
}

output "dns_entry" {
  description = "DNS entries for the endpoint (Interface endpoints)."
  value       = aws_vpc_endpoint.this.dns_entry
}

output "network_interface_ids" {
  description = "Network interface IDs (Interface endpoints)."
  value       = aws_vpc_endpoint.this.network_interface_ids
}

output "tags_all" {
  description = "All tags applied to the resource."
  value       = aws_vpc_endpoint.this.tags_all
}