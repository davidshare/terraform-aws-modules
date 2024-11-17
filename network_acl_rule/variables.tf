variable "network_acl_id" {
  description = "The ID of the network ACL to associate the rule with."
  type        = string
}

variable "rule_number" {
  description = "The rule number for the network ACL rule. Must be between 1 and 32766."
  type        = number
}

variable "protocol" {
  description = "The protocol number (e.g., '6' for TCP, '17' for UDP, '-1' for all protocols)."
  type        = string
}

variable "rule_action" {
  description = "The action to take (allow or deny) for this rule."
  type        = string
  validation {
    condition     = contains(["allow", "deny"], var.rule_action)
    error_message = "The rule_action variable must be either 'allow' or 'deny'."
  }
}

variable "cidr_block" {
  description = "The IPv4 CIDR block to match. Either 'cidr_block' or 'ipv6_cidr_block' must be specified."
  type        = string
  default     = null
}

variable "egress" {
  description = "Whether this rule applies to egress traffic (true) or ingress traffic (false)."
  type        = bool
}

variable "from_port" {
  description = "The starting port range for the network ACL rule. Required if the protocol is TCP or UDP."
  type        = number
  default     = null
}

variable "to_port" {
  description = "The ending port range for the network ACL rule. Required if the protocol is TCP or UDP."
  type        = number
  default     = null
}

variable "ipv6_cidr_block" {
  description = "The IPv6 CIDR block to match. Either 'cidr_block' or 'ipv6_cidr_block' must be specified."
  type        = string
  default     = null
}

variable "icmp_type" {
  description = "The ICMP type number to allow or deny. Required if protocol is '1' (ICMP)."
  type        = number
  default     = null
}

variable "icmp_code" {
  description = "The ICMP code to allow or deny. Required if protocol is '1' (ICMP)."
  type        = number
  default     = null
}
