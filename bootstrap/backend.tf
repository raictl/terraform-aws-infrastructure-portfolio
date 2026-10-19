terraform {
  backend "s3" {
    key          = "terraform-aws-infrastructure-portfolio/bootstrap/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
