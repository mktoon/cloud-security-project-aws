#!/bin/bash

# disable root SSH login, updates system packages, creates a limited user
# set firewall, install fail2ban to block brute force attempts

# Update package list and upgrade installed packages
apt update -y && apt upgrade -y

# Create a non-root user for secure access
adduser secureuser --disabled-password --gecos ""
usermod -aG sudo secureuser


# Disable root login via SSH
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password authentication (force SSH key use only)
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Restart SSH service to apply changes
systemctl restart sshd

# Install UFW firewall and set basic rules
apt install ufw -y
ufw allow OpenSSH
ufw allow 80/tcp
ufw --force enable

# Install fail2ban to prevent brute-force attacks
apt install fail2ban -y
systemctl enable fail2ban
systemctl start fail2ban

# Log basic setup info
echo "EC2 hardened setup complete" >> /var/log/setup.log