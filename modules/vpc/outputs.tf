
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = { for key, subnet in aws_subnet.app : key => subnet.id }
}

output "db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = { for key, subnet in aws_subnet.db : key => subnet.id }
}

output "availability_zones" {
  description = "Availability Zones used by the VPC"
  value       = var.availability_zones
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

