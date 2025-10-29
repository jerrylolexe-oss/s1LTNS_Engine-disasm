; ---------------------------------------------------------------------------
; Music metadata (pointers, speed shoes tempos, flags)
; ---------------------------------------------------------------------------
; byte_71A94: SpeedUpIndex:
MusicIndex:
ptr_mus81:	SMPS_MUSIC_METADATA	Music81, s1TempotoS3($07), 0	; GHZ1
ptr_mus82:	SMPS_MUSIC_METADATA	Music94, s1TempotoS3($07), 0	; GHZ2
ptr_mus83:	SMPS_MUSIC_METADATA	Music9A, s1TempotoS3($07), 0	; GHZ3
ptr_mus84:	SMPS_MUSIC_METADATA	MusicA0, s1TempotoS3($07), 0	; GHZ4
ptr_mus85:	SMPS_MUSIC_METADATA	Music82, s1TempotoS3($72), 0	; LZ1
ptr_mus86:	SMPS_MUSIC_METADATA	Music95, s1TempotoS3($72), 0	; LZ2
ptr_mus87:	SMPS_MUSIC_METADATA	Music9B, s1TempotoS3($72), 0	; LZ3
ptr_mus88:	SMPS_MUSIC_METADATA	MusicA1, s1TempotoS3($72), 0	; LZ4
ptr_mus89:	SMPS_MUSIC_METADATA	Music83, s1TempotoS3($73), 0	; MZ1
ptr_mus8A:	SMPS_MUSIC_METADATA	Music96, s1TempotoS3($73), 0	; MZ2
ptr_mus8B:	SMPS_MUSIC_METADATA	Music9C, s1TempotoS3($73), 0	; MZ3
ptr_mus8C:	SMPS_MUSIC_METADATA	MusicA2, s1TempotoS3($73), 0	; MZ4
ptr_mus8D:	SMPS_MUSIC_METADATA	Music84, s1TempotoS3($26), 0	; SLZ1
ptr_mus8E:	SMPS_MUSIC_METADATA	Music97, s1TempotoS3($26), 0	; SLZ2
ptr_mus8F:	SMPS_MUSIC_METADATA	Music9D, s1TempotoS3($26), 0	; SLZ3
ptr_mus90:	SMPS_MUSIC_METADATA	MusicA3, s1TempotoS3($26), 0	; SLZ4
ptr_mus91:	SMPS_MUSIC_METADATA	Music85, s1TempotoS3($15), 0	; SYZ1
ptr_mus92:	SMPS_MUSIC_METADATA	Music98, s1TempotoS3($15), 0	; SYZ2
ptr_mus93:	SMPS_MUSIC_METADATA	Music9E, s1TempotoS3($15), 0	; SYZ3
ptr_mus94:	SMPS_MUSIC_METADATA	MusicA4, s1TempotoS3($15), 0	; SYZ4
ptr_mus95:	SMPS_MUSIC_METADATA	Music86, s1TempotoS3($08), 0	; SBZ1
ptr_mus96:	SMPS_MUSIC_METADATA	Music99, s1TempotoS3($08), 0	; SBZ2
ptr_mus97:	SMPS_MUSIC_METADATA	Music9F, s1TempotoS3($08), 0	; SBZ3
ptr_mus98:	SMPS_MUSIC_METADATA	MusicA5, s1TempotoS3($08), 0	; SBZ4
ptr_mus99:	SMPS_MUSIC_METADATA	Music87, s1TempotoS3($FF), 0	; Invincible
ptr_mus9A:	SMPS_MUSIC_METADATA	Music88, s1TempotoS3($05), 0	; Extra Life
ptr_mus9B:	SMPS_MUSIC_METADATA	Music89, s1TempotoS3($08), 0	; Special Stage
ptr_mus9C:	SMPS_MUSIC_METADATA	Music8A, s1TempotoS3($05), 0	; Title Screen
ptr_mus9D:	SMPS_MUSIC_METADATA	Music8B, s1TempotoS3($05), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Ending
ptr_mus9E:	SMPS_MUSIC_METADATA	Music8C, s1TempotoS3($04)-$20, 0	; Boss
ptr_mus9F:	SMPS_MUSIC_METADATA	Music8D, s1TempotoS3($06)-$20, 0	; Final Zone
ptr_musA0:	SMPS_MUSIC_METADATA	Music8E, s1TempotoS3($03), 0	; End of Act
ptr_musA1:	SMPS_MUSIC_METADATA	Music8F, s1TempotoS3($13), 0	; Game Over
ptr_musA2:	SMPS_MUSIC_METADATA	Music90, s1TempotoS3($07), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Continue
ptr_musA3:	SMPS_MUSIC_METADATA	Music91, s1TempotoS3($33), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Credits
ptr_musA4:	SMPS_MUSIC_METADATA	Music92, s1TempotoS3($02), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Drowning
ptr_musA5:	SMPS_MUSIC_METADATA	Music93, s1TempotoS3($33), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Emerald
ptr_musA6:	SMPS_MUSIC_METADATA	MusicA6, s1TempotoS3($02), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Level Select
ptr_musend

; ---------------------------------------------------------------------------
; Music data
; ---------------------------------------------------------------------------

Music81:		include "Sound/Music/Act 1/GHZ.asm"
	even
Music82:		include "Sound/Music/Act 1/LZ.asm"
	even
Music83:		include "Sound/Music/Act 1/MZ.asm"
	even
Music84:		include "Sound/Music/Act 1/SLZ.asm"
	even
Music85:		include "Sound/Music/Act 1/SYZ.asm"
	even
Music86:		include "Sound/Music/Act 1/SBZ.asm"
	even
Music87:		include "Sound/Music/Mus87 - Invincibility.asm"
	even
Music88:		include "Sound/Music/Mus88 - Extra Life.asm"
	even
Music89:		include "Sound/Music/Mus89 - Special Stage.asm"
	even
Music8A:		include "Sound/Music/Mus8A - Title Screen.asm"
	even
Music8B:		include "Sound/Music/Mus8B - Ending.asm"
	even
Music8C:		include "Sound/Music/Mus8C - Boss.asm"
	even
Music8D:		include "Sound/Music/Mus8D - FZ.asm"
	even
Music8E:		include "Sound/Music/Mus8E - Sonic Got Through.asm"
	even
Music8F:		include "Sound/Music/Mus8F - Game Over.asm"
	even
Music90:		include "Sound/Music/Mus90 - Continue Screen.asm"
	even
Music91:		include "Sound/Music/Mus91 - Credits.asm"
	even
Music92:		include "Sound/Music/Mus92 - Drowning.asm"
	even
Music93:		include "Sound/Music/Mus93 - Get Emerald.asm"
	even
Music94:		include "Sound/Music/Act 2/GHZ.asm"
	even
Music95:		include "Sound/Music/Act 2/LZ.asm"
	even
Music96:		include "Sound/Music/Act 2/MZ.asm"
	even
Music97:		include "Sound/Music/Act 2/SLZ.asm"
	even
Music98:		include "Sound/Music/Act 2/SYZ.asm"
	even
Music99:		include "Sound/Music/Act 2/SBZ.asm"
	even
Music9A:		include "Sound/Music/Act 3/GHZ.asm"
	even
Music9B:		include "Sound/Music/Act 3/LZ.asm"
	even
Music9C:		include "Sound/Music/Act 3/MZ.asm"
	even
Music9D:		include "Sound/Music/Act 3/SLZ.asm"
	even
Music9E:		include "Sound/Music/Act 3/SYZ.asm"
	even
Music9F:		include "Sound/Music/Act 3/SBZ.asm"
	even
MusicA0:		include "Sound/Music/Act 4/GHZ.asm"
	even
MusicA1:		include "Sound/Music/Act 4/LZ.asm"
	even
MusicA2:		include "Sound/Music/Act 4/MZ.asm"
	even
MusicA3:		include "Sound/Music/Act 4/SLZ.asm"
	even
MusicA4:		include "Sound/Music/Act 4/SYZ.asm"
	even
MusicA5:		include "Sound/Music/Act 4/SBZ.asm"
	even
MusicA6:		include "Sound/Music/Mus94 - Level Select.asm"
	even