output "log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.arn
}

output "metric_filter_id" {
  description = "The ID of the CloudWatch log metric filter"
  value       = length(aws_cloudwatch_log_metric_filter.this) > 0 ? aws_cloudwatch_log_metric_filter.this[0].id : null
}

output "alarm_arn" {
  description = "The ARN of the CloudWatch metric alarm"
  value       = length(aws_cloudwatch_metric_alarm.this) > 0 ? aws_cloudwatch_metric_alarm.this[0].arn : null
}