#!/bin/sh

cp -i bash_profile ~/.bash_profile
cp -i vimrc ~/.vimrc
cp -i gvimrc ~/.gvimrc
cp -i bashrc ~/.bashrc

source ~/.bashrc

git_setup

echo "Please run the following commands to finish the installation:"
echo ". ~/.bashrc"
