#!/bin/bash
cat <<-END
$(uname -s) $(uname -r | cut -f1 -d.) has no automated installer.  You will have to run the installation manually and the specific commands
will depend on how your system works.  The general process for a Mac OS X setup is as follows:

brew update || ruby -e "\$(curl -fsSL https://raw.githubusercontent.com/HomeBrew/install/master/install)"
brew install autoconf automake libtool gnu-sed python3
ln -s /opt/gridlabd/bin/gsed /opt/gridlabd/bin/sed
pip3 install matplotlib pandas numpy

The alternative way is to use --use-docker command to build custom docker image in your syste. Please see README.md for details.

END