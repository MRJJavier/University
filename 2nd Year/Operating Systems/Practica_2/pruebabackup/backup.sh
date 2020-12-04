#!/bin/bash
if [ ! -f "$1" ]
then
	echo $1 no existe
else
	A=$(ls $1* | wc -w)
	if [ $A -ge 9 ]
	then
		echo “Se ha superado el número máximo de versiones”
	else
		Num=`expr $A + 1`
		Version=$1.$Num
		cp $1 $Version
	fi
fi



