variable "security_group_id" {
  description = "The ID of the security group to attach to."
  type        = string
}

variable "type" {
  description = "Type of the rule (ingress or egress)."
  type        = string
  validation {
    condition     = contains(["ingress", "egress"], var.type)
    error_message = "Type must be either 'ingress' or 'egress'."
  }
}

variable "from_port" {
  description = "The starting port of the rule."
  type        = number
  default     = null
}

variable "to_port" {
  description = "The ending port of the rule."
  type        = number
  default     = null
}

variable "protocol" {
  description = "The protocol of the rule. Use 'tcp', 'udp', 'icmp', 'icmpv6', 'all' or the protocol number."
  type        = string
}

variable "cidr_blocks" {
  description = "A list of CIDR blocks to allow or deny."
  type        = list(string)
  default     = []
}

variable "ipv6_cidr_blocks" {
  description = "A list of IPv6 CIDR blocks to allow or deny."
  type        = list(string)
  default     = []
}

variable "prefix_list_ids" {
  description = "A list of Prefix List IDs."
  type        = list(string)
  default     = []
}

variable "self" {
  description = "Whether to allow traffic from/to the same security group."
  type        = bool
  default     = false
}

variable "source_security_group_id" {
  description = "Security group ID to allow access to/from, depending on the type."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the rule."
  type        = string
  default     = ""
}