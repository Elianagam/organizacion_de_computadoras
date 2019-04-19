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
	.ascii	"out_\000"
	.space	75
	.align	2
$LC1:
	.ascii	"r\000"
	.align	2
$LC2:
	.ascii	"w\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,136,$ra		# vars= 96, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,136
	.cprestore 16
	sw	$ra,128($sp)
	sw	$fp,124($sp)
	sw	$gp,120($sp)
	move	$fp,$sp
	sw	$a0,136($fp)
	sw	$a1,140($fp)
	lw	$v0,$LC0
	sw	$v0,24($fp)
	lbu	$v0,$LC0+4
	sb	$v0,28($fp)
	addu	$v0,$fp,29
	li	$v1,75			# 0x4b
	move	$a0,$v0
	move	$a1,$zero
	move	$a2,$v1
	la	$t9,memset
	jal	$ra,$t9
	lw	$v0,140($fp)
	addu	$v0,$v0,4
	addu	$a0,$fp,24
	lw	$a1,0($v0)
	la	$t9,strcat
	jal	$ra,$t9
	lw	$v0,140($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC1
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,104($fp)
	lw	$v0,104($fp)
	bne	$v0,$zero,$L6
	sw	$zero,116($fp)
	b	$L5
$L6:
	addu	$a0,$fp,24
	la	$a1,$LC2
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,108($fp)
	lw	$v0,108($fp)
	bne	$v0,$zero,$L7
	lw	$a0,104($fp)
	la	$t9,fclose
	jal	$ra,$t9
	sw	$zero,116($fp)
	b	$L5
$L7:
	.set	noreorder
	nop
	.set	reorder
$L8:
	lw	$v0,104($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L10
	b	$L9
$L10:
	addu	$v0,$fp,112
	move	$a0,$v0
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,104($fp)
	la	$t9,fread
	jal	$ra,$t9
	lb	$v1,112($fp)
	lb	$v0,CONST_CR
	bne	$v1,$v0,$L11
	addu	$v0,$fp,112
	move	$a0,$v0
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,104($fp)
	la	$t9,fread
	jal	$ra,$t9
	lb	$v1,112($fp)
	lb	$v0,CONST_NL
	beq	$v1,$v0,$L11
	la	$a0,CONST_CR
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,108($fp)
	la	$t9,fwrite
	jal	$ra,$t9
$L11:
	addu	$v0,$fp,112
	move	$a0,$v0
	li	$a1,1			# 0x1
	li	$a2,1			# 0x1
	lw	$a3,108($fp)
	la	$t9,fwrite
	jal	$ra,$t9
	b	$L8
$L9:
	lw	$a0,104($fp)
	la	$t9,fclose
	jal	$ra,$t9
	lw	$a0,108($fp)
	la	$t9,fclose
	jal	$ra,$t9
	sw	$zero,116($fp)
$L5:
	lw	$v0,116($fp)
	move	$sp,$fp
	lw	$ra,128($sp)
	lw	$fp,124($sp)
	addu	$sp,$sp,136
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
