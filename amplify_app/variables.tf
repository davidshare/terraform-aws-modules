variable "name" {
  description = "The name for the Amplify app"
  type        = string
}

variable "repository" {
  description = "The repository for the Amplify app"
  type        = string
}

variable "oauth_token" {
  description = "The OAuth token for a third-party source control system for the Amplify app"
  type        = string
  default     = null
}

variable "access_token" {
  description = "The personal access token for a third-party source control system for the Amplify app"
  type        = string
  default     = null
}

variable "description" {
  description = "The description for the Amplify app"
  type        = string
  default     = null
}

variable "enable_branch_auto_build" {
  description = "Enables auto-building of branches for the Amplify app"
  type        = bool
  default     = false
}

variable "enable_branch_auto_deletion" {
  description = "Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository"
  type        = bool
  default     = false
}

variable "environment_variables" {
  description = "The environment variables for the Amplify app"
  type        = map(string)
  default     = {}
}

variable "iam_service_role_arn" {
  description = "The AWS Identity and Access Management (IAM) service role for the Amplify app"
  type        = string
  default     = null
}

variable "platform" {
  description = "The platform or framework for the Amplify app"
  type        = string
  default     = "WEB"
}

variable "build_spec" {
  description = "The build specification (build spec) for the Amplify app"
  type        = string
  default     = null
}

variable "custom_rules" {
  description = "The custom rewrite and redirect rules for the Amplify app"
  type = list(object({
    source = string
    status = string
    target = string
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}