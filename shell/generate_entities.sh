#!/bin/sh

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
php app/console doctrine:generate:entities Cidetsi/DepartamentoBundle --path src/ --no-backup
