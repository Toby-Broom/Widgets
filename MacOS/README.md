# Shell Scripts for macOS

These are the files to create the xml file with the system data in

## Setup

I put the SysInfo.xml in the public documents folder and share this to the network and then put the remaining files in the root of public

I abstracted the code for running the updates out of the main code so I could more easily update the main

To make the Invoke-XML run at start up you need to make a launchd plist file see here for more infomation https://www.launchd.info/

As in windows share the folder with the Sysinfo.xml file

You'll need to install the intel power gadget from https://www.intel.com/content/www/us/en/developer/articles/tool/power-gadget.html

XMLStarlet http://xmlstar.sourceforge.net/ can be downloaded with Homebrew on MacOS  https://brew.sh/