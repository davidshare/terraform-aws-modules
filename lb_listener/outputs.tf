output "arn" {
  description = "ARN of the created load balancer listener."
  value       = aws_lb_listener.this.arn
}

output "id" {
  description = "ID of the created load balancer listener."
  value       = aws_lb_listener.this.id
}
