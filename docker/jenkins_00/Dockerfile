# Download base image jenkins:jenkins x64
# docker build -t manu-jenkins:0000 .
# RUN:
#  docker run -d --name mj --user root -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock manu-jenkins:0000
# Check password: in /var/jenkins_home/secrets/initialAdminPassword
#  docker exec -it mj /bin/bash
# 00 is base
# must have USER root to avoid apt-key or something fail
FROM jenkins/jenkins:latest
LABEL maintainer="manuchen@home"
LABEL version="00.00"
LABEL description="base of jenkins"
USER root
ENV TZ=Asia/Taipei
ENV APP="apt-transport-https ca-certificates curl gnupg2 software-properties-common"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get -y install $APP && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && apt-get update && apt-get -y install docker-ce