#!/bin/bash
#kickstart new machine

/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

#add homebrew cask repo
brew tap caskroom/cask

#install gui-based app packages
brew cask install iterm2

brew cask install google-chrome

brew cask install firefox

brew cask install shiftit

brew cask install sublime-text

brew cask install 1password

brew cask install dropbox

brew cask install spotify

brew cask install virtualbox

brew cask install virtualbox-extension-pack

brew cask install utorrent

brew cask install docker

brew cask install alfred

brew cask install vagrant

brew cask install atom


#add cli tools
brew install python3

brew install pwgen

brew install zsh

brew install zsh-autosuggestions


