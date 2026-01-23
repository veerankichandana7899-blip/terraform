resource "aws_instance" "name" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  tags = {
    Name =  "sample"
    }
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_vpc" "name2" {
  cidr_block = "10.0.0.0/24"
}