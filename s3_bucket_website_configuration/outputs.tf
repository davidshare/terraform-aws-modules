output "id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided"
  value       = aws_s3_bucket_website_configuration.this.id
}

output "website_domain" {
  description = "Domain of the website endpoint"
  value       = aws_s3_bucket_website_configuration.this.website_domain
}

output "website_endpoint" {
  description = "Website endpoint"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}