# wsend
*the opposite of wget*

## Overview

[wsend](https://github.com/abemassry/wsend) is a [Command Line Tool (CLI)](http://en.wikipedia.org/wiki/Command-line_interface) for sending files. It's open-source and easy to use. [We've](https://massindsutries.org) designed `wsend` to be suitable for command line beginners and well seasoned users alike.

`wsend` requires `bash` and `curl`. And if you've ever run into this problem: http://xkcd.com/949/

`wsend` uses [wsend.net](https://wsend.net) for backend file handling.

## Two-line wsend install

    wget https://raw.github.com/abemassry/wsend/master/install.sh -O - | bash
    alias wsend='/home/user/.wsend/wsend'
Note: This install command appends the alias to your .bashrc or equivalent

## Features

 - Sending files right from the command line without having to specify a directory
 - Gives you a url
 - Integrates well with unix pipes
 - Send a file without registering
 - User accounts available with large amounts of storage space

## Usage

   **Usage:**
   
     wsend <file>
   
   **Common Commands:**

   *Send a file*

     wsend file.txt

   *Send a file in an email to your friend*

     wsend logfile.log | mail -s "Here was that log file you wanted" friend@example.com

   *Register*

     wsend --register

   *Login*
   
     wsend --login
   
   *Refer a friend (receive 1GB for you and friend)*
   
     wsend --refer friend@example.com

## Pricing

 - Unregistered (Anonymous) Account&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Free
 - Free Account&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2GB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Free
 - Supporter Paid Account&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10GB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$10/year or $1/month
 - Enthusiast Paid Account (coming soon)&nbsp;&nbsp;&nbsp;&nbsp;~~75GB~~&nbsp;&nbsp;&nbsp;&nbsp; $30/year or $3/month
 - Hero Paid Account (coming soon)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~~100GB~~&nbsp;&nbsp;&nbsp; $50/year or $5/month
 



### Help

If you find wsend difficult to use, please open up a [Github issue](https://github.com/nodejitsu/jitsu/issues) or if you see an area that can be improved send a pull request! 

#### ~.wsend/ directory

In this directory the executable bash script wsend is stored, along with the README.md documentation, the GPL COPYING licence, a file called version which stores the version and which wsend checks against the github repo to determine whether it should install updates, and a file called .id, which is an identifier for the command line user.

#### version

This file stores the version and wsend checks against the github repo to determine whether it should install updates.

#### .id

This file stores an identifier for the command line user

#### README.md

This file

#### COPYING

The GPL licence

#### wsend

The executable bash script, this can send files and also install the ~.wsend/ directory.  The only user file it changes is the .bashrc file by appending the alias to the end.  If you have bash installed but use another popular shell it will install it to that .*rc file

#### (C) Copyright 2013, wsend.net
