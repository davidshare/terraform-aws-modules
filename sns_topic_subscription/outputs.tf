output "subscription_arn" {
  description = "The ARN of the SNS subscription."
  value       = aws_sns_topic_subscription.this.arn
}

output "owner_id" {
  description = "The AWS account ID of the subscription owner."
  value       = aws_sns_topic_subscription.this.owner_id
}

output "pending_confirmation" {
  description = "Whether the subscription is pending confirmation."
  value       = aws_sns_topic_subscription.this.pending_confirmation
}

output "confirmation_was_authenticated" {
  description = "Whether the subscription confirmation request was authenticated."
  value       = aws_sns_topic_subscription.this.confirmation_was_authenticated
}