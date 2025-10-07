resource "aws_lb_target_group" "this" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  connection_termination             = var.connection_termination
  deregistration_delay               = var.deregistration_delay
  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled
  load_balancing_algorithm_type      = var.load_balancing_algorithm_type
  load_balancing_anomaly_mitigation  = var.load_balancing_anomaly_mitigation
  load_balancing_cross_zone_enabled  = var.load_balancing_cross_zone_enabled
  preserve_client_ip                 = var.preserve_client_ip != null ? var.preserve_client_ip : null
  protocol_version                   = var.protocol_version
  proxy_protocol_v2                  = var.proxy_protocol_v2
  slow_start                         = var.slow_start
  tags                               = var.tags
  ip_address_type                    = var.ip_address_type

  health_check {
    enabled             = var.health_check.enabled
    healthy_threshold   = var.health_check.healthy_threshold
    interval            = var.health_check.interval
    matcher             = var.health_check.matcher
    path                = var.health_check.path
    port                = var.health_check.port
    protocol            = var.health_check.protocol
    timeout             = var.health_check.timeout
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  stickiness {
    cookie_duration = var.stickiness.cookie_duration
    cookie_name     = var.stickiness.cookie_name
    enabled         = var.stickiness.enabled
    type            = var.stickiness.type
  }

  target_failover {
    on_deregistration = var.target_failover.on_deregistration
    on_unhealthy      = var.target_failover.on_unhealthy
  }

  target_health_state {
    enable_unhealthy_connection_termination = var.target_health_state.enable_unhealthy_connection_termination
  }

  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = var.target_group_health.dns_failover.minimum_healthy_targets_count
      minimum_healthy_targets_percentage = var.target_group_health.dns_failover.minimum_healthy_targets_percentage
    }
    unhealthy_state_routing {
      minimum_healthy_targets_count      = var.target_group_health.unhealthy_state_routing.minimum_healthy_targets_count
      minimum_healthy_targets_percentage = var.target_group_health.unhealthy_state_routing.minimum_healthy_targets_percentage
    }
  }

  lifecycle {
    ignore_changes = [ target_failover, target_health_state ]
  }
}
