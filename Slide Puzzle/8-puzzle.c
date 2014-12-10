#include <stdio.h>

char buffer[10];
char solution[10] = "12345678.";
char move;

void printBoard(){
	int i, j, counter;
	i = 0;
	j = 0;
	counter = 0;
	while( i < 3 ){
		while( j < 3){
			printf("%c", buffer[counter]);
			counter++;
			j++;
		}
		j = 0;
		printf("\n");
		i++;
	}
}
void swapNums(){
	int swapIndex, dotIndex, i, diff;
	i = 0;
	while(i < 10 ){
		if (buffer[i] == move){
			swapIndex = i;
		}
		if (buffer[i] == '.'){
			dotIndex = i;
		}
		i++;
	}
	diff = swapIndex - dotIndex;
	if(((diff == 1 || diff == -1) && (swapIndex / 3 == dotIndex / 3)) || diff == -3 || diff == 3){
			/*if(dif == 1){
				if(swapIndex / 3 == dotIndex / 3){
					do stuff
				}
			}
			if(dif == -1){
				if(swapIndex/3 == dotIndex/3){
					do stuff
				}
			}
			if(diff == 3){
				do stuff
			}
			if(diff == -3){
				do stuff
			}
			*/
			buffer[dotIndex] = buffer[swapIndex];
			buffer[swapIndex] = '.';
	} else{
		printf("That is not a valid move.\n");
		return;
	}
}
int isEqual(){
	int i = 0;
	while(i < 9){
		if(buffer[i] != solution[i]){
			return 0;
		}
		i++;	
	}
	return 1;
}
int main(){
	printf("Jacob Calkins's 8-puzzle game.\n");
	printf("Enter initial board configuration: ");
	fgets(buffer, 255, stdin);
	int equality = 0;
	while(equality != 1){
		printBoard();
		printf("Enter a number to swap: ");
		scanf(" %c", &move);
		swapNums();
		equality = isEqual();
	}
	printBoard();
	printf("Congratulations, you win!!!\n");
}