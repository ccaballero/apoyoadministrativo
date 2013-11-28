#!/bin/sh

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

php app/console doctrine:database:drop --force
php app/console doctrine:database:create
php app/console doctrine:schema:create

