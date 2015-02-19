#!/usr/bin/env bash

ssh-keyscan github.com >> ~/.ssh/known_hosts
sudo chown vagrant:vagrant ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
git clone git@github.com:spacecow/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update
