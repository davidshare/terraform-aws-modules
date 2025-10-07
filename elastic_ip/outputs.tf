output "allocation_id" {
  description = "ID that AWS assigns to represent the allocation of the Elastic IP address for use with instances in a VPC"
  value       = aws_eip.this.allocation_id
}

output "association_id" {
  description = "ID representing the association of the address with an instance in a VPC"
  value       = aws_eip.this.association_id
}

output "carrier_ip" {
  description = "Carrier IP address if applicable"
  value       = aws_eip.this.carrier_ip
}

output "customer_owned_ip" {
  description = "Customer-owned IP address if applicable"
  value       = aws_eip.this.customer_owned_ip
}

output "public_ip" {
  description = "Public IP address assigned to the instance or network interface"
  value       = aws_eip.this.public_ip
}

output "private_ip" {
  description = "Private IP address associated with the Elastic IP address"
  value       = aws_eip.this.private_ip
}

output "ptr_record" {
  description = "DNS PTR record for the IP address"
  value       = aws_eip.this.ptr_record
}

output "public_dns" {
  description = "Public DNS associated with the Elastic IP address"
  value       = aws_eip.this.public_dns
}

output "private_dns" {
  description = "Private DNS associated with the Elastic IP address"
  value       = aws_eip.this.private_dns
}
