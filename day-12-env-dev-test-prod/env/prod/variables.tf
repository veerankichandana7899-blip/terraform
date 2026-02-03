variable "ami_id" {
  type = string
  default = ""
}
variable "instance_type" {

  
}


#=====================rds======================

variable "instance_class" {
  
}
variable "db_name" {
  
}
variable "db_user" {
  
}
variable "db_password" {
  
}

#======================VPC===================
variable "vpc_cidr" {
  type = string
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "env" {
  type = string
}
