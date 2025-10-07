output "id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway"
  value       = aws_nat_gateway.this.allocation_id
}

output "subnet_id" {
  description = "The Subnet ID of the subnet in which the NAT gateway is placed"
  value       = aws_nat_gateway.this.subnet_id
}

output "network_interface_id" {
  description = "The ENI ID of the network interface created by the NAT gateway"
  value       = aws_nat_gateway.this.network_interface_id
}

output "private_ip" {
  description = "The private IP address of the NAT Gateway"
  value       = aws_nat_gateway.this.private_ip
}

output "public_ip" {
  description = "The public IP address of the NAT Gateway"
  value       = aws_nat_gateway.this.public_ip
}