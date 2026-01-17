output "arn" {
  description = "The ARN assigned by AWS to this IAM policy."
  value       = aws_iam_policy.this.arn
}

output "id" {
  description = "The ARN of the IAM policy."
  value       = aws_iam_policy.this.id
}

output "policy_id" {
  description = "The stable policy ID assigned by AWS."
  value       = aws_iam_policy.this.policy_id
}

output "attachment_count" {
  description = "Number of IAM entities (users, groups, roles) the policy is attached to."
  value       = aws_iam_policy.this.attachment_count
}

output "policy" {
  description = "The JSON policy document."
  value       = aws_iam_policy.this.policy
}

output "tags_all" {
  description = "All tags assigned to the policy, including provider default_tags."
  value       = aws_iam_policy.this.tags_all
}
