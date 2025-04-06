#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "🔍 Checking for ArgoCD CLI..."

# Check if ArgoCD CLI is installed
if command_exists argocd; then
    echo "✅ ArgoCD CLI is already installed."
    echo "📌 Version: $(argocd version --client)"
else
    echo "⚡ Installing ArgoCD CLI..."
    
    # Detect OS Architecture
    ARCH=$(uname -m)
    if [[ "$ARCH" == "x86_64" ]]; then
        FILE="argocd-linux-amd64"
    elif [[ "$ARCH" == "arm64" ]]; then
        FILE="argocd-darwin-arm64"
    else
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
    fi

    # Download ArgoCD CLI
    curl -sSL -o argocd "https://github.com/argoproj/argo-cd/releases/latest/download/${FILE}"
    
    # Make it executable and move to /usr/local/bin
    chmod +x argocd
    sudo mv argocd /usr/local/bin/

    echo "✅ ArgoCD CLI installed successfully."
    echo "📌 Version: $(argocd version --client)"
fi
