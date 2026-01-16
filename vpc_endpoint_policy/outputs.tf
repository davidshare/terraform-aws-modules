output "id" {
  description = "The ID of the VPC endpoint (same as vpc_endpoint_id)."
  value       = aws_vpc_endpoint_policy.this.id
}

output "vpc_endpoint_id" {
  description = "The VPC Endpoint ID the policy is attached to."
  value       = aws_vpc_endpoint_policy.this.vpc_endpoint_id
}

output "policy" {
  description = "The attached policy document (as provided)."
  value       = aws_vpc_endpoint_policy.this.policy
  sensitive   = true
}

output "effective_policy" {
  description = <<-EOT
    The effective policy: either the user-provided policy or indication of default full access.
  EOT
  value       = var.policy != null ? var.policy : "(AWS default full access policy)"
  sensitive   = true
}