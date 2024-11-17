# AWS Launch Template Terraform Module

This Terraform module creates an AWS Launch Template with configurable options.

## Features

- Configurable instance specifications
- Support for block device mappings
- Network interface customization
- Metadata options configuration
- Tag specification support
- Monitoring configuration

## Usage

```hcl
module "launch_template" {
  source = "path/to/module"
  
  name        = "my-launch-template"
  description = "My Launch Template"
  
  instance_type = "t3.micro"
  image_id      = "ami-12345678"
  
  # Add other configuration as needed
}
```

## Requirements

| Name | Version
|-----|-----
| terraform | >= 0.13.0
| aws | >= 3.0.0


## Providers

| Name | Version
|-----|-----
| aws | >= 3.0.0


## Inputs

| Name | Description | Type | Default | Required
|-----|-----
| name | The name of the launch template | `string` | `null` | no
| name_prefix | Creates a unique name beginning with the specified prefix | `string` | `null` | no
| description | Description of the launch template | `string` | `null` | no
| default_version | Default Version of the launch template | `number` | `null` | no
| update_default_version | Whether to update Default Version each update | `bool` | `null` | no
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no
| image_id | The AMI from which to launch the instance | `string` | `null` | no
| instance_type | The type of the instance | `string` | `null` | no
| kernel_id | The kernel ID | `string` | `null` | no
| key_name | The key name to use for the instance | `string` | `null` | no
| ram_disk_id | The ID of the RAM disk | `string` | `null` | no
| vpc_security_group_ids | A list of security group IDs to associate with | `list(string)` | `null` | no
| user_data | The base64-encoded user data to provide when launching the instance | `string` | `null` | no
| block_device_mappings | Specify volumes to attach to the instance besides the volumes specified by the AMI | `any` | `[]` | no
| capacity_reservation_specification | Targeting for EC2 capacity reservations | `any` | `null` | no
| cpu_options | The CPU options for the instance | `map(string)` | `null` | no
| credit_specification | Customize the credit specification of the instance | `map(string)` | `null` | no
| disable_api_stop | If true, enables EC2 Instance Stop Protection | `bool` | `null` | no
| disable_api_termination | If true, enables EC2 Instance Termination Protection | `bool` | `null` | no
| elastic_gpu_specifications | The elastic GPU to attach to the instance | `map(string)` | `null` | no
| elastic_inference_accelerator | Configuration block containing an Elastic Inference Accelerator to attach to the instance | `map(string)` | `null` | no
| enclave_options | Enable Nitro Enclaves on launched instances | `map(bool)` | `null` | no
| hibernation_options | The hibernation options for the instance | `map(bool)` | `null` | no
| iam_instance_profile | The IAM Instance Profile to launch the instance with | `map(string)` | `null` | no
| instance_initiated_shutdown_behavior | Shutdown behavior for the instance | `string` | `null` | no
| instance_market_options | The market (purchasing) option for the instance | `any` | `null` | no
| license_specification | A list of license specifications to associate with | `map(string)` | `null` | no
| maintenance_options | The maintenance options for the instance | `map(string)` | `null` | no
| metadata_options | Customize the metadata options for the instance | `map(string)` | `null` | no
| monitoring | The monitoring option for the instance | `map(bool)` | `null` | no
| network_interfaces | Customize network interfaces to be attached at instance boot time | `list(any)` | `[]` | no
| placement | The placement of the instance | `map(string)` | `null` | no
| private_dns_name_options | The options for the instance hostname | `map(string)` | `null` | no
| tag_specifications | The tags to apply to the resources during launch | `list(any)` | `[]` | no
| tags | A map of tags to assign to the launch template | `map(string)` | `{}` | no


## Outputs

| Name | Description
|-----|-----
| id | The ID of the launch template
| arn | Amazon Resource Name (ARN) of the launch template
| latest_version | The latest version of the launch template
| tags_all | A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block


## Resource Types

This module manages the following resources:

- `aws_launch_template`


## Notes

- The launch template supports multiple versions
- Default version can be automatically updated when the template is modified
- User data must be base64 encoded before being passed to the module
- Security groups can be specified either through vpc_security_group_ids or within network_interfaces, but not both
- Block device mappings allow you to specify additional EBS volumes or instance store volumes to attach to the instance
- Capacity reservation specification allows you to target specific EC2 capacity reservations
- CPU options allow you to configure the number of CPU cores and threads per core
- Credit specification is used for T2/T3 instances to customize their CPU credit option
- Elastic GPU and Elastic Inference Accelerator options allow you to attach these resources to the instance
- Instance market options allow you to configure the instance for spot or on-demand markets
- Metadata options allow you to configure the Instance Metadata Service (IMDS) for the instance
- Network interfaces can be customized with various options including IP addresses, security groups, and more
- Placement options allow you to specify the availability zone, host resource group, and other placement details
- Tag specifications allow you to specify tags for different resource types associated with the instance


## License

This module is released under the MIT License.

## Authors

Module managed by [Your Name/Organization]

## Support

For issues and feature requests, please file an issue in the GitHub repository.