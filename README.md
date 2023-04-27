# wsend
*the opposite of wget*

## Overview

[wsend](https://github.com/abemassry/wsend) is a [Command Line Tool (CLI)](http://en.wikipedia.org/wiki/Command-line_interface) for sending files. It's open-source and easy to use. [We've](http://massindustries.org) designed `wsend` to be suitable for command line beginners and well seasoned users alike.

`wsend` requires `bash` and `curl`. And if you've ever run into this problem: http://xkcd.com/949/

`wsend` uses [wsend.net](https://wsend.net) for backend file handling.

## Two-line wsend install
```sh
wget https://raw.githubusercontent.com/abemassry/wsend/master/install.sh -O - | bash
alias wsend="~/.wsend/wsend"
```
Note: This install command appends the alias to your .bashrc or equivalent

## Or if you prefer the UNIX way
```sh
mkdir -p ~/bin # just in case
wget https://wsend.net/wsend | ~/bin/wsend
chmod +x ~/bin/wsend
export PATH=$PATH:~/bin # also put that in your .zshenv or whatever
wsend file.txt
```
## For an easy way to remember
```sh
wget https://wsend.net/wsend
chmod +x wsend
./wsend file.txt
```
Your first file is sent and wsend has been installed.

## Features

 - Sending files right from the command line without having to specify a directory
 - Gives you a url
 - Integrates well with unix pipes
 - Send a file without registering
 - User accounts available with large amounts of storage space
 - Optional time-to-live auto-expiring files
 - Optionally send an email with link

## Usage

   **Usage:**
   
     wsend <file>
   
   **Common Commands:**

   *Send a file*

     wsend file.txt

   *Send a file in an email to your friend (if you have the mail command set up)*

     wsend logfile.log | mail -s "Here was that log file you wanted" friend@example.com

   *Register*

     wsend --register

   *Login*

     wsend --login

   *Refer a friend (receive 1GB for you and friend)*

     wsend --refer friend@example.com

   *Get a referral link to send to people*

     wsend --refer-link

   *List Local Files (files that have been uploaded from this machine)*

     wsend --list-local || wsend -ll

   *List Server Files (files stored on wsend.net)*

     wsend --list-server || wsend -ls

   *List Server Files (files stored on wsend.net) urls only*

     wsend --list-server-url || wsend -lsu

   *Delete Files*

     wsend --rm https://wsnd.io/xqZgx2HQ/file.txt

   *Update Files*

     wsend --update https://wsnd.io/xqZgx2HQ/file.txt file.txt

   *Get a qr code for your phone*

     wsend --qr file.txt

   *Remove a file after a certain amount of time*
 
     wsend --ttl 1h file.txt

     # in hours (h), days (d), or months (m)
     # e.g. 3h [3 hours], 4d [4 days], 2m [2 months]
     # m is a shorthand for 30d, 2m would be 60 days independent of
     # calendar month

   *Send an email with a link*

     wsend --mail foo@bar.com file.txt



## Pricing

| Account                               | Space     | Price                |
|---------------------------------------|-----------|----------------------|
| Unregistered (Anonymous) Account      | 200MB     | Free                 |
| Free Account                          | 2GB       | Free                 |
| Supporter Paid Account                | 10GB      | $10/year or $1/month |
| Enthusiast Paid Account               | 75GB      | $30/year or $3/month |
| Hero Paid Account                     | 100GB     | $50/year or $5/month |
 

## API
The API is REST like in the sense that there is a representational transfer of state.  It isn't REST like in the sense that the only transport method that is used is HTTP POST.

### Update
Additional API keys with expiration are available for paid accounts. The management is done through the web interface at https://wsend.net/profile/api to use it save the API token to a secure location and use it in the following examples where `$id` is used. It should behave the same as the standard `uid`. 

To get a user id:

    curl -d "start=1" https://wsend.net/createunreg
    
This should be saved to a file or a database

To send a file:

	curl -F "uid=$id" -F "filehandle=@$fileToSend" https://wsend.net/upload_cli
    
Where `$id` is the id from the previous request and `$fileToSend` is the file you would like to send.

To see if the user has storage space available to send this file:

	curl -d "uid=$id" -d "size=$fileToSendSize" https://wsend.net/userspaceavailable
    

Where `$fileToSendSize` is the filesize in bytes.

To register a user:

	curl -d "uid=$id" -d "email=$email" -d "password=$password" https://wsend.net/register_cli
    
You want to protect the password from showing up anywhere as security measure.  For the wsend command line script the password is not echoed and passed directly as a variable.

To log in a user:

	curl -d "email=$email" -d "password=$password" https://wsend.net/login_cli

To list files (returns a list in JSON):

	curl -d "uid=$id" https://wsend.net/list_cli

To delete a file:

	curl -d "link=$link" -d "uid=$id" $host/delete_cli

Where $link is a wsend.net url pointing to the file

---
## FAQ

 1. Q: Why did you program this in Bash wasn't that painful? Bash isn't meant to do these things, you could have used python with pip, nodejs with npm, or ruby with rubygems.

     A: While it was painful we wanted this script to be ubiquitous as possible and bash was installed on all of our *nix machines. We do have plans to write this in the languages you mention and will work towards this in the future. If you would like to write a client in one of these languages it would be something we would both appreciate and support. UPDATE: node-wsend available on npm

 2. Q: What about wput? Isn't that the opposite of wget?

     A: wput is an FTP client and its aim is a little different than that of wsend. wsend uploads files through HTTPS which works on port 443 which in some restricted firewall situations may work (if you can access HTTPS pages). They serve different purposes and if you like wput as well as wsend we hope you can use them both, in different ways.

 3. Q: When are the Enthusiast and Hero accounts going to become available?

     A: ~As soon as we generate enough income with the Supporter accounts we can purchase more servers and more space. We do not want to degrade the quality of paid accounts because paying customers deserve the best treatment. We do not want to offer services that we can't fully 100% support until we are ready to.~ UPDATE: Enthusiast and Hero plans are now available.

 4. Q: What is the max filesize?

     A: For the Unregistered Account it is 200MB, for the Free account it is 2GB, for the Paid accounts it is 10GB.

 5. Q: I had an unregistered 200MB account. Can I get a listing of my files?

     A: If you register through the command line and then log into https://wsend.net you should be able to get a listing of all of the files you have uploaded.

 6. Q: But I don't want to register, can't you list my files on the command line with a wsend --ls or some such?

     A: While command line account management is definitely in the works, we would prefer it if you registered so you can make sure a file is yours before deleting it. UPDATE: wsend -ls works from the command line to list your files. However, you still need to register to use this command.

 7. Q: I have an unregistered account, why is my file not loading?

     A: We remove files from unregistered accounts when they become 30 days old or space is needed on the server whichever comes first.

 8. Q: I have a free account, why are my files missing?

     A: We remove files from free accounts when they become 30 days old or space is needed on the server whichever comes first.

 9. Q: But why, that doesn't seem right, no other service does this?

     A: The wsend program and service are primarily provided for sending files. We have to maintain the best service possible for paying users, once the paying user-base grows we can support more benefits for the unregistered and free accounts. This service is not meant to compete with other services that store files for free, it can be used as a quick and easy way to send files.

 10. Q: Can I use the wsend script to interface with another web service?

      A: By all means, it's GPL licensed and you can adapt it to whatever service you would like or create your own.

 11. Q: I have a problem but it is not listed here, who should I ask?

      A: While we will try to respond to all requests, you can contact us at https://wsend.net/about If you are a paying user we will definitely respond and will not rest till your problem is resolved. Just fill out the contact form with your email that is registered to your paid account. Paid accounts are so important to us because it not only keeps the lights on and the hard drives spinning, it validates what we are doing and it says you support us, you support the community, and you support an open internet where everyone can exchange ideas. You are also joining us in contributing to something larger than ourselves.	

---
### Help

If you find wsend difficult to use, please open up a [Github issue](https://github.com/abemassry/wsend/issues) or if you see an area that can be improved send a pull request! 

#### ~.wsend/ directory

In this directory the executable bash script wsend is stored, along with the README.md documentation, the GPL COPYING licence, a file called version which stores the version and which wsend checks against the github repo to determine whether it should install updates, and a file called .id, which is an identifier for the command line user.

#### version

This file stores the version and wsend checks against the github repo to determine whether it should install updates.

#### .id

This file stores an identifier for the command line user

#### .list

This file stores a list of files that have been uploaded on this computer.

#### README.md

This file

#### COPYING

The GPL licence

#### wsend

The executable bash script, this can send files and also install the ~.wsend/ directory.  The only user file it changes is the .bashrc file by appending the alias to the end.  If you have bash installed but use another popular shell it will install it to that .*rc file


---
#### (C) Copyright 2021, wsend.net
