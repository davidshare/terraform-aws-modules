output "arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.this.name
}
