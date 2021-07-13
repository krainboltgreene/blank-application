#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh &&
mix do deps.get, compile, dialyzer.build, ecto.reset &&
npm install --no-audit
# terraform init &&
# terraform apply &&
# eval "$(ssh-agent -s)" &&
# ssh-add ~/.ssh/codespaces
