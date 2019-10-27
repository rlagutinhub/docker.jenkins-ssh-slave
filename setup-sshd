#!/bin/bash

set -ex

function _term() {
    echo "Stopping container."
    echo "SIGTERM received, shutting down the server!"
    kill -15 $childPID
    exit 0 # 128+15
}

function _kill() {
    echo "SIGKILL received, shutting down the server!"
    kill -9 $childPID
    # exit 137 # 128+9
}

function write_key() {
    mkdir -p "${JENKINS_HOME}/.ssh"
    echo "$1" > "${JENKINS_HOME}/.ssh/authorized_keys"
    chown -Rf ${JENKINS_USER}:${JENKINS_GROUP} "${JENKINS_HOME}/.ssh"
    chmod 0700 "${JENKINS_HOME}/.ssh"
    chmod 0600 "${JENKINS_HOME}/.ssh/authorized_keys"
}

trap _term SIGTERM
trap _kill SIGKILL

if [[ $JENKINS_SSH_PUBKEY == ssh-* ]]; then write_key "${JENKINS_SSH_PUBKEY}"; fi

if [[ $# -gt 0 ]]; then
    if [[ $1 == ssh-* ]]; then write_key "$1"; shift 1; else exec "$@"; fi
fi

env | grep _ >> /etc/environment
ssh-keygen -A

/usr/sbin/sshd -D -e "${@}" &

childPID=$!
wait $childPID
