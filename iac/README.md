# **Marketverse Infrastructure as Code (IaC) with Terraform and Ansible**

![Infrastructure as Code](https://img.shields.io/badge/IaC-Terraform%20%7C%20Ansible-blue)
![Cloud](https://img.shields.io/badge/Cloud-AWS-orange)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Jenkins%20%7C%20ArgoCD-brightgreen)
![Monitoring](https://img.shields.io/badge/Monitoring-Prometheus%20%7C%20Grafana-red)

This guide provides step-by-step instructions to deploy infrastructure using Terraform, Ansible, Helm, and ArgoCD on AWS EKS Cluster for Marketverse and Jenkins CI/CD pipelines setup.

# **Table of Contents**

- [**Marketverse Infrastructure as Code (IaC) with Terraform and Ansible**](#marketverse-infrastructure-as-code-iac-with-terraform-and-ansible)
- [**Table of Contents**](#table-of-contents)
  - [**Prerequisites**](#prerequisites)
  - [**Steps to Setup the Remote Backend**](#steps-to-setup-the-remote-backend)
    - [**1. Configure Remote Backend for Terraform State Management**](#1-configure-remote-backend-for-terraform-state-management)
    - [**2. Initialize Terraform Remote Backend**](#2-initialize-terraform-remote-backend)
    - [**3. Plan Remote Backend**](#3-plan-remote-backend)
    - [**4. Apply Terraform Configuration**](#4-apply-terraform-configuration)
    - [**5. Check Terraform State**](#5-check-terraform-state)
  - [**Steps to Setup the AWS CLI**](#steps-to-setup-the-aws-cli)
  - [**Steps to Setup the Jenkins CI/CD**](#steps-to-setup-the-jenkins-cicd)
    - [**1. Configure Terraform to Run Instance of EC2 for Jenkins**](#1-configure-terraform-to-run-instance-of-ec2-for-jenkins)
    - [**2. Initialize Terraform with Remote Backend**](#2-initialize-terraform-with-remote-backend)
    - [**3. Create a Key Pair to Use Named Terra**](#3-create-a-key-pair-to-use-named-terra)
    - [**4. Terraform Plan**](#4-terraform-plan)
    - [**5. Terraform Apply**](#5-terraform-apply)
    - [**6. Check Terraform State**](#6-check-terraform-state)
    - [**7. Check Terraform Outputs**](#7-check-terraform-outputs)
    - [**8. Inject the IP Address and SSH Key in Ansible File Present**](#8-inject-the-ip-address-and-ssh-key-in-ansible-file-present)
    - [**9. Change the Directory**](#9-change-the-directory)
    - [**10. Ping All the Servers**](#10-ping-all-the-servers)
    - [**11. Install Required Components in Machine Without Going to It with Ansible Playbooks**](#11-install-required-components-in-machine-without-going-to-it-with-ansible-playbooks)
    - [**12. Now You Have Installed All Required Jenkins Components and Can Set Up Your Jenkins to Run Pipelines**](#12-now-you-have-installed-all-required-jenkins-components-and-can-set-up-your-jenkins-to-run-pipelines)
  - [**Steps to Setup the AWS EKS Cluster**](#steps-to-setup-the-aws-eks-cluster)
    - [**1. Change the Directory to Main**](#1-change-the-directory-to-main)
    - [**2. Terraform Plan for EKS Cluster**](#2-terraform-plan-for-eks-cluster)
    - [**3. Terraform Apply for EKS Cluster and for VPC**](#3-terraform-apply-for-eks-cluster-and-for-vpc)
    - [**4. Check Terraform State for EKS Cluster and VPC**](#4-check-terraform-state-for-eks-cluster-and-vpc)
    - [**5. Now Configure kubectl to Use This EKS Cluster**](#5-now-configure-kubectl-to-use-this-eks-cluster)
  - [**Deployment and Monitoring of App**](#deployment-and-monitoring-of-app)
    - [**Deployment**](#deployment)
      - [**Step 1: Setup Argo CD**](#step-1-setup-argo-cd)
      - [**Step 2: Wait for ArgoCD Pods to Running State**](#step-2-wait-for-argocd-pods-to-running-state)
      - [**Step 3: Expose Argo CD UI**](#step-3-expose-argo-cd-ui)
      - [**Step 4: Get Argo CD Admin Credentials**](#step-4-get-argo-cd-admin-credentials)
      - [**Step 5: Deploy the App Using UI or ArgoCD CLI**](#step-5-deploy-the-app-using-ui-or-argocd-cli)
      - [**Step 6: Access the Application via AWS Load Balancer**](#step-6-access-the-application-via-aws-load-balancer)
    - [**Monitoring with Grafana and Prometheus**](#monitoring-with-grafana-and-prometheus)
      - [**Step 1: Install Prometheus and Grafana**](#step-1-install-prometheus-and-grafana)
      - [**Step 2: Expose Prometheus \& Grafana**](#step-2-expose-prometheus--grafana)
      - [**Step 3: Get Grafana Credentials**](#step-3-get-grafana-credentials)
      - [**Step 4: Setup Grafana Dashboard**](#step-4-setup-grafana-dashboard)
  - [**Cleanup and Resource Deletion**](#cleanup-and-resource-deletion)
    - [**Step 1: Delete Monitoring Resources**](#step-1-delete-monitoring-resources)
    - [**Step 2: Delete ArgoCD and Application Deployments**](#step-2-delete-argocd-and-application-deployments)
    - [**Step 3: Delete EKS Cluster and VPC**](#step-3-delete-eks-cluster-and-vpc)
    - [**Step 4: Delete Jenkins EC2 Instances**](#step-4-delete-jenkins-ec2-instances)
    - [**Step 5: Delete Remote Backend (Optional)**](#step-5-delete-remote-backend-optional)
    - [**Step 6: Verify Resource Deletion**](#step-6-verify-resource-deletion)
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


### **4. Terraform Plan**
Execute the plan command to preview changes:
```bash
terraform plan -target=module.master -target=module.worker_cd -target=module.worker_ci
```

> [!CAUTION]
> This will pull three EC2 machines: one is master Jenkins machine and two are worker machines for Jenkins named CI and CD for running two pipelines, CI and CD 

### **5. Terraform Apply**
Execute the apply command to create the infrastructure:
```bash
terraform apply -target=module.master -target=module.worker_cd -target=module.worker_ci -auto-approve
```

### **6. Check Terraform State**
Check state:
```bash
terraform state list 
```

### **7. Check Terraform Outputs**
Check outputs for specific IP addresses of all machines:
```bash
terraform output 
```


### **8. Inject the IP Address and SSH Key in Ansible File Present**
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


### **9. Change the Directory**
 ```bash
cd ../setup
```

### **10. Ping All the Servers**
 ```bash
ansible all -i inventory.yml -m ping
```

### **11. Install Required Components in Machine Without Going to It with Ansible Playbooks**
 ```bash
# To install Java in all machines 
ansible-playbook -i inventory.yml ./playbooks/java_play.yml

# To install Jenkins on master node 
ansible-playbook -i inventory.yml ./playbooks/jenkins_play.yml

# To install Docker and Trivy on worker-ci node 
ansible-playbook -i inventory.yml ./playbooks/docker_play.yml
ansible-playbook -i inventory.yml ./playbooks/trivy_play.yml

# To add Jenkins User in Docker Group
ansible-playbook -i inventory.yml ./playbooks/user_play.yml
```

### **12. Now You Have Installed All Required Jenkins Components and Can Set Up Your Jenkins to Run Pipelines**

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

## **Deployment and Monitoring of App using ArgoCD**

**We will use ArgoCD GitOps approach to deploy this web app on EKS cluster**

### **Deployment**

#### **Step 1: Setup Argo CD**

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### **Step 2: Wait for ArgoCD Pods to Running State**

```bash
kubectl get all -n argocd -o wide # to check status of ArgoCD pods
```

#### **Step 3: Expose Argo CD UI**

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```

#### **Step 4: Get Argo CD Admin Credentials**

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

**Username:** `admin`

#### **Step 5: Deploy the App Using UI or ArgoCD CLI**

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
argocd login localhost:8080 --username admin --password <your-password> --insecure

argocd app create marketverse \
  --repo https://github.com/yourusername/marketverse-manifests.git \
  --path kubernetes \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace marketverse \
  --sync-policy automated
```


#### **Step 6: Access the Application via AWS Load Balancer**

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

---

### **Monitoring with Grafana and Prometheus**

First ensure Helm is installed: [Helm Installation Guide](https://helm.sh/docs/intro/install/)

#### **Step 1: Install Prometheus and Grafana**

```bash
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
```

#### **Step 2: Expose Prometheus & Grafana**

```bash
kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090 &
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80 &
```

#### **Step 3: Get Grafana Credentials**

```bash
kubectl get secret prometheus-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
```

**Username:** `admin`

#### **Step 4: Setup Grafana Dashboard**

Set up your favorite dashboard in Grafana! Recommended dashboard ID is 15661 for comprehensive Kubernetes monitoring.

1. Go to Grafana UI (http://localhost:3000)
2. Navigate to Dashboards > Import
3. Enter ID: 15661
4. Select your Prometheus data source
5. Click Import to enjoy monitoring your infrastructure

---

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

### **Step 2: Delete ArgoCD and Application Deployments**

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

### **Step 3: Delete EKS Cluster and VPC**

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

### **Step 4: Delete Jenkins EC2 Instances**

Now destroy the Jenkins EC2 instances:

```bash
# Destroy all EC2 instances for Jenkins
terraform destroy -target=module.master -target=module.worker_cd -target=module.worker_ci -auto-approve

# Verify EC2 instances are deleted
terraform state list | grep "module.master"
terraform state list | grep "module.worker_cd"
terraform state list | grep "module.worker_ci"
```

### **Step 5: Delete Remote Backend (Optional)**

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

### **Step 6: Verify Resource Deletion**

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

---

## **Conclusion**
Congratulations! You've successfully set up a complete infrastructure for the Marketverse application using Infrastructure as Code principles. This production-ready setup includes:

- Secure remote state management
- Jenkins CI/CD pipelines with dedicated worker nodes
- A scalable Kubernetes cluster on AWS EKS
- GitOps-based deployment with ArgoCD
- Comprehensive monitoring with Prometheus and Grafana

This infrastructure follows DevOps best practices and provides a solid foundation for deploying, managing, and monitoring your applications at scale. The modular approach allows for easy maintenance and future extensions.

When you're done with the infrastructure, you can follow the cleanup steps to ensure all resources are properly deleted to avoid unexpected AWS charges.

For any issues or questions, please refer to the individual tool documentation or open an issue in the repository.

---

## **Author**

**Anonymous**  
📧 Email: [anonymous292009@gmail.com](mailto:anonymous292009@gmail.com)  
🔗 GitHub: [https://github.com/iamanonymous419](https://github.com/iamanonymous419)

---