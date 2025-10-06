output "id" {
  description = "The ID of the bucket policy (same as bucket name)"
  value       = aws_s3_bucket_policy.this.id
}

output "policy" {
  description = "The applied bucket policy"
  value       = aws_s3_bucket_policy.this.policy
}