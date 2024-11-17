# Terraform AWS Network ACL Module

## Overview

This module creates an AWS Network Access Control List (NACL) in a specified VPC and optionally associates it with a list of subnets. The module also allows you to define ingress and egress rules to control traffic flow.

## Requirements

- AWS Provider 3.x or higher.
- A valid AWS account with the appropriate permissions to manage NACLs.

## Module Inputs

| Name                     | Description                                                                                                         | Type           | Default |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------- | -------------- | ------- |
| `vpc_id`                 | The ID of the VPC where the Network ACL will be created.                                                            | `string`       | -       |
| `subnet_ids`             | List of subnet IDs to associate with the Network ACL.                                                               | `list(string)` | `[]`    |
| `default_network_acl_id` | The ID of an existing Network ACL to associate with. If left empty, a new Network ACL will be created.              | `string`       | `""`    |
| `tags`                   | A map of tags to assign to the Network ACL.                                                                         | `map(string)`  | `{}`    |
| `ingress_rules`          | A list of ingress rules to apply to the Network ACL. Each rule includes properties like rule number, protocol, etc. | `list(object)` | `[]`    |
| `egress_rules`           | A list of egress rules to apply to the Network ACL. Similar to `ingress_rules`, but for outbound traffic.           | `list(object)` | `[]`    |

## Module Outputs

| Name                       | Description                                         |
| -------------------------- | --------------------------------------------------- |
| `network_acl_id`           | The ID of the created or modified Network ACL.      |
| `network_acl_associations` | List of subnet IDs associated with the Network ACL. |

## Example Usage

```hcl
module "network_acl" {
  source   = "./aws_network_acl"
  vpc_id   = "vpc-12345678"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]
  tags = {
    Name = "MyNetworkACL"
    Environment = "Production"
  }
  ingress_rules = [
    {
      rule_number = 100
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      rule_action = "allow"
      port_range  = { from = 80, to = 80 }
    }
  ]
  egress_rules = [
    {
      rule_number = 100
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      rule_action = "allow"
      port_range  = { from = 443, to = 443 }
    }
  ]
}
```
