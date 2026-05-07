# Base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=1.9.8
ENV AWSCLI_VERSION=2.17.0

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    ca-certificates \
    gnupg \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/terraform \
    && rm terraform.zip \
    && terraform --version

RUN curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip \
    -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws \
    && aws --version

RUN useradd -m -s /bin/bash tfrunner

# Give tfrunner ownership of /workspace
RUN mkdir -p /workspace && chown -R tfrunner:tfrunner /workspace

WORKDIR /workspace
USER tfrunner

CMD ["terraform", "--version"]