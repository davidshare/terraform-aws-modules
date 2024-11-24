### AWS Terraform Module: Network ACL Rule

This Terraform module allows you to manage **AWS Network ACL (NACL) rules**, supporting both IPv4 and IPv6 configurations. It provides granular control over ingress and egress traffic.

---

### **Usage**

#### Example Configuration

```hcl
module "network_acl_rule" {
  source          = "./network_acl_rule"
  network_acl_id  = "acl-0123456789abcdef0"
  rule_number     = 100
  protocol        = "6" # TCP
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  egress          = false
  from_port       = 80
  to_port         = 80
}
```

#### Key Parameters:

- **`network_acl_id`**: Specifies the ID of the NACL to which the rule belongs.
- **`rule_number`**: The priority of the rule. Lower numbers are evaluated first.
- **`protocol`**: Protocol for the rule (`6` for TCP, `17` for UDP, `-1` for all protocols).
- **`rule_action`**: Action to apply (`allow` or `deny`).
- **`cidr_block`**: IPv4 range for the rule.

---

### **Features**

- Supports both IPv4 and IPv6 CIDR blocks.
- Handles TCP, UDP, and ICMP protocols with customizable ports and ICMP types/codes.
- Configurable ingress or egress rules.
- Validates actions (`allow` or `deny`).

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

| **File**       | **Description**                                                                |
| -------------- | ------------------------------------------------------------------------------ |
| `main.tf`      | Defines the resource configuration for the Network ACL Rule.                   |
| `variables.tf` | Contains input variable definitions for configuring the module.                |
| `outputs.tf`   | Specifies the output values from the module for reuse in other configurations. |
| `README.md`    | Documentation providing details on usage, inputs, and outputs of the module.   |

---

### **Inputs**

| **Name**          | **Description**                                                      | **Type** | **Default** | **Required** |
| ----------------- | -------------------------------------------------------------------- | -------- | ----------- | ------------ |
| `network_acl_id`  | The ID of the network ACL to associate the rule with.                | `string` | N/A         | Yes          |
| `rule_number`     | Rule number for the network ACL rule (1-32766).                      | `number` | N/A         | Yes          |
| `protocol`        | Protocol number (`6` for TCP, `17` for UDP, `-1` for all protocols). | `string` | N/A         | Yes          |
| `rule_action`     | Action to take (`allow` or `deny`).                                  | `string` | N/A         | Yes          |
| `cidr_block`      | IPv4 CIDR block to match.                                            | `string` | `null`      | No           |
| `egress`          | Whether this rule applies to egress traffic (default: ingress).      | `bool`   | N/A         | Yes          |
| `from_port`       | Starting port range for TCP/UDP.                                     | `number` | `null`      | No           |
| `to_port`         | Ending port range for TCP/UDP.                                       | `number` | `null`      | No           |
| `ipv6_cidr_block` | IPv6 CIDR block to match.                                            | `string` | `null`      | No           |
| `icmp_type`       | ICMP type (required for protocol `1`).                               | `number` | `null`      | No           |
| `icmp_code`       | ICMP code (required for protocol `1`).                               | `number` | `null`      | No           |

---

### **Outputs**

| **Name** | **Description**                 |
| -------- | ------------------------------- |
| `id`     | The ID of the Network ACL rule. |

---

### **Example Usage**

```hcl
module "network_acl_rule_ingress" {
  source          = "./network_acl_rule"
  network_acl_id  = "acl-12345678"
  rule_number     = 100
  protocol        = "6" # TCP
  rule_action     = "allow"
  cidr_block      = "10.0.0.0/16"
  egress          = false
  from_port       = 22
  to_port         = 22
}

module "network_acl_rule_egress" {
  source          = "./network_acl_rule"
  network_acl_id  = "acl-12345678"
  rule_number     = 200
  protocol        = "-1" # All protocols
  rule_action     = "allow"
  egress          = true
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
