# this is a table for manage the tf state of terraform 

resource "aws_dynamodb_table" "remote_table" {
  name         = var.remote_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.remote_table_name
    Envirnoment = var.env
  }
}