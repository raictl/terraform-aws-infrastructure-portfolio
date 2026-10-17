locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Places the RDS database in the private database subnets.
resource "aws_db_subnet_group" "this" {
  name        = "${var.project_name}-${var.environment}-db-subnets"
  description = "Private database subnets for ${var.environment}"
  subnet_ids  = values(var.db_subnet_ids)

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-db-subnets"
    Tier = "private-db"
  })
}

# Creates a private PostgreSQL database.
resource "aws_db_instance" "postgres" {
  identifier = "${var.project_name}-${var.environment}-postgres"

  engine         = "postgres"
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.db_username

  # AWS manages the master password in Secrets Manager.
  # No database password is stored in this repository.
  manage_master_user_password = true

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.db_security_group_id]

  publicly_accessible = false
  multi_az            = var.multi_az

  backup_retention_period    = var.backup_retention_period
  auto_minor_version_upgrade = true

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project_name}-${var.environment}-final-snapshot"

  apply_immediately = false

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-postgres"
    Tier = "private-db"
  })

  lifecycle {
    prevent_destroy = false
  }
}
