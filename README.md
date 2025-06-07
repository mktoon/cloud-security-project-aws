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
