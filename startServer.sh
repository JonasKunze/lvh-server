#!/bin/bash
service firewalld stop
service named start

source /home/kunzejo/.rvm/scripts/rvm
bin/rails s -p80 -b* -e development
