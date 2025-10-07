resource "aws_security_group" "this" {
  name                   = var.name
  description            = var.description
  name_prefix            = var.name_prefix
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = var.tags
}