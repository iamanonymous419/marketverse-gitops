# MarketVerse IaC Commands Reference

## Prerequisites Installation

### AWS CLI
```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS CLI
aws configure

# Verify configuration
aws sts get-caller-identity
```

### Terraform
```bash
# Download and install Terraform (Linux)
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
unzip terraform_1.5.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

### kubectl
```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

### Helm
```bash
# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### eksctl
```bash
# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
```

## Remote Backend Setup

```bash
# Navigate to remote directory
cd ./iac/remote

# Initialize Terraform
terraform init

# Plan remote backend
terraform plan

# Apply remote backend
terraform apply -auto-approve

# Check state
terraform state list
```

## Jenkins CI/CD Setup

```bash
# Navigate to main directory
cd ../main

# Initialize Terraform with remote backend
terraform init

# Create SSH key pair
ssh-keygen
mv <your-key> <your-key>.pem

# Plan and apply VPC only
terraform plan -target=module.vpc
terraform apply -target=module.vpc

# Verify VPC creation
terraform state list

# Plan EC2 instances
terraform plan -target=module.master -target=module.worker_cd -target=module.worker_ci

# Apply EC2 instances
terraform apply -target=module.master -target=module.worker_cd -target=module.worker_ci -auto-approve

# Check outputs
terraform output

# Navigate to setup directory
cd ../setup

# Test connectivity
ansible all -i inventory.yml -m ping

# Install components with Ansible
ansible-playbook -i inventory.yml ./playbooks/java_play.yml -v
ansible-playbook -i inventory.yml ./playbooks/jenkins_play.yml -vvv
ansible-playbook -i inventory.yml ./playbooks/docker_play.yml -vvv
ansible-playbook -i inventory.yml ./playbooks/trivy_play.yml -vvv
ansible-playbook -i inventory.yml ./playbooks/user_play.yml -v
ansible-playbook -i inventory.yml ./playbooks/sonarqube_play.yml -v
```

## EKS Cluster Setup

```bash
# Navigate back to main
cd ../main

# Plan EKS cluster
terraform plan -target=module.vpc
terraform plan -target=module.eks

# Apply EKS cluster
terraform apply -target=module.vpc -auto-approve
terraform apply -target=module.eks -auto-approve

# Check state
terraform state list | grep "module.eks"

# Configure kubectl
aws eks update-kubeconfig --region ap-south-1 --name marketverse

# Verify nodes
kubectl get nodes
```

## AWS Load Balancer Controller Setup

```bash
# Download IAM policy
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.13.3/docs/install/iam_policy.json

# Create IAM policy
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

# Create IAM service account
eksctl create iamserviceaccount \
    --cluster=<cluster-name> \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --region <aws-region-code> \
    --approve

# Add Helm repository
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

# Install controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=<cluster-name> \
    --set serviceAccount.create=false \
    --set region=<aws-region-code> \
    --set vpcId=<vpc-id> \
    --set serviceAccount.name=aws-load-balancer-controller \
    --version 1.13.0

# Verify installation
kubectl get deployment -n kube-system aws-load-balancer-controller
```

## AWS EBS CSI Driver Setup

```bash
# Create IAM service account
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster <your-cluster-name> \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

# Add Helm repository
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update

# Install driver
helm upgrade --install aws-ebs-csi-driver \
    --namespace kube-system \
    aws-ebs-csi-driver/aws-ebs-csi-driver

# Verify installation
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver

# Create storage class
kubectl apply -f storageclass.yaml
kubectl get storageclass
```

## Metrics Server Setup

```bash
# Install via manifest
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Or via Helm
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm install metrics-server metrics-server/metrics-server -n kube-system

# Verify installation
kubectl get pods -n kube-system | grep metrics-server
kubectl get apiservices | grep metrics
kubectl top nodes
```

## HashiCorp Vault Setup

```bash
# Add Helm repository
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

# Install Vault
helm install vault hashicorp/vault \
  --namespace vault \
  --create-namespace \
  --set "injector.enabled=true" \
  --wait

# Access Vault pod
kubectl exec -it vault-0 -n vault -- sh

# Initialize Vault (inside pod)
vault operator init

# Unseal Vault (inside pod)
vault operator unseal <Unseal_Key_1>
vault operator unseal <Unseal_Key_2>
vault operator unseal <Unseal_Key_3>

# Check status
vault status

# Login with root token
vault login <Root_Token>

# Enable Kubernetes auth
vault auth enable kubernetes

# Configure Kubernetes auth
KUBE_HOST="https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT"
vault write auth/kubernetes/config kubernetes_host="$KUBE_HOST"

# Enable KV secrets engine
vault secrets enable -path=secret kv-v2

# Store secrets
vault kv put secret/marketverse/secret \
  CLERK_SECRET_KEY="sk_test_your_clerk_secret_key_here" \
  CLOUDINARY_API_KEY="your_cloudinary_api_key_here" \
  CLOUDINARY_API_SECRET="your_cloudinary_api_secret_here" \
  SMTP_USER="your_email@gmail.com" \
  SMTP_PASSWORD="your_gmail_app_password"

# Create policy
vault policy write marketverse-policy - << EOF
path "secret/*" {
  capabilities = ["read"]
}
EOF

# Configure Kubernetes role
vault write auth/kubernetes/role/marketverse-role \
    bound_service_account_names=marketverse-sa \
    bound_service_account_namespaces=marketverse \
    policies=marketverse-policy \
    ttl=24h

# Expose Vault
kubectl patch svc vault -n vault -p '{"spec": {"type": "LoadBalancer"}}'
```

## ArgoCD Setup

```bash
# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Or via Helm
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd --namespace argocd --create-namespace

# Expose ArgoCD
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Get admin password
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode

# Install ArgoCD CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

# Login to ArgoCD
argocd login localhost:8080 --username admin --password <your-password> --insecure

# Create application
kubectl create namespace marketverse
argocd app create marketverse \
  --repo https://github.com/YOUR_USERNAME/marketverse-gitops.git \
  --path . \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace marketverse \
  --sync-policy automated

# Sync application
argocd app sync marketverse

# Get application status
argocd app get marketverse
```

## Monitoring Stack (Prometheus & Grafana)

```bash
# Add Prometheus Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install monitoring stack
helm install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace --wait

# Port forward services
kubectl port-forward svc/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090 &
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80 &
kubectl port-forward svc/monitoring-kube-prometheus-alertmanager -n monitoring 9093:9093 &

# Or expose via LoadBalancer
kubectl patch svc monitoring-kube-prometheus-prometheus -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'
kubectl patch svc monitoring-grafana -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'
kubectl patch svc monitoring-kube-prometheus-alertmanager -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'

# Get Grafana password
kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode

# Get service URLs
kubectl get svc -n monitoring | grep LoadBalancer
```

## EFK Stack (Elasticsearch, Filebeat, Kibana)

```bash
# Add Elastic repository
helm repo add elastic https://helm.elastic.co
helm repo update

# Install Elasticsearch
helm install elasticsearch elastic/elasticsearch \
  --namespace logging \
  --create-namespace

# Install Filebeat
helm install filebeat elastic/filebeat \
  --namespace logging \
  --wait

# Install Kibana
helm install kibana elastic/kibana \
  --namespace logging \
  --wait

# Expose Kibana
kubectl patch svc kibana-kibana -n logging -p '{"spec": {"type": "LoadBalancer"}}'

# Get Elasticsearch credentials
kubectl get secret elasticsearch-master-credentials -n logging \
  -o jsonpath='{.data.username}' | base64 -d
kubectl get secret elasticsearch-master-credentials -n logging \
  -o jsonpath='{.data.password}' | base64 -d

# Check EFK stack
kubectl get all -n logging
kubectl get svc -n logging | grep LoadBalancer
```

## SSL Certificate & Ingress Setup

```bash
# Request ACM certificate
aws acm request-certificate \
  --domain-name example.com \
  --subject-alternative-names "*.example.com" \
  --validation-method DNS \
  --region us-east-1

# Apply ingress configurations
kubectl apply -f app/ingress.yml

# Get ingress status
kubectl get ingress --all-namespaces -o wide
```

## Load Testing & HPA

```bash
# Apache Benchmark load test
kubectl run -i --tty load-generator --rm --image=httpd:alpine --restart=Never -- /bin/sh -c "ab -n 100000 -c 50 http://marketverse-svc.marketverse.svc.cluster.local/"

# Hey load generator
kubectl run -i --tty load-generator --rm --image=alpine --restart=Never -- /bin/sh -c "apk add --no-cache hey && hey -z 20m -c 50 http://marketverse-svc.marketverse.svc.cluster.local"

# Simple continuous load
kubectl run -i --tty load-generator --rm --image=busybox -n marketverse --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://marketverse-svc.marketverse.svc.cluster.local; done"

# Monitor HPA
kubectl get hpa -n marketverse -w
kubectl get pods -n marketverse -w
kubectl top pods -n marketverse
```

## Troubleshooting Commands

### General Kubernetes
```bash
# Check cluster status
kubectl cluster-info
kubectl get nodes
kubectl get pods --all-namespaces
kubectl get svc --all-namespaces
kubectl get ingress --all-namespaces

# Check events
kubectl get events --all-namespaces
kubectl get events -n <namespace>

# Describe resources
kubectl describe pod <pod-name> -n <namespace>
kubectl describe svc <service-name> -n <namespace>
kubectl describe ingress <ingress-name> -n <namespace>

# Check logs
kubectl logs <pod-name> -n <namespace>
kubectl logs -f <pod-name> -n <namespace>
kubectl logs -l app=<app-label> -n <namespace>
```

### Vault Troubleshooting
```bash
# Check Vault status
kubectl logs -n vault -f pod/<vault-pod>
kubectl get pod -n vault -w

# Check Vault agent logs
kubectl logs pod/<pod-name> -n marketverse -c vault-agent-init
kubectl logs -n marketverse -f pod/<pod-name> -c vault-agent-init

# Verify environment variables
kubectl exec -it pod/<pod-name> -n marketverse -c marketverse -- env | grep -E 'CLERK|CLOUDINARY|SMTP'

# Check secrets mount
kubectl exec -it pod/<pod-name> -n marketverse -c marketverse -- ls /vault/secrets/
kubectl exec -it pod/<pod-name> -n marketverse -c marketverse -- cat /vault/secrets/config

# Enable Vault injection
kubectl label ns marketverse vault.hashicorp.com/agent-injection=enabled --overwrite
kubectl delete pod -l app=marketverse -n marketverse
```

### Monitoring Troubleshooting
```bash
# Check monitoring pods
kubectl get pods -n monitoring
kubectl describe pod <pod-name> -n monitoring
kubectl logs <pod-name> -n monitoring

# Check service endpoints
kubectl get endpoints -n monitoring
kubectl describe svc <service-name> -n monitoring

# Check AlertManager
kubectl logs -l app.kubernetes.io/name=alertmanager -n monitoring
kubectl get secret alertmanager-monitoring-kube-prometheus-alertmanager -n monitoring -o yaml
```

### EFK Troubleshooting
```bash
# Check EFK components
kubectl get all -n logging
kubectl logs -l app=filebeat-filebeat -n logging --tail=100
kubectl logs -l app=kibana -n logging --tail=50

# Elasticsearch issues
kubectl describe pod elasticsearch-master-0 -n logging
kubectl logs elasticsearch-master-0 -n logging

# Storage issues
kubectl get pvc -n logging
kubectl describe pvc -n logging
kubectl get storageclass
```

### Load Balancer Troubleshooting
```bash
# Check AWS Load Balancer Controller
kubectl logs -n kube-system deployment/aws-load-balancer-controller
kubectl get pods -n kube-system | grep aws-load-balancer

# Check target health
aws elbv2 describe-target-health --target-group-arn <target-group-arn>

# Check ALB access logs
aws logs describe-log-groups --log-group-name-prefix "/aws/application-load-balancer"
```

## Cleanup Commands

```bash
# Delete monitoring resources
helm uninstall monitoring -n monitoring
kubectl delete namespace monitoring

# Delete Vault
helm uninstall vault -n vault
kubectl delete pvc -l app.kubernetes.io/name=vault -n vault
kubectl delete namespace vault

# Delete EFK stack
helm uninstall kibana -n logging
helm uninstall filebeat -n logging
helm uninstall elasticsearch -n logging
kubectl delete pvc -l app=elasticsearch-master -n logging
kubectl delete namespace logging

# Delete ArgoCD and applications
argocd app delete marketverse --cascade
kubectl delete namespace marketverse
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl delete namespace argocd

# Terraform cleanup
cd ../main
terraform destroy -target=module.eks -auto-approve
terraform destroy -target=module.vpc -auto-approve
terraform destroy -target=module.master -target=module.worker_cd -target=module.worker_ci -auto-approve

cd ../remote
terraform destroy -auto-approve

# Verify cleanup
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running"
aws eks list-clusters
aws s3 ls | grep terraform-state
```

## Useful Monitoring Commands

```bash
# Resource monitoring
kubectl top nodes
kubectl top pods --all-namespaces
kubectl get hpa --all-namespaces

# Check resource quotas
kubectl describe quota --all-namespaces
kubectl describe limits --all-namespaces

# Check persistent volumes
kubectl get pv
kubectl get pvc --all-namespaces

# Network policies
kubectl get networkpolicies --all-namespaces
kubectl describe networkpolicy <policy-name> -n <namespace>
```

## AWS CLI Useful Commands

```bash
# Check EKS cluster
aws eks describe-cluster --name marketverse
aws eks list-nodegroups --cluster-name marketverse

# Check Load Balancers
aws elbv2 describe-load-balancers
aws elb describe-load-balancers

# Check Route 53
aws route53 list-hosted-zones
aws route53 list-resource-record-sets --hosted-zone-id <zone-id>

# Check ACM certificates
aws acm list-certificates --region us-east-1
aws acm describe-certificate --certificate-arn <cert-arn>

# Check VPC resources
aws ec2 describe-vpcs
aws ec2 describe-subnets
aws ec2 describe-security-groups
```
