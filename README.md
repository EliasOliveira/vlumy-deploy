# Vlumy deploy installation

## Tools
Portainer
```bash
sudo docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```
```bash
sudo docker run -d \
-p 9001:9001 \
--name portainer_agent \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /var/lib/docker/volumes:/var/lib/docker/volumes \
portainer/agent:2.16.2
```
## Docker

### build docker image

Create the docker image of Vlumy Jenkins 

```bash
sudo docker build -t vlumy-jenkins-blueocean:2.426.2-1 .
```

### run docker container

Run the docker container with the image created

```bash
sudo docker run   --name jenkins-blueocean     \
             --restart=on-failure         \
             --detach   --network jenkins \
             --env DOCKER_HOST=tcp://docker:2376 \
             --env DOCKER_CERT_PATH=/certs/client \
             --env DOCKER_TLS_VERIFY=1 \
             --publish 8080:8080 \
             --publish 50000:50000 \
             --volume jenkins-data:/var/jenkins_home \
             --volume jenkins-docker-certs:/certs/client:ro \
             vlumy-jenkins-blueocean:2.426.2-1
```