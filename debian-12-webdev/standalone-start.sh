#!/usr/bin/env bash

if [ "$(id -u)" == "0" ]; then
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
fi

sleep infinity & PID=$!
trap "kill $PID" INT TERM
wait

if [ "$(id -u)" == "0" ]; then
    service ssh stop
fi
