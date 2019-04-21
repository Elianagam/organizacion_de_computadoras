# include <mips/regdef.h>
# include <sys/syscall.h>

	.data

	file_in: .asciiz "Hola mundo"
	file_out: .asciiz "ejemplo.txt"
	const_rc: 	.asciiz '\r'
	const_nl: 	.asciiz '\n'

	.eqv BIT_FRAME 40	# Tamaño del stackframe

	.abicalls

	.globl dos2unix
	.ent dos2unix
	.align 2
	.text

dos2unix:

	.frame	$fp, BIT_FRAME, ra						
						
	.set	noreorder	
	.cpload t9			
	.set	reorder		

	subu $sp, BIT_FRAME, $sp

	.cprestore 24

	sw	$fp, 28(sp)
	sw	ra, 32(sp)

	move	$fp, sp

	sw	a0, 40($fp)

	# Abrimos archivo como lectura
	li   $v0, 13       # system call para open
	la   $a0, file_in
	li   $a1, 0      	# abrir en modo lectura
	li   $a2, 0
	syscall       

	move $s0, $v0 # Guardo en S0 el file descriptor

	








	
