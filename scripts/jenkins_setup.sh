#!/bin/bash
set -e

# Update system packages
sudo apt-get update -y

# Install Java (required by Jenkins)
sudo apt-get install -y openjdk-11-jdk

# Add Jenkins repository key and repo
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update -y
sudo apt-get install -y jenkins git unzip

# Start and enable Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Optional: Print initial admin password for easy access
echo "Jenkins installation completed!"
echo "Initial admin password (you can get it anytime with 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'):"
