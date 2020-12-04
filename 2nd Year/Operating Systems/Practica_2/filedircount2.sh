#!/bin/bash
if [ -d $1 ]
then
	cd $1
	for i in *
	do
		if [ -d "$i" ]
		then
			FILES=`ls -l "$i" | wc -l`
			FILES2=`expr $FILES - 1`
				if [ $FILES2 -eq -1 ]
				then
					FILES2=0
				fi
			echo "$i: $FILES2"
		fi
	done
else
	echo  Error: $1 no es un directorio
fi
