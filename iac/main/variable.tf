# =============================================================================
# INPUT VARIABLES
# =============================================================================

variable "region" {
  description = "this is a var for aws region"
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for instances"
  type        = string
}

variable "instance_storage" {
  description = "Size of instance storage"
  type        = number
}

variable "key_pair_location" {
  description = "Path to the SSH key pair"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.33"
}

variable "eks_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
}

variable "instance_types" {
  description = "Instance types for different node roles"
  type        = map(string)
  default = {
    master    = "t2.medium"
    worker_cd = "t2.micro"
    worker_ci = "t3.large"
  }

  validation {
    condition = alltrue([
      for instance_type in values(var.instance_types) :
      can(regex("^[a-z][0-9]+[a-z]*\\.(nano|micro|small|medium|large|xlarge|[0-9]+xlarge)$", instance_type))
    ])
    error_message = "All instance types must be valid AWS instance types (e.g., t2.micro, m5.large, c5.xlarge)."
  }
}
