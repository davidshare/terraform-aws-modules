variable "name" {
  description = "Name of the target group"
  type        = string
}

variable "port" {
  description = "Port on which targets receive traffic"
  type        = number
}

variable "protocol" {
  description = "Protocol to use for routing traffic to the targets"
  type        = string
}

variable "vpc_id" {
  description = "Identifier of the VPC in which to create the target group"
  type        = string
}

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group"
  type        = string
  default     = "instance"
}

variable "deregistration_delay" {
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type        = number
  default     = 300
}

variable "slow_start" {
  description = "Amount time for targets to warm up before the load balancer sends them a full share of requests"
  type        = number
  default     = 0
}

variable "health_check" {
  description = "Health Check configuration block"
  type = object({
    enabled             = optional(bool, true)
    interval            = optional(number)
    path                = optional(string)
    port                = optional(string)
    healthy_threshold   = optional(number)
    unhealthy_threshold = optional(number)
    timeout             = optional(number)
    protocol            = optional(string)
    matcher             = optional(string)
  })
  default = {}
}

variable "stickiness" {
  description = "Stickiness configuration block"
  type = object({
    type            = string
    cookie_duration = optional(number)
    enabled         = optional(bool)
  })
  default = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}