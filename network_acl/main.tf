resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  tags       = var.tags

  # Optional: Add rules using aws_network_acl_rule resources
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      rule_no         = ingress.value.rule_number
      protocol        = ingress.value.protocol
      cidr_block      = ingress.value.cidr_block
      action          = ingress.value.rule_action
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      ipv6_cidr_block = ingress.value.ipv6_cidr_block
      icmp_type       = ingress.value.icmp_type
      icmp_code       = ingress.value.icmp_code
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      rule_no         = egress.value.rule_number
      protocol        = egress.value.protocol
      cidr_block      = egress.value.cidr_block
      action          = egress.value.rule_action
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      ipv6_cidr_block = egress.value.ipv6_cidr_block
      icmp_type       = egress.value.icmp_type
      icmp_code       = egress.value.icmp_code
    }
  }
}
