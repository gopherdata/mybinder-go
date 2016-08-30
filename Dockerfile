##
## a simple Dockerfile where Go and Gophernotes are installed
##
from andrewosh/binder-base
maintainer Sebastien Binet <binet@cern.ch>

user root

# install Go
run apt-get update -y && \
	apt-get install -y curl git pkg-config libzmq-dev build-essential && \
	curl -O -L https://golang.org/dl/go1.7.linux-amd64.tar.gz && \
	tar -C /usr/local -zxf /home/main/go1.7.linux-amd64.tar.gz

user main

env GOPATH $HOME/gopath
env PATH $GOPATH/bin:/usr/local/go/bin:$PATH

run go get golang.org/x/tools/cmd/goimports && \
	go get github.com/gopherds/gophernotes

# install the Go kernel
run mkdir -p $HOME/.ipython/kernels && \
	cp -r $GOPATH/src/github.com/gopherds/gophernotes/kernel $HOME/.ipython/kernels/gophernotes
copy ./kernel.json $HOME/.ipython/kernels/gophernotes/.


# add an example
run mkdir $HOME/notebooks
copy ./notebooks/* notebooks/.
