#!/bin/sh

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*
php app/console doctrine:database:drop --force
php app/console doctrine:generate:entities Cidetsi/DepartamentoBundle --path src/
php app/console doctrine:database:create
php app/console doctrine:schema:create
php app/console davidbadura:fixtures:load --fixture=src/Cidetsi/DepartamentoBundle/Resources/fixtures/

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

