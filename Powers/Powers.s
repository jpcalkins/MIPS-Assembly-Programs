.data
intro:		.asciiz		"Power program by Jacob Calkins.\n"
base:		.asciiz		"Enter a nuber for base: "
power:		.asciiz		"Enter a number for the power: "
total:		.asciiz		"The total is: "

#variable assignments
#x=$t0, y=$t1, i=$t2, total=$t3
.text
.globl main
main:
	# print the intro
	la $a0, intro
	addi $v0, $zero, 4
	syscall

	# print base prompt
	la $a0, base
	addi $v0, $zero, 4
	syscall

	#read integer
	addi $v0, $zero, 5
	syscall
	move $t0, $v0

	# print power prompt
	la $a0, power
	addi $v0, $zero, 4
	syscall

	#read integer
	addi $v0, $zero, 5
	syscall
	move $t1, $v0

	#initialize count and total
	li $t2, 1			#i=0
	add $t3, $t0, $zero	#total=x

	while:
		beq $t2, $t1, afterWhile
		nop
		mult $t3, $t0
		mflo $t3
		addi $t2, $t2, 1
		b while
		nop

	afterWhile:

	la $a0, total
	addi $v0, $zero, 4
	syscall

	move $a0, $t3
	addi $v0, $zero, 1
	syscall

	addi $v0, $zero, 10
	syscall

