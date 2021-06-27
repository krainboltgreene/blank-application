#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh &&
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc &&
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc &&
asdf shell elixir 1.12.1-otp-24 &&
asdf shell nodejs 16.4.0 &&
asdf shell terraform 1.0.1 &&
mix do local.hex --force, local.rebar --force, deps.get, compile, dialyzer.build, ecto.setup &&
mix do compile, dialyzer.build, ecto.setup &&
npm install --no-audit &&
terraform init &&
terraform apply &&
eval "$(ssh-agent -s)" &&
ssh-add ~/.ssh/codespaces
