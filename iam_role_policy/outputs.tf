output "policy_id" {
  description = "The ID of the IAM role policy, in the form of role_name:role_policy_name."
  value       = aws_iam_role_policy.this.id
}

output "policy_name" {
  description = "The name of the IAM role policy."
  value       = aws_iam_role_policy.this.name
}

output "policy_document" {
  description = "The policy document attached to the role."
  value       = aws_iam_role_policy.this.policy
}

output "associated_role" {
  description = "The name of the role associated with the policy."
  value       = aws_iam_role_policy.this.role
}
