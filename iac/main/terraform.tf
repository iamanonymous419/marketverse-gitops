# =============================================================================
# TERRAFORM AND AWS PROVIDER CONFIGURATION WITH REMOTE BACKEND
# =============================================================================

terraform {
  required_version = ">= 1.0" # Minimum required Terraform version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.92.0"
    }
  }

  # This is a remote backend code 
  # backend "s3" {
  #   bucket         = "remote-bucket-for-marketverse"
  #   key            = "terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "remote_table"
  # }
}

