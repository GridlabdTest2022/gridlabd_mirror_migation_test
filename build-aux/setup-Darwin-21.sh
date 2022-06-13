#!/bin/bash
export PATH=/opt/gridlabd/bin:/usr/bin:/bin:/usr/sbin:/sbin

# install homebrew instance for gridlabd
    brew update || mkdir /opt/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    brew update-reset
    brew doctor

echo "$1"
if ! grep -q "$1/bin" "$HOME/.zshrc"; then
    touch "$HOME/.zshrc"
    echo "export PATH=$1/bin:\$PATH" >> $HOME/.zshrc
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
    pip3 install matplotlib pandas numpy networkx Pillow

# The original scikit-learn at 0.24.2 CANNOT install on the m1 mac. Period. Use 1.1.1 now.
# Reason being, is that it requires a version of NumPy that is incompatible with the m1 mac.
# updated in requirements.txt. Same goes for scipy 1.6.2.
    brew install gdal

# Install pyproj manually due to error building final wheel
    brew install proj
    pip3 install pyproj

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

ln -s /opt/homebrew/bin/* /opt/gridlabd/bin