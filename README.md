# docker.jenkins-slave

```
docker build -f Dockerfile -t docker.jenkins-slave:latest .
docker rm -f jenkins-slave; docker run -dit --name jenkins-slave --network bridge docker.jenkins-slave:latest
docker logs jenkins-slave --follow
docker exec -it jenkins-slave bash
```

# Jenkins SSH slave Docker image
```
```
This image is intended to be used for displaying x11 applications from container in a browser.
>	* Base image oraclelinux:7-slim

FYI https://github.com/rlagutinhub/docker_swarm-mode.novnc-internal-url

[`jenkins/ssh-slave`](https://github.com/jenkinsci/docker-ssh-slave)

A [Jenkins](https://jenkins-ci.org) slave using SSH to establish connection.

See [Jenkins Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds) for more info.

## Running

To run a Docker container

```bash
docker run jenkins/ssh-slave "<public key>"
```

You'll then be able to connect this slave using ssh-slaves-plugin as "jenkins" with the matching private key.

### How to use this image with Docker Plugin

To use this image with [Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin), you need to
pass the public SSH key using environment variable `JENKINS_SLAVE_SSH_PUBKEY` and not as a startup argument.

In _Environment_ field of the Docker Template (advanced section), just add:

    JENKINS_SLAVE_SSH_PUBKEY=<YOUR PUBLIC SSH KEY HERE>

Don't put quotes around the public key. You should be all set.
