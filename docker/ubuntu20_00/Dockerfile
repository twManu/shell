# Download base image ubuntu 20.04
# docker build -t ubuntu20:manu00 .
# 00 is base, python3.8 by default
#  g++
FROM --platform=linux/amd64 ubuntu:20.04
LABEL maintainer="manuchen@home"
LABEL version="0.0"
LABEL description="base of ubuntu"
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y vim git curl build-essential g++ software-properties-common 
RUN echo EDITOR=vim >>~/.bashrc
