module "vpc" {
    source = "./modules/vpc"
    name = var.vpc_name
    cidr_block = var.cidr_block
    subnet_cidr = var.subnet_cidr
    az = var.az
  
}
module "ec2" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type  
    subnet_id     = module.vpc.subnet_id
}
module "rds" {
    source = "./modules/rds"
    subnet_id      = module.vpc.subnet_id
  instance_class = var.instance_class
  db_name        = var.db_name
  db_user        = var.db_user
  db_password    = var.db_password

  
}