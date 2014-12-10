.data
prompt:		.asciiz		"Enter a number: "
first:		.asciiz		"Jacob"
last:		.asciiz		"Calkins"
fullName:	.asciiz		"Jacob Calkins"
newLine:	.asciiz		"\n"

#variable declarations
#height = $t0
#i = $t1
#temp3 = $t2
#temp5 = $t3
#3=$t4
#5=$t5

.text
.globl main
main:
	# print the prompt
	la $a0, prompt
	addi $v0, $zero, 4
	syscall

	#read integer
	addi $v0, $zero, 5
	syscall
	move $t0, $v0

	#intialize variables
	li $t1, 1		#i=1
	li $t2, 0		#temp3=0
	li $t3, 0		#temp5=0
	addi $t4, $zero, 3
	addi $t5, $zero, 5

	while:
		bgt $t1, $t0, afterWhile
		nop
		div $t1, $t4
		mfhi $t2
		div $t1, $t5
		mfhi $t3
		if1A:
			bne $t2, $zero, afterIf1
			nop
			if1B:
				bne $t3, $zero, afterIf1
				nop
				la $a0, fullName
				addi $v0, $zero, 4
				syscall
				b afterIfs
				nop
		afterIf1:

		if2:
			bne $t2, $zero, afterIf2
			nop
			la $a0, first
			addi $v0, $zero, 4
			syscall
			b afterIfs
			nop
		afterIf2:

		if3:
			bne $t3, $zero, afterIf3
			nop
			la $a0, last
			addi $v0, $zero, 4
			syscall
			b afterIfs
			nop
		afterIf3:

		add $a0, $t1, $zero
		addi $v0, $zero, 1
		syscall

		afterIfs:

		la $a0, newLine
		addi $v0, $zero, 4
		syscall

		addi $t1, $t1, 1
		b while
		nop
	afterWhile:

	addi $v0, $zero, 10
	syscall

#printf("Enter a number: ");
#int height;
#scanf(height);
#int i = 1;
#int temp3 = 0;
#int temp5 = 0;

#while(i<height){

#	temp3 = i%3;
#	temp5 = i%5;

#	if(temp3 == 0){
#		if(temp5 == 0){
#			printf("Jacob Calkins");
#		}
#	} else if(temp3 == 0){
#		printf("Jacob");
#	} else if(temp5 == 0){
#		printf("Calkins");
#	} else{
#		printf(i);
#	}
#	i++;
#}