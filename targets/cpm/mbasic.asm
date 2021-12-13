
; z80asm -b mbasic.asm


  ORG $0100

; BASIC-80 Rev. 5.22


; Classic build:
;
; z80asm -b -DORIGINAL mbasic.asm
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


L0100:
  JP BASIC_ENTRY

; Data block at 259
L0103:
  DEFW __CINT

; Data block at 261
L0105:
  DEFW INT_RESULT_HL

; Jump table for statements and functions
FNCTAB:
  DEFW __END
  DEFW __FOR
  DEFW __NEXT
  DEFW __DATA
  DEFW __INPUT
  DEFW __DIM
  DEFW __READ
  DEFW __LET
  DEFW __GO_TO
  DEFW __RUN
  DEFW __IF
  DEFW __RESTORE
  DEFW __GO_SUB
  DEFW __RETURN
  DEFW __REM
  DEFW __STOP
  DEFW __PRINT
  DEFW __CLEAR
  DEFW __LIST
  DEFW __NEW
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
  DEFW __SPACE_S
  DEFW __OCT_S
  DEFW __HEX_S
  DEFW __LPOS
  DEFW __CINT
  DEFW __CSNG
  DEFW __CDBL
  DEFW __FIX
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
  DEFW DECCOMP

; FP OPERATIONS TABLE
FLT_OPR:
  DEFW FADD
  DEFW FSUB
  DEFW FMULT
  DEFW FDIV
  DEFW FCOMP

; INTEGER OPERATIONS TABLE
INT_OPR:
  DEFW IADD
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
  DEFB $01                ; Counter for NULL() function
CTLCFG:
  DEFB $00                ; Yet another "STOP" status flag
ERRFLG:
  DEFB $00,$00
LPTPOS:
  DEFB $00
PRTFLG:
  DEFB $00
COMMAN:
  DEFB $70
NTMSXP:
  DEFB $84                ; Value for 'WIDTH' on printer output (255="infinite").
LINLEN:
  DEFB $50                ; Current column-position of the cursor
CLMLST:
  DEFB $38                ; Column space: value for 'WIDTH' on screen output (255="infinite").
NULFLG:
  DEFB $00                ; "NULL" status flag
CTLOFG:
  DEFB $00                ; "STOP" status flag (toggled with ^O)
PTRFIL:
  DEFW $0000              ; File pointer
STKTOP:
  DEFW $610C              ; Top location to be used for the stack
CURLIN:
  DEFW $FFFE              ; (word), line number being interpreted
TXTTAB:
  DEFW $60A9              ; PTR to Start of BASIC program
MATH_ERRTXT:
  DEFW OVERFLOW_MSG       ; Text PTR to current error message in math operations
AUTORUN:
  DEFB $00
MAXFILSV:
  DEFB $00                ; Top number of files
RWFLG:
  DEFB $00,$00            ; Flag for BDOS functions access

FILPTR:
  DEFW $0000

FILTAB:
  DEFS 32                 ; Pointer table for files/channels

MAXFIL:
  DEFB $00                ; Maximum number of files

TYPE_BUFFR:
  DEFS 39                 ; Used by BASIC to deal with variable types

LCRFLG:
  DEFW $00                ; Locate/Create flag
  
  
; The File Control Block is a 36-byte data structure (33 bytes in CP/M 1).

FCB_COPY:
  DEFS 16

; -- CP/M 1 FCB structure --
; The File Control Block is a 36-byte data structure (33 bytes in CP/M 1).
FCB_FILE:
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


BDOSVER:
  DEFB $00                ; Current CP/M BDOS version number

; BDOS function pair, either R/W or SELECT/OPEN
BDOS_FN1:
  DEFB $00                ; BDOS function code for 'READ' (BDOS v2) or 'SELECT DSK' (BDOS v1) call 
BDOS_FN2:
  DEFB $00                ; BDOS function code for 'WRITE' (BDOS v2) or 'OPEN FILE' (BDOS v1) call

BUFFER:
  DEFM ":"                ; Start of input buffer
KBUF:
  DEFS 318  ; Input buffer +1


BUFMIN:
  DEFB $2C

BUF:
  DEFS 256   ; Buffer to store characters typed (in ASCII code)

  DEFB $00
ENDBUF:
  DEFB $00,$00
TTYPOS:
  DEFB $00
DIMFLG:
  DEFB $00
VALTYP:
  DEFB $00                ; (word) type indicator
DORES:
  DEFB $00                ; a.k.a. OPRTYP, indicates whether stored word can be crunched, etc..
DONUM:
  DEFB $00                ; indicates whether we have a number
CONTXT:
  DEFW $0000              ; Text address used by CHRGTB
CONSAV:
  DEFB $00                ; Store token of constant after calling CHRGET
CONTYP:
  DEFB $00
CONLO:
  DEFW $0000              ; Value of stored constant
  
  DEFW $0000              ; Unused ?
  DEFW $0000
  DEFW $0000

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
FOR_ACC:
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
FILFLG:
  DEFB $00                ; File load status flag
NLONLY:
  DEFB $00                ; nothing found in the input buffer (<>0 when loading program)
  
CHAIN_DEL:
  DEFB $00                ; Flag to track the 'DELETE' option in a CHAIN command
CHAIN_TO:
  DEFW $0000              ; End line number in a range specified for 'CHAIN'
CHAIN_FROM:
  DEFW $0000              ; Start line number in a range specified for 'CHAIN'
MEM_FLG:
  DEFB $00                ; Memory status flag (garbage collector, etc..)
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
  LD HL,$0004             ; Look for "FOR" block with
  ADD HL,SP               ; same index as specified in D
; This entry point is used by the routine at __FOR.
LOKFOR:
  LD A,(HL)               ; Get block ID
  INC HL                  ; Point to index address
  CP TK_WHILE             ; Is it a "WHILE" token
  JP NZ,LOKFOR_0          ; No - check "FOR" as well
  LD BC,$0006
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
  LD BC,$0010             ; Offset to next block
  POP HL                  ; Restore pointer to sign
  RET Z                   ; Return if block found
  ADD HL,BC               ; Point to next block
  JP LOKFOR               ; Keep on looking

; This entry point is used by ERROR and BASIC_MAIN routines.
WARM_BT_0:
  LD BC,RESTART
  JP TM_ERR_0
; This entry point is used by the routine at L12AA.
PRG_END:
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,PRG_END_0
  LD A,(ONEFLG)
  OR A
  LD E,$13                ; Err $13 - "No RESUME"
  JP NZ,ERROR
PRG_END_0:
  JP _ENDPRG              ; 03223



; 'Disk full' error entry
;
; Used by the routine at __EOF.
DSK_FULL_ERR:
  LD E,$3D
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Disk I/O error' error entry
;
; Used by the routine at __EOF.
DISK_ERR:
  LD E,$39
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad file mode' error entry
;
; Used by the routines at __EOF, __OPEN, GET_CHNUM, __MERGE, __FIELD, FN_INPUT
; and __GET.
FMODE_ERR:
  LD E,$36
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'File not found' error entry
;
; Used by the routines at __NAME, __OPEN, __KILL and __FILES.
FF_ERR:
  LD E,$35
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad file number' error entry
;
; Used by the routines at __EOF, __LOC, __LOF, __OPEN, GET_CHNUM and __FIELD.
BN_ERR:
  LD E,$34
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Internal error' error entry
IE_ERR:
  LD E,$33
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Input past END' (EOF) error entry
;
; Used by the routines at LINE_INPUT and FN_INPUT.
EF_ERR:
  LD E,$3E
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'File already open' error entry
;
; Used by the routine at __OPEN.
AO_ERR:
  LD E,$37
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad file name' error entry
;
; Used by the routine at FNAME.
NM_ERR:
  LD E,$40
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Bad record number' error entry
;
; Used by the routine at __GET.
RECNO_ERR:
  LD E,$3F
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'FIELD overflow' error entry
;
; Used by the routines at __FIELD and __GET.
FIELD_OV_ERR:
  LD E,$32
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Too many files' error entry
;
; Used by the routines at __EOF, __LOF, __OPEN and BDOS_EXEC.
FL_ERR:
  LD E,$43
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'File already exists' error entry
;
; Used by the routine at __NAME.
FILE_EXISTS_ERR:
  LD E,$3A
  JP ERROR

; 'SN err' entry for Input STMT
;
; Used by the routine at L184B.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; 'Syntax Error' message
;
; Used by the routines at LNUM_RANGE, SAVSTP, L12AA, __GO_TO, __AUTO, L184B,
; INPUT_SUB, _EVAL, HEXTFP, DOFN, MORE_STMT, __WAIT, __RENUM, __OPTION, __LOAD,
; __MERGE, __WEND, __CHAIN, __GET, GETVAR, SBSCPT, L5256, SYNCHR, __CLEAR and
; BASIC_ENTRY.
SN_ERR:
  LD E,$02
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Division by zero' error entry
;
; Used by the routines at L2BA0 and DECDIV_SUB.
O_ERR:
  LD E,$0B
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'NEXT without FOR' error entry
;
; Used by the routine at __NEXT.
NF_ERR:
  LD E,$01
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Redimensioned array' error entry (re-dim not allowed)
;
; Used by the routines at __OPTION and NXTARY.
DD_ERR:
  LD E,$0A
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Undefined user function' error entry
;
; Used by the routine at DOFN.
UFN_ERR:
  LD E,$12
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'RESUME without error' error entry
;
; Used by the routine at __RESUME.
RW_ERR:
  LD E,$14
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Overflow' error entry
;
; Used by the routines at HEXTFP, __CINT, DECDIV_SUB and __NEXT.
OV_ERR:
  LD E,$06
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Operand Error' error entry
;
; Used by the routine at OPRND.
OPERAND_ERR:
  LD E,$16
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'Type mismatch' error entry
;
; Used by the routines at FORFND, _EVAL, _EVAL_VALTYP, INVSGN, _TSTSGN, __CINT,
; __CSNG, __CDBL, TSTSTR, __INT and __TROFF.
TM_ERR:
  LD E,$0D
; This entry point is used by the routines at WARM_BT_0, FILE_EXISTS_ERR,
; DETOKEN_MORE, FC_ERR, UL_ERR, __RETURN, __ERROR, FDTLP, IDTEST, LOOK_FOR,
; __MERGE, __WEND, BS_ERR, CHKSTK, __CONT, TSTOPL_0, TESTOS and CONCAT.
ERROR:
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  XOR A
  LD (NLONLY),A
  LD (MEM_FLG),A
  LD A,H
  AND L
  INC A
  JP Z,ERROR_1
  LD (DOT),HL
; This entry point is used by the routine at __ON.
ERROR_1:
  LD BC,ERROR_3           ; ERROR_1
; This entry point is used by the routine at WARM_BT_0.
TM_ERR_0:
  LD HL,(SAVSTK)
  JP WARM_ENTRY

; Routine at 3330
ERROR_3:
  POP BC                  ; ERROR_3
  LD A,E
  LD C,E
  LD (ERRFLG),A
  LD HL,(SAVTXT)
  LD (ERRTXT),HL
  EX DE,HL
  LD HL,(ERRLIN)
  LD A,H
  AND L
  INC A
  JP Z,ERROR_4
  LD (OLDLIN),HL
  EX DE,HL
  LD (OLDTXT),HL
ERROR_4:
  LD HL,(ONELIN)          ; ERROR_4
  LD A,H
  OR L
  EX DE,HL
  LD HL,ONEFLG
  JP Z,ERROR_REPORT
  AND (HL)
  JP NZ,ERROR_REPORT
  DEC (HL)
  EX DE,HL
  JP L12AA_0


; Interactive error handling (print error message and break)
;
; Used by the routine at ERROR_3.
ERROR_REPORT:
  XOR A
  LD (HL),A
  LD E,C
  LD (CTLOFG),A
  CALL CONSOLE_CRLF
  LD HL,ERROR_MESSAGES
  LD A,E
  CP $44
  JP NC,UNKNOWN_ERR       ; JP if error code is bigger than $43
  CP $32
  JP NC,SUB_13_ERR        ; JP if error code is between $32 and $43
  CP $1F
  JP C,ERROR_REPORT_0     ; JP if error code is < $1F

; Used by the routines at ERROR_REPORT and _ERROR_REPORT.
UNKNOWN_ERR:
  LD A,$28    ; if error code is bigger than $43 then force it to $28-$13=$15 ("Unprintable error")

; JP here if error code is between $32 and $43, then sub $13
;
; Used by the routine at ERROR_REPORT.
SUB_13_ERR:
  SUB $13
  LD E,A
; This entry point is used by the routine at ERROR_REPORT.
ERROR_REPORT_0:
  CALL __REM
  INC HL
  DEC E
  JP NZ,ERROR_REPORT_0
  PUSH HL
  LD HL,(ERRLIN)
  EX (SP),HL

; Halfway in the interactive error handling (print error message and break)
;
; Used by the routine at INPBRK.
_ERROR_REPORT:
  LD A,(HL)
  CP $3F
  JP NZ,_ERROR_REPORT_0
  POP HL
  LD HL,ERROR_MESSAGES
  JP UNKNOWN_ERR


_ERROR_REPORT_0:
  CALL PRS
  POP HL
  LD DE,$FFFE			; -2
  CALL DCOMPR
  CALL Z,OUTDO_CRLF
  JP Z,EXIT_TO_SYSTEM
  LD A,H
  AND L
  INC A
  CALL NZ,LNUM_MSG
  DEFB $3E                ; "LD A,n" to Mask the next byte

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
  CALL STOP_LPT
  XOR A
  LD (CTLOFG),A
  CALL LOAD_END
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  DEFB $CD                ; CALL nn

; Data block at 3480
SMC_PRINTMSG:
  DEFW $0000

; Routine at 3482
READY_0:
  LD A,(ERRFLG)
  SUB $02
  CALL Z,ERR_EDIT



; Routine at 3490
;
; Used by the routines at __AUTO, __LOAD and __MERGE.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL
  LD A,(AUTFLG)
  OR A
  JP Z,GETCMD
  LD HL,(AUTLIN)
  PUSH HL
  CALL _PRNUM
  POP DE
  PUSH DE
  CALL SRCHLN
  LD A,'*'
  JP C,PROMPT_0
  LD A,' '
PROMPT_0:
  CALL OUTDO
  CALL PINLIN
  POP DE
  JP NC,PROMPT_2
  XOR A
  LD (AUTFLG),A
  JP READY


PROMPT_1:
  XOR A
  LD (AUTFLG),A
  JP PROMPT_3
  
PROMPT_2:
  LD HL,(AUTINC)
  ADD HL,DE
  JP C,PROMPT_1
  PUSH DE
  LD DE,$FFF9		 ; -7
  CALL DCOMPR
  POP DE
  JP NC,PROMPT_1
  LD (AUTLIN),HL
PROMPT_3:
  LD A,(BUF)
  OR A
  JP Z,PROMPT
  JP EDIT_DONE_1


GETCMD:
  CALL PINLIN
  JP C,PROMPT
  CALL CHRGTB             ; Get first character
  INC A                   ; Test if end of line
  DEC A                   ; Without affecting Carry
  JP Z,PROMPT             ; Nothing entered - Get another
  PUSH AF                 ; Save Carry status
  CALL ATOH               ; Get line number into DE
  CALL SKIP_BLANKS
  LD A,(HL)
  CP ' '
  CALL Z,INCHL
; This entry point is used by the routine at EDIT_DONE.
PROMPT_4:
  PUSH DE
  CALL TOKENIZE
  POP DE
  POP AF
  LD (SAVTXT),HL
  JP NC,__MERGE_2
  PUSH DE
  PUSH BC
  CALL FCERR_IF_LOADING
  CALL CHRGTB
  OR A
  PUSH AF
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL SRCHLN             ; Search for line number in DE
  JP C,LINFND             ; Jump if line found
  POP AF
  PUSH AF
  JP Z,UL_ERR
  OR A
LINFND:
  PUSH BC                 ; Save address of line in prog
  PUSH AF
  PUSH HL
  CALL LINE_2PTR
  POP HL
  POP AF
  POP BC
  PUSH BC
  CALL C,__DELETE_0
  POP DE
  POP AF
  PUSH DE
  JP Z,PROMPT_6
  POP DE
  LD A,(MEM_FLG)
  OR A
  JP NZ,PROMPT_5
  LD HL,(MEMSIZ)
  LD (FRETOP),HL
PROMPT_5:
  LD HL,(VARTAB)          ; Get end of program
  EX (SP),HL              ; Get length of input line
  POP BC                  ; End of program to BC
  PUSH HL
  ADD HL,BC               ; Find new end
  PUSH HL                 ; Save new end
  CALL MOVUP              ; Make space for line
  POP HL                  ; Restore new end
  LD (VARTAB),HL          ; Update end of program pointer
  EX DE,HL                ; Get line to move up in HL
  LD (HL),H               ; Save MSB
  POP BC
  POP DE                  ; Get new line number
  PUSH HL
  INC HL
  INC HL
  LD (HL),E               ; Save LSB of line number
  INC HL
  LD (HL),D               ; Save MSB of line number
  INC HL                  ; To first byte in line
  LD DE,KBUF              ; Copy buffer to program
  DEC BC
  DEC BC
  DEC BC
  DEC BC
MOVBUF:
  LD A,(DE)               ; Get source
  LD (HL),A               ; Save destinations
  INC HL                  ; Next source
  INC DE                  ; Next destination
  DEC BC
  LD A,C
  OR B                    ; Done?
  JP NZ,MOVBUF            ; No - Repeat
PROMPT_6:
  POP DE
  CALL UPD_PTRS_0
  LD HL,$0080
  LD (HL),$00
  LD (FILTAB),HL
  LD HL,(PTRFIL)
  LD (NXTOPR),HL
  CALL RUN_FST
  LD HL,(FILPTR)
  LD (FILTAB),HL
  LD HL,(NXTOPR)
  LD (PTRFIL),HL
  JP PROMPT


; Update interpreter pointers
;
; Used by the routines at __LOAD and L46AB.
UPD_PTRS:
  LD HL,(TXTTAB)
  EX DE,HL
; This entry point is used by the routine at PROMPT.
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
  JP Z,UPD_PTRS_3
  CP ' '
  JP NC,UPD_PTRS_1
  CP $0B			; Not a number constant prefix ?
  JP C,UPD_PTRS_1           ; ...then JP
  CALL __CHRCKB
  CALL CHRGTB
  JP UPD_PTRS_2
UPD_PTRS_3:
  INC HL
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JP UPD_PTRS_0

; Line number range
;
; Used by the routines at __LIST, __DELETE and __CHAIN.
LNUM_RANGE:
  LD DE,$0000
  PUSH DE
  JP Z,LNUM_RANGE_0
  POP DE
  CALL LNUM_PARM
  PUSH DE
  JP Z,LNUM_RANGE_1
  CALL SYNCHR
  DEFB TK_MINUS              ; token code for '-'
LNUM_RANGE_0:
  LD DE,$FFFA
  CALL NZ,LNUM_PARM
  JP NZ,SN_ERR
LNUM_RANGE_1:
  EX DE,HL
  POP DE

; Routine at 3830
;
; Used by the routine at __ON.
PHL_SRCHLN:
  EX (SP),HL
  PUSH HL

; Routine at 3832
;
; Used by the routines at PROMPT, __GO_TO, __DELETE, __RENUM, _LINE2PTR,
; __CHAIN, L46AB, __EDIT and SYNCHR.
SRCHLN:
  LD HL,(TXTTAB)        ; Start of program text

; Routine at 3835
;
; Used by the routine at __GO_TO.
SRCHLP:
  LD B,H                ; BC = Address to look at
  LD C,L                
  LD A,(HL)             ; Get address of next line
  INC HL                
  OR (HL)               ; End of program found?
  DEC HL                
  RET Z                 ; Yes - Line not found
  INC HL
  INC HL
  LD A,(HL)             ; Get LSB of line number
  INC HL                
  LD H,(HL)             ; Get MSB of line number
  LD L,A                
  CALL DCOMPR           ; Compare with line in DE
  LD H,B                ; HL = Start of this line
  LD L,C
  LD A,(HL)             ; Get LSB of next line address
  INC HL                
  LD H,(HL)             ; Get MSB of next line address
  LD L,A                ; Next line to HL
  CCF
  RET Z                 ; Lines found - Exit
  CCF                   
  RET NC                ; Line not found,at line after
  JP SRCHLP             ; Keep looking

; Routine at 3864
;
; Used by the routine at PROMPT.
TOKENIZE:
  XOR A
  LD (DONUM),A
  LD (DORES),A
  LD BC,BUF-BUFFER-5      ; BUF-BUFFER-5 = 315 bytes
  LD DE,KBUF

; Routine at 3877
;
; Used by the routines at CRNCLP, CRNCH_MORE, DETOKEN_MORE and L1164.
NXTCHR:
  LD A,(HL)               ; Get byte
  OR A                    ; End of line ?
  JP NZ,CRNCLP            ; No, continue

; Routine at 3882
;
; Used by the routine at CRNCLP.
_ENDBUF:
  LD HL,BUF-BUFFER        ; BUF-BUFFER = 320 bytes
  LD A,L
  SUB C
  LD C,A
  LD A,H
  SBC A,B
  LD B,A
  LD HL,BUFFER            ; Point to start of buffer
  XOR A
  LD (DE),A               ; Mark end of buffer (A = 00)
  INC DE
  LD (DE),A               ; A = 00
  INC DE
  LD (DE),A               ; A = 00
  RET

; Routine at 3901
;
; Used by the routine at NXTCHR.
CRNCLP:
  CP '"'                  ; Is it a quote?
  JP Z,CPYLIT             ; Yes - Copy literal string
  CP ' '                  ; Is it a space?
  JP Z,_MOVDIR            ; Yes - Copy direct
  LD A,(DORES)            ; a.k.a. OPRTYP, indicates whether stored word can be
  OR A                    ; crunched, etc..
  LD A,(HL)
  JP Z,CRNCLP_2
; This entry point is used by the routine at DETOKEN_MORE.
_MOVDIR:
  INC HL
  PUSH AF
  CALL TOKENIZE_ADD
  POP AF
  SUB ':'                 ; ":", End of statement?
  JP Z,SETLIT             ; Jump if multi-statement line
  CP $4A                  ; $4A + $3A = $84 -> TK_DATA.. Is it DATA statement ?
  JP NZ,TSTREM            ; No - see if REM
  LD A,$01
SETLIT:
  LD (DORES),A
  LD (DONUM),A
TSTREM:
  SUB $55                 ; $55 + $3A = $8F  -> TK_REM
  JP NZ,NXTCHR
  PUSH AF
CRNCLP_0:
  LD A,(HL)
  OR A
  EX (SP),HL
  LD A,H
  POP HL
  JP Z,_ENDBUF
  CP (HL)
  JP Z,_MOVDIR
CPYLIT:
  PUSH AF
  LD A,(HL)
; This entry point is used by the routine at TOKEN_BUILT.
CRNCLP_1:
  INC HL
  CALL TOKENIZE_ADD
  JP CRNCLP_0

CRNCLP_2:
  CP '?'                  ; Is it "?" short for PRINT
  LD A,TK_PRINT           ; "PRINT" token
  PUSH DE
  PUSH BC
  JP Z,MOVDIR             ; Yes - replace it
  LD DE,OPR_TOKENS
  CALL UCASE_HL
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
  CALL UCASE_HL
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
  CALL UCASE_HL
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
  CALL UCASE_HL
  LD C,A
  LD A,(DE)               ; Get byte from table
  AND $7F
  JP Z,L1164              ; JP if end of list
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
  CALL UCASE_HL
  CP '.'
  JP Z,CRNCH_MORE_0
  CALL DETOKEN_NEXT_22
CRNCH_MORE_0:
  LD A,$00
  JP NC,L1164
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
  CALL TOKENIZE_ADD
  XOR A
  LD (DONUM),A
  POP AF
  CALL TOKENIZE_ADD
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
; This entry point is used by the routine at L1164.
TOKEN_BUILT_0:
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
  CALL TOKENIZE_ADD
  LD A,TK_PLUS
TOKEN_BUILT_1:
  CP TK_APOSTROPHE			; "'" = comment (=REM)
  JP NZ,DETOKEN_MORE_10
  PUSH AF
  CALL TOKENIZE_COLON
  LD A,TK_REM
  CALL TOKENIZE_ADD
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
  JP NC,DETOKEN_MORE_8
  CP '0'
  JP C,DETOKEN_MORE_8
DETOKEN_MORE_0:
  LD A,(DONUM)
  OR A
  LD A,(HL)
  POP BC
  POP DE
  JP M,_MOVDIR
  JP Z,DETOKEN_MORE_4
  CP '.'
  JP Z,_MOVDIR
  LD A,$0E					; Line number prefix
  CALL TOKENIZE_ADD
  PUSH DE
  CALL ATOH
  CALL SKIP_BLANKS
DETOKEN_MORE_1:
  EX (SP),HL
  EX DE,HL
DETOKEN_MORE_2:
  LD A,L
  CALL TOKENIZE_ADD
  LD A,H
DETOKEN_MORE_3:
  POP HL
  CALL TOKENIZE_ADD
  JP NXTCHR

DETOKEN_MORE_4:
  PUSH DE
  PUSH BC
  LD A,(HL)
  CALL DBL_ASCTFP_0
  CALL SKIP_BLANKS
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
  CALL TOKENIZE_ADD
  LD HL,FACCU
  CALL GETYPR
  JP C,DETOKEN_MORE_6
  LD HL,FACLOW
DETOKEN_MORE_6:
  POP AF
DETOKEN_MORE_7:
  PUSH AF
  LD A,(HL)
  CALL TOKENIZE_ADD
  POP AF
  INC HL
  DEC A
  JP NZ,DETOKEN_MORE_7
  POP HL
  JP NXTCHR
DETOKEN_MORE_8:
  LD DE,WORDS_Z
DETOKEN_MORE_9:
  INC DE
  LD A,(DE)
  AND $7F
  JP Z,L1164_2
  INC DE
  CP (HL)
  LD A,(DE)
  JP NZ,DETOKEN_MORE_9
  JP L1164_3

; This entry point is used by the routine at TOKEN_BUILT.
DETOKEN_MORE_10:
  CP '&'
  JP NZ,_MOVDIR
  PUSH HL
  CALL CHRGTB
  POP HL
  CALL UCASE
  CP 'H'
  LD A,$0B				; Octal Number prefix
  JP NZ,DETOKEN_MORE_11
  LD A,$0C				; Hex Number prefix
DETOKEN_MORE_11:
  CALL TOKENIZE_ADD
  PUSH DE
  PUSH BC
  CALL HEXTFP
  POP BC
  JP DETOKEN_MORE_1

; This entry point is used by the routine at TOKEN_BUILT.
TOKENIZE_COLON:
  LD A,':'
; This entry point is used by the routines at CRNCLP, CRNCH_MORE, TOKEN_BUILT
; and L1164.
TOKENIZE_ADD:
  LD (DE),A               ; 04441: TOKENIZE_ADD
  INC DE
  DEC BC
  LD A,C
  OR B
  RET NZ
; This entry point is used by the routine at PUTBUF.
BUFOV_ERR:
  LD E,$17                ; 'Line Buffer Overflow' error entry
  JP ERROR

; Routine at 4452
;
; Used by the routine at CRNCH_MORE.
L1164:
  POP HL
  DEC HL
  DEC A
  LD (DONUM),A
  POP BC
  POP DE
  CALL UCASE_HL
L1164_0:
  CALL TOKENIZE_ADD
  INC HL
  CALL UCASE_HL
  CALL IS_ALPHA_A
  JP NC,L1164_0       ; JP if letter
  CP '9'+1
  JP NC,L1164_1
  CP '0'
  JP NC,L1164_0
  CP '.'
  JP Z,L1164_0
L1164_1:
  JP NXTCHR

; This entry point is used by the routine at DETOKEN_MORE.
L1164_2:
  LD A,(HL)
  CP ' '
  JP NC,L1164_3
  CP $09
  JP Z,L1164_3
  CP $0A
  JP Z,L1164_3
  LD A,' '
; This entry point is used by the routine at DETOKEN_MORE.
L1164_3:
  PUSH AF
  LD A,(DONUM)
  INC A
  JP Z,L1164_4
  DEC A
L1164_4:
  JP TOKEN_BUILT_0

; Routine at 4524
;
; Used by the routines at PROMPT and DETOKEN_MORE.
SKIP_BLANKS:
  DEC HL
  LD A,(HL)
  CP ' '
  JP Z,SKIP_BLANKS
  CP $09
  JP Z,SKIP_BLANKS
  CP $0A
  JP Z,SKIP_BLANKS
  INC HL
  RET

; 'FOR' BASIC command
__FOR:
  LD A,$64                ; Flag "FOR" assignment
  LD (SUBFLG),A           ; Save "FOR" flag
  CALL GETVAR
  CALL SYNCHR
  DEFB TK_EQUAL           ; Token code for '='
  PUSH DE
  EX DE,HL
  LD (TEMP),HL
  EX DE,HL
  LD A,(VALTYP)           ; Get data type
  PUSH AF                 ; save type
  CALL EVAL
  POP AF                  ; Restore type
  PUSH HL
  CALL CHKTYP
  LD HL,FOR_ACC
  CALL FPTHL
  POP HL
  POP DE
  POP BC
  PUSH HL
  CALL __DATA             ; Get next statement address
  LD (ENDFOR),HL          ; Next address of FOR st.
  LD HL,$0002             ; Offset for "FOR" block
  ADD HL,SP               ; Point to it
FORSLP:
  CALL LOKFOR             ; Look for existing "FOR" block
  JP NZ,FORFND            ; Get code string address
  ADD HL,BC               ; No nesting found
  PUSH DE                 ; Move into "FOR" block
  DEC HL                  ; Save code string address
  LD D,(HL)
  DEC HL                  ; Get MSB of loop statement
  LD E,(HL)
  INC HL                  ; Get LSB of loop statement
  INC HL
  PUSH HL                 ; Save block address
  LD HL,(ENDFOR)          ; Get address of loop statement
  CALL DCOMPR             ; Compare the FOR loops
  POP HL                  ; Restore block address
  POP DE
  JP NZ,FORSLP            ; Different FORs - Find another
  POP DE                  ; Restore code string address
  LD SP,HL                ; Remove all nested loops
  LD (SAVSTK),HL
  DEFB $0E                ; LD C,N to mask the next byte

; Routine at 4625
;
; Used by the routine at __FOR.
FORFND:
  POP DE
  EX DE,HL                ; Code string address to HL
  LD C,$08
  CALL CHKSTK             ; Check for 8 levels of stack
  PUSH HL
  LD HL,(ENDFOR)          ; Get first statement of loop
  EX (SP),HL              ; Save and restore code string
  PUSH HL                 ; Re-save code string address
  LD HL,(CURLIN)          ; Get current line number
  EX (SP),HL              ; Save and restore code string
  CALL SYNCHR             ; Make sure "TO" is next
  DEFB TK_TO              ; "TO" token
  CALL GETYPR             ; Get the number type (FAC)
  JP Z,TM_ERR             ; If string type, Err $0D - "Type mismatch"
  JP NC,TM_ERR
  PUSH AF                 ; save type
  CALL EVAL
  POP AF                  ; Restore type
  PUSH HL
  JP P,FORFND_FP
  CALL __CINT
  EX (SP),HL
  LD DE,$0001             ; Default value for STEP
  LD A,(HL)               ; Get next byte in code string
  CP TK_STEP              ; See if "STEP" is stated
  CALL Z,FPSINT           ; If so, get updated value for 'STEP'
  PUSH DE
  PUSH HL                 ; Save code string address
  EX DE,HL
  CALL _TSTSGN_0          ; Test sign for 'STEP'
  JP FORFND_0

FORFND_FP:
  CALL __CSNG             ; Get value for 'TO'
  CALL BCDEFP             ; Move "TO" value to BCDE
  POP HL                  ; Restore code string address
  PUSH BC                 ; Save "TO" value in block
  PUSH DE
  LD BC,$8100             ; BCDE = 1 (default STEP)
  LD D,C                  ; C=0
  LD E,D                  ; D=0
  LD A,(HL)               ; Get next byte in code string
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
  PUSH BC                 ; Save the STEP value in block
  PUSH DE
  OR A
  JP NZ,SAVSTP_0
  LD A,$02
SAVSTP_0:
  LD C,A
  CALL GETYPR
  LD B,A
  PUSH BC
  DEC HL
  CALL CHRGTB
  JP NZ,SN_ERR
  CALL LOOK_FOR_NEXT
  CALL CHRGTB
  PUSH HL
  PUSH HL
  LD HL,(LOPLIN)
  LD (CURLIN),HL
  LD HL,(TEMP)            ; Get address of index variable
  EX (SP),HL              ; Save and restore code string
  LD B,TK_FOR             ; "FOR" block marker
  PUSH BC                 ; Save it
  INC SP                  ; Don't save C
  PUSH AF
  PUSH AF
  JP __NEXT_0

; "FOR" block marker
;
; Used by the routine at __NEXT.
; --- Put "FOR" block marker ---
PUTFID:
  LD B,TK_FOR             ; "FOR" block marker
  PUSH BC                 ; Save it
  INC SP                  ; Don't save C

; BASIC program execution driver (a.k.a. RUNCNT). HL points to code.
;
; Used by the routines at __LOAD, __WEND, __CALL, L46AB and KILFOR.
EXEC_EVAL:
  PUSH HL
  DEFB $CD                ; CALL nn (Test break)

; Data block at 4776
SMC_ISCNTC:
  DEFW $0000

; Routine at 4778
L12AA:
  POP HL
  OR A                    ; Break key hit?
  CALL NZ,STALL           ; Yes - Pause for a key
  LD (SAVTXT),HL          ; Save code address for break
  EX DE,HL
  LD HL,$0000
  ADD HL,SP
  LD (SAVSTK),HL
  EX DE,HL
  LD A,(HL)
  CP ':'                  ; ':'  .. Multi statement line?
  JP Z,EXEC               ; Yes - Execute it
  OR A                    ; End of line?
  JP NZ,SN_ERR            ; No - Syntax error
  INC HL                  ; Point to address of next line
; This entry point is used by the routine at ERROR_3.
L12AA_0:
  LD A,(HL)
  INC HL
  OR (HL)                 ; Is it zero (End of prog)?
  JP Z,PRG_END            ; Yes - Terminate execution
  INC HL                  ; Point to line number
  LD E,(HL)               ; Get LSB of line number
  INC HL
  LD D,(HL)               ; Get MSB of line number
  EX DE,HL                ; Line number to HL
  LD (CURLIN),HL          ; Save as current line number
  LD A,(TRCFLG)
  OR A
  JP Z,NO_TRACE
  PUSH DE                 ; If "TRACE" is ON, then print current line number between brackets
  LD A,'['
  CALL OUTDO
  CALL _PRNUM
  LD A,']'
  CALL OUTDO
  POP DE
NO_TRACE:
  EX DE,HL                ; Line number back to DE

; Routine at 4843
;
; Used by the routines at L12AA and __MERGE.
EXEC:
  CALL CHRGTB             ; Get key word
  LD DE,EXEC_EVAL         ; Where to RETurn to
  PUSH DE                 ; Save for RETurn
  RET Z                   ; Go to EXEC_EVAL (RUNCNT) if end of STMT
; This entry point is used by the routines at __ON and __IF.
ONJMP:
  SUB TK_END              ; $81 = TK_END .. is it a token?
  JP C,__LET              ; No - try to assign it
IF ZXPLUS3
  CP TK_VPOKE+1-TK_END    ; END to VPOKE ?
ELSE
  CP TK_RESET+1-TK_END    ; END to RESET ?
ENDIF
  JP NC,MORE_STMT         ; Not a key word - ?SN Error
  RLCA                    ; Double it
  LD C,A                  ; BC = Offset into table
  LD B,$00
  EX DE,HL                ; Save code string address
  LD HL,FNCTAB            ; Function routine addresses
  ADD HL,BC               ; Point to right address
  LD C,(HL)               ; Get LSB of address
  INC HL
  LD B,(HL)
  PUSH BC                 ; Get MSB of address
  EX DE,HL                ; Restore code string address

; Pick next char from program
;
; Used by the routines at PROMPT, UPD_PTRS, CRNCLP, DETOKEN_MORE, SAVSTP, EXEC,
; DEFVAL, GET_POSINT, FC_ERR, ATOH, __REM, __ON, __RESUME, __IF, __PRINT,
; __TAB, NEXITM, __INPUT, INPUT_SUB, __READ, __READ_DONE, LTSTND, FDTLP, _EVAL,
; OPRND, __ERR, __ERL, HEXTFP, OPRND_3, FN_USR, __DEF, DOFN, __WAIT, __WIDTH,
; FPSINT, FNDNUM, MAKINT, _PRS, LINE2PTR_1, _LINE2PTR, __OPTION, LOOK_FOR, _ASCTFP,
; PUFOUT, L3338, RND_SUB, __OPEN, GET_CHNUM, LINE_INPUT, __LOAD, __MERGE,
; CLOSE_FILE, FN_INPUT, __WHILE, __CALL, __CHAIN, L45C9, L46AB, __GET, PUTBUF,
; FN_INKEY, DIMRET, GVAR, SBSCPT, L5256, __ERASE, __CLEAR, KILFOR, DTSTR,
; FN_STRING, __VAL, FN_INSTR and BASIC_ENTRY.
CHRGTB:
  INC HL                  ; Point to next character
; This entry point is used by the routine at UPD_PTRS.
__CHRCKB:
  LD A,(HL)               ; Get next code string byte
  CP '9'+1
  RET NC                  ; NC if > "9"
; This entry point is used by the routine at SYNCHR.
CHRGTB_1:
  CP ' '
  JP Z,CHRGTB             ; Skip over spaces
  JP NC,CHRGTB_10         ; NC if < "0"
  OR A                    ; Test for zero - Leave carry
  RET Z
  CP $0B                  ; Not a number constant prefix ?
  JP C,CHRGTB_9           ; ...then JP
  CP $1E                  ; TK_CINT ? .. CURS_UP ?
  JP NZ,CHRGTB_2
  LD A,(CONSAV)           ; Store token of constant after calling CHRGET
  OR A
  RET

CHRGTB_2:
  CP $10                  ; TK_INP ?
  JP Z,CHRGTB_7
  PUSH AF
  INC HL
  LD (CONSAV),A           ; Store token of constant after calling CHRGET
  SUB $1C                 ; Prefix $1C -> Integer between 256 and 32767
  JP NC,CHRGTB_8          ; Jump if constant is bigger than 255, (prefixes 1CH, 1DH 1FH).
  SUB $F5                 ; SUB -$0B ..-> ADD $0B ?
  JP NC,CHRGTB_3
  CP $FE
  JP NZ,CHRGTB_5
  LD A,(HL)
  INC HL
CHRGTB_3:
  LD (CONTXT),HL          ; Text address used by CHRGTB
  LD H,$00
CHRGTB_4:
  LD L,A
  LD (CONLO),HL           ; Value of stored constant
  LD A,$02                ; Integer
  LD (CONTYP),A           ; Type of stored constant
  LD HL,L1392
  POP AF
  OR A
  RET

CHRGTB_5:
  LD A,(HL)
  INC HL
  INC HL
  LD (CONTXT),HL
  DEC HL
  LD H,(HL)
  JP CHRGTB_4

; This entry point is used by the routine at OPRND.
CHRGTB_6:
  CALL CHRGTB_11
CHRGTB_7:
  LD HL,(CONTXT)
  JP __CHRCKB

CHRGTB_8:
  INC A
  RLCA
  LD (CONTYP),A
  PUSH DE
  PUSH BC
  LD DE,CONLO
  EX DE,HL
  LD B,A
  CALL CPY2HL
  EX DE,HL
  POP BC
  POP DE
  LD (CONTXT),HL
  POP AF
  LD HL,L1392
  OR A
  RET
  
CHRGTB_9:
  CP $09
  JP NC,CHRGTB
CHRGTB_10:
  CP '0'
  CCF
  INC A
  DEC A
  RET

L1392:
  LD E,$10

; This entry point is used by the routine at _PRS.
CHRGTB_11:
  LD A,(CONSAV)
  CP $0F
  JP NC,CHRGTB_13
  CP $0D
  JP C,CHRGTB_13
  LD HL,(CONLO)
  JP NZ,CHRGTB_12
  INC HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
CHRGTB_12:
  JP DBL_ABS_0

CHRGTB_13:
  LD A,(CONTYP)
  LD (VALTYP),A
  CP $08
  JP Z,CHRGTB_14
  LD HL,(CONLO)
  LD (FACCU),HL
  LD HL,(CONLO+2)
  LD (FACCU+2),HL
  RET
  
CHRGTB_14:
  LD HL,CONLO
  JP FP_HL2DE

; 'DEFSTR' BASIC function
__DEFSTR:
  LD E,$03
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'DEFINT' BASIC function
__DEFINT:
  LD E,$02
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'DEFSNG' BASIC function
__DEFSNG:
  LD E,$04
  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; 'DEFDBL' BASIC function
__DEFDBL:
  LD E,$08

; Routine at 5082
DEFVAL:
  CALL IS_ALPHA
  LD BC,SN_ERR
  PUSH BC
  RET C
  SUB 'A'
  LD C,A
  LD B,A
  CALL CHRGTB
  CP TK_MINUS              ; token code for '-'
  JP NZ,DEFVAL_0
  CALL CHRGTB
  CALL IS_ALPHA
  RET C
  SUB 'A'
  LD B,A
  CALL CHRGTB
DEFVAL_0:
  LD A,B
  SUB C
  RET C
  INC A
  EX (SP),HL
  LD HL,DEFTBL
  LD B,$00
  ADD HL,BC
DEFVAL_1:
  LD (HL),E
  INC HL
  DEC A
  JP NZ,DEFVAL_1
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  CALL CHRGTB
  JP DEFVAL

; Get subscript
;
; Used by the routines at L46AB, __GET and SBSCPT.
GET_POSINT:
  CALL CHRGTB
; This entry point is used by the routine at __CLEAR.
GET_POSINT_0:
  CALL FPSINT_0
  RET P

; Err $05 - "Illegal function call"
;
; Used by the routines at __ERROR, __AUTO, __ERL, DOFN, MAKINT, __DELETE,
; __RENUM, __LOG, __NAME, __CVD, FN_INPUT, __CHAIN, L45A2, L46AB, __GET,
; __USING, L5256, __TROFF, __CLEAR, __ASC, __MID_S, FN_INSTR and BASIC_ENTRY.
FC_ERR:
  LD E,$05
  JP ERROR

; This entry point is used by the routines at LNUM_RANGE, __AUTO, __RENUM and
; __EDIT.
LNUM_PARM:
  LD A,(HL)
  CP '.'
  EX DE,HL
  LD HL,(DOT)
  EX DE,HL
  JP Z,CHRGTB

; ASCII to Integer, result in DE
;
; Used by the routines at PROMPT, DETOKEN_MORE, __GO_SUB, __GO_TO, __ON,
; __RESUME, __AUTO, UCASE, __RENUM, PUTBUF and SYNCHR.
ATOH:
  DEC HL
; This entry point is used by the routine at __ON.
ATOH2:
  CALL CHRGTB
  CP $0E
  JP Z,LNUM_PARM_2
  CP $0D

; This entry point is used by the routines at _LINE2PTR and L2429.
LNUM_PARM_2:
  EX DE,HL
  LD HL,(CONLO)       ; Value of stored constant
  EX DE,HL
  JP Z,CHRGTB         ; Gets next character (or token) from BASIC text.
  XOR A
  LD (CONSAV),A
  LD DE,$0000         ; Get number to DE
  DEC HL

GTLNLP:
  CALL CHRGTB         ; Get next character
  RET NC              ; Exit if not a digit
  PUSH HL             ; Save code string address
  PUSH AF             ; Save digit
  LD HL,65529/10      ; Largest number 65529
  CALL DCOMPR         ; Compare HL with DE.
  JP C,OUTOF_RNG
  LD H,D
  LD L,E
  ADD HL,DE           ; *2
  ADD HL,HL           ; ..*4
  ADD HL,DE           ; ..*5
  ADD HL,HL           ; ..*10
  POP AF              ; Restore digit
  SUB $30             ; Make it 0 to 9
  LD E,A              ; DE = Value of digit
  LD D,$00        
  ADD HL,DE		      ; Add to number
  EX DE,HL            ; Number to DE
  POP HL              ; Restore code string address
  JP GTLNLP           ; Go to next character
  
OUTOF_RNG:
  POP AF
  POP HL
  RET
  
  
__RUN:
  JP Z,RUN_FST            ; RUN from start if just RUN
  CP $0E
  JP Z,__RUN_0
  CP $0D
  JP NZ,_RUN_FILE

__RUN_0:
  CALL _CLVAR             ; Initialise variables
  LD BC,EXEC_EVAL         ; Execution driver loop
  JP __GO_SUB_0           ; RUN from line number

; 'GOSUB' BASIC command
__GO_SUB:
  LD C,$03                ; 3 Levels of stack needed
  CALL CHKSTK             ; Check for 3 levels of stack
  CALL ATOH
  POP BC                  ; Get return address
  PUSH HL                 ; Save code string for RETURN
  PUSH HL                 ; And for GOSUB routine
  LD HL,(CURLIN)          ; Get current line
  EX (SP),HL              ; Into stack - Code string out
  LD A,TK_GOSUB           ; "GOSUB" token
  PUSH AF                 ; Save token
  INC SP                  ; Don't save flags
  PUSH BC                 ; Save return address
  JP __GO_TO_0
  
; This entry point is used by the routine at ATOH.
__GO_SUB_0:
  PUSH BC                 ; Save return address

; 'GOTO' BASIC command
;
; Used by the routine at __IF.
__GO_TO:
  CALL ATOH               ; ASCII number to DE binary
; This entry point is used by the routines at __GO_SUB and __RESUME.
__GO_TO_0:
  LD A,(CONSAV)
  CP $0D
  EX DE,HL
  RET Z
  CP $0E                  ; Line number prefix
  JP NZ,SN_ERR
  EX DE,HL
  PUSH HL
  LD HL,(CONTXT)
  EX (SP),HL
  CALL __REM              ; Get end of line
  INC HL                  ; Start of next line
  PUSH HL                 ; Save Start of next line
  LD HL,(CURLIN)          ; Get current line
  CALL DCOMPR             ; Line after current?
  POP HL                  ; Restore Start of next line
  CALL C,SRCHLP           ; Line is after current line
  CALL NC,SRCHLN          ; Line is before current line
  JP NC,UL_ERR            ; Err $08 - "Undefined line number"
  DEC BC                  ; Incremented after
  LD A,$0D
  LD (PTRFLG),A
  POP HL
  CALL L2429_1
  LD H,B
  LD L,C
  RET

; entry for '?UL ERROR'
;
; Used by the routines at PROMPT, __GO_TO, __ON, L46AB, __EDIT and SYNCHR.
UL_ERR:
  LD E,$08                ; Err $08 - "Undefined line number"
  JP ERROR

; label=__RETURN
__RETURN:
  RET NZ                  ; Return if not just RETURN
  LD D,$FF                ; Flag "GOSUB" search
  CALL BAKSTK             ; Look "GOSUB" block
  LD SP,HL                ; Kill all FORs in subroutine
  LD (SAVSTK),HL
  CP TK_GOSUB             ; TK_GOSUB, Token for 'GOSUB'
  LD E,$03                ; Err $03 - "RETURN without GOSUB"
  JP NZ,ERROR             ; Error if no "GOSUB" found
  POP HL                  ; Get RETURN line number
  LD (CURLIN),HL          ; Save as current
  LD HL,EXEC_EVAL         ; Execution driver loop
  EX (SP),HL              ; Into stack - Code string out
  DEFB $3E                ; "LD A,n" to Mask the next byte
NXTDTA:
  POP HL                  ; 5361

; 'COMMON' and 'DATA' BASIC instructions
;
; Used by the routines at __FOR, __RESUME, __IF, FDTLP, __DEF, __CHAIN and
; L46AB.
__DATA:
  DEFB $01,$3A            ; LD BC,$0E3A  -> C=":", End of statement

; __ELSE, __REM
;
; Used by the routines at SUB_13_ERR and __GO_TO.
__REM:
  DEFB $0E,$00            ; LD C,0  -> 00  End of statement
  LD B,$00
NXTSTL:
  LD A,C                  ; Statement and byte
  LD C,B
  LD B,A                  ; Statement end byte
__REM_0:
  DEC HL
__REM_1:
  CALL CHRGTB             ; Get byte
  OR A                    ; End of line?
  RET Z                   ; Yes - Exit
  CP B                    ; End of statement?
  RET Z                   ; Yes - Exit
  INC HL                  ; Next byte
  CP '"'                  ; Literal string?
  JP Z,NXTSTL             ; Yes - Look for another '"'
  INC A
  JP Z,__REM_1
  SUB TK_RESTORE
  JP NZ,__REM_0
  CP B
  ADC A,D
  LD D,A
  JP __REM_0              ; Keep looking

; $1518
__LET_00:
  POP AF
  ADD A,$03
  JP __LET_0

; 'LET' BASIC command
;
; Used by the routine at EXEC.
__LET:
  CALL GETVAR
  CALL SYNCHR
  DEFB TK_EQUAL           ; Token code for '='
  EX DE,HL
  LD (TEMP),HL
  EX DE,HL
  PUSH DE
  LD A,(VALTYP)
  PUSH AF
  CALL EVAL
  POP AF
; This entry point is used by the routines at __LET_00 and __LINE.
__LET_0:
  EX (SP),HL
; This entry point is used by the routine at __READ_DONE.
__LET_1:
  LD B,A
  LD A,(VALTYP)
  CP B
  LD A,B
  JP Z,__LET_3
  CALL CHKTYP
; This entry point is used by the routine at DOFN.
__LET_2:
  LD A,(VALTYP)
__LET_3:
  LD DE,FACCU
  CP $05                  ; Integer ?
  JP C,__LET_4
  LD DE,FACLOW
__LET_4:
  PUSH HL
  CP $03                  ; String ?
  JP NZ,LETNUM
  LD HL,(FACCU)           ; Pointer to string entry
  PUSH HL                 ; Save it on stack
  INC HL                  ; Skip over length
  LD E,(HL)               ; LSB of string address
  INC HL
  LD D,(HL)               ; MSB of string address
  LD HL,(TXTTAB)
  CALL DCOMPR
  JP NC,__LET_5
  LD HL,(STREND)
  CALL DCOMPR
  POP DE
  JP NC,MVSTPT
  LD HL,DSCTMP
  CALL DCOMPR
  JP NC,MVSTPT
  DEFB $3E                ; "LD A,n" to Mask the next byte
__LET_5:
  POP DE
  CALL BAKTMP
  EX DE,HL
  CALL SAVSTR_0
MVSTPT:
  CALL BAKTMP
  EX (SP),HL
LETNUM:
  CALL FP2HL
  POP DE
  POP HL
  RET

; 'ON' BASIC instruction
__ON:
  CP TK_ERROR
  JP NZ,ON_OTHER
  CALL CHRGTB
  CALL SYNCHR
  DEFB TK_GOTO
  CALL ATOH
  LD A,D
  OR E
  JP Z,__ON_0
  CALL PHL_SRCHLN
  LD D,B
  LD E,C
  POP HL
  JP NC,UL_ERR
__ON_0:
  EX DE,HL
  LD (ONELIN),HL
  EX DE,HL
  RET C
  LD A,(ONEFLG)
  OR A
  LD A,E
  RET Z
  LD A,(ERRFLG)
  LD E,A
  JP ERROR_1

ON_OTHER:
  CALL GETINT             ; Get integer 0-255
  LD A,(HL)               ; Get "GOTO" or "GOSUB" token
  LD B,A                  ; Save in B
  CP TK_GOSUB             ; "GOSUB" token?
  JP Z,ONGO               ; Yes - Find line number
  CALL SYNCHR             ; Make sure it's "GOTO"
  DEFB TK_GOTO            ; "GOTO" token
  DEC HL                  ; Cancel increment
ONGO:
  LD C,E                  ; Integer of branch value
ONGOLP:
  DEC C                   ; Count branches
  LD A,B                  ; Get "GOTO" or "GOSUB" token
  JP Z,ONJMP              ; Go to that line if right one
  CALL ATOH2              ; Get line number to DE
  CP ','                  ; Another line number?
  RET NZ                  ; No - Drop through
  JP ONGOLP               ; Yes - loop

; 'RESUME' BASIC command
__RESUME:
  LD A,(ONEFLG)
  OR A
  JP NZ,__RESUME_0
  LD (ONELIN),A
  LD (ONELIN+1),A
  JP RW_ERR

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
  CALL __GO_TO_0
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
  RET Z                   ; Go to EXEC_EVAL (RUNCNT) if end of STMT
  CP $0E                  ; Line number prefix ?
  JP Z,__GO_TO            ; Yes - GOTO that line
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
  LD A,(NTMSXP)           ; Value for 'WIDTH' on printer output.
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
  LD A,(CLMLST)           ; Value for 'WIDTH' on screen output (255="infinite").
  LD B,A
  LD A,(TTYPOS)
  CP $FF
  JP Z,ZONELP
  CP B
PRNTNB_1:
  CALL NC,OUTDO_CRLF
  JP NC,NEXITM
ZONELP:
  SUB $0E                 ; Next zone of 14 characters
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
  LD A,(NTMSXP)           ; Value for 'WIDTH' on printer output.
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
; WARM_ENTRY.
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
  JP C,CHRGTB_6           ; JP if control code
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
; Used by the routines at CRNCLP, CRNCH_MORE, L1164 and BASIC_ENTRY.
UCASE_HL:
  LD A,(HL)

; Make char in 'A' upper case
;
; Used by the routines at DETOKEN_MORE, HEXTFP and __EDIT_5.
UCASE:
  CP $61
  RET C
  CP $7B
  RET NC
  AND $5F
  RET

; This entry point is used by the routine at BASIC_ENTRY.
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
  LD BC,BOOL_RESULT
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
; Used by the routines at __ERR, MORE_STMT, __DELETE, __LOF and __VAL.
PASSA:
  LD L,A
  XOR A
; This entry point is used by the routine at __LOC.
BOOL_RESULT:
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
  CALL SAVSTR_0
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
MORE_STMT:
  CP $7E				; (+ $81 =$FF)
  JP NZ,SN_ERR
  INC HL
  LD A,(HL)
  INC HL
  CP $83				; (+ $81 =$04  ...TK_SGN??)
  JP Z,FN_INSTR_6
  JP SN_ERR

__INP:
  CALL MAKINT
  LD (INPORT),A
  DEFB $DB                ; IN A,(n)
INPORT:
  DEFB $00                ; Current port for 'INP' function
  JP PASSA

; 'OUT' BASIC command
__OUT:
  CALL GTINT_GTINT
  DEFB $D3                ; OUT (n),A
OTPORT:
  DEFB $00                ; Current port for 'OUT' statement
  RET

; 'WAIT' BASIC command
__WAIT:
  CALL GTINT_GTINT
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

IF ORIGINAL
  JP SN_ERR			; ???
ENDIF


; 'WIDTH' BASIC command
;
; WIDTH [LPRINT] <integer expression>
; To set the printed line width in number of characters for the terminal or line printer.
;
__WIDTH:
  CP TK_LPRINT
  JP NZ,__WIDTH_0
  CALL CHRGTB
  CALL GETINT             ; Get integer 0-255
  LD (NTMSXP),A           ; Value for 'WIDTH' on printer output.
  LD E,A
  CALL __WIDTH_1
  LD (COMMAN),A
  RET

__WIDTH_0:
  CALL GETINT             ; Get integer 0-255
  LD (LINLEN),A
  LD E,A
  CALL __WIDTH_1
  LD (CLMLST),A           ; Value for 'WIDTH' on screen output.
  RET

__WIDTH_1:
  SUB $0E
  JP NC,__WIDTH_1
  ADD A,$1C
  CPL
  INC A
  ADD A,E
  RET


; Get subscript
;
; Used by the routine at FORFND.
FPSINT:
  CALL CHRGTB
; This entry point is used by the routines at GET_POSINT and __TAB.
FPSINT_0:
  CALL EVAL

; Get integer variable to DE, error if negative
;
; Used by the routine at MAKINT.
DEPINT:
  PUSH HL
  CALL __CINT
  EX DE,HL
  POP HL
  LD A,D
  OR A
  RET

; Get "BYTE,BYTE" parameters
;
; Used by the routines at __OUT and __WAIT.
GTINT_GTINT:
  CALL GETINT             ; Get integer 0-255
  LD (WAIT_INPORT),A
  LD (OTPORT),A
  CALL SYNCHR
  DEFM ","
  JP GETINT             ; Get integer 0-255

; Load 'A' with the next number in BASIC program
;
; Used by the routines at __ERL and __FIELD.
; Numeric argument (0..255)
FNDNUM:
  CALL CHRGTB

; Get a number to 'A'
;
; Used by the routines at __ON, __ERROR, OPRND_3, __WAIT, __WIDTH,
; GTINT_GTINT, __POKE, __OPEN, CLOSE_FILE, FN_INPUT, __NULL, FN_STRING,
; FN_INSTR and MID_ARGSEP.
GETINT:
  CALL EVAL

; Convert tmp string to int in A register
;
; Used by the routines at MORE_STMT, GET_CHNUM, __CHR_S, FN_STRING, __SPACE_S
; and FN_INSTR.
MAKINT:
  CALL DEPINT
  JP NZ,FC_ERR
  DEC HL
  CALL CHRGTB
  LD A,E
  RET


__LLIST:
  LD A,$01                ; 'LLIST' BASIC command
  LD (PRTFLG),A

; 'LIST' BASIC command
;
; Used by the routine at __MERGE.
__LIST:
  POP BC
  CALL LNUM_RANGE
  PUSH BC
  CALL FCERR_IF_LOADING
__LIST_0:
  LD HL,$FFFF
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
  CALL _PRS
  CALL OUTDO_CRLF
  JP __LIST_0

; Routine at 8435
;
; Used by the routines at __LIST, TTYLIN, EDIT_SUBCMD and EDIT_DONE.
_PRS:
  LD A,(HL)
  OR A
  RET Z
  CALL _PR_CHR
  INC HL
  JP _PRS

; This entry point is used by the routines at __LIST and __EDIT.
DETOKEN_LIST:
  LD BC,BUF
  LD D,$FF
  XOR A
  LD (INTFLG),A
  CALL FCERR_IF_LOADING
  JP DETOKEN_NEXT_2
  
DETOKEN_NEXT_1:
  INC BC
  INC HL
  DEC D
  RET Z
; This entry point is used by the routine at L2223.
DETOKEN_NEXT_2:
  LD A,(HL)
  OR A
  LD (BC),A
  RET Z
  CP $0B			; Not a number constant prefix ?
  JP C,DETOKEN_NEXT_3           ; ...then JP
  CP ' '
  LD E,A
  JP C,DETOKEN_NEXT_4           ; JP if control code
DETOKEN_NEXT_3:
  OR A
  JP M,DETOKEN_NEXT_8
  LD E,A
  CP '.'
  JP Z,DETOKEN_NEXT_4
  CALL DETOKEN_NEXT_22
  JP NC,DETOKEN_NEXT_4
  XOR A
  JP DETOKEN_NEXT_6
DETOKEN_NEXT_4:
  LD A,(INTFLG)
  OR A
  JP Z,DETOKEN_NEXT_5
  INC A
  JP NZ,DETOKEN_NEXT_5
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  RET Z
DETOKEN_NEXT_5:
  LD A,$01
DETOKEN_NEXT_6:
  LD (INTFLG),A
  LD A,E
  CP $0B                  ; Not a number constant prefix ?
  JP C,DETOKEN_NEXT_7           ; ...then JP
  CP ' '
  JP C,DETOKEN_NEXT_23           ; JP if control code
DETOKEN_NEXT_7:
  LD (BC),A
  JP DETOKEN_NEXT_1

DETOKEN_NEXT_8:
  INC A
  LD A,(HL)
  JP NZ,DETOKEN_NEXT_9
  INC HL
  LD A,(HL)
  AND $7F
DETOKEN_NEXT_9:
  INC HL
  CP $DB
  JP NZ,DETOKEN_NEXT_10
  DEC BC
  DEC BC
  DEC BC
  DEC BC
  INC D
  INC D
  INC D
  INC D
DETOKEN_NEXT_10:
  CP TK_ELSE
  CALL Z,DCBCDE_0
  CP TK_WHILE
  JP NZ,FNDWRD
  LD A,(HL)
  INC HL
  CP TK_PLUS			; Token for '+'
  LD A,TK_WHILE
  JP Z,FNDWRD
  DEC HL
FNDWRD:
  PUSH HL
  PUSH BC
  PUSH DE                 ; Look for reserved words
  LD HL,WORDS-1             ; Point to table
  LD B,A
  LD C,$40
DETOKEN_NEXT_11:
  INC C
DETOKEN_NEXT_12:
  INC HL
  LD D,H
  LD E,L
DETOKEN_NEXT_13:
  LD A,(HL)
  OR A
  JP Z,DETOKEN_NEXT_11
  INC HL
  JP P,DETOKEN_NEXT_13
  LD A,(HL)
  CP B
  JP NZ,DETOKEN_NEXT_12
  EX DE,HL
  CP TK_USR
  JP Z,DETOKEN_NEXT_14
  CP TK_FN
DETOKEN_NEXT_14:
  LD A,C
  POP DE
  POP BC
  LD E,A
  JP NZ,DETOKEN_NEXT_15
  LD A,(INTFLG)
  OR A
  LD A,$00
  LD (INTFLG),A
  JP DETOKEN_NEXT_17

DETOKEN_NEXT_15:
  CP $5B		; '[' ?  .. 'Z'+1?
  JP NZ,DETOKEN_NEXT_16
  XOR A
  LD (INTFLG),A
  JP DETOKEN_NEXT_19

DETOKEN_NEXT_16:
  LD A,(INTFLG)
  OR A
  LD A,$FF
  LD (INTFLG),A
DETOKEN_NEXT_17:
  JP Z,DETOKEN_NEXT_18
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP Z,POPAF
  
DETOKEN_NEXT_18:
  LD A,E
  JP DETOKEN_NEXT_20
DETOKEN_NEXT_19:
  LD A,(HL)
  INC HL
  LD E,A
DETOKEN_NEXT_20:
  AND $7F
  LD (BC),A
  INC BC
  DEC D
  JP Z,POPAF
  OR E
  JP P,DETOKEN_NEXT_19
  CP $A8
  JP NZ,DETOKEN_NEXT_21
  XOR A
  LD (INTFLG),A
DETOKEN_NEXT_21:
  POP HL
  JP DETOKEN_NEXT_2

; This entry point is used by the routine at CRNCH_MORE.
DETOKEN_NEXT_22:
  CALL IS_ALPHA_A
  RET NC		; RET if letter
  CP '0'
  RET C
  CP '9'+1
  CCF
  RET

DETOKEN_NEXT_23:
  DEC HL
  CALL CHRGTB
  PUSH DE
  PUSH BC
  PUSH AF
  CALL CHRGTB_11
  POP AF
  LD BC,L2223
  PUSH BC
  CP $0B             ; Octal number constant prefix ?
  JP Z,OCT_STR       
  CP $0C             ; Hex numeric constant prefix ?
  JP Z,HEX_STR       
  LD HL,(CONLO)      ; Value of stored constant
  JP FOUT

; 8739
L2223:
  POP BC
  POP DE
  LD A,(CONSAV)
  LD E,'O'           ; Octal numeric constant prefix ?
  CP $0B             
  JP Z,L2223_0       ; Hex numeric constant prefix ?
  CP $0C
  LD E,'H'
  JP NZ,L2223_1
L2223_0:
  LD A,'&'
  LD (BC),A
  INC BC
  DEC D
  RET Z
  LD A,E
  LD (BC),A
  INC BC
  DEC D
  RET Z
L2223_1:
  LD A,(CONTYP)     		; Type of stored constant
  CP $04            		; Single precision ?
  LD E,$00
  JP C,L2223_2
  LD E,'!'
  JP Z,L2223_2
  LD E,'#'
L2223_2:
  LD A,(HL)
  CP ' '
  CALL Z,INCHL
L2223_3:
  LD A,(HL)
  INC HL
  OR A
  JP Z,L2223_6
  LD (BC),A
  INC BC
  DEC D
  RET Z
  LD A,(CONTYP)
  CP $04
  JP C,L2223_3
  DEC BC
  LD A,(BC)
  INC BC
  JP NZ,L2223_4
  CP '.'                    ; $2E
  JP Z,L2223_5              
L2223_4:                    
  CP 'D'					; Double Precision specifier (exponential syntax, e.g. -1.09432D-06)
  JP Z,L2223_5              
  CP 'E'					; Exponential format specifier (e.g. -1.09E-06)
  JP NZ,L2223_3
L2223_5:
  LD E,$00
  JP L2223_3
  
L2223_6:
  LD A,E
  OR A
  JP Z,L2223_7
  LD (BC),A
  INC BC
  DEC D
  RET Z
L2223_7:
  LD HL,(CONTXT)
  JP DETOKEN_NEXT_2

; 'DELETE' BASIC command
__DELETE:
  CALL LNUM_RANGE
  PUSH BC
  CALL LINE_2PTR
  POP BC
  POP DE
  PUSH BC
  PUSH BC
  CALL SRCHLN
  JP NC,__DELETE_00
  LD D,H
  LD E,L
  EX (SP),HL
  PUSH HL
  CALL DCOMPR
__DELETE_00:
  JP NC,FC_ERR
  LD HL,OK_MSG
  CALL PRS
  POP BC
  LD HL,PROMPT_6
  EX (SP),HL
; This entry point is used by the routines at PROMPT and L46AB.
__DELETE_0:
  EX DE,HL
  LD HL,(VARTAB)
__DELETE_1:
  LD A,(DE)
  LD (BC),A
  INC BC
  INC DE
  CALL DCOMPR
  JP NZ,__DELETE_1
  LD H,B
  LD L,C
  LD (VARTAB),HL
  RET

__PEEK:
  CALL GETWORD_HL
  CALL ADDR_RANGE
  LD A,(HL)
  JP PASSA

; 'POKE' BASIC command
__POKE:
  CALL GETWORD
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
  LD BC,__CINT
  PUSH BC
  CALL GETYPR
  RET M
  LD A,(FPEXP)
  CP $90
  RET NZ
  CALL SIGN
  RET M
  CALL __CSNG
  LD BC,$9180		; -65536
  LD DE,$0000
  JP FADD

; 'RENUM' BASIC command
__RENUM:
  LD BC,$000A
  PUSH BC
  LD D,B
  LD E,B
  JP Z,__RENUM_1
  CP ','
  JP Z,__RENUM_0
  PUSH DE
  CALL LNUM_PARM
  LD B,D
  LD C,E
  POP DE
  JP Z,__RENUM_1
__RENUM_0:
  CALL SYNCHR
  DEFM ","
  CALL LNUM_PARM
  JP Z,__RENUM_1
  POP AF
  CALL SYNCHR
  DEFM ","
  PUSH DE
  CALL ATOH
  JP NZ,SN_ERR
  LD A,D
  OR E
  JP Z,FC_ERR
  EX DE,HL
  EX (SP),HL
  EX DE,HL
__RENUM_1:
  PUSH BC
  CALL SRCHLN
  POP DE
  PUSH DE
  PUSH BC
  CALL SRCHLN
  LD H,B
  LD L,C
  POP DE
  CALL DCOMPR
  EX DE,HL
  JP C,FC_ERR
  POP DE
  POP BC
  POP AF
  PUSH HL
  PUSH DE
  JP __RENUM_4
  
__RENUM_3:
  ADD HL,BC
  JP C,FC_ERR
  EX DE,HL
  PUSH HL
  LD HL,$FFF9		; -7
  CALL DCOMPR
  POP HL
  JP C,FC_ERR
__RENUM_4:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  EX DE,HL
  POP DE
  JP Z,__RENUM_5
  LD A,(HL)
  INC HL
  OR (HL)
  DEC HL
  EX DE,HL
  JP NZ,__RENUM_3
__RENUM_5:
  PUSH BC
  ;CALL LINE2PTR_2  <-- MSX variant
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
  JP Z,LINE2PTR
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
  JP __RENUM_6
  
LINE2PTR:
  LD BC,RESTART
  PUSH BC
  DEFB $FE                ; 'CP $F6'  masking the next byte/instr.

LINE2PTR_0:
  DEFB $F6                ; 'OR $AF'  masking the next instruction

; Routine at 9129
;
; Used by the routines at L2429, __MERGE and __GET.
LINE2PTR_1:
  XOR A

;LINE2PTR_2:
  LD (PTRFLG),A
  LD HL,(TXTTAB)   ; Start of program text
  DEC HL
; This entry point is used by the routine at _LINE2PTR.
LINE2PTR_3:
  INC HL
  LD A,(HL)        ; Get address of next line
  INC HL           
  OR (HL)          ; End of program found?
  RET Z            ; Yes - Line not found
  INC HL
  LD E,(HL)        ; Get LSB of line number
  INC HL           
  LD D,(HL)        ; Get MSB of line number
; This entry point is used by the routine at _LINE2PTR.
LINE2PTR_4:
  CALL CHRGTB

; Line number to pointer
_LINE2PTR:
  OR A
  JP Z,LINE2PTR_3
  LD C,A
  LD A,(PTRFLG)
  OR A
  LD A,C
  JP Z,L2429
  CP TK_ERROR
  JP NZ,_LINE2PTR_0
  CALL CHRGTB
  CP TK_GOTO
  JP NZ,_LINE2PTR
  CALL CHRGTB
  CP $0E				; Line number prefix
  JP NZ,_LINE2PTR
  PUSH DE
  CALL LNUM_PARM_2
  LD A,D
  OR E
  JP NZ,_LINE2PTR_1
  JP _LINE2PTR_3
  
_LINE2PTR_0:
  CP $0E				; Line number prefix
  JP NZ,LINE2PTR_4
  PUSH DE
  CALL LNUM_PARM_2
_LINE2PTR_1:
  PUSH HL
  CALL SRCHLN
  DEC BC
  LD A,$0D
  JP C,L2429_0
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
; This entry point is used by the routine at L2429.
_LINE2PTR_4:
  JP LINE2PTR_4

; Message at 9241
LINE_ERR_MSG:
  DEFM "Undefined line "
  DEFB $00

; Routine at 9257
;
; Used by the routine at _LINE2PTR.
L2429:
  CP $0D
  JP NZ,_LINE2PTR_4
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
  LD A,$0E
; This entry point is used by the routine at _LINE2PTR.
L2429_0:
  LD HL,_LINE2PTR_2
  PUSH HL
  LD HL,(CONTXT)
; This entry point is used by the routine at __GO_TO.
L2429_1:
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
LINE_2PTR:
  LD A,(PTRFLG)
  OR A
  RET Z
  JP LINE2PTR_1

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
  LD (LSTRND+1),HL
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
; This entry point is used by the routine at WARM_ENTRY.
DBL_ASCTFP_END_0:
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
; Used by the routines at ADDEXP, NXTARY and EDIT_SUBCMD.
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
; This entry point is used by the routines at PROMPT, L2223, PUFOUT and L3356.
INCHL:
  INC HL                  ; Used for conditional "INC HL"
  RET

; This entry point is used by the routines at __FOR, __RND and __NEXT.
FPTHL:
  LD DE,FACCU             ; Point to FPREG
; This entry point is used by the routines at DECDIV_SUB and __NEW.
DETHL4:
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
; This entry point is used by the routine at _PRS.
DCBCDE_0:
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
  CALL DETHL4
  CALL GETYPR
  JP C,DECDIV_SUB_5
  LD HL,FACLOW
  LD DE,DECDIV_CONST2
  CALL DETHL4
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
; This entry point is used by the routines at PROMPT, L12AA, __LIST, _LINE2PTR,
; __EDIT and L5F1A.
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
; Used by the routines at __PRINT, _PRS, L3356, L46AB and __STR_S.
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
  CP $30                  ; "0" character?
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
; Used by the routines at _PRS and __OCT_S.
OCT_STR:
  XOR A
  LD B,A
  DEFB $C2                ; "JP NZ,nn" to skip the next instruction (B=0)

; Hex string conversion
;
; Used by the routines at _PRS and __HEX_S.
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
  ADD A,$30               ; +'0': convert to ASCII
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
  LD HL,DBL_ASCTFP_END_0
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
  LD HL,LSTRND            ; Last random number
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
  LD (SEED+1),A            ; Re-save seed
  LD HL,LSTRND            ; (RNDTAB-4) Addition table
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
  LD HL,LSTRND            ; Save random number
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
LSTRND:
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
  CALL GET_CHNUM_3
  JP Z,BN_ERR
  CP $02
  JP Z,FMODE_ERR
__EOF_0:
  LD HL,$0027
  ADD HL,BC
  LD A,(HL)
  OR A
  JP Z,__EOF_2
  LD A,(BC)
  CP $03
  JP Z,__EOF_2
  INC HL
  LD A,(HL)
  OR A
  JP NZ,__EOF_1
  PUSH BC
  LD H,B
  LD L,C
  CALL BDOS_PH1_0
  POP BC
  JP __EOF_0
__EOF_1:
  LD A,$80
  SUB (HL)
  LD C,A
  LD B,$00
  ADD HL,BC
  INC HL
  LD A,(HL)
  SUB $1A
__EOF_2:
  SUB $01
  SBC A,A
  JP INT_RESULT_A

; This entry point is used by the routine at __LOF.
; BDOS phase 2
BDOS_PH2:
  LD D,B
  LD E,C
  INC DE
; This entry point is used by the routine at CPM_CLOSE_FILE.
BDOS_PH2_0:
  LD HL,$0027
  ADD HL,BC
  PUSH BC
  XOR A
  LD (HL),A
  CALL SETDMA
  LD A,(BDOS_FN2)		  ; 'secong' BDOS FN code, either WRITE or OPEN
  CALL BDOS_EXEC
  CP $FF
  JP Z,FL_ERR
  DEC A
  JP Z,DISK_ERR
  DEC A
  JP NZ,BDOS_PH2_1
  POP DE
  XOR A
  LD (DE),A
  LD C,$10                ; BDOS function 16 - Close file
  INC DE
  CALL $0005
  JP DSK_FULL_ERR

BDOS_PH2_1:
  INC A
  JP Z,FL_ERR
  POP BC
  LD HL,$0025
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC DE
  LD (HL),D
  DEC HL
  LD (HL),E
  RET

; Routine at 14860
;
; Used by the routine at __LOAD.
CPM_CLOSE_FILE:
  CALL GET_CHNUM_4
  JP Z,CPM_CLOSE_FILE_1
  PUSH BC
  LD A,(BC)
  LD D,B
  LD E,C
  INC DE
  PUSH DE
  CP $02
  JP NZ,CPM_CLOSE_FILE_0
  LD HL,L3A29
  PUSH HL
  PUSH HL
  LD H,B
  LD L,C
  LD A,$1A
  JP __LOF_2

L3A29:
  LD HL,$0027				; $27+$29=128
  ADD HL,BC
  LD A,(HL)
  OR A
  CALL NZ,BDOS_PH2_0
CPM_CLOSE_FILE_0:
  POP DE
  CALL SETDMA
  LD C,$10                ; BDOS function 16 - Close file
  CALL $0005
  POP BC
CPM_CLOSE_FILE_1:
  LD D,$29
  XOR A
CPM_CLOSE_FILE_2:
  LD (BC),A
  INC BC
  DEC D
  JP NZ,CPM_CLOSE_FILE_2
  RET

; 'LOC' BASIC function
__LOC:
  CALL GET_CHNUM_3
  JP Z,BN_ERR
  CP $03
  LD HL,$0026
  JP NZ,__LOC_0
  LD HL,$00AE
__LOC_0:
  ADD HL,BC
  LD A,(HL)
  DEC HL
  LD L,(HL)
  JP BOOL_RESULT

; 'LOF' BASIC function
__LOF:
  CALL GET_CHNUM_3
  JP Z,BN_ERR
  LD HL,$0010
  ADD HL,BC
  LD A,(HL)
  JP PASSA

; This entry point is used by the routine at OUTDO.
__LOF_0:
  POP HL
  POP AF
; This entry point is used by the routine at __MERGE.
__LOF_1:
  PUSH HL
  PUSH AF
  LD HL,(PTRFIL)
  LD A,(HL)
  CP $01
  JP Z,__ERASE_2
  CP $03
  JP Z,__GET_19
  POP AF
; This entry point is used by the routine at CPM_CLOSE_FILE.
__LOF_2:
  PUSH DE
  PUSH BC
  LD B,H
  LD C,L
  PUSH AF
  LD DE,$0027
  ADD HL,DE
  LD A,(HL)
  CP $80
  PUSH HL
  CALL Z,BDOS_PH2
  POP HL
  INC (HL)
  LD C,(HL)
  LD B,$00
  INC HL
  POP AF
  PUSH AF
  LD D,(HL)
  CP $0D
  LD (HL),B
  JP Z,__LOF_3
  ADD A,$E0
  LD A,D
  ADC A,B
  LD (HL),A
__LOF_3:
  ADD HL,BC
  POP AF
  POP BC
  POP DE
  LD (HL),A
  POP HL
  RET

; This entry point is used by the routine at __GET.
__LOF_4:
  DEC DE
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD (HL),$80
  INC HL
  LD (HL),$80
  POP HL
  EX (SP),HL
  LD B,H
  LD C,L
  PUSH HL
  LD A,(BDOSVER)
  OR A
  JP Z,__LOF_5
  LD HL,$0022
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD (HL),$00
  JP __LOF_8

__LOF_5:
  LD HL,$000D
  ADD HL,BC
  LD A,E
  RLA
  LD A,D
  RLA
  LD D,(HL)
  CP D
  JP Z,__LOF_7
  PUSH DE
  PUSH AF
  PUSH HL
  PUSH BC
  LD DE,$0080
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  POP DE
  PUSH DE
  INC DE
  LD C,$10                ; BDOS function 16 - Close file
  CALL $0005
  POP DE
  POP HL
  POP AF
  LD (HL),A
  PUSH DE
  INC DE
  LD C,$0F                ; BDOS function 15 - Open file
  PUSH DE
  CALL $0005
  POP DE
  INC A
  JP NZ,__LOF_6
  LD C,$16                ; BDOS function 22 - create file
  CALL $0005
  INC A
  JP Z,FL_ERR
__LOF_6:
  POP BC
  POP DE
__LOF_7:
  LD HL,$0021
  ADD HL,BC
  LD A,E
  AND $7F
  LD (HL),A
__LOF_8:
  POP HL
  LD A,(RWFLG)
  OR A
  JP NZ,__LOF_9
  CALL BDOS_PH1_0
  POP HL
  RET

__LOF_9:
  LD HL,$0021
  ADD HL,BC
  LD A,(HL)
  CP $7F
  PUSH AF
  LD DE,$0080
  LD HL,$0029
  ADD HL,BC
  PUSH DE
  PUSH HL
  CALL Z,__LOF_10
  CALL BDOS_PH2
  POP DE
  POP HL
  POP AF
  CALL Z,__LOF_10
  POP HL
  JP FINPRT
__LOF_10:
  PUSH BC
  LD B,$80
__LOF_11:
  LD A,(HL)
  INC HL
  LD (DE),A
  INC DE
  DEC B
  JP NZ,__LOF_11
  POP BC
  RET

; Check stream buffer status before I/O operations
;
; Used by the routines at RDBYT and __LOAD.
CHECK_STREAM:
  PUSH BC
  PUSH HL
CHECK_STREAM_0:
  LD HL,(PTRFIL)
  LD A,(HL)
  CP $03
  JP Z,__GET_22
  LD BC,$0028
  ADD HL,BC
  LD A,(HL)
  OR A
  JP Z,CHECK_STREAM_1
  DEC HL
  LD A,(HL)
  INC HL
  DEC (HL)
  SUB (HL)
  LD C,A
  ADD HL,BC
  LD A,(HL)
  OR A
  POP HL
  POP BC
  RET

CHECK_STREAM_1:
  DEC HL
  LD A,(HL)
  OR A
  JP Z,CHECK_STREAM_2
  CALL BDOS_PH1
  JP NZ,CHECK_STREAM_0
CHECK_STREAM_2:
  SCF
  POP HL
  POP BC
  LD A,$1A		; EOF
  RET
  
  
; This entry point is used by the routine at __OPEN.
BDOS_PH1:
  LD HL,(PTRFIL)
; This entry point is used by the routines at __EOF and __LOF.
BDOS_PH1_0:
  PUSH DE
  LD D,H
  LD E,L
  INC DE
  LD BC,$0025
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC BC
  DEC HL
  LD (HL),C
  INC HL
  LD (HL),B
  INC HL
  INC HL
  PUSH HL
  LD C,$80
  
BDOS_PH1_1:
  INC HL
  LD (HL),$00
  DEC C
  JP NZ,BDOS_PH1_1
  CALL SETDMA
  LD A,(BDOS_FN1)          ; 'first' BDOS FN code, either for READ or SELECT
  CALL BDOS_EXEC           ; Get next file record
  OR A
  LD A,$00
  JP NZ,BDOS_PH1_2
  LD A,$80
BDOS_PH1_2:
  POP HL
  LD (HL),A
  DEC HL
  LD (HL),A
  OR A
  POP DE
  RET

; Set DMA address
;
; Used by the routines at __EOF, CPM_CLOSE_FILE, CHECK_STREAM and __OPEN.
SETDMA:
  PUSH BC
  PUSH DE
  PUSH HL
  LD HL,$0028
  ADD HL,DE
  EX DE,HL
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  POP HL
  POP DE
  POP BC
  RET

; Read byte, C flag is set if EOF
;
; Used by the routines at LINE_INPUT, __LOAD, __MERGE, FN_INPUT and L4D05.
RDBYT:
  CALL CHECK_STREAM
  RET C
  CP $1A
  SCF
  CCF
  RET NZ
  PUSH BC
  PUSH HL
  LD HL,(PTRFIL)
  LD BC,$0027
  ADD HL,BC
  LD (HL),$00
  INC HL
  LD (HL),$00
  SCF
  POP HL
  POP BC
  RET

; Get file name, etc..
;
; Used by the routines at __NAME, __OPEN, __KILL and __FILES.
FNAME:
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD A,(HL)
  OR A
  JP Z,NM_ERR
  PUSH AF
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E
  LD E,A
  CP $02
  JP C,FNAME_0
  LD C,(HL)              ; Pick drive letter (if any) from file specifier
  INC HL
  LD A,(HL)
  DEC E
  CP ':'
  JP Z,FNAME_1
  DEC HL
  INC E
FNAME_0:
  DEC HL
  INC E
  LD C,'A'-1             ; Force to '0' (default) if no drv letter in the filename
FNAME_1:
  DEC E
  JP Z,NMERR
  LD A,C                 ; Get drive letter as written in file specifier
  AND $DF                ; Convert..
  SUB 'A'-1              ; ..to drive number.
  JP C,NMERR
  CP $1B
  JP NC,NMERR
  LD BC,FCB_FILE
  LD (BC),A              ; Set drive number
  INC BC                 ; Point to name
  LD D,$0B
FNAME_2:
  INC HL
FNAME_3:
  DEC E
  JP M,FNAME_8
  LD A,(HL)
  CP '.'
  JP NZ,FNAME_4
  CALL FNAME_7
  POP AF
  SCF
  PUSH AF
  JP FNAME_2

FNAME_4:
  LD (BC),A
  INC BC
  INC HL
  DEC D
  JP NZ,FNAME_3
FNAME_5:
  LD HL,FCB_EXTENT
  LD B,$15
FNAME_6:
  LD (HL),$00
  INC HL
  DEC B
  JP NZ,FNAME_6
  POP AF
  POP HL
  RET
  
FNAME_7:
  LD A,D
  CP 11
  JP Z,NMERR
  CP 3
  JP C,NMERR
  RET Z
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP FNAME_7

FNAME_8:
  INC D
  DEC D
  JP Z,FNAME_5
FNAME_9:
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP NZ,FNAME_9
  JP FNAME_5
  
NMERR:
  JP NM_ERR

; 'NAME' BASIC command  (file rename)
__NAME:
  CALL FNAME
  PUSH HL
  LD DE,$0080
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  LD DE,FCB_FILE
  LD C,$0F                ; BDOS function 15 - Open file
  CALL $0005
  INC A
  JP Z,FF_ERR
  LD HL,FCB_COPY
  LD DE,FCB_FILE
  LD B,$0C
__NAME_0:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC B
  JP NZ,__NAME_0
  POP HL
  CALL SYNCHR
  DEFM "A"
  CALL SYNCHR
  DEFM "S"
  CALL FNAME
  PUSH HL
  LD A,(FCB_FILE)
  LD HL,FCB_COPY
  CP (HL)
  JP NZ,FC_ERR
  LD DE,FCB_FILE
  LD C,$0F                ; BDOS function 15 - Open file
  CALL $0005
  INC A
  JP NZ,FILE_EXISTS_ERR
  LD C,$17                ; BDOS function 23 - Rename file
  LD DE,FCB_COPY
  CALL $0005
  POP HL
  RET

; label='OPEN' BASIC command
__OPEN:
  LD BC,FINPRT
  PUSH BC
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD A,(HL)
  OR A
  JP Z,FMODE_ERR
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD A,(BC)
  AND $DF
  LD D,$02
  CP 'O'
  JP Z,__OPEN_0
  LD D,$01
  CP 'I'
  JP Z,__OPEN_0
  LD D,$03
  CP 'R'
  JP NZ,FMODE_ERR
__OPEN_0:
  POP HL
  CALL SYNCHR
  DEFM ","
  PUSH DE
  CP '#'
  CALL Z,CHRGTB
  CALL GETINT             ; Get integer 0-255
  CALL SYNCHR
  DEFM ","
  LD A,E
  OR A
  JP Z,BN_ERR
  POP DE
; This entry point is used by the routine at LINE_INPUT.
__OPEN_1:
  LD E,A
  PUSH DE
  CALL GET_CHNUM_4
  JP NZ,AO_ERR
  POP DE
  PUSH BC
  PUSH DE
  CALL FNAME
  POP DE
  POP BC
  PUSH BC
  PUSH AF
  LD A,D
  CALL L46AB_14
  POP AF
  LD (TEMP),HL
  JP C,__OPEN_2
  LD A,E
  OR A
  JP NZ,__OPEN_2
  LD HL,FCB_FTYP
  LD A,(HL)
  CP ' '
  JP NZ,__OPEN_2
  LD (HL),'B'
  INC HL
  LD (HL),'A'
  INC HL
  LD (HL),'S'
__OPEN_2:
  POP HL
  LD A,D
  PUSH AF
  LD (PTRFIL),HL
  PUSH HL
  INC HL
  LD DE,FCB_FILE
  LD C,$0C
__OPEN_3:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC C
  JP NZ,__OPEN_3
  XOR A
  LD (HL),A
  LD DE,$0014
  ADD HL,DE
  LD (HL),A
  POP DE
  PUSH DE
  INC DE
  CALL SETDMA
  POP HL
  POP AF
  PUSH AF
  PUSH HL
  CP $02
  JP NZ,__OPEN_5
  PUSH DE
  LD C,$13                ; BDOS function 19 - delete file
  CALL $0005
  POP DE
__OPEN_4:
  LD C,$16                ; BDOS function 22 - create file
  CALL $0005
  INC A
  JP Z,FL_ERR
  JP __OPEN_6
__OPEN_5:
  LD C,$0F                ; BDOS function 15 - Open file
  CALL $0005
  INC A
  JP NZ,__OPEN_6
  POP DE
  POP AF
  PUSH AF
  PUSH DE
  CP $03
  JP NZ,FF_ERR
  INC DE
  JP __OPEN_4
__OPEN_6:
  POP DE
  POP AF
  LD (DE),A
  PUSH DE
  LD HL,$0025
  ADD HL,DE
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  POP HL
  LD A,(HL)
  CP $03
  JP Z,__OPEN_7
  CP $01
  JP NZ,WARM_ENTRY_0
  CALL BDOS_PH1
  LD HL,(TEMP)
  RET


__OPEN_7:
  LD BC,$0029
  ADD HL,BC
  LD C,$80
__OPEN_8:
  LD (HL),B
  INC HL
  DEC C
  JP NZ,__OPEN_8
  JP WARM_ENTRY_0

; 'SYSTEM' BASIC command
__SYSTEM:
  RET NZ
  CALL CLOSE_FILE_1
; This entry point is used by the routine at _ERROR_REPORT.
EXIT_TO_SYSTEM:
  JP $0000



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
  ;INC A
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
  ;INC A
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
  RET NZ
  PUSH HL
  CALL CLOSE_FILE_1
  LD C,$19                ; BDOS function 25 - Get current drive
  CALL $0005
  PUSH AF
  LD C,$0D                ; BDOS function 13 - Reset discs
  CALL $0005
  POP AF
  LD E,A
  LD C,$0E                ; BDOS function 14 - Select disc (set current drive)
  CALL $0005
  POP HL
  RET

; 'KILL' BASIC command (erase file)
__KILL:
  CALL FNAME
  PUSH HL
  LD DE,$0080
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  LD DE,FCB_FILE
  PUSH DE
  LD C,$0F                ; BDOS function 15 - Open file
  CALL $0005
  INC A
  POP DE
  PUSH DE
  PUSH AF
  LD C,$10                ; BDOS function 16 - Close file
  JP Z,__KILL_0
  CALL $0005
__KILL_0:
  POP AF
  POP DE
  JP Z,FF_ERR
  LD C,$13                ; BDOS function 19 - delete file
  CALL $0005
  POP HL
  RET

; 'FILES' BASIC command
__FILES:
  JP NZ,__FILES_0
  PUSH HL
  LD HL,FCB_FILE
  LD (HL),$00
  INC HL
  LD C,$0B
  CALL FILENAME_FILL
  POP HL
__FILES_0:
  CALL NZ,FNAME
  XOR A
  LD (FCB_EXTENT),A
  PUSH HL
  LD HL,FCB_FNAME
  LD C,$08
  CALL FILENAME_TXT
  LD HL,FCB_FTYP
  LD C,$03
  CALL FILENAME_TXT
  LD DE,$0080
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  LD DE,FCB_FILE
  LD C,$11                ; BDOS function 17 - search for first
  CALL $0005
  CP $FF
  JP Z,FF_ERR
__FILES_1:
  AND $03
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD C,A
  LD B,$00
  LD HL,$0081
  ADD HL,BC
  LD C,$0B
__FILES_2:
  LD A,(HL)
  INC HL
  AND $7F
  CALL OUTDO
  LD A,C
  CP $04
  JP NZ,__FILES_4
  LD A,(HL)
  CP ' '
  JP Z,__FILES_3
  LD A,'.'
__FILES_3:
  CALL OUTDO
__FILES_4:
  DEC C
  JP NZ,__FILES_2
  LD A,(TTYPOS)
  ADD A,$0D
  LD D,A
  LD A,(LINLEN)
  CP D
  JP C,__FILES_5
  LD A,' '
  CALL OUTDO
  CALL OUTDO
__FILES_5:
  CALL C,OUTDO_CRLF
  LD DE,FCB_FILE
  LD C,$12                ; BDOS function 18 - search for next
  CALL $0005
  CP $FF
  JP NZ,__FILES_1
  POP HL
  RET

; Deal with file name
;
; Used by the routine at __FILES.
FILENAME_TXT:
  LD A,(HL)
  CP '*'
  RET NZ
; This entry point is used by the routine at __FILES.
FILENAME_FILL:
  LD (HL),'?'
  INC HL
  DEC C
  JP NZ,FILENAME_FILL
  RET

; File read or write operations
;
; Used by the routines at __EOF and CHECK_STREAM.
; Called after picking the current function from BDOS_FN1 / BDOS_FN2
BDOS_EXEC:
  PUSH DE
  LD C,A
  PUSH BC
  CALL $0005
  POP BC
  POP DE
  PUSH AF
  LD HL,$0021
  ADD HL,DE               ; Now HL points to the random access record number
  INC (HL)                ; Increment record number LSB (R0)
  JP NZ,R_W_RESULT
  INC HL                  ; Increment record number R1
  INC (HL)                ; Increment record number R2
  JP NZ,R_W_RESULT
  INC HL
  INC (HL)
R_W_RESULT:
  LD A,C
  CP $22                  ; was it a 'write record' BDOS call ?
  JP NZ,BDOS_EXEC_0
  POP AF
  OR A
  RET Z                   ; Return if write OK
  CP $05
  JP Z,FL_ERR             ; JP if Directory full
  CP $03
  LD A,$01
  RET Z                   ; Return if Disk full
  INC A
  RET

BDOS_EXEC_0:
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

; This entry point is used by the routines at __EOF, __LOC and __LOF.
GET_CHNUM_3:
  CALL MAKINT
; This entry point is used by the routines at CPM_CLOSE_FILE and __OPEN.
GET_CHNUM_4:
  LD E,A
GET_CHNUM_5:
  LD A,(MAXFIL)
  CP E
  JP C,BN_ERR
  LD D,$00
  PUSH HL
  LD HL,FILTAB
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
  LD BC,__LET_00
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
  JP __OPEN_1

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
  LD A,(MAXFIL)
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
  LD (MAXFIL),A
  DEFB $F6                ; "OR n" to Mask 'POP AF'
LOAD1:
  POP AF
  LD (AUTORUN),A
  LD HL,$0080
  LD (HL),$00
  LD (FILTAB),HL
  CALL CLRPTR
  LD A,(MAXFILSV)
  LD (MAXFIL),A
  LD HL,(FILPTR)
  LD (FILTAB),HL
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
  LD (FILFLG),A
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
  CALL CHECK_STREAM
  LD (HL),A
  INC HL
  JP NC,__LOAD_3
  LD (VARTAB),HL
  LD A,(FILFLG)
  OR A
  CALL NZ,__GET_33
  CALL UPD_PTRS
  INC HL
  INC HL
  LD (VARTAB),HL
  LD HL,MAXFIL
  LD A,(HL)
  LD (MAXFILSV),A
  LD (HL),$00
  CALL RUN_FST
  LD A,(MAXFILSV)
  LD (MAXFIL),A
  LD A,(MEM_FLG)
  OR A
  JP NZ,L46AB_3
  LD A,(AUTORUN)
  OR A
  JP Z,READY
  JP EXEC_EVAL

; This entry point is used by the routines at READY, __MERGE and L4D05.
LOAD_END:
  CALL FINPRT
  CALL CPM_CLOSE_FILE
  JP WARM_ENTRY_0

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
__MERGE_2:
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
  CALL LINE2PTR_1
  CALL FCERR_IF_LOADING
  LD A,$FF
; This entry point is used by the routine at __GET.
__MERGE_4:
  CALL __LOF_1
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
  CALL __LOF_1
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
  LD A,(MAXFIL)
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


; This entry point is used by the routines at __SYSTEM, __RESET, _NEW, __NEW
; and __END.
CLOSE_FILE_1:
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
  JP _ENDPRG
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
  JP EXEC_EVAL
__WEND_1:
  LD HL,(LOPLIN)
  LD (CURLIN),HL
  POP HL
  POP BC
  POP BC
  JP EXEC_EVAL

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
  JP EXEC_EVAL




; 'CHAIN' BASIC command
; To call a program and pass variables to it from the current program.
;
; CHAIN [MERGE] <filename>[,[<line number exp>] [,ALL] [,DELETE<range>]]
;
__CHAIN:
  XOR A
  LD (NLONLY),A
  LD (CHAIN_DEL),A
  LD A,(HL)
  LD DE,TK_MERGE           ; d=0, e=TK_MERGE
  CP E
  JP NZ,__CHAIN_0
  LD (NLONLY),A
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
  CALL LINE_2PTR
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
  CALL SAVSTR_0
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
  CALL UPD_PTRS
L46AB_2:
  LD A,$01
  LD (MEM_FLG),A
  LD A,(NLONLY)
  OR A
  JP NZ,__MERGE_0
  LD A,(MAXFIL)
  LD (MAXFILSV),A
  JP _LOAD

; This entry point is used by the routines at __LOAD and L4D05.
L46AB_3:
  XOR A
  LD (MEM_FLG),A
  LD (NLONLY),A
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
  JP Z,EXEC_EVAL
  CALL SRCHLN
  JP NC,UL_ERR
  DEC BC
  LD H,B
  LD L,C
  JP EXEC_EVAL

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
L46AB_14:
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
  LD (RWFLG),A
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
  LD A,(RWFLG)
  OR A
  JP Z,__GET_16
__GET_15:
  LD HL,__GET_16
  PUSH HL
  PUSH BC
  PUSH HL
  LD HL,$0026
  ADD HL,BC
  JP __LOF_4

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
__GET_19:
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

; This entry point is used by the routine at CHECK_STREAM.
__GET_22:
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
  CALL LINE2PTR_1
  CALL __GET_30
  LD A,$FE
  CALL __MERGE_4
  CALL __GET_33
  JP WARM_ENTRY_0

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

; This entry point is used by the routines at PROMPT, __LIST, _PRS and __MERGE.
FCERR_IF_LOADING:
  PUSH AF
  LD A,(FILFLG)
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
QINLIN:
  LD A,'?'
  CALL OUTDO
  LD A,' '
  CALL OUTDO
  JP PINLIN

; This entry point is used by the routines at PINLIN, DELCHR, TTYLIN and
; PUTBUF.
MORINP:
  CALL CLOTST		; Get character and test ^O

  CP $01			; CTL-A  (enter in EDIT MODE?))
  JP NZ,TTYLIN_0

  LD (HL),$00
  JP PINLIN_1

; This entry point is used by the routine at PINLIN.
QINLIN_0:
  LD (HL),B

; Line input (aka RINPUT)
;
; Used by the routines at PROMPT, QINLIN and TTYLIN.
PINLIN:
  XOR A
  LD (CTLCFG),A
  XOR A
  LD (INTFLG),A
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
  LD A,(NULFLG)
  OR A
  LD A,'\\'
  LD (NULFLG),A
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
  LD (NULFLG),A
  POP AF
; This entry point is used by the routines at QINLIN and PUTBUF.
TTYLIN_0:
  LD C,A
  CP $7F                 ; RUBOUT ?
  JP Z,RUBOUT
  LD A,(NULFLG)
  OR A
  JP Z,TTYLIN_1
  LD A,'\\'
  CALL OUTDO
  XOR A
  LD (NULFLG),A
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
  CALL _PRS               ; Output buffer
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
  JP TTYLIN_0
  
; This entry point is used by the routine at TTYLIN.
PUTBUF_2:
  LD A,(INTFLG)
  OR A
  JP Z,OUTDO_CRLF_00
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
; Used by the routines at PROMPT, L12AA, DOTAB, INPUT_SUB, __LIST, __FILES,
; L46AB, QINLIN, PINLIN, DELCHR, TTYLIN, PUTBUF, TAB_LOOP, OUTDO_CRLF,
; TTY_FLUSH, _PR_CHR, __USING, L5256, L52F3, __EDIT, EDIT_SUBCMD, CTL_ECHO and PRS1.
OUTDO:
  PUSH AF
  PUSH HL
  CALL ISFLIO
  JP NZ,__LOF_0
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
  LD A,(NTMSXP)              ; Value for 'WIDTH' on printer output.
  INC A
  LD A,(LPTPOS)
  JP Z,OUTC_0                ; If 'WIDTH' is 255, the line width is "infinite" (no CRLF)

  PUSH HL
  LD HL,NTMSXP               ; Value for 'WIDTH' on printer output.
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
; Used by the routines at OUTDO and STOP_LPT.
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
; Used by the routines at READY, WARM_ENTRY and INPBRK.
STOP_LPT:
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
  LD A,(MEM_FLG)
  OR A
  JP NZ,L46AB_3
  LD A,(AUTORUN)
  OR A
  JP Z,CLOTST_PROMPT
  LD HL,EXEC_EVAL
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
; Used by the routines at FN_INPUT, L4D05, STALL, L4DC7, __EDIT_5 and EDIT_SUBCMD.
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
  CP $0F
  RET NZ
  LD A,(CTLOFG)           ; Get flag
  OR A
  CALL Z,INPBRK_0
  CPL                     ; Flip it
  LD (CTLOFG),A           ; Put it back
  OR A
  JP Z,INPBRK_0
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
OUTDO_CRLF_00:
  LD (HL),$00
  LD HL,BUFMIN

; Print and go to new line
;
; Used by the routines at _ERROR_REPORT, __PRINT, PRNTNB, DOTAB, __LIST,
; __FILES, L46AB, PINLIN, DELCHR, TTYLIN, L4CDB, CONSOLE_CRLF, L5256, EDIT_SUBCMD,
; EDIT_DONE, CTL_ECHO and L5F1A.
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
; Used by the routine at L12AA.
STALL:
  CALL GETINP             ; Get input and test for ^O
  CP $13                  ; Is it control "S"
  CALL Z,GETINP           ; Yes - Get another character
  LD (CTLCFG),A
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
  LD A,(CTLCFG)
  OR A
  RET Z
  PUSH AF
  XOR A
  LD (CTLCFG),A
  POP AF
  RET

; Output character, adj. CR/LF if necessary
;
; Used by the routines at _PRS and EDIT_SUBCMD.
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
  CALL LNUM_PARM
  RET NZ
; This entry point is used by the routine at L52F3.
__EDIT_0:
  POP HL

; This entry point is used by the routine at EDIT_SUBCMD.

; Sub-command loop.
; Picks an optional number of repetitions and a command key
EDIT_LOOP:
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL SRCHLN
  JP NC,UL_ERR
  LD H,B
  LD L,C
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  CALL DETOKEN_LIST

; This entry point is used by the routine at EDIT_SUBCMD.
__EDIT_2:
  POP HL
; This entry point is used by the routine at PINLIN.
__EDIT_3:
  PUSH HL                 ; To enter Edit Mode on the line you are currently
  LD A,H                  ; typing, type Control-A. MBASIC responds with CR,
  AND L                   ; '!', and a space. The cursor will be positioned at
  INC A                   ; the first character in the line.
  LD A,'!'
  CALL Z,OUTDO
  CALL NZ,_PRNUM
  LD A,' '
  CALL OUTDO
  LD HL,BUF
  PUSH HL
  LD C,$FF
__EDIT_4:
  INC C
  LD A,(HL)
  INC HL
  OR A
  JP NZ,__EDIT_4
  POP HL
  LD B,A

; Optional number of repetitions of the next subcommand.
__EDIT_5:
  LD D,$00
__EDIT_6:
  CALL GETINP
  OR A
  JP Z,__EDIT_6
  CALL UCASE
  SUB '0'                 ; convert from ASCII
  JP C,EDIT_SUBCMD
  CP $0A
  JP NC,EDIT_SUBCMD
  LD E,A
  LD A,D
  RLCA
  RLCA
  ADD A,D
  RLCA
  ADD A,E
  LD D,A
  JP __EDIT_6

; Proceed by typing an Edit Mode subcommand.
;
; Used by the routine at __EDIT_5.
EDIT_SUBCMD:
  PUSH HL
  LD HL,__EDIT_5
  EX (SP),HL
  DEC D
  INC D
  JP NZ,EDIT_SUBCMD_0
  INC D
EDIT_SUBCMD_0:
  CP $D8			; TAB:  $08 - '0' = $D8
  JP Z,EDIT_TAB
  CP $4F			; DEL:  $7F - '0' = $4F
  JP Z,EDIT_RUBOUT
  CP $DD			; CR:   $0D - '0' = $DD
  JP Z,EDIT_DONE
  CP $F0 			; SPC:  $20 - '0' = $F0
  JP Z,EDIT_SPC
  CP $31			; 'a'
  JP C,EDIT_SUBCMD_1
  SUB $20			; TO UPPERCASE
EDIT_SUBCMD_1:
  CP $21				; 'Q'
  JP Z,EDIT_QUIT
  CP $1C				; '<'
  JP Z,EDIT_SUBCMD_7
  CP $23				; 'S'
  JP Z,EDIT_SEARCH
  CP $19				; 'I'
  JP Z,EDIT_INSERT
  CP $14				; 'D'
  JP Z,EDIT_DELETE_N
  CP $13				; 'C'
  JP Z,EDIT_CHANGE
  CP $15				; 'E'
  JP Z,EDIT_EXIT
  CP $28				; 'X'
  JP Z,EDIT_XTEND
  CP $1B				; 'K'
  JP Z,EDIT_REPLACE
  CP $18				; 'H'
  JP Z,EDIT_DELETE_RIGHT
  CP $11				; 'A'
  LD A,$07
  JP NZ,OUTDO			; Ring a bell if unknown command
  
; The A subcommand lets you begin editing a line over again.
; It restores the original line and repositions the cursor at the beginning.
  POP BC
  POP DE
  CALL OUTDO_CRLF
  JP EDIT_LOOP
  
EDIT_SPC:
  LD A,(HL)
  OR A
  RET Z
  INC B
  CALL _PR_CHR
  INC HL
  DEC D
  JP NZ,EDIT_SPC
  RET


; The subcommand [i]K<ch> is similar to [i]S<ch>, except all the characters
; passed over in the search are deleted. The cursor is positioned before <ch>, 
; and the deleted characters are enclosed in backslashes

EDIT_REPLACE:
  PUSH HL
  LD HL,EDIT_DELETE_N_1
  EX (SP),HL
  SCF
EDIT_SEARCH:
  PUSH AF
  CALL GETINP
  LD E,A
  POP AF
  PUSH AF
  CALL C,EDIT_DELETE_N_1
EDIT_SEARCH_0:
  LD A,(HL)
  OR A
  JP Z,EDIT_SEARCH_2
  CALL _PR_CHR
  POP AF
  PUSH AF
  CALL C,EDIT_REMOVE
  JP C,EDIT_SEARCH_1
  INC HL
  INC B
EDIT_SEARCH_1:
  LD A,(HL)
  CP E
  JP NZ,EDIT_SEARCH_0
  DEC D
  JP NZ,EDIT_SEARCH_0
EDIT_SEARCH_2:
  POP AF
  RET
  
EDIT_SUBCMD_7:
  CALL _PRS
  CALL OUTDO_CRLF
  POP BC
  JP __EDIT_2

; [i]D deletes i characters to the right of the cursor. The deleted characters
; are echoed between backslashes, and the cursor is positioned to the right of
; the last character deleted. If there are fewer than i characters to the right
; of the cursor, [i]D deletes deletes the remainder of the line.

EDIT_DELETE_N:
  LD A,(HL)
  OR A
  RET Z
  LD A,'\\'
  CALL _PR_CHR
EDIT_DELETE_N_0:
  LD A,(HL)
  OR A
  JP Z,EDIT_DELETE_N_1
  CALL _PR_CHR
  CALL EDIT_REMOVE
  DEC D
  JP NZ,EDIT_DELETE_N_0
EDIT_DELETE_N_1:
  LD A,'\\'
  CALL OUTDO
  RET

EDIT_CHANGE:
  LD A,(HL)
  OR A
  RET Z
EDIT_CHANGE_0:
  CALL GETINP
  CP ' '
  JP NC,EDIT_CHANGE_1
  CP $0A
  JP Z,EDIT_CHANGE_1
  CP $07
  JP Z,EDIT_CHANGE_1
  CP $09
  JP Z,EDIT_CHANGE_1
  LD A,$07
  CALL OUTDO
  JP EDIT_CHANGE_0

EDIT_CHANGE_1:
  LD (HL),A
  CALL _PR_CHR
  INC HL
  INC B
  DEC D
  JP NZ,EDIT_CHANGE
  RET


; H deletes all characters to the right of the cursor and then automatically
; enters insert mode.  H is useful for replacing statements at the end of a line.

EDIT_DELETE_RIGHT:
  LD (HL),$00
  LD C,B


; Moves the cursor to the end of the line, goes into insert mode,
; and allows insertion of text as if an Insert command had been given.

EDIT_XTEND:
  LD D,$FF
  CALL EDIT_SPC

; I<text>$
; Inserts <text> at the current cursor position. The inserted characters are printed on the terminal.
; To terminate insertion, type Escape. If Carriage Return is typed during an Insert command,
; the effect is the same as typing Escape and then Carriage Return. During an Insert command,
; the Rubout or Delete key on the terminal may be used to delete characters to the left of the cursor.

EDIT_INSERT:
  CALL GETINP
  CP $7F
  JP Z,BS_PRESSED
  CP $08
  JP Z,BS_PRESSED_0
  CP $0D
  JP Z,EDIT_DONE
  CP $1B
  RET Z
  CP $08
  JP Z,BS_PRESSED_0
  CP $0A
  JP Z,OTHER_PRESSED
  CP $07
  JP Z,OTHER_PRESSED
  CP $09
  JP Z,OTHER_PRESSED
  CP ' '
  JP C,EDIT_INSERT
  CP '_'
  JP NZ,OTHER_PRESSED

BS_PRESSED:
  LD A,'_'
BS_PRESSED_0:
  DEC B
  INC B
  JP Z,EDIT_INSERT_ERR
  CALL _PR_CHR
  DEC HL
  DEC B
  LD DE,EDIT_INSERT
  PUSH DE
EDIT_REMOVE:
  PUSH HL
  DEC C
EDIT_REMOVE_0:
  LD A,(HL)
  OR A
  SCF
  JP Z,POPHLRT
  INC HL
  LD A,(HL)
  DEC HL
  LD (HL),A
  INC HL
  JP EDIT_REMOVE_0

OTHER_PRESSED:
  PUSH AF
  LD A,C

; If an attempt is made to insert a character that will make the line longer than
; 255 characters, a bell (Control-G) is typed and the character is not printed.
  CP 255
  JP C,EDIT_INSERT_CHR
  POP AF
EDIT_INSERT_ERR:
  LD A,$07
  CALL OUTDO
EDIT_INSERT_LP:
  JP EDIT_INSERT

EDIT_INSERT_CHR:
  SUB B
  INC C
  INC B
  PUSH BC
  EX DE,HL
  LD L,A
  LD H,$00
  ADD HL,DE
  LD B,H
  LD C,L
  INC HL
  CALL MOVSTR
  POP BC
  POP AF
  LD (HL),A
  CALL _PR_CHR
  INC HL
  JP EDIT_INSERT_LP


EDIT_TAB:
  LD A,B
  OR A
  RET Z
  DEC HL
  LD A,$08
  CALL _PR_CHR
  DEC B
  DEC D
  JP NZ,EDIT_RUBOUT
  RET


; In Edit Mode, [i]Rubout moves the cursor i spaces to the left (backspaces).
; Characters are printed as you backspace over them.
EDIT_RUBOUT:
  LD A,B
  OR A
  RET Z
  DEC B
  DEC HL
  LD A,(HL)
  CALL _PR_CHR
  DEC D
  JP NZ,EDIT_RUBOUT
  RET


; Typing Carriage Return prints the remainder of the line, saves the changes
; you made and exits Edit Mode.
;
; Used by the routine at EDIT_SUBCMD.
EDIT_DONE:
  CALL _PRS
; This entry point is used by the routine at EDIT_SUBCMD.
EDIT_EXIT:
  CALL OUTDO_CRLF
  POP BC
  POP DE
  LD A,D
  AND E
  INC A
; This entry point is used by the routine at PROMPT.
EDIT_DONE_1:
  LD HL,BUFMIN
  RET Z
  SCF
  PUSH AF
  INC HL
  JP PROMPT_4

; This entry point is used by the routine at EDIT_SUBCMD.

; Returns to BASIC command level, without saving any of the 
; changes that were made to the line during Edit Mode.
EDIT_QUIT:
  POP BC
  POP DE
  LD A,D
  AND E
  INC A
  JP Z,OUTDO_CRLF_00
  JP READY


; Routine at 21850
;
; Used by the routines at PROMPT and L4F11.
MOVUP:
  CALL ENFMEM             ; See if enough memory
; This entry point is used by the routines at L46AB, EDIT_SUBCMD and SCNEND.
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
; Used by the routines at FORFND, __GO_SUB, EVAL, DOFN, __CALL, SBSCPT and
; BSOPRND_0.
CHKSTK:
  PUSH HL                 ; Save code string address
  LD HL,(MEMSIZ)          ; Lowest free memory
  LD B,$00                ; BC = Number of levels to test
  ADD HL,BC               ; 2 Bytes for each level
  ADD HL,BC
  LD A,$C6                ; (-58) 58 Bytes minimum RAM
  SUB L
  LD L,A
  LD A,$FF                ; (-1 for MSB) 58  Bytes minimum RAM
  SBC A,H
  LD H,A
  JP C,OM_ERR             ; Not enough - ?OM Error
  ADD HL,SP               ; Test if stack is overflowed
  POP HL                  ; Restore code string address
  RET C                   ; Return if enough mmory
; This entry point is used by the routines at LOAD_OM_ERR, BSOPRND_0, __CLEAR
; and L5F1A.
OM_ERR:
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
; This entry point is used by the routine at ENFMEM.
_OM_ERR:
  LD DE,$0007
  JP ERROR

; See if enough memory
;
; Used by the routines at BSOPRND_0, MOVUP and L5F1A.
ENFMEM:
  CALL ENFMEM_0
  RET NC
  LD A,(MEM_FLG)
  OR A
  JP NZ,_OM_ERR
  PUSH BC
  PUSH DE
  PUSH HL
  CALL GARBGE
  POP HL
  POP DE
  POP BC
  CALL ENFMEM_0
  RET NC
  JP _OM_ERR
  
ENFMEM_0:
  PUSH DE
  EX DE,HL
  LD HL,(FRETOP)
  CALL DCOMPR
  EX DE,HL
  POP DE
  RET

; Clear memory, initialize files and reset
;
; Used by the routine at _READY.
_NEW:
  LD A,(MAXFIL)
  LD B,A
  LD HL,FILTAB
  XOR A
  INC B
_NEW_0:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD (DE),A
  DEC B
  JP NZ,_NEW_0
  CALL CLOSE_FILE_1
  XOR A

; 'NEW' BASIC command
__NEW:
  RET NZ
; This entry point is used by the routines at __LOAD and LOAD_OM_ERR.
CLRPTR:
  LD HL,(TXTTAB)
  CALL __TROFF
  LD (FILFLG),A
  LD (AUTFLG),A
  LD (PTRFLG),A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (VARTAB),HL
  
; This entry point is used by the routines at PROMPT, ATOH, __LOAD and L4D05.
RUN_FST:
  LD HL,(TXTTAB)
  DEC HL

; This entry point is used by the routines at ATOH and CLVAR.
_CLVAR:
  LD (TEMP),HL            ; Save code string address
  LD A,(NLONLY)
  OR A
  JP NZ,__NEW_0
  XOR A
  LD (OPTBASE_FLG),A
  LD (OPTBASE),A
  LD B,$1A
  LD HL,DEFTBL
_CLVAR_0:
  LD (HL),$04
  INC HL
  DEC B
  JP NZ,_CLVAR_0
__NEW_0:
  LD DE,RND_CONST
  LD HL,LSTRND
  CALL DETHL4
  LD HL,SEED
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  XOR A
  LD (ONEFLG),A
  LD L,A
  LD H,A
  LD (ONELIN),HL
  LD (OLDTXT),HL
  LD HL,(MEMSIZ)
  LD A,(MEM_FLG)
  OR A
  JP NZ,__NEW_1
  LD (FRETOP),HL
__NEW_1:
  XOR A
  CALL __RESTORE
  LD HL,(VARTAB)
  LD (ARYTAB),HL
  LD (STREND),HL
  LD A,(NLONLY)
  OR A
  CALL Z,CLOSE_FILE_1
; This entry point is used by the routine at BASIC_ENTRY.
__NEW_2:
  POP BC
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  INC HL
  INC HL

; Clear registers and warm boot
;
; Used by the routine at TM_ERR.
WARM_ENTRY:
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL DBL_ASCTFP_END_0
  CALL STOP_LPT
  CALL FINPRT
  XOR A
  LD H,A
  LD L,A
  LD (PRMLEN),HL
  LD (NOFUNS),A
  LD (PRMLN2),HL
  LD (FUNACT),HL
  LD (PRMSTK),HL
  LD (SUBFLG),A
  PUSH HL
  PUSH BC
; This entry point is used by the routines at __OPEN, __LOAD and __GET.
WARM_ENTRY_0:
  LD HL,(TEMP)
  RET

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at BAKSTK, _ERROR_REPORT, PROMPT, SRCHLP, __FOR, ATOH,
; __GO_TO, __LET, DOFN, __LIST, __DELETE, __RENUM, __OPTION, MULTEN,
; DECDIV_SUB, __LOAD, __MERGE, __FIELD, __LSET, __WEND, __CHAIN, L45C9,
; CHAIN_ALL, L46AB, __GET, L4F11, SBSCPT, ZERARY, MOVUP, ENFMEM, __TROFF,
; __ERASE, __CLEAR, __NEXT, TSTOPL_0, GRBDON, GRBLP, ARRLP, GRBARY, STRADD,
; GSTRDE, BAKTMP and FN_INSTR.
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
; OPRND_3, DEF_USR, __DEF, DOFN, CHEKFN, __WAIT, GTINT_GTINT, __POKE, __RENUM,
; __OPTION, LOOK_FOR, __NAME, __OPEN, GET_CHNUM, __LOAD, __MERGE, __FIELD,
; FN_INPUT, __CALL, __CHAIN, L45C9, L46AB, DIMRET, __USING, __TROFF, __CLEAR,
; FN_STRING, LFRGNM, FN_INSTR, MID_ARGSEP and BASIC_ENTRY.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  JP NZ,SYNCHR_0
  INC HL
  EX (SP),HL
  INC HL
  LD A,(HL)
  CP ':'            ; Z if ":"
  RET NC			; NC if > "9"
  JP CHRGTB_1
SYNCHR_0:
  JP SN_ERR

; This entry point is used by the routine at __NEW.
__RESTORE:
  EX DE,HL
  LD HL,(TXTTAB)
  JP Z,SYNCHR_1
  EX DE,HL
  CALL ATOH
  PUSH HL
  CALL SRCHLN
  LD H,B
  LD L,C
  POP DE
  JP NC,UL_ERR
SYNCHR_1:
  DEC HL
; This entry point is used by the routine at LTSTND.
UPDATA:
  LD (DATPTR),HL
  EX DE,HL
  RET

; 'STOP' BASIC command
;
; Used by the routine at STALL.
__STOP:
  RET NZ
  INC A
  JP __END_0

; 'END' BASIC command
__END:
  RET NZ
  PUSH AF
  CALL Z,CLOSE_FILE_1
  POP AF
; This entry point is used by the routine at __STOP.
__END_0:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  
  DEFB $21                ; "LD HL,nn" to jump over the next word without executing it

; Get here if the "INPUT" sequence was interrupted
;
; Used by the routines at __LINE, INPUT_SUB and __RANDOMIZE.
INPBRK:
  OR $FF
  POP BC
; This entry point is used by the routines at WARM_BT_0 and FN_INPUT.
_ENDPRG:
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
  CALL STOP_LPT           ; Disable printer echo if enabled
  CALL CONSOLE_CRLF
  POP AF                  ; Restore STOP / END status
  LD HL,BREAK_MSG         ; "Break" message
  JP NZ,_ERROR_REPORT     ; "in line" wanted?
  JP RESTART              ; Go to command mode

; This entry point is used by the routine at L4D46.
INPBRK_0:
  LD A,$0F
; This entry point is used by the routines at TTYLIN and STALL.
KILIN:
  PUSH AF
  SUB $03
  JP NZ,CTL_ECHO
  LD (PRTFLG),A
  LD (CTLOFG),A

; Display the pressed CTL-key sequence, e.g. ^C
;
; Used by the routine at INPBRK.
CTL_ECHO:
  LD A,'^'
  CALL OUTDO
  POP AF
  ADD A,$40
  CALL OUTDO
  JP OUTDO_CRLF

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
  DEFB $3E                ; "LD A,175" and Mask the next byte

; 'TROFF' (TRACE OFF) BASIC command
;
; Used by the routine at __NEW.
__TROFF:
  XOR A
  LD (TRCFLG),A
  RET
__SWAP:
  CALL GETVAR
  PUSH DE
  PUSH HL
  LD HL,SWPTMP
  CALL FP2HL
  LD HL,(ARYTAB)
  EX (SP),HL
  CALL GETYPR
  PUSH AF
  CALL SYNCHR
  DEFM ","
  CALL GETVAR
  POP AF
  LD B,A
  CALL GETYPR
  CP B
  JP NZ,TM_ERR
  EX (SP),HL
  EX DE,HL
  PUSH HL
  LD HL,(ARYTAB)
  CALL DCOMPR
  JP NZ,__TROFF_0
  POP DE
  POP HL
  EX (SP),HL
  PUSH DE
  CALL FP2HL
  POP HL
  LD DE,SWPTMP
  CALL FP2HL
  POP HL
  RET
; This entry point is used by the routine at __ERASE.
__TROFF_0:
  JP FC_ERR

; 'ERASE' BASIC command
__ERASE:
  LD A,$01
  LD (SUBFLG),A
  CALL GETVAR
  JP NZ,__TROFF_0
  PUSH HL
  LD (SUBFLG),A
  LD H,B
  LD L,C
  DEC BC
  DEC BC
  DEC BC
__ERASE_0:
  LD A,(BC)
  DEC BC
  OR A
  JP M,__ERASE_0
  DEC BC
  DEC BC
  ADD HL,DE
  EX DE,HL
  LD HL,(STREND)
__ERASE_1:
  CALL DCOMPR
  LD A,(DE)
  LD (BC),A
  INC DE
  INC BC
  JP NZ,__ERASE_1
  DEC BC
  LD H,B
  LD L,C
  LD (STREND),HL
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  CALL CHRGTB
  JP __ERASE

; This entry point is used by the routine at __LOF.
__ERASE_2:
  POP AF
  POP HL
  RET

; Load A with char in (HL) and check it is a letter:
;
; Used by the routines at DEFVAL and GETVAR.
IS_ALPHA:
  LD A,(HL)

; Check char in 'A' being in the 'A'..'Z' range
;
; Used by the routines at CRNCLP, L1164, OPRND, HEXTFP, _PRS and GETVAR.
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
  JP Z,CLVAR              ; Just "CLEAR" Keep parameters
  CP ','
  JP Z,__CLEAR_0
  CALL GET_POSINT_0
  DEC HL
  CALL CHRGTB             ; Get next character
  JP Z,CLVAR

__CLEAR_0:
  CALL SYNCHR
  DEFM ","
  JP Z,CLVAR
  EX DE,HL
  LD HL,(STKTOP)
  EX DE,HL
  CP ','
  JP Z,__CLEAR_1
  CALL POSINT             ; Get integer to DE
__CLEAR_1:
  DEC HL                  ; Cancel increment
  CALL CHRGTB
  PUSH DE
  JP Z,__CLEAR_3
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
  LD HL,$004E
  CALL DCOMPR
  JP NC,OMERR
  POP HL                  ; Restore code string address (1st copy)
  CALL __CLEAR_4
  JP C,OMERR

  PUSH HL                 ; Save RAM top
  LD HL,(VARTAB)          ; Get program end
  LD BC,$0014             ; 20 Bytes minimum working RAM
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

__CLEAR_4:
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  RET

; 'NEXT' BASIC command
__NEXT:
  PUSH AF
  DEFB $F6                ; "OR n" to Mask 'XOR A'
; This entry point is used by the routine at SAVSTP.
__NEXT_0:
  XOR A
  LD (NEXFLG),A
  POP AF
  LD DE,$0000             ; In case no index given
; This entry point is used by the routine at KILFOR.
__NEXT_1:
  LD (NEXTMP),HL
  CALL NZ,GETVAR          ; not end of statement, locate variable (Get index address)
  LD (TEMP),HL            ; Save code string address
  CALL BAKSTK             ; Look for "FOR" block
  JP NZ,NF_ERR            ; No "FOR" - ?NF Error
  LD SP,HL                ; Clear nested loops
  PUSH DE                 ; Save index address
  LD E,(HL)               ; Get sign of STEP
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  LD HL,(NEXTMP)
  CALL DCOMPR
  JP NZ,NF_ERR
  POP HL
  POP DE
  PUSH DE
  LD A,(HL)
  PUSH AF
  INC HL
  PUSH DE
  LD A,(HL)
  INC HL
  OR A
  JP M,__NEXT_3
  CALL PHLTFP             ; Move index value to FPREG
  EX (SP),HL              ; Save address of TO value
  PUSH HL                 ; Save address of index
  LD A,(NEXFLG)
  OR A
  JP NZ,__NEXT_2
  LD HL,FOR_ACC
  CALL PHLTFP
  XOR A
__NEXT_2:
  CALL NZ,FADD_HLPTR
  POP HL
  CALL FPTHL
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FCOMP
  JP __NEXT_6

__NEXT_3:
  INC HL
  INC HL
  INC HL
  INC HL
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
  LD A,(NEXFLG)
  OR A
  JP NZ,__NEXT_4
  LD HL,(FOR_ACC)
  JP __NEXT_5

__NEXT_4:
  CALL IADD
  LD A,(VALTYP)
  CP $04
  JP Z,OV_ERR
__NEXT_5:
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
__NEXT_6:
  POP HL
  POP BC
  SUB B
  CALL LOADFP
  JP Z,KILFOR             ; Loop finished - Terminate it
  EX DE,HL                ; Loop statement line number
  LD (CURLIN),HL          ; Set loop line number
  LD L,C                  ; Set code string to loop
  LD H,B
  JP PUTFID

; Remove "FOR" block
;
; Used by the routine at __NEXT.
KILFOR:
  LD SP,HL
  LD (SAVSTK),HL          ; Code string after "NEXT"
  LD HL,(TEMP)
  LD A,(HL)               ; Get next byte in code string
  CP ','                  ; More NEXTs ?
  JP NZ,EXEC_EVAL         ; No - Do next statement
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
SAVSTR_0:
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
; __RANDOMIZE, LNUM_MSG, L4D05, L5256 and L5F1A.
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
; This entry point is used by the routines at _PRS and CHPUT.
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
  CALL BAKTMP             ; Was it last tmp-str?
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
BAKTMP:
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

; This entry point is used by the routine at MORE_STMT.
FN_INSTR_6:
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
  CALL SAVSTR_0
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
  CALL GETINT       ; Get integer 0-255
  PUSH DE
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT       ; Get integer 0-255
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  POP BC
  POP AF

COORD_PARMS_1:
  PUSH HL
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
  POP HL
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
  ;CALL _FETCHC			; Gets current cursor address and mask pattern
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


		ld		a,e
		cp		192
		jp		nc,FC_ERR			; y0	out of range


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

IF HAVE_NSETCX
  CALL SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'F'			; 'BOX FILLED'

DOBOXF:
  PUSH HL
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
  ;CALL FETCHC			; Save cursor
  ;PUSH AF
  ;PUSH HL
  EX DE,HL
  CALL NSETCX           ; Set horizontal screenpixels
  ;POP HL
  ;POP AF
  ;CALL STOREC			; Restore cursor
  CALL DOWNC
  POP BC
  POP DE
  DEC BC
  LD A,B
  OR C
  JR NZ,LINE_0
  POP HL
  RET
ELSE
  POP HL
  RET
ENDIF
  
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
  LD (MINDEL+1),HL
  POP HL
DRAW_LINE_2:
  POP DE
  PUSH HL
  CALL INVSGN_HL
  LD (MAXDEL+1),HL
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
  CALL 0

; This entry point is used by the routine at DRAW_LINE.
DRAW_LINE_SEGMENT:
  CALL SETC
  DEC BC
  PUSH HL
MINDEL:
  LD HL,0
  ADD HL,DE
  EX DE,HL
MAXDEL:
  LD HL,0
  ADD HL,DE
  JR NC,DRAW_LINE_3
  EX DE,HL
  POP HL
  LD A,B
  OR C
  RET Z
MINUPD:
  CALL 0		; MINUPD = JP nn for RIGHTC, LEFTC and DOWNC 
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

asm_zx_cxy2aaddr:

   ; enter : h = valid character y coordinate
   ;         l = valid character x coordinate
   ;
   ; exit  : hl = attribute address corresponding to character
   ;
   ; uses  : af, hl

   ld a,h
   rrca
   rrca
   rrca
   ld h,a
   
   and $e0
   or l
   ld l,a
   
   ld a,h
   and $03

IF __USE_SPECTRUM_128_SECOND_DFILE
   or $d8
ELSE
   or $58
ENDIF

   ld h,a
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
   srl a
   LD (CMASK),A
   ld hl,(CLOC)
   ret nc

   inc hl
   ld (CLOC),hl

   ld a,127
   LD (CMASK),A

   ld a,(ALOC)
   inc a
   ld (ALOC),a
   ret


;------------
LEFTC:
   LD A,(CMASK)
   add a
   LD (CMASK),A
   ld hl,(CLOC)
   ret nc

   dec hl
   ld (CLOC),hl

   ld a,1
   LD (CMASK),A

   ld a,(ALOC)
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

;________
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
; Used by the routine at L5F1A.
_READY:
  CALL _NEW
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
BASIC_ENTRY:
  LD HL,MEMORY_LIMIT
  LD SP,HL
  XOR A
  LD (FILFLG),A
  LD (STKTOP),HL
  LD SP,HL
  LD HL,BUFFER
  LD (HL),':'
  CALL __NEW_2
  LD (TTYPOS),A
  LD (SAVSTK),HL
  LD HL,($0001)
  LD BC,$0004
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (SMC_ISCNTC2),HL
  LD (SMC_ISCNTC3),HL
  LD (SMC_ISCNTC),HL
  EX DE,HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (SMC_GETINP),HL
  EX DE,HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (SMC_TTYIN),HL
  EX DE,HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (SMC_OUTPRT),HL
  LD C,$0C                ; BDOS function 12 - Get BDOS version number
  CALL $0005
  LD (BDOSVER),A
  OR A
  LD HL,$1514             ; FN2=$15 (Open file FN), FN1=14 (Select disk FN)
  JP Z,BASIC_ENTRY_0      ; JP if BDOS Version 1
  LD HL,$2221             ; FN2=$22 (Write record FN), FN1=$21 (Read record FN)
BASIC_ENTRY_0:
  LD (BDOS_FN1),HL        ; Load the BDOS FN code pair (FN1+FN2)
  LD HL,$FFFE
  LD (CURLIN),HL
  XOR A
  LD (CTLOFG),A
  LD (ENDBUF+1),A
  LD (MEM_FLG),A
  LD (NLONLY),A
  LD (ERRFLG),A
  LD HL,$0000
  LD (LPTPOS),HL
  LD HL,128               ; The default record size is 128 bytes.
  LD (RECSIZ),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,PRMSTK
  LD (PRMPRV),HL
  LD HL,($0006)           ; HL=BDOS entry address
  LD (MEMSIZ),HL
  LD A,3                  ; If the /F option is omitted, the number of files defaults to 3.
  LD (MAXFIL),A
  LD HL,WARM_0
  LD (TEMP8),HL
  LD A,(WARM_FLG)
  OR A
  JP NZ,L5F1A
  INC A
  LD (WARM_FLG),A
  LD HL,$0080
  LD A,(HL)
  OR A
  LD (TEMP8),HL
  JP Z,L5F1A
  LD B,(HL)
  INC HL
BASIC_ENTRY_1:
  LD A,(HL)
  DEC HL
  LD (HL),A
  INC HL
  INC HL
  DEC B
  JP NZ,BASIC_ENTRY_1
  DEC HL
  LD (HL),$00
  LD (TEMP8),HL
  LD HL,$007F
  CALL CHRGTB
  OR A
  JP Z,L5F1A

;
; Command line parameters usage example
;
; A>MBASIC PRGM/F:2/M:&H9000
; Use first 36K of memory, 2 files, and execute PRGM.BAS.
  
  CP '/'
  JP Z,BASIC_ENTRY_3
  DEC HL
  LD (HL),'"'
  LD (TEMP8),HL
  INC HL
BASIC_ENTRY_2:
  CP '/'
  JP Z,BASIC_ENTRY_3
  CALL CHRGTB
  OR A
  JP NZ,BASIC_ENTRY_2
  JP L5F1A

  
BASIC_ENTRY_3:
  LD (HL),$00
  CALL CHRGTB
BASIC_ENTRY_4:
  CALL UCASE_HL
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
  JP Z,BASIC_ENTRY_6

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
  LD (MAXFIL),A
  JP BASIC_ENTRY_7


BASIC_ENTRY_6:
  EX DE,HL
  LD (MEMSIZ),HL
  EX DE,HL
BASIC_ENTRY_7:
  DEC HL
  CALL CHRGTB
  JP Z,L5F1A
  CALL SYNCHR
  DEFM "/"
  JP BASIC_ENTRY_4
  
  
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
  JP BASIC_ENTRY_7


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
; Used by the routine at BASIC_ENTRY.
L5F1A:
  LD DE,USER_MEMORY
  LD A,(DE)
  OR A
  JP Z,L5F1A_3
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
  JP L5F1A_3
  
PSP_DIFFERS:
  INC DE
  DEC C
  JP NZ,PSP_DIFFERS
  DEC B
  RET Z
  JP PSP_LOOP
  
L5F1A_3:
  DEC HL
  LD HL,(MEMSIZ)
  DEC HL
  LD (MEMSIZ),HL
  DEC HL
  PUSH HL
  LD A,(MAXFIL)
  LD HL,NULL_FILE
  LD (FILPTR),HL
  LD DE,FILTAB
  LD (MAXFIL),A
  INC A

  LD BC,$00A9		; 169

L5F1A_4:
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
  JP NZ,L5F1A_4

  INC HL
  LD (TXTTAB),HL
  LD (SAVSTK),HL
  POP DE
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR

; HL=HL/8
  LD B,$03
L5F1A_5:
  OR A
  LD A,H
  RRA
  LD H,A
  LD A,L
  RRA
  LD L,A
  DEC B
  JP NZ,L5F1A_5

  LD A,H
  CP $02				; HL < 512 ?
  JP C,L5F1A_6

  LD HL,$0200			; Force minimum MEM size to 512

L5F1A_6:
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR


IF ZXPLUS3
	push de
	ld de,-36	; let's reserve extra space on stack for the JP routine
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
  LD (STKTOP),HL
  LD (FRETOP),HL
  LD SP,HL
  LD (SAVSTK),HL
  LD HL,(TXTTAB)
  EX DE,HL
  CALL ENFMEM
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  DEC HL
  DEC HL
  PUSH HL
  LD HL,COPYRIGHT_MSG
  CALL PRS
  POP HL
  CALL _PRNUM
  LD HL,BYTES_MSG
  CALL PRS
  LD HL,PRS
  LD (SMC_PRINTMSG),HL
  CALL OUTDO_CRLF
  LD HL,WARM_BT_0
  JP _READY

; Message at 24551
HIDDEN_MSG:
  DEFB $0D
  DEFB $0A
  DEFB $0A
  DEFM "Owned by Microsoft"
  DEFB $0D
  DEFB $0A
  DEFB $00

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

MEMORY_LIMIT:

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
