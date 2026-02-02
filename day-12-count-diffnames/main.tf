resource "aws_instance" "name" {
 ami = "ami-07ff62358b87c7116"
 instance_type = "t3.micro"
 count = length(var.env)
 tags = {
   Name = var.env[count.index]
 }
}

# o/p will be 4 instances with names madhu, kowshi, mokshi, dil
#but deletion time count will not be stable