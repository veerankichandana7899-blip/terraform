resource "aws_instance" "name" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t3.micro"
}
resource "aws_vpc" "name" {
  tags = {
    Name = "myvpc"
  }
  cidr_block = "10.0.0.0/16"
}


# terraform plan --target=aws_vpc.name
# only vpc will be created