### AWS Terraform Module: NAT Gateway

This Terraform module facilitates the creation and configuration of an AWS NAT Gateway. It includes support for secondary IP addresses, private/public connectivity, and Elastic IP allocation.

---

### **Usage**

#### Example Configuration

```hcl
module "nat_gateway" {
  source                         = "./nat_gateway"
  allocation_id                  = "eipalloc-0123456789abcdef0"
  subnet_id                      = "subnet-0123456789abcdef0"
  connectivity_type              = "public"
  tags = {
    Name        = "example-nat-gateway"
    Environment = "production"
  }
}
```

#### Key Parameters:

- **`allocation_id`**: Elastic IP allocation ID used for the NAT Gateway.
- **`subnet_id`**: Subnet ID where the NAT Gateway will be created.
- **`connectivity_type`**: Specifies whether the gateway is private or public (default: `public`).

---

### **Features**

- Creates a NAT Gateway in a specified subnet.
- Optionally assigns secondary private IP addresses or Elastic IPs.
- Supports tagging for resource organization.
- Configurable connectivity type: public or private.

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
| `main.tf`      | Defines the main resource configuration for the NAT Gateway.                   |
| `variables.tf` | Contains input variable definitions for configuring the module.                |
| `outputs.tf`   | Specifies the output values from the module for reuse in other configurations. |
| `README.md`    | Documentation providing details on usage, inputs, and outputs of the module.   |

---

### **Inputs**

| **Name**                             | **Description**                             | **Type**       | **Default** | **Required** |
| ------------------------------------ | ------------------------------------------- | -------------- | ----------- | ------------ |
| `allocation_id`                      | Allocation ID of the Elastic IP address     | `string`       | `null`      | No           |
| `subnet_id`                          | Subnet ID in which to place the NAT Gateway | `string`       | N/A         | Yes          |
| `connectivity_type`                  | Connectivity type (`public` or `private`)   | `string`       | `public`    | No           |
| `private_ip`                         | Private IP address for the NAT Gateway      | `string`       | `null`      | No           |
| `secondary_allocation_ids`           | List of secondary Elastic IP allocation IDs | `list(string)` | `null`      | No           |
| `secondary_private_ip_address_count` | Number of secondary private IP addresses    | `number`       | `null`      | No           |
| `secondary_private_ip_addresses`     | List of secondary private IP addresses      | `list(string)` | `null`      | No           |
| `tags`                               | Tags for the NAT Gateway                    | `map(string)`  | `{}`        | No           |

---

### **Outputs**

| **Name**               | **Description**                                                     |
| ---------------------- | ------------------------------------------------------------------- |
| `id`                   | The ID of the NAT Gateway                                           |
| `allocation_id`        | The Allocation ID of the Elastic IP associated with the NAT Gateway |
| `subnet_id`            | The Subnet ID where the NAT Gateway is placed                       |
| `network_interface_id` | The ENI ID of the NAT Gateway's network interface                   |
| `private_ip`           | The private IP address of the NAT Gateway                           |
| `public_ip`            | The public IP address of the NAT Gateway                            |

---

### **Example Usage**

```hcl
module "nat_gateway" {
  source                         = "./nat_gateway"
  allocation_id                  = "eipalloc-0123456789abcdef0"
  subnet_id                      = "subnet-abc123456"
  connectivity_type              = "private"
  private_ip                     = "10.0.1.10"
  tags = {
    Name        = "private-nat-gateway"
    Environment = "staging"
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
