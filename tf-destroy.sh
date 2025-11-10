#!/bin/bash

# Terraform Destroy Script with Git Backend
# This script uses terraform-backend-git to run terraform destroy with Git storage

set -e

echo "Running terraform destroy with Git backend..."
terraform-backend-git git terraform --repository git@github.com:v4run75/home-lab-network-tf-state.git --ref main --state terraform.tfstate -- destroy -var-file terraform.tfvars "$@"

