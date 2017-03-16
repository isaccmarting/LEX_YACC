#include <stdio.h>

int main()
{
	int a, b, c;
	c = 'c'; 
	a = b + c; 
	if(a > b && a > c /*Test comments*/)
		a = b & c; 
	printf("a + b = %d\n", a); 
	return 0; 
}
