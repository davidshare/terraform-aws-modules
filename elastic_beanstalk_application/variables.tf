variable "name" {
  description = "The name of the application"
  type        = string
}

variable "description" {
  description = "Short description of the application"
  type        = string
  default     = null
}

variable "appversion_lifecycle" {
  description = "Application version lifecycle configuration"
  type = object({
    service_role          = string
    max_count             = number
    delete_source_from_s3 = bool
    max_age_in_days       = number
  })
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}