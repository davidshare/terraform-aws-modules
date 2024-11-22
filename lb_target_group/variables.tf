variable "name" {
  description = "Name of the target group"
  type        = string
}

variable "port" {
  description = "Port on which targets receive traffic"
  type        = number
}

variable "protocol" {
  description = "Protocol used for routing traffic"
  type        = string
}

variable "target_type" {
  description = "Type of target (instance, ip, or lambda)"
  type        = string
  default     = "instance"
}

variable "vpc_id" {
  description = "VPC ID where the target group will be created"
  type        = string
}

variable "connection_termination" {
  description = "Whether to terminate connections at the end of deregistration timeout"
  type        = bool
  default     = false
}

variable "deregistration_delay" {
  description = "Deregistration delay in seconds"
  type        = number
  default     = 300
}

variable "lambda_multi_value_headers_enabled" {
  description = "Enable multi-value headers for Lambda targets"
  type        = bool
  default     = false
}

variable "load_balancing_algorithm_type" {
  description = "Algorithm used for load balancing"
  type        = string
  default     = "round_robin"
}

variable "load_balancing_anomaly_mitigation" {
  description = "Enable anomaly mitigation"
  type        = string
  default     = "off"
}

variable "load_balancing_cross_zone_enabled" {
  description = "Enable cross-zone load balancing"
  type        = string
  default     = "use_load_balancer_configuration"
}

variable "preserve_client_ip" {
  description = "Preserve client IP"
  type        = bool
  default     = false
}

variable "protocol_version" {
  description = "Protocol version (HTTP1, HTTP2, GRPC)"
  type        = string
  default     = "HTTP1"
}

variable "proxy_protocol_v2" {
  description = "Enable proxy protocol v2"
  type        = bool
  default     = false
}

variable "slow_start" {
  description = "Slow start duration in seconds"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags for the target group"
  type        = map(string)
  default     = {}
}

variable "ip_address_type" {
  description = "IP address type (ipv4 or ipv6)"
  type        = string
  default     = null
}

variable "health_check" {
  description = "Health check configuration"
  type = object({
    enabled             = bool
    healthy_threshold   = number
    interval            = number
    matcher             = string
    path                = string
    port                = string
    protocol            = string
    timeout             = number
    unhealthy_threshold = number
  })
  default = {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200-399"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }
}

variable "stickiness" {
  description = "Stickiness configuration"
  type = object({
    cookie_duration = number
    cookie_name     = string
    enabled         = bool
    type            = string
  })
  default = {
    cookie_duration = 86400
    cookie_name     = null
    enabled         = true
    type            = "lb_cookie"
  }
}

variable "target_failover" {
  description = "Target failover configuration"
  type = object({
    on_deregistration = string
    on_unhealthy      = string
  })
  default = {
    on_deregistration = "no_rebalance"
    on_unhealthy      = "no_rebalance"
  }
}

variable "target_health_state" {
  description = "Target health state configuration"
  type = object({
    enable_unhealthy_connection_termination = bool
  })
  default = {
    enable_unhealthy_connection_termination = false
  }
}

variable "target_group_health" {
  description = "Target group health configuration"
  type = object({
    dns_failover = object({
      minimum_healthy_targets_count      = number
      minimum_healthy_targets_percentage = string
    })
    unhealthy_state_routing = object({
      minimum_healthy_targets_count      = number
      minimum_healthy_targets_percentage = string
    })
  })
  default = {
    dns_failover = {
      minimum_healthy_targets_count      = 1
      minimum_healthy_targets_percentage = "off"
    }
    unhealthy_state_routing = {
      minimum_healthy_targets_count      = 1
      minimum_healthy_targets_percentage = "off"
    }
  }
}
