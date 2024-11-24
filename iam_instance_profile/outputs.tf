output "arn" {
  description = "The ARN of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.arn
}

output "id" {
  description = "The ID of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.id
}

output "unique_id" {
  description = "The unique ID assigned by AWS to the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.unique_id
}
