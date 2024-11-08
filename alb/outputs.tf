output "lb_id" {
  description = "The ID and ARN of the load balancer we created"
  value       = aws_lb.this.id
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = aws_lb.this.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "lb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = aws_lb.this.zone_id
}