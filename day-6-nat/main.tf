

# --------------------
# VPC
# --------------------
resource "aws_vpc" "natvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "natvpc"
  }
}

# --------------------
# Internet Gateway
# --------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.natvpc.id

  tags = {
    Name = "myig"
  }
}

# --------------------
# Public Subnet
# --------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.natvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsn"
  }
}

# --------------------
# Private Subnet
# --------------------
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.natvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "pvtsn"
  }
}

# --------------------
# Public Route Table
# --------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.natvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# --------------------
# Elastic IP for NAT
# --------------------
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# --------------------
# NAT Gateway (MUST be in public subnet)
# --------------------
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "natgw"
  }
}

# --------------------
# Private Route Table (NAT)
# --------------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.natvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

# --------------------
# Security Group
# --------------------
resource "aws_security_group" "ec2_sg" {
  vpc_id     = aws_vpc.natvpc.id
  name       = "secg"
  description = "allow ssh and http"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secg"
  }
}


# --------------------
# Public EC2
# --------------------
resource "aws_instance" "public_ec2" {
  ami                         = "ami-07ff62358b87c7116"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = "mytest"
  associate_public_ip_address = true

  tags = {
    Name = "public-ec2"
  }
}

# --------------------
# Private EC2
# --------------------
resource "aws_instance" "private_ec2" {
  ami                    = "ami-07ff62358b87c7116"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "mytest"

  tags = {
    Name = "private-ec2"
  }
}
