output "secret_version_id" {
  description = "The unique identifier of the secret version."
  value       = aws_secretsmanager_secret_version.this.id
}

output "secret_version_stages" {
  description = "The list of staging labels currently attached to this version of the secret."
  value       = aws_secretsmanager_secret_version.this.version_stages
}

output "secret_string" {
  description = "The secret value stored in this version."
  value       = aws_secretsmanager_secret_version.this.secret_string
}