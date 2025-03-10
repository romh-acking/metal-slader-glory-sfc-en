arch nes.cpu

//==============================
// Write new fonts
//==============================

org $27d812
incbin "asm/gfx/Font 2BPP.chr"

//Repoint
// Entry (a.k.a. "CHR-Bank") 0x00
org $122D5; base $2A2D5
db GameScreenFont&$FF, GameScreenFont>>8&$FF, GameScreenFont>>16&$FF

org $124d5; base $2A4D5
// Entry (a.k.a. "CHR-Bank") 0x80
db PasswordScreenFont&$FF, PasswordScreenFont>>8&$FF, PasswordScreenFont>>16&$FF,$00
// Entry (a.k.a. "CHR-Bank") 0x81
db GameScreenFont2&$FF, GameScreenFont2>>8&$FF, GameScreenFont2>>16&$FF,$00

//Write Password Screen Font
org $1db9f3; base $1db9f3+$9E0000
// Use for password screen and full screen mode.
GameScreenFont:
incbin "asm/gfx/Font 4BPP - Original #1.chr"
PasswordScreenFont:
incbin "asm/gfx/Font 4BPP - Password.chr"

//==============================
// Password GFX
//==============================

//Clear out old password GFX
org $1DA312; base $BBA312; fill $BC0, $FF

org $0026c7f3; base $0026c7f3+$A70000
GameScreenFont2:
incbin "asm/gfx/Font 4BPP - Original #2.chr"

// Change password AGL code to load new bank

// White text
org $14034B
db 0x80

// Orange
org $14034E
db 0x80

//==============================
// Sound and GFX debugger
//==============================
// Change AGL code to load new bank
org $0014781C
db 0x81
org $0013BB4A
db 0x81

org $142d3d
incbin "asm/tilemaps/advanced debug screen.bin"

//==============================
// Gameover
//==============================
org $1429A1
incbin "asm/tilemaps/game over text data.bin"
