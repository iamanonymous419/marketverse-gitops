#!/bin/bash

# ============================================================
# Kubernetes, Docker, and Minikube Installation Script
# ============================================================
# This script:
# 1. Checks if Docker is installed, installs it if not.
# 2. Checks if Kubernetes (kubeadm, kubelet, kubectl) is installed, installs it if not.
# 3. Checks if Minikube is installed, installs it if not.
# 4. Starts a Minikube cluster using Docker as the driver.
#
# Features:
# - Uses functions for modularity
# - Displays clear messages for each step
#
# Supported OS: Ubuntu-based distributions
# ============================================================

# Function to check and install Docker
install_docker() {
    echo "Checking if Docker is installed..."
    if command -v docker &>/dev/null; then
        echo "Docker is already installed."
        docker --version
    else
        echo "Docker is not installed. Installing Docker..."
        sudo apt update
        sudo apt install -y ca-certificates curl gnupg

        # Add Docker's official GPG key
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        # Set up the repository
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        # Install Docker
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        # Enable and start Docker
        sudo systemctl enable docker
        sudo systemctl start docker

        echo "Docker installed successfully."
        docker --version
    fi
}

# Function to check and install Kubernetes
install_kubernetes() {
    echo "Checking if Kubernetes (kubeadm, kubelet, kubectl) is installed..."

    if command -v kubeadm &>/dev/null && command -v kubelet &>/dev/null && command -v kubectl &>/dev/null; then
        echo "Kubernetes components are already installed."
        kubeadm version
        kubectl version --client
    else
        echo "Kubernetes is not installed. Installing Kubernetes..."

        # Update and install required dependencies
        sudo apt update
        sudo apt install -y apt-transport-https ca-certificates curl

        # Add Kubernetes GPG key
        sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

        # Add Kubernetes repository
        echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

        # Update package list
        sudo apt update

        # Install Kubernetes components
        sudo apt install -y kubelet kubeadm kubectl

        # Prevent automatic updates for Kubernetes
        sudo apt-mark hold kubelet kubeadm kubectl

        echo "Kubernetes components installed successfully."
        kubeadm version
        kubectl version --client
    fi
}

# Function to enable Kubernetes services
enable_kubernetes_services() {
    echo "Enabling Kubernetes services..."
    sudo systemctl enable kubelet
    sudo systemctl start kubelet
    echo "Kubernetes services enabled."
}

# Function to check and install Minikube
install_minikube() {
    echo "Checking if Minikube is installed..."
    if command -v minikube &>/dev/null; then
        echo "Minikube is already installed."
        minikube version
    else
        echo "Minikube is not installed. Installing Minikube..."

        # Download Minikube
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

        # Install Minikube
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        rm minikube-linux-amd64

        echo "Minikube installed successfully."
        minikube version
    fi
}

# Function to start Minikube with Docker
start_minikube() {
    echo "Starting Minikube cluster using Docker..."
    minikube start --driver=docker

    if minikube status &>/dev/null; then
        echo "Minikube cluster started successfully."
    else
        echo "Failed to start Minikube cluster."
    fi
}

# Main execution
echo "Starting Kubernetes, Docker, and Minikube installation process..."
install_docker
install_kubernetes
enable_kubernetes_services
install_minikube
start_minikube
echo "Installation process completed!"
