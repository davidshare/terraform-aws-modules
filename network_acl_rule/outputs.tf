output "network_acl_rule_id" {
  description = "The ID of the Network ACL rule."
  value       = aws_network_acl_rule.this.id
}
