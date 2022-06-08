#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# install homebrew
    brew update || mkdir /opt/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
    brew update-reset

# Set-up install directory and add gridlabd and homebrew to bash profile path
    if test ! -e "/opt/gridlabd/bin"; then
        mkdir -p "/opt/gridlabd/bin"
    fi

    if test ! -e "$HOME/.bash_profile"; then
        touch "$HOME/.bash_profile"
    fi

    if ! grep -q '/opt/gridlabd/bin' "$HOME/.bash_profile"; then
        touch "$HOME/.bash_profile"
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> $HOME/.bash_profile
        echo 'export PATH=/opt/homebrew/sbin:$PATH' >> $HOME/.bash_profile
        echo 'export PATH=/opt/gridlabd/bin:$PATH' >> $HOME/.bash_profile
    fi

    if ! grep -q '/opt/gridlabd/bin' "$HOME/.profile"; then
        touch "$HOME/.profile"
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> $HOME/.profile
        echo 'export PATH=/opt/homebrew/sbin:$PATH' >> $HOME/.profile
        echo 'export PATH=/opt/gridlabd/bin:$PATH' >> $HOME/.profile
        source $HOME/.profile
    fi
    brew doctor

# build tools

    brew install autoconf automake libtool gnu-sed gawk

    # Update symlinks in the gridlabd bin
    [ ! -L /opt/gridlabd/bin/sed -o ! "$(readlink /opt/gridlabd/bin/sed)" == "/opt/homebrew/bin/gsed" ] && mv /opt/gridlabd/bin/sed /opt/gridlabd/bin/sed-old
    [ ! -e /opt/gridlabd/bin/sed ] && ln -s /opt/homebrew/bin/gsed /opt/gridlabd/bin/sed
    [ ! -e /opt/gridlabd/bin/libtoolize ] && ln -s /opt/homebrew/bin/glibtoolize /opt/gridlabd/bin/libtoolize

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
