# AWS EC2 Instance Terraform Module

This Terraform module manages the creation and configuration of AWS EC2 instances with customizable options for networking, storage, and instance settings.

---

## **Usage**

```hcl
module "ec2_instance" {
  source                   = "./path-to-module/ec2"
  ami                      = "ami-12345678"
  instance_type            = "t2.micro"
  key_name                 = "my-key-pair"
  subnet_id                = "subnet-abcdefg"
  vpc_security_group_ids   = ["sg-12345678"]
  associate_public_ip_address = true
  tags = {
    Name        = "example-instance"
    Environment = "Production"
  }
}
```

### Key Parameters in the Example

- **`ami`**: The AMI ID used to launch the instance.
- **`instance_type`**: Specifies the type of instance (e.g., `t2.micro`, `m5.large`).
- **`key_name`**: Name of the key pair for SSH access.
- **`subnet_id`**: The subnet in which to launch the instance.
- **`vpc_security_group_ids`**: Security group IDs associated with the instance.
- **`tags`**: Tags to organize and identify resources.

---

## **Requirements**

| Requirement  | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

## **Providers**

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

## **Features**

- **Networking Customization**: Support for assigning public IPs, private IPs, and specific subnet and security group settings.
- **Block Device Management**: Configure root and additional EBS or ephemeral block devices.
- **Monitoring and Hibernation**: Enable detailed monitoring or hibernation features.
- **IAM Roles**: Attach IAM instance profiles for additional permissions.

---

## **Explanation of Files**

| File           | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| `main.tf`      | Defines the primary resource configuration for the EC2 instance.     |
| `variables.tf` | Contains input variables for parameterizing the module.              |
| `outputs.tf`   | Exposes useful outputs such as instance ID, public/private IPs, etc. |
| `README.md`    | Documentation for the module.                                        |

---

## **Inputs**

| Name                                   | Type                | Default | Required | Description                                                               |
| -------------------------------------- | ------------------- | ------- | -------- | ------------------------------------------------------------------------- |
| `ami`                                  | `string`            | N/A     | Yes      | The AMI ID to use for the EC2 instance.                                   |
| `instance_type`                        | `string`            | N/A     | Yes      | The type of EC2 instance.                                                 |
| `key_name`                             | `string`            | `null`  | No       | The key pair name for SSH access.                                         |
| `vpc_security_group_ids`               | `list(string)`      | `[]`    | No       | A list of security group IDs.                                             |
| `subnet_id`                            | `string`            | N/A     | Yes      | The VPC Subnet ID where the instance will be launched.                    |
| `associate_public_ip_address`          | `bool`              | `false` | No       | Whether to associate a public IP address.                                 |
| `availability_zone`                    | `string`            | `null`  | No       | The availability zone to launch the instance.                             |
| `disable_api_termination`              | `bool`              | `false` | No       | Whether to enable API termination protection.                             |
| `ebs_optimized`                        | `bool`              | `null`  | No       | Whether the instance is EBS-optimized.                                    |
| `get_password_data`                    | `bool`              | `false` | No       | Retrieve the Windows password data.                                       |
| `hibernation`                          | `bool`              | `false` | No       | Whether the instance supports hibernation.                                |
| `iam_instance_profile`                 | `string`            | `null`  | No       | The IAM instance profile name or ARN.                                     |
| `instance_initiated_shutdown_behavior` | `string`            | `null`  | No       | Specifies the shutdown behavior.                                          |
| `ipv6_address_count`                   | `number`            | `null`  | No       | Number of IPv6 addresses to associate with the primary network interface. |
| `ipv6_addresses`                       | `list(string)`      | `null`  | No       | List of IPv6 addresses to assign.                                         |
| `monitoring`                           | `bool`              | `false` | No       | Enable detailed monitoring.                                               |
| `placement_group`                      | `string`            | `null`  | No       | The placement group to launch the instance in.                            |
| `private_ip`                           | `string`            | `null`  | No       | Private IP address to assign to the instance.                             |
| `root_block_device`                    | `list(map(string))` | `[]`    | No       | Customize the root block device settings.                                 |
| `ebs_block_device`                     | `list(map(string))` | `[]`    | No       | Additional EBS block devices to attach to the instance.                   |
| `ephemeral_block_device`               | `list(map(string))` | `[]`    | No       | Ephemeral storage configuration.                                          |
| `user_data`                            | `string`            | `null`  | No       | User data script to configure the instance.                               |
| `tags`                                 | `map(string)`       | `{}`    | No       | Tags to assign to the instance.                                           |

---

## **Outputs**

| Name          | Description                                 |
| ------------- | ------------------------------------------- |
| `id`          | The ID of the EC2 instance.                 |
| `arn`         | The ARN of the EC2 instance.                |
| `public_ip`   | The public IP address of the EC2 instance.  |
| `private_ip`  | The private IP address of the EC2 instance. |
| `public_dns`  | The public DNS name of the EC2 instance.    |
| `private_dns` | The private DNS name of the EC2 instance.   |

---

## **Example Usage**

### Example 1: Basic EC2 Instance

```hcl
module "basic_instance" {
  source                 = "./path-to-module/ec2"
  ami                    = "ami-12345678"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-abcde123"
  vpc_security_group_ids = ["sg-12345678"]
  tags = {
    Name = "basic-instance"
  }
}
```

### Example 2: Detailed EC2 Instance with User Data and Block Devices

```hcl
module "advanced_instance" {
  source                 = "./path-to-module/ec2"
  ami                    = "ami-abcdef12"
  instance_type          = "m5.large"
  key_name               = "my-key-pair"
  subnet_id              = "subnet-xyz12345"
  vpc_security_group_ids = ["sg-87654321"]
  user_data              = file("scripts/user-data.sh")
  root_block_device = [
    {
      volume_size = 50
      volume_type = "gp3"
      encrypted   = true
    }
  ]
  ebs_block_device = [
    {
      device_name   = "/dev/sdb"
      volume_size   = 100
      volume_type   = "gp3"
      encrypted     = true
    }
  ]
  tags = {
    Name        = "advanced-instance"
    Environment = "Production"
  }
}
```

---

## **Authors**

Module maintained by [David Essien](https://davidessien.com).

---

## **License**

This project is licensed under the MIT License.
