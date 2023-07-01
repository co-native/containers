FROM debian:12

LABEL org.opencontainers.image.source=https://github.com/brandonp42/containers
LABEL org.opencontainers.image.description="Debian 12 toolbox container"

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y apt-utils aptitude build-essential \
                          ca-certificates curl dumb-init git gpg httpie iputils-ping jq less \
                          net-tools nmap postgresql-client procps s6 sudo tini unzip vim wget

CMD [ "tini", "-v", "--", "bash", "-l" ]

