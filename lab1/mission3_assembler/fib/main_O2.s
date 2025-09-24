	.file	"main.c"
	.option pic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%d"
	.align	3
.LC1:
	.string	"%d\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	addi	sp,sp,-64
	.cfi_def_cfa_offset 64
	sd	s4,16(sp)
	.cfi_offset 20, -48
	la	s4,__stack_chk_guard
	ld	a5, 0(s4)
	sd	a5, 8(sp)
	li	a5, 0
	addi	a1,sp,4
	lla	a0,.LC0
	sd	ra,56(sp)
	.cfi_offset 1, -8
	call	__isoc99_scanf@plt
	li	a2,0
	lla	a1,.LC1
	li	a0,2
	call	__printf_chk@plt
	li	a2,1
	lla	a1,.LC1
	li	a0,2
	call	__printf_chk@plt
	lw	a4,4(sp)
	li	a5,1
	ble	a4,a5,.L2
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	s3,24(sp)
	sd	s2,32(sp)
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 19, -40
	.cfi_offset 18, -32
	li	s1,1
	li	s0,1
	li	a5,0
	lla	s3,.LC1
.L3:
	mv	s2,s0
	addw	s0,a5,s0
	mv	a2,s0
	mv	a1,s3
	li	a0,2
	call	__printf_chk@plt
	lw	a4,4(sp)
	addiw	s1,s1,1
	mv	a5,s2
	bgt	a4,s1,.L3
	ld	s0,48(sp)
	.cfi_restore 8
	ld	s1,40(sp)
	.cfi_restore 9
	ld	s2,32(sp)
	.cfi_restore 18
	ld	s3,24(sp)
	.cfi_restore 19
.L2:
	ld	a4, 8(sp)
	ld	a5, 0(s4)
	xor	a5, a4, a5
	li	a4, 0
	bne	a5,zero,.L8
	ld	ra,56(sp)
	.cfi_remember_state
	.cfi_restore 1
	ld	s4,16(sp)
	.cfi_restore 20
	li	a0,0
	addi	sp,sp,64
	.cfi_def_cfa_offset 0
	jr	ra
.L8:
	.cfi_restore_state
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	s2,32(sp)
	sd	s3,24(sp)
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 18, -32
	.cfi_offset 19, -40
	call	__stack_chk_fail@plt
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
