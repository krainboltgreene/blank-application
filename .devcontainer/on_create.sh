#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh &&
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc &&
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc &&
sudo update-locale LC_ALL=en_US.UTF-8 &&
asdf install &&
mix do local.hex --force, local.rebar --force
