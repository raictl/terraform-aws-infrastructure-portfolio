variable "environment" {
  description = "Environment name, such as dev or prod"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}

variable "db_subnet_ids" {
  description = "Private database subnet IDs across two Availability Zones"
  type        = map(string)

  validation {
    condition     = length(var.db_subnet_ids) == 2
    error_message = "Exactly two database subnets must be provided."
  }
}

variable "db_security_group_id" {
  description = "Security group attached to the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Initial PostgreSQL database name"
  type        = string
  default     = "portfolio"
}

variable "db_username" {
  description = "Master username for the PostgreSQL database"
  type        = string
  default     = "dbadmin"
}

variable "instance_class" {
  description = "RDS DB instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Whether to protect the database from deletion"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether to skip a final snapshot when deleting the database"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 1

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "Backup retention must be between 0 and 35 days."
  }
}
