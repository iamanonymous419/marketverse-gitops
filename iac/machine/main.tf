
resource "aws_instance" "machine" {
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.security.id]
  instance_type               = var.instance_type
  ami                         = var.instance_ami
  depends_on                  = [aws_key_pair.key_pair, aws_security_group.security, var.vpc_id]
  subnet_id                   = var.subnet_id # Replace with the new subnet ID
  associate_public_ip_address = true

  tags = {
    Name        = var.instance_name
    Envirnoment = var.env
  }

  root_block_device {
    volume_size = var.instance_storage
    volume_type = "gp3"
  }
}