; ===========================================================================
; MSU Mode Related
; ===========================================================================
MSUMode	= 0	; if 1, enable MSU Mode.
; ===========================================================================
; SHC Related
; ===========================================================================
SHCScreen	= 1	; if 1, enable SHC screen.
; ===========================================================================
; SRAM Related
; ===========================================================================
EnableSRAM	  = 1	; change to 1 to enable SRAM.
BackupSRAM	  = 1
AddressSRAM	  = 0	; 0 = odd+even; 2 = even only; 3 = odd only
; ===========================================================================
; Revisions Related
; ===========================================================================
; Change to 0 to build the original version of the game, dubbed REV00.
; Change to 1 to build the later vesion, dubbed REV01, which includes various bugfixes and enhancements.
; Change to 2 to build the version from Sonic Mega Collection, dubbed REVXB, which fixes the infamous "spike bug".
Revision	  = 2
; ===========================================================================
; Drums Related
; ===========================================================================
KCDrums	  = 1 ; If 1, toggle drums into KC drums.
CleanS3DAC	  = 1 ; If 1, toggle drums into KC drums.
; ===========================================================================
; Zone Count Related
; ===========================================================================
ZoneCount	  = 6	; Discrete zones are: GHZ, MZ, SYZ, LZ, SLZ, and SBZ.
; ===========================================================================
; Bugfixes Related
; ===========================================================================
FixBugs		  = 1	; Change to 1 to enable bugfixes.
; ===========================================================================
; Zero offset-Related
; ===========================================================================
zeroOffsetOptimization = 1	; If 1, makes a handful of zero-offset instructions smaller.
; ===========================================================================
; Debug-Related
; ===========================================================================
DEBUGROM	  = 0 ; If 1, toggle to Debugging build.
; ===========================================================================
; Level Select Related
; ===========================================================================
ASCIILevsel = 1 ; If 1, toggle ASCII Level Select.
; ===========================================================================
; Skip Sonic from running in the end of the level.
; ===========================================================================
SkipSonicRun	  = 1 ; If 1, skip Sonic from going to the end.
; ===========================================================================
; Leap Animation Toggle
; ===========================================================================
EnableLeapAni		  = 1 ; If 1, enable leap animation when jumping at the end of the level.
; ===========================================================================
; Toggle Spindash https://info.sonicretro.org/SCHG_How-to:Add_Spin_Dash_to_Sonic_1/Part_1
; ===========================================================================
SpindashToggle		= 1 ; If 1, enable spin-dash from later games.
; ===========================================================================
; Toggle Peelout https://sonicresearch.org/community/index.php?threads/how-to-create-a-simple-peelout-from-scratch.7260/
; ===========================================================================
PeeloutToggle		= 1 ; If 1, enable spin-dash from later games.
PeeloutSpeedToggle		= 1 ; If 1, enable spin-dash from later games.
	PeeloutSpeed: = $80|PeeloutToggle	; horizontal range in pixels at which Sonic is noticed by the Orbinaut
	PeeloutMaxSpeed: = $1000|PeeloutToggle	; animation speed of the Orbinaut's "getting angry" animation
;	PeeloutSpeed: = $100|PeeloutToggle	; horizontal range in pixels at which Sonic is noticed by the Orbinaut
;	PeeloutMaxSpeed: = $4000|PeeloutToggle	; animation speed of the Orbinaut's "getting angry" animation
; ===========================================================================
; Toggle Air Roll https://info.sonicretro.org/SCHG_How-to:Add_the_Air_Roll/Flying_Spin_Attack
; ===========================================================================
AirRoll		= 1 ; If 1, enable air roll from Sonic Triple Trouble.
; ===========================================================================
; Toggle unlock controls at Ending sequence
; ===========================================================================
FreeCtrlEnding = 1
; ===========================================================================
; Special Stage tweaks
; ===========================================================================
SpecialStageTweaks = 1 ; If 1, toggle some tweaks in the Special Stage.
; ===========================================================================
; Toggle shrink animation
; ===========================================================================
ShrinkAnimation = 1|SpecialStageTweaks
; ===========================================================================
; Smooth SS Wall rotate
; ===========================================================================
SmoothSSRotate = 1|SpecialStageTweaks
; ===========================================================================
; CD Camera
; ===========================================================================
PanCamera = 1
; ===========================================================================
; SEGA screen fade in
; ===========================================================================
SEGAScreenFadeIn = 1