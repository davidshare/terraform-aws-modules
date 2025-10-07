variable "topic_arn" {
  description = "The ARN of the SNS topic to subscribe to."
  type        = string
}

variable "protocol" {
  description = <<EOT
Protocol to use for the subscription. Valid values:
application, firehose, lambda, sms, sqs, email, email-json, http, https.
EOT
  type        = string
}

variable "endpoint" {
  description = "The endpoint to send data to. The value depends on the protocol."
  type        = string
}

variable "subscription_role_arn" {
  description = "The ARN of the IAM role to publish to Kinesis Data Firehose delivery stream. Required if protocol is firehose."
  type        = string
  default     = null
}

variable "confirmation_timeout_in_minutes" {
  description = "The number of minutes to wait for subscription confirmation before failure."
  type        = number
  default     = 1
}

variable "delivery_policy" {
  description = "JSON string with the delivery policy for HTTP/S subscriptions."
  type        = string
  default     = null
}

variable "endpoint_auto_confirms" {
  description = "Whether the endpoint is capable of auto-confirming subscriptions. Default is false."
  type        = bool
  default     = false
}

variable "filter_policy" {
  description = "JSON string with the filter policy for the subscription."
  type        = string
  default     = null
}

variable "filter_policy_scope" {
  description = "Whether the filter_policy applies to MessageAttributes (default) or MessageBody."
  type        = string
  default     = "MessageAttributes"
}

variable "raw_message_delivery" {
  description = "Whether to enable raw message delivery. Default is false."
  type        = bool
  default     = false
}

variable "redrive_policy" {
  description = "JSON string with the redrive policy for the subscription."
  type        = string
  default     = null
}

variable "replay_policy" {
  description = "JSON string with the archived message replay policy for the subscription."
  type        = string
  default     = null
}