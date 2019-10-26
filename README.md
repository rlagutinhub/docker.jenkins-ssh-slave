# docker.jenkins-slave

```
docker build --build-arg JENKINS_KEY="jenkins-master.id_rsa.pub" -f Dockerfile -t docker.jenkins-slave:latest .
docker rm -f jenkins-slave; docker run -dit --name jenkins-slave --network bridge docker.jenkins-slave:latest
docker logs jenkins-slave --follow
docker exec -it jenkins-slave bash
```
