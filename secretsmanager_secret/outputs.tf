output "id" {
  description = "ID of the secret."
  value       = aws_secretsmanager_secret.this.id
}

output "arn" {
  description = "ARN of the secret."
  value       = aws_secretsmanager_secret.this.arn
}

output "replica" {
  description = "Attributes of replicas including status and last accessed date."
  value       = aws_secretsmanager_secret.this.replica
}

output "tags_all" {
  description = "Map of all tags assigned to the resource, including inherited provider default tags."
  value       = aws_secretsmanager_secret.this.tags_all
}

