output "name" {
  description = "The name of the parameter"
  value       = aws_ssm_parameter.this.name
}

output "arn" {
  description = "The ARN of the parameter"
  value       = aws_ssm_parameter.this.arn
}

output "version" {
  description = "The version of the parameter"
  value       = aws_ssm_parameter.this.version
}