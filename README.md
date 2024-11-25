# Terraform Modules Repository

This repository contains a collection of Terraform modules designed to help manage AWS infrastructure efficiently. Each module is standalone and serves a specific purpose, allowing users to mix and match as needed to build scalable and robust cloud environments. The repository adheres to Terraform's modular architecture, promoting reusability, maintainability, and clarity.

## Table of Contents

1. [Overview](#overview)
2. [Modules](#modules)
3. [Getting Started](#getting-started)
4. [Usage](#usage)
5. [Contributing](#contributing)
6. [License](#license)

---

## Overview

This repository contains Terraform modules for various AWS services and components. Each module is structured with the following files:

- **`main.tf`**: Defines the main Terraform resources.
- **`variables.tf`**: Contains input variables to configure the module.
- **`outputs.tf`**: Defines output values for the module.
- **`README.md`**: Provides detailed usage instructions and examples for each module.

The modules cover a wide range of AWS services, such as networking, compute, storage, databases, and monitoring.

---

## Modules

Below is the list of modules included in this repository:

- **Networking:**

  - `vpc` - Manage AWS Virtual Private Clouds.
  - `subnets` - Create subnets within a VPC.
  - `route_table`, `route` - Manage route tables and routes.
  - `internet_gateway` - Attach Internet Gateways to VPCs.
  - `nat_gateway` - Deploy NAT Gateways.
  - `network_acl` - Configure Network ACLs and rules.

- **Compute:**

  - `ec2` - Launch EC2 instances.
  - `autoscaling_group` - Manage EC2 Auto Scaling Groups.
  - `launch_template` - Create EC2 Launch Templates.
  - `eks` - Deploy Amazon Elastic Kubernetes Service.
  - `ecs_fargate` - Manage ECS Fargate clusters.

- **Storage:**

  - `s3_bucket` - Create and manage S3 buckets.
  - `efs` - Manage Elastic File System resources.
  - `ebs_volume` - Provision Elastic Block Store volumes.

- **Databases:**

  - `db_instance` - Provision RDS instances.
  - `db_subnet_group` - Manage subnet groups for RDS.
  - `db_parameter_group` - Configure database parameter groups.
  - `dynamodb` - Manage DynamoDB tables.

- **IAM:**

  - `iam_role`, `iam_user`, `iam_group` - Manage IAM roles, users, and groups.
  - `iam_policy_document` - Create custom IAM policies.

- **Load Balancers:**

  - `alb` - Configure Application Load Balancers.
  - `lb_listener`, `lb_target_group` - Manage load balancer listeners and target groups.

- **Monitoring & Alerts:**

  - `cloudwatch` - Configure CloudWatch dashboards and alarms.
  - `cloudwatch_log_group` - Manage CloudWatch log groups.
  - `cloudwatch_metric_alarm` - Set up CloudWatch alarms.

- **Others:**
  - `kms` - Manage AWS Key Management Service keys.
  - `sns_topic` - Create and manage SNS topics.
  - `sqs_queue` - Provision SQS queues.
  - `secretsmanager_secret` - Store and manage secrets using AWS Secrets Manager.
  - `amplify_app` - Deploy AWS Amplify applications.

---

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/) (v1.0 or later)
- AWS credentials configured in your environment
- Basic knowledge of Terraform and AWS services

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/terraform-modules.git
   cd terraform-modules
   ```

2. Navigate to the desired module's directory:
   ```bash
   cd vpc
   ```

---

## Usage

### Example: VPC Module

Below is an example of how to use the `vpc` module to create a VPC with DNS support:

```hcl
module "vpc" {
  source = "github.com/davidshare/terraform-aws-modules//vpc?ref=vpc-v1.0.0"

  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
    Env  = "production"
  }
}
```

### Example: S3 Bucket Module

```hcl
module "s3_bucket" {
  source = "github.com/davidshare/terraform-aws-modules//s3?ref=s3-v1.0.0"

  bucket_name = "my-example-bucket"
  tags = {
    Name = "example"
    Env  = "development"
  }
}
```

### Terraform Workflow

1. Initialize the module:

   ```bash
   terraform init
   ```

2. Plan the infrastructure:

   ```bash
   terraform plan
   ```

3. Apply the changes:

   ```bash
   terraform apply
   ```

4. View outputs:
   ```bash
   terraform output
   ```

---

## Contributing

We welcome contributions to improve the modules or add new ones! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/my-feature
   ```
3. Commit changes and push to your branch:
   ```bash
   git push origin feature/my-feature
   ```
4. Create a pull request.

### Making changes to individual modules

There are two approaches to making changes to the individual modules

**Approach 1**

- make your changes in the master branch
- commit your changes
- switch to the branch with the module you want to update. Example: `git checkout vpc-module`
- update the module you made the changes in. Example: `git checkout master -- vpc/`
- before you run the previous command, make sure you are in the branch where you want the changes, not the branch where the change was made.
- In the example, the master branch is where the change was made, but we are in the vpc-module branch.

**Approach 2**

- make your changes in the branch that contains the module
- commit your changes and create your release. Follow the steps below to update the master branch with your changes.
- switch to the master branch. Example: `git checkout master`
- update the master branch with changes from your module branch. Example: `git checkout vpc-module -- vpc/`
- before you run the previous command, make sure you are in the master branch.
- In the example, the vpc-module branch is where the change was made, but we are in the master branch.

---

## Creating a Release

Each module in the repository has a corresponding branch with the format `<directory_name>-module`. for example, vpc-module, lb_listener-module.
The repository contains a github action in the .github.workflow directory that is use for creating releases.

### To create a release

- switch to the branch that contains the module
- create a tag with the commit that has the changes you want release
- the format of the tag is `<directory_name>-v<version_number>` example: `vpc-v1.0.0` or `lb_listener-v2.0.4`

## License

This repository is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this repository as per the license terms.

---

## Feedback

If you encounter any issues or have suggestions, feel free to open an issue in the repository.

Happy Terraforming! 🌐
