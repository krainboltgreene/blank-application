#!/usr/bin/env zsh

sudo update-locale LC_ALL=en_US.UTF-8 &&
asdf install &&
mix do local.hex --force, local.rebar --force
