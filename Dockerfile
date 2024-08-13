ARG JDK_VERSION

FROM --platform=$BUILDPLATFORM eclipse-temurin:${JDK_VERSION}-jammy

LABEL maintainer="philipp@haussleiter.de"

RUN mkdir -p /app

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends curl unzip bash python3 && \
    rm -rf /var/lib/apt/lists/*

ARG PLAY_VERSION
ARG JDK_VERSION

RUN curl --location -s https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip > /tmp/play-${PLAY_VERSION}.zip \
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

RUN apt-get purge -y curl unzip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENV PLAY_VERSION=${PLAY_VERSION}
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="/opt/java/openjdk/bin:$PATH"
ENV PATH "/opt/play-${PLAY_VERSION}:$PATH"

RUN chmod +x /opt/play-${PLAY_VERSION}/play

WORKDIR /app

# EXPOSE 9000

CMD ["play"]
