#!/bin/sh

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

php app/console --env=prod doctrine:schema:create

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*
