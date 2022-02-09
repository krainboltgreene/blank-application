#!/usr/bin/env bash

curl -fSL -o erlang.deb https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_24.2.1-1~ubuntu~focal_amd64.deb &&
	dpkg -i erlang.deb &&
	rm erlang.deb
