variable "name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "region" {
  description = "Region where the repository will be created"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the repository"
  type        = map(string)
  default     = {}
}

variable "force_delete" {
  description = "Delete repository even if it contains images"
  type        = bool
  default     = false
}

variable "image_tag_mutability" {
  description = "Tag mutability setting for the repository"
  type        = string
  default     = "MUTABLE"
}

variable "image_tag_mutability_exclusion_filters" {
  description = "List of exclusion filters for tag mutability"
  type = list(object({
    filter      = string
    filter_type = string
  }))
  default = []
}

variable "image_scanning_configuration" {
  description = "Configuration for image scanning"
  type = object({
    scan_on_push = bool
  })
  default = {
    scan_on_push = false
  }
}

variable "encryption_configuration" {
  description = "Encryption settings for the repository"
  type = object({
    encryption_type = string
    kms_key        = string
  })
  default = {
    encryption_type = "AES256"
    kms_key        = null
  }
}
