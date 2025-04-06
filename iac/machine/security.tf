resource "aws_security_group" "security" {
  name        = "${var.instance_security_group_name}_sg"
  description = "Security group for ${var.instance_name} instance"
  vpc_id      = aws_default_vpc.default.id

  # Dynamic ingress rules
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
      description = ingress.value["description"]
    }
  }

  # Outbound rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.instance_security_group_name}_sg"
    Environment = var.env
  }
}
