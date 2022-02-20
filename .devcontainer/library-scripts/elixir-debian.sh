#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive &&
	apt-get install --no-install-recommends -y inotify-tools &&
	curl -fSL -o elixir.deb https://packages.erlang-solutions.com/erlang/debian/pool/elixir_1.13.0-1~ubuntu~focal_all.deb &&
	dpkg -i elixir.deb &&
	rm elixir.deb &&
	mix do local.hex --force, local.rebar --force
