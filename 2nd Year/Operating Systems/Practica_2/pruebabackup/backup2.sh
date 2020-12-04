#!/bin/bash
for i in $*
do
	if [ ! -f "$i" ]
	then
		echo $i no existe
	else
		Num=`date +"%y%m%d_"`
		Version=$Num$i
		cp $i $Version
	fi
done



