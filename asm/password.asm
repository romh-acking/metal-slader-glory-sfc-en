arch snes.cpu

//////////////////////////////////////////////
//Character selection
//////////////////////////////////////////////

org $62E6 // 0x7C91B
incbin "asm/tilemaps/Orange_Text_Data_1.bin"
org $637e // 0x7C9B3
incbin "asm/tilemaps/Orange_Text_Data_2.bin"

org $14638c
incbin "asm/tilemaps/White_Text_Data_2.bin"
org $1463CF // 0x4E531
incbin "asm/tilemaps/White_Text_Data_3.bin"

//////////////////////////////////////////////
//Password selection codes B
//////////////////////////////////////////////
org $19bA4 //0x839bA4
txa
clc
adc #$08
sta $ad
lda $28
and #$f0
cmp #$10
nop
nop
nop
nop
db $d0,$0d,$c9 //bne $9bc3

//////////////////////////////////////////////
//Password selection codes (Pressing A)
//////////////////////////////////////////////
org $19c41 //0x839c41
cmp #$1a
db $f0,$2c //beq $9c71
cmp #$1f