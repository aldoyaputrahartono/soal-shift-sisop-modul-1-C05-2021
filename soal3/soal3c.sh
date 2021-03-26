#!/bin/bash

curdir=`pwd`
if [ -f $curdir/Foto.log ]
then
	rm $curdir/Foto.log
fi

sekarang=$(date +"%d-%m-%Y")
kemarin=$(date -d '-1 day' '+%d-%m-%Y')

if [ -d "$Kelinci_$kemarin" ]
then
	link="kitten"
	folder="Kucing_$sekarang"
else
	link="bunny"
	folder="Kelinci_$sekarang"
fi

max_donlod=23;
for ((i=1; i<=$max_donlod; ))
do
	if [ $i -le 9 ]
	then
		wget -O $curdir/Koleksi_0$i.jpg --append-output=$curdir/Foto.log https://loremflickr.com/320/240/$link
	else
		wget -O $curdir/Koleksi_$i.jpg --append-output=$curdir/Foto.log https://loremflickr.com/320/240/$link
	fi

	flag=0
	location=($(awk '/Location/ {print $2}' $curdir/Foto.log))
	for ((j=0; j<${#location[@]}-1; j++))
	do
		if [ "${location[$j]}" == "${location[${#location[@]}-1]}" ]
		then
			flag=1
			break
		fi
	done

	if [ $flag -eq 0 ]
	then
		i=$(($i+1))
	elif [ $i -le 9 ]
	then
		rm $curdir/Koleksi_0$i.jpg
		max_donlod=$(($max_donlod-1))
	else
		rm $curdir/Koleksi_$i.jpg
		max_donlod=$(($max_donlod-1))
	fi
done

mkdir "$folder"
mv $curdir/Foto.log "$curdir/$folder/"
mv $curdir/Koleksi_* "$curdir/$folder/"
