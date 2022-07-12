FROM docker:20.10-git

ARG TERRAFORM=https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_windows_amd64.zip
ARG GIT_REPO

# Install Ansible
RUN apk update \
    && apk add python3
RUN python3 -m ensurepip --upgrade \
    && python3 -m pip install --upgrade pip \
    && pip3 install ansible

# Install Terraform
RUN wget ${TERRAFORM} -O terraform.zip \
    && unzip terraform.zip -d /usr/bin \
    && rm terraform.zip