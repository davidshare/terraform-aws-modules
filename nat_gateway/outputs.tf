output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "nat_gateway_allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway"
  value       = aws_nat_gateway.this.allocation_id
}

output "nat_gateway_subnet_id" {
  description = "The Subnet ID of the subnet in which the NAT gateway is placed"
  value       = aws_nat_gateway.this.subnet_id
}

output "nat_gateway_network_interface_id" {
  description = "The ENI ID of the network interface created by the NAT gateway"
  value       = aws_nat_gateway.this.network_interface_id
}

output "nat_gateway_private_ip" {
  description = "The private IP address of the NAT Gateway"
  value       = aws_nat_gateway.this.private_ip
}

output "nat_gateway_public_ip" {
  description = "The public IP address of the NAT Gateway"
  value       = aws_nat_gateway.this.public_ip
}