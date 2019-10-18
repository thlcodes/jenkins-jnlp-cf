FROM golang:1.13-alpine as gosrc

FROM jenkins/jnlp-slave:alpine

USER root

RUN apk --update add git curl make gcc musl-dev g++
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing cloudfoundry-cli
RUN rm -rf /var/cache/apk/* 

ARG GO_BASE_PATH=/usr/local/go

COPY --from=gosrc ${GO_BASE_PATH} ${GO_BASE_PATH}
COPY --from=gosrc /go /go

RUN chown -R jenkins:jenkins /go

USER jenkins

ENV GOPATH /go
ENV PATH "${GOPATH}/bin:${GO_BASE_PATH}/bin:${PATH}"
ENV CGO_ENABLED 0

ENV mkdir -p $GOPATH

# Install some tools

RUN go get -u github.com/go-task/task/cmd/task
RUN go get -u gotest.tools/gotestsum
RUN go get -u github.com/tebeka/go2xunit
RUN go get -u github.com/axw/gocov/gocov
RUN go get -u github.com/AlekSi/gocov-xml
RUN go get -u github.com/matm/gocov-html

# Test binaries

RUN make --version

RUN curl --version

RUN cf version

RUN go version

RUN gotestsum --version
RUN go2xunit -version
RUN which go
RUN which gocov
RUN which gocov-xml
RUN which gocov-html

RUN ls -al $GOPATH/bin

WORKDIR ${HOME}

LABEL maintainer="thomas.liebeskind@gmail.com"