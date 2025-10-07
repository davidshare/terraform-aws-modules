output "id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "arn" {
  description = "The ARN of the Internet Gateway"
  value       = aws_internet_gateway.this.arn
}

output "owner_id" {
  description = "The ID of the AWS account that owns the Internet Gateway"
  value       = aws_internet_gateway.this.owner_id
}