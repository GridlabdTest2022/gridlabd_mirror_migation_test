#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

brew update || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
brew doctor

# build tools
    brew install autoconf automake libtool gnu-sed gawk

    # Some MAC OS use /usr/bin and have not created a modifiable /usr/local/bin, therefore it needs appropriate checks before creating symlinks
    if test ! -e "/usr/local/bin"; then
        mkdir "/usr/local/bin"
        [ ! -e /usr/local/bin/sed ] && ln -s /opt/homebrew/bin/gsed /usr/local/bin/sed
        [ ! -e /usr/local/bin/libtoolize ] && ln -s /opt/homebrew/bin/glibtoolize /usr/local/bin/libtoolize
    elif test -e "/usr/local/bin"; then
        [ ! -L /usr/local/bin/sed -o ! "$(readlink /usr/local/bin/sed)" == "/opt/homebrew/bin/gsed" ] && mv /usr/local/bin/sed /usr/local/bin/sed-old
        [ ! -e /usr/local/bin/sed ] && ln -s /opt/homebrew/bin/gsed /usr/local/bin/sed
        [ ! -e /usr/local/bin/libtoolize ] && ln -s /opt/homebrew/bin/glibtoolize /usr/local/bin/libtoolize
    fi

# install python3
brew install python3

# mdbtools
brew install mdbtools

# docs generators
brew install mono
brew install naturaldocs
ln -s /opt/homebrew/bin/naturaldocs /usr/local/bin/natural_docs

brew install doxygen

# influxdb
brew install influxdb
brew services start influxdb

# subversion cli
brew install svn
