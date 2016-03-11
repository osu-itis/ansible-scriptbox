#!/bin/bash

cd /tmp
tar xf corkscrew-2.0.tar.gz
cd corkscrew-2.0
./configure
make
make install
