#!/bin/sh

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*
php app/console davidbadura:fixtures:load --fixture=src/Cidetsi/DepartamentoBundle/Resources/fixtures/

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

