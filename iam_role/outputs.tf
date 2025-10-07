output "id" {
  description = "The ID of the IAM role."
  value       = aws_iam_role.this.id
}

output "arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "name" {
  description = "The name of the IAM role."
  value       = aws_iam_role.this.name
}

output "unique_id" {
  description = "The unique ID of the IAM role."
  value       = aws_iam_role.this.unique_id
}
