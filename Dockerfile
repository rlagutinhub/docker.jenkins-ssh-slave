# JENKINS DOCKER SLAVE
FROM oraclelinux:7-slim

MAINTAINER Lagutin R.A. <rlagutin@mta4.ru>

ARG JENKINS_USER
ARG JENKINS_GROUP
ARG JENKINS_HOME
ARG JENKINS_UID
ARG JENKINS_GID
ARG JENKINS_KEY

ENV JENKINS_USER=${JENKINS_USER:-jenkins} \
    JENKINS_GROUP=${JENKINS_GROUP:-jenkins} \
    JENKINS_HOME=${JENKINS_HOME:-/var/lib/jenkins} \
    JENKINS_UID=${JENKINS_UID:-997} \
    JENKINS_GID=${JENKINS_GID:-995} \
    JENKINS_KEY=${JENKINS_KEY:-id_rsa.pub}

RUN set -ex; \
    yum -y update; \
    mkdir -p /usr/share/man/man1; \
    yum -y --setopt=tsflags=nodocs --enablerepo ol7_optional_latest,ol7_developer_EPEL install \
    glibc glibc-common rootfiles \
    bash-completion tar gzip bzip2 zip unzip wget curl telnet procps findutils net-tools iproute bind-utils mailx less mc vim-minimal vim-enhanced \
    openssh openssh-clients openssh-server openssl \
    python3 python3-devel python3-pip \
    java-1.8.0-openjdk maven \
    git svn hg; \
    yum clean all

RUN set ex; \
    pip3 install -U \
    ipython

RUN set -ex; \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime

ENV LANG='ru_RU.UTF-8' LANGUAGE='ru_RU:ru' LC_ALL='ru_RU.UTF-8'
# ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN set -ex; \
    echo "PS1='\[\e[1;33m\][\u@\h \W]\$\[\e[0m\]'" > /etc/profile.d/bash-color.sh

RUN set -ex; \
    groupadd -r -g ${JENKINS_GID} ${JENKINS_GROUP}; \
    useradd -d ${JENKINS_HOME} -m -r -s /bin/bash -c "Jenkins Automation Server" -u ${JENKINS_UID} -g ${JENKINS_GID} ${JENKINS_USER}

RUN set -ex; \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa; \
    ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa; \
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

RUN set -ex; \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

RUN set -ex; \
    mkdir -p ${JENKINS_HOME}/.ssh; 
    
COPY ${JENKINS_KEY} ${JENKINS_HOME}/.ssh/authorized_keys

RUN set -ex; \
    chmod 700 ${JENKINS_HOME}/.ssh; chmod 600 ${JENKINS_HOME}/.ssh/authorized_keys; chown -R ${JENKINS_USER}:${JENKINS_GROUP} ${JENKINS_HOME}/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
