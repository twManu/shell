# must build ubuntu2004:0000 in advance
# docker build -t ubuntu2004:0110 .
# 01 is major 00 is minor
# for go
#
FROM ubuntu2004:0000
LABEL maintainer="manuchen@home"
LABEL version="0.0"
LABEL description="base of go"
ENV VER=1.14.8
RUN wget -c https://dl.google.com/go/go${VER}.linux-amd64.tar.gz -O - | tar -xz -C /usr/local && echo "export GOROOT=/usr/local/go" >>~/.bashrc && echo "export PATH=\${PATH}:\${GOROOT}/bin" >>~/.bashrc
