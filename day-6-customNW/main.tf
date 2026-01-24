#vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "myvpc"
    }
  
}
#subnet
resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "publicsn"
  }
    cidr_block = "10.0.0.0/24"
  
}
#internetgateway
resource "aws_internet_gateway" "name" {
  tags = {
    Name = "myvpcig"
  }
  vpc_id = aws_vpc.name.id
}
#route table
resource "aws_route_table" "name" {
  tags = {
    Name = "myrt"
    }
 
 vpc_id =  aws_vpc.name.id
 route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
 }
}

#route table association
resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.name.id
  route_table_id = aws_route_table.name.id
}
#securitygroup
resource "aws_security_group" "name" {
    tags = {
      Name = "mysg"
    }
  description = "allow"
  vpc_id = aws_vpc.name.id
 
  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress{
    description = "tls from vpc"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

egress {
    
    from_port = 0
    to_port = 0
    protocol = "-1"  #allow all
    cidr_blocks = ["0.0.0.0/0"]
}

}
#instance
resource "aws_instance" "name" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.name.id]
   subnet_id = aws_subnet.name.id
  
}