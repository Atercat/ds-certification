FROM hashicorp/terraform:1.2.4

# Install Ansible
RUN apk update \
    && apk add python3
RUN python3 -m ensurepip --upgrade \
    && python3 -m pip install --upgrade pip \
    && pip3 install ansible

# Remove ENTRYPOINT
ENTRYPOINT []