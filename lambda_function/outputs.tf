output "arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = aws_lambda_function.this.invoke_arn
}

output "name" {
  description = "The name of the Lambda Function"
  value       = aws_lambda_function.this.function_name
}

output "version" {
  description = "Latest published version of Lambda Function"
  value       = aws_lambda_function.this.version
}