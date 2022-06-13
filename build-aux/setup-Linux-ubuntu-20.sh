#!/bin/bash

# Install needed system tools
# update first
apt-get -q update
apt-get -q install tzdata -y

# install system build tools needed by gridlabd
apt-get -q install git -y
apt-get -q install unzip -y
apt-get -q install autoconf -y
apt-get -q install libtool -y
apt-get -q install g++ -y
apt-get -q install cmake -y 
apt-get -q install flex -y
apt-get -q install bison -y
apt-get -q install libcurl4-gnutls-dev -y
apt-get -q install libncurses5-dev -y
apt-get -q install liblzma-dev -y
apt-get -q install libssl-dev -y
apt-get -q install libbz2-dev -y
apt-get -q install libffi-dev -y
apt-get -q install zlib1g-dev -y
apt-get -q install mdbtools -y

# install python 3.9
if [ ! -x /opt/gridlabd/bin/python3 -o $(/opt/gridlabd/bin/python3 --version | cut -f-2 -d.) != "Python 3.9" ]; then
	cd /opt/gridlabd/src
	curl https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz | tar xz
	cd Python-3.9.6
	./configure --prefix=/opt/gridlabd --enable-optimizations --with-system-ffi --with-computed-gotos --enable-loadable-sqlite-extensions CFLAGS="-fPIC"
	make -j $(nproc)
	make altinstall
	ln -sf /opt/gridlabd/bin/python3.9 /opt/gridlabd/bin/python3
	ln -sf /opt/gridlabd/bin/python3.9-config /opt/gridlabd/bin/python3-config
	ln -sf /opt/gridlabd/bin/pydoc3.9 /opt/gridlabd/bin/pydoc
	ln -sf /opt/gridlabd/bin/idle3.9 /opt/gridlabd/bin/idle
	curl -sSL https://bootstrap.pypa.io/get-pip.py | /opt/gridlabd/bin/python3
fi

# install python libraries by validation
/opt/gridlabd/bin/python3 pip -m install --upgrade pip
/opt/gridlabd/bin/python3 pip -m install mysql-connector mysql-client matplotlib numpy pandas Pillow

# doxggen
apt-get -q install gawk -y
if [ ! -x /usr/bin/doxygen ]; then
	if [ ! -d /opt/gridlabd/src/doxygen ]; then
		git clone https://github.com/doxygen/doxygen.git /opt/gridlabd/src/doxygen
	fi
	if [ ! -d /opt/gridlabd/src/doxygen/build ]; then
		mkdir /opt/gridlabd/src/doxygen/build
	fi
	cd /opt/gridlabd/src/doxygen/build
	cmake -G "Unix Makefiles" ..
	make
	make install
fi

# mono
apt-get -q install curl -y
if [ ! -f /usr/bin/mono ]; then
	cd /tmp
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu wheezy/snapshots/4.8.0 main" | tee /etc/apt/sources.list.d/mono-official.list
	apt-get -q update -y
	apt-get -q install mono-devel -y
fi

# natural_docs
if [ ! -x /opt/gridlabd/bin/natural_docs ]; then
	cd /opt/gridlabd
	curl https://www.naturaldocs.org/download/natural_docs/2.0.2/Natural_Docs_2.0.2.zip > natural_docs.zip
	unzip -qq natural_docs
	rm -f natural_docs.zip
	mv Natural\ Docs natural_docs
	echo '#!/bin/bash
mono /opt/gridlabd/natural_docs/NaturalDocs.exe \$*' > /opt/gridlabd/bin/natural_docs
	chmod a+x /opt/gridlabd/bin/natural_docs
fi

# converter support
/opt/gridlabd/bin/python3 pip -m install networkx
apt-get -q install mdbtools -y
