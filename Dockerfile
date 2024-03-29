# Dockerfile for development docker image

FROM python:3.12.2-slim-bookworm

WORKDIR /bot

# Install git

RUN apt-get -y update
RUN apt-get -y install git

# Add non-root user

ARG USERNAME=srm
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# Copy root directory and install project dependencies

ADD . .
RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "sleep", "infinity" ]