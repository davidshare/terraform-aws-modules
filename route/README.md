# AWS Route Module

This module creates a single routing table entry (route) within an AWS VPC routing table using the `aws_route` resource.

## Requirements

- Terraform 0.12+
- AWS Provider

## Usage

```hcl
module "route" {
  source                    = "./path_to_route_module"
  route_table_id            = aws_route_table.example.id
  destination_cidr_block    = "10.0.1.0/22"
  gateway_id                = aws_internet_gateway.example.id
}
```

## Argument Reference

- `route_table_id` - (Required) The ID of the routing table to add the route to.
- **Destination Arguments** (One required):
  - `destination_cidr_block` - (Optional) The destination IPv4 CIDR block.
  - `destination_ipv6_cidr_block` - (Optional) The destination IPv6 CIDR block.
  - `destination_prefix_list_id` - (Optional) The ID of a managed prefix list for the route destination.
- **Target Arguments** (One required):
  - `carrier_gateway_id` - (Optional) ID of a carrier gateway for Wavelength Zone subnets.
  - `core_network_arn` - (Optional) ARN of a core network.
  - `egress_only_gateway_id` - (Optional) ID of a VPC egress-only internet gateway.
  - `gateway_id` - (Optional) ID of a VPC internet or virtual private gateway. Specify "local" to update an imported local route.
  - `nat_gateway_id` - (Optional) ID of a NAT gateway.
  - `local_gateway_id` - (Optional) ID of an Outpost local gateway.
  - `network_interface_id` - (Optional) ID of an EC2 network interface.
  - `transit_gateway_id` - (Optional) ID of an EC2 transit gateway.
  - `vpc_endpoint_id` - (Optional) ID of a VPC endpoint.
  - `vpc_peering_connection_id` - (Optional) ID of a VPC peering connection.

## Notes

### Route Table Conflicts

Avoid using standalone `aws_route` and `aws_route_table` with inline routes to prevent conflicts in rule settings.

### Gateway ID

Use the correct identifier type in `gateway_id` (e.g., `internet_gateway` for public internet, `vpn_gateway` for VPNs) to avoid constant diffs due to mismatched resource types.

### Prefix List with VPC Endpoint

Use the `aws_vpc_endpoint_route_table_association` resource if associating a Gateway VPC endpoint with a destination prefix list.

## Outputs

- `route_id` - The ID of the route created in the route table.

## License

MIT License. See `LICENSE` for details.
