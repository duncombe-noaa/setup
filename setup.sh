#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get -y update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi

git clone https://github.com/duncombe/dotfiles.git

# link dotfiles to dotted files in the home directory
ln -sb dotfiles/vimrc .vimrc
ln -sb dotfiles/screenrc .screenrc
ln -sb dotfiles/bash_profile .bash_profile
ln -sb dotfiles/bashrc .bashrc
ln -sb dotfiles/bashrc_custom .bashrc_custom
ln -sf dotfiles/emacs.d .emacs.d

# these are commands that are needed to run node.js on the remote host

sudo apt-get -qq update
sudo apt-get -y install python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js

sudo apt-get -qq update
sudo apt-get -y install nodejs
# Install some node.js libraries 
npm install restler 
npm install cheerio
npm install commander
# npm install js-beautify 
sudo apt-get install tidy

# And get ready for heroku.
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Also want to check xml files (install xmllint).
sudo apt-get install libxml2-utils

