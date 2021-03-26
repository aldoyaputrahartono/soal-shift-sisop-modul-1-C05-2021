#!/bin/bash

tanggal=$(date +"%m%d%Y")
unzip -P "$tanggal" Koleksi.zip
rm Koleksi.zip
