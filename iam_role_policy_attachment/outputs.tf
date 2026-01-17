output "role" {
  description = "The name of the IAM role the policy is attached to."
  value       = aws_iam_role_policy_attachment.this.role
}

output "policy_arn" {
  description = "The ARN of the IAM managed policy attached to the role."
  value       = aws_iam_role_policy_attachment.this.policy_arn
}
