# =============================================================================
# EKS CLUSTER CONFIGURATION
# =============================================================================
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # Using latest major version

  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = module.vpc.vpc_id
  # subnet_ids = module.vpc.public_subnets # enable them when in prod or use private subnets ude nat gateway in prod 
  subnet_ids = module.vpc.private_subnets
  # control_plane_subnet_ids = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2023_x86_64_STANDARD"
    instance_types = [var.eks_instance_type]
  }

  eks_managed_node_groups = {
    spot_nodes = {
      name = "spot-node-group"

      min_size     = 3
      max_size     = 3
      desired_size = 3

      instance_types = [var.eks_instance_type]
      capacity_type  = "SPOT"

      labels = {
        role = "spot-worker"
      }

      tags = merge(
        {
          Name = local.cluster_name,
          Role = "spot-worker"
        },
        local.common_tags
      )
    }
  }

  depends_on = [module.vpc]

  # Enabling public access to the cluster API
  cluster_endpoint_public_access = true

  # This is the new way to grant initial admin access in newer module versions
  enable_cluster_creator_admin_permissions = true

  tags = merge(
    {
      Name = local.cluster_name
    },
    local.common_tags
  )
}