# AWS VPC Security Group Egress Rule Module

This Terraform module manages an outbound (egress) rule for an AWS security group in a VPC, allowing you to configure specific destinations for outgoing traffic.

## Resource Details

- **Link to Documentation:** https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
- **Terraform version:** 5.75.1

## Resource Overview

The `aws_vpc_security_group_egress_rule` resource defines outbound security group rules separately from the main `aws_security_group` resource. This approach helps manage multiple CIDR blocks, allows for improved tagging, and prevents conflicts.

## Usage

```hcl
module "egress_rule" {
  source = "./path-to-module"

  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "10.0.0.0/8"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP egress traffic"
  tags = {
    Name = "http-egress-rule"
  }
}
```

## Module Details

### Arguments

| Argument                       | Description                                                        | Type          | Required | Default |
| ------------------------------ | ------------------------------------------------------------------ | ------------- | -------- | ------- |
| `security_group_id`            | The ID of the security group to associate the egress rule with.    | `string`      | Yes      | N/A     |
| `cidr_ipv4`                    | The destination IPv4 CIDR range.                                   | `string`      | No       | `null`  |
| `cidr_ipv6`                    | The destination IPv6 CIDR range.                                   | `string`      | No       | `null`  |
| `description`                  | A description for the security group rule.                         | `string`      | No       | `null`  |
| `from_port`                    | The start of the port range for the rule.                          | `number`      | No       | `null`  |
| `to_port`                      | The end of the port range for the rule.                            | `number`      | No       | `null`  |
| `ip_protocol`                  | The IP protocol name or number. Use `-1` to specify all protocols. | `string`      | Yes      | N/A     |
| `prefix_list_id`               | The ID of the destination prefix list.                             | `string`      | No       | `null`  |
| `referenced_security_group_id` | The ID of the destination security group referenced in the rule.   | `string`      | No       | `null`  |
| `tags`                         | A map of tags to assign to the resource.                           | `map(string)` | No       | `{}`    |

**Note**: You must define at least one of `cidr_ipv4`, `cidr_ipv6`, `prefix_list_id`, or `referenced_security_group_id` to set the destination of the traffic.

### Outputs

| Output                   | Description                                                               |
| ------------------------ | ------------------------------------------------------------------------- |
| `security_group_rule_id` | The ID of the created security group egress rule.                         |
| `arn`                    | The Amazon Resource Name (ARN) of the created security group egress rule. |

## Example Configuration

To create a security group with egress rules for HTTP and HTTPS traffic, define the security group resource and use this module for each rule:

```hcl
resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "example-security-group"
  }
}

module "http_egress_rule" {
  source = "./path-to-module"

  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP egress traffic"
}

module "https_egress_rule" {
  source = "./path-to-module"

  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS egress traffic"
}
```

## Notes

- **Best Practices**: This module is built following AWS best practices by using `aws_vpc_security_group_egress_rule` independently. This helps prevent conflicts with other security group configurations.
- **Required Attributes**: When setting up egress rules, ensure that `ip_protocol` is provided, and at least one destination (`cidr_ipv4`, `cidr_ipv6`, `prefix_list_id`, or `referenced_security_group_id`) is defined.

This module structure provides best practices for organizing and documenting egress security group rules, which you can leverage to demonstrate your Terraform skills and best practices to potential employers.
