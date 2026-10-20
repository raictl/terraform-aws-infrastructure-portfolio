module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
  project_name       = var.project_name
  enable_nat_gateway = true
}

module "security" {
  source = "../../modules/security"

  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name
  app_port     = 80
}

module "alb" {
  source = "../../modules/alb"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  app_port              = 80
  environment           = var.environment
  project_name          = var.project_name
}

module "compute" {
  source = "../../modules/compute"

  environment           = var.environment
  project_name          = var.project_name
  app_subnet_ids        = module.vpc.app_subnet_ids
  app_security_group_id = module.security.app_security_group_id
  target_group_arn      = module.alb.target_group_arn

  instance_type    = "t3.micro"
  min_size         = 2
  desired_capacity = 2
  max_size         = 2
}

module "rds" {
  source = "../../modules/rds"

  environment          = var.environment
  project_name         = var.project_name
  db_subnet_ids        = module.vpc.db_subnet_ids
  db_security_group_id = module.security.db_security_group_id

  db_name                 = "portfolio"
  db_username             = "dbadmin"
  instance_class          = "db.t3.micro"
  multi_az                = false
  deletion_protection     = false
  skip_final_snapshot     = true
  backup_retention_period = 1
}
