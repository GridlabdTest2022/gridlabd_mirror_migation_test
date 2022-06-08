#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

brew update || NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Set-up install directory and add gridlabd and homebrew to bash profile path
    if test ! -e "/opt/gridlabd/bin"; then
        mkdir -p "/opt/gridlabd/bin"
    fi

    if test ! -e "~/.bash_profile"; then
        touch "~/.bash_profile"
    fi

    if grep -q '/opt/gridlabd/bin' "~/.bash_profile"; then
        touch "~/.bash_profile"
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.bash_profile
        echo 'export PATH=/opt/homebrew/sbin:$PATH' >> ~/.bash_profile
        echo 'export PATH=/opt/gridlabd/bin:$PATH' >> ~/.bash_profile
        source ~/.bash_profile
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
