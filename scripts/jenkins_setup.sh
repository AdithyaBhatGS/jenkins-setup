#!/bin/bash
set -eux
export DEBIAN_FRONTEND=noninteractive

# === Update Base Packages ===
sudo apt-get update -y
sudo apt-get install -y curl gnupg lsb-release software-properties-common fontconfig openjdk-21-jre ca-certificates

# === Install Jenkins ===
sudo mkdir -p /usr/share/keyrings

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# === Install Terraform (HashiCorp repo) ===
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# Refresh all package lists *after* repos are added
sudo apt-get update -y

# Install Jenkins & Terraform
sudo apt-get install -y jenkins terraform

# === Install AWS CLI (from snap, since apt repo is gone) ===
sudo snap install aws-cli --classic

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "✅ Jenkins, Terraform & AWS CLI installation completed successfully!"
