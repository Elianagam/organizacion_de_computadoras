# include <mips/regdef.h>
# include <sys/syscall.h>

.eqv BIT_FRAME 40 		# puede que necesite mas

.data
.abicalls
.align 2 #cambiar
.globl unix2dos 		# es una funcion 


const_rc: 	.asciiz '\r'
const_nl: 	.asciiz '\n'
file_test: 	.asciiz "out_w.txt"
file_out_w: 	.asciiz "test.txt"
buffer:		.space 1024
.text

unix2dos:
    .frame 	$fp, BIT_FRAME, $ra
    .set 	noreorder
    .cpload 	$t9
    .set 	reorder
    sibu 	sp, sp, BIT_FRAME
    .aprestore 	24		# sw gp 24(sp) # ni idea que hace esto
    
    #read from file
    li		$v0, 14 	# leer archivo
    move 	$a0, $s6	# file descriptor
    la		$a1, buffer	# buffer del cual leer
    li 		$a2, 11 	# hardcoded buffer length
    syscall			# se abre en v0

    # cerrar archivo
    li		$v0, 16
    move	$a0, $s6
    syscall


# copy paste de algun lado...
loop:  
    li		$v0, 12       
    syscall            # Read Character

    addiu 	$a0, $v0, 1  	# $a0 gets the next char

    li		$v0, 11       
    syscall            		# Write Character

    b loop
    nop
# **** otro codigo
    li      $t2, 0
strLen:				#getting length of string
    lb      $t0, buffer($t2)	#loading value
    add     $t2, $t2, 1
bne     $t0, $zero, strLen
