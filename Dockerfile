FROM golang:alpine as gosrc

FROM jenkins/jnlp-slave:alpine

USER root

RUN apk --update add sudo git curl make gcc musl-dev g++
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing cloudfoundry-cli
RUN rm -rf /var/cache/apk/* 

USER jenkins

ARG GO_BASE_PATH=/usr/local/go

COPY --from=gosrc ${GO_BASE_PATH} ${GO_BASE_PATH}
COPY --from=gosrc /go ${HOME}/go

ENV GOPATH ${HOME}/go
ENV PATH "${GOPATH}/bin:${GO_BASE_PATH}/bin:${PATH}"
ENV CGO_ENABLED 0

# Test binaries

RUN make --version

RUN curl --version

RUN cf version

RUN go version

WORKDIR ${HOME}

LABEL maintainer="thomas.liebeskind@gmail.com"