output "id" {
  description = "The ID of the instance"
  value       = aws_instance.this.id
}

output "arn" {
  description = "The ARN of the instance"
  value       = aws_instance.this.arn
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value       = aws_instance.this.private_ip
}

output "public_dns" {
  description = "The public DNS name assigned to the instance"
  value       = aws_instance.this.public_dns
}

output "private_dns" {
  description = "The private DNS name assigned to the instance"
  value       = aws_instance.this.private_dns
}