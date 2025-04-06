# for jenkins ec2 setup
locals {
  ami_id            = "ami-0e35ddab05955cf57"
  instance_storage  = "29"
  env               = "test"
  key_pair_location = "./terra.pub"
  subnet_id         = "your-subnet"

  instance_types = {
    master    = "t2.micro"
    worker_cd = "t2.micro"
    worker_ci = "t2.medium"
  }

  key_pairs = {
    master    = "terra"
    worker_cd = "terra-worker-cd"
    worker_ci = "terra-worker-ci"
  }

  common_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    }
  ]

  master_ingress_rules = concat(local.common_ingress_rules, [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow Jenkins"
    }
  ])
}

# for eks cluster
locals {
  cluster_name = "marketverse"
  vpc_name     = "marketverse-vpc"
}