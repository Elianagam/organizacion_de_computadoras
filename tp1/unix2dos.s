# include <mips/regdef.h>
# include <sys/syscall.h>

.eqv BIT_FRAME 40 		# puede que necesite mas

.data
.abicalls
.align 2 #cambiar
.globl unix2dos 		# es una funcion 


const_rc: 	.asciiz '\r'
const_nl: 	.asciiz '\n'
file_out_w: 	.asciiz "out_w.txt"
file_test: 	.asciiz "test.txt"
buffer:		.space 1024
.text

unix2dos:
    .frame 	$fp, BIT_FRAME, $ra
    .set 	noreorder
    .cpload 	$t9
    .set 	reorder
    subu 	sp, sp, BIT_FRAME
    .caprestore 	24		# sw gp 24(sp)

    sw		$fp, 28(sp)
    sw		ra, 32(sp)
    move	$fp, sp
    sw		a0, BIT_FRAME($fp)
    
read:    # abrir archivo para lectura
    li   	v0, 13       	# system call para abrir archivo
    la   	a0, file_test  # nombre archivo
    li   	a1, 0        	# leer = 0
    li   	a2, 0        	# mode ignorar
    syscall			
    move 	s0, v0      	# guardo el file descriptor 
    
    # leer del archivo
    li		v0, 14 	# leer archivo
    move 	a0, s0	# file descriptor
    la		a1, buffer	# buffer del cual leer esta en a1
    li 		a2, 11 	# hardcoded buffer length
    syscall			# se abre en v0 # $v0 set to -1 if error

    la      s3, a1		# guardar buffer leida en s3
    addi    s1, zero, 0	# $s1 = i = 0

while:    # iterar buffer
    add     t2, s3, s1           # $t2 = buffer[i]
    lb      t3, 0(t2)             # $t3 = elements[i]
    beq     t3, zero, fin_while   # test if for loop is done
    addi    t6, zero, const_nl	# t6 = \n
    bneq	t3, t6, write_char	# salta si t3 != \n 
	# escribir \r en t3
write_char:
	# escribir \n en t3 +1



close:    # cerrar archivo
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
