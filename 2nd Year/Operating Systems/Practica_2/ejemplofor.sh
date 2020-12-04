for i in *
do
	if [ -d $i ]
	then
		echo $i es un directorio
	fi
	if [ -f $i ]
	then
		echo $i es un fichero
	fi
done
