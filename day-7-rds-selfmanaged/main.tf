data "aws_secretsmanager_secret" "db" {
  name = "mydb-secret"
}
data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}
resource "aws_db_instance" "default" {
  identifier = "myrds"
  db_name    = "mydb"

  engine         = "mysql"
  engine_version = "8.0.43"
  instance_class = "db.t3.micro"

  allocated_storage = 10

  username = jsondecode( data.aws_secretsmanager_secret_version.db.secret_string)["username"]

  password = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["password"]

  db_subnet_group_name   = aws_db_subnet_group.name.id
  vpc_security_group_ids = [aws_security_group.name.id]

  publicly_accessible     = false
  backup_retention_period = 0
  skip_final_snapshot     = true
}
resource "aws_vpc" "name" {
  tags = {
    Name = "myvpc"
  }
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "public"
  }
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "pvt" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "private"
  }
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}
resource "aws_db_subnet_group" "name" {

  name       = "main"
  subnet_ids = [aws_subnet.public.id, aws_subnet.pvt.id]

  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_security_group" "name" {
  tags = {
    Name = "mysg"
  }
  vpc_id = aws_vpc.name.id
  ingress {
    description = "all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}