output "arn" {
  description = "ARN assigned by AWS to the scaling policy."
  value       = aws_autoscaling_policy.this.arn
}

output "name" {
  description = "Scaling policy's name."
  value       = aws_autoscaling_policy.this.name
}

output "autoscaling_group_name" {
  description = "The scaling policy's assigned autoscaling group."
  value       = aws_autoscaling_policy.this.autoscaling_group_name
}

output "adjustment_type" {
  description = "Scaling policy's adjustment type."
  value       = aws_autoscaling_policy.this.adjustment_type
}

output "policy_type" {
  description = "Scaling policy's type."
  value       = aws_autoscaling_policy.this.policy_type
}
