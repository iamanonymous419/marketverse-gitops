variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance (e.g., t2.micro, t3.medium)"
  type        = string
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_storage" {
  description = "The storage size in GB for the EC2 instance"
  type        = number
}

variable "instance_key_pair" {
  description = "The name of the SSH key pair for the EC2 instance"
  type        = string
}

variable "instance_key_pair_location" {
  description = "The local path to the private key file for SSH access"
  type        = string
}

variable "env" {
  description = "The deployment environment (e.g., dev, staging, production)"
  type        = string
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