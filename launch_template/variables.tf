variable "name" {
  description = "The name of the launch template"
  type        = string
}

variable "description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
}

variable "image_id" {
  description = "The AMI from which to launch the instance"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with"
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = list(object({
    device_name  = string
    no_device    = optional(string)
    virtual_name = optional(string)
    ebs = optional(object({
      delete_on_termination = optional(bool)
      encrypted             = optional(bool)
      iops                  = optional(number)
      kms_key_id            = optional(string)
      snapshot_id           = optional(string)
      volume_size           = optional(number)
      volume_type           = optional(string)
    }))
  }))
  default = []
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type = list(object({
    associate_public_ip_address = optional(bool)
    delete_on_termination       = optional(bool)
    description                 = optional(string)
    device_index                = number
    ipv6_addresses              = optional(list(string))
    ipv6_address_count          = optional(number)
    network_interface_id        = optional(string)
    private_ip_address          = optional(string)
    subnet_id                   = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to the launch template"
  type        = map(string)
  default     = {}
}