#include <stdio.h>
void checkStrings(char *bigPointer, char *smallPointer);
	char bigString[] = "Mississippi";
	char smallString[] = "iss";

int main(){	
	char *bigPointer;
	char *smallPointer;
	bigPointer = bigString;
	smallPointer = smallString;

	while(*bigPointer != 0){
		checkStrings(bigPointer, smallPointer);
		bigPointer++;
	}
}
void checkStrings(char *bigPointer, char *smallPointer){
		int possibleIndex = (int)(bigPointer-bigString);
			while(*smallPointer != 0){
				if(*bigPointer != *smallPointer){
					return;
				}
				bigPointer++;
				smallPointer++;
			}
			printf("%d\n", possibleIndex);
		return;
	}
