# =============================================================================
# LOCAL VALUES 
# =============================================================================

locals {

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
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS"
    }
  ]

  worker_ci_ingress_rules = concat(local.common_ingress_rules, [
    {
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SonarQube"
    }
  ])

  master_ingress_rules = concat(local.common_ingress_rules, [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow Jenkins"
    }
  ])

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 10)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  vpc_name        = "marketverse-vpc"
  cluster_name    = "marketverse-cluster"

  # Common tags applied to all resources
  common_tags = {
    Environment = var.environment
    Project     = "marketverse"
    ManagedBy   = "terraform"
    CreatedBy   = "anonymous"
    Owner       = data.aws_caller_identity.current.user_id
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
