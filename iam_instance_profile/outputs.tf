output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.arn
}

output "instance_profile_id" {
  description = "The ID of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.id
}

output "instance_profile_unique_id" {
  description = "The unique ID assigned by AWS to the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.unique_id
}
