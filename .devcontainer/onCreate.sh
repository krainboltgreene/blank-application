#!/bin/zsh
source ~/.zshrc &&
echo $CODESPACE_PACKAGE_TOKEN | docker login ghcr.io -u krainboltgreene --password-stdin
