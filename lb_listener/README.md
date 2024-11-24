# AWS Terraform Module: Load Balancer Listener

This module manages the creation of an AWS Load Balancer Listener using Terraform. It supports HTTP, HTTPS, and other protocols, allowing you to define default actions, SSL policies, and other settings. The purpose of the module is to streamline the configuration and deployment of load balancer listeners in AWS.

---

## Usage

Below is an example of how to use the module in your Terraform configuration:

```hcl
module "lb_listener" {
  source              = "./lb_listener"
  load_balancer_arn   = "arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/example-lb/123456"
  port                = 443
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-2016-08"
  certificate_arn     = "arn:aws:acm:region:account-id:certificate/123456"
  default_actions     = [
    {
      type             = "forward"
      target_group_arn = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/example-group/123456"
    }
  ]
  tags = {
    Environment = "production"
  }
}
```

### Key Parameters

- **`load_balancer_arn`**: ARN of the load balancer.
- **`port`**: Port for the listener (default: 80).
- **`protocol`**: Protocol for connections (default: HTTP).
- **`ssl_policy`**: SSL policy for HTTPS/TLS connections.
- **`default_actions`**: List of default actions, e.g., forwarding requests to a target group.

---

## Requirements

| Requirement  | Version  |
| ------------ | -------- |
| Terraform    | >= 1.3.0 |
| AWS Provider | >= 4.0.0 |

---

## Providers

| Provider | Purpose                                      |
| -------- | -------------------------------------------- |
| `aws`    | Manages AWS Load Balancer Listener resources |

---

## Features

- Supports multiple protocols, including HTTP, HTTPS, TCP, and TLS.
- Configurable SSL policies and certificate ARNs for secure connections.
- Flexible action configuration for forwarding, redirection, and authentication.

---

## Explanation of Files

| File           | Description                                               |
| -------------- | --------------------------------------------------------- |
| `main.tf`      | Contains the primary resource definitions for the module. |
| `variables.tf` | Defines input variables used by the module.               |
| `outputs.tf`   | Defines output values provided by the module.             |
| `README.md`    | Documentation of the module's usage and features.         |

---

## Inputs

| Name                       | Description                                                         | Type     | Default | Required |
| -------------------------- | ------------------------------------------------------------------- | -------- | ------- | -------- |
| `load_balancer_arn`        | ARN of the load balancer.                                           | `string` | n/a     | yes      |
| `port`                     | Port on which the load balancer is listening.                       | `number` | `80`    | no       |
| `protocol`                 | Protocol for connections (e.g., HTTP, HTTPS, TCP).                  | `string` | `HTTP`  | no       |
| `ssl_policy`               | SSL policy name. Required for HTTPS or TLS.                         | `string` | `null`  | no       |
| `certificate_arn`          | ARN of the SSL certificate for HTTPS/TLS protocols.                 | `string` | `null`  | no       |
| `alpn_policy`              | Name of the ALPN policy for TLS listeners.                          | `string` | `null`  | no       |
| `tcp_idle_timeout_seconds` | TCP idle timeout in seconds.                                        | `number` | `350`   | no       |
| `default_actions`          | List of default actions for the listener (e.g., forward, redirect). | `list`   | n/a     | yes      |
| `tags`                     | A map of tags to assign to the resource.                            | `map`    | `{}`    | no       |

---

## Outputs

| Name           | Description                                |
| -------------- | ------------------------------------------ |
| `arn` | ARN of the created load balancer listener. |
| `id`  | ID of the created load balancer listener.  |

---

## Example Usage

### HTTPS Listener with SSL Policy

```hcl
module "https_listener" {
  source              = "./lb_listener"
  load_balancer_arn   = "arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/example-lb/123456"
  port                = 443
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-2016-08"
  certificate_arn     = "arn:aws:acm:region:account-id:certificate/123456"
  default_actions     = [
    {
      type             = "forward"
      target_group_arn = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/example-group/123456"
    }
  ]
  tags = {
    Environment = "production"
  }
}
```

---

## Authors

Maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.
