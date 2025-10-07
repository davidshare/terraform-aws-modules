resource "aws_security_group_rule" "this" {
  security_group_id = var.security_group_id
  type              = var.type
  protocol          = var.protocol
  from_port         = var.from_port
  to_port           = var.to_port
  description       = var.description

  # Conditionally set `cidr_blocks` if provided and no other source is specified
  dynamic "cidr_blocks" {
    for_each = var.cidr_blocks != [] && var.source_security_group_id == null && !var.self ? [var.cidr_blocks] : []
    content {
      cidr_blocks = cidr_blocks.value
    }
  }

  # Conditionally set `ipv6_cidr_blocks` if provided and no other source is specified
  dynamic "ipv6_cidr_blocks" {
    for_each = var.ipv6_cidr_blocks != [] && var.source_security_group_id == null && !var.self ? [var.ipv6_cidr_blocks] : []
    content {
      ipv6_cidr_blocks = ipv6_cidr_blocks.value
    }
  }

  # Conditionally set `prefix_list_ids` if provided and no other source is specified
  dynamic "prefix_list_ids" {
    for_each = var.prefix_list_ids != [] && var.source_security_group_id == null && !var.self ? [var.prefix_list_ids] : []
    content {
      prefix_list_ids = prefix_list_ids.value
    }
  }

  # Conditionally set `source_security_group_id` if provided and no other source is specified
  dynamic "source_security_group_id" {
    for_each = var.source_security_group_id != null && var.cidr_blocks == [] && var.ipv6_cidr_blocks == [] && !var.self ? [var.source_security_group_id] : []
    content {
      source_security_group_id = source_security_group_id.value
    }
  }

  # Conditionally set `self` if specified
  dynamic "self" {
    for_each = var.self ? [true] : []
    content {
      self = true
    }
  }
}
