### AWS Terraform Module: VPC Security Group Egress Rule

This module creates an **AWS VPC Security Group Egress Rule**, enabling outbound traffic control in a VPC security group.

---

### **Usage**

#### Example Configuration

```hcl
module "security_group_egress_rule" {
  source = "./vpc_security_group_egress_rule"

  security_group_id = "sg-0abcd1234efgh5678"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTP outbound traffic"
  tags = {
    Name = "HTTP_Egress_Rule"
  }
}
```

---

### **Features**

- Supports multiple destination configurations:
  - IPv4 CIDR
  - IPv6 CIDR
  - Prefix list
  - Referenced security group
- Flexible protocol and port configurations.
- Custom tagging for the security group egress rule.

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

| **File**       | **Description**                                                     |
| -------------- | ------------------------------------------------------------------- |
| `main.tf`      | Contains the egress rule resource definition.                       |
| `variables.tf` | Defines input variables for configuring the egress rule.            |
| `outputs.tf`   | Exports key attributes of the egress rule for use in other modules. |

---

### **Inputs**

| **Name**                       | **Description**                                                                | **Type**      | **Default** | **Required** |
| ------------------------------ | ------------------------------------------------------------------------------ | ------------- | ----------- | ------------ |
| `security_group_id`            | The ID of the security group.                                                  | `string`      | N/A         | Yes          |
| `cidr_ipv4`                    | The destination IPv4 CIDR range.                                               | `string`      | `null`      | No           |
| `cidr_ipv6`                    | The destination IPv6 CIDR range.                                               | `string`      | `null`      | No           |
| `from_port`                    | Start of the port range for TCP/UDP protocols or an ICMP/ICMPv6 type.          | `number`      | `null`      | No           |
| `to_port`                      | End of the port range for TCP/UDP protocols or an ICMP/ICMPv6 code.            | `number`      | `null`      | No           |
| `ip_protocol`                  | The IP protocol name/number (`tcp`, `udp`, `icmp`, or `-1` for all protocols). | `string`      | N/A         | Yes          |
| `prefix_list_id`               | The ID of the destination prefix list.                                         | `string`      | `null`      | No           |
| `referenced_security_group_id` | The ID of the destination security group referenced in the rule.               | `string`      | `null`      | No           |
| `description`                  | A description for the security group rule.                                     | `string`      | `null`      | No           |
| `tags`                         | A map of tags to assign to the resource.                                       | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name** | **Description**                                    |
| -------- | -------------------------------------------------- |
| `id`     | The ID of the security group egress rule.          |
| `arn`    | The Amazon Resource Name (ARN) of the egress rule. |

---

### **Examples**

#### Allow All Outbound Traffic

```hcl
module "allow_all_outbound" {
  source = "./vpc_security_group_egress_rule"

  security_group_id = "sg-0abcd1234efgh5678"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}
```

#### Restrict Outbound Traffic to Specific Ports

```hcl
module "restrict_outbound" {
  source = "./vpc_security_group_egress_rule"

  security_group_id = "sg-0abcd1234efgh5678"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "203.0.113.0/24"
  description       = "Allow HTTPS outbound traffic to a specific CIDR range"
}
```

#### Egress Rule for Another Security Group

```hcl
module "sg_to_sg_egress" {
  source = "./vpc_security_group_egress_rule"

  security_group_id             = "sg-0abcd1234efgh5678"
  referenced_security_group_id  = "sg-0wxyz7890hijk1234"
  ip_protocol                   = "tcp"
  from_port                     = 3306
  to_port                       = 3306
  description                   = "Allow MySQL traffic to another security group"
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
