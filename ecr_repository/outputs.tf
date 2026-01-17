output "arn" {
  description = "ARN of the repository"
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "Repository URL"
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "Registry ID where the repository is created"
  value       = aws_ecr_repository.this.registry_id
}

output "tags_all" {
  description = "All tags assigned to the repository"
  value       = aws_ecr_repository.this.tags_all
}
