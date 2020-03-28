	.include "asm/macros.inc"
	.include "constants/constants.inc"

	.syntax unified

	.text

	thumb_func_start CB2_ContinueSavedGame
CB2_ContinueSavedGame: @ 8056938
	push {lr}
	bl FieldClearVBlankHBlankCallbacks
	bl StopMapMusic
	bl ResetSafariZoneFlag_
	bl LoadSaveblockMapHeader
	bl sub_80550A8
	bl UnfreezeObjectEvents
	bl sub_8054E40
	bl InitMapFromSavedGame
	bl PlayTimeCounter_Start
	bl ScriptContext1_Init
	bl ScriptContext2_Disable
	ldr r1, _08056990 @ =gFieldCallback2
	movs r0, 0
	str r0, [r1]
	ldr r1, _08056994 @ =gUnknown_2031DE0
	movs r0, 0x1
	strb r0, [r1]
	bl sav2_x1_query_bit1
	cmp r0, 0x1
	bne _0805699C
	bl sav2_x9_clear_bit1
	bl SetWarpDestinationToContinueGameWarp
	bl WarpIntoMap
	ldr r0, _08056998 @ =CB2_LoadMap
	bl SetMainCallback2
	b _080569AC
	.align 2, 0
_08056990: .4byte gFieldCallback2
_08056994: .4byte gUnknown_2031DE0
_08056998: .4byte CB2_LoadMap
_0805699C:
	ldr r0, _080569B0 @ =gFieldCallback
	ldr r1, _080569B4 @ =sub_8056918
	str r1, [r0]
	ldr r0, _080569B8 @ =CB1_Overworld
	bl SetMainCallback1
	bl CB2_ReturnToField
_080569AC:
	pop {r0}
	bx r0
	.align 2, 0
_080569B0: .4byte gFieldCallback
_080569B4: .4byte sub_8056918
_080569B8: .4byte CB1_Overworld
	thumb_func_end CB2_ContinueSavedGame

	thumb_func_start FieldClearVBlankHBlankCallbacks
FieldClearVBlankHBlankCallbacks: @ 80569BC
	push {lr}
	bl sub_80CC87C
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080569CE
	bl CloseLink
_080569CE:
	ldr r0, _080569E4 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	beq _080569E8
	movs r0, 0xC5
	bl EnableInterrupts
	movs r0, 0x2
	bl DisableInterrupts
	b _080569F4
	.align 2, 0
_080569E4: .4byte gWirelessCommType
_080569E8:
	movs r0, 0x2
	bl DisableInterrupts
	movs r0, 0x1
	bl EnableInterrupts
_080569F4:
	movs r0, 0
	bl SetVBlankCallback
	movs r0, 0
	bl SetHBlankCallback
	pop {r0}
	bx r0
	thumb_func_end FieldClearVBlankHBlankCallbacks

	thumb_func_start SetFieldVBlankCallback
SetFieldVBlankCallback: @ 8056A04
	push {lr}
	ldr r0, _08056A10 @ =VBlankCB_Field
	bl SetVBlankCallback
	pop {r0}
	bx r0
	.align 2, 0
_08056A10: .4byte VBlankCB_Field
	thumb_func_end SetFieldVBlankCallback

	thumb_func_start VBlankCB_Field
VBlankCB_Field: @ 8056A14
	push {lr}
	bl LoadOam
	bl ProcessSpriteCopyRequests
	bl ScanlineEffect_InitHBlankDmaTransfer
	bl FieldUpdateBgTilemapScroll
	bl TransferPlttBuffer
	bl TransferTilesetAnimsBuffer
	pop {r0}
	bx r0
	thumb_func_end VBlankCB_Field

	thumb_func_start InitCurrentFlashLevelScanlineEffect
InitCurrentFlashLevelScanlineEffect: @ 8056A34
	push {lr}
	bl Overworld_GetFlashLevel
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0
	beq _08056A52
	bl WriteFlashScanlineEffectBuffer
	ldr r2, _08056A58 @ =gFlashEffectParams
	ldr r0, [r2]
	ldr r1, [r2, 0x4]
	ldr r2, [r2, 0x8]
	bl ScanlineEffect_SetParams
_08056A52:
	pop {r0}
	bx r0
	.align 2, 0
_08056A58: .4byte gFlashEffectParams
	thumb_func_end InitCurrentFlashLevelScanlineEffect

	thumb_func_start map_loading_iteration_3
map_loading_iteration_3: @ 8056A5C
	push {r4,lr}
	adds r4, r0, 0
	ldrb r0, [r4]
	cmp r0, 0xD
	bls _08056A68
	b _08056B6E
_08056A68:
	lsls r0, 2
	ldr r1, _08056A74 @ =_08056A78
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08056A74: .4byte _08056A78
	.align 2, 0
_08056A78:
	.4byte _08056AB0
	.4byte _08056ABE
	.4byte _08056AC6
	.4byte _08056ACE
	.4byte _08056AE4
	.4byte _08056AEE
	.4byte _08056AF4
	.4byte _08056B04
	.4byte _08056B14
	.4byte _08056B30
	.4byte _08056B36
	.4byte _08056B3C
	.4byte _08056B58
	.4byte _08056B6A
_08056AB0:
	bl InitOverworldBgs
	bl ScriptContext1_Init
	bl ScriptContext2_Disable
	b _08056B62
_08056ABE:
	movs r0, 0x1
	bl mli0_load_map
	b _08056B62
_08056AC6:
	movs r0, 0x1
	bl sub_8057024
	b _08056B62
_08056ACE:
	bl sub_8057178
	bl sub_8057074
	bl sub_80571A8
	bl sub_8057140
	bl SetHelpContextForMap
	b _08056B62
_08056AE4:
	bl InitCurrentFlashLevelScanlineEffect
	bl sub_8056F1C
	b _08056B62
_08056AEE:
	bl move_tilemap_camera_to_upper_left_corner
	b _08056B62
_08056AF4:
	ldr r0, _08056B00 @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset1_to_vram
	b _08056B62
	.align 2, 0
_08056B00: .4byte gMapHeader
_08056B04:
	ldr r0, _08056B10 @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset2_to_vram
	b _08056B62
	.align 2, 0
_08056B10: .4byte gMapHeader
_08056B14:
	bl FreeTempTileDataBuffersIfPossible
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08056B6E
	ldr r0, _08056B2C @ =gMapHeader
	ldr r0, [r0]
	bl apply_map_tileset1_tileset2_palette
	b _08056B62
	.align 2, 0
_08056B2C: .4byte gMapHeader
_08056B30:
	bl DrawWholeMapView
	b _08056B62
_08056B36:
	bl InitTilesetAnimations
	b _08056B62
_08056B3C:
	ldr r0, _08056B54 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	beq _08056B62
	bl LoadWirelessStatusIndicatorSpriteGfx
	movs r0, 0
	movs r1, 0
	bl CreateWirelessStatusIndicatorSprite
	b _08056B62
	.align 2, 0
_08056B54: .4byte gWirelessCommType
_08056B58:
	bl map_post_load_hook_exec
	lsls r0, 24
	cmp r0, 0
	beq _08056B6E
_08056B62:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	b _08056B6E
_08056B6A:
	movs r0, 0x1
	b _08056B70
_08056B6E:
	movs r0, 0
_08056B70:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end map_loading_iteration_3

	thumb_func_start sub_8056B78
sub_8056B78: @ 8056B78
	push {r4,r5,lr}
	adds r4, r0, 0
	adds r5, r1, 0
	ldrb r0, [r4]
	cmp r0, 0xE
	bls _08056B86
	b _08056CD0
_08056B86:
	lsls r0, 2
	ldr r1, _08056B90 @ =_08056B94
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08056B90: .4byte _08056B94
	.align 2, 0
_08056B94:
	.4byte _08056BD0
	.4byte _08056BE0
	.4byte _08056BE6
	.4byte _08056BEE
	.4byte _08056BFE
	.4byte _08056C20
	.4byte _08056C2A
	.4byte _08056C30
	.4byte _08056C40
	.4byte _08056C50
	.4byte _08056C6C
	.4byte _08056C72
	.4byte _08056C78
	.4byte _08056CC0
	.4byte _08056BFA
_08056BD0:
	bl InitOverworldBgs
	bl FieldClearVBlankHBlankCallbacks
	adds r0, r5, 0
	bl mli0_load_map
	b _08056CCA
_08056BE0:
	bl sub_8111F14
	b _08056CCA
_08056BE6:
	adds r0, r5, 0
	bl sub_8057024
	b _08056CCA
_08056BEE:
	bl sub_8113748
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08056CCA
_08056BFA:
	movs r0, 0x1
	b _08056CD2
_08056BFE:
	bl mli4_mapscripts_and_other
	bl sub_8057114
	ldr r0, _08056C1C @ =gQuestLogState
	ldrb r0, [r0]
	cmp r0, 0x2
	beq _08056C16
	bl sub_80CC534
	bl sub_80CC59C
_08056C16:
	bl SetHelpContextForMap
	b _08056CCA
	.align 2, 0
_08056C1C: .4byte gQuestLogState
_08056C20:
	bl InitCurrentFlashLevelScanlineEffect
	bl sub_8056F1C
	b _08056CCA
_08056C2A:
	bl move_tilemap_camera_to_upper_left_corner
	b _08056CCA
_08056C30:
	ldr r0, _08056C3C @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset1_to_vram
	b _08056CCA
	.align 2, 0
_08056C3C: .4byte gMapHeader
_08056C40:
	ldr r0, _08056C4C @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset2_to_vram
	b _08056CCA
	.align 2, 0
_08056C4C: .4byte gMapHeader
_08056C50:
	bl FreeTempTileDataBuffersIfPossible
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08056CD0
	ldr r0, _08056C68 @ =gMapHeader
	ldr r0, [r0]
	bl apply_map_tileset1_tileset2_palette
	b _08056CCA
	.align 2, 0
_08056C68: .4byte gMapHeader
_08056C6C:
	bl DrawWholeMapView
	b _08056CCA
_08056C72:
	bl InitTilesetAnimations
	b _08056CCA
_08056C78:
	bl GetLastUsedWarpMapSectionId
	ldr r5, _08056CA4 @ =gMapHeader
	lsls r0, 24
	lsrs r0, 24
	ldrb r1, [r5, 0x14]
	cmp r0, r1
	beq _08056CA8
	ldrb r0, [r5, 0x14]
	movs r1, 0x1
	bl MapHasPreviewScreen_HandleQLState2
	cmp r0, 0x1
	bne _08056CA8
	ldrb r0, [r5, 0x14]
	bl MapPreview_LoadGfx
	ldrb r0, [r5, 0x14]
	bl MapPreview_StartForestTransition
	b _08056CCA
	.align 2, 0
_08056CA4: .4byte gMapHeader
_08056CA8:
	ldr r0, _08056CBC @ =gMapHeader
	ldrb r1, [r0, 0x19]
	movs r0, 0xFC
	ands r0, r1
	cmp r0, 0x4
	bne _08056CCA
	movs r0, 0
	bl ShowMapNamePopup
	b _08056CCA
	.align 2, 0
_08056CBC: .4byte gMapHeader
_08056CC0:
	bl map_post_load_hook_exec
	lsls r0, 24
	cmp r0, 0
	beq _08056CD0
_08056CCA:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
_08056CD0:
	movs r0, 0
_08056CD2:
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end sub_8056B78

	thumb_func_start sub_8056CD8
sub_8056CD8: @ 8056CD8
	push {r4,lr}
	adds r4, r0, 0
	ldrb r0, [r4]
	cmp r0, 0x4
	bhi _08056D3C
	lsls r0, 2
	ldr r1, _08056CEC @ =_08056CF0
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08056CEC: .4byte _08056CF0
	.align 2, 0
_08056CF0:
	.4byte _08056D04
	.4byte _08056D30
	.4byte _08056D1C
	.4byte _08056D26
	.4byte _08056D38
_08056D04:
	bl InitOverworldBgs
	bl sub_8111F14
	movs r0, 0
	bl sub_8057024
	bl sub_8057100
	bl sub_8057114
	b _08056D30
_08056D1C:
	bl sub_8056F08
	bl SetHelpContextForMap
	b _08056D30
_08056D26:
	bl map_post_load_hook_exec
	lsls r0, 24
	cmp r0, 0
	beq _08056D3C
_08056D30:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	b _08056D3C
_08056D38:
	movs r0, 0x1
	b _08056D3E
_08056D3C:
	movs r0, 0
_08056D3E:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8056CD8

	thumb_func_start map_loading_iteration_2_link
map_loading_iteration_2_link: @ 8056D44
	push {r4,lr}
	adds r4, r0, 0
	ldrb r0, [r4]
	cmp r0, 0xD
	bls _08056D50
	b _08056E54
_08056D50:
	lsls r0, 2
	ldr r1, _08056D5C @ =_08056D60
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08056D5C: .4byte _08056D60
	.align 2, 0
_08056D60:
	.4byte _08056D98
	.4byte _08056DA2
	.4byte _08056DAE
	.4byte _08056DC0
	.4byte _08056DCA
	.4byte _08056DD0
	.4byte _08056DE0
	.4byte _08056DF0
	.4byte _08056E0C
	.4byte _08056E12
	.4byte _08056E3E
	.4byte _08056E18
	.4byte _08056E34
	.4byte _08056E46
_08056D98:
	bl InitOverworldBgs
	bl FieldClearVBlankHBlankCallbacks
	b _08056E3E
_08056DA2:
	bl sub_8111F14
	movs r0, 0x1
	bl sub_8057024
	b _08056E3E
_08056DAE:
	bl sub_8057230
	bl sub_8057100
	bl sub_805715C
	bl SetHelpContextForMap
	b _08056E3E
_08056DC0:
	bl InitCurrentFlashLevelScanlineEffect
	bl sub_8056F1C
	b _08056E3E
_08056DCA:
	bl move_tilemap_camera_to_upper_left_corner
	b _08056E3E
_08056DD0:
	ldr r0, _08056DDC @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset1_to_vram
	b _08056E3E
	.align 2, 0
_08056DDC: .4byte gMapHeader
_08056DE0:
	ldr r0, _08056DEC @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset2_to_vram
	b _08056E3E
	.align 2, 0
_08056DEC: .4byte gMapHeader
_08056DF0:
	bl FreeTempTileDataBuffersIfPossible
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08056E54
	ldr r0, _08056E08 @ =gMapHeader
	ldr r0, [r0]
	bl apply_map_tileset1_tileset2_palette
	b _08056E3E
	.align 2, 0
_08056E08: .4byte gMapHeader
_08056E0C:
	bl DrawWholeMapView
	b _08056E3E
_08056E12:
	bl InitTilesetAnimations
	b _08056E3E
_08056E18:
	ldr r0, _08056E30 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	beq _08056E3E
	bl LoadWirelessStatusIndicatorSpriteGfx
	movs r0, 0
	movs r1, 0
	bl CreateWirelessStatusIndicatorSprite
	b _08056E3E
	.align 2, 0
_08056E30: .4byte gWirelessCommType
_08056E34:
	bl map_post_load_hook_exec
	lsls r0, 24
	cmp r0, 0
	beq _08056E54
_08056E3E:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	b _08056E54
_08056E46:
	bl SetFieldVBlankCallback
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	movs r0, 0x1
	b _08056E56
_08056E54:
	movs r0, 0
_08056E56:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end map_loading_iteration_2_link

	thumb_func_start do_load_map_stuff_loop
do_load_map_stuff_loop: @ 8056E5C
	push {r4,lr}
	adds r4, r0, 0
_08056E60:
	adds r0, r4, 0
	movs r1, 0
	bl sub_8056B78
	cmp r0, 0
	beq _08056E60
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end do_load_map_stuff_loop

	thumb_func_start MoveSaveBlocks_ResetHeap_
MoveSaveBlocks_ResetHeap_: @ 8056E74
	push {lr}
	bl MoveSaveBlocks_ResetHeap
	pop {r0}
	bx r0
	thumb_func_end MoveSaveBlocks_ResetHeap_

	thumb_func_start sub_8056E80
sub_8056E80: @ 8056E80
	push {r4-r7,lr}
	sub sp, 0x4
	movs r0, 0
	movs r1, 0
	bl SetGpuReg
	bl ScanlineEffect_Stop
	ldr r2, _08056EF8 @ =0x05000002
	mov r1, sp
	movs r0, 0
	strh r0, [r1]
	ldr r1, _08056EFC @ =0x040000d4
	mov r0, sp
	str r0, [r1]
	str r2, [r1, 0x4]
	ldr r0, _08056F00 @ =0x810001ff
	str r0, [r1, 0x8]
	ldr r0, [r1, 0x8]
	movs r2, 0xC0
	lsls r2, 19
	movs r3, 0xC0
	lsls r3, 9
	mov r4, sp
	movs r6, 0
	movs r5, 0x80
	lsls r5, 5
	ldr r7, _08056F04 @ =0x81000800
	movs r0, 0x81
	lsls r0, 24
	mov r12, r0
_08056EBE:
	strh r6, [r4]
	mov r0, sp
	str r0, [r1]
	str r2, [r1, 0x4]
	str r7, [r1, 0x8]
	ldr r0, [r1, 0x8]
	adds r2, r5
	subs r3, r5
	cmp r3, r5
	bhi _08056EBE
	strh r6, [r4]
	mov r0, sp
	str r0, [r1]
	str r2, [r1, 0x4]
	lsrs r0, r3, 1
	mov r2, r12
	orrs r0, r2
	str r0, [r1, 0x8]
	ldr r0, [r1, 0x8]
	movs r0, 0
	movs r1, 0x80
	bl ResetOamRange
	bl LoadOam
	add sp, 0x4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08056EF8: .4byte 0x05000002
_08056EFC: .4byte 0x040000d4
_08056F00: .4byte 0x810001ff
_08056F04: .4byte 0x81000800
	thumb_func_end sub_8056E80

	thumb_func_start sub_8056F08
sub_8056F08: @ 8056F08
	push {lr}
	bl InitCurrentFlashLevelScanlineEffect
	bl sub_8056F1C
	bl mapdata_load_assets_to_gpu_and_full_redraw
	pop {r0}
	bx r0
	thumb_func_end sub_8056F08

	thumb_func_start sub_8056F1C
sub_8056F1C: @ 8056F1C
	push {r4,lr}
	bl ClearScheduledBgCopiesToVram
	bl ResetTempTileDataBuffers
	movs r0, 0x4C
	movs r1, 0
	bl SetGpuReg
	ldr r1, _0805700C @ =0x00001f1f
	movs r0, 0x48
	bl SetGpuReg
	ldr r1, _08057010 @ =0x00000101
	movs r0, 0x4A
	bl SetGpuReg
	movs r0, 0x40
	movs r1, 0xFF
	bl SetGpuReg
	movs r0, 0x44
	movs r1, 0xFF
	bl SetGpuReg
	ldr r4, _08057014 @ =0x0000ffff
	movs r0, 0x42
	adds r1, r4, 0
	bl SetGpuReg
	movs r0, 0x46
	adds r1, r4, 0
	bl SetGpuReg
	ldr r0, _08057018 @ =gBLDCNTTarget2BGFlags
	ldrh r1, [r0, 0x2]
	ldrh r2, [r0, 0x4]
	orrs r1, r2
	ldrh r0, [r0, 0x6]
	orrs r1, r0
	movs r2, 0x82
	lsls r2, 5
	adds r0, r2, 0
	orrs r1, r0
	movs r0, 0x50
	bl SetGpuReg
	ldr r1, _0805701C @ =0x0000070d
	movs r0, 0x52
	bl SetGpuReg
	movs r0, 0x1
	bl ScheduleBgCopyTilemapToVram
	movs r0, 0x2
	bl ScheduleBgCopyTilemapToVram
	movs r0, 0x3
	bl ScheduleBgCopyTilemapToVram
	ldr r1, _08057020 @ =0x00007060
	movs r0, 0
	bl SetGpuReg
	movs r0, 0
	bl ShowBg
	movs r0, 0x1
	bl ShowBg
	movs r0, 0x2
	bl ShowBg
	movs r0, 0x3
	bl ShowBg
	movs r0, 0
	movs r1, 0
	movs r2, 0
	bl ChangeBgX
	movs r0, 0
	movs r1, 0
	movs r2, 0
	bl ChangeBgY
	movs r0, 0x1
	movs r1, 0
	movs r2, 0
	bl ChangeBgX
	movs r0, 0x1
	movs r1, 0
	movs r2, 0
	bl ChangeBgY
	movs r0, 0x2
	movs r1, 0
	movs r2, 0
	bl ChangeBgX
	movs r0, 0x2
	movs r1, 0
	movs r2, 0
	bl ChangeBgY
	movs r0, 0x3
	movs r1, 0
	movs r2, 0
	bl ChangeBgX
	movs r0, 0x3
	movs r1, 0
	movs r2, 0
	bl ChangeBgY
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0805700C: .4byte 0x00001f1f
_08057010: .4byte 0x00000101
_08057014: .4byte 0x0000ffff
_08057018: .4byte gBLDCNTTarget2BGFlags
_0805701C: .4byte 0x0000070d
_08057020: .4byte 0x00007060
	thumb_func_end sub_8056F1C

	thumb_func_start sub_8057024
sub_8057024: @ 8057024
	push {r4,lr}
	adds r4, r0, 0
	bl ResetTasks
	bl ResetSpriteData
	bl ResetPaletteFade
	bl ScanlineEffect_Clear
	bl ResetAllPicSprites
	bl ResetCameraUpdateInfo
	bl InstallCameraPanAheadCallback
	cmp r4, 0
	bne _08057050
	movs r0, 0
	bl InitObjectEventPalettes
	b _08057056
_08057050:
	movs r0, 0x1
	bl InitObjectEventPalettes
_08057056:
	bl FieldEffectActiveListClear
	bl StartWeather
	bl ResumePausedWeather
	cmp r4, 0
	bne _0805706A
	bl SetUpFieldTasks
_0805706A:
	bl mapheader_run_script_with_tag_x5
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_8057024

	thumb_func_start sub_8057074
sub_8057074: @ 8057074
	push {lr}
	ldr r0, _08057094 @ =gTotalCameraPixelOffsetX
	movs r1, 0
	strh r1, [r0]
	ldr r0, _08057098 @ =gTotalCameraPixelOffsetY
	strh r1, [r0]
	bl ResetObjectEvents
	movs r0, 0
	movs r1, 0
	bl TrySpawnObjectEvents
	bl mapheader_run_first_tag4_script_list_match
	pop {r0}
	bx r0
	.align 2, 0
_08057094: .4byte gTotalCameraPixelOffsetX
_08057098: .4byte gTotalCameraPixelOffsetY
	thumb_func_end sub_8057074

	thumb_func_start mli4_mapscripts_and_other
mli4_mapscripts_and_other: @ 805709C
	push {r4,r5,lr}
	sub sp, 0x4
	ldr r0, _080570F4 @ =gTotalCameraPixelOffsetX
	movs r1, 0
	strh r1, [r0]
	ldr r0, _080570F8 @ =gTotalCameraPixelOffsetY
	strh r1, [r0]
	bl ResetObjectEvents
	mov r4, sp
	adds r4, 0x2
	mov r0, sp
	adds r1, r4, 0
	bl GetCameraFocusCoords
	bl GetInitialPlayerAvatarState
	adds r5, r0, 0
	mov r0, sp
	movs r1, 0
	ldrsh r0, [r0, r1]
	movs r2, 0
	ldrsh r1, [r4, r2]
	ldrb r2, [r5, 0x1]
	ldr r3, _080570FC @ =gSaveBlock2Ptr
	ldr r3, [r3]
	ldrb r3, [r3, 0x8]
	bl InitPlayerAvatar
	ldrb r0, [r5]
	bl SetPlayerAvatarTransitionFlags
	bl ResetInitialPlayerAvatarState
	movs r0, 0
	movs r1, 0
	bl TrySpawnObjectEvents
	bl mapheader_run_first_tag4_script_list_match
	add sp, 0x4
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080570F4: .4byte gTotalCameraPixelOffsetX
_080570F8: .4byte gTotalCameraPixelOffsetY
_080570FC: .4byte gSaveBlock2Ptr
	thumb_func_end mli4_mapscripts_and_other

	thumb_func_start sub_8057100
sub_8057100: @ 8057100
	push {lr}
	movs r0, 0
	movs r1, 0
	bl sub_805EDF0
	bl mapheader_run_script_with_tag_x7
	pop {r0}
	bx r0
	thumb_func_end sub_8057100

	thumb_func_start sub_8057114
sub_8057114: @ 8057114
	push {lr}
	ldr r2, _08057138 @ =gObjectEvents
	ldr r3, _0805713C @ =gPlayerAvatar
	ldrb r1, [r3, 0x5]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0, 0x1]
	movs r2, 0x80
	orrs r1, r2
	strb r1, [r0, 0x1]
	ldrb r0, [r3, 0x4]
	bl InitCameraUpdateCallback
	pop {r0}
	bx r0
	.align 2, 0
_08057138: .4byte gObjectEvents
_0805713C: .4byte gPlayerAvatar
	thumb_func_end sub_8057114

	thumb_func_start sub_8057140
sub_8057140: @ 8057140
	push {lr}
	ldr r0, _08057158 @ =gLocalLinkPlayerId
	ldrb r0, [r0]
	bl sub_8058504
	lsls r0, 24
	lsrs r0, 24
	bl InitCameraUpdateCallback
	pop {r0}
	bx r0
	.align 2, 0
_08057158: .4byte gLocalLinkPlayerId
	thumb_func_end sub_8057140

	thumb_func_start sub_805715C
sub_805715C: @ 805715C
	push {lr}
	ldr r0, _08057174 @ =gLocalLinkPlayerId
	ldrb r0, [r0]
	bl sub_8058504
	lsls r0, 24
	lsrs r0, 24
	bl InitCameraUpdateCallback
	pop {r0}
	bx r0
	.align 2, 0
_08057174: .4byte gLocalLinkPlayerId
	thumb_func_end sub_805715C

	thumb_func_start sub_8057178
sub_8057178: @ 8057178
	push {r4,lr}
	sub sp, 0x4
	mov r4, sp
	adds r4, 0x2
	mov r0, sp
	adds r1, r4, 0
	bl GetCameraFocusCoords
	mov r2, sp
	ldr r0, _080571A4 @ =gLocalLinkPlayerId
	ldrb r1, [r0]
	ldrh r0, [r2]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	ldrh r1, [r4]
	bl SetCameraFocusCoords
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080571A4: .4byte gLocalLinkPlayerId
	thumb_func_end sub_8057178

	thumb_func_start sub_80571A8
sub_80571A8: @ 80571A8
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	sub sp, 0x4
	mov r4, sp
	adds r4, 0x2
	mov r0, sp
	adds r1, r4, 0
	bl GetCameraFocusCoords
	mov r3, sp
	mov r2, sp
	ldr r0, _08057224 @ =gLocalLinkPlayerId
	ldrb r1, [r0]
	ldrh r0, [r2]
	subs r0, r1
	strh r0, [r3]
	movs r6, 0
	ldr r0, _08057228 @ =gFieldLinkPlayerCount
	mov r8, r4
	ldrb r0, [r0]
	cmp r6, r0
	bcs _08057212
	ldr r7, _0805722C @ =gLinkPlayers
_080571D8:
	lsls r5, r6, 24
	lsrs r5, 24
	mov r0, sp
	ldrh r1, [r0]
	adds r1, r6, r1
	lsls r1, 16
	asrs r1, 16
	mov r0, r8
	movs r3, 0
	ldrsh r2, [r0, r3]
	lsls r4, r6, 3
	subs r4, r6
	lsls r4, 2
	adds r4, r7
	ldrb r3, [r4, 0x13]
	adds r0, r5, 0
	bl SpawnLinkPlayerObjectEvent
	ldrb r1, [r4]
	adds r0, r5, 0
	bl sub_8058878
	adds r0, r6, 0x1
	lsls r0, 16
	lsrs r6, r0, 16
	ldr r0, _08057228 @ =gFieldLinkPlayerCount
	ldrb r0, [r0]
	cmp r6, r0
	bcc _080571D8
_08057212:
	bl sub_80578EC
	add sp, 0x4
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08057224: .4byte gLocalLinkPlayerId
_08057228: .4byte gFieldLinkPlayerCount
_0805722C: .4byte gLinkPlayers
	thumb_func_end sub_80571A8

	thumb_func_start sub_8057230
sub_8057230: @ 8057230
	push {r4,r5,lr}
	movs r4, 0
	ldr r0, _08057264 @ =gFieldLinkPlayerCount
	ldrb r0, [r0]
	cmp r4, r0
	bcs _0805725E
	ldr r5, _08057268 @ =gLinkPlayers
_0805723E:
	lsls r0, r4, 24
	lsrs r0, 24
	lsls r1, r4, 3
	subs r1, r4
	lsls r1, 2
	adds r1, r5
	ldrb r1, [r1]
	bl sub_8058878
	adds r0, r4, 0x1
	lsls r0, 16
	lsrs r4, r0, 16
	ldr r0, _08057264 @ =gFieldLinkPlayerCount
	ldrb r0, [r0]
	cmp r4, r0
	bcc _0805723E
_0805725E:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08057264: .4byte gFieldLinkPlayerCount
_08057268: .4byte gLinkPlayers
	thumb_func_end sub_8057230

	thumb_func_start sub_805726C
sub_805726C: @ 805726C
	push {lr}
	bl FieldClearVBlankHBlankCallbacks
	ldr r1, _08057298 @ =gUnknown_2036E28
	movs r0, 0x1
	strb r0, [r1]
	bl ScriptContext1_Init
	bl ScriptContext2_Disable
	movs r0, 0
	bl SetMainCallback1
	ldr r0, _0805729C @ =CB2_DoChangeMap
	bl SetMainCallback2
	ldr r1, _080572A0 @ =gMain
	ldr r0, _080572A4 @ =sub_80572D8
	str r0, [r1, 0x8]
	pop {r0}
	bx r0
	.align 2, 0
_08057298: .4byte gUnknown_2036E28
_0805729C: .4byte CB2_DoChangeMap
_080572A0: .4byte gMain
_080572A4: .4byte sub_80572D8
	thumb_func_end sub_805726C

	thumb_func_start sub_80572A8
sub_80572A8: @ 80572A8
	push {lr}
	bl FieldClearVBlankHBlankCallbacks
	ldr r0, _080572D0 @ =gUnknown_2036E28
	movs r1, 0x1
	strb r1, [r0]
	bl LoadSaveblockMapHeader
	bl ScriptContext1_Init
	bl ScriptContext2_Disable
	movs r0, 0
	bl SetMainCallback1
	ldr r0, _080572D4 @ =sub_80572D8
	bl SetMainCallback2
	pop {r0}
	bx r0
	.align 2, 0
_080572D0: .4byte gUnknown_2036E28
_080572D4: .4byte sub_80572D8
	thumb_func_end sub_80572A8

	thumb_func_start sub_80572D8
sub_80572D8: @ 80572D8
	push {lr}
	ldr r0, _080572F4 @ =gMain + 0x438
	bl sub_8057300
	bl SetFieldVBlankCallback
	ldr r0, _080572F8 @ =CB1_Overworld
	bl SetMainCallback1
	ldr r0, _080572FC @ =CB2_Overworld
	bl SetMainCallback2
	pop {r0}
	bx r0
	.align 2, 0
_080572F4: .4byte gMain + 0x438
_080572F8: .4byte CB1_Overworld
_080572FC: .4byte CB2_Overworld
	thumb_func_end sub_80572D8

	thumb_func_start sub_8057300
sub_8057300: @ 8057300
	push {r4,lr}
	adds r4, r0, 0
_08057304:
	adds r0, r4, 0
	bl sub_8057314
	cmp r0, 0
	beq _08057304
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_8057300

	thumb_func_start sub_8057314
sub_8057314: @ 8057314
	push {r4,lr}
	adds r4, r0, 0
	ldrb r0, [r4]
	cmp r0, 0xA
	bls _08057320
	b _0805741A
_08057320:
	lsls r0, 2
	ldr r1, _0805732C @ =_08057330
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_0805732C: .4byte _08057330
	.align 2, 0
_08057330:
	.4byte _0805735C
	.4byte _080573A0
	.4byte _080573A6
	.4byte _080573AE
	.4byte _080573B8
	.4byte _080573C2
	.4byte _080573C8
	.4byte _080573D8
	.4byte _080573E8
	.4byte _08057404
	.4byte _0805740A
_0805735C:
	bl InitOverworldBgs
	bl FieldClearVBlankHBlankCallbacks
	bl sub_8111F14
	bl sub_81113E4
	bl sub_8111438
	bl sub_8110AC8
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x2
	bne _08057390
	ldr r1, _0805738C @ =gUnknown_2031DE0
	movs r0, 0
	strb r0, [r1]
	movs r0, 0
	bl mli0_load_map
	b _08057412
	.align 2, 0
_0805738C: .4byte gUnknown_2031DE0
_08057390:
	ldr r1, _0805739C @ =gUnknown_2031DE0
	movs r0, 0x1
	strb r0, [r1]
	bl sub_80559A8
	b _08057412
	.align 2, 0
_0805739C: .4byte gUnknown_2031DE0
_080573A0:
	bl sub_8110FCC
	b _08057412
_080573A6:
	movs r0, 0
	bl sub_8057024
	b _08057412
_080573AE:
	bl sub_8057100
	bl sub_8057114
	b _08057412
_080573B8:
	bl InitCurrentFlashLevelScanlineEffect
	bl sub_8056F1C
	b _08057412
_080573C2:
	bl move_tilemap_camera_to_upper_left_corner
	b _08057412
_080573C8:
	ldr r0, _080573D4 @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset1_to_vram
	b _08057412
	.align 2, 0
_080573D4: .4byte gMapHeader
_080573D8:
	ldr r0, _080573E4 @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset2_to_vram
	b _08057412
	.align 2, 0
_080573E4: .4byte gMapHeader
_080573E8:
	bl FreeTempTileDataBuffersIfPossible
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08057428
	ldr r0, _08057400 @ =gMapHeader
	ldr r0, [r0]
	bl apply_map_tileset1_tileset2_palette
	b _08057412
	.align 2, 0
_08057400: .4byte gMapHeader
_08057404:
	bl DrawWholeMapView
	b _08057412
_0805740A:
	bl InitTilesetAnimations
	bl sub_815A540
_08057412:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	b _08057428
_0805741A:
	bl map_post_load_hook_exec
	lsls r0, 24
	cmp r0, 0
	beq _08057428
	movs r0, 0x1
	b _0805742A
_08057428:
	movs r0, 0
_0805742A:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8057314

	thumb_func_start sub_8057430
sub_8057430: @ 8057430
	push {lr}
	bl FieldClearVBlankHBlankCallbacks
	bl StopMapMusic
	ldr r1, _08057484 @ =gUnknown_2036E28
	movs r0, 0x3
	strb r0, [r1]
	bl ResetSafariZoneFlag_
	bl LoadSaveblockMapHeader
	bl sub_80550A8
	bl UnfreezeObjectEvents
	bl sub_8054E40
	bl InitMapFromSavedGame
	bl PlayTimeCounter_Start
	bl ScriptContext1_Init
	ldr r1, _08057488 @ =gUnknown_2031DE0
	movs r0, 0x1
	strb r0, [r1]
	bl sav2_x1_query_bit1
	cmp r0, 0x1
	bne _08057490
	bl sav2_x9_clear_bit1
	bl SetWarpDestinationToContinueGameWarp
	bl WarpIntoMap
	ldr r0, _0805748C @ =CB2_LoadMap
	bl SetMainCallback2
	b _0805749A
	.align 2, 0
_08057484: .4byte gUnknown_2036E28
_08057488: .4byte gUnknown_2031DE0
_0805748C: .4byte CB2_LoadMap
_08057490:
	ldr r0, _080574A0 @ =CB1_Overworld
	bl SetMainCallback1
	bl CB2_ReturnToField
_0805749A:
	pop {r0}
	bx r0
	.align 2, 0
_080574A0: .4byte CB1_Overworld
	thumb_func_end sub_8057430

	thumb_func_start Overworld_CreditsMainCB
Overworld_CreditsMainCB: @ 80574A4
	push {r4,lr}
	ldr r0, _080574E8 @ =gPaletteFade
	ldrb r0, [r0, 0x7]
	lsrs r0, 7
	adds r4, r0, 0
	cmp r4, 0
	beq _080574B8
	movs r0, 0
	bl SetVBlankCallback
_080574B8:
	bl RunTasks
	bl AnimateSprites
	bl sub_805ACF0
	bl UpdateCameraPanning
	bl BuildOamBuffer
	bl UpdatePaletteFade
	bl UpdateTilesetAnimations
	bl DoScheduledBgTilemapCopiesToVram
	cmp r4, 0
	beq _080574E0
	bl SetFieldVBlankCallback
_080574E0:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080574E8: .4byte gPaletteFade
	thumb_func_end Overworld_CreditsMainCB

	thumb_func_start sub_80574EC
sub_80574EC: @ 80574EC
	push {lr}
	ldr r0, _08057500 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08057504
	movs r0, 0
	b _08057506
	.align 2, 0
_08057500: .4byte gPaletteFade
_08057504:
	movs r0, 0x1
_08057506:
	pop {r1}
	bx r1
	thumb_func_end sub_80574EC

	thumb_func_start Overworld_DoScrollSceneForCredits
Overworld_DoScrollSceneForCredits: @ 805750C
	push {lr}
	ldr r3, _08057520 @ =gUnknown_2031DE4
	str r1, [r3]
	ldr r1, _08057524 @ =gUnknown_2036E28
	strb r2, [r1]
	movs r1, 0
	bl sub_8057528
	pop {r1}
	bx r1
	.align 2, 0
_08057520: .4byte gUnknown_2031DE4
_08057524: .4byte gUnknown_2036E28
	thumb_func_end Overworld_DoScrollSceneForCredits

	thumb_func_start sub_8057528
sub_8057528: @ 8057528
	push {r4-r7,lr}
	adds r7, r0, 0
	ldrb r1, [r7]
	cmp r1, 0x1
	beq _08057560
	cmp r1, 0x1
	bgt _0805753C
	cmp r1, 0
	beq _08057546
	b _08057648
_0805753C:
	cmp r1, 0x2
	beq _08057620
	cmp r1, 0x3
	beq _0805762C
	b _08057648
_08057546:
	ldr r0, _08057558 @ =gUnknown_2031DEA
	strh r1, [r0]
	ldr r0, _0805755C @ =gUnknown_2031DE8
	strh r1, [r0]
_0805754E:
	ldrb r0, [r7]
	adds r0, 0x1
	strb r0, [r7]
	b _08057648
	.align 2, 0
_08057558: .4byte gUnknown_2031DEA
_0805755C: .4byte gUnknown_2031DE8
_08057560:
	ldr r3, _080575F0 @ =gUnknown_2031DEA
	movs r0, 0
	ldrsh r1, [r3, r0]
	ldr r0, _080575F4 @ =gUnknown_2031DE4
	ldr r4, [r0]
	lsls r1, 3
	adds r1, r4
	ldrb r2, [r1, 0x2]
	ldr r0, _080575F8 @ =0xffffff00
	ands r0, r5
	orrs r0, r2
	ldrb r1, [r1, 0x4]
	lsls r1, 8
	ldr r2, _080575FC @ =0xffff00ff
	ands r0, r2
	adds r5, r0, 0
	orrs r5, r1
	movs r0, 0xFF
	lsls r0, 16
	orrs r5, r0
	ldrh r0, [r3]
	adds r0, 0x1
	strh r0, [r3]
	movs r2, 0
	ldrsh r1, [r3, r2]
	lsls r1, 3
	adds r1, r4
	ldrh r2, [r1]
	ldr r0, _08057600 @ =0xffff0000
	ands r0, r6
	orrs r0, r2
	ldrh r1, [r1, 0x2]
	lsls r1, 16
	ldr r2, _08057604 @ =0x0000ffff
	ands r0, r2
	adds r6, r0, 0
	orrs r6, r1
	ldr r0, _08057608 @ =sWarpDestination
	str r5, [r0]
	str r6, [r0, 0x4]
	ldr r1, _0805760C @ =gUnknown_2031DE8
	movs r2, 0
	ldrsh r0, [r3, r2]
	lsls r0, 3
	adds r0, r4
	ldrh r0, [r0, 0x4]
	strh r0, [r1]
	bl WarpIntoMap
	ldr r2, _08057610 @ =gPaletteFade
	ldrb r0, [r2, 0x8]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r2, 0x8]
	bl ScriptContext1_Init
	bl ScriptContext2_Disable
	movs r0, 0
	bl SetMainCallback1
	ldr r1, _08057614 @ =gFieldCallback2
	ldr r0, _08057618 @ =sub_80574EC
	str r0, [r1]
	ldr r0, _0805761C @ =gMain
	movs r1, 0x87
	lsls r1, 3
	adds r0, r1
	movs r1, 0
	strb r1, [r0]
	b _0805754E
	.align 2, 0
_080575F0: .4byte gUnknown_2031DEA
_080575F4: .4byte gUnknown_2031DE4
_080575F8: .4byte 0xffffff00
_080575FC: .4byte 0xffff00ff
_08057600: .4byte 0xffff0000
_08057604: .4byte 0x0000ffff
_08057608: .4byte sWarpDestination
_0805760C: .4byte gUnknown_2031DE8
_08057610: .4byte gPaletteFade
_08057614: .4byte gFieldCallback2
_08057618: .4byte sub_80574EC
_0805761C: .4byte gMain
_08057620:
	bl sub_8057650
	lsls r0, 24
	cmp r0, 0
	beq _08057648
	b _0805754E
_0805762C:
	ldr r0, _08057640 @ =gFieldCamera
	ldr r1, _08057644 @ =sub_8057748
	str r1, [r0]
	bl SetFieldVBlankCallback
	movs r0, 0
	strb r0, [r7]
	movs r0, 0x1
	b _0805764A
	.align 2, 0
_08057640: .4byte gFieldCamera
_08057644: .4byte sub_8057748
_08057648:
	movs r0, 0
_0805764A:
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end sub_8057528

	thumb_func_start sub_8057650
sub_8057650: @ 8057650
	push {r4,lr}
	ldr r4, _08057664 @ =gMain + 0x438
	ldrb r0, [r4]
	cmp r0, 0x8
	bhi _0805773C
	lsls r0, 2
	ldr r1, _08057668 @ =_0805766C
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08057664: .4byte gMain + 0x438
_08057668: .4byte _0805766C
	.align 2, 0
_0805766C:
	.4byte _08057690
	.4byte _0805769C
	.4byte _080576C2
	.4byte _080576CC
	.4byte _080576D2
	.4byte _080576E0
	.4byte _080576F0
	.4byte _0805770C
	.4byte _08057712
_08057690:
	bl InitOverworldBgs_NoResetHeap
	movs r0, 0
	bl mli0_load_map
	b _0805772A
_0805769C:
	bl ScanlineEffect_Clear
	bl ResetAllPicSprites
	bl ResetCameraUpdateInfo
	bl InstallCameraPanAheadCallback
	bl FieldEffectActiveListClear
	bl StartWeather
	bl ResumePausedWeather
	bl SetUpFieldTasks
	bl mapheader_run_script_with_tag_x5
	b _0805772A
_080576C2:
	bl InitCurrentFlashLevelScanlineEffect
	bl sub_8056F1C
	b _0805772A
_080576CC:
	bl move_tilemap_camera_to_upper_left_corner
	b _0805772A
_080576D2:
	ldr r0, _080576DC @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset1_to_vram
	b _0805772A
	.align 2, 0
_080576DC: .4byte gMapHeader
_080576E0:
	ldr r0, _080576EC @ =gMapHeader
	ldr r0, [r0]
	bl copy_map_tileset2_to_vram
	b _0805772A
	.align 2, 0
_080576EC: .4byte gMapHeader
_080576F0:
	bl FreeTempTileDataBuffersIfPossible
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08057740
	ldr r0, _08057708 @ =gMapHeader
	ldr r0, [r0]
	bl apply_map_tileset1_tileset2_palette
	b _0805772A
	.align 2, 0
_08057708: .4byte gMapHeader
_0805770C:
	bl DrawWholeMapView
	b _0805772A
_08057712:
	bl InitTilesetAnimations
	ldr r2, _08057734 @ =gPaletteFade
	ldrb r1, [r2, 0x8]
	movs r0, 0x7F
	ands r0, r1
	strb r0, [r2, 0x8]
	ldr r2, _08057738 @ =0x3fffffff
	movs r0, 0
	movs r1, 0
	bl FadeSelectedPals
_0805772A:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	b _08057740
	.align 2, 0
_08057734: .4byte gPaletteFade
_08057738: .4byte 0x3fffffff
_0805773C:
	movs r0, 0x1
	b _08057742
_08057740:
	movs r0, 0
_08057742:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8057650

	thumb_func_start sub_8057748
sub_8057748: @ 8057748
	push {r4-r6,lr}
	adds r2, r0, 0
	ldr r0, _08057784 @ =gUnknown_2031DE8
	movs r3, 0
	ldrsh r1, [r0, r3]
	adds r5, r0, 0
	ldr r4, _08057788 @ =gUnknown_2031DEA
	ldr r6, _0805778C @ =gUnknown_2031DE4
	cmp r1, 0
	bne _080577F4
	ldrh r0, [r4]
	adds r0, 0x1
	strh r0, [r4]
	movs r1, 0
	ldrsh r0, [r4, r1]
	ldr r1, [r6]
	lsls r0, 3
	adds r3, r0, r1
	ldrh r0, [r3]
	subs r0, 0xFB
	lsls r0, 16
	asrs r0, 16
	cmp r0, 0x4
	bhi _080577D4
	lsls r0, 2
	ldr r1, _08057790 @ =_08057794
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08057784: .4byte gUnknown_2031DE8
_08057788: .4byte gUnknown_2031DEA
_0805778C: .4byte gUnknown_2031DE4
_08057790: .4byte _08057794
	.align 2, 0
_08057794:
	.4byte _080577C0
	.4byte _08057814
	.4byte _080577CA
	.4byte _08057814
	.4byte _080577A8
_080577A8:
	movs r0, 0
	str r0, [r2, 0x8]
	str r0, [r2, 0xC]
	str r0, [r2]
	ldr r0, _080577BC @ =sub_805781C
	movs r1, 0
	bl CreateTask
	b _08057814
	.align 2, 0
_080577BC: .4byte sub_805781C
_080577C0:
	movs r0, 0
	str r0, [r2, 0x8]
	str r0, [r2, 0xC]
	str r0, [r2]
	b _080577F4
_080577CA:
	movs r0, 0
	str r0, [r2, 0x8]
	str r0, [r2, 0xC]
	str r0, [r2]
	b _08057814
_080577D4:
	ldrh r0, [r3, 0x4]
	strh r0, [r5]
	movs r3, 0
	ldrsh r0, [r4, r3]
	lsls r0, 3
	adds r0, r1
	movs r3, 0
	ldrsh r0, [r0, r3]
	str r0, [r2, 0x8]
	movs r3, 0
	ldrsh r0, [r4, r3]
	lsls r0, 3
	adds r0, r1
	movs r1, 0x2
	ldrsh r0, [r0, r1]
	str r0, [r2, 0xC]
_080577F4:
	movs r3, 0
	ldrsh r0, [r4, r3]
	ldr r1, [r6]
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	ldrsh r0, [r0, r1]
	cmp r0, 0xFF
	bne _0805780E
	movs r0, 0
	str r0, [r2, 0x8]
	str r0, [r2, 0xC]
	b _08057814
_0805780E:
	ldrh r0, [r5]
	subs r0, 0x1
	strh r0, [r5]
_08057814:
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end sub_8057748

	thumb_func_start sub_805781C
sub_805781C: @ 805781C
	push {r4,lr}
	sub sp, 0x4
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x1
	negs r0, r0
	movs r1, 0
	str r1, [sp]
	movs r2, 0
	movs r3, 0x10
	bl BeginNormalPaletteFade
	ldr r1, _0805784C @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _08057850 @ =sub_8057854
	str r1, [r0]
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0805784C: .4byte gTasks
_08057850: .4byte sub_8057854
	thumb_func_end sub_805781C

	thumb_func_start sub_8057854
sub_8057854: @ 8057854
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0805787C @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08057876
	bl CleanupOverworldWindowsAndTilemaps
	ldr r0, _08057880 @ =CB2_LoadMap
	bl SetMainCallback2
	adds r0, r4, 0
	bl DestroyTask
_08057876:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0805787C: .4byte gPaletteFade
_08057880: .4byte CB2_LoadMap
	thumb_func_end sub_8057854

	thumb_func_start CB1_UpdateLinkState
CB1_UpdateLinkState: @ 8057884
	push {r4,lr}
	ldr r0, _080578C8 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	beq _0805789E
	bl IsRfuRecvQueueEmpty
	cmp r0, 0
	beq _0805789E
	bl IsSendingKeysToLink
	cmp r0, 0
	bne _080578C0
_0805789E:
	ldr r0, _080578CC @ =gLocalLinkPlayerId
	ldrb r4, [r0]
	ldr r0, _080578D0 @ =gLinkPartnersHeldKeys
	adds r1, r4, 0
	bl sub_8057BE4
	ldr r0, _080578D4 @ =gUnknown_3000E84
	ldr r1, [r0]
	adds r0, r4, 0
	bl _call_via_r1
	lsls r0, 16
	lsrs r0, 16
	bl sub_8057C4C
	bl sub_80578EC
_080578C0:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080578C8: .4byte gWirelessCommType
_080578CC: .4byte gLocalLinkPlayerId
_080578D0: .4byte gLinkPartnersHeldKeys
_080578D4: .4byte gUnknown_3000E84
	thumb_func_end CB1_UpdateLinkState

	thumb_func_start ResetAllMultiplayerState
ResetAllMultiplayerState: @ 80578D8
	push {lr}
	bl sub_805793C
	ldr r0, _080578E8 @ =sub_8057D5C
	bl c1_link_related_func_set
	pop {r0}
	bx r0
	.align 2, 0
_080578E8: .4byte sub_8057D5C
	thumb_func_end ResetAllMultiplayerState

	thumb_func_start sub_80578EC
sub_80578EC: @ 80578EC
	push {lr}
	ldr r0, _080578F8 @ =gLinkPartnersHeldKeys
	bl sub_8057D48
	pop {r0}
	bx r0
	.align 2, 0
_080578F8: .4byte gLinkPartnersHeldKeys
	thumb_func_end sub_80578EC

	thumb_func_start c1_link_related_func_set
c1_link_related_func_set: @ 80578FC
	ldr r2, _08057908 @ =gUnknown_3000E89
	movs r1, 0
	strb r1, [r2]
	ldr r1, _0805790C @ =gUnknown_3000E84
	str r0, [r1]
	bx lr
	.align 2, 0
_08057908: .4byte gUnknown_3000E89
_0805790C: .4byte gUnknown_3000E84
	thumb_func_end c1_link_related_func_set

	thumb_func_start sub_8057910
sub_8057910: @ 8057910
	push {lr}
	ldr r0, _08057934 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	beq _0805792E
	ldr r1, _08057938 @ =gUnknown_3000E89
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x3C
	bls _0805792E
	bl LinkRfu_FatalError
_0805792E:
	pop {r0}
	bx r0
	.align 2, 0
_08057934: .4byte gWirelessCommType
_08057938: .4byte gUnknown_3000E89
	thumb_func_end sub_8057910

	thumb_func_start sub_805793C
sub_805793C: @ 805793C
	push {lr}
	ldr r1, _08057950 @ =gUnknown_3000E80
	movs r2, 0x80
	adds r0, r1, 0x3
_08057944:
	strb r2, [r0]
	subs r0, 0x1
	cmp r0, r1
	bge _08057944
	pop {r0}
	bx r0
	.align 2, 0
_08057950: .4byte gUnknown_3000E80
	thumb_func_end sub_805793C

	thumb_func_start sub_8057954
sub_8057954: @ 8057954
	push {r4,lr}
	lsls r0, 16
	lsrs r3, r0, 16
	ldr r0, _08057974 @ =gFieldLinkPlayerCount
	ldrb r2, [r0]
	movs r1, 0
	cmp r1, r2
	bge _08057982
	ldr r4, _08057978 @ =gUnknown_3000E80
_08057966:
	adds r0, r1, r4
	ldrb r0, [r0]
	cmp r0, r3
	beq _0805797C
	movs r0, 0
	b _08057984
	.align 2, 0
_08057974: .4byte gFieldLinkPlayerCount
_08057978: .4byte gUnknown_3000E80
_0805797C:
	adds r1, 0x1
	cmp r1, r2
	blt _08057966
_08057982:
	movs r0, 0x1
_08057984:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8057954

	thumb_func_start sub_805798C
sub_805798C: @ 805798C
	push {r4,lr}
	lsls r0, 16
	lsrs r3, r0, 16
	ldr r0, _080579AC @ =gFieldLinkPlayerCount
	ldrb r2, [r0]
	movs r1, 0
	cmp r1, r2
	bge _080579BA
	ldr r4, _080579B0 @ =gUnknown_3000E80
_0805799E:
	adds r0, r1, r4
	ldrb r0, [r0]
	cmp r0, r3
	bne _080579B4
	movs r0, 0x1
	b _080579BC
	.align 2, 0
_080579AC: .4byte gFieldLinkPlayerCount
_080579B0: .4byte gUnknown_3000E80
_080579B4:
	adds r1, 0x1
	cmp r1, r2
	blt _0805799E
_080579BA:
	movs r0, 0
_080579BC:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_805798C

	thumb_func_start sub_80579C4
sub_80579C4: @ 80579C4
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	adds r7, r0, 0
	adds r6, r2, 0
	mov r9, r3
	lsls r1, 16
	lsrs r1, 16
	mov r8, r1
	ldr r0, _08057A14 @ =gUnknown_3000E80
	adds r5, r7, r0
	ldrb r0, [r5]
	cmp r0, 0x80
	beq _080579E4
	b _08057B5E
_080579E4:
	adds r0, r6, 0
	bl sub_805801C
	adds r4, r0, 0
	cmp r4, 0
	beq _08057A1C
	bl sub_805812C
	mov r1, r9
	strh r0, [r1]
	movs r0, 0x81
	strb r0, [r5]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	bne _08057A04
	b _08057BD2
_08057A04:
	ldr r0, _08057A18 @ =sub_8057DA4
	bl c1_link_related_func_set
	adds r0, r4, 0
	bl sub_80581DC
	b _08057BD2
	.align 2, 0
_08057A14: .4byte gUnknown_3000E80
_08057A18: .4byte sub_8057DA4
_08057A1C:
	movs r0, 0x83
	bl sub_805798C
	cmp r0, 0x1
	bne _08057A44
	movs r0, 0x81
	strb r0, [r5]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	bne _08057A32
	b _08057BD2
_08057A32:
	ldr r0, _08057A40 @ =sub_8057DA4
	bl c1_link_related_func_set
	bl sub_8058230
	b _08057BD2
	.align 2, 0
_08057A40: .4byte sub_8057DA4
_08057A44:
	mov r0, r8
	subs r0, 0x12
	cmp r0, 0xA
	bls _08057A4E
	b _08057B5E
_08057A4E:
	lsls r0, 2
	ldr r1, _08057A58 @ =_08057A5C
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08057A58: .4byte _08057A5C
	.align 2, 0
_08057A5C:
	.4byte _08057AB4
	.4byte _08057B5E
	.4byte _08057B5E
	.4byte _08057B5E
	.4byte _08057B5E
	.4byte _08057B5E
	.4byte _08057A88
	.4byte _08057AE0
	.4byte _08057B5E
	.4byte _08057B10
	.4byte _08057B3C
_08057A88:
	adds r0, r6, 0
	bl sub_8058004
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057AAC @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x81
	strb r1, [r0]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057AB0 @ =sub_8057DA4
	bl c1_link_related_func_set
	bl sub_80581C8
	b _08057B5E
	.align 2, 0
_08057AAC: .4byte gUnknown_3000E80
_08057AB0: .4byte sub_8057DA4
_08057AB4:
	adds r0, r6, 0
	bl sub_8058034
	cmp r0, 0x1
	bne _08057B5E
	ldr r0, _08057AD8 @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x81
	strb r1, [r0]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057ADC @ =sub_8057DA4
	bl c1_link_related_func_set
	bl sub_80581F8
	b _08057B5E
	.align 2, 0
_08057AD8: .4byte gUnknown_3000E80
_08057ADC: .4byte sub_8057DA4
_08057AE0:
	adds r0, r6, 0
	bl sub_8058060
	adds r4, r0, 0
	cmp r4, 0
	beq _08057B5E
	ldr r0, _08057B08 @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x81
	strb r1, [r0]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057B0C @ =sub_8057DA4
	bl c1_link_related_func_set
	adds r0, r4, 0
	bl sub_8058214
	b _08057B5E
	.align 2, 0
_08057B08: .4byte gUnknown_3000E80
_08057B0C: .4byte sub_8057DA4
_08057B10:
	adds r0, r6, 0
	bl sub_8057FEC
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057B34 @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x81
	strb r1, [r0]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057B38 @ =sub_8057DC8
	bl c1_link_related_func_set
	bl sub_80581BC
	b _08057B5E
	.align 2, 0
_08057B34: .4byte gUnknown_3000E80
_08057B38: .4byte sub_8057DC8
_08057B3C:
	adds r0, r6, 0
	bl sub_8057FEC
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057B70 @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x81
	strb r1, [r0]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	beq _08057B5E
	ldr r0, _08057B74 @ =sub_8057DEC
	bl c1_link_related_func_set
	bl sub_80581BC
_08057B5E:
	mov r0, r8
	cmp r0, 0x17
	beq _08057B84
	cmp r0, 0x17
	bgt _08057B78
	cmp r0, 0x16
	beq _08057B94
	b _08057BD2
	.align 2, 0
_08057B70: .4byte gUnknown_3000E80
_08057B74: .4byte sub_8057DEC
_08057B78:
	mov r1, r8
	cmp r1, 0x1A
	beq _08057BA4
	cmp r1, 0x1D
	beq _08057BC4
	b _08057BD2
_08057B84:
	ldr r0, _08057B90 @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x83
	strb r1, [r0]
	b _08057BD2
	.align 2, 0
_08057B90: .4byte gUnknown_3000E80
_08057B94:
	ldr r0, _08057BA0 @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x82
	strb r1, [r0]
	b _08057BD2
	.align 2, 0
_08057BA0: .4byte gUnknown_3000E80
_08057BA4:
	ldr r0, _08057BBC @ =gUnknown_3000E80
	adds r0, r7, r0
	movs r1, 0x80
	strb r1, [r0]
	ldrb r0, [r6, 0x1]
	cmp r0, 0
	beq _08057BD2
	ldr r0, _08057BC0 @ =sub_8057D5C
	bl c1_link_related_func_set
	b _08057BD2
	.align 2, 0
_08057BBC: .4byte gUnknown_3000E80
_08057BC0: .4byte sub_8057D5C
_08057BC4:
	ldr r0, _08057BE0 @ =gUnknown_3000E80
	adds r1, r7, r0
	ldrb r0, [r1]
	cmp r0, 0x82
	bne _08057BD2
	movs r0, 0x81
	strb r0, [r1]
_08057BD2:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08057BE0: .4byte gUnknown_3000E80
	thumb_func_end sub_80579C4

	thumb_func_start sub_8057BE4
sub_8057BE4: @ 8057BE4
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	sub sp, 0x14
	mov r8, r1
	movs r6, 0
	add r5, sp, 0x10
	mov r9, r5
	adds r7, r0, 0
_08057BF8:
	ldrb r4, [r7]
	movs r0, 0
	strh r0, [r5]
	adds r0, r6, 0
	mov r1, r8
	mov r2, sp
	bl sub_8057F84
	adds r0, r6, 0
	adds r1, r4, 0
	mov r2, sp
	adds r3, r5, 0
	bl sub_80579C4
	ldr r0, _08057C48 @ =gUnknown_3000E80
	adds r0, r6, r0
	ldrb r0, [r0]
	cmp r0, 0x80
	bne _08057C28
	adds r0, r4, 0
	bl sub_8057D14
	mov r1, r9
	strh r0, [r1]
_08057C28:
	lsls r0, r6, 24
	lsrs r0, 24
	ldrb r1, [r5]
	bl sub_8058618
	adds r7, 0x2
	adds r6, 0x1
	cmp r6, 0x3
	ble _08057BF8
	add sp, 0x14
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08057C48: .4byte gUnknown_3000E80
	thumb_func_end sub_8057BE4

	thumb_func_start sub_8057C4C
sub_8057C4C: @ 8057C4C
	push {r4,lr}
	lsls r0, 16
	lsrs r4, r0, 16
	ldr r1, _08057C64 @ =0xffef0000
	adds r0, r1
	lsrs r0, 16
	cmp r0, 0xC
	bhi _08057C6C
	ldr r0, _08057C68 @ =gHeldKeyCodeToSend
	strh r4, [r0]
	b _08057C72
	.align 2, 0
_08057C64: .4byte 0xffef0000
_08057C68: .4byte gHeldKeyCodeToSend
_08057C6C:
	ldr r1, _08057CB0 @ =gHeldKeyCodeToSend
	movs r0, 0x11
	strh r0, [r1]
_08057C72:
	ldr r0, _08057CB4 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	beq _08057CA8
	bl sub_805833C
	cmp r0, 0x1
	bls _08057CA8
	bl IsUpdateLinkStateCBActive
	cmp r0, 0x1
	bne _08057CA8
	bl IsSendingKeysToLink
	cmp r0, 0x1
	bne _08057CA8
	cmp r4, 0x11
	blt _08057CA8
	cmp r4, 0x15
	ble _08057CA2
	cmp r4, 0x19
	bgt _08057CA8
	cmp r4, 0x18
	blt _08057CA8
_08057CA2:
	ldr r1, _08057CB0 @ =gHeldKeyCodeToSend
	movs r0, 0
	strh r0, [r1]
_08057CA8:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08057CB0: .4byte gHeldKeyCodeToSend
_08057CB4: .4byte gWirelessCommType
	thumb_func_end sub_8057C4C

	thumb_func_start sub_8057CB8
sub_8057CB8: @ 8057CB8
	push {lr}
	ldr r2, _08057CCC @ =gMain
	ldrh r1, [r2, 0x2C]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08057CD0
	movs r0, 0x13
	b _08057D10
	.align 2, 0
_08057CCC: .4byte gMain
_08057CD0:
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08057CDC
	movs r0, 0x12
	b _08057D10
_08057CDC:
	movs r0, 0x20
	ands r0, r1
	cmp r0, 0
	beq _08057CE8
	movs r0, 0x14
	b _08057D10
_08057CE8:
	movs r0, 0x10
	ands r0, r1
	cmp r0, 0
	beq _08057CF4
	movs r0, 0x15
	b _08057D10
_08057CF4:
	ldrh r1, [r2, 0x2E]
	movs r0, 0x8
	ands r0, r1
	cmp r0, 0
	beq _08057D02
	movs r0, 0x18
	b _08057D10
_08057D02:
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _08057D0E
	movs r0, 0x11
	b _08057D10
_08057D0E:
	movs r0, 0x19
_08057D10:
	pop {r1}
	bx r1
	thumb_func_end sub_8057CB8

	thumb_func_start sub_8057D14
sub_8057D14: @ 8057D14
	push {lr}
	lsls r0, 16
	lsrs r0, 16
	adds r1, r0, 0
	cmp r0, 0x13
	beq _08057D3A
	cmp r0, 0x13
	bgt _08057D2A
	cmp r0, 0x12
	beq _08057D3E
	b _08057D42
_08057D2A:
	cmp r1, 0x14
	beq _08057D36
	cmp r1, 0x15
	bne _08057D42
	movs r0, 0x4
	b _08057D44
_08057D36:
	movs r0, 0x3
	b _08057D44
_08057D3A:
	movs r0, 0x1
	b _08057D44
_08057D3E:
	movs r0, 0x2
	b _08057D44
_08057D42:
	movs r0, 0
_08057D44:
	pop {r1}
	bx r1
	thumb_func_end sub_8057D14

	thumb_func_start sub_8057D48
sub_8057D48: @ 8057D48
	push {lr}
	movs r2, 0x11
	adds r1, r0, 0x6
_08057D4E:
	strh r2, [r1]
	subs r1, 0x2
	cmp r1, r0
	bge _08057D4E
	pop {r0}
	bx r0
	thumb_func_end sub_8057D48

	thumb_func_start sub_8057D5C
sub_8057D5C: @ 8057D5C
	push {r4,lr}
	adds r4, r0, 0
	bl ScriptContext2_IsEnabled
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08057D70
	movs r0, 0x11
	b _08057D92
_08057D70:
	bl GetLinkRecvQueueLength
	cmp r0, 0x4
	bls _08057D7C
	movs r0, 0x1B
	b _08057D92
_08057D7C:
	bl sub_805833C
	cmp r0, 0x4
	bls _08057D88
	movs r0, 0x1C
	b _08057D92
_08057D88:
	adds r0, r4, 0
	bl sub_8057CB8
	lsls r0, 16
	lsrs r0, 16
_08057D92:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8057D5C

	thumb_func_start sub_8057D98
sub_8057D98: @ 8057D98
	push {lr}
	bl sub_8057910
	movs r0, 0x11
	pop {r1}
	bx r1
	thumb_func_end sub_8057D98

	thumb_func_start sub_8057DA4
sub_8057DA4: @ 8057DA4
	push {r4,lr}
	bl ScriptContext2_IsEnabled
	lsls r0, 24
	lsrs r0, 24
	movs r4, 0x11
	cmp r0, 0x1
	beq _08057DBC
	movs r4, 0x1A
	ldr r0, _08057DC4 @ =sub_8057D98
	bl c1_link_related_func_set
_08057DBC:
	adds r0, r4, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_08057DC4: .4byte sub_8057D98
	thumb_func_end sub_8057DA4

	thumb_func_start sub_8057DC8
sub_8057DC8: @ 8057DC8
	push {r4,lr}
	bl GetLinkRecvQueueLength
	movs r4, 0x11
	cmp r0, 0x2
	bhi _08057DE0
	movs r4, 0x1A
	bl ScriptContext2_Disable
	ldr r0, _08057DE8 @ =sub_8057D98
	bl c1_link_related_func_set
_08057DE0:
	adds r0, r4, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_08057DE8: .4byte sub_8057D98
	thumb_func_end sub_8057DC8

	thumb_func_start sub_8057DEC
sub_8057DEC: @ 8057DEC
	push {r4,lr}
	bl sub_805833C
	movs r4, 0x11
	cmp r0, 0x2
	bhi _08057E04
	movs r4, 0x1A
	bl ScriptContext2_Disable
	ldr r0, _08057E0C @ =sub_8057D98
	bl c1_link_related_func_set
_08057E04:
	adds r0, r4, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_08057E0C: .4byte sub_8057D98
	thumb_func_end sub_8057DEC

	thumb_func_start sub_8057E10
sub_8057E10: @ 8057E10
	push {lr}
	bl sub_8057910
	movs r0, 0x11
	pop {r1}
	bx r1
	thumb_func_end sub_8057E10

	thumb_func_start sub_8057E1C
sub_8057E1C: @ 8057E1C
	push {lr}
	ldr r1, _08057E40 @ =gUnknown_3000E80
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0x82
	bne _08057E4C
	ldr r0, _08057E44 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _08057E50
	ldr r0, _08057E48 @ =sub_8057E10
	bl c1_link_related_func_set
	movs r0, 0x1D
	b _08057E52
	.align 2, 0
_08057E40: .4byte gUnknown_3000E80
_08057E44: .4byte gMain
_08057E48: .4byte sub_8057E10
_08057E4C:
	bl sub_8057910
_08057E50:
	movs r0, 0x11
_08057E52:
	pop {r1}
	bx r1
	thumb_func_end sub_8057E1C

	thumb_func_start sub_8057E58
sub_8057E58: @ 8057E58
	push {lr}
	ldr r0, _08057E68 @ =sub_8057E1C
	bl c1_link_related_func_set
	movs r0, 0x16
	pop {r1}
	bx r1
	.align 2, 0
_08057E68: .4byte sub_8057E1C
	thumb_func_end sub_8057E58

	thumb_func_start sub_8057E6C
sub_8057E6C: @ 8057E6C
	movs r0, 0x11
	bx lr
	thumb_func_end sub_8057E6C

	thumb_func_start sub_8057E70
sub_8057E70: @ 8057E70
	push {lr}
	ldr r1, _08057E9C @ =gUnknown_3000E80
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0x83
	beq _08057E80
	bl sub_8057910
_08057E80:
	movs r0, 0x83
	bl sub_8057954
	cmp r0, 0x1
	bne _08057E96
	ldr r0, _08057EA0 @ =CableClub_EventScript_DoLinkRoomExit
	bl ScriptContext1_SetupScript
	ldr r0, _08057EA4 @ =sub_8057E6C
	bl c1_link_related_func_set
_08057E96:
	movs r0, 0x11
	pop {r1}
	bx r1
	.align 2, 0
_08057E9C: .4byte gUnknown_3000E80
_08057EA0: .4byte CableClub_EventScript_DoLinkRoomExit
_08057EA4: .4byte sub_8057E6C
	thumb_func_end sub_8057E70

	thumb_func_start sub_8057EA8
sub_8057EA8: @ 8057EA8
	push {lr}
	ldr r0, _08057EB8 @ =sub_8057E70
	bl c1_link_related_func_set
	movs r0, 0x17
	pop {r1}
	bx r1
	.align 2, 0
_08057EB8: .4byte sub_8057E70
	thumb_func_end sub_8057EA8

	thumb_func_start sub_8057EBC
sub_8057EBC: @ 8057EBC
	movs r0, 0x11
	bx lr
	thumb_func_end sub_8057EBC

	thumb_func_start sub_8057EC0
sub_8057EC0: @ 8057EC0
	push {lr}
	movs r0, 0x83
	bl sub_805798C
	cmp r0, 0x1
	beq _08057EFC
	ldr r0, _08057F00 @ =gUnknown_3000E84
	ldr r2, [r0]
	ldr r1, _08057F04 @ =sub_8057E1C
	adds r3, r0, 0
	cmp r2, r1
	bne _08057EE6
	ldr r1, _08057F08 @ =gUnknown_3000E80
	ldr r0, _08057F0C @ =gLocalLinkPlayerId
	ldrb r0, [r0]
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0x82
	bne _08057F1E
_08057EE6:
	ldr r1, [r3]
	ldr r0, _08057F10 @ =sub_8057E10
	cmp r1, r0
	bne _08057F14
	ldr r1, _08057F08 @ =gUnknown_3000E80
	ldr r0, _08057F0C @ =gLocalLinkPlayerId
	ldrb r0, [r0]
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0x81
	bne _08057F14
_08057EFC:
	movs r0, 0x2
	b _08057F24
	.align 2, 0
_08057F00: .4byte gUnknown_3000E84
_08057F04: .4byte sub_8057E1C
_08057F08: .4byte gUnknown_3000E80
_08057F0C: .4byte gLocalLinkPlayerId
_08057F10: .4byte sub_8057E10
_08057F14:
	movs r0, 0x82
	bl sub_8057954
	cmp r0, 0
	bne _08057F22
_08057F1E:
	movs r0, 0
	b _08057F24
_08057F22:
	movs r0, 0x1
_08057F24:
	pop {r1}
	bx r1
	thumb_func_end sub_8057EC0

	thumb_func_start sub_8057F28
sub_8057F28: @ 8057F28
	push {lr}
	movs r0, 0x83
	bl sub_805798C
	pop {r1}
	bx r1
	thumb_func_end sub_8057F28

	thumb_func_start sub_8057F34
sub_8057F34: @ 8057F34
	push {lr}
	ldr r0, _08057F44 @ =sub_8057E58
	bl c1_link_related_func_set
	movs r0, 0
	pop {r1}
	bx r1
	.align 2, 0
_08057F44: .4byte sub_8057E58
	thumb_func_end sub_8057F34

	thumb_func_start sub_8057F48
sub_8057F48: @ 8057F48
	push {lr}
	ldr r0, _08057F58 @ =sub_8057DA4
	bl c1_link_related_func_set
	movs r0, 0
	pop {r1}
	bx r1
	.align 2, 0
_08057F58: .4byte sub_8057DA4
	thumb_func_end sub_8057F48

	thumb_func_start sub_8057F5C
sub_8057F5C: @ 8057F5C
	push {lr}
	ldr r0, _08057F6C @ =sub_8057EA8
	bl c1_link_related_func_set
	movs r0, 0
	pop {r1}
	bx r1
	.align 2, 0
_08057F6C: .4byte sub_8057EA8
	thumb_func_end sub_8057F5C

	thumb_func_start sub_8057F70
sub_8057F70: @ 8057F70
	push {lr}
	ldr r0, _08057F80 @ =sub_8057EBC
	bl c1_link_related_func_set
	movs r0, 0
	pop {r1}
	bx r1
	.align 2, 0
_08057F80: .4byte sub_8057EBC
	thumb_func_end sub_8057F70

	thumb_func_start sub_8057F84
sub_8057F84: @ 8057F84
	push {r4-r6,lr}
	sub sp, 0x4
	adds r4, r0, 0
	adds r6, r2, 0
	strb r4, [r6]
	movs r0, 0
	cmp r4, r1
	bne _08057F96
	movs r0, 0x1
_08057F96:
	strb r0, [r6, 0x1]
	ldr r1, _08057FE8 @ =gLinkPlayerObjectEvents
	lsls r0, r4, 2
	adds r0, r1
	ldrb r0, [r0, 0x3]
	strb r0, [r6, 0x2]
	lsls r4, 24
	lsrs r4, 24
	adds r0, r4, 0
	bl sub_805854C
	strb r0, [r6, 0x3]
	mov r5, sp
	adds r5, 0x2
	adds r0, r4, 0
	mov r1, sp
	adds r2, r5, 0
	bl sub_8058524
	mov r0, sp
	ldrh r0, [r0]
	strh r0, [r6, 0x4]
	ldrh r0, [r5]
	strh r0, [r6, 0x6]
	adds r0, r4, 0
	bl sub_805856C
	strb r0, [r6, 0x8]
	mov r0, sp
	movs r1, 0
	ldrsh r0, [r0, r1]
	movs r2, 0
	ldrsh r1, [r5, r2]
	bl MapGridGetMetatileBehaviorAt
	strh r0, [r6, 0xC]
	add sp, 0x4
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08057FE8: .4byte gLinkPlayerObjectEvents
	thumb_func_end sub_8057F84

	thumb_func_start sub_8057FEC
sub_8057FEC: @ 8057FEC
	push {lr}
	ldrb r0, [r0, 0x2]
	cmp r0, 0x2
	beq _08057FF8
	cmp r0, 0
	bne _08057FFC
_08057FF8:
	movs r0, 0x1
	b _08057FFE
_08057FFC:
	movs r0, 0
_08057FFE:
	pop {r1}
	bx r1
	thumb_func_end sub_8057FEC

	thumb_func_start sub_8058004
sub_8058004: @ 8058004
	push {lr}
	ldrb r0, [r0, 0x2]
	cmp r0, 0x2
	beq _08058010
	cmp r0, 0
	bne _08058014
_08058010:
	movs r0, 0x1
	b _08058016
_08058014:
	movs r0, 0
_08058016:
	pop {r1}
	bx r1
	thumb_func_end sub_8058004

	thumb_func_start sub_805801C
sub_805801C: @ 805801C
	push {lr}
	adds r1, r0, 0
	ldrb r0, [r1, 0x2]
	cmp r0, 0x2
	bne _0805802E
	adds r0, r1, 0x4
	bl GetCoordEventScriptAtMapPosition
	b _08058030
_0805802E:
	movs r0, 0
_08058030:
	pop {r1}
	bx r1
	thumb_func_end sub_805801C

	thumb_func_start sub_8058034
sub_8058034: @ 8058034
	push {r4,lr}
	adds r4, r0, 0
	ldrb r0, [r4, 0x2]
	cmp r0, 0x2
	beq _08058042
	cmp r0, 0
	bne _08058058
_08058042:
	ldrb r0, [r4, 0xC]
	bl MetatileBehavior_IsSouthArrowWarp
	lsls r0, 24
	cmp r0, 0
	beq _08058058
	ldrb r0, [r4, 0x3]
	cmp r0, 0x1
	bne _08058058
	movs r0, 0x1
	b _0805805A
_08058058:
	movs r0, 0
_0805805A:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8058034

	thumb_func_start sub_8058060
sub_8058060: @ 8058060
	push {r4,lr}
	sub sp, 0x8
	adds r4, r0, 0
	ldrb r0, [r4, 0x2]
	cmp r0, 0
	beq _08058074
	cmp r0, 0x2
	beq _08058074
	movs r0, 0
	b _08058122
_08058074:
	ldr r0, [r4, 0x4]
	ldr r1, [r4, 0x8]
	str r0, [sp]
	str r1, [sp, 0x4]
	ldr r3, _080580E4 @ =gDirectionToVectors
	ldrb r0, [r4, 0x3]
	lsls r0, 3
	adds r0, r3
	ldr r0, [r0]
	mov r1, sp
	ldrh r1, [r1]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	ldr r1, _080580E8 @ =0xffff0000
	ldr r2, [sp]
	ands r2, r1
	orrs r2, r0
	str r2, [sp]
	asrs r1, r2, 16
	ldrb r0, [r4, 0x3]
	lsls r0, 3
	adds r3, 0x4
	adds r0, r3
	ldr r0, [r0]
	adds r0, r1
	lsls r0, 16
	ldr r1, _080580EC @ =0x0000ffff
	ands r1, r2
	orrs r1, r0
	str r1, [sp]
	ldr r2, _080580F0 @ =0xffffff00
	ldr r0, [sp, 0x4]
	ands r0, r2
	str r0, [sp, 0x4]
	mov r0, sp
	movs r2, 0
	ldrsh r0, [r0, r2]
	asrs r1, 16
	bl GetLinkPlayerIdAt
	lsls r0, 24
	lsrs r1, r0, 24
	adds r2, r1, 0
	cmp r1, 0x4
	beq _08058118
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	beq _080580E0
	ldr r0, _080580F4 @ =gUnknown_3000E80
	adds r0, r1, r0
	ldrb r0, [r0]
	cmp r0, 0x80
	beq _080580FC
_080580E0:
	ldr r0, _080580F8 @ =CableClub_EventScript_TooBusyToNotice
	b _08058122
	.align 2, 0
_080580E4: .4byte gDirectionToVectors
_080580E8: .4byte 0xffff0000
_080580EC: .4byte 0x0000ffff
_080580F0: .4byte 0xffffff00
_080580F4: .4byte gUnknown_3000E80
_080580F8: .4byte CableClub_EventScript_TooBusyToNotice
_080580FC:
	adds r0, r2, 0
	bl GetSeeingLinkPlayerCardMsg
	cmp r0, 0
	bne _08058110
	ldr r0, _0805810C @ =CableClub_EventScript_ReadTrainerCard
	b _08058122
	.align 2, 0
_0805810C: .4byte CableClub_EventScript_ReadTrainerCard
_08058110:
	ldr r0, _08058114 @ =CableClub_EventScript_ReadTrainerCardColored
	b _08058122
	.align 2, 0
_08058114: .4byte CableClub_EventScript_ReadTrainerCardColored
_08058118:
	ldrb r1, [r4, 0xC]
	ldrb r2, [r4, 0x3]
	mov r0, sp
	bl GetInteractedLinkPlayerScript
_08058122:
	add sp, 0x8
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8058060

	thumb_func_start sub_805812C
sub_805812C: @ 805812C
	push {lr}
	adds r1, r0, 0
	ldr r0, _08058178 @ =BattleColosseum_4P_EventScript_PlayerSpot0
	cmp r1, r0
	beq _08058172
	ldr r0, _0805817C @ =BattleColosseum_4P_EventScript_PlayerSpot1
	cmp r1, r0
	beq _080581B4
	ldr r0, _08058180 @ =BattleColosseum_4P_EventScript_PlayerSpot2
	cmp r1, r0
	beq _08058172
	ldr r0, _08058184 @ =BattleColosseum_4P_EventScript_PlayerSpot3
	cmp r1, r0
	beq _080581B4
	ldr r0, _08058188 @ =RecordCenter_EventScript_Spot
	cmp r1, r0
	beq _08058172
	ldr r0, _0805818C @ =RecordCenter_EventScript_Spot
	cmp r1, r0
	beq _080581B4
	ldr r0, _08058190 @ =RecordCenter_EventScript_Spot
	cmp r1, r0
	beq _08058172
	ldr r0, _08058194 @ =RecordCenter_EventScript_Spot
	cmp r1, r0
	beq _080581B4
	ldr r0, _08058198 @ =BattleColosseum_2P_EventScript_PlayerSpot0
	cmp r1, r0
	beq _08058172
	ldr r0, _0805819C @ =BattleColosseum_2P_EventScript_PlayerSpot1
	cmp r1, r0
	beq _080581B4
	ldr r0, _080581A0 @ =TradeCenter_EventScript_Chair0
	cmp r1, r0
	bne _080581A4
_08058172:
	movs r0, 0xA
	b _080581B6
	.align 2, 0
_08058178: .4byte BattleColosseum_4P_EventScript_PlayerSpot0
_0805817C: .4byte BattleColosseum_4P_EventScript_PlayerSpot1
_08058180: .4byte BattleColosseum_4P_EventScript_PlayerSpot2
_08058184: .4byte BattleColosseum_4P_EventScript_PlayerSpot3
_08058188: .4byte RecordCenter_EventScript_Spot
_0805818C: .4byte RecordCenter_EventScript_Spot
_08058190: .4byte RecordCenter_EventScript_Spot
_08058194: .4byte RecordCenter_EventScript_Spot
_08058198: .4byte BattleColosseum_2P_EventScript_PlayerSpot0
_0805819C: .4byte BattleColosseum_2P_EventScript_PlayerSpot1
_080581A0: .4byte TradeCenter_EventScript_Chair0
_080581A4:
	ldr r0, _080581B0 @ =TradeCenter_EventScript_Chair1
	cmp r1, r0
	beq _080581B4
	movs r0, 0
	b _080581B6
	.align 2, 0
_080581B0: .4byte TradeCenter_EventScript_Chair1
_080581B4:
	movs r0, 0x9
_080581B6:
	pop {r1}
	bx r1
	thumb_func_end sub_805812C

	thumb_func_start sub_80581BC
sub_80581BC: @ 80581BC
	push {lr}
	bl ScriptContext2_Enable
	pop {r0}
	bx r0
	thumb_func_end sub_80581BC

	thumb_func_start sub_80581C8
sub_80581C8: @ 80581C8
	push {lr}
	movs r0, 0x6
	bl PlaySE
	bl ShowStartMenu
	bl ScriptContext2_Enable
	pop {r0}
	bx r0
	thumb_func_end sub_80581C8

	thumb_func_start sub_80581DC
sub_80581DC: @ 80581DC
	push {r4,lr}
	adds r4, r0, 0
	movs r0, 0x5
	bl PlaySE
	adds r0, r4, 0
	bl ScriptContext1_SetupScript
	bl ScriptContext2_Enable
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80581DC

	thumb_func_start sub_80581F8
sub_80581F8: @ 80581F8
	push {lr}
	movs r0, 0x6
	bl PlaySE
	ldr r0, _08058210 @ =TradeCenter_ConfirmLeaveRoom
	bl ScriptContext1_SetupScript
	bl ScriptContext2_Enable
	pop {r0}
	bx r0
	.align 2, 0
_08058210: .4byte TradeCenter_ConfirmLeaveRoom
	thumb_func_end sub_80581F8

	thumb_func_start sub_8058214
sub_8058214: @ 8058214
	push {r4,lr}
	adds r4, r0, 0
	movs r0, 0x5
	bl PlaySE
	adds r0, r4, 0
	bl ScriptContext1_SetupScript
	bl ScriptContext2_Enable
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_8058214

	thumb_func_start sub_8058230
sub_8058230: @ 8058230
	push {lr}
	ldr r0, _08058240 @ =TradeCenter_TerminateLink
	bl ScriptContext1_SetupScript
	bl ScriptContext2_Enable
	pop {r0}
	bx r0
	.align 2, 0
_08058240: .4byte TradeCenter_TerminateLink
	thumb_func_end sub_8058230

	thumb_func_start sub_8058244
sub_8058244: @ 8058244
	push {lr}
	bl IsUpdateLinkStateCBActive
	cmp r0, 0
	bne _08058252
	movs r0, 0
	b _0805826C
_08058252:
	bl GetLinkRecvQueueLength
	cmp r0, 0x2
	bls _08058264
	ldr r1, _08058260 @ =gUnknown_3000E88
	movs r0, 0x1
	b _08058268
	.align 2, 0
_08058260: .4byte gUnknown_3000E88
_08058264:
	ldr r1, _08058270 @ =gUnknown_3000E88
	movs r0, 0
_08058268:
	strb r0, [r1]
	ldrb r0, [r1]
_0805826C:
	pop {r1}
	bx r1
	.align 2, 0
_08058270: .4byte gUnknown_3000E88
	thumb_func_end sub_8058244

	thumb_func_start sub_8058274
sub_8058274: @ 8058274
	push {lr}
	bl GetLinkRecvQueueLength
	cmp r0, 0x1
	bls _080582D8
	bl IsUpdateLinkStateCBActive
	cmp r0, 0x1
	bne _080582D8
	bl IsSendingKeysToLink
	cmp r0, 0x1
	bne _080582D8
	ldr r0, _080582C4 @ =gUnknown_3000E84
	ldr r1, [r0]
	ldr r0, _080582C8 @ =sub_8057DC8
	cmp r1, r0
	beq _080582C0
	ldr r0, _080582CC @ =sub_8057DA4
	cmp r1, r0
	bne _080582D8
	ldr r0, _080582D0 @ =gUnknown_3000E88
	ldrb r2, [r0]
	movs r1, 0
	strb r1, [r0]
	cmp r2, 0x1
	beq _080582C0
	ldr r2, _080582D4 @ =gPaletteFade
	ldrb r1, [r2, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _080582D8
	ldrb r1, [r2, 0xA]
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _080582D8
_080582C0:
	movs r0, 0x1
	b _080582DA
	.align 2, 0
_080582C4: .4byte gUnknown_3000E84
_080582C8: .4byte sub_8057DC8
_080582CC: .4byte sub_8057DA4
_080582D0: .4byte gUnknown_3000E88
_080582D4: .4byte gPaletteFade
_080582D8:
	movs r0, 0
_080582DA:
	pop {r1}
	bx r1
	thumb_func_end sub_8058274

	thumb_func_start sub_80582E0
sub_80582E0: @ 80582E0
	push {lr}
	bl sub_805833C
	cmp r0, 0x1
	bls _08058304
	bl IsUpdateLinkStateCBActive
	cmp r0, 0x1
	bne _08058304
	bl IsSendingKeysToLink
	cmp r0, 0x1
	bne _08058304
	ldr r0, _08058308 @ =gUnknown_3000E84
	ldr r1, [r0]
	ldr r0, _0805830C @ =sub_8057DEC
	cmp r1, r0
	beq _08058310
_08058304:
	movs r0, 0
	b _08058312
	.align 2, 0
_08058308: .4byte gUnknown_3000E84
_0805830C: .4byte sub_8057DEC
_08058310:
	movs r0, 0x1
_08058312:
	pop {r1}
	bx r1
	thumb_func_end sub_80582E0

	thumb_func_start sub_8058318
sub_8058318: @ 8058318
	push {lr}
	ldr r0, _08058330 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	bne _08058334
	bl IsSendingKeysToLink
	cmp r0, 0
	beq _08058334
	movs r0, 0x1
	b _08058336
	.align 2, 0
_08058330: .4byte gWirelessCommType
_08058334:
	movs r0, 0
_08058336:
	pop {r1}
	bx r1
	thumb_func_end sub_8058318

	thumb_func_start sub_805833C
sub_805833C: @ 805833C
	push {lr}
	ldr r0, _08058350 @ =gWirelessCommType
	ldrb r0, [r0]
	cmp r0, 0
	bne _0805835C
	ldr r0, _08058354 @ =gLink
	ldr r1, _08058358 @ =0x00000339
	adds r0, r1
	ldrb r0, [r0]
	b _08058364
	.align 2, 0
_08058350: .4byte gWirelessCommType
_08058354: .4byte gLink
_08058358: .4byte 0x00000339
_0805835C:
	ldr r0, _08058368 @ =Rfu
	ldr r1, _0805836C @ =0x000008d2
	adds r0, r1
	ldrb r0, [r0]
_08058364:
	pop {r1}
	bx r1
	.align 2, 0
_08058368: .4byte Rfu
_0805836C: .4byte 0x000008d2
	thumb_func_end sub_805833C

	thumb_func_start ZeroLinkPlayerObjectEvent
ZeroLinkPlayerObjectEvent: @ 8058370
	movs r1, 0
	str r1, [r0]
	bx lr
	thumb_func_end ZeroLinkPlayerObjectEvent

	thumb_func_start ClearLinkPlayerObjectEvents
ClearLinkPlayerObjectEvents: @ 8058378
	push {lr}
	ldr r0, _08058388 @ =gLinkPlayerObjectEvents
	movs r1, 0
	movs r2, 0x10
	bl memset
	pop {r0}
	bx r0
	.align 2, 0
_08058388: .4byte gLinkPlayerObjectEvents
	thumb_func_end ClearLinkPlayerObjectEvents

	thumb_func_start ZeroObjectEvent
ZeroObjectEvent: @ 805838C
	push {lr}
	movs r1, 0
	movs r2, 0x24
	bl memset
	pop {r0}
	bx r0
	thumb_func_end ZeroObjectEvent

	thumb_func_start SpawnLinkPlayerObjectEvent
SpawnLinkPlayerObjectEvent: @ 805839C
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	mov r9, r1
	mov r10, r2
	mov r8, r3
	lsls r0, 24
	lsrs r7, r0, 24
	mov r0, r9
	lsls r0, 16
	lsrs r0, 16
	mov r9, r0
	mov r1, r10
	lsls r1, 16
	lsrs r1, 16
	mov r10, r1
	mov r2, r8
	lsls r2, 24
	lsrs r2, 24
	mov r8, r2
	bl GetFirstInactiveObjectEventId
	adds r6, r0, 0
	lsls r6, 24
	lsrs r6, 24
	lsls r4, r7, 2
	ldr r0, _08058440 @ =gLinkPlayerObjectEvents
	adds r4, r0
	lsls r5, r6, 3
	adds r5, r6
	lsls r5, 2
	ldr r0, _08058444 @ =gObjectEvents
	adds r5, r0
	adds r0, r4, 0
	bl ZeroLinkPlayerObjectEvent
	adds r0, r5, 0
	bl ZeroObjectEvent
	movs r2, 0
	movs r1, 0x1
	movs r0, 0x1
	strb r0, [r4]
	strb r7, [r4, 0x1]
	strb r6, [r4, 0x2]
	strb r2, [r4, 0x3]
	ldrb r0, [r5]
	orrs r0, r1
	mov r2, r8
	ands r2, r1
	lsls r2, 1
	movs r1, 0x3
	negs r1, r1
	ands r0, r1
	orrs r0, r2
	strb r0, [r5]
	movs r0, 0x2
	strb r0, [r5, 0x19]
	movs r0, 0x40
	strb r0, [r5, 0x4]
	mov r0, r9
	lsls r0, 16
	asrs r0, 16
	mov r9, r0
	mov r1, r10
	lsls r1, 16
	asrs r1, 16
	mov r10, r1
	adds r0, r5, 0
	mov r1, r9
	mov r2, r10
	bl InitLinkPlayerObjectEventPos
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08058440: .4byte gLinkPlayerObjectEvents
_08058444: .4byte gObjectEvents
	thumb_func_end SpawnLinkPlayerObjectEvent

	thumb_func_start InitLinkPlayerObjectEventPos
InitLinkPlayerObjectEventPos: @ 8058448
	push {r4,lr}
	adds r4, r0, 0
	adds r0, r1, 0
	adds r1, r2, 0
	lsls r0, 16
	lsrs r0, 16
	lsls r1, 16
	lsrs r1, 16
	strh r0, [r4, 0x10]
	strh r1, [r4, 0x12]
	strh r0, [r4, 0x14]
	strh r1, [r4, 0x16]
	lsls r0, 16
	asrs r0, 16
	lsls r1, 16
	asrs r1, 16
	adds r2, r4, 0
	adds r2, 0xC
	adds r3, r4, 0
	adds r3, 0xE
	bl SetSpritePosToMapCoords
	ldrh r0, [r4, 0xC]
	adds r0, 0x8
	strh r0, [r4, 0xC]
	adds r0, r4, 0
	bl ObjectEventUpdateZCoord
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end InitLinkPlayerObjectEventPos

	thumb_func_start sub_8058488
sub_8058488: @ 8058488
	push {lr}
	lsls r0, 24
	lsls r1, 24
	lsrs r2, r1, 24
	ldr r1, _080584B0 @ =gLinkPlayerObjectEvents
	lsrs r0, 22
	adds r1, r0, r1
	ldrb r0, [r1]
	cmp r0, 0
	beq _080584AA
	ldrb r0, [r1, 0x2]
	lsls r1, r0, 3
	adds r1, r0
	lsls r1, 2
	ldr r0, _080584B4 @ =gObjectEvents
	adds r1, r0
	strb r2, [r1, 0x19]
_080584AA:
	pop {r0}
	bx r0
	.align 2, 0
_080584B0: .4byte gLinkPlayerObjectEvents
_080584B4: .4byte gObjectEvents
	thumb_func_end sub_8058488

	thumb_func_start sub_80584B8
sub_80584B8: @ 80584B8
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r0, 22
	ldr r1, _080584F8 @ =gLinkPlayerObjectEvents
	adds r5, r0, r1
	ldrb r1, [r5, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _080584FC @ =gObjectEvents
	adds r4, r0, r1
	ldrb r0, [r4, 0x4]
	cmp r0, 0x40
	beq _080584E4
	adds r1, r0, 0
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	ldr r1, _08058500 @ =gSprites
	adds r0, r1
	bl DestroySprite
_080584E4:
	movs r0, 0
	strb r0, [r5]
	ldrb r1, [r4]
	subs r0, 0x2
	ands r0, r1
	strb r0, [r4]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080584F8: .4byte gLinkPlayerObjectEvents
_080584FC: .4byte gObjectEvents
_08058500: .4byte gSprites
	thumb_func_end sub_80584B8

	thumb_func_start sub_8058504
sub_8058504: @ 8058504
	lsls r0, 24
	ldr r1, _0805851C @ =gLinkPlayerObjectEvents
	lsrs r0, 22
	adds r0, r1
	ldrb r1, [r0, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _08058520 @ =gObjectEvents
	adds r0, r1
	ldrb r0, [r0, 0x4]
	bx lr
	.align 2, 0
_0805851C: .4byte gLinkPlayerObjectEvents
_08058520: .4byte gObjectEvents
	thumb_func_end sub_8058504

	thumb_func_start sub_8058524
sub_8058524: @ 8058524
	lsls r0, 24
	ldr r3, _08058544 @ =gLinkPlayerObjectEvents
	lsrs r0, 22
	adds r0, r3
	ldrb r3, [r0, 0x2]
	lsls r0, r3, 3
	adds r0, r3
	lsls r0, 2
	ldr r3, _08058548 @ =gObjectEvents
	adds r0, r3
	ldrh r3, [r0, 0x10]
	strh r3, [r1]
	ldrh r0, [r0, 0x12]
	strh r0, [r2]
	bx lr
	.align 2, 0
_08058544: .4byte gLinkPlayerObjectEvents
_08058548: .4byte gObjectEvents
	thumb_func_end sub_8058524

	thumb_func_start sub_805854C
sub_805854C: @ 805854C
	lsls r0, 24
	ldr r1, _08058564 @ =gLinkPlayerObjectEvents
	lsrs r0, 22
	adds r0, r1
	ldrb r1, [r0, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _08058568 @ =gObjectEvents
	adds r0, r1
	ldrb r0, [r0, 0x19]
	bx lr
	.align 2, 0
_08058564: .4byte gLinkPlayerObjectEvents
_08058568: .4byte gObjectEvents
	thumb_func_end sub_805854C

	thumb_func_start sub_805856C
sub_805856C: @ 805856C
	lsls r0, 24
	ldr r1, _08058588 @ =gLinkPlayerObjectEvents
	lsrs r0, 22
	adds r0, r1
	ldrb r1, [r0, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _0805858C @ =gObjectEvents
	adds r0, r1
	ldrb r0, [r0, 0xB]
	lsls r0, 28
	lsrs r0, 28
	bx lr
	.align 2, 0
_08058588: .4byte gLinkPlayerObjectEvents
_0805858C: .4byte gObjectEvents
	thumb_func_end sub_805856C

	thumb_func_start sub_8058590
sub_8058590: @ 8058590
	lsls r0, 24
	ldr r1, _080585B0 @ =gLinkPlayerObjectEvents
	lsrs r0, 22
	adds r0, r1
	ldrb r1, [r0, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _080585B4 @ =gObjectEvents
	adds r0, r1
	adds r0, 0x21
	movs r1, 0
	ldrsb r1, [r0, r1]
	movs r0, 0x10
	subs r0, r1
	bx lr
	.align 2, 0
_080585B0: .4byte gLinkPlayerObjectEvents
_080585B4: .4byte gObjectEvents
	thumb_func_end sub_8058590

	thumb_func_start GetLinkPlayerIdAt
GetLinkPlayerIdAt: @ 80585B8
	push {r4-r6,lr}
	movs r2, 0
	ldr r5, _080585FC @ =gLinkPlayerObjectEvents
	lsls r0, 16
	asrs r4, r0, 16
	lsls r1, 16
	asrs r3, r1, 16
_080585C6:
	lsls r0, r2, 2
	adds r1, r0, r5
	ldrb r0, [r1]
	cmp r0, 0
	beq _08058604
	ldrb r0, [r1, 0x3]
	cmp r0, 0
	beq _080585DA
	cmp r0, 0x2
	bne _08058604
_080585DA:
	ldrb r1, [r1, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _08058600 @ =gObjectEvents
	adds r1, r0, r1
	movs r6, 0x10
	ldrsh r0, [r1, r6]
	cmp r0, r4
	bne _08058604
	movs r6, 0x12
	ldrsh r0, [r1, r6]
	cmp r0, r3
	bne _08058604
	adds r0, r2, 0
	b _08058610
	.align 2, 0
_080585FC: .4byte gLinkPlayerObjectEvents
_08058600: .4byte gObjectEvents
_08058604:
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, 0x3
	bls _080585C6
	movs r0, 0x4
_08058610:
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end GetLinkPlayerIdAt

	thumb_func_start sub_8058618
sub_8058618: @ 8058618
	push {r4-r6,lr}
	lsls r0, 24
	lsls r1, 24
	lsrs r3, r1, 24
	adds r2, r3, 0
	lsrs r0, 22
	ldr r1, _08058648 @ =gLinkPlayerObjectEvents
	adds r5, r0, r1
	ldrb r1, [r5, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _0805864C @ =gObjectEvents
	adds r6, r0, r1
	ldrb r0, [r5]
	cmp r0, 0
	beq _08058674
	cmp r3, 0xA
	bls _08058650
	ldrb r0, [r6]
	movs r1, 0x4
	orrs r0, r1
	strb r0, [r6]
	b _08058674
	.align 2, 0
_08058648: .4byte gLinkPlayerObjectEvents
_0805864C: .4byte gObjectEvents
_08058650:
	ldr r4, _0805867C @ =gUnknown_826D374
	ldr r1, _08058680 @ =gUnknown_826D33C
	ldrb r0, [r5, 0x3]
	lsls r0, 2
	adds r0, r1
	ldr r3, [r0]
	adds r0, r5, 0
	adds r1, r6, 0
	bl _call_via_r3
	lsls r0, 24
	lsrs r0, 22
	adds r0, r4
	ldr r2, [r0]
	adds r0, r5, 0
	adds r1, r6, 0
	bl _call_via_r2
_08058674:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_0805867C: .4byte gUnknown_826D374
_08058680: .4byte gUnknown_826D33C
	thumb_func_end sub_8058618

	thumb_func_start sub_8058684
sub_8058684: @ 8058684
	push {r4,lr}
	lsls r2, 24
	lsrs r2, 24
	ldr r4, _080586A0 @ =gUnknown_826D348
	lsls r3, r2, 2
	adds r3, r4
	ldr r3, [r3]
	bl _call_via_r3
	lsls r0, 24
	lsrs r0, 24
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_080586A0: .4byte gUnknown_826D348
	thumb_func_end sub_8058684

	thumb_func_start sub_80586A4
sub_80586A4: @ 80586A4
	movs r0, 0x1
	bx lr
	thumb_func_end sub_80586A4

	thumb_func_start sub_80586A8
sub_80586A8: @ 80586A8
	push {r4,lr}
	lsls r2, 24
	lsrs r2, 24
	ldr r4, _080586C4 @ =gUnknown_826D348
	lsls r3, r2, 2
	adds r3, r4
	ldr r3, [r3]
	bl _call_via_r3
	lsls r0, 24
	lsrs r0, 24
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_080586C4: .4byte gUnknown_826D348
	thumb_func_end sub_80586A8

	thumb_func_start sub_80586C8
sub_80586C8: @ 80586C8
	movs r0, 0
	bx lr
	thumb_func_end sub_80586C8

	thumb_func_start sub_80586CC
sub_80586CC: @ 80586CC
	push {r4-r6,lr}
	sub sp, 0x4
	adds r4, r0, 0
	adds r5, r1, 0
	lsls r0, r2, 24
	lsrs r0, 24
	ldrb r1, [r5, 0x19]
	bl npc_something3
	strb r0, [r5, 0x19]
	ldrb r1, [r5, 0x19]
	mov r6, sp
	adds r6, 0x2
	adds r0, r5, 0
	mov r2, sp
	adds r3, r6, 0
	bl ObjectEventMoveDestCoords
	ldrb r0, [r4, 0x2]
	ldrb r1, [r5, 0x19]
	mov r2, sp
	movs r3, 0
	ldrsh r2, [r2, r3]
	movs r4, 0
	ldrsh r3, [r6, r4]
	bl npc_080587EC
	lsls r0, 24
	cmp r0, 0
	bne _0805872A
	adds r1, r5, 0
	adds r1, 0x21
	movs r0, 0x10
	strb r0, [r1]
	mov r0, sp
	movs r2, 0
	ldrsh r1, [r0, r2]
	movs r3, 0
	ldrsh r2, [r6, r3]
	adds r0, r5, 0
	bl ShiftObjectEventCoords
	adds r0, r5, 0
	bl ObjectEventUpdateZCoord
	movs r0, 0x1
	b _0805872C
_0805872A:
	movs r0, 0
_0805872C:
	add sp, 0x4
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end sub_80586CC

	thumb_func_start sub_8058734
sub_8058734: @ 8058734
	push {r4,lr}
	adds r4, r1, 0
	lsls r0, r2, 24
	lsrs r0, 24
	ldrb r1, [r4, 0x19]
	bl npc_something3
	strb r0, [r4, 0x19]
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8058734

	thumb_func_start sub_805874C
sub_805874C: @ 805874C
	movs r1, 0
	strb r1, [r0, 0x3]
	bx lr
	thumb_func_end sub_805874C

	thumb_func_start sub_8058754
sub_8058754: @ 8058754
	push {r4-r6,lr}
	adds r6, r0, 0
	adds r4, r1, 0
	adds r5, r4, 0
	adds r5, 0x21
	ldrb r0, [r5]
	subs r0, 0x1
	strb r0, [r5]
	movs r0, 0x1
	strb r0, [r6, 0x3]
	ldrb r0, [r4, 0x19]
	adds r1, 0xC
	adds r2, r4, 0
	adds r2, 0xE
	bl MoveCoords
	ldrb r0, [r5]
	cmp r0, 0
	bne _08058784
	adds r0, r4, 0
	bl ShiftStillObjectEventCoords
	movs r0, 0x2
	strb r0, [r6, 0x3]
_08058784:
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end sub_8058754

	thumb_func_start npc_something3
npc_something3: @ 805878C
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	lsls r1, 24
	lsrs r2, r1, 24
	subs r0, 0x1
	cmp r0, 0x9
	bhi _080587E4
	lsls r0, 2
	ldr r1, _080587A8 @ =_080587AC
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_080587A8: .4byte _080587AC
	.align 2, 0
_080587AC:
	.4byte _080587D4
	.4byte _080587D8
	.4byte _080587DC
	.4byte _080587E0
	.4byte _080587E4
	.4byte _080587E4
	.4byte _080587D4
	.4byte _080587D8
	.4byte _080587DC
	.4byte _080587E0
_080587D4:
	movs r0, 0x2
	b _080587E6
_080587D8:
	movs r0, 0x1
	b _080587E6
_080587DC:
	movs r0, 0x3
	b _080587E6
_080587E0:
	movs r0, 0x4
	b _080587E6
_080587E4:
	adds r0, r2, 0
_080587E6:
	pop {r1}
	bx r1
	thumb_func_end npc_something3

	thumb_func_start npc_080587EC
npc_080587EC: @ 80587EC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	lsls r0, 24
	lsrs r0, 24
	mov r8, r0
	lsls r2, 16
	lsrs r2, 16
	mov r12, r2
	lsls r3, 16
	movs r4, 0
	ldr r0, _08058850 @ =gObjectEvents
	mov r9, r0
	lsrs r2, r3, 16
	mov r10, r2
	asrs r6, r3, 16
_08058810:
	mov r7, r12
	lsls r3, r7, 16
	mov r0, r10
	lsls r5, r0, 16
	cmp r4, r8
	beq _08058854
	lsls r0, r4, 3
	adds r0, r4
	lsls r0, 2
	mov r2, r9
	adds r1, r0, r2
	movs r7, 0x10
	ldrsh r0, [r1, r7]
	asrs r2, r3, 16
	cmp r0, r2
	bne _08058838
	movs r7, 0x12
	ldrsh r0, [r1, r7]
	cmp r0, r6
	beq _0805884A
_08058838:
	movs r7, 0x14
	ldrsh r0, [r1, r7]
	cmp r0, r2
	bne _08058854
	movs r0, 0x16
	ldrsh r1, [r1, r0]
	asrs r0, r5, 16
	cmp r1, r0
	bne _08058854
_0805884A:
	movs r0, 0x1
	b _0805886A
	.align 2, 0
_08058850: .4byte gObjectEvents
_08058854:
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0xF
	bls _08058810
	asrs r0, r3, 16
	asrs r1, r5, 16
	bl MapGridIsImpassableAt
	lsls r0, 24
	lsrs r0, 24
_0805886A:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end npc_080587EC

	thumb_func_start sub_8058878
sub_8058878: @ 8058878
	push {r4,r5,lr}
	sub sp, 0x4
	lsls r0, 24
	lsrs r5, r0, 24
	lsls r1, 24
	lsrs r3, r1, 24
	lsls r2, r5, 2
	ldr r0, _080588B4 @ =gLinkPlayerObjectEvents
	adds r2, r0
	ldrb r1, [r2, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _080588B8 @ =gObjectEvents
	adds r4, r0, r1
	ldrb r0, [r2]
	cmp r0, 0
	beq _080588FC
	subs r0, r3, 0x4
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bhi _080588BC
	ldrb r1, [r4]
	lsls r1, 30
	lsrs r1, 31
	movs r0, 0
	bl GetRivalAvatarGraphicsIdByStateIdAndGender
	b _080588C6
	.align 2, 0
_080588B4: .4byte gLinkPlayerObjectEvents
_080588B8: .4byte gObjectEvents
_080588BC:
	ldrb r0, [r4]
	lsls r0, 30
	lsrs r0, 31
	bl GetHoennLinkPartnerGraphicsIdByGender
_080588C6:
	lsls r0, 24
	lsrs r0, 24
	ldr r1, _08058904 @ =SpriteCB_LinkPlayer
	movs r2, 0
	str r2, [sp]
	movs r3, 0
	bl AddPseudoObjectEvent
	strb r0, [r4, 0x4]
	ldrb r1, [r4, 0x4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	ldr r1, _08058908 @ =gSprites
	adds r0, r1
	adds r3, r0, 0
	adds r3, 0x3E
	ldrb r1, [r3]
	movs r2, 0x2
	orrs r1, r2
	strb r1, [r3]
	strh r5, [r0, 0x2E]
	ldrb r1, [r4]
	movs r0, 0x5
	negs r0, r0
	ands r0, r1
	strb r0, [r4]
_080588FC:
	add sp, 0x4
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08058904: .4byte SpriteCB_LinkPlayer
_08058908: .4byte gSprites
	thumb_func_end sub_8058878

	thumb_func_start SpriteCB_LinkPlayer
SpriteCB_LinkPlayer: @ 805890C
	push {r4-r6,lr}
	adds r5, r0, 0
	movs r0, 0x2E
	ldrsh r4, [r5, r0]
	lsls r4, 2
	ldr r0, _08058970 @ =gLinkPlayerObjectEvents
	adds r4, r0
	ldrb r1, [r4, 0x2]
	lsls r0, r1, 3
	adds r0, r1
	lsls r0, 2
	ldr r1, _08058974 @ =gObjectEvents
	adds r6, r0, r1
	ldrh r0, [r6, 0xC]
	strh r0, [r5, 0x20]
	ldrh r0, [r6, 0xE]
	strh r0, [r5, 0x22]
	ldrb r0, [r6, 0xB]
	lsrs r0, 4
	adds r1, r5, 0
	movs r2, 0x1
	bl SetObjectSubpriorityByZCoord
	ldrb r0, [r6, 0xB]
	lsrs r0, 4
	bl ZCoordToPriority
	movs r1, 0x3
	ands r1, r0
	lsls r1, 2
	ldrb r2, [r5, 0x5]
	movs r0, 0xD
	negs r0, r0
	ands r0, r2
	orrs r0, r1
	strb r0, [r5, 0x5]
	ldrb r0, [r4, 0x3]
	cmp r0, 0
	bne _08058978
	ldrb r0, [r6, 0x19]
	bl GetFaceDirectionAnimNum
	adds r1, r0, 0
	lsls r1, 24
	lsrs r1, 24
	adds r0, r5, 0
	bl StartSpriteAnim
	b _0805898A
	.align 2, 0
_08058970: .4byte gLinkPlayerObjectEvents
_08058974: .4byte gObjectEvents
_08058978:
	ldrb r0, [r6, 0x19]
	bl GetMoveDirectionAnimNum
	adds r1, r0, 0
	lsls r1, 24
	lsrs r1, 24
	adds r0, r5, 0
	bl StartSpriteAnimIfDifferent
_0805898A:
	adds r0, r5, 0
	movs r1, 0
	bl UpdateObjectEventSpriteVisibility
	ldrb r0, [r6]
	lsls r0, 29
	cmp r0, 0
	bge _080589BC
	ldrh r0, [r5, 0x3C]
	movs r1, 0x4
	ands r1, r0
	lsls r1, 16
	adds r3, r5, 0
	adds r3, 0x3E
	lsrs r1, 18
	lsls r1, 2
	ldrb r2, [r3]
	movs r0, 0x5
	negs r0, r0
	ands r0, r2
	orrs r0, r1
	strb r0, [r3]
	ldrh r0, [r5, 0x3C]
	adds r0, 0x1
	strh r0, [r5, 0x3C]
_080589BC:
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end SpriteCB_LinkPlayer

	.align 2, 0 @ Don't pad with nop.
