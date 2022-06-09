#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# install homebrew
    brew update || mkdir /opt/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
    export PATH=/$(brew --prefix)/bin:/$(brew --prefix)/sbin:$PATH
    brew update-reset
    brew doctor

# build tools

    brew install autoconf automake libtool gnu-sed gawk

    # Update symlinks in the gridlabd bin
    [ ! -e /opt/gridlabd/bin/sed ] && ln -s $(brew --prefix)/bin/gsed /opt/gridlabd/bin/sed
    [ ! -e /opt/gridlabd/bin/libtoolize ] && ln -s $(brew --prefix)/bin/glibtoolize /opt/gridlabd/bin/libtoolize

# install python3
    brew install python3

# mdbtools
    brew install mdbtools

# docs generators
    brew install mono
    brew install naturaldocs
    ln -s /opt/homebrew/bin/naturaldocs /opt/gridlabd/bin/natural_docs

    brew install doxygen

# influxdb
    brew install influxdb
    brew services start influxdb

# subversion cli
    brew install svn

cp -RP /opt/homebrew/bin /opt/gridlabd/src