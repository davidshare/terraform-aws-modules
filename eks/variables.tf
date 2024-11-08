variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf"
  type        = string
}

variable "vpc_config" {
  description = "Configuration block for the VPC associated with your cluster"
  type = object({
    endpoint_private_access = optional(bool, false)
    endpoint_public_access  = optional(bool, true)
    public_access_cidrs     = optional(list(string), ["0.0.0.0/0"])
    security_group_ids      = optional(list(string), [])
    subnet_ids              = list(string)
  })
}

variable "kubernetes_network_config" {
  description = "Configuration block with kubernetes network configuration"
  type = object({
    service_ipv4_cidr = optional(string)
    ip_family         = optional(string, "ipv4")
  })
  default = {}
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version"
  type        = string
  default     = null
}

variable "enabled_cluster_log_types" {
  description = "A list of the desired control plane logging to enable"
  type        = list(string)
  default     = []
}

variable "encryption_config" {
  description = "Configuration block with encryption configuration for the cluster"
  type = list(object({
    provider = object({
      key_arn = string
    })
    resources = list(string)
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "A map of timeouts for create/update/delete operations"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = {}
}