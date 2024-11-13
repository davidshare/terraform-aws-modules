resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = var.security_group_id
  from_port         = var.from_port
  to_port           = var.to_port
  ip_protocol       = var.ip_protocol
  description       = try(var.description, null)

  cidr_ipv4                    = var.cidr_ipv4 != "" ? var.cidr_ipv4 : null
  cidr_ipv6                    = var.cidr_ipv6 != "" ? var.cidr_ipv6 : null
  prefix_list_id               = var.prefix_list_id != "" ? var.prefix_list_id : null
  referenced_security_group_id = var.referenced_security_group_id != "" ? var.referenced_security_group_id : null

  tags              = var.tags
}