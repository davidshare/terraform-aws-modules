### AWS Terraform Module: Route

This Terraform module simplifies creating individual routes within an AWS route table. Routes specify how to direct network traffic within your VPC or to external destinations.

---

### **Usage**

#### Example Configuration

```hcl
module "route" {
  source = "./route"

  route_table_id         = "rtb-12345678"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-12345678" # Internet Gateway
}
```

---

### **Features**

- Supports IPv4, IPv6, and managed prefix list destinations.
- Flexible route targets, including:
  - Internet Gateways
  - NAT Gateways
  - VPC Peering Connections
  - Transit Gateways
  - Network Interfaces
  - Virtual Private Gateways
  - Carrier Gateways
  - Egress-only Internet Gateways
  - Local Gateways
- Customizable for single-route management.

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

| **File**       | **Description**                                                       |
| -------------- | --------------------------------------------------------------------- |
| `main.tf`      | Defines the route resource within a route table.                      |
| `variables.tf` | Contains input variables for defining route destinations and targets. |
| `outputs.tf`   | Provides the ID of the created route.                                 |

---

### **Inputs**

| **Name**                      | **Description**                                           | **Type** | **Default** | **Required** |
| ----------------------------- | --------------------------------------------------------- | -------- | ----------- | ------------ |
| `route_table_id`              | The ID of the route table to associate the route with.    | `string` | N/A         | Yes          |
| `destination_cidr_block`      | The destination IPv4 CIDR block for the route.            | `string` | `null`      | No           |
| `destination_ipv6_cidr_block` | The destination IPv6 CIDR block for the route.            | `string` | `null`      | No           |
| `destination_prefix_list_id`  | The ID of a managed prefix list for the route.            | `string` | `null`      | No           |
| `carrier_gateway_id`          | The ID of a carrier gateway.                              | `string` | `null`      | No           |
| `core_network_arn`            | The ARN of a core network.                                | `string` | `null`      | No           |
| `egress_only_gateway_id`      | The ID of a VPC Egress Only Internet Gateway.             | `string` | `null`      | No           |
| `gateway_id`                  | The ID of an Internet Gateway or Virtual Private Gateway. | `string` | `null`      | No           |
| `nat_gateway_id`              | The ID of a NAT Gateway.                                  | `string` | `null`      | No           |
| `local_gateway_id`            | The ID of an Outpost Local Gateway.                       | `string` | `null`      | No           |
| `network_interface_id`        | The ID of an EC2 Network Interface.                       | `string` | `null`      | No           |
| `transit_gateway_id`          | The ID of an EC2 Transit Gateway.                         | `string` | `null`      | No           |
| `vpc_endpoint_id`             | The ID of a VPC Endpoint.                                 | `string` | `null`      | No           |
| `vpc_peering_connection_id`   | The ID of a VPC Peering Connection.                       | `string` | `null`      | No           |

---

### **Outputs**

| **Name** | **Description**                                 |
| -------- | ----------------------------------------------- |
| `id`     | The ID of the route created in the route table. |

---

### **Example Usages**

#### Internet Gateway Route

```hcl
module "internet_gateway_route" {
  source = "./route"

  route_table_id         = "rtb-12345678"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-87654321"
}
```

#### NAT Gateway Route

```hcl
module "nat_gateway_route" {
  source = "./route"

  route_table_id         = "rtb-12345678"
  destination_cidr_block = "10.0.0.0/16"
  nat_gateway_id         = "nat-87654321"
}
```

#### Transit Gateway Route

```hcl
module "transit_gateway_route" {
  source = "./route"

  route_table_id         = "rtb-12345678"
  destination_cidr_block = "192.168.0.0/16"
  transit_gateway_id     = "tgw-12345678"
}
```

#### Peering Connection Route

```hcl
module "peering_connection_route" {
  source = "./route"

  route_table_id              = "rtb-12345678"
  destination_cidr_block      = "172.16.0.0/16"
  vpc_peering_connection_id   = "pcx-12345678"
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
