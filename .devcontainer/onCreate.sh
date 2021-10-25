#!/bin/zsh
source ~/.zshrc &&
sudo update-locale LC_ALL=en_US.UTF-8 &&
echo $CODESPACE_PACKAGE_TOKEN | docker login ghcr.io -u krainboltgreene --password-stdin
