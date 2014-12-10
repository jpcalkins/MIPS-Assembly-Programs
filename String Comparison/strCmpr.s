.data
intro:		.asciiz		"Jacob Calkins's String Search Program\n"
prompt1:	.asciiz		"Enter first string: "
prompt2:	.asciiz		"Enter second string: "
newLine:	.asciiz		"\n"
theString1:	.space 		64
theString2:	.space		64


#variable declarations
#bigString = $t0
#smallString = $t1
#bigPntr = $t2
#smallPntr = $t3
#possibleindex = $t4

.text
.globl main
main:
	# print the intro
	la $a0, intro
	addi $v0, $zero, 4
	syscall

	# print prompt1
	la $a0, prompt1
	addi $v0, $zero, 4
	syscall

	#read String
	li $v0, 8
    la $a0, theString1
    li $a1, 64
    syscall
    la $t0, theString1

    

	# print the prompt2
	la $a0, prompt2
	addi $v0, $zero, 4
	syscall

	#read String
	li $v0, 8
    la $a0, theString2
    li $a1, 64
    syscall
    la $t1, theString2


	la $t2, theString1
	la $t3, theString2



	while1:
		lb $t4, 0($t2)
		beq $t4, $zero, afterWhile1
		nop

		addi $sp, $sp, -20
		sw $t0, 16($sp)
		sw $t1, 12($sp)
		sw $t2, 8($sp)
		sw $t3, 4($sp)
		sw $ra, 0($sp)

		move $a0, $t2
		move $a1, $t3
		jal checkStrings
		nop

		lw $ra, 0($sp)		
		lw $t3, 4($sp)
		lw $t2, 8($sp)
		lw $t1, 12($sp)
		lw $t0, 16($sp)
		addi $sp, $sp, 20

		addi $t2, $t2, 1

		b while1
		nop

	afterWhile1:

		jr $ra
		nop

#$t0 = *bigPointer
#$t1 = *smallPointer
#$t4 = possibleIndex
#$a0 = bigPointer
#$a1 = smallPointer

checkStrings:
	la $t5, theString1
	sub $t4, $a0, $t5

		while2:
			lb $t0, 0($a0)
			lb $t1, 0($a1)
			beq $t1, $zero, afterWhile2
			nop
			li $t3, '\n'
			beq $t1, $t3, afterWhile2
			nop
			if2:
				bne $t0, $t1, return
				nop
				addi $a0, $a0, 1
				addi $a1, $a1, 1
				b while2
				nop
			
	afterWhile2:
		add $a0, $t4, $zero
		addi $v0, $zero, 1
		syscall

	return:
		jr $ra
		nop
