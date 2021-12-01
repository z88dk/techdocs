
; How to build (use the z80asm variant in z88dk):
;
; z80asm -b msxbasic
;

; Variant with HOOKs disabled:
;
; z80asm -DNOHOOK -b msxbasic
;
; No HOOKs but same ROM addresses:
; z80asm -DNOHOOK -DPRESERVE_LOCATIONS -b msxbasic
;

; MOD demonstration (ZX Spectrum skin variant):
;
; z80asm -DSPECTRUM_SKIN -DNOHOOK -b msxbasic
; 

; NON WORKING attempt to adapt this ROM to a 32K Spectravideo SVI:
; z80asm -DNOHOOK -DPRESERVE_LOCATIONS -DNOCALBAS -DSVI -a msxbasic.asm

defc BEL    =  $07		; Control "G", BEEP via the console output
defc TAB    =  $09		; TAB
defc LF     =  $0A		; Line feed
defc CR     =  $0D		; Carriage return
defc FF     =  $0C		; Form Feed / CLS
defc ESC    =  $1B		; Escape


;defc STACK_INIT = $F376
defc STACK_INIT = MAXRAM-10

  INCLUDE "msxbasic.def"
  INCLUDE "msxhook.def"
  INCLUDE "msxtoken.def"
  
IF SVI
  INCLUDE "svi.def"
ELSE
  INCLUDE "msx.def"
ENDIF


ORG $0000

  
; Routine at 0
;
; Check RAM and sets slot for command area.
STARTUP:
  DI
IF SVI
  JP _SVISTARTUP
ELSE
  JP _STARTUP
ENDIF

; Used to initialize CHFONT
FONT:
  IF SPECTRUM_SKIN
  DEFW _FONT-256
  ELSE
  DEFW _FONT
  ENDIF
_VDP_RD:
  DEFB VDP_DATAIN
_VDP_WR:
  DEFB VDP_DATA

; A byte follows to be compared
;
; Checks if then current character pointed by
SYNCHR:
  JP _SYNCHR
  NOP

; Routine at 12
;
; Reads the value of an address in another slot
RDSLT:
  JP _RDSLT
  NOP

; Routine at 16
;
; Gets next character (or token) from BASIC text.
CHRGTB:
  JP _CHRGTB
  NOP

; Routine at 20
;
; Writes a value to an address in another slot.
WRTSLT:
  JP _WRTSLT
  NOP

; Routine at 24
;
; Output to the current device (formerly OUTC).
OUTDO:
  JP _OUTDO
  NOP

; Routine at 28
;
; Performs inter-slot call to specified address.
CALSLT:
  JP _CALSLT
  NOP

; Routine at 32
;
; Compare HL with DE.
DCOMPR:
  JP CPDEHL
  NOP

; Routine at 36
;
; Switches indicated slot at indicated page on perpetual
ENASLT:
  JP _ENASLT
  NOP

; Routine at 40
;
; Return the number type (FAC)
GETYPR:
  JP _GETYPR

; Routine at 43  
;  002B  1        Basic ROM Character set / Date format / Default interrupt freq
;               7 6 5 4 3 2 1 0
;               | | | | +-+-+-+-- Character set
;               | | | |           0 = Japanese, 1 = Other
;               | +-+-+---------- Date format
;               |                 0 = Y-M-D, 1 = M-D-Y, 2 = D-M-Y
;               +---------------- Default interrupt frequency (VSYNC)
;                                 0 = 60Hz, 1 = 50Hz
L002B:
  DEFB $91

L002C:
  DEFB $11
  
; 002D  1        MSX Version Number
;               0 = MSX 1
;               1 = MSX 2
;               2 = MSX 2+
;               3 = MSX Turbo RL002D:
  DEFB $00

L002E:
  DEFB $00		; IF BIT 0 = 1 then internal MIDI is present ( Turbo R Only !!! )

  NOP

; Routine at 48
;  Call FAR
CALLF:
  JP  _CALLF

L0033:
  NOP
  NOP
  NOP
  NOP
  NOP


; Routine at 56
;
; Performs hardware interrupt procedures.
KEYINT:
  JP _KEYINT

; Routine at 59
;
; Dev. initialization.
INITIO:
  JP _INITIO

; Routine at 62
;
; Initializes function key strings.
INIFNK:
  JP _INIFNK

; Routine at 65
;
; Disables screen display.
DISSCR:
  JP _DISSCR

; Routine at 68
;
; Enables screen display.
ENASCR:
  JP _ENASCR

; Routine at 71
;
; Writes to the VDP register.
WRTVDP:
  JP _WRTVDP

; Routine at 74
;
; Reads the VRAM address by [HL].
RDVRM:
  JP _RDVRM

; Routine at 77
;
; Write to the VRAM address by [HL].
WRTVRM:
  JP _WRTVRM

; Routine at 80
;
; Sets up the VDP for read.
SETRD:
  JP _SETRD

; Routine at 83
;
; Sets up the VDP for write.
SETWRT:
  JP _SETWRT

; Routine at 86
;
; Fill the vram with specified data
FILVRM:
  JP _FILVRM

; Routine at 89
;
; Block transfer to memory from VRAM
LDIRMV:
  JP _LDIRMV

; Routine at 92
;
; Block transfer to VRAM from memory
LDIRVM:
  JP _LDIRVM

; Routine at 95
;
; Sets the VDP mode according to SCRMOD.
CHGMOD:
  JP _CHGMOD

; Routine at 98
;
; Changes the color of the screen.
CHGCLR:
  JP _CHGCLR

  NOP

; Routine at 102
;
; Performs non-maskable interrupt procedures.
NMI:
  JP _NMI

; Routine at 105
;
; Initializes all sprites.
CLRSPR:
  JP _CLRSPR

; Routine at 108
;
; Initializes screen for text mode (40*24) and sets the VDP.
INITXT:
  JP _INITXT

; Routine at 111
;
; Initializes screen for text mode (32*24) and sets the VDP.
INIT32:
  JP _INIT32

; Routine at 114
;
; Initializes screen for high-resolution mode and sets the VDP.
INIGRP:
  JP _INIGRP

; Routine at 117
;
; Initializes screen for multi-color mode and sets the VDP.
INIMLT:
  JP _INIMLT

; Routine at 120
;
; Sets the VDP for text (40*24) mode.
SETTXT:
  JP _SETTXT

; Routine at 123
;
; Sets the VDP for text (32*24) mode.
SETT32:
  JP _SETT32

; Routine at 126
;
; Sets the VDP for high-resolution mode.
SETGRP:
  JP _SETGRP

; Routine at 129
;
; Sets the VDP for multicolor mode.
SETMLT:
  JP _SETMLT

; Routine at 132
;
; Returns address of sprite pattern table.
CALPAT:
  JP _CALPAT

; Routine at 135
;
; Returns address of sprite atribute table.
CALATR:
  JP _CALATR

; Routine at 138
;
; Returns the current sprite size.
GSPSIZ:
  JP _GSPSIZ

; Routine at 141
;
; Prints a character on the graphic screen.
GRPPRT:
  JP _GRPPRT

; Routine at 144
;
; Initializes PSG,and static data for PLAY
GICINI:
  JP _GICINI

; Routine at 147
;
; Writes data to the PSG register.
WRTPSG:
  JP _WRTPSG

; Routine at 150
;
; Reads data from PSG register.
RDPSG:
  JP _RDPSG

; Routine at 153
;
; Checks/starts background tasks for PLAY.
STRTMS:
  JP _STRTMS

; Routine at 156
;
; Check the status of keyboard buffer.
CHSNS:
  JP _CHSNS

; Routine at 159
;
; Waits for character being input and returns the character codes.
CHGET:
  JP _CHGET

; Routine at 162
;
; Outputs a character to the console.
CHPUT:
  JP _CHPUT

; Routine at 165
;
; Output a character to the line printer.
LPTOUT:
  JP _LPTOUT

; Routine at 168
;
; Check the line priter status.
LPTSTT:
  JP _LPTSTT

; Routine at 171
;
; Check graphic header byte and converts codes.
SNVCHR:
  JP _SNVCHR

; Routine at 174
;
; Accepts a line from console until a CR or STOP
PINLIN:
  JP _PINLIN

; Routine at 177
;
; Same as PINLIN,exept if AUTFLO if set.
INLIN:
  JP _INLIN

; Routine at 180
;
; Output a '?' mark and a space then falls into the INLIN routine.
QINLIN:
  JP _QINLIN

; Routine at 183
;
; Check the status of the Control-STOP key.
BREAKX:
  JP _BREAKX

; Routine at 186
;
; Check the status of the SHIFT-STOP key.
ISCNTC:
  JP _ISCNTC

; Routine at 189
;
; Same as ISCNTC,used by BASIC
CKCNTC:
  JP _CKCNTC

; Routine at 192
;
; Sounds the buffer
BEEP:
  JP _BEEP

; Routine at 195
;
; Clear the screen.
__CLS:
  JP _CLS

; Routine at 198
;
; Locate cursor at the specified position.
POSIT:
  JP _POSIT 		; Locate cursor at the specified position

; Routine at 201
;
; Check if function key display is active, and display the FN list if so...
FNKSB:
  JP _FNKSB

; Routine at 204
;
; Hide the function key diplay.
ERAFNK:
  JP _ERAFNK

; Routine at 207
;
; Show the function key display.
DSPFNK:
  JP _DSPFNK

; Routine at 210
;
; Forcidly places the screen in text mode.
TOTEXT:
  JP _TOTEXT

; Routine at 213
;
; Return the current joystick status.
GTSTCK:
  JP _GTSTCK

; Routine at 216
;
; Return the current trigger button status.
GTTRIG:
  JP _GTTRIG

; Routine at 219
;
; Check the current touch PAD status.
GTPAD:
  JP _GTPAD

; Routine at 222
;
; Return the value of the paddle.
GTPDL:
  JP _GTPDL

; Routine at 225
;
; Reads the header block after turning the cassette motor on
TAPION:
  JP _TAPION

; Routine at 228
;
; Read data from the tape
TAPIN:
  JP _TAPIN

; Routine at 231
;
; Stops reading from the tape
TAPIOF:
  JP _TAPIOF

; Routine at 234
;
; Turns on the cassette motor and writes the header
TAPOON:
  JP _TAPOON

; Routine at 237
;
; Writes data on the tape
TAPOUT:
  JP _TAPOUT

; Routine at 240
;
; Stops writing on the tape
TAPOOF:
  JP _TAPOOF

; Routine at 243
;
; Sets the cassette motor action
STMOTR:
  JP _STMOTR

; Routine at 246
;
; Gives number of bytes in queue
LFTQ:
  JP _LFTQ

; Routine at 249
;
; Put byte in queue
PUTQ:
  JP _PUTQ

; Routine at 252
;
; Shifts screenpixel to the right
RIGHTC:
  JP _RIGHTC

; Routine at 255
;
; Shifts screenpixel to the left
LEFTC:
  JP _LEFTC

; Routine at 258
;
; Shifts screenpixel up
UPC:
  JP _UPC

; Routine at 261
;
; Tests whether UPC is possible, if possible, execute UPC
TUPC:
  JP _TUPC

; Routine at 264
;
; Shifts screenpixel down
DOWNC:
  JP _DOWNC

; Routine at 267
;
; Tests whether DOWNC is possible, if possible, execute DOWNC
TDOWNC:
  JP _TDOWNC

; Routine at 270
;
; Scales X and Y coordinates
SCALXY:
  JP _SCALXY

; Routine at 273
;
; Places cursor at current cursor address
MAPXY:
  JP _MAPXY

; Routine at 276
;
; Gets current cursor addresses mask pattern
FETCHC:
  JP _FETCHC

; Routine at 279
;
; Record current cursor addresses mask pattern
STOREC:
  JP _STOREC

; Routine at 282
;
; Set attribute byte
SETATR:
  JP _SETATR

; Routine at 285
;
; Reads attribute byte of current screenpixel
READC:
  JP _READC

; Routine at 288
;
; Returns currenct screenpixel of specified attribute byte
SETC:
  JP _SETC

; Routine at 291
;
; Set horizontal screenpixels
NSETCX:
  JP _NSETCX

; Routine at 294
;
; Gets screen relations
GTASPC:
  JP _GTASPC
  
; Routine at 297
;
; This entry point is used by the routine at __PAINT.
PNTINI:
  JP _PNTINI
  
; Routine at 300
;
SCANR:
  JP _SCANR
  
; Routine at 303
;
SCANL:
  JP _SCANL		; $197A

; Routine at 306
;
; Alternates the CAP lamp status
CHGCAP:
  JP _CHGCAP

; Routine at 309
;
; Alternates the 1-bit sound port status
CHGSND:
  JP _CHGSND

; Routine at 312
;
; Reads the primary slot register
RSLREG:
  JP _RSLREG

; Routine at 315
;
; Writes value to the primary slot register
WSLREG:
  JP _WSLREG

; Routine at 318
;
; Reads VDP status register
RDVDP:
  JP _RDVDP

; Routine at 321
;
; Returns the value of the specified line from the keyboard matrix
SNSMAT:
  JP _SNSMAT

; Routine at 324
;
; Executes I/O for mass-storage media like diskettes
PHYDIO:
  JP _PHYDIO

; Routine at 327
;
; Initialises mass-storage media like formatting of diskettes
FORMAT:
  JP _FORMAT

; Routine at 330
;
; Tests if I/O to device is taking place
ISFLIO:
  JP _ISFLIO

; Routine at 333
;
; Printer output
OUTDLP:
  JP OUTC_TABEXP

; Routine at 336
;
; Returns pointer to play queue
GETVCP:
  JP _GETVCP

; Routine at 339
;
; Returns pointer to variable in queue number VOICEN (byte op $FB38)
GETVC2:
  JP _GETVC2

; Routine at 342
;
; Clear keyboard buffer
KILBUF:
  JP _KILBUF

; Routine at 345
;
; Executes inter-slot call to the routine in BASIC interpreter
CALBAS:
  JP _CALBAS

; -- RESERVED FOR EXPANSION --
L015C:
  DEFS $5A

; Routine at 438
;
; Used by the routines at RDSLT, _RDSLT_0, COPY_FONT and L0752.
; Reads the value in an address in another slot
_RDSLT:
  CALL SELPRM		; Calculate bit pattern and mask code, slot# in A
  JP M,_RDSLT_0
  IN A,(PPI_A)
  LD D,A
  AND C
  OR B
  CALL RDPRIM
  LD A,E
  RET

; Routine at 454
;
; Used by the routine at _RDSLT.
_RDSLT_0:
  PUSH HL
  CALL SELEXP		; Select secondary slot
  EX (SP),HL
  PUSH BC
  CALL _RDSLT
  JR _RW_SLT_SUB

; Routine at 465
;
; Used by the routines at WRTSLT and _WRTSLT_0.
; Writes a value to an address in another slot.
_WRTSLT:
  PUSH DE
  CALL SELPRM		; Calculate bit pattern and mask code, slot# in A
  JP M,_WRTSLT_0
  POP DE
  IN A,(PPI_A)
  LD D,A
  AND C
  OR B
  JP WRPRIM

; Routine at 481
;
; Used by the routine at _WRTSLT.
_WRTSLT_0:
  EX (SP),HL
  PUSH HL
  CALL SELEXP		; Select secondary slot
  POP DE
  EX (SP),HL
  PUSH BC
  CALL _WRTSLT
; This entry point is used also by the routine at _RDSLT_0.
_RW_SLT_SUB:
  POP BC
  EX (SP),HL
  PUSH AF
  LD A,B
  AND $3F
  OR C
  OUT (PPI_AOUT),A
  LD A,L
  LD ($FFFF),A		; Secondary slot select register 
  LD A,B
  OUT (PPI_AOUT),A
  POP AF
  POP HL
  RET

; Routine at 511
;
; Used by the routines at CALBAS, L0D12, _OUTDO and L1BA2.
_CALBAS:
IF NOCALBAS
  JP (IX)
  IF PRESERVE_LOCATIONS
    DEFS 4
  ENDIF
ELSE
  LD IY,(EXP0-1)			; Load expansion slot #0 address on IYl
  JR _CALSLT
ENDIF

; Routine at 517
;
; Used by the routine at L002B.
;  Call FAR
_CALLF:
  EX (SP),HL
  PUSH AF
  PUSH DE
  LD A,(HL)
  PUSH AF
  POP IY
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH DE
  POP IX
  POP DE
  POP AF
  EX (SP),HL
; This entry point is used by the routines at CALSLT, _CALBAS and _CALSLT_0.
; Performs inter-slot call to specified address.
_CALSLT:
  EXX
  EX AF,AF'
  PUSH IY			; slot address is on IYl
  POP AF
  PUSH IX
  POP HL
  CALL SELPRM		; Calculate bit pattern and mask code, slot# in A
  JP M,_CALSLT_0
  IN A,(PPI_A)
  PUSH AF
  AND C
  OR B
  EXX
  JP CLPRIM

; Routine at 558
;
; Used by the routine at _CALLF.
_CALSLT_0:
  CALL SELEXP		; Select secondary slot
  PUSH AF
  POP IY
  PUSH HL
  PUSH BC
  LD C,A
  LD B,$00
  LD A,L
  AND H
  OR D
  LD HL,SLT0
  ADD HL,BC
  LD (HL),A
  PUSH HL
  EX AF,AF'
  EXX
  CALL _CALSLT
  EXX
  EX AF,AF'
  POP HL
  POP BC
  POP DE
  LD A,B
  AND $3F
  OR C
  DI
  OUT (PPI_AOUT),A
  LD A,E
  LD ($FFFF),A			;  Secondary slot select register 
  LD A,B
  OUT (PPI_AOUT),A
  LD (HL),E
  EX AF,AF'
  EXX
  RET

; Routine at 606
;
; Used by the routines at ENASLT, _ENASLT_0 and L043F.
_ENASLT:
  CALL SELPRM		; Calculate bit pattern and mask code, slot# in A
  JP M,_ENASLT_0
  IN A,(PPI_A)
  AND C
  OR B
  OUT (PPI_AOUT),A
  RET

; Routine at 619
;
; Used by the routine at _ENASLT.
_ENASLT_0:
  PUSH HL
  CALL SELEXP		; Select secondary slot
  LD C,A
  LD B,$00
  LD A,L
  AND H
  OR D
  LD HL,SLT0
  ADD HL,BC
  LD (HL),A
  POP HL
  LD A,C
  JR _ENASLT

; Routine at 638
;
; Used by the routines at _RDSLT, _WRTSLT, _CALLF and _ENASLT.
; Calculate bit pattern and mask code
SELPRM:
  DI
  PUSH AF
  LD A,H
  RLCA
  RLCA
  AND $03
  LD E,A
  LD A,$C0
SELPRM_0:
  RLCA
  RLCA
  DEC E
  JP P,SELPRM_0
  LD E,A
  CPL
  LD C,A
  POP AF
  PUSH AF
  AND $03
  INC A
  LD B,A
  LD A,$AB			; @10101011
SELPRM_1:
  ADD A,$55			; @01010101
  DJNZ SELPRM_1
  LD D,A
  AND E
  LD B,A
  POP AF
  AND A
  RET

; Routine at 675
;
; Used by the routines at _RDSLT_0, _WRTSLT_0, _CALSLT_0 and _ENASLT_0.
; Select secondary slot REG
SELEXP:
  PUSH AF
  LD A,D
  AND $C0
  LD C,A
  POP AF
  PUSH AF
  LD D,A
  IN A,(PPI_A)
  LD B,A
  AND $3F
  OR C
  OUT (PPI_AOUT),A
  LD A,D
  RRCA
  RRCA
  AND $03
  LD D,A
  LD A,$AB			; @10101011
SELEXP_0:
  ADD A,$55			; @01010101
  DEC D
  JP P,SELEXP_0
  AND E
  LD D,A
  LD A,E
  CPL
  LD H,A
  LD A,($FFFF)			 ; Secondary slot select register 
  CPL					; Reading returns INVERTED! previous written value
  LD L,A
  AND H
  OR D
  LD ($FFFF),A				; Secondary slot select register 
  LD A,B
  OUT (PPI_AOUT),A
  POP AF
  AND $03
  RET


IF SVI
SVI_CRTTAB:
  DEFB $01,$3b,$fe,$01,$3c,$fe,$01,$07,$fa,$01,$3d,$fe,$01,$00,$00,$78
  
_SVISTARTUP:
  LD SP,$F000
  LD HL,$0000
SVINITDLY:
  DEC HL
  LD A,H
  OR L
  JR NZ,SVINITDLY
  OUT (PSG_ADDR),A		; SVI mode bank switching
  LD A,$DF
  OUT (PSG_DATA),A
  CALL _INITIO
  ; Let's complete INITIO here, to preserve the mem position of the other function entries
  LD BC,$1051		; Port $51 (CRT 6845 Controller register R0-R17), count: $10
  LD HL,SVI_CRTTAB
SVINITIO:
  LD A,B
  DEC A
  OUT ($50),A		; CRT 6845 Adress latch
  OUTD				; Writes the value from (HL) to the (C) port, then decrements B and HL.
  JR NZ,SVINITIO


  LD DE,$FFFF
  LD HL,$FE00
_STARTUP_10:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  JR NZ,_STARTUP_11
  NOP
  NOP
  NOP
  DEC H
  LD A,H
  CP $C0
  JR NC,_STARTUP_10
_STARTUP_11:


; Line up to $03F6 to preserve the mem position of the other function entries
SVILINEUP:
DEFS $03F6-SVILINEUP


ELSE
; This entry point is used by the routine at STARTUP.
; $02D7
_STARTUP:
  LD A,$82
  OUT (PPI_MOUT),A
  XOR A
  OUT (PPI_AOUT),A
  LD A,$50
  OUT (PPI_COUT),A
  LD DE,$FFFF
  XOR A
  LD C,A
_STARTUP_0:
  OUT (PPI_AOUT),A
  SLA C
  LD B,$00
  LD HL,$FFFF				; Secondary slot select register 
  LD (HL),$F0
  LD A,(HL)					; Reading returns INVERTED! previous written value
  SUB $0F
  JR NZ,_STARTUP_2
  LD (HL),A
  LD A,(HL)
  INC A
  JR NZ,_STARTUP_2
  INC B
  SET 0,C
_STARTUP_1:
  LD ($FFFF),A				; Secondary slot select register 
_STARTUP_2:
  LD HL,$BF00
_STARTUP_3:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  JR NZ,_STARTUP_4
  NOP
  NOP
  NOP
  DEC H
  JP M,_STARTUP_3
_STARTUP_4:
  LD L,$00
  INC H
  LD A,L
  SUB E
  LD A,H
  SBC A,D
  JR NC,_STARTUP_5
  EX DE,HL
  LD A,($FFFF)					; Secondary slot select register 
  CPL							; Reading returns INVERTED! previous written value
  LD L,A
  IN A,(PPI_A)
  LD H,A
  LD SP,HL
_STARTUP_5:
  LD A,B
  AND A
  JR Z,_STARTUP_6
  LD A,($FFFF)				; Secondary slot select register
  CPL						; Reading returns INVERTED! previous written value
  ADD A,$10
  CP $40
  JR C,_STARTUP_1
_STARTUP_6:
  IN A,(PPI_A)
  ADD A,$50
  JR NC,_STARTUP_0
  LD HL,0
  ADD HL,SP
  LD A,H
  OUT (PPI_AOUT),A
  LD A,L
  LD ($FFFF),A						; Secondary slot select register
  LD A,C
  RLCA
  RLCA
  RLCA
  RLCA
  LD C,A
  LD DE,$FFFF
  IN A,(PPI_A)
  AND $3F
_STARTUP_7:
  OUT (PPI_AOUT),A
  LD B,$00
  RLC C
  JR NC,_STARTUP_9
  INC B
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  AND $3F
_STARTUP_8:
  LD ($FFFF),A					; Secondary slot select register
_STARTUP_9:
  LD HL,$FE00
_STARTUP_10:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  JR NZ,_STARTUP_11
  NOP
  NOP
  NOP
  DEC H
  LD A,H
  CP $C0
  JR NC,_STARTUP_10
_STARTUP_11:
  LD L,$00
  INC H
  LD A,L
  SUB E
  LD A,H
  SBC A,D
  JR NC,_STARTUP_12
  EX DE,HL
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  LD L,A
  IN A,(PPI_A)
  LD H,A
  LD SP,HL
_STARTUP_12:
  LD A,B
  AND A
  JR Z,_STARTUP_13
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  ADD A,$40
  JR NC,_STARTUP_8
; $0398
_STARTUP_13:
  IN A,(PPI_A)
  ADD A,$40
  JR NC,_STARTUP_7
  LD HL,0
  ADD HL,SP
  LD A,H
  OUT (PPI_AOUT),A
  LD A,L
  LD ($FFFF),A					; Secondary slot select register

; $03A9
  LD A,C
  LD BC,$0C49			;  Clear System Variable Region (3145 bytes)
  LD DE,RDPRIM+1		;  System variables region
  LD HL,RDPRIM			;     "      "        "
  LD (HL),$00
  LDIR
  LD C,A
  LD B,$04
  LD HL,EXP3			; Expansion slot #3

_STARTUP_14:
; $03DB
  RR C
  SBC A,A
  AND $80
  LD (HL),A
  DEC HL
  DJNZ _STARTUP_14
  
  IN A,(PPI_A)
  LD C,A
  XOR A
  OUT (PPI_AOUT),A
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  LD L,A
  LD A,$40
  OUT (PPI_AOUT),A
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  LD H,A
  LD A,$80
  OUT (PPI_AOUT),A
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  LD E,A
  LD A,$C0
  OUT (PPI_AOUT),A
  LD A,($FFFF)					; Secondary slot select register
  CPL							; Reading returns INVERTED! previous written value
  LD D,A
  LD A,C
  OUT (PPI_AOUT),A
  LD (SLT0),HL
  EX DE,HL
  LD (SLT2),HL
  
ENDIF

; $03F6
  IM 1
  JP CSTART
  

; Routine at 1019
;
; Used by the routines at ISCNTC and _CKCNTC.
_ISCNTC:
  LD A,(BASROM)		
  AND A
  RET NZ
  PUSH HL
  LD HL,INTFLG
  DI
  LD A,(HL)
  LD (HL),$00
  POP HL
  EI
  AND A
  RET Z
  CP $03
  JR Z,_ISCNTC_1
  PUSH HL
  PUSH DE
  PUSH BC
  CALL L09DA
  LD HL,INTFLG
_ISCNTC_0:
  DI
  LD A,(HL)
  LD (HL),$00
  EI
  AND A
  JR Z,_ISCNTC_0
  PUSH AF
  CALL L0A27
  POP AF
  POP BC
  POP DE
  POP HL
  CP $03
  RET NZ
_ISCNTC_1:
  PUSH HL
  CALL _KILBUF
  CALL CKSTTP				; Check for STOP trap
  JR NC,L043F
  LD HL,IFLG_STOP			; STOP button - Interrupt flags
  DI
  CALL TST_IFLG_EVENT
  EI
  POP HL
  RET

; Routine at 1087
;
; Used by the routine at _ISCNTC.
L043F:
  CALL _TOTEXT
  LD A,(EXP0)			; Expansion slot #0
  LD H,$40
  CALL _ENASLT
  POP HL
  XOR A
  LD SP,(SAVSTK)
  PUSH BC
  JP __STOP_0

; Routine at 1108
;
; Used by the routines at _ISCNTC and L24C4.
; Check for STOP trap
CKSTTP:
  LD A,(IFLG_STOP)			; STOP button - Interrupt flags
  RRCA
  RET NC
  LD HL,(IENTRY_STOP)		; STOP button - Interrupt related code
  LD A,H
  OR L
  RET Z
  LD HL,(CURLIN)		; Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
  INC HL
  LD A,H
  OR L
  RET Z					; RET if we are in 'DIRECT' (immediate) mode
  SCF
  RET

; Routine at 1128
;
; Used by the routines at KILBUF and _ISCNTC.
_KILBUF:
  LD HL,(PUTPNT)
  LD (GETPNT),HL
  RET

; Routine at 1135
;
; Used by the routines at BREAKX, _LPTOUT, _TAPOON, _TAPOUT, _TAPIN, L1B1F and L1B34.
; Return CY if STOP is pressed
_BREAKX:
  IN A,(PPI_C)
  AND $F0

IF SVI
  SCF
  RET
  ;OR $06
ELSE
  OR $07
ENDIF
  OUT (PPI_COUT),A
  
  IN A,(PPI_B)
IF SVI
  AND $22
  DEFS 10
ELSE
  AND $10
  RET NZ
  IN A,(PPI_C)
  DEC A
  OUT (PPI_COUT),A
  IN A,(PPI_B)
  AND $02
ENDIF
  RET NZ
  PUSH HL
  LD HL,(PUTPNT)
  LD (GETPNT),HL
  POP HL
IF SVI
  LD A,(OLDKEY+6)
  AND $DF		; TK_SPC ?
  LD (OLDKEY+6),A
ELSE
  LD A,(OLDKEY+7)
  AND $EF		; TK_EQUAL ?
  LD (OLDKEY+7),A
ENDIF
  LD A,$0D
  LD (REPCNT),A
  SCF
  RET


; Routine at 1181
;
; Used by the routine at INITIO.
_INITIO:
IF SVI

  ; (28 bytes)
  LD A,$0E
  LD E,$FF
  CALL WRTPSG
  LD A,$07
  LD E,$80
  CALL WRTPSG
  LD A,$92
  OUT (PPI_MOUT),A
  LD A,$10
  OUT (PPI_COUT),A
;  LD A,$FF
;  OUT (PRN_STB),A
  LD A,0
  LD (KANAMD),A
  NOP

ELSE
  
  LD A,$07
  LD E,$80
  CALL _WRTPSG
  LD A,$0F
  LD E,$CF
  CALL _WRTPSG
  LD A,$0B
  LD E,A
  CALL _WRTPSG
  CALL L110C
  AND $40
  LD (KANAMD),A
  
ENDIF
  LD A,$FF
  OUT (PRN_STB),A  
  
; This entry point is used by the routines at GICINI, _BEEP and L24C4.
_GICINI:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,MUSICF
  LD B,$71
  XOR A
GICINI_1:
  LD (HL),A
  INC HL
  DJNZ GICINI_1
  LD DE,VOICAQ
  LD B,$7F
  LD HL,$0080
GICINI_2:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL L14DA
  POP AF
  ADD A,$08
  LD E,$00
  CALL _WRTPSG
  SUB $08
  PUSH AF
  LD L,$0F
  CALL _GETVC2_0
  EX DE,HL
  LD HL,L0508
  LD BC,$0006
  LDIR
  POP AF
  POP BC
  POP HL
  POP DE
  ADD HL,DE
  EX DE,HL
  INC A
  CP $03
  JR C,GICINI_2
  LD A,$07
  LD E,$B8
  CALL _WRTPSG
  JP _POPALL

; Sound/Envelope table? at 1288, 6 bytes
L0508:
	DEFB $04,$04,$78,$88,$ff,$00
  

  

; This entry point is used by the routines at INITXT and _CHGMOD.
_INITXT:
  CALL _DISSCR
  XOR A
  LD (SCRMOD),A
  LD (OLDSCR),A
  LD A,(LINL40)
  LD (LINLEN),A
  LD HL,(TXTNAM)
  LD (NAMBAS),HL
  LD HL,(TXTCGP)
  LD (CGPBAS),HL
  CALL _CHGCLR
  CALL CLS_FORMFEED
  CALL COPY_FONT
  CALL _SETTXT
  JR _ENASCR

; Routine at 1336
;
; Used by the routines at INIT32 and _CHGMOD.
_INIT32:
  CALL _DISSCR
  LD A,$01
  LD (SCRMOD),A
  LD (OLDSCR),A
  LD A,(LINL32)
  LD (LINLEN),A
  LD HL,(T32NAM)		; SCREEN 1 name table
  LD (NAMBAS),HL
  LD HL,(T32CGP)		; SCREEN 1 character pattern table
  LD (CGPBAS),HL
  LD HL,(T32PAT)		; SCREEN 1 sprite pattern table
  LD (PATBAS),HL
  LD HL,(T32ATR)
  LD (ATRBAS),HL
  CALL _CHGCLR
  CALL CLS_FORMFEED
  CALL COPY_FONT
  CALL _CLRSPR_0
  CALL _SETT32
  
; This entry point is used by the routines at ENASCR, _INITXT, _INIGRP and _INIMLT.
_ENASCR:
  LD A,(RG1SAV)
  OR $40
  JR _DISSCR_0

; Routine at 1399
;
; Used by the routines at DISSCR, _INITXT, _INIT32, _INIGRP and _INIMLT.
_DISSCR:
  LD A,(RG1SAV)
  AND $BF
; This entry point is used by the routine at _INIT32.
_DISSCR_0:
  LD B,A
  LD C,$01
  
; This entry point is used by the routines at WRTVDP, _SETTXT, _SETT32, _SETGRP,
; _SETMLT, _CLRSPR and RESTORE_BORDER.
_WRTVDP:
  LD A,B
  DI
  OUT (VDP_CMD),A
  LD A,C
  OR $80
  OUT (VDP_CMD),A
  EI
  PUSH HL
  LD A,B
  LD B,$00
  LD HL,RG0SAV
  ADD HL,BC
  LD (HL),A
  POP HL
  RET

; Routine at 1428
;
; Used by the routines at SETTXT and _INITXT.
_SETTXT:
  LD A,(RG0SAV)
  AND $01
  LD B,A
  LD C,$00
  CALL _WRTVDP
  LD A,(RG1SAV)
  AND $E7
  OR $10
  LD B,A
  INC C
  CALL _WRTVDP
  LD HL,TXTNAM
  LD DE,$0000
  JP _SETMLT_0

; Routine at 1460
;
; Used by the routines at SETT32 and _INIT32.
_SETT32:
  LD A,(RG0SAV)
  AND $01
  LD B,A
  LD C,$00
  CALL _WRTVDP
  LD A,(RG1SAV)
  AND $E7
  LD B,A
  INC C
  CALL _WRTVDP
  LD HL,T32NAM		; SCREEN 1 name table
  LD DE,$0000
  JP _SETMLT_0

; Routine at 1490
;
; Used by the routines at INIGRP and _CHGMOD.
_INIGRP:
  CALL _DISSCR
  LD A,$02
  LD (SCRMOD),A
  LD HL,(GRPPAT)		; SCREEN 2 sprite pattern table
  LD (PATBAS),HL
  LD HL,(GRPATR)		; SCREEN 2 sprite attribute table
  LD (ATRBAS),HL
  LD HL,(GRPNAM)		; SCREEN 2 name table
  CALL _SETWRT
  XOR A
  LD B,$03
_INIGRP_0:
  OUT (VDP_DATA),A
  INC A
  JR NZ,_INIGRP_0
  DJNZ _INIGRP_0
  CALL L07A1
  CALL _CLRSPR_0
  CALL _SETGRP
  JP _ENASCR

; Routine at 1538
;
; Used by the routines at SETGRP and _INIGRP.

_SETGRP:
  LD A,(RG0SAV)
  OR $02
  LD B,A
  LD C,$00
  CALL _WRTVDP
  LD A,(RG1SAV)
  AND $E7
  LD B,A
  INC C
  CALL _WRTVDP
  LD HL,GRPNAM
  LD DE,$7F03
  JR _SETMLT_0

; Routine at 1567
;
; Used by the routines at INIMLT and _CHGMOD.
_INIMLT:
  CALL _DISSCR
  LD A,$03
  LD (SCRMOD),A
  LD HL,(MLTPAT)		; SCREEN 3 sprite pattern table
  LD (PATBAS),HL
  LD HL,(MLTATR)		; SCREEN 3 sprite attribute table
  LD (ATRBAS),HL
  LD HL,(MLTNAM)		; SCREEN 3 name table
  CALL _SETWRT
  LD DE,$0006
_INIMLT_0:
  LD C,$04
_INIMLT_1:
  LD A,D
  LD B,$20
_INIMLT_2:
  OUT (VDP_DATA),A
  INC A
  DJNZ _INIMLT_2
  DEC C
  JR NZ,_INIMLT_1
  LD D,A
  DEC E
  JR NZ,_INIMLT_0
  CALL CLS_MLT
  CALL _CLRSPR_0
  CALL _SETMLT
  JP _ENASCR

; Routine at 1625
;
; Used by the routines at SETMLT and _INIMLT.
_SETMLT:
  LD A,(RG0SAV)
  AND $01
  LD B,A
  LD C,$00
  CALL _WRTVDP
  LD A,(RG1SAV)
  AND $E7
  OR $08
  LD B,A
  LD C,$01
  CALL _WRTVDP
  LD HL,MLTNAM		; SCREEN 3 name table
  LD DE,$0000
; This entry point is used by the routines at _SETTXT, _SETT32 and _SETGRP.
_SETMLT_0:
  LD BC,$0602
  CALL _SETMLT_1
  LD B,$0A
  LD A,D
  CALL _SETMLT_2
  LD B,$05
  LD A,E
  CALL _SETMLT_2
  LD B,$09
  CALL _SETMLT_1
  LD B,$05
_SETMLT_1:
  XOR A
_SETMLT_2:
  PUSH HL
  PUSH AF
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  XOR A
_SETMLT_3:
  ADD HL,HL
  ADC A,A
  DJNZ _SETMLT_3
  LD L,A
  POP AF
  OR L
  LD B,A
  CALL _WRTVDP
  POP HL
  INC HL
  INC HL
  INC C
  RET

; Routine at 1704
;
; Used by the routine at CLRSPR.
_CLRSPR:
  LD A,(RG1SAV)
  LD B,A
  LD C,$01
  CALL _WRTVDP
  LD HL,(PATBAS)
  LD BC,$0800		; 2048
  XOR A
  CALL _FILVRM
  
; This entry point is used by the routines at _INIT32, _INIGRP and _INIMLT.
_CLRSPR_0:
  LD A,(FORCLR)
  LD E,A
  LD HL,(ATRBAS)
  LD BC,$2000
_CLRSPR_1:
  LD A,$D1
  CALL _WRTVRM
  INC HL
  INC HL
  LD A,C
  CALL _WRTVRM
  INC HL
  INC C
  LD A,(RG1SAV)
  RRCA
  RRCA
  JR NC,_CLRSPR_2
  INC C
  INC C
  INC C
_CLRSPR_2:
  LD A,E
  CALL _WRTVRM
  INC HL
  DJNZ _CLRSPR_1
  RET

; Routine at 1764
;
; Used by the routine at CALPAT.
_CALPAT:
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  CALL _GSPSIZ
  CP $08
  JR Z,_CALPAT_0
  ADD HL,HL
  ADD HL,HL
_CALPAT_0:
  EX DE,HL
  LD HL,(PATBAS)
  ADD HL,DE
  RET

; Routine at 1785
;
; Used by the routine at CALATR.
_CALATR:
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  EX DE,HL
  LD HL,(ATRBAS)
  ADD HL,DE
  RET

; Routine at 1796
;
; Used by the routines at GSPSIZ and _CALPAT.
_GSPSIZ:
  LD A,(RG1SAV)
  RRCA
  RRCA
  LD A,$08
  RET NC
  LD A,$20
  RET

; Routine at 1807
;
; Used by the routines at LDIRMV and ESC_L_2.
_LDIRMV:
  CALL _SETRD
  EX (SP),HL
  EX (SP),HL
_LDIRMV_0:
  IN A,(VDP_DATAIN)
  LD (DE),A
  INC DE
  DEC BC
  LD A,C
  OR B
  JR NZ,_LDIRMV_0
  RET

; Routine at 1822
;
; Used by the routines at _INITXT and _INIT32.
COPY_FONT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HINIP			;  Hook to Copy character set to VDP
ENDIF
  LD HL,(CGPBAS)
  CALL _SETWRT
  LD A,(SLOTID)
  LD HL,(CHFONT)
  LD BC,$0800			; FONT LENGTH: 2048 bytes 
  PUSH AF
COPY_FONT_0:
  POP AF
  PUSH AF
  PUSH BC
  DI
  CALL _RDSLT
  EI
  POP BC
  OUT (VDP_DATA),A
  INC HL
  DEC BC
  LD A,C
  OR B
  JR NZ,COPY_FONT_0
  POP AF
  RET

; Routine at 1860
;
; Used by the routines at LDIRVM and RESET_CONSOLE.
_LDIRVM:
  EX DE,HL
  CALL _SETWRT
_LDIRVM_0:
  LD A,(DE)
  OUT (VDP_DATA),A
  INC DE
  DEC BC
  LD A,C
  OR B
  JR NZ,_LDIRVM_0
  RET

; Routine at 1874
;
; Used by the routine at _GRPPRT.
L0752:
  LD H,$00
  LD L,A
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  EX DE,HL
  LD HL,(CHFONT)
  ADD HL,DE
  LD DE,PATWRK
  LD B,$08
  LD A,(SLOTID)
L0752_0:
  PUSH AF
  PUSH HL
  PUSH DE
  PUSH BC
  CALL _RDSLT
  EI
  POP BC
  POP DE
  POP HL
  LD (DE),A
  INC DE
  INC HL
  POP AF
  DJNZ L0752_0
  RET

; Routine at 1911
;
; Used by the routine at _CLS.
CLS:
  CALL IS_TXT
  JR Z,L07A1
  JR NC,CLS_MLT
; This entry point is used by the routines at _INITXT and _INIT32.
CLS_FORMFEED:
  LD A,(SCRMOD)
  AND A
  LD HL,(NAMBAS)
  LD BC,$03C0		; 960  (40*24)
  JR Z,CLS_1
  LD BC,$0300		; 768	(32x24)
CLS_1:
  LD A,' '
  CALL _FILVRM
  CALL CURS_HOME
  LD HL,LINTTB
  LD B,$18
CLS_2:
  LD (HL),B
  INC HL
  DJNZ CLS_2
  JP _FNKSB			; Check if function key display is active, and display the FN list if so...

; Routine at 1953
;
; Used by the routines at _INIGRP and CLS.
L07A1:
  CALL RESTORE_BORDER
  LD BC,$1800
  PUSH BC
  LD HL,(GRPCOL)		; SCREEN 2 color table
  LD A,(BAKCLR)
  CALL _FILVRM
  LD HL,(GRPCGP)		; SCREEN 2 character pattern table
  POP BC
  XOR A
  ; --- START PROC L07B6 ---
__FILVRM:
  JP _FILVRM

; Data block at 1977
  ; --- START PROC CLS_MLT ---
CLS_MLT:
  CALL RESTORE_BORDER
  LD HL,BAKCLR
  LD A,(HL)
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  OR (HL)
  LD HL,(MLTCGP)		; SCREEN 3 character pattern table
  LD BC,$0600		; 64*24
  JR __FILVRM

; Routine at 1997
;
; Used by the routines at WRTVRM, _CLRSPR, _NSETCX and L18AA.
_WRTVRM:
  PUSH AF
  CALL _SETWRT
  EX (SP),HL
  EX (SP),HL
  POP AF
  OUT (VDP_DATA),A
  RET

; Routine at 2007
;
; Used by the routines at RDVRM and L166C.
; $07D7
_RDVRM:
  CALL _SETRD
  EX (SP),HL
  EX (SP),HL
  IN A,(VDP_DATAIN)
  RET

; Routine at 2015
;
; Used by the routines at SETWRT, _INIGRP, _INIMLT, COPY_FONT, _LDIRVM, _WRTVRM, ESC_CLINE and
; OUT_CHAR.
_SETWRT:
  LD A,L
  DI
  OUT (VDP_CMD),A
  LD A,H
  AND $3F
  OR $40
  OUT (VDP_CMD),A
  EI
  RET

; Routine at 2028
;
; Used by the routines at SETRD, _LDIRMV, _RDVRM and L0BD8.
_SETRD:
  LD A,L
  DI
  OUT (VDP_CMD),A
  LD A,H
  AND $3F
  OUT (VDP_CMD),A
  EI
  RET

  ; --- START PROC L07F7 ---
_CHGCLR:
  LD A,(SCRMOD)
  DEC A
  JP M,_CHGCLR_0
  PUSH AF
  CALL RESTORE_BORDER
  POP AF
  RET NZ
  LD A,(FORCLR)		; Foreground color 
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD HL,BAKCLR
  OR (HL)
  LD HL,(T32COL)		; SCREEN 1 color table
  LD BC,32

_FILVRM:
  PUSH AF
  CALL _SETWRT
_FILVRM_0:
  POP AF
  OUT (VDP_DATA),A
  PUSH AF
  DEC BC
  LD A,C
  OR B
  JR NZ,_FILVRM_0
  POP AF
  RET
  
_CHGCLR_0:
  LD A,(FORCLR)		; Foreground color 
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD HL,BAKCLR
  OR (HL)
  LD B,A
  JR SETBORDER

  
; Routine at 2098
;
; Used by the routine at L07A1.
RESTORE_BORDER:
  LD A,(BDRCLR)
SETBORDER:
  LD B,A
  LD C,$07
  JP _WRTVDP

; Routine at 2107
;
; Used by the routines at TOTEXT and L043F.
_TOTEXT:
  CALL IS_TXT
  RET C
  LD A,(OLDSCR)
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HTOTE		; Hook for the TOTEXT std routine
ENDIF
  JP _CHGMOD		; Sets the VDP mode according to SCRMOD.

; Routine at 2120
;
; Used by the routine at __CLS.
_CLS:
  RET NZ
  PUSH HL
  CALL CLS
  POP HL
  RET

; Routine at 2127
;
; Used by the routines at CHGMOD and _TOTEXT.
; Sets the VDP mode according to SCRMOD.
_CHGMOD:
  DEC A
  JP M,_INITXT
  JP Z,_INIT32
  DEC A
  JP Z,_INIGRP
  JP _INIMLT

; Routine at 2141
;
; Used by the routines at LPTOUT and L1BA2.
_LPTOUT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLPTO		; Hook for "LPTOUT"
ENDIF
  PUSH AF
_LPTOUT_0:
  CALL _BREAKX		; Set CY if STOP is pressed
  JR C,LPTOUT_BRK
  CALL _LPTSTT
  JR Z,_LPTOUT_0
  POP AF
; This entry point is used by the routine at LPTOUT_BRK.
_LPTOUT_1:
  PUSH AF
  OUT (PRN_DATA),A
  XOR A
  OUT (PRN_STB),A
  DEC A
  OUT (PRN_STB),A
  POP AF
  AND A
  RET

  
; Routine at 2168
;
; Used by the routine at _LPTOUT.
LPTOUT_BRK:
  XOR A
  LD (LPTPOS),A
  LD A,CR
  CALL _LPTOUT_1
  POP AF
  SCF
  RET

; Routine at 2180
;
; Used by the routines at LPTSTT and _LPTOUT.
_LPTSTT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLPTS		;  Hook for LPTSTT
ENDIF
  IN A,(PRN_STATUS)
  RRCA
  RRCA
  CCF
  SBC A,A
  RET

; Routine at 2190
;
; Used by the routines at POSIT and TTY_CR.
_POSIT: 		; Locate cursor at the specified position
  LD A,ESC
  RST OUTDO  		; Output char to the current device
  LD A,'Y'			; ESC_Y, set cursor coordinates
  RST OUTDO  		; Output char to the current device
  LD A,L
  ADD A,$1F			; L+31
  RST OUTDO  		; Output char to the current device
  LD A,H
  ADD A,$1F			; H+31
  RST OUTDO  		; Output char to the current device
  RET

; Routine at 2205
;
; Used by the routines at SNVCHR, CHPUT_CONT, _FNKSB and OUTC_TABEXP.
; A.K.A. CNVCHR (Convert Character)
_SNVCHR:
  PUSH HL
  PUSH AF
  LD HL,GRPHED
  XOR A
  CP (HL)
  LD (HL),A
  JR Z,_SNVCHR_SUB
  POP AF
  SUB $40	; 'A'-1 ?
  CP $20
  JR C,_SNVCHR_1
  ADD A,$40
; This entry point is used by the routine at _SNVCHR_SUB.
_SNVCHR_0:
  CP A
  SCF
_SNVCHR_1:
  POP HL
  RET

; Routine at 2228
;
; Used by the routine at _SNVCHR.
_SNVCHR_SUB:
  POP AF
  CP $01
  JR NZ,_SNVCHR_0
  LD (HL),A
  POP HL
  RET

; Routine at 2236
;
; Used by the routines at CHPUT and _OUTCON.
_CHPUT:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCHPU			; Hook for CHPUT event (A-character; SAVE ALL)
ENDIF
  CALL IS_TXT
  JR NC,_POPALL
  CALL ERASE_CURSOR
  POP AF
  PUSH AF
  CALL CHPUT_CONT
  CALL DISP_CURSOR
  LD A,(CSRX)
  DEC A
  LD (TTYPOS),A
; This entry point is used by the routines at _INITIO and L1574.
_POPALL:
  POP AF
; This entry point is used by the routines at L0D89, _CHGET and L11E2.
_CHPUT_1:
  POP BC
  POP DE
  POP HL
  RET

; Routine at 2271
;
; Used by the routines at _CHPUT and CURS_TAB.
CHPUT_CONT:
  CALL _SNVCHR
  RET NC
  LD C,A
  JR NZ,L08F3
  LD HL,ESCCNT
  LD A,(HL)
  AND A			; Are we in ESCAPE or in some special 'control code' mode ?
  JP NZ,ESC_PROC
  LD A,C
  CP ' '		; < ' ' ?
  JR C,TTY_JP_0
L08F3:
  LD HL,(CSRY)
IF SPECTRUM_SKIN
  ; Unbind CHR$(127) and make it printable
ELSE
  CP $7F		; 'DEL' key code
  JP Z,DELCHR
ENDIF
  CALL OUT_CHAR
  CALL ESC_C
  RET NZ
  XOR A
  CALL SETTRM
  LD H,$01
CURS_LF:
  CALL CURS_DOWN
  RET NZ
  CALL SV_CURS_POS
  LD L,$01
  JP ESC_M_0	; ESC,"M", delete line

; Routine at 2324
;
; Used by the routine at CHPUT_CONT.
; $0914:  Character control code processor
TTY_JP_0:
  LD HL,TTY_CTLCODES-2
  LD C,12
; This entry point is used by the routines at ESC_PROC and _QINLIN.
; Parse the jump table in HL for C entries
TTY_JP:
  INC HL
  INC HL
  AND A
  DEC C
  RET M
  CP (HL)
  INC HL
  JR NZ,TTY_JP
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD HL,(CSRY)
  CALL JP_BC
  XOR A
  RET

; Routine at 2349
;
; Used by the routine at TTY_JP_0.
JP_BC:
  PUSH BC
  RET

; First TTY JP table (12 entries)
TTY_CTLCODES:

  DEFB BEL		; BELL, go beep
  DEFW _BEEP
  
  DEFB $08		; BS, cursor left
  DEFW CURS_LEFT
  
  DEFB $09		; TAB, cursor to next tab position
  DEFW CURS_TAB
  
  DEFB LF		; LF, cursor down a row
  DEFW CURS_LF
  
  DEFB $0b		; HOME, cursor to home
  DEFW CURS_HOME
  
  DEFB FF		; FORMFEED, clear screen and home
  DEFW CLS_FORMFEED
  
  DEFB $0d		; CR, cursor to leftmost column
  DEFW CURS_CR
  
  DEFB $1b		; ESC, enter escape sequence
  DEFW ENTER_ESC
  
  DEFB $1c		; RIGHT, cursor right
  DEFW CURS_RIGHT
  
  DEFB $1d		; LEFT, cursor left
  DEFW CURS_LEFT
  
  DEFB $1e		; UP, cursor up
  DEFW CURS_UP
  
  DEFB $1f		; DOWN, cursor down.
  DEFW CURS_DOWN

  
; Second TTY JP table (15 entries)
TTY_ESC:
  DEFB $6a		; ESC,"j", clear screen and home
  DEFW CLS_FORMFEED		
  
  DEFB $45		; ESC,"E", clear screen and home
  DEFW CLS_FORMFEED
  
  DEFB $4b		; ESC,"K", clear to end of line
  DEFW ESC_K
  
  DEFB $4a		; ESC,"J", clear to end of screen
  DEFW ESC_J
  
  DEFB $6c		; ESC,"l", clear line
  DEFW ESC_CLINE
  
  DEFB $4c		; ESC,"L", insert line
  DEFW ESC_L
  
  DEFB $4d		; ESC,"M", delete line
  DEFW ESC_M
  
  DEFB 'Y'		; ESC,"Y", set cursor coordinates
  DEFW ESC_Y
  
  DEFB $41		; ESC,"A", cursor up
  DEFW CURS_UP
  
  DEFB $42		; ESC,"B", cursor down
  DEFW CURS_DOWN

  DEFB $43		; ESC,"C", cursor right
  DEFW ESC_C
  
  DEFB $44		; ESC,"D", cursor left
  DEFW ESC_D+1
  
  DEFB $48		; ESC,"H", cursor home
  DEFW CURS_HOME
  
  DEFB $78		; ESC,"x", change cursor
  DEFW ESC_CURSOR_X
  
  DEFB $79		; ESC,"y", change cursor
  DEFW ESC_CURSOR_Y
  
  
ESC_CURSOR_X:
; ESC,"x", change cursor, see ESC_CURS
  LD A,$01
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
ESC_CURSOR_Y:
; ESC,"y", change cursor, see ESC_CURS
  LD A,$02

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; ESC,"Y", set cursor coordinates, see ESC_CURS
ESC_Y:
  LD A,$04

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; 'ESCAPE' sequence handling
ENTER_ESC:
  LD A,$FF
  
L098B:
  LD (ESCCNT),A
  RET

; Routine at 2447
;
; Used by the routine at CHPUT_CONT.
; "ESC sequence processor"
ESC_PROC:
  JP P,ESC_CURS
; In-Escape
  LD (HL),$00
  LD A,C
  LD HL,TTY_ESC-2
  LD C,15
  JP TTY_JP

; Routine at 2461
;
; Used by the routine at ESC_PROC.
; different "Escape-Like" status flags
ESC_CURS:
  DEC A
  JR Z,CHG_CURSOR_X		; ESC,"x", change cursor
  DEC A
  JR Z,CHG_CURSOR_Y		; ESC,"y", change cursor
  DEC A
; ESC,"Y", set cursor coordinates (row,column)
  LD (HL),A
  LD A,(LINLEN)
  LD DE,CSRX
  JR Z,ESC_CURS_0
  LD (HL),$03
  CALL TEXT_LINES
  DEC DE
ESC_CURS_0:
  LD B,A
  LD A,C
  SUB $20	;Top left of screen is n=m=20h.
  CP B
  INC A
  LD (DE),A
  RET C
  LD A,B
  LD (DE),A
  RET

; Routine at 2494
;
; Used by the routine at ESC_CURS.
CHG_CURSOR_X:
  LD (HL),A
  LD A,C
  SUB '4'
  JR Z,SET_CSTYLE	; Set block cursor style
  DEC A			; Cursor off
  JR Z,SET_CRSW
  RET

; Routine at 2504
;
; Used by the routine at ESC_CURS.
CHG_CURSOR_Y:
  LD (HL),A
  LD A,C
  SUB '4'
  JR NZ,CURSOR_ON

  INC A		; Set underscore cursor style
; This entry point is used by the routine at CHG_CURSOR_X.
SET_CSTYLE:
  LD (CSTYLE),A
  RET

; Routine at 2515
;
; Used by the routine at CHG_CURSOR_Y.
CURSOR_ON:
  DEC A
  RET NZ
  INC A
; This entry point is used by the routine at CHG_CURSOR_X.
SET_CRSW:
  LD (CSRSW),A
  RET

; Routine at 2522
;
; Used by the routines at _ISCNTC and _CHGET.
L09DA:
  LD A,(CSRSW)
  AND A
  RET NZ
  JR DISP_CURSOR_0

; Routine at 2529
;
; Used by the routines at _CHPUT, L2428, TTY_CR, L24F2, L2535, L2550 and L25CD.
DISP_CURSOR:
  LD A,(CSRSW)
  AND A
  RET Z
; This entry point is used by the routine at L09DA.
DISP_CURSOR_0:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDSPC			; Hook for "Display Cursor" event
ENDIF
  CALL IS_TXT
  RET NC
  LD HL,(CSRY)
  PUSH HL
  CALL L0BD8
  LD (CODSAV),A
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  EX DE,HL
  LD HL,(CGPBAS)
; L0A01:
  PUSH HL
  ADD HL,DE
  CALL RD_CURSOR_PIC
  LD HL,LINWRK + 7			; $FC1F
  LD B,$08		; block cursor style
  LD A,(CSTYLE)
  AND A
  JR Z,DISP_CURSOR_1
  LD B,$03		; "underscore" cursor style
DISP_CURSOR_1:
  LD A,(HL)
  CPL			; Toggle cursor block
  LD (HL),A
  DEC HL
  DJNZ DISP_CURSOR_1
  POP HL
  LD BC,$07F8		; 2040
  ADD HL,BC
  CALL WR_CURSOR_PIC
  POP HL
  LD C,$FF
  JP OUT_CHAR

; Routine at 2599
;
; Used by the routines at _ISCNTC and _CHGET.
L0A27:
  LD A,(CSRSW)
  AND A
  RET NZ
  JR ERASE_CURSOR_0

; Routine at 2606
;
; Used by the routines at _CHPUT, L2428, TTY_CR, L24F2, L2550, L25AE, L25B9,
; L25D7, L25F8 and L260E.
ERASE_CURSOR:
  LD A,(CSRSW)
  AND A
  RET Z
; This entry point is used by the routine at L0A27.
ERASE_CURSOR_0:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HERAC			;  Hook for "Erase cursor" event
ENDIF
  CALL IS_TXT
  RET NC
  LD HL,(CSRY)
  LD A,(CODSAV)
  LD C,A
  JP OUT_CHAR

; Routine at 2628
;
; Used by the routines at CHPUT_CONT and CURS_RIGHT.
; ESC,"C", cursor right
ESC_C:
  LD A,(LINLEN)
  CP H
  RET Z
  INC H
  JR SV_CURS_POS

; Routine at 2636
;
; Used by the routines at DELCHR and L2634.
CURS_LEFT:
  CALL ESC_D+1		; ESC,"D", cursor left
  RET NZ
  LD A,(LINLEN)
  LD H,A
ESC_D:
	; ESC_D+1:	DEC H / LD A,n  (Toggle DEC H / DEC L)
  LD DE,$3E25
CURS_UP:
  DEC L
  RET Z
  JR SV_CURS_POS

; Routine at 2651
;
; Used by the routines at L25D7, L260E and L2624.
CURS_RIGHT:
  CALL ESC_C		; ESC,"C", cursor right
  RET NZ
  LD H,$01
; This entry point is used by the routine at CHPUT_CONT.
CURS_DOWN:
  CALL TEXT_LINES
  CP L
  RET Z
  JR C,L0A6D
  INC L
; This entry point is used by the routines at CHPUT_CONT, ESC_C, CURS_LEFT, L0A6D and CURS_HOME.
SV_CURS_POS:
  LD (CSRY),HL
  RET

; Routine at 2669
;
; Used by the routine at CURS_RIGHT.
L0A6D:
  DEC L
  XOR A
  JR SV_CURS_POS

; Routine at 2673
CURS_TAB:
  LD A,' '
  CALL CHPUT_CONT
  LD A,(CSRX)
  DEC A
  AND $07
  JR NZ,CURS_TAB
  RET

; Routine at 2687
;
; Used by the routine at CLS.
CURS_HOME:
  LD L,$01
; This entry point is used by the routines at ESC_M and ESC_L.
CURS_CR:
  LD H,$01
  JR SV_CURS_POS

; Routine at 2693
; ESC,"M", delete line
ESC_M:
  CALL CURS_CR
; This entry point is used by the routines at CHPUT_CONT and L2535.
ESC_M_0:
  CALL TEXT_LINES
  SUB L
  RET C
  JP Z,ESC_CLINE		; ESC,"l", clear line
  PUSH HL
  PUSH AF
  LD C,A
  LD B,$00
  CALL GETTRM
  LD L,E
  LD H,D
  INC HL
  LDIR
  LD HL,FSTPOS
  DEC (HL)
  POP AF
  POP HL
ESC_M_1:
  PUSH AF
  INC L
  CALL ESC_L_2
  DEC L
  CALL RESET_CONSOLE
  INC L
  POP AF
  DEC A
  JR NZ,ESC_M_1
  JP ESC_CLINE		; ESC,"l", clear line

; Routine at 2740
; ESC,"L", insert line
ESC_L:
  CALL CURS_CR
; This entry point is used by the routine at L2524.
ESC_L_0:
  CALL TEXT_LINES
  LD H,A
  SUB L
  RET C
  JP Z,ESC_CLINE		; ESC,"l", clear line
  LD L,H
  PUSH HL
  PUSH AF
  LD C,A
  LD B,$00
  CALL GETTRM
  LD L,E
  LD H,D
  PUSH HL
  DEC HL
  LDDR
  POP HL
  LD (HL),H
  POP AF
  POP HL
ESC_L_1:
  PUSH AF
  DEC L
  CALL ESC_L_2
  INC L
  CALL RESET_CONSOLE
  DEC L
  POP AF
  DEC A
  JR NZ,ESC_L_1
  JR ESC_CLINE		; ESC,"l", clear line

; Routine at 2787
;
; Used by the routine at CHPUT_CONT.
; Outputting the code for 'DELETE'
DELCHR:
  CALL CURS_LEFT
  RET Z
  LD C,' '
  JP OUT_CHAR

; Routine at 2796
;
; Used by the routines at ESC_M, ESC_L and _ERAFNK.
; ESC,"l", clear line
ESC_CLINE:
  LD H,$01
; This entry point is used by the routines at ESC_J and L25B9.
; ESC,"K", clear to end of line
ESC_K:
  CALL TERMIN
  PUSH HL
  CALL TXT_LOC
  CALL _SETWRT
  POP HL
ESC_CLINE_1:
  LD A,' '
  OUT (VDP_DATA),A
  INC H
  LD A,(LINLEN)
  CP H
  JR NC,ESC_CLINE_1
  RET

; Routine at 2821
; ESC,"J", clear to end of screen
ESC_J:
  PUSH HL
  CALL ESC_K	; ESC,"K", clear to end of line
  POP HL
  CALL TEXT_LINES
  CP L
  RET C
  RET Z
  LD H,$01
  INC L
  JR ESC_J

; Routine at 2837
;
; Used by the routine at ERAFNK.
_ERAFNK:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HERAF			; Hook for ERAFNK std routine(no param.)
ENDIF
  XOR A
  CALL UPD_CNSDFG
  RET NC
  PUSH HL
  LD HL,(CRTCNT)
  CALL ESC_CLINE		; ESC,"l", clear line
  POP HL
  RET

; Routine at 2854
;
; Used by the routines at FNKSB and CLS.
; Check if function key display is active, and display the FN list if so...
_FNKSB:
  LD A,(CNSDFG)		; FN key status
  AND A
  RET Z

; This entry point is used by the routines at DSPFNK and _CHSNS.
; Show the function key display.
_DSPFNK:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDSPF		; Hook for DSPFNK std routine(no param.)
ENDIF
  LD A,$FF
  CALL UPD_CNSDFG
  RET NC
  PUSH HL
  LD A,(CSRY)
  LD HL,CRTCNT
  CP (HL)
  LD A,LF
  JR NZ,_FNKSB_1
  RST OUTDO  		; Output char to the current device
_FNKSB_1:
  LD A,($FBEB)		; KBD ROW #6
  RRCA
  LD HL,FNKSTR
  LD A,$01
  JR C,_FNKSB_2
  LD HL,FNKSTR+80
  XOR A
_FNKSB_2:
  LD (FNKSWI),A
  LD DE,LINWRK
  PUSH DE
  LD B,40
  LD A,' '
_FNKSB_3:
  LD (DE),A
  INC DE
  DJNZ _FNKSB_3
  POP DE
  LD C,$05
  LD A,(LINLEN)
  SUB $04
  JR C,_FNKSB_8
  LD B,$FF
_FNKSB_4:
  INC B
  SUB $05
  JR NC,_FNKSB_4
  LD A,B
  AND A
  JR Z,_FNKSB_8

  DEFB $3E  ; "LD A,n" to Mask the next byte
L0B75:
  INC DE
  PUSH BC
  LD C,$00
_FNKSB_5:
  LD A,(HL)
  INC HL
  INC C
  CALL _SNVCHR
  JR NC,_FNKSB_5
  JR NZ,_FNKSB_6
  CP ' '
  JR C,_FNKSB_7
_FNKSB_6:
  LD (DE),A
_FNKSB_7:
  INC DE
  DJNZ _FNKSB_5
  LD A,$10
  SUB C
  LD C,A
  ADD HL,BC
  POP BC
  DEC C
  JR NZ,L0B75
_FNKSB_8:
  LD HL,(CRTCNT)
  CALL RESET_CONSOLE
  POP HL
  RET

; Routine at 2972
;
; Used by the routines at _ERAFNK and _FNKSB.
UPD_CNSDFG:
  LD (CNSDFG),A		; FN key status
; This entry point is used by the routines at CLS, _TOTEXT, _CHPUT, DISP_CURSOR, ERASE_CURSOR and _CHSNS.
IS_TXT:
  LD A,(SCRMOD)
  CP $02
  RET

; Routine at 2981
;
; Used by the routine at DISP_CURSOR.
RD_CURSOR_PIC:
  PUSH HL
  LD C,$08		; 8 bytes for cursor "shape"
  JR ESC_L_2_0

; Routine at 2986
;
; Used by the routines at ESC_M and ESC_L.
ESC_L_2:
  PUSH HL
  LD H,$01
  CALL TXT_LOC
  LD A,(LINLEN)
  LD C,A
; This entry point is used by the routine at RD_CURSOR_PIC.
ESC_L_2_0:
  LD B,$00		; byte counter in C only
  LD DE,LINWRK
  CALL _LDIRMV	; VRAM to DE
  POP HL
  RET

; Routine at 3006
;
; Used by the routine at DISP_CURSOR.
WR_CURSOR_PIC:
  PUSH HL
  LD C,$08			; 8 bytes for cursor "shape"
  JR RESET_CONSOLE_0

; Routine at 3011
;
; Used by the routines at ESC_M, ESC_L and _FNKSB.
RESET_CONSOLE:
  PUSH HL
  LD H,$01
  CALL TXT_LOC
  LD A,(LINLEN)
  LD C,A
; This entry point is used by the routine at WR_CURSOR_PIC.
RESET_CONSOLE_0:
  LD B,$00
  EX DE,HL
  LD HL,LINWRK
  CALL _LDIRVM
  POP HL
  RET

; Routine at 3032
;
; Used by the routines at DISP_CURSOR, TTY_CR, L24F2, L2550, L25D7 and L2634.
L0BD8:
  PUSH HL
  CALL TXT_LOC
  CALL _SETRD
  EX (SP),HL
  EX (SP),HL
  IN A,(VDP_DATAIN)
  LD C,A
  POP HL
  RET

; Routine at 3046
;
; Used by the routines at CHPUT_CONT, DISP_CURSOR, ERASE_CURSOR, DELCHR, L24F2 and L2550.
;
OUT_CHAR:
  PUSH HL
  CALL TXT_LOC
  CALL _SETWRT
  LD A,C
  OUT (VDP_DATA),A
  POP HL
  RET

; Routine at 3058
;
; Used by the routines at ESC_CLINE, ESC_L_2, RESET_CONSOLE, L0BD8 and OUT_CHAR.
TXT_LOC:
  PUSH BC
  LD E,H
  LD H,$00
  LD D,H
  DEC L
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL		; *8
  LD C,L
  LD B,H
  ADD HL,HL
  ADD HL,HL		; *32
  ADD HL,DE		; -> *40
  LD A,(SCRMOD)
  AND A
  LD A,(LINLEN)
  JR Z,TXTLOC_SUB
  SUB $22
  JR TXTLOC_SUB_0

; Routine at 3085
;
; Used by the routine at TXT_LOC.
TXTLOC_SUB:
  ADD HL,BC
  SUB $2A		; '*'? TK_CVD ?
; This entry point is used by the routine at TXT_LOC.
TXTLOC_SUB_0:
  CPL
  AND A
  RRA
  LD E,A
  ADD HL,DE
  EX DE,HL
  LD HL,(NAMBAS)
  ADD HL,DE
  DEC HL
  POP BC
  RET

; Routine at 3101
;
; Used by the routines at ESC_M, ESC_L, TERMIN, TTY_CR, L24C4, L24F2, L2550,
; L25B9, L25D7 and L266C.
; LD A,(DE+L)	..
GETTRM:
  PUSH HL
  LD DE,BASROM
  LD H,$00
  ADD HL,DE
  LD A,(HL)
  EX DE,HL
  POP HL
  AND A
  RET

; Routine at 3113
;
; Used by the routines at ESC_CLINE, _QINLIN and TTY_CR.
TERMIN:
	;TERMIN+1: XOR A
  LD A,$AF
; This entry point is used by the routine at CHPUT_CONT.
SETTRM:
  PUSH AF
  CALL GETTRM
  POP AF
  LD (DE),A
  RET

; Routine at 3122
;
; Used by the routines at ESC_CURS, CURS_RIGHT, ESC_M, ESC_L, ESC_J, L2524 and L2624.
TEXT_LINES:
  LD A,(CNSDFG)		; FN key status
  PUSH HL
  LD HL,CRTCNT
  ADD A,(HL)		; Number of lines on screen 
  POP HL
  RET

; This entry point is used by the routine at KEYINT.
_KEYINT:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  EXX
  EX AF,AF'
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  PUSH IY
  PUSH IX
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HKEYI 		; First interrupt handler hook
ENDIF
  IN A,(VDP_STATUS)
  AND A
  JP P,_KEYINT_2
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HTIMI			; Hook 2 for Interrupt handler
	ENDIF
  EI
  LD (STATFL),A
  AND $20
  LD HL,IFLG_COLLSN		; Sprite collision - Interrupt flags
  CALL NZ,TST_IFLG_EVENT
  LD HL,(INTCNT)
  DEC HL
  LD A,H
  OR L
  JR NZ,_KEYINT_0
  LD HL,IFLG_TIMER			; TIMER - Interrupt flags
  CALL TST_IFLG_EVENT
  LD HL,(INTVAL)
_KEYINT_0:
  LD (INTCNT),HL
  LD HL,(JIFFY)
  INC HL
  LD (JIFFY),HL
  LD A,(MUSICF)
  LD C,A
  XOR A
_KEYINT_1:
  RR C
  PUSH AF
  PUSH BC
  CALL C,L113B
  POP BC
  POP AF
  INC A
  CP $03
  JR C,_KEYINT_1
  LD HL,SCNCNT		; a.k.a. KYREPT, Wait count for repeat
  DEC (HL)
  JR NZ,_KEYINT_2
  LD (HL),$01
  XOR A
  CALL _GTSTCK_2
  AND $30
  PUSH AF
  LD A,$01
  CALL _GTSTCK_2
  AND $30
  RLCA
  RLCA
  POP BC
  OR B
  PUSH AF
  CALL _GTSTCK_5
  AND $01
  POP BC
  OR B
  LD C,A
  LD HL,TRGFLG
  XOR (HL)
  AND (HL)
  LD (HL),C
  LD C,A
  RRCA
  LD HL,IFLG_STRIG0			; SPACE key trigger - Interrupt flags
  CALL C,TST_IFLG_EVENT
  RL C
  LD HL,IFLG_STRIG4			; Joystick 2, Fire 2 - Interrupt flags
  CALL C,TST_IFLG_EVENT
  RL C
  LD HL,IFLG_STRIG2			; Joystick 2, Fire 1 - Interrupt flags
  CALL C,TST_IFLG_EVENT
  RL C
  LD HL,IFLG_STRIG3			; Joystick 1, Fire 2 - Interrupt flags
  CALL C,TST_IFLG_EVENT
  RL C
  LD HL,IFLG_STRIG1			; Joystick 1, Fire 1 - Interrupt flags
  CALL C,TST_IFLG_EVENT
  XOR A
  LD (CLIKFL),A
  CALL L0D12
  JR NZ,_KEYINT_2
  LD HL,REPCNT
  DEC (HL)
  JR NZ,_KEYINT_2
  LD (HL),$01
  LD HL,OLDKEY
  LD DE,OLDKEY+1
  LD BC,$000A
  LD (HL),$FF
  LDIR
  CALL L0D49_0
_KEYINT_2:
  POP IX
  POP IY
  POP AF
  POP BC
  POP DE
  POP HL
  EX AF,AF'
  EXX
  POP AF
  POP BC
  POP DE
  POP HL
  EI
  RET

; Routine at 3346
;
; Used by the routine at _KEYINT.
L0D12:
  IN A,(PPI_C)			; $9A on SVI
  AND $F0
  LD C,A
  LD B,$0B
  LD HL,NEWKEY
L0D12_0:
  LD A,C
  OUT (PPI_COUT),A			; $96 on SVI
  IN A,(PPI_B)			; $99 on SVI
  LD (HL),A
  INC C
  INC HL
  DJNZ L0D12_0
  LD A,(ENSTOP)
  AND A
  JR Z,L0D3A
  
L0D2C:
  LD A,($FBEB)				; KBD ROW #6
  CP $E8					; CTRL-STOP  ?
  JR NZ,L0D3A
  LD IX,WARM_BT
  JP _CALBAS

; Routine at 3386
;
; Used by the routine at L0D12.
L0D3A:
  LD DE,NEWKEY
  LD B,$0B
L0D3A_0:
  DEC DE
  DEC HL
  LD A,(DE)
  CP (HL)
  JR NZ,L0D49
  DJNZ L0D3A_0
  JR L0D49_0

; Routine at 3401
;
; Used by the routine at L0D3A.
L0D49:
  LD A,$0D
  LD (REPCNT),A
; This entry point is used by the routines at _KEYINT and L0D3A.
L0D49_0:
  LD B,$0B
  LD HL,OLDKEY
  LD DE,NEWKEY
L0D49_1:
  LD A,(DE)
  LD C,A
  XOR (HL)
  AND (HL)
  LD (HL),C
  CALL NZ,L0D89
  INC DE
  INC HL
  DJNZ L0D49_1
; This entry point is used by the routine at _CHSNS.
L0D49_2:
  LD HL,(GETPNT)
  LD A,(PUTPNT)
  SUB L
  RET

; Routine at 3434
;
; Used by the routines at CHSNS and _CHGET.
_CHSNS:
  EI
  PUSH HL
  PUSH DE
  PUSH BC
  CALL IS_TXT
  JR NC,_CHSNS_0
  LD A,(FNKSWI)
  LD HL,$FBEB				; KBD ROW #6
  XOR (HL)
  LD HL,CNSDFG		; FN key status
  AND (HL)
  RRCA
  CALL C,_DSPFNK		; Show the function key display.
_CHSNS_0:
  CALL L0D49_2
  POP BC
  POP DE
  POP HL
  RET

; Routine at 3465
;
; Used by the routine at L0D49.
L0D89:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD A,$0B
  SUB B
  ADD A,A
  ADD A,A
  ADD A,A
  LD C,A
  LD B,$08
  POP AF
L0D97:
  RRA
  PUSH BC
  PUSH AF
  CALL C,SCAN_KEYBOARD
  POP AF
  POP BC
  INC C
  DJNZ L0D97
  JP _CHPUT_1

; Message at 3493
KEYMAP:
  DEFM "0123456789-="
  DEFB '\\'
  DEFM "[];'`,./"
  DEFB $FF

; Message at 3515
L0DBB:
  DEFM "abcdefghijklmnopqrstuvwxyz"
  DEFM ")!@#$%^&*(_+|{}:"
  DEFB '"'
  DEFM "~<>?"
  DEFB $FF

; Message at 3563
L0DEB:
  DEFM "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  DEFB  $09


L0E06:
  DEFB  $ac,$ab,$ba,$ef,$bd,$f4,$fb,$ec,$07,$17,$f1,$1e,$01,$0d,$06,$05
  DEFB  $bb,$f3,$f2,$1d
  DEFB $FF

  DEFB  $c4,$11,$bc,$c7

L0E1F:
  CALL L1514
  INC DE
  CALL C,$DDC6
  RET Z
  DEC BC
  DEC DE
  JP NZ,$CCDB
  JR L0E1F-$1F		;$0E00 (??)

; Data block at 3630
L0E2E:
  DEFB $12,$C0,$1A,$CF,$1C,$19,$0F,$0A
  DEFB $00,$FD,$FC,$00
  
L0E3A:  ; Later we have a reference to $0E3A, but perhaps they are not bound
  DEFB $00,$F5,$00,$00
  DEFB $08
  DEFB $1F,$F0,$16,$02
  DEFB $0E,$04,$03
  DEFB $F7,$AE,$AF,$F6,$FF,$FE,$00,$FA
  DEFB $C1
  
  DEFB $CE,$D4
  DEFB $10,$D6
  DEFB $DF,$CA
  DEFB $DE,$C9
  DEFB $0C,$D3
  
  DEFB $C3,$D7
  DEFB $CB,$A9
  DEFB $D1
  
  DEFB $00,$C5,$D5,$D0,$F9,$AA,$F8,$EB
  DEFB $9F,$D9,$BF,$9B,$98,$E0,$E1,$E7
  DEFB $87,$EE,$E9,$00,$ED,$DA,$B7,$B9
  DEFB $E5,$86,$A6,$A7,$FF,$84,$97,$8D
  DEFB $8B,$8C,$94,$81,$B1,$A1,$91,$B3
  DEFB $B5,$E6,$A4,$A2,$A3,$83,$93,$89
  DEFB $96,$82,$95,$88,$8A,$A0,$85,$D8
  DEFB $AD,$9E,$BE,$9C,$9D,$00,$00,$E2
  DEFB $80,$00,$00,$00
  DEFB $E8,$EA,$B6,$B8,$E4,$8F,$00
  DEFB $A8,$FF,$8E
  DEFB $00,$00,$00,$00
  DEFB $99,$9A,$B0,$00
  DEFB $92,$B2,$B4,$00
  DEFB $A5,$00,$E3,$00
  DEFB $00,$00,$00,$90,$00,$00,$00,$00,$00

L0EC5:
  LD E,C
  LD D,$00
  LD HL,$FB99		; $FB99: Unknown System Variable, or -1127, -$0467
  ADD HL,DE
  LD A,(HL)
  AND A
  JR NZ,L0EE3
L0ED0:
  EX DE,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$F52F		; $F52F: Unknown System Variable or -2769, -$0AD1
  ADD HL,DE
  EX DE,HL
L0EDA:
  LD A,(DE)
  AND A
  RET Z
  CALL K_L0F46_1
  INC DE
  JR L0EDA

; Routine at 3811
L0EE3:
  LD HL,(CURLIN)		 ; Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
  INC HL
  LD A,H
  OR L
  JR Z,L0ED0		; JP if in 'DIRECT' (immediate) mode
  LD HL,$FBAD		; OLDKEY base address ?  ($FD43 on SVI)
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
  
; This entry point is used by the routines at _ISCNTC and _KEYINT.
TST_IFLG_EVENT:
  LD A,(HL)
  AND $01
  RET Z
  LD A,(HL)
  OR $04
  CP (HL)
  RET Z
  LD (HL),A
  XOR $05
  RET NZ
  LD A,(ONGSBF)
  INC A
  LD (ONGSBF),A
  RET

IF NOHOOK
 IF PRESERVE_LOCATIONS
 ELSE
  TRIM_0F00:
    DEFS $0F00-TRIM_0F00
 ENDIF
ENDIF

; Routine at 3846
K_L0F06:
  LD A,($FBEB)				; KBD ROW #6
  RRCA
  LD A,$0C
  SBC A,$00
  JR K_L0F46_1


  ; --- --- CODE CAN BE RELOCATED STARTING FROM HERE --- ---

; Routine at 3856
K_L0F10:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HKYEA			; Hook 1 for Keyboard decoder
ENDIF
  LD E,A
  LD D,$00
  ;LD HL,$1003
  LD HL,L1033-$30
  ADD HL,DE
  LD A,(HL)
  AND A
  RET Z
  JR K_L0F46_1

; Routine at 3871
L0F1F:
  LD A,($FBEB)				; KBD ROW #6
  LD E,A
  OR $FE
  BIT 4,E
  JR NZ,L0F1F_0
  AND $FD
L0F1F_0:
  CPL
  INC A
  LD (KANAST),A
  JR K_L0F46_2
  
  NOP
  NOP
  NOP

; Routine at 3893
L0F35:
  RET

; Routine at 3894
K_CAPS:
  LD HL,CAPST			;  "capital status" flag, ( 00# = Off / FF# = On )
  LD A,(HL)
  CPL
  LD (HL),A
  CPL
; This entry point is used by the routine at CHGCAP.
_CHGCAP:
  AND A
  LD A,$0C
  JR Z,K_CAPS_1
  INC A
K_CAPS_1:
  OUT (PPI_MOUT),A
  RET

; Routine at 3910
K_L0F46:
  LD A,($FBEB)				; KBD ROW #6
  RRCA
  RRCA
  LD A,$03
  JR NC,K_L0F46_0
  INC A
K_L0F46_0:
  LD (INTFLG),A
  JR C,K_L0F46_2
; This entry point is used by the routines at K_L0F06, K_L0F10 and L0FD0.
K_L0F46_1:
  LD HL,(PUTPNT)
  LD (HL),A
  CALL L105A+1
  LD A,(GETPNT)
  CP L
  RET Z
  LD (PUTPNT),HL
; This entry point is used by the routine at L0F1F.
K_L0F46_2:
  LD A,(CLIKSW)
  AND A
  RET Z
  LD A,(CLIKFL)
  AND A
  RET NZ
  LD A,$0F				; KBD click ?
  LD (CLIKFL),A
  OUT (PPI_MOUT),A
  LD A,$0A				; KBD click ?
K_L0F46_3:
  DEC A
  JR NZ,K_L0F46_3
; This entry point is used by the routine at CHGSND.
_CHGSND:
  AND A
  LD A,$0E
  JR Z,_CHGSND_0
  INC A
_CHGSND_0:
  OUT (PPI_MOUT),A
  RET


K_L0F83:
  LD A,($FBEB)			; KBD ROW #6
  LD E,A
  RRA
  RRA
  PUSH AF
  LD A,E
  CPL
  JR NC,K_L0F83_0
  RRA
  RRA
  RLCA
  AND $03
  BIT 1,A
  JR NZ,GET_KSYM
  BIT 4,E
  JR NZ,GET_KSYM
  OR $04
  DEFB 17	; "LD DE,nn" to jump over the next word without executing it
K_L0F83_0:
  AND  $01

GET_KSYM:
  LD E,A
  ADD A,A
  ADD A,E
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD E,A
  LD D,$00
  LD HL,KEYMAP		; Keyboard map ?
  ADD HL,DE
  LD B,D
  ADD HL,BC
  POP AF
  LD A,(HL)
  INC A
  JP Z,L0F1F
  DEC A
  RET Z
  JR C,L0FD0
  AND $DF		; TK_SPC ?
  SUB $40		; '@'
  CP ' '
  RET NC
L0FC1:
  JR  K_L0F46_1


  
; Routine at 4035
K_L0FC3:
  LD A,($FBEB)				; KBD ROW #6
  RRCA
  JR C,K_L0FC3_0
  LD A,C
  ADD A,$05
  LD C,A
K_L0FC3_0:
  JP L0EC5

; Routine at 4048
L0FD0:
  CP ' '
  JR NC,L0FDF
  PUSH AF
  LD A,$01
  CALL K_L0F46_1
  POP AF
  ADD A,'A'-1
  JR L0FC1

; Routine at 4063
;
; Used by the routine at L0FD0.
L0FDF:
  LD HL,CAPST         ; "capital status" flag
  INC (HL)
  DEC (HL)
  JR Z,L0FDF_0
  CP 'a'              ; Less than "a" ?
  JR C,SEARCH         ; Yes - search for words
  CP 'z'+1            ; Greater than "z" ?
  JR NC,SEARCH        ; Yes - search for words
  AND $DF		; TK_SPC ?
L0FDF_0:
  LD DE,(KANAST)
  INC E
  DEC E
  JR Z,L0FC1
  LD D,A
  OR $20
  LD HL,L1066
  LD C,$06
  CPDR
L1003:
  LD A,D
  JR NZ,L0FC1
  INC HL
  LD C,$06
L1008:
  ADD HL,BC
  DEC E
  JR NZ,L1008
  LD A,(HL)
  BIT 5,D
  JR NZ,L0FC1
SEARCH:
  LD C,$1F	; 31
  LD HL,L109D
  CPDR
  JR NZ,L0FC1
  LD C,$1F
  INC HL
  ADD HL,BC
  LD A,(HL)
  JR L0FC1

; Routine at 4129
;
; Used by the routine at L0D89.
SCAN_KEYBOARD:
  LD A,C
  LD HL,L1B96
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HKEYC			; Hook 2 for Keyboard decoder
ENDIF
  LD D,$0F
SCAN_KEYBOARD_0:
  CP (HL)
  INC HL
  LD E,(HL)
  INC HL
  PUSH DE
  RET C
  POP DE
  JR SCAN_KEYBOARD_0

  
;- Example of European Keyboard Layout
;FBE5 0  => 7    6   5   4   3   2   1   0
;FBE6 1  => ;    ]   [   \   =   -   9   8
;FBE7 2  => B    A   ACCENT /   .   ,   `   '
;FBE8 3  => J    I   H   G   F   E   D   C
;FBE9 4  => R    Q   P   O   N   M   L   K
;FBEA 5  => Z    Y   X   W   V   U   T   S
;FBEB 6  => F3   F2  F1  CODE   CAPS   GRPH   CTRL   SHIFT
;FBEC 7  => RET  SEL    BS  STOP   TAB    ESC    F5  F4
;FBED 8  => RIGHT   DOWN   UP  LEFT   DEL    INS    HOME   SPACE
;FBEE 9  => 4    3   2   1   0    /   +   *
;FBEF 10 => .   ,   -   9   8   7   6   5
  
  
; Keyboard map
L1033:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Routine at 4157
L103D:
  DEFB $1b,$09,$00,$08
  
L1041:
  DEFB $18,$0d

; Data block at 4163
L1043:
  DEFB $20,$0C,$12,$7F,$1D,$1E,$1F,$1C
  DEFB $00,$00,$00

; Message at 4174
L104E:
  DEFM "0123456789"

; Routine at 4184
L1058:
  DEC L
  INC L
  
L105A:
	;L105A+1:  XOR A
  LD L,$AF
  LD (KANAST),A
  JR CK_CTLX

; Message at 4193

L1061:
  DEFM "aeiou"

L1066:  
  DEFB $79,$85,$8A,$8D,$95,$97
  DEFB $79,$A0,$82,$A1,$A2,$A3
  DEFB $79,$83,$88,$8C,$93,$96
  DEFB $79,$84,$89,$8B,$94,$81
  DEFB $98,$83,$88,$8C,$93,$96
  DEFB $84,$89,$8B,$94,$81,$98
  DEFB $A0,$82,$A1,$A2,$A3,$85
  DEFB $8A,$8D,$95,$97,$B1,$B3
  DEFB $B5,$B7,$A4,$86,$87,$91
  DEFB $B9
  
  

; Message at 4253
L109D:
  DEFB $79
  DEFM "AEIOU"
  DEFB $8E
  DEFM "EI"
  DEFB $99
  DEFB $9A
  DEFM "YA"
  DEFB $90
  DEFM "IOUAEIOU"
  DEFB $B0,$B2,$B4,$B6,$A5,$8F,$80,$92
  DEFB $B8,$59,$00,$00,$00,$00,$00
  
  ; --- START PROC CK_CTLX ---
CK_CTLX:
  INC HL
  LD A,L
  CP $18		; CTL-X ?
  RET NZ
  LD HL,KEYBUF
  RET

		
; Routine at 4299
;
; Used by the routines at CHGET and _QINLIN.
_CHGET:
  PUSH HL
  PUSH DE
  PUSH BC
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCHGE			; Hook for CHGET  std routine
ENDIF
  CALL _CHSNS
  JR NZ,_CHGET_1
  CALL L09DA
_CHGET_0:
  CALL _CHSNS
  JR Z,_CHGET_0
  CALL L0A27
_CHGET_1:
  LD HL,INTFLG
  LD A,(HL)
  CP $04
  JR NZ,_CHGET_2
  LD (HL),$00
_CHGET_2:
  LD HL,(GETPNT)
  LD C,(HL)
  CALL CK_CTLX
  LD (GETPNT),HL
  LD A,C
  JP _CHPUT_1

; Routine at 4345
;
; Used by the routine at CKCNTC.
_CKCNTC:
  PUSH HL
  LD HL,$0000
  CALL _ISCNTC
  POP HL
  RET

; Routine at 4354
;
; Used by the routines at WRTPSG, _INITIO, _BEEP, L113B, L1181 and L11B0.
_WRTPSG:
  DI
  OUT (PSG_ADDR),A
  PUSH AF
  LD A,E
  OUT (PSG_DATA),A
  EI
  POP AF
  RET

; Routine at 4364
;
; Used by the routines at _INITIO, _GTSTCK_3, _GTPAD, GTPAD_SUB3 and GTPAD_SUB4.
L110C:
  LD A,$0E
; This entry point is used by the routines at RDPSG, _GTSTCK_2, _GTPDL and _GTPAD.
_RDPSG:
  OUT (PSG_ADDR),A
  IN A,(PSG_DATAIN)
  RET

; Routine at 4371
;
; Used by the routine at BEEP.
_BEEP:
  XOR A
  LD E,$55
  CALL _WRTPSG
  LD E,A
  INC A
  CALL _WRTPSG
  LD E,$BE
  LD A,$07
  CALL _WRTPSG
  LD E,A
  INC A
  CALL _WRTPSG
  LD BC,2000
  CALL BEEP_DELAY
  JP _GICINI

; Routine at 4403
;
; Used by the routine at _BEEP.
BEEP_DELAY:
  DEC BC
  EX (SP),HL
  EX (SP),HL
  LD A,B
  OR C
  JR NZ,BEEP_DELAY
  RET

; Routine at 4411
L113B:
  LD B,A
  CALL _GETVCP	; Returns pointer to play queue
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  DEC DE
  LD (HL),E
  INC HL
  LD (HL),D
  LD A,D
  OR E
  RET NZ
  LD A,B
  LD (QUEUEN),A
  CALL L11E2
  CP $FF
  JR Z,L11B0
  LD D,A
  AND $E0
  RLCA
  RLCA
  RLCA
  LD C,A
  LD A,D
  AND $1F
  LD (HL),A
  CALL L11E2
  DEC HL
  LD (HL),A
  INC C
; This entry point is used by the routine at L1181.
L113B_0:
  DEC C
  RET Z
  CALL L11E2
  LD D,A
  AND $C0
  JR NZ,L1181
  CALL L11E2
  LD E,A
  LD A,B
  RLCA
  CALL _WRTPSG
  INC A
  LD E,D
  CALL _WRTPSG
  DEC C
  JR L113B_0

; Routine at 4481
;
; Used by the routine at L113B.
L1181:
  LD H,A
  AND $80
  JR Z,L1181_0
  LD E,D
  LD A,B
  ADD A,$08
  CALL _WRTPSG
  LD A,E
  AND $10
  LD A,$0D
  CALL NZ,_WRTPSG
L1181_0:
  LD A,H
  AND $40
  JR Z,L113B_0
  CALL L11E2
  LD D,A
  CALL L11E2
  LD E,A
  LD A,$0B
  CALL _WRTPSG
  INC A
  LD E,D
  CALL _WRTPSG
  DEC C
  DEC C
  JR L113B_0

; Routine at 4528
;
; Used by the routine at L113B.
L11B0:
  LD A,B
  ADD A,$08
  LD E,$00
  CALL _WRTPSG
  INC B
  LD HL,MUSICF
  XOR A
  SCF
L11B0_0:
  RLA
  DJNZ L11B0_0
  AND (HL)
  XOR (HL)
  LD (HL),A
; This entry point is used by the routine at STRTMS.
_STRTMS:
  LD A,(MUSICF)
  OR A
  RET NZ
  LD HL,PLYCNT
  LD A,(HL)
  OR A
  RET Z
  DEC (HL)
  LD HL,$0001
  LD (VCBA),HL
  LD (VCBB),HL
  LD (VCBC),HL
  LD A,$07
  LD (MUSICF),A
  RET

; Routine at 4578
;
; Used by the routines at L113B and L1181.
L11E2:
  LD A,(QUEUEN)
  PUSH HL
  PUSH DE
  PUSH BC
  CALL L14AD
  JP _CHPUT_1

; Routine at 4590
;
; Used by the routine at GTSTCK.
_GTSTCK:
  DEC A
  JP M,_GTSTCK_1
  CALL _GTSTCK_2
  LD HL,STICK0_MAP
_GTSTCK_0:
  AND $0F
  LD E,A
  LD D,$00
  ADD HL,DE
  LD A,(HL)
  RET

_GTSTCK_1:
  CALL _GTSTCK_5
  RRCA
  RRCA
  RRCA
  RRCA
  LD HL,STICK1_MAP
  JR _GTSTCK_0


; Routine at 4620
;
; Used by the routines at _KEYINT, _GTSTCK and _GTTRIG.
_GTSTCK_2:
  LD B,A
  LD A,$0F
  DI
  CALL _RDPSG
  DJNZ _GTSTCK_3
  AND $DF
  OR $4C
  JR _GTSTCK_4

; Routine at 4635
;
; Used by the routine at _GTSTCK_2.
_GTSTCK_3:
  AND $AF
  OR $03
; This entry point is used by the routine at _GTSTCK_2.
_GTSTCK_4:
  OUT (PSG_DATA),A
  CALL L110C
  EI
  RET

; Routine at 4646
;
; Used by the routines at _KEYINT and _GTTRIG_3.
_GTSTCK_5:
  DI
  IN A,(PPI_C)
  AND $F0
  ADD A,$08
  OUT (PPI_COUT),A
  IN A,(PPI_B)
  EI
  RET
  
STICK0_MAP:
  DEFB $00,$05,$01,$00,$03,$04,$02,$03
  DEFB $07,$06,$08,$07,$00,$05,$01,$00

STICK1_MAP:
  DEFB $00,$03,$05,$04,$01,$02,$00,$03
  DEFB $07,$00,$06,$05,$08,$01,$07,$00


; This entry point is used by the routine at GTTRIG.
  ; --- START PROC L1253 ---
_GTTRIG:
  DEC A
  JP M,_GTTRIG_3
  PUSH AF
  AND $01
  CALL _GTSTCK_2
  POP BC
  DEC B
  DEC B
  LD B,$10
  JP M,_GTTRIG_1
  LD B,$20
_GTTRIG_1:
  AND B
; This entry point is used by the routine at _GTTRIG_3.
_GTTRIG_2:
  SUB $01
  SBC A,A
  RET

; Routine at 4716
;
; Used by the routine at _GTTRIG.
_GTTRIG_3:
  CALL _GTSTCK_5
  AND $01
  JR _GTTRIG_2

; Routine at 4723
;
; Used by the routine at GTPDL.
_GTPDL:
  INC A
  AND A
  RRA
  PUSH AF
  LD B,A
  XOR A
  SCF
_GTPDL_0:
  RLA
  DJNZ _GTPDL_0
  LD B,A
  POP AF
  LD C,$10
  LD DE,$03AF	; MSK=$AF,  OR=$03
  JR NC,_GTPDL_1
  LD C,$20
  LD DE,$4C9F	; MSK=$9F,  OR=$4C
_GTPDL_1:
  LD A,$0F
  DI
  CALL _RDPSG
  AND E
  OR D
  OR C
  OUT (PSG_DATA),A
  XOR C
  OUT (PSG_DATA),A
  LD A,$0E
  OUT (PSG_ADDR),A
  LD C,$00
_GTPDL_2:
  IN A,(PSG_DATAIN)
  AND B
  JR Z,_GTPDL_3
  INC C
  JP NZ,_GTPDL_2
  DEC C
_GTPDL_3:
  EI
  LD A,C
  RET

; Routine at 4780
;
; Used by the routine at GTPAD.
; Check the current touch PAD status.
_GTPAD:
  CP $04
  LD DE,$0CEC
  JR C,_GTPAD_0
  LD DE,$03D3
  SUB $04
_GTPAD_0:
  DEC A
  JP M,_GTPAD_1
  DEC A
  LD A,(PADX)
  RET M
  LD A,(PADY)
  RET Z
_GTPAD_1:
  PUSH AF
  EX DE,HL
  LD (FILNAM),HL
  SBC A,A
  CPL
  AND $40
  LD C,A
  LD A,$0F
  DI
  CALL _RDPSG
  AND $BF
  OR C
  OUT (PSG_DATA),A
  POP AF
  JP M,GTPAD_SUB
  CALL L110C
  EI
  AND $08
  SUB $01
  SBC A,A
  RET

; Routine at 4840
;
; Used by the routine at _GTPAD.
GTPAD_SUB:
  LD C,$00
  CALL GTPAD_SUB3
  CALL GTPAD_SUB3
  JR C,GTPAD_SUB_2
  CALL GTPAD_SUB2
  JR C,GTPAD_SUB_2
  PUSH DE
  CALL GTPAD_SUB2
  POP BC
  JR C,GTPAD_SUB_2
  LD A,B
  SUB D
  JR NC,GTPAD_SUB_0
  CPL
  INC A
GTPAD_SUB_0:
  CP $05
  JR NC,GTPAD_SUB
  LD A,C
  SUB E
  JR NC,GTPAD_SUB_1
  CPL
  INC A
GTPAD_SUB_1:
  CP $05
  JR NC,GTPAD_SUB
  LD A,D
  LD (PADX),A
  LD A,E
  LD (PADY),A
GTPAD_SUB_2:
  EI
  LD A,H
  SUB $01
  SBC A,A
  RET

; Routine at 4896
;
; Used by the routine at GTPAD_SUB.
GTPAD_SUB2:
  LD C,$0A
  CALL GTPAD_SUB3
  RET C
  LD D,L
  PUSH DE
  LD C,$00
  CALL GTPAD_SUB3
  POP DE
  LD E,L
  XOR A
  LD H,A
  RET

; Routine at 4914
;
; Used by the routines at GTPAD_SUB and GTPAD_SUB2.
GTPAD_SUB3:
  CALL GTPAD_SUB4
  LD B,$08
  LD D,C
GTPAD_SUB3_0:
  RES 0,D
  RES 2,D
  CALL GTPAD_SUB4_1
  CALL L110C
  LD H,A
  RRA
  RRA
  RRA
  RL L
  SET 0,D
  SET 2,D
  CALL GTPAD_SUB4_1
  DJNZ GTPAD_SUB3_0
  SET 4,D
  SET 5,D
  CALL GTPAD_SUB4_1
  LD A,H
  RRA
  RET

; Routine at 4955
;
; Used by the routine at GTPAD_SUB3.
GTPAD_SUB4:
  LD A,$35
  OR C
  LD D,A
  CALL GTPAD_SUB4_1
GTPAD_SUB4_0:
  CALL L110C
  AND $02
  JR Z,GTPAD_SUB4_0
  RES 4,D
  RES 5,D
; This entry point is used by the routine at GTPAD_SUB3.
GTPAD_SUB4_1:
  PUSH HL
  PUSH DE
  LD HL,(FILNAM)
  LD A,L
  CPL
  AND D
  LD D,A
  LD A,$0F
  OUT (PSG_ADDR),A
  IN A,(PSG_DATAIN)
  AND L
  OR D
  OR H
  OUT (PSG_DATA),A
  POP DE
  POP HL
  RET


; Routine at 4996
;
; Used by the routine at STMOTR.
_STMOTR:
  AND A
  JP M,_STMOTR_2

_STMOTR_0:
  JR NZ,_STMOTR_1+1
  LD A,9
  
_STMOTR_1:
	; L183C+1: LD A,8
  defb $C2	; JP NZ,NN (always false), masks the next 2 bytes
  LD A,8

  OUT (PPI_MOUT),A
  RET

; Routine at 5010
; Used by the routine at _STMOTR.
_STMOTR_2:
  IN A,(PPI_C)
  AND $10
  JR _STMOTR_0


; Routine at 5016
;
; Used by the routine at NMI.
_NMI:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNMI		; Hook for NMI std routine
ENDIF
  RETN
  
; This entry point is used by the routine at INIFNK.
_INIFNK:
  LD BC,$00A0		; 160
  LD DE,FNKSTR
  LD HL,FNKTAB
  LDIR
  RET

; Message at 5033
FNKTAB:
  DEFM "color "

; Data block at 5039
L13AF:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; Message at 5049
L13B9:
  DEFM "auto "

; Data block at 5054
L13BE:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00

; Message at 5065
L13C9:
  DEFM "goto "

; Data block at 5070
L13CE:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00

; Message at 5081
L13D9:
  DEFM "list "

; Data block at 5086
L13DE:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00

; Message at 5097
L13E9:
  DEFM "run"
  DEFB CR

  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00

; Message at 5113
L13F9:
  DEFM "color 15,4,4"
  DEFB CR

  DEFB $00
  DEFB $00
  DEFB $00
  DEFM "cload"
  DEFB '"'
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00

; Message at 5145
L1419:
  DEFM "cont"
  DEFB CR

; Data block at 5149
L141E:
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00

; Message at 5161
L1429:
  DEFM "list."
  DEFB CR

; Data block at 5166
L142F:
  DEFB $1E,$1E,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$0C

; Message at 5178
L143A:
  DEFM "run"
  DEFB CR

L143E:
  DEFB $00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00


_RDVDP:
  IN A,(VDP_STATUS)
  RET

; Routine at 5196
;
; Used by the routine at RSLREG.
_RSLREG:
  IN A,(PPI_A)
  RET

; Routine at 5199
;
; Used by the routine at WSLREG.
_WSLREG:
  OUT (PPI_AOUT),A
  RET

; Routine at 5202
;
; Used by the routine at SNSMAT.
_SNSMAT:
  LD C,A
  DI
  IN A,(PPI_C)
  AND $F0
  ADD A,C
  OUT (PPI_COUT),A
  IN A,(PPI_B)
  EI
  RET

; Routine at 5215
;
; Used by the routines at ISFLIO and _OUTDO.
_ISFLIO:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HISFL			; Hook for ISFLIO std routine
ENDIF
  PUSH HL
  LD HL,(PTRFIL)
  LD A,L
  OR H
  POP HL
  RET

; Routine at 5226
;
; Used by the routine at DCOMPR.
CPDEHL:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; Routine at 5232
;
; Used by the routines at GETVCP and L113B.
; Returns pointer to play queue
_GETVCP:
  LD L,$02
  JR _GETVC2_0

; Routine at 5236
;
; Used by the routine at GETVC2.
_GETVC2:
  LD A,(VOICEN)
; This entry point is used by the routines at _INITIO and _GETVCP.
_GETVC2_0:
  PUSH DE
  LD DE,VCBA
  LD H,$00
  ADD HL,DE
  OR A
  JR Z,_GETVC2_2
  LD DE,$0025
_GETVC2_1:
  ADD HL,DE
  DEC A
  JR NZ,_GETVC2_1
_GETVC2_2:
  POP DE
  RET

; Routine at 5258
;
; Used by the routine at PHYDIO.
_PHYDIO:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPHYD		; Hook for PHYDIO std routine
ENDIF
  RET

; Routine at 5262
;
; Used by the routine at FORMAT.
_FORMAT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFORM		; Hook for FORMAT std routine
ENDIF
  RET

; Routine at 5266
;
; Used by the routine at PUTQ.
; Put byte in queue
_PUTQ:
  CALL QUE_BCA		; IN: A= QUEUE#, OUT: BCA = first three bytes of the given QUEUE
  LD A,B
  INC A
  INC HL
  AND (HL)
  CP C
  RET Z
  PUSH HL
  DEC HL
  DEC HL
  DEC HL
  EX (SP),HL
  INC HL
  LD C,A
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD B,$00
  ADD HL,BC
  LD (HL),E
  POP HL
  LD (HL),C
  RET

; Routine at 5293
;
; Used by the routine at L11E2.
L14AD:
  CALL QUE_BCA		; IN: A= QUEUE#, OUT: BCA = first three bytes of the given QUEUE
  LD (HL),$00
  JR NZ,L14D1	; QUEBAK+A
  LD A,C
  CP B
  RET Z
  INC HL
  INC A
  AND (HL)
  DEC HL
  DEC HL
  PUSH HL
  INC HL
  INC HL
  INC HL
  LD C,A
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD B,$00
  ADD HL,BC
  LD A,(HL)
  POP HL
  LD (HL),C
  OR A
  RET NZ
  INC A
  LD A,$00
  RET

; Routine at 5329
;
; Used by the routine at L14AD.
L14D1:
  LD C,A
  LD B,$00
  LD HL,QUEBAK-1
  ADD HL,BC
  LD A,(HL)
  RET

; Routine at 5338
;
; Used by the routine at _INITIO.
L14DA:
  PUSH BC
  CALL QUEADDR		; HL = address for queue in A
  LD (HL),B
  INC HL
  LD (HL),B
  INC HL
  LD (HL),B
  INC HL
  POP AF
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  RET

; Routine at 5355
;
; Used by the routine at LFTQ.
; Gives number of bytes left in queue
_LFTQ:
  CALL QUE_BCA		; IN: A= QUEUE#, OUT: BCA = first three bytes of the given QUEUE
  LD A,B
  INC A
  INC HL
  AND (HL)
  LD B,A
  LD A,C
  SUB B
  AND (HL)
  LD L,A
  LD H,$00
  RET

; Routine at 5370
;
; Used by the routines at _PUTQ, L14AD and _LFTQ.
; IN: A= QUEUE#, OUT: BCA = first three bytes of the given QUEUE
QUE_BCA:
  CALL QUEADDR		; HL = address for queue in A
  LD B,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD A,(HL)
  OR A
  RET

; Routine at 5380
;
; Used by the routines at L14DA and QUE_BCA.
; HL = address for queue in A
QUEADDR:
  RLCA
  LD B,A
  RLCA
  ADD A,B
  LD C,A
  LD B,$00
  LD HL,(QUEUES)
  ADD HL,BC
  RET

; Data block at 5392
; $1510
_GRPPRT:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  ; --- START PROC L1514 ---
L1514:
  CALL _SNVCHR
  JR NC,L157B
  JR NZ,_GRPPRT_00
  CP CR
  JR Z,L157E
  CP ' '
  JR C,L157B 

; Routine at 5411
_GRPPRT_00:
  CALL L0752
  LD A,(FORCLR)
  LD (ATRBYT),A
  LD HL,(GRPACY)
  EX DE,HL
  LD BC,(GRPACX)
  CALL _SCALXY
  JR NC,L157B
  CALL _MAPXY
  LD DE,PATWRK
  LD C,$08
_GRPPRT_0:
  LD B,$08
  CALL _FETCHC		; Gets current cursor addresses mask pattern
  PUSH HL
  PUSH AF
  LD A,(DE)
_GRPPRT_1:
  ADD A,A
  PUSH AF
  CALL C,_SETC		; Returns currenct screenpixel of specified attribute byte
  CALL L16AC
  POP HL
  JR C,_GRPPRT_2
  PUSH HL
  POP AF
  DJNZ _GRPPRT_1
_GRPPRT_2:
  POP AF
  POP HL
  CALL _STOREC		; Record current cursor addresses mask pattern
  CALL _TDOWNC
  JR C,_GRPPRT_3
  INC DE
  DEC C
  JR NZ,_GRPPRT_0
_GRPPRT_3:
  CALL IN_GRP_MODE
  LD A,(GRPACX)
  JR Z,L1574
  ADD A,$20
  JR C,L157E
  JR L1574_0

; Routine at 5492
;
; Used by the routine at _GRPPRT.
L1574:
  ADD A,$08
  JR C,L157E
; This entry point is used by the routine at _GRPPRT.
L1574_0:
  LD (GRPACX),A
; This entry point is used by the routines at _GRPPRT and L157E.
L157B:
  JP _POPALL

; Routine at 5502
;
; Used by the routines at _GRPPRT and L1574.
L157E:
  XOR A
  LD (GRPACX),A
  CALL IN_GRP_MODE
  LD A,(GRPACY)
  JR Z,L158D
  ADD A,$20
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
L158D:
  ADD A,8
  
  CP $C0
  JR C,L157E_0
  XOR A
L157E_0:
  LD (GRPACY),A
  JR L157B

; Routine at 5529
;
; Used by the routines at SCALXY and _GRPPRT.
_SCALXY:
  PUSH HL
  PUSH BC
  LD B,$01
  EX DE,HL
  LD A,H
  ADD A,A
  JR NC,L15A7
  LD HL,$0000
  JR L15A7_0

; Routine at 5543
;
; Used by the routine at _SCALXY.
L15A7:
  LD DE,BEEP	; <---- ???  probably the const is needed
  RST DCOMPR		; Compare HL with DE.
  JR C,L15A7_1
  EX DE,HL
  DEC HL
; This entry point is used by the routine at _SCALXY.
L15A7_0:
  LD B,$00
L15A7_1:
  EX (SP),HL
  LD A,H
  ADD A,A
  JR NC,L15BB
  LD HL,$0000
  JR L15BB_0

; Routine at 5563
;
; Used by the routine at L15A7.
L15BB:
  LD DE,$0100
  RST DCOMPR		; Compare HL with DE.
  JR C,L15BB_1
  EX DE,HL
  DEC HL
; This entry point is used by the routine at L15A7.
L15BB_0:
  LD B,$00
L15BB_1:
  POP DE
  CALL IN_GRP_MODE
  JR Z,L15BB_2
  SRL L
  SRL L
  SRL E
  SRL E
L15BB_2:
  LD A,B
  RRCA
  LD B,H
  LD C,L
  POP HL
  RET

; Routine at 5593
;
; Used by the routines at _GRPPRT, L157E, L15BB, _MAPXY, _SETC, L16AC, _RIGHTC,
; L16D8, _LEFTC, _TDOWNC, _DOWNC, _TUPC, _UPC, _NSETCX, _PNTINI and _SCANL.
IN_GRP_MODE:
  LD A,(SCRMOD)
  SUB $02
  RET

; Routine at 5599
;
; Used by the routines at MAPXY and _GRPPRT.
_MAPXY:
  PUSH BC
  CALL IN_GRP_MODE
  JR NZ,L1613
  LD D,C
  LD A,C
  AND $07
  LD C,A
  LD HL,L160B
  ADD HL,BC
  LD A,(HL)
  LD (CMASK),A
  LD A,E
  RRCA
  RRCA
  RRCA
  AND $1F
  LD B,A
  LD A,D
  AND $F8
  LD C,A
  LD A,E
  AND $07
  OR C
  LD C,A
  LD HL,(GRPCGP)
  ADD HL,BC
  LD (CLOC),HL
  POP BC
  RET

; Routine at 5643
L160B:
  ADD A,B
  LD B,B
  JR NZ,L160B_1
  EX AF,AF'
  INC B
  LD (BC),A
L1612:
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
L1613:
  LD A,C
  RRCA

  LD A,$F0			; Mask and keep the left nibble
  JR NC,EVEN_BYTE		
  LD A,$0F			; Mask and keep the righe nibble
EVEN_BYTE:
  LD (CMASK),A
  LD A,C
L160B_1:
  ADD A,A
  ADD A,A
  AND $F8
  LD C,A
  LD A,E
  AND $07
  OR C
  LD C,A
  LD A,E
  RRCA
  RRCA
  RRCA
  AND $07
  LD B,A
  LD HL,(MLTCGP)		; SCREEN 3 character pattern table
  ADD HL,BC
  LD (CLOC),HL
  POP BC
  RET

; Routine at 5689
;
; Used by the routines at FETCHC, _STOREC, _GRPPRT, _SETC, L16AC, _RIGHTC, L16D8, _LEFTC,
; L1779, L178B, L179C, L17AC, _NSETCX, L190C, L192D and L1963.
;
; Gets current cursor addresses mask pattern
_FETCHC:
  LD A,(CMASK)
  LD HL,(CLOC)
  RET

; Routine at 5696
;
; Used by the routines at STOREC, _GRPPRT and L192D.
; Record current cursor addresses mask pattern
;
_STOREC:
  LD (CMASK),A
  LD (CLOC),HL
  RET

; Data block at 5703
  ; --- START PROC L1647 ---
_READC:
  PUSH BC
  PUSH HL
  CALL _FETCHC
  LD B,A
  CALL IN_GRP_MODE
  JR NZ,L166C
  CALL _RDVRM
  AND B
  PUSH AF
  LD BC,$2000
  ADD HL,BC
  CALL _RDVRM
  LD B,A
  POP AF
  LD A,B
  JR Z,L1667
L1663:
  RRCA
  RRCA
  RRCA
  RRCA
L1667:
  AND $0F
  POP HL
  POP BC
  RET


; Routine at 5740
L166C:
  CALL _RDVRM
  INC B
  DEC B
  JP P,L1667
  JR L1663

; Routine at 5750
;
; Used by the routine at SETATR.
; Set attribute byte
_SETATR:
  CP $10
  CCF
  RET C
  LD (ATRBYT),A
  RET

; Routine at 5758
;
; Used by the routines at SETC, _GRPPRT, L18BB and L19C7.
_SETC:
  PUSH HL
  PUSH BC
  CALL IN_GRP_MODE
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  JR NZ,L1690
  PUSH DE
  CALL L186C
  POP DE
  POP BC
  POP HL
  RET

; Data block at 5776
L1690:
  LD B,A
  CALL _RDVRM
  LD C,A
  LD A,B
  CPL
  AND C
  LD C,A
  LD A,(ATRBYT)
  INC B
  DEC B
  JP P,L16A5
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
L16A5:
  OR C
  CALL _WRTVRM
  POP BC
  POP HL
  RET


; Routine at 5804
;
; Used by the routines at _GRPPRT, L18F0, L190C, L1951 and L1963.
L16AC:
  PUSH HL
  CALL IN_GRP_MODE
  JP NZ,L1779
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  RRCA
  JR NC,LR_2
  LD A,L
  AND $F8
  CP $F8
  LD A,$80
  JR NZ,_RIGHTC_0
  JP _TUPC_1

; Routine at 5829
;
; Used by the routines at RIGHTC, L18BB, L199C and L19BA.
; Shifts screenpixel to the right

_RIGHTC:
  PUSH HL
  CALL IN_GRP_MODE
  JP NZ,L178B
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  RRCA
  JR NC,LR_2
; This entry point is used by the routine at L16AC.
_RIGHTC_0:
  PUSH DE
  LD DE,$0008
  JR LR_1

; Routine at 5848
;
; Used by the routines at _SCANL and L19BA.
L16D8:
  PUSH HL
  CALL IN_GRP_MODE
  JP NZ,L179C
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  RLCA
  JR NC,LR_2
  LD A,L
  AND $F8
  LD A,$01
  JR NZ,LR_0
  JR _TUPC_1

; Routine at 5870
;
; Used by the routine at LEFTC.
_LEFTC:
  PUSH HL
  CALL IN_GRP_MODE
  JP NZ,L17AC
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  RLCA
  JR NC,LR_2
  
; This entry point is used by the routine at L16D8.
LR_0:
  PUSH DE
  LD DE,$FFF8		; -8
; This entry point is used by the routine at _RIGHTC.
LR_1:
  ADD HL,DE
  LD (CLOC),HL
  POP DE
; This entry point is used by the routines at L16AC, _RIGHTC and L16D8.
LR_2:
  LD (CMASK),A
  AND A
  POP HL
  RET

; Routine at 5898
;
; Used by the routines at TDOWNC and _GRPPRT.
_TDOWNC:
  PUSH HL
  PUSH DE
  LD HL,(CLOC)
  CALL IN_GRP_MODE
  JP NZ,L17C6
  PUSH HL
  LD HL,(GRPCGP)		; SCREEN 2 character pattern table
  LD DE,$1700
  ADD HL,DE
  EX DE,HL
  POP HL
  RST DCOMPR		; Compare HL with DE.
  JR C,_DOWNC_0
  LD A,L
  INC A
  AND $07
  JR NZ,_DOWNC_0
  JR _TUPC_0

; Routine at 5930
;
; Used by the routine at DOWNC.
_DOWNC:
  PUSH HL
  PUSH DE
  LD HL,(CLOC)
  CALL IN_GRP_MODE
  JP NZ,L17DC
; This entry point is used by the routine at _TDOWNC.
_DOWNC_0:
  INC HL
  LD A,L
  LD DE,$00F8
  JR _UPC_1

; Routine at 5948
;
; Used by the routine at TUPC.
_TUPC:
  PUSH HL
  PUSH DE
  LD HL,(CLOC)
  CALL IN_GRP_MODE
  JP NZ,L17E3
  PUSH HL
  LD HL,(GRPCGP)			; SCREEN 2 character pattern table
  LD DE,$0100
  ADD HL,DE
  EX DE,HL
  POP HL
  RST DCOMPR		; Compare HL with DE.
  JR NC,_UPC_0
  LD A,L
  AND $07
  JR NZ,_UPC_0
; This entry point is used by the routine at _TDOWNC.
_TUPC_0:
  POP DE
; This entry point is used by the routines at L16AC, L16D8, L1779 and L179C.
_TUPC_1:
  SCF
  POP HL
  RET

; Routine at 5981
;
; Used by the routine at UPC.
_UPC:
  PUSH HL
  PUSH DE
  LD HL,(CLOC)
  CALL IN_GRP_MODE
  JP NZ,L17F8
; This entry point is used by the routine at _TUPC.
_UPC_0:
  LD A,L
  DEC HL
  LD DE,$FF08		; -248
; This entry point is used by the routine at _DOWNC.
_UPC_1:
  AND $07
  JR NZ,_UPC_2
  ADD HL,DE
_UPC_2:
  LD (CLOC),HL
  AND A
  POP DE
  POP HL
  RET

; Routine at 6009
;
; Used by the routine at L16AC.
L1779:
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  AND A
  LD A,$0F				; Mask and keep the right nibble
  JP M,APPLY_MASK
  LD A,L
  AND $F8
  CP $F8
  JR NZ,L178B_0
  JR _TUPC_1

; Routine at 6027
;
; Used by the routine at _RIGHTC.
L178B:
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  AND A
  LD A,$0F				; Mask and keep the right nibble
  JP M,APPLY_MASK
; This entry point is used by the routine at L1779.
L178B_0:
  PUSH DE
  LD DE,$0008
  LD A,$F0				; Mask and keep the lsft nibble
  JR L17AC_1

; Routine at 6044
;
; Used by the routine at L16D8.
L179C:
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  AND A
  LD A,$F0				; Mask and keep the left nibble
  JP P,APPLY_MASK
  LD A,L
  AND $F8
  JR NZ,L17AC_0
  JR _TUPC_1

; Routine at 6060
;
; Used by the routine at _LEFTC.
L17AC:
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  AND A
  LD A,$F0				; Mask and keep the left nibble
  JP P,APPLY_MASK
; This entry point is used by the routine at L179C.
L17AC_0:
  PUSH DE
  LD DE,$FFF8		; -8
  LD A,$0F				; Mask and keep the right nibble
; This entry point is used by the routine at L178B.
L17AC_1:
  ADD HL,DE
  LD (CLOC),HL
  POP DE
; This entry point is used by the routines at L1779, L178B and L179C.
APPLY_MASK:
  LD (CMASK),A
  AND A
  POP HL
  RET

; Routine at 6086
;
; Used by the routine at _TDOWNC.
L17C6:
  PUSH HL
  LD HL,(MLTCGP)		; SCREEN 3 character pattern table
  LD DE,$0500			; 1280
  ADD HL,DE
  POP HL
  RST DCOMPR		; Compare HL with DE.
  JR C,L17DC
  LD A,L
  INC A
  AND $07
  JR NZ,L17DC
  SCF
  POP DE
  POP HL
  RET

; Routine at 6108
;
; Used by the routines at _DOWNC and L17C6.
L17DC:
  INC HL
  LD A,L
  LD DE,$00F8
  JR L17F8_0

; Routine at 6115
;
; Used by the routine at _TUPC.
L17E3:
  PUSH HL
  LD HL,(MLTCGP)		; SCREEN 3 character pattern table
  LD DE,$0100
  ADD HL,DE
  POP HL
  RST DCOMPR		; Compare HL with DE.
  JR NC,L17F8
  LD A,L
  AND $07
  JR NZ,L17F8
  SCF
  POP DE
  POP HL
  RET

; Routine at 6136
;
; Used by the routines at _UPC and L17E3.
L17F8:
  LD A,L
  DEC HL
  LD DE,$FF08		; -248
; This entry point is used by the routine at L17DC.
L17F8_0:
  AND $07
  JR NZ,L17F8_1
  ADD HL,DE
L17F8_1:
  LD (CLOC),HL
  AND A
  POP DE
  POP HL
  RET

; Routine at 6153
;
; Used by the routines at NSETCX, L192D and L199C.
; Set horizontal screenpixels
;
_NSETCX:
  CALL IN_GRP_MODE
  JP NZ,L18BB
  PUSH HL
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  EX (SP),HL
  ADD A,A
  JR C,_NSETCX_1
  PUSH AF
  LD BC,$FFFF
  RRCA
_NSETCX_0:
  ADD HL,BC
  JR NC,L1864
  RRCA
  JR NC,_NSETCX_0
  POP AF
  DEC A
  EX (SP),HL
  PUSH HL
  CALL L186C
  POP HL
  LD DE,$0008
  ADD HL,DE
  EX (SP),HL
_NSETCX_1:
  LD A,L
  AND $07
  LD C,A
  LD A,H
  RRCA
  LD A,L
  RRA
  RRCA
  RRCA
  AND $3F
  POP HL
  LD B,A
  JR Z,_NSETCX_3
_NSETCX_2:
  XOR A
  CALL _WRTVRM
  LD DE,$2000
  ADD HL,DE
  LD A,(ATRBYT)
  CALL _WRTVRM
  LD DE,$2008
  ADD HL,DE
  DJNZ _NSETCX_2
_NSETCX_3:
  DEC C
  RET M
  PUSH HL
  LD HL,L185D
  ADD HL,BC
  LD A,(HL)
  JR L186B

L185D:
  DEFB $80,$C0,$E0,$F0,$F8,$FC,$FE

L1864:
  ADD A,A
  DEC A
  CPL
  LD B,A
  POP AF
  DEC A
  AND B
  ; --- START PROC L186B ---
L186B:
  POP HL
  ; --- START PROC L186C ---
L186C:
  LD B,A
  CALL _RDVRM
  LD C,A
  LD DE,$2000
  ADD HL,DE
  CALL _RDVRM
  PUSH AF
  AND $0F
  LD E,A
  POP AF
  SUB E
  LD D,A
  LD A,(ATRBYT)		; Attribute byte (for graphical routines it’s used to read the color) 
  CP E
  JR Z,L189E
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  CP D
  JR Z,L18A1+1   ; reference not aligned to instruction
  PUSH AF
  LD A,B
  OR C
  CP $FF
  JR Z,L18AA
  PUSH HL
  PUSH DE
  CALL L18A1+1   ; reference not aligned to instruction
  POP DE
  POP HL
  POP AF
  OR E
  JR L18B8


; Routine at 6302
L189E:
  LD A,B
  CPL
  AND C
L18A1:
  LD DE,$B178
;; LD A,B
;; OR C

; This entry point is used by the routine at L18AA.
L189E_0:
  LD DE,$2000
  ADD HL,DE
  JR L18B8

; Routine at 6314
L18AA:
  POP AF
  LD A,B
  CPL
  PUSH HL
  PUSH DE
  CALL L189E_0
  POP DE
  POP HL
  LD A,(ATRBYT)
  OR D
; This entry point is used by the routine at L189E.
L18B8:
  JP _WRTVRM

; Routine at 6331
;
; Used by the routine at _NSETCX.
L18BB:
  PUSH HL
  CALL _SETC
  CALL _RIGHTC
  POP HL
  DEC L
  JR NZ,L18BB
  RET

; Routine at 6343
;
; Used by the routine at GTASPC.
_GTASPC:
  LD HL,(ASPCT1)
  EX DE,HL
  LD HL,(ASPCT2)
  RET

; Routine at 6351
;
; Used by the routine at GTASPC.
_PNTINI:
  PUSH AF
  CALL IN_GRP_MODE
  JR Z,L18DB
  POP AF
  CP $10
  CCF
  JR L18DB_0

; Routine at 6363
;
; Used by the routine at _PNTINI.
L18DB:
  POP AF
  LD A,(ATRBYT)
  AND A
; This entry point is used by the routine at _PNTINI.
L18DB_0:
  LD (BRDATR),A
  RET

  ; --- START PROC L18E4 ---
; Scans screenpixels to the right
_SCANR:
  LD HL,$0000
  LD C,L
  CALL IN_GRP_MODE
  JR NZ,L1951
  LD A,B
  LD (RUNFLG),A
  XOR A
  LD (FILNAM+3),A
  LD A,(BRDATR)
  LD B,A
_SCANR_0:
  CALL _READC
  CP B
  JR NZ,L190C
  DEC DE
  LD A,D
  OR E
  RET Z
  CALL L16AC
  JR NC,_SCANR_0
  LD DE,$0000
  RET

; Routine at 6412
;
; Used by the routine at _SCANR.
L190C:
  CALL L19AE
  PUSH DE
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  LD (CSAVEA),HL
  LD (CSAVEM),A
  LD DE,$0000
L190C_0:
  INC DE
  CALL L16AC
  JR C,L192D
  CALL _READC
  CP B
  JR Z,L192D
  CALL L19AE
  JR L190C_0

; Routine at 6445
;
; Used by the routine at L190C.
L192D:
  PUSH DE
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  PUSH HL
  PUSH AF
  LD HL,(CSAVEA)
  LD A,(CSAVEM)
  CALL _STOREC		; Record current cursor addresses mask pattern
  EX DE,HL
  LD (FILNAM+1),HL
  LD A,(FILNAM)
  AND A
  CALL NZ,_NSETCX
  POP AF
  POP HL
  CALL _STOREC		; Record current cursor addresses mask pattern
  POP HL
  POP DE
  JP L199C_1

; Routine at 6481
L1951:
  CALL L19C7
  JR NC,L1963
  DEC DE
  LD A,D
  OR E
  RET Z
  CALL L16AC
  JR NC,L1951
  LD DE,$0000
  RET

; Routine at 6499
;
; Used by the routine at L1951.
L1963:
  CALL _FETCHC			; Gets current cursor addresses mask pattern
  LD (CSAVEA),HL
  LD (CSAVEM),A
  LD HL,$0000
L1963_0:
  INC HL
  CALL L16AC
  RET C
  CALL L19C7
  JR NC,L1963_0
  RET

; Routine at 6522
;
; Used by the routine at GTASPC.
_SCANL:
  LD HL,$0000
  LD C,L
  CALL IN_GRP_MODE
  JR NZ,L19BA
  XOR A
  LD (FILNAM+3),A
  LD A,(BRDATR)
  LD B,A
_SCANL_0:
  CALL L16D8
  JR C,L199C_0
  CALL _READC
  CP B
  JR Z,L199C
  CALL L19AE
  INC HL
  JR _SCANL_0

; Routine at 6556
;
; Used by the routine at _SCANL.
L199C:
  CALL _RIGHTC
; This entry point is used by the routine at _SCANL.
L199C_0:
  PUSH HL
  LD DE,(FILNAM+1)
  ADD HL,DE
  CALL _NSETCX
  POP HL
; This entry point is used by the routine at L192D.
L199C_1:
  LD A,(FILNAM+3)
  LD C,A
  RET

; Routine at 6574
;
; Used by the routines at L190C and _SCANL.
L19AE:
  PUSH HL
  LD HL,ATRBYT
  CP (HL)
  POP HL
  RET Z
  INC A
  LD (FILNAM+3),A
  RET

; Routine at 6586
;
; Used by the routine at _SCANL.
L19BA:
  CALL L16D8
  RET C
  CALL L19C7
  JP C,_RIGHTC
  INC HL
  JR L19BA

; Routine at 6599
;
; Used by the routines at L1951, L1963 and L19BA.
L19C7:
  CALL _READC
  LD B,A
  LD A,(BRDATR)
  SUB B
  SCF
  RET Z
  LD A,(ATRBYT)
  CP B
  RET Z
  CALL _SETC
  LD C,$01
  AND A
  RET

; Routine at 6621
;
; Used by the routine at TAPOOF.
_TAPOOF:
  PUSH BC
  PUSH AF
  LD BC,$0000
_TAPOOF_0:
  DEC BC
  LD A,B
  OR C
  JR NZ,_TAPOOF_0
  POP AF
  POP BC
; This entry point is used by the routine at TAPIOF.
_TAPIOF:
  PUSH AF
  LD A,$09
  OUT (PPI_MOUT),A
  POP AF
  EI
  RET

; Routine at 6641
;
; Used by the routine at TAPOON.
_TAPOON:
  OR A
  PUSH AF
  LD A,$08
  OUT (PPI_MOUT),A
  LD HL,$0000
_TAPOON_0:
  DEC HL
  LD A,H
  OR L
  JR NZ,_TAPOON_0
  POP AF
  LD A,(HEADER)
  JR Z,_TAPOON_1
  ADD A,A
  ADD A,A
_TAPOON_1:
  LD B,A
  LD C,$00
  DI
_TAPOON_2:
  CALL TAPSEND_HIGH
  CALL TAPSEND_RET
  DEC BC
  LD A,B
  OR C
  JR NZ,_TAPOON_2
  JP _BREAKX		; Set CY if STOP is pressed

; Routine at 6681
;
; Used by the routine at TAPOUT.
_TAPOUT:
  LD HL,(LOW)
  PUSH AF
  LD A,L
  SUB $0E
  LD L,A
  ; start bit (HL=LOW)
  CALL TAPSEND_0
  POP AF
  LD B,$08		; 8 bits
_TAPOUT_0:
  RRCA
  CALL C,TAPSEND_HIGH_X2    ; '1'
  CALL NC,TAPSEND_LOW       ; '0'
  DJNZ _TAPOUT_0
  ; stop bits
  CALL TAPSEND_HIGH_X2
  CALL TAPSEND_HIGH_X2
  JP _BREAKX		; Set CY if STOP is pressed

; Routine at 6713
;
; Used by the routine at _TAPOUT.
TAPSEND_LOW:
  LD HL,(LOW)
  CALL TAPSEND_0
; This entry point is used by the routine at _TAPOON.
TAPSEND_RET:
  RET

  ; --- START PROC TAPSEND_HIGH_X2 ---
TAPSEND_HIGH_X2:
  CALL TAPSEND_HIGH
  EX   (SP),HL		; Delay ?
  EX   (SP),HL
  NOP
  NOP
  NOP
  NOP
  CALL TAPSEND_HIGH
  RET



; Routine at 6733
;
; Used by the routine at _TAPOON.
TAPSEND_HIGH:
  LD HL,(HIGH)
; This entry point is used by the routines at _TAPOUT and TAPSEND_LOW.
TAPSEND_0:
  PUSH AF
TAPSEND_1:
  DEC L
  JP NZ,TAPSEND_1
  LD A,$0B
  OUT (PPI_MOUT),A
TAPSEND_2:
  DEC H
  JP NZ,TAPSEND_2
  LD A,$0A
  OUT (PPI_MOUT),A
  POP AF
  RET

; Routine at 6755
;
; Used by the routine at TAPION.
_TAPION:
  LD A,$08
  OUT (PPI_MOUT),A
  DI
  LD A,$0E
  OUT (PSG_ADDR),A
_TAPION_0:
  LD HL,$0457		; 1111
_TAPION_1:
  LD D,C
  CALL L1B34
  RET C
  LD A,C
  CP $DE		; TK_FN ?
  JR NC,_TAPION_0
  CP $05		; TK_INT ?
  JR C,_TAPION_0
  SUB D
  JR NC,_TAPION_2
  CPL
  INC A
_TAPION_2:
  CP $04		; TK_SGN ?
  JR NC,_TAPION_0
  DEC HL
  LD A,H
  OR L
  JR NZ,_TAPION_1
  LD HL,$0000
  LD B,L
  LD D,L
_TAPION_3:
  CALL L1B34
  RET C
  ADD HL,BC
  DEC D
  JP NZ,_TAPION_3
  LD BC,$06AE		; 1710
  ADD HL,BC
  LD A,H
  RRA
  AND $7F
  LD D,A
  ADD HL,HL
  LD A,H
  SUB D
  LD D,A
  SUB $06
  LD (LOWLIM),A
  LD A,D
  ADD A,A
  LD B,$00
_TAPION_4:
  SUB $03
  INC B
  JR NC,_TAPION_4
  LD A,B
  SUB $03
  LD (WINWID),A
  OR A
  RET

; Routine at 6844
;
; Used by the routine at TAPIN.
_TAPIN:
  LD A,(LOWLIM)
  LD D,A
_TAPIN_0:
  CALL _BREAKX		; Set CY if STOP is pressed
  RET C
  IN A,(PSG_DATAIN)
  RLCA
  JR NC,_TAPIN_0
_TAPIN_1:
  CALL _BREAKX		; Set CY if STOP is pressed
  RET C
  IN A,(PSG_DATAIN)
  RLCA
  JR C,_TAPIN_1
  LD E,$00
  CALL L1B1F
_TAPIN_2:
  LD B,C
  CALL L1B1F
  RET C
  LD A,B
  ADD A,C
  JP C,_TAPIN_2
  CP D
  JR C,_TAPIN_2
  LD L,$08
_TAPIN_3:
  CALL L1B03
  CP $04
  CCF
  RET C
  CP $02
  CCF
  RR D
  LD A,C
  RRCA
  CALL NC,L1B1F_0
  CALL L1B1F
  DEC L
  JP NZ,_TAPIN_3
  CALL _BREAKX		; Set CY if STOP is pressed
  LD A,D
  RET

; Routine at 6915
;
; Used by the routine at _TAPIN.
L1B03:
  LD A,(WINWID)
  LD B,A
  LD C,$00
; This entry point is used by the routine at L1B1B.
L1B03_0:
  IN A,(PSG_DATAIN)
  XOR E
  JP P,L1B17
  LD A,E
  CPL
  LD E,A
  INC C
  DJNZ L1B03_0
  LD A,C
  RET

; Unused
L1B17:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 4
 ENDIF
ELSE
  DEFS 4
ENDIF

; Routine at 6939
L1B1B:
  DJNZ L1B03_0
  LD A,C
  RET

; Routine at 6943
;
; Used by the routine at _TAPIN.
L1B1F:
  CALL _BREAKX		; Set CY if STOP is pressed
  RET C
; This entry point is used by the routines at _TAPIN and L1B34.
L1B1F_0:
  LD C,$00
; This entry point is used by the routine at L1B34.
L1B1F_1:
  INC C
  JR Z,L1B32
  IN A,(PSG_DATAIN)
  XOR E
  JP P,L1B1F_1
  LD A,E
  CPL
  LD E,A
  RET

; Routine at 6962
;
; Used by the routine at L1B1F.
L1B32:
  DEC C
  RET

; Routine at 6964
;
; Used by the routine at _TAPION.
L1B34:
  CALL _BREAKX		; Set CY if STOP is pressed
  RET C
  IN A,(PSG_DATAIN)
  RLCA
  JR C,L1B34
  LD E,$00
  CALL L1B1F_0
  JP L1B1F_1

; Routine at 6981
;
; Used by the routine at OUTDO.
_OUTDO:
  PUSH AF
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HOUTD		; Hook for OUTDO std routine
ENDIF
  CALL _ISFLIO
  JR Z,OUTDO_NOFILE
  
  POP AF
  LD IX,FILO		; Sequential file output
  JP _CALBAS

; Routine at 6998
;
; Used by the routine at _OUTDO.
OUTDO_NOFILE:
  LD A,(PRTFLG)
  OR A
  JR Z,_OUTCON
  LD A,(RAWPRT)
  AND A
  JR NZ,_OUTPRT
  POP AF

; This entry point is used by the routine at OUTDLP.
OUTC_TABEXP:
  PUSH AF
  CP TAB
  JR NZ,NO_TAB
TABEXP_LOOP:
  LD A,' '
  CALL OUTC_TABEXP
  LD A,(LPTPOS)
  AND $07
  JR NZ,TABEXP_LOOP
  POP AF
  RET

; Routine at 7030
;
; Used by the routine at OUTDO_NOFILE.
NO_TAB:
  SUB CR
  JR Z,NO_TAB_0
  JR C,NO_TAB_1
  CP ' '-CR
  JR C,NO_TAB_1
  LD A,(LPTPOS)
  INC A
NO_TAB_0:
  LD (LPTPOS),A
NO_TAB_1:
  LD A,(NTMSXP)
  AND A
  JR Z,_OUTPRT
  POP AF
  CALL _SNVCHR
  RET NC
  JR NZ,OUTPRT_SPC
  JR OUTPRT_CHR

; Keyboard jp table
L1B96:
  DEFB $30,K_L0F83-$0F00
  DEFB $33,K_L0F10-$0F00
  DEFB $34,K_CAPS-$0F00
  DEFB $35,K_L0F10-$0F00
  DEFB $3a,K_L0FC3-$0F00
  DEFB $3c,K_L0F10-$0F00
  DEFB $3d,K_L0F46-$0F00
  DEFB $41,K_L0F10-$0F00
  DEFB $42,K_L0F06-$0F00
  DEFB $ff,K_L0F10-$0F00
  DEFB $00

  
; This entry point is used by the routines at OUTDO_NOFILE and NO_TAB.
_OUTPRT:
  POP AF
; This entry point is used by the routines at NO_TAB and OUTPRT_SPC.
OUTPRT_CHR:
  CALL _LPTOUT
  RET NC
  LD IX,IO_ERR
  JP _CALBAS

; Routine at 7095
;
; Used by the routine at NO_TAB.
OUTPRT_SPC:
  LD A,' '
  JR OUTPRT_CHR

; Routine at 7099
;
; Used by the routine at OUTDO_NOFILE.
_OUTCON:
  POP AF
  JP _CHPUT

; Data block at 7103  ($1bbf)
; Data block size: $800 (2048 bytes)
_FONT:
IF SPECTRUM_SKIN
	BINARY  "ZXFONT.BIN"
ELSE
	BINARY  "msxfont.bin"
ENDIF

  ; --- START PROC L23BF ---
; Accepts a line from console until a CR or STOP
; is typed,and stores the line in a buffer.
_PINLIN:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPINL		; Hook for PINLIN std routine
ENDIF
  LD A,(AUTFLG)		; AUTO mode ?
  AND A
  JR NZ,_INLIN
  LD L,$00
  JR _INLIN_0


; Routine at 9164
;
; Used by the routine at QINLIN.
; Same as PINLIN, except if AUTFLO if set.
; L23CC
_QINLIN:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HQINL		; Hook for QINLIN std routine
ENDIF
  LD A,'?'
  RST OUTDO  		; Output char to the current device
  LD A,' '
  RST OUTDO  		; Output char to the current device
  
; This entry point is used by the routine at INLIN.
_INLIN:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HINLI			; Hook for INLIN std routine
ENDIF
  LD HL,(CSRY)
  DEC L
  CALL NZ,TERMIN
  INC L
_INLIN_0:
  LD (FSTPOS),HL
  XOR A
  LD (INTFLG),A
_INLIN_1:
  CALL _CHGET
  LD HL,INLIN_TBL-2
IF SPECTRUM_SKIN
  ; Unbind CHR$(127) and make it printable
  LD C,10
ELSE
  LD C,11
ENDIF
  CALL TTY_JP
  PUSH AF
  CALL NZ,CTL_CHARS
  POP AF
  JR NC,_INLIN_1
  LD HL,BUFMIN
  RET Z
  CCF
L23FE:
  RET

; Routine at 9215
;
; Used by the routine at _QINLIN.
CTL_CHARS:
  PUSH AF
  CP $09		; TAB ?
  JR NZ,NOTAB
  POP AF
TAB_LOOP:
  LD A,$20
  CALL CTL_CHARS
  LD A,(CSRX)
  DEC A
  AND $07
  JR NZ,TAB_LOOP
  RET

; Routine at 9235
;
; Used by the routine at CTL_CHARS.
NOTAB:
  POP AF
  LD HL,INSFLG
  CP $01	;  ?
  JR Z,NOTAB_0
  CP ' '
  JR C,L2428
  PUSH AF
  LD A,(HL)
  AND A
  CALL NZ,L24F2
  POP AF
NOTAB_0:
  RST OUTDO  		; Output char to the current device
  RET

; Routine at 9256
;
; Used by the routine at NOTAB.
L2428:
  LD (HL),$00
  RST OUTDO  		; Output char to the current device
L242B:
  DEFB $3E  ; "LD A,n" to Mask the next byte
L242C:
  DEFB $3E  ; "LD A,n"   .. Toggle between   "LD A,$AF" and "XOR A"

; This entry point is used by the routines at L24C4, L24E5 and L25CD.
L242D:
  XOR A
  PUSH AF
  CALL ERASE_CURSOR
  POP AF
  LD (CSTYLE),A
  JP DISP_CURSOR


  
; Third TTY JP table (11 entries)
INLIN_TBL:
  DEFB $08		; BS, backspace
  DEFW L2561
  
  DEFB $12		; INS, toggle insert mode
  DEFW L24E5
  
  DEFB $1b		; ESC: No action, (just point to 'RET')
  DEFW L23FE
  
  DEFB $02		; CTRL-B, previous word
  DEFW L260E
  
  DEFB $06		; CTRL-F, next word
  DEFW L25F8
  
  DEFB $0e		; CTRL-N, end of logical line
  DEFW L25D7
  
  DEFB $05		; CTRL-E, clear to end of line
  DEFW L25B9
  
  DEFB $03		; CTRL-STOP, terminate (CTRL-C)
  DEFW L24C5
  
  DEFB $0d		; CR, terminate
  DEFW L245A
  
  DEFB $15		; CTRL-U, clear line
  DEFW L25AE
  
IF SPECTRUM_SKIN
  ; Unbind CHR$(127) and make it printable
ELSE
  DEFB $7f		; DEL, delete character
  DEFW L2550
ENDIF


; CR, terminate
L245A:
  CALL L266C
  LD A,(AUTFLG)		; AUTO mode ?
  AND A
  JR Z,TTY_CR_0
  LD H,$01
TTY_CR_0:
  PUSH HL
  CALL ERASE_CURSOR
  POP HL
  LD DE,BUF
  LD B,$FE
  DEC L
TTY_CR_1:
  INC L
TTY_CR_2:
  PUSH DE
  PUSH BC
  CALL L0BD8
  POP BC
  POP DE
  AND A
  JR Z,TTY_CR_4
  CP $20	; ' ' ?
  JR NC,TTY_CR_3
  DEC B
  JR Z,TTY_CR_5
  LD C,A
  LD A,$01
  LD (DE),A
  INC DE
  LD A,C
  ADD A,$40
TTY_CR_3:
  LD (DE),A
  INC DE
  DEC B
  JR Z,TTY_CR_5
TTY_CR_4:
  INC H
  LD A,(LINLEN)
  CP H
  JR NC,TTY_CR_2
  PUSH DE
  CALL GETTRM
  POP DE
  LD H,$01
  JR Z,TTY_CR_1
TTY_CR_5:
  DEC DE
  LD A,(DE)
  CP ' '
  JR Z,TTY_CR_5
  PUSH HL
  PUSH DE
  CALL DISP_CURSOR
  POP DE
  POP HL
  INC DE
  XOR A
  LD (DE),A
; This entry point is used by the routine at L24C4.
TTY_CR_6:
  LD A,CR
  AND A
; This entry point is used by the routine at L24C4.
TTY_CR_7:
  PUSH AF
  CALL TERMIN
  CALL _POSIT 		; Locate cursor at the specified position
  LD A,LF
  RST OUTDO  		; Output char to the current device
  XOR A
  LD (INSFLG),A
  POP AF
  SCF
  POP HL
  RET

; Routine at 9412
L24C4:
  INC L
; CTRL-STOP, terminate (CTRL-C)
L24C5:
  CALL GETTRM
  JR Z,L24C4
  CALL L242D
  XOR A
  LD (BUF),A
  LD H,$01
  PUSH HL
  CALL _GICINI
  CALL CKSTTP				; Check for STOP trap
  POP HL
  JR C,TTY_CR_6
  LD A,(BASROM)
  AND A
  JR NZ,TTY_CR_6
  JR TTY_CR_7

; Routine at 9445
; INS, toggle insert mode
L24E5:
  LD HL,INSFLG
  LD A,(HL)
  XOR $FF
  LD (HL),A
  JP Z,L242D
  JP L242C

; Routine at 9458
;
; Used by the routine at NOTAB.
L24F2:
  CALL ERASE_CURSOR
  LD HL,(CSRY)
  LD C,$20
; This entry point is used by the routine at L2535.
L24F2_0:
  PUSH HL
L24F2_1:
  PUSH BC
  CALL L0BD8
  POP DE
  PUSH BC
  LD C,E
  CALL OUT_CHAR
  POP BC
  LD A,(LINLEN)
  INC H
  CP H
  LD A,D
  JR NC,L24F2_1
  POP HL
  CALL GETTRM
  JR Z,L2535_2
  LD A,C
  CP $20
  PUSH AF
  JR NZ,L2524
  LD A,(LINLEN)
  CP H
  JR Z,L2524
  POP AF
  JP DISP_CURSOR

; Routine at 9508
;
; Used by the routine at L24F2.
L2524:
  CALL TERMIN+1
  INC L
  PUSH BC
  PUSH HL
  CALL TEXT_LINES
  CP L
  JR C,L2535
  CALL ESC_L_0		; ESC,"L", insert line
  JR L2535_1

; Routine at 9525
;
; Used by the routine at L2524.
L2535:
  LD HL,CSRY
  DEC (HL)
  JR NZ,L2535_0
  INC (HL)
L2535_0:
  LD L,$01
  CALL ESC_M_0		; ESC,"M", delete line
  POP HL
  DEC L
  PUSH HL
; This entry point is used by the routine at L2524.
L2535_1:
  POP HL
  POP BC
  POP AF
  JP Z,DISP_CURSOR
  DEC L
; This entry point is used by the routine at L24F2.
L2535_2:
  INC L
  LD H,$01
  JR L24F2_0

IF SPECTRUM_SKIN
  ; Unbind CHR$(127) and make it printable
ELSE
; Routine at 9552
; DEL, delete character
L2550:
  LD A,(LINLEN)
  CP H
  JR NZ,L2550_0
  CALL GETTRM
  JR NZ,L2550_5
L2550_0:
  LD A,$1C			; RIGHT, cursor right
  RST OUTDO  		; Output char to the current device
  LD HL,(CSRY)
ENDIF
  
; BS, backspace
L2561:
  PUSH HL
  CALL ERASE_CURSOR
  POP HL
  DEC H
  JP NZ,L2550_2
  INC H
  PUSH HL
  DEC L
  JR Z,L2550_1
  LD A,(LINLEN)
  LD H,A
  CALL GETTRM
  JR NZ,L2550_1
  EX (SP),HL
L2550_1:
  POP HL
L2550_2:
  LD (CSRY),HL
L2550_3:
  LD A,(LINLEN)
  CP H
  JR Z,L2550_5
  INC H
L2550_4:
  CALL L0BD8
  DEC H
  CALL OUT_CHAR
  INC H
  INC H
  LD A,(LINLEN)
  INC A
  CP H
  JR NZ,L2550_4
  DEC H
L2550_5:
  LD C,' '
  CALL OUT_CHAR
  CALL GETTRM
  JP NZ,DISP_CURSOR
  PUSH HL
  INC L
  LD H,$01
  CALL L0BD8
  EX (SP),HL
  CALL OUT_CHAR
  POP HL
  JR L2550_3

; Routine at 9646
; CTRL-U, clear line
L25AE:
  CALL ERASE_CURSOR
  CALL L266C
  LD (CSRY),HL
  JR L25B9_0

; Routine at 9657
; CTRL-E, clear to end of line
L25B9:
  PUSH HL
  CALL ERASE_CURSOR
  POP HL
; This entry point is used by the routine at L25AE.
L25B9_0:
  CALL GETTRM
  PUSH AF
  CALL ESC_K	; ESC,"K", clear to end of line
  POP AF
  JR NZ,L25CD
  LD H,$01
  INC L
  JR L25B9_0

; Routine at 9677
;
; Used by the routines at L25B9, L25D7, L25F8 and L260E.
L25CD:
  CALL DISP_CURSOR
  XOR A
  LD (INSFLG),A
  JP L242D

; Routine at 9687
; CTRL-N, end of logical line
L25D7:
  CALL ERASE_CURSOR
  LD HL,(CSRY)
  DEC L
L25D7_0:
  INC L
  CALL GETTRM
  JR Z,L25D7_0
  LD A,(LINLEN)
  LD H,A
  INC H
L25D7_1:
  DEC H
  JR Z,L25D7_2
  CALL L0BD8
  CP $20
  JR Z,L25D7_1
L25D7_2:
  CALL CURS_RIGHT
  JR L25CD

; Routine at 9720
; CTRL-F, next word
L25F8:
  CALL ERASE_CURSOR
  CALL L2634
L25F8_0:
  CALL L2624
  JR Z,L25CD
  JR C,L25F8_0
L25F8_1:
  CALL L2624
  JR Z,L25CD
  JR NC,L25F8_1
  JR L25CD

; Routine at 9742
; CTRL-B, previous word
L260E:
  CALL ERASE_CURSOR
L260E_0:
  CALL L2634
  JR Z,L25CD
  JR NC,L260E_0
L260E_1:
  CALL L2634
  JR Z,L25CD
  JR C,L260E_1
  CALL CURS_RIGHT
  JR L25CD

; Routine at 9764
;
; Used by the routine at L25F8.
L2624:
  LD HL,(CSRY)
  CALL CURS_RIGHT
  CALL TEXT_LINES
  LD E,A
  LD A,(LINLEN)
  LD D,A
  JR L2641

; Routine at 9780
;
; Used by the routines at L25F8 and L260E.
L2634:
  LD HL,(CSRY)
  CALL CURS_LEFT
  LD DE,$0101		; TOP-LEFT ?
  
; This entry point is used by the routine at L2624.
L2641:
  LD HL,(CSRY)
  RST DCOMPR		; Compare HL with DE.
  RET Z				; ret if so
  LD DE,L2668
  PUSH DE
  CALL L0BD8
  CP '0'
  CCF
  RET NC
  CP '9'+1
  RET C
  CP 'A'
  CCF
  RET NC
  CP 'Z'+1
  RET C
  CP 'a'
  CCF
  RET NC
  CP 'z'+1
  RET C
  CP $86		; TK_DIM ?
  CCF
  RET NC
  CP $A0		; TK_WIDTH ?
  RET C
  CP $A6		; TK_ERROR ?
  CCF
L2668:
  LD A,$00
  INC A
  RET

; Routine at 9836
;
; Used by the routines at TTY_CR and L25AE.

L266C:
  DEC L
  JR Z,L266C_0
  CALL GETTRM
  JR Z,L266C
L266C_0:
  INC L
  LD A,(FSTPOS)
  CP L
  LD H,$01
  RET NZ
  LD HL,(FSTPOS)
  RET

; Routine at 9856
CSTART:
  JP _CSTART

; Routine at 9859
;
; Used by the routine at SYNCHR.
; Check syntax: a byte follows to be compared 
_SYNCHR:
  JP __SYNCHR

; Routine at 9862
;
; Used by the routine at CHRGTB.
; Gets next character (or token) from BASIC text.
_CHRGTB:
  JP __CHRGTB

; Routine at 9865
;
; Used by the routine at GETYPR.
; Return the number type (FAC)
_GETYPR:
  JP __GETYPR

; Routine at 9868
;
; Used by the routines at __SIN, __ATN, __EXP and SUBPHL.
; FACCU <- FACCU-ARG
DECSUB:
  LD HL,ARG
  LD A,(HL)
  OR A
  RET Z
  XOR $80
  LD (HL),A
  JR DECADD_0

  ; --- START PROC L2697 ---
ARG2DE_DECADD:
  CALL ARG2DE
  ; --- START PROC DECADD ---
; FACCU <- FACCU+ARG
DECADD:
  LD HL,ARG
  LD A,(HL)
  OR A
  RET  Z
  ; --- START PROC DECADD_0 ---
DECADD_0:
  AND $7F   ;
  LD B,A
  LD DE,FACCU
  LD A,(DE)
  OR A
  JP Z,FP_ARG2DE
  AND $7F   ; ABS?
  SUB B
  JR NC,DECADD_2
  CPL
  INC A
  PUSH AF
  PUSH HL
  LD B,$08		; DBL number, 8 bytes
DECADD_1:
  LD A,(DE)
  LD C,(HL)
  LD (HL),A
  LD A,C
  LD (DE),A
  INC DE
  INC HL
  DJNZ DECADD_1
  POP HL
  POP AF
DECADD_2:
  CP $10
  RET NC
  PUSH AF
  XOR A
  LD (FACCU+8),A
  LD (ARG+8),A
  LD HL,ARG+1
  POP AF
  CALL L27A3
  LD HL,ARG
  LD A,(FACCU)
  XOR (HL)
  JP M,L26F7
  LD A,(ARG+8)
  LD (FACCU+8),A
  CALL BCDADD
  JP NC,DECROU
  EX DE,HL
  LD A,(HL)
  INC (HL)
  XOR (HL)
  JP M,OV_ERR		; Err $06 -  "Overflow"
  CALL DV16FACCU
  SET 4,(HL)
  JR DECROU

; Routine at 9975
;
; Used by the routine at DECADD.
L26F7:
  CALL BCDSUB
; This entry point is used by the routines at BNORM and __RND.
DECNRM:
; Normalize FACCU
  LD HL,FACCU+1
  LD BC,$0800		; 2048
DECNRM_0:
  LD A,(HL)
  OR A
  JR NZ,L270C
  INC HL
  DEC C
  DEC C
  DJNZ DECNRM_0
  JP ZERO_EXPONENT

; Routine at 9996
;
; Used by the routine at L26F7.
L270C:
  AND $F0
  JR NZ,L270C_0
  PUSH HL
  CALL ML16FACCU	; shift 4 bits left the whole accumulator (multiply by 16)
  POP HL
  DEC C
L270C_0:
  LD A,$08
  SUB B
  JR Z,L270C_2
  PUSH AF
  PUSH BC
  LD C,B
  LD DE,FACCU+1
  LD B,$00
  LDIR
  POP BC
  POP AF
  LD B,A
  XOR A
DECADD_8:
  LD (DE),A
  INC DE
  DJNZ DECADD_8
L270C_2:
  LD A,C
  OR A
  JR Z,DECROU
  LD HL,FACCU
  LD B,(HL)
  ADD A,(HL)
  LD (HL),A
  XOR B
  JP M,OV_ERR		; Err $06 -  "Overflow"
  RET Z

; This entry point is used by the routines at DECADD and L3301.
; Single precision rounding
DECROU:
  LD HL,FACCU+8
  LD B,$07
; This entry point is used by the routine at L377B.
BNORM_8:
  LD A,(HL)
  CP $50
  RET C
  DEC HL
  XOR A
  SCF
L270C_5:
  ADC A,(HL)
  DAA
  LD (HL),A
  RET NC
  DEC HL
  DJNZ L270C_5
  LD A,(HL)
  INC (HL)
  XOR (HL)
  JP M,OV_ERR		; Err $06 -  "Overflow"
  INC HL
  LD (HL),$10
  RET

; Routine at 10073
;
; Used by the routine at DECADD.
; Add the BCD number in (HL) to (DE).  Result in (DE)
BCDADD:
  LD HL,ARG+7
  LD DE,FACCU+7
  LD B,$07
; This entry point is used by the routine at DECMUL.
DAA_PASS2:
  XOR A
  
; Add the BCD number in (HL) to (DE).  Result in (DE)
BCDADD_1:
  LD A,(DE)
  ADC A,(HL)
  DAA
  LD (DE),A
  DEC DE
  DEC HL
  DJNZ BCDADD_1
  RET

; Routine at 10091
;
; Used by the routine at L26F7.
; Subtract the BCD number in (HL) from (DE).
BCDSUB:
  LD HL,ARG+8
  LD A,(HL)
  CP $50
  JR NZ,BCDSUB_0
  INC (HL)
BCDSUB_0:
  LD DE,FACCU+8
  LD B,$08
  XOR A
BCDSUB_1:
  LD A,(DE)
  SBC A,(HL)
  DAA
  LD (DE),A
  DEC DE
  DEC HL
  DJNZ BCDSUB_1
  RET NC
  EX DE,HL
  LD A,(HL)
  XOR $80
  LD (HL),A
  LD HL,FACCU+8
  LD B,$08
  XOR A
BCDSUB_2:
  LD A,$00
  SBC A,(HL)
  DAA
  LD (HL),A
  DEC HL
  DJNZ BCDSUB_2
  RET

; Routine at 10135
;
; Used by the routine at L270C.
ML16FACCU:
  LD HL,FACCU+8
L279A:
  PUSH BC
  XOR A
RLDLOOP:
  RLD
  DEC HL
  DJNZ RLDLOOP
  POP BC
  RET

; Routine at 10147
;
; Used by the routine at DECADD.
L27A3:
  OR A
  RRA
  PUSH AF
  OR A
  JP Z,DV16PHL_0
  PUSH AF
  CPL
  INC A
  LD C,A
  LD B,$FF
  LD DE,$0007
  ADD HL,DE
  LD D,H
  LD E,L
  ADD HL,BC
  LD A,$08
  ADD A,C
  LD C,A
  PUSH BC
  LD B,$00
  LDDR
  POP BC
  POP AF
  INC HL
  INC DE
  PUSH DE
  LD B,A
  XOR A
L27A3_0:
  LD (HL),A
  INC HL
  DJNZ L27A3_0
  POP HL
  POP AF
  RET NC
  LD A,C
; This entry point is used by the routine at DV16FACCU.
L27A3_1:
  PUSH HL
  PUSH BC
  LD B,A
  XOR A
L27A3_2:
  RRD
  INC HL
  DJNZ L27A3_2
  POP BC
  POP HL
  RET

; Routine at 10203
;
; Used by the routines at DECADD, L35F9 and L377B.
DV16FACCU:
  LD HL,FACCU+1
; This entry point is used by the routine at DV16PHL_0.
DV16PHL:
  LD A,$08
  JR L27A3_1

; Routine at 10210
;
; Used by the routine at L27A3.
DV16PHL_0:
  POP AF
  RET NC
  JR DV16PHL

; Routine at 10214
;
; Used by the routines at __LOG, MULPHL, SUMSER, FMULT and DECEXP.
DECMUL:
  CALL SIGN				; Test sign of FP accumulator
  RET Z                 ; Return zero if zero
  LD A,(ARG)
  OR A
  JP Z,ZERO_EXPONENT
  LD B,A
  LD HL,FACCU
  XOR (HL)
  AND $80
  LD C,A
  RES 7,B
  LD A,(HL)
  AND $7F			; ABS
  ADD A,B
  LD B,A
  LD (HL),$00
  AND $C0
  RET Z
  CP $C0
  JR NZ,DECMUL_0
  JP OV_ERR			; Err $06 -  "Overflow"
  
DECMUL_0:
  LD A,B
  ADD A,$40
  AND $7F			; ABS
  RET Z
  OR C
  DEC HL
  LD (HL),A
  LD DE,HOLD+7
  LD BC,$0008
  LD HL,FACCU+7
  PUSH DE
  LDDR
  INC HL
  XOR A

  LD B,$08

; Init FP accumulator to zero
DECMUL_1:
  LD (HL),A
  INC HL
  DJNZ DECMUL_1
  POP DE
  LD BC,BNORM		; NORMALIZE
  PUSH BC
; This entry point is used by the routine at __RND.
DECMUL_2:
  CALL DAA_PASS1	; ADC/DAA loop
  PUSH HL
  LD BC,$0008
  EX DE,HL
  LDDR
  EX DE,HL
  LD HL,HOLD2+7
  LD B,$08
  CALL DAA_PASS2	; ADC/DAA loop
  POP DE
  CALL DAA_PASS1	; ADC/DAA loop
  LD C,$07
  LD DE,ARG+7
DECMUL_3:
  LD A,(DE)
  OR A
  JR NZ,DECMUL_4

  DEC DE
  DEC C
  JR DECMUL_3

DECMUL_4:
  LD A,(DE)
  DEC DE
  PUSH DE
  LD HL,HOLD8+7  ; HOLD8+7				; Double precision operations work area
DECMUL_5:
  ADD A,A
  JR C,DECMUL_7
  JR Z,DECMUL_8

DECMUL_6:
  LD DE,$0008
  ADD HL,DE
  JR DECMUL_5

DECMUL_7:
  PUSH AF
  LD B,$08
  LD DE,FACCU+7
  PUSH HL
  CALL DAA_PASS2
  POP HL
  POP AF
  JR DECMUL_6
 
DECMUL_8:
  LD B,$0F
  LD DE,FACCU+14	; some declaration is missing here but the distances between
  LD HL,FACCU+15	; the labels in this work area is the same on all the target computers
  CALL LDDR_DEHL
  LD (HL),$00
  POP DE
  DEC C
  JR NZ,DECMUL_4
  RET

; Routine at 10371
BNORM:
  DEC HL
  LD A,(HL)
  INC HL
  LD (HL),A
  JP DECNRM		; Single precision normalization

; Routine at 10378
;
; Used by the routine at DECMUL.
; IN: HL=last byte of value
DAA_PASS1:
  LD HL,$FFF8		; -8
  ADD HL,DE			; Move on first byte of value
  LD C,$03
DAA_PASS1_0:
  LD B,$08
  OR A
DAA_PASS1_1:
  LD A,(DE)
  ADC A,A
  DAA
  LD (HL),A
  DEC HL
  DEC DE
  DJNZ DAA_PASS1_1
  DEC C
  JR NZ,DAA_PASS1_0
  RET

; Data block at 10399
  ; --- START PROC L289F ---
DECDIV:
  LD A,(ARG)
  OR A
  JP Z,O_ERR		; Err $0B - "Division by zero"
  LD B,A
  LD HL,FACCU
  LD A,(HL)
  OR A
  JP Z,ZERO_EXPONENT
  XOR B
  AND $80
  LD C,A
  RES 7,B
  LD A,(HL)
  AND $7F			; ABS
  SUB B
  LD B,A
  RRA
  XOR B
  AND $40
  LD (HL),$00		; zero exponent
  JR Z,L28C9
  LD A,B
  AND $80
  RET NZ
L28C6:
  JP OV_ERR			; Err $06 -  "Overflow"


L28C9:
  LD A,B
  ADD A,$41
  AND $7F			; ABS
  LD (HL),A
  JR Z,L28C6
  OR C
  LD (HL),$00
  DEC HL
  LD (HL),A
  LD DE,FACCU+7
  LD HL,ARG+7			; Unknown system variable ?
  LD B,$07
  XOR A
L28DF:
  CP (HL)
  JR NZ,L28E6
  DEC DE
  DEC HL
  DJNZ L28DF
L28E6:
  LD (DECTM2),HL		; Used at division routine execution
  EX DE,HL
  LD (DECTMP),HL
  LD A,B
  LD (DECCNT),A
  LD HL,HOLD
L28F4:
  LD B,$0F
L28F6:
  PUSH HL
  PUSH BC
  LD HL,(DECTM2)
  EX DE,HL
  LD HL,(DECTMP)
  LD A,(DECCNT)
  LD C,$FF
L2904:
  INC C
  LD B,A
  PUSH HL
  PUSH DE
  XOR A
  EX DE,HL
L290A:
  LD A,(DE)
  SBC A,(HL)
  DAA
  LD (DE),A
  DEC HL
  DEC DE
  DJNZ L290A
  LD A,(DE)
  SBC A,B
  LD (DE),A
  POP DE
  POP HL
  LD A,(DECCNT)
  JR NC,L2904
  LD B,A
  EX DE,HL
  CALL DAA_PASS2
  JR NC,L2925
  EX DE,HL
  INC (HL)
L2925:
  LD A,C
  POP BC
  LD C,A
  PUSH BC
  SRL B
  INC B
  LD E,B
  LD D,$00
  LD HL,FACCU-1
  ADD HL,DE
  CALL L279A
  POP BC
  POP HL
  LD A,B
  INC C
  DEC C
  JR NZ,L2973
  CP $0F
  JR Z,L2964
  RRCA
  RLCA
  JR NC,L2973
  PUSH BC
  PUSH HL
  LD HL,FACCU
  LD B,$08
  XOR A
L294D:
  CP (HL)
  JR NZ,L295F
  INC HL
  DJNZ L294D
  POP HL
  POP BC
  SRL B
  INC B
  XOR A
L2959:
  LD (HL),A
  INC HL
  DJNZ L2959
  JR L2985

L295F:
  POP HL
  POP BC
  LD A,B
  JR L2973

L2964:
  LD A,(FACCU-1)
  LD E,A
  DEC A
  LD (FACCU-1),A
  XOR E
  JP P,L28F4
  JP ZERO_EXPONENT

L2973:
  RRA
  LD A,C
  JR C,L297C
  OR (HL)
  LD (HL),A
  INC HL
  JR L2981

L297C:
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD (HL),A
L2981:
  DEC B
  JP NZ,L28F6
L2985:
  LD HL,FACCU+8
  LD DE,HOLD+7
  LD B,$08
  CALL LDDR_DEHL
  JP BNORM			; NORMALIZE

  ; --- START PROC L2993 ---

; Routine at 10643
;
; Used by the routine at __TAN.
;
;  "Sine/Cosine" Taylor polynomial algorithm
__COS:
  LD HL,FP_EPSILON
  CALL MULPHL
  LD A,(FACCU)
  AND $7F			; ABS
  LD (FACCU),A
  LD HL,FP_QUARTER
  CALL SUBPHL
  CALL NEG
  JR __SIN_0

; Routine at 10668
;
; Used by the routine at __TAN.
__SIN:
;; Trick to inspect single precision constants, "PRINT  SIN(X)" to display the value
;  LD BC,$xxxx
;  LD DE,$yyyy
;  CALL FPBCDE
;  CALL __CDBL
;  JP SETTYPE_DBL
;;

;; Trick to inspect constants, "PRINT  SIN(X)" to display the value
;; (to preserve the code size, comment out the next three instructions)
;  LD HL,_const_
;  CALL HL2FACCU
;  JP SETTYPE_DBL
;;

  LD HL,FP_EPSILON
  CALL MULPHL
; This entry point is used by the routine at __COS.
__SIN_0:
  LD A,(FACCU)
  OR A
  CALL M,NEGAFT
  CALL STAKFP
  CALL __INT
  CALL FACCU2ARG
  CALL USTAKFP
  CALL DECSUB
  LD A,(FACCU)
  CP $40
  JP C,__SIN_2
  LD A,(FACCU+1)
  CP $25
  JP C,__SIN_2
  CP $75
  JP NC,__SIN_1
  CALL FACCU2ARG
  LD HL,FP_HALF
  CALL HL2FACCU
  CALL DECSUB
  JP __SIN_2
__SIN_1:
  LD HL,FP_UNITY
  CALL HL2ARG
  CALL DECSUB
__SIN_2:
  LD HL,FP_SINTAB				; 8 values series
  JP SUMSER

; Routine at 10747
__TAN:
  CALL STAKFP
  CALL __COS
  CALL XSTKFP
  CALL __SIN
  CALL USTAKARG
  LD A,(ARG)
  OR A
  JP NZ,DECDIV
  JP OV_ERR			; Err $06 -  "Overflow"

; Routine at 10772
__ATN:
  LD A,(FACCU)
  OR A
  RET Z
  CALL M,NEGAFT
  CP $41			; Number less than 1?
  JP C,__ATN_0		; Yes - Get arc tangnt
  CALL FACCU2ARG
  LD HL,FP_UNITY
  CALL HL2FACCU
  CALL DECDIV
  CALL __ATN_0
  CALL FACCU2ARG
  LD HL,FP_HALFPI
  CALL HL2FACCU
  JP DECSUB
  
__ATN_0:
  LD HL,FP_TAN15
  CALL CMPPHL
  JP M,__ATN_1
  CALL STAKFP
  LD HL,FP_SQR3
  CALL ADDPHL
  CALL XSTKFP
  LD HL,FP_SQR3
  CALL MULPHL
  LD HL,FP_UNITY
  CALL SUBPHL
  CALL USTAKARG
  CALL DECDIV		; Get reciprocal of number
  CALL __ATN_1
  LD HL,FP_SIXTHPI
  JP ADDPHL
  
__ATN_1:
  LD HL,FP_ATNTAB
  JP SUMSER

; Routine at 10866
;
; Used by the routine at DECEXP.
__LOG:
  CALL SIGN			; test FP number sign
  JP M,FC_ERR			; Err $05 - "Illegal function call"
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  LD HL,FACCU
  LD A,(HL)
  PUSH AF
  LD (HL),$41
  LD HL,FP_10EXHALF
  CALL CMPPHL
  JP M,__LOG_0
  POP AF
  INC A
  PUSH AF
  LD HL,FACCU
  DEC (HL)
__LOG_0:
  POP AF
  LD (TEMP3),A
  CALL STAKFP
  LD HL,FP_UNITY
  CALL ADDPHL
  CALL XSTKFP
  LD HL,FP_UNITY
  CALL SUBPHL
  CALL USTAKARG
  CALL DECDIV
  CALL STAKFP
  CALL SQUAREFP
  CALL STAKFP
  CALL STAKFP
  LD HL,FP_LOGTAB2		; 5 values series
  CALL SMSER1_0
  CALL XSTKFP
  LD HL,FP_LOGTAB		; 4 values series
  CALL SMSER1_0
  CALL USTAKARG
  CALL DECDIV
  CALL USTAKARG
  CALL DECMUL
  LD HL,FP_TWODLN10
  CALL ADDPHL
  CALL USTAKARG
  CALL DECMUL
  CALL STAKFP
  LD A,(TEMP3)
  SUB $41
  LD L,A
  ADD A,A
  SBC A,A
  LD H,A
  CALL HL_CSNG
  CALL ZERO_FACCU
  CALL USTAKARG
  CALL DECADD
  LD HL,FP_LN10
  JP MULPHL

; Data block at 11007
__SQR:
  CALL SIGN			; test FP number sign
  RET Z
  JP  M,FC_ERR			; Err $05 - "Illegal function call"
  CALL FACCU2ARG
  LD A,(FACCU)
  OR A
  RRA
  ADC A,$20
  LD (ARG),A
  LD A,(FACCU+1)
  OR A
  RRCA
  OR A
  RRCA
  AND $33
  ADD A,$10
  LD (ARG+1),A
  LD A,$07
__SQR_0:
  LD (TEMP3),A
  CALL STAKFP
  CALL STAKARG
  CALL DECDIV
  CALL USTAKARG
  CALL DECADD
  LD HL,FP_HALF
  CALL MULPHL
  CALL FACCU2ARG
  CALL USTAKFP
  LD A,(TEMP3)
  DEC A
  JR NZ,__SQR_0
  JP ARG2FACCU

; Routine at 11082
;
; Used by the routine at DECEXP.
__EXP:
  LD HL,FP_LOG10E
  CALL MULPHL
  CALL STAKFP
  CALL __CINT
  LD A,L
  RLA
  SBC A,A
  CP H
  JR Z,__EXP_1
  LD A,H
  OR A
  JP P,__EXP_0
  CALL SETTYPE_DBL
  CALL USTAKFP
  LD HL,FP_ZERO
  JP HL2FACCU
__EXP_0:
  JP OV_ERR			; Err $06 -  "Overflow"
  
__EXP_1:
  LD (TEMP3),HL
  CALL __CDBL
  CALL FACCU2ARG
  CALL USTAKFP
  CALL DECSUB
  LD HL,FP_HALF
  CALL CMPPHL
  PUSH AF
  JR Z,__EXP_2
  JR C,__EXP_2
  LD HL,FP_HALF
  CALL SUBPHL
__EXP_2:
  CALL STAKFP
  LD HL,FP_EXPTAB2	; 3 values series
  CALL SUMSER
  CALL XSTKFP
  LD HL,FP_EXPTAB	; 4 values series
  CALL SMSER1
  CALL USTAKARG
  CALL STAKARG
  CALL STAKFP
  CALL DECSUB
  LD HL,HOLD
  CALL DBL_FACCU2HL
  CALL USTAKARG
  CALL USTAKFP
  CALL DECADD
  LD HL,HOLD
  CALL HL2ARG
  CALL DECDIV
  POP AF
  JR C,__EXP_3
  JR Z,__EXP_3
  LD HL,FP_10EXHALF
  CALL MULPHL
__EXP_3:
  LD A,(TEMP3)
  LD HL,FACCU
  LD C,(HL)
  ADD A,(HL)
  LD (HL),A
  XOR C
  RET P
  JP OV_ERR			; Err $06 -  "Overflow"

; Routine at 11231
__RND:
  CALL SIGN			; test FP number sign
  LD HL,RNDX
  JR Z,__RND_0
  CALL M,DBL_FACCU2HL
  LD HL,HOLD
  LD DE,RNDX
  CALL DBL2HL
  LD HL,RNDTAB_1
  CALL HL2ARG
  LD HL,RNDTAB_2
  CALL HL2FACCU
  LD DE,HOLD+7
  CALL DECMUL_2
  LD DE,FACCU+8
  LD HL,RNDX+1
  LD B,$07
  CALL CPY2HL   		; Copy B bytes from DE to HL
  LD HL,RNDX
  LD (HL),$00
__RND_0:
  CALL HL2FACCU
  LD HL,FACCU
  LD (HL),$40
  XOR A
L2C18:
	; L2C18+2:  
  LD (FACCU+8),A
  JP DECNRM		; Single precision normalization

; Routine at 11300
;
; Used by the routine at L628E.
INIT_RND:
  LD DE,RNDX_INIT
  LD HL,RNDX
  JR DBL2HL

; Routine at 11308
;
; Used by the routines at __ATN and __LOG.
ADDPHL:
  CALL HL2ARG
  JP DECADD

; Routine at 11314
;
; Used by the routines at __COS, __ATN, __LOG and __EXP.
SUBPHL:
  CALL HL2ARG
  JP DECSUB

; Routine at 11320
;
; Used by the routines at __LOG and SMSER1.
SQUAREFP:
  LD HL,FACCU

; ADD number at HL to BCDE
;
; Used by the routines at __COS, __SIN, __ATN, __LOG, __SQR, __EXP, SMSER1 and
; L3878.
MULPHL:
  CALL HL2ARG
  JP DECMUL

; Routine at 11329
DIVPHL:
  CALL HL2ARG
  JP DECDIV

; Routine at 11335
;
; Used by the routines at __ATN, __LOG and __EXP.
CMPPHL:
  CALL HL2ARG
  JP XDCOMP

; Routine at 11341
;
; Used by the routines at __SIN, __ATN, __SQR, __EXP and L3878.
FACCU2ARG:
  LD HL,FACCU
; This entry point is used by the routines at __SIN, __EXP, __RND, ADDPHL,
; SUBPHL, MULPHL, DIVPHL, CMPPHL and SMSER1.

HL2ARG:
  LD DE,ARG
; This entry point is used by the routine at ARG2FACCU.
FP2DE:
  EX DE,HL
  CALL DBL2HL
  EX DE,HL
  RET

; Routine at 11353
;
; Used by the routines at __SQR, XSTKFP, DECEXP, L3878 and L391A.
ARG2FACCU:
  LD HL,ARG
; This entry point is used by the routines at __SIN, __ATN, __EXP, __RND,
; SMSER1, L375F, DECEXP and L3878.
HL2FACCU:
  LD DE,FACCU
  JR FP2DE

; Routine at 11361 ($2C61)
; ..how is this called ?
GET_RNDX:
  CALL HL_CSNG
  LD HL,RNDX
  
; This entry point is used by the routines at __EXP, __RND, SMSER1, DECEXP and
; L3878.
DBL_FACCU2HL:
  LD DE,FACCU
; This entry point is used by the routines at __RND, INIT_RND and FACCU2ARG.
DBL2HL:
  LD B,$08
  JP CPY2HL   		; Copy B bytes from DE to HL

; Routine at 11375
;
; Used by the routines at __TAN, __ATN, __LOG, __EXP and DECEXP.
; Exchange stack and FP value (ARG is used and left = FACCU)
XSTKFP:
  POP HL
  LD (FBUFFR),HL		; Buffer for fout, save ret addr.
  CALL USTAKARG
  CALL STAKFP
  CALL ARG2FACCU
  LD HL,(FBUFFR)		; Buffer for fout, restore ret addr.
  JP (HL)

; Negate number
;
; Used by the routines at __SIN and __ATN.
NEGAFT:
  CALL NEG
  LD HL,NEG
  EX (SP),HL
  JP (HL)

; This entry point is used by the routines at __SIN, __ATN and __EXP.
SUMSER:
  LD (FBUFFR),HL		; Buffer for fout
  CALL STAKFP
  LD HL,(FBUFFR)		; Buffer for fout
  CALL SMSER1
  CALL USTAKARG
  JP DECMUL

; Routine at 11418
;
; Used by the routines at __EXP and SUMSER.
SMSER1:
  LD (FBUFFR),HL		; Buffer for fout
  CALL SQUAREFP
  LD HL,(FBUFFR)		; Buffer for fout
; This entry point is used by the routine at __LOG.
SMSER1_0:
  LD A,(HL)			; Get number of coefficients
  PUSH AF
  INC HL			; Point to start of table
  PUSH HL
  LD HL,FBUFFR		; Buffer for fout
  CALL DBL_FACCU2HL
  POP HL
  CALL HL2FACCU
SUMLP:
  POP AF
  DEC A
  RET Z
  PUSH AF
  PUSH HL
  LD HL,FBUFFR		; Buffer for fout
  CALL MULPHL
  POP HL
  CALL HL2ARG
  PUSH HL
  CALL DECADD
  POP HL
  JR SUMLP

; Routine at 11463
;
; Used by the routines at __SQR, __EXP and L391A.
STAKARG:
  LD HL,ARG+7
  JR STAKFP_0

; Routine at 11468
;
; Used by the routines at __SIN, __TAN, __ATN, __LOG, __SQR, __EXP, XSTKFP,
; SUMSER, DECEXP and L3878.
STAKFP:
  LD HL,FACCU+7
; This entry point is used by the routine at STAKARG.
STAKFP_0:
  LD A,$04
  POP DE
STAKFP_1:
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  PUSH BC
  DEC A
  JR NZ,STAKFP_1
  EX DE,HL
  JP (HL)


; This entry point is used by the routines at __TAN, __ATN, __LOG, __SQR,
; __EXP, XSTKFP, SUMSER, DECEXP and L391A.
USTAKARG:
  LD HL,ARG
  JR USTAK_SUB

  ; --- START PROC USTAKFP ---
USTAKFP:
  LD HL,FACCU

  ; --- START PROC USTAK_SUB ---
USTAK_SUB:
  LD A,$04
  POP DE
USTAK_SUB_0:
  POP BC
  LD (HL),C
  INC HL
  LD (HL),B
  INC HL
  DEC A
  JR NZ,USTAK_SUB_0
  EX DE,HL
  JP (HL)


; FP "operands" for RND

RNDTAB_2:
  DEFB $00,$14,$38,$98,$20,$42,$08,$21

RNDTAB_1:
  DEFB $00,$21,$13,$24,$86,$54,$05,$19 

; Constant to initialize the "last random number" variable
RNDX_INIT:
  DEFB $00,$40,$64,$96,$51,$37,$23,$58


; FP Numeric constants

FP_LOG10E:
  DEFB $40,$43,$42,$94,$48,$19,$03,$24		; LOG(E)	 =~  0.43429448190324

FP_HALF:
  DEFB $40,$50								; 0.5
FP_ZERO:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00		; 0

; Why did they optimize space for FP_HALF and
; preferred not to reuse the last value of FP_ATNTAB for FP UNITY ?
FP_UNITY:
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		;  1

FP_QUARTER:
  DEFB $40,$25,$00,$00,$00,$00,$00,$00		; 1/4		=  0.25

FP_10EXHALF:
  DEFB $41,$31,$62,$27,$76,$60,$16,$84		; 10^(1/2)  =~ 3.1622776601684

FP_TWODLN10:
  DEFB $40,$86,$85,$88,$96,$38,$06,$50		; 2/LN(10)	=~ 0.8685889638065

FP_LN10:
  DEFB $41,$23,$02,$58,$50,$92,$99,$40		; LN(10)	=~ 2.302585092994

FP_HALFPI:
  DEFB $41,$15,$70,$79,$63,$26,$79,$49		; PI/2		=~ 1.5707963267949 

FP_TAN15:
  DEFB $40,$26,$79,$49,$19,$24,$31,$12		; TAN(15)	=~ 0.26794919243112

FP_SQR3:
  DEFB $41,$17,$32,$05,$08,$07,$56,$89		; SQR(3)	=~ 1.7320508075689

FP_SIXTHPI:
  DEFB $40,$52,$35,$98,$77,$55,$98,$30		; PI/6		=~ 0.5235987755983

FP_EPSILON:
  DEFB $40,$15,$91,$54,$94,$30,$91,$90		; 1/(2*PI)	=~  0.1591549430919

FP_EXPTAB:
  DEFB $04	; 4 values series
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		; 1
  DEFB $43,$15,$93,$74,$15,$23,$60,$31		; 159.37415236031
  DEFB $44,$27,$09,$31,$69,$40,$85,$16		; 2709.3169408516
  DEFB $44,$44,$97,$63,$35,$57,$40,$58		; 4497.6335574058

FP_EXPTAB2:
  DEFB $03	; 3 values
  DEFB $42,$18,$31,$23,$60,$15,$92,$75		; 18.31236015975
  DEFB $43,$83,$14,$06,$72,$12,$93,$71		; 831.4067219371
  DEFB $44,$51,$78,$09,$19,$91,$51,$62		; 5178.0919915162
  
FP_LOGTAB:
  DEFB $04	; 4 values
  DEFB $c0,$71,$43,$33,$82,$15,$32,$26		; -0.71433382153226
  DEFB $41,$62,$50,$36,$51,$12,$79,$08		; 6.2503651127908
  DEFB $C2,$13,$68,$23,$70,$24,$15,$03		; -13.682370241503
  DEFB $41,$85,$16,$73,$19,$87,$23,$89		; 8.5167319872389

FP_LOGTAB2:
  DEFB $05	; 5 values
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		; 1
  DEFB $C2,$13,$21,$04,$78,$35,$01,$56		; -13.210478350156
  DEFB $42,$47,$92,$52,$56,$04,$38,$73		; 47.925256043873
  DEFB $C2,$64,$90,$66,$82,$74,$09,$43		; -64.906682740943
  DEFB $42,$29,$41,$57,$50,$17,$23,$23		; 29.415750172323

; Compared to the earlier BASIC versions this one is much more accurate
; the first three values of the list were simply missing
FP_SINTAB:
  DEFB $08	; 8 values
  DEFB $C0,$69,$21,$56,$92,$29,$18,$09		; -0.69215692291809
  DEFB $41,$38,$17,$28,$86,$38,$57,$71 		; 3.8172886385771
  DEFB $C2,$15,$09,$44,$99,$47,$48,$01		; -15.094499474801
  DEFB $42,$42,$05,$86,$89,$66,$73,$55		; 42.048689667355
  DEFB $c2,$76,$70,$58,$59,$68,$32,$91		; -76.605859683291 
  DEFB $42,$81,$60,$52,$49,$27,$55,$13		; 81.605249275513
  DEFB $c2,$41,$34,$17,$02,$24,$03,$98		; -41.341702240398
  DEFB $41,$62,$83,$18,$53,$07,$17,$96		; 6.2831853071796

FP_ATNTAB:
  DEFB $08	; 8 values                      ; Approx. conversion of list
  DEFB $BF,$52,$08,$69,$39,$04,$00,$00		; -1/19   =~ -0.05208693904    (slightly smaller)
  DEFB $3F,$75,$30,$71,$49,$13,$48,$00		;  1/13   =~  0.0753071491348  (slightly smaller)
  DEFB $bf,$90,$81,$34,$32,$24,$70,$50		; -1/11   =~ -0.09081343224705
  DEFB $40,$11,$11,$07,$94,$18,$40,$29		;  1/9    =~  0.11110794184029
  DEFB $C0,$14,$28,$57,$08,$55,$48,$84		; -1/7    =~ -0.14285708554884
  DEFB $40,$19,$99,$99,$99,$94,$89,$67		;  1/5    =~  0.19999999948967
  DEFB $C0,$33,$33,$33,$33,$33,$31,$60		; -1/3    =~ -0,3333333333316
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		;  1/1    =  1


  
  
  ; --- START PROC SIGN ---
  ; test FP number sign
SIGN:
  LD A,(FACCU)
  OR A
  RET Z
L2E76:
  DEFB $FE		;  CP 2Fh ..hides the "CPL" instruction
SGN_RESULT_CPL:
  CPL  
  ; --- START PROC L2E78 ---
SGN_RESULT:
  RLA
  ; --- START PROC L2E79 ---
EVAL_RESULT:
  SBC A,A
  RET NZ
  INC A
  RET

; Routine at 11901
;
; Used by the routines at L26F7, DECMUL and __FIX.
ZERO_EXPONENT:
  XOR A
  LD (FACCU),A
  RET

; Routine at 11906
__ABS:
  CALL _TSTSGN
  RET P

; Invert number sign
;
; Used by the routines at __FIX, L3301 and OPRND.
INVSGN:
  RST GETYPR 		; Get the number type (FAC)
  JP M,DBL_ABS
  JP Z,TM_ERR				; If string type, Err $0D - "Type mismatch"
  
; This entry point is used by the routines at __COS, NEGAFT, __FIX, IMULT and
; FSUB.
NEG:
  LD HL,FACCU

INVSGN_1:
  LD A,(HL)
  OR A
  RET Z
  XOR $80
  LD (HL),A
  RET

; Routine at 11927
__SGN:
  CALL _TSTSGN
; This entry point is used by the routines at L4F57, CAS_EOF, FN_PLAY and __STRIG.
; Signed char to signed int conversion, then return
INT_RESULT_A:
  LD L,A
  RLA
  SBC A,A
  LD H,A
  JP INT_RESULT_HL

; Routine at 11937
;
; Used by the routines at __ABS, __SGN and __IF.
_TSTSGN:
  RST GETYPR 		; Get the number type (FAC)
  JP Z,TM_ERR				; If string type, Err $0D - "Type mismatch"
  JP P,SIGN			; test FP number sign
  LD HL,(FACLOW)
  ; --- START PROC __TSTSGN_0 ---
__TSTSGN_0:
  LD A,H
  OR L
  RET Z
  LD A,H
  JR SGN_RESULT

; Routine at 11953
;
; Used by the routines at IADD, IMULT, L4D26, IDIV and CIRCLE_SUB.
STAKI:
  EX DE,HL
  LD HL,(FACLOW)
  EX (SP),HL
  PUSH HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  RET

; Routine at 11966
;
; Used by the routine at L7684.
PHLTFP:
  CALL LOADFP

; Move BCDE to FPREG
;
; Used by the routine at L4D26.
FPBCDE:
  EX DE,HL
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACCU),HL
  EX DE,HL
  RET

; Routine at 11980
;
; Used by the routine at L4D26.
; LOAD (FACCU) on BCDE registers
BCDEFP:
  LD HL,(FACLOW)
  EX DE,HL
  LD HL,(FACCU)
  LD C,L
  LD B,H
  RET

; Routine at 11990
;
; Load single precision FP value from (HL) in reverse byte order
; Used by the routine at __NEXT.
LOADFP_REV:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  RET

; Routine at 11999
;
; Used by the routines at PHLTFP, L324B, __NEXT and L6719.ù
; $2EDF
LOADFP:
  LD E,(HL)
  INC HL
; This entry point is used by the routine at PRS1.
LOADFP_0:
  LD D,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
; This entry point is used by the routines at L34C2 and L35F9.
INCHL:
  INC HL
  RET

; Routine at 12008
;
; Used by the routine at __NEXT.
; copy number value from FPREG (FP accumulator) to HL
FPTHL:
  LD DE,FACCU
  LD B,$04
  JR CPY2HL   		; Copy B bytes from DE to HL

; Routine at 12015
;
; Used by the routine at __NEXT.
ARG2DE:
  LD DE,ARG

; Copy number value from HL to DE
VAL2DE:
  EX DE,HL
  
; This entry point is used by the routines at __LET, __SWAP, TSTOPL and _MID_S.
; Copy number value from DE to HL
  ; --- START PROC L2EF3 ---
FP2HL:
  LD A,(VALTYP)
  LD B,A
  
; This entry point is used by the routines at __RND, GET_RNDX, FPTHL and L46C0.
; Copy B bytes from DE to HL
  ; --- START PROC L2EF7 ---
CPY2HL:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DJNZ CPY2HL   		; Copy B bytes from DE to HL
  RET

; Routine at 12030
;
; Used by the routine at DECMUL.
; Similar to LDDR but moving from DE to HL, B times.
LDDR_DEHL:
  LD A,(DE)
  LD (HL),A
  DEC DE
  DEC HL
  DJNZ LDDR_DEHL
  RET

; Routine at 12037
FP_ARG2DE:
  LD HL,ARG
; This entry point is used by the routines at L46E6, OPRND and __NEXT.
FP_HL2DE:
  LD DE,VAL2DE 		; Copy number value from HL to DE
  JR FPCOPY_0

; Routine at 12045
;
; Used by the routines at L4D26 and L7684.
FP_ARG2HL:
  LD HL,ARG
  
; This entry point is used by the routines at DOFN and __NEXT.
  ; --- START PROC L2F10 ---
FP_DE2HL:
  LD DE,FP2HL   		; Copy number value from DE to HL
  
; This entry point is used by the routine at FP_ARG2DE.
FPCOPY_0:
  PUSH DE
  LD DE,FACCU
  LD A,(VALTYP)
  CP $04
  RET NC
  LD DE,FACLOW
  RET

; Routine at 12065
;
; Used by the routines at INT_RESULT_HL_2, GETWORD_HL, FCOMP_UNITY and __NEXT.
; Formerly known as "CMPNUM"
FCOMP:
  LD A,C
  OR A
  JP Z,SIGN			; test FP number sign
  LD HL,SGN_RESULT_CPL
  PUSH HL
  CALL SIGN			; test FP number sign
  LD A,C
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  CALL CMPFP
  RRA
  XOR C
  RET

; Routine at 12091
;
; Used by the routine at FCOMP.
; 
CMPFP:
  LD A,C
  CP (HL)
  RET NZ
  INC HL
  LD A,B
  CP (HL)
  RET NZ
  INC HL
  LD A,E
  CP (HL)
  RET NZ
  INC HL
  LD A,D
  SUB (HL)
  RET NZ
  POP HL
  POP HL
  RET

; Routine at 12109
;
; Used by the routine at __NEXT.
ICOMP:
  LD A,D
  XOR H
  LD A,H
  JP M,SGN_RESULT
  CP D
  JR NZ,ICOMP_0
  LD A,L
  SUB E
  RET Z
ICOMP_0:
  JP EVAL_RESULT

; Routine at 12124
;
; Used by the routines at CMPPHL, DECCOMP, L391A and __NEXT.
XDCOMP:
  LD DE,ARG
  LD A,(DE)
  OR A
  JP Z,SIGN			; test FP number sign
  LD HL,SGN_RESULT_CPL
  PUSH HL
  CALL SIGN			; test FP number sign
  LD A,(DE)
  LD C,A
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  LD B,$08
XDCOMP_0:
  LD A,(DE)
  SUB (HL)
  JR NZ,XDCOMP_1
  INC DE
  INC HL
  DJNZ XDCOMP_0
  POP BC
  RET
XDCOMP_1:
  RRA
  XOR C
  RET

; Routine at 12163
DECCOMP:
  CALL XDCOMP
  JP NZ,SGN_RESULT_CPL
  RET

; Routine at 12170
;
; Used by the routines at __EXP, EVAL, NOT, EVAL_BOOL_END, DEPINT, L577A, __CIRCLE,
; CIRCLE_SUB, L7684 and PARMADDR.
  ; --- START PROC L2F8A ---
__CINT:
  RST GETYPR 		; Get the number type (FAC)
  LD HL,(FACLOW)
  RET M
  JP Z,TM_ERR				; If string type, Err $0D - "Type mismatch"
  CALL CINT
  JP C,OV_ERR			; Err $06 -  "Overflow"
  EX DE,HL
; This entry point is used by the routines at __SGN, INT_RESULT_HL_2, __FIX, IMULT,
; INT_DIV_3, LNUM_MSG, OPRND, HEXTFP, __POS, FN_POINT, __CIRCLE and CIRCLE_SUB.
INT_RESULT_HL:
  LD (FACLOW),HL
; This entry point is used by the routine at IMOD.
SETTYPE_INT:
  LD A,$02		; Integer type
; This entry point is used by the routine at SETTYPE_SNG.
SETTYPE:
  LD (VALTYP),A
  RET

; Routine at 12194
;
; Used by the routine at L3301.
INT_RESULT_HL_2:
  LD BC,$32C5		; BCDE = -32768 (float)
  LD DE,$8076
  CALL FCOMP
  RET NZ
  LD HL,$8000		; HL = 32768
; This entry point is used by the routine at IADD.
INT_RESULT_HL_2_0:
  POP DE
  JR INT_RESULT_HL		; L2F99

  
;  Convert number to single precision
__CSNG:
  RST GETYPR 		; Get the number type (FAC)
L2FB3:
  RET PO
  JP M,INT_CSNG
  JP Z,TM_ERR				; If string type, Err $0D - "Type mismatch"
  CALL SETTYPE_SNG
  CALL L3752
  INC HL
  LD A,B
  OR A
  RRA
  LD B,A
  JP BNORM_8

  ; --- START PROC INT_CSNG ---
INT_CSNG:
  LD HL,(FACLOW)			; DECIMAL ACCUMULATOR + 2
  ; --- START PROC HL_CSNG ---
HL_CSNG:
  LD A,H
  ; --- START PROC FLGREL_0 ---
FLGREL_0:
  OR A
  PUSH AF
  CALL M,INT_DIV_6
  CALL SETTYPE_SNG
  EX DE,HL
  LD HL,$0000
  LD (FACCU),HL
  LD (FACLOW),HL			; DECIMAL ACCUMULATOR + 2
  LD A,D
  OR E
  JP Z,TESTR_0
  LD BC,$0500		; 1280 
  LD HL,FACCU+1
  PUSH HL
  LD HL,L3030		; !
L2FED:
  LD A,$FF
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  PUSH BC
L2FF6:
  LD B,H
  LD C,L
  ADD HL,DE
  INC A
  JR C,L2FF6
  LD H,B
  LD L,C
  POP BC
  POP DE
  EX DE,HL
  INC C
  DEC C
  JR NZ,L3010
  OR A
  JR Z,L3024
  PUSH AF
  LD A,40h  		; '@'
  ADD A,B
  LD (FACCU),A
  POP AF
L3010:
  INC C
  EX (SP),HL
  PUSH AF
  LD A,C
  RRA
  JR NC,L301F
  POP AF
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD (HL),A
  JR L3023

L301F:
  POP AF
  OR (HL)
  LD (HL),A
  INC HL
L3023:
  EX (SP),HL
L3024:
  LD A,D
  OR E
  JR Z,L302A
  DJNZ L2FED
L302A:
  POP HL
  POP AF
  RET P
  JP NEG

		
; Routine at 12336
L3030:			; !
  DEFB		$F0
  DEFB		$D8
  DEFW LINWRK
  ;DEFB		$18
  ;DEFB		$FC
  
  ;RET P		; $F0
  ;RET C		; $D8
  ;;JR L3030  ; $18, $FC    -   
  
  

; Routine at 12340
L3034:
  SBC A,H
  RST KEYINT 		;  Performs hardware interrupt procedures
  OR $FF
  RST KEYINT 		;  Performs hardware interrupt procedures
  RST KEYINT 		;  Performs hardware interrupt procedures
  

; This entry point is used by the routines at __EXP, TO_DOUBLE, L375F, L3878, L4D26 and OPRND_3.
; Position: $303A
__CDBL:
  RST GETYPR 		; Get the number type (FAC)
  RET NC
  JP Z,TM_ERR				; If string type, Err $0D - "Type mismatch"
  CALL M,INT_CSNG
; This entry point is used by the routines at __LOG, L324B, FMULT, DIVIDE and
; L3878.
ZERO_FACCU:
  LD HL,$0000
  LD (FACCU+4),HL
  LD (FACCU+6),HL
  LD A,H
  LD (FACCU+8),A

; This entry point is used by the routines at __EXP and DECEXP.
SETTYPE_DBL:
  LD A,$08
  JR SETTYPE_SNG_0

; Routine at 12371
SETTYPE_SNG:
  LD A,$04
; This entry point is used by the routine at L3034.
SETTYPE_SNG_0:
  JP SETTYPE

; Routine at 12376
;
; Used by the routines at __LINE, OPRND_3, USING, L61C4, CONCAT, GETSTR, FN_INSTR and _MID_S.
TSTSTR:
  RST GETYPR 		; Get the number type (FAC)
  RET Z
  JP TM_ERR				; If not string type, Err $0D - "Type mismatch"

; Data block at 12381
  ; --- START PROC CINT ---
CINT:
  LD HL,CINT_RET2
  PUSH HL
  LD HL,FACCU
  LD A,(HL)
  AND $7F			; ABS
  CP $46
  RET NC
  SUB $41
  JR NC,CINT_SUB
  OR A
  POP DE
  LD DE,$0000
  RET

CINT_SUB:
  INC A
  LD B,A
  LD DE,$0000
  LD C,D
  INC HL
CINT_SUB_0:
  LD A,C
  INC C
  RRA
  LD A,(HL)
  JR C,CINT_SUB_1
  RRA
  RRA
  RRA
  RRA
  JR CINT_SUB_2

CINT_SUB_1:
  INC HL
CINT_SUB_2:
  AND $0F
  LD (DECTMP),HL
  LD H,D
  LD L,E
  ADD HL,HL
  RET C
  ADD HL,HL
  RET C
  ADD HL,DE
  RET C
  ADD HL,HL
  RET C
  LD E,A
  LD D,$00
  ADD HL,DE
  RET C
  EX DE,HL
  LD HL,(DECTMP)
  DJNZ CINT_SUB_0
  LD HL,$8000		; 32768
  RST DCOMPR		; Compare HL with DE.
  LD A,(FACCU)
  RET C
  JR Z,CINT_RET1
  POP HL
  OR A
  RET P
  EX DE,HL
  CALL INT_DIV_6
  EX DE,HL
  OR A
  RET

CINT_RET1:
  OR A
  RET P
  POP HL
  RET


; Routine at 12474
CINT_RET2:
  SCF
  RET

; Routine at 12476
DETOKEN_ELSE:
  DEC BC
  RET

; Routine at 12478
__FIX:
  RST GETYPR 		; Get the number type (FAC)
  RET M
  CALL SIGN			; test FP number sign
  JP P,__INT
  CALL NEG
  CALL __INT
  JP INVSGN

; This entry point is used by the routines at __SIN and L391A.
__INT:
  RST GETYPR 		; Get the number type (FAC)
  RET M
  LD HL,FACCU+8
  LD C,$0E
  JR NC,__FIX_0
  JP Z,TM_ERR				; If string type, Err $0D - "Type mismatch"
  LD HL,FACCU+4
  LD C,$06			; TK_ABS ?
__FIX_0:
  LD A,(FACCU)
  OR A
  JP M,__FIX_2
  AND $7F			; ABS
  SUB $41
  JP C,ZERO_EXPONENT
  INC A
  SUB C
  RET NC
  CPL
  INC A
  LD B,A
__FIX_1:
  DEC HL
  LD A,(HL)
  AND $F0
  LD (HL),A
  DEC B
  RET Z
  XOR A
  LD (HL),A
  DJNZ __FIX_1
  RET
  
__FIX_2:
  AND $7F			; ABS
  SUB $41
  JR NC,__FIX_3
  LD HL,$FFFF
  JP INT_RESULT_HL
  
__FIX_3:
  INC A
  SUB C
  RET NC
  CPL
  INC A
  LD B,A
  LD E,$00
__FIX_4:
  DEC HL
  LD A,(HL)
  LD D,A
  AND $F0
  LD (HL),A
  CP D
  JR Z,__FIX_5
  INC E
__FIX_5:
  DEC B
  JR Z,__FIX_7
  XOR A
  LD (HL),A
  CP D
  JR Z,__FIX_6
  INC E
__FIX_6:
  DJNZ __FIX_4
__FIX_7:
  INC E
  DEC E
  RET Z
  LD A,C
  CP $06			; TK_ABS ?
  LD BC,$10C1		; BCDE = 1 (float) 
  LD DE,$0000
  JP Z,FADD
  EX DE,HL
  LD (ARG+6),HL
  LD (ARG+4),HL
  LD (ARG+2),HL
  LD H,B
  LD L,C
  LD (ARG),HL
  JP DECADD

; Routine at 12618
;
; Used by the routine at L7684.
; $314A,  Also Known as "UMULT", DE=BC*DE
MLDEBC:
  PUSH HL
  LD HL,$0000			; Clear partial product
  LD A,B				; Test multiplier
  OR C
  JR Z,MLDEBC_2			; Return zero if zero
  LD A,16				; 16 bits
MLDBLP:
  ADD HL,HL				; Shift P.P left
  JP C,BS_ERR		; "Subscript error" if overflow
  EX DE,HL
  ADD HL,HL				; Shift multiplier left
  EX DE,HL
  JR NC,NOMLAD			; Bit was zero - No add
  ADD HL,BC				; Add multiplicand
  JP C,BS_ERR		; "Subscript error" if overflow
NOMLAD:
  DEC A					; Count bits
  JR NZ,MLDBLP
MLDEBC_2:
  EX DE,HL
  POP HL
  RET

; Routine at 12647
ISUB:
  LD A,H
  RLA
  SBC A,A
  LD B,A
  CALL INT_DIV_6
  LD A,C
  SBC A,B
  JR IADD_0

; Routine at 12658
;
; Used by the routine at __NEXT.
IADD:
  LD A,H
  RLA
  SBC A,A
; This entry point is used by the routine at ISUB.
IADD_0:
  LD B,A
  PUSH HL
  LD A,D
  RLA
  SBC A,A
  ADD HL,DE
  ADC A,B
  RRCA
  XOR H
  JP P,INT_RESULT_HL_2_0
  PUSH BC
  EX DE,HL
  CALL HL_CSNG
  POP AF
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP FADD

; Routine at 12691
;
; Used by the routine at L390D.
; $3193
IMULT:
  LD A,H
  OR L
  JP Z,INT_RESULT_HL
  PUSH HL
  PUSH DE
  CALL INT_DIV_3
  PUSH BC
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$10
IMULT_0:
  ADD HL,HL
  JR C,IMULT_4
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JR NC,IMULT_1
  ADD HL,BC
  JR C,IMULT_4
IMULT_1:
  DEC A
  JR NZ,IMULT_0
  POP BC
  POP DE
; This entry point is used by the routine at DIVLP.
IMULT_RESULT:
  LD A,H
  OR A
  JP M,IMULT_3
  POP DE
  LD A,B
  JP INT_DIV_5

IMULT_3:
  XOR $80
  OR L
  JR Z,IMULT_6
  EX DE,HL
  JR IMULT_5
IMULT_4:
  POP BC
  POP HL
IMULT_5:
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP FMULT

IMULT_6:
  LD A,B
  OR A
  POP BC
  JP M,INT_RESULT_HL
  PUSH DE
  CALL HL_CSNG
  POP DE
  JP NEG

 
; Data block at 12774
  ; --- START PROC INT_DIV ---
INT_DIV:
  LD A,H
L31E7:
  OR L
  JP Z,O_ERR   		; Err $0B - "Division by zero"
  CALL INT_DIV_3
  PUSH BC
  EX DE,HL
  CALL INT_DIV_6
  LD B,H
  LD C,L

; Routine at 12789
L31F5:
  LD HL,$0000
  LD A,$11		; const
  OR A
  JR INT_DIV_2

DIVLP:
  PUSH HL
  ADD HL,BC
  JR NC,L3204+1  ; reference not aligned to instruction
L3201:
  INC SP
  INC SP
  SCF				; Set carry to Skip the next byte
L3204:
  JR NC,L31E7
INT_DIV_2:
  RL E				; Double LSB of quotient (LSW)
  RL D				; Double MSB of quotient (LSW)
  ADC HL,HL			; Double quotient (MSW)
  DEC A
  JR NZ,DIVLP
  EX DE,HL
  POP BC
  PUSH DE
  JP IMULT_RESULT

; Routine at 12821
;
; Used by the routine at IMULT.
INT_DIV_3:
  LD A,H
  XOR D
  LD B,A
  CALL INT_DIV_4
  EX DE,HL
INT_DIV_4:
  LD A,H
; This entry point is used by the routines at IMULT and IMOD.
INT_DIV_5:
  OR A
  JP P,INT_RESULT_HL
; This entry point is used by the routines at ISUB and DBL_ABS.
INT_DIV_6:
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
  JP INT_RESULT_HL

  
; Routine at 12843
;
; ABS (double precision BASIC variant)
; Used by the routine at INVSGN.
DBL_ABS:
  LD HL,(FACLOW)
  CALL INT_DIV_6
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at L46E6, OPRND, FRE_RESLT, FN_TIME and
; L7BA3.
DBL_ABS_0:
  XOR A
  JP FLGREL_0

; Routine at 12858
;
; Used by the routine at EVAL_BOOL_END.
IMOD:
  PUSH DE
  CALL INT_DIV
  XOR A
  ADD A,D
  RRA
  LD H,A
  LD A,E
  RRA
  LD L,A
  CALL SETTYPE_INT
  POP AF
  JR INT_DIV_5

; Routine at 12875  (LOADFP/FADD.. this label is not used in the core ROM)
FADD_HLPTR:
  CALL LOADFP
; This entry point is used by the routines at __FIX, IADD, FSUB, GETWORD_HL and
; __NEXT.
FADD:
  CALL DEC_HL2ARG
  CALL ZERO_FACCU
  JP DECADD

; Routine at 12887
FSUB:
  CALL NEG
  JR FADD

; Routine at 12892
;
; Used by the routines at IMULT, __CIRCLE and CIRCLE_SUB.
FMULT:
  CALL DEC_HL2ARG
  CALL ZERO_FACCU
  JP DECMUL

; Routine at 12901
;
; Used by the routine at IDIV.
DIVIDE:
  POP BC
  POP DE
; This entry point is used by the routine at __CIRCLE.
FDIV:
  LD HL,(FACLOW)
  EX DE,HL
  LD (FACLOW),HL
  PUSH BC
  LD HL,(FACCU)
  EX (SP),HL
  LD (FACCU),HL
  POP BC
  CALL DEC_HL2ARG
  CALL ZERO_FACCU
  JP DECDIV

; Routine at 12928
;
; Used by the routines at FADD_HLPTR, FMULT and DIVIDE.
DEC_HL2ARG:
  EX DE,HL
  LD (ARG+2),HL
  LD H,B
  LD L,C
  LD (ARG),HL
  LD HL,$0000
  LD (ARG+4),HL
  LD (ARG+6),HL
  RET

; Routine at 12947
;
; Used by the routine at L35F9.
DCR_A:
  DEC A
  RET

; Routine at 12949
;
; Used by the routines at L34C2 and L35F9.
DCXH:
  DEC HL
  RET

; Routine at 12951
; 
POPHLRT:
  POP HL
  RET

; Data block at 12953
  ; --- START PROC L3299 ---
; Also known as "FIN", convert text to number
DBL_ASCTFP:
  EX DE,HL
  LD BC,$00FF
  LD H,B
  LD L,B
  CALL INT_RESULT_HL
  EX DE,HL
  LD A,(HL)

; ASCII to FP number (also '&' prefixes)
H_ASCTFP:
  CP '&'
  JP Z,HEXTFP

; ASCII to FP number
_ASCTFP:
  CP '-'
  PUSH AF
  JR Z,_ASCTFP_0
  CP '+'
  JR Z,_ASCTFP_0
  DEC HL
; This entry point is used by the routine at DECIMAL.
_ASCTFP_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,_ASCTFP_DIGITS
  CP '.'
  JP Z,DECIMAL
  CP 'e'
  JR Z,EXPONENTIAL
  CP 'E'
EXPONENTIAL:
  JR NZ,_ASCTFP_4
  PUSH HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP 'l'
  JR Z,_ASCTFP_2
  CP 'L'
  JR Z,_ASCTFP_2
  CP 'q'
  JR Z,_ASCTFP_2
  CP 'Q'
_ASCTFP_2:
  POP HL
  JR Z,_ASCTFP_3
  RST GETYPR 		; Get the number type (FAC)
  JR NC,_ASCTFP_5
  XOR A
  JR _ASCTFP_6
_ASCTFP_3:
  LD A,(HL)
_ASCTFP_4:
  CP '%'
  JP Z,L3362
  CP '#'
  JP Z,L3370
  CP '!'
  JP Z,L3370_0
  CP 'd'
  JR Z,_ASCTFP_5
  CP 'D'
  JR NZ,L3301_3
_ASCTFP_5:
  OR A
_ASCTFP_6:
  CALL TO_DOUBLE
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH DE
  LD D,$00
  CALL SGNEXP		; test '+', '-'..
  LD C,D
  POP DE
L3301_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR NC,L3301_2
  LD A,E
  CP $0C
  JR NC,L3301_1
  RLCA
  RLCA
  ADD A,E
  RLCA
  ADD A,(HL)
  SUB '0'           ; convert from ASCII
  LD E,A
  JR L3301_0
L3301_1:
  LD E,$80
  JR L3301_0
L3301_2:
  INC C
  JR NZ,L3301_3
  XOR A
  SUB E
  LD E,A
; This entry point is used by the routines at _ASCTFP, DECIMAL, L3362 and L3370.
L3301_3:
  RST GETYPR 		; Get the number type (FAC)
  JP M,L3301_4
  LD A,(FACCU)
  OR A
  JR Z,L3301_4
  LD A,D
  SUB B
  ADD A,E
  ADD A,$40
  LD (FACCU),A
  OR A
  CALL M,L334C
L3301_4:
  POP AF
  PUSH HL
  CALL Z,INVSGN
  RST GETYPR 		; Get the number type (FAC)
  JR NC,L3301_5
  POP HL
  RET PE
  PUSH HL
  LD HL,POPHLRT		; (POP HL / RET)
  PUSH HL
  CALL INT_RESULT_HL_2
  RET

L3301_5:
  CALL DECROU
  POP HL
  RET

; Routine at 13132
;
; Used by the routine at L3301.
L334C:
  JP OV_ERR			; Err $06 -  "Overflow"

; Routine at 13135
;
; Used by the routine at _ASCTFP.
DECIMAL:
  RST GETYPR 		; Get the number type (FAC)
  INC C
  JR NZ,L3301_3
  JR NC,DECIMAL_0
  CALL TO_DOUBLE
  LD A,(FACCU)
  OR A
  JR NZ,DECIMAL_0
  LD D,A
DECIMAL_0:
  JP _ASCTFP_0

; Routine at 13154
;
; Used by the routine at _ASCTFP.
L3362:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH HL
  LD HL,POPHLRT		; (POP HL / RET)
  PUSH HL
  LD HL,__CINT
  PUSH HL
  PUSH AF
  JR L3301_3

; Routine at 13168
;
; Used by the routine at _ASCTFP.
L3370:
  OR A
; This entry point is used by the routine at _ASCTFP.
L3370_0:
  CALL TO_DOUBLE
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR L3301_3

; Routine at 13175
;
; Used by the routines at _ASCTFP, DECIMAL and L3370.
TO_DOUBLE:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL Z,__CSNG
  POP AF
  CALL NZ,__CDBL
  POP BC
  POP DE
  POP HL
  RET

; Data block at 13190
_ASCTFP_DIGITS:
  SUB '0'           ; convert from ASCII
  JP NZ,L3393
  OR C
  JP Z,L3393
  AND D
  JP Z,_ASCTFP_0
L3393:
  INC D
  LD A,D
  CP $07
  JR NZ,L339D
  OR A
  CALL TO_DOUBLE

L339D:
  PUSH DE
  LD A,B
  ADD A,C
  INC A
  LD B,A
  PUSH BC
  PUSH HL
  LD A,(HL)
  SUB '0'           ; convert from ASCII
  PUSH AF
  RST GETYPR 		; Get the number type (FAC)
  JP P,L33D1
  LD HL,(FACLOW)
  LD DE,$0CCD		; const
  RST DCOMPR		; Compare HL with DE.

L33B3:
  JR NC,L33CE
  LD D,H
  LD E,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  ADD HL,HL
  POP AF
  LD C,A
  ADD HL,BC
  LD A,H
  OR A
  JP M,L33CC
  LD (FACLOW),HL
  ; --- START PROC L33C6 ---
L33C6:
  POP HL
  POP BC
  POP DE
  JP _ASCTFP_0

  ; --- START PROC L33CC ---
L33CC:
  LD A,C
  PUSH AF
L33CE:
  CALL INT_CSNG
L33D1:
  POP AF
  POP HL
  POP BC
  POP DE
  JR NZ,L33E3
  LD A,(FACCU)
  OR A
  LD A,$00
  JR NZ,L33E3
  LD D,A
  JP _ASCTFP_0

L33E3:
  PUSH DE
  PUSH BC
  PUSH HL
  PUSH AF
  LD HL,FACCU
  LD (HL),$01
  LD A,D
  CP $10
  JR C,L33F4
  POP AF
  JR L33C6

L33F4:
  INC A
  OR A
  RRA
  LD B,$00
  LD C,A
  ADD HL,BC
  POP AF
  LD C,A
  LD A,D
  RRA
  LD A,C
  JR NC,L3406
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
L3406:
  OR (HL)
  LD (HL),A
  JR L33C6

  ; --- START PROC LNUM_MSG ---

; Routine at 13322
;
; Used by the routine at LINE2PTR.
; $340A:
LNUM_MSG:
  PUSH HL
  LD HL,IN_MSG		; " in "
  CALL PRS
  POP HL

; This entry point is used by the routines at __LLIST, LINE2PTR and L7D29.
_PRNUM:
  LD BC,PRNUMS
  PUSH BC
  CALL INT_RESULT_HL
  XOR A
  LD (TEMP3),A
  LD HL,FBUFFR+1		; Buffer for fout + 1
  LD (HL),' '
  OR (HL)
  JR SPCFST

  
; --- START PROC L3425 ---
; Convert number/expression to string (format not specified)
FOUT:
  XOR A
; --- START PROC L3426 ---
; Convert number/expression to string ("PRINT USING" format specified in 'A' register)
PUFOUT:
  CALL L375F
  AND $08	; bit 3 - Sign (+ or -) preceeds number
  JR Z,L342F
  LD (HL),'+'
L342F:
  EX DE,HL
  CALL _TSTSGN
L3433:
  EX DE,HL
  JP P,SPCFST
  LD (HL),'-'
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H
; --- START PROC SPCFST ---
SPCFST:
  INC HL
  LD (HL),'0'
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,L34F7
  JP Z,L34EF
  CP $04
  JP NC,L34A1
  LD BC,$0000
  CALL L36DB
; --- START PROC L345D ---
L345D:
  LD HL,FBUFFR+1		; Buffer for fout + 1
  LD B,(HL)
  LD C,' '
  LD A,(TEMP3)
  LD E,A
  AND $20			; bit 5 - Asterisks fill  
  JR Z,L3477
  LD A,B
  CP C
  LD C,'*'
  JR NZ,L3477
  LD A,E
  AND $04			; bit 2 - Sign (+ or -) follows ASCII number  
  JR NZ,L3477
  LD B,C
L3477:
  LD (HL),C
  RST CHRGTB		; Gets next character (or token) from BASIC text.

L3479:
  JR Z,L348F
  CP 'E'
  JR Z,L348F
  CP 'D'
  JR Z,L348F
  CP '0'
  JR Z,L3477
  CP ','
  JR Z,L3477
  CP '.'
  JR NZ,L3492
L348F:
  DEC HL
  LD (HL),'0'
L3492:
  LD A,E
  AND $10		; bit 4 - Print leading '$'  
  JR Z,L349A
  DEC HL
  LD (HL),'$'
L349A:
  LD A,E
  AND $04		; bit 2 - Sign (+ or -) follows ASCII number  
  RET NZ
  DEC HL
  LD (HL),B
  RET

; --- START PROC L34A1 ---
L34A1:
  PUSH HL
  CALL L3752
  LD D,B
  INC D
  LD BC,$0300			; const
  LD A,(FACCU)
  SUB $3f				; '?'
  JR C,L34B9
  INC D
  CP D
  JR NC,L34B9
  INC A
  LD B,A
  LD A,$02
L34B9:
  SUB $02
  POP HL
  PUSH AF
  CALL L368E
  LD (HL),'0'

; Routine at 13506
L34C2:
  CALL Z,INCHL
  CALL L36B3
SUPTLZ:
  DEC HL              ; Move back through buffer
  LD A,(HL)           ; Get character
  CP '0'              ; "0" character?
  JR Z,SUPTLZ         ; Yes - Look back for more
  CP '.'              ; A decimal point?
  CALL NZ,INCHL       ; Move back over digit
  POP AF              ; Get "E" flag
  JR Z,NOENED         ; No "E" needed - End buffer
  
; This entry point is used by the routine at L35F9.
DOEBIT:
  LD (HL),'E'         ; Put "E" in buffer
  INC HL              ; And move on
  LD (HL),'+'         ; Put '+' in buffer
  JP P,OUTEXP         ; Positive - Output exponent
  LD (HL),'-'         ; Put "-" in buffer
  CPL                 ; Negate exponent
  INC A
OUTEXP:
  LD B,'0'-1          ; ASCII "0" - 1
EXPTEN:
  INC B               ; Count subtractions
  SUB 10              ; Tens digit
  JR NC,EXPTEN        ; More to do
  ADD A,'0'+10        ; Restore and make ASCII
  INC HL              ; Move on
  LD (HL),B           ; Save MSB of exponent
  INC HL
  LD (HL),A           ; Save LSB of exponent
L34EF:
  INC HL
NOENED:
  LD (HL),$00
  EX DE,HL
  LD HL,FBUFFR+1		; Buffer for fout + 1
  RET

L34F7:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,L3566
  RRA
  JP C,L35EF
  LD BC,$0603		; const
  CALL L367A_1
  POP DE
  LD A,D
  SUB $05		; TK_INT ?
  CALL P,L3666
  CALL L36DB
L3513:
  LD A,E
  OR A
  CALL Z,DCXH	; DEC HL, RET
  DEC A
  CALL P,L3666
; This entry point is used by the routines at L35EC and L35F9.
L351C:
  PUSH HL
  CALL L345D
  POP HL
  JR Z,L34C2_6
  LD (HL),B
  INC HL
L34C2_6:
  LD (HL),$00
  LD HL,FBUFFR		; Buffer for fout
L34C2_7:
  INC HL
; This entry point is used by the routine at L3557.
L34C2_8:
  LD A,(NXTOPR)		; Next operator in EVAL
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP ' '
  JR Z,L34C2_7
  CP '*'
  JR Z,L34C2_7
  DEC HL
  PUSH HL
L353C:
  PUSH AF
  LD BC,L353C
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '-'
  RET Z
  CP '+'
  RET Z
  CP '$'
  RET Z
  POP BC
  CP '0'
  JR NZ,L355F
  INC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR NC,L355F
  DEC HL
  JR L3557_0

; Routine at 13655
L3557:
  DEC HL
  LD (HL),A
; This entry point is used by the routine at L34C2.
L3557_0:
  POP AF
  JR Z,L3557
  POP BC
  JR L34C2_8

; Routine at 13663
;
; Used by the routine at L34C2.
L355F:
  POP AF
  JR Z,L355F
  POP HL
  LD (HL),'%'	; $25
  RET


L3566:
  PUSH HL
  RRA
  JP C,L35F5
  CALL L3752
  LD D,B
  LD A,(FACCU)
  SUB $4F
  JR C,L3581
  POP HL
  POP BC
  CALL FOUT
  LD HL,FBUFFR		; Buffer for fout
  LD (HL),'%'
  RET

L3581:
  CALL SIGN			; test FP number sign
  CALL NZ,L37A2
  POP HL
  POP BC
  JP M,L35A6
  PUSH BC
  LD E,A
  LD A,B
  SUB D
  SUB E
  CALL P,L3666
  CALL L367A
  CALL L36B3
  OR E
  CALL NZ,L3674
  OR E
  CALL NZ,L36A0
  POP DE
  JP L3513

L35A6:
  LD E,A
  LD A,C
  OR A
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,E
  JP M,L35B1
  XOR A
L35B1:
  PUSH BC
  PUSH AF
  CALL M,L377B
  POP BC
  LD A,E
  SUB B
  POP BC
  LD E,A
  ADD A,D
  LD A,B
  JP M,L35CB
  SUB D
  SUB E
  CALL P,L3666
  PUSH BC
  CALL L367A
  JR L35DC

L35CB:
  CALL L3666
  LD A,C
  CALL L36A3
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL L3666
  PUSH BC
  LD B,A
  LD C,A
L35DC:
  CALL L36B3
  POP BC
  OR C
  JR NZ,L35E6
  LD HL,(NXTOPR)		; Next operator in EVAL
L35E6:
  ADD A,E
  DEC A
  CALL P,L3666
  LD D,B
  JP L351C

L35EF:
  PUSH HL
  PUSH DE
  CALL INT_CSNG
  POP DE
L35F5:
  CALL L3752
  LD E,B
  
; Routine at 13817
L35F9:
  CALL SIGN			; test FP number sign
  PUSH AF
  CALL NZ,L37A2
  POP AF
  POP HL
  POP BC
  PUSH AF
  LD A,C
  OR A
  PUSH AF
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,B
  LD C,A
  LD A,D
  AND $04
  CP $01
  SBC A,A
  LD D,A
  ADD A,C
  LD C,A
  SUB E
  PUSH AF
  JP P,L35F9_0
  CALL L377B
  JR NZ,L35F9_0
  PUSH HL
  CALL DV16FACCU
  LD HL,FACCU
  INC (HL)
  POP HL
L35F9_0:
  POP AF
  PUSH BC
  PUSH AF
  JP M,L35F9_1
  XOR A
L35F9_1:
  CPL
  INC A
  ADD A,B
  INC A
  ADD A,D
  LD B,A
  LD C,$00
  CALL Z,L368E
  CALL L36B3
  POP AF
  CALL P,L366E
  CALL L36A0
  POP BC
  POP AF
  JR NZ,L35F9_2
  CALL DCXH	; DEC HL, RET
  LD A,(HL)
  CP '.'			; $2E
  CALL NZ,INCHL
  LD (NXTOPR),HL		; Next operator in EVAL
L35F9_2:
  POP AF
  LD A,(FACCU)
  JR Z,L35F9_3
  ADD A,E
  SUB B
  SUB D
L35F9_3:
  PUSH BC
  CALL DOEBIT
  EX DE,HL
  POP DE
  JP L351C

; Routine at 13926
;
; Used by the routine at L34C2.
L3666:
  OR A
L3666_0:
  RET Z
  DEC A
  LD (HL),'0'
  INC HL
  JR L3666_0

; Data block at 13934
  ; --- START PROC L366E ---
L366E:
  JR NZ,L3674
  ; --- START PROC L3670 ---
L3670:
  RET Z
  CALL L36A0
  ; --- START PROC L3674 ---
L3674:
  LD (HL),'0'

; Routine at 13942
L3676:
  INC HL
  DEC A
  JR L3670

; Routine at 13946
L367A:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
L367A_0:
  SUB $03
  JR NC,L367A_0
  ADD A,$05
  LD C,A
; This entry point is used by the routine at L34C2.
L367A_1:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET

; Routine at 13966
;
; Used by the routine at L35F9.
L368E:
  DEC B
  JP P,L36A0_0
  LD (NXTOPR),HL		; Next operator in EVAL
  LD (HL),'.'
L368E_0:
  INC HL
  LD (HL),'0'
  INC B
  LD C,B
  JR NZ,L368E_0
  INC HL
  RET

; Routine at 13984
;
; Used by the routines at L35F9 and L36DB.
L36A0:
  DEC B
; This entry point is used by the routine at L368E.
L36A0_0:
  JR NZ,L36A0_1
L36A3:
  LD (HL),'.'			; $2E
  LD (NXTOPR),HL		; Next operator in EVAL
  INC HL
  LD C,B
  RET
  
L36A0_1:
  DEC C
  RET NZ
  LD (HL),','
  INC HL
  LD C,$03
  RET

; Data block at 14003
  ; --- START PROC L36B3 ---
L36B3:
  PUSH DE
  PUSH HL
  PUSH BC
  CALL L3752
  LD A,B
  POP BC
  POP HL
  LD DE,FACCU+1
  SCF
L36C0:
  PUSH AF
  CALL L36A0
  LD A,(DE)
  JR NC,L36CD
  RRA
  RRA
  RRA
  RRA
  JR L36CE

L36CD:
  INC DE
L36CE:
  AND $0F
  ADD A,'0'
  LD (HL),A
  INC HL
  POP AF
  DEC A
  CCF
  JR NZ,L36C0
  JR L370A


; Routine at 14043
;
; Used by the routine at L34C2.
L36DB:
  PUSH DE
  LD DE,POWERS_TAB
  LD A,$05
L36DB_0:
  CALL L36A0
  PUSH BC
  PUSH AF
  PUSH HL
  EX DE,HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  INC HL
  EX (SP),HL
  EX DE,HL
  LD HL,(FACLOW)
  LD B,'0'-1  ; $2F, '/'
L36DB_1:
  INC B
  ; HL=HL-DE
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  ;
  JR NC,L36DB_1
  ADD HL,DE
  LD (FACLOW),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JR NZ,L36DB_0
L370A:
  CALL L36A0
  LD (HL),A
  POP DE
  RET

; Routine at 14096
POWERS_TAB:
	DEFW 10000
	DEFW 1000
	DEFW 100
	DEFW 10
	DEFW 1

  
; This entry point is used by __BIN$.
BIN_STR:
  DEFB $06	; "LD B,1"   	; BASE: 2^1 -> 2
L371B:
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
L371C:
  DEFB $18	; "JR 06 -> L3722_0
L371D:
  DEFB $06	; "LD B,6" /INC BC 	; BASE: 2^6 -> 64 (this is incidental !!)

; This entry point is used by the routines at L5361 and __OCT$.
OCT_STR:
  LD B,$03	; BASE: 2^3 -> 8
  JR L3722_0

; Routine at 14114
;
; Used by the routines at L5361 and __HEX$.
HEX_STR:
  LD B,$04	; BASE: 2^4 -> 16

; This entry point is used by the routine at POWERS_TAB.
L3722_0:
  PUSH BC
  CALL GETWORD_HL
  LD DE,FBUFFR+17
  XOR A			; string termination after 16 characters
  LD (DE),A
  POP BC
  LD C,A
L3722_1:
  PUSH BC
  DEC DE
L3722_2:
  AND A
  LD A,H
  RRA
  LD H,A
  LD A,L
  RRA
  LD L,A
  LD A,C
; This entry point is used by the routine at POWERS_TAB.
L3722_3:
  RRA
  LD C,A
  DJNZ L3722_2
  POP BC
  PUSH BC
L3722_4:
  RLCA
  DJNZ L3722_4
  ADD A,'0'
  CP '9'+1
  JR C,L3722_5
  ADD A,$07	; A..F
L3722_5:
  LD (DE),A
  POP BC
  LD A,L
  OR H
  JR NZ,L3722_1
  EX DE,HL
  RET

; Routine at 14162
;
; Used by the routines at L377B, L37A2 and L37B4.
L3752:
  RST GETYPR 		; Get the number type (FAC)
  LD HL,FACCU+7
  LD B,$0E
  RET NC
  LD HL,FACLOW+1
  LD B,$06
  RET

; Routine at 14175
L375F:
  LD (TEMP3),A
  PUSH AF
  PUSH BC
  PUSH DE
  CALL __CDBL
  LD HL,FP_ZERO
  LD A,(FACCU)
  AND A
  CALL Z,HL2FACCU
  POP DE
  POP BC
  POP AF
  LD HL,FBUFFR+1		; Buffer for fout + 1
  LD (HL),' '
  RET

; Routine at 14203
;
; Used by the routine at L35F9.
L377B:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CPL
  INC A
  LD E,A
  LD A,$01
  JP Z,L377B_1
  CALL L3752
  PUSH HL
L377B_0:
  CALL DV16FACCU
  DEC E
  JR NZ,L377B_0
  POP HL
  INC HL
  LD A,B
  RRCA
  LD B,A
  CALL BNORM_8
  CALL L37B4
L377B_1:
  POP BC
  ADD A,B
  POP BC
  POP DE
  POP HL
  RET

; Routine at 14242
;
; Used by the routine at L35F9.
L37A2:
  PUSH BC
  PUSH HL
  CALL L3752
  LD A,(FACCU)
  SUB $40
  SUB B
  LD (FACCU),A
  POP HL
  POP BC
  OR A
  RET

; Routine at 14260
;
; Used by the routine at L377B.
L37B4:
  PUSH BC
  CALL L3752
L37B4_0:
  LD A,(HL)
  AND $0F
  JR NZ,L37B4_1
  DEC B
  LD A,(HL)
  OR A
  JR NZ,L37B4_1
  DEC HL
  DJNZ L37B4_0
L37B4_1:
  LD A,B
  POP BC
  RET

; Single precision exponential function
FEXP:
  CALL DEC_HL2ARG
  CALL ZERO_FACCU
  CALL STAKARG
  CALL XSTKFP
  CALL USTAKARG

; Double precision exponential function
DECEXP:
  LD A,(ARG)
  OR A
  JP Z,INTEXP_0		; SIGN - test FP number sign
  LD H,A
  LD A,(FACCU)
  OR A
  JP Z,INTEXP_2
  CALL STAKFP
  CALL L391A
  JR C,DECEXP_1
  EX DE,HL
  LD (TEMP8),HL
  CALL SETTYPE_DBL
  CALL USTAKARG
  CALL L391A
  CALL SETTYPE_DBL
  LD HL,(TEMP8)
  JP NC,L385A
  LD A,(ARG)
  PUSH AF
  PUSH HL
  CALL ARG2FACCU
  LD HL,FBUFFR		; Buffer for fout
  CALL DBL_FACCU2HL
  LD HL,FP_UNITY
  CALL HL2FACCU
  POP HL
  LD A,H
  OR A
  PUSH AF
  JP P,DECEXP_0
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
DECEXP_0:
  PUSH HL
  JP L3878_0

DECEXP_1:
  CALL SETTYPE_DBL
  CALL ARG2FACCU
  CALL XSTKFP
  CALL __LOG
  CALL USTAKARG
  CALL DECMUL
  JP __EXP

  
; Integer exponential function
; FACCU=DE^HL
INTEXP:
  LD A,H
  OR L
  JR NZ,INTEXP_1
		
INTEXP_0:
  LD HL,$0001
  JP INT_RESULT_ONE

INTEXP_1:
  LD A,D
  OR E
  JR NZ,L385A
INTEXP_2:
  LD A,H
  RLA
  JR NC,INT_RESULT_ZERO
  JP O_ERR			; Err $0B - "Division by zero"

INT_RESULT_ZERO:
  LD HL,$0000
INT_RESULT_ONE:
  JP INT_RESULT_HL

L385A:
  LD (TEMP8),HL
  PUSH DE
  LD A,H
  OR A
  PUSH AF
  CALL M,INT_DIV_6
  LD B,H
  LD C,L
  LD HL,$0001
L3869:
  OR A
  LD A,B
  RRA
  LD B,A
  LD A,C
  RRA
  LD C,A
  JR NC,L3877
  CALL L390D
  JR NZ,L38C3
L3877:
  LD A,B
L3878:
  OR C
  JR Z,L3878_2
  PUSH HL
  LD H,D
  LD L,E
  CALL L390D
  EX DE,HL
  POP HL
  JR Z,L3869
  PUSH BC
  PUSH HL
  LD HL,FBUFFR		; Buffer for fout
  CALL DBL_FACCU2HL
  POP HL
  CALL HL_CSNG
  CALL ZERO_FACCU
; This entry point is used by the routine at DECEXP.
L3878_0:
  POP BC
  LD A,B
  OR A
  RRA
  LD B,A
  LD A,C
  RRA
  LD C,A
  JR NC,L3878_1
  PUSH BC
  LD HL,FBUFFR		; Buffer for fout
  CALL MULPHL
  POP BC
L3878_1:
  LD A,B
  OR C
  JR Z,L3878_2
  PUSH BC
  CALL STAKFP
  LD HL,FBUFFR		; Buffer for fout
  PUSH HL
  CALL HL2FACCU
  POP HL
  PUSH HL
  CALL MULPHL
  POP HL
  CALL DBL_FACCU2HL
  CALL USTAKFP
  JR L3878_0
  
L38C3:
  PUSH BC
  PUSH DE
  CALL __CDBL
  CALL FACCU2ARG
  POP HL
  CALL HL_CSNG
  CALL ZERO_FACCU
  LD HL,FBUFFR		; Buffer for fout
  CALL DBL_FACCU2HL
  CALL ARG2FACCU
  POP BC
  JR L3878_1
  
L3878_2:
  POP AF
  POP BC
  RET P
  LD A,(VALTYP)
  CP $02		; Integer ?
  JR NZ,L3878_3
  PUSH BC
  CALL HL_CSNG
  CALL ZERO_FACCU
  POP BC
L3878_3:
  LD A,(FACCU)
  OR A
  JR NZ,L3878_4
  LD HL,(TEMP8)
  OR H
  RET P
  LD A,L
  RRCA
  AND B
  JP OV_ERR			; Err $06 -  "Overflow"
  
L3878_4:
  CALL FACCU2ARG
  LD HL,FP_UNITY
  CALL HL2FACCU
  JP DECDIV

  
; Routine at 14605
;
; Used by the routine at L3878.
L390D:
  PUSH BC
  PUSH DE
  CALL IMULT
  LD A,(VALTYP)
  CP $02		; Integer ?
  POP DE
  POP BC
  RET

; Routine at 14618
;
; Used by the routine at DECEXP.
L391A:
  CALL ARG2FACCU
  CALL STAKARG
  CALL __INT
  CALL USTAKARG
  CALL XDCOMP
  SCF
  RET NZ
  JP CINT

; Jump table for statements and functions
; $392E
FNCTAB:
  DEFW __END
  DEFW __FOR
  DEFW __NEXT
  DEFW __DATA
  DEFW __INPUT
  DEFW __DIM
  DEFW __READ
  DEFW __LET
  DEFW __GOTO
  DEFW __RUN
  DEFW __IF
  DEFW __RESTORE
  DEFW __GOSUB
  DEFW __RETURN
  DEFW __REM
  DEFW __STOP
  DEFW __PRINT
  DEFW __CLEAR
  DEFW __LIST
  DEFW __NEW
  DEFW __ON
  DEFW __WAIT
  DEFW __DEF
  DEFW __POKE
  DEFW __CONT
  DEFW __CSAVE
  DEFW __CLOAD
  DEFW __OUT
  DEFW __LPRINT
  DEFW __LLIST
  DEFW __CLS
  DEFW __WIDTH
  DEFW __REM		; ELSE
  DEFW __TRON
  DEFW __TROFF
  DEFW __SWAP
  DEFW __ERASE
  DEFW __ERROR
  DEFW __RESUME
  DEFW __DELETE
  DEFW __AUTO
  DEFW __RENUM
  DEFW __DEFSTR
  DEFW __DEFINT
  DEFW __DEFSNG
  DEFW __DEFDBL
  DEFW __LINE
  DEFW __OPEN
  DEFW __FIELD
  DEFW __GET
  DEFW __PUT
  DEFW __CLOSE
  DEFW __LOAD
  DEFW __MERGE
  DEFW __FILES
  DEFW __LSET
  DEFW __RSET
  DEFW __SAVE
  DEFW __LFILES
  DEFW __CIRCLE
  DEFW __COLOR
  DEFW __DRAW
  DEFW __PAINT
  DEFW BEEP
  DEFW __PLAY
  DEFW __PSET
  DEFW __PRESET
  DEFW __SOUND
  DEFW __SCREEN
  DEFW __VPOKE
  DEFW __SPRITE
  DEFW __VDP
  DEFW __BASE
  DEFW __CALL
  DEFW __TIME
  DEFW __KEY
  DEFW __MAX
  DEFW __MOTOR
  DEFW __BLOAD
  DEFW __BSAVE
  DEFW __DSKO_S
  DEFW __SET
  DEFW __NAME
  DEFW __KILL
  DEFW __IPL
  DEFW __COPY
  DEFW __CMD
  DEFW __LOCATE
  
FNCTAB_FN:
  DEFW __LEFT_S
  DEFW __RIGHT_S
  DEFW __MID_S
  DEFW __SGN
  DEFW __INT
  DEFW __ABS
  DEFW __SQR
  DEFW __RND
  DEFW __SIN
  DEFW __LOG
  DEFW __EXP
  DEFW __COS
  DEFW __TAN
  DEFW __ATN
  DEFW __FRE
  DEFW __INP
  DEFW __POS
  DEFW __LEN
  DEFW __STR_S
  DEFW __VAL
  DEFW __ASC
  DEFW __CHR_S
  DEFW __PEEK

  DEFW __VPEEK
  DEFW __SPACE_S
  DEFW __OCT_S
  DEFW __HEX_S
  DEFW __LPOS
  DEFW __BIN_S
  DEFW __CINT
  DEFW __CSNG
  DEFW __CDBL
  DEFW __FIX
  DEFW __STICK
  DEFW __STRIG
  DEFW __PDL
  DEFW __PAD
  DEFW __DSKF
  DEFW __FPOS
  DEFW __CVI
  DEFW __CVS
  DEFW __CVD
  DEFW __EOF
  DEFW __LOC
  DEFW __LOF
  DEFW __MKI_S
  DEFW __MKS_S
  DEFW __MKD_S

FNCTAB_END:

; Table position: $3A3E
WORD_PTR:
  DEFW WORDS_A
  DEFW WORDS_B
  DEFW WORDS_C
  DEFW WORDS_D
  DEFW WORDS_E
  DEFW WORDS_F
  DEFW WORDS_G
  DEFW WORDS_H
  DEFW WORDS_I
  DEFW WORDS_J
  DEFW WORDS_K
  DEFW WORDS_L
  DEFW WORDS_M
  DEFW WORDS_N
  DEFW WORDS_O
  DEFW WORDS_P
  DEFW WORDS_Q
  DEFW WORDS_R
  DEFW WORDS_S
  DEFW WORDS_T
  DEFW WORDS_U
  DEFW WORDS_V
  DEFW WORDS_W
  DEFW WORDS_X
  DEFW WORDS_Y
  DEFW WORDS_Z
  

; BASIC keyword and TOKEN codes list
WORDS:

WORDS_A:
  DEFM "UT"
  DEFB 'O'+$80
  DEFB TK_AUTO

  DEFM "N"
  DEFB 'D'+$80
  DEFB TK_AND

  DEFM "B"
  DEFB 'S'+$80
  DEFB TK_ABS

  DEFM "T"
  DEFB 'N'+$80
  DEFB TK_ATN

  DEFM "S"
  DEFB 'C'+$80
  DEFB TK_ASC

  DEFM "TTR"
  DEFB '$'+$80
  DEFB TK_ATTR

  DEFB $00


WORDS_B:

  DEFM "AS"
  DEFB 'E'+$80
  DEFB TK_BASE

  DEFM "SAV"
  DEFB 'E'+$80
  DEFB TK_BSAVE

  DEFM "LOA"
  DEFB 'D'+$80
  DEFB TK_BLOAD

  DEFM "EE"
  DEFB 'P'+$80
  DEFB TK_BEEP

  DEFM "IN"
  DEFB '$'+$80
  DEFB TK_BIN

  DEFB $00


WORDS_C:

  DEFM "AL"
  DEFB 'L'+$80
  DEFB TK_CALL

  DEFM "LOS"
  DEFB 'E'+$80
  DEFB TK_CLOSE

  DEFM "OP"
  DEFB 'Y'+$80
  DEFB TK_COPY

  DEFM "ON"
  DEFB 'T'+$80
  DEFB TK_CONT

  DEFM "LEA"
  DEFB 'R'+$80
  DEFB TK_CLEAR

  DEFM "LOA"
  DEFB 'D'+$80
  DEFB TK_CLOAD

  DEFM "SAV"
  DEFB 'E'+$80
  DEFB TK_CSAVE

  DEFM "SRLI"
  DEFB 'N'+$80
  DEFB TK_CSRLIN

  DEFM "IN"
  DEFB 'T'+$80
  DEFB TK_CINT

  DEFM "SN"
  DEFB 'G'+$80
  DEFB TK_CSGN

  DEFM "DB"
  DEFB 'L'+$80
  DEFB TK_CDBL

  DEFM "V"
  DEFB 'I'+$80
  DEFB TK_CVI

  DEFM "V"
  DEFB 'S'+$80
  DEFB TK_CVS

  DEFM "V"
  DEFB 'D'+$80
  DEFB TK_CVD

  DEFM "O"
  DEFB 'S'+$80
  DEFB TK_COS

  DEFM "HR"
  DEFB '$'+$80
  DEFB TK_CHR_S

  DEFM "IRCL"
  DEFB 'E'+$80
  DEFB TK_CIRCLE

  DEFM "OLO"
  DEFB 'R'+$80
  DEFB TK_COLOR

  DEFM "L"
  DEFB 'S'+$80
  DEFB TK_CLS

  DEFM "M"
  DEFB 'D'+$80
  DEFB TK_CMD

  DEFB $00


WORDS_D:

  DEFM "ELET"
  DEFB 'E'+$80
  DEFB TK_DELETE

  DEFM "AT"
  DEFB 'A'+$80
  DEFB $84

  DEFM "I"
  DEFB 'M'+$80
  DEFB TK_DIM

  DEFM "EFST"
  DEFB 'R'+$80
  DEFB TK_DEFSTR

  DEFM "EFIN"
  DEFB 'T'+$80
  DEFB TK_DEFINT

  DEFM "EFSN"
  DEFB 'G'+$80
  DEFB TK_DEFSGN

  DEFM "EFDB"
  DEFB 'L'+$80
  DEFB TK_DEFDBL

  DEFM "SKO"
  DEFB '$'+$80
  DEFB TK_DSKO_S

  DEFM "E"
  DEFB 'F'+$80
  DEFB TK_DEF

  DEFM "SKI"
  DEFB '$'+$80
  DEFB TK_DSKI

  DEFM "SK"
  DEFB 'F'+$80
  DEFB TK_DSKF

  DEFM "RA"
  DEFB 'W'+$80
  DEFB TK_DRAW

  DEFB $00


WORDS_E:

  DEFM "LS"
  DEFB 'E'+$80
  DEFB TK_ELSE

  DEFM "N"
  DEFB 'D'+$80
  DEFB $81

  DEFM "RAS"
  DEFB 'E'+$80
  DEFB TK_ERASE

  DEFM "RRO"
  DEFB 'R'+$80
  DEFB TK_ERROR

  DEFM "R"
  DEFB 'L'+$80
  DEFB TK_ERL

  DEFM "R"
  DEFB 'R'+$80
  DEFB TK_ERR

  DEFM "X"
  DEFB 'P'+$80
  DEFB TK_EXP

  DEFM "O"
  DEFB 'F'+$80
  DEFB TK_EOF

  DEFM "Q"
  DEFB 'V'+$80
  DEFB TK_EQV

  DEFB $00


WORDS_F:

  DEFM "O"
  DEFB 'R'+$80
  DEFB TK_FOR

  DEFM "IEL"
  DEFB 'D'+$80
  DEFB TK_FIELD

  DEFM "ILE"
  DEFB 'S'+$80
  DEFB TK_FILES

  DEFB 'N'+$80
  DEFB TK_FN

  DEFM "R"
  DEFB 'E'+$80
  DEFB TK_FRE

  DEFM "I"
  DEFB 'X'+$80
  DEFB TK_FIX

  DEFM "PO"
  DEFB 'S'+$80
  DEFB TK_FPOS

  DEFB $00


WORDS_G:

  DEFM "OT"
  DEFB 'O'+$80
  DEFB TK_GOTO

  DEFM "O T"
  DEFB 'O'+$80
  DEFB TK_GOTO

  DEFM "OSU"
  DEFB 'B'+$80
  DEFB TK_GOSUB

  DEFM "E"
  DEFB 'T'+$80
  DEFB TK_GET

  DEFB $00


WORDS_H:

  DEFM "EX"
  DEFB '$'+$80
  DEFB TK_HEX_S

  DEFB $00


WORDS_I:

  DEFM "NPU"
  DEFB 'T'+$80
  DEFB TK_INPUT

  DEFB 'F'+$80
  DEFB TK_IF

  DEFM "NST"
  DEFB 'R'+$80
  DEFB TK_INSTR

  DEFM "N"
  DEFB 'T'+$80
  DEFB TK_INT

  DEFM "N"
  DEFB 'P'+$80
  DEFB TK_INP

  DEFM "M"
  DEFB 'P'+$80
  DEFB TK_IMP

  DEFM "NKEY"
  DEFB '$'+$80
  DEFB TK_INKEY_S

  DEFM "P"
  DEFB 'L'+$80
  DEFB TK_IPL

  DEFB $00


WORDS_J:

  DEFB $00


WORDS_K:

  DEFM "IL"
  DEFB 'L'+$80
  DEFB TK_KILL

  DEFM "E"
  DEFB 'Y'+$80
  DEFB TK_KEY

  DEFB $00


WORDS_L:

  DEFM "PRIN"
  DEFB 'T'+$80
  DEFB TK_LPRINT

  DEFM "LIS"
  DEFB 'T'+$80
  DEFB TK_LLIST

  DEFM "PO"
  DEFB 'S'+$80
  DEFB TK_LPOS

  DEFM "E"
  DEFB 'T'+$80
  DEFB TK_LET

  DEFM "OCAT"
  DEFB 'E'+$80
  DEFB TK_LOCATE

  DEFM "IN"
  DEFB 'E'+$80
  DEFB TK_LINE

  DEFM "OA"
  DEFB 'D'+$80
  DEFB TK_LOAD

  DEFM "SE"
  DEFB 'T'+$80
  DEFB TK_LSET

  DEFM "IS"
  DEFB 'T'+$80
  DEFB TK_LIST

  DEFM "FILE"
  DEFB 'S'+$80
  DEFB TK_LFILES

  DEFM "O"
  DEFB 'G'+$80
  DEFB TK_LOG

  DEFM "O"
  DEFB 'C'+$80
  DEFB TK_LOC

  DEFM "E"
  DEFB 'N'+$80
  DEFB TK_LEN

  DEFM "EFT"
  DEFB '$'+$80
  DEFB TK_LEFT_S

  DEFM "O"
  DEFB 'F'+$80
  DEFB TK_LOF

  DEFB $00


WORDS_M:

  DEFM "OTO"
  DEFB 'R'+$80
  DEFB TK_MOTOR

  DEFM "ERG"
  DEFB 'E'+$80
  DEFB TK_MERGE

  DEFM "O"
  DEFB 'D'+$80
  DEFB TK_MOD

  DEFM "KI"
  DEFB '$'+$80
  DEFB TK_MKI_S

  DEFM "KS"
  DEFB '$'+$80
  DEFB TK_MKS_S

  DEFM "KD"
  DEFB '$'+$80
  DEFB TK_MKD_S

  DEFM "ID"
  DEFB '$'+$80
  DEFB TK_MID_S

  DEFM "A"
  DEFB 'X'+$80
  DEFB TK_MAX

  DEFB $00


WORDS_N:

  DEFM "EX"
  DEFB 'T'+$80
  DEFB TK_NEXT

  DEFM "AM"
  DEFB 'E'+$80
  DEFB TK_NAME

  DEFM "E"
  DEFB 'W'+$80
  DEFB TK_NEW

  DEFM "O"
  DEFB 'T'+$80
  DEFB TK_NOT

  DEFB $00


WORDS_O:

  DEFM "PE"
  DEFB 'N'+$80
  DEFB TK_OPEN

  DEFM "U"
  DEFB 'T'+$80
  DEFB TK_OUT

  DEFB 'N'+$80
  DEFB $95

  DEFB 'R'+$80
  DEFB TK_OR

  DEFM "CT"
  DEFB '$'+$80
  DEFB TK_OCT_S

  DEFM "F"
  DEFB 'F'+$80
  DEFB TK_OFF

  DEFB $00


WORDS_P:

  DEFM "RIN"
  DEFB 'T'+$80
  DEFB TK_PRINT

  DEFM "U"
  DEFB 'T'+$80
  DEFB TK_PUT

  DEFM "OK"
  DEFB 'E'+$80
  DEFB TK_POKE

  DEFM "O"
  DEFB 'S'+$80
  DEFB TK_POS

  DEFM "EE"
  DEFB 'K'+$80
  DEFB TK_PEEK

  DEFM "SE"
  DEFB 'T'+$80
  DEFB TK_PSET

  DEFM "RESE"
  DEFB 'T'+$80
  DEFB TK_PRESET

  DEFM "OIN"
  DEFB 'T'+$80
  DEFB TK_POINT

  DEFM "AIN"
  DEFB 'T'+$80
  DEFB TK_PAINT

  DEFM "D"
  DEFB 'L'+$80
  DEFB TK_PDL

  DEFM "A"
  DEFB 'D'+$80
  DEFB TK_PAD

  DEFM "LA"
  DEFB 'Y'+$80
  DEFB TK_PLAY

  DEFB $00


WORDS_Q:

  DEFB $00


WORDS_R:

  DEFM "ETUR"
  DEFB 'N'+$80
  DEFB TK_RETURN

  DEFM "EA"
  DEFB 'D'+$80
  DEFB TK_READ

  DEFM "U"
  DEFB 'N'+$80
  DEFB TK_RUN

  DEFM "ESTOR"
  DEFB 'E'+$80
  DEFB TK_RESTORE

  DEFM "E"
  DEFB 'M'+$80
  DEFB TK_REM

  DEFM "ESUM"
  DEFB 'E'+$80
  DEFB TK_RESUME

  DEFM "SE"
  DEFB 'T'+$80
  DEFB TK_RSET

  DEFM "IGHT"
  DEFB '$'+$80
  DEFB TK_RIGHT_S

  DEFM "N"
  DEFB 'D'+$80
  DEFB TK_RND

  DEFM "ENU"
  DEFB 'M'+$80
  DEFB TK_RENUM

  DEFB $00


WORDS_S:

  DEFM "CREE"
  DEFB 'N'+$80
  DEFB TK_SCREEN

  DEFM "PRIT"
  DEFB 'E'+$80
  DEFB TK_SPRITE

  DEFM "TO"
  DEFB 'P'+$80
  DEFB TK_STOP

  DEFM "WA"
  DEFB 'P'+$80
  DEFB TK_SWAP

  DEFM "E"
  DEFB 'T'+$80
  DEFB TK_SET

  DEFM "AV"
  DEFB 'E'+$80
  DEFB TK_SAVE

  DEFM "PC"
  DEFB '('+$80
  DEFB TK_SPC

  DEFM "TE"
  DEFB 'P'+$80
  DEFB TK_STEP

  DEFM "G"
  DEFB 'N'+$80
  DEFB TK_SGN

  DEFM "Q"
  DEFB 'R'+$80
  DEFB TK_SQR

  DEFM "I"
  DEFB 'N'+$80
  DEFB TK_SIN

  DEFM "TR"
  DEFB '$'+$80
  DEFB TK_STR_S

  DEFM "TRING"
  DEFB '$'+$80
  DEFB TK_STRING

  DEFM "PACE"
  DEFB '$'+$80
  DEFB TK_SPACE_S

  DEFM "OUN"
  DEFB 'D'+$80
  DEFB TK_SOUND

  DEFM "TIC"
  DEFB 'K'+$80
  DEFB TK_STICK

  DEFM "TRI"
  DEFB 'G'+$80
  DEFB TK_TRIG

  DEFB $00


WORDS_T:

  DEFM "HE"
  DEFB 'N'+$80
  DEFB TK_THEN

  DEFM "RO"
  DEFB 'N'+$80
  DEFB TK_TRON

  DEFM "ROF"
  DEFB 'F'+$80
  DEFB TK_TROFF

  DEFM "AB"
  DEFB '('+$80
  DEFB TK_TAB

  DEFB 'O'+$80
  DEFB TK_TO

  DEFM "IM"
  DEFB 'E'+$80
  DEFB TK_TIME

  DEFM "A"
  DEFB 'N'+$80
  DEFB TK_TAN

  DEFB $00


WORDS_U:

  DEFM "SIN"
  DEFB 'G'+$80
  DEFB TK_USING

  DEFM "S"
  DEFB 'R'+$80
  DEFB TK_USR

  DEFB $00


WORDS_V:

  DEFM "A"
  DEFB 'L'+$80
  DEFB TK_VAL

  DEFM "ARPT"
  DEFB 'R'+$80
  DEFB TK_VARPTR

  DEFM "D"
  DEFB 'P'+$80
  DEFB TK_VDP

  DEFM "POK"
  DEFB 'E'+$80
  DEFB TK_VPOKE

  DEFM "PEE"
  DEFB 'K'+$80
  DEFB TK_VPEEK

  DEFB $00


WORDS_W:

  DEFM "IDT"
  DEFB 'H'+$80
  DEFB TK_WIDTH

  DEFM "AI"
  DEFB 'T'+$80
  DEFB TK_WAIT

  DEFB $00


WORDS_X:

  DEFM "O"
  DEFB 'R'+$80
  DEFB TK_XOR

  DEFB $00


WORDS_Y:

  DEFB $00


WORDS_Z:

  DEFB $00
  
  

OPR_TOKENS:
  DEFB $AB
  DEFB TK_PLUS		; Token for '+'
  DEFB $AD
  DEFB TK_MINUS		; Token for '-'
  DEFB $AA
  DEFB TK_STAR		; Token for '*'
  DEFB $AF
  DEFB TK_SLASH		; Token for '/'
  DEFB $DE
  DEFB TK_EXPONENT	; Token for '^'
  DEFB $DC
  DEFB TK_BKSLASH	; Token for '\'
  DEFB $A7
  DEFB TK_APOSTROPHE	; Token for '''
  DEFB $BE
  DEFB TK_GREATER	; Token for '>'
  DEFB $BD
  DEFB TK_EQUAL		; Token for '='
  DEFB $BC
  DEFB TK_MINOR		; Token for '<'
  DEFB $00

  

; ARITHMETIC PRECEDENCE TABLE
PRITAB:
  DEFB $79  ; +   (Token code $F1)
  DEFB $79  ; -
  DEFB $7c  ; *
  DEFB $7c  ; /
  DEFB $7f  ; ^
  DEFB $50  ; AND 
  DEFB $46  ; OR
  DEFB $3c  ; XOR
  DEFB $32  ; EQU
  DEFB $28  ; IMP
  DEFB $7a  ; MOD
  DEFB $7b  ; \   (Token code $FC)


; NUMBER TYPES
TYPE_OPR:
  DEFW __CDBL
  DEFW 0
  DEFW __CINT
  DEFW TSTSTR
  DEFW __CSNG

  
; ARITHMETIC OPERATIONS TABLE  
DEC_OPR:
  DEFW DECADD
  DEFW DECSUB
  DEFW DECMUL
  DEFW DECDIV
  DEFW DECEXP
  DEFW DECCOMP

; Message at 15709
FLT_OPR:
  DEFW FADD
  DEFW FSUB
  DEFW FMULT
  DEFW FDIV
  DEFW FEXP
  DEFW FCOMP
  
INT_OPR:
  DEFW IADD
  DEFW ISUB
  DEFW IMULT
  DEFW IDIV
  DEFW INTEXP
  DEFW ICOMP

; Message at 15734
ERROR_MESSAGES:
  DEFB $00
  ; Err $01
  DEFM "NEXT without FOR"
  DEFB $00
  ; Err $02
  DEFM "Syntax error"
  DEFB $00
  ; Err $03
  DEFM "RETURN without GOSUB"
  DEFB $00
  ; Err $04
  DEFM "Out of DATA"
  DEFB $00
  ; Err $05
  DEFM "Illegal function call"
  DEFB $00
  ; Err $06
  DEFM "Overflow"
  DEFB $00
  ; Err $07
  DEFM "Out of memory"
  DEFB $00
  ; Err $08
  DEFM "Undefined line number"
  DEFB $00
  ; Err $09
  DEFM "Subscript out of range"
  DEFB $00
  ; Err $0A
  DEFM "Redimensioned array"
  DEFB $00
  ; Err $0B
  DEFM "Division by zero"
  DEFB $00
  ; Err $0C
  DEFM "Illegal direct"
  DEFB $00
  ; Err $0D
  DEFM "Type mismatch"
  DEFB $00
  ; Err $0E
  DEFM "Out of string space"
  DEFB $00
  ; Err $0F
  DEFM "String too long"
  DEFB $00
  ; Err $10
  DEFM "String formula too complex"
  DEFB $00
  ; Err $11
  DEFM "Can't CONTINUE"
  DEFB $00
  ; Err $12
  DEFM "Undefined user function"
  DEFB $00
  ; Err $13
  DEFM "Device I/O error"
  DEFB $00
  ; Err $14
  DEFM "Verify error"
  DEFB $00
  ; Err $15
  DEFM "No RESUME"
  DEFB $00
  ; Err $16
  DEFM "RESUME without error"
  DEFB $00  
  ; Err $17 (but also $00)
  DEFM "Unprintable error"
  DEFB $00
  ; Err $18
  DEFM "Missing operand"
  DEFB $00
  ; Err $19
  DEFM "Line buffer overflow"
  DEFB $00
  ; Err $1A
  DEFM "FIELD overflow"
  DEFB $00
  ; Err $1B
  DEFM "Internal error"
  DEFB $00
  ; Err $1C
  DEFM "Bad file number"
  DEFB $00
  ; Err $1D
  DEFM "File not found"
  DEFB $00
  ; Err $1E
  DEFM "File already open"
  DEFB $00
  ; Err $1F
  DEFM "Input past end"
  DEFB $00
  ; Err $20
  DEFM "Bad file name"
  DEFB $00
  ; Err $21
  DEFM "Direct statement in file"
  DEFB $00
  ; Err $22
  DEFM "Sequential I/O only"
  DEFB $00
  ; Err $23
  DEFM "File not OPEN"
  DEFB $00
  
IN_MSG:
  DEFM " in "

NULL_STRING:
  DEFB $00

OK_MSG:
  DEFM "Ok"
  DEFB CR
  DEFB LF
  DEFB $00

BREAK_MSG:
  DEFM "Break"
  DEFB $00

; Data block at 16353
  ; --- START PROC BAKSTK ---
; Search FOR or GOSUB block on stack (skip 2 words)
; Used by 'RETURN' and 'NEXT'
BAKSTK:
  LD HL,$0004       ; Look for "FOR" block with
  ADD HL,SP         ; same index as specified in D
  ; --- START PROC LOKFOR ---
LOKFOR:
  LD A,(HL)         ; Get block ID
  INC HL            ; Point to index address
  CP TK_FOR         ; Is it a "FOR" token
  RET NZ            ; No - exit
  LD C,(HL)         ; BC = Address of "FOR" index
  INC HL
  LD B,(HL)
  INC HL            ; Point to sign of STEP
  PUSH HL           ; Save pointer to sign
  LD H,B            ; HL = address of "FOR" index
  LD L,C           
  LD A,D            ; See if an index was specified
  OR E              ; DE = 0 if no index specified
  EX DE,HL          ; Specified index into HL
  JR Z,INDFND       ; Skip if no index given
  EX DE,HL          ; Index back into DE
  RST DCOMPR		; Compare index with one given
  
; INDFND
INDFND:
  LD BC,22          ; Offset to next block
  POP HL            ; Restore pointer to sign
  RET Z             ; Return if block found
  ADD HL,BC         ; Point to next block
  JR LOKFOR         ; Keep on looking

__INP:
  CALL GETWORD_HL
  LD B,H
  LD C,L
__INP_0:
  IN A,(C)
  JP PASSA

; Routine at 16395
;
; Used by the routines at __OUT and __WAIT.
; Get "WORD,BYTE" parameters
GTWORD_GTINT:
  CALL GETWORD
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  POP BC
  RET

; Routine at 16406
__OUT:
  CALL GTWORD_GTINT		; Get "WORD,BYTE" parameters
  OUT (C),A
  RET

; Routine at 16412
__WAIT:
  CALL GTWORD_GTINT		; Get "WORD,BYTE" parameters
  PUSH BC
  PUSH AF
  LD E,$00
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__WAIT_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
__WAIT_0:
  POP AF
  LD D,A
  POP BC
__WAIT_1:
  CALL CKCNTC
  IN A,(C)
  XOR E
  AND D
  JR Z,__WAIT_1
  RET

; Routine at 16441
PRG_END:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPRGE			; Hook for Program End event
ENDIF
  LD HL,(CURLIN)		 ; Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
  LD A,H
  AND L
  INC A
  JR Z,PRG_END_0		; JP if in 'DIRECT' (immediate) mode
  LD A,(ONEFLG)
  OR A
  LD E,$15
  JR NZ,ERROR			; Err $15 - No RESUME
PRG_END_0:
  JP _ENDPRG

; Routine at 16463
;
; Used by the routine at L4B4A.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?SN ERROR'
;
; Used by the routines at LNUM_RANGE, RUNLIN, __AUTO, EVAL, HEXTFP, NOT_KEYWORD, __RENUM_0,
; __SYNCHR, L55A7, GETVAR, __CLEAR, __OPEN, L7439, L77FE and __MAX.
SN_ERR:
  LD E,$02	; "Syntax error"
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; a.k.a. OERR, DZERR
O_ERR:
  LD E,$0B	; "Division by zero"
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
NF_ERR:
  LD E,$01	;  "NEXT without FOR"

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
DD_ERR:
  LD E,$0A	; "Redimensioned array"

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
UFN_ERR:
  LD E,$12  ; "Undefined user function"

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
RW_ERR:
  LD E,$16	; "RESUME without error"

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
OV_ERR:
  LD E,$06  ; "Overflow"
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
MO_ERR:
  LD E,$18	; "Missing operand"
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
TM_ERR:
  LD E,$0D	; "Type mismatch"

; This entry point is used by the routines at PRG_END, TOKENIZE_COLON, FC_ERR, UL_ERR,
; __ERROR, FDTLP, IDTEST, CHKSTK, __CONT, TSTOPL, TESTR, CONCAT, NM_ERR, __CLOAD and IO_ERR.
ERROR:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HERRO			; Hook for Error handler
ENDIF
  XOR A
  LD (NLONLY),A
  LD HL,(VLZADR)
  LD A,H
  OR L
  JR Z,ERROR_1
  LD A,(VLZDAT)
  LD (HL),A
  LD HL,$0000
  LD (VLZADR),HL
ERROR_1:
  EI
  LD HL,(CURLIN)		 ; Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
  LD (ERRLIN),HL
  LD A,H
  AND L
  INC A
  JR Z,ERROR_2			; JR if in 'DIRECT' (immediate) mode
  LD (DOT),HL
  
; This entry point is also used by the routine at ON_ERROR.
ERROR_2:		;(4096h)
  LD BC,ERROR_3
  JR WARM_BT_0

; Routine at 16539  ($409B)
;
; address of "warm boot" BASIC interpreter
WARM_BT:
  LD BC,RESTART		; 01 1E 41
; Routine at $409D
; This entry point is used by ERROR and BASIC_MAIN routines.
WARM_BT_0:
  LD HL,(SAVSTK)	; 2A B1 F6
  JP WARM_ENTRY		; C3 F0 62

; Routine at 16404
ERROR_3:
  POP BC		; C1
  LD A,E		; 7B
  LD C,E		; 4B
  LD (ERRFLG),A		; 32
  LD HL,(SAVTXT)
  LD (ERRTXT),HL
  EX DE,HL
  LD HL,(ERRLIN)
  LD A,H
  AND L
  INC A
  JR Z,ERROR_4
  LD (OLDLIN),HL
  EX DE,HL
  LD (OLDTXT),HL
ERROR_4:
  LD HL,(ONELIN)
  LD A,H
  OR L
  EX DE,HL
  LD HL,ONEFLG		; =1 if executing an error trap routine
  JR Z,ERROR_REPORT
  AND(HL)
  JR NZ,ERROR_REPORT
  ; We get here if the standard error handling is temporairly disabled (error trap).
  DEC(HL)
  EX DE,HL
  JP EXEC_EVAL_1

ERROR_REPORT:
  XOR A
  LD (HL),A
  LD E,C
  CALL CONSOLE_CRLF
  LD HL,ERROR_MESSAGES
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HERRP			; Hook 1 for Error Handler
ENDIF
  LD A,E
  CP $3C
  JR NC,UNKNOWN_ERR 	; JP if error code is bigger than $3B
  CP $32
  JR NC,SUB_18_ERR 		; JP if error code is between $32 and $3B
  CP $1A
  JR C,ERROR_REPORT_0	; JP if error code is < $1A

UNKNOWN_ERR:
  LD A,$2F		; if error code is bigger than $3B then force it to $2f-$18=$17 ("Unprintable error")
SUB_18_ERR:
  SUB $18		; JP here if error code is between $32 and $3B, sub $18
  LD E,A
ERROR_REPORT_0:
  CALL __REM		; 'Move to next line' (used by ELSE, REM..)
  INC HL
  DEC E
  JR NZ,ERROR_REPORT_0
  PUSH HL
  LD HL,(ERRLIN)
  EX (SP),HL
  ; --- START PROC _ERROR_REPORT ---
_ERROR_REPORT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HERRF			; Hook 2 for Error Handler
ENDIF
  PUSH HL
  CALL TOTEXT
  POP HL
  LD A,(HL)
  CP $3F 		; '?'
  JR NZ,ERROR_REPORT_1
  POP HL
  LD HL,ERROR_MESSAGES
  JR UNKNOWN_ERR

ERROR_REPORT_1:
  LD A,BEL
  RST OUTDO  		; Output char to the current device
  CALL PRS
  POP HL
  LD A,H
  AND L
  INC A
  CALL NZ,LNUM_MSG
  DEFB $3E  ; "LD A,n" to Mask the next byte
RESTART:
  POP BC

  ; --- START PROC READY ---
READY:
  CALL TOTEXT
  CALL STOP_LPT
  CALL CLOSE_STREAM
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HREAD				; Hook 1 for Mainloop ("OK")
ENDIF
  CALL CONSOLE_CRLF
  LD HL,OK_MSG				; "Ok" Message
  CALL PRS
  ; --- START PROC L4134 ---
PROMPT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HMAIN				; Hook 2 for Mainloop
ENDIF
  LD HL,$FFFF
  LD (CURLIN),HL			; Set interpreter in 'DIRECT' (immediate) mode
  LD HL,ENDPRG
  LD (SAVTXT),HL
  LD A,(AUTFLG)		; AUTO mode ?
  OR A
  JR Z,L415F
  LD HL,(AUTLIN)
  PUSH HL
  CALL _PRNUM
  POP DE
  PUSH DE
  CALL SRCHLN		; Get first line number
  LD A,'*'
  JR C,L415B
  LD A,' '
L415B:
  RST OUTDO  		; Output char to the current device

L415C:
  LD (AUTFLG),A		; AUTO mode
L415F:
  CALL ISFLIO		; Tests if I/O to device is taking place
  JR NZ,INI_STREAM
  CALL PINLIN
  JR NC,INI_LIN
  XOR A
  LD (AUTFLG),A		; Disable AUTO mode
  JP PROMPT

; Accepts a line from a stream
INI_STREAM:
  CALL PINSTREAM
  ; --- START PROC INI_LIN ---
INI_LIN:
  RST CHRGTB		 ; Get first character
  INC A              ; Test if end of line
  DEC A              ; Without affecting Carry
  JR Z,PROMPT        ; Nothing entered - Get another
  PUSH AF
  CALL ATOH		; Get specified line number
  JR NC,L4184
  CALL ISFLIO		; Tests if I/O to device is taking place
  JP Z,SN_ERR		; ?SN Err


L4184:
  CALL SKIP_BLANKS
  LD A,(AUTFLG)		; AUTO mode ?
  OR A
  JR Z,L4195
  CP '*'
  JR NZ,L4195
  CP (HL)
  JR NZ,L4195
  INC HL
L4195:
  LD A,D
  OR E
  JR Z,L419F
  LD A,(HL)
  CP ' '
  JR NZ,L419F
  INC HL
L419F:
  PUSH DE
  CALL TOKENIZE
  POP DE
  POP AF
  LD (SAVTXT),HL
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDIRD				; Hook 3 for Mainloop (direct statement)
ENDIF
  JR C,L41B4
  XOR A
  LD (AUTFLG),A		; reset AUTO mode flag
  JP EXEC_FILE

L41B4:
  PUSH DE
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.

L41B7:
  OR A
  PUSH AF
  LD A,(AUTFLG)		; AUTO mode ?
  AND A
  JR Z,L41C2
  POP AF
  SCF
  PUSH AF
  
L41C2:
  LD (DOT),DE		; Current line for edit & list
  LD HL,(AUTINC)	; Increment for auto
  ADD HL,DE
  JR C,L41D7
  PUSH DE
  LD DE,$FFFA		; -6
  RST DCOMPR		; Compare HL with DE.

L41D1:
  POP DE
  ; --- START PROC L41D2 ---
L41D2:
  LD (AUTLIN),HL		; Current line number for auto
  JR C,L41DB
L41D7:
  XOR A
  LD (AUTFLG),A			; AUTO mode ?
L41DB:
  CALL SRCHLN			; Get first line number
  JR C,L41ED
  POP AF
  PUSH AF
  JR NZ,L41EA
  JP NC,UL_ERR			; Err $08 - "Undefined line number"
  ; --- START PROC L41E7 ---
L41E7:
  PUSH BC
  JR L4237

  ; --- START PROC L41EA ---
L41EA:
  OR A
  JR L41F4

  ; --- START PROC L41ED ---
L41ED:
  POP AF
  PUSH AF
  JR NZ,L41F3
  JR C,L41E7
L41F3:
  SCF
  ; --- START PROC L41F4 ---
L41F4:
  PUSH BC
  PUSH AF
  PUSH HL
  CALL LINE2PTR_00
  POP HL
  POP AF
  POP BC
  PUSH BC
  CALL C,L5405
  POP DE
  POP AF
  PUSH DE
  JR Z,L4237
  
  POP DE
  LD HL,$0000
  LD (ONELIN),HL			; LINE to go when error
  LD HL,(VARTAB)
  EX (SP),HL
  POP BC
  PUSH HL
  ADD HL,BC
  PUSH HL
  CALL L6250
  POP HL
  LD (VARTAB),HL
  EX DE,HL
  LD (HL),H
  POP BC
  POP DE
  PUSH HL
  INC HL
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD DE,KBUF
  DEC BC
  DEC BC
  DEC BC
  DEC BC
L422E:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
  LD A,C
  OR B
  JR NZ,L422E
  ; --- START PROC L4237 ---
L4237:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFINI			;  Hook 1 for Mainloop finished
ENDIF
  POP DE
  CALL UPD_PTRS_0
  LD HL,(PTRFIL)		; Points to file data of currently accessing file
  LD (NXTOPR),HL		; Save I/O pointer before a possible file redirection (RUN "program")
  CALL RUN_FST
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFINE			;  Hook 2 for Mainloop finished
ENDIF
  LD HL,(NXTOPR)		; Restore I/O pointer
  LD (PTRFIL),HL
  JP PROMPT

  ; --- START PROC UPD_PTRS ---

; Routine at 16979
;
; Used by the routine at CHKSTK.
UPD_PTRS:
  LD HL,(TXTTAB)
  EX DE,HL
UPD_PTRS_0:
  LD H,D
  LD L,E
  LD A,(HL)
  INC HL
  OR (HL)
  RET Z
  INC HL
  INC HL
UPD_PTRS_1:
  INC HL
  LD A,(HL)
UPD_PTRS_2:
  OR A
  JR Z,UPD_PTRS_3
  CP ' '
  JR NC,UPD_PTRS_1
  CP $0B			; Not a number constant prefix ?
  JR C,UPD_PTRS_1           ; ...then JP
  CALL __CHRCKB		; Gets current character (or token) from BASIC text.
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR UPD_PTRS_2
  
UPD_PTRS_3:
  INC HL
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JR UPD_PTRS_0

; Routine at 17017
;
; Used by the routines at __LLIST and __DELETE.
LNUM_RANGE:
  LD DE,$0000
  PUSH DE
  JR Z,L4288
  POP DE
  CALL LNUM_PARM             ; Get specified line number
  PUSH DE
  JR Z,LNUM_RANGE_0
  RST SYNCHR 			;   Check syntax: next byte holds the byte to be found
  DEFB TK_MINUS			; Token for '-'
L4288:
  LD DE,$FFFA		; -6
  CALL NZ,LNUM_PARM
  JP NZ,SN_ERR
LNUM_RANGE_0:
  EX DE,HL
  POP DE

PHL_SRCHLN:
  EX (SP),HL
  PUSH HL
; This entry point is used by the routines at GO_TO, __DELETE, __RENUM_0, LINE2PTR and
; __RESTORE.
; Get first line number
SRCHLN:
  LD HL,(TXTTAB)	; Start of program text

; This entry point is used by the routine at RUNLIN.
SRCHLP:
  LD B,H            ; BC = Address to look at
  LD C,L            
  LD A,(HL)         ; Get address of next line
  INC HL            
  OR (HL)           ; End of program found?
  DEC HL            
  RET Z				; Yes - Line not found
  INC HL
  INC HL
  LD A,(HL)			; Get LSB of line number
  INC HL
  LD H,(HL)         ; Get MSB of line number
  LD L,A
  RST DCOMPR		; Compare HL with DE.
  LD H,B            ; HL = Start of this line
  LD L,C
  LD A,(HL)         ; Get LSB of next line address
  INC HL            
  LD H,(HL)         ; Get MSB of next line address
  LD L,A            ; Next line to HL
  CCF
  RET Z             ; Lines found - Exit
  CCF               
  RET NC            ; Line not found,at line after
  JR SRCHLP         ; Keep looking

; Routine at 17074
TOKENIZE:
  XOR A
  LD (DONUM),A
  LD (DORES),A		; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCRUN			; Hook 1 for Tokenise
ENDIF
  LD BC,BUF-BUFFER-5	; BUF-BUFFER-5 = 315 bytes
  LD DE,KBUF

; This entry point is used by the routine at DETOKEN_MORE.
NXTCHR:
  LD A,(HL)         ; Get byte
  OR A				; End of line ?
  JR NZ,CRNCLP      ; No, continue

					
; This entry point is used by the routine at TOKEN_BUILT.
_ENDBUF:			  ; Yes - Terminate buffer
  LD HL,BUF-BUFFER		; BUF-BUFFER = 320 bytes
  LD A,L
  SUB C
  LD C,A
  LD A,H
  SBC A,B
  LD B,A
  LD HL,BUFFER     ; Point to start of buffer
  XOR A
  LD (DE),A        ; Mark end of buffer (A = 00)
  INC DE           
  LD (DE),A        ; A = 00
  INC DE           
  LD (DE),A        ; A = 00
  RET
  
CRNCLP:
  CP '"'            ; Is it a quote?
  JP Z,CPYLIT       ; Yes - Copy literal string
  CP ' '            ; Is it a space?
  JR Z,_MOVDIR       ; Yes - Copy direct
  LD A,(DORES)		; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  OR A
  LD A,(HL)
  JR Z,TOKENIZE_11
; This entry point is used by the routines at DETOKEN_MORE and L44B4.
_MOVDIR:
  INC HL
  PUSH AF
  
  CP $01
  JR NZ,TOKENIZE_4
  LD A,(HL)
  AND A
  LD A,$01
TOKENIZE_4:
  CALL NZ,TOKENIZE_ADD
  POP AF
  SUB $3A			; ":", End of statement?
  JR Z,SETLIT       ; Jump if multi-statement line
  CP $4A			; $4A + $3A = $84 -> TK_DATA.. Is it DATA statement ?
  JR NZ,TSTREM      ; No - see if REM
  LD A,$01
SETLIT:
  LD (DORES),A		; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  LD (DONUM),A
TSTREM:
  SUB $55			; $55 + $3A = $8F  -> is it TK_REM ?
  JR NZ,NXTCHR
  PUSH AF
CRNCLP_0:
  LD A,(HL)
  OR A
  EX (SP),HL
  LD A,H
  POP HL
  JR Z,_ENDBUF
  CP (HL)
  JR Z,_MOVDIR

CPYLIT:
  PUSH AF
  LD A,(HL)
; This entry point is used by the routine at TOKEN_BUILT.
TOKENIZE_9:
  INC HL
  CP $01
  JR NZ,TOKENIZE_10
  LD A,(HL)
  AND A
  LD A,$01
TOKENIZE_10:
  CALL NZ,TOKENIZE_ADD
  JR CRNCLP_0
  
TOKENIZE_11:
  INC HL
  OR A
  JP M,NXTCHR
  CP $01
  JR NZ,TOKENIZE_12
  LD A,(HL)
  AND A
  JR Z,_ENDBUF
  INC HL
  JR NXTCHR

TOKENIZE_12:
  DEC HL
  CP '?'
  LD A,TK_PRINT
  PUSH DE
  PUSH BC
  JP Z,MOVDIR
  LD A,(HL)
  CP '_'		; $5F
  JP Z,MOVDIR
  LD DE,OPR_TOKENS
  CALL UCASE_HL		; Load A with char in 'HL' and make it uppercase
  CALL IS_ALPHA_A	; Check it is in the 'A'..'Z' range
  JP C,DETOKEN_MORE
  PUSH HL
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCRUS			; Hook 2 for Tokenise
ENDIF
  LD HL,WORD_PTR
  SUB $41
  ADD A,A
  LD C,A
  LD B,$00
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
  INC HL
CRNCH_MORE_3:
  PUSH HL

GETNXT:
  CALL UCASE_HL		; Load A with char in 'HL' and make it uppercase
  LD C,A
  LD A,(DE)
  AND $7F               ; Strip bit 7
  JP Z,L44EB            ; Return if end of list
  INC HL
  CP C                  ; Same character as in buffer?
  JR NZ,GETNXT_WD     ; No - get next word
  LD A,(DE)
  INC DE
  OR A
  JP P,GETNXT
  POP AF
  LD A,(DE)
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HISRE				; Hook 3 for Tokenise
ENDIF
  OR A
  JP M,TOKENIZE_17
  POP BC
  POP DE
  OR $80
  PUSH AF
  LD A,$FF
  CALL TOKENIZE_ADD
  XOR A
  LD (DONUM),A
  POP AF
  CALL TOKENIZE_ADD
  JP NXTCHR

GETNXT_WD:
  POP HL
COMPR_WD:
  LD A,(DE)
  INC DE
  OR A
  JP P,COMPR_WD
  INC DE
  JR CRNCH_MORE_3

TOKENIZE_17:
  DEC HL
MOVDIR:
  PUSH AF
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNTFN			; Hook 4 for Tokenise
ENDIF
  LD DE,LNUM_TOKENS		; List of commands (tokens) requiring program line numbers
  LD C,A
TOKENIZE_19:
  LD A,(DE)
  OR A
  JR Z,TOKEN_BUILT
  INC DE
  CP C
  JR NZ,TOKENIZE_19
  JR TOKENIZE_LNUM

; Routine at 17333
; List of commands (tokens) requiring program line numbers
LNUM_TOKENS:
  DEFB TK_RESTORE
  DEFB TK_AUTO
  DEFB TK_RENUM
  DEFB TK_DELETE
  DEFB TK_RESUME
  DEFB TK_ERL
  DEFB TK_ELSE
  DEFB TK_RUN
  DEFB TK_LIST
  DEFB TK_LLIST
  DEFB TK_GOTO
  DEFB TK_RETURN		; !
  DEFB TK_THEN
  DEFB TK_GOSUB
  DEFB $00

; This entry point is used by the routine at TOKENIZE.
TOKEN_BUILT:
  XOR A
  defb $C2	; JP NZ,NN (always false), masks the next 2 bytes
TOKENIZE_LNUM:
  LD A,1

TOKEN_BUILT_1:
  LD (DONUM),A
  POP AF
TOKEN_BUILT_2:
  POP BC
  POP DE
  CP TK_ELSE
  PUSH AF
  CALL Z,TOKENIZE_COLON
  POP AF
  CP TK_CALL	; $CA
  JR Z,TOKEN_BUILT_3
  CP '_'		; $5F
  JR NZ,TOKEN_BUILT_7
TOKEN_BUILT_3:
  CALL NC,TOKENIZE_ADD
TOKEN_BUILT_4:
  INC HL
  CALL UCASE_HL		; Load A with char in 'HL' and make it uppercase
  AND A
TOKEN_BUILT_5:
  JP Z,_ENDBUF
  JP M,TOKEN_BUILT_4
  CP $01
  JR NZ,TOKEN_BUILT_6
  INC HL
  LD A,(HL)
  AND A
  JR Z,TOKEN_BUILT_5
  JR TOKEN_BUILT_4

TOKEN_BUILT_6:
  CP ' '
  JR Z,TOKEN_BUILT_3
  CP ':'
  JR Z,DETOKEN_MORE_1
  CP '('
  JR Z,DETOKEN_MORE_1
  CP '0'
  JR TOKEN_BUILT_3

TOKEN_BUILT_7:
  CP TK_APOSTROPHE
  JP NZ,L44B4
  PUSH AF
  CALL TOKENIZE_COLON
  LD A,TK_REM
  CALL TOKENIZE_ADD
  POP AF
  PUSH HL
  LD HL,$0000
  EX (SP),HL
  JP TOKENIZE_9

; Routine at 17437
;
; Used by the routine at TOKENIZE.
DETOKEN_MORE:
  LD A,(HL)
  CP '.'
  JR Z,DETOKEN_MORE_0
  CP '9'+1
  JP NC,DETOKEN_MORE_9
  CP '0'
  JP C,DETOKEN_MORE_9
DETOKEN_MORE_0:
  LD A,(DONUM)
  OR A
  LD A,(HL)
  POP BC
  POP DE
  JP M,_MOVDIR
  JR Z,DETOKEN_MORE_5
  CP '.'
; This entry point is used by the routine at TOKEN_BUILT.
DETOKEN_MORE_1:
  JP Z,_MOVDIR
  LD A,$0E				; Line number prefix
  CALL TOKENIZE_ADD
  PUSH DE
  CALL ATOH		; Get specified line number
  CALL SKIP_BLANKS
; This entry point is used by the routine at L44B4.
DETOKEN_MORE_2:
  EX (SP),HL
  EX DE,HL
DETOKEN_MORE_3:
  LD A,L
  CALL TOKENIZE_ADD
  LD A,H
DETOKEN_MORE_4:
  POP HL
  CALL TOKENIZE_ADD
  JP NXTCHR

DETOKEN_MORE_5:
  PUSH DE
  PUSH BC
  LD A,(HL)
  CALL DBL_ASCTFP
  CALL SKIP_BLANKS
  POP BC
  POP DE
  PUSH HL
  LD A,(VALTYP)
  CP $02		; Integer ?
  JR NZ,DETOKEN_MORE_6
  LD HL,(FACLOW)
  LD A,H
  OR A
  LD A,$02
  JR NZ,DETOKEN_MORE_6
  LD A,L
  LD H,L
  LD L,$0F
  CP $0A
  JR NC,DETOKEN_MORE_3
  ADD A,$11				; Tokenized numeric suffix, as in USR0..USR9
  JR DETOKEN_MORE_4

DETOKEN_MORE_6:
  PUSH AF
  RRCA
  ADD A,$1B
  CALL TOKENIZE_ADD
  LD HL,FACCU
  LD A,(VALTYP)
  CP $02		; Integer ?
  JR NZ,DETOKEN_MORE_7
  LD HL,FACLOW
DETOKEN_MORE_7:
  POP AF
DETOKEN_MORE_8:
  PUSH AF
  LD A,(HL)
  CALL TOKENIZE_ADD
  POP AF
  INC HL
  DEC A
  JR NZ,DETOKEN_MORE_8
  POP HL
  JP NXTCHR

DETOKEN_MORE_9:
  LD DE,OPR_TOKENS-1
DETOKEN_MORE_10:
  INC DE
  LD A,(DE)
  AND $7F
  JP Z,L44FA
  INC DE
  CP (HL)
  LD A,(DE)
  JR NZ,DETOKEN_MORE_10
  JP L44FA_0

; Routine at 17588
;
; Used by the routine at TOKEN_BUILT.
L44B4:
  CP '&'		 ; $26
  JP NZ,_MOVDIR
  PUSH HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP HL
  CALL UCASE
  CP 'H'		; &H ..hex prefix
  JR Z,L44B4_1
  CP 'O'		; &O ..octal prefix
  JR Z,L44B4_0
  LD A,'&'		 ; $26
  JP _MOVDIR

L44B4_0:
  LD A,$0B		; Octal Number prefix
  JR L44B4_2

L44B4_1:
  LD A,$0C		; Hex Number prefix
L44B4_2:
  CALL TOKENIZE_ADD
  PUSH DE
  PUSH BC
  CALL HEXTFP
  POP BC
  JP DETOKEN_MORE_2

; Routine at 17630
;
; Used by the routine at TOKEN_BUILT.
TOKENIZE_COLON:
  LD A,':'
; This entry point is used by the routines at TOKENIZE, TOKEN_BUILT, DETOKEN_MORE and L44B4.
TOKENIZE_ADD:
  LD (DE),A
  INC DE
  DEC BC
  LD A,C
  OR B
  RET NZ
  LD E,$19				; Err $19 - "Line buffer overflow"
  JP ERROR

; Routine at 17643
;
; Used by the routine at TOKENIZE.
L44EB:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNOTR			; Hook 5 for Tokenise
ENDIF
  POP HL
  DEC HL
  DEC A
  LD (DONUM),A
  CALL UCASE_HL		; Load A with char in 'HL' and make it uppercase
  JP TOKEN_BUILT_2

; Routine at 17658
;
; Used by the routine at DETOKEN_MORE.
L44FA:
  LD A,(HL)
  CP ' '
  JR NC,L44FA_0
  CP $09	; TAB
  JR Z,L44FA_0
  CP LF
  JR Z,L44FA_0
  LD A,' '
; This entry point is used by the routine at DETOKEN_MORE.
L44FA_0:
  PUSH AF
  LD A,(DONUM)
  INC A
  JR Z,L44FA_1
  DEC A
L44FA_1:
  JP TOKEN_BUILT_1

; Routine at 17684
;
; Used by the routine at DETOKEN_MORE.
SKIP_BLANKS:
  DEC HL
  LD A,(HL)
  CP ' '
  JR Z,SKIP_BLANKS
  CP $09		; TAB
  JR Z,SKIP_BLANKS
  CP LF
  JR Z,SKIP_BLANKS
  INC HL
  RET

; Data block at 17700
__FOR:
  LD A,$64				; Flag "FOR" assignment
  LD (SUBFLG),A			; Save "FOR" flag
  CALL __LET            ; Set up initial index
  POP BC                ; Drop RETurn address
  PUSH HL               ; Save code string address
  CALL __DATA           ; Get next statement address
  LD (ENDFOR),HL		; Next address of FOR st.	
  LD HL,2               ; Offset for "FOR" block
  ADD HL,SP             ; Point to it
FORSLP:
  CALL LOKFOR           ; Look for existing "FOR" block
  JR NZ,FORFND          ; Get code string address
  ADD HL,BC             ; No nesting found
  PUSH DE               ; Move into "FOR" block
  DEC HL                ; Save code string address
  LD D,(HL)
  DEC HL                ; Get MSB of loop statement
  LD E,(HL)             
  INC HL                ; Get LSB of loop statement
  INC HL
  PUSH HL
  LD HL,(ENDFOR)		; Next address of FOR st.
  RST DCOMPR			; Compare the FOR loops
  POP HL                ; Restore block address
  POP DE
  JR NZ,FORSLP          ; Different FORs - Find another
  POP DE                ; Restore code string address
  LD SP,HL              ; Remove all nested loops
  LD (SAVSTK),HL
  
  DEFB $0E              ; LD C,N to mask the next byte

FORFND:
  POP DE                ; Code string address to HL
  EX DE,HL              
  LD C,12               ; Check for 12 levels of stack
  CALL CHKSTK
  PUSH HL
  LD HL,(ENDFOR)        ; Get first statement of loop
  EX (SP),HL            ; Save and restore code string
  PUSH HL               ; Re-save code string address
  LD HL,(CURLIN)		; Get current line number
  EX (SP),HL            ; Save and restore code string
  RST SYNCHR 			; Make sure "TO" is next
  DEFB TK_TO			; TK_TO: "TO" token
  RST GETYPR 			; Get the number type (FAC)
  JP Z,TM_ERR			; If string type, Err $0D - "Type mismatch"
  PUSH AF               ; save type
  CALL EVAL
  POP AF                ; Restore type
  PUSH HL
  JR NC,FORFND_DBL
  JP P,FORFND_FP
  CALL __CINT
  EX (SP),HL

  LD DE,$0001			; Default value for STEP
  LD A,(HL)             ; Get next byte in code string
  CP TK_STEP			; See if "STEP" is stated
  CALL Z,GET_PSINT      ; If so, get updated value for 'STEP'
  PUSH DE
  PUSH HL
  EX DE,HL
  CALL __TSTSGN_0		; Test sign for 'STEP'
  JR FORFND_1
  
FORFND_DBL:
  CALL __CDBL	        ; Get value for 'TO'
  POP DE	
  LD HL,$FFF8			; -8
  ADD HL,SP	
  LD SP,HL	
  PUSH DE	
  CALL FP_DE2HL	
  POP HL	
  LD A,(HL)	
  CP TK_STEP			; 'STEP'
  LD DE,FP_UNITY	    ; 1
  LD A,1				; Default STEP value
  JR NZ,SAVSTP			; No STEP given - Default to 1
  RST CHRGTB			; Jump over "STEP" token and point to step value
  CALL EVAL	
  PUSH HL	
  CALL __CDBL
  CALL SIGN			; test FP number sign
  LD DE,FACCU
  POP HL
  
SAVSTP:
  LD B,H
  LD C,L
  LD HL,$FFF8		; -8
  ADD HL,SP
  LD SP,HL
  PUSH AF
  PUSH BC
  CALL FP2HL
  POP HL
  POP AF
  JR FORFND_3

FORFND_FP:
  CALL __CSNG       ; Get value for 'TO'
  CALL BCDEFP       ; Move "TO" value to BCDE
  POP HL            ; Restore code string address
  PUSH BC           ; Save "TO" value in block
  PUSH DE
  LD BC,$1041		; BCDE = 1 float (default value for STEP)
  LD DE,$0000

IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSNGF			; Hook for 'FOR'
ENDIF

  LD A,(HL)
  CP TK_STEP			; See if "STEP" is stated
  LD A,$01              ; Sign of step = 1
  JR NZ,SAVSTP_2		; No STEP given - Default to 1
  CALL EVAL_0
  PUSH HL
  CALL __CSNG
  CALL BCDEFP
  CALL SIGN			; test FP number sign

FORFND_1:
  POP HL

SAVSTP_2:
  PUSH DE               ; Save the STEP value in block
  PUSH BC
  PUSH BC
  PUSH BC
  PUSH BC
  PUSH BC

FORFND_3:
  OR A
  JR NZ,FORFND_4
  LD A,$02
FORFND_4:
  LD C,A
  RST GETYPR 		; Get the number type (FAC)
  LD B,A
  PUSH BC
  PUSH HL
  LD HL,(TEMP)            ; Get address of index variable
  EX (SP),HL              ; Save and restore code string
; --- Put "FOR" block marker ---
PUTFID:
  LD B,TK_FOR             ; "FOR" block marker
  PUSH BC                 ; Save it
  INC SP                  ; Don't save C
		
		
; BASIC program execution driver (a.k.a. RUNCNT).
; HL points to code.

EXEC_EVAL: 
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNEWS				; Hook for runloop new statement event
ENDIF
  LD (SAVSTK),SP
  CALL ISCNTC			; Check STOP key status
  LD A,(ONGSBF)
  OR A
  CALL NZ,EXEC_ONGOSUB
EXEC_EVAL_0:
  EI
  LD (SAVTXT),HL		; Save code address for break
  LD A,(HL)             ; Get next byte in code string
  CP ':'                ; Multi statement line?
  JR Z,EXEC             ; Yes - Execute it
  OR A                  ; End of line?
  JP NZ,SN_ERR          ; No - Syntax error
  INC HL                ; Point to address of next line

;$4620
EXEC_EVAL_1:
  LD A,(HL)				; Get LSB of line pointer
  INC HL
  OR (HL)               ; Is it zero (End of prog)?
  JP Z,PRG_END          ; Yes - Terminate execution
  INC HL                ; Point to line number
  LD E,(HL)             ; Get LSB of line number
  INC HL
  LD D,(HL)             ; Get MSB of line number
  EX DE,HL              ; Line number to HL
  LD (CURLIN),HL        ; Save as current line number
  LD A,(TRCFLG)				; 0 MEANS NO TRACE
  OR A
  JR Z,EXEC_EVAL_2

  ; If "TRACE" is ON, then print current line number between brackets
  PUSH DE
  LD A,'['
  RST OUTDO  		; [0000] <<<-- print line number being executed
  CALL _PRNUM
  LD A,']'
  RST OUTDO 
  POP DE

;$463F
EXEC_EVAL_2:
  EX DE,HL				; Line number back to DE
  
;$4640
EXEC:
  RST CHRGTB		; Get key word
  LD DE,EXEC_EVAL   ; Where to RETurn to
  PUSH DE           ; Save for RETurn
  RET Z             ; Go to EXEC_EVAL if end of STMT
ONJMP:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HGONE			; Hook 1 in runloop execute event
ENDIF
  CP '_'			; $5F
  JP Z,L55A7
  SUB TK_END                 ; $81 = TK_END .. is it a token?
  JP C,__LET                 ; No - try to assign it
  CP TK_LOCATE+1-TK_END      ; END to LOCATE ?
  JP NC,NOT_KEYWORD          ; Not a key word - ?SN Error

  ; We're in the token range between TK_END and TK_LOCATE
  RLCA
  LD C,A
  LD B,$00
  EX DE,HL           ; Save code string address
  LD HL,FNCTAB		; Function routine addresses
  ADD HL,BC          ; Point to right address
  LD C,(HL)          ; Get LSB of address
  INC HL            
  LD B,(HL)          ; Get MSB of address
  PUSH BC
  EX DE,HL
		
  ; --- START PROC L4666 ---
;L4666:
__CHRGTB:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCNRG		; Hook for CHRGTR std routine
ENDIF
  INC HL                ; Point to next character
  ; --- START PROC __CHRCKB ---
  ; Gets current character (or token) from BASIC text.
__CHRCKB:
  LD A,(HL)             ; Get next code string byte
  CP ':'                ; Z if ":"
  RET NC                ; NC if > "9"
  CP ' '
  JR Z,__CHRGTB         ; Skip over spaces
  JR NC,__CHRCKB_0      ; NC if < "0"
  OR A                  ; Test for zero - Leave carry
  RET Z
  CP $0B				; Not a number constant prefix ?
  JR C,L46DB			; ...then JP
  CP $1E				; TK_CINT ? .. CURS_UP ?
  JR NZ,L4683
  LD A,(CONSAV)			; Store token of constant after calling CHRGTB
  OR A
  RET

L4683:
  CP $10				; TK_INP ?
  JR Z,L46BB
  PUSH AF
  INC HL
  LD (CONSAV),A			; Store token of constant after calling CHRGTB
  SUB $1C				; Prefix $1C -> Integer between 256 and 32767
  JR NC,L46C0			; Jump if constant is bigger than 255, (prefixes 1CH, 1DH 1FH).
  SUB $F5				; SUB -$0B ..-> ADD $0B ?
L4692:
  JR NC,L469A
  CP $FE		; -2 ?
  JR NZ,L46AE
  LD A,(HL)
  INC HL
L469A:
  LD (CONTXT),HL		; Text address used by CHRGTB
  LD H,$00
L469F:
  LD L,A
  LD (CONLO),HL			; Value of stored constant
  LD A,$02				; Integer
  LD (CONTYP),A			; Type of stored constant
  LD HL,L46E6
  POP AF
  OR A
  RET

L46AE:
  LD A,(HL)
  INC HL
  INC HL
  LD (CONTXT),HL		; Text address used by CHRGTB
  DEC HL
  LD H,(HL)
  JR L469F


; Routine at 18104
;
; Used by the routine at OPRND.
L46B8:
  CALL L46E6_0
L46BB:
  LD HL,(CONTXT)
  JR __CHRCKB		; Gets current character (or token) from BASIC text.

; Routine at 18112
L46C0:
  INC A
  RLCA
  LD (CONTYP),A			; Type of stored constant
  PUSH DE
  PUSH BC
  LD DE,CONLO			; Value of stored constant
  EX DE,HL
  LD B,A
  CALL CPY2HL   		; Copy B bytes from DE to HL
  EX DE,HL
  POP BC
  POP DE
  LD (CONTXT),HL
  POP AF
  LD HL,L46E6
  OR A
  RET

; Routine at 18139
L46DB:
  CP $09		; TAB
  JP NC,__CHRGTB  ; Gets next character (or token) from BASIC text.
__CHRCKB_0:
  CP '0'
  CCF
  INC A
  DEC A
  RET

; Routine at 18150
L46E6:
  LD E,$10
; This entry point is used by the routines at L46B8 and L5361.
L46E6_0:
  LD A,(CONSAV)
  CP $0F			; Prefix for Integer 10 to 255 ?
  JR NC,L46E6_2
  CP $0C+1
  JR C,L46E6_2			; JP if Prefix for Hex or Octal number
  LD HL,(CONLO)			; Value of stored constant
  JR NZ,L46E6_1
  INC HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
L46E6_1:
  JP DBL_ABS_0

L46E6_2:
  LD A,(CONTYP)			; Type of stored constant
  LD (VALTYP),A
  CP $02			; Integer ?
  JR NZ,L46E6_3
  LD HL,(CONLO)			; Value of stored constant
  LD (FACLOW),HL
L46E6_3:
  LD HL,CONLO			; Value of stored constant
  JP FP_HL2DE


; $4718
__DEFSTR:
  LD E,$03	; String type

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; $471B
__DEFINT:
  LD E,$02	; Integer type

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; $471E
__DEFSNG:
  LD E,$04	; Single precision type
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; $4721
__DEFDBL:
  LD E,$08	; Double Precision type

; $4723
DEFVAL:
  CALL IS_ALPHA  		; Load A with char in (HL) and check it is a letter
  LD BC,SN_ERR
  PUSH BC
  RET C
  SUB 'A'
  LD C,A
  LD B,A

  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP TK_MINUS		; Token for '-'
  JR NZ,L472F_0
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL IS_ALPHA		; Load A with char in (HL) and check it is a letter
  RET C
  SUB  'A'
  LD B,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
L472F_0:
  LD A,B
  SUB C
  RET C
  INC A
  EX (SP),HL
  LD HL,DEFTBL
  LD B,$00
  ADD HL,BC

L472F_1:
  LD (HL),E
  INC HL
  DEC A
  JR NZ,L472F_1
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR DEFVAL

; Routine at 18261
; Get subscript
GET_POSINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
; This entry point is used by the routine at __CLEAR.
GET_POSINT_0:
  CALL FPSINT
  RET P

; entry for '?FC ERROR'
;
; Used by the routines at __LOG, __ERROR, __AUTO, OPRND, __WIDTH, FNDNUM,
; __DELETE, __RENUM_0, __RENUM_3, L5683, L575A, PAINT_PARMS, ISGRPMODE, __PAINT, __CIRCLE, CIRCLE_SUB,
; __DRAW, M_DIAGONAL, SCALE, FORECOLOR, L5E91, USING_0, __SWAP, __CLEAR, __ASC, __MID_S,
; FN_INSTR, _MID_S, __LFILES, FN_INPUT, __SOUND, L748E, L7684, L77D4, ONGO, __STRIG,
; __SCREEN, L7A2D, __SPRITE, PUT_SPRITE, __BASE, __CVD and __MAX.
;  $475A
FC_ERR:
  LD E,$05				; Err $05 - "Illegal function call"
  JP ERROR

; Routine at 18271
;
; Used by the routines at LNUM_RANGE, __AUTO and __RENUM_0.
LNUM_PARM:
  LD A,(HL)
  CP '.'
  LD DE,(DOT)
  JP Z,__CHRGTB  ; Gets next character (or token) from BASIC text.

; This entry point is used by the routines at DETOKEN_MORE, __GOSUB, RUNLIN, __AUTO,
; L4EB3, __RENUM_0 and __RESTORE.
; Get specified line number
; ASCII to Integer, result in DE
ATOH:
  DEC HL
; This entry point is used by the routine at L492A.
ATOH2:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $0E			; Line number prefix
  JR Z,LNUM_PARM_2
  CP CR				; $0D
; This entry point is used by the routines at LINE2PTR and L556A.
LNUM_PARM_2:
  LD DE,(CONLO)			; Value of stored constant
  JP Z,__CHRGTB			; Gets next character (or token) from BASIC text.
  XOR A
  LD (CONSAV),A
  LD DE,$0000
  DEC HL
LNUM_PARM_3:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET NC
  PUSH HL
  PUSH AF
  LD HL,65529/10     ; Largest number 65529
  RST DCOMPR		; Compare HL with DE.
  JR C,OUTOF_RNG
  LD H,D
  LD L,E
  ADD HL,DE		; *2
  ADD HL,HL		; ..*4
  ADD HL,DE     ; ..*5
  ADD HL,HL     ; ..*10
  POP AF
  SUB '0'       ; -'0': convert from ASCII
  LD E,A
  LD D,0
  ADD HL,DE		; +A
  EX DE,HL
  POP HL
  JR LNUM_PARM_3
OUTOF_RNG:
  POP AF
  POP HL
  RET

; Routine at 18334
__RUN:
  JP Z,RUN_FST
  CP $0E			; Line number prefix
  JR Z,__RUN_0
  CP CR
  JP NZ,_RUN_FILE
__RUN_0:
  CALL _CLVAR
  LD BC,EXEC_EVAL
  JR RUNLIN

; Routine at 18354
__GOSUB:
  LD C,$03             ; 3 Levels of stack needed
  CALL CHKSTK          ; Check for 3 levels of stack
  CALL ATOH
  POP BC               ; Get return address
  PUSH HL              ; Save code string for RETURN
  PUSH HL              ; And for GOSUB routine
  LD HL,(CURLIN)       ; Get current line
  EX (SP),HL           ; Into stack - Code string out
  LD BC,$0000          
  PUSH BC              
  LD BC,EXEC_EVAL      
  LD A,TK_GOSUB        ; "GOSUB" token
  PUSH AF              ; Save token
  INC SP               ; Don't save flags
  PUSH BC
  JR __GOTO_0

; Routine at 18383
;
; Used by the routine at EXEC_ONGOSUB.
DO_GOSUB:
  PUSH HL                ; Save code string for RETURN
  PUSH HL                ; And for GOSUB routine
  LD HL,(CURLIN)		 ; Get current line
  EX (SP),HL             ; Into stack - Code string out
  PUSH BC
  LD A,TK_GOSUB          ; "GOSUB" token
  PUSH AF                ; Save token
  INC SP                 ; Don't save flags
  EX DE,HL
  DEC HL
  LD (SAVTXT),HL
  INC HL
  LD (SAVSTK),SP
  JP EXEC_EVAL_1

; Routine at 18407
;
; Used by the routine at __RUN.
RUNLIN:
  PUSH BC				; Save return address

; This entry point is used by the routine at __IF.
__GOTO:
  CALL ATOH				; ASCII number to DE binary
; This entry point is used by the routine at __GOSUB.
__GOTO_0:
  LD A,(CONSAV)
  CP CR
  EX DE,HL
  RET Z
  CP $0E				; Line number prefix
  JP NZ,SN_ERR
  EX DE,HL
  PUSH HL
  LD HL,(CONTXT)
  EX (SP),HL
  CALL __REM			; Get end of line
  INC HL                ; Start of next line
  PUSH HL               ; Save Start of next line
  LD HL,(CURLIN)		; Get current line
  RST DCOMPR			; Line after current?
  POP HL                ; Restore Start of next line
  CALL C,SRCHLP  ; Line is after current line
  CALL NC,SRCHLN	; Line is before current line
  JR NC,UL_ERR			; Err $08 - "Undefined line number"
  DEC BC                ; Incremented after
  LD A,$0D
  LD (PTRFLG),A
  POP HL
  CALL L556A_1
  LD H,B                ; Set up code string address
  LD L,C
  RET

; entry for '?UL ERROR'
;
; Used by the routines at RUNLIN, L492A and __RESTORE.
  ; --- START PROC L481C ---
UL_ERR:
  LD E,$08				; Err $08 - "Undefined line number"
  JP ERROR

; Data block at 18465
__RETURN:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HRETU			; Hook for 'RETURN'
ENDIF
  LD (TEMP),HL
  LD D,$FF				; Flag "GOSUB" search
  CALL BAKSTK			; Look "GOSUB" block
  CP TK_GOSUB			; TK_GOSUB, Token for 'GOSUB'
  JR Z,__RETURN_0
  DEC HL                
__RETURN_0:
  LD SP,HL              ; Kill all FORs in subroutine
  LD (SAVSTK),HL
  LD E,$03				; Err $03 - RETURN without GOSUB
  JP NZ,ERROR

  POP HL
  LD A,H
  OR L
  JR Z,__RETURN_1
  LD A,(HL)
  AND $01
  CALL NZ,RETURN_TRAP
__RETURN_1:
  POP BC           		; Get RETURN line number
  LD HL,EXEC_EVAL		; Execution driver loop
  EX (SP),HL			; Into stack - Code string out
  EX DE,HL
  LD HL,(TEMP)
  DEC HL
  RST CHRGTB			; Gets next character (or token) from BASIC text.
  JP NZ,__GOTO
  LD H,B            	; Put RETURN line number in HL
  LD L,C
  LD (CURLIN),HL    	; Save as current
  EX DE,HL

  DEFB $3E  ; "LD A,n" to Mask the next byte

NXTDTA:
  POP HL

  ; --- START PROC L485B ---
; DATA statement: find next DATA program line..
;
; Used by the routines at __IF, FDTLP and __DEF.
__DATA:
  DEFB $01,':'		; LD BC,$0E3A  -> C=":", End of statement

; 'Go to next line'
; Used by 'REM', 'ELSE' and error handling code.
__REM:
  DEFB $0E,$00		; LD C,0  -> 00  End of statement

  LD B,$00
NXTSTL:
  LD A,C			; Statement and byte
  LD C,B
  LD B,A			; Statement end byte
NXTSTT:
  DEC HL
NXTSTT_0:
  RST CHRGTB		; Get byte
  OR A              ; End of line?
  RET Z             ; Yes - Exit
  CP B              ; End of statement?
  RET Z             ; Yes - Exit
  INC HL            ; Next byte
  CP '"'            ; Literal string?
  JR Z,NXTSTL       ; Yes - Look for another '"'
  INC A
  JR Z,NXTSTT_0
  SUB TK_RESTORE	; $8C: TK_RESTORE
  JR NZ,NXTSTT
  CP B
  ADC A,D
  LD D,A
  JR NXTSTT			; Keep looking

; Routine at 18555
__LET_00:
  POP AF
  ADD A,$03		; cp valtyp to A+3 (String+?)
  JR __LET_0

; Routine at 18560
__LET:
  CALL GETVAR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL		; Token for '='
  LD (TEMP),DE
  PUSH DE
  LD A,(VALTYP)     ; Get data type
  PUSH AF           ; save type
  CALL EVAL
  POP AF            ; Restore type
; This entry point is used by the routines at __LET_00 and __LINE.
__LET_0:
  EX (SP),HL
; This entry point is used by the routine at __READ.
__LET_1:
  LD B,A
  LD A,(VALTYP)
  CP B
  LD A,B
  JR Z,__LET_2
  CALL CHKTYP
L489E:
  LD A,(VALTYP)
__LET_2:
  LD DE,FACCU
  CP $02	; Integer ?
  JR NZ,__LET_3
  LD DE,FACLOW
__LET_3:
  PUSH HL
  CP $03	; String ?
  JR NZ,LETNUM
  
  LD HL,(FACLOW)	; Pointer to string entry
  PUSH HL			; Save it on stack
  INC HL			; Skip over length
  LD E,(HL)			; LSB of string address
  INC HL
  LD D,(HL)			; MSB of string address
  LD HL,BUFFER
  RST DCOMPR		; Compare HL with DE.. is string before program?
  JR C,__LET_5
  LD HL,(STREND)
  RST DCOMPR		; Compare HL with DE.. is string literal in program?
  POP DE
  JR NC,MVSTPT		; Yes - Set up pointer
  LD HL,VARIABLES+14		; ..  on TRS80 Model 100 it is VARIABLES+15
  RST DCOMPR		; Compare HL with DE.
  JR C,__LET_4
  LD HL,VARIABLES-16		; ..  on TRS80 Model 100 it is VARIABLES-15
  RST DCOMPR		; Compare HL with DE.
  JR C,MVSTPT

__LET_4:
  DEFB $3E                ; "LD A,n" to Mask the next byte
  
__LET_5:
  POP DE
  CALL BAKTMP		; Back to last tmp-str entry
  EX DE,HL
  CALL SAVSTR_0
MVSTPT:
  CALL BAKTMP		; Back to last tmp-str entry
  EX (SP),HL

LETNUM:
  CALL FP2HL   		; Copy number value from DE to HL
  POP DE
  POP HL
  RET

; Data block at 18660
__ON:
  CP TK_ERROR
  JR NZ,ON_OTHER
  
  ; ON ERROR
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_GOTO
  CALL ATOH		; Get specified line number
  LD A,D
  OR E
  JR Z,__ON_0
  CALL PHL_SRCHLN		; Sink HL in stack and get first line number
  LD D,B
  LD E,C
  POP HL
  JP NC,UL_ERR			; Err $08 - "Undefined line number"
__ON_0:
  LD (ONELIN),DE		  ; LINE to go when error
  RET C
  LD A,(ONEFLG)		  ; =1 if executing an error trap routine
  OR A
  LD A,E
  RET Z
  LD A,(ERRFLG)		; Basic Error code 
  LD E,A
  JP ERROR_2		; Error

  ; ON KEY, STOP, SPRITE...
ON_OTHER:
  CALL ONGO			; ..ON "what" ?
  JR C,ON_GOSUB

  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_GOSUB
  XOR A

L4917:
  POP BC
  PUSH BC
  CP C
  JP NC,SN_ERR		; ?SN Err
  PUSH AF
  CALL ATOH		; Get specified line number
  LD A,D
  OR E
  JR Z,L492E
  CALL PHL_SRCHLN		; Sink HL in stack and get first line number
  LD D,B
  LD E,C		; DE=BC

; Routine at 18730
L492A:
  POP HL
  JP NC,UL_ERR			; Err $08 - "Undefined line number"

L492E:
  POP AF
  POP BC
  PUSH AF
  ADD A,B
  PUSH BC
  CALL L785C		; (ON key.. ?)
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP BC
  POP DE
  RET Z
  PUSH BC
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  POP AF
  INC A
  JR L4917
  
ON_GOSUB:
  CALL GETINT           ; Get integer 0-255
  LD A,(HL)             ; Get "GOTO" or "GOSUB" token
  LD B,A                ; Save in B
  CP TK_GOSUB           ; "GOSUB" token?
  JR Z,_ONGO             ; Yes - Find line number
  RST SYNCHR 		    ; Make sure it's "GOTO"
  DEFB TK_GOTO          ; TK_GOTO: "GOTO" token
  DEC HL                ; Cancel increment

_ONGO:                   
  LD C,E                ; Integer of branch value
ONGOLP:                 
  DEC C                 ; Count branches
  LD A,B                ; Get "GOTO" or "GOSUB" token
  JP Z,ONJMP            ; Go to that line if right one
  CALL ATOH2            ; Get line number to DE
  CP ','                ; Another line number?
  RET NZ                ; No - Drop through
  JR ONGOLP             ; Yes - loop

; Data block at 18781
__RESUME:
  LD A,(ONEFLG)
  OR A
  JR NZ,__RESUME_0
  LD (ONELIN),A
  LD (ONELIN+1),A
  JP RW_ERR			; Err 16 - "RESUME without error"

__RESUME_0:
  INC A
  LD (ERRFLG),A		;(a.k.a. ERRFLG) Error code of last error
  LD A,(HL)
  CP TK_NEXT
  JR Z,__RESUME_SUB
  CALL ATOH		; Get specified line number
  RET NZ
  LD A,D
  OR E
  JR Z,__RESUME_SUB_1
  CALL __GOTO_0
  XOR A
  LD (ONEFLG),A		; Clear 'on error' flag
  RET

__RESUME_SUB:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET NZ
  JR __RESUME_SUB_2

__RESUME_SUB_1:
  XOR A
  LD (ONEFLG),A			; Clear 'on error' flag
  INC A
__RESUME_SUB_2:
  LD HL,(ERRTXT)		; Error messages table
  EX DE,HL
  LD HL,(ERRLIN)		; Line where last error
  LD (CURLIN),HL
  EX DE,HL
  RET NZ
  LD A,(HL)
  OR A
  JR NZ,__RESUME_SUB_3
  INC HL
  INC HL
  INC HL
  INC HL
__RESUME_SUB_3:
  INC HL
  XOR A
  LD (ONEFLG),A			; Clear 'on error' flag
  JP __DATA


; Routine at 18858
  ; --- START PROC L406F ---
__ERROR:
  CALL GETINT           ; Get integer 0-255
  RET NZ                ; Return if bad value
  OR A
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  JP ERROR

; Routine at 18869
__AUTO:
  LD DE,$000A
  PUSH DE
  JR Z,__AUTO_0
  CALL LNUM_PARM             ; Get specified line number
  EX DE,HL
  EX (SP),HL
  JR Z,__AUTO_1
  EX DE,HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  LD DE,(AUTINC)
  JR Z,__AUTO_0
  CALL ATOH		; Get specified line number
  JP NZ,SN_ERR
__AUTO_0:
  EX DE,HL
__AUTO_1:
  LD A,H
  OR L
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  LD (AUTINC),HL
  LD (AUTFLG),A			; AUTO mode ?
  POP HL
  LD (AUTLIN),HL
  POP BC
  JP PROMPT

; Routine at 18917
__IF:
  CALL EVAL             ; Evaluate expression
  LD A,(HL)             ; Get token
  CP ','                ; ","
  CALL Z,__CHRGTB
  CP TK_GOTO			; "GOTO" token?
  JR Z,IFGO             ; Yes - Get line
  RST SYNCHR 		    ; Make sure it's "THEN"
  DEFB TK_THEN			; TK_THEN: "THEN" token
  DEC HL                ; Cancel increment
IFGO:
  PUSH HL
  CALL _TSTSGN          ; Test state of expression
  POP HL
  JR Z,FALSE_IF         ; False - Drop through
IFGO_0:
  RST CHRGTB			; Get next character
  RET Z
  CP $0E				; Line number prefix ?
  JP Z,__GOTO			; Yes - GOTO that line
  CP CR
  JP NZ,ONJMP			; Otherwise do statement
  LD HL,(CONLO)			; Value of stored constant
  RET

FALSE_IF:
  LD D,$01
DROP_THROUGH:
  CALL __DATA
  OR A
  RET Z
  RST CHRGTB			; Gets next character (or token) from BASIC text.
  CP TK_ELSE			; Token for ELSE
  JR NZ,DROP_THROUGH
  DEC D
  JR NZ,DROP_THROUGH
  JR IFGO_0

; Routine at 18973
__LPRINT:
  LD A,$01
  LD (PRTFLG),A
  JR MRPRNT

; Data block at 18980
__PRINT:
  LD C,$02
  CALL GET_CHNUM		; Get stream number (C=default #channel)
MRPRNT:
  DEC HL			; DEC 'cos GETCHR INCs
  RST CHRGTB		; Gets next character (or token) from BASIC text.

  CALL Z,OUTDO_CRLF
PRNTLP:
  JP Z,FINPRT		      ; End of list - Exit
  CP TK_USING		      ; USING
  JP Z,USING
  CP TK_TAB			      ; "TAB(" token?
  JP Z,__TAB		      ; Yes - Do TAB routine
  CP TK_SPC			      ; "SPC(" token?
  JP Z,__TAB		      ; Yes - Do SPC routine
  PUSH HL                 ; Save code string address
  CP ','                  ; Comma?
  JR Z,DOCOM              ; Yes - Move to next zone
  CP ';'                  ; Semi-colon?
  JP Z,NEXITM		      ; Do semi-colon routine
  POP BC                  ; Code string address to BC
  CALL EVAL               ; Evaluate expression
  PUSH HL                 ; Save code string address
  RST GETYPR 		      ; Get the number type (FAC)
  JR Z,PRNTST		      ; JP If string type
                          
  CALL FOUT               ; Convert number to text
  CALL CRTST              ; Create temporary string
  LD (HL),' '             ; Followed by a space
                          
; Routine at 19034        
  LD HL,(FACLOW)          ; Get length of output
  INC (HL)                ; Plus 1 for the space
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPRTF			; Hook 1 for "PRINT"
ENDIF
  CALL ISFLIO
  JR NZ,PRNTNB
  LD HL,(FACLOW)
  LD A,(PRTFLG)
  OR A
  JR Z,__PRINT_0
  LD A,(LPTPOS)
  ADD A,(HL)
  CP $FF
  JR __PRINT_1

__PRINT_0:
  LD A,(LINLEN)           ; Get width of line
  LD B,A                  ; To B
  LD A,(TTYPOS)           ; Get cursor position
  ADD A,(HL)              ; Add length of string
  DEC A                   ; Adjust it
  CP B                    ; Will output fit on this line?
__PRINT_1:                  
  JR C,PRNTNB            
  CALL Z,CRLF_DONE        ; No - CRLF first
  CALL NZ,OUTDO_CRLF
PRNTNB:
  CALL PRS1               ; Output string at (HL)
  OR A                    ; Skip CALL by resetting "Z" flag
; Output string contents
PRNTST:
  CALL Z,PRS1             ; Output string at (HL)
  POP HL                  ; Restore code string address
  JP MRPRNT               ; See if more to PRINT

; "," found in PRINT list
DOCOM:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCOMP			; Hook 2 for "PRINT" (comma found in PRINT command)
ENDIF
  LD BC,$0008
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL ISFLIO
  LD A,(HL)
  JR NZ,ZONELP
  LD A,(PRTFLG)
  OR A
  JR Z,L4A5A_3
  LD A,(LPTPOS)
  CP TK_GREATER			; Token for '>'
  JR L4A5A_4
  
L4A5A_3:
  LD A,(CLMLST)			; Column space
  LD B,A
  LD A,(TTYPOS)
  CP B
L4A5A_4:
  CALL NC,OUTDO_CRLF
  JP NC,NEXITM
ZONELP:
  SUB $0E			; Next zone of 14 characters
  JR NC,ZONELP      ; Repeat if more zones
  CPL               ; Number of spaces to output
  JR ASPCS          ; Output them
  
  
; __TAB(   &   __SPC(
__TAB:
  PUSH AF
  CALL FNDNUM		
  RST SYNCHR 		; Make sure ")" follows
  DEFB ')'
  DEC HL			; Back space on to ")"
  POP AF			; Restore token
  SUB $DF			; TK_SPC - Was it "SPC(" ?
  PUSH HL			; Save code string address
  JR Z,DOSPC		; Yes - Do "E" spaces

; TAB(
  LD BC,$0008
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL ISFLIO
  LD A,(HL)
  JR NZ,DOSPC
  LD A,(PRTFLG)
  OR A
  JP Z,DOTAB_TTY
  LD A,(LPTPOS)    ; Get current printer position
  JR DOSPC

DOTAB_TTY:
  LD A,(TTYPOS)    ; Get current position
  
; SPC(
DOSPC:
  CPL
  ADD A,E
  JR NC,NEXITM
ASPCS:
  INC A            ; Output A spaces
  LD B,A           ; Save number to print
  LD A,' '         ; Space
SPCLP:           
  RST OUTDO  		; Output character in A
  DJNZ SPCLP        ; Repeat if more
                    
; Move to next item in the PRINT list
NEXITM:            
  POP HL           ; Restore code string address
  RST CHRGTB		; Get next character
  JP PRNTLP        ; More to print

; This entry point is used by the routines at LTSTND, L61C4 and L628E.
FINPRT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFINP			; Hook 3 for "PRINT"
ENDIF
  XOR A
  LD (PRTFLG),A
  PUSH HL
  LD H,A
  LD L,A
  LD (PTRFIL),HL		; Redirect I/O
  POP HL
  RET

; Routine at 19214
__LINE:
  CP TK_INPUT		; ? Token for INPUT to support the "LINE INPUT" statement ?
  JP NZ,LINE		; No, this is a real graphics command !
  
  ; LINE INPUT
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_INPUT
  CP '#'
  JP Z,LINE_INPUT
  CALL __INPUT_0
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  PUSH HL
  CALL INLIN
  POP DE
  POP BC
  JP C,INPBRK
  PUSH BC
  PUSH DE
  LD B,$00
  CALL QTSTR_0	; Eval '0' quoted string
  POP HL
  LD A,$03		; cp VALTYP to String type
  JP __LET_0

; Message at 19259
REDO_MSG:
  DEFM "?Redo from start"
  DEFB CR, LF, $00

; This entry point is used by the routine at LTSTND.
ERR_INPUT:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HTRMN			; Hook for "READ/INPUT" error
ENDIF
  LD A,(FLGINP)
  OR A
  JP NZ,DATSNR
  POP BC
  LD HL,REDO_MSG			;  "?Redo from start"
  CALL PRS
  LD HL,(SAVTXT)
  RET

; Routine at 19298
;
; Used by the routine at __INPUT.
; INPUT #
SET_INPUT_CHANNEL:		; deal with '#' argument
  CALL GT_CHANNEL		; Get stream number (default #channel=1)
  PUSH HL
  LD HL,BUFMIN
  JP INPUT_CHANNEL		; 'INPUT' from a stream

; Routine at 19308
__INPUT:
  CP '#'
  JR Z,SET_INPUT_CHANNEL		; deal with '#' argument
  PUSH HL
  PUSH AF
  CALL TOTEXT
  POP AF
  POP HL
  LD BC,INPUT_SUB
  PUSH BC
; This entry point is used by the routine at __LINE.
__INPUT_0:
  CP '"'        	; Is there a prompt string?
  LD A,$00      	; Clear A and leave flags
  RET NZ
  CALL QTSTR		; Get string terminated by '"'
  RST SYNCHR 		; Check for ";" after prompt
  DEFB ';'
  PUSH HL           ; Save code string address
  CALL PRS1         ; Output prompt string
  POP HL
  RET

; Routine at 19339
INPUT_SUB:
  PUSH HL
  CALL QINLIN			; User interaction with question mark, HL = resulting text 
  POP BC
  JP C,INPBRK
  INC HL
  LD A,(HL)
  OR A
  DEC HL
  PUSH BC
  JP Z,NXTDTA		; just before '__DATA"

; This entry point is used by the routine at SET_INPUT_CHANNEL.
; 'INPUT' from a stream
INPUT_CHANNEL:
  LD (HL),','
  JR _READ_CH

; Routine at 19359
__READ:
  PUSH HL               ; Save code string address
  LD HL,(DATPTR)        ; Next DATA statement

  DEFB $F6				; OR AFh ..Flag "READ"

_READ_CH:
  XOR A					; Flag "INPUT"
  LD (FLGINP),A			; Save "READ"/"INPUT" flag
  EX (SP),HL			; Get code str' , Save pointer
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
_READ_00:
  RST SYNCHR			; Check for comma between items
  DEFB ','

;GTVLUS:  <-  the 'DEFB' trick above makes this jump unnecessary
  CALL GETVAR
  EX (SP),HL
  PUSH DE
  LD A,(HL)
  CP ','				; Comma?
  JR Z,ANTVLU			; Yes - Get another value
  LD A,(FLGINP)         ; Is it READ?
  OR A                  
  JP NZ,FDTLP           ; Yes - Find next DATA stmt
  LD A,'?'              ; More INPUT needed
  RST OUTDO				; Output character
  CALL QINLIN			; Get INPUT with prompt, HL = resulting text 
  POP DE
  POP BC
  JP C,INPBRK
  INC HL
  LD A,(HL)
  DEC HL
  OR A
  PUSH BC
  JP Z,NXTDTA		; just before '__DATA"
  PUSH DE

; This entry point is used by the routine at FDTLP.
ANTVLU:
  CALL ISFLIO       ; Tests if I/O to device is taking place
  JP NZ,__READ_INPUT
  RST GETYPR 		; Check data type
  PUSH AF
  JR NZ,INPBIN	    ; If numeric, convert to binary
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD D,A            ; Save input character
  LD B,A            ; Again
  CP '"'            ; Start of literal sting?
  JR Z,STRENT       ; Yes - Create string entry
  LD A,(FLGINP)     ; "READ" or "INPUT" ?
  OR A              
  LD D,A            ; Save 00 if "INPUT"
  JR Z,ITMSEP       ; "INPUT" - End with 00
  LD D,':'          ; "DATA" - End with 00 or ":"
ITMSEP:
  LD B,','          ; Item separator
  DEC HL            ; Back space for DTSTR
STRENT:
  CALL DTSTR         ; Get string terminated by D
  
  
__READ_DONE:
  POP AF
  ADD A,$03
  EX DE,HL
  LD HL,LTSTND
  EX (SP),HL
  PUSH DE
  JP __LET_1

INPBIN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD BC,__READ_DONE
  PUSH BC
  JP DBL_ASCTFP

; Routine at 19461
LTSTND:
  DEC HL
  RST CHRGTB		   ; Get next character
  JR Z,MORDT           ; End of line - More needed?
  CP ','               ; Another value?
  JP NZ,ERR_INPUT      ; No - Bad input
MORDT:              
  EX (SP),HL           ; Get code string address
  DEC HL               ; DEC 'cos GETCHR INCs
  RST CHRGTB		   ; Get next character
  JP NZ,_READ_00       ; More needed - Get it
  POP DE               ; Restore DATA pointer
  LD A,(FLGINP)        ; "READ" or "INPUT" ?
  OR A                 
  EX DE,HL             ; DATA pointer to HL
  JP NZ,UPDATA         ; Update DATA pointer if "READ"
  PUSH DE              ; Save code string address
  CALL ISFLIO          ; Tests if I/O to device is taking place
  JR NZ,LTSTND_1
  LD A,(HL)
  OR A
  LD HL,EXTRA_MSG		; "?Extra ignored"
  CALL NZ,PRS
LTSTND_1:
  POP HL               ; Restore code string address
  JP FINPRT

; Data block at 19503
EXTRA_MSG:
  DEFM "?Extra ignored"
  DEFB CR, LF, $00

  
; Find next DATA statement
;
; Used by the routine at __READ.
FDTLP:
  CALL __DATA      ; Get next statement
  OR A             ; End of line?
  JR NZ,FANDT      ; No - See if DATA statement
  INC HL           
  LD A,(HL)        ; End of program?
  INC HL           
  OR (HL)          ; 00 00 Ends program
  LD E,$04         ; Err $04 - "Out of DATA" (?OD Error)
  JP Z,ERROR		; Yes - Out of DATA
  INC HL
  LD E,(HL)        ; LSB of line number
  INC HL           
  LD D,(HL)        ; MSB of line number
  LD (DATLIN),DE   ; Set line of current DATA item
FANDT:
  RST CHRGTB		; Get next character
  CP TK_DATA		; TK_DATA, "DATA" token
  JR NZ,FDTLP       ; No "DATA" - Keep looking
  JP ANTVLU         ; Found - Convert input

  ; --- START PROC L4C5F ---
NEXT_EQUAL:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  DEFB 1		; "LD BC,n" to mask the next 2 lines

; Chk Syntax, make sure '(' follows
OPNPAR:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('

  ; --- START PROC L4C64 ---
; Evaluate expression
;
; Used by the routines at __LET, __IF, DOFN, GET_POSINT, FNDNUM, GETWORD, __CIRCLE,
; CIRCLE_SUB, L61C4, FN_STRING, FN_INSTR, FILE_PARMS, BSAVE_PARM, __BASE and __VPOKE.
EVAL:
  DEC HL                ; Evaluate expression & save
; This entry point is used by the routine at USING.
; $4C65
EVAL_0:
  LD D,$00              ; Precedence value

; Save precedence and eval until precedence break
;
; Used by the routines at EVAL, OPRND and NOT.
EVAL1:
  PUSH DE               ; Save precedence
  LD C,$01              ; Check for 1 level of stack
  CALL CHKSTK
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFRME			; Hook 1 for Expression evaluator
ENDIF
  CALL OPRND            ; Get next expression value

; Evaluate expression until precedence break
;
EVAL2:
  LD (NXTOPR),HL			; Save address of next operator

;
; Used by the routine at NOT.
EVAL3:
  LD HL,(NXTOPR)			; Restore address of next opr
  POP BC                    ; Precedence value and operator
  LD A,(HL)                 ; Get next operator / function
  LD (TEMP3),HL
  CP TK_GREATER				; Token code for '>'
  RET C                     
  CP TK_PLUS				; TK_PLUS, token code for '+'
  JR C,L4CAD_3              
  SUB TK_PLUS				; TK_PLUS, token code for '+'
  LD E,A					; Coded operator
  JR NZ,FOPRND
  LD A,(VALTYP)				; Get data type
  CP $03					; String ?
  LD A,E					; Coded operator
  JP Z,CONCAT				; If so, string concatenation (use '+' to join strings)
FOPRND:
  CP $0C                    ; Hex or another numeric prefix ?
  RET NC
  LD HL,PRITAB              ; ARITHMETIC PRECEDENCE TABLE
  LD D,$00
  ADD HL,DE                 ; To the operator concerned
  LD A,B                    ; Last operator precedence
  LD D,(HL)                 ; Get evaluation precedence
  CP D                      ; Compare with eval precedence
  RET NC                    ; Exit if higher precedence
  PUSH BC                   ; Save last precedence & token
  LD BC,EVAL3               ; Where to go on prec' break
  PUSH BC                   ; Save on stack for return
  LD A,D
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNTPL			; Hook 2 for Expression Evaluator
ENDIF
  CP $51				; one less than AND as mapped in PRITAB
  JR C,EVAL_BOOL	
  AND $FE	
  CP $7A				; MOD as mapped in PRITAB
  JR Z,EVAL_BOOL	
EVAL_NUMERIC:
  LD HL,FACLOW
  LD A,(VALTYP)
  SUB $03				; String ?
  JP Z,TM_ERR			; Err $0D - "Type mismatch"
  OR A
  
  LD HL,(FACLOW)
  PUSH HL
  JP M,EVAL_NEXT
  
  LD HL,(FACCU)
  PUSH HL
  JP PO,EVAL_NEXT
  
  LD HL,(FACCU+6)
  PUSH HL
  LD HL,(FACCU+4)
  PUSH HL

EVAL_NEXT:
  ADD A,$03
  LD C,E
  LD B,A
  PUSH BC
  LD BC,EVAL_VALTYP
  
EVAL_MORE:
  PUSH BC                   ; Save routine address
  LD HL,(TEMP3)             ; Address of current operator
  JP EVAL1                  ; Loop until prec' break


; This entry point is used by the routine at EVAL3.
L4CAD_3:
  LD D,$00
L4CAD_4:
  SUB TK_GREATER		; $EE
  JR C,NO_COMPARE_TK
  CP TK_MID_S			; $03
  JR NC,NO_COMPARE_TK
  CP TK_LEFT_S			; $01
  RLA
  XOR D
  CP D
  LD D,A
  JP C,SN_ERR
  LD (TEMP3),HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR L4CAD_4

EVAL_BOOL:
  PUSH DE
  CALL __CINT
  POP DE
  PUSH HL
  LD BC,EVAL_BOOL_END
  JR EVAL_MORE

NO_COMPARE_TK:
  LD A,B
  CP $64		; 100
  RET NC
  PUSH BC
  PUSH DE
  LD DE,$6405		; const value
  LD HL,L4F57
  PUSH HL
  RST GETYPR 		; Get the number type (FAC)
  JP NZ,EVAL_NUMERIC		; JP if not string type
  LD HL,(FACLOW)
  PUSH HL
  LD BC,EVAL_STR
  JR EVAL_MORE

; Data block at 19746
EVAL_VALTYP:
  POP BC
  LD A,C
  LD (OPRTYP),A			; Temp operator number operations
  LD A,(VALTYP)		; VALTYP - type indicator
  CP B				; is type specified in 'B' different ?
  JR NZ,EVAL_VALTYP_0
  CP $02			; Integer ?
  JR Z,EVAL_INTEGER
  CP $04			; single precision ?
  JP Z,L4D26_9
  JR NC,L4D26_3
EVAL_VALTYP_0:
  LD D,A
  LD A,B
  CP $08			; Double precision ?
  JR Z,L4D26_2
  LD A,D
  CP $08			; Double precision ?
  JR Z,L4D26_7
  LD A,B
  CP $04			; Single precision ?
  JR Z,EVAL_SINGLE_PREC
  LD A,D
  CP $03			; String ?
  JP Z,TM_ERR		; Err $0D - "Type mismatch"
  JR NC,EVAL_FP
; Integer VALTYP
EVAL_INTEGER:
  LD HL,INT_OPR
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP DE
  LD HL,(FACLOW)
  PUSH BC
  RET


L4D26_2:
  CALL __CDBL
L4D26_3:
  CALL FP_ARG2HL
  POP HL
  LD (FACCU+4),HL
  POP HL
  LD (FACCU+6),HL
L4D26_4:
  POP BC
  POP DE
  CALL FPBCDE
L4D26_5:
  CALL __CDBL
  LD HL,DEC_OPR
L4D26_6:
  LD A,(DORES)		; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  RLCA
  ADD A,L
  LD L,A
  ADC A,H
  SUB L
  LD H,A
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP (HL)
  
L4D26_7:
  LD A,B
  PUSH AF
  CALL FP_ARG2HL
  POP AF
  LD (VALTYP),A
  CP $04			; Single precision ?
  JR Z,L4D26_4
  POP HL
  LD (FACLOW),HL
  JR L4D26_5

EVAL_SINGLE_PREC:
  CALL __CSNG
; Single Precision VALTYP
L4D26_9:
  POP BC
  POP DE
L4D26_10:
  LD HL,FLT_OPR
  JR L4D26_6
EVAL_FP:
  POP HL
  CALL STAKI
  CALL HL_CSNG
  CALL BCDEFP
  POP HL
  LD (FACCU),HL
  POP HL
  LD (FACLOW),HL
  JR L4D26_10

; Routine at 19896
IDIV:
  PUSH HL
  EX DE,HL
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  JP DIVIDE

; Routine at 19911
;
; Used by the routines at EVAL1 and CONCAT.
OPRND:
  RST CHRGTB			; Gets next character (or token) from BASIC text.
  JP Z,MO_ERR			; Err $18 - "Missing Operand" Error
  JP C,DBL_ASCTFP       ; If numeric type, create FP number
  CALL IS_ALPHA_A		; See if a letter
  JP NC,EVAL_VARIABLE   ; Letter - Find variable
  CP ' '
  JP C,L46B8
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HEVAL            ; Hook 1 for Factor Evaluator
ENDIF
  INC A
  JP Z,OPRND_3
  DEC A
  CP TK_PLUS		; Token for '+'
  JR Z,OPRND		; Yes - Look for operand
  CP TK_MINUS		; Token for '-'
  JP Z,MINUS	    ; Yes - Do minus
  CP '"'
  JP Z,QTSTR		; Eval quoted string
  CP TK_NOT			; Token for NOT
  JP Z,NOT
  CP '&'
  JP Z,HEXTFP
  CP TK_ERR			; Token for ERR  ($E2)
  JR NZ,OPRND_0

__ERR:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,(ERRFLG)
  PUSH HL
  CALL PASSA
  POP HL
  RET


OPRND_0:
  CP TK_ERL			; Token for ERL
  JR NZ,OPRND_1
  
 __ERL:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,(ERRLIN)
  CALL DBL_ABS_0
  POP HL
  RET
  
OPRND_1:
  CP TK_POINT 
  JP Z,FN_POINT
  CP TK_TIME
  JP Z,FN_TIME
  CP TK_SPRITE
  JP Z,FN_SPRITE
  CP TK_VDP
  JP Z,FN_VDP
  CP TK_BASE
  JP Z,FN_BASE
  CP TK_PLAY
  JP Z,FN_PLAY
  CP TK_DSKI
  JP Z,FN_DSKI
  CP TK_ATTR
  JP Z,FN_ATTR
  CP TK_VARPTR
  JR NZ,OPRND_MORE

; 'VARPTR'
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  CP '#'
  JR NZ,VARPTR_VAR

; VARPTR(#buffer) Function
;VARPTR_BUF:
  CALL FNDNUM
  PUSH HL
  CALL GETPTR
  EX DE,HL
  POP HL
  JR VARPTR_1
  
VARPTR_VAR:
  CALL _GETVAR		; GETVAR

VARPTR_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  PUSH HL
  EX DE,HL
  LD A,H
  OR L
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  CALL INT_RESULT_HL
  POP HL
  RET

  
OPRND_MORE:
  CP TK_USR			; Token for USR
  JP Z,FN_USR
  CP TK_INSTR		; Token for INSTR
  JP Z,FN_INSTR
  CP TK_INKEY_S		; Token for INKEY$
  JP Z,FN_INKEY
  CP TK_STRING		; Token for STRING$
  JP Z,FN_STRING
  CP TK_INPUT		; Token for INPUT
  JP Z,FN_INPUT
  CP TK_CSRLIN		; Token for CSRLIN
  JP Z,FN_CSRLIN
  CP TK_FN			; Token for FN
  JP Z,DOFN

; This entry point is used by the routines at OPRND_3 and FN_USR.
EVLPAR:
  CALL OPNPAR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  RET
  
; '-', deal with minus sign 
MINUS:		; (a.k.a. "MINUS")
  LD D,$7D				; "-" precedence
  CALL EVAL1			; Evaluate until prec' break
  LD HL,(NXTOPR)		; Get next operator address
  PUSH HL				; Save next operator address
  CALL INVSGN			; Negate value

RETNUM:
  POP HL				; Restore next operator address
  RET


; This entry point is used by the routine at L575A.
; EVAL_VARIABLE (a.k.a. CONVAR)
EVAL_VARIABLE:
  CALL GETVAR
EVAL_VARIABLE_1:
  PUSH HL
  EX DE,HL
  LD (FACLOW),HL
  RST GETYPR 		; Get the number type (FAC)
  CALL NZ,FP_HL2DE	; CALL if not string type
  POP HL
  RET

; Routine at 20137
;
; Used by the routines at TOKENIZE, TOKEN_BUILT, L44EB, L55F8 and GET_DEVNAME.
UCASE_HL:
  LD A,(HL)

; Make char in 'A' upper case
;
; Used by the routines at L44B4 and HEXTFP.
UCASE:
  CP 'a'
  RET C
  CP 'z'+1
  RET NC
  AND $5F	; convert to uppercase
  RET

; Routine at 20147
L4EB3:
  CP '&'		 ; $26
  JP NZ,ATOH

; HEX(ASCII) to FP number
;
; Used by the routines at H_ASCTFP, L44B4 and OPRND.
HEXTFP:
  LD DE,$0000
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL UCASE
  LD BC,$0102		; B=1, C=2  ..Binary
  CP 'B'
  JR Z,HEXTFP_0
  LD BC,$0308		; B=3, C=8  ..Octal
  CP 'O'
  JR Z,HEXTFP_0
  LD BC,$0410		; B=4, C=16  ..Hex
  CP 'H'
  JP NZ,SN_ERR
HEXTFP_0:
  INC HL
  LD A,(HL)
  EX DE,HL
  CALL UCASE
  CP '9'+1
  JR C,HEXTFP_1
  CP 'A'
  JR C,HEXTFP_3
  SUB 7
HEXTFP_1:
  SUB '0'				; Transform to 0-F
  CP C
  JR NC,HEXTFP_3
  PUSH BC
HEXTFP_2:
  ADD HL,HL
  JP C,OV_ERR			; Err $06 -  "Overflow"
  DJNZ HEXTFP_2
  POP BC
  OR L
  LD L,A
  EX DE,HL
  JR HEXTFP_0
HEXTFP_3:
  CALL INT_RESULT_HL
  EX DE,HL
  RET

; Routine at 20220
;
; Used by the routine at OPRND.
OPRND_3:
  INC HL
  LD A,(HL)
  SUB $81                  ; Is it a function?
  LD B,$00                 ; Get address of function
  RLCA                     ; Double function offset
  LD C,A                   ; BC = Offset in function table
  PUSH BC                  ; Save adjusted token value
  RST CHRGTB		       ; Get next character
  LD A,C                   ; Get adjusted token value
  CP $05			       ; (??) TK_INT ?
  JR NC,FNVAL              ;  - Do function
  CALL OPNPAR		       ; Evaluate expression  (X,...
  RST SYNCHR 		       ; Make sure "," follows
  DEFB ','                 
  CALL TSTSTR              ; Make sure it's a string
  EX DE,HL                 ; Save code string address
  LD HL,(FACLOW)           ; Get address of string
  EX (SP),HL               ; Save address of string
  PUSH HL                  ; Save adjusted token value
  EX DE,HL                 ; Restore code string address
  CALL GETINT              ; Get integer 0-255
  EX DE,HL                 ; Save code string address
  EX (SP),HL               ; Save integer,HL = adj' token
  JR GOFUNC                ; Jump to string function

FNVAL:
  CALL EVLPAR              ; Evaluate expression
  EX (SP),HL               ; HL = Adjusted token value
  LD A,L
  CP $0C		; TK_COS ?
  JR C,FNVAL_0
  CP $1B
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HOKNO				; Hook 2 for Factor Evaluator
ENDIF
  JR NC,FNVAL_0
  RST GETYPR 		; Get the number type (FAC)
  
  PUSH HL
  CALL C,__CDBL
  POP HL
  
FNVAL_0:
  LD DE,RETNUM          ; Return number from function
  PUSH DE               ; Save on stack
GOFUNC:
  LD BC,FNCTAB_FN		; Function routine addresses
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFING		; Hook 3 for Factor Evaluator
ENDIF
GOFUNC_0:
  ADD HL,BC             ; Point to right address
  LD C,(HL)             ; Get LSB of address
  INC HL                ;
  LD H,(HL)             ; Get MSB of address
  LD L,C                ; Address to HL
  JP (HL)               ; Jump to function

; This entry point is used by the routine at _ASCTFP.
; test '+', '-'..
SGNEXP:
  DEC D                 ; Dee to flag negative exponent
  CP TK_MINUS			; "-" token ?
  RET Z                 ; Yes - Return
  CP '-'                ; "-" ASCII ?
  RET Z                 ; Yes - Return
  INC D                 ; Inc to flag positive exponent
  CP '+'                ; "+" ASCII ?
  RET Z                 ; Yes - Return
  CP TK_PLUS			; "+" token ?
  RET Z                 ; Yes - Return
  DEC HL                ; DEC 'cos GETCHR INCs
  RET                   ; Return "NZ"

; Routine at 20311
L4F57:
  INC A
  ADC A,A
  POP BC
  AND B
  ADD A,$FF
  SBC A,A
  CALL INT_RESULT_A
  JR NOT_0

; Routine at 20323
;
; Used by the routine at OPRND.
; Evaluate 'NOT'
NOT:
  LD D,$5A             ; Precedence value for "NOT"
  CALL EVAL1           ; Eval until precedence break
  CALL __CINT          ; Get integer -32768 - 32767
  LD A,L               ; Get LSB
  CPL                  ; Invert LSB
  LD L,A               ; Save "NOT" of LSB
  LD A,H               ; Get MSB
  CPL                  ; Invert MSB
  LD H,A               ; Set "NOT" of MSB
  LD (FACLOW),HL       ; Save AC as current
  POP BC               ; Clean up stack
; This entry point is used by the routine at L4F57.
NOT_0:
  JP EVAL3             ; Continue evaluation


; Routine at 20344
EVAL_BOOL_END:
  LD A,B
  PUSH AF
  CALL __CINT
  POP AF
  POP DE
  
  CP $7A		; MOD as mapped in PRITAB
  JP Z,IMOD
  
  CP $7B		; '\' as mapped in PRITAB
  JP Z,INT_DIV
  
  LD BC,BOOL_RESULT 
  PUSH BC
  
  CP $46		; OR as mapped in PRITAB
  JR NZ,SKIP_OR
OR:
  LD A,E
  OR L
  LD L,A
  LD A,H
  OR D
  RET

SKIP_OR:
  CP $50		; AND as mapped in PRITAB
  JR NZ,SKIP_AND
  
AND:
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET
  
SKIP_AND:
  CP $3C		; XOR as mapped in PRITAB
  JR NZ,SKIP_XOR

XOR:
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET
  
SKIP_XOR:
  CP $32		; EQU (=) as mapped in PRITAB
  JR NZ,IMP

EQV:
  LD A,E
  XOR L
  CPL
  LD L,A
  LD A,H
  XOR D
  CPL
  RET
  
IMP:
  LD A,L
  CPL
  AND E
  CPL
  LD L,A
  LD A,H
  CPL
  AND D
  CPL
  RET

; Routine at 20417 ($4FC1)
;
; Used by the routine at __FRE.
FRE_RESLT:
  OR A
  SBC HL,DE
  JP DBL_ABS_0

; Routine at 20423
__LPOS:
  LD A,(LPTPOS)
  JR PASSA

; Routine at 20428
__POS:
  LD A,(TTYPOS)
; This entry point is used by the routines at __INP_0, OPRND, __LPOS, __PEEK,
; __VAL, __PDL, FN_VDP and __VPEEK.
PASSA:
  LD L,A
  XOR A
  
BOOL_RESULT:
  LD H,A
  JP INT_RESULT_HL

; Routine at 20437
;
; Used by the routine at OPRND.
FN_USR:
  CALL GET_USR_JPTAB_ADDR
  PUSH DE
  CALL EVLPAR
  EX (SP),HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,POPHLRT		; (POP HL / RET)
  PUSH HL
  PUSH DE
  LD A,(VALTYP)
  PUSH AF
  CP $03	; String ?
  CALL Z,GSTRCU
  POP AF
  EX DE,HL
  LD HL,FACCU
  RET

; Routine at 20468
;
; Used by the routines at FN_USR and DEF_USR.
GET_USR_JPTAB_ADDR:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD BC,$0000
  CP $1B		; USR9 + 1 + $11
  JR NC,GET_USR_JPTAB_ADDR_0
  CP $11		; USR0 + $11
  JR C,GET_USR_JPTAB_ADDR_0
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,(CONLO)			; Value of stored constant
  OR A
  RLA
  LD C,A
GET_USR_JPTAB_ADDR_0:
  EX DE,HL
  LD HL,USR0
  ADD HL,BC
  EX DE,HL
  RET

; Routine at 20494
;
; Used by the routine at __DEF.
DEF_USR:
  CALL GET_USR_JPTAB_ADDR
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  CALL GETWORD
  EX (SP),HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; Routine at 20509
__DEF:
  CP TK_USR
  JR Z,DEF_USR
  CALL CHEKFN
  CALL IDTEST	; Error if in 'DIRECT' (immediate) mode
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  LD A,(HL)
  CP '('
  JP NZ,__DATA
  RST CHRGTB		; Gets next character (or token) from BASIC text.
__DEF_0:
  CALL GETVAR
  LD A,(HL)
  CP ')'
  JP Z,__DATA
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JR __DEF_0

; Routine at 20544
;
; Used by the routine at OPRND.
DOFN:
  CALL CHEKFN           ; Make sure "FN" follows and get FN name
  LD A,(VALTYP)
  OR A
  PUSH AF
  LD (NXTOPR),HL		; Next operator in EVAL
  EX DE,HL
  LD A,(HL)             ; Get LSB of FN code string
  INC HL                
  LD H,(HL)             ; Get MSB of FN code string
  LD L,A                
  LD A,H                ; Is function DEFined?
  OR L
  JP Z,UFN_ERR          ; Err $12 - "Undefined user function"
  LD A,(HL)
  CP '('
  JP NZ,DOFN_4
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD (TEMP3),HL
  EX DE,HL
  LD HL,(NXTOPR)		; Next operator in EVAL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  XOR A
  PUSH AF
  PUSH HL
  EX DE,HL
DOFN_0:
  LD A,$80
  LD (SUBFLG),A
  CALL GETVAR
  EX DE,HL
  EX (SP),HL
  LD A,(VALTYP)
  PUSH AF
  PUSH DE
  CALL EVAL
  LD (NXTOPR),HL		; Next operator in EVAL
  POP HL
  LD (TEMP3),HL
  POP AF
  CALL CHKTYP
  LD C,$04
  CALL CHKSTK
  LD HL,$FFF8		; -8
  ADD HL,SP
  LD SP,HL
  CALL FP_DE2HL
  LD A,(VALTYP)
  PUSH AF
  LD HL,(NXTOPR)		; Next operator in EVAL
  LD A,(HL)
  CP ')'
  JR Z,DOFN_2
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  LD HL,(TEMP3)
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JR DOFN_0	; $5069
  

DOFN_1:
  POP AF
  LD (PRMLN2),A		; Size of parameter block
DOFN_2:
  POP AF
  OR A
  JR Z,DOFN_3
  LD (VALTYP),A
  LD HL,$0000
  ADD HL,SP
  CALL FP_HL2DE
  LD HL,$0008
  ADD HL,SP
  LD SP,HL
  POP DE
  LD L,$03
  DEC DE
  DEC DE
  DEC DE
  LD A,(VALTYP)
  ADD A,L
  LD B,A
  LD A,(PRMLN2)		; Size of parameter block
  LD C,A
  ADD A,B
  CP $64 		; 'd'
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  PUSH AF
  LD A,L
  LD B,$00
  LD HL,PARM2
  ADD HL,BC
  LD C,A
  CALL DOFN_8
  LD BC,DOFN_1
  PUSH BC
  PUSH BC
  JP L489E

DOFN_3:
  LD HL,(NXTOPR)		; Next operator in EVAL
  RST CHRGTB		 		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,(TEMP3)		; Used for garbage collection or by USR function
  RST SYNCHR			;   Check syntax: next byte holds the byte to be found
  DEFB ')'

  DEFB $3E                ; "LD A,n" to Mask the next byte
DOFN_4:
  PUSH DE
  LD (TEMP3),HL		; Used for garbage collection or by USR function
  LD A,(PRMLEN)
  ADD A,$04
  PUSH AF
  RRCA
  LD C,A
  CALL CHKSTK
  POP AF
  LD C,A
  CPL
  INC A
  LD L,A
  LD H,$FF
  ADD HL,SP
  LD SP,HL
  PUSH HL
  LD DE,PRMSTK		; Previous definition block on stack
  CALL DOFN_8
  POP HL
  LD (PRMSTK),HL		; Previous definition block on stack
  LD HL,(PRMLN2)
  LD (PRMLEN),HL
  LD B,H
  LD C,L
  LD HL,PARM1
  LD DE,PARM2
  CALL DOFN_8
  LD H,A
  LD L,A
  LD (PRMLN2),HL
  LD HL,(FUNACT)		; Count of active functions
  INC HL
  LD (FUNACT),HL		; Count of active functions
  LD A,H
  OR L
  LD (NOFUNS),A		; 0 if no function active
  LD HL,(TEMP3)
  CALL NEXT_EQUAL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR	; ?SN Err
  RST GETYPR 		; Get the number type (FAC)
  JR NZ,DOFN_5		; JP if not string type, 
  LD DE,DSCTMP		; String descriptor which is the result of string fun.
  LD HL,(FACLOW)
  RST DCOMPR		; Compare HL with DE.
  JR C,DOFN_5
  CALL SAVSTR_0
  CALL TSTOPL_0
DOFN_5:
  LD HL,(PRMSTK)		; Previous definition block on stack
  LD D,H
  LD E,L
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC BC
  INC BC
  INC BC
  INC BC
  LD HL,PRMSTK		; Previous definition block on stack
  CALL DOFN_8
  EX DE,HL
  LD SP,HL
  LD HL,(FUNACT)		; Count of active functions
  DEC HL
  LD (FUNACT),HL		; Count of active functions
  LD A,H
  OR L
  LD (NOFUNS),A		; 0 if no function active
  POP HL
  POP AF
  ; --- START PROC CHKTYP ---
CHKTYP:
  PUSH HL
  AND $07
  LD HL,TYPE_OPR
  LD C,A
  LD B,$00
  ADD HL,BC
  CALL GOFUNC_0
  POP HL
  RET

; Routine at 20873
DOFN_7:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
DOFN_8:
  LD A,B
  OR C
  JR NZ,DOFN_7
  RET

; Routine at 20883
;
; Used by the routine at __DEF.
;
; Check for a running program (Z if so).  If a program is not running, generate
; an Illegal Direct (ID) error.
;
IDTEST:
  PUSH HL               ; Save code string address
  LD HL,(CURLIN)		; Get current line number
  INC HL                ; -1 means direct statement
  LD A,H                
  OR L                  
  POP HL                ; Restore code string address
  RET NZ                ; Return if in program
  LD E,$0C				; Err $0C - "Illegal direct" (ID_ERROR)
  JP ERROR

; Routine at 20897
;
; Used by the routines at __DEF and DOFN.
CHEKFN:
  RST SYNCHR            ; Make sure FN follows
  DEFB TK_FN            ; "FN" token
  LD A,$80              
  LD (SUBFLG),A         ; Flag FN name to find
  OR (HL)               ; FN name has bit 7 set
  LD C,A                ; in first byte of name
  JP GTFNAM             ; Get FN name

; Routine at 20909
NOT_KEYWORD:
  CP $7E		; = $FF-$81 .. Token codes smaller than $80 ?
  JR NZ,NOT_KEYWORD_ERR
  INC HL
  LD A,(HL)
  INC HL
  CP TK_MID_S+$80	; $83
  JP Z,_MID_S
  CP TK_TRIG+$80	; $A3
  JP Z,_TRIG
  CP TK_INT+$80	; $85
  JP Z,_INTERVAL
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HISMI			; Hook 2 for Runloop execute event
ENDIF
NOT_KEYWORD_ERR:
  JP SN_ERR

; Routine at 20937
__WIDTH:
  CALL GETINT
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HWIDT			; Hook for "WIDTH"
ENDIF
  AND A
  JR Z,__WIDTH_1
  LD A,(OLDSCR)
  AND A
  LD A,E
  JR Z,__WIDTH_0
  CP 32+1
  JR NC,__WIDTH_1
__WIDTH_0:
  CP 40+1
__WIDTH_1:
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  LD A,(LINLEN)
  CP E
  RET Z
  LD A,FF			; FORMFEED
  RST OUTDO  		; Output char to the current device
  
L5200:
  LD A,E
  LD (LINLEN),A
  LD A,(OLDSCR)
  DEC A
  LD A,E
  JR NZ,__WIDTH_2
  LD (LINL32),A
  JR __WIDTH_3
__WIDTH_2:
  LD (LINL40),A
__WIDTH_3:
  LD A,FF			; FORMFEED
  RST OUTDO  		; Output char to the current device
  LD A,E
; This entry point is used by the routine at __SCREEN.
__WIDTH_4:
  SUB $0E			; Line number prefix
  JR NC,__WIDTH_4
  ADD A,$1C			; TK_LPOS ?  Cursor right ?
  CPL
  INC A
  ADD A,E
  LD (CLMLST),A			; Column space
  RET

; Routine at 21006
; $520E
GET_PSINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
;
; This entry point is used by the routines at GET_POSINT, COORD_PARMS and __CIRCLE.
; $520F
FPSINT:
  CALL EVAL
;
; Get integer variable to DE, error if negative
; Used by the routine at FNDNUM.
; $5212
DEPINT:
  PUSH HL
  CALL __CINT
  EX DE,HL
  POP HL
  LD A,D
  OR A
  RET

; Routine at 21019
;
; Used by the routines at L4A5A, OPRND and GT_CHANNEL.
FNDNUM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
; This entry point is used by the routines at GTWORD_GTINT, __WAIT, L492A, __ERROR,
; OPRND_3, __WIDTH, __POKE, PAINT_PARMS, __PAINT, _MID_S, L69E4, L6A9E, __OPEN, L6BFB,
; FN_INPUT, __SOUND, __LOCATE, L77D4, __COLOR, __SCREEN, L7A2D, PUT_SPRITE, __VDP,
; __VPOKE and __MAX.
; $521C
GETINT:
  CALL EVAL
; This entry point is used by the routines at __CHR_S, FN_STRING, FN_INSTR, GETFLP,
; __STICK, __STRIG, __PDL and __PAD.
MAKINT:
  CALL DEPINT
  JP NZ,FC_ERR			; Err $05 - "Illegal function call"
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,E
  RET

; Routine at 21033
__LLIST:
  LD A,$01
  LD (PRTFLG),A
; This entry point is used by the routine at __SAVE.
__LIST:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLIST			; Hook for "LIST"
ENDIF
  POP BC
  CALL LNUM_RANGE             ; Get specified line number range
  PUSH BC
__LIST_0:
  LD HL,$FFFF		; Set interpreter in 'DIRECT' (immediate) mode
  LD (CURLIN),HL
  POP HL
  POP DE
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,B
  OR C
  JP Z,READY
  CALL ISFLIO
  CALL Z,ISCNTC
  PUSH BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  EX (SP),HL
  EX DE,HL
  RST DCOMPR		; Compare HL with DE.
  POP BC
  JP C,RESTART
  EX (SP),HL
  PUSH HL
  PUSH BC
  EX DE,HL
  LD (DOT),HL
  CALL _PRNUM
  POP HL
  LD A,(HL)
  CP $09			; TAB
  JR Z,__LIST_1
  LD A,' '
  RST OUTDO  		; Output char to the current device
__LIST_1:
  CALL DETOKEN_LIST
  LD HL,BUF
  CALL __LIST_2
  CALL OUTDO_CRLF
  JR __LIST_0

; Routine at 21115
;
; Used by the routine at __LLIST.
__LIST_2:
  LD A,(HL)
  OR A
  RET Z
  CALL __LIST_3
  INC HL
  JR __LIST_2

; Routine at 21124
;
; Used by the routine at __LLIST.
DETOKEN_LIST:
  LD BC,BUF
  LD D,$FF		; init line byte counter in D
  XOR A
  LD (DORES),A		; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  JR DETOKEN_NEXT_1

;  block at 21135
  ; --- START PROC DETOKEN_NEXT ---
DETOKEN_NEXT:
  INC BC
  INC HL
  DEC D		; decrement line byte counter in D
  RET Z
  ; --- START PROC DETOKEN_NEXT_1 ---
DETOKEN_NEXT_1:
  LD A,(HL)
  OR A
  LD (BC),A
  RET Z
  CP $0B			; Not a number constant prefix ?
  JR C,DETOKEN_NEXT_4		;..then JP
  CP ' '
  JP C,L5361
  CP '"'
  JR NZ,DETOKEN_NEXT_2
  LD A,(OPRTYP)		; Temp operator number operations
  XOR $01
  LD (OPRTYP),A		; Temp operator number operations
  LD A,'"'
DETOKEN_NEXT_2:
  CP ':'
  JR NZ,DETOKEN_NEXT_4
  LD A,(OPRTYP)		; Temp operator number operations
  RRA
  JR C,DETOKEN_NEXT_3
  RLA
  AND $FD
  LD (OPRTYP),A		; Temp operator number operations
DETOKEN_NEXT_3:
  LD A,':'
DETOKEN_NEXT_4:
  OR A
  JP P,DETOKEN_NEXT
  LD A,(OPRTYP)		; Temp operator number operations
  RRA
  JR C,_DETOKEN_NEXT
  RRA
  RRA
  JR NC,DETOKEN
  LD A,(HL)
  CP TK_APOSTROPHE	  ; COMMENT, check if line ends with the apostrophe..
  PUSH HL
  PUSH BC
  LD HL,__DETOKEN_NEXT
  PUSH HL
  RET NZ
  
  ; ..or with the ':REM' sequence..
  DEC BC
  LD A,(BC)
  CP 'M'
  RET NZ
  DEC BC
  LD A,(BC)
  CP 'E'
  RET NZ
  DEC BC
  LD A,(BC)
  CP 'R'
  RET NZ
  DEC BC
  LD A,(BC)
  CP ':'
  RET NZ
  
  POP AF
  POP AF
  POP HL
  INC D		; add 4 to line byte counter D
  INC D
  INC D
  INC D
  JR L531A

; Routine at 21237
__DETOKEN_NEXT:
  POP BC
  POP HL
  LD A,(HL)
; This entry point is used by the routine at DETOKEN.
_DETOKEN_NEXT:
  JP DETOKEN_NEXT

; Routine at 21243
;
; Used by the routine at DETOKEN.
SET_DATA_FLAG:
  LD A,(DORES)	; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  OR $02
; This entry point is used by the routine at SET_REM_FLAG.
UPD_OPRTYP:
  LD (DORES),A	; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  XOR A
  RET

; Routine at 21253
;
; Used by the routine at DETOKEN.
SET_REM_FLAG:
  LD A,(DORES)	; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
  OR $04
  JR UPD_OPRTYP

; Routine at 21260
DETOKEN:
  RLA
  JR C,_DETOKEN_NEXT
  LD A,(HL)
  CP TK_DATA
  CALL Z,SET_DATA_FLAG
  CP TK_REM
  CALL Z,SET_REM_FLAG
L531A:
  LD A,(HL)
  INC A	
  LD A,(HL)
  JR NZ,DETOKEN_0	; (HL-1) <> $FF ?
  INC HL			; (HL-1) == $FF ..
  LD A,(HL)
  AND $7F
DETOKEN_0:
  INC HL
  CP TK_ELSE
  JR NZ,DETOKEN_1
  DEC BC
  INC D
DETOKEN_1:
  PUSH HL
  PUSH BC
  PUSH DE
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HBUFL			; Hook for Detokenise event
ENDIF

  LD HL,WORDS-1
  LD B,A
  LD C,$40
DETOKEN_2:
  INC C
DETOKEN_3:
  INC HL
  LD D,H
  LD E,L
DETOKEN_4:
  LD A,(HL)
  OR A
  JR Z,DETOKEN_2
  INC HL
  JP P,DETOKEN_4
  LD A,(HL)
  CP B
  JR NZ,DETOKEN_3
  EX DE,HL
  LD A,C
  POP DE
  POP BC
  CP $5B		; '['
  JR NZ,DETOKEN_6
DETOKEN_5:
  LD A,(HL)
  INC HL
DETOKEN_6:
  LD E,A
  AND $7F
  LD (BC),A
  INC BC
  DEC D
  JP Z,TESTR_0
  OR E
  JP P,DETOKEN_5
  POP HL
  JP DETOKEN_NEXT_1

; Routine at 21345
L5361:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH DE
  PUSH BC
  PUSH AF
  CALL L46E6_0
  POP AF
  LD BC,L537E
  PUSH BC
  CP $0B			; Octal number constant prefix ?
  JP Z,OCT_STR
  CP $0C			; Hex numeric constant prefix ?
  JP Z,HEX_STR
  LD HL,(CONLO)		; Value of stored constant
  JP FOUT

; Routine at 21374
L537E:
  POP BC
  POP DE
  LD A,(CONSAV)
  LD E,'O'
  CP $0B			; Octal numeric constant prefix ?
  JR Z,L537E_0
  CP $0C			; Hex numeric constant prefix ?
  LD E,'H'
  JR NZ,L537E_1
L537E_0:
  LD A,'&'		; $26
  LD (BC),A
  INC BC
  DEC D
  RET Z
  LD A,E
  LD (BC),A
  INC BC
  DEC D
  RET Z
L537E_1:
  LD A,(CONTYP)			; Type of stored constant
  CP $04				; Single precision ?
  LD E,$00
  JR C,L537E_2
  LD E,'!'
  JR Z,L537E_2
  LD E,'#'
L537E_2:
  LD A,(HL)
  CP ' '
  JR NZ,L537E_3
  INC HL
L537E_3:
  LD A,(HL)
  INC HL
  OR A
  JR Z,L537E_6
  LD (BC),A
  INC BC
  DEC D
  RET Z
  LD A,(CONTYP)			; Type of stored constant
  CP $04			; Single precision ?
  JR C,L537E_3
  DEC BC
  LD A,(BC)
  INC BC
  JR NZ,L537E_4
  CP '.'			; $2E
  JR Z,L537E_5
L537E_4:
  CP $44			; 'D'
  JR Z,L537E_5
  CP $45			; 'E'
  JR NZ,L537E_3
L537E_5:
  LD E,$00
  JR L537E_3
  
L537E_6:
  LD A,E
  OR A
  JR Z,L537E_7
  LD (BC),A
  INC BC
  DEC D
  RET Z
L537E_7:
  LD HL,(CONTXT)
  JP DETOKEN_NEXT_1

; Routine at 21474
__DELETE:
  CALL LNUM_RANGE             ; Get specified line number range
  PUSH BC
  CALL LINE2PTR_00
  POP BC
  POP DE
  PUSH BC
  PUSH BC
  CALL SRCHLN		; Get first line number
  JR NC,__DELETE_0
  LD D,H
  LD E,L
  EX (SP),HL
  PUSH HL
  RST DCOMPR			; Compare HL with DE.
__DELETE_0:
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  LD HL,OK_MSG				; "Ok" Message
  CALL PRS
  POP BC
  LD HL,L4237
  EX (SP),HL
  ; --- START PROC L5405 ---
L5405:
  EX DE,HL
  LD HL,(VARTAB)
__DELETE_1:
  LD A,(DE)
  LD (BC),A
  INC BC
  INC DE
  RST DCOMPR		; Compare HL with DE.
  JR NZ,__DELETE_1
  LD H,B
  LD L,C
  LD (VARTAB),HL
  LD (ARYTAB),HL
  LD (STREND),HL
  RET

; Routine at 21532
__PEEK:
  CALL GETWORD_HL
  LD A,(HL)
  JP PASSA

; Routine at 21539
__POKE:
  CALL GETWORD
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  POP DE
  LD (DE),A
  RET

; Routine at 21551
;
; Used by the routines at GTWORD_GTINT, DEF_USR, __POKE, __CLEAR, ONGO and __TIME.
GETWORD:
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  EX DE,HL
  POP HL
  RET

; Routine at 21561
;
; Used by the routines at HEX_STR(BIN, OCT...), __PEEK, GETWORD and BSAVE_PARM.
GETWORD_HL:
  LD BC,__CINT
  PUSH BC
  RST GETYPR 		; Get the number type (FAC)
  RET M
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFRQI		; Hook for "convert to integer"
ENDIF
  CALL SIGN			; test FP number sign
  RET M
  CALL __CSNG
  LD BC,$3245		; BCDE = 32768 (float)
  LD DE,$8076
  CALL FCOMP
  RET C
  LD BC,$6545		; BCDE = 65536 (float)
  LD DE,$6053
  CALL FCOMP
  JP NC,OV_ERR			; Err $06 -  "Overflow"
  LD BC,$65C5		; BCDE = -65536 (float)
  LD DE,$6053
  JP FADD

; Data block at 21608
__RENUM:
  LD  BC,10
  PUSH BC
  LD  D,B
  LD  E,B
  JR  Z,__RENUM_2
  CP  ','
  JR  Z,__RENUM_1
  PUSH DE
  CALL LNUM_PARM		; Get specified line number
  LD  B,D
  LD  C,E

; Routine at 21626
__RENUM_0:
  POP DE
  JR Z,__RENUM_2
__RENUM_1:
  RST SYNCHR 			;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL LNUM_PARM		; Get specified line number
  JR Z,__RENUM_2
  POP AF
  RST SYNCHR 			;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH DE
  CALL ATOH				; Get specified line number
  JP NZ,SN_ERR
  LD A,D
  OR E
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  EX DE,HL
  EX (SP),HL
  EX DE,HL
__RENUM_2:
  PUSH BC
  CALL SRCHLN			; Get first line number
  POP DE
  PUSH DE
  PUSH BC
  CALL SRCHLN			; Get first line number
  LD H,B
  LD L,C
  POP DE
  RST DCOMPR			; Compare HL with DE.
  EX DE,HL
  JP C,FC_ERR			; Err $05 - "Illegal function call"
  POP DE
  POP BC
  POP AF
  PUSH HL
  PUSH DE
  JR __RENUM_4

; Routine at 21679
__RENUM_3:
  ADD HL,BC
  JP C,FC_ERR			; Err $05 - "Illegal function call"
  EX DE,HL
  PUSH HL
  LD HL,$FFF9		; -7
  RST DCOMPR		; Compare HL with DE.
  POP HL
  JP C,FC_ERR			; Err $05 - "Illegal function call"
; This entry point is used by the routine at __RENUM_0.
__RENUM_4:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  EX DE,HL
  POP DE
  JR Z,__RENUM_5
  LD A,(HL)
  INC HL
  OR (HL)
  DEC HL
  EX DE,HL
  JR NZ,__RENUM_3
__RENUM_5:
  PUSH BC
  CALL LINE2PTR_0
  POP BC
  POP DE
  POP HL
__RENUM_6:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  JR Z,LINE2PTR
  EX DE,HL
  EX (SP),HL
  EX DE,HL
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  ADD HL,BC
  EX DE,HL
  POP HL
  JR __RENUM_6

; Routine at 21738
;
; Used by the routines at __DELETE, __CLOAD and __CSAVE_1.
LINE2PTR_00:
  LD A,(PTRFLG)
  OR A
  RET Z
  JR LINE2PTR_1

  ; --- START PROC LINE2PTR ---
LINE2PTR:
  LD BC,RESTART
  PUSH BC
  DEFB $FE                ; 'CP $F6'  masking the next byte/instr.

LINE2PTR_0:
  DEFB $F6                ; 'OR $AF'  masking the next instruction
 
LINE2PTR_1:
  XOR A

LINE2PTR_2:
  LD (PTRFLG),A
  LD HL,(TXTTAB)    ; Start of program text
  DEC HL

LINE2PTR_3:
  INC HL
  LD A,(HL)         ; Get address of next line
  INC HL            
  OR (HL)           ; End of program found?
  RET Z             ; Yes - Line not found
  INC HL            
  LD E,(HL)         ; Get LSB of line number
  INC HL            
  LD D,(HL)         ; Get MSB of line number
LINE2PTR_4:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

; Line number to pointer
_LINE2PTR:
  OR A
  JR Z,LINE2PTR_3
  LD C,A
  LD A,(PTRFLG)
  OR A
  LD A,C
  JR Z,L556A
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSCNE		; Hook for 'Line number to pointer' event
ENDIF
  CP TK_ERROR
  JR NZ,_LINE2PTR_0

  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP TK_GOTO
  JR NZ,_LINE2PTR

  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $0E			; Line number prefix
  JR NZ,_LINE2PTR
  PUSH DE
  CALL LNUM_PARM_2
  LD A,D
  OR E
  JR NZ,_LINE2PTR_1
  JR _LINE2PTR_3

_LINE2PTR_0:
  CP $0E			; Line number prefix
  JR NZ,LINE2PTR_4
  PUSH DE
  CALL LNUM_PARM_2
_LINE2PTR_1:
  PUSH HL
  CALL SRCHLN	; Get first line number
  DEC BC
  LD A,$0D
  JR C,L556A_0
  CALL CONSOLE_CRLF
  LD HL,LINE_ERR_MSG
  PUSH DE
  CALL PRS
  POP HL
  CALL _PRNUM
  POP BC
  POP HL
  PUSH HL
  PUSH BC
  CALL LNUM_MSG
_LINE2PTR_2:
  POP HL
_LINE2PTR_3:
  POP DE
  DEC HL
; This entry point is used by the routine at L556A.
_LINE2PTR_4:
  JR LINE2PTR_4

; Message at 21850
LINE_ERR_MSG:
  DEFM "Undefined line "

; Unused
L5569:
  DEFS $01

; Routine at 21866
L556A:
  CP CR
  JR NZ,_LINE2PTR_4
  PUSH DE
  CALL LNUM_PARM_2
  PUSH HL
  EX DE,HL
  INC HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD A,$0E					; Line number prefix
; This entry point is used by the routine at LINE2PTR.
L556A_0:
  LD HL,_LINE2PTR_2
  PUSH HL
  LD HL,(CONTXT)
; This entry point is used by the routine at RUNLIN.
L556A_1:
  PUSH HL
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC HL
  LD (HL),A
  POP HL
  RET

; Routine at 21900
;
; Used by the routine at _SYNCHR.
__SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  INC HL
  EX (SP),HL
  JP NZ,SN_ERR
  JP __CHRGTB  ; Gets next character (or token) from BASIC text.

; Routine at 21911
;
; Used by the routine at _GETYPR.
; Return the number type (FAC)
; 
__GETYPR:
  LD A,(VALTYP)
  CP $08		; set M,PO.. flags
  JR NC,__GETYPR_0
  SUB $03		; String ?
  OR A
  SCF
  RET

__GETYPR_0:
  SUB $03		; String ?
  OR A
  RET

; Routine at 21927
L55A7:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
__CALL:
  LD DE,PROCNM
  LD B,$0F
L55A7_0:
  LD A,(HL)
  AND A
  JR Z,L55A7_1
  CP ':'
  JR Z,L55A7_1
  CP '('
  JR Z,L55A7_1
  LD (DE),A
  INC DE
  INC HL
  DJNZ L55A7_0
L55A7_1:
  LD A,B
  CP $0F		; Did we find 0, ':', or '(' at first position ?
  JR Z,L55A7_5
L55A7_2:		; No, skip spaces
  XOR A
  LD (DE),A
  DEC DE
  LD A,(DE)
  CP ' '
  JR Z,L55A7_2
  LD B,$40
  LD DE,SLTATR
L55A7_3:
  LD A,(DE)
  AND $20
  JR NZ,L55A7_6
L55A7_4:
  INC DE
  DJNZ L55A7_3
L55A7_5:
  JP SN_ERR
  
L55A7_6:
  PUSH BC
  PUSH DE
  PUSH HL
  CALL L7E2A
  PUSH AF
  LD C,A
  LD L,$04
  CALL RDSLT_WORD
  PUSH DE
  POP IX
  POP IY
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL CALSLT
  POP DE
  POP BC
  JR C,L55A7_4
  RET

; Routine at 22008
;
; Used by the routine at GET_DEVNAME.
; deal with exceptions/expansions
L55F8:
  POP HL
  LD A,B
  CP $10			; TK_INP ?
  JR C,L55F8_0
  LD B,$0F
L55F8_0:
  CALL L7FB7			; "RESUME NEXT"+1, copy in ROM  ??
L55F8_1:
  CALL UCASE_HL		; Load A with char in 'HL' and make it uppercase
  LD (DE),A
  INC HL
  INC DE
  DJNZ L55F8_1
  XOR A
  LD (DE),A
  LD B,$40
  LD DE,SLTATR
L55F8_2:
  LD A,(DE)
  AND $40
  JR NZ,L55F8_5
L55F8_3:
  INC DE
  DJNZ L55F8_2
L55F8_4:
  JP NM_ERR					; Err $38 -  'Bad file name'
  
L55F8_5:
  PUSH BC
  PUSH DE
  CALL L7E2A
  PUSH AF
  LD C,A
  LD L,$06
  CALL RDSLT_WORD
  PUSH DE
  POP IX
  POP IY
  LD A,$FF
  CALL CALSLT
  POP DE
  POP BC
  JR C,L55F8_3
  LD C,A
  LD A,$40
  SUB B
  ADD A,A
  ADD A,A
  OR C
  CP $09	; TK_SIN ?
  JR C,L55F8_4
  CP $FC		; TK_BKSLASH ?
  JR NC,L55F8_4
  POP HL
  POP DE
  AND A
  RET

; Routine at 22090
;
; Used by the routine at L6F85.
L564A:
  PUSH BC
  PUSH AF
  RRA
  RRA
  AND $3F
  CALL L7E2A_0
  PUSH AF
  LD C,A
  LD L,$06
  CALL RDSLT_WORD
  PUSH DE
  POP IX
  POP IY
  POP AF
  AND $03
  LD (DEVICE),A
  POP BC
  POP AF
  POP DE
  POP HL
  JP CALSLT


; Data block at 22124
DECODE_JPTAB:
  LD   (MCLTAB),DE
  CALL EVAL
  PUSH HL
  LD   DE,$0000
  PUSH DE
  PUSH AF
DECODE_JPTAB_0:
  CALL GETSTR
  CALL LOADFP
  LD   B,C
  LD   C,D
  LD   D,E
  LD   A,B
; Routine at 22147
L5683:
  OR C
  JR Z,DECODE_JPTAB_2
  LD A,D
  OR A
  JR Z,DECODE_JPTAB_2
  PUSH BC
  PUSH DE
DECODE_JPTAB_2:
  POP AF
  LD (MCLLEN),A
  POP HL
  LD A,H
  OR L
  JR NZ,L5683_1
  LD A,(MCLFLG)
  OR A
  JP Z,MCL_ITEM_1
  JP L748E_0


L5683_1:
  LD (MCLPTR),HL
; This entry point is used by the routines at L7439 and L7684.
L5683_2:
  CALL MCL_ITEM
  JR Z,DECODE_JPTAB_2
  ADD A,A
  LD C,A
  LD HL,(MCLTAB)
L5683_3:
  LD A,(HL)
  ADD A,A
L5683_4:
  CALL Z,FC_ERR			; Err $05 - "Illegal function call"
  CP C
  JR Z,L5683_5
  INC HL
  INC HL
  INC HL
  JR L5683_3

L5683_5:
  LD BC,L5683_2
  PUSH BC
  LD A,(HL)
  LD C,A
  ADD A,A
  JR NC,L5683_9
  OR A
  RRA
  LD C,A
  PUSH BC
  PUSH HL
  CALL MCL_ITEM
  LD DE,$0001
  JP Z,L5683_7
  CALL IS_ALPHA_A	; Check it is in the 'A'..'Z' range
  JP NC,L5683_6
  CALL L5719_0
  SCF
  JR L5683_8

L5683_6:
  CALL MCL_PREV_ITEM
L5683_7:
  OR A
L5683_8:
  POP HL
  POP BC
L5683_9:
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP (HL)
  

; This entry point is used by the routines at L5719, L575A and M_DIAGONAL.
GET_MCL_ITEM:
  CALL MCL_ITEM
  JR Z,L5683_4
  RET

; Routine at 22254
;
; Used by the routines at L5683, L5719, PLAY_NOTE and L7684.
MCL_ITEM:
  PUSH HL
MCL_ITEM_0:
  LD HL,MCLLEN
  LD A,(HL)
  OR A
  JR Z,MCL_ITEM_1
  DEC (HL)
  LD HL,(MCLPTR)
  LD A,(HL)
  INC HL
  LD (MCLPTR),HL
  CP $20	; ' ' ?
  JR Z,MCL_ITEM_0
  CP $60	; "'" ?
  JR C,MCL_ITEM_1
  SUB $20
; This entry point is used by the routine at L5683.
MCL_ITEM_1:
  POP HL
  RET

; Routine at 22283
;
; Used by the routines at L5683, L5719, M_DIAGONAL, PLAY_NOTE and L7684.
MCL_PREV_ITEM:
  PUSH HL
  LD HL,MCLLEN
  INC (HL)
  LD HL,(MCLPTR)
  DEC HL
  LD (MCLPTR),HL
  POP HL
  RET

; Routine at 22297
;
; Used by the routine at M_DIAGONAL.
L5719:
  CALL GET_MCL_ITEM
; This entry point is used by the routine at L5683.
L5719_0:
  CP '='
  JP Z,L577A
  CP '+'
  JR Z,L5719
  CP '-'
  JR NZ,L5719_1
  LD DE,L5795
  PUSH DE
  JR L5719
  
; This entry point is used by the routine at L7684.
L5719_1:
  LD DE,$0000
L5719_2:
  CP ','
  JR Z,MCL_PREV_ITEM
  CP ';'
  RET Z
  CP ':'
  JR NC,MCL_PREV_ITEM
  CP '0'
  JR C,MCL_PREV_ITEM

  LD HL,$0000
  LD B,$0A
MUL10:
  ADD HL,DE
  JR C,FC_ERR_D
  DJNZ MUL10
  
  SUB '0'
  LD E,A
  LD D,$00
  ADD HL,DE
  JR C,FC_ERR_D
  EX DE,HL
  CALL MCL_ITEM
  JR NZ,L5719_2
  RET

; Routine at 22362
;
; Used by the routines at L577A and X_MACRO.
L575A:
  CALL GET_MCL_ITEM
  LD DE,BUF
  PUSH DE
  LD B,$28	; '('
  CALL IS_ALPHA_A	; Check it is in the 'A'..'Z' range
  JR C,FC_ERR_D
L575A_0:
  LD (DE),A
  INC DE
  CP ';'		;$3B
  JR Z,L575A_2
  CALL GET_MCL_ITEM
  DJNZ L575A_0
; This entry point is used by the routine at L5719.
FC_ERR_D:
  CALL FC_ERR			; Err $05 - "Illegal function call"
L575A_2:
  POP HL
  JP EVAL_VARIABLE

; Routine at 22394
;
; Used by the routine at L5719.
L577A:
  CALL L575A
  CALL __CINT
  EX DE,HL
  RET

; Routine at 22402
;
; Used by the DRAW and PLAY routines.
;  Plays MML stored in string variable A$ *3 / Executes a drawing substring
X_MACRO:
  CALL L575A
  LD A,(MCLLEN)
  LD HL,(MCLPTR)
  EX (SP),HL
  PUSH AF
  LD C,$02
  CALL CHKSTK
  JP DECODE_JPTAB_0

; Routine at 22421
L5795:
  XOR A
  SUB E
  LD E,A
  SBC A,D
  SUB E
  LD D,A
  RET

; Routine at 22428
;
; Used by the routines at LINE, __PAINT, __CIRCLE and PUT_SPRITE.
COORD_PARMS:
  LD A,(HL)
  CP $40		; ?
  CALL Z,__CHRGTB  ; Gets next character (or token) from BASIC text.
  LD BC,$0000
  LD D,B
  LD E,C
  CP TK_MINUS		; Token for '-'
  JR Z,COORD_PARMS_1
; This entry point is used by the routines at __PSET and FN_POINT.
COORD_PARMS_DST:
  LD A,(HL)
  CP $DC		; TK_STEP ?
  PUSH AF
  CALL Z,__CHRGTB  ; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  CALL FPSINT
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL FPSINT
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  POP BC
  POP AF
COORD_PARMS_1:
  PUSH HL
  LD HL,(GRPACX)
  JR Z,COORD_PARMS_2
  LD HL,$0000
COORD_PARMS_2:
  ADD HL,BC
  LD (GRPACX),HL
  LD (GXPOS),HL
  LD B,H
  LD C,L
  LD HL,(GRPACY)
  JR Z,COORD_PARMS_3
  LD HL,$0000
COORD_PARMS_3:
  ADD HL,DE
  LD (GRPACY),HL
  LD (GYPOS),HL
  EX DE,HL
  POP HL
  RET

; Routine at 22501
__PRESET:
  LD A,(BAKCLR)
  JR __PSET_0

; Routine at 22506
__PSET:
  LD A,(FORCLR)
; This entry point is used by the routine at __PRESET.
__PSET_0:
  PUSH AF
  CALL COORD_PARMS_DST
  POP AF
  CALL PAINT_PARMS_0
DOPSET:
  PUSH HL
  CALL SCALXY
  JR NC,__PSET_1
  CALL MAPXY
  CALL SETC
__PSET_1:
  POP HL
  RET

; Routine at 22531
;
; Used by the routine at OPRND.
FN_POINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL FETCHC
  POP DE
  PUSH HL
  PUSH AF
  LD HL,(GYPOS)
  PUSH HL
  LD HL,(GXPOS)
  PUSH HL
  LD HL,(GRPACY)
  PUSH HL
  LD HL,(GRPACX)
  PUSH HL
  EX DE,HL
  CALL COORD_PARMS_DST
  PUSH HL
  CALL SCALXY
  LD HL,$FFFF
  JR NC,FN_POINT_0
  CALL MAPXY
  CALL READC
  LD L,A
  LD H,$00
FN_POINT_0:
  CALL INT_RESULT_HL
  POP DE
  POP HL
  LD (GRPACX),HL
  POP HL
  LD (GRPACY),HL
  POP HL
  LD (GXPOS),HL
  POP HL
  LD (GYPOS),HL
  POP AF
  POP HL
  PUSH DE
  CALL STOREC
  POP HL
  RET

; Routine at 22605
;
; Used by the routines at LINE, __PAINT and __CIRCLE.
PAINT_PARMS:
  LD A,(FORCLR)
; This entry point is used by the routine at __PSET.
PAINT_PARMS_0:
  PUSH BC
  PUSH DE
  LD E,A
  CALL ISGRPMODE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,PAINT_PARMS_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,PAINT_PARMS_1
  CALL GETINT
PAINT_PARMS_1:
  LD A,E
  PUSH HL
  CALL SETATR		; Set attribute byte
  JP C,FC_ERR			; Err $05 - "Illegal function call"
  POP HL
  POP DE
  POP BC
  JP __CHRCKB		; Gets current character (or token) from BASIC text.

; Routine at 22641
;
; Used by the routines at LINE and DRAW_LINE.
L5871:
  LD HL,(GXPOS)
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A
; This entry point is used by the routine at L5883.
L5871_0:
  RET NC
  
; This entry point is used by the routines at DRAW_LINE, L5A26, INVSGN_DE, L5C06 and
; M_DIAGONAL.
INVSGN_HL:
  XOR A
  SUB L		; Negate exponent
  LD L,A	; Re-save exponent
  SBC A,H
  SUB L
  LD H,A
  SCF
  RET

		
; Routine at 22659
;
; Used by the routines at LINE and DRAW_LINE.
L5883:
  LD HL,(GYPOS)
  ; HL=HL-DE
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  ;
  JR L5871_0

; Routine at 22670
;
; Used by the routines at L5898 and LINE.
L588E:
  PUSH HL
  LD HL,(GYPOS)
  EX DE,HL
  LD (GYPOS),HL
  POP HL
  RET

; Routine at 22680
;
; Used by the routines at LINE and DRAW_LINE.
L5898:
  CALL L588E
; This entry point is used by the routine at LINE.
L5898_0:
  PUSH HL
  PUSH BC
  LD HL,(GXPOS)
  EX (SP),HL
  LD (GXPOS),HL
  POP BC
  POP HL
  RET

; Routine at 22695
;
; Used by the routine at __LINE.
LINE:
  CALL COORD_PARMS
  PUSH BC
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_MINUS		; Token for '-'
  CALL COORD_PARMS_DST
  CALL PAINT_PARMS
  POP DE
  POP BC
  JR Z,DOTLINE
  
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'B'
  JP Z,BOXLIN
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'F'			; 'BOX FILLED'
DOBOXF:
  PUSH HL
  CALL SCALXY
  CALL L5898
  CALL SCALXY
  CALL L5883
  CALL C,L588E
  INC HL
  PUSH HL
  CALL L5871
  CALL C,L5898_0
  INC HL
  PUSH HL
  CALL MAPXY
  POP DE
  POP BC
LINE_0:
  PUSH DE
  PUSH BC
  CALL FETCHC
  PUSH AF
  PUSH HL
  EX DE,HL
  CALL NSETCX
  POP HL
  POP AF
  CALL STOREC
  CALL DOWNC
  POP BC
  POP DE
  DEC BC
  LD A,B
  OR C
  JR NZ,LINE_0
  POP HL
  RET
  
DOTLINE:
  PUSH BC
  PUSH DE
  PUSH HL
  CALL DRAW_LINE
  LD HL,(GRPACX)
  LD (GXPOS),HL
  LD HL,(GRPACY)
  LD (GYPOS),HL
  POP HL
  POP DE
  POP BC
  RET
  
BOXLIN:
  PUSH HL
  LD HL,(GYPOS)
  PUSH HL
  PUSH DE
  EX DE,HL
  CALL DOTLINE
  POP HL
  LD (GYPOS),HL
  EX DE,HL
  CALL DOTLINE
  POP HL
  LD (GYPOS),HL
  LD HL,(GXPOS)
  PUSH BC
  LD B,H
  LD C,L
  CALL DOTLINE
  POP HL
  LD (GXPOS),HL
  LD B,H
  LD C,L
  CALL DOTLINE
  POP HL
  RET

; Routine at 22844
;
; Used by the routines at LINE and DRAW_LINE_GRPAC.
DRAW_LINE:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDOGR			; Hook for line drawing event
ENDIF
  CALL SCALXY
  CALL L5898
  CALL SCALXY
  CALL L5883
  CALL C,L5898
  PUSH DE
  PUSH HL
  CALL L5871
  EX DE,HL
  LD HL,RIGHTC
  JR NC,DRAW_LINE_0
  LD HL,LEFTC
DRAW_LINE_0:
  EX (SP),HL
  RST DCOMPR		; Compare HL with DE.
  JR NC,DRAW_LINE_1
  LD (MINDEL),HL
  POP HL
  LD (MAXUPD+1),HL	; MAXUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
  LD HL,DOWNC
  LD (MINUPD+1),HL	; MINUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
  EX DE,HL
  JR DRAW_LINE_2
DRAW_LINE_1:
  EX (SP),HL
  LD (MINUPD+1),HL	; MINUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
  LD HL,DOWNC
  LD (MAXUPD+1),HL	; MAXUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
  EX DE,HL
  LD (MINDEL),HL
  POP HL
DRAW_LINE_2:
  POP DE
  PUSH HL
  CALL INVSGN_HL
  LD (MAXDEL),HL
  CALL MAPXY
  POP DE
  PUSH DE
  CALL L59B4		; "RR DE"
  POP BC
  INC BC
  JR L5993_1

; Routine at 22931
L5993:
  POP HL
  LD A,B
  OR C
  RET Z
L5993_0:
  CALL MAXUPD
; This entry point is used by the routine at DRAW_LINE.
L5993_1:
  CALL SETC
  DEC BC
  PUSH HL
  LD HL,(MINDEL)
  ADD HL,DE
  EX DE,HL
  LD HL,(MAXDEL)
  ADD HL,DE
  JR NC,L5993
  EX DE,HL
  POP HL
  LD A,B
  OR C
  RET Z
  CALL MINUPD		; MINUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
  JR L5993_0

; Routine at 22964
;
; "RR DE" - Used by the routines at DRAW_LINE, __CIRCLE and L5E66.
L59B4:
  LD A,D
  OR A
  RRA
  LD D,A
  LD A,E
  RRA
  LD E,A
  RET

; Routine at 22972
;
; Used by the routine at PAINT_PARMS.
ISGRPMODE:
  LD A,(SCRMOD)
  CP $02
  RET P
  JP FC_ERR			; Err $05 - "Illegal function call"

; Routine at 22981
__PAINT:
  CALL COORD_PARMS
  PUSH BC
  PUSH DE
  CALL PAINT_PARMS
  LD A,(ATRBYT)
  LD E,A
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__PAINT_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
__PAINT_0:
  LD A,E
  CALL PNTINI
  JP C,FC_ERR			; Err $05 - "Illegal function call"
  POP DE
  POP BC
O_PAINT:
  PUSH HL
  CALL L5E91
  CALL MAPXY
  LD DE,$0001
  LD B,$00
  CALL L5ADC
  JR Z,__PAINT_1
  PUSH HL
  CALL L5AED
  POP DE
  ADD HL,DE
  EX DE,HL
  XOR A
  CALL L5AC2_0
  LD A,$40
  CALL L5AC2_0
  LD B,$C0
  JR L5A26

; This entry point is used by the routines at L5A26 and __CIRCLE.
__PAINT_1:
  POP HL
  RET

; Data block at 23050
L5A0A:
  CALL CKCNTC
  LD   A,(LOHDIR)
  OR   A
  JR   Z,L5A1F
  LD   HL,(LOHADR)
  PUSH HL
  LD   HL,(LOHMSK)
  PUSH HL
  LD   HL,(LOHCNT)
  PUSH HL
L5A1F:
  POP  DE
  POP  BC
  POP  HL
  LD   A,C
  CALL STOREC

L5A26:
  LD  A,B
  LD  (PDIREC),A  ; Direction of the paint
  ADD A,A
  JR Z,__PAINT_1
  PUSH DE
  JR NC,L5A26_0
  CALL TUPC
  JR L5A26_1
L5A26_0:
  CALL TDOWNC
L5A26_1:
  POP DE
  JR C,L5A1F
  LD B,$00
  CALL L5ADC
  JP Z,L5A1F
  XOR A
  LD (LOHDIR),A
  CALL L5AED
  LD E,L
  LD D,H
  OR A
  JR Z,L5A26_2
  DEC HL
  DEC HL
  LD A,H
  ADD A,A
  JR C,L5A26_2
  LD (LOHCNT),DE
  CALL FETCHC
  LD (LOHADR),HL
  LD (LOHMSK),A
  LD A,(PDIREC)
  CPL
  LD (LOHDIR),A
L5A26_2:
  LD HL,(MOVCNT)
  ADD HL,DE
  EX DE,HL
  CALL L5AC2
; This entry point is used by the routine at CRT_CTL.
L5A26_3:
  LD HL,(CSAVEA)
  LD A,(CSAVEM)
  CALL STOREC
L5A26_4:
  LD HL,(SKPCNT)
  LD DE,(MOVCNT)
  OR A
  SBC HL,DE
  JR Z,L5A26_7
  JR C,L5A26_5
  EX DE,HL
  LD B,$01
  CALL L5ADC
  JR Z,L5A26_7
  OR A
  JR Z,L5A26_4
  EX DE,HL
  LD HL,(CSAVEA)
  LD A,(CSAVEM)
  LD C,A
  LD A,(PDIREC)
  LD B,A
  CALL L5AC2_1
  JR L5A26_4
L5A26_5:
  CALL INVSGN_HL
  DEC HL
  DEC HL
  LD A,H
  ADD A,A
  JR C,L5A26_7
  INC HL
  PUSH HL
L5A26_6:
  CALL LEFTC
  DEC HL
  LD A,H
  OR L
  JR NZ,L5A26_6
  POP DE
  LD A,(PDIREC)
  CPL
  CALL L5AC2_0
L5A26_7:
  JP L5A0A

; Routine at 23234
;
; Used by the routine at L5A26.
L5AC2:
  LD A,(LFPROG)
  LD C,A
  LD A,(RTPROG)
  OR C
  RET Z
  LD A,(PDIREC)
; This entry point is used by the routines at __PAINT and L5A26.
L5AC2_0:
  LD B,A
  CALL FETCHC
  LD C,A
; This entry point is used by the routine at L5A26.
L5AC2_1:
  EX (SP),HL
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,$02
  JP CHKSTK

; Data block at 23260
L5ADC:
  CALL SCANR
  LD   (SKPCNT),DE	; Skip count
  LD   (MOVCNT),HL
  LD   A,H
  OR   L
  LD   A,C
  LD   (RTPROG),A
  RET


; Data block at 23277
L5AED:
  CALL FETCHC
  PUSH HL
  PUSH AF
  LD   HL,(CSAVEA)
  LD   A,(CSAVEM)
  CALL STOREC
  POP  AF
  POP  HL
  LD   (CSAVEA),HL
  LD   (CSAVEM),A
  CALL SCANL
  LD   A,C
  LD   (LFPROG),A
  RET
		

; Routine at 23307
;
; Used by the routines at L5C06, U_LINE, L_LINE, H_DIAGONAL, E_DIAGONAL, G_DIAGONAL and M_DIAGONAL.
INVSGN_DE:
  EX DE,HL
  CALL INVSGN_HL
  EX DE,HL
  RET

; Routine at 23313
__CIRCLE:
  CALL COORD_PARMS
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL FPSINT
DO_CIRC:
  PUSH HL
  EX DE,HL
  LD (GXPOS),HL
  CALL INT_RESULT_HL
  CALL __CSNG
  LD BC,$7040		; BCDE = 0.707107
  LD DE,$0771
  CALL FMULT
  CALL __CINT
  LD (CNPNTS),HL
  XOR A
  LD (CLINEF),A
  LD (CSCLXY),A
  POP HL
  CALL PAINT_PARMS
  LD C,$01
  LD DE,$0000
  CALL CIRCLE_SUB
  PUSH DE
  LD C,$80
  LD DE,$FFFF
  CALL CIRCLE_SUB
  EX (SP),HL
  XOR A
  EX DE,HL
  RST DCOMPR		; Compare HL with DE.
  LD A,$00
  JR NC,__CIRCLE_0
  DEC A
  EX DE,HL
  PUSH AF
  LD A,(CLINEF)
  LD C,A
  RLCA
  RLCA
  OR C
  RRCA
  LD (CLINEF),A
  POP AF
__CIRCLE_0:
  LD (CPLOTF),A
  LD (CSTCNT),DE
  LD (CENCNT),HL
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR NZ,__CIRCLE_1
  PUSH HL
  CALL GTASPC
  LD A,H
  OR A
  JR Z,__CIRCLE_3
  LD A,$01
  LD (CSCLXY),A
  EX DE,HL
  JR __CIRCLE_3
__CIRCLE_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  PUSH HL
  CALL __CSNG
  CALL SIGN			; test FP number sign
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  JP M,FC_ERR			; Err $05 - "Illegal function call"
  CALL FCOMP_UNITY		; == 1 ?
  JR NZ,__CIRCLE_2
  INC A
  LD (CSCLXY),A
  CALL FDIV
__CIRCLE_2:
  LD BC,$2543			; BCDE = 256 (float)
  LD DE,$0060
  CALL FMULT
  CALL __CINT
__CIRCLE_3:
  LD (ASPECT),HL
  LD DE,$0000
  LD (CRCSUM),DE
  LD HL,(GXPOS)
  ADD HL,HL
__CIRCLE_4:
  CALL CKCNTC
  LD A,E
  RRA
  JR C,__CIRCLE_5
  PUSH DE
  PUSH HL
  INC HL
  EX DE,HL
  CALL L59B4		; "RR DE"
  EX DE,HL
  INC DE
  CALL L59B4		; "RR DE"
  CALL L5C06
  POP DE
  POP HL
  RST DCOMPR		; Compare HL with DE.
  JP NC,__PAINT_1
  EX DE,HL
__CIRCLE_5:
  LD B,H
  LD C,L
  LD HL,(CRCSUM)
  INC HL
  ADD HL,DE
  ADD HL,DE
  LD A,H
  ADD A,A
  JR C,__CIRCLE_6
  PUSH DE
  EX DE,HL
  LD H,B
  LD L,C
  ADD HL,HL
  DEC HL
  EX DE,HL
  OR A
  SBC HL,DE
  DEC BC
  POP DE
__CIRCLE_6:
  LD (CRCSUM),HL
  LD H,B
  LD L,C
  INC DE
  JR __CIRCLE_4

; Routine at 23546
;
; Used by the routine at L5C06.
L5BFA:
  PUSH DE
  CALL L5CEB
  POP HL
  LD A,(CSCLXY)
  OR A 
  RET Z
  EX DE,HL
  RET

; Routine at 23558
;
; Used by the routine at __CIRCLE.
L5C06:
  LD (CPCNT),DE
  PUSH HL
  LD HL,$0000
  LD (CPCNT8),HL
  CALL L5BFA
  LD (CXOFF),HL
  POP HL
  EX DE,HL
  PUSH HL
  CALL L5BFA
  LD (CYOFF),DE
  POP DE
  CALL INVSGN_DE
  CALL L5C06_0
  PUSH HL
  PUSH DE
  LD HL,(CNPNTS)
  LD (CPCNT8),HL
  LD DE,(CPCNT)
  OR A
  SBC HL,DE
  LD (CPCNT),HL
  LD HL,(CXOFF)
  CALL INVSGN_HL
  LD (CXOFF),HL
  POP DE
  POP HL
  CALL INVSGN_DE
L5C06_0:
  LD A,$04
L5C06_1:
  PUSH AF
  PUSH HL
  PUSH DE
  PUSH HL
  PUSH DE
  LD DE,(CPCNT8)
  LD HL,(CNPNTS)
  ADD HL,HL
  ADD HL,DE
  LD (CPCNT8),HL
  LD HL,(CPCNT)
  ADD HL,DE
  EX DE,HL
  LD HL,(CSTCNT)
  RST DCOMPR		; Compare HL with DE.
  JR Z,L5C06_4
  JR NC,L5C06_2
  LD HL,(CENCNT)
  RST DCOMPR		; Compare HL with DE.
  JR Z,L5C06_3
  JR NC,L5C06_6
L5C06_2:
  LD A,(CPLOTF)
  OR A
  JR NZ,L5C06_8
  JR L5C06_7
L5C06_3:
  LD A,(CLINEF)
  ADD A,A
  JR NC,L5C06_8
  JR L5C06_5
L5C06_4:
  LD A,(CLINEF)
  RRA
  JR NC,L5C06_8
L5C06_5:
  POP DE
  POP HL
  CALL CALC_POSITION
  CALL DRAW_LINE_GRPAC
  JR L5C06_9
  
L5C06_6:
  LD A,(CPLOTF)
  OR A
  JR Z,L5C06_8
L5C06_7:
  POP DE
  POP HL
  JR L5C06_9
L5C06_8:
  POP DE
  POP HL
  CALL CALC_POSITION
  CALL SCALXY
  JR NC,L5C06_9
  CALL MAPXY
  CALL SETC
L5C06_9:
  POP DE
  POP HL
  POP AF
  DEC A
  RET Z
  PUSH AF
  PUSH DE
  LD DE,(CXOFF)
  CALL INVSGN_DE
  LD (CXOFF),HL
  EX DE,HL
  POP DE
  PUSH HL
  LD HL,(CYOFF)
  EX DE,HL
  LD (CYOFF),HL
  CALL INVSGN_DE
  POP HL
  POP AF
  JP L5C06_1

; Routine at 23757
;
; Used by the routines at L5C06 and M_DIAGONAL.
DRAW_LINE_GRPAC:
  LD HL,(GRPACX)
  LD (GXPOS),HL
  LD HL,(GRPACY)
  LD (GYPOS),HL
  JP DRAW_LINE

; Routine at 23772
;
; Used by the routines at L5C06 and M_DIAGONAL.
CALC_POSITION:
  PUSH DE
  LD DE,(GRPACX)
  ADD HL,DE
  LD B,H
  LD C,L
  POP DE
  LD HL,(GRPACY)
  ADD HL,DE
  EX DE,HL
  RET

; Routine at 23787
;
; Used by the routine at L5BFA.
L5CEB:
  LD HL,(ASPECT)
  LD A,L
  OR A
  JR NZ,L5CEB_0
  OR H
  RET NZ
  EX DE,HL
  RET

L5CEB_0:
  LD C,D
  LD D,$00
  PUSH AF
  CALL L5D0A
  LD E,$80
  ADD HL,DE
  LD E,C
  LD C,H
  POP AF
  CALL L5D0A
  LD E,C
  ADD HL,DE
  EX DE,HL
  RET

; Routine at 23818
;
; Used by the routine at L5CEB.
L5D0A:
  LD B,$08
  LD HL,$0000
L5D0A_0:
  ADD HL,HL
  ADD A,A
  JR NC,L5D0A_1
  ADD HL,DE
L5D0A_1:
  DJNZ L5D0A_0
  RET

; Routine at 23831
;
; Used by the routine at __CIRCLE.
CIRCLE_SUB:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  RET Z
  PUSH BC
  CALL EVAL
  EX (SP),HL
  PUSH HL
  CALL __CSNG
  POP BC
  LD HL,FACCU
  LD A,(HL)
  OR A
  JP P,CIRCLE_SUB_0
  AND $7F
  LD (HL),A
  LD HL,CLINEF
  LD A,(HL)
  OR C
  LD (HL),A
CIRCLE_SUB_0:
  LD BC,$1540			; BCDE = 0.159155
  LD DE,$5591
  CALL FMULT
  CALL FCOMP_UNITY		; == 1 ?
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  CALL STAKI
  LD HL,(CNPNTS)
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  CALL INT_RESULT_HL
  CALL __CSNG
  POP BC
  POP DE
  CALL FMULT
  CALL __CINT
  POP DE
  EX DE,HL
  RET

; Routine at 23907
;
; Used by the routines at __CIRCLE and CIRCLE_SUB.
FCOMP_UNITY:
  LD BC,$1041		; BCDE = 1 (float) 
  LD DE,$0000
  CALL FCOMP
  DEC A
  RET

; Routine at 23918
__DRAW:
  LD A,(SCRMOD)
  CP $02
  JP C,FC_ERR			; Err $05 - "Illegal function call"
  LD DE,DRAW_TAB
  XOR A
  LD (DRWFLG),A
  LD (MCLFLG),A
  JP DECODE_JPTAB



; Routine at 23939
; JP table for the Graphics Macro Language (GML)
;$5D83
DRAW_TAB:

  DEFB 'U'+$80
  DEFW U_LINE	; Draw a line of <DE> pixels in a straight upward direction

  DEFB 'D'+$80
  DEFW D_LINE	; Draw a line of <DE> pixels in a straight downward direction

  DEFB 'L'+$80
  DEFW L_LINE	; Draw a line of <DE> pixels to the left

  DEFB 'R'+$80
  DEFW R_LINE	; Draw a line of <DE> pixels to the right

  DEFB 'M'
  DEFW M_DIAGONAL	; Draw a line to a specific location (x,y) or a location relative to the current position (M+20,-20)

  DEFB 'E'+$80
  DEFW E_DIAGONAL	; Draw a diagonal line of <DE> pixels (line goes upward and to the right)

  DEFB 'F'+$80
  DEFW F_DIAGONAL	; Draw a diagonal line of <DE> pixels (line goes downward and to the right)

  DEFB 'G'+$80
  DEFW G_DIAGONAL	; Draw a diagonal line of <DE> pixels (line goes downward and to the left)

  DEFB 'H'+$80
  DEFW H_DIAGONAL	; Draw a diagonal line of <DE> pixels (line goes upward and to the left)

  DEFB 'A'+$80
  DEFW ROTATE	; Change the orientation of the drawing to 0 (normal), 1 (90 degrees clockwise), 2 (180 degrees clockwise) or 3 (270 degrees clockwise)

  DEFB 'B'
  DEFW MOVEONLY	; Move to the location specified by the command, but don't draw a line 

  DEFB 'N'
  DEFW KEEP_POS	; Return to the starting position after performing the command 

  DEFB 'X'
  DEFW X_MACRO	; X<string> Execute a sub-string of instructions 

  DEFB 'C'+$80
  DEFW FORECOLOR	; Change the foreground (drawing) color to <color>
  
  DEFB 'S'+$80
  DEFW SCALE	; S<scale> Scale every length specified after this command by <scale/4> pixels.
  
  DEFB $00		; Table termination

  
  
  
  
; Draw a line of <DE> pixels in a straight upward direction
U_LINE:
  CALL INVSGN_DE
; Draw a line of <DE> pixels in a straight downward direction
D_LINE:
  LD BC,$0000
  JR LINE_SUB

; Routine at 23993
;
; Used by the routine at L5D83.
; Draw a line of <DE> pixels to the left
L_LINE:
  CALL INVSGN_DE
; Draw a line of <DE> pixels to the right
R_LINE:
  LD B,D
  LD C,E
  LD DE,$0000
  JR LINE_SUB

; Routine at 24003
; Draw a diagonal line of <DE> pixels (line goes upward and to the left)
H_DIAGONAL:
  CALL INVSGN_DE
; Draw a diagonal line of <DE> pixels (line goes downward and to the right)
F_DIAGONAL:
  LD B,D
  LD C,E
  JR LINE_SUB

; Routine at 24010
; Draw a diagonal line of <DE> pixels (line goes upward and to the right)
E_DIAGONAL:
  LD B,D
  LD C,E
; This entry point is used by the routine at G_DIAGONAL.
E_DIAGONAL_0:
  CALL INVSGN_DE
  JR LINE_SUB

; Routine at 24017
; Draw a diagonal line of <DE> pixels (line goes downward and to the left)
G_DIAGONAL:
  CALL INVSGN_DE
  LD B,D
  LD C,E
  JR E_DIAGONAL_0

; Routine at 24024
; Draw a line to a specific location (x,y) or a location relative to the current position (M+20,-20)
M_DIAGONAL:
  CALL GET_MCL_ITEM
  LD B,$00
  CP '+'
  JR Z,M_DIAGONAL_0
  CP '-'
  JR Z,M_DIAGONAL_0
  INC B
M_DIAGONAL_0:
  LD A,B
  PUSH AF
  CALL MCL_PREV_ITEM
  CALL L5719
  PUSH DE
  CALL GET_MCL_ITEM
  CP ','
  JP NZ,FC_ERR			; Err $05 - "Illegal function call"
  CALL L5719
  POP BC
  POP AF
  OR A
  JR NZ,LINE_SUB_4
  

; This entry point is used by the DRAW routines at U_LINE, L_LINE, H_DIAGONAL and E_DIAGONAL.
LINE_SUB:
  CALL L5E66
  PUSH DE
  LD D,B
  LD E,C
  CALL L5E66
  EX DE,HL
  POP DE
  LD A,(DRWANG)
  RRA
  JR NC,LINE_SUB_2
  PUSH AF
  CALL INVSGN_HL
  EX DE,HL
  POP AF
LINE_SUB_2:
  RRA
  JR NC,LINE_SUB_3
  CALL INVSGN_HL
  CALL INVSGN_DE
LINE_SUB_3:
  CALL CALC_POSITION

LINE_SUB_4:
  LD A,(DRWFLG)
  ADD A,A
  JR C,MOVEONLY_MODE
  PUSH AF
  PUSH BC
  PUSH DE
  CALL DRAW_LINE_GRPAC
  POP DE
  POP BC
  POP AF
MOVEONLY_MODE:
  ADD A,A			; KEEP_POS mode ?
  JR C,NO_REPOS		; If so, jump over
  LD (GRPACY),DE
  LD H,B
  LD L,C
  LD (GRPACX),HL
NO_REPOS:
  XOR A					; Reset draw mode when finished drawing
  LD (DRWFLG),A
  RET

; Routine at 24130
; Set flags to return to the starting position after performing the command 
KEEP_POS:
  LD A,$40
  JR SET_DRWFLG

; Routine at 24134
; Set flags to move to the location specified by the command, but don't draw a line 
MOVEONLY:
  LD A,$80
; This entry point is used by the routine at KEEP_POS.
SET_DRWFLG:
  LD HL,DRWFLG
  OR (HL)
  LD (HL),A
  RET

; Data block at 24142
; Change the orientation of the drawing to 0 (normal), 1 (90 degrees clockwise), 2 (180 degrees clockwise) or 3 (270 degrees clockwise)
ROTATE:
  JR NC,SCALE
  LD A,E
  CP $04
  JR NC,SCALE
  LD (DRWANG),A		; DrawAngle (0..3): 1=90 degrees rotation .. 3=270 degrees, etc..
  RET

; S<scale> Scale every length specified after this command by <scale/4> pixels.
SCALE:
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  LD A,D
  OR A
  JP NZ,FC_ERR			; Err $05 - "Illegal function call"
  LD A,E
  LD (DRWSCL),A			; Draw Scaling
  RET

; Routine at 24166
;
; Used by the routine at M_DIAGONAL.
L5E66:
  LD A,(DRWSCL)
  OR A
  RET Z
  LD HL,$0000
L5E66_0:
  ADD HL,DE
  DEC A
  JR NZ,L5E66_0
  EX DE,HL
  LD A,D
  ADD A,A
  PUSH AF
  JR NC,L5E66_1
  DEC DE
L5E66_1:
  CALL L59B4		; "RR DE"
  CALL L59B4		; "RR DE"
  POP AF
  RET NC
  LD A,D
  OR $C0
  LD D,A
  INC DE
  RET



FORECOLOR:
  JR NC,SCALE
  LD A,E
  CALL SETATR		; Set attribute byte
  JP C,FC_ERR			; Err $05 - "Illegal function call"
  RET

; Routine at 24209
;
; Used by the routine at __PAINT.
L5E91:
  PUSH HL
  CALL SCALXY
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  POP HL
  RET

  
DIMRET:
  DEC HL            ; DEC 'cos GETCHR INCs
  RST CHRGTB		; Get next character
  RET Z             ; End of DIM statement
  RST SYNCHR 		; Make sure "," follows
  DEFB ','
  
__DIM:
  LD BC,DIMRET
  PUSH BC

  DEFB $F6			; "OR n" to Mask 'XOR A' (Flag "Create" variable)

; Get variable address to DE (AKA PTRGET)
;
; Used by the routines at __LET, __LINE, __READ, OPRND, __DEF, DOFN, _GETVAR,
; __SWAP and __NEXT.
GETVAR:
  XOR A				; Find variable address,to DE
  LD (DIMFLG),A		; Set locate / create flag
  LD C,(HL)			; Get First byte of name
  
; This entry point is used by the routine at CHEKFN.
GTFNAM:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPTRG		;  Hook for Variable search event
ENDIF
  CALL IS_ALPHA  	; See if a letter
  JP C,SN_ERR       ; ?SN Error if not a letter
  XOR A
  LD B,A            ; Clear second byte of name
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR C,SVNAM2
  CALL IS_ALPHA_A	; Check it is in the 'A'..'Z' range
  JR C,GETVAR_3
SVNAM2:
  LD B,A
ENDNAM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR C,ENDNAM
  CALL IS_ALPHA_A	; Check it is in the 'A'..'Z' range
  JR NC,ENDNAM
GETVAR_3:
  CP '%'+1
  JR NC,GETVAR_4
  LD DE,GVAR
  PUSH DE
  LD D,$02
  CP '%'
  RET Z
  INC D
  CP '$'
  RET Z
  INC D
  CP '!'
  RET Z
  LD D,$08
  CP '#'
  RET Z
  POP AF
GETVAR_4:
  LD A,C
  AND $7F
  LD E,A
  LD D,$00
  PUSH HL
  LD HL,VARIABLES
  ADD HL,DE
  LD D,(HL)
  POP HL
  DEC HL
  
GVAR:
  LD A,D
  LD (VALTYP),A     ; Set variable type
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,(SUBFLG)     ; Array name needed ?
  DEC A             
  JP Z,ARLDSV       ; Yes - Get array name
  JP P,NSCFOR       ; No array with "FOR" or "FN"
  LD A,(HL)         ; Get byte again
  SUB $28			; "(" ..Subscripted variable?
  JP Z,SBSCPT       ; Yes - Sort out subscript
  SUB $33			; ($28+$33)="[" ..Subscripted variable?
  JP Z,SBSCPT       ; Yes - Sort out subscript
  
NSCFOR:
  XOR A
  LD (SUBFLG),A
  PUSH HL
  LD A,(NOFUNS)			; 0 if no function active
  OR A
  LD (PRMFLG),A
  JR Z,GVAR_4
  LD HL,(PRMLEN)
  LD DE,PARM1
  ADD HL,DE
  LD (ARYTA2),HL
  EX DE,HL
  JR GVAR_3

; Routine at 24355
GVAR_1:
  LD A,(DE)
  LD L,A
  INC DE
  LD A,(DE)
  INC DE
  CP C
  JR NZ,GVAR_2
  LD A,(VALTYP)
  CP L
  JR NZ,GVAR_2
  LD A,(DE)
  CP B
  JP Z,ENDNAM0_1

GVAR_2:
  INC DE
  LD H,$00
  ADD HL,DE
  
GVAR_3:
  EX DE,HL
  LD A,(ARYTA2)
  CP E
  JP NZ,GVAR_1
  LD A,(ARYTA2+1)
  CP D
  JR NZ,GVAR_1
  LD A,(PRMFLG)
  OR A
  JR Z,ENDNAM0
  XOR A
  LD (PRMFLG),A

GVAR_4:
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)
  JR GVAR_3

; Routine at 24413
;
; Used by the routine at VARPTR.
_GETVAR:
  CALL GETVAR
_GETVAR_RET:
  RET

; Routine at 24417
;
; Used by the routine at ENDNAM0.
L5F61:
  LD D,A
  LD E,A
  POP BC
  EX (SP),HL
  RET

; Routine at 24422
;
; Used by the routine at GVAR_1.
ENDNAM0:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,_GETVAR_RET		; Just points to 'RET'
  RST DCOMPR		; Compare HL with DE.
  JR Z,L5F61
  
  LD DE,EVAL_VARIABLE_1
  RST DCOMPR		; Compare HL with DE.
  POP DE
  JR Z,ENDNAM0_2
  EX (SP),HL
  PUSH HL
  PUSH BC
  LD A,(VALTYP)
  LD C,A
  PUSH BC
  LD B,$00
  INC BC
  INC BC
  INC BC
  LD HL,(STREND)
  PUSH HL
  ADD HL,BC
  POP BC
  PUSH HL
  CALL L6250
  POP HL
  LD (STREND),HL
  LD H,B
  LD L,C
  LD (ARYTAB),HL
ENDNAM0_0:
  DEC HL
  LD (HL),$00
  RST DCOMPR		; Compare HL with DE.
  JR NZ,ENDNAM0_0
  POP DE
  LD (HL),E
  INC HL
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
; This entry point is used by the routine at GVAR_1.
ENDNAM0_1:
  INC DE
  POP HL
  RET
  

ENDNAM0_2:
  LD (FACCU),A
  LD H,A
  LD L,A
  LD (FACLOW),HL
  RST GETYPR 		; Get the number type (FAC)
  JR NZ,ENDNAM0_3		; JP if not string type, 
  LD HL,NULL_STRING
  LD (FACLOW),HL
ENDNAM0_3:
  POP HL
  RET


; Sort out subscript
; Data block at 24506
;
; Used by the routine at GETVAR.
SBSCPT:
  PUSH HL			; Save code string address
  LD HL,(DIMFLG)
  EX (SP),HL		; Save and get code string
  LD D,A			; Zero number of dimensions
SCPTLP:
  PUSH DE			; Save number of dimensions
  PUSH BC			; Save array name
  CALL GET_POSINT		; Get subscript
  POP BC
  POP AF			; Get number of dimensions
  EX DE,HL
  EX (SP),HL		; Save subscript value
  PUSH HL			; Save LCRFLG and TYPE (DIMFLAG)
  EX DE,HL
  INC A				; Count dimensions
  LD D,A			; Save in D
  LD A,(HL)			; Get next byte in code string
  CP ','
  JP Z,SCPTLP
  CP ')'
  JR Z,SCPTLP_0
  CP ']'
  JP NZ,SN_ERR
SCPTLP_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

L5FDD:
  LD (NXTOPR),HL		; Next operator in EVAL
  POP HL
  LD (DIMFLG),HL
  LD E,$00
  PUSH DE
  
  ;LD DE,$F5E5
  defb $11	

ARLDSV:
  PUSH HL            ; Save code string address
  PUSH AF            ; A = 00 , Flags set = Z,N
  LD HL,(ARYTAB)     ; Start of arrays

  DEFB $3E  ; "LD A,n" to Mask the next byte  (skip "ADD HL,DE")

FNDARY:
  ADD HL,DE          ; Move to next array start
  LD DE,(STREND)     ; End of arrays
  RST DCOMPR		 ; Compare HL with DE.
  JR Z,CREARY        ; Yes - Create array
  LD E,(HL)          ; Get type
  INC HL             ; Move on
  LD A,(HL)          ; Get second byte of name
  INC HL             ; Move on
  CP C               ; Compare with name given (second byte)
  JR NZ,NXTARY       ; Different - Find next array
  LD A,(VALTYP)
  CP E               ; Compare type
  JR NZ,NXTARY       ; Different - Find next array
  LD A,(HL)          ; Get first byte of name
  CP B               ; Compare with name given (first byte)
NXTARY:
  INC HL
  LD E,(HL)          ; Get LSB of next array address
  INC HL             
  LD D,(HL)          ; Get MSB of next array address
  INC HL             
  JR NZ,FNDARY       ; Not found - Keep looking
  LD A,(DIMFLG)      ; Found Locate or Create it?
  OR A
  JP NZ,DD_ERR		 ; Create - Err $0A - "Redimensioned array"
  POP AF             ; Locate - Get number of dim'ns
  LD B,H             ; BC Points to array dim'ns
  LD C,L
  JP Z,POPHLRT		 ; Jump if array load/save
  SUB (HL)           ; Same number of dimensions?
  JP Z,FINDEL        ; Yes - Find elementù

  ; --- START PROC BS_ERR ---
BS_ERR:
  LD DE,$0009		; ERR $09 - "Subscript out of range"
  JP ERROR

CREARY:
  LD A,(VALTYP)
  LD (HL),A
  INC HL
  LD E,A
  LD D,$00
  POP AF                ; Array to save or 0 dim'ns?
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  LD (HL),C             ; Save second byte of name
  INC HL                
  LD (HL),B             ; Save first byte of name
  INC HL                
  LD C,A                ; Number of dimensions to C
  CALL CHKSTK           ; Check if enough memory
  INC HL                ; Point to number of dimensions
  INC HL                
  LD (TEMP3),HL         ; Save address of pointer
  LD (HL),C             ; Set number of dimensions
  INC HL
  LD A,(DIMFLG)         ; Locate of Create?
  RLA                   ; Carry set = Create
  LD A,C                ; Get number of dimensions
CRARLP:
  LD BC,10+1            ; Default dimension size 10
  JR NC,DEFSIZ          ; Locate - Set default size
  POP BC                ; Get specified dimension size
  INC BC                ; Include zero element
DEFSIZ:
  LD  (HL),C            ; Save LSB of dimension size
  PUSH AF               ; Save num' of dim'ns an status
  INC HL                
  LD  (HL),B            ; Save MSB of dimension size
  INC HL
  CALL MLDEBC           ; Multiply DE by BC to find amount of mem needed
  POP AF                ; Restore number of dimensions
  DEC A                 ; Count them
  JR  NZ,CRARLP         ; Do next dimension if more
  PUSH AF               ; Save locate/create flag
  LD  B,D               ; MSB of memory needed
  LD  C,E               ; LSB of memory needed
  EX  DE,HL
  ADD HL,DE             ; Add bytes to array start
  JP  C,OM_ERR         ; Too big - Error
  CALL ENFMEM           ; See if enough memory
  LD  (STREND),HL       ; Save new end of array

ZERARY:
  DEC HL                ; Back through array data
  LD  (HL),$00          ; Set array element to zero
  RST DCOMPR		    ; All elements zeroed?
  JR  NZ,ZERARY         ; No - Keep on going
  INC BC                ; Number of bytes + 1
  LD  D,A               ; A=0
  LD  HL,(TEMP3)        ; Get address of array
  LD  E,(HL)            ; Number of dimensions
  EX  DE,HL             ; To HL
  ADD HL,HL             ; Two bytes per dimension size
  ADD HL,BC             ; Add number of bytes
  EX  DE,HL             ; Bytes needed to DE
  DEC HL
  DEC HL
  LD  (HL),E            ; Save LSB of bytes needed
  INC HL                
  LD  (HL),D            ; Save MSB of bytes needed
  INC HL                
  POP AF                ; Locate / Create?
  JR  C,ENDDIM          ; A is 0 , End if create
FINDEL:
  LD  B,A               ; Find array element
  LD  C,A                
  LD  A,(HL)            ; Number of dimensions
  INC HL

  DEFB $16                ; "LD D,n" to skip "POP HL"
  
FNDELP:
  POP HL                ; Address of next dim' size
  LD  E,(HL)            ; Get LSB of dim'n size
  INC HL                
  LD  D,(HL)            ; Get MSB of dim'n size
  INC HL
  EX  (SP),HL           ; Save address - Get index
  PUSH AF               ; Save number of dim'ns
  RST DCOMPR		    ; Dimension too large?
  JP  NC,BS_ERR         ; Yes - ?BS Error
  CALL MLDEBC           ; Multiply previous by size
  ADD HL,DE             ; Add index to pointer
  POP AF                ; Number of dimensions
  DEC A                 ; Count them
  LD  B,H               ; MSB of pointer
  LD  C,L               ; LSB of pointer
  JR  NZ,FNDELP         ; More - Keep going
  LD A,(VALTYP)
  LD B,H
  LD C,L
  ADD HL,HL             ; 4 Bytes per element
  SUB $04
  JR C,FINDEL_0          
  ADD HL,HL
  JR Z,FINDEL_1
  ADD HL,HL
FINDEL_0:
  OR A
  JP PO,FINDEL_1
  ADD HL,BC
FINDEL_1:                
  POP BC                ; Start of array
  ADD HL,BC             ; Point to element
  EX DE,HL              ; Address of element to DE
ENDDIM:                 
  LD HL,(NXTOPR)		; Got code string address
  RET                   

; Routine at 24753
USING:
  CALL EVAL_0
  CALL TSTSTR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ';'
  EX DE,HL
  LD HL,(FACLOW)
  JR USING_1
; Routine at 24767
;
; Used by the routine at L61C4.
USING_0:
  LD A,(FLGINP)
  OR A
  JR Z,USING_2
  POP DE
  EX DE,HL
; This entry point is used by the routine at USING.
USING_1:
  PUSH HL
  XOR A
  LD (FLGINP),A
  INC A
  PUSH AF
  PUSH DE
  LD B,(HL)
  INC B
  DEC B
USING_2:
  JP Z,FC_ERR			; Err $05 - "Illegal function call"
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JR USING_7

; Data block at 24796
USING_3:
  LD E,B
  PUSH HL
  LD C,$02
USING_4:
  LD A,(HL)
  INC HL
  CP '\\'
  JP Z,L620F+1 ; reference not aligned to instruction
  CP ' '
  JR NZ,USING_5
  INC C
  DJNZ USING_4
USING_5:
  POP HL
  LD B,E
  LD A,'\\'
USING_6:
  CALL OUTC_SGN
  RST OUTDO  		; Output char to the current device

USING_7:
  XOR A
  LD E,A
  LD D,A
L60F9:
  CALL OUTC_SGN
  LD D,A
  LD A,(HL)
  INC HL
  CP '!'
  JP Z,L620D
  CP '#'
  JR Z,L6144
  CP '&'
  JP Z,L6209
  DEC B
  JP Z,L61F5
  CP '+'
  LD A,$08		;
  JR Z,L60F9
  DEC HL
  LD A,(HL)
  INC HL
  CP '.'
  JR Z,L615E
  CP '\\'
  JR Z,USING_3
  CP (HL)
  JR NZ,USING_6
  CP '$'             ; String variable?
  JR Z,USING_STR
  CP '*'
  JR NZ,USING_6
  INC HL
  LD A,B
  CP $02
  JR C,L6136
  LD A,(HL)
  CP '$'
L6136:
  LD A,' '
  JR NZ,L6141
  DEC B
  INC E

  DEFB $FE			; CP AFh ..hides the "XOR A" instruction
USING_STR:
  XOR A				; Simple variable
  ADD A,$10
  INC HL
L6141:
  INC E
  ADD A,D
  LD D,A
L6144:
  INC E
  LD C,$00
  DEC B
  JR Z,L6192
  LD A,(HL)
  INC HL
  CP '.'
  JR Z,L6169
  CP '#'
  JR Z,L6144
  CP ','
  JR NZ,L6173
  LD A,D
  OR $40 ; '@'
  LD D,A
  JR L6144

L615E:
  LD A,(HL)
  CP '#'
  LD A,'.'
  JP NZ,USING_6
  
  LD C,$01
  INC HL
L6169:
  INC C
  DEC B
  JR Z,L6192
  
  LD A,(HL)
  INC HL
  CP '#'
  JR Z,L6169
L6173:
  PUSH DE
  LD DE,L6190
  PUSH DE
  LD D,H
  LD E,L
  CP '^'		; $5E
  RET NZ
  CP (HL)
  RET NZ
  INC HL		; +1
  CP (HL)
  RET NZ
  INC HL		; +2
  CP (HL)
  RET NZ
  INC HL		; +3
  LD A,B
  SUB $04
  RET C
  POP DE
  POP DE
  LD B,A
  INC D
  INC HL

  DEFB $CA                ; JP Z,nn  to mask the next 2 bytes
L6190:  
  EX DE,HL
  POP DE
  
L6192:
  LD A,D
  DEC HL
  INC E
  AND $08
  JR NZ,L61AE
  DEC E
  LD A,B
  OR A
  JR Z,L61AE
  LD A,(HL)
  SUB $2D		; '-'
  JR Z,L61A9
  CP $FE
  JR NZ,L61AE
  LD A,$08
L61A9:
  ADD A,$04
  ADD A,D
  LD D,A
  DEC B
L61AE:
  POP HL
  POP AF
  JR Z,L61FE
  PUSH BC
  PUSH DE
  CALL EVAL
  POP DE
  POP BC
  PUSH BC
  PUSH HL
  LD B,E
  LD A,B
  ADD A,C
  CP $19	; TK_SPACE_S ?
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  LD A,D
		
; Routine at 25028
;L61C4:
  OR $80
  CALL PUFOUT		; Convert number/expression to string (format specified in 'A' register)
  CALL PRS
L61C4_0:
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
L61CF:
  SCF
  JR Z,L61DD
  LD (FLGINP),A
  CP ';'		;$3B
  JR Z,L61DB+1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
L61DB:
  LD B,$D7
  ; L61DB+1: RST CHRGTB		; Gets next character (or token) from BASIC text.
L61DD:
  POP BC
  EX DE,HL
  POP HL
  PUSH HL
  PUSH AF
  PUSH DE
  LD A,(HL)
  SUB B
  INC HL
  LD D,$00
  LD E,A
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  ADD HL,DE
  LD A,B
  OR A
  JP NZ,USING_7
  JR L61C4_2
L61F5:
  CALL OUTC_SGN
  RST OUTDO  		; Output char to the current device
L61C4_2:
  POP HL
  POP AF
  JP NZ,USING_0
L61FE:
  CALL C,OUTDO_CRLF
  EX (SP),HL
  CALL GSTRHL
  POP HL
  JP FINPRT

L6209:
  LD C,$00
  JR L61C4_4
L620D:
  LD C,$01
L620F:
  LD A,$F1
  ;  L620f+1:   POP AF
L61C4_4:
  DEC B
  CALL OUTC_SGN
  POP HL
  POP AF
  JR Z,L61FE
  PUSH BC
  CALL EVAL
  CALL TSTSTR
  POP BC
  PUSH BC
  PUSH HL
  LD HL,(FACLOW)
  LD B,C
  LD C,$00
  LD A,B
  PUSH AF
  OR A
  CALL NZ,__LEFT_S_1	; into LEFT$
  CALL PRS1
  LD HL,(FACLOW)
  POP AF
  OR A
  JP Z,L61C4_0
  SUB (HL)
  LD B,A
  LD A,' '
  INC B
L61C4_5:
  DEC B
  JP Z,L61C4_0
  RST OUTDO  		; Output char to the current device
  JR L61C4_5

; Routine at 25158
;
; Used by the routine at L61C4.
OUTC_SGN:
  PUSH AF
  LD A,D
  OR A
  LD A,'+'
  CALL NZ,OUTDO
  POP AF
  RET

; Routine at 25168
;
; Used by the routine at ENDNAM0.
L6250:
  CALL ENFMEM   ; $6267 = ENFMEM (reference not aligned to instruction)
; This entry point is used by the routines at L6719, L7439 and L748E.
L6250_0:
  PUSH BC
  EX (SP),HL
  POP BC
L6250_1:
  RST DCOMPR		; Compare HL with DE.
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JR L6250_1

; Routine at 25182
;
; Used by the routines at __GOSUB, EVAL1, DOFN, X_MACRO, L5AC2 and EXEC_ONGOSUB.
; $625E
CHKSTK:
  PUSH HL
  LD HL,(STREND)
  LD B,$00
  ADD HL,BC
  ADD HL,BC

  DEFB $3E  ; "LD A,n" to Mask the next byte

; See if enough memory
ENFMEM:
  PUSH HL
  LD A,-120	; 120 Bytes minimum RAM
  SUB L
  LD L,A
  LD A,-1	; 120 Bytes (MSB) minimum RAM
  SBC A,H
  LD H,A
  JR C,OM_ERR
  ADD HL,SP
  POP HL
  RET C
; This entry point is used by the routines at __CLEAR and MAXFILES.
OM_ERR:
  CALL UPD_PTRS
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  LD DE,$0007			; Err $07 - "Out of memory"
  JP ERROR


; Data block at 25222
__NEW:
  RET NZ
  ; --- START PROC L6287 ---
CLRPTR:
  LD  HL,(TXTTAB)
  CALL __TRON+1			; TROFF
  LD (AUTFLG),A			; AUTO mode flag
  LD (PTRFLG),A			; =0 if no line number converted to pointers
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (VARTAB),HL		; Pointer to start of variable space
  
  ; --- START PROC RUN_FST ---
;; RUNFST:
RUN_FST:
  ; Clear all variables
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HRUNC			; Hook 1 for RUN-Clear
ENDIF
  LD HL,(TXTTAB)		; Starting address of BASIC text area
  DEC HL
  ; --- START PROC _CLVAR ---
;; INTVAR:
_CLVAR:
  ; Initialise RUN variables
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCLEA			; Hook 2 for RUN-Clear
ENDIF
  LD (TEMP),HL			; Location for temporary reservation for st.code
  
  ; --- START PROC L62A7 ---
; Clear registers
_CLREG:
  CALL CLR_ALLINT
  LD B,1Ah
  LD HL,DEFTBL
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLOPD			; Hook 3 for RUN-Clear
ENDIF

_CLREG_0:
  LD (HL),$08
  INC HL
  DJNZ _CLREG_0
  
  CALL INIT_RND
  XOR A
  LD (ONEFLG),A			; Clear 'on error' flag
  LD L,A
  LD H,A
  LD (ONELIN),HL
  LD (OLDTXT),HL
  LD HL,(MEMSIZ)
  LD (FRETOP),HL
  CALL __RESTORE
  LD HL,(VARTAB)
  LD (ARYTAB),HL
  LD (STREND),HL
  CALL CLSALL		; Close all files
  LD A,(NLONLY)
  AND $01
  JR NZ,CLREG  		; Clear registers and warm boot
  LD (NLONLY),A
; This entry point is used by the routine at _CSTART.
; Clear registers and warm boot:
CLREG:
  POP BC
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  INC HL
  INC HL

; This entry point is used by the routine at WARM_BT.
WARM_ENTRY:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSTKE		; Hook for "Reset stack" event
ENDIF
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL STOP_LPT
  CALL FINPRT
  XOR A
  LD H,A
  LD L,A
  LD (PRMLEN),HL
  LD (NOFUNS),A			; 0 if no function active
  LD (PRMLN2),HL
  LD (FUNACT),HL
  LD (PRMSTK),HL		; Previous definition block on stack
  LD (SUBFLG),A
  PUSH HL
  PUSH BC
WARM_ENTRY_0:
  LD HL,(TEMP)
  RET

; Routine at 25371
;
; Used by the routine at L77FE.
TIME_S_ON:
  DI
  LD A,(HL)
  AND $04
  OR $01
  CP (HL)
  LD (HL),A
  JR Z,TIME_S_ON_0
  AND $04
  JR NZ,RESET_ONGSBF
TIME_S_ON_0:
  EI
  RET

; Routine at 25387
;
; Used by the routine at L77FE.
TIME_S_OFF:
  DI
  LD A,(HL)
  LD (HL),$00
  JR STOP_TRAPEVT_FLG

; Routine at 25393
;
; Used by the routines at EXEC_ONGOSUB and L77FE.
TIME_S_STOP:
  DI
  LD A,(HL)
  PUSH AF
  OR $02		; Interrupt STOP
  LD (HL),A
  POP AF
; This entry point is used by the routine at TIME_S_OFF.
STOP_TRAPEVT_FLG:
  XOR $05  	; bit 0 and 2 (Interrupt occurred / Interrupt OFF)
  JR Z,SET_ONGSBF
  EI
  RET

; Routine at 25406
RETURN_TRAP:
  DI
  LD A,(HL)
  AND $05	;  bit 0 and 2 (Interrupt occurred / Interrupt OFF)
  CP (HL)
  LD (HL),A
  JR NZ,RESET_TRAPEVT_FLG
  EI
  RET

; Toggle bit 0 and 2 (Interrupt occurred / Interrupt OFF)
RESET_TRAPEVT_FLG:
  XOR $05	;  bit 0 and 2 (Interrupt occurred / Interrupt OFF)
  JR Z,RESET_ONGSBF
  EI
  RET

; Routine at 25422
L634E:
  DI
; This entry point is used by the routines at TIME_S_ON and RETURN_TRAP.
RESET_ONGSBF:
  LD A,(ONGSBF)
  INC A
  LD (ONGSBF),A
  EI
  RET

; Routine at 25432
;
; Used by the routine at EXEC_ONGOSUB.
TIME_S_EVENT:
  DI
  LD A,(HL)
  AND $03		; are bit 0 or 1 (Interrupt OFF / Interrupt STOP) set ?
  CP (HL)
  LD (HL),A
  JR NZ,SET_ONGSBF
TIME_S_STOP_7:
  EI
  RET
  
; This entry point is used by the routine at TIME_S_STOP.
SET_ONGSBF:
  LD A,(ONGSBF)
  SUB $01
  JR C,TIME_S_STOP_7
  LD (ONGSBF),A
  EI
  RET

; Routine at 25454
;
; Used by the routine at L628E.
; Clear all the interrupt trap tables definitions
CLR_ALLINT:
  LD HL,TRPTBL
  LD B,$1A
  XOR A
CLR_ALLINT_0:
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  DJNZ CLR_ALLINT_0
  LD HL,FNKFLG
  LD B,$0A
CLR_ALLINT_1:
  LD (HL),A
  INC HL
  DJNZ CLR_ALLINT_1
  LD (ONGSBF),A
  RET

; Routine at 25481
EXEC_ONGOSUB:
  LD A,(ONEFLG)
  OR A
  RET NZ
  PUSH HL
  LD HL,(CURLIN)		 ; Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
  LD A,H
  AND L
  INC A
  JR Z,EXEC_ONGOSUB_2
  LD HL,TRPTBL
  LD B,$1A
EXEC_ONGOSUB_0:
  LD A,(HL)
  CP $05
  JR Z,EXEC_ONGOSUB_3
RUN_FST4:
  INC HL
  INC HL
  INC HL
  DJNZ EXEC_ONGOSUB_0
EXEC_ONGOSUB_2:
  POP HL
  RET

EXEC_ONGOSUB_3:
  PUSH BC
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  LD A,D
  OR E
  POP BC
  JR Z,RUN_FST4
  PUSH DE
  PUSH HL
  CALL TIME_S_EVENT
  CALL TIME_S_STOP
  LD C,$03
  CALL CHKSTK
  POP BC
  POP DE
  POP HL
  EX (SP),HL
  POP HL
  JP DO_GOSUB

; Routine at 25545
;
; Used by the routine at L628E.
__RESTORE:
  EX DE,HL
  LD HL,(TXTTAB)
  JR Z,__RESTORE_0
  EX DE,HL
  CALL ATOH		; Get specified line number
  PUSH HL
  CALL SRCHLN		; Get first line number
  LD H,B
  LD L,C
  POP DE
  JP NC,UL_ERR			; Err $08 - "Undefined line number"
__RESTORE_0:
  DEC HL
; This entry point is used by the routine at LTSTND.
UPDATA:
  LD (DATPTR),HL
  EX DE,HL
  RET

; Routine at 25571
; $63E3
__STOP:
  JP NZ,L77A5
; This entry point is used by the routine at L043F.
__STOP_0:
  RET NZ
  INC A
  JR __END_00

; Routine at 25578
__END:
  RET NZ
  XOR A
  LD (ONEFLG),A				; Clear 'on error' flag
  PUSH AF
  CALL Z,CLSALL		; Close all files
  POP AF
; This entry point is used by the routine at __STOP.
__END_00:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  DEFB $21	 ; "LD HL,nn" to jump over the next word without executing it

; Used by the routines at __RESUME, __LINE, __INPUT and __READ.
INPBRK:
  OR $FF                 ; 11111111b, Flag "Break" wanted
  POP BC                 ; Return not needed and more
; This entry point is used by the routine at PRG_END.
; $6401
_ENDPRG:
  LD HL,(CURLIN)		 ; Get current line number
  PUSH HL                
  PUSH AF                ; Save STOP / END statusct break?
  LD A,L                 ; Is it direct break?
  AND H
  INC A                  ; Line is -1 if direct break
  JR Z,NOLIN             ; Yes - No line number
  LD (OLDLIN),HL         ; Save line of break
  LD HL,(SAVTXT)         ; Get point of break
  LD (OLDTXT),HL         ; Save point to CONTinue
NOLIN:
  CALL STOP_LPT          ; Disable printer echo if enabled
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG		; "Break" message
  JP NZ,_ERROR_REPORT
  JP RESTART

; Routine at 25636
__CONT:
  LD HL,(OLDTXT)        ; Get CONTinue address
  LD A,H                ; Is it zero?
  OR L
  LD DE,$0011			; Err $11 - "Can't CONTINUE"
  JP Z,ERROR
  LD DE,(OLDLIN)        ; Get line of last break
  LD (CURLIN),DE        ; Set up current line number
  RET

; Routine at 25656
__TRON:
  DEFB $3E  ; "LD A,n" to Mask the next byte

__TROFF:
  XOR A
  LD (TRCFLG),A			; 0 MEANS NO TRACE
  RET

; Routine at 25662
__SWAP:
  CALL GETVAR
  PUSH DE
  PUSH HL
  LD HL,SWPTMP
  CALL FP2HL   		; Copy number value from DE to HL
  LD HL,(ARYTAB)
  EX (SP),HL
  RST GETYPR 		; Get the number type (FAC)
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETVAR
  POP AF
  LD B,A
  RST GETYPR 		; Get the number type (FAC)
  CP B
  JP NZ,TM_ERR	; If types are different, Err $0D - "Type mismatch"
  EX (SP),HL
  EX DE,HL
  PUSH HL
  LD HL,(ARYTAB)
  RST DCOMPR		; Compare HL with DE.
  JR NZ,_FC_ERR_A
  POP DE
  POP HL
  EX (SP),HL
  PUSH DE
  CALL FP2HL   		; Copy number value from DE to HL
  POP HL
  LD DE,SWPTMP
  CALL FP2HL   		; Copy number value from DE to HL
  POP HL
  RET
_FC_ERR_A:
  JP FC_ERR			; Err $05 - "Illegal function call"

; Data block at 25719
__ERASE:
L6477:
  LD A,$01
  LD (SUBFLG),A
  CALL GETVAR
  PUSH HL
  LD (SUBFLG),A
  LD H,B
  LD L,C
  DEC BC
  DEC BC
  DEC BC
  DEC BC
  DEC BC
  ADD HL,DE
  EX DE,HL
  LD HL,(STREND)

L648F:
  RST DCOMPR		; Compare HL with DE.

L6490:
  LD  A,(DE)
  LD  (BC),A
  INC DE
  INC BC
  JR  NZ,L648F
  DEC BC
  LD  H,B
  LD  L,C
  LD  (STREND),HL
  POP HL
  LD  A,(HL)
  CP  ','
  RET NZ
  RST CHRGTB		; Gets next character (or token) from BASIC text.
L64A2:
  JR  __ERASE

; Routine at 25764
L64A4:
  POP AF
  POP HL
  RET

; Routine at 25767

; a.k.a. CHKLTR
; Used by the routines at DEFVAL and GETVAR.
; Load A with char in (HL) and check it is a letter:
IS_ALPHA:
  LD A,(HL)         ; Get byte

; This entry point is used by the routines at TOKENIZE, OPRND, L5683, L575A and GETVAR.
; Check char in 'A' being in the 'A'..'Z' range
IS_ALPHA_A:
  CP 'A'             ; < "A" ?
  RET C              ; Carry set if not letter
  CP $5B             ; > "Z" ?
  CCF                
  RET                ; Carry set if not letter

; Routine at 25775
__CLEAR:
  JP Z,_CLVAR
  CALL GET_POSINT_0 ; Get integer
  DEC HL            ; Cancel increment
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL           ; Save code string address
  LD HL,(HIMEM)
  LD B,H
  LD C,L
  LD HL,(MEMSIZ)    ; Get end of RAM
  JR Z,STORED       ; No value given - Use stored
  POP HL
  RST SYNCHR 		; Check for comma
  DEFB ','
  PUSH DE           ; Save number
  CALL GETWORD      ; Get integer 0 to 32767 to DE
  DEC HL            ; Cancel increment
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  EX (SP),HL        ; Save code string address
  EX DE,HL          ; Number to DE
  LD A,H            ; Get MSB of new RAM top
  AND A             ; too low ?
  JP P,FC_ERR		; Err $05 - "Illegal function call"
  PUSH DE
  LD DE,MAXRAM+1	; Limit of CLEAR position
  RST DCOMPR		; Compare HL with DE.
  JP NC,FC_ERR		; Err $05 - "Illegal function call"
  POP DE
  PUSH HL           ; Save code string address (again)
  LD BC,$FEF5		; -267 (same offset on Tandy model 100)
  LD A,(MAXFIL)
__CLEAR_0:
  ADD HL,BC
  DEC A
  JP P,__CLEAR_0
  POP BC            ; Restore code string address (1st copy)
  DEC HL
STORED:
  LD A,L            ; Get LSB of new RAM top
  SUB E             ; Subtract LSB of string space
  LD E,A            ; Save LSB
  LD A,H            ; Get MSB of new RAM top
  SBC A,D           ; Subtract MSB of string space
  LD D,A            ; Save MSB
  JP C,OM_ERR      ; ?OM Error if not enough mem
  PUSH HL           ; Save RAM top
  LD HL,(VARTAB)    ; Get program end
  PUSH BC
  LD BC,$00A0		; 160 Bytes minimum working RAM (same offset on Tandy model 100)
  ADD HL,BC         ; Get lowest address
  POP BC
  RST DCOMPR		; Enough memory?
  JP NC,OM_ERR     ; No - ?OM Error
  EX DE,HL          ; RAM top to HL
  LD (STKTOP),HL    ; Set new top of RAM
  LD H,B
  LD L,C
  LD (HIMEM),HL
  POP HL
  LD (MEMSIZ),HL    ; Set new string space
  POP HL
  CALL _CLVAR       ; Initialise variables
  LD A,(MAXFIL)
  CALL MAXFILES
  LD HL,(TEMP)
  JP EXEC_EVAL

; Routine at 25888
L6520:
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  RET

; Routine at 25895
__NEXT:
  LD DE,$0000               ; In case no index given
__NEXT_0:
  CALL NZ,GETVAR			; not end of statement, locate variable (Get index address)
  LD (TEMP),HL				; save BASIC pointer
  CALL BAKSTK				; search FOR block on stack (skip 2 words)
  JP NZ,NF_ERR				; Err $01 - "NEXT without FOR"
  LD SP,HL					; Clear nested loops
  PUSH DE					; Save index address
  LD A,(HL)					; Get sign of STEP
  PUSH AF                   ; Save sign of STEP
  INC HL
  PUSH DE                   ; Save index address
  LD A,(HL)
  INC HL
  OR A
  JP M,__NEXT_2
  DEC A
  JR NZ,__NEXT_1
  LD BC,$0008
  ADD HL,BC
__NEXT_1:
  ADD A,$04
  LD (VALTYP),A
  CALL FP_HL2DE				; Move index value to FPREG
  EX DE,HL
  EX (SP),HL				; Save address of TO value
  PUSH HL
  RST GETYPR 				; Get the number type (FAC)
  JR NC,__NEXT_4	
  CALL LOADFP_REV			; Load single precision FP value from (HL) in reverse byte order
  CALL FADD
  POP HL
  CALL FPTHL
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FCOMP
  JR __NEXT_3

__NEXT_2:
  LD BC,RDSLT
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  EX (SP),HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  PUSH HL
  LD L,C
  LD H,B
  CALL IADD
  LD A,(VALTYP)
  CP $02
  JP NZ,OV_ERR			; Err $06 -  "Overflow"
  EX DE,HL
  POP HL
  LD (HL),D
  DEC HL
  LD (HL),E
  POP HL
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  CALL ICOMP
__NEXT_3:
  POP HL
  POP BC
  SUB B
  CALL LOADFP
  JR Z,KILFOR
  EX DE,HL
  LD (CURLIN),HL
  LD L,C
  LD H,B
  JP PUTFID

__NEXT_4:
  CALL ARG2DE_DECADD
  POP HL
  CALL FP_DE2HL
  POP HL
  CALL ARG2DE
  PUSH DE
  CALL XDCOMP
  JR __NEXT_3
  
; Remove "FOR" block
KILFOR:
  LD SP,HL           ; Remove "FOR" block
  LD (SAVSTK),HL     ; Code string after "NEXT"
  EX DE,HL          
  LD HL,(TEMP)       ; Get next byte in code string
  LD A,(HL)          ; More NEXTs ?
  CP ','             ; No - Do next statement
  JP NZ,EXEC_EVAL    ; Position to index name
  RST CHRGTB         ; Gets next character (or token) from BASIC text.
  CALL __NEXT_0      ; Re-enter NEXT routine
; < will not RETurn to here , Exit to EXEC_EVAL (RUNCNT) or Loop >

EVAL_STR:
  CALL GETSTR
  LD A,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP DE
  PUSH BC
  PUSH AF
  CALL GSTRDE
  POP AF
  LD D,A
  LD E,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP HL
EVAL_STR_0:
  LD A,E
  OR D
  RET Z
  LD A,D
  SUB $01
  RET C
  XOR A
  CP E
  INC A
  RET NC
  DEC D
  DEC E
  LD A,(BC)
  INC BC
  CP (HL)
  INC HL
  JR Z,EVAL_STR_0
  CCF
  JP EVAL_RESULT


; Routine at 26101
__OCT_S:
  CALL OCT_STR
  JR __STR_S_0

; Routine at 26106
__HEX_S:
  CALL HEX_STR
  JR __STR_S_0

; Routine at 26111
__BIN_S:
  CALL BIN_STR
  JR __STR_S_0

; Routine at 26116
__STR_S:
  CALL FOUT

; This entry point is used by the routines at __OCT_S, __HEX_S and __BIN_S.
__STR_S_0:
  CALL CRTST          ; Create string entry
  CALL GSTRCU         ; Current string to pool

; Save string in string area
SAVSTR:
  LD BC,TOPOOL        ; Save in string pool
  PUSH BC             ; Save address on stack

; This entry point is used by the routines at __LET and _MID_S.
; $6611
SAVSTR_0:
  LD A,(HL)			; Get string length
  INC HL
  PUSH HL             ; Save pointer to string
  CALL TESTR          ; See if enough string space
  POP HL              ; Restore pointer to string
  LD C,(HL)           ; Get LSB of address
  INC HL             
  LD B,(HL)           ; Get MSB of address
  CALL CRTMST         ; Create string entry
  PUSH HL             ; Save pointer to MSB of addr
  LD L,A              ; Length of string
  CALL TOSTRA         ; Move to string area
  POP DE              ; Restore pointer to MSB
  RET

; Routine at 26149
;
; Used by the routines at __CHR_S and FN_INKEY.
MK_1BYTE_TMST:
  LD A,$01
; This entry point is used by the routines at CONCAT, FN_STRING, FN_INPUT and FN_SPRITE.
; Make temporary string
MKTMST:
  CALL TESTR			; See if enough string space
; This entry point is used by the routines at SAVSTR, DTSTR and __LEFT_S.
; Create string entry
CRTMST:
  LD HL,DSCTMP           ; Temporary string
  PUSH HL                ; Save it
  LD (HL),A              ; Save length of string
  INC HL          
  LD (HL),E              ; Save LSB of address
  INC HL          
  LD (HL),D              ; Save MSB of address
  POP HL                 ; Restore pointer
  RET

; Routine at 26165
;
; Used by the routines at __STR_S and PRS.
CRTST:
  DEC HL			; DEC - INCed after

; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,'"'			; Terminating quote
; This entry point is used by the routines at __LINE and L6E35.
QTSTR_0:
  LD D,B			; Quote to D

; Create String, termination char in D
;
; Used by the routine at __READ.
DTSTR:
  PUSH HL           ; Save start
  LD C,-1           ; Set counter to -1
DTSTR_0:
  INC HL            ; Move on
  LD A,(HL)         ; Get byte
  INC C             ; Count bytes
  OR A              ; End of line?
  JR Z,DTSTR_1      ; Yes - Create string entry
  CP D              ; Terminator D found?
  JR Z,DTSTR_1      ; Yes - Create string entry
  CP B              ; Terminator B found?
  JR NZ,DTSTR_0     ; No - Keep looking
DTSTR_1:
  CP '"'            ; End with '"'?
  CALL Z,__CHRGTB   ; Yes - Get next character
  EX (SP),HL        ; Starting quote
  INC HL            ; First byte of string
  EX DE,HL          ; To DE
  LD A,C            ; Get length
  CALL CRTMST		; Create string entry

; Temporary string to pool
;
; Used by the routines at CONCAT, TOPOOL, __LEFT_S, FN_INPUT and FN_SPRITE.
TSTOPL:
  LD DE,DSCTMP		; Temporary string
  DEFB $3E  ; "LD A,n" to Mask the next byte
TSTOPL_0:
  PUSH DE
  LD HL,(TEMPPT)	; Temporary string pool pointer
  LD (FACLOW),HL	; Save address of string ptr
  LD A,$03
  LD (VALTYP),A     ; Set type to string
  CALL FP2HL   		; Move string to pool
  LD DE,FRETOP
  RST DCOMPR		; Out of string pool?
  LD (TEMPPT),HL	; Save new pointer
  POP HL			; Restore code string address
  LD A,(HL)			; Get next code byte
  RET NZ			; Return if pool OK
  LD DE,$0010		; Err $10 - "String formula too complex"
  JP ERROR

; Routine at 26231
PRNUMS:
  INC HL

; Create string entry and print it
;
; Used by the routines at LNUM_MSG, L4B4A, LTSTND, __DELETE, LINE2PTR, L61C4, __CLOAD,
; L710B, _CSTART and L7D29.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routines at L4A5A, __INPUT and L61C4.
PRS1:
  CALL GSTRCU
  CALL LOADFP_0
  INC D
PRS1_0:
  DEC D
  RET Z
  LD A,(BC)
  RST OUTDO  		; Output char to the current device
  CP CR
  CALL Z,CRLF_DONE
  INC BC
  JR PRS1_0

; Routine at 26254
;
; Used by the routines at SAVSTR, MK_1BYTE_TMST and __LEFT_S.
TESTR:
  OR A
  DEFB $0E  ; "LD C,n" to Mask the next byte
;TESTR+2:
  POP AF
  PUSH AF
  LD HL,(STKTOP)	; Start of string buffer for BASIC
  EX DE,HL
  LD HL,(FRETOP)
  CPL
  LD C,A
  LD B,$FF
  ADD HL,BC
  INC HL
  RST DCOMPR		; Compare HL with DE.
  JR C,TESTR_1
  LD (FRETOP),HL
  INC HL
  EX DE,HL
; This entry point is used by the routine at DETOKEN.
TESTR_0:
  POP AF
  RET
  
TESTR_1:
  POP AF
  LD DE,$000E		; Err $0E - "Out of string space"
  JP Z,ERROR
  CP A
  PUSH AF
  LD BC,TESTR+2
  PUSH BC
; This entry point is used by the routine at __FRE.
TESTR_2:
  LD HL,(MEMSIZ)
; This entry point is used by the routine at L6719.
TESTR_3:
  LD (FRETOP),HL
  LD HL,$0000
  PUSH HL
  LD HL,(STREND)
  PUSH HL
  LD HL,TEMPST
L66C7:
  LD DE,(TEMPPT)
  RST DCOMPR		; Compare HL with DE.
  LD BC,L66C7
  JP NZ,L6742
  LD HL,PRMPRV
  LD (TEMP9),HL
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)
TESTR_4:
  LD DE,(ARYTA2)
  RST DCOMPR		; Compare HL with DE.
  JR Z,TESTR_6
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  CP $03		; ?perhaps checks str type ?
  JR NZ,TESTR_5
  CALL L6743
  XOR A
TESTR_5:
  LD E,A
  LD D,$00
  ADD HL,DE
  JR TESTR_4
TESTR_6:
  LD HL,(TEMP9)
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  LD HL,(ARYTAB)
  JR Z,L6719_0
  EX DE,HL
  LD (TEMP9),HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL
  ADD HL,DE
  LD (ARYTA2),HL
  EX DE,HL
  JR TESTR_4

; Routine at 26393
L6719:
  POP BC
; This entry point is used by the routine at TESTR.
L6719_0:
  LD DE,(STREND)
  RST DCOMPR		; Compare HL with DE.
  JP Z,L6763
  LD A,(HL)
  INC HL
  CALL LOADFP
  PUSH HL
  ADD HL,BC
  CP $03
  JR NZ,L6719
  LD (TEMP8),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL
L6737:
  EX DE,HL
  LD HL,(TEMP8)
  EX DE,HL
  RST DCOMPR		; Compare HL with DE.
  JR Z,L6719_0
  LD BC,L6737
; This entry point is used by the routine at TESTR.
L6742:
  PUSH BC
; This entry point is used by the routine at TESTR.
L6743:
  XOR A
  OR (HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  RET Z
  LD B,H
  LD C,L
  LD HL,(FRETOP)
  RST DCOMPR		; Compare HL with DE.
  LD H,B
  LD L,C
  RET C
  POP HL
  EX (SP),HL
  RST DCOMPR		; Compare HL with DE.
  EX (SP),HL
  PUSH HL
  LD H,B
  LD L,C
  RET NC
  POP BC
  POP AF
  POP AF
  PUSH HL
  PUSH DE
  PUSH BC
  RET
  
L6763:
  POP DE
  POP HL
  LD A,H
  OR L
  RET Z
  DEC HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  PUSH HL
  DEC HL
  LD L,(HL)
  LD H,$00
  ADD HL,BC
  LD D,B
  LD E,C
  DEC HL
  LD B,H
  LD C,L
  LD HL,(FRETOP)
  CALL L6250_0
  POP HL
  LD (HL),C
  INC HL
  LD (HL),B
  LD H,B
  LD L,C
  DEC HL
  JP TESTR_3

; Routine at 26503
;
; Used by the routine at EVAL3.
CONCAT:
  PUSH BC
  PUSH HL
  LD HL,(FACLOW)
  EX (SP),HL
  CALL OPRND
  EX (SP),HL
  CALL TSTSTR
  LD A,(HL)
  PUSH HL
  LD HL,(FACLOW)
  PUSH HL
  ADD A,(HL)
  LD DE,$000F			; Err $0F - "String too long"
  JP C,ERROR
  CALL MKTMST			; Make temporary string
  POP DE
  CALL GSTRDE
  EX (SP),HL
  CALL GSTRHL
  PUSH HL
  LD HL,(TMPSTR)
  EX DE,HL
  CALL SSTSA
  CALL SSTSA
  LD HL,EVAL2
  EX (SP),HL
  PUSH HL
  JP TSTOPL

; Routine at 26559
;
; Used by the routine at CONCAT.
SSTSA:
  POP HL                ; Return address
  EX (SP),HL            ; Get string block,save return
  LD A,(HL)             ; Get length of string
  INC HL                
  LD C,(HL)             ; Get LSB of string address
  INC HL                
  LD B,(HL)             ; Get MSB of string address
  LD L,A                ; Length to L
  
; This entry point is used by the routines at SAVSTR and __LEFT_S.
TOSTRA:
  INC L                 ; INC - DECed after
  
TSALP:
  DEC L                 ; Count bytes moved
  RET Z                 ; End of string - Return
  LD A,(BC)             ; Get source
  LD (DE),A             ; Save destination
  INC BC                ; Next source
  INC DE                ; Next destination
  JR TSALP              ; Loop until string moved

; Routine at 26576
;
; Used by the routines at __NEXT, __LEN, FN_INSTR, _MID_S, FILE_PARMS and __SPRITE.
; $67D0
GETSTR:
  CALL TSTSTR           ; Make sure it's a string

; Get string pointed by FPREG
;
; Used by the routines at FN_USR, __STR_S, PRS1 and __FRE.
GSTRCU:
  LD HL,(FACLOW)        ; Get current string

; Get string pointed by HL
;
; Used by the routines at L61C4, CONCAT and FN_INSTR.
GSTRHL:
  EX DE,HL              ; Save DE

; Get string pointed by DE
;
; Used by the routines at __NEXT, CONCAT and __LEFT_S.
GSTRDE:
  CALL BAKTMP		    ; Was it last tmp-str?
  EX DE,HL              ; Restore DE
  RET NZ                ; No - Return
  PUSH DE               ; Save string
  LD D,B                ; String block address to DE
  LD E,C                
  DEC DE                ; Point to length
  LD C,(HL)             ; Get string length
  LD HL,(FRETOP)        ; Current bottom of string area
  RST DCOMPR		    ; Last one in string area?
  JR NZ,POPHL           ; No - Return
  LD B,A                ; Clear B (A=0)
  ADD HL,BC             ; Remove string from str' area
  LD (FRETOP),HL        ; Save new bottom of str' area
POPHL:
  POP HL                ; Restore string
  RET

; Routine at 26606
;
; Used by the routines at __LET and GSTRDE.
; Back to last tmp-str entry
BAKTMP:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFRET		; Hook for 'Free descriptor' event
ENDIF
  LD HL,(TEMPPT)    ; Back
  DEC HL            ; Get MSB of address
  LD B,(HL)         ; Back
  DEC HL            ; Get LSB of address
  LD C,(HL)         ; Back
  DEC HL            ; Back
  RST DCOMPR		; String last in string pool?
  RET NZ            ; Yes - Leave it
  LD (TEMPPT),HL    ; Save new string pool top
  RET
  
; Routine at 26623
__LEN:
  LD BC,PASSA        ; To return integer A
  PUSH BC            ; Save address
; This entry point is used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR        ; Get string and its length
  XOR A
  LD D,A             ; Clear D
  LD A,(HL)          ; Get length of string
  OR A               ; Set status flags
  RET

; Routine at 26635
__ASC:
  LD BC,PASSA        ; To return integer A
  PUSH BC            ; Save address
; This entry point is used by the routine at FN_STRING.
__ASC_0:
  CALL GETLEN        ; Get length of string
  JP Z,FC_ERR		 ; Null string - Error
  INC HL
  LD E,(HL)          ; Get LSB of address
  INC HL
  LD D,(HL)          ; Get MSB of address
  LD A,(DE)          ; Get first byte of string
  RET

; Routine at 26651
__CHR_S:
  CALL MK_1BYTE_TMST   ; Make One character temporary string
  CALL MAKINT          ; Make it integer A
; This entry point is used by the routine at FN_INKEY.
__CHR_S_0:
  LD HL,(TMPSTR)       ; Get address of string
  LD (HL),E            ; Save character

; Save in string pool
;
; Used by the routine at FN_STRING.
TOPOOL:
  POP BC            ; Clean up stack
  JP TSTOPL         ; Temporary string to pool

; Routine at 26665
;
; Used by the routine at OPRND.
FN_STRING:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  CALL GETINT
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  EX (SP),HL
  PUSH HL
  RST GETYPR 		; Get the number type (FAC)
  JR Z,FN_STRING_0	; JP if string type
  CALL MAKINT
  JR FN_STRING_1
  
FN_STRING_0:
  CALL __ASC_0
FN_STRING_1:
  POP DE
  CALL FN_STRING_2
  
__SPACE_S:
  CALL MAKINT
  LD A,' '
FN_STRING_2:
  PUSH AF
  LD A,E
  CALL MKTMST			; Make temporary string
  LD B,A
  POP AF
  INC B
  DEC B
  JR Z,TOPOOL
  LD HL,(TMPSTR)
__SPACE_S_1:
  LD (HL),A
  INC HL
  DJNZ __SPACE_S_1
  JR TOPOOL

; Routine at 26721
__LEFT_S:
  CALL LFRGNM			; Get number and ending ")"
  XOR A                 ; Start at first byte in string

; This entry point is used by the routine at __RIGHT_S.
RIGHT1:
  EX (SP),HL            ; Save code string,Get string
  LD C,A                ; Starting position in string
  
  DEFB $3E              ; "LD A,n" to Mask the next byte

__LEFT_S_1:
  PUSH HL

; Continuation of MID$ routine
MID1:
  PUSH HL               ; Save string block address
  LD A,(HL)             ; Get length of string
  CP B                  ; Compare with number given
  JR C,ALLFOL           ; All following bytes required
  LD A,B                ; Get new length
  DEFB $11              ; "LD DE,nn" to skip "LD C,0"

ALLFOL:                 ; First byte of string
  LD C,0                ; Save position in string
  PUSH BC               ; See if enough string space
  CALL TESTR            ; Get position in string
  POP BC                ; Restore string block address
  POP HL                ; And re-save it
  PUSH HL               
  INC HL                ; Get LSB of address
  LD B,(HL)             
  INC HL                ; Get MSB of address
  LD H,(HL)             ; HL = address of string
  LD L,B                ; BC = starting address
  LD B,$00              ; Point to that byte
  ADD HL,BC             ; BC = source string
  LD B,H                
  LD C,L                ; Create a string entry
  CALL CRTMST	        ; Length of new string
  LD L,A                ; Move string to string area
  CALL TOSTRA           ; Clear stack
  POP DE                ; Move to string pool if needed
  CALL GSTRDE           ; Temporary string to pool
  JP TSTOPL

; Routine at 26769
__RIGHT_S:
  CALL LFRGNM			; Get number and ending ")"
  POP DE                ; Get string length
  PUSH DE               ; And re-save
  LD A,(DE)             ; Get length
  SUB B                 ; Move back N bytes
  JR RIGHT1         ; Go and get sub-string

; Routine at 26778
__MID_S:
  EX DE,HL              ; Get code string address
  LD A,(HL)             ; Get next byte "," or ")"
  CALL MIDNUM			; Get number supplied
  INC B                 ; Is it character zero?
  DEC B                 
  JP Z,FC_ERR			; Yes - Error
  PUSH BC               ; Save starting position
  CALL L69E4			; test ',' & ')'
  POP AF                ; Restore starting position
  EX (SP),HL            ; Get string,save code string
  LD BC,MID1            ; Continuation of MID$ routine
  PUSH BC               ; Save for return
  DEC A                 ; Starting position-1
  CP (HL)               ; Compare with length
  LD B,$00              ; Zero bytes length
  RET NC                ; Null string if start past end
  LD C,A                ; Save starting position-1
  LD A,(HL)             ; Get length of string
  SUB C                 ; Subtract start
  CP E                  ; Enough string for it?
  LD B,A                ; Save maximum length available
  RET C                 ; Truncate string if needed
  LD B,E                ; Set specified length
  RET                   ; Go and create string

; Routine at 26811
__VAL:
  CALL GETLEN               ; Get length of string
  JP Z,PASSA    ; Result zero
  LD E,A                    ; Save length
  INC HL                    
  LD A,(HL)                 ; Get LSB of address
  INC HL                    
  LD H,(HL)                 ; Get MSB of address
  LD L,A                    ; HL = String address
  PUSH HL                   ; Save string address
  ADD HL,DE                 
  LD B,(HL)                 ; Get end of string+1 byte
  LD (VLZADR),HL
  LD A,B
  LD (VLZDAT),A
  LD (HL),D                 ; Zero it to terminate
  EX (SP),HL                ; Save string end,get start
  PUSH BC                   ; Save end+1 byte
  DEC HL                    
  RST CHRGTB                ; Gets next character (or token) from BASIC text.
  CALL DBL_ASCTFP           ; Convert ASCII string to FP
  LD HL,$0000               
  LD (VLZADR),HL            
  POP BC                    ; Restore end+1 byte
  POP HL                    ; Restore end+1 address
  LD (HL),B                 ; Put back original byte
  RET

; Routine at 26851
;
; Used by the routines at __LEFT_S and __RIGHT_S.
; Get number and ending ")"
LFRGNM:
  EX DE,HL          ; Code string address to HL
  RST SYNCHR 		; Make sure ")" follows
  DEFB ')'

;
; Used by the routine at __MID_S.
; Get numeric argument for MID$
MIDNUM:
  POP BC            ; Get return address
  POP DE            ; Get number supplied
  PUSH BC           ; Re-save return address
  LD B,E            ; Number to B
  RET

; Routine at 26859
;
; Used by the routine at OPRND.
FN_INSTR:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL OPNPAR
  RST GETYPR 		; Get the number type (FAC)
  LD A,$01
  PUSH AF
  JR Z,FN_INSTR_0	; JP if string type
  POP AF
  CALL MAKINT
  OR A
  JP Z,FC_ERR
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  CALL TSTSTR
FN_INSTR_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  LD HL,(FACLOW)
  EX (SP),HL
  CALL EVAL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  PUSH HL
  CALL GETSTR
  EX DE,HL
  POP BC
  POP HL
  POP AF
  PUSH BC
  LD BC,POPHLRT		; (POP HL / RET)
  PUSH BC
  LD BC,PASSA
  PUSH BC
  PUSH AF
  PUSH DE
  CALL GSTRHL
  POP DE
  POP AF
  LD B,A
  DEC A
  LD C,A
  CP (HL)
  LD A,$00
  RET NC
  LD A,(DE)
  OR A
  LD A,B
  RET Z
  LD A,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD H,(HL)
  LD L,B
  LD B,$00
  ADD HL,BC
; This entry point is used by the routine at _MID_S.
FN_INSTR_1:
  SUB C
  LD B,A
  PUSH BC
  PUSH DE
  EX (SP),HL
  LD C,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
FN_INSTR_2:
  PUSH HL
  PUSH DE
  PUSH BC
FN_INSTR_3:
  LD A,(DE)
  CP (HL)
  JR NZ,FN_INSTR_6
  INC DE
  DEC C
  JR Z,FN_INSTR_5
  INC HL
  DJNZ FN_INSTR_3
  POP DE
  POP DE
  POP BC
FN_INSTR_4:
  POP DE
  XOR A
  RET
  
FN_INSTR_5:
  POP HL
  POP DE
  POP DE
  POP BC
  LD A,B
  SUB H
  ADD A,C
  INC A
  RET

FN_INSTR_6:
  POP BC
  POP DE
  POP HL
  INC HL
  DJNZ FN_INSTR_2
  JR FN_INSTR_4

; Routine at 26990
;
; Used by the routine at NOT_KEYWORD.
_MID_S:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  CALL GETVAR
  CALL TSTSTR
  PUSH HL
  PUSH DE
  EX DE,HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(STREND)
  RST DCOMPR		; Compare HL with DE.
  JR C,_MID_S_0
  LD HL,(TXTTAB)
  RST DCOMPR		; Compare HL with DE.
  JR NC,_MID_S_0
  POP HL
  PUSH HL
  CALL SAVSTR_0
  POP HL
  PUSH HL
  CALL FP2HL   		; Copy number value from DE to HL
_MID_S_0:
  POP HL
  EX (SP),HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  OR A
  JP Z,FC_ERR
  PUSH AF
  LD A,(HL)
  CALL L69E4			; test ',' & ')'
  PUSH DE
  CALL NEXT_EQUAL
  PUSH HL
  CALL GETSTR
  EX DE,HL
  POP HL
  POP BC
  POP AF
  LD B,A
  EX (SP),HL
  PUSH HL
  LD HL,POPHLRT		; (POP HL / RET)
  EX (SP),HL
  LD A,C
  OR A
  RET Z
  LD A,(HL)
  SUB B
  JP C,FC_ERR
  INC A
  CP C
  JR C,_MID_S_1
  LD A,C
_MID_S_1:
  LD C,B
  DEC C
  LD B,$00
  PUSH DE
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E
  ADD HL,BC
  LD B,A
  POP DE
  EX DE,HL
  LD C,(HL)
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  EX DE,HL
  LD A,C
  OR A
  RET Z
_MID_S_2:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC C
  RET Z
  DJNZ _MID_S_2
  RET

; Routine at 27108
;
; Used by the routines at __MID_S and _MID_S.
; test ',' & ')'
L69E4:
  LD E,$FF
  CP ')'
  JR Z,L69E4_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
L69E4_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  RET

; Routine at 27122
__FRE:
  LD HL,(STREND)
  EX DE,HL
  LD HL,$0000
  ADD HL,SP
  RST GETYPR 		; Get the number type (FAC)
  JP NZ,FRE_RESLT	; JP if not string type
  CALL GSTRCU
  CALL TESTR_2
  LD DE,(STKTOP)
  LD HL,(FRETOP)
  JP FRE_RESLT

; Routine at 27150
;
; Used by the routines at __OPEN, _RUN_FILE, __SAVE and __BSAVE.
; AKA  NAMSCN (name scan) - evaluate filespecification
FILE_PARMS:
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD A,(HL)
  OR A					; stringsize zero ?
  JR Z,FILE_PARMS_2		; yep, bad filename error
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E			; pointer to string
  LD E,A			; size of string
  
  CALL L6F15		; Parse Device Name
  PUSH AF
  LD BC,FILNAM
  LD D,11
  INC E
; This entry point is used by the routine at FNAME_6.
FILE_PARMS_0:
  DEC E						; end of filespecification string ?
  JR Z,L6A61				; yep, fill remaining FILNAME with spaces
  LD A,(HL)
  CP ' '					; control characters ?
  JR C,FILE_PARMS_2			; yep, bad filename error
  CP '.'					; filename/extension seperator ?
  JR Z,FNAME_7				; yep, handle extension
  LD (BC),A
  INC BC
  INC HL
  DEC D						; FILNAM full ?
  JR NZ,FILE_PARMS_0		; nope, next
; This entry point is used by the routine at L6A61.
FILE_PARMS_1:
  POP AF
  PUSH AF
  LD D,A					; devicecode
  LD A,(FILNAM)
  INC A						; first character FILNAME charactercode 255 ?
  JR Z,FILE_PARMS_2			; yep, bad filename error (because this is internally used as runflag)
  POP AF
  POP HL
  RET

; This entry point is used by the routine at FNAME_7.
FILE_PARMS_2:
  JP NM_ERR					; Err $38 -  'Bad file name'

; Routine at 27210
;
; Used by the routine at FNAME_7.
FNAME_6:
  INC HL
  JR FILE_PARMS_0

; Routine at 27213
;
; Used by the routine at FILE_PARMS.
FNAME_7:
  LD A,D
  CP 11
  JP Z,FILE_PARMS_2
  CP 3
  JP C,FILE_PARMS_2
  JR Z,FNAME_6
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JR FNAME_7

; Routine at 27233
;
; Used by the routine at FILE_PARMS.
L6A61:
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JR NZ,L6A61
  JR FILE_PARMS_1

; Routine at 27242
;
; Used by the routines at __LOC, __LOF, __EOF and __FPOS.
GETFLP:
  CALL MAKINT
; This entry point is used by the routines at OPRND, L6A9E and __OPEN.
; a.k.a. VARPTR_A
GETPTR:
  LD L,A
  LD A,(MAXFIL)
  CP L
  JP C,BN_ERR			; Err $34 -  'Bad file number'
  LD H,$00
  ADD HL,HL
  EX DE,HL
  LD HL,(FILTAB)
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD A,(NLONLY)
  INC A
  RET Z
  LD A,(HL)
  OR A
  RET Z
  PUSH HL
  LD DE,$0004
  ADD HL,DE
  LD A,(HL)
  CP $09		; TK_SIN ?
  JR NC,GETFLP_1
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HGETP				; Hook 1 for Locate FCB
ENDIF
  JP IE_ERR				; Err $33 - "Internal Error"

GETFLP_1:
  POP HL
  LD A,(HL)
  OR A
  SCF
  RET

; Routine at 27294
;
; Used by the routines at GET and FN_INPUT.
L6A9E:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '#'
  CALL Z,__CHRGTB  ; Gets next character (or token) from BASIC text.
  CALL GETINT
  EX (SP),HL
  PUSH HL
; a.k.a. SELECT. This entry point is used by the routines at _RUN_FILE and GT_CHANNEL.
SETFIL:
  CALL GETPTR
  JP Z,CF_ERR			; Err $3B - "File not OPEN"
  LD (PTRFIL),HL		; Redirect I/O
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSETF			; Hook 2 for Locate FCB
ENDIF
  RET

; Routine at 27319
__OPEN:
  LD BC,FINPRT
  PUSH BC
  CALL FILE_PARMS
  LD A,(HL)
  CP TK_FOR			; 'FOR'
  LD E,$04
  JR NZ,__OPEN_2
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP TK_INPUT		; 'INPUT'
  LD E,$01
  JR Z,__OPEN_INPUT
  
  CP TK_OUT			; 'OUT..PUT'
  JR Z,__OPEN_OUTPUT
  
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'P'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'P'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_END
  LD E,$08			; 'APPEND'
  JR __OPEN_2
  
__OPEN_OUTPUT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_PUT		; "OUTPUT"  :S
  LD E,$02
  JR __OPEN_2
__OPEN_INPUT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
__OPEN_2:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'S'			; 'AS'
  PUSH DE
  LD A,(HL)
  CP '#'
  CALL Z,__CHRGTB  ; Gets next character (or token) from BASIC text.
  CALL GETINT
  OR A
  JP Z,BN_ERR			; Err $34 -  'Bad file number'
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNOFO		; Hook for "OPEN": not found event
ENDIF

  DEFB $1E      ;LD E,N
NULOPN:
  PUSH DE		; open a "NULL" file

  DEC HL
  LD E,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  EX (SP),HL
  LD A,E
  PUSH AF
  PUSH HL
  CALL GETPTR
  JP NZ,AO_ERR		; Err $36 - "File already open"
  POP DE
  LD A,D
  CP $09
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNULO		; Hook for "OPEN"
ENDIF
  JP C,IE_ERR				; Err $33 - "Internal Error"
  PUSH HL
  LD BC,$0004
  ADD HL,BC
  LD (HL),D
  LD A,$00
  POP HL
  CALL GET_DEVICE
  POP AF
  POP HL
  RET

; Data block at 27428
  ; --- START PROC CLOSE ---
CLOSE:
  PUSH HL
  OR   A
  JR   NZ,NTFL0
  LD   A,(NLONLY)		; <>0 when loading program
  AND  $01
  JP   NZ,POPHLRT2      ;   POP HL / RET
  
; NTFL0 - "NoT FiLe number 0"
NTFL0:
  CALL GETPTR
  JR   Z,L6B4A 		; CLOSE_1
  LD   (PTRFIL),HL
  PUSH HL
  JR   C,L6B41		; CLOSE_0
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNTFL			; Hook for Close I/O buffer 0 event
ENDIF
  JP   IE_ERR			; Err $33 - "Internal Error"

 ; CLOSE_0
L6B41:
  LD   A,$02
  CALL GET_DEVICE
  CALL CLRBUF
  POP  HL
 ; CLOSE_1
L6B4A:
  PUSH HL
  LD   DE,$0007
  ADD  HL,DE
  LD   (HL),A
  LD   H,A
  LD   L,A
  LD (PTRFIL),HL		; Redirect I/O
  POP HL
  ADD A,(HL)
  LD (HL),$00
  POP HL
  RET

; Routine at 27483
;
; load and RUN a file when text is addedd to "RUN"
;
; Used by the routine at __RUN.
_RUN_FILE:
  SCF
  defb $11	; LD DE,NN

; Routine at 19824
__LOAD:
  defb $f6		; OR $AF

; Routine at 19825
__MERGE:
  XOR A
  PUSH AF
  CALL FILE_PARMS
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HMERG		; Hook for "MERGE/LOAD"
ENDIF
  POP AF
  PUSH AF
  JR Z,_LOAD_0
  LD A,(HL)
  SUB ','
  OR A
  JR NZ,_LOAD_0
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'R'
  POP AF
  SCF				; Set the 'RUN' flag 
  PUSH AF
_LOAD_0:
  PUSH AF
  XOR A
  LD E,$01
  CALL NULOPN		; OPEN a "NULL file"
  LD HL,(PTRFIL)
  LD BC,$0007
  ADD HL,BC
  POP AF
  SBC A,A
  AND $80
  OR $01
  LD (NLONLY),A
  POP AF
  PUSH AF
  SBC A,A
  LD (FILNAM),A
  LD A,(HL)
  OR A
  JP M,L6BD4			; handle "bad file name" for MERGE/LOAD
  
  POP AF
  CALL NZ,CLRPTR
  XOR A
  CALL SETFIL
  JP PROMPT

; Routine at 27555
__SAVE:
  CALL FILE_PARMS
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSAVE		; Hook 1 for "SAVE"
ENDIF
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD E,$80
  SCF
  JR Z,__SAVE_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'			;   Save in ASCII mode ?
  OR A
  LD E,$02
__SAVE_0:
  PUSH AF
  LD A,D
  CP $09
  JR C,__SAVE_1
  LD E,$02
  POP AF
  XOR A
  PUSH AF
__SAVE_1:
  XOR A
  CALL NULOPN		; OPEN a "NULL file"
  POP AF
  JR C,__SAVE_2
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __LIST
  
__SAVE_2:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HBINS		; Hook 2 for "SAVE"
ENDIF
  JP NM_ERR					; Err $38 -  'Bad file name'

; Routine at 27604
;
; Used by the routine at _LOAD.
; handle "bad file name" for MERGE/LOAD
L6BD4:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HBINL		; Hook for "MERGE/LOAD"
ENDIF
  JP NM_ERR					; Err $38 -  'Bad file name'

; Routine at 27610
L6BDA:
  PUSH HL
  PUSH DE
  LD HL,(PTRFIL)
  LD DE,$0004
  ADD HL,DE
  LD A,(HL)
  POP DE
  POP HL
  RET

; Routine at 27623
;
; Used by the routines at L6BFB and CLSALL.
L6BE7:
  JR NZ,L6BFB_0
  PUSH HL
; This entry point is used by the routine at L6BF3.
L6BE7_0:
  PUSH BC
  PUSH AF
  LD DE,L6BF3
  PUSH DE
  PUSH BC
  OR A
  RET

; Routine at 27635
L6BF3:
  POP AF
  POP BC
  DEC A
  JP P,L6BE7_0
  POP HL
  RET

; Routine at 27643
L6BFB:
  POP BC
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  RST CHRGTB		; Gets next character (or token) from BASIC text.
; This entry point is used by the routine at L6BE7.
L6BFB_0:
  PUSH BC
  LD A,(HL)
  CP '#'
  CALL Z,__CHRGTB		; Gets next character (or token) from BASIC text.
  CALL GETINT
  EX (SP),HL
  PUSH HL
  LD DE,L6BFB
  PUSH DE
  SCF
  JP (HL)

__CLOSE:
  LD BC,CLOSE
  LD A,(MAXFIL)
  JR L6BE7

; Routine at 27676
;
; Used by the routines at L628E, __END and __MAX.
; Close all files
CLSALL:
  LD A,(NLONLY)
  OR A
  RET M
  LD BC,CLOSE
  XOR A
  LD A,(MAXFIL)
  JR L6BE7

; Routine at 27690
__LFILES:
  LD A,$01
  LD (PRTFLG),A
__FILES:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFILE				; Hook for "FILES"
ENDIF
  JP FC_ERR

; Routine at 27701
;
; Used by the routine at L7756.
GET:
  PUSH AF
  CALL L6A9E
  JR C,GET_0
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDGET				; Hook for "GET/PUT"
ENDIF
  JP NM_ERR					; Err $38 -  'Bad file name'

GET_0:
  POP DE
  POP BC
  LD A,$04
  JP GET_DEVICE

; Data block at 27720
FILO:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL CHECK_STREAM
  JR NC,L6C57
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFILO			; Hook for "Sequential Output" event
ENDIF
  JP NM_ERR					; Err $38 -  'Bad file name'
		
L6C57:
  POP  AF
  PUSH AF
  LD C,A
  LD A,$06
  CALL GET_DEVICE
  JP START_TAP_OUT_RET_0

; Check stream buffer status before I/O operations
CHECK_STREAM:
  PUSH DE
  LD HL,(PTRFIL)
  EX DE,HL
  LD HL,$0004
  ADD HL,DE
  LD A,(HL)
  EX DE,HL
  POP DE
  CP $09
  RET

; Data block at 27761
  ; --- START PROC RDBYT ---
  ; Read byte, C flag is set if EOF
RDBYT:
  PUSH HL
L6C72:
  PUSH DE
  PUSH BC
  CALL CHECK_STREAM
  JR   NC,L6C7F
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HINDS				; Hook for "Sequential Input" exception
ENDIF
  JP   IE_ERR				; Err $33 - "Internal Error"


L6C7F:
  LD A,$08
  CALL GET_DEVICE
  JP START_TAP_OUT_RET_1

; Routine at 27783
;
; Used by the routine at OPRND.
FN_INPUT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '$'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  PUSH HL
  LD HL,(PTRFIL)
  PUSH HL
  LD HL,$0000
  LD (PTRFIL),HL		; Redirect I/O
  POP HL
  EX (SP),HL
  CALL GETINT
  PUSH DE
  LD A,(HL)
  CP ','
  JR NZ,FN_INPUT_1
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL L6A9E
  CP $01
  JP Z,FN_INPUT_0
  CP $04
  JP NZ,EF_ERR		; Err $37 - "Input past END" (EOF)
FN_INPUT_0:
  POP HL
  XOR A
  LD A,(HL)
FN_INPUT_1:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found\n
  DEFB ')'
  POP AF
  EX (SP),HL
  PUSH AF
  LD A,L
  OR A
  JP Z,FC_ERR
  PUSH HL
  CALL MKTMST			; Make temporary string
  EX DE,HL
  POP BC
FN_INPUT_2:
  POP AF
  PUSH AF
  JR Z,FN_INPUT_4
  CALL CHGET
  PUSH AF
  CALL CKCNTC
  POP AF
FN_INPUT_3:
  LD (HL),A
  INC HL
  DEC C
  JR NZ,FN_INPUT_2
  POP AF
  POP BC
  POP HL
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HRSLF				; Hook for "INPUT$"
ENDIF
  LD (PTRFIL),HL		; Redirect I/O
  PUSH BC
  JP TSTOPL

FN_INPUT_4:
  CALL RDBYT
  JP C,EF_ERR		; Err $37 - "Input past END" (EOF)
  JR FN_INPUT_3

; Routine at 27882
CLRBUF:
  CALL GETBUF
  PUSH HL
  LD B,$00
  CALL L6CF5
POPHLRT2:
  POP HL
  RET

; Routine at 27893
;
; Used by the routine at CLRBUF.
L6CF5:
  XOR A
L6CF5_0:
  LD (HL),A
  INC HL
  DJNZ L6CF5_0
  RET

; Routine at 27899
;
; Used by the routine at CLRBUF.
GETBUF:
  LD HL,(PTRFIL)
  LD DE,$0009
  ADD HL,DE
  RET

; Routine at 27907
__LOC:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSAVD			; Init Hook for LOC, LOF, EOF, FPOS
ENDIF
  CALL GETFLP
  JR Z,__EOF_0
  LD A,$0A
  JR C,__EOF_1
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLOC				; Hook for LOC
ENDIF
  JR _IE_ERR

; Routine at 27924
__LOF:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSAVD			; Init Hook for LOC, LOF, EOF, FPOS
ENDIF
  CALL GETFLP
  JR Z,__EOF_0
  LD A,$0C
  JR C,__EOF_1
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLOF				; Hook for LOF
ENDIF
  JR _IE_ERR

; Routine at 27941
__EOF:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSAVD			; Init Hook for LOC, LOF, EOF, FPOS
ENDIF
  CALL GETFLP
; This entry point is used by the routines at __LOC and __LOF.
__EOF_0:
  JP Z,CF_ERR			; Err $3B - "File not OPEN"
  LD A,$0E
; This entry point is used by the routines at __LOC, __LOF and __FPOS.
__EOF_1:
  JP C,GET_DEVICE
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HEOF				; Hook for EOF
ENDIF
; This entry point is used by the routines at __LOC, __LOF and __FPOS.
_IE_ERR:
  JP IE_ERR				; Err $33 - "Internal Error"

; Routine at 27961
__FPOS:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSAVD			; Init Hook for LOC, LOF, EOF, FPOS
ENDIF
  CALL GETFLP
  LD A,$10
  JR C,__EOF_1
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFPOS			; Hook for FPOS
ENDIF
  JR _IE_ERR

; Routine at 27976
EXEC_FILE:
  CALL ISFLIO
  JP Z,EXEC
  XOR A
  CALL CLOSE
  JP L6E71		; Err $39 - Direct statement in a file

; Routine at 27989
;
; Used by the routine at SET_INPUT_CHANNEL.
; Get stream number (default #channel=1
GT_CHANNEL:
  LD C,$01
; Get stream number (C=default #channel)
GET_CHNUM:
  CP '#'
  RET NZ
  PUSH BC
  CALL FNDNUM
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  LD A,E
  PUSH HL
  CALL SETFIL
  LD A,(HL)
  POP HL
  POP BC
  CP C
  JR Z,GT_CHANNEL_1
  CP $04
  JR Z,GT_CHANNEL_1
  CP $08
  JR NZ,GT_CHANNEL_0
  LD A,C
  CP $02
GT_CHANNEL_0:
  JP NZ,BN_ERR			; Err $34 -  'Bad file number'
GT_CHANNEL_1:
  LD A,(HL)
  RET

; Routine at 28027
;
; Used by the routine at L7380.
CLOSE_STREAM:
  LD BC,WARM_ENTRY_0
  PUSH BC
  XOR A
  JP CLOSE

; Routine at 28035
;
; Used by the routine at __READ.
__READ_INPUT:
  RST GETYPR 		; Get the number type (FAC)
  LD BC,__READ_DONE
  LD DE,$2C20		;  D=','  E=' '
  JR NZ,LINE_INPUT_0		; JP if not string type
  LD E,D
  JR LINE_INPUT_0

; Data block at 28047
LINE_INPUT:
  LD  BC,FINPRT
  PUSH BC
  CALL GT_CHANNEL
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  LD BC,__LET_00
  XOR A
  LD D,A
  LD E,A
LINE_INPUT_0:
  PUSH AF
  PUSH BC
  PUSH HL
LINE_INPUT_1:
  CALL RDBYT
  JP C,EF_ERR		; Err $37 - "Input past END" (EOF)
  CP ' '
  JR NZ,LINE_INPUT_2
  INC D
  DEC D
  JR NZ,LINE_INPUT_1
LINE_INPUT_2:
  CP '"'
  JR NZ,LINE_INPUT_3
  LD A,E
  CP ','
  LD A,'"'
  JR NZ,LINE_INPUT_3
  LD D,A
  LD E,A
  CALL RDBYT
  JR C,L6E0D
LINE_INPUT_3:
  LD HL,BUF
  LD B,$FF
LINE_INPUT_4:
  LD C,A
  LD A,D
  CP '"'
  LD A,C
  JR Z,L6DFC
  CP CR
  PUSH HL
  JR Z,L6E27
  POP HL
  CP LF
  JR NZ,L6DFC
L6DDC:
  LD C,A
  LD A,E
  CP ','
  LD A,C
  CALL NZ,L6E61
  CALL RDBYT
  JR C,L6E0D
  CP LF
  JR Z,L6DDC
  CP CR
  JR NZ,L6DFC
  LD A,E
  CP ' '
  JR Z,L6E08
  CP ','
  LD A,CR
  JR Z,L6E08
L6DFC:
  OR A
  JR Z,L6E08
  CP D
  JR Z,L6E0D
  CP E
  JR Z,L6E0D
  CALL L6E61
L6E08:
  CALL RDBYT
  JR NC,LINE_INPUT_4
L6E0D:
  PUSH HL
  CP '"'
  JR Z,L6E16
  CP ' '
  JR NZ,NOSKCR
L6E16:
  CALL RDBYT
  JR C,NOSKCR
  CP ' '
  JR Z,L6E16
  CP ','
  JR Z,NOSKCR
  CP CR
  JR NZ,L6E30
L6E27:
  CALL RDBYT
  JR C,NOSKCR
  CP LF
  JR Z,NOSKCR
L6E30:
  LD C,A
  CALL CHECK_STREAM
  JR NC,L6E3C
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HBAKU			; Hook for "LINE INPUT#"
ENDIF
  JP IE_ERR			; Err $33 - "Internal Error"

L6E3C:
  LD A,$12		; INS ?  .. TK_LEN ?
  CALL GET_DEVICE

NOSKCR:
  POP HL
; This entry point is used by the routine at L6E61.
L6E35_0:
  LD (HL),$00
  LD HL,BUFMIN
  LD A,E
  SUB $20
  JR Z,L6E35_1
  LD B,$00
  CALL QTSTR_0		; Eval '0' quoted string
  POP HL
  RET
  
L6E35_1:
  RST GETYPR 		; Get the number type (FAC)
  PUSH AF
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH AF
  CALL C,DBL_ASCTFP
  POP AF
  CALL NC,DBL_ASCTFP
  POP HL
  RET

; Routine at 28257
L6E61:
  OR A
  RET Z
  LD (HL),A
  INC HL
  DEC B
  RET NZ
  POP AF
  JP L6E35_0

; Routine at 28267
;
; Used by the routines at L55F8, FILE_PARMS, __SAVE, L6BD4, GET, __BSAVE, BLOAD_1,
; L71AB, L71D9 and GET_DEVNO.
NM_ERR:
  LD E,$38 ; - Bad file name

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
AO_ERR:
  LD E,$36 ; - File already open
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
L6E71:
  LD E,$39 ; - Direct statement in a file

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
FF_ERR:
  LD E,$35 ; - File not found

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
CF_ERR:
  LD E,$3B ; - File not OPEN

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
L6E7A:
  LD E,$32 ; - FIELD overflow

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
BN_ERR:
  LD E,$34 ; - Bad file number

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
IE_ERR:
  LD E,$33 ; - Internal error

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
EF_ERR:
  LD E,$37 ; - Input past end

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
ERR_NO_RNDACC:
  LD E,$3A ; - Sequential I/O Only

  XOR A
  LD (NLONLY),A
  LD (FLBMEM),A
  JP ERROR			; Error $00


; Routine at 28306
__BSAVE:
  CALL FILE_PARMS
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL BSAVE_PARM
  EX DE,HL
  LD (SAVENT),HL
  EX DE,HL
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL BSAVE_PARM
  EX DE,HL
  LD (SAVEND),HL
  EX DE,HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__BSAVE_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL BSAVE_PARM
  EX DE,HL
  LD (SAVENT),HL
  EX DE,HL
__BSAVE_0:
  POP BC
  POP DE
  PUSH HL
  PUSH BC
  LD A,D
  CP $FF
  JP Z,DO_BSAVE
  JP NM_ERR					; Err $38 -  'Bad file name'

; Data block at 28358
; $6EC6
__BLOAD:
  CALL FILE_PARMS
  PUSH DE
  XOR A
  LD  (RUNBNF),A	; Reset "Run Binary File After loading" flag (see below)
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD  BC,$0000
  JR  Z,BLOAD_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP  'R'
  JR  NZ,BLOAD_0
  LD  (RUNBNF),A	; Run Binary File After loading ( Bload"File.Bin",R ) 0 = Don't Run / 1 = Run
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR  Z,BLOAD_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
BLOAD_0:
  CALL BSAVE_PARM
  LD  B,D
  LD  C,E
BLOAD_1:
  POP DE
  PUSH HL
  PUSH BC
  LD A,D
  CP $FF
  JP Z,TAPE_LOAD		; load data from tape (incl. header)
  JP NM_ERR					; Err $38 -  'Bad file name'

; Routine at 28404
;
; Used by the routine at TAPE_LOAD.
TAPE_LOAD_END:
  LD A,(RUNBNF)			; Run Binary File After loading ( Bload"File.Bin",R ) 0 = Don't Run / 1 = Run
  OR A
  JR Z,SPSVEX
  XOR A
  CALL CLOSE
  LD HL,POPHLRT2      ;   POP HL / RET
  PUSH HL
  LD HL,(SAVENT)
  JP (HL)

; Named SPSVEX only to suggest a retro compatibility with the SVI318
SPSVEX:
  POP HL
  XOR A
  JP CLOSE

; Routine at 28427
;
; Used by the routine at __BSAVE.
BSAVE_PARM:
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  POP DE
  EX DE,HL
  RET

; Data block at 28437
; --- START PROC L6F15 ---
;
; Parse Device Name
L6F15:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPARD		; Hook 1 for "Parse device name" event
ENDIF
  LD A,(HL)
  CP ':'
  JR C,POSDSK
  PUSH HL
  LD D,E
  LD A,(HL)
  INC  HL
  DEC  E
  JR Z,L6F2E
L6F24:
  CP ':'
  JR Z,GET_DEVNAME
  LD A,(HL)
  INC  HL
  DEC  E
  JP P,L6F24
L6F2E:
  LD E,D
  POP  HL
  XOR  A
  LD A,$FF
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNODE		; Hook 2 for "Parse device name" event
ENDIF
  RET

 
POSDSK:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPOSD		; Hook 3 for "Parse device name" event
ENDIF
  JP NM_ERR					; Err $38 -  'Bad file name'

GET_DEVNAME:
  LD A,D
  SUB E
  DEC A
  POP BC
  PUSH DE
  PUSH BC
  LD C,A		; dev name length
  LD B,A
  LD DE,DEVICE_TBL
  EX (SP),HL
  PUSH HL
DEVN_LOOP:
  CALL UCASE_HL		; Load A with char in 'HL' and make it uppercase
  PUSH BC
  LD B,A
  LD A,(DE)
  INC HL
  INC DE
  CP B
  POP BC
  JR NZ,GET_DEVNAME_2
  DEC C
  JR NZ,DEVN_LOOP
GET_DEVNAME_1:
  LD A,(DE)
  OR A
  JP P,GET_DEVNAME_2
  POP HL
  POP HL
  POP DE
  OR A
  RET
  
GET_DEVNAME_2:
  OR A
  JP M,GET_DEVNAME_1
GET_DEVNAME_3:
  LD A,(DE)
  ADD A,A
  INC DE
  JR NC,GET_DEVNAME_3
  LD C,B
  POP HL
  PUSH HL
  LD A,(DE)
  OR A
  JR NZ,DEVN_LOOP
  JP L55F8			; deal with exceptions/expansions

; Message at 28534
DEVICE_TBL:
  DEFM "CAS"
  DEFB $FF
  DEFM "LPT"
  DEFB $FE
  DEFM "CRT"
  DEFB $FD
  DEFM "GRP"
  DEFB $FC
  DEFB $00

; Table to define Token groups ?
DEVICE_VECT:
  DEFW CAS_CTL
  DEFW LPT_CTL
  DEFW CRT_CTL
  DEFW GRP_CTL

; This entry point is used by the routines at __OPEN, GET, L6C50, L6C78,
; __EOF and L6E35.

; Routine location: $6F8F
GET_DEVICE:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HGEND			; Hook for I/O function dispatcher
ENDIF
  PUSH HL
  PUSH DE
  PUSH AF
  LD DE,$0004
  ADD HL,DE
  LD A,(HL)
  CP $FC		; TK_BKSLASH ?
  JP C,L564A
  LD A,$FF
  SUB (HL)
  ADD A,A
  LD E,A
  LD HL,DEVICE_VECT
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP AF
  LD L,A
  LD H,$00
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  POP DE
  EX (SP),HL
  RET

; Routine at 28599
__CSAVE:
  CALL L7098
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__CSAVE_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL L7A2D
__CSAVE_0:
  PUSH HL
  LD A,TK_NAME			; Token for "NAME"
  CALL SEND_CAS_FNAME
  LD HL,(VARTAB)
  LD (SAVEND),HL
  LD HL,(TXTTAB)
  CALL __CSAVE_1
  POP HL
  RET

; Routine at 28631
;
; Used by the routine at __BSAVE.
DO_BSAVE:
  LD A,TK_BSAVE
  CALL SEND_CAS_FNAME
  XOR A
  CALL START_TAP_OUT		; start tape for writing
  POP HL
  PUSH HL
  CALL L7003			; send word to tape
  LD HL,(SAVEND)
  PUSH HL
  CALL L7003			; send word to tape
  LD HL,(SAVENT)
  CALL L7003			; send word to tape
  POP DE
  POP HL
DO_BSAVE_0:
  LD A,(HL)
  CALL TAPOUT_SUB		; send byte to tape
  RST DCOMPR		; Compare HL with DE.
  JR NC,DO_BSAVE_1
  INC HL
  JR DO_BSAVE_0
DO_BSAVE_1:
  CALL TAPOOF
  POP HL
  RET

; Routine at 28675
;
; Used by the routine at DO_BSAVE.
; send word to tape
L7003:
  LD A,L
  CALL TAPOUT_SUB		; send byte to tape
  LD A,H
  JP TAPOUT_SUB		; send byte to tape

; Routine at 28683
;
; Used by the routine at TAPE_LOAD.
; get word from tape
BLOAD_HL:
  CALL BLOAD_A                   ; get byte from tape
  LD L,A
  CALL BLOAD_A                   ; get byte from tape
  LD H,A
  RET

; Routine at 28692
;
; Used by the routine at BLOAD_1.
; load data from tape (incl. header)
TAPE_LOAD:
  LD C,TK_BSAVE
  CALL L70B8
  CALL START_TAP_IN                   ; start tape for reading
  POP BC
  CALL BLOAD_HL                   ; get word from tape
  ADD HL,BC
  EX DE,HL
  CALL BLOAD_HL                   ; get word from tape
  ADD HL,BC
  PUSH HL
  CALL BLOAD_HL                   ; get word from tape
  LD (SAVENT),HL
  EX DE,HL
  POP DE
TAPE_LOAD_0:
  CALL BLOAD_A                   ; get byte from tape
  LD (HL),A
  RST DCOMPR		; Compare HL with DE.
  JR Z,TAPE_LOAD_1
  INC HL
  JR TAPE_LOAD_0
TAPE_LOAD_1:
  CALL TAPIOF
  JP TAPE_LOAD_END

; Routine at 28735
__CLOAD:
  SUB $91		 ; TK_PRINT  (=CLOAD?)
  JR Z,L7044+1
  XOR A
L7044:
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
  CPL
  INC HL
  
  CP $01
  PUSH AF
  CALL L708C
  LD C,TK_NAME
  CALL L70B8
  
  POP AF
  LD (FACLOW),A
  CALL C,CLRPTR
  LD A,(FACLOW)
  CP $01
  LD (FRCNEW),A
  PUSH AF
  CALL LINE2PTR_00
  POP AF
  LD HL,(TXTTAB)
  CALL L715D
  JR NZ,__CLOAD_1
  LD (VARTAB),HL
__CLOAD_0:
  LD HL,OK_MSG				; "Ok" Message
  CALL PRS
  LD HL,(TXTTAB)
  PUSH HL
  JP L4237

__CLOAD_1:
  INC HL
  EX DE,HL
  LD HL,(VARTAB)
  RST DCOMPR		; Compare HL with DE.
  JP C,__CLOAD_0
  LD E,$14				; Err $14 - "Verify error"
  JP ERROR

; Data block at 28812
  ; --- START PROC L708C ---
L708C:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.

L708E:
  JR  NZ,L7098
  PUSH HL
  LD  HL,RUNFLG
  LD  B,$06
  JR  L70B1

  ; --- START PROC L7098 ---
L7098:
  CALL EVAL
  PUSH HL
  CALL __ASC_0
  DEC HL
  DEC HL
  LD  B,(HL)
  LD  C,$06
  LD  HL,RUNFLG
L70A7:
  LD  A,(DE)
  LD  (HL),A
  INC HL
  INC DE
  DEC C
  JR  Z,L70B6
  DJNZ L70A7
  LD  B,C
L70B1:
  LD (HL),' '
  INC HL
  DJNZ L70B1
L70B6:
  POP HL
  RET

; Routine at 28856
;
; Used by the routines at TAPE_LOAD, __CLOAD and L71D9.
L70B8:
  CALL START_TAP_IN                   ; start tape for reading
  LD B,$0A

L70B8_0:
  CALL BLOAD_A         ; get byte from tape
  CP C
  JR NZ,L70B8
  DJNZ L70B8_0
  
  LD HL,FILNM2
  PUSH HL
  LD B,$06           ; 6 bytes
L70B8_1:
  CALL BLOAD_A         ; get byte from tape
  LD (HL),A
  INC HL
  DJNZ L70B8_1
  POP HL

  LD DE,FILNAM
  LD B,$06           ; 6 bytes
L70B8_2:
  LD A,(DE)
  INC DE
  CP ' '
  JR NZ,CMP_FNAME
  DJNZ L70B8_2
  JR FILE_FOUND
  
CMP_FNAME:
  LD DE,FILNAM
  LD B,$06           ; 6 bytes
CMP_FNAME_LOOP:
  LD A,(DE)
  CP (HL)
  JR NZ,SKIP_CAS_FILE
  INC HL
  INC DE
  DJNZ CMP_FNAME_LOOP
  
FILE_FOUND:
  LD HL,FOUND_MSG
  JP PRINT_FNAME_MSG
  
SKIP_CAS_FILE:
  PUSH BC
  LD HL,SKIP_MSG
  CALL PRINT_FNAME_MSG
  POP BC
  JR L70B8

; Message at 28927
FOUND_MSG:
  DEFM "Found:"
  DEFB $00
  
SKIP_MSG:
  DEFM "Skip :"
  DEFB $00

PRINT_FNAME_MSG:
  LD DE,(CURLIN)		 ; Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
  INC DE
  LD A,D
  OR E
  RET NZ
  CALL PRS
  LD HL,FILNM2
  LD B,$06
PRNAME_LOOP:
  LD A,(HL)
  INC HL
  RST OUTDO  		; Output char to the current device
  DJNZ PRNAME_LOOP
  JP OUTDO_CRLF

; Routine at 28965
;
; Used by the routines at __CSAVE, DO_BSAVE and L71D9.
SEND_CAS_FNAME:
  CALL START_TAP_OUT		; start tape for writing
  LD B,$0A
SEND_CAS_FNAME_0:
  CALL TAPOUT_SUB		; send byte to tape
  DJNZ SEND_CAS_FNAME_0
  LD B,$06
  LD HL,FILNAM
SEND_CAS_FNAME_1:
  LD A,(HL)
  INC HL
  CALL TAPOUT_SUB		; send byte to tape
  DJNZ SEND_CAS_FNAME_1
  JP TAPOOF

; Routine at 28990
;
; Used by the routine at __CSAVE.
__CSAVE_1:
  PUSH HL
  CALL LINE2PTR_00
  XOR A
  CALL START_TAP_OUT		; start tape for writing
  POP DE
  LD HL,(SAVEND)
__CSAVE_1_0:
  LD A,(DE)
  INC DE
  CALL TAPOUT_SUB		; send byte to tape
  RST DCOMPR		; Compare HL with DE.
  JR NZ,__CSAVE_1_0
  LD L,$07
__CSAVE_1_1:
  CALL TAPOUT_SUB		; send byte to tape
  DEC L
  JR NZ,__CSAVE_1_1
  JP TAPOOF

; Routine at 29021
;
; Used by the routine at __CLOAD.
L715D:
  CALL START_TAP_IN                   ; start tape for reading
  SBC A,A
  CPL
  LD D,A
L715D_0:
  LD B,$0A       ; 10 bytes
L715D_1:
  CALL BLOAD_A     ; get byte from tape
  LD E,A
  CALL ENFMEM   ; $6267 = ENFMEM (reference not aligned to instruction)
  LD A,E
  SUB (HL)
  AND D
  JP NZ,TAPIOF
  LD (HL),E
  LD A,(HL)
  OR A
  INC HL
  JR NZ,L715D_0
  DJNZ L715D_1
  
  LD BC,$FFFA		; -6
  ADD HL,BC
  XOR A
  JP TAPIOF


; Data block at 29058
; GRP: Device Control Table/Driver
; $7182
GRP_CTL:
  DEFW DEVICE_OPEN
  DEFW DO_NOTHING		; CLOSE operation
  DEFW ERR_NO_RNDACC
  DEFW GRP_OUTPUT

  DEFW FC_ERR		; INPUT operation
  DEFW FC_ERR
  DEFW FC_ERR
  DEFW FC_ERR		; EOF operation
  DEFW FC_ERR
  DEFW FC_ERR		; UNGETC operation

GRP_OUTPUT:
  LD A,(SCRMOD)
  CP $02
  JP C,FC_ERR
  LD A,C
; Routine at 29087
L719F:
  JP GRPPRT

  
  
; Routine at 29090
; CRT: Device Control Table/Driver
; $71A2
CRT_CTL:
  DEFW DEVICE_OPEN
  DEFW DO_NOTHING		; CLOSE operation
  DEFW ERR_NO_RNDACC
  DEFW CRT_OUTPUT
  
  DEFW FC_ERR		; INPUT operation
  DEFW FC_ERR
  DEFW FC_ERR
  DEFW FC_ERR		; EOF operation
  DEFW FC_ERR
  DEFW FC_ERR		; UNGETC operation
  
DEVICE_OPEN:
  CALL GET_DEVNO	; Get device number
  CP $01
  JP Z,NM_ERR					; Err $38 -  'Bad file name'
; This entry point is used by the routine at L71D9.
REDIRECT_IO:
  LD (PTRFIL),HL
  LD (HL),E
DO_NOTHING:
  RET

; Routine at 29123
CRT_OUTPUT:
  LD A,C
  JP CHPUT

; Data block at 29127
; CAS: Device Control Table/Driver
;$71C7
CAS_CTL:
  DEFW CAS_OPEN
  DEFW CAS_CLOSE
  DEFW ERR_NO_RNDACC
  DEFW CAS_OUTPUT
  
  DEFW CAS_INPUT
  DEFW FC_ERR
  DEFW FC_ERR
  DEFW CAS_EOF
  DEFW FC_ERR
  DEFW CAS_UNGETC

CAS_OPEN:
  PUSH HL
  PUSH DE
  LD BC,$0006
  ADD HL,BC					; char count
  XOR A
  LD (HL),A
  LD (CASPRV),A				; clear char for UNGETC
  CALL GET_DEVNO
  CP $04
  JP Z,NM_ERR				; Err $38 -  'Bad file name'

  CP $01
  JR Z,L71D9_1

  LD A,$EA			; TK_DSKI ?
  CALL SEND_CAS_FNAME
L71D9_0:
  POP DE
  POP HL
  JR REDIRECT_IO
  
L71D9_1:
  LD C,$EA			; TK_DSKI ?
  CALL L70B8
  CALL TAPIOF
  JR L71D9_0
  
; Routine at 29189
CAS_CLOSE:
  LD A,(HL)
  CP $01
  JR Z,CAS_CLOSE_1
  LD A,$1A		; EOF
  PUSH HL
  CALL INIT_DEV_OUTPUT
  CALL Z,CAS_OUTPUT_0
  POP HL
  CALL CLOSE_DEVICE
  JR Z,CAS_CLOSE_1
  PUSH HL
  ADD HL,BC
CAS_CLOSE_0:
  LD (HL),$1A		; EOF
  INC HL
  INC C
  JR NZ,CAS_CLOSE_0
  POP HL
  CALL CAS_OUTPUT_0
CAS_CLOSE_1:
  XOR A
  LD (CASPRV),A
  RET

; Routine at 29226
CAS_OUTPUT:
  LD A,C
  CALL INIT_DEV_OUTPUT
  RET NZ
; This entry point is used by the routine at CAS_CLOSE.
CAS_OUTPUT_0:
  XOR A
  CALL START_TAP_OUT		; start tape for writing
  LD B,$00
CAS_OUTPUT_1:
  LD A,(HL)
  CALL TAPOUT_SUB		; send byte to tape
  INC HL
  DJNZ CAS_OUTPUT_1
  JP TAPOOF

; Routine at 29247
;
; Used by the routine at CAS_EOF.
CAS_INPUT:
  EX DE,HL
  LD HL,CASPRV
  CALL GET_BYTE
  EX DE,HL
  CALL INIT_INPUT
  JR NZ,CAS_INPUT_1
  PUSH HL
  CALL START_TAP_IN                   ; start tape for reading
  POP HL
  LD B,$00
CAS_INPUT_0:
  CALL BLOAD_A                   ; get byte from tape
  LD (HL),A
  INC HL
  DJNZ CAS_INPUT_0
  CALL TAPIOF
  DEC H
  XOR A
  LD B,A
CAS_INPUT_1:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A		; EOF
  SCF
  CCF
  RET NZ
  LD (CASPRV),A
  SCF
  RET

; Routine at 29293
CAS_EOF:
  CALL CAS_INPUT
  LD HL,CASPRV
  LD (HL),A
  SUB $1A		; EOF
  SUB $01
  SBC A,A
  JP INT_RESULT_A

; Routine at 29308
CAS_UNGETC:
  LD HL,CASPRV
  LD (HL),C
  RET

; Routine at 29313
;
; Used by the routine at CAS_CLOSE.
CLOSE_DEVICE:
  LD BC,$0006
  ADD HL,BC					; char count
  LD A,(HL)
  LD C,A
  LD (HL),$00
  JR DEVICE_RET

; Routine at 29323
;
; Used by the routines at CAS_CLOSE and CAS_OUTPUT.
INIT_DEV_OUTPUT:
  LD E,A
  LD BC,$0006
  ADD HL,BC					; char count
  LD A,(HL)
  INC (HL)
  INC HL
  INC HL
  INC HL
  PUSH HL
  LD C,A
  ADD HL,BC
  LD (HL),E
  POP HL
  RET

; Routine at 29339
;
; Used by the routine at CAS_INPUT.
INIT_INPUT:
  LD BC,$0006
  ADD HL,BC					; char count
  LD A,(HL)
  INC (HL)
; This entry point is used by the routine at CLOSE_DEVICE.
DEVICE_RET:
  INC HL
  INC HL
  INC HL
  AND A
  RET

; Data block at 29350
; LPT: Device Control Table/Driver
; $72A6
LPT_CTL:
  DEFW DEVICE_OPEN
  DEFW DO_NOTHING		; CLOSE operation
  DEFW ERR_NO_RNDACC
  DEFW LPT_OUTPUT
 
  DEFW FC_ERR		; INPUT operation
  DEFW FC_ERR
  DEFW FC_ERR
  DEFW FC_ERR		; EOF operation
  DEFW FC_ERR
  DEFW FC_ERR		; UNGETC operation

LPT_OUTPUT:
  LD A,C
  JP OUTDLP


; Routine at 29374
;
; Used by the routine at CAS_INPUT.
GET_BYTE:
  LD A,(HL)
  LD (HL),$00
  AND A
  RET Z
  INC SP
  INC SP
  CP $1A		; EOF
  SCF
  CCF
  RET NZ
  LD (HL),A
  SCF
  RET

; Routine at 29389
;
; Used by the routines at L71AB and L71D9.
; Copy the current device/stream/channel number to A
GET_DEVNO:
  LD A,E
  CP $08
  JP Z,NM_ERR		; Err $38 -  'Bad file name'
  RET

; Routine at 29396
;
; Used by the routines at BLOAD_HL, TAPE_LOAD, L70B8, L715D and CAS_INPUT.
; get byte from tape
BLOAD_A:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL TAPIN	; Get byte from cassette
  JR NC,START_TAP_OUT_RET_1
  JR TAPE_ERROR

; Routine at 29406
;
; Used by the routines at DO_BSAVE, L7003, SEND_CAS_FNAME, __CSAVE_1 and CAS_OUTPUT.
; send byte to tape
TAPOUT_SUB:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL TAPOUT
  JR NC,START_TAP_OUT_RET_0
  JR TAPE_ERROR

; Routine at 29417
;
; Used by the routines at TAPE_LOAD, L70B8, L715D and CAS_INPUT.
; start tape for reading
START_TAP_IN:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL TAPION
  JR NC,START_TAP_OUT_RET_0
; This entry point is used by the routines at BLOAD_A and TAPOUT_SUB.
TAPE_ERROR:
  CALL TAPIOF
  JP IO_ERR

; Routine at 29432
;
; Used by the routines at DO_BSAVE, SEND_CAS_FNAME, __CSAVE_1 and CAS_OUTPUT.
; start tape for writing
START_TAP_OUT:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL TAPOON
; This entry point is used by the routines at L6C50, TAPOUT_SUB and START_TAP_IN.
START_TAP_OUT_RET_0:
  POP AF
; This entry point is used by the routines at L6C78 and BLOAD_A.
START_TAP_OUT_RET_1:
  POP BC
  POP DE
  POP HL
  RET

; Routine at 29444
;
; Used by the routines at L628E and __END.
STOP_LPT:
  XOR A
  LD (PRTFLG),A
  LD A,(LPTPOS)
  OR A
  RET Z
  LD A,CR
  CALL LPTOUT_SAFE
  LD A,LF
  CALL LPTOUT_SAFE
  XOR A
  LD (LPTPOS),A
  RET

; Routine at 29468
;
; Used by the routine at STOP_LPT.
LPTOUT_SAFE:
  CALL LPTOUT
  RET NC
  JP IO_ERR

; Routine at 29475
;
; Used by the routines at LINE2PTR and __END.
CONSOLE_CRLF:
  LD A,(TTYPOS)
  OR A
  RET Z
  
; This entry point is used by the routines at L4A5A, __LLIST, L61C4, L710B and
; __KEY.
OUTDO_CRLF:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCRDO		; Hook for "CRLF to OUTDO" events
ENDIF
  LD A,CR
  RST OUTDO  		; Output char to the current device
  LD A,LF
  RST OUTDO  		; Output char to the current device
; This entry point is used by the routines at L4A5A, PRS1 and __LIST_3.
CRLF_DONE:
  CALL ISFLIO		; Tests if I/O to device is taking place
  JR Z,RESET_POS
  XOR A
  RET

RESET_POS:
  LD A,(PRTFLG)		; Printer output flag ?
  OR A
  JR Z,TTY_FLUSH
  XOR A
  LD (LPTPOS),A		; Reset printer head position
  RET

TTY_FLUSH:
  LD (TTYPOS),A		; Reset TTY position
  RET

; Routine at 29511
;
; Used by the routine at OPRND.
FN_INKEY:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL CHSNS
  JR Z,INKEY_S_0
  CALL CHGET
  PUSH AF
  CALL MK_1BYTE_TMST
  POP AF
  LD E,A
  CALL __CHR_S_0
INKEY_S_0:
  LD HL,NULL_STRING
  LD (FACLOW),HL
  LD A,$03			; String
  LD (VALTYP),A
  POP HL
  RET

; Routine at 29543
;
; Used by the routine at __LIST_2.
__LIST_3:
  RST OUTDO  		; Output char to the current device
  CP LF
  RET NZ
  LD A,CR
  RST OUTDO  		; Output char to the current device
  CALL CRLF_DONE
  LD A,LF
  RET


; Accepts a line from a file or device

; Data block at 29556
PINSTREAM:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDSKC  		; ($FEEE) Hook for  Mainloop line input
ENDIF
  LD B,$FF
  LD HL,BUF
L737C:
  CALL RDBYT
  JR C,EOF_REACHED
  LD (HL),A
  CP CR
  JR Z,NEXT_LINE
  CP $09		; TAB
  JR Z,L7380_0
  CP LF
  JR Z,L737C
L7380_0:
  INC HL
  DJNZ L737C
NEXT_LINE:
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET
  
EOF_REACHED:
  INC B
  JR NZ,NEXT_LINE
  LD A,(NLONLY)
  AND $80
  LD (NLONLY),A
  CALL CLOSE_STREAM
  LD A,(FILNAM)
  AND A
  JP Z,RESTART
  CALL RUN_FST
  JP EXEC_EVAL

; Routine at 29618
;
; Used by the routines at START_TAP_IN and LPTOUT_SAFE.
IO_ERR:
  LD E,$13				; Err $13 - "Device I/O error"
  JP ERROR

; Routine at 29623
__MOTOR:
  LD E,$FF
  JR Z,__MOTOR_0
  SUB TK_OFF
  LD E,A
  JR Z,L73C4+1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_ON
  LD E,$01
L73C4:
	; L73C4+1:   RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$D7
__MOTOR_0:
  LD A,E
  JP STMOTR

; Routine at 29642
__SOUND:
  CALL GETINT
  CP $0E			; ?
  JP NC,FC_ERR
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
;:::::::::::::::::::::
L73D8:
  POP AF
;:::::::: CODE RELOCATION IS SAFE STARTING FROM HERE ::::::::
  CP $07
  JR NZ,__SOUND_0
  RES 6,E
  SET 7,E
__SOUND_0:
  JP WRTPSG

; Data block at 29668
L73E4:
  DEFB ' '

__PLAY:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HPLAY  		; Hook for 'PLAY'
ENDIF

  PUSH HL
  LD HL,PLAY_TAB
  LD (MCLTAB),HL
  LD A,$00
  LD (PRSCNT),A		; Used by PLAY command in BASIC	
  LD HL,$FFF6		; -10
  ADD HL,SP
  LD (SAVSP),HL		; Used by PLAY command in BASIC
  POP HL
  PUSH AF
L73FD:
  CALL EVAL
  EX (SP),HL
  PUSH HL
  CALL GETSTR
  CALL LOADFP
  LD A,E
  OR A
  JR NZ,L7413
  LD E,$01
  LD BC,L73E4		; points to ' '.. empty play queue
  LD D,C
  LD C,B

; Routine at 29715
L7413:
  POP AF
  PUSH AF
  CALL GETVCP	; Returns pointer to play queue
  LD (HL),E		; = 1
  INC HL
  LD (HL),D
  INC HL
  LD (HL),C
  INC HL
  LD D,H
  LD E,L
  LD BC,$001C		; 28
  ADD HL,BC
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP BC
  POP HL
  INC B
  LD A,B
  CP $03			; TK_MID_S ?
  JR NC,L7439_0
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,L7439
  PUSH BC
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JR L73FD

; Routine at 29753
L7439:
  LD  A,B
  LD  (VOICEN),A
  CALL L7507
  INC B
  LD A,B
  CP $03
  JR C,L7439
; This entry point is used by the routine at L7413.
L7439_0:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  PUSH HL
; This entry point is used by the routine at L748E.
L7439_1:
  XOR A
; This entry point is used by the routine at L748E.
L7439_2:
  PUSH AF
  LD (VOICEN),A
  LD B,A
  CALL L7521
  JP C,L748E_3
  LD A,B
  CALL GETVCP	; Returns pointer to play queue
  LD A,(HL)
  OR A
  JP Z,L748E_3
  LD (MCLLEN),A
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD (MCLPTR),DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  LD L,$24
  CALL GETVC2
  PUSH HL
  LD HL,(SAVSP)
  DEC HL
  POP BC
  DI
  CALL L6250_0
  POP DE
  LD H,B
  LD L,C
  LD SP,HL
  EI
  LD A,$FF
  LD (MCLFLG),A
  JP L5683_2

; Routine at 29838
;
; Used by the routine at L7684.
L748E:
  LD A,(MCLLEN)
  OR A
  JR NZ,L748E_1
; This entry point is used by the routine at L5683.
L748E_0:
  CALL L7507
L748E_1:
  LD A,(VOICEN)
  CALL GETVCP
  LD A,(MCLLEN)
  LD (HL),A
  INC HL
  LD DE,(MCLPTR)
  LD (HL),E
  INC HL
  LD (HL),D
  LD HL,$0000
  ADD HL,SP
  EX DE,HL
  LD HL,(SAVSP)
  DI
  LD SP,HL
  POP BC
  POP BC
  POP BC
  PUSH HL
  OR A
  SBC HL,DE
  JR Z,L748E_2
  LD A,$F0
  AND L
  OR H
  JP NZ,FC_ERR
  LD L,$24
  CALL GETVC2
  POP BC
  DEC BC
  CALL L6250_0
  POP HL
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  JR L748E_3
L748E_2:
  POP BC
  POP BC
; This entry point is used by the routine at L7439.
L748E_3:
  EI
  POP AF
  INC A
  CP $03
  JP C,L7439_2
  DI
  LD A,(INTFLG)
  CP $03
  JR Z,L748E_6
  LD A,(PRSCNT)
  RLCA
  JR C,L748E_4
  LD HL,PLYCNT
  INC (HL)
  CALL STRTMS
L748E_4:
  EI
  LD HL,PRSCNT
  LD A,(HL)
  OR $80
  LD (HL),A
  CP $83		; TK_NEXT ?
  JP NZ,L7439_1
L748E_5:
  POP HL
  RET
L748E_6:
  CALL GICINI
  JR L748E_5

; Routine at 29959
;
; Used by the routines at L7439 and L748E.
L7507:
  LD A,(PRSCNT)
  INC A
  LD (PRSCNT),A
  LD E,$FF
; This entry point is used by the routine at L7684.
L7507_0:
  PUSH HL
  PUSH BC
L7507_1:
  PUSH DE
  LD A,(VOICEN)
  DI
  CALL PUTQ
  EI
  POP DE
  JR Z,L7507_1
  POP BC
  POP HL
  RET


; Routine at 29985
;
; Used by the routines at L7439 and L7684.
L7521:
  LD A,(VOICEN)
  PUSH BC
  DI
  CALL LFTQ			; Gives number of bytes left in queue
  EI
  POP BC
  CP $08
  RET


; Data table at 29998
;$5D83
PLAY_TAB:
  DEFB 'A'
  DEFW PLAY_NOTE
  
  DEFB 'B' 
  DEFW PLAY_NOTE
  
  DEFB 'C' 
  DEFW PLAY_NOTE
  
  DEFB 'D' 
  DEFW PLAY_NOTE
  
  DEFB 'E' 
  DEFW PLAY_NOTE
  
  DEFB 'F' 
  DEFW PLAY_NOTE
  
  DEFB 'G' 
  DEFW PLAY_NOTE

  DEFB 'M'+$80
  DEFW ENVELOPE_CYCLE	; Envelope cycle setting *2 (1..65535)

  DEFB 'V'+$80
  DEFW VOLUME			; Volume (0..15)
  
  DEFB 'S'+$80
  DEFW ENVELOPE_SHAPE	; Envelope shape *2 (0..15)
  
  DEFB 'N'+$80
  DEFW RAISE_NOTE		; Plays Note raised to n (0..96)

  DEFB 'O'+$80
  DEFW OCTAVE			; Octave (1..8)
  
  DEFB 'R'+$80
  DEFW REST				; Rest setting (1..64)

  DEFB 'T'+$80
  DEFW TEMPO			; Tempo setting (32..255)

  DEFB 'L'+$80
  DEFW LENGTH			; Length (1..64)

  DEFB 'X'		; .. Plays MML string stored in variable A$
  DEFW X_MACRO
  
  DEFB $00


PLAY_TAB_2:
  DEFB $10
  DEFB $12
  DEFB $14
  DEFB $16
  DEFB $00,$00
  DEFB $02
  DEFB $04
  DEFB $06
  DEFB $08
  DEFB $0a,$0a
  DEFB $0c
  DEFB $0e
  DEFB $10
  
  
PLAY_TAB_3:
  DEFW  $0D5D,  $0C9C,  $0BE7,  $0B3C,  $0A9B,  $0A02
  DEFW  $0973,  $08EB,  $086B,  $07F2,  $0780,  $0714

  
  
; Volume (0..15)
VOLUME:
  JR C,SET_VOLUME
  LD E,8		; Default volume: 8
SET_VOLUME:
  LD A,15		; Max volume: 15
  CP E
  JR C,_FC_ERR_C

SET_ENVELOPE:
  XOR A
  OR D
  JR NZ,_FC_ERR_C
  LD L,$12
  CALL GETVC2
  LD A,$40
  AND (HL)
  OR E
  LD (HL),A
  RET

; Routine at 30110
;
; Used by the routine at L752E.
; Envelope cycle setting *2 (1..65535)
ENVELOPE_CYCLE:
  LD A,E
  JR C,SET_ENV_CYCLE
  CPL
  INC A
  LD E,A
SET_ENV_CYCLE:
  OR D
  JR Z,_FC_ERR_C
  LD L,$13
  CALL GETVC2
  PUSH HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RST DCOMPR		; Compare HL with DE.
  POP HL
  RET Z
  LD (HL),E
  INC HL
  LD (HL),D
  DEC HL
  DEC HL
  LD A,$40
  OR (HL)
  LD (HL),A
  RET

; Routine at 30142
; Envelope shape *2 (0..15)
ENVELOPE_SHAPE:
  LD A,E
  CP 15+1		; Max envelope shape: 15
  JR NC,_FC_ERR_C
  OR $10
  LD E,A
  JR SET_ENVELOPE

; Data block at 30152
  ; --- START PROC LENGTH ---
; Length (1..64)
LENGTH:
  JR C,SET_LENGHT
  LD E,4			; Default Length: 4
SET_LENGHT:
  LD A,E
  CP 64+1				; Max Length: 64
  JR NC,_FC_ERR_C
  LD L,$10
  ; --- START PROC L75D3 ---
SETVC2:
  CALL GETVC2
  XOR  A
  OR D
  JR NZ,_FC_ERR_C
  OR E
  JR Z,_FC_ERR_C
  LD (HL),A
  RET

  ; --- START PROC _FC_ERR_C ---
_FC_ERR_C:
  CALL FC_ERR
  
  ; --- START PROC TEMPO ---
; Tempo setting (32..255)
TEMPO:
  JR C,SET_TEMPO
  LD E,120		; Default tempo: 120
SET_TEMPO:
  LD A,E
  CP 32			; Max tempo: 32
  JR C,_FC_ERR_C
  LD L,$11
  JR SETVC2

; Routine at 30191
; Octave (1..8)
OCTAVE:
  JR C,SET_OCTAVE
  LD E,4		; Default octave: 4
SET_OCTAVE:
  LD A,E
  CP 8+1		; Max octave: 8
  JR NC,_FC_ERR_C
  LD L,$0F
  JR SETVC2
  
; Routine at 30204
;
; Used by the routine at L752E.
; Rest setting (1..64)
REST:
  JR C,SET_REST
  LD E,4		; Default REST value: 4
SET_REST:
  XOR A
  OR D
  JR NZ,_FC_ERR_C
  OR E
  JR Z,_FC_ERR_C
  CP $41
  JR NC,_FC_ERR_C
; This entry point is used by the routine at RAISE_NOTE.
REST_1:
  LD HL,$0000
  PUSH HL
  LD L,$10
  CALL GETVC2
  PUSH HL
  INC HL
  INC HL
  LD A,(HL)
  LD (SAVVOL),A
  LD (HL),$80
  DEC HL
  DEC HL
  JR L7684_1

; Routine at 30241
RAISE_NOTE:
  JR NC,_FC_ERR_C
  XOR A
  OR D
  JR NZ,_FC_ERR_C
  OR E
  JR Z,REST_1
  CP 96+1			; Max RAISE value: 96
  JR NC,_FC_ERR_C
  LD A,E
  LD B,$00
  LD E,B
RAISE_NOTE_0:
  SUB $0C
  INC E
  JR NC,RAISE_NOTE_0
  ADD A,$0C
  ADD A,A
  LD C,A
  JP PLAY_NOTE_4

; Routine at 30270
PLAY_NOTE:
  LD B,C
  LD A,C
  SUB $40
  ADD A,A
  LD C,A
  CALL MCL_ITEM
  JR Z,PLAY_NOTE_2
  CP '#'		; Sharp (raise half tone) 
  JR Z,PLAY_SHARP_NOTE
  CP '+'		; Sharp (raise half tone) 
  JR Z,PLAY_SHARP_NOTE
  CP '-'		; Flat (Lower half tone)
  JR Z,PLAY_FLAT_NOTE
  CALL MCL_PREV_ITEM
  JR PLAY_NOTE_2

; Flat (Lower half tone)
PLAY_FLAT_NOTE:
  DEC C
  LD A,B
  CP 'C'
  JR Z,PLAY_NOTE_1		; 'C flat' does not exist, compensate..
  CP 'F'
  JR NZ,PLAY_NOTE_2		; 'F flat' does not exist, compensate..
PLAY_NOTE_1:
  DEC C			; lower the table ptr
PLAY_NOTE_2:
  DEC C			; lower the table ptr
; Sharp (raise half tone) 
PLAY_SHARP_NOTE:
  LD L,$0F
  CALL GETVC2
  LD E,(HL)
  LD B,$00
  LD HL,PLAY_TAB_2
  ADD HL,BC
  LD C,(HL)
; This entry point is used by the routine at RAISE_NOTE.
PLAY_NOTE_4:
  LD HL,PLAY_TAB_3
  ADD HL,BC
  LD A,E
  LD E,(HL)
  INC HL
  LD D,(HL)
PLAY_NOTE_5:
  DEC A
  JR Z,L7684_0
  SRL D
  RR E
  JR PLAY_NOTE_5

; Routine at 30340
L7684:
  CALL FC_ERR  ;???
  
; This entry point is used by the routine at PLAY_NOTE.
L7684_0:
  ADC A,E
  LD E,A
  ADC A,D
  SUB E
  LD D,A
  PUSH DE
  LD L,$10
  CALL GETVC2
  LD C,(HL)
  PUSH HL
  CALL MCL_ITEM
  JR Z,L7684_2
  CALL L5719_1
; This entry point is used by the routine at REST.
L7684_1:
  LD A,$40
  CP E
  JR C,L7684
  XOR A
  OR D
  JR NZ,L7684
  OR E
  JR Z,L7684_2
  LD C,E
L7684_2:
  POP HL
  LD D,$00
  LD B,D
  INC HL
  LD E,(HL)
  PUSH HL
  CALL MLDEBC
  EX DE,HL
  CALL HL_CSNG
  CALL FP_ARG2HL
  LD HL,SP_FPCONST		; Single precision float const
  CALL PHLTFP
  CALL DECDIV		; /
  CALL __CINT
  LD D,H
  LD E,L
L7684_3:
  CALL MCL_ITEM
  JR Z,L7684_5
  CP '.'			; $2E
  JR NZ,L7684_4
  SRL D
  RR E
  ADC HL,DE
  LD A,$E0
  AND H
  JR Z,L7684_3
  XOR H
  LD H,A
  JR L7684_5
L7684_4:
  CALL MCL_PREV_ITEM
L7684_5:
  LD DE,$0005
  RST DCOMPR		; Compare HL with DE.
  JR C,L7684_6
  EX DE,HL
L7684_6:
  LD BC,$FFF7		; -9
  POP HL
  PUSH HL
  ADD HL,BC
  LD (HL),D
  INC HL
  LD (HL),E
  INC HL
  LD C,$02
  EX (SP),HL
  INC HL
  LD E,(HL)
  LD A,E
  AND $BF
  LD (HL),A
  EX (SP),HL
  LD A,$80
  OR E
  LD (HL),A
  INC HL
  INC C
  EX (SP),HL
  LD A,E
  AND $40
  JR Z,L7715+1
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
  LD (HL),D
  INC HL
  LD (HL),E
  INC HL
  INC C
  INC C
L7715:
	; L7715+1: POP HL
  CP $E1
  POP DE
  LD A,D
  OR E
  JR Z,L7684_7
  LD (HL),D
  INC HL
  LD (HL),E
  INC C
  INC C
L7684_7:
  LD L,$07
  CALL GETVC2
  LD (HL),C
  LD A,C
  SUB $02
  RRCA
  RRCA
  RRCA
  INC HL
  OR (HL)
  LD (HL),A
  DEC HL
  LD A,D
  OR E
  JR NZ,L7684_8
  PUSH HL
  LD A,(SAVVOL)
  OR $80
  LD BC,$000B
  ADD HL,BC
  LD (HL),A
  POP HL
L7684_8:
  POP DE
  LD B,(HL)
  INC HL
L7684_9:
  LD E,(HL)
  INC HL
  CALL L7507_0
  DJNZ L7684_9
  CALL L7521
  JP C,L748E
  JP L5683_2

; Pointed by routine at L7684
; numeric float const  (10?)
SP_FPCONST:
  DEFB $00
  DEFB $00
  DEFB $45
  DEFB $12


__PUT:
  LD B,$80
  DEFB 17	; "LD DE,nn" to jump over the next word without executing it

__GET:
  LD B,$00
  CP TK_SPRITE
  JP Z,PUT_SPRITE
  LD A,B
  JP GET

; Routine at 30566
__LOCATE:
  LD DE,(CSRY)
  PUSH DE
  CP ','
  JR Z,__LOCATE_0
  CALL GETINT
  INC A
  POP DE
  LD D,A
  PUSH DE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__LOCATE_3
__LOCATE_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,__LOCATE_1
  CALL GETINT
  INC A
  POP DE
  LD E,A
  PUSH DE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__LOCATE_3
__LOCATE_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  AND A
  LD A,'y'
  JR NZ,__LOCATE_2
  DEC A
__LOCATE_2:
  PUSH AF
  LD A,ESC
  RST OUTDO  		; Output char to the current device
  POP AF			; ESC_y (set cursor coordinates) / ???
  RST OUTDO  		; Output char to the current device
  LD A,$35			; '5'
  RST OUTDO  		; Output char to the current device
__LOCATE_3:
  EX (SP),HL
  CALL POSIT
  POP HL
  RET

; Routine at 30629
;
; Used by the routine at __STOP.
L77A5:
  PUSH HL
  LD HL,$FC6A		; Unkown system variable
  JR _TRIG_0

; Routine at 30635
;
; Used by the routine at __SPRITE.
L77AB:
  PUSH HL
  LD HL,IFLG_COLLSN		; Sprite collision - Interrupt flags
  JR _TRIG_0

; Routine at 30641
;
; Used by the routine at NOT_KEYWORD.
_INTERVAL:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'E'			; "INTE..."
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'R'			; "INTER..."
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB $FF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_VAL+$80	; "INTERVAL"
  PUSH HL
  LD HL,IFLG_TIMER		; TIMER - Interrupt flags
  JR _TRIG_0

; Routine at 30655
;
; Used by the routine at NOT_KEYWORD.
; STICK(n) function
_TRIG:
  LD A,$04
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD D,$00
  LD HL,IFLG_STRIG0		; SPACE key trigger - Interrupt flags
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
; This entry point is used by the routines at L77A5, L77AB and _INTERVAL.
_TRIG_0:
  CALL L77FE
  JR __MDM_2

; Routine at 30676
; This entry point is used by the routine at _TRIG and KEY_CONFIG.
L77D4:
  CALL GETINT
  DEC A
  CP $0A
  JP NC,FC_ERR
  LD A,(HL)
  PUSH HL
  CALL L77E8

__MDM_2:
  POP HL
  POP AF
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP EXEC_EVAL_0

; Routine at 30696
;
; Used by the routine at L77D4.
L77E8:
  LD D,$00
  LD HL,FNKSWI
  ADD HL,DE
  PUSH HL
  LD HL,TRPTBL-3		; BOTTOM+1
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
  CALL L77FE
  LD A,(HL)
  AND $01
  POP HL
  LD (HL),A
  RET

; Routine at 30718
;
; Used by the routines at _TRIG and L77E8.
L77FE:
  CP TK_ON
  JP Z,TIME_S_ON
  CP TK_OFF
  JP Z,TIME_S_OFF
  CP TK_STOP
  JP Z,TIME_S_STOP
  JP SN_ERR

; Routine at 30736
ONGO:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HONGO		; Hook for "ON DEVICE GOSUB"
ENDIF
  LD BC,$000A		; 1, 10
  CP TK_KEY
  RET Z
  LD BC,$0A01		; 10, 1
  CP TK_STOP
  RET Z
  INC B				; 10, 2
  CP TK_SPRITE
  RET Z
  CP $FF			; Lower TOKEN codes prefix ?
  RET C
  PUSH HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP TK_TRIG+$80	; $A3
  JR Z,ONGO_1
  
  CP TK_INT+$80		; INTERVAL ?
  JR Z,ON_INTERVAL
  
ONGO_0:
  POP HL
  SCF
  RET

ONGO_1:
  POP BC
  LD BC,$0C05		; 12, 5
  RET

ON_INTERVAL:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP 'E'			; "INTE.."
  JR NZ,ONGO_0
  POP BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'R'			; "INTER.."
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB $FF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_VAL+$80	; "INTERVAL"
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  CALL GETWORD
  LD A,D
  OR E
  JP Z,FC_ERR
  EX DE,HL
  LD (INTVAL),HL
  LD (INTCNT),HL
  EX DE,HL
  LD BC,$1101		; 17, 1
  DEC HL
  RET

  
; Routine at 30812
;
; Used by the routine at L492A.
L785C:
  PUSH HL
  LD B,A	; compute (B*3)+IENTRY_F1
  ADD A,A
  ADD A,B
  LD L,A
  LD H,$00
  LD BC,TRPTBL+1		; First entry in the table for interrupt services
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; Routine at 30828
__KEY:
  CP TK_LIST		; "KEY LIST" command ?
  JR NZ,KEY_CONFIG
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,FNKSTR
  LD C,$0A
__KEY_0:
  LD B,$10
__KEY_1:
  LD A,(HL)
  INC HL
  CALL SNVCHR
  JR C,__KEY_2
  DEC B
  JR Z,__KEY_5
  LD A,(HL)
  INC HL
  LD E,A
  CALL SNVCHR
  JR Z,__KEY_2
  LD A,$01
  RST OUTDO  		; Output char to the current device
  LD A,E
  JR __KEY_4

__KEY_2:
  CP $7F			; 'DEL' key code
  JR Z,__KEY_3
  CP ' '
  JR NC,__KEY_4
__KEY_3:
  LD A,' '
__KEY_4:
  RST OUTDO  		; Output char to the current device
  DJNZ __KEY_1
__KEY_5:
  CALL OUTDO_CRLF
  DEC C
  JR NZ,__KEY_0
  POP HL
  RET

; Routine at 30886
KEY_ON:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP DSPFNK		; Show the function key display.

; Routine at 30890
KEY_OFF:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP ERAFNK

; Data block at 30894
KEY_CONFIG:
  CP '('
  JP Z,L77D4
  CP TK_ON		; "KEY ON"
  JR Z,KEY_ON
  
  CP TK_OFF		; "KEY OFF"
  JR Z,KEY_OFF
  
  CALL GETINT
  DEC A
  CP LF
  JP NC,FC_ERR
  EX DE,HL
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD BC,FNKSTR		; FUNCTION KEY AREA
  ADD HL,BC
  PUSH HL
  EX DE,HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD B,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
  EX (SP),HL
  LD C,$0F
  LD A,B
  AND A
  JR Z,KEY_CONFIG_1
KEY_CONFIG_0:
  LD A,(DE)
  AND A
  JP Z,FC_ERR
  LD (HL),A
  INC DE
  INC HL
  DEC C
  JR Z,KEY_CONFIG_2
  DJNZ KEY_CONFIG_0
KEY_CONFIG_1:
  LD (HL),B
  INC HL
  DEC C
  JR NZ,KEY_CONFIG_1
KEY_CONFIG_2:
  LD (HL),C
  CALL FNKSB
  POP HL
  RET

; Routine at 30976
;
; Used by the routine at OPRND.
FN_TIME:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,(JIFFY)
  CALL DBL_ABS_0
  POP HL
  RET

; Routine at 30986
;
; Used by the routine at OPRND.
FN_CSRLIN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD A,(CSRY)
  JR FN_PLAY_1

; Routine at 30993
__TIME:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  CALL GETWORD
  LD (JIFFY),DE
  RET

; Routine at 31003
;
; Used by the routine at OPRND.
FN_PLAY:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$03			; 3 possible sound channels
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  PUSH HL
  LD A,(MUSICF)
  DEC E
  JP M,FN_PLAY_3
FN_PLAY_0:
  RRCA
  DEC E
  JP P,FN_PLAY_0
  LD A,$00
  JR NC,FN_PLAY_2
; This entry point is used by the routine at FN_CSRLIN.
FN_PLAY_1:
  DEC A
FN_PLAY_2:
  CALL INT_RESULT_A
  POP HL
  RET
  
FN_PLAY_3:
  AND $07
  JR Z,FN_PLAY_2
  LD A,$FF
  JR FN_PLAY_2

; Routine at 31040
__STICK:
  CALL MAKINT
  CP $03
  JR NC,__STRIG_0
  CALL GTSTCK
  JR __PDL_0

; Routine at 31052
__STRIG:
  CALL MAKINT
  CP $05
; This entry point is used by the routines at __STICK, __PDL and __PAD.
__STRIG_0:
  JP NC,FC_ERR
  CALL GTTRIG
; This entry point is used by the routine at __PAD.
__STRIG_1:
  JP INT_RESULT_A

; Routine at 31066
__PDL:
  CALL MAKINT
  DEC A
  CP $0C
  JR NC,__STRIG_0
  INC A
  CALL GTPDL
; This entry point is used by the routines at __STICK and __PAD.
__PDL_0:
  JP PASSA

; Routine at 31081
__PAD:
  CALL MAKINT
  CP $08
  JR NC,__STRIG_0
  PUSH AF
  CALL GTPAD
  LD B,A
  POP AF
  AND $03
  DEC A
  CP $02
  LD A,B
  JR C,__PDL_0
  JR __STRIG_1

; Routine at 31104
__COLOR:
  LD BC,FC_ERR
  PUSH BC
  LD DE,(FORCLR)
  PUSH DE
  CP ','
  JR Z,__COLOR_0
  CALL GETINT
  POP DE
  CP $10		; 16 colors
  RET NC
  LD E,A
  PUSH DE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__COLOR_2
__COLOR_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JR Z,__COLOR_2
  CP ','
  JR Z,__COLOR_1
  CALL GETINT
  POP DE
  CP $10		; 16 colors
  RET NC
  LD D,A
  PUSH DE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__COLOR_2
__COLOR_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  POP DE
  CP $10		; 16 colors
  RET NC
  LD (BDRCLR),A
  PUSH DE
__COLOR_2:
  POP DE
  POP AF
  PUSH HL
  EX DE,HL
  LD (FORCLR),HL
  LD A,L
  LD (ATRBYT),A
  CALL CHGCLR
  POP HL
  RET

; Routine at 31180
__SCREEN:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSCRE		; Hook for "SCREEN"
ENDIF
  CP ','
  JR Z,__SCREEN_0
  CALL GETINT
  CP $04
  JP NC,FC_ERR
  PUSH HL
  CALL CHGMOD		; Sets the VDP mode according to SCRMOD.
  LD A,(LINLEN)
  LD E,A
  CALL __WIDTH_4
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
__SCREEN_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,__SCREEN_1
  CALL GETINT
  CP $04
  JP NC,FC_ERR
  LD A,(RG1SAV)
  AND $FC
  OR E
  LD (RG1SAV),A
  PUSH HL
  CALL CLRSPR
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
__SCREEN_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,__SCREEN_2
  CALL GETINT
  LD (CLIKSW),A
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
__SCREEN_2:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,__SCREEN_3
  CALL L7A2D
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
__SCREEN_3:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  LD (NTMSXP),A
  RET

; Routine at 31277
;
; Used by the routines at __CSAVE and __SCREEN.
L7A2D:
  CALL GETINT
  DEC A
  CP $02
  JP NC,FC_ERR
  PUSH HL
  LD BC,$0005
  AND A
  LD HL,CS120
  JR Z,L7A2D_0
  ADD HL,BC
L7A2D_0:
  LD DE,LOW
  LDIR
  POP HL
  RET

; Routine at 31304
__SPRITE:
  CP $24
  JP NZ,L77AB
  LD A,(SCRMOD)
  AND A
  JP Z,FC_ERR
  CALL GET_HEXBYTE
  PUSH DE
  CALL NEXT_EQUAL
  EX (SP),HL
  PUSH HL
  CALL GETSTR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  CALL GSPSIZ
  LD C,A
  LD B,$00
  DEC HL
  DEC HL
  DEC A
  CP (HL)
  LD A,(HL)
  JR C,__SPRITE_0
  POP HL
  PUSH HL
  PUSH AF
  XOR A
  CALL FILVRM
  POP AF
  AND A
  LD C,A
  LD B,$00
__SPRITE_0:
  EX DE,HL
  POP DE
  CALL NZ,LDIRVM
  POP HL
  RET

; Routine at 31364
;
; Used by the routine at OPRND.
FN_SPRITE:
  CALL GETNEXT_HEXBYTE
  PUSH HL
  PUSH DE
  CALL GSPSIZ
  LD C,A
  LD B,$00
  PUSH BC
  CALL MKTMST			; Make temporary string
  LD HL,(TMPSTR)
  EX DE,HL
  POP BC
  POP HL
  CALL LDIRMV
  JP TSTOPL

; Routine at 31391
;
; Used by the routine at FN_SPRITE.
GETNEXT_HEXBYTE:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

; This entry point is used by the routine at __SPRITE.
GET_HEXBYTE:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '$'
  LD A,$FF			; A whole byte range
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  PUSH HL
  LD A,E
  CALL CALPAT
  EX DE,HL
  POP HL
  RET

; Routine at 31407
;
; Used by the routine at L7756.
PUT_SPRITE:
  DEC B
  JP M,FC_ERR
  LD A,(SCRMOD)
  AND A
  JP Z,FC_ERR
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL GETINT
  CP 32
  JP NC,FC_ERR
  PUSH HL
  CALL CALATR
  EX (SP),HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,PUT_SPRITE_1
  CALL COORD_PARMS
  EX (SP),HL
  LD A,E
  CALL WRTVRM
  LD A,B
  ADD A,A
  LD A,C
  LD B,$00
  JR NC,PUT_SPRITE_0
  ADD A,$20
  LD B,$80
PUT_SPRITE_0:
  INC HL
  CALL WRTVRM
  INC HL
  INC HL
  CALL RDVRM
  AND $0F
  OR B
  CALL WRTVRM
  DEC HL
  DEC HL
  DEC HL
  EX (SP),HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP BC
  RET Z
  PUSH BC
PUT_SPRITE_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,PUT_SPRITE_2
  CALL GETINT
  CP $10
  JP NC,FC_ERR
  EX (SP),HL
  INC HL
  INC HL
  INC HL
  CALL RDVRM
  AND $80
  OR E
  CALL WRTVRM
  DEC HL
  DEC HL
  DEC HL
  EX (SP),HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP BC
  RET Z
  PUSH BC
PUT_SPRITE_2:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  CALL GSPSIZ
  LD A,E
  JR NC,PUT_SPRITE_3
  CP $40
  JP NC,FC_ERR
  ADD A,A
  ADD A,A
PUT_SPRITE_3:
  EX (SP),HL
  INC HL
  INC HL
  CALL WRTVRM
  POP HL
  RET

; Routine at 31543
__VDP:
  LD A,$07
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  CALL GETINT
  POP BC
  LD B,A
  JP WRTVDP

; Routine at 31559
;
; Used by the routine at OPRND.
FN_VDP:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$08
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  PUSH HL
  LD D,$00
  LD HL,RG0SAV
  ADD HL,DE
  LD A,(HL)
  CALL PASSA
  POP HL
  RET

; Routine at 31578
__BASE:
  LD A,$13
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  LD D,$00
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  CALL EVAL
  EX (SP),HL
  PUSH HL
  CALL PARMADDR		; get address parameter
  LD C,L
  LD B,H
  POP HL
  LD A,L
  PUSH AF
  ADD HL,HL
  EX DE,HL
  LD HL,L7BA3
  ADD HL,DE
  LD A,C
  AND (HL)
  JR NZ,__BASE_0
  INC HL
  LD A,B
  AND (HL)
__BASE_0:
  JP NZ,FC_ERR
  LD HL,TXTNAM
  ADD HL,DE
  LD (HL),C
  INC HL
  LD (HL),B
  POP AF
  LD E,$FF
__BASE_1:
  INC E
  SUB $05
  JR NC,__BASE_1
  LD A,(SCRMOD)
  CP E
  CALL Z,L7B99
  POP HL
  RET

; Routine at 31641
;
; Used by the routine at __BASE.
L7B99:
  DEC A
  JP M,SETTXT
  JP Z,SETGRP
  JP SETMLT

; Routine at 31651
L7BA3:
  DEFB $ff,$03, $3f,$00, $ff,$07, $7f,$00, $ff,$07
  DEFB $ff,$03, $3f,$00, $ff,$07, $7f,$00, $ff,$07
  DEFB $ff,$03, $ff,$1f, $ff,$1f, $7f,$00, $ff,$07
  DEFB $ff,$03, $3f,$00, $ff,$07, $7f,$00, $ff,$07

; This entry point is used by the routine at OPRND.
FN_BASE:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$13
  CALL BYTPPARM		; Get (byte parameter), use A to check its MAX value
  PUSH HL
  LD D,$00
  LD HL,TXTNAM
  ADD HL,DE
  ADD HL,DE
; This entry point is used by the routine at BYTPPARM.
FN_BASE_1:
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  CALL DBL_ABS_0
  POP HL
  RET

; Routine at 31714
__VPOKE:
  CALL EVAL
  PUSH HL
  CALL PARMADDR		; get address parameter
  EX (SP),HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  EX (SP),HL
  CALL WRTVRM
  POP HL
  RET

; Routine at 31733
__VPEEK:
  CALL PARMADDR		; get address parameter
  CALL RDVRM
  JP PASSA

; Routine at 31742
;
; Used by the routines at __BASE, __VPOKE and __VPEEK.
PARMADDR:
  CALL __CINT
  LD DE,$4000
  RST DCOMPR		; Compare HL with DE.
  RET C
  JR _FC_ERR_B

; Routine at 31752
;
; Used by the routines at _TRIG, FN_PLAY, GETNEXT_HEXBYTE, __VDP, FN_VDP, __BASE and L7BA3.
; Get (byte parameter), use A to check its MAX value
BYTPPARM:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  CALL GETINT
  POP AF
  CP E
  JR C,_FC_ERR_B
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  LD A,E
  RET

; Routine at 31766
__DSKO_S:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDSKO			; Hook for "DSKO$"
ENDIF
  JR _FC_ERR_B

; Routine at 31771
__SET:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HSETS			; Hook for SET
ENDIF
  JR _FC_ERR_B

; Routine at 31776
__NAME:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HNAME			; Hook for NAME
ENDIF
  JR _FC_ERR_B

; Routine at 31781
__KILL:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HKILL			; Hook for KILL
ENDIF
  JR _FC_ERR_B

; Routine at 31786
__IPL:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HIPL				; Hook for IPL
ENDIF
  JR _FC_ERR_B

; Routine at 31791
__COPY:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCOPY			; Hook for COPY
ENDIF
  JR _FC_ERR_B

; Routine at 31796
__CMD:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCMD				; Hook for CMD
ENDIF
  JR _FC_ERR_B

; Routine at 31801
__DSKF:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDSKF			; Hook for DSKF
ENDIF
  JR _FC_ERR_B

; Routine at 31806
;
; Used by the routine at OPRND.
FN_DSKI:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HDSKI			; Hook for DSKI$
ENDIF
  JR _FC_ERR_B

; Routine at 31811
;
; Used by the routine at OPRND.
FN_ATTR:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HATTR			; Hook for ATTR$
ENDIF
  JR _FC_ERR_B

; Routine at 31816
__LSET:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HLSET			; Hook for LSET
ENDIF
  JR _FC_ERR_B

; Routine at 31821
__RSET:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HRSET			; Hook for RSET
ENDIF
  JR _FC_ERR_B

; Routine at 31826
__FIELD:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HFIEL			; Hook for FIELD
ENDIF
  JR _FC_ERR_B

; Routine at 31831
__MKI_S:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HMKI_S			; Hook for MKI$
ENDIF
  JR _FC_ERR_B

; Routine at 31836
__MKS_S:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HMKS_S			; Hook for MKS$
ENDIF
  JR _FC_ERR_B

; Routine at 31841
__MKD_S:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HMKD_S			; Hook for MKD$
ENDIF
  JR _FC_ERR_B

; Routine at 31846
__CVI:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCVI				; Hook for CVI
ENDIF
  JR _FC_ERR_B

; Routine at 31851
__CVS:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCVS				; Hook for CVS
ENDIF
  JR _FC_ERR_B

; Routine at 31856
__CVD:
IF NOHOOK
 IF PRESERVE_LOCATIONS
   DEFS 3
 ENDIF
ELSE
  CALL HCVD				; Hook for CVD
ENDIF
; This entry point is used by the routines at PARMADDR, BYTPPARM, __DSKO_S, __SET,
; __NAME, __KILL, __IPL, __COPY, __CMD, __DSKF, FN_DSKI, FN_ATTR, __LSET, __RSET,
; __FIELD, __MKI_S, __MKS_S, __MKD_S, __CVI and __CVS.
_FC_ERR_B:
  JP FC_ERR

; Routine at 31862
;
; Used by the routine at CSTART.
_CSTART:
  LD SP,STACK_INIT
IF NOHOOK
  IF PRESERVE_LOCATIONS
  DEFS 13
  ENDIF
ELSE
  LD BC,$022F		; HOOK table size
  LD DE,HKEYI+1
  LD HL,HKEYI		; First Entry in the Hook Table
  LD (HL),$C9		; 'RET'
  LDIR
ENDIF
  LD HL,RDPRIM		;  First location in the System variables region
  LD (HIMEM),HL
  CALL BASE_RAM
  LD (BOTTOM),HL
  
IF SVI
  LD BC,$0076		; temporary workaround not to touch REPCNT ($F3F7 or >)
ELSE
  LD BC,$0090		; > $0076 crashes the SVI
ENDIF
  
  LD DE,RDPRIM		; Prepare System variables region, first location is $F380 (RDPRIM)
  LD HL,__RDPRIM	; 
  LDIR

IF SVI
	inc hl
	inc de
	ld bc, $90-$77
	ldir
ENDIF
  
  ;CALL INIT32
  ;HALT
  
  CALL INIFNK		; Init FN KEY region, starts at $F87F
  XOR A
  LD (ENDBUF),A
  LD (NLONLY),A
  LD A,','
  LD (BUFMIN),A
  LD A,':'
  LD (BUFFER),A
  LD HL,(FONT)			; Point to CHFONT in ROM
  LD (CHFONT),HL
  LD HL,PRMSTK		; Previous definition block on stack
  LD (PRMPRV),HL
  LD (STKTOP),HL
  LD BC,$00C8		; 200
  ADD HL,BC
  LD (MEMSIZ),HL
  LD A,$01
  LD (VARTAB+1),A
  CALL MAXFILES
  CALL CLREG  		; Clear registers and warm boot
  LD HL,(BOTTOM)
  XOR A
  LD (HL),A
  INC HL
  LD (TXTTAB),HL
  CALL CLRPTR
  CALL INITIO
  CALL INIT32
  CALL CLRSPR
  LD HL,$0A0B		; Cursor Position: 
  LD (CSRY),HL		
  LD HL,MSX_MSG		; "MSX System"
  CALL PRS
  LD HL,$0A0C		; Cursor Position: 
  LD (CSRY),HL
  LD HL,VER_MSG
  CALL PRS
IF SPECTRUM_SKIN
  LD HL,$060E		; Cursor Position: 
ELSE
  LD HL,$020E		; Cursor Position: 
ENDIF
  LD (CSRY),HL
  LD HL,COPYRIGHT_MSG
  CALL PRS
  LD B,$06
_CSTART_0:
  DEC HL
  LD A,L
  OR H
  JR NZ,_CSTART_0
  LD B,$00
  CALL L7D75
  LD HL,(BOTTOM)
  XOR A
  LD (HL),A
  INC HL
  LD (TXTTAB),HL
  CALL CLRPTR
  CALL BANNER
  JP READY

; Routine at 32041
;
; Used by the routine at _CSTART.
; Initial "copyright" message on top of the screen
; The "DISK BASIC" extension calls it directly skipping the 
; above call (adds the "DISK BASIC" message), so this can't be easily relocated
; (probably HOOKS need to be disabled in this case)
BANNER:
  LD A,$FF
  LD (CNSDFG),A		; FN key status
IF SPECTRUM_SKIN
  CALL INIT32
ELSE
  CALL INITXT
ENDIF
  LD HL,BASIC_MSG
  CALL PRS
  LD HL,VER_MSG
  CALL PRS
  LD HL,COPYRIGHT_MSG
  CALL PRS
  LD HL,(VARTAB)
  EX DE,HL
  LD HL,(STKTOP)
  ; HL=HL-DE
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  ;
  LD BC,$FFF2		; -14
  ADD HL,BC
  CALL _PRNUM
  LD HL,BYTES_MSG
  JP PRS

; Routine at 32093
;
; Used by the routine at _CSTART.
;  Programs mostly start on 0x8000 (if not otherwise descripted by TXTTAB)
BASE_RAM:
  LD HL,$8000		; 32768
; This entry point is used by the routine at L7D61.
JUST_RET:
  RET

; Routine at 32097
L7D61:
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  JR NZ,L7D61_0
  INC L
  JR NZ,JUST_RET
  LD A,H
  DEC A
  RET P
  LD H,A
  JR JUST_RET
L7D61_0:
  LD L,$00
  INC H
  RET

; Routine at 32117
;
; Used by the routine at _CSTART.
L7D75:
  DI
  LD C,$00
  LD DE,EXP0		; Expansion slot #0
  LD HL,SLTATR
L7D75_0:
  LD A,(DE)
  OR C
  LD C,A
  PUSH DE
L7D75_1:
  INC HL
  PUSH HL
  LD HL,$4000
L7D75_2:
  CALL RDSLT_WORD
  PUSH HL
  LD HL,$4241
  RST DCOMPR		; Compare HL with DE.
  POP HL
  LD B,$00
  JR NZ,L7D75_3
  CALL RDSLT_WORD
  PUSH HL
  PUSH BC
  PUSH DE
  POP IX
  LD A,C
  PUSH AF
  POP IY
  CALL NZ,CALSLT
  POP BC
  POP HL
  CALL RDSLT_WORD
  ADD A,$FF
  RR B
  CALL RDSLT_WORD
  ADD A,$FF
  RR B
  CALL RDSLT_WORD
  ADD A,$FF
  RR B
  LD DE,$FFF8		; -8
  ADD HL,DE
L7D75_3:
  EX (SP),HL
  LD (HL),B
  INC HL
  EX (SP),HL
  LD DE,$3FFE
  ADD HL,DE
  LD A,H
  CP $C0
  JR C,L7D75_2
  POP HL
  INC HL
  LD A,C
  AND A
  LD DE,RDSLT
  JP P,L7DDF+1
  ADD A,$04
  LD C,A
  CP $90
  JR C,L7D75_1
  AND $03
  LD C,A
L7DDF:
	; L7DDF+1:  ADD HL,DE
  LD A,$19
  POP DE
  INC DE
  INC C
  LD A,C
  CP $04
  JR C,L7D75_0
  LD HL,SLTATR
  LD B,$40
L7DEE:
  LD A,(HL)
  ADD A,A
  JR C,L7D75_5
  INC HL
  DJNZ L7DEE
  RET

L7D75_5:
  CALL L7E2A
  CALL ENASLT
  LD HL,(VARTAB)
  LD DE,$C000
  RST DCOMPR		; Compare HL with DE.
  JR NC,L7D75_6
  EX DE,HL
  LD (VARTAB),HL
L7D75_6:
  LD HL,($8008)		;  Programs mostly start on 0x8000 (if not otherwise descripted by TXTTAB)
  INC HL
  LD (TXTTAB),HL
  LD A,H
  LD (BASROM),A
  CALL RUN_FST
  JP EXEC_EVAL

; Routine at 32282
;
; Used by the routines at L55A7, L55F8, L564A and L7D75.
RDSLT_WORD:
  CALL RDSLT_WORD_0
  LD E,D
RDSLT_WORD_0:
  LD A,C
  PUSH BC
  PUSH DE
  CALL RDSLT
  POP DE
  POP BC
  LD D,A
  OR E
  INC HL
  RET

; Routine at 32298
;
; Used by the routines at L55A7, L55F8 and L7D75.
L7E2A:
  LD A,$40
  SUB B
; This entry point is used by the routine at L564A.
L7E2A_0:
  LD B,A
  LD H,$00
  RRA
  RR H
  RRA
  RR H
  RRA
  RRA
  AND $03
  LD C,A
  LD A,B
  LD B,$00
  PUSH HL
  LD HL,EXP0		; Expansion slot #0
  ADD HL,BC
  AND $0C
  OR C
  LD C,A
  LD A,(HL)
  POP HL
  OR C
  RET

; Routine at 32331
__MAX:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_FILES
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_EQUAL			; Token for '='
  CALL GETINT
  JP NZ,SN_ERR
  CP $10
  JP NC,FC_ERR
  LD (TEMP),HL
  PUSH AF
  CALL CLSALL		; Close all files
  POP AF
  CALL MAXFILES
  CALL _CLREG
  JP EXEC_EVAL

; Routine at 32363
;
; Used by the routines at __CLEAR, _CSTART and __MAX.
; clear files ?
MAXFILES:
  PUSH AF
  LD HL,(HIMEM)
  LD DE,$FEF5		; -267 (same offset on Tandy model 100)
MAXFILES_0:
  ADD HL,DE
  DEC A
  JP P,MAXFILES_0
  EX DE,HL
  LD HL,(STKTOP)
  LD B,H
  LD C,L
  LD HL,(MEMSIZ)
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A
  POP AF
  PUSH HL
  PUSH AF
  LD BC,$008C		; 140
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,(VARTAB)
  ADD HL,BC
  RST DCOMPR		; Compare HL with DE.
  JP NC,OM_ERR
  POP AF
  LD (MAXFIL),A
  LD L,E
  LD H,D
  LD (FILTAB),HL
  DEC HL
  DEC HL
  LD (MEMSIZ),HL
  POP BC
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A
  LD (STKTOP),HL
  DEC HL
  DEC HL
  POP BC
  LD SP,HL
  PUSH BC
  LD A,(MAXFIL)
  LD L,A
  INC L
  LD H,$00
  ADD HL,HL
  ADD HL,DE
  EX DE,HL
  PUSH DE
  LD BC,$0109		; 265
MAXFILES_1:
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  LD (HL),$00
  ADD HL,BC
  EX DE,HL
  DEC A
  JP P,MAXFILES_1
  POP HL
  LD BC,$0009
  ADD HL,BC
  LD (NULBUF),HL
  RET

; Message at 32472
MSX_MSG:
  DEFM "MSX  system"
  DEFB $00
VER_MSG:
  DEFM "version 1.0"
  DEFB CR
  DEFB LF
  DEFB $00
BASIC_MSG:
  DEFM "MSX BASIC "
  DEFB $00
COPYRIGHT_MSG:
IF SPECTRUM_SKIN
  DEFB 127
  DEFM " 1983 by Microsoft"
ELSE
  DEFM "Copyright 1983 by Microsoft"
ENDIF
  DEFB CR
  DEFB LF
  DEFB $00
BYTES_MSG:
  DEFM " Bytes free"
  DEFB $00

  
;----------------------------------------------------
;-- THE NEXT $ 90 BYTES WILL BE RELOCATED AT $F380 --
;----------------------------------------------------

; Routine at 32551 ($7F27 -> $F380)
__RDPRIM:
  OUT (PPI_AOUT),A
  LD E,(HL)
  JR __WRPRIM_0

DEFC SYSV_DELTA = RDPRIM-__RDPRIM
  
; Routine at 32556 ($7F2C -> $F385)
__WRPRIM:
  OUT (PPI_AOUT),A
  LD (HL),E

__WRPRIM_0:
  LD A,D
  OUT (PPI_AOUT),A
  RET

; Routine at 32563 ($F733 -> $F38C)
__CLPRIM:
  OUT (PPI_AOUT),A
  EX AF,AF'
  CALL CALLIX + SYSV_DELTA		; CALL (IX)
  EX AF,AF'
  POP AF
  OUT (PPI_AOUT),A
  EX AF,AF'
  RET

CALLIX:  JP  (IX)   ; ($7F3F -> $F398)
; CALLIX+1:  JP (HL)	; ($7F40 -> $F399)

; USR0 ($7F3F -> $F39A)
USR_JPTAB:
  DEFW FC_ERR		; USR0
  DEFW FC_ERR		; USR1
  DEFW FC_ERR		; USR2
  DEFW FC_ERR		; USR3
  DEFW FC_ERR		; USR4
  DEFW FC_ERR		; USR5
  DEFW FC_ERR		; USR6
  DEFW FC_ERR		; USR7
  DEFW FC_ERR		; USR8
  DEFW FC_ERR		; USR9

  DEFB 37		; LINL40: Width for SCREEN 0
  DEFB 29		; LINL32: Width for SCREEN 1
  DEFB 29		; LINLEN: Width for the current text mode 
  DEFB 24		; CRTCNT: Columns
  DEFB 14		; CLMLST: Column space.
  
  DEFW 0		; TXTNAM: SCREEN 0 name table
  DEFW 0		; TXTCOL: SCREEN 0 color table
  DEFW $0800	; TXTCGP: SCREEN 0 character pattern table
  DEFW 0		; TXTATR: SCREEN 0 Sprite Attribute Table
  DEFW 0		; TXTPAT: SCREEN 0 Sprite Pattern Table

  DEFW $1800	; T32NAM: SCREEN 1 name table
  DEFW $2000	; T32COL: SCREEN 1 color table
  DEFW 0		; T32CGP: SCREEN 1 character pattern table
  DEFW $1B00	; T32ATR: SCREEN 1 Sprite Attribute Table
  DEFW $3800	; T32PAT: SCREEN 1 Sprite Pattern Table

  DEFW $1800	; GRPNAM: SCREEN 2 name table
  DEFW $2000	; GRPCOL: SCREEN 2 color table
  DEFW 0		; GRPCGP: SCREEN 2 character pattern table
  DEFW $1B00	; GRPATR: SCREEN 2 Sprite Attribute Table
  DEFW $3800	; GRPPAT: SCREEN 2 Sprite Pattern Table

  DEFW $0800	; MLTNAM: SCREEN 3 name table
  DEFW 0		; MLTCOL: SCREEN 3 color table
  DEFW 0		; MLTCGP: SCREEN 3 character pattern table
  DEFW $1B00	; MLTATR: SCREEN 3 Sprite Attribute Table
  DEFW $3800	; MLTPAT: SCREEN 3 Sprite Pattern Table

  DEFB 1		; CLIKSW: keyboard click status
  DEFB 1		; CSRY  : Current row position of the cursor
  DEFB 1		; CSRX  : Current column position of the cursor
  DEFB 0		; CNSDFG: function keys status
  
  DEFB $00		; RG0SAV: Copy of VDP Register #0
  DEFB $E0		; RG1SAV: Copy of VDP Register #1
  DEFB $00		; RG2SAV: Copy of VDP Register #2
  DEFB $00		; RG3SAV: Copy of VDP Register #3
  DEFB $00		; RG4SAV: Copy of VDP Register #4
  DEFB $00		; RG5SAV: Copy of VDP Register #5
  DEFB $00		; RG6SAV: Copy of VDP Register #6
  DEFB $00		; RG7SAV: Copy of VDP Register #7

  DEFB $00		; STATFL: Content of VDP(8) status register
  DEFB $FF		; TRGFLG: trigger buttons and space bar status
IF SPECTRUM_SKIN
  DEFB 1		; FORCLR: Foreground color
  DEFB 14		; BAKCLR: Background color
  DEFB 14		; BDRCLR: Border color
ELSE
  DEFB 15		; FORCLR: Foreground color
  DEFB 4		; BAKCLR: Background color
  DEFB 4		; BDRCLR: Border color
ENDIF
  
  JP 0			; ($7F94 -> $F3EC) Jump instruction used by Basic LINE command. (RIGHTC, LEFTC, UPC and DOWNC)
  JP 0			; ($7F96 -> $F3EF) Jump instruction used by Basic LINE command. (RIGHTC, LEFTC, UPC and DOWNC
  
  DEFB $0F		; ATRBYT: Attribute byte (for graphical routines it’s used to read the color) 
  
  DEFW $F959	; QUEUES: Address of the queue table for 'PLAY'
  DEFB $FF		; FRCNEW: CLOAD flag
  
  DEFB 1		; SCNCNT: Key scan timing
  DEFB 50		; REPCNT: Key repeat delay counter

L7FFF:
  DEFW KEYBUF	; PUTPNT: Keyboard buffer write position
  DEFW KEYBUF	; GETPNT: Keyboard buffer read position

; CS120 Cassette I/O parameters to use for 1200 baud 
 DEFW $5C53		; LOW - Signal delay when writing a 0 to tape 
 DEFW $2D26		; HIGH - Signal delay when writing a 1 to tape ($4D52 on SVI)
 DEFB $0F		; HEADER - Delay of tape header (sync.) block 

; CS240 - Cassette I/O parameters to use for 2400 baud 
 DEFW $2D25		; LOW - Signal delay when writing a 0 to tape 
 DEFW $160E		; HIGH - Signal delay when writing a 1 to tape ($4D52 on SVI)
 DEFB $1F		; HEADER - Delay of tape header (sync.) block 

; Default  Cassette I/O parameters (1200 baud)
 DEFW $5C53		; LOW - Signal delay when writing a 0 to tape 
 DEFW $2D26		; HIGH - Signal delay when writing a 1 to tape ($4D52 on SVI)
 DEFB $0F		; HEADER - Delay of tape header (sync.) block 

 DEFW $0100		; ASPCT1 Horizontal / Vertical aspect for CIRCLE command 
 DEFW $0100		; ASPCT2 Horizontal / Vertical aspect for CIRCLE command  

; "RESUME NEXT"   ($7FB6 -> $F40F)
; _ENDPRG:
; 
  DEFB ':'	; SAVTXT often points to this value (copied to "_ENDPRG" in RAM)
L7FB7:
  LD DE,PROCNM		; $FD89
  AND A
  RET NZ
  INC B
  RET
  
  
  
  
L0END:
  defs $8000-L0END

