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

output "qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = aws_lambda_function.this.qualified_arn
}

output "signing_job_arn" {
  description = "ARN of the signing job"
  value       = aws_lambda_function.this.signing_job_arn
}

output "signing_profile_version_arn" {
  description = "ARN of the signing profile version"
  value       = aws_lambda_function.this.signing_profile_version_arn
}

output "last_modified" {
  description = "The date the Lambda Function was last modified"
  value       = aws_lambda_function.this.last_modified
}