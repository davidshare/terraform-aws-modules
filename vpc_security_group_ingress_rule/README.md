### AWS Terraform Module: VPC Security Group Ingress Rule

This Terraform module creates an **AWS VPC Security Group Ingress Rule**, which defines inbound traffic rules for an AWS security group.

---

### **Usage**

#### Example Configuration

```hcl
module "security_group_ingress_rule" {
  source = "./vpc_security_group_ingress_rule"

  security_group_id = "sg-0abcd1234efgh5678"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow SSH traffic from any IPv4 address"
  tags = {
    Name = "SSH_Ingress_Rule"
  }
}
```

---

### **Features**

- Configurable sources for traffic:
  - IPv4 CIDR
  - IPv6 CIDR
  - Prefix list
  - Referenced security group
- Flexible protocol and port configurations.
- Supports tagging for better resource management.

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
| `main.tf`      | Defines the ingress rule resource.                                             |
| `variables.tf` | Specifies input variables for the module.                                      |
| `outputs.tf`   | Exports key attributes of the ingress rule for use in other Terraform modules. |

---

### **Inputs**

| **Name**                       | **Description**                                                            | **Type**      | **Default** | **Required** |
| ------------------------------ | -------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `security_group_id`            | The ID of the security group to associate the ingress rule with.           | `string`      | N/A         | Yes          |
| `cidr_ipv4`                    | The source IPv4 CIDR range for the rule.                                   | `string`      | `null`      | No           |
| `cidr_ipv6`                    | The source IPv6 CIDR range for the rule.                                   | `string`      | `null`      | No           |
| `description`                  | A description for the security group rule.                                 | `string`      | `null`      | No           |
| `from_port`                    | The start of the port range for TCP/UDP protocols or the ICMP/ICMPv6 type. | `number`      | `null`      | No           |
| `to_port`                      | The end of the port range for TCP/UDP protocols or the ICMP/ICMPv6 code.   | `number`      | `null`      | No           |
| `ip_protocol`                  | The IP protocol name or number. Use `-1` to allow all protocols.           | `string`      | N/A         | Yes          |
| `prefix_list_id`               | The ID of the source prefix list.                                          | `string`      | `null`      | No           |
| `referenced_security_group_id` | The ID of the source security group referenced in the rule.                | `string`      | `null`      | No           |
| `tags`                         | A map of tags to assign to the ingress rule.                               | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**                 | **Description**                                     |
| ------------------------ | --------------------------------------------------- |
| `id` | The ID of the created security group ingress rule.  |
| `arn`                    | The Amazon Resource Name (ARN) of the ingress rule. |

---

### **Examples**

#### Allow HTTP Traffic from Specific CIDR

```hcl
module "allow_http_ingress" {
  source = "./vpc_security_group_ingress_rule"

  security_group_id = "sg-0abcd1234efgh5678"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "192.168.0.0/16"
  description       = "Allow HTTP traffic from internal network"
}
```

#### Allow All Traffic from Another Security Group

```hcl
module "allow_all_from_sg" {
  source = "./vpc_security_group_ingress_rule"

  security_group_id             = "sg-0abcd1234efgh5678"
  referenced_security_group_id  = "sg-0wxyz7890hijk1234"
  ip_protocol                   = "-1"
  description                   = "Allow all inbound traffic from another security group"
}
```

#### Allow HTTPS Traffic from IPv6 CIDR

```hcl
module "allow_https_ipv6" {
  source = "./vpc_security_group_ingress_rule"

  security_group_id = "sg-0abcd1234efgh5678"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv6         = "::/0"
  description       = "Allow HTTPS traffic from any IPv6 address"
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
