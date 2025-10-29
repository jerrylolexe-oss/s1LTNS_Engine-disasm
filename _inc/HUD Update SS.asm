; ---------------------------------------------------------------------------
; Subroutine to	update the HUD in the Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HUD_Update_SS:
		lea		(vdp_data_port).l,a6
		tst.w	(v_debuguse).w				; is debug mode	on?
		bne.w	HudDebug_SS					; if yes, branch
		tst.b	(f_scorecount).w			; does the score need updating?
		beq.s	.chkrings					; if not, branch

		clr.b	(f_scorecount).w
		locVRAM	(ArtTile_SS_HUD+$18)*tile_size,d0	; ($4220) set VRAM address -- RetroKoH VRAM Overhaul		
		move.l	(v_score).w,d1				; load score
		bsr.w	Hud_Score

.chkrings:
		tst.b	(f_ringcount).w				; does the ring	counter	need updating?
		beq.s	.chktime					; if not, branch
		bpl.s	.notzero
		bsr.w	Hud_LoadZero_SS				; reset rings count to 0

.notzero:
		clr.b	(f_ringcount).w
		locVRAM	(ArtTile_SS_HUD+$2E)*tile_size,d0	; ($44E0) set VRAM address -- RetroKoH VRAM Overhaul
		moveq	#0,d1
		move.w	(v_rings).w,d1				; load number of rings
		bsr.w	Hud_Rings

.chktime:
		tst.b	(f_timecount).w				; does the time	need updating?
		beq.w	.chklives					; if not, branch
		tst.b	(f_pause).w					; is the game paused?
		bne.w	.chklives					; if yes, branch
		lea		(v_time).w,a1

.updatetime:
		locVRAM	(ArtTile_SS_HUD+$26)*tile_size,d0				; ($43E0) set VRAM address -- RetroKoH VRAM Overhaul
		moveq	#0,d1
		move.b	(v_timemin).w,d1						; load minutes
		bsr.w	Hud_Mins
		locVRAM	(ArtTile_SS_HUD+$2A)*tile_size,d0				; ($4460) set VRAM address -- RetroKoH VRAM Overhaul
		moveq	#0,d1
		move.b	(v_timesec).w,d1						; load seconds
		bsr.w	Hud_Secs
		
.chklives:
		tst.b	(f_lifecount).w							; does the lives counter need updating?
		beq.s	.finish									; if not, branch
		clr.b	(f_lifecount).w
		bsr.w	Hud_Lives_SS

.finish:
		rts	
; ===========================================================================

TimeOver_SS:				; XREF: Hud_ChkTime_SS
		clr.b	(f_timecount).w							; stop the time counter
		rts	
; ===========================================================================

HudDebug_SS:				; XREF: HUD_Update
		bsr.w	HudDb_XY_SS
		tst.b	(f_ringcount).w							; does the ring	counter	need updating?
		beq.s	.objcounter								; if not, branch
		bpl.s	.notzero
		bsr.w	Hud_LoadZero_SS

.notzero:
		clr.b	(f_ringcount).w
		locVRAM	(ArtTile_SS_HUD+$2E)*tile_size,d0				; ($44E0) set VRAM address -- RetroKoH VRAM Overhaul	
		moveq	#0,d1
		move.w	(v_rings).w,d1							; load number of rings
		bsr.w	Hud_Rings

.objcounter:
		locVRAM	(ArtTile_SS_HUD+$2A)*tile_size,d0				; ($4460) set VRAM address -- RetroKoH VRAM Overhaul
		moveq	#0,d1
		move.b	(v_spritecount).w,d1					; load "number of objects" counter
		bsr.w	Hud_Secs
		tst.b	(f_lifecount).w							; does the lives counter need updating?
		beq.s	.finish									; if not, branch
		clr.b	(f_lifecount).w
		bsr.w	Hud_Lives_SS

.finish:
		rts	
; End of function HUD_Update_SS

; ---------------------------------------------------------------------------
; Subroutine to	load "0" on the	HUD in the Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_LoadZero_SS:				; XREF: HUD_Update_SS
		locVRAM	(ArtTile_SS_HUD+$32)*tile_size				; ($4560) set VRAM address -- RetroKoH VRAM Overhaul	
		lea		Hud_TilesZero(pc),a2
		moveq	#2,d2									; Optimized from move.w
		bra.w	loc_1C83E
; End of function Hud_LoadZero_SS
; ---------------------------------------------------------------------------
; Subroutine to	load uncompressed HUD patterns ("E", "0", colon) in Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_Base_SS:				; XREF: GM_Special
		lea		(vdp_data_port).l,a6
		bsr.w	Hud_Lives_SS
		locVRAM	(ArtTile_SS_HUD+$16)*tile_size				; ($41E0) set VRAM address -- RetroKoH VRAM Overhaul
		lea		Hud_TilesBase(pc),a2
		moveq	#$E,d2									; Optimized from move.w
		bra.w	loc_1C83E
; End of function Hud_Base_SS

; ---------------------------------------------------------------------------
; Subroutine to	load debug mode	numbers	patterns in Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HudDb_XY_SS:				; XREF: HudDebug_SS
		locVRAM	(ArtTile_SS_HUD+$16)*tile_size				; ($41E0) set VRAM address -- RetroKoH VRAM Overhaul
		move.w	(v_screenposx).w,d1 ; load camera x-position
		swap	d1
		move.w	(v_player+obX).w,d1 ; load Sonic's x-position
		bsr.w	HudDb_XY2
		move.w	(v_screenposy).w,d1 ; load camera y-position
		swap	d1
		move.w	(v_player+obY).w,d1 ; load Sonic's y-position
		bra.w	HudDb_XY2
; End of function HudDb_XY_SS

; ---------------------------------------------------------------------------
; Subroutine to	load uncompressed lives	counter	patterns in Special Stage
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hud_Lives_SS:				; XREF: Hud_ChkLives_SS
		locVRAM	(ArtTile_SS_Lives+9)*tile_size,d0		; ($4700) set VRAM address
		moveq	#0,d1
		move.b	(v_lives).w,d1					; load number of lives
		lea		Hud_10(pc),a2					; Optimized from (Hud_10).l
		moveq	#1,d6
		moveq	#0,d4
		lea		Art_LivesNums(pc),a1
		bra.w	Hud_LivesLoop
		;rts
; End of function Hud_Lives_SS