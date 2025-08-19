# =============================================================================
# VPC CONFIGURATION
# =============================================================================

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.vpc_name
  cidr = var.vpc_cidr

  azs             = local.azs
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_nat_gateway   = true # enable them when in prod or use private subnets
  single_nat_gateway   = true # enable them when in prod or use private subnets
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

  # Tags for VPC
  tags = merge(
    {
      Name = local.vpc_name
    },
    local.common_tags
  )

  # Tags required for EKS
  public_subnet_tags  = merge(local.common_tags, local.public_subnet_tags)
  private_subnet_tags = merge(local.common_tags, local.private_subnet_tags)
}