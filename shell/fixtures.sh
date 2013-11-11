#!/bin/sh

PWD=`pwd`
cd $PWD

php app/console davidbadura:fixtures:load --fixture=src/Cidetsi/DepartamentoBundle/Resources/fixtures/
