#!/bin/bash

PWD=`pwd`
cd $PWD

sudo rm -rf app/cache/*
sudo rm -rf app/logs/*

ID=(
114071
134111
299701
309801
319801
329201
#329202 # ing.civil (nuevo)
339701
349701
359201
378501
389701
399501
409701
419701 
429701
439801
650001
760101
)

for i in "${ID[@]}"
do
    php app/console cidetsi:scrapping --sql "http://websis.umss.edu.bo/umss_carrerasDesc.asp?codSer=UMSS&idCat=45&qual=${i}"
done
