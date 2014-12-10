.data
intro:		.asciiz		"Jacob Calkins's 8-puzzle game.\n"
prompt1:	.asciiz		"Enter initial board configuration: "
prompt2:	.asciiz		"Enter a number to swap: "
win:		.asciiz		"Congratulations, you win!!!\n"
invalid:	.asciiz		"That is not a valid move.\n"
solution:	.asciiz		"12345678."
newLine:	.asciiz		"\n"
buffer:		.space 		10
#variable declarations
#equality = $t0
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

	#read initial to buffer
	li $v0, 8
    la $a0, buffer
    li $a1, 10
    syscall

    # print newLine
	la $a0, newLine
	addi $v0, $zero, 4
	syscall

    #initialize equality
    li $t0, 0

    while:
    	bne $t0, $zero, afterWhile
    	nop
    	#printBoard()
    	addi $sp, $sp, -8
    	sw $t0, 4($sp)
    	sw $ra, 0($sp)
    	jal printBoard
    	nop
    	lw $ra, 0($sp)
    	lw $t0, 0($sp)
    	addi $sp, $sp, 8

    	#print prompt2
    	la $a0, prompt2
		addi $v0, $zero, 4
		syscall

		#read move
		li $v0, 12
	    syscall
	    add $t9, $v0, $zero

	    # print newLine
		la $a0, newLine
		addi $v0, $zero, 4
		syscall

	    #swapNums()
    	addi $sp, $sp, -8
    	sw $t0, 4($sp)
    	sw $ra, 0($sp)
    	move $a0, $t9
    	jal swapNums
    	nop
    	move $t9, $v0
    	lw $ra, 0($sp)
    	lw $t0, 0($sp)
    	addi $sp, $sp, 8

    	#equality = isEqual()
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	add $a0, $t0, $zero
    	jal isEqual
    	nop
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
    	add $t0, $v0, $zero

    	b while
    	nop
    afterWhile:
		#printBoard()
    	addi $sp, $sp, -8
    	sw $t0, 4($sp)
    	sw $ra, 0($sp)
    	jal printBoard
    	nop
    	lw $ra, 0($sp)
    	lw $t0, 0($sp)
    	addi $sp, $sp, 8    	

    	#print win statement
    	la $a0, win
		addi $v0, $zero, 4
		syscall
		jr $ra
		nop
printBoard:
	#variables
	#i = $t0; j = $t1; counter = $t2; 3 = $t3; $t4 = buffer; $t5 = buffer[counter]
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 3
	la $t4, buffer
	printWhile1:
		beq $t0, $t3, afterPrintWhile1
		nop
		printWhile2:
			beq $t1, $t3, afterPrintWhile2
			nop
			add $t5, $t4, $t2
			lb $t5, 0($t5)		#$t5 = buffer[counter]
			#print buffer[counter]
			add $a0, $t5, $zero
			addi $v0, $zero, 11
			syscall
			addi $t2, $t2, 1 	#counter++
			addi $t1, $t1, 1 	#j++
			b printWhile2
			nop
		afterPrintWhile2:
			li $t1, 0			#j=0
			#print newLine
			la $a0, newLine
			addi $v0, $zero, 4
			syscall
			addi $t0, $t0, 1 	#i++
		b printWhile1
		nop
	afterPrintWhile1:
		jr $ra
		nop
swapNums:
	#variables
	#swapIndex = $t0; dotIndex = $t1; i = $t2; diff = $t3; 10 = $t4; buffer = $t5; move = $s7; '.' = $s8
	li $t2, 0
	addi $s4, $zero, 10
	la $t5, buffer
	move $s7, $a0
	addi $s8, $zero, '.'
	swapWhile1:
		beq $t2, $s4, afterSwapWhile1
		nop
		add $t6, $t5, $t2
		lb $t6, 0($t6)		#buffer[i] = $t6
		if1:
			bne $t6, $s7, if2	#if (buffer[i] == move)
			nop
			add $t0, $t2, $zero
		if2:
			bne $t6, $s8, afterIf2
			nop
			add $t1, $t2, $zero
		afterIf2:
			addi $t2, $t2, 1
	b swapWhile1
	nop
	afterSwapWhile1:
		sub $t3, $t0, $t1	#diff = swapIndex - dotIndex;
		addi $s0, $zero, -1
		addi $s1, $zero, 1
		addi $s2, $zero, -3
		addi $s3, $zero, 3
		bigIf1:
			bne $t3, $s1, bigIf2
			nop
			div $t0, $s3
			mflo $t4		#swapIndex/3 = $t4
			div $t1, $s3
			mflo $t9		#dotIndex/3 = $t9
			bne $t4, $t9, bigIf2
			nop
			b stuff
			nop
		bigIf2:
			bne $t3, $s0, bigIf3
			nop
			div $t0, $s3
			mflo $t4		#swapIndex/3 = $t4
			div $t1, $s3
			mflo $t9		#dotIndex/3 = $t9
			bne $t4, $t9, bigIf3
			nop
			b stuff
			nop
		bigIf3:
			bne $t3, $s3, bigIf4
			nop
			b stuff
			nop
		bigIf4:
			bne $t3, $s2, bigElse
			nop
			b stuff
			nop
		stuff:
			add $t4, $t5, $t1
			#lb $t7, 0($t4)	#buffer[dotIndex] = $t7
			add $t9, $t5, $t0
			lb $t8, 0($t9)	#buffer[swapIndex] = $t8
			sb $t8, 0($t4)
			sb $s8, 0($t9)
			move $v0, $a0
			jr $ra
			nop
		bigElse:
			la $a0, invalid
			addi $v0, $zero, 4
			syscall
			move $v0, $a0
			jr $ra
			nop
isEqual:
	#variables
	#i = $t0; buffer = $t1; solution = $t2
	move $t9, $a0
	li $t0, 0
	la $t1, buffer
	la $t2, solution
	li $t3, 9
	equalWhile:
		beq	$t0, $t3, afterEqualWhile
		nop
		add $t4, $t1, $t0
		lb $t4, 0($t4)		#buffer[i] = $t4
		add $t5, $t2, $t0
		lb $t5, 0($t5)		#solution[i] = $t5
		beq $t4, $t5, afterEqualIf
		nop
		li $v0, 0
		jr $ra
		nop
		afterEqualIf:
			addi $t0, $t0, 1 	#i++
			b equalWhile
			nop
	afterEqualWhile:
		li $v0, 1
		jr $ra
		nop