#include "constants/maps.h"
#include "constants/species.h"
	.include "asm/macros.inc"
	.include "constants/constants.inc"

	.section .rodata
	.align 2

gUnknown_83E23D0:: @ 83E23D0
	.4byte sub_809F11C
	.4byte KeyboardKeyHandler_Page
	.4byte KeyboardKeyHandler_Backspace
	.4byte KeyboardKeyHandler_OK

gUnknown_83E23E0:: @ 83E23E0
	.4byte InputState_Disabled
	.4byte InputState_Enabled

gUnknown_83E23E8:: @ 83E23E8
	.2byte 0x0000, 0x0000, 0x0000, 0xffff, 0x0001

gUnknown_83E23F2:: @ 83E23F2
	.2byte 0x0000, 0xffff, 0x0001, 0x0000, 0x0000

gUnknown_83E23FC:: @ 83E23FC
	.2byte 0x0000, 0x0001, 0x0001, 0x0002

gUnknown_83E2404:: @ 83E2404
	.2byte 0x0000, 0x0000, 0x0003, 0x0000

gUnknown_83E240C:: @ 83E240C
	.4byte sub_809F49C
	.4byte sub_809F49C
	.4byte sub_809F4F0
	.4byte sub_809F4F0
	.4byte sub_809F49C

gUnknown_83E2420:: @ 83E2420
	.4byte nullsub_55
	.4byte sub_809F5C4

gUnknown_83E2428:: @ 83E2428
	.byte 0x00, 0x09, 0x08, 0x00
	.byte 0x05, 0x04, 0x00, 0x00

gUnknown_83E2430:: @ 83E2430
	.byte 0x0d, 0x01, 0x02, 0x00

gUnknown_83E2434:: @ 83E2434
	.byte 0x0e, 0x01, 0x02, 0x00

gUnknown_83E2438:: @ 83E2438
	.byte 0x0f, 0x01, 0x02, 0x00

gUnknown_83E243C:: @ 83E243C
	.byte 0xee, 0xdd, 0xff, 0x00

gUnknown_83E2440:: @ 83E2440
	.4byte gUnknown_83E2434
	.4byte gUnknown_83E2430
	.4byte gUnknown_83E2438

gUnknown_83E244C:: @ 83E244C
	.4byte gUnknown_8E98398
	.4byte gUnknown_8E98458
	.4byte gUnknown_8E98518

gUnknown_83E2458:: @ 83E2458
	.byte 0x0f, 0x01, 0x02

	.align 2
gUnknown_83E245C:: @ 83E245C
	.byte 0x00, 0x07, 0x01, 0x00, 0x01
	.align 2
	.4byte gUnknown_8418E47

gUnknown_83E2468:: @ 83E2468
	.byte 0x00, 0x08, 0x02, 0x00, 0x01
	.align 2
	.4byte gUnknown_8418E52

gUnknown_83E2474:: @ 83E2474
	.byte 0x00, 0x0a, 0x03, 0x01, 0x01
	.align 2
	.4byte gUnknown_8418E5C

gUnknown_83E2480:: @ 83E2480
	.byte 0x00, 0x07, 0x04, 0x00, 0x01
	.align 2
	.4byte gUnknown_8418E69

sNamingScreenTemplates:: @ 83E248C
	.4byte gUnknown_83E245C @ NAMING_SCREEN_PLAYER
	.4byte gUnknown_83E2468 @ NAMING_SCREEN_BOX
	.4byte gUnknown_83E2474 @ NAMING_SCREEN_CAUGHT_MON
	.4byte gUnknown_83E2474 @ NAMING_SCREEN_NAME_RATER
	.4byte gUnknown_83E2480 @ NAMING_SCREEN_RIVAL

gUnknown_83E24A0:: @ 83E24A0
	.4byte 0x00000000, 0x00000000

gUnknown_83E24A8:: @ 3E24A8
	.4byte 0x40000000, 0x00000000

gUnknown_83E24B0:: @ 3E24B0
	.4byte 0x80004000, 0x00000000

gUnknown_83E24B8:: @ 83E24B8
	subsprite 236, 240, 1, 0x0000, 32x8
	subsprite 12, 240, 1, 0x0004, 8x8
	subsprite 236, 248, 1, 0x0005, 32x8
	subsprite 12, 248, 1, 0x0009, 8x8
	subsprite 236, 0, 1, 0x000a, 32x8
	subsprite 12, 0, 1, 0x000e, 8x8
	subsprite 236, 8, 1, 0x000f, 32x8
	subsprite 12, 8, 1, 0x0013, 8x8

gUnknown_83E24D8:: @ 83E24D8
	subsprite 244, 252, 1, 0x0000, 16x8
	subsprite 4, 252, 1, 0x0002, 8x8

gUnknown_83E24E0:: @ 83E24E0
	subsprite 236, 244, 1, 0x0000, 32x8
	subsprite 12, 244, 1, 0x0004, 8x8
	subsprite 236, 252, 1, 0x0005, 32x8
	subsprite 12, 252, 1, 0x0009, 8x8
	subsprite 236, 4, 1, 0x000a, 32x8
	subsprite 12, 4, 1, 0x000e, 8x8

gUnknown_83E24F8::
	subsprite 248, 244, 3, 0x0000, 16x8
	subsprite 248, 252, 3, 0x0002, 16x8
	subsprite 248, 4, 3, 0x0004, 16x8

gUnknown_83E2504:: @ 83E2504
	.byte 0x08
	.align 2
	.4byte gUnknown_83E24B8

gUnknown_83E250C:: @ 83E250C
	.byte 0x02
	.align 2
	.4byte gUnknown_83E24D8
	.byte 0x02
	.align 2
	.4byte gUnknown_83E24D8
	.byte 0x02
	.align 2
	.4byte gUnknown_83E24D8

gUnknown_83E2524:: @ 83E2524
	.byte 0x06
	.align 2
	.4byte gUnknown_83E24E0

gUnknown_83E252C:: @ 83E252C
	.byte 0x03
	.align 2
	.4byte gUnknown_83E24F8

gUnknown_83E2534:: @ 83E2534
	obj_frame_tiles gUnknown_83E1800, 0x00c0
	obj_frame_tiles gUnknown_83E18C0, 0x00c0

gUnknown_83E2544:: @ 83E2544
	obj_image_anim_frame 0, 1
	obj_image_anim_jump 0

gUnknown_83E254C:: @ 83E254C
	obj_image_anim_frame 4, 8
	obj_image_anim_frame 8, 8
	obj_image_anim_end

gUnknown_83E2558:: @ 83E2558
	obj_image_anim_frame 0, 2
	obj_image_anim_frame 1, 2
	obj_image_anim_jump 0

gUnknown_83E2564:: @ 83E2564
	.4byte gUnknown_83E2544

gUnknown_83E2568:: @ 83E2568
	.4byte gUnknown_83E2544
	.4byte gUnknown_83E254C

gUnknown_83E2570:: @ 83E2570
	.4byte gUnknown_83E2558

gUnknown_83E2574:: @ 83E2574
	spr_template 2, 4, gUnknown_83E24A0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, SpriteCB_PageSwap

gUnknown_83E258C:: @ 83E258C
	spr_template 3, 1, gUnknown_83E24B0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, SpriteCallbackDummy

gUnknown_83E25A4:: @ 83E25A4
	spr_template 4, 4, gUnknown_83E24A0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, SpriteCallbackDummy

gUnknown_83E25BC:: @ 83E25BC
	spr_template 0, 6, gUnknown_83E24A0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, SpriteCallbackDummy

gUnknown_83E25D4:: @ 83E25D4
	spr_template 1, 7, gUnknown_83E24A0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, SpriteCallbackDummy

gUnknown_83E25EC:: @ 83E25EC
	spr_template 7, 5, gUnknown_83E24A8, gUnknown_83E2568, NULL, gDummySpriteAffineAnimTable, sub_809E700

sSpriteTemplate_InputArrow:: @ 83E2604
	spr_template 10, 3, gUnknown_83E24A0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, sub_809E7F0

sSpriteTemplate_Underscore:: @ 83E261C
	spr_template 11, 3, gUnknown_83E24A0, gUnknown_83E2564, NULL, gDummySpriteAffineAnimTable, sub_809E83C

gUnknown_83E2634:: @ 83E2634
	spr_template 65535, 0, gUnknown_83E24A0, gUnknown_83E2570, gUnknown_83E2534, gDummySpriteAffineAnimTable, SpriteCallbackDummy

gUnknown_83E264C:: @ 83E264C
	.4byte gUnknown_847A955
	.4byte gUnknown_847A976
	.4byte gUnknown_847A997
	.4byte gUnknown_847A9B8
	.4byte gUnknown_847A9D9
	.4byte gUnknown_847A9FA
	.4byte gUnknown_847AA1B
	.4byte gUnknown_847AA3C
	.4byte gUnknown_847AA5D
	.4byte gUnknown_847AA76
	.4byte gUnknown_847AA8F
	.4byte gUnknown_847AAA8

gUnknown_83E267C:: @ 83E267C
	obj_tiles gUnknown_8E98858, 0x01e0, 0
	obj_tiles gUnknown_8E98A38, 0x01e0, 1
	obj_tiles gUnknown_8E985D8, 0x0280, 2
	obj_tiles gUnknown_8E98FD8, 0x0100, 3
	obj_tiles gUnknown_8E98C18, 0x0060, 4
	obj_tiles gUnknown_8E98CB8, 0x0060, 5
	obj_tiles gUnknown_8E98D58, 0x0060, 6
	obj_tiles gUnknown_8E98DF8, 0x0080, 7
	obj_tiles gUnknown_8E98E98, 0x0080, 8
	obj_tiles gUnknown_8E98F38, 0x0080, 9
	obj_tiles gUnknown_8E990D8, 0x0020, 10
	obj_tiles gUnknown_8E990F8, 0x0020, 11
	null_obj_tiles

gUnknown_83E26E4:: @ 83E26E4
	obj_pal gUnknown_8E98024, 0
	obj_pal gUnknown_8E98044, 1
	obj_pal gUnknown_8E98064, 2
	obj_pal gUnknown_8E98084, 3
	obj_pal gUnknown_8E980A4, 4
	obj_pal gUnknown_8E980C4, 5
	obj_pal gUnknown_8E980A4, 6
	obj_pal gUnknown_8E980A4, 7
	null_obj_pal
