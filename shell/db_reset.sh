#!/bin/sh

PWD=`pwd`
cd $PWD
cd data/implantation/sql/

mysql --user=jacobian --password=asdf --database=apoyoadm --default-character-set=utf8 < _all.sql

