resource "aws_lb_listener" "this" {
  load_balancer_arn        = var.load_balancer_arn
  port                     = var.port
  protocol                 = var.protocol
  ssl_policy               = var.ssl_policy
  certificate_arn          = var.certificate_arn
  alpn_policy              = var.alpn_policy
  tcp_idle_timeout_seconds = var.tcp_idle_timeout_seconds

  dynamic "default_action" {
    for_each = var.default_actions
    content {
      type             = default_action.value.type
      order            = default_action.value.order
      target_group_arn = default_action.value.target_group_arn

      dynamic "authenticate_cognito" {
        for_each = default_action.value.authenticate_cognito != null ? [1] : []
        content {
          user_pool_arn       = default_action.value.authenticate_cognito.user_pool_arn
          user_pool_client_id = default_action.value.authenticate_cognito.user_pool_client_id
          user_pool_domain    = default_action.value.authenticate_cognito.user_pool_domain
          session_cookie_name = default_action.value.authenticate_cognito.session_cookie_name
          session_timeout     = default_action.value.authenticate_cognito.session_timeout
        }
      }

      dynamic "authenticate_oidc" {
        for_each = default_action.value.authenticate_oidc != null ? [1] : []
        content {
          authorization_endpoint = default_action.value.authenticate_oidc.authorization_endpoint
          client_id              = default_action.value.authenticate_oidc.client_id
          client_secret          = default_action.value.authenticate_oidc.client_secret
          issuer                 = default_action.value.authenticate_oidc.issuer
          token_endpoint         = default_action.value.authenticate_oidc.token_endpoint
          user_info_endpoint     = default_action.value.authenticate_oidc.user_info_endpoint
        }
      }

      dynamic "fixed_response" {
        for_each = default_action.value.fixed_response != null ? [1] : []
        content {
          content_type = default_action.value.fixed_response.content_type
          message_body = default_action.value.fixed_response.message_body
          status_code  = default_action.value.fixed_response.status_code
        }
      }

      dynamic "redirect" {
        for_each = default_action.value.redirect != null ? [1] : []
        content {
          status_code = default_action.value.redirect.status_code
          host        = default_action.value.redirect.host
          path        = default_action.value.redirect.path
          port        = default_action.value.redirect.port
          protocol    = default_action.value.redirect.protocol
        }
      }
    }
  }

  tags = var.tags
}
