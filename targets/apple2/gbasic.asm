
; Apple II GBASIC disassembly

; The original code now includes Z80 specific optimizations,
; but Z80ASM is able to transparently convert back to 8080.
;
; Classic build (almost byte-identical but for few small bug fixes):
;
; z80asm -b -DORIGINAL -DCPMV1 -m8080 mbasic.asm
;
; ren mbasic.bin MBASIC.COM
; -or-
; z88dk-appmake +cpmdisk -f apple2 --container=raw --extension=.dsk  -b "a.bin" -c "a"
;

; --- CP/M Specific definitions --- 

IF !BASE
  defc BASE = 0
ENDIF

defc CPMWRM  =  BASE                ;CP/M WARM BOOT ADDR
defc CPMENT  =  BASE+5              ;CP/M BDOS CALL ADDR
defc DIRTMP  =  BASE+$0080


  ORG BASE+$0100



;----------------------------------------------  
; Apple II specific constants to be renamed


; 6502 page zero

 defc LF022 = $F022

 defc LF02C = $F02C
 defc LF02D = $F02D

 defc LF030 = $F030



; positions in page zero used to pass registers to the 6502 CPU

 defc F045_REG_A = $F045
 defc F046_REG_X = $F046
 defc F047_REG_Y = $F047

 defc LE050 = $E050
 defc LE051 = $E051

 defc LE053 = $E053
 defc LE054 = $E054

 defc LE056 = $E056
 defc LE057 = $E057

 defc LE061 = $E061


; Invoking the 6502 CPU

 defc F396_XY_OFFSET      = $F396
 defc F397_SCREEN_FN_TBL  = $F397
 defc F3D0_6502_ADDRESS   = $F3D0


; $03BB - I/O config block, device drivers

 defc LF3BB_IOCONFIG  = $F3BB


;----------------------------------------------  

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

defc LINLN    =   80   ; TERMINAL LINE LENGTH 
defc LINCT    =   24   ; TERMINAL LINE COUNT

defc LPTLEN   =  132   ; Max column size on printer
defc CLMWID   =   14   ; MAKE COMMA COLUMNS FOURTEEN CHARACTERS
defc LNCMPS   = (((LPTLEN/CLMWID)-1)*CLMWID) ;LAST COMMA FIELD POSIT

;------------------------------------

defc DATPSC   =  128    ;NUMBER OF DATA BYTES IN DISK SECTOR

;----------------------------------------------  

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

 defc TK_POS      =  $10
 defc TK_LEN      =  $11
 defc TK_STR_S    =  $12
 defc TK_VAL      =  $13
 defc TK_ASC      =  $14
 defc TK_CHR_S    =  $15
 defc TK_PEEK     =  $16
 defc TK_SPACE_S  =  $17
 defc TK_OCT_S    =  $18
 defc TK_HEX_S    =  $19
 defc TK_LPOS     =  $1A
 defc TK_CINT     =  $1B
 defc TK_CSGN     =  $1C
 defc TK_CDBL     =  $1D
 defc TK_FIX      =  $1E

 defc TK_CVI      =  $2A
 defc TK_CVS      =  $2B
 defc TK_CVD      =  $2C

 defc TK_EOF      =  $2E
 defc TK_LOC      =  $2F

 defc TK_LOF      =  $30
 defc TK_MKI_S    =  $31
 defc TK_MKS_S    =  $32
 defc TK_MKD_S    =  $33

 defc TK_VPOS     =  $34   ; Apple ][ GBASIC specific, VPOS(0)
 defc TK_PDL      =  $35   ; Apple ][ GBASIC specific, PDL(0)
 defc TK_BUTTON   =  $36   ; Apple ][ GBASIC specific, BUTTON(0)


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
 defc TK_ON       =  $95
 defc TK_DEF      =  $96
 defc TK_POKE     =  $97
 defc TK_CONT     =  $98

 defc TK_LPRINT   =  $9B
 defc TK_LLIST    =  $9C


 defc TK_WIDTH    =  $9D
 defc TK_ELSE     =  $9E	; Token for 'ELSE'
 defc TK_TRACE    =  $9F   ; a.k.a. TRON
 defc TK_NOTRACE  =  $A0	; Token for 'TROFF'
 defc TK_SWAP     =  $A1
 defc TK_ERASE    =  $A2
 defc TK_EDIT     =  $A3
 defc TK_ERROR    =  $A4	; Token for 'ERROR'
 defc TK_RESUME   =  $A5
 defc TK_DELETE   =  $A6
 defc TK_AUTO     =  $A7
 defc TK_RENUM    =  $A8
 defc TK_DEFSTR   =  $A9
 defc TK_DEFINT   =  $AA
 defc TK_DEFSGN   =  $AB


 defc TK_WHILE    =  $AF

 defc TK_WEND     =  $B0	; Token for 'PUT' (used also in 'OPEN' to check syntax)
 defc TK_CALL     =  $B1
 defc TK_WRITE    =  $B2
 defc TK_COMMON   =  $B3
 defc TK_CHAIN    =  $B4
 defc TK_OPTION   =  $B5
 defc TK_RANDOMIZE = $B6
 defc TK_SYSTEM   =  $B7
 defc TK_OPEN     =  $B8 
 defc TK_FIELD    =  $B9
 defc TK_GET      =  $BA
 defc TK_PUT      =  $BB	; Token for 'PUT' (used also in 'OPEN' to check syntax)
 defc TK_CLOSE    =  $BC
 defc TK_LOAD     =  $BD
 defc TK_MERGE    =  $BE
 defc TK_FILES    =  $BF   ; Token for 'FILES' (MSX uses it also in "MAXFILES")

 defc TK_NAME     =  $C0
 defc TK_KILL     =  $C1

 defc TK_GR       =  $CC
 defc TK_COLOR    =  $CD

 defc TK_HGR      =  $D1
 defc TK_HPLOT    =  $D2
 defc TK_HCOLOR   =  $D3
 defc TK_BEEP     =  $D4
 defc TK_WAIT     =  $D5



 defc TK_TO       =  $DD	; Token for 'TO' identifier in a 'FOR' statement
 defc TK_THEN     =  $DE	; Token for 'THEN'
 defc TK_TAB      =  $DF	; Token for 'TAB('

 defc TK_STEP     =  $E0	; Token for 'STEP' identifier in a 'FOR' statement
 defc TK_USR      =  $E1	; Token for 'USR'
 defc TK_FN       =  $E2	; Token for 'FN'
 defc TK_SPC      =  $E3	; Token for 'SPC('
 defc TK_NOT      =  $E4	; Token for 'NOT'
 defc TK_ERL      =  $E5	; Token for 'ERL'
 defc TK_ERR      =  $E6	; Token for 'ERR'
 defc TK_STRING   =  $E7	; Token for 'STRING$'
 defc TK_USING    =  $E8	; Token for 'USING'
 defc TK_INSTR    =  $E9	; Token for 'INSTR'

 defc TK_APOSTROPHE  =  $EA

 defc TK_VARPTR   =  $EB	; Token for 'VARPTR'
 defc TK_SCRN     =  $EC
 defc TK_HSCRN    =  $ED
 defc TK_INKEY_S  =  $EE


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

;--------------------
 defc LSTOPK      =  TK_BKSLASH+1-TK_PLUS
;--------------------





; Routine at 256
L0100:
  JP _HIRES_PAGE

; Data block at 259
L0103:
  DEFW __CINT

; Data block at 261
L0105:
  DEFW MAKINT
  DEFW $5600

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
  DEFW __DEF
  DEFW __POKE
  DEFW __CONT
  DEFW SN_ERR
  DEFW SN_ERR
  DEFW __LPRINT
  DEFW __LLIST
  DEFW __WIDTH
  DEFW __REM
  DEFW __TRACE
  DEFW __NOTRACE
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
  DEFW __POP
  DEFW __WHILE
  DEFW __WEND
  DEFW __CALL
  DEFW __WRITE
  DEFW __DATA
  DEFW __CHAIN
  DEFW __OPTION
  DEFW __RANDOMIZE
  DEFW __SYSTEM
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
  DEFW __TEXT
  DEFW __HOME
  DEFW __VTAB
  DEFW __HTAB
  DEFW __INVERSE
  DEFW __NORMAL
  DEFW __GR
  DEFW __COLOR
  DEFW __HLIN
  DEFW __VLIN
  DEFW __PLOT
  DEFW __HGR
  DEFW __HPLOT
  DEFW __HCOLOR
  DEFW __BEEP
  DEFW __WAIT
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
  DEFW __VPOS
  DEFW __PDL
  DEFW __BUTTON
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

; BASIC keyword list
WORDS:
  DEFB $04

; Message at 594
WORDS_A:
  DEFM "N"
  DEFB $C4
  DEFB $F7
  DEFM "B"
  DEFB $D3
  DEFB $06
  DEFM "T"
  DEFB $CE
  DEFB $0E
  DEFM "S"
  DEFB $C3
  DEFB $14
  DEFM "UT"
  DEFB $CF
  DEFB $A7
  DEFB $00

; Message at 611
WORDS_B:
  DEFM "UTTO"
  DEFB $CE
  DEFM "6EE"
  DEFB $D0
  DEFB $D4
  DEFB $00

; Message at 622
WORDS_C:
  DEFM "LOS"
  DEFB $C5
  DEFB $BC
  DEFM "ON"
  DEFB $D4
  DEFB $98
  DEFM "LEA"
  DEFB $D2
  DEFB $92
  DEFM "IN"
  DEFB $D4
  DEFB $1B
  DEFM "SN"
  DEFB $C7
  DEFB $1C
  DEFM "DB"
  DEFB $CC
  DEFB $1D
  DEFM "V"
  DEFB $C9
  DEFM "*V"
  DEFB $D3
  DEFM "+V"
  DEFB $C4
  DEFM ",O"
  DEFB $D3
  DEFB $0C
  DEFM "HR"
  DEFB $A4
  DEFB $15
  DEFM "AL"
  DEFB $CC
  DEFB $B1
  DEFM "OMMO"
  DEFB $CE
  DEFB $B3
  DEFM "HAI"
  DEFB $CE
  DEFB $B4
  DEFM "OLO"
  DEFB $D2
  DEFB $CD
  DEFB $00

; Message at 685
WORDS_D:
  DEFM "AT"
  DEFB $C1
  DEFB $84
  DEFM "I"
  DEFB $CD
  DEFB $86
  DEFM "EFST"
  DEFB $D2
  DEFB $A9
  DEFM "EFIN"
  DEFB $D4
  DEFB $AA
  DEFM "EFSN"
  DEFB $C7
  DEFB $AB
  DEFM "EFDB"
  DEFB $CC
  DEFB $AC
  DEFM "E"
  DEFB $C6
  DEFB $96
  DEFM "ELET"
  DEFB $C5
  DEFB $A6
  DEFM "E"
  DEFB $CC
  DEFB $A6
  DEFB $00

; Message at 729
WORDS_E:
  DEFM "N"
  DEFB $C4
  DEFB $81
  DEFM "LS"
  DEFB $C5
  DEFB $9E
  DEFM "RAS"
  DEFB $C5
  DEFB $A2
  DEFM "DI"
  DEFB $D4
  DEFB $A3
  DEFM "RRO"
  DEFB $D2
  DEFB $A4
  DEFM "R"
  DEFB $CC
  DEFB $E5
  DEFM "R"
  DEFB $D2
  DEFB $E6
  DEFM "X"
  DEFB $D0
  DEFB $0B
  DEFM "O"
  DEFB $C6
  DEFM ".Q"
  DEFB $D6
  DEFB $FA
  DEFB $00

; Message at 766
WORDS_F:
  DEFM "O"
  DEFB $D2
  DEFB $82
  DEFM "IEL"
  DEFB $C4
  DEFB $B9
  DEFM "ILE"
  DEFB $D3
  DEFB $BF
  DEFB $CE
  DEFB $E2
  DEFM "R"
  DEFB $C5
  DEFB $0F
  DEFM "I"
  DEFB $D8
  DEFB $1E
  DEFB $00

; Message at 788
WORDS_G:
  DEFM "OT"
  DEFB $CF
  DEFB $89
  DEFM "O T"
  DEFB $CF
  DEFB $89
  DEFM "OSU"
  DEFB $C2
  DEFB $8D
  DEFM "E"
  DEFB $D4
  DEFB $BA
  DEFB $D2
  DEFB $CC
  DEFB $00

; Message at 808
WORDS_H:
  DEFM "OM"
  DEFB $C5
  DEFB $C7
  DEFM "LI"
  DEFB $CE
  DEFB $CE
  DEFM "G"
  DEFB $D2
  DEFB $D1
  DEFM "COLO"
  DEFB $D2
  DEFB $D3
  DEFM "PLO"
  DEFB $D4
  DEFB $D2
  DEFM "TA"
  DEFB $C2
  DEFB $C9
  DEFM "SCR"
  DEFB $CE
  DEFB $ED
  DEFM "EX"
  DEFB $A4
  DEFB $19
  DEFB $00

; Message at 844
WORDS_I:
  DEFM "NPU"
  DEFB $D4
  DEFB $85
  DEFB $C6
  DEFB $8B
  DEFM "NST"
  DEFB $D2
  DEFB $E9
  DEFM "N"
  DEFB $D4
  DEFB $05
  DEFM "M"
  DEFB $D0
  DEFB $FB
  DEFM "NKEY"
  DEFB $A4
  DEFB $EE
  DEFM "NVERS"
  DEFB $C5
  DEFB $CA
  DEFB $00

WORDS_J:
  DEFB $00

WORDS_K:
  DEFM "IL"
  DEFB 'L'+$80
  DEFB TK_KILL

  DEFB $00

; Message at 882
WORDS_L:
  DEFM "E"
  DEFB $D4
  DEFB $88
  DEFM "IN"
  DEFB $C5
  DEFB $AD
  DEFM "OA"
  DEFB $C4
  DEFB $BD
  DEFM "SE"
  DEFB $D4
  DEFB $C2
  DEFM "PRIN"
  DEFB $D4
  DEFB $9B
  DEFM "LIS"
  DEFB $D4
  DEFB $9C
  DEFM "PO"
  DEFB $D3
  DEFB $1A
  DEFM "IS"
  DEFB $D4
  DEFB $93
  DEFM "O"
  DEFB $C7
  DEFB $0A
  DEFM "O"
  DEFB $C3
  DEFM "/E"
  DEFB $CE
  DEFB $11
  DEFM "EFT"
  DEFB $A4
  DEFB $01
  DEFM "O"
  DEFB $C6
  DEFM "0"
  DEFB $00

; Message at 934
WORDS_M:
  DEFM "ERG"
  DEFB $C5
  DEFB $BE
  DEFM "O"
  DEFB $C4
  DEFB $FC
  DEFM "KI"
  DEFB $A4
  DEFM "1KS"
  DEFB $A4
  DEFM "2KD"
  DEFB $A4
  DEFM "3ID"
  DEFB $A4
  DEFB $03
  DEFB $00

; Message at 959
WORDS_N:
  DEFM "EX"
  DEFB $D4
  DEFB $83
  DEFM "ORMA"
  DEFB $CC
  DEFB $CB
  DEFM "OTRAC"
  DEFB $C5
  DEFB $A0
  DEFM "AM"
  DEFB $C5
  DEFB $C0
  DEFM "E"
  DEFB $D7
  DEFB $94
  DEFM "O"
  DEFB $D4
  DEFB $E4
  DEFB $00

; Message at 987
WORDS_O:
  DEFB $CE
  DEFB $95
  DEFM "PE"
  DEFB $CE
  DEFB $B8
  DEFB $D2
  DEFB $F8
  DEFM "CT"
  DEFB $A4
  DEFB $18
  DEFM "PTIO"
  DEFB $CE
  DEFB $B5
  DEFB $00

; Message at 1006
WORDS_P:
  DEFM "U"
  DEFB $D4
  DEFB $BB
  DEFM "OK"
  DEFB $C5
  DEFB $97
  DEFM "RIN"
  DEFB $D4
  DEFB $91
  DEFM "O"
  DEFB $D3
  DEFB $10
  DEFM "EE"
  DEFB $CB
  DEFB $16
  DEFM "LO"
  DEFB $D4
  DEFB $D0
  DEFM "D"
  DEFB $CC
  DEFM "5O"
  DEFB $D0
  DEFB $AE
  DEFB $00

; Message at 1036
WORDS_Q:
  DEFB $00

; Message at 1037
WORDS_R:
  DEFM "EA"
  DEFB $C4
  DEFB $87
  DEFM "U"
WORDS_R_0:
  DEFB $CE
  DEFB $8A
  DEFM "ESTOR"
  DEFB $C5
  DEFB $8C
  DEFM "ETUR"
  DEFB $CE
  DEFB $8E
  DEFM "E"
  DEFB $CD
  DEFB $8F
  DEFM "ESUM"
  DEFB $C5
  DEFB $A5
  DEFM "SE"
  DEFB $D4
  DEFB $C3
  DEFM "IGHT"
  DEFB $A4
  DEFB $02
  DEFM "N"
  DEFB $C4
  DEFB $08
  DEFM "ENU"
  DEFB $CD
  DEFB $A8
  DEFM "ESE"
  DEFB $D4
  DEFB $C5
  DEFM "ANDOMIZ"
  DEFB $C5
  DEFB $B6
  DEFB $00

; Message at 1099
WORDS_S:
  DEFM "TO"
  DEFB $D0
  DEFB $90
  DEFM "WA"
  DEFB $D0
  DEFB $A1
  DEFM "AV"
  DEFB $C5
  DEFB $C4
  DEFM "PC"
  DEFB $A8
  DEFB $E3
  DEFM "TE"
  DEFB $D0
  DEFB $E0
  DEFM "G"
  DEFB $CE
  DEFB $04
  DEFM "Q"
  DEFB $D2
  DEFB $07
  DEFM "I"
  DEFB $CE
  DEFB $09
  DEFM "TR"
  DEFB $A4
  DEFB $12
  DEFM "TRING"
  DEFB $A4
  DEFB $E7
  DEFM "PACE"
  DEFB $A4
  DEFB $17
  DEFM "YSTE"
  DEFB $CD
  DEFB $B7
  DEFM "CR"
  DEFB $CE
  DEFB $EC
  DEFB $00

; Message at 1156
WORDS_T:
  DEFM "RAC"
  DEFB $C5
  DEFB $9F
  DEFM "AB"
  DEFB $A8
  DEFB $DF
  DEFB $CF
  DEFB $DD
  DEFM "HE"
  DEFB $CE
  DEFB $DE
  DEFM "A"
  DEFB $CE
  DEFB $0D
  DEFM "EX"
  DEFB $D4
  DEFB $C6
  DEFB $00

; Message at 1179
WORDS_U:
  DEFM "SIN"
  DEFB $C7
  DEFB $E8
  DEFM "S"
  DEFB $D2
  DEFB $E1
  DEFB $00

; Message at 1188
WORDS_V:
  DEFM "A"
  DEFB $CC
  DEFB $13
  DEFM "ARPT"
  DEFB $D2
  DEFB $EB
  DEFM "LI"
  DEFB $CE
  DEFB $CF
  DEFM "TA"
  DEFB $C2
  DEFB $C8
  DEFM "PO"
  DEFB $D3
  DEFM "4"
  DEFB $00

; Message at 1210
WORDS_W:
  DEFM "IDT"
  DEFB $C8
  DEFB $9D
  DEFM "AI"
  DEFB $D4
  DEFB $D5
  DEFM "HIL"
  DEFB $C5
  DEFB $AF
  DEFM "EN"
  DEFB $C4
  DEFB $B0
  DEFM "RIT"
  DEFB $C5
  DEFB $B2
  DEFB $00

; Message at 1234
WORDS_X:
  DEFM "O"
  DEFB $D2
  DEFB $F9
  DEFB $00

; Message at 1238
WORDS_Y:
  DEFB $00

; Message at 1239
WORDS_Z:
  DEFB $00

; Data block at 1240
OPR_TOKENS:
  DEFB $AB,$F2,$AD,$F3,$AA,$F4,$AF,$F5
  DEFB $DE,$F6,$DC,$FD,$A7,$EA,$BE,$EF
  DEFB $BD,$F0,$BC,$F1,$00


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

; Data block at 1273
TYPE_OPR:
  DEFW __CDBL
  DEFW $0000
  DEFW __CINT
  DEFW TSTSTR
  DEFW __CSNG

;
; THESE TABLES ARE USED AFTER THE DECISION HAS BEEN MADE
; TO APPLY AN OPERATOR AND ALL THE NECESSARY CONVERSION HAS
; BEEN DONE TO MATCH THE TWO ARGUMENT TYPES (APPLOP)
;
; ARITHMETIC OPERATIONS TABLE

; Data block at 1283
DEC_OPR:
  DEFW DADD             ;DOUBLE PRECISION ROUTINES
  DEFW DSUB
  DEFW DMUL
  DEFW DDIV
  DEFW DCOMP

defc OPCNT = ((FLT_OPR-DEC_OPR)/2)-1

; Data block at 1293
FLT_OPR:
  DEFW FADD               ;SINGLE PRECISION ROUTINES
  DEFW FSUB
  DEFW FMULT
  DEFW FDIV
  DEFW FCOMP

; Data block at 1303
INT_OPR:
  DEFW IADD               ;INTEGER ROUTINES
  DEFW ISUB
  DEFW IMULT
  DEFW IDIV
  DEFW ICOMP

; Message at 1313
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
  DEFM "Reset error"
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
  DEFM "Disk Read Only"
  DEFB $00
  DEFM "Drive select error"
  DEFB $00
  DEFM "File Read Only"
  DEFB $00
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $D0
  DEFM "4"
  DEFB $01

; ISCNTC STORES EATEN CHAR HERE WHEN NOT A ^C
CHARC:
  DEFW $0000

; Data block at 2101
ERRFLG:
  DEFB $00

;LPTLST:  <--  not used
  DEFB $00

LPTPOS:
  DEFB $01

; Data block at 2104
PRTFLG:
  DEFB $00

; Data block at 2105
COMMAN:
  DEFB (((LPTLEN/CLMWID)-1)*CLMWID)    ; LAST COMMA FIELD POSITION

; Data block at 2106
LPTSIZ:
  DEFB LPTLEN

; Text horizontal size, configured with 'WIDTH'
LINLEN:
  DEFB LINLN

; Text vertical size, configured with 'WIDTH'
CRTCNT:
  DEFB LINCT

; Data block at 2109
NCMPOS:
  DEFB (((LINLN/CLMWID)-1)*CLMWID)     ; POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS

RUBSW:
  DEFB $00                ; RUBOUT SWITCH =1 INSIDE THE PROCESSING OF A RUBOUT (INLIN)

; Data block at 2111
CTLOFG:
  DEFB $00

; Data block at 2112
PTRFIL:
  DEFW $0000

; Data block at 2114
STKTOP:
  DEFW $852C
CURLIN:
  DEFW $FFFE

; BASIC program start ptr (aka BASTXT)
TXTTAB:
  DEFW $84C9
  
OVERRI:
  DEFW OVERFLOW_MSG       ; Text PTR to current error message in math operations

; Data block at 2122
AUTORUN:
  DEFW $0000

; Data block at 2123
MAXFILSV:
  DEFW $0000

MAXTRK:
  DEFB $00                ; ALLOCATE INSIDE THIS TRACK

; Data block at 2126
FILPT1:
  DEFW $0000

; FILE POINTER TABLE
FILPTR:
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
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000

; Data block at 2160
MAXFIL:
  DEFB $00

; Data block at 2161
NAMCNT:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00

; The File Control Block is a 36-byte data structure (33 bytes in CP/M 1).
; Second storage space for the file name (like FILNAM)
FILNA2:
  DEFS 16


; also FCB_DRV
FILNAM:
  DEFB $00

; Data block at 2219
FCB_FNAME:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00

; Data block at 2227
FCB_FTYP:
  DEFB $00,$00,$00

; Data block at 2230
FCB_EXTENT:
  DEFB $00

; Data block at 2231
FCB_S1:
  DEFB $00

; Data block at 2232
FCB_S2:
  DEFB $00

; Data block at 2233
FCB_RC:
  DEFB $00

; Data block at 2234
FCB_AL:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00

IF CPMV1
BDOSVER:
  DEFB $00                ; Current CP/M BDOS version number (#0 is 2.x)

; BDOS function pair, either R/W or SELECT/OPEN
CPMREA:
  DEFB $00                ; BDOS function code for 'READ' (BDOS v2) or 'SELECT DSK' (BDOS v1) call 
CPMWRT:
  DEFB $00                ; BDOS function code for 'WRITE' (BDOS v2) or 'OPEN FILE' (BDOS v1) call
ENDIF

; Start of input buffer
BUFFER:
  DEFM ":"

; Data block at 2255
KBUF:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Message at 2573
BUFMIN:
  DEFM ","

; Data block at 2574
BUF:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; Data block at 2832
ENDBUF:
  DEFB $00

; Character position on line
TTYPOS:
  DEFB $00

; Character position on column
TTY_VPOS:
  DEFB $00

  
; IN GETTING A POINTER TO A VARIABLE IT IS IMPORTANT TO REMEMBER WHETHER IT
; IS BEING DONE FOR "DIM" OR NOT DIMFLG AND VALTYP MUST BE CONSECUTIVE LOCATIONS
;
; Data block at 2835
DIMFLG:
  DEFB $00
; type indicator
VALTYP:
  DEFB $00

; a.k.a. DORES, indicates whether stored word can be crunched, etc..
OPRTYP:
  DEFB $00

; indicates whether we have a number
DONUM:
  DEFB $00

; Text address used by CHRGTB
CONTXT:
  DEFW $0000

; Saved token of constant after calling CHRGET
CONSAV:
  DEFB $00

; SAVED CONSTANT VALTYPE
CONTYP:
  DEFB $00

; SAVED CONSTANT VALUE
CONLO:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00

; Data block at 2851
MEMSIZ:
  DEFW $0000
TEMPPT:
  DEFW $0000
TEMPST:
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
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFB $00
  
DSCTMP:
  DEFB $00                ; String descriptor which is the result of string fun

TMPSTR:
  DEFW $0000

; Starting address of unused area of string area
FRETOP:
  DEFW $0000

; (word) used for garbage collection or by USR function
TEMP3:
  DEFW $0000

; Used for garbage collection and at boot as "CPMFIL"
TEMP8:
  DEFW $0000

; Next address of FOR st.
ENDFOR:
  DEFW $0000

; Line number of DATA st.read by READ st.
DATLIN:
  DEFW $0000

; (byte), flag for USR fn. array
SUBFLG:
  DEFB $00

; Data block at 2899
FLGINP:
  DEFB $00

; (word) temp. reservation for st.code
TEMP:
  DEFW $0000

; =0 if no line number converted to pointers
PTRFLG:
  DEFB $00

; AUTO mode flag
AUTFLG:
  DEFB $00

; Data block at 2904
AUTLIN:
  DEFW $0000

; Increment for auto
AUTINC:
  DEFW $0000

; (word), prg pointer for resume
SAVTXT:
  DEFW $0000

; Save stack when error occurs
SAVSTK:
  DEFW $0000

; (word), line number where an error occurred
ERRLIN:
  DEFW $0000

; Data block at 2914
DOT:
  DEFW $0000

; Error messages text table
ERRTXT:
  DEFB $00,$00

; Data block at 2918
ONELIN:
  DEFW $0000

; Data block at 2920
ONEFLG:
  DEFB $00

; (word) temp. storage used by EVAL, a.k.a. TEMP2
NXTOPR:
  DEFW $0000
OLDLIN:
  DEFW $0000
OLDTXT:
  DEFW $0000
VARTAB:
  DEFW $0000
ARYTAB:
  DEFW $0000
STREND:
  DEFW $0000

; Next DATA statement
DATPTR:
  DEFW $0000

; Data block at 2935
DEFTBL:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; (word), previous block definition on stack
PRMSTK:
  DEFW $0000

; (word), number of bytes of obj table
PRMLEN:
  DEFW $0000

; Objective prameter definition table (100 bytes)
PARM1:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00

; Data block at 3065
PRMPRV:
  DEFW PRMSTK

; (word), size of parameter block
PRMLN2:
  DEFW $0000

; For parameter storage
PARM2:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00

; Flag to indicate whether PARM1 was searching
PRMFLG:
  DEFB $00

; End point of search
ARYTA2:
  DEFW $0000

; (byte), 0 if no function active
NOFUNS:
  DEFB $00

; Location of temporary storage for garbage collection
TEMP9:
  DEFW $0000

; (word), active functions counter
FUNACT:
  DEFW $0000

; Flag to indicate the READ status
READFLG:
  DEFB $00

; Used by NEXT to save code ptr
NEXTMP:
  DEFW $0000

; Flag used by NEXT
NEXFLG:
  DEFB $00

; FP accumulator used by FOR/NEXT commands
FVALSV:
  DEFB $00,$00,$00,$00

; (word), temp line no. storage used in FOR, WHILE, etc..
NXTLIN:
  DEFW $0000

; Array size set with "OPTION BASE", (for 10=default size, value is '0': 10+1
; XOR 11)
OPTVAL:
  DEFB $00

; Array status flag to deal with "OPTION BASE"
OPTFLG:
  DEFB $00

;
; This function was used once only and
; has been removed in the later versions
;
; Routine at 3189
;
; Used by the routine at OPNFIL.
GET_FILEMODE:
  POP HL
  POP DE                    ;GET BACK FILE POINTER
  POP AF                    ;GET MODE OF FILE  (LD A,(DE) somewhere else)
  PUSH AF
  PUSH DE
  JP (HL)

; Routine at 3195
;
; Used by the routine at L4B88.
L0C7B:
  LD HL,(SAVSTK)
  LD SP,HL
  PUSH DE
  LD C,$0E
  JP L4B8B
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP

; Data block at 3219
INTFLG:
  DEFB $00

; Data block at 3220
IMPFLG:
  DEFB $00

; Data block at 3221
SAVFRE:
  DEFW $0000

; a.k.a. RECSIZ
MAXREC:
  DEFW $0000

; 'File protected' status flag
PROFLG:
  DEFW $0000

; 'In MERGE' status flag
MRGFLG:
  DEFB $00

; Flag to track the 'DELETE' or 'MERGE' option in a CHAIN command
MDLFLG:
  DEFB $00

; End line number in a range specified for 'CHAIN'
CMEPTR:
  DEFW $0000

; Start line number in a range specified for 'CHAIN'
CMSPTR:
  DEFW $0000

; Data block at 3232
CHNFLG:
  DEFB $00

; Line number to go to after the CHAIN command execution
CHNLIN:
  DEFW $0000

; Value of first variable in SWAP st (8 bytes).
SWPTMP:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00

; 'TRACE' status flag (0 MEANS NO TRACE)
TRCFLG:
  DEFB $00,$00

; Data block at 3245
FACLOW:
  DEFB $00,$00,$00,$00
FACCU:
  DEFB $00,$00,$00
FPEXP:
  DEFB $00
SGNRES:
  DEFB $00

; OVERFLOW PRINT FLAG,=0,1 PRINT   FURTHER =1 CHANGE TO 2
FLGOVC:
  DEFB $00

; Data block at 3255
OVCSTR:
  DEFB $00

; Data block at 3256
FANSII:
  DEFB $00,$00

; Data block at 3258
FPARG:
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000

; Data block at 3265
ARG:
  DEFB $00
FBUFFR:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00

; Message at 3309
IN_MSG:
  DEFM " in "

; Message at 3313
NULL_STRING:
  DEFB $00

; Message at 3314
OK_MSG:
  DEFM "Ok"
  DEFB $0D
  DEFB $0A
  DEFB $00

; Message at 3319
BREAK_MSG:
  DEFM "Break"
  DEFB $00

; Routine at 3325
;
; Used by the routines at __POP, __RETURN and __NEXT.
BAKSTK:
  LD HL,$0004
  ADD HL,SP

; Routine at 3329
;
; Used by the routines at INDFND and L329B.
LOKFOR:
  LD A,(HL)
  INC HL
  CP $AF
  JR NZ,LOKFOR_0
  LD BC,$0006
  ADD HL,BC
  JR LOKFOR
LOKFOR_0:
  CP $82
  RET NZ
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH HL
  LD L,C
  LD H,B
  LD A,D
  OR E
  EX DE,HL
  JR Z,INDFND
  EX DE,HL
  CALL DCOMPR

; Routine at 3360
;
; Used by the routine at LOKFOR.
INDFND:
  LD BC,$0010
  POP HL
  RET Z
  ADD HL,BC
  JR LOKFOR
  LD BC,RESTART
  JP ERRESM_0

; Routine at 3374
;
; Used by the routine at NEWSTT_0.
PRG_END:
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JR Z,PRG_END_0
  LD A,(ONEFLG)
  OR A
  LD E,$13
  JR NZ,ERROR
PRG_END_0:
  JP ENDCON

; Routine at 3393
;
; Used by the routine at __EOF.
DSK_FULL_ERR:
  LD E,$3D

; "LD BC,nn" to jump over the next word without executing it
L0D43:
  DEFB $01

; "DISK I/O ERROR"
;
; Used by the routine at __EOF.
DISK_ERR:
  LD E,$39

; "LD BC,nn" to jump over the next word without executing it
L0D46:
  DEFB $01

; Routine at 3399
;
; Used by the routines at FILGET, OKGETM, __FIELD, L79F2, __EOF, __OPEN and
; __GET.
FMODE_ERR:
  LD E,$36

; "LD BC,nn" to jump over the next word without executing it
L0D49:
  DEFB $01

; Routine at 3402
;
; Used by the routines at __NAME, OPNFIL, __KILL and __FILES.
FF_ERR:
  LD E,$35

; "LD BC,nn" to jump over the next word without executing it
L0D4C:
  DEFB $01

; Routine at 3405
;
; Used by the routines at FILID2, __FIELD, __EOF, __LOC, __LOF and L7D2F.
BN_ERR:
  LD E,$34

; "LD BC,nn" to jump over the next word without executing it
L0D4F:
  DEFB $01

; Routine at 3408
IE_ERR:
  LD E,$33

; "LD BC,nn" to jump over the next word without executing it
L0D52:
  DEFB $01

; Routine at 3411
;
; Used by the routines at LINE_INPUT and DSKCHR.
EF_ERR:
  LD E,$3E

; "LD BC,nn" to jump over the next word without executing it
L0D55:
  DEFB $01

; Routine at 3414
;
; Used by the routine at PRGFIL.
AO_ERR:
  LD E,$37

; "LD BC,nn" to jump over the next word without executing it
L0D58:
  DEFB $01

; Routine at 3417
;
; Used by the routines at FNAME and FILLNM.
NM_ERR:
  LD E,$40

; "LD BC,nn" to jump over the next word without executing it
L0D5B:
  DEFB $01

; Routine at 3420
;
; Used by the routine at __GET.
RECNO_ERR:
  LD E,$3F

; "LD BC,nn" to jump over the next word without executing it
L0D5E:
  DEFB $01

; Routine at 3423
;
; Used by the routines at L7913 and __GET.
DERFOV:
  LD E,$32

; "LD BC,nn" to jump over the next word without executing it
L0D61:
  DEFB $01

; Routine at 3426
;
; Used by the routines at __EOF, MAKFIL and ACCFIL.
FL_ERR:
  LD E,$43

; "LD BC,nn" to jump over the next word without executing it
L0D64:
  DEFB $01

; Routine at 3429
;
; Used by the routine at L7CCF.
FILE_EXISTS_ERR:
  LD E,$3A
  JR ERROR

; 'SN err' entry for Input STMT
;
; Used by the routine at TRMNOK.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?SN ERROR'
;
; Used by the routines at LNUM_RANGE, SAVSTP, NEWSTT_0, L36E3, SCNSTR, NOTQTI,
; LOPREL, OCTCNS, L3F72, L402A, L4305, L4423, PTRGET, SHTNAM, NOTSCI, SYNCHR,
; L6A82, __WEND, L7317, L7799, __MERGE, __GET and ENDCMD.
SN_ERR:
  LD E,$02

; Data block at 3441
L0D71:
  DEFB $01

; DIVISION BY ZERO
;
; Used by the routines at FMULTT and OVERR.
O_ERR:
  LD E,$0B

; Data block at 3444
L0D74:
  DEFB $01

; "NEXT WITHOUT FOR" ERROR
;
; Used by the routine at __NEXT.
NF_ERR:
  LD E,$01

; Data block at 3447
L0D77:
  DEFB $01

; "REDIMENSIONED VARIABLE"
;
; Used by the routines at L4423 and FNDARY.
DD_ERR:
  LD E,$0A

; Data block at 3450
L0D7A:
  DEFB $01

; "UNDEFINED FUNCTION" ERROR
;
; Used by the routine at DOFN.
UFN_ERR:
  LD E,$12

; Data block at 3453
L0D7D:
  DEFB $01

; "RESUME WITHOUT ERROR"
;
; Used by the routine at __RESUME.
RW_ERR:
  LD E,$14

; Data block at 3456
L0D80:
  DEFB $01

; OVERFLOW ERROR
;
; Used by the routines at OCTCNS, __CINT, OVERR and __NEXT.
OV_ERR:
  LD E,$06

; Data block at 3459
L0D83:
  DEFB $01

; MISSING OPERAND ERROR
;
; Used by the routine at OPRND.
MO_ERR:
  LD E,$16

; Data block at 3462
L0D86:
  DEFB $01

; TYPE MISMATCH ERROR
;
; Used by the routines at L32F3, EVAL_NUMERIC, EVAL1, INVSGN, VSIGN, __CINT,
; __CSNG, __CDBL, TSTSTR, __INT and L69DC.
TM_ERR:
  LD E,$0D

; Routine at 3465
;
; Used by the routines at PRG_END, FILE_EXISTS_ERR, KRNSAV, INTIDX, UL_ERR,
; __RETURN, __ERROR, FDTLP, IDTEST, SCNCNT, L4B8B, FNDARY, OM_ERR, __CONT,
; TSTOPL, TESTOS, CONCAT, WE_ERR and DIRDO.
ERROR:
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  XOR A
  LD (MRGFLG),A
  LD (CHNFLG),A
  LD A,H
  AND L
  INC A
  JR Z,ERRESM
  LD (DOT),HL

; Routine at 3486
;
; Used by the routines at ERROR and L364D.
ERRESM:
  LD BC,ERRMOR
; This entry point is used by the routine at INDFND.
ERRESM_0:
  LD HL,(SAVSTK)
  JP STKERR

; Routine at 3495
ERRMOR:
  POP BC
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
  JR Z,ERRMOR_0
  LD (OLDLIN),HL
  EX DE,HL
  LD (OLDTXT),HL
ERRMOR_0:
  LD HL,(ONELIN)
  LD A,H
  OR L
  EX DE,HL
  LD HL,ONEFLG
  JR Z,ERRMOR_1
  AND (HL)
  JR NZ,ERRMOR_1
  DEC (HL)
  EX DE,HL
  JP GONE4
ERRMOR_1:
  XOR A
  LD (HL),A
  LD E,C
  LD (CTLOFG),A
  CALL CONSOLE_CRLF
  LD HL,ERROR_MESSAGES
  LD A,E
  CP $47
  JR NC,ERRMOR_2
  CP $32
  JR NC,ERRMOR_3
  CP $20
  JR C,ERRMOR_4
ERRMOR_2:
  LD A,$27
ERRMOR_3:
  SUB $12
  LD E,A
ERRMOR_4:
  CALL __REM
  INC HL
  DEC E
  JR NZ,ERRMOR_4
  PUSH HL
  LD HL,(ERRLIN)
  EX (SP),HL
; This entry point is used by the routine at ENDCON.
ERRMOR_5:
  LD A,(HL)
  CP $3F
  JR NZ,ERRMOR_6
  POP HL
  LD HL,ERROR_MESSAGES
  JR ERRMOR_2
ERRMOR_6:
  CALL PRS
  POP HL
  LD DE,$FFFE
  CALL DCOMPR
  CALL Z,OUTDO_CRLF
  JP Z,EXIT_TO_SYSTEM
  LD A,H
  AND L
  INC A
  CALL NZ,IN_PRT
  LD A,$C1

; Routine at 3618
;
; Used by the routines at __LIST and ENDCON.
RESTART:
  POP BC
; This entry point is used by the routines at PROMPT, __LIST, EDIT_QUIT, BINLOD
; and PROCHK.
READY:
  CALL FINLPT
  XOR A
  LD (CTLOFG),A
  CALL LOAD_END
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  CALL $0000
  LD A,(ERRFLG)
  SUB $02
  CALL Z,FNDARY_22

; Routine at 3646
;
; Used by the routines at AUTSTR, GETCMD, FINI, L36E3, NOTRNL, OKGETM and
; MAINGO.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL
  LD A,(AUTFLG)
  OR A
  JR Z,GETCMD
  LD HL,(AUTLIN)
  PUSH HL
  CALL LINPRT
  POP DE
  PUSH DE
  CALL SRCHLN
  LD A,$2A
  JR C,PROMPT_0
  LD A,$20
PROMPT_0:
  CALL OUTDO
  CALL PINLIN
  POP DE
  JR NC,AUTGOD
  XOR A
  LD (AUTFLG),A
  JR READY

; This entry point is used by the routine at AUTGOD.
PROMPT_1:
  XOR A
  LD (AUTFLG),A
  JR AUTSTR

; Routine at 3697
;
; Used by the routine at PROMPT.
AUTGOD:
  LD HL,(AUTINC)
  ADD HL,DE
  JR C,PROMPT_1
  PUSH DE
  LD DE,$FFF9
  CALL DCOMPR
  POP DE
  JR NC,PROMPT_1
  LD (AUTLIN),HL

; Routine at 3716
;
; Used by the routine at PROMPT.
AUTSTR:
  LD A,(BUF)
  OR A
  JR Z,PROMPT
  JP EDITRT

; Routine at 3725
;
; Used by the routine at PROMPT.
GETCMD:
  CALL PINLIN             ; GET A LINE FROM TTY
  JR C,PROMPT             ; IGNORE ^C S
  CALL CHRGTB             ; Get first character                  GET THE FIRST
  INC A                   ; Test if end of line                  SEE IF 0 SAVING THE CARRY FLAG
  DEC A                   ; Without affecting Carry
  JR Z,PROMPT             ; Nothing entered - Get another        IF SO, A BLANK LINE WAS INPUT
  PUSH AF                 ; Save Carry status                    SAVE STATUS INDICATOR FOR 1ST CHARACTER
  CALL ATOH               ; Get line number into DE              READ IN A LINE #
  CALL BAKSP              ; BACK UP THE POINTER
  LD A,(HL)               ;GET THE CHAR
  CP ' '                  ; Is it a space?                       CHARACTER A SPACE?
  CALL Z,INCHL            ;THEN EAT PAST IT
                          ;(ONE SPACE ALWAYS PRINTED AFTER LINE #)

; Routine at 3750
;
; Used by the routine at EDITRT.
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
  EX DE,HL
  LD (DOT),HL             ;LD (DOT),DE  (***)    ;SAVE THIS LINE # IN DOT;
  EX DE,HL
  CALL SRCHLN             ; Search for line number in DE: GET A POINTER TO THE LINE
  JR C,LINFND             ; Jump if line found: LINE EXISTS, DELETE IT
  POP AF                  ;GET FLAG SAYS WHETHER LINE BLANK
  PUSH AF                 ;SAVE BACK
  JP Z,UL_ERR             ;TRYING TO DELETE NON-EXISTANT LINE, ERROR
  OR A                    ;CLEAR FLAG THAT SAYS LINE EXISTS

; Routine at 3788
;
; Used by the routine at EDENT.
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
  JR Z,FINI               ;IF NOT DON'T INSERT
  POP DE                  ;GET RID OF START OF LINK FIX
  LD A,(CHNFLG)           ;ONLY CHANGET FRETOP IF NOT CHAINING
  OR A                    ; Clear Carry
  JR NZ,LEVFRE            ;LEAVE FRETOP ALONE
  LD HL,(MEMSIZ)          ;DELETE ALL STRINGS
  LD (FRETOP),HL          ;SO REASON DOESNT USE THEM

; Routine at 3819
;
; Used by the routine at LINFND.
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

; Routine at 3852
; NOW TRANSFERING LINE IN FROM BUF
MOVBUF:
  LD A,(DE)               ; Get source
  LD (HL),A               ; Save destinations
  INC HL                  ; Next source
  INC DE                  ; Next destination
  DEC BC
  LD A,C
  OR B                    ; Done?
  JR NZ,MOVBUF            ; No - Repeat

; Routine at 3861
;
; Used by the routine at LINFND.
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

; Routine at 3897
;
; Used by the routines at CDVARS and BINLOD.
LINKER:
  LD HL,(TXTTAB)
  EX DE,HL

; Routine at 3901
;
;
; CHEAD GOES THROUGH PROGRAM STORAGE AND FIXES
; UP ALL THE LINKS. THE END OF EACH
; LINE IS FOUND BY SEARCHING FOR THE ZERO AT THE END.
; THE DOUBLE ZERO LINK IS USED TO DETECT THE END OF THE PROGRAM
;
; Used by the routine at FINI.
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
  JR Z,CZLIN              ;END OF LINE, DONE.
  CP DBLCON+1             ;EMBEDDED CONSTANT?
  JR NC,CZLOOP            ;NO, GET NEXT
  CP $0A+1                ;IS IT LINEFEED OR BELOW?
  JR C,CZLOOP             ;THEN SKIP PAST
  CALL __CHRCKB           ;GET CONSTANT
  CALL CHRGTB             ;GET OVER IT
  JR CZLOO2               ;GO BACK FOR MORE
CZLIN:
  INC HL                  ;MAKE [H,L] POINT AFTER TEXT
  EX DE,HL                ;SWITCH TEMP
  LD (HL),E               ;DO FIRST BYTE OF FIXUP
  INC HL                  ;ADVANCE POINTER
  LD (HL),D               ;2ND BYTE OF FIXUP
  JP CHEAD                ;KEEP CHAINING TIL DONE

; Read numeric range function parameters
;
; SCNLIN SCANS A LINE RANGE OF
; THE FORM  #-# OR # OR #- OR -# OR BLANK
; AND THEN FINDS THE FIRST LINE IN THE RANGE
;

; Used by the routines at __LIST, __DELETE and L7317.
LNUM_RANGE:
  LD DE,$0000             ;ASSUME START LIST AT ZERO
  PUSH DE                 ;SAVE INITIAL ASSUMPTION
  JP Z,ALL_LIST           ;IF FINISHED, LIST IT ALL
  POP DE                  ;WE ARE GOING TO GRAB A #
  CALL LNUM_PARM          ;GET A LINE #. IF NONE, RETURNS ZERO
  PUSH DE                 ;SAVE FIRST
  JR Z,SNGLIN             ;IF ONLY # THEN DONE.
  LD A,(HL)
  CP ','                  ;This check was removed in the later MBASIC versions
  JR Z,LNUM_RANGE_0
  CP TK_MINUS             ;MUST BE A DASH.
  JP NZ,SN_ERR
LNUM_RANGE_0:
  CALL CHRGTB

ALL_LIST:
  LD DE,65530             ;ASSUME MAX END OF RANGE
  CALL NZ,LNUM_PARM       ;GET THE END OF RANGE
  JP NZ,SN_ERR            ;MUST BE TERMINATOR

SNGLIN:
  EX DE,HL                ;[H,L] = FINAL
  POP DE                  ;GET INITIAL IN [D,E]

; This entry point is used by the routine at L364D.
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

; Routine at 3976
;
; Used by the routines at PROMPT, EDENT, __GOTO, __DELETE, L4305, _LINE2PTR,
; __EDIT, __RESTORE, L7317 and CDVARS.
SRCHLN:
  LD HL,(TXTTAB)        ; Start of program text

; Routine at 3979
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


; 
; This entry point is used by the routine at __GET.
GET_SUB:
  CALL __CHRCKB
  CP '#'
  RET Z
  PUSH HL
  CALL EVAL
  CALL GETYPR
  JR Z,GET_SUB_0
  CALL FILFRM
  POP DE
  POP DE
  JP __GET_0

GET_SUB_0:
  POP HL
  CALL GETVAR
  CALL GETYPR
  JP NZ,FC_ERR
  PUSH HL
  LD A,(DE)
  OR A
  JR Z,GET_SUB_1
  PUSH DE
  EX DE,HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(VARTAB)
  CALL DCOMPR
  POP DE
  JR C,GET_SUB_2
GET_SUB_1:
  LD A,$01
  PUSH DE
  CALL TESTR
  POP HL
  CALL CRTMST_0

  DEFB $FE                ; CP $EB ..hides the "EX DE,HL"

GET_SUB_2:
  EX DE,HL

  LD (HL),$01
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  CALL CHARCG
  CALL Z,INCHR
  LD (DE),A
  POP HL
  POP BC
  RET

; Data block at 4088
L0FF8:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00

; Aux Hi-res graphics page 1X
;
; Used by the routine at L0100.
_HIRES_PAGE:
  LD HL,$6490
  LD DE,$8482
  LD BC,$5483
  LDDR
  JP INIT

; Data block at 4110
GAP:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00

; Code position: $3000
;
; Used by the routine at EDENT.
TOKENIZE:
  XOR A
  LD (DONUM),A
  LD (OPRTYP),A
  LD BC,$013B
  LD DE,KBUF
; This entry point is used by the routines at ISVARS, SAVINT, NTINTG, STUFFH
; and KRNSAV.
TOKENIZE_0:
  LD A,(HL)
  CP $22
  JP Z,STUFFH_3
  CP $20
  JP Z,STUFFH
  OR A
  JP Z,STUFFH_5
  LD A,(OPRTYP)
  OR A
  LD A,(HL)
  JP NZ,STUFFH
  CP $3F
  LD A,$91
  PUSH DE
  PUSH BC
  JP Z,LNUM_TOKENS_0
  LD DE,OPR_TOKENS
  CALL MAKUPL
  CALL ISLETTER_A
  JP C,TSTNUM
  PUSH HL
  LD BC,$307C
  PUSH BC
  CP $47
  RET NZ
  INC HL
  CALL MAKUPL
  CP $4F
  RET NZ
  INC HL
  CALL MAKUPL
  CP $20
  RET NZ
  INC HL
TOKENIZE_1:
  CALL MAKUPL
  INC HL
  CP $20
  JR Z,TOKENIZE_1
  CP $53
  JR Z,TOKENIZE_2
  CP $54
  RET NZ
  CALL MAKUPL
  CP $4F
  LD A,$89
  JR TOKENIZE_3
TOKENIZE_2:
  CALL MAKUPL
  CP $55
  RET NZ
  INC HL
  CALL MAKUPL
  CP $42
  LD A,$8D
TOKENIZE_3:
  RET NZ
  POP BC
  POP BC
  JP LNUM_TOKENS_0
  POP HL
  CALL MAKUPL
  PUSH HL
  LD HL,$021E
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
; This entry point is used by the routine at LOPSKP.
TRYAGA:
  PUSH HL
LOPPSI:
  CALL MAKUPL
  LD C,A
  LD A,(DE)
  AND $7F
  JP Z,KRNSAV_1
  INC HL
  CP C
  JR NZ,LOPSKP
  LD A,(DE)
  INC DE
  OR A
  JP P,LOPPSI
  LD A,C
  CP $28
  JR Z,ISRESW
  LD A,(DE)
  CP $E2
  JR Z,ISRESW
  CP $E1
  JR Z,ISRESW
  CALL MAKUPL
  CP $2E
  JR Z,ISVARS
  CALL TSTANM

; Routine at 12477
;
; Used by the routine at TOKENIZE.
ISVARS:
  LD A,$00
  JP NC,KRNSAV_1
; This entry point is used by the routine at TOKENIZE.
ISRESW:
  POP AF
  LD A,(DE)
  OR A
  JP M,LNUM_TOKENS
  POP BC
  POP DE
  OR $80
  PUSH AF
  LD A,$FF
  CALL KRNSAV
  XOR A
  LD (DONUM),A
  POP AF
  CALL KRNSAV
  JP TOKENIZE_0

; Routine at 12509
;
; Used by the routine at TOKENIZE.
LOPSKP:
  POP HL
LOPSKP_0:
  LD A,(DE)
  INC DE
  OR A
  JP P,LOPSKP_0
  INC DE
  JR TRYAGA

; Routine at 12519
;
; Used by the routine at ISVARS.
LNUM_TOKENS:
  DEC HL
; This entry point is used by the routine at TOKENIZE.
LNUM_TOKENS_0:
  PUSH AF
  LD BC,TOKENIZE_LNUM
  PUSH BC
  CP $8C
  RET Z
  CP $A7
  RET Z
  CP $A8
  RET Z
  CP $A6
  RET Z
  CP $A3
  RET Z
  CP $A5
  RET Z
  CP $E5
  RET Z
  CP $9E
  RET Z
  CP $8A
  RET Z
  CP $93
  RET Z
  CP $9C
  RET Z

; TK_GOTO
L310E:
  CP $89
  RET Z
  CP $DE
  RET Z
  CP $8D
  RET Z
  POP AF

; Routine at 12568
TOKEN_BUILT:
  XOR A

; Data block at 12569
L3119:
  DEFB $C2

; Routine at 12570
TOKENIZE_LNUM:
  LD A,$01
; This entry point is used by the routine at KRNSAV.
NOTRS6:
  LD (DONUM),A
  POP AF
  POP BC
  POP DE
  CP $9E
  PUSH AF
  CALL Z,STUFFH_6
  POP AF
  CP $EA
  JP NZ,NTSNGT
  PUSH AF
  CALL STUFFH_6
  LD A,$8F
  CALL KRNSAV
  POP AF
  PUSH AF
  JP STUFFH_4

; Routine at 12604
;
; Used by the routine at TOKENIZE.
TSTNUM:
  LD A,(HL)
  CP $2E
  JR Z,NUMTRY
  CP $3A
  JP NC,SRCSPC
  CP $30
  JP C,SRCSPC

; Routine at 12619
;
; Used by the routine at TSTNUM.
NUMTRY:
  LD A,(DONUM)
  OR A
  LD A,(HL)
  POP BC
  POP DE
  JP M,STUFFH
  JR Z,FLTGET
  CP $2E
  JP Z,STUFFH
  LD A,$0E
  CALL KRNSAV
  PUSH DE
  CALL ATOH
  CALL BAKSP

; Routine at 12648
;
; Used by the routine at WUZOCT.
SAVINT:
  EX (SP),HL
  EX DE,HL
; This entry point is used by the routine at FLTGET.
SAVINT_0:
  LD A,L
  CALL KRNSAV
  LD A,H
; This entry point is used by the routine at FLTGET.
SAVINT_1:
  POP HL
  CALL KRNSAV
  JP TOKENIZE_0

; Routine at 12662
;
; Used by the routine at NUMTRY.
FLTGET:
  PUSH DE
  PUSH BC
  LD A,(HL)
  CALL FIN
  CALL BAKSP
  POP BC
  POP DE
  PUSH HL
  LD A,(VALTYP)
  CP $02
  JR NZ,NTINTG
  LD HL,(FACCU)
  LD A,H
  OR A
  LD A,$02
  JR NZ,NTINTG
  LD A,L
  LD H,L
  LD L,$0F
  CP $0A
  JR NC,SAVINT_0
  ADD A,$11
  JR SAVINT_1

; Routine at 12702
;
; Used by the routine at FLTGET.
NTINTG:
  PUSH AF
  RRCA
  ADD A,$1B
  CALL KRNSAV
  LD HL,FACCU
  CALL GETYPR
  JR C,NTINTG_0
  LD HL,FACLOW
NTINTG_0:
  POP AF
NTINTG_1:
  PUSH AF
  LD A,(HL)
  CALL KRNSAV
  POP AF
  INC HL
  DEC A
  JR NZ,NTINTG_1
  POP HL
  JP TOKENIZE_0

; Routine at 12735
;
; Used by the routine at TSTNUM.
SRCSPC:
  LD DE,WORDS_Z
SRCSPC_0:
  INC DE
  LD A,(DE)
  AND $7F
  JP Z,KRNSAV_4
  INC DE
  CP (HL)
  LD A,(DE)
  JR NZ,SRCSPC_0
  JP KRNSAV_5

; Routine at 12753
;
; Used by the routine at TOKENIZE_LNUM.
NTSNGT:
  CP $26
  JR NZ,STUFFH
  PUSH HL
  CALL CHRGTB
  POP HL
  CALL UCASE
  CP $48
  LD A,$0B
  JR NZ,WUZOCT
  LD A,$0C

; Routine at 12773
;
; Used by the routine at NTSNGT.
WUZOCT:
  CALL KRNSAV
  PUSH DE
  PUSH BC
  CALL OCTCNS
  POP BC
  JP SAVINT

; Routine at 12785
;
; Used by the routines at TOKENIZE, NUMTRY and NTSNGT.
STUFFH:
  INC HL
  PUSH AF
  CALL KRNSAV
  POP AF
  SUB $3A
  JR Z,STUFFH_0
  CP $4A
  JR NZ,STUFFH_1
  LD A,$01
STUFFH_0:
  LD (OPRTYP),A
  LD (DONUM),A
STUFFH_1:
  SUB $55
  JP NZ,TOKENIZE_0
  PUSH AF
STUFFH_2:
  LD A,(HL)
  OR A
  EX (SP),HL
  LD A,H
  POP HL
  JR Z,STUFFH_5
  CP (HL)
  JR Z,STUFFH
; This entry point is used by the routine at TOKENIZE.
STUFFH_3:
  PUSH AF
  LD A,(HL)
; This entry point is used by the routine at TOKENIZE_LNUM.
STUFFH_4:
  INC HL
  CALL KRNSAV
  JR STUFFH_2
; This entry point is used by the routine at TOKENIZE.
STUFFH_5:
  LD HL,$0140
  LD A,L
  SUB C
  LD C,A
  LD A,H
  SBC A,B
  LD B,A
  LD HL,BUFFER
  XOR A
  LD (DE),A
  INC DE
  LD (DE),A
  INC DE
  LD (DE),A
  RET
; This entry point is used by the routine at TOKENIZE_LNUM.
STUFFH_6:
  LD A,$3A

; Routine at 12852
;
; Used by the routines at ISVARS, TOKENIZE_LNUM, NUMTRY, SAVINT, NTINTG, WUZOCT
; and STUFFH.
KRNSAV:
  LD (DE),A
  INC DE
  DEC BC
  LD A,C
  OR B
  RET NZ
; This entry point is used by the routine at PINLIN.
KRNSAV_0:
  LD E,$17
  JP ERROR
; This entry point is used by the routines at TOKENIZE and ISVARS.
KRNSAV_1:
  POP HL
  DEC HL
  DEC A
  LD (DONUM),A
  POP BC
  POP DE
  CALL MAKUPL
KRNSAV_2:
  CALL KRNSAV
  INC HL
  CALL MAKUPL
  CALL ISLETTER_A
  JR NC,KRNSAV_2
  CP $3A
  JR NC,KRNSAV_3
  CP $30
  JR NC,KRNSAV_2
  CP $2E
  JR Z,KRNSAV_2
KRNSAV_3:
  JP TOKENIZE_0
; This entry point is used by the routine at SRCSPC.
KRNSAV_4:
  LD A,(HL)
  CP $20
  JR NC,KRNSAV_5
  CP $09
  JR Z,KRNSAV_5
  CP $0A
  JR Z,KRNSAV_5
  LD A,$20
; This entry point is used by the routine at SRCSPC.
KRNSAV_5:
  PUSH AF
  LD A,(DONUM)
  INC A
  JR Z,KRNSAV_6
  DEC A
KRNSAV_6:
  JP NOTRS6

; BACK UP THE STACK POINTER
;
; Used by the routines at GETCMD, NUMTRY and FLTGET.
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

; Routine at 12943
__FOR:
  LD A,$64                ; Flag "FOR" assignment
  LD (SUBFLG),A           ; Save "FOR" flag             DONT RECOGNIZE SUBSCRIPTED VARIABLES
  CALL GETVAR             ;                             GET POINTER TO LOOP VARIABLE
  CALL SYNCHR
  DEFB TK_EQUAL           ; Token code for '='          SKIP OVER ASSIGNMENT "="
  PUSH DE                 ;SAVE THE VARIABLE POINTER
  EX DE,HL
  LD (TEMP),HL            ;SAVE THE LOOP VARIABLE IN TEMP FOR USE LATER ON
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
  CALL __DATA             ; Get next statement address           SET [H,L]=END OF STATEMENT
  LD (ENDFOR),HL          ; Next address of FOR st.              SAVE FOR COMPARISON
  LD HL,$0002             ; Offset for "FOR" block               SET UP POINTER INTO STACK
  ADD HL,SP               ; Point to it
FORSLP:
  CALL LOKFOR             ; Look for existing "FOR" block        MUST HAVE VARIABLE POINTER IN [D,E]
  POP DE                  ; (***)
  JR NZ,FORFND
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
  JR NZ,FORSLP            ; Different FORs - Find another        KEEP SEARCHING IF NO MATCH
  POP DE                  ; Restore code string address          GET BACK THE TEXT POINTER
  LD SP,HL                ; Remove all nested loops              DO THE ELIMINATION
  LD (SAVSTK),HL          ; UPDATE SAVED STACK SINCE A MATCHING ENTRY WAS FOUND

;;;  DEFB $0E                ; (***) LD C,N to mask the next byte

; Routine at 13023
;
; Used by the routine at L329B.
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

; Routine at 13082
;
; Used by the routine at L32F3.
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
; This entry point is used by the routine at L32F3.
FORFND_0:
  POP HL                  ; Restore code string address

; Save the STEP value in block
;
; Routine at 13117
;
; Used by the routine at FORFND_SNG.
SAVSTP:
  PUSH BC                 ; Save the STEP value in block         PUT VALUE ON BACKWARDS
  PUSH DE                 ;OPPOSITE OF PUSHR
;;  OR A
;;  JR NZ,SAVSTP_0         ; (***)
;;  LD A,$02
;;SAVSTP_0:
  LD C,A                  ;[C]=SIGN OF STEP
  CALL GETYPR             ;MUST PUT ON INTEGER/SINGLE-PRECISION FLAG - MINUS IS SET FOR INTEGER CASE
  LD B,A                  ;HIGH BYTE = INTEGER/SINGLE PRECISION FLAG
  PUSH BC                 ;SAVE FLAG AND SIGN OF STEP BOTH
  DEC HL                  ;MAKE SURE THE "FOR" ENDED PROPERLY
  CALL CHRGTB
  JP NZ,SN_ERR
  CALL NXTSCN_0
  CALL CHRGTB
  PUSH HL
  PUSH HL
  LD HL,(NXTLIN)
  LD (CURLIN),HL
  LD HL,(TEMP)
  EX (SP),HL
  LD B,$82
  PUSH BC
  INC SP
  PUSH AF
  PUSH AF
  JP $6AD4

; LD B,TK_FOR
;
; Used by the routine at __NEXT.
PUTFID:
  LD B,$82
  PUSH BC
  INC SP

; Routine at 13163
;
; Used by the routines at __POP, __NEXT, __WEND, FLSWHL, CALLRT, CDVARS and
; BINLOD.
NEWSTT:
  PUSH HL

; CALL..
L336C:
  DEFB $CD

; Data block at 13165
SMC_ISCNTC:
  DEFW $0000

; Routine at 13167
NEWSTT_0:
  POP HL
  OR A
  CALL NZ,STALL
  LD (SAVTXT),HL
  LD (SAVSTK),SP
  LD A,(HL)
  CP $3A
  JR Z,EXEC
  OR A
  JP NZ,SN_ERR
  INC HL
; This entry point is used by the routine at ERRMOR.
GONE4:
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,PRG_END
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (CURLIN),HL
  LD A,(TRCFLG)
  OR A
  JR Z,NO_TRACE
  PUSH DE
  LD A,$5B
  CALL OUTDO
  CALL LINPRT
  LD A,$5D
  CALL OUTDO
  POP DE
NO_TRACE:
  EX DE,HL
; This entry point is used by the routine at DIRDO.
EXEC:
  CALL CHRGTB
  LD DE,NEWSTT
  PUSH DE
  RET Z
; This entry point is used by the routines at L367D and L3715.
ONJMP:
  SUB $81
  JP C,__LET
  CP $5B
  JP NC,ISMID
  RLCA
  LD C,A
  LD B,$00
  EX DE,HL
  LD HL,FNCTAB
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  EX DE,HL

; Pick next char from program
;
; Used by the routines at GETCMD, EDENT, CHEAD, LNUM_RANGE, NTSNGT, SAVSTP,
; NEWSTT_0, __CHRCKB, DEFCON, INTIDX, ATOH, __REM, __ON, RESNXT, __IF, L3715,
; __PRINT, __TAB, NEXITM, __INPUT, NOTQTI, SCNVAL, INPBIN, LTSTND, FDTLP,
; LOPREL, OPRND, __ERR, __ERL, __VARPTR, OCTCNS, ISFUN, SCNUSR, __DEF, DOFN,
; FINASG, L3F72, __WIDTH, FPSINT, FNDNUM, CONINT, NUMLIN, SCNEXT, _LINE2PTR,
; L4423, SCNCNT, DECNXT, FN_SCRN, FN_COLOR, L4796, L47A8, FN_HCOLOR, FN_HSCRN,
; __HPLOT, H_ASCTFP, FINEC, DPOINT, FOUTZS, FOUTTS, SUMLP, DIMRET, PTRGET,
; DOCHRT, NOTSCI, FN_INKEY, __ERASE, __CLEAR, L6A5D, L6A82, __NEXT, DTSTR,
; FN_STRING, __VAL, FN_INSTR, PINLIN, __WHILE, __CALL, GETPAR, __CHAIN, L72E5,
; L7317, CHAIN_COMMON, BCKUCM, __WRITE, L75C6, FILSCN, LINE_INPUT, __LOAD,
; __MERGE, __SAVE, __CLOSE, FN_INPUT, L79F2, L7D22, VARECS, __GET, ENDCMD,
; WASM, L8316 and WASS.
;
; NEWSTT FALLS INTO CHRGET. THIS FETCHES THE FIRST CHAR AFTER
; THE STATEMENT TOKEN AND THE CHRGET'S "RET" DISPATCHES TO STATEMENT
;
CHRGTB:
  INC HL

; Pick current char (or token) on program
;
; Used by the routines at CHEAD, SRCHLP, __CALL_6502 and __HPLOT.
__CHRCKB:
  LD A,(HL)               ; Get next code string byte      ;SEE CHRGET RST FOR EXPLANATION
  CP '9'+1
  RET NC                  ; NC if > "9"
; This entry point is used by the routine at SYNCHR.

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

; This entry point is used by the routines at CONFAC and CONFDB.
__CHRCKB_2:
  LD HL,(CONTXT)
  JR __CHRCKB

NTRSC2:
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

; Routine at 13381
;
; Used by the routines at OPRND and NUMLIN.
CONFAC:
  LD A,(CONSAV)            ;GET CONSTANT TOKEN
  CP LINCON+1              ;LINE# CONSTANT? (ERL=#)
  JR NC,NTLINE             ;NO
  CP PTRCON                ;LINE POINTER CONSTANT?
  JR C,NTLINE              ;NO
  LD HL,(CONLO)            ;GET VALUE
  JR NZ,FLTLIN             ;MUST BE LINE NUMBER, NOT POINTER
  INC HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
FLTLIN:
  CALL INEG2
  JP __CHRCKB_2

; Routine at 13410
;
; Used by the routine at CONFAC.
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
  JP __CHRCKB_2

; Routine at 13435
;
; Used by the routine at NTLINE.
CONFDB:
  LD HL,CONLO
  CALL VMOVFM
  JP __CHRCKB_2

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


; Routine at 13455
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

; Routine at 13513
;
; Used by the routines at SBSCPT, SHTNAM, VARECS and __GET.
INTIDX:
  CALL CHRGTB
; This entry point is used by the routines at __CLEAR and L6A82.
INTIDX_0:
  CALL FPSINT_0          ;READ A FORMULA AND GET THE RESULT AS AN INTEGER IN [D,E]
                         ;ALSO SET THE CONDITION CODES BASED ON THE HIGH ORDER OF THE RESULT
  RET P                  ;DON'T ALLOW NEGATIVE NUMBERS

; This entry point is used by the routines at SRCHLP, __ERROR, L36E3, L3C68,
; LPSIZL, CONINT, __DELETE, L4305, GET_POSINT, L4646, __PDL, SET_HCOLOR, __HGR,
; __LOG, L6462, NOTSCI, L69DC, __ERASE, L6A5D, __ASC, __MID_S, FN_INSTR, L6F94,
; L7317, CHAIN_COMMON, SCNSMP, __CVD, L7A0F, L7CCF, VARECS, __GET, PROCHK and
; L8316.
FC_ERR:
  LD E,$05
  JP ERROR

; This entry point is used by the routines at LNUM_RANGE, __AUTO, __RENUM,
; L42FB and __EDIT.
LNUM_PARM:
  LD A,(HL)
  CP $2E
  EX DE,HL
  LD HL,(DOT)
  EX DE,HL
  JP Z,CHRGTB

; ASCII number to DE binary
;
; Used by the routines at GETCMD, NUMTRY, __GOSUB, __GOTO, L364D, __RESUME,
; L36E3, UCASE, L4305, __RESTORE and PINLIN.
ATOH:
  DEC HL
; This entry point is used by the routine at L367D.
ATOH_0:
  CALL CHRGTB
  CP $0E
  JP Z,LINGT3
  CP $0D
; This entry point is used by the routines at _LINE2PTR and SCNPT2.
LINGT3:
  EX DE,HL
  LD HL,(CONLO)
  EX DE,HL
  JP Z,CHRGTB
  DEC HL
  LD DE,$0000
ATOH_2:
  CALL CHRGTB
  RET NC
  PUSH HL
  PUSH AF
  LD HL,$1998
  CALL DCOMPR
  JR C,ATOH_3
  LD H,D
  LD L,E
  ADD HL,DE
  ADD HL,HL
  ADD HL,DE
  ADD HL,HL
  POP AF
  SUB $30
  LD E,A
  LD D,$00
  ADD HL,DE
  EX DE,HL
  POP HL
  JR ATOH_2
ATOH_3:
  POP AF
  POP HL
  RET

; Routine at 13593
__RUN:
  JP Z,RUN_FST
  CP $0E
  JR Z,__RUN_0
  CP $0D
  JP NZ,LRUN
__RUN_0:
  CALL CLEARC
  LD BC,NEWSTT
  JR GO_TO

; Routine at 13613
__GOSUB:
  LD C,$03
  CALL CHKSTK
  CALL ATOH
  POP BC
  PUSH HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  LD A,$8D
  PUSH AF
  INC SP
  PUSH BC
  JP __GOTO_0

; Go To..
;
; Used by the routine at __RUN.
GO_TO:
  PUSH BC

; Routine at 13637
;
; Used by the routine at L3715.
__GOTO:
  CALL ATOH
; This entry point is used by the routines at __GOSUB and __RESUME.
__GOTO_0:
  LD A,(CONSAV)
  CP $0D
  EX DE,HL
  RET Z
  EX DE,HL
  PUSH HL
  LD HL,(CONTXT)
  EX (SP),HL
  CALL __REM
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  CALL DCOMPR
  POP HL
  CALL C,SRCHLP
  CALL NC,SRCHLN
  JR NC,UL_ERR
  DEC BC
  LD A,$0D
  LD (PTRFLG),A
  POP HL
  CALL CONCH2
  LD H,B
  LD L,C
  RET

; entry for '?UL ERROR'
;
; Used by the routines at EDENT, __GOTO, L364D, __EDIT, __RESTORE and CDVARS.
UL_ERR:
  LD E,$08
  JP ERROR

; Routine at 13691
__POP:
  LD (TEMP),HL
  LD D,$FF
  CALL BAKSTK
  LD SP,HL
  LD (SAVSTK),HL
  CP $8D
  JR NZ,__RETURN_0
  LD HL,$0004
  ADD HL,SP
  LD (SAVSTK),HL
  LD SP,HL
  LD HL,(TEMP)
  JP NEWSTT

; Routine at 13721
__RETURN:
  RET NZ
  LD D,$FF
  CALL BAKSTK
  LD SP,HL
  LD (SAVSTK),HL
  CP $8D
; This entry point is used by the routine at __POP.
__RETURN_0:
  LD E,$03
  JP NZ,ERROR
  POP HL
  LD (CURLIN),HL
  LD HL,NEWSTT
  EX (SP),HL

; Data block at 13746
L35B2:
  DEFB $3E

; Routine at 13747
NXTDTA:
  POP HL

; Message at 13748
__DATA:
  DEFB $01
  DEFM ":"

; Routine at 13750
;
; Used by the routines at ERRMOR and __GOTO.
__REM:
  LD C,$00
  LD B,$00
NXTSTL:
  LD A,C
  LD C,B
  LD B,A
__REM_0:
  DEC HL
__REM_1:
  CALL CHRGTB
  OR A
  RET Z
  CP B
  RET Z
  INC HL
  CP $22
  JR Z,NXTSTL
  INC A
  JR Z,__REM_1
  SUB $8C
  JR NZ,__REM_0
  CP B
  ADC A,D
  LD D,A
  JR __REM_0

; Routine at 13782
LETCON:
  POP AF                  ;GET VALTYPE OFF STACK
  ADD A,$03               ;MAKE VALTYPE CORRECT
  JR __LET_0              ;CONTINUE

; Routine at 13787
;
; Used by the routine at NEWSTT_0.
__LET:
  CALL GETVAR             ;GET THE POINTER TO THE VARIABLE NAMED IN TEXT AND PUT IT INTO [D,E]
  CALL SYNCHR
  DEFB TK_EQUAL           ;CHECK FOR "="
  EX DE,HL
  LD (TEMP),HL            ;MUST SET UP TEMP FOR "FOR"
  EX DE,HL                ;UP HERE SO WHEN USER-FUNCTIONS
                          ;CALL REDINP, TEMP DOESN'T GET CHANGED
  PUSH DE
  LD A,(VALTYP)           ; Get data type
  PUSH AF                 ; save type         ;CALL REDINP, TEMP DOESN'T GET CHANGED
  CALL EVAL                                   ;GET THE VALUE OF THE FORMULA
  POP AF                  ; Restore type      ;GET THE VALTYP OF THE VARIABLE INTO [A] INTO FAC
  
; This entry point is used by the routines at LETCON and L388F.
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
; This entry point is used by the routine at LPSIZL.
LETCN4:
  LD A,(VALTYP)
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

; "LD A,n" to Mask the next byte
L362F:
  DEFB $3E

; Routine at 13872
;
; Used by the routine at L35E2.
CRESTR:
  POP DE
  CALL GSTRDE_1
  EX DE,HL
  CALL STRCPY
; This entry point is used by the routine at L35E2.
DNTCPY:
  CALL GSTRDE_1
  EX (SP),HL
; This entry point is used by the routine at L35E2.
LETNUM:
  CALL VMOVE
  POP DE
  POP HL
  RET

; Routine at 13890
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
  EX DE,HL
  LD (ONELIN),HL          ;SAVE POINTER TO LINE OR ZERO IF 0.
  EX DE,HL
  RET C                   ;YOU WOULDN'T BELIEVE IT IF I TOLD YOU
  LD A,(ONEFLG)           ;ARE WE IN AN "ON...ERROR" ROUTINE?
  OR A                    ;SET CONDITION CODES
  LD A,E                  ;WANT AN EVEN STACK PTR. FOR 8086
  RET Z                   ;IF NOT, HAVE ALREADY DISABLED TRAPPING.
  LD A,(ERRFLG)           ;GET ERROR CODE
  LD E,A                  ;INTO E.
  JP ERRESM               ;FORCE THE ERROR TO HAPPEN

; Not 'ON ERROR'
; This entry point is used by the routine at __ON.
NTOERR:
  CALL GETINT             ; Get integer 0-255                  ;GET VALUE INTO [E]
  LD A,(HL)               ; Get "GOTO" or "GOSUB" token        ;GET THE TERMINATOR BACK
  LD B,A                  ; Save in B                          ;SAVE THIS CHARACTER FOR LATER
  CP TK_GOSUB             ; "GOSUB" token?                     ;AN "ON ... GOSUB" PERHAPS?
  JR Z,ONGO               ; Yes - Find line number             ;YES, SOME FEATURE USE
  CALL SYNCHR             ; Make sure it's "GOTO"
  DEFB TK_GOTO            ; "GOTO" token                       ;OTHERWISE MUST BE "GOTO"
  DEC HL                  ; Cancel increment                   ;BACK UP CHARACTER POINTER
; This entry point is used by the routine at L364D.
ONGO:
  LD C,E
ONGOLP:
  DEC C
  LD A,B
  JP Z,ONJMP
  CALL ATOH_0
  CP ','
  RET NZ
  JR ONGOLP

; Routine at 13964
__RESUME:
  LD DE,ONEFLG
  LD A,(DE)
  OR A
  JP Z,RW_ERR
  INC A
  LD (ERRFLG),A
  LD (DE),A
  LD A,(HL)
  CP $83
  JR Z,RESNXT
  CALL ATOH
  RET NZ
  LD A,D
  OR E
  JP NZ,__GOTO_0
  INC A
  JR RESTXT

; Routine at 13994
;
; Used by the routine at __RESUME.
RESNXT:
  CALL CHRGTB
  RET NZ

; Routine at 13998
;
; Used by the routine at __RESUME.
RESTXT:
  LD HL,(ERRTXT)
  EX DE,HL
  LD HL,(ERRLIN)
  LD (CURLIN),HL
  EX DE,HL
  RET NZ
  LD A,(HL)
  OR A
  JR NZ,RESTXT_0
  INC HL
  INC HL
  INC HL
  INC HL
RESTXT_0:
  INC HL
  JP __DATA

; Routine at 14022
__ERROR:
  CALL GETINT
  RET NZ
  OR A
  JP Z,FC_ERR
  JP ERROR

; Routine at 14033
__AUTO:
  LD DE,$000A
  PUSH DE
  JR Z,L36E3_0
  CALL LNUM_PARM
  EX DE,HL
  EX (SP),HL
  JR Z,L36E3_1
  EX DE,HL
  CALL SYNCHR

; Message at 14050
L36E2:
  DEFM ","

; Routine at 14051
L36E3:
  EX DE,HL
  LD HL,(AUTINC)
  EX DE,HL
  JR Z,L36E3_0
  CALL ATOH
  JP NZ,SN_ERR
; This entry point is used by the routine at __AUTO.
L36E3_0:
  EX DE,HL
; This entry point is used by the routine at __AUTO.
L36E3_1:
  LD A,H
  OR L
  JP Z,FC_ERR
  LD (AUTINC),HL
  LD (AUTFLG),A
  POP HL
  LD (AUTLIN),HL
  POP BC
  JP PROMPT

; Routine at 14084
__IF:
  CALL EVAL
  LD A,(HL)
  CP ','
  CALL Z,CHRGTB
  CP $89
  JR Z,L3715_0
  CALL SYNCHR

; Message at 14100
L3714:
  DEFB $DE

; Routine at 14101
L3715:
  DEC HL
; This entry point is used by the routine at __IF.
L3715_0:
  PUSH HL
  CALL VSIGN
  POP HL
  JR Z,L3715_2
L3715_1:
  CALL CHRGTB
  RET Z
  CP $0E
  JP Z,__GOTO
  CP $0D
  JP NZ,ONJMP
  LD HL,(CONLO)
  RET
L3715_2:
  LD D,$01
L3715_3:
  CALL __DATA
  OR A
  RET Z
  CALL CHRGTB
  CP $9E
  JR NZ,L3715_3
  DEC D
  JR NZ,L3715_3
  JR L3715_1

; Routine at 14146
__LPRINT:
  LD A,$01
  LD (PRTFLG),A
  JP MRPRNT

; Routine at 14154
__PRINT:
  LD C,$02
  CALL FILGET
; This entry point is used by the routine at __LPRINT.
MRPRNT:
  DEC HL
  CALL CHRGTB
  CALL Z,OUTDO_CRLF
; This entry point is used by the routine at NEXITM.
PRNTLP:
  JP Z,FINPRT
  CP $E8
  JP Z,__USING
  CP $DF
  JP Z,__TAB
  CP $E3
  JP Z,__TAB
  PUSH HL
  CP ','
  JR Z,DOCOM
  CP $3B
  JP Z,NEXITM
  POP BC
  CALL EVAL
  PUSH HL
  CALL GETYPR
  JR Z,PRNTST
  CALL FOUT
  CALL CRTST
  LD (HL),$20
  LD HL,(FACCU)
  INC (HL)
PRNTST:
  LD HL,(PTRFIL)
  LD A,H
  OR L
  JR NZ,LINCH2
  LD HL,(FACCU)
  LD A,(PRTFLG)
  OR A
  JR Z,ISTTY
  LD A,(LPTSIZ)
  LD B,A
  INC A
  JP Z,LINCH2
  LD A,(LPTPOS)
  OR A
  JP Z,LINCH2
  ADD A,(HL)
  CCF
  JR NC,PRNTNB
  CP B
  JR PRNTNB
ISTTY:
  LD A,(LINLEN)
  LD B,A
  INC A
  JR Z,LINCH2
  LD A,(TTYPOS)
  OR A
  JR Z,LINCH2
  ADD A,(HL)
  CCF
  JR NC,PRNTNB
  DEC A
  CP B
PRNTNB:
  CALL NC,OUTDO_CRLF
LINCH2:
  CALL PRS1
  POP HL
  JP MRPRNT
DOCOM:
  LD HL,(PTRFIL)
  LD A,H
  OR L
  LD BC,$0028
  ADD HL,BC
  LD A,(HL)
  JR NZ,ZONELP
  LD A,(PRTFLG)
  OR A
  JR Z,ISCTTY
  LD A,(COMMAN)
  LD B,A
  INC A
  LD A,(LPTPOS)
  JR Z,ZONELP
  CP B
  JP CHKCOM
ISCTTY:
  LD A,(NCMPOS)
  LD B,A
  LD A,(TTYPOS)
  CP $FF
  JR Z,ZONELP
  CP B
CHKCOM:
  CALL NC,OUTDO_CRLF
  JP NC,NEXITM
ZONELP:
  SUB $0E
  JR NC,ZONELP
  CPL
  JP ASPCS

; PRINT TAB(
;
; Used by the routine at __PRINT.
__TAB:
  PUSH AF
  CALL CHRGTB
  CALL FPSINT_0
  POP AF
  PUSH AF
  CP $E3
  JR Z,__SPC
  DEC DE

; Routine at 14355
;
; Used by the routine at __TAB.
__SPC:
  LD A,D
  OR A
  JP P,__SPC_0
  LD DE,$0000
__SPC_0:
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  JR NZ,LNOMOD
  LD A,(PRTFLG)
  OR A
  LD A,(LPTSIZ)
  JR NZ,LPTMDF
  LD A,(LINLEN)

; Routine at 14383
;
; Used by the routine at __SPC.
LPTMDF:
  LD L,A
  INC A
  JR Z,LNOMOD
  LD H,$00
  CALL INEG_2
  EX DE,HL

; Routine at 14393
;
; Used by the routines at __SPC and LPTMDF.
LNOMOD:
  POP HL
  CALL SYNCHR

; Message at 14397
L383D:
  DEFM ")"

; Routine at 14398
L383E:
  DEC HL
  POP AF
  SUB $E3
  PUSH HL
  JR Z,DOSPC
  LD HL,(PTRFIL)
  LD A,H
  OR L
  LD BC,$0028
  ADD HL,BC
  LD A,(HL)
  JR NZ,DOSPC
  LD A,(PRTFLG)
  OR A
  JP Z,TTYIST
  LD A,(LPTPOS)
  JR DOSPC

; Routine at 14429
;
; Used by the routine at L383E.
TTYIST:
  LD A,(TTYPOS)

; Routine at 14432
;
; Used by the routine at L383E.
DOSPC:
  CPL
  ADD A,E
  JR C,ASPCS
  INC A
  JR Z,NEXITM
  CALL OUTDO_CRLF
  LD A,E
  DEC A
  JP M,NEXITM

; Routine at 14447
;
; Used by the routines at __PRINT and DOSPC.
ASPCS:
  INC A
  LD B,A
  LD A,$20

; Routine at 14451
SPCLP:
  CALL OUTDO
  DJNZ SPCLP

; Routine at 14456
;
; Used by the routines at __PRINT and DOSPC.
NEXITM:
  POP HL
  CALL CHRGTB
  JP PRNTLP

; Routine at 14463
;
; Used by the routines at __PRINT, LTSTND, REUSIN, STKINI, NTRNDW, LOAD_END,
; PUTCHR and FIVDPT.
FINPRT:
  XOR A
  LD (PRTFLG),A
  PUSH HL
  LD H,A
  LD L,A
  LD (PTRFIL),HL
  POP HL
  RET

; Routine at 14475
__LINE:
  CALL SYNCHR

; Message at 14478
L388E:
  DEFB $85

; Routine at 14479
L388F:
  CP $23
  JP Z,LINE_INPUT
  CALL PINLIN_17
  CALL __INPUT_0
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  PUSH HL
  CALL INLIN
  POP DE
  POP BC
  JP C,INPBRK
  PUSH BC                 ;SAVE BACK VARIABLE POINTER
  PUSH DE                 ;SAVE TEXT POINTER
  LD B,$00                ;SETUP ZERO AS ONLY TERMINATOR
  CALL QTSTR_0            ;LITERALIZE THE INPUT
  POP HL                  ;RESTORE [H,L]=TEXT POINTER
  LD A,$03                ;SET THREE FOR STRING
  JP __LET_0              ;DO THE ASSIGNMENT

; Message at 14519
REDO_MSG:
  DEFM "?Redo from start"
  DEFB $0D
  DEFB $0A
  DEFB $00

; Routine at 14538
;
; Used by the routine at NOTQTI.
SCNSTR:
  INC HL
  LD A,(HL)
  OR A
  JP Z,SN_ERR
  CP $22
  JR NZ,SCNSTR
  JP SCNCON

; Routine at 14551
;
; Used by the routine at NOTQTI.
INPBAK:
  POP HL
  POP HL
  JP RDOIN2

; Routine at 14556
;
; Used by the routine at LTSTND.
TRMNOK:
  LD A,(FLGINP)
  OR A
  JP NZ,DATSNR

; Routine at 14563
;
; Used by the routines at INPBAK and NOTQTI.
RDOIN2:
  POP BC
  LD HL,REDO_MSG
  CALL PRS
  LD HL,(SAVTXT)
  RET

; Routine at 14574
;
; Used by the routine at __INPUT.
FILSTI:
  CALL FILINP
  PUSH HL
  LD HL,BUFMIN
  JP INPUT_CHANNEL

; Routine at 14584
__INPUT:
  CP $23
  JP Z,FILSTI
  CALL PINLIN_17
  LD BC,NOTQTI
  PUSH BC
; This entry point is used by the routine at L388F.
__INPUT_0:
  CP $22
  LD A,$00
  LD (CTLOFG),A
  LD A,$FF
  LD (IMPFLG),A
  RET NZ
  CALL QTSTR
  LD A,(HL)
  CP ','
  JR NZ,__INPUT_1
  XOR A
  LD (IMPFLG),A
  CALL CHRGTB
  JR __INPUT_2
__INPUT_1:
  CALL SYNCHR

; Message at 14629
L3925:
  DEFM ";"

; Routine at 14630
;
; Used by the routine at __INPUT.
__INPUT_2:
  PUSH HL
  CALL PRS1
  POP HL
  RET

; Routine at 14636
NOTQTI:
  PUSH HL
  LD A,(IMPFLG)
  OR A
  JR Z,SUPPRS             ;THEN SUPPRESS "?"
  LD A,'?'                  ;TYPE "?" AND INPUT A LINE OF TEXT    ; Get input with "? " prompt
  CALL OUTDO                ; Output character
  LD A,' '                  ; Space
  CALL OUTDO                ; Output character
SUPPRS:
  CALL INLIN
  POP BC
  JP C,INPBRK
  PUSH BC                   ; Re-save code string address      ;PUT BACK SINCE DIDN'T LEAVE

;
; THIS IS THE FIRST PASS DICTATED BY ANSI REQUIRMENT THAN NO VALUES BE ASSIGNED 
; BEFORE CHECKING TYPE AND NUMBER. THE VARIABLE LIST IS SCANNED WITHOUT EVALUATING
; SUBSCRIPTS AND THE INPUT IS SCANNED TO GET ITS TYPE. NO ASSIGNMENT IS DONE
;
;;  XOR A                    ;(***)
;;  LD (FLGINP),A
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
  CALL GETVAR               ;SCAN NAME AND RETURN POINTER IN [D,E]
  LD A,(HL)                 ;SEE IF IT ENDED ON "("
  DEC HL                    ;RESCAN THE TERMINATOR
;;  CP '['                   ;(***)
;;  JR Z,HAVE_ARRAY
  CP '('                    ;ARRAY OR NOT?
  JR NZ,ENDSCN              ;IF NOT, VARIABLE NAME IS DONE
;;HAVE_ARRAY:                ; (***)
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
;;  CP '['                  ;(***)
;;  JR Z,SCNCON
;;  CP ']'
;;  JR Z,SQ_PAREN
  CP '('                    ;ANOTHER LEVEL OF NESTING?
  JR Z,SCNOPN               ;INCREMENT COUTN AND KEEP SCANNING
  CP ')'                    ;ONE LESS LEVEL OF PARENS?
  JR NZ,SCNCON              ;NO, KEEP SCANNING
  DJNZ SCNCON               ;IF NOT AT ZERO LEVEL, KEEP SCANNING
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

; Routine at 14771
;
; Used by the routine at FILSTI.
INPUT_CHANNEL:
  LD (HL),','               ;SETUP COMMA AT BUFMIN
  JR INPCON


; 'READ' BASIC command
; Routine at 14775
__READ:
  PUSH HL                 ; Save code string address      ;SAVE THE TEXT POINTER
  LD HL,(DATPTR)          ; Next DATA statement           ;GET LAST DATA LOCATION

  DEFB $F6                ; OR AFh ..Flag "READ"          ;"ORI" TO SET [A] NON-ZERO

; Routine at 14780
;
; Used by the routine at INPUT_CHANNEL.
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

; Routine at 14791
;
; Used by the routine at INPCON.
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
  JP NZ,FDTLP             ; Yes - Find next DATA stmt     ;SEARCH FOR ANOTHER DATA STATEMENT

;THE DATA NOW STARTS AT THE BEGINNING OF THE BUFFER
;AND QINLIN LEAVES [H,L]=BUF

; a.k.a. DATBK
ANTVLU:
  DEFB $F6                ; OR AFh ..hides the "XOR A" instruction    ;SET A NON-ZERO

; Routine at 14809
;
; Used by the routine at NOTQTI.
SCNVAL:
  XOR A                   ; SET ZERO FLAG IN [A]
  LD (READFLG),A          ; STORE SO EARLY RETURN CHECK WORKS
  EX DE,HL                ; SEE IF A FILE READ   (*** CALL ISFLIO)
  LD HL,(PTRFIL)
  LD A,H
  OR L
  EX DE,HL
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


; Routine at 14850
; a.k.a. NOWGET
;
; Used by the routine at SCNVAL.
STRENT:
  CALL DTSTR

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

; Routine at 14872
;
; Used by the routine at SCNVAL.
INPBIN:
  CALL CHRGTB             ; Get next character
  POP AF                  ; GET BACK VALTYPE OF SOURCE
  PUSH AF                 ; SAVE BACK
;;  LD BC,$3A05
  LD BC,DOASIG            ; ASSIGNMENT IS COMPLICATED EVEN FOR NUMERICS SO USE THE "LET" CODE
  PUSH BC                 ; SAVE ON STACK
  JP C,FIN                ; IF NOT DOUBLE, CALL USUAL # INPUTTER
  JP FIN_DBL              ; ELSE CALL SPECIAL ROUTINE WHICH EXPECTS DOUBLES

; Routine at 14887
LTSTND:
  DEC HL
  CALL CHRGTB
  JR Z,MORDT
  CP ','                  ; Another value?
  JP NZ,TRMNOK            ; No - Bad input           ;ENDED PROPERLY?

MORDT:
  EX (SP),HL              ; Get code string address
  DEC HL                  ; DEC 'cos GETCHR INCs     ;LOOK AT TERMINATOR
  CALL CHRGTB             ; Get next character       ;AND SET UP CONDITION CODES
  JP NZ,LOPDT2            ; More needed - Get it     ;NOT ENDING, CHECK FOR COMMA AND GET
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
  EX DE,HL
  LD (DATLIN),HL
  EX DE,HL
FANDT:
  CALL CHRGTB             ; Get next character               ;GET THE STATEMENT TYPE
  CP TK_DATA              ; "DATA" token                     ;IS IS "DATA"?
  JR NZ,FDTLP             ; No "DATA" - Keep looking         ;NOT DATA SO LOOK SOME MORE
  JP ANTVLU               ; Found - Convert input            ;CONTINUE READING

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

; Routine at 14954
;
; Used by the routines at L3F72, L6F94 and __LSET.
FRMEQL:
  CALL SYNCHR
  DEFB TK_EQUAL       ; Token code for '='       ;CHECK FOR EQUAL SIGN
  JP EVAL                                            ;EVALUATE FORMULA AND RETURN

; Routine at 14961
;
; Used by the routines at EVLPAR, ISFUN and FN_INSTR.
OPNPAR:
  CALL SYNCHR         ; Make sure "(" follows
  DEFM "("            ;GET PAREN BEFORE FORMULA

; Routine at 14965
;
; Used by the routines at SRCHLP, L329B, L32F3, L35E2, __IF, __PRINT, L3A6E,
; ASGMOR, FPSINT_0, GETINT, __POKE, __RANDOMIZE, NOTSCI, ISSTRF, L6A5D, L6E22,
; L6EF1, L6EFB, __WEND, L72E5, __WRITE, FILSCN, FNAME and __OPEN.
EVAL:
  DEC HL              ; Evaluate expression & save          ;BACK UP CHARACTER POINTER

; This entry point is used by the routines at FORFND_SNG and __USING.
EVAL_0:
  LD D,$00            ; Precedence value                    ;INITIAL DUMMY PRECEDENCE IS 0

; This entry point is used by the routines at EVAL_MORE, MINUS and __NOT.
EVAL_1:
  PUSH DE             ; Save precedence                     ;SAVE PRECEDENCE
  LD C,$01            ; Check for 1 level of stack          ;EXTRA SPACE NEEDED FOR RETURN ADDRESS
  CALL CHKSTK                                               ;MAKE SURE THERE IS ROOM FOR RECURSIVE CALLS
  CALL OPRND          ; Get next expression value           ;EVALUATE SOMETHING
  XOR A               ; RESET OVERFLOW PRINTING BACK TO NORMAL (SET TO 1 AT FUNDSP TO SUPPRESS
  LD (FLGOVC),A       ;                                               MULTIPLE OVERFLOW MESSAGES)

; Routine at 14981
; Evaluate expression until precedence break
EVAL2:
  LD (NXTOPR),HL      ; Save address of next operator

; This entry point is used by the routine at __NOT.
EVAL3:
  LD HL,(NXTOPR)      ; Restore address of next opr

  POP BC              ; Precedence value and operator       ;POP OFF THE PRECEDENCE OF OLDOP
  LD A,(HL)           ; Get next operator / function        ;GET NEXT CHARACTER
  LD (TEMP3),HL                                             ;SAVE UPDATED CHARACTER POINTER
  CP TK_GREATER       ; Token code for '>' (lower opr code) ;IS IT AN OPERATOR?
  RET C               ; NO, ALL DONE (THIS CAN RESULT IN OPERATOR APPLICATION OR ACTUAL RETURN)
  CP TK_MINOR+1       ; '<' +1  (higher opr code)           ;SOME KIND OF RELATIONAL?
  JP C,DORELS                                               ;YES, DO IT
  SUB TK_PLUS         ; Token code for '+'                  ;SUBTRAXDCT OFFSET FOR FIRST ARITHMETIC
  LD E,A              ; Coded operator                      ;MUST MULTIPLY BY 3 SINCE OPTAB ENTRIES ARE 3 LONG
  JR NZ,FOPRND        ; Function - Call it                  ;NOT ADDITION OP

  LD A,(VALTYP)       ; Get data type                       ;SEE IF LEFT PART IS STRING
  CP $03              ; String ?                            ;SEE IF ITS A STRING
  LD A,E              ; Coded operator                      ;REFETCH OP-VALUE
  JP Z,CONCAT         ; If so, string concatenation (use '+' to join strings)      ;MUST BE CAT

; Routine at 15014
;
; Used by the routine at EVAL3.
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
  JP Z,EVAL_EXPONENT                                        ;IF SO, "FRCSNG" AND MAKE A SPECIAL STACK ENTRY
  CP $51                                                       ;SEE IF THE OPERATOR IS "AND" OR "OR"
  JP C,EVAL_BOOL      ; one less than AND as mapped in PRITAB  ;AND IF SO "FRCINT" AND MAKE A SPECIAL STACK ENTRY
  AND $FE                                                      ;MAKE 123 AND 122 BOTH MAP TO 122
  CP $7A              ; MOD as mapped in PRITAB                ;MAKE A SPECIAL CHECK FOR "MOD" AND "IDIV"
  JP Z,EVAL_BOOL                                               ;IF SO, COERCE ARGUMENTS TO INTEGER

; Routine at 15050
;
; THIS CODE PUSHES THE CURRENT VALUE IN THE FAC
; ONTO THE STACK, EXCEPT IN THE CASE OF STRINGS IN WHICH IT CALLS
; TYPE MISMATCH ERROR. [D] AND [E] ARE PRESERVED.
;
; Used by the routine at FINREL.
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
  INC HL

  LD HL,FACLOW        ;WE HAVE A DOUBLE PRECISON NUMBER
  LD C,(HL)           ;PUSH ITS 4 LO BYTES ON THE STACK
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC

; Routine at 15090
;
; Used by the routine at EVAL_NUMERIC.
EVAL_NEXT:
  ADD A,$03             ; FIX [A] TO BE THE VALTYP OF THE NUMBER JUST PUSHED ON THE STACK
  LD C,E                ; [C]=OPERATOR NUMBER
  LD B,A                ; [B]=TYPE OF VALUE ON THE STACK
  PUSH BC               ; SAVE THESE THINGS FOR APPLOP
  LD BC,APPLOP          ; GENERAL OPERATOR APPLICATION ROUTINE -- DOES TYPE CONVERSIONS

; Routine at 15098
;
; Used by the routines at LOPREL and FINREL.
EVAL_MORE:
  PUSH BC               ; Save routine address             ;SAVE PLACE TO GO
  LD HL,(TEMP3)         ; Address of current operator      ;REGET THE TEXT POINTER
  JP EVAL_1             ; Loop until prec' break           ;PUSH ON THE PRECEDENCE AND READ MORE FORMULA

; Routine at 15105
;
; Used by the routine at EVAL3.
DORELS:
  LD D,$00       ;ASSUME NO RELATION OPS, ALSO SETUP THE HIGH ORDER OF THE INDEX INTO OPTAB
; Routine at 15107
LOPREL:
  SUB TK_GREATER            ;IS THIS ONE RELATION?
  JP C,FINREL               ;RELATIONS ALL THROUGH
  CP TK_MINOR-TK_GREATER+1  ;IS IT REALLY RELATIONAL?
  JP NC,FINREL              ;NO JUST BIG
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
; This entry point is used by the routine at FOPRND.
EVAL_EXPONENT:
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
; This entry point is used by the routine at FOPRND.
EVAL_BOOL:
  PUSH DE                   ;SAVE THE PRECEDENCE
  CALL __CINT               
  POP DE                    ;[D]=PRECEDENCE
  PUSH HL                   ;PUSH THE LEFT HAND OPERAND
  LD BC,DANDOR              ;"AND" AND "OR" DOER
  JR EVAL_MORE              ;PUSH THE ADDRESS, REGET THE TEXT POINTER
                            ;SAVE THE PRECEDENCE AND SCAN
                            ;MORE OF THE FORMULA

; Build an entry for a relational operator
;
; HERE TO BUILD AN ENTRY FOR A RELATIONAL OPERATOR
; STRINGS ARE TREATED SPECIALLY. NUMERIC COMPARES ARE DIFFERENT
; FROM MOST OPERATOR ENTRIES ONLY IN THE FACT THAT AT THE
; BOTTOM INSTEAD OF HAVING RETAOP, DOCMP AND THE RELATIONAL
; BITS ARE STORED. STRINGS HAVE STRCMP,THE POINTER AT THE STRING DESCRIPTOR,
; DOCMP AND THE RELATIONAL BITS.
;
; Used by the routine at LOPREL.
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
  JP NZ,EVAL_NUMERIC        ;YES, BUILD AN APPLOP ENTRY
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
; Routine at 15186
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
  JP Z,SNGDPC               ;YES, DISPATCH!!
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
  
; Save precedence and eval until precedence break
;EVAL1:
  CP $03                    ;BLOW UP ON RIGHT HAND STRING OPERAND
  JP Z,TM_ERR               ; Err $0D - "Type mismatch"
  JR NC,EVAL_FP             ;AND IF SO CONVERT THE STACK TO SINGLE PRECISION


;NOTE: THE STACK MUST BE INTEGER AT THIS POINT

; Routine at 15232
;
; Used by the routine at APPLOP.
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

; Routine at 15248
;
; THE STACK OPERAND IS DOUBLE PRECISION, SO
; THE FAC MUST BE FORCED TO DOUBLE PRECISION, MOVED INTO ARG
; AND THE STACK VALUE POPED INTO THE FAC
;
;
; Used by the routine at APPLOP.
STKDBL:
  CALL __CDBL              ;MAKE THE FAC DOUBLE PRECISION
; This entry point is used by the routine at APPLOP.
DBLDPC:
  CALL VMOVAF              ;POP OFF THE STACK OPERAND INTO THE FAC
  POP HL
  LD (FACLOW+2),HL
  POP HL
  LD (FACLOW),HL           ;STORE LOW BYTES AWAY
; This entry point is used by the routine at FACDBL.
SNGDBL:
  POP BC
  POP DE                   ;POP OFF A FOUR BYTE VALUE
  CALL FPBCDE              ;INTO THE FAC
; This entry point is used by the routine at FACDBL.
SETDBL:
  CALL __CDBL              ;MAKE SURE THE LEFT OPERAND IS DOUBLE PRECISION
  LD HL,DEC_OPR            ;DISPATCH TO A DOUBLE PRECISION ROUTINE
; This entry point is used by the routine at FACDBL.
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
; Routine at 15287
;
FACDBL:
  PUSH BC                  ;(***)
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

SNGDPC:
  POP BC                   ;PUT THE LEFT HAND OPERAND IN THE REGISTERS
  POP DE
; This entry point is used by the routine at EVAL_FP.
SNGDO:
  LD HL,FLT_OPR            ;SETUP THE DISPATCH ADDRESS FOR THE SINGLE PRECISION OPERATOR ROUTINES
  JR DODSP                 ;DISPATCH

; THIS IS THE CASE WHERE THE FAC IS SINGLE PRECISION AND THE STACK IS AN
; INTEGER
;
; Used by the routine at EVAL1.
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
; Routine at 15335
IDIV:
  PUSH HL                  ;SAVE THE RIGHT HAND ARGUMENT
  EX DE,HL                 ;[H,L]=LEFT HAND ARGUMENT
  CALL HL_CSNG             ;CONVERT [H,L] TO A SINGLE-PRECISION NUMBER IN THE FAC
  POP HL                   ;GET BACK THE RIGHT HAND ARGUMENT
  CALL PUSHF               ;PUSH THE CONVERTED LEFT HAND ARGUMENT ONTO THE STACK
  CALL HL_CSNG             ;CONVERT THE RIGHT HAND ARGUMENT TO A SINGLE PRECISION NUMBER IN THE FAC
  JP DIV                   ;DO THE DIVISION AFTER POPING INTO THE REGISTERS THE LEFT HAND ARGUMENT

; Get next expression value
; a.k.a. EVAL (in that case 'EVAL' was called 'FRMEVL')
;
; Used by the routines at EVAL and CONCAT.
OPRND:
  CALL CHRGTB             ; Gets next character (or token) from BASIC text.
  JP Z,MO_ERR             ;TEST FOR MISSING OPERAND - IF NONE, Err $18 - "Missing Operand" Error
  JP C,FIN                ;IF NUMERIC, INTERPRET CONSTANT              If numeric type, create FP number
  CALL ISLETTER_A         ;VARIABLE NAME?                              See if a letter
  JP NC,EVAL_VARIABLE     ;AN ALPHABETIC CHARACTER MEANS YES           Letter - Find variable
  CP DBLCON+1             ;IS IT AN EMBEDED CONSTANT
  JP C,CONFAC             ;RESCAN THE TOKEN & RESTORE OLD TEXT PTR
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
  JP Z,__NOT
  CP '&'                  ;OCTAL CONSTANT?
  JP Z,OCTCNS
  CP TK_ERR               ;'ERR' token ?
  JR NZ,NTERC             ;NO, TRY OTHER POSSIBILITIES

; Routine at 15403
__ERR:
  CALL CHRGTB             ;GRAB FOLLOWING CHAR IS IT A DISK ERROR CALL?
  LD A,(ERRFLG)           ;GET THE ERROR CODE. "CPI OVER NEXT BYTE
  PUSH HL                 ;SAVE TEXT POINTER
  CALL PASSA              ;RETURN THE VALUE
  POP HL                  ;RESTORE TEXT POINTER
  RET                     ;ALL DONE.

; ERL function evaluation
;
; Used by the routine at OPRND.
NTERC:
  CP TK_ERL               ;ERROR LINE NUMBER VARIABLE
  JR NZ,NTERL             ;NO, TRY MORE THINGS.

; ERL function evaluation
__ERL:
  CALL CHRGTB             ;GET FOLLOWING CHARACTER
  PUSH HL                 ;SAVE TEXT POINTER
  LD HL,(ERRLIN)          ;GET THE OFFENDING LINE #
  CALL INEG2              ;FLOAT 2 BYTE UNSINGED INT
  POP HL                  ;RESTORE TEXT POINTER
  RET                     ;RETURN

; This entry point is used by the routine at NTERC.
NTERL:
  CP TK_VARPTR            ;VARPTR CALL?
  JR NZ,NTVARP            ;NO

; VARPTR function evaluation
__VARPTR:
  CALL CHRGTB             ;EAT CHAR AFTER
  CALL SYNCHR             ;EAT LEFT PAREN
  DEFM "("                
  CP '#'                  ;WANT POINTER TO FILE?
  JR NZ,NVRFIL

  CALL FNDNUM
  PUSH HL
  CALL GETPTR
  POP HL
  JP VARRET

NVRFIL:
  CALL GETVAR             ;GET ADDRESS OF VARIABLE
VARRET:
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
; Routine at 15476
;
; Used by the routine at __ERL.
NTVARP:
  CP TK_USR               ;USER ASSEMBLY LANGUAGE ROUTINE??
  JP Z,FN_USR             ;GO HANDLE IT
  CP TK_INSTR             ;IS IT THE INSTR FUNCTION??
  JP Z,FN_INSTR           ;DISPATCH

; Apple II specific code section
;---------------------
  CP TK_COLOR
  JP Z,FN_COLOR
  CP TK_HCOLOR
  JP Z,FN_HCOLOR
  CP TK_SCRN
  JP Z,FN_SCRN
  CP TK_HSCRN
  JP Z,FN_HSCRN
;---------------------
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
; Routine at 15526
;
; Used by the routines at OKNORM and FN_USR.
EVLPAR:
  CALL OPNPAR        ; Evaluate expression in "()", RECURSIVELY EVALUATE THE FORMULA
  CALL SYNCHR        ; Make sure ")" follows
  DEFM ")"
  RET

; '-' operand evaluation
;
; Used by the routine at OPRND.
MINUS:
  LD D,$7D           ; "-" precedence                   ;A PRECEDENCE BELOW ^
  CALL EVAL_1        ; Evaluate until prec' break       ;BUT ABOVE ALL ELSE
  LD HL,(NXTOPR)     ; Get next operator address        ;SO ^ GREATER THAN UNARY MINUS
  PUSH HL            ; Save next operator address       ;GET TEXT POINTER
  CALL INVSGN        ; Negate value

; Routine at 15546
RETNUM:
  POP HL             ; Restore next operator address
  RET

; Routine at 15548
;
; Used by the routine at OPRND.
EVAL_VARIABLE:
  CALL GETVAR
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
; Used by the routines at TOKENIZE and KRNSAV.
MAKUPL:
  LD A,(HL)

; Make char in 'A' upper case
;
; Used by the routines at NTSNGT, OCTCNS and DISPI.
UCASE:
  CP 'a'                ;IS IT LOWER CASE RANGE
  RET C                 ;LESS
  CP 'z'+1              ;GREATER
  RET NC                ;TEST
  AND $5F               ;MAKE UPPER CASE
  RET                   ;DONE

; This entry point is used by the routines at L8316 and L8345.
CNSGET:
  CP '&'                ;OCTAL PERHAPS?
  JP NZ,ATOH


;
; OCTAL, HEX or other specified base (ASCII) to FP number
;
; Used by the routines at WUZOCT, OPRND and H_ASCTFP.
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
  DEC B
  JP Z,OV_ERR           ;TOO MANY DIGITS?
  EX DE,HL              ;GET TEXT POINTER BACK IN [H,L]
  JR LOPHEX             ;KEEP EATING
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

; Routine at 15675
;
; Used by the routine at OPRND.
ISFUN:
  INC HL
  LD A,(HL)
  SUB $81
  CP $07
  JR NZ,ISFUN_0
  PUSH HL
  CALL CHRGTB
  CP $28
  POP HL
  JP NZ,SUMLP_0
  LD A,$07
ISFUN_0:
  LD B,$00
  RLCA
  LD C,A
  PUSH BC
  CALL CHRGTB
  LD A,C
  CP $05
  JP NC,OKNORM
  CALL OPNPAR
  CALL SYNCHR

; Message at 15715
L3D63:
  DEFM ","

; Routine at 15716
L3D64:
  CALL TSTSTR
  EX DE,HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  CALL GETINT
  EX DE,HL
  EX (SP),HL
  JR OKNORM_1

; Routine at 15733
;
; Used by the routine at ISFUN.
OKNORM:
  CALL EVLPAR
  EX (SP),HL
  LD A,L
  CP $0C
  JR C,OKNORM_0
  CP $1B
  PUSH HL
  CALL C,__CSNG
  POP HL
OKNORM_0:
  LD DE,RETNUM
  PUSH DE
  LD A,$01
  LD (FLGOVC),A
; This entry point is used by the routine at L3D64.
OKNORM_1:
  LD BC,$01B2
; This entry point is used by the routine at CHKTYP.
OKNORM_2:
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  JP (HL)
; This entry point is used by the routine at H_ASCTFP.
OKNORM_3:
  DEC D
  CP $F3
  RET Z
  CP $2D
  RET Z
  INC D
  CP $2B
  RET Z
  CP $F2
  RET Z
  DEC HL
  RET

; Routine at 15783
DOCMP:
  INC A
  ADC A,A
  POP BC
  AND B
  ADD A,$FF
  SBC A,A
  CALL CONIA
  JR __NOT_0

; eval NOT boolean operation
;
; Used by the routine at OPRND.
__NOT:
  LD D,$5A
  CALL EVAL_1
  CALL __CINT
  LD A,L
  CPL
  LD L,A
  LD A,H
  CPL
  LD H,A
  LD (FACCU),HL
  POP BC
; This entry point is used by the routine at DOCMP.
__NOT_0:
  JP EVAL3

; Test number FAC type (Precision mode, etc..)
;
; Used by the routines at SRCHLP, NTINTG, L32F3, SAVSTP, __PRINT, NOTQTI,
; SCNVAL, FINREL, EVAL_VARIABLE, L3F72, GETWORD_HL, INVSGN, VSIGN, VMVVFM,
; __CINT, __CSNG, __CDBL, TSTSTR, __FIX, __INT, FINE, DPOINT, MULTEN, FINDIV,
; ADDIG, FINEDG, OVERR, DOEBIT, FOUTNV, SIXDIG, RNGTST, FOUTCV, ZEROER, __SWAP,
; L69DC, L6E29, FN_INSTR, __FRE, __CALL, __WRITE, FILIND and LINE_INPUT.
GETYPR:
  LD A,(VALTYP)
  CP $08
  JR NC,GETYPR_0
  SUB $03
  OR A
  SCF
  RET
GETYPR_0:
  SUB $03
  OR A
  RET

; Routine at 15832
DANDOR:
  PUSH BC
  CALL __CINT
  POP AF
  POP DE
  CP $7A
  JP Z,INEG_2
  CP $7B
  JP Z,INT_DIV
  LD BC,PASSA_0
  PUSH BC
  CP $46
  JR NZ,DANDOR_0
  LD A,E
  OR L
  LD L,A
  LD A,H
  OR D
  RET
DANDOR_0:
  CP $50
  JR NZ,DANDOR_1
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET
DANDOR_1:
  CP $3C
  JR NZ,DANDOR_2
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET
DANDOR_2:
  CP $32
  JR NZ,DANDOR_3
  LD A,E
  XOR L
  CPL
  LD L,A
  LD A,H
  XOR D
  CPL
  RET
DANDOR_3:
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
DANDOR_4:
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP INEG2

; Routine at 15913
__LPOS:
  LD A,(LPTPOS)
  JR __POS_0

; Routine at 15918
__POS:
  LD A,(TTYPOS)
; This entry point is used by the routine at __LPOS.
__POS_0:
  INC A

; aka SNGFLT, Get back from function, result in A
;
; Used by the routines at __ERR, __PEEK, EXIT_FN, __PDL, __VAL and __LOF.
PASSA:
  LD L,A
  XOR A
; This entry point is used by the routine at __LOC.
PASSA_0:
  LD H,A
  JP MAKINT

; Routine at 15928
;
; Used by the routine at NTVARP.
FN_USR:
  CALL SCNUSR
  PUSH DE
  CALL EVLPAR
  EX (SP),HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD HL,POPHLRT
  PUSH HL
  PUSH BC
  LD A,(VALTYP)
  PUSH AF
  CP $03
  CALL Z,GSTRCU
  POP AF
  EX DE,HL
  LD HL,FACCU
  RET

; Routine at 15959
;
; Used by the routines at FN_USR and DEF_USR.
SCNUSR:
  CALL CHRGTB
  LD BC,$0000
  CP $1B
  JR NC,NOARGU
  CP $11
  JR C,NOARGU
  CALL CHRGTB
  LD A,(CONLO)
  OR A
  RLA
  LD C,A

; Routine at 15982
;
; Used by the routine at SCNUSR.
NOARGU:
  EX DE,HL
  LD HL,$081F
  ADD HL,BC
  EX DE,HL
  RET

; Routine at 15989
;
; Used by the routine at __DEF.
DEF_USR:
  CALL SCNUSR
  PUSH DE
  CALL SYNCHR

; Message at 15996
L3E7C:
  DEFB $F0

; Routine at 15997
L3E7D:
  CALL FPSINT_0
  EX (SP),HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; Routine at 16006
__DEF:
  CP $E1
  JR Z,DEF_USR
  CALL GETFNM
  CALL IDTEST
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  LD A,(HL)
  CP $28
  JP NZ,__DATA
  CALL CHRGTB
; This entry point is used by the routine at L3EAB.
__DEF_0:
  CALL GETVAR
  LD A,(HL)
  CP $29
  JP Z,__DATA
  CALL SYNCHR

; Message at 16042
L3EAA:
  DEFM ","

; Routine at 16043
L3EAB:
  JR __DEF_0

; Routine at 16045
;
; Used by the routine at NTVARP.
DOFN:
  CALL GETFNM
  LD A,(VALTYP)
  OR A
  PUSH AF
  LD (NXTOPR),HL
  EX DE,HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  OR H
  JP Z,UFN_ERR
  LD A,(HL)
  CP $28
  JP NZ,$3F73
  CALL CHRGTB
  LD (TEMP3),HL
  EX DE,HL
  LD HL,(NXTOPR)
  CALL SYNCHR

; Message at 16084
L3ED4:
  DEFM "("

; Routine at 16085
L3ED5:
  XOR A
  PUSH AF
  PUSH HL
  EX DE,HL

; Routine at 16089
;
; Used by the routine at L3F1B.
ASGMOR:
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
  CALL CHKSTK
  LD HL,$FFF8
  ADD HL,SP
  LD SP,HL
  CALL VMOVMF
  LD A,(VALTYP)
  PUSH AF
  LD HL,(NXTOPR)
  LD A,(HL)
  CP $29
  JR Z,POPASG
  CALL SYNCHR

; Message at 16146
L3F12:
  DEFM ","

; Routine at 16147
L3F13:
  PUSH HL
  LD HL,(TEMP3)
  CALL SYNCHR

; Message at 16154
L3F1A:
  DEFM ","

; Routine at 16155
L3F1B:
  JR ASGMOR

; Routine at 16157
POPAS2:
  POP AF
  LD (PRMLN2),A

; Routine at 16161
;
; Used by the routine at ASGMOR.
POPASG:
  POP AF
  OR A
  JR Z,FINASG
  LD (VALTYP),A
  LD HL,$0000
  ADD HL,SP
  CALL VMOVFM
  LD HL,$0008
  ADD HL,SP
  LD SP,HL
  POP DE
  LD L,$03

; Routine at 16183
LPSIZL:
  INC L
  DEC DE
  LD A,(DE)
  OR A
  JP M,LPSIZL
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
  CALL BCTRAN
  LD BC,POPAS2
  PUSH BC
  PUSH BC
  JP LETCN4

; Routine at 16228
;
; Used by the routine at POPASG.
FINASG:
  LD HL,(NXTOPR)
  CALL CHRGTB
  PUSH HL
  LD HL,(TEMP3)
  CALL SYNCHR

; Message at 16241
L3F71:
  DEFM ")"

; Routine at 16242
L3F72:
  LD A,$D5
  LD (TEMP3),HL
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
  LD DE,PRMSTK
  CALL BCTRAN
  POP HL
  LD (PRMSTK),HL
  LD HL,(PRMLN2)
  LD (PRMLEN),HL
  LD B,H
  LD C,L
  LD HL,PARM1
  LD DE,PARM2
  CALL BCTRAN
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
  CALL FRMEQL
  DEC HL
  CALL CHRGTB
  JP NZ,SN_ERR
  CALL GETYPR
  JR NZ,NOCPRS
  LD DE,DSCTMP
  LD HL,(FACCU)
  CALL DCOMPR
  JR C,NOCPRS
  CALL STRCPY
  CALL $6C1E

; Routine at 16347
;
; Used by the routine at L3F72.
NOCPRS:
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
  CALL BCTRAN
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

; Routine at 16383
;
; Used by the routines at L329B, L35E2, ASGMOR and __MKD_S.
CHKTYP:
  PUSH HL
  AND $07
  LD HL,TYPE_OPR
  LD C,A
  LD B,$00
  ADD HL,BC
  CALL OKNORM_2
  POP HL
  RET

; Routine at 16398
;
; Used by the routine at BCTRAN.
BCTRAL:
  LD A,(DE)
  LD (HL),A

; Routine at 16400
BCTRAl:
  INC HL
  INC DE
  DEC BC

; Routine at 16403
;
; Used by the routines at LPSIZL, L3F72 and NOCPRS.
BCTRAN:
  LD A,B
  OR C
  JR NZ,BCTRAL
  RET

; Routine at 16408
;
; Used by the routine at __DEF.
IDTEST:
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  RET NZ
  LD E,$0C
  JP ERROR



;
; SUBROUTINE TO GET A POINTER TO A FUNCTION NAME
; Make sure "FN" follows and get FN name
;
; This entry point is used by the routines at __DEF and DOFN.
GETFNM:
  CALL SYNCHR             ; Make sure FN follows
  DEFB TK_FN              ;MUST START WITH "FN"
  LD A,$80                ;DONT ALLOW AN ARRAY,
  LD (SUBFLG),A           ;DON'T RECOGNIZE THE "(" AS THE START OF AN ARRAY REFEREENCE
  OR (HL)                 ; FN name has bit 7 set      ;PUT FUNCTION BIT ON
  LD C,A                  ; in first byte of name      ;GET FIRST CHARACTER INTO [C]
  JP GTFNAM               ; Get FN name


; STRING FUNCTIONS - LEFT HAND SIDE MID$
; Used by the routine at EXEC.
;
; This entry point is used by the routine at NEWSTT_0.
ISMID:
  CP $FF-TK_END           ;LHS MID$?                   ;FUNCTION? (FF - $END)
  JP NZ,SN_ERR            ;NO, ERROR.
  INC HL                  ;POINT TO NEXT CHAR
  LD A,(HL)               ;GET FN DESCRIPTOR
  CP $80+TK_MID_S         ;IS IT MID?
  JP NZ,SN_ERR            ;NO, ERROR
  INC HL
  JP LHSMID
  JP SN_ERR


; 'WIDTH' BASIC command
; THIS IS THE WIDTH (TERMINAL WIDTH) COMMAND
; ARG MUST BE .GT. 15 AND .LT. 255
;
; WIDTH [LPRINT] <integer expression>
; To set the printed line width in number of characters for the terminal or line printer.
;
; Routine at 16455
__WIDTH:
  CP TK_LPRINT            ;WIDTH LPRINT?
  JR NZ,NOTWLP            ;NO
  CALL CHRGTB             ;FETCH NEXT CHAR
  CALL GETINT             ;GET WIDTH
  LD (LPTSIZ),A           ;SAVE IT
  LD E,A                  ; (probably not needed)
  CALL __WIDTH_3
  LD (COMMAN),A
  RET

NOTWLP:
  CP ','
  JR Z,__WIDTH_2
  CALL GETINT             ;GET THE CHANNEL #
; This entry point is used by the routine at L8287.
__WIDTH_1:
  LD (LINLEN),A           ;SETUP THE LINE LENGTH
  LD E,A
  CALL __WIDTH_3          ;COMPUTE LAST COMMA COLUMN
  LD (NCMPOS),A           ;SET LAST COMMA POSITION
  LD A,(HL)
  CP ','
  RET NZ
__WIDTH_2:
  CALL CHRGTB
  CALL GETINT
  LD (CRTCNT),A           ;Vertical text size (Apple II specific)
  RET

;COMPUTE LAST COMMA COLUMN
__WIDTH_3:
  SUB CLMWID
  JR NC,__WIDTH_3
  ADD A,2*CLMWID
  CPL
  INC A
  ADD A,E
  RET                     ;BACK TO NEWSTT

; Get subscript
;
; Used by the routine at L32F3.
FPSINT:
  CALL CHRGTB

; Get positive integer
;
; Used by the routines at INTIDX, __TAB, L3E7D, __WAIT and SCAND.
FPSINT_0:
  CALL EVAL

; Get integer variable to DE, error if negative
;
; Used by the routine at CONINT.
DEPINT:
  PUSH HL
  CALL __CINT
  EX DE,HL
  POP HL
  LD A,D
  OR A
  RET

; Load 'A' with the next number in BASIC program
;
; Used by the routines at L3C52 and __FIELD.
FNDNUM:
  CALL CHRGTB

; Routine at 16535
;
; Used by the routines at L364D, __ERROR, L3D64, __WIDTH, GETWORD, GET_POSINT,
; __GR, L4646, L466F, GET_2_ARGS, L46AE, L472A, L4736, L47A8, L483F, __HGR,
; L4B30, L6E1A, L6F94, L6FEB, __CLOSE, L79F2 and L7D22.
GETINT:
  CALL EVAL

; Routine at 16538
;
; Used by the routines at __BUTTON, __PDL, __ASC, L6E29, __SPACE_S, FN_INSTR
; and FILFRM.
CONINT:
  CALL DEPINT
  JP NZ,FC_ERR
  DEC HL
  CALL CHRGTB
  LD A,E
  RET

; Routine at 16550
__LLIST:
  LD A,$01
  LD (PRTFLG),A

; Routine at 16555
;
; Used by the routine at L787A.
__LIST:
  POP BC
  CALL LNUM_RANGE
  PUSH BC
  CALL PROCHK
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
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  POP HL
  CALL Z,FININL_3
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
  CALL LINPRT
  POP HL
  LD A,(HL)
  CP $09
  JR Z,__LIST_1
  LD A,$20
  CALL OUTDO
__LIST_1:
  CALL DETOKEN_LIST
  LD HL,BUF
  CALL LISPRT
  CALL OUTDO_CRLF
  JR __LIST_0

; Routine at 16640
;
; Used by the routines at __LIST, EDIT_BRANCH, EDIT_DONE and PINLIN.
LISPRT:
  LD A,(HL)
  OR A
  RET Z
  CALL OUTCH1
  INC HL
  JR LISPRT

; Routine at 16649
;
; Used by the routines at __LIST and __EDIT.
DETOKEN_LIST:
  LD BC,BUF
  LD D,$FF
  XOR A
  LD (INTFLG),A
  CALL PROCHK
  JR PLOOP2
; This entry point is used by the routine at PRTVAR.
DETOKEN_NEXT_1:
  INC BC
  INC HL
  DEC D
  RET Z
; This entry point is used by the routines at L4193 and NUMDN.
PLOOP2:
  LD A,(HL)
  OR A
  LD (BC),A
  RET Z
  CP $0B
  JR C,NTEMBL
  CP $20
  LD E,A
  JR C,PRTVAR
NTEMBL:
  OR A
  JP M,PLOOPR
  LD E,A
  CP $2E
  JR Z,PRTVAR
  CALL TSTANM
  JP NC,PRTVAR
  XOR A
  JR PRTVAR_0

; Routine at 16698
;
; Used by the routine at DETOKEN_LIST.
PRTVAR:
  LD A,(INTFLG)
  OR A
  JR Z,PLOOPG
  INC A
  JR NZ,PLOOPG
  LD A,$20
  LD (BC),A
  INC BC
  DEC D
  RET Z
PLOOPG:
  LD A,$01
; This entry point is used by the routine at DETOKEN_LIST.
PRTVAR_0:
  LD (INTFLG),A
  LD A,E
  CP $0B
  JR C,PLOOPZ
  CP $20
  JP C,NUMLIN
PLOOPZ:
  LD (BC),A
  JR DETOKEN_NEXT_1
; This entry point is used by the routine at DETOKEN_LIST.
PLOOPR:
  INC A
  LD A,(HL)
  JR NZ,NTFNTK
  INC HL
  LD A,(HL)
  AND $7F
NTFNTK:
  INC HL
  CP $EA
  JR NZ,FNDWRD
  DEC BC
  DEC BC
  DEC BC
  DEC BC
  INC D
  INC D
  INC D
  INC D

; Routine at 16752
;
; Used by the routine at PRTVAR.
FNDWRD:
  CP $9E
  CALL Z,DCBCDE_0
  PUSH HL
  PUSH BC
  PUSH DE
  LD HL,WORDS
  LD B,A
  LD C,$40
RESSR3:
  INC C
RESSR1:
  INC HL
  LD D,H
  LD E,L
RESSRC:
  LD A,(HL)
  OR A
  JR Z,RESSR3
  INC HL
  JP P,RESSRC
  LD A,(HL)
  CP B
  JR NZ,RESSR1
  EX DE,HL

; TK_USR
L418F:
  CP $E1
  JR Z,NOISPA

; TK_FN
L4193:
  CP $E2
; This entry point is used by the routine at L418F.
NOISPA:
  LD A,C
  POP DE
  POP BC
  LD E,A
  JR NZ,L4193_0
  LD A,(INTFLG)
  OR A
  LD A,$00
  LD (INTFLG),A
  JR MORLNZ
L4193_0:
  CP $5B
  JR NZ,L4193_1
  XOR A
  LD (INTFLG),A
  JR MORPUR
L4193_1:
  LD A,(INTFLG)
  OR A
  LD A,$FF
  LD (INTFLG),A
MORLNZ:
  JR Z,L4193_2
  LD A,$20
  LD (BC),A
  INC BC
  DEC D
  JP Z,POPAF
L4193_2:
  LD A,E
  JR L4193_3
MORPUR:
  LD A,(HL)
  INC HL
  LD E,A
L4193_3:
  AND $7F
  LD (BC),A
  INC BC
  DEC D
  JP Z,POPAF
  OR E
  JP P,MORPUR
  CP $A8
  JR NZ,L4193_4
  XOR A
  LD (INTFLG),A
L4193_4:
  POP HL
  JP PLOOP2

; Routine at 16865
;
; Used by the routines at TOKENIZE and DETOKEN_LIST.
TSTANM:
  CALL ISLETTER_A
  RET NC
  CP $30
  RET C
  CP $3A
  CCF
  RET

; Routine at 16876
;
; Used by the routine at PRTVAR.
NUMLIN:
  DEC HL
  CALL CHRGTB
  PUSH DE
  PUSH BC
  PUSH AF
  CALL CONFAC
  POP AF
  LD BC,CONLIN
  PUSH BC
  CP $0B
  JP Z,FOUTO
  CP $0C
  JP Z,FOUTH
  LD HL,(CONLO)
  JP FOUT

; Routine at 16907
CONLIN:
  POP BC
  POP DE
  LD A,(CONSAV)
  LD E,$4F
  CP $0B
  JR Z,SAVBAS
  CP $0C
  LD E,$48
  JR NZ,NUMSLN
SAVBAS:
  LD A,$26
  LD (BC),A
  INC BC
  DEC D
  RET Z
  LD A,E
  LD (BC),A
  INC BC
  DEC D
  RET Z
NUMSLN:
  LD A,(CONTYP)
  CP $04
  LD E,$00
  JR C,TYPSET
  LD E,$21
  JR Z,TYPSET
  LD E,$23
TYPSET:
  LD A,(HL)
  CP $20
  CALL Z,INCHL
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

; Routine at 16993
;
; Used by the routine at CONLIN.
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

; Routine at 17007
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
; This entry point is used by the routines at LINFND and CDVARS.
__DELETE_0:
  EX DE,HL                ;[D,E] NOW HAVE THE POINTER TO THE LINE BEYOND THIS ONE
  LD HL,(VARTAB)          ;COMPACTIFYING TO VARTAB
MLOOP:
  LD A,(DE)
  LD (BC),A
  INC BC
  INC DE
  CALL DCOMPR
  JR NZ,MLOOP
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

; Routine at 17063
__PEEK:
  CALL GETWORD_HL         ;GET AN INTEGER IN [H,L]
  CALL PRODIR             ;DONT ALLOW DIRECT IF PROTECTED FILE
  LD A,(HL)               ;GET THE VALUE TO RETURN
  JP PASSA                ;AND FLOAT IT

; 'POKE' BASIC command
; Routine at 17073
__POKE:
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  EX (SP),HL
  CALL PRODIR
  CALL SYNCHR
  DEFM ","


; Get a number to DE
; a.k.a. FRMQNT
; Routine at 17088
GETWORD:
  CALL GETINT
  POP DE
  LD (DE),A
  RET

; Routine at 17094
;
; Used by the routines at __PEEK, __POKE, FOUTH, L6A5D and L72E5.
GETWORD_HL:
  LD BC,__CINT            ;RETURN HERE
  PUSH BC                 ;SAVE ADDR
  CALL GETYPR             ;SET THE CC'S ON VALTYPE
  RET M                   ;RETURN IF ALREADY INTEGER.
  LD A,(FPEXP)            ;GET EXPONENT
  CP $90                  ;IS MAGNITUDE .GT. 32767
  RET NZ
  LD A,(FACCU+2)
  OR A
  RET M
  LD BC,$9180		; -65536
  LD DE,$0000
  JP FADD

; Routine at 17122
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
  LD A,E
  INC HL                ;GET LOW PART INTO K[A] FOR ZERO TEST
  LD D,(HL)             
  OR D                  ;SET CC'S ON LINK FIELD
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
  LD A,E
  INC HL
  LD D,(HL)
  OR D
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

; This entry point is used by the routines at DEPTR, BINSAV and __GET.
SCCPTR:
  XOR A
  LD (PTRFLG),A
  LD HL,(TXTTAB)
  DEC HL
  
; This entry point is used by the routine at _LINE2PTR.
SCNPLN:
  INC HL           ;                                           POINT TO BYTE AFTER ZERO AT END OF LINE
  LD A,(HL)        ; Get address of next line                  GET LINK FIELD INTO [D,E]
  INC HL
  OR (HL)          ; End of program found?                     SET CC'S
  RET Z            ; Yes - Line not found                      RETURN IF ALL DONE.
  INC HL
  LD E,(HL)        ; Get LSB of line number                    GET LOW BYTE OF LINE #
  INC HL
  LD D,(HL)        ; Get MSB of line number                    GET HIGH BYTE OF LINE #

; Routine at 17283
;
; Used by the routines at _LINE2PTR, _SCNEXT and SCNPT2.
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
  CP $0E
  JR NZ,SCNEXT
  PUSH DE
  CALL LINGT3
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

; Routine at 17363
SCNPOP:
  POP HL                ;POP OFF CURRENT TEXT POINTER
SCNEX3:
  POP DE                ;GET BACK CURRENT LINE #
  DEC HL                ;BACKUP POINTER

; Routine at 17366
_SCNEXT:
  JR SCNEXT             ;KEEP SCANNING

; Message at 17368
LINE_ERR_MSG:
  DEFM "Undefined line "
  DEFB $00

; Routine at 17384
;
; Used by the routine at _LINE2PTR.
SCNPT2:
  CP $0D
  JP NZ,SCNEXT
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
  LD A,$0E
; This entry point is used by the routine at _LINE2PTR.
MAKPTR:
  LD HL,SCNPOP
  PUSH HL
  LD HL,(CONTXT)


; CHANGE LINE # TO PTR
;
; Used by the routine at __GOTO.
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

; Routine at 17419
;
; Used by the routines at LINFND, __DELETE and L7317.
DEPTR:
  LD A,(PTRFLG)        ;DO LINE POINTERS EXIST IN PGM?
  OR A                 ;SET CC'S
  RET Z                ;NO, JUST RETURN
  JP SCCPTR            ;CONVERT THEN TO LINE #'S

; Routine at 17427
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
  SUB $30
  JP C,SN_ERR
  CP $02
  JP NC,SN_ERR
  LD (OPTVAL),A
  INC A
  LD (OPTFLG),A
  CALL CHRGTB
  RET

; This entry point is used by the routine at OVERR.
STRPRN:
  LD A,(HL)            ;GET BYTE FROM MESSAGE
  OR A                 ;END OF MESSAGE
  RET Z                ;YES, DONE
  CALL CALTTY          ;PRINT CHAR
  INC HL               ;INCREMENT POINTER
  JP STRPRN            ;PRINT NEXT CHAR

;
; CALTTY IS A SPECIAL ROUTINE TO OUTPUT ERROR MESSAGE TO TTY, REGARDLESS OF CURRENT FILE I/O.
;
; Entry - [A] = byte to be output
; Exit  - All registers preserved
;
; This entry point is used by the routine at OVERR.
CALTTY:
  PUSH AF
  JP CHPUT


; 'RANDOMIZE' BASIC command

; Routine at 17501
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
  CALL __FRE_1
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
  LD ($5E25),HL
  CALL SUMLP_1
  POP HL
  RET

; Message at 17547
RND_SEED_MSG:
  DEFM "Random number seed (-32768-"
  DEFB $08
  DEFM " to 32767)"
  DEFB $00

; Routine at 17586
;
; Used by the routine at __WHILE.
WNDSCN:
  LD C,$1D

; Routine at 17588
NXTSCN:
  JR SCNCNT
; This entry point is used by the routine at SAVSTP.
NXTSCN_0:
  LD C,$1A

; Routine at 17592
;
; Used by the routine at NXTSCN.
SCNCNT:
  LD B,$00
  EX DE,HL
  LD HL,(CURLIN)
  LD (NXTLIN),HL
  EX DE,HL
; This entry point is used by the routine at NXTLOK.
FORINC:
  INC B
; This entry point is used by the routine at NXTLOK.
FNLOP:
  DEC HL
SCANWF:
  CALL CHRGTB
  JR Z,FORTRM
  CP $9E
  JR Z,FNNWST
  CP $DE
  JR NZ,SCANWF
; This entry point is used by the routine at DECNXT.
FORTRM:
  OR A
  JR NZ,FNNWST
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
  LD (NXTLIN),HL
  EX DE,HL
FNNWST:
  CALL CHRGTB
  LD A,C
  CP $1A
  LD A,(HL)
  JR Z,NXTLOK
  CP $AF
  JR Z,FORINC
  CP $B0
  JR NZ,FNLOP
  DJNZ FNLOP
  RET

; Routine at 17657
;
; Used by the routine at SCNCNT.
NXTLOK:
  CP $82
  JR Z,FORINC
  CP $83
  JR NZ,FNLOP

; Routine at 17665
DECNXT:
  DEC B
  RET Z
  CALL CHRGTB
  JR Z,FORTRM
  EX DE,HL
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(NXTLIN)
  LD (CURLIN),HL
  EX DE,HL
  PUSH BC
  CALL GETVAR
  POP BC
  DEC HL
  CALL CHRGTB
  LD DE,FORTRM
  JR Z,TRMNXT
  CALL SYNCHR

; Message at 17701
L4525:
  DEFM ","

; Routine at 17702
L4526:
  DEC HL
  LD DE,DECNXT

; Routine at 17706
;
; Used by the routine at DECNXT.
TRMNXT:
  EX (SP),HL
  LD (CURLIN),HL
  POP HL
  PUSH DE
  RET

; Routine at 17713
FINOVC:
  PUSH AF
  LD A,(FLGOVC)
  LD (OVCSTR),A
  POP AF

; Routine at 17721
;
; Used by the routine at STKINI.
CLROVC:
  PUSH AF
  XOR A
  LD (FLGOVC),A
  POP AF
  RET

; Routine at 17728
__VTAB:
  CALL GET_POSINT
  PUSH HL
  LD HL,CRTCNT
__VTAB_0:
  SUB (HL)
  JP P,__VTAB_0
  ADD A,(HL)
  LD (TTY_VPOS),A

; Routine at 17743
;
; Used by the routine at __HTAB.
GOTOXY:
  CALL GOTOXY_0
  POP HL
  RET
; This entry point is used by the routine at __GR.
GOTOXY_0:
  LD E,$07
  CALL CONUA
  LD HL,(TTYPOS)
  LD A,(F396_XY_OFFSET)
  OR A
  JP P,NORVS
  AND $7F
  LD E,L
  LD L,H
  LD H,E

; Do not reverse coordinates if positive
;
; Used by the routine at GOTOXY.
NORVS:
  LD E,A
  ADD A,L
  LD L,A
  LD A,E
  ADD A,H
  PUSH HL
  CALL TRYOUT
  POP HL
  LD A,L
  JR CONUE

; Invoke an Apple II CP/M screen function
;
; Used by the routines at GOTOXY and __NORMAL.
CONUA:
  LD D,$00
  LD HL,F397_SCREEN_FN_TBL
  ADD HL,DE
  LD A,(HL)
  OR A
  RET Z
  JP P,CONUE
  AND $7F
  PUSH AF
  LD A,(F397_SCREEN_FN_TBL)
  CALL TRYOUT
  POP AF

; Invoke an Apple II CP/M screen function and exit
;
; Used by the routines at NORVS and CONUA.
CONUE:
  JP TRYOUT

; Routine at 17806
;
; Used by the routines at __VTAB and __HTAB.
GET_POSINT:
  CALL GETINT
  OR A
  JP Z,FC_ERR
  DEC A
  RET

; Routine at 17815
__HTAB:
  CALL GET_POSINT
  PUSH HL
  LD HL,LINLEN
__HTAB_0:
  SUB (HL)
  JP P,__HTAB_0
  ADD A,(HL)
  LD (TTYPOS),A
; This entry point is used by the routine at __TEXT.
__HTAB_1:
  JR GOTOXY

; Routine at 17832
;
; Used by the routine at DONCMD.
__HOME:
  PUSH HL
  LD HL,$0000
  LD (TTYPOS),HL
  POP HL

; LD E,n
L45B0:
  DEFB $1E

; LD BC,nnn
L45B1:
  DEFB $01

; LD BC,nnn
L45B2:
  DEFB $01

; Routine at 17843
__INVERSE:
  LD E,$05

; LD BC,nnn
L45B5:
  DEFB $01

; Routine at 17846
__NORMAL:
  LD E,$04
  PUSH HL
  CALL CONUA
  POP HL
  RET

; Routine at 17854
;
; Used by the routine at __SYSTEM.
__TEXT:
  PUSH HL
  LD HL,$FB2F
  CALL GO_6502
  LD A,(CRTCNT)
  DEC A
  LD H,A
  LD L,$00
  LD (TTYPOS),HL
  LD A,(LE051)
  LD A,(LE054)
  LD A,(SCRMOD)
  OR A
  JR Z,__TEXT_0
  LD HL,$FC58
  CALL GO_6502
__TEXT_0:
  XOR A
  LD (SCRMOD),A
  JR __HTAB_1

; Routine at 17895
;
; Used by the routines at __TEXT, CALL_HLINE, CALL_6502_POPHL, __PDL and L476B.
GO_6502:
  LD (F3D0_6502_ADDRESS),HL
  LD ($0000),A
  RET

; Routine at 17902
__GR:
  LD A,$00
  LD (LF030),A
  CALL NZ,GETINT
  CP $02
  JR NC,L4646_2
  PUSH HL
  PUSH AF
  LD A,$14
  LD (LF022),A
  LD HL,$1700
  LD (TTYPOS),HL
  CALL GOTOXY_0
  LD A,(LE056)
  POP AF
  POP HL
  LD (LE056),A
  CALL GFX_MODE
  JR NZ,__GR_0
  INC HL
  PUSH DE
  CALL GETINT
  CALL L4646_0
  POP DE
__GR_0:
  PUSH HL
  LD A,$27
  LD (LF02C),A
  LD B,D
__GR_1:
  XOR A
  LD (F047_REG_Y),A
  LD A,B
  DEC A
  LD (F045_REG_A),A
  CALL CALL_HLINE
  DJNZ __GR_1
  LD A,$FF
  LD (SCRMOD),A
  POP HL
  RET

; Routine at 17980
;
; Used by the routines at __GR and __HLIN.
CALL_HLINE:
  LD HL,$F819
  JP GO_6502

; Routine at 17986
__COLOR:
  CALL SYNCHR

; Message at 17989
L4645:
  DEFB $F0

; Routine at 17990
L4646:
  CALL GETINT
; This entry point is used by the routine at __GR.
L4646_0:
  LD A,E
  CP $10
  JR NC,L4646_2
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  OR E
  LD (LF030),A
  RET
; This entry point is used by the routines at __HLIN and __VLIN.
L4646_1:
  PUSH BC
  CALL GET_2_ARGS
  POP BC
  CP B
; This entry point is used by the routines at __GR, L466F and PLOT_ARGS.
L4646_2:
  JP NC,FC_ERR
  CP E
  JP C,FC_ERR
  LD D,A
  PUSH DE
  PUSH BC
  CALL SYNCHR

; Message at 18026
L466A:
  DEFM "A"

; Routine at 18027
L466B:
  CALL SYNCHR

; Message at 18030
L466E:
  DEFM "T"

; Routine at 18031
L466F:
  CALL GETINT
  POP BC
  CP C
  JR NC,L4646_2
  POP DE
  RET

; Routine at 18040
__HLIN:
  LD BC,$2830
  CALL L4646_1
  LD (F045_REG_A),A
  LD A,E
  LD (F047_REG_Y),A
  LD A,D
  LD (LF02C),A
  PUSH HL
  CALL CALL_HLINE
  POP HL
  RET

; Routine at 18063
__VLIN:
  LD BC,$3028
  CALL L4646_1
  LD (F047_REG_Y),A
  LD A,E
  LD (F045_REG_A),A
  LD A,D
  LD (LF02D),A
  PUSH HL
  LD HL,$F828
  JR CALL_6502_POPHL

; Routine at 18086
;
; Used by the routines at L4646, PLOT_ARGS and __BEEP.
GET_2_ARGS:
  CALL GETINT
  PUSH DE
  CALL SYNCHR

; Message at 18093
L46AD:
  DEFM ","

; Routine at 18094
L46AE:
  CALL GETINT
  POP DE
  RET

; Routine at 18099
;
; Used by the routines at __PLOT and L4764.
PLOT_ARGS:
  CALL GET_2_ARGS
  CP $30
  JR NC,L4646_2
  LD (F045_REG_A),A
  LD A,E
  CP $28
  JR NC,L4646_2
  LD (F047_REG_Y),A
  RET

; Routine at 18118
__PLOT:
  CALL PLOT_ARGS
  PUSH HL
  LD HL,$F800

; Routine at 18125
;
; Used by the routines at __VLIN, __BEEP and L47BE.
CALL_6502_POPHL:
  CALL GO_6502
  POP HL
  RET

; determine whether a paddle button has been pressed
__BUTTON:
  CALL CONINT
  LD A,E
  CP $03
  JR NC,__PDL_0
  LD A,D
  OR A
  JR NZ,__PDL_0
  PUSH HL
  LD HL,LE061
  ADD HL,DE
  LD A,(HL)
  POP HL
  RLA
  SBC A,A
; This entry point is used by the routine at L4819.
__BUTTON_0:
  LD L,A
  LD H,A
  JP MAKINT

; Routine at 18156
__VPOS:
  LD A,(TTY_VPOS)
  INC A

; Routine at 18160
;
; Used by the routines at FN_COLOR and FN_HCOLOR.
EXIT_FN:
  PUSH HL
; This entry point is used by the routine at L476B.
EXIT_FN_0:
  CALL PASSA
  POP HL
  RET

; Routine at 18166
__BEEP:
  CALL GET_2_ARGS
  INC A
  LD (F045_REG_A),A
  LD A,E
  INC A
  LD (F046_REG_X),A
  PUSH HL
  LD HL,L5709
  JP CALL_6502_POPHL

; Message at 18184
L4708:
  DEFM "F"

; LDY $00  (entry address for the 6502: $5709)
L4709:
  DEFB $A0

; Data block at 18186
L470A:
  DEFB $00

; LDA $C030  (we're just reading from $C030 to make the speaker click)
L470B:
  DEFB $AD

; Data block at 18188
L470C:
  DEFW $C030

; DEY
L470E:
  DEFB $88

; BNE +4
L470F:
  DEFB $D0

; (+4, to "JSR $57FF")
L4710:
  DEFB $04

; DEC $45
L4711:
  DEFB $C6

; Data block at 18194
L4712:
  DEFB $45

; BEQ +12
L4713:
  DEFB $F0

; (+12, to RTS)
L4714:
  DEFB $0C

; JSR $57FF
L4715:
  DEFB $20

; ($FF47 --> $57FF after conversion)
L4716:
  DEFW $FF57

; DEX
L4718:
  DEFB $CA

; BNE -13
L4719:
  DEFB $D0

; (-13, to DEY)
L471A:
  DEFB $F3

; LDX $46
L471B:
  DEFB $A6

; Data block at 18204
L471C:
  DEFB $46

; BNE -20
L471D:
  DEFB $D0

; (-20, to "LDA $C030")
L471E:
  DEFB $EC

; BEQ -22
L471F:
  DEFB $F0

; (-22, to "LDA $C030")
L4720:
  DEFB $EA

; RTS
L4721:
  DEFB $60

; On the Apple2 GBASIC WAIT monitors the status of an address rather than of an
; I/O port
__WAIT:
  CALL FPSINT_0
  PUSH DE
  CALL SYNCHR

; Message at 18217
L4729:
  DEFM ","

; Routine at 18218
L472A:
  CALL GETINT
  PUSH AF
  LD E,$00
  JR Z,L4736_0
  CALL SYNCHR

; Message at 18229
L4735:
  DEFM ","

; Routine at 18230
L4736:
  CALL GETINT
; This entry point is used by the routine at L472A.
L4736_0:
  POP AF
  LD D,A
  EX (SP),HL
L4736_1:
  LD A,(HL)
  XOR E
  AND D
  JR Z,L4736_1
  POP HL
  RET

; paddle
__PDL:
  CALL CONINT
  LD A,E
  CP $04
; This entry point is used by the routine at __BUTTON.
__PDL_0:
  JP NC,FC_ERR
  LD (F046_REG_X),A
  PUSH HL
  LD HL,$FB1E
  CALL GO_6502
  POP HL
  LD A,(F047_REG_Y)
  JP PASSA

; Routine at 18269
;
; Used by the routine at NTVARP.
FN_SCRN:
  CALL CHRGTB
  CALL SYNCHR

; Message at 18275
L4763:
  DEFM "("

; Routine at 18276
L4764:
  CALL PLOT_ARGS
  CALL SYNCHR

; Message at 18282
L476A:
  DEFM ")"

; Routine at 18283
L476B:
  PUSH HL
  LD HL,$F871
  CALL GO_6502
  LD A,(F045_REG_A)
  JP EXIT_FN_0

; Routine at 18296
;
; Used by the routine at NTVARP.
FN_COLOR:
  CALL CHRGTB
  LD A,(LF030)
  AND $0F
  JP EXIT_FN

; Routine at 18307
;
; Used by the routine at __CALL.
__CALL_6502:
  LD HL,F045_REG_A
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  POP HL
  CALL __CHRCKB
  JR Z,L47BE
  CALL SYNCHR

; Message at 18325
L4795:
  DEFM "("

; Routine at 18326
L4796:
  LD DE,F045_REG_A
  LD B,$03
; This entry point is used by the routine at L47A8.
L4796_0:
  LD A,(HL)
  CP $29
  JR Z,L47A8_2
  CP ','
  JR NZ,L47A8_0
  CALL CHRGTB
  JR L47A8_1

; Routine at 18344
L47A8:
  RRCA
; This entry point is used by the routine at L4796.
L47A8_0:
  PUSH BC
  PUSH DE
  CALL GETINT
  POP DE
  POP BC
  LD (DE),A
  INC DE
  LD A,(HL)
  CP ','
  CALL Z,CHRGTB
; This entry point is used by the routine at L4796.
L47A8_1:
  DJNZ L4796_0
; This entry point is used by the routine at L4796.
L47A8_2:
  CALL SYNCHR

; Message at 18365
L47BD:
  DEFM ")"

; Routine at 18366
;
; Used by the routine at __CALL_6502.
L47BE:
  PUSH HL
  LD HL,(INTFLG)
  JP CALL_6502_POPHL

; Routine at 18372
L47C4:
  LD B,(HL)

; Routine at 18373
;
; Used by the routines at __GR and __HGR.
GFX_MODE:
  PUSH HL
  LD (LE050),A
  LD HL,LE053
  RRA
  LD D,$28
  JR NC,MIX_MODE
  DEC L
  LD D,$30

; Routine at 18388
;
; Used by the routine at GFX_MODE.
MIX_MODE:
  LD (HL),L
  POP HL
  LD A,(HL)
  CP ','
  RET

; Data block at 18394
A2_HCOLOR:
  DEFB $00

; Data block at 18395
A2_HCOLOR_PATTERN:
  DEFW $0000

; Data block at 18397
L47DD:
  DEFW $8081

; Data block at 18399
A2_HADDR:
  DEFW _HIRES_PAGE

; HRG pixel mask/position, only LSB used
A2_HPIXEL:
  DEFW $0000

; 128-byte video memory segment (we have 8 in HRG)
A2_HSEGMENT:
  DEFB $00

; Data block at 18403
L47E3:
  DEFW $0000

; Data block at 18405
L47E5:
  DEFB $00

; Routine at 18406
;
; Used by the routine at NTVARP.
FN_HCOLOR:
  CALL CHRGTB
  LD A,(A2_HCOLOR)
  JP EXIT_FN

; Routine at 18415
;
; Used by the routine at NTVARP.
FN_HSCRN:
  CALL CHRGTB
  CALL SYNCHR

; Message at 18421
L47F5:
  DEFM "("

; Routine at 18422
L47F6:
  CALL SCAND
  CALL SYNCHR

; Message at 18428
L47FC:
  DEFM ")"

; Routine at 18429
L47FD:
  PUSH HL

; LD HL,(L47DD)
L47FE:
  DEFB $2A

; Used by BEEP?  $57FF
L47FF:
  DEFW L47DD

; Routine at 18433
L4801:
  PUSH HL
  LD HL,(A2_HADDR)
  PUSH HL
  LD HL,(A2_HPIXEL)
  PUSH HL
  LD HL,L4819
  PUSH HL
  PUSH HL
  LD HL,COLOR_MAP_2
  LD (A2_COLOR_MAP),HL
  LD A,C
  JP MAPXY_0

; Routine at 18457
L4819:
  CALL RELPOS_DIFF
  EXX
  BIT 0,L
  JR NZ,L4819_0
  LD B,C
  NOP
L4819_0:
  LD A,(HL)
  AND B
  ADD A,A
  JR Z,L4819_1
  LD A,$FF
L4819_1:
  CALL __BUTTON_0
  POP HL
  LD (A2_HPIXEL),HL
  POP HL
  LD (A2_HADDR),HL
  POP HL
  LD (L47DD),HL
  POP HL
  RET

; Routine at 18491
__HCOLOR:
  CALL SYNCHR

; Message at 18494
L483E:
  DEFB $F0

; Routine at 18495
L483F:
  CALL GETINT

; Routine at 18498
;
; Used by the routine at __HGR.
SET_HCOLOR:
  CP $0D
  JP NC,FC_ERR
  LD (A2_HCOLOR),A
  PUSH HL
  CP $08
  JR NC,SET_HCOLOR_0
  LD HL,COLOR_PATTERNS
  ADD A,A
  LD E,A
  LD D,$00
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  JR SET_HCOLOR_3
SET_HCOLOR_0:
  CP $0C
  JR Z,SET_HCOLOR_5
  CP $0A
  JR NC,SET_HCOLOR_1
  RRA
  SBC A,A
  AND $7F
  JR SET_HCOLOR_2
SET_HCOLOR_1:
  RRA
  SBC A,A
  SET 7,A
SET_HCOLOR_2:
  LD H,A
  LD L,A
SET_HCOLOR_3:
  LD (A2_HCOLOR_PATTERN),HL
  LD HL,HPLOT_PATH_A
  LD (HCOLOR_SMC),HL
SET_HCOLOR_4:
  CALL CONVERT_COLOR
  JP MAPXY_2
SET_HCOLOR_5:
  LD HL,HPLOT_PATH_C
  LD (HCOLOR_SMC),HL
  JR SET_HCOLOR_4

; Routine at 18568
;
; Used by the routines at L4958 and __HPLOT.
DO_HPLOT:
  EXX
  BIT 0,L

; CALL..
CALL_HPLOT_SMC:
  DEFB $C3

; Data block at 18572
HCOLOR_SMC:
  DEFW HPLOT_PATH_A

; Routine at 18574
HPLOT_PATH_A:
  JP NZ,HPLOT_PATH_B
  LD A,C
  ADD A,A
  JP Z,HPLOT_PATH_A_0
  LD A,(HL)
  XOR E
  AND C
  XOR (HL)
  LD (HL),A
  LD A,B
  ADD A,A
  JP Z,HPLOT_END
HPLOT_PATH_A_0:
  INC L
  LD A,(HL)
  XOR D
  AND B
  XOR (HL)
  LD (HL),A
  DEC L
  EXX
  RET

; Routine at 18601
;
; Used by the routine at HPLOT_PATH_A.
HPLOT_PATH_B:
  LD A,B
  ADD A,A
  JP Z,HPLOT_PATH_B_0
  LD A,(HL)
  XOR D
  AND B
  XOR (HL)
  LD (HL),A
  LD A,C
  ADD A,A
  JP Z,HPLOT_END
HPLOT_PATH_B_0:
  INC L
  LD A,(HL)
  XOR E
  AND C
  XOR (HL)
  LD (HL),A
  DEC L

; Routine at 18623
;
; Used by the routines at HPLOT_PATH_A, HPLOT_PATH_B, HPLOT_PATH_C and
; HPLOT_PATH_D.
HPLOT_END:
  EXX
  RET

; Routine at 18625
HPLOT_PATH_C:
  JP NZ,HPLOT_PATH_D
  LD A,C
  ADD A,A
  JP Z,HPLOT_PATH_C_0
  LD A,C
  AND $7F
  XOR (HL)
  LD (HL),A
  LD A,B
  ADD A,A
  JP Z,HPLOT_END
HPLOT_PATH_C_0:
  INC L
  AND $7F
  XOR (HL)
  LD (HL),A
  DEC L
  EXX
  RET

; Routine at 18651
;
; Used by the routine at HPLOT_PATH_C.
HPLOT_PATH_D:
  LD A,B
  ADD A,A
  JP Z,HPLOT_PATH_D_0
  LD A,B
  AND $7F
  XOR (HL)
  LD (HL),A
  LD A,C
  ADD A,A
  JP Z,HPLOT_END
HPLOT_PATH_D_0:
  INC L
  LD A,C
  AND $7F
  XOR B
  LD (HL),A
  DEC L
  EXX
  RET

; Routine at 18675
;
; Used by the routine at __HPLOT.
HPLOT_SUB:
  CALL CONVERT_COLOR
  LD A,(L47E5)
  LD HL,L49FD
  SUB C
  JR NC,HPLOT_SUB_0
  CPL
  INC A
  LD HL,L4A1B
HPLOT_SUB_0:
  PUSH HL
  PUSH AF
  LD A,C
  LD (L47E5),A
  LD HL,(L47E3)
  EX DE,HL
  LD (L47E3),HL
  OR A
  SBC HL,DE
  JR NC,HPLOT_SUB_1
  ADD HL,DE
  EX DE,HL
  OR A
  SBC HL,DE
  LD DE,L4A4E
  JR HPLOT_SUB_2
HPLOT_SUB_1:
  LD DE,L4A65
HPLOT_SUB_2:
  POP BC
  LD A,H
  OR A
  LD A,B
  JR NZ,L493B
  CP L
  JR C,L493B
  EX (SP),HL
  LD (SMC_L4956),HL
  EX DE,HL
  LD (SMC_L4967),HL
  LD L,A
  LD H,$00
  POP DE
  PUSH HL
  JR L493B_0

; Routine at 18747
;
; Used by the routine at HPLOT_SUB.
L493B:
  EX (SP),HL
  LD (SMC_L4967),HL
  EX DE,HL
  LD (SMC_L4956),HL
  LD E,A
  LD D,$00
; This entry point is used by the routine at HPLOT_SUB.
L493B_0:
  POP HL
  LD (SMC_L496C),HL
  LD B,H
  LD C,L
  INC BC
  OR A
  RR H
  RR L
  JR L4958_0

; Routine at 18772
;
; Used by the routines at L4958 and L496E.
L4954:
  EXX

; CALL..
L4955:
  DEFB $CD

; Data block at 18774
SMC_L4956:
  DEFW L4A1B

; Routine at 18776
L4958:
  EXX
  CALL DO_HPLOT
; This entry point is used by the routine at L493B.
L4958_0:
  DEC BC
  LD A,B
  OR C
  RET Z
  AND A
  SBC HL,DE
  JR NC,L4954
  EXX

; CALL..
L4966:
  DEFB $CD

; Data block at 18791
SMC_L4967:
  DEFW L4A65

; Routine at 18793
L4969:
  EXX
  PUSH DE

; LD DE,..
L496B:
  DEFB $11

; Data block at 18796
SMC_L496C:
  DEFW $0000

; Routine at 18798
L496E:
  ADD HL,DE
  POP DE
  JP L4954

; Routine at 18803
;
; Used by the routine at __HPLOT.
MAPXY:
  PUSH HL
  CALL CONVERT_COLOR
  EX DE,HL
  LD (L47E3),HL
  EX DE,HL
  LD A,C
  LD (L47E5),A
; This entry point is used by the routine at L4801.
MAPXY_0:
  AND $C0
  LD L,A
  RRA
  RRA
  OR L
  LD L,A
  LD A,C
  ADD A,A
  ADD A,A
  LD H,A
  ADD A,A
  RLA
  RLA
  RR L
  OR H
  AND $1F
  ADD A,$10
  LD H,A
  LD (A2_HADDR),HL
  EX DE,HL
  CALL L49AD_1
  SUB $07
  JR C,MAPXY_1
  INC B
MAPXY_1:
  LD A,B
  LD (A2_HSEGMENT),A
; This entry point is used by the routine at SET_HCOLOR.
MAPXY_2:
  LD A,(A2_HPIXEL)
  LD C,A

; Data block at 18858
L49AA:
  DEFB $21

; Data block at 18859
A2_COLOR_MAP:
  DEFW $0000

; Routine at 18861
L49AD:
  PUSH HL
  LD B,$00
  ADD HL,BC
  LD E,(HL)
  LD A,C
  POP HL
  ADD A,$07
  LD C,A
  SUB $0E
  JR C,L49AD_0
  LD C,A
L49AD_0:
  ADD HL,BC
  LD D,(HL)
  EX DE,HL
  LD (L47DD),HL
  POP HL
  RET
; This entry point is used by the routines at MAPXY and __HPLOT.
L49AD_1:
  LD DE,$FFF2
  LD A,D
L49AD_2:
  INC A
  ADD HL,DE
  JR C,L49AD_2
  ADD A,A
  LD B,A
  LD A,L
  ADD A,$0E
  LD (A2_HPIXEL),A
  RET

; Use the alternate register set (EXX) to compute relative position (PLOT TO..)
;
; Used by the routine at __HPLOT.
RELPOS:
  EXX
  LD HL,COLOR_MAP_2
  LD D,$00
  LD A,(A2_HPIXEL)
  SUB $07
  JR NC,RELPOS_0
  ADD A,$07
RELPOS_0:
  LD E,A
  ADD HL,DE
  LD A,(HL)
  AND $7F
  EX AF,AF'

; Use the alternate register set (EXX) to compute relative position (PLOT TO..)
;
; Used by the routine at L4819.
RELPOS_DIFF:
  LD HL,(L47DD)
  LD C,L
  LD B,H
  LD HL,(A2_HCOLOR_PATTERN)
  EX DE,HL
  LD A,(A2_HSEGMENT)
  LD HL,(A2_HADDR)
  ADD A,L
  LD L,A
  EXX
  RET

; Routine at 18941
L49FD:
  LD A,L
  LD HL,(A2_HADDR)
  SUB L
  PUSH AF
  LD A,H
  SUB $14
  JR NC,L4A44
  RL L
  RLA
  DEC A
  BIT 3,A
  JR NZ,L4A3A
  LD H,$2F
  SCF
  LD A,L
  RRA
  SUB $28
  LD L,A
  JP L4A44_1

; Routine at 18971
L4A1B:
  LD A,L
  LD HL,(A2_HADDR)
  SUB L
  PUSH AF
  LD A,H
  SUB $0C
  BIT 5,A
  JR Z,L4A44
  RL L
  RLA
  INC A
  BIT 3,A
  JR Z,L4A3A_0
  LD H,$10
  LD A,L
  RRA
  ADD A,$28
  LD L,A
  JP L4A44_1

; Routine at 19002
;
; Used by the routine at L49FD.
L4A3A:
  AND $3F
; This entry point is used by the routine at L4A1B.
L4A3A_0:
  XOR $60
  RRA
  RR L
  JP L4A44_0

; Routine at 19012
;
; Used by the routines at L49FD and L4A1B.
L4A44:
  ADD A,$10
; This entry point is used by the routine at L4A3A.
L4A44_0:
  LD H,A
; This entry point is used by the routines at L49FD and L4A1B.
L4A44_1:
  LD (A2_HADDR),HL
  POP AF
  ADD A,L
  LD L,A
  RET

; Routine at 19022
L4A4E:
  EX AF,AF'
  RRCA
  JP NC,L4A4E_0
  DEC L
  RRCA
L4A4E_0:
  EX AF,AF'
  SCF
  RR B
  JP C,L4A4E_1
  RES 7,C
L4A4E_1:
  SCF
  RR C
  RET C
  RES 6,B
  RET

; Routine at 19045
L4A65:
  EX AF,AF'
  ADD A,A
  JP P,L4A65_0
  INC L
  RLCA
L4A65_0:
  EX AF,AF'
  SCF
  BIT 6,B
  JP NZ,L4A65_1
  OR A
L4A65_1:
  RL C
  JP M,L4A65_2
  OR A
  SET 7,C
L4A65_2:
  RL B
  SET 7,B
  RET

; Data block at 19073
COLOR_PATTERNS:
  DEFB $00,$00,$2A,$55,$55,$2A,$7F,$7F
  DEFB $80,$80,$AA,$D5,$D5,$AA,$FF,$FF

; Routine at 19089
;
; Used by the routines at SET_HCOLOR, HPLOT_SUB and MAPXY.
CONVERT_COLOR:
  LD A,(A2_HCOLOR)
  LD HL,COLOR_MAP_2
  CP $0C
  JR Z,CONVERT_COLOR_2
  CP $08
  JR NC,CONVERT_COLOR_0
  AND $03
  JR Z,CONVERT_COLOR_2
  CP $03
  JR Z,CONVERT_COLOR_2
CONVERT_COLOR_0:
  LD HL,$FEE9
  AND A
  ADC HL,DE
  JR NZ,CONVERT_COLOR_1
  DEC DE
CONVERT_COLOR_1:
  LD HL,COLOR_MAP_1
CONVERT_COLOR_2:
  LD (A2_COLOR_MAP),HL
  RET

; Data block at 19127
COLOR_MAP_1:
  DEFB $83,$86,$8C,$98,$B0,$E0,$C0,$80
  DEFB $80,$80,$80,$80,$80,$81

; Data block at 19141
COLOR_MAP_2:
  DEFB $81,$82,$84,$88,$90,$A0,$C0,$80
  DEFB $80,$80,$80,$80,$80,$80,$80

; Routine at 19156
__HGR:
  LD A,$00
  CALL NZ,GETINT
  CP $04
; This entry point is used by the routines at SCAND and L4B30.
SCAND_FCERR:
  JP NC,FC_ERR
  LD (LE057),A
  PUSH AF
  CALL GFX_MODE
  LD A,$00
  JR NZ,__HGR_0
  INC HL
  CALL GETINT
__HGR_0:
  PUSH AF
  CALL SET_HCOLOR
  POP BC
  POP AF
  AND $02
  RET NZ
  LD A,B
  CP $0C
  JR Z,__HGR_1
  PUSH HL
  LD HL,_HIRES_PAGE
  LD HL,(A2_HCOLOR_PATTERN)
  LD (_HIRES_PAGE),HL
  LD HL,_HIRES_PAGE
  LD DE,$1002
  LD BC,$1FFE
  LDIR
  POP HL
  RET
__HGR_1:
  LD DE,_HIRES_PAGE
__HGR_2:
  LD A,(DE)
  XOR $7F
  LD (DE),A
  INC DE
  LD A,D
  CP $30
  JR NZ,__HGR_2
  RET

; Get coordinates in DE,BC - check for boundaries (280,192)
;
; Used by the routines at L47F6 and __HPLOT.
SCAND:
  CALL FPSINT_0
  LD A,E
  CP $18
  LD A,D
  SBC A,$01
  JR NC,SCAND_FCERR
  PUSH DE
  CALL SYNCHR

; Message at 19247
L4B2F:
  DEFM ","

; Routine at 19248
L4B30:
  CALL GETINT
  CP $C0
  JR NC,SCAND_FCERR
  LD C,A
  POP DE
  RET

; Routine at 19258
__HPLOT:
  CP $DD
  JR NZ,__HPLOT_0
  CALL RELPOS
  JR __HPLOT_1
__HPLOT_0:
  CALL SCAND
  CALL MAPXY
  CALL RELPOS
  CALL DO_HPLOT
  CALL __CHRCKB
  RET Z
__HPLOT_1:
  CALL CHRGTB
  CALL SCAND
  PUSH HL
  CALL HPLOT_SUB
  POP HL
  LD A,(HL)
  CP $DD
  JR Z,__HPLOT_1
  EXX
  LD A,(A2_HADDR)
  SUB L
  CPL
  INC A
  LD (A2_HSEGMENT),A
  LD L,C
  LD H,B
  LD (L47DD),HL
  LD HL,(L47E3)
  CALL L49AD_1
  EXX
  RET

; Routine at 19322
L4B7A:
  LD E,$1F

; LD BC,..
L4B7C:
  DEFB $01

; Data block at 19325
 SMC_V1:
  DEFW $391E

; LD BC,..
L4B7F:
  DEFB $01

; Data block at 19328
 SMC_V2:
  DEFW $441E

; LD BC,..
L4B82:
  DEFB $01

; Data block at 19331
SMC_V3:
  DEFW $451E

; LD BC,..
L4B85:
  DEFB $01

; Data block at 19334
SMC_V4:
  DEFW $461E

; Routine at 19336
L4B88:
  JP L0C7B

; Routine at 19339
;
; Used by the routine at L0C7B.
L4B8B:
  LD A,($0004)
  LD E,A
  CALL CPMENT
  POP DE
  JP ERROR

; 0=TEXT, $FF=GRAPHICS
SCRMOD:
  DEFB $00

; Data block at 19351
L4B97:
  DEFB $50

; Routine at 19352
;
; Used by the routines at __CINT and FOUCD1.
FADDH:
  LD HL,FP_HALF

; Routine at 19355
;
; Used by the routines at __RND, __COS and __NEXT.
FADDS:
  CALL LOADFP
  JR FADD

; Routine at 19360
FSUBS:
  CALL LOADFP

; Formerly SUBCDE, Subtract BCDE from FP reg
;
; Used by the routines at __EXP and __SIN.
FSUB:
  CALL NEG

; a.k.a. FPADD, Add BCDE to FP reg
;
; Used by the routines at GETWORD_HL, FADDS, __LOG, MLSP10, FINDG4, SUMLP and
; __SIN.
FADD:
  LD A,B
  OR A
  RET Z
  LD A,(FPEXP)
  OR A
  JP Z,FPBCDE
  SUB B
  JR NC,FADD_0
  CPL
  INC A
  EX DE,HL
  CALL PUSHF
  EX DE,HL
  CALL FPBCDE
  POP BC
  POP DE
FADD_0:
  CP $19
  RET NC
  PUSH AF
  CALL UNPACK
  LD H,A
  POP AF
  CALL COMPL_0
  LD A,H
  OR A
  LD HL,FACCU
  JP P,FADD_1
  CALL PLUCDE
  JP NC,BNORM_8
  INC HL
  INC (HL)
  JP Z,OVERR_1
  LD L,$01
  CALL COMPL_5
  JR BNORM_8
FADD_1:
  XOR A
  SUB B
  LD B,A
  LD A,(HL)
  SBC A,E
  LD E,A
  INC HL
  LD A,(HL)
  SBC A,D
  LD D,A
  INC HL
  LD A,(HL)
  SBC A,C
  LD C,A
; This entry point is used by the routines at FLOAT and INT.
FADD_2:
  CALL C,COMPL

; Routine at 19446
;
; Used by the routine at __RND.
BNORM:
  LD L,B
  LD H,E
  XOR A
BNORM_0:
  LD B,A
  LD A,C
  OR A
  JR NZ,BNORM_6
  LD C,D
  LD D,H
  LD H,L
  LD L,A
  LD A,B
  SUB $08
  CP $E0
  JR NZ,BNORM_0
; This entry point is used by the routines at FDIV, DADD, DMUL, DECF1, DDIV,
; FIN_DBL and __EXP.
ZERO:
  XOR A
; This entry point is used by the routine at POWER.
BNORM_2:
  LD (FPEXP),A
  RET
BNORM_3:
  LD A,H
  OR L
  OR D
  JR NZ,BNORM_5
  LD A,C
BNORM_4:
  DEC B
  RLA
  JR NC,BNORM_4
  INC B
  RRA
  LD C,A
  JR BNORM_7
BNORM_5:
  DEC B
  ADD HL,HL
  LD A,D
  RLA
  LD D,A
  LD A,C
  ADC A,A
  LD C,A
BNORM_6:
  JP P,BNORM_3
BNORM_7:
  LD A,B
  LD E,H
  LD B,L
  OR A
  JR Z,BNORM_8
  LD HL,FPEXP
  ADD A,(HL)
  LD (HL),A
  JR NC,ZERO
  JP Z,ZERO
; This entry point is used by the routines at FADD and __CSNG.
BNORM_8:
  LD A,B
; This entry point is used by the routine at FDIV.
BNORM_9:
  LD HL,FPEXP
  OR A
  CALL M,ZERO0
  LD B,(HL)
  INC HL
  LD A,(HL)
  AND $80
  XOR C
  LD C,A
  JP FPBCDE
; This entry point is used by the routine at QINT.
ZERO0:
  INC E
  RET NZ
  INC D
  RET NZ
  INC C
  RET NZ
  LD C,$80
  INC (HL)
  RET NZ
  JP OVERR_0

; Add number pointed by HL to CDE
;
; Used by the routines at FADD and FOUCS1.
PLUCDE:
  LD A,(HL)
  ADD A,E
  LD E,A
  INC HL
  LD A,(HL)
  ADC A,D
  LD D,A
  INC HL
  LD A,(HL)
  ADC A,C
  LD C,A
  RET

; Convert a negative number to positive
;
; Used by the routines at FADD and QINT.
COMPL:
  LD HL,SGNRES
  LD A,(HL)
  CPL
  LD (HL),A
  XOR A
  LD L,A
  SUB B
  LD B,A
  LD A,L
  SBC A,E
  LD E,A
  LD A,L
  SBC A,D
  LD D,A
  LD A,L
  SBC A,C
  LD C,A
  RET
; This entry point is used by the routines at FADD and QINT.
COMPL_0:
  LD B,$00
COMPL_1:
  SUB $08
  JR C,COMPL_2
  LD B,E
  LD E,D
  LD D,C
  LD C,$00
  JR COMPL_1
COMPL_2:
  ADD A,$09
  LD L,A
  LD A,D
  OR E
  OR B
  JR NZ,COMPL_4
  LD A,C
COMPL_3:
  DEC L
  RET Z
  RRA
  LD C,A
  JR NC,COMPL_3
  JR COMPL_6
COMPL_4:
  XOR A
  DEC L
  RET Z
  LD A,C
; This entry point is used by the routine at FADD.
COMPL_5:
  RRA
  LD C,A
COMPL_6:
  LD A,D
  RRA
  LD D,A
  LD A,E
  RRA
  LD E,A
  LD A,B
  RRA
  LD B,A
  JR COMPL_4

; Data block at 19622
FP_UNITY:
  DEFB $00,$00,$00,$81

; Data block at 19626
FP_LOGTAB_P:
  DEFB $04,$9A,$F7,$19,$83,$24,$63,$43
  DEFB $83,$75,$CD,$8D,$84,$A9,$7F,$83
  DEFB $82

; Data block at 19643
FP_LOGTAB_Q:
  DEFB $04,$00,$00,$00,$81,$E2,$B0,$4D
  DEFB $83,$0A,$72,$11,$83,$F4,$04,$35
  DEFB $7F

; LOG
;
; Used by the routine at POWER.
__LOG:
  CALL SIGN
  OR A
  JP PE,FC_ERR
  CALL __LOG_0
  LD BC,$8031
  LD DE,$7218
  JP FMULT
__LOG_0:
  CALL BCDEFP
  LD A,$80
  LD (FPEXP),A
  XOR B
  PUSH AF
  CALL PUSHF
  LD HL,FP_LOGTAB_P
  CALL POLY_0
  POP BC
  POP HL
  CALL PUSHF
  EX DE,HL
  CALL FPBCDE
  LD HL,FP_LOGTAB_Q
  CALL POLY_0
  POP BC
  POP DE
  CALL FDIV
  POP AF
  CALL PUSHF
  CALL FLOAT
  POP BC
  POP DE
  JP FADD

; MULTIPLICATION, FAC:=ARG*FAC
;
; Used by the routines at __LOG, FMULTT, EXP, __EXP, SUMSER, SUMLP, __RND and
; __SIN.
FMULT:
  CALL SIGN
  RET Z
  LD L,$00
  CALL ADDEXP
  LD A,C
  LD (MULVAL),A
  EX DE,HL
  LD (MULVAL2),HL
  LD BC,$0000
  LD D,B
  LD E,B
  LD HL,BNORM
  PUSH HL
  LD HL,MULT8
  PUSH HL
  PUSH HL
  LD HL,FACCU

; Routine at 19764
MULT8:
  LD A,(HL)
  INC HL
  OR A
  JR Z,BYTSFT
  PUSH HL
  EX DE,HL
  LD E,$08
; This entry point is used by the routine at NOMADD.
MULT8_0:
  RRA
  LD D,A
  LD A,C
  JR NC,NOMADD
  PUSH DE

; LD DE,..
L4D43:
  DEFB $11

; Data block at 19780
MULVAL2:
  DEFW $0000

; Routine at 19782
L4D46:
  ADD HL,DE
  POP DE

; ADC A,..
L4D48:
  DEFB $CE

; Data block at 19785
MULVAL:
  DEFB $00

; Routine at 19786
;
; Used by the routine at MULT8.
NOMADD:
  RRA
  LD C,A
  LD A,H
  RRA
  LD H,A
  LD A,L
  RRA
  LD L,A
  LD A,B
  RRA
  LD B,A
  AND $10
  JP Z,NOMADD_0
  LD A,B
  OR $20
  LD B,A
NOMADD_0:
  DEC E
  LD A,D
  JR NZ,MULT8_0
  EX DE,HL
; This entry point is used by the routines at FDIV, FNDARY, EDIT_REMOVE and
; L670C.
POPHLRT:
  POP HL
  RET

; This entry point is used by the routine at MULT8.
BYTSFT:
  LD B,E
  LD E,D
  LD D,C
  LD C,A
  RET

; Divide FP by 10
;
; Used by the routine at FINDIV.
DIV10:
  CALL PUSHF
  LD HL,FP_TEN
  CALL MOVFM

; Divide FP by number on stack
;
; Used by the routines at IDIV and __TAN.
DIV:
  POP BC
  POP DE




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
;  JP Z,OVFIN1             ; BUGFIX
  INC (HL)
;  JP Z,OVFIN1             ; BUGFIX

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

FDIV_0:
  PUSH HL                 ;SAVE LO'S OF NUMBER
  PUSH BC                 ;SAVE HO OF NUMBER
  LD A,L                  ;SUBTRACT NUMBER THAT WAS IN FAC

  DEFB $D6                ; SUB n,   ;SUBTRACT LO
DIV1:
  DEFB $00

  LD L,A                  ;SAVE IT
  LD A,H                  ;SUBTRACT MIDDLE ORDER

  DEFB $DE                ; SBC A,n
DIV2:
  DEFB $00

  LD H,A
  LD A,B                  ;SUBTRACT HO

  DEFB $DE                ; SBC A,n
DIV3:
  DEFB $00

;-------
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
  JP Z,FDIV_1             ;IF NOT IGNORE
  LD A,$20                ;ST BIT

FDIV_1:
  POP HL                  ;AND THE REST OF REMAINDER
  OR H                    ;"OR" IN REST
  JP BNORM_9              ;USE REMAINDER

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
  LD HL,ARG-1
  LD C,(HL)
  INC HL
  XOR (HL)
  LD B,A
  LD L,$00
; This entry point is used by the routine at FMULT.
ADDEXP:
  LD A,B
  OR A
  JR Z,FDIV_7
  LD A,L
  LD HL,FPEXP
  XOR (HL)
  ADD A,B
  LD B,A
  RRA
  XOR B
  LD A,B
  JP P,DIV_OVTST2
  ADD A,$80
  LD (HL),A
  JP Z,POPHLRT
  CALL UNPACK
  LD (HL),A
; This entry point is used by the routines at FOUTTD and FFXXVS.
FDIV_5:
  DEC HL
  RET
  CALL SIGN
  CPL
  POP HL
DIV_OVTST2:
  OR A
FDIV_7:
  POP HL
  JP P,ZERO
  JP OVFIN1

; Multiply number in FPREG by 10
;
; Used by the routines at MULTEN and FINDGE.
MLSP10:
  CALL BCDEFP
  LD A,B
  OR A
  RET Z
  ADD A,$02
  JP C,OVERR
  LD B,A
  CALL FADD
  LD HL,FPEXP
  INC (HL)
  RET NZ
  JP OVERR

; Test sign of FPREG
;
; Used by the routines at FORFND_SNG, __LOG, FMULT, FDIV, VSIGN, FCOMP, XDCOMP,
; __FIX, DMUL, FFXSDC, FFXXVS, POWER, __RND, __SIN and __ATN.
SIGN:
  LD A,(FPEXP)
  OR A
  RET Z
  LD A,(FACCU+2)
  DEFB $FE                ; CP 2Fh ..hides the "CPL" instruction       ;"CPI" AROUND NEXT BYTE

; Routine at 20048
;
; Used by the routine at DCOMP.
FCOMPS:
  CPL

; Routine at 20049
;
; Used by the routines at VSIGN and ICOMP.
ICOMPS:
  RLA

; Routine at 20050
;
; Used by the routines at ICOMP and STRCMP.
SIGNS:
  SBC A,A
  RET NZ
  INC A
  RET

; a.k.a. FLGREL, Float the signed integer in A (CY and A to FP, & normalise)
;
; Used by the routines at __LOG, FINDGE and FINDG4.
FLOAT:
  LD B,$88
  LD DE,$0000
; This entry point is used by the routines at HLPASS and INEG.
FLOAT_0:
  LD HL,FPEXP
  LD C,A
  LD (HL),B
  LD B,$00
  INC HL
  LD (HL),$80
  RLA
  JP FADD_2

; Absolute value
__ABS:
  CALL VSIGN
  RET P

; Invert number sign
;
; Used by the routines at MINUS, __FIX, FINE and PUFOUT.
INVSGN:
  CALL GETYPR
  JP M,INEG
  JP Z,TM_ERR

; Invert number sign
;
; Used by the routines at FSUB, __FIX, FMULTT, POWER, __SIN and __ATN.
NEG:
  LD HL,FACCU+2
  LD A,(HL)
  XOR $80
  LD (HL),A
  RET

; Routine at 20094
__SGN:
  CALL VSIGN

; Get back from function, result in A (signed)
;
; Used by the routines at DOCMP and __EOF.
CONIA:
  LD L,A
  RLA
  SBC A,A
  LD H,A
  JP MAKINT

; Test sign in number
;
; Used by the routines at L3715, __ABS, __SGN, PUFOUT and __WEND.
VSIGN:
  CALL GETYPR
  JP Z,TM_ERR
  JP P,SIGN
  LD HL,(FACCU)
; This entry point is used by the routine at L32F3.
ISIGN:
  LD A,H
  OR L
  RET Z
  LD A,H
  JR ICOMPS

; a.k.a. STAKFP, Put FP value on stack
;
; Used by the routines at LOPREL, EVAL_FP, IDIV, FADD, __LOG, DIV10, IADD,
; IMLDIV, FINDG4, FOUFRV, __SQR, __EXP, SUMSER, POLY, __SIN and __TAN.
PUSHF:
  EX DE,HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  LD HL,(FACCU+2)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  RET

; a.k.a. PHLTFP, Number at HL to BCDE
;
; Used by the routines at DIV10, FOUCD1, __SQR, POLY, SUMLP, __RND and __NEXT.
MOVFM:
  CALL LOADFP

; Move BCDE to FPREG
;
; Used by the routines at STKDBL, FADD, BNORM, __LOG, FOUFRV, FOUCD1, FOUCS1,
; GET_UNITY and __TAN.
FPBCDE:
  EX DE,HL
  LD (FACCU),HL
  LD H,B
  LD L,C
  LD (FACCU+2),HL
  EX DE,HL
  RET

; Load FP reg to BCDE
;
; Used by the routines at FORFND_SNG, EVAL_FP, __LOG, MLSP10, __CSNG, QINT,
; INT, FOUCS1, POWER, SUMSER and __RND.
BCDEFP:
  LD HL,FACCU

; Load FP value pointed by HL to BCDE
;
; Used by the routines at FADDS, FSUBS, MOVFM, SUMLP, __RND and __NEXT.
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

; label=INCHL
;
; Used by the routines at GETCMD, CONLIN, FOUFRF, SUPTLZ and FFXXVS.
INCHL:
  INC HL
  RET
; This entry point is used by the routines at L329B, __RND and __NEXT.
FPTHL:
  LD DE,FACCU
; This entry point is used by the routines at OVERR and RUN_FST.
INCHL_1:
  LD B,$04
  JR MOVE1

; Routine at 20168
MOVVFM:
  EX DE,HL

; Routine at 20169
;
; Used by the routines at CRESTR, CMPPHL, DDIV10, FORBIG, __SWAP, L69DC, TSTOPL
; and L6F67.
VMOVE:
  LD A,(VALTYP)
  LD B,A
; This entry point is used by the routines at __CHRCKB, INCHL and CDVARS.
MOVE1:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DJNZ MOVE1
  RET

; Routine at 20180
;
; Used by the routines at FADD, FDIV, __CSNG, QINT, INT and DADD.
UNPACK:
  LD HL,FACCU+2
  LD A,(HL)
  RLCA
  SCF
  RRA
  LD (HL),A
  CCF
  RRA
  INC HL
  INC HL
  LD (HL),A
  LD A,C
  RLCA
  SCF
  RRA
  LD C,A
  RRA
  XOR (HL)
  RET

; Routine at 20201
;
; Used by the routine at DADD.
VMOVFA:
  LD HL,FPARG

; Routine at 20204
;
; Used by the routines at CONFDB, EVAL_VARIABLE, POPASG, __CINT, FOUTCV, __CALL
; and __CVD.
VMOVFM:
  LD DE,MOVVFM
  JR VMVVFM

; Routine at 20209
;
; Used by the routines at STKDBL, FACDBL, __CINT, DMUL10, FINDGE and FOUTCV.
VMOVAF:
  LD HL,FPARG

; Routine at 20212
;
; Used by the routines at ASGMOR and __MKD_S.
VMOVMF:
  LD DE,VMOVE

; Routine at 20215
;
; Used by the routine at VMOVFM.
VMVVFM:
  PUSH DE
  LD DE,FACCU
  CALL GETYPR
  RET C
  LD DE,FACLOW
  RET

; Compare FP reg to BCDE
;
; Used by the routines at MAKINT, FINDGE, FFXSFX, SIXDIG, RNGTST, POWER, __SIN
; and __NEXT.
FCOMP:
  LD A,B
  OR A
  JP Z,SIGN
  LD HL,FCOMPS
  PUSH HL
  CALL SIGN
  LD A,C
  RET Z
  LD HL,FACCU+2
  XOR (HL)
  LD A,C
  RET M
  CALL CMPFP

; Routine at 20250
;
; Used by the routine at XDCOMP.
FCOMPD:
  RRA
  XOR C
  RET

; Routine at 20253
;
; Used by the routine at FCOMP.
CMPFP:
  INC HL
  LD A,B
  CP (HL)
  RET NZ
  DEC HL
  LD A,C
  CP (HL)
  RET NZ
  DEC HL
  LD A,D
  CP (HL)
  RET NZ
  DEC HL
  LD A,E
  SUB (HL)
  RET NZ
  POP HL
  POP HL
  RET

; Compare the signed integer in DE to the signed integer in HL
;
; Used by the routine at __NEXT.
ICOMP:
  LD A,D
  XOR H
  LD A,H
  JP M,ICOMPS
  CP D
  JP NZ,SIGNS
  LD A,L
  SUB E
  JP NZ,SIGNS
  RET

; a.k.a. DCOMPD, COMPARE TWO DOUBLE PRECISION NUMBERS
;
; Used by the routines at FOUFXV, SIXDIG and RNGTST.
CMPPHL:
  LD HL,FPARG
  CALL VMOVE

; Routine at 20294
;
; Used by the routine at DCOMP.
XDCOMP:
  LD DE,ARG
  LD A,(DE)
  OR A
  JP Z,SIGN
  LD HL,FCOMPS
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
  JP NZ,FCOMPD
  DEC DE
  DEC HL
  DEC B
  JR NZ,XDCOMP_0
  POP BC
  RET

; Routine at 20335
DCOMP:
  CALL XDCOMP
  JP NZ,FCOMPS
  RET

; Routine at 20342
;
; Used by the routines at L32F3, LOPREL, __NOT, DANDOR, DEPINT, __RANDOMIZE and
; __CALL.
__CINT:
  CALL GETYPR
  LD HL,(FACCU)
  RET M
  JP Z,TM_ERR
  JP PO,__CINT_0
  CALL VMOVAF
  LD HL,DBL_FP_ZERO
  CALL VMOVFM
  CALL DADD
  CALL __CSNG_0
  JP __CINT_1
__CINT_0:
  CALL FADDH
__CINT_1:
  LD A,(FACCU+2)
  OR A
  PUSH AF
  AND $7F
  LD (FACCU+2),A
  LD A,(FPEXP)
  CP $90
  JP NC,OV_ERR
  CALL QINT
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
  JP MAKINT
  LD HL,OV_ERR
  PUSH HL
; This entry point is used by the routine at __INT.
__CINT_5:
  LD A,(FPEXP)
  CP $90
  JR NC,MAKINT_2
  CALL QINT
  EX DE,HL
; This entry point is used by the routines at MAKINT and IADD.
__CINT_6:
  POP DE

; Convert tmp string to int in A register
;
; Used by the routines at L3C68, OCTCNS, PASSA, __BUTTON, CONIA, __CINT, INT,
; IMULT, FMULTT, INEGA, INEGHL, FIN and LINPRT.
MAKINT:
  LD (FACCU),HL
; This entry point is used by the routine at INEG.
MAKINT_0:
  LD A,$02
; This entry point is used by the routine at VALSNG.
MAKINT_1:
  LD (VALTYP),A
  RET
; This entry point is used by the routines at __CINT and FINE.
MAKINT_2:
  LD BC,$9080
  LD DE,$0000
  CALL FCOMP
  RET NZ
  LD H,C
  LD L,D
  JR __CINT_6

; Routine at 20462
;
; Used by the routines at FORFND_SNG, LOPREL, FACDBL, OKNORM, DPOINT and POWER.
__CSNG:
  CALL GETYPR
  RET PO
  JP M,__CSNG_1
  JP Z,TM_ERR
; This entry point is used by the routine at __CINT.
__CSNG_0:
  CALL BCDEFP
  CALL VALSNG
  LD A,B
  OR A
  RET Z
  CALL UNPACK
  LD HL,$0CB0
  LD B,(HL)
  JP BNORM_8
; This entry point is used by the routines at __CDBL, FINDGE and FFXXVS.
__CSNG_1:
  LD HL,(FACCU)

; Routine at 20494
;
; Used by the routines at EVAL_FP, IDIV, IADD, IMLDIV and FMULTT.
HL_CSNG:
  CALL VALSNG

; Get back from function passing an INT value HL
HLPASS:
  LD A,H
  LD D,L
  LD E,$00
  LD B,$90
  JP FLOAT_0

; Routine at 20506
;
; Used by the routines at STKDBL, INT and DPOINT.
__CDBL:
  CALL GETYPR
  RET NC
  JP Z,TM_ERR
  CALL M,__CSNG_1
; This entry point is used by the routine at FINDGE.
__CDBL_0:
  LD HL,$0000
  LD (FACLOW),HL
  LD (FACLOW+2),HL

; Routine at 20525
;
; Used by the routine at FIN_DBL.
VALDBL:
  LD A,$08

; "LD BC,nn" to jump over the next word without executing it
L502F:
  DEFB $01

; Routine at 20528
;
; Used by the routines at __CSNG, HL_CSNG, INEG and SUMLP.
VALSNG:
  LD A,$04
  JP MAKINT_1

; Test a string, 'Type Error' if it is not
;
; Used by the routines at L388F, L3D64, __USING, ISSTRF, CONCAT, GETSTR, L6EF1,
; L6F67, LINE_INPUT, L7913 and __LSET.
TSTSTR:
  CALL GETYPR
  RET Z
  JP TM_ERR

; a.k.a. FPINT, Floating Point to Integer
;
; Used by the routines at __CINT, INT and FOUCD1.
QINT:
  LD B,A
  LD C,A
  LD D,A
  LD E,A
  OR A
  RET Z
  PUSH HL
  CALL BCDEFP
  CALL UNPACK
  XOR (HL)
  LD H,A
  CALL M,DCBCDE
  LD A,$98
  SUB B
  CALL COMPL_0
  LD A,H
  RLA
  CALL C,ZERO0
  LD B,$00
  CALL C,COMPL
  POP HL
  RET

; Decrement FP value in BCDE
;
; Used by the routine at QINT.
DCBCDE:
  DEC DE
  LD A,D
  AND E
  INC A
  RET NZ
; This entry point is used by the routine at FNDWRD.
DCBCDE_0:
  DEC BC
  RET

; Double Precision to Integer conversion
__FIX:
  CALL GETYPR
  RET M
  CALL SIGN
  JP P,__INT
  CALL NEG
  CALL __INT
  JP INVSGN

; Routine at 20602
;
; Used by the routine at __FIX.
__INT:
  CALL GETYPR
  RET M
  JR NC,INT_0
  JP Z,TM_ERR
  CALL __CINT_5

; INT
;
; Used by the routines at POWER, __EXP and __SIN.
INT:
  LD HL,FPEXP
  LD A,(HL)
  CP $98
  LD A,(FACCU)
  RET NC
  LD A,(HL)
  CALL QINT
  LD (HL),$98
  LD A,E
  PUSH AF
  LD A,C
  RLA
  CALL FADD_2
  POP AF
  RET
; This entry point is used by the routine at __INT.
INT_0:
  LD HL,FPEXP
  LD A,(HL)
  CP $90
  JR NZ,INT_3
  LD C,A
  DEC HL
  LD A,(HL)
  XOR $80
  LD B,$06
INT_1:
  DEC HL
  OR (HL)
  DEC B
  JR NZ,INT_1
  OR A
  LD HL,$8000
  JP NZ,INT_2
  CALL MAKINT
  JP __CDBL
INT_2:
  LD A,C
INT_3:
  OR A
  RET Z
  CP $B8
  RET NC
; This entry point is used by the routine at FOUTCV.
INT_4:
  PUSH AF
  CALL BCDEFP
  CALL UNPACK
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
  CALL DADDFO_4
  POP AF
  CALL M,DADD_10
  XOR A
  LD ($0CAC),A
  POP AF
  RET NC
  JP DADD_3
INT_5:
  LD HL,FACLOW
INT_6:
  LD A,(HL)
  DEC (HL)
  OR A
  INC HL
  JR Z,INT_6
  RET

; Multiply DE by BC
;
; Used by the routine at FNDARY.
MLDEBC:
  PUSH HL
  LD HL,$0000
  LD A,B
  OR C
  JR Z,MLDEBC_2
  LD A,$10
MLDEBC_0:
  ADD HL,HL
  JP C,FNDARY_3
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JR NC,MLDEBC_1
  ADD HL,BC
  JP C,FNDARY_3
MLDEBC_1:
  DEC A
  JR NZ,MLDEBC_0
MLDEBC_2:
  EX DE,HL
  POP HL
  RET

; Integer SUBTRTACTION, (HL):=(DE)-(HL)
ISUB:
  LD A,H
  RLA
  SBC A,A
  LD B,A
  CALL INEGHL
  LD A,C
  SBC A,B
  JR IADD_0

; Integer ADDITION, (HL):=(DE)+(HL)
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
  JP P,__CINT_6
  PUSH BC
  EX DE,HL
  CALL HL_CSNG
  POP AF
  POP HL
  CALL PUSHF
  EX DE,HL
  CALL INEG_1
  JP FADDT

; Integer MULTIPLY, (HL):=(DE)*(HL)
IMULT:
  LD A,H
  OR L
  JP Z,MAKINT
  PUSH HL
  PUSH DE
  CALL IMULDV
  PUSH BC
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$10
IMULT_0:
  ADD HL,HL
  JR C,IMULT5
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JR NC,IMULT_1
  ADD HL,BC
  JP C,IMULT5
IMULT_1:
  DEC A
  JR NZ,IMULT_0
  POP BC
  POP DE

; Routine at 20838
;
; Used by the routine at FMULTT.
IMLDIV:
  LD A,H
  OR A
  JP M,IMULT_3
  POP DE
  LD A,B
  JP INEGA
IMULT_3:
  XOR $80
  OR L
  JR Z,IMULT4
  EX DE,HL
  DEFB $01             ; "LD BC,nn" OVER NEXT 2 BYTES

; Routine at 11168
;
; Used by the routine at IMULT.
IMULT5:
  POP BC               ;GET SIGN OF RESULT OFF STACK
  POP HL               ;GET THE ORIGINAL FIRST ARGUMENT
  CALL HL_CSNG
  POP HL
  CALL PUSHF
  CALL HL_CSNG

; Routine at 20867
FMULTT:
  POP BC
  POP DE
  JP FMULT
; This entry point is used by the routine at IMLDIV.
IMULT4:
  LD A,B
  OR A
  POP BC
  JP M,MAKINT
  PUSH DE
  CALL HL_CSNG
  POP DE
  JP NEG



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

DIVLP:
  PUSH AF               ;SAVE COUNT
  PUSH HL               ;SAVE (HL) I.E. CURRENT NUMERATOR
  ADD HL,BC             ;SUBTRACT DENOMINATOR
  JR NC,IDIV2

  POP AF                ;THE SUBTRACTION WAS GOOD, DISCARD OLD (HL)
  SCF                   ;NEXT BIT IN QUOTIENT IS A ONE
  DEFB $3E              ; "LD A,n" OVER NEXT BYTE

IDIV2:
  POP HL                ;IGNORE THE SUBTRACTION, WE COULDN'T DO IT
IDIV3:
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
  JR NZ,DIVLP
  EX DE,HL
  POP BC
  PUSH DE
  JP IMLDIV

; GET READY TO MULTIPLY OR DIVIDE
;
; Used by the routines at IMULT and FMULTT.
IMULDV:
  LD A,H
  XOR D
  LD B,A
  CALL INEGH
  EX DE,HL

; NEGATE H,L
;
; Used by the routine at IMULDV.
INEGH:
  LD A,H

; NEGATE A
;
; Used by the routines at IMLDIV and INEG.
INEGA:
  OR A
  JP P,MAKINT

; Negate HL
;
; Used by the routines at ISUB, FMULTT and INEG.
INEGHL:
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
  JP MAKINT

; Integer negation
;
; Used by the routine at INVSGN.
INEG:
  LD HL,(FACCU)
  CALL INEGHL
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at CONFAC, __ERL and DANDOR.
INEG2:
  EX DE,HL
  CALL VALSNG
  XOR A
; This entry point is used by the routine at IADD.
INEG_1:
  LD B,$98
  JP FLOAT_0
; This entry point is used by the routines at LPTMDF and DANDOR.
INEG_2:
  PUSH DE
  CALL INT_DIV
  XOR A
  ADD A,D
  RRA
  LD H,A
  LD A,E
  RRA
  LD L,A
  CALL MAKINT_0
  POP AF
  JR INEGA

; aka DECSUB, Double precision SUB (formerly SUBCDE)
DSUB:
  LD HL,ARG-1
  LD A,(HL)
  XOR $80
  LD (HL),A

; Routine at 21008
;
; Used by the routines at __CINT, DDIV10, DMUL10, FINDGE and FOUTCV.
DADD:
  LD HL,ARG
  LD A,(HL)
  OR A
  RET Z
  LD B,A
  DEC HL
  LD C,(HL)
  LD DE,FPEXP
  LD A,(DE)
  OR A
  JP Z,VMOVFA
  SUB B
  JR NC,DADD_1
  CPL
  INC A
  PUSH AF
  LD C,$08
  INC HL
  PUSH HL
DADD_0:
  LD A,(DE)
  LD B,(HL)
  LD (HL),A
  LD A,B
  LD (DE),A
  DEC DE
  DEC HL
  DEC C
  JR NZ,DADD_0
  POP HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  POP AF
DADD_1:
  CP $39
  RET NC
  PUSH AF
  CALL UNPACK
  LD HL,$0CB9
  LD B,A
  LD A,$00
  LD (HL),A
  LD ($0CAC),A
  POP AF
  LD HL,ARG-1
  CALL DADDFO_4
  LD A,($0CB9)
  LD ($0CAC),A
  LD A,B
  OR A
  JP P,DADD_2
  CALL DADD_12
  JP NC,DADD_8
  EX DE,HL
  INC (HL)
  JP Z,OVERR_1
  CALL DADDFO_12
  JP DADD_8
DADD_2:
  LD A,$9E
  CALL DADD_13
  LD HL,SGNRES
  CALL C,DADDFO_2
; This entry point is used by the routines at INT and DMUL.
DADD_3:
  XOR A
DADD_4:
  LD B,A
  LD A,(FACCU+2)
  OR A
  JR NZ,DADD_7
  LD HL,$0CAC
  LD C,$08
DADD_5:
  LD D,(HL)
  LD (HL),A
  LD A,D
  INC HL
  DEC C
  JR NZ,DADD_5
  LD A,B
  SUB $08
  CP $C0
  JR NZ,DADD_4
  JP ZERO
DADD_6:
  DEC B
  LD HL,$0CAC
  CALL DADDFO_13
  OR A
DADD_7:
  JP P,DADD_6
  LD A,B
  OR A
  JR Z,DADD_8
  LD HL,FPEXP
  ADD A,(HL)
  LD (HL),A
  JP NC,ZERO
  RET Z
DADD_8:
  LD A,($0CAC)
; This entry point is used by the routine at DDIV.
DADD_9:
  OR A
  CALL M,DADD_10
  LD HL,SGNRES
  LD A,(HL)
  AND $80
  DEC HL
  DEC HL
  XOR (HL)
  LD (HL),A
  RET
; This entry point is used by the routine at INT.
DADD_10:
  LD HL,FACLOW
  LD B,$07
DADD_11:
  INC (HL)
  RET NZ
  INC HL
  DEC B
  JR NZ,DADD_11
  INC (HL)
  JP Z,OVERR_1
  DEC HL
  LD (HL),$80
  RET
; This entry point is used by the routine at DDIV.
DADDD:
  LD DE,$0CDD
  LD HL,FPARG
  JP DADDFO_0
; This entry point is used by the routine at DMUL.
DADD_12:
  LD A,$8E
DADD_13:
  LD HL,FPARG

; Routine at 21218
;
; Used by the routine at FOUCD1.
DADDFO:
  LD DE,FACLOW
; This entry point is used by the routine at DADD.
DADDFO_0:
  LD C,$07
  LD ($52EC),A
  XOR A
DADDFO_1:
  LD A,(DE)
  ADC A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JR NZ,DADDFO_1
  RET
; This entry point is used by the routine at DADD.
DADDFO_2:
  LD A,(HL)
  CPL
  LD (HL),A
  LD HL,$0CAC
  LD B,$08
  XOR A
  LD C,A
DADDFO_3:
  LD A,C
  SBC A,(HL)
  LD (HL),A
  INC HL
  DEC B
  JR NZ,DADDFO_3
  RET
; This entry point is used by the routines at INT and DADD.
DADDFO_4:
  LD (HL),C
  PUSH HL
DADDFO_5:
  SUB $08
  JR C,DADDFO_8
  POP HL
; This entry point is used by the routine at DMUL.
DADDFO_6:
  PUSH HL
  LD DE,$0800
DADDFO_7:
  LD C,(HL)
  LD (HL),E
  LD E,C
  DEC HL
  DEC D
  JR NZ,DADDFO_7
  JR DADDFO_5
DADDFO_8:
  ADD A,$09
  LD D,A
DADDFO_9:
  XOR A
  POP HL
  DEC D
  RET Z
DADDFO_10:
  PUSH HL
  LD E,$08
DADDFO_11:
  LD A,(HL)
  RRA
  LD (HL),A
  DEC HL
  DEC E
  JR NZ,DADDFO_11
  JR DADDFO_9
; This entry point is used by the routines at DADD and DMUL.
DADDFO_12:
  LD HL,FACCU+2
  LD D,$01
  JR DADDFO_10
; This entry point is used by the routines at DADD and DDIV.
DADDFO_13:
  LD C,$08
; This entry point is used by the routine at DDIV.
DADDFO_14:
  LD A,(HL)
  RLA
  LD (HL),A
  INC HL
  DEC C
  JR NZ,DADDFO_14
  RET

; aka DECMUL, Double precision MULTIPLY
;
; Used by the routines at DDIV10 and FORBIG.
DMUL:
  CALL SIGN
  RET Z
  LD A,(ARG)
  OR A
  JP Z,ZERO
  CALL $4DFC
  CALL DMULDV           ;ZERO FAC AND PUT FAC IN FBUFFR
  LD HL,FBUFFR+34		;GET POINTER TO THE EXTRA HO BYTE WE WILL USE; last byte in FBUFFR
  LD (HL),C             ;ZERO IT
  LD B,C                ;ZERO FLAG TO SEE WHEN WE START DIVIDING
DMUL_0:
  LD A,(DE)
  INC DE
  OR A
  PUSH DE
  JR Z,DMUL_3
  LD C,$08
DMUL_1:
  PUSH BC
  RRA
  LD B,A
  CALL C,DADD_12
  CALL DADDFO_12
  LD A,B
  POP BC
  DEC C
  JR NZ,DMUL_1
DMUL_2:
  POP DE
  DEC B
  JR NZ,DMUL_0
  JP DADD_3
DMUL_3:
  LD HL,FACCU+2
  CALL DADDFO_6
  JR DMUL_2
  CALL $CCCC
  CALL Z,$CCCC
  LD C,H
  LD A,L
  NOP
  NOP
  NOP
  NOP

; Data block at 21380
FP_TEN:
  DEFB $00,$00,$20,$84

; Routine at 21384
;
; Used by the routine at FINDIV.
DDIV10:
  LD A,(FPEXP)
  CP $41
  JP NC,DDIV10_0
  LD DE,$5378
  LD HL,FPARG
  CALL VMOVE
  JP DMUL
DDIV10_0:
  LD A,(FACCU+2)
  OR A
  JP P,DDIV10_1
  AND $7F
  LD (FACCU+2),A
  LD HL,NEG
  PUSH HL
DDIV10_1:
  CALL DECF1
  LD DE,FACLOW
  LD HL,FPARG
  CALL VMOVE
  CALL DECF1
  CALL DADD
  LD DE,FACLOW
  LD HL,FPARG
  CALL VMOVE
  LD A,$0F
DDIV10_2:
  PUSH AF
  CALL DECA4
  CALL PSARG
  CALL DADD
  LD HL,ARG-1
  CALL PPARG
  POP AF
  DEC A
  JP NZ,DDIV10_2
  CALL DECF1
  CALL DECF1
  CALL DECF1
  RET

; Routine at 21480
;
; Used by the routine at DDIV10.
DECF1:
  LD HL,FPEXP
  DEC (HL)
  RET NZ
  JP ZERO

; Routine at 21488
;
; Used by the routine at DDIV10.
DECA4:
  LD HL,ARG
  LD A,$04
DECA4_0:
  DEC (HL)
  RET Z
  DEC A
  JP NZ,DECA4_0
  RET

; Routine at 21500
;
; Used by the routine at DDIV10.
PSARG:
  POP DE
  LD A,$04
  LD HL,FPARG
PSARG_0:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  DEC A
  JP NZ,PSARG_0
  PUSH DE
  RET

; Routine at 21517
;
; Used by the routine at DDIV10.
PPARG:
  POP DE
  LD A,$04
  LD HL,ARG
PPARG_0:
  POP BC
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC HL
  DEC A
  JP NZ,PPARG_0
  PUSH DE
  RET

; aka DECDIV, Double precision DIVIDE
DDIV:
  LD A,(ARG)
  OR A
  JP Z,OVERR_4
  LD A,(FPEXP)
  OR A
  JP Z,ZERO
  CALL MULDVS
  INC (HL)
  INC (HL)
  JP Z,OVERR_1
  CALL DMULDV
  LD HL,$0CE4
  LD (HL),C
  LD B,C
DDIV_0:
  LD A,$9E				; SBC A,(HL)  ->   SUBTRACT ARG FROM FBUFFR
  CALL DADDD            ;DO THE SUBTRACTION
  LD A,(DE)
  SBC A,C
  CCF
  JR C,$544D
  LD A,$8E
  CALL DADDD
  XOR A
  JP C,WORDS_R_0
  LD A,(FACCU+2)
  INC A
  DEC A
  RRA
  JP M,DADD_9
  RLA
  LD HL,FACLOW
  LD C,$07
  CALL DADDFO_14
  LD HL,$0CDD
  CALL DADDFO_13
  LD A,B
  OR A
  JR NZ,DDIV_0
  LD HL,FPEXP
  DEC (HL)
  JR NZ,DDIV_0
  JP ZERO
; This entry point is used by the routine at DMUL.
DMULDV:
  LD A,C
  LD (ARG-1),A
  DEC HL
  LD DE,$0CE3
  LD BC,$0700
DDIV_2:
  LD A,(HL)
  LD (DE),A
  LD (HL),C
  DEC DE
  DEC HL
  DEC B
  JR NZ,DDIV_2
  RET

; MULTIPLY BY 10D0
;
; Used by the routines at MULTEN and FINDGE.
DMUL10:
  CALL VMOVAF
  EX DE,HL
  DEC HL
  LD A,(HL)
  OR A
  RET Z
  ADD A,$02
  JP C,OVERR_1
  LD (HL),A
  PUSH HL
  CALL DADD
  POP HL
  INC (HL)
  RET NZ
  JP OVERR_1

; Routine at 21664
;
; Used by the routines at INPBIN, __VAL and LINE_INPUT.
FIN_DBL:
  CALL ZERO
  CALL VALDBL

; "OR n" to Mask 'XOR A'  -  SO FRCINT IS NOT CALLED
L54A6:
  DEFB $F6

; Routine at 21671
;
; Used by the routines at FLTGET, INPBIN, OPRND, __RANDOMIZE and LINE_INPUT.
FIN:
  XOR A
  LD BC,FINOVC
  PUSH BC
  PUSH AF
  LD A,$01
  LD (FLGOVC),A
  POP AF
  EX DE,HL
  LD BC,$00FF
  LD H,B
  LD L,B
  CALL Z,MAKINT
  EX DE,HL
  LD A,(HL)

; Routine at 21694
H_ASCTFP:
  CP $26
  JP Z,OCTCNS
_ASCTFP:
  CP $2D
  PUSH AF
  JP Z,_ASCTFP_0
  CP $2B
  JR Z,_ASCTFP_0
  DEC HL
; This entry point is used by the routines at DPOINT and FINDGE.
_ASCTFP_0:
  CALL CHRGTB
  JP C,ADDIG
  CP $2E
  JP Z,DPOINT
  CP $65
  JR Z,EXPONENTIAL
  CP $45
EXPONENTIAL:
  JP NZ,NOTE
  PUSH HL
  CALL CHRGTB
  CP $6C
  JR Z,_ASCTFP_1
  CP $4C
  JR Z,_ASCTFP_1
  CP $71
  JR Z,_ASCTFP_1
  CP $51
_ASCTFP_1:
  POP HL
  JR Z,_ASCTFP_2
  LD A,(VALTYP)
  CP $08
  JR Z,FINEX1
  LD A,$00
  JR FINEX1
_ASCTFP_2:
  LD A,(HL)
NOTE:
  CP $25
  JP Z,FININT
  CP $23
  JP Z,FINDBF
  CP $21
  JP Z,FINSNF
  CP $64
  JR Z,FINEX1
  CP $44
  JR NZ,FINE
FINEX1:
  OR A
  CALL FINFRC
  CALL CHRGTB
  CALL OKNORM_3

; Routine at 21796
;
; Used by the routine at FINEDG.
FINEC:
  CALL CHRGTB
  JP C,FINEDG
  INC D
  JR NZ,FINE
  XOR A
  SUB E
  LD E,A

; HERE TO FINISH UP THE NUMBER
;
; Used by the routines at H_ASCTFP, FINEC and DPOINT.
FINE:
  PUSH HL
  LD A,E
  SUB B
  LD E,A
FINE_0:
  CALL P,DPOINT_0
  CALL M,FINDIV
  JR NZ,FINE_0
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
  CALL MAKINT_2
  RET

; HERE TO CHECK IF WE HAVE SEEN 2 DECIMAL POINTS AND SET THE DECIMAL POINT FLAG
;
; Used by the routine at H_ASCTFP.
DPOINT:
  CALL GETYPR
  INC C
  JR NZ,FINE
  CALL C,FINFRC
  JP _ASCTFP_0
; This entry point is used by the routine at H_ASCTFP.
FININT:
  CALL CHRGTB
  POP AF
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  LD HL,__CINT
  PUSH HL
  PUSH AF
  JR FINE
; This entry point is used by the routine at H_ASCTFP.
FINDBF:
  OR A
; This entry point is used by the routine at H_ASCTFP.
FINSNF:
  CALL FINFRC
  CALL CHRGTB
  JR FINE
; This entry point is used by the routine at H_ASCTFP.
FINFRC:
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
; This entry point is used by the routine at FINE.
DPOINT_0:
  RET Z

; Multiply FP value by ten
;
; Used by the routine at SIXDIG.
MULTEN:
  PUSH AF
  CALL GETYPR
  PUSH AF
  CALL PO,MLSP10
  POP AF
  CALL PE,DMUL10
  POP AF
; This entry point is used by the routine at FFXXVS.
DCRART:
  DEC A
  RET

; Routine at 21908
;
; Used by the routines at FINE, FFXXVS and SIXDIG.
FINDIV:
  PUSH DE
  PUSH HL
  PUSH AF
  CALL GETYPR
  PUSH AF
  CALL PO,DIV10
  POP AF
  CALL PE,DDIV10
  POP AF
  POP HL
  POP DE
  INC A
  RET

; a.k.a. FINDIG - HERE TO PACK THE NEXT DIGIT OF THE NUMBER INTO THE FAC
;
; Used by the routine at H_ASCTFP.
ADDIG:
  PUSH DE
  LD A,B
  ADC A,C
  LD B,A
  PUSH BC
  PUSH HL
  LD A,(HL)
  SUB $30
  PUSH AF
  CALL GETYPR
  JP P,FINDGV
  LD HL,(FACCU)
  LD DE,$0CCD
  CALL DCOMPR
  JR NC,FINDG2
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
  JP M,FINDG1
  LD (FACCU),HL

; Routine at 21971
FINDGE:
  POP HL
  POP BC
  POP DE
  JP _ASCTFP_0
; This entry point is used by the routine at ADDIG.
FINDG1:
  LD A,C
  PUSH AF
; This entry point is used by the routine at ADDIG.
FINDG2:
  CALL __CSNG_1
  SCF
; This entry point is used by the routine at ADDIG.
FINDGV:
  JR NC,FINDGD
  LD BC,$9474
  LD DE,$2400
  CALL FCOMP
  JP P,FINDGE_0
  CALL MLSP10
  POP AF
  CALL FINDG4
  JR FINDGE
FINDGE_0:
  CALL __CDBL_0
FINDGD:
  CALL DMUL10
  CALL VMOVAF
  POP AF
  CALL FLOAT
  CALL __CDBL_0
  CALL DADD
  JR FINDGE

; Routine at 22027
;
; Used by the routine at FINDGE.
FINDG4:
  CALL PUSHF
  CALL FLOAT
; This entry point is used by the routine at IADD.
FADDT:
  POP BC
  POP DE
  JP FADD

; Routine at 22038
;
; Used by the routine at FINEC.
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

  OR A                   ; ***
  JP OVFINT

  POP AF

; This entry point is used by the routine at FDIV.
OVFIN1:
  PUSH HL
  LD HL,FACCU+2          ;POINT (HL) TO SIGN BYTE
  CALL GETYPR
  JP PO,OVF2A            ;SP PROCEED AS NORMAL
  LD A,(ARG-1)
  JR OVF2B

; Routine at 22078
;
; Used by the routine at FINEDG.
OVF2A:
  LD A,C
; This entry point is used by the routine at FINEDG.
OVF2B:
  XOR (HL)               ;SIGN IN HIGH BIT OF (A)
  RLA                    ;SIGN IN CARRY
  POP HL
  JP OVFINT              ;GO PRINT OVERFLOW

  LD A,(SGNRES)          ; ***
  JP OVERR_2

  POP AF          ; ***
; This entry point is used by the routine at __EXP.
OVFIN6:
  POP AF                 ; This entry is used by __EXP
  POP AF                 ; (RESZER exits here)

; Routine at 22094
;
; Used by the routine at MLSP10.
OVERR:
  LD A,(FACCU+2)
  RLA
  JR OVFINT              ;GO PRINT OVERFLOW
  
; This entry point is used by the routine at BNORM.
OVERR_0:
  POP AF                 ;DO A POP THEN FALL INTO OVERR_1

; This entry point is used by the routines at FADD, DADD, DDIV and DMUL10.
OVERR_1:
  LD A,(SGNRES)          ;GET SIGN BYTE
  CPL                    ;SIGN WAS STORED COMPLEMENTED

; This entry point is used by the routine at OVF2A.
OVERR_2:
  RLA                    ;SIGN TO CARRY
  JR OVFINT              ;GO PRINT OVERFLOW

; This entry point is used by the routine at FDIV.
DIV_DZERR:
  LD A,C
  JP DZERR
  
; This entry point is used by the routine at DDIV.
OVERR_4:
  PUSH HL
  PUSH DE
  LD HL,FACLOW
  LD DE,INFM             ;ALL ONES
  CALL INCHL_1
  LD A,(INFM)
  LD (FACLOW+2),A
  CALL GETYPR
  JP PO,OVERR_5
  LD A,(FACCU+2)
  JP OVERR_6

OVERR_5:
  LD A,(ARG-1)
OVERR_6:
  POP DE
  POP HL

; This entry point is used by the routine at POWER.
DZERR:
  RLA                    ;TO CARRY
  LD HL,DIV0_MSG         ;GET MESSAGE ADDRESS
  LD (OVERRI),HL         ;STORE SO OVFINT WILL PICK UP


	;ANSI OVERFLOW ROUTINE

; This entry point is used by the routines at FINEDG and OVF2A.
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
  LD A,(FLGOVC)          ;PRINT INDICATOR FLAG
  OR A                   ;PRINT IF 0,1;SET TO 2 IF 1
  JP Z,OV1A
  CP $01
  JP NZ,OVFPRT
  LD A,$02
  LD (FLGOVC),A
OV1A:
  LD HL,(OVERRI)         ;ADDRESS OF OVERFLOW MESSAGE
  CALL STRPRN            ;PRINT
  LD (TTYPOS),A
  LD A,$0D
  CALL CALTTY
  LD A,$0A
  CALL CALTTY            ;CARRIAGE RETURN,LINE FEED
OVFPRT:
  POP AF
  LD HL,FACCU
  LD DE,INFP
  JP NC,OVFINA
  LD DE,INFM
OVFINA:
  CALL INCHL_1
  CALL GETYPR
  JP PO,OVFINB
  LD HL,FACLOW
  LD DE,INFM
  CALL INCHL_1
OVFINB:
  LD HL,(ONELIN)
  LD A,H
  OR L
  JP Z,NOODTP
  LD HL,(OVERRI)
  LD DE,OVERFLOW_MSG
  CALL DCOMPR
  LD HL,OVERFLOW_MSG
  LD (OVERRI),HL
  JP Z,OV_ERR
  JP O_ERR
NOODTP:
  POP AF
  LD HL,OVERFLOW_MSG
  LD (OVERRI),HL
  POP DE
  POP BC
  POP HL
  RET

; INFINITY
INFP:
  DEFB $FF,$FF,$7F,$FF

; MINUS INFINITY
INFM:
  DEFB $FF,$FF

; Data block at 22281
L5709:
  DEFW $FFFF

; Routine at 22283
;
; Used by the routines at ERRMOR and _LINE2PTR.
IN_PRT:
  PUSH HL
  LD HL,IN_MSG
  CALL PRS
  POP HL

; Print HL in ASCII form at the current cursor position
;
; Used by the routines at PROMPT, NEWSTT_0, __LIST, _LINE2PTR, __EDIT and
; DONCMD.
LINPRT:
  LD BC,PRNUMS
  PUSH BC
  CALL MAKINT
  XOR A
  CALL FOUINI
  OR (HL)
  JP SPCFST

; FLOATING OUTPUT OF FAC
;
; Used by the routines at __PRINT, NUMLIN, FFXSDO, __STR_S and __WRITE.
FOUT:
  XOR A

; Routine at 22307
;
; Used by the routine at NOTSCI.
PUFOUT:
  CALL FOUINI
  AND $08
  JR Z,PUFOUT_0
  LD (HL),$2B
PUFOUT_0:
  EX DE,HL
  CALL VSIGN
  EX DE,HL
  JP P,SPCFST
  LD (HL),$2D
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H

; Routine at 22334
;
; Used by the routines at LINPRT and PUFOUT.
SPCFST:
  INC HL
  LD (HL),$30
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,FOUTFX
  JP Z,FOUTZR
  CP $04
  JP NC,FOUFRV
  LD BC,$0000
  CALL FOUTCI

; ZERO SUPPRESS THE DIGITS IN FBUFFR, ASTERISK FILL AND ZERO SUPPRESS IF
; NECESSARY
;
; Used by the routine at FOUTTS.
FOUTZS:
  LD HL,$0CC3
  LD B,(HL)
  LD C,$20
  LD A,(TEMP3)
  LD E,A
  AND $20
  JR Z,FOUTZS_0
  LD A,B
  CP C
  LD C,$2A
  JR NZ,FOUTZS_0
  LD A,E
  AND $04
  JP NZ,FOUTZS_0
  LD B,C
FOUTZS_0:
  LD (HL),C
  CALL CHRGTB
  JR Z,FOUTZS_1
  CP $45
  JR Z,FOUTZS_1
  CP $44
  JR Z,FOUTZS_1
  CP $30
  JR Z,FOUTZS_0
  CP ','
  JR Z,FOUTZS_0
  CP $2E
  JR NZ,FOUTZS_2
FOUTZS_1:
  DEC HL
  LD (HL),$30
FOUTZS_2:
  LD A,E
  AND $10
  JR Z,FOUTZS_3
  DEC HL
  LD (HL),$24
FOUTZS_3:
  LD A,E
  AND $04
  RET NZ
  DEC HL
  LD (HL),B
  RET

; HERE TO INITIALLY SET UP THE FORMAT SPECS AND PUT IN A SPACE FOR THE SIGN OF
; A POSITIVE NUMBER
;
; Used by the routines at LINPRT and PUFOUT.
FOUINI:
  LD (TEMP3),A
  LD HL,$0CC3
  LD (HL),$20
  RET

; HERE TO PRINT A SNG OR DBL IN FREE FORMAT
;
; Used by the routine at SPCFST.
FOUFRV:
  CALL PUSHF
  EX DE,HL
  LD HL,(FACLOW)
  PUSH HL
  LD HL,(FACLOW+2)
  PUSH HL
  EX DE,HL
  PUSH AF
  XOR A
  LD (FANSII),A
  POP AF
  PUSH AF
  CALL FOUFRF
  LD B,$45
  LD C,$00
FOUFRV_0:
  PUSH HL
  LD A,(HL)
FOUFRV_1:
  CP B
  JP Z,FOUFRV_4
  CP $3A
  JP NC,FOUFRV_2
  CP $30
  JP C,FOUFRV_2
  INC C
FOUFRV_2:
  INC HL
  LD A,(HL)
  OR A
  JP NZ,FOUFRV_1
  LD A,$44
  CP B
  LD B,A
  POP HL
  LD C,$00
  JP NZ,FOUFRV_0
FOUFRV_3:
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
FOUFRV_4:
  PUSH BC
  LD B,$00
  INC HL
  LD A,(HL)
FOUFRV_5:
  CP $2B
  JP Z,FOUFRV_9
  CP $2D
  JP Z,FOUFRV_6
  SUB $30
  LD C,A
  LD A,B
  ADD A,A
  ADD A,A
  ADD A,B
  ADD A,A
  ADD A,C
  LD B,A
  CP $10
  JP NC,FOUFRV_9
FOUFRV_6:
  INC HL
  LD A,(HL)
  OR A
  JP NZ,FOUFRV_5
  LD H,B
  POP BC
  LD A,B
  CP $45
  JP NZ,FOUFRV_8
  LD A,C
  ADD A,H
  CP $09
  POP HL
  JP NC,FOUFRV_3
FOUFRV_7:
  LD A,$80
  LD (FANSII),A
  JP FOUFRV_10
FOUFRV_8:
  LD A,H
  ADD A,C
  CP $12
  POP HL
  JP NC,FOUFRV_3
  JP FOUFRV_7
FOUFRV_9:
  POP BC
  POP HL
  JP FOUFRV_3
FOUFRV_10:
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

; Routine at 22613
;
; Used by the routine at FOUFRV.
FOUFRF:
  CP $05
  PUSH HL
  SBC A,$00
  RLA
  LD D,A
  INC D
  CALL FOUTNV
  LD BC,$0300
  PUSH AF
  LD A,(FANSII)
  OR A
  JP P,FOUFRF_0
  POP AF
  ADD A,D
  JP FOUFRF_1
FOUFRF_0:
  POP AF
  ADD A,D
  JP M,FOFRS1
  INC D
  CP D
  JR NC,FOFRS1
FOUFRF_1:
  INC A
  LD B,A
  LD A,$02
FOFRS1:
  SUB $02
  POP HL
  PUSH AF
  CALL FOUTAN
  LD (HL),$30
  CALL Z,INCHL
  CALL FOUTCV

; HERE TO SUPPRESS THE TRAILING ZEROS
SUPTLZ:
  DEC HL
  LD A,(HL)
  CP $30
  JR Z,SUPTLZ
  CP $2E
  CALL NZ,INCHL
  POP AF
  JR Z,NOENED

; HERE TO PUT THE EXPONENT AND "E" OR "D" IN THE BUFFER
;
; Used by the routine at FFXXVS.
DOEBIT:
  PUSH AF
  CALL GETYPR
  LD A,$22
  ADC A,A
  LD (HL),A
  INC HL
  POP AF
  LD (HL),$2B
  JP P,OUTEXP
  LD (HL),$2D
  CPL
  INC A

; CALCULATE THE TWO DIGIT EXPONENT
;
; Used by the routine at DOEBIT.
OUTEXP:
  LD B,$2F
EXPTEN:
  INC B
  SUB $0A
  JR NC,EXPTEN
  ADD A,$3A
  INC HL
  LD (HL),B
  INC HL
  LD (HL),A
; This entry point is used by the routine at SPCFST.
FOUTZR:
  INC HL

; PRINTING A FREE FORMAT ZERO
;
; Used by the routine at SUPTLZ.
NOENED:
  LD (HL),$00
  EX DE,HL
  LD HL,$0CC3
  RET

; HERE TO PRINT A NUMBER IN FIXED FORMAT
;
; Used by the routine at SPCFST.
FOUTFX:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,FOUFXV
  RRA
  JP C,FFXXVS_5
  LD BC,$0603
  CALL FOUICC
  POP DE
  LD A,D
  SUB $05
  CALL P,FOTZER
  CALL FOUTCI

; Routine at 22750
;
; Used by the routine at FFXSDC.
FOUTTD:
  LD A,E
  OR A
  CALL Z,FDIV_5
  DEC A
  CALL P,FOTZER

; Routine at 22759
;
; Used by the routine at FFXXVS.
FOUTTS:
  PUSH HL
  CALL FOUTZS
  POP HL
  JR Z,FOUTTS_0
  LD (HL),B
  INC HL
FOUTTS_0:
  LD (HL),$00
  LD HL,FBUFFR
FOUTTS_1:
  INC HL
FOUTTS_2:
  LD A,(NXTOPR)
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP $20
  JR Z,FOUTTS_1
  CP $2A
  JR Z,FOUTTS_1
  DEC HL
  PUSH HL
  PUSH AF
  LD BC,$5907
  PUSH BC
  CALL CHRGTB
  CP $2D
  RET Z
  CP $2B
  RET Z
  CP $24
  RET Z
  POP BC
  CP $30
  JR NZ,FOUTTS_3
  INC HL
  CALL CHRGTB
  JR NC,FOUTTS_3
  DEC HL
  LD BC,$772B
  POP AF
  JR Z,$5925
  POP BC
  JP FOUTTS_2
FOUTTS_3:
  POP AF
  JR Z,FOUTTS_3
  POP HL
  LD (HL),$25
  RET

; HERE TO PRINT A SNG OR DBL IN FIXED FORMAT
;
; Used by the routine at FOUTFX.
FOUFXV:
  PUSH HL
  RRA
  JP C,FFXXVS_6
  JR Z,FFXSFX
  LD DE,FP_FFXDXM
  CALL CMPPHL
  LD D,$10
  JP M,FFXSDC

; HERE TO PRINT IN FREE FORMAT WITH A PERCENT SIGN A NUMBER .GE. 10^16
;
; Used by the routine at FFXSFX.
FFXSDO:
  POP HL
  POP BC
  CALL FOUT
  DEC HL
  LD (HL),$25
  RET

; HERE TO PRINT A SNG IN FIXED FORMAT--FIXED POINT NOTATION
;
; Used by the routine at FOUFXV.
FFXSFX:
  LD BC,$B60E
  LD DE,$1BCA
  CALL FCOMP
  JP P,FFXSDO
  LD D,$06

; HERE TO ACTUALLY PRINT A SNG OR DBL IN FIXED FORMAT
;
; Used by the routine at FOUFXV.
FFXSDC:
  CALL SIGN
  CALL NZ,FOUTNV
  POP HL
  POP BC
  JP M,FFXXVS
  PUSH BC
  LD E,A
  LD A,B
  SUB D
  SUB E
  CALL P,FOTZER
  CALL FOUTCD
  CALL FOUTCV
  OR E
  CALL NZ,FOTZEC
  OR E
  CALL NZ,FOUTED
  POP DE
  JP FOUTTD

; Routine at 22915
;
; Used by the routine at FFXSDC.
FFXXVS:
  LD E,A
  LD A,C
  OR A
  CALL NZ,DCRART
  ADD A,E
  JP M,FFXXVS_0
  XOR A
FFXXVS_0:
  PUSH BC
  PUSH AF
FFXXVS_1:
  CALL M,FINDIV
  JP M,FFXXVS_1
  POP BC
  LD A,E
  SUB B
  POP BC
  LD E,A
  ADD A,D
  LD A,B
  JP M,FFXXVS_2
  SUB D
  SUB E
  CALL P,FOTZER
  PUSH BC
  CALL FOUTCD
  JR FFXXVS_3
FFXXVS_2:
  CALL FOTZER
  LD A,C
  CALL FOUTDP
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL FOTZER
  PUSH BC
  LD B,A
  LD C,A
FFXXVS_3:
  CALL FOUTCV
  POP BC
  OR C
  JR NZ,FFXXVS_4
  LD HL,(NXTOPR)
FFXXVS_4:
  ADD A,E
  DEC A
  CALL P,FOTZER
  LD D,B
  JP FOUTTS
; This entry point is used by the routine at FOUTFX.
FFXXVS_5:
  PUSH HL
  PUSH DE
  CALL __CSNG_1
  POP DE
  XOR A
; This entry point is used by the routine at FOUFXV.
FFXXVS_6:
  JP Z,$59DC
  LD E,$10
  LD BC,$061E
  CALL SIGN
  SCF
  CALL NZ,FOUTNV
  POP HL
  POP BC
  PUSH AF
  LD A,C
  OR A
  PUSH AF
  CALL NZ,DCRART
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
FFXXVS_7:
  CALL M,FINDIV
  JP M,FFXXVS_7
  POP BC
  POP AF
  PUSH BC
  PUSH AF
  JP M,FFXXVS_8
  XOR A
FFXXVS_8:
  CPL
  INC A
  ADD A,B
  INC A
  ADD A,D
  LD B,A
  LD C,$00
  CALL FOUTCV
  POP AF
  CALL P,FOTZNC
  CALL FOUTED
  POP BC
  POP AF
  JP NZ,FFXXVS_9
  CALL FDIV_5
  LD A,(HL)
  CP $2E
  CALL NZ,INCHL
  LD (NXTOPR),HL
FFXXVS_9:
  POP AF
  JR C,FFXXVS_10
  ADD A,E
  SUB B
  SUB D
FFXXVS_10:
  PUSH BC
  CALL DOEBIT
  EX DE,HL
  POP DE
  JP FOUTTS

; Routine at 23100
;
; Used by the routines at FOUFRF, FFXSDC and FFXXVS.
FOUTNV:
  PUSH DE
  XOR A
  PUSH AF
  CALL GETYPR
  JP PO,FOUNDB

; Routine at 23109
FORBIG:
  LD A,(FPEXP)
  CP $91
  JP NC,FOUNDB
  LD DE,FP_TENTEN
  LD HL,FPARG
  CALL VMOVE
  CALL DMUL
  POP AF
  SUB $0A
  PUSH AF
  JR FORBIG

; Routine at 23135
;
; Used by the routines at FOUTNV and FORBIG.
FOUNDB:
  CALL RNGTST

; Routine at 23138
SIXDIG:
  CALL GETYPR
  JP PE,SIXDIG_0
  LD BC,$9143
  LD DE,$4FF9
  CALL FCOMP
  JR SIXDIG_1
SIXDIG_0:
  LD DE,FP_FOUTDL
  CALL CMPPHL
SIXDIG_1:
  JP P,SIXDIG_3
  POP AF
  CALL MULTEN
  PUSH AF
  JR SIXDIG
; This entry point is used by the routine at RNGTST.
SIXDIG_2:
  POP AF
  CALL FINDIV
  PUSH AF
  CALL RNGTST
SIXDIG_3:
  POP AF
  OR A
  POP DE
  RET

; Routine at 23183
;
; Used by the routines at FOUNDB and SIXDIG.
RNGTST:
  CALL GETYPR
  JP PE,RNGTST_0
  LD BC,$9474
  LD DE,$23F8
  CALL FCOMP
  JR RNGTST_1
RNGTST_0:
  LD DE,FP_FOUTDU
  CALL CMPPHL
RNGTST_1:
  POP HL
  JP P,SIXDIG_2
  JP (HL)

; Routine at 23211
;
; Used by the routines at FOUTFX, FOUTTD, FFXSDC and FFXXVS.
FOTZER:
  OR A
FOTZER_0:
  RET Z
  DEC A
  LD (HL),$30
  INC HL
  JR FOTZER_0

; Routine at 23219
;
; Used by the routine at FFXXVS.
FOTZNC:
  JR NZ,FOTZEC

; Routine at 23221
;
; Used by the routine at FOTZEC.
FOTZRC:
  RET Z
  CALL FOUTED

; Routine at 23225
;
; Used by the routines at FFXSDC and FOTZNC.
FOTZEC:
  LD (HL),$30
  INC HL
  DEC A
  JR FOTZRC

; Routine at 23231
;
; Used by the routines at FFXSDC and FFXXVS.
FOUTCD:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
FOUTCD_0:
  SUB $03
  JR NC,FOUTCD_0
  ADD A,$05
  LD C,A

; Routine at 23243
;
; Used by the routine at FOUTFX.
FOUICC:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET

; Routine at 23251
;
; Used by the routine at FOUFRF.
FOUTAN:
  DEC B
  JP P,FOUTED_0
  LD (NXTOPR),HL
  LD (HL),$2E
FOUTAN_0:
  INC HL
  LD (HL),$30
  INC B
  JP NZ,FOUTAN_0
  INC HL
  LD C,B
  RET

; Routine at 23270
;
; Used by the routines at FFXSDC, FFXXVS, FOTZRC, FOUCD1, FOUCS1 and FOUTCI.
FOUTED:
  DEC B
; This entry point is used by the routine at FOUTAN.
FOUTED_0:
  JR NZ,FOUED1

; ENTRY TO PUT A DECIMAL POINT IN THE BUFFER
;
; Used by the routine at FFXXVS.
FOUTDP:
  LD (HL),$2E
  LD (NXTOPR),HL
  INC HL
  LD C,B
  RET

; HERE TO SEE IF IT IS TIME TO PRINT A COMMA
;
; Used by the routine at FOUTED.
FOUED1:
  DEC C
  RET NZ
  LD (HL),$2C
  INC HL
  LD C,$03
  RET

; HERE TO CONVERT A SNG OR DBL NUMBER THAT HAS BEEN NORMALIZED TO DECIMAL
; DIGITS
;
; Used by the routines at FOUFRF, FFXSDC and FFXXVS.
FOUTCV:
  PUSH DE
  CALL GETYPR
  JP PO,FOUTCS
  PUSH BC
  PUSH HL
  CALL VMOVAF
  LD HL,DBL_FP_ZERO
  CALL VMOVFM
  CALL DADD
  XOR A
  CALL INT_4
  POP HL
  POP BC
  LD DE,FP_POWERS_TAB
  LD A,$0A

; HERE TO CONVERT THE NEXT DIGIT
FOUCD1:
  CALL FOUTED
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  LD B,$2F
FOUCD2:
  INC B
  POP HL
  PUSH HL
  LD A,$9E
  CALL DADDFO
  JR NC,FOUCD2
  POP HL
  LD A,$8E
  CALL DADDFO
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JR NZ,FOUCD1
  PUSH BC
  PUSH HL
  LD HL,FACLOW
  CALL MOVFM
  JR FOUCDC
; This entry point is used by the routine at FOUTCV.
FOUTCS:
  PUSH BC
  PUSH HL
  CALL FADDH
  LD A,$01
  CALL QINT
  CALL FPBCDE
FOUCDC:
  POP HL
  POP BC
  XOR A
  LD DE,POWERS_TAB

; HERE TO CALCULATE THE NEXT DIGIT OF THE NUMBER
FOUCS1:
  CCF
  CALL FOUTED
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  CALL BCDEFP
  POP HL
  LD B,$2F
FOUCS2:
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
  JR NC,FOUCS2
  CALL PLUCDE
  INC HL
  CALL FPBCDE
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  JR C,FOUCS1
  INC DE
  INC DE
  LD A,$04
  JR FOUCI1

; HERE TO CONVERT AN INTEGER INTO DECIMAL DIGITS
;
; Used by the routines at SPCFST and FOUTFX.
FOUTCI:
  PUSH DE
  LD DE,INT_POWERS_TAB
  LD A,$05
; This entry point is used by the routine at FOUCS1.
FOUCI1:
  CALL FOUTED
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
  LD B,$2F
FOUCI2:
  INC B
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JR NC,FOUCI2
  ADD HL,DE
  LD (FACCU),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JR NZ,FOUCI1
  CALL FOUTED
  LD (HL),A
  POP DE
  RET

; Data block at 23488
FP_TENTEN:
  DEFB $00,$00,$00,$00,$F9,$02,$15,$A2

; Data block at 23496
FP_FOUTDL:
  DEFB $E1,$FF,$9F,$31,$A9,$5F,$63,$B2

; Data block at 23504
FP_FOUTDU:
  DEFB $FE,$FF,$03,$BF,$C9,$1B,$0E,$B6

; Data block at 23512
DBL_FP_ZERO:
  DEFB $00,$00,$00,$00

; Data block at 23516
FP_HALF:
  DEFB $00,$00,$00,$80

; Data block at 23520
FP_FFXDXM:
  DEFB $00,$00,$04,$BF,$C9,$1B,$0E,$B6

; Data block at 23528
FP_POWERS_TAB:
  DEFB $00,$80,$C6,$A4,$7E,$8D,$03,$00
  DEFB $40,$7A,$10,$F3,$5A,$00,$00,$A0
  DEFB $72,$4E,$18,$09,$00,$00,$10,$A5
  DEFB $D4,$E8,$00,$00,$00,$E8,$76,$48
  DEFB $17,$00,$00,$00,$E4,$0B,$54,$02
  DEFB $00,$00,$00,$CA,$9A,$3B,$00,$00
  DEFB $00,$00,$E1,$F5,$05,$00,$00,$00
  DEFB $80,$96,$98,$00,$00,$00,$00,$40
  DEFB $42,$0F,$00,$00,$00,$00

; Data block at 23598
POWERS_TAB:
  DEFB $A0,$86,$01,$10,$27,$00

; Data block at 23604
INT_POWERS_TAB:
  DEFB $10,$27,$E8,$03,$64,$00,$0A,$00
  DEFB $01,$00

; Routine at 23614
;
; Used by the routines at NUMLIN and __OCT_S.
FOUTO:
  XOR A
  LD B,A

; "JP NZ,nn" AROUND NEXT TWO BYTES
L5C40:
  DEFB $C2

; Routine at 23617
;
; Used by the routines at NUMLIN and __HEX_S.
FOUTH:
  LD B,$01
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
  JR Z,FOUTH_2
  LD C,$04
FOUTH_0:
  ADD HL,HL
  ADC A,A
FOUTH_1:
  ADD HL,HL
  ADC A,A
  ADD HL,HL
  ADC A,A
FOUTH_2:
  ADD HL,HL
  ADC A,A
  OR A
  JP NZ,FOUTH_3
  LD A,C
  DEC A
  JP Z,FOUTH_3
  LD A,(DE)
  OR A
  JP Z,FOUTH_5
  XOR A
FOUTH_3:
  ADD A,$30
  CP $3A
  JP C,FOUTH_4
  ADD A,$07
FOUTH_4:
  LD (DE),A
  INC DE
  LD (DE),A
FOUTH_5:
  XOR A
  DEC C
  JR Z,FOUTH_6
  DEC B
  INC B
  JP Z,FOUTH_1
  JP FOUTH_0
FOUTH_6:
  LD (DE),A
  POP HL
  RET

; Negate number
;
; Used by the routines at POWER and __ATN.
NEGAFT:
  LD HL,NEG
  EX (SP),HL
  JP (HL)

; Routine at 23693
__SQR:
  CALL PUSHF
  LD HL,FP_HALF
  CALL MOVFM
  JR POWER_0

; Routine at 23704
POWER:
  CALL __CSNG
; This entry point is used by the routine at __SQR.
POWER_0:
  POP BC
  POP DE
  LD HL,CLROVC
  PUSH HL
  LD A,$01
  LD (FLGOVC),A
  CALL SIGN
  LD A,B
  JR Z,__EXP
  JP P,POWER_1
  OR A
  JP Z,DZERR
POWER_1:
  OR A
  JP Z,BNORM_2
  PUSH DE
  PUSH BC
  LD A,C
  OR $7F
  CALL BCDEFP
  JP P,POWER_2
  PUSH DE
  PUSH BC
  CALL INT
  POP BC
  POP DE
  PUSH AF
  CALL FCOMP
  POP HL
  LD A,H
  RRA
POWER_2:
  POP HL
  LD (FACCU+2),HL
  POP HL
  LD (FACCU),HL
  CALL C,NEGAFT
  CALL Z,NEG
  PUSH DE
  PUSH BC
  CALL __LOG
  POP BC
  POP DE

; EXP
EXP:
  CALL FMULT

; Routine at 23784
;
; Used by the routine at POWER.
__EXP:
  LD BC,$8138
  LD DE,$AA3B
  CALL FMULT
  LD A,(FPEXP)
  CP $88
  JP NC,__EXP_0
  CP $68
  JP C,GET_UNITY
  CALL PUSHF
  CALL INT
  ADD A,$81
  POP BC
  POP DE
  JP Z,__EXP_1
  PUSH AF
  CALL FSUB
  LD HL,FP_EXPTAB
  CALL POLY_0
  POP BC
  LD DE,$0000
  LD C,D
  JP FMULT
__EXP_0:
  CALL PUSHF
__EXP_1:
  LD A,(FACCU+2)
  OR A
  JP P,__EXP_2
  POP AF
  POP AF
  JP ZERO
__EXP_2:
  JP OVFIN6

; Routine at 23855
;
; Used by the routine at __EXP.
GET_UNITY:
  LD BC,$8100
  LD DE,$0000
  CALL FPBCDE
  RET

; Data block at 23865
FP_EXPTAB:
  DEFB $07,$7C,$88,$59,$74,$E0,$97,$26
  DEFB $77,$C4,$1D,$1E,$7A,$5E,$50,$63
  DEFB $7C,$1A,$FE,$75,$7E,$18,$72,$31
  DEFB $80,$00,$00,$00,$81

; POLYNOMIAL EVALUATOR AND THE RANDOM NUMBER GENERATOR
;
; Used by the routines at __SIN and __ATN.
SUMSER:
  CALL PUSHF
  LD DE,FMULTT
  PUSH DE
  PUSH HL
  CALL BCDEFP
  CALL FMULT

; POLYNOMIAL EVALUATOR
POLY:
  LD (DE),A
  LD C,L
  POP HL
; This entry point is used by the routines at __LOG and __EXP.
POLY_0:
  CALL PUSHF
  LD A,(HL)
  INC HL
  CALL MOVFM

; Data block at 23917
L5D6D:
  DEFB $06

; Routine at 23918
SUMLP:
  POP AF
  POP BC
  POP DE
  DEC A
  RET Z
  PUSH DE
  PUSH BC
  PUSH AF
  PUSH HL
  CALL FMULT
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FADD
  POP HL
  JR SUMLP
  LD D,D
  RST $00
  LD C,A
  ADD A,B
; This entry point is used by the routine at ISFUN.
SUMLP_0:
  CALL CHRGTB
; This entry point is used by the routine at __RANDOMIZE.
SUMLP_1:
  PUSH HL
  LD HL,FP_UNITY
  CALL MOVFM
  CALL __RND
  POP HL
  JP VALSNG

; Routine at 23962
;
; Used by the routine at SUMLP.
__RND:
  CALL SIGN
  LD HL,$5E03
  JP M,__RND_2
  LD HL,RNDX
  CALL MOVFM
  LD HL,$5E03
  RET Z
  ADD A,(HL)
  AND $07
  LD B,$00
  LD (HL),A
  INC HL
  ADD A,A
  ADD A,A
  LD C,A
  ADD HL,BC
  CALL LOADFP
  CALL FMULT
  LD A,($5E02)
  INC A
  AND $03
  LD B,$00
  CP $01
  ADC A,B
  LD ($5E02),A
  LD HL,RNDX
  ADD A,A
  ADD A,A
  LD C,A
  ADD HL,BC
  CALL FADDS
__RND_0:
  CALL BCDEFP
  LD A,E
  LD E,C
  XOR $4F
  LD C,A
  LD (HL),$80
  DEC HL
  LD B,(HL)
  LD (HL),$80
  LD HL,SEED
  INC (HL)
  LD A,(HL)
  SUB $AB
  JR NZ,__RND_1
  LD (HL),A
  INC C
  DEC D
  INC E
__RND_1:
  CALL BNORM
  LD HL,RNDX
  JP FPTHL
__RND_2:
  LD (HL),A
  DEC HL
  LD (HL),A
  DEC HL
  LD (HL),A
  JR __RND_0

; Seed for RND numbers
SEED:
  DEFB $00,$00,$00

; Values table for RND numbers
RNDTAB:
  DEFB $35,$4A,$CA,$99,$39,$1C,$76,$98
  DEFB $22,$95,$B3,$98,$0A,$DD,$47,$98
  DEFB $53,$D1,$99,$99,$0A,$1A,$9F,$98
  DEFB $65,$BC,$CD,$98,$D6,$77,$3E,$98

; Data block at 24100
RNDX:
  DEFB $52,$C7,$4F,$80

; Data block at 24104
RNDTB2:
  DEFB $68,$B1,$46,$68,$99,$E9,$92,$69
  DEFB $10,$D1,$75,$68

; Routine at 24116
;
; Used by the routine at __TAN.
__COS:
  LD HL,FP_HALFPI
  CALL FADDS

; Routine at 24122
;
; Used by the routine at __TAN.
__SIN:
  LD A,(FPEXP)
  CP $77
  RET C
  LD BC,$7E22
  LD DE,$F983
  CALL FMULT
  CALL PUSHF
  CALL INT
  POP BC
  POP DE
  CALL FSUB
  LD BC,$7F00
  LD DE,$0000
  CALL FCOMP
  JP M,__SIN_0
  LD BC,$7F80
  LD DE,$0000
  CALL FADD
  LD BC,$8080
  LD DE,$0000
  CALL FADD
  CALL SIGN
  CALL P,NEG
  LD BC,$7F00
  LD DE,$0000
  CALL FADD
  CALL NEG
__SIN_0:
  LD A,(FACCU+2)
  OR A
  PUSH AF
  JP P,__SIN_1
  XOR $80
  LD (FACCU+2),A
__SIN_1:
  LD HL,FP_SINTAB
  CALL SUMSER
  POP AF
  RET P
  LD A,(FACCU+2)
  XOR $80
  LD (FACCU+2),A
  RET

; Data block at 24226
  DEFB $00,$00,$00,$00

; Data block at 24230
FP_EPSILON:
  DEFB $83,$F9,$22,$7E    ; 1/(2*PI) 0.159155

; Data block at 24234
FP_HALFPI:
  DEFB $DB,$0F,$49,$81    ; 1.5708 (PI/2)

; Data block at 24238
FP_QUARTER:
  DEFB $00,$00,$00,$7F    ; 0.25   (not used)

;HART ALGORITHM 3341 CONSTANTS

;NOTE THAT HART CONSTANTS HAVE BEEN SCALED BY A POWER OF 2
;THIS IS DUE TO RANGE REDUCTION AS A % OF 2*PI RATHER THAN PI/2
;WOULD NEED TO MULTIPLY ARGUMENT BY 4 BUT INSTEAD WE FACTOR THIS
;THRU THE CONSTANTS.

; Data block at 24242
FP_SINTAB:
  DEFB $05                ; Table used by SIN
  DEFB $FB,$D7,$1E,$86    ; 39.711   ->  .1514851E-3
  DEFB $65,$26,$99,$87    ; -76.575  -> -.4673767E-2
  DEFB $58,$34,$23,$87    ; 81.602   ->  .7968968E-1
  DEFB $E1,$5D,$A5,$86    ; -41.342  -> -.6459637
  DEFB $DB,$0F,$49,$83    ; 6.2832   -> 1.570796

; Routine at 24263
__TAN:
  CALL PUSHF
  CALL __SIN
  POP BC
  POP HL
  CALL PUSHF
  EX DE,HL
  CALL FPBCDE
  CALL __COS
  JP DIV

; Routine at 24284
__ATN:
  CALL SIGN
  CALL M,NEGAFT
  CALL M,NEG
  LD A,(FPEXP)
  CP $81
  JR C,__ATN_0
  LD BC,$8100
  LD D,C
  LD E,C
  CALL FDIV
  LD HL,FSUBS
  PUSH HL
__ATN_0:
  LD HL,FP_ATNTAB
  CALL SUMSER
  LD HL,FP_HALFPI
  RET

; Data block at 24322
FP_ATNTAB:
  DEFB $09,$4A,$D7,$3B,$78,$02,$6E,$84
  DEFB $7B,$FE,$C1,$2F,$7C,$74,$31,$9A
  DEFB $7D,$84,$3D,$5A,$7D,$C8,$7F,$91
  DEFB $7E,$E4,$BB,$4C,$7E,$6C,$AA,$AA
  DEFB $7F,$00,$00,$00,$81

; Routine at 24359
DIMRET:
  DEC HL
  CALL CHRGTB
  RET Z
  CALL SYNCHR

; Message at 24367
L5F2F:
  DEFM ","

; Routine at 24368
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

; Routine at 24373
;
; Used by the routines at SRCHLP, __FOR, __LET, L388F, NOTQTI, GTVLUS, L3C52,
; EVAL_VARIABLE, __DEF, ASGMOR, DECNXT, __SWAP, L69DC, __ERASE, __NEXT, L6F67,
; __CALL, GETPAR, CHAIN_COMMON, SCNSMP, LINE_INPUT, L7913 and __LSET.
GETVAR:
  XOR A                   ; Find variable address,to DE       ;MAKE [A]=0
  LD (DIMFLG),A           ; Set locate / create flag          ;FLAG IT AS SUCH
  LD C,(HL)               ; Get First byte of name            ;GET FIRST CHARACTER IN [C]
; This entry point is used by the routine at L402A.
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

; a.k.a. NOARYS
; This entry point is used by the routine at SCNSMP.
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

; This entry point is used by the routine at ZEROER.
NFINPT:
  LD A,(DE)               ;GET LENGTH OF VAR NAME IN [A]

; This entry point is used by the routine at ZEROER.
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
  JP NZ,LOPTOP            ;YES
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

; Routine at 24610
;
; Used by the routine at SMKVAR.
VARNOT:
  LD D,A                  ;ZERO [D,E]
  LD E,A
  POP BC                  ;GET RID OF PUSHED [D,E]
  EX (SP),HL              ;PUT RETURN ADDRESS BACK ON STACK
  RET                     ;RETURN FROM PTRGET

; Routine at 24615
;
; Used by the routine at PTRGET.
SMKVAR:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,VARRET
  CALL DCOMPR
  JR Z,VARNOT
  LD DE,$73A5
  CALL DCOMPR
  JP Z,VARNOT
  LD DE,$73B4
  CALL DCOMPR
  JR Z,VARNOT
  LD DE,$3CBF
  CALL DCOMPR
  POP DE
  JR Z,ZEROER_2
  EX (SP),HL
  PUSH HL
  PUSH BC
  LD A,(VALTYP)
  LD B,A
  LD A,(NAMCNT)
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

; Routine at 24690
ZEROER:
  DEC HL
  LD (HL),$00
  CALL DCOMPR
  JR NZ,ZEROER
  POP DE
  LD (HL),D
  INC HL
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
  CALL FNDARY_17
  EX DE,HL
  INC DE
  POP HL
  RET
; This entry point is used by the routine at PTRGET.
FINPTR:
  INC DE
  LD A,(NAMCNT)
  LD H,A
  LD A,(DE)
  CP H
  JP NZ,NFINPT
  OR A
  JR NZ,ZEROER_1
  INC DE
  POP HL
  RET
ZEROER_1:
  EX DE,HL
  CALL FNDARY_19
  EX DE,HL
  JP NZ,SNOMAT
  POP HL
  RET
; This entry point is used by the routine at SMKVAR.
ZEROER_2:
  LD (FPEXP),A
  LD H,A
  LD L,A
  LD (FACCU),HL
  CALL GETYPR
  JR NZ,ZEROER_3
  LD HL,NULL_STRING
  LD (FACCU),HL
ZEROER_3:
  POP HL
  RET

; Routine at 24759
;
; Used by the routine at PTRGET.
SBSCPT:
  PUSH HL
  LD HL,(DIMFLG)
  EX (SP),HL
  LD D,A
; This entry point is used by the routine at SHTNAM.
SBSCPT_0:
  PUSH DE
  PUSH BC
  LD DE,NAMCNT
  LD A,(DE)
  OR A
  JR Z,SHTNAM
  EX DE,HL
  ADD A,$02
  RRA
  LD C,A
  CALL CHKSTK
  LD A,C
SBSCPT_1:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  DEC A
  JR NZ,SBSCPT_1
  PUSH HL
  LD A,(NAMCNT)
  PUSH AF
  EX DE,HL
  CALL INTIDX
  POP AF
  LD ($0898),HL
  POP HL
  ADD A,$02
  RRA
SBSCPT_2:
  POP BC
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC A
  JR NZ,SBSCPT_2
  LD HL,($0898)
  JR SHTNAM_0

; Routine at 24821
;
; Used by the routine at SBSCPT.
SHTNAM:
  CALL INTIDX
  XOR A
  LD (NAMCNT),A
; This entry point is used by the routine at SBSCPT.
SHTNAM_0:
  LD A,(OPTVAL)
  OR A
  JR Z,SHTNAM_1
  LD A,D
  OR E
  DEC DE
  JP Z,FNDARY_3
SHTNAM_1:
  POP BC
  POP AF
  EX DE,HL
  EX (SP),HL
  PUSH HL
  EX DE,HL
  INC A
  LD D,A
  LD A,(HL)
  CP ','
  JP Z,SBSCPT_0
  CP $29
  JR Z,DOCHRT
  CP $5D
  JP NZ,SN_ERR

; Routine at 24863
;
; Used by the routine at SHTNAM.
DOCHRT:
  CALL CHRGTB
  LD (NXTOPR),HL
  POP HL
  LD (DIMFLG),HL
  LD E,$00
  PUSH DE
  LD DE,$F5E5

; a.k.a. ERSFIN
;
; Used by the routines at PTRGET and CHAIN_COMMON.
ARLDSV:
  PUSH HL
  PUSH AF
  LD HL,(ARYTAB)
  LD A,$19

; Search array table
FNDARY:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  CALL DCOMPR
  JR Z,FNDARY_5
  LD E,(HL)
  INC HL
  LD A,(HL)
  INC HL
  CP C
  JR NZ,FNDARY_0
  LD A,(VALTYP)
  CP E
  JR NZ,FNDARY_0
  LD A,(HL)
  CP B
  JR Z,FNDARY_4
FNDARY_0:
  INC HL
FNDARY_1:
  LD E,(HL)
  INC E
  LD D,$00
  ADD HL,DE
FNDARY_2:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  JR NZ,$6133
  LD A,(DIMFLG)
  OR A
  JP NZ,DD_ERR
  POP AF
  LD B,H
  LD C,L
  JP Z,POPHLRT
  SUB (HL)
  JP Z,FNDARY_10
; This entry point is used by the routines at MLDEBC and SHTNAM.
FNDARY_3:
  LD DE,$0009
  JP ERROR
FNDARY_4:
  INC HL
  LD A,(NAMCNT)
  CP (HL)
  JR NZ,FNDARY_1
  INC HL
  OR A
  JR Z,FNDARY_2
  DEC HL
  CALL FNDARY_19
  JR FNDARY_2
FNDARY_5:
  LD A,(VALTYP)
  LD (HL),A
  INC HL
  LD E,A
  LD D,$00
  POP AF
  JP Z,FNDARY_14
  LD (HL),C
  INC HL
  LD (HL),B
  CALL FNDARY_17
  INC HL
  LD C,A
  CALL CHKSTK
  INC HL
  INC HL
  LD (TEMP3),HL
  LD (HL),C
  INC HL
  LD A,(DIMFLG)
  RLA
  LD A,C
FNDARY_6:
  JR C,FNDARY_7
  PUSH AF
  LD A,(OPTVAL)
  XOR $0B
  LD C,A
  LD B,$00
  POP AF
  JR NC,FNDARY_8
FNDARY_7:
  POP BC
  INC BC
FNDARY_8:
  LD (HL),C
  PUSH AF
  INC HL
  LD (HL),B
  INC HL
  CALL MLDEBC
  POP AF
  DEC A
  JR NZ,FNDARY_6
  PUSH AF
  LD B,D
  LD C,E
  EX DE,HL
  ADD HL,DE
  JP C,OM_ERR
  CALL ENFMEM
  LD (STREND),HL
FNDARY_9:
  DEC HL
  LD (HL),$00
  CALL DCOMPR
  JR NZ,FNDARY_9
  INC BC
  LD D,A
  LD HL,(TEMP3)
  LD E,(HL)
  EX DE,HL
  ADD HL,HL
  ADD HL,BC
  EX DE,HL
  DEC HL
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  POP AF
  JR C,FNDARY_13
FNDARY_10:
  LD B,A
  LD C,A
  LD A,(HL)
  INC HL
  LD D,$E1
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  PUSH AF
  CALL DCOMPR
  JP NC,FNDARY_3
  CALL MLDEBC
  ADD HL,DE
  POP AF
  DEC A
  LD B,H
  LD C,L
  JR NZ,$61F0
  LD A,(VALTYP)
  LD B,H
  LD C,L
  ADD HL,HL
  SUB $04
  JR C,FNDARY_11
  ADD HL,HL
  JR Z,FNDARY_12
  ADD HL,HL
FNDARY_11:
  OR A
  JP PO,FNDARY_12
  ADD HL,BC
FNDARY_12:
  POP BC
  ADD HL,BC
  EX DE,HL
FNDARY_13:
  LD HL,(NXTOPR)
  RET
FNDARY_14:
  SCF
  SBC A,A
  POP HL
  RET
; This entry point is used by the routines at SMPVAR, ARRLP, CLPSLP, CLPAKP and
; DNCMDA.
FNDARY_15:
  LD A,(HL)
  INC HL
FNDARY_16:
  PUSH BC
  LD B,$00
  LD C,A
  ADD HL,BC
  POP BC
  RET
; This entry point is used by the routine at ZEROER.
FNDARY_17:
  PUSH BC
  PUSH DE
  PUSH AF
  LD DE,NAMCNT
  LD A,(DE)
  LD B,A
  INC B
FNDARY_18:
  LD A,(DE)
  INC DE
  INC HL
  LD (HL),A
  DEC B
  JR NZ,FNDARY_18
  POP AF
  POP DE
  POP BC
  RET
; This entry point is used by the routine at ZEROER.
FNDARY_19:
  PUSH DE
  PUSH BC
  LD DE,$0872
  LD B,A
  INC HL
  INC B
FNDARY_20:
  DEC B
  JR Z,FNDARY_21
  LD A,(DE)
  CP (HL)
  INC HL
  INC DE
  JR Z,FNDARY_20
  LD A,B
  DEC A
  CALL NZ,FNDARY_16
  XOR A
  DEC A
FNDARY_21:
  POP BC
  POP DE
  RET
; This entry point is used by the routine at RESTART.
FNDARY_22:
  LD (ERRFLG),A
  LD HL,(ERRLIN)
  OR H
  AND L
  INC A
  EX DE,HL
  RET Z
  JR __EDIT_0

; Routine at 25194
__EDIT:
  CALL LNUM_PARM
  RET NZ
; This entry point is used by the routine at FNDARY.
__EDIT_0:
  POP HL
; This entry point is used by the routine at NOTDGI.
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
; This entry point is used by the routine at EDIT_BRANCH.
__EDIT_1:
  POP HL
; This entry point is used by the routine at PINLIN.
__EDIT_2:
  PUSH HL
  LD A,H
  AND L
  INC A
  LD A,$21
  CALL Z,OUTDO
  CALL NZ,LINPRT
  LD A,$20
  CALL OUTDO
  LD HL,BUF
  PUSH HL
  LD C,$FF
__EDIT_3:
  INC C
  LD A,(HL)
  INC HL
  OR A
  JR NZ,__EDIT_3
  POP HL
  LD B,A

; Routine at 25254
DISPED:
  LD D,$00

; Routine at 25256
DISPI:
  CALL INCHRI
  OR A
  JR Z,DISPI
  CALL UCASE
  SUB $30
  JR C,NOTDGI
  CP $0A
  JR NC,NOTDGI
  LD E,A
  LD A,D
  RLCA
  RLCA
  ADD A,D
  RLCA
  ADD A,E
  LD D,A
  JR DISPI

; Routine at 25283
;
; Used by the routine at DISPI.
NOTDGI:
  PUSH HL
  LD HL,DISPED
  EX (SP),HL
  DEC D
  INC D
  JP NZ,NOTDGI_0
  INC D
NOTDGI_0:
  CP $D8
  JP Z,EDIT_BKSP
  CP $4F
  JP Z,EDIT_DEL
  CP $DD
  JP Z,EDIT_DONE
  CP $F0
  JR Z,EDIT_SPC
  CP $31
  JR C,NOTDGI_1
  SUB $20
NOTDGI_1:
  CP $21
  JP Z,EDIT_QUIT
  CP $1C
  JP Z,EDIT_BRANCH
  CP $23
  JR Z,EDIT_SEARCH
  CP $19
  JP Z,EDIT_INSERT
  CP $14
  JP Z,EDIT_DELETE
  CP $13
  JP Z,EDIT_CHANGE
  CP $15
  JP Z,EDIT_EXIT
  CP $28
  JP Z,EDIT_XTEND
  CP $1B
  JR Z,EDIT_REPLACE
  CP $18
  JP Z,EDIT_HACK
  CP $11
  LD A,$07
  JP NZ,OUTDO
  POP BC
  POP DE
  CALL OUTDO_CRLF
  JP EDIT_LOOP

; Routine at 25382
;
; Used by the routines at NOTDGI and EDIT_XTEND.
EDIT_SPC:
  LD A,(HL)
  OR A
  RET Z
  INC B
  CALL OUTCH1
  INC HL
  DEC D
  JR NZ,EDIT_SPC
  RET

; Routine at 25394
;
; Used by the routine at NOTDGI.
EDIT_REPLACE:
  PUSH HL
  LD HL,TYPSLH
  EX (SP),HL
  SCF

; Routine at 25400
;
; Used by the routine at NOTDGI.
EDIT_SEARCH:
  PUSH AF
  CALL INCHRI
  LD E,A
  POP AF
  PUSH AF
  CALL C,TYPSLH
EDIT_SEARCH_0:
  LD A,(HL)
  OR A
  JP Z,EDIT_SEARCH_2
  CALL OUTCH1
  POP AF
  PUSH AF
  CALL C,EDIT_REMOVE
  JR C,NOTSRC
  INC HL
  INC B
NOTSRC:
  LD A,(HL)
  CP E
  JR NZ,EDIT_SEARCH_0
  DEC D
  JR NZ,EDIT_SEARCH_0
EDIT_SEARCH_2:
  POP AF
  RET

; Routine at 25436
;
; Used by the routine at NOTDGI.
EDIT_BRANCH:
  CALL LISPRT
  CALL OUTDO_CRLF
  POP BC
  JP __EDIT_1

; Routine at 25446
;
; Used by the routine at NOTDGI.
EDIT_DELETE:
  LD A,(HL)
  OR A
  RET Z
  LD A,$5C
  CALL OUTCH1
DELLP:
  LD A,(HL)
  OR A
  JR Z,TYPSLH
  CALL OUTCH1
  CALL EDIT_REMOVE
  DEC D
  JR NZ,DELLP
; This entry point is used by the routine at EDIT_SEARCH.
TYPSLH:
  LD A,$5C
  CALL OUTDO
  RET

; Routine at 25473
;
; Used by the routines at NOTDGI and NOTCCC.
EDIT_CHANGE:
  LD A,(HL)
  OR A
  RET Z
EDIT_CHANGE_0:
  CALL INCHRI
  CP $20
  JR NC,NOTCCC
  CP $0A
  JR Z,NOTCCC
  CP $07
  JR Z,NOTCCC
  CP $09
  JR Z,NOTCCC
  LD A,$07
  CALL OUTDO
  JR EDIT_CHANGE_0

; Routine at 25502
;
; Used by the routine at EDIT_CHANGE.
NOTCCC:
  LD (HL),A
  CALL OUTCH1
  INC HL
  INC B
  DEC D
  JR NZ,EDIT_CHANGE
  RET

; Routine at 25512
;
; Used by the routine at NOTDGI.
EDIT_HACK:
  LD (HL),$00
  LD C,B

; Routine at 25515
;
; Used by the routine at NOTDGI.
EDIT_XTEND:
  LD D,$FF
  CALL EDIT_SPC

; Routine at 25520
;
; Used by the routines at NOTDGI and NTARRW.
EDIT_INSERT:
  CALL INCHRI
  CP $7F
  JR Z,TYPARW
  CP $08
  JR Z,TYPARW_0
  CP $0D
  JP Z,EDIT_DONE
  CP $1B
  RET Z
  CP $08
  JR Z,TYPARW_0
  CP $0A
  JR Z,NTARRW
  CP $07
  JR Z,NTARRW
  CP $09
  JR Z,NTARRW
  CP $20
  JR C,EDIT_INSERT
  CP $5F
  JR NZ,NTARRW

; Routine at 25563
;
; Used by the routine at EDIT_INSERT.
TYPARW:
  LD A,$5F
; This entry point is used by the routine at EDIT_INSERT.
TYPARW_0:
  DEC B
  INC B
  JR Z,DINGI
  CALL OUTCH1
  DEC HL
  DEC B
  LD DE,EDIT_INSERT
  PUSH DE

; Routine at 25578
;
; Used by the routines at EDIT_SEARCH and EDIT_DELETE.
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
  JR EDIT_REMOVE_0

; Routine at 25593
;
; Used by the routine at EDIT_INSERT.
NTARRW:
  PUSH AF
  LD A,C
  CP $FF
  JR C,EDIT_INS_CH
  POP AF
; This entry point is used by the routine at TYPARW.
DINGI:
  LD A,$07
  CALL OUTDO
EDIT_INSERT_LP:
  JR EDIT_INSERT
EDIT_INS_CH:
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
  CALL OUTCH1
  INC HL
  JP EDIT_INSERT_LP

; Routine at 25632
;
; Used by the routine at NOTDGI.
EDIT_BKSP:
  LD A,B
  OR A
  RET Z
  CALL PINLIN_19
  DEC B
  DEC D
  JR NZ,EDIT_DEL
  RET

; Routine at 25643
;
; Used by the routines at NOTDGI and EDIT_BKSP.
EDIT_DEL:
  LD A,B
  OR A
  RET Z
  DEC B
  DEC HL
  LD A,(HL)
  CALL OUTCH1
  DEC D
  JR NZ,EDIT_DEL
  RET

; Routine at 25656
;
; Used by the routines at NOTDGI and EDIT_INSERT.
EDIT_DONE:
  CALL LISPRT

; Routine at 25659
;
; Used by the routine at NOTDGI.
EDIT_EXIT:
  CALL OUTDO_CRLF
  POP BC
  POP DE
  LD A,D
  AND E
  INC A

; Routine at 25667
;
; Used by the routine at AUTSTR.
EDITRT:
  LD HL,BUFMIN
  RET Z
  SCF
  PUSH AF
  INC HL
  JP EDENT

; Routine at 25677
;
; Used by the routine at NOTDGI.
EDIT_QUIT:
  POP BC
  POP DE
  LD A,D
  AND E
  INC A
  JP Z,FININL
  JP READY

; PRINT USING
;
; Used by the routine at __PRINT.
__USING:
  CALL EVAL_0
  CALL TSTSTR
  CALL SYNCHR

; Message at 25697
L6461:
  DEFM ";"

; Routine at 25698
L6462:
  EX DE,HL
  LD HL,(FACCU)
  JR L6462_0
; This entry point is used by the routine at REUSIN.
REUSST:
  LD A,(FLGINP)
  OR A
  JR Z,FCERR3
  POP DE
  EX DE,HL
L6462_0:
  PUSH HL
  XOR A
  LD (FLGINP),A
  CP D
  PUSH AF
  PUSH DE
  LD B,(HL)
  OR B
FCERR3:
  JP Z,FC_ERR
  INC HL
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  JR PRCCHR
; This entry point is used by the routine at PLSFIN.
BGSTRF:
  LD E,B
  PUSH HL
  LD C,$02
LPSTRF:
  LD A,(HL)
  INC HL
  CP $5C
  JP Z,ISSTRF
  CP $20
  JR NZ,NOSTRF
  INC C
  DJNZ LPSTRF
NOSTRF:
  POP HL
  LD B,E
  LD A,$5C
; This entry point is used by the routines at PLSFIN and DOTNUM.
NEWUCH:
  CALL PLS_PRNT
  CALL OUTDO
; This entry point is used by the routine at NOTSCI.
PRCCHR:
  XOR A
  LD E,A
  LD D,A

; Routine at 25763
PLSFIN:
  CALL PLS_PRNT
  LD D,A
  LD A,(HL)
  INC HL
  CP $21
  JP Z,SMSTRF
  CP $23
  JR Z,NUMNUM
  CP $26
  JP Z,VARSTR
  DEC B
  JP Z,REUSIN
  CP $2B
  LD A,$08
  JR Z,PLSFIN
  DEC HL
  LD A,(HL)
  INC HL
  CP $2E
  JR Z,DOTNUM
  CP $5F
  JP Z,LITCHR
  CP $5C
  JR Z,BGSTRF
  CP (HL)
  JR NZ,NEWUCH
  CP $24
  JR Z,DOLRNM
  CP $2A
  JR NZ,NEWUCH
  LD A,B
  INC HL
  CP $02
  JR C,_NOTSPC
  LD A,(HL)
  CP $24
_NOTSPC:
  LD A,$20
  JR NZ,SPCNUM
  DEC B
  INC E

; ; CP AFh ..hides the "XOR A" instruction (MVI SI,  IN 8086)
L64EB:
  DEFB $FE

; Routine at 25836
;
; Used by the routine at PLSFIN.
DOLRNM:
  XOR A
  ADD A,$10
  INC HL

; Routine at 25840
;
; Used by the routine at PLSFIN.
SPCNUM:
  INC E
  ADD A,D
  LD D,A

; Routine at 25843
;
; Used by the routine at PLSFIN.
NUMNUM:
  INC E
  LD C,$00
  DEC B
  JR Z,ENDNUS
  LD A,(HL)
  INC HL
  CP $2E
  JR Z,AFTDOT
  CP $23
  JR Z,NUMNUM
  CP ','
  JR NZ,FINNUM
  LD A,D
  OR $40
  LD D,A
  JR NUMNUM

; Routine at 25869
;
; Used by the routine at PLSFIN.
DOTNUM:
  LD A,(HL)
  CP $23
  LD A,$2E
  JP NZ,NEWUCH
  LD C,$01
  INC HL
; This entry point is used by the routine at NUMNUM.
AFTDOT:
  INC C
  DEC B
  JR Z,ENDNUS
  LD A,(HL)
  INC HL
  CP $23
  JR Z,AFTDOT
; This entry point is used by the routine at NUMNUM.
FINNUM:
  PUSH DE
  LD DE,NOTSCI
  PUSH DE
  LD D,H
  LD E,L
  CP $5E
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

; ; JP Z,nn  to mask the next 2 bytes    ;SKIP THE NEXT TWO BYTES WITH "JZ"
L653E:
  DEFB $CA

; Routine at 25919
NOTSCI:
  EX DE,HL
  POP DE
; This entry point is used by the routines at NUMNUM and DOTNUM.
ENDNUS:
  LD A,D
  DEC HL
  INC E
  AND $08
  JR NZ,ENDNUM
  DEC E
  LD A,B
  OR A
  JR Z,ENDNUM
  LD A,(HL)
  SUB $2D
  JR Z,SGNTRL
  CP $FE
  JR NZ,ENDNUM
  LD A,$08
SGNTRL:
  ADD A,$04
  ADD A,D
  LD D,A
  DEC B
ENDNUM:
  POP HL
  POP AF
  JR Z,FLDFIN
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
  CP $19
  JP NC,FC_ERR
  LD A,D
  OR $80
  CALL PUFOUT
  CALL PRS
; This entry point is used by the routines at ISSTRF and UPRTSP.
FNSTRF:
  POP HL
  DEC HL
  CALL CHRGTB
  SCF
  JR Z,CRDNUS
  LD (FLGINP),A
  CP $3B
  JR Z,SEMUSN
  CP ','
  JP NZ,SN_ERR
SEMUSN:
  CALL CHRGTB
CRDNUS:
  POP BC
  EX DE,HL
  POP HL
  PUSH HL
  PUSH AF
  PUSH DE
  LD A,(HL)
  SUB B
  INC HL
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  LD D,$00
  LD E,A
  ADD HL,DE
; This entry point is used by the routine at REUSIN.
CHKUSI:
  LD A,B
  OR A
  JP NZ,PRCCHR
  JR FINUSI

; Routine at 26026
;
; Used by the routine at PLSFIN.
REUSIN:
  CALL PLS_PRNT
  CALL OUTDO
; This entry point is used by the routine at NOTSCI.
FINUSI:
  POP HL
  POP AF
  JP NZ,REUSST
; This entry point is used by the routines at NOTSCI and ISSTRF.
FLDFIN:
  CALL C,OUTDO_CRLF
  EX (SP),HL
  CALL GSTRHL
  POP HL
  JP FINPRT
; This entry point is used by the routine at PLSFIN.
LITCHR:
  CALL PLS_PRNT
  DEC B
  LD A,(HL)
  INC HL
  CALL OUTDO
  JR CHKUSI

; Routine at 26059
;
; Used by the routine at PLSFIN.
VARSTR:
  LD C,$FF
  JR ISSTRF_0

; Routine at 26063
;
; Used by the routine at PLSFIN.
SMSTRF:
  LD C,$01

; ; "LD A,n" to Mask the next byte      ;SKIP NEXT BYTE WITH A "MVI A,"
L65D1:
  DEFB $3E

; Routine at 26066
;
; Used by the routine at L6462.
ISSTRF:
  POP AF
; This entry point is used by the routine at VARSTR.
ISSTRF_0:
  DEC B
  CALL PLS_PRNT
  POP HL
  POP AF
  JR Z,FLDFIN
  PUSH BC
  CALL EVAL
  CALL TSTSTR
  POP BC
  PUSH BC
  PUSH HL
  LD HL,(FACCU)
  LD B,C
  LD C,$00
  PUSH BC
  CALL __LEFT_S_1
  CALL PRS1
  LD HL,(FACCU)
  POP AF
  INC A
  JP Z,FNSTRF
  DEC A
  SUB (HL)
  LD B,A
  LD A,$20
  INC B

; Routine at 26112
UPRTSP:
  DEC B
  JP Z,FNSTRF
  CALL OUTDO
  JR UPRTSP

; Routine at 26121
;
; Used by the routines at L6462, PLSFIN, REUSIN and ISSTRF.
PLS_PRNT:
  PUSH AF
  LD A,D
  OR A
  LD A,$2B
  CALL NZ,OUTDO
  POP AF
  RET

; Output char in 'A' to console
;
; Used by the routines at PROMPT, NEWSTT_0, SPCLP, NOTQTI, __LIST, __EDIT,
; NOTDGI, EDIT_DELETE, EDIT_CHANGE, NTARRW, L6462, REUSIN, UPRTSP, PLS_PRNT,
; NTBKS1, FININL, OUTCH1, KILIN, PRS1, __FRE, PINLIN, L75C6, CRLFSQ and
; __FILES.
OUTDO:
  PUSH AF
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  JP NZ,FILOUT
  POP HL
  LD A,(PRTFLG)
  OR A
  JP Z,CHPUT
  POP AF
  PUSH AF
  CP $08
  JR NZ,NTBKS2
  LD A,(LPTPOS)
  DEC A
  LD (LPTPOS),A
  POP AF
  JR OUTC_2
NTBKS2:
  CP $09
  JR NZ,OUTC
TABEXP_LOOP:
  LD A,$20
  CALL OUTDO
  LD A,(LPTPOS)
  AND $07
  JR NZ,TABEXP_LOOP
  POP AF
  RET

; Routine at 26183
;
; Used by the routine at OUTDO.
OUTC:
  POP AF
  PUSH AF
  SUB $0D
  JR Z,OUTC_1
  JR C,_OUTPRT
  LD A,(LPTSIZ)
  INC A
  LD A,(LPTPOS)
  JR Z,OUTC_0
  PUSH HL
  LD HL,LPTSIZ
  CP (HL)
  POP HL
  CALL Z,L6674_0
  JR Z,_OUTPRT
OUTC_0:
  CP $FF
  JR Z,_OUTPRT
  INC A
OUTC_1:
  LD (LPTPOS),A
_OUTPRT:
  POP AF
; This entry point is used by the routines at OUTDO and L6674.
OUTC_2:
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,A

; CALL..
L6671:
  DEFB $CD

; Data block at 26226
SMC_LPTOUT:
  DEFW $0000

; Routine at 26228
L6674:
  POP HL
  POP DE
  POP BC
  POP AF
  RET
; This entry point is used by the routines at RESTART, STKINI and ENDCON.
FINLPT:
  XOR A
  LD (PRTFLG),A
  LD A,(LPTPOS)
  OR A
  RET Z
; This entry point is used by the routine at OUTC.
L6674_0:
  LD A,$0D
  CALL OUTC_2
  LD A,$0A
  CALL OUTC_2
  XOR A
  LD (LPTPOS),A
  RET
; This entry point is used by the routines at L4423 and OUTDO.
CHPUT:
  LD A,(CTLOFG)
  OR A
  JP NZ,POPAF
  POP AF
  PUSH BC
  PUSH AF
  CP $0A
  JR NZ,L6674_2
  CALL L670C_1
  LD A,$0A
L6674_2:
  CP $08
  JR NZ,NTBKS1
  LD A,(TTYPOS)
  OR A
  JR NZ,L6674_3
  LD A,(TTY_VPOS)
  OR A
  JR Z,NTBKS1_0
  DEC A
  LD (TTY_VPOS),A
  LD A,(LINLEN)
L6674_3:
  DEC A
  LD (TTYPOS),A
  LD A,$08
  JR NOTAB_0

; Routine at 26307
;
; Used by the routine at L6674.
NTBKS1:
  CP $09
  JR NZ,NOTAB
TAB_LOOP:
  LD A,$20
  CALL OUTDO
  LD A,(TTYPOS)
  AND $07
  JR NZ,TAB_LOOP
; This entry point is used by the routine at L6674.
NTBKS1_0:
  POP AF
  POP BC
  RET

; Routine at 26326
;
; Used by the routine at NTBKS1.
NOTAB:
  CP $20
  JR C,NOTAB_0
; This entry point is used by the routine at L6674.
NOTAB_0:
  POP AF
  PUSH AF
  CALL TRYOUT
  CP $20
  JR C,INCTPS
  LD A,(LINLEN)
  INC A
  JR Z,INCTPS
  DEC A
  LD B,A
  LD A,(TTYPOS)
  INC A
  JR Z,INCTPS
  LD (TTYPOS),A
  CP B
  JR NZ,INCTPS
  LD A,(L4B97)
  CP B
  CALL Z,L670C_0
  CALL NZ,OUTDO_CRLF
INCTPS:
  POP AF
  POP BC
  RET

; Routine at 26372
;
; Used by the routines at NORVS, CONUA, CONUE and NOTAB.
TRYOUT:
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,A

; Data block at 26377
L6709:
  DEFB $CD

; Data block at 26378
SMC_CONOUT:
  DEFW $0000

; Routine at 26380
L670C:
  POP HL
  POP DE
  POP BC
  POP AF
  RET
  
  
; This entry point is used by the routine at NOTAB.
L670C_0:
  CALL CRFIN
; This entry point is used by the routine at L6674.
L670C_1:
  LD A,(CRTCNT)
  LD B,A
  LD A,(TTY_VPOS)
  INC A
  CP B
  JR NC,L670C_2
  LD (TTY_VPOS),A
L670C_2:
  XOR A
  RET


; This entry point is used by the routines at SRCHLP, __FRE and PINLIN.
INCHR:
  PUSH HL
  LD HL,(PTRFIL)         ; (*** -> ISFLIO)
  LD A,H
  OR L
  JR Z,INCHRI_0          ;GET CHARACTER FROM TERMINAL
  CALL RDBYT
  JP NC,POPHLRT          ;RETURN WITH CHARACTER

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
  LD HL,NEWSTT
  EX (SP),HL
  JP NZ,RUN_FST
  
  EX (SP),HL
  PUSH BC
  PUSH DE
  LD HL,OK_MSG
  CALL PRS
  POP DE
  POP BC
  XOR A
  POP HL
  RET
  
INCHRI_0:
  POP HL

; Routine at 26460
;
; Used by the routines at DISPI, EDIT_SEARCH, EDIT_CHANGE, EDIT_INSERT, STALL,
; L67D8 and L7A0F.
INCHRI:
  PUSH BC
  PUSH DE
  PUSH HL

; CALL..
L675F:
  DEFB $CD

; Data block at 26464
SMC_CONIN:
  DEFW $0000

; Routine at 26466
L6762:
  POP HL                ;RESTORE REGS
  POP DE
  POP BC
  AND $7F               ; (This mask is missing on the Otrona Attachè variant)

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
; This entry point is used by the routines at ERRMOR, RESTART, _LINE2PTR and
; ENDCON.
CONSOLE_CRLF:
  LD A,(TTYPOS)         ;GET CURRENT TTYPOS
  OR A                  ;SET CC'S
  RET Z                 ;IF ALREADY ZERO, RETURN
  JP OUTDO_CRLF         ;DO CR

; Routine at 26499
;
; Used by the routines at EDIT_QUIT and PINLIN.
FININL:
  LD (HL),$00           ;PUT A ZERO AT THE END OF BUF
  LD HL,BUFMIN			;SETUP POINTER

; Print and go to new line
;
; This entry point is used by the routines at ERRMOR, __PRINT, DOSPC, __LIST,
; NOTDGI, EDIT_BRANCH, EDIT_EXIT, REUSIN, NOTAB, L6762, KILIN, PINLIN, NTRNDW,
; __FILES and DONCMD.
OUTDO_CRLF:
  LD A,$0D              ; CR
  CALL OUTDO            ; Output char to the current device
  LD A,$0A              ; LF
  CALL OUTDO            ; Output char to the current device

; This entry point is used by the routines at L670C, OUTCH1 and PRS1.
CRFIN:
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  POP HL
  JR Z,CRCONT
  XOR A
  RET

CRCONT:
  LD A,(PRTFLG)
  OR A
  JR Z,NTPRTR
  XOR A
  LD (LPTPOS),A
  RET

NTPRTR:
  XOR A
  LD (TTYPOS),A
  XOR A
  RET

; This entry point is used by the routine at __LIST.
FININL_3:
  PUSH BC
  PUSH DE
  PUSH HL

; CALL..
L67B1:
  DEFB $CD

; Data block at 26546
SMC_ISCNTC3:
  DEFW $0000

; Routine at 26548
L67B4:
  POP HL
  POP DE
  POP BC
  OR A
  RET Z

; Routine at 26553
;
; Used by the routine at NEWSTT_0.
STALL:
  CALL INCHRI
  CP $13
  CALL Z,INCHRI
  LD (CHARC),A
  CP $03
  CALL Z,KILIN
  JP __STOP

; Routine at 26572
;
; Used by the routine at NTVARP.
FN_INKEY:
  CALL CHRGTB
  PUSH HL
  CALL CHARCG
  JR NZ,BUFCIN

; CALL..
L67D5:
  DEFB $CD

; Data block at 26582
SMC_ISCNTC2:
  DEFW $0000

; Routine at 26584
L67D8:
  OR A
  JR Z,L67D8_0
  CALL INCHRI
; This entry point is used by the routine at FN_INKEY.
BUFCIN:
  PUSH AF
  CALL STRIN1
  POP AF
  LD E,A
  CALL __ASC_1
L67D8_0:
  LD HL,NULL_STRING
  LD (FACCU),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET
; This entry point is used by the routines at SRCHLP, FN_INKEY and L7A0F.
CHARCG:
  LD A,(CHARC)
  OR A
  RET Z
  PUSH AF
  XOR A
  LD (CHARC),A
  POP AF
  RET

; Routine at 26624
;
; Used by the routines at LISPRT, EDIT_SPC, EDIT_SEARCH, EDIT_DELETE, NOTCCC,
; TYPARW, NTARRW and EDIT_DEL.
OUTCH1:
  CALL OUTDO
  CP $0A
  RET NZ
  LD A,$0D
  CALL OUTDO
  CALL CRFIN
  LD A,$0A
  RET

; Routine at 26641
;
; Used by the routines at LEVFRE and SMKVAR.
MOVUP:
  CALL ENFMEM

; Routine at 26644
;
; Used by the routines at NTARRW, SCNEND and CDVARS.
MOVSTR:
  PUSH BC
  EX (SP),HL
  POP BC

; Routine at 26647
MOVLP:
  CALL DCOMPR
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JR MOVLP

; Check for C levels of stack
;
; Used by the routines at FORFND, __GOSUB, EVAL, ASGMOR, L3F72, SBSCPT, FNDARY
; and __CALL.
CHKSTK:
  PUSH HL
  LD HL,(MEMSIZ)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  LD A,$C6
  SUB L
  LD L,A
  LD A,$FF
  SBC A,H
  JR C,OM_ERR
  LD H,A
  ADD HL,SP
  POP HL
  RET C

; Routine at 26678
;
; Used by the routines at FNDARY, CHKSTK, L6A82, LOAD_OM_ERR and DONCMD.
OM_ERR:
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
; This entry point is used by the routine at ENFMEM.
OM_ERR_0:
  LD DE,$0007
  JP ERROR

; Routine at 26692
;
; Used by the routines at FNDARY, MOVUP and DONCMD.
ENFMEM:
  CALL REALLY
  RET NC
  PUSH BC
  PUSH DE
  PUSH HL
  CALL GARBGE
  POP HL
  POP DE
  POP BC
  CALL REALLY
  RET NC
  JR OM_ERR_0
REALLY:
  PUSH DE
  EX DE,HL
  LD HL,(FRETOP)
  CALL DCOMPR
  EX DE,HL
  POP DE
  RET
; This entry point is used by the routine at PROCHK.
NODSKS:
  LD A,(MAXFIL)
  LD B,A
  LD HL,FILPTR
  XOR A
  INC B
LOPNTO:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD (DE),A
  DJNZ LOPNTO
  CALL CLSALL
  XOR A

; Routine at 26742
__NEW:
  RET NZ

; Routine at 26743
;
; Used by the routines at NOTRNL and LOAD_OM_ERR.
CLRPTR:
  LD HL,(TXTTAB)
  CALL __NOTRACE
  LD (PROFLG),A
  LD (AUTFLG),A
  LD (PTRFLG),A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (VARTAB),HL

; Routine at 26765
;
; Used by the routines at FINI, __RUN, L670C and BINLOD.
RUN_FST:
  LD HL,(TXTTAB)
  DEC HL
; This entry point is used by the routines at __RUN, __CLEAR, L6A5D and L6A82.
;CLVAR:
CLEARC:
  LD (TEMP),HL
  LD A,(MRGFLG)
  OR A
  JR NZ,LEVDTB
  XOR A
  LD (OPTFLG),A
  LD (OPTVAL),A
  LD B,$1A
  LD HL,DEFTBL
LOPDFT:
  LD (HL),$04
  INC HL
  DJNZ LOPDFT
LEVDTB:
  LD DE,$5D85
  LD HL,RNDX
  CALL INCHL_1
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
  LD A,(CHNFLG)
  OR A
  JR NZ,GOOD_FRETOP
  LD (FRETOP),HL
GOOD_FRETOP:
  XOR A
  CALL __RESTORE
  LD HL,(VARTAB)
  LD (ARYTAB),HL
  LD (STREND),HL
  LD A,(MRGFLG)
  OR A
  CALL Z,CLSALL

; Routine at 26857
STKINI:
  POP BC
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  INC HL
  INC HL
; This entry point is used by the routine at ERRESM.
STKERR:
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL CLROVC
  CALL FINLPT
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

; Routine at 26907
;
; Used by the routines at LOAD_END, OPNFIL and __GET.
GTMPRT:
  LD HL,(TEMP)
  RET

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at LOKFOR, ERRMOR, AUTGOD, SRCHLP, L329B, ATOH, __GOTO,
; L35E2, L3F72, __LIST, __DELETE, L4305, L4423, ADDIG, OVERR, SMKVAR, ZEROER,
; FNDARY, MOVLP, ENFMEM, L69DC, __ERASE, L6A82, __NEXT, TSTOPL, GRBDON, TVAR,
; SMPVAR, ARRLP, ARYSTR, STRADD, GSTRDE, L6F67, FNDWND, L7317, CLPSLP, DLSVLP,
; CLPAKP, DNCMDA, CAYSTR, CDVARS, BINSAV, L7913, __LSET, LPBLDR, VARECS and
; __GET.
DCOMPR:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; Check syntax, 1 byte follows to be compared
;
; Used by the routines at __FOR, FORFND, __LET, __ON, L364D, __AUTO, __IF,
; LNOMOD, __LINE, __INPUT, INPCON, FRMEQL, OPNPAR, __VARPTR, L3C52, EVLPAR,
; ISFUN, DEF_USR, __DEF, DOFN, ASGMOR, L3F13, FINASG, IDTEST, __POKE, __RENUM,
; L42FB, __OPTION, L4417, L441B, L441F, DECNXT, __COLOR, L4646, L466B,
; GET_2_ARGS, __WAIT, L472A, FN_SCRN, L4764, __CALL_6502, L47A8, FN_HSCRN,
; L47F6, __HCOLOR, SCAND, DIMRET, __USING, __SWAP, __CLEAR, L6A5D, FN_STRING,
; L6E1A, L6E22, LFRGNM, FN_INSTR, L6EF1, L6EFB, LHSMID, L6F67, MID_ARGSEP,
; L6FEB, __CALL, GETPAR, __CHAIN, L72E5, L72FE, L7308, L730C, L7310, BCKUCM,
; L73ED, __WRITE, GDFILM, __LOAD, L7795, __SAVE, L7871, __FIELD, L790F,
; FN_INPUT, L79EE, L79F2, __NAME, L7CCB, HAVMOD, L7D22, WASM, L8316 and WASS.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  JR NZ,SYNCHR_0
  INC HL
  EX (SP),HL
  INC HL
  LD A,(HL)
  CP $3A
  RET NC
  JP CHRCON
SYNCHR_0:
  JP SN_ERR

; Routine at 26935
;
; Used by the routine at RUN_FST.
__RESTORE:
  EX DE,HL
  LD HL,(TXTTAB)
  JR Z,__RESTORE_0
  EX DE,HL
  CALL ATOH
  PUSH HL
  CALL SRCHLN
  LD H,B
  LD L,C
  POP DE
  JP NC,UL_ERR
__RESTORE_0:
  DEC HL
; This entry point is used by the routine at LTSTND.
UPDATA:
  LD (DATPTR),HL
  EX DE,HL
  RET

; Routine at 26961
;
; Used by the routine at STALL.
__STOP:
  RET NZ
  INC A
  JP __END_0

; Routine at 26966
__END:
  RET NZ
  PUSH AF
  CALL Z,CLSALL
  POP AF
; This entry point is used by the routine at __STOP.
__END_0:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL

  DEFB $21                ; "LD HL,nn" to jump over the next word without executing it

; Get here if the "INPUT" sequence was interrupted
;
; Used by the routines at __LINE, NOTQTI and __RANDOMIZE.
INPBRK:
  OR $FF            ;SET NON-ZERO TO FORCE PRINTING OF BREAK MESSAGE
  POP BC            ;POP OFF NEWSTT ADDRESS


; BASIC jumps here on a STOP program condition
;
; Used by the routines at PRG_END and INTCTC.
ENDCON:
  LD HL,(CURLIN)
  PUSH HL
  PUSH AF
  LD A,L
  AND H
  INC A
  JR Z,ENDCON_0
  LD (OLDLIN),HL
  LD HL,(SAVTXT)
  LD (OLDTXT),HL
ENDCON_0:
  XOR A
  LD (CTLOFG),A
  CALL FINLPT
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG
  JP NZ,ERRMOR_5
  JP RESTART

; This entry point is used by the routine at L6762.
CTROPT:
  LD A,$0F

; Routine at 27026
;
; Used by the routines at STALL and PINLIN.
KILIN:
  PUSH AF
  SUB $03
  JR NZ,KILIN_0
  LD (PRTFLG),A
  LD (CTLOFG),A
KILIN_0:
  LD A,$5E
  CALL OUTDO
  POP AF
  ADD A,$40
  CALL OUTDO
  JP OUTDO_CRLF

; Routine at 27051
__CONT:
  LD HL,(OLDTXT)
  LD A,H
  OR L
  LD DE,$0011
  JP Z,ERROR
  EX DE,HL
  LD HL,(OLDLIN)
  LD (CURLIN),HL
  EX DE,HL
  RET

; a.k.a. TRON
__TRACE:
  LD A,$AF

; a.k.a. TROFF
;
; Used by the routine at CLRPTR.
__NOTRACE:
  XOR A
  LD (TRCFLG),A
  RET

; Routine at 27077
__SWAP:
  CALL GETVAR
  PUSH DE
  PUSH HL
  LD HL,SWPTMP
  CALL VMOVE
  LD HL,(ARYTAB)
  EX (SP),HL
  CALL GETYPR
  PUSH AF
  CALL SYNCHR

; Message at 27099
L69DB:
  DEFM ","

; Routine at 27100
L69DC:
  CALL GETVAR
  POP BC
  CALL GETYPR
  CP B
  JP NZ,TM_ERR
  EX (SP),HL
  EX DE,HL
  PUSH HL
  LD HL,(ARYTAB)
  CALL DCOMPR
  JP NZ,FC_ERR
  POP DE
  POP HL
  EX (SP),HL
  PUSH DE
  CALL VMOVE
  POP HL
  LD DE,SWPTMP
  CALL VMOVE
  POP HL
  RET

; Routine at 27139
__ERASE:
  LD A,$01
  LD (SUBFLG),A           ;THAT THIS IS "ERASE" CALLING PTRGET
  CALL GETVAR             ;GO FIND OUT WHERE TO ERASE
  JP NZ,FC_ERR            ;PTRGET DID NOT FIND VARIABLE!
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

; This entry point is used by the routine at FILOUT.
POPAHT:
  POP AF
  POP HL                  ;GET THE TEXT POINTER
  RET

; Load A with char in (HL) and check it is a letter:
;
; Routine at 27200
;
; Used by the routines at DEFCON and PTRGET.
CHKLTR:
  LD A,(HL)

; Check char in 'A' being in the 'A'..'Z' range
;
; Used by the routines at TOKENIZE, KRNSAV, OPRND, OCTCNS, TSTANM and PTRGET.
ISLETTER_A:
  CP 'A'            ; < "A" ?
  RET C             ; Carry set if not letter
  CP 'Z'+1          ; > "Z" ?
  CCF               
  RET               ; Carry set if not letter



; 'CLEAR' BASIC command
;
; To set all numeric variables to zero and all string variables to null; and, optionally,
; to set the end of memory and the amount of stack space.
;
; CLEAR [,[<expressionl>] [,<expression2>]]
;
; Routine at 27208
__CLEAR:
  JP Z,CLEARC             ; Just "CLEAR" Keep parameters    ;IF NO FORMULA JUST CLEAR
  CP ','                  ;ALLOW NO STRING SPACE
  JR Z,__CLEAR_0
  CALL INTIDX_0           ;GET AN INTEGER INTO [D,E]
  DEC HL
  CALL CHRGTB             ; Get next character, SEE IF ITS THE END
  JP Z,CLEARC

__CLEAR_0:
  CALL SYNCHR
  DEFM ","
  JP Z,CLEARC
  EX DE,HL
  LD HL,(STKTOP)          ;GET HIGHEST ADDRESS
  EX DE,HL
  CP ','
  JR Z,__CLEAR_1          ; No value given - Use stored           ;SHOULD FINISH THERE
  CALL EVAL               ; Get integer to DE
  PUSH HL
  CALL GETWORD_HL
  LD A,H
  OR L
  JP Z,FC_ERR
  EX DE,HL
  POP HL
  
__CLEAR_1:
  DEC HL                  ; Cancel increment   (BACK UP)
  CALL CHRGTB             ;GET CHAR
  PUSH DE                 ;SAVE NEW HIGH MEM
  JR Z,CDFSTK             ;USE SAME STACK SIZE
  CALL SYNCHR             ; Check for comma
  DEFM ","
  JR Z,CDFSTK
  CALL INTIDX_0           ; Get integer to DE
  DEC HL                  ; Cancel increment
  CALL CHRGTB             ; Get next character
  JP NZ,SN_ERR            ; ?SN Error if more on line

CLEART:
  EX (SP),HL              ; Save code string address
  PUSH HL                 ; Save code string address (again)
  LD HL,0+(NUMLEV*2)+20   ; CHECK STACK SIZE IS REASONABLE
  CALL DCOMPR
  JP NC,OM_ERR
  POP HL                  ; [HL]=candidate for TOPMEM                         ; Restore code string address (1st copy)
  CALL SUBDE              ; DE=HL-DE=High Ram - Stack Size=new stack bottom   ; SUBTRACT [H,L]-[D,E] INTO [D,E]
  JP C,OM_ERR             ; WANTED MORE THAN TOTAL!

  PUSH HL                 ; Save RAM top                       ;SAVE STACK BOTTOM
  LD HL,(VARTAB)          ; Get program end                    ;TOP LOCATION IN USE
  LD BC,20                ; 20 Bytes minimum working RAM       ;LEAVE BREATHING ROOM
  ADD HL,BC               ; Get lowest address
  CALL DCOMPR             ; Enough memory?
  JP NC,OM_ERR            ; No - ?OM Error
  EX DE,HL                ; RAM top to HL
  LD (MEMSIZ),HL          ; Set new string space
  POP HL                  ; End of memory to use
  LD (STKTOP),HL          ; Set new top of RAM
  POP HL                  ; Restore code string address
  JP CLEARC               ; Initialise variables

;;OMERR:
;;  JP OM_ERR


; Routine at 27322
;
; Used by the routines at L6A5D and L6A82.
CDFSTK:
  PUSH HL
  LD HL,(STKTOP)          ;FIGURE OUT CURRENT STACK SIZE
  EX DE,HL
  LD HL,(MEMSIZ)
  LD A,E
  SUB L
  LD E,A
  LD A,D
  SBC A,H
  LD D,A
  POP HL
  JR CLEART


;SUBTRACT [H,L]-[D,E] INTO [D,E]
;
; Routine at 27339
;
; Used by the routine at L6A82.
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

; Routine at 27346
__NEXT:
  PUSH AF                 ;SAVE THE CHARACTER CODES
  DEFB $F6                ; "OR n" to Mask 'XOR A';   SET [A] NON-ZERO

  LD (NEXFLG),A
  POP AF
  LD DE,$0000
__NEXT_0:
  LD (NEXTMP),HL          ; SAVE STARTING TEXT POINTER
  CALL NZ,GETVAR          ; not end of statement, locate variable (Get index address)
  LD (TEMP),HL
  CALL BAKSTK
  JP NZ,NF_ERR
  LD SP,HL
  PUSH DE
  LD E,(HL)
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
  JP M,__NEXT_2
  CALL MOVFM
  EX (SP),HL
  PUSH HL
  LD A,(NEXFLG)
  OR A
  JR NZ,NXTDO             ; NO, CONTINUE "NEXT"
  LD HL,FVALSV            ; FETCH THE INITIAL VALUE INTO THE FAC
  CALL MOVFM
  XOR A                   ; CONTINUE THE "NEXT" WITH INITIAL VALUE

NXTDO:
  CALL NZ,FADDS
  POP HL
  CALL FPTHL
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FCOMP
  JR __NEXT_5

__NEXT_2:
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
  JR NZ,__NEXT_3
  LD HL,(FVALSV)
  JR __NEXT_4
__NEXT_3:
  CALL IADD
  LD A,(VALTYP)
  CP $04
  JP Z,OV_ERR
__NEXT_4:
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
__NEXT_5:
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


; Remove "FOR" block
;
KILFOR:
  LD SP,HL
  LD (SAVSTK),HL
  LD HL,(TEMP)
  LD A,(HL)
  CP ','
  JP NZ,NEWSTT
  CALL CHRGTB
  CALL __NEXT_0


;
; THE FOLLOWING ROUTINE COMPARES TWO STRINGS
; ONE WITH DESC IN [D,E] OTHER WITH DESC. IN [FACLO, FACLO+1]
; A=0 IF STRINGS EQUAL
; A=377 IF B,C,D,E .GT. FACLO
; A=1 IF B,C,D,E .LT. FACLO
;
; Routine at 27523
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
  POP DE
  LD E,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP HL

; a.k.a. CMPSTR
CSLOOP:
  LD A,E                   ; Bytes of string 2 to do         ;BOTH STRINGS ENDED
  OR D                     ; Bytes of string 1 to do         ;TEST BY OR'ING THE LENGTHS TOGETHER
  RET Z                    ; Exit if all bytes compared      ;IF SO, RETURN WITH A ZERO
  LD A,D                   ; Get bytes of string 1 to do     ;GET FACLO STRING LENGTH
  SUB 1                                                      ;SET CARRY AND MAKE [A]=255 IF [D]=0
  RET C                    ; Exit if end of string 1         ;RETURN IF THAT STRING ENDED
  XOR A                                                      ;MUST NOT HAVE BEEN ZERO, TEST CASE
  CP E                     ; (***) Bytes of string 2 to do         ;OF B,C,D,E STRING HAVING ENDED FIRST
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
; Routine at 27567
__OCT_S:
  CALL FOUTO             ;PUT OCTAL NUMBER IN FBUFFR
  JR __STR_S_0             ;JUMP INTO STR$ CODE

; 'HEX$' BASIC function
; STRH$ SAME AS STRO$ EXCEPT USES HEX INSTEAD OF OCTAL
;
; Routine at 27572
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
; Routine at 27590
;
; Used by the routines at CRESTR, L3F72, L6F67 and CDVARS.
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

; This entry point is used by the routines at L67D8 and __ASC.
STRIN1:
  LD A,$01                ;MAKE ONE CHAR STRING (CHR$, INKEY$)


; Make temporary string
;
; Used by the routines at CONCAT, __SPACE_S, __MKD_S, MAKDSC and L7A0F.
MKTMST:
  CALL TESTR              ; See if enough string space


; Create temporary string entry
;
; Used by the routines at STRCPY, DTSTR and MID1.
CRTMST:
  LD HL,DSCTMP            ; Temporary string          ;GET DESC. TEMP
; This entry point is used by the routine at SRCHLP.
CRTMST_0:
  PUSH HL                 ; Save it                   ;SAVE DESC. POINTER
  LD (HL),A               ; Save length of string     ;SAVE CHARACTER COUNT
  INC HL                                              ;STORE [D,E]=POINTER TO FREE SPACE
  LD (HL),E               ; Save LSB of address
  INC HL
  LD (HL),D               ; Save MSB of address
  POP HL                  ; Restore pointer           ;AND RESTORE [H,L] AS THE DESCRIPTOR POINTER
  RET

; Create String
;
; Used by the routines at __PRINT, __STR_S, PRS and __WRITE.
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
; a.k.a. STRLTI
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,'"'                ; Terminating quote               ;ASSUME STR ENDS ON QUOTE
; This entry point is used by the routine at L388F.
QTSTR_0:
  LD D,B                  ; Quote to D


; Create String, termination char in D
; a.k.a. STRLT2
;
; Used by the routines at DOASIG and LINE_INPUT.
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
; Used by the routines at CONCAT, TOPOOL, MID1, MAKDSC and PUTCHR.
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
  LD (TEMPPT),HL
  POP HL
  LD A,(HL)
  RET NZ
  LD DE,$0010
  JP ERROR

; Print number string
PRNUMS:
  INC HL

; Create string entry and print it
;
; Used by the routines at ERRMOR, RDOIN2, __DELETE, _LINE2PTR, __RANDOMIZE,
; IN_PRT, NOTSCI, L670C and DONCMD.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routines at __PRINT, __INPUT_2, ISSTRF, __WRITE and L75C6.
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
  CALL Z,CRFIN
  INC BC
  JR PRS1_0

; Test if enough room for string
;
; Used by the routines at SRCHLP, STRCPY, MKTMST, MID1 and __LSET.
TESTR:
  OR A
  LD C,$F1

; Routine at 27738
GRBDON:
  POP AF
  PUSH AF
  LD HL,(STREND)
  EX DE,HL
  LD HL,(FRETOP)
  CPL
  LD C,A
  LD B,$FF
  ADD HL,BC
  INC HL
  CALL DCOMPR
  JR C,TESTOS
  LD (FRETOP),HL
  INC HL
  EX DE,HL

; Routine at 27763
;
; Used by the routines at L4193 and L6674.
POPAF:
  POP AF
  RET

; Routine at 27765
;
; Used by the routine at GRBDON.
TESTOS:
  POP AF
  LD DE,$000E
  JP Z,ERROR
  CP A
  PUSH AF
  LD BC,GRBDON
  PUSH BC

; Routine at 27778
;
; Used by the routines at ENFMEM, __FRE and CDVARS.
GARBGE:
  LD HL,(MEMSIZ)
; This entry point is used by the routine at SCNEND.
GARBLP:
  LD (FRETOP),HL
  LD HL,$0000
  PUSH HL
  LD HL,(STREND)
  PUSH HL
  LD HL,TEMPST

; Routine at 27795
TVAR:
  EX DE,HL
  LD HL,(TEMPPT)
  EX DE,HL
  CALL DCOMPR
  LD BC,TVAR
  JP NZ,STPOOL
  LD HL,PRMPRV
  LD (TEMP9),HL
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)

; Routine at 27824
;
; Used by the routines at SKPVAR and ARYVAR.
SMPVAR:
  EX DE,HL
  LD HL,(ARYTA2)
  EX DE,HL
  CALL DCOMPR
  JR Z,ARYVAR
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  PUSH AF
  CALL FNDARY_15
  POP AF
  CP $03
  JR NZ,SKPVAR
  CALL STRADD
  XOR A

; Routine at 27851
;
; Used by the routine at SMPVAR.
SKPVAR:
  LD E,A
  LD D,$00
  ADD HL,DE
  JR SMPVAR

; Routine at 27857
;
; Used by the routine at SMPVAR.
ARYVAR:
  LD HL,(TEMP9)
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  OR H
  EX DE,HL
  LD HL,(ARYTAB)
  JR Z,ARRLP
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
  JR SMPVAR

; Routine at 27889
;
; Used by the routine at ARRLP.
GNXARY:
  POP BC

; Routine at 27890
;
; Used by the routines at ARYVAR and ARYSTR.
ARRLP:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  CALL DCOMPR
  JP Z,SCNEND
  LD A,(HL)
  INC HL
  PUSH AF
  INC HL
  INC HL
  CALL FNDARY_15
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  POP AF
  PUSH HL
  ADD HL,BC
  CP $03
  JR NZ,GNXARY
  LD (TEMP8),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL

; Routine at 27930
ARYSTR:
  EX DE,HL
  LD HL,(TEMP8)
  EX DE,HL
  CALL DCOMPR
  JR Z,ARRLP
  LD BC,ARYSTR

; Routine at 27943
;
; Used by the routine at TVAR.
STPOOL:
  PUSH BC

; Routine at 27944
;
; Used by the routine at SMPVAR.
STRADD:
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
  CALL DCOMPR
  LD H,B
  LD L,C
  RET C
  POP HL
  EX (SP),HL
  CALL DCOMPR
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

; Routine at 27980
;
; Used by the routine at ARRLP.
SCNEND:
  POP DE
  POP HL
  LD A,L
  OR H
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
  CALL MOVSTR
  POP HL
  LD (HL),C
  INC HL
  LD (HL),B
  LD L,C
  LD H,B
  DEC HL
  JP GARBLP

; String concatenation
;
; Used by the routine at EVAL3.
CONCAT:
  PUSH BC
  PUSH HL
  LD HL,(FACCU)
  EX (SP),HL
  CALL OPRND
  EX (SP),HL
  CALL TSTSTR
  LD A,(HL)
  PUSH HL
  LD HL,(FACCU)
  PUSH HL
  ADD A,(HL)
  LD DE,$000F
  JP C,ERROR
  CALL MKTMST
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

; Move string on stack to string area
;
; Used by the routine at CONCAT.
SSTSA:
  POP HL
  EX (SP),HL
  LD A,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD L,A

; Move string in BC, (len in L) to string area
;
; Used by the routines at STRCPY and MID1.
TOSTRA:
  INC L

; TOSTRA loop
TSALP:
  DEC L
  RET Z
  LD A,(BC)
  LD (DE),A
  INC BC
  INC DE
  JR TSALP

; Get string pointed by FPREG 'Type Error' if it is not
;
; Used by the routines at STRCMP, __LEN, L6F07, L6F94, __CVD, __LSET, FNAME and
; __OPEN.
GETSTR:
  CALL TSTSTR

; Get string pointed by FPREG
;
; Used by the routines at NOTQTI, FN_USR, __STR_S, PRS1 and __FRE.
GSTRCU:
  LD HL,(FACCU)

; Get string pointed by HL
;
; Used by the routines at REUSIN, CONCAT and L6F07.
GSTRHL:
  EX DE,HL

; Get string pointed by DE
;
; Used by the routines at STRCMP, CONCAT and MID1.
GSTRDE:
  CALL GSTRDE_1
  EX DE,HL
  RET NZ
  PUSH DE
  LD D,B
  LD E,C
  DEC DE
  LD C,(HL)
  LD HL,(FRETOP)
  CALL DCOMPR
  JR NZ,GSTRDE_0
  LD B,A
  ADD HL,BC
  LD (FRETOP),HL
GSTRDE_0:
  POP HL
  RET
; This entry point is used by the routine at CRESTR.
GSTRDE_1:
  LD HL,(TEMPPT)
  DEC HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  CALL DCOMPR
  RET NZ
  LD (TEMPPT),HL
  RET

; Routine at 28137
__LEN:
  LD BC,PASSA
  PUSH BC
; This entry point is used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR
  XOR A
  LD D,A
  LD A,(HL)
  OR A
  RET

; Routine at 28149
__ASC:
  LD BC,PASSA
  PUSH BC
; This entry point is used by the routine at L6E29.
__ASC_0:
  CALL GETLEN
  JP Z,FC_ERR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  RET
__CHR_S:
  CALL STRIN1
  CALL CONINT
; This entry point is used by the routine at L67D8.
__ASC_1:
  LD HL,(TMPSTR)
  LD (HL),E

; Save in string pool
;
; Used by the routines at __SPACE_S and __MKD_S.
TOPOOL:
  POP BC
  JP TSTOPL

; Routine at 28179
;
; Used by the routine at NTVARP.
FN_STRING:
  CALL CHRGTB
  CALL SYNCHR

; Message at 28185
L6E19:
  DEFM "("

; Routine at 28186
L6E1A:
  CALL GETINT
  PUSH DE
  CALL SYNCHR

; Message at 28193
L6E21:
  DEFM ","

; Routine at 28194
L6E22:
  CALL EVAL
  CALL SYNCHR

; Message at 28200
L6E28:
  DEFM ")"

; Routine at 28201
L6E29:
  EX (SP),HL
  PUSH HL
  CALL GETYPR
  JR Z,L6E29_0
  CALL CONINT
  JR L6E29_1
L6E29_0:
  CALL __ASC_0
L6E29_1:
  POP DE
  CALL __SPACE_S_0

; Routine at 28220
__SPACE_S:
  CALL CONINT
  LD A,$20
; This entry point is used by the routine at L6E29.
__SPACE_S_0:
  PUSH AF
  LD A,E
  CALL MKTMST
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

; Routine at 28245
__LEFT_S:
  CALL LFRGNM
  XOR A
; This entry point is used by the routine at __RIGHT_S.
RIGHT1:
  EX (SP),HL
  LD C,A

; "LD A,n" to Mask the next byte       ;SKIP THE NEXT BYTE WITH "MVI A,"
L6E5B:
  DEFB $3E

; Routine at 28252
;
; Used by the routine at ISSTRF.
__LEFT_S_1:
  PUSH HL

; Routine at 28253
MID1:
  PUSH HL                 ; Save string block address            ;SAVE DESC. FOR  FRETMP
  LD A,(HL)               ; Get length of string                 ;GET STRING LENGTH
  CP B                    ; Compare with number given            ;ENTIRE STRING WANTED?
  JR C,ALLFOL             ; All following bytes required         ;IF #CHARS ASKED FOR.GE.LENGTH,YES
  LD A,B                  ; Get new length                       ;GET TRUNCATED LENGTH OF STRING
  DEFB $11                ; "LD DE,nn" to skip "LD C,0"          ;SKIP OVER MVI USING "LXI D,"

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

; Routine at 28293
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
; Routine at 28302
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
; Routine at 28335
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
; Routine at 28374
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
; This entry point is used by the routine at GOTSTR.
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
; This entry point is used by the routine at GOTSTR.
RETZER:
  POP DE                  ;LIKE SO
  XOR A                   ;GO TO SNGFLT.
  RET                     ;RETURN

; Routine at 28498
;
; Used by the routine at L6F07.
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

; This entry point is used by the routine at L6F07.
OHWELL:
  POP DE                  ;POINT TO START OF SUBSTRING
  POP HL                  ;GET BACK WHERE WE STARTED TO COMPARE
  INC HL                  ;AND POINT TO NEXT CHAR
  ;DEC B                   ;DECR. # CHAR LEFT IN SOURCE STRING
  DJNZ CHK1              ;TRY SEARCHING SOME MORE
  JR RETZER               ;END OF STRING, RETURN 0

; Routine at 28515
;
; Used by the routine at L402A.
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
  LD HL,(TXTTAB)
  CALL DCOMPR
  JR NC,NCPMID
  POP HL
  PUSH HL
  CALL STRCPY
  POP HL
  PUSH HL
  CALL VMOVE
NCPMID:
  POP HL
  EX (SP),HL
  CALL SYNCHR

; Message at 28563
L6F93:
  DEFM ","

; Routine at 28564
L6F94:
  CALL GETINT
  OR A
  JP Z,FC_ERR
  PUSH AF
  LD A,(HL)
  CALL MID_ARGSEP
  PUSH DE
  CALL FRMEQL
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
  JR C,BIGLEN
  LD A,C
BIGLEN:
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
MID_LP:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC C
  RET Z
  DJNZ MID_LP
  RET

; Routine at 28641
;
; Used by the routines at __MID_S and L6F94.
MID_ARGSEP:
  LD E,$FF
  CP $29
  JR Z,L6FEB_0
  CALL SYNCHR

; Message at 28650
L6FEA:
  DEFM ","

; Routine at 28651
L6FEB:
  CALL GETINT
; This entry point is used by the routine at MID_ARGSEP.
L6FEB_0:
  CALL SYNCHR

; Message at 28657
L6FF1:
  DEFM ")"

; Routine at 28658
L6FF2:
  RET

; Routine at 28659
__FRE:
  CALL GETYPR
  JP NZ,__FRE_0
  CALL GSTRCU
  CALL GARBGE
__FRE_0:
  LD HL,(STREND)
  EX DE,HL
  LD HL,(FRETOP)
  JP DANDOR_4
; This entry point is used by the routine at __RANDOMIZE.
__FRE_1:
  LD A,$3F
  CALL OUTDO
  LD A,$20
  CALL OUTDO
  JP PINLIN
; This entry point is used by the routine at PINLIN.
__FRE_2:
  CALL INCHR
  CP $01
  JP NZ,PINLIN_6
  LD (HL),$00
  JR PINLIN_1
; This entry point is used by the routine at PINLIN.
__FRE_3:
  LD (HL),B

; a.k.a. RINPUT, Line input
;
; Used by the routines at PROMPT, GETCMD and __FRE.
PINLIN:
  XOR A
  LD (CHARC),A
  XOR A
  LD (INTFLG),A
; This entry point is used by the routines at L388F and NOTQTI.
INLIN:
  CALL PINLIN_18
  CALL INCHR
  CP $01
  JR NZ,PINLIN_5
; This entry point is used by the routine at __FRE.
PINLIN_1:
  CALL OUTDO_CRLF
  LD HL,$FFFF
  JP __EDIT_2
PINLIN_2:
  LD A,($083E)
  OR A
  LD A,$5C
  LD ($083E),A
  JR NZ,PINLIN_3
  DEC B
  JR Z,__FRE_3
  CALL OUTDO
  INC B
PINLIN_3:
  DEC B
  DEC HL
  JR Z,PINLIN_4
  LD A,(HL)
  CALL OUTDO
  JR __FRE_2
  DEC B
  DEC HL
  CALL OUTDO
  JR NZ,__FRE_2
PINLIN_4:
  CALL OUTDO
  CALL OUTDO_CRLF
PINLIN_5:
  LD HL,BUF
  LD B,$01
  PUSH AF
  XOR A
  LD ($083E),A
  POP AF
; This entry point is used by the routine at __FRE.
PINLIN_6:
  LD C,A
  CP $7F
  JR Z,PINLIN_2
  LD A,($083E)
  OR A
  JR Z,PINLIN_7
  LD A,$5C
  CALL OUTDO
  XOR A
  LD ($083E),A
PINLIN_7:
  LD A,C
  CP $07
  JR Z,PINLIN_12
  CP $03
  CALL Z,KILIN
  SCF
  RET Z
  CP $0D
  JP Z,PINLIN_16
  CP $09
  JR Z,PINLIN_12
  CP $0A
  JR NZ,PINLIN_8
  DEC B
  JP Z,PINLIN
  INC B
  JR PINLIN_12
PINLIN_8:
  CP $15
  CALL Z,KILIN
  JP Z,PINLIN
  CP $08
  JR NZ,PINLIN_9
  DEC B
  JP Z,INLIN
  CALL PINLIN_19
  JP __FRE_2
PINLIN_9:
  CP $18
  JP NZ,PINLIN_10
  LD A,$23
  JP PINLIN_4
PINLIN_10:
  CP $12
  JR NZ,PINLIN_11
  PUSH BC
  PUSH DE
  PUSH HL
  LD (HL),$00
  CALL OUTDO_CRLF
  LD HL,BUF
  CALL LISPRT
  POP HL
  POP DE
  POP BC
  JP __FRE_2
PINLIN_11:
  CP $20
  JP C,__FRE_2
PINLIN_12:
  LD A,B
  INC A
  JR NZ,PINLIN_13
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  POP HL
  LD A,$07
  JR Z,PINLIN_14
  LD HL,BUF
  CALL ATOH
  EX DE,HL
  LD (CURLIN),HL
  JP KRNSAV_0
PINLIN_13:
  LD A,C
  LD (HL),C
  INC HL
  INC B
PINLIN_14:
  CALL OUTDO
  SUB $0A
  JP NZ,__FRE_2
  LD (TTYPOS),A
  LD A,$0D
  CALL OUTDO
PINLIN_15:
  CALL INCHR
  OR A
  JR Z,PINLIN_15
  CP $0D
  JP Z,__FRE_2
  JP PINLIN_6
PINLIN_16:
  LD A,(INTFLG)
  OR A
  JP Z,FININL
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET
; This entry point is used by the routines at L388F and __INPUT.
PINLIN_17:
  PUSH AF
  LD A,$00
  LD (INTFLG),A
  POP AF
  CP $3B
  RET NZ
  LD (INTFLG),A
  JP CHRGTB
PINLIN_18:
  LD A,(TTYPOS)
  LD ($719D),A
  RET
; This entry point is used by the routine at EDIT_BKSP.
PINLIN_19:
  DEC HL
  LD A,(HL)
  CP $0A
  JR NZ,PINLIN_22
  PUSH BC
  DEC B
  JR Z,PINLIN_21
  LD HL,BUF
PINLIN_20:
  LD A,(HL)
  CALL OUTDO
  INC HL
  DJNZ PINLIN_20
PINLIN_21:
  POP BC
  RET
PINLIN_22:
  CP $09
  JR NZ,PINLIN_26
  PUSH HL
  PUSH BC
  PUSH DE
  LD D,$00
PINLIN_23:
  DEC HL
  LD A,(HL)
  CP $09
  JR Z,PINLIN_25
  CP $0A
  JR Z,PINLIN_25
  DEC B
  JR Z,PINLIN_24
  INC D
  JR PINLIN_23
PINLIN_24:
  LD A,($719D)
  ADD A,D
  LD D,A
PINLIN_25:
  LD A,D
  AND $07
  CPL
  ADD A,$09
  CALL PINLIN_27
  POP DE
  POP BC
  POP HL
  RET
PINLIN_26:
  LD A,$01
PINLIN_27:
  PUSH BC
  LD B,A
PINLIN_28:
  LD A,$08
  CALL OUTDO
  LD A,$20
  CALL OUTDO
  LD A,$08
  CALL OUTDO
  DJNZ PINLIN_28
  POP BC
  RET
  NOP

; Routine at 29086
__WHILE:
  LD (ENDFOR),HL
  CALL WNDSCN
  CALL CHRGTB
  EX DE,HL
  CALL FNDWND
  INC SP
  INC SP
  JR NZ,__WHILE_0
  ADD HL,BC
  LD SP,HL
  LD (SAVSTK),HL
__WHILE_0:
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(ENDFOR)
  PUSH HL
  PUSH DE
  JR __WEND_0

; Routine at 29119
__WEND:
  JP NZ,SN_ERR
  EX DE,HL
  CALL FNDWND
  JP NZ,WE_ERR
  LD SP,HL
  LD (SAVSTK),HL
  EX DE,HL
  LD HL,(CURLIN)
  LD (NXTLIN),HL
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
  CALL VSIGN
  POP HL
  JR Z,FLSWHL
  LD BC,$00AF
  LD B,C
  PUSH BC
  INC SP
  JP NEWSTT

; Routine at 29174
;
; Used by the routine at __WEND.
FLSWHL:
  LD HL,(NXTLIN)
  LD (CURLIN),HL
  POP HL
  POP AF
  POP AF
  JP NEWSTT

; Routine at 29186
;
; Used by the routines at __WHILE and __WEND.
FNDWND:
  LD HL,$0004
  ADD HL,SP
FNDWND_0:
  LD A,(HL)
  INC HL
  LD BC,$0082
  CP C
  JR NZ,FNDWND_1
  LD BC,$0010
  ADD HL,BC
  JR FNDWND_0
FNDWND_1:
  LD BC,$00AF
  CP C
  RET NZ
  PUSH HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD H,B
  LD L,C
  CALL DCOMPR
  POP HL
  LD BC,$0006
  RET Z
  ADD HL,BC
  JR FNDWND_0

; Routine at 29226
;
; Used by the routine at __WEND.
WE_ERR:
  LD DE,$001E
  JP ERROR

; Routine at 29232
__CALL:
  LD A,$80
  LD (SUBFLG),A
  LD A,(HL)
  CP $25
  PUSH AF
  CALL Z,CHRGTB
  CALL GETVAR
  EX (SP),HL
  PUSH HL
  EX DE,HL
  CALL GETYPR
  CALL VMOVFM
  CALL __CINT
  LD (INTFLG),HL
  POP AF
  JP Z,__CALL_6502
  LD C,$20
  CALL CHKSTK
  POP DE
  LD HL,$FFC0
  ADD HL,SP
  LD SP,HL
  EX DE,HL
  LD C,$20
  DEC HL
  CALL CHRGTB
  LD (TEMP),HL
  JR Z,CALLST
  CALL SYNCHR

; Message at 29292
L726C:
  DEFM "("

; Routine at 29293
GETPAR:
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
  JR NZ,GETPAR_0
  DEC C
  CALL CHRGTB
  JR GETPAR
GETPAR_0:
  CALL SYNCHR

; Message at 29320
L7288:
  DEFM ")"

; Routine at 29321
ENDPAR:
  LD (TEMP),HL
  LD A,$21
  SUB C
  POP HL
  DEC A
  JR Z,CALLST
  POP DE
  DEC A
  JR Z,CALLST
  POP BC
  DEC A
  JR Z,CALLST
  PUSH BC
  PUSH HL
  LD HL,$0002
  ADD HL,SP
  LD B,H
  LD C,L
  POP HL

; Routine at 29348
;
; Used by the routines at __CALL and ENDPAR.
CALLST:
  PUSH HL
  LD HL,CALLRT
  EX (SP),HL
  PUSH HL
  LD HL,(INTFLG)
  EX (SP),HL
  RET

; Routine at 29359
CALLRT:
  LD HL,(SAVSTK)
  LD SP,HL
  LD HL,(TEMP)
  JP NEWSTT

; Routine at 29369
__CHAIN:
  XOR A
  LD (MRGFLG),A
  LD (MDLFLG),A
  LD A,(HL)
  LD DE,$00BE
  CP E
  JR NZ,__CHAIN_0
  LD (MRGFLG),A
  INC HL
__CHAIN_0:
  DEC HL
  CALL CHRGTB
  CALL PRGFLI
  PUSH HL
  LD HL,$0000
  LD (CHNLIN),HL
  POP HL
  DEC HL
  CALL CHRGTB
  JP Z,NTCHAL
  CALL SYNCHR

; Message at 29412
L72E4:
  DEFM ","

; Routine at 29413
L72E5:
  CP ','
  JR Z,NTLINF
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  LD (CHNLIN),HL
  POP HL
  DEC HL
  CALL CHRGTB
  JR Z,NTCHAL
NTLINF:
  CALL SYNCHR

; Message at 29437
L72FD:
  DEFM ","

; Routine at 29438
L72FE:
  LD DE,$00A6
  CP E
  JR Z,CHMWDL
  CALL SYNCHR

; Message at 29447
L7307:
  DEFM "A"

; Routine at 29448
L7308:
  CALL SYNCHR

; Message at 29451
L730B:
  DEFM "L"

; Routine at 29452
L730C:
  CALL SYNCHR

; Message at 29455
L730F:
  DEFM "L"

; Routine at 29456
L7310:
  JP Z,DNCMDA
  CALL SYNCHR

; Message at 29462
L7316:
  DEFM ","

; Routine at 29463
L7317:
  CP E
  JP NZ,SN_ERR
  OR A
; This entry point is used by the routine at L72FE.
CHMWDL:
  PUSH AF
  LD (MDLFLG),A
  CALL CHRGTB
  CALL LNUM_RANGE
  PUSH BC
  CALL DEPTR
  POP BC
  POP DE
  PUSH BC
  LD H,B
  LD L,C
  LD (CMSPTR),HL
  CALL SRCHLN
  JR NC,FCERRG
  LD D,H
  LD E,L
  LD (CMEPTR),HL
  POP HL
  CALL DCOMPR
FCERRG:
  JP NC,FC_ERR
  POP AF
  JP NZ,DNCMDA
; This entry point is used by the routines at __CHAIN and L72E5.
NTCHAL:
  LD HL,(TXTTAB)
  DEC HL
CLPSCN:
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,CLPFIN
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (CURLIN),HL
  EX DE,HL
CSTSCN:
  CALL CHRGTB
; This entry point is used by the routines at CHAIN_COMMON, BCKUCM and L73ED.
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
  
; Routine at 29556
;
; Used by the routine at L7317.
CHAIN_COMMON:
  CALL CHRGTB             ;Get thing after COMMON
  JR Z,AFTCOM             ;Get next thing

; This entry point is used by the routine at L73F4.
NXTCOM:
  PUSH HL                 ;Save text pointer
  LD A,$01                ;Call PTRGET to search for array
  LD (SUBFLG),A
  CALL GETVAR             ;This subroutine in F3 scans variables
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

; Routine at 29601
;
; Used by the routines at CHAIN_COMMON and COMFNS.
SCNSMP:
  POP HL                 ;Rescan variable name for start
  CALL GETVAR            ;Evaluate as simple
;COMPTR:
  LD A,D                 ;If var not found, [D,E]=0
  OR E
  JR NZ,COMFNS           ;Found it
  LD A,B                 ;Try to find in COMMON
  OR $80                 ;Set COMMON bit

  LD B,A
  LD A,(VALTYP)          ;Must have VALTYP in [D]
  LD D,A
  CALL NSCFOR            ;Search symbol table

  LD A,D                 ;Found?
  OR E
  JP Z,FC_ERR            ;No, who is this guy?

; Routine at 29625
;
; Used by the routine at SCNSMP.
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

; This entry point is used by the routine at CHAIN_COMMON.
FNDAAY:
  LD (SUBFLG),A          ;Array found, clear SUBFLG
  LD A,(HL)              ;Make sure really array spec
  CP '('                 ;Really an array?
  JR NZ,SCNSMP           ;No, scan as simp
  EX (SP),HL             ;Save text pointer, get rid of saved text pointer
  DEC BC                 ;Point at last char of name extension
  DEC BC
  CALL CBAKBL            ;Back up before variable and mark as COMMON

; Routine at 29658
BCKUCM:
  POP HL                 ;Restore text pointer
  DEC HL                 ;Rescan terminator
  CALL CHRGTB
  JP Z,AFTCOM            ;End of COMMON statement
  CP '('                 ;End of COMMON array spec?
  JR NZ,CHKCST           ;No, should be comma
; This entry point is used by the routine at CHAIN_COMMON.
COMADY:
  CALL CHRGTB            ;Fetch char after paren
  CALL SYNCHR
  DEFM ")"               ;Right paren should follow
  JP Z,AFTCOM            ;End of COMMON
; This entry point is used by the routine at BCKUCM.
CHKCST:
  CALL SYNCHR            ;Force comma to appear here
  DEFM ","               ;Get next COMMON variable
  JP NXTCOM


; Step 3 - Squeeze..
; Routine at 29687
;
; Used by the routine at L7317.
CLPFIN:
  LD HL,(ARYTAB)
  EX DE,HL
  LD HL,(VARTAB)

; Routine at 29694
CLPSLP:
  CALL DCOMPR
  JR Z,DNCMDS
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
  CALL FNDARY_15
  LD B,$00
  ADD HL,BC
  POP AF
  POP BC
  JP M,CLPSLP
  PUSH BC
  CALL VARDLS
  LD HL,(ARYTAB)
  ADD HL,DE
  LD (ARYTAB),HL
  EX DE,HL
  POP HL
  JR CLPSLP

; Routine at 29736
;
; Used by the routines at CLPSLP and CLPAKP.
VARDLS:
  EX DE,HL
  LD HL,(STREND)

; Routine at 29740
DLSVLP:
  CALL DCOMPR
  LD A,(DE)
  LD (BC),A
  INC DE
  INC BC
  JR NZ,DLSVLP
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

; Routine at 29763
;
; Used by the routine at CLPSLP.
DNCMDS:
  LD HL,(STREND)
  EX DE,HL

; Routine at 29767
CLPAKP:
  CALL DCOMPR
  JR Z,DNCMDA
  PUSH HL
  INC HL
  INC HL
  LD A,(HL)
  OR A
  PUSH AF
  AND $7F
  LD (HL),A
  INC HL
  CALL FNDARY_15
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC
  POP AF
  POP BC
  JP M,CLPAKP
  PUSH BC
  CALL VARDLS
  EX DE,HL
  POP HL
  JR CLPAKP

; Routine at 29803
;
; Used by the routines at L7310, L7317 and CLPAKP.
DNCMDA:
  LD HL,(VARTAB)
DNCMDA_0:
  EX DE,HL
  LD HL,(ARYTAB)
  EX DE,HL
  CALL DCOMPR
  JR Z,DNCMDA_3
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  PUSH AF
  CALL FNDARY_15
  POP AF
  CP $03
  JR NZ,DNCMDA_1
  CALL CDVARS
  XOR A
DNCMDA_1:
  LD E,A
  LD D,$00
  ADD HL,DE
  JR DNCMDA_0
DNCMDA_2:
  POP BC
; This entry point is used by the routine at CAYSTR.
DNCMDA_3:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  CALL DCOMPR
  JR Z,DNCCLS
  LD A,(HL)
  INC HL
  INC HL
  PUSH AF
  INC HL
  CALL FNDARY_15
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  POP AF
  PUSH HL
  ADD HL,BC
  CP $03
  JR NZ,DNCMDA_2
  LD (TEMP3),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL

; Routine at 29879
CAYSTR:
  EX DE,HL
  LD HL,(TEMP3)
  EX DE,HL
  CALL DCOMPR
  JR Z,DNCMDA_3
  LD BC,CAYSTR
  PUSH BC

; Routine at 29893
;
; Used by the routine at DNCMDA.
CDVARS:
  XOR A
  OR (HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
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
  CALL MOVE1
  POP HL
  RET
; This entry point is used by the routine at DNCMDA.
DNCCLS:
  CALL GARBGE
  LD HL,(STREND)
  LD B,H
  LD C,L
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
  LD (SAVFRE),HL
  CALL MOVSTR
  LD H,B
  LD L,C
  DEC HL
  LD (FRETOP),HL
  LD A,(MDLFLG)
  OR A
  JR Z,CAYSTR_2
  LD HL,(CMSPTR)
  LD B,H
  LD C,L
  LD HL,(CMEPTR)
  CALL __DELETE_0
  CALL LINKER
CAYSTR_2:
  LD A,$01
  LD (CHNFLG),A
  LD A,(MRGFLG)
  OR A
  JP NZ,OKGETM
  LD A,(MAXFIL)
  LD (MAXFILSV),A
  JP CHNENT

; This entry point is used by the routines at L670C and BINLOD.
CHNRET:
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
  LD HL,(SAVFRE)
  LD (FRETOP),HL
MVBKVR:
  CALL DCOMPR
  LD A,(DE)
  LD (BC),A
  INC DE
  INC BC
  JR NZ,MVBKVR
  DEC BC
  LD H,B
  LD L,C
  LD (STREND),HL
  LD HL,(CHNLIN)
  LD A,H
  OR L
  EX DE,HL
  LD HL,(TXTTAB)
  DEC HL
  JP Z,NEWSTT
  CALL SRCHLN
  JP NC,UL_ERR
  DEC BC
  LD H,B
  LD L,C
  JP NEWSTT
  JP __DATA

; Routine at 30088
__WRITE:
  LD C,$02
  CALL FILGET
  DEC HL
  CALL CHRGTB
  JR Z,WRTFIN
; This entry point is used by the routine at L75C6.
WRTMLP:
  CALL EVAL
  PUSH HL
  CALL GETYPR
  JR Z,WRTSTR
  CALL FOUT
  CALL CRTST
  LD HL,(FACCU)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  CP $20
  JR NZ,WRTNEG
  INC DE
  LD (HL),D
  DEC HL
  LD (HL),E
  DEC HL
  DEC (HL)
WRTNEG:
  CALL PRS1
; This entry point is used by the routine at L75C6.
NXTWRV:
  POP HL
  DEC HL
  CALL CHRGTB
  JR Z,WRTFIN
  CP $3B
  JR Z,WASEMI
  CALL SYNCHR

; Message at 30149
L75C5:
  DEFM ","

; Routine at 30150
L75C6:
  DEC HL
; This entry point is used by the routine at __WRITE.
WASEMI:
  CALL CHRGTB
  LD A,$2C
  CALL OUTDO
  JR WRTMLP
; This entry point is used by the routine at __WRITE.
WRTSTR:
  LD A,$22
  CALL OUTDO
  CALL PRS1
  LD A,$22
  CALL OUTDO
  JR NXTWRV
; This entry point is used by the routine at __WRITE.
WRTFIN:
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  JR Z,NTRNDW
  LD A,(HL)
  CP $03
  JR NZ,NTRNDW
  CALL CMPFBC
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD DE,$FFFE
  ADD HL,DE
  JR NC,NTRNDW

; Routine at 30204
CRLFSQ:
  LD A,$20
  CALL OUTDO
  DEC HL
  LD A,H
  OR L
  JR NZ,CRLFSQ

; Routine at 30214
;
; Used by the routine at L75C6.
NTRNDW:
  POP HL
  CALL OUTDO_CRLF
  JP FINPRT
; This entry point is used by the routines at FILSTI and LINE_INPUT.
FILINP:
  LD C,$01

; Routine at 30223
;
; Used by the routines at __PRINT and __WRITE.
FILGET:
  CP $23
  RET NZ
  PUSH BC
  CALL FILSCN
  POP DE
  CP E
  JR Z,GDFILM
  CP $03
  JP NZ,FMODE_ERR

; Routine at 30239
;
; Used by the routine at FILGET.
GDFILM:
  CALL SYNCHR

; Message at 30242
L7622:
  DEFM ","

; Routine at 30243
;
; Used by the routine at L79F2.
L7623:
  EX DE,HL

; Routine at 30244
FILSET:
  LD H,B
  LD L,C
  LD (PTRFIL),HL
  EX DE,HL
  RET

;
; AT THIS ENTRY POINT [H,L] IS ASSUMED TO BE THE TEXT POINTER AND
; A FILE NUMBER IS SCANNED
;
; Routine at 30251
;
; Used by the routines at FILGET, __FIELD, L79F2 and __GET.
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
;
; Used by the routines at SRCHLP, __EOF, __LOC and __LOF.
FILFRM:
  CALL CONINT           ;GET THE FILE NUMBER INTO [A]

;
; AT THIS POINT IT IS ASSUMED THE FILE NUMBER IS IN [A]
; THE FILE NUMBER IS RETURNED IN [E]
; [D] IS SET TO ZERO. [H,L] IS SAVED.
; [B,C] IS SET TO POINT AT THE FILE DATA BLOCK FOR FILE [E]
; [A] GIVE THE MODE OF THE FILE AND ZERO IS SET  IF THE FILE IS MODE ZERO (NOT OPEN).
;
; Routine at 30266
;
; Used by the routines at CPM_CLSFIL and PRGFIL.
FILIDX:
  LD E,A                ;GET FILE NUMBER INTO [E]

; Routine at 30267
;
; Used by the routine at GETPTR.
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
; Routine at 30289
;
; Used by the routine at L3C52.
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
; Routine at 30308
__MKS_S:
  LD A,$04              ;VALUE TYPE OF SINGLE PRECISION

  DEFB $01              ; "LD BC,nn" to SKIP THE NEXT TWO BYTES

; 'MKD$' BASIC function
; Routine at 30311
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
; Routine at 30330
__CVI:
  LD A,$01              ;SET [A] TO BE VALTYP-1

  DEFB $01              ; "LD BC,nn" to SKIP THE NEXT TWO BYTES

; 'CVS' BASIC function
; Routine at 30333
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
  INC HL                ;[H,L]=POINTER AT STRING DATA
  LD C,(HL)             ;(***) TO BE MOVED INTO THE FAC
  INC HL
  LD H,(HL)
  LD L,C                ;SETUP VALUE TYPE FOR MOVE AND FOR IDENTIFICATION
  LD (VALTYP),A
  JP VMOVFM             ;MOVE IN THE STRING DATA

; Routine at 30359
;
; Used by the routine at SCNVAL.
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
; Routine at 30373
;
; Used by the routine at L388F.
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
  LD B,A                 ;(***)
  LD A,E                ;SAVE THE QUOTE
  CP ','                ;MUST BE INPUT OF A STRING   ;;  LD x,'"' (***) WHICH HAS [E]=44
  LD A,B
  JR NZ,NOTQTE          ;QUOTE BACK INTO [A]
  LD D,B
  LD E,B                ;TERMINATORS ARE QUOTES ONLY  ;; LD E,x (***)
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
  CP ','                ;  MBASIC v.5.20 and 5.22 introduced a serious bug here, they check for 54 DECIMAL ('6') rather than 54 OCTAL (',') !!
  LD A,C                ;RESTORE ORIG CHAR
  CALL NZ,STRCHR        ;IF NOT, STORE LF (?)
  CALL RDBYT            ;GET NEXT CHAR
  JR C,QUITSI           ;IF EOF, ALL DONE.

;;  (***) This extra check exists on Tandy M100, Olivetti M10 and MSX
;;  CP $0A                ;IS IT A LF?
;;  JR Z,SKIP_LF

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
  JP Z,NOSKCR           ;OK, SKIP IT
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

; This entry point is used by the routines at __CHAIN, __LOAD and __MERGE.
PRGFLI:
  LD D,$01              ;MD.SQI: SEQUENTIAL INPUT MODE

; Routine at 30587
;
; Used by the routine at __SAVE.
FILE_OPENOUT:
  XOR A                 ;INTERNAL FILE NUMBER IS ALWAYS ZERO
  JP PRGFIL             ;SCAN FILE NAME AND DISK NUMMER
                        ;AND DO THE RIGHT THING USING MD.KIL AS A FLAG


; Load and run a file, used also at boot time

; This entry point is used by the routines at __RUN and INITSA.
LRUN:
  DEFB $F6                ; 'OR $AF'  ;SET NON ZERO TO FLAG "RUN" COMMAND

; Routine at 30592
__LOAD:
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

; This entry point is used by the routine at CDVARS.
CHNENT:
  XOR A                 ;SO FILES AREN'T CLOSED
  LD (MAXFIL),A			; HIGHEST FILE NUMBER ALLOWED
  DEFB $F6                ; "OR n" to Mask 'POP AF'        ; FLAG RUN WITH NON-ZERO

; Routine at 30626
;
; Used by the routine at __LOAD.
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

; Routine at 30687
;
; Used by the routine at NOTRNL.
BINLOD:
  LD HL,(TXTTAB)          ;GET PLACE TO START STORING INTO

  CALL BINLOD_SUB         ;(***)

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

; Routine at 30746
;
; Used by the routines at RESTART, L670C, __MERGE and BINSAV.
LOAD_END:
  CALL FINPRT
  CALL CPM_CLSFIL
  JP GTMPRT

; Routine at 30755
;
; Used by the routine at LPBLDR.
LOAD_OM_ERR:
  CALL CLRPTR
  JP OM_ERR

; Routine at 30761
__MERGE:
  POP BC
  CALL PRGFLI
  DEC HL
  CALL CHRGTB
  JR Z,OKGETM
  CALL LOAD_END
  JP SN_ERR

; Routine at 30777
;
; Used by the routines at CDVARS and __MERGE.
OKGETM:
  XOR A
  LD (AUTORUN),A
  CALL RDBYT
  JP C,PROMPT
  INC A
  JP Z,FMODE_ERR

; Routine at 30791
;
; Used by the routine at NOTRNL.
MAINGO:
  LD HL,(PTRFIL)
  LD BC,$0028
  ADD HL,BC
  INC (HL)
  JP PROMPT

; Routine at 30802
;
; Used by the routine at EDENT.
DIRDO:
  PUSH HL
  LD HL,(PTRFIL)        ; (*** -> ISFLIO)
  LD A,H
  OR L
  LD DE,$0042
  JP NZ,ERROR
  POP HL
  JP EXEC

; Routine at 30818
__SAVE:
  LD D,$02
  CALL FILE_OPENOUT
  DEC HL
  CALL CHRGTB
  JR Z,BINSAV
  CALL SYNCHR

; Message at 30832
L7870:
  DEFM ","

; Routine at 30833
L7871:
  CP $50
  JP Z,PROSAV
  CALL SYNCHR

; Message at 30841
L7879:
  DEFM "A"

; Routine at 30842
L787A:
  JP __LIST

; Routine at 30845
;
; Used by the routine at __SAVE.
BINSAV:
  CALL SCCPTR
  CALL PROCHK
  LD A,$FF
; This entry point is used by the routine at __GET.
BINPSV:
  CALL FILOUT_0
  LD HL,(VARTAB)
  EX DE,HL
  LD HL,(TXTTAB)
BSAVLP:
  CALL DCOMPR
  JP Z,LOAD_END
  LD A,(HL)
  INC HL
  PUSH DE
  CALL FILOUT_0
  POP DE
  JR BSAVLP

; Routine at 30878
__CLOSE:
  LD BC,CPM_CLSFIL
  LD A,(MAXFIL)
  JR NZ,__CLOSE_1
  PUSH HL
__CLOSE_0:
  PUSH BC
  PUSH AF
  LD DE,$78AF
  PUSH DE
  PUSH BC
  RET
  POP AF
  POP BC
  DEC A
  JP P,__CLOSE_0
  POP HL
  RET
  POP BC
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  CALL CHRGTB
__CLOSE_1:
  PUSH BC
  LD A,(HL)
  CP $23
  CALL Z,CHRGTB
  CALL GETINT
  EX (SP),HL
  PUSH HL
  LD DE,$78B7
  PUSH DE
  JP (HL)
; This entry point is used by the routines at ENFMEM, RUN_FST, __END, __SYSTEM
; and __RESET.
CLSALL:
  PUSH DE
  PUSH BC
  XOR A
  CALL __CLOSE
  POP BC
  POP DE
  XOR A
  RET

; Routine at 30939
__FIELD:
  CALL FILSCN
  JP Z,BN_ERR
  SUB $03
  JP NZ,FMODE_ERR
  EX DE,HL
  LD HL,$00A9
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (INTFLG),HL
  LD HL,$0000
  LD (RECORD),HL
  LD A,H
  EX DE,HL
  LD DE,$00B2
; This entry point is used by the routine at L7913.
__FIELD_0:
  EX DE,HL
  ADD HL,BC
  LD B,A
  EX DE,HL
  LD A,(HL)
  CP ','
  RET NZ
  PUSH DE
  PUSH BC
  CALL FNDNUM
  PUSH AF
  CALL SYNCHR

; Message at 30990
L790E:
  DEFM "A"

; Routine at 30991
L790F:
  CALL SYNCHR

; Message at 30994
L7912:
  DEFM "S"

; Routine at 30995
L7913:
  CALL GETVAR
  CALL TSTSTR
  POP AF
  POP BC
  EX (SP),HL
  LD C,A
  PUSH DE
  PUSH HL
  LD HL,(RECORD)
  LD B,$00
  ADD HL,BC
  LD (RECORD),HL
  EX DE,HL
  LD HL,(INTFLG)
  CALL DCOMPR
  JP C,DERFOV
  POP HL
  POP DE
  EX DE,HL
  LD (HL),C
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  JR __FIELD_0

; Routine at 31037
__RSET:
  OR $37

; Routine at 31038
__LSET:
  SCF
  PUSH AF
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  CALL FRMEQL
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
  JP Z,RETCUR
  LD HL,(TXTTAB)
  CALL DCOMPR
  JR NC,OLDSTR
  LD HL,(VARTAB)
  CALL DCOMPR
  JR C,OLDSTR
  LD E,C
  LD D,$00
  LD HL,(STREND)
  ADD HL,DE
  EX DE,HL
  LD HL,(FRETOP)
  CALL DCOMPR
  JP C,MAKDSC
; This entry point is used by the routine at MAKDSC.
MADESC:
  POP AF
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
  LD (HL),E
  INC HL
  LD (HL),D
  PUSH AF
OLDSTR:
  POP AF
  POP HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP BC
  POP HL
  PUSH DE
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  POP DE
  LD A,C
  CP B
  JR NC,FILDOK
  LD B,A
FILDOK:
  SUB B
  LD C,A
  POP AF
  CALL NC,BLKFIL
  INC B
__LSET_0:
  DEC B
  JR Z,LRSTDN
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  JP __LSET_0
RETCUR:
  POP BC
  POP BC
  POP BC
  POP BC
  POP BC
LRSTDN:
  CALL C,BLKFIL
  POP HL
  RET

; Routine at 31175
;
; Used by the routine at __LSET.
BLKFIL:
  LD A,$20
  INC C
BLKFIL_0:
  DEC C
  RET Z
  LD (DE),A
  INC DE
  JR BLKFIL_0

; Routine at 31184
;
; Used by the routine at __LSET.
MAKDSC:
  POP AF
  POP HL
  POP BC
  EX (SP),HL
  EX DE,HL
  JR NZ,MAKDSC_0
  PUSH BC
  LD A,B
  CALL MKTMST
  CALL TSTOPL
  POP BC
MAKDSC_0:
  EX (SP),HL
  PUSH BC
  PUSH HL
  PUSH AF
  JP MADESC

; a.k.a. FIXINP:  Program I/O -- Fixed Length INPUT
;
; Used by the routine at NTVARP.
FN_INPUT:
  CALL CHRGTB
  CALL SYNCHR

; Message at 31213
L79ED:
  DEFM "$"

; Routine at 31214
L79EE:
  CALL SYNCHR

; Message at 31217
L79F1:
  DEFM "("

; Routine at 31218
L79F2:
  CALL GETINT
  PUSH DE
  LD A,(HL)
  CP ','
  JR NZ,REDTTY
  CALL CHRGTB
  CALL FILSCN
  CP $02
  JP Z,FMODE_ERR
  CALL L7623
  XOR A
REDTTY:
  PUSH AF
  CALL SYNCHR

; Message at 31246
L7A0E:
  DEFM ")"

; Routine at 31247
L7A0F:
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
; This entry point is used by the routine at PUTCHR.
FIXLOP:
  POP AF
  PUSH AF
  JR Z,DSKCHR
  CALL CHARCG
  JR NZ,CHARCW
  CALL INCHRI
CHARCW:
  CP $03
  JP Z,INTCTC

; Routine at 31278
;
; Used by the routine at DSKCHR.
PUTCHR:
  LD (HL),A
  INC HL
  DEC C
  JR NZ,FIXLOP
  POP AF
  CALL FINPRT
  JP TSTOPL

; Routine at 31290
;
; Used by the routine at L7A0F.
INTCTC:
  LD HL,(SAVSTK)
  LD SP,HL
  JP ENDCON

; Routine at 31297
;
; Used by the routine at L7A0F.
DSKCHR:
  CALL RDBYT
  JP C,EF_ERR
  JP PUTCHR

; Routine at 31306
__EOF:
  CALL FILFRM
  JP Z,BN_ERR
  CP $02
  JP Z,FMODE_ERR
__EOF_0:
  LD HL,$0027
  ADD HL,BC
  LD A,(HL)
  OR A
  JR Z,__EOF_2
  LD A,(BC)
  CP $03
  JR Z,__EOF_2
  INC HL
  LD A,(HL)
  OR A
  JR NZ,__EOF_1
  PUSH BC
  LD H,B
  LD L,C
  CALL READIN
  POP BC
  JR __EOF_0

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
  JP CONIA
; This entry point is used by the routines at FILOUT and FIVDPT.
__EOF_3:
  LD D,B
  LD E,C
  INC DE
; This entry point is used by the routine at CLSFL1.
NOUTSEQ_0:
  LD HL,$0027
  ADD HL,BC
  PUSH BC
  XOR A
  LD (HL),A
  CALL SETBUF
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

;
; CLOSE A FILE
;
; FILE NUMBER IS IN [A]
; ZERO ALL INFORMATION. IF FILE IS OPEN, RAISE ITS DISKS HEAD
; IF FILE IS SEQUENTIAL OUTPUT, SEND FINAL SECTOR OF DATA
;
; Routine at 31422
;
; Used by the routine at LOAD_END.
CPM_CLSFIL:
  CALL FILIDX             ;GET POINTER TO DATA
  JR Z,NTOPNC             ;RETURN IF NOT OPEN
                          ;SAVE FILE #
  LD L,E
  PUSH BC                 ;SAVE FILE POINTER
  LD A,(BC)               ;GET FILE MODE
  LD D,B                  ;PUT FILE BLOCK OFFSET IN [D,E]
  LD E,C
  INC DE                  ;POINT TO FCB
  PUSH DE                 ;SAVE [D,E] FOR LATER
  CP $02                  ;SEQENTIAL OUTPUT?
  JR NZ,NOFORC            ;NO NEED TO FORCE PARTIAL OUTPUT BUFFER

  INC L                   ; (***)
  DEC L
  JR NZ,CPM_CLSFIL_0
  XOR A
  LD (BC),A
CPM_CLSFIL_0:

  LD HL,CLSFL1            ;RETURN HERE
  PUSH HL                 ;SAVE ON STACK
  PUSH HL                 ;NEED EXTRA STACK ENTRY
  LD H,B                  ;GET FILE POINTER
  LD L,C                  ;INTO [H,L]
  LD A,$1A                ;PUT OUT CONTROL-Z (OR FS)
  JR FILOU4               ;JUMP INTO CHAR OUTPUT CODE

; Routine at 31455
CLSFL1:
  LD HL,$0027
  ADD HL,BC
  LD A,(HL)
  OR A
  CALL NZ,NOUTSEQ_0
; This entry point is used by the routine at CPM_CLSFIL.
NOFORC:
  POP DE

;	CLOSE FILE
;
;	(DE) points to FCB
;	((SP)) points to File Data Block

  CALL SETBUF
  LD C,$10                ;THE CLOSE (BDOS function 16 - Close file)
  CALL CPMENT             ;CALL CPM
  
  ;*****	NO CHECK FOR ERRORS
  
  POP BC

; Routine at 31474
;
; Used by the routine at CPM_CLSFIL.
NTOPNC:
  LD D,$29                ; (DATOFS) NUMBER OF BYTES TO ZERO
  XOR A

; Routine at 31477
MORCZR:
  LD (BC),A
  INC BC
  DEC D
  JR NZ,MORCZR
  RET

; Routine at 31483
__LOC:
  CALL FILFRM
  JP Z,BN_ERR
  CP $03
  LD HL,$0026
  JR NZ,__LOC_0
  LD HL,$00AE
__LOC_0:
  ADD HL,BC
  LD A,(HL)
  DEC HL
  LD L,(HL)
  JP PASSA_0

; Routine at 31506
__LOF:
  CALL FILFRM
  JP Z,BN_ERR
  LD HL,$0010
  ADD HL,BC
  LD A,(HL)
  JP PASSA

; Routine at 31520
;
; Used by the routine at OUTDO.
FILOUT:
  POP HL
  POP AF
; This entry point is used by the routine at BINSAV.
FILOUT_0:
  PUSH HL
  PUSH AF
  LD HL,(PTRFIL)
  LD A,(HL)
  CP $01
  JP Z,POPAHT
  CP $03
  JP Z,FILOFV
  POP AF
; This entry point is used by the routine at CPM_CLSFIL.
FILOU4:
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
  CALL Z,__EOF_3
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
  JR Z,ISCRDS
  ADD A,$E0
  LD A,D
  ADC A,B
  LD (HL),A
ISCRDS:
  ADD HL,BC
  POP AF
  POP BC
  POP DE
  LD (HL),A
  POP HL
  RET

; Routine at 31581
;
; Used by the routine at __GET.
FIVDPT:
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
  LD HL,$0022
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD (HL),$00
  POP HL
  LD A,(MAXTRK)
  OR A
  JR NZ,FIVDPT_0
  CALL READIN
  POP HL
  RET
FIVDPT_0:
  CALL __EOF_3
  POP HL
  JP FINPRT

; (DATSPC=$80)
;
; Used by the routine at BINLOD_SUB.
BUFMOV:
  PUSH BC
  LD BC,$0080
  LDIR
  POP BC
  RET

;
; GET A CHARACTER FROM A SEQUENTIAL FILE IN [PTRFIL]
; ALL REGISTERS EXCEPT [D,E] SMASHED
; Used also to Check stream buffer status before I/O operations
;
;	'C' set if EOF read
;

; Routine at 31634
;
; Used by the routine at RDBYT.
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

; This entry point is used by the routine at OPNFIL.
READ2:
  LD HL,(PTRFIL)         ;GET DATA POINTER
; This entry point is used by the routines at __EOF and FIVDPT.
READIN:
  PUSH DE
  LD D,H                 ;PUT FCB POINTER IN [D,E]
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
  LD BC,$007F
  LD (HL),$00
  PUSH DE
  LD D,H
  LD E,L
  INC DE
  LDIR
  POP DE

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

  CALL SETBUF           ; SET CPM BUFFER ADDRESS
  LD A,(CPMREA)         ;Get read code
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
; Routine at 31738
;
; Used by the routines at __EOF, CLSFL1, INDSKB and OPNLP.
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

; Routine at 31755
;
;
; a.k.a. INDSKC
; Used by the routines at L670C, LINE_INPUT, NOTRNL, OKGETM and DSKCHR.
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


; a.k.a. NAMFIL -- SCAN A FILE NAME AND NAME COMMAND

; Routine at 31782
;
; Used by the routines at __NAME, L7CCF, PRGFIL, __KILL and __FILES.
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
  JP Z,NM_ERR             ;ERROR IF NO FILENAME
  LD A,C                 ; Get drive letter as written in file specifier
  SUB 'A'-1              ; ..to drive number (LOGICAL NUMBER).
;;  AND $DF                ; (***) Convert to uppercase..
  JP C,NM_ERR             ;NOT IN RANGE
  CP 27                  ;BIGGER THAN 27
  JP NC,NM_ERR            ;NOT ALLOWED
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

; Routine at 31859
;
; Used by the routine at FNAME.
FILLOP_NOEXT:
  LD (BC),A              ;COPY CHAR
  INC BC
  INC HL
  DEC D                  ;DECRMENT POSSIBLE COUNT OF CHARS
  JR NZ,FILLOP

; Routine at 31865
;
; Used by the routine at FILLNM.
GOTNAM:
  XOR A
  LD (FCB_EXTENT),A
  POP AF
  POP HL
  RET

; Routine at 31872
;
; Used by the routine at FNAME.
FILLNM:
  LD A,D                 ;GET # OF CHARS
  CP 11                  ;INITIAL POSITION?  (11+8*0-2*0)
  JP Z,NM_ERR             ;DONT ALLOW NULL FILENAME
  CP 3                   ;FILLED FIELD?
  JP C,NM_ERR             ;NO, BUT 2ND "."
  RET Z                  ;YES, BACK TO LOOP
  LD A,' '               ;FILL WITH SPACE
  LD (BC),A
  INC BC
  DEC D
  JR FILLNM

; This entry point is used by the routine at FNAME.
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


; 'NAME' BASIC command  (file rename)
; Routine at 31904
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
;  INC A                  ;FILE FOUND?  (A=0-3 if successful; A=0FFh if error)
;  JP Z,FF_ERR            ;NO

  POP HL                 ;RESTORE TEXT POINTER
  RET

; label='OPEN' BASIC command
;
; Different versions pick the file access mode directly from the FCB structure
; It looks like this version is avoiding to trust CP/M
;
; Routine at 31987
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

; Routine at 32029
;
; Used by the routine at __OPEN.
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

; Routine at 32053
;
; Used by the routine at FILE_OPENOUT.
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
  JP NZ,PRGDOT              ;NOT FILE 0, DONT DEFAULT FILE NAME
  LD HL,FCB_FTYP            ; (FILNAM+9-0-0-2*0): POINT TO FIRST CHAR OF EXTENSION
  LD A,(HL)                 ;GET IT
  CP ' '                    ;BLANK EXTENSION
  JR NZ,PRGDOT              ;NON-BLANK EXTENSION, DONT USE DEFAULT
  LD (HL),'B'               ;SET DEFAULT EXTENSION
  INC HL
  LD (HL),'A'
  INC HL
  LD (HL),'S'               ;SET ".BAS"

; Routine at 32102
;
; Used by the routine at PRGFIL.
PRGDOT:
  POP HL                    ;[H,L]=POINTER AT FILE DATA BLOCK
  LD A,D
  PUSH AF
  LD (PTRFIL),HL            ;SETUP AS CURRENT FILE
  PUSH HL                   ;SAVE BACK FILE DATA BLOCK POINTER
  INC HL                    ;POINT TO FCB ENTRY
  LD DE,FILNAM              ;GET POINTER TO SCANNED FILE NAME
  LD C,$0C                  ;(12+0+0*3+2*0+3*0 ??) NUMBER OF BYTES TO COPY

; Routine at 32115
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

  LD (HL),$00               ;(***) MAKE SURE EXTENT FIELD IS ZERO
  LD DE,$0014               ;POINT TO NR FIELD
  ADD HL,DE
  LD (HL),$00               ;SET TO ZERO
  POP DE                    ;GET POINTER TO FILE DATA BLOCK BACK IN [D]
  PUSH DE                   ;SAVE AGAIN FOR LATER
  INC DE
  CALL SETBUF               ;SET BUFFER ADDRESS
  POP HL                    ;GET BACK FILE DATA BLOCK PTR
  POP AF                    ;GET MODE
  PUSH AF
  PUSH HL
  CP $02                    ; (MD.SQO) SEQENTIAL OUTPUT?
  JR NZ,OPNFIL              ;NO, DO CPM OPEN CALL
  PUSH DE                   ;SAVE FCB POINTER
  LD C,$13                  ;DELETE EXISTING OUTPUT FILE, IF ANY  (BDOS function 19 - delete file)
  CALL CPMENT               ;CALL CP/M
  POP DE                    ;RESTORE FCB POINTER

; Routine at 32151
;
; Used by the routine at OPNFIL.
MAKFIL:
  LD C,$16                  ; BDOS function 22 - create file
  CALL CPMENT               ;CALL CPM
  INC A                     ;TEST FOR TOO MANY FILES
  JP Z,FL_ERR               ;THAT WAS THE CASE
  JR OPNSET                 ;FINISH SETUP OF FILE DATA BLOCK

; Routine at 32162
;
; Used by the routine at OPNLP.
OPNFIL:
  LD C,$0F                  ;CPM CODE FOR OPEN (BDOS function 15 - Open file)
  CALL CPMENT               ;CALL CPM
  INC A                     ;FILE NOT FOUND
  JR NZ,OPNSET              ;FOUND
  CALL GET_FILEMODE
  CP $03                    ;RANDOM?
  JP NZ,FF_ERR              ;NO, SEQENTIAL INPUT, FILE NOT FOUND
  INC DE                    ;MAKE [D,E]=FCB POINTER
  JR MAKFIL                 ;MAKE FILE

;	((SP)) points to File Data Block
;	((SP)+2) contains the file mode - DMC!X3200!R2E

; This entry point is used by the routine at MAKFIL.
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

; Routine at 32230
__SYSTEM:
  RET NZ                    ;SHOULD TERMINATE
  CALL CLSALL               ;CLOSE ALL DATA FILES
  CALL __TEXT               ; force text mode on exit (Apple II specific)
; This entry point is used by the routine at ERRMOR.
EXIT_TO_SYSTEM:
  JP CPMWRM                 ;WARM START CP/M


; 'RESET' BASIC command
; Routine at 32240
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
; Routine at 32265
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
  CALL NZ,$0005
  POP AF                 ;RESTORE FOUND INDICATOR
  POP DE                 ;RESTORE FCB POINTER
  JP Z,FF_ERR            ;YES
  LD C,$13               ; BDOS function 19 - delete file
  CALL CPMENT            ;CALL CPM
  POP HL                 ;GET BACK TEXT POINTER
  RET


; 'FILES' BASIC command
; Routine at 32307
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
;;  AND $7F                ; (***)  Force it to 7 bit ASCII  (does not exist on previous versions)
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
  ADD A,$0F              ;SPACE FOR NEXT NAME?  ($0D in later versions)
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

FILENAME_QS:
  LD A,(HL)               ;GET CHAR
  CP '*'                  ;WILD CARD?
  RET NZ                  ;NO, RETURN
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
; Routine at 32454
;
; Used by the routines at __EOF and INDSKB.
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

; Routine at 32498
;
; Used by the routine at BINLOD.
BINLOD_SUB:
  EX DE,HL
  CALL BINLOD_CHK
  LD HL,(PTRFIL)         ;GET DATA BLOCK POINTER
  PUSH HL
  LD BC,$002A
  ADD HL,BC
  CALL BUFMOV
  DEC DE
  POP HL
  LD BC,$0021
  ADD HL,BC
  INC (HL)

; Routine at 32520
LPBLDR:
  CALL BINLOD_CHK
  PUSH DE
  LD C,$1A
  CALL CPMENT
  LD HL,(PTRFIL)
  INC HL
  EX DE,HL
  LD C,$14
  CALL CPMENT
  OR A
  POP DE
  LD HL,$0080
  ADD HL,DE
  RET NZ
  EX DE,HL
  JR LPBLDR

; This entry point is used by the routine at BINLOD_SUB.
BINLOD_CHK:
  LD HL,(FRETOP)
  LD BC,$FF2A         ; 65536-214
  ADD HL,BC
  CALL DCOMPR
  RET NC
  JP LOAD_OM_ERR      ;ERROR AND WIPE OUT PARTIAL GARBAGE
					;UNLINKED!! NO ZEROES AT THE END!!



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

; Routine at 32563
;
; Used by the routine at PRGFIL.
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

; Routine at 32609
__PUT:
  OR $AF


; 'GET' BASIC command

; Routine at 32610
__GET:
  XOR A                   ;Set zero
  LD (PUTGET_FLG),A       ;Save flag
  CALL Z,GET_SUB
  CALL FILSCN             ;Get pointer at file data block   (in BC)
; This entry point is used by the routine at SRCHLP.
__GET_0:
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
  LD A,E                  ;Get record #
  OR D                    ;Make sure its not zero
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
  LD HL,$00B0             ;FD.OPS: Zero output file posit
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
  DEC A
  JR NZ,FRMUL1


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
  OR A                    ;Is it non-zero
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
  LD HL,(PBUFF)
  EX DE,HL
  LD HL,(LBUFF)          ;Get ready to move bytes between buffers
  CALL _LDIR             ;Move bytes to physical buffer
  LD (LBUFF),HL          ;Store updated pointer
  LD D,B                 ;COUNT TO [D,E]
  LD E,C
  POP BC                 ;Restore FDB pointer
  CALL PUTSUB            ;Do write
NXFVBF:
  POP HL
  ; HL=HL-DE
  LD A,L                 ;Make count correct
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  OR L
  LD DE,$0000
  PUSH HL
  LD HL,(RECORD)
  INC HL                 ;Increment it
  LD (RECORD),HL         ;Save back
  JR NZ,NXTOPD
  POP HL
  POP HL
  RET


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
  EX DE,HL
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
  LD HL,(RECORD)
  EX DE,HL
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
  PUSH BC
_LDIR1:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC BC
  LD A,B
  OR C
  JR NZ,_LDIR1
  POP BC
  RET
  
; This entry point is used by the routine at FILOUT.
FILOFV:
  POP AF                  ;Get character off stack
  PUSH DE                 ;Save [D,E]
  PUSH BC                 ;Save [B,C]
  PUSH AF                 ;Save back char
  LD B,H                  ;[B,C]=file data block
  LD C,L
  CALL CMPFPS             ;Any room in buffer
  JP Z,DERFOV             ;No
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
  
; This entry point is used by the routine at INDSKB.
FILIFV:
  PUSH DE
  CALL CMPFBC             ;Save [D,E]
  JP Z,DERFOV             ;Compare to present posit
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

; This entry point is used by the routine at L75C6.
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

; This entry point is used by the routine at L7871.
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
  LD BC,$0D0B
  LD HL,(TXTTAB)
  EX DE,HL

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
  DEC B
  JR NZ,ENCDBL
  LD B,N2                 ;Re-initialize counter 2
  JR ENCDBL               ;Keep going until done

; This entry point is used by the routine at BINLOD.
PDECOD:
  LD BC,N1+N2*256         ;Initialize both counters  (B=N1, C=N2)
  LD HL,(TXTTAB)          ;Starting point
  EX DE,HL                ;Into [D,E]
DECDBL:
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
  LD HL,FP_ATNTAB
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
  JR NZ,CNTZR2
  LD C,$0B
CNTZR2:
  DJNZ DECDBL
  LD B,$0D
  JR DECDBL

; This entry point is used by the routines at __PEEK and __POKE.
PRODIR:
  PUSH HL
  LD HL,(CURLIN)
  LD A,H
  AND L
  POP HL
  INC A
  RET NZ

; Routine at 33196
;
; Used by the routines at EDENT, __LIST, DETOKEN_LIST and BINSAV.
PROCHK:
  PUSH AF
  LD A,(PROFLG)
  OR A
  JP NZ,FC_ERR
  POP AF
  RET

;@ 33206 ($81B6)
RECORD:
  DEFW $0000

;@ 33208 ($81B8)
LBUFF:
  DEFW $0000

;@ 33210 ($81BA)
PBUFF:
  DEFW $0000

; Used to toggle between PUT / GET mode
;@ 33212 ($81BC)
PUTGET_FLG:
  DEFB $00

;----------------------------------------------------------------------

; This entry point is used by the routine at DONCMD.
INITSA:
  CALL NODSKS
  LD HL,(TXTTAB)
  DEC HL
  LD (HL),$00
  LD HL,(TEMP_PTR)
  LD A,(HL)
  OR A
  JP NZ,LRUN
  JP READY

;-----------------------------------------------------------------------------------
;    WARNING:  All the code after 'ENDIO' will be destroyed after initialization
;-----------------------------------------------------------------------------------


ENDIO:
  DEFW $0000


; This entry point is used by the routine at _HIRES_PAGE.
INIT:
  LD HL,$84C8
  LD SP,HL
  XOR A
  LD (PROFLG),A
  LD (STKTOP),HL
  LD (SAVSTK),HL            ;WE RESTORE STACK WHEN ERRORS
  LD HL,(BASE+$0001)        ;GET START OF BIOS VECTOR TABLE

  ;  The following 3 rows are Apple II specific
  LD ($7DEE),HL
  LD A,H
  LD ($0107),A

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

  ;  This code section is Apple II specific
  EX DE,HL
  LD DE,$F1F8
  ADD HL,DE              ; -3592
  LD DE, SMC_V1
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD DE,SMC_V3
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD DE, SMC_V2
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD DE,SMC_V4
  LD (HL),E
  INC HL
  LD (HL),D
  LD HL,L4B7A
  LD ($0001),HL
  LD HL,($F3DE)           ; get the HW slot currently in use by the Z80 SoftCard
  LD (GO_6502+4),HL       ; ($45EB) use SMC to adjust the pivot routine calling the 6502


  ;  Check CP/M Version Number
IF CPMV1
  LD C,$0C                ; BDOS function 12 - Get BDOS version number
  CALL CPMENT
  LD (BDOSVER),A
  OR A
  LD HL,$1514             ; FN2=$15 (CP/M 1 WR), FN1=14 (CP/M 1 RD)
  JR Z,CPMVR1             ; JP if BDOS Version 1
  LD HL,$2221             ; FN2=$22 (Write record FN), FN1=$21 (Read record FN)

CPMVR1:                   ; Routine at 33368
  LD (CPMREA),HL          ; Load the BDOS FN code pair (FN1+FN2)
ENDIF

  LD HL,$FFFE
  LD (CURLIN),HL
  XOR A
  LD (CTLOFG),A
  LD (ENDBUF),A
  LD (CHNFLG),A
  LD (MRGFLG),A
  LD (ERRFLG),A
  LD HL,$0000
  LD (LPTPOS),HL
  LD (LF030),A
  LD A,(LF3BB_IOCONFIG)
  SUB $03
  JR Z,L8287
  DEC A
  JR Z,L8287
  LD A,$28
  LD BC,$503E

; Routine at 33415
;
; Used by the routine at CPMVR1.
L8287:
  LD A,$50
  LD (L4B97),A
  CALL __WIDTH_1
  LD HL,$0080
  LD (MAXREC),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,PRMSTK
  LD (PRMPRV),HL
  LD HL,($0006)
  LD (MEMSIZ),HL
  LD A,$03
  LD (MAXFIL),A
  LD HL,ZEROB
  LD (TEMP_PTR),HL
  LD A,(COMAGN)
  OR A
  JP NZ,DONCMD
  INC A
  LD (COMAGN),A
  LD HL,$0080
  LD A,(HL)
  OR A
  LD (TEMP_PTR),HL
  JP Z,DONCMD
  LD B,(HL)
  INC HL
TBF_LP:
  LD A,(HL)
  DEC HL
  LD (HL),A
  INC HL
  INC HL
  DEC B
  JP NZ,TBF_LP
  DEC HL

; Routine at 33492
ENDCMD:
  LD (HL),$00
  LD (TEMP_PTR),HL
  LD HL,$007F
  CALL CHRGTB
  OR A
  JP Z,DONCMD
  CP $2F
  JR Z,FNDSLH
  DEC HL
  LD (HL),$22
  LD (TEMP_PTR),HL
  INC HL
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
; This entry point is used by the routine at L833B.
SCANS1:
  CP 'S'              ; [/S:<maximum record size>]
  JR Z,WASS

  CP 'M'              ; [/M:<highest memory location>]
  PUSH AF             ;SAVE INDICATOR
  JR Z,WASM           ;WAS MEMORY OPTION

  CP 'F'              ; [/F:<number of files>]
  JP NZ,SN_ERR        ;NOT "M" OR "F" ERROR

; Routine at 33551
;
; Used by the routine at ENDCMD.
WASM:
  CALL CHRGTB         ;GET NEXT CHAR
  CALL SYNCHR

; Message at 33557
L8315:
  DEFM ":"

; Routine at 33558
L8316:
  CALL CNSGET
  POP AF
  JR Z,L8316_0

  LD A,D
  OR A
  JP NZ,FC_ERR
  LD A,E
  CP $10
  JP NC,FC_ERR
  LD (MAXFIL),A
  JR L8316_1
L8316_0:
  EX DE,HL
  LD (MEMSIZ),HL
  EX DE,HL
; This entry point is used by the routine at L8345.
L8316_1:
  DEC HL
  CALL CHRGTB
  JR Z,DONCMD
  CALL SYNCHR

; Message at 33594
L833A:
  DEFM "/"

; Routine at 33595
L833B:
  JP SCANS1

; Routine at 33598
;
; Used by the routine at ENDCMD.
WASS:
  CALL CHRGTB
  CALL SYNCHR

; Message at 33604
L8344:
  DEFM ":"

; Routine at 33605
L8345:
  CALL CNSGET
  EX DE,HL
  LD (MAXREC),HL
  EX DE,HL
  JR L8316_1

; Routine at 33615
ZEROB:
  NOP

; (TEMP_PTR)
TEMP_PTR:
  DEFW $0000

; Data block at 33618
COMAGN:
  DEFB $00

; Routine at 33619
;
; Used by the routines at L8287, ENDCMD and L8316.
DONCMD:
  DEC HL
  LD HL,(MEMSIZ)
  PUSH HL
  POP HL
  DEC HL
  LD (MEMSIZ),HL
  DEC HL
  PUSH HL
  LD A,(MAXFIL)
  LD HL,$81D1
  LD (FILPT1),HL
  LD DE,FILPTR
  LD (MAXFIL),A
  INC A
  LD BC,$00A9
DONCMD_0:
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  ADD HL,BC
  PUSH HL
  LD HL,(MAXREC)
  LD BC,$00B2
  ADD HL,BC
  LD B,H
  LD C,L
  POP HL
  DEC A
  JR NZ,DONCMD_0
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
  LD B,$03
DONCMD_1:
  OR A
  LD A,H
  RRA
  LD H,A
  LD A,L
  RRA
  LD L,A
  DJNZ DONCMD_1
  LD A,H
  CP $02
  JR C,DONCMD_2
  LD HL,$0200
DONCMD_2:
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,OM_ERR
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
  CALL __HOME
  LD HL,COPYRIGHT_MSG
  CALL PRS
  POP HL
  CALL LINPRT
  LD HL,BYTES_MSG
  CALL PRS
  LD HL,PRS
  LD ($0E34),HL
  CALL OUTDO_CRLF
  LD HL,$0D28
  LD ($0101),HL
  JP INITSA

; Message at 33783
AUTTXT:
  DEFB $0D
  DEFB $0A
  DEFB $0A
  DEFM "Owned by Microsoft"
  DEFB $0D
  DEFB $0A
  DEFB $00

; Message at 33807
BYTES_MSG:
  DEFM " Bytes free"
  DEFB $0D
  DEFB $0A
  DEFB $00

; Message at 33821
COPYRIGHT_MSG:
  DEFB $0D
  DEFB $0A
  DEFB $0D
  DEFB $0A
  DEFB $0D
  DEFB $0A
  DEFM "BASIC-80 Rev. 5.2"
  DEFB $0D
  DEFB $0A
  DEFM "[Apple CP/M Version]"
  DEFB $0D
  DEFB $0A
  DEFM "Copyright (C) 1980 by Microsoft"
  DEFB $0D
  DEFB $0A
  DEFM "Created: 12-Nov-80"
  DEFB $0D

; BASIC program area
L8480:

;defs 72
;TSTACK: ; $84C8
