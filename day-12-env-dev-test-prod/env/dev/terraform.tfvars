env = "dev"

vpc_cidr = "10.0.0.0/16"

private_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

azs = [
  "us-east-1a",
  "us-east-1b"
]

ami_id = "ami-07ff62358b87c7116"
instance_type      = "t3.micro"

instance_class  = "db.t3.micro"
db_name            = "madhu"
db_user            = "admin"
db_password        = "mokshithandkowshik"
