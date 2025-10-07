variable "name" {
  description = "The name of the SNS topic. Conflicts with name_prefix."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the topic."
  type        = string
  default     = null
}

variable "policy" {
  description = "The fully-formed AWS policy as JSON."
  type        = string
  default     = null
}

variable "delivery_policy" {
  description = "The SNS delivery policy as JSON."
  type        = string
  default     = null
}

variable "kms_master_key_id" {
  description = "The ARN of an AWS-managed or customer master key (CMK) for encrypting log data."
  type        = string
  default     = null
}

variable "signature_version" {
  description = "Signature version for notifications. Valid values: '1' (SHA1), '2' (SHA256)."
  type        = string
  default     = null
}

variable "tracing_config" {
  description = "Tracing mode for the SNS topic. Valid values: 'PassThrough', 'Active'."
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Boolean indicating if the topic is FIFO (First-In-First-Out)."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO topics."
  type        = bool
  default     = false
}

# Feedback Configuration Variables
variable "application_success_feedback_role_arn" {
  description = "The IAM role ARN for application success feedback."
  type        = string
  default     = null
}

variable "application_success_feedback_sample_rate" {
  description = "Percentage of successful application deliveries to sample."
  type        = number
  default     = null
}

variable "application_failure_feedback_role_arn" {
  description = "The IAM role ARN for application failure feedback."
  type        = string
  default     = null
}

variable "http_success_feedback_role_arn" {
  description = "The IAM role ARN for HTTP success feedback."
  type        = string
  default     = null
}

variable "http_success_feedback_sample_rate" {
  description = "Percentage of successful HTTP deliveries to sample."
  type        = number
  default     = null
}

variable "http_failure_feedback_role_arn" {
  description = "The IAM role ARN for HTTP failure feedback."
  type        = string
  default     = null
}

variable "lambda_success_feedback_role_arn" {
  description = "The IAM role ARN for Lambda success feedback."
  type        = string
  default     = null
}

variable "lambda_success_feedback_sample_rate" {
  description = "Percentage of successful Lambda deliveries to sample."
  type        = number
  default     = null
}

variable "lambda_failure_feedback_role_arn" {
  description = "The IAM role ARN for Lambda failure feedback."
  type        = string
  default     = null
}

variable "sqs_success_feedback_role_arn" {
  description = "The IAM role ARN for SQS success feedback."
  type        = string
  default     = null
}

variable "sqs_success_feedback_sample_rate" {
  description = "Percentage of successful SQS deliveries to sample."
  type        = number
  default     = null
}

variable "sqs_failure_feedback_role_arn" {
  description = "The IAM role ARN for SQS failure feedback."
  type        = string
  default     = null
}

variable "firehose_success_feedback_role_arn" {
  description = "The IAM role ARN for Firehose success feedback."
  type        = string
  default     = null
}

variable "firehose_success_feedback_sample_rate" {
  description = "Percentage of successful Firehose deliveries to sample."
  type        = number
  default     = null
}

variable "firehose_failure_feedback_role_arn" {
  description = "The IAM role ARN for Firehose failure feedback."
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = map(string)
  default     = {}
}
