# AWS VPC Endpoint Route Table Association Module

Manages a VPC Endpoint Route Table Association.

## Example Usage

```hcl
module "example" {
  source = "./modules/vpc-endpoint-route-table-association"

  vpc_endpoint_id = aws_vpc_endpoint.example.id
  route_table_id  = aws_route_table.example.id
}
```

## Argument Reference

- `vpc_endpoint_id` — (Required) Identifier of the VPC Endpoint with which the EC2 Route Table will be associated.
- `route_table_id` — (Required) Identifier of the EC2 Route Table to be associated with the VPC Endpoint.

## Attribute Reference

- `id` — A hash of the EC2 Route Table and VPC Endpoint identifiers.

## Import

Can be imported using `vpc_endpoint_id` together with `route_table_id`, e.g.:

```console
terraform import module.example.aws_vpc_endpoint_route_table_association.this vpce-aaaaaaaa/rtb-bbbbbbbb
```
