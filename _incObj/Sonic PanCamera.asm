; ---------------------------------------------------------------------------
; Subroutine to horizontally pan the camera view ahead of the player
; (Ported from the US version of Sonic CD's "R11A__.MMD" by Nat The Porcupine)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B    R O U T    I N E |||||||||||||||||||||||||||||||||||||||


Sonic_PanCamera:
		move.w	(v_unused7).w,d1		; get the current camera pan value

		move.w	obInertia(a0),d0		; get Sonic's ground speed
		btst	#1,obStatus(a0)			; is Sonic airborne?
		beq.s	is_grounded			; if not, branch
		move.w	obVelX(a0),d0			; use X velocity instead if airborne

	is_grounded:
		tst.w	d0				; check if speed is positive
		spl.b	d2				; remember whether our value was positive or negative (needed a bit further down below)
		bpl.s	abs_speed			; if yes, branch
		neg.w	d0				; otherwise, convert speed to an absolute value

	abs_speed:

; These lines were intended to prevent the Camera from panning while
; going up the very first giant ramp in Palmtree Panic Zone Act 1.
; However, given that no such object exists in Sonic 1, I just went
; ahead and commented these out.
;        btst    #1,$2C(a0)                ; is sonic going up a giant ramp in PPZ?
;        beq.s    skip                    ; if not, branch
;        cmpi.w    #$1B00,obX(a0)            ; is sonic's x position lower than $1B00?
;        bcs.s    reset_pan                ; if so, branch

        tst.b    $39(a0)                    ; is sonic charging up a spin dash?
        beq.s    skip                    ; if not, branch
        btst    #0,obStatus(a0)            ; check the direction that sonic is facing
        bne.s    pan_right                ; if he's facing right, pan the camera to the right
        bra.s    pan_left                ; otherwise, pan the camera to the left

    skip:
        cmpi.w    #$600,d0                ; is sonic's inertia greater than $600
        bcs.s    reset_pan                ; if not, recenter the screen (if needed)
        tst.b    d2	  	          ; check if the direction was positive or negative
        bne.s    pan_left                 ; if the direction was positive, then speed was negative, so we pan the screen left

    pan_right:
        addq.w    #2,d1                    ; add 2 to the pan value
        cmpi.w    #224,d1                    ; is the pan value greater than 224 pixels?
        bcs.s    update_pan                ; if not, branch
        move.w    #224,d1                    ; otherwise, cap the value at the maximum of 224 pixels
        bra.s    update_pan                ; branch
; ---------------------------------------------------------------------------

    pan_left:
        subq.w    #2,d1                    ; subtract 2 from the pan value
        cmpi.w    #96,d1                    ; is the pan value less than 96 pixels?
        bcc.s    update_pan                ; if not, branch
        move.w    #96,d1                    ; otherwise, cap the value at the minimum of 96 pixels
        bra.s    update_pan                ; branch
; ---------------------------------------------------------------------------

    reset_pan:
        cmpi.w    #160,d1                    ; is the pan value 160 pixels?
        beq.s    update_pan                ; if so, branch
        bcc.s    reset_left                ; otherwise, branch if it greater than 160
     
    reset_right:
        addq.w    #2,d1                    ; add 2 to the pan value
        bra.s    update_pan                ; branch
; ---------------------------------------------------------------------------

    reset_left:
        subq.w    #2,d1                    ; subtract 2 from the pan value

    update_pan:
        move.w    d1,(v_unused7).w        ; update the camera pan value
        rts                                ; return
     
; End of function Sonic_PanCamera