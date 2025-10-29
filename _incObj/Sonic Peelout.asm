Sonic_Peelout:
;		move.b	#id_PeeloutTransition,obAnim(a0)	; set Spin Dash anim to fix the monitor bug
        btst     #1,$39(a0)             ; is peelout currently being charged up?
        bne.s    .charge_peelout        ; if yes, branch to a different code section
     
        ; peelout init check
        btst     #bitUp,(v_jpadhold2).w ; is the Up button held?
        beq.s    .nopeel                ; if not, branch
        moveq    #btnABC,d0             ; are buttons ABC...
        and.b    (v_jpadpress2).w,d0    ; ...pressed?
        beq.s    .nopeel                ; if not, branch
        cmpi.b   #id_LookUp,obAnim(a0)  ; is Sonic in his looking-up animation?
        bne.s    .nopeel                ; if not, branch
        bset     #1,$39(a0)             ; set spindash/peelout flag
        clr.b    obAnim(a0)             ; reset Sonic's animation
        addq.l   #4,sp                  ; skip rest in MdNormal
        move.w   #sfx_Peelout,d0           ; play roll sound
        jmp      (PlaySound_Special).l        ; (will be replaced later)
.nopeel:
        rts
; ===========================================================================

.charge_peelout:
		move.b	#id_PeeloutTransition,obAnim(a0)	; set Spin Dash anim to fix the monitor bug
        btst     #bitUp,(v_jpadhold2).w ; is the Up button STILL held?
        beq.s    .release_peelout       ; if not, release peelout

		if PeeloutSpeedToggle
        add.w    #PeeloutSpeed,obInertia(a0)     ; add $40 charge to peelout speed per frame\
		else
        add.w    #$40,obInertia(a0)     ; add $40 charge to peelout speed per frame
		endif
		if PeeloutToggle
        move.w   #PeeloutMaxSpeed,d0              ; define max speed
		else
        move.w   #$1000,d0              ; define max speed
		endif
        cmp.w    obInertia(a0),d0       ; did charge speed exceed maximum?
        bge.s    .nocap                 ; if not, branch
        move.w   d0,obInertia(a0)       ; cap max speed
.nocap:
 
        bsr.w    Sonic_LevelBound       ; keep checking for level boundaries
        bsr.w    Sonic_AnglePos         ; make sure Sonic uses the correct angled sprites on a slope
        move.w   #$60,(v_lookshift).w   ; reset looking up/down
        addq.l   #4,sp                  ; skip rest in MdNormal
        rts                             ; don't do anything else
; ===========================================================================

.release_peelout:
        cmpi.w   #$600,obInertia(a0)    ; was minimum speed reached?
        bge.s    .speedok               ; if yes, branch
        clr.w    obInertia(a0)          ; kill whatever little speed we've built up
        clr.b    $39(a0)                ; reset spindash/peelout flag
        rts                             ; don't do anything else
.speedok:
        btst     #0,obStatus(a0)        ; is Sonic looking to the left?
        beq.s    .notleft               ; if not, branch
        neg.w    obInertia(a0)          ; negate final speed
.notleft:
        clr.b    $39(a0)                ; reset spindash/peelout flag
        move.w   #sfx_Teleport,d0       ; play teleport/dash sound
        jmp      (PlaySound_Special).l