# Terraform AWS Network ACL Rule Module

## Overview

This module allows you to create or manage Network ACL rules in AWS. You can define rules to allow or deny traffic based on specific conditions such as IP ranges, ports, and protocols.

## Requirements

- AWS Provider 3.x or higher.
- A valid AWS account with the appropriate permissions to manage Network ACL rules.

## Module Inputs

| Name             | Description                                                                                           | Type          | Default |
| ---------------- | ----------------------------------------------------------------------------------------------------- | ------------- | ------- |
| `network_acl_id` | The ID of the Network ACL to which the rule will be added.                                            | `string`      | -       |
| `rule_number`    | The number for the rule. Rules are evaluated in order, with lower rule numbers being evaluated first. | `number`      | -       |
| `protocol`       | The protocol for the rule. Can be `tcp`, `udp`, `icmp`, or `-1` for all protocols.                    | `string`      | -       |
| `rule_action`    | The action for the rule, either `allow` or `deny`.                                                    | `string`      | -       |
| `cidr_block`     | The CIDR block to which the rule applies.                                                             | `string`      | -       |
| `egress`         | If `true`, this rule applies to outbound traffic. If `false`, it applies to inbound traffic.          | `bool`        | -       |
| `port_range`     | The port range for the rule. Defines the from and to port numbers.                                    | `object`      | -       |
| `description`    | An optional description for the rule.                                                                 | `string`      | `""`    |
| `tags`           | A map of tags to assign to the rule.                                                                  | `map(string)` | `{}`    |

## Module Outputs

| Name                  | Description                             |
| --------------------- | --------------------------------------- |
| `network_acl_rule_id` | The ID of the created Network ACL rule. |

## Example Usage

```hcl
module "acl_rule" {
  source         = "./aws_network_acl_rule"
  network_acl_id = module.network_acl.network_acl_id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  egress         = false
  port_range     = { from = 80, to = 80 }
  description    = "Allow inbound HTTP traffic"
}
```
