output "security_group_rule_id" {
  description = "The ID of the security group egress rule."
  value       = aws_vpc_security_group_egress_rule.this.security_group_rule_id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the security group egress rule."
  value       = aws_vpc_security_group_egress_rule.this.arn
}
