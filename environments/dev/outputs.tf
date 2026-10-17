output "vpc_id" {
  description = "ID of the development VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = module.vpc.app_subnet_ids
}

output "db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = module.vpc.db_subnet_ids
}

output "nat_gateway_id" {
  description = "ID of the development NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group"
  value       = module.compute.autoscaling_group_name
}

output "db_instance_identifier" {
  description = "Identifier of the PostgreSQL database"
  value       = module.rds.db_instance_identifier
}

output "db_endpoint" {
  description = "Endpoint of the private PostgreSQL database"
  value       = module.rds.db_endpoint
}
