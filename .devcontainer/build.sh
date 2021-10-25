#!/usr/bin/env zsh

COMMIT=$(git rev-parse --short HEAD)

docker build \
  --tag ghcr.io/krainboltgreene/blank-application_devcontainer_codespace:latest \
  --tag ghcr.io/krainboltgreene/blank-application_devcontainer_codespace:$COMMIT \
  .
docker push ghcr.io/krainboltgreene/blank-application_devcontainer_codespace:latest
docker push ghcr.io/krainboltgreene/blank-application_devcontainer_codespace:$COMMIT
