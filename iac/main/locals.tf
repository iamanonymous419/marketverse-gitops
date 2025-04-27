# locals.tf
locals {
  instance_types = {
    master    = "t2.medium"
    worker_cd = "t2.micro"
    worker_ci = "t3.large"
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
