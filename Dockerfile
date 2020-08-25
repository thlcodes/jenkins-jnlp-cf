FROM jenkins/jnlp-slave:alpine

USER root
FROM jenkins/jnlp-slave:alpine

USER root

RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories
RUN apk --update add git curl gmp-dev gcc musl-dev g++ make libuv libgcc
RUN echo "===> Adding NPM..." 
RUN apk --update add "nodejs-npm"
RUN echo "===> Adding NodeJS..." 
RUN apk --update add "nodejs"
RUN echo "===> Adding YARN..." 
RUN apk --update add --no-cache yarn
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing cloudfoundry-cli

RUN rm -rf /var/cache/apk/*    

RUN node -v

RUN npm -v

RUN yarn -v

# install newman
RUN npm i -g newman

RUN newman -v

RUN cf version

WORKDIR $HOME

LABEL maintainer="thomas.liebeskind@gmail.com"
