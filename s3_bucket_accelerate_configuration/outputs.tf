output "id" {
  description = "The bucket name"
  value       = aws_s3_bucket_accelerate_configuration.this.bucket
}

output "status" {
  description = "The current transfer acceleration status"
  value       = aws_s3_bucket_accelerate_configuration.this.status
}