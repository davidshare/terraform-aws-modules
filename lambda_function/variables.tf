variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function you are uploading"
  type        = string
}

variable "role" {
  description = "IAM role attached to the Lambda Function"
  type        = string
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem"
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "The S3 bucket location containing the function's deployment package"
  type        = string
  default     = null
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package"
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "The object version containing the function's deployment package"
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Used to trigger updates when file contents change"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of what your Lambda Function does"
  type        = string
  default     = null
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function"
  type        = list(string)
  default     = null
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 3
}

variable "publish" {
  description = "Whether to publish creation/change as a new Lambda Function Version"
  type        = bool
  default     = false
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda function"
  type        = number
  default     = null
}

variable "architectures" {
  description = "Instruction set architecture for your Lambda function"
  type        = list(string)
  default     = ["x86_64"]
}

variable "package_type" {
  description = "The type of deployment package. Valid values are `Zip` and `Image`"
  type        = string
  default     = "Zip"
}

variable "image_uri" {
  description = "The ECR image URI containing the function's deployment package"
  type        = string
  default     = null
}

variable "image_config" {
  description = "Configuration for the container image"
  type = object({
    entry_point           = list(string)
    command               = list(string)
    working_directory     = string
  })
  default = null
}

variable "code_signing_config_arn" {
  description = "ARN of the code signing configuration"
  type        = string
  default     = null
}

variable "dead_letter_config" {
  description = "Configuration for the dead letter queue"
  type = object({
    target_arn = string
  })
  default = null
}

variable "tracing_config" {
  description = "Configuration for tracing"
  type = object({
    mode = string
  })
  default = null
}

variable "vpc_config" {
  description = "Provide this to allow your function to access your VPC"
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "environment" {
  description = "The Lambda environment's configuration settings"
  type = object({
    variables = map(string)
  })
  default = null
}

variable "file_system_config" {
  description = "Configuration for the file system"
  type = object({
    arn              = string
    local_mount_path = string
  })
  default = null
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key used to encrypt your function's environment variables"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the Lambda function"
  type        = map(string)
  default     = {}
}