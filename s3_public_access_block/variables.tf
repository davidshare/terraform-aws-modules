variable "bucket" {
  description = "The name of the S3 bucket to apply public access block settings to."
  type        = string
}

variable "block_public_acls" {
  description = "Whether to block new public ACLs and prevent existing public ACLs from granting public access."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether to block bucket policies that grant public access."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs on objects in this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public access to only AWS service principals and authorized users."
  type        = bool
  default     = true
}