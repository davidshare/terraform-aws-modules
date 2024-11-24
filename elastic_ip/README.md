# AWS Terraform Module: Elastic IP

## Brief Description

This AWS Terraform module manages the allocation and association of Elastic IP (EIP) addresses for use with EC2 instances and network interfaces within a VPC. It supports optional configurations like associating EIPs with private IP addresses, customer-owned IP pools, and IPAM pools, providing flexibility in managing network resources.

---

## Usage

### Example Configuration

```hcl
module "elastic_ip" {
  source                   = "./elastic_ip"
  domain                   = "vpc"
  instance_id              = "i-0abcd1234efgh5678"
  associate_with_private_ip = "10.0.0.10"
  tags = {
    Environment = "Production"
    Owner       = "Network Team"
  }
}
```

### Explanation of Key Parameters

- **`domain`**: Specifies the domain for the Elastic IP address (typically "vpc" for use in VPC).
- **`instance_id`**: EC2 instance ID to associate the Elastic IP with (optional).
- **`network_interface`**: Network interface ID to associate the Elastic IP with (optional).
- **`associate_with_private_ip`**: Private IP address to associate with the Elastic IP (optional).
- **`tags`**: A map of tags to assign to the Elastic IP for management and organization.

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

## Features

- Allocates and associates Elastic IPs with EC2 instances or network interfaces.
- Supports associating EIPs with private IP addresses.
- Allows use of customer-owned IP pools and IPAM pools.
- Provides flexibility in specifying domain and network border group.
- Tags all resources for better management.

---

## Explanation of Files

| **File**       | **Description**                                                                                        |
| -------------- | ------------------------------------------------------------------------------------------------------ |
| `main.tf`      | Defines the `aws_eip` resource, including configuration for allocation and association of Elastic IPs. |
| `variables.tf` | Declares input variables to configure the Elastic IP resource.                                         |
| `outputs.tf`   | Provides outputs such as allocation ID, association ID, and public IP address.                         |
| `README.md`    | Documentation for the module.                                                                          |

---

## Inputs

| **Variable**                | **Description**                                                 | **Type**      | **Default** | **Required** |
| --------------------------- | --------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `domain`                    | Indicates if the EIP is for use in VPC (use 'vpc').             | `string`      | `"vpc"`     | No           |
| `instance_id`               | EC2 instance ID to associate the Elastic IP with (optional).    | `string`      | `null`      | No           |
| `network_interface`         | Network interface ID to associate with (optional).              | `string`      | `null`      | No           |
| `associate_with_private_ip` | Private IP address to associate with the Elastic IP (optional). | `string`      | `null`      | No           |
| `customer_owned_ipv4_pool`  | ID of a customer-owned IP address pool (optional).              | `string`      | `null`      | No           |
| `ipam_pool_id`              | The ID of an IPAM pool to allocate the IP from (optional).      | `string`      | `null`      | No           |
| `network_border_group`      | Location from which the IP address is advertised (optional).    | `string`      | `null`      | No           |
| `public_ipv4_pool`          | EC2 IPv4 address pool identifier (optional).                    | `string`      | `null`      | No           |
| `tags`                      | A map of tags to apply to the Elastic IP resource.              | `map(string)` | `{}`        | No           |

---

## Outputs

| **Output**          | **Description**                                                                   |
| ------------------- | --------------------------------------------------------------------------------- |
| `allocation_id`     | ID that AWS assigns to represent the allocation of the Elastic IP address.        |
| `association_id`    | ID representing the association of the EIP with an instance or network interface. |
| `carrier_ip`        | Carrier IP address if applicable.                                                 |
| `customer_owned_ip` | Customer-owned IP address if applicable.                                          |
| `public_ip`         | Public IP address assigned to the instance or network interface.                  |
| `private_ip`        | Private IP address associated with the Elastic IP address.                        |
| `ptr_record`        | DNS PTR record for the IP address.                                                |
| `public_dns`        | Public DNS associated with the Elastic IP address.                                |
| `private_dns`       | Private DNS associated with the Elastic IP address.                               |

---

## Example Usage

### Basic Elastic IP Association

```hcl
module "elastic_ip_basic" {
  source      = "./elastic_ip"
  instance_id = "i-0abcd1234efgh5678"
  tags = {
    Environment = "Staging"
    Owner       = "Network Team"
  }
}
```

### Elastic IP with Customer-Owned IP

```hcl
module "elastic_ip_customer_owned" {
  source                   = "./elastic_ip"
  domain                   = "vpc"
  customer_owned_ipv4_pool = "pool-abc123"
  tags = {
    Environment = "Production"
    Owner       = "Network Team"
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See `LICENSE` for more information.
