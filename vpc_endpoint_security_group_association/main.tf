resource "aws_vpc_endpoint_security_group_association" "this" {
  vpc_endpoint_id             = var.vpc_endpoint_id
  security_group_id           = var.security_group_id
  replace_default_association = var.replace_default_association
}