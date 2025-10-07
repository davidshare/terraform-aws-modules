variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling group to associate with the load balancer."
  type        = string
}

variable "elb" {
  description = "The name of the Classic Load Balancer to attach to the Auto Scaling group (optional)."
  type        = string
  default     = null
}

variable "lb_target_group_arn" {
  description = "ARN of the load balancer target group to attach to the Auto Scaling group (optional)."
  type        = string
  default     = null
}

