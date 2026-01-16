# Terraform Module: AWS VPC Endpoint Subnet Association

A safe and focused module for managing individual subnet associations with an AWS VPC Endpoint (Interface, GatewayLoadBalancer, Resource, or ServiceNetwork types).

## Purpose

Use this module when:

- You have an existing `aws_vpc_endpoint` managed elsewhere (or via another module)
- You want to **dynamically add or remove subnet associations** without modifying the `subnet_ids` list in the parent endpoint resource
- You're using `for_each` or `count` to manage multiple associations independently

**Important Warning**:  
Do **not** use this module for a subnet that is already included in the `subnet_ids` argument of the parent `aws_vpc_endpoint` resource. Doing so will cause **permanent drift and conflicts**.

## Features

- Full validation of ID formats
- Customizable timeouts
- Clear outputs
- Lifecycle precondition for non-empty inputs

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

## Usage Examples

### Single Association

```hcl
module "endpoint_subnet_assoc" {
  source = "./modules/vpc-endpoint-subnet-association"

  vpc_endpoint_id = module.ecr_dkr_endpoint.id
  subnet_id       = aws_subnet.private["us-east-1a"].id
}
```

### Multiple Associations with for_each (Recommended)

```hcl
resource "aws_vpc_endpoint" "logs" {
  # ... Interface endpoint without subnet_ids
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.vpce.id]
  private_dns_enabled = true
  # subnet_ids intentionally omitted
}

module "logs_endpoint_subnet_associations" {
  source = "./modules/vpc-endpoint-subnet-association"

  for_each = toset(aws_subnet.private[*].id)

  vpc_endpoint_id = aws_vpc_endpoint.logs.id
  subnet_id       = each.value
}
```

## Inputs & Outputs

See `variables.tf` and `outputs.tf` for details.

## Best Practices

- Prefer managing all subnets via `for_each` on this module rather than hardcoding `subnet_ids` in `aws_vpc_endpoint`
- This gives better control, avoids conflicts, and makes multi-AZ deployments cleaner
- Always ensure the VPC endpoint type supports subnet associations (Interface, GWLB, etc.)

## Import Example

```hcl
import {
  to = module.logs_endpoint_subnet_associations["subnet-12345678"]
  id = "vpce-0abcd1234efgh5678/subnet-12345678"
}
```
