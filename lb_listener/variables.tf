variable "load_balancer_arn" {
  description = "ARN of the load balancer."
  type        = string
}

variable "port" {
  description = "Port on which the load balancer is listening."
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol for connections. Valid values are HTTP, HTTPS, TCP, TLS, etc."
  type        = string
  default     = "HTTP"
}

variable "ssl_policy" {
  description = "Name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS/TLS protocols."
  type        = string
  default     = null
}

variable "alpn_policy" {
  description = "Name of the ALPN policy for TLS listeners."
  type        = string
  default     = null
}

variable "tcp_idle_timeout_seconds" {
  description = "TCP idle timeout in seconds for applicable protocols."
  type        = number
  default     = 350
}

variable "default_actions" {
  description = <<EOT
List of default actions for the listener. Each action may include configurations for forward, redirect, 
fixed-response, authenticate-cognito, or authenticate-oidc types.
EOT
  type = list(object({
    type             = string
    order            = optional(number)
    target_group_arn = optional(string)
    authenticate_cognito = optional(object({
      user_pool_arn       = string
      user_pool_client_id = string
      user_pool_domain    = string
      session_cookie_name = optional(string)
      session_timeout     = optional(number)
    }))
    authenticate_oidc = optional(object({
      authorization_endpoint = string
      client_id              = string
      client_secret          = string
      issuer                 = string
      token_endpoint         = string
      user_info_endpoint     = string
    }))
    fixed_response = optional(object({
      content_type = string
      message_body = optional(string)
      status_code  = optional(string)
    }))
    redirect = optional(object({
      status_code = string
      host        = optional(string)
      path        = optional(string)
      port        = optional(string)
      protocol    = optional(string)
    }))
  }))
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
