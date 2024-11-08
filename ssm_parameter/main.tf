resource "aws_ssm_parameter" "this" {
  name        = var.name
  description = var.description
  type        = var.type
  value       = var.value
  key_id      = var.key_id
  allowed_pattern = var.allowed_pattern
  tier        = var.tier

  tags = var.tags
}