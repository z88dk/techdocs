
; z80asm -b mbasic.asm


  ORG $0100

; BASIC-80 Rev. 5.22


; Classic build:
;
; z80asm -b -DORIGINAL -DCPMV1 mbasic.asm
; ren mbasic.bin MBASIC.COM


; Proof of concept:  ZX Spectrum +3 graphics and Terminal
; (PSET, PRESET, POINT, LINE, CLS, LOCATE)
;
; z80asm -b -DHAVE_GFX -DZXPLUS3 -DVT52 mbasic.asm
; ren mbasic.bin P3BASIC.COM
; z88dk-appmake +cpmdisk -f plus3 -b P3BASIC.COM


; Proof of concept:  reusing MSX specific code
; The COLOR command sort of works, PSET would require to enter in graphics mode.
; It is portable to MTX, SVI, EINSTEIN, etc.
;
; z80asm -b -DHAVE_GFX -DUSEVDP -DFORMSX mbasic.asm
; ren mbasic.bin MSXBAS.COM
; z88dk-appmake +fat -f msxdos -b MSXBAS.COM


; --- Sizes --- 

defc NUMLEV   =   0*20+19+2*5       ; NUMBER OF STACK LEVELS RESERVED BY AN EXPLICIT CALL TO GETSTK

; --- Prefixes, Tokens.. --- 

;defc OCTCON   = 11  ; $0B - EMBEDED OCTAL CONSTANT

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




;IF ZXPLUS3
;defc LINLN    =   50  ; Commented out, the 24x80 virtual screen can be useful
;ELSE
defc LINLN    =   80   ; TERMINAL LINE LENGTH 
;ENDIF

defc LPTLEN   =  132   ; Max column size on printer
defc CLMWID   =   14   ; MAKE COMMA COLUMNS FOURTEEN CHARACTERS


;DATPSC	SET	128			;NUMBER OF DATA BYTES IN DISK SECTOR

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
;CPMWRM	SET	0			;CP/M WARM BOOT ADDR
;CPMENT	SET	CPMWRM+5	;CP/M BDOS CALL ADDR



;------------------------------------


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
;; defc TK_CSAVE    =  $9B
;; defc TK_CLOAD    =  $9C
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
defc TK_DEFSGN   =  $AF


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

IF HAVE_GFX
defc TK_POINT    =  $DE
ENDIF

defc TK_GREATER  =  $EF ; Token for '>'
defc TK_EQUAL    =  $F0 ; Token for '='

defc TK_MINOR    =  $F1	; Token for '<'
defc TK_PLUS     =  $F2	; Token for '+'
defc TK_MINUS    =  $F3	; Token for '-'
defc TK_STAR     =  $F4	; Token for '*'
defc TK_SLASH    =  $F5	; Token for '/'
defc TK_EXPONENT =  $F6	; Token for '^'
defc TK_AND      =  $F7	; Token for 'AND'
defc TK_OR       =  $F8	; Token for 'OR'
defc TK_XOR      =  $F9	; Token for 'XOR'
defc TK_EQV      =  $FA	; Token for 'EQV'
defc TK_IMP      =  $FB	; Token for 'IMP'
defc TK_MOD      =  $FC	; Token for 'MOD'
defc TK_BKSLASH  =  $FD	; Token for '\'


;------------------------------------

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
  DEFW INT_RESULT_HL	; (MAKINT) TURN [H,L] INTO A VALUE IN THE FAC


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
  DEFW SN_ERR
  DEFW SN_ERR
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

  DEFM "E"
  DEFB 'F'+$80
  DEFB TK_DEF

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
  DEFW DECADD             ;DOUBLE PRECISION ROUTINES
  DEFW DECSUB
  DEFW DECMUL
  DEFW DECDIV
  DEFW DECCOMP

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
  DEFM "FIELD overflow"
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

; SET TO 65534 IN PURE VERSION DURING INIT EXECUTION
; SET TO 65535 WHEN DIRECT STATEMENTS EXECUTE
CURLIN:
  DEFW 65534              ; (word), line number being interpreted (at startup, 65534: INITIALIZATION IS EXECUTING)

TXTTAB:
  DEFW TSTACK+1           ; PTR to Start of BASIC program

MATH_ERRTXT:
  DEFW OVERFLOW_MSG       ; (a.k.a. OVERRI), Text PTR to current error message in math operations


;
;	END OF INITIALIZED PART OF RAM
;
;
; DISK DATA STORAGE AREA
;

AUTORUN:
  DEFB $00

MAXFILSV:
  DEFB $00                ; Top number of files

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

TYPE_BUFFR:
  DEFS 39                 ; Used by BASIC to deal with variable types

LCRFLG:
  DEFW $00                ; Locate/Create flag
  
  
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
  DEFB $2C



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

; DORES (OPRTYP):  USED TO STORE OPERATOR NUMBER IN THE EXTENDED
; MOMENTARILY BEFORE OPERATOR APPLICATION (APPLOP)
DORES:
  DEFB $00                ; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..

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
  DEFS 15                ; Storage area for BASIC variables
DSCTMP:
  DEFB $00                ; String descriptor which is the result of string fun
TMPSTR:
  DEFW $0000              ; Temporary string
FRETOP:
  DEFW $0000              ; Starting address of unused area of string area
TEMP3:
  DEFW $0000              ; (word) used for garbage collection or by USR function, a.k.a. CUROPR
TEMP8:
  DEFW $0000              ; Used for garbage collection
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
  DEFW $0000              ; Address ptr to next operator, used by EVAL
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
LOPLIN:
  DEFW $0000              ; (word), temp line no. storage used in FOR, WHILE, etc..
OPTBASE:
  DEFB $00                ; Array size set with "OPTION BASE", (for 10=default size, value is '0': 10+1 XOR 11)
OPTBASE_FLG:
  DEFB $00                ; Array status flag to deal with "OPTION BASE"

  DEFS 30                 ; Unused ?

INTFLG:
  DEFB $00                ; This flag is set if STOP (=4) or CTRL + STOP (=3) is pressed
IMPFLG:
  DEFB $00                ; This flag is related to the INPUT status
FRETOP_SV:
  DEFW $0000              ; Temporary usage of the free string area
RECSIZ:
  DEFW $0000              ; $0bea:  maximum record size for use with random files.
PROFLG:
  DEFB $00                ; 'File protected' status flag
MRGFLG:
  DEFB $00                ; 'In MERGE' status flag
  
CHAIN_DEL:
  DEFB $00                ; Flag to track the 'DELETE' option in a CHAIN command
CHAIN_TO:
  DEFW $0000              ; End line number in a range specified for 'CHAIN'
CHAIN_FROM:
  DEFW $0000              ; Start line number in a range specified for 'CHAIN'
CHNFLG:
  DEFB $00                ; 'In CHAIN' status flag
CHAIN_LN:
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
  
RESFLG:
  DEFB $00
RESFLG_OLD:
  DEFB $00
PUFOUT_FLG:
  DEFB $00                ; Flag used by PUFOUT

  DEFB $00
FPARG:
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00

  DEFB $00
  DEFB $00
DBL_LAST_FPREG:
  DEFB $00
ARG:
  DEFB $00

FBUFFR:
  DEFS 43                ; $0C15 Buffer for fout


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

p3_poke:
		jp 0

p3_peek:
		jp 0



__VPOKE:
  CALL GETWORD
  PUSH DE
  CALL ADDR_RANGE
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
  EX (SP),HL
  CALL p3_poke
  POP HL
  RET


	PUSH HL
	CALL GETWORD
	PUSH DE
	CALL ADDR_RANGE
	CALL SYNCHR
	DEFM ","
	CALL GETINT             ; Get integer 0-255
	POP HL
	CALL p3_poke
	POP HL
	RET

__VPEEK:
  CALL GETWORD_HL
  CALL ADDR_RANGE
  CALL p3_peek
  JP PASSA

; ---------------------------------------------------------------
ENDIF



; Search FOR or GOSUB block on stack
;
; Used by the routines at __RETURN and __NEXT.
BAKSTK:
  LD HL,$0004             ; IGNORING EVERYONES "NEWSTT" AND THE RETURN..
  ADD HL,SP               ; ..ADDRESS OF THIS SUBROUTINE

; Look for "FOR" block with same index as specified in D
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
  CP TK_FOR               ; Is it a "FOR" token
  RET NZ                  ; No - exit
  LD C,(HL)               ; BC = Address of "FOR" index
  INC HL
  LD B,(HL)
  INC HL                  ; Point to sign of STEP
  PUSH HL                 ; Save pointer to sign
  LD H,B                  ; HL = address of "FOR" index
  LD L,C
  LD A,D                  ; See if an index was specified
  OR E                    ; DE = 0 if no index specified
  EX DE,HL                ; Specified index into HL
  JP Z,INDFND             ; Skip if no index given
  EX DE,HL                ; Index back into DE
  CALL DCOMPR             ; Compare index with one given
INDFND:
  LD BC,$0010             ; Offset to next block (FORSZC=14+2)
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
; Used by the routines at __EOF, __OPEN, GET_CHNUM, __MERGE, __FIELD, FN_INPUT
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
; Used by the routines at __EOF, __LOC, __LOF, __OPEN, GET_CHNUM and __FIELD.
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
FIELD_OV_ERR:
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
; Used by the routine at L184B.
DATSNR:
  LD HL,(DATLIN)            ;GET DATA LINE
  LD (CURLIN),HL            ;MAKE IT CURRENT LINE


; 'Syntax Error' message
;
; Used by the routines at LNUM_RANGE, SAVSTP, NEWSTT_0, __GOTO, __AUTO, L184B,
; INPUT_SUB, _EVAL, HEXTFP, DOFN, ISMID, __WAIT, __RENUM, __OPTION, __LOAD,
; __MERGE, __WEND, __CHAIN, __GET, GETVAR, SBSCPT, L5256, SYNCHR, __CLEAR and
; INIT.
SN_ERR:
  LD E,$02                ;"SYNTAX ERROR"
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Division by zero' error entry
;
; Used by the routines at L2BA0 and DECDIV_SUB.
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
; Used by the routines at HEXTFP, __CINT, DECDIV_SUB and __NEXT.
OV_ERR:
  LD E,$06                ;SET OVERFLOW ERROR CODE
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Operand Error' error entry
;
; Used by the routine at OPRND.
OPERAND_ERR:
  LD E,$16                ;MISSIN OPERAND ERROR
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Type mismatch' error entry
;
; Used by the routines at FORFND, _EVAL, _EVAL_VALTYP, INVSGN, _TSTSGN, __CINT,
; __CSNG, __CDBL, TSTSTR, __INT and __TROFF.
TM_ERR:
  LD E,$0D                 ;TYPE MISMATCH ERROR


; This entry point is used by the routines at WARM_BT, FILE_EXISTS_ERR,
; DETOKEN_MORE, FC_ERR, UL_ERR, __RETURN, __ERROR, FDTLP, IDTEST, LOOK_FOR,
; __MERGE, __WEND, BS_ERR, CHKSTK, __CONT, TSTOPL_0, TESTOS and CONCAT.
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
  CP $44                    ;(LSTERR) IS IT PAST LAST ERROR?
  JP NC,UNKNOWN_ERR         ;YES, TOO BIG TO PRINT
  CP $32                    ;(DSKERR+1) DISK ERROR?
  JP NC,NTDER2              ;JP if error code is between $32 and $43
  CP $1F                    ;(NONDSK+1) IS IT BETWEEN LAST NORMAL & FIRST DISK?
  JP C,LEPSKP               ;YES, OK TO PRINT IT (JP if error code is < $1F)

; Used by the routines at ERROR_REPORT and _ERROR_REPORT.
UNKNOWN_ERR:
; if error code is bigger than $43 then force it to $28-$13=$15 ("Unprintable error")
  LD A,$28  ;(ERRUE+DSKERR-NONDSK): PRINT "UNPRINTABLE ERROR"


; JP here if error code is between $32 and $43, then sub $13
;
; Used by the routine at ERROR_REPORT.
NTDER2:
  SUB $13                   ; (DSKERR-NONDSK): FIX OFFSET INTO TABLE OF MESSAGES
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
  JP UNKNOWN_ERR            ;MAKE UNPRINTABLE ERROR


_LEPSKP:
  CALL PRS                 	;PRINT MESSAGE
  POP HL                    ;RESTORE LINE NUMBER
  LD DE,65534               ;IS INIT EXECUTING?
  CALL DCOMPR
  CALL Z,OUTDO_CRLF        	;DO CRLF
  JP Z,EXIT_TO_SYSTEM       ;SYSTEM error exit
  
  LD A,H                   	;SEE IF IN DIRECT MODE
  AND L                     
  INC A                     ;ZERO SAYS DIRECT MODE
  CALL NZ,LNUM_MSG          ;PRINT LINE NUMBER IN [H,L]


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
; Used by the routines at PROMPT, __LIST, __LOAD, EDIT_DONE and _READY.
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

  DEFB $CD                 ; CALL CPMWRM

; Data block at 3480
SMC_PRINTMSG:
  DEFW $0000

; Routine at 3482
READY_0:
  LD A,(ERRFLG)            ;SEE IF IT WAS A "SYNTAX ERROR"
  SUB $02
  CALL Z,ERR_EDIT          ;"EDIT" THE BAD LINE



; Routine at 3490
;
; Used by the routines at __AUTO, __LOAD and __MERGE.
PROMPT:
  LD HL,65535              ;SETUP CURLIN FOR DIRECT MODE
  LD (CURLIN),HL
  LD A,(AUTFLG)            ;IN AN AUTO COMMAND?
  OR A                     ;SET CC'S
  JP Z,GETCMD              ;NO, REUGLAR MODE
  LD HL,(AUTLIN)           ;GET CURRENT AUTO LINE
  PUSH HL                  ;SAVE AWAY FOR LATER USE
  CALL _PRNUM              ;PRINT THE LINE #
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
  CP ' '                  ;CHARACTER A SPACE?
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
  EX DE,HL                ;SAVE THIS LINE # IN DOT;
  LD (DOT),HL
  EX DE,HL
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
  OR A                    
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
  LD HL,$0080             ;(DIRTMP) DON'T ALLOW ZERO TO BE CLOSED
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
; Used by the routines at __LOAD and L46AB.
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
  CP $0B                  ;IS IT LINEFEED OR BELOW?
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
; __CHAIN, L46AB, __EDIT and SYNCHR.
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
  JP SRCHLP             ; Keep looking


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
  LD (DORES),A            ; ALLOW CRUNCHING
  LD BC,KBFLEN-3          ; GET LENGTH OF KRUNCH BUFFER MINUS THREE BECAUSE OF ZEROS AT END
  LD DE,KBUF              ; SETUP DESTINATION POINTER

; Routine at 3877
;
; Used by the routines at CRNCLP, CRNCH_MORE, DETOKEN_MORE and NOTRES.
NXTCHR:                   ; (=KLOOP)
  LD A,(HL)               ; Get byte            GET CHARACTER FROM BUF
  OR A                    ; End of line ?
  JP NZ,CRNCLP            ; No, continue

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
  JP Z,CPYLIT             ; Yes - Copy literal string        YES, GO TO SPECIAL STRING HANDLING
  CP ' '                  ; Is it a space?                   SPACE?
  JP Z,STUFFH             ; Yes - Copy direct                JUST STUFF AWAY
  LD A,(DORES)            ; a.k.a. OPRTYP, indicates whether stored word can be
  OR A                    ; crunched, etc..                  END OF LINE?
  LD A,(HL)
  JP Z,CRNCLP_2           ;                                  YES, DONE CRUNCHING

; This entry point is used by the routine at DETOKEN_MORE.
STUFFH:
  INC HL                  ; ENTRY TO BUMP [H,L]
  PUSH AF                 ; SAVE CHAR AS KRNSAV CLOBBERS
  CALL KRNSAV             ; SAVE CHAR IN KRUNCH BUFFER   (Insert during tokenization)
  POP AF                  ; RESTORE CHAR
  SUB ':'                 ; ":", End of statement?
  JP Z,SETLIT             ; IF SO ALLOW CRUNCHING AGAIN
  CP TK_DATA-':'          ; SEE IF IT IS A DATA TOKEN
  JP NZ,TSTREM            ; No - see if REM
  LD A,$01                ;SET LINE NUMBER ALLOWED FLAG - KLUDGE AS HAS TO BE NON-ZERO.
SETLIT:
  LD (DORES),A            ;SETUP FLAG
  LD (DONUM),A            ;SET NUMBER ALLOWED FLAG
TSTREM:
  SUB TK_REM-':'
  JP NZ,NXTCHR            ;KEEP LOOPING
  PUSH AF                 ;SAVE TERMINATOR ON STACK
STR1_LP:
  LD A,(HL)               ;GET A CHAR
  OR A                    ;SET CONDITION CODES
  EX (SP),HL              ;GET SAVED TERMINATOR OFF STACK, SAVE [H,L]
  LD A,H                  ;GET TERMINATOR INTO [A] WITHOUT AFFECTING PSW
  POP HL                  ;RESTORE [H,L]
  JP Z,CRDONE             ;IF END OF LINE THEN DONE
  CP (HL)                 ;COMPARE CHAR WITH THIS TERMINATOR
  JP Z,STUFFH             ;IF YES, DONE WITH STRING

CPYLIT:
  PUSH AF                 ;SAVE TERMINATOR
  LD A,(HL)               ;GET BACK LINE CHAR
; This entry point is used by the routine at TOKEN_BUILT.
CRNCLP_1:
  INC HL                  ;INCREMENT TEXT POINTER
  CALL KRNSAV             ;SAVE CHAR IN KRUNCH BUFFER
  JP STR1_LP              ;KEEP LOOPING

CRNCLP_2:
  CP '?'                  ; Is it "?" short for PRINT
  LD A,TK_PRINT           ; "PRINT" token
  PUSH DE
  PUSH BC
  JP Z,MOVDIR             ; Yes - replace it
  LD DE,OPR_TOKENS
  CALL MAKUPL
  CALL IS_ALPHA_A
  JP C,DETOKEN_MORE       ; JP if not letter
  PUSH HL
  LD DE,FNC_GO
  CALL TK_TXT_COMPARE
  JP NZ,CRNCH_MORE
  CALL CHRGTB
  LD DE,FNC_TO
  CALL TK_TXT_COMPARE
  LD A,TK_GOTO
  JP Z,CRNCLP_3
  LD DE,FNC_SUB
  CALL TK_TXT_COMPARE
  JP NZ,CRNCH_MORE
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
  JP TK_TXT_COMPARE
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
  CALL MAKUPL
  PUSH HL
  LD HL,WORD_PTR
  SUB 'A'
  ADD A,A
  LD C,A
  LD B,$00
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
  INC HL                  ; Get next reserved word
GETNXT_WD:
  PUSH HL
COMPR_WD:
  CALL MAKUPL
  LD C,A
  LD A,(DE)               ; Get byte from table
  AND $7F
  JP Z,NOTRES              ; JP if end of list
  INC HL
  CP C                    ; Same character as in buffer?
  JP NZ,GETNXT            ; No - get next word
  LD A,(DE)
  INC DE
  OR A
  JP P,COMPR_WD
  LD A,C
  CP '('
  JP Z,CRNCH_MORE_1
  LD A,(DE)
  CP TK_FN
  JP Z,CRNCH_MORE_1
  CP TK_USR
  JP Z,CRNCH_MORE_1
IF HAVE_GFX
  CP TK_POINT 
  JP Z,CRNCH_MORE_1
ENDIF
  CALL MAKUPL
  CP '.'
  JP Z,CRNCH_MORE_0
  CALL TSTANM
CRNCH_MORE_0:
  LD A,$00
  JP NC,NOTRES
CRNCH_MORE_1:
  POP AF
  LD A,(DE)
  OR A
  JP M,CRNCH_MORE_3
  POP BC
  POP DE
  OR $80
  PUSH AF
  LD A,$FF
  CALL KRNSAV		; Insert during tokenization
  XOR A
  LD (DONUM),A
  POP AF
  CALL KRNSAV		; Insert during tokenization
  JP NXTCHR
GETNXT:
  POP HL
CRNCH_MORE_2:
  LD A,(DE)
  INC DE
  OR A
  JP P,CRNCH_MORE_2
  INC DE
  JP GETNXT_WD
CRNCH_MORE_3:
  DEC HL

; Token found, direct token code assignment
;
; Used by the routine at CRNCLP.
MOVDIR:
  PUSH AF
  LD DE,LNUM_TOKENS		; List of commands (tokens) requiring program line numbers
  LD C,A
MOVDIR_0:
  LD A,(DE)
  OR A
  JP Z,TOKEN_BUILT
  INC DE
  CP C
  JP NZ,MOVDIR_0
  JP TOKENIZE_LNUM

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
  LD (DONUM),A
  POP AF
  POP BC
  POP DE
  CP TK_ELSE
  PUSH AF
  CALL Z,TOKENIZE_COLON
  POP AF
  CP TK_WHILE
  JP NZ,TOKEN_BUILT_1
  CALL KRNSAV		; Insert during tokenization
  LD A,TK_PLUS
TOKEN_BUILT_1:
  CP TK_APOSTROPHE			; "'" = comment (=REM)
  JP NZ,NTSNGT
  PUSH AF
  CALL TOKENIZE_COLON
  LD A,TK_REM
  CALL KRNSAV		; Insert during tokenization
  POP AF
  PUSH AF
  JP CRNCLP_1

; Routine at 4247
;
; Used by the routine at CRNCLP.
DETOKEN_MORE:
  LD A,(HL)
  CP '.'
  JP Z,DETOKEN_MORE_0
  CP '9'+1
  JP NC,SRCSPC
  CP '0'
  JP C,SRCSPC
DETOKEN_MORE_0:
  LD A,(DONUM)
  OR A
  LD A,(HL)
  POP BC
  POP DE
  JP M,STUFFH
  JP Z,DETOKEN_MORE_4
  CP '.'
  JP Z,STUFFH
  LD A,LINCON		; Line number prefix: $0E
  CALL KRNSAV		; Insert during tokenization
  PUSH DE
  CALL ATOH
  CALL BAKSP
SAVINT:
  EX (SP),HL
  EX DE,HL
DETOKEN_MORE_2:
  LD A,L
  CALL KRNSAV		; Insert during tokenization
  LD A,H
DETOKEN_MORE_3:
  POP HL
  CALL KRNSAV		; Insert during tokenization
  JP NXTCHR

DETOKEN_MORE_4:
  PUSH DE
  PUSH BC
  LD A,(HL)
  CALL DBL_ASCTFP_0
  CALL BAKSP
  POP BC
  POP DE
  PUSH HL
  LD A,(VALTYP)
  CP $02
  JP NZ,DETOKEN_MORE_5
  LD HL,(FACCU)
  LD A,H
  OR A
  LD A,$02
  JP NZ,DETOKEN_MORE_5
  LD A,L
  LD H,L
  LD L,$0F
  CP $0A
  JP NC,DETOKEN_MORE_2
  ADD A,$11
  JP DETOKEN_MORE_3
  
DETOKEN_MORE_5:
  PUSH AF
  RRCA
  ADD A,$1B
  CALL KRNSAV		; Insert during tokenization
  LD HL,FACCU
  CALL GETYPR
  JP C,DETOKEN_MORE_6
  LD HL,FACLOW
DETOKEN_MORE_6:
  POP AF
DETOKEN_MORE_7:
  PUSH AF
  LD A,(HL)
  CALL KRNSAV		; Insert during tokenization
  POP AF
  INC HL
  DEC A
  JP NZ,DETOKEN_MORE_7
  POP HL
  JP NXTCHR

SRCSPC:
  LD DE,OPR_TOKENS-1      ; GET POINTER TO SPECIAL CHARACTER TABLE
SRCSP2:
  INC DE                  ; MOVE POINTER AHEAD
  LD A,(DE)               ; GET BYTE FROM TABLE
  AND $7F                 ; MASK OFF HIGH BIT
  JP Z,NOTRS5             ; IF END OF TABLE, STUFF AWAY, DONT CHANGE DONUM
  INC DE                  ; BUMP POINTER
  CP (HL)                 ; IS THIS SPECIAL CHAR SAME AS CURRENT TEXT CHAR?
  LD A,(DE)               ; GET NEXT RESWRD
  JP NZ,SRCSP2            ; IF NO MATCH, KEEP LOOKING
  JP NOTRS1               ; FOUND, SAVE AWAY AND SET DONUM=1.

; This entry point is used by the routine at TOKEN_BUILT.
NTSNGT:
  CP '&'                  ; OCTAL CONSTANT?
  JP NZ,STUFFH            ; JUST STUFF IT AWAY
  PUSH HL                 ; SAVE TEXT POINTER
  CALL CHRGTB             ; GET NEXT CHAR
  POP HL                  ; RESTORE TEXT POINTER
  CALL UCASE              ; MAKE CHAR UPPER CASE
  CP 'H'                  ; '&H' HEX CONSTANT?
  LD A,$0B				  ; Octal Number prefix  (OCTCON)
  JP NZ,WUZOCT
  LD A,$0C				  ; Hex Number prefix
WUZOCT:
  CALL KRNSAV		; Insert during tokenization
  PUSH DE
  PUSH BC
  CALL HEXTFP
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
  CALL IS_ALPHA_A         ;IS IT A LETTER?
  JP NC,KRNVAR            ;YES, EAT
  CP '9'+1                ;DIGIT?
  JP NC,JKLOOP            ;NO, TOO LARGE
  CP '0'                  
  JP NC,KRNVAR            ;YES, EAT
  CP '.'                  ;IS IT DOT
  JP Z,KRNVAR             ;YES, DOTS OK IN VAR NAMES
JKLOOP:
  JP NXTCHR               ;(=KLOOP) DONE LOOKING AT VARIABLE NAME

; This entry point is used by the routine at DETOKEN_MORE.
NOTRS5:
  LD A,(HL)               ;GET CHAR FROM LINE
  CP ' '                  ;SPACE OR HIGHER ?
  JP NC,NOTRS1            ;YES = SAVE IT
  CP $09                  ;TAB ?
  JP Z,NOTRS1             ;YES = THAT'S OK
  CP $0A                  ;ALSO ALLOW...
  JP Z,NOTRS1             ;...LINE FEEDS
  LD A,' '                ;FORCE REST TO SPACES
; This entry point is used by the routine at DETOKEN_MORE.
NOTRS1:
  PUSH AF                 ;SAVE THIS CHAR
  LD A,(DONUM)            ;GET NUMBER OK FLAG
  INC A                   ;SEE IF IN A VARIABLE NAME.
  JP Z,NOTRES_4           ;IF SO & SPECIAL CHAR SEEN, RESET DONUM
  DEC A                   ;OTHERWISE LEAVE DONUM UNCHANGED.
NOTRES_4:
  JP NOTRS6


; ROUTINE TO BACK UP POINTER AFTER # EATEN
; Routine at 4524
;
; Used by the routines at PROMPT and DETOKEN_MORE.
BAKSP:
  DEC HL                  ;POINT TO PREVIOUS CHAR
  LD A,(HL)               ;GET THE CHAR
  CP ' '                  ;A SPACE?
  JP Z,BAKSP              ;YES, KEEP BACKING UP
  CP $09                  ;TAB?
  JP Z,BAKSP              ;YES, BACK UP
  CP $0A                  ;LF?
  JP Z,BAKSP
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
  EX DE,HL                ;SAVE THE LOOP VARIABLE IN TEMP
  LD (TEMP),HL            ;FOR USE LATER ON
  EX DE,HL
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
  CALL __DATA             ; Get next statement address         SET [H,L]=END OF STATEMENT
  LD (ENDFOR),HL          ; Next address of FOR st.            SAVE FOR COMPARISON
  LD HL,$0002             ; Offset for "FOR" block             SET UP POINTER INTO STACK
  ADD HL,SP               ; Point to it
FORSLP:
  CALL LOKFOR             ; Look for existing "FOR" block      MUST HAVE VARIABLE POINTER IN [D,E]
  JP NZ,FORFND            ; IF NO MATCHING ENTRY, DON'T ELIMINATE ANYTHING
  ADD HL,BC               ; IN THE CASE OF "FOR" WE ELIMINATE THE MATCHING ENTRY AS WELL AS EVERYTHING AFTER IT
  PUSH DE                 ; SAVE THE TEXT POINTER
  DEC HL                  ; SEE IF END TEXT POINTER OF MATCHING ENTRY
  LD D,(HL)               ; MATCHES THE FOR WE ARE HANDLING
  DEC HL                  ; PICK UP THE END OF THE "FOR" TEXT POINTER
  LD E,(HL)               ; FOR THE ENTRY ON THE STACK
  INC HL                  ; WITHOUT CHANGING [H,L]
  INC HL
  PUSH HL                 ; Save block address                 SAVE THE STACK POINTER FOR THE COMPARISON
  LD HL,(ENDFOR)          ; Get address of loop statement      GET ENDING TEXT POINTER FOR THIS "FOR"
  CALL DCOMPR             ; Compare the FOR loops              SEE IF THEY MATCH
  POP HL                  ; Restore block address              GET BACK THE STACK POINTER
  POP DE                  ;                                    GET BACK THE TEXT POINTER
  JP NZ,FORSLP            ; Different FORs - Find another      KEEP SEARCHING IF NO MATCH
  POP DE                  ; Restore code string address        GET BACK THE TEXT POINTER
  LD SP,HL                ; Remove all nested loops            DO THE ELIMINATION
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
  LD HL,(ENDFOR)          ; Get first statement of loop     PICK UP POINTER AT END OF "FOR" 
                          ;                                 JUST BEYOND THE TERMINATOR
  EX (SP),HL              ; Save and restore code string    PUT [H,L] POINTER TO TERMINATOR ON THE STACK
                          ;                                 AND RESTORE [H,L] AS TEXT POINTER AT VARIABLE NAME
  PUSH HL                 ; Re-save code string address     PUSH THE TEXT POINTER ONTO THE STACK
  LD HL,(CURLIN)          ; Get current line number         [H,L] GET THE CURRENT LINE #
  EX (SP),HL              ; Save and restore code string    NOW THE CURRENT LINE # IS ON THE STACK, HL IS THE TEXT POINTER
  CALL SYNCHR             ; Make sure "TO" is next
  DEFB TK_TO              ; "TO" token                         "TO" IS NECESSARY
  CALL GETYPR             ; Get the number type (FAC)          SEE WHAT TYPE THIS VALUE HAS
  JP Z,TM_ERR             ; If string type, "Type mismatch"    GIVE STRINGS A "TYPE MISMATCH"
  JP NC,TM_ERR            ;                                    AS WELL AS DOUBLE-PRECISION
  PUSH AF                 ; save type                          SAVE THE INTEGER/FLOATING FLAG
  CALL EVAL               ;                                    EVALUATE THE TARGET VALUE FORMULA
  POP AF                  ; Restore type                       POP OFF THE FLAG
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
  CALL _TSTSGN_0          ; Test sign for 'STEP'                 THE SIGN OF THE STEP INTO [A]
  JP FORFND_0             ;                                      FINISH UP THE ENTRY BY PUTTING THE SIGN OF
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
  LD A,(HL)               ; Get next byte in code string          GET TERMINATING CHARACTER
  CP TK_STEP              ; See if "STEP" is stated
  LD A,$01                ; Sign of step = 1
  JP NZ,SAVSTP            ; No STEP given - Default to 1
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
  JP NZ,SAVSTP_0
  LD A,$02
SAVSTP_0:
  LD C,A                  ;[C]=SIGN OF STEP
  CALL GETYPR             ;MUST PUT ON INTEGER/SINGLE-PRECISION FLAG - MINUS IS SET FOR INTEGER CASE
  LD B,A                  ;HIGH BYTE = INTEGER/SINGLE PRECISION FLAG
  PUSH BC                 ;SAVE FLAG AND SIGN OF STEP BOTH
  DEC HL                  ;MAKE SURE THE "FOR" ENDED PROPERLY
  CALL CHRGTB
  JP NZ,SN_ERR
  CALL LOOK_FOR_NEXT      ;SCAN UNTIL THE MATCHING "NEXT" IS FOUND
  CALL CHRGTB             ;FETCH FIRST CHARACTER OF "NEXT"
  PUSH HL                 ;MAKE THE NEXT TXTPTR PART OF THE ENTRY
  PUSH HL
  LD HL,(LOPLIN)                                             ;GET THE LINE NUMBER OF NEXT
  LD (CURLIN),HL                                             ;MAKE IT THE CURRENT LINE
  LD HL,(TEMP)            ; Get address of index variable    ;GET THE POINTER TO THE VARIABLE BACK
  EX (SP),HL              ; Save and restore code string     ;PUT THE PTR ON SP AND RESTORE THE TEXT POINTER
  LD B,TK_FOR             ; "FOR" block marker               ;FINISH UP "FOR"
  PUSH BC                 ; Save it
  INC SP                  ; Don't save C                     ;THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE
  PUSH AF                 ;SAVE THE CHARACTER
  PUSH AF                 ;MAKE A STACK ENTRY TO SUBSTITUTE FOR "NEWSTT"
  JP __NEXT_0             ;GO EXECUTE "NEXT" WITH NXTFLG ZERO

; "FOR" block marker
;
; Used by the routine at __NEXT.
; --- Put "FOR" block marker ---
PUTFID:
  LD B,TK_FOR             ; "FOR" block marker               ;PUT A 'FOR' TOKEN ONTO THE STACK
  PUSH BC                 ; Save it                          
  INC SP                  ; Don't save C                     ;THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE
;	JMP	NEWSTT		;ALL DONE

;
; BASIC program execution driver (a.k.a. RUNCNT).  HL points to code.
;
; BACK HERE FOR NEW STATEMENT. CHARACTER POINTED TO BY [H,L]
; ":" OR END-OF-LINE. THE ADDRESS OF THIS LOCATION IS
; LEFT ON THE STACK WHEN A STATEMENT IS EXECUTED SO
; IT CAN MERELY DO A RETURN WHEN IT IS DONE.
;
; Used by the routines at __LOAD, __WEND, __CALL, L46AB and KILFOR.
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
  JP Z,EXEC               ; Yes - Execute it
  OR A                    ; End of line?
  JP NZ,SN_ERR            ; No - Syntax error           ;MUST BE A ZERO
  INC HL                  ; Point to address of next line

; This entry point is used by the routine at ERRMOR.
GONE4:                    ;CHECK POINTER TO SEE IF IT IS ZERO, IF SO WE ARE AT THE END OF THE PROGRAM
  LD A,(HL)
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
  JP Z,NO_TRACE           ; SKIP THIS PRINTING

  ; If "TRACE" is ON, then print current line number between brackets
  ; [0000] <<<-- print line number being executed
  PUSH DE                 ;SAVE THE TEXT POINTER
  LD A,'['                ;FORMAT THE LINE NUMBER
  CALL OUTDO              ;OUTPUT IT
  CALL _PRNUM             ;PRINT THE LINE # IN [H,L]
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
  JP NC,ISMID         ; Not a key word - ?SN Error      ;SEE IF LHS MID$ CASE
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
; Used by the routines at PROMPT, LINKER, CRNCLP, DETOKEN_MORE, SAVSTP, EXEC,
; DEFCON, GET_POSINT, FC_ERR, ATOH, __REM, __ON, __RESUME, __IF, __PRINT,
; __TAB, NEXITM, __INPUT, INPUT_SUB, __READ, __READ_DONE, LTSTND, FDTLP, _EVAL,
; OPRND, __ERR, __ERL, HEXTFP, OPRND_3, FN_USR, __DEF, DOFN, __WAIT, __WIDTH,
; FPSINT, FNDNUM, MAKINT, LISPRT, SCCPTR, _LINE2PTR, __OPTION, LOOK_FOR, _ASCTFP,
; PUFOUT, L3338, RND_SUB, __OPEN, GET_CHNUM, LINE_INPUT, __LOAD, __MERGE,
; CLOSE_FILE, FN_INPUT, __WHILE, __CALL, __CHAIN, L45C9, L46AB, __GET, PUTBUF,
; FN_INKEY, DIMRET, GVAR, SBSCPT, L5256, __ERASE, __CLEAR, KILFOR, DTSTR,
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
CHRGTB_1:
  CP ' '                  ;                                MUST SKIP SPACES
  JP Z,CHRGTB             ; Skip over spaces               GET ANOTHER CHARACTER
  JP NC,NOTLFT            ; NC if < "0"                    NOT SPECIAL TRY OTHER POSSIB.
  OR A                    ; Test for zero - Leave carry
  RET Z
  CP $0B                  ;(OCTCON) IS IT INLINE CONSTANT ?
  JP C,NOTCON             ;NO, SHOULD BE TAB OR LF
  CP $1E                  ;ARE WE TRYING TO RE-SCAN A CONSTANT?
  JP NZ,NTRSCC            ;NO.
  LD A,(CONSAV)           ;GET THE SAVED CONSTANT TOKEN
  OR A                    ;SET NON-ZERO, NON CARRY CC'S
  RET                     ;ALL DONE

NTRSCC:
  CP CONCN2               ;GOING TO SCAN PAST EMBEDDED CONSTANT?
  JP Z,NTRSC2             ;NO, TRY OTHER CASES
  PUSH AF                 ;SAVE TOKEN TO RETURN
  INC HL                  ;POINT TO NUMBER
  LD (CONSAV),A           ;SAVE CURRENT TOKEN
  SUB INTCON              ;IS IT LESS THAN INTEGER CONSTANT?
  JP NC,MAKTKN            ;NO, NOT LINE NUMBER CONSTANT
  SUB ONECON-INTCON       ;LESS THAN EMBEDDED 1 BYTER
  JP NC,ONEI              ;WAS ONE BYTER
  CP IN2CON-ONECON        ;IS IT TWO BYTER?
  JP NZ,FRCINC            ;NOPE, NORMAL INT
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
  JP ONEI2                ;FINISH SCANNING

; This entry point is used by the routine at OPRND.
NTRSC2_0:
  CALL CONFAC
NTRSC2:
  LD HL,(CONTXT)
  JP __CHRCKB

MAKTKN:                   ;CALCULATE VALTYPE
  INC A                   ;*2 TO GET VALTYPE 0=2, 1=4, 3=8
  RLCA                    ;CONTYPE NOW SETUP
  LD (CONTYP),A           ;SAVE SOME RGS
  PUSH DE
  PUSH BC                 ;PLACE TO STORE SAVED CONSTANT
  LD DE,CONLO             ;GET TEXT POINTER IN [D,E]
  EX DE,HL                ;SETUP COUNTER IN [B]
  LD B,A                  ;MOVE DATA IN
  CALL CPY2HL             ;GET TEXT POINTER BACK
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
  JP NC,CHRGTB            ;YES, EAT.
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
  JP NC,NTLINE             ;NO
  CP PTRCON                ;LINE POINTER CONSTANT?
  JP C,NTLINE              ;NO
  LD HL,(CONLO)            ;GET VALUE
  JP NZ,FLTLIN             ;MUST BE LINE NUMBER, NOT POINTER
  INC HL                   ;POINT TO LINE #
  INC HL
  INC HL
  LD E,(HL)                ;GET LINE # IN [D,E]
  INC HL
  LD D,(HL)                ;GET HIGH PART
  EX DE,HL                 ;VALUE TO [H,L]
FLTLIN:
  JP DBL_ABS_0             ;FLOAT IT

NTLINE:
  LD A,(CONTYP)            ;GET SAVED CONSTANT VALTYP
  LD (VALTYP),A            ;SAVE IN REAL VALTYP
  CP $08                   ;DOUBLE PRECISION ?
  JP Z,CONFDB              ;YES
  LD HL,(CONLO)            ;GET LOW TWO BYTES OF FAC
  LD (FACCU),HL            ;SAVE THEM
  LD HL,(CONLO+2)          ;GET NEXT TWO BYTES
  LD (FACCU+2),HL          ;SAVE THEM
  RET                      ;SCAN FURTHER

CONFDB:
  LD HL,CONLO              ;GET POINTER TO SAVED CONSTANT AREA
  JP FP_HL2DE              ;MOVE INTO FAC  (then, RESTORE TEXT PTR & SCAN FOLLOWING CHARACTER)

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
  CALL IS_ALPHA           ;MAKE SURE THE ARGUMENT IS A LETTER
  LD BC,SN_ERR            ;PREPARE "SYNTAX ERROR" RETURN
  PUSH BC
  RET C                   ;RETURN IF THERES NO LETTER
  SUB 'A'                 ;MAKE AN OFFSET INTO DEFTBL
  LD C,A                  ;SAVE THE INITIAL OFFSET
  LD B,A                  ;ASSUME IT WILL BE THE FINAL OFFSET
  CALL CHRGTB             ;GET THE POSSIBLE DASH
  CP TK_MINUS             ;(token code for '-'): A RANGE ARGUMENT? ; 
  JP NZ,NOTRNG            ;IF NOT, JUST ONE LETTER
  CALL CHRGTB             ;GET THE FINAL POSITION
  CALL IS_ALPHA           ;CHECK FOR A LETTER
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
  JP NZ,LPDCHG            
  POP HL                  ;GET BACK THE TEXT POINTER
  LD A,(HL)               ;GET LAST CHARACTER
  CP ','                  ;IS IT A COMMA?
  RET NZ                  ;IF NOT STATEMENT SHOULD HAVE ENDED
  CALL CHRGTB             ;OTHERWISE SET UP TO SCAN NEW RANGE
  JP DEFCON

; Get subscript
;
; Used by the routines at L46AB, __GET and SBSCPT.
;
; INTIDX READS A FORMULA FROM THE CURRENT POSITION AND
; TURNS IT INTO A POSITIVE INTEGER
; LEAVING THE RESULT IN [D,E].  NEGATIVE ARGUMENTS
; ARE NOT ALLOWED. [H,L] POINTS TO THE TERMINATING
; CHARACTER OF THE FORMULA ON RETURN.
;
GET_POSINT:
  CALL CHRGTB
; This entry point is used by the routine at __CLEAR.
GET_POSINT_0:
  CALL FPSINT_0          ;READ A FORMULA AND GET THE RESULT AS AN INTEGER IN [D,E]
                         ;ALSO SET THE CONDITION CODES BASED ON THE HIGH ORDER OF THE RESULT
  RET P                  ;DON'T ALLOW NEGATIVE NUMBERS

; Err $05 - "Illegal function call"
;
; Used by the routines at __ERROR, __AUTO, __ERL, DOFN, MAKINT, __DELETE,
; __RENUM, __LOG, __NAME, __CVD, FN_INPUT, __CHAIN, L45A2, L46AB, __GET,
; __USING, L5256, __TROFF, __CLEAR, __ASC, __MID_S, FN_INSTR and INIT.
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
  EX DE,HL              ;SAVE TEXT POINTER
  LD HL,(DOT)           ;GET CURRENT LINE #
  EX DE,HL              ;GET BACK TEXT POINTER
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
; Used by the routines at PROMPT, DETOKEN_MORE, __GOSUB, __GOTO, __ON,
; __RESUME, __AUTO, UCASE, __RENUM, PUTBUF and SYNCHR.
ATOH:
  DEC HL                ;BACKSPACE PTR

; As above, but conversion starts at HL+1
;
; This entry point is used by the routine at __ON.
ATOH2:
  CALL CHRGTB           ;FETCH CHAR (GOBBLE LINE CONSTANTS)
  CP LINCON             ;$0E: EMBEDDED LINE CONSTANT?
  JP Z,LINGT3           ;YES, RETURN DOUBLE BYTE VALUE
  CP PTRCON             ;$0D: ALSO CHECK FOR POINTER

; This entry point is used by the routines at _LINE2PTR and SCNPT2.
LINGT3:
  EX DE,HL              ;SAVE TEXT PTR IN [D,E]
  LD HL,(CONLO)         ;GET EMBEDDED LINE #
  EX DE,HL              ;RESTORE TEXT PTR.
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
  JP C,POPHSR         ; YES, DON'T SCAN ANY MORE DIGITS IF SO.  FORCE CALLER TO SEE DIGIT AND GIVE SYNTAX ERROR
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
  JP GTLNLP           ; Go to next character
  
POPHSR:
  POP AF              ;GET OFF TERMINATING DIGIT
  POP HL              ;GET BACK OLD TEXT POINTER
  RET
  
  
__RUN:
  JP Z,RUN_FST        ; RUN from start if just RUN   ;NO LINE # ARGUMENT
  CP LINCON           ;LINE NUMBER CONSTANT?
  JP Z,__RUN_0        ;YES
  CP PTRCON           ;LINE POINTER (RATHER UNLIKELY)
  JP NZ,_RUN_FILE

;CLEAN UP,SET [H,L]=[TXTTAB]-1 AND
;RETURN TO NEWSTT
__RUN_0:
  CALL _CLVAR          ; Initialise variables      ;CLEAN UP -- RESET THE STACK, DATPTR,VARIABLES ...
                                                   ;[H,L] IS THE ONLY THING PRESERVED
  LD BC,NEWSTT         ; Execution driver loop
  JP RUNLIN            ; RUN from line number      ;PUT "NEWSTT" ON AND FALL INTO "GOTO"

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
  JP __GOTO_0                                               ;HAVE NOW GRAB LINE # PROPERLY
  
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
  JP NC,UL_ERR            ; Err $08 - "Undefined line number"  ;LINE NOT FOUND, DEATH
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
; Used by the routines at PROMPT, __GOTO, __ON, L46AB, __EDIT and SYNCHR.
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
; L46AB.

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
  JP Z,NXTSTL             ; Yes - Look for another '"'   ;IF SO TIME TO TRADE
;
; WHEN AN "IF" TAKES A FALSE BRANCH IT MUST FIND THE APPROPRIATE "ELSE" TO START EXECUTION AT.
; "DATA" COUNTS THE NUMBER OF "IF"S, IT SEES SO THAT THE "ELSE" CODE CAN MATCH "ELSE"S WITH "IF"S.
; THE COUNT IS KEPT IN [D] BECAUSE THEN S HAVE NO COLON
; MULTIPLE IFS CAN BE FOUND IN A SINGLE STATEMENT SCAN
; THIS CAUSES A PROBLEM FOR 8-BIT DATA IN UNQUOTED STRING DATA BECAUSE $IF MIGHT BE MATCHED.
; FIX IS TO HAVE FALSIF IGNORE CHANGES IN [D] IF ITS A DATA STATEMENT
;
  INC A                   ;FUNCTION TOKEN?
  JP Z,__REM_1            ;THEN IGNORE FOLLOWING FN NUMBER
  SUB TK_IF+1             ;IS IT AN "IF"
  JP NZ,__REM_0           ;IF NOT, CONTINUE ON
  CP B                    ;SINCE "REM" CAN'T SMASH [D,E] WE HAVE TO BE CAREFUL
                          ;SO ONLY IF B DOESN'T EQUAL ZERO WE INCREMENT D. (THE "IF" COUNT)
  ADC A,D                 ;CARRY ON IF [B] NOT ZERO
  LD D,A                  ;UPDATE [D]
  JP __REM_0              ; Keep looking

; Code at $1518
; LETCON IS LET ENTRY POINT WITH VALTYP-3 IN [A]
; BECAUSE GETYPR HAS BEEN CALLED
LETCON:
  POP AF                  ;GET VALTYPE OFF STACK
  ADD A,$03               ;MAKE VALTYPE CORRECT
  JP __LET_0              ;CONTINUE

; 'LET' BASIC command
;
; Used by the routine at EXEC.
__LET:
  CALL GETVAR             ;GET THE POINTER TO THE VARIABLE NAMED IN TEXT AND PUT IT INTO [D,E]
  CALL SYNCHR
  DEFB TK_EQUAL           ;CHECK FOR "="
  EX DE,HL                ;MUST SET UP TEMP FOR "FOR"
  LD (TEMP),HL            ;UP HERE SO WHEN USER-FUNCTIONS
  EX DE,HL                ;CALL REDINP, TEMP DOESN'T GET CHANGED
  PUSH DE
  LD A,(VALTYP)           ; Get data type
  PUSH AF                 ; save type         ;CALL REDINP, TEMP DOESN'T GET CHANGED
  CALL EVAL                                   ;GET THE VALUE OF THE FORMULA
  POP AF                  ; Restore type      ;GET THE VALTYP OF THE VARIABLE INTO [A] INTO FAC

; This entry point is used by the routines at LETCON and __LINE.
__LET_0:
  EX (SP),HL              ;[H,L]=POINTER TO VARIABLE TEXT POINTER TO ON TOP OF STACK
; This entry point is used by the routine at __READ_DONE.
__LET_1:
  LD B,A                  ;SAVE VALTYP
  LD A,(VALTYP)           ;GET PRESENT VALTYPE
  CP B                    ;COMPARE THE TWO
  LD A,B                  ;GET BACK CURRENT
  JP Z,__LET_3            ;VALTYPE ALREADY SET UP, GO!
  CALL CHKTYP             ;FORCE VALTPES TO BE [A]'S
; This entry point is used by the routine at DOFN.
__LET_2:
  LD A,(VALTYP)           ;GET PRESENT VALTYPE
__LET_3:
  LD DE,FACCU             ;ASSUME THIS IS WHERE TO START MOVEING
  CP $05                  ;IS IT?   ; (Integer ?)
  JP C,__LET_4            ;YES
  LD DE,FACLOW            ;NO, USE D.P. FAC
__LET_4:
  PUSH HL                 ;SAVE THE POINTER AT THE VALUE POSITION
  CP $03                  ; String ?
  JP NZ,LETNUM            ;NUMERIC, SO FORCE IT AND COPY

  LD HL,(FACCU)           ; Pointer to string entry           ;GET POINTER TO THE DESCRIPTOR OF THE RESULT
  PUSH HL                 ; Save it on stack                  ;SAVE THE POINTER AT THE DESCRIPTOR
  INC HL                  ; Skip over length
  LD E,(HL)               ; LSB of string address
  INC HL
  LD D,(HL)               ; MSB of string address
  LD HL,(TXTTAB)          ;IF THE DATA IS IN BUF, OR IN DISK RANDOM BUFFER, COPY.
  CALL DCOMPR             ;SINCE BUF CHANGES ALL THE TIME
  JP NC,__LET_5           ;GO COPY, IF DATA REALLY IS IN BUF
  LD HL,(STREND)          ;SEE IF IT POINTS INTO STRING SPACE
  CALL DCOMPR             ;Is string literal in program?    IF NOT DON'T COPY
  POP DE                  ;GET BACK THE POINTER AT THE DESCRIPTOR
  JP NC,DNTCPY            ;DON'T COPY LITERALS
  LD HL,DSCTMP            ;NOW, SEE IF ITS A VARIABLE
  CALL DCOMPR             ;BY SEEING IF THE DESCRIPTOR IS IN THE TEMPORARY STORAGE AREA (BELOW DSCTMP)
  JP NC,DNTCPY            ;DON'T COPY IF ITS NOT A VARIABLE

  DEFB $3E                ; "LD A,n" to Mask the next byte

__LET_5:
  POP DE                  ;GET THE POINTER TO THE DESCRIPTOR IN [D,E]

  CALL FRETMS             ;FREE UP A TEMORARY POINTING INTO BUF    (Back to last tmp-str entry)
  EX DE,HL                ;STRCPY COPIES [H,L]
  CALL STRCPY             ;COPY VARIABLES IN STRING SPACE OR STRINGS WITH DATA IN BUF

; a.k.a MVSTPT
DNTCPY:
  CALL FRETMS             ;FREE UP THE TEMPORARY WITHOUT FREEING UP ANY STRING SPACE (Back to last tmp-str entry)
  EX (SP),HL              ;[H,L]=PLACE TO STORE THE DESCRIPTOR
                          ;LEAVE A NONSENSE ENTRY ON THE STACK, SINCE THE "POP DE" DOESN'T EVER MATTER IN THIS CASE
LETNUM:
  CALL FP2HL              ;COPY A DESCRIPTOR OR A VALUE
  POP DE                  ;FOR "FOR" POP OFF A POINTER AT THE LOOP VARIABLE INTO [D,E]
  POP HL                  ;GET THE TEXT POINTER BACK
  RET

; 'ON' BASIC instruction
; ON..GOTO, ON ERROR GOTO CODE
__ON:
  CP TK_ERROR             ;"ON...ERROR"?
  JP NZ,ON_OTHER          ;NO.
  CALL CHRGTB             ;GET NEXT THING
  CALL SYNCHR             
  DEFB TK_GOTO            ;MUST HAVE ...GOTO
  CALL ATOH               ;GET FOLLOWING LINE #
  LD A,D                  ;IS LINE NUMBER ZERO?
  OR E                    ;SEE
  JP Z,__ON_0             ;IF ON ERROR GOTO 0, RESET TRAP
  CALL FNDLN1             ;SEE IF LINE EXISTS (SAVE [H,L] ON STACK)	..Sink HL in stack and get first line number
  LD D,B                  ;GET POINTER TO LINE IN [D,E]
  LD E,C                  ;(LINK FIELD OF LINE)
  POP HL                  ;RESTORE [H,L]
  JP NC,UL_ERR            ;ERROR IF LINE NOT FOUND.. Err $08 - "Undefined line number"
__ON_0:
  EX DE,HL                ;GET LINE POINTER IN [H,L]
  LD (ONELIN),HL          ;SAVE POINTER TO LINE OR ZERO IF 0.
  EX DE,HL                ;BACK TO NORMAL
  RET C                   ;YOU WOULDN'T BELIEVE IT IF I TOLD YOU
  LD A,(ONEFLG)           ;ARE WE IN AN "ON...ERROR" ROUTINE?
  OR A                    ;SET CONDITION CODES
  LD A,E                  ;WANT AN EVEN STACK PTR. FOR 8086
  RET Z                   ;IF NOT, HAVE ALREADY DISABLED TRAPPING.
  LD A,(ERRFLG)           ;GET ERROR CODE
  LD E,A                  ;INTO E.
  JP ERRESM               ;FORCE THE ERROR TO HAPPEN

ON_OTHER:
  CALL GETINT             ; Get integer 0-255                  ;GET VALUE INTO [E]
  LD A,(HL)               ; Get "GOTO" or "GOSUB" token        ;GET THE TERMINATOR BACK
  LD B,A                  ; Save in B                          ;SAVE THIS CHARACTER FOR LATER
  CP TK_GOSUB             ; "GOSUB" token?                     ;AN "ON ... GOSUB" PERHAPS?
  JP Z,ONGO               ; Yes - Find line number             ;YES, SOME FEATURE USE
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
  JP ONGOLP               ; Yes - loop

; 'RESUME' BASIC command
__RESUME:
  LD A,(ONEFLG)
  OR A
  JP NZ,__RESUME_0
  LD (ONELIN),A
  LD (ONELIN+1),A
  JP RW_ERR                ;"RESUME WITHOUT ERROR"

__RESUME_0:
  INC A
  LD (ERRFLG),A
  LD A,(HL)
  CP TK_NEXT
  JP Z,__RESUME_1
  CALL ATOH
  RET NZ
  LD A,D
  OR E
  JP Z,__RESUME_SUB_1
  CALL __GOTO_0
  XOR A
  LD (ONEFLG),A
  RET

__RESUME_1:
  CALL CHRGTB
  RET NZ
  DEFB $3E                ; DEFB $3E  ; "LD A,n" to Mask the next byte  (skip "INC A")
__RESUME_SUB_1:
  INC A
  LD HL,(ERRTXT)
  EX DE,HL
  LD HL,(ERRLIN)
  LD (CURLIN),HL
  EX DE,HL
  RET NZ
  LD A,(HL)
  OR A
  JP NZ,__RESUME_2
  INC HL
  INC HL
  INC HL
  INC HL
__RESUME_2:
  INC HL
  XOR A
  LD (ONEFLG),A
  JP __DATA

; 'ERROR' BASIC command
__ERROR:
  CALL GETINT             ; Get integer 0-255
  RET NZ                  ; Return if bad value
  OR A
  JP Z,FC_ERR             ; Err $05 - "Illegal function call"
  JP ERROR

; 'AUTO' BASIC instruction
; AUTO [<line number>[,<increment>]]
__AUTO:
  LD DE,$000A
  PUSH DE
  JP Z,__AUTO_0
  CALL LNUM_PARM
  EX DE,HL
  EX (SP),HL
  JP Z,__AUTO_1
  EX DE,HL
  CALL SYNCHR
  DEFM ","
  EX DE,HL
  LD HL,(AUTINC)
  EX DE,HL
  JP Z,__AUTO_0
  CALL ATOH
  JP NZ,SN_ERR
__AUTO_0:
  EX DE,HL
__AUTO_1:
  LD A,H
  OR L
  JP Z,FC_ERR
  LD (AUTINC),HL
  LD (AUTFLG),A
  POP HL
  LD (AUTLIN),HL
  POP BC
  JP PROMPT

; 'IF' BASIC instruction
__IF:
  CALL EVAL               ; Evaluate expression
  LD A,(HL)               ; Get token
  CP ','
  CALL Z,CHRGTB
  CP TK_GOTO              ; "GOTO" token?
  JP Z,IFGO               ; Yes - Get line
  CALL SYNCHR             ; Make sure it's "THEN"
  DEFB TK_THEN            ; "THEN" token
  DEC HL                  ; Cancel increment
IFGO:
  PUSH HL
  CALL _TSTSGN            ; Test state of expression
  POP HL
  JP Z,FALSE_IF           ; False - Drop through
IFGO_0:
  CALL CHRGTB             ; Get next character
  RET Z                   ; Go to NEWSTT (RUNCNT) if end of STMT
  CP LINCON               ; Line number prefix ?
  JP Z,__GOTO             ; Yes - GOTO that line
  CP $0D
  JP NZ,ONJMP             ; Otherwise do statement
  LD HL,(CONLO)
  RET

FALSE_IF:
  LD D,$01
DROP_THROUGH:
  CALL __DATA
  OR A
  RET Z
  CALL CHRGTB
  CP TK_ELSE
  JP NZ,DROP_THROUGH
  DEC D
  JP NZ,DROP_THROUGH
  JP IFGO_0

; 'LPRINT' BASIC command
__LPRINT:
  LD A,$01
  LD (PRTFLG),A
  JP MRPRNT

; 'PRINT' BASIC command
__PRINT:
  LD C,$02
  CALL GET_CHNUM          ; Look for '#' channel specifier and put the associated file buffer in BC
; This entry point is used by the routines at __LPRINT and PRNTNB.
MRPRNT:
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL CHRGTB
  CALL Z,OUTDO_CRLF       ; CRLF if just PRINT
; This entry point is used by the routine at NEXITM.
PRNTLP:
  JP Z,FINPRT             ; End of list - Exit
  CP TK_USING
  JP Z,__USING
  CP TK_TAB               ; "TAB(" token?
  JP Z,__TAB              ; Yes - Do TAB routine
  CP TK_SPC               ; "SPC(" token?
  JP Z,__TAB              ; Yes - Do SPC routine
  PUSH HL                 ; Save code string address
  CP ','                  ; Comma?
  JP Z,DOCOM              ; Yes - Move to next zone
  CP ';'                  ; Semi-colon?
  JP Z,NEXITM             ; Do semi-colon routine
  POP BC                  ; Code string address to BC
  CALL EVAL               ; Evaluate expression
  PUSH HL                 ; Save code string address
  CALL GETYPR             ; Get the number type (FAC)
  JP Z,PRNTST             ; JP If string type
  CALL FOUT               ; Convert number to text
  CALL CRTST              ; Create temporary string
  LD (HL),' '             ; Followed by a space
  LD HL,(FACCU)           ; Get length of output
  INC (HL)                ; Plus 1 for the space

; Output string contents
;
; Used by the routine at __PRINT.
PRNTST:
  CALL ISFLIO
  JP NZ,_PRNTST
  LD HL,(FACCU)
  LD A,(PRTFLG)
  OR A
  JP Z,PRNTST_0
  LD A,(LPTSIZ)           ; Value for 'WIDTH' on printer output.
  LD B,A
  INC A
  JP Z,_PRNTST            ; 255="infinite" column size
  LD A,(LPTPOS)           ; Get cursor position
  OR A
  JP Z,_PRNTST
  ADD A,(HL)              ; Add length of string
  CCF
  JP NC,PRNTNB
  DEC A                   ; Adjust it
  CP B
  JP PRNTNB

PRNTST_0:
  LD A,(LINLEN)           ; Get width of line
  LD B,A                  ; To B
  INC A
  JP Z,_PRNTST
  LD A,(TTYPOS)           ; Get cursor position
  OR A
  JP Z,_PRNTST
  ADD A,(HL)              ; Add length of string
  CCF
  JP NC,PRNTNB
  DEC A                   ; Adjust it
  CP B                    ; Will output fit on this line?

; Output number string
;
; Used by the routine at PRNTST.
PRNTNB:
  CALL NC,OUTDO_CRLF
; This entry point is used by the routine at PRNTST.
_PRNTST:
  CALL PRS1               ; Output string at (HL)
  POP HL                  ; Restore code string address
  JP MRPRNT               ; See if more to PRINT

; This entry point is used by the routine at __PRINT.
DOCOM:
  LD BC,$0028
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL ISFLIO
  LD A,(HL)
  JP NZ,ZONELP
  LD A,(PRTFLG)
  OR A
  JP Z,PRNTNB_0
  LD A,(COMMAN)           ; Get comma width
  LD B,A                  ; Save in B
  INC A
  LD A,(LPTPOS)
  JP Z,ZONELP
  CP B
  JP PRNTNB_1

PRNTNB_0:
  LD A,(NCMPOS)           ; POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS
  LD B,A
  LD A,(TTYPOS)
  CP $FF
  JP Z,ZONELP
  CP B
PRNTNB_1:
  CALL NC,OUTDO_CRLF
  JP NC,NEXITM
ZONELP:
  SUB 14                  ; Next zone of 14 characters
  JP NC,ZONELP            ; Repeat if more zones
  CPL                     ; Number of spaces to output
  JP ASPCS                ; Output them

; PRINT TAB( or PRINT SPC(
;
; Used by the routine at __PRINT.
__TAB:
  PUSH AF                 ; Save token
  CALL CHRGTB             ; Evaluate expression
  CALL FPSINT_0
  POP AF                  ; Restore token
  PUSH AF                 ; Save token
  CP TK_SPC               ; TK_SPC - Was it "SPC(" ?
  JP Z,__SPC
  DEC DE
__SPC:
  LD A,D
  OR A
  JP P,__TAB_0
  LD DE,$0000
__TAB_0:
  PUSH HL
  CALL ISFLIO
  JP NZ,DOTAB
  LD A,(PRTFLG)
  OR A
  LD A,(LPTSIZ)           ; Value for 'WIDTH' on printer output.
  JP NZ,__TAB_1
  LD A,(LINLEN)
__TAB_1:
  LD L,A
  INC A
  JP Z,DOTAB
  LD H,$00
  CALL IMOD
  EX DE,HL

; TAB/SPC routine
;
; Used by the routine at __TAB.
DOTAB:
  POP HL
  CALL SYNCHR
  DEFM ")"                ; Make sure ")" follows
  DEC HL                  ; Back space on to ")"
  POP AF                  ; Restore token
  SUB TK_SPC              ; Was it "SPC(" ?
  PUSH HL                 ; Save code string address
  JP Z,DOSPC              ; Yes - Do "E" spaces
  LD BC,$0028
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL ISFLIO
  LD A,(HL)
  JP NZ,DOSPC
  LD A,(PRTFLG)
  OR A
  JP Z,DOTAB_0
  LD A,(LPTPOS)           ; Get current printer position
  JP DOSPC

DOTAB_0:
  LD A,(TTYPOS)           ; Get current position
DOSPC:
  CPL                     ; Number of spaces to print to
  ADD A,E                 ; Total number to print
  JP C,ASPCS
  INC A
  JP Z,NEXITM
  CALL OUTDO_CRLF
  LD A,E
  DEC A
  JP M,NEXITM
; This entry point is used by the routine at PRNTNB.
ASPCS:
  INC A                   ; Output A spaces
  LD B,A                  ; Save number to print
  LD A,' '                ; Space
SPCLP:
  CALL OUTDO              ; Output character in A
  DEC B                   ; Count them
  JP NZ,SPCLP             ; Repeat if more

; Move to next item in the PRINT list
;
; Used by the routines at __PRINT, PRNTNB and DOTAB.
NEXITM:
  POP HL                  ; Restore code string address
  CALL CHRGTB             ; Get next character
  JP PRNTLP               ; More to print

; Routine at 6144
;
; Used by the routines at __PRINT, LTSTND, __LOF, __LOAD, L46AB, L5256 and
; STKERR.
FINPRT:
  XOR A
  LD (PRTFLG),A
  PUSH HL
  LD H,A
  LD L,A
  LD (PTRFIL),HL
  POP HL
  RET

; 'LINE INPUT' BASIC command
__LINE:

IF HAVE_GFX
  CP TK_INPUT		; ? Token for INPUT to support the "LINE INPUT" statement ?
  JP NZ,LINE		; No, this is a real graphics command !
ENDIF

  CALL SYNCHR
  DEFB TK_INPUT
  CP '#'
  JP Z,LINE_INPUT
  CALL PUTBUF_3
  CALL __INPUT_0
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  PUSH HL
  CALL PINLIN_0
  POP DE
  POP BC
  JP C,INPBRK
  PUSH BC
  PUSH DE
  LD B,$00
  CALL QTSTR_0
  POP HL
  LD A,$03
  JP __LET_0

; Message at 6200
REDO_MSG:
  DEFM "?Redo from start"
  DEFB $0D
  DEFB $0A
  DEFB $00

; 06219
;
; Used by the routine at INPUT_SUB.
L184B:
  INC HL
  LD A,(HL)
  OR A
  JP Z,SN_ERR
  CP '"'
  JP NZ,L184B
  JP INPUT_SUB_4

; This entry point is used by the routine at INPUT_SUB.
L184B_0:
  POP HL
  POP HL
  JP L184B_2
; This entry point is used by the routine at LTSTND.
L184B_1:
  LD A,(FLGINP)
  OR A
  JP NZ,DATSNR
; This entry point is used by the routine at INPUT_SUB.
L184B_2:
  POP BC
  LD HL,REDO_MSG
  CALL PRS
  LD HL,(SAVTXT)
  RET

; INPUT #, deal with stream number
;
; Used by the routine at __INPUT.
SET_INPUT_CHANNEL:
  CALL GET_CHANNEL
  PUSH HL
  LD HL,BUFMIN
  JP INPUT_CHANNEL

; 'INPUT' BASIC command
__INPUT:
  CP '#'
  JP Z,SET_INPUT_CHANNEL
  CALL PUTBUF_3
  LD BC,INPUT_SUB
  PUSH BC
; This entry point is used by the routine at __LINE.
__INPUT_0:
  CP '"'                  ; Is there a prompt string?
  LD A,$00                ; Clear A and leave flags
  LD (CTLOFG),A           ; Enable output
  LD A,$FF
  LD (IMPFLG),A
  RET NZ
  CALL QTSTR
  LD A,(HL)
  CP ','
  JP NZ,__INPUT_1
  XOR A
  LD (IMPFLG),A
  CALL CHRGTB
  JP __INPUT_2

__INPUT_1:
  CALL SYNCHR
  DEFM ";"
__INPUT_2:
  PUSH HL
  CALL PRS1
  POP HL
  RET

; INPUT_SUB
INPUT_SUB:
  PUSH HL                   ; Save code string address
  LD A,(IMPFLG)
  OR A
  JP Z,INPUT_SUB_0
  LD A,'?'                  ; Get input with "? " prompt
  CALL OUTDO                ; Output character
  LD A,' '                  ; Space
  CALL OUTDO                ; Output character
INPUT_SUB_0:
  CALL PINLIN_0             ; Get input line
  POP BC                    ; Restore code string address
  JP C,INPBRK
  PUSH BC                   ; Re-save code string address
  XOR A
  LD (FLGINP),A
  LD (HL),','               ; Store comma as separator
  EX DE,HL
  POP HL
  PUSH HL
  PUSH DE
  PUSH DE
  DEC HL
INPUT_SUB_1:
  LD A,$80
  LD (SUBFLG),A
  CALL CHRGTB
  CALL _GETVAR
  LD A,(HL)
  DEC HL
  CP '['
  JP Z,INPUT_SUB_2
  CP '('
  JP NZ,INPUT_SUB_6
INPUT_SUB_2:
  INC HL
  LD B,$00
INPUT_SUB_3:
  INC B
; This entry point is used by the routine at L184B.
INPUT_SUB_4:
  CALL CHRGTB
  JP Z,SN_ERR
  CP '"'
  JP Z,L184B
  CP '('
  JP Z,INPUT_SUB_3
  CP '['
  JP Z,INPUT_SUB_4
  CP ']'
  JP Z,INPUT_SUB_5
  CP ')'
  JP NZ,INPUT_SUB_4
INPUT_SUB_5:
  DEC B
  JP NZ,INPUT_SUB_4
INPUT_SUB_6:
  CALL CHRGTB
  JP Z,INPUT_SUB_7
  CP ','
  JP NZ,SN_ERR
INPUT_SUB_7:
  EX (SP),HL
  LD A,(HL)
  CP ','
  JP NZ,L184B_0
  LD A,$01
  LD (RESFLG_OLD),A
  CALL __READ_0
  LD A,(RESFLG_OLD)
  DEC A
  JP NZ,L184B_0
  PUSH HL
  CALL GETYPR
  CALL Z,GSTRCU
  POP HL
  DEC HL
  CALL CHRGTB
  EX (SP),HL
  LD A,(HL)
  CP ','
  JP Z,INPUT_SUB_1
  POP HL
  DEC HL
  CALL CHRGTB
  OR A
  POP HL
  JP NZ,L184B_2

; 'INPUT' from a stream
;
; Used by the routine at SET_INPUT_CHANNEL.
INPUT_CHANNEL:
  LD (HL),','
  JP _READ_CH

; 'READ' BASIC command
__READ:
  PUSH HL                 ; Save code string address
  LD HL,(DATPTR)          ; Next DATA statement
  
  DEFB $F6                ; OR AFh ..Flag "READ"
  
; This entry point is used by the routine at INPUT_CHANNEL.
_READ_CH:
  XOR A                   ; Flag "INPUT"
  LD (FLGINP),A           ; Save "READ"/"INPUT" flag
  EX (SP),HL              ; Get code str' , Save pointer
  JP GTVLUS               ; Get values
; This entry point is used by the routine at LTSTND.
_READ_00:
  CALL SYNCHR             ; Check for comma between items
  DEFM ","
  
GTVLUS:
  CALL GETVAR
  EX (SP),HL              ; Save code str" , Get pointer
  PUSH DE                 ; Save variable address
  LD A,(HL)               ; Get next "INPUT"/"DATA" byte
  CP ','                  ; Comma?
  JP Z,ANTVLU             ; Yes - Get another value
  LD A,(FLGINP)           ; Is it READ?
  OR A
  JP NZ,FDTLP             ; Yes - Find next DATA stmt
; This entry point is used by the routine at FDTLP.
ANTVLU:
  DEFB $F6                ; OR AFh ..hides the "XOR A" instruction
; This entry point is used by the routine at INPUT_SUB.
__READ_0:
  XOR A
  LD (READFLG),A
  CALL ISFLIO
  JP NZ,__READ_INPUT
  CALL GETYPR             ; Check data type
  PUSH AF
  JP NZ,INPBIN            ; If numeric, convert to binary
  CALL CHRGTB             ; Get next character
  LD D,A                  ; Save input character
  LD B,A                  ; Again
  CP '"'                  ; Start of literal sting?
  JP Z,STRENT             ; Yes - Create string entry
  LD A,(FLGINP)           ; "READ" or "INPUT" ?
  OR A
  LD D,A                  ; Save 00 if "INPUT"
  JP Z,ITMSEP
  LD D,$3A
ITMSEP:
  LD B,$2C
  DEC HL
STRENT:
  CALL DTSTR              ; Get string terminated by D

; $19a6
__READ_DONE:
  POP AF
  ADD A,$03
  LD C,A
  LD A,(READFLG)
  OR A
  RET Z
  LD A,C
  EX DE,HL
  LD HL,LTSTND
  EX (SP),HL
  PUSH DE
  JP __LET_1

; This entry point is used by the routine at __READ.
INPBIN:
  CALL CHRGTB             ; Get next character
  POP AF
  PUSH AF
  LD BC,__READ_DONE
  PUSH BC
  JP C,DBL_ASCTFP_0
  JP DBL_ASCTFP

; Where to go after LETSTR
LTSTND:
  DEC HL
  CALL CHRGTB             ; Get next character
  JP Z,MORDT              ; End of line - More needed?
  CP ','                  ; Another value?
  JP NZ,L184B_1           ; No - Bad input
MORDT:
  EX (SP),HL              ; Get code string address
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL CHRGTB             ; Get next character
  JP NZ,_READ_00          ; More needed - Get it
  POP DE                  ; Restore DATA pointer
  LD A,(FLGINP)           ; "READ" or "INPUT" ?
  OR A
  EX DE,HL                ; DATA pointer to HL
  JP NZ,UPDATA            ; Update DATA pointer if "READ"
  PUSH DE                 ; Move code string address
  POP HL                  ; .. to HL
  JP FINPRT


; Find next DATA statement
;
; Used by the routine at __READ.
FDTLP:
  CALL __DATA             ; Get next statement
  OR A                    ; End of line?
  JP NZ,FANDT             ; No - See if DATA statement
  INC HL
  LD A,(HL)               ; End of program?
  INC HL
  OR (HL)                 ; 00 00 Ends program
  LD E,$04                ; Err $04 - "Out of DATA" (?OD Error)
  JP Z,ERROR              ; Yes - Out of DATA
  INC HL
  LD E,(HL)               ; LSB of line number
  INC HL
  LD D,(HL)               ; MSB of line number
  EX DE,HL
  LD (DATLIN),HL          ; Set line of current DATA item
  EX DE,HL
FANDT:
  CALL CHRGTB             ; Get next character
  CP $84                  ; "DATA" token
  JP NZ,FDTLP             ; No "DATA" - Keep looking
  JP ANTVLU               ; Found - Convert input

; Routine at 6670
;
; Used by the routines at DOFN, __LSET and FN_INSTR.
NEXT_EQUAL:
  CALL SYNCHR
  DEFB TK_EQUAL           ; Token code for '='
  JP EVAL

; Routine at 6677
;
; Used by the routines at EVLPAR, OPRND_3 and FN_INSTR.
OPNPAR:
  CALL SYNCHR            ; Make sure "(" follows
  DEFM "("

; Routine at 6681
;
; Used by the routines at __FOR, FORFND, __LET, __IF, __PRINT, NEXT_EQUAL,
; DOFN, FPSINT, GETINT, __POKE, __RANDOMIZE, FNAME, __OPEN, GET_CHNUM, __WEND,
; __CHAIN, L46AB, L5256, L52F3, FN_STRING and FN_INSTR.

EVAL:
  DEC HL                  ; Evaluate expression & save
; This entry point is used by the routines at FORFND and __USING.
EVAL_0:
  LD D,$00                ; Precedence value
; This entry point is used by the routines at _EVAL, MINUS and NOT.
EVAL_1:
  PUSH DE                 ; Save precedence
  LD C,$01
  CALL CHKSTK             ; Check for 1 level of stack
  CALL OPRND              ; Get next expression value
  XOR A
  LD (RESFLG),A

; Evaluate expression until precedence break
EVAL2:
  LD (NXTOPR),HL          ; Save address of next operator
; This entry point is used by the routine at NOT.

EVAL3:
  LD HL,(NXTOPR)          ; Restore address of next opr

  POP BC                  ; Precedence value and operator
  LD A,(HL)               ; Get next operator / function
  LD (TEMP3),HL
  CP TK_GREATER           ; Token code for '>'
  RET C
  CP TK_PLUS              ; Token code for '+'
  JP C,_EVAL_1
  SUB TK_PLUS             ; Token code for '+'
  LD E,A                  ; Coded operator
  JP NZ,FOPRND
  LD A,(VALTYP)           ; Get data type
  CP $03                  ; String ?
  LD A,E                  ; Coded operator
  JP Z,CONCAT             ; If so, string concatenation (use '+' to join strings)
FOPRND:
  CP $0C                  ; Hex or another numeric prefix ?
  RET NC
  LD HL,PRITAB            ; ARITHMETIC PRECEDENCE TABLE
  LD D,$00
  ADD HL,DE               ; To the operator concerned
  LD A,B                  ; Last operator precedence
  LD D,(HL)               ; Get evaluation precedence
  CP D                    ; Compare with eval precedence
  RET NC                  ; Exit if higher precedence
  PUSH BC                 ; Save last precedence & token
  LD BC,EVAL3             ; Where to go on prec' break
  PUSH BC                 ; Save on stack for return
  LD A,D
  CP $7F                  ; '^' as mapped in PRITAB
  JP Z,EVAL_EXPONENT
  CP $51
  JP C,EVAL_BOOL          ; one less than AND as mapped in PRITAB
  AND $FE                 
  CP $7A                  ; MOD as mapped in PRITAB          
  JP Z,EVAL_BOOL
  
EVAL_NUMERIC:
  LD HL,FACCU
  LD A,(VALTYP)
  SUB $03                 ; String ?
  JP Z,TM_ERR             ; Type error
  OR A
  
  ; Stack this one and get next
  LD C,(HL)
  INC HL   
  LD B,(HL)
  PUSH BC
  JP M,EVAL_NEXT
  
  ; Stack this one and get next
  INC HL
  LD C,(HL) 
  INC HL    
  LD B,(HL) 
  PUSH BC
  JP PO,EVAL_NEXT
  
  ; Stack this one and get next
  LD HL,FACLOW
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  LD C,(HL)
  INC HL   
  LD B,(HL)
  PUSH BC

EVAL_NEXT:
  ADD A,$03
  LD C,E
  LD B,A
  PUSH BC
  LD BC,EVAL_VALTYP

EVAL_MORE:
  PUSH BC               ; Save routine address
  LD HL,(TEMP3)         ; Address of current operator
  JP EVAL_1             ; Loop until prec' break


_EVAL_1:
  LD D,$00
_EVAL3:
  SUB $EF
  JP C,NO_COMPARE_TK
  CP $03
  JP NC,NO_COMPARE_TK
  CP $01
  RLA
  XOR D
  CP D
  LD D,A
  JP C,SN_ERR
  LD (TEMP3),HL
  CALL CHRGTB
  JP _EVAL3

EVAL_EXPONENT:
  CALL __CSNG
  CALL STAKFP
  LD BC,POWER
  LD D,$7F
  JP EVAL_MORE

EVAL_BOOL:
  PUSH DE
  CALL __CINT
  POP DE
  PUSH HL
  LD BC,EVAL_BOOL_END
  JP EVAL_MORE

NO_COMPARE_TK:
  LD A,B
  CP $64			; 100
  RET NC
  PUSH BC
  PUSH DE
  LD DE,$6404		; const value
  LD HL,L1D59
  PUSH HL
  CALL GETYPR
  JP NZ,EVAL_NUMERIC
  LD HL,(FACCU)
  PUSH HL
  LD BC,EVAL_STR
  JP EVAL_MORE

EVAL_VALTYP:
  POP BC
  LD A,C
  LD (DORES),A
  LD A,(VALTYP)
  CP B
  JP NZ,_EVAL_4
  CP $02
  JP Z,EVAL_INTEGER
  CP $04
  JP Z,_EVAL_VALTYP_6
  JP NC,_EVAL_VALTYP_1
_EVAL_4:
  LD D,A
  LD A,B
  CP $08
  JP Z,_EVAL_VALTYP_0
  LD A,D
  CP $08

; Save precedence and eval until precedence break
_EVAL_VALTYP:
  JP Z,_EVAL_VALTYP_5
  LD A,B
  CP $04
  JP Z,EVAL_SINGLE_PREC
  LD A,D
  CP $03
  JP Z,TM_ERR
  JP NC,EVAL_FP
; This entry point is used by the routine at _EVAL.
EVAL_INTEGER:
  LD HL,INT_OPR
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP DE
  LD HL,(FACCU)
  PUSH BC
  RET

; This entry point is used by the routine at _EVAL.
_EVAL_VALTYP_0:
  CALL __CDBL
; This entry point is used by the routine at _EVAL.
_EVAL_VALTYP_1:
  CALL FP_ARG2HL
  POP HL
  LD (FACLOW+2),HL
  POP HL
  LD (FACLOW),HL
_EVAL_VALTYP_2:
  POP BC
  POP DE
  CALL FPBCDE
_EVAL_VALTYP_3:
  CALL __CDBL
  LD HL,DEC_OPR
_EVAL_VALTYP_4:
  LD A,(DORES)
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

_EVAL_VALTYP_5:
  LD A,B
  PUSH AF
  CALL FP_ARG2HL
  POP AF
  LD (VALTYP),A
  CP $04
  JP Z,_EVAL_VALTYP_2
  POP HL
  LD (FACCU),HL
  JP _EVAL_VALTYP_3

EVAL_SINGLE_PREC:
  CALL __CSNG
; This entry point is used by the routine at _EVAL.
_EVAL_VALTYP_6:
  POP BC
  POP DE
_EVAL_VALTYP_7:
  LD HL,FLT_OPR
  JP _EVAL_VALTYP_4

EVAL_FP:
  POP HL
  CALL STAKFP
  CALL HL_CSNG
  CALL BCDEFP
  POP HL
  LD (FACCU+2),HL
  POP HL
  LD (FACCU),HL
  JP _EVAL_VALTYP_7

; Integer DIVIDE
IDIV:
  PUSH HL
  EX DE,HL
  CALL HL_CSNG
  POP HL
  CALL STAKFP
  CALL HL_CSNG
  JP DIV

; Get next expression value
;
; Used by the routines at EVAL and CONCAT.
OPRND:
  CALL CHRGTB             ; Gets next character (or token) from BASIC text.
  JP Z,OPERAND_ERR        ; No operand - "Missing Operand" Error
  JP C,DBL_ASCTFP_0       ; JP if numeric type
  CALL IS_ALPHA_A         ; See if a letter
  JP NC,EVAL_VARIABLE     ; Letter - Find variable
  CP ' '
  JP C,NTRSC2_0           ; JP if control code
  INC A
  JP Z,OPRND_3            ; ($FF)
  DEC A
  CP TK_PLUS              ; ( $F2 = Token for '+' )
  JP Z,OPRND
  CP TK_MINUS             ; ( $F3 = Token for '-' )
  JP Z,MINUS
  CP '"'                  ; Literal string ?
  JP Z,QTSTR              ; Get string terminated by '"' (eval quoted string)
  CP TK_NOT               ; ( $D5 = Token for NOT )
  JP Z,NOT
  CP '&'
  JP Z,HEXTFP
  CP TK_ERR               ; ( $D7 = Token for ERR )
  JP NZ,OPRND_0

; 'ERR' BASIC function
__ERR:
  CALL CHRGTB
  LD A,(ERRFLG)
  PUSH HL
  CALL PASSA
  POP HL
  RET

; This entry point is used by the routine at OPRND.
OPRND_0:
  CP TK_ERL
  JP NZ,OPRND_1

; 'ERL' BASIC function
__ERL:
  CALL CHRGTB
  PUSH HL
  LD HL,(ERRLIN)
  CALL DBL_ABS_0
  POP HL
  RET

; This entry point is used by the routine at __ERR.
OPRND_1:

IF HAVE_GFX
  CP TK_POINT 
  JP Z,FN_POINT
ENDIF

  CP TK_VARPTR
  JP NZ,OPRND_MORE
VARPTR:
  CALL CHRGTB
  CALL SYNCHR
  DEFM "("
  CP '#'
  JP NZ,VARPTR_VAR
VARPTR_BUF:
  CALL FNDNUM		; Numeric argument (0..255)
  PUSH HL
  CALL GETPTR
  POP HL
  JP VARPTR_1

VARPTR_VAR:
  CALL _GETVAR
VARPTR_1:
  CALL SYNCHR
  DEFM ")"
  PUSH HL
  EX DE,HL
  LD A,H
  OR L
  JP Z,FC_ERR
  CALL INT_RESULT_HL
  POP HL
  RET

; (continued)..get next expression value
;
; Used by the routine at __ERL.
OPRND_MORE:
  CP TK_USR
  JP Z,FN_USR
  CP TK_INSTR
  JP Z,FN_INSTR
  CP TK_INKEY_S
  JP Z,FN_INKEY
  CP TK_STRING
  JP Z,FN_STRING
  CP TK_INPUT
  JP Z,FN_INPUT
  CP TK_FN
  JP Z,DOFN

; End of expression.  Look for ')'.
;
; Used by the routines at OPRND_3 and FN_USR.
EVLPAR:
  CALL OPNPAR        ; Evaluate expression in "()"
  CALL SYNCHR        ; Make sure ")" follows
  DEFM ")"
  RET

; '-', deal with minus sign
;
; Used by the routine at OPRND.
MINUS:
  LD D,$7D           ; "-" precedence
  CALL EVAL_1        ; Evaluate until prec' break
  LD HL,(NXTOPR)     ; Get next operator address
  PUSH HL            ; Save next operator address
  CALL INVSGN        ; Negate value

; POP HL / RET
RETNUM:
  POP HL             ; Restore next operator address
  RET

; (a.k.a. CONVAR)
;
; Used by the routine at OPRND.
EVAL_VARIABLE:
  CALL GETVAR
EVAL_VARIABLE_1:
  PUSH HL
  EX DE,HL
  LD (FACCU),HL
  CALL GETYPR
  CALL NZ,FP_HL2DE
  POP HL
  RET

; Get char from (HL) and make upper case
;
; Used by the routines at CRNCLP, CRNCH_MORE, NOTRES and INIT.
MAKUPL:
  LD A,(HL)

; Make char in 'A' upper case
;
; Used by the routines at DETOKEN_MORE, HEXTFP and DISPED.
UCASE:
  CP $61
  RET C
  CP $7B
  RET NC
  AND $5F
  RET

; This entry point is used by the routine at INIT.
UCASE_0:
  CP '&'
  JP NZ,ATOH

; HEX or other specified base (ASCII) to FP number
;
; Used by the routines at DETOKEN_MORE, OPRND and H_ASCTFP.
HEXTFP:
  LD DE,$0000
  CALL CHRGTB
  CALL UCASE
  CP 'O'				; &O ..octal prefix
  JP Z,HEXTFP_4         
  CP 'H'				; &H ..hex prefix
  JP NZ,HEXTFP_3
  LD B,$05
HEXTFP_0:
  INC HL
  LD A,(HL)
  CALL UCASE
  CALL IS_ALPHA_A
  EX DE,HL
  JP NC,HEXTFP_1		; JP if letter
  
  CP '9'+1
  JP NC,HEXTFP_5
  SUB '0'				; Transform to 0-F
  JP C,HEXTFP_5
  JP HEXTFP_2

HEXTFP_1:
  CP 'H'-1
  JP NC,HEXTFP_5
  SUB '7'
HEXTFP_2:
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  OR L
  LD L,A
  EX DE,HL
  DEC B
  JP NZ,HEXTFP_0
  JP OV_ERR
  
HEXTFP_3:
  DEC HL
HEXTFP_4:
  CALL CHRGTB
  EX DE,HL
  JP NC,HEXTFP_5
  CP '8'
  JP NC,SN_ERR
  LD BC,OV_ERR
  PUSH BC
  ADD HL,HL
  RET C
  ADD HL,HL
  RET C
  ADD HL,HL
  RET C
  POP BC
  LD B,$00
  SUB '0'                 ; convert from ASCII
  LD C,A
  ADD HL,BC
  EX DE,HL
  JP HEXTFP_4

HEXTFP_5:
  CALL INT_RESULT_HL
  EX DE,HL
  RET

; OPRND_3
;
; Used by the routine at OPRND.
OPRND_3:
  INC HL
  LD A,(HL)
  SUB $81                ; Is it a function?  -$80-1
  CP TK_RND-1
  JP NZ,FNOFST           ; Yes - Evaluate function
  PUSH HL
  CALL CHRGTB            ; Make sure "(" follows
  CP '('
  POP HL
  JP NZ,RND_SUB
  LD A,$07
FNOFST:
  LD B,$00               ; Get address of function
  RLCA                   ; Double function offset
  LD C,A                 ; BC = Offset in function table
  PUSH BC                ; Save adjusted token value
  CALL CHRGTB            ; Get next character
  LD A,C                 ; Get adjusted token value
  CP $05                 ; Adj' LEFT$,RIGHT$ or MID$ ?
  JP NC,FNVAL            ; No - Do function
  CALL OPNPAR            ; Evaluate expression  (X,...
  CALL SYNCHR            ; Make sure "," follows
  DEFM ","               
  CALL TSTSTR            ; Make sure it's a string
  EX DE,HL               ; Save code string address
  LD HL,(FACCU)          ; Get address of string
  EX (SP),HL             ; Save address of string
  PUSH HL                ; Save adjusted token value
  EX DE,HL               ; Restore code string address
  CALL GETINT            ; Get integer 0-255
  EX DE,HL               ; Save code string address
  EX (SP),HL             ; Save integer,HL = adj' token
  JP GOFUNC              ; Jump to string function

FNVAL:
  CALL EVLPAR            ; Evaluate expression
  EX (SP),HL             ; HL = Adjusted token value
  LD A,L
  CP TK_ABS*2            ; Adj' SGN, INT or ABS ?
  JP C,OPRND_3_2
  CP TK_ATN*2-1          ; Adj' ABS, SQR, RND, SIN, LOG, EXP, COS, TAN or ATN ?
  PUSH HL
  CALL C,__CSNG
  POP HL
OPRND_3_2:
  LD DE,RETNUM          ; Return number from function (POP HL / RET)
  PUSH DE               ; Save on stack
  LD A,$01
  LD (RESFLG),A
GOFUNC:
  LD BC,FNCTAB_FN       ; Function routine addresses
; This entry point is used by the routine at DOFN.
GOFUNC_0:
  ADD HL,BC             ; Point to right address
  LD C,(HL)             ; Get LSB of address
  INC HL                ;
  LD H,(HL)             ; Get MSB of address
  LD L,C                ; Address to HL
  JP (HL)               ; Jump to function

; Routine at 7497
;
; Used by the routine at _ASCTFP.
SGNEXP:
  DEC D                   ; Dee to flag negative exponent
  CP TK_MINUS             ; .."-" token ?
  RET Z                   ; Yes - Return
  CP '-'                  ; "-" ASCII ?
  RET Z                   ; Yes - Return
  INC D                   ; Inc to flag positive exponent
  CP '+'                  ; "+" ASCII ?
  RET Z                   ; Yes - Return
  CP TK_PLUS              ; .."+" token ?
  RET Z                   ; Yes - Return
  DEC HL                  ; DEC 'cos GETCHR INCs
  RET                     ; Return "NZ"

; Routine at 7513
L1D59:
  INC A
  ADC A,A
  POP BC
  AND B
  ADD A,$FF
  SBC A,A
  CALL INT_RESULT_A
  JP NOT_0

; 'NOT' boolean expression
;
; Used by the routine at OPRND.
NOT:
  LD D,$5A                ; Precedence value for "NOT"
  CALL EVAL_1             ; Eval until precedence break
  CALL __CINT             ; Get integer -32768 - 32767
  LD A,L                  ; Get LSB
  CPL                     ; Invert LSB
  LD L,A                  ; Save "NOT" of LSB
  LD A,H                  ; Get MSB
  CPL                     ; Invert MSB
  LD H,A                  ; Set "NOT" of MSB
  LD (FACCU),HL           ; Save AC as current
  POP BC                  ; Clean up stack
; This entry point is used by the routine at L1D59.
NOT_0:
  JP EVAL3               ; Continue evaluation

; Test number FAC type (Precision mode, etc..)
;
; Used by the routines at DETOKEN_MORE, SAVSTP, __PRINT, INPUT_SUB, __READ,
; _EVAL, EVAL_VARIABLE, DOFN, __POKE, INVSGN, _TSTSGN, FP_DE2HL, __CINT,
; __CSNG, __CDBL, TSTSTR, __FIX, __INT, _ASCTFP, MULTEN, DECDIV_SUB, PUFOUT,
; L3356, RNGTST, __READ_INPUT, LINE_INPUT, __CALL, L46AB, L4F11, __TROFF,
; FN_STRING, FN_INSTR and __FRE.
GETYPR:
  LD A,(VALTYP)
  CP $08                  ; set M,PO.. flags
  JP NC,GETYPR_0
  SUB $03
  OR A
  SCF
  RET
GETYPR_0:
  SUB $03
  OR A
  RET

; Routine at 7564
EVAL_BOOL_END:
  LD A,B
  PUSH AF
  CALL __CINT
  POP AF
  POP DE
  CP $7A					; MOD as mapped in PRITAB
  JP Z,IMOD
  CP $7B					; '\' as mapped in PRITAB
  JP Z,INT_DIV
  LD BC,GIVINT
  PUSH BC
  CP $46
  JP NZ,SKIP_OR

; 'OR' boolean expression
OR:
  LD A,E
  OR L
  LD L,A
  LD A,H
  OR D
  RET
; This entry point is used by the routine at EVAL_BOOL_END.
SKIP_OR:
  CP $50
  JP NZ,SKIP_AND

; 'AND' boolean expression
AND:
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET
; This entry point is used by the routine at OR.
SKIP_AND:
  CP $3C
  JP NZ,SKIP_XOR

; 'XOR' boolean expression
XOR:
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET
; This entry point is used by the routine at AND.
SKIP_XOR:
  CP $32
  JP NZ,IMP

; 'EQV' boolean expression
EQV:
  LD A,E
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
  
; This entry point is used by the routine at __FRE.
IMP_0:
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP DBL_ABS_0

; 'LPOS' BASIC command
__LPOS:
  LD A,(LPTPOS)
  JP __POS_0

; 'POS' BASIC instruction
; Returns the current cursor position. The leftmost position is 1.
__POS:
  LD A,(TTYPOS)
; This entry point is used by the routine at __LPOS.
__POS_0:
  INC A

; Exit from function, result in A
;
; Used by the routines at __ERR, ISMID, __DELETE, __LOF and __VAL.
PASSA:
  LD L,A
  XOR A
; This entry point is used by the routine at __LOC.
GIVINT:
  LD H,A
  JP INT_RESULT_HL

; Routine at 7666
;
; Used by the routine at OPRND_MORE.
FN_USR:
  CALL GET_USR_JPTAB_ADDR
  PUSH DE
  CALL EVLPAR
  EX (SP),HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,POPHLRT
  PUSH HL
  PUSH DE
  LD A,(VALTYP)
  PUSH AF
  CP $03
  CALL Z,GSTRCU
  POP AF
  EX DE,HL
  LD HL,FACCU
  RET

; This entry point is used by the routine at DEF_USR.
GET_USR_JPTAB_ADDR:
  CALL CHRGTB
  LD BC,$0000
  CP $1B
  JP NC,FN_USR_0
  CP $11
  JP C,FN_USR_0
  CALL CHRGTB
  LD A,(CONLO)
  OR A
  RLA
  LD C,A
FN_USR_0:
  EX DE,HL
  LD HL,USR0
  ADD HL,BC
  EX DE,HL
  RET

; Routine at 7729
;
; Used by the routine at __DEF.
DEF_USR:
  CALL GET_USR_JPTAB_ADDR
  PUSH DE
  CALL SYNCHR
  DEFB TK_EQUAL           ; Token code for '='
  CALL GETWORD
  EX (SP),HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; 'DEF' BASIC instruction
__DEF:
  CP TK_USR
  JP Z,DEF_USR

; DEF FN<name>[«parameter list>}]=<function definition>
;
  CALL CHEKFN             ; Get "FN" and name
  CALL IDTEST             ; Test for illegal direct
  EX DE,HL                ; To get next statement
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  LD A,(HL)
  CP '('
  JP NZ,__DATA            ; To get next statement
  CALL CHRGTB
__DEF_00:
  CALL GETVAR             ; Get argument variable name
  LD A,(HL)
  CP ')'
  JP Z,__DATA             ; To get next statement
  CALL SYNCHR
  DEFM ","
  JP __DEF_00

; Routine at 7787
;
; Used by the routine at OPRND_MORE.
DOFN:
  CALL CHEKFN             ; Make sure "FN" follows and get FN name
  LD A,(VALTYP)
  OR A
  PUSH AF
  LD (NXTOPR),HL          ; Next operator in EVAL
  EX DE,HL
  LD A,(HL)               ; Get LSB of FN code string
  INC HL
  LD H,(HL)               ; Get MSB of FN code string
  LD L,A
  LD A,H                  ; Is function DEFined?
  OR L
  JP Z,UFN_ERR            ; If not, "Undefined user function" error
  LD A,(HL)
  CP '('
  JP NZ,DOFN_4
  CALL CHRGTB
  LD (TEMP3),HL
  EX DE,HL
  LD HL,(NXTOPR)
  CALL SYNCHR
  DEFM "("
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
  LD (NXTOPR),HL
  POP HL
  LD (TEMP3),HL
  POP AF
  CALL CHKTYP
  LD C,$04
  CALL CHKSTK             ; Check for C levels on stack
  LD HL,-8
  ADD HL,SP
  LD SP,HL
  CALL FP_DE2HL
  LD A,(VALTYP)
  PUSH AF
  LD HL,(NXTOPR)
  LD A,(HL)
  CP ')'
  JP Z,DOFN_1
  CALL SYNCHR
  DEFM ","
  PUSH HL
  LD HL,(TEMP3)
  CALL SYNCHR
  DEFM ","
  JP DOFN_0

DOFN_00:
  POP AF
  LD (PRMLN2),A
DOFN_1:
  POP AF
  OR A
  JP Z,DOFN_3
  LD (VALTYP),A
  LD HL,$0000
  ADD HL,SP
  CALL FP_HL2DE
  LD HL,$0008
  ADD HL,SP
  LD SP,HL
  POP DE
  LD L,$03
DOFN_2:
  INC L
  DEC DE
  LD A,(DE)
  OR A
  JP M,DOFN_2
  DEC DE
  DEC DE
  DEC DE
  LD A,(VALTYP)
  ADD A,L
  LD B,A
  LD A,(PRMLN2)
  LD C,A
  ADD A,B
  CP $64
  JP NC,FC_ERR
  PUSH AF
  LD A,L
  LD B,$00
  LD HL,PARM2
  ADD HL,BC
  LD C,A
  CALL DOFN_8
  LD BC,DOFN_00
  PUSH BC
  PUSH BC
  JP __LET_2
DOFN_3:
  LD HL,(NXTOPR)
  CALL CHRGTB
  PUSH HL
  LD HL,(TEMP3)
  CALL SYNCHR
  DEFM ")"
  DEFB $3E                ; "LD A,n" to Mask the next byte
DOFN_4:
  PUSH DE
  LD (TEMP3),HL
  LD A,(PRMLEN)
  ADD A,$04
  PUSH AF
  RRCA
  LD C,A
  CALL CHKSTK             ; Check for C levels on stack
  POP AF
  LD C,A
  CPL
  INC A
  LD L,A
  LD H,$FF
  ADD HL,SP
  LD SP,HL
  PUSH HL
  LD DE,PRMSTK
  CALL DOFN_8
  POP HL
  LD (PRMSTK),HL
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
  LD HL,(FUNACT)
  INC HL
  LD (FUNACT),HL
  LD A,H
  OR L
  LD (NOFUNS),A
  LD HL,(TEMP3)
  CALL NEXT_EQUAL
  DEC HL
  CALL CHRGTB
  JP NZ,SN_ERR
  CALL GETYPR
  JP NZ,DOFN_5
  LD DE,DSCTMP
  LD HL,(FACCU)
  CALL DCOMPR
  JP C,DOFN_5
  CALL STRCPY
  CALL TSTOPL_0
DOFN_5:
  LD HL,(PRMSTK)
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
  LD HL,PRMSTK
  CALL DOFN_8
  EX DE,HL
  LD SP,HL
  LD HL,(FUNACT)
  DEC HL
  LD (FUNACT),HL
  LD A,H
  OR L
  LD (NOFUNS),A
  POP HL
  POP AF

; This entry point is used by the routines at __FOR, __LET and __MKD_S.
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
  
DOFN_7:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
DOFN_8:
  LD A,B
  OR C
  JP NZ,DOFN_7
  RET

; Routine at 8157
;
; Used by the routine at __DEF.
IDTEST:
  PUSH HL                 ; Save code string address
  LD HL,(CURLIN)          ; Get current line number
  INC HL                  ; -1 means direct statement
  LD A,H
  OR L
  POP HL                  ; Restore code string address
  RET NZ                  ; Return if in program
  LD E,$0C                ; Err $0C - "Illegal direct" (ID_ERROR)
  JP ERROR

; Make sure "FN" follows and get FN name
;
; Used by the routines at __DEF and DOFN.
CHEKFN:
  CALL SYNCHR             ; Make sure FN follows
  DEFB TK_FN
  LD A,$80
  LD (SUBFLG),A           ; Flag FN name to find
  OR (HL)                 ; FN name has bit 7 set
  LD C,A                  ; in first byte of name
  JP GTFNAM               ; Get FN name

; Routine at 8185
;
; Used by the routine at EXEC.
ISMID:
  CP $FF-TK_END           ;LHS MID$?
  JP NZ,SN_ERR            ;NO, ERROR.
  INC HL                  ;POINT TO NEXT CHAR
  LD A,(HL)               ;GET FN DESCRIPTOR
  INC HL                  ;BUMP POINTER
  CP $80+TK_MID_S         ;IS IT MID?
  JP Z,LHSMID
  JP SN_ERR               ;NO, ERROR

__INP:
  CALL MAKINT
  LD (INPORT),A
  DEFB $DB                ; IN A,(n)
INPORT:
  DEFB $00                ; Current port for 'INP' function
  JP PASSA

; 'OUT' BASIC command
__OUT:
  CALL SETIO
  DEFB $D3                ; OUT (n),A
OTPORT:
  DEFB $00                ; Current port for 'OUT' statement
  RET

; 'WAIT' BASIC command
__WAIT:
  CALL SETIO
  PUSH AF
  LD E,$00
  DEC HL
  CALL CHRGTB
  JP Z,__WAIT_0
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
__WAIT_0:
  POP AF
  LD D,A
__WAIT_1:
  DEFB $DB                ; IN A,(n)
WAIT_INPORT:
  DEFB $00                ; Current port for 'INP' function
  XOR E
  AND D
  JP Z,__WAIT_1
  RET

;IF ORIGINAL
CONSOL:
  JP SN_ERR			; ???
;ENDIF


; 'WIDTH' BASIC command
; THIS IS THE WIDTH (TERMINAL WIDTH) COMMAND
; ARG MUST BE .GT. 15 AND .LT. 255
;
; WIDTH [LPRINT] <integer expression>
; To set the printed line width in number of characters for the terminal or line printer.
;
__WIDTH:
  CP TK_LPRINT            ;WIDTH LPRINT?
  JP NZ,NOTWLP            ;NO
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
  JP NC,__WIDTH_1
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
; This entry point is used by the routines at GET_POSINT and __TAB.
FPSINT_0:
  CALL EVAL               ;EVALUATE A FORMULA

; Get integer variable to DE, error if negative
;
; Used by the routine at MAKINT.
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

; Get "BYTE,BYTE" parameters
;
; Used by the routines at __OUT and __WAIT.
SETIO:
  CALL GETINT             ;GET INTEGER CHANNEL NUMBER IN [A]
  LD (WAIT_INPORT),A      ;SETUP "WAIT"
  LD (OTPORT),A           ;SETUP "OUT"
  CALL SYNCHR
  DEFM ","                ;MAKE SURE THERE IS A COMMA
  JP GETINT               ; Get integer 0-255

; Load 'A' with the next number in BASIC program
;
; Used by the routines at __ERL and __FIELD.
; a.k.a. GTBYTC:  pick a numeric argument (0..255)
FNDNUM:
  CALL CHRGTB

; Get a number to 'A'
;
; Used by the routines at __ON, __ERROR, OPRND_3, __WAIT, __WIDTH,
; SETIO, __POKE, __OPEN, CLOSE_FILE, FN_INPUT, __NULL, FN_STRING,
; FN_INSTR and MID_ARGSEP.
GETINT:
  CALL EVAL               ;EVALUATE A FORMULA

; Convert tmp string to int in A register
;
; Used by the routines at __INP, GET_CHNUM, __CHR_S, FN_STRING, __SPACE_S
; and FN_INSTR.
MAKINT:
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
  LD HL,65535             ;DONT ALLOW ^C TO CHANGE
  LD (CURLIN),HL          ;CONTINUE PARAMETERS
  POP HL                  ;GET POINTER TO LINE
  POP DE                  ;GET MAX LINE # OFF STACK
  LD C,(HL)               ;[B,C]=THE LINK POINTING TO THE NEXT LINE
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
  CALL DCOMPR
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
  CP $09
  JP Z,__LIST_1
  LD A,' '
  CALL OUTDO
__LIST_1:
  CALL DETOKEN_LIST
  LD HL,BUF
  CALL LISPRT
  CALL OUTDO_CRLF
  JP __LIST_0

; Routine at 8435
;
; Used by the routines at __LIST, TTYLIN, NOTDGI and EDIT_DONE.
LISPRT:
  LD A,(HL)
  OR A
  RET Z
  CALL _PR_CHR
  INC HL
  JP LISPRT

; This entry point is used by the routines at __LIST and __EDIT.
DETOKEN_LIST:
  LD BC,BUF
  LD D,$FF
  XOR A
  LD (INTFLG),A
  CALL PROCHK
  JP PLOOP2
  
DETOKEN_NEXT_1:
  INC BC
  INC HL
  DEC D
  RET Z
; This entry point is used by the routine at CONLIN.
PLOOP2:
  LD A,(HL)                ;GET CHAR FROM BUF
  OR A                     ;SET CC'S
  LD (BC),A                ;SAVE THIS CHAR
  RET Z                    ;IF END OF SOURCE BUFFER, ALL DONE.
  CP $0B                   ;IS IT SMALLER THAN SMALLEST EMBEDDED CONSTANT?   (Not a number constant prefix ?)
  JP C,NTEMBL              ;YES, DONT TREAT AS ONE
  CP DBLCON+1              ;IS IT EMBEDED CONSTANT?
  LD E,A                                                 ;SAVE CHAR IN [E]
  JP C,PRTVAR              ; JP if control code     	;PRINT LEADING SPACE IF NESC.
NTEMBL:
  OR A                     ;SET CC'S
  JP M,PLOOPR              ;RESERVED WORD OF SOME KIND
  LD E,A                   ;SAVE CHAR IN [E]
  CP '.'                   ;DOT IS PART OF VAR NAME
  JP Z,PRTVAR
  CALL TSTANM              ;IS CHAR ALPHANUMERIC
  JP NC,PRTVAR             ;ALPHANUMERIC
  XOR A                    ;MAKE SPECIAL
  JP DETOKEN_NEXT_6
PRTVAR:
  LD A,(INTFLG)            ;WHAT DID WE DO LAST?
  OR A                     ;SET CONDITION CODES
  JP Z,PLOOPG              ;SPECIAL, NEVER INSERT SPACE
  INC A                    ;IN RESERVED WORD?
  JP NZ,PLOOPG             ;NO
  LD A,' '                 ;PUT OUT SPACE BEFORE RESWORD
  LD (BC),A                ;STORE IN BUFFER
  INC BC                   ;INCRMENT POINTER INTO BUFFER
  DEC D                    ;SPACE LEFT?
  RET Z                    ;NO, DONE
PLOOPG:
  LD A,$01
DETOKEN_NEXT_6:
  LD (INTFLG),A
  LD A,E
  CP $0B                  ; (OCTCON) IS IT SMALLER THAN SMALLEST EMBEDDED CONSTANT? (Not a number constant prefix ?)
  JP C,PLOOPZ           ; ...then JP
  CP DBLCON+1                   ;IS IT EMBEDED CONSTANT?
  JP C,NUMLIN           ; JP if control code
PLOOPZ:
  LD (BC),A
  JP DETOKEN_NEXT_1

PLOOPR:
  INC A                  ;SET ZERO IF FN TOKEN
  LD A,(HL)              ;GET CHAR BACK
  JP NZ,NTFNTK           ;NOT FUNCTION JUST TREAT NORMALLY
  INC HL                 ;BUMP POINTER
  LD A,(HL)              ;GET CHAR
  AND $7F                ;TURN OFF HIGH BIT
NTFNTK:
  INC HL                 ;ADVANCE TO POINT AFTER
  CP TK_APOSTROPHE       ;SINGLE QUOTE TOKEN?
  JP NZ,NTQTTK           ;NO, JUMP OUT
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
  JP NZ,FNDWRD
  LD A,(HL)
  INC HL
  CP TK_PLUS			; Token for '+'
  LD A,TK_WHILE
  JP Z,FNDWRD
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
  JP Z,RESSR3             ;IF END OF THIS CHARS TABLE, GO BACK & BUMP C
  INC HL                  ;BUMP SOURCE PTR
  JP P,RESSRC             ;IF NOT END OF THIS RESWRD, THEN KEEP LOOKING
  LD A,(HL)               ;GET PTR TO RESERVED WORD VALUE
  CP B                    ;SAME AS THE ONE WE SEARCH FOR?
  JP NZ,RESSR1            ;NO, KEEP LOOKING.
  EX DE,HL                ;SAVE FOUND PTR IN [H,L]
  CP TK_USR               ;USR FUNCTION TOKEN?
  JP Z,NOISPA             ;DONT INSERT SPACE
  CP TK_FN                ;IS IT FUNCTION TOKEN?
NOISPA:
  LD A,C                  ;GET LEADING CHAR
  POP DE                  ;RESTORE LINE CHAR COUNT
  POP BC                  ;RESTORE DEPOSIT PTR
  LD E,A                  ;SAVE LEADING CHAR
  JP NZ,NTFNEX            ;NOT "FN" EXPANSION
  LD A,(INTFLG)           ;SET CC'S ON TEMPA(=INTFLG)
  OR A
  LD A,$00
  LD (INTFLG),A
  JP MORLNZ

NTFNEX:
  CP 'Z'+1                ;WAS IT A SPECIAL CHAR?
  JP NZ,NTSPCH            ;NON-SPECIAL CHAR
  XOR A                   ;SET NON-SPECIAL
  LD (INTFLG),A
  JP MORPUR               ;PRINT IT

NTSPCH:
  LD A,(INTFLG)           ;WHAT DID WE DO LAST?
  OR A                    ;SPECIAL?
  LD A,$FF                ;FLAG IN RESERVED WORD
  LD (INTFLG),A           ;CLEAR FLAG
MORLNZ:
  JP Z,MORLN0             ;GET CHAR AND PROCEED
  LD A,' '                ;PUT SPACE IN BUFFER
  LD (BC),A
  INC BC
  DEC D                   ;ANY SPACE LEFT IN BUFFER
  JP Z,POPAF              ;NO, RETURN
  
MORLN0:
  LD A,E
  JP MORLN1               ;CONTINUE

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
  JP NZ,NTSPCT            ;NO
  XOR A                   ;CLEAR FLAG
  LD (INTFLG),A           ;TO INSERT SPACE AFTERWARDS
NTSPCT:
  POP HL                  ;RESTORE SOURCE PTR.
  JP PLOOP2               ;GET NEXT CHAR FROM LINE

; This entry point is used by the routine at CRNCH_MORE.
TSTANM:
  CALL IS_ALPHA_A         ;YES
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
  CP $0B                  ;(OCTCON) OCTAL CONSTANT?
  JP Z,OCT_STR            ;PRINT IT
  CP $0C                  ;(HEXCON) HEX CONSTANT?
  JP Z,HEX_STR            ;PRINT IN HEX
  LD HL,(CONLO)           ;GET LINE # VALUE IF ONE.
  JP FOUT                 ;PRINT REMAINING POSSIBILITIES.

; 8739
CONLIN:
  POP BC                  ;RESTORE DEPOSIT PTR.
  POP DE                  ;RESTORE CHAR COUNT
  LD A,(CONSAV)           ;GET SAVED CONSTANT TOKEN
  LD E,'O'                ;ASSUME OCTAL CONSTANT
  CP $0B                  ;(OCTCON) OCTAL CONSTANT?
  JP Z,SAVBAS             ;YES, PRINT IT
  CP $0C                  ;(HEXCON) HEX CONSTANT?
  LD E,'H'                ;ASSUME SO.
  JP NZ,NUMSLN            ;NOT BASE CONSTANT
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
  JP C,TYPSET         
  LD E,'!'                ;ASSUME SINGLE PREC.
  JP Z,TYPSET             ;IS CONTYP=4, WAS SINGLE
  LD E,'#'                ;DOUBLE PREC INDICATOR
TYPSET:
  LD A,(HL)               ;GET LEADING CHAR
  CP ' '                  ;LEADING SPACE
  CALL Z,INCHL            ;GO BY IT
NUMSL2:
  LD A,(HL)               ;GET CHAR FROM NUMBER BUFFER
  INC HL                  ;BUMP POINTER
  OR A                    ;SET CC'S
  JP Z,NUMDN              ;IF ZERO, ALL DONE.
  LD (BC),A               ;SAVE CHAR IN BUF.
  INC BC                  ;BUMP PTR
  DEC D                   ;SEE IF END OF BUFFER
  RET Z                   ;IF END OF BUFFER, RETURN
  LD A,(CONTYP)           ;GET TYPE OF CONSTANT TO BE PRINTED
  CP $04                  ;TEST FOR SINGLE OR DOUBLE PRECISION
  JP C,NUMSL2             ;NO, WAS INTEGER
  DEC BC                  ;PICK UP SAVED CHAR
  LD A,(BC)               ;EASIER THAN PUSHING ON STACK
  INC BC                  ;RESTORE TO POINT WHERE IT SHOULD
  JP NZ,DBLSCN            ;IF DOUBLE, DONT TEST FOR EMBEDED "."
  CP '.'                  ;TEST FOR FRACTION  ; $2E
  JP Z,ZERE               ;IF SINGLE & EMBEDED ., THEN DONT PRINT !   
DBLSCN: 
; Double Precision specifier (exponential syntax, e.g. -1.09432D-06)                   
  CP 'D'                  ;DOUBLE PREC. EXPONENT?
  JP Z,ZERE               ;YES, MARK NO VALUE TYPE INDICATOR NESC.
; Exponential format specifier (e.g. -1.09E-06)
  CP 'E'                  ;SINGLE PREC. EXPONENT?
  JP NZ,NUMSL2            ;NO, PROCEED
ZERE:
  LD E,$00                ;MARK NO PRINTING OF TYPE INDICATOR
  JP NUMSL2               ;KEEP MOVING NUMBER CHARS INTO BUF
  
NUMDN:
  LD A,E                  ;GET FLAG TO INDICATE WHETHER TO INSERT
  OR A                    ;A "D" AFTER DOUBLE PREC. #
  JP Z,NOD                ;NO, DONT INSERT IT
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
  JP NC,FCERRG            ;MUST HAVE A MATCH ON THE UPPER BOUND
  LD D,H                  ;[D,E] =  POINTER AT THE START OF THE LINE
  LD E,L                  ;BEYOND THE LAST LINE IN THE RANGE
  EX (SP),HL              ;SAVE THE POINTER TO THE NEXT LINE
  PUSH HL                 ;SAVE THE POINTER TO THE START OF THE FIRST LINE IN THE RANGE
  CALL DCOMPR             ;MAKE SURE THE START COMES BEFORE THE END
FCERRG:
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
; This entry point is used by the routines at PROMPT and L46AB.
__DELETE_0:
  EX DE,HL                ;[D,E] NOW HAVE THE POINTER TO THE LINE BEYOND THIS ONE
  LD HL,(VARTAB)          ;COMPACTIFYING TO VARTAB
MLOOP:
  LD A,(DE)
  LD (BC),A               ;SHOVING DOWN TO ELIMINATE A LINE
  INC BC
  INC DE
  CALL DCOMPR
  JP NZ,MLOOP             ;DONE COMPACTIFYING?
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
  CALL ADDR_RANGE         ;DONT ALLOW DIRECT IF PROTECTED FILE
  LD A,(HL)               ;GET THE VALUE TO RETURN
  JP PASSA                ;AND FLOAT IT

; 'POKE' BASIC command
__POKE:
  CALL GETWORD            ;READ A FORMULA
  PUSH DE
  CALL ADDR_RANGE
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
  POP DE
  LD (DE),A
  RET
  
; This entry point is used by the routines at DEF_USR and __CLEAR.
GETWORD:
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  EX DE,HL
  POP HL
  RET

; This entry point is used by the routines at __DELETE, HEX_STR, __CALL and
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
  JP Z,__RENUM_1        ;IF JUST 'RESEQ' RESEQ 10 BY 10
  CP ','                ;COMMA
  JP Z,__RENUM_0        ;DONT USE STARTING # OF ZERO
  PUSH DE               ;SAVE [D,E]
  CALL LNUM_PARM        ;GET NEW NN
  LD B,D                ;GET IN IN [B,C] WHERE IT BELONGS
  LD C,E
  POP DE                ;GET BACK [D,E]
  JP Z,__RENUM_1        ;IF EOS, DONE
__RENUM_0:
  CALL SYNCHR
  DEFM ","              ;EXPECT COMMA
  CALL LNUM_PARM        ;GET NEW MM
  JP Z,__RENUM_1        ;IF EOS, DONE
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
  JP __RENUM_4
  
__RENUM_NXT:
  ADD HL,BC             ;ADD INCREMENT INTO
  JP C,FC_ERR           ;UH OH, HIS INC WAS TOO LARGE. (Err $05 - "Illegal function call")
  EX DE,HL              ;FLIP LINK FIELD, ACCUM.
  PUSH HL               ;SAVE LINK FIELD
  LD HL,65529           ;TEST FOR TOO LARGE LINE
  CALL DCOMPR           ;COMPARE TO CURRENT #
  POP HL                ;RESTORE LINK FIELD
  JP C,FC_ERR           ;UH OH, HIS INC WAS TOO LARGE. (Err $05 - "Illegal function call")
__RENUM_4:
  PUSH DE               ;SAVE CURRENT LINE ACCUM
  LD E,(HL)             ;GET LINK FIELD INTO [D,E]
  INC HL                ;GET LOW PART INTO K[A] FOR ZERO TEST
  LD D,(HL)             
  LD A,D                ;GET HIGH PART OF LINK
  OR E                  ;SET CC'S ON LINK FIELD
  EX DE,HL              ;SEE IF NEXT LINK ZERO
  POP DE                ;GET BACK ACCUM LINE #
  JP Z,__RENUM_FIN      ;ZERO, DONE
  LD A,(HL)             ;GET FIRST BYTE OF LINK
  INC HL                ;INC POINTER
  OR (HL)               ;SET CC'S
  DEC HL                ;MOVE POINTER BACK
  EX DE,HL              ;BACK IN [D,E]
  JP NZ,__RENUM_NXT     ;INC COUNT

__RENUM_FIN:
  PUSH BC               ;SAVE INC
  CALL SCCLIN           ;SCAN PROGRAM CONVERTING LINES TO PTRS.
  POP BC                ;GET BACK INC
  POP DE                ;GET NN
  POP HL                ;GET PTR TO FIRST LINE TO RESEQ
__RENUM_LP:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  JP Z,LINE2PTR         ;STOP RESEQING WHEN SEE END OF PGM
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
  JP __RENUM_LP         ;KEEP RESEQING
  
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
  JP Z,SCNPLN           ;SCAN NEXT LINE
  LD C,A                ;SAVE [A]
  LD A,(PTRFLG)         ;CHANGE LINE TOKENS WHICH WAY?
  OR A                  ;SET CC'S
  LD A,C                ;GET BACK CURRENT CHAR
  JP Z,SCNPT2           ;CHANGING POINTERS TO #'S
  CP TK_ERROR           ;IS IT ERROR TOKEN?
  JP NZ,NTERRG          ;NO.
  CALL CHRGTB           ;SCAN NEXT CHAR
  CP TK_GOTO            ;ERROR GOTO?
  JP NZ,_LINE2PTR       ;GET NEXT ONE
  CALL CHRGTB           ;GET NEXT CHAR
  CP LINCON             ; Line number prefix:  LINE # CONSTANT?
  JP NZ,_LINE2PTR       ;NO, IGNORE.
  PUSH DE               ;SAVE [D,E]
  CALL LINGT3           ;GET IT
  LD A,D                ;IS IT LINE # ZERO?
  OR E                  ;SET CC'S
  JP NZ,CHGPTR          ;CHANGE IT TO A POINTER
  JP SCNEX3             ;YES, DONT CHANGE IT
  
NTERRG:
  CP LINCON             ; Line number prefix: LINE # CONSTANT?
  JP NZ,SCNEXT          ;NOT, KEEP SCANNING
  PUSH DE               ;SAVE CURRENT LINE # FOR POSSIBLE ERROR MSG
  CALL LINGT3           ;GET LINE # OF LINE CONSTANT INTO [D,E]
CHGPTR:                 
  PUSH HL               ;SAVE TEXT POINTER JUST AT END OF LINCON 3 BYTES
  CALL SRCHLN           ;TRY TO FIND LINE IN PGM.
  DEC BC                ;POINT TO ZERO AT END OF PREVIOUS LINE
  LD A,$0D              ;CHANGE LINE # TO PTR
  JP C,MAKPTR           ;IF LINE FOUND CHANE # TO PTR
  CALL CONSOLE_CRLF     ;PRINT CRLF IF REQUIRED
  LD HL,LINE_ERR_MSG    ;PRINT "Undefined line" MESSAGE
  PUSH DE               ;SAVE LINE #
  CALL PRS              ;PRINT IT
  POP HL                ;GET LINE # IN [H,L]
  CALL _PRNUM           ;PRINT IT
  POP BC                ;GET TEXT PTR OFF STACK
  POP HL                ;GET CURRENT LINE #
  PUSH HL               ;SAVE BACK
  PUSH BC               ;SAVE BACK TEXT PTR
  CALL LNUM_MSG         ;PRINT IT
SCNPOP:
  POP HL                ;POP OFF CURRENT TEXT POINTER
SCNEX3:
  POP DE                ;GET BACK CURRENT LINE #
  DEC HL                ;BACKUP POINTER

_SCNEXT:
  JP SCNEXT             ;KEEP SCANNING

; Message at 9241
LINE_ERR_MSG:
  DEFM "Undefined line "
  DEFB $00

; Routine at 9257
;
; Used by the routine at _LINE2PTR.
SCNPT2:
  CP PTRCON            ; LINE REFERENCE token ?
  JP NZ,_SCNEXT
  PUSH DE
  CALL LINGT3
  PUSH HL
  EX DE,HL
  INC HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD A,LINCON		; Line number prefix
; This entry point is used by the routine at _LINE2PTR.
MAKPTR:
  LD HL,SCNPOP
  PUSH HL
  LD HL,(CONTXT)

; This entry point is used by the routine at __GOTO.
CONCH2:
  PUSH HL
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC HL
  LD (HL),A
  POP HL
  RET

; This entry point is used by the routines at PROMPT, __DELETE and __CHAIN.
DEPTR:
  LD A,(PTRFLG)
  OR A
  RET Z
  JP SCCPTR

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
  LD A,(OPTBASE_FLG)
  OR A
  JP NZ,DD_ERR
  PUSH HL
  LD HL,(ARYTAB)
  EX DE,HL
  LD HL,(STREND)
  CALL DCOMPR
  JP NZ,DD_ERR
  POP HL
  LD A,(HL)
  SUB '0'                 ; convert from ASCII
  JP C,SN_ERR
  CP $02
  JP NC,SN_ERR
  LD (OPTBASE),A
  INC A
  LD (OPTBASE_FLG),A
  CALL CHRGTB
  RET

; Print string using CHPUT_SP
;
; Used by the routine at DECDIV_SUB.
TXTPUT_SP:
  LD A,(HL)
  OR A
  RET Z
  CALL CHPUT_SP
  INC HL
  JP TXTPUT_SP

; Safe char on stack and JP to CHPUT
;
; Used by the routines at TXTPUT_SP and DECDIV_SUB.
CHPUT_SP:
  PUSH AF
  JP CHPUT

; 'RANDOMIZE' BASIC command
__RANDOMIZE:
  JP Z,__RANDOMIZE_0
  CALL EVAL
  PUSH HL
  CALL __CINT
  JP __RANDOMIZE_2
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
  CALL DBL_ASCTFP_0
  LD A,(HL)
  OR A
  JP NZ,__RANDOMIZE_1
  CALL __CINT
__RANDOMIZE_2:
  LD (RNDX+1),HL
  CALL SEED_SHUFFLE
  POP HL
  RET

; Interactive message to initialize RND
RND_SEED_MSG:
  DEFM "Random number seed (-32768 to 32767)"
  DEFB $00

; Routine at 9460
;
; Used by the routine at __WHILE.
LOOK_FOR_WEND:
  LD C,$1D                ; Err $1D - "WHILE without WEND"
  JP LOOK_FOR
; This entry point is used by the routine at SAVSTP.
LOOK_FOR_NEXT:
  LD C,$1A                ; Err $1A - "FOR Without NEXT"

; Routine at 9467
;
; Used by the routine at LOOK_FOR_WEND.
LOOK_FOR:
  LD B,$00
  EX DE,HL
  LD HL,(CURLIN)
  LD (LOPLIN),HL
  EX DE,HL
LOOK_FOR_0:
  INC B
LOOK_FOR_1:
  DEC HL
LOOK_FOR_2:
  CALL CHRGTB
  JP Z,LOOK_FOR_3
  CP TK_ELSE
  JP Z,LOOK_FOR_4
  CP TK_THEN
  JP NZ,LOOK_FOR_2
LOOK_FOR_3:
  OR A
  JP NZ,LOOK_FOR_4
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  LD E,C
  JP Z,ERROR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (LOPLIN),HL
  EX DE,HL
LOOK_FOR_4:
  CALL CHRGTB
  LD A,C
  CP $1A
  LD A,(HL)
  JP Z,LOOK_FOR_5
  CP TK_WHILE
  JP Z,LOOK_FOR_0
  CP TK_WEND
  JP NZ,LOOK_FOR_1
  DEC B
  JP NZ,LOOK_FOR_1
  RET

LOOK_FOR_5:
  CP TK_FOR
  JP Z,LOOK_FOR_0
  CP TK_NEXT
  JP NZ,LOOK_FOR_1
L254F:
  DEC B                   ; $254F
  RET Z
  CALL CHRGTB
  JP Z,LOOK_FOR_3
  EX DE,HL
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(LOPLIN)
  LD (CURLIN),HL
  EX DE,HL
  PUSH BC
  CALL GETVAR
  POP BC
  DEC HL
  CALL CHRGTB
  LD DE,LOOK_FOR_3
  JP Z,LOOK_FOR_6
  CALL SYNCHR
  DEFM ","
  DEC HL
  LD DE,L254F
LOOK_FOR_6:
  EX (SP),HL
  LD (CURLIN),HL
  POP HL
  PUSH DE
  RET

; Routine at 9601
DBL_ASCTFP_END:
  PUSH AF
  LD A,(RESFLG)
  LD (RESFLG_OLD),A
  POP AF

; This entry point is used by the routine at STKERR.
;BACK TO NORMAL OVERFLOW PRINT MODE
CLROVC:
  PUSH AF
  XOR A
  LD (RESFLG),A
  POP AF
  RET

; ROUND
;
; Used by the routines at __CINT and RNGTST.
ROUND:
  LD HL,FP_HALF           ; Add 0.5 to FPREG

; LOADFP/FADD
;
; Used by the routines at __RND, __COS and __NEXT.
FADD_HLPTR:
  CALL LOADFP             ; Load FP at (HL) to BCDE
  JP FADD

; LOADFP/FSUB
SUBPHL:
  CALL LOADFP             ; FPREG = -FPREG + number at HL

; aka, SUBCDE Subtract BCDE from FP reg
;
; Used by the routines at __EXP and __SIN.
FSUB:
  CALL NEG

; aka FPADD, Add BCDE to FP reg
;
; Used by the routines at __POKE, FADD_HLPTR, __LOG, MLSP10, MULTEN, SMSER1 and
; __SIN.
FADD:
  LD A,B                  ; Get FP exponent
  OR A                    ; Is number zero?
  RET Z                   ; Yes - Nothing to add
  LD A,(FPEXP)            ; Get FPREG exponent
  OR A                    ; Is this number zero?
  JP Z,FPBCDE             ; Yes - Move BCDE to FPREG
  SUB B                   ; BCDE number larger?
  JP NC,NOSWAP            ; No - Don't swap them
  CPL                     ; Two's complement
  INC A                   ; FP exponent
  EX DE,HL
  CALL STAKFP             ; Put FPREG on stack
  EX DE,HL
  CALL FPBCDE             ; Move BCDE to FPREG
  POP BC                  ; Restore number from stack
  POP DE
NOSWAP:
  CP $19                  ; (24+1) Second number insignificant?
  RET NC                  ; Yes - First number is result
  PUSH AF                 ; Save number of bits to scale
  CALL SIGNS              ; Set MSBs & sign of result
  LD H,A                  ; Save sign of result
  POP AF                  ; Restore scaling factor
  CALL SCALE              ; Scale BCDE to same exponent
  LD A,H
  OR A                    ; Result to be positive?
  LD HL,FACCU             ; Point to FPREG
  JP P,MINCDE             ; No - Subtract FPREG from CDE
  CALL PLUCDE             ; Add FPREG to CDE
  JP NC,RONDUP            ; No overflow - Round it up
  INC HL                  ; Point to exponent
  INC (HL)                ; Increment it
  JP Z,OVERR_1            ; Number overflowed - Error
  LD L,$01                ; 1 bit to shift right
  CALL SHRITE_1           ; Shift result right
  JP RONDUP               ; Round it up
MINCDE:
  XOR A                   ; Clear A and carry
  SUB B                   ; Negate exponent
  LD B,A                  ; Re-save exponent
  LD A,(HL)               ; Get LSB of FPREG
  SBC A,E                 ; Subtract LSB of BCDE
  LD E,A                  ; Save LSB of BCDE
  INC HL
  LD A,(HL)               ; Get NMSB of FPREG
  SBC A,D                 ; Subtract NMSB of BCDE
  LD D,A                  ; Save NMSB of BCDE
  INC HL
  LD A,(HL)               ; Get MSB of FPREG
  SBC A,C                 ; Subtract MSB of BCDE
  LD C,A                  ; Save MSB of BCDE
; This entry point is used by the routines at FLGREL and INT.
CONPOS:
  CALL C,COMPL            ; Overflow - Make it positive

; Normalise number
;
; Used by the routine at __RND.
BNORM:
  LD L,B                  ; L = Exponent
  LD H,E                  ; H = LSB
  XOR A
BNRMLP:
  LD B,A                  ; Save bit count
  LD A,C                  ; Get MSB
  OR A                    ; Is it zero?
  JP NZ,PNORM             ; No - Do it bit at a time
  LD C,D                  ; MSB = NMSB
  LD D,H                  ; NMSB= LSB
  LD H,L                  ; LSB = VLSB
  LD L,A                  ; VLSB= 0
  LD A,B                  ; Get exponent
  SUB $08                 ; Count 8 bits
  CP $E0                  ; (-24-8) Was number zero?
  JP NZ,BNRMLP            ; No - Keep normalising

; This entry point is used by the routines at RESDIV, DIV_OVTST1, DECADD,
; DECMUL, L2DC9, DECDIV, DBL_ASCTFP and __EXP.
ZERO_EXPONENT:
  XOR A                   ; Result is zero
; This entry point is used by the routine at __SQR.
SAVE_EXPONENT:
  LD (FPEXP),A            ; Save result as zero
  RET

NORMAL:
  LD A,H
  OR L
  OR D
  JP NZ,BNORM_1
  LD A,C

BNORM_0:
  DEC B                   ; Count bits
  RLA                     ; Shift left
  JP NC,BNORM_0
  INC B
  RRA
  LD C,A
  JP BNORM_2

BNORM_1:
  DEC B                   ; Count bits
  ADD HL,HL               ; Shift HL left
  LD A,D                  ; Get NMSB
  RLA                     ; Shift left with last bit
  LD D,A                  ; Save NMSB
  LD A,C                  ; Get MSB
  ADC A,A                 ; Shift left with last bit
  LD C,A                  ; Save MSB
PNORM:
  JP P,NORMAL             ; Not done - Keep going
BNORM_2:
  LD A,B                  ; Number of bits shifted
  LD E,H                  ; Save HL in EB
  LD B,L
  OR A                    ; Any shifting done?
  JP Z,RONDUP             ; No - Round it up
  LD HL,FPEXP             ; Point to exponent
  ADD A,(HL)              ; Add shifted bits
  LD (HL),A               ; Re-save exponent
  JP NC,ZERO_EXPONENT     ; Underflow - Result is zero
  JP Z,ZERO_EXPONENT      ; Result is zero
; This entry point is used by the routines at FADD and __CSNG.
RONDUP:
  LD A,B                  ; Get VLSB of number
; This entry point is used by the routine at RESDIV.
RONDUP_0:
  LD HL,FPEXP             ; Point to exponent
  OR A                    ; Any rounding?
  CALL M,FPROND           ; Yes - Round number up
  LD B,(HL)               ; B = Exponent
  INC HL
  LD A,(HL)               ; Get sign of result
  AND $80                 ; Only bit 7 needed
  XOR C                   ; Set correct sign
  LD C,A                  ; Save correct sign in number
  JP FPBCDE               ; Move BCDE to FP accumulator

; This entry point is used by the routine at FPINT.
FPROND:
  INC E                   ; Round LSB
  RET NZ                  ; Return if ok
  INC D                   ; Round NMSB
  RET NZ                  ; Return if ok
  INC C                   ; Round MSB
  RET NZ                  ; Return if ok
  LD C,$80                ; Set normal value
  INC (HL)                ; Increment exponent
  RET NZ                  ; Return if ok
  JP OVERR_0              ; Overflow error

; Add number pointed by HL to CDE
;
; Used by the routines at FADD and RNGTST.
PLUCDE:
  LD A,(HL)               ; Get LSB of FPREG
  ADD A,E                 ; Add LSB of BCDE
  LD E,A                  ; Save LSB of BCDE
  INC HL
  LD A,(HL)               ; Get NMSB of FPREG
  ADC A,D                 ; Add NMSB of BCDE
  LD D,A                  ; Save NMSB of BCDE
  INC HL
  LD A,(HL)               ; Get MSB of FPREG
  ADC A,C                 ; Add MSB of BCDE
  LD C,A                  ; Save MSB of BCDE
  RET


; Convert a negative number to positive
;
; Used by the routines at FADD and FPINT.
COMPL:
  LD HL,SGNRES            ; Sign of result
  LD A,(HL)               ; Get sign of result
  CPL                     ; Negate it
  LD (HL),A               ; Put it back
  XOR A
  LD L,A                  ; Set L to zero
  SUB B                   ; Negate exponent,set carry
  LD B,A                  ; Re-save exponent
  LD A,L                  ; Load zero
  SBC A,E                 ; Negate LSB
  LD E,A                  ; Re-save LSB
  LD A,L                  ; Load zero
  SBC A,D                 ; Negate NMSB
  LD D,A                  ; Re-save NMSB
  LD A,L                  ; Load zero
  SBC A,C                 ; Negate MSB
  LD C,A                  ; Re-save MSB
  RET


; This entry point is used by the routines at FADD and FPINT.
SCALE:
  LD B,$00                ; Clear underflow
SCALLP:
  SUB $08                 ; 8 bits (a whole byte)?
  JP C,SHRITE             ; No - Shift right A bits
  LD B,E                  ; <- Shift
  LD E,D                  ; <- right
  LD D,C                  ; <- eight
  LD C,$00                ; <- bits
  JP SCALLP               ; More bits to shift

; Shift right number in BCDE
;
; Used by the routine at COMPL.
SHRITE:
  ADD A,8+1               ; Adjust count
  LD L,A                  ; Save bits to shift
  LD A,D
  OR E
  OR B
  JP NZ,SHRLP
  LD A,C                 ; Get MSB
SHRITE_0:
  DEC L
  RET Z
  RRA                    ; Shift it right
  LD C,A                 ; Re-save
  JP NC,SHRITE_0
  JP SHRITE_2

SHRLP:
  XOR A                   ; Flag for all done
  DEC L                   ; All shifting done?
  RET Z                   ; Yes - Return
  LD A,C                  ; Get MSB
; This entry point is used by the routine at FADD.
SHRITE_1:
  RRA                     ; Shift it right
  LD C,A                  ; Re-save

SHRITE_2:
  LD A,D                  ; Get NMSB
  RRA                     ; Shift right with last bit
  LD D,A                  ; Re-save it
  LD A,E                  ; Get LSB
  RRA                     ; Shift right with last bit
  LD E,A                  ; Re-save it
  LD A,B                  ; Get underflow
  RRA                     ; Shift right with last bit
  LD B,A                  ; Re-save underflow
  JP SHRLP                ; More bits to do


FP_UNITY:
  DEFB $00,$00,$00,$81

FP_LOGTAB:
  DEFB $04
  DEFB $9A,$F7,$19,$83
  DEFB $24,$63,$43,$83
  DEFB $75,$CD,$8D,$84
  DEFB $A9,$7F,$83,$82

FP_LOGTAB2:
  DEFB $04
  DEFB $00,$00,$00,$81
  DEFB $E2,$B0,$4D,$83
  DEFB $0A,$72,$11,$83
  DEFB $F4,$04,$35,$7F


; 'LOG' BASIC function
;
; Used by the routine at __SQR.
__LOG:
  CALL SIGN               ; Test sign of value
  OR A
  JP PE,FC_ERR            ; ?FC Error if <= zero
  CALL __LOG_0
  LD BC,$8031             ; BCDE = Ln(2)
  LD DE,$7218
  JP FMULT

__LOG_0:
  CALL BCDEFP
  LD A,$80
  LD (FPEXP),A
  XOR B
  PUSH AF
  CALL STAKFP
  LD HL,FP_LOGTAB         ; Coefficient table
  CALL SMSER1             ; Evaluate sum of series
  POP BC
  POP HL
  CALL STAKFP
  EX DE,HL
  CALL FPBCDE
  LD HL,FP_LOGTAB2        ; Coefficient table
  CALL SMSER1             ; Evaluate sum of series
  POP BC
  POP DE
  CALL FDIV
  POP AF
  CALL STAKFP
  CALL FLGREL
  POP BC
  POP DE
  JP FADD

; aka FPMULT, Multiply BCDE to FP reg
;
; Used by the routines at __LOG, L2BA0, EXP, __EXP, SUMSER, SMSER1, __RND and
; __SIN.
FMULT:
  CALL SIGN               ; Test sign of FPREG
  RET Z                   ; Return zero if zero
  LD L,$00                ; Flag add exponents
  CALL ADDEXP             ; Add exponents
  LD A,C                  ; Get MSB of multiplier
  LD (MULVAL),A           ; Save MSB of multiplier
  EX DE,HL
  LD (MULVAL2),HL         ; Save rest of multiplier
  LD BC,$0000             ; Partial product (BCDE) = zero
  LD D,B
  LD E,B
  LD HL,BNORM             ; Address of normalise
  PUSH HL                 ; Save for return
  LD HL,MULT8             ; Address of 8 bit multiply
  PUSH HL                 ; Save for NMSB,MSB
  PUSH HL
  LD HL,FACCU             ; Point to number

; 8 bit multiply
MULT8:
  LD A,(HL)               ; Get LSB of number
  INC HL                  ; Point to NMSB
  OR A                    ; Test LSB
  JP Z,BYTSFT             ; Zero - shift to next byte
  PUSH HL                 ; Save address of number
  EX DE,HL
  LD E,$08                ; 8 bits to multiply by
; This entry point is used by the routine at NOMADD.
MUL8LP:
  RRA                     ; Shift LSB right
  LD D,A                  ; Save LSB
  LD A,C                  ; Get MSB
  JP NC,NOMADD            ; Bit was zero - Don't add
  PUSH DE
  DEFB $11                ; SMC trick: "LD DE,nn"

; Data block at 10062
MULVAL2:
  DEFW $0000

; Routine at 10064
L2750:
  ADD HL,DE               ; Add NMSB and LSB
  POP DE
  DEFB $CE                ; SMC trick: ADC A,n -> Add MSB
MULVAL:
  DEFB $00

; Routine at 10068
;
; Used by the routine at MULT8.
NOMADD:
  RRA                     ; Shift MSB right
  LD C,A                  ; Re-save MSB
  LD A,H                  ; Get NMSB
  RRA                     ; Shift NMSB right
  LD H,A                  ; Re-save NMSB
  LD A,L                  ; Get LSB
  RRA                     ; Shift LSB right
  LD L,A                  ; Re-save LSB
  LD A,B                  ; Get VLSB
  RRA                     ; Shift VLSB right
  LD B,A                  ; Re-save VLSB
  AND $10
  JP Z,NOMADD_0
  LD A,B
  OR $20
  LD B,A
NOMADD_0:
  DEC E
  LD A,D
  JP NZ,MUL8LP
  EX DE,HL

; (POP HL / RET)
;
; Used by the routines at ADDEXP, NXTARY and NOTDGI.
POPHLRT:
  POP HL
  RET

; Shift partial product left
;
; Used by the routine at MULT8.
BYTSFT:
  LD B,E
  LD E,D
  LD D,C
  LD C,A
  RET

; Divide FP by 10
;
; Used by the routine at MULTEN.
DIV10:
  CALL STAKFP             ; Save FPREG on stack
  LD HL,FP_TEN
  CALL PHLTFP

; Divide FP by number on stack
;
; Used by the routines at IDIV and __TAN.
DIV:
  POP BC
  POP DE

; divide BCDE by FP reg
;
; Used by the routines at __LOG and __ATN.
FDIV:
  CALL SIGN               ; Test sign of FPREG
  JP Z,DIV_DZERR          ; Error if division by zero
  LD L,$FF                ; (-1) Flag subtract exponents
  CALL ADDEXP             ; Subtract exponents
  INC (HL)                ; Add 2 to exponent to adjust..
  JP Z,DIV_OVERR
  INC (HL)
  JP Z,DIV_OVERR          ; .. (jp on errors)
  DEC HL                  ; Point to MSB
  LD A,(HL)               ; Get MSB of dividend
  LD (DIV3),A             ; Save for subtraction
  DEC HL
  LD A,(HL)               ; Get NMSB of dividend
  LD (DIV2),A             ; Save for subtraction
  DEC HL
  LD A,(HL)               ; Get MSB of dividend
  LD (DIV1),A             ; Save for subtraction
  LD B,C                  ; Get MSB
  EX DE,HL                ; NMSB,LSB to HL
  XOR A
  LD C,A                  ; Clear MSB of quotient
  LD D,A                  ; Clear NMSB of quotient
  LD E,A                  ; Clear LSB of quotient
  LD (DIV4),A             ; Clear overflow count
; This entry point is used by the routine at RESDIV.
FDIV_0:
  PUSH HL
  PUSH BC
  LD A,L
  DEFB $D6                ; SUB n
DIV1:
  DEFB $00

; Routine at 10160
L27B0:
  LD L,A
  LD A,H
  DEFB $DE                ; SBC A,n
DIV2:
  DEFB $00

; Routine at 10164
L27B4:
  LD H,A
  LD A,B
  DEFB $DE                ; SBC A,n
DIV3:
  DEFB $00

; Routine at 10168
L27B8:
  LD B,A
  DEFB $3E                ; "LD A,n" to Mask the next byte
DIV4:
  DEFB $00

; Routine at 10171
L27BB:
  SBC A,$00               ; Count for overflows
  CCF
  JP NC,RESDIV            ; Restore divisor if borrow
  LD (DIV4),A             ; Re-save overflow count
  POP AF                  ; Scrap divisor
  POP AF
  SCF                     ; Set carry to Skip "POP BC" and "POP HL"
  DEFB $D2                ; "JP NC,nn"

; Routine at 10184
;
; Used by the routine at L27BB.
RESDIV:
  POP BC                  ; Restore divisor
  POP HL
  LD A,C                  ; Get MSB of quotient
  INC A
  DEC A
  RRA                     ; Bit 0 to bit 7
  JP P,RESDIV_00
  RLA                     ; Restore carry
  LD A,(DIV4)
  RRA
  AND $C0
  PUSH AF
  LD A,B
  OR H
  OR L
  JP Z,RESDIV_0
  LD A,' '
RESDIV_0:
  POP HL
  OR H
  JP RONDUP_0

RESDIV_00:
  RLA                     ; Restore carry
  LD A,E                  ; Get LSB of quotient
  RLA                     ; Double it
  LD E,A                  ; Put it back
  LD A,D                  ; Get NMSB of quotient
  RLA                     ; Double it
  LD D,A                  ; Put it back
  LD A,C                  ; Get MSB of quotient
  RLA                     ; Double it
  LD C,A                  ; Put it back
  ADD HL,HL               ; Double NMSB,LSB of divisor
  LD A,B                  ; Get MSB of divisor
  RLA                     ; Double it
  LD B,A                  ; Put it back
  LD A,(DIV4)             ; Get VLSB of quotient
  RLA                     ; Double it
  LD (DIV4),A             ; Put it back
  LD A,C                  ; Get MSB of quotient
  OR D                    ; Merge NMSB
  OR E                    ; Merge LSB
  JP NZ,FDIV_0            ; Not done - Keep dividing
  PUSH HL                 ; Save divisor
  LD HL,FPEXP             ; Point to exponent
  DEC (HL)                ; Divide by 2
  POP HL                  ; Restore divisor
  JP NZ,FDIV_0            ; Ok - Keep going
  JP ZERO_EXPONENT        ; Overflow error

; This entry point is used by the routine at DECDIV.
RESDIV_1:
  LD A,$FF
  DEFB $2E                ; "LD L,n" to Mask 'XOR A'
; This entry point is used by the routine at DECMUL.
RESDIV_2:
  XOR A
  LD HL,DBL_LAST_FPREG
  LD C,(HL)
  INC HL
  XOR (HL)
  LD B,A
  LD L,$00

; Add (or subtract) exponent
;
; Used by the routines at FMULT and FDIV.
ADDEXP:
  LD A,B                  ; Get exponent of dividend
  OR A                    ; Test it
  JP Z,OVTST3             ; Zero - Result zero
  LD A,L                  ; Get add/subtract flag
  LD HL,FPEXP             ; Point to exponent
  XOR (HL)                ; Add or subtract it
  ADD A,B                 ; Add the other exponent
  LD B,A                  ; Save new exponent
  RRA                     ; Test exponent for overflow
  XOR B
  LD A,B                  ; Get exponent
  JP P,DIV_OVTST2         ; Positive - Test for overflow
  ADD A,$80               ; Add excess 128
  LD (HL),A               ; Save new exponent
  JP Z,POPHLRT            ; Zero - Result zero
  CALL SIGNS              ; Set MSBs and sign of result
  LD (HL),A               ; Save new exponent

; DCR_A ->  DEC A, RET
;
; Used by the routines at PUFOUT and L3356.
DCXH:
  DEC HL
  RET

; Test for OVERFLOW
DIV_OVTST1:
  CALL SIGN               ; Test sign of FPREG
  CPL                     ; Invert sign
  POP HL                  ; Clean up stack
; This entry point is used by the routine at ADDEXP.
DIV_OVTST2:
  OR A                    ; Test if new exponent zero
; This entry point is used by the routine at ADDEXP.
OVTST3:
  POP HL                  ; Clear off return address
  JP P,ZERO_EXPONENT      ; Result zero
  JP DIV_OVERR            ; Overflow error

; Multiply number in FPREG by 10
;
; Used by the routine at MULTEN.
MLSP10:
  CALL BCDEFP             ; Move FPREG to BCDE
  LD A,B                  ; Get exponent
  OR A                    ; Is it zero?
  RET Z                   ; Yes - Result is zero
  ADD A,$02               ; Multiply by 4
  JP C,OVERR              ; Overflow - ?OV Error
  LD B,A                  ; Re-save exponent
  CALL FADD               ; Add BCDE to FPREG (Times 5)
  LD HL,FPEXP             ; Point to exponent
  INC (HL)                ; Double number (Times 10)
  RET NZ                  ; Ok - Return
  JP OVERR                ; Overflow error

; Test sign of FPREG
;
; Used by the routines at FORFND, __POKE, __LOG, FMULT, FDIV, DIV_OVTST1,
; _TSTSGN, FCOMP, XDCOMP, __FIX, DECMUL, L3356, __SQR, __RND, __SIN and __ATN.
SIGN:
  LD A,(FPEXP)            ; Get sign of FPREG
  OR A
  RET Z                   ; RETurn if number is zero
  LD A,(FACCU+2)            ; Get MSB of FPREG
  DEFB $FE                ; CP 2Fh ..hides the "CPL" instruction

; SGN_RESULT_CPL
;
; Used by the routine at DECCOMP.
SGN_RESULT_CPL:
  CPL                     ; Invert sign

; SGN_RESULT
;
; Used by the routines at _TSTSGN and ICOMP.
SGN_RESULT:
  RLA                     ; Sign bit to carry

; EVAL_RESULT
;
; Used by the routines at ICOMP and EVAL_STR.
EVAL_RESULT:
  SBC A,A                 ; Carry to all bits of A
  RET NZ                  ; Return -1 if negative
  INC A                   ; Bump to +1
  RET                     ; Positive - Return +1

; CY and A to FP, & normalise
;
; Used by the routines at __LOG and MULTEN.
FLGREL:
  LD B,$88                ; 8 bit integer in exponent
  LD DE,$0000             ; Zero NMSB and LSB
; This entry point is used by the routines at HLPASS and DBL_ABS.
RETINT:
  LD HL,FPEXP             ; Point to exponent
  LD C,A                  ; CDE = MSB,NMSB and LSB
  LD (HL),B               ; Save exponent
  LD B,$00                ; CDE = integer to normalise
  INC HL                  ; Point to sign of result
  LD (HL),$80             ; Set sign of result
  RLA                     ; Carry = sign of integer
  JP CONPOS               ; Set sign of result

; 'ABS' BASIC function
__ABS:
  CALL _TSTSGN
  RET P

; Invert number sign
;
; Used by the routines at MINUS, __FIX, _ASCTFP and PUFOUT.
INVSGN:
  CALL GETYPR
  JP M,DBL_ABS
  JP Z,TM_ERR

; Invert number sign
;
; Used by the routines at FSUB, __FIX, L2BA0, __SQR, __SIN and __ATN.
NEG:
  LD HL,FACCU+2
  LD A,(HL)
  XOR $80
  LD (HL),A
  RET

; 'SGN' BASIC function
__SGN:
  CALL _TSTSGN            ; Test sign of FPREG

; Get back from function, result in A (signed)
;
; Used by the routines at L1D59 and __EOF.
INT_RESULT_A:
  LD L,A
  RLA                     ; Sign bit to carry
  SBC A,A                 ; Carry to all bits of A
  LD H,A
  JP INT_RESULT_HL

; Test sign in number
;
; Used by the routines at __IF, __ABS, __SGN, PUFOUT and __WEND.
_TSTSGN:
  CALL GETYPR
  JP Z,TM_ERR
  JP P,SIGN
  LD HL,(FACCU)
; This entry point is used by the routine at FORFND.
_TSTSGN_0:
  LD A,H
  OR L
  RET Z
  LD A,H
  JP SGN_RESULT

; Put FP value on stack
;
; Used by the routines at _EVAL, _EVAL_VALTYP, IDIV, FADD, __LOG, DIV10, IADD, L2BA0,
; MULTEN, PUFOUT, __SQR, __EXP, SUMSER, SMSER1, __SIN and __TAN.
STAKFP:
  EX DE,HL                ; Save code string address
  LD HL,(FACCU)           ; LSB,NLSB of FPREG
  EX (SP),HL              ; Stack them,get return
  PUSH HL                 ; Re-save return
  LD HL,(FACCU+2)           ; MSB and exponent of FPREG
  EX (SP),HL              ; Stack them,get return
  PUSH HL                 ; Re-save return
  EX DE,HL                ; Restore code string address
  RET

; Copy number pointed by HL to BCDE
;
; Used by the routines at DIV10, RNGTST, __SQR, SMSER1, SEED_SHUFFLE, __RND and
; __NEXT.
PHLTFP:
  CALL LOADFP             ; Number at HL to BCDE

; Move BCDE to FPREG
;
; Used by the routines at _EVAL_VALTYP, FADD, BNORM, __LOG, PUFOUT, RNGTST, GET_UNITY
; and __TAN.
FPBCDE:
  EX DE,HL                ; Save code string address
  LD (FACCU),HL           ; Save LSB,NLSB of number
  LD H,B                  ; Exponent of number
  LD L,C                  ; MSB of number
  LD (FACCU+2),HL           ; Save MSB and exponent
  EX DE,HL                ; Restore code string address
  RET

; Load FP reg to BCDE
;
; Used by the routines at FORFND, _EVAL_VALTYP, __LOG, MLSP10, __CSNG, FPINT, INT,
; RNGTST, __SQR, SUMSER and __RND.
BCDEFP:
  LD HL,FACCU             ; Point to FPREG

; Load FP value pointed by HL to BCDE
;
; Used by the routines at FADD_HLPTR, SUBPHL, PHLTFP, SMSER1, __RND and __NEXT.
LOADFP:
  LD E,(HL)               ; Get LSB of number
  INC HL
; This entry point is used by the routine at PRS1.
LOADFP_0:
  LD D,(HL)               ; Get NMSB of number
  INC HL
  LD C,(HL)               ; Get MSB of number
  INC HL
  LD B,(HL)               ; Get exponent of number
; This entry point is used by the routines at PROMPT, CONLIN, PUFOUT and L3356.
INCHL:
  INC HL                  ; Used for conditional "INC HL"
  RET

; This entry point is used by the routines at __FOR, __RND and __NEXT.
FPTHL:
  LD DE,FACCU             ; Point to FPREG
; This entry point is used by the routines at DECDIV_SUB and __NEW.
MOVE:
  LD B,$04                ; 4 bytes to move
  JP CPY2HL

VAL2DE:
  EX DE,HL
; This entry point is used by the routines at __LET, CMPPHL, L2DC9, L3356,
; __TROFF, TSTOPL_0 and FN_INSTR.
FP2HL:
  LD A,(VALTYP)
  LD B,A                  ; get number of bytes to move

; Routine at 10468
;
; Used by the routines at CHRGTB, LOADFP and L46AB.
CPY2HL:
  LD A,(DE)               ; Get source
  LD (HL),A               ; Save destination
  INC DE                  ; Next source
  INC HL                  ; Next destination
  DEC B                   ; Count bytes
  JP NZ,CPY2HL            ; Loop if more
  RET
; This entry point is used by the routines at FADD, ADDEXP, __CSNG, FPINT, INT
; and DECADD.
SIGNS:
  LD HL,FACCU+2           ; Point to MSB of FPREG
  LD A,(HL)               ; Get MSB
  RLCA                    ; Old sign to carry
  SCF                     ; Set MSBit
  RRA                     ; Set MSBit of MSB
  LD (HL),A               ; Save new MSB
  CCF                     ; Complement sign
  RRA                     ; Old sign to carry
  INC HL
  INC HL
  LD (HL),A               ; Set sign of result
  LD A,C                  ; Get MSB
  RLCA                    ; Old sign to carry
  SCF                     ; Set MSBit
  RRA                     ; Set MSBit of MSB
  LD C,A                  ; Save MSB
  RRA
  XOR (HL)                ; New sign of result
  RET

; This entry point is used by the routine at DECADD.
FP_ARG2DE:
  LD HL,FPARG
; This entry point is used by the routines at CHRGTB, EVAL_VARIABLE, DOFN,
; __CINT, RNGTST, __CVD and __CALL.
FP_HL2DE:
  LD DE,VAL2DE
  JP FP_DE2HL_0

; FP_ARG2HL
;
; Used by the routines at _EVAL_VALTYP, __CINT, DECDIV, MULTEN and RNGTST.
FP_ARG2HL:
  LD HL,FPARG

; FP_DE2HL
;
; Used by the routines at DOFN and __MKD_S.
FP_DE2HL:
  LD DE,FP2HL
; This entry point is used by the routine at CPY2HL.
FP_DE2HL_0:
  PUSH DE
  LD DE,FACCU
  CALL GETYPR
  RET C
  LD DE,FACLOW
  RET

; aka FCOMPor CMPNUM, Compare FP reg to BCDE
;
; Used by the routines at SETTYPE, MULTEN, L3356, RNGTST, __SQR, __SIN and
; __NEXT.
FCOMP:
  LD A,B                  ; Get exponent of number
  OR A
  JP Z,SIGN               ; Zero - Test sign of FPREG
  LD HL,SGN_RESULT_CPL    ; Return relation routine
  PUSH HL                 ; Save for return
  CALL SIGN               ; Test sign of FPREG
  LD A,C                  ; Get MSB of number
  RET Z                   ; FPREG zero - Number's MSB
  LD HL,FACCU+2             ; MSB of FPREG
  XOR (HL)                ; Combine signs
  LD A,C                  ; Get MSB of number
  RET M                   ; Exit if signs different
  CALL CMPFP              ; Compare FP numbers
; This entry point is used by the routine at XDCOMP.
FCOMP_0:
  RRA                     ; Get carry to sign
  XOR C                   ; Combine with MSB of number
  RET

; Compare FP numbers
;
; Used by the routine at FCOMP.
CMPFP:
  INC HL                  ; Point to exponent
  LD A,B                  ; Get exponent
  CP (HL)                 ; Compare exponents
  RET NZ                  ; Different
  DEC HL                  ; Point to MBS
  LD A,C                  ; Get MSB
  CP (HL)                 ; Compare MSBs
  RET NZ                  ; Different
  DEC HL                  ; Point to NMSB
  LD A,D                  ; Get NMSB
  CP (HL)                 ; Compare NMSBs
  RET NZ                  ; Different
  DEC HL                  ; Point to LSB
  LD A,E                  ; Get LSB
  SUB (HL)                ; Compare LSBs
  RET NZ                  ; Different
  POP HL                  ; Drop RETurn
  POP HL                  ; Drop another RETurn
  RET

; Integer COMPARE
;
; Used by the routine at __NEXT.
ICOMP:
  LD A,D
  XOR H
  LD A,H
  JP M,SGN_RESULT
  CP D
  JP NZ,ICOMP_0
  LD A,L
  SUB E
  RET Z
ICOMP_0:
  JP EVAL_RESULT

; Routine at 10586
;
; Used by the routines at L3356 and RNGTST.
CMPPHL:
  LD HL,FPARG
  CALL FP2HL

; FP COMPARE
;
; Used by the routine at DECCOMP.
XDCOMP:
  LD DE,ARG
  LD A,(DE)
  OR A
  JP Z,SIGN
  LD HL,SGN_RESULT_CPL
  PUSH HL
  CALL SIGN
  DEC DE
  LD A,(DE)
  LD C,A
  RET Z
  LD HL,FACCU+2
  XOR (HL)
  LD A,C
  RET M
  INC DE
  INC HL
  LD B,$08
XDCOMP_0:
  LD A,(DE)
  SUB (HL)
  JP NZ,FCOMP_0
  DEC DE
  DEC HL
  DEC B
  JP NZ,XDCOMP_0
  POP BC
  RET

; Double precision COMPARE
DECCOMP:
  CALL XDCOMP
  JP NZ,SGN_RESULT_CPL
  RET

; 'CINT' BASIC function
;
; Used by the routines at FORFND, _EVAL, NOT, EVAL_BOOL_END, DEPINT and
; __RANDOMIZE.
__CINT:
  CALL GETYPR
  LD HL,(FACCU)
  RET M
  JP Z,TM_ERR
  JP PO,__CINT_0
  CALL FP_ARG2HL
  LD HL,DBL_FP_ZERO
  CALL FP_HL2DE
  CALL DECADD
  CALL __CSNG_0
  JP __CINT_1

__CINT_0:
  CALL ROUND
__CINT_1:
  LD A,(FACCU+2)
  OR A
  PUSH AF
  AND $7F
  LD (FACCU+2),A
  LD A,(FPEXP)
  CP $90
  JP NC,OV_ERR
  CALL FPINT
  LD A,(FPEXP)
  OR A
  JP NZ,__CINT_2
  POP AF
  EX DE,HL
  JP __CINT_3

__CINT_2:
  POP AF
  EX DE,HL
  JP P,__CINT_4
__CINT_3:
  LD A,H
  CPL
  LD H,A
  LD A,L
  CPL
  LD L,A
__CINT_4:
  JP INT_RESULT_HL

  LD HL,OV_ERR
  PUSH HL
; This entry point is used by the routine at __INT.
__CINT_5:
  LD A,(FPEXP)
  CP $90
  JP NC,INT_RESULT_HL_2
  CALL FPINT
  EX DE,HL

; This entry point is used by the routines at SETTYPE and IADD.
INT_RESULT_HL_2_0:
  POP DE

; Get back from function, result in HL
;
; Used by the routines at __ERL, HEXTFP, PASSA, INT_RESULT_A, __CINT, INT,
; IMULT, L2BA0, L2BE1, DBL_ASCTFP_0 and LNUM_MSG.
INT_RESULT_HL:
  LD (FACCU),HL

; Set type to "integer"
;
; Used by the routine at DBL_ABS.
SETTYPE_INT:
  LD A,$02

; Set variable/value type
;
; Used by the routine at SETTYPE_SNG.
SETTYPE:
  LD (VALTYP),A
  RET

; This entry point is used by the routines at __CINT and _ASCTFP.
INT_RESULT_HL_2:
  LD BC,$9080             ; BCDE = -32768
  LD DE,$0000
  CALL FCOMP
  RET NZ
  LD H,C
  LD L,D
  JP INT_RESULT_HL_2_0

; 'CSNG' BASIC function
;
; Used by the routines at FORFND, _EVAL, _EVAL_VALTYP, OPRND_3, __POKE, _ASCTFP and
; __SQR.
__CSNG:
  CALL GETYPR
  RET PO
  JP M,INT_CSNG
  JP Z,TM_ERR
; This entry point is used by the routine at __CINT.
__CSNG_0:
  CALL BCDEFP
  CALL SETTYPE_SNG
  LD A,B
  OR A
  RET Z
  CALL SIGNS
  LD HL,FACLOW+3
  LD B,(HL)
  JP RONDUP

; This entry point is used by the routines at __CDBL, MULTEN and L3356.
INT_CSNG:
  LD HL,(FACCU)
; This entry point is used by the routines at _EVAL_VALTYP, IDIV, IADD and L2BA0.
HL_CSNG:
  CALL SETTYPE_SNG

; Get back from function passing an INT value HL
HLPASS:
  LD A,H
  LD D,L
  LD E,$00
  LD B,$90
  JP RETINT

; 'CDBL' BASIC function
;
; Used by the routines at _EVAL_VALTYP, INT and _ASCTFP.
__CDBL:
  CALL GETYPR
  RET NC
  JP Z,TM_ERR
  CALL M,INT_CSNG
; This entry point is used by the routine at MULTEN.
ZERO_FACCU:
  LD HL,$0000
  LD (FACLOW),HL
  LD (FACLOW+2),HL

; Set type to "double precision"
;
; Used by the routine at DBL_ASCTFP.
SETTYPE_DBL:
  LD A,$08
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; Set type to "single precision"
;
; Used by the routines at __CSNG, DBL_ABS and SEED_SHUFFLE.
SETTYPE_SNG:
  LD A,$04
  JP SETTYPE

; Test a string, 'Type Error' if it is not
;
; Used by the routines at __LINE, OPRND_3, LINE_INPUT, __FIELD, __LSET,
; __USING, L52F3, CONCAT, GETSTR and FN_INSTR.
TSTSTR:
  CALL GETYPR
  RET Z
  JP TM_ERR

; Floating Point to Integer
;
; Used by the routines at __CINT, INT and RNGTST.
FPINT:
  LD B,A
  LD C,A
  LD D,A
  LD E,A
  OR A
  RET Z
  PUSH HL
  CALL BCDEFP
  CALL SIGNS
  XOR (HL)
  LD H,A
  CALL M,DCBCDE
  LD A,$98
  SUB B
  CALL SCALE
  LD A,H
  RLA
  CALL C,FPROND
  LD B,$00
  CALL C,COMPL
  POP HL
  RET

; Decrement FP value in BCDE
;
; Used by the routine at FPINT.
DCBCDE:
  DEC DE
  LD A,D
  AND E
  INC A
  RET NZ
; This entry point is used by the routine at LISPRT.
DCXBRT:
  DEC BC
  RET

; 'FIX' BASIC function
__FIX:
  CALL GETYPR
  RET M
  CALL SIGN
  JP P,__INT
  CALL NEG
  CALL __INT
  JP INVSGN

; 'INT' BASIC function
;
; Used by the routine at __FIX.
__INT:
  CALL GETYPR
  RET M
  JP NC,INT_0
  JP Z,TM_ERR
  CALL __CINT_5

; INT
;
; Used by the routines at __SQR, __EXP and __SIN.
INT:
  LD HL,FPEXP
  LD A,(HL)
  CP TK_DEF
  LD A,(FACCU)
  RET NC
  LD A,(HL)
  CALL FPINT
  LD (HL),TK_DEF
  LD A,E
  PUSH AF
  LD A,C
  RLA
  CALL CONPOS
  POP AF
  RET

; This entry point is used by the routine at __INT.
INT_0:
  LD HL,FPEXP
  LD A,(HL)
  CP $90
  JP NZ,INT_3
  LD C,A
  DEC HL
  LD A,(HL)
  XOR $80
  LD B,$06
INT_1:
  DEC HL
  OR (HL)
  DEC B
  JP NZ,INT_1
  OR A
  LD HL,$8000			; 32768
  JP NZ,INT_2
  CALL INT_RESULT_HL
  JP __CDBL

INT_2:
  LD A,C
INT_3:
  OR A
  RET Z
  CP $B8
  RET NC
; This entry point is used by the routine at RNGTST.
INT_4:
  PUSH AF
  CALL BCDEFP
  CALL SIGNS
  XOR (HL)
  DEC HL
  LD (HL),$B8
  PUSH AF
  DEC HL
  LD (HL),C
  CALL M,INT_5
  LD A,(FACCU+2)
  LD C,A
  LD HL,FACCU+2
  LD A,$B8
  SUB B
  CALL SCALE_DEC
  POP AF
  CALL M,DECADD_10
  XOR A
  LD (FACLOW-1),A
  POP AF
  RET NC
  JP DECADD_3

INT_5:
  LD HL,FACLOW
INT_6:
  LD A,(HL)
  DEC (HL)
  OR A
  INC HL
  JP Z,INT_6
  RET

; Multiply DE by BC
;
; Used by the routines at BSOPRND_0 and ZERARY.
MLDEBC:
  PUSH HL
  LD HL,$0000
  LD A,B
  OR C
  JP Z,MLDEBC_2
  LD A,$10
MLDEBC_0:
  ADD HL,HL
  JP C,BS_ERR
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,MLDEBC_1
  ADD HL,BC
  JP C,BS_ERR
MLDEBC_1:
  DEC A
  JP NZ,MLDEBC_0
MLDEBC_2:
  EX DE,HL
  POP HL
  RET

; Integer SUB
ISUB:
  LD A,H
  RLA                     ; Sign bit to carry
  SBC A,A                 ; Carry to all bits of A
  LD B,A
  CALL L2BE1_4
  LD A,C
  SBC A,B
  JP IADD_0

; Integer ADD
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
  CALL STAKFP
  EX DE,HL
  CALL DBL_ABS_1
  JP MULTEN_8

; Integer MULTIPLY
IMULT:
  LD A,H
  OR L
  JP Z,INT_RESULT_HL
  PUSH HL
  PUSH DE
  CALL L2BE1_1
  PUSH BC
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$10
IMULT_0:
  ADD HL,HL
  JP C,L2BA0
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,IMULT_1
  ADD HL,BC
  JP C,L2BA0
IMULT_1:
  DEC A
  JP NZ,IMULT_0
  POP BC
  POP DE
; This entry point is used by the routine at L2BE1.
IMULT_2:
  LD A,H
  OR A
  JP M,IMULT_3
  POP DE
  LD A,B
  JP L2BE1_3
IMULT_3:
  XOR $80
  OR L
  JP Z,L2BA0_0
  EX DE,HL
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; Routine at 11168
;
; Used by the routine at IMULT.
L2BA0:
  POP BC
  POP HL
  CALL HL_CSNG
  POP HL
  CALL STAKFP
  CALL HL_CSNG
POP_FMULT:
  POP BC                  ; Pointed by SUMSER
  POP DE
  JP FMULT

; This entry point is used by the routine at IMULT.
L2BA0_0:
  LD A,B
  OR A
  POP BC
  JP M,INT_RESULT_HL
  PUSH DE
  CALL HL_CSNG
  POP DE
  JP NEG

; This entry point is used by the routines at EVAL_BOOL_END and DBL_ABS.
INT_DIV:
  LD A,H
  OR L
  JP Z,O_ERR
  CALL L2BE1_1
  PUSH BC
  EX DE,HL
  CALL L2BE1_4
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$11
  PUSH AF
  OR A
  JP L2BE1_0

; This entry point is used by the routine at L2BE1.
L2BA0_1:
  PUSH AF
  PUSH HL
  ADD HL,BC
  JP NC,L2BE1
  POP AF
  SCF
  DEFB $3E                ; "LD A,n" to Mask the next byte

; Routine at 11233
;
; Used by the routine at L2BA0.
L2BE1:
  POP HL
; This entry point is used by the routine at L2BA0.
L2BE1_0:
  LD A,E
  RLA
  LD E,A
  LD A,D
  RLA
  LD D,A
  LD A,L
  RLA
  LD L,A
  LD A,H
  RLA
  LD H,A
  POP AF
  DEC A
  JP NZ,L2BA0_1
  EX DE,HL
  POP BC
  PUSH DE
  JP IMULT_2

; This entry point is used by the routines at IMULT and L2BA0.
L2BE1_1:
  LD A,H
  XOR D
  LD B,A
  CALL L2BE1_2
  EX DE,HL
L2BE1_2:
  LD A,H
; This entry point is used by the routines at IMULT and DBL_ABS.
L2BE1_3:
  OR A
  JP P,INT_RESULT_HL
; This entry point is used by the routines at ISUB, L2BA0 and DBL_ABS.
L2BE1_4:
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
  JP INT_RESULT_HL

; ABS (double precision BASIC variant)
;
; Used by the routine at INVSGN.
DBL_ABS:
  LD HL,(FACCU)
  CALL L2BE1_4
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at CHRGTB, __ERL and IMP.
DBL_ABS_0:
  EX DE,HL
  CALL SETTYPE_SNG
  XOR A
; This entry point is used by the routine at IADD.
DBL_ABS_1:
  LD B,$98
  JP RETINT

; This entry point is used by the routines at __TAB and EVAL_BOOL_END.
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
  JP L2BE1_3


; aka DBL_SUB, Double precision SUB (formerly SUBCDE)
DECSUB:
  LD HL,DBL_LAST_FPREG
  LD A,(HL)
  XOR $80
  LD (HL),A

; aka DBL_ADD, Double precision ADD (formerly FPADD)
;
; Used by the routines at __CINT, L2DC9, DECDIV, MULTEN and RNGTST.
DECADD:
  LD HL,ARG
  LD A,(HL)                  ; Get FP exponent
  OR A                       ; Is number zero?
  RET Z                      ; Yes - Nothing to add
  LD B,A
  DEC HL
  LD C,(HL)
  LD DE,FPEXP
  LD A,(DE)                  ; Get FPREG exponent
  OR A                       ; Is this number zero?
  JP Z,FP_ARG2DE             ; Yes - Move FP to FPREG
  SUB B                      ; FP number larger?
  JP NC,NOSWAP_DEC           ; No - Don't swap them
  CPL                        ; Two's complement
  INC A                      ;  FP exponent
  PUSH AF
  LD C,$08
  INC HL
  PUSH HL
DECADD_SWAP:                 ; Put FP on stack
  LD A,(DE)
  LD B,(HL)
  LD (HL),A
  LD A,B
  LD (DE),A
  DEC DE
  DEC HL
  DEC C
  JP NZ,DECADD_SWAP
  POP HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  POP AF
NOSWAP_DEC:
  CP $39                    ; Second number insignificant?
  RET NC                    ; Yes - First number is result
  PUSH AF                   ; Save number of bits to scale
  CALL SIGNS                ; Set MSBs & sign of result
  LD HL,FPARG-1
  LD B,A                    ; Save sign of result
  LD A,$00
  LD (HL),A
  LD (FACLOW-1),A
  POP AF                    ; Restore scaling factor
  LD HL,DBL_LAST_FPREG      ; Point to FPREG
  CALL SCALE_DEC            ; Scale to same exponent
  LD A,B                    ; Restore sign of result
  OR A                      ; Result to be positive?
  JP P,MINCDE_DEC           ; No - Subtract FPREG from CDE
  LD A,(FPARG-1)
  LD (FACLOW-1),A
  CALL PLUCDE_DEC           ; Add FPREG to CDE
  JP NC,DECROU              ; No overflow - Round it up
  EX DE,HL                  ; Point to exponent
  INC (HL)                  ; Increment it
  JP Z,OVERR_1              ; Number overflowed - Error
  CALL SHRT1_DEC            ; Shift result right
  JP DECROU                 ; Round it up

MINCDE_DEC:
  LD A,$9E				; SBC A,(HL)
  CALL DECSUB_SMC_0
  LD HL,SGNRES          ; Sign of result
  CALL C,COMPL_DEC
; This entry point is used by the routines at INT and DECMUL.
DECADD_3:
  XOR A
DECADD_4:
  LD B,A
  LD A,(FACCU+2)
  OR A
  JP NZ,DECADD_7
  LD HL,FACLOW-1
  LD C,$08
DECADD_5:
  LD D,(HL)
  LD (HL),A
  LD A,D
  INC HL
  DEC C
  JP NZ,DECADD_5
  LD A,B
  SUB $08
  CP $C0
  JP NZ,DECADD_4
  JP ZERO_EXPONENT

DECADD_6:
  DEC B
  LD HL,FACLOW-1
  CALL DECADD_29
  OR A
DECADD_7:
  JP P,DECADD_6
  LD A,B
  OR A
  JP Z,DECROU
  LD HL,FPEXP
  ADD A,(HL)
  LD (HL),A
  JP NC,ZERO_EXPONENT
  RET Z
DECROU:
  LD A,(FACLOW-1)
; This entry point is used by the routine at DECDIV.
DECADD_9:
  OR A
  CALL M,DECADD_10
  LD HL,SGNRES
  LD A,(HL)
  AND $80
  DEC HL
  DEC HL
  XOR (HL)
  LD (HL),A
  RET

  
; This entry point is used by the routine at INT.
DECADD_10:
  LD HL,FACLOW
  LD B,$07
DECADD_11:
  INC (HL)
  RET NZ
  INC HL
  DEC B
  JP NZ,DECADD_11
  INC (HL)
  JP Z,OVERR_1
  DEC HL
  LD (HL),$80
  RET



; This entry point is used by the routine at DECDIV.
DEC_SMC:
  LD DE,FBUFFR+27
  LD HL,FPARG
  JP DEC_SMC_1

; This entry point is used by the routine at DECMUL.
PLUCDE_DEC:
  LD A,$8E			; ADC A,(HL)
DECSUB_SMC_0:
  LD HL,FPARG

; This entry point is used by the routine at RNGTST.
DEC_SMC_0:
  LD DE,FACLOW
DEC_SMC_1:
  LD C,$07
  LD (DEC_SMC_BYTE),A
  XOR A
DEC_SMC_2:
  LD A,(DE)
DEC_SMC_BYTE:
  ADC A,(HL)		; <-- SMC instruction
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,DEC_SMC_2
  RET
  

; Complement sign
COMPL_DEC:
  LD A,(HL)
  CPL
  LD (HL),A
  LD HL,FACLOW-1
  LD B,$08
  XOR A
  LD C,A
COMPL_DEC_0:
  LD A,C
  SBC A,(HL)
  LD (HL),A
  INC HL
  DEC B
  JP NZ,COMPL_DEC_0
  RET


; This entry point is used by the routine at INT.
SCALE_DEC:
  LD (HL),C
  PUSH HL
SCALLP_DEC:
  SUB $08                ; 8 bits (a whole byte)?
  JP C,SHRITE_DEC        ; No - Shift right A bits
  POP HL
; This entry point is used by the routine at DECMUL.
SCALE_DEC_1:
  PUSH HL
  LD DE,$0800            ; D=8 bits to shift
SCALE_DEC_2:
  LD C,(HL)
  LD (HL),E
  LD E,C
  DEC HL
  DEC D
  JP NZ,SCALE_DEC_2
  JP SCALLP_DEC

SHRITE_DEC:
  ADD A,8+1              ; Adjust count
  LD D,A
SHRITE_DEC_LP:
  XOR A                  ; Flag for all done
  POP HL
  DEC D                  ; All shifting done?
  RET Z                  ; Yes - Return
SHRITE_DEC_LP2:
  PUSH HL
  LD E,$08               ; Count 8 bits
SHRITE_DEC_LP3:
  LD A,(HL)
  RRA
  LD (HL),A
  DEC HL
  DEC E
  JP NZ,SHRITE_DEC_LP3
  JP SHRITE_DEC_LP


; This entry point is used by the routine at DECMUL.
SHRT1_DEC:
  LD HL,FACCU+2
  LD D,$01
  JP SHRITE_DEC_LP2


; This entry point is used by the routine at DECDIV.
DECADD_29:
  LD C,$08
; This entry point is used by the routine at DECDIV.
DECADD_30:
  LD A,(HL)
  RLA
  LD (HL),A
  INC HL
  DEC C
  JP NZ,DECADD_30
  RET

; Double precision MUL
;
; Used by the routines at L2DC9 and L3356.
DECMUL:
  CALL SIGN
  RET Z
  LD A,(ARG)
  OR A
  JP Z,ZERO_EXPONENT
  CALL RESDIV_2
  CALL DECDIV_2
  LD (HL),C
  INC DE
  LD B,$07
DECMUL_0:
  LD A,(DE)
  INC DE
  OR A
  PUSH DE
  JP Z,DECMUL_3
  LD C,$08
DECMUL_1:
  PUSH BC
  RRA
  LD B,A
  CALL C,PLUCDE_DEC
  CALL SHRT1_DEC
  LD A,B
  POP BC
  DEC C
  JP NZ,DECMUL_1
DECMUL_2:
  POP DE
  DEC B
  JP NZ,DECMUL_0
  JP DECADD_3

DECMUL_3:
  LD HL,FACCU+2
  CALL SCALE_DEC_1
  JP DECMUL_2
  
DECMUL_CONST:
  DEFB $CD,$CC,$CC,$CC
DECMUL_CONST2:
  DEFB $CC,$CC,$4C,$7D
FP_ZERO:
  DEFB $00,$00,$00,$00
FP_TEN:
  DEFB $00,$00,$20,$84    ; Float const: 10

; Routine at 11721
;
; Used by the routine at MULTEN.
L2DC9:
  LD A,(FPEXP)
  CP $41		; 'A'
  JP NC,L2DC9_0
  LD DE,DECMUL_CONST
  LD HL,FPARG
  CALL FP2HL
  JP DECMUL

L2DC9_0:
  LD A,(FACCU+2)
  OR A
  JP P,L2DC9_1
  AND $7F
  LD (FACCU+2),A
  LD HL,NEG
  PUSH HL
L2DC9_1:
  CALL L2DC9_3
  LD DE,FACLOW
  LD HL,FPARG
  CALL FP2HL
  CALL L2DC9_3
  CALL DECADD
  LD DE,FACLOW
  LD HL,FPARG
  CALL FP2HL
  LD A,$0F
L2DC9_2:
  PUSH AF
  CALL L2DC9_4
  CALL L2DC9_6
  CALL DECADD
  LD HL,DBL_LAST_FPREG
  CALL L2DC9_8
  POP AF
  DEC A
  JP NZ,L2DC9_2
  CALL L2DC9_3
  CALL L2DC9_3
L2DC9_3:
  LD HL,FPEXP
  DEC (HL)
  RET NZ
  JP ZERO_EXPONENT

L2DC9_4:
  LD HL,ARG
  LD A,$04
L2DC9_5:
  DEC (HL)
  RET Z
  DEC A
  JP NZ,L2DC9_5
  RET

L2DC9_6:
  POP DE
  LD A,$04
  LD HL,FPARG
L2DC9_7:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  DEC A
  JP NZ,L2DC9_7
  PUSH DE
  RET

L2DC9_8:
  POP DE
  LD A,$04
  LD HL,ARG
L2DC9_9:
  POP BC
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC HL
  DEC A
  JP NZ,L2DC9_9
  PUSH DE
  RET

; Double precision DIV
DECDIV:
  LD A,(ARG)
  OR A
  JP Z,DECDIV_SUB
  LD A,(FPEXP)
  OR A
  JP Z,ZERO_EXPONENT
  CALL RESDIV_1
  INC (HL)
  INC (HL)
  JP Z,OVERR_1
  CALL DECDIV_2
  LD HL,FBUFFR+34		; last byte in FBUFFR
  LD (HL),C
  LD B,C
DECDIV_0:
  LD A,$9E				; SBC A,(HL)
  CALL DEC_SMC
  LD A,(DE)
  SBC A,C
  CCF
  JP C,DECDIV_1
  LD A,$8E				; ADC A,(HL)
  CALL DEC_SMC
  XOR A
  DEFB $DA                ; "JP C,n" to mask the next 2 bytes
DECDIV_1:
  LD (DE),A
  INC B
  LD A,(FACCU+2)
  INC A
  DEC A
  RRA
  JP M,DECADD_9
  RLA
  LD HL,FACLOW
  LD C,$07
  CALL DECADD_30
  LD HL,FBUFFR+27
  CALL DECADD_29
  LD A,B
  OR A
  JP NZ,DECDIV_0
  LD HL,FPEXP
  DEC (HL)
  JP NZ,DECDIV_0
  JP ZERO_EXPONENT
  
; This entry point is used by the routine at DECMUL.
DECDIV_2:
  LD A,C
  LD (DBL_LAST_FPREG),A
  DEC HL
  LD DE,FBUFFR+33
  LD BC,$0700		; B=7,  C=0
DECDIV_3:
  LD A,(HL)
  LD (DE),A
  LD (HL),C
  DEC DE
  DEC HL
  DEC B
  JP NZ,DECDIV_3
  RET

; This entry point is used by the routine at MULTEN.
DECDIV_4:
  CALL FP_ARG2HL
  EX DE,HL
  DEC HL
  LD A,(HL)
  OR A
  RET Z
  ADD A,$02
  JP C,OVERR_1
  LD (HL),A
  PUSH HL
  CALL DECADD
  POP HL
  INC (HL)
  RET NZ
  JP OVERR_1

; Also known as "FIN", convert text to number
;
; Used by the routines at __READ_DONE, LINE_INPUT and __VAL.
DBL_ASCTFP:
  CALL ZERO_EXPONENT
  CALL SETTYPE_DBL
  DEFB $F6                ; "OR n" to Mask 'XOR A'

; Also known as "FIN", convert text to number
;
; Used by the routines at DETOKEN_MORE, __READ_DONE, OPRND, __RANDOMIZE and
; LINE_INPUT.
DBL_ASCTFP_0:
  XOR A
  LD BC,DBL_ASCTFP_END
  PUSH BC
  PUSH AF
  LD A,$01
  LD (RESFLG),A
  POP AF
  EX DE,HL
  LD BC,$00FF
  LD H,B
  LD L,B
  CALL Z,INT_RESULT_HL
  EX DE,HL
  LD A,(HL)

; ASCII to FP number (also '&' prefixes)
H_ASCTFP:
  CP '&'
  JP Z,HEXTFP

; ASCII to FP number
_ASCTFP:
  CP '-'                  ; '-': Negative?
  PUSH AF                 ; Save it and flags
  JP Z,_ASCTFP_0          ; Yes - Convert number
  CP '+'                  ; Positive?
  JP Z,_ASCTFP_0          ; Yes - Convert number
  DEC HL                  ; DEC 'cos GETCHR INCs
; This entry point is used by the routine at MULTEN.
_ASCTFP_0:
  CALL CHRGTB             ; Set result to zero
  JP C,ADDIG              ; Digit - Add to number
  CP '.'
  JP Z,DPOINT             ; "." - Flag point
  CP 'e'
  JP Z,EXPONENTIAL
  CP 'E'
EXPONENTIAL:
  JP NZ,_ASCTFP_3         ; Get number in exponential format

  PUSH HL
  CALL CHRGTB
  CP 'l'
  JP Z,_ASCTFP_1
  CP 'L'
  JP Z,_ASCTFP_1
  CP 'q'
  JP Z,_ASCTFP_1
  CP 'Q'
_ASCTFP_1:
  POP HL
  JP Z,_ASCTFP_2
  LD A,(VALTYP)
  CP $08
  JP Z,DBL_EXPONENTIAL
  LD A,$00
  JP DBL_EXPONENTIAL

_ASCTFP_2:
  LD A,(HL)
_ASCTFP_3:
  CP '%'				; Integer variable ?
  JP Z,INT_PREC
  CP '#'				; Double precision variable ?
  JP Z,_ASCTFP_9
  CP '!'				; Single precision variable ?
  JP Z,SNG_PREC
  CP 'd'
  JP Z,DBL_EXPONENTIAL
  CP 'D'
  JP NZ,DFLT_PREC

DBL_EXPONENTIAL:
  OR A
  CALL TO_DOUBLE
  CALL CHRGTB
  CALL SGNEXP

; This entry point is used by the routine at MULTEN.
DBL_EXPONENTIAL_0:
  CALL CHRGTB
  JP C,DBL_EXPONENTIAL_EXPONENT
  INC D
  JP NZ,DFLT_PREC
  XOR A
  SUB E
  LD E,A
  
DFLT_PREC:
  PUSH HL
  LD A,E
  SUB B
  LD E,A
DFLT_PREC_0:
  CALL P,_ASCTFP_11
  CALL M,MULTEN_0
  JP NZ,DFLT_PREC_0
  POP HL
  POP AF
  PUSH HL
  CALL Z,INVSGN
  POP HL
  CALL GETYPR
  RET PE
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  CALL INT_RESULT_HL_2
  RET

DPOINT:
  CALL GETYPR             ; Get number in decimal format
  INC C
  JP NZ,DFLT_PREC
  CALL C,TO_DOUBLE
  JP _ASCTFP_0

INT_PREC:
  CALL CHRGTB
  POP AF
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  PUSH AF
  JP DFLT_PREC

_ASCTFP_9:
  OR A

SNG_PREC:
  CALL TO_DOUBLE
  CALL CHRGTB
  JP DFLT_PREC

TO_DOUBLE:
  PUSH HL                 ; Convert number precision
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

_ASCTFP_11:
  RET Z

; Multiply FP value by ten
;
; Used by the routine at L3356.
MULTEN:
  PUSH AF
  CALL GETYPR
  PUSH AF
  CALL PO,MLSP10
  POP AF
  CALL PE,DECDIV_4
  POP AF
; This entry point is used by the routine at L3356.
DCR_A:
  DEC A
  RET

; This entry point is used by the routines at _ASCTFP and L3356.
MULTEN_0:
  PUSH DE
  PUSH HL
  PUSH AF
  CALL GETYPR
  PUSH AF
  CALL PO,DIV10
  POP AF
  CALL PE,L2DC9
  POP AF
  POP HL
  POP DE
  INC A
  RET

; This entry point is used by the routine at _ASCTFP.
ADDIG:
  PUSH DE                 ; Save sign of exponent/digit
  LD A,B                  ; Get digits after point
  ADC A,C                 ; Add one if after point
  LD B,A                  ; Re-save counter
  PUSH BC                 ; Save point flags
  PUSH HL                 ; Save code string address
  LD A,(HL)
  SUB '0'                 ; convert from ASCII
  PUSH AF                 
  CALL GETYPR             ; Get the number type (FAC)
  JP P,MULTEN_4           
  LD HL,(FACCU)           
  LD DE,$0CCD             ; const
  CALL DCOMPR             ; Compare HL with DE.
  JP NC,MULTEN_3
  LD D,H
  LD E,L
  ADD HL,HL               ; * 10
  ADD HL,HL
  ADD HL,DE
  ADD HL,HL
  POP AF
  LD C,A
  ADD HL,BC
  LD A,H
  OR A
  JP M,MULTEN_2
  LD (FACCU),HL
MULTEN_1:
  POP HL
  POP BC
  POP DE
  JP _ASCTFP_0

MULTEN_2:
  LD A,C
  PUSH AF
MULTEN_3:
  CALL INT_CSNG
  SCF
MULTEN_4:
  JP NC,MULTEN_6
  LD BC,$9474			; 1000000
  LD DE,$2400
  CALL FCOMP
  JP P,MULTEN_5
  CALL MLSP10
  POP AF
  CALL MULTEN_7
  JP MULTEN_1

MULTEN_5:
  CALL ZERO_FACCU
MULTEN_6:
  CALL DECDIV_4
  CALL FP_ARG2HL
  POP AF
  CALL FLGREL
  CALL ZERO_FACCU
  CALL DECADD
  JP MULTEN_1
MULTEN_7:
  CALL STAKFP
  CALL FLGREL
; This entry point is used by the routine at IADD.
MULTEN_8:
  POP BC
  POP DE
  JP FADD

; This entry point is used by the routine at _ASCTFP.
DBL_EXPONENTIAL_EXPONENT:
  LD A,E
  CP 10
  JP NC,MULTEN_10
  RLCA
  RLCA
  ADD A,E
  RLCA
  ADD A,(HL)
  SUB '0'                 ; convert from ASCII
  LD E,A
  DEFB $FA                ; JP M,nn  to mask the next 2 bytes
MULTEN_10:
  LD E,$7F
  JP DBL_EXPONENTIAL_0

; This entry point is used by the routines at FDIV and DIV_OVTST1.
DIV_OVERR:
  PUSH HL
  LD HL,FACCU+2
  CALL GETYPR
  JP PO,MULTEN_11
  LD A,(DBL_LAST_FPREG)
  JP MULTEN_12

MULTEN_11:
  LD A,C
MULTEN_12:
  XOR (HL)
  RLA
  POP HL
  JP DECDIV_SUB_1

; This entry point is used by the routine at __EXP.
MUL_OVERR:
  POP AF
  POP AF

; Deal with various overflow conditions
;
; Used by the routine at MLSP10.
OVERR:
  LD A,(FACCU+2)
  RLA
  JP DECDIV_SUB_1

; This entry point is used by the routine at BNORM.
OVERR_0:
  POP AF
; This entry point is used by the routines at FADD, DECADD and DECDIV.
OVERR_1:
  LD A,(SGNRES)
  CPL
  RLA
  JP DECDIV_SUB_1

; This entry point is used by the routine at FDIV.
DIV_DZERR:
  OR B
  JP Z,DECDIV_SUB_0
  LD A,C
  JP DECDIV_SUB_0

; Division (exponent is 0)
;
; Used by the routine at DECDIV.
DECDIV_SUB:
  LD A,(FACCU+2)
; This entry point is used by the routines at OVERR and __SQR.
DECDIV_SUB_0:
  RLA
  LD HL,DIV0_MSG
  LD (MATH_ERRTXT),HL
; This entry point is used by the routines at MULTEN and OVERR.
DECDIV_SUB_1:
  PUSH HL
  PUSH BC
  PUSH DE
  PUSH AF
  PUSH AF
  LD HL,(ONELIN)
  LD A,H
  OR L
  JP NZ,DECDIV_SUB_3
  LD HL,RESFLG
  LD A,(HL)
  OR A
  JP Z,DECDIV_SUB_2
  DEC A
  JP NZ,DECDIV_SUB_3
  INC (HL)
DECDIV_SUB_2:
  LD HL,(MATH_ERRTXT)
  CALL TXTPUT_SP
  LD (TTYPOS),A
  LD A,$0D
  CALL CHPUT_SP
  LD A,$0A
  CALL CHPUT_SP
DECDIV_SUB_3:
  POP AF
  LD HL,FACCU
  LD DE,DECDIV_CONST
  JP NC,DECDIV_SUB_4
  LD DE,DECDIV_CONST2
DECDIV_SUB_4:
  CALL MOVE
  CALL GETYPR
  JP C,DECDIV_SUB_5
  LD HL,FACLOW
  LD DE,DECDIV_CONST2
  CALL MOVE
DECDIV_SUB_5:
  LD HL,(ONELIN)
  LD A,H
  OR L
  LD HL,(MATH_ERRTXT)
  LD DE,OVERFLOW_MSG
  EX DE,HL
  LD (MATH_ERRTXT),HL
  JP Z,DECDIV_SUB_6
  CALL DCOMPR
  JP Z,OV_ERR
  JP O_ERR

DECDIV_SUB_6:
  POP AF
  POP DE
  POP BC
  POP HL
  RET

DECDIV_CONST:
  DEFB $FF,$FF,$7F,$FF
DECDIV_CONST2:
  DEFB $FF,$FF,$FF,$FF

; LNUM_MSG
;
; Used by the routines at _ERROR_REPORT and _LINE2PTR.
LNUM_MSG:
  PUSH HL
  LD HL,IN_MSG
  CALL PRS
  POP HL
; This entry point is used by the routines at PROMPT, NEWSTT_0, __LIST, _LINE2PTR,
; __EDIT and DONCMD.
_PRNUM:
  LD BC,PRNUMS
  PUSH BC
  CALL INT_RESULT_HL
  XOR A
  CALL INIT_FBUFFR
  OR (HL)
  JP SPCFST

; Convert number/expression to string (format not specified)
; a.k.a. NUMASC
; Used by the routines at __PRINT, LISPRT, L3356, L46AB and __STR_S.
FOUT:
  XOR A

; Convert number/expression to string ("PRINT USING" format specified in 'A'
; register)
;
; Used by the routine at L5256.
PUFOUT:
  CALL INIT_FBUFFR
  AND $08
  JP Z,PUFOUT_0
  LD (HL),'+'
PUFOUT_0:
  EX DE,HL
  CALL _TSTSGN            ; Test sign of FPREG
  EX DE,HL
  JP P,SPCFST             ; Positive - Space to start
  LD (HL),'-'             ; "-" sign at start
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H
; This entry point is used by the routine at LNUM_MSG.
SPCFST:
  INC HL                  ; First byte of number
  LD (HL),'0'             ; "0" if zero
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,PUFOUT_24
  JP Z,PUFOUT_23

  CP $04
  JP NC,PUFOUT_7
  LD BC,$0000
  CALL RNGTST_23
PUFOUT_1:
  LD HL,FBUFFR+1
  LD B,(HL)
  LD C,$20
  LD A,(TEMP3)
  LD E,A
  AND $20
  JP Z,PUFOUT_2
  LD A,B
  CP C
  LD C,$2A
  JP NZ,PUFOUT_2
  LD A,E
  AND $04
  JP NZ,PUFOUT_2
  LD B,C
PUFOUT_2:
  LD (HL),C
  CALL CHRGTB
  JP Z,PUFOUT_3
  CP 'E'
  JP Z,PUFOUT_3
  CP $44
  JP Z,PUFOUT_3
  CP '0'
  JP Z,PUFOUT_2
  CP ','
  JP Z,PUFOUT_2
  CP '.'
  JP NZ,PUFOUT_4
PUFOUT_3:
  DEC HL
  LD (HL),'0'
PUFOUT_4:
  LD A,E
  AND $10
  JP Z,PUFOUT_5
  DEC HL
  LD (HL),'$'
PUFOUT_5:
  LD A,E
  AND $04
  RET NZ
  DEC HL
  LD (HL),B
  RET

; This entry point is used by the routine at LNUM_MSG.
INIT_FBUFFR:
  LD (TEMP3),A
  LD HL,FBUFFR+1
  LD (HL),' '
  RET

PUFOUT_7:
  CALL STAKFP
  EX DE,HL
  LD HL,(FACLOW)
  PUSH HL
  LD HL,(FACLOW+2)
  PUSH HL
  EX DE,HL
  PUSH AF
  XOR A
  LD (PUFOUT_FLG),A
  POP AF
  PUSH AF
  CALL PUFOUT_19
  LD B,'E'
  LD C,$00
PUFOUT_8:
  PUSH HL
  LD A,(HL)
PUFOUT_9:
  CP B
  JP Z,PUFOUT_12
  CP '9'+1
  JP NC,PUFOUT_10
  CP '0'
  JP C,PUFOUT_10
  INC C
PUFOUT_10:
  INC HL
  LD A,(HL)
  OR A
  JP NZ,PUFOUT_9
  LD A,$44
  CP B
  LD B,A
  POP HL
  LD C,$00
  JP NZ,PUFOUT_8
PUFOUT_11:
  POP AF
  POP BC
  POP DE
  EX DE,HL
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACLOW+2),HL
  EX DE,HL
  POP BC
  POP DE
  RET

PUFOUT_12:
  PUSH BC
  LD B,$00
  INC HL
  LD A,(HL)
PUFOUT_13:
  CP '+'
  JP Z,PUFOUT_17
  CP '-'
  JP Z,PUFOUT_14
  SUB '0'                 ; convert from ASCII
  LD C,A
  LD A,B
  ADD A,A
  ADD A,A
  ADD A,B
  ADD A,A
  ADD A,C
  LD B,A
  CP $10
  JP NC,PUFOUT_17
PUFOUT_14:
  INC HL
  LD A,(HL)
  OR A
  JP NZ,PUFOUT_13
  LD H,B
  POP BC
  LD A,B
  CP 'E'
  JP NZ,PUFOUT_16
  LD A,C
  ADD A,H
  CP $09
  POP HL
  JP NC,PUFOUT_11
PUFOUT_15:
  LD A,$80
  LD (PUFOUT_FLG),A
  JP PUFOUT_18
  
PUFOUT_16:
  LD A,H
  ADD A,C
  CP $12
  POP HL
  JP NC,PUFOUT_11
  JP PUFOUT_15
  
PUFOUT_17:
  POP BC
  POP HL
  JP PUFOUT_11
  
PUFOUT_18:
  POP AF
  POP BC
  POP DE
  EX DE,HL
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACLOW+2),HL
  EX DE,HL
  POP BC
  POP DE
  CALL FPBCDE
  INC HL
PUFOUT_19:
  CP $05
  PUSH HL
  SBC A,$00
  RLA
  LD D,A
  INC D
  CALL L3356_17
  LD BC,$0300
  PUSH AF
  LD A,(PUFOUT_FLG)
  OR A
  JP P,PUFOUT_20
  POP AF
  ADD A,D
  JP PUFOUT_21
  
PUFOUT_20:
  POP AF
  ADD A,D
  JP M,PUFOUT_22
  INC D
  CP D
  JP NC,PUFOUT_22
PUFOUT_21:
  INC A
  LD B,A
  LD A,$02
PUFOUT_22:
  SUB $02
  POP HL
  PUSH AF
  CALL RNGTST_10
  LD (HL),'0'
  CALL Z,INCHL
  CALL RNGTST_16

SUPTLZ:
  DEC HL                  ; Move back through buffer
  LD A,(HL)               ; Get character
  CP '0'                  ; "0" character?
  JP Z,SUPTLZ             ; Yes - Look back for more
  CP '.'                  ; A decimal point?
  CALL NZ,INCHL           ; Move back over digit
  POP AF                  ; Get "E" flag
  JP Z,NOENED             ; No "E" needed - End buffer

; This entry point is used by the routine at L3356.
DOEBIT:
  PUSH AF
  CALL GETYPR
  LD A,$22                ; 'D'/2
  ADC A,A                 ; 'D' (?) or 'E'
  LD (HL),A               ; Put "E" in buffer
  INC HL                  ; And move on
  POP AF
  LD (HL),'+'             ; Put '+' in buffer
  JP P,OUTEXP             ; Positive - Output exponent
  LD (HL),'-'             ; Put "-" in buffer
  CPL                     ; Negate exponent
  INC A
OUTEXP:
  LD B,$2F                ; ASCII "0" - 1
EXPTEN:
  INC B                   ; Count subtractions
  SUB $0A                 ; Tens digit
  JP NC,EXPTEN            ; More to do
  ADD A,$3A               ; '0'+10: Restore and make ASCII
  INC HL                  ; Move on
  LD (HL),B               ; Save MSB of exponent
  INC HL
  LD (HL),A               ; Save LSB of exponent

PUFOUT_23:
  INC HL
NOENED:
  LD (HL),$00
  EX DE,HL
  LD HL,FBUFFR+1
  RET

PUFOUT_24:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,L3356_1
  RRA
  JP C,L3356_11
  LD BC,$0603
  CALL RNGTST_9
  POP DE
  LD A,D
  SUB $05
  CALL P,RNGTST_2
  CALL RNGTST_23
; This entry point is used by the routine at L3356.
PUFOUT_25:
  LD A,E
  OR A
  CALL Z,DCXH
  DEC A
  CALL P,RNGTST_2
; This entry point is used by the routine at L3356.
PUFOUT_26:
  PUSH HL
  CALL PUFOUT_1
  POP HL
  JP Z,PUFOUT_27
  LD (HL),B
  INC HL
PUFOUT_27:
  LD (HL),$00
  LD HL,FBUFFR
PUFOUT_28:
  INC HL
; This entry point is used by the routine at L3356.
PUFOUT_29:
  LD A,(NXTOPR)
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP ' '
  JP Z,PUFOUT_28
  CP '*'
  JP Z,PUFOUT_28
  DEC HL
  PUSH HL

L3336:
  PUSH AF

  LD BC,L3336
  PUSH BC

  CALL CHRGTB
  CP '-'
  RET Z
  CP '+'
  RET Z
  CP '$'
  RET Z
  POP BC
  CP '0'
  JP NZ,L3356_0
  INC HL
  CALL CHRGTB
  JP NC,L3356_0
  DEC HL
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; Routine at 13142
L3356:
  DEC HL
  LD (HL),A
  POP AF
  JP Z,L3356
  POP BC
  JP PUFOUT_29
  
; This entry point is used by the routine at L3338.
L3356_0:
  POP AF
  JP Z,L3356_0
  POP HL
  LD (HL),$25
  RET

; This entry point is used by the routine at PUFOUT.
L3356_1:
  PUSH HL
  RRA
  JP C,L3356_12
  JP Z,L3356_3
  LD DE,TAB_3628
  CALL CMPPHL
  LD D,$10
  JP M,L3356_4
L3356_2:
  POP HL
  POP BC
  CALL FOUT
  DEC HL
  LD (HL),$25
  RET

L3356_3:
  LD BC,$B60E	; 10000000000000000
  LD DE,$1BCA
  CALL FCOMP
  JP P,L3356_2
  LD D,$06
L3356_4:
  CALL SIGN
  CALL NZ,L3356_17
  POP HL
  POP BC
  JP M,L3356_5
  PUSH BC
  LD E,A
  LD A,B
  SUB D
  SUB E
  CALL P,RNGTST_2
  CALL RNGTST_7
  CALL RNGTST_16
  OR E
  CALL NZ,RNGTST_6
  OR E
  CALL NZ,RNGTST_12
  POP DE
  JP PUFOUT_25

L3356_5:
  LD E,A
  LD A,C
  OR A
  CALL NZ,DCR_A
  ADD A,E
  JP M,L3356_6
  XOR A
L3356_6:
  PUSH BC
  PUSH AF
L3356_7:
  CALL M,MULTEN_0
  JP M,L3356_7
  POP BC
  LD A,E
  SUB B
  POP BC
  LD E,A
  ADD A,D
  LD A,B
  JP M,L3356_8
  SUB D
  SUB E
  CALL P,RNGTST_2
  PUSH BC
  CALL RNGTST_7
  JP L3356_9

L3356_8:
  CALL RNGTST_2
  LD A,C
  CALL RNGTST_14
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL RNGTST_2
  PUSH BC
  LD B,A
  LD C,A
L3356_9:
  CALL RNGTST_16
  POP BC
  OR C
  JP NZ,L3356_10
  LD HL,(NXTOPR)
L3356_10:
  ADD A,E
  DEC A
  CALL P,RNGTST_2
  LD D,B
  JP PUFOUT_26

; This entry point is used by the routine at PUFOUT.
L3356_11:
  PUSH HL
  PUSH DE
  CALL INT_CSNG
  POP DE
  XOR A
L3356_12:
  JP Z,L3412
  LD E,$10

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

L3412:
  LD E,$06

  CALL SIGN
  SCF
  CALL NZ,L3356_17
  POP HL
  POP BC
  PUSH AF
  LD A,C
  OR A
  PUSH AF
  CALL NZ,DCR_A
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
  PUSH BC
L3356_13:
  CALL M,MULTEN_0
  JP M,L3356_13
  POP BC
  POP AF
  PUSH BC
  PUSH AF
  JP M,L3356_14
  XOR A
L3356_14:
  CPL
  INC A
  ADD A,B
  INC A
  ADD A,D
  LD B,A
  LD C,$00
  CALL RNGTST_16
  POP AF
  CALL P,RNGTST_4
  CALL RNGTST_12
  POP BC
  POP AF
  JP NZ,L3356_15
  CALL DCXH
  LD A,(HL)
  CP '.'
  CALL NZ,INCHL
  LD (NXTOPR),HL
L3356_15:
  POP AF
  JP C,L3356_16
  ADD A,E
  SUB B
  SUB D
L3356_16:
  PUSH BC
  CALL DOEBIT
  EX DE,HL
  POP DE
  JP PUFOUT_26

; This entry point is used by the routine at PUFOUT.
L3356_17:
  PUSH DE
  XOR A                   ; Zero A
  PUSH AF                 ; Save it
  CALL GETYPR
  JP PO,L3356_19
L3356_18:
  LD A,(FPEXP)
  CP $91
  JP NC,L3356_19
  LD DE,DBL_FP_SMALL
  LD HL,FPARG
  CALL FP2HL
  CALL DECMUL
  POP AF                  ; Restore count
  SUB 10                  ; subtract 10
  PUSH AF                 ; Re-save count
  JP L3356_18

L3356_19:
  CALL RNGTST             ; Test number is in range
SIXDIG:
  CALL GETYPR
  JP PE,L3356_20
  LD BC,$9143             ; BCDE = 100000
  LD DE,$4FF9
  CALL FCOMP              ; Compare numbers
  JP L3356_21

L3356_20:
  LD DE,DBL_FP_BIG
  CALL CMPPHL
L3356_21:
  JP P,L3356_23
  POP AF                  ; Restore count
  CALL MULTEN             ; Multiply by ten
  PUSH AF                 ; Re-save count
  JP SIXDIG               ; Test it again

; This entry point is used by the routine at RNGTST.
L3356_22:
  POP AF
  CALL MULTEN_0
  PUSH AF
  CALL RNGTST
L3356_23:
  POP AF
  OR A
  POP DE
  RET

; Routine at 13513
;
; Used by the routine at L3356.
RNGTST:
  CALL GETYPR
  JP PE,RNGTST_0
  LD BC,$9474             ; BCDE = 1000000
  LD DE,$23F8
  CALL FCOMP              ; Compare numbers
  JP RNGTST_1

RNGTST_0:
  LD DE,DBL_FP_999999
  CALL CMPPHL
RNGTST_1:
  POP HL
  JP P,L3356_22
  JP (HL)

; This entry point is used by the routines at PUFOUT and L3356.
RNGTST_2:
  OR A
RNGTST_3:
  RET Z
  DEC A
  LD (HL),'0'
  INC HL
  JP RNGTST_3

; This entry point is used by the routine at L3356.
RNGTST_4:
  JP NZ,RNGTST_6
RNGTST_5:
  RET Z
  CALL RNGTST_12
; This entry point is used by the routine at L3356.
RNGTST_6:
  LD (HL),'0'
  INC HL
  DEC A
  JP RNGTST_5

; This entry point is used by the routine at L3356.
RNGTST_7:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
RNGTST_8:
  SUB $03
  JP NC,RNGTST_8
  ADD A,$05
  LD C,A
; This entry point is used by the routine at PUFOUT.
RNGTST_9:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET

; This entry point is used by the routine at PUFOUT.
RNGTST_10:
  DEC B
  JP P,RNGTST_13
  LD (NXTOPR),HL
  LD (HL),'.'             ; Save point
RNGTST_11:
  INC HL                  ; Move on
  LD (HL),'0'             ; Save zero
  INC B
  JP NZ,RNGTST_11
  INC HL                  ; Move on
  LD C,B
  RET

; This entry point is used by the routine at L3356.
RNGTST_12:
  DEC B
RNGTST_13:
  JP NZ,RNGTST_15
; This entry point is used by the routine at L3356.
RNGTST_14:
  LD (HL),'.'
  LD (NXTOPR),HL
  INC HL
  LD C,B
  RET

RNGTST_15:
  DEC C
  RET NZ
  LD (HL),','
  INC HL
  LD C,$03
  RET

  
; This entry point is used by the routines at PUFOUT and L3356.
RNGTST_16:
  PUSH DE
  CALL GETYPR
  JP PO,RNGTST_19

  PUSH BC
  PUSH HL
  CALL FP_ARG2HL
  LD HL,DBL_FP_ZERO
  CALL FP_HL2DE
  CALL DECADD
  XOR A
  CALL INT_4
  POP HL
  POP BC
  
  LD DE,TAB_3630
  LD A,$0A
RNGTST_17:
  CALL RNGTST_12
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  LD B,$2F			; '0'-1
RNGTST_18:
  INC B				; count
  POP HL
  PUSH HL
  LD A,$9E			; SBC A,(HL)
  CALL DEC_SMC_0
  JP NC,RNGTST_18
  POP HL
  LD A,$8E			; ADC A,(HL)
  CALL DEC_SMC_0
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,RNGTST_17
  PUSH BC
  PUSH HL
  LD HL,FACLOW
  CALL PHLTFP
  JP RNGTST_20
  
RNGTST_19:
  PUSH BC
  PUSH HL
  CALL ROUND
  LD A,$01
  CALL FPINT
  CALL FPBCDE
RNGTST_20:
  POP HL
  POP BC
  XOR A
  LD DE,POWERS_TAB
RNGTST_21:
  CCF
  CALL RNGTST_12
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  CALL BCDEFP
  POP HL
  LD B,$2F                ; ASCII "0" - 1
RNGTST_22:
  INC B
  LD A,E
  SUB (HL)
  LD E,A
  INC HL
  LD A,D
  SBC A,(HL)
  LD D,A
  INC HL
  LD A,C
  SBC A,(HL)
  LD C,A
  DEC HL
  DEC HL
  JP NC,RNGTST_22
  CALL PLUCDE
  INC HL
  CALL FPBCDE
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  JP C,RNGTST_21
  INC DE
  INC DE
  LD A,$04
  JP RNGTST_24

; This entry point is used by the routine at PUFOUT.
RNGTST_23:
  PUSH DE
  LD DE,POWERS_TAB_2
  LD A,$05
RNGTST_24:
  CALL RNGTST_12
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
  LD HL,(FACCU)
  LD B,$2F                ; ASCII "0" - 1
RNGTST_25:
  INC B
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP NC,RNGTST_25
  ADD HL,DE
  LD (FACCU),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,RNGTST_24
  CALL RNGTST_12
  LD (HL),A
  POP DE
  RET

DBL_FP_SMALL:
  DEFB $00,$00,$00,$00,$F9,$02,$15,$A2
DBL_FP_BIG:
  DEFB $E1,$FF,$9F,$31,$A9,$5F,$63,$B2
DBL_FP_999999:
  DEFB $FE,$FF,$03,$BF,$C9,$1B,$0E,$B6

DBL_FP_ZERO:
  DEFB $00,$00,$00,$00
FP_HALF:
  DEFB $00,$00,$00,$80

TAB_3628:
  DEFB $00,$00,$04,$BF,$C9,$1B,$0E,$B6

TAB_3630:
  DEFB $00,$80,$C6,$A4,$7E,$8D,$03,$00
  
  DEFB $40,$7A,$10,$F3,$5A,$00
  DEFB $00,$A0,$72,$4E,$18,$09,$00
  DEFB $00,$10,$A5,$D4,$E8,$00,$00,$00
  DEFB $E8,$76,$48,$17,$00,$00,$00,$E4
  DEFB $0B,$54,$02,$00,$00,$00,$CA,$9A
  DEFB $3B,$00,$00,$00,$00,$E1,$F5,$05
  DEFB $00,$00,$00,$80,$96,$98,$00,$00
  DEFB $00,$00,$40,$42,$0F,$00,$00,$00
  DEFB $00
POWERS_TAB:
  DEFB $A0,$86,$01        ; 100000
  DEFB $10,$27,$00        ; 10000
POWERS_TAB_2:
  DEFB $10,$27,$E8        ; 100
  DEFB $03,$64,$00        ; 10
  DEFB $0A,$00,$01        ; 1
  DEFB $00

; Octal string conversion
;
; Used by the routines at LISPRT and __OCT_S.
OCT_STR:
  XOR A
  LD B,A
  DEFB $C2                ; "JP NZ,nn" to skip the next instruction (B=0)

; Hex string conversion
;
; Used by the routines at LISPRT and __HEX_S.
HEX_STR:
  LD B,$01				; B=1
  
  PUSH BC
  CALL GETWORD_HL
  POP BC
  LD DE,FBUFFR
  PUSH DE
  XOR A
  LD (DE),A
  DEC B
  INC B
  LD C,$06
  JP Z,NOT_HEX
  LD C,$04
HEX_STR_0:
  ADD HL,HL
  ADC A,A
HEX_STR_1:
  ADD HL,HL
  ADC A,A
  ADD HL,HL
  ADC A,A

NOT_HEX:
  ADD HL,HL
  ADC A,A
  OR A
  JP NZ,HEX_STR_3
  LD A,C
  DEC A
  JP Z,HEX_STR_3
  LD A,(DE)
  OR A
  JP Z,HEX_STR_5
  XOR A
HEX_STR_3:
  ADD A,'0'               ; +'0': convert to ASCII
  CP '9'+1
  JP C,HEX_STR_4
  ADD A,$07               ; A..F
HEX_STR_4:
  LD (DE),A
  INC DE
  LD (DE),A
HEX_STR_5:
  XOR A
  DEC C
  JP Z,HEX_STR_6
  DEC B
  INC B
  JP Z,HEX_STR_1
  JP HEX_STR_0

HEX_STR_6:
  LD (DE),A
  POP HL
  RET

; Negate number
;
; Used by the routines at __SQR and __ATN.
NEGAFT:
  LD HL,NEG
  EX (SP),HL
  JP (HL)

; 'SQR' BASIC function
__SQR:
  CALL STAKFP             ; Put value on stack
  LD HL,FP_HALF           ; Set power to 1/2
  CALL PHLTFP             ; Move 1/2 to FPREG
  JP POWER_0

POWER:
  CALL __CSNG

POWER_0:
  POP BC                  ; Get base
  POP DE
  LD HL,CLROVC            ;BACK TO NORMAL OVERFLOW PRINT MODE
  PUSH HL
  LD A,$01
  LD (RESFLG),A
  CALL SIGN               ; Test sign of power
  LD A,B                  ; Get exponent of base
  JP Z,__EXP              ; Make result 1 if zero
  JP P,POWER1             ; Positive base - Ok
  OR A                    ; Zero to negative power?
  JP Z,DECDIV_SUB_0       ; Yes - ?/0 Error
POWER1:
  OR A                    ; Base zero?
  JP Z,SAVE_EXPONENT      ; Yes - Return zero
  PUSH DE                 ; Save base
  PUSH BC
  LD A,C                  ; Get MSB of base
  OR $7F                  ; Get sign status
  CALL BCDEFP             ; Move power to BCDE
  JP P,POWER2             ; Positive base - Ok
  PUSH AF                 ; Save power
  LD A,(FPEXP)
  CP $99
  JP C,POWER_2
  POP AF
  JP POWER2

POWER_2:
  POP AF
  PUSH DE
  PUSH BC
  CALL INT                ; Get integer of power
  POP BC                  ; Restore power
  POP DE
  PUSH AF                 ; MSB of base
  CALL FCOMP              ; Power an integer?
  POP HL                  ; Restore MSB of base
  LD A,H                  ; but don't affect flags
  RRA                     ; Exponent odd or even?

POWER2:
  POP HL                  ; Restore MSB and exponent
  LD (FACCU+2),HL           ; Save base in FPREG
  POP HL                  ; LSBs of base
  LD (FACCU),HL           ; Save in FPREG
  CALL C,NEGAFT           ; Odd power - Negate result
  CALL Z,NEG              ; Negative base - Negate it
  PUSH DE                 ; Save power
  PUSH BC
  CALL __LOG              ; Get LOG of base
  POP BC                  ; Restore power
  POP DE

; EXP
EXP:
  CALL FMULT              ; Multiply LOG by power

; label='EXP' BASIC function
;
; Used by the routine at __SQR.
__EXP:
  LD BC,$8138             ; BCDE = 1/Ln(2)
  LD DE,$AA3B
  CALL FMULT              ; Multiply value by 1/LN(2)
  LD A,(FPEXP)            ; Get exponent
  CP $88                  ; Is it in range?  (80H+8)
  JP NC,MUL_OVTST1        ; No - Test for overflow
  CP $68
  JP C,GET_UNITY          ; Load '1' to FP accumulator
  CALL STAKFP             ; Put value on stack
  CALL INT                ; Get INT of FP accumulator
  ADD A,$81               ; 80h+1: For excess 128, Exponent = 126?
  JP Z,MUL_OVTST2         ; Yes - Test for overflow
  POP BC
  POP DE
  PUSH AF
  CALL FSUB               ; Subtract exponent from FP accumulator
  LD HL,FP_EXPTAB         ; Coefficient table
  CALL SMSER1             ; Sum the series
  POP BC                  ; Zero LSBs
  LD DE,$0000             ; Scaling factor
  LD C,D                  ; Zero MSB
  JP FMULT                ; Scale result to correct value

MUL_OVTST1:
  CALL STAKFP
MUL_OVTST2:
  LD A,(FACCU+2)
  OR A                    ; Test if new exponent zero
  JP P,RESZER             ; Result zero
  POP AF
  POP AF
  JP ZERO_EXPONENT

RESZER:
  JP MUL_OVERR            ; Overflow error

; Load '1' to FP accumulator
;
; Used by the routine at __EXP.
GET_UNITY:
  LD BC,$8100
  LD DE,$0000
  JP FPBCDE

FP_EXPTAB:
  DEFB $07
  DEFB $7C,$88,$59,$74
  DEFB $E0,$97,$26,$77
  DEFB $C4,$1D,$1E,$7A
  DEFB $5E,$50,$63,$7C
  DEFB $1A,$FE,$75,$7E
  DEFB $18,$72,$31,$80
  DEFB $00,$00,$00,$81    ; 1/0! ( 1/1)

; Series math sub
;
; Used by the routines at __SIN and __ATN.
SUMSER:
  CALL STAKFP             ; Put FPREG on stack
  LD DE,POP_FMULT         ; Multiply by "X"
  PUSH DE                 ; To be done after
  PUSH HL                 ; Save address of table
  CALL BCDEFP             ; Move FPREG to BCDE
  CALL FMULT              ; Square the value
  POP HL                  ; Restore address of table

; Put value on stack
;
; Used by the routines at __LOG and __EXP.
SMSER1:
  CALL STAKFP
  LD A,(HL)               ; Get number of coefficients
  INC HL                  ; Point to start of table
  CALL PHLTFP             ; Move coefficient to FPREG
  DEFB $06                ; Skip "POP AF"
SUMLP:
  POP AF                  ; Restore count
  POP BC                  ; Restore number
  POP DE
  DEC A                   ; Cont coefficients
  RET Z                   ; All done
  PUSH DE                 ; Save number
  PUSH BC
  PUSH AF                 ; Save count
  PUSH HL                 ; Save address in table
  CALL FMULT              ; Multiply FPREG by BCDE
  POP HL                  ; Restore address in table
  CALL LOADFP             ; Number at HL to BCDE
  PUSH HL                 ; Save address in table
  CALL FADD               ; Add coefficient to FPREG
  POP HL                  ; Restore address in table
  JP SUMLP                ; More coefficients

RND_CONST:
  DEFB $52,$C7,$4F,$80    ; @14303 ($37DF)

; Routine at 14307
;
; Used by the routine at OPRND_3.
RND_SUB:
  CALL CHRGTB

; Routine at 14310
;
; Used by the routine at __RANDOMIZE.
SEED_SHUFFLE:
  PUSH HL
  LD HL,FP_UNITY
  CALL PHLTFP
  CALL __RND
  POP HL
  JP SETTYPE_SNG

; 'RND' BASIC function
;
; Used by the routine at SEED_SHUFFLE.
__RND:
  CALL SIGN               ; Test sign of FPREG
  LD HL,SEED+2             ; Random number seed
  JP M,RESEED             ; Negative - Re-seed
  LD HL,RNDX              ; Last random number
  CALL PHLTFP             ; Move last RND to FPREG
  LD HL,SEED+2             ; Random number seed
  RET Z                   ; Return if RND(0)
  ADD A,(HL)              ; Add (SEED)+2)
  AND $07                 ; 0 to 7
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
  LD HL,RNDX              ; (RNDTAB-4) Addition table
  ADD A,A                 ; 4 bytes
  ADD A,A                 ; per entry
  LD C,A                  ; BC = Offset into table
  ADD HL,BC               ; Point to value
  CALL FADD_HLPTR         ; Add value to FPREG
RND1:
  CALL BCDEFP             ; Return RND seed
  LD A,E                  ; Get LSB
  LD E,C                  ; LSB = MSB
  XOR $4F                 ; 01001111.. Fiddle around
  LD C,A                  ; New MSB
  LD (HL),$80             ; Set exponent
  DEC HL                  ; Point to MSB
  LD B,(HL)               ; Get MSB
  LD (HL),$80             ; Make value -0.5
  LD HL,SEED              ; Random number seed
  INC (HL)                ; Count seed
  LD A,(HL)               ; Get seed
  SUB $AB                 ; Do it modulo 171
  JP NZ,RND2              ; Non-zero - Ok
  LD (HL),A               ; Zero seed
  INC C                   ; Fillde about
  DEC D                   ; with the
  INC E                   ; number
RND2:
  CALL BNORM              ; Normalise number
  LD HL,RNDX              ; Save random number
  JP FPTHL                ; Move FPREG to last and return

RESEED:
  LD (HL),A               ; Re-seed random numbers
  DEC HL
  LD (HL),A
  DEC HL
  LD (HL),A
  JP RND1


SEED:
  DEFB $00,$00,$00        ; Random number seed


; Table used by RND
L3860:
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
  DEFB $52,$C7,$4F,$80    ; Last random number

; Routine at 14468
RNDTAB:
  DEFB $68,$B1,$46,$68    ; Table used by RND
  DEFB $99,$E9,$92,$69
  DEFB $10,$D1,$75,$68

; 'COS' BASIC function
;
; Used by the routine at __TAN.
__COS:
  LD HL,FP_HALFPI
  CALL FADD_HLPTR

; 'SIN' BASIC function
;
; Used by the routine at __TAN.
__SIN:
  LD A,(FPEXP)
  CP $77
  RET C
  LD A,(FACCU+2)
  OR A
  JP P,__SIN_0
  AND $7F
  LD (FACCU+2),A
  LD DE,NEG
  PUSH DE
__SIN_0:
  LD BC,$7E22             ; BCDE = FP_EPSILON: 1/(2*PI) =~ 0.159155
  LD DE,$F983
  CALL FMULT
  CALL STAKFP
  CALL INT
  POP BC
  POP DE
  CALL FSUB
  LD BC,$7F00             ; 0.25
  LD DE,$0000
  CALL FCOMP
  JP M,__SIN_1
  LD BC,$7F80             ; -.025
  LD DE,$0000
  CALL FADD
  LD BC,$8080             ; -0.5
  LD DE,$0000
  CALL FADD
  CALL SIGN
  CALL P,NEG
  LD BC,$7F00             ; 0.25
  LD DE,$0000
  CALL FADD
  CALL NEG
__SIN_1:
  LD A,(FACCU+2)
  OR A
  PUSH AF
  JP P,__SIN_2
  XOR $80
  LD (FACCU+2),A
__SIN_2:
  LD HL,FP_SINTAB
  CALL SUMSER
  POP AF
  RET P
  LD A,(FACCU+2)
  XOR $80
  LD (FACCU+2),A
  RET


  DEFB $00,$00,$00,$00

; Routine at 14610
FP_EPSILON:
  DEFB $83,$F9,$22,$7E    ; 1/(2*PI) 0.159155

; Routine at 14614
FP_HALFPI:
  DEFB $DB,$0F,$49,$81    ; 1.5708 (PI/2)

FP_QUARTER:
  DEFB $00,$00,$00,$7F    ; 0.25

FP_SINTAB:
  DEFB $05                ; Table used by SIN
  DEFB $FB,$D7,$1E,$86    ; 39.711
  DEFB $65,$26,$99,$87    ; -76.575
  DEFB $58,$34,$23,$87    ; 81.602
  DEFB $E1,$5D,$A5,$86    ; -41.342
  DEFB $DB,$0F,$49,$83    ; 6.2832

; 'TAN' BASIC function
__TAN:
  CALL STAKFP             ; Put angle on stack
  CALL __SIN              ; Get SIN of angle
  POP BC                  ; Restore angle
  POP HL
  CALL STAKFP             ; Save SIN of angle
  EX DE,HL                ; BCDE = Angle
  CALL FPBCDE             ; Angle to FPREG
  CALL __COS              ; Get COS of angle
  JP DIV                  ; TAN = SIN / COS

; 'ATN' BASIC function
__ATN:
  CALL SIGN               ; Test sign of value
  CALL M,NEGAFT           ; Negate result after if -ve
  CALL M,NEG              ; Negate value if -ve
  LD A,(FPEXP)            ; Get exponent
  CP $81                  ; Number less than 1?
  JP C,__ATN_0            ; Yes - Get arc tangnt
  LD BC,$8100             ; BCDE = 1
  LD D,C
  LD E,C
  CALL FDIV               ; Get reciprocal of number
  LD HL,SUBPHL            ; Sub angle from PI/2
  PUSH HL                 ; Save for angle > 1
__ATN_0:
  LD HL,ATNTAB            ; Coefficient table
  CALL SUMSER             ; Evaluate sum of series
  LD HL,FP_HALFPI         ; PI/2 - angle in case > 1
  RET                     ; Number > 1 - Sub from PI/2

ATNTAB:
  DEFB $09
  DEFB $4A,$D7,$3B,$78    ; 1/17
  DEFB $02,$6E,$84,$7B    ; -1/15
  DEFB $FE,$C1,$2F,$7C    ; 1/13
  DEFB $74,$31,$9A,$7D    ; -1/11
  DEFB $84,$3D,$5A,$7D    ; 1/9
  DEFB $C8,$7F,$91,$7E    ; -1/7
  DEFB $E4,$BB,$4C,$7E    ; 1/5
  DEFB $6C,$AA,$AA,$7F    ; -1/3
  DEFB $00,$00,$00,$81    ; 1/1

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
  JP Z,WASEOF             ;NO BYTES LEFT
  LD A,(BC)               ;** 5.11 **  GET FILE MODE
  CP $03                  ;IS IT A RANDOM FILE?
  JP Z,WASEOF             ;** 5.11 **  (A) .NE. 0 - not EOF
  INC HL                  ;POINT TO NUMBER LEFT IN BUFFER
  LD A,(HL)               ;GET NUMBER OF BYTES IN BUFFER
  OR A                    ;NON-ZERO?
  JP NZ,CHKCTZ            ;THEN CHECK FOR CONTROL-Z
  PUSH BC                 ;SAVE [B,C]
  LD H,B                  ;GET FCB POINTER IN [B,C]
  LD L,C                  
  CALL READIN             ;READ ANOTHER BUFFER
  POP BC                  ;RESTORE [B,C]
  JP ORNCHK               ;HAVE NEW BUFFER, USE PREVIOUS PROCEDURE
CHKCTZ:
  LD A,$80                ; (DATPSC) GET # OF BYTES IN FULL BUFFER
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
  JP INT_RESULT_A         ;CONVERT TO AN INTEGER AND RETURN

; This entry point is used by the routine at __LOF.
;
; [B,C] POINTS AT FILE DATA BLOCK
;
OUTSEQ:
  LD D,B                  ;PUT FILE BLOCK OFFSET IN [D,E]
  LD E,C
  INC DE                  ;POINT TO FCB
; This entry point is used by the routine at CPM_CLOSE_FILE.
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

  CALL SETDMA             ;SET BUFFER ADDRESS

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
  JP NZ,OUTSOK            ;NO
  POP DE                  ;GET BACK FILE POINTER
  XOR A                   ;GET ZERO
  LD (DE),A               ;MARK AS CLOSED
  LD C,$10                ;CLOSE IT (BDOS function 16 - Close file)
  INC DE                  ;POINT TO FCB
  CALL $0005              ;CALL CP/M
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


; CLOSE A FILE
;
; FILE NUMBER IS IN [A]
; ZERO ALL INFORMATION. IF FILE IS OPEN, RAISE ITS DISKS HEAD
; IF FILE IS SEQUENTIAL OUTPUT, SEND FINAL SECTOR OF DATA
;
; Used by the routine at __LOAD.
CPM_CLOSE_FILE:
  CALL FILIDX             ;GET POINTER TO DATA
  JP Z,NTOPNC             ;RETURN IF NOT OPEN
                          ;SAVE FILE #
  PUSH BC                 ;SAVE FILE POINTER
  LD A,(BC)               ;GET FILE MODE
  LD D,B                  ;PUT FILE BLOCK OFFSET IN [D,E]
  LD E,C                  
  INC DE                  ;POINT TO FCB
  PUSH DE                 ;SAVE [D,E] FOR LATER
  CP $02                  ;SEQENTIAL OUTPUT?
  JP NZ,NOFORC            ;NO NEED TO FORCE PARTIAL OUTPUT BUFFER
  LD HL,CLSFL1            ;RETURN HERE
  PUSH HL                 ;SAVE ON STACK
  PUSH HL                 ;NEED EXTRA STACK ENTRY
  LD H,B                  ;GET FILE POINTER
  LD L,C                  ;INTO [H,L]
  LD A,$1A                ;PUT OUT CONTROL-Z (OR FS)
  JP FILOU4               ;JUMP INTO CHAR OUTPUT CODE

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

  CALL SETDMA
  LD C,$10                ;THE CLOSE (BDOS function 16 - Close file)
  CALL $0005              ;CALL CPM
  
  ;*****	NO CHECK FOR ERRORS
  
  POP BC                  ;RESTORE FILE POINTER
NTOPNC:
  LD D,$29                ; (DATOFS) NUMBER OF BYTES TO ZERO
  XOR A
MORCZR:
  LD (BC),A
  INC BC
  DEC D
  JP NZ,MORCZR
  RET


; LOC (CURRENT LOCATION) AND LOF (LAST RECORD NUMBER)

; 'LOC' BASIC function
__LOC:
  CALL FILFRM            ;CONVERT ARGUMENT AND POINT AT DATA BLOCK
  JP Z,BN_ERR            ;IF NOT OPEN, "BAD FILE NUMBER"
  CP $03                 ;Random mode?
  LD HL,$0026            ;0+LOCOFS+1: Assume not
  JP NZ,LOC1             ;No, use CURLOC
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
; This entry point is used by the routine at CPM_CLOSE_FILE.
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
  JP Z,ISCRDS             ;ALL DONE UPDATING POSITION
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
  JP Z,RNDVR1             ;Version 1.x
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
  JP RNDDON              ;Finished setting record number

RNDVR1:
  LD HL,$000D            ;POINT TO EXTENT
  ADD HL,BC              ;ADD START OF FILE CONTROL BLOCK
  LD A,E                 ;GET LOW BYTE OF OFFSET
  RLA                    ;GET HIGH BIT IN CARRY
  LD A,D                 ;GET HIGH BYTE
  RLA                    ;ROTATE IN HIGH BYTE OF LOW PART
  LD D,(HL)              ;PUT ORIGINAL EXTENT IN [D]
  CP D                   ;ARE NEW AND OLD EXTENT THE SAME?
  JP Z,SAMEXT            ;SAME EXTENT, DONT RE-OPEN
  PUSH DE                ;SAVE RECORD NUMBER
  PUSH AF                ;SAVE NEW EXTENT
  PUSH HL                ;SAVE POINTER TO EXTENT
  PUSH BC                ;SAVE FILE POINTER
  LD DE,$0080            ;READ DIRECTORY IN HERE FOR OPEN
  LD C,$1A               ;SET CPM BUFFER ADDRESS ; BDOS function 26 - Set DMA address
  CALL $0005             ;CALL CP/M
  POP DE                 ;GET CPM FCB POINTER
  PUSH DE                ;SAVE BACK
  INC DE                 ;POINT TO FCB
  LD C,$10               ;CLOSE PREVIOUS EXTENT (?!) (BDOS function 16 - Close file)
  CALL $0005             ;CALL CP/M
  POP DE                 ;GET BACK FCB POINTER
  POP HL                 ;RESTORE POINTER TO EXTENT FIELD
  POP AF                 ;GET BACK NEW EXTENT
  LD (HL),A              ;STORE NEW EXTENT
  PUSH DE
  INC DE                 ;POINT TO FCB
  LD C,$0F               ;OPEN NEW EXTENT (BDOS function 15 - Open file)
  PUSH DE                ;SAVE EXTENT POINTER
  CALL $0005             ;BY CALLING CP/M
  POP DE                 ;RESTORE FCB POINTER
  INC A                  ;DOES EXTENT EXIST?
  JP NZ,RNDOK            ;YES
  LD C,$16               ;MAKE THE EXTENT EXIST (BDOS function 22 - create file)
  CALL $0005             ;CALL CP/M
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
  JP NZ,PUTFIN           ;DO THE PUTTING
  CALL READIN            ;PERFORM THE GET
  POP HL                 ;GET THE TEXT POINTER
  RET

PUTFIN:
  LD HL,$0021            ; 0+FCB.NR+1: LOOK AT RECORD #
  ADD HL,BC              ;[H,L] POINTS TO IT
  LD A,(HL)              ;GET IT
  CP $7F                 ;LAST RECORD IN EXTENT?
  PUSH AF                ;SAVE INDICATOR
  LD DE,$0080            ;DIRTMP: SAVE HERE
  LD HL,$0029            ;0+DATOFS: POINT TO DATA
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
  LD B,$80               ;DATPSC: # OF BYTES TO MOVE
BUFSLP:                  
  LD A,(HL)              ;GET BYTE FROM BUFFER
  INC HL                 ;BUMP POINTER
  LD (DE),A              ;SAVE IN DIRTMP
  INC DE                 ;BUMP POINTER
  DEC B                  
  JP NZ,BUFSLP           ;KEEP MOVING BYTES
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
  JP Z,FILLSQ          
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
  JP Z,INDSKB_2          ;YES
  CALL READ2             ;READ A RECORD
  ; OR A              <-  USED TO BE - WAS IT EOF?
  JP NZ,INDSKB_0         ;RETURN WITH A CHAR (GET A CHAR BY INDSKB)
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
  LD C,$80               ; DATPSC: NUMBER OF BYTES/BUFFER
  
ZRRND:
  INC HL                 ;INCREMENT BUFFER POINTER
  LD (HL),$00            ;ZERO IT
  DEC C                  ;DECREMENT COUNT
  JP NZ,ZRRND            ;KEEP ZEROING


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

  CALL SETDMA            ; SET CPM BUFFER ADDRESS


IF CPMV1
  LD A,(CPMREA)          ;Get read code
ELSE
  LD A,$21               ;BDOS function for 'Read record'
ENDIF

  CALL ACCFIL           ;Access file
  OR A                  ;EOF?
  LD A,$00              ;Return 0 if EOF
  JP NZ,READI2          ;Assume EOF if error
  LD A,$80              ;DATPSC: OTHERWISE, HAVE 128 BYTES
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
; Used by the routines at __EOF, CPM_CLOSE_FILE, INDSKB and __OPEN.
SETDMA:
  PUSH BC
  PUSH DE
  PUSH HL
  LD HL,$0028           ;0+DATOFS-1: POINT TO BUFFER
  ADD HL,DE             ;ADD
  EX DE,HL              ;PUT BUFFER ADDRESS IN [D,E]
  LD C,$1A              ;SET UP BUFFER ADDRESS (BDOS function 26 - Set DMA address)
  CALL $0005            ;CALL CPM
  POP HL
  POP DE
  POP BC
  RET

; Read byte, C flag is set if EOF
;
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
; NAMFIL -- SCAN A FILE NAME AND NAME COMMAND
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
  JP C,NODEV             ;NO, NAME TOO SHORT
  LD C,(HL)              ;[C]=POSSIBLE DEVICE NAME ('drive letter' in file specifier)
  INC HL                 ;POINT TO NEXT CHAR
  LD A,(HL)              ;GET IT
  DEC E                  ;DECREMENT COUNT FOR DEVICE NAME
  CP ':'                 ;COLON FOR DEVICE NAME?
  JP Z,FNAME_1           ;YES, SO NOW GET FILE NAME
  DEC HL                 ;BACK UP POINTER BY ONE
  INC E                  ;COMPENSATE FOR DCR
NODEV:
  DEC HL                 ;BACK UP POINTER
  INC E                  ;INCREMENT CHAR COUNT TO COMPENSATE FOR NEXT DECR
  LD C,'A'-1             ;USE CURRENTLY SELECTED DRIVE (Force to drive number '0' {default}
                         ;                                if no drv letter in the filename)
FNAME_1:
  DEC E                  ;DECRMENT CHAR COUNT
  JP Z,NMERR             ;ERROR IF NO FILENAME
  LD A,C                 ; Get drive letter as written in file specifier
  AND $DF                ; Convert..
  SUB 'A'-1              ; ..to drive number (LOGICAL NUMBER).
  JP C,NMERR             ;NOT IN RANGE
  CP $1B                 ;BIGGER THAN 27
  JP NC,NMERR            ;NOT ALLOWED
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
  JP NZ,FILLOP_NOEXT     ;NO
  CALL FILLNM            ;YES, FILL NAME WITH BLANKS
  POP AF                 ;RESTORE CC'S
  SCF                    ;FLAG "." SEEN
  PUSH AF                ;SAVE CC'S BACK
  JP FILINX              ;YES, IGNORE "."

FILLOP_NOEXT:
  LD (BC),A              ;COPY CHAR
  INC BC
  INC HL
  DEC D                  ;DECRMENT POSSIBLE COUNT OF CHARS
  JP NZ,FILLOP

GOTNAM:
  LD HL,FCB_EXTENT       ;CLEAR EXTENT FIELD
  LD B,$15
GOTNAM_0:
  LD (HL),$00
  INC HL
  DEC B
  JP NZ,GOTNAM_0
  POP AF
  POP HL
  RET
  
FILLNM:
  LD A,D                 ;GET # OF CHARS
  CP 11                  ;INITIAL POSITION?  (11+8*0-2*0)
  JP Z,NMERR             ;DONT ALLOW NULL FILENAME
  CP 3                   ;FILLED FIELD?
  JP C,NMERR             ;NO, BUT 2ND "."
  RET Z                  ;YES, BACK TO LOOP
  LD A,' '               ;FILL WITH SPACE
  LD (BC),A
  INC BC
  DEC D
  JP FILLNM

FILSPC:
  INC D                  ;CHARS LEFT IN FILE BUFFER
  DEC D                  ;TEST
  JP Z,GOTNAM            ;NO
FILSP2:
  LD A,' '               ;SPACE
  LD (BC),A              ;STORE
  INC BC                
  DEC D                  ;FILLED WHOLE FIELD?
  JP NZ,FILSP2           ;NO, MORE SPACES
  JP GOTNAM              ;YES, MAKE SURE NAME OK
  
NMERR:
  JP NM_ERR

; 'NAME' BASIC command  (file rename)
__NAME:
  CALL FNAME             ;PICK UP THE OLD NAME TO USE
  PUSH HL                ;SAVE THE TEXT POINTER
  LD DE,$0080            ;READ DIRECTORY IN HERE
  LD C,$1A               ;SET BUFFER ADDRESS  (BDOS function 26 - Set DMA address)
  CALL $0005             ;CALL CP/M
  LD DE,FILNAM           ;SEE IF ORIGINAL NAME EXISTS
  LD C,$0F               ;BY OPENING (BDOS function 15 - Open file)
  CALL $0005             ;CALL CP/M
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
  DEC B
  JP NZ,NAMRMV
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
  CALL $0005             ;CALL CP/M
  INC A                  ;DOES IT EXIST?
  JP NZ,FILE_EXISTS_ERR  ;YES
  LD C,$17               ;RENAME OPERATION (BDOS function 23 - Rename file)
  LD DE,FILNA2           ;POINT AT OLD NAME FCB
  CALL $0005             ;CALL CP/M
IF ORIGINAL
;	INC	A		;FILE FOUND?
;****DONT CHECK ERROR RETURN, CP/M HAS PROBLEMS****
;	JP Z,FF_ERR		;NO
ELSE
  INC	A		;FILE FOUND?   (A=0-3 if successful; A=0FFh if error)
  JP Z,FF_ERR		;NO
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
  JP Z,HAVMOD            ;[D] HAS CORRECT MODE
  LD D,$01               ;ASSUME SEQUENTIAL (1=MD.SQI)
  CP 'I'                 ;IS IT?
  JP Z,HAVMOD            ;[D] SAYS SEQUENTIAL INPUT
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
  JP C,PRGDOT               ;IF "." SEEN, DONT DEFAULT EXTENSION
  LD A,E                    ;GET FILE NUMBER
  OR A                      ;SET CONDITION CODES
  JP NZ,PRGDOT              ;NOT FILE 0, DONT DEFAULT FILE NAME
  LD HL,FCB_FTYP            ; (FILNAM+9-0-0-2*0): POINT TO FIRST CHAR OF EXTENSION
  LD A,(HL)                 ;GET IT
  CP ' '                    ;BLANK EXTENSION
  JP NZ,PRGDOT              ;NON-BLANK EXTENSION, DONT USE DEFAULT
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
  JP NZ,OPNLP               ;KEEP LOOPING

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
  CALL SETDMA               ;SET BUFFER ADDRESS
  POP HL                    ;GET BACK FILE DATA BLOCK PTR
  POP AF                    ;GET MODE
  PUSH AF
  PUSH HL                   ;SAVE BACK
  ;MOV	A,(HL)			;GET MODE   (found in other versions)
  CP $02                    ; (MD.SQO) SEQENTIAL OUTPUT?
  JP NZ,OPNFIL              ;NO, DO CPM OPEN CALL
  PUSH DE                   ;SAVE FCB POINTER
  LD C,$13                  ;DELETE EXISTING OUTPUT FILE, IF ANY  (BDOS function 19 - delete file)
  CALL $0005                ;CALL CP/M
  POP DE                    ;RESTORE FCB POINTER
MAKFIL:
  LD C,$16                  ; BDOS function 22 - create file
  CALL $0005                ;CALL CPM
  INC A                     ;TEST FOR TOO MANY FILES
  JP Z,FL_ERR               ;THAT WAS THE CASE
  JP OPNSET                 ;FINISH SETUP OF FILE DATA BLOCK
OPNFIL:
  LD C,$0F                  ;CPM CODE FOR OPEN (BDOS function 15 - Open file)
  CALL $0005                ;CALL CPM
  INC A                     ;FILE NOT FOUND
  JP NZ,OPNSET              ;FOUND
  POP DE                    ;GET BACK FILE POINTER
  POP AF                    ;GET MODE OF FILE  (LD A,(DE) somewhere else)
  PUSH AF                   
  PUSH DE                   ;SAVE BACK FILE POINTER
  CP $03                    ;RANDOM?
  JP NZ,FF_ERR              ;NO, SEQENTIAL INPUT, FILE NOT FOUND
  INC DE                    ;MAKE [D,E]=FCB POINTER
  JP MAKFIL                 ;MAKE FILE

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
  JP Z,RNDFIN               ;YES RANDOM FINISH UP
  CP $01                    ;IF SEQUENTIAL ALL THAT IS LEFT TO DO
  JP NZ,GTMPRT              ;FETCH TEXT POINTER AND DONE
;
; FINISH UP SEQUENTIAL INPUT AFTER FINDING FILE
;
  CALL READ2                ;READ FIRST DATA BLOCK
  LD HL,(TEMP)              ;GET BACK THE TEXT POINTER
  RET


RNDFIN:
  LD BC,$0029               ;(0+DATOFS) NOW ADVANCE POINTER TO DATA
  ADD HL,BC                 ;BY ADDING PROPER OFFSET
  LD C,$80                  ;# OF BYTES TO ZERO
ZRRNDT:
  LD (HL),B
  INC HL
  DEC C
  JP NZ,ZRRNDT
  JP GTMPRT                 ;Restore code string address


; 'SYSTEM' BASIC command
; SYSTEM (EXIT) COMMAND - RETURN TO CPM (OR EXIT TO OS)
__SYSTEM:
  RET NZ                    ;SHOULD TERMINATE
  CALL CLSALL               ;CLOSE ALL DATA FILES
; This entry point is used by the routine at _ERROR_REPORT.
EXIT_TO_SYSTEM:
  JP $0000                  ;WARM START CP/M



IF VT52

__CLS:
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
  PUSH AF
  LD A,27
  CALL OUTDO  		; Output char to the current device
  POP AF			; ESC_y (show/hide cursor)
  CALL OUTDO  		; Output char to the current device
__LOCATE_3:
  EX (SP),HL

  LD A,27
  CALL OUTDO  		; Output char to the current device
  LD A,'Y'			; ESC_Y, set cursor coordinates
  CALL OUTDO  		; Output char to the current device
  LD A,L
  LD (TTYPOS),A
  ADD A,31
  CALL OUTDO  		; Output char to the current device
  LD A,H
  ADD A,31
  CALL OUTDO  		; Output char to the current device
  POP HL
  RET

ENDIF




; 'RESET' BASIC command
__RESET:
  RET NZ                  ;SHOULD TERMINATE
  PUSH HL                 ;SAVE TEXT POINTER
  CALL CLSALL             ;CLOSE ALL FILES
  LD C,$19                ;GET DRIVE CURRENTLY SELECTED (BDOS function 25 - Get current drive)
  CALL $0005              ;GET IT IN [A]
  PUSH AF                 ;SAVE CURRENT DRIVE #
  LD C,$0D                ;DO THE RESET CALL (BDOS function 13 - Reset discs)
  CALL $0005
  POP AF                  ;GET DRIVE TO SELECT
  LD E,A                  ;INTO [E]
  LD C,$0E                ;SET DRIVE, BDOS function 14 - Select disc (set current drive)
  CALL $0005              ;CALL CPM
  POP HL                  ;RESTORE TEXT POINTER
  RET

; 'KILL' BASIC command (erase file)
__KILL:
  CALL FNAME             ;SCAN FILE NAME
  PUSH HL                ;SAVE TEXT POINTER
  LD DE,$0080            ;(DIRTMP) READ DIRECTORY IN HERE
  LD C,$1A               ;SET BUFFER ADDRESS (BDOS function 26 - Set DMA address)
  CALL $0005             ;FOR CP/M
  LD DE,FILNAM           ;TRY TO OPEN FILE
  PUSH DE                ;SAVE FCB POINTER
  LD C,$0F               ; BDOS function 15 - Open file
  CALL $0005
  INC A                  ;FILE FOUND?
  POP DE                 ;GET BACK POINTER TO FCB
  PUSH DE                ;SAVE BACK
  PUSH AF                ;SAVE FOUND FLAG
  LD C,$10               ;THIS MAY NOT BE NESC. (BDOS function 16 - Close file)
  JP Z,__KILL_0
  CALL $0005             ;CLOSE FILE
__KILL_0:
  POP AF                 ;RESTORE FOUND INDICATOR
  POP DE                 ;RESTORE FCB POINTER
  JP Z,FF_ERR            ;YES
  LD C,$13               ; BDOS function 19 - delete file
  CALL $0005             ;CALL CPM
  POP HL                 ;GET BACK TEXT POINTER
  RET

; 'FILES' BASIC command
__FILES:
  JP NZ,__FILES_0        ;FILE NAME WAS SPECIFIED
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
  LD DE,$0080            ;SET BUFFER TO 80 HEX
  LD C,$1A               ;(C.BUFF) BDOS function 26 - Set DMA address
  CALL $0005
  LD DE,FILNAM           ;POINT TO FCB
  LD C,$11               ;DO INITIAL SEARCH FOR FILE - BDOS function 17 - search for first
  CALL $0005
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
  LD HL,$0081            ;POINT TO DIRECTORY BUFFER
  ADD HL,BC              ;POINT TO FCB ENTRY IN DIRECTORY
  LD C,$0B               ; (11+5*0+11*0 ??) CHARS IN NAME
__FILES_2:
  LD A,(HL)              ;GET FILE NAME CHAR
  INC HL                 ;BUMP POINTER
  AND $7F                ;Force it to 7 bit ASCII  (does not exist on previous versions)
  CALL OUTDO             ;PRINT IT
  LD A,C                 ;GET  CHAR POSIT
  CP $04                 ; (4+5*0) ABOUT TO PRINT EXTENSION?
  JP NZ,NOTEXT           ;NO
  LD A,(HL)              ;GET FIRST CHAR OF EXTENSION
  CP ' '                 ;IF SO, NOT SPACE
  JP Z,PRISPA            ;PRINT SPACE
  LD A,'.'               ;PRINT DOT
PRISPA:
  CALL OUTDO
NOTEXT:
  DEC C                  ;DECREMENT CHAR COUNT
  JP NZ,__FILES_2        ;MORE OF NAME TO PRINT
  LD A,(TTYPOS)          ;GET CURRENT TTY POSIT
  ADD A,$0D              ;SPACE FOR NEXT NAME?
  LD D,A                 ;SAVE IN D
  LD A,(LINLEN)          ;GET LENGTH OF TERMINAL LINE
  CP D                   ;COMPRE TO CURRENT POSIT
  JP C,NWFILN            ;NEED TO FORCE CRLF
  LD A,' '               ;TWO SPACES BETWEEN FILE NAMES
  CALL OUTDO
  CALL OUTDO
                         ;OR THREE
NWFILN:
  CALL C,OUTDO_CRLF       ;TYPE CRLF
  LD DE,FILNAM            ;POINT AT FCB
  LD C,$12                ;SEARCH FOR NEXT ENTRY (BDOS function 18 - search for next)
  CALL $0005              ;SEARCH FOR NEXT INCARNATION
  CP $FF                  ;NO MORE?
  JP NZ,FILNXT            ;MORE.
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
  JP NZ,FILENAME_FILL     ;KEEP SAVING QMARKS
  RET

; Enter BDOS for file read or write operations
;
; Used by the routines at __EOF and INDSKB.
; Called after picking the current function from CPMREA / CPMWRT
ACCFIL:
  PUSH DE                 ; Save FCB address
  LD C,A
  PUSH BC
  CALL $0005
  POP BC
  POP DE
  PUSH AF
  LD HL,$0021             ; (0+FCB.RN) Point to random record number
  ADD HL,DE               ; Now HL points to the random access record number
  INC (HL)                ; Increment record number LSB (R0)
  JP NZ,ACCFL1
  INC HL                  ; Increment record number R1
  INC (HL)                ; Increment record number R2
  JP NZ,ACCFL1            ; NO
  INC HL
  INC (HL)
ACCFL1:
  LD A,C                  ;Get back CPM call code
  CP $22                  ; was it a 'random write' BDOS call ?
  JP NZ,ACCFL2
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

; Get stream number (default #channel=1
;
; Used by the routines at SET_INPUT_CHANNEL and LINE_INPUT.
GET_CHANNEL:
  LD C,$01

; Get stream number (C=default #channel)
; Look for '#' channel specifier and put the associated file buffer in BC
;
; Used by the routines at __PRINT and L46AB.
GET_CHNUM:
  CP '#'
  RET NZ
  PUSH BC
  CALL GET_CHNUM_2    ; Check the '#' channel specifier and put the associated file buffer in BC
  POP DE
  CP E
  JP Z,GET_CHNUM_0
  CP $03
  JP NZ,FMODE_ERR
GET_CHNUM_0:
  CALL SYNCHR
  DEFM ","
; This entry point is used by the routine at FN_INPUT.
GET_CHNUM_1:
  LD D,B
  LD E,C
  EX DE,HL
  LD (PTRFIL),HL
  EX DE,HL
  RET

; This entry point is used by the routines at __FIELD, FN_INPUT and __GET.
GET_CHNUM_2:
  DEC HL
  CALL CHRGTB
  CP '#'
  CALL Z,CHRGTB
  CALL EVAL

;
; CONVERT ARGUMENT TO FILE NUMBER AND SET [B,C] TO POINT TO FILE DATA BLOCK
;
; This entry point is used by the routines at __EOF, __LOC and __LOF.
FILFRM:
  CALL MAKINT
; This entry point is used by the routines at CPM_CLOSE_FILE and __OPEN.
FILIDX:
  LD E,A
GET_CHNUM_5:
  LD A,(MAXFIL)			; HIGHEST FILE NUMBER ALLOWED
  CP E
  JP C,BN_ERR
  LD D,$00
  PUSH HL
  LD HL,FILPTR
  ADD HL,DE
  ADD HL,DE
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD A,(BC)
  OR A
  POP HL
  RET

; This entry point is used by the routine at __ERL.
GETPTR:
  CALL GET_CHNUM_5
  LD HL,$0029
  CP $03
  JP NZ,GET_CHNUM_6
  LD HL,$00B2
GET_CHNUM_6:
  ADD HL,BC
  EX DE,HL
  RET

; label='MKI$' BASIC function
__MKI_S:
  LD A,$02
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'MKS$' BASIC function
__MKS_S:
  LD A,$04
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'MKD$' BASIC function
__MKD_S:
  LD A,$08
  PUSH AF
  CALL CHKTYP
  POP AF
  CALL MKTMST
  LD HL,(TMPSTR)
  CALL FP_DE2HL
  JP TOPOOL

; 'CVI' BASIC function
__CVI:
  LD A,$01
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; Routine at 16207
__CVS:
  LD A,$03

; 'CVS' BASIC function
L3F51:
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'CVD' BASIC function
__CVD:
  LD A,$07
  PUSH AF
  CALL GETSTR
  POP AF
  CP (HL)
  JP NC,FC_ERR
  INC A
  LD (VALTYP),A
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP FP_HL2DE

; c16233
;
; Used by the routine at __READ.
__READ_INPUT:
  CALL GETYPR
  LD BC,__READ_DONE
  LD DE,$2C20             ; D=','  E=' '
  JP NZ,LINE_INPUT_0
  LD E,D
  JP LINE_INPUT_0

; Line input
;
; Used by the routine at __LINE.
LINE_INPUT:
  CALL GET_CHANNEL
  CALL GETVAR
  CALL TSTSTR
  LD BC,FINPRT
  PUSH BC
  PUSH DE
  LD BC,LETCON
  XOR A
  LD D,A
  LD E,A
; This entry point is used by the routine at __READ_INPUT.
LINE_INPUT_0:
  PUSH AF
  PUSH BC
  PUSH HL
LINE_INPUT_1:
  CALL RDBYT
  JP C,EF_ERR
  CP ' '
  JP NZ,LINE_INPUT_2
  INC D
  DEC D
  JP NZ,LINE_INPUT_1
LINE_INPUT_2:
  CP '"'
  JP NZ,LINE_INPUT_3
  LD A,E
  CP ','
  LD A,'"'
  JP NZ,LINE_INPUT_3
  LD D,A
  LD E,A
  CALL RDBYT
  JP C,LINE_INPUT_7
LINE_INPUT_3:
  LD HL,BUF
  LD B,$FF
LINE_INPUT_4:
  LD C,A
  LD A,D
  CP '"'
  LD A,C
  JP Z,LINE_INPUT_5
  CP $0D
  PUSH HL
  JP Z,LINE_INPUT_9
  POP HL
  CP $0A
  JP NZ,LINE_INPUT_5
  LD C,A
  LD A,E
  CP $36
  LD A,C
  CALL NZ,LINE_INPUT_13
  CALL RDBYT
  JP C,LINE_INPUT_7
  CP $0D
  JP NZ,LINE_INPUT_5
  LD A,E
  CP ' '
  JP Z,LINE_INPUT_6
  CP ','
  LD A,$0D
  JP Z,LINE_INPUT_6
LINE_INPUT_5:
  OR A
  JP Z,LINE_INPUT_6
  CP D
  JP Z,LINE_INPUT_7
  CP E
  JP Z,LINE_INPUT_7
  CALL LINE_INPUT_13
LINE_INPUT_6:
  CALL RDBYT
  JP NC,LINE_INPUT_4
LINE_INPUT_7:
  PUSH HL
  CP '"'
  JP Z,LINE_INPUT_8
  CP ' '
  JP NZ,NOSKCR
LINE_INPUT_8:
  CALL RDBYT
  JP C,NOSKCR
  CP ' '
  JP Z,LINE_INPUT_8
  CP ','
  JP Z,NOSKCR
  CP $0D
  JP NZ,LINE_INPUT_10
LINE_INPUT_9:
  CALL RDBYT
  JP C,NOSKCR
  CP $0A
  JP Z,NOSKCR
LINE_INPUT_10:
  LD HL,(PTRFIL)
  LD BC,$0028
  ADD HL,BC
  INC (HL)
NOSKCR:
  POP HL
LINE_INPUT_11:
  LD (HL),$00
  LD HL,BUFMIN
  LD A,E
  SUB $20
  JP Z,LINE_INPUT_12
  LD B,D
  LD D,$00
  CALL DTSTR
  POP HL
  RET

LINE_INPUT_12:
  CALL GETYPR
  PUSH AF
  CALL CHRGTB
  POP AF
  PUSH AF
  CALL C,DBL_ASCTFP_0
  POP AF
  CALL NC,DBL_ASCTFP
  POP HL
  RET

LINE_INPUT_13:
  OR A
  RET Z
  LD (HL),A
  INC HL
  DEC B
  RET NZ
  POP BC
  JP LINE_INPUT_11

; This entry point is used by the routines at __LOAD, __MERGE and __CHAIN.
FILE_OPENIN:
  LD D,$01
; This entry point is used by the routine at __MERGE.
FILE_OPENOUT:
  XOR A
  JP PRGFIL

; label=_RUN_FILE
;
; Used by the routines at ATOH and _READY.
_RUN_FILE:
  DEFB $F6                ; 'OR $AF'  masking the next instruction

; 'LOAD' BASIC command
__LOAD:
  XOR A
  PUSH AF
  CALL FILE_OPENIN
  LD A,(MAXFIL)			; HIGHEST FILE NUMBER ALLOWED
  LD (MAXFILSV),A
  DEC HL
  CALL CHRGTB
  JP Z,LOAD1
  CALL SYNCHR
  DEFM ","
  CALL SYNCHR
  DEFM "R"
  JP NZ,SN_ERR
  POP AF
; This entry point is used by the routine at L46AB.
_LOAD:
  XOR A
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  DEFB $F6                ; "OR n" to Mask 'POP AF'
LOAD1:
  POP AF
  LD (AUTORUN),A
  LD HL,$0080
  LD (HL),$00
  LD (FILPTR),HL
  CALL CLRPTR
  LD A,(MAXFILSV)
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  LD HL,(FILPT1)
  LD (FILPTR),HL
  LD (PTRFIL),HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  AND L
  INC A
  JP NZ,__LOAD_0
  LD (CURLIN),HL
__LOAD_0:
  CALL RDBYT
  JP C,PROMPT
  CP $FE
  JP NZ,__LOAD_1
  LD (PROFLG),A
  JP __LOAD_2

__LOAD_1:
  INC A
  JP NZ,__MERGE_1
__LOAD_2:
  LD HL,(TXTTAB)
__LOAD_3:
  EX DE,HL
  LD HL,(FRETOP)
  LD BC,$FFAA
  ADD HL,BC
  CALL DCOMPR
  EX DE,HL
  JP C,LOAD_OM_ERR
  CALL INDSKB               ; GET A CHARACTER FROM A SEQUENTIAL FILE IN [PTRFIL]
  LD (HL),A
  INC HL
  JP NC,__LOAD_3
  LD (VARTAB),HL
  LD A,(PROFLG)
  OR A
  CALL NZ,__GET_33
  CALL LINKER
  INC HL
  INC HL
  LD (VARTAB),HL
  LD HL,MAXFIL			; HIGHEST FILE NUMBER ALLOWED
  LD A,(HL)
  LD (MAXFILSV),A
  LD (HL),$00
  CALL RUN_FST
  LD A,(MAXFILSV)
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  LD A,(CHNFLG)
  OR A
  JP NZ,L46AB_3
  LD A,(AUTORUN)
  OR A
  JP Z,READY
  JP NEWSTT

; This entry point is used by the routines at READY, __MERGE and L4D05.
LOAD_END:
  CALL FINPRT
  CALL CPM_CLOSE_FILE
  JP GTMPRT            ;Restore code string address

; Routine at 16680
;
; Used by the routine at __LOAD.
LOAD_OM_ERR:
  CALL CLRPTR
  JP OM_ERR

; 'MERGE' BASIC command
__MERGE:
  POP BC
  CALL FILE_OPENIN
  DEC HL
  CALL CHRGTB
  JP Z,__MERGE_0
  CALL LOAD_END
  JP SN_ERR

; This entry point is used by the routine at L46AB.
__MERGE_0:
  XOR A
  LD (AUTORUN),A
  CALL RDBYT
  JP C,PROMPT
  INC A
  JP Z,FMODE_ERR
  INC A
  JP Z,FMODE_ERR
; This entry point is used by the routine at __LOAD.
__MERGE_1:
  LD HL,(PTRFIL)
  LD BC,$0028
  ADD HL,BC
  INC (HL)
  JP PROMPT

; This entry point is used by the routine at PROMPT.
DIRDO:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  LD DE,$0042             ; Err $42 - (DS_ERR) "Direct statement in file"
  JP NZ,ERROR
  POP HL
  JP EXEC

__SAVE:
  LD D,$02
  CALL FILE_OPENOUT
  DEC HL
  CALL CHRGTB
  JP Z,__MERGE_3
  CALL SYNCHR
  DEFM ","
  CP $50
  JP Z,__GET_29
  CALL SYNCHR
  DEFM "A"
  JP __LIST

__MERGE_3:
  CALL SCCPTR
  CALL PROCHK
  LD A,$FF
; This entry point is used by the routine at __GET.
__MERGE_4:
  CALL FILOU3
  EX DE,HL
  LD HL,(VARTAB)
  EX DE,HL
  LD HL,(TXTTAB)
__MERGE_5:
  CALL DCOMPR
  JP Z,LOAD_END
  LD A,(HL)
  INC HL
  PUSH DE
  CALL FILOU3
  POP DE
  JP __MERGE_5

; 'CLOSE' BASIC command
;
; Used by the routine at CLOSE_FILE.
;
; CLOSE[[#]<file number>[,[#]<file number ••• >]]
;
__CLOSE:
  LD BC,CPM_CLOSE_FILE
  LD A,(MAXFIL)			; HIGHEST FILE NUMBER ALLOWED
  JP NZ,CLOSE_FILE_0
  PUSH HL
; This entry point is used by the routine at __CLOSE_1.
__CLOSE_0:
  PUSH BC
  PUSH AF
  LD DE,__CLOSE_1
  PUSH DE
  PUSH BC
  RET

; Routine at 16829
__CLOSE_1:
  POP AF
  POP BC
  DEC A
  JP P,__CLOSE_0
  POP HL
  RET

; Routine at 16837
CLOSE_FILE:
  POP BC
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  CALL CHRGTB
; This entry point is used by the routine at __CLOSE.
CLOSE_FILE_0:
  PUSH BC
  LD A,(HL)
  CP '#'
  CALL Z,CHRGTB
  CALL GETINT             ; Get integer 0-255
  EX (SP),HL
  PUSH HL
  LD DE,CLOSE_FILE
  PUSH DE
  JP (HL)


; This entry point is used by the routines at __SYSTEM, __RESET, NODSKS, __NEW
; and __END.
CLSALL:
  PUSH DE
  PUSH BC
  XOR A
  CALL __CLOSE
  POP BC
  POP DE
  XOR A
  RET

; 'FIELD' BASIC command: allocate space in the random buffer for the variables
; that will be written to the random file
__FIELD:
  CALL GET_CHNUM_2		; Check we have the '#' channel specifier and put the associated file buffer in BC
  JP Z,BN_ERR
  SUB $03
  JP NZ,FMODE_ERR
  EX DE,HL
  LD HL,$00A9		; 169
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (INTFLG),HL
  LD HL,$0000
  LD (FIELD_PTR1),HL
  LD A,H
  EX DE,HL
  LD DE,$00B2
__FIELD_NEXT:
  EX DE,HL
  ADD HL,BC
  LD B,A
  EX DE,HL
  LD A,(HL)
  CP ','
  RET NZ
  PUSH DE
  PUSH BC
  CALL FNDNUM		; Numeric argument (0..255)
  PUSH AF
  CALL SYNCHR
  DEFM "A"
  CALL SYNCHR
  DEFM "S"
  CALL GETVAR
  CALL TSTSTR
  POP AF
  POP BC
  EX (SP),HL
  LD C,A
  PUSH DE
  PUSH HL
  LD HL,(FIELD_PTR1)
  LD B,$00
  ADD HL,BC
  LD (FIELD_PTR1),HL
  EX DE,HL
  LD HL,(INTFLG)
  CALL DCOMPR
  JP C,FIELD_OV_ERR
  POP HL
  POP DE
  EX DE,HL
  LD (HL),C
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  JP __FIELD_NEXT

; 'RSET' BASIC command
__RSET:
  DEFB $F6                ; "OR n" to Mask 'SCF'

; 'LSET' BASIC function
__LSET:
  SCF
  PUSH AF
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  CALL NEXT_EQUAL
  POP BC
  EX (SP),HL
  PUSH HL
  PUSH BC
  CALL GETSTR
  LD B,(HL)
  EX (SP),HL
  LD A,(HL)
  LD C,A
  PUSH BC
  PUSH HL
  PUSH AF
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  OR A
  JP Z,__LSET_4
  LD HL,(TXTTAB)
  CALL DCOMPR
  JP NC,__LSET_1
  LD HL,(VARTAB)
  CALL DCOMPR
  JP C,__LSET_1
  LD E,C
  LD D,$00
  LD HL,(STREND)
  ADD HL,DE
  EX DE,HL
  LD HL,(FRETOP)
  CALL DCOMPR
  JP C,__LSET_8
  POP AF
__LSET_0:
  LD A,C
  CALL TESTR
  POP HL
  POP BC
  EX (SP),HL
  PUSH DE
  PUSH BC
  CALL GETSTR
  POP BC
  POP DE
  EX (SP),HL
  PUSH BC
  PUSH HL
  INC HL
  PUSH AF
  LD (HL),E
  INC HL
  LD (HL),D
__LSET_1:
  POP AF
  POP HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP BC
  POP HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD A,C
  CP B
  JP NC,__LSET_2
  LD B,A
__LSET_2:
  SUB B
  LD C,A
  POP AF
  CALL NC,__LSET_6
  INC B
__LSET_3:
  DEC B
  JP Z,__LSET_5
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  JP __LSET_3

__LSET_4:
  POP BC
  POP BC
  POP BC
  POP BC
  POP BC
__LSET_5:
  CALL C,__LSET_6
  POP HL
  RET

__LSET_6:
  LD A,' '
  INC C
__LSET_7:
  DEC C
  RET Z
  LD (DE),A
  INC DE
  JP __LSET_7

__LSET_8:
  POP AF
  POP HL
  POP BC
  EX (SP),HL
  EX DE,HL
  JP NZ,__LSET_9
  PUSH BC
  LD A,B
  CALL MKTMST
  CALL TSTOPL
  POP BC
__LSET_9:
  EX (SP),HL
  PUSH BC
  PUSH HL
  JP __LSET_0

; Routine at 17145
;
; Used by the routine at OPRND_MORE.
FN_INPUT:
  CALL CHRGTB
  CALL SYNCHR
  DEFM "$"
  CALL SYNCHR
  DEFM "("
  PUSH HL
  LD HL,(PTRFIL)
  LD DE,$0000
  EX DE,HL
  LD (PTRFIL),HL
  EX DE,HL
  EX (SP),HL
  CALL GETINT             ; Get integer 0-255
  PUSH DE
  LD A,(HL)
  CP ','
  JP NZ,FN_INPUT_0
  CALL CHRGTB
  CALL GET_CHNUM_2		; Check we have the '#' channel specifier and put the associated file buffer in BC
  CP $02
  JP Z,FMODE_ERR
  CALL GET_CHNUM_1
  XOR A
FN_INPUT_0:
  PUSH AF
  CALL SYNCHR
  DEFM ")"
  POP AF
  EX (SP),HL
  PUSH AF
  LD A,L
  OR A
  JP Z,FC_ERR
  PUSH HL
  CALL MKTMST
  EX DE,HL
  POP BC
FN_INPUT_1:
  POP AF
  PUSH AF
  JP Z,FN_INPUT_5
  CALL L4DC7_2
  JP NZ,FN_INPUT_2
  CALL GETINP
FN_INPUT_2:
  CP $03
  JP Z,FN_INPUT_4
FN_INPUT_3:
  LD (HL),A
  INC HL
  DEC C
  JP NZ,FN_INPUT_1
  POP AF
  POP BC
  POP HL
  LD (PTRFIL),HL
  PUSH BC
  JP TSTOPL
FN_INPUT_4:
  LD HL,(SAVSTK)
  LD SP,HL
  JP ENDCON

FN_INPUT_5:
  CALL RDBYT
  JP C,EF_ERR
  JP FN_INPUT_3

; 'WHILE' BASIC instruction
__WHILE:
  LD (ENDFOR),HL
  CALL LOOK_FOR_WEND
  CALL CHRGTB
  EX DE,HL
  CALL __WEND_2
  INC SP
  INC SP
  JP NZ,__WHILE_0
  ADD HL,BC
  LD SP,HL
  LD (SAVSTK),HL
__WHILE_0:
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(ENDFOR)
  PUSH HL
  PUSH DE
  JP __WEND_0

; 'WEND' BASIC instruction
__WEND:
  JP NZ,SN_ERR
  EX DE,HL
  CALL __WEND_2
  JP NZ,__WEND_5
  LD SP,HL
  LD (SAVSTK),HL
  EX DE,HL
  LD HL,(CURLIN)
  EX DE,HL
  EX DE,HL
  LD (LOPLIN),HL
  EX DE,HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (CURLIN),HL
  EX DE,HL
; This entry point is used by the routine at __WHILE.
__WEND_0:
  CALL EVAL
  PUSH HL
  CALL _TSTSGN
  POP HL
  JP Z,__WEND_1
  LD BC,TK_WHILE
  LD B,C		; ?
  PUSH BC
  INC SP
  JP NEWSTT
__WEND_1:
  LD HL,(LOPLIN)
  LD (CURLIN),HL
  POP HL
  POP BC
  POP BC
  JP NEWSTT

; This entry point is used by the routine at __WHILE.
__WEND_2:
  LD HL,$0004
  ADD HL,SP
__WEND_3:
  LD A,(HL)
  INC HL
  LD BC,$0082		; TK_FOR
  CP C
  JP NZ,__WEND_4
  LD BC,$0012		; 18
  ADD HL,BC
  JP __WEND_3

__WEND_4:
  LD BC,TK_WHILE
  CP C
  RET NZ
  PUSH HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  CALL DCOMPR
  POP HL
  LD BC,$0006
  RET Z
  ADD HL,BC
  JP __WEND_3
  
__WEND_5:
  LD DE,$001E		; Err $1E - "WEND without WHILE"
  JP ERROR




; 'CALL' BASIC command
; CALL <variable name>[«argument list»]

; Extended and Disk BASIC-80 user function calls may also be made with the CALL statement.
; The calling sequence used is the same as that in Microsoft's FORTRAN, COBOL and BASIC compilers.

__CALL:
  LD A,$80
  LD (SUBFLG),A
  CALL GETVAR
  PUSH HL
  EX DE,HL
  CALL GETYPR
  CALL FP_HL2DE
  CALL GETWORD_HL
  LD (INTFLG),HL
  LD C,32
  CALL CHKSTK             ; Check for C levels on stack
  POP DE
  LD HL,-64
  ADD HL,SP
  LD SP,HL
  EX DE,HL
  LD C,32
  DEC HL
  CALL CHRGTB
  LD (TEMP),HL
  JP Z,CALL_REGS          ; jp if no parameters

  CALL SYNCHR
  DEFM "("
CALL_PARM_LP:
  PUSH BC
  PUSH DE
  CALL GETVAR
  EX (SP),HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX (SP),HL
  POP DE
  POP BC
  LD A,(HL)
  CP ','
  JP NZ,CALL_PARM_END
  DEC C
  CALL CHRGTB
  JP CALL_PARM_LP
CALL_PARM_END:
  CALL SYNCHR
  DEFM ")"

  LD (TEMP),HL
  LD A,33
  SUB C
  POP HL             ; (HL=Parameter 1)
  DEC A              ; If the number of parameters is..
  JP Z,CALL_REGS
  POP DE             ; (DE=Parameter 2)
  DEC A              ; ...less than ..
  JP Z,CALL_REGS
  POP BC             ; (BC=Parameter 3)
  DEC A              ; ...or equal to 3,
  JP Z,CALL_REGS     ; they are passed in the registers.
  PUSH BC
  PUSH HL
  LD HL,$0002        ; If the number of parameters is greater than 3,
  ADD HL,SP          ; parameters 3 through n will be in a contiguous data block
  LD B,H             ; BC will point to the low byte of this data block
  LD C,L
  POP HL

CALL_REGS:
  PUSH HL
  LD HL,__CALL_3
  EX (SP),HL
  PUSH HL
  LD HL,(INTFLG)
  EX (SP),HL
  RET
  
__CALL_3:
  LD HL,(SAVSTK)
  LD SP,HL
  LD HL,(TEMP)
  JP NEWSTT




; 'CHAIN' BASIC command
; To call a program and pass variables to it from the current program.
;
; CHAIN [MERGE] <filename>[,[<line number exp>] [,ALL] [,DELETE<range>]]
;
__CHAIN:
  XOR A
  LD (MRGFLG),A
  LD (CHAIN_DEL),A
  LD A,(HL)
  LD DE,TK_MERGE           ; d=0, e=TK_MERGE
  CP E
  JP NZ,__CHAIN_0
  LD (MRGFLG),A
  INC HL
__CHAIN_0:
  DEC HL
  CALL CHRGTB
  CALL FILE_OPENIN
  PUSH HL
  LD HL,$0000
  LD (CHAIN_LN),HL
  POP HL
  DEC HL
  CALL CHRGTB
  JP Z,__CHAIN_3
  CALL SYNCHR
  DEFM ","
  CP ','
  JP Z,__CHAIN_1
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  LD (CHAIN_LN),HL
  POP HL
  DEC HL
  CALL CHRGTB
  JP Z,__CHAIN_3
__CHAIN_1:
  CALL SYNCHR
  INC L
  LD DE,TK_DELETE          ; d=0, e=TK_DELETE
  CP E
  JP Z,CHAIN_DELETE
  CALL SYNCHR
  DEFM "A"
  CALL SYNCHR
  DEFM "L"
  CALL SYNCHR
  DEFM "L"
  JP Z,CHAIN_ALL
  CALL SYNCHR
  DEFM ","
  CP E
  JP NZ,SN_ERR
  OR A
CHAIN_DELETE:
  PUSH AF
  LD (CHAIN_DEL),A
  CALL CHRGTB
  CALL LNUM_RANGE
  PUSH BC
  CALL DEPTR
  POP BC
  POP DE
  PUSH BC
  LD H,B
  LD L,C
  LD (CHAIN_FROM),HL
  CALL SRCHLN
  JP NC,__CHAIN_2
  LD D,H
  LD E,L
  LD (CHAIN_TO),HL
  POP HL
  CALL DCOMPR
__CHAIN_2:
  JP NC,FC_ERR
  POP AF
  JP NZ,CHAIN_ALL
__CHAIN_3:
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(TXTTAB)
  DEC HL
__CHAIN_4:
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,L45C9_2
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (CURLIN),HL
  EX DE,HL
__CHAIN_5:
  CALL CHRGTB
; This entry point is used by the routine at L45C9.
__CHAIN_6:
  OR A
  JP Z,__CHAIN_4
  CP '9'+1
  JP Z,__CHAIN_5
  LD DE,TK_COMMON          ; d=0, e=TK_COMMON
  CP E
  JP Z,CHAIN_COMMON
  CALL CHRGTB
  CALL __DATA
  DEC HL
  JP __CHAIN_5

  
;	Example
;
;	100 COMMON A,B,C,D(),G$
;	110 CHAIN "PROG3",10 
  
CHAIN_COMMON:
  CALL CHRGTB
  JP Z,__CHAIN_6
; This entry point is used by the routine at L45C9.
__CHAIN_7:
  PUSH HL
  LD A,$01
  LD (SUBFLG),A
  CALL _GETVAR
  JP Z,L45A2_3
  LD A,B
  OR $80
  LD B,A
  XOR A
  CALL ARLDSV
  LD A,$00
  LD (SUBFLG),A
  JP NZ,__CHAIN_8
  LD A,(HL)
  CP '('
  JP NZ,__CHAIN_9
  POP AF
  JP L45C9_0

__CHAIN_8:
  LD A,(HL)
  CP '('
  JP Z,FC_ERR
; This entry point is used by the routine at L45A2.
__CHAIN_9:
  POP HL
  CALL _GETVAR
  LD A,D
  OR E
  JP NZ,L45A2_0
  LD A,B
  OR $80
  LD B,A
  LD DE,L45A2
  PUSH DE
  LD DE,_GETVAR_RET
  PUSH DE
  LD A,(VALTYP)
  LD D,A
  JP NSCFOR

; Routine at 17826
L45A2:
  LD A,D
  OR E
  JP Z,FC_ERR
; This entry point is used by the routine at __CHAIN.
L45A2_0:
  PUSH HL
  LD B,D
  LD C,E
  LD HL,L45C9
  PUSH HL
L45A2_1:
  DEC BC
L45A2_2:
  LD A,(BC)
  DEC BC
  OR A
  JP M,L45A2_2
  LD A,(BC)
  OR $80
  LD (BC),A
  RET

; This entry point is used by the routine at __CHAIN.
L45A2_3:
  LD (SUBFLG),A
  LD A,(HL)
  CP '('
  JP NZ,__CHAIN_9
  EX (SP),HL
  DEC BC
  DEC BC
  CALL L45A2_1

; Routine at 17865
L45C9:
  POP HL
  DEC HL
  CALL CHRGTB
  JP Z,__CHAIN_6
  CP '('
  JP NZ,L45C9_1
; This entry point is used by the routine at __CHAIN.
L45C9_0:
  CALL CHRGTB
  CALL SYNCHR
  DEFM ")"
  JP Z,__CHAIN_6
L45C9_1:
  CALL SYNCHR
  DEFM ","
  JP __CHAIN_7

; This entry point is used by the routine at __CHAIN.
L45C9_2:
  POP HL
  LD (CURLIN),HL
  EX DE,HL
  LD HL,(ARYTAB)
  EX DE,HL
  LD HL,(VARTAB)
L45C9_3:
  CALL DCOMPR
  JP Z,L45C9_6
  PUSH HL
  LD C,(HL)
  INC HL
  INC HL
  LD A,(HL)
  OR A
  PUSH AF
  AND $7F
  LD (HL),A
  INC HL
  CALL ARR_GET
  LD B,$00
  ADD HL,BC
  POP AF
  POP BC
  JP M,L45C9_3
  PUSH BC
  CALL L45C9_4
  LD HL,(ARYTAB)
  ADD HL,DE
  LD (ARYTAB),HL
  EX DE,HL
  POP HL
  JP L45C9_3

L45C9_4:
  EX DE,HL
  LD HL,(STREND)
L45C9_5:
  CALL DCOMPR
  LD A,(DE)
  LD (BC),A
  INC DE
  INC BC
  JP NZ,L45C9_5
  LD A,C
  SUB L
  LD E,A
  LD A,B
  SBC A,H
  LD D,A
  DEC DE
  DEC BC
  LD H,B
  LD L,C
  LD (STREND),HL
  RET

L45C9_6:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
L45C9_7:
  CALL DCOMPR
  JP Z,CHAIN_ALL
  PUSH HL
  INC HL
  INC HL
  LD A,(HL)
  OR A
  PUSH AF
  AND $7F
  LD (HL),A
  INC HL
  CALL ARR_GET
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC
  POP AF
  POP BC
  JP M,L45C9_7
  PUSH BC
  CALL L45C9_4
  EX DE,HL
  POP HL
  JP L45C9_7

; CHAIN: With the ALL option, every variable in the current program is passed
; to the called program
;
; Used by the routines at __CHAIN and L45C9.
CHAIN_ALL:
  LD HL,(VARTAB)
CHAIN_ALL_0:
  EX DE,HL
  LD HL,(ARYTAB)
  EX DE,HL
  CALL DCOMPR
  JP Z,CHAIN_ALL_3
  CALL L46AB_5
  JP NZ,CHAIN_ALL_1
  CALL L46AB_0
  XOR A
CHAIN_ALL_1:
  LD E,A
  LD D,$00
  ADD HL,DE
  JP CHAIN_ALL_0
CHAIN_ALL_2:
  POP BC
; This entry point is used by the routine at L46AB.
CHAIN_ALL_3:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  CALL DCOMPR
  JP Z,L46AB_1
  CALL L46AB_5
  PUSH AF
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  POP AF
  PUSH HL
  ADD HL,BC
  CP $03
  JP NZ,CHAIN_ALL_2
  LD (TEMP3),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL

; Routine at 18091
L46AB:
  EX DE,HL
  LD HL,(TEMP3)
  EX DE,HL
  CALL DCOMPR
  JP Z,CHAIN_ALL_3
  LD BC,L46AB
  PUSH BC
; This entry point is used by the routine at CHAIN_ALL.
L46AB_0:
  LD A,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  OR A
  RET Z
  PUSH HL
  LD HL,(VARTAB)
  CALL DCOMPR
  POP HL
  RET C
  PUSH HL
  LD HL,(TXTTAB)
  CALL DCOMPR
  POP HL
  RET NC
  PUSH HL
  DEC HL
  DEC HL
  DEC HL
  PUSH HL
  CALL STRCPY
  POP HL
  LD B,$03
  CALL CPY2HL
  POP HL
  RET

; This entry point is used by the routine at CHAIN_ALL.
L46AB_1:
  CALL GARBGE
  LD HL,(STREND)
  LD B,H
  LD C,L
  EX DE,HL
  LD HL,(VARTAB)
  EX DE,HL
  LD HL,(ARYTAB)
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD (TEMP9),HL
  LD HL,(FRETOP)
  LD (FRETOP_SV),HL
  CALL MOVSTR
  LD H,B
  LD L,C
  DEC HL
  LD (FRETOP),HL
  LD A,(CHAIN_DEL)
  OR A
  JP Z,L46AB_2
  LD HL,(CHAIN_FROM)
  LD B,H
  LD C,L
  LD HL,(CHAIN_TO)
  CALL __DELETE_0
  LD (ARYTAB),HL
  LD (STREND),HL
  CALL LINKER
L46AB_2:
  LD A,$01
  LD (CHNFLG),A
  LD A,(MRGFLG)
  OR A
  JP NZ,__MERGE_0
  LD A,(MAXFIL)			; HIGHEST FILE NUMBER ALLOWED
  LD (MAXFILSV),A
  JP _LOAD

; This entry point is used by the routines at __LOAD and L4D05.
L46AB_3:
  XOR A
  LD (CHNFLG),A
  LD (MRGFLG),A
  LD HL,(VARTAB)
  LD B,H
  LD C,L
  LD HL,(TEMP9)
  ADD HL,BC
  LD (ARYTAB),HL
  LD HL,(FRETOP)
  INC HL
  EX DE,HL
  LD HL,(FRETOP_SV)
  LD (FRETOP),HL
L46AB_4:
  CALL DCOMPR
  LD A,(DE)
  LD (BC),A
  INC DE
  INC BC
  JP NZ,L46AB_4
  DEC BC
  LD H,B
  LD L,C
  LD (STREND),HL
  EX DE,HL
  LD HL,(CHAIN_LN)
  EX DE,HL
  LD HL,(TXTTAB)
  DEC HL
  LD A,D
  OR E
  JP Z,NEWSTT
  CALL SRCHLN
  JP NC,UL_ERR
  DEC BC
  LD H,B
  LD L,C
  JP NEWSTT

; This entry point is used by the routine at CHAIN_ALL.
L46AB_5:
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  PUSH AF
  CALL ARR_GET
  POP AF
  CP $03
  RET

IF ORIGINAL
  JP __DATA
ENDIF

__WRITE:
  LD C,$02
  CALL GET_CHNUM          ; Look for '#' channel specifier and put the associated file buffer in BC
  DEC HL
  CALL CHRGTB
  JP Z,L46AB_11
__WRITE_0:
  CALL EVAL
  PUSH HL
  CALL GETYPR
  JP Z,L46AB_10
  CALL FOUT
  CALL CRTST
  LD HL,(FACCU)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  CP ' '
  JP NZ,__WRITE_1
  INC DE
  LD (HL),D
  DEC HL
  LD (HL),E
  DEC HL
  DEC (HL)
__WRITE_1:
  CALL PRS1
__WRITE_2:
  POP HL
  DEC HL
  CALL CHRGTB
  JP Z,L46AB_11
  CP ';'
  JP Z,__WRITE_3
  CALL SYNCHR
  DEFM ","
  DEC HL
__WRITE_3:
  CALL CHRGTB
  LD A,$2C
  CALL OUTDO
  JP __WRITE_0

L46AB_10:
  LD A,'"'
  CALL OUTDO
  CALL PRS1
  LD A,'"'
  CALL OUTDO
  JP __WRITE_2

L46AB_11:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  JP Z,L46AB_13
  LD A,(HL)
  CP $03
  JP NZ,L46AB_13
  CALL __GET_27
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD DE,$FFFE
  ADD HL,DE
  JP NC,L46AB_13
L46AB_12:
  LD A,' '
  CALL OUTDO
  DEC HL
  LD A,H
  OR L
  JP NZ,L46AB_12
L46AB_13:
  POP HL
  CALL OUTDO_CRLF
  JP FINPRT

; This entry point is used by the routine at __OPEN.
VARECS:
  CP $03
  RET NZ
  DEC HL
  CALL CHRGTB
  PUSH DE
  LD DE,$0080
  JP Z,L46AB_15
  PUSH BC
  CALL GET_POSINT
  POP BC
L46AB_15:
  PUSH HL
  LD HL,(RECSIZ)
  CALL DCOMPR
  JP C,FC_ERR
  LD HL,$00A9		; 169
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  XOR A
  LD E,$07
L46AB_16:
  INC HL
  LD (HL),A
  DEC E
  JP NZ,L46AB_16
  POP HL
  POP DE
  RET

; 'PUT' BASIC command
__PUT:
  DEFB $F6                ; OR $AF  masking the next instruction

; 'GET' BASIC command
__GET:
  XOR A
  LD (PUTGET_FLG),A
  CALL GET_CHNUM_2		; Check we have the '#' channel specifier and put the associated file buffer in BC
  CP $03
  JP NZ,FMODE_ERR
  PUSH BC
  PUSH HL
  LD HL,$00AD
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC DE
  EX (SP),HL
  LD A,(HL)
  CP ','
  CALL Z,GET_POSINT
  DEC HL
  CALL CHRGTB
  JP NZ,SN_ERR
  EX (SP),HL
  LD A,D
  OR E
  JP Z,RECNO_ERR
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  DEC DE
  POP HL
  POP BC
  PUSH HL
  PUSH BC
  LD HL,$00B0		; 176
  ADD HL,BC
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD HL,$00A9		; 169
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  EX DE,HL
  PUSH DE
  PUSH HL
  LD HL,$0080
  CALL DCOMPR
  POP HL
  JP NZ,__GET_0
  LD DE,$0000
  JP __GET_7

__GET_0:
  LD B,D
  LD C,E
  LD A,$10
  EX DE,HL
  LD HL,$0000
  PUSH HL
__GET_1:
  ADD HL,HL
  EX (SP),HL
  JP NC,__GET_2
  ADD HL,HL
  INC HL
  JP __GET_3

__GET_2:
  ADD HL,HL
__GET_3:
  EX (SP),HL
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,__GET_5
  ADD HL,BC
  EX (SP),HL
  JP NC,__GET_4
  INC HL
__GET_4:
  EX (SP),HL
__GET_5:
  DEC A
  JP NZ,__GET_1
  LD A,L
  AND $7F
  LD E,A
  LD D,$00
  POP BC
  LD A,L
  LD L,H
  LD H,C
  ADD HL,HL
  JP C,FC_ERR
  RLA
  JP NC,__GET_6
  INC HL
__GET_6:
  LD A,B
  OR A
  JP NZ,FC_ERR
__GET_7:
  LD (FIELD_PTR1),HL
  POP HL
  POP BC
  PUSH HL
  LD HL,$00B2
  ADD HL,BC
  LD (FIELD_PTR2),HL
__GET_8:
  LD HL,$0029
  ADD HL,BC
  ADD HL,DE
  LD (FIELD_PTR3),HL
  POP HL
  PUSH HL
  LD HL,$0080
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  POP DE
  PUSH DE
  CALL DCOMPR
  JP C,__GET_9
  LD H,D
  LD L,E
__GET_9:
  LD A,(PUTGET_FLG)
  OR A
  JP Z,__GET_12           ; JP if GET
  LD DE,$0080
  CALL DCOMPR
  JP NC,__GET_10
  PUSH HL
  CALL __GET_14
  POP HL
__GET_10:
  PUSH BC
  LD B,H
  LD C,L
  EX DE,HL
  LD HL,(FIELD_PTR3)
  EX DE,HL
  LD HL,(FIELD_PTR2)
  CALL __GET_17
  LD (FIELD_PTR2),HL
  LD D,B
  LD E,C
  POP BC
  CALL __GET_13
__GET_11:
  LD HL,(FIELD_PTR1)
  INC HL
  LD (FIELD_PTR1),HL
  POP HL
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD A,H
  OR L
  LD DE,$0000
  PUSH HL
  JP NZ,__GET_8
  POP HL
  POP HL
  RET

__GET_12:
  PUSH HL
  CALL __GET_14
  POP HL
  PUSH BC
  LD B,H
  LD C,L
  EX DE,HL
  LD HL,(FIELD_PTR2)
  EX DE,HL
  LD HL,(FIELD_PTR3)
  CALL __GET_17
  EX DE,HL
  LD (FIELD_PTR2),HL
  LD D,B
  LD E,C
  POP BC
  JP __GET_11

__GET_13:
  DEFB $F6                ; "OR n" to Mask 'XOR A'
__GET_14:
  XOR A
  LD (MAXTRK),A
  PUSH BC
  PUSH DE
  PUSH HL
  EX DE,HL
  LD HL,(FIELD_PTR1)
  EX DE,HL
  LD HL,$00AB
  ADD HL,BC
  PUSH HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  INC DE
  CALL DCOMPR
  POP HL
  LD (HL),E
  INC HL
  LD (HL),D
  JP NZ,__GET_15
  LD A,(MAXTRK)
  OR A
  JP Z,__GET_16
__GET_15:
  LD HL,__GET_16
  PUSH HL
  PUSH BC
  PUSH HL
  LD HL,$0026
  ADD HL,BC
  JP FIVDPT

__GET_16:
  POP HL
  POP DE
  POP BC
  RET

__GET_17:
  PUSH BC
__GET_18:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC BC
  LD A,B
  OR C
  JP NZ,__GET_18
  POP BC
  RET

; This entry point is used by the routine at __LOF.
FILOFV:
  POP AF
  PUSH DE
  PUSH BC
  PUSH AF
  LD B,H
  LD C,L
  CALL __GET_28
  JP Z,__GET_21
  CALL __GET_26
  LD HL,$00B1		; 177
  ADD HL,BC
  ADD HL,DE
  POP AF
  LD (HL),A
  PUSH AF
  LD HL,$0028
  ADD HL,BC
  LD D,(HL)
  LD (HL),$00
  CP $0D
  JP Z,__GET_20
  ADD A,$E0
  LD A,D
  ADC A,$00
  LD (HL),A
__GET_20:
  POP AF
  POP BC
  POP DE
  POP HL
  RET

__GET_21:
  JP FIELD_OV_ERR

; This entry point is used by the routine at INDSKB.
FILIFV:
  PUSH DE
  CALL __GET_27
  JP Z,__GET_21
  CALL __GET_26
  LD HL,$00B1		; 177
  ADD HL,BC
  ADD HL,DE
  LD A,(HL)
  OR A
  POP DE
  POP HL
  POP BC
  RET

__GET_23:
  LD HL,$00A9		; 169
  JP __GET_25

__GET_24:
  LD HL,$00B0		; 176
__GET_25:
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  RET

__GET_26:
  INC DE
  LD HL,$00B0		; 176
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  RET

; This entry point is used by the routine at L46AB.
__GET_27:
  LD B,H
  LD C,L
__GET_28:
  CALL __GET_24
  PUSH DE
  CALL __GET_23
  EX DE,HL
  POP DE
  CALL DCOMPR
  RET

; This entry point is used by the routine at __MERGE.
__GET_29:
  CALL CHRGTB
  LD (TEMP),HL
  CALL SCCPTR
  CALL __GET_30
  LD A,$FE
  CALL __MERGE_4
  CALL __GET_33
  JP GTMPRT            ;Restore code string address

__GET_30:
  LD BC,$0D0B
  LD HL,(TXTTAB)
  EX DE,HL
__GET_31:
  LD HL,(VARTAB)
  CALL DCOMPR
  RET Z
  LD HL,ATNTAB
  LD A,L
  ADD A,C
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  LD A,(DE)
  SUB B
  XOR (HL)
  PUSH AF
  LD HL,FP_SINTAB
  LD A,L
  ADD A,B
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  POP AF
  XOR (HL)
  ADD A,C
  LD (DE),A
  INC DE
  DEC C
  JP NZ,__GET_32
  LD C,$0B
__GET_32:
  DEC B
  JP NZ,__GET_31
  LD B,$0D
  JP __GET_31

; This entry point is used by the routine at __LOAD.
__GET_33:
  LD BC,$0D0B
  LD HL,(TXTTAB)
  EX DE,HL
__GET_34:
  LD HL,(VARTAB)
  CALL DCOMPR
  RET Z
  LD HL,FP_SINTAB
  LD A,L
  ADD A,B
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  LD A,(DE)
  SUB C
  XOR (HL)
  PUSH AF
  LD HL,ATNTAB
  LD A,L
  ADD A,C
  LD L,A
  LD A,H
  ADC A,$00
  LD H,A
  POP AF
  XOR (HL)
  ADD A,B
  LD (DE),A
  INC DE
  DEC C
  JP NZ,__GET_35
  LD C,$0B
__GET_35:
  DEC B
  JP NZ,__GET_34
  LD B,$0D
  JP __GET_34

; This entry point is used by the routines at __DELETE and __POKE.
ADDR_RANGE:
  PUSH HL
  LD HL,(CURLIN)
  LD A,H
  AND L
  POP HL
  INC A
  RET NZ

; This entry point is used by the routines at PROMPT, __LIST, LISPRT and __MERGE.
PROCHK:
  PUSH AF
  LD A,(PROFLG)
  OR A
  JP NZ,FC_ERR
  POP AF
  RET

; Data block at 19141
FIELD_PTR1:
  DEFW $0000

; Data block at 19143
FIELD_PTR2:
  DEFW $0000

; Data block at 19145
FIELD_PTR3:
  DEFW $0000

; Used to toggle between PUT / GET mode
PUTGET_FLG:
  DEFB $00

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
  JP PINLIN          ;NO CRUNCHING IN THIS CASE

; This entry point is used by the routines at PINLIN, DELCHR, TTYLIN and
; PUTBUF.
MORINP:
  CALL CLOTST		; Get character and test ^O

  CP $01			; CTL-A  (enter in EDIT MODE?))
  JP NZ,INLNC1      ; NO, TREAT NORMALLY

  LD (HL),$00       ; SAVE TERMINATOR
  JP PINLIN_1       ; GO EDIT FROM HERE

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
; This entry point is used by the routines at __LINE, INPUT_SUB and TTYLIN.
PINLIN_0:
  CALL CLOTST		; Get character and test ^O
  CP $01			; CTL-A to enter in EDIT mode
  JP NZ,TTYLIN
; This entry point is used by the routine at QINLIN.
PINLIN_1:
  CALL OUTDO_CRLF
  LD HL,$FFFF
  JP __EDIT_3

; This entry point is used by the routine at TTYLIN.
RUBOUT:
  LD A,(RUBSW)
  OR A
  LD A,'\\'
  LD (RUBSW),A
  JP NZ,ECHDEL
  DEC B
  JP Z,QINLIN_0
  CALL OUTDO
  INC B
ECHDEL:
  DEC HL
  DEC B
  JP Z,OTKLN
  LD A,(HL)
  CALL OUTDO
  JP MORINP


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
  JP NZ,MORINP
; This entry point is used by the routines at PINLIN and TTYLIN.
OTKLN:
  CALL OUTDO              ; Output character in A
  CALL OUTDO_CRLF         ; Output CRLF

; Routine at 19246
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
  JP Z,RUBOUT
  LD A,(RUBSW)
  OR A
  JP Z,TTYLIN_1
  LD A,'\\'
  CALL OUTDO
  XOR A
  LD (RUBSW),A
TTYLIN_1:
  LD A,C
  CP $07
  JP Z,PUTCTL
  CP $03                  ; CTL-C ?
  CALL Z,KILIN
  SCF
  RET Z
  CP $0D
  JP Z,PUTBUF_2
  CP $09                  ; Is it TAB ?
  JP Z,PUTCTL
  CP $0A
  JP NZ,TTYLIN_2
  DEC B
  JP Z,PINLIN
  INC B
  JP PUTCTL

TTYLIN_2:
  CP $15                  ; Is it control "U"?
  CALL Z,KILIN            ; Yes - Get another line (wipe current buffer)
  JP Z,PINLIN
  CP $08                  ; Is it delete (backspace: ctl-H) ?
  JP NZ,NO_DELETE         ; No, skip over
DO_DELETE:
  DEC B
  JP Z,PINLIN_0
  CALL OUTDO
  LD A,' '
  CALL OUTDO
  LD A,$08
  JP DELCHR

NO_DELETE:
  CP $18                  ; CTL-X ?
  JP NZ,TTYLIN_3
  LD A,'#'                ; Print '#' to confirm
  JP OTKLN                ; .. and remove the current line being inserted

TTYLIN_3:
  CP $12                  ; Is it control "R"?
  JP NZ,PUTBUF            ; No - Put in buffer
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
  JP NZ,PUTBUF_0
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H                  ; Test for line overflow
  OR L
  POP HL
  LD A,$07                ; CTRL-G: Set a bell
  JP Z,OUTIT              ; Ring bell if buffer full
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
  CALL CLOTST		; Get character and test ^O
  OR A
  JP Z,PUTBUF_1
  CP $0D
  JP Z,MORINP
  JP INLNC1
  
; This entry point is used by the routine at TTYLIN.
PUTBUF_2:
  LD A,(INTFLG)
  OR A
  JP Z,FININL
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET

; This entry point is used by the routines at __LINE and __INPUT.
PUTBUF_3:
  PUSH AF
  LD A,$00
  LD (INTFLG),A
  POP AF
  CP ';'
  RET NZ
  LD (INTFLG),A
  JP CHRGTB



; Output char in 'A' to console
;
; Used by the routines at PROMPT, NEWSTT_0, DOTAB, INPUT_SUB, __LIST, __FILES,
; L46AB, QINLIN, PINLIN, DELCHR, TTYLIN, PUTBUF, TAB_LOOP, OUTDO_CRLF,
; TTY_FLUSH, _PR_CHR, __USING, L5256, L52F3, __EDIT, NOTDGI, NTCTCT and PRS1.
OUTDO:
  PUSH AF
  PUSH HL
  CALL ISFLIO
  JP NZ,FILOUT
  POP HL
  LD A,(PRTFLG)
  OR A
  JP Z,CHPUT
  POP AF
  PUSH AF
  CP $08
  JP NZ,OUTDO_1
  LD A,(LPTPOS)
  SUB $01
  JP C,OUTDO_0
  LD (LPTPOS),A
OUTDO_0:
  POP AF
  JP OUTPRT_CHR

OUTDO_1:
  CP $09
  JP NZ,OUTC

OUTC_TAB:
  LD A,' '
  CALL OUTDO
  LD A,(LPTPOS)
  CP $FF
  JP Z,OUTC_TAB_END
  AND $07
  JP NZ,OUTC_TAB
OUTC_TAB_END:
  POP AF
  RET

; Routine at 19542
;
; Used by the routine at OUTDO.
OUTC:
  POP AF
  PUSH AF
  SUB $0D
  JP Z,OUTC_1
  JP C,_OUTPRT
  LD A,(LPTSIZ)              ; Value for 'WIDTH' on printer output.
  INC A
  LD A,(LPTPOS)
  JP Z,OUTC_0                ; If 'WIDTH' is 255, the line width is "infinite" (no CRLF)

  PUSH HL
  LD HL,LPTSIZ               ; Value for 'WIDTH' on printer output.
  CP (HL)
  POP HL
  CALL Z,OUTPRT_CRLF

OUTC_0:
  CP $FF
  JP Z,_OUTPRT
  INC A
OUTC_1:
  LD (LPTPOS),A

; Output character to printer
;
; Used by the routine at OUTC.
_OUTPRT:
  POP AF

; Output character to printer
;
; Used by the routines at OUTDO and FINLPT.
OUTPRT_CHR:
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,A
  DEFB $CD                ; CALL nn

; Data block at 19587
SMC_OUTPRT:
  DEFW $0000

; Routine at 19589
L4C85:
  POP HL
  POP DE
  POP BC
  POP AF
  RET

; Reset printer
;
; Used by the routines at READY, STKERR and INPBRK.
FINLPT:
  XOR A
  LD (PRTFLG),A
  LD A,(LPTPOS)
  OR A
  RET Z
; This entry point is used by the routine at OUTC.
OUTPRT_CRLF:
  LD A,$0D
  CALL OUTPRT_CHR
  LD A,$0A
  CALL OUTPRT_CHR
  XOR A
  LD (LPTPOS),A
  RET

; Output character
;
; Used by the routines at CHPUT_SP and OUTDO.
CHPUT:
  LD A,(CTLOFG)
  OR A
  JP NZ,POPAF
  POP AF
  PUSH BC
  PUSH AF
  CP $08
  JP NZ,CTL_CHARS
  LD A,(TTYPOS)
  OR A
  JP Z,TAB_LOOP_0
  DEC A
  LD (TTYPOS),A
  LD A,$08
  JP TTY_JP
CTL_CHARS:
  CP $09
  JP NZ,L4CDB

; TAB_LOOP
TAB_LOOP:
  LD A,' '
  CALL OUTDO
  LD A,(TTYPOS)
  CP $FF
  JP Z,TAB_LOOP_0
  AND $07
  JP NZ,TAB_LOOP
; This entry point is used by the routine at CHPUT.
TAB_LOOP_0:
  POP AF
  POP BC
  RET

; Routine at 19675
;
; Used by the routine at CHPUT.
L4CDB:
  CP ' '
  JP C,TTY_JP
  LD A,(LINLEN)
  LD B,A
  LD A,(TTYPOS)
  INC B
  JP Z,L4CDB_0
  DEC B
  CP B
  CALL Z,OUTDO_CRLF
L4CDB_0:
  CP $FF
  JP Z,TTY_JP
  INC A
  LD (TTYPOS),A

; Routine at 19705
;
; Used by the routines at CHPUT and L4CDB.
TTY_JP:
  POP AF
  POP BC
  PUSH AF
  POP AF
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,A
  DEFB $CD                ; CALL nn

; Data block at 19715
SMC_TTYIN:
  DEFW $0000

; Routine at 19717
L4D05:
  POP HL
  POP DE
  POP BC
  POP AF
  RET

; This entry point is used by the routines at QINLIN, PINLIN and PUTBUF.
; Get character and test ^O
CLOTST:
  CALL ISFLIO
  JP Z,GETINP
  CALL RDBYT
  RET NC
  PUSH BC
  PUSH DE
  PUSH HL
  CALL LOAD_END
  POP HL
  POP DE
  POP BC
  LD A,(CHNFLG)
  OR A
  JP NZ,L46AB_3
  LD A,(AUTORUN)
  OR A
  JP Z,CLOTST_PROMPT
  LD HL,NEWSTT
  PUSH HL
  JP RUN_FST

CLOTST_PROMPT:
  PUSH HL
  PUSH BC
  PUSH DE
  LD HL,OK_MSG
  CALL PRS
  POP DE
  POP BC
  XOR A
  POP HL
  RET

; Get input character
;
; Used by the routines at FN_INPUT, L4D05, STALL, L4DC7, DISPED and NOTDGI.
GETINP:
  PUSH BC
  PUSH DE
  PUSH HL
  DEFB $CD                ; CALL nn

; Data block at 19780
SMC_GETINP:
  DEFW $0000

; Routine at 19782
L4D46:
  POP HL
  POP DE
  POP BC
  AND $7F
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
  CP $0F
  RET NZ
  LD A,(CTLOFG)           ; Get flag
  OR A
  CALL Z,CTROPT           ; PRINT AN ^O.
  CPL                     ; Flip it
  LD (CTLOFG),A           ; Put it back
  OR A
  JP Z,CTROPT             ; PRINT AN ^O.
  XOR A                   ; Null character
  RET

; Go to new line
;
; Used by the routines at ERROR_REPORT, READY, _LINE2PTR and INPBRK.
CONSOLE_CRLF:
  LD A,(TTYPOS)
  OR A
  RET Z
  JP OUTDO_CRLF
 
; This entry point is used by the routines at PUTBUF and EDIT_DONE.
FININL:
  LD (HL),$00
  LD HL,BUFMIN

; Print and go to new line
;
; Used by the routines at _ERROR_REPORT, __PRINT, PRNTNB, DOTAB, __LIST,
; __FILES, L46AB, PINLIN, DELCHR, TTYLIN, L4CDB, CONSOLE_CRLF, L5256, NOTDGI,
; EDIT_DONE, NTCTCT and DONCMD.
OUTDO_CRLF:
  LD A,$0D
  CALL OUTDO
  LD A,$0A
  CALL OUTDO
; This entry point is used by the routines at _PR_CHR and PRS1.
CRLF_DONE:
  CALL ISFLIO
  JP Z,RESET_POS
  XOR A
  RET

; RESET_POS
;
; Used by the routine at OUTDO_CRLF.
RESET_POS:
  LD A,(PRTFLG)
  OR A
  JP Z,TTY_FLUSH
  XOR A
  LD (LPTPOS),A
  RET

; TTY_FLUSH
;
; Used by the routine at RESET_POS.
TTY_FLUSH:
  XOR A                  ; Set to position 0
  LD (TTYPOS),A          ; Store it
  LD A,(NULLS)           ; Get number of nulls
NULLP:
  DEC A                  ; Count them
  RET Z                  ; Return if done
  PUSH AF                ; Save count
  XOR A                  ; Load a null
  CALL OUTDO             ; Output it
  POP AF                 ; Restore count
  JP NULLP               ; Keep counting

; TTY status check
;
; Used by the routine at __LIST.
ISCNTC:
  PUSH BC
  PUSH DE
  PUSH HL
  DEFB $CD                ; CALL nn

; Data block at 19872
SMC_ISCNTC3:
  DEFW $0000

; Routine at 19874
L4DA2:
  POP HL
  POP DE
  POP BC
  OR A
  RET Z


; "STOP" pressed.  Now wait for ^O or ^C
;
; Used by the routine at NEWSTT_0.
STALL:
  CALL GETINP             ; Get input and test for ^O
  CP $13                  ; Is it control "S"
  CALL Z,GETINP           ; Yes - Get another character
  LD (CHARC),A
  CP $03
  CALL Z,KILIN
  JP __STOP

; Routine at 19898
;
; Used by the routine at OPRND_MORE.
FN_INKEY:
  CALL CHRGTB
  PUSH HL
  CALL L4DC7_2
  JP NZ,L4DC7_0
  DEFB $CD                ; CALL nn

; Data block at 19909
SMC_ISCNTC2:
  DEFW $0000

; Routine at 19911
L4DC7:
  OR A
  JP Z,L4DC7_1
  CALL GETINP
; This entry point is used by the routine at FN_INKEY.
L4DC7_0:
  PUSH AF
  CALL MK_1BYTE_TMST
  POP AF
  LD E,A
  CALL __CHR_S_0
L4DC7_1:
  LD HL,NULL_STRING
  LD (FACCU),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET

; This entry point is used by the routines at FN_INPUT and FN_INKEY.
L4DC7_2:
  LD A,(CHARC)
  OR A
  RET Z
  PUSH AF
  XOR A
  LD (CHARC),A
  POP AF
  RET

; Output character, adj. CR/LF if necessary
;
; Used by the routines at LISPRT and NOTDGI.
_PR_CHR:
  CALL OUTDO
  CP $0A
  RET NZ
  LD A,$0D
  CALL OUTDO
  CALL CRLF_DONE
  LD A,$0A
  RET

; Return from 'DIM' command
DIMRET:
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL CHRGTB             ; Get next character
  RET Z                   ; End of DIM statement
  CALL SYNCHR             ; Make sure "," follows
  DEFM ","

; 'DIM' BASIC command
__DIM:
  LD BC,DIMRET
  PUSH BC
  DEFB $F6                ; "OR n" to Mask 'XOR A' (Flag "Create" variable)

; Get variable address to DE
;
; Used by the routines at __FOR, __LET, __LINE, __READ, EVAL_VARIABLE, __DEF,
; DOFN, LOOK_FOR, LINE_INPUT, __FIELD, __LSET, __CALL, GVAR, __TROFF, __ERASE,
; __NEXT and FN_INSTR.
GETVAR:
  XOR A                   ; Find variable address,to DE
  LD (DIMFLG),A           ; Set locate / create flag
  LD C,(HL)               ; Get First byte of name
; This entry point is used by the routine at CHEKFN.
GTFNAM:
  CALL IS_ALPHA           ; See if a letter
  JP C,SN_ERR             ; ?SN Error if not a letter
  XOR A
  LD B,A                  ; Clear second byte of name
  LD (TYPE_BUFFR),A             ; Set type to numeric
  INC HL
  LD A,(HL)
  CP '.'
  JP C,GETVAR_3
  JP Z,SVNAM2
  CP '9'+1
  JP NC,GETVAR_0
  CP '0'
  JP NC,SVNAM2
GETVAR_0:
  CALL IS_ALPHA_A
  JP C,GETVAR_3           ; JP if not letter
SVNAM2:
  LD B,A
  PUSH BC
  LD B,$FF
  LD DE,TYPE_BUFFR
GETVAR_1:
  OR $80                  ; A = 80H , Flag for string
  INC B
  LD (DE),A
  INC DE
  INC HL
  LD A,(HL)
  CP '9'+1
  JP NC,GETVAR_2
  CP '0'
  JP NC,GETVAR_1
GETVAR_2:
  CALL IS_ALPHA_A
  JP NC,GETVAR_1          ; JP if letter
  CP '.'
  JP Z,GETVAR_1
  LD A,B
  CP $27
  JP NC,SN_ERR
  POP BC
  LD (TYPE_BUFFR),A
  LD A,(HL)
GETVAR_3:
  CP '%'+1
  JP NC,GETVAR_4
  LD DE,GVAR
  PUSH DE
  LD D,$02                ; D=2
  CP '%'                  ; Single precision
  RET Z
  INC D                   ; D=3
  CP '$'                  ; String variable
  RET Z
  INC D
  CP '!'
  RET Z
  LD D,$08
  CP '#'                  ; Double precision
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

; Get variable
GVAR:
  LD A,D
  LD (VALTYP),A           ; Set variable type
  CALL CHRGTB
  LD A,(SUBFLG)           ; Array name needed ?
  DEC A
  JP Z,ARLDSV             ; Yes - Get array name
  JP P,NSCFOR             ; No array with "FOR" or "FN"
  LD A,(HL)               ; Get byte again
  SUB '('                 ; "(" ..Subscripted variable?
  JP Z,SBSCPT             ; Yes - Sort out subscript
  SUB $33                 ; ($28+$33)="[" ..Subscripted variable?
  JP Z,SBSCPT             ; Yes - Sort out subscript

; This entry point is used by the routine at __CHAIN.
NSCFOR:
  XOR A                   ; Simple variable
  LD (SUBFLG),A           ; Clear "FOR" flag
  PUSH HL                 ; Save code string address
  LD A,(NOFUNS)
  OR A
  LD (PRMFLG),A
  JP Z,GVAR_5
  LD HL,(PRMLEN)
  LD DE,PARM1
  ADD HL,DE
  LD (ARYTA2),HL
  EX DE,HL
  JP GVAR_4
  
GVAR_0:
  LD A,(DE)
  LD L,A
  INC DE
  LD A,(DE)
  INC DE
  CP C
  JP NZ,GVAR_1
  LD A,(VALTYP)
  CP L
  JP NZ,GVAR_1
  LD A,(DE)
  CP B
  JP Z,L4F11_2
GVAR_1:
  INC DE
; This entry point is used by the routine at L4F11.
GVAR_2:
  LD A,(DE)
; This entry point is used by the routine at L4F11.
GVAR_3:
  LD H,$00
  ADD A,L
  INC A
  LD L,A
  ADD HL,DE
GVAR_4:
  EX DE,HL
  LD A,(ARYTA2)
  CP E
  JP NZ,GVAR_0
  LD A,(ARYTA2+1)
  CP D
  JP NZ,GVAR_0
  LD A,(PRMFLG)
  OR A
  JP Z,ENDNAM0
  XOR A
  LD (PRMFLG),A
GVAR_5:
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)
  JP GVAR_4
; This entry point is used by the routines at INPUT_SUB, __ERL and __CHAIN.
_GETVAR:
  CALL GETVAR
_GETVAR_RET:
  RET

; Routine at 20241
L4F11:
  LD D,A
  LD E,A
  POP BC
  EX (SP),HL
  RET

; This entry point is used by the routine at GVAR.
ENDNAM0:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,_GETVAR_RET
  CALL DCOMPR
  JP Z,L4F11
  LD DE,EVAL_VARIABLE_1
  CALL DCOMPR
  POP DE
  JP Z,L4F11_4
  EX (SP),HL
  PUSH HL
  PUSH BC
  LD A,(VALTYP)
  LD B,A
  LD A,(TYPE_BUFFR)
  ADD A,B
  INC A
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
  CALL MOVUP
  POP HL
  LD (STREND),HL
  LD H,B
  LD L,C
  LD (ARYTAB),HL
L4F11_1:
  DEC HL
  LD (HL),$00
  CALL DCOMPR
  JP NZ,L4F11_1
  POP DE
  LD (HL),D
  INC HL
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
  CALL CREARY_TYPE
  EX DE,HL
  INC DE
  POP HL
  RET
; This entry point is used by the routine at GVAR.
L4F11_2:
  INC DE
  LD A,(TYPE_BUFFR)
  LD H,A
  LD A,(DE)
  CP H
  JP NZ,GVAR_2
  OR A
  JP NZ,L4F11_3
  INC DE
  POP HL
  RET
L4F11_3:
  EX DE,HL
  CALL ZERARY_7
  EX DE,HL
  JP NZ,GVAR_3
  POP HL
  RET
L4F11_4:
  LD (FPEXP),A
  LD H,A
  LD L,A
  LD (FACCU),HL
  CALL GETYPR
  JP NZ,L4F11_5
  LD HL,NULL_STRING
  LD (FACCU),HL
L4F11_5:
  POP HL
  RET

; SBSCPT
;
; Used by the routine at GVAR.
SBSCPT:
  PUSH HL                 ; Save code string address
  LD HL,(DIMFLG)          ; Type
  EX (SP),HL              ; Save and get code string
  LD D,A                  ; Zero number of dimensions
SCPTLP:
  PUSH DE                 ; Save number of dimensions
  PUSH BC                 ; Save array name
  LD DE,TYPE_BUFFR
  LD A,(DE)
  OR A                    ; numeric type ?
  JP Z,SBSCPT_2
  
  EX DE,HL
  ADD A,$02
  RRA
  LD C,A
  CALL CHKSTK             ; Check if enough memory
  LD A,C
SBSCPT_0:
  LD C,(HL)               ; SCPTLP_0
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  DEC A
  JP NZ,SBSCPT_0
  PUSH HL
  LD A,(TYPE_BUFFR)
  PUSH AF
  EX DE,HL
  CALL GET_POSINT           ; Get subscript (0-32767)
  POP AF
  LD (LCRFLG),HL
  POP HL
  ADD A,$02
  RRA
SBSCPT_LP:
  POP BC
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC A
  JP NZ,SBSCPT_LP
  LD HL,(LCRFLG)            ; Locate/Create and Type
  JP SBSCPT_3

SBSCPT_2:
  CALL GET_POSINT           ; Get subscript (0-32767)
  XOR A
  LD (TYPE_BUFFR),A               ; Set type to numeric

SBSCPT_3:
  LD A,(OPTBASE)
  OR A
  JP Z,SBSCPT_4
  LD A,D
  OR E
  JP Z,BS_ERR
  DEC DE
SBSCPT_4:
  POP BC
  POP AF
  EX DE,HL
  EX (SP),HL              ; Save subscript value
  PUSH HL                 ; Save LCRFLG and TYPE
  EX DE,HL
  INC A                   ; Count dimensions
  LD D,A                  ; Save in D
  LD A,(HL)               ; Get next byte in code string
  CP ','                  ; Comma (more to come)?
  JP Z,SCPTLP             ; Yes - More subscripts
  CP ')'                  ; Make sure ")" follows
  JP Z,SBSCPT_5
  CP ']'
  JP NZ,SN_ERR
SBSCPT_5:
  CALL CHRGTB
  LD (NXTOPR),HL          ; Save code string address
  POP HL                  ; Get LCRFLG and TYPE
  LD (DIMFLG),HL          ; Restore Locate/create & type
  LD E,$00
  PUSH DE
  
  DEFB $11                ; "LD DE,nn" to jump over the next word without executing it
  
; This entry point is used by the routines at __CHAIN and GVAR.
ARLDSV:
  PUSH HL                 ; Save code string address
  PUSH AF                 ; A = 00 , Flags set = Z,N
  LD HL,(ARYTAB)          ; Start of arrays
  DEFB $3E                ; DEFB $3E  ; "LD A,n" to Mask the next byte
; This entry point is used by the routine at NXTARY.
FNDARY:
  ADD HL,DE               ; Move to next array start
  EX DE,HL
  LD HL,(STREND)          ; End of arrays
  EX DE,HL
  CALL DCOMPR             ; End of arrays found?
  JP Z,CREARY             ; Yes - Create array
  LD E,(HL)               ; Get type
  INC HL                  ; Move on
  LD A,(HL)               ; Get second byte of name
  INC HL                  ; Move on
  CP C                    ; Compare with name given (second byte)
  JP NZ,NXTARY            ; Different - Find next array
  LD A,(VALTYP)
  CP E                    ; Compare type
  JP NZ,NXTARY            ; Different - Find next array
  LD A,(HL)               ; Get first byte of name
  CP B                    ; Compare with name given (first byte)
  JP Z,BSOPRND_0

; Routine at 20540
;
; Used by the routine at SBSCPT.
NXTARY:
  INC HL
; This entry point is used by the routine at BSOPRND_0.
NXTARY_0:
  LD E,(HL)
  INC E
  LD D,$00
  ADD HL,DE
; This entry point is used by the routine at BSOPRND_0.
NXTARY_1:
  LD E,(HL)               ; Get LSB of next array address
  INC HL
  LD D,(HL)               ; Get MSB of next array address
  INC HL
  JP NZ,FNDARY            ; Not found - Keep looking
  LD A,(DIMFLG)           ; Found Locate or Create it?
  OR A
  JP NZ,DD_ERR            ; Create - Err $0A - "Redimensioned array"
  POP AF                  ; Locate - Get number of dim'ns
  LD B,H                  ; BC Points to array dim'ns
  LD C,L
  JP Z,POPHLRT            ; Jump if array load/save
  SUB (HL)                ; Same number of dimensions?
  JP Z,FINDEL             ; Yes - Find element

; ERR $09 - "Subscript out of range"
;
; Used by the routines at MLDEBC, SBSCPT and ZERARY.
BS_ERR:
  LD DE,$0009
  JP ERROR

; BSOPRND_0
;
; Used by the routine at SBSCPT.
BSOPRND_0:
  INC HL
  LD A,(TYPE_BUFFR)
  CP (HL)
  JP NZ,NXTARY_0
  INC HL
  OR A
  JP Z,NXTARY_1
  DEC HL
  CALL ZERARY_7
  JP NXTARY_1

; This entry point is used by the routine at SBSCPT.
CREARY:
  LD A,(VALTYP)
  LD (HL),A
  INC HL
  LD E,A
  LD D,$00
  POP AF                  ; Array to save or 0 dim'ns?
  JP Z,CREARY_EXIT
  LD (HL),C               ; Save second byte of name
  INC HL
  LD (HL),B               ; Save first byte of name
  CALL CREARY_TYPE
  INC HL
  LD C,A                  ; Number of dimensions to C
  CALL CHKSTK             ; Check if enough memory
  INC HL                  ; Point to number of dimensions
  INC HL
  LD (TEMP3),HL           ; Save address of pointer
  LD (HL),C               ; Set number of dimensions
  INC HL
  LD A,(DIMFLG)           ; Locate of Create?
  RLA                     ; Carry set = Create
  LD A,C                  ; Get number of dimensions
CRARLP:
  JP C,GETSIZ
  PUSH AF
  LD A,(OPTBASE)
  XOR $0B                 ; (10+1) XOR 11: Default dimension size is 10
  LD C,A                  ; BC = number of dimensions
  LD B,$00
  POP AF
  JP NC,DEFSIZ            ; Locate - Set default size
GETSIZ:
  POP BC                  ; Get specified dimension size
  INC BC                  ; Include zero element
DEFSIZ:
  LD (HL),C               ; Save LSB of dimension size
  PUSH AF                 ; Save num' of dim'ns an status
  INC HL
  LD (HL),B               ; Save MSB of dimension size
  INC HL
  CALL MLDEBC             ; Multiply DE by BC to find amount of mem needed
  POP AF                  ; Restore number of dimensions
  DEC A                   ; Count them
  JP NZ,CRARLP            ; Do next dimension if more
  PUSH AF                 ; Save locate/create flag
  LD B,D                  ; MSB of memory needed
  LD C,E                  ; LSB of memory needed
  EX DE,HL
  ADD HL,DE               ; Add bytes to array start
  JP C,OM_ERR             ; Too big - Error
  CALL ENFMEM             ; See if enough memory
  LD (STREND),HL          ; Save new end of array

; Set array elements to zero
ZERARY:
  DEC HL                  ; Back through array data
  LD (HL),$00             ; Set array element to zero
  CALL DCOMPR             ; All elements zeroed?
  JP NZ,ZERARY            ; No - Keep on going
  INC BC                  ; Number of bytes + 1
  LD D,A                  ; A=0
  LD HL,(TEMP3)           ; Get address of array
  LD E,(HL)               ; Number of dimensions
  EX DE,HL                ; To HL
  ADD HL,HL               ; Two bytes per dimension size
  ADD HL,BC               ; Add number of bytes
  EX DE,HL                ; Bytes needed to DE
  DEC HL
  DEC HL
  LD (HL),E               ; Save LSB of bytes needed
  INC HL
  LD (HL),D               ; Save MSB of bytes needed
  INC HL
  POP AF                  ; Locate / Create?
  JP C,ENDDIM             ; A is 0 , End if create
; This entry point is used by the routine at NXTARY.
FINDEL:
  LD B,A                  ; Find array element
  LD C,A
  LD A,(HL)               ; Number of dimensions
  INC HL
  DEFB $16                ; "LD D,n" to skip "POP HL"
FNDELP:
  POP HL                  ; Address of next dim' size
  LD E,(HL)               ; Get LSB of dim'n size
  INC HL
  LD D,(HL)               ; Get MSB of dim'n size
  INC HL
  EX (SP),HL              ; Save address - Get index
  PUSH AF                 ; Save number of dim'ns
  CALL DCOMPR             ; Dimension too large?
  JP NC,BS_ERR            ; Yes - ?BS Error
  CALL MLDEBC             ; Multiply previous by size
  ADD HL,DE               ; Add index to pointer
  POP AF                  ; Number of dimensions
  DEC A                   ; Count them
  LD B,H                  ; MSB of pointer
  LD C,L                  ; LSB of pointer
  JP NZ,FNDELP            ; More - Keep going
  LD A,(VALTYP)
  LD B,H
  LD C,L
  ADD HL,HL             ; 4 Bytes per element
  SUB $04
  JP C,FINDEL_0
  ADD HL,HL
  JP Z,FINDEL_1
  ADD HL,HL
FINDEL_0:
  OR A
  JP PO,FINDEL_1
  ADD HL,BC
FINDEL_1:
  POP BC                  ; Start of array
  ADD HL,BC               ; Point to element
  EX DE,HL                ; Address of element to DE
ENDDIM:
  LD HL,(NXTOPR)          ; Got code string address
  RET

; This entry point is used by the routine at BSOPRND_0.
CREARY_EXIT:
  SCF
  SBC A,A		; A=$FF
  POP HL		; Skip return address
  RET

; This entry point is used by the routines at L45C9, L46AB, GRBLP and ARRLP.
ARR_GET:
  LD A,(HL)
  INC HL
ARR_GET_0:
  PUSH BC
  LD B,$00
  LD C,A
  ADD HL,BC
  POP BC
  RET

; This entry point is used by the routines at L4F11 and BSOPRND_0.
CREARY_TYPE:
  PUSH BC
  PUSH DE
  PUSH AF
  LD DE,TYPE_BUFFR
  LD A,(DE)
  LD B,A
  INC B
CREARY_TYPE_0:
  LD A,(DE)
  INC DE
  INC HL
  LD (HL),A
  DEC B
  JP NZ,CREARY_TYPE_0
  POP AF
  POP DE
  POP BC
  RET

; This entry point is used by the routines at L4F11 and BSOPRND_0.
ZERARY_7:
  PUSH DE
  PUSH BC
  LD DE,$07C6
  LD B,A
  INC HL
  INC B
ZERARY_8:
  DEC B
  JP Z,ZERARY_9
  LD A,(DE)
  INC DE
  CP (HL)
  INC HL
  JP Z,ZERARY_8
  LD A,B
  DEC A
  CALL NZ,ARR_GET_0
  XOR A
  DEC A
ZERARY_9:
  POP BC
  POP DE
  RET

; PRINT USING
;
; PRINT#<filenumber>,[USING<string exp>;]<list of exps>
; To write data to a sequential disk file.
;
; Used by the routine at __PRINT.
__USING:
  CALL EVAL_0
  CALL TSTSTR
  CALL SYNCHR
  DEFM ";"
  EX DE,HL
  LD HL,(FACCU)
  JP __USING_1

; This entry point is used by the routine at L5256.
__USING_0:
  LD A,(FLGINP)
  OR A
  JP Z,__USING_2
  POP DE
  EX DE,HL
__USING_1:
  PUSH HL
  XOR A
  LD (FLGINP),A
  INC A
  PUSH AF
  PUSH DE
  LD B,(HL)
  OR B
__USING_2:
  JP Z,FC_ERR
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP __USING_7
__USING_3:
  LD E,B
  PUSH HL
  LD C,$02
__USING_4:
  LD A,(HL)
  INC HL
  CP '\\'
  JP Z,L52F3
  CP ' '
  JP NZ,__USING_5
  INC C
  DEC B
  JP NZ,__USING_4
__USING_5:
  POP HL
  LD B,E
  LD A,'\\'
__USING_6:
  CALL OUTC_SGN
  CALL OUTDO
; This entry point is used by the routine at L5256.
__USING_7:
  XOR A
  LD E,A
  LD D,A
__USING_8:
  CALL OUTC_SGN
  LD D,A
  LD A,(HL)
  INC HL
  CP '!'
  JP Z,L5256_12
  CP '#'
  JP Z,__USING_11
  CP '&'
  JP Z,L5256_11
  DEC B
  JP Z,L5256_7
  CP '+'
  LD A,$08
  JP Z,__USING_8
  DEC HL
  LD A,(HL)
  INC HL
  CP '.'
  JP Z,__USING_12
  CP '_'
  JP Z,L5256_10
  CP '\\'
  JP Z,__USING_3
  CP (HL)
  JP NZ,__USING_6
  CP '$'
  JP Z,USING_STR
  CP '*'
  JP NZ,__USING_6
  INC HL
  LD A,B
  CP $02
  JP C,__USING_9
  LD A,(HL)
  CP '$'
__USING_9:
  LD A,' '
  JP NZ,__USING_10
  DEC B
  INC E
  DEFB $FE                ; CP AFh ..hides the "XOR A" instruction
USING_STR:
  XOR A
  ADD A,$10
  INC HL
__USING_10:
  INC E
  ADD A,D
  LD D,A
__USING_11:
  INC E
  LD C,$00
  DEC B
  JP Z,L5256_0
  LD A,(HL)
  INC HL
  CP '.'
  JP Z,__USING_13
  CP '#'
  JP Z,__USING_11
  CP ','
  JP NZ,__USING_14
  LD A,D
  OR $40
  LD D,A
  JP __USING_11
__USING_12:
  LD A,(HL)
  CP '#'
  LD A,'.'
  JP NZ,__USING_6
  LD C,$01
  INC HL
__USING_13:
  INC C
  DEC B
  JP Z,L5256_0
  LD A,(HL)
  INC HL
  CP '#'
  JP Z,__USING_13
__USING_14:
  PUSH DE
  LD DE,L5256
  PUSH DE
  LD D,H
  LD E,L
  CP '^'
  RET NZ
  CP (HL)
  RET NZ
  INC HL
  CP (HL)
  RET NZ
  INC HL
  CP (HL)
  RET NZ
  INC HL
  LD A,B
  SUB $04
  RET C
  POP DE
  POP DE
  LD B,A
  INC D
  INC HL
  DEFB $CA                ; JP Z,nn  to mask the next 2 bytes

; Routine at 21078
L5256:
  EX DE,HL
  POP DE
; This entry point is used by the routine at __USING.
L5256_0:
  LD A,D
  DEC HL
  INC E
  AND $08
  JP NZ,L5256_2
  DEC E
  LD A,B
  OR A
  JP Z,L5256_2
  LD A,(HL)
  SUB $2D		; '-'
  JP Z,L5256_1
  CP $FE
  JP NZ,L5256_2
  LD A,$08
L5256_1:
  ADD A,$04
  ADD A,D
  LD D,A
  DEC B
L5256_2:
  POP HL
  POP AF
  JP Z,L5256_9
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
  CP $19		;  TK_SPACE_S ?    ('F'?)
  JP NC,FC_ERR			; Err $05 - "Illegal function call"
  LD A,D
  OR $80
  CALL PUFOUT
  CALL PRS
; This entry point is used by the routine at L52F3.
L5256_3:
  POP HL
  DEC HL
  CALL CHRGTB
  SCF
  JP Z,L5256_5
  LD (FLGINP),A
  CP ';'
  JP Z,L5256_4
  CP ','
  JP NZ,SN_ERR
L5256_4:
  CALL CHRGTB
L5256_5:
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
L5256_6:
  LD A,B
  OR A
  JP NZ,__USING_7
  JP L5256_8

; This entry point is used by the routine at __USING.
L5256_7:
  CALL OUTC_SGN
  CALL OUTDO
L5256_8:
  POP HL
  POP AF
  JP NZ,__USING_0
; This entry point is used by the routine at L52F3.
L5256_9:
  CALL C,OUTDO_CRLF
  EX (SP),HL
  CALL GSTRHL
  POP HL
  JP FINPRT

; This entry point is used by the routine at __USING.
L5256_10:
  CALL OUTC_SGN
  DEC B
  LD A,(HL)
  INC HL
  CALL OUTDO
  JP L5256_6
; This entry point is used by the routine at __USING.
L5256_11:
  LD C,$00
  JP L52F3_0
; This entry point is used by the routine at __USING.
L5256_12:
  LD C,$01

; "LD A,n" to Mask the next byte
L52F2:
  DEFB $3E

; Routine at 21235
;
; Used by the routine at __USING.
L52F3:
  POP AF
; This entry point is used by the routine at L5256.
L52F3_0:
  DEC B
  CALL OUTC_SGN
  POP HL
  POP AF
  JP Z,L5256_9
  PUSH BC
  CALL EVAL
  CALL TSTSTR
  POP BC
  PUSH BC
  PUSH HL
  LD HL,(FACCU)
  LD B,C
  LD C,$00
  LD A,B
  PUSH AF
  LD A,B
  OR A
  CALL NZ,__LEFT_S_1
  CALL PRS1
  LD HL,(FACCU)
  POP AF
  OR A
  JP Z,L5256_3
  SUB (HL)
  LD B,A
  LD A,' '
  INC B
L52F3_1:
  DEC B
  JP Z,L5256_3
  CALL OUTDO
  JP L52F3_1

; This entry point is used by the routines at __USING and L5256.
OUTC_SGN:
  PUSH AF
  LD A,D
  OR A
  LD A,'+'
  CALL NZ,OUTDO
  POP AF
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
  JP __EDIT_0


; 'EDIT' BASIC command
__EDIT:
  CALL LNUM_PARM            ;GET THE ARGUMENT LINE NUMBER
  RET NZ                    ;ERROR IF NOT END OF LINE
; This entry point is used by the routine at L52F3.
__EDIT_0:                   ;GET RID OF NEWSTT ADDRESS
  POP HL

; This entry point is used by the routine at NOTDGI.

; Sub-command loop.
; Picks an optional number of repetitions and a command key
EDIT_LOOP:
  EX DE,HL                  ;SAVE CURRENT LINE IN DOT
  LD (DOT),HL               ;FOR LATER EDIT OR LIST
  EX DE,HL                  ;GET BACK LINE # IN [H,L]
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
  CALL NZ,_PRNUM            ;PRINT LINE # IF NOT INLIN EDIT
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
  JP NZ,__EDIT_4            ;IF NOT ZERO (END OF LINE) KEEP COUNTING...
  POP HL                    ;GET BACK POINTER TO LINE
  LD B,A                    ;SET CURRENT LINE POSIT TO ZERO

; Optional number of repetitions of the next subcommand.
DISPED:
  LD D,$00                  ;ASSUME REPITION COUNT IS ZERO
DISPI:
  CALL GETINP               ;GET A CHAR FROM USER
  OR A                      ;IGNORE NULLS
  JP Z,DISPI
  CALL UCASE                ;MAKE UPPER CASE COMMAND
  SUB '0'                   ; convert from ASCII
  JP C,NOTDGI               ;GET RID OF OFFSET
  CP 10                     	;...
  JP NC,NOTDGI
  LD E,A                    ;SAVE CHAR
  LD A,D                    ;GET ACCUM REPITITION
  RLCA                      ;MULTIPLY BY 2
  RLCA                      ;BY 4
  ADD A,D                   ;AND ADD TO GET 5*D
  RLCA                      ;*2 TO GET 10*D
  ADD A,E                   ;ADD DIGIT
  LD D,A                    ;SAVE BACK NEW ACCUM
  JP DISPI                  ;GET NEXT CHAR

; Proceed by typing an Edit Mode subcommand.
;
; Used by the routine at DISPED.
NOTDGI:
  PUSH HL                   ;SAVE TEXT POINTER
  LD HL,DISPED              ;PUT RETURN ADDRESS TO DISPED
  EX (SP),HL                ;ON THE STACK
  DEC D                     ;SEE IF D=0 (REP FACTOR)
  INC D                     ;SET CONDITION CODES
  JP NZ,NOTDGI_0            ;BRANCH AROUND
  INC D                     ;MAKE IT 1
NOTDGI_0:
  CP $08-'0'		        ; TAB:  $08 - '0' = $D8
  JP Z,EDIT_BKSP            
  CP $7F-'0'		        ; DEL:  $7F - '0' = $4F
  JP Z,EDIT_DEL             
  CP $0D-'0'		        ; CR:   $0D - '0' = $DD
  JP Z,EDIT_DONE            
  CP ' '-'0'
  JP Z,EDIT_SPC             
  CP $31			        ;COMMAND IN LOWER CASE?
  JP C,NOTDGI_1
  SUB $20                   ; TO UPPERCASE
NOTDGI_1:
  CP 'Q'-'0'			; 'Q': QUIT?
  JP Z,EDIT_QUIT        ;     IF SO, QUIT & PRINT "OK" OR RETURN TO INLIN
  CP 'L'-'0'
  JP Z,EDIT_BRANCH      ; BRANCH
  CP 'S'-'0'
  JP Z,EDIT_SEARCH      ; SEARCH
  CP 'I'-'0'
  JP Z,EDIT_INSERT      ; INSERT
  CP 'D'-'0'
  JP Z,EDIT_DELETE      ; DELETE
  CP 'C'-'0'
  JP Z,EDIT_CHANGE      ; CHANGE
  CP 'E'-'0'          	;END?
  JP Z,EDIT_EXIT        ; (SAME AS <CR> BUT DOESNT PRINT REST)
  CP 'X'-'0'         	;EXTEND?
  JP Z,EDIT_XTEND       ; GO TO END OF LINE & INSERT
  CP 'K'-'0'          	;KILL??
  JP Z,EDIT_REPLACE     ; (SAME AS "S" BUT DELETES CHARS)
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
  CALL _PR_CHR          ;TYPE CHARACTER
  INC HL                ;MOVE POINTER TO NEXT CHAR
  DEC D                 ;TEST IF DONE WITH REPITITIONS
  JP NZ,EDIT_SPC        ;REPEAT
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
  CALL GETINP           ;GET SEARCH CHAR
  LD E,A                ;SAVE IT
  POP AF
  PUSH AF
  CALL C,TYPSLH         ;TYPE BEGINNING SLASH FOR "K"
EDIT_SEARCH_LP:
  LD A,(HL)
  OR A
  JP Z,EDIT_SEARCH_2
  CALL _PR_CHR          ;TYPE THE CHAR
  POP AF                ;GET KILL FLAG
  PUSH AF               ;SAVE BACK
  CALL C,EDIT_REMOVE    ;DELETE THE CHAR IF K COMMAND.
  JP C,NOTSRC           ;AND DONT MOVE POINTER AS DELCHR ALREADY DID
  INC HL
  INC B                 ;INCREMENT LINE POSIT
NOTSRC:
  LD A,(HL)             ;ARE WE AT END ?
  CP E                  ;ARE CURRENT CHAR & SEARCH
  JP NZ,EDIT_SEARCH_LP  ;CHAR THE SAME? IF NOT, LOOK MORE
  DEC D                 ;LOOK FOR N MATCHES
  JP NZ,EDIT_SEARCH_LP  ;IF NOT 0, KEEP LOOKING
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
  CALL _PR_CHR
DELLP:
  LD A,(HL)             ;GET CHAR FROM LINE
  OR A                  ;ARE WE AT END?
  JP Z,TYPSLH           ;TYPE SLASH
  CALL _PR_CHR          ;TYPE CHAR WE'RE GOING TO DELETE
  CALL EDIT_REMOVE      ;DELETE CURRENT CHAR
  DEC D                 ;DECREMENT DELETE COUNT
  JP NZ,DELLP           ;KEEP DOING IT
TYPSLH:                 
  LD A,'\\'             ;TYPE ENDING SLASH
  CALL OUTDO
  RET

EDIT_CHANGE:
  LD A,(HL)             ;ARE WE AT END OF LINE?
  OR A                  ;SEE IF 0
  RET Z                 ;RETURN
EDIT_CHANGE_0:
  CALL GETINP
  CP ' '                ;IS IT CONTROL CHAR?
  JP NC,NOTCCC          ;NO
  CP $0A                ;IS IT LF?
  JP Z,NOTCCC           ;YES
  CP $07                ;OR BELL?
  JP Z,NOTCCC           ;OK
  CP $09                ;OR TAB?
  JP Z,NOTCCC           ;OK
  LD A,$07              ;GET BELL
  CALL OUTDO            ;SEND IT
  JP EDIT_CHANGE_0      ;RETRY

NOTCCC:
  LD (HL),A             ;SAVE IN MEMORY
  CALL _PR_CHR          ;ECHO THE CHAR WERE USING TO REPLACE
  INC HL                ;BUMP POINTER
  INC B                 ;INCREMENT POSITION WITHIN LINE
  DEC D                 ;ARE WE DONE CHANGING?
  JP NZ,EDIT_CHANGE     ;IF NOT, CHANGE SOME MORE.
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
  CALL GETINP           ;GET CHAR TO INSERT
  CP $7F                ;DELETE??
  JP Z,TYPARW           ;YES, ACT LIKE "_"
  CP $08                ;Backspace?
  JP Z,TYPARW_0         ;Do delete
  CP $0D                ;IS IT A CARRIAGE RETURN?
  JP Z,EDIT_DONE        ;DONT INSERT, AND SIMULATE <CR>
  CP $1B                ;IS IT ESCAPE?
  RET Z                 ;IF SO, DONE.
  CP $08                ;BACKSPACE?
  JP Z,TYPARW_0         ;TYPE BACKARROW AND DELETE
  CP $0A                ;LINE FEED?
  JP Z,NTARRW           ;ALLOW IT
  CP $07                ;BELL?
  JP Z,NTARRW           ;ALLOW IT
  CP $09                ;TAB?
  JP Z,NTARRW           ;ALLOW IT
  CP ' '                ;IS IT ILLEGAL CHAR
  JP C,EDIT_INSERT      ;TOO SMALL
  CP '_'                ;DELETE PREVIOUS CHAR INSERTED?
  JP NZ,NTARRW          ;IF NOT, JUMP AROUND NEXT CODE

TYPARW:
  LD A,'_'              ;TYPE IT
TYPARW_0:
  DEC B                 ;ARE WE AT START OF LINE?
  INC B                 ;LETS SEE
  JP Z,DINGI            ;IF SO, TYPE DING.
  CALL _PR_CHR          ;TYPE THE BACK ARROW
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
  JP EDIT_REMOVE_LP     ;KEEP CRUNCHING

NTARRW:
  PUSH AF               ;SAVE THE CHAR TO BE INSERTED
  LD A,C                ;GET LENGTH OF LINE

; If an attempt is made to insert a character that will make the line longer than
; 255 characters, a bell (Control-G) is typed and the character is not printed.
  CP BUFLEN             ;SEE IF WE ARENT TRYING TO MAKE LINE TOO LONG
  JP C,EDIT_INS_CH      ;IF LENGTH OK, GO INSERT
  POP AF                ;GET THE UNLAWFUL CHAR
DINGI:
  LD A,$07              ;TYPE A BELL TO LET USER KNOW
  CALL OUTDO            ;IT ALL OVER

EDIT_INSERT_LP:
  JP EDIT_INSERT        ;HE HAS TO TYPE <ESC> TO GET OUT

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
  CALL _PR_CHR          ;TYPE THE CHAR
  INC HL                ;POINT TO NEXT CHAR
  JP EDIT_INSERT_LP    	;AND GO GET MORE CHARS


EDIT_BKSP:
  LD A,B                ;ARE WE MOVING BACK PAST THE
  OR A                  ;FIRST CHARACTER
  RET Z                 ;DON'T ALLOW IT
  DEC HL                ;MOVE CHAR POINTER BACK
  LD A,$08              
  CALL _PR_CHR          ;ECHO IT
  DEC B                 ;CHANGE CURRENT POSITION
  DEC D                 ;ARE WE DONE MOVING BACK?
  JP NZ,EDIT_DEL        ;IF NOT, GO BACK MORE
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
  CALL _PR_CHR          ;ECHO IT
  DEC D                 ;ARE WE DONE MOVING BACK?
  JP NZ,EDIT_DEL        ;IF NOT, GO BACK MORE
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


; Routine at 21850
;
; Used by the routines at PROMPT and L4F11.
MOVUP:
  CALL ENFMEM             ; See if enough memory
; This entry point is used by the routines at L46AB, NOTDGI and SCNEND.
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
  JP MOVLP                ; Loop until all bytes moved

; Check for C levels of stack
;
; Used by the routines at FORFND, __GOSUB, EVAL, DOFN, __CALL, SBSCPT and
; BSOPRND_0.
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
  JP C,OM_ERR             ; Not enough - ?OM Error
  ADD HL,SP               ; Test if stack is overflowed
  POP HL                  ; Restore code string address
  RET C                   ; Return if enough mmory
; This entry point is used by the routines at LOAD_OM_ERR, BSOPRND_0, __CLEAR
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
; Used by the routines at BSOPRND_0, MOVUP and DONCMD.
ENFMEM:
  CALL REALLY             ;ENOUGH SPACE BETWEEN STRING & STACK
  RET NC                  ;YES
  LD A,(CHNFLG)
  OR A
  JP NZ,_OM_ERR
  PUSH BC                 ;SAVE ALL REGS
  PUSH DE
  PUSH HL
  CALL GARBGE             ;DO A GARBAGE COLLECTION
  POP HL                  ;RESTORE ALL REGS
  POP DE
  POP BC
  CALL REALLY             ;ENOUGH SPACE THIS TIME?
  RET NC                  ;YES
  JP _OM_ERR              ;NO, GIVE "OUT OF MEMORY BUT DONT TOUCH STACK

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
; Used by the routine at _READY.
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
  DEC B
  JP NZ,LOPNTO            ;LOOP UNTIL DONE
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
RUN_FST:
  LD HL,(TXTTAB)          ;POINT AT THE START OF TEXT
  DEC HL

; This entry point is used by the routines at ATOH and CLVAR.
_CLVAR:
  LD (TEMP),HL            ; Save code string address in TEMP
  LD A,(MRGFLG)           ;DOING A CHAIN MERGE?
  OR A                    ;TEST
  JP NZ,LEVDTB            ;LEAVE DEFAULT TABLE ALONE
  XOR A
  LD (OPTBASE_FLG),A      ;INDICATE NO "OPTION" HAS BEEN SEEN
  LD (OPTBASE),A          ;DEFAULT TO "OPTION BASE 0"
  LD B,26                 ;INITIALIZE THE DEFAULT VALTYPE TABLE
  LD HL,DEFTBL            ;POINT AT THE FIRST ENTRY
LOPDFT:
  LD (HL),$04             ;LOOP 26 TIMES STORING A DEFAULT VALTYP
  INC HL                  ;FOR SINGLE PRECISION
  DEC B                   ;COUNT OFF THE LETTERS
  JP NZ,LOPDFT            ;LOOP BACK, AND SETUP THE REST OF THE TABLE
  
LEVDTB:
  LD DE,RND_CONST         ;RESET THE RANDOM NUMBER GENERATOR
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
  LD (ONELIN),HL
  LD (OLDTXT),HL          ;MAKE CONTINUING IMPOSSIBLE
  LD HL,(MEMSIZ)
  LD A,(CHNFLG)           ;ARE WE CHAINING?
  OR A                    ;TEST
  JP NZ,GOOD_FRETOP       ;FRETOP IS GOOD, LEAVE IT ALONE
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
  CALL FINLPT           ; "FINLPT"
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
  LD HL,(TEMP)            ;Restore code string address
  RET

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at BAKSTK, _ERROR_REPORT, PROMPT, SRCHLP, __FOR, ATOH,
; __GOTO, __LET, DOFN, __LIST, __DELETE, __RENUM, __OPTION, MULTEN,
; DECDIV_SUB, __LOAD, __MERGE, __FIELD, __LSET, __WEND, __CHAIN, L45C9,
; CHAIN_ALL, L46AB, __GET, L4F11, SBSCPT, ZERARY, MOVUP, ENFMEM, __TROFF,
; __ERASE, __CLEAR, __NEXT, TSTOPL_0, GRBDON, GRBLP, ARRLP, GRBARY, STRADD,
; GSTRDE, FRETMS and FN_INSTR.
DCOMPR:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; Check syntax, 1 byte follows to be compared
;
; Used by the routines at LNUM_RANGE, __FOR, FORFND, __LET, __ON, __AUTO, __IF,
; DOTAB, __LINE, __INPUT, __READ, NEXT_EQUAL, OPNPAR, __ERL, EVLPAR,
; OPRND_3, DEF_USR, __DEF, DOFN, CHEKFN, __WAIT, SETIO, __POKE, __RENUM,
; __OPTION, LOOK_FOR, __NAME, __OPEN, GET_CHNUM, __LOAD, __MERGE, __FIELD,
; FN_INPUT, __CALL, __CHAIN, L45C9, L46AB, DIMRET, __USING, __TROFF, __CLEAR,
; FN_STRING, LFRGNM, FN_INSTR, MID_ARGSEP and INIT.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
IF ORIGINAL
  JP NZ,SYNCHR_0
ELSE
  JP NZ,SN_ERR
ENDIF
  INC HL
  EX (SP),HL
  INC HL            ;LOOK AT NEXT CHAR
  LD A,(HL)         ;GET IT
  CP ':'            ;IS IT END OF STATMENT OR BIGGER
  RET NC
  JP CHRGTB_1       ;REST OF CHRGET

IF ORIGINAL
SYNCHR_0:
  JP SN_ERR
ENDIF

; This entry point is used by the routine at __NEW.
__RESTORE:
  EX DE,HL
  LD HL,(TXTTAB)
  JP Z,BGNRST       ;RESTORE DATA POINTER TO BEGINNING OF PROGRAM
  EX DE,HL          ;TEXT POINTER BACK TO [H,L]
  CALL ATOH         ;GET THE FOLLOWING LINE NUMBER
  PUSH HL           ;SAVE TEXT POINTER
  CALL SRCHLN       ;FIND THE LINE NUMBER
  LD H,B            ;GET POINTER TO LINE in HL
  LD L,C
  POP DE            ;TEXT POINTER BACK TO [D,E]
  JP NC,UL_ERR      ;SHOULD HAVE FOUND LINE

BGNRST:
  DEC HL            ;INITIALIZE DATPTR TO [TXTTAB]-1

; This entry point is used by the routine at LTSTND.
UPDATA:
  LD (DATPTR),HL    ;READ FINISHES COME TO RESFIN
  EX DE,HL          ;GET THE TEXT POINTER BACK
  RET

; 'STOP' BASIC command
;
; Used by the routine at STALL.
__STOP:
  RET NZ            ;RETURN IF NOT CONTROL-C AND MAKE
  INC A             ;SURE "STOP" STATEMENTS HAVE A TERMINATOR
  JP __END_0

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
; Used by the routines at __LINE, INPUT_SUB and __RANDOMIZE.
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
  JP Z,NOLIN              ; Yes - No line number
  LD (OLDLIN),HL          ; Save line of break
  LD HL,(SAVTXT)          ; Get point of break
  LD (OLDTXT),HL          ; Save point to CONTinue
NOLIN:
  XOR A
  LD (CTLOFG),A           ; Enable output
  CALL FINLPT           ; Disable printer echo if enabled
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
  JP NZ,NTCTCT
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
  EX DE,HL                ; ???
  EX DE,HL                ; ???  ...useless
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
  CALL FP2HL              ;SWPTMP=VALUE #1
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
  JP NZ,FCERR             ;IF ITS CHANGED, ERROR
  POP DE                  ;[D,E]=POINTER AT VALUE #2
  POP HL                  ;[H,L]=TEXT POINTER
  EX (SP),HL              ;SAVE THE TEXT POINTER ON THE STACK, [H,L]=POINTER AT VALUE #1
  PUSH DE                 ;SAVE THE POINTER AT VALUE #2
  CALL FP2HL              ;TRANSFER VALUE #2 INTO VALUE #1'S OLD POSITION
  POP HL                  ;[H,L]=POINTER AT VALUE #2
  LD DE,SWPTMP            ;LOCATION OF VALUE #1
  CALL FP2HL              ;TRANSFER SWPTMP=VALUE #1 INTO VALUE #2'S OLD POSITION
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
  JP NZ,FCERR             ;PTRGET DID NOT FIND VARIABLE!
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
  JP NZ,__ERASE_LP        ;MOVE THE REST
  DEC BC                   
  LD H,B                  ;SETUP THE NEW STORAGE END POINTER
  LD L,C
  LD (STREND),HL
  POP HL                  ;GET BACK THE TEXT POINTER
  LD A,(HL)               ;SEE IF MORE ERASURES NEEDED
  CP ','                  ;ADDITIONAL VARIABLES DELIMITED BY COMMA
  RET NZ                  ;ALL DONE IF NOT
  CALL CHRGTB
  JP __ERASE

; This entry point is used by the routine at __LOF.
POPAHT:
  POP AF
  POP HL                  ;GET THE TEXT POINTER
  RET

; Load A with char in (HL) and check it is a letter:
;
; Used by the routines at DEFCON and GETVAR.
IS_ALPHA:
  LD A,(HL)

; Check char in 'A' being in the 'A'..'Z' range
;
; Used by the routines at CRNCLP, NOTRES, OPRND, HEXTFP, LISPRT and GETVAR.
; Check char in 'A' being in the 'A'..'Z' range
IS_ALPHA_A:
  CP 'A'            ; < "A" ?
  RET C             ; Carry set if not letter
  CP 'Z'+1          ; > "Z" ?
  CCF               
  RET               ; Carry set if not letter

; Routine at 22454
;
; Used by the routine at __CLEAR.
CLVAR:
  JP _CLVAR

; 'CLEAR' BASIC command
;
; To set all numeric variables to zero and all string variables to null; and, optionally,
; to set the end of memory and the amount of stack space.
;
; CLEAR [,[<expressionl>] [,<expression2>]]
__CLEAR:
  JP Z,CLVAR              ;IF NO FORMULA JUST CLEAR
  CP ','                  ;ALLOW NO STRING SPACE
  JP Z,__CLEAR_0
  CALL GET_POSINT_0       ;GET AN INTEGER INTO [D,E]
  DEC HL
  CALL CHRGTB             ; Get next character, SEE IF ITS THE END
  JP Z,CLVAR

__CLEAR_0:
  CALL SYNCHR
  DEFM ","
  JP Z,CLVAR
  EX DE,HL
  LD HL,(STKTOP)          ;GET HIGHEST ADDRESS
  EX DE,HL
  CP ','
  JP Z,__CLEAR_1          ;SHOULD FINISH THERE
  CALL POSINT             ; Get integer to DE
__CLEAR_1:
  DEC HL                  ; Cancel increment   (BACK UP)
  CALL CHRGTB             ;GET CHAR
  PUSH DE                 ;SAVE NEW HIGH MEM
  JP Z,__CLEAR_3          ;USE SAME STACK SIZE
  CALL SYNCHR             ; Check for comma
  DEFM ","
  JP Z,__CLEAR_3
  CALL POSINT             ; Get integer to DE
  DEC HL                  ; Cancel increment
  CALL CHRGTB             ; Get next character
  JP NZ,SN_ERR            ; ?SN Error if more on line

__CLEAR_2:
  EX (SP),HL              ; Save code string address
  PUSH HL                 ; Save code string address (again)
  LD HL,0+(NUMLEV*2)+20   ; CHECK STACK SIZE IS REASONABLE
  CALL DCOMPR
  JP NC,OMERR
  POP HL                  ; Restore code string address (1st copy)
  CALL SUBDE              ; SUBTRACT [H,L]-[D,E] INTO [D,E]
  JP C,OMERR              ; WANTED MORE THAN TOTAL!

  PUSH HL                 ; Save RAM top
  LD HL,(VARTAB)          ; Get program end
  LD BC,20                ; 20 Bytes minimum working RAM (LEAVE BREATHING ROOM)
  ADD HL,BC               ; Get lowest address
  CALL DCOMPR             ; Enough memory?
  JP NC,OMERR             ; No - ?OM Error
  EX DE,HL                ; RAM top to HL
  LD (MEMSIZ),HL          ; Set new string space
  POP HL                  ; End of memory to use
  LD (STKTOP),HL          ; Set new top of RAM
  POP HL                  ; Restore code string address
  JP CLVAR                ; Initialise variables


POSINT:
  CALL GETWORD            ; Get integer
  LD A,D
  OR E
  JP Z,FC_ERR
  RET

OMERR:
  JP OM_ERR


__CLEAR_3:
  PUSH HL
  LD HL,(STKTOP)
  EX DE,HL
  LD HL,(MEMSIZ)
  LD A,E
  SUB L
  LD E,A
  LD A,D
  SBC A,H
  LD D,A
  POP HL
  JP __CLEAR_2

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
  CALL PHLTFP             ; STEP VALUE INTO THE FAC
  EX (SP),HL              ; PUT THE POINTER INTO THE FOR ENTRY ONTO THE STACK
  PUSH HL                 ; PUT THE POINTER TO THE LOOP VARIABLE BACK ONTO THE STACK
  LD A,(NEXFLG)           ; IS "FOR" USING "NEXT"
  OR A
  JP NZ,NXTDO             ; NO, CONTINUE "NEXT"
  LD HL,FVALSV            ; FETCH THE INITIAL VALUE INTO THE FAC
  CALL PHLTFP
  XOR A                   ; CONTINUE THE "NEXT" WITH INITIAL VALUE

NXTDO:
  CALL NZ,FADD_HLPTR
  POP HL                  ; POP OFF THE POINTER TO THE LOOP VARIABLE
  CALL FPTHL              ; MOV FAC INTO LOOP VARIABLE
  POP HL                  ; GET THE ENTRY POINTER
  CALL LOADFP             ; GET THE FINAL INTO THE REGISTERS
  PUSH HL                 ; SAVE THE ENTRY POINTER
  CALL FCOMP              ; COMPARE THE NUMBERS RETURNING $FF IF FAC IS LESS THAN THE REGISTERS,
                          ; 0 IF EQUAL, OTHERWISE 1
  JP __NEXT_6             ; SKIP OVER INTEGER CODE

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
  JP NZ,INXTDO            ; NO, JUST CONTINUE NEXT
  LD HL,(FVALSV)          ; GET THE INITIAL VALUE
  JP IFORIN               ; CONTINUE FIRST ITERATION CHECK

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
  JP Z,KILFOR             ; IF SIGN(FINAL-CURRENT)+SIGN(STEP)=0, then loop finished - Terminate it
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

; Tests if I/O to device is taking place
;
; Used by the routines at PRNTST, PRNTNB, __TAB, DOTAB, __READ, __LIST, OUTDO,
; L4D05 and OUTDO_CRLF.
ISFLIO:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  POP HL
  RET


; String evaluation
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
  JP Z,EVAL_STR_0
  CCF
  JP EVAL_RESULT

; 'OCT$' BASIC function
__OCT_S:
  CALL OCT_STR
  JP __STR_S_0

; 'HEX$' BASIC function
__HEX_S:
  CALL HEX_STR
  JP __STR_S_0

; 'STR$' BASIC function
__STR_S:
  CALL FOUT               ; Turn number into text
; This entry point is used by the routines at __OCT_S and __HEX_S.
__STR_S_0:
  CALL CRTST              ; Create string entry for it
  CALL GSTRCU             ; Current string to pool

; Save string in string area
SAVSTR:
  LD BC,TOPOOL            ; Save in string pool
  PUSH BC                 ; Save address on stack
; This entry point is used by the routines at __LET, DOFN, L46AB and FN_INSTR.
STRCPY:
  LD A,(HL)               ; Get string length
  INC HL
  PUSH HL                 ; Save pointer to string
  CALL TESTR              ; See if enough string space
  POP HL                  ; Restore pointer to string
  LD C,(HL)               ; Get LSB of address
  INC HL
  LD B,(HL)               ; Get MSB of address
  CALL CRTMST             ; Create string entry
  PUSH HL                 ; Save pointer to MSB of addr
  LD L,A                  ; Length of string
  CALL TOSTRA             ; Move to string area
  POP DE                  ; Restore pointer to MSB
  RET
; This entry point is used by the routines at L4DC7 and __CHR_S.
MK_1BYTE_TMST:
  LD A,$01

; Make temporary string
;
; Used by the routines at __MKD_S, __LSET, FN_INPUT, CONCAT and __SPACE_S.
MKTMST:
  CALL TESTR              ; See if enough string space

; Create temporary string entry
;
; Used by the routines at SAVSTR, DTSTR and ALLFOL.
CRTMST:
  LD HL,DSCTMP            ; Temporary string
  PUSH HL                 ; Save it
  LD (HL),A               ; Save length of string
  INC HL
  LD (HL),E               ; Save LSB of address
  INC HL
  LD (HL),D               ; Save MSB of address
  POP HL                  ; Restore pointer
  RET

; Create String
;
; Used by the routines at __PRINT, L46AB, __STR_S and PRS.
CRTST:
  DEC HL                  ; DEC - INCed after

; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,'"'                ; Terminating quote
; This entry point is used by the routine at __LINE.
QTSTR_0:
  LD D,B                  ; Quote to D

; Create String, termination char in D
;
; Used by the routines at __READ and LINE_INPUT.
DTSTR:
  PUSH HL                 ; Save start
  LD C,$FF                ; Set counter to -1
DTSTR_0:
  INC HL                  ; Move on
  LD A,(HL)               ; Get byte
  INC C                   ; Count bytes
  OR A                    ; End of line?
  JP Z,DTSTR_1            ; Yes - Create string entry
  CP D                    ; Terminator D found?
  JP Z,DTSTR_1            ; Yes - Create string entry
  CP B                    ; Terminator B found?
  JP NZ,DTSTR_0           ; No - Keep looking
DTSTR_1:
  CP '"'                  ; End with '"'?
  CALL Z,CHRGTB           ; Yes - Get next character
  PUSH HL
  LD A,B
  CP ','
  JP NZ,DTSTR_3
  INC C
DTSTR_2:
  DEC C
  JP Z,DTSTR_3
  DEC HL
  LD A,(HL)
  CP ' '
  JP Z,DTSTR_2
DTSTR_3:
  POP HL
  EX (SP),HL              ; Starting quote
  INC HL                  ; First byte of string
  EX DE,HL                ; To DE
  LD A,C                  ; Get length
  CALL CRTMST             ; Create string entry

; Temporary string to pool
;
; Used by the routines at __LSET, FN_INPUT, CONCAT, TOPOOL and ALLFOL.
TSTOPL:
  LD DE,DSCTMP            ; Temporary string
  DEFB $3E                ; "LD A,n" to Mask the next byte

; TSTOPL_0
;
; Used by the routine at DOFN.
TSTOPL_0:
  PUSH DE
  LD HL,(TEMPPT)          ; Temporary string pool pointer
  LD (FACCU),HL           ; Save address of string ptr
  LD A,$03
  LD (VALTYP),A           ; Set type to string
  CALL FP2HL              ; Move string to pool
  LD DE,FRETOP
  CALL DCOMPR             ; Out of string pool?
  LD (TEMPPT),HL          ; Save new pointer
  POP HL                  ; Restore code string address
  LD A,(HL)               ; Get next code byte
  RET NZ                  ; Return if pool OK
  LD DE,$0010             ; Err $10 - "String formula too complex"
  JP ERROR

; Print number string
PRNUMS:
  INC HL

; Create string entry and print it
;
; Used by the routines at _ERROR_REPORT, L184B, __DELETE, _LINE2PTR,
; __RANDOMIZE, LNUM_MSG, L4D05, L5256 and DONCMD.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routines at PRNTNB, __INPUT, L46AB and L52F3.
PRS1:
  CALL GSTRCU
  CALL LOADFP_0
  INC D
PRS1_0:
  DEC D
  RET Z
  LD A,(BC)
  CALL OUTDO
  CP $0D
  CALL Z,CRLF_DONE
  INC BC
  JP PRS1_0

; Test if enough room for string
;
; Used by the routines at __LSET, SAVSTR, MKTMST and ALLFOL.
TESTR:
  OR A
  DEFB $0E                ; "LD C,n" to Mask the next byte

; GRBDON: Garbage Collection Done
GRBDON:
  POP AF
  PUSH AF                 ; Save status
  LD HL,(STREND)          ; Bottom of string space in use
  EX DE,HL                ; To DE
  LD HL,(FRETOP)          ; Bottom of string area
  CPL                     ; Negate length (Top down)
  LD C,A                  ; -Length to BC
  LD B,$FF                ; BC = -ve length of string
  ADD HL,BC               ; Add to bottom of space in use
  INC HL                  ; Plus one for 2's complement
  CALL DCOMPR             ; Below string RAM area?
  JP C,TESTOS             ; Tidy up if not done else err
  LD (FRETOP),HL          ; Save new bottom of area
  INC HL                  ; Point to first byte of string
  EX DE,HL                ; Address to DE
; This entry point is used by the routines at LISPRT and CHPUT.
POPAF:
  POP AF                  ; Throw away status push
  RET

; Garbage Collection: Tidy up if not done else err
;
; Used by the routine at GRBDON.
TESTOS:
  POP AF                  ; Garbage collect been done?
  LD DE,$000E             ; Err $0E - "Out of string space"
  JP Z,ERROR              ; Yes - Not enough string apace
  CP A                    ; Flag garbage collect done
  PUSH AF                 ; Save status
  LD BC,GRBDON            ; Garbage collection done
  PUSH BC                 ; Save for RETurn

; Garbage collection
;
; Used by the routines at L46AB, ENFMEM and __FRE.
GARBGE:
  LD HL,(MEMSIZ)          ; Get end of RAM pointer
; This entry point is used by the routine at SCNEND.
GARBLP:
  LD (FRETOP),HL          ; Reset string pointer
  LD HL,$0000
  PUSH HL                 ; Flag no string found
  LD HL,(STREND)          ; Get bottom of string space
  PUSH HL                 ; Save bottom of string space
  LD HL,TEMPST            ; Temporary string pool

; Routine at 23075
GRBLP:
  EX DE,HL
  LD HL,(TEMPPT)          ; Temporary string pool pointer
  EX DE,HL
  CALL DCOMPR             ; Temporary string pool done?
  LD BC,GRBLP             ; Loop until string pool done
  JP NZ,STPOOL            ; No - See if in string area
  LD HL,PRMPRV            ; Start of simple variables
  LD (TEMP9),HL
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)
SMPVAR:
  EX DE,HL
  LD HL,(ARYTA2)          ; End of simple variables
  EX DE,HL
  CALL DCOMPR             ; All simple strings done?
  JP Z,GRB_STARY          ; Yes - Do string arrays
  LD A,(HL)               ; Get type of variable
  INC HL
  INC HL
  INC HL
  PUSH AF                 ; Save type of variable
  CALL ARR_GET
  POP AF                  ; Restore type of variable
  CP $03
  JP NZ,GRB_NOSTR
  CALL STRADD             ; Add if string in string area
  XOR A
GRB_NOSTR:
  LD E,A
  LD D,$00
  ADD HL,DE
  JP SMPVAR               ; Loop until simple ones done

GRB_STARY:
  LD HL,(TEMP9)
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  LD HL,(ARYTAB)
  JP Z,ARRLP
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
  JP SMPVAR

; Move to next array
;
; Used by the routine at ARRLP.
GNXARY:
  POP BC                  ; Scrap address of this array

; Routine at 23174
;
; Used by the routines at GRBLP and GRBARY.
ARRLP:
  EX DE,HL
  LD HL,(STREND)          ; End of string arrays
  EX DE,HL
  CALL DCOMPR             ; All string arrays done?
  JP Z,SCNEND             ; Yes - Move string if found
  LD A,(HL)               ; Get type of array
  INC HL
  PUSH AF                 ; Save type of array
  INC HL
  INC HL
  CALL ARR_GET           ; Get next
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  POP AF                  ; Restore type of array
  PUSH HL                 ; Save address of num of dim'ns
  ADD HL,BC               ; Start of next array
  CP $03                  ; Test type of array
  JP NZ,GNXARY            ; Numeric array - Ignore it
  LD (TEMP8),HL           ; Save address of next array
  POP HL                  ; Get address of num of dim'ns
  LD C,(HL)               ; BC = Number of dimensions
  LD B,$00
  ADD HL,BC               ; Two bytes per dimension size
  ADD HL,BC
  INC HL                  ; Plus one for number of dim'ns

; Routine at 23215
GRBARY:
  EX DE,HL                ; Get address of next array
  LD HL,(TEMP8)
  EX DE,HL                ; Is this array finished?
  CALL DCOMPR             ; Yes - Get next one
  JP Z,ARRLP              ; Loop until array all done
  LD BC,GRBARY

; Routine at 23229
;
; Used by the routine at GRBLP.
STPOOL:
  PUSH BC                 ; Save return address

; Routine at 23230
;
; Used by the routine at GRBLP.
STRADD:
  XOR A
  OR (HL)                 ; Get string length
  INC HL
  LD E,(HL)               ; Get LSB of string address
  INC HL
  LD D,(HL)               ; Get MSB of string address
  INC HL
  RET Z
  LD B,H
  LD C,L
  LD HL,(FRETOP)          ; Bottom of new area
  CALL DCOMPR             ; String been done?
  LD H,B                  ; Restore variable pointer
  LD L,C
  RET C                   ; String done - Ignore
  POP HL                  ; Return address
  EX (SP),HL              ; Lowest available string area
  CALL DCOMPR             ; String within string area?
  EX (SP),HL              ; Lowest available string area
  PUSH HL                 ; Re-save return address
  LD H,B                  ; Restore variable pointer
  LD L,C
  RET NC                  ; Outside string area - Ignore
  POP BC                  ; Get return , Throw 2 away
  POP AF
  POP AF
  PUSH HL                 ; Save variable pointer
  PUSH DE                 ; Save address of current
  PUSH BC                 ; Put back return address
  RET                     ; Go to it

; All string arrays done, now move string
;
; Used by the routine at ARRLP.
SCNEND:
  POP DE                  ; Addresses of strings
  POP HL
  LD A,H                  ; HL = 0 if no more to do
  OR L
  RET Z                   ; No more to do - Return
  DEC HL
  LD B,(HL)               ; MSB of address of string
  DEC HL
  LD C,(HL)               ; LSB of address of string
  PUSH HL                 ; Save variable address
  DEC HL
  LD L,(HL)               ; HL = Length of string
  LD H,$00
  ADD HL,BC               ; Address of end of string+1
  LD D,B                  ; String address to DE
  LD E,C
  DEC HL                  ; Last byte in string
  LD B,H                  ; Address to BC
  LD C,L
  LD HL,(FRETOP)          ; Current bottom of string area
  CALL MOVSTR             ; Move string to new address
  POP HL                  ; Restore variable address
  LD (HL),C               ; Save new LSB of address
  INC HL
  LD (HL),B               ; Save new MSB of address
  LD H,B                  ; Next string area+1 to HL
  LD L,C
  DEC HL                  ; Next string area address
  JP GARBLP               ; Look for more strings

; String concatenation
;
; Used by the routine at _EVAL.
CONCAT:
  PUSH BC                 ; Save prec' opr & code string
  PUSH HL
  LD HL,(FACCU)           ; Get first string
  EX (SP),HL              ; Save first string
  CALL OPRND              ; Get second string
  EX (SP),HL              ; Restore first string
  CALL TSTSTR             ; Make sure it's a string
  LD A,(HL)               ; Get length of second string
  PUSH HL                 ; Save first string
  LD HL,(FACCU)           ; Get second string
  PUSH HL                 ; Save second string
  ADD A,(HL)              ; Add length of second string
  LD DE,$000F             ; Err $0F - "String too long"
  JP C,ERROR              ; String too long - Error
  CALL MKTMST             ; Make temporary string
  POP DE                  ; Get second string to DE
  CALL GSTRDE             ; Move to string pool if needed
  EX (SP),HL              ; Get first string
  CALL GSTRHL             ; Move to string pool if needed
  PUSH HL                 ; Save first string
  LD HL,(TMPSTR)          ; Temporary string address
  EX DE,HL                ; To DE
  CALL SSTSA              ; First string to string area
  CALL SSTSA              ; Second string to string area
  LD HL,EVAL2             ; Return to evaluation loop
  EX (SP),HL              ; Save return,get code string
  PUSH HL                 ; Save code string address
  JP TSTOPL               ; To temporary string to pool

; Move string on stack to string area
;
; Used by the routine at CONCAT.
SSTSA:
  POP HL                  ; Return address
  EX (SP),HL              ; Get string block,save return
  LD A,(HL)               ; Get length of string
  INC HL
  LD C,(HL)               ; Get LSB of string address
  INC HL
  LD B,(HL)               ; Get MSB of string address
  LD L,A                  ; Length to L

; Move string in BC, (len in L) to string area
;
; Used by the routines at SAVSTR and ALLFOL.
TOSTRA:
  INC L                   ; INC - DECed after

; TOSTRA loop
TSALP:
  DEC L                   ; Count bytes moved
  RET Z                   ; End of string - Return
  LD A,(BC)               ; Get source
  LD (DE),A               ; Save destination
  INC BC                  ; Next source
  INC DE                  ; Next destination
  JP TSALP                ; Loop until string moved

; Get string pointed by FPREG 'Type Error' if it is not
;
; Used by the routines at FNAME, __OPEN, __CVD, __LSET, EVAL_STR, __LEN and
; FN_INSTR.
GETSTR:
  CALL TSTSTR             ; Make sure it's a string

; Get string pointed by FPREG
;
; Used by the routines at INPUT_SUB, FN_USR, __STR_S, PRS1 and __FRE.
GSTRCU:
  LD HL,(FACCU)           ; Get current string

; Get string pointed by HL
;
; Used by the routines at L5256, CONCAT and FN_INSTR.
GSTRHL:
  EX DE,HL                ; Save DE

; Get string pointed by DE
;
; Used by the routines at EVAL_STR, CONCAT and ALLFOL.
GSTRDE:
  CALL FRETMS             ; Was it last tmp-str?
  EX DE,HL                ; Restore DE
  RET NZ                  ; No - Return
  PUSH DE                 ; Save string
  LD D,B                  ; String block address to DE
  LD E,C
  DEC DE                  ; Point to length
  LD C,(HL)               ; Get string length
  LD HL,(FRETOP)          ; Current bottom of string area
  CALL DCOMPR             ; Last one in string area?
  JP NZ,POPHL             ; No - Return
  LD B,A                  ; Clear B (A=0)
  ADD HL,BC               ; Remove string from str' area
  LD (FRETOP),HL          ; Save new bottom of str' area
POPHL:
  POP HL                  ; Restore string
  RET

; Get temporary string pool top
;
; Used by the routines at __LET and GSTRDE.
; a.k.a BAKTMP
FRETMS:
  LD HL,(TEMPPT)          ; Back
  DEC HL                  ; Get MSB of address
  LD B,(HL)               ; Back
  DEC HL                  ; Get LSB of address
  LD C,(HL)               ; Back
  DEC HL                  ; Back
  CALL DCOMPR             ; String last in string pool?
  RET NZ                  ; Yes - Leave it
  LD (TEMPPT),HL          ; Save new string pool top
  RET

; 'LEN' BASIC function
__LEN:
  LD BC,PASSA             ; To return integer A
  PUSH BC                 ; Save address
; This entry point is used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR             ; Get string and its length
  XOR A
  LD D,A                  ; Clear D
  LD A,(HL)               ; Get length of string
  OR A                    ; Set status flags
  RET

; 'ASC' BASIC function
__ASC:
  LD BC,PASSA             ; To return integer A
  PUSH BC                 ; Save address
; This entry point is used by the routine at FN_STRING.
__ASC_0:
  CALL GETLEN             ; Get length of string
  JP Z,FC_ERR             ; Null string - Error
  INC HL
  LD E,(HL)               ; Get LSB of address
  INC HL
  LD D,(HL)               ; Get MSB of address
  LD A,(DE)               ; Get first byte of string
  RET

; 'CHR$' BASIC function
__CHR_S:
  CALL MK_1BYTE_TMST      ; Make One character temporary string
  CALL MAKINT             ; Make it integer A
; This entry point is used by the routine at L4DC7.
__CHR_S_0:
  LD HL,(TMPSTR)          ; Get address of string
  LD (HL),E               ; Save character

; Save in string pool
;
; Used by the routines at __MKD_S and __SPACE_S.
TOPOOL:
  POP BC                  ; Clean up stack
  JP TSTOPL               ; Temporary string to pool

; Routine at 23467
;
; Used by the routine at OPRND_MORE.
FN_STRING:
  CALL CHRGTB
  CALL SYNCHR
  DEFM "("
  CALL GETINT             ; Get integer 0-255
  PUSH DE
  CALL SYNCHR
  DEFM ","
  CALL EVAL
  CALL SYNCHR
  DEFM ")"
  EX (SP),HL
  PUSH HL
  CALL GETYPR           ; Get the number type (FAC)
  JP Z,FN_STRING_0      ; JP if string type
  CALL MAKINT
  JP FN_STRING_1

FN_STRING_0:
  CALL __ASC_0
FN_STRING_1:
  POP DE
  CALL __SPACE_S_0

; label='SPACE$' BASIC function
__SPACE_S:
  CALL MAKINT
  LD A,' '
; This entry point is used by the routine at FN_STRING.
__SPACE_S_0:
  PUSH AF
  LD A,E
  CALL MKTMST
  LD B,A
  POP AF
  INC B
  DEC B
  JP Z,TOPOOL
  LD HL,(TMPSTR)
__SPACE_S_1:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,__SPACE_S_1
  JP TOPOOL

; 'LEFT$' BASIC function
__LEFT_S:
  CALL LFRGNM             ; Get number and ending ")"
  XOR A                   ; Start at first byte in string

; This entry point is used by the routine at __RIGHT_S.
RIGHT1:
  EX (SP),HL              ; Save code string,Get string
  LD C,A                  ; Starting position in string

; "LD A,n" to Mask the next byte
L5BF9:
  DEFB $3E

; Routine at 23546
;
; Used by the routine at L52F3.
__LEFT_S_1:
  PUSH HL                 ; Save string block address (twice)

; Continuation of MID$ routine
MID1:
  PUSH HL                 ; Save string block address
  LD A,(HL)               ; Get length of string
  CP B                    ; Compare with number given
  JP C,ALLFOL             ; All following bytes required
  LD A,B                  ; Get new length
  DEFB $11                ; "LD DE,nn" to skip "LD C,0"

; Routine at 23555
;
; Used by the routine at MID1.
ALLFOL:
  LD C,$00                ; First byte of string
  PUSH BC                 ; Save position in string
  CALL TESTR              ; See if enough string space
  POP BC                  ; Get position in string
  POP HL                  ; Restore string block address
  PUSH HL                 ; And re-save it
  INC HL
  LD B,(HL)               ; Get LSB of address
  INC HL
  LD H,(HL)               ; Get MSB of address
  LD L,B                  ; HL = address of string
  LD B,$00                ; BC = starting address
  ADD HL,BC               ; Point to that byte
  LD B,H                  ; BC = source string
  LD C,L
  CALL CRTMST             ; Create a string entry
  LD L,A                  ; Length of new string
  CALL TOSTRA             ; Move string to string area
  POP DE                  ; Clear stack
  CALL GSTRDE             ; Move to string pool if needed
  JP TSTOPL               ; Temporary string to pool

; 'RIGHT$' BASIC function
__RIGHT_S:
  CALL LFRGNM             ; Get number and ending ")"
  POP DE                  ; Get string length
  PUSH DE                 ; And re-save
  LD A,(DE)               ; Get length
  SUB B                   ; Move back N bytes
  JP RIGHT1               ; Go and get sub-string

; 'MID$' BASIC function
__MID_S:
  EX DE,HL                ; Get code string address
  LD A,(HL)               ; Get next byte "," or ")"
  CALL MIDNUM             ; Get number supplied
  INC B                   ; Is it character zero?
  DEC B
  JP Z,FC_ERR             ; Yes - Error
  PUSH BC                 ; Save starting position
  CALL MID_ARGSEP         ; test ',' & ')'
  POP AF                  ; Restore starting position
  EX (SP),HL              ; Get string,save code string
  LD BC,MID1              ; Continuation of MID$ routine
  PUSH BC                 ; Save for return
  DEC A                   ; Starting position-1
  CP (HL)                 ; Compare with length
  LD B,$00                ; Zero bytes length
  RET NC                  ; Null string if start past end
  LD C,A                  ; Save starting position-1
  LD A,(HL)               ; Get length of string
  SUB C                   ; Subtract start
  CP E                    ; Enough string for it?
  LD B,A                  ; Save maximum length available
  RET C                   ; Truncate string if needed
  LD B,E                  ; Set specified length
  RET                     ; Go and create string

; 'VAL' BASIC function
__VAL:
  CALL GETLEN             ; Get length of string
  JP Z,PASSA              ; Result zero
  LD E,A                  ; Save length
  INC HL
  LD A,(HL)               ; Get LSB of address
  INC HL
  LD H,(HL)               ; Get MSB of address
  LD L,A                  ; HL = String address
  PUSH HL                 ; Save string address
  ADD HL,DE
  LD B,(HL)               ; Get end of string+1 byte
  LD (HL),D               ; Zero it to terminate
  EX (SP),HL              ; Save string end,get start
  PUSH BC                 ; Save end+1 byte
  DEC HL
  CALL CHRGTB             ; Gets next character (or token) from BASIC text.
  CALL DBL_ASCTFP         ; Convert ASCII string to FP
  POP BC                  ; Restore end+1 byte
  POP HL                  ; Restore end+1 address
  LD (HL),B               ; Put back original byte
  RET

; Get number check for ending ')'
;
; Used by the routines at __LEFT_S and __RIGHT_S.
LFRGNM:
  EX DE,HL                ; Code string address to HL
  CALL SYNCHR             ; Make sure ")" follows
  DEFM ")"

; Get numeric argument for MID$
;
; Used by the routine at __MID_S.
MIDNUM:
  POP BC
  POP DE                  ; Get number supplied
  PUSH BC                 ; Re-save return address
  LD B,E                  ; Number to B
  RET

; Routine at 23670
;
; Used by the routine at OPRND_MORE.
FN_INSTR:
  CALL CHRGTB
  CALL OPNPAR
  CALL GETYPR
  LD A,$01
  PUSH AF
  JP Z,FN_INSTR_0
  POP AF
  CALL MAKINT
  OR A
  JP Z,FC_ERR
  PUSH AF
  CALL SYNCHR
  DEFM ","
  CALL EVAL
  CALL TSTSTR
FN_INSTR_0:
  CALL SYNCHR
  DEFM ","
  PUSH HL
  LD HL,(FACCU)
  EX (SP),HL
  CALL EVAL
  CALL SYNCHR
  DEFM ")"
  PUSH HL
  CALL GETSTR
  EX DE,HL
  POP BC
  POP HL
  POP AF
  PUSH BC
  LD BC,POPHLRT
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
FN_INSTR_1:
  PUSH HL
  PUSH DE
  PUSH BC
FN_INSTR_2:
  LD A,(DE)
  CP (HL)
  JP NZ,FN_INSTR_5
  INC DE
  DEC C
  JP Z,FN_INSTR_4
  INC HL
  DEC B
  JP NZ,FN_INSTR_2
  POP DE
  POP DE
  POP BC
FN_INSTR_3:
  POP DE
  XOR A
  RET

FN_INSTR_4:
  POP HL
  POP DE
  POP DE
  POP BC
  LD A,B
  SUB H
  ADD A,C
  INC A
  RET

FN_INSTR_5:
  POP BC
  POP DE
  POP HL
  INC HL
  DEC B
  JP NZ,FN_INSTR_1
  JP FN_INSTR_3

; This entry point is used by the routine at ISMID.
LHSMID:
  CALL SYNCHR
  DEFM "("
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
  CALL DCOMPR
  JP C,FN_INSTR_7
  LD HL,(TXTTAB)
  CALL DCOMPR
  JP NC,FN_INSTR_7
  POP HL
  PUSH HL
  CALL STRCPY
  POP HL
  PUSH HL
  CALL FP2HL
FN_INSTR_7:
  POP HL
  EX (SP),HL
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
  OR A
  JP Z,FC_ERR
  PUSH AF
  LD A,(HL)
  CALL MID_ARGSEP
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
  LD HL,POPHLRT
  EX (SP),HL
  LD A,C
  OR A
  RET Z
  LD A,(HL)
  SUB B
  JP C,FC_ERR
  INC A
  CP C
  JP C,FN_INSTR_8
  LD A,C
FN_INSTR_8:
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
FN_INSTR_9:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC C
  RET Z
  DEC B
  JP NZ,FN_INSTR_9
  RET

; test ',' & ')' as argument separators in string functions
;
; Used by the routines at __MID_S and FN_INSTR.
MID_ARGSEP:
  LD E,$FF
  CP ')'
  JP Z,MID_ARGSEP_0
  CALL SYNCHR
  DEFM ","
  CALL GETINT             ; Get integer 0-255
MID_ARGSEP_0:
  CALL SYNCHR
  DEFM ")"
  RET

; 'FRE' BASIC function
__FRE:
  CALL GETYPR
  JP NZ,__FRE_0
  CALL GSTRCU
  CALL GARBGE
__FRE_0:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  LD HL,(FRETOP)
  JP IMP_0



;------------------------------------------------------------------------------

IF HAVE_GFX

GRPACX:    DEFW 0			; X position of the last plotted pixel (GFX cursor X)
GRPACY:    DEFW 0			; Y position of the last plotted pixel (GFX cursor Y)

GXPOS:     DEFW 0			; Requested X coordinate
GYPOS:     DEFW 0			; Requested Y coordinate

IF ZXPLUS3
ATRBYT:    DEFB 8+7			; Blue PAPER, white INK
FORCLR:    DEFB 7			; Foreground color
BAKCLR:    DEFB 1			; Background color
BDRCLR:    DEFB 1			; Border color
ELSE
ATRBYT:    DEFB 0
FORCLR:    DEFB 0			; Foreground color
BAKCLR:    DEFB 0			; Background color
BDRCLR:    DEFB 0			; Border color
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
        LD A,(FORCLR)                ; Get default color (PSET=foreground)
; This entry point is used by the routine at __PRESET.
__PSET_0:
        PUSH AF                      ; Save default color
        CALL COORD_PARMS_DST         ; Get coordinates in BC, DE
        POP AF                       ; Restore default color
        CALL PAINT_PARMS_0           ; Get color, if specified
        PUSH    HL                   ; Save code string address

IF ZXPLUS3
;
ELSE
        CALL SCALXY
        JR NC,__PSET_1
ENDIF

        CALL MAPXY                   ; Find position in VRAM. CLOC=memory address, CMASK=color pixelmask
        CALL SETC

__PSET_1:
        POP     HL                   ; Restore code string address
        RET


;---------------------
; Used by the routines at LINE, (__PAINT, __CIRCLE and PUT_SPRITE).
COORD_PARMS:
  LD A,(HL)
  CP $40		; ?
  CALL Z,CHRGTB  ; Gets next character (or token) from BASIC text.
  LD BC,$0000
  LD D,B
  LD E,C
  CP TK_MINUS		; Token for '-'
  JR Z,COORD_PARMS_1

; This entry point is used by the routines at __PSET, __PRESET and FN_POINT.
COORD_PARMS_DST:
  LD A,(HL)
  CP TK_STEP		; If STEP is used, coordinates are interpreted relative to the current cursor position.
					; In this case the values can also be negative.
  PUSH AF
  CALL Z,CHRGTB     ; Gets next character (or token) from BASIC text.
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  CALL FPSINT_0
  PUSH DE
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL FPSINT_0
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  POP BC
  POP AF

COORD_PARMS_1:
  PUSH HL            		; code string address
  LD HL,(GRPACX)
  JR Z,RELATIVE_XPOS		; JP if 'STEP' is specified
  LD HL,$0000
RELATIVE_XPOS:
  ADD HL,BC
  LD (GRPACX),HL
  LD (GXPOS),HL
  LD B,H
  LD C,L

  LD HL,(GRPACY)
  JR Z,RELATIVE_YPOS		; JP if 'STEP' is specified
  LD HL,$0000
RELATIVE_YPOS:
  ADD HL,DE
  LD (GRPACY),HL
  LD (GYPOS),HL
  EX DE,HL
  POP HL            		; code string address
  
IF ZXPLUS3
  xor a
  or b
  or d
  jp nz,FC_ERR
  ld a,e
  cp 192
  jp nc,FC_ERR			; y0	out of range
ENDIF
  
  RET


;---------------------
__COLOR:
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
IF ZXPLUS3
  CALL SETATR
ELSE
  LD (ATRBYT),A
ENDIF
  CALL CHGCLR
  POP HL
  RET


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




CHGCLR:
IF ZXPLUS3
	
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

	; BORDER
	LD	A,(BDRCLR)
	out	(254),a
	
	ret

CLRTBL:
    defb 32,34,40,42,64,66,72,74
    defb 32,35,44,47,80,83,92,95

ELSE
	ret
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


        CALL COORD_PARMS_DST

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

		CALL INT_RESULT_HL
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

        ;CALL INT_RESULT_A
		;CALL INT_RESULT_HL
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

PAINT_PARMS:
  LD A,(FORCLR)
PAINT_PARMS_0:
  PUSH BC
  PUSH DE
  LD E,A
  ;CALL IN_GFX_MODE            ; "Illegal function call" if not in graphics mode
  DEC HL
  CALL CHRGTB		; Gets next character (or token) from BASIC text.
  JR Z,PAINT_PARMS_1
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JR Z,PAINT_PARMS_1
  CALL GETINT             ; Get integer 0-255
PAINT_PARMS_1:
  LD A,E
  PUSH HL
  CALL SETATR           ; Set attribute byte
  JP C,FC_ERR           ; Err $05 - "Illegal function call"
  POP HL
  POP DE
  POP BC
  JP __CHRCKB           ; Gets current character (or token) from BASIC text.

;=====================================================================


; Routine at 22680
;
; Used by the routines at LINE and DRAW_LINE.
SWAP_GXGY:
  CALL SWAP_GY

; This entry point is used by the routine at LINE.
SWAP_GX:
  PUSH HL
  PUSH BC
  LD HL,(GXPOS)
  EX (SP),HL
  LD (GXPOS),HL
  POP BC
  POP HL
  RET

; Used by the routines at LINE and DRAW_LINE.
GX_DELTA:
  LD HL,(GXPOS)
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A

; This entry point is used by the routine at GY_DELTA.
GX_DELTA_0:
  RET NC

INVSGN_HL:
  XOR A
  SUB L		; Negate exponent
  LD L,A	; Re-save exponent
  SBC A,H
  SUB L
  LD H,A
  SCF
  RET


GY_DELTA:
  LD HL,(GYPOS)
  ; HL=HL-DE
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JR GX_DELTA_0

SWAP_GY:
  PUSH HL
  LD HL,(GYPOS)
  EX DE,HL
  LD (GYPOS),HL
  POP HL
  RET


;=====================================================================

LINE:
  CALL COORD_PARMS
  PUSH BC
  PUSH DE
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB TK_MINUS		; Token for '-'
  CALL COORD_PARMS_DST
  CALL PAINT_PARMS  ;  Deals also with default color
  POP DE
  POP BC
  JR Z,DOTLINE
  
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'B'
  JP Z,BOXLIN

  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'F'			; 'BOX FILLED'

DOBOXF:
  PUSH HL            		; code string address
  ;CALL SCALXY
  CALL SWAP_GXGY
  ;CALL SCALXY
  CALL GY_DELTA
  CALL C,SWAP_GY
  INC HL
  PUSH HL
  CALL GX_DELTA
  CALL C,SWAP_GX
  INC HL
  PUSH HL
  CALL MAPXY
  POP DE
  POP BC
LINE_0:
  PUSH DE
  PUSH BC

  CALL FETCHC			; Save cursor
  PUSH AF
  PUSH HL
IF ZXPLUS3
  ld hl,(ALOC)		; 'pixeladdress' result for attributes, saved by MAPXY
  push hl
ENDIF
  EX DE,HL

  CALL NSETCX           ; Set horizontal screenpixels

IF ZXPLUS3
  pop hl
  ld (ALOC),hl		; 'pixeladdress' result for attributes, saved by MAPXY
ENDIF
  POP HL
  POP AF
  CALL STOREC			; Restore cursor

  CALL DOWNC
  POP BC
  POP DE
  DEC BC
  LD A,B
  OR C
  JR NZ,LINE_0
  POP HL            		; code string address
  RET


FETCHC:
  LD A,(CMASK)
  LD HL,(CLOC)
  RET

STOREC:
  LD (CMASK),A
  LD (CLOC),HL
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
  PUSH HL            		; code string address
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
  POP HL            		; code string address
  RET

; Routine at 22844
;
; Used by the routines at LINE and DRAW_LINE_GRPAC.
DRAW_LINE:
  ;CALL SCALXY
  CALL SWAP_GXGY
  ;CALL SCALXY
  CALL GY_DELTA
  CALL C,SWAP_GXGY
  PUSH DE
  PUSH HL
  CALL GX_DELTA
  EX DE,HL
  LD HL,RIGHTC
  JR NC,DRAW_LINE_0
  LD HL,LEFTC
DRAW_LINE_0:
  EX (SP),HL
  CALL DCOMPR		; Compare HL with DE.
  JR NC,DRAW_LINE_1
  LD (MINDEL+1),HL
  POP HL
  LD (MAXUPD+1),HL	; MAXUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  LD HL,DOWNC
  LD (MINUPD+1),HL	; MINUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  EX DE,HL
  JR DRAW_LINE_2

DRAW_LINE_1:
  EX (SP),HL
  LD (MINUPD+1),HL	; MINUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  LD HL,DOWNC
  LD (MAXUPD+1),HL	; MAXUPD = JP nn for RIGHTC, LEFTC and DOWNC 
  EX DE,HL
  LD (MINDEL+1),HL	; The original ROM version uses a system variable.  We do SMC.
  POP HL
DRAW_LINE_2:
  POP DE
  PUSH HL
  CALL INVSGN_HL
  LD (MAXDEL+1),HL	; The original ROM version uses a system variable.  We do SMC.
  CALL MAPXY		; Initialize CLOC, CMASK, etc..
  POP DE
  PUSH DE
  CALL DE_DIV2		; DE=DE/2
  POP BC
  INC BC
  JR DRAW_LINE_SEGMENT

; Routine at 22931
DRAW_LINE_3:
  POP HL
  LD A,B
  OR C
  RET Z
MAXUPD:
  CALL 0		; <- SMC, MAXUPD = JP nn for RIGHTC, LEFTC and DOWNC 

; This entry point is used by the routine at DRAW_LINE.
DRAW_LINE_SEGMENT:
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
  JR NC,DRAW_LINE_3
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
; "RR DE" - Used by the routines at DRAW_LINE, __CIRCLE and L5E66.
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

  DEC L
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

; Now update color attribute for the plotted pixel
	ld		a,(ATRBYT)
	ld		hl,(ALOC)		; 'pixeladdress' result for attributes, saved by MAPXY
	call	p3_poke
	
	pop hl
	pop de
	pop bc
	ret



;------------
MAPXY:
	push bc
	push de
	push hl			       ; code string address
	
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
	and $03
	or $58		; $5800 = color attributes
	ld h,a   

	ld (ALOC),hl		   ; Store attribute address

	pop hl			       ; code string address
	pop de
	pop bc
	ret



;------------
pointxy:
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



;------------
pixeladdress:
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

   inc hl
   ld (CLOC),hl

   ld a,(ALOC)	; LSB of ATTR address
   inc a
   ld (ALOC),a
   ret



;------------
LEFTC:
   LD A,(CMASK)
   rlca
   LD (CMASK),A
   ld hl,(CLOC)	; SCREEN address
   ret nc

   dec hl
   ld (CLOC),hl

   ld a,(ALOC)	; LSB of ATTR address
   dec a
   ld (ALOC),a
   ret



;------------
DOWNC:
   ld hl,(CLOC)
   call zx_pdown
   ld (CLOC),hl
   ret c

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




; Routine at 23992
;
; Used by the routine at DONCMD.
_READY:
  CALL NODSKS
  LD HL,(TXTTAB)
  DEC HL
  LD (HL),$00
  LD HL,(TEMP8)
  LD A,(HL)
  OR A
  JP NZ,_RUN_FILE
  JP READY

; Data block at 24012
NULL_FILE:
  DEFW $0000

; Data block at 24014
PSP_BYTES:
  DEFB $05

; Data block at 24015
L5DCF:
  DEFB $01

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
  LD HL,($0001)             ;GET START OF BIOS VECTOR TABLE
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
  LD (SMC_GETINP),HL        ;SAVE IN CONSOLE INPUT CALL
  EX DE,HL                  ;POINTER BACK TO [H,L]
  INC HL                    ;SKIP "JMP" OPCODE
  INC HL                    ;BUMP POINTER
  LD E,(HL)                 ;GET OUTPUT ROUTINE ADDRESS
  INC HL
  LD D,(HL)
  EX DE,HL                  ;INTO [H,L]
  LD (SMC_TTYIN),HL         ;SAVE INTO OUTPUT ROUTINE
  EX DE,HL                  ;POINTER BACK TO [H,L]
  INC HL                    ;NOW POINT TO PRINTER OUTPUT
  INC HL                    ;ROUTINE ADDRESS
  LD E,(HL)                 ;PICK IT UP
  INC HL
  LD D,(HL)
  EX DE,HL                  ;GET ADDRESS INTO [D,E]
  LD (SMC_OUTPRT),HL        ;SET PRINT ROUTINE ADDRESS

  ;  Check CP/M Version Number
IF CPMV1
  LD C,$0C                ; BDOS function 12 - Get BDOS version number
  CALL $0005
  LD (BDOSVER),A
  OR A
  LD HL,$1514             ; FN2=$15 (CP/M 1 WR), FN1=14 (CP/M 1 RD)
  JP Z,CPMVR1             ; JP if BDOS Version 1
  LD HL,$2221             ; FN2=$22 (Write record FN), FN1=$21 (Read record FN)
CPMVR1:
  LD (CPMREA),HL          ; Load the BDOS FN code pair (FN1+FN2)
ENDIF

  LD HL,65534             ; SAY INITIALIZATION IS EXECUTING
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
  LD (RECSIZ),HL          ; a.k.a. MAXREC
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,PRMSTK            ; INITIALIZE PARAMETER BLOCK CHAIN
  LD (PRMPRV),HL
  LD HL,($0006)           ; HL=BDOS entry address (=LAST LOC IN MEMORY)
  LD (MEMSIZ),HL          ; -> USE AS DEFAULT



;
;
; THE FOLLOWING CODE SCANS A CP/M COMMAND LINE FOR BASIC.
; THE FORMAT OF THE COMMAND IS:
;
; BASIC <FILE NAME>[/M:<TOPMEM>][/F:<FILES>]
;
  LD A,3                ; If the /F option is omitted, the number of files defaults to 3.
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  LD HL,WARM_0          ; POINT AT ZERO BYTE
  LD (TEMP8),HL         ; SO IF RE-INITAILIZE OK
  LD A,(WARM_FLG)       ; HAVE WE ALREADY READ COMMAND LINE
  OR A                  ; AND GOT ERROR?
  JP NZ,DONCMD          ; THEN DEFAULT
  INC A                 ; MAKE NON-ZERO
  LD (WARM_FLG),A       ; STORE BACK NON-ZERO FOR NEXT TIME
  LD HL,$0080           ; POINT TO FIRST CHAR OF COMMAND BUFFER (CPMWRM+128)
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
  DEC B                 ; DECREMENT COUNT OF CHARS TO MOVE
  JP NZ,TBF_LP          ; KEEP MOVING CHARS
  DEC HL                ; BACK UP POINTER
ENDCMD:
  LD (HL),$00           ; STORE TERMINATOR FOR CHRGET (0)
  LD (TEMP8),HL         ; SAVE POINTER TO NEW ZERO (OLD DESTROYED)
  LD HL,$007F           ; POINT TO CHAR BEFORE BUFFER
  CALL CHRGTB           ; IGNORE LEADING SPACES
  OR A
  JP Z,DONCMD           ; END OF COMMAND

;
; Command line parameters usage example
;
; A>MBASIC PRGM/F:2/M:&H9000
; Use first 36K of memory, 2 files, and execute PRGM.BAS.
  
  CP '/'
  JP Z,INIT_3
  DEC HL
  LD (HL),'"'
  LD (TEMP8),HL
  INC HL
INIT_2:
  CP '/'
  JP Z,INIT_3
  CALL CHRGTB
  OR A
  JP NZ,INIT_2
  JP DONCMD

  
INIT_3:
  LD (HL),$00
  CALL CHRGTB
INIT_4:
  CALL MAKUPL
  CP 'S'		; [/S:<maximum record size>]
  JP Z,GET_RECSIZ
  CP 'M'		; [/M:<highest memory location>]
  PUSH AF
  JP Z,HAVE_OPTIONS
  CP 'F'		; [/F:<number of files>]
  JP NZ,SN_ERR


HAVE_OPTIONS:
  CALL CHRGTB
  CALL SYNCHR
  DEFM ":"
  CALL UCASE_0
  POP AF
  JP Z,INIT_6

; If /F:<number of files> is present, it sets the number of disk data files that may be 
; open at anyone time during the execution of a BASIC program.
; Each file data block allocated in this fashion requires 166 bytes of memory.
; If the /F option is omitted, the number of files defaults to 3.

  LD A,D
  OR A
  JP NZ,FC_ERR
  LD A,E
  CP $10
  JP NC,FC_ERR
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  JP INIT_7


INIT_6:
  EX DE,HL
  LD (MEMSIZ),HL
  EX DE,HL
INIT_7:
  DEC HL
  CALL CHRGTB
  JP Z,DONCMD
  CALL SYNCHR
  DEFM "/"
  JP INIT_4
  
  
; /S:<maximum record size> may be added at the end of the command
; line to set the maximum record size for use with random files.
; The default record size is 128 bytes.

GET_RECSIZ:
  CALL CHRGTB
  CALL SYNCHR
  DEFM ":"
  CALL UCASE_0
  EX DE,HL
  LD (RECSIZ),HL
  EX DE,HL
  JP INIT_7


IF ZXPLUS3
; ---------------------------------------------------------------
; This code portion will be copied on stack
; ---------------------------------------------------------------
pokebyte_code:
		di
		; ..$15 00010101 -> banks 4,5,6,3
		; ..$11 00010001 -> banks 0,1,2,3 (TPA)
		ex  af,af
		ld	a,$15
		;ld	a,$0D
		;ld	a,$05
		ld bc,$1ffd
		out(c),a
		ex af,af
		ld (hl),a
		ld	a,$11		; avoid using ($FF01) to be compatible with CP/M 2.2 
		;ld	a,$09
		;ld	a,$01
		;ld	a,($FF01)	; saved value
		out(c),a
		ei
		ret
		; adjust code size
		nop
peekbyte_code:
		di
		; ..$15 00010101 -> banks 4,5,6,3
		; ..$11 00010001 -> banks 0,1,2,3 (TPA)
		ld	a,$15
		;ld	a,$0D
		;ld	a,$05
		ld bc,$1ffd
		out(c),a
		ld a,(hl)
		ex  af,af
		ld	a,$11		; avoid using ($FF01) to be compatible with CP/M 2.2 
		;ld	a,$09
		;ld	a,$01
		;ld	a,($FF01)	; saved value
		out(c),a
		ex  af,af
		ei
		ret
		; adjust code size
		nop
; ---------------------------------------------------------------
ENDIF


WARM_0:
  DEFB $00
WARM_FLG:
  DEFB $00

; Routine at 24346
;
; Used by the routine at INIT.
DONCMD:
  LD DE,USER_MEMORY
  LD A,(DE)
  OR A
  JP Z,DONCMD_3
  LD A,(L5DCF)
  LD B,A
  

PSP_LOOP:
  LD A,(PSP_BYTES)
  LD C,A
  LD HL,($0006)           ; HL=BDOS entry address
  LD L,$00                ; Reduce to the byte boundary to get the TPA size
  
PSP_CHK:
  LD A,(DE)
  CP (HL)
  JP NZ,PSP_DIFFERS
  
  INC HL
  INC DE
  DEC C
  JP NZ,PSP_CHK
  JP DONCMD_3
  
PSP_DIFFERS:
  INC DE
  DEC C
  JP NZ,PSP_DIFFERS
  DEC B
  RET Z
  JP PSP_LOOP
  
DONCMD_3:
  DEC HL
  LD HL,(MEMSIZ)        ; GET SIZE OF MEMORY
  DEC HL

; SET UP DEFAULT STRING SPACE
  LD (MEMSIZ),HL
  DEC HL
  PUSH HL
  LD A,(MAXFIL)			; HIGHEST FILE NUMBER ALLOWED
  LD HL,NULL_FILE
  LD (FILPT1),HL
  LD DE,FILPTR
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  INC A

  LD BC,$00A9		; 169

DONCMD_4:
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  ADD HL,BC
  PUSH HL
  LD HL,(RECSIZ)
  LD BC,128+50		; The default record size is 128 bytes.
  ADD HL,BC
  LD B,H
  LD C,L
  POP HL
  
  DEC A
  JP NZ,DONCMD_4

  INC HL               ; INCREMENT POINTER
  LD (TXTTAB),HL       ; SAVE BOTTOM OF MEMORY
  LD (SAVSTK),HL       ; WE RESTORE STACK WHEN ERRORS
  POP DE               ; GET  CURRENT MEMSIZ
  LD A,E               ; CALC TOTAL FREE/8
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR

; HL=HL/8
  LD B,$03             ; DIVIDE BY 2 THREE TIMES
SHFLF3:
  OR A
  LD A,H
  RRA
  LD H,A
  LD A,L
  RRA
  LD L,A
  DEC B
  JP NZ,SHFLF3

  LD A,H                ; SEE HOW MUCH
  CP $02				; IF LESS THAN 512 USE 1 EIGHTH
  JP C,SMLSTK

  LD HL,$0200			; Force minimum MEM size to 512

SMLSTK:
  LD A,E                ; SUBTRACT STACK SIZE FROM TOP MEM
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR

IF ZXPLUS3
	push de
	ld de,-36	; let's reserve extra space on stack for the JP routines
	add hl,de
	push hl
	
	; Save entry for p3_poke
	ld (p3_poke+1),hl

	; Determine entry for p3_peek
	push hl		; keep a copy
	ld de,18	; -36+18..
	add hl,de
	ld (p3_peek+1),hl

	; copy on stack
	pop hl
	ld d,h
	ld e,l
	ld hl,pokebyte_code
	ld bc,18+18
	ldir
	pop hl
	pop de
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
  LD A,L                  ; SUBTRACT MEMSIZ-TXTTAB
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  DEC HL                  ; SINCE TWO ZEROS EXIST BETWEEN
  DEC HL                  ; TXTTAB AND STREND, ADJUST
  PUSH HL                 ; SAVE NUMBER OF BYTES TO PRINT
  LD HL,COPYRIGHT_MSG     ; GET HEADING ("BASIC VERSION...")
  CALL PRS                ; PRINT IT
  POP HL                  ; RESTORE NUMBER OF BYTES TO PRINT
  CALL _PRNUM             ; PRINT # OF BYTES FREE
  LD HL,BYTES_MSG         ; TYPE THE HEADING
  CALL PRS                ; "BYTES FREE"
  LD HL,PRS
  LD (SMC_PRINTMSG),HL
  CALL OUTDO_CRLF         ; PRINT CARRIAGE RETURN
  LD HL,WARM_BT
  JP _READY

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

; Message at 24587
COPYRIGHT_MSG:
  DEFM "BASIC-80 Rev. 5.22"
  DEFB $0D
  DEFB $0A
  DEFM "CP/M Version"
  DEFB $0D
  DEFB $0A
  DEFM "Copyright 1977-1982 (C) by Microsoft"
  DEFB $0D
  DEFB $0A
  DEFB $00

; Message at 24660
; Useless signature
; adds a bit of space between program and interpreter
BASIC_SIGNATURE:
  DEFM "Basic-80"

; Foo data in yser memory
USER_MEMORY:
  DEFB 0
  DEFB 22
  DEFB 20
  DEFB 0
  DEFB 'X'
  DEFB $00
  
  DEFS 70

TSTACK:

IF ORIGINAL
; CP/M sector filler

  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
ENDIF
