	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 26, 0	sdk_version 26, 2
	.globl	_debug_log                      ; -- Begin function debug_log
	.p2align	2
_debug_log:                             ; @debug_log
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	str	x8, [sp]                        ; 8-byte Folded Spill
	ldr	x0, [sp, #8]
	bl	_strlen
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	mov	x2, x0
	mov	w0, #1                          ; =0x1
	bl	_write
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_malloc_header              ; -- Begin function get_malloc_header
	.p2align	2
_get_malloc_header:                     ; @get_malloc_header
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, _heap_start@PAGE
	ldr	x8, [x8, _heap_start@PAGEOFF]
	subs	x8, x8, #0
	cset	w8, eq
	tbz	w8, #0, LBB1_2
	b	LBB1_1
LBB1_1:
	adrp	x0, l___func__.get_malloc_header@PAGE
	add	x0, x0, l___func__.get_malloc_header@PAGEOFF
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	mov	w2, #44                         ; =0x2c
	adrp	x3, l_.str.1@PAGE
	add	x3, x3, l_.str.1@PAGEOFF
	bl	___assert_rtn
LBB1_2:
	b	LBB1_3
LBB1_3:
	adrp	x8, _heap_start@PAGE
	ldr	x8, [x8, _heap_start@PAGEOFF]
	str	x8, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	w8, [x8]
	subs	w8, w8, #85
	cset	w8, ne
	tbz	w8, #0, LBB1_5
	b	LBB1_4
LBB1_4:
	adrp	x0, l___func__.get_malloc_header@PAGE
	add	x0, x0, l___func__.get_malloc_header@PAGEOFF
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	mov	w2, #46                         ; =0x2e
	adrp	x3, l_.str.2@PAGE
	add	x3, x3, l_.str.2@PAGEOFF
	bl	___assert_rtn
LBB1_5:
	b	LBB1_6
LBB1_6:
	ldr	x0, [sp, #8]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_find_previous_used_block       ; -- Begin function find_previous_used_block
	.p2align	2
_find_previous_used_block:              ; @find_previous_used_block
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #16]
	ldr	x8, [sp, #16]
	str	x8, [sp, #8]
	b	LBB2_1
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #8]
	cbz	x8, LBB2_5
	b	LBB2_2
LBB2_2:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #8]
	str	x8, [sp, #8]
	ldr	x8, [sp, #8]
	ldrb	w8, [x8, #16]
	and	w8, w8, #0x1
	subs	w8, w8, #1
	b.ne	LBB2_4
	b	LBB2_3
LBB2_3:
	ldr	x8, [sp, #8]
	str	x8, [sp, #24]
	b	LBB2_6
LBB2_4:                                 ;   in Loop: Header=BB2_1 Depth=1
	b	LBB2_1
LBB2_5:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #24]
	b	LBB2_6
LBB2_6:
	ldr	x0, [sp, #24]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_find_last_block                ; -- Begin function find_last_block
	.p2align	2
_find_last_block:                       ; @find_last_block
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_get_malloc_header
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	add	x8, x8, #16
	str	x8, [sp]
	b	LBB3_1
LBB3_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp]
	ldr	x8, [x8, #24]
	cbz	x8, LBB3_3
	b	LBB3_2
LBB3_2:                                 ;   in Loop: Header=BB3_1 Depth=1
	ldr	x8, [sp]
	ldr	x8, [x8, #24]
	str	x8, [sp]
	b	LBB3_1
LBB3_3:
	ldr	x0, [sp]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_reduce_heap_size_if_possible   ; -- Begin function reduce_heap_size_if_possible
	.p2align	2
_reduce_heap_size_if_possible:          ; @reduce_heap_size_if_possible
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_find_last_block
	stur	x0, [x29, #-8]
	ldur	x0, [x29, #-8]
	bl	_find_previous_used_block
	stur	x0, [x29, #-16]
	ldur	x8, [x29, #-16]
	cbnz	x8, LBB4_4
	b	LBB4_1
LBB4_1:
	ldur	x8, [x29, #-8]
	ldr	w8, [x8, #20]
	subs	w8, w8, #1, lsl #12             ; =4096
	b.ls	LBB4_3
	b	LBB4_2
LBB4_2:
	ldur	x9, [x29, #-8]
	mov	w8, #4096                       ; =0x1000
	str	w8, [x9, #20]
	b	LBB4_3
LBB4_3:
	ldur	x8, [x29, #-8]
	stur	x8, [x29, #-16]
	b	LBB4_4
LBB4_4:
	ldur	x8, [x29, #-16]
	add	x8, x8, #32
	ldur	x9, [x29, #-16]
	ldr	w9, [x9, #20]
                                        ; kill: def $x9 killed $w9
	add	x8, x8, x9
	stur	x8, [x29, #-24]
	mov	w0, #0                          ; =0x0
	bl	_sbrk
	stur	x0, [x29, #-32]
	bl	_get_malloc_header
	str	x0, [sp, #40]
	b	LBB4_5
LBB4_5:                                 ; =>This Inner Loop Header: Depth=1
	ldur	x8, [x29, #-24]
	ldur	x9, [x29, #-32]
	subs	x9, x9, #1, lsl #12             ; =4096
	subs	x8, x8, x9
	b.hs	LBB4_7
	b	LBB4_6
LBB4_6:                                 ;   in Loop: Header=BB4_5 Depth=1
	mov	w0, #-4096                      ; =0xfffff000
	bl	_sbrk
	mov	w0, #0                          ; =0x0
	bl	_sbrk
	stur	x0, [x29, #-32]
	ldr	x9, [sp, #40]
	ldrh	w8, [x9, #12]
	subs	w8, w8, #1
	strh	w8, [x9, #12]
	b	LBB4_5
LBB4_7:
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-24]
	subs	x8, x8, x9
	subs	x8, x8, #33
	b.ls	LBB4_9
	b	LBB4_8
LBB4_8:
	ldur	x8, [x29, #-24]
	str	x8, [sp, #32]
	ldr	x8, [sp, #32]
	mov	w9, #221                        ; =0xdd
	strb	w9, [sp]
	ldur	x9, [x29, #-16]
	str	x9, [sp, #8]
	strb	wzr, [sp, #16]
	ldur	x9, [x29, #-32]
	ldur	x10, [x29, #-24]
	subs	x9, x9, x10
	subs	x9, x9, #32
                                        ; kill: def $w9 killed $w9 killed $x9
	str	w9, [sp, #20]
                                        ; kill: def $x9 killed $xzr
	str	xzr, [sp, #24]
	ldr	q0, [sp]
	str	q0, [x8]
	ldr	q0, [sp, #16]
	str	q0, [x8, #16]
	ldr	x8, [sp, #32]
	ldur	x9, [x29, #-16]
	str	x8, [x9, #24]
	b	LBB4_9
LBB4_9:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_an_free                        ; -- Begin function an_free
	.p2align	2
_an_free:                               ; @an_free
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-16]
	bl	_get_malloc_header
	str	x0, [sp, #24]
	b	LBB5_1
LBB5_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]
	ldrb	w8, [x8, #4]
	tbz	w8, #0, LBB5_3
	b	LBB5_2
LBB5_2:                                 ;   in Loop: Header=BB5_1 Depth=1
	mov	w0, #1                          ; =0x1
	bl	_sleep
	b	LBB5_1
LBB5_3:
	ldr	x9, [sp, #24]
	mov	w8, #1                          ; =0x1
	strb	w8, [x9, #4]
	ldur	x8, [x29, #-16]
	subs	x8, x8, #32
	str	x8, [sp, #16]
	ldr	x8, [sp, #16]
	ldrb	w8, [x8]
	subs	w8, w8, #221
	b.eq	LBB5_5
	b	LBB5_4
LBB5_4:
	mov	w8, #0                          ; =0x0
	and	w8, w8, #0x1
	and	w8, w8, #0x1
	sturb	w8, [x29, #-1]
	b	LBB5_17
LBB5_5:
	ldr	x8, [sp, #16]
	strb	wzr, [x8, #16]
	ldur	x0, [x29, #-16]
	ldr	x8, [sp, #16]
	ldr	w8, [x8, #20]
	mov	x2, x8
	mov	w1, #0                          ; =0x0
	mov	x3, #-1                         ; =0xffffffffffffffff
	bl	___memset_chk
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #24]
	cbz	x8, LBB5_10
	b	LBB5_6
LBB5_6:
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #24]
	ldrb	w8, [x8, #16]
	tbnz	w8, #0, LBB5_10
	b	LBB5_7
LBB5_7:
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #24]
	str	x8, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #24]
	ldr	x9, [sp, #16]
	str	x8, [x9, #24]
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #24]
	cbz	x8, LBB5_9
	b	LBB5_8
LBB5_8:
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #8]
	ldr	x9, [x9, #24]
	str	x8, [x9, #8]
	b	LBB5_9
LBB5_9:
	ldr	x8, [sp, #8]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	add	x10, x8, #32
	ldr	x9, [sp, #16]
	ldr	w8, [x9, #20]
                                        ; kill: def $x8 killed $w8
	add	x8, x8, x10
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, #20]
	ldr	x0, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	add	x2, x8, #32
	mov	w1, #0                          ; =0x0
	mov	x3, #-1                         ; =0xffffffffffffffff
	bl	___memset_chk
	ldr	x9, [sp, #24]
	ldr	w8, [x9, #8]
	subs	w8, w8, #1
	str	w8, [x9, #8]
	b	LBB5_10
LBB5_10:
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #8]
	cbz	x8, LBB5_15
	b	LBB5_11
LBB5_11:
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #8]
	ldrb	w8, [x8, #16]
	tbnz	w8, #0, LBB5_15
	b	LBB5_12
LBB5_12:
	ldr	x8, [sp, #16]
	str	x8, [sp]
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #8]
	str	x8, [sp, #16]
	ldr	x8, [sp]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	add	x10, x8, #32
	ldr	x9, [sp, #16]
	ldr	w8, [x9, #20]
                                        ; kill: def $x8 killed $w8
	add	x8, x8, x10
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, #20]
	ldr	x8, [sp]
	ldr	x8, [x8, #24]
	ldr	x9, [sp, #16]
	str	x8, [x9, #24]
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #24]
	cbz	x8, LBB5_14
	b	LBB5_13
LBB5_13:
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #16]
	ldr	x9, [x9, #24]
	str	x8, [x9, #8]
	b	LBB5_14
LBB5_14:
	ldr	x9, [sp, #24]
	ldr	w8, [x9, #8]
	subs	w8, w8, #1
	str	w8, [x9, #8]
	b	LBB5_15
LBB5_15:
	bl	_reduce_heap_size_if_possible
	b	LBB5_16
LBB5_16:
	ldr	x8, [sp, #24]
	strb	wzr, [x8, #4]
	mov	w8, #1                          ; =0x1
	and	w8, w8, #0x1
	and	w8, w8, #0x1
	sturb	w8, [x29, #-1]
	b	LBB5_17
LBB5_17:
	ldurb	w8, [x29, #-1]
	and	w0, w8, #0x1
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_add_used_block                 ; -- Begin function add_used_block
	.p2align	2
_add_used_block:                        ; @add_used_block
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	bl	_get_malloc_header
	stur	x0, [x29, #-16]
	b	LBB6_1
LBB6_1:                                 ; =>This Inner Loop Header: Depth=1
	ldur	x8, [x29, #-16]
	ldrb	w8, [x8, #4]
	tbz	w8, #0, LBB6_3
	b	LBB6_2
LBB6_2:                                 ;   in Loop: Header=BB6_1 Depth=1
	mov	w0, #1                          ; =0x1
	bl	_sleep
	b	LBB6_1
LBB6_3:
	ldur	x9, [x29, #-16]
	mov	w8, #1                          ; =0x1
	strb	w8, [x9, #4]
	adrp	x8, _heap_start@PAGE
	ldr	x8, [x8, _heap_start@PAGEOFF]
	add	x8, x8, #16
	stur	x8, [x29, #-24]
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #32]
	ldur	x8, [x29, #-24]
	str	x8, [sp, #24]
	b	LBB6_4
LBB6_4:                                 ; =>This Inner Loop Header: Depth=1
	ldur	x8, [x29, #-24]
	cbz	x8, LBB6_15
	b	LBB6_5
LBB6_5:                                 ;   in Loop: Header=BB6_4 Depth=1
	ldur	x8, [x29, #-24]
	ldrb	w8, [x8]
	subs	w8, w8, #221
	cset	w8, ne
	tbz	w8, #0, LBB6_7
	b	LBB6_6
LBB6_6:
	adrp	x0, l___func__.add_used_block@PAGE
	add	x0, x0, l___func__.add_used_block@PAGEOFF
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	mov	w2, #172                        ; =0xac
	adrp	x3, l_.str.3@PAGE
	add	x3, x3, l_.str.3@PAGEOFF
	bl	___assert_rtn
LBB6_7:                                 ;   in Loop: Header=BB6_4 Depth=1
	b	LBB6_8
LBB6_8:                                 ;   in Loop: Header=BB6_4 Depth=1
	ldur	x8, [x29, #-24]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	ldur	x9, [x29, #-8]
	add	x9, x9, #32
	add	x9, x9, #1
	subs	x8, x8, x9
	b.lo	LBB6_14
	b	LBB6_9
LBB6_9:                                 ;   in Loop: Header=BB6_4 Depth=1
	ldur	x8, [x29, #-24]
	ldrb	w8, [x8, #16]
	tbnz	w8, #0, LBB6_14
	b	LBB6_10
LBB6_10:                                ;   in Loop: Header=BB6_4 Depth=1
	ldr	x8, [sp, #32]
	cbz	x8, LBB6_12
	b	LBB6_11
LBB6_11:                                ;   in Loop: Header=BB6_4 Depth=1
	ldr	x8, [sp, #32]
	ldr	w8, [x8, #20]
	ldur	x9, [x29, #-24]
	ldr	w9, [x9, #20]
	subs	w8, w8, w9
	b.ls	LBB6_13
	b	LBB6_12
LBB6_12:                                ;   in Loop: Header=BB6_4 Depth=1
	ldur	x8, [x29, #-24]
	str	x8, [sp, #32]
	b	LBB6_13
LBB6_13:                                ;   in Loop: Header=BB6_4 Depth=1
	b	LBB6_14
LBB6_14:                                ;   in Loop: Header=BB6_4 Depth=1
	ldur	x8, [x29, #-24]
	str	x8, [sp, #24]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #24]
	stur	x8, [x29, #-24]
	b	LBB6_4
LBB6_15:
	ldr	x8, [sp, #32]
	cbnz	x8, LBB6_20
	b	LBB6_16
LBB6_16:
	bl	_find_last_block
	str	x0, [sp, #16]
	b	LBB6_17
LBB6_17:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #16]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	ldur	x9, [x29, #-8]
	subs	x8, x8, x9
	b.ge	LBB6_19
	b	LBB6_18
LBB6_18:                                ;   in Loop: Header=BB6_17 Depth=1
	mov	w0, #4096                       ; =0x1000
	bl	_sbrk
	ldr	x9, [sp, #16]
	ldr	w8, [x9, #20]
	add	w8, w8, #1, lsl #12             ; =4096
	str	w8, [x9, #20]
	ldur	x9, [x29, #-16]
	ldrh	w8, [x9, #12]
	add	w8, w8, #1
	strh	w8, [x9, #12]
	b	LBB6_17
LBB6_19:
	ldr	x8, [sp, #16]
	str	x8, [sp, #32]
	b	LBB6_20
LBB6_20:
	ldr	x9, [sp, #32]
	mov	w8, #1                          ; =0x1
	strb	w8, [x9, #16]
	ldr	x8, [sp, #32]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	ldur	x9, [x29, #-8]
	subs	x8, x8, x9
	subs	x8, x8, #32
	subs	x8, x8, #1
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	subs	w8, w8, #0
	b.gt	LBB6_22
	b	LBB6_21
LBB6_21:
	mov	w0, #4096                       ; =0x1000
	bl	_sbrk
	ldur	x9, [x29, #-16]
	ldrh	w8, [x9, #12]
	add	w8, w8, #1
	strh	w8, [x9, #12]
	ldr	x9, [sp, #24]
	ldr	w8, [x9, #20]
	add	w8, w8, #1, lsl #12             ; =4096
	str	w8, [x9, #20]
	ldr	x8, [sp, #32]
	ldr	w8, [x8, #20]
                                        ; kill: def $x8 killed $w8
	ldur	x9, [x29, #-8]
	subs	x8, x8, x9
	subs	x8, x8, #32
	subs	x8, x8, #1
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [sp, #12]
	b	LBB6_22
LBB6_22:
	ldr	w8, [sp, #12]
	add	w8, w8, #1
	str	w8, [sp, #12]
	str	w8, [sp, #8]
	ldur	x9, [x29, #-16]
	ldr	w8, [x9, #8]
	add	w8, w8, #1
	str	w8, [x9, #8]
	ldr	x8, [sp, #32]
	add	x8, x8, #32
	ldur	x9, [x29, #-8]
	add	x8, x8, x9
	str	x8, [sp]
	ldr	x9, [sp]
	mov	w8, #221                        ; =0xdd
	strb	w8, [x9]
	ldr	x8, [sp]
	strb	wzr, [x8, #16]
	ldr	x8, [sp, #32]
	ldr	x9, [sp]
	str	x8, [x9, #8]
	ldr	x8, [sp, #32]
	ldr	x8, [x8, #24]
	ldr	x9, [sp]
	str	x8, [x9, #24]
	ldr	w8, [sp, #8]
	ldr	x9, [sp]
	str	w8, [x9, #20]
	ldr	x8, [sp]
	ldr	x8, [x8, #24]
	cbz	x8, LBB6_24
	b	LBB6_23
LBB6_23:
	ldr	x8, [sp]
	ldr	x9, [sp]
	ldr	x9, [x9, #24]
	str	x8, [x9, #8]
	b	LBB6_24
LBB6_24:
	ldr	x8, [sp]
	ldr	x9, [sp, #32]
	str	x8, [x9, #24]
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #32]
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, #20]
	ldur	x8, [x29, #-16]
	strb	wzr, [x8, #4]
	ldr	x8, [sp, #32]
	add	x0, x8, #32
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_an_malloc                      ; -- Begin function an_malloc
	.p2align	2
_an_malloc:                             ; @an_malloc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	adrp	x8, _heap_start@PAGE
	ldr	x8, [x8, _heap_start@PAGEOFF]
	cbnz	x8, LBB7_2
	b	LBB7_1
LBB7_1:
	mov	w0, #0                          ; =0x0
	bl	_sbrk
	adrp	x8, _heap_start@PAGE
	str	x0, [x8, _heap_start@PAGEOFF]
	mov	w0, #4096                       ; =0x1000
	bl	_sbrk
	b	LBB7_2
LBB7_2:
	mov	w0, #0                          ; =0x0
	bl	_sbrk
	stur	x0, [x29, #-16]
	ldur	x9, [x29, #-16]
	adrp	x8, _heap_start@PAGE
	ldr	x10, [x8, _heap_start@PAGEOFF]
	subs	x9, x9, x10
	str	x9, [sp, #24]
	ldr	x8, [x8, _heap_start@PAGEOFF]
	ldrsb	w8, [x8]
	subs	w8, w8, #85
	b.eq	LBB7_4
	b	LBB7_3
LBB7_3:
	adrp	x8, _heap_start@PAGE
	ldr	x10, [x8, _heap_start@PAGEOFF]
	mov	w9, #85                         ; =0x55
	strb	w9, [x10]
	ldr	x9, [x8, _heap_start@PAGEOFF]
	str	x9, [sp, #16]
	ldr	x10, [sp, #16]
	mov	w9, #1                          ; =0x1
	str	w9, [x10, #8]
	ldr	x10, [sp, #16]
	mov	w9, #1                          ; =0x1
	strh	w9, [x10, #12]
	ldr	x8, [x8, _heap_start@PAGEOFF]
	add	x8, x8, #16
	str	x8, [sp, #8]
	ldr	x9, [sp, #8]
	mov	w8, #221                        ; =0xdd
	strb	w8, [x9]
	ldr	x8, [sp, #8]
	strb	wzr, [x8, #16]
	ldr	x8, [sp, #24]
	subs	x8, x8, #16
	subs	x8, x8, #32
	ldr	x9, [sp, #8]
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, #20]
	ldr	x8, [sp, #8]
                                        ; kill: def $x9 killed $xzr
	str	xzr, [x8, #24]
	ldr	x8, [sp, #8]
	str	xzr, [x8, #8]
	b	LBB7_4
LBB7_4:
	ldur	x0, [x29, #-8]
	bl	_add_used_block
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w0, #0                          ; =0x0
	str	wzr, [sp, #12]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
	.globl	_MAGICAL_BYTES                  ; @MAGICAL_BYTES
	.p2align	2, 0x0
_MAGICAL_BYTES:
	.long	85                              ; 0x55

	.globl	_BLOCK_MARKER                   ; @BLOCK_MARKER
	.p2align	2, 0x0
_BLOCK_MARKER:
	.long	221                             ; 0xdd

	.globl	_PAGE_SIZE                      ; @PAGE_SIZE
	.p2align	2, 0x0
_PAGE_SIZE:
	.long	4096                            ; 0x1000

	.globl	_heap_start                     ; @heap_start
.zerofill __DATA,__common,_heap_start,8,3
	.section	__TEXT,__cstring,cstring_literals
l___func__.get_malloc_header:           ; @__func__.get_malloc_header
	.asciz	"get_malloc_header"

l_.str:                                 ; @.str
	.asciz	"malloc.c"

l_.str.1:                               ; @.str.1
	.asciz	"heap_start != NULL"

l_.str.2:                               ; @.str.2
	.asciz	"malloc_header->magical_bytes == MAGICAL_BYTES"

l___func__.add_used_block:              ; @__func__.add_used_block
	.asciz	"add_used_block"

l_.str.3:                               ; @.str.3
	.asciz	"block->marker == BLOCK_MARKER"

.subsections_via_symbols
