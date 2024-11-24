### AWS Terraform Module: Route Table

This Terraform module allows you to manage AWS route tables, define custom routes, and associate them with a VPC.

---

### **Usage**

#### Example Configuration

```hcl
module "route_table" {
  source = "./route_table"

  vpc_id = "vpc-12345678"

  route = [
    {
      cidr_block     = "0.0.0.0/0"
      gateway_id     = "igw-12345678"
    },
    {
      cidr_block     = "10.0.0.0/16"
      nat_gateway_id = "nat-12345678"
    }
  ]

  propagating_vgws = ["vgw-12345678"]

  tags = {
    Name = "MyRouteTable"
  }
}
```

---

### **Features**

- Create and manage route tables in AWS VPC.
- Supports various route targets like `gateway_id`, `nat_gateway_id`, `network_interface_id`, etc.
- Supports route propagation via virtual gateways (VGWs).
- Outputs information such as the Route Table ID, ARN, and Owner ID.

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
| `main.tf`      | Defines the main resource for the route table and its routes.                  |
| `variables.tf` | Contains the input variables for the module, including routes and propagation. |
| `outputs.tf`   | Provides outputs, such as the ID and ARN of the route table.                   |

---

### **Inputs**

| **Name**           | **Description**                                          | **Type**       | **Default** | **Required** |
| ------------------ | -------------------------------------------------------- | -------------- | ----------- | ------------ |
| `vpc_id`           | The ID of the VPC where the route table will be created. | `string`       | N/A         | Yes          |
| `route`            | A list of routes to associate with the route table.      | `list(object)` | `[]`        | No           |
| `propagating_vgws` | A list of virtual gateways for route propagation.        | `list(string)` | `null`      | No           |
| `tags`             | A map of tags to assign to the route table.              | `map(string)`  | `{}`        | No           |

---

### **Outputs**

| **Name**               | **Description**                                      |
| ---------------------- | ---------------------------------------------------- |
| `id`       | The ID of the created route table.                   |
| `arn`      | The ARN of the created route table.                  |
| `route_table_owner_id` | The ID of the AWS account that owns the route table. |

---

### **Example Usage**

#### Define Routes

This example demonstrates adding multiple routes to a route table:

```hcl
module "route_table" {
  source = "./route_table"
  vpc_id = "vpc-12345678"

  route = [
    {
      cidr_block     = "0.0.0.0/0"
      gateway_id     = "igw-12345678"   # Internet Gateway
    },
    {
      cidr_block     = "10.0.0.0/16"
      nat_gateway_id = "nat-87654321"   # NAT Gateway
    },
    {
      cidr_block     = "172.16.0.0/16"
      vpc_peering_connection_id = "pcx-12345678" # VPC Peering Connection
    }
  ]

  propagating_vgws = ["vgw-12345678"]

  tags = {
    Name = "MainRouteTable"
  }
}
```

#### Define Propagation with VGWs

If you want to allow route propagation from VGWs:

```hcl
module "route_table" {
  source = "./route_table"
  vpc_id = "vpc-12345678"

  propagating_vgws = ["vgw-12345678"]
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
