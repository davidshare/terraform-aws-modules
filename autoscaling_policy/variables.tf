variable "name" {
  description = "Name of the policy."
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the autoscaling group."
  type        = string
}

variable "adjustment_type" {
  description = "Whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."
  type        = string
  default     = null
}

variable "policy_type" {
  description = "Policy type, either 'SimpleScaling', 'StepScaling', 'TargetTrackingScaling', or 'PredictiveScaling'."
  type        = string
  default     = "SimpleScaling"
}

variable "estimated_instance_warmup" {
  description = "Estimated time, in seconds, until a newly launched instance will contribute CloudWatch metrics."
  type        = number
  default     = null
}

variable "enabled" {
  description = "Whether the scaling policy is enabled or disabled."
  type        = bool
  default     = true
}

variable "predictive_scaling_configuration" {
  description = "Predictive scaling policy configuration to use with Amazon EC2 Auto Scaling."
  type = object({
    max_capacity_breach_behavior = optional(string)
    max_capacity_buffer          = optional(number)
    mode                         = optional(string)
    scheduling_buffer_time       = optional(number)
    metric_specification = object({
      target_value = number
      customized_capacity_metric_specification = optional(object({
        metric_data_queries = list(object({
          id         = string
          expression = optional(string)
          label      = optional(string)
          metric_stat = optional(object({
            metric = object({
              metric_name = string
              namespace   = string
              dimensions  = optional(map(string))
            })
            stat = string
            unit = optional(string)
          }))
          return_data = optional(bool)
        }))
      }))
      customized_load_metric_specification = optional(object({
        metric_data_queries = list(object({
          id         = string
          expression = optional(string)
          label      = optional(string)
          metric_stat = optional(object({
            metric = object({
              metric_name = string
              namespace   = string
              dimensions  = optional(map(string))
            })
            stat = string
            unit = optional(string)
          }))
          return_data = optional(bool)
        }))
      }))
      customized_scaling_metric_specification = optional(object({
        metric_data_queries = list(object({
          id         = string
          expression = optional(string)
          label      = optional(string)
          metric_stat = optional(object({
            metric = object({
              metric_name = string
              namespace   = string
              dimensions  = optional(map(string))
            })
            stat = string
            unit = optional(string)
          }))
          return_data = optional(bool)
        }))
      }))
      predefined_load_metric_specification = optional(object({
        predefined_metric_type = string
        resource_label         = string
      }))
      predefined_metric_pair_specification = optional(object({
        predefined_metric_type = string
        resource_label         = string
      }))
      predefined_scaling_metric_specification = optional(object({
        predefined_metric_type = string
        resource_label         = string
      }))
    })
  })
  default = null
}

variable "min_adjustment_magnitude" {
  description = "Minimum value to scale by when adjustment_type is set to PercentChangeInCapacity."
  type        = number
  default     = null
}

variable "cooldown" {
  description = "Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  type        = number
  default     = null
}

variable "scaling_adjustment" {
  description = "Number of instances by which to scale. A positive increment adds to the current capacity and a negative value removes from the current capacity."
  type        = number
  default     = null
}

variable "metric_aggregation_type" {
  description = "Aggregation type for the policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'."
  type        = string
  default     = null
}

variable "step_adjustment" {
  description = "Set of adjustments that manage group scaling."
  type = list(object({
    scaling_adjustment          = number
    metric_interval_lower_bound = optional(number)
    metric_interval_upper_bound = optional(number)
  }))
  default = []
}

variable "target_tracking_configuration" {
  description = "Target tracking policy configuration."
  type = object({
    target_value     = number
    disable_scale_in = optional(bool)
    predefined_metric_specification = optional(object({
      predefined_metric_type = string
      resource_label         = optional(string)
    }))
    customized_metric_specification = optional(object({
      metric_name = string
      namespace   = string
      statistic   = string
      unit        = optional(string)
      metric_dimension = optional(list(object({
        name  = string
        value = string
      })))
    }))
  })
  default = null
}

