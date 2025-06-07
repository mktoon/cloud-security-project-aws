# output.tf defines the outputs
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "ec2_public_ip" {
  description = "Public IP of EC2 Instance"
  value       = aws_instance.web.public_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web_sg.id
}
