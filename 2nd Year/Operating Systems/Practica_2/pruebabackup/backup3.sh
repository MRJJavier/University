#!/bin/bash
A="backup"
if [ ! -d $A ]
then
	mkdir $A
fi
cd $A
Num=`date +"%y%m%d"`
if [ ! -d $Num ]
then
	Ver=$Num
	mkdir $Ver
else
	B="_"$(ls | wc -w)
	Ver=$Num$B
	mkdir $Ver
fi
cd $Ver
cd ../..
C=`pwd`/$A/$Ver
for i in $*
do	
	if [ ! -f "$i" ]
	then
		echo $i no existe
	else
		cp $i $C
	fi
done





