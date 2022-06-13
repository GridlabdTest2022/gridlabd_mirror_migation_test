#!/bin/bash
export PATH=/opt/gridlabd/bin:/usr/bin:/bin:/usr/sbin:/sbin

brew update || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/HomeBrew/install/master/install)"
brew doctor

# build tools
brew install autoconf automake libtool gnu-sed gawk
[ ! -L /opt/gridlabd/bin/sed -o ! "$(readlink /opt/gridlabd/bin/sed)" == "/opt/gridlabd/bin/gsed" ] && mv /opt/gridlabd/bin/sed /opt/gridlabd/bin/sed-old
[ ! -e /opt/gridlabd/bin/sed ] && ln -s /opt/gridlabd/bin/gsed /opt/gridlabd/bin/sed
[ ! -e /opt/gridlabd/bin/libtoolize ] && ln -s /opt/gridlabd/bin/glibtoolize /opt/gridlabd/bin/libtoolize

# install python3
brew install python3

# mdbtools
brew install mdbtools

# docs generators
brew install mono
brew install naturaldocs
ln -s /opt/gridlabd/bin/naturaldocs /opt/gridlabd/bin/natural_docs
brew install doxygen

# influxdb
brew install influxdb
brew services start influxdb

# subversion cli
brew install svn
