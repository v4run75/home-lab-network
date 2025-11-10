# Terraform Scripts Usage Guide

This project uses `terraform-backend-git` to store Terraform state in a Git repository. The following scripts automate the process of starting the backend server, running Terraform commands, and cleaning up.

## Prerequisites

1. **terraform-backend-git** must be installed and in your PATH
   ```bash
   go install github.com/plumber-cd/terraform-backend-git@v0.1.8
   ```

2. **Git repository access** - Ensure you have access to the state repository:
   - Repository: `git@github.com:v4run75/home-lab-network-tf-state.git` (SSH)
   - **SSH Authentication required**: You need to set up SSH keys with GitHub

### SSH Authentication Setup

The backend uses SSH to authenticate with GitHub. You need to:

1. **Generate SSH key** (if you don't have one):
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. **Add SSH key to GitHub**:
   - Copy your public key: `cat ~/.ssh/id_ed25519.pub`
   - Go to GitHub → Settings → SSH and GPG keys → New SSH key
   - Paste your public key and save

3. **Test SSH connection**:
   ```bash
   ssh -T git@github.com
   ```
   You should see: "Hi username! You've successfully authenticated..."

## Available Scripts

### `./tf-init.sh`
Initialize Terraform with the Git backend.

```bash
./tf-init.sh
```

### `./tf-plan.sh`
Run `terraform plan` with the Git backend.

```bash
./tf-plan.sh
```

You can pass additional Terraform arguments:
```bash
./tf-plan.sh -out=tfplan
```

### `./tf-apply.sh`
Run `terraform apply` with the Git backend.

```bash
./tf-apply.sh
```

You can pass additional Terraform arguments:
```bash
./tf-apply.sh -auto-approve
./tf-apply.sh tfplan
```

### `./tf-destroy.sh`
Run `terraform destroy` with the Git backend.

```bash
./tf-destroy.sh
```

You can pass additional Terraform arguments:
```bash
./tf-destroy.sh -auto-approve
```

## How It Works

1. Each script starts the `terraform-backend-git` server in the background
2. Waits for the server to be ready
3. Runs the Terraform command
4. Automatically stops the backend server when done (even on errors)

## Configuration

The backend configuration uses SSH and is set in the scripts:

```hcl
git {
  repository = "git@github.com:*.git"
  ref = "main"
  state = "terraform.tfstate"
}
```

## Troubleshooting

### Backend server fails to start
- Check that `terraform-backend-git` is installed and in your PATH
- Verify Git credentials are configured
- Check `.terraform-backend-git.log` for error messages

### State lock issues
- The backend uses Git for state locking
- If a lock persists, check the state repository for lock files
- You may need to manually remove lock files from the Git repository

### Authentication issues
- Ensure your Git credentials are configured
- For HTTPS, you may need to use a personal access token
- Consider using SSH keys for better security

## Manual Backend Management

If you need to manage the backend manually:

```bash
# Start backend server
terraform-backend-git git --config terraform-backend-git.hcl

# In another terminal, run terraform commands
terraform plan -var-file terraform.tfvars

# Stop backend server
terraform-backend-git stop
```

