variable "vpc_id" {
  description = "ID of the VPC where the ALB and target group will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the Application Load Balancer"
  type        = map(string)
}

variable "alb_security_group_id" {
  description = "Security group ID attached to the ALB"
  type        = string
}

variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 80
}

variable "environment" {
  description = "Environment name, such as dev or prod"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}
