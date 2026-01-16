# AWS VPC Endpoint Terraform Module

This Terraform module creates AWS VPC Endpoints with support for all endpoint types: Gateway, GatewayLoadBalancer, Interface, Resource, and ServiceNetwork.

## Features

- **Multiple Endpoint Types**: Supports all AWS VPC endpoint types
- **Flexible Configuration**: All optional parameters are optional, allowing for simple to complex configurations
- **Security Integration**: Built-in support for security groups and subnet associations
- **DNS Configuration**: Full support for private DNS and DNS options
- **Tag Management**: Consistent tagging across all resources
- **Cross-region Support**: Create endpoints in different regions from your VPC

## Usage

### Basic Gateway Endpoint (S3)

```hcl
module "vpc_endpoint_s3" {
  source = "./modules/vpc_endpoint"

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-2.s3"
  vpc_endpoint_type = "Gateway"
}
```

### Interface Endpoint with Security Groups

```hcl
module "vpc_endpoint_ec2" {
  source = "./modules/vpc_endpoint"

  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-west-2.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.endpoint_sg.id]
  subnet_ids         = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  private_dns_enabled = true
}
```

### Interface Endpoint with Custom IP Addresses

```hcl
module "vpc_endpoint_custom_ips" {
  source = "./modules/vpc_endpoint"

  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-west-2.ec2"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]

  subnet_configuration = [
    {
      ipv4      = "10.0.1.10"
      subnet_id = aws_subnet.example1.id
    },
    {
      ipv4      = "10.0.2.10"
      subnet_id = aws_subnet.example2.id
    }
  ]
}
```

### Gateway Load Balancer Endpoint

```hcl
module "vpc_endpoint_gwlb" {
  source = "./modules/vpc_endpoint"

  vpc_id            = aws_vpc.main.id
  service_name      = aws_vpc_endpoint_service.gwlb.service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids        = [aws_subnet.endpoint.id]
}
```

### Cross-region Service

```hcl
module "vpc_endpoint_cross_region" {
  source = "./modules/vpc_endpoint"

  region = "us-west-2"
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.us-east-2.s3"
  service_region = "us-east-2"
  vpc_endpoint_type = "Gateway"
}
```

### With IAM Policy

```hcl
module "vpc_endpoint_with_policy" {
  source = "./modules/vpc_endpoint"

  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-2.s3"
  vpc_endpoint_type = "Gateway"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "_"
        Action = ["s3:GetObject"]
        Resource = ["arn:aws:s3:::my-bucket/_"]
      }
    ]
  })
}
```

| Name                       | Description                                                                              | Type                  | Default     | Required |
| -------------------------- | ---------------------------------------------------------------------------------------- | --------------------- | ----------- | :------: |
| region                     | AWS region where the endpoint will be created                                            | `string`              | `null`      |    no    |
| vpc_id                     | ID of the VPC where the endpoint will be created                                         | `string`              | n/a         |   yes    |
| service_name               | AWS service name for the endpoint                                                        | `string`              | `null`      |    no    |
| service_network_arn        | ARN of the Service Network for ServiceNetwork endpoints                                  | `string`              | `null`      |    no    |
| resource_configuration_arn | ARN of the Resource Configuration for Resource endpoints                                 | `string`              | `null`      |    no    |
| vpc_endpoint_type          | Type of VPC endpoint (Gateway, GatewayLoadBalancer, Interface, Resource, ServiceNetwork) | `string`              | `"Gateway"` |    no    |
| auto_accept                | Automatically accept the endpoint if VPC and service are in same account                 | `bool`                | `false`     |    no    |
| policy                     | IAM policy document for endpoint access control                                          | `string`              | `null`      |    no    |
| private_dns_enabled        | Enable private DNS for interface endpoints                                               | `bool`                | `false`     |    no    |
| dns_options                | DNS configuration options                                                                | `object({...})`       | `null`      |    no    |
| ip_address_type            | IP address type (ipv4, dualstack, ipv6)                                                  | `string`              | `"ipv4"`    |    no    |
| route_table_ids            | Route table IDs for Gateway endpoints                                                    | `list(string)`        | `[]`        |    no    |
| subnet_ids                 | Subnet IDs for Interface and GatewayLoadBalancer endpoints                               | `list(string)`        | `[]`        |    no    |
| security_group_ids         | Security group IDs for Interface endpoints                                               | `list(string)`        | `[]`        |    no    |
| subnet_configuration       | Custom IP configuration for subnets                                                      | `list(object({...}))` | `[]`        |    no    |
| service_region             | Region of the endpoint service for cross-region endpoints                                | `string`              | `null`      |    no    |
| tags                       | Resource tags                                                                            | `map(string)`         | `{}`        |    no    |
| create_timeout             | Timeout for creation                                                                     | `string`              | `"10m"`     |    no    |
| update_timeout             | Timeout for updates                                                                      | `string`              | `"10m"`     |    no    |
| delete_timeout             | Timeout for deletion                                                                     | `string`              | `"10m"`     |    no    |

| Name | Description |
|------|-------------|
| id | ID of the VPC endpoint |
| arn | ARN of the VPC endpoint |
| state | State of the VPC endpoint |
| dns_entry | DNS entries for the endpoint |
| network_interface_ids | Network interface IDs for interface endpoints |
| cidr_blocks | CIDR blocks for gateway endpoints |
| prefix_list_id | Prefix list ID for gateway endpoints |
| owner_id | AWS account ID that owns the endpoint |

## Requirements
- Terraform 0.13 or newer
- AWS Provider 4.0 or newer

## Validation
Exactly one of service_name, service_network_arn, or resource_configuration_arn must be specified, depending on the endpoint type.

## Security
- Interface endpoints automatically use the VPC's default security group if none are specified

- Gateway endpoints require route table associations

- All endpoints support IAM policies for access control

## Notes
The module validates that required combinations of arguments are provided for each endpoint type

DNS options are only applicable for interface endpoints

Subnet configuration with custom IPs requires corresponding subnet_ids

