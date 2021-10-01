# Download base image manu-jenkins:0000
# docker build -t manu-jenkins:0100 .
# RUN:
#  docker run -d --name mj --user root -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v <host_jenkins_home>:/var/jenkins_home manu-jenkins:0100
# Check password: in /var/jenkins_home/secrets/initialAdminPassword
#  docker exec -it mj /bin/bash
# NOTE:
#  jenkins shell use sh (dash), at top of script use "#!/bin/bash" without any blank to make .bashrc working
# 00 is major 00 is minor
# 01 is major 00 is minor
# must have USER root to avoid apt-key or something fail
#
# Suggested modules:
# 1. Copy Artifact
# 2. Pipeline Utility Steps
FROM manu-jenkins:0000
LABEL maintainer="manuchen@home"
LABEL version="01.00"
LABEL description="jenkins for Q8Vista"
USER root
ENV VER=1.14.15
ENV APP="make autoconf automake autopoint bison flex gperf libtool libtool-bin libtool lzip p7zip-full intltool-debian intltool libgtk2.0-dev python ruby npm wget cpio rsync bc gcc-mingw-w64 g++-mingw-w64 libssl-dev libelf-dev"
RUN apt-get update && apt-get -y install $APP
RUN wget -c https://dl.google.com/go/go${VER}.linux-amd64.tar.gz -O - | tar -xz -C /usr/local && echo "export GOROOT=/usr/local/go" >>~/.bashrc && echo "export PATH=\${PATH}:\${GOROOT}/bin" >>~/.bashrc
