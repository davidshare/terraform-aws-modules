variable "name" {
  description = "The name of the launch template"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "default_version" {
  description = "Default Version of the launch template"
  type        = number
  default     = null
}

variable "update_default_version" {
  description = "Whether to update Default Version each update"
  type        = bool
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "image_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = null
}

variable "kernel_id" {
  description = "The kernel ID"
  type        = string
  default     = null
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = null
}

variable "ram_disk_id" {
  description = "The ID of the RAM disk"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "user_data" {
  description = "The base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = any
  default     = []
}

variable "capacity_reservation_specification" {
  description = "Targeting for EC2 capacity reservations"
  type        = any
  default     = null
}

variable "cpu_options" {
  description = "The CPU options for the instance"
  type        = map(string)
  default     = null
}

variable "credit_specification" {
  description = "Customize the credit specification of the instance"
  type        = map(string)
  default     = null
}

variable "disable_api_stop" {
  description = "If true, enables EC2 Instance Stop Protection"
  type        = bool
  default     = null
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = null
}

variable "elastic_gpu_specifications" {
  description = "The elastic GPU to attach to the instance"
  type        = map(string)
  default     = null
}

variable "elastic_inference_accelerator" {
  description = "Configuration block containing an Elastic Inference Accelerator to attach to the instance"
  type        = map(string)
  default     = null
}

variable "enclave_options" {
  description = "Enable Nitro Enclaves on launched instances"
  type        = map(bool)
  default     = null
}

variable "hibernation_options" {
  description = "The hibernation options for the instance"
  type        = map(bool)
  default     = null
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with"
  type        = map(string)
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  type        = string
  default     = null
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instance"
  type        = any
  default     = null
}

variable "license_specification" {
  description = "A list of license specifications to associate with"
  type        = map(string)
  default     = null
}

variable "maintenance_options" {
  description = "The maintenance options for the instance"
  type        = map(string)
  default     = null
}

variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type        = map(string)
  default     = null
}

variable "monitoring" {
  description = "The monitoring option for the instance"
  type        = map(bool)
  default     = null
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(any)
  default     = []
}

variable "placement" {
  description = "The placement of the instance"
  type        = map(string)
  default     = null
}

variable "private_dns_name_options" {
  description = "The options for the instance hostname"
  type        = map(string)
  default     = null
}

variable "tag_specifications" {
  description = "The tags to apply to the resources during launch"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the launch template"
  type        = map(string)
  default     = {}
}