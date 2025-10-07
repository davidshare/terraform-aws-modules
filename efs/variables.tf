variable "creation_token" {
  description = "A unique name used as reference when creating the EFS"
  type        = string
}

variable "performance_mode" {
  description = "The file system performance mode"
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "Throughput mode for the file system"
  type        = string
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "The throughput, measured in MiB/s, that you want to provision for the file system"
  type        = number
  default     = null
}

variable "encrypted" {
  description = "If true, the disk will be encrypted"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Subnet IDs for mount targets"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to allow access to the EFS"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}