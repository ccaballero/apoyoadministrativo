#!/bin/bash

PWD=`pwd`
cd $PWD

php app/console doctrine:schema:drop --force

