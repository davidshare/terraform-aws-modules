# AWS Elastic IP (EIP) Terraform Module

This module provides an Elastic IP (EIP) resource for AWS, allowing you to allocate an EIP and associate it with an EC2 instance or network interface. It supports various configurations, including IPAM pool allocation, BYOIP, and custom tagging.

## Usage

```hcl
module "eip" {
  source                    = "./path_to_eip_module"
  domain                    = "vpc"
  instance_id               = aws_instance.example.id
  associate_with_private_ip = "10.0.0.12"
  tags                      = {
    Name = "example-eip"
  }
}
```

## Inputs

| Name                        | Description                                                              | Type          | Default | Required |
| --------------------------- | ------------------------------------------------------------------------ | ------------- | ------- | -------- |
| `address`                   | IP address from an EC2 BYOIP pool                                        | `string`      | `null`  | no       |
| `associate_with_private_ip` | Primary or secondary private IP address to associate with the Elastic IP | `string`      | `null`  | no       |
| `customer_owned_ipv4_pool`  | ID of a customer-owned address pool                                      | `string`      | `null`  | no       |
| `domain`                    | Indicates if this EIP is for use in VPC (`vpc`)                          | `string`      | `"vpc"` | no       |
| `instance_id`               | EC2 instance ID to associate with the EIP                                | `string`      | `null`  | no       |
| `ipam_pool_id`              | ID of an IPAM pool for Amazon-provided or BYOIP public IPv4 CIDR         | `string`      | `null`  | no       |
| `network_border_group`      | Location to advertise the IP address from                                | `string`      | `null`  | no       |
| `network_interface`         | Network interface ID to associate with the EIP                           | `string`      | `null`  | no       |
| `public_ipv4_pool`          | EC2 IPv4 address pool identifier or amazon                               | `string`      | `null`  | no       |
| `tags`                      | Map of tags to assign to the resource                                    | `map(string)` | `{}`    | no       |

## Outputs

| Name                | Description                                                    |
| ------------------- | -------------------------------------------------------------- |
| `allocation_id`     | The allocation ID for the Elastic IP                           |
| `association_id`    | The association ID for the Elastic IP                          |
| `carrier_ip`        | Carrier IP address (if applicable)                             |
| `customer_owned_ip` | Customer-owned IP address (if applicable)                      |
| `id`                | ID containing the EIP allocation ID                            |
| `private_dns`       | Private DNS associated with the EIP (if in VPC)                |
| `private_ip`        | Private IP address associated with the EIP                     |
| `ptr_record`        | DNS pointer (PTR) record for the IP address                    |
| `public_dns`        | Public DNS associated with the EIP                             |
| `public_ip`         | Public IP address                                              |
| `tags_all`          | Map of tags assigned to the resource, including inherited ones |

## Example Configurations

### Single EIP Associated with an Instance

```hcl
module "eip" {
  source  = "./path_to_eip_module"
  instance_id = aws_instance.example.id
  domain      = "vpc"
}
```

### Multiple EIPs Associated with a Network Interface

```hcl
module "multi_eip" {
  source = "./path_to_eip_module"

  network_interface         = aws_network_interface.example.id
  associate_with_private_ip = "10.0.0.10"
  domain                    = "vpc"
}
```

## Requirements

- Terraform 1.0 or newer
- AWS Provider 3.0 or newer

## Notes

- Ensure the Internet Gateway exists before associating an EIP with an instance. Use `depends_on` to manage dependencies on the IGW.
- For resources like `aws_lb` or `aws_nat_gateway`, use `allocation_id` instead of `network_interface` to avoid `AuthFailure` errors.
