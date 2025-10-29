Sonic_HomingAttack:
        btst    #7,obStatus(a0)          ; was the homing attack flag already set?
        bne.s   .homeend                 ; if yes, branch
        moveq   #btnABC,d0               ; is any of the buttons ABC...
        and.b   (v_jpadpress2).w,d0      ; ...pressed?
        beq.s   .homeend                 ; if not, branch
        bset    #7,obStatus(a0)          ; set the homing attack flag

        move.w  #sfx_Teleport,d0         ; play dash sound as a test
        jsr     (PlaySound_Special).l          ; (PlaySound_Special in older disassemblies)

        bsr.s   FindHomingTarget         ; check if any homing targets are in range
        beq.s   RegularJumpdash          ; if not, do a regular jumpdash instead

        move.w  obX(a2),d1      ; load target object's X coordinate into d1
        move.w  obY(a2),d2      ; load target object's Y coordinate into d2
        sub.w   obX(a0),d1               ; subtract Sonic's X-pos from target X coordinate
        sub.w   obY(a0),d2               ; subtract Sonic's Y-pos from target Y coordinate
        jsr     CalcAngle                ; calculate the angle of Sonic to target - atan2 of (dx,dy)
        jsr     CalcSine                 ; calculate the sine (d0=Y-part) and cosine (d1=X-part) of the input angle in d0
        asl.w   #3,d0                    ; multiply Y-speed by 8
        asl.w   #3,d1                    ; multiply X-speed by 8
        move.w  d0,obVelY(a0)            ; set final result to Sonic's Y-speed
        move.w  d1,obVelX(a0)            ; set final result to Sonic's X-speed

.homeend:
        rts
; ===========================================================================

RegularJumpdash:
        clr.w   obVelY(a0)               ; reset Sonic's fall speed (i.e. Y-speed)
        move.w  #$C00,d0                 ; define our jumpdash X-speed
        btst    #0,obStatus(a0)          ; is Sonic facing left?
        beq.s   .notleft                 ; if not, branch
        neg.w   d0                       ; negate jumpdash speed
.notleft:
        move.w  d0,obVelX(a0)            ; set Sonic's X-speed
        rts
; ===========================================================================

FindHomingTarget:  
        moveq   #-1,d3                  ; initialize closest object distance to maximum
        lea     (v_lvlobjspace).w,a1    ; set a1 to the start of object RAM ($D800)
        moveq   #(v_lvlobjend-v_lvlobjspace)/object_size-1,d0 ; set loop count to all 96 objects (minus one for the first loop run)

.loop:
        tst.b   (a1)                    ; is the current object even initialized? (i.e. ID is not 0)
        beq.s   .next                   ; if it's a null object, go to next object
        move.b  obColType(a1),d1        ; load collision type to d1
        beq.s   .next                   ; if it has no collision type, invalid object
        cmpi.b  #$E,d1                  ; is this object's collision type $E or lower (badnik)?
        bls.s   .targetfound            ; if yes, target found
        cmpi.b  #$46,d1                 ; is this a monitor?
        bne.s   .next                   ; if not, branch
        cmpi.b  #2,obRoutine(a1)        ; is monitor still unbroken?
        bhi.s   .next                   ; if not, branch

.targetfound:
        move.w  obX(a1),d1              ; copy target object's X coordinate to d1
        sub.w   obX(a0),d1              ; subtract Sonic's X coordinate from it
        bpl.s   .xpos                   ; if result is positive, branch
        neg.w   d1                      ; make the X distance positive (abs)
.xpos:  cmpi.w  #150,d1                 ; is the X distance between Sonic and the object exceeding the maximum?
        bhi.s   .next                   ; if yes, too far away, branch

        move.w  obY(a1),d1              ; copy target object's Y coordinate to d1
        sub.w   obY(a0),d1              ; subtract Sonic's Y coordinate from it
        bpl.s   .ypos                   ; if result is positive, branch
        neg.w   d1                      ; make the Y distance positive (abs)
.ypos:  cmpi.w  #150,d1                 ; is the Y distance between Sonic and the object exceeding the maximum?
        bhi.s   .next                   ; if yes, too far away, branch

        move.w  obX(a1),d1              ; copy target object's X coordinate to d1
        sub.w   obX(a0),d1              ; subtract Sonic's X coordinate from it
        bpl.s   .objright               ; branch if positive (d1 = positive if object is to the right of Sonic, negative if to the left)
        ; object is to the left of Sonic
        btst    #0,obStatus(a0)         ; is Sonic looking to the left (towards the object)?
        beq.s   .next                   ; if not, branch
        bra.s   .targetvalid            ; if yes, Sonic is looking at the object
.objright:
        ; object is to the right of Sonic
        btst    #0,obStatus(a0)         ; is Sonic looking to the right (towards the object)?
        bne.s   .next                   ; if not, branch

.targetvalid:
        move.w  obX(a1),d1              ; x_target
        sub.w   obX(a0),d1              ; x_sonic
        muls.w  d1,d1                   ; squared
        move.w  obY(a1),d2              ; y_target
        sub.w   obY(a0),d2              ; y_sonic
        muls.w  d2,d2                   ; squared
        add.l   d2,d1                   ; d1 = (x_target - x_sonic)^2 + (y_target - y_sonic)^2
        bpl.s   .checkcloser            ; branch if the result in d1 is already positive
        neg.l   d1                      ; make positive (abs)
.checkcloser:
        cmp.l   d3,d1                   ; is new distance smaller than a previously found target?
        bhs.s   .next                   ; if not, branch
        move.l  d1,d3                   ; remember distance for this object
        movea.l a1,a2                   ; remember address of the target object in a2

.next:
        adda.w  #object_size,a1         ; increase a1 to go to next object (i.e. +$40)
        dbf     d0,.loop                ; loop until we've gone through all objects

        addq.l  #1,d3                   ; was any target found? (this sets the Z flag when d3=$FFFFFFFF, clear if different)
        rts                             ; return with our results