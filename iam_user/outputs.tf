output "iam_user_name" {
  description = "The user's name"
  value       = aws_iam_user.this.name
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.this.arn
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = aws_iam_user.this.unique_id
}