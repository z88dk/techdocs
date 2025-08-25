
; BASIC-80 Rev. 5.22 - March 19, 1982
; (The previous version was released on March 10th)

; The earlier versions of the Microsoft BASIC were written on a PDP-10 with its MACRO-10 assembler
; adding macros to support the 8080 and 6502 opcodes.  MACRO-10 did not support hex numbers,
; the numeric values (including the ASCII codes) were written in decimal or octal format.


; --- CP/M Specific definitions --- 

IF !BASE
  defc BASE = 0
ENDIF

defc CPMWRM  =  BASE                ;CP/M WARM BOOT ADDR
defc CPMENT  =  BASE+5              ;CP/M BDOS CALL ADDR
defc DIRTMP  =  BASE+$0080


  ORG BASE+$0100


; The original code now includes Z80 specific optimizations,
; but Z80ASM is able to transparently convert back to 8080.
;
; Classic build (almost byte-identical but for few small bug fixes):
;
; z80asm -b -DORIGINAL -DCPMV1 -m8080 mbasic.asm
; ren mbasic.bin MBASIC.COM
;
; Rebased CP/M buid 
; Alphatronic-P2 (8085, BASE at $4200)
; z80asm -b -DBASE=16896 -m8085 mbasic.asm
; z88dk-appmake +cpmdisk -f alphatp2 --container=imd  -b mbasic.bin

; TRS-80 Model I Small System Software or FMG (Z80, BASE at $4200)
; z80asm -b -DBASE=16896 -DCPMV1 mbasic.asm
; z88dk-appmake +cpmdisk -f omikron --container=imd  -b mbasic.bin

; CP/M 2 BDOS trap, as implemented on the Apple II
;-------------------------------------------------
; Error codes, allowing ON ERROR based tricks
; . 68 "Disk read only"  ("write protected", this same error code survived up to the MSX era)
; . 69 "Drive select error"  (this same code became "Disk I/O error" on the MSX, which uses also 70 for "disk offline" )
; . 70 "File Read Only"  (it shifted to 72 on MSX)
;
; z80asm -b -DCPMV1 -m8080 -DTRAP_BDOS mbasic.asm
; ren mbasic.bin MBASIC.COM


; ZX Spectrum +3 graphics and Terminal
;--------------------------------------
; VPOKE, VPEEK  -> direct video memory access.  ZX Spectrum style: 0->6142 (screen), 6143->6911 (attributes)
; PSET, PRESET, POINT, CSRLIN, LINE, CLS, COLOR, LOCATE, PRINT @#, DRAW, CIRCLE
;
; add -DTAPE for LOAD!, LOAD!? (=CLOAD, CLOAD?) and SAVE! (=CSAVE) ...Kansas City Standard, at 1200 bps, MSX style CSAVE protocol.
; add -DBIT_PLAY for OUT! (=PLAY) and OUT@ (=SOUND), they're single channel melody commands, Philips VG-5000 style syntax
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DVT52 -DBIT_PLAY mbasic.asm
; ren mbasic.bin P3BASIC.COM
; z88dk-appmake +cpmdisk -f plus3 -b P3BASIC.COM


; ZX Spectrum clones: Scorpion ZS, Kay-1024, Pentagon (expanded)
;----------------------------------------------------------------
; ** Add -DBIOS20 for 512x256 monochrome graphics (FK0CPM by Kirill Frolov). **
; Omitting "BIOS20" will build a color BASIC for the Scorpion CP/M (MOA '92)
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DVT52 -DTAPE -DBIT_PLAY mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f scorpion --container=raw --extension=.trd -b zxbasic.com


; PINIX CP/M on Profi, Profi+ ZX Spectrum clones
; (and in theory on Scorpion, Pentagon+16k cache, KAY, Spectrum +3 with BetaDisk)
;---------------------------------------------------------------------------------
; -DPINIX is used to alter the Scorpion mode
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DPINIX -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f scorpion --container=raw --extension=.trd -b zxbasic.com


; KLUG CP/M CP/M on Profi ZX Spectrum clones
;-------------------------------------------
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DPROFI -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f quorum --container=dsk -b zxbasic.com


; ZX Spectrum QUORUM-128 (CP/J)
;-------------------------------
; -DQUORUM is used to alter the Scorpion mode
; The modified version of the "UnrealSpeccy" emulator (unrl020q) requires disk images in FDI format
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DQUORUM -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f quorum --container=dsk -b zxbasic.com
; samdisk zxbasic.dsk zxbasic.fdi

; Standard ZX Spectrum + Betadisk, rebased CP/M 
;-------------------------------------------------
; ZXCPM by Kamil karimov, 2003
; -DBIT_PLAY works but we have so little space left already !!
;
; z80asm -b -DBASE=24576 -DVT52 -DZX128 mbasic.asm
; z88dk-appmake +cpmdisk -f quorum --container=raw --extension=.trd -b mbasic.bin
; A> ren zxbasic.cm6=mbasic.com

; ZX ASC CP/M on LSY256 memory MOD
;----------------------------------
; -DZXASC is used to alter the Scorpion mode
; A tuned version of the "UnrealSpeccy" emulates an OREL-BK08 with BETADisk and LSY256 MOD
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DZXASC -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f quorum --container=dsk -b zxbasic.com
; samdisk zxbasic.dsk zxbasic.fdi


; ZX Spectrum ELWRO 800 (CP/J)
;------------------------------
; -DELWRO is used to alter the Scorpion mode
; TODO: color graphics (requires paging ?)
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DELWRO -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f elwro --container=dsk -b zxbasic.com                


; ZX Spectrum Dataputer DISKFACE 
;--------------------------------
; A simple RAWRITE tool should suffice to write the floppy disk image to a real disk.
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DDISKFACE -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f diskface --container=raw --extension=.raw -b zxbasic.com


; ZX Spectrum LEC memory MOD, (CP/M 2.2 on Microdrive)
;-----------------------------------------------------
; Use the CPM2TAP tool in {z88dk}/support/zx
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DZXLEC -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +zx --lec-cpm -b zxbasic.com --org 256 zxbasic.tap


; ZX Spectrum CS-DISK interface (untested)
;-----------------------------------------
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DZXCSDISK -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com


; ZX Spectrum 80K mod presented in AG Mikrorechentechnik Berlin, December 1987
;-----------------------------------------------------------------------------
; Perhaps used on the SPECTRAL or KUB64 clones
;
; uncomment the ZXSPECTRAL related sections, see the LEC and DISKFACE for the build.


; ZX Spectrum HC-2000 (and possibly HC-91)
;------------------------------------------
; -DHC2000 is used to alter the Scorpion mode
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DSCORPION -DHC2000 -DVT52 -DBIT_PLAY -DTAPE mbasic.asm
; ren mbasic.bin zxbasic.com
; z88dk-appmake +cpmdisk -f hc2000 --container=dsk -b zxbasic.com



; Proof of concept:  reusing MSX specific code
; The COLOR command sort of works, PSET would require to enter in graphics mode.
; It is portable to MTX, SVI, EINSTEIN, etc.
;
; z80asm -b -DHAVE_GFX -DUSEVDP -DFORMSX mbasic.asm
; ren mbasic.bin MSXBAS.COM
; z88dk-appmake +fat -f msxdos -b MSXBAS.COM



; --- Sizes --- 

defc NUMLEV   =   0*20+19+2*5       ; NUMBER OF STACK LEVELS RESERVED BY AN EXPLICIT CALL TO GETSTK
;defc NUMLEV   =   110				; ..the amount used by GW-BASIC
defc NAMLEN   =   40                ;  ;MAXIMUM LENGTH NAME -- 3 TO 127

; --- Prefixes, Tokens.. --- 

defc OCTCON   = 11  ; $0B - EMBEDED OCTAL CONSTANT
defc HEXCON   = 12  ; $0C - EMBEDED HEX CONSTANT

defc PTRCON   = 13  ; $0D - A LINE REFERENCE CONSTANT
defc LINCON   = 14  ; $0E - A LINE NUMBER UNCONVERTED TO POINTER

defc IN2CON   = 15  ;SINGLE BYTE (TWO BYTE WITH TOKEN) INTEGER
defc CONCN2   = 16  ;TOKEN RETURNED SECOND TYPE CONSTANT IS SCANNED.

defc ONECON   = 17  ;FIRST OF 10 (0-9) INTEGER SPECIAL TOKENS
defc INTCON   = 28  ;REGULAR 16 BIT TWO'S COMPLEMENT INT

defc CONCON   = 30  ;TOKEN RETURNED BY CHRGET AFTER CONSTANT SCANNED
defc DBLCON   = 31  ;DOUBLE PREC (8 BYTE) CONSTANT


;------------------------------------

defc BUFLEN   =  255   ; LONG LINES
defc KBFLEN   =  BUFLEN+(BUFLEN/4)	; MAKE KRUNCH BUFFER SOMEWHAT LARGER THAN SOURCE BUFFER (BUF)




IF ZXPLUS3
defc LINLN    =   50
ELSE
defc LINLN    =   80   ; TERMINAL LINE LENGTH 
ENDIF

defc LPTLEN   =  132   ; Max column size on printer
defc CLMWID   =   14   ; MAKE COMMA COLUMNS FOURTEEN CHARACTERS
defc LNCMPS   = (((LPTLEN/CLMWID)-1)*CLMWID) ;LAST COMMA FIELD POSIT


defc DATPSC   =  128    ;NUMBER OF DATA BYTES IN DISK SECTOR


;BUFLEN	SET	255			;LONG LINES
;NAMLEN	SET	40			;MAXIMUM LENGTH NAME -- 3 TO 127

;STRSIZ	SET	4

;STRSIZ	SET	3
;NUMTMP	SET	3			;NUMBER OF STRING TEMPORARIES

;NUMTMP	SET	10

;MD.RND	SET	3			;THE MODE NUMBER FOR RANDOM FILES
;MD.SQI	SET	1			;THE MODE NUMBER FOR SEQUENTIAL INPUT FILES
						;NEVER WRITTEN INTO A FILE
;MD.SQO	SET	2			;THE MODE FOR SEQUENTIAL OUTPUT FILES
						;AND PROGRAM FILES


;------------------------------------

defc ONEFUN = TK_LEFT_S		; Function offset


defc TK_LEFT_S   =  $01
defc TK_RIGHT_S  =  $02
defc TK_MID_S    =  $03
defc TK_SGN      =  $04
defc TK_INT      =  $05
defc TK_ABS      =  $06
defc TK_SQR      =  $07
defc TK_RND      =  $08
defc TK_SIN      =  $09
defc TK_LOG      =  $0A
defc TK_EXP      =  $0B
defc TK_COS      =  $0C
defc TK_TAN      =  $0D
defc TK_ATN      =  $0E
defc TK_FRE      =  $0F

defc TK_INP      =  $10
defc TK_POS      =  $11
defc TK_LEN      =  $12
defc TK_STR_S    =  $13
defc TK_VAL      =  $14
defc TK_ASC      =  $15
defc TK_CHR_S    =  $16
defc TK_PEEK     =  $17
defc TK_SPACE_S  =  $18
defc TK_OCT_S    =  $19
defc TK_HEX_S    =  $1A
defc TK_LPOS     =  $1B
defc TK_CINT     =  $1C
defc TK_CSGN     =  $1D
defc TK_CDBL     =  $1E
defc TK_FIX      =  $1F


IF ZXPLUS3
defc TK_VPEEK    =  $20
ENDIF


defc TK_CVI      =  $2B
defc TK_CVS      =  $2C
defc TK_CVD      =  $2D
;
defc TK_EOF      =  $2F

defc TK_LOC      =  $30
defc TK_LOF      =  $31
defc TK_MKI_S    =  $32
defc TK_MKS_S    =  $33
defc TK_MKD_S    =  $34


defc TK_END      =  $81	; Token for 'END' (used also in 'APPEND')
defc TK_FOR      =  $82	; Token for 'FOR' (used also in 'OPEN' syntax)
defc TK_NEXT     =  $83	; Token for 'FOR' (used also for 'RESUME NEXT')
defc TK_DATA     =  $84	; Token for 'DATA'
defc TK_INPUT    =  $85	; Token for 'INPUT' (used for the "LINE INPUT" compound statement)
defc TK_DIM      =  $86
defc TK_READ     =  $87
defc TK_LET      =  $88
defc TK_GOTO     =  $89	; Token for 'GOTO'
defc TK_RUN      =  $8A
defc TK_IF       =  $8B
defc TK_RESTORE  =  $8C	; 
defc TK_GOSUB    =  $8D	; Token for 'GOSUB'
defc TK_RETURN   =  $8E	; Token for 'RETURN'
defc TK_REM      =  $8F

defc TK_STOP     =  $90	; Token for 'STOP'
defc TK_PRINT    =  $91	; Token for 'PRINT'
defc TK_CLEAR    =  $92
defc TK_LIST     =  $93
defc TK_NEW      =  $94
defc TK_ON       =  $95	; Token for 'ON'

defc TK_NULL     =  $96
defc TK_WAIT     =  $97
defc TK_DEF      =  $98
defc TK_POKE     =  $99
defc TK_CONT     =  $9A
IF HAVE_GFX
defc TK_DRAW     =  $9B
defc TK_CIRCLE   =  $9C
ENDIF
defc TK_OUT      =  $9D	; Token for 'OUT' (used also in 'OPEN' to check syntax)
defc TK_LPRINT   =  $9E
defc TK_LLIST    =  $9F

IF VT52
defc TK_CLS      =  $A0
ENDIF

defc TK_WIDTH    =  $A1
defc TK_ELSE     =  $A2	; Token for 'ELSE'
defc TK_TRON     =  $A3
defc TK_TROFF    =  $A4	; Token for 'TROFF'
defc TK_SWAP     =  $A5
defc TK_ERASE    =  $A6
defc TK_EDIT     =  $A7
defc TK_ERROR    =  $A8	; Token for 'ERROR'
defc TK_RESUME   =  $A9
defc TK_DELETE   =  $AA
defc TK_AUTO     =  $AB
defc TK_RENUM    =  $AC
defc TK_DEFSTR   =  $AD
defc TK_DEFINT   =  $AE
defc TK_DEFSNG   =  $AF


defc TK_DEFDBL   =  $B0
defc TK_LINE     =  $B1

IF HAVE_GFX
defc TK_PSET     =  $B2
defc TK_PRESET   =  $B3
ENDIF

defc TK_WHILE    =  $B4
defc TK_WEND     =  $B5	; Token for 'PUT' (used also in 'OPEN' to check syntax)
defc TK_CALL     =  $B6
defc TK_WRITE    =  $B7
defc TK_COMMON   =  $B8
defc TK_CHAIN    =  $B9
defc TK_OPTION   =  $BA
defc TK_RANDOMIZE  =  $BB

IF HAVE_GFX
defc TK_COLOR    =  $BC
ENDIF

defc TK_SYSTEM   =  $BD

IF VT52
defc TK_LOCATE   =  $BE
ENDIF

defc TK_OPEN     =  $BF

defc TK_FIELD    =  $C0
defc TK_GET      =  $C1
defc TK_PUT      =  $C2	; Token for 'PUT' (used also in 'OPEN' to check syntax)
defc TK_CLOSE    =  $C3
defc TK_LOAD     =  $C4
defc TK_MERGE    =  $C5
defc TK_FILES    =  $C6   ; Token for 'FILES' (MSX uses it also in "MAXFILES")
defc TK_NAME     =  $C7
defc TK_KILL     =  $C8
defc TK_LSET     =  $C9
defc TK_RSET     =  $CA
defc TK_SAVE     =  $CB
defc TK_RESET    =  $CC  ; <-- used as TK code limit by ONJMP

IF ZXPLUS3
defc TK_VPOKE    =  $CD  ; <-- used as TK code limit by ONJMP
ENDIF

defc TK_TO       =  $CE	; Token for 'TO' identifier in a 'FOR' statement
defc TK_THEN     =  $CF	; Token for 'THEN'

defc TK_TAB      =  $D0	; Token for 'TAB('
defc TK_STEP     =  $D1	; Token for 'STEP' identifier in a 'FOR' statement
defc TK_USR      =  $D2	; Token for 'USR'
defc TK_FN       =  $D3	; Token for 'FN'
defc TK_SPC      =  $D4	; Token for 'SPC('
defc TK_NOT      =  $D5	; Token for 'NOT'
defc TK_ERL      =  $D6	; Token for 'ERL'
defc TK_ERR      =  $D7	; Token for 'ERR'
defc TK_STRING   =  $D8	; Token for 'STRING$'
defc TK_USING    =  $D9	; Token for 'USING'
defc TK_INSTR    =  $DA	; Token for 'INSTR'
defc TK_APOSTROPHE = $DB ; Comment, a modern variant of REM
defc TK_VARPTR   =  $DC	; Token for 'VARPTR'
defc TK_INKEY_S  =  $DD	; Token for 'INKEY$'

IF ZXPLUS3
defc TK_CSRLIN   =  $DE
ENDIF

IF HAVE_GFX
defc TK_POINT    =  $DF
ENDIF


; RELATIONAL OPERATORS

defc TK_GREATER  =  $EF ; Token for '>'
defc TK_EQUAL    =  $F0 ; Token for '='
defc TK_MINOR    =  $F1	; Token for '<'

; OPERATORS

defc TK_PLUS     =  $F2	; Token for '+'
defc TK_MINUS    =  $F3	; Token for '-'
defc TK_STAR     =  $F4	; Token for '*'
defc TK_SLASH    =  $F5	; Token for '/'

; 8K BASIC OPERATORS

defc TK_EXPONENT =  $F6	; Token for '^'
defc TK_AND      =  $F7	; Token for 'AND'
defc TK_OR       =  $F8	; Token for 'OR'

; EXTENDED BASIC OPERATORS

defc TK_XOR      =  $F9	; Token for 'XOR'
defc TK_EQV      =  $FA	; Token for 'EQV'
defc TK_IMP      =  $FB	; Token for 'IMP'
defc TK_MOD      =  $FC	; Token for 'MOD'
defc TK_BKSLASH  =  $FD	; Token for '\' (Integer division)

defc LSTOPK      =  TK_BKSLASH+1-TK_PLUS





;----------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------




; INIT IS THE INTIALIZATION ROUTINE
; IT SETS UP CERTAIN LOCATIONS
; DELETES FUNCTIONS IF DESIRED AND
; CHANGES THIS TO JMP READY

L0100:
  JP INIT


; WARM START FOR ISIS
; OF THE ROUTINE TO CONVERT [A,B]
; TO A FLOATING POINT NUMBER IN THE FAC

; Data block at 259
;L0103:
  DEFW __CINT			; (FRCINT) TURN FAC INTO AN INTEGER IN [H,L]

; Data block at 261
;L0105:
  DEFW MAKINT			; TURN [H,L] INTO A VALUE IN THE FAC


; Jump table for statements and functions
; a.k.a.  "STMDSP"
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
; 8K AND ABOVE STATEMENTS
  DEFW __ON
  DEFW __NULL
  DEFW __WAIT
  DEFW __DEF
  DEFW __POKE
  DEFW __CONT
IF HAVE_GFX
  DEFW __DRAW
  DEFW __CIRCLE
ELSE
  DEFW SN_ERR
  DEFW SN_ERR
ENDIF
  DEFW __OUT
  DEFW __LPRINT
  DEFW __LLIST
; LEN2 AND ABOVE STATEMENTS
IF VT52
  DEFW __CLS
ELSE
  DEFW $0000
ENDIF
  DEFW __WIDTH
  DEFW __REM
  DEFW __TRON
  DEFW __TROFF
  DEFW __SWAP
  DEFW __ERASE
  DEFW __EDIT
  DEFW __ERROR
  DEFW __RESUME
  DEFW __DELETE
  DEFW __AUTO
  DEFW __RENUM
; EXTENDED AND ABOVE
  DEFW __DEFSTR
  DEFW __DEFINT
  DEFW __DEFSNG
  DEFW __DEFDBL
  DEFW __LINE

;------------------------------------------------------------------------------

IF HAVE_GFX
  DEFW __PSET
  DEFW __PRESET
ELSE
  DEFW $0000
  DEFW $0000
ENDIF
  DEFW __WHILE
  DEFW __WEND
  DEFW __CALL
  DEFW __WRITE
  DEFW __DATA		; 'COMMON'
  DEFW __CHAIN
  DEFW __OPTION
  DEFW __RANDOMIZE

IF HAVE_GFX
  DEFW __COLOR
ELSE
  DEFW $0000
ENDIF

; DISK AND ABOVE
;------------------------------------------------------------------------------

  DEFW __SYSTEM

IF VT52
  DEFW __LOCATE
ELSE
  DEFW $0000
ENDIF

  DEFW __OPEN
  DEFW __FIELD
  DEFW __GET
  DEFW __PUT
  DEFW __CLOSE
  DEFW __LOAD
  DEFW __MERGE
  DEFW __FILES
  DEFW __NAME
  DEFW __KILL
  DEFW __LSET
  DEFW __RSET
  DEFW __SAVE
  DEFW __RESET

IF ZXPLUS3
  DEFW __VPOKE
ENDIF



; Jump table for statements and functions (continued)
FNCTAB_FN:
; FUNCTIONS
  DEFW __LEFT_S
  DEFW __RIGHT_S
  DEFW __MID_S
  DEFW __SGN
  DEFW __INT
  DEFW __ABS
  DEFW __SQR
  DEFW __RND
  DEFW __SIN
; 8K FUNCTIONS
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
  DEFW __SPACE_S
  DEFW __OCT_S
  DEFW __HEX_S
  DEFW __LPOS
; EXTENDED FUNCTIONS
  DEFW __CINT
  DEFW __CSNG
  DEFW __CDBL
  DEFW __FIX

; DISK FUNCTIONS
IF ZXPLUS3
  DEFW __VPEEK
ELSE
  DEFW $0000
ENDIF
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW __CVI
  DEFW __CVS
  DEFW __CVD
  DEFW $0000
  DEFW __EOF
  DEFW __LOC
  DEFW __LOF
  DEFW __MKI_S
  DEFW __MKS_S
  DEFW __MKD_S
;END DISK FUNCTIONS


; THE FOLLOWING TABLES ARE THE ALPHABETIC DISPATCH TABLE
; FOLLOWED BY THE RESERVED WORD TABLE ITSELF

WORD_PTR:
  DEFW WORDS
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

; BASIC keyword list
WORDS:
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

  DEFB $00

WORDS_B:
  DEFB $00

WORDS_C:
  DEFM "LOS"
  DEFB 'E'+$80
  DEFB TK_CLOSE


  DEFM "ON"
  DEFB 'T'+$80
  DEFB TK_CONT

  DEFM "LEA"
  DEFB 'R'+$80
  DEFB TK_CLEAR

  DEFM "IN"
  DEFB 'T'+$80
  DEFB TK_CINT

IF HAVE_GFX
  DEFM "IRCL"
  DEFB 'E'+$80
  DEFB TK_CIRCLE
ENDIF

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

  DEFM "AL"
  DEFB 'L'+$80
  DEFB TK_CALL

  DEFM "OMMO"
  DEFB 'N'+$80
  DEFB TK_COMMON

  DEFM "HAI"
  DEFB 'N'+$80
  DEFB TK_CHAIN

IF HAVE_GFX
  DEFM "OLO"
  DEFB 'R'+$80
  DEFB TK_COLOR
ENDIF

IF VT52
  DEFM "L"
  DEFB 'S'+$80
  DEFB TK_CLS
ENDIF

IF ZXPLUS3
  DEFM "SRLI"
  DEFB 'N'+$80
  DEFB TK_CSRLIN
ENDIF

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
  DEFB TK_DEFSNG

  DEFM "EFDB"
  DEFB 'L'+$80
  DEFB TK_DEFDBL

  DEFM "E"
  DEFB 'F'+$80
  DEFB TK_DEF

IF HAVE_GFX
  DEFM "RA"
  DEFB 'W'+$80
  DEFB TK_DRAW
ENDIF

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

  DEFM "DI"
  DEFB 'T'+$80
  DEFB TK_EDIT

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

  DEFB $00

WORDS_J:
  DEFB $00

WORDS_K:
  DEFM "IL"
  DEFB 'L'+$80
  DEFB TK_KILL

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

IF VT52
  DEFM "OCAT"
  DEFB 'E'+$80
  DEFB TK_LOCATE
ENDIF

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

  DEFB $00

WORDS_N:
  DEFM "EX"
  DEFB 'T'+$80
  DEFB TK_NEXT

  DEFM "UL"
  DEFB 'L'+$80
  DEFB TK_NULL

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

  DEFM "PTIO"
  DEFB 'N'+$80
  DEFB TK_OPTION

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

IF HAVE_GFX
  DEFM "SE"
  DEFB 'T'+$80
  DEFB TK_PSET

  DEFM "RESE"
  DEFB 'T'+$80
  DEFB TK_PRESET

  DEFM "OIN"
  DEFB 'T'+$80
  DEFB TK_POINT
ENDIF

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

  DEFM "ESE"
  DEFB 'T'+$80
  DEFB TK_RESET

  DEFM "ANDOMIZ"
  DEFB 'E'+$80
  DEFB TK_RANDOMIZE

  DEFB $00

WORDS_S:
  DEFM "TO"
  DEFB 'P'+$80
  DEFB TK_STOP

  DEFM "WA"
  DEFB 'P'+$80
  DEFB TK_SWAP

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

  DEFM "YSTE"
  DEFB 'M'+$80
  DEFB TK_SYSTEM

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

IF ZXPLUS3
  DEFM "POK"
  DEFB 'E'+$80
  DEFB TK_VPOKE

  DEFM "PEE"
  DEFB 'K'+$80
  DEFB TK_VPEEK
ENDIF

  DEFB $00

WORDS_W:
  DEFM "IDT"
  DEFB 'H'+$80
  DEFB TK_WIDTH

  DEFM "AI"
  DEFB 'T'+$80
  DEFB TK_WAIT

  DEFM "HIL"
  DEFB 'E'+$80
  DEFB TK_WHILE

  DEFM "EN"
  DEFB 'D'+$80
  DEFB TK_WEND

  DEFM "RIT"
  DEFB 'E'+$80
  DEFB TK_WRITE

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



; Data block at 1130
; a.k.a. SPCTAB
OPR_TOKENS:
  DEFB '+'+128
  DEFB TK_PLUS		; Token for '+'
  DEFB '-'+128
  DEFB TK_MINUS		; Token for '-'
  DEFB '*'+128
  DEFB TK_STAR		; Token for '*'
  DEFB '\/'+128
  DEFB TK_SLASH		; Token for '/'
  DEFB '^'+128
  DEFB TK_EXPONENT	; Token for '^'
  DEFB '\\'+128
  DEFB TK_BKSLASH	; Token for '\'
  DEFB '\''+128
  DEFB TK_APOSTROPHE	; Token for '''
  DEFB '>'+128
  DEFB TK_GREATER	; Token for '>'
  DEFB '='+128
  DEFB TK_EQUAL		; Token for '='
  DEFB '<'+128
  DEFB TK_MINOR		; Token for '<'
  DEFB $00


;PRECEDENCE FOLLOWED BY
;THE ROUTINE ADDRESS

; Arithmetic precedence table
PRITAB:
  DEFB $79                ; +   (Token code $F2)
  DEFB $79                ; -
  DEFB $7C                ; *
  DEFB $7C                ; /
  DEFB $7F                ; ^
  DEFB $50                ; AND
  DEFB $46                ; OR
  DEFB $3C                ; XOR
  DEFB $32                ; EQU
  DEFB $28                ; IMP
  DEFB $7A                ; MOD
  DEFB $7B                ; \   (Token code $FD)


; USED BY ASSIGNMENT CODE TO FORCE THE RIGHT HAND VALUE TO CORRESPOND
; TO THE VALUE TYPE OF THE VARIABLE BEING ASSIGNED TO.

; NUMBER TYPES
TYPE_OPR:
  DEFW __CDBL
  DEFW 0
  DEFW __CINT
  DEFW TSTSTR
  DEFW __CSNG

;
; THESE TABLES ARE USED AFTER THE DECISION HAS BEEN MADE
; TO APPLY AN OPERATOR AND ALL THE NECESSARY CONVERSION HAS
; BEEN DONE TO MATCH THE TWO ARGUMENT TYPES (APPLOP)
;

; ARITHMETIC OPERATIONS TABLE
DEC_OPR:
  DEFW DADD             ;DOUBLE PRECISION ROUTINES
  DEFW DSUB
  DEFW DMUL
  DEFW DDIV
  DEFW DCOMP

defc OPCNT = ((FLT_OPR-DEC_OPR)/2)-1

; FP OPERATIONS TABLE
FLT_OPR:
  DEFW FADD               ;SINGLE PRECISION ROUTINES
  DEFW FSUB
  DEFW FMULT
  DEFW FDIV
  DEFW FCOMP

; INTEGER OPERATIONS TABLE
INT_OPR:
  DEFW IADD               ;INTEGER ROUTINES
  DEFW ISUB
  DEFW IMULT
  DEFW IDIV
  DEFW ICOMP

; Message at 1203
ERROR_MESSAGES:
  DEFB $00
  DEFM "NEXT without FOR"
  DEFB $00
  DEFM "Syntax error"
  DEFB $00
  DEFM "RETURN without GOSUB"
  DEFB $00
  DEFM "Out of DATA"
  DEFB $00
  DEFM "Illegal function call"
  DEFB $00

; Message at 1289
OVERFLOW_MSG:
  DEFM "Overflow"
  DEFB $00
  DEFM "Out of memory"
  DEFB $00
  DEFM "Undefined line number"
  DEFB $00
  DEFM "Subscript out of range"
  DEFB $00
  DEFM "Duplicate Definition"
  DEFB $00

; Message at 1378
DIV0_MSG:
  DEFM "Division by zero"
  DEFB $00
  DEFM "Illegal direct"
  DEFB $00
  DEFM "Type mismatch"
  DEFB $00
  DEFM "Out of string space"
  DEFB $00
  DEFM "String too long"
  DEFB $00
  DEFM "String formula too complex"
  DEFB $00
  DEFM "Can't continue"
  DEFB $00
  DEFM "Undefined user function"
  DEFB $00
  DEFM "No RESUME"
  DEFB $00
  DEFM "RESUME without error"
  DEFB $00
  DEFM "Unprintable error"
  DEFB $00
  DEFM "Missing operand"
  DEFB $00
  DEFM "Line buffer overflow"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "FOR Without NEXT"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "WHILE without WEND"
  DEFB $00
  DEFM "WEND without WHILE"
  DEFB $00

IF TRAP_BDOS
  DEFM "Reset error"           ; error code: $1F
  DEFB $00
ENDIF

  DEFM "FIELD overflow"        ; error code: $32
  DEFB $00
  DEFM "Internal error"
  DEFB $00
  DEFM "Bad file number"
  DEFB $00
  DEFM "File not found"
  DEFB $00
  DEFM "Bad file mode"
  DEFB $00
  DEFM "File already open"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "Disk I/O error"
  DEFB $00
  DEFM "File already exists"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "Disk full"
  DEFB $00
  DEFM "Input past end"
  DEFB $00
  DEFM "Bad record number"
  DEFB $00
  DEFM "Bad file name"
  DEFB $00
  DEFM "?"
  DEFB $00
  DEFM "Direct statement in file"
  DEFB $00
  DEFM "Too many files"
  DEFB $00

  defc TERR_OFFS = 0
  defc BDERR_OFFS = 0

IF TRAP_BDOS
  UNDEFINE BDERR_OFFS
  defc BDERR_OFFS = 3
  DEFM "Disk Read Only"
  DEFB $00
  DEFM "Drive select error"
  DEFB $00
  DEFM "File Read Only"
  DEFB $00
ENDIF
IF TAPE
  UNDEFINE TERR_OFFS
  defc TERR_OFFS = 2
  DEFM "Tape I/O error"
  DEFB $00
  DEFM "Verify error"
  DEFB $00
ENDIF

defc LSTERR=$44+BDERR_OFFS+TERR_OFFS


;
; THIS IS THE "VOLATILE" STORAGE AREA AND NONE OF IT
; CAN BE KEPT IN ROM. ANY CONSTANTS IN THIS AREA CANNOT
; BE KEPT IN A ROM, BUT MUST BE LOADED IN BY THE 
; PROGRAM INSTRUCTIONS IN ROM.
;


; Device Control Table/Driver
USR0:
  DEFW FC_ERR             ; USR0
USR1:
  DEFW FC_ERR             ; USR1
USR2:
  DEFW FC_ERR             ; USR2
USR3:
  DEFW FC_ERR             ; USR3
USR4:
  DEFW FC_ERR             ; USR4
USR5:
  DEFW FC_ERR             ; USR5
USR6:
  DEFW FC_ERR             ; USR6
USR7:
  DEFW FC_ERR             ; USR7
USR8:
  DEFW FC_ERR             ; USR8
USR9:
  DEFW FC_ERR             ; USR9

; System variables
NULLS:
  DEFB $01                ; Counter for NULL() function (NUMBER OF NULLS TO PRINT AFTER CRLF)
CHARC:
  DEFB $00                ; ISCNTC STORES EATEN CHAR HERE WHEN NOT A ^C
ERRFLG:
  DEFB $00                ; USED TO SAVE THE ERROR NUMBER SO EDIT CAN BE CALLED ON "SYNTAX ERROR"
;LPTLST:  <--  not used
  DEFB $00                ; LAST LINE PRINTER OPERATION. ZERO MEANS LINEFEED
LPTPOS:
  DEFB $00                ; POSITION OF LPT PRINT HEAD
PRTFLG:
  DEFB $00                ; WHETHER OUTPUT GOES TO LPT
COMMAN:
  DEFB (((LPTLEN/CLMWID)-1)*CLMWID)    ; LAST COMMA FIELD POSITION
LPTSIZ:
  DEFB LPTLEN             ; DEFAULT LINE PRINTER WIDTH
LINLEN:
  DEFB LINLN              ; TTY LINE LENGTH
NCMPOS:
  DEFB (((LINLN/CLMWID)-1)*CLMWID)     ; POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS
RUBSW:
  DEFB $00                ; RUBOUT SWITCH =1 INSIDE THE PROCESSING OF A RUBOUT (INLIN)
CTLOFG:
  DEFB $00                ; SUPRESS OUTPUT FLAG (toggled with ^O), NON-ZERO MEANS SUPRESS
PTRFIL:
  DEFW $0000              ; Pointer TO DATA BLOCK OF CURRENT FILE USED BY DISK AND NCR CASSETTE CODE

;INITIALLY SET UP BY INIT ACCORDING TO MEMORY SIZE TO ALLOW FOR 50 BYTES OF STRING SPACE.
;CHANGED BY A CLEAR COMMAND WITH AN ARGUMENT.
STKTOP:
  DEFW TSTACK+100         ; Top location to be used for the stack

; SET TO 65534 (-2) IN PURE VERSION DURING INIT EXECUTION
; SET TO 65535 (-1) WHEN DIRECT STATEMENTS EXECUTE
CURLIN:
  DEFW -2                 ; (word), line number being interpreted (at startup, 65534: INITIALIZATION IS EXECUTING)

TXTTAB:
  DEFW TSTACK+1           ; PTR to Start of BASIC program

OVERRI:
  DEFW OVERFLOW_MSG       ; Text PTR to current error message in math operations


;
;	END OF INITIALIZED PART OF RAM
;
;
; DISK DATA STORAGE AREA
;

AUTORUN:
  DEFB $00                ; a.k.a. "LSTFRE"

MAXFILSV:
  DEFB $00                ; Top number of files  (a.k.a. "LSTFRE+1")

MAXTRK:
  DEFB $00                ; ALLOCATE INSIDE THIS TRACK
  
DSKMOD:
  DEFB $00                ; MODE OF FILE JUST LOOKED UP

FILPT1:
  DEFW $0000              ; [FILPTR] ALWAYS REFETCHED FROM HERE

FILPTR:
  DEFS 32                 ; POINTERS TO DATA BLOCKS FOR EACH FILE

MAXFIL:
  DEFB $00                ; HIGHEST FILE NUMBER ALLOWED

NAMCNT:
  DEFB $00                ; Used to deal with variable types: THE NUMBER OF CHARACTER BEYOND #2 IN A VAR NAME

NAMBUF:
  DEFS NAMLEN-2           ; STORAGE FOR CHARS BEYOND #2. USED IN PTRGET

NAMTMP:
  DEFW $00                ; Used to deal with arrays TEMP STORAGE DURING NAME SAVE AT INDLOP

  
; The File Control Block is a 36-byte data structure (33 bytes in CP/M 1).
; Second storage space for the file name (like FILNAM)
FILNA2:
  DEFS 16

; -- CP/M 1 FCB structure --
; The File Control Block is a 36-byte data structure (33 bytes in CP/M 1).
FILNAM:
FCB_DRV:
  DEFB $00                                     ; Drive. 0 for default, 1-16 for A-P.
FCB_FNAME:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00         ; File name (8 bytes)
FCB_FTYP:
  DEFB $00,$00,$00                             ; File type (a.k.s. "file extension", 3 bytes)
FCB_EXTENT:
  DEFB $00                                     ; File extent [ie (file pointer % 524288) / 16384], Set to 0 when opening a file
FCB_S1:
  DEFB $00                                     ; Reserved
FCB_S2:
  DEFB $00                                     ; Extent high byte, [ie (file pointer / 524288)]
FCB_RC:
  DEFB $00                                     ; Extent high byte, [ie (file pointer / 524288)]
FCB_AL:
  DEFS 16                                      ; 
FCB_CR:
  DEFB $00                                     ; 
; -- CP/M 1 FCB structure --
;FCB_R0:
;  DEFB $00
;FCB_R1:
;  DEFB $00
;FCB_R2:
;  DEFB $00


IF CPMV1
BDOSVER:
  DEFB $00                ; Current CP/M BDOS version number (#0 is 2.x)

; BDOS function pair, either R/W or SELECT/OPEN
CPMREA:
  DEFB $00                ; BDOS function code for 'READ' (BDOS v2) or 'SELECT DSK' (BDOS v1) call 
CPMWRT:
  DEFB $00                ; BDOS function code for 'WRITE' (BDOS v2) or 'OPEN FILE' (BDOS v1) call
ENDIF

BUFFER:
  DEFM ":"                ; a colon for restarting input
KBUF:
  DEFS KBFLEN  ; THIS IS THE KRUNCH BUFFER


BUFMIN:
  DEFB ","		; a comma used, e.g. in "FILSTI"



; TYPE IN STORED HERE
; DIRECT STATEMENTS EXECUTE OUT OF HERE. REMEMBER "INPUT" SMASHES BUF.
; MUST BE AT A LOWER ADDRESS THAN DSCTMP OR ASSIGNMENT OF STRING
; VALUES IN DIRECT STATEMENTS WON'T COPY INTO STRING SPACE 
; -- WHICH IT MUST ALLOW FOR SINGLE QUOTE IN BIG LINE
BUF:
  DEFS BUFLEN+3           ; Buffer to store characters typed (in ASCII code)
ENDBUF:
  DEFB $00                ;PLACE TO STOP BIG LINES

TTYPOS:
  DEFB $00                ; STORE TERMINAL POSITION HERE

  
; IN GETTING A POINTER TO A VARIABLE IT IS IMPORTANT TO REMEMBER WHETHER IT
; IS BEING DONE FOR "DIM" OR NOT DIMFLG AND VALTYP MUST BE CONSECUTIVE LOCATIONS
;
DIMFLG:
  DEFB $00
VALTYP:
  DEFB $00                ; (word) type indicator  (IN THE 8K 0=NUMERIC 1=STRING)

; OPRTYP (DORES):  USED TO STORE OPERATOR NUMBER IN THE EXTENDED
; MOMENTARILY BEFORE OPERATOR APPLICATION (APPLOP)
OPRTYP:
  DEFB $00                ; a.k.a. DORES, indicates whether stored word can be crunched, etc..

; DONUM: FLAG FOR CRUNCH
; 0 MEANS NUMBERS ALLOWED, (FLOATING,INT, DBL)
; 1 MEANS NUMBERS ALLOWED, KRUNCH BY CALLING LINGET
; -1 ($FF) MEANS NUMBERS DISALLOWED (SCANNING VARIABLE NAME)
DONUM:
  DEFB $00                ; indicates whether we have a number

; USED BY CHRGET TO SAVE THE TEXT POINTER AFTER CONSTANT HAS BEEN SCANNED.
CONTXT:
  DEFW $0000              ; Text address used by CHRGTB

CONSAV:
  DEFB $00                ; Saved token of constant after calling CHRGET
CONTYP:
  DEFB $00                ; SAVED CONSTANT VALTYPE
CONLO:
  DEFS 4                  ; SAVED CONSTANT VALUE
  DEFS 4                  ; EXTRA FOUR BYTES FOR DOUBLE PRECISION

MEMSIZ:
  DEFW $0000              ; Highest location in memory used by BASIC
TEMPPT:
  DEFW $0000              ; (word), start of free area of temporary descriptor
TEMPST:
  DEFS 15                 ; Temporary descriptors
VARIABLES:
  DEFS 15                 ; Storage area for BASIC variables
DSCTMP:
  DEFB $00                ; String descriptor which is the result of string fun
TMPSTR:
  DEFW $0000              ; Temporary string
FRETOP:
  DEFW $0000              ; Starting address of unused area of string area
TEMP3:
  DEFW $0000              ; (word) used for garbage collection or by USR function, a.k.a. CUROPR
TEMP8:
  DEFW $0000              ; Used for garbage collection and at boot as "CPMFIL"
ENDFOR:
  DEFW $0000              ; Next address of FOR st.
DATLIN:
  DEFW $0000              ; Line number of DATA st.read by READ st.
SUBFLG:
  DEFB $00                ; (byte), flag for USR fn. array
FLGINP:
  DEFB $00                ; Flag for INPUT or READ
TEMP:
  DEFW $0000              ; (word) temp. reservation for st.code
PTRFLG:
  DEFB $00                ; =0 if no line number converted to pointers
AUTFLG:
  DEFB $00                ; AUTO mode flag
AUTLIN:
  DEFW $0000              ; Current line number for auto
AUTINC:
  DEFW $0000              ; Increment for auto
SAVTXT:
  DEFW $0000              ; PTR to recent or running line (e.g. used by RESUME)
SAVSTK:
  DEFW $0000              ; Save stack when error occurs
ERRLIN:
  DEFW $0000              ; Line where last error occurred
DOT:
  DEFW $0000              ; Current line for edit & list
ERRTXT:
  DEFW $0000              ; Error messages text table
ONELIN:
  DEFW $0000              ; ON ERROR line
ONEFLG:
  DEFB $00                ; ON ERROR status flag
NXTOPR:
  DEFW $0000              ; a.k.a. TEMP2, Address ptr to next operator, used by EVAL
OLDLIN:
  DEFW $0000              ; old line number set up ^C ...
OLDTXT:
  DEFW $0000              ; Points st. to be executed next
VARTAB:
  DEFW $0000              ; BASIC program end ptr (a.k.a. PROGND, Simple Variables)
ARYTAB:
  DEFW $0000              ; End of variables (aka VAREND), begin of array aariables
STREND:
  DEFW $0000              ; End of arrays (a.k.a. ARREND lowest free mem)
DATPTR:
  DEFW $0000              ; Pointer used by READ to get DATA stored in BASIC PGM
DEFTBL:
  DEFS 26                 ; Default valtype for each letter
PRMSTK:
  DEFW $0000              ; (word), previous block definition on stack
PRMLEN:
  DEFW $0000              ; (word), number of bytes of obj table
PARM1:
  DEFS 100                ; Objective prameter definition table
PRMPRV:
  DEFW $0000              ; Pointer to previous parameter block
PRMLN2:
  DEFW $0000              ; (word), size of parameter block
PARM2:
  DEFS 100                ; For parameter storage
PRMFLG:
  DEFB $00                ; Flag to indicate whether PARM1 was searching
ARYTA2:
  DEFW $0000              ; End point of search
NOFUNS:
  DEFB $00                ; (byte), 0 if no function active
TEMP9:
  DEFW $0000              ; Location of temporary storage for garbage collection
FUNACT:
  DEFW $0000              ; (word), active functions counter
READFLG:
  DEFB $00                ; Flag to indicate the READ status
NEXTMP:
  DEFW $0000              ; Used by NEXT to save code ptr
NEXFLG:
  DEFB $00                ; Flag used by NEXT
FVALSV:
  DEFB $00,$00,$00,$00    ; FP accumulator used by FOR/NEXT commands
NXTLIN:
  DEFW $0000              ; (word), temp line no. storage used in FOR, WHILE, etc..
OPTVAL:
  DEFB $00                ; Array size set with "OPTION BASE", (for 10=default size, value is '0': 10+1 XOR 11)
OPTFLG:
  DEFB $00                ; Array status flag to deal with "OPTION BASE"

;------------------------------------
IF TRAP_BDOS

CPM_ERR_TRAP:
  LD HL,(SAVSTK)
  LD SP,HL
  PUSH DE                 ; Keep the error code in E
  LD C,$0E                ; BDOS function 14 - Select disc (set current drive)
  JP RESUME_DRIVE

  DEFS 14
ELSE

  DEFS 30                 ; Unused ?
ENDIF
;------------------------------------

INTFLG:
  DEFB $00                ; This flag is set if STOP (=4) or CTRL + STOP (=3) is pressed
IMPFLG:
  DEFB $00                ; This flag is related to the INPUT status
SAVFRE:
  DEFW $0000              ; Temporary usage of the free string area (used by CHAIN to keep a copy of FRETOP)
MAXREC:
  DEFW $0000              ; $0bea:  maximum record size for use with random files.
PROFLG:
  DEFB $00                ; 'File protected' status flag
MRGFLG:
  DEFB $00                ; 'In MERGE' status flag
  
MDLFLG:
  DEFB $00                ; Flag to track the 'DELETE' or 'MERGE' option in a CHAIN command
CMEPTR:
  DEFW $0000              ; End line number in a range specified for 'CHAIN'
CMSPTR:
  DEFW $0000              ; Start line number in a range specified for 'CHAIN'
CHNFLG:
  DEFB $00                ; 'In CHAIN' status flag
CHNLIN:
  DEFW $0000              ; Line number to go to after the CHAIN command execution

SWPTMP:
  DEFB $00,$00,$00,$00    ; Value of first variable in SWAP st (8 bytes).
  DEFB $00,$00,$00,$00

TRCFLG:
  DEFB $00                ; 'TRACE' status flag (0 MEANS NO TRACE)

  DEFB $00	; $0bff
FACLOW:
  DEFB $00	; $0c00
  DEFB $00
  DEFB $00	; $0c02
  DEFB $00

FACCU:
  DEFB $00	; $0c04
  DEFB $00	; $0c05
  DEFB $00	; $0c06
FPEXP:
  DEFB $00                ; Floating Point Exponent

SGNRES:
  DEFB $00
  
FLGOVC:                   ;OVERFLOW PRINT FLAG,=0,1 PRINT   FURTHER =1 CHANGE TO 2
  DEFB $00
OVCSTR:
  DEFB $00                ;PLACE TO STORE OVERFLOW FLAG AFTER FIN
FANSII:
  DEFB $00                ;FLAG TO FORCE FIXED OUTPUT (SEE ANSI)

  DEFB $00                ;[TEMPORARY LEAST SIGNIFICANT BYTE]
FPARG:
  DEFB $00                ;[LOCATION OF SECOND ARGUMENT FOR DOUBLE PRECISION]
  DEFB $00
  DEFB $00
  DEFB $00

  DEFB $00
  DEFB $00

  DEFB $00                ;'ARG-1'; High Byte Order of ARG
                          ;FOR INTEL FORMATS MUST HAVE SPACE FOR 11 BITS OF EXPONENT
ARG:
  DEFB $00

FBUFFR:
  DEFS 43                ; Buffer for fout
                         ;THE LAST 3 LOCATIONS ARE TEMP FOR ROM FMULT 
						 
;FMLTT1	SET	FBUFFR+40     ; <-- possibly other locations in this version
;FMLTT2	SET	FBUFFR+41


; Message at 3136
IN_MSG:
  DEFM " in "

; Message at 3140
NULL_STRING:
  DEFB $00

; Message at 3141
OK_MSG:
  DEFM "Ok"
  DEFB $0D
  DEFB $0A
  DEFB $00

; Message at 3146
BREAK_MSG:
  DEFM "Break"
  DEFB $00



;------------  CODE  ------------

IF ZXPLUS3
; ---------------------------------------------------------------
pixelbyte:
		defb	0		; pivot for data transfer

IF SCORPION

p3_poke:
		di
		ex  af,af

IF QUORUM
		LD      BC,80FDh
		LD      A,80h
		OUT     (C),A	; Enable writing on background RAM
ENDIF

IF ZXASC
		ld	a,$0F
		ld bc,$7ffd
		out(c),a
ELSE
IF ELWRO
;		LD A,$A9
;		out($f7),a
ELSE
IF PROFI
		ld	a,$0F
		ld bc,$7ffd
		out(c),a
ELSE
IF HC2000
		ld a,$ee
		out ($c5),a
ELSE
		ld	a,$1F
		ld bc,$7ffd
		out(c),a
ENDIF
ENDIF
ENDIF
ENDIF

		ex af,af
		ld (hl),a

IF HC2000
		ld a,$ee
		out ($c7),a
ELSE

IF ELWRO
;		LD A,$A8
;		out($f7),a
ELSE

;-------------------------------
IF ZXASC
		ld a,8
ELSE
IF PROFI
		ld	a,$0B
ELSE
IF BIOS20 | PINIX
		ld	a,$19
ELSE
IF QUORUM
		LD      B,80h
		xor     a
		OUT     (C),A

		LD      B,7Fh
		ld	a,$0F
ELSE
		ld	a,$1C
ENDIF
ENDIF
ENDIF
ENDIF
;-------------------------------

		out(c),a

ENDIF  ; ELWRO
ENDIF  ; HC2000

		ei
		ret

p3_peek:
		di

IF QUORUM
		LD      BC,80FDh
		LD      A,80h
		OUT     (C),A	; Enable writing on background RAM
ENDIF

IF ZXASC
		ld	a,$0F
		ld bc,$7ffd
		out(c),a
ELSE
IF ELWRO
;		LD A,$A9
;		out($f7),a
ELSE
IF PROFI
		ld	a,$0F
		ld bc,$7ffd
		out(c),a
ELSE
IF HC2000
		ld a,$ee
		out ($c5),a
ELSE
		ld	a,$1F
		ld bc,$7ffd
		out(c),a
ENDIF
ENDIF
ENDIF
ENDIF

		ld a,(hl)
		ex  af,af

IF HC2000
		ld a,$ee
		out ($c7),a
ELSE

IF ELWRO
;		LD A,$A8
;		out($f7),a
ELSE

;-------------------------------
IF ZXASC
		ld a,8
ELSE
IF PROFI
		ld	a,$0B
ELSE
IF BIOS20 | PINIX
		ld	a,$19
ELSE
IF QUORUM
		LD      B,80h
		xor     a
		OUT     (C),A

		LD      B,7Fh
		ld	a,$0F
ELSE
		ld	a,$1C
ENDIF
ENDIF
ENDIF
ENDIF
;-------------------------------

		out(c),a

ENDIF  ; ELWRO
ENDIF  ; HC2000

		ex  af,af
		ei
		ret
ELSE
p3_poke:
		jp 0

p3_peek:
		jp 0
ENDIF


; -- -- -- -- --
__VPOKE:
  CALL GETWORD
  ld b,h	;SAVE TEXT POINTER
  ld c,l

  LD HL,6911
  CALL DCOMPR
  JP C,OMERR

IF SCORPION
IF ELWRO
  ld hl,57344
ELSE
  ld hl,49152
ENDIF
ELSE
  ld hl,16384
ENDIF
  add hl,de

  push hl
  ld h,b	; RESTORE TEXT POINTER
  ld l,c
  
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
  EX (SP),HL
  CALL p3_poke
  POP HL
  RET



; -- -- -- -- --
__VPEEK:
  CALL GETWORD_HL

  LD DE,6912
  CALL DCOMPR
  JP NC,OMERR


IF SCORPION
IF ELWRO
  ld de,57344
ELSE
  ld de,49152
ENDIF
ELSE
  ld de,16384
ENDIF
  add hl,de

  CALL p3_peek
  JP PASSA


; -- -- -- -- --
FN_CSRLIN:
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  
  call subuserf
  DEFW $00BF        ; TE ASK - where is the cursor, what screen size
  
  LD A,H
  INC A             ; top-left corner is at 1:1 as for GW-BASIC, (while MSX had 0:0)
  CALL CONIA        ;CONVERT [A] TO AN INTEGER SIGNED
  POP HL
  RET

;FIND USERF AND CALL IT.  (Amstrad, ZX +3..)
subuserf:
	push hl
	push de
	ld hl,($0001)
	ld de,$0057
	add hl,de
	pop de
	ex (sp),hl
	ret


; -- -- -- -- --
; Cassette handling must be away from the contended memory

IF TAPE



; ----------------------------------------------
;  Cassette output (MSX style) on a ZX Spectrum
; ----------------------------------------------

LOWLIM:  defb 0      ; Used by the Cassette system (minimal length of startbit)
WINWID:  defb 0      ; Used by the Cassette system (store the difference between a low-and high-cycle)

__CLOAD:

  CALL SYNCHR
  DEFB '!'		; LOAD!, new syntax in place of CLOAD

  SUB $91		 ; TK_PRINT (Check if a "CLOAD?" command was issued to VERIFY the file only)
  JR Z,_VERIFY
  XOR A
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it
_VERIFY:
  CPL
  INC HL
  
  CP $01
  PUSH AF
  CALL CLOAD_FNAME_ARG
  LD C,$D3					; BASIC PROGRAM header mode (TK_NAME)
  CALL CLOAD_HEADER
  POP AF
  LD (FACLOW),A
  CALL C,CLRPTR
  LD A,(FACLOW)
  CP $01
  ;LD (FRCNEW),A
  PUSH AF
  CALL DEPTR
  POP AF
  LD HL,(TXTTAB)
  CALL CLOAD_SUB
  JR NZ,__CLOAD_1
  LD (VARTAB),HL
__CLOAD_OK:
  LD HL,OK_MSG				; "Ok" Message
  CALL PRS
  LD HL,(TXTTAB)
  PUSH HL
  JP FINI

__CLOAD_1:
  INC HL
  EX DE,HL
  LD HL,(VARTAB)
  CALL DCOMPR		; Compare HL with DE.
  JP C,__CLOAD_OK
IF TRAP_BDOS
  LD E,$48           ; "Verify error"
ELSE
  LD E,$45           ; "Verify error"
ENDIF
  JP ERROR


CLOAD_HEADER:
  CALL CSROON        ; start tape for reading
  LD B,10            ; we check the leading header marker 10 times
  

CLOAD_HEADER_0:
  CALL CASIN         ; get byte from tape
  CP C
  JR NZ,CLOAD_HEADER
  DJNZ CLOAD_HEADER_0

  LD HL,FILNA2
  PUSH HL
  LD B,$06           ; 6 bytes
CLOAD_HEADER_1:
  CALL CASIN         ; get byte from tape
  LD (HL),A
  INC HL
  DJNZ CLOAD_HEADER_1
  POP HL

  LD DE,FILNAM
  LD B,$06           ; 6 bytes
CLOAD_HEADER_2:
  LD A,(DE)
  INC DE
  CP ' '
  JR NZ,CMP_FNAME
  DJNZ CLOAD_HEADER_2
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
  JR CLOAD_HEADER

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
  LD HL,FILNA2
  LD B,$06
PRNAME_LOOP:
  LD A,(HL)
  INC HL
  CALL OUTDO  		; Output char to the current device
  DJNZ PRNAME_LOOP
  JP OUTDO_CRLF


; Used by the routine at __CLOAD.
CLOAD_SUB:
  CALL CSROON                   ; start tape for reading
  SBC A,A
  CPL
  LD D,A
CLOAD_SUB_0:
  LD B,$0A       ; 10 bytes
CLOAD_SUB_1:
  CALL CASIN     ; get byte from tape
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
  JR NZ,CLOAD_SUB_0
  DJNZ CLOAD_SUB_1
  
  LD BC,$FFFA		; -6
  ADD HL,BC
  XOR A
  JP TAPIOF

CASIN:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL TAPIN	; Get byte from cassette
  JP NC,POPALL_0
  JR DIOERR


CSROON:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL TAPION
  JP NC,POPALL
; This entry point is used by the routines at _CASIN and CASOUT.
DIOERR:
  CALL TAPIOF
IF TRAP_BDOS
  LD E,$47                ; "Tape I/O Error"
ELSE
  LD E,$44                ; "Tape I/O Error"
ENDIF
  JP ERROR


TAPION:
  call TAPOON
  out ($FE),a
TAPION_0:
  LD HL,1111
TAPION_1:
  LD D,C              ; Get tape block mode
  CALL TAPIN_BIT
  RET C               ; Exit if BREAK was pressed
  LD A,C              ; get measured tape sync speed
  CP 222              ; Timeout ?
  JR NC,TAPION_0      ; Try again
  CP 5                ; Too short ?
  JR C,TAPION_0       ; Try again
  SUB D
  JR NC,TAPION_2
  CPL
  INC A
TAPION_2:
  CP $04
  JR NC,TAPION_0     ; Try again
  DEC HL
  LD A,H
  OR L
  JR NZ,TAPION_1     ; Correct leading tone.  It must stay like this 1111 times.
  LD HL,$0000
  LD B,L
  LD D,L
TAPION_3:
  CALL TAPIN_BIT
  RET C               ; Exit if BREAK was pressed
  ADD HL,BC
  DEC D
  JP NZ,TAPION_3
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
  LD (LOWLIM),A			; Keep the minimal length of startbit
  LD A,D
  ADD A,A
  LD B,$00
TAPION_4:
  SUB $03
  INC B
  JR NC,TAPION_4
  LD A,B
  SUB $03
  LD (WINWID),A			;  Store the difference between a low-and high-cycle
  OR A
  RET


TAPIN:
  LD A,(LOWLIM)			; Minimal length of startbit
  LD D,A
TAPIN_0:
  CALL BREAKX			; Set CY if STOP is pressed
  RET C
;  IN A,(PSG_DATAIN)
;  RLCA
;  JR NC,TAPIN_0
  AND $20
  JR NZ,TAPIN_0
TAPIN_1:
  CALL BREAKX			; Set CY if STOP is pressed
  RET C
;  IN A,(PSG_DATAIN)
;  RLCA
;  JR C,TAPIN_1
  AND $20
  JR Z,TAPIN_1

  LD E,$00
  CALL TAPIN_PERIOD
TAPIN_2:
  LD B,C

  CALL TAPIN_PERIOD
  RET C
  LD A,B
  ADD A,C
  JP C,TAPIN_2
  CP D
  JR C,TAPIN_2
;  LD L,8
  LD L,9		; <-- something goes wrong during the first bit 'sync', so we trash one extra bit
TAPIN_BYTE:
  CALL TAPIN_STARTBIT
  CP $04
  CCF
  RET C
  CP $02
  CCF
  RR D
  LD A,C
  RRCA
  CALL NC,TAPIN_PERIOD_0
  CALL TAPIN_PERIOD
  DEC L
  JP NZ,TAPIN_BYTE
  CALL BREAKX		; Set CY if BREAK is pressed
  LD A,D
  RET



TAPIN_STARTBIT:
  LD A,(WINWID)		;  Get the difference between a low-and high-cycle
  LD B,A
  LD C,$00

TAPIN_STARTBIT_0:

;  IN A,(PSG_DATAIN)
;  XOR E
;  JP P,_TAPIN_STARTBIT_1
;  LD A,E
;  CPL
;  LD E,A
;  INC C
;  DJNZ _TAPIN_STARTBIT_0
;  LD A,C
;  RET

;  IN A,(PSG_DATAIN)
  LD A,$7F
  IN A,($FE)
  RRA
  XOR E
  AND $20
  JP Z,TAPIN_STARTBIT_1
  LD A,E
  CPL
  LD E,A
	AND     $07
	;OR      $09
	OR      $0A		; Changing the output mask we may alter the color of the data being loaded
	OUT     ($FE),A
  INC C
  DJNZ TAPIN_STARTBIT_0
  LD A,C
  RET

TAPIN_STARTBIT_1:
  DJNZ TAPIN_STARTBIT_0
  LD A,C
  RET


; Set CY if BREAK is pressed
BREAKX:
  LD A,$7F
  IN A,($FE)
  RRA
  CCF
  RET


TAPIN_BIT:
  CALL BREAKX		; Set CY if STOP is pressed
  RET C
;  IN A,(PSG_DATAIN)
;  RLCA
  AND $20
  JR NZ,TAPIN_BIT		; .. should it be JR Z, ?
  LD E,$00
  CALL TAPIN_PERIOD_0
  JP TAPIN_PERIOD_1


; Used by the routine at TAPIN.
TAPIN_PERIOD:
  CALL BREAKX		; Set CY if STOP is pressed
  RET C
TAPIN_PERIOD_0:
  LD C,$00

;TAPIN_PERIOD_1:
;  INC C
;  JR Z,TAPIN_PERIOD_OVERFLOW
;  IN A,(PSG_DATAIN)
;  XOR E
;  JP P,TAPIN_PERIOD_1

TAPIN_PERIOD_1:
  INC C
  JR Z,TAPIN_PERIOD_OVERFLOW
  LD A,$7F
  IN A,($FE)
  RRA
;  CCF
;  RET C

;  IN A,(PSG_DATAIN)
  XOR E
  AND $20
  JP Z,TAPIN_PERIOD_1
  LD A,E
  CPL
  LD E,A
	AND     $07
	OR      $09
	OUT     ($FE),A
  RET

TAPIN_PERIOD_OVERFLOW:
  DEC C
  RET



; ----------------------------------------------
;  Cassette output (MSX style) on a ZX Spectrum
; ----------------------------------------------


SAVEND: defw 0


__CSAVE:
  CALL SYNCHR
  DEFB '!'		; SAVE!, new syntax in place of CSAVE

  CALL FNAME_ARG
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__CSAVE_0
  
  JP SN_ERR
  ;CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ;DEFB ','
  ;CALL SET_BAUDRATE
__CSAVE_0:
  PUSH HL
  LD A,$D3			; BASIC program type header
  CALL __CSAVE_HEADER
  LD HL,(VARTAB)
  LD (SAVEND),HL
  LD HL,(TXTTAB)
  CALL __CSAVE_BAS
  POP HL
  RET



__CSAVE_BAS:
  PUSH HL
  CALL LINE2PTR_00
  XOR A
  CALL CWRTON		; start tape for writing
  POP DE
  LD HL,(SAVEND)
__CSAVE_BAS_0:
  LD A,(DE)
  INC DE
  CALL CASOUT		; send byte to tape
  CALL DCOMPR		; Compare HL with DE.
  JR NZ,__CSAVE_BAS_0
  LD L,$07
__CSAVE_BAS_1:
  CALL CASOUT		; send byte to tape
  DEC L
  JR NZ,__CSAVE_BAS_1
  JP TAPOOF


__CSAVE_HEADER:
  CALL CWRTON		; start tape for writing
  LD B,10           ; we write the leading header marker 10 times
__CSAVE_HEADER_0:
  CALL CASOUT		; send byte to tape
  DJNZ __CSAVE_HEADER_0
  LD B,$06
  LD HL,FILNAM
__CSAVE_HEADER_1:
  LD A,(HL)
  INC HL
  CALL CASOUT		; send byte to tape
  DJNZ __CSAVE_HEADER_1
  JP TAPOOF


LINE2PTR_00:
  LD A,(PTRFLG)
  OR A
  RET Z
  JP SCCPTR


__snd_tick:  DEFB 0

TAPOON:
	di
	ld a,(BDRCLR)
	ld  (__snd_tick),a
	and 7
	or	8
	ret

TAPIOF:
TAPOOF:
	LD	A,(BDRCLR)
	out	($FE),a
	EI
	RET


CWRTON:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL TAPOON
  

  OR A
  PUSH AF

  LD HL,$0000
CWRTON_0:
  DEC HL
  LD A,H
  OR L
  JR NZ,CWRTON_0

  POP AF
  LD A,PLAY_MSXDATA_HDR
  JR Z,CWRTON_1
  ADD A,A
  ADD A,A
CWRTON_1:
  LD B,A
  LD C,$00
  ;DI
CWRTON_2:
  CALL TAPSEND_HIGH
  CALL TAPSEND_RET
  DEC BC
  LD A,B
  OR C
  JR NZ,CWRTON_2

POPALL:
  POP AF
POPALL_0:
  POP BC
  POP DE
  POP HL
TAPSEND_RET:
  RET


CLOAD_FNAME_ARG:
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR  NZ,FNAME_ARG
  PUSH HL
  LD  HL,FILNAM
  LD  B,$06
  JR  FNAME_ARG_1

FNAME_ARG:
  CALL EVAL         ;EVALUATE STRING ARGUMENT
  PUSH HL           ;SAVE TXTPTR
  CALL __ASC_0
  DEC HL
  DEC HL
  LD  B,(HL)
  LD  C,$06
  LD  HL,FILNAM
FNAME_ARG_0:
  LD  A,(DE)
  LD  (HL),A
  INC HL
  INC DE
  DEC C
  JR  Z,FNAME_ARG_2
  DJNZ FNAME_ARG_0
  LD  B,C
FNAME_ARG_1:
  LD (HL),' '
  INC HL
  DJNZ FNAME_ARG_1
FNAME_ARG_2:
  POP HL
  RET

CASOUT_HL:
  LD A,L
  CALL CASOUT
  LD A,H
  JP CASOUT

CASOUT:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF

  LD HL,PLAY_MSXDATA_LO
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

  JR POPALL



TAPSEND_HIGH_X2:
  CALL TAPSEND_HIGH
  EX   (SP),HL
  EX   (SP),HL
  NOP
  NOP
  NOP
  NOP
  CALL TAPSEND_HIGH
  RET

defc PLAY_MSXDATA_HI     = $2D26   ; 1200 baud, High tone period
defc PLAY_MSXDATA_LO     = $5C53   ; 1200 baud, Low tone period
defc PLAY_MSXDATA_HDR    = 15      ; 1200 baud, leading tone cycle count

TAPSEND_LOW:
  LD HL,PLAY_MSXDATA_LO
  CALL TAPSEND_0
  RET


TAPSEND_HIGH:
  LD HL,PLAY_MSXDATA_HI

TAPSEND_0:
  PUSH AF

TAPSEND_1:
  DEC L
  JP NZ,TAPSEND_1
		ld	a,(__snd_tick)		; MIC on
		;xor  16					; MIC on<>off
		XOR     $1E
		out ($FE),a
TAPSEND_2:
  DEC H
  JP NZ,TAPSEND_2
		ld	a,(__snd_tick)		; MIC on
		out ($FE),a
  POP AF
  RET

ENDIF

; ---------------------------------------------------------------



ENDIF



; Search FOR or GOSUB block on stack
;
; Used by the routines at __RETURN and __NEXT.
BAKSTK:
  LD HL,$0004             ; Look for "FOR" block with         ; IGNORING EVERYONES "NEWSTT" AND THE RETURN..
  ADD HL,SP               ; same index as specified           ; ..ADDRESS OF THIS SUBROUTINE

; Look for "FOR" block with same index as specified in D
; a.k.a. FNDFOR
;
; This entry point is used by the routine at __FOR.
LOKFOR:
  LD A,(HL)               ; Get block ID (SEE WHAT TYPE OF THING IS ON THE STACK)
  INC HL                  ; Point to index address
  CP TK_WHILE             ; Is it a "WHILE" token
  JP NZ,LOKFOR_0          ; No - check "FOR" as well
  LD BC,$0006             ; WHLSIZ
  ADD HL,BC
  JP LOKFOR

LOKFOR_0:
  CP TK_FOR               ; Is it a "FOR" token                     ;IS THIS STACK ENTRY A "FOR"?
  RET NZ                  ; No - exit                               ;NO SO OK
  LD C,(HL)               ; BC = Address of "FOR" index
  INC HL                                                            ;DO EQUIVALENT OF PUSHM / XTHL
  LD B,(HL)
  INC HL                  ; Point to sign of STEP
  PUSH HL                 ; Save pointer to sign                    ;PUT H  ON
  LD H,B                  ; HL = address of "FOR" index             ;PUSH B / XTHL IS SLOWER
  LD L,C
  LD A,D                  ; See if an index was specified           ;FOR THE "NEXT" STATMENT WITHOUT AN ARGUMENT
  OR E                    ; DE = 0 if no index specified            ;WE MATCH ON ANYTHING
  EX DE,HL                ; Specified index into HL                 ;MAKE SURE WE RETURN [D,E]
  JP Z,INDFND             ; Skip if no index given                  ;POINTING TO THE VARIABLE
  EX DE,HL                ; Index back into DE
  CALL DCOMPR             ; Compare index with one given
  
; a.k.a. POPGOF
INDFND:
  LD BC,$0010             ; FORSZC: Offset to next block            ;TO WIPE OUT A "FOR" ENTRY
  POP HL                  ; Restore pointer to sign
  RET Z                   ; Return if block found, WITH [H,L] POINTING THE BOTTOM OF THE ENTRY
  ADD HL,BC               ; Point to next block
  JP LOKFOR               ; Keep on looking



; THIS ROUTINE IS CALLED TO RESET THE STACK IF BASIC IS
; EXTERNALLY STOPPED AND THEN RESTARTED.

; This entry point is used by ERROR and BASIC_MAIN routines.
WARM_BT:
  LD BC,RESTART           ;(a.k.a. STPRDY), ADDRESS GO TO, ALSO POP OFF GARBAGE STACK ENTRY.
  JP ERESET               ;RESET STACK, GOTO READY.

; This entry point is used by the routine at NEWSTT_0.
PRG_END:
  LD HL,(CURLIN)          ;GET CURRENT LINE #
  LD A,H                  ;SEE IF in 'DIRECT' (immediate) mode
  AND L                   ;AND TOGETHER
  INC A                   ;SET CC'S
  JP Z,PRG_END_0          ;IF DIRECT DONE, ALLOW FOR DEBUGGING PURPOSES
  LD A,(ONEFLG)           ;SEE IF IN ON ERROR
  OR A                    ;SET CC
  LD E,$13                ;"NO RESUME" ERROR (Err $13)
  JP NZ,ERROR             ;YES, FORGOT RESUME
PRG_END_0:
  JP ENDCON               ;NO, LET IT END



; 'Disk full' error entry
;
; Used by the routine at __EOF.
DSK_FULL_ERR:
  LD E,$3D                ;"DISK FULL"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Disk I/O error' error entry
;
; Used by the routine at __EOF.
DISK_ERR:
  LD E,$39                ;"DISK I/O ERROR"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad file mode' error entry
;
; Used by the routines at __EOF, __OPEN, FILGET, __MERGE, __FIELD, FN_INPUT
; and __GET.
FMODE_ERR:
  LD E,$36                ;"BAD FILE MODE"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'File not found' error entry
;
; Used by the routines at __NAME, __OPEN, __KILL and __FILES.
FF_ERR:
  LD E,$35                ;"FILE NOT FOUND"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad file number' error entry
;
; Used by the routines at __EOF, __LOC, __LOF, __OPEN, FILGET and __FIELD.
BN_ERR:
  LD E,$34                ;"BAD FILE NUMBER"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Internal error' error entry
IE_ERR:
  LD E,$33                ;"INTERNAL ERROR"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Input past END' (EOF) error entry
;
; Used by the routines at LINE_INPUT and FN_INPUT.
EF_ERR:
  LD E,$3E                ;"READ PAST END"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'File already open' error entry
;
; Used by the routine at __OPEN.
AO_ERR:
  LD E,$37                ;"FILE ALREADY OPEN"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad file name' error entry
;
; Used by the routine at FNAME.
NM_ERR:
  LD E,$40                ;"BAD FILE NAME"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad record number' error entry
;
; Used by the routine at __GET.
RECNO_ERR:
  LD E,$3F                ;"BAD RECORD NUMBER"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'FIELD overflow' error entry
;
; Used by the routines at __FIELD and __GET.
FO_ERR:
  LD E,$32                ;"FIELD OVERFLOW"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Too many files' error entry
;
; Used by the routines at __EOF, __LOF, __OPEN and ACCFIL.
FL_ERR:
  LD E,$43                ;"TOO MANY FILES"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'File already exists' error entry
;
; Used by the routine at __NAME.
FILE_EXISTS_ERR:
  LD E,$3A                ;"FILE ALREADY EXISTS"
  JP ERROR



; 'SN err' entry for Input STMT
;
; Used by the routine at SCNSTR.
DATSNR:
  LD HL,(DATLIN)            ;GET DATA LINE
  LD (CURLIN),HL            ;MAKE IT CURRENT LINE


; 'Syntax Error' message
;
; Used by the routines at LNUM_RANGE, SAVSTP, NEWSTT_0, __GOTO, __AUTO, SCNSTR,
; NOTQTI, _EVAL, OCTCNS, DOFN, ISMID, __WAIT, __RENUM, __OPTION, __LOAD,
; __MERGE, __WEND, __CHAIN, __GET, GETVAR, SBSCPT, NOTSCI, SYNCHR, __CLEAR and
; INIT.
SN_ERR:
  LD E,$02                ;"SYNTAX ERROR"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Division by zero' error entry
;
; Used by the routines at IMULT5 and DDIV_SUB.
O_ERR:
  LD E,$0B                ;DIVISION BY ZERO
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'NEXT without FOR' error entry
;
; Used by the routine at __NEXT.
NF_ERR:
  LD E,$01                ;"NEXT WITHOUT FOR" ERROR
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Redimensioned array' error entry (re-dim not allowed)
;
; Used by the routines at __OPTION and NXTARY.
DD_ERR:
  LD E,$0A                ;"REDIMENSIONED VARIABLE"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Undefined user function' error entry
;
; Used by the routine at DOFN.
UFN_ERR:
  LD E,$12                ;"UNDEFINED FUNCTION" ERROR
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'RESUME without error' error entry
;
; Used by the routine at __RESUME.
RW_ERR:
  LD E,$14                ;"RESUME WITHOUT ERROR"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Overflow' error entry
;
; Used by the routines at OCTCNS, __CINT, DDIV_SUB and __NEXT.
OV_ERR:
  LD E,$06                ;SET OVERFLOW ERROR CODE
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Operand Error' error entry
;
; Used by the routine at OPRND.
MO_ERR:
  LD E,$16                ;MISSIN OPERAND ERROR
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Type mismatch' error entry
;
; Used by the routines at FORFND, _EVAL, INVSGN, VSIGN, __CINT,
; __CSNG, __CDBL, TSTSTR, __INT and __TROFF.
TM_ERR:
  LD E,$0D                 ;TYPE MISMATCH ERROR


; This entry point is used by the routines at WARM_BT, FILE_EXISTS_ERR,
; TSTNUM, FC_ERR, UL_ERR, __RETURN, __ERROR, FDTLP, IDTEST, SCNCNT,
; __MERGE, __WEND, BS_ERR, CHKSTK, __CONT, PUTTMP, TESTOS and CONCAT.
ERROR:
  LD HL,(CURLIN)            ;GET CURRENT LINE NUMBER
  LD (ERRLIN),HL            ;SAVE IT FOR ERL VARIABLE
  XOR A                     ;CLEAR CHAIN FLAG IN CASE OF ERROR
  LD (MRGFLG),A             ;ALSO MERGE FLAG
  LD (CHNFLG),A             ;SO IT DOESNT TRY TO CHAIN
  LD A,H                    ;ONLY SET UP DOT IF IT ISNT DIRECT
  AND L
  INC A
  JP Z,ERRESM
  LD (DOT),HL               ;SAVE IT FOR EDIT OR LIST


; This entry point is used by the routine at __ON.
ERRESM:
  LD BC,ERRMOR              ;GET RETURN ADDRESS IN [B,C]
; This entry point is used by the routine at WARM_BT.
ERESET:
  LD HL,(SAVSTK)            ;GET A GOOD STACK BACK
  JP STKERR                 ;JUMP INTO STKINI

; Routine at 3330
ERRMOR:
  POP BC                    ;POP OFF FNDFOR STOPPER
  LD A,E                    ;[A]=ERROR NUMBER
  LD C,E                    ;ALSO SAVE IT FOR LATER RESTORE
  LD (ERRFLG),A             ;SAVE IT SO WE KNOW WHETHER TO CALL "EDIT"
  LD HL,(SAVTXT)            ;GET SAVED TEXT POINTER
  LD (ERRTXT),HL            ;SAVE FOR RESUME.
  EX DE,HL                  ;SAVE SAVTXT PTR
  LD HL,(ERRLIN)            ;GET ERROR LINE #
  LD A,H                    ;TEST IF DIRECT LINE
  AND L                     ;SET CC'S
  INC A                     ;SETS ZERO IF DIRECT LINE (65535)
  JP Z,NTMDCN               ;IF DIRECT, DONT MODIFY OLDTXT & OLDLIN
  LD (OLDLIN),HL            ;SET OLDLIN=ERRLIN.
  EX DE,HL                  ;GET BACK SAVTXT
  LD (OLDTXT),HL            ;SAVE IN OLDTXT.
NTMDCN:
  LD HL,(ONELIN)            ;SEE IF WE ARE TRAPPING ERRORS.
  LD A,H                    ;BY CHECKING FOR LINE ZERO.
  OR L                      ;IS IT?
  EX DE,HL                  ;PUT LINE TO GO TO IN [D,E]
  LD HL,ONEFLG              ;POINT TO ERROR FLAG
  JP Z,ERROR_REPORT         ;SORRY, NO TRAPPING...
  AND (HL)                  ;A IS NON-ZERO, SETZERO IF ONEFLG ZERO
  JP NZ,ERROR_REPORT        ;IF FLAG ALREADY SET, FORCE ERROR
  DEC (HL)                  ;IF ALREADY IN ERROR ROUTINE, FORCE ERROR
  EX DE,HL                  ;GET LINE POINTER IN [H,L]
  JP GONE4                  ;GO DIRECTLY TO NEWSTT CODE


; Interactive error handling (print error message and break)
; a.k.a. NOTRAP
;
; Used by the routine at ERRMOR.
ERROR_REPORT:
  XOR A                     ;A MUST BE ZERO FOR CONTRO
  LD (HL),A                 ;RESET ONEFLG
  LD E,C                    ;GET BACK ERROR CODE
  LD (CTLOFG),A             ;FORCE OUTPUT
  CALL CONSOLE_CRLF         ;CRLF
  LD HL,ERROR_MESSAGES      ;GET START OF ERROR TABLE
  LD A,E                    ;GET ERROR CODE

  CP LSTERR                 ;IS IT PAST LAST ERROR?

  JP NC,UE_ERR              ;YES, TOO BIG TO PRINT
  CP $32                    ;(DSKERR+1) DISK ERROR?
  JP NC,NTDER2              ;JP if error code is between $32 and $43
IF TRAP_BDOS
  CP $20                    ; ...and a trap on WBOOT  
ELSE
  CP $1F                    ;(NONDSK+1) IS IT BETWEEN LAST NORMAL & FIRST DISK?
ENDIF
  JP C,LEPSKP               ;YES, OK TO PRINT IT (JP if error code is < $1F)

; a.k.a. UPERR
; Used by the routines at ERROR_REPORT and _ERROR_REPORT.
UE_ERR:
; if error code is bigger than $43 then force it to $28-$13=$15 ("Unprintable error")
IF TRAP_BDOS
  LD A,$27
ELSE
  LD A,$28  ;(ERRUE+DSKERR-NONDSK): PRINT "UNPRINTABLE ERROR"
ENDIF

; JP here if error code is between $32 and $43, then sub $13
;
; Used by the routine at ERROR_REPORT.
NTDER2:
IF TRAP_BDOS
  SUB $12
ELSE
  SUB $13                   ; (DSKERR-NONDSK): FIX OFFSET INTO TABLE OF MESSAGES
ENDIF
  LD E,A                    ;SAVE BACK ERROR CODE
; This entry point is used by the routine at ERROR_REPORT.
LEPSKP:                     ;ON "SYNTAX ERROR"S
  CALL __REM                ;SKIP AN ERROR MESSAGE
  INC HL                    ;SKIP OVER THIS ERROR MESSAGE
  DEC E                     ;DECREMENT ERROR COUNT
  JP NZ,LEPSKP              ;SKIP SOME MORE
  PUSH HL                   ;SAVE TEXT POINTER
  LD HL,(ERRLIN)            ;GET ERROR LINE NUMBER
  EX (SP),HL                ;GET BACK ERROR TEXT POINTER

; Halfway in the interactive error handling (print error message and break)
;
; Used by the routine at INPBRK.
_ERROR_REPORT:
  LD A,(HL)                 ;GET 1ST CHAR OF ERROR
  CP $3F                    ;PADDED ERROR?
  JP NZ,_LEPSKP             ;NO,PRINT
  POP HL                    ;GET LINE # OFF STACK
  LD HL,ERROR_MESSAGES
  JP UE_ERR                 ;MAKE UNPRINTABLE ERROR


_LEPSKP:
  CALL PRS                 	;PRINT MESSAGE
  POP HL                    ;RESTORE LINE NUMBER
  LD DE,-2                  ;IS INIT EXECUTING?
  CALL DCOMPR
  CALL Z,OUTDO_CRLF        	;DO CRLF
  JP Z,EXIT_TO_SYSTEM       ;SYSTEM error exit
  
  LD A,H                   	;SEE IF IN DIRECT MODE
  AND L                     
  INC A                     ;ZERO SAYS DIRECT MODE
  CALL NZ,IN_PRT            ;PRINT LINE NUMBER IN [H,L]


; NOW FALL INTO MAIN INTERPRETER LOOP
;
; FOR "LIST" COMMAND STOPPING
; AND FOR RETURNING FROM A FAILED "CVER"
; AND TO CORRECT A DIRECT GOSUB WHICH DOES INPUT
;
  DEFB $3E                ; "LD A,n" to Mask the next byte WITH "MVI A,0"

; $0D86: RESTART
;
; Used by the routines at __LIST and INPBRK.
RESTART:
  POP BC

; KO

; --- START PROC READY ---
;
; Used by the routines at PROMPT, __LIST, __LOAD, EDIT_DONE and INITSA.
READY:

IF HAVE_GFX
  CALL TOTEXT               ; Go back in text mode if in graphics mode (e.g. if BREAK was pressed)
ENDIF

  CALL FINLPT              ;PRINT ANY LEFT OVERS
  XOR A                    
  LD (CTLOFG),A            ;FORCE OUTPUT
  CALL LOAD_END            ;FINISH OUTPUT OF A FILE
  CALL CONSOLE_CRLF        ;IF NOT ALREADY AT LEFT, SEND CRLF
  LD HL,OK_MSG             ;"OK" CRLF CRLF

;  Other versione here have an extra check:
;  "ERRORS IN CP/M INITIALIZATION, RETURN TO CP/M"

  DEFB $CD                 ; CALL CPMWRM   ->  Warm boot

; Data block at 3480
SMC_PRINTMSG:
  DEFW 0

; Routine at 3482
READY_0:
  LD A,(ERRFLG)            ;SEE IF IT WAS A "SYNTAX ERROR"
  SUB $02
  CALL Z,ERR_EDIT          ;"EDIT" THE BAD LINE



; Routine at 3490
;
; Used by the routines at __AUTO, __LOAD and __MERGE.
PROMPT:
  LD HL,-1                 ;SETUP CURLIN FOR DIRECT MODE
  LD (CURLIN),HL		   ;Set interpreter in 'DIRECT' (immediate) mode
  LD A,(AUTFLG)            ;IN AN AUTO COMMAND?
  OR A                     ;SET CC'S
  JP Z,GETCMD              ;NO, REUGLAR MODE
  LD HL,(AUTLIN)           ;GET CURRENT AUTO LINE
  PUSH HL                  ;SAVE AWAY FOR LATER USE
  CALL LINPRT              ;PRINT THE LINE #
  POP DE                   ;GET IT BACK
  PUSH DE                  ;SAVE BACK AGAIN
  CALL SRCHLN              ;SEE IF IT EXISTS
  LD A,'*'                 ;CHAR TO PRINT IF LINE ALREADY EXISTS
  JP C,AUTELN              ;DOESNT EXIST
  LD A,' '                 ;PRINT SPACE
AUTELN:
  CALL OUTDO               ;PRINT CHAR
  CALL PINLIN              ;READ A LINE
  POP DE                   ;GET LINE # OFF STACK
  JP NC,AUTGOD             ;IF NO CONTROL-C, PROCEED
  XOR A                    ;CLEAR AUTFLG
  LD (AUTFLG),A            ;BY SETTING IT TO ZERO
  JP READY                 ;PRINT READY MESSAGE


AUTRES:
  XOR A
  LD (AUTFLG),A            ;Clear auto flag
  JP AUTSTR                ;And enter line
  
AUTGOD:
  LD HL,(AUTINC)           ;GET INCREMENT
  ADD HL,DE                ;ADD INCREMENT TO THIS LINE
  JP C,AUTRES              ;CHECK FOR PATHETIC CASE
  PUSH DE                  ;SAVE LINE NUMBER #
  LD DE,65529              ;CHECK FOR LINE # TOO BIG
  CALL DCOMPR
  POP DE                   ;GET BACK LINE #
  JP NC,AUTRES             ;IF TOO BIG, QUIT
  LD (AUTLIN),HL           ;SAVE IN NEXT LINE

;SET NON-ZERO CONDITION CODES (SEE EDIT)
AUTSTR:
  LD A,(BUF)               ;GET CHAR FROM BUFFER
  OR A                     ;IS IT NULL LINE?
  JP Z,PROMPT              ;YES, LEAVE LINE ALONE
  JP EDITRT                ;JUMP INTO EDIT CODE


; a.k.a. _INLIN
GETCMD:
  CALL PINLIN             ; GET A LINE FROM TTY
  JP C,PROMPT             ; IGNORE ^C S
  CALL CHRGTB             ; Get first character                  GET THE FIRST
  INC A                   ; Test if end of line                  SEE IF 0 SAVING THE CARRY FLAG
  DEC A                   ; Without affecting Carry
  JP Z,PROMPT             ; Nothing entered - Get another        IF SO, A BLANK LINE WAS INPUT
  PUSH AF                 ; Save Carry status                    SAVE STATUS INDICATOR FOR 1ST CHARACTER
  CALL ATOH               ; Get line number into DE              READ IN A LINE #
  CALL BAKSP              ; BACK UP THE POINTER
  LD A,(HL)               ;GET THE CHAR
  CP ' '                  ; Is it a space?                       CHARACTER A SPACE?
  CALL Z,INCHL            ;THEN EAT PAST IT
                          ;(ONE SPACE ALWAYS PRINTED AFTER LINE #)
  
; This entry point is used by the routine at EDIT_DONE.
EDENT:
  PUSH DE                 ;SAVE LINE #
  CALL TOKENIZE			  ;CRUNCH THE LINE DOWN ; (CRUNCH)
  POP DE                  ;RESTORE LINE #
  POP AF                  ;WAS THERE A LINE #?
  LD (SAVTXT),HL          ;FOR RESUMING A DIRECT STMT 
  JP NC,DIRDO             ;MAKE SURE WE'RE NOT READING A FILE
  PUSH DE                 
  PUSH BC                 ;SAVE LINE # AND CHARACTER COUNT
  CALL PROCHK             ;DONT ALLOW ANY FUNNY BUSINESS WITH EXISTING PGM
  CALL CHRGTB             ;REMEMBER IF THIS LINE IS
  OR A                    ;SET THE ZERO FLAG ON ZERO      LINES THAT START WITH ":" SHOULD NOT BE IGNORED
  PUSH AF                 ;BLANK SO WE DON'T INSERT IT
  LD (DOT),DE             ;SAVE THIS LINE # IN DOT;
  CALL SRCHLN             ; Search for line number in DE: GET A POINTER TO THE LINE
  JP C,LINFND             ; Jump if line found: LINE EXISTS, DELETE IT
  POP AF                  ;GET FLAG SAYS WHETHER LINE BLANK
  PUSH AF                 ;SAVE BACK
  JP Z,UL_ERR             ;TRYING TO DELETE NON-EXISTANT LINE, ERROR
  OR A                    ;CLEAR FLAG THAT SAYS LINE EXISTS
LINFND:
  PUSH BC                 ; Save address of line in prog
  PUSH AF                 ;SAVE REGISTERS
  PUSH HL                 ;SAVE [H,L]
  CALL DEPTR              ;GET RID OF PTRS IN PGM
  POP HL                  ;GET BACK POINTER TO NEXT LINE
  POP AF                  ;GET BACK PSW
  POP BC                  ;RESTORE POINTER TO THIS LINE
  PUSH BC                 ;SAVE BACK AGAIN
  CALL C,__DELETE_0       ;DELETE THE LINE
  POP DE                  ;POP POINTER AT PLACE TO INSERT
  POP AF                  ;SEE IF THIS LINE HAD ANYTHING ON IT
  PUSH DE                 ;SAVE PLACE TO START FIXING LINKS
  JP Z,FINI               ;IF NOT DON'T INSERT
  POP DE                  ;GET RID OF START OF LINK FIX
  LD A,(CHNFLG)           ;ONLY CHANGET FRETOP IF NOT CHAINING
  OR A                    ; Clear Carry
  JP NZ,LEVFRE            ;LEAVE FRETOP ALONE
  LD HL,(MEMSIZ)          ;DELETE ALL STRINGS
  LD (FRETOP),HL          ;SO REASON DOESNT USE THEM


LEVFRE:
  LD HL,(VARTAB)          ; Get end of program           CURRENT END
  EX (SP),HL              ; Get length of input line     [H,L]=CHARACTER COUNT. VARTAB ONTO THE STACK
  POP BC                  ; End of program to BC         [B,C]=OLD VARTAB
  PUSH HL                 ;SAVE COUNT OF CHARS TO MOVE
  ADD HL,BC               ; Find new end
  PUSH HL                 ; Save new end                 SAVE NEW VARTAB
  CALL MOVUP              ; Make space for line
  POP HL                  ; Restore new end              POP OFF VARTAB
  LD (VARTAB),HL          ; Update end of program pointer
  EX DE,HL                ; Get line to move up in HL
  LD (HL),H               ; Save MSB                     FOOL CHEAD WITH NON-ZERO LINK
  POP BC                  ;                              RESTORE COUNT OF CHARS TO MOVE
  POP DE                  ; Get new line number          GET LINE # OFF STACK
  PUSH HL                 ;           SAVE START OF PLACE TO FIX LINKS SO IT DOESN'T THINK
  INC HL                  ;                 THIS LINK IS THE END OF THE PROGRAM
  INC HL
  LD (HL),E               ; Save LSB of line number      PUT DOWN LINE #
  INC HL
  LD (HL),D               ; Save MSB of line number
  INC HL                  ; To first byte in line
  LD DE,KBUF              ; Copy buffer to program       ;MOVE LINE FRM KBUF TO PROGRAM AREA
  DEC BC                                                 ;FIX UP COUNT OF CHARS TO MOVE
  DEC BC                                                 ;(DONT INCLUDE LINE # & LINK)
  DEC BC
  DEC BC

; NOW TRANSFERING LINE IN FROM BUF
MOVBUF:
  LD A,(DE)               ; Get source
  LD (HL),A               ; Save destinations
  INC HL                  ; Next source
  INC DE                  ; Next destination
  DEC BC
  LD A,C
  OR B                    ; Done?
  JP NZ,MOVBUF            ; No - Repeat
FINI:
  POP DE                  ;GET START OF LINK FIXING AREA
  CALL CHEAD              ;FIX LINKS
  LD HL,DIRTMP            ;(DIRTMP) DON'T ALLOW ZERO TO BE CLOSED
  LD (HL),$00             ;NOT SEQUENTIAL OUTPUT
  LD (FILPTR),HL
  LD HL,(PTRFIL)          ;GET FILE POINTER, COULD BE ZERO
  LD (NXTOPR),HL          ;SAVE IT
  CALL RUN_FST            ;DO CLEAR & SET UP STACK 
  LD HL,(FILPT1)          ;RESET [FILPTR]
  LD (FILPTR),HL
  LD HL,(NXTOPR)          ;RESET [PTRFIL]
  LD (PTRFIL),HL
  JP PROMPT               ;GO TO MAIN CODE


; Update interpreter pointers
;
; Used by the routines at __LOAD and CAYSTR.
LINKER:
  LD HL,(TXTTAB)
  EX DE,HL
; This entry point is used by the routine at PROMPT.
;
; CHEAD GOES THROUGH PROGRAM STORAGE AND FIXES
; UP ALL THE LINKS. THE END OF EACH
; LINE IS FOUND BY SEARCHING FOR THE ZERO AT THE END.
; THE DOUBLE ZERO LINK IS USED TO DETECT THE END OF THE PROGRAM
;
CHEAD:
  LD H,D                  ;[H,L]=[D,E]
  LD L,E
  LD A,(HL)               ;SEE IF END OF CHAIN
  INC HL                  ;BUMP POINTER
  OR (HL)                 ;2ND BYTE
  RET Z
  INC HL                  ;FIX H TO START OF TEXT
  INC HL
CZLOOP:
  INC HL                  ;BUMP POINTER
  LD A,(HL)               ;GET BYTE
CZLOO2:
  OR A                    ;SET CC'S
  JP Z,CZLIN              ;END OF LINE, DONE.
  CP DBLCON+1             ;EMBEDDED CONSTANT?
  JP NC,CZLOOP            ;NO, GET NEXT
  CP $0A+1                ;IS IT LINEFEED OR BELOW?
  JP C,CZLOOP             ;THEN SKIP PAST
  CALL __CHRCKB           ;GET CONSTANT
  CALL CHRGTB             ;GET OVER IT
  JP CZLOO2               ;GO BACK FOR MORE
CZLIN:
  INC HL                  ;MAKE [H,L] POINT AFTER TEXT
  EX DE,HL                ;SWITCH TEMP
  LD (HL),E               ;DO FIRST BYTE OF FIXUP
  INC HL                  ;ADVANCE POINTER
  LD (HL),D               ;2ND BYTE OF FIXUP
  JP CHEAD                ;KEEP CHAINING TIL DONE

; Line number range
;
; SCNLIN SCANS A LINE RANGE OF
; THE FORM  #-# OR # OR #- OR -# OR BLANK
; AND THEN FINDS THE FIRST LINE IN THE RANGE
;
; Used by the routines at __LIST, __DELETE and __CHAIN.
LNUM_RANGE:
  LD DE,$0000             ;ASSUME START LIST AT ZERO
  PUSH DE                 ;SAVE INITIAL ASSUMPTION
  JP Z,ALL_LIST           ;IF FINISHED, LIST IT ALL
  POP DE                  ;WE ARE GOING TO GRAB A #
  CALL LNUM_PARM          ;GET A LINE #. IF NONE, RETURNS ZERO
  PUSH DE                 ;SAVE FIRST
  JP Z,SNGLIN             ;IF ONLY # THEN DONE.
  CALL SYNCHR
  DEFB TK_MINUS           ;MUST BE A DASH.
ALL_LIST:
  LD DE,65530             ;ASSUME MAX END OF RANGE
  CALL NZ,LNUM_PARM       ;GET THE END OF RANGE
  JP NZ,SN_ERR            ;MUST BE TERMINATOR
SNGLIN:
  EX DE,HL                ;[H,L] = FINAL
  POP DE                  ;GET INITIAL IN [D,E]

; Routine at 3830
;
; Used by the routine at __ON.
FNDLN1:
  EX (SP),HL              ;PUT MAX ON STACK, RETURN ADDR TO [H,L]
  PUSH HL                 ;SAVE RETURN ADDRESS BACK

;
; FNDLIN SEARCHES THE PROGRAM TEXT FOR THE LINE
; WHOSE LINE # IS PASSED IN [D,E]. [D,E] IS PRESERVED.
; THERE ARE THREE POSSIBLE RETURNS:
;
;	1) ZERO FLAG SET. CARRY NOT SET.  LINE NOT FOUND.
;	   NO LINE IN PROGRAM GREATER THAN ONE SOUGHT.
;	   [B,C] POINTS TO TWO ZERO BYTES AT END OF PROGRAM.
;	   [H,L]=[B,C]
;
;	2) ZERO, CARRY SET. 
;	   [B,C] POINTS TO THE LINK FIELD IN THE LINE
;	   WHICH IS THE LINE SEARCHED FOR.
;	   [H,L] POINTS TO THE LINK FIELD IN THE NEXT LINE.
;
;	3) NON-ZERO, CARRY NOT SET.
;	   LINE NOT FOUND, [B,C]  POINTS TO LINE IN PROGRAM
;	   GREATER THAN ONE SEARCHED FOR.
;	   [H,L] POINTS TO THE LINK FIELD IN THE NEXT LINE.
;
; Routine at 3832
;
; Used by the routines at PROMPT, __GOTO, __DELETE, __RENUM, _LINE2PTR,
; __CHAIN, CAYSTR, __EDIT and SYNCHR.
SRCHLN:
  LD HL,(TXTTAB)        ; Start of program text

; Routine at 3835
;
; Used by the routine at __GOTO.
SRCHLP:
  LD B,H                ; BC = Address to look at     IF EXITING BECAUSE OF END OF PROGRAM,
  LD C,L                ;                             SET [B,C] TO POINT TO DOUBLE ZEROES.
  LD A,(HL)             ; Get address of next line
  INC HL                
  OR (HL)               ; End of program found?
  DEC HL                ;GO BACK
  RET Z                 ; Yes - Line not found
  INC HL                ;SKIP PAST AND GET THE LINE #
  INC HL
  LD A,(HL)             ; Get LSB of line number      INTO [H,L] FOR COMPARISON WITH
  INC HL                ;                             THE LINE # BEING SEARCHED FOR
  LD H,(HL)             ; Get MSB of line number      WHICH IS IN [D,E]
  LD L,A                
  CALL DCOMPR           ; Compare with line in DE         SEE IF IT MATCHES OR IF WE'VE GONE TOO FAR
  LD H,B                ; HL = Start of this line         MAKE [H,L] POINT TO THE START OF THE
  LD L,C                ;                                 LINE BEYOND THIS ONE, BY PICKING
  LD A,(HL)             ; Get LSB of next line address    UP THE LINK THAT [B,C] POINTS AT
  INC HL                
  LD H,(HL)             ; Get MSB of next line address
  LD L,A                ; Next line to HL
  CCF
  RET Z                 ; Lines found - Exit
  CCF                   
  RET NC                ; Line not found,at line after    NO MATCH RETURN (GREATER)
  JR SRCHLP             ; Keep looking


; Routine at 3864
;
; Used by the routine at PROMPT.

; TOKENIZE (CRUNCH)
; ALL "RESERVED" WORDS ARE TRANSLATED INTO SINGLE ONE OR TWO
; (IF TWO, FIRST IS ALWAYS $FF, 377 OCTAL) BYTES WITH THE MSB ON.
; THIS SAVES SPACE AND TIME BY ALLOWING FOR TABLE DISPATCH DURING EXECUTION.
; THEREFORE ALL STATEMENTS APPEAR TOGETHER IN THE RESERVED WORD LIST 
; IN THE SAME ORDER THEY APPEAR IN IN STMDSP.
;
; NUMERIC CONSTANTS ARE ALSO CONVERTED TO THEIR INTERNAL 
; BINARY REPRESENTATION TO IMPROVE EXECUTION SPEED
; LINE NUMBERS ARE ALSO PRECEEDED BY A SPECIAL TOKEN SO THAT
; LINE NUMBERS CAN BE CONVERTED TO POINTERS AT EXECUTION TIME.
;
TOKENIZE:
  XOR A                   ; SAY EXPECTING FLOATING NUMBERS
  LD (DONUM),A            ; SET FLAG ACORDINGLY
  LD (OPRTYP),A           ; ALLOW CRUNCHING
  LD BC,KBFLEN-3          ; GET LENGTH OF KRUNCH BUFFER MINUS THREE BECAUSE OF ZEROS AT END
  LD DE,KBUF              ; SETUP DESTINATION POINTER

; Routine at 3877
;
; Used by the routines at CRNCLP, CRNCH_MORE, TSTNUM and NOTRES.
NXTCHR:                   ; (=KLOOP)
  LD A,(HL)               ; Get byte            GET CHARACTER FROM BUF
  OR A                    ; End of line ?
  JR NZ,CRNCLP            ; No, continue

; Routine at 3882
;
; Used by the routine at CRNCLP.
CRDONE:                   ; Yes - Terminate buffer
  LD HL,KBFLEN+2		  ;GET OFFSET
  LD A,L                  ;GET COUNT TO SUBTRACT FROM
  SUB C                   ;SUBTRACT
  LD C,A
  LD A,H
  SBC A,B
  LD B,A
  LD HL,KBUF-1            ;GET POINTER TO CHAR BEFORE KBUF, AS "GONE" DOES A CHRGET
  ; Mark end of buffer
  XOR A                   ;GET A ZERO
  LD (DE),A               ;NEED THREE 0'S ON THE END
  INC DE                  ;ONE FOR END-OF-LINE
  LD (DE),A               ;AND 2 FOR A ZERO LINK
  INC DE                  ;SINCE IF THIS IS A DIRECT STATEMENT
  LD (DE),A               ;ITS END MUST LOOK LIKE THE END OF A PROGRAM
  RET                     ;END OF CRUNCHING

; Routine at 3901
;
; Used by the routine at NXTCHR.
CRNCLP:
  CP '"'                  ; Is it a quote?                   QUOTE SIGN? 
  JR Z,CPYLIT             ; Yes - Copy literal string        YES, GO TO SPECIAL STRING HANDLING
  CP ' '                  ; Is it a space?                   SPACE?
  JR Z,STUFFH             ; Yes - Copy direct                JUST STUFF AWAY
  LD A,(OPRTYP)           ; a.k.a. DORES, indicates whether stored word can be
  OR A                    ; crunched, etc..                  END OF LINE?
  LD A,(HL)
  JR Z,CRNCLP_2           ;                                  YES, DONE CRUNCHING

; This entry point is used by the routine at TSTNUM.
STUFFH:
  INC HL                  ; ENTRY TO BUMP [H,L]
  PUSH AF                 ; SAVE CHAR AS KRNSAV CLOBBERS
  CALL KRNSAV             ; SAVE CHAR IN KRUNCH BUFFER   (Insert during tokenization)
  POP AF                  ; RESTORE CHAR
  SUB ':'                 ; ":", End of statement?
  JR Z,SETLIT             ; IF SO ALLOW CRUNCHING AGAIN
  CP TK_DATA-':'          ; SEE IF IT IS A DATA TOKEN
  JR NZ,TSTREM            ; No - see if REM
  LD A,$01                ;SET LINE NUMBER ALLOWED FLAG - KLUDGE AS HAS TO BE NON-ZERO.
SETLIT:
  LD (OPRTYP),A           ;SETUP FLAG
  LD (DONUM),A            ;SET NUMBER ALLOWED FLAG
TSTREM:
  SUB TK_REM-':'
  JR NZ,NXTCHR            ;KEEP LOOPING
  PUSH AF                 ;SAVE TERMINATOR ON STACK
STR1_LP:
  LD A,(HL)               ;GET A CHAR
  OR A                    ;SET CONDITION CODES
  EX (SP),HL              ;GET SAVED TERMINATOR OFF STACK, SAVE [H,L]
  LD A,H                  ;GET TERMINATOR INTO [A] WITHOUT AFFECTING PSW
  POP HL                  ;RESTORE [H,L]
  JR Z,CRDONE             ;IF END OF LINE THEN DONE
  CP (HL)                 ;COMPARE CHAR WITH THIS TERMINATOR
  JR Z,STUFFH             ;IF YES, DONE WITH STRING

CPYLIT:
  PUSH AF                 ;SAVE TERMINATOR
  LD A,(HL)               ;GET BACK LINE CHAR
; This entry point is used by the routine at TOKEN_BUILT.
CRNCLP_1:
  INC HL                  ;INCREMENT TEXT POINTER
  CALL KRNSAV             ;SAVE CHAR IN KRUNCH BUFFER
  JR STR1_LP              ;KEEP LOOPING

CRNCLP_2:
  CP '?'                  ;A QMARK?  (Is it "?" short for PRINT)
  LD A,TK_PRINT           ; "PRINT" token
  PUSH DE                 ;SAVE STORE POINTER
  PUSH BC                 ;SAVE CHAR COUNT
  JP Z,MOVDIR             ;THEN USE A "PRINT" TOKEN
					;***5.11 DONT ALLOW FOLLOWING LINE #***
  LD DE,OPR_TOKENS        ;ASSUME WE'LL SEARCH SPECIAL CHAR TABLE
  CALL MAKUPL             ;TRANSLATE THIS CHAR TO UPPER CASE
  CALL ISLETTER_A         ;LETTER?
  JP C,TSTNUM             ;NOT A LETTER, TEST FOR NUMBER
  PUSH HL                 ;SAVE TEXT POINTER
  LD DE,FNC_GO            ;PLACE TO RETURN IF NOT FUNNY GO
  CALL TK_TXT_COMPARE
  JR NZ,CRNCH_MORE
  CALL CHRGTB
  LD DE,FNC_TO
  CALL TK_TXT_COMPARE
  LD A,TK_GOTO
  JR Z,CRNCLP_3
  LD DE,FNC_SUB
  CALL TK_TXT_COMPARE
  JR NZ,CRNCH_MORE
  LD A,TK_GOSUB
CRNCLP_3:
  POP BC
  JP MOVDIR

TK_TXT_COMPARE:
  LD A,(DE)
  OR A
  RET Z
  LD C,A
  CALL MAKUPL
  CP C
  RET NZ
  INC HL
  INC DE
  JR TK_TXT_COMPARE

FNC_GO:
  DEFM "GO "
  DEFB $00
FNC_TO:
  DEFM "TO"
  DEFB $00
FNC_SUB:
  DEFM "UB"
  DEFB $00

; Routine at 4054
;
; Used by the routine at CRNCLP.
CRNCH_MORE:
  POP HL
  CALL MAKUPL             ;GET BACK THE CHARACTER
  PUSH HL                 ;RESAVE THE TEXT POINTER

  LD HL,WORD_PTR          ;GET POINTER TO ALPHA DISPATCH TABLE

  SUB 'A'                 ;SUBTRACT ALPHA OFFSET
  ADD A,A                 ;MULTIPLY BY TWO
  LD C,A                  ;SAVE OFFSET IN [C] FOR DAD.
  LD B,$00                ;MAKE HIGH PART OF OFFSET ZERO
  ADD HL,BC               ;ADD TO TABLE ADDRESS
  LD E,(HL)               ;SET UP POINTER IN [D,E]
  INC HL
  LD D,(HL)               ;GET HIGH PART OF ADDRESS
  POP HL                  ;GET BACK SOURCE POINTER
  INC HL                  ;POINT TO CHAR AFTER FIRST ALPHA  (Get next reserved word)

TRYAGA:
  PUSH HL                 ;SAVE TXTPTR TO START OF SEARCH AREA
LOPPSI:
  CALL MAKUPL             ;TRANSLATE THIS CHAR TO UPPER CASE
  LD C,A                  ;SAVE CHAR IN [C]
  LD A,(DE)               ;GET BYTE FROM RESERVED WORD LIST   (Get byte from table)
  AND $7F                 ;GET RID OF HIGH BIT
  JP Z,NOTRES             ;IF=0 THEN END OF THIS CHARS RESLT  (JP if end of list)
  INC HL                  ;BUMP SOURCE POINTER
  CP C                    ;COMPARE TO CHAR FROM SOURCE LINE     (Same character as in buffer?)
  JR NZ,LOPSKP            ;IF NO MATCH, SEARCH FOR NEXT RESWRD  (No - get next word)
  LD A,(DE)               ;GET RESWRD BYTE AGAIN
  INC DE                  ;BUMP RESLST POINTER
  OR A                    ;SET CC'S
  JP P,LOPPSI             ;SEE IF REST OF CHARS MATCH
  LD A,C                  ;GET LAST CHAR OF RESWRD
  CP '('                  ;IF TAB( OR SPC(, SPACE NEED NOT FOLLOW
  JR Z,ISRESW             ;IS A RESWORD
  LD A,(DE)               ;LOOK AFTER CHAR
  CP TK_FN                ;FUNCTION?
  JR Z,ISRESW             ;THEN NO SPACE NEED AFTERWARD
  CP TK_USR               ;OR USR DEFINITION?
  JR Z,ISRESW
IF HAVE_GFX
  CP TK_POINT
  JR Z,ISRESW        ; <-- there must be a better way
ENDIF
IF ZXPLUS3
  CP TK_CSRLIN
  JR Z,ISRESW        ; <-- there must be a better way
ENDIF

  CALL MAKUPL             ;GET NEXT CHAR IN LINE (MC 6/22/80)
  CP '.'                  ;IS IT A DOT
  JR Z,ISVARS             ;YES
  CALL TSTANM             ;IS IT A LETTER IMMEDIATELY FOLLOWING RESWRD
ISVARS:
  LD A,$00                ;SET DONUM TO -1
  JP NC,NOTRES            ;IF ALPHA, CANT BE RESERVED WORD
ISRESW:
  POP AF                  ;GET RID OF SAVED [H,L]
  LD A,(DE)               ;GET RESWRD VALUE
  OR A                    ;SET CC'S
  JP M,NOTFNT             ;IF MINUS, WASN'T FUNCTION TOKEN
  POP BC
  POP DE
  OR $80                  ;MAKE HIGH ORDER BIT ONE
  PUSH AF                 ;SAVE FN CHAR
  LD A,$FF                ;GET BYTE WHICH PRECEEDS FNS
  CALL KRNSAV             ;SAVE IN KRUNCH BUFFER
  XOR A                   ;MAKE A ZERO
  LD (DONUM),A            ;TO RESET DONUM (FLOATINGS ALLOWED)
  POP AF                  ;GET FUNCTION TOKEN
  CALL KRNSAV             ;STORE IT
  JP NXTCHR               ;KEEP KRUNCHING

LOPSKP:
  POP HL                  ;RESTORE UNDEFILED TEXT POINTER
LOPSK2:
  LD A,(DE)               ;GET A BYTE FROM RESWRD LIST
  INC DE                  ;BUMP RESLST POINTER
  OR A                    ;SET CC'S
  JP P,LOPSK2             ;NOT END OF RESWRD, KEEP SKIPPING
  INC DE                  ;POINT AFTER TOKEN
  JR TRYAGA               ;TRY ANOTHER RESWRD

NOTFNT:
  DEC HL

; Token found, direct token code assignment
;
; Used by the routine at CRNCLP.
MOVDIR:
  PUSH AF
  LD DE,LNUM_TOKENS		; List of commands (tokens) requiring program line numbers
  LD C,A
;CRUNCH LINE #'S AFTER any of the token codes found in "LNUM_TOKENS"
MOVDIR_0:
  LD A,(DE)
  OR A
  JR Z,TOKEN_BUILT
  INC DE
  CP C
  JR NZ,MOVDIR_0
  JR TOKENIZE_LNUM

; Data block at 4186
; List of commands (tokens) requiring program line numbers
LNUM_TOKENS:
  DEFB TK_RESTORE
  DEFB TK_AUTO
  DEFB TK_RENUM
  DEFB TK_DELETE
  DEFB TK_EDIT
  DEFB TK_RESUME
  DEFB TK_ERL
  DEFB TK_ELSE
  DEFB TK_RUN
  DEFB TK_LIST
  DEFB TK_LLIST
  DEFB TK_GOTO
  DEFB TK_THEN
  DEFB TK_GOSUB
  DEFB $00

; Routine at 4201
;
; Used by the routine at MOVDIR.
TOKEN_BUILT:
  XOR A
  DEFB $C2                ; JP NZ,NN (always false), masks the next 2 bytes
; This entry point is used by the routine at MOVDIR.
TOKENIZE_LNUM:
  LD A,$01                ; 04203: TOKENIZE_LNUM
; This entry point is used by the routine at NOTRES.
NOTRS6:
  LD (DONUM),A              ;SAVE IN FLAG
  POP AF                    ;RESTORE CHARACTER TO SAVE IN KRUNCH BUFFER
  POP BC                    ;GET BACK THE CHARACTER COUNT
  POP DE                    ;GET STUFF POINTER BACK
  CP TK_ELSE                ;HAVE TO PUT A HIDDEN COLON IN FRONT OF "ELSE"S
  PUSH AF                   ;SAVE CURRENT CHAR ($ELSE)
  CALL Z,TOKENIZE_COLON     ;SAVE ":" IN CRUNCH BUFFER
  POP AF                    ;GET BACK TOKEN
  CP TK_WHILE               ; <<--  new feature in v5.22
  JR NZ,TOKEN_BUILT_1
  CALL KRNSAV				; save 'TK_WHILE'
  LD A,TK_PLUS              ; replace the currently examined byte with '+' 
TOKEN_BUILT_1:
  CP TK_APOSTROPHE			;SINGLE QUOTE TOKEN?   "'" = comment (=REM)
  JP NZ,NTSNGT
  PUSH AF
  CALL TOKENIZE_COLON       ;SAVE ":" IN CRUNCH BUFFER
  LD A,TK_REM               ;STORE ":$REM" IN FRONT FOR EXECUTION
  CALL KRNSAV               ;SAVE IT
  POP AF                    ;GET SNGQTK (TK_APOSTROPHE) BACK
  PUSH AF                   ;SAVE BACK AS TERMINATOR FOR STRNG
  JP CRNCLP_1               ;STUFF THE REST OF THE LINE WITHOUT CRUNCHING

; Routine at 4247
;
; Used by the routine at CRNCLP.
TSTNUM:
  LD A,(HL)                 ;GET CHAR
  CP '.'                    ;TEST FOR START OF FLOATING #
  JR Z,NUMTRY               ;TRY INPUTTING IT AS CONSTANT
  CP '9'+1                  ;IS IT A DIGIT?
  JR NC,SRCSPC              ;NO, TRY OTHER THINGS
  CP '0'                    ;TRY LOWER END
  JR C,SRCSPC               ;NO TRY OTHER POSSIBILITIES
NUMTRY:
  LD A,(DONUM)              ;TEST FOR NUMBERS ALLOWED
  OR A                      ;SET CC'S
  LD A,(HL)                 ;GET CHAR IF GOING TO STUFFH
  POP BC                    ;RESTORE CHAR COUNT
  POP DE                    ;RESTORE DEP. POINTER
  JP M,STUFFH               ;NO, JUST STUFF IT (!)
  JR Z,FLTGET               ;IF DONUM=0 THEN FLOATING #'S ALLOWED
  CP '.'                    ;IS IT DOT?
  JP Z,STUFFH               ;YES, STUFF IT FOR HEAVENS SAKE! (EDIT .)
  LD A,LINCON               ;GET LINE # TOKEN
  CALL KRNSAV               ;SAVE IT
  PUSH DE                   ;SAVE DEPOSIT POINTER
  CALL ATOH                 ;GET THE LINE #.
  CALL BAKSP                ;BACK UP POINTER TO AFTER LAST DIGIT
SAVINT:
  EX (SP),HL                ;EXCHANGE CURRENT [H,L] WITH SAVED [D,E]
  EX DE,HL                  ;GET SAVED [D,E] IN [D,E]
TSTNUM_2:
  LD A,L                    ;GET LOW BYTE OF VALUE RETURNED BY LINGET
  CALL KRNSAV               ;SAVE THE LOW BYTE OF LINE #
  LD A,H                    ;GET HIGH BYTE
POPSTF:
  POP HL                    ;RESTORE [H,L]
  CALL KRNSAV               ;SAVE IT TOO
  JP NXTCHR                 ;EAT SOME MORE

FLTGET:
  PUSH DE                   ;SAVE DEPOSIT POINTER
  PUSH BC                   ;SAVE CHAR COUNT
  LD A,(HL)                 ;FIN ASSUMES CHAR IN [A]
  CALL FIN                  ;READ THE #
  CALL BAKSP                ;BACK UP POINTER TO AFTER LAST DIGIT
  POP BC                    ;RESTORE CHAR COUNT
  POP DE                    ;RESTORE DEPOSIT POINTER
  PUSH HL                   ;SAVE TEXT POINTER
  LD A,(VALTYP)             ;GET VALUE TYPE
  CP $02                    ;INTEGER?
  JR NZ,NTINTG              ;NO
  LD HL,(FACCU)             ;GET IT
  LD A,H                    ;GET HIGH PART
  OR A                      ;IS IT ZERO?
  LD A,$02                  ;RESTORE INT VALTYP
  JR NZ,NTINTG              ;THEN ISNT SINGLE BYTE INT
  LD A,L                    ;GET LOW BYTE
  LD H,L                    ;GET LOW BYTE IN HIGH BYTE TO STORE
  LD L,$0F                  ;GET CONSTANT FOR 1 BYTE INTS
  CP $0A                    ;IS IT TOO BIG FOR A SINGLE BYTE CONSTANT?
  JR NC,TSTNUM_2            ;TOO BIG, USE SINGLE BYTE INT
  ADD A,ONECON              ;MAKE SINGLE BYTE CONSTANT
  JR POPSTF                 ;POP H & STUFF AWAY CHAR
  
NTINTG:
  PUSH AF                   ;SAVE FOR LATER
  RRCA                      ;DIVIDE BY TWO
  ADD A,$1B                 ;ADD OFFSET TO GET TOKEN
  CALL KRNSAV               ;SAVE THE TOKEN
  LD HL,FACCU               ;GET START POINTER
  CALL GETYPR               ;SET CC'S ON VALTYPE
  JR C,NTDBL                ;IF NOT DOUBLE, START MOVING AT FACLO
  LD HL,FACLOW              ;DOUBLE, START MOVING AT DFACLO
NTDBL:
  POP AF                    ;RESTORE COUNT OF BYTES TO MOVE
TSTNUM_7:
  PUSH AF                   ;SAVE BYTE MOVE COUNT
  LD A,(HL)                 ;GET A BYTE
  CALL KRNSAV               ;SAVE IT IN KRUNCH BUFFER
  POP AF                    ;GET BACK COUNT
  INC HL                    ;BUMP POINTER INTO FAC
  DEC A                     ;MOVE IT DOWN
  JR NZ,TSTNUM_7            ;KEEP MOVING IT
  POP HL                    ;GET BACK SAVED TEXT POINTER
  JP NXTCHR                 ;KEEP LOOPING

SRCSPC:
  LD DE,OPR_TOKENS-1      ; GET POINTER TO SPECIAL CHARACTER TABLE
SRCSP2:
  INC DE                  ; MOVE POINTER AHEAD
  LD A,(DE)               ; GET BYTE FROM TABLE
  AND $7F                 ; MASK OFF HIGH BIT
  JR Z,NOTRS5             ; IF END OF TABLE, STUFF AWAY, DONT CHANGE DONUM
  INC DE                  ; BUMP POINTER
  CP (HL)                 ; IS THIS SPECIAL CHAR SAME AS CURRENT TEXT CHAR?
  LD A,(DE)               ; GET NEXT RESWRD
  JR NZ,SRCSP2            ; IF NO MATCH, KEEP LOOKING
  JR NOTRS1               ; FOUND, SAVE AWAY AND SET DONUM=1.

; This entry point is used by the routine at TOKEN_BUILT.
NTSNGT:
  CP '&'                  ; OCTAL CONSTANT?
  JP NZ,STUFFH            ; JUST STUFF IT AWAY
  PUSH HL                 ; SAVE TEXT POINTER
  CALL CHRGTB             ; GET NEXT CHAR
  POP HL                  ; RESTORE TEXT POINTER
  CALL UCASE              ; MAKE CHAR UPPER CASE
  CP 'H'                  ; '&H' HEX CONSTANT?
  LD A,OCTCON             ; Octal Number prefix
  JR NZ,WUZOCT
  LD A,$0C				  ; Hex Number prefix
WUZOCT:
  CALL KRNSAV		; Insert during tokenization
  PUSH DE
  PUSH BC
  CALL OCTCNS
  POP BC
  JP SAVINT

; This entry point is used by the routine at TOKEN_BUILT.
TOKENIZE_COLON:
  LD A,':'                ; GET COLON IN KRUNCH BUFFER
; This entry point is used by the routines at CRNCLP, CRNCH_MORE, TOKEN_BUILT
; and NOTRES.

; (KRNSAV)
KRNSAV:
  LD (DE),A               ; SAVE BYTE IN KRUNCH BUFFER
  INC DE                  ; BUMP POINTER
  DEC BC                  ; DECREMENT COUNT OF BYTES LEFT IN BUFFER
  LD A,C                  ; TEST IF IT WENT TO ZERO
  OR B                    ; BY SEEING IF DOUBLE BYTE ZERO.
  RET NZ                  ; ALL DONE IF STILL SPACE LEFT
; This entry point is used by the routine at PUTBUF.

BUFOV_ERR:
  LD E,$17                ; 'Line Buffer Overflow' error entry
  JP ERROR

; Routine at 4452
;
; Used by the routine at CRNCH_MORE.
NOTRES:
  POP HL                  ;GET BACK POINTER TO ORIGINAL CHAR
  DEC HL                  ;NOW POINT TO FIRST ALPHA CHAR
  DEC A                   ;SET A TO MINUS ONE
  LD (DONUM),A            ;FLAG WERE IN VARIABLE NAME
  POP BC                  ;GET BACK CHAR COUNT
  POP DE                  ;GET BACK DEPOSIT POINTER
  CALL MAKUPL             ;GET CHAR FROM LINE, MAKE UPPER CASE

KRNVAR:
  CALL KRNSAV             ;SAVE CHAR
  INC HL                  ;INCRMENT SOURCE POINTER
  CALL MAKUPL             ;MAKE UPPER CASE (?)
  CALL ISLETTER_A         ;IS IT A LETTER?
  JR NC,KRNVAR            ;YES, EAT
  CP '9'+1                ;DIGIT?
  JR NC,JKLOOP            ;NO, TOO LARGE
  CP '0'                  
  JR NC,KRNVAR            ;YES, EAT
  CP '.'                  ;IS IT DOT
  JR Z,KRNVAR             ;YES, DOTS OK IN VAR NAMES
JKLOOP:
  JP NXTCHR               ;(=KLOOP) DONE LOOKING AT VARIABLE NAME

; This entry point is used by the routine at TSTNUM.
NOTRS5:
  LD A,(HL)               ;GET CHAR FROM LINE
  CP ' '                  ;SPACE OR HIGHER ?
  JR NC,NOTRS1            ;YES = SAVE IT
  CP $09                  ;TAB ?
  JR Z,NOTRS1             ;YES = THAT'S OK
  CP $0A                  ;ALSO ALLOW...
  JR Z,NOTRS1             ;...LINE FEEDS
  LD A,' '                ;FORCE REST TO SPACES
; This entry point is used by the routine at TSTNUM.
NOTRS1:
  PUSH AF                 ;SAVE THIS CHAR
  LD A,(DONUM)            ;GET NUMBER OK FLAG
  INC A                   ;SEE IF IN A VARIABLE NAME.
  JR Z,NOTRES_4           ;IF SO & SPECIAL CHAR SEEN, RESET DONUM
  DEC A                   ;OTHERWISE LEAVE DONUM UNCHANGED.
NOTRES_4:
  JP NOTRS6


; ROUTINE TO BACK UP POINTER AFTER # EATEN
; Routine at 4524
;
; Used by the routines at PROMPT and TSTNUM.
BAKSP:
  DEC HL                  ;POINT TO PREVIOUS CHAR
  LD A,(HL)               ;GET THE CHAR
  CP ' '                  ;A SPACE?
  JR Z,BAKSP              ;YES, KEEP BACKING UP
  CP $09                  ;TAB?
  JR Z,BAKSP              ;YES, BACK UP
  CP $0A                  ;LF?
  JR Z,BAKSP
  INC HL                  ;POINT TO CHAR AFTER LAST NON-SPACE
  RET                     ;ALL DONE.


; 'FOR' BASIC command
;
; A "FOR" ENTRY ON THE STACK HAS THE FOLLOWING FORMAT:
;
; LOW ADDRESS
;	TOKEN ($FOR IN HIGH BYTE)  1 BYTE
;	A POINTER TO THE LOOP VARIABLE  2 BYTES
;	A BYTE REFLECTING THE SIGN OF THE INCREMENT 1 BYTE
;	THE STEP 4 BYTES
;	THE UPPER VALUE 4 BYTES
;	THE LINE # OF THE "FOR" STATEMENT 2 BYTES
;	A TEXT POINTER INTO THE "FOR" STATEMENT 2 BYTES
;
__FOR:
  LD A,$64                ; Flag "FOR" assignment
  LD (SUBFLG),A           ; Save "FOR" flag             DONT RECOGNIZE SUBSCRIPTED VARIABLES
  CALL GETVAR             ;                             GET POINTER TO LOOP VARIABLE
  CALL SYNCHR
  DEFB TK_EQUAL           ; Token code for '='          SKIP OVER ASSIGNMENT "="
  PUSH DE                 ;SAVE THE VARIABLE POINTER
  LD (TEMP),DE            ;SAVE THE LOOP VARIABLE IN TEMP FOR USE LATER ON
  LD A,(VALTYP)           ; Get data type
  PUSH AF                 ;REMEMBER THE LOOP VARIABLE TYPE
  CALL EVAL               ;GET THE START VALUE
  POP AF                  ;REGET THE LOOP TYPE
  PUSH HL                 ;SAVE THE TEXT POINTER
  CALL CHKTYP             ;FORCE CONVERSION TO LOOP TYPE
  LD HL,FVALSV            ;PLACE TO SAVE THE VALUE
  CALL FPTHL              ;STORE FOR USE IN "NEXT"
  POP HL                  ;GET BACK THE TEXT POINTER
  POP DE                  ;GET BACK THE VARIABLE POINTER
  POP BC                  ;GET RID OF THE NEWSTT RETURN
  PUSH HL                 ;SAVE THE TEXT POINTER
  CALL __DATA             ; Get next statement address           SET [H,L]=END OF STATEMENT
  LD (ENDFOR),HL          ; Next address of FOR st.              SAVE FOR COMPARISON
  LD HL,$0002             ; Offset for "FOR" block               SET UP POINTER INTO STACK
  ADD HL,SP               ; Point to it
FORSLP:
  CALL LOKFOR             ; Look for existing "FOR" block        MUST HAVE VARIABLE POINTER IN [D,E]
  JR NZ,FORFND            ; IF NO MATCHING ENTRY, DON'T ELIMINATE ANYTHING
  ADD HL,BC               ; IN THE CASE OF "FOR" WE ELIMINATE THE MATCHING ENTRY AS WELL AS EVERYTHING AFTER IT
  PUSH DE                 ; SAVE THE TEXT POINTER
  DEC HL                  ; SEE IF END TEXT POINTER OF MATCHING ENTRY
  LD D,(HL)               ; MATCHES THE FOR WE ARE HANDLING
  DEC HL                  ; PICK UP THE END OF THE "FOR" TEXT POINTER
  LD E,(HL)               ; FOR THE ENTRY ON THE STACK
  INC HL                  ; WITHOUT CHANGING [H,L]
  INC HL
  PUSH HL                 ; Save block address                   SAVE THE STACK POINTER FOR THE COMPARISON
  LD HL,(ENDFOR)          ; Get address of loop statement        GET ENDING TEXT POINTER FOR THIS "FOR"
  CALL DCOMPR             ; Compare the FOR loops                SEE IF THEY MATCH
  POP HL                  ; Restore block address                GET BACK THE STACK POINTER
  POP DE                  ;                                      GET BACK THE TEXT POINTER
  JR NZ,FORSLP            ; Different FORs - Find another        KEEP SEARCHING IF NO MATCH
  POP DE                  ; Restore code string address          GET BACK THE TEXT POINTER
  LD SP,HL                ; Remove all nested loops              DO THE ELIMINATION
  LD (SAVSTK),HL          ; UPDATE SAVED STACK SINCE A MATCHING ENTRY WAS FOUND

  DEFB $0E                ; LD C,N to mask the next byte

; Routine at 4625
;
; Used by the routine at __FOR.
FORFND:
  POP DE                  ; Code string address to DE
  EX DE,HL                ; TEXT POINTER to HL
  LD C,$08                ; MAKE SURE 16 BYTES ARE AVAILABLE OFF OF THE STACK
  CALL CHKSTK             ; Check for 8 levels of stack
  PUSH HL                 ; REALLY SAVE THE TEXT POINTER
  LD HL,(ENDFOR)          ; Get first statement of loop          PICK UP POINTER AT END OF "FOR" 
                          ;                                      JUST BEYOND THE TERMINATOR
  EX (SP),HL              ; Save and restore code string         PUT [H,L] POINTER TO TERMINATOR ON THE STACK
                          ;                                      AND RESTORE [H,L] AS TEXT POINTER AT VARIABLE NAME
  PUSH HL                 ; Re-save code string address          PUSH THE TEXT POINTER ONTO THE STACK
  LD HL,(CURLIN)          ; Get current line number              [H,L] GET THE CURRENT LINE #
  EX (SP),HL              ; Save and restore code string         NOW THE CURRENT LINE # IS ON THE STACK, HL IS THE TEXT POINTER
  CALL SYNCHR             ; Make sure "TO" is next
  DEFB TK_TO              ; "TO" token                           "TO" IS NECESSARY
  CALL GETYPR             ; Get the number type (FAC)            SEE WHAT TYPE THIS VALUE HAS
  JP Z,TM_ERR             ; If string type, "Type mismatch"      GIVE STRINGS A "TYPE MISMATCH"
  JP NC,TM_ERR            ;                                      AS WELL AS DOUBLE-PRECISION
  PUSH AF                 ; save type                            SAVE THE INTEGER/FLOATING FLAG
  CALL EVAL               ;                                      EVALUATE THE TARGET VALUE FORMULA
  POP AF                  ; Restore type                         POP OFF THE FLAG
  PUSH HL                 ; SAVE THE TEXT POINTER
  JP P,FORFND_SNG         ; POSITIVE MEANS SINGLE PRECISION "FOR"-LOOP
  CALL __CINT             ; COERCE THE FINAL VALUE
  EX (SP),HL              ; SAVE IT ON THE STACK AND REGET THE TEXT POINTER
  LD DE,$0001             ; Default value for STEP               DEFAULT THE STEP TO BE 1
  LD A,(HL)               ; Get next byte in code string         SEE WHAT CHARACTER IS NEXT
  CP TK_STEP              ; See if "STEP" is stated              IS THERE A "STEP" CLAUSE?
  CALL Z,FPSINT           ; If so, get updated value for 'STEP'  IF SO, READ THE STEP INTO [D,E]
  PUSH DE                 ;                                      PUT THE STEP ONTO THE STACK
  PUSH HL                 ; Save code string address             SAVE THE TEXT POINTER
  EX DE,HL                ;                                      STEP INTO [H,L]
  CALL ISIGN              ; Test sign for 'STEP'                 THE SIGN OF THE STEP INTO [A]
  JR FORFND_0             ;                                      FINISH UP THE ENTRY BY PUTTING THE SIGN OF
                          ;                                      THE STEP AND THE DUMMY ENTRIES ON THE STACK

FORFND_SNG:
  CALL __CSNG             ; Get value for 'TO'
  CALL BCDEFP             ; Move "TO" value to BCDE
  POP HL                  ; Restore code string address
  PUSH BC                 ; Save "TO" value in block
  PUSH DE                 ; SAVE THE SIGN OF THE INCREMENT
  LD BC,$8100             ; BCDE = 1.0 (default STEP)
  LD D,C                  ; C=0
  LD E,D                  ; D=0
  LD A,(HL)               ; Get next byte in code string         GET TERMINATING CHARACTER
  CP TK_STEP              ; See if "STEP" is stated
  LD A,$01                ; Sign of step = 1
  JR NZ,SAVSTP            ; No STEP given - Default to 1
  CALL EVAL_0             ; Jump over "STEP" token and point to step value
  PUSH HL                 ; Save code string address
  CALL __CSNG             ; Get value for 'STEP'
  CALL BCDEFP             ; Move STEP to BCDE
  CALL SIGN               ; Test sign for 'STEP' in FPREG
FORFND_0:
  POP HL                  ; Restore code string address

; Save the STEP value in block
;
; Used by the routine at FORFND.
SAVSTP:
  PUSH BC                 ; Save the STEP value in block         PUT VALUE ON BACKWARDS
  PUSH DE                 ;OPPOSITE OF PUSHR
  OR A
  JR NZ,SAVSTP_0
  LD A,$02
SAVSTP_0:
  LD C,A                  ;[C]=SIGN OF STEP
  CALL GETYPR             ;MUST PUT ON INTEGER/SINGLE-PRECISION FLAG - MINUS IS SET FOR INTEGER CASE
  LD B,A                  ;HIGH BYTE = INTEGER/SINGLE PRECISION FLAG
  PUSH BC                 ;SAVE FLAG AND SIGN OF STEP BOTH
  DEC HL                  ;MAKE SURE THE "FOR" ENDED PROPERLY
  CALL CHRGTB
  JP NZ,SN_ERR
  CALL NXTSCN             ;SCAN UNTIL THE MATCHING "NEXT" IS FOUND
  CALL CHRGTB             ;FETCH FIRST CHARACTER OF "NEXT"
  PUSH HL                 ;MAKE THE NEXT TXTPTR PART OF THE ENTRY
  PUSH HL
  LD HL,(NXTLIN)                                                ;GET THE LINE NUMBER OF NEXT
  LD (CURLIN),HL                                                ;MAKE IT THE CURRENT LINE
  LD HL,(TEMP)            ; Get address of index variable        GET THE POINTER TO THE VARIABLE BACK
  EX (SP),HL              ; Save and restore code string         PUT THE PTR ON SP AND RESTORE THE TEXT POINTER
  LD B,TK_FOR             ; "FOR" block marker                   FINISH UP "FOR"
  PUSH BC                 ; Save it
  INC SP                  ; Don't save C                         THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE
  PUSH AF                 ;SAVE THE CHARACTER
  PUSH AF                 ;MAKE A STACK ENTRY TO SUBSTITUTE FOR "NEWSTT"
  JP __NEXT_0             ;GO EXECUTE "NEXT" WITH NXTFLG ZERO

; "FOR" block marker
;
; Used by the routine at __NEXT.
; --- Put "FOR" block marker ---
PUTFID:
  LD B,TK_FOR             ; "FOR" block marker                   PUT A 'FOR' TOKEN ONTO THE STACK
  PUSH BC                 ; Save it                          
  INC SP                  ; Don't save C                         THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE
;	JMP	NEWSTT		;ALL DONE

;
; BASIC program execution driver (a.k.a. RUNCNT).  HL points to code.
;
; BACK HERE FOR NEW STATEMENT. CHARACTER POINTED TO BY [H,L]
; ":" OR END-OF-LINE. THE ADDRESS OF THIS LOCATION IS
; LEFT ON THE STACK WHEN A STATEMENT IS EXECUTED SO
; IT CAN MERELY DO A RETURN WHEN IT IS DONE.
;
; Used by the routines at __LOAD, __WEND, __CALL, CAYSTR and KILFOR.
NEWSTT:
  PUSH HL

  DEFB $CD                ; CALL nn (Test break)

; Data block at 4776
SMC_ISCNTC:
  DEFW $0000              ; CSTS GET CONSOLE STATUS

; Routine at 4778
NEWSTT_0:
  POP HL                                                 ;RESTORE ALL REGISTERS
  OR A                    ; Break key hit?               ;SET CC'S - 0 FALSE - NO CHAR TYPED
  CALL NZ,STALL           ; Yes - Pause for a key        ;SEE IF ITS CONTROL-C. IF SO, CHECK FOR CONTRL-C
  LD (SAVTXT),HL          ; Save code address for break , USED BY CONTINUE AND INPUT AND CLEAR AND PRINT USING
  EX DE,HL                ;SAVE TEXT POINTER
  LD HL,$0000             ;SAVE STACK POINTER
  ADD HL,SP               ;COPY TO [H,L]
  LD (SAVSTK),HL          ;SAVE IT TO REMEMBER HOW TO RESTART THIS STATEMENT
  EX DE,HL                ;GET CURRENT TEXT POINTER BACK IN [H,L] TO SAVE BYTES & SPEED
  LD A,(HL)               ;GET CURRENT CHARACTER WHICH TERMINATED THE LAST STATEMENT
  CP ':'                  ; Multi statement line?
  JR Z,EXEC               ; Yes - Execute it
  OR A                    ; End of line?
  JP NZ,SN_ERR            ; No - Syntax error           ;MUST BE A ZERO
  INC HL                  ; Point to address of next line

; This entry point is used by the routine at ERRMOR.
GONE4:                    ;CHECK POINTER TO SEE IF IT IS ZERO, IF SO WE ARE AT THE END OF THE PROGRAM
  LD A,(HL)               ; Get LSB of line pointer
  INC HL
  OR (HL)                 ; Is it zero (End of prog)?
  JP Z,PRG_END            ; Yes - Terminate execution        ;FIX SYNTAX ERROR IN UNENDED ERROR ROUTINE
  INC HL                  ; Point to line number
  LD E,(HL)               ; Get LSB of line number
  INC HL
  LD D,(HL)               ; Get MSB of line number           ;GET LINE # IN [D,E]
  EX DE,HL                ; Line number to HL                ;[H,L]=LINE #
  LD (CURLIN),HL          ; Save as current line number      ;SETUP CURLIN WITH THE CURRENT LINE #
  LD A,(TRCFLG)           ; SEE IF TRACE IS ON
  OR A                    ; NON-ZERO MEANS YES
  JR Z,NO_TRACE           ; SKIP THIS PRINTING

  ; If "TRACE" is ON, then print current line number between brackets
  ; [0000] <<<-- print line number being executed
  PUSH DE                 ;SAVE THE TEXT POINTER
  LD A,'['                ;FORMAT THE LINE NUMBER
  CALL OUTDO              ;OUTPUT IT
  CALL LINPRT             ;PRINT THE LINE # IN [H,L]
  LD A,']'                ;SOME MORE FORMATING
  CALL OUTDO
  POP DE                  ;[D,E]=TEXT POINTER

NO_TRACE:
  EX DE,HL                ;RESTORE THE TEXT POINTER, Line number back to DE

; Routine at 4843
;
; Used by the routines at NEWSTT_0 and __MERGE.
EXEC:
  CALL CHRGTB             ; Get key word                            ;GET THE STATEMENT TYPE
  LD DE,NEWSTT            ; Where to RETurn to                      ;PUSH ON A RETURN ADDRESS OF NEWSTT
  PUSH DE                 ; Save for RETurn                         ;STATEMENT
  RET Z                   ; Go to NEWSTT (RUNCNT) if end of STMT    ;IF A TERMINATOR TRY AGAIN


;"IF" COMES HERE, "ON ... GOTO" AND "ON ... GOSUB" COME HERE
; This entry point is used by the routines at __ON and __IF.
ONJMP:
  SUB TK_END              ; $81 = TK_END .. is it a token?
  JP C,__LET              ; No - try to assign it, MUST BE A LET
IF ZXPLUS3
  CP TK_VPOKE+1-TK_END    ; END to VPOKE ?
ELSE
  CP TK_RESET+1-TK_END    ; END to RESET ?
ENDIF
  JP NC,ISMID             ; Not a key word - ?SN Error      ;SEE IF LHS MID$ CASE
  RLCA                    ; Double it                       ;MULTIPLY BY 2
  LD C,A                  ; BC = Offset into table
  LD B,$00
  EX DE,HL                ; Save code string address
  LD HL,FNCTAB            ; Function routine addresses     ;a.k.a. STMDSP: STATEMENT DISPATCH TABLE
  ADD HL,BC               ; Point to right address         ;ADD ON OFFSET 
  LD C,(HL)               ; Get LSB of address             ;PUSH THE ADDRESS TO GO TO ONTO
  INC HL                                                   ;THE STACK
  LD B,(HL)                                                ;PUSHM SAVES BYTES BUT NOT SPEED
  PUSH BC                 ; Get MSB of address
  EX DE,HL                ; Restore code string address    ;RESTORE THE TEXT POINTER

; Pick next char from program
;
; Used by the routines at PROMPT, LINKER, CRNCLP, TSTNUM, SAVSTP, EXEC,
; DEFCON, INTIDX, FC_ERR, ATOH, __REM, __ON, __RESUME, __IF, __PRINT,
; __TAB, NEXITM, __INPUT, NOTQTI, __READ, DOASIG, LTSTND, FDTLP, _EVAL,
; OPRND, __ERR, __ERL, OCTCNS, ISFUN, FN_USR, __DEF, DOFN, __WAIT, __WIDTH,
; FPSINT, FNDNUM, CONINT, LISPRT, SCCPTR, _LINE2PTR, __OPTION, SCNCNT, _ASCTFP,
; PUFOUT, L3338, RNDMON, __OPEN, FILGET, LINE_INPUT, __LOAD, __MERGE,
; RETRTS, FN_INPUT, __WHILE, __CALL, __CHAIN, BCKUCM, CAYSTR, __GET, PUTBUF,
; FN_INKEY, DIMRET, HAVTYP, SBSCPT, NOTSCI, __ERASE, __CLEAR, KILFOR, DTSTR,
; FN_STRING, __VAL, FN_INSTR and INIT.
;
; NEWSTT FALLS INTO CHRGET. THIS FETCHES THE FIRST CHAR AFTER
; THE STATEMENT TOKEN AND THE CHRGET'S "RET" DISPATCHES TO STATEMENT
;
CHRGTB:
  INC HL                  ; Point to next character        ;DUPLICATION OF CHRGET RST FOR SPEED
; This entry point is used by the routine at LINKER.
__CHRCKB:
  LD A,(HL)               ; Get next code string byte      ;SEE CHRGET RST FOR EXPLANATION
  CP '9'+1
  RET NC                  ; NC if > "9"

; This entry point is used by the routine at SYNCHR.
;
; CHRCON IS THE CONTINUATION OF THE CHRGET RST
;
; IN EXTENDED, CHECK FOR INLINE CONSTANT AND IF ONE
; MOVE IT INTO THE FAC & SET VALTYP APPROPRIATELY
;
CHRCON:
  CP ' '                  ;                                MUST SKIP SPACES
  JR Z,CHRGTB             ; Skip over spaces               GET ANOTHER CHARACTER
  JR NC,NOTLFT            ; NC if < "0"                    NOT SPECIAL TRY OTHER POSSIB.
  OR A                    ; Test for zero - Leave carry
  RET Z
  CP OCTCON               ;IS IT INLINE CONSTANT ?
  JR C,NOTCON             ;NO, SHOULD BE TAB OR LF
  CP CONCON               ;ARE WE TRYING TO RE-SCAN A CONSTANT?
  JR NZ,NTRSCC            ;NO.
  LD A,(CONSAV)           ;GET THE SAVED CONSTANT TOKEN
  OR A                    ;SET NON-ZERO, NON CARRY CC'S
  RET                     ;ALL DONE

NTRSCC:
  CP CONCN2               ;GOING TO SCAN PAST EMBEDDED CONSTANT?
  JR Z,NTRSC2             ;NO, TRY OTHER CASES
  PUSH AF                 ;SAVE TOKEN TO RETURN
  INC HL                  ;POINT TO NUMBER
  LD (CONSAV),A           ;SAVE CURRENT TOKEN
  SUB INTCON              ;IS IT LESS THAN INTEGER CONSTANT?
  JR NC,MAKTKN            ;NO, NOT LINE NUMBER CONSTANT
  SUB ONECON-INTCON       ;LESS THAN EMBEDDED 1 BYTER
  JR NC,ONEI              ;WAS ONE BYTER
  CP IN2CON-ONECON        ;IS IT TWO BYTER?
  JR NZ,FRCINC            ;NOPE, NORMAL INT
  LD A,(HL)               ;GET EMBEDED INT
  INC HL                  ;POINT AFTER CONSTANT
ONEI:
  LD (CONTXT),HL          ;SAVE TEXT POINTER
  LD H,$00                ;GET UPPER BYTE OF ZERO
ONEI2:
  LD L,A                  ;GET VALUE
  LD (CONLO),HL           ;SAVE CONSTANT VALUE
  LD A,$02                ;GET VALTYPE
  LD (CONTYP),A           ;SET IT UP IN SAVE PLACE
  LD HL,NUMCON            ;POINT TO NUMBER RE-SCANNER ("FAKE TEXT")
  POP AF                  ;GET BACK TOKEN
  OR A                    ;MAKE SURE NUMBER FLAG RE-SET
  RET                     ;RETURN TO CALLER

FRCINC:
  LD A,(HL)               ;GET LOW BYTE OF CONSTANT
  INC HL                  ;POINT PAST IT
  INC HL                  ;TO NEXT THING
  LD (CONTXT),HL          ;SAVE POINTER PAST
  DEC HL                  ;BACK TO HIGH BYTE
  LD H,(HL)               ;GET HIGH BYTE
  JR ONEI2                ;FINISH SCANNING

;RESCAN THE TOKEN & RESTORE OLD TEXT PTR
; This entry point is used by the routine at OPRND.
_CONFAC:
  CALL CONFAC
NTRSC2:
  LD HL,(CONTXT)
  JR __CHRCKB

MAKTKN:                   ;CALCULATE VALTYPE
  INC A                   ;*2 TO GET VALTYPE 0=2, 1=4, 3=8
  RLCA                    ;CONTYPE NOW SETUP
  LD (CONTYP),A           ;SAVE SOME RGS
  PUSH DE
  PUSH BC                 ;PLACE TO STORE SAVED CONSTANT
  LD DE,CONLO             ;GET TEXT POINTER IN [D,E]
  EX DE,HL                ;SETUP COUNTER IN [B]
  LD B,A                  ;MOVE DATA IN
  CALL MOVE1              ;GET TEXT POINTER BACK
  EX DE,HL                ;RESTORE [B,C]
  POP BC
  POP DE
  LD (CONTXT),HL          ;SAVE THE GOOD TEXT POINTER
  POP AF                  ;RESTORE TOKEN
  LD HL,NUMCON            ;GET POINTER TO FAKE TEXT
  OR A                    ;CLEAR CARRY SO OTHERS DONT THINK ITS A NUMBER AND SET NON-ZERO SO NOT TERMINATOR
  RET                     ;ALL DONE
  
NOTCON:
  CP $09                  ;LINE FEED OR TAB?
  JR NC,CHRGTB            ;YES, EAT.
NOTLFT:
  CP '0'                  ;ALL CHARACTERS GREATER THAN "9" HAVE RETURNED, SO SEE IF NUMERIC
  CCF                     ;MAKE NUMERICS HAVE CARRY ON
  INC A                   ;SET ZERO IF [A]=0
  DEC A
  RET


;THESE FAKE TOKENS FORCE CHRGET TO EFFECTIVELY RE-SCAN THE EMBEDED CONSTANT
NUMCON:
  DEFB CONCON     ;TOKEN RETURNED BY CHRGET AFTER CONSTANT SCANNED
  DEFB CONCN2     ;TOKEN RETURNED SECOND TYPE CONSTANT IS SCANNED.


; This entry point is used by the routine at LISPRT.
CONFAC:
  LD A,(CONSAV)            ;GET CONSTANT TOKEN
  CP LINCON+1              ;LINE# CONSTANT? (ERL=#)
  JR NC,NTLINE             ;NO
  CP PTRCON                ;LINE POINTER CONSTANT?
  JR C,NTLINE              ;NO
  LD HL,(CONLO)            ;GET VALUE
  JR NZ,FLTLIN             ;MUST BE LINE NUMBER, NOT POINTER
  INC HL                   ;POINT TO LINE #
  INC HL
  INC HL
  LD E,(HL)                ;GET LINE # IN [D,E]
  INC HL
  LD D,(HL)                ;GET HIGH PART
  EX DE,HL                 ;VALUE TO [H,L]
FLTLIN:
  JP INEG2                 ;FLOAT IT

NTLINE:
  LD A,(CONTYP)            ;GET SAVED CONSTANT VALTYP
  LD (VALTYP),A            ;SAVE IN REAL VALTYP
  CP $08                   ;DOUBLE PRECISION ?
  JR Z,CONFDB              ;YES
;NEW_STMT:                  ; Interprete next statement
  LD HL,(CONLO)            ;GET LOW TWO BYTES OF FAC
  LD (FACCU),HL            ;SAVE THEM
  LD HL,(CONLO+2)          ;GET NEXT TWO BYTES
  LD (FACCU+2),HL          ;SAVE THEM
  RET                      ;SCAN FURTHER

CONFDB:
  LD HL,CONLO              ;GET POINTER TO SAVED CONSTANT AREA
  JP VMOVFM                ;MOVE INTO FAC  (then, RESTORE TEXT PTR & SCAN FOLLOWING CHARACTER)

; 'DEFSTR' BASIC function
__DEFSTR:
  LD E,$03                ;DEFAULT SOME LETTERS TO STRING
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'DEFINT' BASIC function
__DEFINT:
  LD E,$02                ;DEFAULT SOME LETTERS TO INTEGER
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'DEFSNG' BASIC function
__DEFSNG:
  LD E,$04                ;DEFAULT SOME LETTERS TO SINGLE PRECISION
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'DEFDBL' BASIC function
__DEFDBL:
  LD E,$08                ;DEFAULT SOME LETTERS TO DOUBLE PRECISION

; Routine at 5082
; a.k.a. DEFCON
DEFCON:
  CALL CHKLTR             ;MAKE SURE THE ARGUMENT IS A LETTER
  LD BC,SN_ERR            ;PREPARE "SYNTAX ERROR" RETURN
  PUSH BC
  RET C                   ;RETURN IF THERES NO LETTER
  SUB 'A'                 ;MAKE AN OFFSET INTO DEFTBL
  LD C,A                  ;SAVE THE INITIAL OFFSET
  LD B,A                  ;ASSUME IT WILL BE THE FINAL OFFSET
  CALL CHRGTB             ;GET THE POSSIBLE DASH
  CP TK_MINUS             ;(token code for '-'): A RANGE ARGUMENT? ; 
  JR NZ,NOTRNG            ;IF NOT, JUST ONE LETTER
  CALL CHRGTB             ;GET THE FINAL POSITION
  CALL CHKLTR             ;CHECK FOR A LETTER
  RET C                   ;GIVE A SYNTAX ERROR IF IMPROPER
  SUB 'A'                 ;MAKE IT AN OFFSET
  LD B,A                  ;PUT THE FINAL IN [B]
  CALL CHRGTB             ;GET THE TERMINATOR
NOTRNG:
  LD A,B                  ;GET THE FINAL CHARACTER
  SUB C                   ;SUBTRACT THE START
  RET C                   ;IF IT'S LESS THATS NONSENSE
  INC A                   ;SETUP THE COUNT RIGHT
  EX (SP),HL              ;SAVE THE TEXT POINTER AND GET RID OF THE "SYNTAX ERROR" RETURN
  LD HL,DEFTBL            ;POINT TO THE TABLE OF DEFAULTS
  LD B,$00                ;SETUP A TWO-BYTE STARTING OFFSET
  ADD HL,BC               ;MAKE [H,L] POINT TO THE FIRST ENTRY TO BE MODIFIED
LPDCHG:
  LD (HL),E               ;MODIFY THE DEFAULT TABLE
  INC HL                  
  DEC A                   ;COUNT DOUNT THE NUMBER OF CHANGES TO MAKE
  JR NZ,LPDCHG            
  POP HL                  ;GET BACK THE TEXT POINTER
  LD A,(HL)               ;GET LAST CHARACTER
  CP ','                  ;IS IT A COMMA?
  RET NZ                  ;IF NOT STATEMENT SHOULD HAVE ENDED
  CALL CHRGTB             ;OTHERWISE SET UP TO SCAN NEW RANGE
  JR DEFCON

; Get subscript
;
; Used by the routines at CAYSTR, __GET and SBSCPT.
;
; INTIDX READS A FORMULA FROM THE CURRENT POSITION AND
; TURNS IT INTO A POSITIVE INTEGER
; LEAVING THE RESULT IN [D,E].  NEGATIVE ARGUMENTS
; ARE NOT ALLOWED. [H,L] POINTS TO THE TERMINATING
; CHARACTER OF THE FORMULA ON RETURN.
;
INTIDX:
  CALL CHRGTB
; This entry point is used by the routine at __CLEAR.
INTIDX_0:
  CALL FPSINT_0          ;READ A FORMULA AND GET THE RESULT AS AN INTEGER IN [D,E]
                         ;ALSO SET THE CONDITION CODES BASED ON THE HIGH ORDER OF THE RESULT
  RET P                  ;DON'T ALLOW NEGATIVE NUMBERS

; Err $05 - "Illegal function call"
;
; Used by the routines at __ERROR, __AUTO, __ERL, DOFN, CONINT, __DELETE,
; __RENUM, __LOG, __NAME, __CVD, FN_INPUT, __CHAIN, VALTYP, CAYSTR, __GET,
; __USING, NOTSCI, __TROFF, __CLEAR, __ASC, __MID_S, FN_INSTR and INIT.
FC_ERR:
  LD E,$05				; Err $05 - "Illegal function call"
  JP ERROR              ;TOO BIG. FUNCTION CALL ERROR

; Evaluate line number text pointed to by HL.
;
;
; LINSPC IS THE SAME AS LINGET EXCEPT IN ALLOWS THE
; CURRENT LINE (.) SPECIFIER
;
; This entry point is used by the routines at LNUM_RANGE, __AUTO, __RENUM and
; __EDIT.
LNUM_PARM:
  LD A,(HL)             ;GET CHAR FROM MEMORY
  CP '.'                ;IS IT CURRENT LINE SPECIFIER
  LD DE,(DOT)           ;GET CURRENT LINE #
  JP Z,CHRGTB           ;ALL DONE.

; Get specified line number
; ASCII to Integer, result in DE
;
; LINGET READS A LINE # FROM THE CURRENT TEXT POSITION
;
; LINE NUMBERS RANGE FROM 0 TO 65529
;
; THE ANSWER IS RETURNED IN [D,E].
; [H,L] IS UPDATED TO POINT TO THE TERMINATING CHARACTER
; AND [A] CONTAINS THE TERMINATING CHARACTER WITH CONDITION
; CODES SET UP TO REFLECT ITS VALUE.
;
; Used by the routines at PROMPT, TSTNUM, __GOSUB, __GOTO, __ON,
; __RESUME, __AUTO, UCASE, __RENUM, PUTBUF and SYNCHR.
ATOH:
  DEC HL                ;BACKSPACE PTR

; As above, but conversion starts at HL+1
;
; This entry point is used by the routine at __ON.
ATOH2:
  CALL CHRGTB           ;FETCH CHAR (GOBBLE LINE CONSTANTS)
  CP LINCON             ;$0E: EMBEDDED LINE CONSTANT?
  JR Z,LINGT3           ;YES, RETURN DOUBLE BYTE VALUE
  CP PTRCON             ;$0D: ALSO CHECK FOR POINTER

; This entry point is used by the routines at _LINE2PTR and SCNPT2.
LINGT3:
  LD DE,(CONLO)         ;GET EMBEDDED LINE #
  JP Z,CHRGTB           ;EAT FOLLOWING CHAR
  XOR A
  LD (CONSAV),A
  LD DE,$0000           ;ZERO ACCUMULATED LINE #
  DEC HL                ;BACK UP POINTER

GTLNLP:               ;a.k.a. MORLIN
  CALL CHRGTB         ; Get next character
  RET NC              ; Exit if not a digit          ;WAS IT A DIGIT
  PUSH HL             ; Save code string address
  PUSH AF             ; Save digit
  LD HL,65529/10      ; Largest number 65529         ;SEE IF THE LINE # IS TOO BIG
  CALL DCOMPR         ; Compare HL with DE.
  JR C,POPHSR         ; YES, DON'T SCAN ANY MORE DIGITS IF SO.  FORCE CALLER TO SEE DIGIT AND GIVE SYNTAX ERROR
                      ; CAN'T JUST GO TO SYNTAX ERROR BECAUSE OF NON-FAST RENUM WHICH CAN'T TERMINATE
  LD H,D              ;SAVE [D,E]
  LD L,E
  ADD HL,DE           ; *2
  ADD HL,HL           ; ..*4
  ADD HL,DE           ; ..*5
  ADD HL,HL           ; ..*10   ;PUTTING [D,E]*10 INTO [H,L]
  POP AF              ; Restore digit
  SUB '0'             ; Make it 0 to 9
  LD E,A              ; DE = Value of digit
  LD D,$00        
  ADD HL,DE		      ; Add to number                   ;ADD THE NEW DIGIT
  EX DE,HL            ; Number to DE
  POP HL              ; Restore code string address     ;GET BACK TEXT POINTER
  JR GTLNLP           ; Go to next character
  
POPHSR:
  POP AF              ;GET OFF TERMINATING DIGIT
  POP HL              ;GET BACK OLD TEXT POINTER
  RET
  
  
__RUN:
  JP Z,RUN_FST        ; RUN from start if just RUN   ;NO LINE # ARGUMENT
  CP LINCON           ;LINE NUMBER CONSTANT?
  JR Z,__RUN_0        ;YES
  CP PTRCON           ;LINE POINTER (RATHER UNLIKELY)
  JP NZ,LRUN          ;No line number specified, try to load and run a file

;CLEAN UP,SET [H,L]=[TXTTAB]-1 AND
;RETURN TO NEWSTT
__RUN_0:
  CALL CLEARC          ; Initialise variables      ;CLEAN UP -- RESET THE STACK, DATPTR,VARIABLES ...
                                                   ;[H,L] IS THE ONLY THING PRESERVED
  LD BC,NEWSTT         ; Execution driver loop
  JR RUNLIN            ; RUN from line number      ;PUT "NEWSTT" ON AND FALL INTO "GOTO"

; 'GOSUB' BASIC command
;
; A "GOSUB" ENTRY ON THE STACK HAS THE FOLLOWING FORMAT
;
; LOW ADDRESS
;
;	A TOKEN EQUAL TO $GOSUB 1 BYTE
;	THE LINE # OF THE THE "GOSUB" STATEMENT 2 BYTES
;	A POINTER INTO THE TEXT OF THE "GOSUB" 2 BYTES
;
; HIGH ADDRESS
;
; TOTAL 5 BYTES
;
__GOSUB:
  LD C,$03                ; 3 Levels of stack needed         ;"GOSUB" ENTRIES ARE 5 BYTES LONG
  CALL CHKSTK             ; Check for 3 levels of stack      ;MAKE SURE THERE IS ROOM
  CALL ATOH                                                  ;MUST SCAN LINE NUMBER NOW
  POP BC                  ; Get return address               ;POP OFF RETURN ADDRESS OF "NEWSTT"
  PUSH HL                 ; Save code string for RETURN      ;REALLY PUSH THE TEXT POINTER
  PUSH HL                 ; And for GOSUB routine            ;SAVE TEXT POINTER
  LD HL,(CURLIN)          ; Get current line                 ;GET THE CURRENT LINE #
  EX (SP),HL              ; Into stack - Code string out     ;PUT CURLIN ON THE STACK AND [H,L]=TEXT PTR
  LD A,TK_GOSUB           ; "GOSUB" token
  PUSH AF                 ; Save token                       ;PUT GOSUB TOKEN ON THE STACK
  INC SP                  ; Don't save flags                 ;THE GOSUB TOKEN TAKES ONLY ONE BYTE
  PUSH BC                 ; Save return address              ;SAVE NEWSTT ON STACK
  JR __GOTO_0                                               ;HAVE NOW GRAB LINE # PROPERLY
  
; This entry point is used by the routine at __RUN.
RUNLIN:                                            ; CONTINUE WITH SUBROUTINE
  PUSH BC                 ; Save return address    ; RESTORE RETURN ADDRESS OF "NEWSTT"
                                                   ; AND SEARCH. IN THE 8K WE START WHERE WE
                                                   ; ARE IF WE ARE GOING TO A FORWARD LOCATION.
; 'GOTO' BASIC command
;
; Used by the routine at __IF.
__GOTO:
  CALL ATOH               ; ASCII number to DE binary    ;PICK UP THE LINE # AND PUT IT IN [D,E]
; This entry point is used by the routines at __GOSUB and __RESUME.
__GOTO_0:
  LD A,(CONSAV)           ;GET TOKEN FOR LINE # BACK
  CP PTRCON               ;WAS IT A POINTER
  EX DE,HL                ;ASSUME SO
  RET Z                   ;IF IT WAS, GO BACK TO NEWSTT WITH [H,L] AS TEXT PTR
  CP LINCON               ; Line number prefix ?
  JP NZ,SN_ERR            ; ...if not, something was wrong
  EX DE,HL                ;FLIP BACK IF NOT
  PUSH HL                 ;SAVE CURRENT TEXT PTR ON STACK
  LD HL,(CONTXT)          ;GET POINTER TO RIGHT AFTER CONSTANT
  EX (SP),HL              ;SAVE ON STACK, RESTORE CURRENT TEXT PTR
  CALL __REM              ; Get end of line                     ;SKIP TO THE END OF THIS LINE
  INC HL                  ; Start of next line                  ;POINT AT THE LINK BEYOND IT
  PUSH HL                 ; Save Start of next line             ;SAVE THE POINTER
  LD HL,(CURLIN)          ; Get current line                    ;GET THE CURRENT LINE #
  CALL DCOMPR             ; Line after current?   ;[D,E] CONTAINS WHERE WE ARE GOING, [H,L] CONTAINS THE CURRENT LINE #
                                                  ;SO COMPARING THEM TELLS US WHETHER TO START SEARCHING FROM WHERE 
                                                  ;WE ARE OR TO START SEARCHING FROM THE BEGINNING OF TXTTAB
  POP HL                  ; Restore Start of next line         ; [H,L]=CURRENT POINTER
  CALL C,SRCHLP           ; Line is after current line         ; SEARCH FROM THIS POINT
  CALL NC,SRCHLN          ; Line is before current line        ; SEARCH FROM THE BEGINNING
                                                               ; -- ACTUALLY SEARCH AGAIN IF ABOVE SEARCH FAILED
  JR NC,UL_ERR            ; Err $08 - "Undefined line number"  ;LINE NOT FOUND, DEATH
  DEC BC                  ; Incremented after                  ;POINT TO ZERO AT END OF PREVIOUS LINE
  LD A,PTRCON             ;POINTER CONSTANT
  LD (PTRFLG),A           ;SET PTRFLG
  POP HL                  ;GET SAVED POINTER TO RIGHT AFTER CONSTANT
  CALL CONCH2             ;CHANGE LINE # TO PTR
  LD H,B                  ; Set up code string address: [H,L]= POINTER TO THE START OF THE MATCHED LINE
  LD L,C                  ; NOW POINTING AT THE FIRST BYTE OF THE POINTER TO THE START OF THE NEXT LINE
  RET                     ; Line found: GO TO NEWSTT

; entry for '?UL ERROR'
;
; Used by the routines at PROMPT, __GOTO, __ON, CAYSTR, __EDIT and SYNCHR.
UL_ERR:
  LD E,$08                ; Err $08 - "Undefined line number"
  JP ERROR                ;C=MATCH, SO IF NO MATCH WE GIVE A "US" ERROR


;
; SEE "GOSUB" FOR THE FORMAT OF THE STACK ENTRY
; "RETURN" RESTORES THE LINE NUMBER AND TEXT POINTER ON THE STACK
; AFTER ELIMINATING ALL THE "FOR" ENTRIES IN FRONT OF THE "GOSUB" ENTRY
;
__RETURN:
  RET NZ                  ; Return if not just RETURN      ;BLOW HIM UP IF THERE ISN'T A TERMINATOR
  LD D,$FF                ; Flag "GOSUB" search            ;MAKE SURE THIS VARIABLE POINTER IN [D,E] NEVER GETS MATCHED
  CALL BAKSTK             ; Look "GOSUB" block             ;GO PAST ALL THE "FOR" ENTRIES
  LD SP,HL                ; Kill all FORs in subroutine    ;UPDATE THE STACK
  LD (SAVSTK),HL                                           ;UPDATE SAVED STACK
  CP TK_GOSUB             ; TK_GOSUB, Token for 'GOSUB'
  LD E,$03                ; Err $03 - "RETURN without GOSUB" (ERRRG)
  JP NZ,ERROR             ; Error if no "GOSUB" found          
  POP HL                  ; Get RETURN line number         ;GET LINE # "GOSUB" WAS FROM
  LD (CURLIN),HL          ; Save as current                ;PUT IT INTO CURLIN
  LD HL,NEWSTT            ; Execution driver loop
  EX (SP),HL              ; Into stack - Code string out   ;PUT RETURN ADDRESS OF "NEWSTT" BACK ONTO THE STACK.
                                                           ;GET TEXT POINTER FROM "GOSUB" SKIP OVER SOME CHARACTERS
                                                           ;SINCE WHEN "GOSUB" STUCK THE TEXT POINTER ONTO THE STACK
                                                           ;THE LINE # ARGUMENT HADN'T BEEN READ IN YET.

  DEFB $3E                ; "LD A,n" to Mask the next byte  ("MVI A," AROUND POP H.)

NXTDTA:
  POP HL                  ;GET TEXT POINTER OFF STACK

; 'COMMON' and 'DATA' BASIC instructions
;
; Used by the routines at __FOR, __RESUME, __IF, FDTLP, __DEF, __CHAIN and
; CAYSTR.

; "DATA" TERMINATES ON ":" AND 0. 
; ":" ONLY APPLIES IF QUOTES HAVE MATCHED UP
__DATA:
  DEFB $01                ; "LD BC," TO PICK UP ":" INTO C AND SKIP
  DEFB ':'                ;"DATA" TERMINATES ON ":" AND 0.   ":" ONLY APPLIES IF QUOTES HAVE MATCHED UP

; __ELSE (EXECUTED "ELSE"S ARE SKIPPED), __REM
;
; NOTE: REM MUST PRESERVE [D,E] BECAUSE OF "GO TO" AND ERROR
;
; Used by the routines at NTDER2 and __GOTO.
__REM:
  DEFB $0E          ;"LD C,"   THE ONLY TERMINATOR IS ZERO
  DEFB 0            ;0 = End of statement

  LD B,$00          ;INSIDE QUOTES THE ONLY TERMINATOR IS ZERO
NXTSTL:
  LD A,C            ; Statement and byte   ;WHEN A QUOTE IS SEEN THE SECOND
  LD C,B                                   ;TERMINATOR IS TRADED, SO IN "DATA"
  LD B,A            ; Statement end byte   ;COLONS INSIDE QUOTATIONS WILL HAVE NO EFFECT
__REM_0:
  DEC HL            ;NOP THE INX H IN CHRGET
__REM_1:
  CALL CHRGTB             ; Get byte                     ;GET A CHAR
  OR A                    ; End of line?                 ;ZERO IS ALWAYS A TERMINATOR
  RET Z                   ; Yes - Exit
  CP B                    ; End of statement?            ;TEST FOR THE OTHER TERMINATOR
  RET Z                   ; Yes - Exit
  INC HL                  ; Next byte
  CP '"'                  ; Literal string?              ;IS IT A QUOTE?
  JR Z,NXTSTL             ; Yes - Look for another '"'   ;IF SO TIME TO TRADE
;
; WHEN AN "IF" TAKES A FALSE BRANCH IT MUST FIND THE APPROPRIATE "ELSE" TO START EXECUTION AT.
; "DATA" COUNTS THE NUMBER OF "IF"S, IT SEES SO THAT THE "ELSE" CODE CAN MATCH "ELSE"S WITH "IF"S.
; THE COUNT IS KEPT IN [D] BECAUSE THEN S HAVE NO COLON
; MULTIPLE IFS CAN BE FOUND IN A SINGLE STATEMENT SCAN
; THIS CAUSES A PROBLEM FOR 8-BIT DATA IN UNQUOTED STRING DATA BECAUSE $IF MIGHT BE MATCHED.
; FIX IS TO HAVE FALSIF IGNORE CHANGES IN [D] IF ITS A DATA STATEMENT
;
  INC A                   ;FUNCTION TOKEN?
  JR Z,__REM_1            ;THEN IGNORE FOLLOWING FN NUMBER
  SUB TK_IF+1             ;IS IT AN "IF"
  JR NZ,__REM_0           ;IF NOT, CONTINUE ON
  CP B                    ;SINCE "REM" CAN'T SMASH [D,E] WE HAVE TO BE CAREFUL
                          ;SO ONLY IF B DOESN'T EQUAL ZERO WE INCREMENT D. (THE "IF" COUNT)
  ADC A,D                 ;CARRY ON IF [B] NOT ZERO
  LD D,A                  ;UPDATE [D]
  JR __REM_0              ; Keep looking

; Code at $1518
; LETCON IS LET ENTRY POINT WITH VALTYP-3 IN [A]
; BECAUSE GETYPR HAS BEEN CALLED
LETCON:
  POP AF                  ;GET VALTYPE OFF STACK
  ADD A,$03               ;MAKE VALTYPE CORRECT
  JR __LET_0              ;CONTINUE

; 'LET' BASIC command
;
; Used by the routine at EXEC.
__LET:
  CALL GETVAR             ;GET THE POINTER TO THE VARIABLE NAMED IN TEXT AND PUT IT INTO [D,E]
  CALL SYNCHR
  DEFB TK_EQUAL           ;CHECK FOR "="
  LD (TEMP),DE            ;MUST SET UP TEMP FOR "FOR"
                          ;UP HERE SO WHEN USER-FUNCTIONS
                          ;CALL REDINP, TEMP DOESN'T GET CHANGED
  PUSH DE
  LD A,(VALTYP)           ; Get data type
  PUSH AF                 ; save type         ;CALL REDINP, TEMP DOESN'T GET CHANGED
  CALL EVAL                                   ;GET THE VALUE OF THE FORMULA
  POP AF                  ; Restore type      ;GET THE VALTYP OF THE VARIABLE INTO [A] INTO FAC

; This entry point is used by the routines at LETCON and __LINE.
__LET_0:
  EX (SP),HL              ;[H,L]=POINTER TO VARIABLE TEXT POINTER TO ON TOP OF STACK
; This entry point is used by the routine at DOASIG.
__LET_1:
  LD B,A                  ;SAVE VALTYP
  LD A,(VALTYP)           ;GET PRESENT VALTYPE
  CP B                    ;COMPARE THE TWO
  LD A,B                  ;GET BACK CURRENT
  JR Z,__LET_2            ;VALTYPE ALREADY SET UP, GO!
  CALL CHKTYP             ;FORCE VALTPES TO BE [A]'S
; This entry point is used by the routine at DOFN.
LETCN4:
  LD A,(VALTYP)           ;GET PRESENT VALTYPE
__LET_2:
  LD DE,FACCU             ;ASSUME THIS IS WHERE TO START MOVEING
  CP $05                  ;IS IT?   ; (Integer ?)
  JR C,__LET_3            ;YES
  LD DE,FACLOW            ;NO, USE D.P. FAC
__LET_3:
  PUSH HL                 ;SAVE THE POINTER AT THE VALUE POSITION
  CP $03                  ; String ?
  JR NZ,LETNUM            ; Numeric - Move value              ;NUMERIC, SO FORCE IT AND COPY

  LD HL,(FACCU)           ; Pointer to string entry           ;GET POINTER TO THE DESCRIPTOR OF THE RESULT
  PUSH HL                 ; Save it on stack                  ;SAVE THE POINTER AT THE DESCRIPTOR
  INC HL                  ; Skip over length
  LD E,(HL)               ; LSB of string address
  INC HL
  LD D,(HL)               ; MSB of string address
  LD HL,(TXTTAB)          ; Point to start of program         ;IF THE DATA IS IN BUF, OR IN DISK RANDOM BUFFER, COPY.
  CALL DCOMPR             ; Is string before program?         ;SINCE BUF CHANGES ALL THE TIME
  JR NC,CRESTR            ; Yes - Create string entry         ;GO COPY, IF DATA REALLY IS IN BUF
  LD HL,(STREND)          ; Point to string space             ;SEE IF IT POINTS INTO STRING SPACE
  CALL DCOMPR             ; Is string literal in program?     ;IF NOT DON'T COPY
  POP DE                  ; Restore address of string         ;GET BACK THE POINTER AT THE DESCRIPTOR
  JR NC,DNTCPY            ; Yes - Set up pointer              ;DON'T COPY LITERALS
  LD HL,DSCTMP            ; Temporary string pool             ;NOW, SEE IF ITS A VARIABLE
  CALL DCOMPR             ; Is string in temporary pool?      ;BY SEEING IF THE DESCRIPTOR IS IN THE TEMPORARY STORAGE AREA (BELOW DSCTMP)
  JR NC,DNTCPY            ; No - Set up pointer               ;DON'T COPY IF ITS NOT A VARIABLE

  DEFB $3E                ; "LD A,n" to Mask the next byte

CRESTR:
  POP DE                  ; Restore address of string         ;GET THE POINTER TO THE DESCRIPTOR IN [D,E]

  CALL FRETMS             ; Back to last tmp-str entry        ;FREE UP A TEMORARY POINTING INTO BUF
  EX DE,HL                ; Address of string entry           ;STRCPY COPIES [H,L]
  CALL STRCPY             ; Save string in string area        ;COPY VARIABLES IN STRING SPACE OR STRINGS WITH DATA IN BUF

; a.k.a MVSTPT
DNTCPY:
  CALL FRETMS             ; Back to last tmp-str entry        ;FREE UP THE TEMPORARY WITHOUT FREEING UP ANY STRING SPACE
  EX (SP),HL              ;[H,L]=PLACE TO STORE THE DESCRIPTOR
                          ;LEAVE A NONSENSE ENTRY ON THE STACK, SINCE THE "POP DE" DOESN'T EVER MATTER IN THIS CASE
LETNUM:
  CALL VMOVE              ; Move string pointer to var        ;COPY A DESCRIPTOR OR A VALUE
  POP DE                  ;FOR "FOR" POP OFF A POINTER AT THE LOOP VARIABLE INTO [D,E]
  POP HL                  ; Restore code string address       ;GET THE TEXT POINTER BACK
  RET

; 'ON' BASIC instruction
; ON..GOTO, ON ERROR GOTO CODE
__ON:
  CP TK_ERROR             ;"ON...ERROR"?
  JR NZ,NTOERR            ;NO.
  CALL CHRGTB             ;GET NEXT THING
  CALL SYNCHR             
  DEFB TK_GOTO            ;MUST HAVE ...GOTO
  CALL ATOH               ;GET FOLLOWING LINE #
  LD A,D                  ;IS LINE NUMBER ZERO?
  OR E                    ;SEE
  JR Z,__ON_0             ;IF ON ERROR GOTO 0, RESET TRAP
  CALL FNDLN1             ;SEE IF LINE EXISTS (SAVE [H,L] ON STACK)	..Sink HL in stack and get first line number
  LD D,B                  ;GET POINTER TO LINE IN [D,E]
  LD E,C                  ;(LINK FIELD OF LINE)
  POP HL                  ;RESTORE [H,L]
  JP NC,UL_ERR            ;ERROR IF LINE NOT FOUND.. Err $08 - "Undefined line number"
__ON_0:
  LD (ONELIN),DE          ;SAVE POINTER TO LINE OR ZERO IF 0.
  RET C                   ;YOU WOULDN'T BELIEVE IT IF I TOLD YOU
  LD A,(ONEFLG)           ;ARE WE IN AN "ON...ERROR" ROUTINE?
  OR A                    ;SET CONDITION CODES
  LD A,E                  ;WANT AN EVEN STACK PTR. FOR 8086
  RET Z                   ;IF NOT, HAVE ALREADY DISABLED TRAPPING.
  LD A,(ERRFLG)           ;GET ERROR CODE
  LD E,A                  ;INTO E.
  JP ERRESM               ;FORCE THE ERROR TO HAPPEN

; Not 'ON ERROR'
NTOERR:
  CALL GETINT             ; Get integer 0-255                  ;GET VALUE INTO [E]
  LD A,(HL)               ; Get "GOTO" or "GOSUB" token        ;GET THE TERMINATOR BACK
  LD B,A                  ; Save in B                          ;SAVE THIS CHARACTER FOR LATER
  CP TK_GOSUB             ; "GOSUB" token?                     ;AN "ON ... GOSUB" PERHAPS?
  JR Z,ONGO               ; Yes - Find line number             ;YES, SOME FEATURE USE
  CALL SYNCHR             ; Make sure it's "GOTO"
  DEFB TK_GOTO            ; "GOTO" token                       ;OTHERWISE MUST BE "GOTO"
  DEC HL                  ; Cancel increment                   ;BACK UP CHARACTER POINTER
ONGO:
  LD C,E                  ; Integer of branch value
ONGOLP:
  DEC C                   ; Count branches
  LD A,B                  ; Get "GOTO" or "GOSUB" token
  JP Z,ONJMP              ; Go to that line if right one
  CALL ATOH2              ; Get line number to DE
  CP ','                  ; Another line number?          ;A COMMA
  RET NZ                  ; No - Drop through, IF A COMMA DOESN'T DELIMIT THE END OF THE
                          ; CURRENT LINE #, WE MUST BE THE END OF THE LINE
  JR ONGOLP               ; Yes - loop                    ;CONTINUE GOBBLING LINE #S

; 'RESUME' BASIC command
__RESUME:


;  LD A,(ONEFLG)           ;GET FLAG
;  OR A                    ;TRAP ROUTINE.
;  JP NZ,__RESUME_0        ;No error, continue
;  LD (ONELIN),A
;  LD (ONELIN+1),A
;  JP RW_ERR               ;"RESUME WITHOUT ERROR"

; --> updated in the late March edition
  LD DE,ONEFLG            ;GET FLAG
  LD A,(DE)               ;TRAP ROUTINE.
  OR A
  JP Z,RW_ERR             ;"RESUME WITHOUT ERROR"
  INC A                   ;MAKE A=0
  LD (ERRFLG),A           ;CLEAR ERROR FLAG SO ^C DOESN'T GIVE ERROR
  LD (DE),A
  LD A,(HL)
  CP TK_NEXT              ;RESUME NEXT?
  JR Z,RESNXT             ;YUP.
                          ;No error, continue

;__RESUME_0:
;  INC A                   ;MAKE A=0
;  LD (ERRFLG),A           ;CLEAR ERROR FLAG SO ^C DOESN'T GIVE ERROR
;  LD A,(HL)               ;GET CURRENT CHAR BACK
;  CP TK_NEXT              ;RESUME NEXT?
;  JP Z,RESNXT             ;YUP.

  CALL ATOH               ;GET FOLLOWING LINE #
  RET NZ                  ;SHOULD TERMINATE
  LD A,D                  ;IS LINE NUMBER ZERO?
  OR E                    ;TEST

;  JP Z,RESTXT
;  CALL __GOTO_0           ;DO A GOTO THAT LINE.
;  XOR A
;  LD (ONEFLG),A         ; Clear 'on error' flag
;  RET

  JP NZ,__GOTO_0
  INC A
  JR RESTXT

RESNXT:
  CALL CHRGTB             ;MUST TERMINATE
  RET NZ                  ;BLOW HIM UP

;  DEFB $3E                ; DEFB $3E  ; "LD A,n" to Mask the next byte  (skip "INC A")

RESTXT:
;  INC A                   ;SET NON ZERO CONDITION CODES
  LD HL,(ERRTXT)          ;GET POINTER INTO LINE.
  EX DE,HL                ;SAVE ERRTXT IN [D,E]
  LD HL,(ERRLIN)          ;GET LINE #
  LD (CURLIN),HL          ;SAVE IN CURRENT LINE #
  EX DE,HL
  RET NZ                  ;GO TO NEWSTT IF JUST "RESUME"
  LD A,(HL)               ;GET ":" OR LINE HEADER
  OR A                    ;SET CC
  JR NZ,NOTBGL            ;#0 MEANS MUST BE ":"
  INC HL                  ;SKIP HEADER
  INC HL
  INC HL
  INC HL
NOTBGL:
;  INC HL                  ;POINT TO START OF THIS STATEMENT
;  XOR A
;  LD (ONEFLG),A           ; Clear 'on error' flag
  INC HL
  JP __DATA               ;GET NEXT STMT


; 'ERROR' BASIC command
;
; THIS IS THE ERROR <CODE> STATEMENT WHICH FORCES
; AN ERROR OF TYPE <CODE> TO OCCUR
; <CODE> MUST BE .GE. 0 AND .LE. 255
;
__ERROR:
  CALL GETINT             ;GET THE PARAM
  RET NZ                  ;SHOULD HAVE TERMINATED
  OR A                    ;ERROR CODE 0?
  JP Z,FC_ERR             ;YES, ERROR IN ITSELF, Err $05 - "Illegal function call"
  JP ERROR                ;FORCE AN ERROR


; AUTO [<line number>[,<increment>]]
;
; THE AUTO [BEGGINNING LINE[,[INCREMENT]]]
; COMMAND IS USED TO AUTOMATICALLY GENERATE LINE NUMBERS FOR LINES TO BE INSERTED.
; BEGINNING LINE IS USED TO SPECIFY THE INITAL LINE (10 IS ASSUMED IF OMMITED)
; AND THE INCREMENT IS USED TO SPECIFY THE INCREMENT USED TO GENERATE THE NEXT LINE #.
; IF ONLY A COMMA IS USED AFTER THE BEGGINING LINE, THE OLD INCREMENT IS USED.
;
__AUTO:
  LD DE,10                ;ASSUME INITIAL LINE # OF 10
  PUSH DE                 ;SAVE IT
  JR Z,__AUTO_0           ;IF END OF COMMAND USE 10,10
  CALL LNUM_PARM          ;GET LINE #, ALLOW USE OF . FOR CURRENT LINE
  EX DE,HL                ;GET TXT PTR IN [D,E]
  EX (SP),HL              ;PUT INIT ON STACK, GET 10 IN [H,L]
  JR Z,__AUTO_1           ;IF TERMINATOR, USE INC OF 10
  EX DE,HL                ;GET TEXT PTR BACK IN [H,L]
  CALL SYNCHR
  DEFM ","                ;COMMA MUST FOLLOW
  LD DE,(AUTINC)          ;GET PREVIOUS INC
  JR Z,__AUTO_0           ;USE PREVIOUS INC IF TERMINATOR
  CALL ATOH               ;GET INC
  JP NZ,SN_ERR            ;SHOULD HAVE FINISHED.
__AUTO_0:
  EX DE,HL                ;GET INC IN [H,L]
__AUTO_1:
  LD A,H                  ;SEE IF ZERO
  OR L
  JP Z,FC_ERR             ;ZERO INC GIVES FCERR ( Err $05 - "Illegal function call" )
  LD (AUTINC),HL          ;SAVE INCREMENT
  LD (AUTFLG),A           ;SET FLAG TO USE AUTO IN MAIN CODE.
  POP HL                  ;GET INITIAL LINE #
  LD (AUTLIN),HL          ;SAVE IN INTIAL LINE
  POP BC                  ;GET RID OF NEWSTT ADDR
  JP PROMPT               ;JUMP INTO MAIN CODE (FOR REST SEE AFTER MAIN:)


; 'IF'..'THEN' BASIC code
__IF:
  CALL EVAL               ; Evaluate expression (FORMULA)
  LD A,(HL)               ; Get token
  CP ','                  ; "," GET TERMINATING CHARACTER OF FORMULA
  CALL Z,CHRGTB           ; IF SO SKIP IT
  CP TK_GOTO              ; "GOTO" token?
  JR Z,IFGO               ; Yes - Get line
  CALL SYNCHR             ; Make sure it's "THEN"
  DEFB TK_THEN            ; "THEN" token
  DEC HL                  ; Cancel increment
IFGO:
  PUSH HL                 ; SAVE THE TEXT POINTER
  CALL VSIGN              ; Test state of expression        
  POP HL                  ; GET BACK THE TEXT POINTER
  JR Z,FALSE_IF           ; False - Drop through, HANDLE POSSIBLE "ELSE"
DOCOND:
  CALL CHRGTB             ; PICK UP THE FIRST LINE # CHARACTER
  RET Z                   ; Go to NEWSTT (RUNCNT) if end of STMT (RETURN FOR "THEN :" OR "ELSE :")
  CP LINCON               ; Line number prefix ?
  JP Z,__GOTO             ; Yes - GOTO that line
  CP PTRCON               ; POINTER CONSTANT
  JP NZ,ONJMP             ; Otherwise do statement (EXECUTE STATEMENT, NOT GOTO)
  LD HL,(CONLO)           ; GET TEXT POINTER
  RET                     ; FETCH NEW STATMENT

;
; "ELSE" HANDLER. HERE ON FALSE "IF" CONDITION
;
FALSE_IF:
  LD D,$01                ;NUMBER OF "ELSE"S THAT MUST BE SEEN.
                          ;"DATA" INCREMENTS THIS COUNT EVERY TIME AN "IF" IS SEEN
SKPMRF:
  CALL __DATA             ;SKIP A STATEMENT
  ;":" IS STUCK IN FRONT OF "ELSE"S SO THAT "DATA" WILL STOP BEFORE "ELSE" CLAUSES
  OR A                    ;END OF LINE?
  RET Z                   ;IF SO, NO "ELSE" CLAUSE
  CALL CHRGTB             ;SEE IF WE HIT AN "ELSE"
  CP TK_ELSE
  JR NZ,SKPMRF            ;NO, STILL IN THE "THEN" CLAUSE
  DEC D                   ;DECREMENT THE NUMBER OF "ELSE"S THAT MUST BE SEEN
  JR NZ,SKPMRF            ;SKIP MORE IF HAVEN'T SEEN ENOUGH
  JR DOCOND               ;FOUND THE RIGHT "ELSE" -- GO EXECUTE


IF ZXPLUS3
PRINT_AT:
  CALL FPSINT
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  EX DE,HL
  LD A,50
  CPL
  INC A
  LD C,A
  LD B,$FF
  LD E,B
PRINT_AT_0:
  INC E
  LD D,L
  ADD HL,BC
  JR C,PRINT_AT_0
  LD A,50
  INC D
  CP D
  JP C,FC_ERR
  LD A,23
  INC E
  CP E
  JP C,FC_ERR
  EX DE,HL	; cursor coordinates
  CALL POSIT
  LD A,H
  DEC A
  LD (TTYPOS),A		; Current horizontal position of cursor (0-39)
  POP HL
  RET
ENDIF


; 'LPRINT' BASIC command
__LPRINT:
  LD A,$01                ;SAY NON ZERO
  LD (PRTFLG),A           ;SAVE AWAY
  JR MRPRNT               ; a.k.a. NEWCHR

; 'PRINT' BASIC command
__PRINT:
  LD C,$02                ;SETUP OUTPUT FILE
  CALL FILGET             ; Look for '#' channel specifier and put the associated file buffer in BC


; This Syntax variant was enabled on the Tandy Radio Shack models.
; It required a single parameter to position the cursor on the screen
; wrapping up the display rows into a single virtual vector.
; Working on it to adjust programs coming from computers with a different 
; text resolution would probably be more difficult than fiddling with LOCATE.

;IF VT52
;  CP '@'
;  CALL Z,PRINT_AT
;ENDIF

IF ZXPLUS3
  CP '@'
  CALL Z,PRINT_AT
ENDIF


; This entry point is used by the routines at __LPRINT and PRNTNB.
MRPRNT:
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL CHRGTB             ; GET ANOTHER CHARACTER
  CALL Z,OUTDO_CRLF       ; CRLF if just PRINT    (IF END WITHOUT PUNCTUATION)
; This entry point is used by the routine at NEXITM.
PRNTLP:
  JP Z,FINPRT             ; End of list - Exit (FINISH BY RESETTING FLAGS)
                          ; IN WHICH CASE A TERMINATOR DOES NOT MEAN WE SHOULD TYPE A CRLF BUT JUST RETURN
  CP TK_USING                                             ;IS IT "PRINT USING" ?
  JP Z,__USING                                            ;IF SO, USE A SPECIAL HANDLER
  CP TK_TAB               ; "TAB(" token?                 
  JP Z,__TAB              ; Yes - Do TAB routine          ;THE TAB FUNCTION?
  CP TK_SPC               ; "SPC(" token?                 
  JP Z,__TAB              ; Yes - Do SPC routine          ;THE SPC FUNCTION?
  PUSH HL                 ; Save code string address      ;SAVE THE TEXT POINTER
  CP ','                  ; Comma?                        ;IS IT A COMMA?
  JR Z,DOCOM              ; Yes - Move to next zone
  CP ';'                  ; Semi-colon?                   ;IS IT A ";"
  JP Z,NEXITM             ; Do semi-colon routine
  POP BC                  ; Code string address to BC     ;GET RID OF OLD TEXT POINTER
  CALL EVAL               ; Evaluate expression           ;EVALUATE THE FORMULA
  PUSH HL                 ; Save code string address      ;SAVE TEXT POINTER
  CALL GETYPR             ; Get the number type (FAC)     ;SEE IF WE HAVE A STRING
  JR Z,PRNTST             ; JP If string type             ;IF SO, PRINT SPECIALY
  CALL FOUT               ; Convert number to text        ;MAKE A NUMBER INTO A STRING
  CALL CRTST              ; Create temporary string       ;MAKE IT  A STRING
  LD (HL),' '             ; Followed by a space           ;PUT A SPACE AT THE END
  LD HL,(FACCU)           ; Get length of output          ;AND INCREASE SIZE BY 1
  INC (HL)                ; Plus 1 for the space          ;SIZE BYTE IS FIRST IN DESCRIPTOR

; Output string contents (a.k.a. STRDON)
; USE FOLDING FOR STRINGS AND #S
;
; Used by the routine at __PRINT.
PRNTST:
  CALL ISFLIO             ;DISK OUTPUT?  IF SO, DON'T EVER FORCE A CRLF
  JR NZ,LINCH2
  LD HL,(FACCU)           ;GET THE POINTER
  LD A,(PRTFLG)
  OR A
  JR Z,ISTTY              ;LPT OR TTY?
  LD A,(LPTSIZ)           ; GET WIDTH OF PRINTER
  LD B,A                  ; SAVE IN [B]
  INC A                   ; IS IT INFINITE? (255="infinite")
  JR Z,LINCH2             ; THEN JUST PRINT
  LD A,(LPTPOS)           ; Get cursor position
  OR A                    ; DON'T DO A CRLF IF STRING LONGER THAN LINE
  JR Z,LINCH2             ; LENGTH IF POSITION IS 0
  ADD A,(HL)              ; Add length of string
  CCF                     ; SET NC IF OVERFLOW ON CHECK
  JR NC,PRNTNB            ; START ON A NEW LINE
  DEC A                   ; Adjust it
  CP B                    ; Will output fit on this line?
  JR PRNTNB

ISTTY:
  LD A,(LINLEN)           ; Get width of line
  LD B,A                  ; To B
  INC A                   ; NO OVERFLOW LINE WIDTH?
  JR Z,LINCH2             ; YES
  LD A,(TTYPOS)           ; Get cursor position             ; SEE WHERE WE ARE
  OR A                    ; DON'T DO CRLF
  JR Z,LINCH2             ; IF ALREADY AT 0 EVEN IF STRING IS LONGER THAT LINE LENGTH
  ADD A,(HL)              ; Add length of string  			; ADD THIS LENGTH
  CCF                     ; SET NC IF OVERFLOW ON CHECK
  JR NC,PRNTNB            ; (POSSIBLE SINCE STRINGS CAN BE BIG..)
  DEC A                   ; Adjust it ACTUALLY EQUAL TO LINE LENGTH IS OK
  CP B                    ; Will output fit on this line?

; Output number string
;
; Used by the routine at PRNTST.
PRNTNB:
  CALL NC,OUTDO_CRLF      ;IF SO CRLF
; This entry point is used by the routine at PRNTST.
LINCH2:
  CALL PRS1               ; Output string at (HL)             ;PRINT THE NUMBER
  POP HL                  ; Restore code string address
  JR MRPRNT               ; See if more to PRINT              ;PRINT SOME MORE

; This entry point is used by the routine at __PRINT.
DOCOM:
  LD BC,$0028             ; (NMLO.C) if file output, SPECIAL PRINT POSITION SHOULD BE FETCHED FROM FILE DATA
  LD HL,(PTRFIL)          
  ADD HL,BC               ;[H,L] POINT AT POSITION
  CALL ISFLIO             ;OUTPUTING INTO A FILE?
  LD A,(HL)               ;IF FILE IS ACTIVE
  JR NZ,ZONELP 
  LD A,(PRTFLG)           ;OUTPUT TO THE LINE PRINTER?
  OR A                    ;NON-ZERO MEANS YES
  JR Z,ISCTTY             ;NO, DO TELETYPE COMMA
  LD A,(COMMAN)           ; Get comma width   (NLPPOS)
  LD B,A                  ; Save in B
  INC A                   ;TEST
  LD A,(LPTPOS)           ;GET LINE PRINTER POSITION
  JR Z,ZONELP             ;ALWAYS DO MODULUS IF WIDTH=255
  CP B                    ;CHECK IF NO MORE COMMA FIELDS
  JR CHKCOM               ;USE TELETYPE CHECK

ISCTTY:
  LD A,(NCMPOS)           ; Get comma width             ;POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS
  LD B,A                  ; Save in B
  LD A,(TTYPOS)           ; Get current position        ;GET TELETYPE POSITION
  CP $FF                  ;INFINITE WIDTH?
  JR Z,ZONELP             ;DO MODULUS
  ;<- extra code here with MBASIC versions with a "TERMINAL WIDTH" QUESTION
  CP B                    ; Within the limit?
CHKCOM:
  CALL NC,OUTDO_CRLF      ; No - output CRLF            ;TYPE CRLF
  JP NC,NEXITM            ; Get next item               ;AND QUIT IF BEYOND THE LAST COMMA FIELD

; a.k.a MORCOM
ZONELP:
  SUB CLMWID              ; Next zone of 14 characters
  JR NC,ZONELP            ; Repeat if more zones
  CPL                     ; Number of spaces to output
                          ; WE WANT TO  FILL THE PRINT POSITION OUT TO AN EVEN CLMWID,
                          ; SO WE PRINT CLMWID-[A] MOD CLMWID SPACES
  JR ASPCS                ; Output them              ;GO PRINT [A]+1 SPACES

; PRINT TAB( or PRINT SPC(
;
; Used by the routine at __PRINT.
__TAB:
  PUSH AF                 ; Save token                  ;REMEMBER IF [A]=SPCTK OR TABTK
  CALL CHRGTB             ; 
  CALL FPSINT_0           ; Evaluate expression         ;EVALUATE THE ARGUMENT
  POP AF                  ; Restore token               ;SEE IF ITS SPC OR TAB
  PUSH AF                 ; Save token
  CP TK_SPC               ; TK_SPC - Was it "SPC(" ?    ;IF SPACE LEAVE ALONE
  JR Z,__SPC
  DEC DE                  ;OFFSET BY 1
__SPC:
  LD A,D
  OR A                    ;MAKE SURE ITS NOT NEGATIVE
  JP P,__TAB_0
  LD DE,$0000
__TAB_0:
  PUSH HL                 ;SAVE THE TEXT POINTER
  CALL ISFLIO             ;SEE IF GOING TO DISK FILE
  JR NZ,LNOMOD            ;DONT MOD
  LD A,(PRTFLG)           ;GOING TO PRINTER?
  OR A                    ;SET FLAGS
  LD A,(LPTSIZ)           ;GET SIZE
  JR NZ,LPTMDF            ;WAS LPT, MOD BY ITS SIZE
  LD A,(LINLEN)           ;GET THE LINE LENGTH
LPTMDF:
  LD L,A
  INC A                   ;TEST FOR WIDTH OF 255 (NO FOLDING)
  JR Z,LNOMOD             ;IF SO, DONT MOD
  LD H,$00                ;MOD OUT BY LINE LENGTH
  CALL IMOD
  EX DE,HL                ;SET [E] = POSITION TO GO TO 

; TAB/SPC routine
;
; Used by the routine at __TAB.
LNOMOD:
  POP HL                  ;GET BACK THE TEXT POINTER
  CALL SYNCHR
  DEFM ")"                ; Make sure ")" follows
  DEC HL                  ; Back space on to ")"
  POP AF                  ; Restore token                    ;GET BACK SPCTK OR TABTK
  SUB TK_SPC              ; Was it "SPC(" ?                  ;WAS IT SPCTK?
  PUSH HL                 ; Save code string address         ;SAVE THE TEXT POINTER
  JR Z,DOSPC              ; Yes - Do "E" spaces              ;VALUE IN [A]
  LD BC,$0028             ; (NMLO.C) if file output, SPECIAL PRINT POSITION SHOULD BE FETCHED FROM FILE DATA
  LD HL,(PTRFIL)
  ADD HL,BC               ;[H,L] POINT AT POSITION
  CALL ISFLIO             ;OUTPUTING INTO A FILE?  (IF SO, [PTRFIL] .NE. 0)
  LD A,(HL)               ;IF FILE IS ACTIVE
  JR NZ,DOSPC             ;DO TAB CALCULATION NOW
  LD A,(PRTFLG)           ;LINE PRINTER OR TTY?
  OR A                    ;NON-ZERO MEANS LPT
  JR Z,TTYIST
  LD A,(LPTPOS)           ; Get current printer position     ;GET LINE PRINTER POSITION
  JR DOSPC

TTYIST:
  LD A,(TTYPOS)           ; Get current position        ;GET TELETYPE PRINT POSITION
DOSPC:
  CPL                     ; Number of spaces to print to   ;PRINT [E]-[A] SPACES
  ADD A,E                 ; Total number to print
  JR C,ASPCS                                               ;PRINT IF PAST CURRENT
  INC A
  JR Z,NEXITM             ;DO NOTHING IF AT CURRENT
  CALL OUTDO_CRLF         ;GO TO A NEW LINE
  LD A,E                  ;GET THE POSITION TO GO TO
  DEC A
  JP M,NEXITM
; This entry point is used by the routine at PRNTNB.
ASPCS:
  INC A                   ; Output A spaces
  LD B,A                  ; Save number to print        ;[B]=NUMBER OF SPACES TO PRINT
  LD A,' '                ; Space                       ;[A]=SPACE
SPCLP:
  CALL OUTDO              ; Output character in A       ;PRINT [A]
  ;DEC B                   ; Count them                  ;DECREMENT THE COUNT
  DJNZ SPCLP             ; Repeat if more

; Move to next item in the PRINT list
;
; Used by the routines at __PRINT, PRNTNB and LNOMOD.
NEXITM:
  POP HL                  ; Restore code string address     ;PICK UP TEXT POINTER
  CALL CHRGTB             ; Get next character              ;AND THE NEXT CHARACTER
  ;AND SINCE WE JUST PRINTED SPACES, DON'T CALL CRDO IF IT'S THE END OF THE LINE
  JP PRNTLP               ; More to print

; Routine at 6144
;
; Used by the routines at __PRINT, LTSTND, __LOF, __LOAD, CAYSTR, NOTSCI and
; STKERR.
;
;FINISH 'PRINT' BY RESETTING FLAGS
;(IN WHICH CASE A TERMINATOR DOES NOT MEAN WE SHOULD TYPE A CRLF BUT JUST RETURN)
FINPRT:
  XOR A
  LD (PRTFLG),A
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD H,A                  ;[H,L]=0
  LD L,A
  LD (PTRFIL),HL          ;ZERO OUT PTRFIL  (disabling eventual output redirection)
  POP HL                  ;GET BACK THE TEXT POINTER
  RET

; 'LINE INPUT' BASIC command
__LINE:

IF HAVE_GFX
  CP TK_INPUT       ; ? Token for INPUT to support the "LINE INPUT" statement ?
  JP NZ,LINE        ; No, this is a real graphics command !
ENDIF

  CALL SYNCHR
  DEFB TK_INPUT
  CP '#'                  ;SEE IF THERE IS A FILE NUMBER
  JP Z,LINE_INPUT         ;DO DISK INPUT LINE
  CALL SCNSEM             ;SCAN SEMICOLON FOR NO-CR
  CALL __INPUT_0          ;PRINT QUOTED STRING IF ONE
  CALL GETVAR             ;READ STRING TO STORE INTO
  CALL TSTSTR             ;MAKE SURE ITS A STRING
  PUSH DE                 ;SAVE POINTER AT VARIABLE
  PUSH HL                 ;SAVE TEXT POINTER
  CALL INLIN              ;READ A LINE OF INPUT
  POP DE                  ;GET TEXT POINTER
  POP BC                  ;GET POINTER AT VARIABLE
  JP C,INPBRK             ;IF CONTROL-C, STOP
  PUSH BC                 ;SAVE BACK VARIABLE POINTER
  PUSH DE                 ;SAVE TEXT POINTER
  LD B,$00                ;SETUP ZERO AS ONLY TERMINATOR
  CALL QTSTR_0            ;LITERALIZE THE INPUT
  POP HL                  ;RESTORE [H,L]=TEXT POINTER
  LD A,$03                ;SET THREE FOR STRING
  JP __LET_0              ;DO THE ASSIGNMENT

; Message at 6200
REDO_MSG:
  DEFM "?Redo from start"
  DEFB $0D
  DEFB $0A
  DEFB $00

; 06219
;
; a.k.a. BADINP
; HERE WHEN PASSING OVER STRING LITERAL IN SUBSCRIPT OF VARIABLE IN INPUT LIST
; ON THE FIRST PASS OF INPUT CHECKING FOR TYPE MATCH AND NUMBER
;
; Used by the routine at NOTQTI.
SCNSTR:
  INC HL              ;LOOK AT THE NEXT CHARACTER
  LD A,(HL)           ;FETCH IT
  OR A                ;END OF LINE?
  JP Z,SN_ERR         ;ENDING IN STRING IN SUBSCRIPT IS BAD SYNTAX
  CP '"'              ;ONLY OTHER TERMINATOR IS QUOTE
  JR NZ,SCNSTR        ;CONTINUE UNTIL QUOTE OR 0 IS FOUND
  JP SCNCON           ;CONTINUE MATCHING PARENS SINCE STRING ENDED

; This entry point is used by the routine at NOTQTI.
INPBAK:
  POP HL              ;GET RID OF PASS1 DATA POINTER
  POP HL              ;GET RID OF PASS2 DATA POINTER
  JR RDOIN2           ;GET RID OF PASS2 VARLST POINTER AND RETRY

;
; HERE WHEN THE DATA THAT WAS TYPED IN OR IN "DATA" STATEMENTS
; IS IMPROPERLY FORMATTED. FOR "INPUT" WE START AGAIN.
; FOR "READ" WE GIVE A SYNTAX ERROR AT THE DATA LINE
;
; This entry point is used by the routine at LTSTND.
TRMNOK:
  LD A,(FLGINP)       ; READ or INPUT?                  ;WAS IT READ OR INPUT?
  OR A                ;                                 ;ZERO=INPUT
  JP NZ,DATSNR        ; READ - ?SN Error                ;GIVE ERROR AT DATA LINE
; This entry point is used by the routine at NOTQTI.
RDOIN2:
  POP BC              ; Throw away code string addr     ;GET RID OF THE POINTER INTO THE VARIABLE LIST
  LD HL,REDO_MSG
  CALL PRS            ;PRINT "?REDO FROM START" TO NEWSTT POINTING AT THE START OF
  LD HL,(SAVTXT)      ;START ALL OVER: GET SAVED TEXT POINTER
  RET                 ;GO BACK TO NEWSTT 
                      ;OF THE "INPUT" STATEMENT

; INPUT #, set stream number (input channel)
; "set input channel"
;
; Used by the routine at __INPUT.
FILSTI:
  CALL FILINP
  PUSH HL             ;PUT THE TEXT POINTER ON THE STACK
  LD HL,BUFMIN        ;POINT AT A COMMA
  JP INPUT_CHANNEL    ; 'INPUT' from a stream

; 'INPUT' BASIC command
__INPUT:
  CP '#'
  JR Z,FILSTI             ; "set input channel"
  CALL SCNSEM             ;SCAN SEMICOLON FOR NO-CR
  LD BC,NOTQTI            ;WHERE TO GO
  PUSH BC                 ;WHEN DONE WITH QUOTED STRING
; This entry point is used by the routine at __LINE.
__INPUT_0:
  CP '"'                  ; Is there a prompt string?    ;IS IT A QUOTE?
  LD A,$00                ; Clear A and leave flags      ;BE TALKATIVE
  LD (CTLOFG),A           ; Enable output                ;FORCE OUTPUT
  LD A,$FF                ;MAKE NON-ZERO VALUE
  LD (IMPFLG),A           ;FLAG TO DO "? "
  RET NZ                  ;not a quote.. JUST RETURN
  CALL QTSTR              ;MAKE THE MESSAGE A STRING
  LD A,(HL)               ;GET CHAR
  CP ','                  ;COMMA?
  JR NZ,NTICMA            ;NO
  XOR A                   ;FLAG NOT TO DO IT
  LD (IMPFLG),A
  CALL CHRGTB             ;FETCH NEXT CHAR
  JR __INPUT_2            ;CONTINUE

NTICMA:
  CALL SYNCHR
  DEFM ";"                ;MUST END WITH SEMI-COLON
__INPUT_2:
  PUSH HL                 ; Save code string address     ;REMEMBER WHERE IT ENDED
  CALL PRS1               ; Output prompt string
  POP HL                  ; Restore code string address    ;GET BACK SAVED TEXT PTR
  RET                     ;ALL DONE

; NOTQTI
NOTQTI:
  PUSH HL                   ; Save code string address
  LD A,(IMPFLG)             ;DO "? "
  OR A
  JR Z,SUPPRS             ;THEN SUPPRESS "?"
  LD A,'?'                  ;TYPE "?" AND INPUT A LINE OF TEXT    ; Get input with "? " prompt
  CALL OUTDO                ; Output character
  LD A,' '                  ; Space
  CALL OUTDO                ; Output character
SUPPRS:
  CALL INLIN                ; Get input line
  POP BC                    ; Restore code string address      ;TAKE OFF SINCE MAYBE LEAVING
  JP C,INPBRK                                                  ;IF EMPTY LEAVE
  PUSH BC                   ; Re-save code string address      ;PUT BACK SINCE DIDN'T LEAVE

;
; THIS IS THE FIRST PASS DICTATED BY ANSI REQUIRMENT THAN NO VALUES BE ASSIGNED 
; BEFORE CHECKING TYPE AND NUMBER. THE VARIABLE LIST IS SCANNED WITHOUT EVALUATING
; SUBSCRIPTS AND THE INPUT IS SCANNED TO GET ITS TYPE. NO ASSIGNMENT IS DONE
;
  XOR A
  LD (FLGINP),A
  LD (HL),','               ;PUT A COMMA IN FRONT OF BUF    (Store comma as separator)
  EX DE,HL                  ;SAVE DATA POINTER IN [D,E]
  POP HL                    ;GET THE VARLST POINTER INTO [H,L]
  PUSH HL                   ;RESAVE THE VARLST POINTER
  PUSH DE                   ;SAVE A COPY OF THE DATA POINTER FOR PASS2
  PUSH DE                   ;SAVE THE DATA POINTER FOR PASS1
  DEC HL                    ;READ THE FIRST VARIABLE NAME

VARLOP:
  LD A,128                  ;DON'T ALLOW SUBSCRIPTS -- RETURN POINTING TO "("
  LD (SUBFLG),A
  CALL CHRGTB               ;ADVANCE TEXT POINTER
  CALL PTRGET               ;SCAN NAME AND RETURN POINTER IN [D,E]
  LD A,(HL)                 ;SEE IF IT ENDED ON "("
  DEC HL                    ;RESCAN THE TERMINATOR
  CP '['
  JR Z,HAVE_ARRAY
  CP '('                    ;ARRAY OR NOT?
  JR NZ,ENDSCN              ;IF NOT, VARIABLE NAME IS DONE
HAVE_ARRAY:
  INC HL                    ;NOW SCAN THE SUBSCRIPT EXPRESSION
  LD B,$00                  ;INITIALIZE THE PAREN COUNT
SCNOPN:
  INC B                     ;UP THE COUNT FOR EVERY "("
; This entry point is used by the routine at SCNSTR.
SCNCON:
  CALL CHRGTB               ;GET THE NEXT CHARACTER
  JP Z,SN_ERR               ;SHOULDN'T END STATEMENT IN EXPRESSION
  CP '"'                    ;IS THERE A QUOTED STRING CONSTANT
  JP Z,SCNSTR               ;GO SCAN THE ENDTIRE CONSTANT (MAY CONTAIN PARENS)
  CP '('                    ;ANOTHER LEVEL OF NESTING?
  JR Z,SCNOPN               ;INCREMENT COUTN AND KEEP SCANNING
  CP '['
  JR Z,SCNCON
  CP ']'
  JR Z,SQ_PAREN
  CP ')'                    ;ONE LESS LEVEL OF PARENS?
  JR NZ,SCNCON              ;NO, KEEP SCANNING
SQ_PAREN:
  ;DEC B                     ;DECREMENT PAREN COUNT. OUT OF SUBSCRIPT?
  DJNZ SCNCON              ;IF NOT AT ZERO LEVEL, KEEP SCANNING
ENDSCN:
  CALL CHRGTB               ;GET TERMINATING CHARACTER
  JR Z,OKVLST               ;LAST VARIABLE IN INPUT LIST
  CP ','                    ;OTHERWISE IT MUST BE A COMMA
  JP NZ,SN_ERR              ;BADLY FORMED INPUT -- SYNTAX ERROR
OKVLST:
  EX (SP),HL                ;SAVE THE VARLST POINTER <> GET THE DATA POINTER INTO [H,L]
  LD A,(HL)                 ;DATA SHOULD ALWAYS HAVE A LEADING COMMA
  CP ','                    ;IS IT PROPERLY FORMED?
  JP NZ,INPBAK              ;NO, ASK FOR COMPLETE REINPUT
  LD A,$01                  ;SET OVCSTR=1
  LD (OVCSTR),A
  CALL SCNVAL               ;GO INTO PASS2 CODE AND SCAN A VALUE
  LD A,(OVCSTR)             ;SEE IF IT WAS TOO BIG
  DEC A
  JP NZ,INPBAK
  PUSH HL                   ;SAVE THE RETURNED DATA POINTER
  CALL GETYPR               ;RELEASE STRING
  CALL Z,GSTRCU
  POP HL
  DEC HL                    ;SKIP OVER SPACES LEFT AFTER VALUE SCAN
  CALL CHRGTB

;
; NOTE CHECK FOR OVERFLOW OF INPUT VALUE HERE
;
  EX (SP),HL                ;SAVE THE DATA POINTER <> [H,L]=DATA LIST POINTER
  LD A,(HL)                 ;DID VARIABLE LIST CONTINUE?
  CP ','                    ;MUST HAVE HAD A COMMA
  JR Z,VARLOP               ;GO CHECK ANOTHER
  POP HL                    ;GET FINAL DATA POINTER
  DEC HL                    ;SKIP OVER ANY TRAILING SPACES
  CALL CHRGTB
  OR A                      ;IS IT A TRUE END?
  POP HL                    ;GET THE START OF DATA POINTER FOR PASS2
  JP NZ,RDOIN2              ;IF DATA ENDED BADLY ASK FOR REINPUT

; 'INPUT' from a stream
;
; Used by the routine at FILSTI.
INPUT_CHANNEL:
  LD (HL),','               ;SETUP COMMA AT BUFMIN
  JR INPCON

; 'READ' BASIC command
__READ:
  PUSH HL                 ; Save code string address      ;SAVE THE TEXT POINTER
  LD HL,(DATPTR)          ; Next DATA statement           ;GET LAST DATA LOCATION
  
  DEFB $F6                ; OR AFh ..Flag "READ"          ;"ORI" TO SET [A] NON-ZERO
  
; This entry point is used by the routine at INPUT_CHANNEL.
INPCON:
  XOR A                   ; Flag "INPUT"                  ;SET FLAG THAT THIS IS AN INPUT
  LD (FLGINP),A           ; Save "READ"/"INPUT" flag      ;STORE THE FLAG
;
; IN THE PROCESSING OF DATA AND READ STATEMENTS:
; ONE POINTER POINTS TO THE DATA (IE THE NUMBERS BEING FETCHED)
; AND ANOTHER POINTS TO THE LIST OF VARIABLES
;
; THE POINTER INTO THE DATA ALWAYS STARTS POINTING TO A
; TERMINATOR -- A , : OR END-OF-LINE
;
  EX (SP),HL              ; Get code str' , Save pointer  ;[H,L]=VARIABLE LIST POINTER <> DATA POINTER GOES ON THE STACK
  JR GTVLUS               ; Get values

; This entry point is used by the routine at LTSTND.
LOPDT2:
  CALL SYNCHR             ; Check for comma between items
  DEFM ","                ;MAKE SURE THERE IS A ","

; a.k.a. LOPDAT
GTVLUS:
  CALL GETVAR             ;READ THE VARIABLE LIST AND GET THE POINTER TO A VARIABLE INTO [D,E]
                          ;PUT THE VARIABLE LIST POINTER ONTO THE STACK AND TAKE THE DATA LIST POINTER OFF
  EX (SP),HL              ; Save code str" , Get pointer
;
; NOTE AT THIS POINT WE HAVE A VARIABLE WHICH WANTS DATA
; AND SO WE MUST GET DATA OR COMPLAIN
;
  PUSH DE                 ; SAVE THE POINTER TO THE VARIABLE WE ARE ABOUT TO SET UP WITH A VALUE
  ;SINCE THE DATA LIST POINTER ALWAYS POINTS AT A TERMINATOR LETS READ THE TERMINATOR INTO [A] AND SEE WHAT IT IS
  LD A,(HL)               ; Get next "INPUT"/"DATA" byte
  CP ','                  ; Comma?
  JR Z,ANTVLU             ; Yes - Get another value       ;A COMMA SO A VALUE MUST FOLLOW
  LD A,(FLGINP)           ; Is it READ?                   ;SEE WHAT TYPE OF STATEMENT THIS WAS
  OR A
  JR NZ,FDTLP             ; Yes - Find next DATA stmt     ;SEARCH FOR ANOTHER DATA STATEMENT

;THE DATA NOW STARTS AT THE BEGINNING OF THE BUFFER
;AND QINLIN LEAVES [H,L]=BUF

; a.k.a. DATBK
; This entry point is used by the routine at FDTLP.
ANTVLU:
  DEFB $F6                ; OR AFh ..hides the "XOR A" instruction    ;SET A NON-ZERO

; This entry point is used by the routine at NOTQTI.
SCNVAL:
  XOR A                   ; SET ZERO FLAG IN [A]
  LD (READFLG),A          ; STORE SO EARLY RETURN CHECK WORKS
  CALL ISFLIO             ; SEE IF A FILE READ
  JP NZ,FILIND            ; IF SO, SPECIAL HANDLING
  CALL GETYPR             ; IS IT A STRING?
  PUSH AF                 ; SAVE THE TYPE INFORMATION
;
; IF NUMERIC, USE FIN TO GET IT
; ONLY THE VARAIBLE TYPE IS CHECKED SO AN UNQUOTED STRING CAN BE ALL DIGITS
;
  JR NZ,INPBIN            ; If numeric, convert to binary

  CALL CHRGTB             ; Get next character
  LD D,A                  ; Save input character            ;ASSUME QUOTED STRING
  LD B,A                  ; Again                           ;SETUP TERMINATORS
  CP '"'                  ; Start of literal sting?         ;QUOTE ?
  JR Z,STRENT             ; Yes - Create string entry       ;TERMINATORS OK
  LD A,(FLGINP)           ; "READ" or "INPUT" ?             ;INPUT SHOULDN'T TERMINATE ON ":"
  OR A                                                      ;SEE IF READ OR INPUT
  LD D,A                  ; Save 00 if "INPUT"              ;SET D TO ZERO FOR INPUT
  JR Z,ITMSEP             ; "INPUT" - End with 00
  LD D,':'                ; "DATA" - End with 00 or ":"     ;UNQUOTED STRING TERMINATORS
ITMSEP:
  LD B,','                ; ARE COLON AND COMMA
                          ; NOTE: ANSI USES [B]=44 AS A FLAG TO TRIGGER TRAILING SPACE SUPPRESSION

  DEC HL                  ; Back space for DTSTR
                          ; BACKUP SINCE START CHARACTER MUST BE INCLUDED
                          ; IN THE QUOTED STRING CASE WE DON'T WANT TO
                          ; INCLUDE THE STARTING OR ENDING QUOTE

; a.k.a. NOWGET
STRENT:
  ;MAKE A STRING DESCRIPTOR FOR THE VALUE AND COPY IF NECESSARY
  CALL DTSTR              ; Get string terminated by D

DOASIG:
  POP AF                  ;POP OFF THE TYPE INFORMATION
  ADD A,$03               ;MAKE VALTYPE CORRECT
  LD C,A                  ;SAVE VALUE TYPE IN [C]
  LD A,(READFLG)          ;SEE IF SCANNING VALUES FOR PASS1
  OR A                    ;ZERO FOR PASS1
  RET Z                   ;GO BACK TO PASS1
  LD A,C                  ;RECOVER VALTYP
  EX DE,HL                ;[D,E]=TEXT POINTER
  LD HL,LTSTND            ;RETURN LOC
  EX (SP),HL              ;[H,L]=PLACE TO STORE VARIABLE VALUE
  PUSH DE                 ;TEXT POINTER GOES ON
  JP __LET_1              ;DO ASSIGNMENT

; This entry point is used by the routine at __READ.
; a.k.a. NUMINS
INPBIN:
  CALL CHRGTB             ; Get next character
  POP AF                  ; GET BACK VALTYPE OF SOURCE
  PUSH AF                 ; SAVE BACK
  LD BC,DOASIG            ; ASSIGNMENT IS COMPLICATED EVEN FOR NUMERICS SO USE THE "LET" CODE
  PUSH BC                 ; SAVE ON STACK
  JP C,FIN                ; IF NOT DOUBLE, CALL USUAL # INPUTTER
  JP FIN_DBL              ; ELSE CALL SPECIAL ROUTINE WHICH EXPECTS DOUBLES

; Where to go after LETSTR
LTSTND:
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL CHRGTB             ; Get next character
  JR Z,MORDT              ; End of line - More needed?
  CP ','                  ; Another value?
  JP NZ,TRMNOK            ; No - Bad input           ;ENDED PROPERLY?

MORDT:
  EX (SP),HL              ; Get code string address
  DEC HL                  ; DEC 'cos GETCHR INCs     ;LOOK AT TERMINATOR
  CALL CHRGTB             ; Get next character       ;AND SET UP CONDITION CODES
  JR NZ,LOPDT2            ; More needed - Get it     ;NOT ENDING, CHECK FOR COMMA AND GET
                                                     ;ANOTHER VARIABLE TO FILL WITH DATA
  POP DE                  ; Restore DATA pointer     ;POP OFF THE POINTER INTO DATA
  LD A,(FLGINP)           ; "READ" or "INPUT" ?      ;FETCH THE STATEMENT TYPE FLAG
  OR A
				;INPUT STATEMENT
  EX DE,HL                ; DATA pointer to HL
  JP NZ,UPDATA            ; Update DATA pointer if "READ"      ;UPDATE DATPTR
  PUSH DE                 ; Move code string address           ;SAVE THE TEXT POINTER
  POP HL                  ; .. to HL                           ;GET BACK THE TEXT POINTER
  JP FINPRT


; Find next DATA statement
;
; THE SEARCH FOR DATA STATMENTS IS MADE BY USING THE EXECUTION CODE
; FOR DATA TO SKIP OVER STATEMENTS. THE START WORD OF EACH STATEMENT
; IS COMPARED WITH $DATA. EACH NEW LINE NUMBER
; IS STORED IN DATLIN SO THAT IF AN ERROR OCCURS WHILE READING
; DATA THE ERROR MESSAGE WILL GIVE THE LINE NUMBER OF THE 
; ILL-FORMATTED DATA
;
; a.k.a. DATLOP
; Used by the routine at __READ.
FDTLP:
  CALL __DATA             ; Get next statement
  OR A                    ; End of line?
  JR NZ,FANDT             ; No - See if DATA statement
  INC HL
  LD A,(HL)               ; End of program?
  INC HL
  OR (HL)                 ; 00 00 Ends program
  LD E,$04                ; Err $04 - "Out of DATA" (?OD Error)   ;NO DATA IS ERROR ERROD
  JP Z,ERROR              ; Yes - Out of DATA                     ;IF SO COMPLAIN
  INC HL                                                          ;SKIP PAST LINE #
  LD E,(HL)               ; LSB of line number                    ;GET DATA LINE #
  INC HL
  LD D,(HL)               ; MSB of line number
  LD (DATLIN),DE          ; Set line of current DATA item
FANDT:
  CALL CHRGTB             ; Get next character               ;GET THE STATEMENT TYPE
  CP TK_DATA              ; "DATA" token                     ;IS IS "DATA"?
  JR NZ,FDTLP             ; No "DATA" - Keep looking         ;NOT DATA SO LOOK SOME MORE
  JP ANTVLU               ; Found - Convert input            ;CONTINUE READING

; Routine at 6670
;
;	FORMULA EVALUATION CODE
;
; THE FORMULA EVALUATOR STARTS WITH [H,L] POINTING TO THE FIRST CHARACTER OF THE FORMULA.
; AT THE END [H,L] POINTS TO THE TERMINATOR.
; THE RESULT IS LEFT IN THE FAC.
; ON RETURN [A] DOES NOT REFLECT THE TERMINATING CHARACTER
;
; THE FORMULA EVALUATOR USES THE OPERATOR TABLE (OPTAB) TO DETERMINE
; PRECEDENCE AND DISPATCH ADDRESSES FOR EACH OPERATOR.
;
; A TEMPORARY RESULT ON THE STACK HAS THE FOLLOWING FORMAT:
; - THE ADDRESS OF 'RETAOP' -- THE PLACE TO RETURN ON COMPLETION OF OPERATOR APPLICATION
; - THE FLOATING POINT TEMPORARY RESULT
; - THE ADDRESS OF THE OPERATOR ROUNTINE
; - THE PRECEDENCE OF THE OPERATOR
;
; TOTAL 10 BYTES
;
; Used by the routines at DOFN, __LSET and FN_INSTR.
FRMEQL:
  CALL SYNCHR
  DEFB TK_EQUAL       ; Token code for '='       ;CHECK FOR EQUAL SIGN
  JR EVAL                                            ;EVALUATE FORMULA AND RETURN

; Routine at 6677
;
; Used by the routines at EVLPAR, ISFUN and FN_INSTR.
OPNPAR:
  CALL SYNCHR         ; Make sure "(" follows
  DEFM "("            ;GET PAREN BEFORE FORMULA

; Routine at 6681
;
; Used by the routines at __FOR, FORFND, __LET, __IF, __PRINT, FRMEQL,
; DOFN, FPSINT, GETINT, __POKE, __RANDOMIZE, FNAME, __OPEN, FILGET, __WEND,
; __CHAIN, CAYSTR, NOTSCI, ISSTRF, FN_STRING and FN_INSTR.
; a.k.a. GETNUM, evaluate expression
EVAL:
  DEC HL              ; Evaluate expression & save          ;BACK UP CHARACTER POINTER
  
; This entry point is used by the routines at FORFND and __USING.
; a.k.a. LPOPER
EVAL_0:
  LD D,$00            ; Precedence value                    ;INITIAL DUMMY PRECEDENCE IS 0
  
; This entry point is used by the routines at _EVAL, MINUS and NOT.
EVAL_1:
  PUSH DE             ; Save precedence                     ;SAVE PRECEDENCE
  LD C,$01            ; Check for 1 level of stack          ;EXTRA SPACE NEEDED FOR RETURN ADDRESS
  CALL CHKSTK                                               ;MAKE SURE THERE IS ROOM FOR RECURSIVE CALLS
  CALL OPRND          ; Get next expression value           ;EVALUATE SOMETHING
  XOR A               ; RESET OVERFLOW PRINTING BACK TO NORMAL (SET TO 1 AT FUNDSP TO SUPPRESS
  LD (FLGOVC),A       ;                                               MULTIPLE OVERFLOW MESSAGES)

; Evaluate expression until precedence break
EVAL2:
  LD (NXTOPR),HL      ; Save address of next operator
; This entry point is used by the routine at NOT.

EVAL3:
  LD HL,(NXTOPR)      ; Restore address of next opr

  POP BC              ; Precedence value and operator       ;POP OFF THE PRECEDENCE OF OLDOP
  LD A,(HL)           ; Get next operator / function        ;GET NEXT CHARACTER
  LD (TEMP3),HL                                             ;SAVE UPDATED CHARACTER POINTER
  CP TK_GREATER       ; Token code for '>' (lower opr code) ;IS IT AN OPERATOR?
  RET C               ; NO, ALL DONE (THIS CAN RESULT IN OPERATOR APPLICATION OR ACTUAL RETURN)
  CP TK_MINOR+1       ; '<' +1  (higher opr code)           ;SOME KIND OF RELATIONAL?
  JR C,DORELS                                               ;YES, DO IT
  SUB TK_PLUS         ; Token code for '+'                  ;SUBTRAXDCT OFFSET FOR FIRST ARITHMETIC
  LD E,A              ; Coded operator                      ;MUST MULTIPLY BY 3 SINCE OPTAB ENTRIES ARE 3 LONG
  JR NZ,FOPRND        ; Function - Call it                  ;NOT ADDITION OP

  LD A,(VALTYP)       ; Get data type                       ;SEE IF LEFT PART IS STRING
  CP $03              ; String ?                            ;SEE IF ITS A STRING
  LD A,E              ; Coded operator                      ;REFETCH OP-VALUE
  JP Z,CONCAT         ; If so, string concatenation (use '+' to join strings)      ;MUST BE CAT
FOPRND:
  CP LSTOPK           ; HIGHER THAN THE LAST OP?            ;HIGHER THAN THE LAST OP?
  RET NC                                                    ;YES, MUST BE TERMINATOR
  LD HL,PRITAB        ; ARITHMETIC PRECEDENCE TABLE         ;CREATE INDEX INTO OPTAB
  LD D,$00                                                  ;MAKE HIGH BYTE OF OFFSET=0
  ADD HL,DE           ; To the operator concerned           ;ADD IN CALCULATED OFFSET
  LD A,B              ; Last operator precedence            ;[A] GETS OLD PRECEDENCE
  LD D,(HL)           ; Get evaluation precedence           ;REMEMBER NEW PRECEDENCE
  CP D                ; Compare with eval precedence        ;OLD-NEW
  RET NC              ; Exit if higher precedence           ;MUST APPLY OLD OP
                                                            ;IF HAS GREATER OR = PRECEDENCE, NEW OPERATOR
  PUSH BC             ; Save last precedence & token        ;SAVE THE OLD PRECEDENCE
  LD BC,EVAL3         ; Where to go on prec' break          ;PUT ON THE ADDRESS OF THE
  PUSH BC             ; Save on stack for return            ;PLACE TO RETURN TO AFTER OPERATOR APPLICATION
  LD A,D                                                    ;SEE IF THE OPERATOR IS EXPONENTIATION
  CP $7F              ; '^' as mapped in PRITAB             ;WHICH HAS PRECEDENCE 127
  JR Z,EVAL_EXPONENT                                        ;IF SO, "FRCSNG" AND MAKE A SPECIAL STACK ENTRY
  CP $51                                                       ;SEE IF THE OPERATOR IS "AND" OR "OR"
  JR C,EVAL_BOOL      ; one less than AND as mapped in PRITAB  ;AND IF SO "FRCINT" AND MAKE A SPECIAL STACK ENTRY
  AND $FE                                                      ;MAKE 123 AND 122 BOTH MAP TO 122
  CP $7A              ; MOD as mapped in PRITAB                ;MAKE A SPECIAL CHECK FOR "MOD" AND "IDIV"
  JR Z,EVAL_BOOL                                               ;IF SO, COERCE ARGUMENTS TO INTEGER
  
; THIS CODE PUSHES THE CURRENT VALUE IN THE FAC
; ONTO THE STACK, EXCEPT IN THE CASE OF STRINGS IN WHICH IT CALLS
; TYPE MISMATCH ERROR. [D] AND [E] ARE PRESERVED.
;
EVAL_NUMERIC:
  LD HL,FACCU         ;SAVE THE VALUE OF THE FAC
  LD A,(VALTYP)       ;FIND OUT WHAT TYPE OF VALUE WE ARE SAVING
  SUB $03             ; String ?      SET ZERO FOR STRINGS
  JP Z,TM_ERR         ; Type error
  OR A                ;SET PARITY -- CARRY UNAFFECTED SINCE OFF

  LD C,(HL)
  INC HL   
  LD B,(HL)
  PUSH BC             ;PUSH FACLO+0,1 ON THE STACK
  JP M,EVAL_NEXT      ;ALL DONE IF THE DATA WAS AN INTEGER  (Stack this one and get next)

  INC HL
  LD C,(HL) 
  INC HL    
  LD B,(HL) 
  PUSH BC             ;PUSH FAC-1,0 ON THE STACK
  JP PO,EVAL_NEXT     ;ALL DONE IF WE HAD A SNG  (Stack this one and get next)

  LD HL,FACLOW        ;WE HAVE A DOUBLE PRECISON NUMBER
  LD C,(HL)           ;PUSH ITS 4 LO BYTES ON THE STACK
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  LD C,(HL)
  INC HL   
  LD B,(HL)
  PUSH BC               ; USER-DEFINED FUNCTIONS REQUIRE THAT THE [H,L]
                        ; RETURNED POINTS AT THE LAST VALUE BYTE AND NOT BEYOND IT

;a.k.a. VPUSHD
EVAL_NEXT:
  ADD A,$03             ; FIX [A] TO BE THE VALTYP OF THE NUMBER JUST PUSHED ON THE STACK
  LD C,E                ; [C]=OPERATOR NUMBER
  LD B,A                ; [B]=TYPE OF VALUE ON THE STACK
  PUSH BC               ; SAVE THESE THINGS FOR APPLOP
  LD BC,APPLOP          ; GENERAL OPERATOR APPLICATION ROUTINE -- DOES TYPE CONVERSIONS

;a.k.a. FINTMP
EVAL_MORE:
  PUSH BC               ; Save routine address             ;SAVE PLACE TO GO
  LD HL,(TEMP3)         ; Address of current operator      ;REGET THE TEXT POINTER
  JP EVAL_1             ; Loop until prec' break           ;PUSH ON THE PRECEDENCE AND READ MORE FORMULA


DORELS:
  LD D,$00       ;ASSUME NO RELATION OPS, ALSO SETUP THE HIGH ORDER OF THE INDEX INTO OPTAB
LOPREL:
  SUB TK_GREATER            ;IS THIS ONE RELATION?
  JR C,FINREL               ;RELATIONS ALL THROUGH
  CP TK_MINOR-TK_GREATER+1  ;IS IT REALLY RELATIONAL?
  JR NC,FINREL              ;NO JUST BIG
  CP 1                      ;SET UP BITS BY MAPPING
  RLA                       ;0 TO 1 1 TO 2 AND 2 TO 4
  XOR D                     ;BRING IN THE OLD BITS
  CP D                      ;MAKE SURE RESULT IS BIGGER
  LD D,A                    ;SAVE THE MASK
  JP C,SN_ERR               ;DON'T ALLOW TWO OF THE SAME
  LD (TEMP3),HL             ;SAVE CHARACTER POINTER
  CALL CHRGTB               ;GET THE NEXT CANDIDATE
  JR LOPREL

;
; FOR EXPONENTIATION WE WANT TO FORCE THE CURRENT VALUE IN THE FAC
; TO BE SINGLE PRECISION. WHEN APPLICATION TIME COMES WE FORCE
; THE RIGHT HAND OPERAND TO SINGLE PRECISION AS WELL
;
EVAL_EXPONENT:              ;COERCE LEFT HAND OPERAND
  CALL __CSNG               ;PUT IT ON THE STACK
  CALL PUSHF                ;PLACE TO COERCE RIGHT HAND
  LD BC,POWER               ;OPERAND AND DO EXPONENTIATION
  LD D,$7F                  ;RESTORE THE PRECEDENCE
  JR EVAL_MORE              ;FINISH ENTRY AND EVALUATE MORE FORMULA

;
; FOR "AND" AND "OR" AND "\" AND "MOD" WE WANT TO FORCE THE CURRENT VALUE
; IN THE FAC TO BE AN INTEGER, AND AT APPLICATION TIME FORCE THE RIGHT
; HAND OPERAND TO BE AN INTEGER
;
EVAL_BOOL:
  PUSH DE                   ;SAVE THE PRECEDENCE
  CALL __CINT               
  POP DE                    ;[D]=PRECEDENCE
  PUSH HL                   ;PUSH THE LEFT HAND OPERAND
  LD BC,DANDOR              ;"AND" AND "OR" DOER
  JR EVAL_MORE              ;PUSH ON THIS ADDRESS,PRECEDENCE AND CONTINUE EVALUATION

;
; HERE TO BUILD AN ENTRY FOR A RELATIONAL OPERATOR
; STRINGS ARE TREATED SPECIALLY. NUMERIC COMPARES ARE DIFFERENT
; FROM MOST OPERATOR ENTRIES ONLY IN THE FACT THAT AT THE
; BOTTOM INSTEAD OF HAVING RETAOP, DOCMP AND THE RELATIONAL
; BITS ARE STORED. STRINGS HAVE STRCMP,THE POINTER AT THE STRING DESCRIPTOR,
; DOCMP AND THE RELATIONAL BITS.
;
FINREL:
  LD A,B                    ;[A]=OLD PRECEDENCE
  CP 100                    ;RELATIONALS HAVE PRECEDENCE 100
  RET NC                    ;APPLY EARLIER OPERATOR IF IT HAS HIGHER PRECEDENCE
  PUSH BC                   ;SAVE THE OLD PRECEDENCE
  PUSH DE                   ;SAVE [D]=RELATIONAL BITS
  LD DE,100*256+OPCNT       ;[D]=PRECEDENCE=100
                            ;[E]=DISPATCH OFFSET FOR COMPARES IN APPLOP=4
                            ;IN CASE THIS IS A NUMERIC COMPARE
  LD HL,DOCMP               ;ROUTINE TO TAKE COMPARE ROUTINE RESULT
                            ;AND RELATIONAL BITS AND RETURN THE ANSWER
  PUSH HL                   ;DOES A JMP TO RETAOP WHEN DONE
  CALL GETYPR               ;SEE IF WE HAVE A NUMERIC COMPARE
  JR NZ,EVAL_NUMERIC        ;YES, BUILD AN APPLOP ENTRY
  LD HL,(FACCU)             ;GET THE POINTER AT THE STRING DESCRIPTOR
  PUSH HL                   ;SAVE IT FOR STRCMP
  LD BC,STRCMP              ;STRING COMPARE ROUTINE
  JR EVAL_MORE              ;PUSH THE ADDRESS, REGET THE TEXT POINTER
                            ;SAVE THE PRECEDENCE AND SCAN
                            ;MORE OF THE FORMULA

;
; APPLOP IS RETURNED TO WHEN IT IS TIME TO APPLY AN ARITHMETIC
; OR NUMERIC COMPARISON OPERATION.
; THE STACK HAS A DOUBLE BYTE ENTRY WITH THE OPERATOR
; NUMBER AND THE VALTYP OF THE VALUE ON THE STACK.
; APPLOP DECIDES WHAT VALUE LEVEL THE OPERATION
; WILL OCCUR AT, AND CONVERTS THE ARGUMENTS. APPLOP
; USES DIFFERENT CALLING CONVENTIONS FOR EACH VALUE TYPE.
; INTEGERS: LEFT IN [D,E] RIGHT IN [H,L]
; SINGLES:  LEFT IN [B,C,D,E] RIGHT IN THE FAC
; DOUBLES:  LEFT IN FAC   RIGHT IN ARG
;
APPLOP:
  POP BC                    ;[B]=STACK OPERAND VALUE TYPE  [C]=OPERATOR OFFSET
  LD A,C                    ;SAVE IN MEMORY SINCE THE STACK WILL BE BUSY
  LD (OPRTYP),A             ;A RAM LOCATION
  LD A,(VALTYP)             ;GET VALTYP OF FAC
  CP B                      ;ARE VALTYPES THE SAME?
  JR NZ,VALNSM              ;NO
  CP $02                    ;INTEGER?
  JR Z,INTDPC               ;YES, DISPATCH!!
  CP $04                    ;SINGLE?
  JR Z,SNGDPC               ;YES, DISPATCH!!
  JR NC,DBLDPC              ;MUST BE DOUBLE, DISPATCH!!
VALNSM:
  LD D,A                    ;SAVE IN [D]
  LD A,B                    ;CHECK FOR DOUBLE
  CP $08                    ;PRECISION ENTRY ON THE STACK
  JR Z,STKDBL               ;FORCE FAC TO DOUBLE
  LD A,D                    ;GET VALTYPE OF FAC
  CP $08                    ;AND IF SO, CONVERT THE STACK OPERAND
  JR Z,FACDBL               ;TO DOUBLE PRECISION
  LD A,B                    ;SEE IF THE STACK ENTRY IS SINGLE
  CP $04                    ;PRECISION AND IF SO, CONVERT
  JR Z,STKSNG               ;THE FAC TO SINGLE PRECISION
  LD A,D                    ;SEE IF THE FAC IS SINGLE PRECISION
  CP $03                    ;BLOW UP ON RIGHT HAND STRING OPERAND
  JP Z,TM_ERR               ; Err $0D - "Type mismatch"
  JR NC,EVAL_FP             ;AND IF SO CONVERT THE STACK TO SINGLE PRECISION

;NOTE: THE STACK MUST BE INTEGER AT THIS POINT

; This entry point is used by the routine at _EVAL.
INTDPC:
  LD HL,INT_OPR             ;INTEGER INTEGER CASE
  LD B,$00                  ;SPECIAL DISPATCH FOR SPEED
  ADD HL,BC                 ;[H,L] POINTS TO THE ADDRESS TO GO TO 
  ADD HL,BC
  LD C,(HL)                 ;[B,C]=ROUTINE ADDRESS
  INC HL
  LD B,(HL)                 
  POP DE                    ;[D,E]=LEFT HAND OPERAND
  LD HL,(FACCU)             ;[H,L]=RIGHT HAND OPERAND
  PUSH BC                   ;DISPATCH
  RET

;
; THE STACK OPERAND IS DOUBLE PRECISION, SO
; THE FAC MUST BE FORCED TO DOUBLE PRECISION, MOVED INTO ARG
; AND THE STACK VALUE POPED INTO THE FAC
;
; This entry point is used by the routine at _EVAL.
STKDBL:
  CALL __CDBL              ;MAKE THE FAC DOUBLE PRECISION
DBLDPC:
  CALL VMOVAF              ;POP OFF THE STACK OPERAND INTO THE FAC
  POP HL
  LD (FACLOW+2),HL
  POP HL
  LD (FACLOW),HL           ;STORE LOW BYTES AWAY
SNGDBL:
  POP BC
  POP DE                   ;POP OFF A FOUR BYTE VALUE
  CALL FPBCDE              ;INTO THE FAC
SETDBL:
  CALL __CDBL              ;MAKE SURE THE LEFT OPERAND IS DOUBLE PRECISION
  LD HL,DEC_OPR            ;DISPATCH TO A DOUBLE PRECISION ROUTINE
DODSP:
  LD A,(OPRTYP)            ;RECALL WHICH OPERAND IT WAS
  RLCA                     ;CREATE A DISPATCH OFFSET, SINCE
  ADD A,L                  ;TABLE ADDRESSES ARE TWO BYTES
  LD L,A                   ;ADD LOW BYTE OF ADDRESS
  ADC A,H                  ;SAVE BACK
  SUB L                    ;ADD HIGH BYTE
  LD H,A                   ;SUBTRACT LOW
  LD A,(HL)                ;RESULT BACK
  INC HL                   ;GET THE ADDRESS
  LD H,(HL)
  LD L,A
  JP (HL)     ;AND PERFORM THE OPERATION, RETURNING TO RETAOP, EXCEPT FOR COMPARES WHICH RETURN TO DOCMP

;
; THE FAC IS DOUBLE PRECISION AND THE STACK IS EITHER
; INTEGER OR SINGLE PRECISION AND MUST BE CONVERTED
; 
FACDBL:
  LD A,B
  PUSH AF                  ;SAVE THE STACK VALUE TYPE
  CALL VMOVAF              ;MOVE THE FAC INTO ARG
  POP AF                   ;POP THE STACK VALUE TYPE INTO [A]
  LD (VALTYP),A            ;PUT IT IN VALTYP FOR THE FORCE ROUTINE
  CP $04                   ;SEE IF ITS SINGLE, SO WE KNOW HOW TO POP THE VALUE OFF
  JR Z,SNGDBL              ;IT'S SINGLE PRECISION SO DO A POPR / CALL MOVFR
  POP HL                   ;POP OFF THE INTEGER VALUE
  LD (FACCU),HL            ;SAVE IT FOR CONVERSION
  JR SETDBL                ;SET IT UP

;
; THIS IS THE CASE WHERE THE STACK IS SINGLE PRECISION
; AND THE FAC IS EITHER SINGLE PRECISION OR INTEGER
;
STKSNG:
  CALL __CSNG              ;CONVERT THE FAC IF NECESSARY
; This entry point is used by the routine at _EVAL.
SNGDPC:
  POP BC                   ;PUT THE LEFT HAND OPERAND IN THE REGISTERS
  POP DE
SNGDO:
  LD HL,FLT_OPR            ;SETUP THE DISPATCH ADDRESS FOR THE SINGLE PRECISION OPERATOR ROUTINES
  JR DODSP                 ;DISPATCH

;
; THIS IS THE CASE WHERE THE FAC IS SINGLE PRECISION AND THE STACK
; IS AN INTEGER. 
;
EVAL_FP:
  POP HL                   ;POP OFF THE INTEGER ON THE STACK
  CALL PUSHF               ;SAVE THE FAC ON THE STACK
  CALL HL_CSNG             ;CONVERT [H,L] TO A SINGLE PRECISION NUMBER IN THE FAC
  CALL BCDEFP              ;PUT THE LEFT HAND OPERAND IN THE REGISTERS
  POP HL                   ;RESTORE THE FAC
  LD (FACCU+2),HL          ;FROM THE STACK
  POP HL
  LD (FACCU),HL
  JR SNGDO                 ;PERFORM THE OPERATION

;
; HERE TO DO INTEGER DIVISION. SINCE WE WANT 1/3 TO BE
; .333333 AND NOT ZERO WE HAVE TO FORCE BOTH ARGUMENTS
; TO BE SINGLE-PRECISION FLOATING POINT NUMBERS
; AND USE FDIV
;
; Integer DIVIDE
IDIV:
  PUSH HL                  ;SAVE THE RIGHT HAND ARGUMENT
  EX DE,HL                 ;[H,L]=LEFT HAND ARGUMENT
  CALL HL_CSNG             ;CONVERT [H,L] TO A SINGLE-PRECISION NUMBER IN THE FAC
  POP HL                   ;GET BACK THE RIGHT HAND ARGUMENT
  CALL PUSHF               ;PUSH THE CONVERTED LEFT HAND ARGUMENT ONTO THE STACK
  CALL HL_CSNG             ;CONVERT THE RIGHT HAND ARGUMENT TO A SINGLE PRECISION NUMBER IN THE FAC
  JP DIV                   ;DO THE DIVISION AFTER POPING INTO THE REGISTERS THE LEFT HAND ARGUMENT


; Get next expression value (a.k.a. "EVAL" !)
; Used by the routines at EVAL and CONCAT.
; a.k.a. EVAL (in that case 'EVAL' was called 'FRMEVL')
OPRND:
  CALL CHRGTB             ; Gets next character (or token) from BASIC text.
  JP Z,MO_ERR             ;TEST FOR MISSING OPERAND - IF NONE, Err $18 - "Missing Operand" Error
  JP C,FIN                ;IF NUMERIC, INTERPRET CONSTANT              If numeric type, create FP number
  CALL ISLETTER_A         ;VARIABLE NAME?                              See if a letter
  JP NC,EVAL_VARIABLE     ;AN ALPHABETIC CHARACTER MEANS YES           Letter - Find variable
  CP DBLCON+1             ;IS IT AN EMBEDED CONSTANT
  JP C,_CONFAC            ;RESCAN THE TOKEN & RESTORE OLD TEXT PTR
  INC A                   ;IS IT A FUNCTION CALL (PRECEDED BY $FF, 377 OCTAL)
  JP Z,ISFUN              ;YES, DO IT
  DEC A                   ;FIX A BACK
  CP TK_PLUS              ;IGNORE "+"
  JR Z,OPRND              ; ..skip it, we will look the digits
  CP TK_MINUS             ;NEGATION?
  JP Z,MINUS              ; Yes - deal with minus sign
  CP '"'                  ;STRING CONSTANT?
  JP Z,QTSTR              ;IF SO BUILD A DESCRIPTOR IN A TEMPORARY DESCRIPTOR LOCATION
                          ;AND PUT A POINTER TO THE DESCRIPTOR IN FACLO.
  CP TK_NOT               ;CHECK FOR "NOT" OPERATOR
  JP Z,NOT
  CP '&'                  ;OCTAL CONSTANT?
  JP Z,OCTCNS
  CP TK_ERR               ;'ERR' token ?
  JR NZ,NTERC             ;NO, TRY OTHER POSSIBILITIES

; 'ERR' BASIC function
__ERR:
  CALL CHRGTB             ;GRAB FOLLOWING CHAR IS IT A DISK ERROR CALL?
  LD A,(ERRFLG)           ;GET THE ERROR CODE. "CPI OVER NEXT BYTE
  PUSH HL                 ;SAVE TEXT POINTER
  CALL PASSA              ;RETURN THE VALUE
  POP HL                  ;RESTORE TEXT POINTER
  RET                     ;ALL DONE.

; This entry point is used by the routine at OPRND.
NTERC:
  CP TK_ERL               ;ERROR LINE NUMBER VARIABLE
  JR NZ,NTERL             ;NO, TRY MORE THINGS.

; 'ERL' BASIC function
__ERL:
  CALL CHRGTB             ;GET FOLLOWING CHARACTER
  PUSH HL                 ;SAVE TEXT POINTER
  LD HL,(ERRLIN)          ;GET THE OFFENDING LINE #
  CALL INEG2              ;FLOAT 2 BYTE UNSINGED INT
  POP HL                  ;RESTORE TEXT POINTER
  RET                     ;RETURN

; This entry point is used by the routine at __ERR.
NTERL:

IF HAVE_GFX
  CP TK_POINT
  JP Z,FN_POINT
ENDIF

IF ZXPLUS3
  CP TK_CSRLIN
  JP Z,FN_CSRLIN
ENDIF

  CP TK_VARPTR            ;VARPTR CALL?
  JR NZ,NTVARP            ;NO

VARPTR:
  CALL CHRGTB             ;EAT CHAR AFTER
  CALL SYNCHR             ;EAT LEFT PAREN
  DEFM "("                
  CP '#'                  ;WANT POINTER TO FILE?
  JR NZ,NVRFIL            ;NO, MUST BE VARIABLE

VARPTR_BUF:
  CALL FNDNUM             ;READ FILE #
  PUSH HL                 ;SAVE TEXT PTR
  CALL GETPTR             ;GET PTR TO FILE
  POP HL                  ;RESTORE TEXT PTR
  JR VARPTR_0

NVRFIL:
  CALL PTRGET             ;GET ADDRESS OF VARIABLE
VARPTR_0:
  CALL SYNCHR
  DEFM ")"                ;EAT RIGHT PAREN
  PUSH HL                 ;SAVE TEXT POINTER
  EX DE,HL                ;GET VALUE TO RETURN IN [H,L]
  LD A,H                  ;MAKE SURE NOT UNDEFINED VAR
  OR L                    ;SET CC'S. ZERO IF UNDEF
  JP Z,FC_ERR             ;ALL OVER IF UNDEF (DONT WANT USER POKING INTO ZERO IF HE'S TOO LAZY TO CHECK
  CALL MAKINT             ;MAKE IT AN INT
  POP HL                  ;RESTORE TEXT POINTER
  RET

; (continued)..get next expression value
;
; Used by the routine at __ERL.
NTVARP:
  CP TK_USR               ;USER ASSEMBLY LANGUAGE ROUTINE??
  JP Z,FN_USR             ;GO HANDLE IT
  CP TK_INSTR             ;IS IT THE INSTR FUNCTION??
  JP Z,FN_INSTR           ;DISPATCH
  CP TK_INKEY_S           ;INKEY$ FUNCTION?
  JP Z,FN_INKEY           ;GO DO IT
  CP TK_STRING            ;STRING FUNCTION?
  JP Z,FN_STRING          ;YES, GO DO IT
  CP TK_INPUT             ;FIXED LENGTH INPUT?
  JP Z,FN_INPUT           ;YES
  CP TK_FN                ;USER-DEFINED FUNCTION?
  JP Z,DOFN
					;NUMBERED CHARACTERS ALLOWED
					;SO THERE IS NO NEED TO CHECK
					;THE UPPER BOUND


; End of expression.  Look for ')'.
; ONLY POSSIBILITY LEFT IS A FORMULA IN PARENTHESES
;
; Used by the routines at ISFUN and FN_USR.
EVLPAR:
  CALL OPNPAR        ; Evaluate expression in "()", RECURSIVELY EVALUATE THE FORMULA
  CALL SYNCHR        ; Make sure ")" follows
  DEFM ")"
  RET

; '-', deal with minus sign
;
; Used by the routine at OPRND.
MINUS:
  LD D,$7D           ; "-" precedence                   ;A PRECEDENCE BELOW ^
  CALL EVAL_1        ; Evaluate until prec' break       ;BUT ABOVE ALL ELSE
  LD HL,(NXTOPR)     ; Get next operator address        ;SO ^ GREATER THAN UNARY MINUS
  PUSH HL            ; Save next operator address       ;GET TEXT POINTER
  CALL INVSGN        ; Negate value


; FUNCTIONS THAT DON'T RETURN STRING VALUES COME BACK HERE (POP HL / RET)
RETNUM:
  POP HL             ; Restore next operator address
  RET

; (a.k.a. CONVAR)
;
; Used by the routine at OPRND.
EVAL_VARIABLE:
  CALL GETVAR           ;GET A POINTER TO THE VARIABLE IN [D,E]
COMPTR:
  PUSH HL               ;SAVE THE TEXT POINTER
  EX DE,HL              ;PUT THE POINTER TO THE VARIABLE VALUE INTO [H,L]. IN THE CASE OF A STRING
                        ;THIS IS A POINTER TO A DESCRIPTOR AND NOT AN ACTUAL VALUE
  LD (FACCU),HL         ;IN CASE IT'S STRING STORE THE POINTER TO THE DESCRIPTOR IN FACLO.
  CALL GETYPR           ;Get the number type (FAC).   FOR STRINGS WE JUST LEAVE
  CALL NZ,VMOVFM        ;A POINTER IN THE FAC THE FAC USING [H,L] AS THE POINTER.   (CALL if not string type)
  POP HL                ;RESTORE THE TEXT POINTER
  RET

; Get char from (HL) and make upper case
;
; Used by the routines at CRNCLP, CRNCH_MORE, NOTRES and INIT.
MAKUPL:
  LD A,(HL)             ;GET CHAR FROM MEMORY

; Make char in 'A' upper case
;
; Used by the routines at TSTNUM, OCTCNS and DISPED.
UCASE:
  CP 'a'                ;IS IT LOWER CASE RANGE
  RET C                 ;LESS
  CP 'z'+1              ;GREATER
  RET NC                ;TEST
  AND $5F               ;MAKE UPPER CASE
  RET                   ;DONE

; This entry point is used by the routine at INIT.
CNSGET:
  CP '&'                ;OCTAL PERHAPS?
  JP NZ,ATOH

; OCTAL, HEX or other specified base (ASCII) to FP number
;
; Used by the routines at TSTNUM, OPRND and H_ASCTFP.
OCTCNS:
  LD DE,$0000           ;INITIALIZE TO ZERO AND IGNORE OVERFLOW
  CALL CHRGTB           ;GET FIRST CHAR
  CALL UCASE            ;MAKE UPPER IF NESC.
  CP 'O'                ;"&o": OCTAL?
  JR Z,LOPOCT           ;IF SO, DO IT
  CP 'H'                ;"&h": HEX?
  JR NZ,LOPOC2          ;THEN DO IT
  LD B,$05              ;INIT DIGIT COUNT
LOPHEX:
  INC HL                ;BUMP POINTER
  LD A,(HL)             ;GET CHAR
  CALL UCASE            ;MAKE UPPER CASE
  CALL ISLETTER_A       ;FETCH CHAR, SEE IF ALPHA
  EX DE,HL              ;SAVE [H,L]
  JR NC,ALPTST          ;YES, MAKE SURE LEGAL HEC
  CP '9'+1              ;IS IT BIGGER THAN LARGEST DIGIT?
  JR NC,OCTFIN          ;YES, BE FORGIVING & RETURN
  SUB '0'               ;CONVERT DIGIT, MAKE BINARY
  JR C,OCTFIN           ;BE FORGIVING IF NOT HEX DIGIT
  JR NXTHEX             ;ADD IN OFFSET

ALPTST:
  CP 'F'+1              ;IS IT LEGAL HEX?
  JR NC,OCTFIN          ;YES, TERMINATE
  SUB 'A'-10            ;MAKE BINARY VALUE
NXTHEX:
  ADD HL,HL             ;SHIFT RIGHT FOUR BITS
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  OR L                  ;OR ON NEW DIGIT
  LD L,A                ;SAVE BACK
  EX DE,HL              ;GET TEXT POINTER BACK IN [H,L]
  ;DEC B
  DJNZ LOPHEX           ;KEEP EATING
  JP OV_ERR             ;TOO MANY DIGITS?
  
LOPOC2:
  DEC HL                ;REGET LAST CHARACTER
LOPOCT:
  CALL CHRGTB           ;READ A DIGIT
  EX DE,HL              ;RESULT INTO [H,L]
  JR NC,OCTFIN          ;OUT OF DIGITS MEANS DONE
  CP '8'                ;IS THIS AN OCTAL DIGIT
  JP NC,SN_ERR          ;NO, TOO BAD YOU WILL LOSE
  LD BC,OV_ERR          ;WHERE TO GO ON OVERFLOW ERROR
  PUSH BC               ;SAVE ADDR ON STACK
  ADD HL,HL             ;MULTIPLY BY EIGHT
  RET C                 ;OVERFLOW ERROR
  ADD HL,HL
  RET C                 ;OVERFLOW ERROR
  ADD HL,HL
  RET C                 ;OVERFLOW ERROR
  POP BC                ;GET RID OF OVERR ADDR
  LD B,$00              ;SETUP TO ADD [B,C]
  SUB '0'               ; convert from ASCII
  LD C,A
  ADD HL,BC             ;ADD IN THE DIGIT
  EX DE,HL              ;PUT TEXT POINTER BACK IN [H,L]
  JR LOPOCT             ;SCAN MORE DIGITS

OCTFIN:
  CALL MAKINT           ;SAVE AS AN INTEGER
  EX DE,HL              ;[H,L]-TEXT POINTER
  RET

; ISFUN
;
; Used by the routine at OPRND.
ISFUN:
  INC HL                 ; BUMP SOURCE TEXT POINTER
  LD A,(HL)              ; GET THE ACTUAL TOKEN FOR FN
  SUB $80+ONEFUN         ; MAKE INTO OFFSET  (Is it a function?  -$80-1)
  CP TK_RND-ONEFUN       ; IS IT RND?
  JR NZ,NTMRND           ; IF NOT NO NEED TO CHECK MONADIC
  PUSH HL                ; SAVE TEXT POINTER
  CALL CHRGTB            ; Make sure "(" follows
  CP '('                 ; SEE IF NEXT CHAR IS "("
  POP HL                 ; GET BACK THE OLD TEXT POINTER
  JP NZ,RNDMON           ; HANDLE MONADIC CASE
  LD A,TK_RND-ONEFUN    
NTMRND:
  LD B,$00               ; Get address of function
  RLCA                   ; Double function offset             ;MULTIPLY BY 2
  LD C,A                 ; BC = Offset in function table
  PUSH BC                ; Save adjusted token value          ;SAVE THE FUNCTION # ON THE STACK
  CALL CHRGTB            ; Get next character
  LD A,C                 ; Get adjusted token value           ;LOOK AT FUNCTION #
  CP 2*TK_MID_S-2*ONEFUN+1 ; Adj' LEFT$,RIGHT$ or MID$ ?
  JR NC,OKNORM            ; No - Do function

;
; MOST FUNCTIONS TAKE A SINGLE ARGUMENT.
; THE RETURN ADDRESS OF THESE FUNCTIONS IS A SMALL ROUTINE
; THAT CHECKS TO MAKE SURE VALTYP IS 0 (NUMERIC) AND POPS OFF
; THE TEXT POINTER. SO NORMAL FUNCTIONS THAT RETURN STRING RESULTS (I.E. CHR$)
; MUST POP OFF THE RETURN ADDRESS OF LABBCK, AND POP OFF THE
; TEXT POINTER AND THEN RETURN TO FRMEVL.
;
; THE SO CALLED "FUNNY" FUNCTIONS CAN TAKE MORE THAN ONE ARGUMENT.
; THE FIRST OF WHICH MUST BE STRING AND THE SECOND OF WHICH
; MUST BE A NUMBER BETWEEN 0 AND 256. THE TEXT POINTER IS
; PASSED TO THESE FUNCTIONS SO ADDITIONAL ARGUMENTS
; CAN BE READ. THE TEXT POINTER IS PASSED IN [D,E].
; THE CLOSE PARENTHESIS MUST BE CHECKED AND RETURN IS DIRECTLY
; TO FRMEVL WITH [H,L] SETUP AS THE TEXT POINTER POINTING BEYOND THE ")".
; THE POINTER TO THE DESCRIPTOR OF THE STRING ARGUMENT
; IS STORED ON THE STACK UNDERNEATH THE VALUE OF THE INTEGER ARGUMENT (2 BYTES)
;
; FIRST ARGUMENT ALWAYS STRING -- SECOND INTEGER
;
  CALL OPNPAR            ; Evaluate expression  (X,...        ;EAT OPEN PAREN AND FIRST ARG
  CALL SYNCHR            ; Make sure "," follows
  DEFM ","                                                    ;TWO ARGS SO COMMA MUST DELIMIT
  CALL TSTSTR            ; Make sure it's a string            ;MAKE SURE THE FIRST ONE WAS STRING
  EX DE,HL               ; Save code string address           ;[D,E]=TXTPTR
  LD HL,(FACCU)          ; Get address of string              ;GET PTR AT STRING DESCRIPTOR
  EX (SP),HL             ; Save address of string             ;GET FUNCTION # <> SAVE THE STRING PTR
  PUSH HL                ; Save adjusted token value          ;PUT THE FUNCTION # ON
  EX DE,HL               ; Restore code string address        ;[H,L]=TXTPTR
  CALL GETINT            ; Get integer 0-255                  ;[E]=VALUE OF FORMULA
  EX DE,HL               ; Save code string address           ;TEXT POINTER INTO [D,E] <> [H,L]=INT VALUE OF SECOND ARGUMENT
  EX (SP),HL             ; Save integer,HL = adj' token       ;SAVE INT VALUE OF SECOND ARG <> [H,L]=FUNCTION NUMBER
  JR GOFUNC              ; Jump to string function            ;DISPATCH TO FUNCTION

; a.k.a. FNVAL
OKNORM:
  CALL EVLPAR            ; Evaluate expression                ;CHECK OUT THE ARGUMENT AND MAKE SURE ITS FOLLOWED BY ")"
  EX (SP),HL             ; HL = Adjusted token value          ;[H,L]=FUNCTION # AND SAVE TEXT POINTER
;
; CHECK IF SPECIAL COERCION MUST BE DONE FOR ONE OF THE TRANSCENDENTAL
; FUNCTIONS (RND, SQR, COS, SIN, TAN, ATN, LOG, AND EXP)
; THESE FUNCTIONS DO NOT LOOK AT VALTYP, BUT RATHER ASSUME THE
; ARGUMENT PASSED IN THE FAC IS SINGLE PRECISION, SO FRCSNG
; MUST BE CALLED BEFORE DISPATCHING TO THEM.
;
  LD A,L                 ;[A]=FUNCTION NUMBER
  CP 2*(TK_SQR-ONEFUN)   ;LESS THAN SQUARE ROOT?        ; Adj' SGN, INT or ABS ?
  JR C,NOTFRF            ;DON'T FORCE THE ARGUMENT
  CP 2*(TK_ATN-ONEFUN)+1 ;BIGGER THAN ARC-TANGENT?      ; Adj' ABS, SQR, RND, SIN, LOG, EXP, COS, TAN or ATN ?
  PUSH HL                ;SAVE THE FUNCTION NUMBER
  CALL C,__CSNG          ;IF NOT, FORCE FAC TO SINGLE-PRECISION
  POP HL                 ;RESTORE THE FUNCTION NUMBER
NOTFRF:
  LD DE,RETNUM          ; Return number from function (POP HL / RET)       ;RETURN ADDRESS
  PUSH DE               ; Save on stack                                    ;MAKE THEM REALLY COME BACK
  LD A,$01              ;FUNCTION SHOULD ONLY PRINT OVERFLOW ONCE
  LD (FLGOVC),A
GOFUNC:
  LD BC,FNCTAB_FN       ; Function routine addresses         ;FUNCTION DISPATCH TABLE
; This entry point is used by the routine at DOFN.
DISPAT:
  ADD HL,BC             ; Point to right address             ;ADD ON THE OFFSET
  LD C,(HL)             ; Get LSB of address                 ;FASTER THAN PUSHM
  INC HL                ;
  LD H,(HL)             ; Get MSB of address
  LD L,C                ; Address to HL
  JP (HL)               ; Jump to function                   ;GO PERFORM THE FUNCTION

;
; THE FOLLOWING ROUTINE IS CALLED FROM FIN IN F4
; TO SCAN LEADING SIGNS FOR NUMBERS. IT WAS MOVED
; TO F3 TO ELIMINATE BYTE EXTERNALS
;
; test '+', '-'..
; a.k.a. MINPLS
;
; Used by the routine at _ASCTFP.
SGNEXP:
  DEC D                   ; Dee to flag negative exponent      ;SET SIGN OF EXPONENT FLAG
  CP TK_MINUS             ; .."-" token ?                      ;NEGATIVE EXPONENT?
  RET Z                   ; Yes - Return
  CP '-'                  ; "-" ASCII ?
  RET Z                   ; Yes - Return
  INC D                   ; Inc to flag positive exponent      ;NO, RESET FLAG
  CP '+'                  ; "+" ASCII ?
  RET Z                   ; Yes - Return
  CP TK_PLUS              ; .."+" token ?                      ;IGNORE "+"
  RET Z                   ; Yes - Return
  DEC HL                  ; DEC 'cos GETCHR INCs               ;CHECK IF LAST CHARACTER WAS A DIGIT
  RET                     ; Return "NZ"                        ;RETURN WITH NON-ZERO SET

; Routine at 7513
DOCMP:
  INC A                   ;SETUP BITS
  ADC A,A                 ;4=LESS 2=EQUAL 1=GREATER
  POP BC                  ;WHAT DID HE WANT?
  AND B                   ;ANY BITS MATCH?
  ADD A,$FF               ;MAP 0 TO 0
  SBC A,A                 ;AND ALL OTHERS TO 377
  CALL CONIA              ;CONVERT [A] TO AN INTEGER SIGNED
  JR RETAPG               ;RETURN FROM OPERATOR APPLICATION PLACE SO THE TEXT POINTER
                          ;WILL GET SET UP TO WHAT IT WAS WHEN LPOPER RETURNED.

; 'NOT' boolean expression
;
; Used by the routine at OPRND.
NOT:
  LD D,$5A                ; Precedence value for "NOT"         ;"NOT" HAS PRECEDENCE 90, SO FORMULA EVALUATION
  CALL EVAL_1             ; Eval until precedence break        ;IS ENTERED WITH A DUMMY ENTRY OF 90 ON THE STACK
  CALL __CINT             ; Get integer -32768 - 32767         ;COERCE THE ARGUMENT TO INTEGER
  LD A,L                  ; Get LSB                            ;COMPLEMENT [H,L]
  CPL                     ; Invert LSB
  LD L,A                  ; Save "NOT" of LSB
  LD A,H                  ; Get MSB
  CPL                     ; Invert MSB
  LD H,A                  ; Set "NOT" of MSB
  LD (FACCU),HL           ; Save AC as current                 ;UPDATE THE FAC
  POP BC                  ; Clean up stack                     ;FRMEVL, AFTER SEEING THE PRECEDENCE OF 90 THINKS IT IS 
                                                               ;APPLYING AN OPERATOR SO IT HAS THE TEXT POINTER IN TEMP2 SO
; This entry point is used by the routine at DOCMP.
RETAPG:
  JP EVAL3               ; Continue evaluation                 ;RETURN TO REFETCH IT

; Test number FAC type (Precision mode, etc..)                 ;REPLACEMENT FOR "GETYPE" RST
;
; Used by the routines at TSTNUM, SAVSTP, __PRINT, NOTQTI, __READ,
; _EVAL, EVAL_VARIABLE, DOFN, __POKE, INVSGN, VSIGN, VMOVMF, __CINT,
; __CSNG, __CDBL, TSTSTR, __FIX, __INT, _ASCTFP, MULTEN, DDIV_SUB, PUFOUT,
; FOUBE3, RNGTST, FILIND, LINE_INPUT, __CALL, CAYSTR, VARNOT, __TROFF,
; FN_STRING, FN_INSTR and __FRE.
GETYPR:
  LD A,(VALTYP)
  CP $08                  ; set M,PO.. flags
;
; CONTINUATION OF GETYPE RST
;
  JR NC,NCASE        ;SPLIT OFF NO CARRY CASE
  SUB $03            ;SET A CORRECTLY
  OR A               ;NOW SET LOGICAL'S OK
  SCF                ;CARRY MUST BE SET
  RET                ;ALL DONE
NCASE:
  SUB $03            ;SUBTRACT CORRECTLY
  OR A               ;SET CC'S PROPERLY
  RET                ;RETURN

;
; DANDOR APPLIES THE "AND" AND "OR" OPERATORS
; AND SHOULD BE USED TO IMPLEMENT ALL LOGICAL OPERATORS.
; WHENEVER AN OPERATOR IS APPLIED, ITS PRECEDENCE IS IN [B].
; THIS FACT IS USED TO DISTINGUISH BETWEEN "AND" AND "OR".
; THE RIGHT HAND ARGUMENT IS COERCED TO INTEGER, JUST AS
; THE LEFT HAND ONE WAS WHEN IT WAS PUSHED ON THE STACK.
;
; Routine at 7564
DANDOR:
  LD A,B            ;SAVE THE PRECEDENCE "OR"=70
  PUSH AF
  CALL __CINT       ;COERCE RIGHT HAND ARGUMENT TO INTEGER
  POP AF            ;GET BACK THE PRECEDENCE TO DISTINGUISH "AND" AND "OR"
  POP DE            ;POP OFF THE LEFT HAND ARGUMENT
  CP $7A			;IS THE OPERATOR "MOD"?    (as in PRITAB)
  JP Z,IMOD         ;IF SO, USE MONTE'S SPECIAL ROUTINE
  CP $7B			;IS THE OPERATOR "IDIV"?   (as in PRITAB)
  JP Z,INT_DIV      ;LET MONTE HANDLE IT
  LD BC,GIVINT      ;PLACE TO RETURN WHEN DONE
  PUSH BC           ;SAVE ON STACK
  CP $46            ;SET ZERO FOR "OR"
  JR NZ,NOTOR

; 'OR' boolean expression
OR:
  LD A,E            ;SETUP LOW IN [A]
  OR L
  LD L,A
  LD A,H
  OR D
  RET               ;RETURN THE INTEGER [A,L]

; This entry point is used by the routine at DANDOR.
NOTOR:
  CP $50            ;AND?
  JR NZ,NOTAND

; 'AND' boolean expression
AND:
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET               ;RETURN THE INTEGER [A,L]
; This entry point is used by the routine at OR.
NOTAND:
  CP $3C            ;XOR?
  JR NZ,NOTXOR      ;NO

; 'XOR' boolean expression
XOR:
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET
; This entry point is used by the routine at AND.
NOTXOR:
  CP $32            ;EQV?
  JR NZ,NOTEQV         ;NO

; 'EQV' boolean expression
;EQV:
  LD A,E            ;LOW PART
  XOR L
  CPL
  LD L,A
  LD A,H
  XOR D
  CPL
  RET

; 'IMP' expression
;
; Used by the routine at XOR.
;FOR "IMP" USE A IMP B = NOT(A AND NOT(B))
NOTEQV:
  LD A,L            ;MUST BE "IMP"
  CPL
  AND E
  CPL
  LD L,A
  LD A,H
  CPL
  AND D
  CPL
  RET
  
;
; THIS ROUTINE SUBTRACTS [D,E] FROM [H,L]
; AND FLOATS THE RESULT LEAVING IT IN FAC.
;
; This entry point is used by the routine at __FRE.
GIVDBL:
IF ORIGINAL | __CPU_8080__ | __CPU_8085__
  LD A,L                 ;[H,L]=[H,L]-[D,E]
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A                 ;SAVE HIGH BYTE IN [H]
ELSE
  OR A
  SBC HL,DE              ;[H,L]=[H,L]-[D,E]
ENDIF
  JP INEG2               ;FLOAT 2 BYTE UNSIGNED INT

; 'LPOS' BASIC command
__LPOS:
  LD A,(LPTPOS)
  JR SNGFLI

; 'POS' BASIC instruction
; Returns the current cursor position. The leftmost position is 1 for GW-BASIC, while MSX had 0.
__POS:
  LD A,(TTYPOS)         ;GET TELETYPE POSITION
  
;SEE WHERE WE ARE  (LPT or TTY)
; This entry point is used by the routine at __LPOS.
SNGFLI:
  INC A        ;IN ADDS VERSION TAB POSITIONS START AT COLUMN 1.

; Exit from function, result in A
; a.k.a. SNGFLT
;
; Used by the routines at __ERR, ISMID, __DELETE, __LOF and __VAL.
PASSA:
  LD L,A       ;MAKE [A] AN UNSIGNED INTEGER
  XOR A

; a.k.a. SNGFLT
; This entry point is used by the routine at __LOC.
GIVINT:
  LD H,A
  JP MAKINT

; Routine at 7666
;
; USER DEFINED (USR) ASSEMBLY LANGUAGE FUNCTION CODE
;
; Used by the routine at NTVARP.
FN_USR:
  CALL SCNUSR         ;SCAN THE USR#
  PUSH DE             ;SAVE POINTER
  CALL EVLPAR         ;EAT LEFT PAREN AND FORMULA
  EX (SP),HL          ;SAVE TEXT POINTER & GET INDEX INTO USRTAB
  LD E,(HL)           ;GET DISPATCH ADRESS
  INC HL              ;BUMP POINTER
  LD D,(HL)           ;PICK UP 2ND BYTE OF ADDRESS
  LD HL,POPHLRT       ;GET ADDRESS OF POP H RET
  PUSH HL             ;PUSH IT ON
  PUSH DE             ;SAVE ADDRESS OF USR ROUTINE
  LD A,(VALTYP)       ;GET ARGUMENT TYPE IN [A]
  PUSH AF             ;SAVE VALTYP
  CP $03              ;STRING??
  CALL Z,GSTRCU       ;FREE IT UP
  POP AF              ;GET BACK VALTYP
  EX DE,HL            ;MOVE POSSIBLE DESC. POINTER TO [D,E]
  LD HL,FACCU         ;POINTER TO FAC IN [H,L]
  RET                 ;CALL USR ROUTINE

; This entry point is used by the routine at DEF_USR.
SCNUSR:
  CALL CHRGTB         ;GET A CHAR
  LD BC,$0000         ;ASSUME USR0
  CP ONECON+10        ;SINGLE BYTE INT EXPECTED
  JR NC,NOARGU        ;NO, MUST BE DEFAULTING TO USR0
  CP ONECON           ;IS IT SMALLER THAN ONECON
  JR C,NOARGU         ;YES, ASSUME TRYING TO DEFAULT TO USR0
  CALL CHRGTB         ;SCAN PAST NEXT CHAR
  LD A,(CONLO)        ;GET VALUE OF 1 BYTER
  OR A                ;MAKE SURE CARRY IS OFF
  RLA                 ;MULTIPLY BY 2
  LD C,A              ;SAVE OFFSET IN [C]
NOARGU:
  EX DE,HL            ;SAVE TEXT POINTER IN [D,E]
  LD HL,USR0          ;GET START OF TABLE
  ADD HL,BC           ;ADD ON OFFSET
  EX DE,HL            ;RESTORE TEXT POINTER, ADDRESS TO [D,E]
  RET                 ;RETURN FROM SCAN ROUTINE


; Routine at 7729
;
; Used by the routine at __DEF.
DEF_USR:
  CALL SCNUSR         ;SCAN THE USR NAME
  PUSH DE             ;SAVE POINTER TO USRTAB ENTRY
  CALL SYNCHR
  DEFB TK_EQUAL       ;MUST HAVE EQUAL SIGN
  CALL GETWORD        ;GET THE ADDRESS
  EX (SP),HL          ;TEXT POINTER TO STACK, GET ADDRESS
  LD (HL),E           ;SAVE USR CALL ADDRESS
  INC HL              ;BUMP POINTER
  LD (HL),D           ;SAVE HIGH BYTE OF ADDRESS
  POP HL              ;RESTORE TEXT POINTER
  RET                 ;RETURN TO NEWSTT

;
;SIMPLE-USER-DEFINED-FUNCTION CODE
;
; IN THE 8K VERSION (SEE LATER COMMENT FOR EXTENDED)
; NOTE ONLY SINGLE ARGUMENTS ARE ALLOWED TO FUNCTIONS
; AND FUNCTIONS MUST BE OF THE SINGLE LINE FORM:
; DEF FNA(X)=X^2+X-2
; NO STRINGS CAN BE INVOLVED WITH THESE FUNCTIONS
;
; IDEA: CREATE A FUNNY SIMPLE VARIABLE ENTRY
; WHOSE FIRST CHARACTER (SECOND WORD IN MEMORY)
; HAS THE 200 BIT SET.
; THE VALUE WILL BE:
;
; 	A TXTPTR TO THE FORMULA
;	THE NAME OF THE PARAMETER VARIABLE
;
; FUNCTION NAMES CAN BE LIKE "FNA4"
;

; 'DEF' BASIC instruction
__DEF:
  CP TK_USR               ;DEFINING THE CALL ADDRESS OF USR ROUTINE?
  JR Z,DEF_USR            ;YES, DO IT

; DEF FN<name>[«parameter list>}]=<function definition>
;
  CALL GETFNM             ; Get "FN" and name              ;GET A POINTER TO THE FUNCTION NAME
  CALL IDTEST             ; Error if in 'DIRECT' (immediate) mode
  EX DE,HL                ;[D,E] = THE TEXT POINTER AFTER THE FUNCTION NAME 
                          ;AND [H,L] = POINTER AT PLACE TO STORE VALUE OF THE FUNCTION VARIABLE
  LD (HL),E               ;SAVE THE TEXT POINTER AS THE VALUE
  INC HL
  LD (HL),D
  EX DE,HL                ;RESTORE THE TEXT POINTER TO [H,L]
  LD A,(HL)               ;GET NEXT CHAR
  CP '('                  ;DOES THIS FUNCTION HAVE ARGS?
  JP NZ,__DATA            ;NO, go to get next statement
  CALL CHRGTB
SCNLIS:
  CALL GETVAR             ;GET POINTER TO DUMMY VAR(CREATE VAR)
  LD A,(HL)               ;GET TERMINATOR
  CP ')'                  ;END OF ARG LIST?
  JP Z,__DATA             ;YES
  CALL SYNCHR
  DEFM ","                ;"," MUST FOLLOW THEN
  JR SCNLIS

; Routine at 7787
;
; Used by the routine at NTVARP.
DOFN:
  CALL GETFNM             ; Make sure "FN" follows and get FN name
  LD A,(VALTYP)           ;FIND OUT WHAT KIND OF FUNCTION IT IS
  OR A                    ;PUSH THIS [A] ON WITH A PSW WITH CARRY OFF SO THAT WHEN VALUES ARE
                          ;BEING POPPED OFF AND RESTORED TO PARAMETERS WE WILL KNOW WHEN TO STOP
                          ;WHEN A VALTYP IS POPPED OFF WITH CARRY OFF

  PUSH AF                 ;SAVE SO THAT THE FINAL RESULT WILL BE COERCED TO THE FUNCTION TYPE
  LD (NXTOPR),HL          ;SAVE THE TEXT POINTER THAT POINTS PAST THE FUNCTION NAME IN THE CALL
  EX DE,HL                ;[H,L]=A POINTER TO THE VALUE OF FUNCTION
  LD A,(HL)               ;[H,L]=VALUE OF THE FUNCTION
  INC HL                  ;WHICH IS A TEXT POINTER AT THE FORMAL
  LD H,(HL)               ;PARAMETER LIST IN THE DEFINITION
  LD L,A
  LD A,H                  ; Is function DEFined?
  OR L                    ;A ZERO TEXT POINTER MEANS THE FUNCTION WAS NEVER DEFINED
  JP Z,UFN_ERR            ; If not, "Undefined user function" error
  LD A,(HL)               ;SEE IF THERE ARE ANY PARAMETERS
  CP '('                  ;PARAMETER LIST STARTS WITH "(""
  JP NZ,FINVLS            ;SKIP OVER PARAMETER SETUP
  CALL CHRGTB             ;GO PAST THE "("
  LD (TEMP3),HL           ;SAVE THE TEXT POINTER TO THE START OF THE
  EX DE,HL                ;PARAMETER LIST.
  LD HL,(NXTOPR)          ;NOW GET THE TEXT-POINTER FROM THE CALL WHICH IS POINTING
                          ;JUST PAST THE FUNCTION NAME AT THE ARGUMENT LIST
  CALL SYNCHR
  DEFM "("                ;MAKE SURE THE ARGUMENT LIST IS THERE
  XOR A                   ;INDICATE END OF VALUES TO ASSIGN
  PUSH AF
  PUSH HL                 ;SAVE THE CALLERS TEXT POINTER
  EX DE,HL                ;GET THE POINTER TO THE BEGINNING OF THE PARAMETER LIST
ASGMOR:
  LD A,$80                ;OUTLAW ARRAYS WHEN SCANNING
  LD (SUBFLG),A           ;PARAMETERS
  CALL GETVAR             ;READ A PARAMETER
  EX DE,HL                ;[D,E]=PARAMETER LIST TEXT,[H,L]=VARIABLE POINTER
  EX (SP),HL              ;SAVE THE VARIABLES POSITION AND GET THE POINTER AT THE ARG LIST
  LD A,(VALTYP)           ;AND ITS TYPE (FOR COERCION)
  PUSH AF
  PUSH DE                 ;SAVE THE TEXT POINTER INTO THE PARAMETER
  CALL EVAL               ;EVALUATE THE ARGUMENT
  LD (NXTOPR),HL          ;SAVE THE ARGUMENT LIST POINTER
  POP HL                  ;AND THE PARAMETER LIST POINTER
  LD (TEMP3),HL
  POP AF                  ;GET THE VALUE TYPE
  CALL CHKTYP             ;COERCE THE ARGUMENT
  LD C,$04                ;MAKE SURE THERE IS ROOM FOR THE VALUE
  CALL CHKSTK             ; Check for C levels on stack
  LD HL,-8                ;SAVE EIGHT PLACES
  ADD HL,SP               
  LD SP,HL                
  CALL VMOVMF             ;PUT VALUE INTO RESERVED PLACE IN STACK
  LD A,(VALTYP)           ;SAVE TYPE FOR ASSIGNMENT
  PUSH AF
  LD HL,(NXTOPR)          ;REGET THE ARGUMENT LIST POINTER
  LD A,(HL)               ;SEE WHAT COMES AFTER THE ARGUMENT FORMULA
  CP ')'                  ;IS THE ARGUMENT LIST ENDING?
  JR Z,POPASG             ;MAKE SURE THE ARGUMENT LIST ALSO ENDED
  CALL SYNCHR
  DEFM ","                ;SKIP OVER ARGUMENT COMMA
  PUSH HL                 ;SAVE THE ARGUMENT LIST TEXT POINTER
  LD HL,(TEMP3)           ;GET THE TEXT POINTER INTO THE DEFINTION'S PARAMETER LIST
  CALL SYNCHR             
  DEFM ","                ;SKIP OVER THE PARAMETER LIST COMMA
  JR ASGMOR               ;AND BIND THE REST OF THE PARAMETERS

POPAS2:
  POP AF                  ;IF ASSIGNMENT IS SUCESSFUL UPDATE PRMLN2
  LD (PRMLN2),A           ;INDICATE NEW VARIABLE IS IN PLACE
POPASG:
  POP AF                  ;GET THE VALUE TYPE
  OR A
  JR Z,FINASG             ;ZERO MEANS NO MORE LEFT TO POP AND ASSIGN
  LD (VALTYP),A
  LD HL,$0000             ;POINT INTO STACK
  ADD HL,SP               ;TO GET SAVED VALUE
  CALL VMOVFM             ;PUT VALUE INTO FAC
  LD HL,$0008             ;FREE UP STACK AREA
  ADD HL,SP
  LD SP,HL
  POP DE                  ;GET PLACE TO STORE TO
  LD L,$03                ;CALCULATE THE SIZE OF THE LOOKS (NAME)
LPSIZL:
  INC L                   ;INCREMENT SIZE
  DEC DE                  ;POINT AT PREVIOUS CHARACTER
  LD A,(DE)               ;SEE IF IT IS THE LENGTH OR ANOTHER CHARACTER
  OR A
  JP M,LPSIZL             ;HIGH BIT INDICATES STILL PART OF NAME

  DEC DE                  ;BACK UP OVER LOOKS
  DEC DE
  DEC DE
  LD A,(VALTYP)           ;GET SIZE OF VALUE
  ADD A,L                 ;ADD ON SIZE OF NAME
  LD B,A                  ;SAVE TOTAL LENGTH IN [B]
  LD A,(PRMLN2)           ;GET CURRENT SIZE OF BLOCK
  LD C,A                  ;SAVE IN [C]
  ADD A,B                 ;GET POTENTIAL NEW SIZE
  CP $64                  ;CAN'T EXCEED ALLOCATED STORAGE
  JP NC,FC_ERR            ; Err $05 - "Illegal function call"
  PUSH AF                 ;SAVE NEW SIZE
  LD A,L                  ;[A]=SIZE OF NAME
  LD B,$00                ;[B,C]=SIZE OF PARM2
  LD HL,PARM2             ;BASE OF PLACE TO STORE INTO
  ADD HL,BC               ;[H,L]=PLACE TO START THE NEW VARIABLE
  LD C,A                  ;[B,C]=LENGTH OF NAME OF VARIABLE
  CALL BCTRAN             ;PUT IN THE NEW NAME
  LD BC,POPAS2            ;PLACE TO RETURN AFTER ASSIGNMENT
  PUSH BC                 
  PUSH BC                 ;SAVE EXTRA ENTRY ON STACK
  JP LETCN4               ;PERFORM ASSIGNMENT ON [H,L] (EXTRA POP D)

FINASG:
  LD HL,(NXTOPR)          ;GET ARGUMENT LIST POINTER
  CALL CHRGTB             ;SKIP OVER THE CLOSING PARENTHESIS
  PUSH HL                 ;SAVE THE ARGUMENT TEXT POINTER
  LD HL,(TEMP3)           ;GET THE PARAMETER LIST TEXT POINTER
  CALL SYNCHR
  DEFM ")"                ;MAKE SURE THE PARAMETER LIST ENDED AT THE SAME TIME

  DEFB $3E                ; SKIP THE NEXT BYTE WITH "LD A,n"

FINVLS:
  PUSH DE                 ;HERE WHEN THERE WERE NO ARGUMENTS OR PARAMETERS SAVE THE TEXT POINTER OF THE CALLER
  LD (TEMP3),HL           ;SAVE THE TEXT POINTER OF THE FUNCTION
  LD A,(PRMLEN)           ;PUSH PARM1 STUFF ONTO THE STACK
  ADD A,$04               ;WITH PRMLEN AND PRMSTK (4 BYTES EXTRA)
  PUSH AF                 ;SAVE THE NUMBER OF BYTES
  RRCA                    ;NUMBER OF TWO BYTE ENTRIES IN [A]
  LD C,A
  CALL CHKSTK             ;IS THERE ROOM ON THE STACK?
  POP AF                  ;[A]=AMOUNT TO PUT ONTO STACK
  LD C,A
  CPL                     ;COMPLEMENT [A]
  INC A
  LD L,A
  LD H,$FF
  ADD HL,SP               ;SET UP NEW STACK
  LD SP,HL                ;SAVE THE NEW VALUE FOR PRMSTK
  PUSH HL                 ;FETCH DATA FROM HERE
  LD DE,PRMSTK
  CALL BCTRAN
  POP HL                  ;LINK PARAMETER BLOCK FOR GARBAGE COLLECTION
  LD (PRMSTK),HL          ;NOW PUT PARM2 INTO PARM1
  LD HL,(PRMLN2)          ;SET UP LENGTH
  LD (PRMLEN),HL
  LD B,H
  LD C,L                  ;[B,C]=TRANSFER COUNT
  LD HL,PARM1
  LD DE,PARM2             
  CALL BCTRAN
  LD H,A                  ;CLEAR OUT PARM2
  LD L,A                  
  LD (PRMLN2),HL
  LD HL,(FUNACT)          ;INCREMENT FUNCTION COUNT
  INC HL
  LD (FUNACT),HL		  ; Count of active functions
  LD A,H
  OR L                    ;SET UP ACTIVE FLAG NON-ZERO
  LD (NOFUNS),A           ; 0 if no function active
  LD HL,(TEMP3)           ;GET BACK THE FUNCTION DEFINITION TEXT POINTER

;	DCX	H			;DETECT A MULTI-LINE FUNCTION
;	CHRGET			;IF THE DEFINITION ENDS NOW
;	JZ	MULFUN		;IF ENDS, ITS A MULTI-LINE FUNCTION

  CALL FRMEQL             ;SKIP OVER THE "=" IN THE DEFINITION AND EVALUATE THE DEFINITION FORMULA
                          ;CAN HAVE RECURSION AT THIS POINT
  DEC HL
  CALL CHRGTB             ;SEE IF THE STATEMENT ENDED RIGHT
  JP NZ,SN_ERR            ;THIS IS A CHEAT, SINCE THE LINE NUMBER OF THE ERROR WILL BE
                          ;THE CALLER'S LINE # INSTEAD OF THE DEFINITIONS LINE #
  CALL GETYPR             ;SEE IF THE RESULT IS A STRING
  JR NZ,NOCPRS            ;WHOSE DESCRIPTOR IS ABOUT TO BE WIPED OUT BECAUSE IT IS SITTING IN PARM1
                          ;(THIS HAPPENS IT THE FUNCTION IS A PROJECTION FUNCTION ON A STRING ARGUMENT)
  LD DE,DSCTMP            ;DSCTMP IS PAST ALL THE TEMP AREA
  LD HL,(FACCU)           ;GET THE ADDRESS OF THE DESCRIPTOR
  CALL DCOMPR
  JR C,NOCPRS             ;RESULT IS A TEMP - NO COPY NESC
  CALL STRCPY             ;MAKE A COPY IN DSCTMP
  CALL PUTTMP             ;PUT RESULT IN A TEMP AND MAKE FACLO POINT AT IT
NOCPRS:
  LD HL,(PRMSTK)          ;GET PLACE TO RESTORE PARM1 FROM STACK
  LD D,H
  LD E,L
  INC HL                  ;POINT AT LENGTH
  INC HL
  LD C,(HL)               ;[B,C]=LENGTH
  INC HL
  LD B,(HL)
  INC BC                  ;INCLUDE EXTRA BYTES
  INC BC
  INC BC
  INC BC
  LD HL,PRMSTK            ;PLACE TO STORE INTO
  CALL BCTRAN
  EX DE,HL                ;[D,E]=PLACE TO RESTORE STACK TO
  LD SP,HL
  LD HL,(FUNACT)          ;DECREASE ACTIVE FUNCTION COUNT
  DEC HL
  LD (FUNACT),HL
  LD A,H
  OR L                    ;SET UP FUNCTION FLAG
  LD (NOFUNS),A           ; (0 if no function active)
  POP HL                  ;GET BACK THE CALLERS TEXT POINTER
  POP AF                  ;GET BACK THE TYPE OF THE FUNCTION

; This entry point is used by the routines at __FOR, __LET and __MKD_S.
; a.k.a. DOCNVF (=force type conversion)
CHKTYP:
  PUSH HL                 ;SAVE THE TEXT POINTER
  AND $07                 ;SETUP DISPATCH TO FORCE FORMULA TYPE 
                          ;TO CONFORM TO THE VARIABLE ITS BEING ASSIGNED TO
  LD HL,TYPE_OPR          ;TABLE OF FORCE ROUTINES
  LD C,A                  ;[B,C]=TWO BYTE OFFSET
  LD B,$00
  ADD HL,BC
  CALL DISPAT             ;DISPATCH
  POP HL                  ;GET BACK THE TEXT POINTER
  RET
  
;
; BLOCK TRANSFER ROUTINE WITH SOURCE IN [D,E] DESTINATION IN [H,L]
; AND COUNT IN [B,C]. TRANSFER IS FORWARD.
;
BCTRAL:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
BCTRAN:
  LD A,B
  OR C
  JR NZ,BCTRAL
  RET

; Routine at 8157
;
;
; SUBROUTINE TO SEE IF WE ARE IN DIRECT MODE AND COMPLAIN IF SO
;
; Check for a running program (Z if so).  If a program is not running, generate
; an Illegal Direct (ID) error.
;
; Used by the routine at __DEF.
IDTEST:
  PUSH HL                 ; Save code string address                  ;SAVE THEIR [H,L]
  LD HL,(CURLIN)          ; Get current line number                   ;SEE WHAT THE CURRENT LINE IS
  INC HL                  ; -1 means direct statement                 ;DIRECT IS 65,535 SO NOW 0
  LD A,H
  OR L                                                                ;IS IT ZERO NOW?
  POP HL                  ; Restore code string address
  RET NZ                  ; Return if in program                      ;RETURN IF NOT
  LD E,$0C                ; Err $0C - "Illegal direct" (ID_ERROR)     ;"ILLEGAL DIRECT" ERROR
  JP ERROR


;
; SUBROUTINE TO GET A POINTER TO A FUNCTION NAME
; Make sure "FN" follows and get FN name
;
; Used by the routines at __DEF and DOFN.
GETFNM:
  CALL SYNCHR             ; Make sure FN follows
  DEFB TK_FN              ;MUST START WITH "FN"
  LD A,$80                ;DONT ALLOW AN ARRAY,
  LD (SUBFLG),A           ;DON'T RECOGNIZE THE "(" AS THE START OF AN ARRAY REFEREENCE
  OR (HL)                 ; FN name has bit 7 set      ;PUT FUNCTION BIT ON
  LD C,A                  ; in first byte of name      ;GET FIRST CHARACTER INTO [C]
  JP GTFNAM               ; Get FN name

; Routine at 8185
;
; STRING FUNCTIONS - LEFT HAND SIDE MID$
; Used by the routine at EXEC.
ISMID:
  CP $FF-TK_END           ;LHS MID$?                   ;FUNCTION? (FF - $END)
  JP NZ,SN_ERR            ;NO, ERROR.
  INC HL                  ;POINT TO NEXT CHAR
  LD A,(HL)               ;GET FN DESCRIPTOR
  INC HL                  ;BUMP POINTER                ;POINT TO CHAR AFTER
  CP $80+TK_MID_S         ;IS IT MID?
  JP Z,LHSMID
  JP SN_ERR               ;NO, ERROR

;
; THE FOLLOWING FUNCTIONS ALLOW THE 
; USER FULL ACCESS TO THE ALTAIR I/O PORTS
; INP(CHANNEL#) RETURNS AN INTEGER WHICH IS THE STATUS
; OF THE CHANNEL. OUT CHANNEL#,VALUE PUTS OUT THE INTEGER
; VALUE ON CHANNEL #. IT IS A STATEMENT, NOT A FUNCTION.
;
; a.k.a. FNINP

IF ORIGINAL | __CPU_8080__ | __CPU_8085__
__INP:
  CALL CONINT             ;GET INTEGER CHANNEL #
  LD (INPORT),A           ;GEN INP INSTR
  DEFB $DB                ;IN A,(n)  ..THE INP INSTR
INPORT:
  DEFB $00                ; Current port for 'INP' function
  JP PASSA                ;SNGFLT RESULT
ELSE
  ; 16 bit port addresses
__INP:
  CALL GETWORD_HL    ;GET INTEGER CHANNEL #
  LD B,H
  LD C,L
__INP_0:
  IN A,(C)
  JP PASSA

ENDIF


IF ORIGINAL | __CPU_8080__ | __CPU_8085__
; 'OUT' BASIC command
__OUT:
  CALL SETIO              ;GET READY
  DEFB $D3                ; OUT (n),A  ..DO THE "OUT" AND RETURN
OTPORT:
  DEFB $00                ; Current port for 'OUT' statement
  RET


; 'WAIT' BASIC command, a.k.a. FNWAIT
;
; THE WAIT CHANNEL#,MASK,MASK2 WAITS UNTIL THE STATUS
; RETURNED BY CHANNEL# IS NON ZERO WHEN XORED WITH MASK2
; AND THEN ANDED WITH MASK. IF MASK2 IS NOT PRESENT IT IS ASSUMED
; TO BE ZERO.
;
__WAIT:
  CALL SETIO              ;SET UP FOR WAIT
  PUSH AF                 ;SAVE THE MASK
  LD E,$00                ;DEFAULT MASK2 TO ZERO
  DEC HL
  CALL CHRGTB             ;SEE IF THE STATEMENT ENDED
  JR Z,__WAIT_0           ;IF NO THIRD ARGUMENT SKIP THIS
  CALL SYNCHR
  DEFM ","                ;MAKE SURE THERE IS A ","
  CALL GETINT             ; Get integer 0-255
__WAIT_0:
  POP AF                  ;REGET THE "AND" MASK
  LD D,A
__WAIT_1:
  DEFB $DB                ; IN A,(n)     ..THE INPUT INSTR
WAIT_INPORT:
  DEFB $00                ; Current port for 'INP' function
  XOR E                   ;XOR WITH MASK2
  AND D                   ;AND WITH MASK
  JR Z,__WAIT_1           ;LOOP UNTIL RESULT IS NON-ZERO
  RET
					;NOTE: THIS LOOP CANNOT BE CONTROL-C'ED
					;UNLESS THE WAIT IS BEING DONE ON CHANNEL
					;ZERO. HOWEVER A RESTART AT 0 IS OK.

ELSE

; 16 bit port addresses

; Get "WORD,BYTE" parameters
SETIO:
  CALL GETWORD      ; GET INTEGER CHANNEL NUMBER
  PUSH DE           ; Save channel # on stack
  CALL SYNCHR
  DEFB ','          ;MAKE SURE THERE IS A COMMA
  CALL GETINT       ; Get integer 0-255
  POP BC            ; BC = channel #
  RET

__OUT:
IF BIT_PLAY
  CP '!'            ; New Syntax.  SAVE! replaces CSAVE, we ran out of space for TOKEN codes !
  JP Z,__PLAY
  CP '@'            ; New Syntax.  SAVE! replaces CSAVE, we ran out of space for TOKEN codes !
  JP Z,__SOUND
ENDIF
  CALL SETIO		; Get "WORD,BYTE" parameters
  OUT (C),A
  RET


; 'WAIT' BASIC command
__WAIT:
  CALL SETIO
  PUSH BC
  PUSH AF
  LD E,$00
  DEC HL
  CALL CHRGTB
  JR Z,__WAIT_0
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
__WAIT_0:
  POP AF
  POP BC
  LD D,A
__WAIT_1:
  IN A,(C)
;  DEFB $DB                ; IN A,(n)
;WAIT_INPORT:
;  DEFB $00                ; Current port for 'INP' function
  XOR E
  AND D
  JR Z,__WAIT_1
  RET

ENDIF

IF ORIGINAL
CONSOL:
  JP SN_ERR			; ???
ENDIF


; 'WIDTH' BASIC command
; THIS IS THE WIDTH (TERMINAL WIDTH) COMMAND
; ARG MUST BE .GT. 15 AND .LT. 255
;
; WIDTH [LPRINT] <integer expression>
; To set the printed line width in number of characters for the terminal or line printer.
;
__WIDTH:
  CP TK_LPRINT            ;WIDTH LPRINT?
  JR NZ,NOTWLP            ;NO
  CALL CHRGTB             ;FETCH NEXT CHAR
  CALL GETINT             ;GET WIDTH
  LD (LPTSIZ),A           ;SAVE IT
IF ORIGINAL
  LD E,A                  ; (probably not needed)
ENDIF
  CALL __WIDTH_1          ;COMPUTE LAST COMMA COLUMN
  LD (COMMAN),A           ;SAVE IT
  RET

NOTWLP:
  CALL GETINT             ;GET THE CHANNEL #
  LD (LINLEN),A           ;SETUP THE LINE LENGTH
IF ORIGINAL
  LD E,A                  ; (probably not needed)
ENDIF
  CALL __WIDTH_1          ;COMPUTE LAST COMMA COLUMN
  LD (NCMPOS),A           ;SET LAST COMMA POSITION
  RET                     ;DONE

__WIDTH_1:
  SUB CLMWID
  JR NC,__WIDTH_1
  ADD A,2*CLMWID
  CPL
  INC A
  ADD A,E
  RET                     ;BACK TO NEWSTT


; Get subscript
;
; Used by the routine at FORFND.
FPSINT:
  CALL CHRGTB
; This entry point is used by the routines at INTIDX and __TAB.
FPSINT_0:
  CALL EVAL               ;EVALUATE A FORMULA

; Get integer variable to DE, error if negative
;
; Used by the routine at CONINT.
;CONVERT THE FAC TO AN INTEGER IN [D,E]
;AND SET THE CONDITION CODES BASED ON THE HIGH ORDER
DEPINT:
  PUSH HL                 ;SAVE THE TEXT POINTER
  CALL __CINT             ;CONVERT THE FORMULA TO AN INTEGER IN [H,L]
  EX DE,HL                ;PUT THE INTEGER INTO [D,E]
  POP HL                  ;RETSORE THE TEXT POINTER
  LD A,D                  ;SET THE CONDITION CODES ON THE HIGH ORDER
  OR A
  RET

IF ORIGINAL | __CPU_8080__ | __CPU_8085__
; Get "BYTE,BYTE" parameters
;
; Used by the routines at __OUT and __WAIT.
SETIO:
  CALL GETINT             ;GET INTEGER CHANNEL NUMBER IN [A]
  LD (WAIT_INPORT),A      ;SETUP "WAIT"
  LD (OTPORT),A           ;SETUP "OUT"
  CALL SYNCHR
  DEFM ","                ;MAKE SURE THERE IS A COMMA
  JR GETINT               ; Get integer 0-255
ENDIF

; Load 'A' with the next number in BASIC program
;
; Used by the routines at __ERL and __FIELD.
; a.k.a. GTBYTC:  pick a numeric argument (0..255)
FNDNUM:
  CALL CHRGTB

; Get a number to 'A'
;
; Used by the routines at __ON, __ERROR, ISFUN, __WAIT, __WIDTH,
; SETIO, __POKE, __OPEN, RETRTS, FN_INPUT, __NULL, FN_STRING,
; FN_INSTR and MID_ARGSEP.

; a.k.a. GETBYT, get integer in 0-255 range
GETINT:
  CALL EVAL               ;EVALUATE A FORMULA

; Convert tmp string to int in A register
;
; Used by the routines at __INP, FILGET, __CHR_S, FN_STRING, __SPACE_S
; and FN_INSTR.
CONINT:
  CALL DEPINT             ;CONVERT THE FAC TO AN INTEGER IN [D,E]
  JP NZ,FC_ERR            ;WASN'T ERROR (Err $05 - "Illegal function call")
  DEC HL                  ;ACTUALLY FUNCTIONS CAN GET HERE
                          ;WITH BAD [H,L] BUT NOT SERIOUS
                          ;SET CONDITION CODES ON TERMINATOR
  CALL CHRGTB
  LD A,E                  ;RETURN THE RESULT IN [A] AND [E]
  RET


; 'LLIST' BASIC command
;
__LLIST:                  ;PRTFLG=1 FOR REGULAR LIST
  LD A,$01                ;GET NON ZERO VALUE
  LD (PRTFLG),A           ;SAVE IN I/O FLAG (END OF LPT)

; 'LIST' BASIC command
;
; Used by the routine at __MERGE.
__LIST:
  POP BC                  ;GET RID OF NEWSTT RETURN ADDR
  CALL LNUM_RANGE         ;SCAN LINE RANGE
  PUSH BC                 ;SAVE POINTER TO 1ST LINE
  CALL PROCHK   		  ;DONT EVEN LIST LINE #
__LIST_0:
  LD HL,-1                ;DONT ALLOW ^C TO CHANGE
  LD (CURLIN),HL          ;CONTINUE PARAMETERS:  Set interpreter in 'DIRECT' (immediate) mode
  POP HL                  ;GET POINTER TO LINE
  POP DE                  ;GET MAX LINE # OFF STACK
  LD C,(HL)               ;[B,C]=THE LINK POINTING TO THE NEXT LINE
  INC HL
  LD B,(HL)
  INC HL
  LD A,B                  ;SEE IF END OF CHAIN
  OR C
  JP Z,READY              ;LAST LINE, STOP.  
  CALL ISFLIO             ;DON'T ALLOW ^C ON FILE OUTPUT
  CALL Z,ISCNTC           ;CHECK FOR CONTROL-C
  PUSH BC                 ;SAVE LINK
  LD C,(HL)               ;PUSH THE LINE #
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  EX (SP),HL              ;GET LINE # INTO [H,L]
  EX DE,HL                ;GET MAX LINE IN [H,L]
  CALL DCOMPR             ;PAST LAST LINE IN RANGE?
  POP BC                  ;TEXT POINTER TO [B,C]
  JP C,RESTART            ;IF PAST, THEN DONE LISTING.
  EX (SP),HL              ;SAVE MAX ON BOTTOM OF STACK
  PUSH HL                 ;SAVE LINK ON TOP
  PUSH BC                 ;SAVE TEXT POINTER BACK
  EX DE,HL                ;GET LINE # IN [H,L]
  LD (DOT),HL             ;SAVE FOR LATER EDIT OR LIST <> AND WE WANT [H,L] ON THE STACK
  CALL LINPRT             ;PRINT AS INT WITHOUT LEADING SPACE
  POP HL
  LD A,(HL)               ;GET BYTE FROM LINE
  CP $09                  ;IS IT A TAB?
  JR Z,__LIST_1           ;THEN DONT PRINT SPACE
  LD A,' '
  CALL OUTDO              ;PRINT A SPACE AFTER THE LINE #
__LIST_1:
  CALL DETOKEN_LIST       ;UNPACK THE LINE INTO BUF
  LD HL,BUF               ;POINT AT THE START OF THE UNPACKED CHARACTERS
  CALL LISPRT             ;PRINT THE LINE
  CALL OUTDO_CRLF         ;PRINT CRLF
  JR __LIST_0             ;GO BACK FOR NEXT LINE

; Routine at 8435
;
; Used by the routines at __LIST, TTYLIN, NOTDGI and EDIT_DONE.
LISPRT:
  LD A,(HL)
  OR A                    ;SET CC
  RET Z                   ;IF =0 THEN END OF LINE
  CALL OUTCH1             ;OUTPUT CHAR AND CHECK FOR LF
  INC HL                  ;INCR POINTER
  JR LISPRT               ;PRINT NEXT CHAR

; This entry point is used by the routines at __LIST and __EDIT.
DETOKEN_LIST:
  LD BC,BUF               ;GET START OF TEXT BUFFER
  LD D,$FF                ;GET ITS LENGTH INTO [D]
  XOR A                   ;SET ON SPECIAL CHAR FOR SPACE INSERTION
  LD (INTFLG),A           ; in other versions DORES, OPRTYP, TEMPA.. are used
  CALL PROCHK             ;ONLY PROCEED IF OK
  JR PLOOP2               ;START HERE
  
DETOKEN_NEXT_1:
  INC BC                   ;INCREMENT DEPOSIT PTR.
  INC HL                   ;ADVANCE TEXT PTR
  DEC D                    ;BUMP DOWN COUNT
  RET Z                    ;IF BUFFER FULL, RETURN
; This entry point is used by the routine at CONLIN.
PLOOP2:
  LD A,(HL)                ;GET CHAR FROM BUF
  OR A                     ;SET CC'S
  LD (BC),A                ;SAVE THIS CHAR
  RET Z                    ;IF END OF SOURCE BUFFER, ALL DONE.
  CP OCTCON                ;IS IT SMALLER THAN SMALLEST EMBEDDED CONSTANT?   (Not a number constant prefix ?)
  JR C,NTEMBL              ;YES, DONT TREAT AS ONE
  CP DBLCON+1              ;IS IT EMBEDED CONSTANT?
  LD E,A                                                 ;SAVE CHAR IN [E]
  JR C,PRTVAR              ; JP if control code     	;PRINT LEADING SPACE IF NESC.
NTEMBL:
  OR A                     ;SET CC'S
  JP M,PLOOPR              ;RESERVED WORD OF SOME KIND
  LD E,A                   ;SAVE CHAR IN [E]
  CP '.'                   ;DOT IS PART OF VAR NAME
  JR Z,PRTVAR
  CALL TSTANM              ;IS CHAR ALPHANUMERIC
  JR NC,PRTVAR             ;ALPHANUMERIC
  XOR A                    ;MAKE SPECIAL
  JR DETOKEN_NEXT_6
PRTVAR:
  LD A,(INTFLG)            ;WHAT DID WE DO LAST?
  OR A                     ;SET CONDITION CODES
  JR Z,PLOOPG              ;SPECIAL, NEVER INSERT SPACE
  INC A                    ;IN RESERVED WORD?
  JR NZ,PLOOPG             ;NO
  LD A,' '                 ;PUT OUT SPACE BEFORE RESWORD
  LD (BC),A                ;STORE IN BUFFER
  INC BC                   ;INCRMENT POINTER INTO BUFFER
  DEC D                    ;SPACE LEFT?
  RET Z                    ;NO, DONE
PLOOPG:
  LD A,$01                 ;STORE FLAG SAYING IN VAR
DETOKEN_NEXT_6:
  LD (INTFLG),A
  LD A,E
  CP OCTCON                ;IS IT SMALLER THAN SMALLEST EMBEDDED CONSTANT? (Not a number constant prefix ?)
  JR C,PLOOPZ           ; ...then JP
  CP DBLCON+1                   ;IS IT EMBEDED CONSTANT?
  JP C,NUMLIN           ; JP if control code
PLOOPZ:
  LD (BC),A
  JR DETOKEN_NEXT_1

PLOOPR:
  INC A                  ;SET ZERO IF FN TOKEN
  LD A,(HL)              ;GET CHAR BACK
  JR NZ,NTFNTK           ;NOT FUNCTION JUST TREAT NORMALLY
  INC HL                 ;BUMP POINTER
  LD A,(HL)              ;GET CHAR
  AND $7F                ;TURN OFF HIGH BIT
NTFNTK:
  INC HL                 ;ADVANCE TO POINT AFTER
  CP TK_APOSTROPHE       ;SINGLE QUOTE TOKEN?
  JR NZ,NTQTTK           ;NO, JUMP OUT
  DEC BC                 ;MOVE DEPOSIT PTR BACK OVER :$REM
  DEC BC
  DEC BC
  DEC BC
  INC D
  INC D
  INC D
  INC D                  ;FIX UP CHAR COUNT
NTQTTK:
  CP TK_ELSE             ;ELSE?
  CALL Z,DCXBRT          ;MOVE DEPOSIT PTR BACK OVER LEADING COLON.
  CP TK_WHILE
  JR NZ,FNDWRD
  LD A,(HL)
  INC HL
  CP TK_PLUS			; Token for '+'
  LD A,TK_WHILE
  JR Z,FNDWRD
  DEC HL
FNDWRD:
  PUSH HL                 ;SAVE TEXT PTR.
  PUSH BC                 ;SAVE DEPOSIT PTR.
  PUSH DE                 ;SAVE CHAR COUNT.
  LD HL,WORDS-1           ;GET PTR TO START OF RESERVED WORD LIST
  LD B,A                  ;SAVE THIS CHAR IN [B]
  LD C,'A'-1              ;INIT LEADING CHAR VALUE
RESSR3:
  INC C                   ;BUMP LEADING CHAR VALUE.
RESSR1:
  INC HL                  ;BUMP POINTER INTO RESLST
  LD D,H                  ;SAVE PTR TO START OF THIS RESWRD
  LD E,L
RESSRC:
  LD A,(HL)               ;GET CHAR FROM RESLST
  OR A                    ;SET CC'S
  JR Z,RESSR3             ;IF END OF THIS CHARS TABLE, GO BACK & BUMP C
  INC HL                  ;BUMP SOURCE PTR
  JP P,RESSRC             ;IF NOT END OF THIS RESWRD, THEN KEEP LOOKING
  LD A,(HL)               ;GET PTR TO RESERVED WORD VALUE
  CP B                    ;SAME AS THE ONE WE SEARCH FOR?
  JR NZ,RESSR1            ;NO, KEEP LOOKING.
  EX DE,HL                ;SAVE FOUND PTR IN [H,L]
  CP TK_USR               ;USR FUNCTION TOKEN?
  JR Z,NOISPA             ;DONT INSERT SPACE
  CP TK_FN                ;IS IT FUNCTION TOKEN?
NOISPA:
  LD A,C                  ;GET LEADING CHAR
  POP DE                  ;RESTORE LINE CHAR COUNT
  POP BC                  ;RESTORE DEPOSIT PTR
  LD E,A                  ;SAVE LEADING CHAR
  JR NZ,NTFNEX            ;NOT "FN" EXPANSION
  LD A,(INTFLG)           ;SET CC'S ON TEMPA(=INTFLG)
  OR A
  LD A,$00
  LD (INTFLG),A
  JR MORLNZ

NTFNEX:
  CP 'Z'+1                ;WAS IT A SPECIAL CHAR?
  JR NZ,NTSPCH            ;NON-SPECIAL CHAR
  XOR A                   ;SET NON-SPECIAL
  LD (INTFLG),A
  JR MORPUR               ;PRINT IT

NTSPCH:
  LD A,(INTFLG)           ;WHAT DID WE DO LAST?
  OR A                    ;SPECIAL?
  LD A,$FF                ;FLAG IN RESERVED WORD
  LD (INTFLG),A           ;CLEAR FLAG
MORLNZ:
  JR Z,MORLN0             ;GET CHAR AND PROCEED
  LD A,' '                ;PUT SPACE IN BUFFER
  LD (BC),A
  INC BC
  DEC D                   ;ANY SPACE LEFT IN BUFFER
  JP Z,POPAF              ;NO, RETURN
  
MORLN0:
  LD A,E
  JR MORLN1               ;CONTINUE

MORPUR:
  LD A,(HL)               ;GET BYTE FROM RESWRD
  INC HL                  ;BUMP POINTER
  LD E,A
MORLN1:
  AND $7F                 ;AND OFF HIGH ORDER BIT FOR DISK & EDIT
  LD (BC),A               ;STORE THIS CHAR
  INC BC                  ;BUMP PTR
  DEC D                   ;BUMP DOWN REMAINING CHAR COUNT
  JP Z,POPAF              ;IF END OF LINE, JUST RETURN
  OR E                    ;SET CC'S
  JP P,MORPUR             ;END OF RESWRD?
  CP '('+128              ;SPC( OR TAB( ?
  JR NZ,NTSPCT            ;NO
  XOR A                   ;CLEAR FLAG
  LD (INTFLG),A           ;TO INSERT SPACE AFTERWARDS
NTSPCT:
  POP HL                  ;RESTORE SOURCE PTR.
  JP PLOOP2               ;GET NEXT CHAR FROM LINE

; This entry point is used by the routine at CRNCH_MORE.
TSTANM:
  CALL ISLETTER_A         ;YES
  RET NC                  ;DIGIT?
  CP '0'                  ;TOO SMALL
  RET C                   ;LAST DIGIT
  CP '9'+1                ;MAKE CARRY RIGHT
  CCF                     ;NO CARRY=DIGIT
  RET

NUMLIN:
  DEC HL                  ;MOVE POINTER BACK AS CHRGET INX'S
  CALL CHRGTB             ;SCAN THE CONSTANT
  PUSH DE                 ;SAVE CHAR COUNT
  PUSH BC                 ;SAVE DEPOSIT PTR
  PUSH AF                 ;SAVE CONSTANT TYPE.
  CALL CONFAC             ;MOVE CONSTANT INTO FAC
  POP AF                  ;RESTORE CONSTANT TYPE
  LD BC,CONLIN            ;PUT RETURN ADDR ON STACK
  PUSH BC                 ;SAVE IT
  CP OCTCON               ;OCTAL CONSTANT?
  JP Z,FOUTO              ;PRINT IT
  CP HEXCON               ;HEX CONSTANT?
  JP Z,FOUTH              ;PRINT IN HEX
  LD HL,(CONLO)           ;GET LINE # VALUE IF ONE.
  JP FOUT                 ;PRINT REMAINING POSSIBILITIES.

; 8739
CONLIN:
  POP BC                  ;RESTORE DEPOSIT PTR.
  POP DE                  ;RESTORE CHAR COUNT
  LD A,(CONSAV)           ;GET SAVED CONSTANT TOKEN
  LD E,'O'                ;ASSUME OCTAL CONSTANT
  CP OCTCON               ;OCTAL CONSTANT?
  JR Z,SAVBAS             ;YES, PRINT IT
  CP HEXCON               ;HEX CONSTANT?
  LD E,'H'                ;ASSUME SO.
  JR NZ,NUMSLN            ;NOT BASE CONSTANT
SAVBAS:
  LD A,'&'                ;PRINT LEADING BASE INDICATOR
  LD (BC),A               ;SAVE IT
  INC BC                  ;BUMP PTR
  DEC D                   ;BUMP DOWN CHAR COUNT
  RET Z                   ;RETURN IF END OF BUFFER
  LD A,E                  ;GET BASE CHAR
  LD (BC),A               ;SAVE IT
  INC BC                  ;BUMP PTR
  DEC D                   ;BUMP DOWN BASE COUNT
  RET Z                   ;END OF BUFFER, DONE
NUMSLN:
  LD A,(CONTYP)     	  ;GET TYPE OF CONSTANT WE ARE
  CP $04                  ;IS IT SINGLE OR DOUBLE PREC?
  LD E,$00                ;NO, NEVER PRINT TRAILING TYPE INDICATOR
  JR C,TYPSET         
  LD E,'!'                ;ASSUME SINGLE PREC.
  JR Z,TYPSET             ;IS CONTYP=4, WAS SINGLE
  LD E,'#'                ;DOUBLE PREC INDICATOR
TYPSET:
  LD A,(HL)               ;GET LEADING CHAR
  CP ' '                  ;LEADING SPACE
  CALL Z,INCHL            ;GO BY IT
NUMSL2:
  LD A,(HL)               ;GET CHAR FROM NUMBER BUFFER
  INC HL                  ;BUMP POINTER
  OR A                    ;SET CC'S
  JR Z,NUMDN              ;IF ZERO, ALL DONE.
  LD (BC),A               ;SAVE CHAR IN BUF.
  INC BC                  ;BUMP PTR
  DEC D                   ;SEE IF END OF BUFFER
  RET Z                   ;IF END OF BUFFER, RETURN
  LD A,(CONTYP)           ;GET TYPE OF CONSTANT TO BE PRINTED
  CP $04                  ;TEST FOR SINGLE OR DOUBLE PRECISION
  JR C,NUMSL2             ;NO, WAS INTEGER
  DEC BC                  ;PICK UP SAVED CHAR
  LD A,(BC)               ;EASIER THAN PUSHING ON STACK
  INC BC                  ;RESTORE TO POINT WHERE IT SHOULD
  JR NZ,DBLSCN            ;IF DOUBLE, DONT TEST FOR EMBEDED "."
  CP '.'                  ;TEST FOR FRACTION  ; $2E
  JR Z,ZERE               ;IF SINGLE & EMBEDED ., THEN DONT PRINT !   
DBLSCN: 
; Double Precision specifier (exponential syntax, e.g. -1.09432D-06)                   
  CP 'D'                  ;DOUBLE PREC. EXPONENT?
  JR Z,ZERE               ;YES, MARK NO VALUE TYPE INDICATOR NESC.
; Exponential format specifier (e.g. -1.09E-06)
  CP 'E'                  ;SINGLE PREC. EXPONENT?
  JR NZ,NUMSL2            ;NO, PROCEED
ZERE:
  LD E,$00                ;MARK NO PRINTING OF TYPE INDICATOR
  JR NUMSL2               ;KEEP MOVING NUMBER CHARS INTO BUF
  
NUMDN:
  LD A,E                  ;GET FLAG TO INDICATE WHETHER TO INSERT
  OR A                    ;A "D" AFTER DOUBLE PREC. #
  JR Z,NOD                ;NO, DONT INSERT IT
  LD (BC),A               ;SAVE IN BUFFER
  INC BC                  ;BUMP POINTER
  DEC D                   ;DECRMENT COUNT OF CHARS LEFT IN BUFFER
  RET Z                   ;=0, MUST TRUNCATE LIST OF THIS LINE.
NOD:
  LD HL,(CONTXT)          ;GET BACK TEXT POINTER AFTER CONSTANT
  JP PLOOP2               ;GET NEXT CHAR

;
; THE FOLLOWING CODE IS FOR THE DELETE RANGE
; COMMAND. BEFORE THE LINES ARE DELETED, 'OK'
; IS TYPED.
;
; 'DELETE' BASIC command
__DELETE:
  CALL LNUM_RANGE         ;SCAN LINE RANGE
  PUSH BC
  CALL DEPTR              ;CHANGE POINTERS BACK TO NUMBERS
  POP BC
  POP DE                  ;POP MAX LINE OFF STACK
  PUSH BC                 ;SAVE POINTER TO START OF DELETION FOR USE BY CHEAD AFTER FINI
  PUSH BC                 ;SAVE POINTER TO START OF 1ST LINE
  CALL SRCHLN             ;FIND THE LAST LINE
  JR NC,_FCERRG           ;MUST HAVE A MATCH ON THE UPPER BOUND
  LD D,H                  ;[D,E] =  POINTER AT THE START OF THE LINE
  LD E,L                  ;BEYOND THE LAST LINE IN THE RANGE
  EX (SP),HL              ;SAVE THE POINTER TO THE NEXT LINE
  PUSH HL                 ;SAVE THE POINTER TO THE START OF THE FIRST LINE IN THE RANGE
  CALL DCOMPR             ;MAKE SURE THE START COMES BEFORE THE END
_FCERRG:
  JP NC,FC_ERR            ;IF NOT, "ILLEGAL FUNCTION CALL"
  LD HL,OK_MSG            ;PRINT "OK" PREMATURELY
  CALL PRS
  POP BC                  ;GET POINTER TO FIRST IN [B,C]
  LD HL,FINI              ;GO BACK TO FINI WHEN DONE
  EX (SP),HL              ;[H,L]=POINTER TO THE NEXT LINE

;
; ERASE A LINE FROM MEMORY
; [B,C]=START OF LINE BEING DELETED
; [D,E]=START OF NEXT LINE
;
; This entry point is used by the routines at PROMPT and CAYSTR.
__DELETE_0:
  EX DE,HL                ;[D,E] NOW HAVE THE POINTER TO THE LINE BEYOND THIS ONE
  LD HL,(VARTAB)          ;COMPACTIFYING TO VARTAB
MLOOP:
  LD A,(DE)
  LD (BC),A               ;SHOVING DOWN TO ELIMINATE A LINE
  INC BC
  INC DE
  CALL DCOMPR
  JR NZ,MLOOP             ;DONE COMPACTIFYING?
  LD H,B
  LD L,C
  LD (VARTAB),HL
  RET

;
; NOTE: IN THE 8K PEEK ONLY ACCEPTS POSITIVE NUMBERS UP TO 32767
; POKE WILL ONLY TAKE AN ADDRESS UP TO 32767 , NO
; FUDGING ALLOWED. THE VALUE IS UNSIGNED.
; IN THE EXTENDED VERSION NEGATIVE NUMBERS CAN BE
; USED TO REFER TO LOCATIONS HIGHER THAN 32767.
; THE CORRESPONDENCE IS GIVEN BY SUBTRACTING 65536 FROM LOCATIONS
; HIGHER THAN 32767 OR BY SPECIFYING A POSITIVE NUMBER UP TO 65535.
;

__PEEK:
  CALL GETWORD_HL         ;GET AN INTEGER IN [H,L]
  CALL PRODIR             ;DONT ALLOW DIRECT IF PROTECTED FILE
  LD A,(HL)               ;GET THE VALUE TO RETURN
  JP PASSA                ;AND FLOAT IT

; 'POKE' BASIC command
__POKE:
  CALL GETWORD            ;READ A FORMULA
  PUSH DE
  CALL PRODIR             ;DONT ALLOW DIRECT IF PROTECTED FILE
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
  POP DE
  LD (DE),A
  RET

; Get a number to DE
; a.k.a. FRMQNT
; This entry point is used by the routines at DEF_USR and __CLEAR.
GETWORD:
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  EX DE,HL
  POP HL
  RET

; This entry point is used by the routines at __DELETE, FOUTH, __CALL and
; __CHAIN.
GETWORD_HL:
  LD BC,__CINT            ;RETURN HERE
  PUSH BC                 ;SAVE ADDR
  CALL GETYPR             ;SET THE CC'S ON VALTYPE
  RET M                   ;RETURN IF ALREADY INTEGER.
  LD A,(FPEXP)            ;GET EXPONENT
  CP $90                  ;IS MAGNITUDE .GT. 32767
  RET NZ
  CALL SIGN
  RET M
  CALL __CSNG
  LD BC,$9180		; -65536
  LD DE,$0000
  JP FADD


; 'RENUM' BASIC command
;
; THE RESEQ(UENCE) COMMAND TAKE UP TO THREE ARGUMENTS
; RESEQ [NN[,MM[,INC]]]
; WHERE NN IS THE FIRST DESTINATION LINE OF THE
; LINES BEING RESEQUENCED, LINES LESS THAN MM ARE
; NOT RESEQUENCED, AND INC IS THE INCREMENT.
;
__RENUM:
  LD BC,10             	;ASSUME INC=10
  PUSH BC              	;SAVE ON STACK
  LD D,B                ;RESEQ ALL LINES BY SETTING [D,E]=0
  LD E,B
  JR Z,__RENUM_1        ;IF JUST 'RESEQ' RESEQ 10 BY 10
  CP ','                ;COMMA
  JR Z,__RENUM_0        ;DONT USE STARTING # OF ZERO
  PUSH DE               ;SAVE [D,E]
  CALL LNUM_PARM        ;GET NEW NN
  LD B,D                ;GET IN IN [B,C] WHERE IT BELONGS
  LD C,E
  POP DE                ;GET BACK [D,E]
  JR Z,__RENUM_1        ;IF EOS, DONE
__RENUM_0:
  CALL SYNCHR
  DEFM ","              ;EXPECT COMMA
  CALL LNUM_PARM        ;GET NEW MM
  JR Z,__RENUM_1        ;IF EOS, DONE
  POP AF                ;GET RID OF OLD INC
  CALL SYNCHR
  DEFM ","              ;EXPECT COMMA
  PUSH DE               ;SAVE MM
  CALL ATOH             ;GET NEW INC
  JP NZ,SN_ERR          ;SHOULD HAVE TERMINATED.
  LD A,D                ;SEE IF INC=0 (ILLEGAL)
  OR E
  JP Z,FC_ERR           ;YES, BLOW HIM UP NOW (Err $05 - "Illegal function call")
  EX DE,HL              ;FLIP NEW INC & [H,L]
  EX (SP),HL            ;NEW INC ONTO STACK
  EX DE,HL              ;GET [H,L] BACK, ORIG [D,E] BACK
__RENUM_1:
  PUSH BC               ;SAVE NN ON STACK
  CALL SRCHLN           ;FIND MM LINE
  POP DE                ;GET NN OFF STACK
  PUSH DE               ;SAVE NN BACK
  PUSH BC               ;SAVE POINTER TO MM LINE
  CALL SRCHLN           ;FIND FIRST LINE TO RESEQ.
  LD H,B                ;GET PTR TO THIS LINE IN [H,L]
  LD L,C                
  POP DE                ;GET LINE PTD TO BY MM
  CALL DCOMPR           ;COMPARE TO FIRST LINE RESEQED
  EX DE,HL              ;GET PTR TO MM LINE IN [H,L]
  JP C,FC_ERR           ;CANT ALLOW PROGRAM TO BE RESEQUED ON TOP OF ITSELF (Err $05 - "Illegal function call")
  POP DE                ;GET NN BACK
  POP BC                ;GET INC IN [B,C]
  POP AF                ;GET RID OF NEWSTT
  PUSH HL               ;SAVE PTR TO FIRST LINE TO RESEQ.
  PUSH DE               ;SAVE NN ON STACK
  JR __RENUM_NXT_0
  
__RENUM_NXT:
  ADD HL,BC             ;ADD INCREMENT INTO
  JP C,FC_ERR           ;UH OH, HIS INC WAS TOO LARGE. (Err $05 - "Illegal function call")
  EX DE,HL              ;FLIP LINK FIELD, ACCUM.
  PUSH HL               ;SAVE LINK FIELD
  LD HL,65529           ;TEST FOR TOO LARGE LINE
  CALL DCOMPR           ;COMPARE TO CURRENT #
  POP HL                ;RESTORE LINK FIELD
  JP C,FC_ERR           ;UH OH, HIS INC WAS TOO LARGE. (Err $05 - "Illegal function call")
__RENUM_NXT_0:
  PUSH DE               ;SAVE CURRENT LINE ACCUM
  LD E,(HL)             ;GET LINK FIELD INTO [D,E]
  INC HL                ;GET LOW PART INTO K[A] FOR ZERO TEST
  LD D,(HL)             
  LD A,D                ;GET HIGH PART OF LINK
  OR E                  ;SET CC'S ON LINK FIELD
  EX DE,HL              ;SEE IF NEXT LINK ZERO
  POP DE                ;GET BACK ACCUM LINE #
  JR Z,__RENUM_FIN      ;ZERO, DONE
  LD A,(HL)             ;GET FIRST BYTE OF LINK
  INC HL                ;INC POINTER
  OR (HL)               ;SET CC'S
  DEC HL                ;MOVE POINTER BACK
  EX DE,HL              ;BACK IN [D,E]
  JR NZ,__RENUM_NXT     ;INC COUNT

__RENUM_FIN:
  PUSH BC               ;SAVE INC
  CALL SCCLIN           ;SCAN PROGRAM CONVERTING LINES TO PTRS.
  POP BC                ;GET BACK INC
  POP DE                ;GET NN
  POP HL                ;GET PTR TO FIRST LINE TO RESEQ
__RENUM_LP:
  PUSH DE               ;SAVE CURRENT LINE
  LD E,(HL)             ;GET LINK FIELD
  INC HL                ;PREPARE FOR ZERO LINK FIELD TEST
  LD D,(HL)
  LD A,D
  OR E
  JR Z,LINE2PTR         ;STOP RESEQING WHEN SEE END OF PGM
  EX DE,HL              ;FLIP LINE PTR, LINK FIELD
  EX (SP),HL            ;PUT LINK ON STACK, GET NEW LINE # OFF
  EX DE,HL              ;PUT NEW LINE # IN [D,E], THIS LINE PTR IN [H,L]
  INC HL                ;POINT TO LINE # FIELD.
  LD (HL),E             ;CHANGE TO NEW LINE #
  INC HL
  LD (HL),D
  EX DE,HL              ;GET THIS LINE # IN [H,L]
  ADD HL,BC             ;ADD INC
  EX DE,HL              ;GET NEW LINE # BACK IN [D,E]
  POP HL                ;GET PTR TO NEXT LINE
  JR __RENUM_LP         ;KEEP RESEQING
  
LINE2PTR:
  LD BC,RESTART         ;WHERE TO GO WHEN DONE
  PUSH BC               ;SAVE ON STACK

  DEFB $FE                ; 'CP $F6'  masking the next byte/instr.


; THE SUBROUTINES SCCLIN AND SCCPTR CONVERT ALL
; LINE #'S TO POINTERS AND VICE-VERSA.
; THE ONLY SPECIAL CASE IS "ON ERROR GOTO 0" WHERE THE "0"
; IS LEFT AS A LINE NUMBER TOKEN SO IT WONT BE CHANGED BY RESEQUENCE.

SCCLIN:
  DEFB $F6                ; 'OR $AF'  masking the next instruction

; Routine at 9129
;
; Used by the routines at SCNPT2, __MERGE and __GET.
SCCPTR:
  XOR A            ;SET A=0

  LD (PTRFLG),A    ;SET TO SAY WHETER LINES OR PTRS EXTANT
  LD HL,(TXTTAB)   ; Start of program text                     GET PTR TO START OF PGM
  DEC HL           ;                                           NOP NEXT INX.

SCNPLN:
  INC HL           ;                                           POINT TO BYTE AFTER ZERO AT END OF LINE
  LD A,(HL)        ; Get address of next line                  GET LINK FIELD INTO [D,E]
  INC HL           ;                                           BUMP PTR
  OR (HL)          ; End of program found?                     SET CC'S
  RET Z            ; Yes - Line not found                      RETURN IF ALL DONE.
  INC HL           ;                                           POINT PAST LINE #
  LD E,(HL)        ; Get LSB of line number                    GET LOW BYTE OF LINE #
  INC HL           
  LD D,(HL)        ; Get MSB of line number                    GET HIGH BYTE OF LINE #
; This entry point is used by the routine at _LINE2PTR.
SCNEXT:
  CALL CHRGTB      ;GET NEXT CHAR FROM LINE

; Line number to pointer
_LINE2PTR:
  OR A                  ;END OF LINE
  JR Z,SCNPLN           ;SCAN NEXT LINE
  LD C,A                ;SAVE [A]
  LD A,(PTRFLG)         ;CHANGE LINE TOKENS WHICH WAY?
  OR A                  ;SET CC'S
  LD A,C                ;GET BACK CURRENT CHAR
  JR Z,SCNPT2           ;CHANGING POINTERS TO #'S
  CP TK_ERROR           ;IS IT ERROR TOKEN?
  JR NZ,NTERRG          ;NO.
  CALL CHRGTB           ;SCAN NEXT CHAR
  CP TK_GOTO            ;ERROR GOTO?
  JR NZ,_LINE2PTR       ;GET NEXT ONE
  CALL CHRGTB           ;GET NEXT CHAR
  CP LINCON             ; Line number prefix:  LINE # CONSTANT?
  JR NZ,_LINE2PTR       ;NO, IGNORE.
  PUSH DE               ;SAVE [D,E]
  CALL LINGT3           ;GET IT
  LD A,D                ;IS IT LINE # ZERO?
  OR E                  ;SET CC'S
  JR NZ,CHGPTR          ;CHANGE IT TO A POINTER
  JR SCNEX3             ;YES, DONT CHANGE IT
  
NTERRG:
  CP LINCON             ; Line number prefix: LINE # CONSTANT?
  JR NZ,SCNEXT          ;NOT, KEEP SCANNING
  PUSH DE               ;SAVE CURRENT LINE # FOR POSSIBLE ERROR MSG
  CALL LINGT3           ;GET LINE # OF LINE CONSTANT INTO [D,E]
CHGPTR:                 
  PUSH HL               ;SAVE TEXT POINTER JUST AT END OF LINCON 3 BYTES
  CALL SRCHLN           ;TRY TO FIND LINE IN PGM.
  DEC BC                ;POINT TO ZERO AT END OF PREVIOUS LINE
  LD A,PTRCON           ;CHANGE LINE # TO PTR
  JR C,MAKPTR           ;IF LINE FOUND CHANE # TO PTR
  CALL CONSOLE_CRLF     ;PRINT CRLF IF REQUIRED
  LD HL,LINE_ERR_MSG    ;PRINT "Undefined line" MESSAGE
  PUSH DE               ;SAVE LINE #
  CALL PRS              ;PRINT IT
  POP HL                ;GET LINE # IN [H,L]
  CALL LINPRT           ;PRINT IT
  POP BC                ;GET TEXT PTR OFF STACK
  POP HL                ;GET CURRENT LINE #
  PUSH HL               ;SAVE BACK
  PUSH BC               ;SAVE BACK TEXT PTR
  CALL IN_PRT           ;PRINT IT
SCNPOP:
  POP HL                ;POP OFF CURRENT TEXT POINTER
SCNEX3:
  POP DE                ;GET BACK CURRENT LINE #
  DEC HL                ;BACKUP POINTER

_SCNEXT:
  JR SCNEXT             ;KEEP SCANNING

; Message at 9241
LINE_ERR_MSG:
  DEFM "Undefined line "
  DEFB $00

  
; Routine at 9257
;
; Used by the routine at _LINE2PTR.
SCNPT2:
  CP PTRCON            ;POINTER
  JR NZ,_SCNEXT        ;NO, KEEP SCANNING
  PUSH DE              ;SAVE CURRENT LINE #
  CALL LINGT3          ;GET #
  PUSH HL              ;SAVE TEXT POINTER
  EX DE,HL             ;FLIP CURRENT TEXT PTR & PTR
  INC HL               ;BUMP POINTER
  INC HL               ;POINT TO LINE # FIELD
  INC HL
  LD C,(HL)            ;PICK UP LINE #
  INC HL               ;POINT TO HIGH PART
  LD B,(HL)
  LD A,LINCON		; Line number prefix
; This entry point is used by the routine at _LINE2PTR.
MAKPTR:
  LD HL,SCNPOP         ;PLACE TO RETURN TO AFTER CHANGING CONSTANT
  PUSH HL              ;SAVE ON STACK
  LD HL,(CONTXT)       ;GET TXT PTR AFTER CONSTANT IN [H,L]

; This entry point is used by the routine at __GOTO.
CONCH2:
  PUSH HL              ;SAVE PTR TO END OF CONSTANT
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C            ;CHANGE TO VALUE IN [B,C]
  DEC HL               ;POINT TO CONSTANT TOKEN
  LD (HL),A            ;CHANGE TO VALUE IN [A]
  POP HL               ;RESTORE POINTER TO AFTER CONSTANT
  RET

; This entry point is used by the routines at PROMPT, __DELETE and __CHAIN.
DEPTR:
  LD A,(PTRFLG)        ;DO LINE POINTERS EXIST IN PGM?
  OR A                 ;SET CC'S
  RET Z                ;NO, JUST RETURN
  JP SCCPTR            ;CONVERT THEN TO LINE #'S

; 'OPTION' BASIC command
__OPTION:
  CALL SYNCHR
  DEFM "B"
  CALL SYNCHR
  DEFM "A"
  CALL SYNCHR
  DEFM "S"
  CALL SYNCHR
  DEFM "E"
  LD A,(OPTFLG)        ;GET THE BASE NUMBER
  OR A                 ;HAVE WE SEEN OPTION BASE BEFOR
  JP NZ,DD_ERR         ;IF SO "DOUBLE DIMENSION ERROR"
  PUSH HL              ;SAVE THE TEXT POINTER
  LD HL,(ARYTAB)       ;SEE IF WE HAVE ANY ARRAYS YET
  EX DE,HL
  LD HL,(STREND)
  CALL DCOMPR          ;IF THESE ARE EQUAL WE HAVE NOT
  JP NZ,DD_ERR
  POP HL
  LD A,(HL)
  SUB '0'              ; convert from ASCII
  JP C,SN_ERR
  CP $02
  JP NC,SN_ERR
  LD (OPTVAL),A
  INC A
  LD (OPTFLG),A
  CALL CHRGTB
  RET

; Print string using CALTTY
;
; Used by the routine at DDIV_SUB.
STRPRN:
  LD A,(HL)            ;GET BYTE FROM MESSAGE
  OR A                 ;END OF MESSAGE
  RET Z                ;YES, DONE
  CALL CALTTY          ;PRINT CHAR
  INC HL               ;INCREMENT POINTER
  JR STRPRN            ;PRINT NEXT CHAR

;
; CALTTY IS A SPECIAL ROUTINE TO OUTPUT ERROR MESSAGE TO TTY, REGARDLESS OF CURRENT FILE I/O.
;
; Entry - [A] = byte to be output
; Exit  - All registers preserved
;
; Used by the routines at STRPRN and DDIV_SUB.
CALTTY:
  PUSH AF
  JP CHPUT

; 'RANDOMIZE' BASIC command
__RANDOMIZE:
  JR Z,__RANDOMIZE_0
  CALL EVAL
  PUSH HL
  CALL __CINT
  JR __RANDOMIZE_2
__RANDOMIZE_0:
  PUSH HL
__RANDOMIZE_1:
  LD HL,RND_SEED_MSG
  CALL PRS
  CALL QINLIN
  POP DE
  JP C,INPBRK
  PUSH DE
  INC HL
  LD A,(HL)
  CALL FIN
  LD A,(HL)
  OR A
  JR NZ,__RANDOMIZE_1
  CALL __CINT
__RANDOMIZE_2:
  LD (RNDX+1),HL
  CALL RNDMN2
  POP HL
  RET

; Interactive message to initialize RND
RND_SEED_MSG:
  DEFM "Random number seed (-32768 to 32767)"
  DEFB $00

;
; THIS CODE SCANS AHEAD TO FIND THE "NEXT" THAT MATCHES A "FOR"
; IN ORDER TO 1) HANDLE EMPTY LOOPS AND 
;             2) MAKE SURE LOOPS MATCH UP PROPERLY.
;
; Used by the routine at __WHILE.
WNDSCN:
  LD C,$1D                ; Err $1D - "WHILE without WEND"  -  SCAN FOR MATCHING WEND THIS IS ERROR IF FAIL
  JR SCNCNT
; This entry point is used by the routine at SAVSTP.
NXTSCN:
  LD C,$1A                ; Err $1A - "FOR Without NEXT"

; Routine at 9467
;
; Used by the routine at WNDSCN.
SCNCNT:
  LD B,$00                ;SET UP THE COUNT OF "FOR"S SEEN
  EX DE,HL                ;INITIALIZE NXTLIN FOR NEXT ON SAME LINE
  LD HL,(CURLIN)
  LD (NXTLIN),HL
  EX DE,HL             ;RESTORE THE TEXT POINTER TO [H,L]
FORINC:
  INC B                ;INCREMENT THE COUNT WHENEVER "FOR" IS SEEN
FNLOP:
  DEC HL               ;** FIX HERE FOR 5.03 CAN'T CALL DATA
SCANWF:
  CALL CHRGTB          ;TO SKIP TO STATEMENT BECAUSE COULD
  JR Z,FORTRM          ;HAVE STATEMENT AFTER "THEN"
  CP TK_ELSE           ;ELSE STATMENT
  JR Z,FNNWST          ;THEN ALLOW NEXT OR WEND AFTER IT
  CP TK_THEN           ;SO SCAN USING CHRGET WAITING FOR END
  JR NZ,SCANWF         ;OF STATEMENT OR $THEN
FORTRM:
  OR A                 ;SEE HOW IT ENDED
  JR NZ,FNNWST         ;JUST NEW STATEMENT -- EXAMINE IT
                       ;OR COULD BE COLON IN STRING BUT NO HARM
                       ;IN NON KANABS (HGHBIT) VERSION SINCE NO RESERVED
                       ;WORDS WILL MATCH THE NEXT CHARACTER
  INC HL
  LD A,(HL)            ;SCAN THE LINK AT THE START OF THE NEXT LINE
  INC HL
  OR (HL)              ;TO SEE IF ITS ZERO (END OF PROGRAM)
  LD E,C               ;SET UP ERROR NUMBER
  JP Z,ERROR
  INC HL               ;PICK UP THE NEW LINE NUMBER
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD (NXTLIN),DE       ;SAVE AS "NEXT" LINE NUMBER
FNNWST:
  CALL CHRGTB          ;GET THE TYPE OF THE NEXT STATEMENT
  LD A,C               ;GET THE ERROR NUMBER TO SEE WHAT WE ARE
  CP $1A               ;SCANNING FOR
  LD A,(HL)            ;GET BACK THE CHARACTER
  JR Z,NXTLOK          ;FOR/NEXT SEARCHING
  CP TK_WHILE          ;ANOTHER WHILE/WEND NEST?
  JR Z,FORINC
  CP TK_WEND
  JR NZ,FNLOP
  ;DEC B
  DJNZ FNLOP
  RET

NXTLOK:
  CP TK_FOR            ;ANOTHER "FOR"?
  JR Z,FORINC          ;INCREMENT THE FOR COUNT
  CP TK_NEXT           ;END WITH NEXT?
  JR NZ,FNLOP          ;SKIP OVER THIS STATEMENT
DECNXT:
  DEC B                ;DECREMENT THE LOOP COUNT
  RET Z
;
; SCAN  THE VARIABLES LISTED IN A "NEXT" STATEMENT
;
  CALL CHRGTB          ;SEE IF THERE IS A NAME
  JR Z,FORTRM          ;ONLY ONE SO SCAN MORE STATEMENTS
  EX DE,HL             ;SAVE TEXT POINTER IN [D,E]
  LD HL,(CURLIN)       ;SAVE THE CURRENT LINE NUMBER
  PUSH HL
  LD HL,(NXTLIN)       ;MAKE ERROR COME FROM "NEXT"       ;GET THE LINE NUMBER OF NEXT
  LD (CURLIN),HL                                          ;MAKE IT THE CURRENT LINE
  EX DE,HL             ;[H,L]= TEXT POINTER
  PUSH BC              ;SAVE THE "FOR" COUNT
  CALL GETVAR          ;SKIP OVER THE VARIABLE NAME
  POP BC               ;GET BACK THE "FOR" COUNT
  DEC HL               ;CHECK TERMINATOR
  CALL CHRGTB
  LD DE,FORTRM
  JR Z,TRMNXT
  CALL SYNCHR
  DEFM ","             ;SHOULD HAVE COMMAS IN BETWEEN
  DEC HL               ;RESCAN FIRST CHARACTER
  LD DE,DECNXT         ;PLACE TO GO BACK TO
TRMNXT:
  EX (SP),HL           ;SAVE THE TEXT POINTER ON THE STACK
  LD (CURLIN),HL
  POP HL
  PUSH DE              ;GO OFF TO ADDRESS IN [B,C]
  RET

;
; THIS ROUTINE CLEARS FLGOVC TO RESET TO NORMAL OVERFLOW MODE.
; IN NORMAL MODE, OVERR ALWAYS PRINTS OVERFLOW BECAUSE FLGOVC=0
; FUNCTION DISPATCH, FIN (&FINDBL), AND EXPONENTIATION SET UP AN OVERFLOW
; MODE WHERE FLGOVC=1 AND AFTER ONE OVERFLOW FLGOVC=2 AND NO MORE
; OVERFLOW MESSAGES ARE PRINTED. FIN (&FINDBL) ALSO STORE FLGOVC IN OVCSTR
; BEFORE RESETTING FLGOVC SO A CALLER CAN DETECT OVERFLOW OCCURANCE.
;
FINOVC:
  PUSH AF
  LD A,(FLGOVC)        ;STORE OVERFLOW FLAG TO INDICATE
  LD (OVCSTR),A        ;WHETHER AN OVERFLOW OCCURED
  POP AF

; This entry point is used by the routine at STKERR.
;BACK TO NORMAL OVERFLOW PRINT MODE
CLROVC:
  PUSH AF              ;SAVE EVERYTHING
  XOR A                ;NORMAL OVERFLOW MODE
  LD (FLGOVC),A
  POP AF
  RET




;
;	EXTERNAL LOCATIONS USED BY THE MATH-PACKAGE
;	;THE FLOATING ACCUMULATOR

;IFN	LENGTH&2,<
;         BLOCK	1		;[TEMPORARY LEAST SIGNIFICANT BYTE]
;DFACLO:  BLOCK	4>		;[FOUR LOWEST ORDERS FOR DOUBLE PRECISION]
;FACLO:   BLOCK	3		;[LOW ORDER OF MANTISSA (LO)]
;				;[MIDDLE ORDER OF MANTISSA (MO)]
;				;[HIGH ORDER OF MANTISSA (HO)]
;FAC:	  BLOCK	2		;[EXPONENT]
;				;[TEMPORARY COMPLEMENT OF SIGN IN MSB]

;IFN	LENGTH&2,<
;	     BLOCK	1		;[TEMPORARY LEAST SIGNIFICANT BYTE]
;ARGLO:	 BLOCK	7		;[LOCATION OF SECOND ARGUMENT FOR DOUBLE
;ARG:	 BLOCK	1>		; PRECISION]
;FBUFFR:	BLOCK	^D13		;BUFFER FOR FOUT

;IFN	LENGTH&2,<BLOCK	^D<35-13>>
;

;
;THE FLOATING POINT FORMAT IS AS FOLLOWS:
;
;THE SIGN IS THE FIRST BIT OF THE MANTISSA
;THE MANTISSA IS 24 BITS LONG
;THE BINARY POINT IS TO THE LEFT OF THE MSB
;NUMBER = MANTISSA * 2 ^ EXPONENT
;THE MANTISSA IS POSITIVE, WITH A ONE ASSUMED TO BE WHERE THE SIGN BIT IS
;THE SIGN OF THE EXPONENT IS THE FIRST BIT OF THE EXPONENT
;THE EXPONENT IS STORED IN EXCESS 200 I.E. WITH A BIAS OF 200
;SO, THE EXPONENT IS A SIGNED 8-BIT NUMBER WITH 200 ADDED TO IT
;AN EXPONENT OF ZERO MEANS THE NUMBER IS ZERO, THE OTHER BYTES ARE IGNORED
;TO KEEP THE SAME NUMBER IN THE FAC WHILE SHIFTING:
;	TO SHIFT RIGHT,	EXP:=EXP+1
;	TO SHIFT LEFT,	EXP:=EXP-1
;
;SO, IN MEMORY THE NUMBER LOOKS LIKE THIS:
;	[BITS 17-24 OF THE MANTISSA]
;	[BITS 9-16 OF THE MANTISSA]
;	[THE SIGN IN BIT 7, BITS 2-8 OF THE MANTISSA ARE IN BITS 6-0]
;	[THE EXPONENT AS A SIGNED NUMBER + 200]
;(REMEMBER THAT BIT 1 OF THE MANTISSA IS ALWAYS A ONE)
;
;ARITHMETIC ROUTINE CALLING CONVENTIONS:
;
;FOR ONE ARGUMENT FUNCTIONS:
;	THE ARGUMENT IS IN THE FAC, THE RESULT IS LEFT IN THE FAC
;FOR TWO ARGUMENT OPERATIONS:
;	THE FIRST ARGUMENT IS IN B,C,D,E I.E. THE "REGISTERS"
;	THE SECOND ARGUMENT IS IN THE FAC
;	THE RESULT IS LEFT IN THE FAC
;
;THE "S" ENTRY POINTS TO THE TWO ARGUMENT OPERATIONS HAVE (HL) POINTING TO
;THE FIRST ARGUMENT INSTEAD OF THE FIRST ARGUMENT BEING IN THE REGISTERS.
;MOVRM IS CALLED TO GET THE ARGUMENT IN THE REGISTERS.
;THE "T" ENTRY POINTS ASSUME THE FIRST ARGUMENT IS ON THE STACK.
;POPR IS USED TO GET THE ARGUMENT IN THE REGISTERS.
;NOTE: THE "T" ENTRY POINTS SHOULD ALWAYS BE JUMPED TO AND NEVER CALLED
;BECAUSE THE RETURN ADDRESS ON THE STACK WILL BE CONFUSED WITH THE NUMBER.
;
;ON THE STACK, THE TWO LO'S ARE PUSHED ON FIRST AND THEN THE HO AND SIGN.
;THIS IS DONE SO IF A NUMBER IS STORED IN MEMORY, IT CAN BE PUSHED ON THE
;STACK WITH TWO PUSHM'S.  THE LOWER BYTE OF EACH PART IS IN THE LOWER
;MEMORY ADDRESS SO WHEN THE NUMBER IS POPPED INTO THE REGISTERS, THE HIGHER
;ORDER BYTE WILL BE IN THE HIGHER ORDER REGISTER OF THE REGISTER PAIR, I.E.
;THE HIGHER ORDER BYTE WILL BE POPPED INTO B, D OR H.
;

;*****************************************************************
;IF INTFSW=1 THE FORMAT OF FLOATING POINT NUMBERS WILL BE:
;REG B:SIGN AND BITS 1-7 OF EXPONENT,REG C:BIT 8 OF EXPONENT
;AND BITS 2-8 OF MANTISSA,REG D:BITS 9-16 OF MANTISSA,
;REG E:BITS 17-24 OF MANTISSA, AND LIKEWISE FOR THE FAC FORMAT
;FURTHERMORE, THE EXPONENT FOR INTEL WILL BE BIAS 177 OCTAL
;******************************************************************


; FLOATING POINT ADDITION AND SUBTRACTION
; ENTRY TO FADD WITH POINTER TO ARG IN (HL)

; a.k.a. ROUND
; Used by the routines at __CINT and RNGTST.
FADDH:
  LD HL,FP_HALF           ;ENTRY TO ADD 1/2

; LOADFP/FADD
; Load FP at (HL) to BCDE
;
; Used by the routines at __RND, __COS and __NEXT.
FADDS:
  CALL LOADFP             ;GET ARGUMENT INTO THE REGISTERS
  JR FADD                 ;DO THE ADDITION


;SUBTRACTION	FAC:=ARG-FAC
;ENTRY IF POINTER TO ARG IS IN (HL)

; LOADFP/FSUB
FSUBS:                    ;ENTRY IF POINTER TO ARG IS IN (HL)
  CALL LOADFP             ; FPREG = -FPREG + number at HL


; Subtract the single precision numbers in FAC1 and BCDE
; aka, SUBCDE Subtract BCDE from FP reg
;
; Used by the routines at __EXP and __SIN.
FSUB:
  CALL NEG                ;NEGATE SECOND ARGUMENT
                          ;FALL INTO FADD

; ADDITION	FAC:=ARG+FAC
; aka FPADD, Add BCDE to FP reg
; ALTERS A,B,C,D,E,H,L
;
; Used by the routines at __POKE, FADDS, __LOG, MLSP10, MULTEN, POLY and
; __SIN.
FADD:
  LD A,B                  ; Get FP exponent                 ;CHECK IF FIRST ARGUMENT IS ZERO
  OR A                    ; Is number zero?                 ;GET EXPONENT
  RET Z                   ; Yes - Nothing to add            ;IT IS, RESULT IS NUMBER IN FAC
  LD A,(FPEXP)            ; Get FPREG exponent              ;GET EXPONENT
  OR A                    ; Is this number zero?            ;SEE IF THE NUMBER IS ZERO
  JP Z,FPBCDE             ; Yes - Move BCDE to FPREG        ;IT IS, ANSWER IS IN REGISTERS

;WE WANT TO GET THE SMALLER NUMBER IN THE REGISTERS SO WE CAN SHIFT IT RIGHT
;AND ALIGN THE BINARY POINTS OF THE TWO NUMBERS.  THEN WE CAN JUST ADD OR
;SUBTRACT THEM (DEPENDING ON THEIR SIGNS) BYTEWISE.
  SUB B                   ; BCDE number larger?             ;CHECK RELATIVE SIZES
  JR NC,NOSWAP            ; No - Don't swap them            ;IS FAC SMALLER?
  CPL                     ; Two's complement                ;YES, NEGATE SHIFT COUNT
  INC A                   ; FP exponent
  EX DE,HL                                                  ;SWITCH FAC AND REGISTERS, SAVE (DE)
  CALL PUSHF              ; Put FPREG on stack              ;PUT FAC ON STACK
  EX DE,HL                                                  ;GET (DE) BACK WHERE IT BELONGS
  CALL FPBCDE             ; Move BCDE to FPREG              ;PUT REGISTERS IN THE FAC
  POP BC                  ; Restore number from stack
  POP DE
                                                            ;GET THE OLD FAC IN THE REGISTERS
NOSWAP:
  CP 24+1                 ; Second number insignificant?    ;ARE WE WITHIN 24 BITS?
  RET NC                  ; Yes - First number is result
  PUSH AF                 ; Save number of bits to scale    ;SAVE SHIFT COUNT
  CALL UNPACK             ; Set MSBs & sign of result       ;UNPACK THE NUMBERS
  LD H,A                  ; Save sign of result             ;SAVE SUBTRACTION FLAG
  POP AF                  ; Restore scaling factor          ;GET SHIFT COUNT BACK
  CALL SCALE              ; Scale BCDE to same exponent     ;SHIFT REGISTERS RIGHT THE RIGHT AMOUNT

;IF THE NUMBERS HAVE THE SAME SIGN, THEN WE ADD THEM.  IF THE SIGNS ARE
;DIFFERENT, THEN WE HAVE TO SUBTRACT THEM.  WE HAVE TO DO THIS BECAUSE THE
;MANTISSAS ARE POSITIVE.  JUDGING BY THE EXPONENTS, THE LARGER NUMBER IS IN
;THE FAC, SO IF WE SUBTRACT, THE SIGN OF THE RESULT SHOULD BE THE SIGN OF THE
;FAC; HOWEVER, IF THE EXPONENTS ARE THE SAME, THE NUMBER IN THE REGISTERS
;COULD BE BIGGER, SO AFTER WE SUBTRACT THEM, WE HAVE TO CHECK IF THE RESULT
;WAS NEGATIVE.  IF IT WAS, WE NEGATE THE NUMBER IN THE REGISTERS AND
;COMPLEMENT THE SIGN OF THE FAC.  (HERE THE FAC IS UNPACKED)
;IF WE HAVE TO ADD THE NUMBERS, THE SIGN OF THE RESULT IS THE SIGN OF THE
;FAC.  SO, IN EITHER CASE, WHEN WE ARE ALL DONE, THE SIGN OF THE RESULT
;WILL BE THE SIGN OF THE FAC.

  LD A,H                                                    ;GET SUBTRACTION FLAG
  OR A                    ; Result to be positive?
  LD HL,FACCU             ; Point to FPREG                  ;SET POINTER TO LO'S
  JP P,MINCDE             ; No - Subtract FPREG from CDE    ;SUBTRACT IF THE SIGNS WERE DIFFERENT
  CALL PLUCDE             ; Add FPREG to CDE                ;ADD THE NUMBERS
  JR NC,RONDUP            ; No overflow - Round it up       ;ROUND RESULT IF THERE WAS NO OVERFLOW
                                                            ;THE MOST IT CAN OVERFLOW IS ONE BIT
  INC HL                  ; Point to exponent               ;THERE WAS OVERFLOW
  INC (HL)                ; Increment it                    ;INCREMENT EXPONENT
  JP Z,OVERR_1            ; Number overflowed - Error
  LD L,$01                ; 1 bit to shift right            ;SHIFT RESULT RIGHT ONE, SHIFT CARRY IN
  CALL SHRITE_1           ; Shift result right
  JR RONDUP               ; Round it up                     ;ROUND RESULT AND WE ARE DONE

MINCDE:                                                     ;HERE TO SUBTRACT C,D,E,B FROM ((HL)+0,1,2),0
  XOR A                   ; Clear A and carry               ;SUBTRACT NUMBERS, NEGATE UNDERFLOW BYTE
  SUB B                   ; Negate exponent
  LD B,A                  ; Re-save exponent                ;SAVE IT
  LD A,(HL)               ; Get LSB of FPREG                ;SUBTRACT LOW ORDERS
  SBC A,E                 ; Subtract LSB of BCDE
  LD E,A                  ; Save LSB of BCDE
  INC HL                                                    ;UPDATE POINTER TO NEXT BYTE
  LD A,(HL)               ; Get NMSB of FPREG               ;SUBTRACT MIDDLE ORDERS
  SBC A,D                 ; Subtract NMSB of BCDE
  LD D,A                  ; Save NMSB of BCDE
  INC HL                                                    ;UPDATE POINTER TO HIGH ORDERS
  LD A,(HL)               ; Get MSB of FPREG                ;SUBTRACT HIGH ORDERS
  SBC A,C                 ; Subtract MSB of BCDE
  LD C,A                  ; Save MSB of BCDE

;BECAUSE WE WANT A POSITIVE MANTISSA, CHECK IF WE HAVE TO NEGATE THE NUMBER
; a.k.a. FADFLT
; This entry point is used by the routines at FLOAT and INT.
CONPOS:
  CALL C,COMPL            ; Overflow - Make it positive     ;ENTRY FROM FLOATR, INT: NEGATE NUMBER IF IT
                                                            ; WAS NEGATIVE, FALL INTO NORMALIZE


;NORMALIZE C,D,E,B
;ALTERS A,B,C,D,E,H,L
;HERE WE SHIFT THE MANTISSA LEFT UNTIL THE MSB IS A ONE.
;EXCEPT IN 4K, THE IDEA IS TO SHIFT LEFT BY 8 AS MANY TIMES AS POSSIBLE.

; Normalise number, a.k.a. NORMAL
;
; Used by the routine at __RND.
BNORM:
  LD L,B                  ; L = Exponent                    ;PUT LOWEST 2 BYTES IN (HL)
  LD H,E                  ; H = LSB
  XOR A                                                     ;ZERO SHIFT COUNT
BNRMLP:
  LD B,A                  ; Save bit count                  ;SAVE SHIFT COUNT
  LD A,C                  ; Get MSB                         ;DO WE HAVE 1 BYTE OF ZEROS
  OR A                    ; Is it zero?
  JR NZ,PNORM             ; No - Do it bit at a time        ;NO, SHIFT ONE PLACE AT A TIME
  
  ;THIS LOOP SPEEDS THINGS UP BY SHIFTING 8 PLACES AT ONE TIME
  LD C,D                  ; MSB = NMSB                      ;YES, SHIFT OVER 1 BYTE
  LD D,H                  ; NMSB= LSB
  LD H,L                  ; LSB = VLSB
  LD L,A                  ; VLSB= 0                         ;SHIFT IN 8 ZEROS FOR THE LOW ORDER
  LD A,B                  ; Get exponent                    ;UPDATE SHIFT COUNT
  SUB 8                   ; Count 8 bits
  CP -24-8                ; Was number zero?                ;DID WE SHIFT IN 4 BYTES OF ZEROS?
  JR NZ,BNRMLP            ; No - Keep normalising           ;NO, TRY TO SHIFT OVER 8 MORE
                                                            ;YES, NUMBER WAS ZERO.  FALL INTO ZERO


;ZERO FAC
;ALTERS A ONLY
;EXITS WITH A=0
;BY OUR FLOATING POINT FORMAT, THE NUMBER IS ZERO IF THE EXPONENT IS ZERO

; This entry point is used by the routines at RESDIV, MLDVEX, DADD,
; DMUL, DDIV10, DDIV, FIN_DBL and __EXP.
ZERO:
  XOR A                   ; Result is zero           ;ZERO A
; This entry point is used by the routine at __SQR.
ZERO0:
  LD (FPEXP),A            ; Save result as zero      ;ZERO THE FAC'S EXPONENT, ENTRY IF A=0
  RET                                                ;ALL DONE


; a.k.a. NORM2
NORMAL:
  LD A,H                  ;CHECK FOR CASE OF NORMALIZING A SMALL INT
  OR L
  OR D
  JR NZ,BNORM_1           ;DO USUAL THING
  LD A,C                  ;GET BYTE TO SHIFT

BNORM_0:
  DEC B                   ;DECRMENT SHIFT COUNT        ; Count bits
  RLA                     ;SHIFT LEFT                  ; Shift left
  JR NC,BNORM_0           ;NORMALIZE LIKE SOB
  INC B                   ;CORRECT SHIFT COUNT
  RRA                     ;WE DID IT ONE TOO MANY TIMES
  LD C,A                  ;RESULT TO [C]
  JR BNORM_2              ;ALL DONE

BNORM_1:
  DEC B                   ;DECREMENT SHIFT COUNT                        ; Count bits
  ADD HL,HL               ;ROTATE (HL) LEFT ONE, SHIFT IN A ZERO        ; Shift HL left
  LD A,D                  ;ROTATE NEXT HIGHER ORDER LEFT ONE            ; Get NMSB
  RLA                                                                   ; Shift left with last bit
  LD D,A                                                                ; Save NMSB
  LD A,C                  ;ROTATE HIGH ORDER LEFT ONE                   ; Get MSB
  ADC A,A                 ;SET CONDITION CODES                          ; Shift left with last bit
  LD C,A                                                                ; Save MSB
PNORM:
  JP P,NORMAL             ; Not done - Keep going

BNORM_2:
  LD A,B                  ; Number of bits shifted         ;ALL NORMALIZED, GET SHIFT COUNT
  LD E,H                  ; Save HL in EB                  ;PUT LO'S BACK IN E,B
  LD B,L
  OR A                    ; Any shifting done?             ;CHECK IF WE DID NO SHIFTING
  JR Z,RONDUP             ; No - Round it up
  LD HL,FPEXP             ; Point to exponent              ;LOOK AT FAC'S EXPONENT
  ADD A,(HL)              ; Add shifted bits               ;UPDATE EXPONENT
  LD (HL),A               ; Re-save exponent
  JR NC,ZERO              ; Underflow - Result is zero     ;CHECK FOR UNDERFLOW
  JR Z,ZERO               ; Result is zero                 ;NUMBER IS ZERO, ALL DONE
                                                           ;FALL INTO ROUND AND WE ARE DONE


;ROUND RESULT IN C,D,E,B AND PUT NUMBER IN THE FAC
;ALTERS A,B,C,D,E,H,L
;WE ROUND C,D,E UP OR DOWN DEPENDING UPON THE MSB OF B

; This entry point is used by the routines at FADD and __CSNG.
RONDUP:
  LD A,B                  ; Get VLSB of number             ;SEE IF WE SHOULD ROUND UP
; This entry point is used by the routine at RESDIV.
RONDUP_0:
  LD HL,FPEXP             ; Point to exponent              ;ENTRY FROM FDIV, GET POINTER TO EXPONENT
  OR A                    ; Any rounding?                  ;(  ?? INTEL FLOATING SOFTWARE FLAG ?? )
  CALL M,FPROND           ; Yes - Round number up          ;DO IT IF NECESSARY
  LD B,(HL)               ; B = Exponent                   ;PUT EXPONENT IN B
                                ; HERE WE PACK THE HO AND SIGN
  INC HL                                                   ;POINT TO SIGN
  LD A,(HL)               ; Get sign of result             ;GET SIGN
  AND $80                 ; Only bit 7 needed              ;GET RID OF UNWANTED BITS
  XOR C                   ; Set correct sign               ;PACK SIGN AND HO
  LD C,A                  ; Save correct sign in number    ;SAVE IT IN C
  JP FPBCDE               ; Move BCDE to FP accumulator    ;SAVE NUMBER IN FAC

;SUBROUTNE FOR ROUND:  ADD ONE TO C,D,E
; a.k.a. ROUNDA
; This entry point is used by the routine at QINT.
FPROND:
  INC E                   ; Round LSB                      ;ADD ONE TO THE LOW ORDER, ENTRY FROM QINT
  RET NZ                  ; Return if ok                   ;ALL DONE IF IT IS NOT ZERO
  INC D                   ; Round NMSB                     ;ADD ONE TO NEXT HIGHER ORDER
  RET NZ                  ; Return if ok                   ;ALL DONE IF NO OVERFLOW
  INC C                   ; Round MSB                      ;ADD ONE TO THE HIGHEST ORDER
  RET NZ                  ; Return if ok                   ;RETURN IF NO OVEFLOW
  LD C,$80                ; Set normal value               ;THE NUMBER OVERFLOWED, SET NEW HIGH ORDER
  INC (HL)                ; Increment exponent             ;UPDATE EXPONENT
  RET NZ                  ; Return if ok                   ;RETURN IF IT DID NOT OVERFLOW
  JP OVERR_0              ; Overflow error                 ;OVERFLOW AND CONTINUE


; a.k.a. FADDA
;ADD (HL)+2,1,0 TO C,D,E
;THIS CODE IS USED BY FADD, FOUT
;
; Add number pointed by HL to CDE
;
; Used by the routines at FADD and RNGTST.
PLUCDE:
  LD A,(HL)               ; Get LSB of FPREG               ;GET LOWEST ORDER
  ADD A,E                 ; Add LSB of BCDE                ;ADD IN OTHER LOWEST ORDER
  LD E,A                  ; Save LSB of BCDE               ;SAVE IT
  INC HL                                                   ;UPDATE POINTER TO NEXT BYTE
  LD A,(HL)               ; Get NMSB of FPREG              ;ADD MIDDLE ORDERS
  ADC A,D                 ; Add NMSB of BCDE
  LD D,A                  ; Save NMSB of BCDE
  INC HL                                                   ;UPDATE POINTER TO HIGH ORDER
  LD A,(HL)               ; Get MSB of FPREG               ;ADD HIGH ORDERS
  ADC A,C                 ; Add MSB of BCDE
  LD C,A                  ; Save MSB of BCDE
  RET                                                      ;ALL DONE


;NEGATE NUMBER IN C,D,E,B
;THIS CODE IS USED BY FADD, QINT
;ALTERS A,B,C,D,E,L
;
;a.k.a. NEGR
;
; Used by the routines at FADD and QINT.
COMPL:
  LD HL,SGNRES            ; Sign of result                 ;NEGATE FAC
  LD A,(HL)               ; Get sign of result             ;GET SIGN
  CPL                     ; Negate it                      ;COMPLEMENT IT
  LD (HL),A               ; Put it back                    ;SAVE IT AGAIN
  XOR A                                                    ;ZERO A
  LD L,A                  ; Set L to zero                  ;SAVE ZERO IN L
  SUB B                   ; Negate exponent,set carry      ;NEGATE LOWEST ORDER
  LD B,A                  ; Re-save exponent               ;SAVE IT
  LD A,L                  ; Load zero                      ;GET A ZERO
  SBC A,E                 ; Negate LSB                     ;NEGATE NEXT HIGHEST ORDER
  LD E,A                  ; Re-save LSB                    ;SAVE IT
  LD A,L                  ; Load zero                      ;GET A ZERO
  SBC A,D                 ; Negate NMSB                    ;NEGATE NEXT HIGHEST ORDER
  LD D,A                  ; Re-save NMSB                   ;SAVE IT
  LD A,L                  ; Load zero                      ;GET ZERO BACK
  SBC A,C                 ; Negate MSB                     ;NEGATE HIGHEST ORDER
  LD C,A                  ; Re-save MSB                    ;SAVE IT
  RET                                                      ;ALL DONE


;SHIFT C,D,E RIGHT
;A = SHIFT COUNT
;ALTERS A,B,C,D,E,L
;THE IDEA (EXCEPT IN 4K) IS TO SHIFT RIGHT 8 PLACES AS MANY TIMES AS POSSIBLE
;
;a.k.a. SHIFTR
;
; This entry point is used by the routines at FADD and QINT.
SCALE:
  LD B,$00                ; Clear underflow                ;ZERO OVERFLOW BYTE
SCALLP:
  SUB $08                 ; 8 bits (a whole byte)?         ;CAN WE SHIFT IT 8 RIGHT?
  JR C,SHRITE             ; No - Shift right A bits        ;NO, SHIFT IT ONE PLACE AT A TIME
                                                           ;THIS LOOP SPEEDS THINGS UP BY SHIFTING 8 PLACES AT ONE TIME
  LD B,E                  ; <- Shift                       ;SHIFT NUMBER 1 BYTE RIGHT
  LD E,D                  ; <- right
  LD D,C                  ; <- eight
  LD C,$00                ; <- bits                        ;PUT 0 IN HO
  JR SCALLP               ; More bits to shift             ;TRY TO SHIFT 8 RIGHT AGAIN

; Shift right number in BCDE
;
; Used by the routine at COMPL.
SHRITE:
  ADD A,8+1               ; Adjust count                   ;CORRECT SHIFT COUNT
  LD L,A                  ; Save bits to shift             ;SAVE SHIFT COUNT

;TEST FOR CASE (VERY COMMON) WHERE SHIFTING SMALL INTEGER RIGHT.
;THIS HAPPENS IN FOR LOOPS, ETC.
  LD A,D                  ;SEE IF THREE LOWS ARE ZERO.
  OR E                    
  OR B                    
  JR NZ,SHRLP             ;IF SO, DO USUAL.
  LD A,C                  ;GET HIGH BYTE TO SHIFT          ; Get MSB
SHRITE_0:
  DEC L                   ;DONE SHIFTING?
  RET Z                   ;YES, DONE
  RRA                     ;ROTATE ONE RIGHT                ; Shift it right
  LD C,A                  ;SAVE RESULT                     ; Re-save
  JR NC,SHRITE_0          ;ZAP BACK AND DO NEXT ONE IF NONE
  JR SHRITE_2             ;CONTINUE SHIFTING

SHRLP:
  XOR A                   ; Flag for all done              ;CLEAR CARRY
  DEC L                   ; All shifting done?             ;ARE WE DONE SHIFTING?
  RET Z                   ; Yes - Return                   ;RETURN IF WE ARE
  LD A,C                  ; Get MSB                        ;GET HO
; This entry point is used by the routine at FADD.
SHRITE_1:
  RRA                     ; Shift it right                 ;ENTRY FROM FADD, SHIFT IT RIGHT
  LD C,A                  ; Re-save                        ;SAVE IT

SHRITE_2:
  LD A,D                  ; Get NMSB                       ;SHIFT NEXT BYTE RIGHT
  RRA                     ; Shift right with last bit
  LD D,A                  ; Re-save it
  LD A,E                  ; Get LSB                        ;SHIFT LOW ORDER RIGHT
  RRA                     ; Shift right with last bit
  LD E,A                  ; Re-save it
  LD A,B                  ; Get underflow                  ;SHIFT OVERFLOW BYTE RIGHT
  RRA                     ; Shift right with last bit
  LD B,A                  ; Re-save underflow
  JR SHRLP                ; More bits to do                ;SEE IF WE ARE DONE



; NATURAL LOG FUNCTION

;CALCULATION IS BY:
; LN(F*2^N)=(N+LOG2(F))*LN(2)
;AN APPROXIMATION POLYNOMIAL IS USED TO CALCULATE LOG2(F)



;CONSTANTS USED BY LOG

FP_UNITY:
  DEFB $00,$00,$00,$81       ; 1

FP_LOGTAB_P:
  DEFB $04                   ;HART 2524 COEFFICIENTS
  DEFB $9A,$F7,$19,$83       ;4.8114746
  DEFB $24,$63,$43,$83       ;6.105852
  DEFB $75,$CD,$8D,$84       ;-8.86266
  DEFB $A9,$7F,$83,$82       ;-2.054667

FP_LOGTAB_Q:
  DEFB $04
  DEFB $00,$00,$00,$81       ;1.0
  DEFB $E2,$B0,$4D,$83       ;6.427842
  DEFB $0A,$72,$11,$83       ;4.545171
  DEFB $F4,$04,$35,$7F       ;.3535534


; 'LOG' BASIC function
;
; Used by the routine at __SQR.
__LOG:
  CALL SIGN               ;CHECK FOR A NEGATIVE OR ZERO ARGUMENT      ; Test sign of value
  OR A                    ;SET CC'S PROPERLY
  JP PE,FC_ERR            ;FAC .LE. 0, BLOW HIM OUT OF THE WATER      ; ?FC Error if <= zero
                          ;FSIGN ONLY RETURNS 0,1 OR 377 IN A
                          ;THE PARITY WILL BE EVEN IF A HAS 0 OR 377

  CALL __LOG_0
  LD BC,$8031             ; BCDE = Ln(2)
  LD DE,$7218
  JR FMULT                ;COMPLETE LOG CALCULATION

;USE HART 2524 CALCULATION
__LOG_0:
  CALL BCDEFP             ;MOVE FAC TO REGISTERS TOO
  LD A,$80                ;
  LD (FPEXP),A            ;ZERO THE EXPONENT
  XOR B                   ;REMOVE 200 EXCESS FROM X
  PUSH AF                 ;SAVE EXPONENT
  CALL PUSHF              ;SAVE THE FAC (X)
  LD HL,FP_LOGTAB_P       ;POINT TO P CONSTANTS
  CALL POLY               ;CALCULATE P(X)
  POP BC                  ;FETCH X
  POP HL                  ;PUSHF WOULD ALTER DE
  CALL PUSHF              ;PUSH P(X) ON THE STACK
  EX DE,HL                ;GET LOW BYTES OF X TO (DE)
  CALL FPBCDE             ;AND MOVE TO FAC
  LD HL,FP_LOGTAB_Q       ;POINT TO Q COEFFICIENTS
  CALL POLY               ;COMPUTE Q(X)
  POP BC                  ;FETCH P(X) TO REGISTERS
  POP DE
  CALL FDIV               ;CALCULATE P(X)/Q(X)
  POP AF                  ;RE-FETCH EXPONENT
  CALL PUSHF              ;SAVE EVALUATION
  CALL FLOAT              ;FLOAT THE EXPONENT
  POP BC
  POP DE
  JP FADD                 ;GET EVAL. BACK



;	FLOATING MULTIPLICATION AND DIVISION

;MULTIPLICATION		FAC:=ARG*FAC
;ALTERS A,B,C,D,E,H,L

; aka FPMULT, Multiply BCDE to FP reg
;
; Used by the routines at __LOG, IMULT5, EXP, __EXP, SUMSER, POLY, __RND and
; __SIN.
FMULT:
  CALL SIGN               ; Test sign of FPREG               ;CHECK IF FAC IS ZERO
  RET Z                   ; Return zero if zero              ;IF IT IS, RESULT IS ZERO
  LD L,$00                ; Flag add exponents               ;ADD THE TWO EXPONENTS, L IS A FLAG
  CALL ADDEXP             ; Add exponents                    ;FIX UP THE EXPONENTS
                ;SAVE THE NUMBER IN THE REGISTERS SO WE CAN ADD IT FAST
  LD A,C                  ; Get MSB of multiplier            ;GET HO
  LD (MULVAL),A           ; Save MSB of multiplier           ;STORE HO OF REGISTERS
  EX DE,HL                                                   ;STORE THE TWO LO'S OF THE REGISTERS
  LD (MULVAL2),HL         ; Save rest of multiplier
  LD BC,$0000             ; Partial product (BCDE) = zero    ;ZERO THE PRODUCT REGISTERS
  LD D,B
  LD E,B
  LD HL,BNORM             ; Address of normalise
  PUSH HL                 ; Save for return                  ; ON THE STACK
  LD HL,MULT8             ; Address of 8 bit multiply        ;PUT FMULT2 ON THE STACK TWICE, SO AFTER
  PUSH HL                 ; Save for NMSB,MSB                ; WE MULTIPLY BY THE LO BYTE, WE WILL
  PUSH HL                                                    ; MULTIPLY BY THE MO AND HO
  LD HL,FACCU             ; Point to number                  ;GET ADDRESS OF LO OF FAC

; 8 bit multiply
MULT8:
  LD A,(HL)               ; Get LSB of number                ;GET BYTE TO MULTIPLY BY
  INC HL                  ; Point to NMSB                    ;MOVE POINTER TO NEXT BYTE
  OR A                    ; Test LSB
  JR Z,BYTSFT             ; Zero - shift to next byte        ;ARE WE MULTIPLYING BY ZERO?
  PUSH HL                 ; Save address of number           ;SAVE POINTER
  EX DE,HL                                                   ;GET LO'S IN (HL)
  LD E,$08                ; 8 bits to multiply by            ;SET UP A COUNT


;THE PRODUCT WILL BE FORMED IN C,D,E,B. THIS WILL BE IN C,H,L,B PART OF THE
;TIME IN ORDER TO USE THE "DAD" INSTRUCTION.  AT FMULT2, WE GET THE NEXT
;BYTE OF THE MANTISSA IN THE FAC TO MULTIPLY BY.  ((HL) POINTS TO IT)
;(THE FMULT2 SUBROUTINE PRESERVES (HL))  IN 8K, IF THE BYTE IS ZERO, WE JUST
;SHIFT THE PRODUCT 8 RIGHT.  THIS BYTE IS THEN SHIFTED RIGHT AND SAVED IN D
;(H IN 4K).  THE CARRY DETERMINES IF WE SHOULD ADD IN THE SECOND FACTOR
;IF WE DO, WE ADD IT TO C,H,L.  B IS ONLY USED TO DETERMINE WHICH WAY WE
;ROUND.  WE THEN SHIFT C,H,L,B (C,D,E,B) IN 4K RIGHT ONE TO GET READY FOR THE
;NEXT TIME THROUGH THE LOOP.  NOTE THAT THE CARRY IS SHIFTED INTO THE MSB OF
;C.  E HAS A COUNT (L IN 4K) TO DETERMINE WHEN WE HAVE LOOKED AT ALL THE BITS
;OF D (H IN 4K).

; This entry point is used by the routine at NOMADD.
MUL8LP:
  RRA                     ; Shift LSB right                ;ROTATE BYTE RIGHT
  LD D,A                  ; Save LSB                       ;SAVE IT
  LD A,C                  ; Get MSB                        ;GET HO
  JR NC,NOMADD            ; Bit was zero - Don't add       ;DON'T ADD IN NUMBER IF BIT WAS ZERO
  PUSH DE                                                  ;SAVE COUNTERS

  DEFB $11                ; SMC trick: "LD DE,nn"          ;GET LO'S OF NUMBER TO ADD, THIS IS SET ABOVE
; Data block at 10062
MULVAL2:
  DEFW $0000

; Routine at 10064
L2750:
  ADD HL,DE               ; Add NMSB and LSB               ;ADD THEM IN
  POP DE                                                   ;GET COUNTERS BACK

  DEFB $CE                ; SMC trick: ADC A,n -> Add MSB  ;ADD IN HO, THIS IS SET UP ABOVE
MULVAL:
  DEFB $00

; Routine at 10068
;
; Used by the routine at MULT8.
NOMADD:
  RRA                     ; Shift MSB right                ;ROTATE RESULT RIGHT ONE
  LD C,A                  ; Re-save MSB
  LD A,H                  ; Get NMSB                       ;ROTATE NEXT BYTE
  RRA                     ; Shift NMSB right
  LD H,A                  ; Re-save NMSB
  LD A,L                  ; Get LSB                        ;ROTATE NEXT LOWER ORDER
  RRA                     ; Shift LSB right
  LD L,A                  ; Re-save LSB
  LD A,B                  ; Get VLSB                       ;ROTATE LO
  RRA                     ; Shift VLSB right
  LD B,A                  ; Re-save VLSB
  AND $10                 ;SEE IF WE ROTATED THRU ST
  JR Z,NOMADD_0           ;IF NOT DON'T WORRY
  LD A,B                  ;RE FETCH LO
  OR $20                  ;"OR" IN STICKY
  LD B,A                  ;BACK TO LO
NOMADD_0:
  DEC E                   ;ARE WE DONE?
  LD A,D                  ;GET NUMBER WE ARE MULTIPLYING BY
  JR NZ,MUL8LP            ;MULTIPLY AGAIN IF WE ARE NOT DONE
  EX DE,HL                ;GET LO'S IN (DE)

; (POP HL / RET)
;
; Used by the routines at ADDEXP, NXTARY and NOTDGI.
POPHLRT:
  POP HL                  ;GET POINTER TO NUMBER TO MULTIPLY BY
  RET                     ;ALL DONE

; Shift partial product left
;
; Used by the routine at MULT8.
BYTSFT:
  LD B,E                  ;MULTIPLY BY ZERO: SHIFT EVERYTHING 8 RIGHT
  LD E,D
  LD D,C
  LD C,A                  ;SHIFT IN 8 ZEROS ON THE LEFT
  RET                     ;ALL DONE


; Divide FP by 10

;DIVIDE FAC BY 10
;ALTERS A,B,C,D,E,H,L
;
; Used by the routine at MULTEN.
DIV10:
  CALL PUSHF             ;SAVE NUMBER                         ; Save FPREG on stack
  LD HL,FP_TEN           ;GET POINTER TO THE CONSTANT '10'
  CALL MOVFM             ;MOVE TEN INTO THE FAC

; Divide FP by number on stack
;
; Used by the routines at IDIV and __TAN.
DIV:
  POP BC                 ;GET NUMBER BACK IN REGISTERS
  POP DE                 ;FALL INTO DIVIDE AND WE ARE DONE


; divide BCDE by FP reg

;DIVISION	FAC:=ARG/FAC
;ALTERS A,B,C,D,E,H,L
;
; Used by the routines at __LOG and __ATN.
FDIV:
  CALL SIGN               ; Test sign of FPREG                        ;CHECK FOR DIVISION BY ZERO
  JP Z,DIV_DZERR          ; Error if division by zero                 ;DON'T ALLOW DIVIDE BY ZERO
  LD L,$FF                ; (-1) Flag subtract exponents              ;SUBTRACT THE TWO EXPONENTS, L IS A FLAG
  CALL ADDEXP             ; Subtract exponents                        ;FIX UP THE EXPONENTS AND THINGS
  INC (HL)                ; Add 2 to exponent to adjust..
  JP Z,OVFIN1
  INC (HL)
  JP Z,OVFIN1             ; .. (jp on errors)

;HERE WE SAVE THE FAC IN MEMORY SO WE CAN SUBTRACT IT FROM THE NUMBER
;IN THE REGISTERS QUICKLY.
  DEC HL                  ; Point to MSB                              ;POINT TO HO
  LD A,(HL)               ; Get MSB of dividend                       ;GET HO
  LD (DIV3),A             ; Save for subtraction                      ;SAVE IT
  DEC HL                                                              ;SAVE MIDDLE ORDER
  LD A,(HL)               ; Get NMSB of dividend
  LD (DIV2),A             ; Save for subtraction                      ;PUT IT WHERE NOTHING WILL HURT IT
  DEC HL                                                              ;SAVE LO
  LD A,(HL)               ; Get MSB of dividend
  LD (DIV1),A             ; Save for subtraction

;THE NUMERATOR WILL BE KEPT IN B,H,L.  THE QUOTIENT WILL BE FORMED IN C,D,E.
;TO GET A BIT OF THE QUOTIENT, WE FIRST SAVE B,H,L ON THE STACK, THEN
;SUBTRACT THE DENOMINATOR THAT WE SAVED IN MEMORY.  THE CARRY INDICATES
;WHETHER OR NOT B,H,L WAS BIGGER THAN THE DENOMINATOR.  IF B,H,L WAS BIGGER,
;THE NEXT BIT OF THE QUOTIENT IS A ONE.  TO GET THE OLD B,H,L OFF THE STACK,
;WE POP THEM INTO THE PSW.  IF THE DENOMINATOR WAS BIGGER, THE NEXT BIT OF
;THE QUOTIENT IS ZERO, AND WE GET THE OLD B,H,L BACK BY POPPING IT OFF THE
;STACK.  WE HAVE TO KEEP AN EXTRA BIT OF THE QUOTIENT IN FDIVG+1 IN CASE THE
;DENOMINATOR WAS BIGGER,  THEN B,H,L WILL GET SHIFTED LEFT.  IF THE MSB  OF
;B WAS ONE, IT HAS TO BE STORED SOMEWHERE, SO WE STORE IT IN FDIVG+1.  THEN
;THE NEXT TIME THROUGH THE LOOP B,H,L WILL LOOK BIGGER BECAUSE IT HAS AN
;EXTRA HO BIT IN FDIVG+1. WE ARE DONE DIVIDING WHEN THE MSB OF C IS A ONE.
;THIS OCCURS WHEN WE HAVE CALCULATED 24 BITS OF THE QUOTIENT.  WHEN WE JUMP
;TO ROUND, THE 25TH BIT OF THE QUOTIENT DETERMINES WHETHER WE ROUND OR NOT.
;IT IS IN THE MSB OF A.  IF INITIALLY THE DENOMINATOR IS BIGGER THAN THE
;NUMERATOR, THE FIRST BIT OF THE QUOTIENT WILL BE ZERO.  THIS MEANS WE
;WILL GO THROUGH THE DIVIDE LOOP 26 TIMES, SINCE IT STOPS ON THE 25TH BIT
;AFTER THE FIRST NON-ZERO BIT OF THE QUOTIENT.  SO, THIS QUOTIENT WILL LOOK
;SHIFTED LEFT ONE FROM THE QUOTIENT OF TWO NUMBERS IN WHICH THE NUMERATOR IS
;BIGGER.  THIS CAN ONLY OCCUR ON THE FIRST TIME THROUGH THE LOOP, SO C,D,E
;ARE ALL ZERO.  SO, IF WE FINISH THE LOOP AND C,D,E ARE ALL ZERO, THEN WE
;MUST DECREMENT THE EXPONENT TO CORRECT FOR THIS.

  LD B,C                  ; Get MSB                               ;GET NUMBER IN B,H,L
  EX DE,HL                ; NMSB,LSB to HL
  XOR A                                                           ;ZERO C,D,E AND HIGHEST ORDER
  LD C,A                  ; Clear MSB of quotient
  LD D,A                  ; Clear NMSB of quotient
  LD E,A                  ; Clear LSB of quotient
  LD (DIV4),A             ; Clear overflow count
; This entry point is used by the routine at RESDIV.
FDIV_0:
  PUSH HL                 ;SAVE LO'S OF NUMBER
  PUSH BC                 ;SAVE HO OF NUMBER
  LD A,L                  ;SUBTRACT NUMBER THAT WAS IN FAC

  DEFB $D6                ; SUB n,   ;SUBTRACT LO
DIV1:
  DEFB $00

; Routine at 10160
L27B0:
  LD L,A                  ;SAVE IT
  LD A,H                  ;SUBTRACT MIDDLE ORDER

  DEFB $DE                ; SBC A,n
DIV2:
  DEFB $00

; Routine at 10164
L27B4:
  LD H,A
  LD A,B                  ;SUBTRACT HO

  DEFB $DE                ; SBC A,n
DIV3:
  DEFB $00

; Routine at 10168
L27B8:
  LD B,A
                          ;GET HIGHEST ORDER
                          ;WE COULD DO THIS WITH NO CODE IN RAM, BUT
                          ; IT WOULD BE MUCH SLOWER.

  DEFB $3E                ; LD A,n
DIV4:
  DEFB $00

; Routine at 10171
L27BB:
  SBC A,$00               ; Count for overflows                             ;SUBTRACT THE CARRY FROM IT
  CCF                                                                       ;SET CARRY TO CORESPOND TO NEXT QUOTIENT BIT
  JR NC,RESDIV            ; Restore divisor if borrow                       ;GET OLD NUMBER BACK IF WE SUBTRACTED TOO MUCH
  LD (DIV4),A             ; Re-save overflow count                          ;UPDATE HIGHEST ORDER
  POP AF                  ; Scrap divisor                                   ;THE SUBTRACTION WAS GOOD
  POP AF                                                                    ;GET PREVIOUS NUMBER OFF STACK
  SCF                     ; Set carry to Skip "POP BC" and "POP HL"         ;NEXT BIT IN QUOTIENT IS A ONE
  DEFB $D2                ; "JP NC,nn"                                      ;"JNC" AROUND NEXT 2 BYTES

; Routine at 10184
;
; Used by the routine at L27BB.
RESDIV:
  POP BC                  ;WE SUBTRACTED TOO MUCH                        ; Restore divisor
  POP HL                  ;GET OLD NUMBER BACK
  LD A,C                  ;ARE WE DONE?                                  ; Get MSB of quotient
  INC A                   ;SET SIGN FLAG WITHOUT AFFECTING CARRY
  DEC A
  RRA                     ;PUT CARRY IN MSB                              ; Bit 0 to bit 7
  JP P,DIV2A              ;NOT READY TO ROUND YET
  RLA                     ;BIT BACK TO CARRY                             ; Restore carry
  LD A,(DIV4)             ;FETCH EXTRA BIT
  RRA                     ;BOTH NOW IN A
  AND $C0                 ;CLEAR SUPERFLUOUS BITS
  PUSH AF                 ;SAVE FOR LATER
  LD A,B                  ;FETCH HO OF REMAINDER
  OR H                    ;FETCH HO
  OR L                    ;SEE IF OTHER REMAINDER BITS AND IF SO SET ST
  JR Z,RESDIV_0           ;IF NOT IGNORE
  LD A,$20                ;ST BIT

RESDIV_0:
  POP HL                  ;AND THE REST OF REMAINDER
  OR H                    ;"OR" IN REST
  JP RONDUP_0             ;USE REMAINDER

DIV2A:
  RLA                     ; Restore carry                   ;WE AREN'T, GET OLD CARRY BACK
  LD A,E                  ; Get LSB of quotient             ;ROTATE EVERYTHING LEFT ONE
  RLA                     ; Double it                       ;ROTATE NEXT BIT OF QUOTIENT IN
  LD E,A                  ; Put it back
  LD A,D                  ; Get NMSB of quotient
  RLA                     ; Double it
  LD D,A                  ; Put it back
  LD A,C                  ; Get MSB of quotient
  RLA                     ; Double it
  LD C,A                  ; Put it back
  ADD HL,HL               ; Double NMSB,LSB of divisor      ;ROTATE A ZERO INTO RIGHT END OF NUMBER
  LD A,B                  ; Get MSB of divisor              ;THE HO BYTE, FINALLY!

  RLA                     ; Double it
  LD B,A                  ; Put it back
  LD A,(DIV4)             ; Get VLSB of quotient            ;ROTATE THE HIGHEST ORDER
  RLA                     ; Double it
  LD (DIV4),A             ; Put it back
  LD A,C                  ; Get MSB of quotient             ;ADD ONE TO EXPONENT IF THE FIRST SUBTRACTION
  OR D                    ; Merge NMSB                      ; DID NOT WORK
  OR E                    ; Merge LSB
  JR NZ,FDIV_0            ; Not done - Keep dividing        ;THIS ISN'T THE CASE
  PUSH HL                 ; Save divisor                    ;SAVE PART OF NUMBER
  LD HL,FPEXP             ; Point to exponent               ;GET POINTER TO FAC
  DEC (HL)                ; Divide by 2                     ;DECREMENT EXPONENT
  POP HL                  ; Restore divisor                 ;GET NUMBER BACK
  JR NZ,FDIV_0            ; Ok - Keep going                 ;DIVIDE MORE IF NO OVERFLOW OCCURED
  JP ZERO                 ; Overflow error                  ;UNDERFLOW!!


;CHECK SPECIAL CASES AND ADD EXPONENTS FOR FMULT, FDIV
;ALTERS A,B,H,L

; This entry point is used by the routine at DDIV.
MULDVS:
  LD A,$FF                ;ENTRY FROM DDIV, SUBTRACT EXPONENTS
  DEFB $2E                ;"MVI	L" AROUND NEXT BYTE      ; "LD L,n" to Mask 'XOR A'

; This entry point is used by the routine at DMUL.
MULDVA:
  XOR A                   ;ENTRY FROM DMULT, ADD EXPONENTS
  LD HL,ARG-1             ;GET POINTER TO SIGN AND HO OF ARG
  LD C,(HL)               ;GET HO AND SIGN FOR UNPACKING
  INC HL                  ;INCREMENT POINTER TO EXPONENT
  XOR (HL)                ;GET EXPONENT
  LD B,A                  ;SAVE IT IN B FOR BELOW
  LD L,$00                ;SET FLAG TO ADD THE EXPONENTS BELOW

; Add (or subtract) exponent
;
; Used by the routines at FMULT and FDIV.
ADDEXP:
  LD A,B                  ; Get exponent of dividend         ;IS NUMBER IN REGISTERS ZERO?
  OR A                    ; Test it
  JR Z,OVTST3             ; Zero - Result zero               ;IT IS, ZERO FAC AND WE ARE DONE
  LD A,L                  ; Get add/subtract flag            ;GET ADD OR SUBTRACT FLAG
  LD HL,FPEXP             ; Point to exponent                ;GET POINTER TO EXPONENT
  XOR (HL)                ; Add or subtract it               ;GET EXPONENT
  ADD A,B                 ; Add the other exponent           ;ADD IN REGISTER EXPONENT
  LD B,A                  ; Save new exponent                ;SAVE IT
  RRA                     ; Test exponent for overflow       ;CHECK FOR OVERFLOW
  XOR B                                                      ;OVERFLOW IF SIGN IS THE SAME AS CARRY
  LD A,B                  ; Get exponent                     ;GET SUM
  JP P,DIV_OVTST2         ; Positive - Test for overflow     ;WE HAVE OVERFLOW!!
  ADD A,$80               ; Add excess 128                   ;PUT EXPONENT IN EXCESS 200
  LD (HL),A               ; Save new exponent                ;SAVE IT IN THE FAC
  JP Z,POPHLRT            ; Zero - Result zero               ;WE HAVE UNDEFLOW!! RETURN.
  CALL UNPACK             ; Set MSBs and sign of result      ;UNPACK THE ARGUMENTS
  LD (HL),A               ; Save new exponent                ;SAVE THE NEW SIGN

; DCRART ->  DEC A, RET
;
; Used by the routines at PUFOUT and FOUBE3.
DCXHRT:
  DEC HL                  ;POINT TO EXPONENT
  RET                     ;ALL DONE, LEAVE HO IN A

; Test for OVERFLOW
MLDVEX:
  CALL SIGN               ; Test sign of FPREG               ;ENTRY FROM EXP, PICK UNDERFLOW IF NEGATIVE
  CPL                     ; Invert sign                      ;PICK OVERFLOW IF POSITIVE
  POP HL                  ; Clean up stack                   ;DON'T SCREW UP STACK

; This entry point is used by the routine at ADDEXP.
DIV_OVTST2:
  OR A                    ; Test if new exponent zero        ;IS ERROR OVERFLOW OR UNDEFLOW?

; This entry point is used by the routine at ADDEXP.
OVTST3:
  POP HL                  ; Clear off return address         ;GET OLD RETURN ADDRESS OFF STACK
  JP P,ZERO               ; Result zero
  JP OVFIN1               ; Overflow error


; Multiply number in FPREG by 10

	;MULTIPLY FAC BY 10
	;ALTERS A,B,C,D,E,H,L
;
; Used by the routine at MULTEN.
MLSP10:
  CALL BCDEFP             ; Move FPREG to BCDE               ;GET NUMBER IN REGISTERS
  LD A,B                  ; Get exponent                     ;GET EXPONENT
  OR A                    ; Is it zero?                      ;RESULT IS ZERO IF ARG IS ZERO
  RET Z                   ; Yes - Result is zero             ;IT IS
  ADD A,$02               ; Multiply by 4                    ;MULTIPLY BY 4 BY ADDING 2 TO EXPONENT
  JP C,OVERR              ; Overflow - ?OV Error
  LD B,A                  ; Re-save exponent                 ;RESTORE EXPONENT
  CALL FADD               ; Add BCDE to FPREG (Times 5)      ;ADD IN ORIGINAL NUMBER TO GET 5 TIMES IT
  LD HL,FPEXP             ; Point to exponent                ;ADD 1 TO EXPONENT TO MULTIPLY NUMBER BY
  INC (HL)                ; Double number (Times 10)         ; 2 TO GET 10 TIMES ORIGINAL NUMBER
  RET NZ                  ; Ok - Return                      ;ALL DONE IF NO OVERFLOW
  JP OVERR                ; Overflow error


; Test sign of FPREG

	;PUT SIGN OF FAC IN A
	;ALTERS A ONLY
	;LEAVES FAC ALONE
	;NOTE: TO TAKE ADVANTAGE OF THE RST INSTRUCTIONS TO SAVE BYTES, FSIGN IS USUALLY DEFINED TO BE AN RST.
	;"FSIGN" IS EQUIVALENT TO "CALL SIGN"
	;THE FIRST FEW INSTRUCTIONS OF SIGN (THE ONES BEFORE SIGNC) ARE DONE IN THE 8 BYTES AT THE RST LOCATION.

;
; Used by the routines at FORFND, __POKE, __LOG, FMULT, FDIV, MLDVEX,
; VSIGN, FCOMP, XDCOMP, __FIX, DMUL, FOUBE3, __SQR, __RND, __SIN and __ATN.
SIGN:
  LD A,(FPEXP)            ; Get sign of FPREG
  OR A                                                       ;CHECK IF THE NUMBER IS ZERO
  RET Z                   ; RETurn if number is zero         ;IT IS, A IS ZERO
  LD A,(FACCU+2)          ; Get MSB of FPREG                           ;GET SIGN OF FAC, IT IS NON-ZERO
  DEFB $FE                ; CP 2Fh ..hides the "CPL" instruction       ;"CPI" AROUND NEXT BYTE

;
; Used by the routine at DCOMP.
FCOMPS:
  CPL                     ; Invert sign         ;ENTRY FROM FCOMP, COMPLEMENT SIGN

;
; Used by the routines at VSIGN and ICOMP.
ICOMPS:
  RLA                     ; Sign bit to carry   ;ENTRY FROM ICOMP, PUT SIGN BIT IN CARRY

;
; Used by the routines at ICOMP and STRCMP.
SIGNS:
  SBC A,A                 ; Carry to all bits of A      ;A=0 IF CARRY WAS 0, A=377 IF CARRY WAS 1
  RET NZ                  ; Return -1 if negative       ;RETURN IF NUMBER WAS NEGATIVE
  INC A                   ; Bump to +1                  ;PUT ONE IN A IF NUMBER WAS POSITIVE
  RET                     ; Positive - Return +1        ;ALL DONE



; CY and A to FP, & normalise

	;SGN FUNCTION
	;ALTERS A,B,C,D,E,H,L
	;FALL INTO FLOAT


	;FLOAT THE SIGNED INTEGER IN A
	;ALTERS A,B,C,D,E,H,L

	;USE MICROSOFT FORMAT IF NOT INTEL
;
; Used by the routines at __LOG and MULTEN.
; a.k.a. FLGREL
FLOAT:                                                          ;SET EXPONENT CORRECTLY
  LD B,$88                ; 8 bit integer in exponent           ;ZERO D,E
  LD DE,$0000             ; Zero NMSB and LSB                   ;FALL INTO FLOATR

; a.k.a. RETINT
; This entry point is used by the routines at HLPASS and INEG.
FLOATR:
  LD HL,FPEXP             ; Point to exponent                   ;GET POINTER TO FAC
  LD C,A                  ; CDE = MSB,NMSB and LSB              ;PUT HO IN C
  LD (HL),B               ; Save exponent                       ;PUT EXPONENT IN THE FAC
  LD B,$00                ; CDE = integer to normalise          ;ZERO OVERFLOW BYTE
  INC HL                  ; Point to sign of result             ;POINT TO SIGN
  LD (HL),$80             ; Set sign of result                  ;ASSUME A POSITIVE NUMBER
  RLA                     ; Carry = sign of integer             ;PUT SIGN IN CARRY
  JP CONPOS               ; Set sign of result                  ;GO AND FLOAT THE NUMBER



;
;	;GET THE VALTYP AND SET CONDITION CODES AS FOLLOWS:
;;CONDITION CODE		TRUE SET	FALSE SET
;;SIGN			INT=2		STR,SNG,DBL
;;ZERO			STR=3		INT,SNG,DBL
;;ODD PARITY		SNG=4		INT,STR,DBL
;;NO CARRY		DBL=10		INT,STR,SNG
;GETYPE:	LDA	VALTYP		;GET THE VALTYP
;	CPI	10		;SET CARRY CORRECTLY
;	DCR	A		;SET THE OTHER CONDITION CODES CORRECTLY
;	DCR	A		; WITHOUT AFFECTING CARRY
;	DCR	A
;	RET	*			;ALL DONE


; 'ABS' BASIC function

	;ABSOLUTE VALUE OF FAC
	;ALTERS A,B,C,D,E,H,L

;
__ABS:
  CALL VSIGN          ;GET THE SIGN OF THE FAC IN A
  RET P               ;IF IT IS POSITIVE, WE ARE DONE


; Invert number sign

	;NEGATE ANY TYPE VALUE IN THE FAC
	;ALTERS A,B,C,D,E,H,L

;
; Used by the routines at MINUS, __FIX, _ASCTFP and PUFOUT.
INVSGN:
  CALL GETYPR         ;SEE WHAT KIND OF NUMBER WE HAVE
  JP M,INEG           ;WE HAVE AN INTEGER, NEGATE IT THAT WAY
  JP Z,TM_ERR         ;BLOW UP ON STRINGS,   If string type, Err $0D - "Type mismatch"
                      ;FALL INTO NEG TO NEGATE A SNG OR DBL


; Invert number sign

	;NEGATE NUMBER IN THE FAC
	;ALTERS A,H,L
	;NOTE: THE NUMBER MUST BE PACKED

;
; Used by the routines at FSUB, __FIX, IMULT5, __SQR, __SIN and __ATN.
NEG:                   ;IF INTFSW=0 DO NOT USE INTEL FORMAT
  LD HL,FACCU+2        ;GET POINTER TO SIGN
  LD A,(HL)            ;GET SIGN
  XOR $80              ;COMPLEMENT SIGN BIT
  LD (HL),A            ;SAVE IT
  RET                  ;ALL DONE


; 'SGN' BASIC function

	;SGN FUNCTION
	;ALTERS A,H,L
;
__SGN:
  CALL VSIGN            ;GET THE SIGN OF THE FAC IN A    ; Test sign of FPREG

;ENTRY TO CONVERT A SIGNED NUMBER IN A TO AN INTEGER
; Signed char to signed int conversion, then return
; Get back from function, result in A (signed)
;
; Used by the routines at DOCMP and __EOF.
CONIA:
  LD L,A                ;PUT IT IN THE LO POSITION
  RLA                   ;EXTEND THE SIGN TO THE HO     ; Sign bit to carry
  SBC A,A                                              ; Carry to all bits of A
  LD H,A
  JP MAKINT             ;RETURN THE RESULT AND SET VALTYP


; Test sign in number

	;GET THE SIGN OF THE VALUE IN THE FAC IN A
	;ALTERS A,H,L
;
; Used by the routines at __IF, __ABS, __SGN, PUFOUT and __WEND.
VSIGN:
  CALL GETYPR           ;SEE WHAT KIND OF A NUMBER WE HAVE
  JP Z,TM_ERR           ;BLOW UP ON STRINGS
  JP P,SIGN             ;SINGLE AND DOUBLE PREC. WORK THE SAME
  LD HL,(FACCU)         ;GET THE INTEGER ARGUMENT


	;ENTRY TO FIND THE SIGN OF (HL)
	;ALTERS A ONLY
; This entry point is used by the routine at FORFND.
ISIGN:
  LD A,H                ;GET ITS SIGN
  OR L                  ;CHECK IF THE NUMBER IS ZERO
  RET Z                 ;IT IS, WE ARE DONE
  LD A,H                ;IT ISN'T, SIGN IS THE SIGN OF H
  JR ICOMPS             ;GO SET A CORRECTLY


; Put FP value on stack

	;FLOATING POINT MOVEMENT ROUTINES
	;PUT FAC ON STACK
	;ALTERS D,E
;
; Used by the routines at _EVAL, IDIV, FADD, __LOG, DIV10, IADD, IMULT5,
; MULTEN, PUFOUT, __SQR, __EXP, SUMSER, POLY, __SIN and __TAN.
PUSHF:
  EX DE,HL              ; Save code string address        ;SAVE (HL)
  LD HL,(FACCU)         ; LSB,NLSB of FPREG               ;GET LO'S
  EX (SP),HL            ; Stack them,get return           ;SWITCH LO'S AND RET ADDR
  PUSH HL               ; Re-save return                  ;PUT RET ADDR BACK ON STACK
  LD HL,(FACCU+2)       ; MSB and exponent of FPREG       ;GET HO'S
  EX (SP),HL            ; Stack them,get return           ;SWITCH HO'S AND RET ADDR
  PUSH HL               ; Re-save return                  ;PUT RET ADDR BACK ON STACK
  EX DE,HL              ; Restore code string address     ;GET OLD (HL) BACK
  RET                                                       ;ALL DONE



	;MOVE NUMBER FROM MEMORY [(HL)] TO FAC
	;ALTERS B,C,D,E,H,L
	;AT EXIT NUMBER IS IN B,C,D,E
	;AT EXIT (HL):=(HL)+4

; a.k.a. PHLTFP
; Used by the routines at DIV10, RNGTST, __SQR, POLY, RNDMN2, __RND and
; __NEXT.
MOVFM:
  CALL LOADFP             ; Number at HL to BCDE       ;GET NUMBER IN REGISTERS
                                                       ;FALL INTO MOVFR AND PUT IT IN FAC

; Move BCDE to FPREG
; a.k.a. MOVFR
;
	;MOVE REGISTERS (B,C,D,E) TO FAC
	;ALTERS D,E
;
; Used by the routines at FADD, BNORM, __LOG, PUFOUT, RNGTST, GET_UNITY and __TAN.
FPBCDE:
  EX DE,HL                ; Save code string address          ;GET LO'S IN (HL)
  LD (FACCU),HL           ; Save LSB,NLSB of number           ;PUT THEM WHERE THEY BELONG
  LD H,B                  ; Exponent of number                ;GET HO'S IN (HL)
  LD L,C                  ; MSB of number
  LD (FACCU+2),HL         ; Save MSB and exponent             ;PUT HO'S WHERE THEY BELONG
  EX DE,HL                ; Restore code string address       ;GET OLD (HL) BACK
  RET                                                         ;ALL DONE


; Load FP reg to BCDE
; a.k.a. MOVRF
;
	;MOVE FAC TO REGISTERS (B,C,D,E)
	;ALTERS B,C,D,E,H,L
;
; Used by the routines at FORFND, __LOG, MLSP10, __CSNG, QINT, INT,
; RNGTST, __SQR, SUMSER and __RND.
BCDEFP:
  LD HL,FACCU             ; Point to FPREG                    ;GET POINTER TO FAC
                                                              ;FALL INTO MOVRM

; Load FP value pointed by HL to BCDE,
; a.k.a. MOVRM
;
;GET NUMBER IN REGISTERS (B,C,D,E) FROM MEMORY [(HL)]
;ALTERS B,C,D,E,H,L
;AT EXIT (HL):=(HL)+4
;
; Used by the routines at FADDS, FSUBS, MOVFM, POLY, __RND and __NEXT.
LOADFP:
  LD E,(HL)               ; Get LSB of number                 ;GET LO
  INC HL                                                      ;POINT TO MO
LOADFP_0:                                                     
  LD D,(HL)               ; Get NMSB of number                ;GET MO, ENTRY FOR BILL
  INC HL                                                      ;POINT TO HO
  LD C,(HL)               ; Get MSB of number                 ;GET HO
  INC HL                                                      ;POINT TO EXPONENT
  LD B,(HL)               ; Get exponent of number            ;GET EXPONENT

; This entry point is used by the routines at PROMPT, CONLIN, PUFOUT and FOUBE3.
INCHL:
  INC HL                  ; Used for conditional "INC HL"     ;INC POINTER TO BEGINNING OF NEXT NUMBER
  RET                                                         ;ALL DONE


	;MOVE NUMBER FROM FAC TO MEMORY [(HL)]
	;ALTERS A,B,D,E,H,L
	;a.k.a. MOVMF
; This entry point is used by the routines at __FOR, __RND and __NEXT.
FPTHL:
  LD DE,FACCU             ; Point to FPREG                    ;GET POINTER TO FAC
                                                              ;FALL INTO MOVE
	;MOVE NUMBER FROM (DE) TO (HL)
	;ALTERS A,B,D,E,H,L
	;EXITS WITH (DE):=(DE)+4, (HL):=(HL)+4
; This entry point is used by the routines at DDIV_SUB and __NEW.
MOVE:
  LD B,$04                ; 4 bytes to move    ;SET COUNTER
  JR MOVE1                                     ;CONTINUE WITH THE MOVE


; Copy number value from HL to DE
	;MOVE ANY TYPE VALUE (AS INDICATED BY VALTYP) FROM (DE) TO (HL)
	;ALTERS A,B,D,E,H,L
MOVVFM:
  EX DE,HL                ;ENTRY TO SWITCH (DE) AND (HL)

; This entry point is used by the routines at __LET, CMPPHL, DDIV10, FOUBE3,
; __TROFF, PUTTMP and FN_INSTR.
VMOVE:
  LD A,(VALTYP)           ;GET THE LENGTH OF THE NUMBER                                 
  LD B,A                  ;SAVE IT AWAY  (number of bytes to move)      

; Routine at 10468
;
; Used by the routines at CHRGTB, LOADFP and CAYSTR.
MOVE1:
  LD A,(DE)               ; Get source            ;GET WORD, ENTRY FROM VMOVMF
  LD (HL),A               ; Save destination      ;PUT IT WHERE IT BELONGS
  INC DE                  ; Next source           ;INCREMENT POINTERS TO NEXT WORD
  INC HL                  ; Next destination
  ;DEC B                   ; Count bytes
  DJNZ MOVE1             ; Loop if more
  RET


;UNPACK THE FAC AND THE REGISTERS
;ALTERS A,C,H,L
;WHEN THE NUMBER IN THE FAC IS UNACKED, THE ASSUMED ONE IN THE
;MANTISSA IS RESTORED, AND THE COMPLEMENT OF THE SIGN IS PLACED IN FAC+1

; This entry point is used by the routines at FADD, ADDEXP, __CSNG, QINT, INT
; and DADD.
UNPACK:
  LD HL,FACCU+2           ; Point to MSB of FPREG    ;POINT TO HO AND SIGN
  LD A,(HL)               ; Get MSB                  ;GET HO AND SIGN
  RLCA                    ; Old sign to carry        ;DUPLICATE THE SIGN IN CARRY AND THE LSB
  SCF                     ; Set MSBit                ;RESTORE THE HIDDEN ONE
  RRA                     ; Set MSBit of MSB         ;RESTORE THE NUMBER IN A
  LD (HL),A               ; Save new MSB             ;SAVE HO
  CCF                     ; Complement sign          ;GET THE COMPLEMENT OF THE SIGN
  RRA                     ; Old sign to carry        ;GET IT IN THE SIGN BIT
  INC HL                                             ;POINT TO TEMPORARY SIGN BYTE
  INC HL                                             
  LD (HL),A               ; Set sign of result       ;SAVE COMPLEMENT OF SIGN
  LD A,C                  ; Get MSB                  ;GET HO AND SIGN OF THE REGISTERS
  RLCA                    ; Old sign to carry        ;DUPLICATE THE SIGN IN CARRY AND THE LSB
  SCF                     ; Set MSBit                ;RESTORE THE HIDDEN ONE
  RRA                     ; Set MSBit of MSB         ;RESTORE THE HO IN A
  LD C,A                  ; Save MSB                 ;SAVE THE HO
  RRA                                                ;GET THE SIGN BACK
  XOR (HL)                ; New sign of result       ;COMPARE SIGN OF FAC AND SIGN OF REGISTERS
  RET                                                ;ALL DONE


	;MOVE ANY TYPE VALUE FROM MEMORY [(HL)] TO FAC
	;ALTERS A,B,D,E,H,L
; This entry point is used by the routine at DADD.
VMOVFA:
  LD HL,FPARG             ;ENTRY FROM DADD, MOVE ARG TO FAC

; This entry point is used by the routines at CHRGTB, EVAL_VARIABLE, DOFN,
; __CINT, RNGTST, __CVD and __CALL.
VMOVFM:
  LD DE,MOVVFM            ;GET ADDRESS OF LOCATION THAT DOES  ; Copy number value from HL to DEES
  JR VMVVFM               ; AN "XCHG" AND FALLS INTO MOVE1


	;MOVE ANY TYPE VALUE FROM FAC TO MEMORY [(HL)]
	;ALTERS A,B,D,E,H,L
; Used by the routines at __CINT, DDIV, MULTEN and RNGTST.
VMOVAF:
  LD HL,FPARG             ;ENTRY FROM FIN, DMUL10, DDIV10


	;MOVE FAC TO ARG
; Used by the routines at DOFN and __MKD_S.
VMOVMF:
  LD DE,VMOVE             ;GET ADDRESS OF MOVE SUBROUTINE  (Copy number value from DE to HL)

; This entry point is used by the routine at MOVE1.
VMVVFM:
  PUSH DE                 ;SHOVE IT ON THE STACK
;VDFACS:
  LD DE,FACCU             ;GET FIRST ADDRESS FOR INT, STR, SNG
  CALL GETYPR             ;GET THE VALUE TYPE
  RET C                   ;GO MOVE IT IF WE DO NOT HAVE A DBL
  LD DE,FACLOW            ;WE DO, GET LO ADDR OF THE DBL NUMBER
  RET                     ;GO DO THE MOVE


;	COMPARE TWO NUMBERS

	;COMPARE TWO SINGLE PRECISION NUMBERS
	;A=1 IF ARG .LT. FAC
	;A=0 IF ARG=FAC
	;A=-1 IF ARG .GT. FAC
	;DOREL DEPENDS UPON THE FACT THAT FCOMP RETURNS WITH CARRY ON
	; IFF A HAS 377
	;ALTERS A,H,L

; aka CMPNUM, Compare FP reg to BCDE
;
; Used by the routines at SETTYPE, MULTEN, FOUBE3, RNGTST, __SQR, __SIN and
; __NEXT.
FCOMP:
  LD A,B                  ; Get exponent of number
  OR A                    ;CHECK IF ARG IS ZERO
  JP Z,SIGN               ; Zero - Test sign of FPREG
  LD HL,FCOMPS            ; Return relation routine           ;WE JUMP TO FCOMPS WHEN WE ARE DONE
  PUSH HL                 ; Save for return                   ;PUT THE ADDRESS ON THE STACK
  CALL SIGN               ; Test sign of FPREG                ;CHECK IF FAC IS ZERO
  LD A,C                  ; Get MSB of number                 ;IF IT IS, RESULT IS MINUS THE SIGN OF ARG
  RET Z                   ; FPREG zero - Number's MSB         ;IT IS
  LD HL,FACCU+2           ; MSB of FPREG                      ;POINT TO SIGN OF FAC
  XOR (HL)                ; Combine signs                     ;SEE IF THE SIGNS ARE THE SAME
  LD A,C                  ; Get MSB of number                 ;IF THEY ARE DIFFERENT, RESULT IS SIGN OF ARG
  RET M                   ; Exit if signs different           ;THEY ARE DIFFERENT
  CALL CMPFP              ; Compare FP numbers                ;CHECK THE REST OF THE NUMBER
; This entry point is used by the routine at XDCOMP.
FCOMPD:
  RRA                     ; Get carry to sign                 ;NUMBERS ARE DIFFERENT, CHANGE SIGN IF
  XOR C                   ; Combine with MSB of number        ; BOTH NUMBERS ARE NEGATIVE
  RET                                                         ;GO SET UP A

; Compare FP numbers
;
; Used by the routine at FCOMP.
CMPFP:
  INC HL                  ; Point to exponent                 ;POINT TO EXPONENT
  LD A,B                  ; Get exponent                      ;GET EXPONENT OF ARG
  CP (HL)                 ; Compare exponents                 ;COMPARE THE TWO
  RET NZ                  ; Different                         ;NUMBERS ARE DIFFERENT
  DEC HL                  ; Point to MBS                      ;POINT TO HO
  LD A,C                  ; Get MSB                           ;GET HO OF ARG
  CP (HL)                 ; Compare MSBs                      ;COMPARE WITH HO OF FAC
  RET NZ                  ; Different                         ;THEY ARE DIFFERENT
  DEC HL                  ; Point to NMSB                     ;POINT TO MO OF FAC
  LD A,D                  ; Get NMSB                          ;GET MO OF ARG
  CP (HL)                 ; Compare NMSBs                     ;COMPARE WITH MO OF FAC
  RET NZ                  ; Different                         ;THE NUMBERS ARE DIFFERENT
  DEC HL                  ; Point to LSB                      ;POINT TO LO OF FAC
  LD A,E                  ; Get LSB                           ;GET LO OF ARG
  SUB (HL)                ; Compare LSBs                      ;SUBTRACT LO OF FAC
  RET NZ                  ; Different                         ;NUMBERS ARE DIFFERENT
  POP HL                  ; Drop RETurn                       ;NUMBERS ARE THE SAME, DON'T SCREW UP STACK
  POP HL                  ; Drop another RETurn               
  RET                                                         ;ALL DONE


; Integer COMPARE
; Compare the signed integer in DE to the signed integer in HL
;
	;COMPARE TWO INTEGERS
	;A=1 IF (DE) .LT. (HL)
	;A=0 IF (DE)=(HL)
	;A=-1 IF (DE) .GT. (HL)
	;ALTERS A ONLY
;
; Used by the routine at __NEXT.
ICOMP:
  LD A,D                ;ARE THE SIGNS THE SAME?
  XOR H
  LD A,H                ;IF NOT, ANSWER IS THE SIGN OF (HL)
  JP M,ICOMPS           ;THEY ARE DIFFERENT
  CP D                  ;THEY ARE THE SAME, COMPARE THE HO'S
  JR NZ,ICOMP_0         ;GO SET UP A
  LD A,L                ;COMPARE THE LO'S
  SUB E
  RET Z                 ;ALL DONE, THEY ARE THE SAME
ICOMP_0:
  JP SIGNS              ;GO SET UP A



	;COMPARE TWO DOUBLE PRECISION NUMBERS
	;A=1 IF ARG .LT. FAC
	;A=0 IF ARG=FAC
	;A=-1 IF ARG .GT. FAC
	;ALTERS A,B,C,D,E,H,L

; a.k.a. DCOMPD
; Routine at 10586
;
; Used by the routines at FOUBE3 and RNGTST.
CMPPHL:
  LD HL,FPARG           ;ENTRY WITH POINTER TO ARG IN (DE)
  CALL VMOVE            ;MOVE THE ARGUMENT INTO ARG

; FP COMPARE
;
; Used by the routine at DCOMP.
XDCOMP:
  LD DE,ARG             ;GET POINTER TO ARG
  LD A,(DE)             ;SEE IF ARG=0
  OR A
  JP Z,SIGN             ;ARG=0, GO SET UP A
  LD HL,FCOMPS          ;PUSH FCOMPS ON STACK SO WE WILL RETURN TO
  PUSH HL               ; TO IT AND SET UP A
  CALL SIGN             ;SEE IF FAC=0
  DEC DE                ;POINT TO SIGN OF ARGUMENT
  LD A,(DE)             ;GET SIGN OF ARG
  LD C,A                ;SAVE IT FOR LATER
  RET Z                 ;FAC=0, SIGN OF RESULT IS SIGN OF ARG
  LD HL,FACCU+2         ;POINT TO SIGN OF FAC
  XOR (HL)              ;SEE IF THE SIGNS ARE THE SAME
  LD A,C                ;IF THEY ARE, GET THE SIGN OF THE NUMBERS
  RET M                 ;THE SIGNS ARE DIFFERENT, GO SET A
  INC DE                ;POINT BACK TO EXPONENT OF ARG
  INC HL                ;POINT TO EXPONENT OF FAC
  LD B,$08              ;SET UP A COUNT
XDCOMP_0:
  LD A,(DE)             ;GET A BYTE FROM ARG
  SUB (HL)              ;COMPARE IT WITH THE FAC
  JR NZ,FCOMPD          ;THEY ARE DIFFERENT, GO SET UP A
  DEC DE                ;THEY ARE THE SAME, EXAMINE THE NEXT LOWER
  DEC HL                ; ORDER BYTES
  ;DEC B                 ;ARE WE DONE?
  DJNZ XDCOMP_0        ;NO, COMPARE THE NEXT BYTES
  POP BC                ;THEY ARE THE SAME, GET FCOMPS OFF STACK
  RET                   ;ALL DONE


; Compare the double precision numbers in FAC1 and ARG
	;COMPARE TWO DOUBLE PRECISION NUMBERS
	;A=1 IF ARG .GT. FAC
	;A=0 IF ARG=FAC
	;A=-1 IF ARG .LT. FAC
	;NOTE:	THIS IS THE REVERSE OF ICOMP, FCOMP AND XDCOMP
	;ALTERS A,B,C,D,E,H,L
; Double precision COMPARE
DCOMP:
  CALL XDCOMP           ;COMPARE THE TWO NUMBERS
  JP NZ,FCOMPS          ;NEGATE THE ANSWER, MAKE SURE THE CARRY COMES
  RET                   ; OUT CORRECT FOR DOCMP



;  CONVERSION ROUTINES BETWEEN INTEGER, SINGLE AND DOUBLE PRECISION
	

; 'CINT' BASIC function
; a.k.a. FRCINT
	;FORCE THE FAC TO BE AN INTEGER
	;ALTERS A,B,C,D,E,H,L
;
; Used by the routines at FORFND, _EVAL, NOT, DANDOR, DEPINT and __RANDOMIZE.
__CINT:
  CALL GETYPR          	;SEE WHAT WE HAVE
  LD HL,(FACCU)        	;GET FACLO+0,1 IN CASE WE HAVE AN INTEGER
  RET M                 ;WE HAVE AN INTEGER, ALL DONE
  JP Z,TM_ERR           ;WE HAVE A STRING, THAT IS A "NO-NO"
  JP PO,__CINT_0        ;GO DO S.P.
;FDBINT:
  CALL VMOVAF          	;ADD D.P. .5
  LD HL,DBL_FP_ZERO
  CALL VMOVFM
  CALL DADD
  CALL CONSD
  JR __CINT_1

__CINT_0:
  CALL FADDH
__CINT_1:
  LD A,(FACCU+2)        ;GET SIGN BYTE
  OR A                  ;SET CONDITION CODES CORRECTLY
  PUSH AF
  AND $7F               ;CLEAR SIGN
  LD (FACCU+2),A        ;MAKE FAC POSITIVE
  LD A,(FPEXP)          ;GET EXPONENT
  CP $90                ;SEE IF TOO LARGE
  JP NC,OV_ERR          ;
  CALL QINT             ;CONVERT TO INTEGER
  LD A,(FPEXP)
  OR A
  JR NZ,__CINT_2
  POP AF
  EX DE,HL
  JR __CINT_3

__CINT_2:
  POP AF
  EX DE,HL              ;MOVE INTEGER TO (HL)
  JP P,__CINT_4
__CINT_3:
  LD A,H
  CPL
  LD H,A                ;COMPLEMENT (HL)
  LD A,L
  CPL
  LD L,A
__CINT_4:
  JR MAKINT

;FRCIN4:
  LD HL,OV_ERR          ;PUT OVERR ON THE STACK SO WE WILL GET ERROR
  PUSH HL               ; IF NUMBER IS TOO BIG
                        ;FALL INTO CONIS

; This entry point is used by the routine at __INT.
CONIS:
  LD A,(FPEXP)          ;GET THE EXPONENT
  CP $90                ;SEE IF IT IS TOO BIG
  JR NC,CONIS2          ;IT IS, BUT IT MIGHT BE -32768
  CALL QINT             ;IT ISN'T, CONVERT IT TO AN INTEGER
  EX DE,HL              ;PUT IT IN (HL)

; This entry point is used by the routines at SETTYPE and IADD.
CONIS1:                 ;ENTRY FROM IADD
  POP DE                ;GET ERROR ADDRESS OFF STACK



; Get back from function, result in HL
;
	;PUT (HL) IN FACLO, SET VALTYP TO INT
	;ALTERS A ONLY
;
; Used by the routines at __ERL, OCTCNS, PASSA, CONIA, __CINT, INT,
; IMULT, IMULT5, IDIV2, FIN and IN_PRT.
MAKINT:
  LD (FACCU),HL         ;STORE THE NUMBER IN FACLO

; Set type to "integer"
;
; Used by the routine at INEG.
VALINT:
  LD A,$02              ;SET VALTYP TO "INTEGER"

; Set variable/value type
;
; Used by the routine at VALSNG.
SETTYPE:
  LD (VALTYP),A         ;ENTRY FROM CONDS
  RET                   ;ALL DONE

; This entry point is used by the routines at __CINT and _ASCTFP.
CONIS2:
  LD BC,$9080           ; BCDE = -32768  (float)
  LD DE,$0000
  CALL FCOMP            ;CHECK IF NUMBER IS -32768, ENTRY FROM FIN
  RET NZ                ;ERROR:  IT CAN'T BE CONVERTED TO AN INTEGER
  LD H,C                ;IT IS -32768, PUT IT IN (HL)
  LD L,D
  JR CONIS1             ;STORE IT IN THE FAC AND SET VALTYP


; 'CSNG' BASIC function
;
	;FORCE THE FAC TO BE A SINGLE PRECISION NUMBER
	;ALTERS A,B,C,D,E,H,L
;
; Used by the routines at FORFND, _EVAL, ISFUN, __POKE, _ASCTFP and __SQR.
__CSNG:
  CALL GETYPR           ;SEE WHAT KIND OF NUMBER WE HAVE
  RET PO                ;WE ALREADY HAVE A SNG, ALL DONE
  JP M,CONSI            ;WE HAVE AN INTEGER, CONVERT IT
  JP Z,TM_ERR           ;STRINGS!! -- ERROR!!
                        ;DBL PREC -- FALL INTO CONSD

; This entry point is used by the routine at __CINT.
CONSD:
  CALL BCDEFP           ;GET THE HO'S IN THE REGISTERS
  CALL VALSNG           ;SET VALTYP TO "SINGLE PRECISON"
  LD A,B                ;CHECK IF THE NUMBER IS ZERO
  OR A
  RET Z                 ;IF IT IS, WE ARE DONE
  CALL UNPACK           ;UNPACK THE NUMBER
  LD HL,FACLOW+3        ;GET FIRST BYTE BELOW A SNG NUMBER
  LD B,(HL)             ;PUT IT IN B FOR ROUND
  JP RONDUP             ;ROUND THE DBL NUMBER UP AND WE ARE DONE


; Convert the signed integer in FAC1 to single precision.
	;CONVERT AN INTEGER TO A SINGLE PRECISION NUMBER
	;ALTERS A,B,C,D,E,H,L
; This entry point is used by the routines at __CDBL, MULTEN and FOUBE3.
CONSI:
  LD HL,(FACCU)         ;GET THE INTEGER
; This entry point is used by the routines at IDIV, IADD and IMULT5.
HL_CSNG:
  CALL VALSNG           ;SET VALTYP TO "SINGLE PRECISION"

; Get back from function passing an INT value HL
HLPASS:
  LD A,H                ;SET UP REGISTERS FOR FLOATR
  LD D,L
  LD E,$00
  LD B,$90
  JP FLOATR             ;GO FLOAT THE NUMBER


; 'CDBL' BASIC function
	;FORCE THE FAC TO BE A DOUBLE PRECISION NUMBER
	;ALTERS A,B,C,D,E,H,L
;
; Used by the routines at INT and _ASCTFP.
__CDBL:
  CALL GETYPR          ;SEE WHAT KIND OF NUMBER WE HAVE
  RET NC               ;WE ALREADY HAVE A DBL, WE ARE DONE
  JP Z,TM_ERR          ;GIVE AN ERROR IF WE HAVE A STRING
  CALL M,CONSI         ;CONVERT TO SNG IF WE HAVE AN INT
                       ;FALL INTO CONDS AND CONVERT TO DBL

	;CONVERT A SINGLE PRECISION NUMBER TO A DOUBLE PRECISION ONE
	;ALTERS A,H,L
; This entry point is used by the routine at MULTEN.
CONDS:
  LD HL,$0000          ;ZERO H,L
  LD (FACLOW),HL       ;CLEAR THE FOUR LOWER BYTES IN THE DOUBLE
  LD (FACLOW+2),HL     ; PRECISION NUMBER

; Set type to "double precision"
;
; Used by the routine at FIN_DBL.
VALDBL:
  LD A,$08             ;SET VALTYP TO "DOUBLE PRECISION"
  DEFB $01             ; "LD BC,nn" to jump over the next word without executing it

; Set type to "single precision"
;
; Used by the routines at __CSNG, INEG and RNDMN2.
VALSNG:
  LD A,$04             ;SET VALTYP TO "SINGLE PRECISION"
  JR SETTYPE


; Test for string type, 'Type Error' if it is not
; a.k.a. CHKSTR, FRCSTR
;
	;FORCE THE FAC TO BE A STRING
	;ALTERS A ONLY
;
; Used by the routines at __LINE, ISFUN, LINE_INPUT, __FIELD, __LSET,
; __USING, ISSTRF, CONCAT, GETSTR and FN_INSTR.
TSTSTR:
  CALL GETYPR           ;SEE WHAT KIND OF VALUE WE HAVE
  RET Z                 ;WE HAVE A STRING, EVERYTHING IS OK
  JP TM_ERR             ;WE DON'T HAVE A STRING, FALL INTO TMERR


; Floating Point to Integer
; a.k.a. FPINT
;
	;QUICK GREATEST INTEGER FUNCTION
	;LEAVES INT(FAC) IN C,D,E (SIGNED)
	;ASSUMES FAC .LT. 2^23 = 8388608
	;ASSUMES THE EXPONENT OF FAC IS IN A
;
; Used by the routines at __CINT, INT and RNGTST.
QINT:
  LD B,A                ;ZERO B,C,D,E IN CASE THE NUMBER IS ZERO
  LD C,A
  LD D,A
  LD E,A
  OR A                  ;SET CONDITION CODES
  RET Z                 ;IT IS ZERO, WE ARE DONE

;THE HARD CASE IN QINT IS NEGATIVE NON-INTEGERS.  TO HANDLE THIS, IF THE
;NUMBER IS NEGATIVE, WE REGARD THE 3-BYTE MANTISSA AS A 3-BYTE INTEGER AND
;SUBTARCT ONE.  THEN ALL THE FRACTIONAL BITS ARE SHIFTED OUT BY SHIFTING THE
;MANTISSA RIGHT.  THEN, IF THE NUMBER WAS NEGATIVE, WE ADD ONE.  SO, IF WE
;HAD A NEGATIVE INTEGER, ALL THE BITS TO THE RIGHT OF THE BINARY POINT WERE
;ZERO.  SO THE NET EFFECT IS WE HAVE THE ORIGINAL NUMBER IN C,D,E.  IF THE
;NUMBER WAS A NEGATIVE NON-INTEGER, THERE IS AT LEAST ONE NON-ZERO BIT TO THE
;RIGHT OF THE BINARY POINT.  SO THE NET EFFECT IS THAT WE GET THE ABSOLUTE
;VALUE OF INT(FAC) IN C,D,E.  C,D,E IS THEN NEGATED IF THE ORIGINAL NUMBER WAS
;NEGATIVE SO THE RESULT WILL BE SIGNED.
  PUSH HL               ;SAVE (HL)
  CALL BCDEFP           ;GET NUMBER IN THE REGISTERS
  CALL UNPACK           ;UNPACK THE NUMBER
  XOR (HL)              ;GET SIGN OF NUMBER
  LD H,A                ;DON'T LOSE IT
  CALL M,DCBCDE         ;SUBTRACT 1 FROM LO IF NUMBER IS NEGATIVE
  LD A,$98              ;SEE HOW MANY WE HAVE TO SHIFT TO CHANGE
  SUB B                 ; NUMBER TO AN INTEGER
  CALL SCALE            ;SHIFT NUMBER TO GET RID OF FRACTIONAL BITS
  LD A,H                ;GET SIGN
  RLA                   ;PUT SIGN IN CARRY SO IT WILL NOT BE CHANGED
  CALL C,FPROND         ;IF NUMBER WAS NEGATIVE, ADD ONE
  LD B,$00              ;FORGET THE BITS WE SHIFTED OUT
  CALL C,COMPL          ;NEGATE NUMBER IF IT WAS NEGATIVE BECAUSE WE WANT A SIGNED MANTISSA
  POP HL                ;GET OLD (HL) BACK
  RET                   ;ALL DONE

; Decrement FP value in BCDE
;
; Used by the routine at QINT.
DCBCDE:
  DEC DE                 ;SUBTRACT ONE FROM C,D,E
  LD A,D                 ;WE HAVE TO SUBTRACT ONE FROM C IF
  AND E                  ; D AND E ARE BOTH ALL ONES
  INC A                  ;SEE IF BOTH WERE -1
  RET NZ                 ;THEY WERE NOT, WE ARE DONE

; This entry point is used by the routine at LISPRT.
DCXBRT:
  DEC BC                 ;THIS IS FOR BILL.  C WILL NEVER BE ZERO
  RET                    ; (THE MSB WILL ALWAYS BE ONE) SO "DCX	B"
                         ; AND "DCR	C" ARE FUNCTIONALLY EQUIVALENT



; 'FIX' BASIC function
	; THIS IS THE FIX (X) FUNCTION. IT RETURNS
	; FIX(X)=SGN(X)*INT(ABS(X))
; Double Precision to Integer conversion
; a.k.a. FIXER
__FIX:
  CALL GETYPR            ;GET VALTYPE OF ARG
  RET M                  ;INT, DONE
  CALL SIGN              ;GET SIGN
  JP P,__INT             ;IF POSITIVE, JUST CALL REGULAR INT CODE
  CALL NEG               ;NEGATE IT
  CALL __INT             ;GET THE INTEGER OF IT
  JP INVSGN              ;NOW RE-NEGATE IT


; 'INT' BASIC function
;
	;GREATEST INTEGER FUNCTION
	;ALTERS A,B,C,D,E,H,L
;
; a.k.a. VINT
; Used by the routine at __FIX.
__INT:
  CALL GETYPR            ;SEE WHAT TYPE OF A NUMBER WE HAVE
  RET M                  ;IT IS AN INTEGER, ALL DONE
  JR NC,DINT             ;CONVERT THE DOUBLE PRECISION NUMBER
  JP Z,TM_ERR            ;BLOW UP ON STRINGS
  CALL CONIS             ;TRY TO CONVERT THE NUMBER TO AN INTEGER
                         ;IF WE CAN'T, WE WILL RETURN HERE TO GIVE A
                         ; SINGLE PRECISION RESULT


; INT
; Used by the routines at __SQR, __EXP and __SIN.
INT:
  LD HL,FPEXP            ;GET EXPONENT
  LD A,(HL)
  CP $98                 ;SEE IF NUMBER HAS ANY FRACTIONAL BITS
  LD A,(FACCU)           ;THE ONLY GUY WHO NEEDS THIS DOESN'T CARE..
  RET NC                 ;..ABOUT THE SIGN
  LD A,(HL)              ;GET EXPONENT BACK
  CALL QINT              ;IT DOES, SHIFT THEM OUT
  LD (HL),$98            ;CHANGE EXPONENT SO IT WILL BE CORRECT
				;NOTE:QINT UNPACKED THE NUMBER!!!!
				; AFTER NORMALIZATION
  LD A,E                 ;GET LO
  PUSH AF                ;SAVE IT
  LD A,C                 ;NEGATE NUMBER IF IT IS NEGATIVE
  RLA                    ;PUT SIGN IN CARRY
  CALL CONPOS            ;REFLOAT NUMBER  (a.k.a. FADFLT)
  POP AF                 ;GET LO BACK
  RET                    ;ALL DONE



	;GREATEST INTEGER FUNCTION FOR DOUBLE PRECISION NUMBERS
	;ALTERS A,B,C,D,E,H,L
; This entry point is used by the routine at __INT.
DINT:
  LD HL,FPEXP            ;GET POINTER TO FAC
  LD A,(HL)              ;GET EXPONENT
  CP $90                 ;CAN WE CONVERT IT TO AN INTEGER?
  JR NZ,DINT2            ;CHECK FOR -32768
  LD C,A                 ;SAVE EXPONENT IN C
  DEC HL                 ;GET POINTER TO SIGN AND HO
  LD A,(HL)              ;GET SIGN AND HO
  XOR $80                ;CHECK IF IT IS 200
  LD B,$06               ;SET UP A COUNT TO CHECK IF THE REST OF
DINT1:
  DEC HL                 ; THE NUMBER IS ZERO, POINT TO NEXT BYTE
  OR (HL)                ;IF ANY BITS ARE NON-ZERO, A WILL BE NON-ZERO
  ;DEC B                  ;ARE WE DONE?
  DJNZ DINT1            ;NO, CHECK THE NEXT LOWER ORDER BYTE
  OR A                   ;IS A NOW ZERO?
  LD HL,$8000            ;GET -32768 JUST IN CASE
  JR NZ,DIN05
  CALL MAKINT            ;A IS ZERO SO WE HAVE -32768
  JP __CDBL              ;FORCE BACK TO DOUBLE

DIN05:
  LD A,C                 ;GET EXPONENT
DINT2:
  OR A                   ;CHECK FOR ZERO VALUE
  RET Z                  ;***FIX 5.11***^1 -- ALA LOW 0 IN DINT
  CP $B8                 ;ARE THERE ANY FRACTIONAL BITS?
  RET NC                 ;NO, THE NUMBER IS ALREADY AN INTEGER

; This entry point is used by the routine at RNGTST.
DINTFO:
  PUSH AF                ;ENTRY FROM FOUT, CARRY IS ZERO IF WE COME HERE FROM FOUT
  CALL BCDEFP            ;GET HO'S OF NUMBER IN REGISTERS FOR UNPACKING
  CALL UNPACK            ;UNPACK IT
  XOR (HL)               ;GET ITS SIGN BACK
  DEC HL                 ;SET THE EXPONENT TO NORMALIZE CORRECTLY
  LD (HL),$B8
  PUSH AF                ;SAVE THE SIGN
  DEC HL
  LD (HL),C              ;GET UNPACKED HIGH BYTE
  CALL M,DINTA           ;SUBTRACT 1 FROM LO IF NUMBER IS NEGATIVE
  LD A,(FACCU+2)         ;FETCH NEW HIGH MANTISSA BYTE
  LD C,A                 ;AND PUT IN C
  LD HL,FACCU+2          ;POINT TO THE HO OF THE FAC
  LD A,$B8               ;GET HOW MANY BITS WE HAVE TO SHIFT OUT
  SUB B
  CALL DSHFTR            ;SHIFT THEM OUT!!
  POP AF                 ;GET THE SIGN BACK
  CALL M,DROUNA          ;IF NUMBER WAS NEGATIVE, ADD ONE
  XOR A                  ;PUT A ZERO IN THE EXTRA LO BYTE SO WHEN
  LD (FACLOW-1),A        ; WE NORMALIZE, WE WILL SHIFT IN ZEROS
  POP AF                 ;IF WE WERE CALLED FROM FOUT, DON'T NORMALIZE,
  RET NC                 ; JUST RETURN
  JP DNORML              ;RE-FLOAT THE INTEGER

DINTA:
  LD HL,FACLOW           ;SUBTRACT ONE FROM FAC, GET POINTER TO LO
DINTA1:
  LD A,(HL)              ;GET A BYTE OF FAC
  DEC (HL)               ;SUBTRACT ONE FROM IT
  OR A                   ;CONTINUE ONLY IF THE BYTE USED TO BE ZERO
  INC HL                 ;INCREMENT POINTER TO NEXT BYTE
  JR Z,DINTA1            ;CONTINUE IF NECESSARY
  RET                    ;ALL DONE


; Multiply DE by BC
; a.k.a. UMULT
	;INTEGER MULTIPLY FOR MULTIPLY DIMENSIONED ARRAYS
	; (DE):=(BC)*(DE)
	;OVERFLOW CAUSES A BS ERROR
	;ALTERS A,B,C,D,E
;
; Used by the routines at BSNTERC and ZERARY.
MLDEBC:
  PUSH HL                                                    ;SAVE [H,L]
  LD HL,$0000            ; Clear partial product             ;ZERO PRODUCT REGISTERS
  LD A,B                 ; Test multiplier                   ;CHECK IF (BC) IS ZERO
  OR C                                                       ;IF SO, JUST RETURN, (HL) IS ALREADY ZERO
  JR Z,MLDEBC_2          ; Return zero if zero               ;THIS IS DONE FOR SPEED
  LD A,$10               ; 16 bits                           ;SET UP A COUNT
MLDEBC_0:
  ADD HL,HL              ; Shift P.P left                    ;ROTATE (HL) LEFT ONE
  JP C,BS_ERR            ; "Subscript error" if overflow     ;CHECK FOR OVERFLOW, IF SO,
  EX DE,HL                                                   ; BAD SUBSCRIPT (BS) ERROR
  ADD HL,HL              ; Shift multiplier left             ;ROTATE (DE) LEFT ONE
  EX DE,HL
  JR NC,MLDEBC_1         ; Bit was zero - No add             ;ADD IN (BC) IF HO WAS 1
  ADD HL,BC              ; Add multiplicand                  
  JP C,BS_ERR            ; "Subscript error" if overflow     ;CHECK FOR OVERFLOW
MLDEBC_1:
  DEC A                  ; Count bits                        ;SEE IF DONE
  JR NZ,MLDEBC_0
MLDEBC_2:
  EX DE,HL                                                   ;RETURN THE RESULT IN [D,E]
  POP HL                                                     ;GET BACK THE SAVED [H,L]
  RET



;
;	INTEGER ARITHMETIC CONVENTIONS
;
;INTEGER VARIABLES ARE 2 BYTE, SIGNED NUMBERS
;	THE LO BYTE COMES FIRST IN MEMORY
;
;CALLING CONVENTIONS:
;FOR ONE ARGUMENT FUNCTIONS:
;	THE ARGUMENT IS IN (HL), THE RESULT IS LEFT IN (HL)
;FOR TWO ARGUMENT OPERATIONS:
;	THE FIRST ARGUMENT IS IN (DE)
;	THE SECOND ARGUMENT IS IN (HL)
;	THE RESULT IS LEFT IN THE FAC AND IF NO OVERFLOW, (HL)
;IF OVERFLOW OCCURS, THE ARGUMENTS ARE CONVERTED TO SINGLE PRECISION
;WHEN INTEGERS ARE STORED IN THE FAC, THEY ARE STORED AT FACLO+0,1
;VALTYP(INTEGER)=2


; Integer SUB
	;INTEGER SUBTRTACTION	(HL):=(DE)-(HL)
	;ALTERS A,B,C,D,E,H,L
ISUB:
  LD A,H               ;EXTEND THE SIGN OF (HL) TO B
  RLA                  ;GET SIGN IN CARRY
  SBC A,A
  LD B,A
  CALL INEGHL          ;NEGATE (HL)
  LD A,C               ;GET A ZERO
  SBC A,B              ;NEGATE SIGN
  JR IADD_0            ;GO ADD THE NUMBERS


; Integer ADD
;
	;INTEGER ADDITION	(HL):=(DE)+(HL)
	;ALTERS A,B,C,D,E,H,L
;
; Used by the routine at __NEXT.
IADD:
  LD A,H               ;EXTEND THE SIGN OF (HL) TO B
  RLA                  ;GET SIGN IN CARRY
  SBC A,A

; This entry point is used by the routine at ISUB.
IADD_0:
  LD B,A               ;SAVE THE SIGN
  PUSH HL              ;SAVE THE SECOND ARGUMENT IN CASE OF OVERFLOW
  LD A,D               ;EXTEND THE SIGN OF (DE) TO A
  RLA                  ;GET SIGN IN CARRY
  SBC A,A
  ADD HL,DE            ;ADD THE TWO LO'S
  ADC A,B              ;ADD THE EXTRA HO
  RRCA                 ;IF THE LSB OF A IS DIFFERENT FROM THE MSB OF
  XOR H                ; H, THEN OVERFLOW OCCURED
  JP P,CONIS1          ;NO OVERFLOW, GET OLD (HL) OFF STACK AND WE ARE DONE, SAVE (HL) IN THE FAC ALSO
  PUSH BC              ;OVERFLOW -- SAVE EXTENDED SIGN OF (HL)
  EX DE,HL             ;GET (DE) IN (HL)
  CALL HL_CSNG         ;FLOAT IT
  POP AF               ;GET SIGN OF (HL) IN A
  POP HL               ;GET OLD (HL) BACK
  CALL PUSHF           ;PUT FIRST ARGUMENT ON STACK
  EX DE,HL             ;PUT SECOND ARGUMENT IN (DE) FOR FLOATR
  CALL INEGAD          ;FLOAT IT
  JP FADDT             ;ADD THE TWO NUMBERS USING SINGLE PRECISION


; Integer MULTIPLY
	;INTEGER MULTIPLICATION		(HL):=(DE)*(HL)
	;ALTERS A,B,C,D,E,H,L
IMULT:
  LD A,H               ;CHECK (HL) IF IS ZERO, IF SO
  OR L                 ; JUST RETURN.  THIS IS FOR SPEED.
  JP Z,MAKINT          ;UPDATE FACLO TO BE ZERO AND RETURN
  PUSH HL              ;SAVE SECOND ARGUMENT IN CASE OF OVERFLOW
  PUSH DE              ;SAVE FIRST ARGUMENT
  CALL IMULDV          ;FIX UP THE SIGNS
  PUSH BC              ;SAVE THE SIGN OF THE RESULT
  LD B,H               ;COPY SECOND ARGUMENT INTO (BC)
  LD C,L
  LD HL,$0000          ;ZERO (HL), THAT IS WHERE THE PRODUCT GOES
  LD A,16              ;SET UP A COUNT
IMULT_0:
  ADD HL,HL            ;ROTATE PRODUCT LEFT ONE
  JR C,IMULT5          ;CHECK FOR OVERLFOW
  EX DE,HL             ;ROTATE FIRST ARGUMENT LEFT ONE TO SEE IF
  ADD HL,HL            ; WE ADD IN (BC) OR NOT
  EX DE,HL
  JR NC,IMULT_1        ;DON'T ADD IN ANYTHING
  ADD HL,BC            ;ADD IN (BC)
  JR C,IMULT5          ;CHECK FOR OVERLFOW
IMULT_1:
  DEC A                ;ARE WE DONE?
  JR NZ,IMULT_0        ;NO, DO IT AGAIN
  POP BC               ;WE ARE DONE, GET SIGN OF RESULT
  POP DE               ;GET ORIGINAL FIRST ARGUMENT
; This entry point is used by the routine at IDIV2.
IMLDIV:
  LD A,H               ;ENTRY FROM IDIV, IS RESULT .GE. 32768?
  OR A
  JP M,IMULT_3         ;IT IS, CHECK FOR SPECIAL CASE OF -32768
  POP DE               ;RESULT IS OK, GET SECOND ARGUMENT OFF STACK
  LD A,B               ;GET THE SIGN OF RESULT IN A
  JR INEGA             ;NEGATE THE RESULT IF NECESSARY

IMULT_3:
  XOR $80              ;IS RESULT 32768?
  OR L                 ;NOTE: IF WE GET HERE FROM IDIV, THE RESULT
  JR Z,IMULT4          ; MUST BE 32768, IT CANNOT BE GREATER
  EX DE,HL             ;IT IS .GT. 32768, WE HAVE OVERFLOW
  DEFB $01             ; "LD BC,nn" OVER NEXT 2 BYTES

; Routine at 11168
;
; Used by the routine at IMULT.
IMULT5:
  POP BC               ;GET SIGN OF RESULT OFF STACK
  POP HL               ;GET THE ORIGINAL FIRST ARGUMENT

  CALL HL_CSNG         ;FLOAT IT
  POP HL               ;GET THE ORIGINAL SECOND ARGUMENT
  CALL PUSHF           ;SAVE FLOATED FIRST ARUMENT
  CALL HL_CSNG         ;FLOAT SECOND ARGUMENT


; Used by the routine at SUMSER.
FMULTT:
  POP BC
  POP DE                ;GET FIRST ARGUMENT OFF STACK, ENTRY FROM POLYX
  JP FMULT              ;MULTIPLY THE ARGUMENTS USING SINGLE PRECISION

; This entry point is used by the routine at IMULT.
IMULT4:
  LD A,B                ;IS RESULT +32768 OR -32768?
  OR A                  ;GET ITS SIGN
  POP BC                ;DISCARD ORIGINAL SECOND ARGUMENT
  JP M,MAKINT           ;THE RESULT SHOULD BE NEGATIVE, IT IS OK
  PUSH DE               ;IT IS POSITIVE, SAVE REMAINDER FOR MOD
  CALL HL_CSNG          ;FLOAT -32768
  POP DE                ;GET MOD'S REMAINDER BACK
  JP NEG                ;NEGATE -32768 TO GET 32768, WE ARE DONE


; Divide the signed integer in DE by the signed integer in HL.
;
	;INTEGER DIVISION	(HL):=(DE)/(HL)
	;REMAINDER IS IN (DE), QUOTIENT IN (HL)
	;ALTERS A,B,C,D,E,H,L
;
; This entry point is used by the routines at DANDOR and INEG.
INT_DIV:
  LD A,H                ;CHECK FOR DIVISION BY ZERO
  OR L
  JP Z,O_ERR            ;WE HAVE DIVISION BY ZERO!!
  CALL IMULDV           ;FIX UP THE SIGNS
  PUSH BC               ;SAVE THE SIGN OF THE RESULT
  EX DE,HL              ;GET DENOMINATOR IN (HL)
  CALL INEGHL           ;NEGATE IT
  LD B,H                ;SAVE NEGATED DENOMINATOR IN (BC)
  LD C,L
  LD HL,$0000           ;ZERO WHERE WE DO THE SUBTRACTION
  LD A,17               ;SET UP A COUNT
  PUSH AF               ;SAVE IT
  OR A                  ;CLEAR CARRY 
  JR IDIV3              ;GO DIVIDE

; This entry point is used by the routine at IDIV2.
DIVLP:
  PUSH AF               ;SAVE COUNT
  PUSH HL               ;SAVE (HL) I.E. CURRENT NUMERATOR
  ADD HL,BC             ;SUBTRACT DENOMINATOR
  JR NC,IDIV2           ;WE SUBTRACTED TOO MUCH, GET OLD (HL) BACK
  POP AF                ;THE SUBTRACTION WAS GOOD, DISCARD OLD (HL)
  SCF                   ;NEXT BIT IN QUOTIENT IS A ONE
  DEFB $3E              ; "LD A,n" OVER NEXT BYTE

; Routine at 11233
; Used by the routine at IMULT5.
IDIV2:
  POP HL                ;IGNORE THE SUBTRACTION, WE COULDN'T DO IT
; This entry point is used by the routine at IMULT5.
IDIV3:
  LD A,E                ;SHIFT IN THE NEXT QUOTIENT BIT           ; Double LSB of quotient (LSW)
  RLA
  LD E,A
  LD A,D                ;SHIFT THE HO                             ; Double MSB of quotient (LSW)
  RLA
  LD D,A
  LD A,L                ;SHIFT IN THE NEXT BIT OF THE NUMERATOR   ; Double LSB of quotient (MSW)
  RLA
  LD L,A
  LD A,H                ;DO THE HO; Double MSB of quotient (MSW)              
  RLA
  LD H,A                ;SAVE THE HO
  POP AF                ;GET COUNT BACK
  DEC A                 ;ARE WE DONE?
  JR NZ,DIVLP           ;NO, DIVIDE AGAIN
  EX DE,HL              ;GET QUOTIENT IN (HL), REMAINDER IN (DE)
  POP BC                ;GET SIGN OF RESULT
  PUSH DE               ;SAVE REMAINDER SO STACK WILL BE ALRIGHT
  JR IMLDIV             ;CHECK FOR SPECIAL CASE OF 32768


	;GET READY TO MULTIPLY OR DIVIDE
	;ALTERS A,B,C,D,E,H,L
;
; This entry point is used by the routines at IMULT and IMULT5.
IMULDV:
  LD A,H                ;GET SIGN OF RESULT
  XOR D
  LD B,A                ;SAVE IT IN B
  CALL INEGH            ;NEGATE SECOND ARGUMENT IF NECESARY
  EX DE,HL              ;PUT (DE) IN (HL), FALL IN AND NEGATE FIRST ARGUMENT IF NECESSARY


	;NEGATE H,L
	;ALTERS A,C,H,L
INEGH:
  LD A,H                ;GET SIGN OF (HL)
; This entry point is used by the routines at IMULT and INEG.
INEGA:
  OR A                  ;SET CONDITION CODES
  JP P,MAKINT           ;WE DON'T HAVE TO NEGATE, IT IS POSITIVE
                        ;SAVE THE RESULT IN THE FAC FOR WHEN
                        ; OPERATORS RETURN THROUGH HERE

; This entry point is used by the routines at ISUB, IMULT5 and INEG.
INEGHL:
  XOR A                 ;CLEAR A
  LD C,A                ;STORE A ZERO (WE USE THIS METHOD FOR ISUB)
  SUB L                 ;NEGATE LO
  LD L,A                ;SAVE IT
  LD A,C                ;GET A ZERO BACK
  SBC A,H               ;NEGATE HO
  LD H,A                ;SAVE IT
  JP MAKINT             ;ALL DONE, SAVE THE RESULT IN THE FAC
                        ; FOR WHEN OPERATORS RETURN THROUGH HERE


	;INTEGER NEGATION
	;ALTERS A,B,C,D,E,H,L
;
; Used by the routine at INVSGN.
INEG:
  LD HL,(FACCU)         ;GET THE INTEGER
  CALL INEGHL           ;NEGATE IT
  LD A,H                ;GET THE HIGH ORDER
  XOR $80               ;CHECK FOR SPECIAL CASE OF 32768
  OR L
  RET NZ                ;IT DID NOT OCCUR, EVERYTHING IS FINE

; This entry point is used by the routines at CHRGTB, __ERL and IMP.
INEG2:
  EX DE,HL              ;WE HAVE IT, FLOAT 32768
  CALL VALSNG           ;CHANGE VALTYP TO "SINGLE PRECISION"
  XOR A                 ;GET A ZERO FOR THE HIGH ORDER
; This entry point is used by the routine at IADD.
INEGAD:
  LD B,$98              ;ENTRY FROM IADD, SET EXPONENT
  JP FLOATR             ;GO FLOAT THE NUMBER


	;MOD OPERATOR
	;(HL):=(DE)-(DE)/(HL)*(HL),  (DE)=QUOTIENT
	;ALTERS A,B,C,D,E,H,L
;
; This entry point is used by the routines at __TAB and DANDOR.
IMOD:
  PUSH DE               ;SAVE (DE) FOR ITS SIGN
  CALL INT_DIV          ;DIVIDE AND GET THE REMAINDER
  XOR A                 ;TURNOFF THE CARRY AND TRANFER
  ADD A,D               ;THE REMAINDER*2 WHICH IS IN [D,E]
  RRA                   ;TO [H,L] DIVIDING BY TWO
  LD H,A
  LD A,E
  RRA
  LD L,A                ; ***WHG01*** FIX TO MOD OPERATOR
  CALL VALINT           ;SET VALTYP TO "INTEGER" IN CASE RESULT OF
  POP AF
  JR INEGA




;  DOUBLE PRECISION ARITHMETIC ROUTINES

;DOUBLE PRECISION NUMBERS ARE 8 BYTE QUANTITIES
;THE LAST 4 BYTES IN MEMORY ARE IN THE SAME FORMAT AS SINGLE PRECISION NUMBERS
;THE FIRST 4 BYTES ARE 32 MORE LOW ORDER BITS OF PRECISION
;THE LOWEST ORDER BYTE COMES FIRST IN MEMORY
;
;CALLING CONVENTIONS:
;FOR ONE ARGUMENT FUNCTIONS:
;	THE ARGUMENT IS IN THE FAC, THE RESULT IS LEFT IN THE FAC
;FOR TWO ARGUMENT OPERATIONS:
;	THE FIRST ARGUMENT IS IN THE FAC
;	THE SECOND ARGUMENT IS IN ARG-7,6,5,4,3,2,1,0  (NOTE: ARGLO=ARG-7)
;	THE RESULT IS LEFT IN THE FAC
;NOTE:	THIS ORDER IS REVERSED FROM INT AND SNG
;VALTYP(DOUBLE PRECISION)=10 OCTAL



;
	;DOUBLE PRECISION SUBTRACTION	FAC:=FAC-ARG
	;ALTERS ALL REGISTERS
;
; aka DSUB, Double precision SUB (formerly SUBCDE)
DSUB:
  LD HL,ARG-1        ;NEGATE THE SECOND ARGUMENT
  LD A,(HL)          ;GET THE HO AND SIGN
  XOR $80            ;COMPLEMNT THE SIGN
  LD (HL),A          ;PUT IT BACK
                     ;FALL INTO DADD


; aka DADD, Double precision ADD (formerly FPADD)
;
	;DOUBLE PRECISION ADDITION	FAC:=FAC+ARG
	;ALTERS ALL REGISTERS
;
; Used by the routines at __CINT, DDIV10, DDIV, MULTEN and RNGTST.
DADD:
  LD HL,ARG             ;GET  POINTER TO EXPONENT OF FIRST ARGUMENT
  LD A,(HL)             ;CHECK IF IT IS ZERO                          ; Get FP exponent
  OR A                                                                ; Is number zero?
  RET Z                 ;IT IS, RESULT IS ALREADY IN FAC              ; Yes - Nothing to add
  LD B,A                ;SAVE EXPONENT FOR UNPACKING
  DEC HL                ;POINT TO HO AND SIGN
  LD C,(HL)             ;GET HO AND SIGN FOR UNPACKING
  LD DE,FPEXP           ;GET POINTER TO EXPONENT OF SECOND ARGUMENT
  LD A,(DE)             ;GET EXPONENT                                 ; Get FPREG exponent
  OR A                  ;SEE IF IT IS ZERO                            ; Is this number zero?
  JP Z,VMOVFA           ;IT IS, MOVE ARG TO FAC AND WE ARE DONE       ; Yes - Move FP to FPREG
  SUB B                 ;SUBTRACT EXPONENTS TO GET SHIFT COUNT        ; FP number larger?
  JR NC,NOSWAP_DEC      ;PUT THE SMALLER NUMBER IN FAC                ; No - Don't swap them
  CPL                   ;NEGATE SHIFT COUNT                           ; Two's complement
  INC A
  PUSH AF               ;SAVE SHIFT COUNT
  LD C,$08              ;SWITCH FAC AND ARG, SET UP A COUNT
  INC HL                ;POINT TO ARG
  PUSH HL               ;SAVE POINTER TO ARG                          ; Put FP on stack

DADD_SWAP:
  LD A,(DE)             ;GET A BYTE OF THE FAC
  LD B,(HL)             ;GET A BYTE OF ARG
  LD (HL),A             ;PUT THE FAC BYTE IN ARG
  LD A,B                ;PUT THE ARG BYTE IN A
  LD (DE),A             ;PUT THE ARG BYTE IN FAC
  DEC DE                ;POINT TO THE NEXT LO BYTE OF FAC
  DEC HL                ;POINT TO THE NEXT LO BYTE OF ARG
  DEC C                 ;ARE WE DONE?
  JR NZ,DADD_SWAP       ;NO, DO THE NEXT LO BYTE
  POP HL                ;GET THE HO BACK
  LD B,(HL)             ;GET THE EXPONENT
  DEC HL                ;POINT TO THE HO AND SIGN
  LD C,(HL)             ;GET HO AND SIGN FOR UNPACKING
  POP AF                ;GET THE SHIFT COUNT BACK
NOSWAP_DEC:
  
	;WE NOW HAVE THE SUSPECTED LARGER NO IN THE FAC, WE NEED
	;TO KNOW IF WE ARE TO SUBTRACT (SIGNS ARE DIFFERENT) AND
	;WE NEED TO RESTORE THE HIDDEN MANTISSA BIT
	;FURTHER, IF THERE IS TO BE MORE THAN 56 BITS SHIFTED
	;TO ALIGN THE BINARY POINTS THEN THE LESSOR NO. IS
	;INSIGNIFICANT IN COMPARISON TO THE LARGER NO. SO WE
	;CAN JUST RETURN AND CALL THE LARGER NO. THE ANSWER.
				
  CP 57                 ;ARE WE WITHIN 56 BITS?             ; Second number insignificant?    ; (GWBASIC) THIS MUST SET CF TO CONTINUE
  RET NC                ;NO, ALL DONE                       ; Yes - First number is result    ;RETURN IF CF=0
  PUSH AF               ;SAVE SHIFT COUNT                   ; Save number of bits to scale    ;SAVE MANTISSA BITS
  CALL UNPACK           ;UNPACK THE NUMBERS                 ; Set MSBs & sign of result
  LD HL,FPARG-1         ;POINT TO ARGLO-1
  LD B,A                ;SAVE SUBTRACTION FLAG              ; Save sign of result
  LD A,$00              ;
  LD (HL),A             ;CLEAR TEMPORARY LEAST SIG BYTE
  LD (FACLOW-1),A       ;CLEAR EXTRA BYTE
  POP AF                ;GET SHIFT COUNT                    ; Restore scaling factor
  LD HL,ARG-1           ;POINT TO THE HO OF ARG             ; Point to FPREG
  CALL DSHFTR           ;SHIFT ARG RIGHT THE RIGHT NUMBER OF TIMES    ; Scale to same exponent   ;"SHRA" in GWBASIC
  LD A,B                ;TRANSFER OVERFLOW BYTE             ; Restore sign of result
  OR A                  ;FROM ARG TO FAC                    ; Result to be positive?
  JP P,DADD3                                                ; No - Subtract FPREG from CDE
  LD A,(FPARG-1)        ;GET SUBTRACTION FLAG
  LD (FACLOW-1),A       ;SUBTRACT NUMBERS IF THEIR SIGNS ARE DIFFERENT
  CALL PLUCDE_DEC       ;SIGNS ARE THE SAME, ADD THE NUMBERS          ; Add FPREG to CDE
  JR NC,DECROU          ;ROUND THE RESULT IF NO CARRY       ; No overflow - Round it up
  EX DE,HL              ;GET POINTER TO FAC IN (HL)         ; Point to exponent
  INC (HL)              ;ADD 1 TO EXPONENT                  ; Increment it
  JP Z,OVERR_1                                              ; Number overflowed - Error

;**************************************************************
; WE ARE NOW SET TO SHIFT THE FAC RIGHT 1 BIT. RECALL WE GOT HERE WITH CF=1. 
; THE INSTRUCTIONS SINCE WE GOT HERE HAVEN'T AFFECTED
; CF SO WHEN WE SHIFT RIGHT WE WILL SHIFT CF INTO THE HIGH MANTISSA BIT.
;*************************************************************

  CALL DSHFRB           ;SHIFT NUMBER RIGHT ONE, SHIFT IN CARRY    ; Shift result right
  JR DECROU             ;ROUND THE RESULT                   ; Round it up

;**************************************************************
;TO GET HERE THE SIGNS OF THE FAC AND ARG WERE DIFFERENT THUS
;IMPLYING A DESIRED SUBTRACT.
;**************************************************************

DADD3:
  LD A,$9E				; "SBC A,(HL)", SUBTRACT THE NUMBERS
  CALL DSUB_SMC_0     ;GET THE SUBTRACT INSTRUCTION IN A
  LD HL,SGNRES          ; Sign of result    		;SUBTRACT THE NUMBERS
  CALL C,NEGR                                       ;FIX [H,L] TO POINT TO SIGN FOR DNEGR
                                                    ;NEGATE THE RESULT IF IT WAS NEGATIVE
                                                    ;FALL INTO DNORML

; a.k.a. PNORM  (or NORMD on GW-BASIC)
	;NORMALIZE FAC
	;ALTERS A,B,C,D,H,L
; This entry point is used by the routines at INT and DMUL.
DNORML:
  XOR A                 ;CLEAR SHIFT COUNT
DNORM1:             
  LD B,A                ;SAVE SHIFT COUNT
  LD A,(FACCU+2)        ;GET HO
  OR A                  ;SEE IF WE CAN SHIFT 8 LEFT
  JR NZ,DNORM5          ;WE CAN'T, SEE IF NUMBER IS NORMALIZED
  LD HL,FACLOW-1        ;WE CAN, GET POINTER TO LO
  LD C,$08              ;SET UP A COUNT
DNORM2:
  LD D,(HL)             ;GET A BYTE OF FAC
  LD (HL),A             ;PUT IN BYTE FROM LAST LOCATION, THE FIRST TIME THROUGH A IS ZERO
  LD A,D                ;PUT THE CURRENT BYTE IN A FOR NEXT TIME
  INC HL                ;INCREMENT POINTER TO NEXT HIGHER ORDER
  DEC C                 ;ARE WE DONE?
  JR NZ,DNORM2          ;NO, DO THE NEXT BYTE

  LD A,B                ;SUBTRACT 8 FROM SHIFT COUNT
  SUB $08
  CP $C0                ;HAVE WE SHIFTED ALL BYTES TO ZERO?
  JR NZ,DNORM1          ;NO, TRY TO SHIFT 8 MORE
  JP ZERO               ;YES, THE NUMBER IS ZERO

DNORM3:
  DEC B                 ;DECREMENT SHIFT COUNT
  LD HL,FACLOW-1        ;GET POINTER TO LO
  CALL DSHFLC           ;SHIFT THE FAC LEFT
  OR A                  ;SEE IF NUMBER IS NORMALIZED
DNORM5:
  JP P,DNORM3           ;SHIFT FAC LEFT ONE IF IT IS NOT NORMALIZED
  LD A,B                ;GET THE SHIFT COUNT
  OR A                  ;SEE IF NO SHIFTING WAS DONE
  JR Z,DECROU           ;NONE WAS, PROCEED TO ROUND THE NUMBER
  LD HL,FPEXP           ;GET POINTER TO EXPONENT
  ADD A,(HL)            ;UPDATE IT
  LD (HL),A             ;SAVE UPDATED EXPONENT
  JP NC,ZERO            ;UNDERFLOW, THE RESULT IS ZERO
  RET Z                 ;RESULT IS ALREADY ZERO, WE ARE DONE
                        ;FALL INTO DROUND AND ROUND THE RESULT


	;ROUND FAC
	;ALTERS A,B,H,L
; a.k.a. DROUND
DECROU:
  LD A,(FACLOW-1)       ;GET EXTRA BYTE TO SEE IF WE HAVE TO ROUND
; This entry point is used by the routine at DDIV.
DECROU_0:
  OR A                  ;ENTRY FROM DDIV
  CALL M,DROUNA         ;ROUND UP IF NECESSARY
  LD HL,SGNRES          ;GET POINTER TO UNPACKED SIGN
  LD A,(HL)             ;GET SIGN
  AND $80               ;ISOLATE SIGN BIT
  DEC HL                ;POINT TO HO
  DEC HL
  XOR (HL)              ;PACK SIGN AND HO
  LD (HL),A             ;PUT PACKED SIGN AND HO IN FAC
  RET                   ;WE ARE DONE

	;SUBROUTINE FOR ROUND: ADD ONE TO FAC
; This entry point is used by the routine at INT.
DROUNA:
  LD HL,FACLOW          ;GET POINTER TO LO, ENTRY FROM DINT
  LD B,$07              ;SET UP A COUNT
DROUNA_LP:              ;INCREMENT A BYTE                           ; (GWBASIC)
  INC (HL)              ;RETURN IF THERE WAS NO CARRY               ;IF THIS GETS ZF=1 THEN CARRY
  RET NZ                ;INCREMENT POINTER TO NEXT HIGHER ORDER
  INC HL                ;HAVE WE INCREMENTED ALL BYTES
  ;DEC B
  DJNZ DROUNA_LP        ;NO, TRY THE NEXT ONE
  INC (HL)              ;YES, INCREMENT THE EXPONENT                ;MUST INCREMENT EXPONENT
  JP Z,OVERR_1          ;THE NUMBER OVERFLOWED ITS EXPONENT
  DEC HL
  LD (HL),$80           ;PUT 200 IN HO                              ;SET HIGH BYTE TO 200
  RET                   ;ALL DONE



		;ADD OR SUBTRACT 2 DBL QUANTITIES
		;ALTERS A,C,D,E,H,L
; This entry point is used by the routine at DDIV.
DADDD:
  LD DE,FBUFFR+27       ;ENTRY FROM DDIV
  LD HL,FPARG
  JR DADDD_1

; This entry point is used by the routine at DMUL.
PLUCDE_DEC:
  LD A,$8E              ; ADC A,(HL)
DSUB_SMC_0:
  LD HL,FPARG           ;GET POINTER TO ARG, ENTRY FROM DADD

; This entry point is used by the routine at RNGTST.
DADDFO:
  LD DE,FACLOW          ;GET POINTER TO FAC, ENTRY FROM FOUT
DADDD_1:
  LD C,$07              ;SET UP A COUNT
  LD (DADDD_BYTE),A     ;STORE THE ADD OR SUBTRACT INSTRUCTION
  XOR A                 ;CLEAR CARRY
DADDD_2:
  LD A,(DE)             ;GET A BYTE FROM RESULT NUMBER
DADDD_BYTE:
  ADC A,(HL)		; <-- SMC instruction, THIS IS EITHER "ADC" OR "SBC"
  LD (DE),A             ;SAVE THE CHANGED BYTE
  INC DE                ;INCREMENT POINTERS TO NEXT HIGHER ORDER BYTE
  INC HL
  DEC C                 ;ARE WE DONE?
  JR NZ,DADDD_2         ;NO, DO THE NEXT HIGHER ORDER BYTE
  RET                   ;ALL DONE
  

; Complement sign
	;NEGATE SIGNED NUMBER IN FAC
	;THIS IS USED BY DADD, DINT
	;ALTERS A,B,C,H,L
NEGR:
  LD A,(HL)              ;COMPLEMENT SIGN OF FAC
  CPL                    ;USE THE UNPACKED SIGN BYTE
  LD (HL),A              ;SAVE THE NEW SIGN
  LD HL,FACLOW-1         ;GET POINTER TO LO
  LD B,$08               ;SET UP A COUNT
  XOR A                  ;CLEAR CARRY AND GET A ZERO
  LD C,A                 ;SAVE ZERO IN C
NEGR_0:
  LD A,C                 ;GET A ZERO
  SBC A,(HL)             ;NEGATE THE BYTE OF FAC
  LD (HL),A              ;UPDATE FAC
  INC HL                 ;INCREMENT POINTER TO NEXT HIGHER ORDER BYTE
  ;DEC B                 ;ARE WE DONE?
  DJNZ NEGR_0            ;NO, NEGATE THE NEXT BYTE
  RET                    ;ALL DONE


; a.k.a. SCALE
	;SHIFT DBL FAC RIGHT ONE
	;A = SHIFT COUNT
	;ALTERS A,C,D,E,H,L
; This entry point is used by the routine at INT.
DSHFTR:
  LD (HL),C              ;PUT THE UNPACKED HO BACK
  PUSH HL                ;SAVE POINTER TO WHAT TO SHIFT
DSHFTR_0:
  SUB $08                ;SEE IF WE CAN SHIFT 8 RIGHT        ; 8 bits (a whole byte)?
  JR C,DSHFTR_3          ;WE CAN'T, CHECK IF WE ARE DONE     ; No - Shift right A bits
  POP HL                 ;GET POINTER BACK
; This entry point is used by the routine at DMUL.
DSHFTR_1:
  PUSH HL                ;ENTRY FROM DMULT, SAVE POINTER TO HO
  LD DE,$0800            ;SHIFT A ZERO INTO THE HO, SET UP A COUNT     ; D=8 bits to shift
DSHFTR_2:
  LD C,(HL)              ;SAVE A BYTE OF FAC
  LD (HL),E              ;PUT THE LAST BYTE IN ITS PLACE
  LD E,C                 ;SET UP E FOR NEXT TIME THROUGH THE LOOP
  DEC HL                 ;POINT TO NEXT LOWER ORDER BYTE
  DEC D                  ;ARE WE DONE?
  JR NZ,DSHFTR_2         ;NO, DO THE NEXT BYTE
  JR DSHFTR_0            ;YES, SEE IF WE CAN SHIFT OVER 8 MORE

DSHFTR_3:
  ADD A,8+1              ;CORRECT SHIFT COUNT        ; Adjust count
  LD D,A                 ;SAVE SHIFT COUNT IN D
DSHFTR_4:
  XOR A                  ;CLEAR CARRY                                  ; Flag for all done
  POP HL                 ;GET POINTER TO HO
  DEC D                  ;ARE WE DONE?                                 ; All shifting done?
  RET Z                  ;YES                                          ; Yes - Return
DSHFTRA:
  PUSH HL                ;NO, SAVE POINTER TO LO, ENTRY FROM DADD, DMULT
  LD E,$08               ;SET UP A COUNT, ROTATE FAC ONE LEFT          ; Count 8 bits
DSHFTR_5:
  LD A,(HL)              ;GET A BYTE OF THE FAC
  RRA                    ;ROTATE IT LEFT
  LD (HL),A              ;PUT THE UPDATED BYTE BACK
  DEC HL                 ;DECREMENT POINTER TO NEXT LOWER ORDER BYTE
  DEC E                  ;ARE WE DONE?
  JR NZ,DSHFTR_5         ;NO, ROTATE THE NEXT LOWER ORDER BYTE
  JR DSHFTR_4            ;YES, SEE IF WE ARE DONE SHIFTING


	;ENTRY TO DSHFTR FROM DADD, DMULT
; This entry point is used by the routine at DMUL.
DSHFRB:
  LD HL,FACCU+2          ;GET POINTER TO HO OF FAC
  LD D,$01               ;SHIFT RIGHT ONCE
  JR DSHFTRA             ;GO DO IT


	;ROTATE FAC LEFT ONE
	;ALTERS A,C,H,L
; This entry point is used by the routine at DDIV.
DSHFLC:
  LD C,$08               ;SET UP A COUNT
; This entry point is used by the routine at DDIV.
DSHFTL:                  
  LD A,(HL)
  RLA                    ;ROTATE IT LEFT ONE
  LD (HL),A              ;UPDATE BYTE IN FAC
  INC HL                 ;INCREMENT POINTER TO NEXT HIGHER ORDER BYTE
  DEC C                  ;ARE WE DONE?
  JR NZ,DSHFTL
  RET                    ;ALL DONE



; a.k.a. DMULT
;
	;DOUBLE PRECISION MULTIPLICATION	FAC:=FAC*ARG
	;ALTERS ALL REGISTERS
;
; Used by the routines at DDIV10 and FOUBE3.
DMUL:
  CALL SIGN              ;CHECK IF WE ARE MULTIPLYING BY ZERO
  RET Z                  ;YES, ALL DONE, THE FAC IS ZERO
  LD A,(ARG)             ;MUST SEE IF ARG IS ZERO
  OR A
  JP Z,ZERO              ;RETURN ZERO

  CALL MULDVA            ;ADD EXPONENTS AND TAKE CARE OF SIGNS
  CALL DMULDV            ;ZERO FAC AND PUT FAC IN FBUFFR
  LD (HL),C              ;PUT UNPACKED HO IN ARG
  INC DE                 ;GET POINTER TO LO OF ARG
  LD B,$07               ;SET UP A COUNT
DMUL_0:
  LD A,(DE)              ;GET THE BYTE OF ARG TO MULTIPLY BY
  INC DE                 ;INCREMENT POINTER TO NEXT HIGHER BYTE
  OR A                   ;CHECK IF WE ARE MULTIPLYING BY ZERO
  PUSH DE                ;SAVE POINTER TO ARG
  JR Z,DMUL_3            ;WE ARE
  LD C,$08               ;SET UP A COUNT
DMUL_1:
  PUSH BC                ;SAVE COUNTERS
  RRA                    ;ROTATE MULTIPLIER RIGHT
  LD B,A                 ;SAVE IT
  CALL C,PLUCDE_DEC      ;ADD IN OLD FAC IF BIT OF MULTIPIER WAS ONE
  CALL DSHFRB            ;ROTATE PRODUCT RIGHT ONE
  LD A,B                 ;GET MULTIPLIER IN A
  POP BC                 ;GET COUNTERS BACK
  DEC C                  ;ARE WE DONE WITH THIS BYTE OF ARG?
  JR NZ,DMUL_1           ;NO, MULTIPLY BY THE NEXT BIT OF THE MULTIPLIER
DMUL_2:
  POP DE                 ;YES, GET POINTER INTO ARG BACK
  ;DEC B                  ;ARE WE DONE?
  DJNZ DMUL_0           ;NO, MULTIPLY BY NEXT HIGHER ORDER BY OF ARG
                         ;POINT IS TO RIGHT OF UNDERSTOOD ONE

  JP DNORML              ;ALL DONE, NORMALIZE AND ROUND RESULT

DMUL_3:
  LD HL,FACCU+2          ;GET POINTER TO HO OF FAC
  CALL DSHFTR_1          ;SHIFT PRODUCT RIGHT ONE BYTE, WE ARE
  JR DMUL_2              ; MULTIPLYIING BY ZERO



;CONSTANT FOR DIV10, DDIV10
TENTH:
  DEFB $CD,$CC,$CC,$CC,$CC,$CC,$4C,$7D
DBL_TEN:
  DEFB $00,$00,$00,$00
FP_TEN:
  DEFB $00,$00,$20,$84    ; Float const: 10


;
	;DOUBLE PRECISION DIVIDE FAC BY 10
	;ALTERS ALL REGISTERS
	;
	;(FAC)=(FAC)*3/4*16/15*1/8
;
; Routine at 11721
; Used by the routine at MULTEN.
DDIV10:
  LD A,(FPEXP)           ;MUST ASSURE OURSELVES WE CAN DO
  CP $41                 ;65 EXPONENT DECREMENTS W/O   ($41 = 65)
  JR NC,DDIV10_0         ;REACHING ZERO
  LD DE,TENTH            ;POINT TO .1D0
  LD HL,FPARG            ;POINT TO ARG
  CALL VMOVE
  JR DMUL

DDIV10_0:
  LD A,(FACCU+2)         ;NEGATIVE NO?
  OR A
  JP P,DDIV10_1
  AND $7F                ;WANT ONLY POS. NOS.
  LD (FACCU+2),A
  LD HL,NEG
  PUSH HL                ;WILL NEGATE WHEN FINISHED
DDIV10_1:
  CALL DECF1             ;DIVIDE FAC BY 2
  LD DE,FACLOW
  LD HL,FPARG
  CALL VMOVE
  CALL DECF1             ;DIVIDE FAC BY 2
  CALL DADD              ;(FAC)=(FAC)+(ARG)
  LD DE,FACLOW
  LD HL,FPARG
  CALL VMOVE             ;(ARG)=(FAC)
  LD A,$0F
DDIV10_2:
  PUSH AF                ;SAVE LOOP COUNTER
  CALL DECA4             ;(ARG)=(ARG)/16
  CALL PSARG             ;PUSH ARG ON THE STACK
  CALL DADD              ;(FAC)=(FAC)+(ARG)
  LD HL,ARG-1
  CALL PPARG             ;POP ARG OFF THE STACK
  POP AF                 ;FETCH LOOP COUNTER
  DEC A
  JR NZ,DDIV10_2
  CALL DECF1
  CALL DECF1


	;(FAC)=(FAC)/2
DECF1:
  LD HL,FPEXP
  DEC (HL)               ;(FAC)=(FAC)/2
  RET NZ              
  JP ZERO                ;UNDERFLOW


	;(ARG)=(ARG)/16
DECA4:
  LD HL,ARG
  LD A,$04
DECA4_0:
  DEC (HL)
  RET Z
  DEC A
  JR NZ,DECA4_0
  RET


	;PUSH DOUBLE PRECISION ARG ON THE STACK
PSARG:
  POP DE                 ;GET OUR RETURN ADDRESS OFF THE STACK
  LD A,$04
  LD HL,FPARG
PSARG_0:
  LD C,(HL)              ;FETCH BYTE
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  DEC A                  ;THROUGH?
  JR NZ,PSARG_0
  PUSH DE
  RET


	;POP ARG OFF THE STACK
PPARG:
  POP DE                 ;GET OUR RETURN ADDRESS OFF THE STACK
  LD A,$04
  LD HL,ARG
PPARG_0:
  POP BC
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC HL
  DEC A
  JR NZ,PPARG_0
  PUSH DE
  RET



; Double precision DIVIDE
;
	;DOUBLE PRECISION DIVISION	FAC:=FAC/ARG
	;ALTERS ALL REGISTERS
;
DDIV:
  LD A,(ARG)            ;CHECK FOR DIVISION BY ZERO
  OR A                  ;GET THE EXPONENT OF ARG
  JP Z,DDIV_SUB
  LD A,(FPEXP)          ;IF FAC=0 THEN ANS IS ZERO
  OR A
  JP Z,ZERO             
  CALL MULDVS           ;SUBTRACT EXPONENTS AND CHECK SIGNS
  INC (HL)              ;MULDIV DIFFERENT FOR TRUANS=0
  INC (HL)              ;MUST CORRECT FOR INCORRECT EXP CALC
  JP Z,OVERR_1
  CALL DMULDV           ;ZERO FAC AND PUT FAC IN FBUFFR
  LD HL,FBUFFR+34		;GET POINTER TO THE EXTRA HO BYTE WE WILL USE; last byte in FBUFFR
  LD (HL),C             ;ZERO IT
  LD B,C                ;ZERO FLAG TO SEE WHEN WE START DIVIDING
DDIV_0:
  LD A,$9E				; SBC A,(HL)  ->   SUBTRACT ARG FROM FBUFFR
  CALL DADDD            ;DO THE SUBTRACTION
  LD A,(DE)             ;SUBTRACT FROM EXTRA HO BYTE
  SBC A,C               ;HERE C=0
  CCF                   ;CARRY=1 IF SUBTRACTION WAS GOOD
  JR C,DDIV_1           ;WAS IT OK?
  LD A,$8E              ; ADC A,(HL)  ->    NO, ADD FBUFFR BACK IN
  CALL DADDD            ;DO THE ADDITION
  XOR A                 ;CLEAR CARRY
  DEFB $DA              ; "JP C,n"  OVER NEXT TWO BYTES
DDIV_1:
  LD (DE),A             ;STORE THE NEW HIGHEST ORDER BYTE
  INC B                 ;INCREMENT FLAG TO SHOW WE COULD DIVIDE
  LD A,(FACCU+2)        ;CHECK IF WE ARE DONE DIVIDING
  INC A                 ;SET SIGN FLAG WITHOUT AFFECTING CARRY
  DEC A
  RRA                   ;PUT CARRY IN MSB FOR DROUND
  JP M,DECROU_0         ;WE ARE DONE, WE HAVE 57 BITS OF ACCURACY
  RLA                   ;GET OLD CARRY BACK WHERE IT BELONGS
  LD HL,FACLOW          ;GET POINTER TO LO OF FAC
  LD C,$07              ;SET UP A COUNT, SHIFT FAC LEFT ONE
  CALL DSHFTL           ;SHIFT IN THE NEXT BIT IN THE QUOTIENT
  LD HL,FBUFFR+27       ;GET POINTER TO LO IN FBUFFR
  CALL DSHFLC           ;SHIFT DIVIDEND ONE LEFT
  LD A,B                ;IS THIS THE FIRST TIME AND WAS THE
  OR A                  ; SUBTRACTION NOT GOOD? (B WILL GET
  JR NZ,DDIV_0          ; CHANGED ON THE FIRST OR SECOND SUBTRACTION)
  LD HL,FPEXP           ;YES, SUBTRACT ONE FROM EXPONENT TO CORRECT
  DEC (HL)              ; SCALING
  JR NZ,DDIV_0          ;CONTINUE DIVIDING IF NO UNDERFLOW
  JP ZERO               ;UNDERFLOW


	;TRANSFER FAC TO FBUFFR FOR DMULT AND DDIV
	;ALTERS A,B,C,D,E,H,L
; This entry point is used by the routine at DMUL.
DMULDV:
  LD A,C                ;PUT UNPACKED HO BACK IN ARG
  LD (ARG-1),A
  DEC HL                ;POINT TO HO OF FAC
  LD DE,FBUFFR+33       ;POINT TO END OF FBUFFR
  LD BC,$0700           ;SET UP A COUNT TO FBUFFR:  B=7, set C to 0
DMULDV_0:
  LD A,(HL)             ;GET A BYTE FROM FAC
  LD (DE),A             ;PUT IT IN FBUFFR
  LD (HL),C             ;PUT A ZERO IN FAC
  DEC DE                ;POINT TO NEXT BYTE IN FBUFFR
  DEC HL                ;POINT TO NEXT LOWER ORDER BYTE IN FAC
  ;DEC B                 ;ARE WE DONE?
  DJNZ DMULDV_0        ;NO, TRANSFER THE NEXT BYTE
  RET                   ;ALL DONE


; a.k.a. MLSP10
	;DOUBLE PRECISION MULTIPLY THE FAC BY 10
	;ALTERS ALL REGISTERS
; This entry point is used by the routine at MULTEN.
DMUL10:
  CALL VMOVAF           ;SAVE THE FAC IN ARG, VMOVAF EXITS WITH (DE)=FAC+1
  EX DE,HL              ;GET THE POINTER INTO THE FAC IN (HL)
  DEC HL                ;POINT TO THE EXPONENT
  LD A,(HL)             ;GET THE EXPONENT                                  ; Get exponent
  OR A                  ;IS THE NUMBER ZERO?                               ; Is it zero?
  RET Z                 ;YES, ALL DONE                                     ; Yes - Result is zero
  ADD A,$02             ;MULTIPLY FAC BY 4 BY ADDING 2 TO THE EXPONENT     ; Multiply by 4
  JP C,OVERR_1                                                             ; Overflow - ?OV Error
  LD (HL),A             ;SAVE THE NEW EXPONENT
  PUSH HL               ;SAVE POINTER TO FAC
  CALL DADD             ;ADD IN THE ORIGINAL FAC TO GET 5 TIMES  FAC
  POP HL                ;GET THE POINTER TO FAC BACK
  INC (HL)              ;ADD ONE TO EXPONENT TO GET 10 TIMES FAC
  RET NZ                ;ALL DONE IF OVERFLOW DID NOT OCCUR
  JP OVERR_1



; Also known as "FIN", convert text to number
;	FLOATING POINT INPUT ROUTINE
;
	;ALTERS ALL REGISTERS
	;THE NUMBER IS LEFT IN FAC
	;AT ENTRY, (HL) POINTS TO THE FIRST CHARACTER IN A TEXT BUFFER.
	;THE FIRST CHARACTER IS ALSO IN A.  WE PACK THE DIGITS INTO THE FAC
	;AS AN INTEGER AND KEEP TRACK OF WHERE THE DECIMAL POINT IS.
	;C IS $FF IF WE HAVE NOT SEEN A DECIMAL POINT, 0 IF WE HAVE.
	;B IS THE NUMBER OF DIGITS AFTER THE DECIMAL POINT.
	;AT THE END, B AND THE EXPONENT (IN E) ARE USED TO DETERMINE HOW MANY
	;TIMES WE MULTIPLY OR DIVIDE BY TEN TO GET THE CORRECT NUMBER.
	;
; Used by the routines at DOASIG, LINE_INPUT and __VAL.
FIN_DBL:
  CALL ZERO             ;ZERO THE FAC
  CALL VALDBL           ;FORCE TO DOUBLE PRECISION
  DEFB $F6              ; "OR n" to Mask 'XOR A'  -  SO FRCINT IS NOT CALLED

; Also known as "FIN", convert text to number
;
; Used by the routines at TSTNUM, DOASIG, OPRND, __RANDOMIZE and
; LINE_INPUT.
FIN:
  XOR A                 ;FORCE CALL TO FRCINT
  LD BC,FINOVC
  PUSH BC               ;WHEN DONE STORE OVERFLOW FLAG
  PUSH AF               ;INTO STROVC AND GO TO NORMAL OVERFLOW MODE
  LD A,$01              ;SET UP ONCE ONLY OVERFLOW MODE
  LD (FLGOVC),A
  POP AF
  EX DE,HL              ;SAVE THE TEXT POINTER IN (DE)
  LD BC,$00FF           ;CLEAR FLAGS:  B=DECIMAL PLACE COUNT,  C="." FLAG
  LD H,B                ;ZERO (HL)
  LD L,B
  CALL Z,MAKINT         ;ZERO FAC, SET VALTYP TO "INTEGER"
  EX DE,HL              ;GET THE TEXT POINTER BACK IN (HL) AND ZEROS IN (DE)
  LD A,(HL)             ;RESTORE CHAR FROM MEMORY

; ASCII to FP number (also '&' prefixes)
H_ASCTFP:
  CP '&'
  JP Z,OCTCNS

; ASCII to FP number
_ASCTFP:                                                    ;IF WE ARE CALLED BY VAL OR INPUT OR READ, THE SIGNS MAY NOT BE CRUNCHED
  CP '-'                  ; '-': Negative?                  ;SEE IF NUMBER IS NEGATIVE
  PUSH AF                 ; Save it and flags               ;SAVE SIGN
  JR Z,_ASCTFP_0          ; Yes - Convert number            ;IGNORE MINUS SIGN
  CP '+'                  ; Positive?                       ;IGNORE A LEADING SIGN
  JR Z,_ASCTFP_0          ; Yes - Convert number
  DEC HL                  ; DEC 'cos GETCHR INCs            ;SET CHARACTER POINTER BACK ONE

; This entry point is used by the routine at MULTEN.
_ASCTFP_0:                                                  ;HERE TO CHECK FOR A DIGIT, A DECIMAL POINT, "E" OR "D"
  CALL CHRGTB             ; Set result to zero              ;GET THE NEXT CHARACTER OF THE NUMBER
  JP C,ADDIG              ; Digit - Add to number           ;WE HAVE A DIGIT
  CP '.'                                                    ;CHECK FOR A DECIMAL POINT
  JP Z,DPOINT             ; "." - Flag point                ;WE HAVE ONE, I GUESS
  CP 'e'                                                    ;LOWER CASE "E"
  JR Z,EXPONENTIAL
  CP 'E'                  ;CHECK FOR A SINGLE PRECISION EXPONENT
EXPONENTIAL:
  JR NZ,NOTE              ;NO
  PUSH HL                 ;SAVE TEXT PTR
  CALL CHRGTB             ;GET NEXT CHAR
  CP 'l'                  ;SEE IF LOWER CASE "L"
  JR Z,_ASCTFP_1          ;IF SO POSSIBLE ELSE
  CP 'L'                  ;IS THIS REALLY AN "ELSE"?
  JR Z,_ASCTFP_1          ;WAS ELSE
  CP 'q'                  ;SEE IF LOWER CASE "Q"
  JR Z,_ASCTFP_1          ;IF SO POSSIBLE "EQV"
  CP 'Q'                  ;POSSIBLE "EQV"
_ASCTFP_1:
  POP HL                  ;RESTORE [H,L]
  JR Z,_ASCTFP_2          ;IT WAS JUMP!
  LD A,(VALTYP)           ;IF DOUBLE DON'T DOWNGRADE TO SINGLE
  CP $08                  ;SET CONDITION CODES
  JR Z,FINEX1    
  LD A,$00                ;MAKE A=0 SO NUMBER IS A SINGLE
  JR FINEX1

_ASCTFP_2:
  LD A,(HL)               ;RESTORE ORIGINAL CHAR
NOTE:
  CP '%'				  ;TRAILING % (RSTS-11 COMPATIBILITY)    ; Integer variable ?
  JR Z,FININT             ;MUST BE INTEGER.
  CP '#'				  ;FORCE DOUBLE PRECISION?               ; Double precision variable ?
  JR Z,FINDBF             ;YES, FORCE IT & FINISH UP.
  CP '!'				  ;FORCE SINGLE PREC.                    ; Single precision variable ?
  JR Z,FINSNF
  CP 'd'                  ;LOWER CASE "D"
  JR Z,FINEX1
  CP 'D'                  ;CHECK FOR A DOUBLE PRECISION EXPONENT
  JR NZ,FINE              ;WE DON'T HAVE ONE, THE NUMBER IS FINISHED

FINEX1:
  OR A                    ;DOUBLE PRECISION NUMBER -- TURN OFF ZERO FLAG
;FINEX:
  CALL FINFRC             ;FORCE THE FAC TO BE SNG OR DBL
  CALL CHRGTB             ;GET THE FIRST CHARACTER OF THE EXPONENT
  CALL SGNEXP             ;EAT SIGN OF EXPONENT  ( test '+', '-'..)

	;HERE TO GET THE NEXT DIGIT OF THE EXPONENT
; This entry point is used by the routine at MULTEN.
FINEC:
  CALL CHRGTB             ;GET THE NEXT CHARATER
  JP C,FINEDG             ;PACK THE NEXT DIGIT INTO THE EXPONENT
  INC D                   ;IT WAS NOT A DIGIT, PUT THE CORRECT SIGN ON
  JR NZ,FINE              ; THE EXPONENT, IT IS POSITIVE
  XOR A                   ;THE EXPONENT IS NEGATIVE
  SUB E                   ;NEGATE IT
  LD E,A                  ;SAVE IT AGAIN
  
	;HERE TO FINISH UP THE NUMBER
FINE:
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD A,E                  ;FIND OUT HOW MANY TIMES WE HAVE TO MULTIPLY
  SUB B                   ; OR DIVIDE BY TEN
  LD E,A                  ;SAVE NEW EXPONENT IN E

	;HERE TO MULTIPLY OR DIVIDE BY TEN THE CORRECT NUMBER OF TIMES
	;IF THE NUMBER IS AN INT, A IS 0 HERE.
FINE_0:
  CALL P,FINMUL           ;MULTIPLY IF WE HAVE TO
  CALL M,FINDIV           ;DIVIDE IF WE HAVE TO
  JR NZ,FINE_0            ;MULTIPLY OR DIVIDE AGAIN IF WE ARE NOT DONE

;HERE TO PUT THE CORRECT SIGN ON THE NUMBER
  POP HL                  ;GET THE TEXT POINTER
  POP AF                  ;GET THE SIGN
  PUSH HL                 ;SAVE THE TEXT POINTER AGAIN
  CALL Z,INVSGN           ;NEGATE IF NECESSARY
;FINE2C:
  POP HL                  ;GET THE TEXT POINTER IN (HL)
  CALL GETYPR             ;WE WANT -32768 TO BE AN INT, BUT UNTIL NOW IT WOULD BE A SNG
  RET PE                  ;IT IS NOT SNG, SO IT IS NOT -32768
  PUSH HL                 ;WE HAVE A SNG, SAVE TEXT POINTER
  LD HL,POPHLRT           ;GET ADDRESS THAT POP'S H OFF STACK BECAUSE
  PUSH HL                 ; CONIS2 DOES FUNNY THINGS WITH THE STACK
  CALL CONIS2             ;CHECK IF WE HAVE -32768
  RET                     ;WE DON'T, POPHRT IS STILL ON THE STACK SO WE CAN JUST RETURN


	;HERE TO CHECK IF WE HAVE SEEN 2 DECIMAL POINTS AND SET THE DECIMAL POINT FLAG
; a.k.a. FINDP
DPOINT:
  CALL GETYPR             ;SET CARRY IF WE DON'T HAVE A DOUBLE
  INC C                   ;SET THE FLAG
  JR NZ,FINE              ;WE HAD 2 DECIMAL POINTS, NOW WE ARE DONE
  CALL C,FINFRC           ;THIS IS THE FIRST ONE, CONVERT FAC TO SNG IF WE DON'T ALREADY HAVE A DOUBLE
  JP _ASCTFP_0            ;CONTINUE LOOKING FOR DIGITS

FININT:
  CALL CHRGTB             ; Gets next character (or token) from BASIC text.
  POP AF                  ;GET SIGN OFF THE STACK
  PUSH HL                 ;SAVE TEXT POINTER
  LD HL,POPHLRT           ;ADDRESS POP (HL) AND RETURN
  PUSH HL                 ; * (added in the late March edition)
  LD HL,__CINT            ; *
  PUSH HL                 ;WILL WANT TO FORCE ONCE D.P. DONE
  PUSH AF                 ;PUT SIGN BACK ON THE STACK
  JR FINE                 ;ALL DONE

FINDBF:
  OR A                    ;SET NON-ZERO TO FORCE DOUBLE PREC

FINSNF:
  CALL FINFRC             ;FORCE THE TYPE
  CALL CHRGTB             ;READ AFTER TERMINATOR
  JR FINE                 ;ALL DONE


	;FORCE THE FAC TO BE SNG OR DBL
	;IF THE ZERO FLAG IS ON, THEN FORCE THE FAC TO BE SNG
	;IF THE ZERO FLAG IS OFF, FORCE THE FAC TO BE DBL
FINFRC:
  PUSH HL                 ;SAVE TEXT POINTER
  PUSH DE                 ;SAVE EXPONENT INFORMATION
  PUSH BC                 ;SAVE DECIMAL POINT INFORMATION
  PUSH AF                 ;SAVE WHAT WE WANT THE FAC TO BE
  CALL Z,__CSNG           ;CONVERT TO SNG IF WE HAVE TO
  POP AF                  ;GET TYPE FLAG BACK
  CALL NZ,__CDBL          ;CONVERT TO DBL IF WE HAVE TO
  POP BC                  ;GET DECIMAL POINT INFORMATION BACK
  POP DE                  ;GET EXPONENT INFORMATION BACK
  POP HL                  ;GET TEXT POINTER BACK
  RET                     ;ALL DONE


	;THIS SUBROUTINE MULIPLIES BY TEN ONCE.
	;IT IS A SUBROUTINE BECAUSE IT SAVES BYTES WHEN WE CHECK IF A IS ZERO
	;ALTERS ALL REGISTERS
FINMUL:
  RET Z                   ; Exit if no scaling needed        ;RETURN IF EXPONENT IS ZERO, ENTRY FROM FOUT

; Multiply FP value by ten
;
; Used by the routine at FOUBE3.
MULTEN:
  PUSH AF                 ;SAVE EXPONENT, ENTRY FROM FOUT
  CALL GETYPR             ;SEE WHAT KIND OF NUMBER WE HAVE
  PUSH AF                 ;SAVE THE TYPE
  CALL PO,MLSP10          ;WE HAVE A SNG, MULTIPLY BY 10.0
  POP AF                  ;GET THE TYPE BACK
  CALL PE,DMUL10          ;WE HAVE A DBL, MULTIPLY BY 10D0
  POP AF                  ;GET EXPONENT
; This entry point is used by the routine at FOUBE3.
DCRART:
  DEC A                   ;DECREASE IT
  RET                     ;ALL DONE


	;THIS SUBROUTINE DIVIDES BY TEN ONCE.
	;IT IS USED BY FIN, FOUT
	;ALTERS A,B,C
; This entry point is used by the routines at _ASCTFP and FOUBE3.
FINDIV:
  PUSH DE                ;SAVE D,E
  PUSH HL                ;SAVE H,L
  PUSH AF                ;WE HAVE TO DIVIDE -- SAVE COUNT
  CALL GETYPR            ;SEE WHAT KIND OF NUMBER WE HAVE
  PUSH AF                ;SAVE THE TYPE
  CALL PO,DIV10          ;WE HAVE A SNG NUMBER
  POP AF                 ;GET THE TYPE BACK
  CALL PE,DDIV10         ;WE HAVE A DBL NUMBER
  POP AF                 ;GET COUNT BACK
  POP HL                 ;GET H,L BACK
  POP DE                 ;GET D,E BACK
  INC A                  ;UPDATE IT
  RET


; a.k.a. FINDIG
	;HERE TO PACK THE NEXT DIGIT OF THE NUMBER INTO THE FAC
	;WE MULTIPLY THE FAC BY TEN AND ADD IN THE NEXT DIGIT
; This entry point is used by the routine at _ASCTFP.
ADDIG:
  PUSH DE                ;SAVE EXPONENT INFORMATION                  ; Save sign of exponent/digit
  LD A,B                 ;INCREMENT DECIMAL PLACE COUNT IF WE ARE    ; Get digits after point
  ADC A,C                ; PAST THE DECIMAL POINT                    ; Add one if after point
  LD B,A                                                             ; Re-save counter
  PUSH BC                ;SAVE DECIMAL POINT INFORMATION             ; Save point flags
  PUSH HL                ;SAVE TEXT POINTER                          ; Save code string address
  LD A,(HL)              ;GET THE DIGIT
  SUB '0'                ;CONVERT IT TO ASCII                        ; convert from ASCII
  PUSH AF                ;SAVE THE DIGIT
  CALL GETYPR            ;SEE WHAT KIND OF A NUMBER WE HAVE          ; Get the number type (FAC)
  JP P,FINDGV            ;WE DO NOT HAVE AN INTEGER 

	;HERE TO PACK THE NEXT DIGIT OF AN INTEGER
  LD HL,(FACCU)          ;WE HAVE AN INTEGER, GET IT IN (HL)
  LD DE,3277             ;SEE IF WE WILL OVERFLOW                    ; Const: $0CCD
  CALL DCOMPR            ;COMPAR RETURNS WITH CARRY ON IF            ; Compare HL with DE.
  JR NC,FINDG2           ; (HL) .LT. (DE), SO THE NUMBER IS TOO BIG
  LD D,H                 ;COPY (HL) INTO (DE)
  LD E,L
  ADD HL,HL              ;MULTIPLY (HL) BY 2                         ; * 10
  ADD HL,HL              ;MULTIPLY (HL) BY 2, (HL) NOW IS 4*(DE)
  ADD HL,DE              ;ADD IN OLD (HL) TO GET 5*(DE)
  ADD HL,HL              ;MULTIPLY BY 2 TO GET TEN TIMES THE OLD (HL)
  POP AF                 ;GET THE DIGIT
  LD C,A                 ;SAVE IT SO WE CAN USE DAD, B IS ALREADY ZERO
  ADD HL,BC              ;ADD IN THE NEXT DIGIT
  LD A,H                 ;CHECK FOR OVERFLOW
  OR A                   ;OVERFLOW OCCURED IF THE MSB IS ON
  JP M,FINDG1            ;WE HAVE OVERFLOW!!
  LD (FACCU),HL          ;EVERYTHING IS FINE, STORE THE NEW NUMBER
FINDGE:
  POP HL                 ;ALL DONE, GET TEXT POINTER BACK
  POP BC                 ;GET DECIMAL POINT INFORMATION BACK
  POP DE                 ;GET EXPONENT INFORMATION BACK
  JP _ASCTFP_0           ;GET THE NEXT CHARACTER


	;HERE TO HANDLE 32768, 32769
FINDG1:
  LD A,C                 ;GET THE DIGIT
  PUSH AF                ;PUT IT BACK ON THE STACK


	;HERE TO CONVERT THE INTEGER DIGITS TO SINGLE PRECISION DIGITS
FINDG2:
  CALL CONSI             ;CONVERT THE INTEGER TO SINGLE PRECISION
  SCF                    ;DO NOT TAKE THE FOLLOWING JUMP

	;HERE TO DECIDE IF WE HAVE A SINGLE OR DOUBLE PRECISION NUMBER
FINDGV:
  JR NC,FINDGD           ;FALL THROUGH IF VALTYP WAS 4 I.E. SNG PREC
  LD BC,$9474            ;GET 1000000, DO WE HAVE 7 DIGITS ALREADY?
  LD DE,$2400
  CALL FCOMP             ;IF SO, FAC .GE. 1000000
  JP P,FINDG3            ;WE DO, CONVERT TO DOUBLE PRECISION
  CALL MLSP10            ;MULTIPLY THE OLD NUMBER BY TEN
  POP AF                 ;GET THE NEXT DIGIT
  CALL FINDG4            ;PACK IT INTO THE FAC
  JR FINDGE              ;GET FLAGS OFF STACK AND WE ARE DONE

	;HERE TO CONVERT A 7 DIGIT SINGLE PRECISION NUMBER TO DOUBLE PRECISION
FINDG3:
  CALL CONDS             ;CONVERT SINGLE TO DOUBLE PRECISION

	;HERE TO PACK IN THE NEXT DIGIT OF A DOUBLE PRECISION NUMBER
FINDGD:
  CALL DMUL10            ;MULTIPLY THE FAC BY 10
  CALL VMOVAF            ;SAVE THE FAC IN ARG
  POP AF                 ;GET THE NEXT DIGIT
  CALL FLOAT             ;CONVERT THE DIGIT TO SINGLE PRECISION
  CALL CONDS             ;NOW, CONVERT THE DIGIT TO DOUBLE PRECISION
  CALL DADD              ;ADD IN THE DIGIT
  JR FINDGE              ;GET THE FLAGS OFF THE STACK AND WE ARE DONE

; a.k.a. RSCALE
FINDG4:
  CALL PUSHF
  CALL FLOAT
; This entry point is used by the routine at IADD.
FADDT:
  POP BC                 ;GET PREVIOUS NUMBER OFF STACK
  POP DE
  JP FADD                ;ADD THE TWO NUMBERS

; This entry point is used by the routine at _ASCTFP.
FINEDG:
  LD A,E                 ;EXPONENT DIGIT -- MULTIPLY EXPONENT BY 10
  CP 10                  ;CHECK THAT THE EXPONENT DOES NOT OVERFLOW
                         ;IF IT DID, E COULD GET GARBAGE IN IT.
  JR NC,FINEDO           ;WE ALREADY HAVE TWO DIGITS
  RLCA                   ;FIRST BY 4
  RLCA
  ADD A,E                ;ADD 1 TO MAKE 5
  RLCA                   ;NOW DOUBLE TO GET 10
  ADD A,(HL)             ;ADD IT IN
  SUB '0'                ;SUBTRACT OFF ASCII CODE, THE RESULT IS
                         ; POSITIVE ON LENGTH=2 BECAUSE OF THE ABOVE CHECK
  LD E,A                 ;STORE EXPONENT
  DEFB $FA               ; JP M,nn  to mask the next 2 bytes

FINEDO:
  LD E,$7F               ;AN EXPONENT LIKE THIS WILL SAFELY CAUSE OVERFLOW OR UNDERFLOW
  JP FINEC               ;CONTINUE

; This entry point is used by the routines at FDIV and MLDVEX.
OVFIN1:
  PUSH HL
  LD HL,FACCU+2          ;POINT (HL) TO SIGN BYTE
  CALL GETYPR
  JP PO,OVF2A            ;SP PROCEED AS NORMAL
  LD A,(ARG-1)
  JR OVF2B

OVF2A:
  LD A,C
OVF2B:
  XOR (HL)               ;SIGN IN HIGH BIT OF (A)
  RLA                    ;SIGN IN CARRY
  POP HL
  JR OVFINT              ;GO PRINT OVERFLOW

; This entry point is used by the routine at __EXP.
OVFIN6:
  POP AF                 ; This entry is used by __EXP
  POP AF                 ; (RESZER exits here)

; Deal with various overflow conditions
;
; Used by the routine at MLSP10.
OVERR:
  LD A,(FACCU+2)
  RLA
  JR OVFINT              ;GO PRINT OVERFLOW

; This entry point is used by the routine at BNORM.
OVERR_0:
  POP AF                 ;DO A POP THEN FALL INTO OVERR_1

; This entry point is used by the routines at FADD, DADD and DDIV.
OVERR_1:
  LD A,(SGNRES)          ;GET SIGN BYTE
  CPL                    ;SIGN WAS STORED COMPLEMENTED
  RLA                    ;SIGN TO CARRY
  JR OVFINT              ;GO PRINT OVERFLOW

; This entry point is used by the routine at FDIV.
DIV_DZERR:
  OR B
  JR Z,DZERR
  LD A,C
  JR DZERR

; Division (exponent is 0)
;
; Used by the routine at DDIV.
DDIV_SUB:
  LD A,(FACCU+2)

; This entry point is used by the routines at OVERR and __SQR.
DZERR:
  RLA                    ;TO CARRY
  LD HL,DIV0_MSG         ;GET MESSAGE ADDRESS
  LD (OVERRI),HL         ;STORE SO OVFINT WILL PICK UP


	;ANSI OVERFLOW ROUTINE
; This entry point is used by the routines at MULTEN and OVERR.
OVFINT:
  PUSH HL
  PUSH BC
  PUSH DE
  PUSH AF                ;SAVE MACHINE STATUS
  PUSH AF                ;AGAIN
  LD HL,(ONELIN)         ;TRAPPING ERRORS?
  LD A,H                 
  OR L
  JR NZ,OVFPRT           ;JUMP PRINT IF TRAPPING OTHERWISE +INFINITY
  LD HL,FLGOVC           ;PRINT INDICATOR FLAG
  LD A,(HL)
  OR A                   ;PRINT IF 0,1;SET TO 2 IF 1
  JR Z,OV1A
  DEC A
  JR NZ,OVFPRT
  INC (HL)
OV1A:
  LD HL,(OVERRI)         ;ADDRESS OF OVERFLOW MESSAGE
  CALL STRPRN            ;PRINT
  LD (TTYPOS),A          ;SET TTY POSITION TO CHAR 0
  LD A,$0D
  CALL CALTTY
  LD A,$0A
  CALL CALTTY            ;CARRIAGE RETURN,LINE FEED
OVFPRT:
  POP AF                 ;GET PLUS,MINUS INDICATION BACK
  LD HL,FACCU            ;MUST NOW PUT RIGHT INFINITY INTO THE FAC
  LD DE,INFP
  JR NC,OVFINA
  LD DE,INFM             ;MINUS INFINITY
OVFINA:
  CALL MOVE              ;MOVE INTO FAC
  CALL GETYPR
  JR C,OVFINB            ;SP ALL OK
  LD HL,FACLOW
  LD DE,INFM             ;ALL ONES
  CALL MOVE
OVFINB:
  LD HL,(ONELIN)         ;TRAPPING ERRORS?
  LD A,H
  OR L
  LD HL,(OVERRI)
  LD DE,OVERFLOW_MSG
  EX DE,HL               ;PUT "OVRMSG" ADDRESS IN OVERRI
  LD (OVERRI),HL         ;IN CASE THIS WAS A DIV BY 0
  JR Z,NOODTP            ;JUMP IF NOT TRAPPING
  CALL DCOMPR
  JP Z,OV_ERR            ;ALL RESTORED 
  JP O_ERR               ;CONTINUE PROCESSING

NOODTP:
  POP AF
  POP DE
  POP BC
  POP HL                 ;ALL RESTORED 
  RET                    ;CONTINUE PROCESSING

INFP:
  DEFB $FF,$FF,$7F,$FF    ; INFINITY

INFM:
  DEFB $FF,$FF,$FF,$FF    ; MINUS INFINITY





	
; 'in' <line number> message
;
; Used by the routines at _ERROR_REPORT and _LINE2PTR.
IN_PRT:
  PUSH HL               ;SAVE LINE NUMBER
  LD HL,IN_MSG          ;PRINT MESSAGE    (.." in "..)
  CALL PRS
  POP HL                ;FALL INTO LINPRT


; Print HL in ASCII form at the current cursor position
; a.k.a. NUMPRT
		;PRINT THE 2 BYTE NUMBER IN H,L
		;ALTERS ALL REGISTERS
; This entry point is used by the routines at PROMPT, NEWSTT_0, __LIST, _LINE2PTR,
; __EDIT and DONCMD.
LINPRT:
  LD BC,PRNUMS
  PUSH BC
  CALL MAKINT            ;PUT THE LINE NUMBER IN THE FAC AS AN INTEGER
  XOR A                  ;SET FORMAT TO FREE FORMAT
  CALL FOUINI            ;SET UP THE SIGN
  OR (HL)                ;TURN OFF THE ZERO FLAG
  JR SPCFST              ;CONVERT THE NUMBER INTO DIGITS




;
;	OUTPUT THE VALUE IN THE FAC ACCORDING TO THE FORMAT SPECIFICATIONS
;	IN A,B,C
;	ALL REGISTERS ARE ALTERED
;	THE ORIGINAL CONTENTS OF THE FAC IS LOST
;
;	THE FORMAT IS SPECIFIED IN A, B AND C AS FOLLOWS:
;	THE BITS OF A MEAN THE FOLLOWING:
;BIT 7	0 MEANS FREE FORMAT OUTPUT, I.E. THE OTHER BITS OF A MUST BE ZERO,
;	TRAILING ZEROS ARE SUPPRESSED, A NUMBER IS PRINTED IN FIXED OR FLOATING
;	POINT NOTATION ACCORDING TO ITS MAGNITUDE, THE NUMBER IS LEFT
;	JUSTIFIED IN ITS FIELD, B AND C ARE IGNORED.
;	1 MEANS FIXED FORMAT OUTPUT, I.E. THE OTHER BITS OF A ARE CHECKED FOR
;	FORMATTING INFORMATION, THE NUMBER IS RIGHT JUSTIFIED IN ITS FIELD,
;	TRAILING ZEROS ARE NOT SUPPRESSED.  THIS IS USED FOR PRINT USING.
;BIT 6	1 MEANS GROUP THE DIGITS IN THE INTEGER PART OF THE NUMBER INTO GROUPS
;	OF THREE AND SEPARATE THE GROUPS BY COMMAS
;	0 MEANS DON'T PRINT THE NUMBER WITH COMMAS
;BIT 5	1 MEANS FILL THE LEADING SPACES IN THE FIELD WITH ASTERISKS ("*")
;BIT 4	1 MEANS OUTPUT THE NUMBER WITH A FLOATING DOLLAR SIGN ("$")
;BIT 3	1 MEANS PRINT THE SIGN OF A POSITIVE NUMBER AS A PLUS SIGN ("+")
;	INSTEAD OF A SPACE
;BIT 2	1 MEANS PRINT THE SIGN OF THE NUMBER AFTER THE NUMBER
;BIT 1	UNUSED
;BIT 0	1 MEANS PRINT THE NUMBER IN FLOATING POINT NOTATION I.E. "E NOTATION"
;	IF THIS BIT IS ON, THE COMMA SPECIFICATION (BIT 6) IS IGNORED.
;	0 MEANS PRINT THE NUMBER IN FIXED POINT NOTATION.  NUMBERS .GE. 1E16
;	CANNOT BE PRINTED IN FIXED POINT NOTATION.
;
;	B AND C TELL HOW BIG THE FIELD IS:
;B   =	THE NUMBER OF PLACES IN THE FIELD TO THE LEFT OF THE DECIMAL POINT
;	(B DOES NOT INCLUDE THE DECIMAL POINT)
;C   =	THE NUMBER OF PLACES IN THE FIELD TO THE RIGHT OF THE DECIMAL POINT
;	(C INCLUDES THE DECIMAL POINT)
;	B AND C DO NOT INCLUDE THE 4 POSITIONS FOR THE EXPONENT IF BIT 0 IS ON
;	FOUT ASSUMES B+C .LE. 24 (DECIMAL)
;	IF THE NUMBER IS TOO BIG TO FIT IN THE FIELD, A PERCENT SIGN ("%") IS
;	PRINTED AND THE FIELD IS EXTENDED TO HOLD THE NUMBER.



; Convert number/expression to string (format not specified)
;
	;FLOATING OUTPUT OF FAC
	;ALTERS ALL REGISTERS
	;THE ORIGINAL CONTENTS OF THE FAC IS LOST
;
; a.k.a. NUMASC
; Used by the routines at __PRINT, LISPRT, FOUBE3, CAYSTR and __STR_S.
FOUT:                   ;ENTRY TO PRINT THE FAC IN FREE FORMAT
  XOR A                 ;SET FORMAT FLAGS TO FREE FORMATTED OUTPUT

; Convert the binary number in FAC1 to ASCII.  A - Bit configuration for PRINT USING options
; This entry point is used by the routine at USING.
PUFOUT:                 ;ENTRY TO PRINT THE FAC USING THE FORMAT SPECIFICATIONS IN A, B AND C
  CALL FOUINI           ;SAVE THE FORMAT SPECIFICATION IN A AND PUT A SPACE FOR POSITIVE NUMBERS IN THE BUFFER
  AND $08               ;CHECK IF POSITIVE NUMBERS GET A PLUS SIGN      ; bit 3 - Sign (+ or -) preceeds number
  JR Z,PUFOUT_0         ;THEY DON'T
  LD (HL),'+'           ;THEY DO, PUT IN A PLUS SIGN
PUFOUT_0:
  EX DE,HL              ;SAVE BUFFER POINTER
  CALL VSIGN            ;GET THE SIGN OF THE FAC                        ; Test sign of FPREG
  EX DE,HL              ;PUT THE BUFFER POINTER BACK IN (HL)
  JP P,SPCFST           ;IF WE HAVE A NEGATIVE NUMBER, NEGATE IT        ; Positive - Space to start
  LD (HL),'-'           ; AND PUT A MINUS SIGN IN THE BUFFER            ; "-" sign at start
  PUSH BC               ;SAVE THE FIELD LENGTH SPECIFICATION
  PUSH HL               ;SAVE THE BUFFER POINTER
  CALL INVSGN           ;NEGATE THE NUMBER
  POP HL                ;GET THE BUFFER POINTER BACK
  POP BC                ;GET THE FIELD LENGTH SPECIFICATIONS BACK
  OR H                  ;TURN OFF THE ZERO FLAG, THIS DEPENDS ON THE FACT THAT FBUFFR IS NEVER ON PAGE 0.

; This entry point is used by the routine at IN_PRT.
SPCFST:
  INC HL                ;POINT TO WHERE THE NEXT CHARACTER GOES  ; First byte of number
  LD (HL),'0'           ;PUT A ZERO IN THE BUFFER IN CASE THE NUMBER IS ZERO (IN FREE FORMAT)
                        ;OR TO RESERVE SPACE FOR A FLOATING DOLLAR SIGN (FIXED FORMAT)
  LD A,(TEMP3)          ;GET THE FORMAT SPECIFICATION
  LD D,A                ;SAVE IT FOR LATER
  RLA                   ;PUT THE FREE FORMAT OR NOT BIT IN THE CARRY
  LD A,(VALTYP)         ;GET THE VALTYP, VNEG COULD HAVE CHANGED THIS SINCE -32768 IS INT AND 32768 IS SNG.
  JP C,FOUTFX           ;THE MAN WANTS FIXED FORMATED OUTPUT
  
	;HERE TO PRINT NUMBERS IN FREE FORMAT
  JP Z,FOUTZR           ;IF THE NUMBER IS ZERO, FINISH IT UP
  CP $04                ;DECIDE WHAT KIND OF A VALUE WE HAVE
  JR NC,FOUFRV          ;WE HAVE A SNG OR DBL

	;HERE TO PRINT AN INTEGER IN FREE FORMAT
  LD BC,$0000           ;SET THE DECIMAL POINT COUNT AND COMMA COUNT TO ZERO
  CALL FOUTCI           ;CONVERT THE INTEGER TO DECIMAL
                        ;FALL INTO FOUTZS AND ZERO SUPPRESS THE THING

	;ZERO SUPPRESS THE DIGITS IN FBUFFR
	;ASTERISK FILL AND ZERO SUPPRESS IF NECESSARY
	;SET UP B AND CONDITION CODES IF WE HAVE A TRAILING SIGN
FOUTZS:
  LD HL,FBUFFR+1        ;GET POINTER TO THE SIGN
  LD B,(HL)             ;SAVE THE SIGN IN B
  LD C,$20              ;DEFAULT FILL CHARACTER TO A SPACE
  LD A,(TEMP3)          ;GET FORMAT SPECS TO SEE IF WE HAVE TO
  LD E,A                ; ASTERISK FILL.  SAVE IT                       ; bit 5 - Asterisks fill  
  AND $20
  JR Z,FOUTZS_0         ;WE DON'T
  LD A,B                ;WE DO, SEE IF THE SIGN WAS A SPACE
  CP C                  ;ZERO FLAG IS SET IF IT WAS
  LD C,$2A              ;SET FILL CHARACTER TO AN ASTERISK
  JR NZ,FOUTZS_0        ;SET THE SIGN TO AN ASTERISK IF IT WAS A SPACE
  LD A,E                ;GET FORMAT SPECS AGAIN
  AND $04               ;SEE IF SIGN IS TRAILING                        ; bit 2 - Sign (+ or -) follows ASCII number  
  JR NZ,FOUTZS_0        ;IF SO DON'T ASTERISK FILL
  LD B,C                ;B HAS THE SIGN, C THE FILL CHARACTER

FOUTZS_0:
  LD (HL),C             ;FILL IN THE ZERO OR THE SIGN
  CALL CHRGTB           ;GET THE NEXT CHARACTER IN THE BUFFER SINCE THERE ARE NO SPACES, "CHRGET" IS EQUIVALENT TO "INX	H"/"MOV	A,M"
  JR Z,FOUTZS_1         ;IF WE SEE A REAL ZERO, IT IS THE END OF THE NUMBER, AND WE MUST BACK UP AND PUT IN A ZERO.
                        ;CHRGET SETS THE ZERO FLAG ON REAL ZEROS OR COLONS, BUT WE WON'T SEE ANY COLONS IN THIS BUFFER.

  CP 'E'                ;BACK UP AND PUT IN A ZERO IF WE SEE
  JR Z,FOUTZS_1         ;AN "E" OR A "D" SO WE CAN PRINT 0 IN
  CP 'D'                ;FLOATING POINT NOTATION WITH THE C FORMAT ZERO
  JR Z,FOUTZS_1
  CP '0'                ;DO WE HAVE A ZERO?
  JR Z,FOUTZS_0         ;YES, SUPPRESS IT
  CP ','                ;DO WE HAVE A COMMA?
  JR Z,FOUTZS_0         ;YES, SUPPRESS IT
  CP '.'                ;ARE WE AT THE DECIMAL POINT?
  JR NZ,FOUTZS_2        ;NO, I GUESS NOT
FOUTZS_1:
  DEC HL                ;YES, BACK UP AND PUT A ZERO BEFORE IT
  LD (HL),'0'
FOUTZS_2:
  LD A,E                ;GET THE FORMAT SPECS TO CHECK FOR A FLOATING
  AND $10               ; DOLLAR SIGN                                   ; bit 4 - Print leading '$'  
  JR Z,FOUTZS_3         ;WE DON'T HAVE ONE
  DEC HL                ;WE HAVE ONE, BACK UP AND PUT IN THE DOLLAR
  LD (HL),'$'           ; SIGN
FOUTZS_3:
  LD A,E                ;DO WE HAVE A TRAILING SIGN?
  AND $04                                                               ; bit 2 - Sign (+ or -) follows ASCII number  
  RET NZ                ;YES, RETURN; NOTE THE NON-ZERO FLAG IS SET
  DEC HL                ;NO, BACK UP ONE AND PUT THE SIGN BACK IN
  LD (HL),B             ;PUT IN THE SIGN
  RET                   ;ALL DONE


	;HERE TO INITIALLY SET UP THE FORMAT SPECS AND PUT IN A SPACE FOR THE
	;SIGN OF A POSITIVE NUMBER
; This entry point is used by the routine at IN_PRT.
FOUINI:
  LD (TEMP3),A          ;SAVE THE FORMAT SPECIFICATION
  LD HL,FBUFFR+1        ;GET A POINTER INTO FBUFFR
                        ;WE START AT FBUFFR+1 IN CASE THE NUMBER WILL OVERFLOW ITS FIELD, 
						; THEN THERE IS ROOM IN FBUFFR FOR THE PERCENT SIGN.
  LD (HL),' '           ;PUT IN A SPACE
  RET                   ;ALL DONE



;THE FOLLOWING CODE DOWN TO FOUFRF: IS ADDED TO ADDRESS THE
;ANSI STANDARD OF PRINTING NUMBERS IN FIXED FORMAT RATHER THAN
;SCIENTIFIC NOTATION IF THEY CAN BE AS ACCURATELY RPRESENTED
;IN FIXED FORMAT


	;HERE TO PRINT A SNG OR DBL IN FREE FORMAT
FOUFRV:
  CALL PUSHF            ;SAVE IN CASE NEEDED FOR 2ED PASS
  EX DE,HL              ;SAVE BUFFER POINTER IN (HL)
  LD HL,(FACLOW)
  PUSH HL               ;SAVE FOR D.P.
  LD HL,(FACLOW+2)
  PUSH HL
  EX DE,HL              ;BUFFER POINTER BACK TO (HL)
  PUSH AF               ;SAVE IN CASE NEEDED FOR SECOND PASS
  XOR A                 ;(A)=0
  LD (FANSII),A         ;INITIALIZE FANSII FLAG
  POP AF                ;GET PSW RIGHT
  PUSH AF               ;SAVE PSW
  CALL FOUFRF           ;FORMAT NUMBER
  LD B,'E'              ;WILL SEARCH FOR SCIENTIFIC NOTN.
  LD C,$00              ;DIGIT COUNTER
FU1:                    ;GET ORIGINAL FBUFFER POINTER
  PUSH HL               ;SAVE IN CASE WE NEED TO LOOK FOR "D"
  LD A,(HL)             ;FETCH UP FIRST CHARACTER
FU2:
  CP B                  ;SCIENTIFIC NOTATION?
  JR Z,FU4              ;IF SO, JUMP
  CP '9'+1              ;IF CARRY NOT SET NOT A DIGIT
  JR NC,FU2A
  CP '0'                ;IF CARRY SET NOT A DIGIT
  JR C,FU2A
  INC C                 ;INCREMENTED DIGITS TO PRINT
FU2A:
  INC HL                ;POINT TO NEXT BUFFER CHARACTER
  LD A,(HL)             ;FETCH NEXT CHARACTER
  OR A                  ;0(BINARY) AT THE END OF CHARACTERS
  JR NZ,FU2             ;CONTINUE SEARCH IF NOT AT END
  LD A,'D'              ;NOW TO CHECK TO SEE IF SEARCHED FOR D
  CP B
  LD B,A                ;IN CASE NOT YET SEARCHED FOR
  POP HL                ;NOW TO CHECK FOR "D"
  LD C,$00              ;ZERO DIGIT COUNT
  JR NZ,FU1             ;GO SEARCH FOR "D" IF NOT DONE SO
FU3:
  POP AF                ;POP	ORIGINAL PSW
  POP BC
  POP DE                ;GET DFACLO-DFACLO+3
  EX DE,HL              ;(DE)=BUF PTR,(HL)=DFACLO
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACLOW+2),HL
  EX DE,HL
  POP BC
  POP DE                ;GET ORIG FAC OFF STACK
  RET                   ;COMPLETE

FU4:                    ;PRINT IS IN SCIENTIFIC NOTATION , IS THIS BEST?
  PUSH BC               ;SAVE TYPE,DIGIT COUNT
  LD B,$00              ;EXPONENT VALUE (IN BINARY)
  INC HL                ;POINT TO NEXT CHARACTER OF EXP.
  LD A,(HL)             ;FETCH NEXT CHARACTER OF EXPONENT
FU5:
  CP '+'                ;IS EXPONENT POSITIVE?
  JR Z,FU8              ;IF SO NO BETTER PRINTOUT
  CP '-'                ;MUST BE NEGATIVE!
  JR Z,FU5A             ;MUST PROCESS THE DIGITS
  SUB '0'               ;SUBTRACT OUT ASCII BIAS
  LD C,A                ;DIGIT TO C
  LD A,B                ;FETCH OLD DIGIT
  ADD A,A               ;*2
  ADD A,A               ;*4
  ADD A,B               ;*5
  ADD A,A               ;*10
  ADD A,C               ;ADD IN NEW DIGIT
  LD B,A                ;BACK OUT TO EXPONENT ACCUMULATOR
  CP 16                 ;16 D.P. DIGITS FOR MICROSOFT FORMAT
  JR NC,FU8             ;IF SO STOP TRYING
FU5A:
  INC HL                ;POINT TO NEXT CHARACTER 
  LD A,(HL)             ;FETCH UP
  OR A                  ;BINARY ZERO AT END
  JR NZ,FU5             ;CONTINUE IF NOT AT END
  LD H,B                ;SAVE EXPONENT
  POP BC                ;FETCH TYPE, DIGIT COUNT
  LD A,B                ;DETERMINE TYPE
  CP 'E'                ;SINGLE PRECISION?
  JR NZ,FU7             ;NO - GO PROCESS AS DOUBLE PRECISION
  LD A,C                ;DIGIT COUNT
  ADD A,H               ;ADD EXPONENT VALUE
  CP $09
  POP HL                ;POP OLD BUFFER POINTER
  JR NC,FU3             ;CAN'T DO BETTER
FU6:
  LD A,$80
  LD (FANSII),A
  JR FU9                ;DO FIXED POINT PRINTOUT
  
FU7:
  LD A,H                ;SAVE EXPONENT
  ADD A,C               ;TOTAL DIGITS NECESSARY
  CP $12                ;MUST PRODUCE CARRY TO USE FIXED POINT
  POP HL                ;GET STACK RIGHT
  JR NC,FU3
  JR FU6                ;GO PRINT IN FIXED POINT
  
FU8:
  POP BC
  POP HL                ;GET ORIGINAL BUFFER PTR BACK
  JR FU3
  
FU9:
  POP AF                ;GET ORIGINAL PSW OFF STACK
  POP BC
  POP DE                ;GET DFACLO-DFACLO+3
  EX DE,HL              ;(DE)=BUFFER PTR,(HL)=DFACLO
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACLOW+2),HL
  EX DE,HL
  POP BC
  POP DE                ;GET ORIGINAL FAC BACK
  CALL FPBCDE           ;MOVE TO FAC
  INC HL                ;BECAUSE WHEN WE ORIGINALLY ENTERED FOUFRV THE (HL) POINTED TO A CHAR.
                        ;PAST THE SIGN AND THE PASS THROUGH THIS CODE LEAVES (HL) POINTING TO THE SIGN.
                        ;(HL) MUST POINT PAST SIGN!

FOUFRF:
  CP $05                ;SET CC'S FOR Z80
  PUSH HL               ;SAVE THE BUFFER POINTER
  SBC A,$00             ;MAP 4 TO 6 AND 10 TO 20
  RLA                   ;THIS CALCULATES HOW MANY DIGITS
  LD D,A                ;WE WILL PRINT
  INC D
  CALL FOUTNV           ;NORMALIZE THE FAC SO ALL SIGNIFICANT DIGITS ARE IN THE INTEGER PART
  LD BC,$0300           ;B = DECIMAL POINT COUNT
                        ;C = COMMA COUNT
                        ;SET COMMA COUNT TO ZERO AND DECIMAL POINT COUNT FOR E NOTATION
  PUSH AF               ;SAVE FOR NORMAL CASE
  LD A,(FANSII)         ;SEE IF FORCED FIXED OUTPUT
  OR A                  ;SET CONDITION CODES CORRECTLY
  JP P,FOFV5A           ;DO NORMAL THING
  POP AF
  ADD A,D
  JR FOUFV6             ;FIXED OUTPUT
  
FOFV5A:
  POP AF                ;NORMAL ROUTE
  ADD A,D               ;SEE IF NUMBER SHOULD BE PRINTED IN E NOTATION
  JP M,FOFRS1           ;IT SHOULD, IT IS .LT. .01
  INC D                 ;CHECK IF IT IS TOO BIG
  CP D
  JR NC,FOFRS1          ;IT IS TOO BIG, IT IS .GT. 10^D-1
FOUFV6:
  INC A                 ;IT IS OK FOR FIXED POINT NOTATION
  LD B,A                ;SET DECIMAL POINT COUNT
  LD A,$02              ;SET FIXED POINT FLAG, THE EXPONENT IS ZERO
                        ; IF WE ARE USING FIXED POINT NOTATION
FOFRS1:
  SUB $02               ;E NOTATION: ADD D-2 TO ORIGINAL EXPONENT
                        ;RESTORE EXP IF NOT D.P.
  POP HL                ;GET THE BUFFER POINTER BACK
  PUSH AF               ;SAVE THE EXPONENT FOR LATER
  CALL FOUTAN           ;.01 .LE. NUMBER .LT. .1?
  LD (HL),'0'           ;YES, PUT ".0" IN BUFFER
  CALL Z,INCHL
  CALL FOUTCV           ;CONVERT THE NUMBER TO DECIMAL DIGITS

	;HERE TO SUPPRESS THE TRAILING ZEROS
SUPTLZ:
  DEC HL                ; Move back through buffer         ;MOVE BACK TO THE LAST CHARACTER
  LD A,(HL)             ; Get character                    ;GET IT AND SEE IF IT WAS ZERO
  CP '0'                ; "0" character?
  JR Z,SUPTLZ           ; Yes - Look back for more         ;IT WAS, CONTINUE SUPPRESSING
  CP '.'                ; A decimal point?                 ;HAVE WE SUPPRESSED ALL THE FRACTIONAL DIGITS?
  CALL NZ,INCHL         ; Move back over digit             ;YES, IGNORE THE DECIMAL POINT ALSO
  POP AF                ; Get "E" flag                     ;GET THE EXPONENT BACK
  JR Z,NOENED           ; No "E" needed - End buffer       ;WE ARE DONE IF WE ARE IN FIXED POINT NOTATION
                                                           ;FALL IN AND PUT THE EXPONENT IN THE BUFFER

; a.k.a. FOFLDN
;
	;HERE TO PUT THE EXPONENT AND "E" OR "D" IN THE BUFFER
	;THE EXPONENT IS IN A, THE CONDITION CODES ARE ASSUMED TO BE SET
	;CORRECTLY.
;
; This entry point is used by the routine at FOUBE3.
DOEBIT:
  PUSH AF                                                  ;SAVE THE EXPONENT
  CALL GETYPR                                              ;SET CARRY FOR SINGLE PRECISION
  LD A,$22              ; 'D'/2                            ;[A]="D"/2
  ADC A,A               ; 'D' (?) or 'E'                   ;MULTIPLY BY 2 AND ADD CARRY
  LD (HL),A             ; Put "E" in buffer                ;SAVE IT IN THE BUFFER
  INC HL                ; And move on                      ;INCREMENT THE BUFFER POINTER

	;PUT IN THE SIGN OF THE EXPONENT
  POP AF                                                   ;GET THE EXPONENT BACK
  LD (HL),'+'           ; Put '+' in buffer                ;A PLUS IF POSITIVE
  JP P,OUTEXP           ; Positive - Output exponent
  LD (HL),'-'           ; Put "-" in buffer                ;A MINUS IF NEGATIVE
  CPL                   ; Negate exponent                  ;NEGATE EXPONENT
  INC A

	;CALCULATE THE TWO DIGIT EXPONENT
OUTEXP:
  LD B,'0'-1            ; ASCII "0" - 1                    ;INITIALIZE TEN'S DIGIT COUNT
EXPTEN:
  INC B                 ; Count subtractions               ;INCREMENT DIGIT
  SUB 10                ; Tens digit                       ;SUBTRACT TEN
  JR NC,EXPTEN          ; More to do                       ;DO IT AGAIN IF RESULT WAS POSITIVE
  ADD A,'0'+10          ; Restore and make ASCII           ;ADD BACK IN TEN AND CONVERT TO ASCII

	;PUT THE EXPONENT IN THE BUFFER
  INC HL                ; Move on                          
  LD (HL),B             ; Save MSB of exponent             ;PUT TEN'S DIGIT OF EXPONENT IN BUFFER
  INC HL                                                   ;WHEN WE JUMP TO HERE, A IS ZERO
  LD (HL),A             ; Save LSB of exponent             ;PUT ONE'S DIGIT IN BUFFER
                                                           
FOUTZR:
  INC HL                ;INCREMENT POINTER, HERE TO FINISH UP

	; PRINTING A FREE FORMAT ZERO
NOENED:
  LD (HL),$00           ;PUT A ZERO AT THE END OF THE NUMBER
  EX DE,HL              ;SAVE THE POINTER TO THE END OF THE NUMBER IN (DE) FOR FFXFLV
  LD HL,FBUFFR+1        ;GET A POINTER TO THE BEGINNING    ; Buffer for fout + 1
  RET                   ;ALL DONE


	;HERE TO PRINT A NUMBER IN FIXED FORMAT
FOUTFX:
  INC HL                ;MOVE PAST THE ZERO FOR THE DOLLAR SIGN
  PUSH BC               ;SAVE THE FIELD LENGTH SPECIFICATIONS
  CP $04                ;CHECK WHAT KIND OF VALUE WE HAVE
  LD A,D                ;GET THE FORMAT SPECS
  JR NC,FOUFXV          ;WE HAVE A SNG OR A DBL
  
	;HERE TO PRINT AN INTEGER IN FIXED FORMAT
  RRA                   ;CHECK IF WE HAVE TO PRINT IT IN FLOATING
  JP C,FFXIFL           ; POINT NOTATION

	;HERE TO PRINT AN INTEGER IN FIXED FORMAT-FIXED POINT NOTATION
  LD BC,$0603           ;SET DECIMAL POINT COUNT TO 6 AND COMMA COUNT TO 3
  CALL FOUICC           ;CHECK IF WE DON'T HAVE TO USE THE COMMAS
  POP DE                ;GET THE FIELD LENGTHS
  LD A,D                ;SEE IF WE HAVE TO PRINT EXTRA SPACES BECAUSE
  SUB $05               ; THE FIELD IS TOO BIG
  CALL P,FOTZER         ;WE DO, PUT IN ZEROS, THEY WILL LATER BE CONVERTED TO SPACES OR ASTERISKS BY FOUTZS
  CALL FOUTCI           ;CONVERT THE NUMBER TO DECIMAL DIGITS

; This entry point is used by the routine at FOUBE3.
FOUTTD:
  LD A,E                ;DO WE NEED A DECIMAL POINT?
  OR A                  
  CALL Z,DCXHRT         ;WE DON'T, BACKSPACE OVER IT.
  DEC A                 ;GET HOW MANY TRAILING ZEROS TO PRINT
  CALL P,FOTZER         ;PRINT THEM
                        ;IF WE DO HAVE DECIMAL PLACES, FILL THEM UP WITH ZEROS
                        ;FALL IN AND FINISH UP THE NUMBER


	;HERE TO FINISH UP A FIXED FORMAT NUMBER
; This entry point is used by the routine at FOUBE3.
FOUTTS:
  PUSH HL               ;SAVE BUFFER POINTER
  CALL FOUTZS           ;ZERO SUPPRESS THE NUMBER
  POP HL                ;GET THE BUFFER POINTER BACK
  JR Z,FFXIX1           ;CHECK IF WE HAVE A TRAILING SIGN
  LD (HL),B             ;WE DO, PUT THE SIGN IN THE BUFFER
  INC HL                ;INCREMENT THE BUFFER POINTER
FFXIX1:
  LD (HL),$00           ;PUT A ZERO AT THE END OF THE NUMBER


	;HERE TO CHECK IF A FIXED FORMAT-FIXED POINT NUMBER OVERFLOWED ITS
	;FIELD LENGTH
	;D = THE B IN THE FORMAT SPECIFICATION
	;THIS ASSUMES THE LOCATION OF THE DECIMAL POINT IS IN TEMP2

  LD HL,FBUFFR          ;GET A POINTER TO THE BEGINNING
FOUBE1:
  INC HL                ;INCREMENT POINTER TO THE NEXT CHARACTER
; This entry point is used by the routine at FOUBE3.
FOUBE5:
  LD A,(NXTOPR)         ;GET THE LOCATION OF THE DECIMAL POINT

	;SINCE FBUFFR IS ONLY 35 (DECIMAL) LONG, WE
	; ONLY HAVE TO LOOK AT THE LOW ORDER TO SEE
	; IF THE FIELD IS BIG ENOUGH
  SUB L                 ;FIGURE OUT HOW MUCH SPACE WE ARE TAKING
  SUB D                 ;IS THIS THE RIGHT AMOUNT OF SPACE TO TAKE?
  RET Z                 ;YES, WE ARE DONE, RETURN FROM FOUT
  LD A,(HL)             ;NO, WE MUST HAVE TOO MUCH SINCE WE STARTED

	; CHECKING FROM THE BEGINNING OF THE BUFFER
	; AND THE FIELD MUST BE SMALL ENOUGH TO FIT IN THE BUFFER.
	; GET THE NEXT CHARACTER IN THE BUFFER.
  CP ' '                ;IF IT IS A SPACE OR AN ASTERISK, WE CAN
  JR Z,FOUBE1           ; IGNORE IT AND MAKE THE FIELD SHORTER WITH
  CP '*'                ; NO ILL EFFECTS
  JR Z,FOUBE1
  DEC HL                ;MOVE THE POINTER BACK ONE TO READ THE CHARACTER WITH CHRGET
  PUSH HL               ;SAVE THE POINTER


	;HERE WE SEE IF WE CAN IGNORE THE LEADING ZERO BEFORE A DECIMAL POINT.
	;THIS OCCURS IF WE SEE THE FOLLOWING: (IN ORDER)
	;	+,-	A SIGN (EITHER "-" OR "+")	[OPTIONAL]
	;	$	A DOLLAR SIGN			[OPTIONAL]
	;	0	A ZERO				[MANDATORY]
	;	.	A DECIMAL POINT			[MANDATORY]
	;	0-9	ANOTHER DIGIT			[MANDATORY]
	;IF YOU SEE A LEADING ZERO, IT MUST BE THE ONE BEFORE A DECIMAL POINT
	;OR ELSE FOUTZS WOULD HAVE SUPPRESSED IT, SO WE CAN JUST "INX	H"
	;OVER THE CHARACTER FOLLOWING THE ZERO, AND NOT CHECK FOR THE
	;DECIMAL POINT EXPLICITLY.
FOUBE2:
  PUSH AF               ;PUT THE LAST CHARACTER ON THE STACK.
                        ;THE ZERO FLAG IS SET.
                        ;THE FIRST TIME THE ZERO ZERO FLAG IS NOT SET.
  LD BC,FOUBE2          ;GET ADDRESS WE GO TO IF WE SEE A CHARACTER
  PUSH BC               ; WE ARE LOOKING FOR
  CALL CHRGTB           ;GET THE NEXT CHARACTER
  CP '-'                ;SAVE IT AND GET THE NEXT CHARACTER IF IT IS
  RET Z                 ; A MINUS SIGN, A PLUS SIGN OR A DOLLAR SIGN
  CP '+'
  RET Z 
  CP '$'
  RET Z 
  POP BC                ;IT ISN'T, GET THE ADDRESS OFF THE STACK
  CP '0'                ;IS IT A ZERO?
  JR NZ,FOUBE4          ;NO, WE CAN NOT GET RID OF ANOTHER CHARACTER
  INC HL                ;SKIP OVER THE DECIMAL POINT
  CALL CHRGTB           ;GET THE NEXT CHARACTER
  JR NC,FOUBE4          ;IT IS NOT A DIGIT, WE CAN'T SHORTEN THE FIELD
  DEC HL                ;WE CAN!!!  POINT TO THE DECIMAL POINT
  DEFB $01              ; "LD BC,nn" OVER THE NEXT 2 BYTES

; Routine at 13142
FOUBE3:
  DEC HL                ;POINT BACK ONE CHARACTER
  LD (HL),A             ;PUT THE CHARACTER BACK


	;IF WE CAN GET RID OF THE ZERO, WE PUT THE CHARACTERS ON THE STACK
	;BACK INTO THE BUFFER ONE POSITION IN FRONT OF WHERE THEY ORIGINALLY
	;WERE.  NOTE THAT THE MAXIMUM NUMBER OF STACK LEVELS THIS USES IS
	;THREE -- ONE FOR THE LAST ENTRY FLAG, ONE FOR A POSSIBLE SIGN,
	;AND ONE FOR A POSSIBLE DOLLAR SIGN.  WE DON'T HAVE TO WORRY ABOUT
	;THE FIRST CHARACTER BEING IN THE BUFFER TWICE BECAUSE THE POINTER
	;WHEN FOUT EXITS WILL BE POINTING TO THE SECOND OCCURANCE.
  POP AF                ;GET THE CHARACTER OFF THE STACK
  JR Z,FOUBE3           ;PUT IT BACK IN THE BUFFER IF IT IS NOT THE LAST ONE
  POP BC                ;GET THE BUFFER POINTER OFF THE STACK
  JR FOUBE5             ;SEE IF THE FIELD IS NOW SMALL ENOUGH

	;HERE IF THE NUMBER IS TOO BIG FOR THE FIELD
; This entry point is used by the routine at L3338.
FOUBE4:
  POP AF                ;GET THE CHARACTERS OFF THE STACK
  JR Z,FOUBE4           ;LEAVE THE NUMBER IN THE BUFFER ALONE
  POP HL                ;GET THE POINTER TO THE BEGINNING OF THE NUMBER MINUS 1
  LD (HL),'%'           ;PUT IN A PERCENT SIGN TO INDICATE THE NUMBER WAS TOO LARGE FOR THE FIELD
  RET                   ;ALL DONE -- RETURN FROM FOUT


	;HERE TO PRINT A SNG OR DBL IN FIXED FORMAT
; This entry point is used by the routine at PUFOUT.
FOUFXV:
  PUSH HL               ;SAVE THE BUFFER POINTER
  RRA                   ;GET FIXED OR FLOATING NOTATION FLAG IN CARRY
  JP C,FFXFLV           ;PRINT THE NUMBER IN E-NOTATION
  JR Z,FFXSFX           ;WE HAVE A SNG HERE TO PRINT A DBL IN FIXED FORMAT--FIXED POINT NOTATION
  LD DE,FP_FFXDXM       ;GET POINTER TO 1D16
  CALL CMPPHL           ;WE CAN'T PRINT A NUMBER .GE. 10^16 IN FIXED POINT NOTATION
  LD D,$10              ;SET D = NUMBER OF DIGITS TO PRINT FOR A DBL
  JP M,FFXSDC           ;IF THE FAC WAS SMALL ENOUGH, GO PRINT IT

	;HERE TO PRINT IN FREE FORMAT WITH A PERCENT SIGN A NUMBER .GE. 10^16
FFXSDO:
  POP HL                ;GET THE BUFFER POINTER OFF THE STACK
  POP BC                ;GET THE FIELD SPECIFICATION OFF THE STACK
  CALL FOUT             ;PRINT THE NUMBER IN FREE FORMAT
  DEC HL                ;POINT TO IN FRONT OF THE NUMBER
  LD (HL),'%'           ;PUT IN THE PERCENT SIGN
  RET                   ;ALL DONE--RETURN FROM FOUT

	;HERE TO PRINT A SNG IN FIXED FORMAT--FIXED POINT NOTATION
FFXSFX:
  LD BC,$B60E           ; (10000000000000000) GET 1E16, CHECK IF THE NUMBER IS TOO BIG
  LD DE,$1BCA
  CALL FCOMP
  JP P,FFXSDO           ;IT IS, PRINT IT IN FREE FORMAT WITH A % SIGN
  LD D,$06              ;D = NUMBER OF DIGITS TO PRINT IN A SNG

	;HERE TO ACTUALLY PRINT A SNG OR DBL IN FIXED FORMAT
FFXSDC:
  CALL SIGN             ;SEE IF WE HAVE ZERO
  CALL NZ,FOUTNV        ;IF NOT, NORMALIZE THE NUMBER SO ALL DIGITS TO BE PRINTED ARE IN THE INTEGER PART
  POP HL                ;GET THE BUFFER POINTER
  POP BC                ;GET THE FIELD LENGTH SPECS
  JP M,FFXXVS           ;DO DIFFERENT STUFF IF EXPONENT IS NEGATIVE

	;HERE TO PRINT A NUMBER WITH NO FRACTIONAL DIGITS
  PUSH BC               ;SAVE THE FIELD LENGTH SPECS AGAIN
  LD E,A                ;SAVE THE EXPONENT IN E
  LD A,B                ;WE HAVE TO PRINT LEADING ZEROS IF THE FIELD
  SUB D                 ; HAS MORE CHARACTERS THAN THERE ARE DIGITS
  SUB E                 ; IN THE NUMBER.

	; IF WE ARE USING COMMAS, A MAY BE TOO BIG.
	; THIS DOESN'T MATTER BECAUSE FOUTTS WILL FIND THE CORRECT BEGINNING.
	; THERE IS ROOM IN FBUFFR BECAUSE THE MAXIMUM VALUE B CAN BE IS
	; 24 (DECIMAL) SO D+C .LE. 16 (DECIMAL)  SINCE FAC .LT. 10^16.
	; SO WE NEED 8 MORE BYTES FOR ZEROS.
	; 4 COME SINCE WE WILL NOT NEED TO PRINT AN EXPONENT.
	; FBUFFR ALSO CONTAINS AN EXTRA 4 BYTES FOR THIS CASE.
	;(IT WOULD TAKE MORE THAN 4 BYTES TO CHECK FOR THIS.)

  CALL P,FOTZER         ;FOUTZS WILL LATER SUPPRESS THEM
  CALL FOUTCD           ;SETUP DECIMAL POINT AND COMMA COUNT
  CALL FOUTCV           ;CONVERT THE NUMBER TO DECIMAL DIGITS
  OR E                  ;PUT IN DIGITS AFTER THE NUMBER IF IT IS BIG ENOUGH, HERE A=0
  CALL NZ,FOTZEC        ;THERE CAN BE COMMAS IN THESE ZEROS
  OR E                  ;MAKE SURE WE GET A DECIMAL POINT FOR FOUTTS
  CALL NZ,FOUTED
  POP DE                ;GET THE FIELD LENGTH SPECS
  JP FOUTTD             ;GO CHECK THE SIZE, ZERO SUPPRESS, ETC. AND FINISH THE NUMBER

	;HERE TO PRINT A SNG OR DBL THAT HAS FRACTIONAL DIGITS
FFXXVS:
  LD E,A                ;SAVE THE EXPONENT
  LD A,C                ;DIVIDE BY TEN THE RIGHT NUMBER OF TIMES SO
  OR A                  ; THE RESULT WILL BE ROUNDED CORRECTLY AND
  CALL NZ,DCRART        ; HAVE THE CORRECT NUMBER OF SIGNIFICANT
  ADD A,E               ; DIGITS
  JP M,FFXXV8           ;FOR LATER CALCULATIONS, WE WANT A ZERO IF THE
  XOR A                 ; RESULT WAS NOT NEGATIVE
FFXXV8:
  PUSH BC               ;SAVE THE FIELD SPECS
  PUSH AF               ;SAVE THIS NUMBER FOR LATER
FFXXV2:
  CALL M,FINDIV         ;THIS IS THE DIVIDE LOOP
  JP M,FFXXV2
  POP BC                ;GET THE NUMBER WE SAVED BACK IN B
  LD A,E                ;WE HAVE TWO CASES DEPENDING ON WHETHER THE
  SUB B                 ; THE NUMBER HAS INTEGER DIGITS OR NOT
  POP BC                ;GET THE FILED SPECS BACK
  LD E,A                ;SAVE HOW MANY DECIMAL PLACES BEFORE THE
  ADD A,D               ; THE NUMBER ENDS
  LD A,B                ;GET THE "B" FIELD SPEC
  JP M,FFXXV3

	;HERE TO PRINT NUMBERS WITH INTEGER DIGITS
  SUB D                 ;PRINT SOME LEADING ZEROS IF THE FIELD IS
  SUB E                 ; BIGGER THAN THE NUMBER OF DIGITS WE WILL
  CALL P,FOTZER         ; PRINT
  PUSH BC               ;SAVE FIELD SPEC
  CALL FOUTCD           ;SET UP DECIMAL POINT AND COMMA COUNT
  JR FFXXV6             ;CONVERT THE DIGITS AND DO THE TRIMMING UP

	;HERE TO PRINT A NUMBER WITHOUT INTEGER DIGITS
FFXXV3:
  CALL FOTZER           ;PUT ALL ZEROS BEFORE THE DECIMAL POINT
  LD A,C                ;SAVE C
  CALL FOUTDP           ;PUT IN A DECIMAL POINT
  LD C,A                ;RESTORE C
  XOR A                 ;DECIDE HOW MANY ZEROS TO PRINT BETWEEN THE
  SUB D                 ; DECIMAL POINT AND THE FIRST DIGIT WE WILL
  SUB E                 ; PRINT.
  CALL FOTZER           ;PRINT THE ZEROS
  PUSH BC               ;SAVE EXPONENT AND THE "C" IN THE FIELD SPEC
  LD B,A                ;ZERO THE DECIMAL PLACE COUNT
  LD C,A                ;ZERO THE COMMA COUNT
FFXXV6:
  CALL FOUTCV           ;CONVERT THE NUMBER TO DECIMAL DIGITS
  POP BC                ;GET THE FIELD SPECS BACK
  OR C                  ;CHECK IF WE HAVE TO PRINT ANY ZEROS AFTER THE LAST DIGIT
  JR NZ,FFXXV7          ;CHECK IF THERE WERE ANY DECIMAL PLACES AT ALL
                        ;E CAN NEVER BE 200, (IT IS NEGATIVE) SO IF
                        ; A=0 HERE, THERE IS NO WAY WE WILL CALL FOTZER 
  LD HL,(NXTOPR)        ;THE END OF THE NUMBER IS WHERE THE DP IS
FFXXV7:
  ADD A,E               ;PRINT SOME MORE TRAILING ZEROS
  DEC A
  CALL P,FOTZER
  LD D,B                ;GET THE "B" FIELD SPEC IN D FOR FOUTTS
  JP FOUTTS             ;FINISH UP THE NUMBER

	;HERE TO PRINT AN INTEGER IN FIXED FORMAT--FLOATING POINT NOTATION
; This entry point is used by the routine at PUFOUT.
FFXIFL:
  PUSH HL               ;SAVE THE BUFFER POINTER
  PUSH DE               ;SAVE THE FORMAT SPECS
  CALL CONSI            ;CONVERT THE INTEGER TO A SNG
  POP DE                ;GET THE FORMAT SPECS BACK
  XOR A                 ;SET FLAGS TO PRINT THE NUMBER AS A SNG
                        ;FALL INTO FFXFLV
FFXFLV:
  JR Z,FFXSFL           ;IF WE HAVE A SNG, SET THE RIGHT FLAGS
  LD E,$10              ;WE HAVE A DBL, GET HOW MANY DIGITS WE HAVE

  DEFB $01              ; "LD BC,nn" OVER THE NEXT TWO BYTES

FFXSFL:
  LD E,$06              ;WE HAVE A SNG, GET HOW MANY DIGITS WE PRINT

  CALL SIGN             ;SEE IF WE HAVE ZERO
  SCF                   ;SET CARRY TO DETERMINE IF WE ARE PRINTING ZERO.
                        ; NOTE: THIS DEPENDS ON THE FACT THAT FOUTNV EXITS WITH CARRY OFF
  CALL NZ,FOUTNV        ;IF NOT, NORMALIZE THE NUMBER SO ALL DIGITS TO BE PRINTED ARE IN THE INTEGER PART
  POP HL                ;GET THE BUFFER POINTER BACK
  POP BC                ;GET THE FIELD LENGTH SPECS
  PUSH AF               ;SAVE THE EXPONENT
  LD A,C                ;CALCULATE HOW MANY SIGNIFICANT DIGITS WE MUST
  OR A                  ; PRINT
  PUSH AF               ;SAVE THE "C" FIELD SPEC FOR LATER
  CALL NZ,DCRART
  ADD A,B
  LD C,A
  LD A,D                ;GET THE "A" FIELD SPEC
  AND $04               ;SEE IF THE SIGN IS A TRAILING SIGN
  CP $01                ;SET CARRY IF A IS ZERO
  SBC A,A               ;SET D=0 IF WE HAVE A TRAILING SIGN,
  LD D,A                ; D=377 ($FF) IF WE DO NOT
  ADD A,C
  LD C,A                ;SET C=NUMBER OF SIGNIFICANT DIGITS TO PRINT
  SUB E                 ;IF WE HAVE LESS THAN E, THEN WE MUST GET RID
  PUSH AF               ;SAVE COMPARISON # OF SIG DIGITS AND THE # OF DIGITS WE WILL PRINT
  PUSH BC               ;SAVE THE "B" FIELD SPEC AND # OF SIG DIGITS
FFXLV1:
  CALL M,FINDIV         ; OF SOME BY DIVIDING BY TEN AND ROUNDING
  JP M,FFXLV1
  POP BC                ;GET "B" FIELD SPEC AND # OF SIG DIGITS BACK
  POP AF                ;GET # OF TRAILING ZEROS TO PRINT
  PUSH BC               ;SAVE THE "B" FIELD SPEC AND # OF SIG DIGITS
  PUSH AF               ;SAVE # OF TRAILING ZEROS TO PRINT
  JP M,FFXLV3           ;TAKE INTO ACCOUNT DIGITS THAT WERE
  XOR A                 ;DIVIDED OFF AT FFXLV1
FFXLV3:
  CPL
  INC A
  ADD A,B               ;SET THE DECIMAL PLACE COUNT
  INC A                 
  ADD A,D               ;TAKE INTO ACCOUNT IF THE SIGN IS TRAILING
  LD B,A                ; OR NOT
  LD C,$00              ;SET COMMA COUNT TO ZERO, THE COMMA SPEC IS IGNORED.
  CALL FOUTCV           ;CONVERT THE NUMBER TO DECIMAL DIGITS
  POP AF                ;GET NUMBER TRAILING ZEROS TO PRINT

	;IF THE FIELD LENGTH IS LONGER THAN THE # OF DIGITS
	;WE CAN PRINT
  CALL P,FOTZNC         ;THE DECIMAL POINT COULD COME OUT IN HERE
  CALL FOUTED           ;IN CASE D.P. IS LAST ON LIST
  POP BC                ;GET # OF SIG DIGITS AND "B" FIELD SPAC BACK
  POP AF                ;GET THE "C" FIELD SPEC BACK
  JR NZ,FFXLV4          ;IF NON-ZERO PROCEED
  CALL DCXHRT           ;SEE IF D.P. THERE
  LD A,(HL)             ;FETCH TO MAKE SURE D.P.
  CP '.'                ;IF NOT MUST BE ZERO
  CALL NZ,INCHL         ;IF NOT MUST LEAVE AS IS
  LD (NXTOPR),HL        ;NEED D.P. LOCATION IN TEMP2
FFXLV4:                 ; SO IGNORE IT.
  POP AF                ;GET THE EXPONENT BACK
  JR C,FFXLV2           ;EXPONENT=0 IF THE NUMBER IS ZERO
  ADD A,E               ;SCALE IT CORRECTLY
  SUB B
  SUB D
FFXLV2:
  PUSH BC               ;SAVE THE "B" FIELD SPEC
  CALL DOEBIT           ;PUT THE EXPONENT IN THE BUFFER
  EX DE,HL              ;GET THE POINTER TO THE END IN (HL) IN CASE WE HAVE A TRAILING SIGN
  POP DE                ;GET THE "B" FIELD SPEC IN D, PUT ON A
  JP FOUTTS             ; POSSIBLE TRAILING SIGN AND WE ARE DONE


	;NORMALIZE THE NUMBER IN THE FAC SO ALL THE DIGITS ARE IN THE INTEGER
	;PART.  RETURN THE BASE 10 EXPONENT IN A
	;D,E ARE LEFT UNALTERED
; This entry point is used by the routine at PUFOUT.
FOUTNV:
  PUSH DE               ;SAVE (DE)
  XOR A                 ;ZERO THE EXPONENT
  PUSH AF               ;SAVE IT
  CALL GETYPR           ;GET TYPE OF NUMBER TO BE PRINTED
  JP PO,FOUNDB          ;NOT DOUBLE, DO NORMAL THING
FORBIG:
  LD A,(FPEXP)          ;GET EXPONENT
  CP $91                ;IS IT .LT.1D5?
  JR NC,FOUNDB          ;NO, DONT MULTPLY
  LD DE,FP_TENTEN       ;MULTIPLY BY 1D10
  LD HL,FPARG           ;MOVE INTO ARG
  CALL VMOVE            ;PUT IN ARG
  CALL DMUL             ;MULTIPLY BY IT
  POP AF                ;GET ORIG EXPONENT OFF STACK
  SUB 10                ;GET PROPER OFFSET FOR EXPONENT
  PUSH AF               ;SAVE EXPONENT BACK
  JR FORBIG             ;FORCE IT BIGGER IF POSSIBLE

FOUNDB:
  CALL RNGTST           ;IS THE FAC TOO BIG OR TOO SMALL?        ; Test number is in range
SIXDIG:
  CALL GETYPR           ;SEE WHAT KIND OF VALUE WE HAVE SO WE CAN SEE IF THE FAC IS BIG ENOUGH
  JP PE,FOUNV4          ;WE HAVE A DBL
  LD BC,$9143           ;GET 99999.95 TO SEE IF THE FAC IS BIG
  LD DE,$4FF9
  CALL FCOMP            ; ENOUGH YET
  JR FOUNV5             ;GO DO THE CHECK

FOUNV4:
  LD DE,FP_FOUTDL       ;GET POINTER TO 999,999,999,999,999.5
  CALL CMPPHL           ;SEE IF THE NUMBER IS STILL TOO SMALL
FOUNV5:
  JP P,FOUNV3           ;IT ISN'T ANY MORE, WE ARE DONE
  POP AF                ;IT IS, MULTIPLY BY TEN
  CALL MULTEN
  PUSH AF               ;SAVE THE EXPONENT AGAIN
  JR SIXDIG             ;NOW SEE IF IT IS BIG ENOUGH

; This entry point is used by the routine at RNGTST.
FOUNV2:
  POP AF                ;THE FAC IS TOO BIG, GET THE EXPONENT
  CALL FINDIV           ;DIVIDE IT BY TEN
  PUSH AF               ;SAVE THE EXPONENT AGAIN
  CALL RNGTST           ;SEE IF THE FAC IS SMALL ENOUGH
FOUNV3:
  POP AF                ;WE ARE DONE, GET THE EXPONENT BACK
  OR A                  ;CLEAR CARRY
  POP DE                ;GET (DE) BACK
  RET                   ;ALL DONE


	;HERE TO SEE IF THE FAC IS SMALL ENOUGH YET
; Test number is in range, a.k.a. FOUNVC
; Routine at 13513
; Used by the routine at FOUNDB.
RNGTST:
  CALL GETYPR           ;SEE WHAT TYPE NUMBER WE HAVE
  JP PE,RNGTST_0        ;WE HAVE A DBL
  LD BC,$9474           ;GET 999999.5 TO SEE IF THE FAC IS TOO BIG
  LD DE,$23F8
  CALL FCOMP
  JR RNGTST_1           ;GO DO THE CHECK
RNGTST_0:
  LD DE,FP_FOUTDU       ;GET POINTER TO 9,999,999,999,999,999.5
  CALL CMPPHL           ;SEE IF THE NUMBER IS TOO BIG
RNGTST_1:
  POP HL                ;GET THE RETURN ADDRESS OFF THE STACK
  JP P,FOUNV2           ;THE NUMBER IS TOO BIG, DIVIDE IT BY TEN
  JP (HL)               ;IT ISN'T TOO BIG, JUST RETURN


	;HERE TO PUT SOME ZEROS IN THE BUFFER
	;THE COUNT IS IN A, IT CAN BE ZERO, BUT THE ZERO FLAG MUST BE SET
	;ONLY (HL) AND A ARE ALTERED
	;WE EXIT WITH A=0
; This entry point is used by the routines at PUFOUT and FOUBE3.
FOTZER:
  OR A                  ;THIS IS BECAUSE FFXXV3 CALL US WITH THE CONDITION CODES NOT SET UP
FOTZR1:
  RET Z                 ;RETURN IF WE ARE DONE
  DEC A                 ;WE ARE NOT DONE, SO DECREMENT THE COUNT
  LD (HL),'0'           ;PUT A ZERO IN THE BUFFER
  INC HL                ;UPDATE THE BUFFER POINTER
  JR FOTZR1             ;GO SEE IF WE ARE NOW DONE


	;HERE TO PUT ZEROS IN THE BUFFER WITH COMMAS OR A DECIMAL POINT IN THE MIDDLE.  
	;THE COUNT IS IN A, IT CAN BE ZERO, BUT THE ZERO FLAG MUST BE SET.
	;B THE DECIMAL POINT COUNT AND C THE COMMA COUNT ARE UPDATED
	;A,B,C,H,L ARE ALTERED
; This entry point is used by the routine at FOUBE3.
FOTZNC:
  JR NZ,FOTZEC          ;ENTRY AFTER A "CALL FOUTCV"
FOTZRC:
  RET Z                 ;RETURN IF WE ARE DONE
  CALL FOUTED           ;SEE IF WE HAVE TO PUT A COMMA OR A DECIMAL POINT BEFORE THIS ZERO
FOTZEC:
  LD (HL),'0'           ;PUT A ZERO IN THE BUFFER
  INC HL                ;UPDATE THE BUFFER POINTER
  DEC A                 ;DECREMENT THE ZERO COUNT
  JR FOTZRC             ;GO BACK AND SEE IF WE ARE DONE


	;HERE TO PUT A POSSIBLE COMMA COUNT IN C, AND ZERO C IF WE ARE NOT
	;USING THE COMMA SPECIFICATION
; This entry point is used by the routine at FOUBE3.
FOUTCD:
  LD A,E                ;SETUP DECIMAL POINT COUNT
  ADD A,D
  INC A
  LD B,A
  INC A                 ;SETUP COMMA COUNT
FOUTCD_0:
  SUB $03               ;REDUCE [A] MOD 3
  JR NC,FOUTCD_0
  ADD A,$05             ;ADD 3 BACK IN AND ADD 2 MORE FOR SCALING
  LD C,A                ;SAVE A POSSIBLE COMMA COUNT

; This entry point is used by the routine at PUFOUT.
FOUICC:
  LD A,(TEMP3)          ;GET THE FORMAT SPECS
  AND $40               ;LOOK AT THE COMMA BIT
  RET NZ                ;WE ARE USING COMMAS, JUST RETURN
  LD C,A                ;WE AREN'T, ZERO THE COMMA COUNT
  RET                   ;ALL DONE


;*****************************************************************
;
;       $FOUTAN  THIS ROUTINE IS CALLED BY THE FREE FORMAT OUTPUT
;               CODE TO OUTPUT DECIMAL POINT AND LEADING ZEROS.
;       $FOUTED  THIS ROUTINE IS CALLED BY BOTH THE FREE FORMAT
;               OUTPUT ROUTINE AND THE PRINT USING CODE TO OUTPUT
;               THE DECIMAL POINT WHEN NECESSARY AND TO PUT IN
;               COMMAS "," AFTER EACH THREE DIGITS IF THIS OPTION
;               IS INVOKED.
;       CALLING SEQUENCE:       CALL    $FOUTAN
;                               CALL    $FOUTED
;               WITH $FMTCX CONTAINING NUMBER PLACES PRIOR TO
;               DECIMAL POINT(NEGATIVELY) IN UPPER BYTE AND
;               NO PLACES BEFORE NEXT COMMA IN LOW BYTE
;
;*******************************************************************


	;HERE TO PUT DECIMAL POINTS AND COMMAS IN THEIR CORRECT PLACES
	;THIS SUBROUTINE SHOULD BE CALLED BEFORE THE NEXT DIGIT IS PUT IN THE
	;BUFFER.  B=THE DECIMAL POINT COUNT, C=THE COMMA COUNT
	;THE COUNTS TELL HOW MANY MORE DIGITS HAVE TO GO IN BEFORE THE COMMA
	;OR DECIMAL POINT GO IN.  THE COMMA OR DECIMAL POINT THEN GOES BEFORE 
	;THE LAST DIGIT IN THE COUNT.  FOR EXAMPLE, IF THE DECIMAL POINT SHOULD
	;COME AFTER THE FIRST DIGIT, THE DECIMAL POINT COUNT SHOULD BE 2.
; This entry point is used by the routine at PUFOUT.
FOUTAN:
  DEC B                 ;IF NEGATIVE THEN LEADING ZEROS
  JP P,FTD05                                                ;PROCESS AS NORMAL
  LD (NXTOPR),HL        ;SAVE DECIMAL POINT COUNT           ;SAVE LOCATION OF DECIMAL POINT
  LD (HL),'.'           ;MOVE IN DECIMAL POINT
FTN10:                 
  INC HL                ;POINT TO NEXT OUTPUT POSITION
  LD (HL),'0'           ;PUT IN LEADING ZERO
  INC B                 ;WILL INCREMENT B UNTIL ZERO
  JR NZ,FTN10          
  INC HL                ;PUT IN LEADING ZEROS UNTIL B ZERO
  LD C,B                ;POINT TO NEXT AVAILABLE BUFFER LOCATION
  RET

; This entry point is used by the routine at FOUBE3.
FOUTED:
  DEC B                 ;TIME FOR D.P.?
FTD05:                  
  JR NZ,FOUED1          ;IF NOT D.P. TIME, SEE IF COMMA TIME

	;ENTRY TO PUT A DECIMAL POINT IN THE BUFFER
; This entry point is used by the routine at FOUBE3.
FOUTDP:
  LD (HL),'.'           ;YES, PUT THE DECIMAL POINT IN
  LD (NXTOPR),HL        ;SAVE THE LOCATION OF THE DECIMAL POINT
  INC HL                ;INCREMENT THE BUFFER POINTER PAST D.P. 
  LD C,B                ;PUT ZERO IN C SO WE WON"T PRINT ANY COMMAS AFTER THE DECIMAL POINT.
  RET                   ;ALL DONE

;HERE TO SEE IF IT IS TIME TO PRINT A COMMA
FOUED1:
  DEC C                 ;IF ZERO TIME FOR COMMA
  RET NZ                ;NOPE, WE CAN RETURN
  LD (HL),','           ;YES, PUT A COMMA IN THE BUFFER
  INC HL                ;POINT TO NEXT BUFFER POSITION
  LD C,$03              ;RESET THE COMMA COUNT SO WE WILL PRINT A COMMA AFTER THREE MORE DIGITS.
  RET                   ;ALL DONE


	;HERE TO CONVERT A SNG OR DBL NUMBER THAT HAS BEEN NORMALIZED TO DECIMAL DIGITS.
	;THE DECIMAL POINT COUNT AND COMMA COUNT ARE IN B AND C RESPECTIVELY.
	;(HL) POINTS TO WHERE THE FIRST DIGIT WILL GO.
	;THIS EXITS WITH A=0.  (DE) IS LEFT UNALTERED.
; This entry point is used by the routines at PUFOUT and FOUBE3.
FOUTCV:
  PUSH DE               ;SAVE (DE)
  CALL GETYPR           ;SEE WHAT KIND OF A NUMBER WE HAVE
  JP PO,FOUTCS          ;WE HAVE A SNG

	;HERE TO CONVERT A DOUBLE PRECISION NUMBER TO DECIMAL DIGITS
  PUSH BC               ;SAVE THE DECIMAL POINT AND COMMA COUNTS
  PUSH HL               ;SAVE THE BUFFER POINTER
  CALL VMOVAF           ;MOVE THE FAC INTO ARG
  LD HL,DBL_FP_ZERO     ;GET POINTER TO .5D0
  CALL VMOVFM           ;MOVE THE CONSTANT INTO THE FAC
  CALL DADD             ;ADD .5 TO THE ORIGINAL NUMBER TO ROUND IT
  XOR A                 ;CLEAR THE CARRY
  CALL DINTFO           ;TAKE THE INTEGER PART OF THE NUMBER
                        ;THE NUMBER IS NOT NORMALIZED AFTERWARDS
  POP HL                ;GET THE BUFFER POINTER BACK
  POP BC                ;GET THE COMMA AND DECIMAL POINT COUNTS BACK
  LD DE,FP_POWERS_TAB   ;GET A POINTER TO THE DBL POWER OF TEN TABLE
  LD A,$0A              ;CONVERT TEN DIGITS, THE OTHERS WILL BE  CONVERTED AS SNG'S AND INT'S
                        ;BECAUSE WE BRACKETED THE NUMBER A POWER OF TEN LESS IN MAGNITUDE AND
                        ;SINGLE PRECISION CONVERSION CAN HANDLE A MAGNITUDE OF TEN LARGER

	;HERE TO CONVERT THE NEXT DIGIT
FOUCD1:
  CALL FOUTED           ;SEE IF WE HAVE TO PUT IN A DP OR COMMA
  PUSH BC               ;SAVE DP AND COMMA INFORMATION
  PUSH AF               ;SAVE DIGIT COUNT
  PUSH HL               ;SAVE BUFFER POINTER
  PUSH DE               ;SAVE POWER OF TEN POINTER
  LD B,'0'-1            ;SET UP THE COUNT FOR THE DIGIT
FOUCD2:
  INC B                 ;INCREMENT THE DIGIT COUNT
  POP HL                ;GET THE POINTER TO THE POWER OF TEN
  PUSH HL               ;SAVE IT AGAIN
  LD A,$9E			; SBC A,(HL)     GET THE INSTRUCTION TO SUBTRACT THE POWER OF TEN
  CALL DADDFO           ;GO SUBTRACT THEM
  JR NC,FOUCD2          ;IF THE NUMBER WAS NOT LESS THAN THE POWER OF TEN, SUBTRACT AGAIN
  POP HL                ;WE ARE DONE SUBTRACTING, BUT WE DID IT ONCE
  LD A,$8E			; ADC A,(HL)     GET THE INSTRUCTION TO ADD THE POWER OF TEN AND THE NUMBER
  CALL DADDFO           ;ADD THE TWO NUMBERS
  EX DE,HL              ;PUT THE POWER OF TEN POINTER IN (DE).  IT IS UPDATED FOR THE NEXT POWER OF TEN
  POP HL                ;GET THE BUFFER POINTER BACK
  LD (HL),B             ;PUT THE DIGIT INTO THE BUFFER
  INC HL                ;INCREMENT THE BUFFER POINTER
  POP AF                ;GET THE DIGIT COUNT BACK
  POP BC                ;GET THE DECIMAL POINT AND COMMA COUNTS
  DEC A                 ;HAVE WE PRINTED THE LAST DIGIT?
  JR NZ,FOUCD1          ;NO, GO DO THE NEXT ONE
  PUSH BC               ;YES, CONVERT REMAINING DIGITS USING SINGLE
  PUSH HL               ; PRECISION, THIS IS FASTER, MOVE THE NUMBER
  LD HL,FACLOW          ; THAT IS LEFT INTO THE SNG FAC
  CALL MOVFM
  JR FOUCDC

	;HERE TO CONVERT A SINGLE PRECISION NUMBER TO DECIMAL DIGITS
FOUTCS:
  PUSH BC               ;SAVE THE DECIMAL POINT AND COMMA COUNTS
  PUSH HL               ;SAVE THE BUFFER POINTER
  CALL FADDH            ;ROUND NUMBER TO NEAREST INTEGER
  LD A,$01              ;MAKE A NON-ZERO, SINCE NUMBER IS POSITIVE AND NON-ZERO, ROUND WILL EXIT WITH THE HO
                        ; IN A, SO THE MSB WILL ALWAYS BE ZERO AND ADDING ONE WILL NEVER CAUSE A TO BE ZERO

  CALL QINT             ;GET INTEGER PART IN C,D,E
  CALL FPBCDE           ;SAVE NUMBER IN FAC
FOUCDC:
  POP HL                ;GET THE BUFFER POINTER BACK
  POP BC                ;GET THE DECIMAL POINT AND COMMA COUNTS BACK
  XOR A                 ;CLEAR CARRY, THE CARRY IS OUR FLAG TO CALCULATE TWO DIGITS
  LD DE,POWERS_TAB      ;GET POINTER TO POWER OF TEN TABLE

	;HERE TO CALCULATE THE NEXT DIGIT OF THE NUMBER
FOUCS1:
  CCF                   ;COMPLEMENT FLAG THAT TELLS WHEN WE ARE DONE
  CALL FOUTED           ;SEE IF A COMMA OR DP GOES BEFORE THIS DIGIT
  PUSH BC               ;SAVE COMMA AND DECIMAL POINT INFORMATION
  PUSH AF               ;SAVE CARRY I.E. DIGIT COUNT
  PUSH HL               ;SAVE CHARACTER POINTER
  PUSH DE               ;SAVE POWER OF TEN POINTER
  CALL BCDEFP           ;GET NUMBER IN C,D,E
  POP HL                ;GET POWER OF TEN POINTER
  LD B,'0'-1            ;B = NEXT DIGIT TO BE PRINTED
FOUCS2:
  INC B                 ;ADD ONE TO DIGIT
  LD A,E                ;SUBTRACT LO
  SUB (HL)
  LD E,A
  INC HL                ;POINT TO NEXT BYTE OF POWER OF TEN
  LD A,D                ;SUBTRACT MO
  SBC A,(HL)
  LD D,A
  INC HL
  LD A,C                ;SUBTRACT HO
  SBC A,(HL)
  LD C,A
  DEC HL                ;POINT TO BEGINNING OF POWER OF TEN
  DEC HL
  JR NC,FOUCS2          ;SUBTRACT AGAIN IF RESULT WAS POSITIVE
  CALL PLUCDE           ;IT WASN'T, ADD POWER OF TEN BACK IN
  INC HL                ;INCREMENT POINTER TO NEXT POWER OF TEN
  CALL FPBCDE           ;SAVE C,D,E IN FAC
  EX DE,HL              ;GET POWER OF TEN POINTER IN (DE)
  POP HL                ;GET BUFFER POINTER
  LD (HL),B             ;PUT CHARACTER IN BUFFER
  INC HL                ;INCREMENT BUFFER POINTER
  POP AF                ;GET DIGIT COUNT (THE CARRY) BACK
  POP BC                ;GET COMMA AND DP INFORMATION BACK
  JR C,FOUCS1           ;CALCULATE NEXT DIGIT IF WE HAVE NOT DONE 2
  INC DE                ;WE HAVE, INCREMENT POINTER TO CORRECT PLACE
  INC DE                ; IN THE INTEGER POWER OF TEN TABLE
  LD A,$04              ;GET THE DIGIT COUNT
  JR FOUCI1             ;COMPUTE THE REST OF THE DIGITS LIKE INTEGERS
                        ;NOTE THAT THE CARRY IS OFF


;*************************************************************
;
;       $FOUTCI  CONVERT THE INTEGER IN (FACLO)-TWO BYTES TO
;               ASCII DIGITS.
;       CALLING SEQUENCE:       CALL    $FOUTCI
;               WITH DECIMAL POINT AND COMMA COUNTS IN (CX)
;       $FOUTO  CONVERT INTEGER IN $FACLO:FACLO+1 TO OCTAL
;       $FOUTH  CONVERT INTEGER IN $FACLO:FACLO+1 TO HEXIDECIMAL
;       CALLING SEQUENCE:       CALL    $FOUTO/$FOUTH
;               WITH $FACLO:FACLO+1 CONTAINING INTEGER TO BE
;               PRINTED. RETURNS WITH (BX) POINTING TO $FBUFF
;
;**************************************************************

	;HERE TO CONVERT AN INTEGER INTO DECIMAL DIGITS
	;THIS EXITS WITH A=0.  (DE) IS LEFT UNALTERED.
; This entry point is used by the routine at PUFOUT.
FOUTCI:
  PUSH DE               ;SAVE (DE)
  LD DE,INT_POWERS_TAB  ;GET POINTER TO THE INTEGER POWER OF TEN TABLE
  LD A,$05              ;SET UP A DIGIT COUNT, WE HAVE TO CALCULATE 5 DIGITS BECAUSE THE MAX POS INTEGER IS 32768

	;HERE TO CALCULATE EACH DIGIT
FOUCI1:
  CALL FOUTED           ;SEE IF A COMMA OR DP GOES BEFORE THE DIGIT
  PUSH BC               ;SAVE COMMA AND DECIMAL POINT INFORMATION
  PUSH AF               ;SAVE DIGIT COUNT
  PUSH HL               ;SAVE BUFFER POINTER
  EX DE,HL              ;GET THE POWER OF TEN POINTER IN (HL)
  LD C,(HL)             ;PUT THE POWER OF TEN ON THE STACK
  INC HL
  LD B,(HL)
  PUSH BC
  INC HL                ;INCREMENT THE PWR OF TEN PTR TO NEXT POWER
  EX (SP),HL            ;GET THE POWER OF TEN IN (HL) AND PUT THE POINTER ON THE STACK
  EX DE,HL              ;PUT THE POWER OF TEN IN (DE)
  LD HL,(FACCU)         ;GET THE INTEGER IN (HL)
  LD B,'0'-1            ;SET UP THE DIGIT COUNT, B=DIGIT TO BE PRINTED

FOUCI2:
  INC B                 ;INCREMENT THE DIGIT COUNT
	; HL=HL-DE: SUBTRACT OUT POWER OF TEN
  LD A,L                ;SUBTRACT (DE) FROM (HL)
  SUB E                 ;SUBTRACT THE LOW ORDERS
  LD L,A                ;SAVE THE NEW RESULT
  LD A,H                ;SUBTRACT THE HIGH ORDERS
  SBC A,D
  LD H,A                ;SAVE THE NEW HIGH ORDER
  JR NC,FOUCI2          ;IF (HL) WAS .GE. (DE) THEN SUBTRACT AGAIN
  ADD HL,DE             ;WE ARE DONE, BUT WE SUBTRACTED (DE) ONCE TOO OFTEN, SO ADD IT BACK IN
  LD (FACCU),HL         ;SAVE IN THE FAC WHAT IS LEFT
  POP DE                ;GET THE POWER OF TEN POINTER BACK
  POP HL                ;GET THE BUFFER POINTER BACK
  LD (HL),B             ;PUT THE NEW DIGIT IN THE BUFFER
  INC HL                ;INCREMENT THE BUFFER POINTER TO NEXT DIGIT
  POP AF                ;GET THE DIGIT COUNT BACK
  POP BC                ;GET THE COMMA AND DP INFORMATION BACK
  DEC A                 ;WAS THAT THE LAST DIGIT?
  JR NZ,FOUCI1          ;NO, GO DO THE NEXT ONE
  CALL FOUTED           ;YES, SEE IF A DP GOES AFTER THE LAST DIGIT
  LD (HL),A             ;PUT A ZERO AT THE END OF THE NUMBER, BUT DON'T INCREMENT (HL)
                        ;SINCE AN EXPONENT OR A TRAILING SIGN MAY BE COMMING
  POP DE                ;GET (DE) BACK
  RET                   ;ALL DONE, RETURN WITH A=0


	;CONSTANTS USED BY FOUT

FP_TENTEN:
  DEFB $00,$00,$00,$00,$F9,$02,$15,$A2   ;1D10  (10000000000)
FP_FOUTDL:
  DEFB $E1,$FF,$9F,$31,$A9,$5F,$63,$B2   ; 999,999,999,999,999.5
FP_FOUTDU:
  DEFB $FE,$FF,$03,$BF,$C9,$1B,$0E,$B6   ; 9,999,999,999,999,999.5

DBL_FP_ZERO:
  DEFB $00,$00,$00,$00
FP_HALF:
  DEFB $00,$00,$00,$80

FP_FFXDXM:
  DEFB $00,$00,$04,$BF,$C9,$1B,$0E,$B6    ; 1D16: 10000000000000000

FP_POWERS_TAB:
  DEFB $00,$80,$C6,$A4,$7E,$8D,$03        ; 1D15: 1000000000000000
  DEFB $00,$40,$7A,$10,$F3,$5A,$00        ; 1D14: 100000000000000
  DEFB $00,$A0,$72,$4E,$18,$09,$00        ; 1D13: 10000000000000
  DEFB $00,$10,$A5,$D4,$E8,$00,$00        ; 1D12: 1000000000000
  DEFB $00,$E8,$76,$48,$17,$00,$00        ; 1D11: 100000000000
  DEFB $00,$E4,$0B,$54,$02,$00,$00        ; 1D10: 10000000000
  DEFB $00,$CA,$9A,$3B,$00,$00,$00        ;  1D9: 1000000000
  DEFB $00,$E1,$F5,$05,$00,$00,$00        ;  1D8: 100000000
  DEFB $80,$96,$98,$00,$00,$00,$00        ;  1D7: 10000000
  DEFB $40,$42,$0F,$00,$00,$00,$00        ;  1D6: 1000000

POWERS_TAB:
  DEFB $A0,$86,$01        ; 100000
  DEFB $10,$27,$00        ; 10000
INT_POWERS_TAB:
  DEFB $10,$27,$E8        ; 100
  DEFB $03,$64,$00        ; 10
  DEFB $0A,$00,$01        ; 1
  DEFB $00



;
; OUTPUT ROUTINES FOR OCTAL AND HEX NUMBERS
;


; Octal string conversion
;
; Used by the routines at LISPRT and __OCT_S.
FOUTO:
  XOR A                ;MAKE A=0, SET ZERO
  LD B,A               ;SAVE IN [B]
  DEFB $C2             ; "JP NZ,nn" AROUND NEXT TWO BYTES

; Hex string conversion
;
; Used by the routines at LISPRT and __HEX_S.
FOUTH:
  LD B,$01             ;SET HEX FLAG

  PUSH BC              ;SAVE HEX/OCTAL FLAG
  CALL GETWORD_HL      ;GET DOUBLE BYTE INT IN [H,L]
  POP BC               ;GET BACK HEX/OCTAL FLAG
  LD DE,FBUFFR         ;POINTER TO OUTPUT BUFFER IN [D,E]
  PUSH DE              ;SAVE SO WE CAN RETURN IT LATER
  XOR A                ;GET SET TO HAVE FIRST DIGIT FOR OCTAL
  LD (DE),A            ;CLEAR DIGIT SEEN FLAG
  DEC B                ;SEE IF OCTAL
  INC B                ;IF SO, ZERO SET
  LD C,$06             ;SIX DIGITS FOR OCTAL
  JR Z,OCTONE          ;DO FIRST OCTAL DIGIT
  LD C,$04             ;FOUR DIGIT FOR HEX
OUTHLP:
  ADD HL,HL            ;SHIFT LEFT ONE BIT
  ADC A,A              ;ADD IN THE SHIFTED BIT
OUTOLP:
  ADD HL,HL            ;SHIFT LEFT ONE BIT
  ADC A,A
  ADD HL,HL
  ADC A,A
OCTONE:
  ADD HL,HL            ;ENTER HERE FOR FIRST OCTAL DIGIT
  ADC A,A
  OR A                 ;SEE IF WE GOT A ZERO DIGIT
  JR NZ,MAKDIG         ;NO, MAKE A DIGIT
  LD A,C               ;GET DIGIT COUNTER
  DEC A                ;WAS IT GOING TO GO TO ZERO (LAST DIG?)
  JR Z,MAKDIG          ;IF SO, FORCE ONE ZERO DIGIT
  LD A,(DE)            ;HAVE WE PRINTED A NON-ZERO DIGIT?
  OR A                 ;SET CC'S
  JR Z,NOLEAD          ;NO, DONT PRINT THIS LEADING ZERO
  XOR A                ;GET ZERO
MAKDIG:
  ADD A,'0'            ;MAKE NUMERIC DIGIT
  CP '9'+1             ;IS IT A BIG HEX DIGIT? (A-F)
  JR C,NOTHAL          ;NO, DONT ADD OFFSET
  ADD A,'A'-'9'-1      ;(A..F) ADD OFFSET
NOTHAL:
  LD (DE),A            ;SAVE DIGIT IN FBUFFR
  INC DE               ;BUMP POINTER
  LD (DE),A            ;SAVE HERE TO FLAG PRINTED SIG. DIG.
NOLEAD:
  XOR A                ;MAKE A ZERO
  DEC C                ;ALL DONE PRINTING?
  JR Z,FINOHO          ;YES, RETURN
  DEC B                ;SEE IF HEX OR OCTAL
  INC B                ;TEST
  JR Z,OUTOLP          ;WAS OCTAL
  JR OUTHLP            ;WAS HEX

FINOHO:
  LD (DE),A            ;STORE FINAL ZERO
  POP HL               ;GET POINTER TO FBUFFR
  RET                  ;ALL DONE.



; EXPONENTIATION AND THE SQUARE ROOT FUNCTION

; Negate number, a.k.a. PSHNEG
;
; Used by the routines at __SQR and __ATN.
NEGAFT:
  LD HL,NEG            ;GET THE ADDRESS OF NEG
  EX (SP),HL           ;SWITCH RET ADDR AND ADDR OF NEG
  JP (HL)              ;RETURN, THE ADDRESS OF NEG IS ON THE STACK


; 'SQR' BASIC function
;
	;SQUARE ROOT FUNCTION
	;WE USE SQR(X)=X^.5
;
__SQR:
  CALL PUSHF              ; Put value on stack          ;SAVE ARG X
  LD HL,FP_HALF           ; Set power to 1/2            ;GET 1/2
  CALL MOVFM              ; Move 1/2 to FPREG           ;SQR(X)=X^.5
  JR POWER_0              ;SKIP OVER THE NEXT 3 BYTES

POWER:
  CALL __CSNG             ;MAKE SURE THE FAC IS A SNG

POWER_0:
  POP BC                  ;GET ARG IN REGISTERS, ENTRY TO FPWR IF ARGUMENT IS ON STACK.  FALL INTO FPWR
  POP DE
;FPWR:
  LD HL,CLROVC            ;RETURN TO ROUTINE TO SET NORMAL OVERFLOW MODE     ;BACK TO NORMAL OVERFLOW PRINT MODE
  PUSH HL                 ;
  LD A,$01                ;SET UP ONCE ONLY OVERFLOW MODE
  LD (FLGOVC),A           ;SEE IF Y IS ZERO
  CALL SIGN               ;IT IS, RESULT IS ONE                 ; Test sign of power
  LD A,B                  ;POSITIVE EXPONENT                    ; Get exponent of base
  JR Z,__EXP              ;IS IT ZERO TO MINUS POWER?           ; Make result 1 if zero
  JP P,POWER_1            ;GIVE DIV BY ZERO AND CONTINUE        ; Positive base - Ok
  OR A                    ; Zero to negative power?
  JP Z,DZERR              ; Yes - ?/0 Error
POWER_1:
  OR A                    ; Base zero?
  JP Z,ZERO0              ; Yes - Return zero                   ;IT IS, RESULT IS ZERO
  PUSH DE                 ; Save base
  PUSH BC                 ;SAVE X ON STACK
  LD A,C                  ;CHECK THE SIGN OF X                  ; Get MSB of base
  OR $7F                  ;TURN THE ZERO FLAG OFF               ; Get sign status
  CALL BCDEFP             ;GET Y IN THE REGISTERS               ; Move power to BCDE
  JP P,POWER_3            ;NO PROBLEMS IF X IS POSITIVE         ; Positive base - Ok

  PUSH AF                 ; Save exponent
  LD A,(FPEXP)            ; Check the sign of power
  CP $99
  JR C,POWER_2            ; Negative
  POP AF                  ; Restore exponent
  JR POWER_3              ; Positive

POWER_2:
  POP AF                  ; Restore exponent

  PUSH DE
  PUSH BC
  CALL INT                ;SEE IF Y IS AN INTEGER                         ; Get integer of power
  POP BC                                                                  ; Restore power
  POP DE                  ;GET Y BACK
  PUSH AF                 ;SAVE LO OF INT FOR EVEN AND ODD INFORMATION    ; MSB of base
  CALL FCOMP              ;SEE IF WE HAVE AN INTEGER                      ; Power an integer?
  POP HL                  ;GET EVEN-ODD INFORMATION                       ; Restore MSB of base
  LD A,H                  ;PUT EVEN-ODD FLAG IN CARRY                     ; but don't affect flags
  RRA                                                                     ; Exponent odd or even?

POWER_3:
  POP HL                  ;GET X BACK IN FAC                              ; Restore MSB and exponent
  LD (FACCU+2),HL         ;STORE HO'S                                     ; Save base in FPREG
  POP HL                  ;GET LO'S OFF STACK                             ; LSBs of base
  LD (FACCU),HL           ;STORE THEM IN FAC                              ; Save in FPREG
  CALL C,NEGAFT           ;NEGATE NUMBER AT END IF Y WAS ODD              ; Odd power - Negate result
  CALL Z,NEG              ;NEGATE THE NEGATIVE NUMBER                     ; Negative base - Negate it
  PUSH DE                                                                 ; Save power
  PUSH BC                 ;SAVE Y AGAIN
  CALL __LOG              ;COMPUTE  EXP(Y*LOG(X))                         ; Get LOG of base
  POP BC                                                                  ; Restore power
  POP DE
                          ;IF X WAS NEGATIVE AND Y NOT AN INTEGER THEN
                          ; LOG WILL BLOW HIM OUT OF THE WATER

; EXP
EXP:
  CALL FMULT              ; Multiply LOG by power


	;THE FUNCTION EXP(X) CALCULATES e^X WHERE e=2.718282
	;	THE TECHNIQUE USED IS TO EMPLOY A COUPLE
	;	OF FUNDAMENTAL IDENTITIES THAT ALLOWS US TO
	;	USE THE BASE 2 THROUGH THE DIFFICULT PORTIONS OF
	;	THE CALCULATION:
	;
	;		(1)e^X=2^y  WHERE y=X*LOG2(e)   [LOG2(e) IS LOG BASE 2 OF e ]
	;
	;		(2) 2^y=2^[ INT(y)+(y-INT(y)]
	;		(3) IF Ny=INT(y) THEN
	;		    2^(Ny+y-Ny)=[2^Ny]*[2^(y-Ny)]
	;
	;	NOW, SINCE 2^Ny IS EASY TO COMPUTE (AN EXPONENT
	;	CALCULATION WITH MANTISSA BITS OF ZERO) THE DIFFICULT
	;	PORTION IS TO COMPUTE 2^(Y-Ny) WHERE 0.LE.(Y-Ny).LT.1
	;	THIS IS ACCOMPLISHED WITH A POLYNOMIAL APPROXIMATION
	;	TO 2^Z WHERE 0.LE.Z.LT.1  . ONCE THIS IS COMPUTED WE
	;	HAVE TO EFFECT THE MULTIPLY BY 2^Ny .

; label='EXP' BASIC function
;
; Used by the routine at __SQR.
__EXP:
  LD BC,$8138             ;GET LOG2(e)                    ; BCDE = 1/Ln(2)
  LD DE,$AA3B             
  CALL FMULT              ;y=FAC*LOG2(e)                  ; Multiply value by 1/LN(2)
  LD A,(FPEXP)            ;MUST SEE IF TOO LARGE          ; Get exponent
  CP $88                  ;ABS .GT. 128?                  ; Is it in range?  (80H+8)
  JR NC,MUL_OVTST1        ;IF SO OVERFLOW                 ; No - Test for overflow
  CP $68                  ;IF TOO SMALL ANSWER IS 1
  JR C,GET_UNITY                                          ; Load '1' to FP accumulator
  CALL PUSHF              ;SAVE y                         ; Put value on stack
  CALL INT                ;DETERMINE INTEGER POWER OF 2   ; Get INT of FP accumulator
  ADD A,$81               ;INTEGER WAS RETURNED IN A      ; 80h+1: For excess 128, Exponent = 126?
                          ;BIAS IS $81 BECAUSE BINARY POINT IS TO LEFT OF UNDERSTOOD 1
							 
  JR Z,MUL_OVTST2         ; Yes - Test for overflow       ;OVERFLOW
  POP BC
  POP DE                  ;RECALL y
  PUSH AF                 ;SAVE EXPONENT
  CALL FSUB               ;FAC=y-INT(y)                   ; Subtract exponent from FP accumulator
  LD HL,FP_EXPTAB         ;WILL USE HART 1302 POLY.       ; Coefficient table
  CALL POLY               ;COMPUTE 2^[y-INT(y)]           ; Sum the series
  POP BC                  ;INTEGER POWER OF 2 EXPONENT
  LD DE,$0000             ;NOW HAVE FLOATING REPRESENTATION  OF INT(y) IN (BCDE)    ; Scaling factor
  LD C,D                                                  ; Zero MSB

  JP FMULT                ;MULTIPLY BY 2^[y-INT(y)] AND RETURN     ; Scale result to correct value

MUL_OVTST1:
  CALL PUSHF
MUL_OVTST2:
  LD A,(FACCU+2)          ;IF NEG. THEN JUMP TO ZERO
  OR A                                                     ; Test if new exponent zero
  JP P,RESZER             ;OVERFLOW IF PLUS
  POP AF                  ;NEED STACK RIGHT
  POP AF
  JP ZERO                 ;GO ZERO THE FAC

RESZER:
  JP OVFIN6               ;OVERFLOW                        ; Overflow error


; Load '1' to FP accumulator
;
; Used by the routine at __EXP.
GET_UNITY:
  LD BC,$8100
  LD DE,$0000
  JP FPBCDE


;*************************************************************
;	Hart 1302 polynomial coefficients
; COEFFICIENTS FOR POLYNOMIAL EVALUATION OF LOG BASE 2 OF X
; WHERE 5.LE.X.LE.1
;*************************************************************

FP_EXPTAB:
  DEFB $07
  DEFB $7C,$88,$59,$74    ;.00020745577403-
  DEFB $E0,$97,$26,$77    ;.00127100574569-
  DEFB $C4,$1D,$1E,$7A    ;.00965065093202+
  DEFB $5E,$50,$63,$7C    ;.05549656508324+
  DEFB $1A,$FE,$75,$7E    ;.24022713817633-
  DEFB $18,$72,$31,$80    ;.69314717213716+
  DEFB $00,$00,$00,$81    ; 1.0! (1/1)




; Series math sub: POLYNOMIAL EVALUATOR AND THE RANDOM NUMBER GENERATOR
;
	;EVALUATE P(X^2)*X
	;POINTER TO DEGREE+1 IS IN (HL)
	;THE CONSTANTS FOLLOW THE DEGREE
	;CONSTANTS SHOULD BE STORED IN REVERSE ORDER, FAC HAS X
	;WE COMPUTE:
	; C0*X+C1*X^3+C2*X^5+C3*X^7+...+C(N)*X^(2*N+1)
;
; Used by the routines at __SIN and __ATN.
SUMSER:
  CALL PUSHF              ; Put FPREG on stack               ;SAVE X
  LD DE,FMULTT            ; Multiply by "X"                  ;PUT ADDRESS OF FMULTT ON STACK SO WHEN WE
  PUSH DE                 ; To be done after                 ; RETURN WE WILL MULTIPLY BY X
  PUSH HL                 ; Save address of table            ;SAVE CONSTANT POINTER
  CALL BCDEFP             ; Move FPREG to BCDE               ;SQUARE X
  CALL FMULT              ; Square the value
  POP HL                  ; Restore address of table         ;GET CONSTANT POINTER
                                                             ;FALL INTO POLY
	;POLYNOMIAL EVALUATOR
	;POINTER TO DEGREE+1 IS IN (HL), IT IS UPDATED
	;THE CONSTANTS FOLLOW THE DEGREE
	;CONSTANTS SHOULD BE STORED IN REVERSE ORDER, FAC HAS X
	;WE COMPUTE:
	; C0+C1*X+C2*X^2+C3*X^3+...+C(N-1)*X^(N-1)+C(N)*X^N
;
; Used by the routines at __LOG and __EXP.
POLY:
  CALL PUSHF                                                 ;SAVE X
  LD A,(HL)               ; Get number of coefficients       ;GET DEGREE
  INC HL                  ; Point to start of table          ;INCREMENT POINTER TO FIRST CONSTANT
  CALL MOVFM              ; Move coefficient to FPREG        ;MOVE FIRST CONSTANT TO FAC
  DEFB $06                ; Skip "POP AF"                    ;"MVI	B" OVER NEXT BYTE
SUMLP:
  POP AF                  ; Restore count                    ;GET DEGREE
  POP BC                  ; Restore number
  POP DE                                                     ;GET X
  DEC A                   ; Cont coefficients                ;ARE WE DONE?
  RET Z                   ; All done                         ;YES, RETURN
  PUSH DE                 ; Save number
  PUSH BC                                                    ;NO, SAVE X
  PUSH AF                 ; Save count                       ;SAVE DEGREE
  PUSH HL                 ; Save address in table            ;SAVE CONSTANT POINTER
  CALL FMULT              ; Multiply FPREG by BCDE           ;EVALUATE THE POLY, MULTIPLY BY X
  POP HL                  ; Restore address in table         ;GET LOCATION OF CONSTANTS
  CALL LOADFP             ; Number at HL to BCDE             ;GET CONSTANT
  PUSH HL                 ; Save address in table            ;STORE LOCATION OF CONSTANTS SO FADD AND FMULT
  CALL FADD               ; Add coefficient to FPREG         ; WILL NOT SCREW THEM UP, ADD IN CONSTANT
  POP HL                  ; Restore address in table         ;MOVE CONSTANT POINTER TO NEXT CONSTANT
  JR SUMLP                ; More coefficients                ;SEE IF DONE



	;PSUEDO-RANDOM NUMBER GENERATOR
	;IF ARG=0, THE LAST RANDOM NUMBER GENERATED IS RETURNED
	;IF ARG .LT. 0, A NEW SEQUENCE OF RANDOM NUMBERS IS STARTED
	; USING THE ARGUMENT
	;TO FORM THE NEXT RANDOM NUMBER IN THE SEQUENCE, WE MULTIPLY THE
	;PREVIOUS RANDOM NUMBER BY A RANDOM CONSTANT, AND ADD IN ANOTHER
	;RANDOM CONSTANT.  THEN THE HO AND LO BYTES ARE SWITCHED, THE
	;EXPONENT IS PUT WHERE IT WILL BE SHIFTED IN BY NORMAL, AND THE
	;EXPONENT IN THE FAC SET TO 200 SO THE RESULT WILL BE LESS THAN 1.
	;THIS IS THEN NORMALIZED AND SAVED FOR THE NEXT TIME.
	;THE HO AND LO BYTES WERE SWITCHED SO WE HAVE A RANDOM CHANCE OF
	;GETTING A NUMBER LESS THAN OR GREATER THAN .5

RND_COPY:
  DEFB $52,$C7,$4F,$80    ;A COPY OF RNDX TO COPY AT RUN TIME

; Routine at 14307
;
; Used by the routine at ISFUN.
RNDMON:
  CALL CHRGTB

; Routine at 14310
;
; Used by the routine at __RANDOMIZE.
RNDMN2:
  PUSH HL                  ;SAVE TEXT POINTER FOR MONADIC RND
  LD HL,FP_UNITY           ;PRETEND ARG IS 1.0
  CALL MOVFM
  CALL __RND               ;PICK UP A RANDOM VALUE
  POP HL                   ;GET BACK THE TEXT POINTER
  JP VALSNG

; 'RND' BASIC function
;
; Used by the routine at RNDMN2.
__RND:
  CALL SIGN               ; Test sign of FPREG                   ;GET SIGN OF ARG
  LD HL,SEED+2            ; Random number seed
  JP M,RESEED             ; Negative - Re-seed                   ;START NEW SEQUENCE IF NEGATIVE
  LD HL,RNDX              ; Last random number                   ;GET LAST NUMBER GENERATED
  CALL MOVFM              ; Move last RND to FPREG
  LD HL,SEED+2            ; Random number seed
  RET Z                   ; Return if RND(0)                     ;RETURN LAST NUMBER GENERATED IF ZERO
  ADD A,(HL)              ; Add (SEED)+2)                        ;GET COUNTER INTO CONSTANTS
  AND $07                 ; 0 to 7                               ;AND ADD ONE
  LD B,$00
  LD (HL),A               ; Re-save seed
  INC HL                  ; Move to coefficient table
  ADD A,A                 ; 4 bytes
  ADD A,A                 ; per entry
  LD C,A                  ; BC = Offset into table
  ADD HL,BC               ; Point to coefficient
  CALL LOADFP             ; Coefficient to BCDE
  CALL FMULT              ; Multiply FPREG by coefficient
  LD A,(SEED+1)            ; Get (SEED+1)
  INC A                   ; Add 1
  AND $03                 ; 0 to 3
  LD B,$00
  CP $01                  ; Is it zero?
  ADC A,B                 ; Yes - Make it 1
  LD (SEED+1),A           ; Re-save seed
  LD HL,RNDTB2-4          ; Addition table
  ADD A,A                 ; 4 bytes
  ADD A,A                 ; per entry
  LD C,A                  ; BC = Offset into table
  ADD HL,BC               ; Point to value
  CALL FADDS              ; Add value to FPREG
RND1:
  CALL BCDEFP             ; Return RND seed                      ;SWITCH HO AND LO BYTES,
  LD A,E                  ; Get LSB                              ;GET LO
  LD E,C                  ; LSB = MSB                            ;PUT HO IN LO BYTE
  XOR $4F                 ; 01001111.. Fiddle around
  LD C,A                  ; New MSB                              ;PUT LO IN HO BYTE
  LD (HL),$80             ; Set exponent                         ;MAKE RESULT POSITIVE
  DEC HL                  ; Point to MSB                         ;GET POINTER TO EXPONENT
  LD B,(HL)               ; Get MSB                              ;PUT EXPONENT IN OVERFLOW POSITION
  LD (HL),$80             ; Make value -0.5                      ;SET EXP SO RESULT WILL BE BETWEEN 0 AND 1
  LD HL,SEED              ; Random number seed
  INC (HL)                ; Count seed                           ;INCREMENT THE PERTUBATION COUNT
  LD A,(HL)               ; Get seed                             ;SEE IF ITS TIME
  SUB $AB                 ; Do it modulo 171
  JR NZ,RND2              ; Non-zero - Ok
  LD (HL),A               ; Zero seed                            ;ZERO THE COUNTER
  INC C                   ; Fillde about
  DEC D                   ; with the
  INC E                   ; number
RND2:
  CALL BNORM              ; Normalise number                     ;NORMALIZE THE RESULT
  LD HL,RNDX              ; Save random number                   ;SAVE RANDOM NUMBER GENERATED..
  JP FPTHL                ; Move FPREG to last and return        ;..FOR NEXT TIME

RESEED:
  LD (HL),A               ; Re-seed random numbers
  DEC HL
  LD (HL),A
  DEC HL
  LD (HL),A
  JR RND1


; RNDCNT = SEED+1
SEED:
  DEFB $00,$00,$00        ; Random number seed


; Table used by RND
;RNDTAB:
  DEFB $35,$4A,$CA,$99    ; -2.65145E+07
  DEFB $39,$1C,$76,$98    ; 1.61291E+07
  DEFB $22,$95,$B3,$98    ; -1.17691E+07
  DEFB $0A,$DD,$47,$98    ; 1.30983E+07
  DEFB $53,$D1,$99,$99    ; -2-01612E+07
  DEFB $0A,$1A,$9F,$98    ; -1.04269E+07
  DEFB $65,$BC,$CD,$98    ; -1.34831E+07
  DEFB $D6,$77,$3E,$98    ; 1.24825E+07
; Last random number
RNDX:
  DEFB $52,$C7,$4F,$80    ;LAST RANDOM NUMBER GENERATED, BETWEEN 0 AND 1

RNDTB2:
  DEFB $68,$B1,$46,$68    ; Table used by RND
  DEFB $99,$E9,$92,$69
  DEFB $10,$D1,$75,$68




;	SINE, COSINE AND TANGENT FUNCTIONS



; 'COS' BASIC function
;
	;COSINE FUNCTION
	;IDEA:  USE COS(X)=SIN(X+PI/2)
;
; Used by the routine at __TAN.
__COS:
  LD HL,FP_HALFPI         ;ADD PI/2 TO FAC
  CALL FADDS
                          ;END INTFSW
                          ;FALL INTO SIN

; 'SIN' BASIC function
;
	;SINE FUNCTION
	;IDEA: USE IDENTITIES TO GET FAC IN QUADRANTS I OR IV
	;THE FAC IS DIVIDED BY 2*PI AND THE INTEGER PART IS IGNORED BECAUSE SIN(X+2*PI)=SIN(X).
	;THEN THE ARGUMENT CAN BE COMPARED WITH PI/2 BY COMPARING THE RESULT OF THE DIVISION WITH PI/2/(2*PI)=1/4.
	;IDENTITIES ARE THEN USED TO GET THE RESULT IN QUADRANTS I OR IV.
	;AN APPROXIMATION POLYNOMIAL IS THEN USED TO COMPUTE SIN(X).
;
; Used by the routine at __TAN.
__SIN:
  LD A,(FPEXP)            ;WILL SEE IF .LT.2^-10
  CP $77                  ;AND IF SO SIN(X)=X
  RET C

	;SIN BY HART #3341
  LD A,(FACCU+2)
  OR A
  JP P,__SIN_0
  AND $7F
  LD (FACCU+2),A
  LD DE,NEG
  PUSH DE
__SIN_0:                  ;WILL CALCULATE X=FAC/(2*PI)
  LD BC,$7E22             ; BCDE = FP_EPSILON: 1/(2*PI) =~ 0.159155
  LD DE,$F983
  CALL FMULT
  CALL PUSHF              ;SAVE X
  CALL INT                ;FAC=INT(X)
  POP BC
  POP DE                  ;FETCH X TO REGISTERS
  CALL FSUB               ;FAC=X-INT(X)
  LD BC,$7F00             ; 0.25
  LD DE,$0000             ;(GET 1/4)
  CALL FCOMP              ;FAC=FAC-1/4
  JP M,__SIN_1
  LD BC,$7F80             ; -.025
  LD DE,$0000             ;(-1/4)
  CALL FADD
  LD BC,$8080             ; -0.5
  LD DE,$0000             ;(-1/2)
  CALL FADD               ;X=X-1/2
  CALL SIGN
  CALL P,NEG
  LD BC,$7F00             ; 0.25
  LD DE,$0000             ;(1/4)
  CALL FADD
  CALL NEG
__SIN_1:
  LD A,(FACCU+2)          ;MUST REDUCE TO [0,1/4]
  OR A                    ;SIGN IN PSW
  PUSH AF                 ;SAVE FOR POSSIBLE NEG. AFTER CALC
  JP P,__SIN_2
  XOR $80
  LD (FACCU+2),A          ;NOW IN [0,1/4]
__SIN_2:
  LD HL,FP_SINTAB         ;POINT TO HART COEFFICIENTS
  CALL SUMSER             ;DO POLY EVAL
  POP AF                  ;NOW TO DO SIGN
  RET P                   ;OK IF POS
  LD A,(FACCU+2)          ;FETCH SIGN BYTE
  XOR $80                 ;MAKE NEG
  LD (FACCU+2),A          ;REPLACE SIGN
  RET
                          ;END OF INTFSW COND


  DEFB $00,$00,$00,$00

;  defb 0,0, $80, $90	; -32768
;  defb 0,0, $80, $80	; -0.5

; Routine at 14610
FP_EPSILON:
  DEFB $83,$F9,$22,$7E    ; 1/(2*PI) 0.159155

; Routine at 14614
FP_HALFPI:
  DEFB $DB,$0F,$49,$81    ; 1.5708 (PI/2)

; (unused)
FP_QUARTER:
  DEFB $00,$00,$00,$7F    ; 0.25


;HART ALGORITHM 3341 CONSTANTS

;NOTE THAT HART CONSTANTS HAVE BEEN SCALED BY A POWER OF 2
;THIS IS DUE TO RANGE REDUCTION AS A % OF 2*PI RATHER THAN PI/2
;WOULD NEED TO MULTIPLY ARGUMENT BY 4 BUT INSTEAD WE FACTOR THIS
;THRU THE CONSTANTS.

FP_SINTAB:
  DEFB $05                ; Table used by SIN
  DEFB $FB,$D7,$1E,$86    ; 39.711   ->  .1514851E-3
  DEFB $65,$26,$99,$87    ; -76.575  -> -.4673767E-2
  DEFB $58,$34,$23,$87    ; 81.602   ->  .7968968E-1
  DEFB $E1,$5D,$A5,$86    ; -41.342  -> -.6459637
  DEFB $DB,$0F,$49,$83    ; 6.2832   -> 1.570796


; 'TAN' BASIC function
;
	;TANGENT FUNCTION
	;TAN(X)=SIN(X)/COS(X)
;
__TAN:
  CALL PUSHF              ; Put angle on stack               ;SAVE ARG
  CALL __SIN              ; Get SIN of angle                 ;   TAN(X)=SIN(X)/COS(X)
  POP BC                  ; Restore angle                    ;GET X OFF STACK
  POP HL                                                     ;PUSHF SMASHES (DE)
  CALL PUSHF              ; Save SIN of angle
  EX DE,HL                ; BCDE = Angle                     ;GET LO'S WHERE THEY BELONG
  CALL FPBCDE             ; Angle to FPREG
  CALL __COS              ; Get COS of angle
  JP DIV                  ; TAN = SIN / COS


; 'ATN' BASIC function
	;IDEA: USE IDENTITIES TO GET ARG BETWEEN 0 AND 1 AND THEN USE AN
	;APPROXIMATION POLYNOMIAL TO COMPUTE ARCTAN(X)
__ATN:
  CALL SIGN               ; Test sign of value               ;SEE IF ARG IS NEGATIVE
  CALL M,NEGAFT           ; Negate result after if -ve       ;IF ARG IS NEGATIVE, USE:
  CALL M,NEG              ; Negate value if -ve              ;   ARCTAN(X)=-ARCTAN(-X)
  LD A,(FPEXP)            ; Get exponent                     ;SEE IF FAC .GT. 1
  CP $81                  ; Number less than 1?
  JR C,__ATN_0            ; Yes - Get arc tangnt
  LD BC,$8100             ; BCDE = 1                         ;GET THE CONSTANT 1
  LD D,C
  LD E,C                                                     ;COMPUTE RECIPROCAL TO USE THE IDENTITY:
  CALL FDIV               ; Get reciprocal of number         ;  ARCTAN(X)=PI/2-ARCTAN(1/X)
  LD HL,FSUBS             ; Sub angle from PI/2              ;PUT FSUBS ON THE STACK SO WE WILL RETURN
  PUSH HL                 ; Save for angle > 1               ; TO IT AND SUBTRACT THE REULT FROM PI/2
__ATN_0:
  LD HL,FP_ATNTAB         ; Coefficient table                ;EVALUATE APPROXIMATION POLYNOMIAL
  CALL SUMSER             ; Evaluate sum of series           
  LD HL,FP_HALFPI         ; PI/2 - angle in case > 1         ;GET POINTER TO PI/2 IN CASE WE HAVE TO
  RET                     ; Number > 1 - Sub from PI/2       ; SUBTRACT THE RESULT FROM PI/2


	;CONSTANTS FOR ATN

FP_ATNTAB:
  DEFB $09
  DEFB $4A,$D7,$3B,$78    ; 1/17        ; .002866226
  DEFB $02,$6E,$84,$7B    ; -1/15       ; -.01616574
  DEFB $FE,$C1,$2F,$7C    ; 1/13        ; .04290961
  DEFB $74,$31,$9A,$7D    ; -1/11       ; -.07528964
  DEFB $84,$3D,$5A,$7D    ; 1/9         ; .1065626
  DEFB $C8,$7F,$91,$7E    ; -1/7        ; -.142089
  DEFB $E4,$BB,$4C,$7E    ; 1/5         ; .1999355
  DEFB $6C,$AA,$AA,$7F    ; -1/3        ; -.3333315
  DEFB $00,$00,$00,$81    ; 1/1         ; 1.0




; Return from 'DIM' command
; a.k.a. DIMCON
DIMRET:
  DEC HL                  ; DEC 'cos GETCHR INCs        ;SEE IF COMMA ENDED THIS VARIABLE
  CALL CHRGTB             ; Get next character
  RET Z                   ; End of DIM statement        ;IF TERMINATOR, GOOD BYE
  CALL SYNCHR             ; Make sure "," follows       
  DEFM ","                                              ;MUST BE COMMA



; 'DIM' BASIC command
;
; THE "DIM" CODE SETS DIMFLG AND THEN FALLS INTO THE VARIABLE
; SEARCH ROUTINE. THE VARIABLE SEARCH ROUTINE LOOKS AT
; DIMFLG AT THREE DIFFERENT POINTS:
;
;	1) IF AN ENTRY IS FOUND, DIMFLG BEING ON INDICATES
;		A "DOUBLY DIMENSIONED" VARIABLE
;	2) WHEN A NEW ENTRY IS BEING BUILT DIMFLG'S BEING ON
;		INDICATES THE INDICES SHOULD BE USED FOR
;		THE SIZE OF EACH INDICE. OTHERWISE THE DEFAULT
;		OF TEN IS USED.
;	3) WHEN THE BUILD ENTRY CODE FINISHES, ONLY IF DIMFLG IS
;		OFF WILL INDEXING BE DONE
;
__DIM:
  LD BC,DIMRET            ; Return to "DIMRET"    ;PLACE TO COME BACK TO
  PUSH BC                 ; Save on stack

  DEFB $F6                ; "OR n" to Mask 'XOR A' (Flag "Create" variable):   NON ZERO THING MUST TURN THE MSB ON

; Get variable address to DE
;
; ROUTINE TO READ THE VARIABLE NAME AT THE CURRENT TEXT POSITION
; AND PUT A POINTER TO ITS VALUE IN [D,E]. [H,L] IS UPDATED
; TO POINT TO THE CHARACTER AFTER THE VARIABLE NAME.
; VALTYP IS SETUP. NOTE THAT EVALUATING SUBSCRIPTS IN
; A VARIABLE NAME CAN CAUSE RECURSIVE CALLS TO PTRGET SO AT
; THAT POINT ALL VALUES MUST BE STORED ON THE STACK.
; ON RETURN, [A] DOES NOT REFLECT THE VALUE OF THE TERMINATING CHARACTER
;
; Used by the routines at __FOR, __LET, __LINE, __READ, EVAL_VARIABLE, __DEF,
; DOFN, SCNCNT, LINE_INPUT, __FIELD, __LSET, __CALL, HAVTYP, __TROFF, __ERASE,
; __NEXT and FN_INSTR.
GETVAR:
  XOR A                   ; Find variable address,to DE       ;MAKE [A]=0
  LD (DIMFLG),A           ; Set locate / create flag          ;FLAG IT AS SUCH
  LD C,(HL)               ; Get First byte of name            ;GET FIRST CHARACTER IN [C]
; This entry point is used by the routine at GETFNM.
GTFNAM:
  CALL CHKLTR             ; See if a letter                   ;CHECK FOR LETTER
  JP C,SN_ERR             ; ?SN Error if not a letter         ;MUST HAVE A LETTER
  XOR A
  LD B,A                  ; Clear second byte of name         ;ASSUME NO SECOND CHARACTER
  LD (NAMCNT),A           ;ZERO NAMCNT
  INC HL                  ;INCRMENT TEXT POINTER
  LD A,(HL)               ;GET CHAR
  CP '.'                  ;IS IT A DOT?
  JR C,NOSEC              ;TOO SMALL FOR ANYTHING REASONABLE
  JR Z,ISSEC              ;"." IS VALID VAR CHAR
  CP '9'+1                ;TOO BIG FOR NUMERIC?
  JR NC,PTRGT3            ;YES
  CP '0'                  ;IN RIGHT RANGE?
  JR NC,ISSEC             ;YES, WAS NUMERIC
PTRGT3:
  CALL ISLETTER_A
  JR C,NOSEC              ;ALLOW ALPHABETICS
ISSEC:
  LD B,A                  ;IT IS A NUMBER--SAVE IN B
  PUSH BC                 ;SAVE [B,C]
  LD B,$FF                ;[B] COUNTS THE CHARACTERS PAST #2
  LD DE,NAMCNT            ;THE PLACE TO PUT THE CHARACTERS

VMORCH:
  OR $80                  ;EXTRA CHARACTERS MUST HAVE THE HIGH BIT ON SO ERASE CAN SCAN BACKWARDS OVER THEM
  INC B                   ;INCREASE THE CHACRACTER COUNT
  LD (DE),A               ;AND STORE INTO THE BUFFER
  INC DE                  ;AND UPDATE THE BUFFER POINTER
  INC HL                  ;INCREMENT TEXT POINTER
  LD A,(HL)               ;GET CHAR
  CP '9'+1                ;TOO BIG?
  JR NC,VMORC1            ;YES
  CP '0'                  ;IN RANGE FOR DIGIT
  JR NC,VMORCH            ;YES, VALID CHAR
VMORC1:
  CALL ISLETTER_A         ;AS ARE ALPHABETICS
  JR NC,VMORCH            ; JP if letter
  CP '.'                  ;DOTS ALSO OK
  JR Z,VMORCH             ;SO EAT IT
  LD A,B                  ;CHECK FOR MAXIMUM COUNT
  CP NAMLEN-1             ;LIMITED TO SIZE OF NAMBUF ONLY
  JP NC,SN_ERR            ;MUST BE BAD SYNTAX
  POP BC                  ;GET BACK THE STORED [B,C]
  LD (NAMCNT),A           ;ALWAYS SET UP COUNT OF EXTRAS
  LD A,(HL)               ;RESTORE TERMINATING CHAR
NOSEC:                    
  CP '%'+1                ;NOT A TYPE INDICATOR
  JR NC,TABTYP            ;THEN DONT CHECK THEM
  LD DE,HAVTYP            ;SAVE JUMPS BY USING RETURN ADDRESS
  PUSH DE
  LD D,$02                ;CHECK FOR INTEGER
  CP '%'
  RET Z
  INC D                   ;CHECK FOR STRING
  CP '$'
  RET Z
  INC D                   ;CHECK FOR SINGLE PRECISION
  CP '!'
  RET Z
  LD D,$08                ;ASSUME ITS DOUBLE PRECISION
  CP '#'                  ;CHECK THE CHARACTER
  RET Z                   ;WHEN WE MATCH, SETUP VALTYP
  POP AF                  ;POP OFF NON-USED HAVTYP ADDRESS
TABTYP:
  LD A,C                  ;GET THE STARTING CHARACTER
  AND $7F                 ;GET RID OF THE USER-DEFINED FUNCTION BIT IN [C]
  LD E,A                  ;BUILD A TWO BYTE OFFSET
  LD D,$00
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD HL,DEFTBL-'A'        ;SEE WHAT THE DEFAULT IS
  ADD HL,DE
  LD D,(HL)               ;GET THE TYPE OUT OF THE TABLE
  POP HL                  ;GET BACK THE TEXT POINTER
  DEC HL                  ;NO MARKING CHARACTER

; Get variable
HAVTYP:
  LD A,D                                                     ;SETUP VALTYP
  LD (VALTYP),A           ; Set variable type
  CALL CHRGTB                                                ;READ PAST TYPE MARKER
  LD A,(SUBFLG)           ; Array name needed ?              ;GET FLAG WHETHER TO ALLOW ARRAYS
  DEC A                                                      ;IF SUBFLG=1, "ERASE" HAS CALLED
  JP Z,ARLDSV             ; Yes - Get array name             ;PTRGET, AND SPECIAL HANDLING MUST BE DONE
  JP P,NSCFOR             ; No array with "FOR" or "FN"      ;NO ARRAYS ALLOWED
  LD A,(HL)               ; Get byte again                   ;GET CHAR BACK
  SUB '('                 ; ..Subscripted variable?          ;ARRAY PERHAPS (IF SUBFLG SET NEVER WILL MATCH)
  JP Z,SBSCPT             ; Yes - Sort out subscript         ;IT IS!
  SUB '['-')'+1           ; ..Subscripted variable?          ;SEE IF LEFT BRACKET
  JP Z,SBSCPT             ; Yes - Sort out subscript         ;IF SO, OK SUBSCRIPT

; This entry point is used by the routine at __CHAIN.
; a.k.a. NOARYS
NSCFOR:
  XOR A                   ;ALLOW PARENS AGAIN         ; Simple variable
  LD (SUBFLG),A           ;SAVE IN FLAG LOCATION      ; Clear "FOR" flag
  PUSH HL                 ;SAVE THE TEXT POINTER      ; Save code string address
  LD A,(NOFUNS)           ;ARE FUNCTIONS ACTIVE?
  OR A
  LD (PRMFLG),A           ;INDICATE IF PARM1 NEEDS SEARCHING
  JR Z,SNFUNS             ;NO FUNCTIONS SO NO SPECIAL SEARCH
  LD HL,(PRMLEN)          ;GET THE SIZE TO SEARCH
  LD DE,PARM1             ;GET THE BASE OF THE SEARCH
  ADD HL,DE               ;[H,L]= PLACE TO STOP SEARCHING
  LD (ARYTA2),HL          ;SET UP STOPPING POINT
  EX DE,HL                ;[H,L]=START [D,E]=END
  JR LOPFND               ;START LOOPING
  
LOPTOP:
  LD A,(DE)               ;GET THE VALTYP OF THIS SIMPLE VARIABLE
  LD L,A                  ;SAVE SO WE KNOW HOW MUCH TO SKIP
  INC DE
  LD A,(DE)               ;[A]=FIRST CHARACTER OF THIS VARIABLE
  INC DE                  ;POINT TO 2ND CHAR OF VAR NAME
  CP C                    ;SEE IF OUR VARIABLE MATCHES
  JR NZ,NOTIT1
  LD A,(VALTYP)           ;GET TYPE WERE LOOKING FOR
  CP L                    ;COMPARE WITH OUR VALTYP
  JR NZ,NOTIT1            ;NOT RIGHT KIND -- SKIP IT
  LD A,(DE)               ;SEE IF SECOND CHACRACTER MATCHES
  CP B
  JP Z,FINPTR             ;THAT WAS IT, ALL DONE

NOTIT1:
  INC DE

; This entry point is used by the routine at VARNOT.
NFINPT:
  LD A,(DE)               ;GET LENGTH OF VAR NAME IN [A]
; This entry point is used by the routine at VARNOT.

;SKIP OVER THE CURRENT VARIABLE SINCE WE DIDN'T MATCH
SNOMAT:
  LD H,$00                ;[H,L]=NUMBER OF BYTES TO SKIP
  ADD A,L                 ;ADD VALTYPE TO LENGTH OF VAR
  INC A                   ;PLUS ONE
  LD L,A                  ;SAVE IN [L] TO MAKE OFFSET
  ADD HL,DE               ;ADD ON THE POINTER

LOPFND:
  EX DE,HL                ;[D,E]=POINTER INTO SIMPLE VARIABLES
  LD A,(ARYTA2)           ;ARE LOW BYTES DIFFERENT
  CP E                    ;TEST
  JR NZ,LOPTOP            ;YES
  LD A,(ARYTA2+1)         ;ARE HIGH BYTES DIFFERENT
  CP D                    ;THE SAME?
  JR NZ,LOPTOP            ;NO, MUST BE MORE VARS TO EXAMINE
;NOTFNS:
  LD A,(PRMFLG)           ;HAS PARM1 BEEN SEARCHED
  OR A
  JR Z,SMKVAR             ;IF SO, CREATE VARIABLE
  XOR A                   ;FLAG PARM1 AS SEARCHED
  LD (PRMFLG),A
SNFUNS:
  LD HL,(ARYTAB)          ;STOPPING POINT IS [ARYTA2]
  LD (ARYTA2),HL
  LD HL,(VARTAB)          ;SET UP STARTING POINT
  JR LOPFND

; This entry point is used by the routines at NOTQTI, __ERL and __CHAIN.
PTRGET:
  CALL GETVAR
VARRET:
  RET

; THIS IS EXIT FOR VARPTR AND OTHERS
; Routine at 20241
VARNOT:
  LD D,A                  ;ZERO [D,E]
  LD E,A
  POP BC                  ;GET RID OF PUSHED [D,E]
  EX (SP),HL              ;PUT RETURN ADDRESS BACK ON STACK
  RET                     ;RETURN FROM PTRGET

; a.k.a. CFEVAL
; This entry point is used by the routine at HAVTYP.
SMKVAR:
  POP HL                  ;[H,L]= TEXT POINTER
  EX (SP),HL              ;[H,L]= RETURN ADDRESS
  PUSH DE                 ;SAVE CURRENT VARIABLE TABLE POSITION
  LD DE,VARRET            ;ARE WE RETURNING TO VARPTR?
  CALL DCOMPR             ;COMPARE
  JR Z,VARNOT             ;YES.
  LD DE,COMPTR            ;RETURN HERE IF NOT FOUND
  CALL DCOMPR
  POP DE                  ;RESTORE THE POSITION
  JR Z,FINZER             ;MAKE FAC ZERO (ALL TYPES) AND SKIP RETURN
  EX (SP),HL              ;PUT RETURN ADDRESS BACK
  PUSH HL                 ;PUT THE TEXT POINTER BACK
  PUSH BC                 ;SAVE THE LOOKS
  LD A,(VALTYP)           ;GET LENGTH OF SYMBOL TABLE ENTRY
  LD B,A                  ;[B]=VALTYP
  LD A,(NAMCNT)           ;INCLUDE EXTRA CHARACTERS IN SIZE
  ADD A,B
  INC A                   ;AS WELL AS THE EXTRA CHARACTER COUNT
  LD C,A                  ;[B,C]=LENGTH OF THIS VARIABLE
  PUSH BC                 ;SAVE THE VALTYP ON THE STACK
  LD B,$00                ;[B]=0
  INC BC                  ;MAKE THE LENGTH INCLUDE
  INC BC                  ;THE LOOKS TOO
  INC BC
  LD HL,(STREND)          ;EVERYTHING UP BY THE CURRENT END OF STORAGE
  PUSH HL                 ;SAVE THIS #
  ADD HL,BC               ;ADD ON THE AMOUNT OF SPACE EXTRA NOW BEING USED
  POP BC                  ;POP OFF HIGH ADDRESS TO MOVE
  PUSH HL                 ;SAVE NEW CANDIDATE FOR STREND
  CALL MOVUP              ;BLOCK TRANSFER AND MAKE SURE WE ARE NOT OVERFLOWING THE STACK SPACE
  POP HL                  ;[H,L]=NEW STREND
  LD (STREND),HL          ;STORE SINCE WAS OK
                          ;THERE WAS ROOM, AND BLOCK TRANSFER WAS DONE, SO UPDATE POINTERS
  LD H,B                  ;GET BACK [H,L] POINTING AT THE END
  LD L,C                  ;OF THE NEW VARIABLE
  LD (ARYTAB),HL          ;UPDATE THE ARRAY TABLE POINTE
ZEROER:
  DEC HL                  ;[H,L] IS RETURNED POINTING TO THE
  LD (HL),$00             ;END OF THE VARIABLE SO WE
  CALL DCOMPR             ;ZERO BACKWARDS TO [D,E] WHICH
  JR NZ,ZEROER            ;POINTS TO THE START OF THE VARIABLE
  POP DE                  ;[E]=VALTYP
  LD (HL),D               ;VALTYP IS IN HIGH ORDER
  INC HL
  POP DE
  LD (HL),E               ;PUT DESCRIPTION
  INC HL
  LD (HL),D               ;OF THIS VARIABLE INTO MEMORY
  CALL NPUTSB             ;SAVE THE EXTRA CHARACTERS IN THE NAME
  EX DE,HL                ;POINTER AT VARIABLE INTO [D,E]
  INC DE                  ;POINT AT THE VALUE
  POP HL                  ;RESTORE THE TEXT POINTER
  RET

; This entry point is used by the routine at HAVTYP.
FINPTR:
  INC DE                  ;POINT AT THE EXTRA CHARACTER COUNT
  LD A,(NAMCNT)           ;SEE IF THE EXTRA COUNTS MATCH
  LD H,A                  ;SAVE LENGTH OF NEW VAR
  LD A,(DE)               ;GET LENGTH OF CURRENT VAR
  CP H                    ;ARE THEY THE SAME?
  JP NZ,NFINPT            ;SKIP EXTRAS AND CONTINUE SEARCH
  OR A                    ;LENGTH ZERO?
  JR NZ,NTFPRT            ;NO, MORE CHARS TO LOOK AT
  INC DE                  ;POINT TO VALUE OF VAR
  POP HL                  ;RESTORE TEXT POINTER
  RET                     ;ALL DONE WITH THIS VAR

NTFPRT:
  EX DE,HL
  CALL MATSUB             ;SEE IF THE CHARACTERS MATCH
  EX DE,HL                ;TABLE POINTER BACK INTO [D,E]
  JP NZ,SNOMAT            ;IF NOT, CONTINUE SEARCH
  POP HL                  ;GET BACK THE TEXT POINTER
  RET

;
; MAKE ALL TYPES ZERO AND SKIP RETURN
;
FINZER:
  LD (FPEXP),A            ;MAKE SINGLES AND DOUBLES ZERO
  LD H,A                  ;MAKE INTEGERS ZERO
  LD L,A
  LD (FACCU),HL
  CALL GETYPR             ;SEE IF ITS A STRING
  JR NZ,POPHR2            ;IF NOT, DONE
  LD HL,NULL_STRING       ;MAKE IT A NULL STRING BY
  LD (FACCU),HL           ;POINTING AT A ZERO
POPHR2:
  POP HL                  ;GET THE TEXT POINTER
  RET                     ;RETURN FROM EVAL


; MULTIPLE DIMENSION CODE
;

; FORMAT OF ARRAYS IN CORE
;
; DESCRIPTOR 
;	LOW BYTE = SECOND CHARCTER (200 BIT IS STRING FLAG)
;	HIGH BYTE = FIRST CHARACTER
;	LENGTH OF ARRAY IN CORE IN BYTES (DOES NOT INCLUDE DESCRIPTOR)
;	NUMBER OF DIMENSIONS 1 BYTE FOR EACH DIMENSION 
;		STARTING WITH THE FIRST A LIST (2 BYTES EACH) OF THE MAX INDICE+1
;	THE VALUES
;
; SBSCPT (a.k.a. ISARY): Sort out subscript
; Used by the routine at HAVTYP.
SBSCPT:
  PUSH HL                 ; Save code string address          ;SAVE DIMFLG AND VALTYP FOR RECURSION
  LD HL,(DIMFLG)          ; Type
  EX (SP),HL              ; Save and get code string          ;TEXT POINTER BACK INTO [H,L]
  LD D,A                  ; Zero number of dimensions         ;SET # DIMENSIONS =0
SCPTLP:
  PUSH DE                 ; Save number of dimensions         ;SAVE NUMBER OF DIMENSIONS
  PUSH BC                 ; Save array name                   ;SAVE LOOKS
  LD DE,NAMCNT            ;POINT AT THE AREA TO SAVE
  LD A,(DE)               ;GET LENGTH
  OR A                    ;IS IT ZERO?
  JR Z,SHTNAM             ;YES, SHORT NAME
  EX DE,HL                ;SAVE THE TEXT POINTER IN [D,E]
  ADD A,$02               ;WE WANT SMALLEST INT .GE.(NAMCNT+1)/2
  RRA
  LD C,A                  ;SEE IF THERE IS ROOM TO SAVE THIS STUFF
  CALL CHKSTK             ; Check if enough memory
  LD A,C                  ;RESTORE COUNT OF PUSHES
LPPSNM:
  LD C,(HL)               ;GET VALUES TO PUSH
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC                 ;AND DO THE SAVE
  DEC A                   ;[A] TIMES
  JR NZ,LPPSNM
  PUSH HL                 ;SAVE THE ADDRESS TO STORE TO
  LD A,(NAMCNT)           ;SAVE THE NUMBER OF BYTES FOR A COUNT
  PUSH AF
  EX DE,HL                ;RESTORE THE TEXT POINTER
  CALL INTIDX             ;EVALUATE INDICE INTO [D,E]
  POP AF                  ;COUNT TELLING HOW MUCH TO RESTORE
  LD (NAMTMP),HL          ;SAVE THE TEXT POINTER
  POP HL                  ;THE PLACE TO RESTORE TO
  ADD A,$02               ;CALCULATE BYTE POPS AGAIN
  RRA
LPLNAM:
  POP BC
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC A                   ;LOOP [A] TIMES POPING NAME BACK INTO NAMBUF
  JR NZ,LPLNAM
  LD HL,(NAMTMP)
  JR LNGNAM               ;WAS LONG ONE

SHTNAM:
  CALL INTIDX             ;EVALUATE IT
  XOR A                   ;MAKE SURE NAMCNT=0
  LD (NAMCNT),A

LNGNAM:
  LD A,(OPTVAL)          ;SEE WHAT THE OPTION BASE IS
  OR A
  JR Z,OPTB0              ;IF BASE 0 DO NOTHING
  LD A,D                  ;CHECK FOR 0 SUBSCRIPT
  OR E                    ;WHICH IS ILLEGAL IN BASE 1
  JR Z,BS_ERR             ;ADJUST SUBSCRIPT
  DEC DE
OPTB0:
  POP BC                  ;POP OFF THE LOOKS
  POP AF                  ;[A] = NUMBER OF DIMENSIONS SO FAR
  EX DE,HL                ;[D,E]=TEXT POINTER <> [H,L]=INDICE
  EX (SP),HL              ;PUT THE INDICE ON THE STACK <> [H,L]=VALTYP & DIMFLG   ; Save subscript value
  PUSH HL                 ;RESAVE VALTYP AND DIMFLG                               ; Save NAMTMP and TYPE
  EX DE,HL                ;[H,L]=TEXT POINTER
  INC A                   ;INCREMENT # OF DIMENSIONS                              ; Count dimensions
  LD D,A                  ;[D]=NUMBER OF DIMENSIONS                               ; Save in D
  LD A,(HL)               ;GET TERMINATING CHARACTER                              ; Get next byte in code string
  CP ','                  ;A COMMA SO MORE INDICES FOLLOW?                        ; Comma (more to come)?
  JR Z,SCPTLP             ;IF SO, READ MORE                                       ; Yes - More subscripts
  CP ')'                  ;EXPECTED TERMINATOR?                                   ; Make sure ")" follows
  JR Z,DOCHRT             ;DO CHRGET FOR NEXT ONE
  CP ']'                  ;BRACKET?
  JP NZ,SN_ERR            ;NO, GIVE ERROR
DOCHRT:
  CALL CHRGTB
;SUBSOK:
  LD (NXTOPR),HL          ;SAVE THE TEXT POINTER
  POP HL                  ;[H,L]= VALTYP & DIMFLG
  LD (DIMFLG),HL          ;SAVE VALTYP AND DIMFLG
  LD E,$00                ;WHEN [D,E] IS POPED INTO PSW, WE DON'T WANT THE ZERO FLAG TO BE SET,
                          ;SO "ERASE" WILL HAVE A UNIQUE CONDITION
  PUSH DE                 ;SAVE NUMBER OF DIMENSIONS
  
  DEFB $11                ; "LD DE,nn", OVER THE NEXT TWO BYTES

; a.k.a. ERSFIN
; This entry point is used by the routines at __CHAIN and HAVTYP.
ARLDSV:
  PUSH HL                 ; Save code string address         ;SAVE THE TEXT POINTER
  PUSH AF                 ; A = 00 , Flags set = Z,N         ;SAVE A DUMMY NUMBER OF DIMENSIONS WITH THE ZERO FLAG SET
;
; AT THIS POINT [B,C]=LOOKS. THE TEXT POINTER IS IN TEMP2.
; THE INDICES ARE ALL ON THE STACK, FOLLOWED BY THE NUMBER OF DIMENSIONS.
;
  LD HL,(ARYTAB)          ; Start of arrays                  ;[H,L]=PLACE TO START THE SEARCH

  DEFB $3E                ; "LD A,n" AROUND THE NEXT BYTE

; This entry point is used by the routine at NXTARY.
FNDARY:
  ADD HL,DE               ; Move to next array start                    ;SKIP OVER THIS ARRAY SINCE IT'S NOT THE ONE
  LD DE,(STREND)          ; End of arrays                               ;GET THE PLACE TO STOP INTO [D,E]
  CALL DCOMPR             ; End of arrays found?                        ;STOPPING TIME?
  JR Z,CREARY             ; Yes - Create array                          ;YES, COULDN'T FIND THIS ARRAY
  LD E,(HL)               ; Get type                                    ;GET VALTYP IN [E]
  INC HL                  ; Move on
  LD A,(HL)               ; Get second byte of name                     ;GET FIRST CHARACTER
  INC HL                  ; Move on
  CP C                    ; Compare with name given (second byte)       ;SEE IF IT MATCHES
  JR NZ,NXTARY            ; Different - Find next array                 ;NOT THIS ONE
  LD A,(VALTYP)                                                         ;GET TYPE OF VAR WERE LOOKING FOR
  CP E                    ; Compare type                                ;SAME AS THIS ONE?
  JR NZ,NXTARY            ; Different - Find next array                 ;NO, SKIP THIS VAR
  LD A,(HL)               ; Get first byte of name                      ;GET SECOND CHARACTER
  CP B                    ; Compare with name given (first byte)        ;ANOTHER MATCH?
  JR Z,BSNTERC                                                          ;MATCH, CHECK OUT REST OF NAME

; Routine at 20540
;
; Used by the routine at SBSCPT.
NXTARY:
  INC HL                  ; Move on                                     ;POINT TO SIZE ENTRY
; This entry point is used by the routine at BSNTERC.
BNAMSZ:
  LD E,(HL)               ;GET VAR NAME LENGTH IN [E]
  INC E                   ;ADD ONE TO GET CORRECT LENGTH
  LD D,$00                ;HIGH BYTE OF ZERO
  ADD HL,DE               ;ADD OFFSET
; This entry point is used by the routine at BSNTERC.
NXTARY_1:
  LD E,(HL)               ;[D,E]=LENGTH
  INC HL                  ;OF THE ARRAY BEING LOOKED AT
  LD D,(HL)
  INC HL
  JR NZ,FNDARY            ; Not found - Keep looking                    ;IF NO MATCH, SKIP THIS ONE AND TRY AGAIN
  LD A,(DIMFLG)           ; Found Locate or Create it?                  ;SEE IF CALLED BY "DIM"
  OR A                                                                  ;ZERO MEANS NO
  JP NZ,DD_ERR            ; Create - Err $0A - "Redimensioned array"    ;PRESERVE [D,E], AND DISPATCH TO
                                                                        ;"REDIMENSIONED VARIABLE" ERROR
                                                                        ;IF ITS "DIM" CALLING PTRGET
;
; TEMP2=THE TEXT POINTER
; WE HAVE LOCATED THE VARIABLE WE WERE LOOKING FOR
; AT THIS POINT [H,L] POINTS BEYOND THE SIZE TO THE NUMBER OF DIMENSIONS
; THE INDICES ARE ON THE STACK FOLLOWED BY THE NUMBER OF DIMENSIONS
;
  POP AF                  ; Locate - Get number of dim'ns      ;[A]=NUMBER OF DIMENSIONS
  LD B,H                  ; BC Points to array dim'ns          ;SET [B,C] TO POINT AT NUMBER OF DIMENSIONS
  LD C,L
  JP Z,POPHLRT            ; Jump if array load/save            ;"ERASE" IS DONE AT THIS POINT, SO RETURN TO DO THE ACTUAL ERASURE
  SUB (HL)                ; Same number of dimensions?         ;MAKE SURE THE NUMBER GIVEN NOW
                                                               ;AND WHEN THE ARRAY WAS SET UP ARE THE SAME
  JP Z,FINDEL             ; Yes - Find element                 ;JUMP OFF AND READ THE INDICES....

; ERR $09 - "Subscript out of range"
;
; Used by the routines at MLDEBC, SBSCPT and ZERARY.
BS_ERR:
  LD DE,$0009
  JP ERROR

;
; a.k.a. CMPNAM
; Used by the routine at SBSCPT.
BSNTERC:
  INC HL                  ;POINT TO LENGTH OF NAME
  LD A,(NAMCNT)           ;SEE IF COUNT MATCHES COUNT IN COMPLEX TABLE
  CP (HL)
  JR NZ,BNAMSZ            ;BAD NAME SIZE JUST SKIP AND SET NZ CC
  INC HL                  ;POINT ONE BYTE AFTER LENGTH FIELD
  OR A                    ;LENGTH ZERO?
  JR Z,NXTARY_1           ;THEN FOUND, EXIT
  DEC HL                  ;MOVE BACK ONE
  CALL MATSUB             ;OTHERWISE TRY TO MATCH CHARACTERS
  JR NXTARY_1             ;USING COMMON SUBROUTINE

;
; HERE WHEN VARIABLE IS NOT FOUND IN THE ARRAY TABLE
;
; BUILDING AN ENTRY:
; 
;	PUT DOWN THE DESCRIPTOR	
;	SETUP NUMER OF DIMENSIONS
;	MAKE SURE THERE IS ROOM FOR THE NEW ENTRY
;	REMEMBER VARPTR
;	TALLY=4 (VALTYP FOR THE EXTENDED)
;	SKIP 2 LOCS FOR LATER FILL IN -- THE SIZE
; LOOP:	GET AN INDICE
;	PUT NUMBER +1 DOWN AT VARPTR AND INCREMENT VARPTR
;	TALLY= TALLY * NUMBER+1
;	DECREMENT NUMBER-DIMS
;	JNZ	LOOP
;	CALL REASON WITH [H,L] REFLECTING LAST LOC OF VARIABLE
;	UPDATE STREND
;	ZERO BACKWARDS
;	MAKE TALLY INCLUDE MAXDIMS
;	PUT DOWN TALLY
;	IF CALLED BY DIMENSION, RETURN
;	OTHERWISE INDEX INTO THE VARIABLE AS IF IT WERE FOUND ON THE INITIAL SEARCH
;
; This entry point is used by the routine at SBSCPT.
CREARY:
  LD A,(VALTYP)           ;GET VALTYP OF NEW VAR
  LD (HL),A               ;PUT DOWN THE VARIABLE TYPE
  INC HL
  LD E,A
  LD D,$00                ;[D,E]=SIZE OF ONE VALUE (VALTYP)
  POP AF                  ;[A]=NUMBER OF DIMENSIONS                 ; Array to save or 0 dim'ns?
  JP Z,CREARY_RNZ         ;CALLED BY CHAIN, JUST RETURN NON-ZERO
  LD (HL),C               ;PUT DOWN THE DESCRIPTOR                  ; Save second byte of name
  INC HL
  LD (HL),B                                                         ; Save first byte of name
  CALL NPUTSB             ;STORE THE EXTRA CHARACTERS IN THE TABLE
  INC HL
  LD C,A                  ; Number of dimensions to C  (=NUMBER OF TWO BYTE ENTRIES NEEDED TO STORE THE SIZE OF EACH DIMENSION)
  CALL CHKSTK             ; Check if enough memory                  ;GET SPACE FOR DIMENSION ENTRIES
  INC HL                  ; Point to number of dimensions           ;SKIP OVER THE SIZE LOCATIONS
  INC HL
  LD (TEMP3),HL           ; Save address of pointer     ;SAVE THE LOCATION TO PUT THE SIZE IN -- POINTS AT THE NUMBER OF DIMENSIONS
  LD (HL),C               ; Set number of dimensions    ;STORE THE NUMBER OF DIMENSIONS
  INC HL
  LD A,(DIMFLG)           ; Locate of Create?           ;CALLED BY DIMENSION?
  RLA                     ; Carry set = Create          ;SET CARRY IF SO
  LD A,C                  ; Get number of dimensions    ;[A]=NUMBER OF DIMENSIONS
CRARLP:
  JR C,GETSIZ
  PUSH AF
  LD A,(OPTVAL)                                             ;GET THE OPTION BASE
  XOR 10+1                ; Default dimension size is 10     ;MAP 0 TO 11 AND 1 TO 10
  LD C,A                  ; BC = number of dimensions        ;[B,C]=DEFAULT DIMENSION
  LD B,$00
  POP AF
  JR NC,DEFSIZ            ; Locate - Set default size        ;DEFAULT DIMENSIONS TO TEN
GETSIZ:
  POP BC                  ; Get specified dimension size     ;POP OFF AN INDICE INTO [B,C]
  INC BC                  ; Include zero element             ;ADD ONE TO IT FOR THE ZERO ENTRY
DEFSIZ:
  LD (HL),C               ; Save LSB of dimension size       ;PUT THE MAXIMUM DOWN
  PUSH AF                 ; Save num' of dim'ns an status    ;SAVE THE NUMBER OF DIMENSIONS AND DIMFLG (CARRY)
  INC HL
  LD (HL),B               ; Save MSB of dimension size
  INC HL
  CALL MLDEBC             ; Multiply DE by BC to find amount of mem needed   ;MULTIPLY [B,C]=NEWMAX BY CURTOL=[D,E]
  POP AF                  ; Restore number of dimensions      ;GET THE NUMBER OF DIMENSIONS AND DIMFLG (CARRY) BACK
  DEC A                   ; Count them                        ;DECREMENT THE NUMBER OF DIMENSIONS LEFT
  JR NZ,CRARLP            ; Do next dimension if more         ;HANDLE THE OTHER INDICES
  PUSH AF                 ; Save locate/create flag           ;SAVE DIMFLG (CARRY)
  LD B,D                  ; MSB of memory needed              ;[B,C]=SIZE
  LD C,E                  ; LSB of memory needed
  EX DE,HL                                                    ;[D,E]=START OF VALUES
  ADD HL,DE               ; Add bytes to array start          ;[H,L]=END OF VALUES
  JP C,OM_ERR             ; Too big - Error                   ;OUT OF MEMORY POINTER BEING GENERATED?
  CALL ENFMEM             ; See if enough memory              ;SEE IF THERE IS ROOM FOR THE VALUES
  LD (STREND),HL          ; Save new end of array             ;UPDATE THE END OF STORAGE

; Set array elements to zero
ZERARY:
  DEC HL                  ; Back through array data          ;ZERO THE NEW ARRAY
  LD (HL),$00             ; Set array element to zero
  CALL DCOMPR             ; All elements zeroed?             ;BACK AT THE BEGINNING?
  JR NZ,ZERARY            ; No - Keep on going               ;NO, ZERO MORE
  INC BC                  ; Number of bytes + 1              ;ADD ONE TO THE SIZE TO INCLUDE THE BYTE FOR THE NUMBER OF DIMENSIONS
  LD D,A                  ; A=0                              ;[D]=ZERO
  LD HL,(TEMP3)           ; Get address of array             ;GET A POINTER AT THE NUMBER OF DIMENSIONS
  LD E,(HL)               ; Number of dimensions             ;[E]=NUMBER OF DIMENSIONS
  EX DE,HL                ; To HL                            ;[H,L]=NUMBER OF DIMENSIONS
  ADD HL,HL               ; Two bytes per dimension size     ;[H,L]=NUMBER OF DIMENSIONS TIMES TWO
  ADD HL,BC               ; Add number of bytes              ;ADD ON THE SIZE TO GET THE TOTAL NUMBER OF BYTES USED
  EX DE,HL                ; Bytes needed to DE               ;[D,E]=TOTAL SIZE
  DEC HL                                                     ;BACK UP TO POINT TO LOCATION TO PUT
  DEC HL                                                     ;THE SIZE OF THE ARRAY IN BYTES IN.
  LD (HL),E               ; Save LSB of bytes needed         ;PUT DOWN THE SIZE
  INC HL
  LD (HL),D               ; Save MSB of bytes needed
  INC HL
  POP AF                  ; Locate / Create?                 ;GET BACK DIMFLG (CARRY) AND SET [A]=0
  JR C,ENDDIM             ; A is 0 , End if create

;
; AT THIS POINT [H,L] POINTS BEYOND THE SIZE TO THE NUMBER OF DIMENSIONS
; STRATEGY:
;	NUMDIM=NUMBER OF DIMENSIONS
;	CURTOL=0
; INLPNM:GET A NEW INDICE
;	POP NEW MAX INTO CURMAX
;	MAKE SURE INDICE IS NOT TOO BIG
;	MUTLIPLY CURTOL BY CURMAX
;	ADD INDICE TO CURTOL
;	NUMDIM=NUMDIM-1
;	JNZ	INLPNM
;	USE CURTOL*4 (VALTYP FOR EXTENDED) AS OFFSET
;
; a.k.a. GETDEF
; This entry point is used by the routine at NXTARY.
FINDEL:
  LD B,A                  ; Find array element              ;[B,C]=CURTOL=ZERO
  LD C,A
  LD A,(HL)               ; Number of dimensions            ;[A]=NUMBER OF DIMENSIONS
  INC HL                                                    ;POINT PAST THE NUMBER OF DIMENSIONS
  DEFB $16                ; "LD D,n" to skip "POP HL"       ;"MVI D," AROUND THE NEXT BYTE

INLPNM:
  POP HL                  ; Address of next dim' size       ;[H,L]= POINTER INTO VARIABLE ENTRY
  LD E,(HL)               ; Get LSB of dim'n size           ;[D,E]=MAXIMUM FOR THE CURRENT INDICE
  INC HL
  LD D,(HL)               ; Get MSB of dim'n size
  INC HL
  EX (SP),HL              ; Save address - Get index        ;[H,L]=CURRENT INDICE, POINTER INTO THE VARIABLE GOES ON THE STACK
  PUSH AF                 ; Save number of dim'ns           ;SAVE THE NUMBER OF DIMENSIONS
  CALL DCOMPR             ; Dimension too large?            ;SEE IF THE CURRENT INDICE IS TOO BIG
  JP NC,BS_ERR            ; Yes - ?BS Error                 ;IF SO "BAD SUBSCRIPT" ERROR
  CALL MLDEBC             ; Multiply previous by size       ;CURTOL=CURTOL*CURRENT MAXIMUM
  ADD HL,DE               ; Add index to pointer            ;ADD THE INDICE TO CURTOL
  POP AF                  ; Number of dimensions            ;GET THE NUMBER OF DIMENSIONS IN [A]
  DEC A                   ; Count them                      ;SEE IF ALL THE INDICES HAVE BEEN PROCESSED
  LD B,H                  ; MSB of pointer                  ;[B,C]=CURTOL IN CASE WE LOOP BACK
  LD C,L                  ; LSB of pointer
  JR NZ,INLPNM            ; More - Keep going               ;PROCESS THE REST OF THE INDICES
  LD A,(VALTYP)           ; SEE HOW BIG THE VALUES ARE AND MULTIPLY BY THAT SIZE
  LD B,H                  ; SAVE THE ORIGINAL VALUE FOR MULTIPLYING
  LD C,L                  ; BY THREE
  ADD HL,HL               ; MULTIPLY BY TWO AT LEAST
  SUB $04                 ; FOR INTEGERS AND STRINGS NO MORE MULTIPLYING BY TWO
  JR C,SMLVAL
  ADD HL,HL               ;NOW MULTIPLIED BY FOUR
  JR Z,DONMUL             ;IF SINGLE ALL DONE
  ADD HL,HL               ;BY EIGHT FOR DOUBLES
SMLVAL:
  OR A                    ;FIX CC'S FOR Z-80
  JP PO,DONMUL            ;FOR STRINGS
  ADD HL,BC               ;ADD IN THE ORIGINAL
DONMUL:
  POP BC                  ; Start of array                  ;POP OFF THE ADDRESS OF WHERE THE VALUES BEGIN
  ADD HL,BC               ; Point to element                ;ADD IT ONTO CURTOL TO GET THE PLACE THE VALUE IS STORED
  EX DE,HL                ; Address of element to DE        ;RETURN THE POINTER IN [D,E]
  
; a.k.a. FINNOW
ENDDIM:
  LD HL,(NXTOPR)          ; Got code string address          ;REGET THE TEXT POINTER
  RET

; This entry point is used by the routine at BSNTERC.
CREARY_RNZ:
  SCF                                     ;RETURN WITH NON-ZERO IN [A]
  SBC A,A		; A=$FF                   ;AND CONDITION CODES SET
  POP HL		; Skip return address     ;RESTORE TEST POINTER
  RET

;
; LONG VARIABLE NAME SUBROUTINES. AFTER THE NORMAL 2 CHARACTER NAME
; THE COUNT OF ADDITIONAL CHARACTERS IS STORED. FOLLOWING THIS
; COMES THE CHARACTERS IN ORDER WITH THE HIGH BIT TURNED ON SO A BACKWARD SCAN IS POSSIBLE
;
; This entry point is used by the routines at BCKUCM, CAYSTR, TVAR and ARRLP.
IADAHL:
  LD A,(HL)               ;GET THE CHARACTER COUNT
  INC HL
ADDAHL:
  PUSH BC
  LD B,$00                ;ADD [A] TO [H,L]
  LD C,A
  ADD HL,BC
  POP BC                  ;RESTORE THE SAVED [B,C]
  RET

;THIS ROUTINE STORE THE "LONG" NAME AT [H,L]
; This entry point is used by the routines at VARNOT and BSNTERC.
NPUTSB:
  PUSH BC
  PUSH DE
  PUSH AF
  LD DE,NAMCNT            ;POINT AT DATA TO SAVE
  LD A,(DE)               ;GET THE COUNT
  LD B,A
  INC B                   ;[B]= NUMBER OF BYTES TO SAVE
SLPLNG:
  LD A,(DE)               ;FETCH STORE VALUE
  INC DE
  INC HL                  ;MOVE UP TO STORE NAME INTO TABLE
  LD (HL),A               ;DO THE STORE
  ;DEC B                   ;AND REPEAT [B] TIMES
  DJNZ SLPLNG            ;FOR THE COUNT AND DATA
  POP AF
  POP DE
  POP BC
  RET

;THIS ROUTINE TRIES TO PERFORM A MATCH
; This entry point is used by the routines at VARNOT and BSNTERC.
MATSUB:
  PUSH DE
  PUSH BC
  LD DE,NAMBUF            ;POINT AT COUNT AND DATA
  LD B,A                  ;[B]=CHARACTER COUNT
  INC HL                  ;POINT AT THE DATA
  INC B                   ;START OFF LOOP
SLPMAT:
  DEC B                   ;MATCHED ALL CHARACTERS YET?
  JR Z,ISMAT2             ;IF SO, ITS A MATCH
  LD A,(DE)               ;GET ANOTHER CHARACTER
  INC DE                  ;MORE FORWARD IN STORED NAME
  CP (HL)                 ;SEE IF ITS THE SAME
  INC HL                  ;MOVE FORWARD IN DEFINITION TABLE
  JR Z,SLPMAT             ;IF MATCH KEEP GOING UNTIL END
  LD A,B                  ;NEED TO ADVANCE BY [B]-1 TO SKIP BAD CHARS
  DEC A
  CALL NZ,ADDAHL          ;USE THE COMMON SUBROUTINE. [H,L]=[H,L]+[A]
  XOR A                   ;SET CC'S NON ZERO FOR NO MATCH
  DEC A                   ;AND RETURN [A]=FF
ISMAT2:
  POP BC                  ;RESTORE SAVED REGISTERS
  POP DE
  RET


; This entry point is used by the routine at READY_0.
ERR_EDIT:
  LD (ERRFLG),A
  LD HL,(ERRLIN)
  OR H
  AND L
  INC A
  EX DE,HL
  RET Z
  JR __EDIT_0


; 'EDIT' BASIC command
__EDIT:
  CALL LNUM_PARM            ;GET THE ARGUMENT LINE NUMBER
  RET NZ                    ;ERROR IF NOT END OF LINE
; This entry point is used by the routine at ISSTRF.
__EDIT_0:                   ;GET RID OF NEWSTT ADDRESS
  POP HL

; This entry point is used by the routine at NOTDGI.

; Sub-command loop.
; Picks an optional number of repetitions and a command key
EDIT_LOOP:
  LD (DOT),DE               ;SAVE CURRENT LINE IN DOT FOR LATER EDIT OR LIST
  CALL SRCHLN               ;FIND THE LINE IN QUESTION
  JP NC,UL_ERR              ;IF NOT FOUND, UNDEFINED STATEMENT ERROR.
  LD H,B                    ;PONTER TO LINE IS IN [B,C]
  LD L,C                    ;TRANSFER IT TO [H,L]
  INC HL                    ;PASS OVER POINTER TO NEXT LINE
  INC HL                    ;LIKE SO.
  LD C,(HL)                 ;GET FIRST BYTE OF LINE #
  INC HL                    ;MOVE TO 2ND BYTE
  LD B,(HL)                 ;PICK IT UP INTO B
  INC HL                    ;ADVANCE TO POINT TO FIRST BYTE OF LINE
  PUSH BC                   ;SAVE LINE # ON STACK
  CALL DETOKEN_LIST         ;UNPACK LINE INTO BUF

; This entry point is used by the routine at NOTDGI.
__EDIT_2:
  POP HL                    ;GET BACK LINE #

; To enter Edit Mode on the line you are currently
; typing, type Control-A. MBASIC responds with CR,
; '!', and a space. The cursor will be positioned at
; the first character in the line.

; This entry point is used by the routine at PINLIN.
__EDIT_3:
  PUSH HL                   ;SAVE IT BACK ON STACK
  LD A,H                    ;TEST FOR DOUBLE BYTE ZERO
  AND L                   
  INC A                   
  LD A,'!'                  ;GET PROMPT FOR DIRECT EDIT
  CALL Z,OUTDO              ;SEND IT
  CALL NZ,LINPRT            ;PRINT LINE # IF NOT INLIN EDIT
  LD A,' '                  ;TYPE A SPACE
  CALL OUTDO
  LD HL,BUF                 ;GET START OF BUF IN [H,L]
  PUSH HL                   ;SAVE [H,L] WHILE WE CALC LINE LENGTH
  LD C,$FF                  ;ASSUME 0 CHAR LINE
__EDIT_4:                   ;BUMP COUNT OF CHARS
  INC C
  LD A,(HL)                 ;GET CHAR FROM LINE
  INC HL                    ;BUMP POINTER
  OR A
  JR NZ,__EDIT_4            ;IF NOT ZERO (END OF LINE) KEEP COUNTING...
  POP HL                    ;GET BACK POINTER TO LINE
  LD B,A                    ;SET CURRENT LINE POSIT TO ZERO

; Optional number of repetitions of the next subcommand.
DISPED:
  LD D,$00                  ;ASSUME REPITION COUNT IS ZERO
DISPI:
  CALL INCHRI               ;GET A CHAR FROM USER
  OR A                      ;IGNORE NULLS
  JR Z,DISPI
  CALL UCASE                ;MAKE UPPER CASE COMMAND
  SUB '0'                   ; convert from ASCII
  JR C,NOTDGI               ;GET RID OF OFFSET
  CP 10                     	;...
  JR NC,NOTDGI
  LD E,A                    ;SAVE CHAR
  LD A,D                    ;GET ACCUM REPITITION
  RLCA                      ;MULTIPLY BY 2
  RLCA                      ;BY 4
  ADD A,D                   ;AND ADD TO GET 5*D
  RLCA                      ;*2 TO GET 10*D
  ADD A,E                   ;ADD DIGIT
  LD D,A                    ;SAVE BACK NEW ACCUM
  JR DISPI                  ;GET NEXT CHAR

; Proceed by typing an Edit Mode subcommand.
;
; Used by the routine at DISPED.
NOTDGI:
  PUSH HL                   ;SAVE TEXT POINTER
  LD HL,DISPED              ;PUT RETURN ADDRESS TO DISPED
  EX (SP),HL                ;ON THE STACK
  DEC D                     ;SEE IF D=0 (REP FACTOR)
  INC D                     ;SET CONDITION CODES
  JR NZ,NOTDGI_0            ;BRANCH AROUND
  INC D                     ;MAKE IT 1
NOTDGI_0:
  CP $08-'0'		        ; TAB:  $08 - '0' = $D8
  JP Z,EDIT_BKSP            
  CP $7F-'0'		        ; DEL:  $7F - '0' = $4F
  JP Z,EDIT_DEL             
  CP $0D-'0'		        ; CR:   $0D - '0' = $DD
  JP Z,EDIT_DONE            
  CP ' '-'0'
  JR Z,EDIT_SPC             
  CP $31			        ;COMMAND IN LOWER CASE?
  JR C,NOTDGI_1
  SUB $20                   ; TO UPPERCASE
NOTDGI_1:
  CP 'Q'-'0'			; 'Q': QUIT?
  JP Z,EDIT_QUIT        ;     IF SO, QUIT & PRINT "OK" OR RETURN TO INLIN
  CP 'L'-'0'
  JR Z,EDIT_BRANCH      ; BRANCH
  CP 'S'-'0'
  JR Z,EDIT_SEARCH      ; SEARCH
  CP 'I'-'0'
  JP Z,EDIT_INSERT      ; INSERT
  CP 'D'-'0'
  JR Z,EDIT_DELETE      ; DELETE
  CP 'C'-'0'
  JP Z,EDIT_CHANGE      ; CHANGE
  CP 'E'-'0'          	;END?
  JP Z,EDIT_EXIT        ; (SAME AS <CR> BUT DOESNT PRINT REST)
  CP 'X'-'0'         	;EXTEND?
  JP Z,EDIT_XTEND       ; GO TO END OF LINE & INSERT
  CP 'K'-'0'          	;KILL??
  JR Z,EDIT_REPLACE     ; (SAME AS "S" BUT DELETES CHARS)
  CP 'H'-'0'          	;HACK??
  JP Z,EDIT_HACK        ;HACK OFF THE REST OF THE LINE & INSERT
  CP 'A'-'0'         	;AGAIN??
  LD A,$07
  JP NZ,OUTDO			; Ring a bell if unknown command
  
; The A subcommand lets you begin editing a line over again.
; It restores the original line and repositions the cursor at the beginning.
  POP BC                ;DISPI RETURN ADDRESS
  POP DE                ;LINE NUMBER INTO [D,E]
  CALL OUTDO_CRLF
  JP EDIT_LOOP          ;RESTART EDITING
  
EDIT_SPC:
  LD A,(HL)             ;GET CHAR FROM CURENT POSIT
  OR A                  ;ARE WE AT END OF LINE?
  RET Z                 ;IF SO, RETURN
  INC B                 ;BUMP CURRENT POSITION
  CALL OUTCH1          ;TYPE CHARACTER
  INC HL                ;MOVE POINTER TO NEXT CHAR
  DEC D                 ;TEST IF DONE WITH REPITITIONS
  JR NZ,EDIT_SPC        ;REPEAT
  RET                   ;RETURN TO DISPATCHER


; The subcommand [i]K<ch> is similar to [i]S<ch>, except all the characters
; passed over in the search are deleted. The cursor is positioned before <ch>, 
; and the deleted characters are enclosed in backslashes

EDIT_REPLACE:
  PUSH HL               ;SAVE CURRENT CHAR POSIT
  LD HL,TYPSLH          ;TYPE SLASH WHEN DONE
  EX (SP),HL            ;PUT IT ON STACK & GET POSIT BACK
  SCF
EDIT_SEARCH:
  PUSH AF               ;SAVE CONDITION CODES
  CALL INCHRI           ;GET SEARCH CHAR
  LD E,A                ;SAVE IT
  POP AF
  PUSH AF
  CALL C,TYPSLH         ;TYPE BEGINNING SLASH FOR "K"
EDIT_SEARCH_LP:
  LD A,(HL)
  OR A
  JR Z,EDIT_SEARCH_2
  CALL OUTCH1          ;TYPE THE CHAR
  POP AF                ;GET KILL FLAG
  PUSH AF               ;SAVE BACK
  CALL C,EDIT_REMOVE    ;DELETE THE CHAR IF K COMMAND.
  JR C,NOTSRC           ;AND DONT MOVE POINTER AS DELCHR ALREADY DID
  INC HL
  INC B                 ;INCREMENT LINE POSIT
NOTSRC:
  LD A,(HL)             ;ARE WE AT END ?
  CP E                  ;ARE CURRENT CHAR & SEARCH
  JR NZ,EDIT_SEARCH_LP  ;CHAR THE SAME? IF NOT, LOOK MORE
  DEC D                 ;LOOK FOR N MATCHES
  JR NZ,EDIT_SEARCH_LP  ;IF NOT 0, KEEP LOOKING
EDIT_SEARCH_2:
  POP AF                ;GET RID OF KILL FLAG
  RET                   ;DONE SEARCHING
  
; "BRANCH" command in EDIT mode
EDIT_BRANCH:
  CALL LISPRT             ;TYPE REST OF LINE
  CALL OUTDO_CRLF       ;TYPE CARRIAGE RETURN
  POP BC                ;GET RID OF RETURN TO DISPED
  JP __EDIT_2           ;GO TO MAIN CODE

; [i]D deletes i characters to the right of the cursor. The deleted characters
; are echoed between backslashes, and the cursor is positioned to the right of
; the last character deleted. If there are fewer than i characters to the right
; of the cursor, [i]D deletes deletes the remainder of the line.

EDIT_DELETE:
  LD A,(HL)             ;GET CHAR WHICH WE ARE TRYING TO DELETE
  OR A                  ;IS IT THE END OF LINE MARKER?
  RET Z                 ;DONE IF SO
  LD A,'\\'             ;TYPE BACKSLASH
  CALL OUTCH1
DELLP:
  LD A,(HL)             ;GET CHAR FROM LINE
  OR A                  ;ARE WE AT END?
  JR Z,TYPSLH           ;TYPE SLASH
  CALL OUTCH1          ;TYPE CHAR WE'RE GOING TO DELETE
  CALL EDIT_REMOVE      ;DELETE CURRENT CHAR
  DEC D                 ;DECREMENT DELETE COUNT
  JR NZ,DELLP           ;KEEP DOING IT
TYPSLH:                 
  LD A,'\\'             ;TYPE ENDING SLASH
  CALL OUTDO
  RET

EDIT_CHANGE:
  LD A,(HL)             ;ARE WE AT END OF LINE?
  OR A                  ;SEE IF 0
  RET Z                 ;RETURN
EDIT_CHANGE_0:
  CALL INCHRI
  CP ' '                ;IS IT CONTROL CHAR?
  JR NC,NOTCCC          ;NO
  CP $0A                ;IS IT LF?
  JR Z,NOTCCC           ;YES
  CP $07                ;OR BELL?
  JR Z,NOTCCC           ;OK
  CP $09                ;OR TAB?
  JR Z,NOTCCC           ;OK
  LD A,$07              ;GET BELL
  CALL OUTDO            ;SEND IT
  JR EDIT_CHANGE_0      ;RETRY

NOTCCC:
  LD (HL),A             ;SAVE IN MEMORY
  CALL OUTCH1          ;ECHO THE CHAR WERE USING TO REPLACE
  INC HL                ;BUMP POINTER
  INC B                 ;INCREMENT POSITION WITHIN LINE
  DEC D                 ;ARE WE DONE CHANGING?
  JR NZ,EDIT_CHANGE     ;IF NOT, CHANGE SOME MORE.
  RET                   ;DONE


; H deletes all characters to the right of the cursor and then automatically
; enters insert mode.  H is useful for replacing statements at the end of a line.

EDIT_HACK:
  LD (HL),$00          	;MAKE LINE END AT CURRENT POSITION
  LD C,B                ;SET UP LINE LENGTH CORRECTLY


; Moves the cursor to the end of the line, goes into insert mode,
; and allows insertion of text as if an Insert command had been given.

EDIT_XTEND:
  LD D,$FF              ;FIND END OF LINE
  CALL EDIT_SPC         ;BY CALLING SPACER

; I<text>$
; Inserts <text> at the current cursor position. The inserted characters are printed on the terminal.
; To terminate insertion, type Escape. If Carriage Return is typed during an Insert command,
; the effect is the same as typing Escape and then Carriage Return. During an Insert command,
; the Rubout or Delete key on the terminal may be used to delete characters to the left of the cursor.

EDIT_INSERT:
  CALL INCHRI           ;GET CHAR TO INSERT
  CP $7F                ;DELETE??
  JR Z,TYPARW           ;YES, ACT LIKE "_"
  CP $08                ;Backspace?
  JR Z,TYPARW_0         ;Do delete
  CP $0D                ;IS IT A CARRIAGE RETURN?
  JP Z,EDIT_DONE        ;DONT INSERT, AND SIMULATE <CR>
  CP $1B                ;IS IT ESCAPE?
  RET Z                 ;IF SO, DONE.
  CP $08                ;BACKSPACE?
  JR Z,TYPARW_0         ;TYPE BACKARROW AND DELETE
  CP $0A                ;LINE FEED?
  JR Z,NTARRW           ;ALLOW IT
  CP $07                ;BELL?
  JR Z,NTARRW           ;ALLOW IT
  CP $09                ;TAB?
  JR Z,NTARRW           ;ALLOW IT
  CP ' '                ;IS IT ILLEGAL CHAR
  JR C,EDIT_INSERT      ;TOO SMALL
  CP '_'                ;DELETE PREVIOUS CHAR INSERTED?
  JR NZ,NTARRW          ;IF NOT, JUMP AROUND NEXT CODE

TYPARW:
  LD A,'_'              ;TYPE IT
TYPARW_0:
  DEC B                 ;ARE WE AT START OF LINE?
  INC B                 ;LETS SEE
  JR Z,DINGI            ;IF SO, TYPE DING.
  CALL OUTCH1          ;TYPE THE BACK ARROW
  DEC HL                ;BACK UP THE POINTER
  DEC B                 ;MOVE BACK POSIT IN LINE
  LD DE,EDIT_INSERT     ;SET UP RETURN ADDRESS
  PUSH DE               ;SAVE IT  ON STACK & FALL THROUGH

; SUBROUTINE TO DELETE CHAR POINTED TO BY [H,L]. CORRECTS C.
EDIT_REMOVE:
  PUSH HL               ;SAVE CURRENT POSIT POINTER
  DEC C                 ;MAKE LENGTH OF LINE ONE LESS
EDIT_REMOVE_LP:
  LD A,(HL)             ;GET CHAR TO DELETE
  OR A                  ;ARE WE AT END OF LINE
  SCF                   ;FLAG THAT DELCHR WAS CALLED (FOR K)
  JP Z,POPHLRT          ;IF SO, DONE COMPRESSING
  INC HL                ;POINT TO NEXT BYTE
  LD A,(HL)             ;PICK IT UP
  DEC HL                ;NOW BACK AGAIN
  LD (HL),A             ;DEPOSIT IT
  INC HL                ;NOW TO NEXT BYTE
  JR EDIT_REMOVE_LP     ;KEEP CRUNCHING

NTARRW:
  PUSH AF               ;SAVE THE CHAR TO BE INSERTED
  LD A,C                ;GET LENGTH OF LINE

; If an attempt is made to insert a character that will make the line longer than
; 255 characters, a bell (Control-G) is typed and the character is not printed.
  CP BUFLEN             ;SEE IF WE ARENT TRYING TO MAKE LINE TOO LONG
  JR C,EDIT_INS_CH      ;IF LENGTH OK, GO INSERT
  POP AF                ;GET THE UNLAWFUL CHAR
DINGI:
  LD A,$07              ;TYPE A BELL TO LET USER KNOW
  CALL OUTDO            ;IT ALL OVER

EDIT_INSERT_LP:
  JR EDIT_INSERT        ;HE HAS TO TYPE <ESC> TO GET OUT

EDIT_INS_CH:
  SUB B                	;CALC POINTER TO 0 AT END OF LINE
  INC C                 ;WE ARE GOING TO HAVE LINE LONGER BY 1
  INC B                 ;POSITION MOVES UP ONE ALSO
  PUSH BC              	;SAVE [B,C]
  EX DE,HL             	;SAVE [D,E] IN [H,L]
  LD L,A                ;SAVE # OF BYTES TO MOVE IN [L]
  LD H,$00              ;GET SET TO ADD [D,E] TO [H,L]
  ADD HL,DE             ;CALC HIGH POINTER
  LD B,H                ;GET HIGH BYTE TO MOVE POINTER
  LD C,L                ;IN [B,C]
  INC HL                ;ALWAYS MOVE AT LEAST ZERO AT END
  CALL MOVSTR           ;MOVE LINE OUT 1 CHAR
  POP BC                ;RESTORE [B,C]
  POP AF                ;GET CHAR BACK
  LD (HL),A             ;SAVE IT IN LINE
  CALL OUTCH1          ;TYPE THE CHAR
  INC HL                ;POINT TO NEXT CHAR
  JR EDIT_INSERT_LP    	;AND GO GET MORE CHARS


EDIT_BKSP:
  LD A,B                ;ARE WE MOVING BACK PAST THE
  OR A                  ;FIRST CHARACTER
  RET Z                 ;DON'T ALLOW IT
  DEC HL                ;MOVE CHAR POINTER BACK
  LD A,$08              
  CALL OUTCH1          ;ECHO IT
  DEC B                 ;CHANGE CURRENT POSITION
  DEC D                 ;ARE WE DONE MOVING BACK?
  JR NZ,EDIT_DEL        ;IF NOT, GO BACK MORE
  RET                   ;RETURN


; In Edit Mode, [i]Rubout moves the cursor i spaces to the left (backspaces).
; Characters are printed as you backspace over them.
EDIT_DEL:
  LD A,B                ;ARE WE MOVING BACK PAST THE
  OR A                  ;FIRST CHARACTER
  RET Z                 ;DON'T ALLOW IT
  DEC B                 ;CHANGE CURRENT POSITION
  DEC HL                ;MOVE CHAR POINTER BACK
  LD A,(HL)             ;GET CURRENT CHAR
  CALL OUTCH1          ;ECHO IT
  DEC D                 ;ARE WE DONE MOVING BACK?
  JR NZ,EDIT_DEL        ;IF NOT, GO BACK MORE
  RET                   ;RETURN


; Typing Carriage Return prints the remainder of the line, saves the changes
; you made and exits Edit Mode.
;
; Used by the routine at NOTDGI.
EDIT_DONE:
  CALL LISPRT           ;TYPE REST OF LINE
; This entry point is used by the routine at NOTDGI.
EDIT_EXIT:
  CALL OUTDO_CRLF       ;TYPE CARRIAGE RETURN
  POP BC                ;GET RID OF DISPED ADDRESS
  POP DE                ;GET LINE # OFF STACK
  LD A,D                ;DOUBLE BYTE ZERO.
  AND E                 
  INC A                 ;SET ZERO IF [D,E] = ALL ONES.
  
;USED BY AUTO CODE
; This entry point is used by the routine at PROMPT.
EDITRT:
  LD HL,BUF-1           ;START KRUNCHING AT BUF
  RET Z                 ;RETURN TO INLIN IF CALLED FROM THERE
  SCF                   ;FLAG LINE # WAS SEEN TO FOOL INSERT CODE
  PUSH AF               ;PSW IS ON STACK
  INC HL                ;NOW POINT AT BUF.
  JP EDENT              ;GO TO ENTRY POINT IN MAIN CODE

; This entry point is used by the routine at NOTDGI.

; Returns to BASIC command level, without saving any of the 
; changes that were made to the line during Edit Mode.
EDIT_QUIT:
  POP BC                ;GET RID OF DISPED ADDRESS
  POP DE                ;GET LINE # OFF STACK
  LD A,D                ;DOUBLE BYTE ZERO.
  AND E
  INC A                 ;SET ZERO IF [D,E] = ALL ONES.
  JP Z,FININL           ;TYPE CR AND STORE ZERO IN BUF.
  JP READY              ;OTHERWISE CALLED FROM MAIN



; PRINT USING
;
; PRINT#<filenumber>,[USING<string exp>;]<list of exps>
; To write data to a sequential disk file.
;
; COME HERE AFTER THE "USING" CLAUSE IN A PRINT STATEMENT IS RECOGNIZED.
; THE IDEA IS TO SCAN THE USING STRING UNTIL THE VALUE LIST IS EXHAUSTED,
; FINDING STRING AND NUMERIC FIELDS TO PRINT VALUES OUT OF THE LIST IN,
; AND JUST OUTPUTING ANY CHARACTERS THAT AREN'T PART OF A PRINT FIELD.
;
; Used by the routine at __PRINT.
__USING:
  CALL EVAL_0              ;EVALUATE THE "USING" STRING
  CALL TSTSTR              ;MAKE SURE IT IS A STRING
  CALL SYNCHR
  DEFM ";"                 ;MUST BE DELIMITED BY A SEMI-COLON
  EX DE,HL                 ;[D,E]=TEXT POINTER
  LD HL,(FACCU)            ;GET POINTER TO "USING" STRING DESCRIPTOR
  JR __USING_1             ;DONT POP OFF OR LOOK AT USFLG

; This entry point is used by the routine at NOTSCI.
REUSST:
  LD A,(FLGINP)            ;DID WE PRINT OUT A VALUE LAST SCAN?
  OR A                     ;SET CC'S
  JR Z,FCERR3              ;NO, GIVE ERROR
  POP DE                   ;[D,E]=POINTER TO "USING" STRING DESCRIPTOR
  EX DE,HL                 ;[D,E]=TEXT POINTER
__USING_1:
  PUSH HL                  ;SAVE THE POINTER TO "USING" STRING DESCRIPTOR
  XOR A                    ;INITIALLY INDICATE THERE ARE MORE VALUES IN THE VALUE LIST
  LD (FLGINP),A            ;RESET THE FLAG THAT SAYS VALUES PRINTED
  INC A                    ;TURN THE ZERO FLAG OFF TO INDICATE THE VALUE LIST HASN'T ENDED   (this introduced a bug)
  PUSH AF                  ;SAVE FLAG INDICATING WHETHER THE VALUE LIST HAS ENDED
  PUSH DE                  ;SAVE THE TEXT POINTER INTO THE VALUE LIST
  LD B,(HL)                ;[B]=LENGTH OF THE "USING" STRING
IF ORIGINAL
  OR B                     ;SEE IF ITS ZERO
ELSE
  INC B                    ;SEE IF ITS ZERO (bugfix)
  DEC B
ENDIF

FCERR3:
  JP Z,FC_ERR              ;IF SO, Err $05 - "Illegal function call"
  INC HL                   ;[H,L]=POINTER AT THE "USING" STRING'S
  LD A,(HL)                ;DATA
  INC HL
  LD H,(HL)
  LD L,A
  JR PRCCHR                ;GO INTO THE LOOP TO SCAN THE "USING" STRING

BGSTRF:
  LD E,B                   ;SAVE THE "USING" STRING CHARACTER COUNT
  PUSH HL                  ;SAVE THE POINTER INTO THE "USING" STRING
  LD C,$02                 ;THE \\ STRING FIELD HAS 2 PLUS NUMBER OF ENCLOSED SPACES WIDTH
LPSTRF:
  LD A,(HL)                ;GET THE NEXT CHARACTER
  INC HL                   ;ADVANCE THE POINTER AT THE "USING" STRINGDATA
  CP '\\'                  ;THE FIELD TERMINATOR?
  JP Z,ISSTRF              ;GO EVALUATE A STRING AND PRINT
  CP ' '                   ;A FIELD EXTENDER?
  JR NZ,NOSTRF             ;IF NOT, ITS NOT A STRING FIELD
  INC C                    ;INCREMENT THE FIELD WIDTH
  DJNZ LPSTRF              ;KEEP SCANNING FOR THE FIELD TERMINATOR

;
; SINCE  STRING FIELD WASN'T FOUND, THE "USING" STRING 
; CHARACTER COUNT AND THE POINTER INTO IT'S DATA MUST
; BE RESTORED AND THE "\" PRINTED
;
NOSTRF:
  POP HL                   ;RESTORE THE POINTER INTO "USING" STRING'S DATA
  LD B,E                   ;RESTORE THE "USING" STRING CHARACTER COUNT
  LD A,'\\'                ;RESTORE THE CHARACTER

;
; HERE TO PRINT THE CHARACTER IN [A] SINCE IT WASN'T PART OF ANY FIELD
;
NEWUCH:
  CALL PLS_PRNT            ;IF A "+" CAME BEFORE THIS CHARACTER MAKE SURE IT GETS PRINTED
  CALL OUTDO               ;PRINT THE CHARACTER THAT WASN'T PART OF A FIELD
PRCCHR:
  XOR A                    ;SET [D,E]=0 SO IF WE DISPATCH
  LD E,A                   ;SOME FLAGS ARE ALREADY ZEROED
  LD D,A                   ;DON'T PRINT "+" TWICE
PLSFIN:
  CALL PLS_PRNT            ;ALLOW FOR MULTIPLE PLUSES IN A ROW
  LD D,A                   ;SET "+" FLAG
  LD A,(HL)                ;GET A NEW CHARACTER
  INC HL
  CP '!'                   ;CHECK FOR A SINGLE CHARACTER
  JP Z,SMSTRF              ;STRING FIELD
  CP '#'                   ;CHECK FOR THE START OF A NUMERIC FIELD 
  JR Z,NUMNUM              ;GO SCAN IT
  CP '&'                   ;SEE IF ITS A VARIABLE LENGTH STRING FIELD
  JP Z,VARSTR              ;GO PRINT ENTIRE STRING
  DEC B                    ;ALL THE OTHER POSSIBILITIES REQUIRE AT LEAST 2 CHARACTERS
  JP Z,REUSIN              ;IF THE VALUE LIST IS NOT EXHAUSTED GO REUSE "USING" STRING
  CP '+'                   ;A LEADING "+" ?
  LD A,$08                 ;SETUP [D] WITH THE PLUS-FLAG ON IN
  JR Z,PLSFIN              ;CASE A NUMERIC FIELD STARTS
  DEC HL                   ;POINTER HAS ALREADY BEEN INCREMENTED
  LD A,(HL)                ;GET BACK THE CURRENT CHARACTER
  INC HL                   ;REINCREMENT THE POINTER
  CP '.'                   ;NUMERIC FIELD WITH TRAILING DIGITS
  JR Z,DOTNUM              ;IF SO GO SCAN WITH [E]=NUMBER OF DIGITS BEFORE THE "."=0
  CP '_'                   ;CHECK FOR LITERAL CHARACTER DECLARATION
  JP Z,LITCHR
  CP '\\'                  ;CHECK FOR A BIG STRING FIELD STARTER
  JR Z,BGSTRF              ;GO SEE IF IT REALLY IS A STRING FIELD
  CP (HL)                  ;SEE IF THE NEXT CHARACTER MATCHES THE CURRENT ONE
  JR NZ,NEWUCH             ;IF NOT, CAN'T HAVE $$ OR ** SO ALL THE POSSIBILITIES ARE EXHAUSTED
  CP '$'                   ;IS IT $$ ?
  JR Z,DOLRNM              ;GO SET UP THE FLAG BIT
  CP '*'                   ;IS IT ** ?
  JR NZ,NEWUCH             ;IF NOT, ITS NOT PART OF A FIELD SINCE ALL THE POSSIBILITIES HAVE BEEN TRIED
  INC HL                   ;SEE IF THE "USING" STRING IS LONG
  LD A,B                   ;CHECK FOR $
  CP $02                   ;ENOUGH FOR THE SPECIAL CASE OF
  JR C,_NOTSPC             ; **$
  LD A,(HL)
  CP '$'                   ;IS THE NEXT CHARACTER $ ?
_NOTSPC:
  LD A,32                  ;SET THE ASTERISK BIT
  JR NZ,SPCNUM             ;IF IT NOT THE SPECIAL CASE, DON'T SET THE DOLLAR SIGN FLAG
  DEC B                    ;DECREMENT THE "USING" STRING CHARACTER COUNT TO TAKE THE $ INTO CONSIDERATION
  INC E                    ;INCREMENT THE FIELD WIDTH FOR THE FLOATING DOLLAR SIGN

  DEFB $FE          ; CP AFh ..hides the "XOR A" instruction (MVI SI,  IN 8086)

DOLRNM:
  XOR A                    ;CLEAR [A]
  ADD A,$10                ;SET BIT FOR FLOATING DOLLAR SIGN FLAG
  INC HL                   ;POINT BEYOND THE SPECIAL CHARACTERS
SPCNUM:
  INC E                    ;SINCE TWO CHARACTERS SPECIFY THE FIELD SIZE, INITIALIZE [E]=1
  ADD A,D                  ;PUT NEW FLAG BITS IN [A]
  LD D,A                   ;INTO [D]. THE PLUS FLAG MAY HAVE ALREADY BEEN SET
NUMNUM:
  INC E                    ;INCREMENT THE NUMBER OF DIGITS BEFORE THE DECIMAL POINT
  LD C,$00                 ;SET THE NUMBER OF DIGITS AFTER THE DECIMAL POINT = 0
  DEC B                    ;SEE IF THERE ARE MORE CHARACTERS
  JR Z,ENDNUS              ;IF NOT, WE ARE DONE SCANNING THIS NUMERIC FIELD
  LD A,(HL)                ;GET THE NEW CHARACTER
  INC HL                   ;ADVANCE THE POINTER AT THE "USING" STRING DATA
  CP '.'                   ;DO WE HAVE TRAILING DIGITS?
  JR Z,AFTDOT              ;IF SO, USE SPECIAL SCAN LOOP
  CP '#'                   ;MORE LEADING DIGITS ?
  JR Z,NUMNUM              ;INCREMENT THE COUNT AND KEEP SCANNING
  CP ','
  JR NZ,FINNUM
  LD A,D                   ;TURN ON THE COMMA BIT
  OR 64
  LD D,A
  JR NUMNUM                ;GO SCAN SOME MORE

;
; HERE WHEN A "." IS SEEN IN THE "USING" STRING
; IT STARTS A NUMERIC FIELD IF AND ONLY IF
; IT IS FOLLOWED BY A "#"
;
DOTNUM:
  LD A,(HL)                ;GET THE CHARACTER THAT FOLLOWS
  CP '#'                   ;IS THIS A NUMERIC FIELD?
  LD A,'.'                 ;IF NOT, GO BACK AND PRINT "."
  JR NZ,NEWUCH
  LD C,$01                 ;INITIALIZE THE NUMBER OF DIGITS AFTER THE DECIMAL POINT
  INC HL
AFTDOT:
  INC C                    ;INCREMENT THE NUMBER OF DIGITS AFTER THE DECIMAL POINT
  DEC B                    ;SEE IF THE "USING" STRING HAS MORE
  JR Z,ENDNUS              ;CHARACTERS, AND IF NOT, STOP SCANNING
  LD A,(HL)                ;GET THE NEXT CHARACTER
  INC HL                   
  CP '#'                   ;MORE DIGITS AFTER THE DECIMAL POINT?
  JR Z,AFTDOT              ;IF SO, INCREMENT THE COUNT AND KEEP SCANNING
;
; CHECK FOR THE "^^^^" THAT INDICATES SCIENTIFIC NOTATION
;
FINNUM:
  PUSH DE                  ;SAVE [D]=FLAGS AND [E]=LEADING DIGITS
  LD DE,NOTSCI             ;PLACE TO GO IF ITS NOT SCIENTIFIC
  PUSH DE                  ;NOTATION
  LD D,H                   ;REMEMBER [H,L] IN CASE
  LD E,L                   ;ITS NOT SCIENTIFIC NOTATION
  CP '^'                   ;IS THE FIRST CHARACTER "^" ?
  RET NZ
  CP (HL)                  ;IS THE SECOND CHARACTER "^" ?
  RET NZ
  INC HL
  CP (HL)                  ;IS THE THIRD CHARACTER "^" ?
  RET NZ
  INC HL
  CP (HL)                  ;IS THE FOURTH CHARACTER "^" ?
  RET NZ
  INC HL
  LD A,B                   ;WERE THERE ENOUGH CHARACTERS FOR "^^^^"
  SUB $04                  ;IT TAKES FOUR
  RET C
  POP DE                   ;POP OFF THE NOTSCI RETURN ADDRESS
  POP DE                   ;GET BACK [D]=FLAGS [E]=LEADING DIGITS
  LD B,A                   ;MAKE [B]=NEW CHARACTER COUNT
  INC D                    ;TURN ON THE SCIENTIFIC NOTATION FLAG
  INC HL

  DEFB $CA                 ; JP Z,nn  to mask the next 2 bytes    ;SKIP THE NEXT TWO BYTES WITH "JZ"

; Routine at 21078
NOTSCI:
  EX DE,HL                 ;RESTORE THE OLD [H,L]
  POP DE                   ;GET BACK [D]=FLAGS [E]=LEADING DIGITS
; This entry point is used by the routine at __USING.
ENDNUS:
  LD A,D                   ;IF THE LEADING PLUS FLAG IS ON
  DEC HL                   
  INC E                    ;INCLUDE LEADING "+" IN NUMBER OF DIGITS
  AND $08                  ;DON'T CHECK FOR A TRAILING SIGN
  JR NZ,ENDNUM             ;ALL DONE WITH THE FIELD IF SO IF THERE IS A LEADING PLUS
  DEC E                    ;NO LEADING PLUS SO DON'T INCREMENT THE NUMBER OF DIGITS BEFORE THE DECIMAL POINT
  LD A,B
  OR A                     ;SEE IF THERE ARE MORE CHARACTERS
  JR Z,ENDNUM              ;IF NOT, STOP SCANNING
  LD A,(HL)                ;GET THE CURRENT CHARACTER
  SUB '-'                  ;TRAIL MINUS?
  JR Z,SGNTRL              ;SET THE TRAILING SIGN FLAG
  CP '+'-'-'               ;A TRAILING PLUS?
  JR NZ,ENDNUM             ;IF NOT, WE ARE DONE SCANNING
  LD A,$08                 ;TURN ON THE POSITIVE="+" FLAG
SGNTRL:
  ADD A,$04                ;TURN ON THE TRAILING SIGN FLAG
  ADD A,D                  ;INCLUDE WITH OLD FLAGS
  LD D,A
  DEC B                    ;DECREMENT THE "USING" STRING CHARACTER COUNT TO ACCOUNT FOR THE TRAILING SIGN
ENDNUM:
  POP HL                   ;[H,L]=THE OLD TEXT POINTER
  POP AF                   ;POP OFF FLAG THAT SAYS WHETHER THERE ARE MORE VALUES IN THE VALUE LIST
  JR Z,FLDFIN              ;IF NOT, WE ARE DONE WITH THE "PRINT"
  PUSH BC                  ;SAVE [B]=# OF CHARACTERS REMAINING IN "USING" STRING AND [C]=TRAILING DIGITS
  PUSH DE                  ;SAVE [D]=FLAGS AND [E]=LEADING DIGITS
  CALL EVAL                ;READ A VALUE FROM THE VALUE LIST
  POP DE                   ;[D]=FLAGS & [E]=# OF LEADING DIGITS
  POP BC                   ;[B]=# CHARACTER LEFT IN "USING" STRING
                           ;[C]=NUMBER OF TRAILING DIGITS
  PUSH BC                  ;SAVE [B] FOR ENTERING SCAN AGAIN
  PUSH HL                  ;SAVE THE TEXT POINTER
  LD B,E                   ;[B]=# OF LEADING DIGITS
  LD A,B                   ;MAKE SURE THE TOTAL NUMBER OF DIGITS
  ADD A,C                  ;DOES NOT EXCEED TWENTY-FOUR
  CP 25
  JP NC,FC_ERR             ;IF SO, Err $05 - "Illegal function call"

  LD A,D                   ;[A]=FLAG BITS
  OR $80                   ;TURN ON THE "USING" BIT
  CALL PUFOUT              ;PRINT THE VALUE
  CALL PRS                 ;ACTUALLY PRINT IT

; This entry point is used by the routine at ISSTRF.
FNSTRF:
  POP HL                   ;GET BACK THE TEXT POINTER
  DEC HL                   ;SEE WHAT THE TERMINATOR WAS
  CALL CHRGTB
  SCF                      ;SET FLAG THAT CRLF IS DESIRED
  JR Z,CRDNUS              ;IF IT WAS A END-OF-STATEMENT, FLAG THAT THE VALUE LIST ENDED AND THAT CRLF SHOULD BE PRINTED
  LD (FLGINP),A            ;FLAG THAT VALUE HAS BEEN PRINTED.
                           ;DOESNT MATTER IF ZERO SET, [A] MUST BE NON-ZERO OTHERWISE
  CP ';'                   ;A SEMI-COLON?
  JR Z,SEMUSN              ;A LEGAL DELIMITER
  CP ','                   ;A COMMA ?
  JP NZ,SN_ERR             ;THE DELIMETER WAS ILLEGAL

SEMUSN:
  CALL CHRGTB              ;IS THERE ANOTHER VALUE?
CRDNUS:
  POP BC                   ;[B]=CHARACTERS REMAINING IN "USING" STRING
  EX DE,HL                 ;[D,E]=TEXT POINTER
  POP HL                   ;[H,L]=POINT AT THE "USING" STRING
  PUSH HL                  ;DESCRIPTOR. RESAVE IT.
  PUSH AF                  ;SAVE THE FLAG THAT INDICATES WHETHER OR NOT THE VALUE LIST TERMINATED
  PUSH DE                  ;SAVE THE TEXT POINTER

;
; SINCE FRMEVL MAY HAVE FORCED GARBAGE COLLECTION
; WE HAVE TO USE THE NUMBER OF CHARACTERS ALREADY SCANNED
; AS AN OFFSET TO THE POINTER TO THE "USING" STRING'S DATA
; TO GET A NEW POINTER TO THE REST OF THE CHARACTERS TO BE SCANNED
;
  LD A,(HL)                ;GET THE "USING" STRING'S LENGTH
  SUB B                    ;SUBTRACT THE NUMBER OF CHARACTERS ALREADY SCANNED
  INC HL                   ;[H,L]=POINTER AT
  LD D,$00                 ;THE "USING" STRING'S
  LD E,A                   ;STRING DATA
  LD A,(HL)
  INC HL
  LD H,(HL)                ;SETUP [D,E] AS A DOUBLE BYTE OFFSET
  LD L,A
  ADD HL,DE                ;ADD ON THE OFFSET TO GET THE NEW POINTER
CHKUSI:
  LD A,B                   ;[A]=THE NUMBER OF CHARACTERS LEFT TO SCAN
  OR A                     ;SEE IF THERE ARE ANY LEFT
  JP NZ,PRCCHR             ;IF SO, KEEP SCANNING
  JR FINUSI                ;SEE IF THERE ARE MORE VALUES

; This entry point is used by the routine at __USING.
REUSIN:
  CALL PLS_PRNT            ;PRINT A "+" IF NECESSARY
  CALL OUTDO               ;PRINT THE FINAL CHARACTER
FINUSI:
  POP HL                   ;POP OFF THE TEXT POINTER
  POP AF                   ;POP OFF THE INDICATOR OF WHETHER OR NOT THE VALUE LIST HAS ENDED
  JP NZ,REUSST             ;IF NOT, REUSE THE "USING" STRING

; This entry point is used by the routine at ISSTRF.
FLDFIN:
  CALL C,OUTDO_CRLF        ;IF NOT COMMA OR SEMI-COLON ENDED THE VALUE LIST, PRINT A CRLF
  EX (SP),HL               ;SAVE THE TEXT POINTER <> [H,L]=POINT AT THE "USING" STRING'S DESCRIPTOR
  CALL GSTRHL              ;FINALLY FREE IT UP
  POP HL                   ;GET BACK THE TEXT POINTER
  JP FINPRT                ;ZERO [PTRFIL]

;
; HERE TO HANDLE A LITERAL CHARACTER IN THE USING STRING PRECEDED BY "_"
;
LITCHR:
  CALL PLS_PRNT            ;PRINT PREVIOUS "+" IF ANY
  DEC B                    ;DECREMENT COUNT FOR ACTUAL CHARACTER
  LD A,(HL)                ;FETCH LITERAL CHARACTER
  INC HL
  CALL OUTDO               ;OUTPUT LITERAL CHARACTER
  JR CHKUSI                ;GO SEE IF USING STRING ENDED

;
; HERE TO HANDLE VARIABLE LENGTH STRING FIELD SPECIFIED WITH "&"
;
VARSTR:
  LD C,$00                 ;SET LENGTH TO MAXIMUM POSSIBLE
  JR ISSTRF_0

;
; HERE WHEN THE "!" INDICATING A SINGLE CHARACTER STRING FIELD HAS BEEN SCANNED
;
SMSTRF:
  LD C,$01                 ;SET THE FIELD WIDTH TO 1
  DEFB $3E                 ; "LD A,n" to Mask the next byte      ;SKIP NEXT BYTE WITH A "MVI A,"

; Routine at 21235
;
; Used by the routine at __USING.
ISSTRF:
  POP AF                   ;GET RID OF THE [H,L] THAT WAS BEING SAVED IN CASE THIS WASN'T A STRING FIELD

; This entry point is used by the routine at NOTSCI.
ISSTRF_0:
  DEC B                    ;DECREMENT THE "USING" STRING CHARACTER COUNT
  CALL PLS_PRNT            ;PRINT A "+" IF ONE CAME BEFORE THE FIELD
  POP HL                   ;TAKE OFF THE TEXT POINTER
  POP AF                   ;TAKE OFF THE FLAG WHICH SAYS WHETHER THERE ARE MORE VALUES IN THE VALUE LIST
  JR Z,FLDFIN              ;IF THERE ARE NO MORE VALUES THEN WE ARE DONE
  PUSH BC                  ;SAVE [B]=NUMBER OF CHARACTERS YET TO BE SCANNED IN "USING" STRING
  CALL EVAL                ;READ A VALUE
  CALL TSTSTR              ;MAKE SURE ITS A STRING
  POP BC                   ;[C]=FIELD WIDTH
  PUSH BC                  ;RESAVE [B]
  PUSH HL                  ;SAVE THE TEXT POINTER
  LD HL,(FACCU)            ;GET A POINTER TO THE DESCRIPTOR
  LD B,C                   ;[B]=FIELD WIDTH
  LD C,$00                 ;SET UP FOR "LEFT$"
  LD A,B
  PUSH AF
  LD A,B
  OR A
  CALL NZ,__LEFT_S_1       ; into LEFT$, TRUNCATE THE STRING TO [B] CHARACTERS
  CALL PRS1                ;PRINT THE STRING
  LD HL,(FACCU)            ;SEE IF IT NEEDS TO BE PADDED
  POP AF                   ;[A]=FIELD WIDTH
  OR A                     ;
  JP Z,FNSTRF              ;DONT PRINT ANY TRAILING SPACES
  SUB (HL)                 ;[A]=AMOUNT OF PADDING NEEDED
  LD B,A
  LD A,' '                 ;SETUP THE PRINT CHARACTER
  INC B                    ;DUMMY INCREMENT OF NUMBER OF SPACES
UPRTSP:
  DEC B                    ;SEE IF MORE SPACES
  JP Z,FNSTRF              ;NO, GO SEE IF THE VALUE LIST ENDED AND RESUME SCANNING
  CALL OUTDO               ;PRINT A SPACE
  JR UPRTSP                ;AND LOOP PRINTING THEM

;
; WHEN A "+" IS DETECTED IN THE "USING" STRING IF A NUMERIC FIELD FOLLOWS A BIT IN [D]
; SHOULD BE SET, OTHERWISE "+" SHOULD BE PRINTED.
; SINCE DECIDING WHETHER A NUMERIC FIELD FOLLOWS IS VERY DIFFICULT, THE BIT IS ALWAYS SET IN [D].
; AT THE POINT IT IS DECIDED A CHARACTER IS NOT PART OF A NUMERIC FIELD, THIS ROUTINE IS CALLED
; TO SEE IF THE BIT IN [D] IS SET, WHICH MEANS A PLUS PRECEDED THE CHARACTER AND SHOULD BE PRINTED.
;
PLS_PRNT:
  PUSH AF                  ;SAVE THE CURRENT CHARACTER
  LD A,D                   ;CHECK THE PLUS BIT
  OR A                     ;SINCE IT IS THE ONLY THING THAT COULD BE TURNED ON
  LD A,'+'                 ;SETUP TO PRINT THE PLUS
  CALL NZ,OUTDO            ;PRINT IT IF THE BIT WAS SET
  POP AF                   ;GET BACK THE CURRENT CHARACTER
  RET



; Output char in 'A' to console
;
;	OUTDO (either CALL or RST) prints char in [A] no registers affected
;		to either terminal or disk file or printer depending
;		flags:
;			PRTFLG if non-zero print to printer
;			PTRFIL if non-zero print to disk file pointed to by PTRFIL
;
; Used by the routines at PROMPT, NEWSTT_0, LNOMOD, NOTQTI, __LIST, __FILES,
; CAYSTR, QINLIN, PINLIN, DELCHR, TTYLIN, PUTBUF, TAB_LOOP, OUTDO_CRLF,
; NTPRTR, OUTCH1, __USING, NOTSCI, ISSTRF, __EDIT, NOTDGI, NTCTCT and PRS1.
OUTDO:
  PUSH AF
  PUSH HL
  CALL ISFLIO           ; Tests if I/O to device is taking place
  JP NZ,FILOUT
  POP HL
  LD A,(PRTFLG)         ;SEE IF WE WANT TO TALK TO LPT
  OR A                  ;TEST BITS
  JR Z,CHPUT            ;IF ZERO THEN NOT
  POP AF                ;GET BACK CHAR
  PUSH AF
  CP $08                ;BACKSPACE?
  JR NZ,NTBKS2          ;NO
  LD A,(LPTPOS)         ;GET LPT POS
  SUB $01               ;SUBTRACT ONE FROM PRINTER POSIT
  JR C,OUTDO_0
  LD (LPTPOS),A
OUTDO_0:
  POP AF                ;GET BACK BACKSPACE
  JR LPTCHR             ;SEND CHAR

NTBKS2:
  CP $09                ;TAB
  JR NZ,OUTC            ;NO

TABEXP_LOOP:
  LD A,' '
  CALL OUTDO
  LD A,(LPTPOS)         ;GET CURRENT PRINT POSIT
  CP $FF
  JR Z,OUTC_TAB_END
  AND $07               ;AT TAB STOP?
  JR NZ,TABEXP_LOOP     ;GO BACK IF MORE TO PRINT
OUTC_TAB_END:
  POP AF                ;POP OFF CHAR
  RET                   ;RETURN

; Routine at 19542
;
; Used by the routine at OUTDO.
OUTC:
  POP AF                ;GET CHAR BACK
  PUSH AF               ;SAVE AGAIN
  SUB $0D               ;IF FUNNY CONTROL CHAR, (LF) DO NOTHING
  JR Z,ZERLP1
  JR C,_OUTPRT          ;JUST PRINT CHAR
  LD A,(LPTSIZ)         ;GET SIZE OF PRINTER
  INC A                 ;IS IT INFINITE?
  LD A,(LPTPOS)         ;GET POSIT
  JR Z,ZERLPT           ;THEN DONT FOLD     ; If 'WIDTH' is 255, the line width is "infinite" (no CRLF)
  PUSH HL               ;SAVE [H,L]
  LD HL,LPTSIZ          ; Value for 'WIDTH' on printer output.
  CP (HL)               ;MAX size reached ?
  POP HL
  CALL Z,OUTPRT_CRLF    ;THEN DO CRLF

ZERLPT:
  CP $FF                ;MAX LENGTH?
  JR Z,_OUTPRT          ;THEN JUST PRINT
  INC A                 ;INCREMENT POSIT
ZERLP1:
  LD (LPTPOS),A

; Output character to printer
;
; Used by the routine at OUTC.
_OUTPRT:
  POP AF                ;GET CHAR BACK

; Output character to printer
;
; a.k.a. LPTOUT
; Used by the routines at OUTDO and FINLPT.
LPTCHR:
  PUSH AF               ;SAVE BACK AGAIN
  PUSH BC               ;SAVE [B,C]
  PUSH DE               ;SAVE [D,E]
  PUSH HL
  LD C,A                  ;CPM WANTS CHAR IN [C]
  DEFB $CD                ; CALL nn

; Data block at 19587
SMC_LPTOUT:
  DEFW $0000              ;PRINTER ROUTINE ADDRESS STORED HERE

; Routine at 19589
L4C85:
  POP HL                ;RESTORE REGS
  POP DE
  POP BC
  POP AF                ;RESTORE CHAR
  RET                   ;RETURN FROM OUTCHR

; Reset printer
;
; Used by the routines at READY, STKERR and INPBRK.
FINLPT:
  XOR A                 ;RESET PRINT FLAG SO
  LD (PRTFLG),A         ;OUTPUT GOES TO TERMINAL
  LD A,(LPTPOS)         ;GET CURRENT LPT POSIT
  OR A                  ;ON LEFT HAND MARGIN ALREADY?
  RET Z                 ;YES, RETURN

; This entry point is used by the routine at OUTC.
OUTPRT_CRLF:
  LD A,$0D              ;PUT OUT CRLF
  CALL LPTCHR
  LD A,$0A
  CALL LPTCHR
  XOR A                 ;ZERO LPTPOS
  LD (LPTPOS),A         ;DONE
  RET

; Output character
;
; Used by the routines at CALTTY and OUTDO.
CHPUT:
  LD A,(CTLOFG)
  OR A
  JP NZ,POPAF           ;NO, DO OUTPUT
  POP AF                ;GET THE CHARACTER
  PUSH BC
  PUSH AF               ;AND SAVE IT AGAIN
  CP $08                ;BACKSPACE?
  JR NZ,NTBKS1
  LD A,(TTYPOS)         ;GET TTY POS
  OR A                  ;SET CC'S
  JR Z,TAB_LOOP_0       ;RETURN
  DEC A                 ;DECRMENT POSIT BY ONE
  LD (TTYPOS),A         ;CORRECT TTYPOS
  LD A,$08              ;GET BACK BACKSPACE CHAR
  JR TRYOUT             ;SEND IT

NTBKS1:
  CP $09                ;OUTPUTTING TAB?
  JR NZ,NOTAB           ;NO.

; TAB_LOOP
TAB_LOOP:
  LD A,' '              ;GET SPACE CHAR
  CALL OUTDO            ;CALL OUTCHR RECURSIVELY (!)
  LD A,(TTYPOS)         ;GET CURRENT PRINT POS.
  CP $FF                ; 'Infinite TAB' mode ?
  JR Z,TAB_LOOP_0      
  AND $07               ;AT TAB STOP YET??
  JR NZ,TAB_LOOP        ;NO, KEEP SPACING
; This entry point is used by the routine at CHPUT.
TAB_LOOP_0:
  POP AF                ;RESTORE CURRENT CHAR (TAB)
  POP BC                ;GET [B,C] BACK
  RET                   ;ALL DONE

; Routine at 19675
;
; Used by the routine at CHPUT.
NOTAB:
  CP ' '                ;IS THIS A MEANINGFUL CHARACTER?
  JR C,TRYOUT           ;IF IT'S A NON-PRINTING CHARACTER
  LD A,(LINLEN)         ;[B]=LINE LENGTH  (DON'T INCLUDE IT IN TTYPOS)
  LD B,A                ;DON'T INCLUDE IT IN TTYPOS
  LD A,(TTYPOS)         ;SEE IF PRINT HEAD IS AT THE END OF THE LINE
  INC B                 ;IS WIDTH 255?
  JR Z,INCTPS           ;YES, JUST INC TTYPOS
  DEC B                 ;CORRECT [B]
  CP B
  CALL Z,OUTDO_CRLF     ;TYPE CRLF AND SET TTYPOS AND [A]=0 IF SO
INCTPS:
  CP $FF                ;HAVE WE HIT MAX #?
  JR Z,TRYOUT           ;THEN LEAVE IT THERE
  INC A                 ;INCREMENT TTYPOS SINCE WE'RE GOING TO PRINT A CHARACTER.
  LD (TTYPOS),A         ;STORE NEW PRINT HEAD POSITION

; Routine at 19705
;
; Used by the routines at CHPUT and NOTAB.
TRYOUT:
  POP AF                ;GET CHAR OFF STACK
  POP BC                ;RESTORE [B,C]
  PUSH AF               ;SAVE PSW BACK
  POP AF
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,A                ;CPM WANTS CHAR IN [C]
  DEFB $CD                ; CALL nn

; Data block at 19715
SMC_CONOUT:
  DEFW $0000

; Routine at 19717
L4D05:                  ;RESTORE REGS
  POP HL
  POP DE
  POP BC                ;RESTORE CHAR
  POP AF                ;RETURN FROM OUTCHR
  RET

; This entry point is used by the routines at QINLIN, PINLIN and PUTBUF.
; Get character and test ^O
INCHR:
  CALL ISFLIO
  JR Z,INCHRI            ;GET CHARACTER FROM TERMINAL
  CALL RDBYT             ;READ A CHARACTER
  RET NC                 ;RETURN WITH CHARACTER
  PUSH BC                ;SAVE ALL REGISTERS
  PUSH DE
  PUSH HL
  CALL LOAD_END          ;CLOSE THE FILE
  POP HL
  POP DE
  POP BC
  LD A,(CHNFLG)          ;CHAIN IN PROGRESS?
  OR A                   ;TEST..
  JP NZ,CHNRET           ;YES, PERFORM VARIABLE BLOCK TRANSFER, ETC.
  LD A,(AUTORUN)         ;RUN IT OR NOT?
  OR A
  JR Z,INCHR_PROMPT
  LD HL,NEWSTT
  PUSH HL
  JP RUN_FST             ;RUN IT

INCHR_PROMPT:
  PUSH HL                ;PRESERVE REGISTERS
  PUSH BC
  PUSH DE
  LD HL,OK_MSG           ;PRINT PROMPT "OK"
  CALL PRS
  POP DE
  POP BC
  XOR A
  POP HL
  RET

; Get input character
;
; Used by the routines at FN_INPUT, L4D05, STALL, FN_INKEY_0, DISPED and NOTDGI.
INCHRI:
  PUSH BC               ;SAVE REGS
  PUSH DE
  PUSH HL
  DEFB $CD              ; CALL nn

; Data block at 19780
SMC_CONIN:
  DEFW $0000            ;CHANGED TO CALL CI

; Routine at 19782
L4D46:
  POP HL                ;RESTORE REGS
  POP DE
  POP BC
  AND $7F               ; This mask is missing on the Otrona Attachè variant
IF ZXPLUS3
  ; Hack to fix the KBD oddities
  CP 127
  JR NZ,NODEL
  LD A,8 ; DELETE (CAPS+0)
NODEL:
  CP 31	; SYM-SHIFT + DELETE (or UP arrow)
  JR NZ,NORUBOUT
  LD A,127
NORUBOUT:
ENDIF
  CP $0F                ;GET RID OF PARITY BIT
  RET NZ                ;IS IT SUPRESS OUTPUT?
  LD A,(CTLOFG)
  OR A                  ;ARE WE SUPRESSING OUTPUT?
  CALL Z,CTROPT         ;THEN PRINT CONTROL-O NOW.
  CPL                   ;COMPLEMENT ITS STATE
  LD (CTLOFG),A         ;SAVE BACK
  OR A                  ;SEE IF WE ARE TURNING OUTPUT ON.
  JP Z,CTROPT           ;PRINT THE ^O
  XOR A
  RET                   ;RETURN WITH NULL WHICH IS ALWAYS IGNORED

; Go to new line
;
; Used by the routines at ERROR_REPORT, READY, _LINE2PTR and INPBRK.
CONSOLE_CRLF:
  LD A,(TTYPOS)         ;GET CURRENT TTYPOS
  OR A                  ;SET CC'S
  RET Z                 ;IF ALREADY ZERO, RETURN
  JR OUTDO_CRLF         ;DO CR
 
; This entry point is used by the routines at PUTBUF and EDIT_DONE.
FININL:
  LD (HL),$00           ;PUT A ZERO AT THE END OF BUF
  LD HL,BUFMIN			;SETUP POINTER

; Print and go to new line
;
; Used by the routines at _ERROR_REPORT, __PRINT, PRNTNB, LNOMOD, __LIST,
; __FILES, CAYSTR, PINLIN, DELCHR, TTYLIN, NOTAB, CONSOLE_CRLF, NOTSCI, NOTDGI,
; EDIT_DONE, NTCTCT and DONCMD.
OUTDO_CRLF:
  LD A,$0D              ; CR
  CALL OUTDO            ; Output char to the current device
  LD A,$0A              ; LF
  CALL OUTDO            ; Output char to the current device

; This entry point is used by the routines at OUTCH1 and PRS1.
;DON'T PUT CR/LF OUT TO LOAD FILE
CRFIN:
  CALL ISFLIO           ;SEE IF OUTPUTTING TO DISK
  JR Z,CRCONT           ;NOT DISK FILE, CONTINUE
  XOR A                 ;CRFIN MUST ALWAYS RETURN WITH A=0
  RET                   ;AND CARRY=0.

; CRCONT
;
; Used by the routine at OUTDO_CRLF.
CRCONT:
  LD A,(PRTFLG)         ;GOING TO PRINTER?
  OR A                  ;TEST
  JR Z,NTPRTR           ;NO
  XOR A                 ;DONE, RETURN
  LD (LPTPOS),A         ;ZERO POSITON
  RET

; NTPRTR
;
; Used by the routine at CRCONT.
NTPRTR:
  XOR A                  ; Set to position 0       ;SET TTYPOS=0
  LD (TTYPOS),A          ; Store it
  LD A,(NULLS)           ; Get number of nulls     ;GET NUMBER OF NULLS
NULLP:
  DEC A                  ; Count them
  RET Z                  ; Return if done          ;ALL NULLS DONE [A]=0
                                                   ;SOME ROUTINES DEPEND ON CRDO
                                                   ;AND CRFIN RETURNING [A]=0 AND Z TRUE
  PUSH AF                ; Save count              ;SAVE THE COUNT
  XOR A                  ; Load a null             ;[A]= A NULL
  CALL OUTDO             ; Output it               ;SEND IT OUT
  POP AF                 ; Restore count           ;RESTORE THE COUNT
  JR NULLP               ; Keep counting           ;LOOP PRINTING NULLS

; TTY status check
;
; Used by the routine at __LIST.
ISCNTC:
  PUSH BC
  PUSH DE
  PUSH HL

  DEFB $CD                ; CALL nn      "GET CONSOLE STATUS"

; Data block at 19872
SMC_ISCNTC3:
  DEFW $0000

; Routine at 19874
L4DA2:
  POP HL
  POP DE
  POP BC
  OR A                    ;SET CC'S
  RET Z                   ;0=FALSE - NO CHARACTER TYPED
                          ;IF NONE, RETURN

; "STOP" pressed.  Now wait for ^O or ^C
;
; Used by the routine at NEWSTT_0.
STALL:
  CALL INCHRI             ; Get input and test for ^O     ;READ THE CHARACTER THAT WAS PRESENT
  CP $13                  ; Is it control "S"             ;PAUSE? (^S)
  CALL Z,INCHRI           ; Yes - Get another character   ;IF PAUSE, READ NEXT CHAR
  LD (CHARC),A            ;SAVE CHAR IN THE BUFFER
  CP $03                  ;^C?
  CALL Z,KILIN            ;TYPE ^C
  JP __STOP

; Routine at 19898
;
; Used by the routine at NTVARP.
FN_INKEY:
  CALL CHRGTB
  PUSH HL                 ;SAVE THE TEXT POINTER
  CALL CHARCG             ;GET CHARC AND CLEAR IF SET
  JR NZ,BUFCIN

  DEFB $CD                ; CALL nn

; Data block at 19909
SMC_ISCNTC2:
  DEFW $0000

; Routine at 19911
FN_INKEY_0:
  OR A               ;SET NON-ZERO IF CHAR THERE
  JR Z,NULRT         ;NO, RETURN NULL STRING

; GET CHAR IF ONE,
;****SOME VERSIONS ALREADY HAVE CHAR AND DONT WANT THIS CODE ***
;****SO THEY SHOULD TURN ON CHSEAT TO TURN OFF READS

  CALL INCHRI

; This entry point is used by the routine at FN_INKEY.
BUFCIN:
  PUSH AF
  CALL STRIN1           ;MAKE ONE CHAR STRING
  POP AF
  LD E,A                ;CHAR TO [D]
  CALL SETSTR           ;STUFF IN DESCRIPTOR AND GOTO PUTNEW

NULRT:
  LD HL,NULL_STRING
  LD (FACCU),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET

; This entry point is used by the routines at FN_INPUT and FN_INKEY.
CHARCG:
  LD A,(CHARC)          ;GET SAVED CHAR
  OR A                  ;IS THERE ONE?
  RET Z                 ;NO, DONE
  PUSH AF               ;SAVE CHAR
  XOR A                 ;CLEAR IT
  LD (CHARC),A          ;BY STORING ZERO
  POP AF                ;RESTORE CHAR AND NON-ZERO CC'S
  RET

; Output character, adj. CR/LF if necessary
;
; Used by the routines at LISPRT and NOTDGI.
OUTCH1:
  CALL OUTDO            ;OUTPUT THE CHAR
  CP $0A                ;WAS IT A LF?
  RET NZ                ;NO, RETURN
  LD A,$0D              ;DO CR
  CALL OUTDO
  CALL CRFIN
  LD A,$0A              ;RESTORE CHAR (LF)
  RET




; Routine at 21850
;
; Used by the routines at PROMPT and VARNOT.
MOVUP:
  CALL ENFMEM             ; See if enough memory
; This entry point is used by the routines at CAYSTR, NOTDGI and SCNEND.
MOVSTR:
  PUSH BC                 ; Save end of source
  EX (SP),HL              ; Swap source and dest" end
  POP BC                  ; Get end of destination
MOVLP:
  CALL DCOMPR             ; See if list moved
  LD A,(HL)               ; Get byte
  LD (BC),A               ; Move it
  RET Z                   ; Exit if all done
  DEC BC                  ; Next byte to move to
  DEC HL                  ; Next byte to move
  JR MOVLP                ; Loop until all bytes moved

; Check for C levels of stack
;
; Used by the routines at FORFND, __GOSUB, EVAL, DOFN, __CALL, SBSCPT and
; BSNTERC.
;
; THIS ROUTINE MUST BE CALLED BY ANY ROUTINE WHICH PUTS AN ARBITRARY
; AMOUNT OF STUFF ON THE STACK (I.E. ANY RECURSIVE ROUTINE LIKE FRMEVL)
; IT IS ALSO CALLED BY ROUTINES SUCH AS "GOSUB" AND "FOR" WHICH MAKE PERMANENT ENTRIES ON THE STACK
; ROUTINES WHICH MERELY USE AND FREE UP THE GUARANTEED NUMLEV STACK LOCATIONS NEED NOT CALL THIS
;
CHKSTK:
  PUSH HL                 ; Save code string address
  LD HL,(MEMSIZ)          ; Lowest free memory
  LD B,$00                ; BC = Number of levels to test
  ADD HL,BC               ; 2 Bytes for each level
  ADD HL,BC               ; SEE IF WE CAN HAVE THIS MANY
;
; [H,L]= SOME ADDRESS
; [H,L] IS EXAMINED TO MAKE SURE AT LEAST NUMLEV
; LOCATIONS REMAIN BETWEEN IT AND THE TOP OF THE STACK
;
  LD A,256-(2*NUMLEV)     ; -(2*NUMLEV) Bytes minimum RAM
  SUB L
  LD L,A
  LD A,$FF                ; (-1 for MSB) -(2*NUMLEV) Bytes minimum RAM
  SBC A,H
  LD H,A
  JR C,OM_ERR             ; Not enough - ?OM Error
  ADD HL,SP               ; Test if stack is overflowed
  POP HL                  ; Restore code string address
  RET C                   ; Return if enough memory

; This entry point is used by the routines at LOAD_OM_ERR, BSNTERC, __CLEAR
; and DONCMD.
OM_ERR:
  LD HL,(STKTOP)          ; "TOPMEM"
  DEC HL                  ; UP SOME MEMORY SPACE
  DEC HL                  ; MAKE SURE THE FNDFOR STOPPER IS SAVED
  LD (SAVSTK),HL          ; PLACE STACK IS RESTORED FROM 

; This entry point is used by the routine at ENFMEM.
_OM_ERR:
  LD DE,$0007             ; "OUT OF MEMORY"
  JP ERROR

; See if enough memory
;
; Used by the routines at BSNTERC, MOVUP and DONCMD.
ENFMEM:
  CALL REALLY             ;ENOUGH SPACE BETWEEN STRING & STACK
  RET NC                  ;YES

  LD A,(CHNFLG)           ; This extra check was not present on CP/M 5.20, nor on MSX 5.22
  OR A
  JR NZ,_OM_ERR

  PUSH BC                 ;SAVE ALL REGS
  PUSH DE
  PUSH HL
  CALL GARBGE             ;DO A GARBAGE COLLECTION
  POP HL                  ;RESTORE ALL REGS
  POP DE
  POP BC
  CALL REALLY             ;ENOUGH SPACE THIS TIME?
  RET NC                  ;YES
  JR _OM_ERR              ;NO, GIVE "OUT OF MEMORY BUT DONT TOUCH STACK

REALLY:
  PUSH DE                 ;SAVE [D,E]
  EX DE,HL                ;SAVE [H,L] IN [D,E]
  LD HL,(FRETOP)          ;GET WHERE STRINGS ARE
  CALL DCOMPR             ;IS TOP OF VARS LESS THAN STRINGS?
  EX DE,HL                ;BACK TO [D,E]
  POP DE                  ;RESTORE [D,E]
  RET                     ;DONE

; Clear memory, initialize files and reset
;
; Used by the routine at INITSA.
; THE CODE BELOW SETS THE FILE MODE TO 0 (CLOSED) FOR ALL FCB'S
NODSKS:
  LD A,(MAXFIL)           ;GET LARGEST FILE #
  LD B,A                  ;INTO B FOR COUNTER
  LD HL,FILPTR            ;POINT TO TABLE OF FILE DATA BLOCKS
  XOR A                   ;MAKE A ZERO TO MARK FILES AS CLOSED
  INC B
LOPNTO:
  LD E,(HL)               ;GET POINTER TO FILE DATA BLOCK IN [D,E]
  INC HL
  LD D,(HL)
  INC HL
  LD (DE),A               ;MARK FILE AS CLOSED (MODE ZERO)
  DJNZ LOPNTO             ;LOOP UNTIL DONE
  CALL CLSALL
  XOR A

;
; THE "NEW" COMMAND CLEARS THE PROGRAM TEXT AS WELL
; AS VARIABLE SPACE
;
__NEW:
  RET NZ                  ;MAKE SURE THERE IS A TERMINATOR

; This entry point is used by the routines at __LOAD and LOAD_OM_ERR.
CLRPTR:
  LD HL,(TXTTAB)          ;GET POINTER TO START OF TEXT
  CALL __TROFF            ;TURN OFF TRACE. SET [A]=0.
  LD (PROFLG),A           ;NO LONGER A PROTECTED FILE
  LD (AUTFLG),A           ;CLEAR AUTO MODE
  LD (PTRFLG),A           ;SAY NO POINTERS EXIST
  LD (HL),A               ;SAVE AT END OFF TEXT
  INC HL                  ;BUMP POINTER
  LD (HL),A               ;SAVE ZERO
  INC HL                  ;BUMP POINTER
  LD (VARTAB),HL          ;NEW START OF VARIABLES
  
; This entry point is used by the routines at PROMPT, ATOH, __LOAD and L4D05.
; a.k.a. RUNC
RUN_FST:
  LD HL,(TXTTAB)          ;POINT AT THE START OF TEXT
  DEC HL

;
; CLEARC IS A SUBROUTINE WHICH INITIALIZES THE VARIABLE AND
; ARRAY SPACE BY RESETING ARYTAB [THE END OF SIMPLE VARIABLE SPACE]
; AND STREND [THE END OF ARRAY STORAGE]. IT FALLS INTO STKINI
; WHICH RESETS THE STACK. [H,L] IS PRESERVED.
;
; This entry point is used by the routines at ATOH and CLVAR.
CLEARC:
  LD (TEMP),HL            ; Save code string address in TEMP                 ;SAVE [H,L] IN TEMP
IF HAVE_GFX
  CALL GRPRST             ;Reset graphics
ENDIF
  ;;CALL INITRP             ;INIT TRAP TABLE                                 ;Initialize trapping
  ;;CALL SNDINI             ;Initialize SOUND & PLAY
  LD A,(MRGFLG)           ;DOING A CHAIN MERGE?
  OR A                    ;TEST
  JR NZ,LEVDTB            ;LEAVE DEFAULT TABLE ALONE
  XOR A
  LD (OPTFLG),A           ;INDICATE NO "OPTION" HAS BEEN SEEN
  LD (OPTVAL),A           ;DEFAULT TO "OPTION BASE 0"
  LD B,26                 ;INITIALIZE THE DEFAULT VALTYPE TABLE
  LD HL,DEFTBL            ;POINT AT THE FIRST ENTRY
LOPDFT:
  LD (HL),$04             ;LOOP 26 TIMES STORING A DEFAULT VALTYP
  INC HL                  ;FOR SINGLE PRECISION
  ;DEC B                   ;COUNT OFF THE LETTERS
  DJNZ LOPDFT            ;LOOP BACK, AND SETUP THE REST OF THE TABLE
  
LEVDTB:
  LD DE,RND_COPY          ;RESET THE RANDOM NUMBER GENERATOR
  LD HL,RNDX              ;SEED IN RNDX
  CALL MOVE
  LD HL,SEED              ;AND ZERO COUNT REGISTERS
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  XOR A
  LD (ONEFLG),A           ;RESET ON ERROR FLAG FOR RUNS
  LD L,A                  ;RESET ERROR LINE NUMBER
  LD H,A                  ;BY SETTING ONELIN=0.
  LD (ONELIN),HL          ;Clear error line number
  LD (OLDTXT),HL          ;MAKE CONTINUING IMPOSSIBLE
  LD HL,(MEMSIZ)
  LD A,(CHNFLG)           ;ARE WE CHAINING?
  OR A                    ;TEST
  JR NZ,GOOD_FRETOP       ;FRETOP IS GOOD, LEAVE IT ALONE
  LD (FRETOP),HL          ;FREE UP STRING SPACE
GOOD_FRETOP:
  XOR A                   ;MAKE SURE [A] IS ZERO, CC'S SET
  CALL __RESTORE          ;RESTORE DATA
  LD HL,(VARTAB)          ;GET START OF VARIABLE SPACE
  LD (ARYTAB),HL          ;SAVE IN START OF ARRAY SPACE
  LD (STREND),HL          ;AND END OF VARIABLE STORAGE
  LD A,(MRGFLG)           ;DOING CHAIN MERGE?
  OR A
  CALL Z,CLSALL           ;IF SO, DONT CLOSE FILES...


; STKINI RESETS THE STACK POINTER ELIMINATING
; GOSUB & FOR CONTEXT.  STRING TEMPORARIES ARE FREED
; UP, SUBFLG IS RESET, CONTINUING IS DISALLOWED,
; AND A DUMMY ENTRY IS PUT ON THE STACK. THIS IS SO
; FNDFOR WILL ALWAYS FIND A NON-"FOR" ENTRY AT THE BOTTOM
; OF THE STACK. [A]=0 AND [D,E] IS PRESERVED.
;
; This entry point is used by the routine at INIT.
STKINI:
  POP BC                  ;GET RETURN ADDRESS HERE
  LD HL,(STKTOP)
  DEC HL                  ;TAKE INTO ACCOUNT FNDFOR STOPPER
  DEC HL
  LD (SAVSTK),HL          ;MAKE SURE SAVSTK OK JUST IN CASE.
  INC HL                  ;INCREMENT BACK FOR SPHL
  INC HL

; Clear registers and warm boot
;
; Used by the routine at TM_ERR.
STKERR:
  LD SP,HL                ;INITIALIZE STACK
  LD HL,TEMPST
  LD (TEMPPT),HL          ;INITIALIZE STRING TEMPORARIES
  CALL CLROVC             ;BACK TO NORMAL OVERFLOW PRINT MODE
  CALL FINLPT             ; "FINLPT"
  CALL FINPRT             ;CLEAR PTRFIL, OTHER I/O FLAGS
  XOR A                   ;ZERO OUT HL and A
  LD H,A
  LD L,A
  LD (PRMLEN),HL          ;FLAG NO ACTIVE PARAMETERS
  LD (NOFUNS),A           ;INDICATE NO USER FUNCTIONS ACTIVE
  LD (PRMLN2),HL          ;NO PARAMETERS BEING BUILT
  LD (FUNACT),HL          ;SET NUMBER OF FUNCTIONS ACTIVE TO 0
  LD (PRMSTK),HL          ;AND NO PARAMETER BLOCKS ON THE STACK
  LD (SUBFLG),A           ;ALLOW SUBSCRIPTS
  PUSH HL                 ;PUT ZERO (NON $FOR,$GOSUB) ON THE STACK
  PUSH BC                 ;PUT RETURN ADDRESS BACK ON

; This entry point is used by the routines at __OPEN, __LOAD and __GET.
GTMPRT:
  LD HL,(TEMP)            ;Restore code string address                       ;GET SAVED [H,L]
  RET

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at BAKSTK, _ERROR_REPORT, PROMPT, SRCHLP, __FOR, ATOH,
; __GOTO, __LET, DOFN, __LIST, __DELETE, __RENUM, __OPTION, MULTEN,
; DDIV_SUB, __LOAD, __MERGE, __FIELD, __LSET, __WEND, __CHAIN, BCKUCM,
; DNCMDA, CAYSTR, __GET, VARNOT, SBSCPT, ZERARY, MOVUP, ENFMEM, __TROFF,
; __ERASE, __CLEAR, __NEXT, PUTTMP, GRBDON, TVAR, ARRLP, ARYSTR, STRADD,
; GSTRDE, FRETMS and FN_INSTR.
DCOMPR:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; (a.k.a. CHKSYN) Check syntax, 1 byte follows to be compared
;
; Used by the routines at LNUM_RANGE, __FOR, FORFND, __LET, __ON, __AUTO, __IF,
; LNOMOD, __LINE, __INPUT, __READ, FRMEQL, OPNPAR, __ERL, EVLPAR,
; ISFUN, DEF_USR, __DEF, DOFN, GETFNM, __WAIT, SETIO, __POKE, __RENUM,
; __OPTION, SCNCNT, __NAME, __OPEN, FILGET, __LOAD, __MERGE, __FIELD,
; FN_INPUT, __CALL, __CHAIN, BCKUCM, CAYSTR, DIMRET, __USING, __TROFF, __CLEAR,
; FN_STRING, LFRGNM, FN_INSTR, MID_ARGSEP and INIT.
SYNCHR:
  LD A,(HL)         ; Check syntax of character
  EX (SP),HL        ; Address of test byte
  CP (HL)           ; Same as in code string?         ;CMPC-IS CHAR THE RIGHT ONE?
IF ORIGINAL
  JR NZ,SYNCHR_0    ; Different - ?SN Error           ;GIVE ERROR IF CHARS DONT MATCH
ELSE
  JP NZ,SN_ERR      ; Different - ?SN Error           ;GIVE ERROR IF CHARS DONT MATCH
ENDIF
  INC HL            ; Point to next character         ;DUPLICATION OF CHRGET RST FOR SPEED
  EX (SP),HL        ; Get next code string byte       ;SEE CHRGET RST FOR EXPLANATION
  INC HL            ;LOOK AT NEXT CHAR
  LD A,(HL)         ; Get next code string byte       ;SEE CHRGET RST FOR EXPLANATION
  CP ':'            ; Z if ":"                        ;IS IT END OF STATMENT OR BIGGER
  RET NC
  JP CHRCON         ;REST OF CHRGET

IF ORIGINAL
SYNCHR_0:
  JP SN_ERR
ENDIF

; This entry point is used by the routine at __NEW.
__RESTORE:
  EX DE,HL          ; Save code string address
  LD HL,(TXTTAB)    ; Point to start of program
  JR Z,BGNRST       ; Just RESTORE - reset pointer            ;RESTORE DATA POINTER TO BEGINNING OF PROGRAM
  EX DE,HL          ; Restore code string address             ;TEXT POINTER BACK TO [H,L]
  CALL ATOH         ; Get line number to DE                   ;GET THE FOLLOWING LINE NUMBER
  PUSH HL           ; Save code string address                ;SAVE TEXT POINTER
  CALL SRCHLN       ; Search for line number in DE            ;FIND THE LINE NUMBER
  LD H,B            ; HL = Address of line                    ;GET POINTER TO LINE in HL
  LD L,C
  POP DE            ; Restore code string address             ;TEXT POINTER BACK TO [D,E]
  JP NC,UL_ERR      ; ?UL Error if not found                  ;SHOULD HAVE FOUND LINE

; a.k.a. RESTNL
BGNRST:
  DEC HL            ; Byte before DATA statement              ;INITIALIZE DATPTR TO [TXTTAB]-1

; This entry point is used by the routine at LTSTND.
; a.k.a. RESFIN
UPDATA:
  LD (DATPTR),HL    ; Update DATA pointer                     ;READ FINISHES COME TO RESFIN
  EX DE,HL          ; Restore code string address             ;GET THE TEXT POINTER BACK
  RET

; 'STOP' BASIC command
;
; Used by the routine at STALL.
__STOP:
  RET NZ            ;RETURN IF NOT CONTROL-C AND MAKE
  INC A             ;SURE "STOP" STATEMENTS HAVE A TERMINATOR
  JR __END_0

; 'END' BASIC command
__END:
  RET NZ            ;MAKE SURE "END" STATEMENTS HAVE A TERMINATOR
  PUSH AF           ;PRESERVE CONDITION CODES OVER CALL TO CLSALL
  CALL Z,CLSALL
  POP AF            ;RESTORE CONDITION CODES
; This entry point is used by the routine at __STOP.
__END_0:
  LD (SAVTXT),HL    ;SAVE FOR "CONTINUE"
  LD HL,TEMPST      ;RESET STRING TEMP POINTER
  LD (TEMPPT),HL    ;SAVE IN CASE ^C PRINT USING
  
  DEFB $21                ; "LD HL,nn" to jump over the next word without executing it

; Get here if the "INPUT" sequence was interrupted
;
; Used by the routines at __LINE, NOTQTI and __RANDOMIZE.
INPBRK:
  OR $FF            ;SET NON-ZERO TO FORCE PRINTING OF BREAK MESSAGE
  POP BC            ;POP OFF NEWSTT ADDRESS


; This entry point is used by the routines at WARM_BT and FN_INPUT.
ENDCON:
  LD HL,(CURLIN)          ; Get current line number
  PUSH HL
  PUSH AF                 ; Save STOP / END statusct break?
  LD A,L                  ; Is it direct break?
  AND H
  INC A                   ; Line is -1 if direct break
  JR Z,NOLIN              ; Yes - No line number
  LD (OLDLIN),HL          ; Save line of break
  LD HL,(SAVTXT)          ; Get point of break
  LD (OLDTXT),HL          ; Save point to CONTinue
NOLIN:
  XOR A
  LD (CTLOFG),A           ; Enable output
  CALL FINLPT             ; Disable printer echo if enabled
  CALL CONSOLE_CRLF
  POP AF                  ; Restore STOP / END status
  LD HL,BREAK_MSG         ; "Break" message
  JP NZ,_ERROR_REPORT     ; "in line" wanted?  if so, CALL STROUT AND FALL INTO READY
  JP RESTART              ; Go to command mode   (POP OFF LINE NUMBER & FALL INTO READY)

; This entry point is used by the routine at L4D46.
CTROPT:
  LD A,$0F                ;PRINT AN ^O.

; This entry point is used by the routines at TTYLIN and STALL.
KILIN:
  PUSH AF                 ;SAVE CURRENT CHAR
  SUB $03                 ;CONTROL-C?
  JR NZ,NTCTCT
  LD (PRTFLG),A           ;DISPLAY ^C ONLY(NOT ON LPT)
  LD (CTLOFG),A           ;RESET ^O FLAG

; Display the pressed CTL-key sequence, e.g. ^C
;
; Used by the routine at INPBRK.
NTCTCT:
  LD A,'^'                ;PRINT UP-ARROW.
  CALL OUTDO              ;SEND IT
  POP AF                  ;GET BACK CONTROL CHAR.
  ADD A,$40               ;MAKE PRINTABLE
  CALL OUTDO              ;SEND IT
  JP OUTDO_CRLF           ;AND THEN SEND CRLF.

; 'CONT' BASIC command
__CONT:
  LD HL,(OLDTXT)          ; Get CONTinue address
  LD A,H                  ; Is it zero?
  OR L
  LD DE,$0011             ; Err $11 - "Can't continue"
  JP Z,ERROR
  EX DE,HL                ; Save code string address
  LD HL,(OLDLIN)          ; Get line of last break
IF ORIGINAL
  EX DE,HL                ; Useless side effect got by macros
  EX DE,HL                ;    ..here we probably had 2 consequent DE fetch/store operations 
ENDIF
  LD (CURLIN),HL          ; Set up current line number
  EX DE,HL                ; Restore code string address
  RET                     ; CONTinue where left off

; 'NULL' BASIC function
__NULL:
  CALL GETINT             ; Get integer 0-255
  RET NZ                  ; Return if bad value
  INC A
  LD (NULLS),A            ; Set nulls number
  RET

; 'TRON' (TRACE ON) BASIC command
__TRON:
  DEFB $3E                ; "LD A,175" (NON-ZERO QUANTITY) and Mask the next byte

; 'TROFF' (TRACE OFF) BASIC command
;
; Used by the routine at __NEW.
__TROFF:
  XOR A                   ;MAKE [A]=0 FOR NO TRACE
  LD (TRCFLG),A           ;UPDATE THE TRACE FLAG
  RET

__SWAP:
  CALL GETVAR             ;[D,E]=POINTER AT VALUE #1
  PUSH DE                 ;SAVE THE POINTER AT VALUE #1
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD HL,SWPTMP            ;TEMPORARY STORE LOCATION
  CALL VMOVE              ;SWPTMP=VALUE #1
  LD HL,(ARYTAB)          ;GET ARYTAB SO CHANGE CAN BE NOTED
  EX (SP),HL              ;GET THE TEXT POINTER BACK AND SAVE CURRENT [ARYTAB]
  CALL GETYPR
  PUSH AF                 ;SAVE THE TYPE OF VALUE #1
  CALL SYNCHR
  DEFM ","                ;MAKE SURE THE VARIABLES ARE DELIMITED BY A COMMA
  CALL GETVAR             ;[D,E]=POINTER AT VALUE #2
  POP AF                  ; (possible optimization: POP BC?)
  LD B,A                  ;[B]=TYPE OF VALUE #1
  CALL GETYPR             ;[A]=TYPE OF VALUE #2
  CP B                    ;MAKE SURE THEY ARE THE SAME
  JP NZ,TM_ERR            ;IF NOT, "TYPE MISMATCH" ERROR
  EX (SP),HL              ;[H,L]=OLD [ARYTAB] SAVE THE TEXT POINTER
  EX DE,HL                ;[D,E]=OLD [ARYTAB]
  PUSH HL                 ;SAVE THE POINTER AT VALUE #2
  LD HL,(ARYTAB)          ;GET NEW [ARYTAB]
  CALL DCOMPR
  JR NZ,FCERR             ;IF ITS CHANGED, ERROR
  POP DE                  ;[D,E]=POINTER AT VALUE #2
  POP HL                  ;[H,L]=TEXT POINTER
  EX (SP),HL              ;SAVE THE TEXT POINTER ON THE STACK, [H,L]=POINTER AT VALUE #1
  PUSH DE                 ;SAVE THE POINTER AT VALUE #2
  CALL VMOVE              ;TRANSFER VALUE #2 INTO VALUE #1'S OLD POSITION
  POP HL                  ;[H,L]=POINTER AT VALUE #2
  LD DE,SWPTMP            ;LOCATION OF VALUE #1
  CALL VMOVE              ;TRANSFER SWPTMP=VALUE #1 INTO VALUE #2'S OLD POSITION
  POP HL                  ;GET THE TEXT POINTER BACK
  RET

; This entry point is used by the routine at __ERASE.
FCERR:
  JP FC_ERR

; 'ERASE' BASIC command
__ERASE:
  LD A,$01
  LD (SUBFLG),A           ;THAT THIS IS "ERASE" CALLING PTRGET
  CALL GETVAR             ;GO FIND OUT WHERE TO ERASE
  JR NZ,FCERR             ;PTRGET DID NOT FIND VARIABLE!
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD (SUBFLG),A           ;ZERO OUT SUBFLG TO RESET "ERASE" FLAG
  LD H,B                  ;[B,C]=START OF ARRAY TO ERASE
  LD L,C
  DEC BC                  ;BACK UP TO THE FRONT
  DEC BC                  ;NO VALUE TYPE WITHOUT LENGTH=2
  DEC BC                  ;BACK UP ONE MORE

__ERASE_0:
  LD A,(BC)               ;GET A CHARACTER. ONLY THE COUNT HAS HIGH BIT=0
  DEC BC                  ;SO LOOP UNTIL WE SKIP OVER THE COUNT
  OR A                    ;SKIP ALL THE EXTRA CHARACTERS
  JP M,__ERASE_0
  DEC BC
  DEC BC
  ADD HL,DE               ;[H,L]=THE END OF THIS ARRAY ENTRY
  EX DE,HL                ;[D,E]=END OF THIS ARRAY
  LD HL,(STREND)          ;[H,L]=LAST LOCATION TO MOVE UP

__ERASE_LP:
  CALL DCOMPR             ;SEE IF THE LAST LOCATION IS GOING TO BE MOVED
  LD A,(DE)               ;DO THE MOVE
  LD (BC),A              
  INC DE                  ;UPDATE THE POINTERS
  INC BC
  JR NZ,__ERASE_LP        ;MOVE THE REST
  DEC BC                   
  LD H,B                  ;SETUP THE NEW STORAGE END POINTER
  LD L,C
  LD (STREND),HL
  POP HL                  ;GET BACK THE TEXT POINTER
  LD A,(HL)               ;SEE IF MORE ERASURES NEEDED
  CP ','                  ;ADDITIONAL VARIABLES DELIMITED BY COMMA
  RET NZ                  ;ALL DONE IF NOT
  CALL CHRGTB
  JR __ERASE

; This entry point is used by the routine at __LOF.
POPAHT:
  POP AF
  POP HL                  ;GET THE TEXT POINTER
  RET

; Load A with char in (HL) and check it is a letter:
;
; Used by the routines at DEFCON and GETVAR.
CHKLTR:
  LD A,(HL)

; Check char in 'A' being in the 'A'..'Z' range
;
; Used by the routines at CRNCLP, NOTRES, OPRND, OCTCNS, LISPRT and GETVAR.
ISLETTER_A:
  CP 'A'            ; < "A" ?
  RET C             ; Carry set if not letter
  CP 'Z'+1          ; > "Z" ?
  CCF               
  RET               ; Carry set if not letter

; Routine at 22454
;
; Used by the routine at __CLEAR.
CLVAR:
  JP CLEARC

; 'CLEAR' BASIC command
;
; To set all numeric variables to zero and all string variables to null; and, optionally,
; to set the end of memory and the amount of stack space.
;
; CLEAR [,[<expressionl>] [,<expression2>]]
__CLEAR:
  JR Z,CLVAR              ; Just "CLEAR" Keep parameters    ;IF NO FORMULA JUST CLEAR
  CP ','                  ;ALLOW NO STRING SPACE
  JR Z,__CLEAR_0
  CALL INTIDX_0           ;GET AN INTEGER INTO [D,E]
  DEC HL
  CALL CHRGTB             ; Get next character, SEE IF ITS THE END
  JR Z,CLVAR

__CLEAR_0:
  CALL SYNCHR
  DEFM ","
  JR Z,CLVAR
  LD DE,(STKTOP)          ;GET HIGHEST ADDRESS
  CP ','
  JR Z,__CLEAR_1          ; No value given - Use stored           ;SHOULD FINISH THERE
  CALL POSINT             ; Get integer to DE

__CLEAR_1:
  DEC HL                  ; Cancel increment   (BACK UP)
  CALL CHRGTB             ;GET CHAR
  PUSH DE                 ;SAVE NEW HIGH MEM
  JR Z,CDFSTK             ;USE SAME STACK SIZE
  CALL SYNCHR             ; Check for comma
  DEFM ","
  JR Z,CDFSTK
  CALL POSINT             ; Get integer to DE
  DEC HL                  ; Cancel increment
  CALL CHRGTB             ; Get next character
  JP NZ,SN_ERR            ; ?SN Error if more on line

CLEART:
  EX (SP),HL              ; Save code string address
  PUSH HL                 ; Save code string address (again)
  LD HL,0+(NUMLEV*2)+20   ; CHECK STACK SIZE IS REASONABLE
  CALL DCOMPR
  JR NC,OMERR
  POP HL                  ; [HL]=candidate for TOPMEM                         ; Restore code string address (1st copy)
  CALL SUBDE              ; DE=HL-DE=High Ram - Stack Size=new stack bottom   ; SUBTRACT [H,L]-[D,E] INTO [D,E]
  JR C,OMERR              ; WANTED MORE THAN TOTAL!

  PUSH HL                 ; Save RAM top                       ;SAVE STACK BOTTOM
  LD HL,(VARTAB)          ; Get program end                    ;TOP LOCATION IN USE
  LD BC,20                ; 20 Bytes minimum working RAM       ;LEAVE BREATHING ROOM
  ADD HL,BC               ; Get lowest address
  CALL DCOMPR             ; Enough memory?
  JR NC,OMERR             ; No - ?OM Error
  EX DE,HL                ; RAM top to HL
  LD (MEMSIZ),HL          ; Set new string space
  POP HL                  ; End of memory to use
  LD (STKTOP),HL          ; Set new top of RAM
  POP HL                  ; Restore code string address
  JR CLVAR                ; Initialise variables


POSINT:
  CALL GETWORD            ; Get integer
  LD A,D
  OR E
  JP Z,FC_ERR
  RET

OMERR:
  JP OM_ERR


CDFSTK:
  PUSH HL
  LD HL,(STKTOP)          ;FIGURE OUT CURRENT STACK SIZE
  EX DE,HL
  LD HL,(MEMSIZ)
  LD A,E                  ;SUB DX,STKLOW
  SUB L
  LD E,A
  LD A,D
  SBC A,H
  LD D,A
  POP HL
  JR CLEART

;SUBTRACT [H,L]-[D,E] INTO [D,E]
SUBDE:
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  RET



; A "FOR" ENTRY ON THE STACK HAS THE FOLLOWING FORMAT:
;
; LOW ADDRESS
;	TOKEN ($FOR IN HIGH BYTE)  1 BYTES
;	A POINTER TO THE LOOP VARIABLE  2 BYTES
;	UNDER ANSI & LENGTH=2, TWO BYTES GIVING TEXT POINTER OF MATCHING "NEXT"
;	A BYTE REFLECTING THE SIGN OF THE INCREMENT 1 BYTE
;	UNDER LENGTH=2, A BYTE MINUS FOR INTEGER AND POSITIVE FOR FLOATING "FOR"S
;	THE STEP 4 BYTES
;	THE UPPER VALUE 4 BYTES
;	THE LINE # OF THE "FOR" STATEMENT 2 BYTES
;	A TEXT POINTER INTO THE "FOR" STATEMENT 2 BYTES
; HIGH ADDRESS
;
; TOTAL 16-19 BYTES
;

; 'NEXT' BASIC command
__NEXT:
  PUSH AF                 ;SAVE THE CHARACTER CODES
  DEFB $F6                ; "OR n" to Mask 'XOR A';   SET [A] NON-ZERO
; This entry point is used by the routine at SAVSTP.
__NEXT_0:
  XOR A                   ;FLAG THAT "FOR" IS USING "NEXT"
  LD (NEXFLG),A
  POP AF                  ; GET BACK THE CHARACTER CODE 
  LD DE,$0000             ; In case no index given ("NEXT" STATEMENT WITHOUT ANY ARGS)

; This entry point is used by the routine at KILFOR.
__NEXT_1:
  LD (NEXTMP),HL          ; SAVE STARTING TEXT POINTER
  CALL NZ,GETVAR          ; not end of statement, locate variable (Get index address)
  LD (TEMP),HL            ; Save code string address
  CALL BAKSTK             ; Look for "FOR" block
  JP NZ,NF_ERR            ; No "FOR" - ?NF Error
  LD SP,HL                ; Clear nested loops  (SETUP STACK POINTER BY CHOPPING AT THIS POINT)
  PUSH DE                 ; PUT THE VARIABLE PTR BACK ON
  LD E,(HL)               ; PICK UP THE CORRECT "NEXT" TEXT POINTER
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL                 ; SAVE THE POINTER INTO THE STACK ENTRY
  LD HL,(NEXTMP)          ; [H,L]=TEXT POINTER AT THE START OF THIS "NEXT"
  CALL DCOMPR
  JP NZ,NF_ERR            ; IF NO MATCH, "NEXT WITHOUT FOR"
  POP HL
  POP DE                  ; GET BACK THE VARIABLE POINTER
  PUSH DE
  LD A,(HL)               ; STEP ONTO THE STACK
  PUSH AF
  INC HL
  PUSH DE                 ; PUT THE POINTER TO THE LOOP VARIABLE ONTO THE STACK
  LD A,(HL)               ; GET FLAG WHETHER THIS IS AN INTEGER "FOR"
  INC HL                  ; ADVANCE THE "FOR" ENTRY POINTER
  OR A                    ; SET THE MINUS FLAG IF IT'S AN INTEGER "FOR"
  JP M,INTNXT             ; HANDLE INTEGERS SEPERATELY
  CALL MOVFM              ; STEP VALUE INTO THE FAC
  EX (SP),HL              ; PUT THE POINTER INTO THE FOR ENTRY ONTO THE STACK
  PUSH HL                 ; PUT THE POINTER TO THE LOOP VARIABLE BACK ONTO THE STACK
  LD A,(NEXFLG)           ; IS "FOR" USING "NEXT"
  OR A
  JR NZ,NXTDO             ; NO, CONTINUE "NEXT"
  LD HL,FVALSV            ; FETCH THE INITIAL VALUE INTO THE FAC
  CALL MOVFM
  XOR A                   ; CONTINUE THE "NEXT" WITH INITIAL VALUE

NXTDO:
  CALL NZ,FADDS
  POP HL                  ; POP OFF THE POINTER TO THE LOOP VARIABLE
  CALL FPTHL              ; MOV FAC INTO LOOP VARIABLE
  POP HL                  ; GET THE ENTRY POINTER
  CALL LOADFP             ; GET THE FINAL INTO THE REGISTERS
  PUSH HL                 ; SAVE THE ENTRY POINTER
  CALL FCOMP              ; COMPARE THE NUMBERS RETURNING $FF IF FAC IS LESS THAN THE REGISTERS,
                          ; 0 IF EQUAL, OTHERWISE 1
  JR __NEXT_6             ; SKIP OVER INTEGER CODE

INTNXT:
  INC HL                  ; SKIP THE FOUR DUMMY BYTES
  INC HL
  INC HL
  INC HL
  LD C,(HL)               ; [B,C]= THE STEP
  INC HL
  LD B,(HL)
  INC HL
  EX (SP),HL	          ; SAVE THE ENTRY POINTER ON THE STACK AND SET [H,L]=POINTER TO THE LOOP VARIABLE
  LD E,(HL)               ; [D,E]=LOOP VARIABLE VALUE
  INC HL
  LD D,(HL)
  PUSH HL                 ; SAVE THE POINTER AT THE LOOP VARIABLE VALUE
  LD L,C
  LD H,B                  ; SETUP TO ADD [D,E] TO [H,L]
  LD A,(NEXFLG)           ; SEE IF "FOR" IS USING "NEXT"
  OR A
  JR NZ,INXTDO            ; NO, JUST CONTINUE NEXT
  LD HL,(FVALSV)          ; GET THE INITIAL VALUE
  JR IFORIN               ; CONTINUE FIRST ITERATION CHECK

INXTDO:
  CALL IADD               ; ADD THE STEP TO THE LOOP VARIABLE
  LD A,(VALTYP)           ; SEE IF THERE WAS OVERFLOW
  CP $04                  ; TURNED TO SINGLE-PRECISION?
  JP Z,OV_ERR             ; INDICE GOT TOO LARGE
IFORIN:                   
  EX DE,HL                ; [D,E]=NEW LOOP VARIABLE VALUE
  POP HL                  ; GET THE POINTER AT THE LOOP VARIABLE
  LD (HL),D               ; STORE THE NEW VALUE
  DEC HL
  LD (HL),E
  POP HL                  ; GET BACK THE POINTER INTO THE "FOR" ENTRY
  PUSH DE                 ; SAVE THE VALUE OF THE LOOP VARIABLE
  LD E,(HL)               ; [D,E]=FINAL VALUE
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL              ; SAVE THE ENTRY POINTER AGAIN, GET THE VALUE OF THE LOOP VARIABLE INTO [H,L]
  CALL ICOMP              ; DO THE COMPARE
__NEXT_6:
  POP HL                  ; POP OFF THE "FOR" ENTRY POINTER WHICH IS NOW POINTING PAST THE FINAL VALUE
  POP BC                  ; GET THE SIGN OF THE INCREMENT
  SUB B                   ; SUBTRACT THE INCREMENTS SIGN FROM THAT OF (CURRENT VALUE-FINAL VALUE)
  CALL LOADFP             ; GET LINE # OF "FOR" INTO [D,E]
  JR Z,KILFOR             ; IF SIGN(FINAL-CURRENT)+SIGN(STEP)=0, then loop finished - Terminate it
  EX DE,HL                ; Loop statement line number
  LD (CURLIN),HL          ; Set loop line number
  LD L,C                  ; Set code string to loop
  LD H,B
  JP PUTFID

; Remove "FOR" block
;
; Used by the routine at __NEXT.
KILFOR:
  LD SP,HL                ; SINCE [H,L] MOVED ALL THE WAY DOWN THE ENTRY
  LD (SAVSTK),HL          ; Code string after "NEXT"
  LD HL,(TEMP)            ; RESTORE THE TEXT POINTER
  LD A,(HL)               ; Get next byte in code string
  CP ','                  ; More NEXTs ?
  JP NZ,NEWSTT         ; No - Do next statement
  CALL CHRGTB             ; Position to index name
  CALL __NEXT_1           ; Re-enter NEXT routine
; < will not RETurn to here , Exit to NEWSTT (RUNCNT) or Loop >


; Tests if I/O to device is taking place
; Older MBASIC versions simply checked whether PTRFIL was zero
;
; Used by the routines at PRNTST, PRNTNB, __TAB, LNOMOD, __READ, __LIST, OUTDO,
; L4D05 and OUTDO_CRLF.
ISFLIO:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  POP HL
  RET


;
; THE FOLLOWING ROUTINE COMPARES TWO STRINGS
; ONE WITH DESC IN [D,E] OTHER WITH DESC. IN [FACLO, FACLO+1]
; A=0 IF STRINGS EQUAL
; A=377 IF B,C,D,E .GT. FACLO
; A=1 IF B,C,D,E .LT. FACLO
;
STRCMP:
  CALL GETSTR              ; Get current string              ;FREE UP THE FAC STRING, AND GET THE POINTER TO THE FAC DESCRIPTOR IN [H,L]
  LD A,(HL)                ; Get length of string            ;SAVE THE LENGTH OF THE FAC STRING IN [A]
  INC HL
  LD C,(HL)                ; Get LSB of address              ;SAVE THE POINTER AT THE FAC STRING DATA IN [B,C]
  INC HL
  LD B,(HL)
  POP DE                   ; Restore string name             ;GET THE STACK STRING POINTER
  PUSH BC                  ; Save address of string          ;SAVE THE POINTER AT THE FAC STRING DATA
  PUSH AF                  ; Save length of string           ;SAVE THE FAC STRING LENGTH
  CALL GSTRDE              ; Get second string               ;FREE UP THE STACK STRING AND RETURN
                                                             ;THE POINTER TO THE STACK STRING DESCRIPTOR IN [H,L]
  POP AF                   ; Restore length of string 1
  LD D,A                   ; Length to D                     ;[D]=LENGTH OF FAC STRING
  LD E,(HL)                                                  ;[E]=LENGTH OF STACK STRING
  INC HL
  LD C,(HL)                                                  ;[B,C]=POINTER AT STACK STRING
  INC HL
  LD B,(HL)
  POP HL                   ; Restore address of string 1     ;GET BACK 2ND CHARACTER POINTER

; a.k.a. CMPSTR
CSLOOP:
  LD A,E                   ; Bytes of string 2 to do         ;BOTH STRINGS ENDED
  OR D                     ; Bytes of string 1 to do         ;TEST BY OR'ING THE LENGTHS TOGETHER
  RET Z                    ; Exit if all bytes compared      ;IF SO, RETURN WITH A ZERO
  LD A,D                   ; Get bytes of string 1 to do     ;GET FACLO STRING LENGTH
  SUB 1                                                      ;SET CARRY AND MAKE [A]=255 IF [D]=0
  RET C                    ; Exit if end of string 1         ;RETURN IF THAT STRING ENDED
  XOR A                                                      ;MUST NOT HAVE BEEN ZERO, TEST CASE
  CP E                     ; Bytes of string 2 to do         ;OF B,C,D,E STRING HAVING ENDED FIRST
  INC A                                                      ;RETURN WITH A=1
  RET NC                   ; Exit if end of string 2         ;TEST THE CONDITION

; a.k.a. CMPRES
;HERE WHEN NEITHER STRING ENDED
  DEC D                    ; Count bytes in string 1         ;DECREMENT BOTH CHARACTER COUNTS
  DEC E                    ; Count bytes in string 2
  LD A,(BC)                ; Byte in string 2                ;GET CHARACTER FROM B,C,D,E STRING
  INC BC                   ; Move up string 2
  CP (HL)                  ; Compare to byte in string 1     ;COMPARE WITH FACLO STRING
  INC HL                   ; Move up string 1                ;BUMP POINTERS (INX DOESNT CLOBBER CC'S)
  JR Z,CSLOOP              ; Same - Try next bytes           ;IF BOTH THE SAME, MUST BE MORE TO STRINGS
  CCF                      ; Flag difference (">" or "<")    ;HERE WHEN STRINGS DIFFER
  JP SIGNS                 ; "<" gives -1 , ">" gives +1     ;SET [A] ACCORDING TO CARRY


; 'OCT$' BASIC function
;
; THE STRO$ FUNCTION TAKES A NUMBER AND GIVES
; A STRING WITH THE CHARACTERS THE NUMBER WOULD GIVE IF OUTPUT IN OCTAL
;
__OCT_S:
  CALL FOUTO             ;PUT OCTAL NUMBER IN FBUFFR
  JR __STR_S_0             ;JUMP INTO STR$ CODE

; 'HEX$' BASIC function
; STRH$ SAME AS STRO$ EXCEPT USES HEX INSTEAD OF OCTAL
__HEX_S:
  CALL FOUTH             ;PUT HEX NUMBER IN FBUFFR
  JR __STR_S_0             ;JUMP INTO STR$ CODE

; 'STR$' BASIC function
;
; THE STR$ FUNCTION TAKES A NUMBER AND GIVES
; A STRING WITH THE CHARACTERS THE OUTPUT OF THE NUMBER
; WOULD HAVE GIVEN
;
__STR_S:                                                    ;IS A NUMERIC
  CALL FOUT               ; Turn number into text           ;DO ITS OUTPUT
; This entry point is used by the routines at __OCT_S and __HEX_S.
__STR_S_0:
  CALL CRTST              ; Create string entry for it      ;SCAN IT AND TURN IT INTO A STRING
  CALL GSTRCU             ; Current string to pool          ;FREE UP THE TEMP

; Save string in string area
SAVSTR:
  LD BC,TOPOOL            ; Save in string pool
  PUSH BC                 ; Save address on stack           ;SET UP ANSWER IN NEW TEMP

;
; STRCPY CREATES A COPY OF THE STRING WHOSE DESCRIPTOR IS POINTED TO BY [H,L].
; ON RETURN [D,E] POINTS TO DSCTMP WHICH HAS THE STRING INFO (LENGTH, WHERE COPIED TO)
;
; This entry point is used by the routines at __LET, DOFN, CAYSTR and FN_INSTR.
STRCPY:
  LD A,(HL)               ; Get string length                    ;GET LENGTH
  INC HL                                                         ;MOVE UP TO THE POINTER
  PUSH HL                 ; Save pointer to string               ;GET POINTER TO POINTER OF ARG
  CALL TESTR              ; See if enough string space           ;GET THE SPACE
  POP HL                  ; Restore pointer to string            ;FIND OUT WHERE STRING TO COPY
  LD C,(HL)               ; Get LSB of address
  INC HL
  LD B,(HL)               ; Get MSB of address
  CALL CRTMST             ; Create string entry                  ;SETUP DSCTMP
  PUSH HL                 ; Save pointer to MSB of addr          ;SAVE POINTER TO DSCTMP
  LD L,A                  ; Length of string                     ;GET CHARACTER COUNT INTO [L]
  CALL TOSTRA             ; Move to string area                  ;MOVE THE CHARS IN
  POP DE                  ; Restore pointer to MSB               ;RESTORE POINTER TO DSCTMP
  RET                                                            ;RETURN

; This entry point is used by the routines at FN_INKEY_0 and __CHR_S.
STRIN1:
  LD A,$01                ;MAKE ONE CHAR STRING (CHR$, INKEY$)

; Make temporary string
;GET SOME STRING SPACE ([A] CHARS)
;
; Used by the routines at __MKD_S, __LSET, FN_INPUT, CONCAT and __SPACE_S.
MKTMST:
  CALL TESTR              ; See if enough string space

; Create temporary string entry
;
; Used by the routines at SAVSTR, DTSTR and ALLFOL.
CRTMST:
  LD HL,DSCTMP            ; Temporary string          ;GET DESC. TEMP
  PUSH HL                 ; Save it                   ;SAVE DESC. POINTER
  LD (HL),A               ; Save length of string     ;SAVE CHARACTER COUNT
;PUTDEI:   (a.k.a. SVSTAD)
  INC HL                                              ;STORE [D,E]=POINTER TO FREE SPACE
  LD (HL),E               ; Save LSB of address
  INC HL
  LD (HL),D               ; Save MSB of address
  POP HL                  ; Restore pointer           ;AND RESTORE [H,L] AS THE DESCRIPTOR POINTER
  RET

; Create String
;
; Used by the routines at __PRINT, CAYSTR, __STR_S and PRS.
CRTST:
  DEC HL                  ; DEC - INCed after


;
; STRLT2 TAKES THE STRING LITERAL WHOSE FIRST CHARACTER IS POINTED BY [H,L]+1 AND BUILDS A DESCRIPTOR FOR IT.
; THE DESCRIPTOR IS INITIALLY BUILT IN DSCTMP, BUT PUTNEW TRANSFERS IT INTO A TEMPORARY AND LEAVES A POINTER
; AT THE TEMPORARY IN FACLO. THE CHARACTERS OTHER THAN ZERO THAT TERMINATE THE STRING SHOULD BE SET UP IN [B]
; AND [D]. IT THE TERMINATOR IS A QUOTE, THE QUOTE IS SKIPPED OVER.
; LEADING QUOTES SHOULD BE SKIPPED BEFORE CALL. ON RETURN THE CHARACTER AFTER THE STRING LITERAL IS POINTED TO
; BY [H,L] AND IS IN [A], BUT THE CONDITION CODES ARE NOT SET UP.
;
; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
; a.k.a. STRLTI
QTSTR:
  LD B,'"'                ; Terminating quote               ;ASSUME STR ENDS ON QUOTE
; This entry point is used by the routine at __LINE.
QTSTR_0:
  LD D,B                  ; Quote to D

; Create String, termination char in D
;
; Used by the routines at __READ and LINE_INPUT.
; a.k.a. STRLT2
DTSTR:
  PUSH HL                 ; Save start                      ;SAVE POINTER TO START OF LITERAL
  LD C,-1                 ; Set counter to -1               ;INITIALIZE CHARACTER COUNT
STRGET:
  INC HL                  ; Move on
  LD A,(HL)               ; Get byte                        ;GET CHAR
  INC C                   ; Count bytes                     ;BUMP CHARACTER COUNT
  OR A                    ; End of line?                    ;IF 0, (END OF LINE) DONE
  JR Z,STRFIN             ; Yes - Create string entry       ;TEST
  CP D                    ; Terminator D found?
  JR Z,STRFIN             ; Yes - Create string entry
  CP B                    ; Terminator B found?             ;CLOSING QUOTE
  JR NZ,STRGET            ; No - Keep looking               ;NO, GO BACK FOR MORE
STRFIN:
  CP '"'                  ;IF QUOTE TERMINATES THE STRING   ; End with '"'?
  CALL Z,CHRGTB           ;SKIP OVER THE QUOTE              ; Yes - Get next character
;------ <this section is absent on MSX and Tandy M100> ------
  PUSH HL                 ;SAVE POINTER AT END OF STRING
  LD A,B                  ;WERE WE SCANNING AN UNQUOTED STRING?
  CP ','
  JR NZ,NTTRLS            ;IF NOT, DON'T SUPPRESS TRAILING SPACES
  INC C                   ;FIX [C] WHICH IS THE CHARACTER COUNT
LPTRLS:
  DEC C                   ;DECREMENT UNTIL WE FIND A NON-SPACE CHARACTER
  JR Z,NTTRLS             ;DON'T GO PAST START (ALL SPACES)
  DEC HL                  ;LOOK AT PREVIOUS CHARACTER
  LD A,(HL)
  CP ' '
  JR Z,LPTRLS             ;IF SO CONTINUE LOOKING
NTTRLS:
  POP HL
;------ <end> ------
  EX (SP),HL              ; Starting quote
  INC HL                  ; First byte of string
  EX DE,HL                ; To DE                         ;GET POINTER TO TEMP
  LD A,C                  ; Get length                    ;GET CHARACTER COUNT IN A
  CALL CRTMST             ; Create string entry           ;SAVE STR INFO

;
; SOME STRING FUNCTION IS RETURNING A RESULT IN DSCTMP
; WE WANT TO SETUP A TEMP DESCRIPTOR WITH DCSTMP IN IT
; PUT A POINTER TO THE DESCRIPTOR IN FACLO AND FLAG THE 
; RESULT AS TYPE STRING
;

; Temporary string to pool
; a.k.a. PUTNEW
;
; Used by the routines at __LSET, FN_INPUT, CONCAT, TOPOOL and ALLFOL.
TSTOPL:
  LD DE,DSCTMP            ; Temporary string                     ;[D,E] POINT AT RESULT DESCRIPTOR
  DEFB $3E                ; "LD A,n" to Mask the next byte       ;SKIP THE NEXT BYTE ("MVI AL,")

; PUTTMP
;
; Used by the routine at DOFN.
PUTTMP:
  PUSH DE                                                        ;SAVE A POINTER TO THE START OF THE STRING
  LD HL,(TEMPPT)          ; Temporary string pool pointer        ;[H,L]=POINTER TO FIRST FREE TEMP
  LD (FACCU),HL           ; Save address of string ptr           ;POINTER AT WHERE RESULT DESCRIPTOR WILL BE
  LD A,$03
  LD (VALTYP),A           ; Set type to string                   ;FLAG THIS AS A STRING
  CALL VMOVE              ; Move string to pool                  ;AND MOVE THE VALUE INTO A TEMPORARY
  LD DE,DSCTMP+3                                                 ;IF THE CALL IS TO PUTTMP, [D,E] WILL NOT EQUAL DSCTMP +3
  CALL DCOMPR             ; Out of string pool?                  ;DSCTMP IS JUST BEYOND THE TEMPS
                                                                 ;AND IF TEMPPT POINTS AT IT THERE ARE NO FREE TEMPS
  LD (TEMPPT),HL          ; Save new pointer                     ;SAVE NEW TEMPORARY POINTER
  POP HL                  ; Restore code string address          ;GET THE TEXT POINTER
  LD A,(HL)               ; Get next code byte                   ;GET CURRENT CHARACTER INTO [A]
  RET NZ                  ; Return if pool OK
  LD DE,$0010             ; Err $10 - "String formula too complex"  ; "STRING TEMPORARY" ERROR
  JP ERROR                                                       ;GO TELL HIM

;
; PRINT THE STRING POINTED TO BY [H,L] WHICH ENDS WITH A ZERO
; IF THE STRING IS BELOW DSCTMP IT WILL BE COPIED INTO STRING SPACE
;
; Print number string
PRNUMS:
  INC HL                  ;POINT AT NEXT CHARACTER

; Create string entry and print it
;
; Used by the routines at _ERROR_REPORT, SCNSTR, __DELETE, _LINE2PTR,
; __RANDOMIZE, IN_PRT, L4D05, NOTSCI and DONCMD.
PRS:
  CALL CRTST              ;GET A STRING LITERAL

; Print string at HL
;
; Used by the routines at PRNTNB, __INPUT, CAYSTR and ISSTRF.
PRS1:
  CALL GSTRCU             ;RETURN TEMP POINTER BY FACLO
  CALL LOADFP_0           ;[D]=LENGTH [B,C]=POINTER AT DATA
  INC D                   ;INCREMENT AND DECREMENT EARLY TO CHECK FOR NULL STRING
PRS1_0:
  DEC D                   ;DECREMENT THE LENGTH
  RET Z                   ;ALL DONE
  LD A,(BC)               ;GET CHARACTER TO PRINT
  CALL OUTDO
  CP $0D
  CALL Z,CRFIN
  INC BC                  ;POINT TO THE NEXT CHARACTER
  JR PRS1_0               ;AND PRINT IT...


; Test if enough room for string
;
; a.k.a. GETSPA - GET SPACE FOR CHARACTER STRING
; MAY FORCE GARBAGE COLLECTION.
;
; # OF CHARS (BYTES) IN [A]
; RETURNS WITH POINTER IN [D,E] OTHERWISE IF CANT GET SPACE
; BLOWS OFF TO "OUT OF STRING SPACE" TYPE ERROR.
;
; Used by the routines at __LSET, SAVSTR, MKTMST and ALLFOL.
TESTR:
  OR A                    ; MUST BE NON ZERO. SIGNAL NO GARBAG YET
  DEFB $0E                ; "LD C,n" to Mask the next byte

; GRBDON: Garbage Collection Done
GRBDON:
  POP AF                                                      ;IN CASE COLLECTED WHAT WAS LENGTH?
  PUSH AF                 ; Save status                       ;SAVE IT BACK
  LD HL,(STREND)          ; Bottom of string space in use
  EX DE,HL                ; To DE                             ;IN [D,E]
  LD HL,(FRETOP)          ; Bottom of string area             ;GET TOP OF FREE SPACE IN [H,L]
  CPL                     ; Negate length (Top down)          ;-# OF CHARS
  LD C,A                  ; -Length to BC                     ;IN [B,C]
  LD B,$FF                ; BC = -ve length of string
  ADD HL,BC               ; Add to bottom of space in use     ;SUBTRACT FROM TOP OF FREE
  INC HL                  ; Plus one for 2's complement
  CALL DCOMPR             ; Below string RAM area?            ;COMPARE THE TWO
  JR C,TESTOS             ; Tidy up if not done else err      ;NOT ENOUGH ROOM FOR STRING, OFFAL TIME
  LD (FRETOP),HL          ; Save new bottom of area           ;SAVE NEW BOTTOM OF MEMORY
  INC HL                  ; Point to first byte of string     ;MOVE BACK TO POINT TO STRING
  EX DE,HL                ; Address to DE                     ;RETURN WITH POINTER IN [D,E]

; This entry point is used by the routines at LISPRT and CHPUT.
POPAF:
  POP AF                  ; Throw away status push            ;GET CHARACTER COUNT
  RET                                                         ;RETURN FROM GETSPA

; Garbage Collection: Tidy up if not done else err
; a.k.a. GARBAG
; Used by the routine at GRBDON.
TESTOS:
  POP AF                  ; Garbage collect been done?           ;HAVE WE COLLECTED BEFORE?
  LD DE,$000E             ; Err $0E - "Out of string space"      ;GET READY FOR OUT OF STRING SPACE ERROR
  JP Z,ERROR              ; Yes - Not enough string apace        ;GO TELL USER HE LOST
  CP A                    ; Flag garbage collect done            ;SET ZERO FLAG TO SAY WEVE GARBAGED
  PUSH AF                 ; Save status                          ;SAVE FLAG BACK ON STACK
  LD BC,GRBDON            ; Garbage collection done              ;PLACE FOR GARBAG TO RETURN TO.
  PUSH BC                 ; Save for RETurn                      ;SAVE ON STACK

; Garbage collection
;
; Used by the routines at CAYSTR, ENFMEM and __FRE.
GARBGE:
  LD HL,(MEMSIZ)          ; Get end of RAM pointer               ;START FROM TOP DOWN
; This entry point is used by the routine at SCNEND.
GARBLP:
  LD (FRETOP),HL          ; Reset string pointer                 ;LIKE SO
  LD HL,$0000                                                    ;GET DOUBLE ZERO
  PUSH HL                 ; Flag no string found                 ;SAY DIDNT SEE VARS THIS PASS
  LD HL,(STREND)          ; Get bottom of string space           ;FORCE DVARS TO IGNORE STRINGS IN THE PROGRAM TEXT (LITERALS, DATA)
  PUSH HL                 ; Save bottom of string space          ;FORCE FIND HIGH ADDRESS
  LD HL,TEMPST            ; Temporary string pool                ;GET START OF STRING TEMPS

; Routine at 23075
TVAR:
  LD DE,(TEMPPT)          ;SEE IF DONE     ; Temporary string pool pointer
  CALL DCOMPR             ;TEST            ; Temporary string pool done?

  ;CANNOT RUN IN RAM SINCE IT STORES TO MESS UP BASIC
  LD BC,TVAR              ;FORCE JUMP TO TVAR                       ; Loop until string pool done
  JP NZ,STPOOL            ;DO TEMP VAR GARBAGE COLLECT              ; No - See if in string area
  LD HL,PRMPRV            ;SETUP ITERATION FOR PARAMETER BLOCKS     ; Start of simple variables
  LD (TEMP9),HL
  LD HL,(ARYTAB)          ;GET STOPPING POINT IN [H,L]
  LD (ARYTA2),HL          ;STORE IN STOP LOCATION
  LD HL,(VARTAB)          ;GET STARTING POINT IN [H,L]
SMPVAR:
  LD DE,(ARYTA2)          ;GET STOPPING LOCATION                    ; End of simple variables
  CALL DCOMPR             ;SEE IF AT END OF SIMPS                   ; All simple strings done?
  JR Z,ARYVAR                                                       ; Yes - Do string arrays
  LD A,(HL)               ;GET VALTYP                               ; Get type of variable
  INC HL                  ;BUMP POINTER TWICE
  INC HL                  ;
  INC HL                  ;POINT AT THE VALUE
  PUSH AF                 ;SAVE VALTYP                              ; Save type of variable
  CALL IADAHL             ;AND SKIP OVER EXTRA CHARACTERS AND COUNT
  POP AF                                                            ; Restore type of variable
  CP $03                  ;SEE IF ITS A STRING
  JR NZ,SKPVAR            ;IF NOT, JUST SKIP AROUND IT
  CALL STRADD             ;COLLECT IT                               ; Add if string in string area
  XOR A                   ;AND DON'T SKIP ANYTHING MORE
SKPVAR:
  LD E,A
  LD D,$00                ;[D,E]=AMOUNT TO SKIP
  ADD HL,DE
  JR SMPVAR               ;GET NEXT ONE                             ; Loop until simple ones done

ARYVAR:
  LD HL,(TEMP9)           ;GET LINK IN PARAMETER BLOCK CHAIN
  LD E,(HL)               ;GO BACK ONE LEVEL
  INC HL
  LD D,(HL)
  LD A,D
  OR E                    ;WAS THAT THE END?
  LD HL,(ARYTAB)
  JR Z,ARRLP              ;OTHERWISE GARBAGE COLLECT ARRAYS
  EX DE,HL
  LD (TEMP9),HL           ;SETUP NEXT LINK IN CHAIN FOR ITERATION
  INC HL                  ;SKIP CHAIN POINTER
  INC HL
  LD E,(HL)               ;PICK UP THE LENGTH
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL                ;SET [D,E]= ACTUAL END ADDRESS BY
  ADD HL,DE               ;ADDING BASE TO LENGTH
  LD (ARYTA2),HL          ;SET UP STOP LOCATION
  EX DE,HL
  JR SMPVAR

; Move to next array
;
; Used by the routine at ARRLP.
GNXARY:
  POP BC                  ; Scrap address of this array         ;GET RID OF STACK GARBAGE

; Routine at 23174
;
; Used by the routines at TVAR and ARYSTR.
ARRLP:                                                         	
  LD DE,(STREND)          ; End of string arrays                ;GET END OF ARRAYS
  CALL DCOMPR             ; All string arrays done?             ;SEE IF DONE WITH ARRAYS
  JR Z,SCNEND             ; Yes - Move string if found          ;YES, SEE IF DONE COLLECTING
  LD A,(HL)               ; Get type of array                   ;GET THE VALUE TYPE INTO [A]
  INC HL
  PUSH AF                 ; Save type of array                  ;SAVE THE VALTYP
  INC HL                                                        ;SKIP THE NAME CHARACTERS
  INC HL
  CALL IADAHL             ; Get next                            ;SKIP THE EXTRA CHARACTERS
  LD C,(HL)                                                     ;PICK UP THE LENGTH
  INC HL
  LD B,(HL)
  INC HL
  POP AF                  ; Restore type of array               ;RESTORE THE VALTYP
  PUSH HL                 ; Save address of num of dim'ns       ;SAVE POINTER TO DIMS
  ADD HL,BC               ; Start of next array                 ;ADD TO CURRENT POINTER PO
  CP $03                  ; Test type of array                  ;SEE IF ITS A STRING
  JR NZ,GNXARY            ; Numeric array - Ignore it           ;IF NOT JUST SKIP IT
  LD (TEMP8),HL           ; Save address of next array          ;SAVE END OF ARRAY
  POP HL                  ; Get address of num of dim'ns        ;GET BACK CURRENT POSITION
  LD C,(HL)               ; BC = Number of dimensions           ;PICK UP NUMBER OF DIMS
  LD B,$00                                                      ;MAKE DOUBLE WITH HIGH ZERO
  ADD HL,BC               ; Two bytes per dimension size        ;GO PAST DIMS
  ADD HL,BC                                                     ;BY ADDING ON TWICE #DIMS (2 BYTE GUYS)
  INC HL                  ; Plus one for number of dim'ns       ;ONE MORE TO ACCOUNT FOR #DIMS.

; Routine at 23215
ARYSTR:
  LD DE,(TEMP8)           ;GET END OF ARRAY                     ; Get address of next array
  CALL DCOMPR             ;SEE IF AT END OF ARRAY               ; Is this array finished?
  JR Z,ARRLP              ;END OF ARRAY, TRY NEXT ARRAY         ; Yes - Get next one
  LD BC,ARYSTR            ;ADDR OF WHERE TO RETURN TO           ; Loop until array all done

; Routine at 23229
;
; Used by the routine at TVAR.
STPOOL:
  PUSH BC                 ;GOES ON STACK                        ; Save return address

; Routine at 23230
;
; Used by the routine at TVAR.
STRADD:
  XOR A
  OR (HL)                 ; Get string length                  ;SEE IF ITS THE NULL STRING
  INC HL
  LD E,(HL)               ; Get LSB of string address
  INC HL
  LD D,(HL)               ; Get MSB of string address
  INC HL                                                       ;[D,E]=POINTER AT THE VALUE
  RET Z                                                        ;NULL STRING, RETURN
  LD B,H                                                       ;MOVE [H,L] TO [B,C]
  LD C,L
  LD HL,(FRETOP)          ; Bottom of new area                 ;GET POINTER TO TOP OF STRING FREE SPACE
  CALL DCOMPR             ; String been done?                  ;IS THIS STRINGS POINTER .LT. FRETOP
  LD H,B                  ; Restore variable pointer           ;MOVE [B,C] BACK TO [H,L]
  LD L,C
  RET C                   ; String done - Ignore               ;IF NOT, NO NEED TO MESS WITH IT FURTHUR
  POP HL                  ; Return address                     ;GET RETURN ADDRESS OFF STACK
  EX (SP),HL              ; Lowest available string area       ;GET MAX SEEN SO FAR & SAVE RETURN ADDRESS
  CALL DCOMPR             ; String within string area?         ;LETS SEE
  EX (SP),HL              ; Lowest available string area       ;SAVE MAX SEEN & GET RETURN ADDRESS OFF STACK
  PUSH HL                 ; Re-save return address             ;SAVE RETURN ADDRESS BACK
  LD H,B                  ; Restore variable pointer           ;MOVE [B,C] BACK TO [H,L]
  LD L,C
  RET NC                  ; Outside string area - Ignore       ;IF NOT, LETS LOOK AT NEXT VAR
  POP BC                  ; Get return , Throw 2 away          ;GET RETURN ADDR OFF STACK
  POP AF                                                       ;POP OFF MAX SEEN
  POP AF                                                       ;AND VARIABLE POINTER
  PUSH HL                 ; Save variable pointer              ;SAVE NEW VARIABLE POINTER
  PUSH DE                 ; Save address of current            ;AND NEW MAX POINTER
  PUSH BC                 ; Put back return address            ;SAVE RETURN ADDRESS BACK
  RET                     ; Go to it                           ;AND RETURN

;
; HERE WHEN MADE ONE COMPLETE PASS THRU STRING VARS
;
; All string arrays done, now move string
;
; Used by the routine at ARRLP.
SCNEND:
  POP DE                  ; Addresses of strings               ;POP OFF MAX POINTER
  POP HL                                                       ;AND GET VARIABLE POINTER
  LD A,H                  ; HL = 0 if no more to do            ;GET LOW IN
  OR L                                                         ;SEE IF ZERO POINTER
  RET Z                   ; No more to do - Return             ;IF END OF COLLECTION, THEN MAYBE RETURN TO GETSPA
  DEC HL                                                       ;CURRENTLY JUST PAST THE DESCRIPTOR
  LD B,(HL)               ; MSB of address of string           ;[B]=HIGH BYTE OF DATA POINTER
  DEC HL
  LD C,(HL)               ; LSB of address of string           ;[B,C]=POINTER AT STRING DATA
  PUSH HL                 ; Save variable address              ;SAVE THIS LOCATION SO THE POINTER CAN BE UPDATED AFTER THE STRING IS MOVED
  DEC HL
  LD L,(HL)               ; HL = Length of string              ;[L]=STRING LENGTH
  LD H,$00                                                     ;[H,L] GET CHARACTER COUNT
  ADD HL,BC               ; Address of end of string+1         ;[H,L]=POINTER BEYOND STRING
  LD D,B                  ; String address to DE
  LD E,C                                                       ;[D,E]=ORIGINAL POINTER
  DEC HL                  ; Last byte in string                ;DON'T MOVE ONE BEYOND STRING
  LD B,H                  ; Address to BC                      ;GET TOP OF STRING IN [B,C]
  LD C,L
  LD HL,(FRETOP)          ; Current bottom of string area      ;GET TOP OF FREE SPACE
  CALL MOVSTR             ; Move string to new address         ;MOVE STRING
  POP HL                  ; Restore variable address           ;GET BACK POINTER TO DESC.
  LD (HL),C               ; Save new LSB of address            ;SAVE FIXED ADDR
  INC HL                                                       ;MOVE POINTER
  LD (HL),B               ; Save new MSB of address            ;HIGH PART
  LD H,B                  ; Next string area+1 to HL
  LD L,C                                                       ;[H,L]=NEW POINTER
  DEC HL                  ; Next string area address           ;FIX UP FRETOP
  JP GARBLP               ; Look for more strings              ;AND TRY TO FIND HIGH AGAIN

; String concatenation, a.k.a. CAT
;
; THE FOLLOWING ROUTINE CONCATENATES TWO STRINGS
; THE FACLO CONTAINS THE FIRST ONE AT THIS POINT,
; [H,L] POINTS BEYOND THE + SIGN AFTER IT
;
; Used by the routine at _EVAL.
CONCAT:
  PUSH BC                 ; Save prec' opr & code string       ;PUT OLD PRECEDENCE BACK ON
  PUSH HL                                                      ;SAVE TEXT POINTER
  LD HL,(FACCU)           ; Get first string                   ;GET POINTER TO STRING DESC.
  EX (SP),HL              ; Save first string                  ;SAVE ON STACK & GET TEXT POINTER BACK
  CALL OPRND              ; Get second string                  ;EVALUATE REST OF FORMULA
  EX (SP),HL              ; Restore first string               ;SAVE TEXT POINTER, GET BACK DESC.
  CALL TSTSTR             ; Make sure it's a string
  LD A,(HL)               ; Get length of second string
  PUSH HL                 ; Save first string                  ;SAVE DESC. POINTER.
  LD HL,(FACCU)           ; Get second string                  ;GET POINTER TO 2ND DESC.
  PUSH HL                 ; Save second string                 ;SAVE IT
  ADD A,(HL)              ; Add length of second string        ;ADD TWO LENGTHS TOGETHER
  LD DE,$000F             ; Err $0F - "String too long"        ;SEE IF RESULT .LT. 256
  JP C,ERROR              ; String too long - Error            ;ERROR "LONG STRING"
  CALL MKTMST             ; Make temporary string              ;GET INITIAL STRING
  POP DE                  ; Get second string to DE            ;GET 2ND DESC.
  CALL GSTRDE             ; Move to string pool if needed
  EX (SP),HL              ; Get first string                   ;SAVE POINTER TO IT
  CALL GSTRHL             ; Move to string pool if needed      ;FREE UP 1ST TEMP
  PUSH HL                 ; Save first string                  ;SAVE DESC. POINTER (FIRST)
  LD HL,(TMPSTR)          ; Temporary string address           ;GET POINTER TO FIRST
  EX DE,HL                ; To DE                              ;IN [D,E]
  CALL SSTSA              ; First string to string area        ;MOVE IN THE FIRST STRING
  CALL SSTSA              ; Second string to string area       ;AND THE SECOND
  LD HL,EVAL2             ; Return to evaluation loop          ;CAT REENTERS FORMULA EVALUATION AT EVAL2
  EX (SP),HL              ; Save return,get code string
  PUSH HL                 ; Save code string address           ;TEXT POINTER OFF FIRST
  JP TSTOPL               ; To temporary string to pool        ;THEN RETURN ADDRESS OF TSTOP

; Move string on stack to string area
; a.k.a. MOVINS
;
; Used by the routine at CONCAT.
SSTSA:
  POP HL                  ; Return address                     ;GET RETURN ADDR
  EX (SP),HL              ; Get string block,save return       ;PUT BACK, BUT GET DESC.
  LD A,(HL)               ; Get length of string               ;[A]=STRING LENGTH
  INC HL
  LD C,(HL)               ; Get LSB of string address          ;[B,C]=POINTER AT STRING DATA
  INC HL
  LD B,(HL)               ; Get MSB of string address
  LD L,A                  ; Length to L                        ;[L]=STRING LENGTH

; Move string in BC, (len in L) to string area
; a.k.a. MOVSTR
; Used by the routines at SAVSTR and ALLFOL.
TOSTRA:
  INC L                   ; INC - DECed after

; TOSTRA loop
TSALP:
  DEC L                   ; Count bytes moved                  ;SET CC'S
  RET Z                   ; End of string - Return             ;0, NO BYTE TO MOVE
;MV_MEM:
; Move the memory pointed by BC to the memory pointed by DE, L times.
  LD A,(BC)               ; Get source                         ;GET CHAR
  LD (DE),A               ; Save destination                   ;SAVE IT
  INC BC                  ; Next source                        ;MOVE POINTERS
  INC DE                  ; Next destination
  JR TSALP                ; Loop until string moved            ;KEEP DOING IT


; Get string pointed by FPREG 'Type Error' if it is not
;
; FRETMP IS PASSED A POINTER TO A STRING DESCRIPTOR IN [D,E]
; THIS VALUE IS RETURNED IN [H,L]. ALL THE OTHER REGISTERS ARE MODIFIED.
; A CHECK TO IS MADE TO SEE IF THE STRING DESCRIPTOR [D,E] POINTS TO
; IS THE LAST TEMPORARY DESCRIPTOR ALLOCATED BY PUTNEW.
; IF SO, THE TEMPORARY IS FREED UP BY THE UPDATING OF TEMPPT.
; IF A TEMPORARY IS FREED UP, A FURTHER CHECK IS MADE TO SEE IF THE STRING DATA
; THAT THAT STRING TEMPORARY POINTED TO IS THE THE LOWEST PART OF STRING SPACE IN USE.
; IF SO, FRETMP IS UPDATED TO REFLECT THE FACT THAT THAT SPACE IS NO LONGER IN USE.
;
; Used by the routines at FNAME, __OPEN, __CVD, __LSET, STRCMP, __LEN and
; FN_INSTR.
GETSTR:
  CALL TSTSTR             ; Make sure it's a string

; Get string pointed by FPREG
;
; Used by the routines at NOTQTI, FN_USR, __STR_S, PRS1 and __FRE.
; a.k.a. FREFAC
GSTRCU:
  LD HL,(FACCU)           ; Get current string

; Get string pointed by HL
;
; Used by the routines at NOTSCI, CONCAT and FN_INSTR.
GSTRHL:
  EX DE,HL                ; Save DE                            ;FREE UP THE TEMP IN THE FACLO

; Get string pointed by DE
;
; Used by the routines at STRCMP, CONCAT and ALLFOL.
GSTRDE:
  CALL FRETMS             ; Was it last tmp-str?               ;FREE UP THE TEMPORARY
  EX DE,HL                ; Restore DE                         ;PUT THE STRING POINTER INTO [H,L]
  RET NZ                  ; No - Return
  PUSH DE                 ; Save string                        ;SAVE [D,E] TO RETURN IN [H,L]
  LD D,B                  ; String block address to DE         ;[D,E]=POINTER AT STRING
  LD E,C
  DEC DE                  ; Point to length                    ;SUBTRACT ONE
  LD C,(HL)               ; Get string length                  ;[C]=LENGTH OF THE STRING FREED UP
  LD HL,(FRETOP)          ; Current bottom of string area      ;SEE IF ITS THE FIRST ONE IN STRING SPACE
  CALL DCOMPR             ; Last one in string area?
  JR NZ,POPHL             ; No - Return                        ;NO SO DON'T ADD
  LD B,A                  ; Clear B (A=0)                      ;MAKE [B]=0
  ADD HL,BC               ; Remove string from str' area       ;ADD
  LD (FRETOP),HL          ; Save new bottom of str' area       ;AND UPDATE FRETOP
POPHL:
  POP HL                  ; Restore string                     ;GET POINTER AT CURRENT DESCRIPTOR
  RET

; Get temporary string pool top
;
; Used by the routines at __LET and GSTRDE.
; a.k.a BAKTMP
FRETMS:
  LD HL,(TEMPPT)          ; Back                               ;GET TEMP POINTER
  DEC HL                  ; Get MSB of address                 ;LOOK AT WHAT IS IN THE LAST TEM
  LD B,(HL)               ; Back                               ;[B,C]=POINTER AT STRING
  DEC HL                  ; Get LSB of address                 ;DECREMENT TEMPPT BY STRSIZ
  LD C,(HL)               ; Back
  DEC HL                  ; Back
  CALL DCOMPR             ; String last in string pool?        ;SEE IF [D,E] POINT AT THE LAST 
  RET NZ                  ; Yes - Leave it                     ;RETURN NOW IF NOW FREEING DONE
  LD (TEMPPT),HL          ; Save new string pool top           ;UPDATE THE TEMP POINTER SINCE ITS BEEN DECREMENTED BY 4
  RET


; 'LEN' BASIC function
;
; THE FUNCTION LEN($) RETURNS THE LENGTH OF THE
; STRING PASSED AS AN ARGUMENT
;
__LEN:
  LD BC,PASSA             ; To return integer A                ;CALL SNGFLT WHEN DONE
  PUSH BC                 ; Save address                       ;LIKE SO

; This entry point is used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR             ; Get string and its length          ;FREE UP TEMP POINTED TO BY FACLO
  XOR A                                                        ;FORCE NUMERIC FLAG
  LD D,A                  ; Clear D                            ;SET HIGH OF [D,E] TO ZERO FOR VAL
  LD A,(HL)               ; Get length of string
  OR A                    ; Set status flags                   ;SET CONDITION CODES ON LENGTH
  RET                                                          ;RETURN


; 'ASC' BASIC function
;
; THE FOLLOWING IS THE ASC($) FUNCTION. IT RETURNS AN INTEGER
; WHICH IS THE DECIMAL ASCII EQUIVALENT
;
__ASC:
  LD BC,PASSA             ; To return integer A                ;WHERE TO GO WHEN DONE
  PUSH BC                 ; Save address                       ;SAVE RETURN ADDR ON STACK

; This entry point is used by the routine at FN_STRING.
__ASC_0:
  CALL GETLEN             ; Get length of string               ;SET UP ORIGINAL STR
  JP Z,FC_ERR             ; Null string - Error                ;NULL STR, BAD ARG.
  INC HL                                                       ;BUMP POINTER
  LD E,(HL)               ; Get LSB of address                 ;[D,E]=POINTER AT STRING DATA
  INC HL
  LD D,(HL)               ; Get MSB of address
  LD A,(DE)               ; Get first byte of string           ;[A]=FIRST CHARACTER
  RET


; 'CHR$' BASIC function
;
; CHR$(#) CREATES A STRING WHICH CONTAINS AS ITS ONLY
; CHARACTER THE ASCII EQUIVALENT OF THE INTEGER ARG (#)
; WHICH MUST BE .LE. 255.
;
__CHR_S:
  CALL STRIN1             ; Make One character temporary string   ;GET STRING IN DSCTMP
  CALL CONINT             ; Make it integer A                     ;GET INTEGER IN RANGE

; This entry point is used by the routine at FN_INKEY_0.
SETSTR:
  LD HL,(TMPSTR)          ; Get address of string              ;GET ADDR OF STR
  LD (HL),E               ; Save character                     ;SAVE ASCII BYTE

; Save in string pool
;
; Used by the routines at __MKD_S and __SPACE_S.
TOPOOL:
  POP BC                  ; Clean up stack                     ;RETURN TO HIGHER LEVEL & SKIP THE CHKNUM CALL.
  JP TSTOPL               ; Temporary string to pool           ;GO CALL PUTNEW

; Routine at 23467
;
; Used by the routine at NTVARP.
FN_STRING:
  CALL CHRGTB             ;GET NEXT CHAR FOLLOWING "STRING$"
  CALL SYNCHR
  DEFM "("                ;MAKE SURE LEFT PAREN
  CALL GETINT             ;EVALUATE FIRST ARG (LENGTH)
  PUSH DE                 ;SAVE IT
  CALL SYNCHR
  DEFM ","                ;COMMA
  CALL EVAL               ;GET FORMULA ARG 2
  CALL SYNCHR
  DEFM ")"                ;EXPECT RIGHT PAREN
  EX (SP),HL              ;SAVE TEXT POINTER ON STACK, GET REP FACTOR
  PUSH HL                 ;SAVE BACK REP FACTOR
  CALL GETYPR             ;GET TYPE OF ARG
  JR Z,STRSTR             ;WAS A STRING
  CALL CONINT             ;GET ASCII VALUE OF CHAR
  JR CALSPA               ;NOW CALL SPACE CODE

STRSTR:
  CALL __ASC_0            ;GET VALUE OF CHAR IN [A]
CALSPA:
  POP DE                  ;GET REP FACTOR IN [E]
  CALL __SPACE_S_0        ;INTO SPACE CODE, PUT DUMMY ENTRY ON STACK POPPED OFF BY FINBCK

; label='SPACE$' BASIC function
__SPACE_S:
  CALL CONINT             ;GET NUMBER OF CHARS IN [E]
  LD A,' '                ;GET SPACE CHAR

; This entry point is used by the routine at FN_STRING.
__SPACE_S_0:
  PUSH AF                 ;SAVE CHAR
  LD A,E                  ;GET NUMBER OF CHARS IN [A]
  CALL MKTMST             ;GET A STRING THAT LONG
  LD B,A                  ;COUNT OF CHARS BACK IN [B]
  POP AF                  ;GET BACK CHAR TO PUT IN STRING
  INC B                   ;TEST FOR NULL STRING
  DEC B
  JR Z,TOPOOL             ;YES, ALL DONE
  LD HL,(TMPSTR)          ;GET DESC. POINTER
SPLP:
  LD (HL),A               ;SAVE CHAR
  INC HL                  ;BUMP PTR
  ;DEC B                   ;DECR COUNT
  DJNZ SPLP              ;KEEP STORING CHAR
  JR TOPOOL               ;PUT TEMP DESC WHEN DONE


; 'LEFT$' BASIC function
;
; THE FOLLOWING IS THE LEFT$($,#) FUNCTION.
; IT TAKES THE LEFTMOST # CHARS OF THE STR.
; IF # IS .GT. THAN THE LEN OF THE STR, IT RETURNS THE WHOLE STR.
;
__LEFT_S:
  CALL LFRGNM             ; Get number and ending ")"            ;TEST THE PARAMETERS
  XOR A                   ; Start at first byte in string        ;LEFT NEVER CHANGES STRING POINTER

; This entry point is used by the routine at __RIGHT_S.
RIGHT1:
  EX (SP),HL              ; Save code string,Get string          ;SAVE TEXT POINTER
  LD C,A                  ; Starting position in string          ;OFFSET NOW IN [C]

  DEFB $3E                ; "LD A,n" to Mask the next byte       ;SKIP THE NEXT BYTE WITH "MVI A,"

;
; THIS IS PRINT USINGS ENTRY POINT INTO LEFT$
;
; Routine at 23546
;
; Used by the routine at ISSTRF.
__LEFT_S_1:
  PUSH HL                 ; Save string block address (twice)    ;THIS IS A DUMMY PUSH TO OFFSET THE EXTRA POP IN PUTNEW

; Continuation of MID$ routine
MID1:
  PUSH HL                 ; Save string block address            ;SAVE DESC. FOR  FRETMP
  LD A,(HL)               ; Get length of string                 ;GET STRING LENGTH
  CP B                    ; Compare with number given            ;ENTIRE STRING WANTED?
  JR C,ALLFOL             ; All following bytes required         ;IF #CHARS ASKED FOR.GE.LENGTH,YES
  LD A,B                  ; Get new length                       ;GET TRUNCATED LENGTH OF STRING
  DEFB $11                ; "LD DE,nn" to skip "LD C,0"          ;SKIP OVER MVI USING "LXI D,"

; Routine at 23555
;
; Used by the routine at MID1.
ALLFOL:
  LD C,$00                ; First byte of string                 ;MAKE OFFSET ZERO
  PUSH BC                 ; Save position in string              ;SAVE OFFSET ON STACK
  CALL TESTR              ; See if enough string space           ;GET SPACE FOR NEW STRING
  POP BC                  ; Get position in string               ;GET BACK OFFSET
  POP HL                  ; Restore string block address         ;GET BACK DESC POINTER.
  PUSH HL                 ; And re-save it                       ;BUT KEEP ON STACK
  INC HL                                                         ;MOVE TO STRING POINTER FIELD
  LD B,(HL)               ; Get LSB of address                   ;GET POINTER LOW
  INC HL                                                         ;
  LD H,(HL)               ; Get MSB of address                   ;POINTER HIGH
  LD L,B                  ; HL = address of string               ;GET LOW IN  L
  LD B,$00                ; BC = starting address                ;GET READY TO ADD OFFSET TO POINTER
  ADD HL,BC               ; Point to that byte                   ;ADD  IT
  LD B,H                  ; BC = source string                   ;GET OFFSET POINTER IN [B,C]
  LD C,L
  CALL CRTMST             ; Create a string entry                ;SAVE INFO IN DSCTMP
  LD L,A                  ; Length of new string                 ;GET#  OF CHARS TO  MOVE IN L
  CALL TOSTRA             ; Move string to string area           ;MOVE THEM IN
  POP DE                  ; Clear stack                          ;GET BACK DESC. POINTER
  CALL GSTRDE             ; Move to string pool if needed        ;FREE IT UP.
  JP TSTOPL               ; Temporary string to pool             ;PUT TEMP IN TEMP LIST


; 'RIGHT$' BASIC function
__RIGHT_S:
  CALL LFRGNM             ; Get number and ending ")"            ;CHECK ARG
  POP DE                  ; Get string length                    ;GET DESC. POINTER
  PUSH DE                 ; And re-save                          ;SAVE BACK FOR LEFT
  LD A,(DE)               ; Get length                           ;GET PRESENT LEN OF STR
  SUB B                   ; Move back N bytes                    ;SUBTRACT 2ND PARM
  JR RIGHT1               ; Go and get sub-string                ;CONTINUE WITH LEFT CODE


; 'MID$' BASIC function
;
; MID ($,#) RETURNS STR WITH CHARS FROM # POSITION
; ONWARD. IF # IS GT LEN($) THEN RETURN NULL STRING.
; MID ($,#,#) RETURNS STR WITH CHARS FROM # POSITION
; FOR #2 CHARS. IF #2 GOES PAST END OF STRING, RETURN
; AS MUCH AS POSSIBLE.
;
__MID_S:
  EX DE,HL                ; Get code string address              ;PUT THE TEXT POINTER IN [H,L]
  LD A,(HL)               ; Get next byte "," or ")"             ;GET THE FIRST CHARACTER
  CALL MIDNUM             ; Get number supplied                  ;GET OFFSET OFF STACK AND MAKE
  INC B                   ; Is it character zero?
  DEC B                                                          ;SEE IF EQUAL TO ZERO
  JP Z,FC_ERR             ; Yes - Error                          ;IT MUST NOT BE 0 SURE DOES NOT = 0.
  PUSH BC                 ; Save starting position               ;PUT OFFSET ON TO THE STACK
  CALL MID_ARGSEP         ; test ',' & ')'                       ;DUPLICATE OF CODE CONDITIONED OUT BELOW
  POP AF                  ; Restore starting position            ;GET OFFSET BACK IN A
  EX (SP),HL              ; Get string,save code string          ;SAVE TEXT POINTER, GET DESC.
  LD BC,MID1              ; Continuation of MID$ routine         ;WHERE TO RETURN TO.
  PUSH BC                 ; Save for return                      ;GOES ON STACK
  DEC A                   ; Starting position-1                  ;SUB ONE FROM OFFSET
  CP (HL)                 ; Compare with length                  ;POINTER PAST END OF STR?
  LD B,$00                ; Zero bytes length                    ;ASSUME NULL LENGTH STR
  RET NC                  ; Null string if start past end        ;YES, JUST USE NULL STR
  LD C,A                  ; Save starting position-1             ;SAVE OFFSET OF CHARACTER POINTER
  LD A,(HL)               ; Get length of string                 ;GET PRESENT LEN OF STR
  SUB C                   ; Subtract start                       ;SUBTRACT INDEX (2ND ARG)
  CP E                    ; Enough string for it?                ;IS IT TRUNCATION
  LD B,A                  ; Save maximum length available        ;GET CALCED LENGTH IN B
  RET C                   ; Truncate string if needed            ;IF NOT USE PARTIAL STR
  LD B,E                  ; Set specified length                 ;USE TRUNCATED LENGTH
  RET                     ; Go and create string                 ;RETURN TO LEFT2


; 'VAL' BASIC function
;
; THE VAL FUNCTION TAKES A STRING AND TURN IT INTO
; A NUMBER BY INTERPRETING THE ASCII DIGITS. ETC..
; EXCEPT FOR THE PROBLEM THAT A TERMINATOR MUST BE SUPPLIED
; BY REPLACING THE CHARACTER BEYOND THE STRING, VAL
; IS MERELY A CALL TO FLOATING INPUT (FIN).
;
__VAL:
  CALL GETLEN             ; Get length of string                 ;DO SETUP, SET RESULT=REAL
  JP Z,PASSA              ; Result zero                          ;MAKE SURE TYPE SET UP OK IN EXTENDED
  LD E,A                  ; Save length                          ;GET LENGTH OF STR
  INC HL                                                         ;TO HANDLE THE FACT THE IF
  LD A,(HL)               ; Get LSB of address
  INC HL
  LD H,(HL)               ; Get MSB of address                   ;TWO STRINGS "1" AND "2"
  LD L,A                  ; HL = String address                  ;ARE STORED NEXT TO EACH OTHER
  PUSH HL                 ; Save string address                  ;AND FIN IS CALLED POINTING TO
  ADD HL,DE                                                      ;THE FIRST TWELVE WILL BE RETURNED
  LD B,(HL)               ; Get end of string+1 byte             ;THE IDEA IS TO STORE 0 IN THE
  LD (HL),D               ; Zero it to terminate                 ;STRING BEYOND THE ONE VAL
  EX (SP),HL              ; Save string end,get start            ;IS BEING CALLED ON
  PUSH BC                 ; Save end+1 byte                      ;THE FIRST CHARACTER OF THE NEXT STRING
  DEC HL                                                         ;***CALL CHRGET TO MAKE SURE
  CALL CHRGTB                                                    ;VAL(" -3")=-3
  CALL FIN_DBL            ; Convert ASCII string to FP           ;IN EXTENDED, GET ALL THE PRECISION WE CAN
  POP BC                  ; Restore end+1 byte                   ;GET THE MODIFIED CHARACTER OF THE NEXT STRING INTO [B]
  POP HL                  ; Restore end+1 address                ;GET THE POINTER TO THE MODIFIED CHARACTER
  LD (HL),B               ; Put back original byte               ;RESTORE THE CHARACTER

					;IF STRING IS HIGHEST IN STRING SPACE
					;WE ARE MODIFYING [MEMSIZ] AND
					;THIS IS WHY [MEMSIZ] CAN'T BE USED TO STORE
					;STRING DATA BECAUSE WHAT IF THE
					;USER TOOK VAL OFF THAT HIGH STRING
  RET


; Get number, check for ending ')'
; USED BY RIGHT$ AND LEFT$ FOR PARAMETER CHECKING AND SETUP
;
; Used by the routines at __LEFT_S and __RIGHT_S.
LFRGNM:
  EX DE,HL                ; Code string address to HL            ;PUT THE TEXT POINTER IN [H,L]
  CALL SYNCHR             ; Make sure ")" follows                ;PARAM LIST SHOULD END
  DEFM ")"

; Get numeric argument for MID$
; USED BY MID$ FOR PARAMETER CHECKING AND SETUP
;
; Used by the routine at __MID_S.
MIDNUM:
  POP BC                                                         ;GET RETURN ADDR OFF STACK
  POP DE                  ; Get number supplied                  ;GET LENGTH OF ARG OFF STACK
  PUSH BC                 ; Re-save return address               ;SAVE RETURN ADDR BACK ON
  LD B,E                  ; Number to B                          ;SAVE INIT LENGTH
  RET


; INSTR
;
; THIS IS THE INSTR FUCNTION. IT TAKES ONE OF TWO
; FORMS: INSTR(I%,S1$,S2$) OR INSTR(S1$,S2$)
; IN THE FIRST FORM THE STRING S1$ IS SEARCHED FOR THE
; CHARACTER S2$ STARTING AT CHARACTER POSITION I%.
; THE SECOND FORM IS IDENTICAL, EXCEPT THAT THE SEARCH
; STARTS AT POSITION 1. INSTR RETURNS THE CHARACTER
; POSITION OF THE FIRST OCCURANCE OF S2$ IN S1$.
; IF S1$ IS NULL, 0 IS RETURNED. IF S2$ IS NULL, THEN
; I% IS RETURNED, UNLESS I% .GT. LEN(S1$) IN WHICH
; CASE 0 IS RETURNED.
;
; Routine at 23670
;
; Used by the routine at NTVARP.
FN_INSTR:
  CALL CHRGTB             ;EAT FIRST CHAR
  CALL OPNPAR             ;EVALUATE FIRST ARG
  CALL GETYPR             ;SET ZERO IF ARG A STRING.
  LD A,$01                ;IF SO, ASSUME, SEARCH STARTS AT FIRST CHAR
  PUSH AF                 ;SAVE OFFSET IN CASE STRING
  JR Z,FN_INSTR_0         ;WAS A STRING
  POP AF                  ;GET RID OF SAVED OFFSET
  CALL CONINT             ;FORCE ARG1 (I%) TO BE INTEGER
  OR A                    ;DONT ALLOW ZERO OFFSET
  JP Z,FC_ERR             ;KILL HIM.
  PUSH AF                 ;SAVE FOR LATER
  CALL SYNCHR
  DEFM ","                ;EAT THE COMMA
  CALL EVAL               ;EAT FIRST STRING ARG
  CALL TSTSTR             ;BLOW UP IF NOT STRING
FN_INSTR_0:
  CALL SYNCHR
  DEFM ","                ;EAT COMMA AFTER ARG
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD HL,(FACCU)           ;GET DESCRIPTOR POINTER
  EX (SP),HL              ;PUT ON STACK & GET BACK TEXT PNT.
  CALL EVAL               ;GET LAST ARG
  CALL SYNCHR
  DEFM ")"                ;EAT RIGHT PAREN
  PUSH HL                 ;SAVE TEXT POINTER
  CALL GETSTR             ;FREE UP TEMP & CHECK STRING
  EX DE,HL                ;SAVE 2ND DESC. POINTER IN [D,E]
  POP BC                  ;GET TEXT POINTER IN B
  POP HL                  ;DESC. POINTER FOR S1$
  POP AF                  ;OFFSET
  PUSH BC                 ;PUT TEXT POINTER ON BOTTOM
  LD BC,POPHLRT           ;PUT ADDRESS OF POP H, RET ON
  PUSH BC                 ;PUSH IT
  LD BC,PASSA             ;NOW ADDRESS OF [A] RETURNER
  PUSH BC                 ;ONTO STACK
  PUSH AF                 ;SAVE OFFSET BACK
  PUSH DE                 ;SAVE DESC. OF S2
  CALL GSTRHL             ;FREE UP S1 DESC.
  POP DE                  ;RESTORE DESC. S2
  POP AF                  ;GET BACK OFFSET
  LD B,A                  ;SAVE UNMODIFIED OFFSET
  DEC A                   ;MAKE OFFSET OK
  LD C,A                  ;SAVE IN C
  CP (HL)                 ;IS IT BEYOND LENGTH OF S1?
  LD A,$00                ;IF SO, RETURN ZERO. (ERROR)
  RET NC
  LD A,(DE)               ;GET LENGTH OF S2$
  OR A                    ;NULL??
  LD A,B                  ;GET OFFSET BACK
  RET Z                   ;ALL IF S2 NULL, RETURN OFFSET
  LD A,(HL)               ;GET LENGTH OF S1$
  INC HL                  ;BUMP POINTER
  LD B,(HL)               ;GET 1ST BYTE OF ADDRESS
  INC HL                  ;BUMP POINTER
  LD H,(HL)               ;GET 2ND BYTE
  LD L,B                  ;GET 1ST BYTE SET UP
  LD B,$00                ;GET READY FOR DAD
  ADD HL,BC               ;NOW INDEXING INTO STRING
  SUB C                   ;MAKE LENGTH OF STRING S1$ RIGHT
  LD B,A                  ;SAVE LENGTH OF 1ST STRING IN [B]
  PUSH BC                 ;SAVE COUNTER, OFFSET
  PUSH DE                 ;PUT 2ND DESC (S2$) ON STACK
  EX (SP),HL              ;GET 2ND DESC. POINTER
  LD C,(HL)               ;SET UP LENGTH
  INC HL                  ;BUMP POINTER
  LD E,(HL)               ;GET FIRST BYTE OF ADDRESS
  INC HL                  ;BUMP POINTER AGAIN
  LD D,(HL)               ;GET 2ND BYTE
  POP HL                  ;RESTORE POINTER FOR 1ST STRING
CHK1:
  PUSH HL                 ;SAVE POSITION IN SEARCH STRING
  PUSH DE                 ;SAVE START OF SUBSTRING
  PUSH BC                 ;SAVE WHERE WE STARTED SEARCH
CHK:
  LD A,(DE)               ;GET CHAR FROM SUBSTRING
  CP (HL)                 ; = CHAR POINTER TO BY [H,L]
  JR NZ,OHWELL            ;NO
  INC DE                  ;BUMP COMPARE POINTER
  DEC C                   ;END OF SEARCH STRING?
  JR Z,GOTSTR             ;WE FOUND IT!
  INC HL                  ;BUMP POINTER INTO STRING BEING SEARCHED
  ;DEC B                   ;DECREMENT LENGTH OF SEARCH STRING
  DJNZ CHK        
  POP DE                  ;END OF STRING, YOU LOSE
  POP DE                  ;GET RID OF POINTERS
  POP BC                  ;GET RID OF GARB
RETZER:
  POP DE                  ;LIKE SO
  XOR A                   ;GO TO SNGFLT.
  RET                     ;RETURN

GOTSTR:
  POP HL
  POP DE                  ;GET RID OF GARB
  POP DE                  ;GET RID OF EXCESS STACK
  POP BC                  ;GET COUNTER, OFFSET
  LD A,B                  ;GET ORIGINAL SOURCE COUNTER
  SUB H                   ;SUBTRACT FINAL COUNTER
  ADD A,C                 ;ADD ORIGINAL OFFSET (N1%)
  INC A                   ;MAKE OFFSET OF ZERO = POSIT 1
  RET                     ;DONE

OHWELL:
  POP BC
  POP DE                  ;POINT TO START OF SUBSTRING
  POP HL                  ;GET BACK WHERE WE STARTED TO COMPARE
  INC HL                  ;AND POINT TO NEXT CHAR
  ;DEC B                   ;DECR. # CHAR LEFT IN SOURCE STRING
  DJNZ CHK1              ;TRY SEARCHING SOME MORE
  JR RETZER               ;END OF STRING, RETURN 0


; STRING FUNCTIONS - LEFT HAND SIDE MID$
; This entry point is used by the routine at ISMID.
LHSMID:
  CALL SYNCHR
  DEFM "("                ;MUST HAVE ( 
  CALL GETVAR             ;GET A STRING VAR
  CALL TSTSTR             ;MAKE SURE IT WAS A STRING
  PUSH HL                 ;SAVE TEXT POINTER
  PUSH DE                 ;SAVE DESC. POINTER
  EX DE,HL                ;PUT DESC. POINTER IN [H,L]
  INC HL                  ;MOVE TO ADDRESS FIELD
  LD E,(HL)               ;GET ADDRESS OF LHS IN [D,E]
  INC HL                  ;BUMP DESC. POINTER
  LD D,(HL)               ;PICK UP HIGH BYTE OF ADDRESS
  LD HL,(STREND)          ;SEE IF LHS STRING IS IN STRING SPACE
  CALL DCOMPR             ;BY COMPARING IT WITH STKTOP
  JR C,NCPMID             ;IF ALREADY IN STRING SPACE DONT COPY.

				;9/23/79 Allow MID$ on field strings
  LD HL,(TXTTAB)
  CALL DCOMPR             ;Is this a fielded string?
  JR NC,NCPMID            ;Yes, Don't copy!!
  POP HL                  ;GET BACK DESC. POINTER
  PUSH HL                 ;SAVE BACK ON STACK
  CALL STRCPY             ;COPY THE STRING LITERAL INTO STRING SPACE
  POP HL                  ;GET BACK DESC. POINTER
  PUSH HL                 ;BACK ON STACK AGAIN
  CALL VMOVE              ;MOVE NEW DESC. INTO OLD SLOT.
NCPMID:
  POP HL                  ;GET DESC. POINTER
  EX (SP),HL              ;GET TEXT POINTER TO [H,L] DESC. TO STACK
  CALL SYNCHR
  DEFM ","                ;MUST HAVE COMMA
  CALL GETINT             ;GET ARG#2 (OFFSET INTO STRING)
  OR A                    ;MAKE SURE NOT ZERO
  JP Z,FC_ERR             ;BLOW HIM UP IF ZERO
  PUSH AF                 ;SAVE ARG#2 ON STACK
  LD A,(HL)               ;RESTORE CURRENT CHAR
  CALL MID_ARGSEP         ;USE MID$ CODE TO EVALUATE POSIBLE THIRD ARG.
  PUSH DE                 ;SAVE THIRD ARG ([E]) ON STACK
  CALL FRMEQL             ;MUST HAVE = SIGN, EVALUATE RHS OF THING.
  PUSH HL                 ;SAVE TEXT POINTER.
  CALL GETSTR             ;FREE UP TEMP RHS IF ANY.
  EX DE,HL                ;PUT RHS DESC. POINTER IN [D,E]
  POP HL                  ;TEXT POINTER TO [H,L]
  POP BC                  ;ARG #3 TO C.
  POP AF                  ;ARG #2 TO A.
  LD B,A                  ;AND [B]
  EX (SP),HL              ;GET LHS DESC. POINTER TO [H,L] <> TEXT POINTER TO STACK
  PUSH HL                 ;SAVE TEXT POINTER
  LD HL,POPHLRT           ;GET ADDR TO RETURN TO
  EX (SP),HL              ;SAVE ON STACK & GET BACK TXT PTR.
  LD A,C                  ;GET ARG #3
  OR A                    ;SET CC'S
  RET Z                   ;IF ZERO, DO NOTHING
  LD A,(HL)               ;GET LENGTH OF LHS
  SUB B                   ;SEE HOW MANY CHARS IN EMAINDER OF STRING
  JP C,FC_ERR             ;CANT ASSIGN PAST LEN(LHS)!
  INC A                   ;MAKE PROPER COUNT
  CP C                    ;SEE IF # OF CHARS IS .GT. THIRD ARG
  JR C,BIGLEN             ;IF SO, DONT TRUNCATE
  LD A,C                  ;TRUNCATE BY USING 3RD ARG.
BIGLEN:
  LD C,B                  ;GET OFFSET OF STRING IN [C]
  DEC C                   ;MAKE PROPER OFFSET
  LD B,$00                ;SET UP [B,C] FOR LATER DAD B.
  PUSH DE                 ;SAVE [D,E]
  INC HL                  ;POINTER TO ADDRESS FIELD.
  LD E,(HL)               ;GET LOW BYTE IN [E]
  INC HL                  ;BUMP POINTER
  LD H,(HL)               ;GET HIGH BYTE IN [H]
  LD L,E                  ;NOW COPY LOW BYTE BACK TO [L]
  ADD HL,BC               ;ADD OFFSET
  LD B,A                  ;SET COUNT OF LHS IN [B]
  POP DE                  ;RESTORE [D,E]
  EX DE,HL                ;MOVE RHS. DESC. POINTER TO [H,L]
  LD C,(HL)               ;GET LEN(RHS) IN [C]
  INC HL                  ;MOVE POINTER
  LD A,(HL)               ;GET LOW BYTE OF ADDRESS IN [A]
  INC HL                  ;BUMP POINTER.
  LD H,(HL)               ;GET HIGH BYTE OF ADDRESS IN [H]
  LD L,A                  ;COPY LOW BYTE TO [L]
  EX DE,HL                ;ADDRESS OF RHS NOW IN [D,E]
  LD A,C                  ;IS RHS NULL?
  OR A                    ;TEST
  RET Z                   ;THEN ALL DONE.

; NOW ALL SET UP FOR ASSIGNMENT.
; [H,L] = LHS POINTER
; [D,E] = RHS POINTER
; C = LEN(RHS)
; B = LEN(LHS)

MID_LP:
  LD A,(DE)               ;GET BYTE FROM RHS.
  LD (HL),A               ;STORE IN LHS
  INC DE                  ;BUMP RHS POINTER
  INC HL                  ;BUMP LHS POINTER.
  DEC C                   ;BUMP DOWN COUNT OF RHS.
  RET Z                   ;IF ZERO, ALL DONE.
  ;DEC B                   ;IF LHS ENDED, ALSO DONE.
  DJNZ MID_LP            ;IF NOT DONE, MORE COPYING.
  RET                     ;BACK TO NEWSTT

; test ',' & ')' as argument separators in string functions
;
; Used by the routines at __MID_S and FN_INSTR.
MID_ARGSEP:
  LD E,255                ;IF TWO ARG GUY, TRUNCATE.
  CP ')'
  JR Z,MID_ARGSEP_0       ;[E] SAYS USE ALL CHARS
                          ;IF ONE ARGUMENT THIS IS CORRECT
  CALL SYNCHR
  DEFM ","                ;COMMA? MUST DELINEATE 3RD ARG.
  CALL GETINT             ;GET ARGUMENT  IN  [E]
MID_ARGSEP_0:
  CALL SYNCHR
  DEFM ")"                ;MUST BE FOLLOWED BY )
  RET                     ;ALL DONE.

; 'FRE' BASIC function
__FRE:
  CALL GETYPR
  JR NZ,CLCDIF
  CALL GSTRCU             ; Current string to pool               ;FREE UP ARGUMENT AND SETUP TO GIVE FREE STRING SPACE
  CALL GARBGE             ; Garbage collection                   ;DO GARBAGE COLLECTION
CLCDIF:
  LD DE,(STREND)          ; Bottom of string space in use
  LD HL,(FRETOP)          ; Current bottom of string area        ;TOP OF FREE AREA
  JP GIVDBL               ;RETURN [H,L]-[D,E]


; Question (print '?' before a line input)
;
; Used by the routine at __RANDOMIZE.

; THIS IS THE LINE INPUT ROUTINE
; IT READS CHARACTERS INTO BUF USING _ AS THE
; CHARACTER DELETE CHARACTER AND @ AS THE LINE DELETE CHARACTER
; IF MORE THAN BUFLEN CHARACTER ARE TYPED, NO ECHOING
; IS DONE UNTIL A  _ @ OR CARRIAGE-RETURN IS TYPED.
; CONTROL-G WILL BE TYPED FOR EACH EXTRA CHARACTER.
; THE ROUTINE IS ENTERED AT INLIN, AT QINLIN TO TYPE A QUESTION MARK AND A SPACE FIRST
;
QINLIN:
  LD A,'?'           ;GET A QMARK
  CALL OUTDO         ;TYPE IT
  LD A,' '           ;SPACE
  CALL OUTDO         ;TYPE IT TOO
  JR PINLIN          ;NO CRUNCHING IN THIS CASE

; This entry point is used by the routines at PINLIN, DELCHR, TTYLIN and
; PUTBUF.
MORINP:
  CALL INCHR		; Get character and test ^O

  CP $01			; CTL-A  (enter in EDIT MODE?))
  JR NZ,INLNC1      ; NO, TREAT NORMALLY

  LD (HL),$00       ; SAVE TERMINATOR
  JR PINLIN_1       ; GO EDIT FROM HERE

; This entry point is used by the routine at PINLIN.
QINLIN_0:
  LD (HL),B         ; STORE ZERO IN BUF

; Line input (aka RINPUT)
;
; Used by the routines at PROMPT, QINLIN and TTYLIN.
PINLIN:
  XOR A
  LD (CHARC),A
  XOR A
  LD (INTFLG),A     ; FLAG TO DO CR
; This entry point is used by the routines at __LINE, NOTQTI and TTYLIN.
INLIN:
  CALL INCHR		; Get character and test ^O
  CP $01			; CTL-A to enter in EDIT mode
  JR NZ,TTYLIN
; This entry point is used by the routine at QINLIN.
PINLIN_1:
  CALL OUTDO_CRLF
  LD HL,-1
  JP __EDIT_3

; This entry point is used by the routine at TTYLIN.
RUBOUT:
  LD A,(RUBSW)
  OR A
  LD A,'\\'
  LD (RUBSW),A
  JR NZ,ECHDEL
  DEC B
  JR Z,QINLIN_0
  CALL OUTDO
  INC B
ECHDEL:
  DEC HL
  DEC B
  JR Z,OTKLN
  LD A,(HL)
  CALL OUTDO
  JR MORINP


IF ORIGINAL
; Routine at 19232
L4B20:
  DEC B                   ; Unused.   This was the entry point for 'DELCHR'
                          ;           in previous BASIC versions.
ENDIF


; Routine at 19233
;
; Used by the routine at TTYLIN.
DELCHR:
  DEC HL
  CALL OUTDO
  JR NZ,MORINP
; This entry point is used by the routines at PINLIN and TTYLIN.
OTKLN:
  CALL OUTDO              ; Output character in A
  CALL OUTDO_CRLF         ; Output CRLF


; A.K.A. PINSTREAM
; Accepts a line from a file or device
;
; Used by the routine at PINLIN.
TTYLIN:
  LD HL,BUF
  LD B,$01
  PUSH AF
  XOR A
  LD (RUBSW),A
  POP AF
; This entry point is used by the routines at QINLIN and PUTBUF.
INLNC1:
  LD C,A
  CP $7F                 ; RUBOUT ?
  JR Z,RUBOUT
  LD A,(RUBSW)
  OR A
  JR Z,TTYLIN_1
  LD A,'\\'
  CALL OUTDO
  XOR A
  LD (RUBSW),A
TTYLIN_1:
  LD A,C
  CP $07
  JR Z,PUTCTL
  CP $03                  ; CTL-C ?
  CALL Z,KILIN
  SCF
  RET Z
  CP $0D
  JP Z,NEXT_LINE
  CP $09                  ; Is it TAB ?
  JR Z,PUTCTL
  CP $0A
  JR NZ,TTYLIN_2
  DEC B
  JR Z,PINLIN
  INC B
  JR PUTCTL

TTYLIN_2:
  CP $15                  ; Is it control "U"?
  CALL Z,KILIN            ; Yes - Get another line (wipe current buffer)
  JP Z,PINLIN
  CP $08                  ; Is it delete (backspace: ctl-H) ?
  JR NZ,NO_DELETE         ; No, skip over
DO_DELETE:
  DEC B
  JP Z,INLIN
  CALL OUTDO
  LD A,' '
  CALL OUTDO
  LD A,$08
  JR DELCHR

NO_DELETE:
  CP $18                  ; CTL-X ?
  JR NZ,TTYLIN_3
  LD A,'#'                ; Print '#' to confirm
  JR OTKLN                ; .. and remove the current line being inserted

TTYLIN_3:
  CP $12                  ; Is it control "R"?
  JR NZ,PUTBUF            ; No - Put in buffer
  PUSH BC                 ; Save buffer length
  PUSH DE                 ; Save DE
  PUSH HL                 ; Save buffer address
  LD (HL),$00             ; Mark end of buffer
  CALL OUTDO_CRLF         ; do CRLF
  LD HL,BUF               ; Point to buffer start
  CALL LISPRT               ; Output buffer
  POP HL                  ; Restore buffer address
  POP DE                  ; Restore DE
  POP BC                  ; Restore buffer length
  JP MORINP               ; Get another character


; Routine at 19380
;
; Used by the routine at TTYLIN.
PUTBUF:
  CP ' '                  ; Is it a control code?
  JP C,MORINP             ; Yes - Ignore
; This entry point is used by the routine at TTYLIN.
PUTCTL:
  LD A,B                  ; Get number of bytes in buffer
  OR A
  JR NZ,PUTBUF_0
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H                  ; Test for line overflow
  OR L
  POP HL
  LD A,$07                ; CTRL-G: Set a bell
  JR Z,OUTIT              ; Ring bell if buffer full
  LD HL,BUF
  CALL ATOH
  EX DE,HL
  LD (CURLIN),HL
  JP BUFOV_ERR

PUTBUF_0:
  LD A,C
  LD (HL),C
  INC HL
  INC B
OUTIT:
  CALL OUTDO
  SUB $0A
  JP NZ,MORINP
  LD (TTYPOS),A
  LD A,$0D
  CALL OUTDO
PUTBUF_1:
  CALL INCHR		; Get character and test ^O
  OR A
  JR Z,PUTBUF_1
  CP $0D
  JP Z,MORINP
  JP INLNC1
  
; This entry point is used by the routine at TTYLIN.
NEXT_LINE:
  LD A,(INTFLG)
  OR A
  JP Z,FININL
  XOR A
  LD (HL),A
  LD HL,BUFMIN			; "," ..
  RET

; This entry point is used by the routines at __LINE and __INPUT.
SCNSEM:
  PUSH AF
  LD A,$00
  LD (INTFLG),A
  POP AF
  CP ';'
  RET NZ
  LD (INTFLG),A
  JP CHRGTB




; 'WHILE' BASIC instruction
__WHILE:
  LD (ENDFOR),HL          ;KEEP THE WHILE TEXT POINTER HERE
  CALL WNDSCN             ;SCAN FOR THE MATCHING WEND CAUSE AN ERRWH IF NO WEND TO MATCH
  CALL CHRGTB             ;POINT AT CHARACTWER AFTER WEND
  EX DE,HL                ;[D,E]= POSITION OF MATCHING WEND
  CALL FNDWND             ;SEE IF THERE IS A STACK ENTRY FOR THIS WHILE
  INC SP                  ;GET RID OF THE NEWSTT ADDRESS ON THE STACK
  INC SP
  JR NZ,WNOTOL            ;IF NO MATCH NO NEED TO TRUNCATE THE STACK
  ADD HL,BC               ;ELIMINATE EVERYTHING UP TO AND INCLUDING THE MATCHING WHILE ENTRY
  LD SP,HL
  LD (SAVSTK),HL
WNOTOL:
  LD HL,(CURLIN)          ;MAKE THE STACK ENTRY
  PUSH HL
  LD HL,(ENDFOR)          ;GET TEXT POINTER FOR WHILE BACK
  PUSH HL
  PUSH DE                 ;SAVE THE WEND TEXT POINTER
  JR __WEND_0             ;FINISH USING WEND CODE

; 'WEND' BASIC instruction
__WEND:
  JP NZ,SN_ERR            ;STATEMENT HAS NO ARGUMENTS
  EX DE,HL                ;FIND MATCHING WHILE ENTRY ON STACK
  CALL FNDWND
  JR NZ,WE_ERR            ;MUST MATCH OR ELSE ERROR
  LD SP,HL                ;TRUNCATE STACK AT MATCH POINT
  LD (SAVSTK),HL
  EX DE,HL                ;SAVE [H,L] POINTING INTO STACK ENTRY
  LD HL,(CURLIN)          ;REMEMBER WEND LINE #
IF ORIGINAL
  EX DE,HL                ; Useless side effect got by macros
  EX DE,HL                ;    ..here we probably had 2 consequent DE fetch/store operations 
ENDIF
  LD (NXTLIN),HL          ;IN NXTLIN
  EX DE,HL
  INC HL                  ;INDEX INTO STACK ENTRY TO GET VALUES
  INC HL                  ;SKIP OVER TEXT POINTER OF WEND
  LD E,(HL)               ;SET [D,E]=TEXT POINTER OF WHILE
  INC HL
  LD D,(HL)
  INC HL
  LD A,(HL)               ;[H,L]=LINE NUMBER OF WHILE
  INC HL
  LD H,(HL)
  LD L,A
  LD (CURLIN),HL          ;IN CASE OF ERROR OR CONTINUATION FIX CURLIN
  EX DE,HL                ;GET TEXT POINTER OF WHILE FORMULA INTO [H,L]

; This entry point is used by the routine at __WHILE.
__WEND_0:
  CALL EVAL               ;EVALUATE FORMULA
  PUSH HL                 ;SAVE TEXT POINTER
  CALL VSIGN              ;GET IF TRUE OR FALSE
  POP HL                  ;GET BACK WHILE TEXT POINTER
  JR Z,FLSWHL             ;GO BACK AT WEND IF FALSE
  LD BC,TK_WHILE          ;COMPLETE WHILE ENTRY
  LD B,C                  ;NEED IT IN THE HIGH BYTE
  PUSH BC
  INC SP                  ;ONLY USE ONE BYTE
  JP NEWSTT

; 'FALSE' condition in WHILE/WEND
FLSWHL:
  LD HL,(NXTLIN)          ;SETUP CURLIN FOR WEND
  LD (CURLIN),HL
  POP HL                  ;TAKE OFF TEXT OF WEND AS NEW TEXT POINTER
  POP BC                  ;GET RID OF TEXT POINTER OF WHILE
  POP BC                  ;TAKE OFF LINE NUMBER OF WHILE
  JP NEWSTT


;
; THIS SUBROUTINE SEARCHES THE STACK FOR AN WHILE ENTRY
; WHOSE WEND TEXT POINTER MATCHES [D,E]. IT RETURNS WITH ZERO TRUE
; IF A MATCH IS FOUND AND ZERO FALSE OTHERWISE. FOR ENTRIES
; ARE SKIPPED OVER, BUT GOSUB ENTRIES ARE NOT.
;

; This entry point is used by the routine at __WHILE.
FNDWND:
  LD HL,$0004             ;SKIP OVER RETURN ADDRESS AND NEWSTT
  ADD HL,SP
__WEND_3:
  LD A,(HL)               ;GET THE ENTRY TYPE
  INC HL                  
  LD BC,TK_FOR
  CP C                    ;SEE IF ITS $FOR
  JR NZ,__WEND_4
  LD BC,$0012             ; FORSZC+2? (size of a 'FOR' entry on stack)
  ADD HL,BC
  JR __WEND_3

__WEND_4:
  LD BC,TK_WHILE
  CP C
  RET NZ
  PUSH HL
  LD A,(HL)               ;PICK UP THE WEND TEXT POINTER
  INC HL
  LD H,(HL)
  LD L,A
  CALL DCOMPR
  POP HL
  LD BC,$0006
  RET Z                   ;RETURN IF ENTRY MATCHES
  ADD HL,BC
  JR __WEND_3
  
WE_ERR:
  LD DE,$001E		; Err $1E - "WEND without WHILE"
  JP ERROR







; 'CALL' BASIC command
; This is the CALL <simple var>[(<simple var>[,<simple var>]..)]
; Stragegy:
;
; 1.) Make sure suboutine name is simple var, get value & save it
; 2.) Allocate space on stack for param adresses
; 3.) Evaluate params & stuff pointers on stack
; 3.) POP off pointers ala calling convention
; 4.) CALL suboutine with return address on stack


; Extended and Disk BASIC-80 user function calls may also be made with the CALL statement.
; The calling sequence used is the same as that in Microsoft's FORTRAN, COBOL and BASIC compilers.

defc MAXPRM = 32

__CALL:
  LD A,$80                ;Flag PTRGET not to allow arrays
  LD (SUBFLG),A
  CALL GETVAR             ;Evaluate var pointer
  PUSH HL                 ;Save text pointer
  EX DE,HL                ;Var pointer to [H,L]
  CALL GETYPR             ;Get type of var
  CALL VMOVFM             ;Store value in FAC
  CALL GETWORD_HL         ;Evaluate var
  LD (INTFLG),HL          ;Save it
  LD C,MAXPRM             ;Check to see if we have space for max parm block
  CALL CHKSTK             ; Check for C levels on stack
  POP DE                  ;Get text pointer off stack
  LD HL,-MAXPRM*2         ;Get space on stack for parms
  ADD HL,SP
  LD SP,HL                ;Adjust stack
  EX DE,HL                ;Put text pointer in [H,L], stack pointer in [D,E]
  LD C,MAXPRM             ;Get # of params again
  DEC HL                  ;Back up text pointer
  CALL CHRGTB             ;Get char
  LD (TEMP),HL            ;Save text pointer
  JR Z,CALLST             ;If end of line, GO!   (jp if no parameters)
                          
  CALL SYNCHR             ;Eat left paren
  DEFM "("

GETPAR:
  PUSH BC                 ;Save count
  PUSH DE                 ;Save pointer into stack
  CALL GETVAR             ;Evaluate param address
  EX (SP),HL              ;Save text pointer get pointer into stack
  LD (HL),E               ;Save var address on stack
  INC HL
  LD (HL),D
  INC HL
  EX (SP),HL              ;Save back var pointer, get text pointer
  POP DE
  POP BC
  LD A,(HL)               ;Look at terminator
  CP ','                  ;Comma?
  JR NZ,ENDPAR            ;Test
  DEC C                   ;Decrement count of params
  CALL CHRGTB             ;Get next char
  JR GETPAR               ;Back for more
ENDPAR:
  CALL SYNCHR
  DEFM ")"                ;Should have left paren
  LD (TEMP),HL            ;Save text pointer
  LD A,MAXPRM+1           ;Calc # of params
  SUB C                   
  POP HL                  ;At least one, get its address in [H,L]    ; (HL=Parameter 1)
  DEC A                   ;Was it one?                               ; If the number of parameters is..
  JR Z,CALLST             ;Yes                  
  POP DE                  ;Next address in [D,E]                     ; (DE=Parameter 2)
  DEC A                   ;Two?                                      ; ...less than ..
  JR Z,CALLST             ;Yes
  POP BC                  ;Final in [B,C]                            ; (BC=Parameter 3)
  DEC A                   ;Three?                                    ; ...or equal to 3,
  JR Z,CALLST             ;Yes                                       ; they are passed in the registers.
  PUSH BC                 ;Save back third parm                  
  PUSH HL                 ;Save back first
  LD HL,$0002             ;Point to rest of parm list                ; If the number of parameters is greater than 3,
  ADD HL,SP                                                          ; parameters 3 through n will be in a contiguous data block
  LD B,H                  ;Get into [B,C]                            ; BC will point to the low byte of this data block
  LD C,L
  POP HL                  ;Restore parm three

CALLST:
  PUSH HL                 ;Save parm three
  LD HL,CALLRT            ;Where subroutines return
  EX (SP),HL              ;Put it on stack, get back parm three
  PUSH HL                 ;Save parm three
  LD HL,(INTFLG)          ;Get subroutine address
  EX (SP),HL              ;Save, get back parm three
  RET                     ;Dispatch to subroutine
  
CALLRT:
  LD HL,(SAVSTK)          ;Restore stack to former state
  LD SP,HL
  LD HL,(TEMP)            ;Get back text poiner
  JP NEWSTT               ;Get next statement



; This is the code for the CHAIN statement
; The syntax is:
; CHAIN [MERGE]<file name>[,[<line number>][,ALL][,DELETE <range>]]
; The steps required to execute a CHAIN are:
;
; 1.) Scan arguments
; 2.) Scan program for all COMMON statements and mark specified variables.
; 3.) Squeeze unmarked entries from symbol table.
; 4.) Copy string literals to string space
; 5.) Move all simple variables and arrays into the bottom of string space.
; 6.) Load new program
; 7.) Move variables back down positioned after program.
; 8.) Run program


; 'CHAIN' BASIC command
; To call a program and pass variables to it from the current program.
;
; CHAIN [MERGE] <filename>[,[<line number exp>] [,ALL] [,DELETE<range>]]
;
__CHAIN:
  XOR A                   ;Assume no MERGE
  LD (MRGFLG),A
  LD (MDLFLG),A           ;Also no MERGE w/ DELETE option
  LD A,(HL)               ;Get current char
  LD DE,TK_MERGE          ;Is it MERGE?; d=0, e=TK_MERGE
  CP E                    ;Test
  JR NZ,__CHAIN_0         ;NO
  LD (MRGFLG),A           ;Set MERGE flag
  INC HL
__CHAIN_0:
  DEC HL                  ;Rescan file name
  CALL CHRGTB
  CALL PRGFLI             ;Evaluate file name and OPEN it
  PUSH HL                 ;Save text pointer
  LD HL,$0000             ;Get zero
  LD (CHNLIN),HL          ;Assume no CHAIN line #
  POP HL                  ;Restore text pointer
  DEC HL                  ;Back up pointer
  CALL CHRGTB             ;Scan char
  JR Z,NTCHAL             ;No line number etc.
  CALL SYNCHR             
  DEFM ","                ;Must be comma
  CP ','                  ;Ommit line # (Use ALL for instance)
  JR Z,NTLINF             ;YES
  CALL EVAL               ;Evaluate line # formula
  PUSH HL                 ;Save text poiner
  CALL GETWORD_HL         ;Force to int in [H,L]
  LD (CHNLIN),HL          ;Save it for later
  POP HL                  ;Restore text poiner
  DEC HL                  ;Rescan last char
  CALL CHRGTB
  JR Z,NTCHAL             ;No ALL i.e. preserve all vars across CHAIN
NTLINF:
  CALL SYNCHR
  DEFM ","                ;Should be comma here
  LD DE,TK_DELETE         ;Test for DELETE option ; d=0, e=TK_DELETE
  CP E                    ;Is it?
  JR Z,CHMWDL             ;Yes
  CALL SYNCHR
  DEFM "A"                ;Check for "ALL"
  CALL SYNCHR
  DEFM "L"
  CALL SYNCHR
  DEFM "L"
  JP Z,DNCMDA             ;Goto step 4
  CALL SYNCHR
  DEFM ","                ;Force comma to appear
  CP E                    ;Must be DELETE
  JP NZ,SN_ERR            ;No, give error
  OR A                    ;Flag to goto DNCMDA
CHMWDL:
  PUSH AF                 ;Save ALL flag
  LD (MDLFLG),A           ;Set MERGE w/ DELETE
  CALL CHRGTB             ;Get char after comma
  CALL LNUM_RANGE         ;Scan line range
  PUSH BC
  CALL DEPTR              ;Change pointers back to numbers
  POP BC
  POP DE                  ;Pop max line off stack
  PUSH BC                 ;Save pointer to start of 1st line
  LD H,B                  ;Save pointer to start line
  LD L,C
  LD (CMSPTR),HL
  CALL SRCHLN             ;Find the last line
  JR NC,FCERRG            ;Must have exact match on end of range
  LD D,H                  ;[D,E] =  pointer at the start of the line
  LD E,L                  ;beyond the last line in the range
  LD (CMEPTR),HL          ;Save pointer to end line
  POP HL                  ;Get back pointer to start of range
  CALL DCOMPR             ;Make sure the start comes before the end
FCERRG:
  JP NC,FC_ERR            ;If not, "Illegal function call"
  POP AF                  ;Flag that says whether to go to DNCMDA
  JP NZ,DNCMDA            ;"ALL" option was present
NTCHAL:
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(TXTTAB)          ;Start searching for COMMONs at program start
  DEC HL                  ;Compensate for next instr
CLPSCN:
  INC HL                  ;Look at first char of next line
  LD A,(HL)               ;Get char from program
  INC HL
  OR (HL)                 ;Are we pointing to program end?
  JP Z,CLPFIN             ;Yes
  INC HL
  LD E,(HL)               ;Get line # in [D,E]
  INC HL
  LD D,(HL)
  LD (CURLIN),DE          ;Save current line # in CURLIN for errors
CSTSCN:
  CALL CHRGTB             ;Get statment type

; This entry point is used by the routine at BCKUCM.
AFTCOM:
  OR A
  JR Z,CLPSCN             ;EOL Scan next one
  CP ':'                  ;Are we looking at colon
  JR Z,CSTSCN             ;Yes, get next statement
  LD DE,TK_COMMON         ;Test for COMMON, avoid byte externals
  CP E                    ;Is it a COMMON?
  JR Z,CHAIN_COMMON       ;Yes, handle it
  CALL CHRGTB             ;Get first char of statement
  CALL __DATA             ;Skip over statement
  DEC HL                  ;Back up to rescan terminator
  JR CSTSCN               ;Scan next one

  
;	Example
;
;	100 COMMON A,B,C,D(),G$
;	110 CHAIN "PROG3",10 
  
CHAIN_COMMON:
  CALL CHRGTB             ;Get thing after COMMON
  JR Z,AFTCOM             ;Get next thing

; This entry point is used by the routine at BCKUCM.
NXTCOM:
  PUSH HL                 ;Save text pointer
  LD A,$01                ;Call PTRGET to search for array
  LD (SUBFLG),A
  CALL PTRGET             ;This subroutine in F3 scans variables
  JR Z,FNDAAY             ;Found array
  LD A,B                  ;Try finding array with COMMON bit set
  OR $80
  LD B,A
  XOR A                   ;Set zero CC
  CALL ARLDSV             ;Search array table
  LD A,$00                ;Clear SUBFLG in all cases
  LD (SUBFLG),A
  JR NZ,NTFN2T            ;Not found, try simple
  LD A,(HL)               ;Get terminator, should be "("
  CP '('                  ;Test
  JR NZ,SCNSMP            ;Must be simple then
  POP AF                  ;Get rid of saved text pointer
  JR COMADY               ;Already was COMMON, ignore it

NTFN2T:
  LD A,(HL)               ;Get terminator
  CP '('                  ;Array specifier?
  JP Z,FC_ERR             ;No such animal, give "Function call" error

; This entry point is used by the routine at VALTYP.
SCNSMP:
  POP HL                 ;Rescan variable name for start
  CALL PTRGET            ;Evaluate as simple
;COMPTR:
  LD A,D                 ;If var not found, [D,E]=0
  OR E
  JR NZ,COMFNS           ;Found it
  LD A,B                 ;Try to find in COMMON
  OR $80                 ;Set COMMON bit
  LD B,A

  LD DE,COMPT2
  PUSH DE
  LD DE,VARRET
  PUSH DE
  
  LD A,(VALTYP)          ;Must have VALTYP in [D]
  LD D,A
  JP NSCFOR              ;Search symbol table

; Routine at 17826
COMPT2:
  LD A,D                 ;Found?
  OR E
  JP Z,FC_ERR            ;No, who is this guy?

; This entry point is used by the routine at __CHAIN.
COMFNS:
  PUSH HL                ;Save text pointer
  LD B,D                 ;Get pointer to var in [B,C]
  LD C,E
  LD HL,BCKUCM           ;Loop back here
  PUSH HL
CBAKBL:
  DEC BC                 ;Point at first char of rest
LPBKNC:
  LD A,(BC)              ;Back up until plus byte
  DEC BC
  OR A
  JP M,LPBKNC
  LD A,(BC)              ;Now point to 2nd char of var name
  OR $80                 ;set COMMON bit
  LD (BC),A
  RET                    ;done
                         
; This entry point is used by the routine at __CHAIN.
FNDAAY:
  LD (SUBFLG),A          ;Array found, clear SUBFLG
  LD A,(HL)              ;Make sure really array spec
  CP '('                 ;Really an array?
  JR NZ,SCNSMP           ;No, scan as simp
  EX (SP),HL             ;Save text pointer, get rid of saved text pointer
  DEC BC                 ;Point at last char of name extension
  DEC BC
  CALL CBAKBL            ;Back up before variable and mark as COMMON

; Routine at 17865
BCKUCM:
  POP HL                 ;Restore text pointer
  DEC HL                 ;Rescan terminator
  CALL CHRGTB
  JP Z,AFTCOM            ;End of COMMON statement
  CP '('                 ;End of COMMON array spec?
  JR NZ,CHKCST           ;No, should be comma
; This entry point is used by the routine at __CHAIN.
COMADY:
  CALL CHRGTB            ;Fetch char after paren
  CALL SYNCHR
  DEFM ")"               ;Right paren should follow
  JP Z,AFTCOM            ;End of COMMON
CHKCST:
  CALL SYNCHR            ;Force comma to appear here
  DEFM ","               ;Get next COMMON variable
  JP NXTCOM


; Step 3 - Squeeze..
; This entry point is used by the routine at __CHAIN.
CLPFIN:
  POP HL
  LD (CURLIN),HL
  LD DE,(ARYTAB)         ;End of simple var squeeze
  LD HL,(VARTAB)         ;Start of simps
CLPSLP:
  CALL DCOMPR            ;Are we done?
  JR Z,DNCMDS            ;Yes done, with simps
  PUSH HL                ;Save where this simp is
  LD C,(HL)              ;Get VALTYP
  INC HL
  INC HL
  LD A,(HL)              ;Get COMMON bit
  OR A                   ;Set minus if COMMON
  PUSH AF                ;Save indicator
  AND $7F                ;Clear COMMON bit
  LD (HL),A              ;Save back
  INC HL
  CALL IADAHL            ;Skip over rest of var name
  LD B,$00               ;Skip VALTYP bytes
  ADD HL,BC
  POP AF                 ;Get indicator whether to delete
  POP BC                 ;Pointer to where var started
  JP M,CLPSLP
  PUSH BC                ;This is where we will resume scanning vars later
  CALL VARDLS            ;Delete variable
  LD HL,(ARYTAB)         ;Now correct ARYTAB by # of bytes deleted
  ADD HL,DE              ;Add negative difference between old and new
  LD (ARYTAB),HL         ;Save new ARYTAB
  EX DE,HL               ;To [D,E]
  POP HL                 ;Get current place back in [H,L]
  JR CLPSLP

VARDLS:
  EX DE,HL               ;Point to where var ends
  LD HL,(STREND)         ;One beyond last byte to move
DLSVLP:
  CALL DCOMPR            ;Done?
  LD A,(DE)              ;Grab byte
  LD (BC),A              ;Move down
  INC DE                 ;Increment pointers
  INC BC
  JR NZ,DLSVLP
  LD A,C                 ;Get difference between old and new
  SUB L                  ;Into [D,E] ([D,E]=[B,C]-[H,L])
  LD E,A
  LD A,B
  SBC A,H
  LD D,A
  DEC DE                 ;Correct # of bytes
  DEC BC                 ;Moved one too far
  LD H,B                 ;Get new STREND [H,L]
  LD L,C
  LD (STREND),HL         ;Store it
  RET

DNCMDS:
  LD DE,(STREND)         ;Limit of array search
CLPAKP:
  CALL DCOMPR            ;Done?
  JR Z,DNCMDA            ;Yes
  PUSH HL                ;Save pointer to VALTYP
  INC HL                 ;Move down to COMMON bit
  INC HL                 
  LD A,(HL)              ;Get it
  OR A                   ;Set CC's
  PUSH AF                ;Save COMMON indicator
  AND $7F                ;Clear COMMON bit
  LD (HL),A              ;Save back
  INC HL                 ;Point to length of array
  CALL IADAHL            ;Add length of var name
  LD C,(HL)              ;Get length of array in [B,C]
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC              ;[H,L] now points after array
  POP AF                 ;Get back COMMON indicator
  POP BC                 ;Get pointer to start of array
  JP M,CLPAKP            ;COMMON, dont delete!
  PUSH BC                ;Save so we can resume
  CALL VARDLS            ;Delete variable
  EX DE,HL               ;Put STREND in [D,E]
  POP HL                 ;Point to next var
  JR CLPAKP              ;Look at next array



; CHAIN: With the ALL option, every variable in the current program is passed to the called program

; Step 4 - Copy literals into string space
; This code is very smilar to the string garbage collect code
;
; Used by the routines at __CHAIN and BCKUCM.
DNCMDA:
  LD HL,(VARTAB)         ;Look at simple strings
CSVAR:
  LD DE,(ARYTAB)         ;Limit of search
  CALL DCOMPR            ;Done?
  JR Z,CAYVAR            ;Yes

  CALL DNCMDA_SUB        ;Get VALTYP of array
  JR NZ,CSKPVA           ;If not string, skip this var

  CALL CDVARS            ;Copy this guy into string space if nesc
  XOR A                  ;CDVARS has already incremented [H,L]
CSKPVA:
  LD E,A
  LD D,$00               ;Add length of VALTYP
  ADD HL,DE
  JR CSVAR

CAYVA2:
  POP BC                 ;Adjust stack

; This entry point is used by the routine at CAYSTR.
CAYVAR:
  LD DE,(STREND)         ;New limit of search
  CALL DCOMPR            ;Done?
  JR Z,DNCCLS            ;Yes
  CALL DNCMDA_SUB        ;Get VALTYP of array
  PUSH AF                ;Save VALTYP
  LD C,(HL)              ;Get length of array
  INC HL
  LD B,(HL)              ;Into [B,C]
  INC HL
  POP AF                 ;Get back VALTYP
  PUSH HL                ;Save pointer to array element
  ADD HL,BC              ;Point after array
  CP $03                 ;String array?
  JR NZ,CAYVA2           ;No, look at next one
  LD (TEMP3),HL          ;Save pointer to end of array
  POP HL                 ;Get back pointer to array start
  LD C,(HL)              ;Pick up number of DIMs
  LD B,$00               ;Make double with high zero
  ADD HL,BC              ;Go past DIMS
  ADD HL,BC
  INC HL                 ;One more to account for # of DIMs

; Routine at 18091
CAYSTR:
  LD DE,(TEMP3)          ;Get end of array
  CALL DCOMPR            ;See if at end of array
  JR Z,CAYVAR            ;Get next array
  LD BC,CAYSTR            ;Do next str in array
  PUSH BC                ;Save branch address on stack

; This entry point is used by the routine at DNCMDA.
CDVARS:
  LD A,(HL)              ;Get length of array
  INC HL
  LD E,(HL)              ;Also pick up pointer into [D,E]
  INC HL
  LD D,(HL)
  INC HL                 ;[H,L] points after descriptor
  OR A                   ;
  RET Z                  ;Ignore null strings
  PUSH HL                ;Save where we are
  LD HL,(VARTAB)         ;Is string in program text or disk buffers?
  CALL DCOMPR            ;Compare
  POP HL                 ;Restore where we are
  RET C                  ;No, must be in string space
  PUSH HL                ;save where we are again.
  LD HL,(TXTTAB)         ;is it in buffers?
  CALL DCOMPR            ;test
  POP HL                 ;Restore where we are
  RET NC                 ;in buffers, do nothing
  PUSH HL                ;Save where we are for nth time
  DEC HL                 ;Point to start of descriptor
  DEC HL
  DEC HL
  PUSH HL                ;Save pointer to start
  CALL STRCPY            ;Copy string into DSCTMP
  POP HL                 ;Destination in [H,L], source in [D,E]
  LD B,$03               ;# of bytes to move
  CALL MOVE1             ;Move em
  POP HL                 ;Where we are
  RET


; Step 5 - Move stuff up into string space!
; This entry point is used by the routine at DNCMDA.
DNCCLS:
  CALL GARBGE            ;Get rid of unused strings
  LD HL,(STREND)         ;Load end of vars
  LD B,H                 ;Into [B,C]
  LD C,L
  LD DE,(VARTAB)         ;Start of simps into [D,E]
  LD HL,(ARYTAB)         ;Get length of simps in [H,L]
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD (TEMP9),HL          ;Save here
  LD HL,(FRETOP)         ;Destination of high byte
  LD (SAVFRE),HL         ;Save FRETOP to restore later
  CALL MOVSTR            ;Move stuff up
  LD H,B                 ;Now adjust top of memory below saved vars
  LD L,C
  DEC HL                 ;One lower to be sure
  LD (FRETOP),HL         ;Update FRETOP to reflect new value
  LD A,(MDLFLG)          ;MERGE w/ DELETE?
  OR A                   ;Test
  JR Z,CAYSTR_2          ;No
  LD HL,(CMSPTR)         ;Start of lines to delete
  LD B,H                 ;Into [B,C]
  LD C,L
  LD HL,(CMEPTR)         ;End of lines to delete
  CALL __DELETE_0        ;Delete the lines
  LD (ARYTAB),HL         ;Re-link lines just in case
  LD (STREND),HL
  CALL LINKER


; Step 6 - load new program
CAYSTR_2:
  LD A,$01               ;Set CHAIN flag
  LD (CHNFLG),A
  LD A,(MRGFLG)          ;MERGEing?
  OR A                   ;Set cc'S
  JP NZ,OKGETM           ;Do MERGE
  LD A,(MAXFIL)          ;Save the number of files
  LD (MAXFILSV),A        ;Since we make it look like zero
  JP CHNENT              ;Jump to LOAD code


; Step 7 - Move stuff back down
; This entry point is used by the routines at __LOAD and L4D05.
CHNRET:
  XOR A                  ;Clear CHAIN, MERGE flags
  LD (CHNFLG),A
  LD (MRGFLG),A
  LD HL,(VARTAB)         ;Get current VARTAB
  LD B,H                 ;Into [B,C]
  LD C,L
  LD HL,(TEMP9)          ;Get length of simps
  ADD HL,BC              ;Add to present VARTAB to get new ARYTAB
  LD (ARYTAB),HL
  LD HL,(FRETOP)         ;Where to start moving
  INC HL                 ;One higher
  EX DE,HL               ;Into [D,E]
  LD HL,(SAVFRE)         ;Last byte to move
  LD (FRETOP),HL         ;Restore FRETOP from this
MVBKVR:
  CALL DCOMPR            ;Done?
  LD A,(DE)              ;Move byte down
  LD (BC),A
  INC DE                 ;Increment pointers
  INC BC
  JR NZ,MVBKVR
  DEC BC                 ;Point to last var byte
  LD H,B                 ;[H,L]=last var byte
  LD L,C
  LD (STREND),HL         ;This is new end
  LD DE,(CHNLIN)         ;Get CHAIN line #
  LD HL,(TXTTAB)         ;Get prog start in [H,L]
  DEC HL                 ;Point at zero before program
  LD A,D
  OR E                   ;Test for zero
  JP Z,NEWSTT            ;line #=0, go...
  CALL SRCHLN            ;Try to find destination line
  JP NC,UL_ERR           ;Not there...
  DEC BC                 ;Point to zero on previous line
  LD H,B                 ;Make text pointer for NEWSTT
  LD L,C
  JP NEWSTT              ;Bye...

; This entry point is used by the routine at DNCMDA.
DNCMDA_SUB:
  LD A,(HL)            ;Get VALTYP
  INC HL               ;Point to length of long var name
  INC HL
  INC HL
  PUSH AF              ;Save VALTYP
  CALL IADAHL          ;Move past long variable name
  POP AF               ;Ge back VALTYP
  CP $03               ;String?
  RET

IF ORIGINAL
;COMMON:
  JP __DATA
ENDIF

__WRITE:
  LD C,$02             ; MD.SQO: Setup output file
  CALL FILGET          ; Look for '#' channel specifier and put the associated file buffer in BC
  DEC HL
  CALL CHRGTB          ;Get another character
  JR Z,WRTFIN          ;Done with WRITE
WRTMLP:
  CALL EVAL            ;Evaluate formula
  PUSH HL              ;Save the text pointer
  CALL GETYPR          ;See if we have a string
  JR Z,WRTSTR          ;We do
  CALL FOUT            ;Convert to a string
  CALL CRTST           ;Literalize string
  LD HL,(FACCU)        ;Get pointer to string
  INC HL               ;Point to address field
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)            ;Is number positive?
  CP ' '               ;Test
  JR NZ,WRTNEG         ;No, must be negative
  INC DE
  LD (HL),D
  DEC HL
  LD (HL),E
  DEC HL
  DEC (HL)             ;Adjust length of string
WRTNEG:
  CALL PRS1            ;Print the number
NXTWRV:
  POP HL               ;Get back text pointer
  DEC HL               ;Back up pointer
  CALL CHRGTB          ;Get next char
  JR Z,WRTFIN          ;end
  CP ';'               ;Semicolon?
  JR Z,WASEMI          ;Was one
  CALL SYNCHR
  DEFM ","             ;Only possib left is comma
  DEC HL               ;to compensate for later CHRGET
WASEMI:
  CALL CHRGTB          ;Fetch next char
  LD A,','             ;put out comma
  CALL OUTDO
  JR WRTMLP            ;Back for more

WRTSTR:
  LD A,'"'             ;put out double quote
  CALL OUTDO           ;Send it
  CALL PRS1            ;print the string
  LD A,'"'             ;Put out another double quote
  CALL OUTDO           ;Send it
  JR NXTWRV            ;Get next value

WRTFIN:
  PUSH HL              ;Save text pointer
  LD HL,(PTRFIL)       ;See if disk file
  LD A,H
  OR L
  JR Z,NTRNDW          ;No
  LD A,(HL)            ;Get file mode
  CP $03               ;MD.RND: Random?
  JR NZ,NTRNDW         ;NO
  CALL CMPFBC          ;See how many bytes left
  ; HL=HL-DE
  LD A,L               ;do subtract
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD DE,-2             ;Subtract number of bytes in CR/LF sequence
  ADD HL,DE
  JR NC,NTRNDW         ;Not enough, give error eventually
CRLFSQ:
  LD A,' '             ;Put out spaces
  CALL OUTDO           ;Send space
  DEC HL               ;Count down
  LD A,H
  OR L
  JR NZ,CRLFSQ
NTRNDW:
  POP HL               ;Restore [H,L]
  CALL OUTDO_CRLF      ;Do crlf
  JP FINPRT


; FILINP AND FILGET -- SCAN A FILE NUMBER AND SETUP PTRFIL

; REVISION HISTORY
; 4/23/78   PGA - ALLOW # ON CLOSE
; 8/6/79    PGA - IF ^C ON MBASIC FOO, DONT RETURN TO SYSTEM. SEE 'NOTINI'
; 6/27/80   PGA - FIX INPUT#1,D# SO IT USES FINDBL INSTEAD OF FIN AND THUS AVOIDS LOSING SIGNIFICANCE.

; Get stream number (default #channel=1)
; Used by the routines at FILSTI and LINE_INPUT.
FILINP:
  LD C,$01               ; (MD.SQI) MUST BE SEQUENTIAL INPUT

; Get stream number (C=default #channel)
; Look for '#' channel specifier and put the associated file buffer in BC
;
; Used by the routines at __PRINT and CAYSTR.
FILGET:
  CP '#'             ;NUMBER SIGN THERE?
  RET NZ             ;NO, NOT DISK READER

  PUSH BC            ;SAVE EXPECTED MODE
  CALL FILSCN        ;READ AND GET POINTER (in BC)
  POP DE             ;[E]=FILE MODE
  CP E               ;IS IT RIGHT?
  JR Z,GDFILM        ;GOOD FILE MODE
  CP $03             ;ALLOW STUFF WITH RANDOM FILES
  JP NZ,FMODE_ERR    ;IF NOT, "BAD FILE MODE"

GDFILM:
  CALL SYNCHR
  DEFM ","               ;GO PAST THE COMMA

; This entry point is used by the routine at FN_INPUT.
FILSET:
  LD D,B
  LD E,C
  LD (PTRFIL),DE         ;SETUP PTRFIL
  RET

;
; AT THIS ENTRY POINT [H,L] IS ASSUMED TO BE THE TEXT POINTER AND
; A FILE NUMBER IS SCANNED
;
; This entry point is used by the routines at __FIELD, FN_INPUT and __GET.
FILSCN:
  DEC HL
  CALL CHRGTB
  CP '#'                ;MAKE NUMBER SIGN OPTIONAL
  CALL Z,CHRGTB         ;BY SKIPPING IT IF THERE
  CALL EVAL             ;READ THE FILE NUMBER INTO THE FAC

;
; CONVERT ARGUMENT TO FILE NUMBER AND SET [B,C] TO POINT TO FILE DATA BLOCK
;
; AT THIS ENTRY POINT THE FAC HAS THE FILE NUMBER IN IT ALREADY
;
; a.k.a. GETFLP
; This entry point is used by the routines at __EOF, __LOC and __LOF.
FILFRM:
  CALL CONINT           ;GET THE FILE NUMBER INTO [A]

;
; AT THIS POINT IT IS ASSUMED THE FILE NUMBER IS IN [A]
; THE FILE NUMBER IS RETURNED IN [E]
; [D] IS SET TO ZERO. [H,L] IS SAVED.
; [B,C] IS SET TO POINT AT THE FILE DATA BLOCK FOR FILE [E]
; [A] GIVE THE MODE OF THE FILE AND ZERO IS SET  IF THE FILE IS MODE ZERO (NOT OPEN).
;
; This entry point is used by the routines at CPM_CLSFIL and __OPEN.
; a.k.a. VARPTR_A, GETPTR
FILIDX:
  LD E,A                ;GET FILE NUMBER INTO [E]
FILID2:
  LD A,(MAXFIL)         ;IS THIS FILE # LEGAL?
  CP E
  JP C,BN_ERR           ;IF NOT, "BAD FILE NUMBER"
  LD D,$00              ;SETUP DOUBLE-BYTE OFFSET TO GET POINTER TO FILE DATA BLOCK
  PUSH HL               ;SAVE [H,L]
  LD HL,FILPTR          ;POINT AT POINTER TABLE
  ADD HL,DE             ;ADD ON OFFSET TWICE FOR DOUBLE BYTE
  ADD HL,DE             ;ENTRIES
  LD C,(HL)             ;PICK UP POINTER IN [B,C]
  INC HL
  LD B,(HL)
  LD A,(BC)             ;GET MODE OF FILE INTO [A]
  OR A                  ;SET ZERO IF FILE NOT OPEN
  POP HL                ;RETRIEVE [H,L]
  RET

; GETPTR IS CALLED FROM VARPTR(#<EXPRESSION>)
; This entry point is used by the routine at __ERL.
GETPTR:
  CALL FILID2           ;INDEX INTO FILE DATA BLOCK
  LD HL,$0029           ;DATOFC: POINT TO DATA BLOCK
  CP $03                ;(MD.RND) RANDOM FILE?
  JR NZ,NTFIVD          ;NO, USE NORMAL OFFSET
  LD HL,$00B2           ;FD.DAT: YES

NTFIVD:
  ADD HL,BC             ;ADD START OF FILE DATA BLOCK
  EX DE,HL              ;RETURN IN [D,E]
  RET

; label='MKI$' BASIC function
__MKI_S:
  LD A,$02              ;VALUE TYPE FOR INTEGER AND NUMBER OF CHARACTERS RESULT WILL NEED

  DEFB $01              ; "LD BC,nn" to SKIP THE NEXT TWO BYTES

; 'MKS$' BASIC function
__MKS_S:
  LD A,$04              ;VALUE TYPE OF SINGLE PRECISION

  DEFB $01              ; "LD BC,nn" to SKIP THE NEXT TWO BYTES

; 'MKD$' BASIC function
__MKD_S:
  LD A,$08              ;VALUE TYPE OF DOUBLE-PRECISION
  PUSH AF               ;SAVE THE NUMBER OF BYTES OF STRING SPACE WE NEED
  CALL CHKTYP           ;CONVERT FAC TO PROPER TYPE
  POP AF                ;GET THE NUMBER OF BYTES NEEDED
  CALL MKTMST           ;GET A PLACE FOR THE STRING DATA
  LD HL,(TMPSTR)        ;POINT TO THE PLACE TO STORE THE DATA
  CALL VMOVMF           ;MOVE THE FAC VALUE INTO THE STRING CREATION
  JP TOPOOL             ;FINISH UP THESE STRING FUNCTIONS

; 'CVI' BASIC function
__CVI:
  LD A,$01              ;SET [A] TO BE VALTYP-1

  DEFB $01              ; "LD BC,nn" to SKIP THE NEXT TWO BYTES

; 'CVS' BASIC function
; Routine at 16207
__CVS:
  LD A,$03              ;ALSO SET [A] TO NUMBER OF CHARACTERS REQUIRED -1

  DEFB $01              ; "LD BC,nn" to SKIP THE NEXT TWO BYTES

; 'CVD' BASIC function
__CVD:
  LD A,$07              ;DOUBLE PRECISION VALUE TYPE -1
  PUSH AF               ;SAVE THE VALTYP
  CALL GETSTR           ;MAKE SURE THE ARGUMENT IS A STRING AND GET A POINTER TO THE DESCRIPTOR
  POP AF                ;GET BACK NUMBER OF CHARACTERS REQUIRED-1
  CP (HL)               ;MAKE SURE THE STRING IS LONGER THAN THAT
  JP NC,FC_ERR          ;IF NOT, "ILLEGAL FUNCTION CALL"
  INC A                 ;[A]=TRUE VALUE TYPE
  LD (VALTYP),A
  INC HL                ;[H,L]=POINTER AT STRING DATA
  LD A,(HL)             ;TO BE MOVED INTO THE FAC
  INC HL
  LD H,(HL)
  LD L,A                ;SETUP VALUE TYPE FOR MOVE AND FOR IDENTIFICATION
  JP VMOVFM             ;MOVE IN THE STRING DATA

; c16233
;
; Used by the routine at __READ.
FILIND:
  CALL GETYPR           ;SEE IF INPUT IS STRING OR NUMBER
  LD BC,DOASIG          ;RETURN ADDRESS TO SETUP [FAC]
  LD DE,$2C20           ; D=','  E=' '   ..SETUP TERMINATORS SPACE AND COMMA
  JR NZ,INPDOR          ;IF NUMERIC, GO READ THE FILE
  LD E,D                ;MAKE BOTH TERMINATORS COMMA
  JR INPDOR             ;GO READ THE FILE

; Line input
; LINE INPUT & READ CODE FOR ITEM FETCHING FROM SEQUENTIAL INPUT FILES
;
; Used by the routine at __LINE.
LINE_INPUT:
  CALL FILINP           ;GET FILE NUMBER SET UP
  CALL GETVAR           ;READ STRING TO STORE INTO
  CALL TSTSTR           ;MAKE SURE IT WAS A STRING
  LD BC,FINPRT          ;RESET TO CONSOLE WHEN DONE READING         ; <- Possible fix:  move this assignment on top
  PUSH BC               ;SAVE ON STACK                              ;                   of LINE_INPUT
  PUSH DE               ;SAVE POINTER AT VARIABLE
  LD BC,LETCON          ;GOOD RETURN ADDRESS FOR ASSIGNMENT
  XOR A                 ;SET A=0 FOR STRING VALUE TYPE
  LD D,A                ;ZERO OUT BOTH TERMINATORS
  LD E,A
; This entry point is used by the routine at FILIND.
INPDOR:
  PUSH AF               ;SAVE VALUE TYPE
  PUSH BC               ;SAVE RETURN ADDRESS
  PUSH HL               ;SAVE POINTER AT DATA COMING IN A DUMMY POINTER AT BUFMIN
NOTNWT:
  CALL RDBYT            ;READ A CHARACTER
  JP C,EF_ERR           ;READ PAST END ERROR IF EOF  -  Err: "Input past END" 
  CP ' '                ;SKIP LEADING SPACES
  JR NZ,NOTSPC          ;EXCEPT FOR LINE INPUT
  INC D                 ;CHECK FOR LINEINPUT
  DEC D
  JR NZ,NOTNWT          ;SKIP ANY NUMBER
NOTSPC:
  CP '"'               	;QUOTED STRING COMING IN?
  JR NZ,NOTQTE
  LD A,E                ;SAVE THE QUOTE
  CP ','                ;MUST BE INPUT OF A STRING
  LD A,'"'              ;WHICH HAS [E]=44
  JR NZ,NOTQTE          ;QUOTE BACK INTO [A]
  LD D,A
  LD E,A                ;TERMINATORS ARE QUOTES ONLY
  CALL RDBYT
  JR C,QUITSI           ;READ PAST QUOTATION
NOTQTE:                	;IF EOF, ALL DONE
  LD HL,BUF             ;BUFFER FOR DATA
  LD B,$FF              ;MAXIMUM NUMBER OF CHARACTERS (255)
LOPCRS:
  LD C,A                ;SAVE CHARACTER IN [C]
  LD A,D                ;CHECK FOR QUOTED STRING
  CP '"'
  LD A,C                ;RESTORE CHARACTER
  JR Z,NOTQTL           ;DON'T IGNORE CR OR STOP ON LF
  CP $0D                ;CR?
  PUSH HL               ;SAVE DEST PTR. ON STACK
  JR Z,ICASLF           ;EAT LINE FEED IF ONE
  POP HL                ;RESTORE DEST. PTR.
  CP $0A                ;LF?
  JR NZ,NOTQTL          ;NO, TEST OTHER TERMINATORS
SKIP_LF:
  LD C,A                ;SAVE CURRENT CHAR
  LD A,E                ;GET TERMINATOR 2
  ;  MBASIC v.5.20 and 5.22 have a bug here, they check for 54 DECIMAL ('6') rather than 54 OCTAL (',') !!
IF KEEP_BUG
  CP '6'
ELSE
  CP ','                ;CHECK FOR COMMA (UNQUOTED STRING)
ENDIF
  LD A,C                ;RESTORE ORIG CHAR
  CALL NZ,STRCHR        ;IF NOT, STORE LF (?)
  CALL RDBYT            ;GET NEXT CHAR
  JR C,QUITSI           ;IF EOF, ALL DONE.

IF !ORIGINAL
  ; This extra check exists on Tandy M100, Olivetti M10 and MSX
  CP $0A                ;IS IT A LF?
  JR Z,SKIP_LF
ENDIF

  CP $0D                ;IS IT A CR?
  JR NZ,NOTQTL          ;IF NOT SEE IF STORE NORMALLY
  LD A,E                ;GET TERMINATOR
  CP ' '                ;IS IT NUMERIC INPUT?
  JR Z,LPCRGT           ;IF SO, IGNORE CR, DONT PUT IN BUFFER
  CP ','                ;IS IT NON-QUOTED STRING (TERM=,)
  LD A,$0D              ;GET BACK CR.
  JR Z,LPCRGT           ;IF SO, IGNORE CR.
NOTQTL:
  OR A                  ;IS CHAR ZERO
  JR Z,LPCRGT           ;ALWAYS IGNORE, AS IT IS TERMINATOR FOR STRLIT (SEE QUIT2B)
  CP D                  ;TERMINATOR ONE?
  JR Z,QUITSI           ;STOP THEN
  CP E                  ;TERMINATOR TWO?
  JR Z,QUITSI
  CALL STRCHR           ;SAVE THE CHAR
LPCRGT:
  CALL RDBYT
  JR NC,LOPCRS
QUITSI:
  PUSH HL               ;SAVE PLACE TO STUFF ZERO
  CP '"'                ;STOPPED ON QUOTE?
  JR Z,MORSPC           ;DON'T SKIP SPACES THEN, BUT DO SKIP FOLLOWING COMMA OR CRLF THOUGH
  CP ' '                ;STOPPED ON SPACE?
  JR NZ,NOSKCR          ;NO, DON'T SKIP SPACES OR ANY FOLLOWING COMMAS OR CRLFS EITHER
MORSPC:
  CALL RDBYT            ;READ SPACES
  JR C,NOSKCR           ;EOF, ALL DONE.
  CP ' '
  JR Z,MORSPC
  CP ','                ;COMMA?
  JR Z,NOSKCR           ;OK, SKIP IT
  CP $0D                ;CARRIAGE RETURN?
  JR NZ,BAKUPT          ;BACK UP PAST THIS CHARACTER
ICASLF:
  CALL RDBYT            ;READ ANOTHER
  JR C,NOSKCR           ;EOF, ALL DONE.
  CP $0A                ;LINE FEED?
  JR Z,NOSKCR           ;OK, SKIP IT TOO
BAKUPT:
  LD HL,(PTRFIL)        ;GO TO NUMBER OF CHARATERS
  LD BC,$0028           ;NMLOFS
  ADD HL,BC
  INC (HL)              ;BACK UP BY INCREMENTING CHARACTER COUNT
NOSKCR:
  POP HL                ;GET BACK PLACE TO STORE TERMINATOR
QUIT2B:
  LD (HL),$00           ;STORE THE TERMINATOR
  LD HL,BUFMIN			;(buf-1) ITEM IS NOW STORED AT THIS POINT +1
  LD A,E                ;WAS IT A NUMERIC INPUT?
  SUB ' '               ;IF SO, [E]=" "
  JR Z,NUMIMK           ;USE FIN TO SCAN IT
  LD B,D                ;SET [B]=44 IF SCANNING UNQUOTED STRING
  LD D,$00
  CALL DTSTR
  POP HL                ;GET BACK [H,L]
  RET                   ;DO ASSIGNMENT

NUMIMK:
  CALL GETYPR           ;GET TYPE OF NUMERIC VARIABLE BEING READ
  PUSH AF               ;SAVE IT
  CALL CHRGTB           ;READ FIRST CHARACTER
  POP AF                ;RESTORE TYPE OF VARIABLE
  PUSH AF               ;SAVE BACK
  CALL C,FIN            ;SINGLE PRECISION INPUT
  POP AF                ;GET BACK TYPE OF VAR
  CALL NC,FIN_DBL       ;DOUBLE PRECISION INPUT
  POP HL                ;GET [H,L]
  RET                   ;DO THE ASSIGNMENT

STRCHR:
  OR A                  ;TRYING TO STORE NULL BYTE
  RET Z                 ;RETURN, DONT STORE IT
  LD (HL),A             ;STORE THE CHARACTER
  INC HL 
  DEC B                 ;128 YET?
  RET NZ                ;MORE SPACE IN BUFFER, RETURN
  POP BC                ;GET RID OF SUPERFLUOUS STACK ENTRY
  JR QUIT2B             ;SPECIAL QUIT

; This entry point is used by the routines at __LOAD, __MERGE and __CHAIN.
PRGFLI:
  LD D,$01              ;MD.SQI: SEQUENTIAL INPUT MODE
; This entry point is used by the routine at __MERGE.
FILE_OPENOUT:
  XOR A                 ;INTERNAL FILE NUMBER IS ALWAYS ZERO
  JP PRGFIL             ;SCAN FILE NAME AND DISK NUMMER
                        ;AND DO THE RIGHT THING USING MD.KIL AS A FLAG


; Load and run a file, used also at boot time
; Used by the routines at __RUN and INITSA.
IF !TAPE
LRUN:
  DEFB $F6                ; 'OR $AF'  ;SET NON ZERO TO FLAG "RUN" COMMAND
ENDIF

; 'LOAD' BASIC command
__LOAD:

IF TAPE
  CP '!'            ; New Syntax.  LOAD! replaces CLOAD, we ran out of space for TOKEN codes !
  JP Z,__CLOAD

LRUN:
  DEFB $F6                ; 'OR $AF'  ;SET NON ZERO TO FLAG "RUN" COMMAND
ENDIF


  XOR A                 ;FLAG ZERO FOR "LOAD"
  PUSH AF               ;SAVE "RUN"/"LOAD" FLAG
  CALL PRGFLI           ;FIND THAT FILE AND SETUP FOR USING INDSKC SUBROUTINE
  LD A,(MAXFIL)         ;SAVE THE NUMBER OF FILES
  LD (MAXFILSV),A       ;  (LSTFRE+1) SINCE WE MAKE IT LOOK LIKE ZERO
                        ;SO ,R OPTION CAN LEAVE FILES OPEN
  DEC HL                ;SEE IF NO RUN OPTION
  CALL CHRGTB
  JR Z,NOTRNL           ;NO, JUST LOAD
  CALL SYNCHR
  DEFM ","              ;GOTTA HAVE A COMMA
  CALL SYNCHR
  DEFM "R"              ;ONLY OPTION IS RUN
  JP NZ,SN_ERR          ;AND THAT BETTER BE THE END
  POP AF                ;GET RID OF "RUN"/"LOAD" FLAG
; This entry point is used by the routine at CAYSTR.
CHNENT:
  XOR A                 ;SO FILES AREN'T CLOSED
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  DEFB $F6                ; "OR n" to Mask 'POP AF'        ; FLAG RUN WITH NON-ZERO
NOTRNL:
  POP AF                ;FLAG NON-RUN WITH ZERO
  LD (AUTORUN),A
  LD HL,DIRTMP
  LD (HL),$00
  LD (FILPTR),HL        ;MESS UP POINTER AT FILE ZERO
  CALL CLRPTR           ;WIPE OUT OLD STUFF
  LD A,(MAXFILSV)       ;(LSTFRE+1), RESTORE MAXFIL
  LD (MAXFIL),A			;THAT WAS KLUDGED
  LD HL,(FILPT1)
  LD (FILPTR),HL        ;RESTORE BACK TO NORMAL
  LD (PTRFIL),HL        ;PTRFIL GOT ZEROED SO FIX IT TOO
; BELOW IS FIX (TO LABEL NOTINI) SO THAT IF ^C DURING MBASIC FOO, WONT EXIT TO SYSTEM
  LD HL,(CURLIN)        ;GET LINE NUMBER
  INC HL                ;SEE IF IN INITIALIZATION
  LD A,H
  AND L
  INC A
  JR NZ,NOTINI          ;NO
  LD (CURLIN),HL        ;SAVE DIRECT LINE NUMBER
NOTINI:
  CALL RDBYT            ;READ THE FIRST CHARACTER
  JP C,PROMPT           ;ALL DONE IF NOTHING IN FILE
  CP $FE                ;IS THIS A PROTECTED FILE?
  JR NZ,NTPROL          ;NO
  LD (PROFLG),A         ;SET PROTECTED FILE
  JR BINLOD             ;DO BINARY LOAD

NTPROL:
  INC A                 ;IS IT A BINARY FILE?
  JP NZ,MAINGO          ;NO, SINCE PTRFIL IS NON-ZERO
					;INCHR WILL USE INDSKC INSTEAD OF POLLING THE TERMINAL
					;WHEN EOF IS HIT PTRFIL WILL BE RESTORED 
					;AND LSTFRE WILL BE USED AS A FLAG
					;TO INDICATE WHETHER TO RUN THE LOADED PROGRAM


;
; TIME FOR A BINARY LOAD.
; AFTER THE LOAD, THE FILE IS LINKED TOGETHER
; LSTFRE IS USED AS A FLAG WHETHER TO RUN OR NOT
;
BINLOD:
  LD HL,(TXTTAB)          ;GET PLACE TO START STORING INTO

LPBLDR:
  EX DE,HL                ;SEE IF THERE IS ROOM TO SPARE
  LD HL,(FRETOP)
  LD BC,65536-86
  ADD HL,BC
  CALL DCOMPR
  EX DE,HL
  JR C,LOAD_OM_ERR        ;ERROR AND WIPE OUT PARTIAL GARBAGE
				;UNLINKED!! NO ZEROES AT THE END!!
  CALL INDSKB             ;READ THE A DATA BYTE
				;THIS IS SEMI-WEAK SINCE MEMORY
				;IS LEFT IN A BAD BAD STATE
				;IF AN I/O ERROR OCCURS
  LD (HL),A               ;STORE BYTE
  INC HL                  ;INCRMENT POINTER
  JR NC,LPBLDR            ;READ THE NEXT CHAR

  LD (VARTAB),HL          ;SAVE END TEMP FOR DECODING
  LD A,(PROFLG)           ;IS THIS A PROTECTED FILE?
  OR A                    ;SET CC'S
  CALL NZ,PDECOD          ;TRANSLATE TO GOOD STUFF
  CALL LINKER             ;FIX THE LINKS
  INC HL                  ;WHEN LINKER RETURNS, [H,L]
  INC HL                  ;POINTS TO DOUBLE ZERO
  LD (VARTAB),HL          ;UPDATE [VARTAB]
  LD HL,MAXFIL            ;ONLY CLOSE FILE ZER0
  LD A,(HL)
  LD (MAXFILSV),A         ;LSTFRE+1
  LD (HL),$00
  CALL RUN_FST            ;SETUP ARYTAB, STREND
  LD A,(MAXFILSV)         ;(LSTFRE+1), RESTORE NUMBER OF FILES
  LD (MAXFIL),A           ; HIGHEST FILE NUMBER ALLOWED
  LD A,(CHNFLG)           ;CHAIN IN PROGRESS
  OR A                    ;TEST
  JP NZ,CHNRET            ;YES, GO BACK TO CHAIN CODE
  LD A,(AUTORUN)          ;RUN OR NOT?
  OR A
  JP Z,READY
  JP NEWSTT

; This entry point is used by the routines at READY, __MERGE and L4D05.
; a.k.a. PRGFIN
LOAD_END:
  CALL FINPRT             ;ZERO PTRFIL
  CALL CPM_CLSFIL         ;CLOSE FILE ZERO
  JP GTMPRT               ;Restore code string address      ; REFETCH TEXT POINTER

; Routine at 16680
;
; Used by the routine at __LOAD.
; a.k.a. OUTLOD, ERROR AND WIPE OUT PARTIAL GARBAGE
LOAD_OM_ERR:
  CALL CLRPTR
  JP OM_ERR

; 'MERGE' BASIC command
__MERGE:
  POP BC                  ;ELIMINATE NEWSTT RETURN
  CALL PRGFLI             ;READ THE NAME AND DISK
  DEC HL                  ;MUST END THERE
  CALL CHRGTB
  JR Z,OKGETM             ;READ THE FILE
  CALL LOAD_END           ;CLOSE OUT TIME
  JP SN_ERR               ;AND "SYNTAX ERROR"

; This entry point is used by the routine at CAYSTR.
OKGETM:
  XOR A                   ;NO RUN OPTION WITH "MERGE"
  LD (AUTORUN),A          ;SET UP THE FLAG
  CALL RDBYT              ;READ FROM [PTRFIL] FILE
  JP C,PROMPT             ;GO BACK IF EOF
  INC A                   ;IS IT A BINARY FILE??
  JP Z,FMODE_ERR          ;BINARY IS WRONG FILE MODE
  INC A
  JP Z,FMODE_ERR
; This entry point is used by the routine at __LOAD.
MAINGO:
  LD HL,(PTRFIL)          ;GET FILE POINTER
  LD BC,$0028             ; (NMLOFC) POINT TO NUMBER OF CHARS IN BUFFER
  ADD HL,BC               ;BY ADDING OFFSET
  INC (HL)                ;BACK UP FILE BY INCREMENTING COUNT
  JP PROMPT

;
; DISPATCH FOR DIRECT STATEMENT
; MAKE SURE WE'RE NOT READING A FILE IN
;
; This entry point is used by the routine at PROMPT.
DIRDO:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L                    ;IS PTRFIL ZERO SO NOT FILE READING?
  LD DE,$0042             ;Err $42 - (DS_ERR) "Direct statement in file"
  JP NZ,ERROR             ;NOTE: LXI D, IS USED TO MAKE SOURCE CONVERSIONS EASIER
  POP HL                  ;GET BACK POINTER AT BUFMIN
  JP EXEC                 ;EXECUTE DIRECT STATEMENT


;
; SAVE COMMAND -- ASCII OR BINARY
;
__SAVE:

IF TAPE
  CP '!'            ; New Syntax.  SAVE! replaces CSAVE, we ran out of space for TOKEN codes !
  JP Z,__CSAVE
ENDIF

  LD D,$02                ;(MD.SQO) ELIMINATE EARLIER VERSION AND CREATE EMPTY FILE
  CALL FILE_OPENOUT       ;READ FILE NAME AND DISK NUMBER AND LOOK IT UP
  DEC HL
  CALL CHRGTB             ;END OF STATEMENT?
  JR Z,BINSAV             ;BINARY SAVE!!
  CALL SYNCHR             
  DEFM ","                ;ONLY OPTION IS ",A"
  CP 'P'                  ;PROTECTED SAVE?
  JP Z,PROSAV             ;DO IT
  CALL SYNCHR
  DEFM "A"                ;FOR ASCII SAVE
  JP __LIST               ;USE THE LIST CODE TO DO THE OUTPUT
                          ;CONTROL-CS ARE NOT ALLOWED AND AT THE END PTRFIL IS ZEROED

BINSAV:
  CALL SCCPTR             ;GET RID OF POINTERS BEFORE SAVING
  CALL PROCHK             ;DONT ALLOW BINARY SAVES OF PROTECTED PROGRAMS
  LD A,$FF                ;ALWAYS START WITH 255
; This entry point is used by the routine at __GET.
BINPSV:
  CALL FILOU3             ;SEND TO FILE
  LD DE,(VARTAB)          ;GET STOP POINT
  LD HL,(TXTTAB)          ;GET START POINT
BSAVLP:
  CALL DCOMPR             ;REACHED THE END?
  JP Z,LOAD_END           ;REGET TEXT POINTER AND CLOSE FILE 0
  LD A,(HL)               ;GET LINE DATA
  INC HL                  ;POINT AT NEXT DATA
  PUSH DE                 ;SAVE LIMIT
  CALL FILOU3             ;SEND CHAR TO FILE
  POP DE                  ;RESTORE LIMIT
  JR BSAVLP               ;CONTINUE WITH LINE DATA

; 'CLOSE' BASIC command
;
; Used by the routine at RETRTS.
;
; CLOSE[[#]<file number>[,[#]<file number ••• >]]
;
__CLOSE:
  LD BC,CPM_CLSFIL        ;SERVICE ROUTINE ADDRESS
  LD A,(MAXFIL)           ;HIGHEST POSSIBLE ARGUMENT, WHICH MEANS DO ALL POSSIBLE
  JR NZ,RETRTS_0          ;NOT END OF STATEMENT, SO SCAN ARGUMENTS
  PUSH HL                 ;SAVE THE TEXT POINTER
; This entry point is used by the routine at RETALL.
__CLOSE_0:
  PUSH BC                 ;SAVE ROUTINE ADDRESS
  PUSH AF                 ;SAVE CURRENT VALUE
  LD DE,RETALL            ;RETURN ADDRESS
  PUSH DE                 ;SAVE IT TO COME BACK WITH
  PUSH BC                 ;DISPATCH TO SERVICE ROUTINE
  RET

; Routine at 16829
RETALL:
  POP AF                  ;GET BACK OLD ARGUMENT
  POP BC                  ;GET BACK SERVICE ROUTINE ADDRESS
  DEC A                   ;DECREMENT ARGUMENT
  JP P,__CLOSE_0          ;LOOP ON MORE VALUES
  POP HL                  ;GET BACK THE TEXT POINTER
  RET

; Routine at 16837
RETRTS:
  POP BC                  ;GET BACK SERVICE ROUTINE ADDRESS
  POP HL                  ;GET BACK THE TEXT POINTER
  LD A,(HL)               ;SEE IF MORE ARGUMENTS
  CP ','                  ;DELIMITED BY COMMA
  RET NZ
  CALL CHRGTB             ;READ FIRST CHARACTER OF FORMULA
; This entry point is used by the routine at __CLOSE.
RETRTS_0:
  PUSH BC                 ;SAVE THE SERVICE ROUTINE ADDRESS
  LD A,(HL)               ;GET POSSBLE "#"
  CP '#'                  ;IS IT
  CALL Z,CHRGTB           ;SKIP IT, ITS OPTIONAL
  CALL GETINT             ;READ THE ARGUMENT
  EX (SP),HL              ;SAVE THE TEXT POINTER ON THE STACK <> AND SET [H,L]=SERVICE ADDRESS
  PUSH HL                 ;SAVE THE SERVICE ADDRESS
  LD DE,RETRTS            ;PUT A RETURN ADDRESS ON THE STACK
  PUSH DE
  JP (HL)                 ;DISPATCH TO DO THE FUNCTION


; This entry point is used by the routines at __SYSTEM, __RESET, NODSKS, __NEW
; and __END.
CLSALL:
  PUSH DE
  PUSH BC                 ;SAVE [B,C] FOR STKINI
  XOR A                   ;MAKE IT CLOSE ALL DISKS
  CALL __CLOSE
  POP BC
  POP DE                  ;GET BACK [D,E]
  XOR A                   ;RETURN WITH [A]=0 AND Z ON
  RET

; 'FIELD' BASIC command: allocate space in the random buffer for the variables
; that will be written to the random file
__FIELD:
  CALL FILSCN		; Check we have the '#' channel specifier and GET DATA BLOCK POINTER IN [B,C]
  JP Z,BN_ERR             ;"BAD FILE NUMBER" IF FILE NOT OPEN
  SUB $03                 ;MAKE SURE ITS A RANDOM FILE
  JP NZ,FMODE_ERR         ;IF NOT, "BAD FILE MODE"
  EX DE,HL                ;SAVE TEXT POINTER
  LD HL,$00A9             ;(FD.SIZ) POINT TO RECORD SIZE
  ADD HL,BC
  LD A,(HL)               ;GET IT
  INC HL
  LD H,(HL)
  LD L,A
  LD (INTFLG),HL          ; (TEMPA), STORE MAX ALLOWED
  LD HL,$0000             ;ZERO MAX # OF CHARS
  LD (RECORD),HL
  LD A,H                  ;MAKE [A]=0
  EX DE,HL                ;GET BACK TEXT POINTER
  LD DE,$00B2             ;FD.DAT: POINT TO 5.0 FIELD BUFFER
__FIELD_NEXT:
  EX DE,HL                ;SAVE TEXT POINTER IN [D,E]
  ADD HL,BC               ;ADD ON DATA POINTER SO [H,L] NOW POINTS AT THE START OF THE DATA
  LD B,A                  ;SETUP COUNT OF CHARACTERS PAST BY IN DATA AREA, SO TOTAL IS NEVER GREATER THAN 128
  EX DE,HL                ;TEXT POINTER BACK INTO [H,L] <> [D,E]=POINTER INTO DATA AREA
  LD A,(HL)               ;MORE "AS"S TO SCAN?
  CP ','                  ;COMMA STARTS THE CLAUSE
  RET NZ                  ;BACK TO NEWSTT IF NOT
  PUSH DE                 ;SAVE THE POINTER INTO THE DATA BLOCK
  PUSH BC                 ;SAVE [B]=NUMBER OF CHARACTERS ALLOCATED
  CALL FNDNUM             ;READ NUMBER INTO [A] FROM TEXT
  PUSH AF                 ;SAVE THIS NUMBER
  CALL SYNCHR
  DEFM "A"                ;SCAN THE "AS"
  CALL SYNCHR
  DEFM "S"
  CALL GETVAR             ;GET A POINTER AT THE STRING DESCRIPTOR
  CALL TSTSTR             ;INTO [D,E]
  POP AF                  ;GET THE NUMBER OF CHARACTERS
  POP BC                  ;GET THE NUMBER ALREADY USED
  EX (SP),HL              ;SAVE THE TEXT POINTER AND [H,L]=POINTER INTO DATA BLOCK
  LD C,A                  ;SAVE # OF CHARACTERS IN [C]
  PUSH DE                 ;SAVE [D,E]
  PUSH HL                 ;SAVE [H,L]
  LD HL,(RECORD)          ;GET TOTAL SO FAR
  LD B,$00                ;ACCUMULATE COUNT
  ADD HL,BC
  LD (RECORD),HL          ;SAVE TOTAL AGAIN
  EX DE,HL                ;TOTAL TO [D,E]
  LD HL,(INTFLG)          ;GET MAX ALLOWED
  CALL DCOMPR             ;IN RANGE?
  JP C,FO_ERR             ;NO, GIVE ERROR
  POP HL                  ;RESTORE [H,L]
  POP DE                  ;RESTORE [D,E]
  EX DE,HL                ;[H,L] POINT AT STRING DESCRIPTOR
  LD (HL),C               ;STORE THE LENGTH
  INC HL
  LD (HL),E               ;STORE THE POINTER INTO THE DATA BLOCK
  INC HL
  LD (HL),D
  POP HL                  ;GET BACK THE TEXT POINTER
  JR __FIELD_NEXT

;LSET/RSET stringvar = stringexp
;
; If stringvar points to an I/O buffer, use the string size to
; justify string. If stringvar is a literal, make new var with length
; of literal. If stringvar points to string space, use it. If the
; length of the variable is zero, return the null string. If a copy
; must be created, and stringexp is a temporary, use this space over
; unless length stringvar greater than stringexp.

; 'RSET' BASIC command
__RSET:
  DEFB $F6                ; "OR n" to Mask 'SCF'       ; ORI <STC>

; 'LSET' BASIC function
__LSET:
  SCF                    ;Set carry if lset
  PUSH AF                ;Save LSET/RSET flag
  CALL GETVAR            ;Get pointer to stringvar
  CALL TSTSTR            ;Must be a string variable
  PUSH DE                ;Save pointer to descriptor
  CALL FRMEQL            ;EAT "=" AND EVALUATE STRINGEXP
  POP BC                 ; [B,C] = ptr to descr.
  EX (SP),HL             ;Text ptr on bottom of stack
  PUSH HL                ;LSET/RSET flag next
  PUSH BC                ;Put descr. ptr back on
  CALL GETSTR            ;Error if not string, free temp.
  LD B,(HL)              ;Get length of stringexp
  EX (SP),HL             ; [H,L] = descr. of var,save othr
  LD A,(HL)              ;Get length of stringvar
  LD C,A                 ;Save in [C]
  PUSH BC                ;Save lengths of both
  PUSH HL                ;Save descriptor pointer
  PUSH AF                ;PSW zero if was temp.
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)              ;Get ptr to stringvar text
  OR A                   ;stringvar null?
  JR Z,RETCUR            ;Yes, don't change
  LD HL,(TXTTAB)
  CALL DCOMPR            ;stringvar in disk buffer?
  JR NC,OLDSTR           ;Yes, use it
  LD HL,(VARTAB)
  CALL DCOMPR            ;stringvar in program(literal)?
  JR C,OLDSTR            ;No, in string space so use it

; Need to make new string for result since stringvar points to a literal.
; If stringexp was a temporary, it has been freed. If the length of
; stringexp is greater than or equal to the length of stringvar, GETSPA
; can be called and no garbage collection can occur so temp. can be reused.
; If stringvar is greater, must get a temp. to point to stringexp if it
; was a temp. , then call GETSPA which in this case can garbage collect.

  LD E,C
  LD D,$00               ;# BYTES TO ALLOCATE FOR RESULT
  LD HL,(STREND)
  ADD HL,DE
  EX DE,HL
  LD HL,(FRETOP)
  CALL DCOMPR            ;WILL GETSPA GARBAGE COLLECT?
  JR C,MAKDSC            ;Yes, better have stringexp temp.
  POP AF
MADESC:
  LD A,C                 ;Get length of stringvar
  CALL TESTR             ;Get space for result
  POP HL                 ;Get stringvar descr.
  POP BC                 ;Get lengths off stack
  EX (SP),HL             ;Get what we wanted, stringexp descr.
  PUSH DE
  PUSH BC
  CALL GETSTR            ;Free temp if any
  POP BC
  POP DE
  EX (SP),HL
  PUSH BC                ;Restore stack to previous state
  PUSH HL
  INC HL
  PUSH AF
  LD (HL),E
  INC HL
  LD (HL),D              ;Set pointer to stringvar copy
OLDSTR:
  POP AF
  POP HL                 ;Get stringvar descr.
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)              ;Get pointer to text area
  POP BC                 ;Get lengths off stack
  POP HL                 ;Get pointer to stringexp descr.
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)              ;Get ptr to stringexp text
  LD L,A                 ;Put pointer in [H,L]
  LD A,C                 ;Get length of field(stringvar)
  CP B
  JR NC,FILDOK           ;Jump if field large enough for result
  LD B,A                 ;Save # of bytes to copy
FILDOK:
  SUB B
  LD C,A                 ;[C] = # blanks to fill
  POP AF                 ;Get LSET/RSET flag
  CALL NC,BLKFIL         ;Fill leading if RSET
  INC B                  ;In case zero
COPLOP:
  DEC B                  ;Decr. # to copy
  JR Z,LRSTDN            ;Done when all copied
  LD A,(HL)              ;Get byte from stringexp
  LD (DE),A              ;Copy to stringvar
  INC HL
  INC DE
  JR COPLOP

RETCUR:
  POP BC
  POP BC
  POP BC
  POP BC
  POP BC                 ;Get garb off stack
LRSTDN:
  CALL C,BLKFIL          ;Fill trailing if LSET
  POP HL                 ;Restore text pointer
  RET

BLKFIL:
  LD A,' '               ;Fill with spaces
  INC C                  ;In case zero
BLKFL1:
  DEC C                  ;Decr. # to fill
  RET Z                  ;Return when done
  LD (DE),A              ;Store space
  INC DE
  JR BLKFL1

; If stringexp was a temporary, create a new temporary to point to
; stringexp since old one was freed. This must be done since GETSPA
; will be called and garbage collection might occur. If stringexp is
; not a temporary, return.

MAKDSC:
  POP AF                 ;Get temp flag
  POP HL
  POP BC
  EX (SP),HL             ;Dig down to stringexp descr.
  EX DE,HL               ;FRETMS wants [D,E]
  JR NZ,MAKDS1           ;Not a temp, don't reallocate
  PUSH BC
  LD A,B
  CALL MKTMST            ;Make a temp point to stringexp
  CALL TSTOPL            ;Get a temp to point to it
  POP BC
MAKDS1:
  EX (SP),HL
  PUSH BC
  PUSH HL                ;Restore stack to previous state
  JR MADESC

;
; a.k.a. FIXINP:  Program I/O -- Fixed Length INPUT
;
; Format:
;		stringvar = INPUT$(#bytes[,[#] file#])
; If no file # is given, characters will be read from the user's
; terminal. No echoing will be done and no editing will be allowed
; (i.e. rubout,@,_,^U are just input as characters).

; Routine at 17145
;
; Used by the routine at NTVARP.
FN_INPUT:
  CALL CHRGTB
  CALL SYNCHR
  DEFM "$"                ;STRING FUNCTION
  CALL SYNCHR
  DEFM "("
  PUSH HL                 ;Preserve PTRFIL across INPUT$ so
  LD HL,(PTRFIL)          ;cases like PRINT #2,INPUT$(3,#1)
  LD DE,$0000             ;will work properly.
  LD (PTRFIL),DE          ;(Clear PTRFIL in case no file number is specified.)
  EX (SP),HL
  CALL GETINT             ;Get # of bytes to read
  PUSH DE                 ;Save # of bytes to read
  LD A,(HL)
  CP ','                  ;Read from disk file?
  JR NZ,REDTTY            ;No, from user's terminal
  CALL CHRGTB
  CALL FILSCN             ; Check we have the '#' channel specifier and put the associated file buffer in BC
  CP $02                  ;SEQUENTIAL OUTPUT FILE?
  JP Z,FMODE_ERR          ;THEN BAD FILE MODE
  CALL FILSET             ;SET UP PTRFIL
  XOR A                   ;SET ZERO FOR FLAG
REDTTY:
  PUSH AF                 ;NON ZERO SET IF TERMINAL I/O             ; PUSH PSW
  CALL SYNCHR
  DEFM ")"                ;Must have paren
  POP AF                  ;Get flag off stack
  EX (SP),HL              ;Save text ptr, [L]=# to read
  PUSH AF                 ;Save flag
  LD A,L
  OR A                    ;Read no characters?
  JP Z,FC_ERR             ;Yes, error
  PUSH HL                 ;Save #
  CALL MKTMST             ;Get space for string
  EX DE,HL
  POP BC                  ;[C] = # to read
FIXLOP:
  POP AF                                                            ; POP PSW
  PUSH AF                 ;NON-ZERO set if should read from TTY     ; PUSH PSW
  JR Z,DSKCHR             ;Read from disk file
  CALL CHARCG             ;GET CHAR IF ONE
  JR NZ,CHARCW            ;WAS ONE
  CALL INCHRI             ;Read a char from terminal
CHARCW:
;Note : will check flag on interrupt ^c
  CP $03                  ;Control-C?
  JR Z,INTCTC             ;Yes, stop
PUTCHR:
  LD (HL),A               ;Put char into string
  INC HL
  DEC C                   ;Read enough yet?
  JR NZ,FIXLOP            ;No, read more
  POP AF                  ;Get flag off stack
  POP BC
  POP HL
  LD (PTRFIL),HL
  PUSH BC
  JP TSTOPL               ;STOP PROGRAM

INTCTC:
  LD HL,(SAVSTK)          ;GET SAVED STACK POINTER
  LD SP,HL                ;SET [H,L] TO IT
  JP ENDCON               ;STOP PROGRAM

DSKCHR:
  CALL RDBYT              ;Get char from file
  JP C,EF_ERR             ;If carry, read past EOF
  JR PUTCHR               ;Put char in string






;
;
;			Revision history
;			-------- -------
;
;11/7/77         FIXED EOF() CODE TO USE ORNOFS INSTEAD OF NMLOFS, PGA
;12/2/77  (4.41) FIXED RANDOM ACCESS TO CLOSE EXTENTS PGA
;12/17/77        ADDITIONAL CODE TO SUPPORT ONTEL DOS BASIC, P.ZILBER
;12/29/77 (4.42) FIXED BUG WHERE GET, PUT W/O REC NOT INC CURLOC, PGA
;1/5/78   (4.43) FIXED ANOTHER RANDOM BUG, LINE PRINTER ^C PROB. PGA
;7/23/79         Add Beehive interace and cleanup conditionals
;
;
;
;File information:
;
;        1	Mode of the file
;F.BLK1	(n)	1st block of space, usually FCB
;      ( CPM: 33, ONTEL: 42 MOSTEK: 47 ). Zero for others
;LOCOFS  2	CURLOC, # of sectors read or writeen for sequential.
;		For random files, it is the last record # +1.
;ORNOFS	 1/2	Seq Input: 	# of bytes in sector when read.
;		Seq Output:	# bytes in output sector( # written )
;		Random:		Set to DATPSC by PUT and GET, sometimes
;				zeroed by OUTSQ2 setup for DSKOUT code.
;NMLOFS	 1/2	Seq Input:	# bytes left in input buffer
;		Seq Output:	Position of imaginary print head
;F.BLK2	(n)	2nd block of space( 6 byte chain links for ONTEL,
;		160 bytes for DMC, 10 bytes for BEEHIV )
;DATOFS	(n)	Sector buffer, Length = DATPSC
;
;Extra information for 5.0 version only:
;
;FD.SIZ	 2	Variable length record size( default = 128 )
;FD.PHY	 2	Current physical record #
;FD.LOG	 2	Current logical record #
;FD.CHG	 1	Future flag for across record PRINTs, etc.
;FD.OPS	 2	Output print position for PRINT, INPUT, WRITE
;FD.DAT	(n)	Data buffer for FIELD, size is (FD.SIZ). FD.MAX is max.
;

;;File modes
;MD.000	=	0			;THE MODE NUMBER FOR NO FILE, INTERNAL USE ONLY AS AN ESCAPE FROM OPEN
;MD.RND	=	3			;THE MODE NUMBER FOR RANDOM FILES
;MD.SQI	=	1			;THE MODE NUMBER FOR SEQUENTIAL INPUT FILES NEVER WRITTEN INTO A FILE
;MD.SQO	=	2			;THE MODE FOR SEQUENTIAL OUTPUT FILES AND PROGRAM FILES




; 'EOF' BASIC function
__EOF:
  CALL FILFRM             ;CONVERT ARGUMENT TO FILE NUMBER AND SET [B,C] TO POINT TO FILE DATA BLOCK
  JP Z,BN_ERR             ;BAD FILE NUMBER - NOT FOUND !!!

  CP $02                  ;IS IT A SEQUENTIAL OUTPUT FILE?
  JP Z,FMODE_ERR          ;THEN GIVE BAD FILE MODE
ORNCHK:
  LD HL,$0027             ; (0+ORNOFS) SEE IF ANY BYTES ARRIVED IN THIS BUFFER
  ADD HL,BC
  LD A,(HL)               ;ZERO IFF IT IS END OF FILE
  OR A                    ;SET CC'S
  JR Z,WASEOF             ;NO BYTES LEFT
  LD A,(BC)               ;** 5.11 **  GET FILE MODE
  CP $03                  ;IS IT A RANDOM FILE?
  JR Z,WASEOF             ;** 5.11 **  (A) .NE. 0 - not EOF
  INC HL                  ;POINT TO NUMBER LEFT IN BUFFER
  LD A,(HL)               ;GET NUMBER OF BYTES IN BUFFER
  OR A                    ;NON-ZERO?
  JR NZ,CHKCTZ            ;THEN CHECK FOR CONTROL-Z
  PUSH BC                 ;SAVE [B,C]
  LD H,B                  ;GET FCB POINTER IN [B,C]
  LD L,C                  
  CALL READIN             ;READ ANOTHER BUFFER
  POP BC                  ;RESTORE [B,C]
  JR ORNCHK               ;HAVE NEW BUFFER, USE PREVIOUS PROCEDURE
CHKCTZ:
  LD A,DATPSC             ;GET # OF BYTES IN FULL BUFFER
  SUB (HL)                ;SUBTRACT LEFT
  LD C,A                  ;PUT IN [B,C] FOR DAD
  LD B,0
  ADD HL,BC               ;ADD TO ORNOFS OFFSET
  INC HL                  ;ADD ONE TO POINT TO BYTE IN BUFFER
  LD A,(HL)               ;GET BYTE
  SUB $1A                 ;IF CONTROL-Z, EOF (CONTROL-\ IS FS)
WASEOF:
  SUB $01
  SBC A,A
  JP CONIA                ;CONVERT TO AN INTEGER AND RETURN

; This entry point is used by the routine at __LOF.
;
; [B,C] POINTS AT FILE DATA BLOCK
;
OUTSEQ:
  LD D,B                  ;PUT FILE BLOCK OFFSET IN [D,E]
  LD E,C
  INC DE                  ;POINT TO FCB
; This entry point is used by the routine at CPM_CLSFIL.
OUTSEQ_0:
  LD HL,$0027             ;(0+ORNOFS) POINT TO NUMBER IN BUFFER
  ADD HL,BC               ;ADD START OF FILE DATA BLOCK
  PUSH BC                 ;SAVE FILE DATA POINTER
  XOR A                   
  LD (HL),A               ;ZERO OUT NUMBER IN DATA BUFFER

;	OUTPUT NEXT RECORD IN FILE
;
;	(A) = 0
;	(HL) points to NMLOFS-1
;	(DE) points to File Data Block + 1 ( FCB if SPC2ND=0)
;	(BC) points to File Data Block

  CALL SETBUF             ;SET BUFFER ADDRESS

IF CPMV1
  LD A,(CPMWRT)		  ; BDOS FN code
ELSE
  LD A,$22		;Write record FN
ENDIF

  CALL ACCFIL             ;Access file
  CP $FF                   
  JP Z,FL_ERR             ;Too many files - 5.11
  DEC A                   ;ERROR EXTENDING FILE? (1)
  JP Z,DISK_ERR           ;YES
  DEC A                   ;DISK FULL? (2)
  JR NZ,OUTSOK            ;NO
  POP DE                  ;GET BACK FILE POINTER
  XOR A                   ;GET ZERO
  LD (DE),A               ;MARK AS CLOSED
  LD C,$10                ;CLOSE IT (BDOS function 16 - Close file)
  INC DE                  ;POINT TO FCB
  CALL CPMENT             ;CALL CP/M
  JP DSK_FULL_ERR         ;GIVE "DISK FULL" ERROR MESSAGE

OUTSOK:
  INC A                   ;TOO MANY FILES?
  JP Z,FL_ERR             ;YES
  POP BC                  ;GET POINTER AT CURLOC
  LD HL,$0025             ;BY ADDING OFFSET TO FILE POINTER
  ADD HL,BC
  LD E,(HL)               ;INCREMENT IT
  INC HL
  LD D,(HL)
  INC DE
  LD (HL),D
  DEC HL
  LD (HL),E
  RET


;>!!!

; CLOSE A FILE
;
; FILE NUMBER IS IN [A]
; ZERO ALL INFORMATION. IF FILE IS OPEN, RAISE ITS DISKS HEAD
; IF FILE IS SEQUENTIAL OUTPUT, SEND FINAL SECTOR OF DATA
;
; Used by the routine at __LOAD.
CPM_CLSFIL:
  CALL FILIDX             ;GET POINTER TO DATA
  JR Z,NTOPNC             ;RETURN IF NOT OPEN
                          ;SAVE FILE #
  PUSH BC                 ;SAVE FILE POINTER
  LD A,(BC)               ;GET FILE MODE
  LD D,B                  ;PUT FILE BLOCK OFFSET IN [D,E]
  LD E,C
  INC DE                  ;POINT TO FCB
  PUSH DE                 ;SAVE [D,E] FOR LATER
  CP $02                  ;SEQENTIAL OUTPUT?
  JR NZ,NOFORC            ;NO NEED TO FORCE PARTIAL OUTPUT BUFFER
  LD HL,CLSFL1            ;RETURN HERE
  PUSH HL                 ;SAVE ON STACK
  PUSH HL                 ;NEED EXTRA STACK ENTRY
  LD H,B                  ;GET FILE POINTER
  LD L,C                  ;INTO [H,L]
  LD A,$1A                ;PUT OUT CONTROL-Z (OR FS)
  JR FILOU4               ;JUMP INTO CHAR OUTPUT CODE

CLSFL1:
  LD HL,$0027             ; (0+ORNOFS) CHARS IN BUFFER
  ADD HL,BC               ;TEST
  LD A,(HL)               ;TEST ORNOFS
  OR A                    
  CALL NZ,OUTSEQ_0        ;FORCE OUT BUFFER
NOFORC:
  POP DE                  ;GET BACK FCB POINTER

;	CLOSE FILE
;
;	(DE) points to FCB
;	((SP)) points to File Data Block

  CALL SETBUF
  LD C,$10                ;THE CLOSE (BDOS function 16 - Close file)
  CALL CPMENT             ;CALL CPM
  
  ;*****	NO CHECK FOR ERRORS
  
  POP BC                  ;RESTORE FILE POINTER
NTOPNC:
  LD D,$29                ; (DATOFS) NUMBER OF BYTES TO ZERO
  XOR A
MORCZR:
  LD (BC),A
  INC BC
  DEC D
  JR NZ,MORCZR
  RET


; LOC (CURRENT LOCATION) AND LOF (LAST RECORD NUMBER)

; 'LOC' BASIC function
__LOC:
  CALL FILFRM            ;CONVERT ARGUMENT AND POINT AT DATA BLOCK
  JP Z,BN_ERR            ;IF NOT OPEN, "BAD FILE NUMBER"
  CP $03                 ;Random mode?
  LD HL,$0026            ;0+LOCOFS+1: Assume not
  JR NZ,LOC1             ;No, use CURLOC
  LD HL,$00AE            ;0+FD.LOG+1: POINT AT LOGICAL RECORD NUMBER
LOC1:
  ADD HL,BC
  LD A,(HL)
  DEC HL
  LD L,(HL)
  JP GIVINT

; 'LOF' BASIC function
__LOF:
  CALL FILFRM             ;CONVERT ARGUMENT AND INDEX
  JP Z,BN_ERR             ;"BAD FILE NUMBER" IF NOT OPEN
  LD HL,$0010             ;0+FCB.RC+1: Point to record number
  ADD HL,BC               ;(BC) points to File Data Block
  LD A,(HL)               ;GET RC
  JP PASSA                ;FLOAT IT


; FILOUT -- PUT A CHARACTER IN AN OUTPUT BUFFER AND OUTPUT IF NECESSARY
;
; CALL AT FILOUT WITH [H,L] TO BE SAVED ON THE STACK
; AND THE CHARACTER IN THE HIGH ORDER BYTE BELOW THE [H,L]
; ON THE STACK. THE CURRENT DATA IS OUTPUT IF THERE ARE 128
; CHARACTER STUFFED INTO THE DATA AREA.
; FILOUT IS NORMALLY CALLED FROM OUTDO (OUTCHR)
;

; This entry point is used by the routine at OUTDO.
FILOUT:
  POP HL                 ;GET SAVED [H,L] OFF STACK
  POP AF                 ;GET SAVE CHAR OFF STACK
; This entry point is used by the routine at __MERGE.
FILOU3:
  PUSH HL                 ;SAVE THE [H,L]
  PUSH AF                 ;SAVE THE CHARACTER AGAIN
  LD HL,(PTRFIL)          ;GET THE POINTER TO THE FILE
  LD A,(HL)               ;WHAT IS THE MODE?
  CP $01                  ;MUST BE ECHOING OR "EXTRA IGNORED" DURING THE READING OF A FILE
  JP Z,POPAHT             ;SO IGNORE THIS OUTCHR
  CP $03                  ;RANDOM?
  JP Z,FILOFV             ;YES, FINISH UP IN FIVDK.MAC
  POP AF                  ;TAKE THE CHARACTER OFF
; This entry point is used by the routine at CPM_CLSFIL.
FILOU4:
  PUSH DE
  PUSH BC
  LD B,H                  ;SETUP [B,C] FOR OUTSEQ
  LD C,L
  PUSH AF                 ;RE-SAVE OUTPUT CHARACTER
  LD DE,$0027             ;0+ORNOFS: POINT AT THE NUMBER OF CHARACTERS IN THE
  ADD HL,DE               ;BUFFER CURRENTLY
  LD A,(HL)
  CP $80                  ;IS THE BUFFER FULL?
  PUSH HL                 ;SAVE POINTER AT CHARACTER COUNT
  CALL Z,OUTSEQ           ;OUTPUT IF FULL
  POP HL                  ;GET BACK DATA BLOCK POINTER
  INC (HL)                ;INCREMENT THE NUMBER OF CHARACTERS
  LD C,(HL)               ;FETCH FOR OFFSET INTO DATA
  LD B,$00
  INC HL                  ;POINT AT PRINT POSITION
;FILUPP:
  POP AF                  ;GET THE OUTPUT CHARACTER
  PUSH AF                 ;RESAVE FOR OUTPUT
  LD D,(HL)               ;[D]=CURRENT POSITION
  CP $0D                  ;BACK TO ZERO POSITION WITH RETURN?
  LD (HL),B               ;ASSUME RESET TO ZERO SINCE [B]=0
  JR Z,ISCRDS             ;ALL DONE UPDATING POSITION
  ADD A,$E0               ;SET CARRY FOR SPACES AND HIGHER
  LD A,D                  ;[A]=CURRENT POSITION
  ADC A,B                 ;ADD ON CARRY SINCE [B]=0
  LD (HL),A               ;UPDATE THE POSITION IN THE DATA BLOCK
ISCRDS:
  ADD HL,BC
  POP AF                  ;GET THE CHARACTER
  POP BC
  POP DE
  LD (HL),A               ;SAVE IT IN THE DATA AREA
  POP HL                  ;GET BACK SAVED [H,L]
  RET

; This entry point is used by the routine at __GET.
FIVDPT:
  DEC DE                  ;MAP RECORD NUMBER 1=0 LOGICAL
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D               ;SETUP CURLOC AGAIN
  INC HL                  ;POINT TO ORN
  LD (HL),$80             ;SET NUMBER IN THE BUFFER TO DATSPC
  INC HL
  LD (HL),$80
  POP HL                  ;[H,L]=TEXT POINTER
  EX (SP),HL              ;SAVE TEXT POINTER, [H,L]=START OF DATA BLOCK
  LD B,H
  LD C,L

;	RANDOM FILE ACCESS
;
;	(DE) = physical block #
;	(BC) points to File Data Block
;	(HL) points to File Data Block

  PUSH HL                 ;SAVE DATA BLOCK POINTER
IF CPMV1
;---------------------------------------------------------------------------------------
  LD A,(BDOSVER)          ;Get version number
  OR A                    
  JR Z,RNDVR1             ;Version 1.x
;---------------------------------------------------------------------------------------
ENDIF
  LD HL,$0022             ;0+FCB.RN+1: Offset to random record number
  ADD HL,BC
  LD (HL),E               ;Set new random record number
  INC HL
  LD (HL),D
  INC HL
  LD (HL),$00
IF CPMV1
;---------------------------------------------------------------------------------------
  JR RNDDON              ;Finished setting record number

RNDVR1:
  LD HL,$000D            ;POINT TO EXTENT
  ADD HL,BC              ;ADD START OF FILE CONTROL BLOCK
  LD A,E                 ;GET LOW BYTE OF OFFSET
  RLA                    ;GET HIGH BIT IN CARRY
  LD A,D                 ;GET HIGH BYTE
  RLA                    ;ROTATE IN HIGH BYTE OF LOW PART
  LD D,(HL)              ;PUT ORIGINAL EXTENT IN [D]
  CP D                   ;ARE NEW AND OLD EXTENT THE SAME?
  JR Z,SAMEXT            ;SAME EXTENT, DONT RE-OPEN
  PUSH DE                ;SAVE RECORD NUMBER
  PUSH AF                ;SAVE NEW EXTENT
  PUSH HL                ;SAVE POINTER TO EXTENT
  PUSH BC                ;SAVE FILE POINTER
  LD DE,DIRTMP           ;READ DIRECTORY IN HERE FOR OPEN
  LD C,$1A               ;SET CPM BUFFER ADDRESS ; BDOS function 26 - Set DMA address
  CALL CPMENT            ;CALL CP/M
  POP DE                 ;GET CPM FCB POINTER
  PUSH DE                ;SAVE BACK
  INC DE                 ;POINT TO FCB
  LD C,$10               ;CLOSE PREVIOUS EXTENT (?!) (BDOS function 16 - Close file)
  CALL CPMENT            ;CALL CP/M
  POP DE                 ;GET BACK FCB POINTER
  POP HL                 ;RESTORE POINTER TO EXTENT FIELD
  POP AF                 ;GET BACK NEW EXTENT
  LD (HL),A              ;STORE NEW EXTENT
  PUSH DE
  INC DE                 ;POINT TO FCB
  LD C,$0F               ;OPEN NEW EXTENT (BDOS function 15 - Open file)
  PUSH DE                ;SAVE EXTENT POINTER
  CALL CPMENT            ;BY CALLING CP/M
  POP DE                 ;RESTORE FCB POINTER
  INC A                  ;DOES EXTENT EXIST?
  JR NZ,RNDOK            ;YES
  LD C,$16               ;MAKE THE EXTENT EXIST (BDOS function 22 - create file)
  CALL CPMENT            ;CALL CP/M
  INC A                  ;ROOM IN DIRECTORY?
  JP Z,FL_ERR            ;NO
  
RNDOK:
  POP BC                 ;RESTORE [B,C]
  POP DE                 ;RESTORE RECORD NUMBER
SAMEXT:
  LD HL,$0021            ;0+FCB.NR+1: NEXT RECORD FIELD
  ADD HL,BC              ;POINT TO IT
  LD A,E                 ;GET LOW 7 BITS OF RECORD #
  AND $7F                
  LD (HL),A              ;SET RECORD #

RNDDON:                  ;[H,L] POINT AT FILE DATA BLOCK
;---------------------------------------------------------------------------------------
ENDIF
  POP HL

;	(BC) points to File Data Block
;	(HL) points to File Data Block

  LD A,(MAXTRK)          ;GET FLAG FOR "PUT" OR "GET"
  OR A                   
  JR NZ,PUTFIN           ;DO THE PUTTING
  CALL READIN            ;PERFORM THE GET
  POP HL                 ;GET THE TEXT POINTER
  RET

PUTFIN:
  LD HL,$0021            ; 0+FCB.NR+1: LOOK AT RECORD #
  ADD HL,BC              ;[H,L] POINTS TO IT
  LD A,(HL)              ;GET IT
  CP $7F                 ;LAST RECORD IN EXTENT?
  PUSH AF                ;SAVE INDICATOR
  LD DE,DIRTMP           ;DIRTMP: SAVE HERE
  LD HL,$0029            ;DATOFS: POINT TO DATA
  ADD HL,BC
  PUSH DE                ;SAVE DIRTMP POINTER
  PUSH HL                ;SAVE DATA POINTER
  CALL Z,BUFMOV          ;NOT LAST EXTENT
  CALL OUTSEQ            ;OUTPUT THE DATA
  POP DE                 ;RESTORE DATA POINTER
  POP HL                 ;RESTORE POINTER TO DIRTMP
  POP AF                 ;RESTORE INDICATOR
  CALL Z,BUFMOV          ;MOVE SECTOR
  POP HL                 ;GET THE TEXT POINTER
  JP FINPRT              ;ZERO PTRFIL

BUFMOV:
  PUSH BC                ;SAVE [B,C]
  LD B,DATPSC            ;# OF BYTES TO MOVE
BUFSLP:                  
  LD A,(HL)              ;GET BYTE FROM BUFFER
  INC HL                 ;BUMP POINTER
  LD (DE),A              ;SAVE IN DIRTMP
  INC DE                 ;BUMP POINTER
  ;DEC B                  
  DJNZ BUFSLP           ;KEEP MOVING BYTES
  POP BC                 ;RESTORE [B,C]
  RET


;
; GET A CHARACTER FROM A SEQUENTIAL FILE IN [PTRFIL]
; ALL REGISTERS EXCEPT [D,E] SMASHED
; Used also to Check stream buffer status before I/O operations
;
;	'C' set if EOF read
;
;
; Used by the routines at RDBYT and __LOAD.
INDSKB:
  PUSH BC                ;SAVE CHAR COUNTER
  PUSH HL                ;SAVE [H,L]
INDSKB_0:
  LD HL,(PTRFIL)         ;GET DATA BLOCK POINTER
  LD A,(HL)
  CP $03                 ;GET FILE MODE
  JP Z,FILIFV            ;MD.RND RANDOM?
  LD BC,$0028            ;DO INPUT
  ADD HL,BC              ;SEE HOW MANY CHARACTERS LEFT
  LD A,(HL)              
  OR A                   ;GET THE NUMBER
  JR Z,FILLSQ          
  DEC HL                 ;MUST GO READ SOME MORE -- IF CAN
  LD A,(HL)              ;POINT AT ORNOFS
  INC HL                 ;GET ORIGINAL NUMBER
  DEC (HL)               ;POINT AT NUMBER LEFT AGAIN
  SUB (HL)               ;DECREMENT THE NUMBER
  LD C,A                 ;SUBTRACT TO GIVE OFFSET
  ADD HL,BC              ;[C]=OFFSET
  LD A,(HL)              
  OR A                   ;GET THE DATA
  POP HL                 ;RESET CARRY FLAG FOR NO EOF
  POP BC                 ;RESTORE [H,L]
  RET

FILLSQ:
  DEC HL                 ;BACK UP POINTER
  LD A,(HL)              ;TO ORNOFS
  OR A                   ;DID WE HIT EOF ON PREVIOUS READ?
  JR Z,INDSKB_2          ;YES
  CALL READ2             ;READ A RECORD
  ; OR A              <-  USED TO BE - WAS IT EOF?
  JR NZ,INDSKB_0         ;RETURN WITH A CHAR (GET A CHAR BY INDSKB)
INDSKB_2:
  SCF                    ;CARRY IS EOF FLAG
  POP HL                 ;RESTORE [H,L]
  POP BC                 ;EOF DETECTED
  LD A,$1A			     ;RETURN WITH EOF: CHAR=CONTROL-Z (OR =FS)
  RET
  
  
; This entry point is used by the routine at __OPEN.
READ2:
  LD HL,(PTRFIL)         ;GET DATA POINTER
; This entry point is used by the routines at __EOF and __LOF.
READIN:
  PUSH DE
  LD D,H                 ;PUT FCB POINTER IN [D,E]
  LD E,L
  INC DE
  LD BC,$0025            ;0+LOCOFS: POINT TO CURLOC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC BC
  DEC HL
  LD (HL),C              ;UPDATE [CURLOC]
  INC HL
  LD (HL),B
  INC HL                 ;POINT TO NUMBER READ
  INC HL                 ;POINT TO NMLOFS
  PUSH HL                ;SAVE [H,L]

; ZERO OUT THE BUFFER IN CASE NOTHING READ
  LD C,DATPSC            ;NUMBER OF BYTES/BUFFER
  
ZRRND:
  INC HL                 ;INCREMENT BUFFER POINTER
  LD (HL),$00            ;ZERO IT
  DEC C                  ;DECREMENT COUNT
  JR NZ,ZRRND            ;KEEP ZEROING


;	READ SPECIFIED RECORD IN FILE
;
;	(DE) points to FCB
;
;	If SW2BYT = 0,
;		(A) = number of bytes read
;	If SW2BYT = 1,
;		(DE) = number of bytes read
;
;	If EOF, return with (A) or (DE) zero and
;		jump to READI2
;
;	Returns 'Z' set if EOF

  CALL SETBUF            ; SET CPM BUFFER ADDRESS


IF CPMV1
  LD A,(CPMREA)          ;Get read code
ELSE
  LD A,$21               ;BDOS function for 'Read record'
ENDIF

  CALL ACCFIL           ;Access file
  OR A                  ;EOF?
  LD A,$00              ;Return 0 if EOF
  JR NZ,READI2          ;Assume EOF if error
  LD A,DATPSC           ;OTHERWISE, HAVE 128 BYTES
READI2:
  POP HL                ;POINT BACK TO # READ
  LD (HL),A             ;STORE NUMBER READ
  DEC HL                ;POINT AT NUMBER ORIGINALLY
  LD (HL),A             ;STORE NUMBER READ
  OR A                  ;Test for EOF
  POP DE                ;GET [D,E] BACK
  RET

; Set DMA address
;
; Used by the routines at __EOF, CPM_CLSFIL, INDSKB and __OPEN.
SETBUF:
  PUSH BC               ;SAVE [B,C]
  PUSH DE               ;SAVE [D,E]
  PUSH HL               ;SAVE [H,L]
  LD HL,$0028           ;DATOFS-1: POINT TO BUFFER
  ADD HL,DE             ;ADD
  EX DE,HL              ;PUT BUFFER ADDRESS IN [D,E]
  LD C,$1A              ;SET UP BUFFER ADDRESS (BDOS function 26 - Set DMA address)
  CALL CPMENT           ;CALL CPM
  POP HL                ;RESTORE [H,L]
  POP DE                ;RESTORE [D,E]
  POP BC                ;RESTORE [B,C]
  RET

; Read byte, C flag is set if EOF
;
; a.k.a. INDSKC
; Used by the routines at LINE_INPUT, __LOAD, __MERGE, FN_INPUT and L4D05.
RDBYT:
  CALL INDSKB            ; GET A CHARACTER FROM A SEQUENTIAL FILE IN [PTRFIL]
  RET C                  ;IF EOF, RETURN WITH END OF FILE CHARACTER
  CP $1A                 ;WAS IT A CONTROL-Z (OR FS)?
  SCF                    ;SET CARRY
  CCF                    ;MAKE SURE CARRY RESET
  RET NZ                 ;NO
  PUSH BC                ;SAVE [B,C]
  PUSH HL                ;SAVE [H,L]
  LD HL,(PTRFIL)         ;GET POINTER TO FILE DATA BLOCK
  LD BC,$0027            ;0+ORNOFS: POINT TO NUMBER ORIGINALLY IN BUFFER
  ADD HL,BC
  LD (HL),$00            ;FORCE IT TO ZERO
  INC HL                 ;POINT TO NUMBER IN BUFFER
  LD (HL),$00            ;FORCE TO ZERO.
  SCF                    ;SET EOF FLAG
  POP HL                 ;RESTORE [H,L]
  POP BC                 ;RESTORE [B,C]
  RET

; Get file name, etc..
; a.k.a. NAMFIL -- SCAN A FILE NAME AND NAME COMMAND
;
; Used by the routines at __NAME, __OPEN, __KILL and __FILES.
FNAME:
  CALL EVAL              ;EVALUATE STRING
  PUSH HL                ;SAVE TEXT POINTER
  CALL GETSTR            ;FREE UP THE TEMP
  LD A,(HL)              ;GET LENGTH OF STRING
  OR A                   ;NULL STRING?
  JP Z,NM_ERR            ;YES, ERROR
  PUSH AF                ;NO "." SEEN
  INC HL                 ;PICK UP POINTER TO STRING
  LD E,(HL)              ;BY GETTING ADDRESS
  INC HL                 ;OUT OF DESCRIPTOR
  LD H,(HL)              
  LD L,E                 ;[H,L] POINTS TO STRING
  LD E,A                 ;SAVE LENGTH

  CP $02                 ;CAN THERE BE A DEVICE?
  JR C,NODEV             ;NO, NAME TOO SHORT
  LD C,(HL)              ;[C]=POSSIBLE DEVICE NAME ('drive letter' in file specifier)
  INC HL                 ;POINT TO NEXT CHAR
  LD A,(HL)              ;GET IT
  DEC E                  ;DECREMENT COUNT FOR DEVICE NAME
  CP ':'                 ;COLON FOR DEVICE NAME?
  JR Z,FNAME_1           ;YES, SO NOW GET FILE NAME
  DEC HL                 ;BACK UP POINTER BY ONE
  INC E                  ;COMPENSATE FOR DCR
NODEV:
  DEC HL                 ;BACK UP POINTER
  INC E                  ;INCREMENT CHAR COUNT TO COMPENSATE FOR NEXT DECR
  LD C,'A'-1             ;USE CURRENTLY SELECTED DRIVE (Force to drive number '0' {default}
                         ;                                if no drv letter in the filename)
FNAME_1:
  DEC E                  ;DECRMENT CHAR COUNT
  JR Z,NMERR             ;ERROR IF NO FILENAME
  LD A,C                 ; Get drive letter as written in file specifier
  AND $DF                ; Convert..
  SUB 'A'-1              ; ..to drive number (LOGICAL NUMBER).
  JR C,NMERR             ;NOT IN RANGE
  CP 27                  ;BIGGER THAN 27
  JR NC,NMERR            ;NOT ALLOWED
  LD BC,FILNAM           ;WHERE TO PUT NAME
  LD (BC),A              ; Set drive number in FCB
  INC BC                 ; Point to name (POINT TO WHERE FIRST CHAR OF FILE NAME IS STORED)
  LD D,11                ;LENGTH OF NAME (11-2*0 ??  ..I'd rather put 8+3)
FILINX:
  INC HL                 ;BUMP POINTER
FILLOP:
  DEC E                  ;END OF STRING
  JP M,FILSPC            ;YES, FILL REST OF FIELD WITH BLANKS
  LD A,(HL)              ;GET CHAR
  CP '.'                 ;EXTENSION?
  JR NZ,FILLOP_NOEXT     ;NO
  CALL FILLNM            ;YES, FILL NAME WITH BLANKS
  POP AF                 ;RESTORE CC'S
  SCF                    ;FLAG "." SEEN
  PUSH AF                ;SAVE CC'S BACK
  JR FILINX              ;YES, IGNORE "."

FILLOP_NOEXT:
  LD (BC),A              ;COPY CHAR
  INC BC
  INC HL
  DEC D                  ;DECRMENT POSSIBLE COUNT OF CHARS
  JR NZ,FILLOP

GOTNAM:
;  LD HL,FCB_EXTENT       ;CLEAR EXTENT FIELD..
;  LD B,21

  XOR A
  LD (FCB_EXTENT),A		; $080A
  POP AF
  POP HL

;GOTNAM_0:
;  LD (HL),$00            ;..and clear more
;  INC HL
;  DEC B
;  JP NZ,GOTNAM_0
;  POP AF                 ;RESTORE CONDITION CODES
;  POP HL                 ;GET BACK TEXT POINTER
  RET
  
FILLNM:
  LD A,D                 ;GET # OF CHARS
  CP 11                  ;INITIAL POSITION?  (11+8*0-2*0)
  JR Z,NMERR             ;DONT ALLOW NULL FILENAME
  CP 3                   ;FILLED FIELD?
  JR C,NMERR             ;NO, BUT 2ND "."
  RET Z                  ;YES, BACK TO LOOP
  LD A,' '               ;FILL WITH SPACE
  LD (BC),A
  INC BC
  DEC D
  JR FILLNM

FILSPC:
  INC D                  ;CHARS LEFT IN FILE BUFFER
  DEC D                  ;TEST
  JR Z,GOTNAM            ;NO
FILSP2:
  LD A,' '               ;SPACE
  LD (BC),A              ;STORE
  INC BC                
  DEC D                  ;FILLED WHOLE FIELD?
  JR NZ,FILSP2           ;NO, MORE SPACES
  JR GOTNAM              ;YES, MAKE SURE NAME OK
  
NMERR:
  JP NM_ERR

; 'NAME' BASIC command  (file rename)
__NAME:
  CALL FNAME             ;PICK UP THE OLD NAME TO USE
  PUSH HL                ;SAVE THE TEXT POINTER
  LD DE,DIRTMP           ;READ DIRECTORY IN HERE
  LD C,$1A               ;SET BUFFER ADDRESS  (BDOS function 26 - Set DMA address)
  CALL CPMENT            ;CALL CP/M
  LD DE,FILNAM           ;SEE IF ORIGINAL NAME EXISTS
  LD C,$0F               ;BY OPENING (BDOS function 15 - Open file)
  CALL CPMENT            ;CALL CP/M
  INC A                  ;DOES IT EXIST?
  JP Z,FF_ERR            ;FILE NOT FOUND
  LD HL,FILNA2           ;SAVE FILE NAME IN FILNA2
  LD DE,FILNAM           ;12+3*0-2*0+2*0+3*0-3*0 (???) SET [C]=MAX FILE NAME LENGTH
  LD B,$0C
NAMRMV:
  LD A,(DE)              ;GET BYTE FROM FILE
  LD (HL),A              ;SAVE BYTE IN "OLD" FILE NAME
  INC HL                 ;BUMP POINTERS
  INC DE
  ;DEC B
  DJNZ NAMRMV
  POP HL                 ;GET THE TEXT POINTER BACK
  CALL SYNCHR            
  DEFM "A"               ;MAKE SURE "AS" IS THERE
  CALL SYNCHR
  DEFM "S"
  CALL FNAME             ;READ THE NEW NAME
  PUSH HL                ;SAVE THE TEXT POINTER
  LD A,(FILNAM)          ;GET DISK # OF FILE NAME
  LD HL,FILNA2           ;POINT TO ORIG FILE
  CP (HL)                ;COMPARE
  JP NZ,FC_ERR           ;DISKS MUST BE THE SAME
  LD DE,FILNAM           ;SEE IF ORIGINAL NAME EXISTS
  LD C,$0F               ;BY OPENING (BDOS function 15 - Open file)
  CALL CPMENT            ;CALL CP/M
  INC A                  ;DOES IT EXIST?
  JP NZ,FILE_EXISTS_ERR  ;YES
  LD C,$17               ;RENAME OPERATION (BDOS function 23 - Rename file)
  LD DE,FILNA2           ;POINT AT OLD NAME FCB
  CALL CPMENT            ;CALL CP/M

;****DONT CHECK ERROR RETURN, CP/M HAS PROBLEMS****
IF !ORIGINAL
  INC A                  ;FILE FOUND?  (A=0-3 if successful; A=0FFh if error)
  JP Z,FF_ERR            ;NO
ENDIF

  POP HL                 ;RESTORE TEXT POINTER
  RET


; label='OPEN' BASIC command
;
; Different versions pick the file access mode directly from the FCB structure
; It looks like this version is avoiding to trust CP/M
;
__OPEN:
  LD BC,FINPRT           ;ZERO PTRFIL WHEN DONE
  PUSH BC                
  CALL EVAL              ;READ THE FILE MODE
  PUSH HL                ;SAVE THE TEXT POINTER
  CALL GETSTR            ;FREE STRING TEMP & CHECK STRING
  LD A,(HL)              ;MAKE SURE ITS NOT A NULL STRING
  OR A                   
  JP Z,FMODE_ERR         ;IF SO, "BAD FILE MODE"
  INC HL                 
  LD C,(HL)              ;[B,C] POINT AT MODE CHARACTER
  INC HL                 
  LD B,(HL)              
  LD A,(BC)              ;[A]=MODE CHARACTER
  AND $DF                ;FORCE TO UPPER CASE
  LD D,$02               ;ASSUME IT'S "O" (2=MD.SQO)
  CP 'O'                 ;IS IT?
  JR Z,HAVMOD            ;[D] HAS CORRECT MODE
  LD D,$01               ;ASSUME SEQUENTIAL (1=MD.SQI)
  CP 'I'                 ;IS IT?
  JR Z,HAVMOD            ;[D] SAYS SEQUENTIAL INPUT
  LD D,$03               ;MUST BE RANDOM (3=MD.RND)
  CP 'R'
  JP NZ,FMODE_ERR        ;IF NOT, NO MATCH SO "BAD FILE MODE"
HAVMOD:
  POP HL                 ;GET BACK THE TEXT POINTER
  CALL SYNCHR
  DEFM ","               ;SKIP COMMA BEFORE FILE NUMBER
  PUSH DE                ;SAVE THE FILE MODE
  CP '#'                 ;SKIP A POSSIBLE "#"
  CALL Z,CHRGTB
  CALL GETINT            ;READ THE FILE NUMBER (Get integer 0-255)
  CALL SYNCHR
  DEFM ","               ;SKIP COMMA BEFORE NAME
  LD A,E                 ;[A]=FILE NUMBER
  OR A                   ;MAKE SURE FILE WASN'T ZERO
  JP Z,BN_ERR            ;IF SO, "BAD FILE NUMBER"
  POP DE                 ;GET BACK FILE MODE
  
; This entry point is used by the routine at LINE_INPUT.
PRGFIL:
  LD E,A                 	;SAVE FILE NUMBER IN [E]
  PUSH DE                	;SAVE THE MODE IN [D] SINCE PROGRAM FILE [A]=0
  CALL FILIDX               ;[B,C] POINT AT FILE DATA BLOCK
  JP NZ,AO_ERR              ;IF NON ZERO MODE, "FILE ALREADY OPEN"
  POP DE                    ;[D]=FILE MODE
  PUSH BC                   ;SAVE POINTER AT FILE DATA BLOCK
  PUSH DE                   ;SAVE BACK FILE MODE AND NUMBER
  CALL FNAME                ;READ THE NAME
  POP DE                    ;RESTORE FILE NUMBER
  POP BC                    ;GET BACK FILE DATA BLOCK POINTER
  PUSH BC                   ;SAVE BACK
  PUSH AF                   ;SAVE EXTENSION FLAG
  LD A,D                    ;GET FILE MODE
  CALL VARECS               ;SCAN RECORD LENGTH FIELD
  POP AF                    ;GET BACK EXTENSION FLAG
  LD (TEMP),HL              ;SAVE THE TEXT POINTER FOR A WHILE
  JR C,PRGDOT               ;IF "." SEEN, DONT DEFAULT EXTENSION
  LD A,E                    ;GET FILE NUMBER
  OR A                      ;SET CONDITION CODES
  JR NZ,PRGDOT              ;NOT FILE 0, DONT DEFAULT FILE NAME
  LD HL,FCB_FTYP            ; (FILNAM+9-0-0-2*0): POINT TO FIRST CHAR OF EXTENSION
  LD A,(HL)                 ;GET IT
  CP ' '                    ;BLANK EXTENSION
  JR NZ,PRGDOT              ;NON-BLANK EXTENSION, DONT USE DEFAULT
  LD (HL),'B'               ;SET DEFAULT EXTENSION
  INC HL
  LD (HL),'A'
  INC HL
  LD (HL),'S'               ;SET ".BAS"

PRGDOT:
  POP HL                    ;[H,L]=POINTER AT FILE DATA BLOCK
  LD A,D                    
  PUSH AF                   
  LD (PTRFIL),HL            ;SETUP AS CURRENT FILE
  PUSH HL                   ;SAVE BACK FILE DATA BLOCK POINTER
  INC HL                    ;POINT TO FCB ENTRY
  LD DE,FILNAM              ;GET POINTER TO SCANNED FILE NAME
  LD C,$0C                  ;(12+0+0*3+2*0+3*0 ??) NUMBER OF BYTES TO COPY
OPNLP:
  LD A,(DE)                 ;GET BYTE FROM FILNAM
  LD (HL),A                 ;STORE IN FILE DATA BLOCK
  INC DE
  INC HL
  DEC C                     ;DECRMENT COUNT OF BYTES TO MOVE
  JR NZ,OPNLP               ;KEEP LOOPING

;	OPEN FILE
;
;	((SP)) points to File Data Block
;	((SP)+2) contains the file mode - DMC!X3200!R2E

  XOR A
  LD (HL),A                 ;MAKE SURE EXTENT FIELD IS ZERO
  LD DE,$0014               ;POINT TO NR FIELD
  ADD HL,DE                 
  LD (HL),A                 ;SET TO ZERO
  POP DE                    ;GET POINTER TO FILE DATA BLOCK BACK IN [D]
  PUSH DE                   ;SAVE AGAIN FOR LATER
  INC DE
  CALL SETBUF               ;SET BUFFER ADDRESS
  POP HL                    ;GET BACK FILE DATA BLOCK PTR
  POP AF                    ;GET MODE
  PUSH AF
  PUSH HL                   ;SAVE BACK
  ;MOV	A,(HL)			;GET MODE   (found in other versions)
  CP $02                    ; (MD.SQO) SEQENTIAL OUTPUT?
  JR NZ,OPNFIL              ;NO, DO CPM OPEN CALL
  PUSH DE                   ;SAVE FCB POINTER
  LD C,$13                  ;DELETE EXISTING OUTPUT FILE, IF ANY  (BDOS function 19 - delete file)
  CALL CPMENT               ;CALL CP/M
  POP DE                    ;RESTORE FCB POINTER
MAKFIL:
  LD C,$16                  ; BDOS function 22 - create file
  CALL CPMENT               ;CALL CPM
  INC A                     ;TEST FOR TOO MANY FILES
  JP Z,FL_ERR               ;THAT WAS THE CASE
  JR OPNSET                 ;FINISH SETUP OF FILE DATA BLOCK
OPNFIL:
  LD C,$0F                  ;CPM CODE FOR OPEN (BDOS function 15 - Open file)
  CALL CPMENT               ;CALL CPM
  INC A                     ;FILE NOT FOUND
  JR NZ,OPNSET              ;FOUND
  POP DE                    ;GET BACK FILE POINTER
  POP AF                    ;GET MODE OF FILE  (LD A,(DE) somewhere else)
  PUSH AF                   
  PUSH DE                   ;SAVE BACK FILE POINTER
  CP $03                    ;RANDOM?
  JP NZ,FF_ERR              ;NO, SEQENTIAL INPUT, FILE NOT FOUND
  INC DE                    ;MAKE [D,E]=FCB POINTER
  JR MAKFIL                 ;MAKE FILE

;	((SP)) points to File Data Block
;	((SP)+2) contains the file mode - DMC!X3200!R2E

OPNSET:
  POP DE                    ;POINT TO FILE INFO
  POP AF
  LD (DE),A
  PUSH DE                   ;SAVE POINTER BACK
  LD HL,$0025               ;(0+LOCOFS) POINT TO CURLOC
  ADD HL,DE
  XOR A                     ;ZERO CURLOC IN CASE THIS FILE WAS JUST KILLED
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A                 ;ZERO NUMBER OF BYTES IN THE BUFFER
  INC HL
  LD (HL),A                 ;ZERO PRINT POSITION
  POP HL                    ;GET POINTER AT MODE
  LD A,(HL)                 ;SEE WHAT HAS TO BE DONE
  CP $03                    ;IS IT RANDOM MODE?
  JR Z,RNDFIN               ;YES RANDOM FINISH UP
  CP $01                    ;IF SEQUENTIAL ALL THAT IS LEFT TO DO
  JP NZ,GTMPRT              ;FETCH TEXT POINTER AND DONE
;
; FINISH UP SEQUENTIAL INPUT AFTER FINDING FILE
;
  CALL READ2                ;READ FIRST DATA BLOCK
  LD HL,(TEMP)              ;GET BACK THE TEXT POINTER
  RET


RNDFIN:
  LD BC,$0029               ;DATOFS: NOW ADVANCE POINTER TO DATA
  ADD HL,BC                 ;BY ADDING PROPER OFFSET
  LD C,$80                  ;# OF BYTES TO ZERO
ZRRNDT:
  LD (HL),B
  INC HL
  DEC C
  JR NZ,ZRRNDT
  JP GTMPRT                 ;Restore code string address


; 'SYSTEM' BASIC command
; SYSTEM (EXIT) COMMAND - RETURN TO CPM (OR EXIT TO OS)
__SYSTEM:
  RET NZ                    ;SHOULD TERMINATE
  CALL CLSALL               ;CLOSE ALL DATA FILES
; This entry point is used by the routine at _ERROR_REPORT.
EXIT_TO_SYSTEM:
  JP CPMWRM                 ;WARM START CP/M



IF VT52

__CLS:

IF ZXLEC | ZXCSDISK
  LD A,26
  JP OUTDO
ELSE

IF BIOS20 | PINIX | ZX128
  LD A,12
  JP OUTDO
ELSE

IF HC2000
  LD A,24
  JP OUTDO
ELSE

IF QUORUM | ELWRO

  LD A,27
  CALL OUTDO
  LD A,'H'
  CALL OUTDO
  LD A,27
  CALL OUTDO
  LD A,'E'
  JP OUTDO

ELSE
  LD A,27
  CALL OUTDO
  LD A,'x'
  CALL OUTDO

  LD A,27
  CALL OUTDO
  LD A,'E'
  CALL OUTDO
  LD A,27
  CALL OUTDO
  LD A,'H'
  JP OUTDO
ENDIF
  
ENDIF
ENDIF
ENDIF

__LOCATE:
  LD DE,$0101			; default values: top-left
  PUSH DE
  CP ','
  JR Z,__LOCATE_0
  CALL GETINT              ; Get integer 0-255
  POP DE
  LD D,A
  PUSH DE
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__LOCATE_3
__LOCATE_0:
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,__LOCATE_1
  CALL GETINT              ; Get integer 0-255
  POP DE
  LD E,A
  PUSH DE
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__LOCATE_3
__LOCATE_1:
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT              ; Get integer 0-255
  AND A
  LD A,'e'			; show cursor
  JR NZ,__LOCATE_2
  INC A				; hide cursor
__LOCATE_2:
IF BIOS20 | ZX128
; TODO: find how to show/hide cursor
ELSE
  CALL ESCA         ; ESC_y (show/hide cursor)
ENDIF
__LOCATE_3:

  EX (SP),HL
  CALL POSIT
  POP HL
  RET

; top-left corner is at 1:1 as for GW-BASIC, while MSX had 0:0
POSIT:

IF ZX128
  LD A,$01
  CALL OUTDO
 
  LD B,H
  DEC B
  JR Z,NO_H
POSIT_H:
  LD A,21
  CALL OUTDO
  DJNZ POSIT_H
NO_H:

  LD B,L
  DEC B
  JR Z,NO_V
POSIT_V:
  LD A,10
  CALL OUTDO
  DJNZ POSIT_V
NO_V:

  RET
ENDIF

IF BIOS20
  LD A,$0B
  CALL OUTDO
 
  LD B,H
  DEC B
  JR Z,NO_H
POSIT_H:
  LD A,$18
  CALL OUTDO
  DJNZ POSIT_H
NO_H:

  LD B,L
  DEC B
  JR Z,NO_V
POSIT_V:
  LD A,$1A
  CALL OUTDO
  DJNZ POSIT_V
NO_V:

  RET
ELSE

IF ZXLEC | ZXCSDISK
  LD A,'='
  CALL ESCA
ELSE
IF HC2000
  LD A,'A'
  CALL ESCA
ELSE
  LD A,'Y'
  CALL ESCA
ENDIF
ENDIF
  LD A,L
  ADD A,31
  CALL OUTDO
  LD A,H
  LD (TTYPOS),A
  ADD A,31
  CALL OUTDO
  RET

; print escape code in A
ESCA:
  PUSH AF
  LD A,27
  CALL OUTDO
  POP AF
  CALL OUTDO
  RET
ENDIF

ENDIF


; 'RESET' BASIC command
__RESET:
  RET NZ                  ;SHOULD TERMINATE
  PUSH HL                 ;SAVE TEXT POINTER
  CALL CLSALL             ;CLOSE ALL FILES
  LD C,$19                ;GET DRIVE CURRENTLY SELECTED (BDOS function 25 - Get current drive)
  CALL CPMENT             ;GET IT IN [A]
  PUSH AF                 ;SAVE CURRENT DRIVE #
  LD C,$0D                ;DO THE RESET CALL (BDOS function 13 - Reset discs)
  CALL CPMENT
  POP AF                  ;GET DRIVE TO SELECT
  LD E,A                  ;INTO [E]
  LD C,$0E                ;SET DRIVE, BDOS function 14 - Select disc (set current drive)
  CALL CPMENT             ;CALL CPM
  POP HL                  ;RESTORE TEXT POINTER
  RET

; 'KILL' BASIC command (erase file)
__KILL:
  CALL FNAME             ;SCAN FILE NAME
  PUSH HL                ;SAVE TEXT POINTER
  LD DE,DIRTMP           ;(DIRTMP) READ DIRECTORY IN HERE
  LD C,$1A               ;SET BUFFER ADDRESS (BDOS function 26 - Set DMA address)
  CALL CPMENT            ;FOR CP/M
  LD DE,FILNAM           ;TRY TO OPEN FILE
  PUSH DE                ;SAVE FCB POINTER
  LD C,$0F               ; BDOS function 15 - Open file
  CALL CPMENT
  INC A                  ;FILE FOUND?
  POP DE                 ;GET BACK POINTER TO FCB
  PUSH DE                ;SAVE BACK
  PUSH AF                ;SAVE FOUND FLAG
  LD C,$10               ;THIS MAY NOT BE NESC. (BDOS function 16 - Close file)
  JR Z,__KILL_0          ; - Previous versions had a cute "CALL NZ,CPMENT".  Why was it changed ?
  CALL CPMENT            ;CLOSE FILE
__KILL_0:
  POP AF                 ;RESTORE FOUND INDICATOR
  POP DE                 ;RESTORE FCB POINTER
  JP Z,FF_ERR            ;YES
  LD C,$13               ; BDOS function 19 - delete file
  CALL CPMENT            ;CALL CPM
  POP HL                 ;GET BACK TEXT POINTER
  RET

; 'FILES' BASIC command
__FILES:
  JR NZ,__FILES_0        ;FILE NAME WAS SPECIFIED
  PUSH HL                ;SAVE TEXT POINTER
  LD HL,FILNAM           ;POINT TO FILE NAME
  LD (HL),$00            ;SET CURRENT DRIVE
  INC HL                 ;BUMP POINTER
  LD C,$0B               ;MATCH ALL FILES
  CALL FILENAME_FILL     ;SET FILE NAME AND EXTENSION TO QUESTION MARKS
  POP HL                 ;RESTORE TEXT POINTER
__FILES_0:
  CALL NZ,FNAME          ;SCAN FILE NAME
  XOR A                  ;MAKE SURE EXTENT IS ZERO
  LD (FCB_EXTENT),A      ; (FILNAM+12)
  PUSH HL                ;SAVE TEXT POINTER
  LD HL,FCB_FNAME        ;GET FIRST CHAR OF FILE NAME
  LD C,$08               ;FILL NAME WITH QUESTION MARKS
  CALL FILENAME_QS      
  LD HL,FCB_FTYP         ;POINT TO EXTENSION
  LD C,$03               ;3 CHARS IN EXTENSION
  CALL FILENAME_QS       ;FILL IT WITH QMARKS
  LD DE,DIRTMP           ;SET BUFFER TO 80 HEX
  LD C,$1A               ;(C.BUFF) BDOS function 26 - Set DMA address
  CALL CPMENT
  LD DE,FILNAM           ;POINT TO FCB
  LD C,$11               ;DO INITIAL SEARCH FOR FILE - BDOS function 17 - search for first
  CALL CPMENT
  CP $FF                 ;FIND FIRST INCARNATION OF FILE
  JP Z,FF_ERR            ;NO

FILNXT:
  AND $03                ;MASK OFF LOW TWO BITS
  ADD A,A                ;MULTIPLY BY 32
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD C,A                 ;PUT OFFSET IN [B,C]
  LD B,$00                
  LD HL,DIRTMP+1         ;POINT TO DIRECTORY BUFFER
  ADD HL,BC              ;POINT TO FCB ENTRY IN DIRECTORY
  LD C,$0B               ; (11+5*0+11*0 ??) CHARS IN NAME
__FILES_2:
  LD A,(HL)              ;GET FILE NAME CHAR
  INC HL                 ;BUMP POINTER
  AND $7F                ;Force it to 7 bit ASCII  (does not exist on previous versions)
  CALL OUTDO             ;PRINT IT
  LD A,C                 ;GET  CHAR POSIT
  CP $04                 ; (4+5*0) ABOUT TO PRINT EXTENSION?
  JR NZ,NOTEXT           ;NO
  LD A,(HL)              ;GET FIRST CHAR OF EXTENSION
  CP ' '                 ;IF SO, NOT SPACE
  JR Z,PRISPA            ;PRINT SPACE
  LD A,'.'               ;PRINT DOT
PRISPA:
  CALL OUTDO
NOTEXT:
  DEC C                  ;DECREMENT CHAR COUNT
  JR NZ,__FILES_2        ;MORE OF NAME TO PRINT
  LD A,(TTYPOS)          ;GET CURRENT TTY POSIT
  ADD A,$0D              ;SPACE FOR NEXT NAME?
  LD D,A                 ;SAVE IN D
  LD A,(LINLEN)          ;GET LENGTH OF TERMINAL LINE
  CP D                   ;COMPRE TO CURRENT POSIT
  JR C,NWFILN            ;NEED TO FORCE CRLF
  LD A,' '               ;TWO SPACES BETWEEN FILE NAMES
  CALL OUTDO
  CALL OUTDO
                         ;OR THREE
NWFILN:
  CALL C,OUTDO_CRLF       ;TYPE CRLF
  LD DE,FILNAM            ;POINT AT FCB
  LD C,$12                ;SEARCH FOR NEXT ENTRY (BDOS function 18 - search for next)
  CALL CPMENT             ;SEARCH FOR NEXT INCARNATION
  CP $FF                  ;NO MORE?
  JR NZ,FILNXT            ;MORE.
  POP HL                  ;RESTORE TEXT POINTER
  RET

; Deal with file name
;
; Used by the routine at __FILES.
FILENAME_QS:
  LD A,(HL)               ;GET CHAR
  CP '*'                  ;WILD CARD?
  RET NZ                  ;NO, RETURN

; This entry point is used by the routine at __FILES.
FILENAME_FILL:
  LD (HL),'?'             ;STORE QUESTION MARK
  INC HL                  ;BUMP POINTER
  DEC C                   ;DECREMENT COUNT OF QMARKS
  JR NZ,FILENAME_FILL     ;KEEP SAVING QMARKS
  RET


; DSKF FUNCTION
; Miscellaneous Operating System I/O

; Enter BDOS for file read or write operations
;
; Used by the routines at __EOF and INDSKB.
; Called after picking the current function from CPMREA / CPMWRT
ACCFIL:
  PUSH DE                 ; Save FCB address
  LD C,A
  PUSH BC
  CALL CPMENT
  POP BC
  POP DE
  PUSH AF
  LD HL,$0021             ; (0+FCB.RN) Point to random record number
  ADD HL,DE               ; Now HL points to the random access record number
  INC (HL)                ; Increment record number LSB (R0)
  JR NZ,ACCFL1
  INC HL                  ; Increment record number R1
  INC (HL)                ; Increment record number R2
  JR NZ,ACCFL1            ; NO
  INC HL
  INC (HL)
ACCFL1:
  LD A,C                  ;Get back CPM call code
  CP $22                  ; was it a 'random write' BDOS call ?
  JR NZ,ACCFL2
  POP AF                  ;Get error code and map into 1.4 errors
  OR A
  RET Z                   ; Return if write OK
  CP $05
  JP Z,FL_ERR             ; JP if Directory full (Too many files)
  CP $03
  LD A,$01                ; Turn into I/O error
  RET Z                   ; Return if Disk full
  INC A                   ; DEFAULT TO DISK SPACE FULL (2)
  RET

ACCFL2:
  POP AF
  RET


;
; The 5.0 Disk code is essentially an extra level of buffering for random disk I/O files.
; Sequential I/O is not affected by the 5.0 code.
; Great care has been taken to insure compatibility with existing code 
; to support diverse operating systems.
; The 5.0 disk code has its own data structure for handling the variable length records in random files.
; This data structure sits right after the regular data block for the file and consumes an amount of 
; memory equal to MAXREC (The maximum allowed record size) plus 9 bytes.
;
;Here is the content of the data block:
;
;FD.SIZ size 2          ;Variable length record size default 128
;FD.PHY size 2          ;Current physical record #
;FD.LOG size 2          ;Current logical record number
;FD.CHG size 1          ;Future flag for accross block PRINTs etc.
;FD.OPS size 2          ;Output print position for PRINT, INPUT, WRITE
;FD.DAT size FD.SIZ	    ;Actual FIELD data buffer
;            ;Size is FD.SIZ bytes long
;
;DATE				FIX
;----				---
;8/6/1979           Make PUT, GET increment LOC correctly
;8/14/1979          PUT in BASIC compiler switch (main source)





;	VARECS - Variable record scan for OPEN

;	Enter VARECS with file mode in [A]


; This entry point is used by the routine at __OPEN.
VARECS:
  CP $03                ;Random?
  RET NZ                ;No, give error later if he gave record length
  DEC HL                ;Back up pointer
  CALL CHRGTB           ;Test for eol
  PUSH DE               ;Save [D,E]
  LD DE,DATPSC          ;Assume record length=DATPSC
  JR Z,NOTSEP           ;No other params for OPEN
  PUSH BC               ;Save file data block pointer
  CALL INTIDX           ;Get record length
  POP BC                ;Get back file data block
NOTSEP:
  PUSH HL               ;Save text pointer
  LD HL,(MAXREC)        ;Is size ok?
  CALL DCOMPR
  JP C,FC_ERR
  LD HL,$00A9           ;Stuff into data block: (FD.SIZ) POINT TO RECORD SIZE  
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  XOR A                 ;Clear other bytes in data block
  LD E,$07              ;# of bytes to clear
ZOFIVB:
  INC HL                ;Increment pointer
  LD (HL),A             ;Clear byte
  DEC E                 ;Count down
  JR NZ,ZOFIVB          ;Go back for more
  POP HL                ;Text pointer 
  POP DE                ;Restore [D,E]
  RET

; 'PUT' BASIC command
__PUT:
  DEFB $F6                ; OR $AF  masking the next instruction  ("ORI"to set non-zero flag)

; 'GET' BASIC command
__GET:
  XOR A                   ;Set zero
  LD (PUTGET_FLG),A       ;Save flag
  CALL FILSCN             ;Get pointer at file data block   (in BC)
;__GET_0:
  CP $03                  ;Must be a random file
  JP NZ,FMODE_ERR         ;If not, "Bad file mode"
  PUSH BC                 ;Save pointer at file data block
  PUSH HL                 ;Save text pointer
  LD HL,$00AD             ;(FD.LOG) Fetch current logical posit
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC DE                  ;Compensate for "DCX D" when call INTIDX
  EX (SP),HL              ;Save data block pointer and get text pointer
  LD A,(HL)
  CP ','                  ;Is there a record number
  CALL Z,INTIDX           ;Read it if there, 1-indexed
  DEC HL                  ;Make sure statement ends
  CALL CHRGTB
  JP NZ,SN_ERR
  EX (SP),HL              ;Save text pointer, get data block pointer
  LD A,D                  ;Get record #
  OR E                    ;Make sure its not zero
  JP Z,RECNO_ERR          ;If so, "Bad record number"
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  DEC DE
  POP HL                  ;Get back text pointer 
  POP BC
  PUSH HL                 ;Save back text pointer 
  PUSH BC                 ;Pointer to file data block
  LD HL,$00B0		      ;FD.OPS: Zero output file posit
  ADD HL,BC
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD HL,$00A9             ;(FD.SIZ) Get logical record size in [D,E]
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  EX DE,HL                ;Record size to [D,E], posit in [H,L]
  PUSH DE                 ;Save record size (count of bytes)

; Record size in [D,E]
; Logical position in [H,L]
; This code computes physical record # in [H,L]
; offset into buffer in [D,E]

  PUSH HL                 ;Save logical posit
  LD HL,DATPSC            ;Get sector size
  CALL DCOMPR             ;Compare the two
  POP HL                  ;Restore logical posit
  JR NZ,NTLSAP            ;If record size=sector size, done
  LD DE,$0000             ;Set offset to zero
  JR DONCLC               ;Done with calculations

NTLSAP:
  LD B,D                  ;Copy record size to [B,C]
  LD C,E
  LD A,16                 ;16 by 16 multiply
  EX DE,HL                ;Put multiplier in [D,E]
  LD HL,$0000             ;Set both parts of product to zero
  PUSH HL                 ;2nd part is on stack
FRMUL1:
  ADD HL,HL
  EX (SP),HL
  JR NC,FNOCRY
  ADD HL,HL
  INC HL
  JR FNOCY0

FNOCRY:
  ADD HL,HL
FNOCY0:
  EX (SP),HL
  EX DE,HL
  ADD HL,HL               ;Rotate [D,E] left one
  EX DE,HL
  JR NC,FNOCY2            ;Add in [B,C] if Ho=1
  ADD HL,BC
  EX (SP),HL
  JR NC,FNOINH
  INC HL
FNOINH:
  EX (SP),HL
FNOCY2:
  DEC A                   ;are we done multiplying
  JR NZ,FRMUL1            ;No, go back for next bit of product


; Now divide by the number of bytes in a sector

;	IFF	DATPSC-256
;	MOV	E,L			;Remainder is just low byte
;	MVI	D,0			;Of which HO is 0
;	MOV	L,H			;Annd record # is shifted down
;	POP	B			;Get most sig. Byte of record #
;	MOV	H,C			;set record # to it
;	MOV	A,B			;Make sure rest=0
;	ORA	A
;	JNZ	FCERR
;	END IFF	DATPSC-256


;	IF	DATPSC-128
;	IF	DATPSC-256
;	POP	D			;Get high word of dividend in [D,E]
;	LXI	B,0			;Set dividend to zero.
;KEPSUB:	PUSH	B			;Save dividend
;	LXI	B,0-DATPSC		;Get divisor (# of bytes sector)
;	DAD	B			;Subtract it
;	JC	GUARCY			;Carry from low bytes implies cary from high
;	XCHG				;Subtract -1 from high byte
;	LXI	B,0-1
;	DAD	B
;	XCHG				;Put result back where it belongs
;GUARCY:	POP	B			;Restore dividend
;	JNC	DONDIV			;Finished
;	INX	B			;Add one to it
;	MOV	A,B			;See if overflowed
;	ORA	C
;	JNZ	KEPSUB			;Keep at it till done
;	JMP	FCERR			;Yes give error
;DONDIV:	PUSH	B			;Save dividend
;	LXI	B,0+DATPSC		;Correct for one too many subtraction
;	DAD	B			;By adding divisor back in
;	POP	D			;Dividend ends up in [D,E], Remainder in [H,L]
;	XCHG	
;	ENDIF
;	ENDIF



;IFF DATPSC-128
  LD A,L                  ;Get low byte of result
  AND $7F                 ;Get rid of high bit
  LD E,A                  ;this is it
  LD D,$00                ;Set high byte of remainder to zero
  POP BC                  ;Get high word of product
  LD A,L                  ;Get MSB of low word
  LD L,H
  LD H,C
  ADD HL,HL               ;Make space for it
  JP C,FC_ERR             ;UH-OH record # to big!
  RLA                     ;Is it set?
  JR NC,DONINH            ;Not set
  INC HL                  ;Copy it into low bit
DONINH:
  LD A,B                  ;Get high byte of record #
  OR A                    ; Is it non-zero
  JP NZ,FC_ERR
;END IFF DATPSC-128


DONCLC:

; At this point, record #is in [H,L]
; offset into record in [D,E]
; Stack:
; COUNT of bytes to read or write
; data block
; Text pointer
; Return Address

  LD (RECORD),HL          ;Save record size
  POP HL                  ;Get count
  POP BC                  ;Pointer to file data block
  PUSH HL                 ;Save back count
  LD HL,$00B2             ;FD.DAT: Point to Field buffer
  ADD HL,BC               ;Add start of data block
  LD (LBUFF),HL           ;Save pointer to FIELD buffer
NXTOPD:
  LD HL,$0029             ;DATOFS: Point to physical buffer
  ADD HL,BC               ;Add file block offset
  ADD HL,DE
  LD (PBUFF),HL           ;PBUFF: Save
  POP HL                  ;Get count
  PUSH HL                 ;Save count
  LD HL,DATPSC            ;[H,L]=DATPSC-offset
  LD A,L                  
  SUB E                   
  LD L,A                  
  LD A,H
  SBC A,D
  LD H,A
  POP DE                  ;Get back count (destroy offset)
  PUSH DE                 ;Save COUNT
  CALL DCOMPR             ;Which is smaller, count or DATPSC-offset?
  JR C,DATMOF             ;The latter
  LD H,D                  ;Copy count into bytes
  LD L,E
DATMOF:
  LD A,(PUTGET_FLG)       ;PUT or GET
  OR A                    ;Set cc's
  JR Z,FIVDRD             ;Was Read
  LD DE,DATPSC            ;If bytes .LT. DATPSC then read(sector)
  CALL DCOMPR
  JR NC,NOFVRD            ;(Idea-if writing full buffer, no need to read)
  PUSH HL                 ;Save bytes
  CALL GETSUB             ;Read record.
  POP HL                  ;Bytes
NOFVRD:
  PUSH BC
  LD B,H
  LD C,L
  LD DE,(PBUFF)
  LD HL,(LBUFF)          ;Get ready to move bytes between buffers
  CALL _LDIR             ;Move bytes to physical buffer
  LD (LBUFF),HL          ;Store updated pointer
  LD D,B                 ;COUNT TO [D,E]
  LD E,C
  POP BC                 ;Restore FDB pointer
  CALL PUTSUB            ;Do write
NXFVBF:
  LD HL,(RECORD)
  INC HL                 ;Increment it
  LD (RECORD),HL         ;Save back
  POP HL                 ;Count
  ; HL=HL-DE
  LD A,L                 ;Make count correct
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD A,H
  OR L                   ;Is count zero?
  LD DE,$0000            ;Set offset=0
  PUSH HL                ;Save COUNT
  JR NZ,NXTOPD           ;Keep working on it
  POP HL                 ;Get rid of COUNT
  POP HL                 ;Restore text pointer
  RET                    ;Done

; Read code
; [H,L]=bytes
; [D,E]=count
FIVDRD:
  PUSH HL                ;Save bytes
  CALL GETSUB            ;Do read
  POP HL                 ;Get back bytes
  PUSH BC
  LD B,H
  LD C,L
  LD DE,(LBUFF)          ;Point to logical buffer
  LD HL,(PBUFF)
  CALL _LDIR
  EX DE,HL               ;Get pointer to FIELD buffer in [H,L]
  LD (LBUFF),HL          ;Save back updated logical buffer
  LD D,B                 ;COUNT TO [D,E]
  LD E,C
  POP BC
  JR NXFVBF

PUTSUB:
  DEFB $F6                ; "OR n" to Mask 'XOR A'
GETSUB:
  XOR A
  LD (MAXTRK),A           ;GET/PUT Fflag
  PUSH BC
  PUSH DE
  PUSH HL
  LD DE,(RECORD)
  LD HL,$00AB             ;FD.PHY: Point to physical record #
  ADD HL,BC               ;Add offset to file buffer
  PUSH HL                 ;Save this pointer
  LD A,(HL)               ;Get current phys. rec #
  INC HL
  LD H,(HL)
  LD L,A
  INC DE
  CALL DCOMPR             ;Do we already have record in buffer
  POP HL                  ;Restore pointer
  LD (HL),E
  INC HL
  LD (HL),D               ;Store new record number
  JR NZ,NTREDS            ;Curent and previos record numbers are different
  LD A,(MAXTRK)           ;Trying to do read?
  OR A
  JR Z,SUBRET             ;If trying to read and record already in buffer, do nothing

NTREDS:
  LD HL,SUBRET            ;Where to return to
  PUSH HL
  PUSH BC                 ;File data block
  PUSH HL                 ;Dummy text pointer
  LD HL,$0026             ;LOCOFS+1: where [H,L] is expected to be
  ADD HL,BC
  JP FIVDPT               ;Call old PUT/GET

SUBRET:
  POP HL
  POP DE
  POP BC
  RET                     ;Restore all regs and return to caller


; a.k.a. FDMOV: LDIR on the 8080/8085
; Move bytes from [H,L] to [D,E] [B,C] times
_LDIR:
  PUSH BC                 ;Save count
IF __CPU_8080__ | __CPU_8085__
_LDIR1:
  LD A,(HL)               ;Get byte
  LD (DE),A               ;Store it
  INC HL
  INC DE
  DEC BC                  ;Decrement count
  LD A,B                  ;Gone to zero?
  OR C
  JP NZ,_LDIR1            ;Go back for more
ELSE
  LDIR
ENDIF
  POP BC                  ;Return with count

  RET


; This entry point is used by the routine at __LOF.
FILOFV:
  POP AF                  ;Get character off stack
  PUSH DE                 ;Save [D,E]
  PUSH BC                 ;Save [B,C]
  PUSH AF                 ;Save back char
  LD B,H                  ;[B,C]=file data block
  LD C,L
  CALL CMPFPS             ;Any room in buffer
  JR Z,DERFOV             ;No
  CALL SETFPI             ;save new position
  LD HL,$00B1             ;FD.DAT-1: Index into data buffer
  ADD HL,BC               ;Add start of file control block
  ADD HL,DE               ;Add offset into buffer
  POP AF                  ;Get back char
  LD (HL),A               ;Store in buffer
  PUSH AF                 ;Save char
  LD HL,$0028             ;NMLOFS: Set up [H,L] to point at print posit
  ADD HL,BC
  LD D,(HL)               ;Get present position
  LD (HL),$00             ;Assume set it to zero
  CP $0D                  ;Is it <Cr>?
  JR Z,FISCR              ;Yes
  ADD A,$E0               ;Set carry for spaces & higher
  LD A,D                  ;Add one to current posit
  ADC A,$00
  LD (HL),A
FISCR:
  POP AF                  ;Restore all regs
  POP BC
  POP DE
  POP HL
  RET

DERFOV:
  JP FO_ERR

; This entry point is used by the routine at INDSKB.
FILIFV:
  PUSH DE
  CALL CMPFBC             ;Save [D,E]
  JR Z,DERFOV             ;Compare to present posit
  CALL SETFPI             ;Return with null 
  LD HL,$00B1             ;FD.DAT-1: Set new position
  ADD HL,BC               ;Point to data
  ADD HL,DE
  LD A,(HL)               ;Get the byte
  OR A                    ;Clear carry (no EOF)
  POP DE                  ;Restore [D,E]
  POP HL                  ;Restore [H,L]
  POP BC                  ;Restore [B,C]
  RET

GETFSZ:
  LD HL,$00A9             ;FD.SIZ: Point to record size
  JR GETFP1               ;Continue

GETFPS:
  LD HL,$00B0             ;FD.OPS: Point to output position
GETFP1:
  ADD HL,BC               ;Add offset into buffer
  LD E,(HL)               ;Get value
  INC HL
  LD D,(HL)
  RET

SETFPI:
  INC DE                  ;Increment current posit
  LD HL,$00B0             ;FD.OPS: Point to output position
  ADD HL,BC               ;Add file control block address
  LD (HL),E
  INC HL
  LD (HL),D
  RET

; This entry point is used by the routine at CAYSTR.
CMPFBC:
  LD B,H                  ;Copy file data block into [B,C]
  LD C,L
CMPFPS:
  CALL GETFPS             ;Get present posit
  PUSH DE                 ;Save it
  CALL GETFSZ             ;Get file size
  EX DE,HL                ;into [H,L]
  POP DE                  ;Get back posit
  CALL DCOMPR             ;See if were at end
  RET

	; Protected files

; This entry point is used by the routine at __MERGE.
PROSAV:
  CALL CHRGTB             ;Get char after "S"               ;skip "P"
  LD (TEMP),HL            ;Save text pointer
  CALL SCCPTR             ;Get rid of GOTO pointers
  CALL PENCOD             ;encode binary
  LD A,$FE                ;Put out 254 at start of file     ;ID byte for Protected files
  CALL BINPSV                                               ;Do the SAVE
  CALL PDECOD             ;Re-decode binary                 ;Decode binary
  JP GTMPRT               ;Back to NEWSTT                   ;return to NEWSTT


defc N1 = 11  ;Number of bytes to use from ATNCON (FP_ATNTAB)
defc N2 = 13  ;Number of bytes to use from SINCON (FP_SINTAB)


PENCOD:
  LD BC,N1+N2*256         ;Initialize both counters  (B=N1, C=N2)
  LD HL,(TXTTAB)          ;Starting point
  EX DE,HL                ;Into [D,E]
ENCDBL:
  LD HL,(VARTAB)          ;At end?
  CALL DCOMPR             ;Test
  RET Z                   ;Yes
  LD HL,FP_ATNTAB         ;Point to first scramble table
  LD A,L                  ;Use [C] to index into it
  ADD A,C
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  LD A,(DE)               ;Get byte from program
  SUB B                   ;Subtract counter for no reason
  XOR (HL)                ;XOR entry
  PUSH AF                 ;Save result
  LD HL,FP_SINTAB         ;calculate offset into SINCON using [B]
  LD A,L
  ADD A,B
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  POP AF                  ;Get back current byte
  XOR (HL)                ;XOR on this one too
  ADD A,C                 ;Add counter for randomness
  LD (DE),A               ;Store back in program
  INC DE                  ;Incrment pointer
  DEC C                   ;decrment first table index
  JR NZ,CNTZER            ;Still non-Zero
  LD C,N1                 ;Re-initialize counter 1
CNTZER:
  ;DEC B                   ;dedecrement counter-2
  DJNZ ENCDBL            ;Still non-zero, go for more
  LD B,N2                 ;Re-initialize counter 2
  JR ENCDBL               ;Keep going until done

; This entry point is used by the routine at __LOAD.
PDECOD:
  LD BC,N1+N2*256         ;Initialize both counters  (B=N1, C=N2)
  LD HL,(TXTTAB)          ;Starting point
  EX DE,HL                ;Into [D,E]
DECDBL:
  LD HL,(VARTAB)          ;At end?
  CALL DCOMPR             ;Test
  RET Z                   ;Yes
  LD HL,FP_SINTAB         ;calculate offset into SINCON using [B]
  LD A,L
  ADD A,B
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  LD A,(DE)              ;Get byte from program
  SUB C                  ;Subtract counter for randomness
  XOR (HL)               ;XOR on this one too
  PUSH AF                ;Save result
  LD HL,FP_ATNTAB        ;Point to first scramble table
  LD A,L                 ;Use [C] to index into it
  ADD A,C
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  POP AF                 ;Get back current byte
  XOR (HL)               ;XOR entry
  ADD A,B                ;Add counter for no reason
  LD (DE),A              ;Store back in program
  INC DE                 ;Increment pointer
  DEC C                  ;decrment first table index
  JR NZ,CNTZR2           ;Still non-Zero
  LD C,N1                ;Re-initialize counter 1
CNTZR2:
  ;DEC B
  DJNZ DECDBL           ;Decrement counter-2, Still non-zero, go for more
  LD B,N2                ;Re-initialize counter 2
  JR DECDBL              ;Keep going until done


; This entry point is used by the routines at __DELETE and __POKE.
PRODIR:
  PUSH HL                ;Save [H,L]
  LD HL,(CURLIN)         ;Get current line #
  LD A,H                 ;Direct?
  AND L
  POP HL                 ;Restore [H,L]
  INC A                  ;If A=0, direct
  RET NZ


; This entry point is used by the routines at PROMPT, __LIST, LISPRT and __MERGE.
PROCHK:
  PUSH AF                ;Save flags
  LD A,(PROFLG)          ;Is this a protected file?
  OR A                   ;Set CC's
  JP NZ,FC_ERR           ;Yes, give error
  POP AF                 ;Restore flags
  RET


; Data block at 19141
RECORD:
  DEFW $0000

; Data block at 19143
LBUFF:
  DEFW $0000

; Data block at 19145
PBUFF:
  DEFW $0000

; Used to toggle between PUT / GET mode
PUTGET_FLG:
  DEFB $00





;------------------------------------------------------------------------------

IF HAVE_GFX

GRPACX:    DEFW 0			; X position of the last plotted pixel (GFX cursor X)
GRPACY:    DEFW 0			; Y position of the last plotted pixel (GFX cursor Y)

GXPOS:     DEFW 0			; Requested X coordinate
GYPOS:     DEFW 0			; Requested Y coordinate

IF PROFI | PINIX | ZXASC
ATRBYT:    DEFB 7			; Black PAPER, white INK
FORCLR:    DEFB 7			; Foreground color
BAKCLR:    DEFB 0			; Background color
BDRCLR:    DEFB 0			; Border color
ELSE

IF QUORUM | ELWRO

IF QUORUM 
defc CPJ_ATRBYT = $EF13
ENDIF
IF ELWRO
defc CPJ_ATRBYT = $D077
ENDIF

ATRBYT:    DEFB 56			;
FORCLR:    DEFB 0			; Foreground color
BAKCLR:    DEFB 7			; Background color
BDRCLR:    DEFB 7			; Border color

ELSE

IF ZXPLUS3
IF SCORPION
ATRBYT:    DEFB 56			;
FORCLR:    DEFB 0			; Foreground color
BAKCLR:    DEFB 7			; Background color
BDRCLR:    DEFB 7			; Border color
ELSE
ATRBYT:    DEFB 8+7			; Blue PAPER, white INK
FORCLR:    DEFB 7			; Foreground color
BAKCLR:    DEFB 1			; Background color
BDRCLR:    DEFB 1			; Border color
ENDIF
ELSE
ATRBYT:    DEFB 0
FORCLR:    DEFB 0			; Foreground color
BAKCLR:    DEFB 0			; Background color
BDRCLR:    DEFB 0			; Border color
ENDIF

ENDIF
ENDIF

CLOC:      DEFW 0			; Current screen address
CMASK:     DEFB 0			; Pixel mask for current screen address

IF ZXPLUS3
ALOC:    DEFW 0				; Current attribute address
ENDIF


;---------------------
__PRESET:
IF ZXPLUS3
		; The ZX Spectrum maps the color attributes on a full 8x8 square, thus
		; it is better to invert the single pixel rather than forcing the 
		; foreground color to the background color for the whole square.
		ld		de,0A62Fh    ; CPL - AND (HL)
		ld		(pixmode),de
		call	__PSET
		ld		de,182    ; OR (HL)
		ld		(pixmode),de
		ret
ELSE
		LD A,(BAKCLR)
		JR __PSET_0
ENDIF


;---------------------

__PSET:
        LD A,(FORCLR)             ; Get default color (PSET=foreground)
; This entry point is used by the routine at __PRESET.
__PSET_0:
        PUSH AF                   ; Save default color               ;SAVE DEFAULT ATTRIBUTE
        CALL SCAND                ; Get coordinates in BC, DE        ;SCAN A SINGLE COORDINATE
        POP AF                    ; Restore default color            ;GET BACK DEFAULT ATTRIBUTE
        CALL ATRENT               ; Get color, if specified          ;SCAN POSSIBLE ATTRIBUTE
        PUSH    HL                ; Save code string address         ;SAVE TEXT POINTER

;IF ZXPLUS3
;;
;ELSE
        CALL SCALXY               ;SCALE INTO BOUNDS
        JR NC,__PSET_1            ;NO PSET IF NOT IN BOUNDS
;ENDIF

        CALL MAPXY                ;MAP INTO A "C"           ; Find position in VRAM. CLOC=memory address, CMASK=color pixelmask
        CALL SETC                 ;ACTUALLY DO THE SET

__PSET_1:
        POP     HL                ; Restore code string address
        RET





;---------------------

;
; ALLOW A COORDINATE OF THE FORM (X,Y) OR STEP(X,Y)
; THE LATTER IS RELATIVE TO THE GRAPHICS AC.
; THE GRAPHICS AC IS UPDATED WITH THE NEW VALUE
; RESULT IS RETURNED WITH [B,C]=X AND [D,E]=Y
; CALL SCAN1 TO GET FIRST IN A SET OF TWO PAIRS SINCE IT ALLOWS
; A NULL ARGUMENT TO IMPLY THE CURRENT AC VALUE AND
; IT WILL SKIP A "@" IF ONE IS PRESENT
;

; Used by the routines at LINE, (__PAINT, __CIRCLE and PUT_SPRITE).
SCAN1:
  LD A,(HL)        ;GET THE CURRENT CHARACTER
  CP '@'           ;ALLOW MEANINGLESS "@"
  CALL Z,CHRGTB    ;BY SKIPPING OVER IT
  LD BC,$0000      ;ASSUME NO COODINATES AT ALL (-SECOND)
  LD D,B
  LD E,C
  CP TK_MINUS      ; "-", SEE IF ITS SAME AS PREVIOUS
  JR Z,SCANN       ;USE GRAPHICS ACCUMULATOR

;
; THE STANDARD ENTRY POINT
;

; This entry point is used by the routines at __PSET, __PRESET and FN_POINT.
SCAND:
  LD A,(HL)         ;GET THE CURRENT CHARACTER
  ;CP TK_MINUS       ; '-'
  CP TK_STEP		;IS IT RELATIVE?    ; If STEP is used, coordinates are interpreted relative to the current cursor position.
					                    ; In this case the values can also be negative.
  PUSH AF           ;REMEMBER
  CALL Z,CHRGTB     ;SKIP OVER $STEP TOKEN
  CALL SYNCHR
  DEFB '('          ;SKIP OVER OPEN PAREN
  CALL FPSINT_0     ;SCAN X INTO [D,E]
  PUSH DE           ;SAVE WHILE SCANNING Y
  CALL SYNCHR
  DEFB ','          ;SCAN COMMA
  CALL FPSINT_0     ;GET Y INTO [D,E]
  CALL SYNCHR
  DEFB ')'
  POP BC            ;GET BACK X INTO [B,C]
  POP AF            ;RECALL IF RELATIVE OR NOT

SCANN:
  PUSH HL           ;SAVE TEXT POINTER
  LD HL,(GRPACX)    ;GET OLD POSITION
  JR Z,SCXREL       ;IF ZERO,RELATIVE SO USE OLD BASE           ; JP if 'STEP' is specified
  LD HL,$0000       ;IN ABSOLUTE CASE, JUST Y USE ARGEUMENT
SCXREL:
  ADD HL,BC         ;ADD NEW VALUE
  LD (GRPACX),HL    ;UPDATE GRAPHICS ACCUMLATOR
  LD (GXPOS),HL     ;STORE SECOND COORDINTE FOR CALLER
  LD B,H            ;RETURN X IN BC
  LD C,L
  LD HL,(GRPACY)    ;GET OLDY POSITION
  JR Z,SCYRE        ;IF ZERO, RELATIVE SO USE OLD BASE          ; JP if 'STEP' is specified
  LD HL,$0000       ;ABSOLUTE SO OFFSET BY 0
SCYRE:
  ADD HL,DE
  LD (GRPACY),HL    ;UPDATE Y PART OF ACCUMULATOR
  LD (GYPOS),HL     ;STORE Y FOR CALLER
  EX DE,HL          ;RETURN Y IN [D,E]
  POP HL            ;GET BACK THE TEXT POINTER                  ; code string address


IF ZXPLUS3

IF BIOS20
  ld a,d
  and $FE	; 512 pixel max
  jp nz,FC_ERR
ELSE
  xor a
  or b
  or d
  jp nz,FC_ERR
ENDIF

  ld a,e
  cp 192
  jp nc,FC_ERR			; y0	out of range
ENDIF
  
  RET


;---------------------
__COLOR:
IF BIOS20
  JP FC_ERR
ELSE
  LD BC,FC_ERR
  PUSH BC
  LD DE,(FORCLR)
  PUSH DE
  CP ','
  JR Z,__COLOR_0
  CALL GETINT             ; Get integer 0-255
  POP DE
  CP $10		; 16 colors
  RET NC
  LD E,A
  PUSH DE
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__COLOR_2
__COLOR_0:
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JR Z,__COLOR_2
  CP ','
  JR Z,__COLOR_1
  CALL GETINT             ; Get integer 0-255
  POP DE
  CP $10		; 16 colors
  RET NC
  LD D,A
  PUSH DE
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,__COLOR_2
__COLOR_1:
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT             ; Get integer 0-255
  POP DE
IF ZXPLUS3
  CP 8
ELSE
  CP $10		; 16 colors
ENDIF
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
;IF ZXPLUS3
  CALL SETATR
;ELSE
;  LD (ATRBYT),A
;ENDIF
  CALL CHGCLR
  POP HL
  RET
ENDIF

;---------------------
TOTEXT:
;IF ZXPLUS3
;  LD A,27
;  CALL OUTDO  		; Output char to the current device
;  LD A,'e'			; show cursor
;  CALL OUTDO  		; Output char to the current device
;ENDIF
  RET



; #################################################################
IF USEVDP


OLDSCR:    DEFB 0
RG0SAV:    DEFB 0

TXTNAM:    DEFW 0		; SCREEN 0 name table
TXTCOL:    DEFW 0		; SCREEN 0 color table
TXTCGP:    DEFW $0800	; SCREEN 0 character pattern table
TXTATR:    DEFW 0		; SCREEN 0 Sprite Attribute Table
TXTPAT:    DEFW 0		; SCREEN 0 Sprite Pattern Table

T32NAM:    DEFW $1800	; SCREEN 1 name table
T32COL:    DEFW $2000	; SCREEN 1 color table
T32CGP:    DEFW 0		; SCREEN 1 character pattern table
T32ATR:    DEFW $1B00	; SCREEN 1 Sprite Attribute Table
T32PAT:    DEFW $3800	; SCREEN 1 Sprite Pattern Table

GRPNAM:    DEFW $1800	; SCREEN 2 name table
GRPCOL:    DEFW $2000	; SCREEN 2 color table
GRPCGP:    DEFW 0		; SCREEN 2 character pattern table
GRPATR:    DEFW $1B00	; SCREEN 2 Sprite Attribute Table
GRPPAT:    DEFW $3800	; SCREEN 2 Sprite Pattern Table

MLTNAM:    DEFW $0800	; SCREEN 3 name table
MLTCOL:    DEFW 0		; SCREEN 3 color table
MLTCGP:    DEFW 0		; SCREEN 3 character pattern table
MLTATR:    DEFW $1B00	; SCREEN 3 Sprite Attribute Table
MLTPAT:    DEFW $3800	; SCREEN 3 Sprite Pattern Table






IN_GFX_MODE:
  LD A,(SCRMOD)
  CP $02
  RET P
  JP FC_ERR			; Err $05 - "Illegal function call"





SCALXY:
  PUSH HL
  PUSH BC
  LD B,$01
  EX DE,HL
  LD A,H
  ADD A,A
  JR NC,_SCALXY_1
  LD HL,$0000
  JR _SCALXY_2

_SCALXY_1:
  LD DE,192
  CALL DCOMPR		; Compare HL with DE.
  JR C,_SCALXY_3
  EX DE,HL
  DEC HL

_SCALXY_2:
  LD B,$00
_SCALXY_3:
  EX (SP),HL
  LD A,H
  ADD A,A
  JR NC,_SCALXY_4
  LD HL,$0000
  JR _SCALXY_5

_SCALXY_4:
  LD DE,256
  CALL DCOMPR		; Compare HL with DE.
  JR C,_SCALXY_6
  EX DE,HL
  DEC HL

_SCALXY_5:
  LD B,$00
_SCALXY_6:
  POP DE
  CALL IN_GRP_MODE
  JR Z,_SCALXY_7
  SRL L
  SRL L
  SRL E
  SRL E
_SCALXY_7:
  LD A,B
  RRCA
  LD B,H
  LD C,L
  POP HL
  RET

MAPXY:
  PUSH BC
  CALL IN_GRP_MODE
  JR NZ,_MAPXY_1
  LD D,C
  LD A,C
  AND $07
  LD C,A
  LD HL,_MAPXY_0
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

_MAPXY_0:
  ADD A,B
  LD B,B
  JR NZ,_MAPXY_3
  EX AF,AF'
  INC B
  LD (BC),A

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it

_MAPXY_1:
  LD A,C
  RRCA

  LD A,$F0			; Mask and keep the left nibble
  JR NC,EVEN_BYTE		
  LD A,$0F			; Mask and keep the righe nibble
EVEN_BYTE:
  LD (CMASK),A

  LD A,C
_MAPXY_3:
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


IN_GRP_MODE:
  LD A,(SCRMOD)
  SUB $02
  RET



SETC:
  PUSH HL
  PUSH BC
  CALL IN_GRP_MODE
  CALL FETCHC			; Gets current cursor address and mask pattern
  JR NZ,_SETC_0
  PUSH DE
  CALL SETC_GFX
  POP DE
  POP BC
  POP HL
  RET

; Data block at 5776
_SETC_0:
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
  JP P,_SETC_1
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
_SETC_1:
  OR C
  CALL _WRTVRM
  POP BC
  POP HL
  RET





IF FORMTX
SCRMOD:    DEFB 2		; GRAPHICS mode
	defc VDP_DATA    = 1
	defc VDP_DATAIN  = 1
	defc VDP_CMD     = 2
ENDIF

IF FOREINSTEIN
SCRMOD:    DEFB 0		; TEXT mode
	defc VDP_DATA    = 8
	defc VDP_DATAIN  = 8
	defc VDP_CMD     = 9
ENDIF

IF FORMSX
SCRMOD:    DEFB 0		; TEXT mode
	defc VDP_DATA   = $98
	defc VDP_DATAIN = $98
	defc VDP_CMD    = $99
ENDIF

IF FORSVI
SCRMOD:    DEFB 0		; TEXT mode
	defc VDP_DATA    = $80
	defc VDP_DATAIN  = $84
	defc VDP_CMD     = $81
ENDIF

IF FORSPC1000
	defc VDP_DATA    = 0xc800
	defc VDP_DATAIN  = 0xc800
	defc VDP_CMD     = 0xc801
ENDIF

IF FORLM80C
	defc VDP_DATA    = 00110000b
	defc VDP_DATAIN  = 00110000b
	defc VDP_CMD     = 00110010b
ENDIF



_RDVRM:
  CALL _SETRD
  EX (SP),HL
  EX (SP),HL
  IN A,(VDP_DATAIN)
  RET

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

_SETRD:
  LD A,L
  DI
  OUT (VDP_CMD),A
  LD A,H
  AND $3F
  OUT (VDP_CMD),A
  EI
  RET




CHGCLR:
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

RESTORE_BORDER:
  LD A,(BDRCLR)
SETBORDER:
  LD B,A
  LD C,$07
  JP _WRTVDP



  ; --- START PROC SETC_GFX ---
SETC_GFX:
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
  JR Z,SETC_GFX_1
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  CP D
  JR Z,SETC_GFX_2
  PUSH AF
  LD A,B
  OR C
  CP $FF
  JR Z,SETC_GFX_4
  PUSH HL
  PUSH DE
  CALL SETC_GFX_2
  POP DE
  POP HL
  POP AF
  OR E
  JR SETC_GFX_5


; Routine at 6302
SETC_GFX_1:
  LD A,B
  CPL
  AND C

  DEFB $11              ; "LD DE,nn" to skip the next 2 instructions

SETC_GFX_2:
  LD A,B
  OR C

; This entry point is used by the routine at SETC_GFX_4.
SETC_GFX_3:
  LD DE,$2000
  ADD HL,DE
  JR SETC_GFX_5

; Routine at 6314
SETC_GFX_4:
  POP AF
  LD A,B
  CPL
  PUSH HL
  PUSH DE
  CALL SETC_GFX_3
  POP DE
  POP HL
  LD A,(ATRBYT)
  OR D
; This entry point is used by the routine at SETC_GFX_1.
SETC_GFX_5:
;  JP _WRTVRM



_WRTVRM:
  PUSH AF
  CALL _SETWRT
  EX (SP),HL
  EX (SP),HL
  POP AF
  OUT (VDP_DATA),A
  RET







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





; VDP section end
; #################################################################
ELSE
; #################################################################


;------------------------------------------------------------------------------

; ZX Spectrum stuff

; Used by the routines at SCALXY and _GRPPRT.
SCALXY:
  PUSH HL
  PUSH BC
  LD B,$01
  EX DE,HL
  LD A,H
  ADD A,A
  JR NC,_SCALXY_1
  LD HL,$0000
  JR _SCALXY_2

_SCALXY_1:
  LD DE,192
  CALL DCOMPR		; Compare HL with DE.
  JR C,_SCALXY_3
  EX DE,HL
  DEC HL

_SCALXY_2:
  LD B,$00
_SCALXY_3:
  EX (SP),HL
  LD A,H
  ADD A,A
  JR NC,_SCALXY_4
  LD HL,$0000
  JR _SCALXY_5

_SCALXY_4:
IF BIOS20
  LD DE,512
ELSE
  LD DE,256
ENDIF
  CALL DCOMPR		; Compare HL with DE.
  JR C,_SCALXY_6
  EX DE,HL
  DEC HL

_SCALXY_5:
  LD B,$00
_SCALXY_6:
  POP DE
;  CALL IN_GRP_MODE       ; Z if GRP (high resolution screen with 256×192 pixels)
;  JR Z,_SCALXY_7
;  SRL L
;  SRL L
;  SRL E
;  SRL E
;_SCALXY_7:
  LD A,B
  RRCA
  LD B,H
  LD C,L
  POP HL
  RET


IF BIOS20
; No color on ZX Spectrum in HRG mode
ELSE

CHGCLR:
IF ZXPLUS3


IF ZXLEC | ZXCSDISK
	ld		a,(ATRBYT)
	ld		hl, $5C8D	; ATTR_P
	call	p3_poke
ELSE

;IF DISKFACE
;	ld		a,(ATRBYT)
;	ld		($F998),a
;ELSE

IF HC2000
	; INK
	ld a,27
	CALL OUTDO
	ld a,73
	CALL OUTDO
	LD A,(FORCLR)
	add '0'
	CALL OUTDO

	; PAPER
	ld a,27
	CALL OUTDO
	ld a,80
	CALL OUTDO
	LD A,(BAKCLR)
	add '0'
	CALL OUTDO
ELSE

IF QUORUM | PINIX | ELWRO
IF PINIX
	ld a,27
	CALL OUTDO
	ld a,'P'
	CALL OUTDO
	ld a,(ATRBYT)
	CALL OUTDO
ELSE
	ld		a,(ATRBYT)
	ld		(CPJ_ATRBYT),a
ENDIF
ELSE

IF SCORPION

IF ELWRO
	ld		hl,$E000+6144		; This should never happen
ELSE
	ld		hl,$C000+6144
ENDIF
	ld		de,768
CHGCLR_SCORPION:
	ld		a,(ATRBYT)
	call	p3_poke
	inc		hl
	dec		de
	ld		a,d
	or		e
	jr		nz,CHGCLR_SCORPION

ELSE

	; INK
	ld a,27
	CALL OUTDO
	ld a,'b'
	CALL OUTDO
	ld hl,CLRTBL
	LD A,(FORCLR)
	; HL=HL+A
    add a,l    ; A = A+L
	ld l,a
	jr nc,foreptr
	inc h
foreptr:
	ld a,(hl)
	CALL OUTDO

	; PAPER
	ld a,27
	CALL OUTDO
	ld a,'c'
	CALL OUTDO
	ld hl,CLRTBL
	LD A,(BAKCLR)
	; HL=HL+A
    add a,l    ; A = A+L
	ld l,a
	jr nc,backptr
	inc h
backptr:
	ld a,(hl)
	CALL OUTDO

ENDIF
ENDIF
ENDIF
;ENDIF
ENDIF

	; BORDER
IF HC2000
	ld a,27
	CALL OUTDO
	ld a,81
	CALL OUTDO
	LD A,(BDRCLR)
	add '0'
	CALL OUTDO
ELSE
	LD	A,(BDRCLR)
	out	($FE),a
IF ELWRO
	ld ($D078),a
ENDIF

IF ZXASC
	LD	A,(BDRCLR)
	ld		hl,$FEA6
	call	p3_poke
ENDIF

IF ZXLEC | ZXCSDISK
	LD    A,(BDRCLR)
	rla
	rla
	rla
	ld    hl,$5C48
	call  p3_poke
ENDIF



ENDIF
	
	ret

; Color conversion table used only on the Spectrum +3
CLRTBL:
    defb 32,34,40,42,64,66,72,74
    defb 32,35,44,47,80,83,92,95

ELSE
	ret
ENDIF

ENDIF

;=====================================================================


FN_POINT:
        CALL CHRGTB		; Gets next character (or token) from BASIC text.

        LD DE,(GYPOS)		; Save GX, GY
        PUSH DE
        LD DE,(GXPOS)		; etc..
        PUSH DE
        LD DE,(GRPACY)
        PUSH DE
        LD DE,(GRPACX)
        PUSH DE


        CALL SCAND

;  CALL SCALXY
;  LD HL,$FFFF
;  JR NC,FN_POINT_0
;  CALL MAPXY
;  CALL READC
;  LD L,A
;  LD H,$00
;FN_POINT_0:


		;ld		a,e
		;cp		192
		;jp		nc,FC_ERR			; y0	out of range


        PUSH HL			; code string address


IF ZXPLUS3
		call	pointxy
		ld		hl,0
		jr		z,__POINT_0
		inc		l
ENDIF
	
__POINT_0:

		CALL MAKINT
        POP HL			; code string address

        POP DE
        LD (GRPACX),DE	; Restore GX, GY
        POP DE
        LD (GRPACY),DE	; etc..
        POP DE
        LD (GXPOS),DE
        POP DE
        LD (GYPOS),DE
;		CALL PASSA
		RET

        ;CALL CONIA
		;CALL MAKINT
        ;POP HL
        ;RET



;=====================================================================


SETATR:
	CP $10
	CCF
	RET C

IF ZXPLUS3
    ld      l,a
	ld		a,(BAKCLR)
	and     a	; clear CY
	rla
	rla
	rla
	rla
	ld      h,a
	rl      h ; Push FLASH bit on CY
	rra
	and     10111000b
	ld      h,a

	;ld		a,(FORCLR)
	ld		a,l
	cp      8
	jr      c,nobright
	set     6,h
nobright:
	and     7
	or      h
ENDIF

	LD (ATRBYT),A
	RET


;=====================================================================

;
; ATTRIBUTE SCAN
; LOOK AT THE CURRENT POSITION AND IF THERE IS AN ARGUMENT READ IT AS
; THE 8-BIT ATTRIBUTE VALUE TO SEND TO SETATR. IF STATEMENT HAS ENDED
; OR THERE IS A NULL ARGUMENT, SEND FORCLR  TO SETATR
;

ATRSCN:
  LD A,(FORCLR)
ATRENT:
  PUSH BC
  PUSH DE
  LD E,A
  ;CALL IN_GFX_MODE            ; "Illegal function call" if not in graphics mode
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,ATRFIN
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,ATRFIN
  CALL GETINT             ; Get integer 0-255
ATRFIN:
  LD A,E
  PUSH HL
  CALL SETATR           ; Set attribute byte
  JP C,FC_ERR           ; Err $05 - "Illegal function call"
  POP HL
  POP DE
  POP BC
  JP __CHRCKB           ; Gets current character (or token) from BASIC text.

;=====================================================================



; XCHGX EXCHANGES [B,C] WITH GXPOS
; XCHGY EXCHANGES [D,E] WITH GYPOS
; XCHGAC PERFORMS BOTH OF THE ABOVE

; NONE OF THE OTHER REGISTERS IS AFFECTED

; Routine at 22680
;
; Used by the routines at LINE and DOGRPH.
XCHGAC:
  CALL XCHGY

; This entry point is used by the routine at LINE.
XCHGX:
  PUSH HL
  PUSH BC
  LD HL,(GXPOS)
  EX (SP),HL
  LD (GXPOS),HL
  POP BC
  POP HL
  RET


;
; XDELT SETS [H,L]=ABS(GXPOS-[B,C]) AND SETS CARRY IF [B,C].GT.GXPOS
; ALL REGISTERS EXCEPT [H,L] AND [A,PSW] ARE PRESERVED
; NOTE: [H,L] WILL BE A DELTA BETWEEN GXPOS AND [B,C] - ADD 1 FOR AN X "COUNT"
;

; Used by the routines at LINE and DOGRPH.
XDELT:
  LD HL,(GXPOS)      ;GET ACCUMULATOR POSITION
  LD A,L
  SUB C 
  LD L,A             ;DO SUBTRACT INTO [H,L]
  LD A,H
  SBC A,B
  LD H,A

; This entry point is used by the routine at YDELT.
XDELT_0:
  RET NC             ;IF NO CARRY, NO NEED TO NEGATE COUNT

NEGHL:
  XOR A              ;STANDARD [H,L] NEGATE
  SUB L              ; Negate exponent
  LD L,A             ; Re-save exponent
  SBC A,H
  SUB L
  LD H,A
  SCF
  RET


;
; YDELT SETS [H,L]=ABS(GYPOS-[D,E]) AND SETS CARRY IF [D,E].GT.GYPOS
; ALL REGISTERS EXCEPT [H,L] AND [A,PSW] ARE PRESERVED
;

YDELT:
  LD HL,(GYPOS)
  ; HL=HL-DE
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JR XDELT_0


; XCHGY EXCHANGES [D,E] WITH GYPOS

XCHGY:
  PUSH HL
  LD HL,(GYPOS)
  EX DE,HL
  LD (GYPOS),HL
  POP HL
  RET



;=====================================================================

;
; LINE [(X1,Y1)]-(X2,Y2) [,ATTRIBUTE[,B[F]]]
; DRAW A LINE FROM (X1,Y1) TO (X2,Y2) EITHER
; 1. STANDARD FORM -- JUST A LINE CONNECTING THE 2 POINTS
; 2. ,B=BOXLINE -- RECTANGLE TREATING (X1,Y1) AND (X2,Y2) AS OPPOSITE CORNERS
; 3. ,BF= BOXFILL --  FILLED RECTANGLE WITH (X1,Y1) AND (X2,Y2) AS OPPOSITE CORNERS
;

LINE:


;  CP TK_MINUS       ; '-'
;  EX DE,HL
;  LD HL,(GR_X)
;  EX DE,HL
;  CALL NZ,SCAN1
;  PUSH BC
;  PUSH DE
;  RST SYNCHR
;  DEFB TK_MINUS     ; '-'


  CALL SCAN1        ;SCAN THE FIRST COORDINATE
  PUSH BC           ;SAVE THE POINT
  PUSH DE
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_MINUS		;MAKE SURE ITS PROPERLY SEPERATED   ; Token for '-'
  CALL SCAND        ;SCAN THE SECOND SET                ; Get coordinates in BC, DE
  CALL ATRSCN       ;SCAN THE ATTRIBUTE                 ;  Deals also with default color
  POP DE            ;GET BACK THE FIRST POINT
  POP BC            
  JR Z,DOLINE       ;IF STATEMENT ENDED ITS A NORMAL LINE
  
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'B'
  JP Z,BOXLIN

  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'F'			; 'BOX FILLED'

DOBOXF:
  PUSH HL             ;SAVE THE TEXT POINTER
  CALL SCALXY         ;SCALE FIRST POINT
  CALL XCHGAC         ;SWITCH POINTS
  CALL SCALXY         ;SCALE SECOND POINT
  CALL YDELT          ;SEE HOW MANY LINES AND SET CARRY
  CALL C,XCHGY        ;MAKE [D,E] THE SMALLEST Y
  INC HL              ;MAKE [H,L] INTO A COUNT
  PUSH HL             ;SAVE COUNT OF LINES
  CALL XDELT          ;GET WIDTH AND SMALLEST X
  CALL C,XCHGX        ;MAKE [B,C] THE SMALLEST X
  INC HL              ;MAKE [H,L] INTO A WIDTH COUNT
  PUSH HL             ;SAVE WIDTH COUNT
  CALL MAPXY          ;MAP INTO A "C"         (Set addresses for initial dot position)
  POP DE              ;GET WIDTH COUNT
  POP BC              ;GET LINE COUNT
BOXLOP:
  PUSH DE             ;SAVE WIDTH
  PUSH BC             ;SAVE NUMBER OF LINES
  CALL FETCHC         ;LOOK AT CURRENT C                  ; Save cursor
  PUSH AF             ;SAVE BIT MASK OF CURRENT "C"
  PUSH HL             ;SAVE ADDRESS
  
IF ZXPLUS3
IF !BIOS20
  ld hl,(ALOC)		; 'pixeladdress' result for attributes, saved by MAPXY
  push hl
ENDIF
ENDIF
  EX DE,HL            ;SET UP FOR NSETCX WITH COUNT
  CALL NSETCX         ;IN [H,L] OF POINTS TO SETC         ; Set horizontal screenpixels

IF ZXPLUS3
IF !BIOS20
  pop hl
  ld (ALOC),hl		; 'pixeladdress' result for attributes, saved by MAPXY
ENDIF
ENDIF
  POP HL              ;GET BACK STARTING C
  POP AF              ;ADDRESS AND BIT MASK
  CALL STOREC         ;SET UP AS CURRENT "C"              ; Restore cursor
  CALL DOWNC          ;MOVE TO NEXT LINE DOWN IN Y
  POP BC              ;GET BACK NUMBER OF LINES
  POP DE              ;GET BACK WIDTH
  DEC BC              ;COUNT DOWN LINES
  LD A,B              ;SEE IF ANY LEFT
  OR C
  JR NZ,BOXLOP        ;KEEP DRAWING MORE LINES
  POP HL              ;RESTORE TEXT POINTER
  RET


FETCHC:
  LD A,(CMASK)
  LD HL,(CLOC)
  RET

STOREC:
  LD (CMASK),A
  LD (CLOC),HL
  RET

  
DOLINE:
  PUSH BC                   ;SAVE COORDINATES
  PUSH DE
  PUSH HL                   ;SAVE TEXT POINTER
  CALL DOGRPH
  LD HL,(GRPACX)            ;RESTORE ORIGINAL SECOND COORDINATE
  LD (GXPOS),HL
  LD HL,(GRPACY)            ;FOR BOXLIN CODE
  LD (GYPOS),HL
  POP HL                    ;RESTORE TEXT POINTER
  POP DE
  POP BC
  RET
  
BOXLIN:
  PUSH HL            		;SAVE TEXT POINTER
  LD HL,(GYPOS)
  PUSH HL                   ;SAVE Y2
  PUSH DE                   ;SAVE Y1
  EX DE,HL                  ;MOVE Y2 TO Y1
  CALL DOLINE               ;DO TOP LINE
  POP HL                    ;MOVE Y1 TO Y2
  LD (GYPOS),HL
  EX DE,HL
  CALL DOLINE
  POP HL                    ;GET BACK Y2
  LD (GYPOS),HL             ;AND RESTORE
  LD HL,(GXPOS)             ;GET X2
  PUSH BC                   ;SAVE X1
  LD B,H                    ;SET X1=X2
  LD C,L
  CALL DOLINE
  POP HL
  LD (GXPOS),HL             ;SET X2=X1
  LD B,H                    ;RESTORE X1 TO [B,C]
  LD C,L
  CALL DOLINE
  POP HL                    ;RESTORE THE TEXT POINTER
  RET


;
; DOGRPH DRAWS A LINE FROM ([B,C],[D,E]) TO (GXPOS,GYPOS)
;

; Routine at 22844
; Used by the routines at LINE and DOGRPH_GRPAC.
DOGRPH:
  CALL SCALXY       ;CHEATY SCALING - JUST TRUNCATE FOR NOW
  CALL XCHGAC
  CALL SCALXY
  CALL YDELT         ;GET COUNT DIFFERENCE IN [H,L]
  CALL C,XCHGAC      ;IF CURRENT Y IS SMALLER NO EXCHANGE
  PUSH DE            ;SAVE Y1 COORDINATE
  PUSH HL            ;SAVE DELTA Y
  CALL XDELT
  EX DE,HL           ;PUT DELTA X INTO [D,E]
  LD HL,RIGHTC       ;ASSUME X WILL GO RIGHT
  JR NC,LINCN2
  LD HL,LEFTC
LINCN2:
  EX (SP),HL
  CALL DCOMPR		; Compare HL with DE.
  JR NC,DOGRPH_1
  LD (MINDEL+1),HL
  POP HL
  LD (MAXUPD+1),HL	; MAXUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  LD HL,DOWNC
  LD (MINUPD+1),HL	; MINUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  EX DE,HL
  JR DOGRPH_2

DOGRPH_1:
  EX (SP),HL
  LD (MINUPD+1),HL	; MINUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  LD HL,DOWNC
  LD (MAXUPD+1),HL	; MAXUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  EX DE,HL
  LD (MINDEL+1),HL	; The original ROM version uses a system variable.  We do SMC.
  POP HL
DOGRPH_2:
  POP DE
  PUSH HL
  CALL NEGHL
  LD (MAXDEL+1),HL	; The original ROM version uses a system variable.  We do SMC.
  CALL MAPXY		; Initialize CLOC, CMASK, etc..
  POP DE
  PUSH DE
  CALL DE_DIV2		; DE=DE/2
  POP BC
  INC BC
  JR DOGRPH_SEGMENT

; Routine at 22931
DOGRPH_3:
  POP HL
  LD A,B
  OR C
  RET Z
MAXUPD:
  CALL 0		; <- SMC, MAXUPD = JP nn for RIGHTC, LEFTC and DOWNC 

; This entry point is used by the routine at DOGRPH.
DOGRPH_SEGMENT:
  CALL SETC
  DEC BC
  PUSH HL
MINDEL:
  LD HL,0		; <- SMC
  ADD HL,DE
  EX DE,HL
MAXDEL:
  LD HL,0		; <- SMC
  ADD HL,DE
  JR NC,DOGRPH_3
  EX DE,HL
  POP HL
  LD A,B
  OR C
  RET Z
MINUPD:
  CALL 0		; <- SMC, MINUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  JR MAXUPD

; Routine at 22964
;
; "RR DE" - Used by the routines at DOGRPH, __CIRCLE and L5E66.
DE_DIV2:
  LD A,D
  OR A
  RRA
  LD D,A
  LD A,E
  RRA
  LD E,A
  RET





IF ZXPLUS3
;*****************************************
NSETCX:
  ld a,(CMASK)
  push af

NSETCX_LP:
  PUSH HL
  CALL SETC
  CALL RIGHTC
  POP HL

  DEC HL
  LD A,H
  OR L
  JR NZ,NSETCX_LP

  pop af
  ld (CMASK),a
  RET


;------------
SETC:
	push bc
	push de
	push hl

	ld		de,(CLOC)		; 'pixeladdress' result, saved by MAPXY
	;ld		a,(CMASK)

	ex		de,hl
	;ld		e,a
	call	p3_peek
	push	hl
	;ex de,hl
	ld		hl,pixelbyte
	ld		(hl),a
	;ld		a,e
	ld		a,(CMASK)
pixmode:
	or		(hl)
	nop
	pop		hl
	call	p3_poke

IF !BIOS20
; Now update color attribute for the plotted pixel
	ld		a,(ATRBYT)
	ld		hl,(ALOC)		; 'pixeladdress' result for attributes, saved by MAPXY
	call	p3_poke
ENDIF
	pop hl
	pop de
	pop bc
	ret



;------------
MAPXY:
	push bc
	push de
	push hl			       ; code string address
	
IF BIOS20
  ; BC=X, DE=Y
	ld	h,b
	ld	l,c

	call    pixeladdress
	ld (CLOC),de                ; store pixel address
	ld (CMASK),a                ; store pixel position in byte

ELSE
  ; BC=X, DE=Y
	ld	h,c
	ld	l,e

	push    hl					; keep x,y
	call    pixeladdress
	ld (CLOC),de                ; store pixel address
	ld (CMASK),a                ; store pixel position in byte
	pop     hl

	; Now deal with color attributes position
	ld	a,l
	ld  l,h
	ld	h,a

	srl l
	srl l
	srl l

	ld a,h
	rlca
	rlca
	ld h,a

	and $e0
	or l
	ld l,a

	ld a,h

IF !ELWRO

	and $03
IF SCORPION
	or $58+$80
ELSE
	or $58		; $5800 = color attributes
ENDIF
	ld h,a   

	ld (ALOC),hl		   ; Store attribute address
ENDIF

ENDIF

	pop hl			       ; code string address
	pop de
	pop bc
	ret



;------------
pointxy:

IF BIOS20
	push	bc
	push	de
	push	hl

  ; BC=X, DE=Y
	ld	h,b
	ld	l,c

	call    pixeladdress

	ex	de,hl
	ld e,a
	call p3_peek
	and e

	pop	hl
	pop	de
	pop	bc
	ret
ELSE
  ; BC=X, DE=Y

  ; BC=X, DE=Y
	ld		h,c
	ld		l,e

	push	bc
	push	de
	push	hl

	call	pixeladdress

	ex	de,hl
	ld e,a
	call p3_peek
	and e

	pop	hl
	pop	de
	pop	bc
	ret
ENDIF


;------------
pixeladdress:
IF BIOS20

;-----------------------------------------------
;HL,DE -> X,Y
	LD      A,E
	LD      B,A
	AND     A
	RRA
	SCF			; Set Carry Flag
	RRA
;	AND     A
	SCF		; <--  DFILE at $C000 rather than $4000
	RRA
	XOR     B
	AND     @11111000
	XOR     B
	LD      D,A
	LD      A,L

	bit		3,a
	jp		z,isfirst
	set		5,d
.isfirst
	rr h
	rra

	RLCA
	RLCA
	RLCA

	XOR     B
	AND     @11000111
	XOR     B
	RLCA
	RLCA
	LD      E,A
	LD      A,L
;-----------------------------------------------
ELSE
;H,L -> X,Y
	LD		A,L
	AND     A
	RRA
	SCF			; Set Carry Flag
	RRA
	AND     A
	RRA
	XOR     L
	AND     @11111000
	XOR     L
IF SCORPION
IF ELWRO
	OR $E0
ELSE
	OR      $80
ENDIF
ENDIF
	LD      D,A
	LD      A,H
	RLCA
	RLCA
	RLCA
	XOR     L
	AND     @11000111
	XOR     L
	RLCA
	RLCA
	LD      E,A
	LD      A,H
;-----------------------------------------------
ENDIF
	AND     @00000111
	XOR		@00000111

	ld		b,a
	ld		a,1
	jr		z, or_pix2		; pixel is at bit 0...
plot_pos:
	rlca
	djnz	plot_pos
or_pix2:

	RET



;------------
RIGHTC:
   LD A,(CMASK)
   rrca
   LD (CMASK),A
   ld hl,(CLOC)	; SCREEN address
   ret nc

IF BIOS20
   
   bit 5,h
   set 5,h
   jr z,rsetaddr
   res 5,h
   inc l
   ld a,l
   and $1f
   jr nz,rsetaddr
   dec l
;   ld a,$01
   set 5,h

rsetaddr:
   ld (CLOC),hl
   
ELSE

   inc hl
   ld (CLOC),hl

   ld a,(ALOC)	; LSB of ATTR address
   inc a
   ld (ALOC),a

ENDIF

   ret



;------------
LEFTC:
   LD A,(CMASK)
   rlca
   LD (CMASK),A
   ld hl,(CLOC)	; SCREEN address
   ret nc

IF BIOS20

   bit 5,h
   res 5,h
   jr nz,setaddr
   set 5,h
   ld a,l
   dec l
   and $1f
   jr nz,setaddr
   inc l
;   ld a,$80
   res 5,h

setaddr:
   ld (CLOC),hl

ELSE

   dec hl
   ld (CLOC),hl

   ld a,(ALOC)	; LSB of ATTR address
   dec a
   ld (ALOC),a

ENDIF

   ret



;------------

DOWNC:
   ld hl,(CLOC)
   call zx_pdown
   ld (CLOC),hl

IF !BIOS20
   ret c   ; no need to update the ATTR pointer if we're in the same 8px boundary

   push hl
   ld a,(ALOC)
   add a,$20
   ld (ALOC),a
   jr nc,ad_done
   ld a,(ALOC+1)
   inc a
   ld (ALOC+1),a
ad_done:
   pop hl
ENDIF
   ret


zx_pdown:
   inc h
   ld a,h
   and $07
   ccf		; CY set if we're still in the same 8px boundary
   ret nz

   ld a,h
   sub $08
   ld h,a
   
   ld a,l
   add a,$20
   ld l,a
   ret nc
   
   ld a,h
   add a,$08
   ld h,a
   ret

 

;*****************************************
ENDIF


ENDIF
ENDIF



;------------------------------------------------------------------------------

IF BIT_PLAY

TMPSOUND:  defw 0
OCTSAV:    defb 0
TMPSAV:    defb 10

__PLAY:
;  DI
  CALL SYNCHR
  DEFB '!'                ; LOAD!, new syntax in place of CLOAD, Eat '!'.

  CALL EVAL               ;EVALUATE STRING ARGUMENT
  PUSH HL                 ;SAVE TEXT POINTER

IF ZXPLUS3
  ld a,(BDRCLR)
  ld (SMC_PLAY1+1),a
  or 16
  ld (SMC_PLAY0+1),a
ENDIF

  CALL GSTRCU       ;get music string to be played, make sure it is a string
  CALL LOADFP       ;GET LENGTH & POINTER

  LD   B,C          ; Adjust string pointer..
  LD   C,D          ;  ..from 8K parameter format to Extended BASIC

  INC E


; play a melody
;
; Used by the routine at _MUSIC.
MUSIC:
  CALL ISCNTC
  LD A,(BC)
  INC BC
  DEC E
  JP Z,MUSIC_END
  CP ','                  ; Comma, space and '|' are equivalent separators
  JR Z,MUSIC
  CP '|'
  JR Z,MUSIC
  CP ' '
  JR Z,MUSIC
  CP 'A'
  JP C,SN_ERR
  RES 5,A
  CP 'O'
  JP Z,M_OCTAVE
  CP 'R'
  JP Z,M_PAUSE
  CP 'T'
  JP Z,M_TEMPO

  CP 'G'+1
  JP NC,SN_ERR
  SUB 'A'
  ADD A,A		; *2
  INC A			; +1
  LD D,A
  LD A,(BC)

  ; Extra syntax in MSX style
  CP '#'            ;CHECK FOR POSSIBLE SHARP
  JR Z,PLYSHARP     ;SHARP IT THEN

  CP '+'            ;"+" ALSO MEANS SHARP
  JR NZ,M_SHARP
PLYSHARP:
  INC BC
  INC D
  DEC E
M_SHARP:
  CP '-'            ;"-" MEANS FLAT
  JR NZ,M_FLAT
  INC BC
  DEC D
  DEC E
M_FLAT:
  LD A,(OCTSAV)
  ADD A,D
  LD D,A
  CALL M_NUMBER
  PUSH HL
  LD A,D
  EXX
  LD E,A
  LD D,$00
  LD HL,NOTE_TAB
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD (TMPSOUND),BC
  INC HL
  LD A,(HL)
  POP DE
  CALL DELAY
  OR A
  RR D
  RR E
  OR A
  RR D
  RR E
  OR A
  RR D
  RR E
  LD A,(TMPSAV)
  CALL DELAY
  OR A
  RR D
  RR E
  OR A
  RR D
  RR E
  CALL SOUND
  JP MUSIC

MUSIC_END:
  POP HL                    ;GET BACK SAVED TEXT POINTER
;  EI
  RET

M_OCTAVE:
  LD A,(BC)
  INC BC
  DEC E
  JP Z,MO_ERR
  CP '1'
  JP C,SN_ERR
  CP '5'
  JP NC,SN_ERR
  SUB '1'
  ADD A,A
  LD D,A
  ADD A,A
  ADD A,A
  ADD A,A
  SUB D
  LD (OCTSAV),A
  JP MUSIC

M_TEMPO:
  LD A,(BC)
  SUB '0'
  JP C,SN_ERR
  CP 10
  JP NC,SN_ERR
  LD L,A
  INC BC
  DEC E
  JR Z,M_TEMPO_0          ; Set the tempo (single digit)
  LD A,(BC)
  SUB '0'
  JR C,M_TEMPO_0          ; Set the tempo (single digit)
  CP 10
  JR NC,M_TEMPO_0         ; Set the tempo (single digit)
  LD H,A                  ; HL=HL*10
  LD A,L
  ADD A,A
  LD L,A
  ADD A,A
  ADD A,A
  ADD A,L
  ADD A,H
  LD L,A
  INC BC
  DEC E
  JR Z,M_TEMPO_0          ; Set the tempo (2 digits)
  LD A,(BC)
  SUB '0'
  JR C,M_TEMPO_0          ; Set the tempo (2 digits)
  CP 10
  JR NC,M_TEMPO_0         ; Set the tempo (2 digits)
  LD H,A                  ; HL=HL*10
  LD A,L
  ADD A,A
  LD L,A
  ADD A,A
  ADD A,A
  ADD A,L
  ADD A,H
  LD L,A
  INC BC
  DEC E                   ; Set the tempo (3 digits)

M_TEMPO_0:
  LD A,L
  OR A
  RRA
  OR A
  RRA
  INC A
  LD (TMPSAV),A
  JP MUSIC

M_PAUSE:
  CALL M_NUMBER
  PUSH HL
  EXX
  POP DE
  LD A,(TMPSAV)
  CALL DELAY
M_PAUSE_0:
  DEC DE
  LD B,$C0
M_PAUSE_1:
  NOP
  DJNZ M_PAUSE_1
  LD A,D
  OR E
  JR NZ,M_PAUSE_0
  EXX
  JP MUSIC

; Get decimal number value
M_NUMBER:
  LD HL,16
  LD A,(BC)
  SUB '0'
  RET C
  CP 10
  RET NC
  LD L,A
  LD H,$00
  INC BC
  DEC E
  RET Z
  LD A,(BC)
  SUB '0'
  RET C
  CP 10
  RET NC
  PUSH DE
  ADD HL,HL                  ; HL=HL*10
  LD D,H
  LD E,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  LD E,A
  LD D,$00
  ADD HL,DE
  POP DE
  INC BC
  DEC E
  RET

; Data block at 3007
NOTE_TAB:
  DEFB $CC,$CC,$08	; A flat

  DEFB $CA,$CA,$09	; A
  DEFB $BE,$BE,$09  ; B flat
  DEFB $B3,$B3,$0A  ; B
  DEFB $B3,$B3,$0A  ; -> 'B sharp' does not exist, compensate..
  DEFB $A9,$A9,$0A  ; C
  DEFB $9F,$9F,$0B  ; D flat
  DEFB $97,$97,$0C  ; D
  DEFB $8E,$8E,$0C  ; E flat
  DEFB $86,$86,$0D  ; E
  DEFB $86,$86,$0D  ; -> 'E sharp' does not exist, compensate..
  DEFB $7F,$7F,$0E  ; F
  DEFB $77,$77,$0F  ; G flat
  DEFB $71,$71,$10  ; G
  DEFB $6A,$6A,$11  ; A flat (G sharp)

  DEFB $64,$64,$12  ; A
  DEFB $5E,$5E,$13  ; B flat
  DEFB $59,$59,$14  ; B
  DEFB $59,$59,$14  ; -> 'B sharp' does not exist, compensate..
  DEFB $54,$54,$15  ; C
  DEFB $4F,$4F,$17  ; D flat
  DEFB $4B,$4B,$18  ; D
  DEFB $46,$47,$19  ; E flat
  DEFB $42,$43,$1B  ; E
  DEFB $42,$43,$1B  ; -> 'E sharp' does not exist, compensate..
  DEFB $3E,$3F,$1D  ; F
  DEFB $3A,$3B,$1E  ; G flat
  DEFB $37,$38,$20  ; G
  DEFB $34,$35,$22  ; A flat (G sharp)

  DEFB $31,$32,$24  ; A
  DEFB $2E,$2F,$25  ; B flat
  DEFB $2C,$2C,$29  ; B
  DEFB $2C,$2C,$29  ; -> 'B sharp' does not exist, compensate..
  DEFB $29,$2A,$2B  ; C
  DEFB $27,$27,$2E  ; D flat
  DEFB $25,$25,$30  ; D
  DEFB $23,$23,$33  ; E flat
  DEFB $21,$21,$36  ; E
  DEFB $21,$21,$36  ; -> 'E sharp' does not exist, compensate..
  DEFB $1F,$1F,$3A  ; F
  DEFB $1D,$1D,$3D  ; G flat
  DEFB $1C,$1B,$41  ; G
  DEFB $1A,$1A,$45  ; A flat (G sharp)

  DEFB $19,$18,$49  ; A
  DEFB $17,$17,$4D  ; B flat
  DEFB $16,$15,$52  ; B
  DEFB $16,$15,$52  ; -> 'B sharp' does not exist, compensate..
  DEFB $14,$14,$57  ; C
  DEFB $13,$13,$5C  ; D flat
  DEFB $12,$12,$61  ; D
  DEFB $11,$11,$67  ; E flat
  DEFB $10,$10,$6D  ; E
  DEFB $10,$10,$6D  ; -> 'E sharp' does not exist, compensate..
  DEFB $0F,$0F,$74  ; F
  DEFB $0E,$0E,$52  ; G flat
  DEFB $0D,$0D,$82  ; G
  DEFB $0C,$0C,$8A  ; A flat (G sharp)

; Routine at 3178
__SOUND:

  CALL SYNCHR
  DEFB '@'		; OUT@, new syntax in place of SOUND

IF ZXPLUS3
  ld a,(BDRCLR)
  ld (SMC_PLAY1+1),a
  or 16
  ld (SMC_PLAY0+1),a
ENDIF

  CALL GETINT
  OR A
  JR NZ,__SOUND_0
  INC A
__SOUND_0:
  EXX
  LD E,A
  LD D,$00
  CPL
  INC A
  LD C,A
  EXX

  CALL SYNCHR
  DEFB ','

  CALL GETINT
  EXX
  CALL DELAY
  LD B,$04
__SOUND_1:
  OR A
  RR D
  RR E
  DJNZ __SOUND_1
  INC DE
  EXX
  LD A,(HL)
  CP ','
  LD A,$00
  JR NZ,__SOUND_2
  INC HL
  CALL GETINT
__SOUND_2:
  EXX
  PUSH AF
  ADD A,C
  LD (TMPSOUND),A
  POP HL
  LD A,C
  SUB H
  LD (TMPSOUND+1),A

; Sound output
;
; Used by the routines at _SOUND, MUSIC, T_EDIT and CONSOLE_BEL.
SOUND:
  DI
SOUND_0:
  PUSH HL
  POP HL
  LD A,$00
  LD HL,(TMPSOUND)
SOUND_1:
  CALL DELAY_2
  DEC L
  JP NZ,SOUND_1
SMC_PLAY0:
  LD A,16
IF ZXPLUS3
  OUT ($FE),A             ; turn audio bit on
ELSE
  OUT ($AF),A             ; turn audio bit on
ENDIF
  DEC DE
  CALL DELAY_3
  CALL DELAY_4
SOUND_2:
  CALL DELAY_2
  DEC H
  JP NZ,SOUND_2
SMC_PLAY1:
  LD A,$00
IF ZXPLUS3
  OUT ($FE),A             ; turn audio bit off
ELSE
  OUT ($AF),A             ; turn audio bit off
ENDIF
  LD A,D
  OR E
  JP NZ,SOUND_0
  EI
  EXX
  RET

; Delay stubs
;
; Used by the routines at MUSIC and __SOUND.
DELAY:
  LD B,$08
  LD HL,$0000
DELAY_0:
  RRCA
  JR NC,DELAY_1
  ADD HL,DE
DELAY_1:
  OR A
  RL E
  RL D
  DJNZ DELAY_0
  EX DE,HL
  RET

; This entry point is used by the routine at SOUND.
DELAY_2:
  EX (SP),HL
  EX (SP),HL
; This entry point is used by the routine at SOUND.
DELAY_3:
  NOP
; This entry point is used by the routine at SOUND.
DELAY_4:
  RET

ENDIF



;------------------------------------------------------------------------------



IF HAVE_GFX

;GRPRST resets graphics.  It is called at CLEARC and during INIT
;Entry - none
;Exit  - all registers preserved
;
GRPRST:
  PUSH AF
  PUSH BC
  PUSH HL
  XOR A
  LD (DRWSCL),A          ;Draw scale init
  LD (DRWANG),A          ;Draw angle init
;  CALL GRPINI            ;Center the graphics cursor
  LD HL,255/2
  LD (GRPACX),HL
  LD HL,192/2
  LD (GRPACY),HL

  LD A,(FORCLR)          ;Get foreground/(background) colors
  CALL SETATR            ;Set the default DRAW color
  
  POP HL
  POP BC
  POP AF
  RET



;;GRPINI - center the graphics cursor.
;; This routine has been documented to OEMs for versions of GW BASIC which are translated to ASM86.
;;Entry - none
;;Exit  - none
;;
;
;GRPINI:
;  CALL GRPSIZ             ;Get screen pixel dimensions
;  PUSH BC                 ;B,C has X dimension
;  POP HL                  ;Move X dimension to H
;  INC HL                  ;Adjust for zero relative
;  SRL H
;  RR L
;  LD (GRPACX),HL          ;Store as previous position
;  PUSH DE                 ;D,E has Y dimension
;  POP HL                  ;Move Y dimension to H
;  INC HL
;  SRL H
;  RR L
;  LD (GRPACY),HL          ;Store as previous position
;  RET	
;	
;
;GRPSIZ:
;  LD BC,255
;  LD DE,192
;  RET






;
;       CIRCLE - DRAW A CIRCLE
;
; SYNTAX: CIRCLE @(X,Y),RADIUS[,ATRB[,+/-STARTANG[,+/-ENDANG[,ASPECT]]]]
;

__CIRCLE:
  CALL SCAN1            ;GET (X,Y) OF CENTER INTO GRPACX,Y
  CALL SYNCHR
  DEFB ','              ;EAT COMMA
  CALL FPSINT_0         ;GET THE RADIUS
  PUSH HL               ;SAVE TXTPTR
  EX DE,HL
  LD (GXPOS),HL         ;SAVE HERE TILL START OF MAIN LOOP
  CALL MAKINT           ;PUT INTEGER INTO FAC
  CALL __CSNG           ;CONVERT TO SINGLE PRECISION
  LD BC,$7040           ;LOAD REGS WITH SQR(2)/2   (BCDE = 0.707107)
  LD DE,$0771
  CALL FMULT            ;DO FLOATING PT MULTIPLY
  CALL __CINT           ;CONVERT TO INTEGER & GET INTO [HL]
  LD (CNPNTS),HL        ;CNPNTS=RADIUS*SQR(2)/2=# PTS TO PLOT
  XOR A                 ;ZERO OUT CLINEF - NO LINES TO CENTER
  LD (CLINEF),A
  LD (CSCLXY),A         ;INITIALLY SCALING Y
  POP HL                ;REGET TXTPTR
  CALL ATRSCN           ;SCAN POSSIBLE ATTRIBUTE
  LD C,$01              ;SET LO BIT IN CLINEF FOR LINE TO CNTR
  LD DE,$0000           ;DEFAULT START COUNT = 0
  CALL CGTCNT           ;PARSE THE BEGIN ANGLE
  PUSH DE               ;SAVE COUNT FOR LATER COMPARISON
  LD C,$80              ;SET HI BIT IN CLINEF FOR LINE TO CNTR
  LD DE,$FFFF           ;DEFAULT END COUNT = INFINITY
  CALL CGTCNT           ;PARSE THE END ANGLE
  EX (SP),HL            ;GET START COUNT, PUSH TXTPTR TILL DONE
  XOR A
  EX DE,HL              ;REVERSE REGS TO TEST FOR .LT.
  CALL DCOMPR            ;SEE IF END .GE. START
  LD A,$00
  JR NC,CSTPLT          ;YES, PLOT POINTS BETWEEN STRT & END
  DEC A                 ;PLOT POINTS ABOVE & BELOW
  EX DE,HL              ;SWAP START AND END SO START .LT. END
  PUSH AF               ;Swap sense of center line flags
  LD A,(CLINEF)
  LD C,A
  RLCA
  RLCA
  OR C
  RRCA
  LD (CLINEF),A         ;Store swapped flags
  POP AF
CSTPLT:
  LD (CPLOTF),A         ;SET UP PLOT POLARITY FLAG
  LD (CSTCNT),DE        ;STORE START COUNT
  LD (CENCNT),HL        ;AND END COUNT
  POP HL                ;GET TXTPTR
  DEC HL                ;NOW SEE IF LAST CHAR WAS A COMMA
  CALL CHRGTB
  JR NZ,CIRC1           ;SOMETHING THERE
  PUSH HL               ;SAVE TXTPTR
  CALL GTASPC           ;GET DEFAULT ASPECT RATIO INTO [HL]
  LD A,H
  OR A                  ;IS ASPECT RATIO GREATER THAN ONE?
  JR Z,CIRC2            ;BRIF GOOD ASPECT RATIO
  LD A,$01
  LD (CSCLXY),A
  EX DE,HL              ;ASPECT RATIO IS GREATER THAN ONE, USE INVERSE
  JR CIRC2              ;NOW GO CONVERT TO FRACTION OF 256

CIRC1:
  CALL SYNCHR
  DEFB ','              ;EAT COMMA
  CALL EVAL
  PUSH HL               ;SAVE TXTPTR
  CALL __CSNG           ;MAKE IT FLOATING POINT
  CALL SIGN                ; test FP number sign
  JP Z,FC_ERR              ; Err $05 - "Illegal function call"
  JP M,FC_ERR              ; Err $05 - "Illegal function call"
  CALL CMPONE           ;SEE IF GREATER THAN ONE
  JR NZ,__CIRCLE_2      ;LESS THAN ONE - SCALING Y
  INC A                 ;MAKE [A] NZ
  LD (CSCLXY),A         ;FLAG SCALING X
  CALL FDIV             ;RATIO = 1/RATIO
__CIRCLE_2:

  ;LD BC,$			;MAKE NUMBER FRACTION OF 256   (BCDE = 256 (float))
  ;LD DE,$
  ;CALL FMULT            ;BY MULTIPLYING BY 2^8 (256)
  LD HL,FPEXP
  ld a,(hl)
  add 8                  ;ADD 8 TO EXPONENT
  ld (hl),a

  CALL __CINT           ;MAKE IT AN INTEGER IN [HL]
CIRC2:
  LD (ASPECT),HL        ;STORE ASPECT RATIO

;
;       CIRCLE ALGORITHM
;
;       [HL]=X=RADIUS * 2 (ONE BIT FRACTION FOR ROUNDING)
;       [DE]=Y=0
;       SUM =0
; LOOP: IF Y IS EVEN THEN
;             REFLECT((X+1)/2,(Y+1)/2) (I.E., PLOT POINTS)
;             IF X.LT.Y THEN EXIT
;       SUM=SUM+2*Y+1
;       Y=Y+1
;       IF SUM.GGWGRP.RNO
;             SUM=SUM-2*X+1
;             X=X-1
;       ENDIF
;       GOTO LOOP
;

  LD DE,$0000           ;INIT Y = 0
  LD (CRCSUM),DE        ;SUM = 0
  LD HL,(GXPOS)         ;X = RADIUS*2
  ADD HL,HL

CIRCLP:
  CALL ISCNTC
  LD A,E                ;TEST EVENNESS OF Y
  RRA                   ;TO SEE IF WE NEED TO PLOT
  JR C,CRCLP2           ;Y IS ODD - DON'T TEST OR PLOT
  PUSH DE               ;SAVE Y AND X
  PUSH HL
  INC HL                ;ACTUAL COORDS ARE (X+1)/2,(Y+1)/2
  EX DE,HL              ;(PLUS ONE BEFORE DIVIDE TO ROUND UP)
  CALL DE_DIV2		; "RR DE"
  EX DE,HL
  INC DE
  CALL DE_DIV2		; "RR DE"
  CALL CPLOT8
  POP DE                ;RESTORE X AND Y
  POP HL                ;INTO [DE] AND [HL] (BACKWARDS FOR CMP)
  CALL DCOMPR            ;QUIT IF Y .GE. X
  JP NC,MC_POPTRT        ;GO POP TXTPTR AND QUIT
  EX DE,HL
CRCLP2:
  LD B,H                ;GET OFFSETS INTO PROPER REGISTERS
  LD C,L                ;[BC]=X
  LD HL,(CRCSUM)
  INC HL                ;SUM = SUM+2*Y+1
  ADD HL,DE
  ADD HL,DE
  LD A,H                ;NOW CHECK SIGN OF RESULT
  ADD A,A
  JR C,CNODEX           ;DON'T ADJUST X IF WAS NEGATIVE
  PUSH DE               ;SAVE Y
  EX DE,HL              ;[DE]=SUM
  LD H,B                ;[HL]=X
  LD L,C
  ADD HL,HL             ;[HL]=2*X-1
  DEC HL
  EX DE,HL              ;PREPARE TO SUBTRACT
  OR A
  SBC HL,DE             ;CALC SUM-2*X+1
  DEC BC                ;X=X-1
  POP DE                ;GET Y BACK
CNODEX:
  LD (CRCSUM),HL        ;UPDATE CIRCLE SUM
  LD H,B                ;GET X BACK TO [HL]
  LD L,C
  INC DE                ;Y=Y+1
  JR CIRCLP


GTASPC:
  LD HL,(ASPCT1)
  EX DE,HL
  LD HL,(ASPCT2)
  RET

CPLSCX:
  PUSH DE
  CALL SCALEY
  POP HL                ;GET UNSCALED INTO [HL]
  LD A,(CSCLXY)         ;SEE WHETHER ASPECT WAS .GT. 1
  OR A 
  RET Z
  EX DE,HL
  RET                   ;DON'T SWAP IF ZERO

; Used by the routine at CPLSCX.
SCALEY:
  LD HL,(ASPECT)        ;SCALE [DE] BY ASPECT RATIO
  LD A,L                ;CHECK FOR *0 AND *1 CASES
  OR A                  ;ENTRY TO DO [A]*[DE] ([A] NON-Z)
  JR NZ,SCAL2           ;NON-ZERO
  OR H                  ;TEST HI BYTE
  RET NZ                ;IF NZ, THEN WAS *1 CASE
  EX DE,HL              ;WAS *0 CASE - PUT 0 IN [DE]
  RET

SCAL2:
  LD C,D
  LD D,$00
  PUSH AF
  CALL SCL_MULTIPLY
  LD E,$80              ; ROUND UP
  ADD HL,DE
  LD E,C
  LD C,H
  POP AF
  CALL SCL_MULTIPLY
  LD E,C
  ADD HL,DE
  EX DE,HL
  RET

; Used by the routine at SCALEY.
SCL_MULTIPLY:
  LD B,$08
  LD HL,$0000
SCL_MULTIPLY_0:
  ADD HL,HL
  ADD A,A
  JR NC,SCL_MULTIPLY_1
  ADD HL,DE
SCL_MULTIPLY_1:
  DJNZ SCL_MULTIPLY_0
  RET

;
; REFLECT THE POINTS AROUND CENTER
; [HL]=X OFFSET FROM CENTER, [DE]=Y OFFSET FROM CENTER
;

; Routine at 23558
;
; Used by the routine at __CIRCLE.
CPLOT8:
  LD (CPCNT),DE         ;POINT COUNT IS ALWAYS = Y
  PUSH HL               ;SAVE X
  LD HL,$0000           ;START CPCNT8 OUT AT 0
  LD (CPCNT8),HL
  CALL CPLSCX           ;SCALE Y AS APPROPRIATE
  LD (CXOFF),HL         ;SAVE CXOFF
  POP HL                ;GET BACK X
  EX DE,HL
  PUSH HL               ;SAVE INITIAL [DE]
  CALL CPLSCX           ;SCALE X AS APPROPRIATE
  LD (CYOFF),DE
  POP DE                ;GET BACK INITIAL [DE]
  CALL NEGDE            ;START: [DE]=-Y,[HL]=X,CXOFF=Y,CY=X

  CALL CPLOT4           ;PLOT +X,-SY -Y,-SX -X,+SY +Y,-SX

  PUSH HL
  PUSH DE
  LD HL,(CNPNTS)        ;GET # PNTS PER OCTANT
  LD (CPCNT8),HL        ;AND SET FOR DOING ODD OCTANTS
  LD DE,(CPCNT)         ;GET POINT COUNT
  OR A
  SBC HL,DE             ;ODD OCTANTS ARE BACKWARDS SO
  LD (CPCNT),HL         ;PNTCNT = PNTS/OCT - PNTCNT
  LD HL,(CXOFF)         ;NEED TO NEGATE CXOFF TO START OUT RIGHT
  CALL NEGHL
  LD (CXOFF),HL
  POP DE
  POP HL
  CALL NEGDE            ;ALSO NEED TO MAKE [DE]=-SX=-[DE]
                        ;PLOT +Y,-SX -X,-SY -Y,+SX +X,+SY
                        ;(FALL THRU TO CPLOT4)
CPLOT4:
  LD A,$04              ;LOOP FOUR TIMES
CPLOT:
  PUSH AF               ;SAVE LOOP COUNT
  PUSH HL               ;SAVE BOTH X & Y OFFSETS
  PUSH DE
  PUSH HL               ;SAVE TWICE
  PUSH DE
  LD DE,(CPCNT8)        ;GET NP*OCTANT*8
  LD HL,(CNPNTS)        ;ADD SQR(2)*RADIUS FOR NEXT OCTANT
  ADD HL,HL
  ADD HL,DE
  LD (CPCNT8),HL        ;UPDATE FOR NEXT TIME
  LD HL,(CPCNT)         ;CALC THIS POINT'S POINT COUNT
  ADD HL,DE             ;ADD IN PNTCNT*OCTANT*NP
  EX DE,HL              ;SAVE THIS POINT'S COUNT IN [DE]
  LD HL,(CSTCNT)        ;GET START COUNT
  CALL DCOMPR
  JR Z,CLINSC           ;SEE IF LINE TO CENTER REQUIRED
  JR NC,CNBTWN          ;IF SC .GT. PC, THEN NOT BETWEEN
  LD HL,(CENCNT)        ;GET END COUNT
  CALL DCOMPR
  JR Z,CLINEC           ;GO SEE IF LINE FROM CENTER NEEDED
  JR NC,CBTWEN          ;IF EC .GT. PC, THEN BETWEEN

CNBTWN:
  LD A,(CPLOTF)         ;SEE WHETHER TO PLOT OR NOT
  OR A                  ;IF NZ, PLOT POINTS NOT IN BETWEEN
  JR NZ,CPLTIT          ;NEED TO PLOT NOT-BETWEEN POINTS
  JR GCPLFN             ;DON'T PLOT - FIX UP STACK & RETURN

CLINEC:
  LD A,(CLINEF)         ;GET CENTER LINE FLAG BYTE
  ADD A,A               ;BIT 7=1 MEANS DRAW LINE FROM CENTER
  JR NC,CPLTIT          ;NO LINE REQUIRED - JUST PLOT POINT
  JR CLINE              ;LINE REQUIRED.

CLINSC:
  LD A,(CLINEF)         ;GET CENTER LINE FLAG BYTE
  RRA                   ;BIT 0=1 MEANS LINE FROM CENTER NEEDED.
  JR NC,CPLTIT          ;NO LINE REQUIRED - JUST PLOT POINT

CLINE:
  POP DE                ;GET X & Y OFFSETS
  POP HL
  CALL GTABSC           ;GO CALC TRUE COORDINATE OF POINT
  CALL CLINE2           ;DRAW LINE FROM [BC],[DE] TO CENTER
  JR CPLFIN
  
CBTWEN:
  LD A,(CPLOTF)         ;SEE WHETHER PLOTTING BETWEENS OR NOT
  OR A
  JR Z,CPLTIT           ;IF Z, THEN DOING BETWEENS
GCPLFN:
  POP DE                ;CLEAN UP STACK
  POP HL
  JR CPLFIN

CPLTIT:
  POP DE                ;GET X & Y OFFSETS
  POP HL
  CALL GTABSC           ;CALC TRUE COORDINATE OF POINT
  CALL SCALXY           ;SEE IF POINT OFF SCREEN
  JR NC,CPLFIN          ;NC IF POINT OFF SCREEN - NO PLOT
  CALL MAPXY
  CALL SETC             ;PLOT THE POINT
CPLFIN:
  POP DE                ;GET BACK OFFSETS
  POP HL
  POP AF                ;GET BACK LOOP COUNT
  DEC A
  RET Z                 ;QUIT IF DONE.
  PUSH AF               ; PUSH PSW
  PUSH DE               ;SAVE X OFFSET
  LD DE,(CXOFF)         ;SWAP [HL] AND CXOFF
  CALL NEGDE            ;NEGATE NEW [HL]
  LD (CXOFF),HL         ;SWAP [DE] AND CYOFF
  EX DE,HL              ;NEGATE NEW [DE]
  POP DE
  PUSH HL
  LD HL,(CYOFF)
  EX DE,HL
  LD (CYOFF),HL
  CALL NEGDE
  POP HL
  POP AF                ; POP PSW
  JP CPLOT              ;PLOT NEXT POINT


;
; PARSE THE BEGIN AND END ANGLES
;  SETTING APPROPRIATE BITS IN CLINEF IF NEG.
;

; Routine at 23831
; Used by the routine at __CIRCLE.
CGTCNT:
  DEC HL
  CALL CHRGTB            ;GET CURRENT CHAR
  RET Z                 ;IF NOTHING, RETURN DFLT IN [DE]
  CALL SYNCHR
  DEFB ','              ;EAT THE COMMA
  CP ','                ;USE DEFAULT IF NO ARGUMENT.
  RET Z
  PUSH BC               ;SAVE FLAG BYTE IN [C]
  CALL EVAL             ;EVALUATE THE THING   ('FRMEVL' in GW-BASIC, 'EVAL' on MSX)
  EX (SP),HL            ;POP FLAG BYTE, PUSH TXTPTR
  PUSH HL               ;RESAVE FLAG BYTE
  CALL __CSNG           ;MAKE IT A SINGLE PRECISION VALUE
  POP BC                ;GET BACK FLAG BYTE
  LD HL,FACCU           ;NOW SEE WHETHER POSITIVE OR NOT
  LD A,(HL)             ;GET EXPONENT BYTE
  OR A
  JP P,CGTCNT_0
  AND $7F               ;MAKE IT POSITIVE
  LD (HL),A
  LD HL,CLINEF          ;SET BIT IN [C] IN CLINEF
  LD A,(HL)
  OR C
  LD (HL),A

CGTCNT_0:
  LD BC,$7E22           ;LOAD REGS WITH 1/2*PI  (BCDE = 0.159155)
  LD DE,$F983
  CALL FMULT            ;MULTIPLY BY 1/(2*PI) TO GET FRACTION
  CALL CMPONE           ;SEE IF RESULT IS GREATER THAN ONE
  JP Z,FC_ERR			;FC ERROR IF SO   (Err $05 - "Illegal function call")
  CALL PUSHF            ;SAVE FAC ON STAC
  LD HL,(CNPNTS)        ;GET NO. OF POINTS PER OCTANT
  ADD HL,HL             ;TIMES 8 FOR TRUE CIRCUMFERENCE
  ADD HL,HL
  ADD HL,HL
  CALL MAKINT           ;STICK IT IN FAC
  CALL __CSNG           ;AND MAKE IT SINGLE PRECISION
  POP BC                ;GET BACK ANG/2*PI IN REGS
  POP DE
  CALL FMULT            ;DO THE MULTIPLY
  CALL __CINT           ;CONVERT TO INTEGER IN [HL]
  POP DE                ;GET BACK TXTPTR
  EX DE,HL
  RET


; Used by the routines at __CIRCLE and CGTCNT.
CMPONE:
  LD BC,$8100           ;MAKE SURE FAC IS LESS THAN ONE  ..BCDE = 1 (float)
  LD D,C
  LD E,C
  CALL FCOMP
  DEC A
  RET




; DATA AREA FOR CIRCLE STATEMENT
ASPECT: defw 0            ; Aspect ratio of the circle; set by <ratio> of CIRCLE
CENCNT: defw 0            ; End count
CLINEF: defb 0            ; Flag to draw line to centre
CNPNTS: defw 0            ; Points to be plottted
CPLOTF: defb 0            ; Plot polarity flag
CPCNT:  defw 0            ;  1/8 of number of points in circle
CPCNT8: defw 0            ; 
CRCSUM: defw 0            ; CIRCLE sum
CSTCNT: defw 0            ; CIRCLE start count
CSCLXY: defb 0            ; Scale of X & Y

CXOFF:  defw 0            ; X offset from center
CYOFF:  defw 0            ; Y offset from center

ASPCT1:  defw $0100       ;2 Horizontal / Vertical aspect for CIRCLE command 
ASPCT2:  defw $0100       ;2 Horizontal / Vertical aspect for CIRCLE command 



DRWSCL: defb 0            ;DRAW: SCALE           DRAW POS,2 ling factor
DRWFLG: defb 0            ;DRAW flag
DRWANG: defb 0            ;DRAW "ANGLE" (0..3)   DRAW translation angle




; "LINE@" is used to replace "DRAW" (I ran out of tokens !)
; Microsoft refers to it as "GML", Graphics Macro Language

__DRAW:
  LD DE,DRAW_TAB        ;DISPATCH TABLE FOR GML
  XOR A
  LD (DRWFLG),A
;  LD (MCLFLG),A
  JP MACLNG

; JP table for the Graphics Macro Language (GML)
DRAW_TAB:

  DEFB 'U'+$80  ;UP
  DEFW DRUP     ; Draw a line of <DE> pixels in a straight upward direction

  DEFB 'D'+$80  ;DOWN
  DEFW DRDOWN	; Draw a line of <DE> pixels in a straight downward direction

  DEFB 'L'+$80  ;LEFT
  DEFW DRLEFT	; Draw a line of <DE> pixels to the left

  DEFB 'R'+$80  ;RIGHT
  DEFW DRIGHT	; Draw a line of <DE> pixels to the right

  DEFB 'M'		;MOVE
  DEFW DMOVE	; Draw a line to a specific location (x,y) or a location relative to the current position (M+20,-20)

  DEFB 'E'+$80	; -,-
  DEFW DRWEEE	; Draw a diagonal line of <DE> pixels (line goes upward and to the right)

  DEFB 'F'+$80	; +,-
  DEFW DRWFFF	; Draw a diagonal line of <DE> pixels (line goes downward and to the right)

  DEFB 'G'+$80	; +,+
  DEFW DRWGGG	; Draw a diagonal line of <DE> pixels (line goes downward and to the left)

  DEFB 'H'+$80	; -,+
  DEFW DRWHHH	; Draw a diagonal line of <DE> pixels (line goes upward and to the left)

  DEFB 'A'+$80  ;ANGLE COMMAND
  DEFW DANGLE	; Change the orientation of the drawing to 0 (normal), 1 (90 degrees clockwise), 2 (180 degrees clockwise) or 3 (270 degrees clockwise)

  DEFB 'B'      ;MOVE WITHOUT PLOTTING
  DEFW DNOPLT	; Move to the location specified by the command, but don't draw a line 

  DEFB 'N'      ;DON'T CHANGE CURRENT COORDS
  DEFW DNOMOV	; Return to the starting position after performing the command 

  DEFB 'X'      ;EXECUTE STRING
  DEFW MCLXEQ	; X<string> Execute a sub-string of instructions 

  DEFB 'C'+$80  ;COLOR
  DEFW DCOLR	; Change the foreground (drawing) color to <color>
  
  DEFB 'S'+$80  ;SCALE
  DEFW DSCALE	; S<scale> Scale every length specified after this command by <scale/4> pixels.
 
  DEFB $00		;END OF TABLE   (Table termination)


; -- -- -- -- -- --

  
NEGDE:
  EX DE,HL
  CALL NEGHL
  EX DE,HL
  RET


CLINE2:
  LD HL,(GRPACX)        ;DRAW LINE FROM [BC],[DE]
  LD (GXPOS),HL         ;TO GRPACX,Y
  LD HL,(GRPACY)
  LD (GYPOS),HL
  JP DOGRPH             ;GO DRAW THE LINE


;
; GTABSC - GET ABSOLUTE COORDS
; ([BC],[DE])=(GRPACX+[HL],GRPACY+[DE])
;
; Used by the routines at CPLOT8 and DMOVE.
GTABSC:
  PUSH DE               ;SAVE Y OFFSET FROM CENTER
  LD DE,(GRPACX)        ;GET CENTER POS
  ADD HL,DE             ;ADD TO DX
  LD B,H                ;[BC]=X CENTER + [HL]
  LD C,L
  POP DE
  LD HL,(GRPACY)        ;GET CENTER Y
  ADD HL,DE
  EX DE,HL              ;[DE]=Y CENTER + [DE]
  RET

; -- -- -- -- -- --
  
;MOVE +0,-Y
; Draw a line of <DE> pixels in a straight upward direction
DRUP:
  CALL NEGDE

;MOVE +0,+Y
; Draw a line of <DE> pixels in a straight downward direction
DRDOWN:
  LD BC,$0000     ;DX=0
  JR DOMOVR       ;TREAT AS RELATIVE MOVE


;MOVE -X,+0
; Draw a line of <DE> pixels to the left
DRLEFT:
  CALL NEGDE

;MOVE +X,+0
; Draw a line of <DE> pixels to the right
DRIGHT:
  LD B,D          ;[BC]=VALUE
  LD C,E
  LD DE,$0000     ;DY=0
  JR DOMOVR       ;TREAT AS RELATIVE MOVE

;MOVE -X,-Y
; Draw a diagonal line of <DE> pixels (line goes upward and to the left)
DRWHHH:
  CALL NEGDE

;MOVE +X,+Y
; Draw a diagonal line of <DE> pixels (line goes downward and to the right)
DRWFFF:
  LD B,D
  LD C,E
  JR DOMOVR

;MOVE +X,-Y
; Draw a diagonal line of <DE> pixels (line goes upward and to the right)
DRWEEE:
  LD B,D
  LD C,E
; This entry point is used by the routine at DRWGGG.
DRWHHC:
  CALL NEGDE
  JR DOMOVR

;MOVE -X,+Y
; Draw a diagonal line of <DE> pixels (line goes downward and to the left)
DRWGGG:
  CALL NEGDE
  LD B,D
  LD C,E
  JR DRWHHC       ;MAKE DY POSITIVE & GO

; Draw a line to a specific location (x,y) or a location relative to the current position (M+20,-20)
DMOVE:
  CALL FETCHZ     ;GET NEXT CHAR AFTER COMMA
  LD B,$00        ;ASSUME RELATIVE
  CP '+'          ;IF "+" OR "-" THEN RELATIVE
  JR Z,MOVREL
  CP '-'
  JR Z,MOVREL
  INC B           ;NON-Z TO FLAG ABSOLUTE
  
MOVREL:
  LD A,B
  PUSH AF         ;SAVE ABS/REL FLAG ON STACK
  CALL DECFET     ;BACK UP SO VALSCN WILL SEE "-"
  CALL VALSCN     ;GET X VALUE
  PUSH DE         ;SAVE IT
  CALL FETCHZ     ;NOW CHECK FOR COMMA
  CP ','          ;COMMA?
  JP NZ,FC_ERR    ; If not, Err $05 - "Illegal function call"
  CALL VALSCN     ;GET Y VALUE IN D
  POP BC          ;GET BACK X VALUE
  POP AF          ;GET ABS/REL FLAG
  OR A
  JR NZ,DRWABS    ;NZ - ABSOLUTE
  

; This entry point is used by the DRAW routines at DRUP, DRLEFT, DRWHHH and DRWEEE.
DOMOVR:
  CALL DSCLDE     ;ADJUST Y OFFSET BY SCALE
  PUSH DE         ;SAVE Y OFFSET
  LD D,B          ;GET X INTO [DE]
  LD E,C          ;GO SCALE IT.
  CALL DSCLDE     ;GET ADJUSTED X INTO [HL]
  EX DE,HL        ;GET ADJUSTED Y INTO [DE]
  POP DE
  LD A,(DRWANG)   ;GET ANGLE BYTE
  RRA             ;LOW BIT TO CARRY
  JR NC,ANGEVN    ;ANGLE IS EVEN - DON'T SWAP X AND Y
  PUSH AF         ;SAVE THIS BYTE
  CALL NEGHL      ;ALWAYS NEGATE NEW DY
  EX DE,HL
  POP AF          ;GET BACK SHIFTED ANGLE
ANGEVN:
  RRA             ;TEST SECOND BIT
  JR NC,ANGPOS    ;DON'T NEGATE COORDS IF NOT SET
  CALL NEGHL
  CALL NEGDE      ;NEGATE BOTH DELTAS
ANGPOS:
  CALL GTABSC     ;GO CALC TRUE COORDINATES
DRWABS:
  LD A,(DRWFLG)   ;SEE WHETHER WE PLOT OR NOT
  ADD A,A         ;CHECK HI BIT
  JR C,DSTPOS     ;JUST SET POSITION.
  PUSH AF         ;SAVE THIS FLAG
  PUSH BC         ;SAVE X,Y COORDS
  PUSH DE         ;BEFORE SCALE SO REFLECT DISTANCE OFF
  CALL CLINE2     ;SCALE IN CASE COORDS OFF SCREEN
  POP DE
  POP BC          ;GET THEM BACK
  POP AF          ;GET BACK FLAG
DSTPOS:
  ADD A,A         ;SEE WHETHER TO STORE COORDS
  JR C,DNSTOR     ;DON'T UPDATE IF B6=1
  LD (GRPACY),DE  ;UPDATE GRAPHICS AC
  LD H,B
  LD L,C
  LD (GRPACX),HL
DNSTOR:
  XOR A           ;CLEAR SPECIAL FUNCTION FLAGS   (Reset draw mode when finished drawing)
  LD (DRWFLG),A
  RET

; Set flags to return to the starting position after performing the command 
DNOMOV:
  LD A,$40        ;SET BIT SIX IN FLAG BYTE
  JR DSTFLG

; Set flags to move to the location specified by the command, but don't draw a line 
DNOPLT:
  LD A,$80        ;SET BIT 7

; This entry point is used by the routine at DNOMOV.
DSTFLG:
  LD HL,DRWFLG
  OR (HL)
  LD (HL),A       ;STORE UPDATED BYTE
  RET

; Data block at 24142
; Change the orientation of the drawing to 0 (normal), 1 (90 degrees clockwise), 2 (180 degrees clockwise) or 3 (270 degrees clockwise)
DANGLE:
  JR NC,DSCALE    ;ERROR IF NO ARG
  LD A,E          ;MAKE SURE LESS THAN 4
  CP $04
  JR NC,DSCALE    ;ERROR IF NOT
  LD (DRWANG),A	  ; DrawAngle (0..3): 1=90 degrees rotation .. 3=270 degrees, etc..
  RET

; S<scale> Scale every length specified after this command by <scale/4> pixels.
DSCALE:
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  LD A,D          ;MAKE SURE LESS THAN 256
  OR A
  JP NZ,FC_ERR			; Err $05 - "Illegal function call"
  LD A,E
  LD (DRWSCL),A   ;STORE SCALE FACTOR
  RET


; Used by the routine at DMOVE.
DSCLDE:
  LD A,(DRWSCL)   ;GET SCALE FACTOR
  OR A            ;ZERO MEANS NO SCALING
  RET Z
  LD HL,$0000
DSCLP:
  ADD HL,DE       ;ADD IN [DE] SCALE TIMES
  DEC A
  JR NZ,DSCLP
  EX DE,HL        ;PUT IT BACK IN [DE]
  LD A,D          ;SEE IF VALUE IS NEGATIVE
  ADD A,A
  PUSH AF         ;SAVE RESULTS OF TEST
  JR NC,DSCPOS
  DEC DE          ;MAKE IT TRUNCATE DOWN
DSCPOS:
  CALL DE_DIV2    ;DIVIDE BY FOUR
  CALL DE_DIV2
  POP AF          ;SEE IF WAS NEGATIVE
  RET NC          ;ALL DONE IF WAS POSITIVE
  LD A,D          ;OR IN HIGH 2 BITS TO MAKE NEGATIVE
  OR $C0
  LD D,A
  INC DE          ;ADJUST SO TRUNCATING TO LOWER VALUE
  RET


DCOLR:
  JR NC,DSCALE    ; "NCFER": FC ERROR IF NO ARG
  LD A,E          ;GO SET ATTRIBUTE
  CALL SETATR     ; Set attribute byte
  JP C,FC_ERR     ;ERROR IF ILLEGAL ATTRIBUTE   ( Err $05 - "Illegal function call" )
  RET


  
; ________________________________________________________

;
;       MACLNG - MACRO LANGUAGE DRIVER
;
; MICROSOFT GRAPHICS AND SOUND MACRO LANGUAGES
;


;MCLFLG: defb 0		;Used to extend the MCL interpreter to PLAY music

;Other 'DRAW' vars. not initialized
MCLPTR: defw 0      ;MAC LANG PTR
MCLLEN: defb 0      ;STRING LENGTH
MCLTAB: defw 0      ;PTR TO COMMAND TABLE

; Data block at 22124
MACLNG:
  LD   (MCLTAB),DE  ;SAVE POINTER TO COMMAND TABLE
  CALL EVAL         ;EVALUATE STRING ARGUMENT
  PUSH HL           ;SAVE TXTPTR TILL DONE
  LD   DE,$0000     ;PUSH DUMMY ENTRY TO MARK END OF STK
  PUSH DE           ;DUMMY ADDR
  PUSH AF           ;DUMMY LENGTH
MCLNEW:
  CALL GETSTR       ; 
  CALL LOADFP       ;GET LENGTH & POINTER
  LD   B,C          ; convert string address from Extended Basic
  LD   C,D          ; ... to 8K
  LD   D,E
  LD   A,B
  OR C
  JR Z,MCLOOP       ;Don't Push if addr is 0
  LD A,D
  OR A
  JR Z,MCLOOP       ; or if Len is 0...
  PUSH BC           ;PUSH ADDR OF STRING
  PUSH DE           ;PUT IN [AL]
MCLOOP:
  POP AF            ;GET LENGTH OFF STACK
  LD (MCLLEN),A
  POP HL            ;GET ADDR
  LD A,H            ;SEE IF LAST ENTRY
  OR L
  JR NZ,MACLNG_0
;  LD A,(MCLFLG)
;  OR A
;  JP Z,MC_POPTRT    ;ALL FINISHED IF ZERO
;  JP MCLPLAY_0
  JR MC_POPTRT    ;ALL FINISHED IF ZERO


MACLNG_0:
  LD (MCLPTR),HL    ;SET UP POINTER

; This entry point is used by the routines at __PLAY_2 and DOSND.
MCLSCN:
  CALL FETCHR       ;GET A CHAR FROM STRING
  JR Z,MCLOOP       ;END OF STRING - SEE IF MORE ON STK
  ADD A,A           ;PUT CHAR * 2 INTO [C]
  LD C,A
  LD HL,(MCLTAB)    ;POINT TO COMMAND TABLE
MSCNLP:
  LD A,(HL)         ;GET CHAR FROM COMMAND TABLE
  ADD A,A           ;CHAR = CHAR * 2 (CLR HI BIT FOR CMP)
GOFCER:
  CALL Z,FC_ERR     ;END OF TABLE.    ( Err $05 - "Illegal function call" )
  CP C              ;HAVE WE GOT IT?
  JR Z,MISCMD       ;YES.
  INC HL            ;MOVE TO NEXT ENTRY
  INC HL
  INC HL
  JR MSCNLP

MISCMD:
  LD BC,MCLSCN      ;RETURN TO TOP OF LOOP WHEN DONE
  PUSH BC
  LD A,(HL)         ;SEE IF A VALUE NEEDED
  LD C,A            ;PASS GOTTEN CHAR IN [C]
  ADD A,A
  JR NC,MNOARG      ;COMMAND DOESN'T REQUIRE ARGUMENT
  OR A              ;CLEAR CARRY
  RRA               ;MAKE IT A CHAR AGAIN
  LD C,A            ;PUT IN [C]
  PUSH BC
  PUSH HL           ;SAVE PTR INTO CMD TABLE
  CALL FETCHR       ;GET A CHAR
  LD DE,$0001       ;DEFAULT ARG=1
  JP Z,VSNARG_0     ;NO ARG IF END OF STRING
  CALL ISLETTER_A   ;SEE IF POSSIBLE LETTER
  JP NC,VSNARG
  CALL VALSC3       ;GET THE VALUE
  SCF               ;SET CARRY TO FLAG USING NON-DEFAULT
  JR ISCMD3

VSNARG:
  CALL DECFET       ;PUT CHAR BACK INTO STRING
VSNARG_0:
  OR A              ;CLEAR CARRY
ISCMD3:
  POP HL
  POP BC            ;GET BACK COMMAND CHAR
MNOARG:
  INC HL            ;POINT TO DISPATCH ADDR
  LD A,(HL)         ;GET ADDRESS INTO HL
  INC HL
  LD H,(HL)
  LD L,A
  JP (HL)           ;DISPATCH



; This entry point is used by the routines at VALSCN, SCNVAR and DMOVE.
FETCHZ:
  CALL FETCHR       ;GET A CHAR FROM STRING
  JR Z,GOFCER       ;GIVE ERROR IF END OF LINE
  RET

FETCHR:
  PUSH HL
FETCH2:
  LD HL,MCLLEN      ;POINT TO STRING LENGTH
  LD A,(HL)
  OR A
  JR Z,MC_POPTRT    ;RETURN Z=0 IF END OF STRING
  DEC (HL)          ;UPDATE COUNT FOR NEXT TIME
  LD HL,(MCLPTR)    ;GET PTR TO STRING
  LD A,(HL)         ;GET CHARACTER FROM STRING
  INC HL            ;UPDATE PTR FOR NEXT TIME
  LD (MCLPTR),HL
  CP ' '            ;SKIP SPACES
  JR Z,FETCH2
  CP 'a'-1          ;CONVERT LOWER CASE TO UPPER
  JR C,MC_POPTRT
  SUB $20           ;DO CONVERSION

MC_POPTRT:
  POP HL
  RET

DECFET:
  PUSH HL
  LD HL,MCLLEN      ;INCREMENT LENGTH
  INC (HL)
  LD HL,(MCLPTR)    ;BACK UP POINTER
  DEC HL
  LD (MCLPTR),HL
  POP HL
  RET

; Used by the routine at DMOVE.
VALSCN:
  CALL FETCHZ       ;GET FIRST CHAR OF ARGUMENT
VALSC3:
  CP '='            ;NUMERIC?
  JP Z,VARGET
  CP '+'            ;PLUS SIGN?
  JR Z,VALSCN       ;THEN SKIP IT
  CP '-'            ;NEGATIVE VALUE?
  JR NZ,VALSC2
  LD DE,NEGD        ;IF SO, NEGATE BEFORE RETURNING
  PUSH DE
  JR VALSCN         ;EAT THE "-"
  
; This entry point is used by the routine at DOSND.
VALSC2:
  LD DE,$0000       ;INITIAL VALUE OF ZERO
NUMLOP:
  CP ','            ;COMMA
  JR Z,DECFET       ;YES, BACK UP AND RETURN
  CP ';'            ;SEMICOLON?
  RET Z             ;YES, JUST RETURN
  CP '9'+1          ;NOW SEE IF ITS A DIGIT
  JR NC,DECFET      ;IF NOT, BACK UP AND RETURN
  CP '0'
  JR C,DECFET

  LD HL,$0000       ;[HL] is accumulator
  LD B,$0A          ;[HL]=[DE]*10
MUL10:
  ADD HL,DE
  JR C, SCNFC       ;overflow - JMP Function Call Error
  DJNZ MUL10
  
  SUB '0'           ;ADD IN THE DIGIT
  LD E,A
  LD D,$00
  ADD HL,DE
  JR C, SCNFC       ;overflow - JMP Function Call Error
  EX DE,HL          ;VALUE SHOULD BE IN [DE]
  CALL FETCHR       ;GET NEXT CHAR
  JR NZ,NUMLOP      ;branch if not end of string
  RET


; (GW-BASIC has extra code here to "Allow VARPTR$(variable) for BASCOM compatibility")
;
; Used by the routines at VARGET and MCLXEQ.
SCNVAR:
  CALL FETCHZ       ;MAKE SURE FIRST CHAR IS LETTER
  LD DE,BUF         ;PLACE TO COPY NAME FOR PTRGET
  PUSH DE           ;SAVE ADDR OF BUF FOR "ISVAR"
  LD B,40           ;COPY MAX OF 40 CHARACTERS
  CALL ISLETTER_A   ;MAKE SURE IT'S A LETTER
  JR C, SCNFC       ;FC ERROR IF NOT LETTER
SCNVLP:
  LD (DE),A         ;STORE CHAR IN BUF
  INC DE
  CP ';'            ;A SEMICOLON?
  JR Z,SCNV2        ;YES - END OF VARIABLE NAME
  CALL FETCHZ       ;GET NEXT CHAR
  DJNZ SCNVLP

; This entry point is used by the routine at VALSCN.
 SCNFC:
  CALL FC_ERR       ;ERROR - VARIABLE TOO LONG
SCNV2:
  POP HL            ;GET PTR TO BUF
  JP EVAL_VARIABLE  ;GO GET ITS VALUE

; Used by the routine at VALSCN.
VARGET:
  CALL SCNVAR       ;SCAN & EVALUATE VARIABLE
  CALL __CINT       ;MAKE IT AN INTEGER
  EX DE,HL          ;IN [DE]
  RET

; Used by the DRAW and PLAY routines.
;  Plays MML stored in string variable A$ *3 / Executes a drawing substring
MCLXEQ:
  CALL SCNVAR       ;SCAN VARIABLE NAME
  LD A,(MCLLEN)     ;SAVE CURRENT STRING POS & LENGTH
  LD HL,(MCLPTR)
  EX (SP),HL        ;POP OFF RET ADDR, PUSH MCLPTR
  PUSH AF
  LD C,$02          ;MAKE SURE OF ROOM ON STACK
  CALL CHKSTK
  JP MCLNEW

NEGD:
  XOR A
  SUB E
  LD E,A
  SBC A,D
  SUB E
  LD D,A
  RET

; ________________________________________________________
;  End of MACRO LANGUAGE block 
ENDIF

;----------------------------------------------------------------
IF APPLE2
GO_6502:
  LD ($F3D0),HL    ; remapped to $03D0 on the 6502 side
  LD ($0000),A     ; Touch the switch in the current Z80 SoftCard HW slot
  RET
ENDIF
;----------------------------------------------------------------

;----------------------------------------------------------------
IF TRAP_BDOS

; New entry for BIOS WBOOT (reload command processor)
; These get patched when GBASIC boots

TRAP_WBOOT:
  LD E,$1F    ; ==> Error code for "Reset error"

  DEFB $01    ; LD BC,NN - over the next 2 bytes

BDOS_BADSCTR:
  LD E,$39    ; ==> Error code for "Disk I/O ERROR"

  DEFB $01    ; LD BC,NN - over the next 2 bytes

BDOS_RODISK:
  LD E,$44    ; ==> Error code for "Disk Read Only"

  DEFB $01    ; LD BC,NN - over the next 2 bytes

BDOS_BADSLCT:
  LD E,$45    ; ==> Error code for "Drive select error"

  DEFB $01    ; LD BC,NN - over the next 2 bytes

BDOS_ROFILE:
  LD E,$46    ; ==> Error code for "File Read Only" 

  JP CPM_ERR_TRAP

; Routine at 19339
;
; Used by the routine at CPM_ERR_TRAP.
RESUME_DRIVE:
  LD A,($0004)
  LD E,A
  CALL CPMENT
  POP DE			; Get the error code in E
  JP ERROR

ENDIF
;----------------------------------------------------------------



;
; Used by the routine at DONCMD.
INITSA:
  CALL NODSKS
  LD HL,(TXTTAB)
  DEC HL
  LD (HL),$00
  LD HL,(TEMP8)         ;POINT TO START OF COMMAND LINE
  LD A,(HL)             ;GET BYTE POINTED TO
  OR A                  ;IF ZERO, NO FILE SEEN
  JP NZ,LRUN            ;TRY TO RUN FILE
  JP READY


; This extra space seemed to add stability to the Spectrum version

;IF !ORIGINAL
;DEFS 32
;ENDIF

;----------------------------------------------------------------
;    WARNING:  All the code after 'ENDIO' will be destroyed
;----------------------------------------------------------------


; Data block at 24012
ENDIO:
  DEFW $0000


IF ORIGINAL

; Data block at 24014
CHK_TRY:
  DEFB $01

; Data block at 24015
CHK_RANGE:
  DEFB $05

ENDIF


; Main entry
;
; Used by the routine at L0100.
INIT:
  LD HL,TSTACK              ;SET UP TEMP STACK
  LD SP,HL                  
  XOR A                     ;INITIALIZE PROTECT FLAG
  LD (PROFLG),A
  LD (STKTOP),HL
  LD SP,HL
  LD HL,BUFFER
  LD (HL),':'
  CALL STKINI
  LD (TTYPOS),A
  LD (SAVSTK),HL            ;WE RESTORE STACK WHEN ERRORS
  LD HL,(BASE+$0001)        ;GET START OF BIOS VECTOR TABLE
IF TRAP_BDOS
  LD (EXIT_TO_SYSTEM+1),HL             ;Keep the boot entry
ENDIF
  LD BC,$0004               ;CSTS
  ADD HL,BC                 ;ADD FOUR
  LD E,(HL)                 ;PICK UP CSTS ADDRESS
  INC HL
  LD D,(HL)
  EX DE,HL                  ;GET CSTS ADDRESS
  LD (SMC_ISCNTC2),HL       	;THIRD CONTROL-C CHECK
  LD (SMC_ISCNTC3),HL       	;SAVE
  LD (SMC_ISCNTC),HL        	;FAST CONTROL-C CHECK
  EX DE,HL                  ;POINTER BACK TO [H,L]
  INC HL                    ;POINT AT CI ADDRESS
  INC HL                    
  LD E,(HL)                 ;GET LOW BYTE OF CI ADDRESS
  INC HL                    
  LD D,(HL)                 ;GET HIGH BYTE
  EX DE,HL                  ;INPUT ADDRESS TO [H,L]
  LD (SMC_CONIN),HL         ;SAVE IN CONSOLE INPUT CALL
  EX DE,HL                  ;POINTER BACK TO [H,L]
  INC HL                    ;SKIP "JMP" OPCODE
  INC HL                    ;BUMP POINTER
  LD E,(HL)                 ;GET OUTPUT ROUTINE ADDRESS
  INC HL
  LD D,(HL)
  EX DE,HL                  ;INTO [H,L]
  LD (SMC_CONOUT),HL         ;SAVE INTO OUTPUT ROUTINE
  EX DE,HL                  ;POINTER BACK TO [H,L]
  INC HL                    ;NOW POINT TO PRINTER OUTPUT
  INC HL                    ;ROUTINE ADDRESS
  LD E,(HL)                 ;PICK IT UP
  INC HL
  LD D,(HL)
  EX DE,HL                  ;GET ADDRESS INTO [D,E]
  LD (SMC_LPTOUT),HL        ;SET PRINT ROUTINE ADDRESS

;----------------------------------------------------------------
IF TRAP_BDOS
; Trap the BIOS WBOOT entry to provide a different "BIOS" function table
; This is probably to prevent a BDOS failure to cause a WBOOT reset
; and to restore the system to a stable working condition
; (e.g. selecting a valid default disk drive, and possibly, in some
;       configuration, paging back in the user memory)
;

  EX DE,HL               ; HL should be pointing to the BIOS printer routine (LIST) 
  LD DE,$F1F8            ; -3592... where is it pointing to?    probably the BDOS error table

  ADD HL,DE              ; it surely knows where the BDOS error table is  :D  !!!
    
  LD DE,BDOS_BADSCTR     ; bad sector on read or write.
  LD (HL),E              ; generates error $39, "Disk I/O ERROR"
  INC HL
  LD (HL),D
  INC HL
  LD DE,BDOS_BADSLCT     ; "bad disk select"
  LD (HL),E              ; generates error $45, "Drive select error"
  INC HL
  LD (HL),D
  INC HL
  LD DE,BDOS_RODISK      ; disk is read only.
  LD (HL),E              ; generates error $44, "Disk Read Only"
  INC HL
  LD (HL),D
  INC HL
  LD DE,BDOS_ROFILE      ; file is read only.
  LD (HL),E              ; generates error $46, "File Read Only" 
  INC HL
  LD (HL),D
  
  ; Now let's trap also WBOOT, we already saved the BIOS entries before
  LD HL,TRAP_WBOOT
  LD (BASE+$0001),HL      ; generates error $1F, "Reset error"

ENDIF
;----------------------------------------------------------------

IF APPLE2
  LD HL,($F3DE)           ; get the HW slot currently in use by the Z80 SoftCard
  LD (GO_6502+4),HL       ; use SMC to adjust the pivot routine calling the 6502
ENDIF

;----------------------------------------------------------------

  ;  Check CP/M Version Number
IF CPMV1
  LD C,$0C                ; BDOS function 12 - Get BDOS version number
  CALL CPMENT
  LD (BDOSVER),A
  OR A
  LD HL,$1514             ; FN2=$15 (CP/M 1 WR), FN1=14 (CP/M 1 RD)
  JR Z,CPMVR1             ; JP if BDOS Version 1
  LD HL,$2221             ; FN2=$22 (Write record FN), FN1=$21 (Read record FN)
CPMVR1:
  LD (CPMREA),HL          ; Load the BDOS FN code pair (FN1+FN2)
ENDIF

  LD HL,-2                ; SAY INITIALIZATION IS EXECUTING
  LD (CURLIN),HL          ; IN CASE OF ERROR MESSAGE
  XOR A
  LD (CTLOFG),A
  LD (ENDBUF),A           ; MAKE SURE OVERRUNS STOP
  LD (CHNFLG),A           ; MAKE SURE CHAINS AND MERGES..
  LD (MRGFLG),A           ; ..DON'T TRY TO HAPPEN
  LD (ERRFLG),A           ; DON'T ALLOW EDIT TO BE CALLED ON ERRORS
  LD HL,0
  LD (LPTPOS),HL          ; ZERO FLAG AND POSITION
  LD HL,128               ; The default record size is 128 bytes.
  LD (MAXREC),HL          ; a.k.a. RECSIZ
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,PRMSTK            ; INITIALIZE PARAMETER BLOCK CHAIN
  LD (PRMPRV),HL
  LD HL,(CPMENT+1)        ; HL=BDOS entry address (=LAST LOC IN MEMORY)
  LD (MEMSIZ),HL          ; -> USE AS DEFAULT



;
;
; THE FOLLOWING CODE SCANS A CP/M COMMAND LINE FOR BASIC.
; THE FORMAT OF THE COMMAND IS:
;
; BASIC <FILE NAME>[/M:<TOPMEM>][/F:<FILES>]
;
  LD A,3                ; DEFAULT FILES           ; If the /F option is omitted, the number of files defaults to 3.
  LD (MAXFIL),A			; BY SETTING MAXFIL=3     ; HIGHEST FILE NUMBER ALLOWED
  LD HL,ZEROB           ; POINT AT ZERO BYTE
  LD (TEMP8),HL         ; SO IF RE-INITAILIZE OK
  LD A,(COMAGN)         ; HAVE WE ALREADY READ COMMAND LINE
  OR A                  ; AND GOT ERROR?
  JP NZ,DONCMD          ; THEN DEFAULT
  INC A                 ; MAKE NON-ZERO
  LD (COMAGN),A         ; STORE BACK NON-ZERO FOR NEXT TIME
  LD HL,CPMWRM+128      ; POINT TO FIRST CHAR OF COMMAND BUFFER (CPMWRM+128)
  LD A,(HL)             ; WHICH CONTAINS # OF CHARS IN COMMAND
  OR A                  ; IS THERE A COMMAND?
  LD (TEMP8),HL         ; SAVE POINTER TO THIS ZERO
  JP Z,DONCMD           ; NOTHING IN COMMAND BUFFER
  LD B,(HL)             ; AND [B]
  INC HL                ; POINT TO FIRST CHAR IN BUFFER
TBF_LP:
  LD A,(HL)             ; GET CHAR FROM BUFFER
  DEC HL                ; BACK UP POINTER
  LD (HL),A             ; STORE CHAR BACK
  INC HL                ; NOW ADVANCE CHAR TO ONE PLACE
  INC HL                ; AFTER PREVIOUS POSIT.
  ;DEC B                 ; DECREMENT COUNT OF CHARS TO MOVE
  DJNZ TBF_LP          ; KEEP MOVING CHARS
  DEC HL                ; BACK UP POINTER
ENDCMD:
  LD (HL),$00           ; STORE TERMINATOR FOR CHRGET (0)
  LD (TEMP8),HL         ; SAVE POINTER TO NEW ZERO (OLD DESTROYED)
  LD HL,CPMWRM+127      ; POINT TO CHAR BEFORE BUFFER
  CALL CHRGTB           ; IGNORE LEADING SPACES
  OR A
  JP Z,DONCMD           ; END OF COMMAND

;
; Command line parameters usage example
;
; A>MBASIC PRGM/F:2/M:&H9000
; Use first 36K of memory, 2 files, and execute PRGM.BAS.
  
  CP '/'              ;IS IT A SLASH
  JR Z,FNDSLH         ;YES
  DEC HL              ;BACK UP POINTER
  LD (HL),'"'         ;STORE DOUBLE QUOTE
  LD (TEMP8),HL       ;SAVE POINTER TO START OF FILE NAME
  INC HL              ;BUMP POINTER
ISSLH:
  CP '/'              ;OPTION?
  JR Z,FNDSLH         ;YES
  CALL CHRGTB         ;SKIP OVER CHAR IN FILE NAME
  OR A                ;SET CC'S
  JR NZ,ISSLH         ;KEEP LOOKING FOR OPTION
  JR DONCMD           ;THAT'S IT

  
FNDSLH:
  LD (HL),$00         ;STORE TERMINATOR OVER "/"
  CALL CHRGTB         ;GET CHAR AFTER SLASH
SCANS1:
  CALL MAKUPL         ; (fix added in 5.22, we accept both /s: and /S:)
  CP 'S'              ; [/S:<maximum record size>]
  JR Z,WASS

  CP 'M'              ; [/M:<highest memory location>]
  PUSH AF             ;SAVE INDICATOR
  JR Z,WASM           ;WAS MEMORY OPTION

  CP 'F'              ; [/F:<number of files>]
  JP NZ,SN_ERR        ;NOT "M" OR "F" ERROR


WASM:
  CALL CHRGTB         ;GET NEXT CHAR
  CALL SYNCHR
  DEFM ":"            ;MAKE SURE COLON FOLLOWS
  CALL CNSGET         ;[DE]=VALUE FOLLOWING COLON
  POP AF              ;GET BACK M/F FLAG
  JR Z,MEM            ;WAS MEMORY OPTION

; If /F:<number of files> is present, it sets the number of disk data files that may be 
; open at anyone time during the execution of a BASIC program.
; Each file data block allocated in this fashion requires 166 bytes of memory.
; If the /F option is omitted, the number of files defaults to 3.

  LD A,D              ;FILES CANT BE .GT. 255
  OR A                ;SET CC'S
  JP NZ,FC_ERR        ;FUNCTION CALL ERROR
  LD A,E              ;GET LOW BYTE
  CP 16               ;MUST BE .LT. 16
  JP NC,FC_ERR
  LD (MAXFIL),A       ;STORE IN # OF FILES        ; HIGHEST FILE NUMBER ALLOWED
  JR FOK              ;DONE


MEM:
  LD (MEMSIZ),DE
FOK:
  DEC HL
  CALL CHRGTB
  JR Z,DONCMD
  CALL SYNCHR
  DEFM "/"
  JR SCANS1
  
  
; /S:<maximum record size> may be added at the end of the command
; line to set the maximum record size for use with random files.
; The default record size is 128 bytes.

WASS:
  CALL CHRGTB         ;GET CHAR AFTER "S"
  CALL SYNCHR
  DEFM ":"            ;MAKE SURE COLON FOLLOWS
  CALL CNSGET         ;GET VALUE FOLLOWING COLON             ;[DE]=VALUE FOLLOWING COLON
  LD (MAXREC),DE      ;SAVE IT
  JR FOK              ;CONTINUE SCANNING



IF ZXPLUS3

; ---------------------------------------------------------------
; This code portion will be copied on stack
; ---------------------------------------------------------------
pokebyte_code:
		di
		ex  af,af

IF ZXCSDISK
		xor a
		out ($7b),a
		nop
		nop
		nop
		nop
ELSE
;IF ZXSPECTRAL
;		LD A,40h ; -> ZXS mode
;		out ($fd),a
;		nop
;		nop
;		nop
;ELSE
IF ZXLEC
		xor a
		out ($fd),a
		nop
		nop
		nop
		nop
ELSE
IF DISKFACE
		call $EFD9
		nop
		nop
		nop
		nop
ELSE

		ld	a,$15
		;ld	a,$0D
		;ld	a,$05
		ld bc,$1ffd
		out(c),a
ENDIF
ENDIF
;ENDIF
ENDIF

		ex af,af
		ld (hl),a
IF ZXCSDISK
		ld a,$c0
		out ($7b),a
ELSE
;IF ZXSPECTRAL
;		LD A,48h ; -> CP/M mode
;		out ($fd),a
;ELSE
IF ZXLEC
		ld a,$80
		out ($fd),a
ELSE
IF DISKFACE
		call $EFF3
		nop
ELSE
		ld	a,$11		; avoid using ($FF01) to be compatible with CP/M 2.2 
		;ld	a,$09
		;ld	a,$01
		;ld	a,($FF01)	; saved value
		out(c),a
ENDIF
ENDIF
;ENDIF
ENDIF
		ei
		ret
		; adjust code size
peekbyte_code:
		di
IF ZXCSDISK
		xor a
		out ($7b),a
		nop
		nop
		nop
		nop
ELSE
;IF ZXSPECTRAL
;		LD A,40h ; -> ZXS mode
;		out ($fd),a
;		nop
;		nop
;		nop
;ELSE
IF ZXLEC
		xor a
		out ($fd),a
		nop
		nop
		nop
		nop
ELSE
IF DISKFACE
		call $EFD9
		nop
		nop
		nop
		nop
ELSE

		ld	a,$15
		;ld	a,$0D
		;ld	a,$05
		ld bc,$1ffd
		out(c),a
ENDIF
ENDIF
;ENDIF
ENDIF
		ld a,(hl)
		ex  af,af
IF ZXCSDISK
		ld a,$c0
		out ($7b),a
ELSE
;IF ZXSPECTRAL
;		LD A,48h ; -> CP/M mode
;		out ($fd),a
;ELSE
IF ZXLEC
		ld a,$80
		out ($fd),a
ELSE
IF DISKFACE
		call $EFF3
		nop
ELSE
		ld	a,$11		; avoid using ($FF01) to be compatible with CP/M 2.2 
		;ld	a,$09
		;ld	a,$01
		;ld	a,($FF01)	; saved value
		out(c),a
ENDIF
ENDIF
;ENDIF
ENDIF
		ex  af,af
		ei
		ret
		; adjust code size
; ---------------------------------------------------------------
ENDIF


ZEROB:
  DEFB $00              ;ZERO BYTE

COMAGN:
  DEFB $00              ;WE HAVENT SCANNED COMMAND YET

; Routine at 24346
;
; Used by the routine at INIT.
; END OF COMMAND
DONCMD:

;
IF ORIGINAL
  LD DE,USER_MEMORY
  LD A,(DE)
  OR A
  JR Z,DONCMD_3
  LD A,(CHK_RANGE)
  LD B,A
  
PSP_LOOP:
  LD A,(CHK_TRY)
  LD C,A
  LD HL,(CPMENT+1)      ; HL=BDOS entry address (=LAST LOC IN MEMORY)
  LD L,$00              ; Cut off the byte boundary

PSP_CHK:
  LD A,(DE)
  CP (HL)
  JR NZ,PSP_DIFFERS
  
  INC HL
  INC DE
  DEC C
  JR NZ,PSP_CHK
  JR DONCMD_3
  
PSP_DIFFERS:
  INC DE
  DEC C
  JR NZ,PSP_DIFFERS
  DEC B
  RET Z
  JR PSP_LOOP

DONCMD_3:
;  (this is also on the MSX version, probably had to be removed with the whole code block)
  DEC HL                ; useless ?

ENDIF

  LD HL,(MEMSIZ)        ; GET SIZE OF MEMORY

  DEC HL                ;ALWAYS LEAVE TOP BYTE UNUSED BECAUSE
                        ;VAL(STRING) MAKES BYTE IN MEMORY
                        ;BEYOND LAST CHAR OF STRING=0

  LD (MEMSIZ),HL        ;SAVE IN REAL MEMORY SIZE
  DEC HL                ;ONE LOWER IS STKTOP
  PUSH HL               ;SAVE IT ON STACK
  
;
; DISK INITIALIZATION ROUTINE
; SETUP FILE INFO BLOCKS
; THE NUMBER OF EACH AND INFORMATION FOR GETTING TO POINTERS TO EACH IS STORED.
; NO LOCATIONS ARE INITIALIZED, THIS IS DONE BY NODSKS, FIRST CLOSING ALL FILES.
; THE NUMBER OF FILES IS THE FILE POINTER TABLE
;
  defc DSKDAT=ENDIO     ;START DATA AFTER ALL CODE

  LD A,(MAXFIL)			; HIGHEST FILE NUMBER ALLOWED
  LD HL,DSKDAT          ;GET START OF MEMORY
  LD (FILPT1),HL
  LD DE,FILPTR          ;POINT TO TABLE TO SET UP
  LD (MAXFIL),A	        ;REMEMBER HOW MANY FILES                ; HIGHEST FILE NUMBER ALLOWED
  INC A                 ;ALWAYS FILE 0 FOR INTERNAL USE

  LD BC,$00A9           ;(DBLK.C) - SIZE OF A FILE INFO BLOCK PLUS $CODE

LOPFLB:
  EX DE,HL              ;[H,L] POINT INTO POINTER BLOCK
  LD (HL),E             ;STORE THE POINTER AT THIS FILE
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  ADD HL,BC             ;[H,L] POINT TO NEXT INFO BLOCK
  PUSH HL               ;SAVE [H,L]
  LD HL,(MAXREC)        ;GET MAX RECORD SIZE
  LD BC,128+50          ;(FNZBLK) GET SIZE OF OTHER STUFF     ; The default record size is 128 bytes.
  ADD HL,BC
  LD B,H
  LD C,L                ;RESULT TO [B,C]
  POP HL                ;RESTORE [H,L]
  DEC A                 ;ARE THERE MORE?
  JR NZ,LOPFLB
;HAVFNS:
  INC HL                ; INCREMENT POINTER
  LD (TXTTAB),HL        ; SAVE BOTTOM OF MEMORY
  LD (SAVSTK),HL        ; WE RESTORE STACK WHEN ERRORS
  POP DE                ; GET  CURRENT MEMSIZ
  LD A,E                ; CALC TOTAL FREE/8
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR

; HL=HL/8
  LD B,$03              ; DIVIDE BY 2 THREE TIMES
SHFLF3:
  OR A
  LD A,H
  RRA
  LD H,A
  LD A,L
  RRA
  LD L,A
  ;DEC B
  DJNZ SHFLF3

  LD A,H                ; SEE HOW MUCH
  CP $02			 	; IF LESS THAN 512 USE 1 EIGHTH
  JR C,SMLSTK

  LD HL,$0200           ; Force minimum MEM size to 512

SMLSTK:
  LD A,E                ; SUBTRACT STACK SIZE FROM TOP MEM
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR

IF ZXPLUS3

IF SCORPION

; Nothing to be done

ELSE
	push de
	ld de,-34	; let's reserve extra space on stack for the JP routines
	add hl,de
	push hl
	
	; Save entry for p3_poke
	ld (p3_poke+1),hl

	; Determine entry for p3_peek
	push hl		; keep a copy
	ld de,17	; -34+17..
	add hl,de
	ld (p3_peek+1),hl

	; copy on stack
	pop hl
	ld d,h
	ld e,l
	ld hl,pokebyte_code
	ld bc,17+17
	ldir
	pop hl
	pop de
ENDIF

ENDIF


  LD (MEMSIZ),HL
  EX DE,HL
  LD (STKTOP),HL          ; REASON USES THIS...
  LD (FRETOP),HL          ; SET UP NEW STACK
  LD SP,HL
  LD (SAVSTK),HL
  LD HL,(TXTTAB)
  EX DE,HL
  CALL ENFMEM
  ; HL=HL-DE
  LD A,L                  ; SUBTRACT MEMSIZ-TXTTAB
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  DEC HL                  ; SINCE TWO ZEROS EXIST BETWEEN
  DEC HL                  ; TXTTAB AND STREND, ADJUST
  PUSH HL                 ; SAVE NUMBER OF BYTES TO PRINT


IF QUORUM | ELWRO
  ld a,(CPJ_ATRBYT)		; Get the current colors defined in CP/J
  ld (ATRBYT),a
  push af
  and 7
  ld (FORCLR),a
  pop af
  rra
  rra
  rra
  and 7
  ld (BAKCLR),a
  ld (BDRCLR),a
  LD A,27
  CALL OUTDO
  LD A,'E'
  CALL OUTDO
ENDIF

IF ZXLEC | ZXCSDISK
  ld hl,$5C48
  call p3_peek
  rra
  rra
  rra
  and 7
  ld (BDRCLR),a

  ld hl, $5C8D		; Get the current colors defined in ATTR_P
  call p3_peek
  ld (ATRBYT),a
  push af
  and 7
  ld (FORCLR),a
  pop af
  rra
  rra
  rra
  and 7
  ld (BAKCLR),a
ELSE

ENDIF


;IF DISKFACE
;  ld a,($F998)		; Get the current colors defined in DiskFace's CP/M
;  ld (ATRBYT),a
;  push af
;  and 7
;  ld (FORCLR),a
;  pop af
;  rra
;  rra
;  rra
;  and 7
;  ld (BAKCLR),a
;  ld (BDRCLR),a
;  LD A,27
;  CALL OUTDO
;  LD A,'E'
;  CALL OUTDO
;ENDIF

IF ELWRO
  ld a,($D078)
  and 7
  ld (BDRCLR),a
ENDIF

IF HC2000
  ld a,($000c)
  and 7
  ld (BDRCLR),a
ENDIF



IF ZXPLUS3
IF SCORPION
ELSE
  LD A,27
  CALL OUTDO  		; Output char to the current device
  LD A,'y'			; disable 80 columns
  CALL OUTDO  		; Output char to the current device
  LD A,27
  CALL OUTDO  		; Output char to the current device
  LD A,'e'			; show cursor
  CALL OUTDO  		; Output char to the current device
ENDIF
ENDIF
  LD HL,COPYRIGHT_MSG     ; GET HEADING ("BASIC VERSION...")
  CALL PRS                ; PRINT IT
  POP HL                  ; RESTORE NUMBER OF BYTES TO PRINT
  CALL LINPRT             ; PRINT # OF BYTES FREE
  LD HL,BYTES_MSG         ; TYPE THE HEADING
  CALL PRS                ; "BYTES FREE"
  LD HL,PRS
  LD (SMC_PRINTMSG),HL
  CALL OUTDO_CRLF         ; PRINT CARRIAGE RETURN
  LD HL,WARM_BT

; Patch myself to do a warm start.
; This instruction was removed in the late MBASIC versions.
; IF !ORIGINAL
;   LD (L0100+1),HL
; ENDIF
  JP INITSA

IF ORIGINAL
; Message at 24551
; HIDDEN TEXT
AUTTXT:
  DEFB $0D
  DEFB $0A
  DEFB $0A
  DEFM "Owned by Microsoft"
  DEFB $0D
  DEFB $0A
  DEFB $00
ENDIF

; Message at 24575
BYTES_MSG:
  DEFM " Bytes free"
  DEFB $00


COPYRIGHT_MSG:
  DEFM "BASIC-80 Rev. 5.22"
  DEFB $0D
  DEFB $0A
  DEFM "["
IF ZXPLUS3
IF SCORPION
  DEFM "ZX Spectrum "
ELSE
  DEFM "ZX +3 "
ENDIF
ENDIF
  DEFM "CP/M Version]"
  DEFB $0D
  DEFB $0A
IF ZXPLUS3
  DEFM "Copyright 1977-1984 (C) by Microsoft"
ELSE
  DEFM "Copyright 1977-1982 (C) by Microsoft"
ENDIF
  DEFB $0D
  DEFB $0A
IF ORIGINAL
  DEFM "Created: 19-Mar-82"
  DEFB $0D
  DEFB $0A
ENDIF
  DEFB $00


; Message at 24660
; Useless signature
; adds a bit of space between program and interpreter
BASIC_SIGNATURE:
  DEFM "Basic-80"

; Foo data in user memory
USER_MEMORY:
  DEFS 94

TSTACK:
  defw $830
  defb 0

; File padding, useful to compare binaries
IF ORIGINAL
defs 66,0
ENDIF
