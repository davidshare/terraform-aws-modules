variable "name" {
  description = "The name of the log group. If omitted, a random unique name is generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = <<EOT
Specifies the number of days you want to retain log events in the specified log group. 
Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 
2192, 2557, 2922, 3288, 3653, and 0. If you select 0, events are always retained.
EOT
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data."
  type        = string
  default     = null
}

variable "skip_destroy" {
  description = "Set to true to prevent the log group and logs from being deleted at destroy time."
  type        = bool
  default     = false
}

variable "log_group_class" {
  description = "Specifies the log class of the log group. Possible values: STANDARD or INFREQUENT_ACCESS."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the log group."
  type        = map(string)
  default     = {}
}
