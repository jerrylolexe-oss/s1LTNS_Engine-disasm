; ===========================================================================
; ---------------------------------------------------------------------------
; Object 05 - Spindash dust (Water splash in Sonic 2)
; ---------------------------------------------------------------------------
; Sprite_1DD20: Obj08:
SpinDash_dust:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj05_Index(pc,d0.w),d1
		jmp	Obj05_Index(pc,d1.w)
; ===========================================================================
; off_1DD2E:
Obj05_Index:	dc.w Obj05_Init-Obj05_Index
		dc.w Obj05_Main-Obj05_Index
		dc.w Obj05_Delete-Obj05_Index
		dc.w Obj05_Skid-Obj05_Index
; ===========================================================================
; loc_1DD36:
Obj05_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj05,obMap(a0)
		ori.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.w	#$7A0,obGfx(a0)
		move.w	#-$3000,objoff_3E(a0)	; MainCharacter
		move.w	#$F400,objoff_3C(a0)
		cmpa.w	#-$2E40,a0	; Sonic_Dust
		beq.s	Obj05_Main	; was "+"
		move.b	#1,objoff_34(a0)
		; As Miles "Tails" Prower didn't exist in Sonic 1, this entire code specific to Sonic 2 has been removed.
;		cmpi.w	#2,(Player_mode).w	; is player mode Miles/Tails?
;		beq.s	+			; if yes, branch
;		move.w	#$48C,obGfx(a0)	; make spindust for Tails
;		move.w	#-$4FC0,objoff_3E(a0)	; Sidekick
;		move.w	#-$6E80,objoff_3C(a0)	; make spindust for Tails
;+
;		bsr.w	Adjust2PArtPointer	; routine doesn't exist in Sonic 1

; loc_1DD90:
Obj05_Main:
		movea.w	objoff_3E(a0),a2 ; a2=character (although an unused/dead code, it's still needed or else dust would not show)
		moveq	#0,d0
		move.b	obAnim(a0),d0	; use current animation as a secondary routine counter
		add.w	d0,d0
		move.w	Obj05_Modes(pc,d0.w),d1
		jmp	Obj05_Modes(pc,d1.w)
; ===========================================================================
; off_1DDA4: Obj08_DisplayModes:
Obj05_Modes:	dc Obj05_Display-Obj05_Modes
		dc Obj05_MdSplash-Obj05_Modes
		dc Obj05_MdDust-Obj05_Modes
		dc Obj05_MdSkidDust-Obj05_Modes
; ===========================================================================
; This is used for the water splash in Sonic 2. Sonic 1 already has the water
; splash object in place for LZ, but this one uses a different graphic. This
; code is just a duplicate/leftover, however.
; loc_1DDAC:
Obj05_MdSplash:
		move.w	(v_waterpos1).w,obY(a0)
		tst.b	obPrevAni(a0)
		bne.s	Obj05_Display
		move.w	obX(a2),obX(a0)
		move.b	#0,obStatus(a0)
		andi.w	#$7FFF,obGfx(a0)	; drawing_mask
		bra.s	Obj05_Display
; ===========================================================================
; loc_1DDCC: Obj08_MdSpindashDust:
Obj05_MdDust:
		if Revision=1
		cmpi.w	#12,(v_air).w	; check air remaining
		blo.s	Obj05_Reset	; if he's drowning, branch to not make dust
		endif
		cmpi.b	#4,obRoutine(a2)
		bhs.s	Obj05_Reset
		tst.b	spindash_flag(a2)
		beq.s	Obj05_Reset
		move.w	obX(a2),obX(a0)
		move.w	obY(a2),obY(a0)
		move.b	obStatus(a2),obStatus(a0)
		andi.b	#1,obStatus(a0)
		tst.b	objoff_34(a0)
		beq.s	+
		subi.w	#4,obY(a0)
+
		tst.b	obPrevAni(a0)
		bne.s	Obj05_Display
		andi.w	#$7FFF,obGfx(a0)	; drawing_mask
		tst.w	obGfx(a2)
		bpl.s	Obj05_Display
		ori.w	#-$8000,obGfx(a0)	; high_priority
		bra.s	Obj05_Display
		nop
; ===========================================================================
; loc_1DE20:
Obj05_MdSkidDust:
		if Revision=1
		cmpi.w	#12,(v_air).w	; check air remaining
		blo.s	Obj05_Reset	; if he's drowning, branch to not make dust
		endif

; loc_1DE28:
Obj05_Display:
		lea	(Ani_obj05).l,a1
		jsr	(AnimateSprite).l
		bsr.w	LoadDustDynPLC
		jmp	(DisplaySprite).l
; ===========================================================================
; loc_1DE3E: Obj08_ResetDisplayMode:
Obj05_Reset:
		move.b	#0,obAnim(a0)
		rts
; ===========================================================================
; BranchTo16_DeleteObject
Obj05_Delete: 
		bra.w	DeleteObject
; ===========================================================================
; This is the routine used for the skidding dust. This is just a leftover, as
; nothing in the game calls for it. Sonic 1 doesn't have a skidding dust in
; the original game.
; loc_1DE4A: Obj08_CheckSkid:
Obj05_Skid:
		movea.w	objoff_3E(a0),a2 ; a2=character (although an unused/dead code, it's still needed or else dust would not show)
		moveq	#$10,d1
		cmpi.b	#id_Stop,obAnim(a2)	; is Sonic skidding?
		beq.s	Obj05_SkidDust	; if not, branch
		moveq	#$6,d1
		cmp.b	#$3,obColProp(a2)
		beq.s	Obj05_SkidDust
		move.b	#2,obRoutine(a0)
		move.b	#0,objoff_32(a0)
		rts
; ===========================================================================
; loc_1DE64:
Obj05_SkidDust:
		subq.b	#1,objoff_32(a0)
		bpl.s	loc_1DEE0
		move.b	#3,objoff_32(a0)
		jsr	(FindFreeObj).l	; changed from bsr.w
		bne.s	loc_1DEE0
		move.b	0(a0),0(a1) ; load obj08 (leftover code)
		move.w	obX(a2),obX(a1)
		move.w	obY(a2),obY(a1)
		addi.w	#$10,obY(a1)	; unknown
		tst.b	objoff_34(a0)
		beq.s	+
		subi.w	#4,obY(a1)
+
		addi.w	d1,$C(a1)
		move.b	#0,obStatus(a1)
		move.b	#3,obAnim(a1)
		addq.b	#2,obRoutine(a1)
		move.l	obMap(a0),obMap(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#1,obPriority(a1)
		move.b	#4,obActWid(a1)
		move.w	obGfx(a0),obGfx(a1)
		move.w	objoff_3E(a0),objoff_3E(a1)
		andi.w	#$7FFF,obGfx(a1)
		tst.w	obGfx(a2)
		bpl.s	loc_1DEE0
		ori.w	#-$8000,obGfx(a1)

loc_1DEE0:
		bsr.s	LoadDustDynPLC
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Spindust pattern loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

; loc_1DEE4:
LoadDustDynPLC:
		moveq	#0,d0
		move.b	obFrame(a0),d0	; load frame number
		cmp.b	objoff_30(a0),d0
		beq.w	return_1DF36
		move.b	d0,objoff_30(a0)
		lea	(DustDynPLC).l,a2 ; load PLC script
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.w	return_1DF36	; if zero, branch
		move.w	objoff_3C(a0),d4

-		moveq	#0,d1
		move.w	(a2)+,d1	; read "number of entries" value
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		addi.l	#Art_Dust,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(DMA_68KtoVRAM).l	; labeled as "QueueDMATransfer" in Sonic 2 disassembly nomenclature
		dbf	d5,-	; repeat for number of entries

return_1DF36:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation script - Spindash Dust
; ---------------------------------------------------------------------------
; off_1DF38:
Ani_obj05:
		dc.w Obj05Ani_Null-Ani_obj05	; 0
		dc.w Obj05Ani_Splash-Ani_obj05	; 1
		dc.w Obj05Ani_Dash-Ani_obj05	; 2
		dc.w Obj05Ani_Skid-Ani_obj05	; 3
Obj05Ani_Null:	dc.b $1F,  0,$FF
Obj05Ani_Splash:dc.b   3,  1,  2,  3,  4,  5,  6,  7,  8,  9,$FD,  0
Obj05Ani_Dash:	dc.b   1, $A, $B, $C, $D, $E, $F,$10,$FF
Obj05Ani_Skid:	dc.b   3,$11,$12,$13,$14,$FC
		even
; ---------------------------------------------------------------------------
; Sprite mappings - Spindash Dust
; ---------------------------------------------------------------------------
Map_Obj05:
		dc.w word_1DF8A-Map_Obj05	; 0
		dc.w word_1DF8C-Map_Obj05	; 1
		dc.w word_1DF96-Map_Obj05	; 2
		dc.w word_1DFA0-Map_Obj05	; 3
		dc.w word_1DFAA-Map_Obj05	; 4
		dc.w word_1DFB4-Map_Obj05	; 5
		dc.w word_1DFBE-Map_Obj05	; 6
		dc.w word_1DFC8-Map_Obj05	; 7
		dc.w word_1DFD2-Map_Obj05	; 8
		dc.w word_1DFDC-Map_Obj05	; 9
		dc.w word_1DFE6-Map_Obj05	; A
		dc.w word_1DFF0-Map_Obj05	; B
		dc.w word_1DFFA-Map_Obj05	; C
		dc.w word_1E004-Map_Obj05	; D
		dc.w word_1E016-Map_Obj05	; E
		dc.w word_1E028-Map_Obj05	; F
		dc.w word_1E03A-Map_Obj05	; 10
		dc.w word_1E04C-Map_Obj05	; 11
		dc.w word_1E056-Map_Obj05	; 12
		dc.w word_1E060-Map_Obj05	; 13
		dc.w word_1E06A-Map_Obj05	; 14
		dc.w word_1DF8A-Map_Obj05	; 15
word_1DF8A:	dc.b 0
word_1DF8C:	dc.b 1
		dc.b $F2, $0D, $0, 0,$F0
word_1DF96:	dc.b 1
		dc.b $E2, $0F, $0, 0,$F0
word_1DFA0:	dc.b 1
		dc.b $E2, $0F, $0, 0,$F0
word_1DFAA:	dc.b 1
		dc.b $E2, $0F, $0, 0,$F0
word_1DFB4:	dc.b 1
		dc.b $E2, $0F, $0, 0,$F0
word_1DFBE:	dc.b 1
		dc.b $E2, $0F, $0, 0,$F0
word_1DFC8:	dc.b 1
		dc.b $F2, $0D, $0, 0,$F0
word_1DFD2:	dc.b 1
		dc.b $F2, $0D, $0, 0,$F0
word_1DFDC:	dc.b 1
		dc.b $F2, $0D, $0, 0,$F0
word_1DFE6:	dc.b 1
		dc.b $4, $0D, $0, 0,$E0
word_1DFF0:	dc.b 1
		dc.b $4, $0D, $0, 0,$E0
word_1DFFA:	dc.b 1
		dc.b $4, $0D, $0, 0,$E0
word_1E004:	dc.b 2
		dc.b $F4, $01, $0, 0,$E8
		dc.b $4, $0D, $0, 2,$E0
word_1E016:	dc.b 2
		dc.b $F4, $05, $0, 0,$E8
		dc.b $4, $0D, $0, 4,$E0
word_1E028:	dc.b 2
		dc.b $F4, $09, $0, 0,$E0
		dc.b $4, $0D, $0, 6,$E0
word_1E03A:	dc.b 2
		dc.b $F4, $09, $0, 0,$E0
		dc.b $4, $0D, $0, 6,$E0
word_1E04C:	dc.b 1
		dc.b $F8, $05, $0, 0,$F8
word_1E056:	dc.b 1
		dc.b $F8, $05, $0, 4,$F8
word_1E060:	dc.b 1
		dc.b $F8, $05, $0, 8,$F8
word_1E06A:	dc.b 1
		dc.b $F8, $05, $0, $C,$F8
		dc.b 0
		even
; --------------------------------------------------------------------------------
; Dynamic Pattern Loading Cues - Spindash Dust
; --------------------------------------------------------------------------------
DustDynPLC:
		dc word_1E0A0-DustDynPLC	; 0
		dc word_1E0A2-DustDynPLC	; 1
		dc word_1E0A6-DustDynPLC	; 2
		dc word_1E0AA-DustDynPLC	; 3
		dc word_1E0AE-DustDynPLC	; 4
		dc word_1E0B2-DustDynPLC	; 5
		dc word_1E0B6-DustDynPLC	; 6
		dc word_1E0BA-DustDynPLC	; 7
		dc word_1E0BE-DustDynPLC	; 8
		dc word_1E0C2-DustDynPLC	; 9
		dc word_1E0C6-DustDynPLC	; A
		dc word_1E0CA-DustDynPLC	; B
		dc word_1E0CE-DustDynPLC	; C
		dc word_1E0D2-DustDynPLC	; D
		dc word_1E0D8-DustDynPLC	; E
		dc word_1E0DE-DustDynPLC	; F
		dc word_1E0E4-DustDynPLC	; 10
		dc word_1E0EA-DustDynPLC	; 11
		dc word_1E0EA-DustDynPLC	; 12
		dc word_1E0EA-DustDynPLC	; 13
		dc word_1E0EA-DustDynPLC	; 14
		dc word_1E0EC-DustDynPLC	; 15
word_1E0A0:	dc 0
word_1E0A2:	dc 1
		dc $7000
word_1E0A6:	dc 1
		dc $F008
word_1E0AA:	dc 1
		dc $F018
word_1E0AE:	dc 1
		dc $F028
word_1E0B2:	dc 1
		dc $F038
word_1E0B6:	dc 1
		dc $F048
word_1E0BA:	dc 1
		dc $7058
word_1E0BE:	dc 1
		dc $7060
word_1E0C2:	dc 1
		dc $7068
word_1E0C6:	dc 1
		dc $7070
word_1E0CA:	dc 1
		dc $7078
word_1E0CE:	dc 1
		dc $7080
word_1E0D2:	dc 2
		dc $1088
		dc $708A
word_1E0D8:	dc 2
		dc $3092
		dc $7096
word_1E0DE:	dc 2
		dc $509E
		dc $70A4
word_1E0E4:	dc 2
		dc $50AC
		dc $70B2
word_1E0EA:	dc 0
word_1E0EC:	dc 1
		dc $F0BA
		even