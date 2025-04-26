# **Marketverse Infrastructure as Code (IaC) with Terraform and Ansible**

[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)](https://www.terraform.io)
[![Ansible](https://img.shields.io/badge/Automation-Ansible-EE0000?logo=ansible)](https://www.ansible.com)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)](https://aws.amazon.com)
[![Jenkins](https://img.shields.io/badge/CI-Jenkins-D24939?logo=jenkins)](https://www.jenkins.io)
[![ArgoCD](https://img.shields.io/badge/CD-ArgoCD-0DADEA?logo=argo)](https://argoproj.github.io/cd)
[![Prometheus](https://img.shields.io/badge/Monitoring-Prometheus-E6522C?logo=prometheus)](https://prometheus.io)
[![Grafana](https://img.shields.io/badge/Dashboards-Grafana-F46800?logo=grafana)](https://grafana.com)

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
  - [**Enable Metrics Server for Kubernetes Monitoring**](#enable-metrics-server-for-kubernetes-monitoring)
    - [**1. Install Metrics Server**](#1-install-metrics-server)
    - [**2. Verify Metrics Server Installation**](#2-verify-metrics-server-installation)
    - [**3. Use Metrics Server for Resource Monitoring**](#3-use-metrics-server-for-resource-monitoring)
    - [**4. Monitor Horizontal Pod Autoscaler (HPA)**](#4-monitor-horizontal-pod-autoscaler-hpa)
  - [**Deployment and Monitoring of App**](#deployment-and-monitoring-of-app)
    - [**Deployment**](#deployment)
      - [**Step 1: Setup Argo CD**](#step-1-setup-argo-cd)
      - [**Step 2: Wait for ArgoCD Pods to Running State**](#step-2-wait-for-argocd-pods-to-running-state)
      - [**Step 3: Expose Argo CD UI**](#step-3-expose-argo-cd-ui)
      - [**Step 4: Get Argo CD Admin Credentials**](#step-4-get-argo-cd-admin-credentials)
      - [**Step 5: Expose ArgoCD via LoadBalancer (Optional)**](#step-5-expose-argocd-via-loadbalancer-optional)
      - [**Step 6: Deploy the App Using UI or ArgoCD CLI**](#step-6-deploy-the-app-using-ui-or-argocd-cli)
      - [**Step 7: Access the Application via AWS Load Balancer**](#step-7-access-the-application-via-aws-load-balancer)
    - [**Monitoring with Grafana and Prometheus**](#monitoring-with-grafana-and-prometheus)
      - [**Step 1: Install Prometheus and Grafana**](#step-1-install-prometheus-and-grafana)
      - [**Step 2: Expose Prometheus \& Grafana**](#step-2-expose-prometheus--grafana)
      - [**Step 3: Expose Grafana via LoadBalancer (Optional)**](#step-3-expose-grafana-via-loadbalancer-optional)
      - [**Step 4: Get Grafana Credentials**](#step-4-get-grafana-credentials)
      - [**Step 5: Setup Grafana Dashboard**](#step-5-setup-grafana-dashboard)
  - [**Testing Horizontal Pod Autoscaling (HPA)**](#testing-horizontal-pod-autoscaling-hpa)
    - [**Option 1: Using Apache Benchmark**](#option-1-using-apache-benchmark)
    - [**Option 2: Using Hey Load Generator**](#option-2-using-hey-load-generator)
    - [**Option 3: Using Simple Continuous Load**](#option-3-using-simple-continuous-load)
    - [**Monitoring HPA During Load Testing**](#monitoring-hpa-during-load-testing)
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
argocd login localhost:8080 --username admin --password <your-password> --insecure

argocd app create marketverse \
  --repo https://github.com/yourusername/marketverse-manifests.git \
  --path kubernetes \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace marketverse \
  --sync-policy automated
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

#### **Step 3: Expose Grafana via LoadBalancer (Optional)**

To make Prometheus and Grafana accessible externally through a LoadBalancer:

```bash
kubectl patch svc prometheus-kube-prometheus-prometheus -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'
kubectl patch svc prometheus-grafana -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'
```

You can then access the services using their LoadBalancer URLs:

```bash
# Get the LoadBalancer URLs
kubectl get svc -n monitoring | grep LoadBalancer
```

#### **Step 4: Get Grafana Credentials**

```bash
kubectl get secret prometheus-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
```

**Username:** `admin`

#### **Step 5: Setup Grafana Dashboard**

Set up your favorite dashboard in Grafana! Recommended dashboard ID is 15661 for comprehensive Kubernetes monitoring.

1. Go to Grafana UI (http://localhost:3000 or using the LoadBalancer URL)
2. Navigate to Dashboards > Import
3. Enter ID: 15661
4. Select your Prometheus data source
5. Click Import to enjoy monitoring your infrastructure

---

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
- Metrics Server for resource monitoring and HPA support
- LoadBalancer exposure for monitoring and management tools

This infrastructure follows DevOps best practices and provides a solid foundation for deploying, managing, and monitoring your applications at scale. The modular approach allows for easy maintenance and future extensions.

When you're done with the infrastructure, you can follow the cleanup steps to ensure all resources are properly deleted to avoid unexpected AWS charges.

For any issues or questions, please refer to the individual tool documentation or open an issue in the repository.

---

## **Author**

**Anonymous**  
📧 Email: [anonymous292009@gmail.com](mailto:anonymous292009@gmail.com)  
🔗 GitHub: [https://github.com/iamanonymous419](https://github.com/iamanonymous419)

---
