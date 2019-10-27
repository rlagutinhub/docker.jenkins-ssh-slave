# Jenkins SSH slave Docker image
```
```
This image is intended to be used as Jenkins SSH Slave on docker. This is a modification of the official image [`jenkins/ssh-slave`](https://hub.docker.com/r/jenkins/ssh-slave/). See [Jenkins Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds) for more info.
> * Base image oraclelinux:7-slim

FYI https://github.com/jenkinsci/docker-ssh-slave
***

## Usage

To run a Docker container

```bash
docker run rlagutinhub/jenkins.ssh-slave "<public key>"
```

You'll then be able to connect this slave using ssh-slaves-plugin as "jenkins" with the matching private key.

### How to use this image with Docker Plugin

To use this image with [Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin), you need to
pass the public SSH key using environment variable `JENKINS_SLAVE_SSH_PUBKEY` and not as a startup argument.

In _Environment_ field of the Docker Template (advanced section), just add:

    JENKINS_SSH_PUBKEY=<YOUR PUBLIC SSH KEY HERE>

Don't put quotes around the public key. You should be all set.
