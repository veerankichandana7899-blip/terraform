resource "aws_vpc" "name" {
  tags = {
    Name = "myvpc"
  }
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "public" {
 vpc_id =aws_vpc.name.id
 tags = {
  Name = "public"
 }
 cidr_block = "10.0.0.0/24"
 availability_zone = "us-east-1a"
}
resource "aws_subnet" "pvt" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "private"
  }
  cidr_block = "10.0.1.0/24"
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
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}
resource "aws_db_instance" "default" {
  allocated_storage       = 10
   identifier =             "myrds"
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0.43"
  instance_class          = "db.t3.micro"
  manage_master_user_password = true #rds and secret manager manage this password
  username                    = "admin"
  db_subnet_group_name    = aws_db_subnet_group.name.id
  parameter_group_name    = "default.mysql8.0"
  backup_retention_period  = 0   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable performance insights
#   performance_insights_enabled          = true
#   performance_insights_retention_period = 7  # Retain insights for 7 days
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)
  deletion_protection = false
  skip_final_snapshot = true
  publicly_accessible = false
  depends_on = [ aws_db_subnet_group.name]
}