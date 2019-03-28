	.file	1 "dos2unix.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.globl	CONST_CR
	.rdata
	.type	CONST_CR, @object
	.size	CONST_CR, 1
CONST_CR:
	.byte	13
	.globl	CONST_NL
	.type	CONST_NL, @object
	.size	CONST_NL, 1
CONST_NL:
	.byte	10
	.align	2
$LC0:
	.ascii	"r\000"
	.align	2
$LC1:
	.ascii	"out_u.txt\000"
	.align	2
$LC2:
	.ascii	"w\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	lw	$v0,60($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC0
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L6
	lw	$a0,24($fp)
	la	$t9,fclose
	jal	$ra,$t9
$L6:
	la	$a0,$LC1
	la	$a1,$LC2
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,28($fp)
$L7:
	lw	$v0,24($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L9
	b	$L8
$L9:
	addu	$v0,$fp,32
	move	$a0,$v0
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,24($fp)
	la	$t9,fread
	jal	$ra,$t9
	lb	$v1,32($fp)
	lb	$v0,CONST_CR
	bne	$v1,$v0,$L10
	addu	$v0,$fp,32
	move	$a0,$v0
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,24($fp)
	la	$t9,fread
	jal	$ra,$t9
	lb	$v1,32($fp)
	lb	$v0,CONST_NL
	beq	$v1,$v0,$L10
	la	$a0,CONST_CR
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,28($fp)
	la	$t9,fwrite
	jal	$ra,$t9
$L10:
	addu	$v0,$fp,32
	move	$a0,$v0
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,28($fp)
	la	$t9,fwrite
	jal	$ra,$t9
	b	$L7
$L8:
	lw	$a0,24($fp)
	la	$t9,fclose
	jal	$ra,$t9
	lw	$a0,28($fp)
	la	$t9,fclose
	jal	$ra,$t9
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
