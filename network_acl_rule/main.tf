resource "aws_network_acl_rule" "this" {
  network_acl_id  = var.network_acl_id
  rule_number     = var.rule_number
  protocol        = var.protocol
  rule_action     = var.rule_action
  cidr_block      = var.cidr_block
  egress          = var.egress
  from_port       = var.from_port
  to_port         = var.to_port
  ipv6_cidr_block = var.ipv6_cidr_block
  icmp_type       = var.icmp_type
  icmp_code       = var.icmp_code
}