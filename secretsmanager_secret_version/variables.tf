variable "secret_id" {
  description = "Specifies the secret to which you want to add a new version. Accepts ARN or name of the secret."
  type        = string
}

variable "secret_string" {
  description = <<EOT
Specifies text data that you want to encrypt and store in this version of the secret. 
This is required if secret_binary is not set.
EOT
  type        = string
  default     = null
}

variable "secret_binary" {
  description = <<EOT
Specifies binary data that you want to encrypt and store in this version of the secret. 
This is required if secret_string is not set. Must be base64-encoded.
EOT
  type        = string
  default     = null
}

variable "version_stages" {
  description = <<EOT
Specifies a list of staging labels attached to this version of the secret. 
Defaults to AWS automatically moving the AWSCURRENT label to the new version.
EOT
  type        = list(string)
  default     = []
}
