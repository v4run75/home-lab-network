#!/bin/bash

# Terraform Apply Script with Git Backend
# This script uses terraform-backend-git to run terraform apply with Git storage

set -e

echo "Running terraform apply with Git backend..."
terraform-backend-git git terraform --repository git@github.com:v4run75/home-lab-network-tf-state.git --ref main --state terraform.tfstate -- apply -var-file terraform.tfvars "$@"

