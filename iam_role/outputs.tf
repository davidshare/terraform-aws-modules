output "iam_role_id" {
  description = "The ID of the IAM role."
  value       = aws_iam_role.this.id
}

output "iam_role_arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "The name of the IAM role."
  value       = aws_iam_role.this.name
}

output "iam_role_unique_id" {
  description = "The unique ID of the IAM role."
  value       = aws_iam_role.this.unique_id
}
