output "url" {
  description = "The URL of the repository"
  value       = aws_ecr_repository.this.repository_url
}

output "arn" {
  description = "The ARN of the repository"
  value       = aws_ecr_repository.this.arn
}

output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.this.registry_id
}