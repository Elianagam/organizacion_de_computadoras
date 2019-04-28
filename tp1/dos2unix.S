# include <mips/regdef.h>
# include <sys/syscall.h>

	.rdata

	W_ERROR: 	.asciiz "Error en escritura\n"
	R_ERROR:	.asciiz	"Error de lectura\n"
	CONST_CR: 	.ascii "\r"
	CONST_NL: 	.ascii "\n"

	.data

	character: 	.byte 1

	.text
	.equ 		BIT_FRAME, 40	# Tamaño del stackframe
	.abicalls
	.align 2

	.globl	main
	.ent main

main:

	.frame	$fp, BIT_FRAME, ra

	.set	noreorder
	.cpload t9
	.set	reorder

	subu 	sp, sp, BIT_FRAME

	.cprestore 24

	sw	$fp, 28(sp)
	sw	ra, 32(sp)

	move	$fp, sp

while:

	li 	v0, SYS_read	# Realizamos un read
	li 	a0, 0 		# sobre el stdin
	la 	a1, character 	# guardamos lo leido en character
	li	a2, 1		# indicamos que queremos leer 1 solo byte.
	syscall

	beqz 	v0, end_program		# Si leyo 0 => caracteres entonces es EOF
	bltz	v0, read_error

	lb 	t0, character	# Cargamos las constantes en registros
	lb 	t1, CONST_CR

	bne 	t0, t1, write_char	# Si no son iguales salto

	li 	v0, SYS_read	# Realizamos lectura de siguiente caracter
	li 	a0, 0
	la 	a1, character
	li	a2, 1
	syscall

	beqz 	v0, end_program		# Si leyo 0 => caracteres entonces es EOF
	bltz	v0, read_error

	lb 	t0, character		# Ponemos nuevamente constantes (actualizadas) en registros
	lb 	t1, CONST_NL

	beq 	t1, t0, write_char

	li   	v0, SYS_write		# Escribimos CONST_CR en archivo
	li 	a0, 1
	la   	a1, CONST_CR
	li   	a2, 1
	syscall

write_char:

	li   	v0, SYS_write	# Hacemos write del caracter y repetimos el while
	li  	a0, 1
	la   	a1, character
	li   	a2, 1
	syscall

	blez 	v0, write_error
	b 	while

end_program:

	lw	gp,  24(sp)
	lw	$fp, 28(sp)
	lw	ra,  32(sp)

	addu 	sp,  sp, BIT_FRAME
	and  	v0,  v0, 0    	 	# Return 0

	jr 	ra

write_error:

	la	a1, W_ERROR
	li 	a2, 20

	b 	exit_error

read_error:

	la 	a1, R_ERROR
	li 	a2, 20

exit_error:

	li 	v0, SYS_write
	li 	a0, 2
	syscall

	li 	v0, SYS_exit
	li 	a0, 1
	syscall

	.end 	main
	.size 	main,.-main
