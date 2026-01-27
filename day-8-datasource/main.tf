data "aws_vpc" "name" {
    filter {
    name   = "tag:Name"
    values = ["myvpc"] # insert value here
  }
}
data "aws_subnet" "name" {
  vpc_id = data.aws_vpc.name.id
  filter {
    name = "tag:Name"
    values = [ "public" ]
  }

}
resource "aws_instance" "name" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.name.id
}