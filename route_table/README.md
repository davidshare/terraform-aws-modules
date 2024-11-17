# Route Table Module

This Terraform module creates an AWS VPC Route Table with configurable routes, route propagation, and tagging.

## Requirements

- Terraform 0.12+
- AWS provider

## Usage

```hcl
module "route_table" {
  source = "./path_to_route_table_module"

  vpc_id = aws_vpc.example.id

  routes = [
    {
      cidr_block                 = "10.0.1.0/24"
      gateway_id                 = aws_internet_gateway.example.id
    },
    {
      ipv6_cidr_block            = "::/0"
      egress_only_gateway_id     = aws_egress_only_internet_gateway.example.id
    }
  ]

  propagating_vgws = [aws_vpn_gateway.example.id]

  tags = {
    Name = "example-route-table"
  }
}
```

### Arguments

- `vpc_id` - (Required) The ID of the VPC to create the route table in.
- `routes` - (Optional) A list of route objects with the following keys:
  - `cidr_block` - (Optional) The IPv4 CIDR block for the route.
  - `ipv6_cidr_block` - (Optional) The IPv6 CIDR block for the route.
  - `destination_prefix_list_id` - (Optional) The ID of a managed prefix list for the route destination.
  - `carrier_gateway_id` - (Optional) The carrier gateway ID.
  - `core_network_arn` - (Optional) The ARN of a core network.
  - `egress_only_gateway_id` - (Optional) The ID of an egress-only internet gateway.
  - `gateway_id` - (Optional) The ID of an internet gateway, virtual private gateway, or "local" for VPC CIDR block.
  - `local_gateway_id` - (Optional) The ID of an Outpost local gateway.
  - `nat_gateway_id` - (Optional) The ID of a NAT gateway.
  - `network_interface_id` - (Optional) The ID of an EC2 network interface.
  - `transit_gateway_id` - (Optional) The ID of a transit gateway.
  - `vpc_endpoint_id` - (Optional) The ID of a VPC endpoint.
  - `vpc_peering_connection_id` - (Optional) The ID of a VPC peering connection.

- `propagating_vgws` - (Optional) A list of virtual gateways for route propagation.
- `tags` - (Optional) A map of tags to assign to the route table.

### Outputs

- `id` - The ID of the route table.
- `arn` - The ARN of the route table.
- `owner_id` - The AWS account ID that owns the route table.
- `tags_all` - A map of tags, including those inherited from provider-level tags.

## Notes

1. **Route Table Conflicts**: The module supports inline routes, so avoid using the standalone `aws_route` resource in conjunction to avoid conflicts.
2. **gateway_id and nat_gateway_id**: Ensure correct usage of `gateway_id` for internet gateways and `nat_gateway_id` for NAT gateways to prevent permanent configuration diffs.
3. **Route Propagation**: If using `propagating_vgws`, avoid defining route propagation in `aws_vpn_gateway_route_propagation` as it could override settings.

## Example Scenario

To set up a route table with routes and propagate routes via a VPN gateway:

```hcl
module "route_table_example" {
  source = "./path_to_route_table_module"

  vpc_id = aws_vpc.main.id

  routes = [
    {
      cidr_block = "10.0.0.0/16"
      gateway_id = aws_internet_gateway.main.id
    }
  ]

  propagating_vgws = [aws_vpn_gateway.main.id]

  tags = {
    Name = "example-route-table"
  }
}
```

## License

MIT License. See `LICENSE` file for details.

