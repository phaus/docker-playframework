# PlayFramework 1.x Docker Images

We build this repository to maintain **[PlayFramework 1.x](https://github.com/playframework/play1/releases)** docker images for the latest MINOR and PATCH version of each **RELEASE 1.X**.

## Supported Versions

| Play Version | JDK Version | Image Tag |
|--------------|-------------|-----------|
| 1.11.0       | Eclipse Temurin 21.0.13 | `phaus/play:1.11.0-21.0.13-jdk` |
| 1.10.0       | Eclipse Temurin 21.0.13 | `phaus/play:1.10.0-21.0.13-jdk` |
| 1.9.0        | Eclipse Temurin 21.0.13 | `phaus/play:1.9.0-21.0.13-jdk` |
| 1.8.0        | Eclipse Temurin 21.0.13 | `phaus/play:1.8.0-21.0.13-jdk` |

All images are based on **[Eclipse Temurin](https://hub.docker.com/_/eclipse-temurin)** (Ubuntu jammy), minimalistic, with CA certs for HTTPS.

Play 1.11.0 requires Java 21 (drops Java 11). Play 1.10.0+ requires Java 17+ (jakarta.*, JUnit5).

# Build

```bash
# Build all versions via build matrix
./build-all.sh

# Or build single version
docker build --pull --build-arg PLAY_VERSION=1.11.0 --build-arg JDK_VERSION=21.0.13-jdk -t phaus/play:1.11.0-21.0.13-jdk .
```

# USAGE

### Development environment:

```bash
docker run -it --rm \
  -v $(pwd)/src:/app \
  phaus/play:1.11.0-21.0.13-jdk \
  play new test
```

With local Ivy/Maven cache for faster builds:

```bash
docker run -p 9000:9000 -d \
  -v ~/.ivy2:/root/.ivy2 \
  -v $(pwd)/src:/app \
  phaus/play:1.11.0-21.0.13-jdk \
  play run test
```

### As base image to pack your application:

```dockerfile
FROM phaus/play:1.11.0-21.0.13-jdk
MAINTAINER https://github.com/phaus

COPY src/ /app/

RUN echo y | play install sass-1.1 && \
  echo prod | play id

CMD ["play", "run"]
```
