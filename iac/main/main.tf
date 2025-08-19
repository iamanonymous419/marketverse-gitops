# =============================================================================
# MAIN FILE FOR JENKINS INFRASTRUCTURE
# =============================================================================

module "master" {
  source                       = "../machine"
  instance_name                = "master"
  instance_type                = var.instance_types.master
  instance_ami                 = var.ami_id
  instance_storage             = var.instance_storage
  instance_key_pair            = local.key_pairs.master
  instance_key_pair_location   = var.key_pair_location
  env                          = var.environment
  instance_security_group_name = "master"
  ingress_rules                = local.master_ingress_rules
  subnet_id                    = module.vpc.public_subnets[0]
  vpc_id                       = module.vpc.vpc_id
  tags                         = local.common_tags
  depends_on                   = [module.vpc, module.vpc.public_subnets]
}

module "worker_cd" {
  source                       = "../machine"
  instance_name                = "worker-cd"
  instance_type                = var.instance_types.worker_cd
  instance_ami                 = var.ami_id
  instance_storage             = var.instance_storage
  instance_key_pair            = local.key_pairs.worker_cd
  instance_key_pair_location   = var.key_pair_location
  env                          = var.environment
  instance_security_group_name = "worker-cd"
  ingress_rules                = local.common_ingress_rules
  subnet_id                    = module.vpc.public_subnets[1]
  vpc_id                       = module.vpc.vpc_id
  tags                         = local.common_tags
  depends_on                   = [module.vpc, module.vpc.public_subnets]
}

module "worker_ci" {
  source                       = "../machine"
  instance_name                = "worker-ci"
  instance_type                = var.instance_types.worker_ci
  instance_ami                 = var.ami_id
  instance_storage             = var.instance_storage
  instance_key_pair            = local.key_pairs.worker_ci
  instance_key_pair_location   = var.key_pair_location
  env                          = var.environment
  instance_security_group_name = "worker-ci"
  ingress_rules                = local.worker_ci_ingress_rules
  subnet_id                    = module.vpc.public_subnets[1]
  vpc_id                       = module.vpc.vpc_id
  tags                         = local.common_tags
  depends_on                   = [module.vpc, module.vpc.public_subnets]
}
