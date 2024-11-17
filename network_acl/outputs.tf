output "network_acl_id" {
  description = "The ID of the Network ACL."
  value       = aws_network_acl.this.id
}

output "network_acl_associations" {
  description = "The list of subnet associations with the Network ACL."
  value       = aws_network_acl.this.subnet_ids
}
