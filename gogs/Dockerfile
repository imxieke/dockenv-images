FROM ubuntu:trusty
MAINTAINER Xiekers <im@xieke.org>

#Replace Sources.list To Ustc mirrors
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
#ADD https://coding.net/u/imxieke/p/Tools/git/raw/master/Sources/sources.list /etc/apt/sources.list

#SET SYSTEM VARIABLE
ENV GOGS gogs_v0.9.13_linux_amd64.zip
RUN apt-get update && apt-get install -y apt-transport-https golang git curl wget unzip && mkdir -p $HOME/local/go
RUN echo 'export GOROOT=$HOME/local/go' >> $HOME/.bashrc && echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
RUN echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc && source $HOME/.bashrc

#install gogs
RUN wget http://7d9nal.com2.z0.glb.qiniucdn.com/$GOGS && unzip $GOGS && cd $HOME/gogs && ./gogs web
VOLUME ["/data"]
EXPOSE 22 80 443 3000
