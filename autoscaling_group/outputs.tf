output "autoscaling_group_id" {
  description = "The Auto Scaling Group id"
  value       = aws_autoscaling_group.this.id
}

output "autoscaling_group_name" {
  description = "The Auto Scaling Group name"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
  description = "The ARN for this Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}