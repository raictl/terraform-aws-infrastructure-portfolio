
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "terraform-aws-infrastructure-portfolio"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}

