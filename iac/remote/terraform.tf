# Configure the Terraform to use the aws and remote backend if used

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

