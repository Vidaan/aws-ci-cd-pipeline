# Base image
FROM ubuntu:22.04

# Avoid interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# Versions - pinned for consistency across all builds
ENV TERRAFORM_VERSION=1.9.8
ENV AWSCLI_VERSION=2.17.0

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    ca-certificates \
    gnupg \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/terraform \
    && rm terraform.zip \
    && terraform --version

# Install AWS CLI v2
RUN curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip \
    -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws \
    && aws --version

# Create a non-root user for running terraform
RUN useradd -m -s /bin/bash tfrunner

# Set working directory
WORKDIR /workspace

# Switch to non-root user
USER tfrunner

# Default command
CMD ["terraform", "--version"]