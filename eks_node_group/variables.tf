variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "node_role_arn" {
  description = "Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group"
  type        = string
}

variable "subnet_ids" {
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group"
  type        = list(string)
}

variable "scaling_config" {
  description = "Configuration block with scaling settings"
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
  default     = null
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group"
  type        = string
  default     = null
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = null
}

variable "force_update_version" {
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue"
  type        = bool
  default     = null
}

variable "instance_types" {
  description = "List of instance types associated with the EKS Node Group"
  type        = list(string)
  default     = null
}

variable "labels" {
  description = "Key-value map of Kubernetes labels"
  type        = map(string)
  default     = null
}

variable "launch_template" {
  description = "Configuration block with Launch Template settings"
  type = object({
    name    = optional(string)
    version = optional(string)
    id      = optional(string)
  })
  default = null
}

variable "remote_access" {
  description = "Configuration block with remote access settings"
  type = object({
    ec2_ssh_key               = optional(string)
    source_security_group_ids = optional(list(string))
  })
  default = null
}

variable "taint" {
  description = "The Kubernetes taints to be applied to the nodes in the node group"
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = null
}

variable "update_config" {
  description = "Configuration block with update settings"
  type = object({
    max_unavailable            = optional(number)
    max_unavailable_percentage = optional(number)
  })
  default = null
}

variable "version" {
  description = "Kubernetes version"
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value map of resource tags"
  type        = map(string)
  default     = {}
}