# AWS VPC Endpoint Security Group Association Module

Provides a resource to create an association between a VPC endpoint and a security group.

## Example Usage

```hcl
module "sg_association" {
  source = "./modules/vpc-endpoint-security-group-association"

  vpc_endpoint_id            = aws_vpc_endpoint.ec2.id
  security_group_id          = aws_security_group.sg.id
  replace_default_association = false
}
```

## Argument Reference

- `vpc_endpoint_id` — (Required) The ID of the VPC endpoint with which the security group will be associated.
- `security_group_id` — (Required) The ID of the security group to be associated with the VPC endpoint.
- `replace_default_association` — (Optional) Whether this association should replace the association with the VPC's default security group. At most 1 association per VPC endpoint should have this set to true. Default: false.

## Attribute Reference

- `id` — The ID of the association.

## Important Note

Do not use the same security group ID in both a VPC Endpoint Security Group Association resource and the `security_group_ids` attribute of the `aws_vpc_endpoint` resource. Doing so will cause a conflict of associations and will overwrite the association.

## Import

VPC Endpoint Security Group Associations can be imported using `vpc_endpoint_id` together with `security_group_id`, e.g.:

```console
terraform import module.sg_association.aws_vpc_endpoint_security_group_association.this vpce-aaaaaaaa/sg-bbbbbbbbbbbbbbbbb
```
