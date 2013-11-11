#!/bin/bash

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*
php app/console doctrine:schema:drop --force

