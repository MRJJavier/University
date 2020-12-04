
int bits1(){
	unsigned char a;
	a=17; //0 0 0 1 0 0 0 1
	a=~a; //1 1 1 0 1 1 1 0
	printf("%d\n",a);
	return 0;
}

int bits2(){
	unsigned char a,b;
	a=17; //0 0 0 1 0 0 0 1
	b=22; //0 0 0 1 0 1 1 0
	a=a & b; //0 0 0 1 0 0 0 0
	printf("%d\n",a);
	return 0;
}

int bits3(){
	unsigned char a,b;
	a=17;//0 0 0 1 0 0 0 1
	a=a << 2;//0 1 0 0 0 1 0 0
	b=64;//0 1 0 0 0 0 0 0
	b=b >> 3;//0 0 0 0 1 0 0 0
	printf("%d %d\n",a,b);
	return 0;
}

int bits4(){
	char a;
	int i;
	a=17; 			//0 0 0 1 0 0 0 1
	a=a | (1 << 3); //0 0 0 1 1 0 0 1 /* pone a 1 el  bit 3 */
	printf("%d\n",a);
	a=a & (~(1<<4)); //0 0 0 0 1 0 0 1 /* pone a 0 el  bit 4 */
	printf("%d\n",a);
	for (i=7; i>=0; i--)
		printf("%d ",(a&(1<<i)) >> i); /* lee el bit i */
	printf("\n");
	return 0;
}

