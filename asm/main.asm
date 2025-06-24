arch snes.cpu

define  current_line_index  $28
define  b_script_index  	$44
define 	Dictionary_Len		$4e
define 	Dict_Item_Loc		$4146
define 	Dict_Item_Loc1		$4147
define 	Dict_Item_Loc2		$4148
define 	Dict_Item_Loc3		$4149
define 	Dict_Item_Loc4		$414a

define 	Script_EN			$4239
define	Character 			$418b //$7e418b
define	ButtonFlags			$4140
define	NameCrdPitch		$59
define	NameCrdColor		$4d
define	NameCrdSpeed		$45 //$145


define 	ScriptID1			$17a
define 	ScriptID2			$17b

define  LineNumber			$4a
define  LineBreakTable	  	$f949
define 	CharValue			$418a

define 	DiatricBottom		$3E

///// Custom
// Arbitrarily chosen RAM addresses. May cause graphical glitches
define 	CustVoiceCounter	$ff		//$1fe

define	VoiceCounterMask	#$01



table "./asm/tbl/CHR - New.tbl"

//==============================
//Enable debug mode
//==============================
org $140423
//db $50

//==============================
//Ch 2: Pilot reveal pause removal (Script Engine)
//(Childless)
//==============================
org $14247e ;base $28a47e
db $0a //originally $f7

//==============================
//No indent - dialogue v3
//==============================
org $1E732; base $83E732; fill $08, $ea

//==============================
//Text speed A
//==============================
org $1e75e; base $83e75e
jmp TextSpeed
TextSpeedRet:

//==============================
//No auto-linebreak (General)
//(Childless)
//==============================
org $1eaf1; base $83eaf1; fill $03, $ea

//==============================
//Skip voice A
//==============================

org $1a67c; base $83a67c
jsr SkipVoice
jmp MaxBSpeed

//==============================
//Dialogue pointer => lorom pointer
//==============================

org $1b414; base $83b414; fill $0f, $ea
org $1b414; base $83b414
lda $07
sta $03

lda $09
sta $05

lda $08
sta $04

//==============================
//No indent fullscreen A
//==============================
org $1e947; base $83e947
jmp NoIndentFullScreen

//==============================
//No auto-linebreak (Fullscreen)
//(Childless)
//==============================

org $1e86c; base $83e86c; fill $0a, $ea
org $1e86c; base $83e86c
jmp $e855

//==============================
//Text speed A (Fullscreen)
//==============================
org $1e9c3; base $83e9c3; fill $04, $ea
org $1e9c3; base $83e9c3
jsr TextSpeedFullScreen

//==============================
//8x16 font (Scrolling)
//==============================
// When preforming scrolling, the game blanks out
// the area for diatrics. This removes this logic.
org $1EC2E; base $83EC2e; fill $03, $ea
org $1EC2E; base $83EC2e
jsr Font8x16Diatric

//==============================
//8x16 font
//==============================
org $1EBBB; base $83EBBB; fill $26, $ea
org $1EBBB; base $83EBBB
jsr Font8x16
rts

//==============================
//8x16 font (Menu options) A
//==============================
org $1B655; base $83b655; fill $05, $ea
org $1B655; base $83b655
jsr Font8x16Menu

// Remove diatric logic that overwrites the upper part of the text
org $01B636; base $83B636; fill $03, $ea

//==============================
//8x16 font (Numbering) A
//==============================
org $1AFC1; base $83AFC1; fill $0B, $ea
org $1AFC1; base $83AFC1
jsr Font8x16Numbering

org $06CE9; base $7EECE9
db "1",$10,"2",$10,"3",$10,"4",$10,"5",$10,"6",$10,"7",$10,"8",$10,$FE,"9",$10
db "10",$10,"11",$10,"12",$10,"13",$10,"14",$10,"15",$10,"16"

//==============================
//8x16 font (Password screen)
//==============================
org $1E888; base $83E888; fill $17, $ea
org $1E888; base $83E888
lda $4146,y
sta $418b

tay

lda #$7E
pha
lda #$83
pha
plb

lda TopFont,y
plb
sta $418a
sta $3e

//==============================
// Mid-talk option shadow A
//==============================
org $01A1FE; base $83A1FE; fill $12, $ea
org $01A1FE; base $83A1FE
jsr TalkOptionShadow

//==============================
// Mid-talk option number fix
//==============================
org $06477
db $21,"1"
db $22,"2"
db $FE,$FE,$10,$FE,$10,$FE,$00

db $21,"1",$FE,$FE
db $22,"2",$FE,$FE
db $10,$FE,$FE,$FE,$10,$FE,$00

db $21,"1"
db $22,"2"
db $FE,$FE,$FE,$FE,$10,$FE,$10,$FE,$FE,$FE,$00

db $21,"1",$FE,$FE
db $22,"2"
db $FE,$FE,$FE,$FE,$10,$FE,$FE,$FE,$10,$FE,$FE,$FE,$00

db $21,"1",$FE,$FE,$FE,$FE
db $22,"2"
db $FE,$FE,$10,$FE,$FE,$FE,$FE,$FE,$10,$FE,$00

db $21,"1"
db $22,"2"
db $FE,$FE,$FE,$FE,$FE,$FE,$10,$FE,$10,$FE,$FE,$FE,$FE,$FE,$00,$23

//==============================
//Scrolling text speed A
//==============================
org $1EF9D; base $83EF9D
jsr ScrollingTextSpeed

//==============================
//Scrolling text speed C (when linebreaks are used)
//==============================
org $1F212; base $83F212
jsr ScrollingTextSpeed

//==============================
//Mouth flap adjust
//==============================
//Characters won't move their
//mouth during ellipsis and long 
//hyphen

// 83A646 $B9 $88 $E6     LDA $E688,Y	[7EE688]      		A:0500 X:0002 Y:0000 S:1C74 D:0100 DB:7E P:nvMXdizc V:53  H:262
// 83A649 $85 $32         STA $32		[000132]			A:0556 X:0002 Y:0000 S:1C74 D:0100 DB:7E P:nvMXdizc V:53  H:268
// 83A64B $B9 $88 $E7     LDA $E788,Y	[7EE788]			A:0556 X:0002 Y:0000 S:1C74 D:0100 DB:7E P:nvMXdizc V:53  H:273
// 83A64E $85 $33         STA $33		[000133]			A:05E5 X:0002 Y:0000 S:1C74 D:0100 DB:7E P:NvMXdizc V:53  H:290

org $6688; base $7EE688
incbin "asm/mouth/table - lo.bin"
incbin "asm/mouth/table - hi.bin"

//==============================
//Faster B speed
//==============================

org $1EADE; base $83EADE
//nop out three bytes conditionally if B button pressed

//==============================
//Slow Mouth A
//==============================
org $1A6F0; base $83A6F0; fill $0B, $ea
org $1A6F0; base $83A6F0
jsr SlowMouth

//==============================
//Portrait shadows fix A
//==============================
org $1B7AD; base $83B7AD
jsr PortraitShadowFix

org $1B7D0; base $83B7D0
jsr PortraitShadowFix

//==============================
//No auto-linebreak (Inline multiple choice)
//==============================
org $1EB13; base $83EB13; fill $03, $ea

//==============================
// Menu expansion
//==============================
//Original
//db $42,$28,$82,$28,$C2,$28,$02,$29,$C2,$29,$02,$2A,$42,$2A,$82
//I actually hate having to shift everything to the left;
//It doesn't align with the dialogue.
org $6CC9
db $41 //Option #01 (nothing on right)
db $28
db $81 //Option #02 (nothing on right)
db $28
db $C1 //Option #03 (nothing on right)
db $28
db $01 //Option #04 (nothing on right)
db $29
db $C1 //Option #01/#05
db $29
db $01 //Option #02/#06
db $2A
db $41 //Option #03/#07
db $2A
db $81 //Option #04/#08

//==============================
// Menu row blanking expansion
//==============================
org $1AEF3; base $83AEF3
lda #$20

//==============================
// AGL Adjust
//==============================

// Ch2: About Glory=>Glory (screen space limitations due to extra option in DX)
org $140A42
dw $0887

// Ch 5
// Tower "Knock" => "Check"
org $141FDF
dw $0A8C
org $14251e // Jiff room
dw $0A8C
org $143FDF
dw $0A8C
org $14703E
dw $0A8C
org $147644
dw $0A8C
org $148105
dw $0A8C
org $1482C5
dw $0A8C
org $148ad6
dw $0A8C
org $14982a
dw $0A8C

// Ch 6
// "About Azusa" => "Azusa"
org $13bee9
dw $0054

// Advanced Debug: Sub-screen
// Stay => Exit
org $13EE36
dw $0445

// I'm alien => They're an alien
org $149F06
db $02
dw $0EE1
db $02
dw $0EE0

org $149D1B
db $02
dw $0EE1
db $02
dw $0EE0

//Ch7: Battle Summary C (Script Engine) (Elina)
org $13e96a; fill $85, $00 //blank out everything

//Ch7: Battle Summary C (Script Engine) (Enkai)
org $13EA29; fill $85, $00 //blank out everything

//Ch7: Battle Summary C (Script Engine) (Enkai & Catty) (Dodge Failed)
org $140533; fill $59, $00 //blank out everything

//==============================
//Ch7: Final blow music change
//==============================
org $14146B
db $B8
db $01,$20
db $82
db $02,$32,$00
db $B6
db $4E,$4C,$10

//==============================
//Upper textbox 8x16 font A
//==============================
org $01EFC8; base $83EFC8; fill $0C, $ea
org $01EFC8; base $83EFC8
jsr UpperTextbox8x16

//==============================
//No indent
//(Top dialogue box)
//(Childless)
//==============================

org $1F0C5
LDA #$00

org $1F1B0
LDA #$00

//==============================
//Text speed
//(Top dialogue box) A
//==============================
org $1A6D5; base $83A6D5; fill $05, $ea
org $1A6D5; base $83A6D5
jmp TextSpeedReport

//==============================
//Remove autolinebreaking
//(Top dialogue box)
//==============================
org $1EF8D; base $83EF8D; fill $03, $ea

//==============================
//Blinking text palettes A
//==============================
org $187EE; base $8387EE
jsr BlinkingTextPalettes

//==============================
//Emergency countdown fix
//==============================
org $1F260
ldy #$9F

//==============================
//Emergency countdown period fix
//==============================
org $1F2A2
lda #$fa

//==============================
// Ch7: Correct quote to AZUSA password
//==============================
org $19EBA
ldy #$AB
lda #$BB

//==============================
//Input code range Up A
//==============================
org $19DFA; base $839DFA; fill $26, $ea
org $19DFA; base $839DFA
jsr InputRangeUp
rts

//==============================
//Input code range down
//==============================
org $19E20; base $839E20; fill $2A, $ea
org $19E20; base $839E20
jsr InputRangeDown
rts

//==============================
// Debug numbering output adjust
//==============================
org $10003C
db $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9

org $10004d
db $CA,$CB,$CC,$CD,$CE,$CF

//==============================
//Input code range fix
//==============================
org $063FD; base $7EE3FD
db $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$00

db $CA, $CB, $CC, $CD, $CE, $CF
db $D0, $D1, $D2, $D3, $D4, $D5
db $D6, $D7, $D8, $D9, $DA, $DB
db $DC, $DD, $DE, $DF, $E0, $E1
db $E2, $E3

//==============================
//Input debug code fix
//==============================
// Fix for subscreen code input option
org $19f55; base $839F57
sbc #$C0

//==============================
//Password remove diatric check
//==============================
org $19F10


////////////////////////////////////////////////////////////////////////////////////////////
//CHILD SECTOR
////////////////////////////////////////////////////////////////////////////////////////////

org $1F301; base $83F301
//==============================
//Text speed B
//==============================
TextSpeed:
lda $414a,y
and #$0f
lsr
lsr
jmp TextSpeedRet

//==============================
//Skip voice B
//==============================
SkipVoice:
//Check if current character to write isn't a space
//if it is, don't increment our counter
ldx $8e
lda {Character},x
cmp #$FE
beq dontIncrement
INC {CustVoiceCounter}
dontIncrement:

LDA {CustVoiceCounter}
AND {VoiceCounterMask}
BEQ ExitSkipVoice
RTS
ExitSkipVoice:
JSR $A719
rts

//==============================
//No indent fullscreen B
//==============================
NoIndentFullScreen:
lda #$00
sta $47
jmp ($012f)

//==============================
//Text speed B (Fullscreen)
//==============================
TextSpeedFullScreen:
lsr
sta $45 
lda #$00
rts

//==============================
//8x16 font
//==============================

TopFont:
db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe
db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe

// 8x16Font Start
db $ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea
db $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$2d,$2e,$2f
db $ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea
db $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4a,$4b,$4c,$4d,$4e,$4f
db $ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea
db $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b,$6c,$6d,$6e,$6f
db $ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea
db $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$8f
db $ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$fe,$ea
db $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$a8,$a9,$aa,$ab,$ac,$ad,$ae,$af
// 8x16Font End

db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe
db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe
db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe
db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe

BottomFont:
db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
db $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f

// 8x16Font Start
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
db $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
db $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5a,$5b,$5c,$5d,$5e,$5f
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
db $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$7b,$7c,$7d,$7e,$7f
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
db $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9a,$9b,$9c,$9d,$9e,$9f
db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
db $b0,$b1,$b2,$b3,$b4,$b5,$b6,$b7,$b8,$b9,$ba,$bb,$bc,$bd,$be,$bf
// 8x16Font End

db $c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$c8,$c9,$ca,$cb,$cc,$cd,$ce,$cf
db $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$db,$dc,$dd,$de,$df
db $e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$e8,$e9,$ea,$eb,$ec,$ed,$ee,$ef
db $f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff

// Printing current line to screen
Font8x16:
sta $418b,x

phy
pha

tay

lda #$7E
pha
lda #$83
pha
plb

lda TopFont,y
plb
sta $418a,x
sta {DiatricBottom}
inc $44
lda $42dd

beq Font8x16Branch
pla
ply
sec
rts

Font8x16Branch:
ldx $4a
lda $28
clc
adc $f949,x
tax
pla
sta $4239,x
ply
sec
rts

Font8x16Diatric:
// Blank out the diatric region
jsr $ED08

phy
phx

ldy $27
ldx $f949,y

clc

ldy #$00
Font8x16DiatricLoop:

phx

lda $4239,x
tax
lda TopFont,x
sta $418a,y

plx

inx
iny

tya
cmp #$1f
bne Font8x16DiatricLoop

plx
ply
rts

//==============================
//8x16 font (Menu options) B
//==============================

Font8x16Menu:
sta $418b,x
inx

phy
tay

lda #$7E
pha
lda #$83
pha
plb

lda TopFont,y
plb
sta $4189,x

ply
inx
rts

//==============================
//8x16 font (Numbering) B
//==============================
Font8x16Numbering:
lda $ece9,x
pha
sta $418b,y

phx

tax

lda #$7E
pha
lda #$83
pha
plb

lda TopFont,x
plb
sta $418a,y

plx

pla
rts

//==============================
// Mid-talk option shadow B
//==============================
TalkOptionShadow:
lda $5802
sta $5800,y
lda $5803
sta $5801,y

// Get shadow from white palette
// In dark mode, the shadow is grey
// In light mode, the shadow is black
lda $5804
sta $5802,y
lda $5805
sta $5803,y
rts

//==============================
//Scrolling text speed B
//==============================
ScrollingTextSpeed:
INC $412E
INC $412E
rts

//==============================
//Slow Mouth B
//==============================

SlowMouth:
lda {CustVoiceCounter}
and {VoiceCounterMask}
beq OpenMouth
rts

OpenMouth:
lda $4714,x
and #$3f
ora $457a
sta $4714,x
rts

//==============================
//Input code range Up B
//==============================

// The original game does some hacky nonsense to determine if it's a hyphen
// After the subtraction, a BPL is called to determine if it's a hyphen or not.

InputRangeUp:
  ldx $2a
  ldy #$00
  lda $423a,x

  cmp #$0C
  bne InputRangeUpIsHyphen
  
  ldy #$00
  beq InputRangeUpIsNotHyphen
  
InputRangeUpIsHyphen:
  sec
  sbc ($2f),y
  tay
  iny

InputRangeUpIsNotHyphen:
  lda ($2f),y
  bne InputRangeUpNoOverflow
  ldy #$00
  lda ($2f),y
InputRangeUpNoOverflow:
  sta $423a,x
  lda #$08
  sta $29
  jsr $9d8d
  clc
  rts
  
InputRangeDown:
  ldx $2a
  ldy #$00
  lda $423a,x
  cmp #$0C
  bne InputRangeDownIsNotSpace
  ldy #$00
  jmp InputRangeDownIsNotHyphen
  
InputRangeDownIsNotSpace:
  sec 
  sbc ($2f),y
  bmi InputRangeDownIsNotHyphen
  tay 
  dey 
  bpl InputRangeDownIsHyphen
InputRangeDownIsNotHyphen:
  iny 
  lda ($2f),y
  bne InputRangeDownIsNotHyphen
  dey 
InputRangeDownIsHyphen:
  lda ($2f),y
  sta $423a,x
  lda #$08
  sta $29
  jsr $9d8d
  clc 
  rts 
  
//==============================
//Portrait shadows fix B
//==============================

// Check if background is black.
// We use a specific entry to give elina's dialogue a shadow.
// Which is also used for the portrait shadow, which will be black, so just don't print it.
PortraitShadowFix:

phb
lda #$7E
pha
plb

lda $580E
bne PortraitShadowFixExit

lda $580F
bne PortraitShadowFixExit

// Don't print shadow
plb
rts

PortraitShadowFixExit:
plb
// Print shadow
jsr $8AFC
rts

//==============================
//Upper textbox 8x16
//==============================
UpperTextbox8x16:
phb

tay

lda #$83
pha
phb
lda #$83
pha
plb

lda BottomFont,y
plb
sta $417C

plb
lda TopFont,y
plb
sta $417B

rts

//==============================
//Text speed (Top dialogue box) B
//==============================
TextSpeedReport:

lda $62

cmp #$01
beq exit
lsr
lsr
exit:

jmp $804E

//==============================
//Max B speed B
//==============================
MaxBSpeed:
//Skip routine if we're not pressing B
lda {ButtonFlags}
//This byte determines whether or not you can power
//through the dialogue with B.
and $4408
beq LoadOriginalSpeed

LoadMaxSpeed:
lda #$00
jmp $1A689

//Speed provided by text speed patches
LoadOriginalSpeed:
lda {NameCrdSpeed}
jmp $1A682

//==============================
//Blinking text palettes A
//==============================

// BG_PinkGrey: 	0C C4 29
// BG_GameOver: 	49 A9 28
// BG_GreenBlack 	A9 C0 29

BlinkingTextPalettes:
  sta $5800,x
  
  inx
  inx
  phy
  
  lda $18 // get indexer
  and #$00FF
  tay
  lda $4453,y
  inc
  and #$00FF
  tay
  
  // Bank switch
  lda #$7E83
  pha
  plb
  
  lda $0E
  cmp #$C40C
  beq BG_PinkGrey
  cmp #$A949
  beq BG_GameOver
  cmp #$C0A9
  beq BG_GreenBlack
  cmp #$BFDF
  beq BG_PinkBlack
  
  jmp BG_Done

  BG_PinkGrey:
    lda t_PinkShadow_GreyBG,y
	jmp BG_Out
	
  BG_GameOver:
    lda t_GameOverShadow,y
	jmp BG_Out
	
  BG_GreenBlack:
    lda t_GreenShadow_BlackBG,y
	jmp BG_Out
	
  BG_PinkBlack:
    lda t_PinkShadow_BlackBG,y
	
  BG_Out:
  plb

  and #$00ff
  asl
  tay
  
  // Bank switch
  lda #$7E80
  pha
  plb
  
  lda $C636,y
  plb
  sta $5800,x
  
  ply
  
  rts
  
  BG_Done:
  plb
  ply
  rts

// The blinking for the pink text is broken in this port lol

t_PinkShadow_GreyBG: //$AE2D's shadows
//Original
//db $00,$70,$00,$05,$15,$25,$25,$25,$25,$25,$25,$25,$25,$25,$15,$05,$00
db $00,$00,$00,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$00,$00

t_PinkShadow_BlackBG: //$AB78's shadows
//Original
//db $0F,$72,$0F,$05,$15,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$15,$05
db $0F,$0F,$0F,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$0F

t_GreenShadow_BlackBG: //$AB90's shadows
//Original
//db $0F,$0F,$0A,$1A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$1A,$0A,$41
db $0F,$0F,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A

t_GameOverShadow: //$AC58's shadows
//Original
//db $82,$10,$00,$0D,$00,$10,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$41
db $82,$10,$00,$0D,$00,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$41,$00

db "Fan translation team hidden credits:                                   "
db "                                                                       "
db "--Main Team--                                                          "
db "FCandChill: ASM work, utilities, localizer, proofreader                "
db "Her-saki: Initial NES work, SNES translation                           "
db "TheMajinkZenki: SNES translation                                       "
db "                                                                       "
db "--SNES Beta Testers--                                                  "
db "dogbrainludus (Ludus)                                                  "
db "                                                                       "
db "For non-profit                                                         "

