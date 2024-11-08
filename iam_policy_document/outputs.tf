output "json" {
  description = "The JSON formatted IAM policy"
  value       = data.aws_iam_policy_document.this.json
}