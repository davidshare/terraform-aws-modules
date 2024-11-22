variable "alarm_name" {
  description = "The descriptive name for the alarm."
  type        = string
}

variable "comparison_operator" {
  description = "The arithmetic operation for comparing Statistic and Threshold."
  type        = string
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the threshold."
  type        = number
}

variable "metric_name" {
  description = "The name of the associated metric."
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace of the associated metric."
  type        = string
  default     = null
}

variable "period" {
  description = "The period in seconds over which the statistic is applied."
  type        = number
  default     = null
}

variable "statistic" {
  description = "The statistic to apply to the associated metric."
  type        = string
  default     = null
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
  type        = number
  default     = null
}

variable "threshold_metric_id" {
  description = "ID of the ANOMALY_DETECTION_BAND function for anomaly detection alarms."
  type        = string
  default     = null
}

variable "alarm_description" {
  description = "The description for the alarm."
  type        = string
  default     = null
}

variable "insufficient_data_actions" {
  description = "Actions to execute when the alarm transitions into an INSUFFICIENT_DATA state."
  type        = list(string)
  default     = []
}

variable "actions_enabled" {
  description = "Whether actions should be executed during alarm state changes."
  type        = bool
  default     = true
}

variable "alarm_actions" {
  description = "Actions to execute when the alarm transitions into an ALARM state."
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "Actions to execute when the alarm transitions into an OK state."
  type        = list(string)
  default     = []
}

variable "datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger the alarm."
  type        = number
  default     = null
}

variable "dimensions" {
  description = "The dimensions for the alarm's associated metric."
  type        = map(string)
  default     = {}
}

variable "unit" {
  description = "The unit for the alarm's associated metric."
  type        = string
  default     = null
}

variable "extended_statistic" {
  description = "Percentile statistic for the metric associated with the alarm."
  type        = string
  default     = null
}

variable "treat_missing_data" {
  description = "How to handle missing data points."
  type        = string
  default     = "missing"
}

variable "evaluate_low_sample_count_percentiles" {
  description = "How the alarm should handle low sample counts."
  type        = string
  default     = null
}

variable "metric_query" {
  description = "List of metric queries for alarms based on expressions."
  type = list(object({
    id          = string
    expression  = string
    label       = string
    return_data = bool
    metric = object({
      metric_name = string
      namespace   = string
      period      = number
      stat        = string
      unit        = string
      dimensions  = map(string)
    })
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
