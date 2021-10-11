#!/usr/bin/env zsh

mix do deps.get, compile &&
npm install --no-audit &&
mix dialyzer.build &
mix ecto.reset &
echo $CODESPACE_PACKAGE_TOKEN | docker login ghcr.io -u krainboltgreene --password-stdin
# terraform init &&
# terraform apply &&
# eval "$(ssh-agent -s)" &&
# ssh-add ~/.ssh/codespaces
