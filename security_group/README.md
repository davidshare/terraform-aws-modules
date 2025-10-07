### AWS Terraform Module: Security Group

This module creates an AWS Security Group, providing control over the network boundaries for resources in a specific VPC.

---

### **Usage**

#### Example Configuration

```hcl
module "security_group" {
  source = "./security_group"

  name        = "web-server-sg"
  description = "Security group for web servers"
  vpc_id      = "vpc-12345678"
  tags = {
    Environment = "Production"
    Project     = "WebApp"
  }
}
```

---

### **Features**

- Creates a **Security Group** in a specific VPC.
- Option to:
  - Specify a **name** or a **name prefix**.
  - Attach custom **tags**.
  - Automatically **revoke rules on delete** to simplify resource cleanup.

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

| **File**       | **Description**                                                                |
| -------------- | ------------------------------------------------------------------------------ |
| `main.tf`      | Contains the Security Group resource definition.                               |
| `variables.tf` | Defines input variables for customizing the Security Group.                    |
| `outputs.tf`   | Exports key attributes of the created Security Group for use in other modules. |

---

### **Inputs**

| **Name**                 | **Description**                                                                    | **Type**      | **Default** | **Required** |
| ------------------------ | ---------------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `name`                   | The name of the Security Group. Conflicts with `name_prefix`.                      | `string`      | N/A         | Yes          |
| `name_prefix`            | Creates a unique name beginning with the specified prefix. Conflicts with `name`.  | `string`      | `null`      | No           |
| `description`            | A description for the Security Group.                                              | `string`      | N/A         | Yes          |
| `vpc_id`                 | The VPC ID in which to create the Security Group.                                  | `string`      | N/A         | Yes          |
| `revoke_rules_on_delete` | Revoke all associated ingress and egress rules before deleting the Security Group. | `bool`        | `false`     | No           |
| `tags`                   | A map of key-value tags to assign to the Security Group.                           | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**   | **Description**                                |
| ---------- | ---------------------------------------------- |
| `id`       | The ID of the Security Group.                  |
| `arn`      | The ARN of the Security Group.                 |
| `vpc_id`   | The VPC ID associated with the Security Group. |
| `owner_id` | The owner ID of the Security Group.            |
| `name`     | The name of the Security Group.                |

---

### **Example Usages**

#### General Purpose Security Group

```hcl
module "general_sg" {
  source = "./security_group"

  name        = "general-sg"
  description = "General purpose security group"
  vpc_id      = "vpc-98765432"
  tags = {
    Team = "DevOps"
  }
}
```

#### Security Group with Name Prefix

```hcl
module "prefix_sg" {
  source = "./security_group"

  name_prefix  = "project-"
  description  = "Security group for project resources"
  vpc_id       = "vpc-87654321"
  tags = {
    Project = "MyApp"
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
