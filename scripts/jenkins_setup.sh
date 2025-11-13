#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

# Update system packages
sudo apt update -y

# Install Java (required by Jenkins)
sudo apt install -y fontconfig openjdk-21-jre

# Add Jenkins repository key and repo
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install the jenkins
sudo apt update -y
sudo apt install -y jenkins

# Start and enable Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Optional: Print initial admin password for easy access
echo "Jenkins installation completed!"
