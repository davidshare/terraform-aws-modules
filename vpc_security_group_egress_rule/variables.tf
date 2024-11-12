variable "security_group_id" {
  description = "The ID of the security group."
  type        = string
}

variable "cidr_ipv4" {
  description = "The destination IPv4 CIDR range."
  type        = string
  default     = null
}

variable "cidr_ipv6" {
  description = "The destination IPv6 CIDR range."
  type        = string
  default     = null
}

variable "from_port" {
  description = "The start of the port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type."
  type        = number
  default     = null
}

variable "to_port" {
  description = "The end of the port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code."
  type        = number
  default     = null
}

variable "ip_protocol" {
  description = "The IP protocol name or number. Use -1 to specify all protocols."
  type        = string
}

variable "prefix_list_id" {
  description = "The ID of the destination prefix list."
  type        = string
  default     = null
}

variable "referenced_security_group_id" {
  description = "The ID of the destination security group referenced in the rule."
  type        = string
  default     = null
}

variable "description" {
  description = "A description for the security group rule."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
