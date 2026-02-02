resource "aws_vpc" "main" {
  tags = {
     Name = "myvpc"
  }
  cidr_block = "10.0.0.0/16"
}
resource "aws_security_group" "example" {
  name   = "example-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each = toset(var.allowed_ports)

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.example.id
}