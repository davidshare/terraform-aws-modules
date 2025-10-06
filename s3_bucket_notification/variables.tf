variable "bucket" {
  type = string
}

variable "lambda_functions" {
  type = list(object({
    id                  = optional(string)
    lambda_function_arn = string
    events              = list(string)
    filter_prefix       = optional(string)
    filter_suffix       = optional(string)
  }))
  default = []
}

variable "topics" {
  type = list(object({
    id         = optional(string)
    topic_arn  = string
    events     = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = []
}

variable "queues" {
  type = list(object({
    id         = optional(string)
    queue_arn  = string
    events     = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = []
}