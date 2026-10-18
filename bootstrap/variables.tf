variable "aws_region" {
  description = "AWS region where the Terraform state bucket will reside"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
  default     = "terraform-aws-infrastructure-portfolio"
}
