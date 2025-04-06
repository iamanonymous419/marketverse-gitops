
module "master" {
  source                       = "../machine"
  instance_name                = "master"
  instance_type                = local.instance_types.master
  instance_ami                 = local.ami_id
  instance_storage             = local.instance_storage
  instance_key_pair            = local.key_pairs.master
  instance_key_pair_location   = local.key_pair_location
  env                          = local.env
  instance_security_group_name = "master"
  ingress_rules                = local.master_ingress_rules
  subnet_id                    = local.subnet_id
}

module "worker_cd" {
  source                       = "../machine"
  instance_name                = "worker-cd"
  instance_type                = local.instance_types.worker_cd
  instance_ami                 = local.ami_id
  instance_storage             = local.instance_storage
  instance_key_pair            = local.key_pairs.worker_cd
  instance_key_pair_location   = local.key_pair_location
  env                          = local.env
  instance_security_group_name = "worker-cd"
  ingress_rules                = local.common_ingress_rules
  subnet_id                    = local.subnet_id
}

module "worker_ci" {
  source                       = "../machine"
  instance_name                = "worker-ci"
  instance_type                = local.instance_types.worker_ci
  instance_ami                 = local.ami_id
  instance_storage             = local.instance_storage
  instance_key_pair            = local.key_pairs.worker_ci
  instance_key_pair_location   = local.key_pair_location
  env                          = local.env
  instance_security_group_name = "worker-ci"
  ingress_rules                = local.common_ingress_rules
  subnet_id                    = local.subnet_id
}


