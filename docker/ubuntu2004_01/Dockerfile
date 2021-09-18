# must build ubuntu2004:0000 in advance
# docker build -t ubuntu2004:0010 .
# 001x is for go
#
FROM ubuntu2004:0000
LABEL maintainer="manuchen@home"
LABEL version="0.0"
LABEL description="base of go"
ENV VER=1.14.8
RUN wget -c https://dl.google.com/go/go$VER.linux-amd64.tar.gz -O - | tar -xz -C /usr/local
RUN echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.bashrc
