resource "aws_instance" "machine" {
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.security.id]
  instance_type               = var.instance_type
  ami                         = var.instance_ami
  depends_on                  = [aws_key_pair.key_pair, aws_security_group.security, var.vpc_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name        = var.instance_name
    Environment = var.env
  }

  instance_market_options {
    market_type = "spot"

    spot_options {
      spot_instance_type             = "one-time"  # or "persistent"
      instance_interruption_behavior = "terminate" # or "stop", "hibernate"
    }
  }

  lifecycle {
    create_before_destroy = true

    precondition {
      condition     = contains(["t2.micro", "t2.medium", "t3.large"], var.instance_type) && var.instance_storage >= 8 && var.instance_storage <= 30
      error_message = "Instance type must be one of t2.micro, t2.medium, t3.large and storage size must be between 8 and 30 GB."
    }

    postcondition {
      condition     = self.public_ip != ""
      error_message = "The EC2 instance did not receive a public IP address."
    }
  }

  root_block_device {
    volume_size           = var.instance_storage
    volume_type           = "gp3"
    delete_on_termination = true
  }
}
