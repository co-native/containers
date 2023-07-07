FROM quay.io/devfile/base-developer-image:ubi9-latest

USER 0

RUN dnf install -y nodejs
ENV VSCODE_NODEJS_RUNTIME_DIR="/usr/bin"

USER 10001
