# include <mips/regdef.h>
# include <sys/syscall.h>

    .rdata

    CONST_CR: 	.ascii "\r"
    CONST_NL: 	.ascii "\n"
    W_ERROR:    .asciiz "Error en escritura\n"
    R_ERROR:    .asciiz "Error de lectura\n"


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
    sw		ra,  32(sp)
    move	$fp, sp

    sw		a0, BIT_FRAME($fp)


while:	# leer del archivo

    li		v0, SYS_read	# leer archivo
    li	 	a0, 0	     	# file descriptor
    la		a1, character	# buffer del cual leer esta en a1
    li 		a2, 1		# leo 1 byte
    syscall

    beqz	v0, end_program	# error salir
    bltz	v0, read_error

    lb		t0, character	# guardo character leido
    lb		t1, CONST_NL

    bne		t0, t1, write_char # if char != \n saltar

write_r: # escribo \r

    li		v0, SYS_write
    li	 	a0, 1
    la		a1, CONST_CR
    li		a2, 1
    syscall

    blez    	v0, write_error

write_char:

    li		v0, SYS_write
    li	 	a0, 1
    la		a1, character
    li		a2, 1
    syscall

    blez    	v0, write_error

    b 	while

end_program:

    lw  	gp, 24(sp)
    lw 		$fp, 28(sp)
    lw  	ra, 32(sp)

    and  	v0, v0, 0     #   Return 0
    addu    	sp, sp, BIT_FRAME

    jr  ra

write_error:

    la      	a1, W_ERROR
    li      	a2, 20

    b	exit_error

read_error:

    la      	a1, R_ERROR
    li      	a2, 20

exit_error:

    li      	v0, SYS_write
    li		a0, 2
    syscall

    li  	v0, SYS_exit
    li		a0, 1
    syscall

    .end    main
    .size   main,.-main
