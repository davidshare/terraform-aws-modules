resource "aws_lb" "this" {
  name                                                         = var.name
  name_prefix                                                  = var.name_prefix
  internal                                                     = var.internal
  load_balancer_type                                           = var.load_balancer_type
  security_groups                                              = var.security_groups
  subnets                                                      = var.subnets
  ip_address_type                                              = var.ip_address_type
  customer_owned_ipv4_pool                                     = var.customer_owned_ipv4_pool
  enable_deletion_protection                                   = var.enable_deletion_protection
  enable_http2                                                 = var.enable_http2
  enable_tls_version_and_cipher_suite_headers                  = var.enable_tls_version_and_cipher_suite_headers
  enable_xff_client_port                                       = var.enable_xff_client_port
  enable_waf_fail_open                                         = var.enable_waf_fail_open
  enable_cross_zone_load_balancing                             = var.enable_cross_zone_load_balancing
  enable_zonal_shift                                           = var.enable_zonal_shift
  enforce_security_group_inbound_rules_on_private_link_traffic = var.enforce_security_group_inbound_rules_on_private_link_traffic
  desync_mitigation_mode                                       = var.desync_mitigation_mode
  dns_record_client_routing_policy                             = var.dns_record_client_routing_policy
  drop_invalid_header_fields                                   = var.drop_invalid_header_fields
  idle_timeout                                                 = var.idle_timeout
  preserve_host_header                                         = var.preserve_host_header
  xff_header_processing_mode                                   = var.xff_header_processing_mode
  tags                                                         = var.tags

  dynamic "access_logs" {
    for_each = var.access_logs_enabled ? [1] : []
    content {
      bucket  = var.access_logs.bucket
      prefix  = var.access_logs.prefix
      enabled = var.access_logs.enabled
    }
  }

  dynamic "connection_logs" {
    for_each = var.connection_logs_enabled ? [1] : []
    content {
      bucket  = var.connection_logs.bucket
      prefix  = var.connection_logs.prefix
      enabled = var.connection_logs.enabled
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_mappings
    content {
      subnet_id            = subnet_mapping.value.subnet_id
      allocation_id        = subnet_mapping.value.allocation_id
      ipv6_address         = subnet_mapping.value.ipv6_address
      private_ipv4_address = subnet_mapping.value.private_ipv4_address
    }
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}
