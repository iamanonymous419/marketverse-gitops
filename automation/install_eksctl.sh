#!/bin/bash

# ============================================================
# eksctl Installation Script
# ============================================================

echo "Checking if eksctl is installed..."
if command -v eksctl &>/dev/null; then
    echo "eksctl is already installed."
    eksctl version
else
    echo "eksctl is not installed. Installing eksctl..."
    
    # Download and install eksctl
    curl -LO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz"
    tar -xzf eksctl_Linux_amd64.tar.gz
    sudo mv eksctl /usr/local/bin/
    rm eksctl_Linux_amd64.tar.gz

    echo "eksctl installed successfully."
    eksctl version
fi

