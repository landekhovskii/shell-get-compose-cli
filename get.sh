#!/bin/bash

DOCKER_PATH=$(which docker)
if [[ -z "$DOCKER_PATH" ]]; then
  echo "Docker not found!"
  exit 1
fi

CURL_PATH=$(which curl)
if [[ -z "$CURL_PATH" ]]; then
  echo "Curl not found!"
  exit 1
fi

COMPOSE_LATEST_URL=$(curl -sSL https://api.github.com/repos/docker/compose/releases/latest | grep '/docker-compose-linux-x86_64"' | cut -d '"' -f 4)

echo "Download compose cli from: $COMPOSE_LATEST_URL"

if [[ ! -d "/usr/local/bin" ]]; then
  mkdir -p /usr/local/bin
fi

curl -sSL "$COMPOSE_LATEST_URL" -o /usr/local/bin/compose-cli
chmod 755 /usr/local/bin/compose-cli

if [[ ! -d "/usr/local/lib/docker/cli-plugins" ]]; then
  mkdir -p /usr/local/lib/docker/cli-plugins
fi

cp /usr/local/bin/compose-cli /usr/local/lib/docker/cli-plugins/compose-cli

compose-cli version

exit 0
