variable "availability_zone" {
  description = "The AZ where the EBS volume will exist"
  type        = string
}

variable "size" {
  description = "The size of the drive in GiBs"
  type        = number
}

variable "type" {
  description = "The type of EBS volume"
  type        = string
  default     = "gp2"
}

variable "iops" {
  description = "The amount of IOPS to provision for the disk"
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

variable "snapshot_id" {
  description = "A snapshot to base the EBS volume off of"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}