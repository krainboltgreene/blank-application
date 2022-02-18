#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive &&
	apt-get install --no-install-recommends -y libncurses5 libwxgtk3.0-gtk3-dev libsctp1 libssh-dev xsltproc fop libxml2-utils &&
	curl -fSL -o erlang.deb https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_24.2.1-1~ubuntu~focal_amd64.deb &&
	dpkg -i erlang.deb &&
	rm erlang.deb
