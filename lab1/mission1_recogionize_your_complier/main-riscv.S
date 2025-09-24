	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1_f2p2_d2p2_zicsr2p0"
	.file	"main.c"
	.option	push
	.option	arch, +a, +c, +m
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	sd	s1, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	addi	s0, sp, 48
	.cfi_def_cfa s0, 0
	sw	zero, -28(s0)
	sw	zero, -32(s0)
	li	a0, 1
	sw	a0, -36(s0)
	sw	a0, -40(s0)
.Lpcrel_hi0:
	auipc	a0, %pcrel_hi(.L.str)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi0)
	addi	a1, s0, -48
	call	__isoc99_scanf
	lw	a1, -32(s0)
.Lpcrel_hi1:
	auipc	a0, %pcrel_hi(.L.str.1)
	addi	s1, a0, %pcrel_lo(.Lpcrel_hi1)
	mv	a0, s1
	call	printf
	lw	a1, -36(s0)
	mv	a0, s1
	call	printf
	j	.LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -40(s0)
	lw	a1, -48(s0)
	bge	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
	lw	a0, -36(s0)
	sw	a0, -44(s0)
	lw	a0, -32(s0)
	lw	a1, -36(s0)
	addw	a0, a0, a1
	sw	a0, -36(s0)
	lw	a1, -36(s0)
.Lpcrel_hi2:
	auipc	a0, %pcrel_hi(.L.str.1)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi2)
	call	printf
	lw	a0, -44(s0)
	sw	a0, -32(s0)
	lw	a0, -40(s0)
	addiw	a0, a0, 1
	sw	a0, -40(s0)
	j	.LBB0_1
.LBB0_3:
	li	a0, 0
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	ld	s1, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.option	pop
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
