
output "id" {
  description = "The ID of the created security group ingress rule."
  value       = aws_vpc_security_group_ingress_rule.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the created security group ingress rule."
  value       = aws_vpc_security_group_ingress_rule.this.arn
}
