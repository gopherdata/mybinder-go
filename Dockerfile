##
## a simple Dockerfile where Go and Gophernotes are installed
##
from andrewosh/binder-base
maintainer Sebastien Binet <binet@cern.ch>

user root

env GOVERS 1.9.2

# install Go
run apt-get update -y && \
	apt-get install -y curl git pkg-config libzmq-dev build-essential && \
	curl -O -L https://golang.org/dl/go${GOVERS}.linux-amd64.tar.gz && \
	tar -C /usr/local -zxf go${GOVERS}.linux-amd64.tar.gz && \
	/bin/rm go${GOVERS}.linux-amd64.tar.gz

user main

env GOPATH $HOME/gopath
env PATH $GOPATH/bin:/usr/local/go/bin:$PATH

run go get golang.org/x/tools/cmd/goimports && \
	go get github.com/gopherds/gophernotes

# install the Go kernel
run mkdir -p $HOME/.ipython/kernels && \
	cp -r $GOPATH/src/github.com/gopherds/gophernotes/kernel $HOME/.ipython/kernels/gophernotes
copy ./kernel.json $HOME/.ipython/kernels/gophernotes/.

run mkdir -p $HOME/notebooks
copy index.ipynb $HOME/notebooks
copy examples $HOME/notebooks/.

user root
run chown -R main:main /home/main/notebooks
