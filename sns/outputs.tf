output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "sns_topic_id" {
  description = "The ID of the SNS topic"
  value       = aws_sns_topic.this.id
}