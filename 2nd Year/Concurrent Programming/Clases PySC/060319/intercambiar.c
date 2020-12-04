
/*No se puede poner void intercambiar(int x, int y)
 *porque se trabajaría con copias de las variables
 *y no se cambiarían los valores de las variables, por
 *ello se pasan los punteros.
 */
void intercambiar(int *x, int *y){
	int aux;
	aux=*x;
	*x=*y;
	*y=aux;
}

int main2(){
	int x=8;
	int y=25;
	intercambiar(&x,&y);
	return 0;
}
