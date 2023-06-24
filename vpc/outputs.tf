output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnet[*].id
  description = "IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnet[*].id
  description = "IDs of the private subnets"
}

output "nat_gateway_ips" {
  value       = aws_eip.main[*].public_ip
  description = "Public IPs of the NAT Gateways"
}