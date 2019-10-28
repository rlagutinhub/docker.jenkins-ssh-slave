# Jenkins SSH slave Docker image
```
```
This image is intended to be used as Jenkins SSH Slave on docker. This is a modification of the official image [`jenkins/ssh-slave`](https://hub.docker.com/r/jenkins/ssh-slave/). See [Jenkins Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds) for more info.
> * Base image oraclelinux:7-slim

FYI https://github.com/jenkinsci/docker-ssh-slave
***

## Usage

To build a Docker image

```bash
docker build -f Dockerfile -t docker.jenkins-ssh-slave:latest .
```

To run a Docker container

```bash
docker run rlagutinhub/docker.jenkins-ssh-slave "<public key>"
```
or
```bash
docker run -e "JENKINS_SLAVE_SSH_PUBKEY=<public key>" rlagutinhub/docker.jenkins-ssh-slave
```

You'll then be able to connect this slave using ssh-slaves-plugin as "jenkins" with the matching private key.

### How to use this image with Docker Plugin

To use this image with [Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin), you need to
pass the public SSH key using environment variable `JENKINS_SLAVE_SSH_PUBKEY` and not as a startup argument.

In _Environment_ field of the Docker Template (advanced section), just add:

    JENKINS_SLAVE_SSH_PUBKEY=<YOUR PUBLIC SSH KEY HERE>

Don't put quotes around the public key. You should be all set.

## On DockerHub / GitHub
___
* DockerHub [rlagutinhub/docker.jenkins-ssh-slave](https://hub.docker.com/r/rlagutinhub/docker.jenkins-ssh-slave)
* GitHub [rlagutinhub/docker.jenkins-ssh-slave](https://github.com/rlagutinhub/docker.jenkins-ssh-slave)
