#!/usr/bin/env bash

sudo apt update
sudo apt install -y ruby-full git ruby-bundler build-essential &&  ruby -v && bundler -v
