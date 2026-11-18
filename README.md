# PlayFramework 1.x Docker Images

We build this repository to maintain **[PlayFramework 1.x](https://github.com/playframework/play1/releases)** docker images for the latest MINOR and PATCH version of each **RELEASE 1.X**.

Images are published to **GitHub Container Registry**: `ghcr.io/phaus/docker-playframework`

## Supported Versions

| Play Version | JDK Version | Image Tag |
|--------------|-------------|-----------|
| 1.11.0       | Eclipse Temurin 25.0.5 (build 8) | `ghcr.io/phaus/docker-playframework:1.11.0-25.0.5_8-jdk` |
| 1.10.0       | Eclipse Temurin 25.0.5 (build 8) | `ghcr.io/phaus/docker-playframework:1.10.0-25.0.5_8-jdk` |
| 1.9.0        | Eclipse Temurin 25.0.5 (build 8) | `ghcr.io/phaus/docker-playframework:1.9.0-25.0.5_8-jdk` |
| 1.8.0        | Eclipse Temurin 25.0.5 (build 8) | `ghcr.io/phaus/docker-playframework:1.8.0-25.0.5_8-jdk` |
| **latest**   | Eclipse Temurin 25.0.5 (build 8) | `ghcr.io/phaus/docker-playframework:latest` (points to 1.11.0) |

All images are based on **[Eclipse Temurin](https://hub.docker.com/_/eclipse-temurin)** (Ubuntu jammy), minimalistic, with CA certs for HTTPS. Multi-platform: `linux/amd64`, `linux/arm64`.

Play 1.11.0 supports Java 21+ (drops Java 11). Play 1.10.0+ requires Java 17+ (jakarta.*, JUnit5). Images use Eclipse Temurin 25 (LTS, Sept 2026+ support).

# Build

### Automated (GitHub Actions)

Images are built and pushed on every push to `master` and on version tags (`v*`). See [`.github/workflows/docker-build.yml`](.github/workflows/docker-build.yml).

### Local

```bash
# Build all versions via build matrix (pushes to Docker Hub)
./build-all.sh

# Or build single version locally
docker build --pull --build-arg PLAY_VERSION=1.11.0 --build-arg JDK_VERSION=25.0.5_8-jdk -t ghcr.io/phaus/docker-playframework:1.11.0-25.0.5_8-jdk .
```

# USAGE

### Development environment (GitHub Container Registry):

```bash
docker run -it --rm \
  -v $(pwd)/src:/app \
  ghcr.io/phaus/docker-playframework:1.11.0-25.0.5_8-jdk \
  play new test
```

With local Ivy/Maven cache for faster builds:

```bash
docker run -p 9000:9000 -d \
  -v ~/.ivy2:/root/.ivy2 \
  -v $(pwd)/src:/app \
  ghcr.io/phaus/docker-playframework:1.11.0-25.0.5_8-jdk \
  play run test
```

### As base image to pack your application:

```dockerfile
FROM ghcr.io/phaus/docker-playframework:1.11.0-25.0.5_8-jdk
MAINTAINER https://github.com/phaus

COPY src/ /app/

RUN echo y | play install sass-1.1 && \
  echo prod | play id

CMD ["play", "run"]
```

### Pull specific version:

```bash
# Specific Play version with pinned JDK
docker pull ghcr.io/phaus/docker-playframework:1.11.0-25.0.5_8-jdk

# Or just latest (points to 1.11.0)
docker pull ghcr.io/phaus/docker-playframework:latest
```
