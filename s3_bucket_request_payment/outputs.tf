output "id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided"
  value       = aws_s3_bucket_request_payment_configuration.this.id
}