

variable "remote_bucket_name" {
  description = "this is a var for remote bucket name"
  type        = string
  default     = "remote-bucket-for-marketverse"
}

variable "remote_table_name" {
  description = "this is a var for remote table name"
  type        = string
  default     = "remote_table"
}

variable "region" {
  description = "this is a var for aws region"
  type        = string
  default     = "ap-south-1"
}

variable "env" {
  type        = string
  description = "to store the key pair location"
  default     = "test"
}