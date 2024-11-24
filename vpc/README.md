### AWS Terraform Module: VPC

This Terraform module provisions an **AWS Virtual Private Cloud (VPC)** with various customizable configurations, such as CIDR blocks, DNS settings, IPv6 settings, and tagging.

---

### **Usage**

#### Basic Example

```hcl
module "vpc" {
  source = "./vpc"

  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}
```

#### Advanced Example (IPv6 CIDR Allocation)

```hcl
module "vpc" {
  source = "./vpc"

  cidr_block                           = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block     = true
  enable_dns_support                   = true
  enable_dns_hostnames                 = true
  ipv6_cidr_block_network_border_group = "us-east-1"
  tags = {
    Name = "my-ipv6-enabled-vpc"
  }
}
```

---

### **Features**

- Supports IPv4 and IPv6 CIDR block configurations.
- Integration with AWS IP Address Manager (IPAM) pools for CIDR allocations.
- DNS support and hostname management options.
- Support for assigning Amazon-provided IPv6 CIDR blocks.
- Customizable instance tenancy (default or dedicated).
- Tagging for resource organization.

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

| **File**       | **Description**                                                         |
| -------------- | ----------------------------------------------------------------------- |
| `main.tf`      | Defines the core AWS VPC resource.                                      |
| `variables.tf` | Specifies input variables for customizing the VPC configuration.        |
| `outputs.tf`   | Exports key attributes of the VPC for use in other Terraform resources. |

---

### **Inputs**

| **Name**                               | **Description**                                                                | **Type**      | **Default** | **Required** |
| -------------------------------------- | ------------------------------------------------------------------------------ | ------------- | ----------- | ------------ |
| `cidr_block`                           | The CIDR block for the VPC.                                                    | `string`      | N/A         | Yes          |
| `instance_tenancy`                     | Tenancy option for instances launched into the VPC (`default` or `dedicated`). | `string`      | `default`   | No           |
| `ipv4_ipam_pool_id`                    | The ID of an IPv4 IPAM pool for allocating this VPC's CIDR.                    | `string`      | `null`      | No           |
| `ipv4_netmask_length`                  | The netmask length of the IPv4 CIDR from the IPAM pool.                        | `number`      | `null`      | No           |
| `ipv6_cidr_block`                      | IPv6 CIDR block to assign to the VPC.                                          | `string`      | `null`      | No           |
| `ipv6_ipam_pool_id`                    | The ID of an IPv6 IPAM pool for CIDR allocation.                               | `string`      | `null`      | No           |
| `ipv6_netmask_length`                  | The netmask length of the IPv6 CIDR from the IPAM pool.                        | `number`      | `null`      | No           |
| `ipv6_cidr_block_network_border_group` | Sets the region of the IPv6 CIDR block.                                        | `string`      | `null`      | No           |
| `enable_dns_hostnames`                 | Enable or disable DNS hostname resolution.                                     | `bool`        | `false`     | No           |
| `enable_dns_support`                   | Enable or disable DNS support in the VPC.                                      | `bool`        | `true`      | No           |
| `enable_network_address_usage_metrics` | Enable Network Address Usage metrics for the VPC.                              | `bool`        | `false`     | No           |
| `assign_generated_ipv6_cidr_block`     | Automatically assign an Amazon-provided IPv6 CIDR block.                       | `bool`        | `false`     | No           |
| `tags`                                 | A map of tags to assign to the VPC resource.                                   | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**                    | **Description**                                             |
| --------------------------- | ----------------------------------------------------------- |
| `id`                        | The ID of the VPC.                                          |
| `arn`                       | The Amazon Resource Name (ARN) of the VPC.                  |
| `cidr_block`                | The CIDR block of the VPC.                                  |
| `instance_tenancy`          | Tenancy option for instances launched in the VPC.           |
| `enable_dns_support`        | Indicates if DNS support is enabled.                        |
| `enable_dns_hostnames`      | Indicates if DNS hostname resolution is enabled.            |
| `main_route_table_id`       | The ID of the main route table associated with the VPC.     |
| `default_network_acl_id`    | The ID of the default network ACL created with the VPC.     |
| `default_security_group_id` | The ID of the default security group created with the VPC.  |
| `default_route_table_id`    | The ID of the default route table created with the VPC.     |
| `ipv6_association_id`       | The association ID for the IPv6 CIDR block (if applicable). |
| `ipv6_cidr_block`           | The assigned IPv6 CIDR block (if applicable).               |
| `owner_id`                  | The ID of the AWS account that owns the VPC.                |

---

### **Examples**

#### Create a VPC with IPAM-Allocated CIDR

```hcl
module "vpc_with_ipam" {
  source = "./vpc"

  ipv4_ipam_pool_id  = "ipam-pool-0abcd1234efgh5678"
  ipv4_netmask_length = 24
  tags = {
    Name = "ipam-vpc"
  }
}
```

#### Enable Network Address Usage Metrics

```hcl
module "vpc_with_metrics" {
  source = "./vpc"

  cidr_block                       = "10.1.0.0/16"
  enable_network_address_usage_metrics = true
  tags = {
    Name = "vpc-with-metrics"
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
