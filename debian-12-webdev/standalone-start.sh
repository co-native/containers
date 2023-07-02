#!/usr/bin/env bash

systemctl enable ssh
service ssh start

if [ ! -z "${TZ}" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    echo $TZ > /etc/timezone
fi

if [ ! -z "${SSH_KEY}" ]; then
    mkdir -p /etc/skel/.ssh 
    chmod 700 /etc/skel/.ssh
    echo "${SSH_KEY}" > /etc/skel/.ssh/authorized_keys
    chmod 0600 /etc/skel/.ssh/authorized_keys
fi

if [ ! -z "${SSH_USER}" ]; then
    adduser --disabled-password --gecos "" ${SSH_USER}
    echo "${SSH_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${SSH_USER}
fi

sleep infinity & PID=$!
trap "kill $PID" INT TERM
wait

service ssh stop

