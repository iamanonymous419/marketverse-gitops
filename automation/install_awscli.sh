#!/bin/bash

# ============================================================
# AWS CLI Installation Script
# ============================================================

echo "Checking if AWS CLI is installed..."
if command -v aws &>/dev/null; then
    echo "AWS CLI is already installed."
    aws --version
else
    echo "AWS CLI is not installed. Installing AWS CLI..."
    
    # Download AWS CLI installer
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    
    # Unzip and install
    unzip awscliv2.zip
    sudo ./aws/install

    # Cleanup
    rm -rf awscliv2.zip aws/

    echo "AWS CLI installed successfully."
    aws --version
fi

