### AWS Terraform Module: Network ACL

This module allows you to create and manage **AWS Network ACLs (NACLs)** along with optional rules for ingress and egress traffic. It supports rule definitions as input variables for easier customization.

---

### **Usage**

#### Example Configuration

```hcl
module "network_acl" {
  source     = "./network_acl"
  vpc_id     = "vpc-12345678"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]

  tags = {
    Name = "example-nacl"
    Environment = "production"
  }

  ingress_rules = [
    {
      rule_number     = 100
      protocol        = "6" # TCP
      cidr_block      = "0.0.0.0/0"
      rule_action     = "allow"
      from_port       = 22
      to_port         = 22
    },
    {
      rule_number     = 101
      protocol        = "-1" # All protocols
      cidr_block      = "10.0.0.0/16"
      rule_action     = "allow"
    }
  ]

  egress_rules = [
    {
      rule_number     = 200
      protocol        = "-1" # All protocols
      cidr_block      = "0.0.0.0/0"
      rule_action     = "allow"
    }
  ]
}
```

---

### **Features**

- Creates a Network ACL and optionally associates it with multiple subnets.
- Supports custom ingress and egress rules.
- Rules can specify IPv4 or IPv6 CIDR blocks, port ranges, protocols, ICMP types, and actions (`allow` or `deny`).
- Dynamic handling of ingress and egress rules for flexibility.

---

### **Requirements**

| **Dependency** | **Version** |
| -------------- | ----------- |
| Terraform      | >= 1.3.0    |
| AWS Provider   | >= 4.0      |

---

### **Providers**

| **Name** | **Source**    |
| -------- | ------------- |
| `aws`    | hashicorp/aws |

---

### **Explanation of Files**

| **File**       | **Description**                                                                  |
| -------------- | -------------------------------------------------------------------------------- |
| `main.tf`      | Defines the main Network ACL resource and dynamically adds ingress/egress rules. |
| `variables.tf` | Contains input variables for the module.                                         |
| `outputs.tf`   | Provides outputs, such as Network ACL ID and subnet associations.                |
| `README.md`    | Documentation detailing the module.                                              |

---

### **Inputs**

| **Name**        | **Description**                                                | **Type**       | **Default** | **Required** |
| --------------- | -------------------------------------------------------------- | -------------- | ----------- | ------------ |
| `vpc_id`        | ID of the VPC where the Network ACL will be created.           | `string`       | N/A         | Yes          |
| `subnet_ids`    | List of subnet IDs to associate with the Network ACL.          | `list(string)` | `[]`        | No           |
| `tags`          | Tags to apply to the Network ACL.                              | `map(string)`  | `{}`        | No           |
| `ingress_rules` | List of ingress rules for the Network ACL. Each rule is a map. | `list(object)` | `[]`        | No           |
| `egress_rules`  | List of egress rules for the Network ACL. Each rule is a map.  | `list(object)` | `[]`        | No           |

#### **Ingress/Egress Rule Object**

| **Key**           | **Description**                                     | **Type** | **Optional** |
| ----------------- | --------------------------------------------------- | -------- | ------------ |
| `rule_number`     | Rule priority number (1-32766).                     | `number` | No           |
| `protocol`        | Protocol (`6` for TCP, `17` for UDP, `-1` for all). | `string` | No           |
| `rule_action`     | Action for the rule (`allow` or `deny`).            | `string` | No           |
| `cidr_block`      | IPv4 CIDR block for the rule.                       | `string` | Yes          |
| `ipv6_cidr_block` | IPv6 CIDR block for the rule.                       | `string` | Yes          |
| `from_port`       | Starting port range (TCP/UDP only).                 | `number` | Yes          |
| `to_port`         | Ending port range (TCP/UDP only).                   | `number` | Yes          |
| `icmp_type`       | ICMP type (for protocol `1`).                       | `number` | Yes          |
| `icmp_code`       | ICMP code (for protocol `1`).                       | `number` | Yes          |

---

### **Outputs**

| **Name**                   | **Description**                                   |
| -------------------------- | ------------------------------------------------- |
| `network_acl_id`           | The ID of the created Network ACL.                |
| `network_acl_associations` | List of subnet associations with the Network ACL. |

---

### **Example Usage**

```hcl
module "network_acl" {
  source     = "./network_acl"
  vpc_id     = "vpc-87654321"
  tags = {
    Name = "dev-nacl"
  }

  ingress_rules = [
    {
      rule_number     = 100
      protocol        = "17" # UDP
      cidr_block      = "10.1.0.0/24"
      rule_action     = "allow"
      from_port       = 53
      to_port         = 53
    }
  ]

  egress_rules = [
    {
      rule_number     = 200
      protocol        = "6" # TCP
      cidr_block      = "0.0.0.0/0"
      rule_action     = "deny"
    }
  ]
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
