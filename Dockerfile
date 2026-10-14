FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN curl --fail --location --retry 3 \
      https://github.com/dikoy52/varylo-downloads/releases/download/v1.0.16-beta.1/app-runtime.tar.gz \
      --output /tmp/app-runtime.tar.gz \
    && echo "607fbe0f2a51c9aab60de8cc7dea8184ef0c22e2a9e0c7ad86c496bacf5cbbcb  /tmp/app-runtime.tar.gz" | sha256sum --check --strict \
    && tar -xzf /tmp/app-runtime.tar.gz -C /app \
    && rm /tmp/app-runtime.tar.gz

ENV CLOUD_MODE=1 \
    HOST=0.0.0.0 \
    APP_DATA_DIR=/app/data \
    OUTPUT_DIR=/app/data/renders \
    FFMPEG_PATH=/usr/bin/ffmpeg

EXPOSE 10000
CMD ["node", "server.js"]
