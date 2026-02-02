resource "aws_instance" "name" {
  for_each = toset(var.instance_names)

  ami           = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  tags = {
    Name = each.value
  }
}