#include <stdio.h>
int main(){
	int x, y, i, total;
	printf("Power program by Jacob Calkins.\n");
	printf("Enter base:");
	scanf("%d", &x);
	printf("Enter power:");
	scanf("%d", &y);
	i = 1;
	total = x;
	while(i<y){
		total = total*x;
		i++;
	}
	printf("%d\n", total);
}