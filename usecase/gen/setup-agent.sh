#!/bin/bash

set -e

cd $HOME
echo `pwd`
wget https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz 2>/dev/null
sudo tar -C /usr/local -xzf go1.10.linux-amd64.tar.gz
sudo chown -R $USER:$USER /usr/local/go
mkdir -p /home/$USER/go/src/github.com/pilosa
mkdir -p /home/$USER/go/bin
GOPATH=/home/$USER/go
export GOPATH
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH

echo "export GOPATH=/home/$USER/go" >> .profile
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> .profile

curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

sudo apt-get update
sudo apt-get -y install make git htop

git clone https://github.com/pilosa/pdk.git $GOPATH/src/github.com/pilosa/pdk
git clone https://github.com/pilosa/pilosa.git $GOPATH/src/github.com/pilosa/pilosa
cd $GOPATH/src/github.com/pilosa/pdk
# # uncomment the following and replace "someone" and "yourbranch" as necessary to test changes.
# git remote add someone https://github.com/someone/pdk.git
# git fetch someone
# git checkout someone/yourbranch
make install
