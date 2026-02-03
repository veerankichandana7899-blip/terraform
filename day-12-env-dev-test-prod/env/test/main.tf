module "ec2" {
  source = "../../modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vpc.private_subnet_ids[0]
  env = var.env
}
module "rds" {
    source = "../../modules/rds"
subnet_ids = module.vpc.private_subnet_ids
instance_class = var.instance_class
db_name = var.db_name
db_user = var.db_user
db_password = var.db_password
env = var.env
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr              = var.vpc_cidr
  private_subnet_cidrs  = var.private_subnet_cidrs
  azs                   = var.azs
  env                   = var.env
}