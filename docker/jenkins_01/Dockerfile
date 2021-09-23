# Download base image jenkins/jenkins:latest
# docker build -t manu-jenkins:0001 .
# RUN:
#  docker run -d --name mj --user root -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock manu-jenkins:0001
# Check password: in /var/jenkins_home/secrets/initialAdminPassword
#  docker exec -it mj /bin/bash
# 00 is base
# must have USER root to avoid apt-key or something fail
FROM jenkins/jenkins:latest
LABEL maintainer="manuchen@home"
LABEL version="0.0"
LABEL description="jenkins for Q8Vista"
USER root
ENV VER=1.14.15
ENV APP="apt-transport-https ca-certificates curl gnupg2 software-properties-common make autoconf automake autopoint bison flex gperf libtool libtool-bin libtool lzip p7zip-full intltool-debian intltool libgtk2.0-dev python golang ruby npm wget cpio rsync bc gcc-mingw-w64 g++-mingw-w64 libssl-dev"
RUN apt-get update && apt-get -y install $APP && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && apt-get update && apt-get -y install docker-ce
RUN wget -c https://dl.google.com/go/go${VER}.linux-amd64.tar.gz -O - | tar -xz -C /usr/local && echo "export GOPATH=/usr/local/go" >>~/.bashrc && echo "export PATH=\$PATH:\$GOPATH/bin" >>~/.bashrc
