FROM alpine:3.7

ARG VERSION=1.3.1

ENV LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

RUN apk add --no-cache libcrypto1.0 libssl1.0 openssl-dev curl git build-base bash tar wget python yajl yajl-dev cmake coreutils &&\
  git clone --branch ${VERSION} --single-branch https://github.com/edenhill/kafkacat.git kafkacat &&\
  cd kafkacat &&\
  ./bootstrap.sh &&\
  make install &&\
  strip /usr/local/bin/kafkacat

FROM alpine:3.7

ARG BUILD_DATE
ARG SOURCE_COMMIT
ARG DOCKERFILE_PATH
ARG SOURCE_TYPE

RUN apk add --no-cache libcrypto1.0 libssl1.0 busybox-extras
COPY --from=0 /usr/local/bin/kafkacat /usr/local/bin/kafkacat

ADD inetd.conf /etc/inetd.conf
ADD belmulletais.sh /
RUN chmod +x /belmulletais.sh

RUN echo "belmulletais 2103/tcp" >> /etc/services

CMD ["inetd","-fe"]
