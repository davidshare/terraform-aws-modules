variable "name" {
  description = "Friendly name of the IAM role. Conflicts with `name_prefix`."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the IAM role name. Conflicts with `name`."
  type        = string
  default     = null
}

variable "path" {
  description = "Path to the IAM role."
  type        = string
  default     = "/"
}

variable "description" {
  description = "Description of the IAM role."
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "The assume role policy in JSON format."
  type        = string
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) for the IAM role."
  type        = number
  default     = 3600
}

variable "permissions_boundary" {
  description = "ARN of the policy used as the permissions boundary for the IAM role."
  type        = string
  default     = null
}

variable "force_detach_policies" {
  description = "Whether to force detaching policies before destroying the role."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Key-value mapping of tags for the IAM role."
  type        = map(string)
  default     = {}
}
