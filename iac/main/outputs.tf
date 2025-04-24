

output "master_instance_id" {
  description = "The ID of the master EC2 instance"
  value       = module.master.instance_id
}

output "master_instance_public_ip" {
  description = "The public IP of the master EC2 instance"
  value       = module.master.instance_public_ip
}

output "master_instance_dns" {
  description = "The public DNS of the master EC2 instance"
  value       = module.master.instance_dns
}

output "worker_cd_instance_id" {
  description = "The ID of the worker-cd EC2 instance"
  value       = module.worker_cd.instance_id
}

output "worker_cd_instance_public_ip" {
  description = "The public IP of the worker-cd EC2 instance"
  value       = module.worker_cd.instance_public_ip
}

output "worker_cd_instance_dns" {
  description = "The public DNS of the worker-cd EC2 instance"
  value       = module.worker_cd.instance_dns
}

output "worker_ci_instance_id" {
  description = "The ID of the worker-ci EC2 instance"
  value       = module.worker_ci.instance_id
}

output "worker_ci_instance_public_ip" {
  description = "The public IP of the worker-ci EC2 instance"
  value       = module.worker_ci.instance_public_ip
}

output "worker_ci_instance_dns" {
  description = "The public DNS of the worker-ci EC2 instance"
  value       = module.worker_ci.instance_dns
}

# Output for kubectl configuration

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ap-south-1 --name ${module.eks.cluster_name}"
}