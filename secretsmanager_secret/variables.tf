variable "description" {
  description = "Description of the secret."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "ARN or Id of the KMS key used to encrypt the secret."
  type        = string
  default     = null
}

variable "name" {
  description = "Friendly name of the new secret. Conflicts with name_prefix."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "policy" {
  description = "Valid JSON document representing a resource policy."
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days AWS Secrets Manager waits before deleting the secret. Default is 30."
  type        = number
  default     = 30
}

variable "force_overwrite_replica_secret" {
  description = "Whether to overwrite a secret with the same name in the destination Region."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Key-value map of user-defined tags attached to the secret."
  type        = map(string)
  default     = {}
}

variable "replica" {
  description = <<EOT
Configuration block to support secret replication. Each block must have:
- region (Required): Region for replicating the secret.
- kms_key_id (Optional): ARN, Key ID, or Alias of the KMS key in the destination region.
EOT
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  default = []
}
