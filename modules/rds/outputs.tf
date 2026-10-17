output "db_instance_identifier" {
  description = "Identifier of the RDS PostgreSQL instance"
  value       = aws_db_instance.postgres.identifier
}

output "db_endpoint" {
  description = "Network endpoint of the RDS PostgreSQL instance"
  value       = aws_db_instance.postgres.endpoint
}

output "db_address" {
  description = "Hostname of the RDS PostgreSQL instance"
  value       = aws_db_instance.postgres.address
}

output "db_port" {
  description = "Port used by the PostgreSQL database"
  value       = aws_db_instance.postgres.port
}
