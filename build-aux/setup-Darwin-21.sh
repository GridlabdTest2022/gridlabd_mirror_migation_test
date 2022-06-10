#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# install homebrew
    brew update || mkdir /opt/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    brew update-reset
    brew doctor

echo "$1"
if ! grep -q "$1/bin" "$HOME/.zshrc"; then
    touch "$HOME/.zshrc"
    echo "export PATH=$1/bin:$1/src:$1/src/bin:$PATH" >> $HOME/.zshrc
fi
# build tools

    brew install autoconf automake libtool gnu-sed gawk

    # Update symlinks in the gridlabd bin
    [ ! -e /opt/gridlabd/src/sed ] && ln -s /opt/homebrew/bin/gsed /opt/gridlabd/src/sed
    [ ! -e /opt/gridlabd/src/libtoolize ] && ln -s /opt/homebrew/bin/glibtoolize /opt/gridlabd/src/libtoolize

# install python3
    brew install python3

# mdbtools
    brew install mdbtools

# docs generators
    brew install mono
    brew install naturaldocs
    ln -s /opt/homebrew/bin/naturaldocs /opt/gridlabd/src/natural_docs

    brew install doxygen

# influxdb
    brew install influxdb
    brew services start influxdb

# subversion cli
    brew install svn

ln -s /opt/homebrew/bin/* /opt/gridlabd/src/bin