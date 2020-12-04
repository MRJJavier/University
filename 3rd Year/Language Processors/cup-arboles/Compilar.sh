#Ejemplo de ejecucion: ./Compilar.sh Calculadora
#!/bin/bash
cup $1.cup
jflex $1.flex
javac sym.java
javac parser.java
javac $1.java
