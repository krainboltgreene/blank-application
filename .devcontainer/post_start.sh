#!/usr/bin/env bash
update-locale LC_ALL=en_US.UTF-8 &&
. $HOME/.asdf/asdf.sh &&
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc &&
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc &&
asdf install &&
mix do local.hex --force, local.rebar --force, deps.get, compile, dialyzer.build, ecto.reset &&
npm install --no-audit
# terraform init &&
# terraform apply &&
# eval "$(ssh-agent -s)" &&
# ssh-add ~/.ssh/codespaces
