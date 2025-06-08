# variables.tf
# AWS Region 
variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}
# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Public Subnet CIDR
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.10.0/24"
}

# Availability Zone
variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
  default     = "us-west-2a"
}

# 
variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-007d948a3621b6c3d" # Amazon Linux 2 (us-west-2)
}

# EC2 Instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the existing AWS EC2 Key Pair to SSH into instances"
  type        = string
  default     = "micahT"
}

variable "default_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "CloudSecurityPortfolio"
    Environment = "Dev"
    Owner       = "MicahT"
  }
}
