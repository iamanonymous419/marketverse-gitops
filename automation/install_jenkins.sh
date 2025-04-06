#!/bin/bash

# ============================================================
# Jenkins Installation Script for Ubuntu
# ============================================================
# This script:
# - Installs Java (required for Jenkins)
# - Installs Jenkins
# - Starts the Jenkins service
# - Displays the initial admin password
#
# Supported OS: Ubuntu-based distributions
# ============================================================

install_java() {
    echo "Checking if Java is installed..."
    if command -v java &>/dev/null; then
        echo "✅ Java is already installed."
        java -version
    else
        echo "🔹 Installing Java (OpenJDK 17)..."
        sudo apt update
        sudo apt install -y openjdk-17-jdk
        echo "✅ Java installed successfully."
        java -version
    fi
}

install_jenkins() {
    echo "Checking if Jenkins is installed..."
    if command -v jenkins &>/dev/null; then
        echo "✅ Jenkins is already installed."
        jenkins --version
    else
        echo "🔹 Installing Jenkins..."
        
        # Add Jenkins repository key
        curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

        # Add Jenkins repository
        echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

        # Update package list and install Jenkins
        sudo apt update
        sudo apt install -y jenkins

        echo "✅ Jenkins installed successfully."
    fi
}

start_jenkins() {
    echo "🔹 Starting Jenkins service..."
    sudo systemctl enable jenkins
    sudo systemctl start jenkins

    echo "✅ Jenkins service started."
    echo "🔹 Checking Jenkins status..."
    sudo systemctl status jenkins --no-pager
}

display_admin_password() {
    echo "🔹 Fetching initial Jenkins admin password..."
    if [ -f "/var/lib/jenkins/secrets/initialAdminPassword" ]; then
        echo "✅ Jenkins is installed. Use the following password to unlock Jenkins:"
        sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    else
        echo "⚠️ Jenkins password file not found. Wait a few minutes and try:"
        echo "   sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    fi
}

echo "🚀 Starting Jenkins Installation..."
install_java
install_jenkins
start_jenkins
display_admin_password
echo "✅ Installation complete! Access Jenkins at: http://localhost:8080"
