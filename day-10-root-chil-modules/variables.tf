variable "vpc_name" {
type = string
default = "myvpc"

}
variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  type = string
  default = "10.0.0.0/24"
}
variable "az" {
  type = string
  default = "us-east-1a"
}
  variable "ami_id" {
    type = string
    default = "ami-07ff62358b87c7116"
  }
  variable "instance_type" {
    type = string
    default = "t3.micro"
  }
variable "instance_class" {
  type = string
  default = "db.t3.micro"
}
variable "db_name" {
  type = string
  default = "madhu"
}
variable "db_user" {
  type = string
  default = "admin"

}
variable "db_password" {
  type = string
  default = "madhudileep"
}