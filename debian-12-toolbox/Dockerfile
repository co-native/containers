FROM debian:12

LABEL org.opencontainers.image.source=https://github.com/brandonp42/containers
LABEL org.opencontainers.image.description="Debian 12 toolbox container"

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
               apt-utils aptitude build-essential ca-certificates curl \
               dumb-init git gpg httpie iputils-ping jq less net-tools nmap \
               postgresql-client procps python3 sudo unzip vim wget

RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get update; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     \
     gcc -Wall /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps

ENTRYPOINT [ "dumb-init" ]
CMD [ "bash", "-l" ]

