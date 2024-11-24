### AWS Terraform Module: Route Table Association

This module allows you to associate a **Route Table** with a **Subnet** or an **Internet Gateway/VPN Gateway** in AWS.

---

### **Usage**

#### Example Configuration

```hcl
module "route_table_association" {
  source         = "./route_table_association"
  route_table_id = "rtb-12345678"
  subnet_id      = "subnet-12345678" # Associate with a subnet
  # gateway_id   = "igw-12345678"   # Alternatively, associate with a gateway
}
```

---

### **Features**

- Supports association of route tables with:
  - Subnets
  - Internet Gateways (IGWs)
  - Virtual Private Gateways (VGWs)
- Outputs the ID of the association for further usage.

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

| **File**       | **Description**                                                  |
| -------------- | ---------------------------------------------------------------- |
| `main.tf`      | Defines the main resource for route table association.           |
| `variables.tf` | Contains input variables for the module.                         |
| `outputs.tf`   | Provides outputs, such as the ID of the route table association. |
| `README.md`    | Documentation detailing the module.                              |

---

### **Inputs**

| **Name**         | **Description**                                          | **Type** | **Default** | **Required** |
| ---------------- | -------------------------------------------------------- | -------- | ----------- | ------------ |
| `route_table_id` | The ID of the route table to associate with.             | `string` | N/A         | Yes          |
| `subnet_id`      | The ID of the subnet to associate with the route table.  | `string` | `null`      | No           |
| `gateway_id`     | The ID of the gateway to associate with the route table. | `string` | `null`      | No           |

> **Note:** Either `subnet_id` or `gateway_id` must be provided.

---

### **Outputs**

| **Name**                     | **Description**                    |
| ---------------------------- | ---------------------------------- |
| `id` | The ID of the created association. |

---

### **Example Usage**

#### Subnet Association

```hcl
module "route_table_association" {
  source         = "./route_table_association"
  route_table_id = "rtb-12345678"
  subnet_id      = "subnet-87654321"
}
```

#### Gateway Association

```hcl
module "route_table_association" {
  source         = "./route_table_association"
  route_table_id = "rtb-12345678"
  gateway_id     = "igw-87654321"
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
