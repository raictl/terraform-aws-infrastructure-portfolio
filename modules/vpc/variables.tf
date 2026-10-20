
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Two Availability Zones for the network"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Exactly two Availability Zones must be provided."
  }
}

variable "environment" {
  description = "Environment name, such as dev or prod"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource tags"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT gateway for outbound internet access from application subnets"
  type        = bool
  default     = true
}
