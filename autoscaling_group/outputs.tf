output "id" {
  description = "The Auto Scaling Group id"
  value       = aws_autoscaling_group.this.id
}

output "name" {
  description = "The Auto Scaling Group name"
  value       = aws_autoscaling_group.this.name
}

output "arn" {
  description = "The ARN for this Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}