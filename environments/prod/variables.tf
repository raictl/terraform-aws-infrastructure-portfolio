
variable "aws_region" {
  description = "AWS region for the production environment"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "prod"

  validation {
    condition     = var.environment == "prod"
    error_message = "The production configuration must use environment = prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the production VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones used by the production network"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "project_name" {
  description = "Project identifier used for resource naming and tags"
  type        = string
  default     = "terraform-aws-infrastructure-portfolio"
}

