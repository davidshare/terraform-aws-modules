variable "name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "region" {
  description = "Region where this resource will be managed"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the ECS cluster"
  type        = map(string)
  default     = {}
}

variable "settings" {
  description = "Cluster settings (e.g. containerInsights)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "service_connect_defaults" {
  description = "Default Service Connect namespace"
  type = object({
    namespace = string
  })
  default = null
}

variable "configuration" {
  description = "Cluster configuration block"
  type = object({

    execute_command_configuration = optional(object({
      kms_key_id = optional(string)
      logging    = optional(string)

      log_configuration = optional(object({
        cloud_watch_encryption_enabled = optional(bool)
        cloud_watch_log_group_name     = optional(string)
        s3_bucket_name                 = optional(string)
        s3_bucket_encryption_enabled   = optional(bool)
        s3_key_prefix                  = optional(string)
      }))
    }))

    managed_storage_configuration = optional(object({
      fargate_ephemeral_storage_kms_key_id = optional(string)
      kms_key_id                           = optional(string)
    }))
  })
  default = null
}

