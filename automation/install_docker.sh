#!/bin/bash

# ===============================================
# Docker & Docker Compose Installation Script
# ===============================================
# This script checks if Docker and Docker Compose are installed on a Linux system.
# If they are installed, it displays their versions and exits.
# If they are not installed, it installs them.
#
# Features:
# - Uses functions for modularity
# - Checks if Docker and Docker Compose are installed
# - Installs Docker if not found
# - Installs Docker Compose if not found
# - Displays installation progress with echo messages
#
# Supported OS: Ubuntu-based distributions
# ===============================================

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

# Function to check and install Docker Compose
install_docker_compose() {
    echo "Checking if Docker Compose is installed..."
    if command -v docker-compose &>/dev/null; then
        echo "Docker Compose is already installed."
        docker-compose --version
    else
        echo "Docker Compose is not installed. Installing Docker Compose..."
        
        # Install Docker Compose
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose

        # Verify installation
        echo "Docker Compose installed successfully."
        docker-compose --version
    fi
}

# Main execution
echo "Starting Docker and Docker Compose installation process..."
install_docker
install_docker_compose
echo "Installation process completed!"
