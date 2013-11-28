#!/bin/sh

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

php app/console davidbadura:fixtures:load --fixture=src/Cidetsi/DepartamentosBundle/Resources/fixtures/
php app/console davidbadura:fixtures:load --fixture=src/Cidetsi/GestionesBundle/Resources/fixtures/

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

