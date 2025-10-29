; ---------------------------------------------------------------------------
; Subroutine to load VDP commands into the DMA transfer queue
;
; In case you wish to use this queue system outside of the spin dash, this is the
; registers in which it expects data in:
; d1.l: Address to data (In 68k address space)
; d2.w: Destination in VRAM
; d3.w: Length of data
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


DMA_68KtoVRAM:				; XREF: LoadSonicDynPLC; LoadDustDynPLC
		movea.l	(v_sgfx_buffer+$FC).w,a1
		cmpa.w	#v_sgfx_buffer+$FC,a1	; is the DMA queue full?
		beq.s	DMA_68KtoVRAM_Done ; return if there's no more room in the buffer

		; piece together some VDP commands and store them for later...
		move.w	#$9300,d0	; command to specify DMA transfer length & $00FF
		move.b	d3,d0
		move.w	d0,(a1)+	; store command

		move.w	#$9400,d0	; command to specify DMA transfer length & $FF00
		lsr.w	#8,d3
		move.b	d3,d0
		move.w	d0,(a1)+	; store command

		move.w	#$9500,d0	; command to specify source address & $0001FE
		lsr.l	#1,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; store command

		move.w	#$9600,d0	; command to specify source address & $01FE00
		lsr.l	#8,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; store command

		move.w	#$9700,d0	; command to specify source address & $FE0000
		lsr.l	#8,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; store command

		andi.l	#$FFFF,d2	; command to specify destination address and begin DMA
		lsl.l	#2,d2
		lsr.w	#2,d2
		swap	d2
		ori.l	#$40000080,d2 ; set bits to specify VRAM transfer
		move.l	d2,(a1)+	; store command

		move.l	a1,(v_sgfx_buffer+$FC).w ; set the next free slot address
		cmpa.w	#v_sgfx_buffer+$FC,a1	; has the end of the queue been reached?
		beq.s	DMA_68KtoVRAM_Done ; return if there's no more room in the buffer
		move.w	#0,(a1) ; put a stop token at the end of the used part of the buffer

DMA_68KtoVRAM_Done:			; XREF: DMA_68KtoVRAM
		rts
; End of function DMA_68KtoVRAM

; ---------------------------------------------------------------------------
; Process all VDP commands and then reset the DMA queue when it's done
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Process_DMA:
		lea	(vdp_control_port).l,a5
		lea	(v_sgfx_buffer).w,a1

Process_DMA_Loop:			; XREF: Process_DMA
		move.w	(a1)+,d0	; has a stop token been encountered?
		beq.s	Process_DMA_Done ; branch if we reached a stop token

		; issue a set of VDP commands...
		move.w	d0,(a5)		; transfer length
		move.w	(a1)+,(a5)	; transfer length
		move.w	(a1)+,(a5)	; source address
		move.w	(a1)+,(a5)	; source address
		move.w	(a1)+,(a5)	; source address
		move.w	(a1)+,(a5)	; destination
		move.w	(a1)+,(a5)	; destination
		cmpa.w	#v_sgfx_buffer+$FC,a1	; has the end of the queue been reached?
		bne.s	Process_DMA_Loop ; loop if we haven't reached the end of the buffer

Process_DMA_Done:			; XREF: Process_DMA
		move.w	#0,(v_sgfx_buffer).w
		move.l	#v_sgfx_buffer,(v_sgfx_buffer+$FC).w
		rts
; End of function Process_DMA