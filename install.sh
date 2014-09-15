#!/bin/bash
#
# Copyright 2013 Abraham Massry
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#
curl_installed=$(curl --version 2>&1)
freeSpaceK=$(df -k $HOME | tail -n 1| awk '{print $4}')
echoerr() { 
  echo "$@" 1>&2; 
}

bashInstall () {
#not sure that put alias in both bash_profile and bashrc is a good idea.
  if [[ ! -e "$HOME/.bashrc" || ! $(grep "alias wsend=" $HOME/.bashrc) ]]; then
      echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.bashrc
      echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.bash_profile
  fi
}

cshInstall () {
  if [[ ! -e "$HOME/.cshrc" || ! $(grep  "alias wsend=" $HOME/.cshrc) ]]
  then
		echo "alias wsend '$HOME/.wsend/wsend'" >> $HOME/.cshrc
	fi
}

kshInstall () {
  if [[ ! -e "$HOME/.kshrc"  || ! $(grep "alias wsend=" $HOME/.kshrc) ]]; then
      echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.kshrc
  fi
}

zshInstall () {
  if [[ ! -e "$HOME/.zshrc" || ! $(grep "alias wsend=" $HOME/.zshrc) ]]; then
      echo "alias -g wsend='$HOME/.wsend/wsend'" >> $HOME/.zshrc
  fi
}

downloadLastVersion() {
	curl -L -s -o $HOME/.wsend/wsend https://raw.githubusercontent.com/abemassry/wsend/master/wsend
	chmod +x $HOME/.wsend/wsend
    #supporting files as well
	curl -L -s -o $HOME/.wsend/README.md https://raw.githubusercontent.com/abemassry/wsend/master/README.md
	curl -L -s -o $HOME/.wsend/COPYING https://raw.githubusercontent.com/abemassry/wsend/master/COPYING
	curl -L -s -o $HOME/.wsend/version https://raw.githubusercontent.com/abemassry/wsend/master/version
	curl -L -s -o $HOME/.wsend/update.sh https://raw.githubusercontent.com/abemassry/wsend/master/update.sh
}

if [[ ! $curl_installed ]]; then
  echoerr -e "\e[01;31m"
  echoerr "error:   curl is required but it is not installed. Aborting";
  echoerr "error:   For ubuntu please run: sudo apt-get install curl";
  echoerr -e "\e[00m"
  exit 1;
fi

if [ -d "$HOME/.wsend" ]; then
  wsend_dir="$HOME/.wsend"
  #check version
  installedVersion=$(cat $wsend_dir/version)
  latestVersion=$(curl -L -s https://raw.githubusercontent.com/abemassry/wsend/master/version)
  if [ "$installedVersion" != "$latestVersion" ]; then
    echoerr -e "\033[01;36m"
    echoerr "info:    "
    echoerr "info:    new version detected, auto updating"
    echoerr "info:    "
    echoerr -e "\033[00m"
	downloadLastVersion
  fi
else
  # if not, install
  if [ "$freeSpaceK" -gt 100 ]; then
    mkdir $HOME/.wsend
	downloadLastVersion
  else
    echoerr "not enough free space to continue. Aborting";
    exit 1;
  fi
  #add alias to shell
  #execute alias command
  if [ $SHELL == "/bin/bash" ]; then
    bashInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend='$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/csh" ]; then
    cshInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend '$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/tcsh" ]; then
    cshInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend '$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/ksh" ]; then
    kshInstall
    echo "enter this to use the wsend command:"
    echo "alias wsend='$HOME/.wsend/wsend'"
  elif [ $SHELL == "/bin/zsh" ]; then
    zshInstall
    echo "enter this to use the wsend command:"
    echo "alias -g wsend='$HOME/.wsend/wsend'"
  fi # install done
fi # check for installation done
echo ''
echo "install done"
