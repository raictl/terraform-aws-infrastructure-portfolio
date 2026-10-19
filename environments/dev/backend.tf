terraform {
  backend "s3" {
    key          = "terraform-aws-infrastructure-portfolio/dev/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
