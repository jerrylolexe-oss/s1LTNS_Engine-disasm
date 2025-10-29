; ---------------------------------------------------------------------------
; Palette pointers
; ---------------------------------------------------------------------------

palp:	macro desinationPaletteLine,sourceAddress
	dc.l sourceAddress
	dc.w v_palette+desinationPaletteLine*$10*2,(sourceAddress_end-sourceAddress)/4-1
	endm

PalPointers:

; palette address, RAM address, colours

ptr_Pal_SegaBG:			palp	0,Pal_SegaBG	; 0 - Sega logo
ptr_Pal_Title:			palp	0,Pal_Title		; 1 - title screen
ptr_Pal_LevelSel:		palp	0,Pal_LevelSel	; 2 - level select
ptr_Pal_Sonic:			palp	0,Pal_Sonic		; 3 - Sonic
Pal_Levels:
ptr_Pal_GHZ1:			palp	1,Pal_GHZ1		; 4 - GHZ1
ptr_Pal_GHZ2:			palp	1,Pal_GHZ2		; 5 - GHZ2
ptr_Pal_GHZ3:			palp	1,Pal_GHZ3		; 6 - GHZ3
ptr_Pal_LZ1:			palp	1,Pal_LZ1		; 7 - LZ1
ptr_Pal_LZ2:			palp	1,Pal_LZ2		; 8 - LZ2
ptr_Pal_LZ3:			palp	1,Pal_LZ3		; 9 - LZ3
ptr_Pal_SBZ3:			palp	1,Pal_SBZ3		; $18 (24) - SBZ3
ptr_Pal_MZ1:			palp	1,Pal_MZ1		; $A (10) - MZ1
ptr_Pal_MZ2:			palp	1,Pal_MZ2		; $B (11) - MZ2
ptr_Pal_MZ3:			palp	1,Pal_MZ3		; $C (12) - MZ3
ptr_Pal_SLZ1:			palp	1,Pal_SLZ1		; $D (13) - SLZ1
ptr_Pal_SLZ2:			palp	1,Pal_SLZ2		; $E (14) - SLZ2
ptr_Pal_SLZ3:			palp	1,Pal_SLZ3		; $F (15) - SLZ3
ptr_Pal_SYZ1:			palp	1,Pal_SYZ1		; $10 (16) - SYZ1
ptr_Pal_SYZ2:			palp	1,Pal_SYZ2		; $11 (17) - SYZ2
ptr_Pal_SYZ3:			palp	1,Pal_SYZ3		; $12 (18) - SYZ3
ptr_Pal_SBZ1:			palp	1,Pal_SBZ1		; $13 (19) - SBZ1
ptr_Pal_Special:		palp	0,Pal_Special	; $14 (20) - special stage
ptr_Pal_LZWater1:		palp	0,Pal_LZWater1	; $15 (21) - LZ1 underwater
ptr_Pal_LZWater2:		palp	0,Pal_LZWater2	; $16 (22) - LZ2 underwater
ptr_Pal_LZWater3:		palp	0,Pal_LZWater3	; $17 (23) - LZ3 underwater
ptr_Pal_SBZ3Water:		palp	0,Pal_SBZ3Water	; $19 (25) - SBZ3 underwater
ptr_Pal_SBZ2:			palp	1,Pal_SBZ2		; $1A (26) - SBZ2
ptr_Pal_LZSonWater1:	palp	0,Pal_LZSonWater1	; $1B (27) - LZ1 Sonic underwater
ptr_Pal_LZSonWater2:	palp	0,Pal_LZSonWater2	; $1C (28) - LZ2 Sonic underwater
ptr_Pal_LZSonWater3:	palp	0,Pal_LZSonWater3	; $1D (29) - LZ3 Sonic underwater
ptr_Pal_SBZ3SonWat:		palp	0,Pal_SBZ3SonWat	; $1E (30) - SBZ3 Sonic underwater
ptr_Pal_SSResult:		palp	0,Pal_SSResult	; $1F (31) - special stage results
ptr_Pal_Continue:		palp	0,Pal_Continue	; $20 (32) - special stage results continue
ptr_Pal_Ending:		palp	0,Pal_Ending	; $21 (33) - ending sequence
			even


palid_SegaBG:		equ (ptr_Pal_SegaBG-PalPointers)/8
palid_Title:		equ (ptr_Pal_Title-PalPointers)/8
palid_LevelSel:		equ (ptr_Pal_LevelSel-PalPointers)/8
palid_Sonic:		equ (ptr_Pal_Sonic-PalPointers)/8
palid_GHZ1:			equ (ptr_Pal_GHZ1-PalPointers)/8
palid_GHZ2:			equ (ptr_Pal_GHZ2-PalPointers)/8
palid_GHZ3:			equ (ptr_Pal_GHZ3-PalPointers)/8
palid_LZ1:			equ (ptr_Pal_LZ1-PalPointers)/8
palid_LZ2:			equ (ptr_Pal_LZ2-PalPointers)/8
palid_LZ3:			equ (ptr_Pal_LZ3-PalPointers)/8
palid_MZ1:			equ (ptr_Pal_MZ1-PalPointers)/8
palid_MZ2:			equ (ptr_Pal_MZ2-PalPointers)/8
palid_MZ3:			equ (ptr_Pal_MZ3-PalPointers)/8
palid_SLZ1:			equ (ptr_Pal_SLZ1-PalPointers)/8
palid_SLZ2:			equ (ptr_Pal_SLZ2-PalPointers)/8
palid_SLZ3:			equ (ptr_Pal_SLZ3-PalPointers)/8
palid_SYZ1:			equ (ptr_Pal_SYZ1-PalPointers)/8
palid_SYZ2:			equ (ptr_Pal_SYZ2-PalPointers)/8
palid_SYZ3:			equ (ptr_Pal_SYZ3-PalPointers)/8
palid_SBZ1:			equ (ptr_Pal_SBZ1-PalPointers)/8
palid_Special:		equ (ptr_Pal_Special-PalPointers)/8
palid_LZWater1:		equ (ptr_Pal_LZWater1-PalPointers)/8
palid_LZWater2:		equ (ptr_Pal_LZWater2-PalPointers)/8
palid_LZWater3:		equ (ptr_Pal_LZWater3-PalPointers)/8
palid_SBZ3:			equ (ptr_Pal_SBZ3-PalPointers)/8
palid_SBZ3Water:	equ (ptr_Pal_SBZ3Water-PalPointers)/8
palid_SBZ2:			equ (ptr_Pal_SBZ2-PalPointers)/8
palid_LZSonWater1:	equ (ptr_Pal_LZSonWater1-PalPointers)/8
palid_LZSonWater2:	equ (ptr_Pal_LZSonWater2-PalPointers)/8
palid_LZSonWater3:	equ (ptr_Pal_LZSonWater3-PalPointers)/8
palid_SBZ3SonWat:	equ (ptr_Pal_SBZ3SonWat-PalPointers)/8
palid_SSResult:		equ (ptr_Pal_SSResult-PalPointers)/8
palid_Continue:		equ (ptr_Pal_Continue-PalPointers)/8
palid_Ending:		equ (ptr_Pal_Ending-PalPointers)/8