variable "environment" {
  description = "Environment name, such as dev or prod"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource tags"
  type        = string
}

variable "app_subnet_ids" {
  description = "Private application subnet IDs across two AZs"
  type        = map(string)

  validation {
    condition     = length(var.app_subnet_ids) == 2
    error_message = "Exactly two application subnets must be provided."
  }
}

variable "app_security_group_id" {
  description = "Security group attached to application instances"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group to register application instances with"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for application servers"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of application instances"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired number of application instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of application instances"
  type        = number
  default     = 2
}
