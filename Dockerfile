FROM openjdk:8-jre-alpine

LABEL maintainer="philipp@haussleiter.de"

RUN mkdir -p /app

RUN apk upgrade \
      && apk --no-cache add curl unzip bash python

# ENV PLAY_VERSION __PLAY_VERSION__
ARG PLAY_VERSION

RUN curl --location -s https://downloads.typesafe.com/play/${PLAY_VERSION}/play-${PLAY_VERSION}.zip > /tmp/play-${PLAY_VERSION}.zip \
      && unzip -q /tmp/play-${PLAY_VERSION}.zip -d /opt \
      && rm -rf /tmp/play-${PLAY_VERSION}.zip \
            /opt/play-${PLAY_VERSION}/COPYING \
            /opt/play-${PLAY_VERSION}/documentation \
            /opt/play-${PLAY_VERSION}/framework/test \
            /opt/play-${PLAY_VERSION}/play.bat \
            /opt/play-${PLAY_VERSION}/python/*.dll \
            /opt/play-${PLAY_VERSION}/python/python.* \
            /opt/play-${PLAY_VERSION}/README.textile \
            /opt/play-${PLAY_VERSION}/samples \
            /opt/play-${PLAY_VERSION}/support

RUN apk del --purge curl unzip \
      && rm -fr /var/cache/apk/*

ENV PATH /opt/play-${PLAY_VERSION}:$PATH

RUN chmod +x /opt/play-${PLAY_VERSION}/play

WORKDIR /app

# EXPOSE 9000

CMD ["play"]
