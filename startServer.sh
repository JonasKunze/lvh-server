#!/bin/bash
service firewalld stop
source /home/kunzejo/.rvm/scripts/rvm
bin/rails s -p80 -b* -e development
