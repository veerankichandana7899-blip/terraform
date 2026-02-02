resource "aws_instance" "name" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  user_data = file("data.sh")
}