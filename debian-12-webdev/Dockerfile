FROM debian:12

LABEL org.opencontainers.image.source=https://github.com/brandonp42/containers
LABEL org.opencontainers.image.description="Debian 12 webdev container"

RUN rm -f /etc/apt/apt.conf.d/docker-clean \
    && echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends apt-transport-https auto-apt-proxy

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
               apt-utils build-essential ca-certificates curl dumb-init git \
	       gpg iputils-ping jq less net-tools nmap procps redis-tools s6 \
	       sudo tini unzip vim

RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     gcc -Wall /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c

# install specific packages for this container
ARG PHP_VERSION=8.2
ARG NODE_VERSION=18

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    export DEBIAN_FRONTEND=noninteractive \
    && curl https://public.dhe.ibm.com/software/ibmi/products/odbc/debs/dists/1.1.0/ibmi-acs-1.1.0.list > /etc/apt/sources.list.d/ibmi-acs-1.1.0.list \
    && curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y --no-install-recommends \
               aptitude httpie postgresql-client wget \
               ibm-iaccess unixodbc-dev nginx nodejs openssh-client openssh-server \
               php${PHP_VERSION} php${PHP_VERSION}-dom php${PHP_VERSION}-mbstring php${PHP_VERSION}-fpm php${PHP_VERSION}-xdebug

COPY --from=composer/composer /usr/bin/composer /usr/local/bin/composer

# add user for eclipse-che
RUN addgroup --gid 1234 user \
    && adduser --uid 1234 --gid 1234 --disabled-password --gecos "" user \
    && mkdir /projects \
    && chown 1234:1234 /projects \
    && chmod 00755 /projects

# define the startup process
COPY . /

ENV VSCODE_NODEJS_RUNTIME_DIR="/usr/bin"

ENTRYPOINT [ "dumb-init" ]
CMD ["/standalone-start.sh"]
