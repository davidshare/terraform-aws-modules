output "key_id" {
  description = "The globally unique identifier for the key"
  value       = aws_kms_key.this.key_id
}

output "key_arn" {
  description = "The ARN of the key"
  value       = aws_kms_key.this.arn
}

output "alias_arn" {
  description = "The ARN of the key alias"
  value       = aws_kms_alias.this.arn
}