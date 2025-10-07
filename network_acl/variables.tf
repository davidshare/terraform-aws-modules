# Variables file for aws_network_acl module

variable "vpc_id" {
  description = "The ID of the VPC where the Network ACL will be created."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the Network ACL."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {
  description = "A list of ingress rules for the Network ACL. Each rule is a map of settings."
  type = list(object({
    rule_number     = number
    protocol        = string
    cidr_block      = optional(string)
    rule_action     = string
    from_port       = optional(number)
    to_port         = optional(number)
    ipv6_cidr_block = optional(string)
    icmp_type       = optional(number)
    icmp_code       = optional(number)
  }))
  default = []
}

variable "egress_rules" {
  description = "A list of egress rules for the Network ACL. Each rule is a map of settings."
  type = list(object({
    rule_number     = number
    protocol        = string
    cidr_block      = optional(string)
    rule_action     = string
    from_port       = optional(number)
    to_port         = optional(number)
    ipv6_cidr_block = optional(string)
    icmp_type       = optional(number)
    icmp_code       = optional(number)
  }))
  default = []
}
