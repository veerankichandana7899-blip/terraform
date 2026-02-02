resource "aws_instance" "name" {
 ami = "ami-07ff62358b87c7116"
 instance_type = "t3.micro"
 count = 3
 tags = {
   Name = "madhu - ${count.index}"
 }
}

# o/p will be 3 instances with names madhu-0 madhu-1 madhu-2