FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN curl --fail --location --retry 3 \
      https://github.com/dikoy52/varylo-downloads/releases/download/v1.0.18-beta.1/app-runtime.tar.gz \
      --output /tmp/app-runtime.tar.gz \
    && echo "a243ad4c7e58e4ca80f1aac178f8cada0c96a0fc13e1203611955ae4b6e93f23  /tmp/app-runtime.tar.gz" | sha256sum --check --strict \
    && tar -xzf /tmp/app-runtime.tar.gz -C /app \
    && rm /tmp/app-runtime.tar.gz

ENV DESKTOP_DOWNLOAD_URL=https://github.com/dikoy52/varylo-downloads/releases/download/v1.0.18-beta.1/Varylo-Setup.exe \
    CLOUD_MODE=1 \
    HOST=0.0.0.0 \
    APP_DATA_DIR=/app/data \
    OUTPUT_DIR=/app/data/renders \
    FFMPEG_PATH=/usr/bin/ffmpeg

EXPOSE 10000
CMD ["node", "server.js"]
