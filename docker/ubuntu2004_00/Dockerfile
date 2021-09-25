# Download base image ubuntu 20.04
# docker build -t ubuntu2004:0000 .
# 00 is major 00 is minor, python3.8 by default
#  g++
FROM --platform=linux/amd64 ubuntu:20.04
LABEL maintainer="manuchen@home"
LABEL version="0.0"
LABEL description="base of ubuntu"
ENV TZ=Asia/Taipei
ENV APP="vim git curl build-essential g++ software-properties-common wget"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y $APP 
RUN echo EDITOR=vim >>~/.bashrc
