FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN curl --fail --location --retry 3 \
      https://github.com/dikoy52/varylo-downloads/releases/download/v1.0.19-beta.1/app-runtime.tar.gz \
      --output /tmp/app-runtime.tar.gz \
    && echo "135294cec6e6235708ecb0f0670626c799f8eeff894d49ad15ba3b9f45c835a5  /tmp/app-runtime.tar.gz" | sha256sum --check --strict \
    && tar -xzf /tmp/app-runtime.tar.gz -C /app \
    && rm /tmp/app-runtime.tar.gz

ENV DESKTOP_DOWNLOAD_URL=https://github.com/dikoy52/varylo-downloads/releases/download/v1.0.19-beta.1/Varylo-Setup.exe \
    CLOUD_MODE=1 \
    HOST=0.0.0.0 \
    APP_DATA_DIR=/app/data \
    OUTPUT_DIR=/app/data/renders \
    FFMPEG_PATH=/usr/bin/ffmpeg

EXPOSE 10000
CMD ["node", "server.js"]
