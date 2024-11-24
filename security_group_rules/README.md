### AWS Terraform Module: Security Group Rules

This module manages individual AWS Security Group rules, enabling fine-grained control over network traffic permissions.

---

### **Usage**

#### Example Configuration

```hcl
module "security_group_rule" {
  source = "./security_group_rules"

  security_group_id = "sg-0123456789abcdef"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTP traffic from anywhere"
}
```

---

### **Features**

- Supports **ingress** and **egress** rules.
- Flexible configuration for multiple traffic sources:
  - **CIDR blocks** (IPv4 or IPv6)
  - **Security group references**
  - **Prefix list IDs**
  - **Self-referencing traffic**
- Includes input validation for rule types (`ingress` or `egress`).
- Dynamically manages conflicting source fields.

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

### **Explanation of Files**

| **File**       | **Description**                                                                 |
| -------------- | ------------------------------------------------------------------------------- |
| `main.tf`      | Contains the Security Group rule resource configuration with dynamic arguments. |
| `variables.tf` | Defines all input variables for creating rules.                                 |
| `outputs.tf`   | Exports key attributes of the created Security Group rule.                      |

---

### **Inputs**

| **Name**                   | **Description**                                                               | **Type**       | **Default** | **Required** |
| -------------------------- | ----------------------------------------------------------------------------- | -------------- | ----------- | ------------ |
| `security_group_id`        | The ID of the Security Group to attach this rule to.                          | `string`       | N/A         | Yes          |
| `type`                     | Type of the rule: either `ingress` or `egress`.                               | `string`       | N/A         | Yes          |
| `from_port`                | Starting port of the rule.                                                    | `number`       | `null`      | No           |
| `to_port`                  | Ending port of the rule.                                                      | `number`       | `null`      | No           |
| `protocol`                 | Protocol to allow: `tcp`, `udp`, `icmp`, `icmpv6`, `all`, or protocol number. | `string`       | N/A         | Yes          |
| `cidr_blocks`              | List of IPv4 CIDR blocks.                                                     | `list(string)` | `[]`        | No           |
| `ipv6_cidr_blocks`         | List of IPv6 CIDR blocks.                                                     | `list(string)` | `[]`        | No           |
| `prefix_list_ids`          | List of Prefix List IDs for traffic sources.                                  | `list(string)` | `[]`        | No           |
| `self`                     | Allow traffic from/to the same Security Group.                                | `bool`         | `false`     | No           |
| `source_security_group_id` | Security Group ID to allow access from/to.                                    | `string`       | `null`      | No           |
| `description`              | A description for the rule.                                                   | `string`       | `""`        | No           |

---

### **Outputs**

| **Name** | **Description**                            |
| -------- | ------------------------------------------ |
| `id`     | The ID of the created Security Group rule. |

---

### **Example Usages**

#### Ingress Rule for SSH Traffic

```hcl
module "ssh_ingress_rule" {
  source = "./security_group_rules"

  security_group_id = "sg-0123456789abcdef"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["203.0.113.0/24"]
  description       = "Allow SSH access from specific subnet"
}
```

#### Egress Rule for All Traffic

```hcl
module "egress_rule" {
  source = "./security_group_rules"

  security_group_id = "sg-0123456789abcdef"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
