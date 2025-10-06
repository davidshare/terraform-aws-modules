variable "bucket" {
  description = "The name of the S3 bucket to attach the policy to"
  type        = string
}

variable "policy" {
  description = "The JSON-formatted bucket policy"
  type        = string
}