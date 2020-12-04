#Ejemplo de ejecucion: ./Ejecutar_pruebas.sh Calculadora
#!/bin/bash
for i in *.in
do
    echo $i
    java $1 $i
    echo " "
done
