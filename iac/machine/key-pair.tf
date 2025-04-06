# first create a key pair

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.instance_key_pair}_key_pair"
  public_key = file(var.instance_key_pair_location)

  tags = {
    Name        = "${var.instance_key_pair}_key_pair"
    Envirnoment = var.env
  }
}