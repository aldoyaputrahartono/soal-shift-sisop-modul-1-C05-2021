#!/bin/bash

curdir=`pwd`
bash $curdir/soal3a.sh
tanggal=$(date +"%d-%m-%Y")
mkdir "$tanggal"
mv $curdir/Foto.log "$curdir/$tanggal/"
mv $curdir/Koleksi_* "$curdir/$tanggal/"
