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
curl_installed=`curl --version 2>&1`
freeSpaceK=`df -k $HOME | tail -n 1 | head -n 1 | awk '{print $4}'`
bashInstall () {
 if [ -e "$HOME/.bashrc" ]; then
   als_set=`grep "alias wsend=" $HOME/.bashrc`
   if [ "$als_set" ]; then
     #do nothing
     true
   else
     echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.bashrc
   fi
 else
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.bashrc
 fi
}
cshInstall () {
 if [ -e "$HOME/.cshrc" ]; then
   als_set=`grep "alias wsend " $HOME/.cshrc`
   if [ "$als_set" ]; then
     #do nothing
     true
   else
     echo "alias wsend '$HOME/.wsend/wsend'" >> $HOME/.cshrc
   fi
 else
   echo "alias wsend '$HOME/.wsend/wsend'" >> $HOME/.cshrc
 fi
}

kshInstall () {
 if [ -e "$HOME/.kshrc" ]; then
   als_set=`grep "alias wsend=" $HOME/.kshrc`
   if [ "$als_set" ]; then
     #do nothing
     true
   else
     echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.kshrc
   fi
 else
   echo "alias wsend='$HOME/.wsend/wsend'" >> $HOME/.kshrc
 fi
}

zshInstall () {
 if [ -e "$HOME/.zshrc" ]; then
   als_set=`grep "alias wsend=" $HOME/.zshrc`
   if [ "$als_set" ]; then
     #do nothing
     true
   else
     alias -g wsend="$HOME/.wsend/wsend" >> $HOME/.zshrc
   fi
 else
   alias -g wsend="$HOME/.wsend/wsend" >> $HOME/.zshrc
 fi
}
if [ "$curl_installed" ]; then
  #continue
  true
else
  echoerr -e "\e[01;31m"
  echoerr "error:   curl is required but it is not installed. Aborting";
  echoerr "error:   For ubuntu please run: sudo apt-get install curl";
  echoerr -e "\e[00m"
  exit 1;
fi
# check to see if directory exists
if [ -d "$HOME/.wsend" ]; then
  wsend_dir="$HOME/.wsend"
  #check version
  installedVersion=`cat $wsend_dir/version`
  latestVersion=`curl https://raw.github.com/abemassry/wsend/master/version 2>/dev/null`
  if [ $installedVersion != $latestVersion ]; then
    echoerr -e "\e[01;36m"
    echoerr "info:    "
    echoerr "info:    new version detected, auto updating"
    echoerr "info:    "
    echoerr -e "\e[00m"
    wsDL=`curl -o $HOME/.wsend/wsend https://raw.github.com/abemassry/wsend/master/wsend 2>/dev/null`
    chmod +x $HOME/.wsend/wsend
    #supporting files as well
    rmDL=`curl -o $HOME/.wsend/README.md https://raw.github.com/abemassry/wsend/master/README.md 2>/dev/null`
    cpDL=`curl -o $HOME/.wsend/COPYING https://raw.github.com/abemassry/wsend/master/COPYING 2>/dev/null`
    newLatestVersion=`curl -o $HOME/.wsend/version https://raw.github.com/abemassry/wsend/master/version 2>/dev/null`
  fi
else
  # if not, install
  if [ "$freeSpaceK" -gt 100 ]; then
    mkdir $HOME/.wsend
    #download wsend and put it in directory
    wsDL=`curl -o $HOME/.wsend/wsend https://raw.github.com/abemassry/wsend/master/wsend 2>/dev/null`
    chmod +x $HOME/.wsend/wsend
    #supporting files as well
    rmDL=`curl -o $HOME/.wsend/README.md https://raw.github.com/abemassry/wsend/master/README.md 2>/dev/null`
    cpDL=`curl -o $HOME/.wsend/COPYING https://raw.github.com/abemassry/wsend/master/COPYING 2>/dev/null`
    newLatestVersionDL=`curl -o $HOME/.wsend/version https://raw.github.com/abemassry/wsend/master/version 2>/dev/null`
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
