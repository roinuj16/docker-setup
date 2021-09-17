#!/bin/bash

docker-compose up -d 

docker-compose run api composer create-project --prefer-dist wendelladriel/larapi api && cd www/api && sh ./tools/configure.sh

#cd www/api && sh ./tools/configure.sh
