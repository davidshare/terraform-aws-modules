output "arn" {
  description = "The ARN of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.arn
}

output "name" {
  description = "The name of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.name
}
