# main.tf

# Pre-Check: Ensure the specified key pair exists in the region
resource "null_resource" "check_keypair_exists" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Checking if key pair '${var.key_pair_name}' exists in region '${var.aws_region}'..."
      aws ec2 describe-key-pairs --key-names "${var.key_pair_name}" --region ${var.aws_region} > /dev/null 2>&1
      if [ $? -ne 0 ]; then
        echo "ERROR: Key pair '${var.key_pair_name}' not found in region '${var.aws_region}'."
        echo "FIX: Create it using: aws ec2 create-key-pair --key-name ${var.key_pair_name} --query \"KeyMaterial\" --output text > ~/.ssh/${var.key_pair_name}.pem"
        echo "Then re-run terraform."
        exit 1
      fi
      echo "Key pair '${var.key_pair_name}' verified."
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  # Run only during creation; no dependencies required
  triggers = {
    always_run = timestamp()
  }
}

# createa  VPC with DNS support
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.default_tags, {
    Name = "main-vpc"
  })
}

# Creates an internet gateway to enable internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, {
    Name = "main-igw"
  })
}

# creates a public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = merge(var.default_tags, {
    Name = "public-subnet"
  })
}

# this  creates a RT with internet access and associates it with the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.default_tags, {
    Name = "public-rt"
  })
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# creates a security group allowing SSH and HTTP
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name = "web-security-group"
  })
}

# creates a  EC2 instance
resource "aws_instance" "web" {
  ami                    = "ami-007d948a3621b6c3d" # replace this with a valid AMI ID
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_pair_name
  user_data              = file("${path.module}/../scripts/instance_setup.sh")

  tags = merge(var.default_tags, {
    Name = "web-instance"
  })
}
