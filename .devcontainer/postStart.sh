#!/bin/zsh

mix do local.hex --force, local.rebar --force &&
mix do deps.get, compile &&
npm install --no-audit &&
mix ecto.reset &&
mix dialyzer.build
