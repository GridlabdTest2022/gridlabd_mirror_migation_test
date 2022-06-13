#!/bin/bash
export PATH=/opt/gridlabd/bin:/usr/bin:/bin:/usr/sbin:/sbin

brew update || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/HomeBrew/install/master/install)"
brew doctor

# build tools
brew install autoconf automake libtool gnu-sed
[ ! -L /opt/gridlabd/bin/sed -o ! "$(readlink /opt/gridlabd/bin/sed)" == "/opt/gridlabd/bin/gsed" ] && mv /opt/gridlabd/bin/sed /opt/gridlabd/bin/sed-old
[ ! -e /opt/gridlabd/bin/sed ] && ln -s /opt/gridlabd/bin/gsed /opt/gridlabd/bin/sed

# docs generators
brew install mono
brew install naturaldocs

# python3
brew install python3 mdbtools
pip3 install matplotlib pandas numpy networkx Pillow

# influxdb
brew install influxdb
brew services start influxdb

brew install pandoc
brew cask install basictex

