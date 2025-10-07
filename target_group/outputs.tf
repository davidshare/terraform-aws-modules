output "arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.this.name
}