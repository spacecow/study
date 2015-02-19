#!/usr/bin/env bash

cd /vagrant

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

gem install bundler
rbenv rehash
bundle
