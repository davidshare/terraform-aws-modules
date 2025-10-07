variable "name" {
  description = "The name of the parameter"
  type        = string
}

variable "description" {
  description = "Description of the parameter"
  type        = string
  default     = null
}

variable "type" {
  description = "The type of the parameter. Valid types are String, StringList and SecureString"
  type        = string
}

variable "value" {
  description = "The value of the parameter"
  type        = string
}

variable "key_id" {
  description = "The KMS key id or arn for encrypting a SecureString"
  type        = string
  default     = null
}

variable "allowed_pattern" {
  description = "A regular expression used to validate the parameter value"
  type        = string
  default     = null
}

variable "tier" {
  description = "The tier of the parameter. Valid tiers are Standard, Advanced, and Intelligent-Tiering"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}