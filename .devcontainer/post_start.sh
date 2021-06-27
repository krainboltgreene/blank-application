#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh &&
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc &&
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc &&
asdf global terraform 1.0.0 &&
terraform apply &&
mix do local.hex --force, local.rebar --force, deps.get, compile, dialyzer.build, ecto.setup &&
mix do compile, dialyzer.build, ecto.setup &&
npm install --no-audit
