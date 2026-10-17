
variable "aws_region" {
  description = "AWS region for the development environment"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = var.environment == "dev"
    error_message = "The development configuration must use environment = dev."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the development VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones used by the development network"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "project_name" {
  description = "Project identifier used for resource naming and tags"
  type        = string
  default     = "terraform-aws-infrastructure-portfolio"
}

