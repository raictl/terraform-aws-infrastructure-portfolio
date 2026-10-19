terraform {
  backend "s3" {
    key          = "terraform-aws-infrastructure-portfolio/prod/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
