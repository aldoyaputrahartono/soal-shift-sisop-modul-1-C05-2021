#!/bin/bash

curdir=`pwd`
if [ -f $curdir/Foto.log ]
then
	rm $curdir/Foto.log
fi

max_kitten=23;
for ((i=1; i<=$max_kitten; ))
do
	if [ $i -le 9 ]
	then
		wget -O $curdir/Koleksi_0$i.jpg --append-output=$curdir/Foto.log https://loremflickr.com/320/240/kitten
	else
		wget -O $curdir/Koleksi_$i.jpg --append-output=$curdir/Foto.log https://loremflickr.com/320/240/kitten
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
		max_kitten=$(($max_kitten-1))
	else
		rm $curdir/Koleksi_$i.jpg
		max_kitten=$(($max_kitten-1))
	fi
done
