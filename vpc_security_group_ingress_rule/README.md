# AWS VPC Security Group Ingress Rule Module

This Terraform module manages an inbound (ingress) rule for an AWS security group within a Virtual Private Cloud (VPC), following the best practices for AWS security group rules.

## Resource Details

- **Link to Documentation:** https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
- **Terraform version:** 5.75.1

## Terraform version

## Resource Overview

The `aws_vpc_security_group_ingress_rule` resource is specifically designed to manage individual ingress rules in a security group, offering more granular control than the in-line `aws_security_group` ingress configuration. By defining each ingress rule as a separate resource, this module helps prevent conflicts when managing multiple CIDR blocks and enables better tracking and tagging.

## Usage

```hcl
module "ingress_rule" {
  source = "./path-to-module"

  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "10.0.0.0/8"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP traffic from VPC"
  tags = {
    Name = "http-ingress-rule"
  }
}
```

## Module Details

### Arguments

| Argument                       | Description                                                      | Type          | Required | Default |
| ------------------------------ | ---------------------------------------------------------------- | ------------- | -------- | ------- |
| `security_group_id`            | The ID of the security group to associate the ingress rule with. | `string`      | Yes      | N/A     |
| `cidr_ipv4`                    | The source IPv4 CIDR range.                                      | `string`      | No       | `null`  |
| `cidr_ipv6`                    | The source IPv6 CIDR range.                                      | `string`      | No       | `null`  |
| `description`                  | A description for the security group rule.                       | `string`      | No       | `null`  |
| `from_port`                    | The start of the port range for the rule.                        | `number`      | No       | `null`  |
| `to_port`                      | The end of the port range for the rule.                          | `number`      | No       | `null`  |
| `ip_protocol`                  | The IP protocol name or number. Use `-1` for all protocols.      | `string`      | Yes      | N/A     |
| `prefix_list_id`               | The ID of the source prefix list.                                | `string`      | No       | `null`  |
| `referenced_security_group_id` | The ID of the source security group referenced in the rule.      | `string`      | No       | `null`  |
| `tags`                         | A map of tags to assign to the resource.                         | `map(string)` | No       | `{}`    |

**Note**: At least one of `cidr_ipv4`, `cidr_ipv6`, `prefix_list_id`, or `referenced_security_group_id` is required to define the source of the traffic.

### Outputs

| Output                   | Description                                                                |
| ------------------------ | -------------------------------------------------------------------------- |
| `security_group_rule_id` | The ID of the created security group ingress rule.                         |
| `arn`                    | The Amazon Resource Name (ARN) of the created security group ingress rule. |

## Example Configuration

To create a security group with HTTP and HTTPS ingress rules, you can define the security group resource and use this module for each ingress rule:

```hcl

  resource "aws_security_group" "example" {
    name        = "example-sg"
    description = "Example security group"
    vpc_id      = aws_vpc.main.id
    tags = {
      Name = "example-security-group"
    }
  }

  module "http_ingress_rule" {
    source = "./path-to-module"

    security_group_id = aws_security_group.example.id
    cidr_ipv4         = "10.0.0.0/8"
    from_port         = 80
    to_port           = 80
    ip_protocol       = "tcp"
    description       = "Allow HTTP traffic"
  }

  module "https_ingress_rule" {
    source = "./path-to-module"

    security_group_id = aws_security_group.example.id
    cidr_ipv4         = "10.0.0.0/8"
    from_port         = 443
    to_port           = 443
    ip_protocol       = "tcp"
    description       = "Allow HTTPS traffic"
  }

```

## Notes

- **Best Practices**: This module follows AWS best practices by using `aws_vpc_security_group_ingress_rule` as a standalone resource. Avoid using `aws_security_group_rule` or in-line `ingress` configuration in `aws_security_group` to prevent conflicts.
- **Conditional Attributes**: The module provides flexibility with optional attributes, like CIDR blocks and tags. Use `ip_protocol = -1` to allow all traffic types, which removes the requirement for `from_port` and `to_port`.
