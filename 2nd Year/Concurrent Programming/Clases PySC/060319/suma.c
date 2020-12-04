int suma(int *v, int l){
	int s = 0;
	int *ptr = v;
	for (int i=0; i<l; i++){
		s = s+ *ptr;
		ptr++;
	}
	return s;
}
