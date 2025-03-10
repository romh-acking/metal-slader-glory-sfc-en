arch snes.cpu

//==============================
// People colors
//==============================

// Other
org $00006ded
db $00,$00

// Tadashi
org $00006DF9
db $00,$00

// Azusa (Grey BG)
org $00006dff
db $00,$00

//==============================
// Menu color
//==============================

// Menu option
org $00006EDD
dw $0000

org $00006EE3
dw $0000
  
// Menu option (Faded)
org $00006ee9
dw $18a5

// Menu option (Faded)
org $00006eef
dw $18a5

//==============================
// People colors (Dark mode)
//==============================

org $6E1B

// Other
dw $7fff
dw $1CE7
dw $0000

// Elina
dw $7fff
dw $400B // dw $7f1a
dw $0000

// Tadashi
dw $7fff
dw $44A0 // dw $7f57
dw $0000

// Azusa
dw $7fff
dw $01AD // dw $53f8
dw $0000

//==============================
// People colors (????)
//==============================

// Other
// ???


// Elina
org $6df1
//dw $7fff
//dw $400B
//dw $0000

org $6df7
//dw $7fff
//dw $44A0
//dw $0000

org $6dfd
//dw $7fff
//dw $01AD
//dw $0000

//==============================
// People colors (Password)
//==============================

// Other
org $6e93
//dw $7fff
//dw $1CE7
//dw $39AB

// Elina
//dw $7fff
//dw $400B
//dw $39AB

// Tadashi
//dw $7fff
//dw $44A0
//dw $39AB

// Azusa
//dw $7fff
//dw $01AD
//dw $39AB

//==============================
// Menu color  (Dark mode)
//==============================

// Menu option
org $6f0d
dw $400B

// Menu option highlight
org $6f13
dw $400B

// Menu option (Faded)
org $6F19
dw $4008 // dw $7FBB

// Menu option (Faded)
org $6F1F
dw $4008 // dw $7FBB

//==============================
//"Sweet dreams" indexed palette
//==============================
// 839597 $B7 $2C         LDA [$2C],Y [29B7E9]

// Palettes behave like the NES where
// an entry corresponds to a color value as
// opposed to holding the RGB value

org $14b7eb
db $30, $00, $0F //Catty
db $30, $04, $0F //Elina
db $30, $01, $0F //Tadashi
db $30, $39, $0F //Azusa

//==============================
// Tadashi is dead palette
//==============================
org $142917
dw $7FFF
dw $0000

//==============================
//Post-credit sequence indexed palette
//==============================

org $14BB9F
db $30, $04, $0F //Elina
db $30, $01, $0F //Tadashi
db $30, $39, $0F //Azusa

//==============================
//Dramatic fullscreen indexed palette
//==============================

org $14B8A8
db $30, $0F, $00
db $34, $0F, $00
db $31, $0F, $00
db $39, $30, $00

//==============================
//NES palette lookup table
//==============================
// Regex find and replace to format binary stream
// Find: ([0-9A-Z][0-9A-Z])([0-9A-Z][0-9A-Z])
// Replace: dw \$$2$1\n

org $4636; base $80C636
dw $39AB
dw $44A0 // Tadashi shadow
dw $7D46
dw $7D13
dw $400B // Elina shadow
dw $200D // Pink flashing text
dw $00BA
dw $0131
dw $0225
dw $0282
dw $0284
dw $5A40
dw $7DC3
dw $0000
dw $0000
dw $0000
dw $56B5 // Light grey
dw $7E48
dw $7DE7
dw $7D96
dw $7D5F
dw $1D1F
dw $015F
dw $027D
dw $0350
dw $0FC0
dw $07E0
dw $77A0
dw $7EEA
dw $1062
dw $0000
dw $0000
dw $7FFF
dw $7EF0
dw $7E6F
dw $7E34
dw $7DFE
dw $497F
dw $1E3F
dw $1B7F
dw $1FFC
dw $23EF
dw $43F4
dw $7BE7
dw $7F70
dw $3DCD
dw $0000
dw $0000
dw $7FFF
dw $7F57
dw $7F59
dw $7ED8
dw $7F1A
dw $76FF
dw $5B9F
dw $43FF
dw $3BFE
dw $53F8
dw $6FF6
dw $7FF3
dw $7FB4
dw $7FDC
dw $0000
dw $0000

//============================
//Dialogue palettes (Labyrinth mode)
//============================

org $6E4B

//Catty - Enkai
dw $535E
dw $008A
dw $0000

//Elina
dw $731F
dw $200D
dw $0000

//Tadashi
dw $633F
dw $002D
dw $0000

//Azusa
dw $535E
dw $008A
dw $0000

//============================
//Choice palettes (Red mode)
//============================

org $6F3B
//Unselected front
dw $7FFF
dw $008A
dw $0000

//Selected front
dw $731F
dw $200D
dw $0000

//Unselected back
dw $7FFF
dw $008A
dw $0000

//Selected back
dw $633F
dw $002D
dw $0000
