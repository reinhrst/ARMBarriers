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
	.align	2
	.type	writer,%function
writer:                                 @ @writer
@ BB#0:                                 @ %entry
	push	{r4, lr}
	movw	r2, :lower16:lock
	movw	r12, :lower16:x1
	movw	lr, :lower16:x2
	movw	r3, #51713
	mov	r0, #1
	mov	r1, #0
	movt	r2, :upper16:lock
	movt	r12, :upper16:x1
	movt	lr, :upper16:x2
	movt	r3, #15258
.LBB0_1:                                @ %for.body
                                        @ =>This Inner Loop Header: Depth=1
	orr	r4, r1, #1
	dmb	ish
	str	r4, [r2]
	add	r1, r1, #2
	dmb	ish
	dmb	ish
	str	r0, [r12]
	dmb	ish
	dmb	ish
	str	r0, [lr]
	add	r0, r0, #1
	dmb	ish
	dmb	ish
	str	r1, [r2]
	dmb	ish
	cmp	r0, r3
	bne	.LBB0_1
@ BB#2:                                 @ %for.end
	pop	{r4, pc}
.Ltmp0:
	.size	writer, .Ltmp0-writer

	.globl	reader
	.align	2
	.type	reader,%function
reader:                                 @ @reader
@ BB#0:                                 @ %entry
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add	r11, sp, #28
	sub	sp, sp, #12
	movw	r5, :lower16:lock
	movw	r6, :lower16:x1
	movw	r7, :lower16:x2
	movw	r9, #11520
	movw	r4, #51711
	movt	r5, :upper16:lock
	movt	r6, :upper16:x1
	movt	r7, :upper16:x2
	movt	r9, #305
	mov	r10, sp
	movt	r4, #15258
.LBB1_1:                                @ %while.body3
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r5]
	dmb	ish
	tst	r0, #1
	bne	.LBB1_1
@ BB#2:                                 @ %if.end
                                        @   in Loop: Header=BB1_1 Depth=1
	ldr	r8, [r6]
	dmb	ish
	ldr	r1, [r7]
	dmb	ish
	ldr	r2, [r5]
	dmb	ish
	cmp	r0, r2
	bne	.LBB1_1
@ BB#3:                                 @ %while.end
                                        @   in Loop: Header=BB1_1 Depth=1
	cmp	r8, r1
	bne	.LBB1_6
@ BB#4:                                 @ %cond.end
                                        @   in Loop: Header=BB1_1 Depth=1
	mov	r0, #0
	mov	r1, #0
	stm	sp, {r0, r9}
	mov	r0, r10
	bl	nanosleep
	cmp	r8, r4
	blt	.LBB1_1
@ BB#5:                                 @ %while.end13
	sub	sp, r11, #28
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
.LBB1_6:                                @ %cond.false
	movw	r0, :lower16:.L.str
	movw	r1, :lower16:.L.str1
	movw	r3, :lower16:.L__PRETTY_FUNCTION__.reader
	movt	r0, :upper16:.L.str
	movt	r1, :upper16:.L.str1
	movt	r3, :upper16:.L__PRETTY_FUNCTION__.reader
	mov	r2, #57
	mov	lr, pc
	b	__assert_fail
.Ltmp1:
	.size	reader, .Ltmp1-reader

	.globl	prod
	.align	2
	.type	prod,%function
prod:                                   @ @prod
@ BB#0:                                 @ %entry
	push	{r4, lr}
	movw	r2, :lower16:lock
	movw	r12, :lower16:x1
	movw	lr, :lower16:x2
	movw	r3, #37888
	mov	r0, #1
	mov	r1, #0
	movt	r2, :upper16:lock
	movt	r12, :upper16:x1
	movt	lr, :upper16:x2
	movt	r3, #30517
.LBB2_1:                                @ %for.body.i
                                        @ =>This Inner Loop Header: Depth=1
	add	r4, r1, #1
	dmb	ish
	str	r4, [r2]
	add	r1, r1, #2
	dmb	ish
	cmp	r1, r3
	dmb	ish
	str	r0, [r12]
	dmb	ish
	dmb	ish
	str	r0, [lr]
	dmb	ish
	add	r0, r0, #1
	dmb	ish
	str	r1, [r2]
	dmb	ish
	bne	.LBB2_1
@ BB#2:                                 @ %writer.exit
	mov	r0, #0
	pop	{r4, pc}
.Ltmp2:
	.size	prod, .Ltmp2-prod

	.globl	cons
	.align	2
	.type	cons,%function
cons:                                   @ @cons
@ BB#0:                                 @ %entry
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add	r11, sp, #28
	sub	sp, sp, #12
	movw	r5, :lower16:lock
	movw	r6, :lower16:x1
	movw	r7, :lower16:x2
	movw	r9, #11520
	movw	r4, #51711
	movt	r5, :upper16:lock
	movt	r6, :upper16:x1
	movt	r7, :upper16:x2
	movt	r9, #305
	mov	r10, sp
	movt	r4, #15258
.LBB3_1:                                @ %while.body3.i
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r5]
	dmb	ish
	tst	r0, #1
	bne	.LBB3_1
@ BB#2:                                 @ %if.end.i
                                        @   in Loop: Header=BB3_1 Depth=1
	ldr	r8, [r6]
	dmb	ish
	ldr	r1, [r7]
	dmb	ish
	ldr	r2, [r5]
	dmb	ish
	cmp	r0, r2
	bne	.LBB3_1
@ BB#3:                                 @ %while.end.i
                                        @   in Loop: Header=BB3_1 Depth=1
	cmp	r8, r1
	bne	.LBB3_6
@ BB#4:                                 @ %cond.end.i
                                        @   in Loop: Header=BB3_1 Depth=1
	mov	r0, #0
	mov	r1, #0
	stm	sp, {r0, r9}
	mov	r0, r10
	bl	nanosleep
	cmp	r8, r4
	blt	.LBB3_1
@ BB#5:                                 @ %reader.exit
	mov	r0, #0
	sub	sp, r11, #28
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
.LBB3_6:                                @ %cond.false.i
	movw	r0, :lower16:.L.str
	movw	r1, :lower16:.L.str1
	movw	r3, :lower16:.L__PRETTY_FUNCTION__.reader
	movt	r0, :upper16:.L.str
	movt	r1, :upper16:.L.str1
	movt	r3, :upper16:.L__PRETTY_FUNCTION__.reader
	mov	r2, #57
	mov	lr, pc
	b	__assert_fail
.Ltmp3:
	.size	cons, .Ltmp3-cons

	.globl	main
	.align	2
	.type	main,%function
main:                                   @ @main
@ BB#0:                                 @ %entry
	push	{r4, r11, lr}
	add	r11, sp, #4
	sub	sp, sp, #44
	mov	r4, sp
	mov	r0, r4
	bl	pthread_attr_init
	mov	r0, r4
	mov	r1, #0
	bl	pthread_attr_setdetachstate
	movw	r2, :lower16:prod
	sub	r0, r11, #8
	movt	r2, :upper16:prod
	mov	r1, r4
	mov	r3, #0
	bl	pthread_create
	movw	r2, :lower16:cons
	sub	r0, r11, #12
	movt	r2, :upper16:cons
	mov	r1, r4
	mov	r3, #0
	bl	pthread_create
	ldr	r0, [r11, #-8]
	mov	r1, #0
	bl	pthread_join
	ldr	r0, [r11, #-12]
	mov	r1, #0
	bl	pthread_join
	mov	r0, #0
	sub	sp, r11, #4
	pop	{r4, r11, pc}
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
