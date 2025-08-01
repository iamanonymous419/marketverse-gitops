# **Marketverse Infrastructure as Code (IaC) with Terraform and Ansible**

[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)](https://www.terraform.io)
[![Ansible](https://img.shields.io/badge/Automation-Ansible-EE0000?logo=ansible)](https://www.ansible.com)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)](https://aws.amazon.com)
[![Jenkins](https://img.shields.io/badge/CI-Jenkins-D24939?logo=jenkins)](https://www.jenkins.io)
[![ArgoCD](https://img.shields.io/badge/CD-ArgoCD-0DADEA?logo=argo)](https://argoproj.github.io/cd)
[![Prometheus](https://img.shields.io/badge/Monitoring-Prometheus-E6522C?logo=prometheus)](https://prometheus.io)
[![Grafana](https://img.shields.io/badge/Dashboards-Grafana-F46800?logo=grafana)](https://grafana.com)
[![Vault](https://img.shields.io/badge/Security-Vault-000000?logo=vault)](https://www.vaultproject.io)
[![Slack](https://img.shields.io/badge/Chat-Slack-4A154B?logo=slack&logoColor=white)](https://slack.com)
[![Elasticsearch](https://img.shields.io/badge/Search-Elasticsearch-005571?logo=elasticsearch&logoColor=white)](https://www.elastic.co/elasticsearch/)
[![Kibana](https://img.shields.io/badge/Visualization-Kibana-E8478B?logo=kibana&logoColor=white)](https://www.elastic.co/kibana/)
[![Filebeat](https://img.shields.io/badge/Log%20Shipper-Filebeat-005571?logo=elastic&logoColor=white)](https://www.elastic.co/beats/filebeat)

This guide provides step-by-step instructions to deploy infrastructure using Terraform, Ansible, Helm, and ArgoCD on AWS EKS Cluster for Marketverse and Jenkins CI/CD pipelines setup.

# **Table of Contents**

- [**Marketverse Infrastructure as Code (IaC) with Terraform and Ansible**](#marketverse-infrastructure-as-code-iac-with-terraform-and-ansible)
- [**Table of Contents**](#table-of-contents)
  - [**Prerequisites**](#prerequisites)
  - [**Steps to Setup the AWS CLI**](#steps-to-setup-the-aws-cli)
  - [**Steps to Setup the Remote Backend**](#steps-to-setup-the-remote-backend)
    - [**1. Configure Remote Backend for Terraform State Management**](#1-configure-remote-backend-for-terraform-state-management)
    - [**2. Initialize Terraform Remote Backend**](#2-initialize-terraform-remote-backend)
    - [**3. Plan Remote Backend**](#3-plan-remote-backend)
    - [**4. Apply Terraform Configuration**](#4-apply-terraform-configuration)
    - [**5. Check Terraform State**](#5-check-terraform-state)
  - [**Steps to Setup the Jenkins CI/CD**](#steps-to-setup-the-jenkins-cicd)
    - [**1. Configure Terraform to Run Instance of EC2 for Jenkins**](#1-configure-terraform-to-run-instance-of-ec2-for-jenkins)
    - [**2. Initialize Terraform with Remote Backend**](#2-initialize-terraform-with-remote-backend)
    - [**3. Create a Key Pair to Use Named Terra**](#3-create-a-key-pair-to-use-named-terra)
    - [**4. Terraform Plan to Create the VPC**](#4-terraform-plan-to-create-the-vpc)
    - [**5. Verify the VPC is Created**](#5-verify-the-vpc-is-created)
    - [**6. Terraform Plan**](#6-terraform-plan)
    - [**7. Terraform Apply**](#7-terraform-apply)
    - [**8. Check Terraform State**](#8-check-terraform-state)
    - [**9. Check Terraform Outputs**](#9-check-terraform-outputs)
    - [**10. Inject the IP Address and SSH Key in Ansible File Present**](#10-inject-the-ip-address-and-ssh-key-in-ansible-file-present)
    - [**11. Change the Directory**](#11-change-the-directory)
    - [**12. Ping All the Servers**](#12-ping-all-the-servers)
    - [**13. Install Required Components in Machine Without Going to It with Ansible Playbooks**](#13-install-required-components-in-machine-without-going-to-it-with-ansible-playbooks)
    - [**14. Now You Have Installed All Required Jenkins Components and Can Set Up Your Jenkins to Run Pipelines**](#14-now-you-have-installed-all-required-jenkins-components-and-can-set-up-your-jenkins-to-run-pipelines)
  - [**Steps to Setup the AWS EKS Cluster**](#steps-to-setup-the-aws-eks-cluster)
    - [**1. Change the Directory to Main**](#1-change-the-directory-to-main)
    - [**2. Terraform Plan for EKS Cluster**](#2-terraform-plan-for-eks-cluster)
    - [**3. Terraform Apply for EKS Cluster and for VPC**](#3-terraform-apply-for-eks-cluster-and-for-vpc)
    - [**4. Check Terraform State for EKS Cluster and VPC**](#4-check-terraform-state-for-eks-cluster-and-vpc)
    - [**5. Now Configure kubectl to Use This EKS Cluster**](#5-now-configure-kubectl-to-use-this-eks-cluster)
  - [**Enable Metrics Server for Kubernetes Monitoring**](#enable-metrics-server-for-kubernetes-monitoring)
    - [**1. Install Metrics Server**](#1-install-metrics-server)
    - [**2. Verify Metrics Server Installation**](#2-verify-metrics-server-installation)
    - [**3. Use Metrics Server for Resource Monitoring**](#3-use-metrics-server-for-resource-monitoring)
    - [**4. Monitor Horizontal Pod Autoscaler (HPA)**](#4-monitor-horizontal-pod-autoscaler-hpa)
  - [**Application Deployment and Monitoring using ArgoCD, Prometheus, and Grafana with HashiCorp Vault for Secrets Management and EFK (ElasticSearch, Filebeat and Kibana) Stack for Logging**](#application-deployment-and-monitoring-using-argocd-prometheus-and-grafana-with-hashicorp-vault-for-secrets-management-and-efk-elasticsearch-filebeat-and-kibana-stack-for-logging)
    - [**HashiCorp Vault Secrets Management Setup**](#hashicorp-vault-secrets-management-setup)
      - [**Prerequisites for Vault**](#prerequisites-for-vault)
      - [**1. Install HashiCorp Vault**](#1-install-hashicorp-vault)
      - [**2. Wait for Vault Pod to Initialize**](#2-wait-for-vault-pod-to-initialize)
      - [**3. Access Vault Pod**](#3-access-vault-pod)
      - [**4. Initialize and Unseal Vault**](#4-initialize-and-unseal-vault)
      - [**5. Enable Kubernetes Authentication**](#5-enable-kubernetes-authentication)
      - [**6. Configure Kubernetes Authentication**](#6-configure-kubernetes-authentication)
      - [**7. Enable KV Secrets Engine**](#7-enable-kv-secrets-engine)
      - [**8. Store Application Secrets**](#8-store-application-secrets)
      - [**9. Create Vault Policy**](#9-create-vault-policy)
      - [**10. Configure Kubernetes Role**](#10-configure-kubernetes-role)
      - [**11. Expose Vault for UI/UX**](#11-expose-vault-for-uiux)
      - [**12. Access the Vault via AWS Load Balancer (Optional)**](#12-access-the-vault-via-aws-load-balancer-optional)
      - [**Application Integration with Vault**](#application-integration-with-vault)
      - [**Vault Troubleshooting Commands**](#vault-troubleshooting-commands)
      - [**Vault Security Best Practices**](#vault-security-best-practices)
      - [**Common Vault Issues**](#common-vault-issues)
    - [**Application Deployment with ArgoCD**](#application-deployment-with-argocd)
      - [**Step 1: Setup Argo CD**](#step-1-setup-argo-cd)
      - [**Step 2: Wait for ArgoCD Pods to Running State**](#step-2-wait-for-argocd-pods-to-running-state)
      - [**Step 3: Expose Argo CD UI**](#step-3-expose-argo-cd-ui)
      - [**Step 4: Get Argo CD Admin Credentials**](#step-4-get-argo-cd-admin-credentials)
      - [**Step 5: Expose ArgoCD via LoadBalancer (Optional)**](#step-5-expose-argocd-via-loadbalancer-optional)
      - [**Step 6: Deploy the App Using UI or ArgoCD CLI**](#step-6-deploy-the-app-using-ui-or-argocd-cli)
      - [**Step 7: Access the Application via AWS Load Balancer**](#step-7-access-the-application-via-aws-load-balancer)
    - [**Monitoring with Prometheus, Grafana, and AlertManager**](#monitoring-with-prometheus-grafana-and-alertmanager)
      - [**Step 1: Install Prometheus, Grafana and AlertManager**](#step-1-install-prometheus-grafana-and-alertmanager)
      - [**Step 2: Expose Prometheus, Grafana and AlertManager**](#step-2-expose-prometheus-grafana-and-alertmanager)
      - [**Step 3: Expose Services via LoadBalancer (Optional)**](#step-3-expose-services-via-loadbalancer-optional)
      - [**Step 4: Setup AlertManager with Slack Messages (Optional but Recommended)**](#step-4-setup-alertmanager-with-slack-messages-optional-but-recommended)
      - [**Step 5: Get Grafana Credentials**](#step-5-get-grafana-credentials)
      - [**Step 6: Setup Grafana Dashboard**](#step-6-setup-grafana-dashboard)
      - [**Step 7: Verification and Testing**](#step-7-verification-and-testing)
      - [**Step 8: Troubleshooting**](#step-8-troubleshooting)
    - [**EFK Stack (ElasticSearch, Filebeat and Kibana) for Logging of cluster and App**](#efk-stack-elasticsearch-filebeat-and-kibana-for-logging-of-cluster-and-app)
      - [**Prerequisites for EFK Stack**](#prerequisites-for-efk-stack)
      - [**Step 1: Add Elastic Repository**](#step-1-add-elastic-repository)
      - [**Step 2: Install ElasticSearch**](#step-2-install-elasticsearch)
      - [**Step 3: Configure ElasticSearch for Single Node**](#step-3-configure-elasticsearch-for-single-node)
      - [**Step 4: Install Filebeat for Log Shipping**](#step-4-install-filebeat-for-log-shipping)
      - [**Step 5: Configure Filebeat for Application-Specific Logging**](#step-5-configure-filebeat-for-application-specific-logging)
      - [**Step 6: Install Kibana for Log Visualization**](#step-6-install-kibana-for-log-visualization)
      - [**Step 7: Configure Kibana Access**](#step-7-configure-kibana-access)
      - [**Step 8: Get Kibana Credentials**](#step-8-get-kibana-credentials)
      - [**Step 9: Setup Kibana Index Patterns and Dashboards**](#step-9-setup-kibana-index-patterns-and-dashboards)
      - [**Step 10: Advanced Filebeat Configuration for Multiple Namespaces (Optional)**](#step-10-advanced-filebeat-configuration-for-multiple-namespaces-optional)
      - [**Step 11: Monitoring and Troubleshooting (Optional)**](#step-11-monitoring-and-troubleshooting-optional)
        - [**Verify EFK Stack Health**](#verify-efk-stack-health)
        - [**Common Troubleshooting Commands**](#common-troubleshooting-commands)
        - [**Performance Tuning (Optional)**](#performance-tuning-optional)
      - [**Step 12: Log Retention and Management (Optional)**](#step-12-log-retention-and-management-optional)
  - [**Testing Horizontal Pod Autoscaling (HPA)**](#testing-horizontal-pod-autoscaling-hpa)
    - [**Option 1: Using Apache Benchmark**](#option-1-using-apache-benchmark)
    - [**Option 2: Using Hey Load Generator**](#option-2-using-hey-load-generator)
    - [**Option 3: Using Simple Continuous Load**](#option-3-using-simple-continuous-load)
    - [**Monitoring HPA During Load Testing**](#monitoring-hpa-during-load-testing)
  - [**Cleanup and Resource Deletion**](#cleanup-and-resource-deletion)
    - [**Step 1: Delete Monitoring Resources**](#step-1-delete-monitoring-resources)
    - [**Step 2: Delete HashiCorp Vault**](#step-2-delete-hashicorp-vault)
    - [**Step 3: Delete Logging Resources (EFK Stack)**](#step-3-delete-logging-resources-efk-stack)
    - [**Step 4: Delete ArgoCD and Application Deployments**](#step-4-delete-argocd-and-application-deployments)
    - [**Step 5: Delete EKS Cluster and VPC**](#step-5-delete-eks-cluster-and-vpc)
    - [**Step 6: Delete Jenkins EC2 Instances**](#step-6-delete-jenkins-ec2-instances)
    - [**Step 7: Delete Remote Backend (Optional)**](#step-7-delete-remote-backend-optional)
    - [**Step 8: Verify Resource Deletion**](#step-8-verify-resource-deletion)
  - [**Conclusion**](#conclusion)
  - [**Author**](#author)

## **Prerequisites**

Before beginning, ensure you have the following tools installed on your local machine:

| Tool | Description | Installation Link |
|------|-------------|-------------------|
| AWS CLI | Command line tool for AWS | [Download AWS CLI](https://aws.amazon.com/cli/) |
| Terraform | Infrastructure as Code tool | [Download Terraform](https://www.terraform.io/downloads.html) |
| kubectl | Kubernetes command line tool | [Download kubectl](https://kubernetes.io/docs/tasks/tools/) |
| Ansible | Configuration management tool | [Download Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) |
| Helm | Kubernetes package manager | [Download Helm](https://helm.sh/docs/intro/install/) |

## **Steps to Setup the AWS CLI**

To interact with AWS services, you need to configure the AWS CLI with your credentials:

1. **Install AWS CLI** (if not done in prerequisites):
   ```bash
   # For Linux/macOS
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```

2. **Configure AWS CLI**:
   ```bash
   aws configure
   ```
   
   You'll be prompted to enter:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region (e.g., ap-south-1)
   - Default output format (json recommended)

3. **Verify configuration**:
   ```bash
   aws sts get-caller-identity
   ```

## **Steps to Setup the Remote Backend**

### **1. Configure Remote Backend for Terraform State Management**
First, set up the remote backend for Terraform state management.
```bash
cd ./iac/remote
```

### **2. Initialize Terraform Remote Backend**
Run the following command to initialize Terraform Remote Backend:
```sh
terraform init
```

### **3. Plan Remote Backend**
Execute the plan command to preview changes:
```sh
terraform plan
```

### **4. Apply Terraform Configuration**
Run the apply command to launch the infrastructure:
```sh
terraform apply -auto-approve
```

### **5. Check Terraform State**
Check state:
```bash
terraform state list 
```

> [!NOTE]
> Remote backend is now ready to use 

## **Steps to Setup the Jenkins CI/CD**

### **1. Configure Terraform to Run Instance of EC2 for Jenkins**
First, change the directory
```bash
cd 
cd ./iac/main
```

### **2. Initialize Terraform with Remote Backend**

- First ensure to run remote backend <!-- point this to above to run  -->

Run the following command to initialize Terraform Remote Backend:
```bash
terraform init
```

### **3. Create a Key Pair to Use Named Terra**

Run the following command to generate a key:
```bash
ssh-keygen
# To convert private key to pem key 
mv <your-key>  <your-key>.pem 
```

### **4. Terraform Plan to Create the VPC**

Run the following command to plan and apply only the VPC creation:

```bash
# Plan only for the VPC module
terraform plan -target=module.vpc

# Apply only the VPC module
terraform apply -target=module.vpc
```

### **5. Verify the VPC is Created**

Use the following command to check if the VPC and its related resources were created:

```bash
terraform state list
```

This will show you a list of resources Terraform is tracking. Look for entries like:

```
module.vpc.aws_vpc.main
module.vpc.aws_subnet.public[0]
...
```

### **6. Terraform Plan**

Execute the plan command to preview changes:
```bash
terraform plan -target=module.master -target=module.worker_cd -target=module.worker_ci
```

> [!CAUTION]
> This will pull three EC2 machines: one is master Jenkins machine and two are worker machines for Jenkins named CI and CD for running two pipelines, CI and CD 

### **7. Terraform Apply**
Execute the apply command to create the infrastructure:
```bash
terraform apply -target=module.master -target=module.worker_cd -target=module.worker_ci -auto-approve
```

### **8. Check Terraform State**
Check state:
```bash
terraform state list 
```

### **9. Check Terraform Outputs**
Check outputs for specific IP addresses of all machines:
```bash
terraform output 
```

### **10. Inject the IP Address and SSH Key in Ansible File Present**
Edit the `setup/inventory.yml` file with the IP addresses from the Terraform output:

```yaml
all:
  hosts:
    master:
      ansible_host: <MASTER_IP_ADDRESS>
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ../main/terra.pem
    worker-ci:
      ansible_host: <WORKER_CI_IP_ADDRESS>
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ../main/terra.pem
    worker-cd:
      ansible_host: <WORKER_CD_IP_ADDRESS>
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ../main/terra.pem

  children:
    master_group:
      hosts:
        master:

    worker_group:
      hosts:
        worker-ci:
        worker-cd:

    all_group:
      hosts:
        master:
        worker-ci:
        worker-cd:

    worker_ci_group:
      hosts:
        worker-ci:

    worker_cd_group:
      hosts:
        worker-cd:
```


### **11. Change the Directory**
 ```bash
cd ../setup
```

### **12. Ping All the Servers**
 ```bash
ansible all -i inventory.yml -m ping
```

### **13. Install Required Components in Machine Without Going to It with Ansible Playbooks**
 ```bash
# To install Java in all machines 
ansible-playbook -i inventory.yml ./playbooks/java_play.yml -v

# To install Jenkins on master node 
ansible-playbook -i inventory.yml ./playbooks/jenkins_play.yml -vvv

# To install Docker and Trivy on worker-ci node 
ansible-playbook -i inventory.yml ./playbooks/docker_play.yml -vvv
ansible-playbook -i inventory.yml ./playbooks/trivy_play.yml -vvv

# To add Jenkins User in Docker Group
ansible-playbook -i inventory.yml ./playbooks/user_play.yml -v

# To add setup sonarqube server for jenkins
ansible-playbook -i inventory.yml ./playbooks/sonarqube_play.yml -v
```

### **14. Now You Have Installed All Required Jenkins Components and Can Set Up Your Jenkins to Run Pipelines**

> [!TIP]
> After setting up Jenkins, it's a good practice to configure webhooks in your Git repository (e.g., GitHub, GitLab) to trigger builds automatically.  
> Additionally, ensure your `Jenkinsfile` is well-structured for better maintainability and easier debugging.

- **Enjoy the CI/CD process and automate your deployments like a pro!** 

## **Steps to Setup the AWS EKS Cluster**

**You have initialized your backend in first step** 

### **1. Change the Directory to Main**
First, change the directory to main 
```bash
cd ../main
```

### **2. Terraform Plan for EKS Cluster**
Execute the plan command to preview changes:
```bash
terraform plan -target=module.vpc # for VPC
terraform plan -target=module.eks  # for EKS cluster
```

### **3. Terraform Apply for EKS Cluster and for VPC**
Execute the apply command to create the infrastructure:
```bash
terraform apply -target=module.vpc -auto-approve # for VPC
terraform apply -target=module.eks -auto-approve # for EKS cluster
```

> [!TIP]
> This will take up to 20 to 25 minutes to create the cluster

### **4. Check Terraform State for EKS Cluster and VPC**
Check state:
```bash
terraform state list | grep "module.vpc" # for VPC
terraform state list | grep "module.eks" # for EKS cluster

terraform state show module.vpc # for VPC
terraform state show module.eks # for EKS cluster
```

### **5. Now Configure kubectl to Use This EKS Cluster**
```bash
aws eks update-kubeconfig --region ap-south-1 --name marketverse # to use this cluster

kubectl get node # to check EKS nodes
```

EKS cluster is ready now for deployment and monitoring of app 

## **Enable Metrics Server for Kubernetes Monitoring**

The Kubernetes Metrics Server collects resource metrics from Kubelets and exposes them in the Kubernetes API server through the Metrics API. These metrics can be used by the Horizontal Pod Autoscaler (HPA) and Vertical Pod Autoscaler (VPA) to make scaling decisions.

### **1. Install Metrics Server**

Deploy the Metrics Server using the following command:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### **2. Verify Metrics Server Installation**

Check if the Metrics Server is running properly:

```bash
# Check if metrics server pods are running
kubectl get pods -n kube-system | grep metrics-server

# Verify the metrics API endpoint is accessible
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes
```

If the installation is successful, the second command should return JSON data containing node metrics.

### **3. Use Metrics Server for Resource Monitoring**

Once the Metrics Server is installed, you can use the following commands to monitor resource usage:

```bash
# Get CPU/Memory usage for all nodes
kubectl top nodes

# Get detailed information about a specific node
kubectl describe node <node-name>

# Get CPU/Memory usage for all pods in the current namespace
kubectl top pods

# Get CPU/Memory usage for all pods in a specific namespace
kubectl top pods -n <namespace>
```

### **4. Monitor Horizontal Pod Autoscaler (HPA)**

With Metrics Server installed, you can now create and monitor HPAs:

```bash
# List all HPAs in the cluster
kubectl get hpa

# List HPAs in a specific namespace
kubectl get hpa -n <namespace>

# Get detailed information about an HPA
kubectl describe hpa <hpa-name> -n <namespace>
```

> [!TIP]
> The Metrics Server is essential for enabling autoscaling functionality in your Kubernetes cluster. Make sure it's properly installed before configuring HPAs for your applications.

## **Application Deployment and Monitoring using ArgoCD, Prometheus, and Grafana with HashiCorp Vault for Secrets Management and EFK (ElasticSearch, Filebeat and Kibana) Stack for Logging**

### **HashiCorp Vault Secrets Management Setup**

This section provides comprehensive instructions for setting up HashiCorp Vault in your Kubernetes environment for production secrets management. Vault will securely store and manage sensitive configuration data for your Marketverse application.

#### **Prerequisites for Vault**

- Kubernetes cluster running (EKS cluster from previous steps)
- Helm 3.x installed
- kubectl configured to access your cluster
- Appropriate RBAC permissions

#### **1. Install HashiCorp Vault**

Add the HashiCorp Helm repository and install Vault:

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

helm install vault hashicorp/vault \
  --namespace vault \
  --create-namespace \
  --set "injector.enabled=true" \
  --wait
```

> [!WARNING]
> This basic Vault installation is suitable for development and testing purposes only. Production environments require additional configuration including persistent storage backends, high availability, TLS encryption, and proper authentication methods. A detailed production-ready Vault setup guide will be added in the upcoming months.

#### **2. Wait for Vault Pod to Initialize**

Monitor the deployment status:

```bash
kubectl get all -n vault
```

Wait until all pods are running before proceeding to the next step.

#### **3. Access Vault Pod**

Execute into the Vault pod:

```bash
kubectl exec -it vault-0 -n vault -- sh
```

#### **4. Initialize and Unseal Vault**

Initialize Vault (first time setup only) and unseal it:

```sh
# Initialize Vault (run only once)
vault operator init

# Unseal Vault using the keys from initialization
vault operator unseal <Unseal_Key_1>
vault operator unseal <Unseal_Key_2>
vault operator unseal <Unseal_Key_3>

# Check Vault status (seal or unseal)
vault status

# Login with root token
vault login <Root_Token>
```

> [!IMPORTANT]
> Store the unseal keys and root token securely. You'll need them every time Vault restarts.

#### **5. Enable Kubernetes Authentication**

Enable the Kubernetes auth method:

```sh
vault auth enable kubernetes
```

#### **6. Configure Kubernetes Authentication**

Set up the Kubernetes configuration for Vault:

```sh
# Get Kubernetes service details
echo $KUBERNETES_SERVICE_HOST  # Should output: 10.96.0.1
echo $KUBERNETES_SERVICE_PORT  # Should output: 443

# Set the Kubernetes host
KUBE_HOST="https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT"

# Configure Kubernetes auth
vault write auth/kubernetes/config kubernetes_host="$KUBE_HOST"
```

#### **7. Enable KV Secrets Engine**

Enable the key-value secrets engine:

```sh
vault secrets enable -path=secret kv-v2
```

#### **8. Store Application Secrets**

Create secrets for your MarketVerse application:

```sh
# Store sensitive secrets
vault kv put secret/marketverse/secret \
  CLERK_SECRET_KEY="sk_test_your_clerk_secret_key_here" \
  CLOUDINARY_API_KEY="your_cloudinary_api_key_here" \
  CLOUDINARY_API_SECRET="your_cloudinary_api_secret_here" \
  SMTP_USER="your_email@gmail.com" \
  SMTP_PASSWORD="your_gmail_app_password"
```

```sh
# Store configuration values
vault kv put secret/marketverse/config \
  NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY="pk_test_your_clerk_publishable_key_here" \
  DATABASE_URL="postgresql://something:something@database-service:5432/database" \
  NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME="your_cloud_name" \
  SMTP_HOST="smtp.gmail.com" \
  SMTP_PORT="587" \
  SMTP_FROM="your_email@gmail.com"
```

#### **9. Create Vault Policy**

Create a policy that defines access permissions:

```sh
vault policy write marketverse-policy - << EOF
path "secret/*" {
  capabilities = ["read"]
}
EOF
```

#### **10. Configure Kubernetes Role**

Create a Kubernetes role that binds service accounts to the policy:

```sh
vault write auth/kubernetes/role/marketverse-role \
    bound_service_account_names=marketverse-sa \
    bound_service_account_namespaces=marketverse \
    policies=marketverse-policy \
    ttl=24h
```

#### **11. Expose Vault for UI/UX**

```bash
# For Minikube Cluster
kubectl patch svc vault -n vault \
  -p '{"spec": {"type": "NodePort"}}'

# Port Forward command for testing 
kubectl port-forward svc/vault 8200:8200 -n vault & 

# For EKS Cluster
kubectl patch svc vault -n vault \
  -p '{"spec": {"type": "LoadBalancer"}}'
```

#### **12. Access the Vault via AWS Load Balancer (Optional)**

After the vault is deployed, an AWS Load Balancer will be provisioned automatically to expose your vault to the internet.

1. **Get the Load Balancer URL**:
   ```bash
   kubectl get svc -n vault
   ```

   Look for a service of type `LoadBalancer`. You'll see an external IP/DNS name that looks something like:
   ```bash
   vault  LoadBalancer  10.96.200.28  a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com    8200:30937/TCP,8201:31023/TCP   5m
   ```

2. **Access the Vault Application**:
   
   You can now access your application through the Load Balancer URL:
   ```
   http://a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com
   ```

#### **Application Integration with Vault**

To use these secrets in your application, you'll need to:

1. Create a ServiceAccount named `marketverse-sa` in the `marketverse` namespace
2. Configure your deployment with Vault annotations for secret injection
3. Enable the Vault agent injector in your namespace

Example ServiceAccount:
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: marketverse-sa
  namespace: marketverse
```

#### **Vault Troubleshooting Commands**

Here are useful commands for debugging Vault integration issues:

```bash
# Check Vault agent init container logs
kubectl logs pod/<pod-name> -n marketverse -c vault-agent-init

# Verify environment variables in application container
kubectl exec -it pod/<pod-name> -n marketverse -c marketverse-project -- env | grep -E 'CLERK|CLOUDINARY|SMTP'

# Check if secrets are mounted correctly
kubectl exec -it pod/<pod-name> -n marketverse -c marketverse-project -- ls /vault/secrets/

# List Vault directory contents
kubectl exec -it pod/<pod-name> -n marketverse -- ls /vault/

# View secret file contents
kubectl exec -it pod/<pod-name> -n marketverse -c marketverse-project -- cat /vault/secrets/config

# Check container names in pod
kubectl get pod <pod-name> -n marketverse -o jsonpath="{.spec.containers[*].name}"
kubectl get pod <pod-name> -n marketverse -o jsonpath="{.spec.initContainers[*].name}"

# Get detailed pod information
kubectl describe pod <pod-name> -n marketverse

# Enable Vault injection for namespace
kubectl label ns marketverse vault.hashicorp.com/agent-injection=enabled --overwrite

# Restart pods to apply changes
kubectl delete pod -l app=marketverse -n marketverse
```

#### **Vault Security Best Practices**

1. **Rotate Secrets Regularly**: Update secrets periodically and rotate access tokens
2. **Principle of Least Privilege**: Grant minimal necessary permissions to each role
3. **Secure Unseal Keys**: Store unseal keys in a secure location, preferably split among multiple trusted individuals
4. **Enable Audit Logging**: Configure Vault audit logs for security monitoring
5. **Use TLS**: Ensure all communication with Vault is encrypted
6. **Backup Vault Data**: Regularly backup Vault configuration and secrets

#### **Common Vault Issues**

- **Pod not starting**: Check if the namespace has Vault injection enabled
- **Secrets not loading**: Verify the ServiceAccount name matches the bound account in the Vault role
- **Permission denied**: Ensure the policy grants appropriate permissions to the secret paths
- **Vault sealed**: Run the unseal commands if Vault has been restarted

### **Application Deployment with ArgoCD**

This section covers ArgoCD setup and configuration for automated application deployment. ArgoCD enables continuous delivery of your Marketverse application through GitOps principles and Git repository synchronization.

> [!NOTE]
> We will use ArgoCD GitOps approach to deploy this web app on EKS cluster

#### **Step 1: Setup Argo CD**

```bash
# Via official manifest
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml 

# via helm 
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Install ArgoCD
helm install argocd argo/argo-cd --namespace argocd --create-namespace

# If in EKS Cluster
helm install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --set server.service.type=LoadBalancer
```

#### **Step 2: Wait for ArgoCD Pods to Running State**

```bash
kubectl get all -n argocd -o wide # to check status of ArgoCD pods
```

#### **Step 3: Expose Argo CD UI**

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```

#### **Step 4: Get Argo CD Admin Credentials**

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

**Username:** `admin`

#### **Step 5: Expose ArgoCD via LoadBalancer (Optional)**

To make ArgoCD accessible externally through a LoadBalancer instead of port-forwarding:

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

You can then access ArgoCD UI using the LoadBalancer's external IP/DNS:

```bash
# Get the LoadBalancer URL
kubectl get svc argocd-server -n argocd
```

Look for a service of type `LoadBalancer`. You'll see an external IP/DNS name that looks something like:
```bash
argocd-server   LoadBalancer   10.100.71.130  a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com   80:30080/TCP,443:30443/TCP  5m
```

You can now access your ArgoCD application through the Load Balancer URL:
```bash
http://a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com
```

#### **Step 6: Deploy the App Using UI or ArgoCD CLI**

Ensure ArgoCD CLI is installed:

```bash
# For Linux
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# For macOS
brew install argocd

# For Windows (using Chocolatey)
choco install argocd
```

Create a namespace for your application:

```bash
kubectl create namespace marketverse
```

Use the ArgoCD CLI to deploy your application:

```bash
# 🔐 Log in to ArgoCD using CLI
# --insecure is used to skip TLS verification for localhost (only use in dev environments)
argocd login localhost:8080 --username admin --password <your-password> --insecure

# 🚀 Create a new ArgoCD application named "marketverse"
# --repo: Git repository containing the Kubernetes manifests and kustomization.yaml
# --path .: The kustomization.yaml is in the root directory of the repo
# --dest-server: Deploy to the in-cluster Kubernetes API
# --dest-namespace: Target namespace for deployment
# --sync-policy automated: Enables auto-sync on Git changes
argocd app create marketverse \
  --repo https://github.com/iamanonymous419/marketverse-gitops.git \
  --path . \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace marketverse \
  --sync-policy automated

# 🔄 Manually trigger an initial sync (optional if auto-sync is enabled)
argocd app sync marketverse

# 📋 View the app status, sync state, and health info
argocd app get marketverse

# 🔁 Force Re-deploy (even if no changes)
argocd app sync marketverse --force

# 📋 View Application Logs (if supported)
argocd app logs marketverse

# ↩️ Roll Back to a Previous Revision
argocd app rollback marketverse <REVISION-ID>

argocd app rollback marketverse 2

# 📜 View App History (Revisions)
argocd app history marketverse

# 🗑️ Delete the Argo CD Application
# This command deletes the Argo CD app **and all Kubernetes resources it manages** (use with caution).

argocd app delete marketverse --cascade --yes

# `--cascade`: Deletes all Kubernetes resources associated with the app.
# `--yes`: Skips the confirmation prompt.
```

#### **Step 7: Access the Application via AWS Load Balancer**

After the application is deployed, an AWS Load Balancer will be provisioned automatically to expose your application to the internet.

1. **Get the Load Balancer URL**:
   ```bash
   kubectl get svc -n marketverse
   ```

   Look for a service of type `LoadBalancer`. You'll see an external IP/DNS name that looks something like:
   ```
   marketverse-svc   LoadBalancer   10.100.71.130   a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com   80:30007/TCP   2m
   ```

2. **Access the Application**:
   
   You can now access your application through the Load Balancer URL:
   ```
   http://a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com
   ```

3. **DNS Configuration (Optional)**:
   
   For a more user-friendly URL, you can create a CNAME record in your DNS provider that points to the AWS Load Balancer URL:
   
   ```
   marketverse.yourdomain.com → a1b2c3d4e5f6g7h8i9j0k.elb.ap-south-1.amazonaws.com
   ```

> [!NOTE]
> It might take a few minutes for the Load Balancer to be fully provisioned and for DNS to propagate. If you can't access immediately, wait a few minutes and try again.

> [!TIP]
> To check the Load Balancer health and status, you can use:
> ```bash
> aws elb describe-load-balancers | grep DNSName
> # Or for ALB/NLB
> aws elbv2 describe-load-balancers | grep DNSName
> ```

### **Monitoring with Prometheus, Grafana, and AlertManager**

First ensure Helm is installed: Helm Installation Guide

This section provides comprehensive instructions for setting up Grafana and Prometheus in your Kubernetes environment for complete application monitoring and observability. This monitoring stack will collect metrics and provide rich visualization dashboards for your Marketverse application.

#### **Step 1: Install Prometheus, Grafana and AlertManager**

Add the Prometheus community Helm repository and install the complete stack:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace --wait
```

#### **Step 2: Expose Prometheus, Grafana and AlertManager**

Access services locally using port forwarding:

```bash
# Prometheus
kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090 &

# Grafana
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80 &

# AlertManager
kubectl port-forward svc/prometheus-kube-prometheus-alertmanager -n monitoring 9093:9093 &
```

**Access URLs:**
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000
- AlertManager: http://localhost:9093

#### **Step 3: Expose Services via LoadBalancer (Optional)**

To make Prometheus, Grafana and AlertManager accessible externally through a LoadBalancer:

```bash
# Convert services to LoadBalancer type
kubectl patch svc prometheus-kube-prometheus-prometheus -n monitoring \
  -p '{"spec": {"type": "LoadBalancer"}}'

kubectl patch svc prometheus-grafana -n monitoring \
  -p '{"spec": {"type": "LoadBalancer"}}'

kubectl patch svc prometheus-kube-prometheus-alertmanager -n monitoring \
  -p '{"spec": {"type": "LoadBalancer"}}'
```

You can then access the services using their LoadBalancer URLs:

```bash
# Get the LoadBalancer URLs
kubectl get svc -n monitoring | grep LoadBalancer

kubectl get svc -n monitoring -o wide | grep LoadBalancer
```

You’ll see output similar to:

```bash
prometheus-grafana                         LoadBalancer   10.100.150.18   a1b2c3d4e5f6g7.elb.ap-south-1.amazonaws.com   80:30123/TCP     2m
prometheus-kube-prometheus-prometheus      LoadBalancer   10.100.162.42   b2c3d4e5f6g7h8.elb.ap-south-1.amazonaws.com   9090:30124/TCP   2m
prometheus-kube-prometheus-alertmanager    LoadBalancer   10.100.167.35   c3d4e5f6g7h8i9.elb.ap-south-1.amazonaws.com   9093:30125/TCP   2m
```

You can now access each service using their external DNS/IP:

- Grafana: http://a1b2c3d4e5f6g7.elb.ap-south-1.amazonaws.com
- Prometheus: http://b2c3d4e5f6g7h8.elb.ap-south-1.amazonaws.com
- AlertManager: http://c3d4e5f6g7h8i9.elb.ap-south-1.amazonaws.com

> [!WARNING]
> If ports other than 80/443 are exposed, include the port (e.g. :9090), or configure port 80 in the Helm chart.

#### **Step 4: Setup AlertManager with Slack Messages (Optional but Recommended)**

Get the Helm values and save it in a file:

```bash
mkdir -p values
helm show values prometheus-community/kube-prometheus-stack > values/monitoring.yaml
```

**Alerting to Slack**

Create a new workspace in Slack, create a new channel e.g. "#alerts"

Go to https://api.slack.com/apps to create the webhook:

1. Create an app "alertmanager"
2. Go to incoming webhook
3. Create a webhook and copy it

Modify the Helm values file in values/monitoring.yaml:

```yaml
alertmanager:
  config:
    global:
      resolve_timeout: 5m
    route:
      group_by: ['namespace']
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 12h
      receiver: 'slack-notification'
      routes:
      - receiver: 'slack-notification'
        matchers:
          - severity = "critical"
    receivers:
    - name: 'slack-notification'
      slack_configs:
          - api_url: 'https://hooks.slack.com/services/YOUR_WEBHOOK_URL_HERE'
            channel: '#alerts'
            send_resolved: true
    templates:
    - '/etc/alertmanager/config/*.tmpl'
```

```yaml
alertmanager:
  config:
    global:
      resolve_timeout: 5m
      slack_api_url: 'YOUR_SLACK_WEBHOOK_URL_HERE'
    
    route:
      group_by: ['namespace', 'alertname']
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 12h
      receiver: 'default-receiver'
      routes:
      - receiver: 'critical-alerts'
        matchers:
          - severity = "critical"
      - receiver: 'warning-alerts'
        matchers:
          - severity = "warning"
    
    receivers:
    - name: 'default-receiver'
      slack_configs:
      - channel: '#alerts'
        send_resolved: true
        title: 'Kubernetes Alert'
        text: '{{ range .Alerts }}{{ .Annotations.summary }}{{ end }}'
        
    - name: 'critical-alerts'
      slack_configs:
      - channel: '#critical-alerts'
        send_resolved: true
        title: '🚨 CRITICAL: {{ .GroupLabels.alertname }}'
        text: '{{ range .Alerts }}{{ .Annotations.summary }}{{ end }}'
        
    - name: 'warning-alerts'
      slack_configs:
      - channel: '#warnings'
        send_resolved: true
        title: '⚠️  WARNING: {{ .GroupLabels.alertname }}'
        text: '{{ range .Alerts }}{{ .Annotations.summary }}{{ end }}'
```

Note: You can refer to this documentation for Slack configuration: "https://prometheus.io/docs/alerting/latest/configuration/#slack_config"

Now upgrade the Helm chart with new YAML files:

```bash
helm upgrade prometheus prometheus-community/kube-prometheus-stack -f values/monitoring.yaml -n monitoring --wait
```

A sample test you can run:

```bash
curl -X POST -H 'Content-type: application/json' --data '{"text":"Test message from AlertManager"}' 'YOUR_SLACK_WEBHOOK_URL_HERE'
```

#### **Step 5: Get Grafana Credentials**

```bash
kubectl get secret prometheus-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
```

**Username:** `admin`

#### **Step 6: Setup Grafana Dashboard**

Set up your favorite dashboard in Grafana! Recommended dashboard ID is 15661 for comprehensive Kubernetes monitoring.

1. Go to Grafana UI (http://localhost:3000 or using the LoadBalancer URL)
2. Navigate to Dashboards > Import
3. Enter ID: 15661
4. Select your Prometheus data source
5. Click Import to enjoy monitoring your infrastructure

#### **Step 7: Verification and Testing**

Check that all components are running:

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
```

Test metrics collection:

```bash
# Port-forward Prometheus (if not already done)
kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090 &

# Check if metrics are being scraped
curl http://localhost:9090/api/v1/query?query=up
```

#### **Step 8: Troubleshooting**

**Common Issues:**

**Pod Not Starting:**
```bash
kubectl describe pod <pod-name> -n monitoring
kubectl logs <pod-name> -n monitoring
```

**Service Not Accessible:**
```bash
kubectl get endpoints -n monitoring
kubectl describe svc <service-name> -n monitoring
```

**AlertManager Not Sending Alerts:**
```bash
kubectl logs -l app.kubernetes.io/name=alertmanager -n monitoring

# Check AlertManager config
kubectl get secret alertmanager-prometheus-kube-prometheus-alertmanager -n monitoring -o yaml
```

**Grafana Dashboard Issues:**
- Verify Prometheus data source configuration
- Check if Prometheus is accessible from Grafana pod
- Ensure proper RBAC permissions

**Security Note:** Always use secrets management for sensitive data like Slack webhook URLs in production environments.

### **EFK Stack (ElasticSearch, Filebeat and Kibana) for Logging of cluster and App**

This section provides comprehensive instructions for setting up the EFK (ElasticSearch, Filebeat, and Kibana) stack in your Kubernetes environment for centralized logging and log analysis. The EFK stack will collect, process, and visualize logs from your Marketverse application and Kubernetes cluster components.

#### **Prerequisites for EFK Stack**

- Kubernetes cluster running (EKS cluster from previous steps)
- Helm 3.x installed and configured
- kubectl configured to access your cluster
- Sufficient cluster resources (minimum 4GB RAM, 2 CPU cores recommended)
- StorageClass available for persistent volumes

#### **Step 1: Add Elastic Repository**

Add the official Elastic Helm repository:

```bash
# Add Elastic Helm repository
helm repo add elastic https://helm.elastic.co
helm repo update

# Verify repository is added
helm repo list | grep elastic
```

#### **Step 2: Install ElasticSearch**

Deploy ElasticSearch as the central log storage system:

```bash
# Install ElasticSearch with default configuration
helm install elasticsearch elastic/elasticsearch \
  --namespace logging \
  --create-namespace \

# Monitor ElasticSearch deployment
kubectl get all -n logging
```

Wait for the ElasticSearch pods to be in Running state before proceeding.

#### **Step 3: Configure ElasticSearch for Single Node**

For development and testing environments, configure ElasticSearch for single-node operation:

```bash
# Get default ElasticSearch values
mkdir -p values
helm show values elastic/elasticsearch > values/elasticsearch.yaml
```

Edit the `values/elasticsearch.yaml` file to configure single-node setup:

```yaml
# ElasticSearch Configuration for Single Node Setup
replicas: 1
minimumMasterNodes: 1

# Health check configuration for single node
clusterHealthCheckParams: "wait_for_status=yellow&timeout=30s"

# Resource configuration (adjust based on your cluster capacity)
resources:
  requests:
    cpu: "500m"
    memory: "1Gi"
  limits:
    cpu: "1000m"
    memory: "2Gi"

# Persistence configuration
persistence:
  enabled: true
  size: 10Gi

# Security configuration
security:
  enabled: true
  password:
    generate: true
```

Apply the configuration:

```bash
# Upgrade ElasticSearch with custom configuration
helm upgrade elasticsearch elastic/elasticsearch \
  -f values/elasticsearch.yaml \
  -n logging \
  --wait

# Verify ElasticSearch is running
kubectl get pods -n logging -l app=elasticsearch-master
```

Make sure the pod is running:

```bash
kubectl get pod -n logging
NAME                     READY   STATUS    RESTARTS   AGE
elasticsearch-master-0   1/1     Running   0          87m
```

#### **Step 4: Install Filebeat for Log Shipping**

Deploy Filebeat as a DaemonSet to collect logs from all nodes:

```bash
# Install Filebeat
helm install filebeat elastic/filebeat \
  --namespace logging \
  --wait

# Verify Filebeat DaemonSet is running on all nodes
kubectl get daemonset -n logging
kubectl get pods -n logging -l app=filebeat-filebeat 
```

Filebeat runs as a daemonset. check if its up:

```bash
kubectl get pod -n logging
NAME                         READY   STATUS    RESTARTS   AGE
elasticsearch-master-0       1/1     Running   0          93m
filebeat-filebeat-g79qs      1/1     Running   0          25s
filebeat-filebeat-kh8mj      1/1     Running   0          25s
```

#### **Step 5: Configure Filebeat for Application-Specific Logging**

Configure Filebeat to collect logs specifically from your Marketverse application:

```bash
# Get Filebeat default values
helm show values elastic/filebeat > values/filebeat.yaml
```

Edit the `values/filebeat.yaml` file to configure application-specific log collection:

```yaml
# Filebeat Configuration for Marketverse Application
filebeatConfig:
  filebeat.yml: |
    filebeat.inputs:
    - type: container
      paths:
        - /var/log/containers/*marketverse*.log
      processors:
        - add_kubernetes_metadata:
            host: ${NODE_NAME}
            matchers:
            - logs_path:
                logs_path: "/var/log/containers/"
        - decode_json_fields:
            fields: ["message"]
            target: ""
            overwrite_keys: true
```

Apply the Filebeat configuration:

```bash
# Upgrade Filebeat with custom configuration
helm upgrade filebeat elastic/filebeat \
  -f values/filebeat.yaml \
  -n logging \
  --wait

# Verify Filebeat is collecting logs
kubectl logs -l app=filebeat-filebeat -n logging --tail=50
```

#### **Step 6: Install Kibana for Log Visualization**

Deploy Kibana for log visualization and analysis:

```bash
# Install Kibana
helm install kibana elastic/kibana \
  --namespace logging \
  --wait

# Monitor Kibana deployment
kubectl get pods -n logging -l app=kibana
```

Verify if it runs.

```bash
kubectl get pod -n logging
NAME                               READY   STATUS    RESTARTS       AGE
elasticsearch-master-0             1/1     Running   0              3h50m
filebeat-filebeat-g79qs            1/1     Running   0              138m
filebeat-filebeat-kh8mj            1/1     Running   1 (137m ago)   138m
kibana-kibana-559f75574-9s4xk      1/1     Running   0              130m
```

#### **Step 7: Configure Kibana Access**

Configure Kibana for external access:

```bash
# Patch clusterIP into NodePort
kubectl patch svc kibana-kibana  -n logging -p '{"spec": {"type": "NodePort"}}'

# For development (using port-forward)
kubectl port-forward -n logging service/kibana-kibana 5601:5601 &
```

Access the Kibana application in Localhost

- **Kibana**: http://localhost:5601

For production (using LoadBalancer in EKS)

```bash
# Patch the Kibana service to LoadBalancer type
kubectl patch svc kibana-kibana -n logging \
  -p '{"spec": {"type": "LoadBalancer"}}'
```

You can then access the services using their LoadBalancer URLs:

```bash
# Get the LoadBalancer URLs
kubectl get svc -n monitoring | grep LoadBalancer
```

You’ll see output similar to:

```bash
kibana-kibana    LoadBalancer   10.100.151.50   d4e5f6g7h8i9j0.elb.ap-south-1.amazonaws.com   5601:30333/TCP   2m
```

You can now access Kibana via LoadBalancer:

- **Kibana**: http://d4e5f6g7h8i9j0.elb.ap-south-1.amazonaws.com

#### **Step 8: Get Kibana Credentials**

Retrieve the ElasticSearch credentials for Kibana login:

```bash
# Get username (should be 'elastic')
kubectl get secret elasticsearch-master-credentials -n logging \
  -o jsonpath='{.data.username}' | base64 -d
echo

# Get password
kubectl get secret elasticsearch-master-credentials -n logging \
  -o jsonpath='{.data.password}' | base64 -d
echo
```

**Default Credentials:**
- **Username:** `elastic`
- **Password:** (retrieved from the command above)

#### **Step 9: Setup Kibana Index Patterns and Dashboards**

Once Kibana is accessible, configure it for log analysis:

1. **Access Kibana UI**:
   - Development: http://localhost:5601
   - Production: Use the LoadBalancer URL from Step 7

2. **Login with ElasticSearch credentials** from Step 8

3. **Create Index Pattern**:
   - Navigate to Management → Stack Management → Index Patterns
   - Click "Create index pattern"
   - Enter pattern: `marketverse-logs-*`
   - Select `@timestamp` as the time field
   - Click "Create index pattern"

4. **View Logs**:
   - Navigate to Analytics → Discover
   - Select your `marketverse-logs-*` index pattern
   - You should see logs from your Marketverse application

5. **Create Custom Dashboard** (Optional):
   - Navigate to Analytics → Dashboard
   - Click "Create dashboard"
   - Add visualizations for log analysis, error rates, and application metrics


#### **Step 10: Advanced Filebeat Configuration for Multiple Namespaces (Optional)**

For comprehensive cluster logging, configure Filebeat to collect logs from multiple namespaces:

```yaml
# Advanced Filebeat Configuration (values/filebeat-advanced.yaml)
filebeatConfig:
  filebeat.yml: |
    filebeat.inputs:
    # Application logs
    - type: container
      paths:
        - /var/log/containers/*marketverse*.log
        - /var/log/containers/*monitoring*.log
        - /var/log/containers/*argocd*.log
      processors:
        - add_kubernetes_metadata:
            host: ${NODE_NAME}
            matchers:
            - logs_path:
                logs_path: "/var/log/containers/"
        - decode_json_fields:
            fields: ["message"]
            target: ""
            overwrite_keys: true
      fields:
        log_type: application
      fields_under_root: true
    
    # System logs
    - type: container
      paths:
        - /var/log/containers/*kube-system*.log
      processors:
        - add_kubernetes_metadata:
            host: ${NODE_NAME}
            matchers:
            - logs_path:
                logs_path: "/var/log/containers/"
      fields:
        log_type: system
      fields_under_root: true
    
    # Output with different indices based on log type
    output.elasticsearch:
      hosts: ["elasticsearch-master:9200"]
      username: "elastic"
      password: "${ELASTICSEARCH_PASSWORD}"
      indices:
        - index: "marketverse-app-logs-%{+yyyy.MM.dd}"
          when.equals:
            log_type: application
        - index: "kubernetes-system-logs-%{+yyyy.MM.dd}"
          when.equals:
            log_type: system
        - index: "general-logs-%{+yyyy.MM.dd}"
```

#### **Step 11: Monitoring and Troubleshooting (Optional)**

##### **Verify EFK Stack Health**

```bash
# Check all EFK components
kubectl get all -n logging

# Check Filebeat is shipping logs
kubectl logs -l app=filebeat-filebeat -n logging --tail=100

# Check Kibana connectivity to ElasticSearch
kubectl logs -l app=kibana -n logging --tail=50
```

##### **Common Troubleshooting Commands**

```bash
# ElasticSearch issues
kubectl describe pod elasticsearch-master-0 -n logging
kubectl logs elasticsearch-master-0 -n logging

# Filebeat issues
kubectl describe daemonset filebeat-filebeat -n logging
kubectl logs -l app=filebeat-filebeat -n logging

# Kibana issues
kubectl describe pod -l app=kibana -n logging
kubectl logs -l app=kibana -n logging

# Storage issues
kubectl get pvc -n logging
kubectl describe pvc -n logging

# Check storage class
kubectl get storageclass
```

##### **Performance Tuning (Optional)**

```bash
# Monitor resource usage
kubectl top pods -n logging
kubectl top nodes
```

#### **Step 12: Log Retention and Management (Optional)**

Configure log retention policies to manage storage:

```yaml
# ElasticSearch Index Lifecycle Management (values/elasticsearch-ilm.yaml)
extraEnvs:
  - name: action.auto_create_index
    value: "true"

extraInitContainers:
  - name: setup-ilm-policy
    image: curlimages/curl:latest
    command:
      - /bin/sh
      - -c
      - |
        until curl -u elastic:${ELASTICSEARCH_PASSWORD} http://elasticsearch-master:9200/_cluster/health; do
          echo "Waiting for ElasticSearch..."
          sleep 5
        done
        
        # Create ILM policy for log rotation
        curl -X PUT -u elastic:${ELASTICSEARCH_PASSWORD} \
          "http://elasticsearch-master:9200/_ilm/policy/logs-policy" \
          -H 'Content-Type: application/json' \
          -d '{
            "policy": {
              "phases": {
                "hot": {
                  "actions": {
                    "rollover": {
                      "max_size": "1GB",
                      "max_age": "7d"
                    }
                  }
                },
                "delete": {
                  "min_age": "30d",
                  "actions": {
                    "delete": {}
                  }
                }
              }
            }
          }'
```

> [!TIP]
> For production environments, consider implementing index lifecycle management (ILM) policies to automatically manage log retention and prevent storage issues.

> [!WARNING]
> The EFK stack can be resource-intensive. Monitor your cluster's resource usage and adjust resource limits accordingly. In production, consider running ElasticSearch on dedicated nodes with sufficient storage and memory.

> [!NOTE]
> This EFK configuration is optimized for development and testing. For production deployments, consider implementing additional security measures, backup strategies, and high-availability configurations.

## **Testing Horizontal Pod Autoscaling (HPA)**

To properly test the Horizontal Pod Autoscaler configuration of your application, you can generate artificial load using various methods. Here are three different approaches to stress test your application and verify that HPA is working correctly.

### **Option 1: Using Apache Benchmark**

This method uses Apache Benchmark (ab) tool to generate a high number of requests:

```bash
kubectl run -i --tty load-generator --rm --image=httpd:alpine --restart=Never -- /bin/sh -c "ab -n 100000 -c 50 http://marketverse-svc.marketverse.svc.cluster.local/"
```

This command:
- Creates a temporary pod using the httpd:alpine image
- Runs Apache Benchmark to send 100,000 requests with 50 concurrent connections
- Targets the marketverse service using the internal DNS name
- Automatically removes the pod after completion

### **Option 2: Using Hey Load Generator**

Hey is a modern load testing tool designed for HTTP loads:

```bash
kubectl run -i --tty load-generator --rm --image=alpine --restart=Never -- /bin/sh -c "apk add --no-cache hey && hey -z 20m -c 50 http://marketverse-svc.marketverse.svc.cluster.local"
```

This command:
- Creates a temporary pod using the alpine image
- Installs the hey load testing tool
- Generates load for 20 minutes with 50 concurrent connections
- Targets the marketverse service using the internal DNS name
- Automatically removes the pod after completion

### **Option 3: Using Simple Continuous Load**

For a simpler approach that generates continuous load:

```bash
kubectl run -i --tty load-generator --rm --image=busybox -n marketverse --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://marketverse-svc.marketverse.svc.cluster.local; done" 
```

This command:
- Creates a temporary pod using the busybox image
- Runs a continuous loop that makes HTTP requests to your service
- Continues until you manually terminate it (Ctrl+C)
- Automatically removes the pod after termination

### **Monitoring HPA During Load Testing**

While the load test is running, monitor your HPA to see it in action:

```bash
# Watch HPA metrics in real-time
kubectl get hpa -n marketverse -w

# Monitor pod scaling
kubectl get pods -n marketverse -w

# Check resource utilization
kubectl top pods -n marketverse
```

You should see:
1. CPU utilization increasing as load is applied
2. HPA scaling up the number of pods when utilization exceeds the target threshold
3. Additional pods being created to handle the load
4. After the load test finishes, pods gradually scaling back down after the cool-down period

> [!TIP]
> For production workloads, it's recommended to thoroughly test your HPA settings to ensure they match your application's resource needs and scaling behavior. Too aggressive scaling can lead to thrashing, while too conservative settings may not scale fast enough during traffic spikes.

## **Cleanup and Resource Deletion**

When you're finished with your infrastructure, follow these steps to properly clean up all resources to avoid unnecessary AWS charges.

### **Step 1: Delete Monitoring Resources**

First, remove the monitoring stack:

```bash
# Delete Prometheus and Grafana resources
helm uninstall prometheus -n monitoring

# Verify all resources are being terminated
kubectl get all -n monitoring

# Delete the monitoring namespace once all resources are terminated
kubectl delete namespace monitoring
```

### **Step 2: Delete HashiCorp Vault**

Clean up Vault resources before proceeding:

```bash
# Delete Vault Helm release
helm uninstall vault -n vault

# Delete any remaining Vault resources and PVCs
kubectl delete pvc -l app.kubernetes.io/name=vault -n vault

# Delete any Vault secrets
kubectl delete secret -l app.kubernetes.io/name=vault -n vault

# Delete the Vault namespace
kubectl delete namespace vault

# Verify Vault resources are deleted
kubectl get all -n vault
kubectl get pvc -n vault

# Optional: Remove Vault Helm repository (if no longer needed)
helm repo remove hashicorp
```

### **Step 3: Delete Logging Resources (EFK Stack)**

Clean up the logging infrastructure:

```bash
# Delete Kibana Helm release
helm uninstall kibana -n logging

# Verify Kibana resources are terminated
kubectl get pods -n logging -l app=kibana

# Delete Filebeat DaemonSet
helm uninstall filebeat -n logging

# Verify Filebeat pods are terminated on all nodes
kubectl get pods -n logging -l app=filebeat-filebeat
kubectl get daemonset -n logging

# Delete ElasticSearch Helm release
helm uninstall elasticsearch -n logging

# Delete ElasticSearch PVCs (this will delete all stored logs)
kubectl delete pvc -l app=elasticsearch-master -n logging

# Verify ElasticSearch resources are deleted
kubectl get pods -n logging -l app=elasticsearch-master
kubectl get pvc -n logging

# Delete any remaining secrets
kubectl delete secret -l app.kubernetes.io/name=elasticsearch -n logging
kubectl delete secret -l app.kubernetes.io/name=kibana -n logging
kubectl delete secret -l app.kubernetes.io/name=filebeat -n logging

# Delete ConfigMaps
kubectl delete configmap -l app.kubernetes.io/name=elasticsearch -n logging
kubectl delete configmap -l app.kubernetes.io/name=kibana -n logging
kubectl delete configmap -l app.kubernetes.io/name=filebeat -n logging

# Delete the entire logging namespace
kubectl delete namespace logging

# Verify namespace deletion
kubectl get namespace logging

# Remove custom values files (optional)
rm -f values/elasticsearch.yaml
rm -f values/filebeat.yaml
rm -f values/kibana.yaml
rm -f values/filebeat-advanced.yaml
rm -f values/elasticsearch-ilm.yaml

# Remove Elastic Helm repository if no longer needed
helm repo remove elastic

# Verify complete EFK cleanup
kubectl get all -n logging 2>/dev/null || echo "Logging namespace not found - cleanup successful"
kubectl get pvc --all-namespaces | grep -E "(elasticsearch|kibana|filebeat)"
kubectl get secrets --all-namespaces | grep -E "(elasticsearch|kibana|filebeat)"
helm list --all-namespaces | grep -E "(elasticsearch|kibana|filebeat)"
```

### **Step 4: Delete ArgoCD and Application Deployments**

Next, clean up your application deployments and ArgoCD:

```bash
# Delete your application deployment through ArgoCD
argocd app delete marketverse --cascade

# Delete the marketverse namespace
kubectl delete namespace marketverse

# Delete ArgoCD installation
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Delete the ArgoCD namespace
kubectl delete namespace argocd
```

### **Step 5: Delete EKS Cluster and VPC**

Return to your Terraform directory and destroy the EKS cluster and VPC:

```bash
cd ../main

# Destroy the EKS cluster first
terraform destroy -target=module.eks -auto-approve

# After EKS is destroyed, destroy the VPC
terraform destroy -target=module.vpc -auto-approve

# Verify the resources are deleted
terraform state list | grep "module.eks"
terraform state list | grep "module.vpc"
```

> [!IMPORTANT]
> Deleting the EKS cluster can take 15-20 minutes. Be patient and wait for the process to complete before proceeding.

### **Step 6: Delete Jenkins EC2 Instances**

Now destroy the Jenkins EC2 instances:

```bash
# Destroy all EC2 instances for Jenkins
terraform destroy -target=module.master -target=module.worker_cd -target=module.worker_ci -auto-approve

# Verify EC2 instances are deleted
terraform state list | grep "module.master"
terraform state list | grep "module.worker_cd"
terraform state list | grep "module.worker_ci"
```

### **Step 7: Delete Remote Backend (Optional)**

If you no longer need the remote backend for Terraform state:

```bash
cd ../remote

# Destroy the remote backend infrastructure
terraform destroy -auto-approve

# Verify destruction
terraform state list
```

> [!WARNING]
> Only delete the remote backend if you're sure you won't need to manage this infrastructure again. The state file contains important information about your resources.

### **Step 8: Verify Resource Deletion**

Finally, check the AWS Management Console or use the AWS CLI to ensure all resources have been properly deleted:

```bash
# Check for any running EC2 instances
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId,Tags[?Key=='Name'].Value|[0]]" --output table

# Check for any EKS clusters
aws eks list-clusters

# Check for any VPCs created by this project
aws ec2 describe-vpcs --filters "Name=tag:Project,Values=marketverse" --query "Vpcs[*].[VpcId,Tags[?Key=='Name'].Value|[0]]" --output table

# Check for S3 buckets (for remote backend)
aws s3 ls | grep terraform-state
```

Clean up any remaining resources that might have been missed by the Terraform destroy commands.

## **Conclusion**
Congratulations! You've successfully set up a complete infrastructure for the Marketverse application using Infrastructure as Code principles. This production-ready setup includes:

- Secure remote state management
- Jenkins CI/CD pipelines with dedicated worker nodes
- A scalable Kubernetes cluster on AWS EKS
- GitOps-based deployment with ArgoCD
- Secure secrets management with HashiCorp Vault
- Comprehensive monitoring with Prometheus and Grafana
- Centralized application logging using the EFK stack (Elasticsearch, Filebeat, and Kibana)
- Metrics Server for resource monitoring and HPA support
- LoadBalancer exposure for monitoring and management tools

This infrastructure follows DevOps best practices and provides a solid foundation for deploying, managing, logging and monitoring your applications at scale. The modular approach allows for easy maintenance and future extensions, while Vault ensures your sensitive data remains secure throughout the deployment pipeline.

When you're done with the infrastructure, you can follow the cleanup steps to ensure all resources are properly deleted to avoid unexpected AWS charges.

For any issues or questions, please refer to the individual tool documentation or open an issue in the repository.

## **Author**

**Anonymous**  
📧 Email: [anonymous292009@gmail.com](mailto:anonymous292009@gmail.com)  
🔗 GitHub: [https://github.com/iamanonymous419](https://github.com/iamanonymous419)
