#include <stdio.h>
int main(){
	int height, i, temp3, temp5;
	printf("Enter a number: ");
	scanf("%d", &height);
	i = 1;
	temp3 = 0;
	temp5 = 0;

	while(i<=height){

		temp3 = i%3;
		temp5 = i%5;

		if(temp3 == 0 && temp5 == 0){
			printf("Jacob Calkins\n");
		} else if(temp3 == 0){
			printf("Jacob\n");
		} else if(temp5 == 0){
			printf("Calkins\n");
		} else{
			printf("%d\n", i);
		}
		i++;
	}
}