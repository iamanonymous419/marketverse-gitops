# Project - MarketVerse Deployment

[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)](https://www.terraform.io)
[![Ansible](https://img.shields.io/badge/Automation-Ansible-EE0000?logo=ansible)](https://www.ansible.com)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)](https://aws.amazon.com)
[![Jenkins](https://img.shields.io/badge/CI-Jenkins-D24939?logo=jenkins)](https://www.jenkins.io)
[![ArgoCD](https://img.shields.io/badge/CD-ArgoCD-0DADEA?logo=argo)](https://argoproj.github.io/cd)
[![Prometheus](https://img.shields.io/badge/Monitoring-Prometheus-E6522C?logo=prometheus)](https://prometheus.io)
[![Grafana](https://img.shields.io/badge/Dashboards-Grafana-F46800?logo=grafana)](https://grafana.com)

MarketVerse is a cloud-native e-commerce platform that can be deployed using Kubernetes and Minikube. This guide provides step-by-step instructions for deploying MarketVerse on Minikube, setting up monitoring with Prometheus and Grafana, using automation with Makefile, and managing deployments with Argo CD.

> [!WARNING]
> This project is for **learning purposes** and aims to explore DevOps best practices.

## References

- [Infrastructure as Code (IaC) Guide](/iac/README.md)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Argo CD Documentation](https://argo-cd.readthedocs.io/en/stable/)
- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/)

---

## Table of Contents

- [Project - MarketVerse Deployment](#project---marketverse-deployment)
  - [References](#references)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Setup and Deployment](#setup-and-deployment)
    - [1. Clone the Repository](#1-clone-the-repository)
    - [2. Set Up Kubernetes Namespace](#2-set-up-kubernetes-namespace)
    - [3. Deploy Database](#3-deploy-database)
    - [4. Configure and Push Database Schema](#4-configure-and-push-database-schema)
    - [5. Deploy Application](#5-deploy-application)
    - [6. Deploy Cron Jobs](#6-deploy-cron-jobs)
    - [7. Access the Application](#7-access-the-application)
  - [Automated Deployment with Makefile](#automated-deployment-with-makefile)
  - [Kubernetes Dashboard in Minikube](#kubernetes-dashboard-in-minikube)
  - [Monitoring with Grafana and Prometheus](#monitoring-with-grafana-and-prometheus)
    - [Step 1: Install Prometheus and Grafana](#step-1-install-prometheus-and-grafana)
    - [Step 2: Expose Prometheus \& Grafana](#step-2-expose-prometheus--grafana)
    - [Step 3: Get Grafana Credentials](#step-3-get-grafana-credentials)
  - [Argo CD Deployment](#argo-cd-deployment)
    - [Step 1: Install Argo CD](#step-1-install-argo-cd)
    - [Step 2: Expose Argo CD UI](#step-2-expose-argo-cd-ui)
    - [Step 3: Get Argo CD Admin Credentials](#step-3-get-argo-cd-admin-credentials)
  - [Infrastructure as Code (IaC) Deployment](#infrastructure-as-code-iac-deployment)
  - [Cleanup](#cleanup)
    - [🚀 MarketVerse is now successfully deployed on Kubernetes with Argo CD! Happy coding! 🎉](#-marketverse-is-now-successfully-deployed-on-kubernetes-with-argo-cd-happy-coding-)

---

## Prerequisites

Ensure the following tools are installed before proceeding:

- **Docker** → [Install Guide](https://docs.docker.com/get-docker/)
- **Minikube** → [Install Guide](https://minikube.sigs.k8s.io/docs/start/)
- **kubectl** → [Install Guide](https://kubernetes.io/docs/tasks/tools/)
- **Helm** → [Install Guide](https://helm.sh/docs/intro/install/)
- **Argo CD** → [Install Guide](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- **Jenkins** (Optional, for CI/CD) → [Install Guide](https://www.jenkins.io/doc/book/installing/)

---

## Setup and Deployment

### 1. Clone the Repository

```bash
# Clone the project repository
git clone https://github.com/iamanonymous419/marketverse-gitops.git marketverse-gitops
cd marketverse-gitops

# For a specific branch
git clone -b main https://github.com/iamanonymous419/marketverse-gitops.git marketverse-gitops
cd marketverse-gitops
```

### 2. Set Up Kubernetes Namespace

```bash
kubectl apply -f namespace.yml
```

### 3. Deploy Database

```bash
kubectl apply -f ./database
```

### 4. Configure and Push Database Schema

Before running this command, make sure to set up the database URL of the Minikube service:

```env
DATABASE_URL="postgresql://something:something@localhost:5432/database"
```

Then, forward the database port and push the schema:

```bash
kubectl port-forward service/database-service 5432:5432 -n marketverse &
pnpm exec drizzle-kit push
```

To verify the tables:

```bash
psql -h localhost -U something -d database
```

To access the database pod:

```bash
kubectl exec -it pod/database-0 -n marketverse -- bash
psql -U something -d database
```

### 5. Deploy Application

```bash
kubectl apply -f ./app
```

### 6. Deploy Cron Jobs

```bash
kubectl apply -f ./cron-job
```

### 7. Access the Application

```bash
kubectl port-forward service/marketverse-svc 3000:80 -n marketverse &
```

Now, open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Automated Deployment with Makefile

For easier deployment, use the provided Makefile:

```bash
make create-ns        # Create Kubernetes namespace
make delete-ns        # Delete Kubernetes namespace
```

```bash
make run-database     # Deploy database
make delete-database  # Remove database
```

```bash
make run-app          # Deploy application
make delete-app       # Remove application
```

```bash
make run-job          # Deploy scheduled jobs
make remove-job       # Remove scheduled jobs
```

```bash
make forward-app      # Forward port 3000 for the app
make forward-database # Forward port 5432 for the database
```

🛠️ **Database Schema:**

```bash
make schema-push      # Push latest schema changes to DB
```

🚀 **Full Deployment:**

```bash
make run-all          # Deploys everything including schema push
```

🧹 **Cleanup:**

```bash
make delete           # Deletes all resources
```

---

## Kubernetes Dashboard in Minikube

Enable the Minikube dashboard:

```bash
minikube addons enable dashboard
minikube addons enable metrics-server
minikube dashboard
```

Access the dashboard at:

[http://127.0.0.1:37725/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/](http://127.0.0.1:37989/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/)

---

## Monitoring with Grafana and Prometheus

### Step 1: Install Prometheus and Grafana

```bash
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
```

### Step 2: Expose Prometheus & Grafana

```bash
kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090 &
kubectl port-forward svc/prometheus-grafana -n monitoring 4000:80 &
```

### Step 3: Get Grafana Credentials

```bash
kubectl get secret prometheus-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
```

**Username:** `admin`

---

## Argo CD Deployment

### Step 1: Install Argo CD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Step 2: Expose Argo CD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```

### Step 3: Get Argo CD Admin Credentials

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

**Username:** `admin`

---

## Infrastructure as Code (IaC) Deployment

> [!IMPORTANT]
> For production-grade AWS EKS deployment using Infrastructure as Code (IaC), please refer to our comprehensive guide:
> 
> 📄 **[Marketverse Infrastructure as Code (IaC) with Terraform and Ansible](/iac/README.md)**

This guide provides a complete production-ready infrastructure setup, including:

- ☁️ **AWS EKS Cluster** setup using Terraform
- 🔄 **CI/CD Pipeline** with Jenkins on AWS EC2
- 🔐 **Remote Backend** for secure Terraform state management
- 🚢 **GitOps Deployment** using ArgoCD
- 📊 **Monitoring Stack** with Prometheus and Grafana
- 🧩 **Configuration Management** using Ansible

![IaC](https://img.shields.io/badge/IaC-Terraform%20%7C%20Ansible-blue)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Jenkins%20%7C%20ArgoCD-brightgreen)
![Cloud](https://img.shields.io/badge/Cloud-AWS%20EKS-orange)

> [!TIP]
> The IaC deployment is ideal for production environments and follows industry best practices for secure, scalable, and maintainable infrastructure.

---

## Cleanup

To delete everything:

```bash
kubectl delete -f namespace.yml
make delete
```

---

### 🚀 MarketVerse is now successfully deployed on Kubernetes with Argo CD! Happy coding! 🎉