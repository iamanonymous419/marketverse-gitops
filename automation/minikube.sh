#!/bin/bash

# ============================================================
# Minikube Startup Script
# ============================================================
# This script:
# - Starts Minikube using Docker as the driver
# - Verifies if Minikube started successfully
#
# Run this after running `install_k8s_minikube.sh`
# ============================================================

echo "🚀 Starting Minikube with Docker..."
minikube start --driver=docker

if minikube status &>/dev/null; then
    echo "✅ Minikube cluster started successfully!"
else
    echo "❌ Failed to start Minikube cluster."
fi

