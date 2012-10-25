#include <stdio.h>
#include <math.h>
#include "./factorial.h"
//seventh order taylor polynomial for computing sin
double seventhOrderTaylorSin(x){
	return x - pow(x,3)/factorial(3) + pow(x,5)/factorial(5) - pow(x,7)/factorial(7);
}
int main(){
	int sides = 100;
	int radius = 1;
	double angle = (2*M_PI)/(sides*2);

	double pi = (seventhOrderTaylorSin(angle))*radius*sides;

	printf("pi is somewhere near: %f",pi);

}

