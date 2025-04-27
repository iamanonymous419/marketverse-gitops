# variables.tf

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

variable "env" {
  description = "Environment name"
  type        = string
}

variable "key_pair_location" {
  description = "Path to the SSH key pair"
  type        = string
}

# for EKS cluster
variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}