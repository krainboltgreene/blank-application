#!/usr/bin/env zsh

. $HOME/.asdf/asdf.sh &&
mix do deps.get, compile, dialyzer.build, ecto.reset &&
npm install --no-audit &&
echo $CODESPACE_PACKAGE_TOKEN  | docker login ghcr.io -u krainboltgreene  --password-stdin
# terraform init &&
# terraform apply &&
# eval "$(ssh-agent -s)" &&
# ssh-add ~/.ssh/codespaces
