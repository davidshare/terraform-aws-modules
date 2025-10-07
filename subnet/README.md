### AWS Terraform Module: Subnet

This module provisions an AWS VPC Subnet with configurable options such as public/private IP mapping, DNS settings, and IPv6 support.

---

### **Usage**

#### Example Configuration

```hcl
module "subnet" {
  source = "./subnets"

  vpc_id                          = "vpc-0abcd1234efgh5678"
  cidr_block                      = "10.0.1.0/24"
  availability_zone               = "us-east-1a"
  map_public_ip_on_launch         = true
  enable_resource_name_dns_a_record_on_launch    = true
  tags = {
    Environment = "Production"
    Name        = "MySubnet"
  }
}
```

---

### **Features**

- **IPv4 and IPv6**: Support for both IPv4 and IPv6 CIDR blocks.
- **DNS Settings**: Enable or disable DNS64, AAAA, and A record resolution.
- **Public/Private Subnet**: Option to map public IP addresses on instance launch.
- **Outpost Support**: Configure subnets for use with AWS Outposts.
- **Tagging**: Apply custom metadata to the subnet.

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

| **File**       | **Description**                                                |
| -------------- | -------------------------------------------------------------- |
| `main.tf`      | Contains the Subnet resource definition.                       |
| `variables.tf` | Defines input variables for subnet configuration.              |
| `outputs.tf`   | Exports key attributes of the subnet for use in other modules. |

---

### **Inputs**

| **Name**                                         | **Description**                                                                  | **Type**      | **Default** | **Required** |
| ------------------------------------------------ | -------------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `vpc_id`                                         | The ID of the VPC.                                                               | `string`      | N/A         | Yes          |
| `cidr_block`                                     | The IPv4 CIDR block for the subnet.                                              | `string`      | N/A         | Yes          |
| `availability_zone`                              | The availability zone for the subnet.                                            | `string`      | N/A         | Yes          |
| `availability_zone_id`                           | The availability zone ID for the subnet.                                         | `string`      | `null`      | No           |
| `customer_owned_ipv4_pool`                       | The customer-owned IPv4 address pool.                                            | `string`      | `null`      | No           |
| `enable_dns64`                                   | Enable DNS64 for the subnet.                                                     | `bool`        | `false`     | No           |
| `enable_resource_name_dns_aaaa_record_on_launch` | Enable DNS AAAA records for instances.                                           | `bool`        | `false`     | No           |
| `enable_resource_name_dns_a_record_on_launch`    | Enable DNS A records for instances.                                              | `bool`        | `false`     | No           |
| `ipv6_cidr_block`                                | The IPv6 CIDR block for the subnet.                                              | `string`      | `null`      | No           |
| `ipv6_native`                                    | Create an IPv6-only subnet.                                                      | `bool`        | `false`     | No           |
| `map_customer_owned_ip_on_launch`                | Assign customer-owned IPs to network interfaces on launch.                       | `bool`        | `false`     | No           |
| `map_public_ip_on_launch`                        | Assign public IPs to instances on launch.                                        | `bool`        | `false`     | No           |
| `outpost_arn`                                    | ARN of the Outpost for the subnet.                                               | `string`      | `null`      | No           |
| `private_dns_hostname_type_on_launch`            | Type of private DNS hostnames to assign (`ip-name`, `resource-name`, or `none`). | `string`      | `null`      | No           |
| `tags`                                           | A map of tags to assign to the subnet.                                           | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**                         | **Description**                               |
| -------------------------------- | --------------------------------------------- |
| `id`                             | The ID of the created subnet.                 |
| `arn`                            | The Amazon Resource Name (ARN) of the subnet. |
| `ipv6_cidr_block_association_id` | The association ID for the IPv6 CIDR block.   |
| `owner_id`                       | The AWS account ID that owns the subnet.      |

---

### **Example Usages**

#### Public Subnet

```hcl
module "public_subnet" {
  source = "./subnets"

  vpc_id                  = "vpc-0abcd1234efgh5678"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet"
  }
}
```

#### Private Subnet

```hcl
module "private_subnet" {
  source = "./subnets"

  vpc_id              = "vpc-0abcd1234efgh5678"
  cidr_block          = "10.0.2.0/24"
  availability_zone   = "us-east-1b"
  tags = {
    Name = "PrivateSubnet"
  }
}
```

#### IPv6-Enabled Subnet

```hcl
module "ipv6_subnet" {
  source = "./subnets"

  vpc_id          = "vpc-0abcd1234efgh5678"
  cidr_block      = "10.0.3.0/24"
  ipv6_cidr_block = "2001:db8:1234:1a00::/64"
  ipv6_native     = true
  tags = {
    Name = "IPv6Subnet"
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
