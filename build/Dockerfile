FROM docker:20.10-git
ARG TERRAFORM=https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_windows_amd64.zip
RUN apk update && apk add python3
RUN wget ${TERRAFORM}