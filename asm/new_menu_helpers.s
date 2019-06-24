	.include "asm/macros.inc"
	.include "constants/constants.inc"

	.syntax unified

	.text

	thumb_func_start GetTextSpeedSetting
GetTextSpeedSetting: @ 80F78A8
	push {lr}
	ldr r3, _080F78D8 @ =gSaveBlock2Ptr
	ldr r2, [r3]
	ldrb r1, [r2, 0x14]
	lsls r0, r1, 29
	lsrs r0, 29
	cmp r0, 0x2
	bls _080F78C4
	movs r0, 0x8
	negs r0, r0
	ands r0, r1
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2, 0x14]
_080F78C4:
	ldr r1, _080F78DC @ =gUnknown_841F428
	ldr r0, [r3]
	ldrb r0, [r0, 0x14]
	lsls r0, 29
	lsrs r0, 29
	adds r0, r1
	ldrb r0, [r0]
	pop {r1}
	bx r1
	.align 2, 0
_080F78D8: .4byte gSaveBlock2Ptr
_080F78DC: .4byte gUnknown_841F428
	thumb_func_end GetTextSpeedSetting

	thumb_func_start sub_80F78E0
sub_80F78E0: @ 80F78E0
	push {r4,lr}
	sub sp, 0x20
	lsls r0, 24
	lsrs r1, r0, 24
	ldr r4, _080F7934 @ =sStartMenuWindowId
	ldrb r0, [r4]
	cmp r0, 0xFF
	bne _080F792A
	movs r0, 0x7
	str r0, [sp]
	lsls r0, r1, 25
	movs r1, 0xFF
	lsls r1, 24
	adds r0, r1
	lsrs r0, 24
	str r0, [sp, 0x4]
	movs r0, 0xF
	str r0, [sp, 0x8]
	ldr r0, _080F7938 @ =0x0000013d
	str r0, [sp, 0xC]
	add r0, sp, 0x10
	movs r1, 0
	movs r2, 0x16
	movs r3, 0x1
	bl SetWindowTemplateFields
	ldr r0, [sp, 0x10]
	ldr r1, [sp, 0x14]
	str r0, [sp, 0x18]
	str r1, [sp, 0x1C]
	add r0, sp, 0x18
	bl AddWindow
	strb r0, [r4]
	ldrb r0, [r4]
	bl PutWindowTilemap
_080F792A:
	ldrb r0, [r4]
	add sp, 0x20
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_080F7934: .4byte sStartMenuWindowId
_080F7938: .4byte 0x0000013d
	thumb_func_end sub_80F78E0

	thumb_func_start GetStartMenuWindowId
GetStartMenuWindowId: @ 80F793C
	ldr r0, _080F7944 @ =sStartMenuWindowId
	ldrb r0, [r0]
	bx lr
	.align 2, 0
_080F7944: .4byte sStartMenuWindowId
	thumb_func_end GetStartMenuWindowId

	thumb_func_start remove_start_menu_window_maybe
remove_start_menu_window_maybe: @ 80F7948
	push {r4,lr}
	ldr r4, _080F7960 @ =sStartMenuWindowId
	ldrb r0, [r4]
	cmp r0, 0xFF
	beq _080F795A
	bl RemoveWindow
	movs r0, 0xFF
	strb r0, [r4]
_080F795A:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080F7960: .4byte sStartMenuWindowId
	thumb_func_end remove_start_menu_window_maybe

	thumb_func_start sub_80F7964
sub_80F7964: @ 80F7964
	movs r0, 0x80
	lsls r0, 2
	bx lr
	thumb_func_end sub_80F7964

	thumb_func_start sub_80F796C
sub_80F796C: @ 80F796C
	movs r0, 0x85
	lsls r0, 2
	bx lr
	thumb_func_end sub_80F796C

	thumb_func_start sub_80F7974
sub_80F7974: @ 80F7974
	push {r4,lr}
	adds r4, r0, 0
	bl sub_8112EB4
	lsls r0, 24
	lsrs r0, 24
	movs r1, 0x80
	lsls r1, 2
	movs r2, 0xF0
	bl sub_814FE6C
	adds r0, r4, 0
	movs r1, 0x2
	bl sub_8113018
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80F7974

	thumb_func_start sub_80F7998
sub_80F7998: @ 80F7998
	push {lr}
	movs r0, 0x2
	bl sub_8112EDC
	pop {r0}
	bx r0
	thumb_func_end sub_80F7998

	thumb_func_start sub_80F79A4
sub_80F79A4: @ 80F79A4
	push {lr}
	bl Menu_LoadStdPal
	movs r1, 0x80
	lsls r1, 2
	movs r0, 0
	movs r2, 0xF0
	bl sub_814FEEC
	movs r1, 0x85
	lsls r1, 2
	movs r0, 0
	movs r2, 0xE0
	bl TextWindow_SetUserSelectedFrame
	pop {r0}
	bx r0
	thumb_func_end sub_80F79A4

	thumb_func_start SetDefaultFontsPointer
SetDefaultFontsPointer: @ 80F79C8
	push {lr}
	ldr r0, _080F79D4 @ =gUnknown_841F444
	bl SetFontsPointer
	pop {r0}
	bx r0
	.align 2, 0
_080F79D4: .4byte gUnknown_841F444
	thumb_func_end SetDefaultFontsPointer

	thumb_func_start GetFontAttribute
GetFontAttribute: @ 80F79D8
	push {lr}
	lsls r0, 24
	lsrs r2, r0, 24
	lsls r1, 24
	lsrs r1, 24
	movs r0, 0
	cmp r1, 0x7
	bhi _080F7AB6
	lsls r0, r1, 2
	ldr r1, _080F79F4 @ =_080F79F8
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_080F79F4: .4byte _080F79F8
	.align 2, 0
_080F79F8:
	.4byte _080F7A18
	.4byte _080F7A2C
	.4byte _080F7A40
	.4byte _080F7A54
	.4byte _080F7A68
	.4byte _080F7A7C
	.4byte _080F7A90
	.4byte _080F7AA8
_080F7A18:
	ldr r1, _080F7A28 @ =gUnknown_841F444
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0, 0x4]
	b _080F7AB6
	.align 2, 0
_080F7A28: .4byte gUnknown_841F444
_080F7A2C:
	ldr r1, _080F7A3C @ =gUnknown_841F444
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0, 0x5]
	b _080F7AB6
	.align 2, 0
_080F7A3C: .4byte gUnknown_841F444
_080F7A40:
	ldr r1, _080F7A50 @ =gUnknown_841F444
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0, 0x6]
	b _080F7AB6
	.align 2, 0
_080F7A50: .4byte gUnknown_841F444
_080F7A54:
	ldr r1, _080F7A64 @ =gUnknown_841F444
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0, 0x7]
	b _080F7AB6
	.align 2, 0
_080F7A64: .4byte gUnknown_841F444
_080F7A68:
	ldr r0, _080F7A78 @ =gUnknown_841F444
	lsls r1, r2, 1
	adds r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0x8]
	b _080F7A9C
	.align 2, 0
_080F7A78: .4byte gUnknown_841F444
_080F7A7C:
	ldr r0, _080F7A8C @ =gUnknown_841F444
	lsls r1, r2, 1
	adds r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0x8]
	b _080F7AB4
	.align 2, 0
_080F7A8C: .4byte gUnknown_841F444
_080F7A90:
	ldr r0, _080F7AA4 @ =gUnknown_841F444
	lsls r1, r2, 1
	adds r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0x9]
_080F7A9C:
	lsls r0, 28
	lsrs r0, 28
	b _080F7AB6
	.align 2, 0
_080F7AA4: .4byte gUnknown_841F444
_080F7AA8:
	ldr r0, _080F7ABC @ =gUnknown_841F444
	lsls r1, r2, 1
	adds r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0x9]
_080F7AB4:
	lsrs r0, 4
_080F7AB6:
	pop {r1}
	bx r1
	.align 2, 0
_080F7ABC: .4byte gUnknown_841F444
	thumb_func_end GetFontAttribute

	thumb_func_start GetMenuCursorDimensionByFont
GetMenuCursorDimensionByFont: @ 80F7AC0
	lsls r0, 24
	lsls r1, 24
	lsrs r1, 24
	ldr r2, _080F7AD4 @ =gUnknown_841F4A4
	lsrs r0, 23
	adds r1, r0
	adds r1, r2
	ldrb r0, [r1]
	bx lr
	.align 2, 0
_080F7AD4: .4byte gUnknown_841F4A4
	thumb_func_end GetMenuCursorDimensionByFont

	.align 2, 0 @ Don't pad with nop.
