#!/bin/bash
set -euxo pipefail

# ======================================
# Log User Data Output
# ======================================
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "========== Starting Server Configuration =========="

# ======================================
# Update System
# ======================================
apt-get update -y
apt-get upgrade -y

# ======================================
# Install Required Packages
# ======================================
apt-get install -y \
git \
docker.io \
curl \
wget \
conntrack \
apt-transport-https \
ca-certificates \
gnupg \
software-properties-common

# ======================================
# Enable Docker
# ======================================
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# ======================================
# Install kubectl
# ======================================
mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key \
| gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" \
> /etc/apt/sources.list.d/kubernetes.list

apt-get update -y
apt-get install -y kubectl

# ======================================
# Install Minikube
# ======================================
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

install minikube-linux-amd64 /usr/local/bin/minikube

rm minikube-linux-amd64

# ======================================
# Wait for Docker
# ======================================
sleep 15

# ======================================
# Start Minikube
# ======================================
sudo -u ubuntu -H bash <<EOF

export HOME=/home/ubuntu

minikube start \
    --driver=docker \
    --force

kubectl get nodes

EOF

# ======================================
# Verification
# ======================================
echo "Git Version:"
git --version

echo "Docker Version:"
docker --version

echo "Kubectl Version:"
kubectl version --client

echo "Minikube Version:"
minikube version

echo "========== Installation Finished =========="