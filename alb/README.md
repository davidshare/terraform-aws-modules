# AWS Load Balancer Terraform Module

This Terraform module creates an AWS Load Balancer (`aws_lb`) resource with full customization options.

## Features

- Supports all load balancer types: Application, Network, and Gateway.
- Fully configurable arguments including access logs, connection logs, and subnet mappings.

## Usage

```hcl
module "lb" {
  source = "./path-to-module"

  name               = "example-lb"
  load_balancer_type = "application"
  subnets            = ["subnet-1", "subnet-2"]
  tags               = {
    Environment = "production"
  }
}
```

## Inputs

Refer to `variables.tf` for the complete list of configurable inputs.

## Outputs

| Name     | Description                       |
| -------- | --------------------------------- |
| id       | The ID of the load balancer       |
| arn      | The ARN of the load balancer      |
| dns_name | The DNS name of the load balancer |
| zone_id  | The zone ID of the load balancer  |
