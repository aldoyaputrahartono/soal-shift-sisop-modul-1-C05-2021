#!/bin/bash

#soal a
#grep -o '[I|E].*' syslog.log

#soal b
#grep -o 'E.*' syslog.log | cut -d"(" -f 1 | sort | uniq -c

#soal c
#echo "Error"
#grep -o 'E.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c
#echo "Info"
#grep -o 'I.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c

#soal d
#error=($(grep -o 'E.*' syslog.log | cut --complement -d" " -f 1 | cut -d"(" -f 1 | sort | uniq -c |sort -nr))
#idx=0
#
#for i in ${!error[@]}
#do
#	if [[ "${error[$i]}" =~ ^[0-9] ]]
#	then
#		angka[$idx]="${error[$i]}"
#	elif [[ "${error[$i+1]}" =~ ^[0-9] ]]
#	then
#		kata[$idx]+="${error[$i]}"
#		idx=$idx+1
#	elif (($i+1 == ${#error[@]}))
#	then
#		kata[$idx]+="${error[$i]}"
#	else
#		kata[$idx]+="${error[$i]} "
#	fi
#done
#
#
#printf "Error,Count\n" > "error_message.csv"
#for i in ${!angka[@]}
#do
#	#word="${kata[$i]}"
#	#number="${angka[$i]}"
#	printf "%s,%d\n" "${kata[$i]}" "${angka[$i]}" >> "error_message.csv"
#done

#soal e
error=($(grep -o 'E.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c))
info=($(grep -o 'I.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c))
#user=($(grep -o '(.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq))

idxe=0
idxi=0

printf "Username,INFO,ERROR\n" > "user_statistic.csv"
while (( $idxe < ${#error[@]} ))
do
	if [[ "${error[$idxe+1]}" < "${info[$idxi+1]}" || $idxi -eq ${#info[@]} ]]
	then
		printf "${error[$idxe+1]},0,${error[$idxe]}\n" >> "user_statistic.csv"
		idxe=$idxe+2
	elif [[ "${error[$idxe+1]}" == "${info[$idxi+1]}" ]]
	then
		printf "${error[$idxe+1]},${info[$idxi]},${error[$idxe]}\n" >> "user_statistic.csv"
		idxe=$idxe+2
		idxi=$idxi+2
	else
		printf "${info[$idxi+1]},${info[$idxi]},0}\n" >> "user_statistic.csv"
		idxe=$idxe+2
		idxi=$idxi+2
	fi
done

while (( $idxi < ${#info[@]} ))
do
	printf "${info[$idxi+1]},${info[$idxi]},0}\n" >> "user_statistic.csv"
	idxi=$idxi+2
done
