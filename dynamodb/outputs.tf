output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.this.arn
}

output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.this.id
}

output "table_stream_arn" {
  description = "The ARN of the Table Stream. Only available when stream_enabled = true"
  value       = var.stream_enabled ? aws_dynamodb_table.this.stream_arn : null
}