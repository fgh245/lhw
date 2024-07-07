#!/bin/bash

# Function to print a message with a timestamp
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Function to install Minikube
install_minikube() {
    log "Downloading Minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

    log "Installing Minikube..."
    sudo install minikube-linux-amd64 /usr/local/bin/minikube

    log "Cleaning up..."
    rm minikube-linux-amd64

    log "Setting up KUBE_CONFIG_PATH environment variable..."
    echo 'export KUBE_CONFIG_PATH=~/.kube/config' >> ~/.bashrc
    source ~/.bashrc

    log "Verifying Minikube installation..."
    minikube version

    log "Minikube installation completed successfully!"
}

# Function to install tfenv and Terraform
install_tfenv_and_terraform() {
    log "Cloning tfenv repository..."
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv

    log "Setting up tfenv..."
    echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc

    log "Installing 1.8.5 Terraform using tfenv..."
    tfenv install 1.8.5
    tfenv use 1.8.5

    log "Verifying Terraform installation..."
    terraform version

    log "Terraform installation completed successfully!"
}

# Check if Minikube is already installed
if command -v minikube &> /dev/null; then
    log "Minikube is already installed. Version: $(minikube version)"
else
    install_minikube
fi

# Check if a Minikube cluster is already running
if minikube status &> /dev/null; then
    log "Minikube cluster is already running."
    log "Setting up KUBE_CONFIG_PATH environment variable..."
    echo 'export KUBE_CONFIG_PATH=~/.kube/config' >> ~/.bashrc
    source ~/.bashrc
else
    log "Starting Minikube cluster..."
    minikube start --cpus='no-limit' --memory='8g' --kubernetes-version='stable' --cni='calico' --keep-context=true

    log "Setting up KUBE_CONFIG_PATH environment variable..."
    echo 'export KUBE_CONFIG_PATH=~/.kube/config' >> ~/.bashrc
    source ~/.bashrc

    log "Minikube cluster started successfully!"
fi

# Check if tfenv is already installed
if command -v tfenv &> /dev/null; then
    log "tfenv is already installed."
else
    install_tfenv_and_terraform
fi

# Check if Terraform is already installed
if command -v terraform &> /dev/null; then
    log "Terraform is already installed. Version: $(terraform version)"
else
    log "Installing Terraform..."
    install_tfenv_and_terraform
fi
