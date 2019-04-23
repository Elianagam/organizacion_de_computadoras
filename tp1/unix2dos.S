# include <mips/regdef.h>
# include <sys/syscall.h>

.rdata

CONST_CR: 	.ascii "\r"
CONST_NL: 	.ascii "\n"
OPEN_ERROR:	.asciiz "Error"
file_out: 	.asciiz "out_w.txt"
file_in: 	.asciiz "test.txt"

.data
character:	.byte	1
.text
.equ BIT_FRAME, 40 		# puede que necesite mas
.abicalls
.align 2
.globl	main
.ent main

main:
    .frame 	$fp, BIT_FRAME, ra
    .set 	noreorder
    .cpload 	t9
    .set 	reorder
    subu 	sp, sp, BIT_FRAME
    .cprestore 	24		# sw gp 24(sp)

    sw		$fp, 28(sp)
    sw		ra, 32(sp)
    move	$fp, sp
    sw		a0, BIT_FRAME($fp)

open_in:    # abrir archivo para lectura
    li   	v0, SYS_open	# system call para abrir archivo
    la   	a0, file_in 	# nombre archivo
    li   	a1, 0        	# leer = 0
    li   	a2, 0        	# mode ignorar
    syscall			
    move 	s0, v0      	# guardo el file descriptor 
    
    bgez 	s0, open_out 
    
error_open:	# Hubo error de apertura, escribimos en stderr: write(2, OPEN_ERROR, 18)
    li   	v0, SYS_write
    li   	a0, 2
    la   	a1, OPEN_ERROR
    li   	a2, 18
    syscall

    li   	v0, SYS_exit
    syscall

open_out:	# Abrimos archivo como escritura: open(file_out, 0)
    li   	v0, SYS_open
    la   	a0, file_out
    li   	a1, 4
    li   	a2, 0
    syscall

    move s1, v0

    bgez s1, while # si no hubo error de escritura

    li   	v0, SYS_write
    li  	a0, 2
    la   	a1, OPEN_ERROR
    li	a2, 18
    syscall

    li   	v0, SYS_close	# Syscall para close
    move 	a0, s0		# Pasamos el fd anterior
    syscall

    li 	v0, SYS_exit	# Hacemos return
    syscall

while:	# leer del archivo
    li		v0, SYS_read	# leer archivo
    move 	a0, s0		# file descriptor
    la		a1, character	# buffer del cual leer esta en a1
    li 		a2, 1		# leo 1 bit
    syscall

    blez	v0, end_program	# error salir

    lb		t0, character	# guardo character leido
    lb		t1, CONST_NL

    bne	t0, t1, write_char # if char != \n saltar 

write_r:
    li		v0, SYS_write
    move 	a0, s1
    la		a1, CONST_CR
    li		a2, 1
    syscall

write_char:
    li		v0, SYS_write
    move 	a0, s1
    la		a1, character
    li		a2, 1
    syscall

    b while

end_program:
   li		v0, SYS_close
   move		a0, s0
   syscall

   li		v0, SYS_close
   move		a0, s1
   syscall

   jr		ra

   .end main
   .size	main,.-main

