variable "name" {
  description = "Name of the load balancer"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the name of the load balancer"
  type        = string
  default     = null
}

variable "internal" {
  description = "If true, the load balancer will be internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer to create: application, gateway, or network"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "List of security group IDs to assign to the load balancer"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "List of subnet IDs to attach to the load balancer"
  type        = list(string)
  default     = []
}

variable "ip_address_type" {
  description = "Type of IP addresses used by the subnets"
  type        = string
  default     = "ipv4"
}

variable "customer_owned_ipv4_pool" {
  description = "ID of the customer owned ipv4 pool"
  type        = string
  default     = null
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Whether HTTP/2 is enabled"
  type        = bool
  default     = true
}

variable "enable_tls_version_and_cipher_suite_headers" {
  description = "Add TLS version and cipher suite headers"
  type        = bool
  default     = false
}

variable "enable_xff_client_port" {
  description = "Preserve source port in the X-Forwarded-For header"
  type        = bool
  default     = false
}

variable "enable_waf_fail_open" {
  description = "Allow routing requests to targets if WAF is unavailable"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = false
}

variable "enable_zonal_shift" {
  description = "Enable zonal shift"
  type        = bool
  default     = false
}

variable "enforce_security_group_inbound_rules_on_private_link_traffic" {
  description = "Enforce inbound security group rules for PrivateLink traffic"
  type        = string
  default     = null
}

variable "desync_mitigation_mode" {
  description = "Mitigation mode for HTTP desync"
  type        = string
  default     = "defensive"
}

variable "dns_record_client_routing_policy" {
  description = "Client routing policy for DNS records"
  type        = string
  default     = "any_availability_zone"
}

variable "drop_invalid_header_fields" {
  description = "Drop invalid HTTP headers"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "Idle timeout in seconds"
  type        = number
  default     = 60
}

variable "preserve_host_header" {
  description = "Preserve the Host header in the HTTP request"
  type        = bool
  default     = false
}

variable "xff_header_processing_mode" {
  description = "How the load balancer modifies the X-Forwarded-For header"
  type        = string
  default     = "append"
}

variable "tags" {
  description = "Tags for the load balancer"
  type        = map(string)
  default     = {}
}

variable "access_logs_enabled" {
  description = "Enable access logs"
  type        = bool
  default     = false
}

variable "access_logs" {
  description = "Access log configuration"
  type = object({
    bucket  = string
    prefix  = string
    enabled = bool
  })
  default = {
    bucket  = null
    prefix  = null
    enabled = false
  }
}

variable "connection_logs_enabled" {
  description = "Enable connection logs"
  type        = bool
  default     = false
}

variable "connection_logs" {
  description = "Connection log configuration"
  type = object({
    bucket  = string
    prefix  = string
    enabled = bool
  })
  default = {
    bucket  = null
    prefix  = null
    enabled = false
  }
}

variable "subnet_mappings" {
  description = "Subnet mapping configuration"
  type = list(object({
    subnet_id            = string
    allocation_id        = string
    ipv6_address         = string
    private_ipv4_address = string
  }))
  default = []
}

variable "timeouts" {
  description = "Timeout configuration"
  type = object({
    create = string
    update = string
    delete = string
  })
  default = {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}
