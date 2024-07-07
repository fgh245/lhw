#!/bin/bash

# Function to print a message with a timestamp
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Define variables
TF_DIR="../terraform"  # Update this with your Terraform directory path

# Change to the Terraform directory
cd $TF_DIR

log "Initialize Terraform..."
terraform init

log "Run terraform apply"
terraform apply -auto-approve
