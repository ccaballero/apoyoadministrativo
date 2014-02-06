#!/bin/sh

PWD=`pwd`
cd $PWD

php app/console assets:install web --symlink

