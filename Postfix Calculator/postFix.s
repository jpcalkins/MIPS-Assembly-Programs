.data
intro:		.asciiz		"Jacob Calkins's Postfix Calculator\n"
prompt1:	.asciiz		"Enter a string containing a postfix expression: "
finalState:	.asciiz		"The total is "
newLine:	.asciiz		"\n"
buffer:		.space 		256
stack:		.space		256
#variable declarations
#c = $t5
#d = $t6
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

	#read String to buffer
	li $v0, 8
    la $a0, buffer
    li $a1, 64
    syscall

    li $t0, 0	#stackSize = $t0
    li $t1, 0	#val = $t1
    li $t2, 0	#i = $t2
    li $t3, 1	#multiplier = $t3
    while:
        la $s0, newLine #\n = $s0
        la $s1, buffer  #buffer = $s1
        li $s2, ' '
        li $s3, '+'
        li $s4, '-'
        li $s5, '*'
        li $s6, '/'
        la $s7, stack   #stack = $s7

    	add $t7, $t2, $s1
    	lb $t5, 0($t7)		#c = buffer[i]
    	beq $t5, $s0, afterWhile
    	nop
    	beq $t5, $zero, afterWhile
    	nop
    	addi $t2, $t2, 1 #i++

    	add $t7, $t2, $s1
    	lb $t6, 0($t7)		#d = buffer[i+1]
    	if1:
            beq $t5, $s2, while     #if(c == ' ')
            nop
        if2:
            bne $t5, $s3, if3       #if(c == '+')
            nop
            addi $sp, $sp, -16
            sw $t1, 12($sp)
            sw $t2, 8($sp)
            sw $t3, 4($sp)
            sw $ra, 0($sp)

            move $a0, $t0
            jal addStack
            nop
            move $t0, $v0

            lw $ra, 0($sp)      
            lw $t3, 4($sp)
            lw $t2, 8($sp)
            lw $t1, 12($sp)
            addi $sp, $sp, 16
    		b while
    		nop
        if3:
            bne $t5, $s5, if4       #if(c == '*')
            nop
            addi $sp, $sp, -16
            sw $t1, 12($sp)
            sw $t2, 8($sp)
            sw $t3, 4($sp)
            sw $ra, 0($sp)

            move $a0, $t0
            jal multStack
            nop
            move $t0, $v0

            lw $ra, 0($sp)      
            lw $t3, 4($sp)
            lw $t2, 8($sp)
            lw $t1, 12($sp)
            addi $sp, $sp, 16
            b while
            nop
        if4:
            bne $t5, $s6, if5A       #if(c == '/')
            nop
            addi $sp, $sp, -16
            sw $t1, 12($sp)
            sw $t2, 8($sp)
            sw $t3, 4($sp)
            sw $ra, 0($sp)

            move $a0, $t0
            jal divStack
            nop
            move $t0, $v0

            lw $ra, 0($sp)      
            lw $t3, 4($sp)
            lw $t2, 8($sp)
            lw $t1, 12($sp)
            addi $sp, $sp, 16
            b while
            nop
        if5A:

            beq $t5, $s4, if5B      #if (c == '-')
            nop
            b afterIfs
            nop
            if5B:
                slti $t4, $t6, '1'  
                bgtz $t4, insideIfs #if((d <= '0')
                nop
            if5C:
                slti $t4, $t6, '9'
                bgtz $t4, afterIfs  #if(d >= '9')
                nop
            insideIfs:
                addi $sp, $sp, -16
                sw $t1, 12($sp)
                sw $t2, 8($sp)
                sw $t3, 4($sp)
                sw $ra, 0($sp)

                move $a0, $t0
                jal subStack
                nop
                move $t0, $v0

                lw $ra, 0($sp)      
                lw $t3, 4($sp)
                lw $t2, 8($sp)
                lw $t1, 12($sp)
                addi $sp, $sp, 16
                b while
                nop
        afterIfs:
            li $t1, 0
            li $t3, 1

        while2:
            beq $t5, $s2, afterWhile2   #(c != ' ')
            nop
            beq $t5, $zero, afterWhile2 #(c != '\0')
            nop
            beq $t5, $s0, afterWhile2   #(c != '\n')
            nop
            if6:
                bne $t5, $s4, if7A
                nop
                li $t3, -1
            if7A:
                slti $t4, $t5, '0'  
                bgtz $t4, afterIfs2
                nop
                if7B:
                    slti $t4, $t5, ':'  
                    beq $t4, $zero, afterIfs2
                    nop
                    li $t9, 10
                    mult $t9, $t1       
                    mflo $t9            #$t9 = val*10
                    li $t8, '0'
                    sub $t7, $t5, $t8   #$t7 = c-'0'
                    add $t1, $t9, $t7   #val = (val*10) + (c-'0')
            afterIfs2:
                add $t7, $t2, $s1
                lb $t5, 0($t7)      #c = buffer[i]
                addi $t2, $t2, 1    #i++
                b while2
                nop
        afterWhile2:
            mult $t1, $t3
            mflo $t1            #val = val * multiplier
            add $t7, $t0, $s7
            sb $t1, 0($t7)      #stack[stackSize] = val
            addi $t0, $t0, 1
            b while
            nop
    afterWhile:
        #print The total is
        la $a0, finalState
        addi $v0, $zero, 4
        syscall
        #print number
        addi $t9, $t0, -2
        add $t8, $t9, $s7
        lb $a0, 0($t8)
        addi $v0, $zero, 1
        syscall
    	jr $ra
		nop
addStack:
    #result = $t0
    #stackSize = $a0
    #stack = $t1
    la $t1, stack
    addi $t2, $a0, -2
    addi $t3, $a0, -1
    add $t2, $t1, $t2
    add $t3, $t1, $t3
    lb $t4, 0($t2)
    lb $t5, 0($t3)
    add $t0, $t4, $t5
    sb $t0, 0($t2)
    addi $a0, $a0, -1
    move $v0, $a0
    jr $ra
    nop

multStack:
    #result = $t0
    #stackSize = $a0
    #stack = $t1
    la $t1, stack
    addi $t2, $a0, -2
    addi $t3, $a0, -1
    add $t2, $t1, $t2
    add $t3, $t1, $t3
    lb $t4, 0($t2)
    lb $t5, 0($t3)
    mult $t4, $t5
    mflo $t0
    sb $t0, 0($t2)
    addi $a0, $a0, -1
    move $v0, $a0
    jr $ra
    nop

divStack:
    #result = $t0
    #stackSize = $a0
    #stack = $t1
    la $t1, stack
    addi $t2, $a0, -2
    addi $t3, $a0, -1
    add $t2, $t1, $t2
    add $t3, $t1, $t3
    lb $t4, 0($t2)
    lb $t5, 0($t3)
    div $t4, $t5
    mflo $t0
    sb $t0, 0($t2)
    addi $a0, $a0, -1
    move $v0, $a0
    jr $ra
    nop

subStack:
    #result = $t0
    #stackSize = $a0
    #stack = $t1
    la $t1, stack
    addi $t2, $a0, -2
    addi $t3, $a0, -1
    add $t2, $t1, $t2
    add $t3, $t1, $t3
    lb $t4, 0($t2)
    lb $t5, 0($t3)
    sub $t0, $t4, $t5
    sb $t0, 0($t2)
    addi $a0, $a0, -1
    move $v0, $a0
    jr $ra
    nop