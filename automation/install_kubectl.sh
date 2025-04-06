#!/bin/bash

# ============================================================
# kubectl Installation Script
# ============================================================

echo "Checking if kubectl is installed..."
if command -v kubectl &>/dev/null; then
    echo "kubectl is already installed."
    kubectl version --client
else
    echo "kubectl is not installed. Installing kubectl..."
    
    # Download and install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl

    echo "kubectl installed successfully."
    kubectl version --client
fi

