
variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Environment name, such as dev or prod"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource tags"
  type        = string
}

variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 80
}

