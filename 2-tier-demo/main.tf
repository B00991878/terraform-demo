module "vpc" {
  source                    = "./modules/vpc"
  project_name              = var.project_name
  public_subnet_cidr        = [cidrsubnet(var.vpc_cidr, 8, 1)]
  public_availability_zone  = ["us-east-1a"]
  private_subnet_cidr       = [cidrsubnet(var.vpc_cidr, 8, 2), cidrsubnet(var.vpc_cidr, 8, 3)]
  private_availability_zone = ["us-east-1b", "us-east-1c"]
  environment               = var.environment
  region                    = var.region
}

module "sg" {
  source       = "./modules/sg"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = var.environment
}

module "rds" {
  source               = "./modules/rds"
  private_subnet_ids   = module.vpc.private_subnet_id
  environment          = var.environment
  db_name              = var.db_name
  db_username          = var.db_username
  parameter_group_name = var.parameter_group_name
  project_name         = var.project_name
  db_security_group_id = module.sg.db_sg_id
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.storage_type
}

module "secrets" {
  source       = "./modules/secret"
  db_host      = module.rds.db_address
  db_password  = module.rds.db_password
  db_username  = module.rds.db_username
  db_name      = module.rds.db_name
  db_port      = module.rds.db_port
  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source             = "./modules/iam"
  project_name       = var.project_name
  environment        = var.environment
  db_credentials_arn = module.secrets.db_credentials_arn
}

module "ec2" {
  source                    = "./modules/ec2"
  project_name              = var.project_name
  environment               = var.environment
  region                    = var.region
  public_subnet_id          = module.vpc.public_subnet_id[0]
  web_security_group_id     = module.sg.web_sg_id
  db_credentials_arn        = module.secrets.db_credentials_arn
  iam_instance_profile_name = module.iam.ec2_instance_profile_arn
  instance_type             = var.ec2_instance_type

}