# AWS Load Balancer Listener Module

This Terraform module creates an AWS Load Balancer Listener (`aws_lb_listener`) resource. It supports multiple listener configurations, including forwarding, fixed responses, redirects, and authentication.

## Features

- Create listeners for ALBs, NLBs, or Gateway Load Balancers.
- Configure default actions for forwarding, fixed-response, or redirects.
- Add authentication options using Cognito or OpenID Connect (OIDC).
- Full support for SSL/TLS protocols and policies.

## Requirements

- Terraform v1.3.0 or newer
- AWS provider v5.0 or newer

## Usage

```hcl
module "lb_listener" {
  source = "./aws_lb_listener_module"

  load_balancer_arn = aws_lb.front_end.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::123456789012:server-certificate/example"

  default_actions = [
    {
      type             = "forward"
      target_group_arn = aws_lb_target_group.front_end.arn
    }
  ]

  tags = {
    Environment = "Production"
    Application = "WebApp"
  }
}
```

## Inputs

| Name                       | Description                                       | Type   | Default | Required |
| -------------------------- | ------------------------------------------------- | ------ | ------- | -------- |
| `load_balancer_arn`        | ARN of the load balancer.                         | string | `null`  | yes      |
| `port`                     | Port on which the load balancer listens.          | number | `80`    | no       |
| `protocol`                 | Protocol for connections.                         | string | `HTTP`  | no       |
| `ssl_policy`               | SSL policy name (required for HTTPS/TLS).         | string | `null`  | no       |
| `certificate_arn`          | ARN of the SSL certificate for HTTPS/TLS.         | string | `null`  | no       |
| `alpn_policy`              | ALPN policy name for TLS listeners.               | string | `null`  | no       |
| `tcp_idle_timeout_seconds` | TCP idle timeout in seconds.                      | number | `350`   | no       |
| `default_actions`          | List of actions to perform for incoming requests. | list   | `[]`    | yes      |
| `tags`                     | Map of tags to assign to the listener.            | map    | `{}`    | no       |

## Outputs

| Name           | Description                                |
| -------------- | ------------------------------------------ |
| `listener_arn` | ARN of the created load balancer listener. |
| `listener_id`  | ID of the created load balancer listener.  |

## Examples

- [Basic HTTPS Listener](examples/basic_https.tf)
- [Redirect HTTP to HTTPS](examples/redirect_http_to_https.tf)
- [Fixed-Response Listener](examples/fixed_response.tf)
- [Authenticate Using Cognito](examples/authenticate_cognito.tf)
- [Authenticate Using OIDC](examples/authenticate_oidc.tf)
