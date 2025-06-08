# 🛡️ Secure Cloud Architecture on AWS (Free Tier)

![Terraform](https://github.com/yourusername/cloud-security-project-aws/actions/workflows/terraform.yml/badge.svg)

## Project Overview
This project demonstrates how to design and implement a secure-by-default AWS cloud architecture using **Terraform** and **free-tier AWS resources**. It follows best practices in network segmentation, access control, logging, and Infrastructure as Code (IaC). The project is deployable end-to-end using Terraform and automated with GitHub Actions.

## Problem Statement
Cloud misconfigurations are a major cause of data breaches. This project aims to show how developers, engineers, and students can design and deploy secure AWS environments—starting with fundamentals like:
- Proper VPC design
- Controlled access with IAM and Security Groups
- Logging and monitoring

## Objectives
- Provision an isolated and secure VPC with public subnets
- Launch a hardened EC2 instance inside the VPC
- Define strict ingress/egress rules using Security Groups and NACLs
- Apply least-privilege IAM policies
- Enable logging with VPC Flow Logs and AWS CloudTrail
- Automate deployment using Terraform and GitHub Actions

## Architecture Diagram
*See [`architecture/vpc_diagram.png`](architecture/vpc_diagram.png)*

## Project Scope
### In-Scope:
- AWS VPC, subnets, EC2, internet gateway, security groups, IAM roles
- Infrastructure-as-Code with Terraform
- Instance hardening via bootstrap script
- Basic cloud monitoring
- GitHub Actions integration for Terraform workflows

### Out-of-Scope:
- High availability, multi-region replication
- Premium AWS services (e.g., GuardDuty, Shield)
- Serverless or container-based architecture

## Project Structure
```
cloud-security-project-aws/
├── .github/workflows/terraform.yml      # GitHub Actions CI
├── architecture/vpc_diagram.png         # Network architecture diagram
├── terraform/                           # All Terraform IaC files
├── scripts/instance_setup.sh            # EC2 instance bootstrap script
├── security/                            # Security group and IAM documentation
├── logs-monitoring/                     # CloudTrail and flow log setup
├── documentation/                       # Setup instructions, risk assessment
├── .gitignore
├── LICENSE
└── README.md
```

## Prerequisites
- AWS Free Tier Account
- AWS CLI configured (`aws configure`)
- Terraform v1.6+
- Git & GitHub account
- Visual Studio Code (recommended)

### 🔐 Ensure the SSH Key Pair Exists

Before running `terraform apply`, verify that the required key pair exists in the selected AWS region:


aws ec2 describe-key-pairs --key-names <your-key-name> --region <your-region>

If it doesn't exist, create it:

aws ec2 create-key-pair --key-name <your-key-name> \
  --query "KeyMaterial" --output text > ~/.ssh/<your-key-name>.pem
chmod 400 ~/.ssh/<your-key-name>.pem

Update key_pair_name in terraform.tfvars accordingly.

pgsql
Copy code

---

## ✅ 2. Add a Terraform `local-exec` Pre-Check

You can add a **Terraform null resource** to perform a runtime pre-check for the key pair via `AWS CLI`.

> ⚠️ This doesn’t stop the plan/apply automatically but will log a warning if the key isn’t found.

### 📄 Add to `main.tf`


resource "null_resource" "check_keypair_exists" {
  provisioner "local-exec" {
    command = <<EOT
      aws ec2 describe-key-pairs --key-names "${var.key_pair_name}" --region ${var.aws_region} > /dev/null 2>&1
      if [ $? -ne 0 ]; then
        echo "ERROR: Key pair '${var.key_pair_name}' not found in region '${var.aws_region}'."
        echo "Please create it before running terraform apply."
        exit 1
      fi
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
💡 Terraform will run this check before creating any resources.

## Quick Start
cd terraform
terraform init
terraform apply


## Deployment & Hardening Checklist
- [x] Terraform scripts for VPC, EC2, IAM
- [x] Hardened EC2 via user data script
- [x] Security groups with tight rules
- [x] IAM policy with least privilege
- [x] VPC Flow Logs + CloudTrail
- [x] GitHub Actions CI setup


---------------------------------------------------------------------------------------------------------------------------------------------------

> Created by Micah Too as a secure cloud infrastructure reference architecture for learning and portfolio presentation.
B.A. Computer Science - New Mexico State University
