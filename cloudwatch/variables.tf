variable "log_group_name" {
  description = "The name of the log group"
  type        = string
}

variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "metric_transformation" {
  description = "A block defining collection of information needed to define how metric data should be extracted from logs"
  type = list(object({
    name      = string
    namespace = string
    value     = string
  }))
  default = []
}

variable "metric_filter_pattern" {
  description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events"
  type        = string
  default     = ""
}

variable "alarm_name" {
  description = "The descriptive name for the alarm"
  type        = string
  default     = null
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = number
  default     = 1
}

variable "metric_name" {
  description = "The name of the metric associated with the alarm"
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric"
  type        = string
  default     = null
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = number
  default     = 60
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric"
  type        = string
  default     = "Average"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared"
  type        = number
  default     = null
}

variable "alarm_description" {
  description = "The description for the alarm"
  type        = string
  default     = null
}

variable "alarm_actions" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}