variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance (e.g., t2.micro, t2.medium, t3.large)"
  type        = string

  validation {
    condition     = contains(["t2.micro", "t2.medium", "t3.large"], var.instance_type)
    error_message = "Instance type must be one of: t2.micro, t2.medium, t3.large."
  }
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string

  validation {
    condition     = can(regex("^ami-[a-zA-Z0-9]{8,}$", var.instance_ami))
    error_message = "Must be a valid AMI ID starting with 'ami-'."
  }
}

variable "instance_storage" {
  description = "The storage size in GB for the EC2 instance"
  type        = number

  validation {
    condition     = var.instance_storage <= 30 && var.instance_storage >= 8
    error_message = "To minimize charges, storage must be between 8 and 30 GB."
  }
}

variable "instance_key_pair" {
  description = "The name of the SSH key pair for the EC2 instance"
  type        = string

  validation {
    condition     = length(var.instance_key_pair) > 1
    error_message = "Please provide a valid key pair name."
  }
}

variable "instance_key_pair_location" {
  description = "The local path to the private key file for SSH access"
  type        = string
}

variable "env" {
  description = "The deployment environment (e.g., dev, staging, production)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "production", "test"], var.env)
    error_message = "Environment must be one of: dev, staging, production, test."
  }
}

variable "subnet_id" {
  description = "This is for a subnet id"
  type        = string
}

variable "vpc_id" {
  description = "This is for a vpc id"
  type        = string
}

# this will we defualt we dnot take this in module code 
variable "instance_security_group_name" {
  description = "this is the worker security group"
  type        = string
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  description = "List of ingress rules for security group"
}