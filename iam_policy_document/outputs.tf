output "policy_json" {
  description = "The generated IAM policy document in JSON format."
  value       = data.aws_iam_policy_document.example.json
}

output "minified_policy_json" {
  description = "The generated IAM policy document in minified JSON format."
  value       = data.aws_iam_policy_document.example.minified_json
}
