	.syntax unified
	.cpu	cortex-a8
	.eabi_attribute	6, 10
	.eabi_attribute	7, 65
	.eabi_attribute	8, 1
	.eabi_attribute	9, 2
	.fpu	neon
	.eabi_attribute	20, 1
	.eabi_attribute	21, 1
	.eabi_attribute	23, 3
	.eabi_attribute	24, 1
	.eabi_attribute	25, 1
	.eabi_attribute	28, 1
	.eabi_attribute	68, 1
	.file	"seqlock.c"
	.text
	.globl	writer
	.align	3
	.type	writer,%function
writer:                                 @ @writer
@ BB#0:                                 @ %entry
	sub	sp, sp, #12
	movw	r0, #1
	movw	r1, #0
	str	r1, [sp, #4]
	str	r0, [sp, #8]
.LBB0_1:                                @ %for.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI0_0
	vldr	d16, .LCPI0_1
	ldr	r1, [sp, #8]
	vmov	s0, r1
	vcvt.f64.s32	d17, s0
	vcmpe.f64	d17, d16
	vmrs	APSR_nzcv, fpscr
	str	r0, [sp]                @ 4-byte Spill
	bhi	.LBB0_4
@ BB#2:                                 @ %for.body
                                        @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	dmb	ish
	movw	r1, :lower16:lock
	movt	r1, :upper16:lock
	str	r0, [r1]
	dmb	ish
	ldr	r0, [sp, #8]
	movw	r2, :lower16:x1
	movt	r2, :upper16:x1
	str	r0, [r2]
	dmb	ish
	ldr	r0, [sp, #8]
	movw	r2, :lower16:x2
	movt	r2, :upper16:x2
	str	r0, [r2]
	dmb	ish
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	str	r0, [r1]
	dmb	ish
@ BB#3:                                 @ %for.inc
                                        @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp, #8]
	add	r0, r0, #1
	str	r0, [sp, #8]
	b	.LBB0_1
.LBB0_4:                                @ %for.end
	add	sp, sp, #12
	bx	lr
	.align	3
@ BB#5:
.LCPI0_1:
	.long	0                       @ double 1.0E+9
	.long	1104006501
.LCPI0_0:
	.long	1000000000              @ 0x3b9aca00
.Ltmp0:
	.size	writer, .Ltmp0-writer

	.globl	reader
	.align	3
	.type	reader,%function
reader:                                 @ @reader
@ BB#0:                                 @ %entry
	push	{r11, lr}
	mov	r11, sp
	sub	sp, sp, #56
	movw	r0, #0
	str	r0, [r11, #-4]
	str	r0, [r11, #-8]
	str	r0, [r11, #-12]
.LBB1_1:                                @ %while.cond
                                        @ =>This Loop Header: Depth=1
                                        @     Child Loop BB1_3 Depth 2
	ldr	r0, .LCPI1_0
	vldr	d16, .LCPI1_1
	ldr	r1, [r11, #-4]
	vmov	s0, r1
	vcvt.f64.s32	d17, s0
	vcmpe.f64	d17, d16
	vmrs	APSR_nzcv, fpscr
	str	r0, [sp, #12]           @ 4-byte Spill
	bpl	.LBB1_12
@ BB#2:                                 @ %while.body
                                        @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, [r11, #-12]
	add	r0, r0, #1
	str	r0, [r11, #-12]
.LBB1_3:                                @ %while.body3
                                        @   Parent Loop BB1_1 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	movw	r0, :lower16:lock
	movt	r0, :upper16:lock
	ldr	r0, [r0]
	dmb	ish
	str	r0, [sp, #28]
	ldr	r0, [sp, #28]
	and	r0, r0, #1
	cmp	r0, #0
	beq	.LBB1_5
@ BB#4:                                 @ %if.then
                                        @   in Loop: Header=BB1_3 Depth=2
	b	.LBB1_3
.LBB1_5:                                @ %if.end
                                        @   in Loop: Header=BB1_3 Depth=2
	movw	r0, :lower16:x1
	movt	r0, :upper16:x1
	ldr	r0, [r0]
	dmb	ish
	str	r0, [r11, #-4]
	movw	r0, :lower16:x2
	movt	r0, :upper16:x2
	ldr	r0, [r0]
	dmb	ish
	str	r0, [r11, #-8]
	ldr	r0, [sp, #28]
	movw	r1, :lower16:lock
	movt	r1, :upper16:lock
	ldr	r1, [r1]
	dmb	ish
	cmp	r0, r1
	bne	.LBB1_7
@ BB#6:                                 @ %if.then9
                                        @   in Loop: Header=BB1_1 Depth=1
	b	.LBB1_8
.LBB1_7:                                @ %if.end10
                                        @   in Loop: Header=BB1_3 Depth=2
	b	.LBB1_3
.LBB1_8:                                @ %while.end
                                        @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-8]
	cmp	r0, r1
	bne	.LBB1_10
@ BB#9:                                 @ %cond.true
                                        @   in Loop: Header=BB1_1 Depth=1
	b	.LBB1_11
.LBB1_10:                               @ %cond.false
	movw	r0, :lower16:.L.str
	movt	r0, :upper16:.L.str
	movw	r1, :lower16:.L.str1
	movt	r1, :upper16:.L.str1
	movw	r2, #57
	movw	r3, :lower16:.L__PRETTY_FUNCTION__.reader
	movt	r3, :upper16:.L__PRETTY_FUNCTION__.reader
	bl	__assert_fail
.LBB1_11:                               @ %cond.end
                                        @   in Loop: Header=BB1_1 Depth=1
	movw	r0, #0
	movw	r1, :lower16:nanosleep
	movt	r1, :upper16:nanosleep
	add	r2, sp, #16
	ldr	r3, .LCPI1_2
	str	r0, [sp, #16]
	str	r3, [sp, #20]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r2
	ldr	r2, [sp, #8]            @ 4-byte Reload
	str	r1, [sp, #4]            @ 4-byte Spill
	mov	r1, r2
	ldr	r3, [sp, #4]            @ 4-byte Reload
	blx	r3
	str	r0, [sp]                @ 4-byte Spill
	b	.LBB1_1
.LBB1_12:                               @ %while.end13
	mov	sp, r11
	pop	{r11, pc}
	.align	3
@ BB#13:
.LCPI1_1:
	.long	4286578688              @ double 999999999
	.long	1104006500
.LCPI1_0:
	.long	999999999               @ 0x3b9ac9ff
.LCPI1_2:
	.long	100000000               @ 0x5f5e100
.Ltmp1:
	.size	reader, .Ltmp1-reader

	.globl	prod
	.align	2
	.type	prod,%function
prod:                                   @ @prod
@ BB#0:                                 @ %entry
	push	{r11, lr}
	mov	r11, sp
	sub	sp, sp, #8
	str	r0, [sp, #4]
	bl	writer
	movw	r0, #0
	mov	sp, r11
	pop	{r11, pc}
.Ltmp2:
	.size	prod, .Ltmp2-prod

	.globl	cons
	.align	2
	.type	cons,%function
cons:                                   @ @cons
@ BB#0:                                 @ %entry
	push	{r11, lr}
	mov	r11, sp
	sub	sp, sp, #8
	str	r0, [sp, #4]
	bl	reader
	movw	r0, #0
	mov	sp, r11
	pop	{r11, pc}
.Ltmp3:
	.size	cons, .Ltmp3-cons

	.globl	main
	.align	2
	.type	main,%function
main:                                   @ @main
@ BB#0:                                 @ %entry
	push	{r11, lr}
	mov	r11, sp
	sub	sp, sp, #72
	add	r0, sp, #24
	movw	r1, #0
	str	r1, [r11, #-4]
	bl	pthread_attr_init
	add	r1, sp, #24
	movw	r2, #0
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	pthread_attr_setdetachstate
	sub	r1, r11, #8
	add	r2, sp, #24
	movw	r3, :lower16:prod
	movt	r3, :upper16:prod
	movw	r12, #0
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	mov	r3, r12
	bl	pthread_create
	sub	r1, r11, #12
	add	r2, sp, #24
	movw	r3, :lower16:cons
	movt	r3, :upper16:cons
	movw	r12, #0
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	mov	r3, r12
	bl	pthread_create
	movw	r1, #0
	ldr	r2, [r11, #-8]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r2
	bl	pthread_join
	movw	r1, #0
	ldr	r2, [r11, #-12]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r2
	bl	pthread_join
	movw	r1, #0
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
.Ltmp4:
	.size	main, .Ltmp4-main

	.type	lock,%object            @ @lock
	.bss
	.globl	lock
	.align	2
lock:
	.long	0                       @ 0x0
	.size	lock, 4

	.type	x1,%object              @ @x1
	.globl	x1
	.align	2
x1:
	.long	0                       @ 0x0
	.size	x1, 4

	.type	x2,%object              @ @x2
	.globl	x2
	.align	2
x2:
	.long	0                       @ 0x0
	.size	x2, 4

	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"v1 == v2"
	.size	.L.str, 9

	.type	.L.str1,%object         @ @.str1
.L.str1:
	.asciz	"seqlock.c"
	.size	.L.str1, 10

	.type	.L__PRETTY_FUNCTION__.reader,%object @ @__PRETTY_FUNCTION__.reader
.L__PRETTY_FUNCTION__.reader:
	.asciz	"void reader()"
	.size	.L__PRETTY_FUNCTION__.reader, 14


	.ident	"clang version 3.5 (http://llvm.org/git/clang.git a693f7de5d45c718ae9b82310d456c51bcda2422) (git@github.com:reinhrst/llvm.git 07fc1059c0bc1145feb5f13363416cef762b368e)"
