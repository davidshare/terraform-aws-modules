# AWS Load Balancer Target Group Module

## Overview

This Terraform module creates an AWS Load Balancer Target Group with configurable options, including health checks, stickiness, target failover, and more.

## Features

- Supports `instance`, `ip`, and `lambda` target types.
- Configurable health checks, stickiness, and target failover.
- Cross-zone load balancing and slow start options.
- Full control over tags and protocol versions.

## Usage

```hcl
module "lb_target_group" {
  source = "./module-path"

  region     = "us-east-1"
  name       = "example-tg"
  port       = 80
  protocol   = "HTTP"
  target_type = "instance"
  vpc_id     = "vpc-xxxxxxxx"

  health_check = {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200-399"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }
}
```

## Inputs

Refer to the `variables.tf` for a complete list of inputs.

## Outputs

- `target_group_arn`: The ARN of the target group.
- `target_group_name`: The name of the target group.

## Notes

- Ensure the provided VPC ID exists before applying this module.
- Check AWS documentation for compatibility of settings based on the load balancer type.
