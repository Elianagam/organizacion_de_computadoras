# include <mips/regdef.h>
# include <sys/syscall.h>

	.rdata

	file_in: 	.asciiz "dos2unix_test.txt"
	file_out: 	.asciiz "out_dos2unix_test.txt"
	OPEN_ERROR: 	.asciiz "Error en apertura de archivo\n"
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

	# Abrimos archivo como lectura: open(file_in, 0)

	li   	v0, SYS_open
	la   	a0, file_in
	li   	a1, 0      	# abrir en modo lectura
	li   	a2, 0
	syscall

	move 	s0, v0 		# Guardo en s0 el file descriptor

	bgez 	s0, apertura_in_ok

	# Hubo error de apertura, escribimos en stderr: write(2, OPEN_ERROR, 18)

	li   	v0, SYS_write
	li   	a0, 2
	la   	a1, OPEN_ERROR
	li   	a2, 18
	syscall

	li   	v0, SYS_exit
	syscall

apertura_in_ok:

	# Abrimos archivo como escritura: open(file_out, 0)
	li   	v0, SYS_open
	la   	a0, file_out
	li   	a1, 4
	li   	a2, 0
	syscall

	move s1, v0

	bgez s1, while

	# Hubo error de apertura, escribimos en stderr: write(2, OPEN_ERROR, 18), cerramos el otro archivo y finalizamos

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

while:

	li 	v0, SYS_read	# Realizamos un read
	move 	a0, s0 		# sobre el fd_in
	la 	a1, character 	# guardamos lo leido en character
	li	a2, 1		# indicamos que queremos leer 1 solo byte.
	syscall

	blez 	v0, end_program	# Si leyo 0 >= caracteres entonces es EOF

	lb 	t0, character	# Cargamos las constantes en registros
	lb 	t1, CONST_CR

	bne 	t0, t1, write_char	# Si no son iguales salto

	li 	v0, SYS_read	# Realizamos lectura de siguiente caracter
	move 	a0, s0
	la 	a1, character
	li	a2, 1
	syscall

	lb 	t0, character	# Ponemos nuevamente constantes (actualizadas) en registros
	lb 	t1, CONST_NL

	beq 	t1, t0, write_char

	li   	v0, SYS_write	# Escribimos CONST_CR en archivo
	move  	a0, s1
	la   	a1, CONST_CR
	li   	a2, 1
	syscall

write_char:

	li   	v0, SYS_write	# Hacemos write del caracter y repetimos el while
	move  	a0, s1
	la   	a1, character
	li   	a2, 1
	syscall

	b 	while

end_program:

	li	 v0, SYS_close	# Cierro primer archivo
	move	 a0, s0
	syscall

	li	 v0, SYS_close	# Cierro segundo archivo
	move	 a0, s1
	syscall

	jr 	ra

	.end 	main
	.size 	main,.-main
