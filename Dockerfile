FROM debian:11
RUN apt-get -q update
RUN apt-get install tzdata -y
RUN  apt-get install curl -y
RUN apt-get install apt-utils -y
RUN apt-get -q install software-properties-common -y
RUN apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y
RUN apt-get -q install git -y
WORKDIR /opt/gridlabd/src
RUN git clone -b develop-fix-debian-11-setup-arm https://github.com/slacgismo/gridlabd.git
WORKDIR /opt/gridlabd/src/gridlabd