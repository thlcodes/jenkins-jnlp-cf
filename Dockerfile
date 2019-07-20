FROM jenkins/jnlp-slave:alpine

USER root

RUN apk --update add sudo git curl 
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing cloudfoundry-cli

USER jenkins

RUN cf version

WORKDIR ${HOME}

LABEL maintainer="thomas.liebeskind@gmail.com"