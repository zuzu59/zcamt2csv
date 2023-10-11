#!/bin/bash
#Petit script pour démarrer le binz
#zf231011.2237

docker run --rm --interactive --tty --volume $PWD:/usr/src/myapp ruby:3.0 /usr/src/myapp/go.sh

exit

cd /usr/src/myapp

gem install camt camt_parser
ruby titi.rb


