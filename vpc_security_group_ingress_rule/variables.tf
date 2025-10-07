# variables.tf

variable "security_group_id" {
  description = "The ID of the security group to associate the ingress rule with."
  type        = string
}

variable "cidr_ipv4" {
  description = "(Optional) The source IPv4 CIDR range for the rule."
  type        = string
  default     = null
}

variable "cidr_ipv6" {
  description = "(Optional) The source IPv6 CIDR range for the rule."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description for the security group rule."
  type        = string
  default     = null
}

variable "from_port" {
  description = "(Optional) The start of the port range for TCP/UDP protocols or the ICMP/ICMPv6 type."
  type        = number
  default     = null
}

variable "to_port" {
  description = "(Optional) The end of the port range for TCP/UDP protocols or the ICMP/ICMPv6 code."
  type        = number
  default     = null
}

variable "ip_protocol" {
  description = "(Required) The IP protocol name or number. Use -1 to allow all protocols."
  type        = string
}

variable "prefix_list_id" {
  description = "(Optional) The ID of the source prefix list."
  type        = string
  default     = null
}

variable "referenced_security_group_id" {
  description = "(Optional) The ID of the source security group referenced in the rule."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the ingress rule."
  type        = map(string)
  default     = {}
}
