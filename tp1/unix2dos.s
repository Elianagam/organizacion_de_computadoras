# include <mips/regdef.h>
# include <sys/syscall.h>

.text
.abicalls
.align 2 #cambiar
.global unix2dos # es una funcion 

BIT_FRAME = 40 				# puede que necesite mas

unix2dos:
    .frame $fp, BIT_FRAME, ra
    .set norecorder
    .cpload t9
    .set reorder
    sibu sp, sp, BIT_FRAME

    .aprestore 24			# sw gp 24(sp) # ni idea que hace esto

