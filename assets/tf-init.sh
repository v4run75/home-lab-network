#!/bin/bash

# Terraform Init Script with Git Backend
# This script uses terraform-backend-git to run terraform init with Git storage

set -e

echo "Running terraform init with Git backend..."
terraform-backend-git git terraform --repository git@github.com:v4run75/home-lab-network-tf-state.git --ref main --state terraform.tfstate -- init "$@"

