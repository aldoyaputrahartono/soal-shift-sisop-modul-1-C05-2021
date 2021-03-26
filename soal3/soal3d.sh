#!/bin/bash

tanggal=$(date +"%m%d%Y")
zip -rem -P "$tanggal" Koleksi.zip Kelinci_* Kucing_*
