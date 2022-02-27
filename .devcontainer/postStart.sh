#!/bin/zsh

mix do local.hex --force, local.rebar --force &&
mix do deps.get, compile &&
mix dialyzer.build
