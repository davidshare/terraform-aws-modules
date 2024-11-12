# main.tf

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id            = var.security_group_id
  cidr_ipv4                    = var.cidr_ipv4
  cidr_ipv6                    = var.cidr_ipv6
  description                  = var.description
  from_port                    = var.from_port
  to_port                      = var.to_port
  ip_protocol                  = var.ip_protocol
  prefix_list_id               = var.prefix_list_id
  referenced_security_group_id = var.referenced_security_group_id
  tags                         = var.tags
}
