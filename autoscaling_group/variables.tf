variable "name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "launch_template" {
  description = "Launch template specification to use to launch instances"
  type = object({
    id      = string
    version = string
  })
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs to launch resources in"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs to associate with the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "Type of health check to perform"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = 300
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated"
  type        = list(string)
  default     = ["Default"]
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type = list(object({
    key                 = string
    value               = string
    propagate_at_launch = bool
  }))
  default = []
}