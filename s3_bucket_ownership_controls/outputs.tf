output "bucket" {
  value = aws_s3_bucket_ownership_controls.this.bucket
}

output "object_ownership" {
  value = aws_s3_bucket_ownership_controls.this.rule[0].object_ownership
}