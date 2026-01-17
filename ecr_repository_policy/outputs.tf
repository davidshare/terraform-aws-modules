output "repository" {
  description = "The name of the ECR repository."
  value       = var.repository
}

output "policy_json" {
  description = "The JSON representation of the ECR repository policy."
  value       = data.aws_iam_policy_document.policy_doc.json
}

output "registry_id" {
  description = "The registry ID where the repository resides."
  value       = aws_ecr_repository_policy.this.registry_id
}
