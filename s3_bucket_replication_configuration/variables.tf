variable "bucket" {
  type = string
}

variable "role" {
  type = string
}

variable "rules" {
  type = list(object({
    id          = optional(string)
    status      = string # Enabled or Disabled
    priority    = optional(number)
    filter = optional(object({
      prefix = optional(string)
      tags   = optional(map(string))
    }))
    delete_marker_replication_status = optional(string)
    destination = object({
      bucket        = string
      account_id    = optional(string)
      storage_class = optional(string)
      replica_kms_key_id = optional(string)
      access_control_translation = optional(object({
        owner = string # Must be "Destination"
      }))
    })
    sse_kms_encrypted_objects_status = optional(string)
  }))
  default = []
}