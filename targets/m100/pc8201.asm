  ORG $0008

; Check syntax, 1 byte follows to be compared
;
; Used by the routines at SNERR, __FOR, __DATA, FDTLP, OPNPAR, OPRND, UCASE,
; DEPINT, MAKINT, GETWORD, TOPOOL, LFRGNM, MIDNUM, CHKSTK, ISFLIO, SCPTLP and
; GET_DEVICE.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  JP NZ,SNERR
  INC HL
  EX (SP),HL
; This entry point is used by the routines at SNERR, __FOR, ULERR, __DATA,
; FDTLP, EVAL4, OPRND, UCASE, FPSINT, FNDNUM, MAKINT, GETWORD, TOPOOL, MIDNUM,
; _DBL_ASCTFP, __RND, __POS, CHKSTK, ISFLIO, GETVAR, SCPTLP and GET_DEVICE.
CHRGTB:
  JP _CHRGTB
  
; This entry point is used by the routine at GET_DEVICE.
SYNCHR_1:
  EX DE,HL
  LD HL,($F507)
  EX DE,HL

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at SNERR, __FOR, __DATA, MAKINT, GETWORD, TSTOPL, TESTR,
; GSTRDE, _DBL_ASCTFP, __POS, CHKSTK, GETVAR, SCPTLP and GET_DEVICE.
CPDEHL:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET
; This entry point is used by the routine at ISFLIO.
CPDEHL_0:
  LD A,' '

; Output char in 'A' to console
;
; Used by the routines at SNERR, __DATA, MAKINT, GETWORD, PRS1, ISFLIO, SCPTLP
; and GET_DEVICE.
OUTC:
  JP _OUTC
  NOP
  JP GET_DEVICE_700
  NOP

; Test number FAC type (Precision mode, etc..)
;
; Used by the routines at DETOKEN_MORE, __FOR, __DATA, EVAL4, OPRND, GETWORD,
; TOPOOL, MIDNUM, __ABS, _TSTSGN, LOADFP, FCOMP, HLPASS, TSTSTR, FIX, __INT,
; _DBL_ASCTFP, GETVAR and SCPTLP.
GETYPR:
  JP __GETYPR
  
  NOP
  DI
  JP GET_DEVICE_697
  
; This entry point is used by the routines at __FOR, GETWORD, SCALE, __LOG,
; FMULT_BCDE, DIV, FCOMP, FIX, DECADD, _DBL_ASCTFP, POWER, __RND and __POS.
__TSTSGN:
  JP TSTSGN

  NOP
  DI
  JP _UART

; This entry point is used by the routines at SNERR, GETWORD, _DBL_ASCTFP, CHKSTK,
; ISFLIO, SCPTLP and GET_DEVICE.
GETYPR_1:
  JP GET_DEVICE_674
  
  NOP
  DI
  JP GETWORD_128

; Jump table for statements and functions
FNCTAB:
  DEFW __END
  DEFW __FOR
  DEFW __NEXT
  DEFW __DATA
  DEFW __TANUT
  DEFW __DIM
  DEFW __READ
  DEFW __LET
  DEFW __GO TO
  DEFW __RUN
  DEFW __IF
  DEFW __RESTORE
  DEFW __GOSUB
  DEFW __RETURN
  DEFW __DATA+2		;  REM
  DEFW __STOP
  DEFW __PRINT
  DEFW __CLEAR
  DEFW __LIST
  DEFW __NEW
  DEFW __ON
  DEFW ULERR
  DEFW ULERR
  DEFW __POKE
  DEFW __CONT
  DEFW __CSAVE
  DEFW __CLOAD
  DEFW __OUT
  DEFW __LPRINT
  DEFW __LLIST
  DEFW ULERR
  DEFW __WIDTH
  DEFW __DATA+2		; ELSE
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW __ERROR
  DEFW __RESUME
  DEFW __MENU
  DEFW ULERR
  DEFW __RENUM
  DEFW __DEFSTR
  DEFW __DEFINT
  DEFW __DEFSNG
  DEFW __DEFDBL
  DEFW __LINE
  DEFW __PRESET
  DEFW __PSET
  DEFW __BEEP
  DEFW __FORMAT
  DEFW __KEY
  DEFW __COLOR
  DEFW __COM
  DEFW __MAX
  DEFW __CMD
  DEFW __MOTOR
  DEFW __SOUND
  DEFW __EDIT
  DEFW __EXEC
  DEFW __SCREEN
  DEFW __CLS
  DEFW __POWER
  DEFW __BLOAD
  DEFW __BSAVE
  DEFW __DSKO_S
  DEFW ULERR
  DEFW ULERR
  DEFW __OPEN
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW __CLOSE
  DEFW _LOAD+2	; __LOAD
  DEFW _LOAD+3	; __MERGE
  DEFW __FILES
  DEFW __NAME
  DEFW __KILL
  DEFW ULERR
  DEFW ULERR
  DEFW __SAVE
  DEFW __LFILES
  DEFW ULERR
FNCTAB_0:
  DEFW __LOCATE
  
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  
;FNCTAB_FN:
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
  DEFW __PEEK	; $15e0

  DEFW __SPACE_S
  DEFW ULERR
  DEFW ULERR
  DEFW $1397
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW __CINT
  DEFW __CSNG
  DEFW __CDBL
  DEFW FIX
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW __LOF
  DEFW $1CFE
FNCTAB_1:
  DEFW $5203
  DEFW $5201
  DEFW $520D
  DEFW ULERR
  DEFW ULERR
  DEFW ULERR
  DEFW LNUM_TOKENS
  DEFW $018B
  DEFW $019A
  DEFW $01DA
  DEFW $020D
  DEFW $0231
  DEFW $0246
  DEFW $0255
  DEFW $0256
  DEFW $0272
  DEFW $0273
  DEFW $027B
  DEFW $02B7
  DEFW $02D0
  DEFW $02DF
  DEFW $02EE
  DEFW $030E
  DEFW $030F
  DEFW $033B
  DEFW $0373
  DEFW $0386
  DEFW $038C
  DEFW $0390
  DEFW WORDS_X
  DEFW WORDS_Y
  DEFW WORDS_Z

; BASIC keyword list
WORDS:

WORDS_A:
  DEFM "N"
  DEFB $C4
  DEFB $F8	; TK_AND
  DEFM "B"
  DEFB $D3
  DEFB $06	; TK_ABS
  DEFM "T"
  DEFB $CE
  DEFB $0E	; TK_ATN
  DEFM "S"
  DEFB $C3
  DEFB $15	; TK_ASC
  DEFB $00

WORDS_B:
  DEFM "SAV"
  DEFB $C5
  DEFB $C1	; TK_BSAVE
  DEFM "LOA"
  DEFB $C4
  DEFB $C0	; TK_BLOAD
  DEFM "EE"
  DEFB $D0
  DEFB $B2	; TK_BEEP
  DEFB $00

WORDS_C:
  DEFM "OLO"
  DEFB $D2
  DEFB $B5	; TK_COLOR
  DEFM "LOS"
  DEFB $C5
  DEFB $CA	; TK_CLOSE
  DEFM "ON"
  DEFB $D4
  DEFB $99	; TK_CONT
  DEFM "LEA"
  DEFB $D2
  DEFB $92	; TK_CLEAR
  DEFM "LOA"
  DEFB $C4
  DEFB $9B	; TK_CLOAD
  DEFM "SAV"
  DEFB $C5
  DEFB $9A	; TK_CSAVE
  DEFM "SRLI"
  DEFB $CE
  DEFB $E6	; TK_CSRLIN
  DEFM "IN"
  DEFB $D4
  DEFB $1F	; TK_CINT
  DEFM "SN"
  DEFB $C7
  DEFB $20	; TK_CSNG
  DEFM "DB"
  DEFB $CC
  DEFB $21	; TK_CDBL
  DEFM "O"
  DEFB $D3
  DEFB $0C	; TK_COS
  DEFM "HR"
  DEFB $A4
  DEFB $16	; TK_CHR$
  DEFM "O"
  DEFB $CD
  DEFB $B6	; TK_COM
  DEFM "L"
  DEFB $D3
  DEFB $BE	; TK_CLS
  DEFM "M"
  DEFB $C4
  DEFB $B8	; TK_CLD
  DEFB $00

WORDS_D:
  DEFM "AT"
  DEFB $C1
  DEFB $84	; TK_DATE
  DEFM "I"
  DEFB $CD
  DEFB $86	; TK_DIM
  DEFM "EFST"
  DEFB $D2
  DEFB $AB	; TK_DEFSTR
  DEFM "EFIN"
  DEFB $D4
  DEFB $AC	; TK_DEFINT
  DEFM "EFSN"
  DEFB $C7
  DEFB $AD	; TK_DEFSNG
  DEFM "EFDB"
  DEFB $CC
  DEFB $AE	; TK_DEFDBL
  DEFM "SKO"
  DEFB $A4
  DEFB $C2	; TK_DSKO$
  DEFM "SKI"
  DEFB $A4
  DEFB $E8	; TK_DSKI$
  DEFM "SK"
  DEFB $C6
  DEFB $26
  DEFM "ATE"
  DEFB $A4
  DEFB $EB	; TK_DATE
  DEFB $00

WORDS_E:
  DEFM "LS"
  DEFB $C5
  DEFB $A1	; TK_ELSE
  DEFM "N"
  DEFB $C4
  DEFB $81	; TK_END
  DEFM "DI"
  DEFB $D4
  DEFB $BB
  DEFM "RRO"
  DEFB $D2
  DEFB $A6	; TK_ERROR
  DEFM "R"
  DEFB $CC
  DEFB $DF
  DEFM "R"
  DEFB $D2
  DEFB $E0
  DEFM "XE"
  DEFB $C3
  DEFB $BC	; TK_EXEC
  DEFM "X"
  DEFB $D0
  DEFB $0B
  DEFM "O"
  DEFB $C6
  DEFM "'Q"
  DEFB $D6
  DEFB $FB	; TK_EQV
  DEFB $00

WORDS_F:
  DEFM "ORMA"
  DEFB $D4
  DEFB $B3	; TK_FORMAT
  DEFM "O"
  DEFB $D2
  DEFB $82
  DEFM "ILE"
  DEFB $D3
  DEFB $CD
  DEFM "R"
  DEFB $C5
  DEFB $0F
  DEFM "I"
  DEFB $D8
  DEFB $22	; TK_FIX
  DEFB $00

WORDS_G:
  DEFM "OT"
  DEFB $CF
  DEFB $89	; TK_GOTO
  DEFM "O T"
  DEFB $CF
  DEFB $89	; TK_GOTO
  DEFM "OSU"
  DEFB $C2
  DEFB $8D
  DEFB $00

WORDS_H:
  DEFB $00

WORDS_I:
  DEFM "NPU"
  DEFB $D4
  DEFB $85
  DEFB $C6
  DEFB $8B
  DEFM "NST"
  DEFB $D2
  DEFB $E3		; TK_INSTR
  DEFM "N"
  DEFB $D4
  DEFB $05
  DEFM "N"
  DEFB $D0
  DEFB $10
  DEFM "M"
  DEFB $D0
  DEFB $FC		; TK_IMP
  DEFM "NKEY"
  DEFB $A4
  DEFB $E9		; TK_INKEY
  DEFB $00

WORDS_J:
  DEFB $00

WORDS_K:
  DEFM "IL"
  DEFB $CC
  DEFB $CF
  DEFM "E"
  DEFB $D9
  DEFB $B4
  DEFB $00

WORDS_L:
  DEFM "OCAT"
  DEFB $C5
  DEFB $D5
  DEFM "PRIN"
  DEFB $D4
  DEFB $9D
  DEFM "LIS"
  DEFB $D4
  DEFB $9E
  DEFM "PO"
  DEFB $D3
  DEFB $1B
  DEFM "E"
  DEFB $D4
  DEFB $88
  DEFM "IN"
  DEFB $C5
  DEFB $AF
  DEFM "OA"
  DEFB $C4
  DEFB $CB
  DEFM "IS"
  DEFB $D4
  DEFB $93
  DEFM "FILE"
  DEFB $D3
  DEFB $D3
  DEFM "O"
  DEFB $C7
  DEFB $0A
  DEFM "O"
  DEFB $C3
  DEFM "(E"
  DEFB $CE
  DEFB $12
  DEFM "EFT"
  DEFB $A4
  DEFB $01
  DEFM "O"
  DEFB $C6
  DEFM ")"
  DEFB $00

WORDS_M:
  DEFM "OTO"
  DEFB $D2
  DEFB $B9
  DEFM "ERG"
  DEFB $C5
  DEFB $CC
  DEFM "O"
  DEFB $C4
  DEFB $FD		; TK_MOD
  DEFM "ID"
  DEFB $A4
  DEFB $03
  DEFM "A"
  DEFB $D8
  DEFB $B7
  DEFM "EN"
  DEFB $D5
  DEFB $A8
  DEFB $00
  
WORDS_N:
  DEFM "EX"
  DEFB $D4
  DEFB $83
  DEFM "AM"
  DEFB $C5
  DEFB $CE
  DEFM "E"
  DEFB $D7
  DEFB $94		; TK_NEW
  DEFM "O"
  DEFB $D4
  DEFB $DE
  DEFB $00

WORDS_O:
  DEFM "PE"
  DEFB $CE
  DEFB $C5
  DEFM "U"
  DEFB $D4
  DEFB $9C
  DEFB $CE
  DEFB $95
  DEFB $D2
  DEFB $F9		; TK_OR
  DEFM "F"
  DEFB $C6
  DEFB $E7
  DEFB $00

WORDS_P:
  DEFM "RIN"
  DEFB $D4
  DEFB $91		; TK_PRINT
  DEFM "OK"
  DEFB $C5
  DEFB $98		; TK_POKE
  DEFM "O"
  DEFB $D3
  DEFB $11
  DEFM "EE"
  DEFB $CB
  DEFB $17
  DEFM "SE"
  DEFB $D4
  DEFB $B1
  DEFM "RESE"
  DEFB $D4
  DEFB $B0
  DEFM "OWE"
  DEFB $D2
  DEFB $BF
  DEFB $00

WORDS_Q:
  DEFB $00

WORDS_R:
  DEFM "ETUR"
  DEFB $CE
  DEFB $8E
  DEFM "EA"
  DEFB $C4
  DEFB $87
  DEFM "U"
  DEFB $CE
  DEFB $8A		; TK_RUN
  DEFM "ESTOR"
  DEFB $C5
  DEFB $8C
  DEFM "E"
  DEFB $CD
  DEFB $8F
  DEFM "ESUM"
  DEFB $C5
  DEFB $A7
  DEFM "IGHT"
  DEFB $A4
  DEFB $02
  DEFM "N"
  DEFB $C4
  DEFB $08
  DEFM "ENU"
  DEFB $CD
  DEFB $AA
  DEFB $00

WORDS_S:
  DEFM "CREE"
  DEFB $CE
  DEFB $BD
  DEFM "TO"
  DEFB $D0
  DEFB $90
  DEFM "TATU"
  DEFB $D3
  DEFB $EE		; TK_STATUS
  DEFM "AV"
  DEFB $C5
  DEFB $D2
  DEFM "TE"
  DEFB $D0
  DEFB $DA
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
  DEFB $13
  DEFM "TRING"
  DEFB $A4
  DEFB $E1	; TK_STRING$
  DEFM "PACE"
  DEFB $A4
  DEFB $18	; TK_SPACE$
  DEFM "OUN"
  DEFB $C4
  DEFB $BA
  DEFB $00
  
WORDS_T:
  DEFM "HE"
  DEFB $CE
  DEFB $D8		; TK_THEN
  DEFM "AB"
  DEFB $A8
  DEFB $D9		; TK_TAB(
  DEFB $CF
  DEFB $D7		; TK_TO
  DEFM "IME"
  DEFB $A4
  DEFB $EA		; TK_TIME
  DEFM "A"
  DEFB $CE
  DEFB $0D
  DEFB $00
  
WORDS_U:
  DEFM "SIN"
  DEFB $C7
  DEFB $E2			; TK_USING
  DEFB $00

WORDS_V:
  DEFM "A"
  DEFB $CC
  DEFB $14
  DEFB $00
  
WORDS_W:
  DEFM "IDT"
  DEFB $C8
  DEFB $A0
  DEFB $00
  
WORDS_X:

  DEFM "O"
  DEFB 'R'+$80
  DEFB $FA		;TK_XOR
  DEFB $00

WORDS_Y:

  DEFB $00

WORDS_Z:

  DEFB $00

  
OPR_TOKENS:
  DEFB $AB
  DEFB $F3		; TK_PLUS		; Token for '+'
  DEFB $AD
  DEFB $F4		; TK_MINUS		; Token for '-'
  DEFB $AA
  DEFB $F5		; TK_STAR		; Token for '*'
  DEFB $AF
  DEFB $F6		; TK_SLASH		; Token for '/'
  DEFB $DE
  DEFB $F7		; TK_EXPONENT	; Token for '^'
  DEFB $DC
  DEFB $FE		; TK_BKSLASH	; Token for '\'
  DEFB $A7
  DEFB $E4		; TK_APOSTROPHE	; Token for '''
  DEFB $BE
  DEFB $F0		; TK_GREATER	; Token for '>'
  DEFB $BD
  DEFB $F1		; TK_EQUAL		; Token for '='
  DEFB $BC
  DEFB $F2		; TK_MINOR		; Token for '<'
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

DEC_OPR:
  DEFW DECADD
  DEFW DECSUB
  DEFW DECMUL
  DEFW DECDIV
  DEFW DECCOMP

FLT_OPR:
  DEFW FADD
  DEFW FSUB
  DEFW FMULT_BCDE
  DEFW FDIV
  DEFW FCOMP

;$03DB
INT_OPR:
  DEFW IADD
  DEFW ISUB
  DEFW IMULT
  DEFW IDIV
  DEFW ICOMP


ERRMSG:
  DEFM "NFSNRGODFCOVOMULBSDD"
  DEFM "/0IDTMOSLSSTCNUFNRRW"
  DEFM "UEMOBOIODUIEBNFFAOEF"
  DEFM "NMDSFLCFPC"

; Data block at 1067
SYSVARS_ROM:
  DEFW $8A4D
  DEFW $0000
  DEFW $F380
  DEFW $00C9
  DEFW $FB00
  DEFW $00C9
  DEFW $00C9
  DEFW $C900
  DEFW $0000
  DEFW $95C3
  DEFW $DB18
  DEFW $E6A0
  DEFW $C00C
  DEFW FNCTAB_1
  DEFW $A1D3
  DEFW $4021
  DEFW $1100
  DEFW $F991
  DEFW $127E
  DEFW UCASE_6
  DEFW $D67D
  DEFW $C248
  DEFW $F3A4
  DEFW $A1D3
  DEFW $912A
  DEFW $11F9
  DEFW $4241
  DEFW $18C3
  DEFW $F300
  DEFW FNCTAB_1
  DEFW $A1D3
  DEFW $00C7
  DEFW $5321
  DEFW $5459
  DEFW FNCTAB
  DEFW $00F0
  DEFW $00C9
  DEFW $C900
  DEFW $0000
  DEFW $00C9
  DEFW $C900
  DEFW $0000
  DEFW $00C9
  DEFW $C900
  DEFW $0000
  DEFW $0000
  DEFW $C9C0
  DEFW $0000
  DEFW $0000
  DEFW $FFFF
  DEFW $0100
  DEFW $0801
  DEFW GETYPR
  DEFW $0000
  DEFW $0101
  DEFW $0101
  DEFW $2819
  DEFW $0000
  DEFW L4FC4_4
  DEFW $3038
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $FF64
  DEFW $0000
  DEFW $4938
  DEFW $3137
  DEFW GET_DEVICE_5
  DEFW $00C3
  DEFW $0000
  DEFW $00C9
  DEFW $D3C9
  DEFW $C900
  DEFW $00D6
  DEFW $7C6F
  DEFW $00DE
  DEFW $7867
  DEFW $00DE
  DEFW $3E47
  DEFW $C900
  DEFW $0000
  DEFW $3500
  DEFW $CA4A
  DEFW $3999
  DEFW $761C
  DEFW $2298
  DEFW $B395
  DEFW $0A98
  DEFW $47DD
  DEFW $5398
  DEFW $99D1
  DEFW $0A99
  DEFW $9F1A
  DEFW $6598
  DEFW $CDBC
  DEFW $D698
  DEFW $3E77
  DEFW $5298
  DEFW $4FC7
  DEFW $DB80
  DEFW $C900
  DEFW $003A
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW __IF
  DEFW $FA00
  DEFW $FEFB
  DEFW $97FF
  DEFW $00FB
  DEFB 0



; Message at 1292
ERR_MSG:
  DEFM " Error"
  DEFB $00
;$0513
IN_MSG:
  DEFM " in "

; Data block at 1303
NULL_STRING:
  DEFB $00

; Message at 1304
OK_MSG:
  DEFM "Ok"
  DEFB $0D
  DEFB $0A
  DEFB $00
  
BREAK_MSG:
  DEFM "Break"
  DEFB $00

; Routine at 1315
;
; Used by the routines at ULERR and CHKSTK.
L0523:
  LD HL,$0004
  ADD HL,SP
; This entry point is used by the routine at __FOR.
NEXT_UNSTACK_0:
  LD A,(HL)
  INC HL
  CP $82
  RET NZ
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH HL
  LD H,B
  LD L,C
  LD A,D
  OR E
  EX DE,HL
  JP Z,L0523_1
  EX DE,HL
  RST $18
L0523_1:
  LD BC,$000E
  POP HL
  RET Z
  ADD HL,BC
  JP NEXT_UNSTACK_0
  
; This entry point is used by the routine at __MERGE.
L0523_2:
  LD BC,RESTART
; This entry point is used by the routine at ISFLIO.
L0523_3:
  JP JPBC
  
; This entry point is used by the routine at __FOR.
L0523_4:
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,BASIC_MAIN_1
  LD A,($FADA)
  OR A
  LD E,$13
  JP NZ,ERROR
BASIC_MAIN_1:
  JP __END_1
  JP ERROR


; 'SN err' entry for Input STMT
;
; Used by the routine at __DATA.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?SN ERROR'
;
; Used by the routines at SYNCHR, __FOR, __DATA, EVAL4, GETWORD, CHKSTK,
; GETVAR, SCPTLP and GET_DEVICE.
SNERR:
  LD E,$02
  LD BC,$3B1E
  LD BC,$191E
  LD BC,$0B1E
  LD BC,$011E
  LD BC,$0A1E
  LD BC,$141E
  LD BC,$061E
  LD BC,$161E
  LD BC,$0D1E
  
; This entry point is used by the routines at DETOKEN_MORE, __FOR, ULERR,
; __DATA, FDTLP, GETWORD, TSTOPL, TESTR, CONCAT, CHKSTK, SCPTLP and GET_DEVICE.
ERROR:
  XOR A
  LD (NLONLY),A
  LD HL,(VLZADR)
  LD A,H
  OR L
  JP Z,SNERR_1
  LD A,(VLZDAT)
  LD (HL),A
  LD HL,$0000
  LD (VLZADR),HL
SNERR_1:
  EI
  LD HL,(ERRTRP)
  PUSH HL
  LD A,H
  OR L
  RET NZ
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  LD A,H
  AND L
  INC A
  JP Z,ERROR_2
  LD (DOT),HL
; This entry point is used by the routine at __DATA.
ERROR_2:
  LD BC,L05BB
  LD HL,(SAVSTK)
  JP WARM_ENTRY
  
L05BB:
  POP BC
  LD A,E
  LD C,E
  LD (ERR_CODE),A
  LD HL,(SAVTXT)
  LD (ERRTXT),HL
  EX DE,HL
  LD HL,(ERRLIN)
  LD A,H
  AND L
  INC A
  JP Z,SNERR_3
  LD (OLDLIN),HL
  EX DE,HL
  LD (OLDTXT),HL
SNERR_3:
  LD HL,(ONELIN)
  LD A,H
  OR L
  EX DE,HL
  LD HL,ONEFLG		; =1 if executing an error trap routine
  JP Z,ERROR_REPORT
  AND (HL)
  JP NZ,ERROR_REPORT
  ; We get here if the standard error handling is temporairly disabled (error trap).
  DEC (HL)
  EX DE,HL
  JP EXEC_EVAL_1
  
ERROR_REPORT:
  XOR A
  LD (HL),A
  LD E,C
  CALL CONSOLE_CRLF
  CALL HERRP			; Hook 1 for Error Handler
  LD A,E
  CP $3C
  JP NC,UNKNOWN_ERR 	; JP if error code is bigger than $3B
  CP $32
  JP NC,SUB_18_ERR 		; JP if error code is between $33 and $3B
  CP $1A
  JP C,SNERR_7		; JP if error code is < $1A
  
UNKNOWN_ERR:
  LD A,$2D		; if error code is bigger than $3B then force it to ("Unprintable error")
SUB_18_ERR:
  SUB $18		; JP if error code is between $33 and $3B, sub $18
  LD E,A
SNERR_7:
  LD D,$00
  LD HL,ERRMSG-2
  ADD HL,DE
  ADD HL,DE
  LD A,$3F 		; '?'
  RST OUTC
  LD A,(HL)
  RST OUTC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST OUTC
  LD HL,ERR_MSG
  PUSH HL
  LD HL,(ERRLIN)
  EX (SP),HL
; This entry point is used by the routine at CHKSTK.
SNERR_8:
  CALL PRS
  POP HL
  LD A,H
  AND L
  INC A
  CALL NZ,LNUM_MSG
  LD A,$C1

; Routine at 1580
;
; Used by the routines at GETWORD, CHKSTK and ISFLIO.
RESTART:
  POP BC
; This entry point is used by the routines at MAKINT, GETWORD and GET_DEVICE.
READY:
  CALL INIT_OUTPUT
  CALL SCPTLP_104
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  CALL PRS
  
; This entry point is used by the routine at SCPTLP.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL
  LD HL,$F44E
  LD (SAVTXT),HL
  CALL ERAEOL1
  JP C,PROMPT
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  INC A
  DEC A
  JP Z,PROMPT
  PUSH AF
  CALL LNUM_PARM_0
  JP NC,SNERR_11
  CALL ISFLIO
  JP Z,SNERR
SNERR_11:
  CALL DETOKEN_MORE_18
  LD A,(HL)
  CP ' '
  CALL Z,INCHL
  PUSH DE
  CALL TOKENIZE
  POP DE
  POP AF
  LD (SAVTXT),HL
  JP NC,SCPTLP_100
  PUSH DE
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  OR A
  PUSH AF
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL FIRST_LNUM
  JP C,SNERR_12
  POP AF
  PUSH AF
  JP Z,ULERR			; Error: "Undefined line number"
  OR A
SNERR_12:
  PUSH BC
  PUSH AF
  PUSH HL
  CALL GETWORD_19
  POP HL
  POP AF
  POP BC
  PUSH BC
  JP NC,SNERR_13
  CALL MAKINT_32
  LD A,C
  SUB E
  LD C,A
  LD A,B
  SBC A,D
  LD B,A
  CALL GETWORD_256
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,($F9CA)
  ADD HL,BC
  LD ($F9CA),HL
SNERR_13:
  POP DE
  POP AF
  PUSH DE
  JP Z,SNERR_15
  POP DE
  LD HL,$0000
  LD (ONELIN),HL
  LD HL,(PROGND)
  EX (SP),HL
  POP BC
  PUSH HL
  ADD HL,BC
  PUSH HL
  CALL __POS_1
  POP HL
  LD (PROGND),HL
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
  PUSH HL
  CALL GETWORD_256
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,($F9CA)
  ADD HL,BC
  LD ($F9CA),HL
  POP HL
  DEC BC
  DEC BC
  DEC BC
  DEC BC
SNERR_14:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
  LD A,C
  OR B
  JP NZ,SNERR_14
SNERR_15:
  POP DE
  CALL UPD_PTRS_0
  LD HL,(PTRFIL)
  LD (TEMP2),HL
  CALL RUN_FST
  LD HL,(TEMP2)
  LD (PTRFIL),HL			; Redirect I/O
  JP PROMPT
; This entry point is used by the routines at GETWORD, CHKSTK and GET_DEVICE.
UPD_PTRS:
  LD HL,(BASTXT)
  EX DE,HL
; This entry point is used by the routine at GETWORD.
UPD_PTRS_0:
  LD H,D
  LD L,E
  LD A,(HL)
  INC HL
  OR (HL)
  RET Z
  INC HL
  INC HL
SNERR_18:
  INC HL
  LD A,(HL)
SNERR_19:
  OR A
  JP Z,ERROR_20
  CP ' '
  JP NC,SNERR_18
  CP $0B
  JP C,SNERR_18
  CALL __FOR_12
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP SNERR_19
ERROR_20:
  INC HL
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JP UPD_PTRS_0
  
; This entry point is used by the routine at MAKINT.
LNUM_RANGE:
  LD DE,$0000
  PUSH DE
  JP Z,$0750
  POP DE
  CALL __FOR_33
  PUSH DE
  JP Z,ERROR_22
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  CALL P,GET_DEVICE_715
  RST $38
  CALL NZ,__FOR_33
  JP NZ,SNERR

ERROR_22:
  EX DE,HL
  POP DE
; This entry point is used by the routine at __DATA.
PHL_FIND_LINE:
  EX (SP),HL
  PUSH HL
; This entry point is used by the routines at __FOR, GETWORD and CHKSTK.
FIRST_LNUM:
  LD HL,(BASTXT)
; This entry point is used by the routine at __FOR.
FIND_LINE_FHL:
  LD B,H
  LD C,L
  LD A,(HL)
  INC HL
  OR (HL)
  DEC HL
  RET Z
  INC HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RST CPDEHL
  LD H,B
  LD L,C
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  CCF
  RET Z
  CCF
  RET NC
  JP FIND_LINE_FHL

TOKENIZE:
  XOR A
  LD (DONUM),A
  LD (DORES),A
  LD BC,$013B		; $01, $3b
  LD DE,KBUF

; This entry point is used by the routine at DETOKEN_MORE.
TOKENIZE_NEXT:
  LD A,(HL)
  OR A
  JP NZ,TOKENIZE_2
  
TOKENIZE_END:
  LD HL,$0140		; $01, $40
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

TOKENIZE_2:
  CP '"'
  JP Z,SNERR_34
  CP ' '
  JP Z,SNERR_30
  LD A,(DORES)
  OR A
  LD A,(HL)
  JP Z,TOKENIZE_11
; This entry point is used by the routine at DETOKEN_MORE.
SNERR_30:
  INC HL
  PUSH AF
  CALL DETOKEN_MORE_13
  POP AF
  SUB $3A
  JP Z,SNERR_31
  CP $4A
  JP NZ,SNERR_32
  LD A,$01
SNERR_31:
  LD (DORES),A
  LD (DONUM),A
SNERR_32:
  SUB $55
  JP NZ,TOKENIZE_NEXT
  PUSH AF
SNERR_33:
  LD A,(HL)
  OR A
  EX (SP),HL
  LD A,H
  POP HL
  JP Z,TOKENIZE_END
  CP (HL)
  JP Z,SNERR_30
SNERR_34:
  PUSH AF
  LD A,(HL)
; This entry point is used by the routine at DETOKEN_MORE.
SNERR_35:
  INC HL
  CALL DETOKEN_MORE_13
  JP SNERR_33

TOKENIZE_11:
  INC HL
  OR A
  JP M,TOKENIZE_NEXT
  DEC HL
  CP '?'
  LD A,$91		; TK_PRINT
  PUSH DE
  PUSH BC
  JP Z,TOKEN_FOUND
  LD DE,OPR_TOKENS
  CALL UCASE_HL
  CALL IS_ALPHA_A
  JP C,DETOKEN_MORE_2
  PUSH HL
  LD HL,$014A
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
SNERR_37:
  PUSH HL
SNERR_38:
  CALL UCASE_HL
  LD C,A
  LD A,(DE)
  AND $7F
  JP Z,DETOKEN_MORE_14
  INC HL
  CP C
  JP NZ,SNERR_39
  LD A,(DE)
  INC DE
  OR A
  JP P,SNERR_38
  POP AF
  LD A,(DE)
  OR A
  JP M,ERROR_REPORT1
  POP BC
  POP DE
  OR $80
  PUSH AF
  LD A,$FF
  CALL DETOKEN_MORE_13
  XOR A
  LD (DONUM),A
  POP AF
  CALL DETOKEN_MORE_13
  JP TOKENIZE_NEXT

SNERR_39:
  POP HL
ERROR_REPORT0:
  LD A,(DE)
  INC DE
  OR A
  JP P,ERROR_REPORT0
  INC DE
  JP SNERR_37
ERROR_REPORT1:
  DEC HL
TOKEN_FOUND:
  PUSH AF
  LD DE,LNUM_TOKENS
  LD C,A
ERROR_REPORT3:
  LD A,(DE)
  OR A
  JP Z,ERROR_REPORT4
  INC DE
  CP C
  JP NZ,ERROR_REPORT3
  JP $086F
  
; Message at 2143
LNUM_TOKENS:
  DEFB $8C	; TK_RESTORE
  DEFB $AA	; TK_RENUM
  DEFB $BB
  DEFB $A7	; TK_RESUME
  DEFB $DF
  DEFB $A1	; TK_ELSE
  DEFB $8A	; TK_RUN
  DEFB $93	; TK_LIST
  DEFB $9E	; TK_LLIST
  DEFB $89	; TK_GOTO
  DEFB $8E	; TK_RETURN
  DEFB $D8	; TK_THEN
  DEFB $8D	; TK_GOSUB
  DEFB $00

ERROR_REPORT4:
  XOR A

; Continue decoding tokens
DETOKEN_MORE:
  JP NZ,FNCTAB_1
DETOKEN_MORE_0:
  LD (DONUM),A
  POP AF
DETOKEN_MORE_1:
  POP BC
  POP DE
  CP $A1		; TK_ELSE
  PUSH AF
  CALL Z,DETOKEN_MORE_12
  POP AF
  CP $E4
  JP NZ,SNERR_30
  PUSH AF
  CALL DETOKEN_MORE_12
  LD A,$8F
  CALL DETOKEN_MORE_13
  POP AF
  PUSH HL
  LD HL,$0000
  EX (SP),HL
  JP SNERR_35
; This entry point is used by the routine at SNERR.
DETOKEN_MORE_2:
  LD A,(HL)
  CP '.'
  JP Z,DETOKEN_MORE_3
  CP '9'+1
  JP NC,DETOKEN_MORE_10
  CP '0'
  JP C,DETOKEN_MORE_10
DETOKEN_MORE_3:
  LD A,(DONUM)
  OR A
  LD A,(HL)
  POP BC
  POP DE
  JP M,SNERR_30
  JP Z,DETOKEN_MORE_6
  CP '.'
  JP Z,SNERR_30
  LD A,$0E				; Line number prefix
  CALL DETOKEN_MORE_13
  PUSH DE
  CALL LNUM_PARM_0		; Get specified line number
  CALL DETOKEN_MORE_18
  EX (SP),HL
  EX DE,HL
DETOKEN_MORE_4:
  LD A,L
  CALL DETOKEN_MORE_13
  LD A,H
DETOKEN_MORE_5:
  POP HL
  CALL DETOKEN_MORE_13
  JP TOKENIZE_NEXT
DETOKEN_MORE_6:
  PUSH DE
  PUSH BC
  LD A,(HL)
  CALL DBL_ASCTFP
  CALL DETOKEN_MORE_18
  POP BC
  POP DE
  PUSH HL
  LD A,(VALTYP)
  CP $02
  JP NZ,DETOKEN_MORE_7
  LD HL,(DBL_FPREG)
  LD A,H
  OR A
  LD A,$02
  JP NZ,DETOKEN_MORE_7
  LD A,L
  LD H,L
  LD L,$0F
  CP $0A
  JP NC,DETOKEN_MORE_4
  ADD A,$11
  JP DETOKEN_MORE_5
DETOKEN_MORE_7:
  PUSH AF
  RRCA
  ADD A,$1B
  CALL DETOKEN_MORE_13
  LD HL,DBL_FPREG
  RST GETYPR 		; Get the number type (FAC)
  JP C,DETOKEN_MORE_8
  LD HL,$FB24
DETOKEN_MORE_8:
  POP AF
DETOKEN_MORE_9:
  PUSH AF
  LD A,(HL)
  CALL DETOKEN_MORE_13
  POP AF
  INC HL
  DEC A
  JP NZ,DETOKEN_MORE_9
  POP HL
  JP TOKENIZE_NEXT
DETOKEN_MORE_10:
  LD DE,OPR_TOKENS-1
DETOKEN_MORE_11:
  INC DE
  LD A,(DE)
  AND $7F
  JP Z,DETOKEN_MORE_15
  INC DE
  CP (HL)
  LD A,(DE)
  JP NZ,DETOKEN_MORE_11
  JP DETOKEN_MORE_16
DETOKEN_MORE_12:
  LD A,$3A
; This entry point is used by the routine at SNERR.
DETOKEN_MORE_13:
  LD (DE),A
  INC DE
  DEC BC
  LD A,C
  OR B
  RET NZ
  LD E,$17
  JP ERROR
; This entry point is used by the routine at SNERR.
DETOKEN_MORE_14:
  POP HL
  DEC HL
  DEC A
  LD (DONUM),A
  CALL UCASE_HL
  JP DETOKEN_MORE_1
DETOKEN_MORE_15:
  LD A,(HL)
  CP ' '
  JP NC,DETOKEN_MORE_16
  CP $09
  JP Z,DETOKEN_MORE_16
  CP $0A
  JP Z,DETOKEN_MORE_16
  LD A,' '
DETOKEN_MORE_16:
  PUSH AF
  LD A,(DONUM)
  INC A
  JP Z,DETOKEN_MORE_17
  DEC A
DETOKEN_MORE_17:
  JP DETOKEN_MORE_0
; This entry point is used by the routine at SNERR.
DETOKEN_MORE_18:
  DEC HL
  LD A,(HL)
  CP ' '
  JP Z,DETOKEN_MORE_18
  CP $09
  JP Z,DETOKEN_MORE_18
  CP $0A
  JP Z,DETOKEN_MORE_18
  INC HL
  RET

; 'FOR' BASIC instruction
__FOR:
  LD A,$64
  LD (SUBFLG),A
  CALL __LET
  POP BC
  PUSH HL
  CALL __DATA
  LD ($FAC5),HL
  LD HL,$0002
  ADD HL,SP
__FOR_0:
  CALL $0527
  JP NZ,$09AD
  ADD HL,BC
  PUSH DE
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  INC HL
  INC HL
  PUSH HL
  LD HL,($FAC5)
  RST CPDEHL
  POP HL
  POP DE
  JP NZ,__FOR_0
  POP DE
  LD SP,HL
  LD (SAVSTK),HL
  LD C,$D1
  EX DE,HL
  LD C,$08
  CALL CHKSTK
  PUSH HL
  LD HL,($FAC5)
  EX (SP),HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST GETYPR 		; Get the number type (FAC)
  JP Z,TMERR
  JP NC,TMERR
  PUSH AF
  CALL $1091
  POP AF
  PUSH HL
  JP P,__FOR_1
  CALL __CINT
  EX (SP),HL
  LD DE,$0001
  LD A,(HL)
  CP $DA
  CALL Z,FPSINT
  PUSH DE
  PUSH HL
  EX DE,HL
  CALL _SGN_RESULT
  JP __FOR_2
__FOR_1:
  CALL __CSNG
  CALL BCDEFP
  POP HL
  PUSH BC
  PUSH DE
  LD BC,$8100
  LD D,C
  LD E,D
  LD A,(HL)
  CP $DA
  LD A,$01
  JP NZ,__FOR_3
  CALL EVAL
  PUSH HL
  CALL __CSNG
  CALL BCDEFP
  RST TSTSGN
__FOR_2:
  POP HL
__FOR_3:
  PUSH BC
  PUSH DE
  OR A
  JP NZ,__FOR_4
  LD A,$02
__FOR_4:
  LD C,A
  RST GETYPR 		; Get the number type (FAC)
  LD B,A
  PUSH BC
  PUSH HL
  LD HL,(TEMP)
  EX (SP),HL
; This entry point is used by the routine at CHKSTK.
__FOR_5:
  LD B,$82
  PUSH BC
  INC SP
; This entry point is used by the routines at GETWORD, CHKSTK, ISFLIO and
; GET_DEVICE.
EXEC_EVAL:
  CALL GET_DEVICE_708
  CALL RCVX
  CALL NZ,RUN_FST3
; This entry point is used by the routine at GETWORD.
__FOR_7:
  CALL GETWORD_37
  LD (SAVTXT),HL
  EX DE,HL
  LD HL,$0000
  ADD HL,SP
  LD (SAVSTK),HL
  EX DE,HL
  LD A,(HL)
  CP $3A
  JP Z,EXEC
  OR A
  JP NZ,SNERR
  INC HL
; This entry point is used by the routine at SNERR.
EXEC_EVAL_1:
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,WORDS_3
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (CURLIN),HL
  EX DE,HL
  
; This entry point is used by the routine at SCPTLP.
EXEC:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD DE,EXEC_EVAL
  PUSH DE
  RET Z
; This entry point is used by the routine at __DATA.
__FOR_10:
  CP $EA			; TK_TIME
  JP Z,TIME
  CP $EB			; TK_DATE
  JP Z,DATE
  SUB $81			; Normal Alphanum sequence ?
  JP C,__LET		; Ok, assume an implicit "LET" statement
  CP $55			;TK_TO-$81
  JP NC,SNERR
  RLCA
  LD C,A
  LD B,$00
  EX DE,HL
  LD HL,($F3C4)		; FNCTAB JP table
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  EX DE,HL

; This entry point is used by the routines at SYNCHR, __DATA, DTSTR and SCPTLP.
_CHRGTB:
  INC HL
; This entry point is used by the routine at SNERR.
__FOR_12:
  LD A,(HL)
  CP $3A
  RET NC
  CP ' '
  JP Z,_CHRGTB
  JP NC,__FOR_22
  OR A
  RET Z
  CP $0B
  JP C,__FOR_21
  CP $0D
  JP NC,__FOR_13
  LD A,$1C
__FOR_13:
  CP $1E
  JP NZ,__FOR_14
  LD A,(CONSAV)
  OR A
  RET
__FOR_14:
  CP $10
  JP Z,__FOR_19
  PUSH AF
  INC HL
  LD (CONSAV),A
  SUB $1C
  JP NC,__FOR_20
  SUB $F5
  JP NC,__FOR_15
  CP $FE
  JP NZ,__FOR_17
  LD A,(HL)
  INC HL
__FOR_15:
  LD (CONTXT),HL
  LD H,$00
__FOR_16:
  LD L,A
  LD (CONLO),HL
  LD A,$02
  LD (CONTYP),A
  LD HL,$0B05
  POP AF
  OR A
  RET
__FOR_17:
  LD A,(HL)
  INC HL
  INC HL
  LD (CONTXT),HL
  DEC HL
  LD H,(HL)
  JP __FOR_16
; This entry point is used by the routine at OPRND.
__FOR_18:
  CALL __FOR_23
__FOR_19:
  LD HL,(CONTXT)
  JP __FOR_12
__FOR_20:
  INC A
  RLCA
  LD (CONTYP),A
  PUSH DE
  PUSH BC
  LD DE,CONLO
  EX DE,HL
  LD B,A
  CALL REV_LDIR_B
  EX DE,HL
  POP BC
  POP DE
  LD (CONTXT),HL
  POP AF
  LD HL,$0B05
  OR A
  RET
__FOR_21:
  CP $09
  JP NC,_CHRGTB
__FOR_22:
  CP '0'
  CCF
  INC A
  DEC A
  RET

  LD E,$10
; This entry point is used by the routine at MAKINT.
__FOR_23:
  LD A,(CONSAV)
  CP $0F			; Prefix for Integer 10 to 255 ?
  JP NC,__FOR_25
  CP $0C+1
  JP C,__FOR_25			; JP if Prefix for Hex or Octal number
  LD HL,(CONLO)			; Value of stored constant
  JP NZ,__FOR_24
  INC HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
__FOR_24:
  JP DBL_ABS_0
  
__FOR_25:
  LD A,(CONTYP)			; Type of stored constant
  LD (VALTYP),A
  CP $08
  JP Z,__FOR_26
  LD HL,(CONLO)			; Value of stored constant
  LD (DBL_FPREG),HL
  LD HL,(CONLO+2)
  LD (LAST_FPREG),HL
  RET

__FOR_26:
  LD HL,CONLO
  JP LOADFP_7
  

__DEFSTR:
  LD E,$03

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it

__DEFINT:
  LD E,$02	; Integer type
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it

__DEFSNG:
  LD E,$04	; Single precision type

  DEFB $01	; "LD BC,nn" to jump over the next word without executing it

__DEFDBL:
  LD E,$08	; Double Precision type

DEFVAL:
  CALL IS_ALPHA  		; Load A with char in (HL) and check it is a letter
  LD BC,SNERR
  PUSH BC
  RET C
  SUB $41
  LD C,A
  LD B,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $F4		; TK_MINUS, '-'
  JP NZ,__FOR_28
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL IS_ALPHA  		; Load A with char in (HL) and check it is a letter
  RET C
  SUB $41
  LD B,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
__FOR_28:
  LD A,B
  SUB C
  RET C
  INC A
  EX (SP),HL
  LD HL,$FAED
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
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP DEFVAL

; This entry point is used by the routine at SCPTLP.
GET_POSINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
; This entry point is used by the routine at CHKSTK.
__FOR_31:
  CALL FPSINT_0
  RET P
; This entry point is used by the routines at __DATA, MAKINT, GETWORD, GSTRDE,
; TOPOOL, MIDNUM, __LOG, CHKSTK, SCPTLP and GET_DEVICE.
FCERR:
  LD E,$05
  JP ERROR
; This entry point is used by the routines at SNERR and GETWORD.
__FOR_33:
  LD A,(HL)
  CP '.'
  EX DE,HL
  LD HL,(DOT)
  EX DE,HL
  JP Z,_CHRGTB

; This entry point is used by the routines at SNERR, DETOKEN_MORE, __DATA,
; GETWORD and CHKSTK.
; Get specified line number
; ASCII to Integer, result in DE
LNUM_PARM_0:
  DEC HL
; This entry point is used by the routine at __DATA.
LNUM_PARM_1::
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $0E			; Line number prefix
  JP Z,__FOR_36
  CP $0D
; This entry point is used by the routine at GETWORD.
__FOR_36:
  EX DE,HL
  LD HL,(CONLO)
  EX DE,HL
  JP Z,_CHRGTB
  XOR A
  LD (CONSAV),A
  LD DE,$0000
  DEC HL
__FOR_37:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET NC
  PUSH HL
  PUSH AF
  LD HL,$1998
  RST CPDEHL
  JP C,__FOR_38
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
  JP __FOR_37
__FOR_38:
  POP AF
  POP HL
  RET
  
__RUN:
  JP Z,RUN_FST
  CP $0E			; Line number prefix
  JP Z,__RUN_0
  CP $0D		; CR
  JP NZ,_LOAD
__RUN_0:
  CALL _CLVAR
  LD BC,EXEC_EVAL
  JP GO_TO

__GOSUB:
  LD C,$03
  CALL CHKSTK
  CALL LNUM_PARM_0
  POP BC
  PUSH HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  LD BC,$0000
  PUSH BC
  LD BC,EXEC_EVAL
  LD A,$8D
  PUSH AF
  INC SP
  PUSH BC
  JP __GO_TO_0
; This entry point is used by the routine at CHKSTK.
__FOR_40:
  PUSH HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  PUSH BC
  LD A,$8D
  PUSH AF
  INC SP
  EX DE,HL
  DEC HL
  LD (SAVTXT),HL
  INC HL
  JP EXEC_EVAL_1
  
GO_TO:
  PUSH BC
; This entry point is used by the routines at ULERR and __DATA.
__GO TO:
  CALL LNUM_PARM_0
; This entry point is used by the routine at __DATA.
__GO_TO_0:
  LD A,(CONSAV)
  CP $0D
  EX DE,HL
  RET Z
  CP $0E			; Line number prefix
  JP NZ,SNERR
  EX DE,HL
  PUSH HL
  LD HL,(CONTXT)
  EX (SP),HL
  CALL __DATA+2		; 'Move to next line' (used by ELSE, REM..)
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  RST CPDEHL
  POP HL
  CALL C,FIND_LINE_FHL
  CALL NC,FIRST_LNUM	; Get first line number
  JP NC,ULERR			; Error: "Undefined line number"
  DEC BC
  LD A,$0D
  LD (PTRFLG),A
  POP HL
  CALL GETWORD_18
  LD H,B
  LD L,C
  RET

; entry for '?UL ERROR'
;
; Used by the routines at SNERR, __FOR, __DATA and CHKSTK.
ULERR:
  LD E,$08
  JP ERROR
  
__RETURN:
  LD (TEMP),HL
  LD D,$FF
  CALL NEXT_UNSTACK			; search FOR block on stack (skip 2 words)
  CP $8D
  JP Z,ULERR			; Error: "Undefined line number"_0
  DEC HL
ULERR_0:
  LD SP,HL
  LD (SAVSTK),HL
  LD E,$03				; Err $03 - RETURN without GOSUB
  JP NZ,ERROR
  
  POP HL
  LD A,H
  OR L
  JP Z,ULERR			; Error: "Undefined line number"_1
  LD A,(HL)
  AND $01
  CALL NZ,TIME_S_STOP_1
ULERR_1:
  POP BC
  LD HL,EXEC_EVAL
  EX (SP),HL
  EX DE,HL
  LD HL,(TEMP)
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,__GO TO
  
  LD H,B
  LD L,C
  LD (CURLIN),HL
  EX DE,HL

  DEFB $3E  ; "LD A,n" to Mask the next byte

  POP HL

; DATA statement: find next DATA program line..
;
; Used by the routines at __FOR and FDTLP.
__DATA:
  LD BC,$0E3A		; Put ':' in C, $0E in B

; Used by 'REM', 'ELSE' and error handling code.
; __DATA+2:
; LD C,0		; Put $00 in C

  NOP
  LD B,$00
__DATA_0:
  LD A,C
  LD C,B
  LD B,A
__DATA_1:
  DEC HL
__DATA_2:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  OR A
  RET Z
  CP B
  RET Z
  INC HL
  CP '"'
  JP Z,__DATA_0
  INC A
  JP Z,__DATA_2
  SUB $8C
  JP NZ,__DATA_1
  CP B
  ADC A,D
  LD D,A
  JP __DATA_1
  POP AF
  ADD A,$03
  JP __DATA_3

; This entry point is used by the routine at __FOR.
__LET:
  CALL GETVAR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  POP AF
  EX DE,HL
  LD (TEMP),HL
  EX DE,HL
  PUSH DE
  LD A,(VALTYP)
  PUSH AF
  CALL $1091
  POP AF
__DATA_3:
  EX (SP),HL
__DATA_4:
  LD B,A
  LD A,(VALTYP)
  CP B
  LD A,B
  JP Z,__DATA_5
  CALL OPRND_3_05
  LD A,(VALTYP)
__DATA_5:
  LD DE,DBL_FPREG
  CP $05
  JP C,__DATA_6
  LD DE,$FB24
__DATA_6:
  PUSH HL
  CP $03				; String ?
  JP NZ,LETNUM
  LD HL,(DBL_FPREG)		; Pointer to string entry
  PUSH HL				; Save it on stack
  INC HL				; Skip over length
  LD E,(HL)				; LSB of string address
  INC HL
  LD D,(HL)				; MSB of string address
  LD HL,BUFFER
  RST CPDEHL			; Compare HL with DE.. is string before program?
  JP C,$0D10
  LD HL,(ARREND)
  RST CPDEHL			; Compare HL with DE.. is string literal in program?
  POP DE
  JP NC,MVSTPT			; Yes - Set up pointer
  LD HL,VARIABLES+15	; .. on MSX it is = VARIABLES+14
  RST CPDEHL
  JP C,__DATA_7
  LD HL,VARIABLES-15	; .. on MSX it is = VARIABLES-16
  RST CPDEHL
  JP C,MVSTPT
  
__DATA_7:
  ;LD A,$D1
  DEFB $3E  ; "LD A,n" to Mask the next byte
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
  

__ON:
  CP $A6		; TK_ERROR
  JP NZ,ON_OTHER

ON_ERROR:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADC A,C			; DEFB TK_GOTO
  
  CALL LNUM_PARM_0
  LD A,D
  OR E
  JP Z,__ON_0
  CALL PHL_FIND_LINE		; Sink HL in stack and get first line number
  LD D,B
  LD E,C
  POP HL
  JP NC,ULERR			; Error: "Undefined line number"
__ON_0:
  EX DE,HL
  LD (ONELIN),HL
  EX DE,HL
  RET C
  LD A,(ONEFLG)		  ; =1 if executing an error trap routine
  OR A
  LD A,E
  RET Z
  LD A,(ERR_CODE)
  LD E,A
  JP ERROR_2
  
ON_OTHER:
  CALL ONGO
  JP C,__DATA_14
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADC A,L
  XOR A
__DATA_12:
  POP BC
  PUSH BC
  CP C
  JP NC,SNERR
  PUSH AF
  CALL LNUM_PARM_0
  LD A,D
  OR E
  JP Z,__DATA_13
  CALL PHL_FIND_LINE
  LD D,B
  LD E,C
  POP HL
  JP NC,ULERR			; Error: "Undefined line number"

__DATA_13:
  POP AF
  POP BC
  PUSH AF
  ADD A,B
  PUSH BC
  CALL GETWORD_127
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
  JP __DATA_12
  
__DATA_14:
  CALL GETINT
  LD A,(HL)
  LD B,A
  CP $8D			; TK_GOSUB
  JP Z,__DATA_15
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADC A,C			; DEFB TK_GOTO
  DEC HL
  
__DATA_15:
  LD C,E
__DATA_16:
  DEC C
  LD A,B
  JP Z,__FOR_10
  CALL LNUM_PARM_1:
  CP ','
  RET NZ
  JP __DATA_16
  
__RESUME:
  LD A,(ONEFLG)
  OR A
  JP NZ,__DATA_17
  LD (ONELIN),A
  LD ($FAD9),A
  JP $057A
__DATA_17:
  INC A
  LD (ERR_CODE),A
  LD A,(HL)
  CP $83
  JP Z,__DATA_18
  CALL LNUM_PARM_0
  RET NZ
  LD A,D
  OR E
  JP Z,__DATA_19
  CALL __GO_TO_0
  XOR A
  LD (ONEFLG),A
  RET
  
__DATA_18:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET NZ
  JP __DATA_20
  
__DATA_19:
  XOR A
  LD (ONEFLG),A
  INC A
__DATA_20:
  LD HL,(ERRTXT)
  EX DE,HL
  LD HL,(ERRLIN)
  LD (CURLIN),HL
  EX DE,HL
  RET NZ
  LD A,(HL)
  OR A
  JP NZ,__DATA_21
  INC HL
  INC HL
  INC HL
  INC HL
__DATA_21:
  INC HL
  XOR A
  LD (ONEFLG),A
  JP __DATA
__ERROR:
  CALL GETINT
  RET NZ
  OR A
  JP Z,FCERR
  JP ERROR
  
__IF:
  CALL $1091
  LD A,(HL)
  CP ','
  CALL Z,_CHRGTB
  CP $89			; TK_GOTO
  JP Z,__DATA_22
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  RET C				; TK_THEN
  DEC HL
__DATA_22:
  PUSH HL
  CALL _TSTSGN
  POP HL
  JP Z,__DATA_24
__DATA_23:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
  CP $0E			; Line number prefix
  JP Z,__GO TO
  CP $0D	;
  JP NZ,__FOR_10
  LD HL,(CONLO)
  RET
  
__DATA_24:
  LD D,$01
__DATA_25:
  CALL __DATA
  OR A
  RET Z
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $A1		; TK_ELSE
  JP NZ,__DATA_25
  DEC D
  JP NZ,__DATA_25
  JP __DATA_23
  
__LPRINT:
  LD A,$01
  LD (PRTFLG),A
  JP __DATA_26

__PRINT:
  LD C,$02
  CALL SCPTLP_102
__DATA_26:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL Z,OUTDO_CRLF
__DATA_27:
  JP Z,FINPRT
  CP $E2			; TK_USING
  JP Z,USING
  CP $D9			; TK_TAB(
  JP Z,__DATA_36
  PUSH HL
  CP ','		; TAB(
  JP Z,__DATA_32
  CP ';'
  JP Z,__DATA_41
  POP BC
  CALL $1091
  PUSH HL
  RST GETYPR 		; Get the number type (FAC)
  JP Z,__DATA_31
  CALL FOUT
  CALL CRTST
  LD (HL),' '
  LD HL,(DBL_FPREG)
  INC (HL)
  CALL ISFLIO
  JP NZ,__DATA_30
  LD HL,(DBL_FPREG)
  LD A,(PRTFLG)
  OR A
  JP Z,__DATA_28
  LD A,(LPT_POS)
  ADD A,(HL)
  CP $FF
  JP __DATA_29
__DATA_28:
  LD A,(ACTV_Y)
  LD B,A
  INC A
  JP Z,__DATA_30
  LD A,(TTYPOS)
  ADD A,(HL)
  DEC A
  CP B
__DATA_29:
  JP C,__DATA_30
  CALL Z,SCPTLP_46
  CALL NZ,OUTDO_CRLF
__DATA_30:
  CALL PRS1
  OR A
__DATA_31:
  CALL Z,PRS1
  POP HL
  JP __DATA_26
  
; TAB(
__DATA_32:
  LD BC,$0008
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL ISFLIO
  LD A,(HL)
  JP NZ,__DATA_35
  LD A,(PRTFLG)
  OR A
  JP Z,__DATA_33
  LD A,(LPT_POS)
  CP $EE
  JP __DATA_34
  
__DATA_33:
  LD A,($F457)
  LD B,A
  LD A,(TTYPOS)
  CP B
__DATA_34:
  CALL NC,OUTDO_CRLF
  JP NC,__DATA_41
__DATA_35:
  SUB $0E
  JP NC,__DATA_35
  CPL
  JP __DATA_39

__DATA_36:
  CALL FNDNUM
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  DEC HL
  PUSH HL
  JP Z,__DATA_38
  LD BC,SYNCHR
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL ISFLIO
  LD A,(HL)
  JP NZ,__DATA_38
  LD A,(PRTFLG)
  OR A
  JP Z,__DATA_37
  LD A,(LPT_POS)
  JP __DATA_38
  
__DATA_37:
  LD A,(TTYPOS)
__DATA_38:
  CPL
  ADD A,E
  JP NC,__DATA_41
__DATA_39:
  INC A
  LD B,A
  LD A,' '
__DATA_40:
  RST OUTC
  DEC B
  JP NZ,__DATA_40
  
__DATA_41:
  POP HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __DATA_27

; This entry point is used by the routines at CHKSTK and SCPTLP.
FINPRT:
  XOR A
  LD (PRTFLG),A
  PUSH HL
  LD H,A
  LD L,A
  LD (PTRFIL),HL			; Redirect I/O
  POP HL
  RET

__LINE:
  CP $85
  JP NZ,GETWORD_140
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '#'
  JP Z,SCPTLP_106
  CALL __DATA_45
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  PUSH HL
  CALL ERAEOL3
  POP DE
  POP BC
  JP C,$4103
  PUSH BC
  PUSH DE
  LD B,$00
  CALL QTSTR_0
  POP HL
  LD A,$03
  JP __DATA_3
  CCF
  LD D,D
  LD H,L
  LD H,H
  LD L,A
  JR NZ,$0FCA
  LD (HL),D
  LD L,A
  LD L,L
  JR NZ,$0FDC
  LD (HL),H
  LD H,C
  LD (HL),D
  LD (HL),H
  DEC C
  LD A,(BC)
  NOP

__DATA_43:
  LD A,(FLGINP)
  OR A
  JP NZ,DATSNR
  POP BC
  LD HL,$0F5D
  CALL PRS
  LD HL,(SAVTXT)
  RET

__DATA_44:
  CALL SCPTLP_101
  PUSH HL
  LD HL,BUFMIN
  JP __DATA_46

__TANUT:
  CP '#'
  JP Z,__DATA_44
  LD BC,$0FA5
  PUSH BC
__DATA_45:
  CP '"'
  LD A,$00
  RET NZ
  CALL QTSTR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEC SP
  PUSH HL
  CALL PRS1
  POP HL
  RET

  PUSH HL
  CALL ERAEOL2
  POP BC
  JP C,$4103
  INC HL
  LD A,(HL)
  OR A
  DEC HL
  PUSH BC
  JP Z,$0C8B
__DATA_46:
  LD (HL),$2C
  JP $0FBF
  
__READ:
  PUSH HL
  LD HL,($FAEB)
  OR $AF
  LD (FLGINP),A
  EX (SP),HL
  JP __DATA_48
  
__DATA_47:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
__DATA_48:
  CALL GETVAR
  EX (SP),HL
  PUSH DE
  LD A,(HL)
  CP ','
  JP Z,__DATA_49
  LD A,(FLGINP)
  OR A
  JP NZ,FDTLP
  LD A,$3F
  RST OUTC
  CALL ERAEOL2
  POP DE
  POP BC
  JP C,$4103
  INC HL
  LD A,(HL)
  DEC HL
  OR A
  PUSH BC
  JP Z,$0C8B
  PUSH DE
; This entry point is used by the routine at FDTLP.
__DATA_49:
  CALL ISFLIO
  JP NZ,SCPTLP_105
  RST GETYPR 		; Get the number type (FAC)
  PUSH AF
  JP NZ,__DATA_52
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD D,A
  LD B,A
  CP '"'
  JP Z,__DATA_51
  LD A,(FLGINP)
  OR A
  LD D,A
  JP Z,__DATA_50
  LD D,$3A
__DATA_50:
  LD B,$2C
  DEC HL
__DATA_51:
  CALL DTSTR
  POP AF
  ADD A,$03
  EX DE,HL
  LD HL,$102B
  EX (SP),HL
  PUSH DE
  JP __DATA_4
__DATA_52:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH AF
  LD BC,$1012
  PUSH BC
  JP C,DBL_ASCTFP
  JP DBL_DBL_ASCTFP
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,__DATA_53
  CP ','
  JP NZ,__DATA_43
__DATA_53:
  EX (SP),HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,__DATA_47
  POP DE
  LD A,(FLGINP)
  OR A
  EX DE,HL
  JP NZ,RUN_FST7
  PUSH DE
  CALL ISFLIO
  JP NZ,__DATA_54
  LD A,(HL)
  OR A
  LD HL,$1057
  CALL NZ,PRS
__DATA_54:
  POP HL
  JP FINPRT
  CCF
  LD B,L
  LD A,B
  LD (HL),H
  LD (HL),D
  LD H,C
  JR NZ,EVAL4_1
  LD H,A
  LD L,(HL)
  LD L,A
  LD (HL),D
  LD H,L
  LD H,H
  DEC C
  LD A,(BC)
  NOP

; Find next DATA statement
;
; Used by the routine at __DATA.
FDTLP:
  CALL __DATA
  OR A
  JP NZ,FDTLP_0
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  LD E,$04
  JP Z,ERROR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (DATLIN),HL
  EX DE,HL
FDTLP_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $84
  JP NZ,FDTLP
  JP __DATA_49
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  POP AF
  JP $1091

; Chk Syntax, make sure '(' follows
;
; Used by the routines at OPRND, UCASE and MIDNUM.
OPNPAR:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  JR Z,$10BD

; (a.k.a. GETNUM, evaluate expression (GETNUM)
;
; Used by the routines at __FOR and SCPTLP.
EVAL:
  LD D,$00
; This entry point is used by the routines at EVAL4, OPRND and UCASE.
EVAL1:
  PUSH DE

; Save precedence and eval until precedence break
EVAL2:
  LD C,$01
  CALL CHKSTK
  CALL OPRND
  LD (TEMP2),HL
; This entry point is used by the routine at UCASE.
EVAL3:
  LD HL,(TEMP2)

; Evaluate expression until precedence break
EVAL4:
  POP BC
  LD A,(HL)
  LD (TEMP3),HL
  CP $F0		; TK_GREATER	; Token for '>'
  RET C
  CP $F3		; TK_PLUS, '+'
  JP C,EVAL4_5
  SUB $F3
  LD E,A
  JP NZ,EVAL4_0
  LD A,(VALTYP)
  CP $03
  LD A,E
  JP Z,CONCAT
EVAL4_0:
  CP $0C
  RET NC
  LD HL,PRITAB
  LD D,$00
  ADD HL,DE
; This entry point is used by the routine at __DATA.
EVAL4_1:
  LD A,B
  LD D,(HL)
  CP D
  RET NC
  PUSH BC
  LD BC,EVAL3
  PUSH BC
  LD A,D
  CP $7F
  JP Z,EVAL4_7
  CP $51
  JP C,EVAL4_8
  AND $FE
  CP $7A
  JP Z,EVAL4_8
EVAL4_2:
  LD HL,DBL_FPREG
  LD A,(VALTYP)
  SUB $03
  JP Z,TMERR
  OR A
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  JP M,EVAL4_3
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  JP PO,EVAL4_3
  LD HL,$FB24
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
EVAL4_3:
  ADD A,$03
  LD C,E
  LD B,A
  PUSH BC
  LD BC,$116A
EVAL4_4:
  PUSH BC
  LD HL,(TEMP3)
  JP EVAL1
  
EVAL4_5:
  LD D,$00
EVAL4_6:
  SUB $F0
  JP C,NO_COMPARE_TK
  CP $03
  JP NC,NO_COMPARE_TK
  CP $01
  RLA
  XOR D
  CP D
  LD D,A
  JP C,SNERR
  LD (TEMP3),HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP EVAL4_6
  
EVAL4_7:
  CALL __CSNG
  CALL STAKI
  LD BC,POWER
  LD D,$7F
  JP EVAL4_4
  
EVAL4_8:
  PUSH DE
  CALL __CINT
  POP DE
  PUSH HL
  LD BC,L1341
  JP EVAL4_4
  
NO_COMPARE_TK:
  LD A,B
  CP $64
  RET NC
  PUSH BC
  PUSH DE
  LD DE,GET_DEVICE_242
  LD HL,$1316
  PUSH HL
  RST GETYPR 		; Get the number type (FAC)
  JP NZ,EVAL4_2
  LD HL,(DBL_FPREG)
  PUSH HL
  LD BC,$2ACD
  JP EVAL4_4
  
  POP BC
  LD A,C
  LD (DORES),A
  LD A,(VALTYP)
  CP B
  JP NZ,EVAL4_10
  CP $02
  JP Z,EVAL4_11
  CP $04
  JP Z,EVAL4_19
  JP NC,EVAL4_13
EVAL4_10:
  LD D,A
  LD A,B
  CP $08
  JP Z,EVAL4_12
  LD A,D
  CP $08
  JP Z,EVAL4_17
  LD A,B
  CP $04
  JP Z,EVAL4_18
  LD A,D
  CP $03
  JP Z,TMERR
  JP NC,EVAL4_21
EVAL4_11:
  LD HL,INT_OPR
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP DE
  LD HL,(DBL_FPREG)
  PUSH BC
  RET
  
EVAL4_12:
  CALL __CDBL
EVAL4_13:
  CALL FP_ARG2HL
  POP HL
  LD ($FB26),HL
  POP HL
  LD ($FB24),HL
EVAL4_14:
  POP BC
  POP DE
  CALL FPBCDE
EVAL4_15:
  CALL __CDBL
  LD HL,DEC_OPR
EVAL4_16:
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
EVAL4_17:
  LD A,B
  PUSH AF
  CALL FP_ARG2HL
  POP AF
  LD (VALTYP),A
  CP $04
  JP Z,EVAL4_14
  POP HL
  LD (DBL_FPREG),HL
  JP EVAL4_15

EVAL4_18:
  CALL __CSNG
EVAL4_19:
  POP BC
  POP DE
EVAL4_20:
  LD HL,FLT_OPR
  JP EVAL4_16
EVAL4_21:
  POP HL
  CALL STAKI
  CALL HL_CSNG
  CALL BCDEFP
  POP HL
  LD (LAST_FPREG),HL
  POP HL
  LD (DBL_FPREG),HL
  JP EVAL4_20

; Routine at 4619
IDIV:
  PUSH HL
  EX DE,HL
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  JP DIV

; Get next expression value
;
; Used by the routines at EVAL1 and CONCAT.
OPRND:
  CALL GET_DEVICE_703
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,$0580		; OPERAND_ERR (OPRND)
  JP C,DBL_ASCTFP
  CALL IS_ALPHA_A
  JP NC,VAR_EVAL
  CP ' '
  JP C,__FOR_18
  INC A
  JP Z,OPRND_SUB
  DEC A
  CP $F3		; TK_PLUS, '+'
  JP Z,OPRND
  CP $F4		; TK_MINUS, '-'
  JP Z,OPRND_SUB
  CP '"'
  JP Z,QTSTR
  CP $DE
  JP Z,NOT
  CP $E0		; TK_ERR
  JP NZ,OPRND_0
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,(ERR_CODE)
  PUSH HL
  CALL UNSIGNED_RESULT_A
  POP HL
  RET

OPRND_0:
  CP $DF		; TK_ERL
  JP NZ,OPRND_1

__ERL:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,(ERRLIN)
  CALL DBL_ABS_0
  POP HL
  RET
  
OPRND_1:
  CP $EA			; TK_TIME
  JP Z,FN_TIME
  CP $EB			; TK_DATE
  JP Z,FN_DATE
  CP $EE			; TK_STATUS
  JP Z,FN_STATUS
  CP $E3			; TK_INSTR
  JP Z,FN_INSTR
  CP $E9			; TK_INKEY_S
  JP Z,FN_INKEY
  CP $E1
  JP Z,TOPOOL_0
  CP $85
  JP Z,SCPTLP_88
  CP $E6
  JP Z,GETWORD_147
  CP $E8
  JP Z,USING5

; This entry point is used by the routine at UCASE.
OPRND_2:
  CALL OPNPAR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  RET

OPRND_SUB:
  LD D,$7D
  CALL EVAL1
  LD HL,(TEMP2)		; NXTOPR,  Next operator in EVAL
  PUSH HL
  CALL INVSGN

; Routine at 4773
_POPHLRT:
  POP HL
  RET
  
VAR_EVAL:
  CALL GETVAR
  PUSH HL
  EX DE,HL
  LD (DBL_FPREG),HL
  RST GETYPR 		; Get the number type (FAC)
  CALL NZ,FP_HL2DE	; CALL if not string type
  POP HL
  RET

; Get char from (HL) and make upper case
;
; Used by the routines at SNERR, DETOKEN_MORE, GETWORD, SCPTLP and GET_DEVICE.
UCASE_HL:
  LD A,(HL)

; Make char in 'A' upper case
;
; Used by the routine at GET_DEVICE.
UCASE:
  CP $61
  RET C
  CP $7B
  RET NC
  AND $5F
  RET
; This entry point is used by the routine at OPRND.
OPRND_SUB:
  INC HL
  LD A,(HL)
  SUB $81
  LD B,$00
  RLCA
  LD C,A
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,C
  CP $05
  JP NC,OPRND_3_0
  CALL OPNPAR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL TSTSTR
  EX DE,HL
  LD HL,(DBL_FPREG)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  CALL GETINT
  EX DE,HL
  EX (SP),HL
  JP UCASE_3
  
OPRND_3_0:
  CALL OPRND_2
  EX (SP),HL
  LD A,L
  CP $0C
  JP C,OPRND_3_1
  CP $1B
  PUSH HL
  CALL C,__CSNG
  POP HL
OPRND_3_1:
  LD DE,_POPHLRT		; (POP HL / RET)
  PUSH DE
UCASE_3:
  LD B,H
  LD C,L
  LD HL,(FNCTAB_FN)			; FNCTAB_FN
UCASE_4:
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  JP (HL)
  
; This entry point is used by the routine at _DBL_ASCTFP.
UCASE_5:
  DEC D
  CP $F4		; TK_MINUS, '-'
  RET Z
  CP '-'
  RET Z
  INC D
  CP '+'
  RET Z
  CP $F3		; TK_PLUS, '+'
  RET Z

DCXH:
  DEC HL
  RET

  INC A
  ADC A,A
  POP BC
  AND B
  ADD A,$FF
  SBC A,A
  CALL INT_RESULT_A
  JP NOT_0
  
; This entry point is used by the routine at OPRND.
NOT:
  LD D,$5A
  CALL EVAL1
  CALL __CINT
  LD A,L
  CPL
  LD L,A
  LD A,H
  CPL
  LD H,A
  LD (DBL_FPREG),HL
  POP BC
NOT_0:
  JP EVAL3
  
; This entry point is used by the routine at GETYPR.
__GETYPR:
  LD A,(VALTYP)
  CP $08
  DEC A
  DEC A
  DEC A
  RET

L1341:
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
  JP NZ,SKIP_OR
  
OR:
  LD A,E
  OR L
  LD L,A
  LD A,H
  OR D
  RET
  
SKIP_OR:
  CP $50		; AND as mapped in PRITAB
  JP NZ,SKIP_AND
  
AND:
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET
  
SKIP_AND:
  CP $3C		; XOR as mapped in PRITAB
  JP NZ,SKIP_XOR
  
XOR:
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET

SKIP_XOR:
  CP $32		; EQU (=) as mapped in PRITAB
  JP NZ,IMP

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
  
; This entry point is used by the routine at MIDNUM.
IMP:
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP DBL_ABS_0
  
__LPOS:
  LD A,(LPT_POS)
  JP UNSIGNED_RESULT_A
  
__POS:
  LD A,(TTYPOS)
; This entry point is used by the routines at OPRND, MAKINT and TOPOOL.
UNSIGNED_RESULT_A:
  LD L,A
  XOR A

BOOL_RESULT:
  LD H,A
  JP INT_RESULT_HL
  
; This entry point is used by the routine at __DATA.
OPRND_3_05:
  PUSH HL
  AND $07
  LD HL,TYPE_OPR
  LD C,A
  LD B,$00
  ADD HL,BC
  CALL UCASE_4
  POP HL
  RET
  
__INP:
  CALL MAKINT
  LD (INPORT),A
  CALL GET_DEVICE_713
  JP UNSIGNED_RESULT_A
  
__OUT:
  CALL GTIO_PARMS		; Get "WORD,BYTE" paramenters
  JP GET_DEVICE_711

; Get subscript
;
; Used by the routine at __FOR.
FPSINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
; This entry point is used by the routine at __FOR.
FPSINT_0:
  CALL $1091

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
  
; This entry point is used by the routine at UCASE.
GTIO_PARMS:
  CALL GETINT
  LD (INPORT),A
  LD (OTPORT),A
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JP GETINT

; Load 'A' with the next number in BASIC program
;
; Used by the routines at __DATA and SCPTLP.
FNDNUM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

; Get a number to 'A'
;
; Used by the routines at __DATA, UCASE, DEPINT, MAKINT, GETWORD, TOPOOL,
; SCPTLP and GET_DEVICE.
GETINT:
  CALL $1091

; Convert tmp string to int in A register
;
; Used by the routines at UCASE, GSTRDE, TOPOOL, MIDNUM and SCPTLP.
MAKINT:
  CALL DEPINT
  JP NZ,FCERR
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,E
  RET

__LLIST:
  LD A,$01
  LD (PRTFLG),A

; This entry point is used by the routines at SCPTLP and GET_DEVICE.
__LIST:
  POP BC
  CALL LNUM_RANGE
  PUSH BC
  LD H,B
  LD L,C
  LD (LBLIST),HL
MAKINT_0:
  LD HL,$FFFF
  LD (CURLIN),HL
  POP HL
  LD ($F9AC),HL
  POP DE
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,B
  OR C
  JP Z,MAKINT_3
  LD A,($F9BA)
  AND A
  CALL Z,ISFLIO
  CALL Z,GETWORD_37
  PUSH BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  EX (SP),HL
  EX DE,HL
  RST CPDEHL
  POP BC
  JP C,MAKINT_2
  EX (SP),HL
  PUSH HL
  PUSH BC
  EX DE,HL
  LD (DOT),HL
  CALL NUMPRT
  POP HL
  LD A,(HL)
  CP $09
  JP Z,MAKINT_1
  LD A,' '
  RST OUTC
MAKINT_1:
  CALL MAKINT_5
  LD HL,$F5A1
  CALL MAKINT_4
  CALL OUTDO_CRLF
  JP MAKINT_0
MAKINT_2:
  POP BC
MAKINT_3:
  LD A,($F3FD)
  AND A
  JP NZ,GET_DEVICE_200
  LD A,$1A
  RST OUTC
  LD A,($F9BA)
  AND A
  JP NZ,GET_DEVICE_100
  JP READY
MAKINT_4:
  LD A,(HL)
  OR A
  RET Z
  RST OUTC
  INC HL
  JP MAKINT_4
MAKINT_5:
  LD BC,$F5A1
  LD D,$FF
  XOR A
  LD (DORES),A
  JP MAKINT_7
MAKINT_6:
  INC BC
  INC HL
  DEC D
  RET Z
MAKINT_7:
  LD A,(HL)
  OR A
  LD (BC),A
  RET Z
  CP $0B
  JP C,MAKINT_10
  CP ' '
  JP C,MAKINT_25
  CP '"'
  JP NZ,MAKINT_8
  LD A,(DORES)
  XOR $01
  LD (DORES),A
  LD A,$22
MAKINT_8:
  CP $3A
  JP NZ,MAKINT_10
  LD A,(DORES)
  RRA
  JP C,MAKINT_9
  RLA
  AND $FD
  LD (DORES),A
MAKINT_9:
  LD A,$3A
MAKINT_10:
  OR A
  JP P,MAKINT_6
  LD A,(DORES)
  RRA
  JP C,MAKINT_11
  RRA
  RRA
  JP NC,DETOKEN
  LD A,(HL)
  CP $E4
  PUSH HL
  PUSH BC
  LD HL,$14E3
  PUSH HL
  RET NZ
  DEC BC
  LD A,(BC)
  CP $4D
  RET NZ
  DEC BC
  LD A,(BC)
  CP 'E'
  RET NZ
  DEC BC
  LD A,(BC)
  CP $52
  RET NZ
  DEC BC
  LD A,(BC)
  CP $3A
  RET NZ
  POP AF
  POP AF
  POP HL
  INC D
  INC D
  INC D
  INC D
  JP MAKINT_16
  POP BC
  POP HL
  LD A,(HL)
MAKINT_11:
  JP MAKINT_6
MAKINT_12:
  LD A,(DORES)
  OR $02
MAKINT_13:
  LD (DORES),A
  XOR A
  RET
MAKINT_14:
  LD A,(DORES)
  OR $04
  JP MAKINT_13
  
DETOKEN:
  RLA
  JP C,MAKINT_11
  LD A,(HL)
  CP $84		; TK_DATA
  CALL Z,MAKINT_12
  CP $8F		; TK_REM
  CALL Z,MAKINT_14
MAKINT_16:
  LD A,(HL)
  INC A
  LD A,(HL)
  JP NZ,MAKINT_17
  INC HL
  LD A,(HL)
  AND $7F
MAKINT_17:
  INC HL
  CP $A1		; TK_ELSE
  JP NZ,MAKINT_18
  DEC BC
  INC D
MAKINT_18:
  PUSH HL
  PUSH BC
  PUSH DE
  LD HL,WORDS-1
  LD B,A
  LD C,$40
DETOKEN_2:
  INC C
  LD A,C
  CP $5C  	;'\'
  JP NC,DETOKEN_7
DETOKEN_3:
  INC HL
  LD D,H
  LD E,L
DETOKEN_4:
  LD A,(HL)
  OR A
  JP Z,DETOKEN_2
  INC HL
  JP P,DETOKEN_4
  LD A,(HL)
  CP B
  JP NZ,DETOKEN_3
  EX DE,HL
  LD A,C
  POP DE
  POP BC
  CP $5B
  JP NZ,DETOKEN_6
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
  JP MAKINT_7
  
DETOKEN_7:
  POP DE
  POP BC
  LD HL,$1561
  JP DETOKEN_5
  
  
  LD HL,($4350)
  XOR D
MAKINT_25:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH DE
  PUSH BC
  PUSH AF
  CALL __FOR_23
  POP AF
  LD HL,(CONLO)
  CALL FOUT
  POP BC
  POP DE
  LD A,(CONTYP)
  CP $04
  LD E,$00
  JP C,MAKINT_26
  LD E,$21
  JP Z,MAKINT_26
  LD E,$23
MAKINT_26:
  LD A,(HL)
  CP ' '
  CALL Z,INCHL
MAKINT_27:
  LD A,(HL)
  INC HL
  OR A
  JP Z,MAKINT_30
  LD (BC),A
  INC BC
  DEC D
  RET Z
  LD A,(CONTYP)
  CP $04
  JP C,MAKINT_27
  DEC BC
  LD A,(BC)
  INC BC
  JP NZ,MAKINT_28
  CP '.'
  JP Z,MAKINT_29
MAKINT_28:
  CP 'D'			; 'D'
  JP Z,MAKINT_29
  CP 'E'			; 'E'
  JP NZ,MAKINT_27
MAKINT_29:
  LD E,$00
  JP MAKINT_27
  
MAKINT_30:
  LD A,E
  OR A
  JP Z,MAKINT_31
  LD (BC),A
  INC BC
  DEC D
  RET Z
MAKINT_31:
  LD HL,(CONTXT)
  JP MAKINT_7
  
; This entry point is used by the routine at SNERR.
MAKINT_32:
  EX DE,HL
  LD HL,(PROGND)
MAKINT_33:
  LD A,(DE)
  LD (BC),A
  INC BC
  INC DE
  RST CPDEHL
  JP NZ,MAKINT_33
  LD H,B
  LD L,C
  LD (PROGND),HL
  LD (VAREND),HL
  LD (ARREND),HL
  RET

__PEEK:
  CALL GETWORD_HL
  LD A,(HL)
  JP UNSIGNED_RESULT_A

__POKE:
  CALL GETWORD
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  POP DE
  LD (DE),A
  RET

; Get a number to DE (0..65535)
;
; Used by the routines at MAKINT and CHKSTK.
GETWORD:
  CALL $1091
  PUSH HL
  CALL GETWORD_HL
  EX DE,HL
  POP HL
  RET

; This entry point is used by the routine at MAKINT.
GETWORD_HL:
  LD BC,__CINT
  PUSH BC
  RST GETYPR 		; Get the number type (FAC)
  RET M
  LD A,(FACCU)
  CP $90
  RET NZ
  RST TSTSGN
  RET M
  CALL __CSNG
  LD BC,$9180
  LD DE,$0000
  JP FADD
  
__RENUM:
  LD BC,$000A
  PUSH BC
  LD D,B
  LD E,B
  JP Z,GETWORD_2
  CP ','
  JP Z,GETWORD_1
  PUSH DE
  CALL __FOR_33
  LD B,D
  LD C,E
  POP DE
  JP Z,GETWORD_2

GETWORD_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL __FOR_33
  JP Z,GETWORD_2
  POP AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH DE
  CALL LNUM_PARM_0
  JP NZ,SNERR
  LD A,D
  OR E
  JP Z,FCERR
  EX DE,HL
  EX (SP),HL
  EX DE,HL
GETWORD_2:
  PUSH BC
  CALL FIRST_LNUM
  POP DE
  PUSH DE
  PUSH BC
  CALL FIRST_LNUM
  LD H,B
  LD L,C
  POP DE
  RST CPDEHL
  EX DE,HL
  JP C,FCERR
  POP DE
  POP BC
  POP AF
  PUSH HL
  PUSH DE
  JP GETWORD_4
GETWORD_3:
  ADD HL,BC
  JP C,FCERR
  EX DE,HL
  PUSH HL
  LD HL,$FFF9
  RST CPDEHL
  POP HL
  JP C,FCERR
GETWORD_4:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  EX DE,HL
  POP DE
  JP Z,GETWORD_5
  LD A,(HL)
  INC HL
  OR (HL)
  DEC HL
  EX DE,HL
  JP NZ,GETWORD_3
GETWORD_5:
  PUSH BC
  CALL $16A7
  POP BC
  POP DE
  POP HL
GETWORD_6:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  JP Z,GETWORD_7
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
  JP GETWORD_6

GETWORD_7:
  LD BC,RESTART
  PUSH BC
  CP $F6
; This entry point is used by the routine at GET_DEVICE.
GETPARM_VRFY:
  XOR A
  LD (PTRFLG),A
  LD HL,(BASTXT)
  DEC HL
GETWORD_9:
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  RET Z
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
GETWORD_10:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

LINE2PTR:
  OR A
  JP Z,GETWORD_9
  LD C,A
  LD A,(PTRFLG)
  OR A
  LD A,C
  JP Z,GETWORD_16
  CP $A6			; TK_ERROR
  JP NZ,GETWORD_12
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $89			; TK_GOTO
  
  JP NZ,LINE2PTR
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $0E			; Line number prefix
  
  JP NZ,LINE2PTR
  PUSH DE
  CALL __FOR_36
  LD A,D
  OR E
  JP NZ,GETWORD_13
  JP GETWORD_14
  
GETWORD_12:
  CP $0E			; Line number prefix
  JP NZ,GETWORD_10
  PUSH DE
  CALL __FOR_36
GETWORD_13:
  PUSH HL
  CALL FIRST_LNUM
  DEC BC
  LD A,$0D
  JP C,GETWORD_17
  CALL CONSOLE_CRLF
  LD HL,$1712
  PUSH DE
  CALL PRS
  POP HL
  CALL NUMPRT
  POP BC
  POP HL
  PUSH HL
  PUSH BC
  CALL LNUM_MSG
  POP HL
GETWORD_14:
  POP DE
  DEC HL
GETWORD_15:
  JP GETWORD_10
  LD D,L
  LD L,(HL)
  LD H,H
  LD H,L
  LD H,(HL)
  LD L,C
  LD L,(HL)
  LD H,L
  LD H,H
  JR NZ,$1789
  LD L,C
  LD L,(HL)
  LD H,L
  JR NZ,GETWORD_16
GETWORD_16:
  CP $0D
  JP NZ,GETWORD_15
  PUSH DE
  CALL __FOR_36
  PUSH HL
  EX DE,HL
  INC HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD A,$0E
GETWORD_17:
  LD HL,$170C
  PUSH HL
  LD HL,(CONTXT)
; This entry point is used by the routine at __FOR.
GETWORD_18:
  PUSH HL
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC HL
  LD (HL),A
  POP HL
  RET
  
; This entry point is used by the routine at SNERR.
GETWORD_19:
  LD A,(PTRFLG)
  OR A
  RET Z
  JP GETPARM_VRFY
  
; This entry point is used by the routines at ISFLIO, SCPTLP and GET_DEVICE.
CHGET:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL GETWORD_21
  JP POPALL_0
GETWORD_21:
  RST $38
  INC B
  LD HL,($F3E0)
  INC H
  DEC H
  JP Z,GETWORD_24
  LD B,(HL)
  INC HL
  LD A,(HL)
  OR A
  JP NZ,GETWORD_22
  LD H,A
GETWORD_22:
  LD ($F3E0),HL
  LD A,B
  RET
GETWORD_23:
  LD A,(FNK_FLAG)
  ADD A,A
  RET C
  LD HL,$0000
  LD ($F3E2),HL
  LD A,$0D
  LD ($F98E),A
GETWORD_24:
  LD HL,($F3E2)
  LD A,L
  AND H
  INC A
  JP Z,GETWORD_26
  PUSH HL
  LD A,($F98E)
  CP $0D
  CALL Z,RESFPT_0
  LD HL,(HAYASHI)
  POP DE
  ADD HL,DE
  LD A,(HL)
  LD ($F98E),A
  LD B,A
  CP $1A		; EOF
  LD A,$00
  JP Z,GETWORD_25
  CALL GET_DEVICE_490
  JP C,GETWORD_25
  INC HL
  LD A,(HL)
  EX DE,HL
  INC HL
  LD ($F3E2),HL
  CP $1A		; EOF
  LD A,B
  SCF
  CCF
  RET NZ
GETWORD_25:
  LD HL,$FFFF
  LD ($F3E2),HL
  RET
GETWORD_26:
  CALL CHSNS
  JP NZ,GETWORD_28
  CALL GETWORD_33
  LD A,$FF
  LD ($F401),A
GETWORD_27:
  CALL CHSNS
  JP Z,GETWORD_27
  XOR A
  LD ($F401),A
  CALL GETWORD_34
GETWORD_28:
  LD HL,$F841
  LD A,(HL)
  AND A
  JP NZ,GETWORD_31
  CALL GETWORD_131
  CALL GET_DEVICE_485
  RET NC
  SUB $0A
  JP Z,GETWORD_23
  JP NC,GETWORD_32
  LD E,A
  LD A,(FNK_FLAG)
  AND $60
  SCF
  LD A,E
  RET NZ
  LD D,$FF
  EX DE,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$F745
  ADD HL,DE
  LD A,(FNK_FLAG)
  AND A
  JP P,GETWORD_29
  INC HL
  INC HL
  INC HL
  INC HL
GETWORD_29:
  LD ($F3E0),HL
  JP GETWORD_21
GETWORD_30:
  JP Z,ISFLIO_20
  JP ISFLIO_22
GETWORD_31:
  DI
  LD (HL),$00
  LD A,($F402)
  DEC HL
  LD (HL),A
  CALL GETWORD_41
GETWORD_32:
  XOR A
  RET
GETWORD_33:
  LD A,(CSR_STATUS)
  LD ($F9BE),A
  AND A
  RET NZ
  CALL ISFLIO_6
  JP ISFLIO_11
GETWORD_34:
  LD A,($F9BE)
  AND A
  RET NZ
  CALL ISFLIO_7
  JP ISFLIO_11
; This entry point is used by the routines at SCPTLP and GET_DEVICE.
CHSNS:
  LD A,($F3E1)
  AND A
  RET NZ
  LD A,($F841)
  AND A
; This entry point is used by the routine at GET_DEVICE.
GETWORD_36:
  RET NZ
  PUSH HL
  LD HL,($F3E2)
  LD A,L
  AND H
  INC A
  POP HL
  RET NZ
  RST $38
  LD B,$C3
  AND (HL)
  LD (HL),D
; This entry point is used by the routines at __FOR and MAKINT.
GETWORD_37:
  CALL GET_DEVICE_492
  RET Z
  CP $03
  JP Z,GETWORD_39
  CP $13
  RET NZ
  CALL GETWORD_33
GETWORD_38:
  CALL GET_DEVICE_492
  CP $11
  JP Z,GETWORD_34
  CP $03
  JP NZ,GETWORD_38
  CALL GETWORD_34
GETWORD_39:
  XOR A
  LD ($FE68),A
  JP __STOP
__POWER:
  SUB $99
  JP Z,GETWORD_43
  CP $4E
  JP NZ,GETWORD_44
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,GETWORD_42
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  AND A
  JP NZ,SNERR
  JP GETWORD_41
GETWORD_40:
  POP AF
  RET
  PUSH AF
  IN A,($D8)
  AND A
  JP M,GETWORD_40
  LD A,($F401)
  AND A
  LD A,$01
  LD ($F401),A
  JP NZ,GETWORD_42
  POP AF
GETWORD_41:
  DI
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,$0000
  ADD HL,SP
  LD ($F9AE),HL
  LD HL,$9C0B	; POWER ON data marker
  LD (ATIDSV),HL
GETWORD_42:
  DI
  CALL GETWORD_131
  IN A,($BA)
  OR $10
  OUT ($BA),A
  HALT
GETWORD_43:
  CALL GETWORD_45
  LD ($F841),A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET
GETWORD_44:
  CALL GETINT
  CP $0A
  JP C,FCERR
GETWORD_45:
  LD ($F402),A
  LD (TIMINT),A
  RET
; This entry point is used by the routine at SCPTLP.
LPT_OUT:
  RST $38
  INC C
  CALL GET_DEVICE_397
  PUSH AF
  CALL GETWORD_131
  POP AF
  RET NC
  XOR A
  LD (LPT_POS),A
  JP GETWORD_49
  
; Start tape and load tape header.  If an error or Shift Break pressed,
; generate I/O error
;
; Used by the routine at CAS_OPNI_CO.
HEADER:
  CALL GET_DEVICE_707
  CALL CTON
  CALL SYNCR
  RET NC
HEADER_0:
  CALL CTOFF
GETWORD_49:
  LD E,$18
  JP ERROR
  
GETWORD_50:
  CALL GET_DEVICE_706
  CALL CTON
  LD BC,$0000
GETWORD_51:
  DEC BC
  LD A,B
  OR C
  JP NZ,GETWORD_51
  JP GET_DEVICE_446
  
CTON:
  DI
  defb $11		; LD DE,NN to skip the next 2 bytes
; Cassette motor OFF
;
; Used by the routines at HEADER, CAS_INPUT, __CLOAD, LOAD_RECORD, CLOADM,
; LDIR_B, CAS_OPNO_CO and CAS_OPNI_CO.
CTOFF:
  EI
  LD E,$00
  JP DATAR_1
  
CASIN:
  CALL GET_DEVICE_704
  PUSH DE
  PUSH HL
  PUSH BC
  CALL DATAR
  JP C,HEADER_0
  LD D,A
  POP BC
  ADD A,C
  LD C,A
  LD A,D
  POP HL
  POP DE
  RET

CSOUT:
  CALL GET_DEVICE_705
  PUSH HL
  PUSH DE
  LD D,A
  ADD A,C
  LD C,A
  PUSH BC
  LD A,D
  CALL DATAW
  JP C,HEADER_0
  JP POPALL_0


; LCD Device control block
LCD_CTL:
  DEFW LCDLPT_OPN
  DEFW _CLOSE
  DEFW LCD_OUTPUT
  
;  LD C,B
;  ADD HL,DE
;  DEC B
;  LD C,A
;  LD D,L
;  ADD HL,DE


; LCD and LPT file open routine
LCDLPT_OPN:
  LD A,$02
  CP E
  JP NZ,NMERR			; NM error: bad file name
  
REDIRECT_IO:
  LD (PTRFIL),HL			; Redirect I/O
  LD (HL),E
  POP AF
  POP HL
  RET

; LCD file output routine
LCD_OUTPUT:
  POP AF
  PUSH AF
  CALL OUTC_SUB_0
LCD_OUTPUT_0:
  CALL GETWORD_131
  
; This entry point is used by the routines at ISFLIO and GET_DEVICE.
POPALL:
  POP AF
POPALL_0:
  POP BC
  POP DE
  POP HL
  RET



  
; CRT device control block?
; Data block at 6498
CRT_CTL:
  DEFW CRT_OPN
  DEFW _CLOSE
  DEFW CRT_OUTPUT
  DEFW L1970
  DEFW L1972

CRT_OPN:
  RST $38
  DEFB $62
  
CRT_OUTPUT:
  RST $38
  DEFB $66

L1970:
  RST $38
  DEFB $68

L1972:
  RST $38
  DEFB $6a


; Data block at 6516
RAM_CTL:
  DEFW RAM_OPN
  DEFW RAM_CLS
  DEFW RAM_OUTPUT
  DEFW RAM_INPUT
  DEFW RAM_IO
  


; RAM Device control block
RAM_CTL:
  DEFW RAM_OPN
  DEFW RAM_CLS
  DEFW RAM_OUTPUT
  DEFW RAM_INPUT
  DEFW RAM_IO


; Data block at 6516
RAM_CTL:
  DEFW L197E
  DEFW $1A05
  DEFW $1A24
  DEFW $1A3C
  DEFW $1A93
  
; RAM file open routine
RAM_OPN:
  PUSH HL
  PUSH DE
  INC HL
  INC HL
  PUSH HL
  LD A,E
  CP $01
  JP Z,GETWORD_62
  CP $08
  JP Z,GETWORD_63
RAM_OPN_0:
  CALL MAKTXT
  JP C,GETWORD_65
  PUSH DE
  CALL __EOF_3
  POP DE
GETWORD_60:
  LD BC,$0000
GETWORD_61:
  POP HL
  LD A,(DE)
  AND $02
  JP NZ,AOERR
  LD A,(DE)
  OR $02
  LD (DE),A
  INC DE
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  INC HL
  INC HL
  LD (HL),$00
  INC HL
  LD (HL),C
  INC HL
  LD (HL),B
  POP DE
  POP HL
  JP REDIRECT_IO
GETWORD_62:
  LD A,($F3FD)
  AND A
  LD HL,$F886
  CALL Z,FINDCO_0
  JP Z,FFERR
  EX DE,HL
  CALL GET_RAM_PTR
  XOR A
  LD (HL),A
  LD L,A
  LD H,A
  LD ($F9CA),HL
  JP GETWORD_60
GETWORD_63:
  POP HL
  POP DE
  LD E,$02
  PUSH DE
  PUSH HL
  CALL RESFPT_0
  CALL FINDCO_0
  JP Z,RAM_OPN_0
  LD E,L
  LD D,H
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD BC,$FFFF
GETWORD_64:
  LD A,(HL)
  INC HL
  INC BC
  CP $1A		; EOF
  JP NZ,GETWORD_64
  JP GETWORD_61
GETWORD_65:
  LD A,(DE)
  AND $02
  JP NZ,AOERR
  EX DE,HL
  CALL KILLASC+1 
  JP RAM_OPN_0

; Routine at 6661
RAM_CLS:
  PUSH HL
  CALL RAM_CLS_0
  POP HL
  CALL CLOSE_DEVICE
  CALL NZ,RAM_INPUT_2
  CALL GET_RAM_PTR
  LD (HL),$00
  JP _CLOSE
  
RAM_CLS_0:
  INC HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  DEC HL
  LD A,(HL)
  AND $FD
  LD (HL),A
  RET

; Routine at 6692
RAM_OUTPUT:
  POP AF
  PUSH AF
  LD BC,LCD_OUTPUT_0
  PUSH BC
  AND A
  RET Z
  CP $1A		; EOF
  RET Z
  CP $7F
  RET Z
  CALL INIT_DEV_OUTPUT
  RET NZ
  LD BC,$0100
  JP RAM_INPUT_2


; RAM file input routine
; Routine at 6716
RAM_INPUT:
  EX DE,HL
  CALL GET_RAM_PTR
  CALL GET_BYTE
  EX DE,HL
  CALL GETPARM_VRFY3
  JP NZ,RAM_INPUT_1
  EX DE,HL
  LD HL,($FB67)
  RST CPDEHL
  PUSH AF
  PUSH DE
  CALL NZ,RESFPT_0
  POP HL
  POP AF
  LD BC,$FFF9
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP NZ,RAM_INPUT_0
  PUSH DE
  EX DE,HL
  LD HL,($F9CA)
  EX DE,HL
  ADD HL,DE
  POP DE
RAM_INPUT_0:
  EX DE,HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC (HL)
  INC HL
  EX DE,HL
  ADD HL,BC
  LD B,$00
  CALL LDIR_B
  EX DE,HL
  DEC H
  XOR A
RAM_INPUT_1:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  CALL GET_RAM_PTR
  LD (HL),A
  SCF
  JP RDBYT_0

; Routine at 6803
RAM_IO:
  CALL GET_RAM_PTR
  JP DEV_IO_SUB

; This entry point is used by the routines at RAM_CLS and RAM_OUTPUT.
RAM_INPUT_2:
  PUSH HL
  PUSH BC
  PUSH HL
  EX DE,HL
  LD HL,($FB67)
  RST CPDEHL
  CALL NZ,RESFPT_0
  POP HL
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  EX DE,HL
  POP BC
  PUSH BC
  PUSH HL
  ADD HL,BC
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  LD BC,$FFFA			; -6
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  LD L,A
  INC DE
  LD A,(DE)
  LD H,A
  POP BC
  ADD HL,BC
  POP BC
  PUSH HL
  PUSH BC
  CALL GET_DEVICE_376
  CALL NC,__EOF_4
  POP BC
  POP DE
  POP HL
  JP C,RAM_INPUT_4
  PUSH HL
RAM_INPUT_3:
  LD A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,RAM_INPUT_3
  POP DE
  LD HL,($FB67)
  RST CPDEHL
  RET Z
  JP RESFPT_0

RAM_INPUT_4:
  LD BC,$FFF7				; -9
  ADD HL,BC
  LD (HL),$00
  CALL RAM_CLS_0
  JP OMERR

GET_RAM_PTR:
  PUSH DE
  LD HL,($F98F)
  LD DE,$F97E
  ADD HL,DE
  POP DE
  RET


; CAS Device control block
CAS_CTL:
  DEFW CAS_OPN
  DEFW CAS_CLS
  DEFW CAS_OUTPUT
  DEFW CAS_INPUT
  DEFW CAS_IO


; CAS file open routine
CAS_OPN:
  PUSH HL
  PUSH DE
  LD BC,$0006
  ADD HL,BC
  XOR A
  LD (HL),A
  LD (CASPRV),A
  LD A,E
  CP $08
  JP Z,NMERR			; NM error: bad file name
  CP $01
  JP Z,CAS_OPN_1
  CALL GETWORD_280
CAS_OPN_0:
  POP DE
  POP HL
  JP REDIRECT_IO

CAS_OPN_1:
  CALL $2A0F		; CAS_OPNI_DO
  JP CAS_OPN_0

; CAS file close routine
CAS_CLS:
  CALL CLOSE_DEVICE
  JP Z,CAS_CLS_1
  PUSH HL
  ADD HL,BC
CAS_CLS_0:
  LD (HL),$1A		; EOF
  INC HL
  INC C
  JP NZ,CAS_CLS_0
  POP HL
  CALL CAS_OUTPUT_0
CAS_CLS_1:
  XOR A
  LD (CASPRV),A
  JP _CLOSE
  

; CAS file output routine
CAS_OUTPUT:
  POP AF
  PUSH AF
  CALL INIT_DEV_OUTPUT
  CALL Z,CAS_OUTPUT_0
  JP LCD_OUTPUT_0

; CAS file input routine
CAS_INPUT:
  EX DE,HL
  LD HL,CASPRV
  CALL GET_BYTE
  EX DE,HL
  CALL GETPARM_VRFY3
  JP NZ,GETWORD_78
  PUSH HL
  CALL GETWORD_303
  POP HL
  LD BC,$0000
GETWORD_77:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC B
  JP NZ,GETWORD_77
  CALL CASIN
  LD A,C
  AND A
  JP NZ,HEADER_0
  CALL CTOFF
  DEC H
  XOR A
  LD B,A
GETWORD_78:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  LD (CASPRV),A
  SCF
  JP RDBYT_0
  LD HL,CASPRV
  JP DEV_IO_SUB
CAS_OUTPUT_0:
  PUSH HL
  CALL GETWORD_284
  POP HL
  LD BC,$0000
GETPARM_VRFY0:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC B
  JP NZ,GETPARM_VRFY0
  JP GETWORD_282
CLOSE_DEVICE:
  LD A,(HL)
  CP $01
  RET Z
  LD BC,$0006
  ADD HL,BC
  LD A,(HL)
  LD C,A
  LD (HL),$00
  JP GETPARM_VRFY4
INIT_DEV_OUTPUT:
  LD E,A
  LD BC,$0006
  ADD HL,BC
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
GETPARM_VRFY3:
  LD BC,$0006
  ADD HL,BC
  LD A,(HL)
  INC (HL)
GETPARM_VRFY4:
  INC HL
  INC HL
  INC HL
  AND A
  RET
  LD C,B
  ADD HL,DE
  DEC B
  LD C,A
  JP NC,GET_DEVICE_694
  PUSH AF
  CALL OUTC_TABEXP
  JP LCD_OUTPUT_0
  CALL PO,$011B
  INC E
  DEC E
  INC E
  JR Z,GETPARM_VRFY6
  LD B,A
  INC E
  RST $38
  LD C,(HL)
  PUSH HL
  PUSH DE
  LD HL,FILNAM
  CALL GETWORD_91
  POP DE
  LD A,E
  CP $08
  JP Z,NMERR			; NM error: bad file name
  SUB $01
  JP NZ,GETPARM_VRFY5
  LD (COMPRV),A
GETPARM_VRFY5:
  POP HL
GETPARM_VRFY6:
  JP REDIRECT_IO
  
GETPARM_VRFY7:
  RST $38
  LD D,B
  IN A,($D8)
  AND $10
  JP Z,GETPARM_VRFY7
  LD BC,__CLOSE_3
GETPARM_VRFY8:
  DEC BC
  LD A,B
  OR C
  JP NZ,GETPARM_VRFY8
  CALL GET_DEVICE_432
  XOR A
  LD (COMPRV),A
  JP _CLOSE

  POP AF
  PUSH AF
  CALL GET_DEVICE_415
  JP NC,LCD_OUTPUT_0
  JP GETWORD_49
  LD HL,COMPRV
  CALL GET_BYTE
  CALL RV232C
  JP C,GETWORD_49
  JP Z,GETPARM_VRFY9
  LD A,$82
GETPARM_VRFY9:
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  LD (COMPRV),A
  SCF
  JP RDBYT_0
  LD HL,COMPRV
DEV_IO_SUB:
  LD (HL),C
  JP SCPTLP_119
  
; This entry point is used by the routine at GET_DEVICE.
GETWORD_91:
  LD E,L
  LD D,H
  LD B,$06
GETWORD_92:
  LD A,(DE)
  CP ' '
  JP NZ,GETWORD_93
  INC DE
  DEC B
  JP NZ,GETWORD_92
  LD HL,$F406
GETWORD_93:
  LD BC,NMERR			; NM error: bad file name
  PUSH BC
  LD A,(HL)
  SUB $31
  CP $09
  RET NC
  INC A
  LD D,A
  INC HL
  CALL UCASE_HL
  LD B,A
  CP $49
  JP Z,GETWORD_94
  CP 'E'
  LD E,$02
  JP Z,GETWORD_95
  SUB $4E
GETWORD_94:
  LD E,$04
  JP Z,GETWORD_95
  DEC A
  RET NZ
  LD E,A
GETWORD_95:
  INC HL
  LD A,(HL)
  SUB $36
  CP $03
  RET NC
  INC A
  ADD A,A
  ADD A,A
  ADD A,A
  OR E
  LD E,A
  LD A,B
  CP $49
  JP NZ,$1CAC
  LD A,E
  AND $18
  CP $18
  RET Z
  LD A,E
  ADD A,$08
  LD E,A
  AND $08
  ADD A,A
  ADD A,A
  ADD A,A
  OR $3F
  JP Z,PTRFIL_2
  LD C,A
  INC HL
  LD A,(HL)
  SUB $31
  CP $02
  RET NC
  OR E
  LD E,A
  INC HL
  CALL UCASE_HL
  CP $4E
  JP Z,GETWORD_96
  CP $58
  RET NZ
  CALL _XONXOFF_FLG
  SCF
GETWORD_96:
  CALL NC,$6F8E
  INC HL
  CALL UCASE_HL
  CP $53
  JP Z,GETWORD_97
  CP $4E
  RET NZ
GETWORD_97:
  POP AF
  PUSH DE
  LD DE,$F40B
  LD B,$06
GETWORD_98:
  CALL UCASE_HL
  LD (DE),A
  DEC HL
  DEC DE
  DEC B
  JP NZ,GETWORD_98
  POP HL
  JP $6F58
  OR $1C
  RET M
  INC E
  ADD A,A
  DEC BC
  JP M,PTRFIL_0
  INC E
  RST $38
  LD L,H
  RST $38
  LD L,(HL)
  RST $38
  LD (HL),B
  RST $38
  LD (HL),D
  RST $38
  JR Z,$1CCE
  DEC L
  LD C,(HL)
  JP Z,CFERR
  CP $01
  JP NZ,NMERR			; NM error: bad file name
  PUSH HL
  CALL __EOF_1
  LD C,A
  SBC A,A
  CALL INT_RESULT_A
  POP HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  LD HL,COMPRV
  CP $FC		; 'COM' device
  JP Z,__EOF_0
  CALL GET_RAM_PTR
  CP $F9		; 'RAM' device ?
  JP Z,__EOF_0
  LD HL,CASPRV
__EOF_0:
  LD (HL),C
  RET

__EOF_1:
  PUSH BC
  PUSH HL
  PUSH DE
  LD A,$06
  JP GET_DEVICE

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
  JP NZ,RDBYT_0
  LD (HL),A
; This entry point is used by the routine at GET_DEVICE.
GETWORD_102:
  SCF
  JP RDBYT_0

__EOF_3:
  LD BC,$0001
__EOF_4:
  LD HL,(SAVSTK)
__EOF_5:
  LD A,(HL)
  AND A
  RET Z
  EX DE,HL
  LD HL,(STKTOP)
  EX DE,HL
  RST CPDEHL
  RET NC
  LD A,(HL)
  CP $82
  LD DE,$0007
  JP NZ,GETWORD_106
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  ADD HL,BC
  EX DE,HL
  LD (HL),D
  DEC HL
  LD (HL),E
  LD DE,CHRGTB
GETWORD_106:
  ADD HL,DE
  JP __EOF_5
  
; This entry point is used by the routine at OPRND.
FN_TIME:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL GET_DAY_0
  CALL READ_TIME
  JP TSTOPL
  
; This entry point is used by the routine at GET_DEVICE.
READ_TIME:
  CALL READ_CLOCK
  LD DE,$F837
  CALL LINE2PTR4
  LD (HL),':'
  INC HL
  CALL LINE2PTR4
  LD (HL),':'
GETWORD_109:
  INC HL
  JP LINE2PTR4
  
; This entry point is used by the routine at OPRND.
FN_DATE:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL GET_DAY_0
  CALL GET_DATE
  JP TSTOPL
  
; This entry point is used by the routine at GET_DEVICE.
GET_DATE:
  CALL READ_CLOCK
  PUSH HL
  LD HL,$F83D
  LD B,$00
  DI
  CALL $7EEC
  EI
  LD A,D
  EX (SP),HL
  CALL LINE2PTR6
  EX (SP),HL
  DEC HL
  DI
  CALL $7EEC
  EI
  LD A,D
  POP HL
  CALL LINE2PTR6
  LD DE,$F83B
  LD (HL),$2F
  INC HL
  LD A,(DE)
  CP $0A
  LD B,$30
  JP C,LINE2PTR2
  LD B,$31
  SUB $0A
LINE2PTR2:
  LD (HL),B
  INC HL
  CALL LINE2PTR6
  DEC DE
  LD (HL),$2F
  JP GETWORD_109
  
GET_DAY_0:
  LD A,$08
  CALL MKTMST
  LD HL,(TMPSTR)
  RET
  
LINE2PTR4:
  CALL LINE2PTR5
LINE2PTR5:
  LD A,(DE)
LINE2PTR6:
  OR $30
  LD (HL),A
  DEC DE
  INC HL
  RET
  
READ_CLOCK:
  PUSH HL
  LD HL,$F832
  DI
  CALL GET_DEVICE_502
  EI
  POP HL
  RET

; This entry point is used by the routine at __FOR.
TIME:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL GETWORD_123
LINE2PTR9:
  LD HL,$F832
  DI
  CALL $735A
  EI
  POP HL
  RET

; This entry point is used by the routine at __FOR.
DATE:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL GETWORD_122
  JP NZ,SNERR
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,$F83D
  DI
  CALL GET_DEVICE_669
  EI
  EX (SP),HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  EX (SP),HL
  DEC HL
; This entry point is used by the routine at EXP.
GETWORD_121:
  DI
  CALL GET_DEVICE_669
  EI
  POP HL
  INC HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  CPL
  CALL GETINT
  DEC A
  CP $0C
  JP NC,SNERR
  INC A
  LD DE,$F83B
  LD (DE),A
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  CPL
  DEC DE
  CALL GETWORD_124
  CP $04
  JP NC,SNERR
  CALL GETWORD_124
  JP LINE2PTR9

GETWORD_122:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  POP AF
  CALL $1091
  EX (SP),HL
  PUSH HL
  CALL READ_CLOCK
  CALL GETSTR
  LD A,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E
  CP $08
  RET
GETWORD_123:
  CALL GETWORD_122
  JP NZ,SNERR
  EX DE,HL
  POP HL
  EX (SP),HL
  PUSH HL
  EX DE,HL
  LD DE,$F838
  CALL GETWORD_124
  CP $03
  JP NC,SNERR
  CALL GETWORD_124
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  LD A,($7BCD)
  LD E,$CF
  LD A,($83CD)
  LD E,$FE
  LD B,$D2
  LD L,B
  DEC B
GETWORD_124:
  DEC DE
  LD A,(HL)
  INC HL
  SUB $30
  CP $0A
  JP NC,SNERR
  AND $0F
  LD (DE),A
  RET
__COM:
  PUSH HL
  LD HL,$F84C
  CALL GETWORD_125
  POP HL
  POP AF
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __FOR_7
GETWORD_125:
  CP $95
  JP Z,TIME_S_ON
  CP $E7
  JP Z,TIME_S_OFF
  CP $90
  JP Z,TIME_S_STOP
  JP SNERR
; This entry point is used by the routine at __DATA.
ONGO:
  CP $B6
  LD BC,$0001
  RET Z
  SCF
  RET
  
; This entry point is used by the routine at __DATA.
GETWORD_127:
  EX DE,HL
  LD ($F84D),HL		; IENTRY_F1
  EX DE,HL
  RET
  
; This entry point is used by the routine at GETYPR.
GETWORD_128:
  CALL GET_DEVICE_699
  PUSH HL
  PUSH DE
  PUSH BC
GETWORD_129:
  PUSH AF
  LD A,$0D
  JR NC,GETWORD_129
  LD HL,$F83E
  DEC (HL)
  JP NZ,GETWORD_130
  LD (HL),$7D
  INC HL
  DEC (HL)
  JP NZ,GETWORD_130
  LD (HL),$0C
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  CALL NZ,GETWORD_131
  LD A,(HL)
  AND A
  JP Z,GETWORD_130
  DEC (HL)
  JP NZ,GETWORD_130
  INC HL
  LD (HL),$FF
GETWORD_130:
  JP GET_DEVICE_508
; This entry point is used by the routine at GET_DEVICE.
GETWORD_131:
  LD A,($F402)
  LD (TIMINT),A
  RET
; This entry point is used by the routine at ISFLIO.
GETWORD_132:
  LD A,(HL)
  CP $7F
  JP Z,GETWORD_133
  CP ' '
  JP NC,GETWORD_134
GETWORD_133:
  LD A,' '
GETWORD_134:
  RST OUTC
  INC HL
  DEC B
  JP NZ,GETWORD_132
  LD A,' '
  RET
__KEY:
  CALL GETINT
  DEC A
  CP $0A
  JP NC,FCERR
  EX DE,HL
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD BC,$F6A5
  ADD HL,BC
  PUSH HL
  EX DE,HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL $1091
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
  JP Z,GETWORD_137
GETWORD_135:
  LD A,(DE)
  AND A
  JP Z,FCERR
  LD (HL),A
  INC DE
GETWORD_136:
  INC HL
  DEC C
  JP Z,GETWORD_138
  DEC B
  JP NZ,GETWORD_135
GETWORD_137:
  LD (HL),B
  INC HL
  DEC C
  JP NZ,GETWORD_137
GETWORD_138:
  LD (HL),C
  CALL GET_DEVICE_152
  CALL GET_DEVICE_387
  POP HL
  RET
__PSET:
  CALL GETWORD_141
GETWORD_139:
  RRCA
  PUSH HL
  PUSH AF
  CALL C,PLOT
  POP AF
  CALL NC,$74D1
  POP HL
  RET

__PRESET:
  CALL GETWORD_141
  CPL
  JP GETWORD_139

; This entry point is used by the routine at __DATA.
GETWORD_140:
  RST $38
  ADD A,(HL)
GETWORD_141:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  JR Z,GETWORD_136
  EX (SP),HL
  INC DE
  CP $F0		; TK_GREATER	; Token for '>'
  JP C,GETWORD_142
  LD A,$EF
GETWORD_142:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  CP $40
  JP C,GETWORD_143
  LD E,$3F
GETWORD_143:
  POP AF
  LD D,A
  EX DE,HL
  LD ($F3FA),HL
  EX DE,HL
  LD A,(HL)
  CP ')'
  JP NZ,GETWORD_144
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$01
  RET
GETWORD_144:
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  LD A,E
  POP DE
  RET
  
__LOCATE:
  CALL GETINT
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  POP AF
  LD D,A
  LD A,(ACTV_Y)
  INC D
  CP D
  JP NC,GETWORD_145
  LD D,A
GETWORD_145:
  LD A,($F3E7)
  INC E
  CP E
  JP NC,GETWORD_146
  LD E,A
GETWORD_146:
  PUSH HL
  EX DE,HL
  CALL POSIT
  LD A,H
  DEC A
  LD (TTYPOS),A
  POP HL
  RET
; This entry point is used by the routine at OPRND.
GETWORD_147:
  PUSH HL
  LD A,(CSRX)
  DEC A
  CALL INT_RESULT_A
  POP HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET
__WIDTH:
  RST $38
  LD E,(HL)
__CMD:
  RST $38
  ADC A,D
__COLOR:
  RST $38
  ADC A,B
; This entry point is used by the routine at OPRND.
FN_STATUS:
  RST $38
  ADC A,H
__SOUND:
  CALL GETWORD
  LD A,D
  AND $C0
  JP NZ,FCERR
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
GETWORD_149:
  AND A
  LD B,A
  POP DE
  JP NZ,MUSIC
  RET
__MOTOR:
  CALL GETINT
  JP DATAR_1
__EXEC:
  CALL GETWORD
  PUSH HL
  LD A,($F9A7)
  LD HL,($F9A8)
  CALL GETWORD_150
  LD ($F9A7),A
  LD ($F9A8),HL
  POP HL
  RET
GETWORD_150:
  PUSH DE
  RET
__SCREEN:
  CP ','
  LD A,($F3E4)
  CALL NZ,GETINT
  CALL GETWORD_151
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  PUSH HL
  AND A
  CALL GETWORD_30
  POP HL
  RET
; This entry point is used by the routine at GET_DEVICE.
GETWORD_151:
  PUSH HL
  LD ($F3E4),A
  AND A
  LD DE,$2808
  LD HL,($F3EC)
  LD A,$0E
  RST $38
  LD (HL),$CA
  LD C,H
  JR NZ,GETWORD_149
  LD ($F3E4),A
  RST $38
  LD H,B
  LD (CSRX),HL
  EX DE,HL
  LD ($F3E7),HL
  LD ($F457),A
  POP HL
  RET
  
; This entry point is used by the routine at SCPTLP.
MERGE_SUB:
  PUSH HL
  CALL CHGET8
  CALL RESFPT
  LD HL,(FILNAM+6)
  LD DE,$2020
  RST CPDEHL
  PUSH AF
  JP Z,_MERGE_SUB_3
  LD DE,'B'+'A'*$100			; "BA" (as in filename string)
  RST CPDEHL
  JP NZ,_MERGE_SUB_5
_MERGE_SUB_3:
  CALL FINDBA
  JP Z,_MERGE_SUB_5
  POP AF
  POP BC
  POP AF
  JP Z,FCERR
  LD A,$00
  PUSH AF
  PUSH BC
  LD (DIRPNT),HL
  EX DE,HL
  LD (BASTXT),HL
  CALL UPD_PTRS
  POP HL
  LD A,(HL)
  CP ','
  JP NZ,_MERGE_SUB_4
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'R'
  POP AF
  LD A,$80
  SCF
  PUSH AF
_MERGE_SUB_4:
  POP AF
  LD (NLONLY),A
  JP C,RUN_FST
  CALL RUN_FST
  JP READY
  
_MERGE_SUB_5:
  POP AF
  POP HL
  LD D,$F9		; 'RAM' device
  JP NZ,__MERGE_0
  PUSH HL
  LD HL,$2020
  LD (FILNAM+6),HL			; clear file name ext
  POP HL
  JP __MERGE_0

; This entry point is used by the routine at SCPTLP.
__LCOPY_6:
  PUSH HL
  CALL CHGET8
  LD HL,(FILNAM+6)			; point to file name ext
  LD DE,'D'+'O'*$100		; "DO" (as in filename string)
  RST CPDEHL
  LD B,$00
  JP Z,__LCOPY_7
  LD DE,'B'+'A'*$100		; "BA" (as in filename string)
  RST CPDEHL
  LD B,$01
  JP Z,__LCOPY_7
  LD DE,$2020			; "  "
  RST CPDEHL
  LD B,$02
  JP NZ,NMERR			; NM error: bad file name

__LCOPY_7:
  POP HL
  PUSH BC
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,__LCOPY_9
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  POP BC
  DEC B
  JP Z,NMERR			; NM error: bad file name
__LCOPY_8:
  XOR A
  LD DE,$F902		; D = 'RAM' device, E = $02
  PUSH AF
  JP __SAVE_1

__LCOPY_9:
  POP BC
  DEC B
  JP M,__LCOPY_8
  CALL __NAME_2
  JP NZ,FCERR

;SAVEBA:
  CALL FINDBA
  CALL NZ,KILLASC_6
  CALL RESFPT_0
  CALL NXTDIR_0
  LD (DIRPNT),HL
  LD A,$80
  EX DE,HL
  LD HL,(BASTXT)
  EX DE,HL
  CALL MAKTXT_0
  CALL RESFPT_9
  JP READY
  
__FILES:
  RST $38
  INC (HL)
  PUSH HL
  CALL CATALOG
  POP HL
  JP CONSOLE_CRLF


; Display Catalog
;
; Used by the routine at __FILES.
CATALOG:
  LD HL,$F844
CATALOG_0:
  LD C,$03
  LD A,(ACTV_Y)
  CP 40
  JP Z,CATALOG_1
  LD C,$06		; 6 characters
CATALOG_1:
  CALL NXTDIR
  RET Z
  AND $18	; 24
  JP NZ,CATALOG_1
  PUSH HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH DE
  
  LD B,$06		; 6 characters
CATALOG_2:
  LD A,(HL)
  RST OUTC
  INC HL
  DEC B
  JP NZ,CATALOG_2
  LD A,'.'
  RST OUTC
  LD A,(HL)
  RST OUTC
  INC HL
  LD A,(HL)
  RST OUTC
  POP DE
  LD HL,(BASTXT)
  RST CPDEHL
  LD A,'*'
  LD B,' '
  JP Z,CATALOG_3
  LD A,B
CATALOG_3:
  RST OUTC
  LD A,B
  RST OUTC
  RST OUTC
  POP HL
  DEC C
  JP NZ,CATALOG_1
  CALL ISFLIO_0
  PUSH HL
  LD HL,$0000
  CALL GETWORD_37
  POP HL
  JP CATALOG_0

__KILL:
  CALL __NAME_1
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SNERR
  LD A,D
  CP $F9		; 'RAM' device ?
  JP Z,__KILL_0
  RST $38
  DEFB $7E		; HKILL, Offset: 126
  ;LD A,(HL)
__KILL_0:
  PUSH HL
  CALL RESFPT_0
  CALL FINDFL
  JP Z,FFERR
  LD B,A
  AND $20
  JP NZ,KILLBIN_0
  LD A,B
  AND $40
  JP Z,KILLASC_5
  LD A,B
  AND $02
  JP NZ,AOERR

; Kill a text (.DO) file, DE=TOP addr, HL=adrress of dir entry.
KILLASC:
  LD A,$E5
  ; PUSH	HL  	; (KILLASC+1)
  LD BC,$0000
  LD (HL),C
  LD L,E
  LD H,D
KILLASC_0:
  LD A,(DE)
  INC DE
  INC BC
  CP $1A		; EOF
  JP NZ,KILLASC_0
  CALL MASDEL
KILLASC_1:
  CALL __EOF_4
  CALL RESFPT_0
  POP HL
  RET
  
; This entry point is used by the routine at GET_DEVICE.
KILLBIN:
  PUSH HL
KILLBIN_0:
  LD (HL),$00
  LD HL,(CO_FILES)
  PUSH HL
  EX DE,HL
  PUSH HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD HL,$0006
  ADD HL,BC
  LD B,H
  LD C,L
  POP HL
  CALL MASDEL
  POP HL
  LD (CO_FILES),HL
  JP KILLASC_1

; This entry point is used by the routine at GET_DEVICE.
KILLASC_4:
  CALL RESFPT_0
  LD HL,($F887)
  EX DE,HL
  LD HL,$F886
  JP KILLASC+1

KILLASC_5:
  PUSH HL
  LD HL,(BASTXT)
  RST CPDEHL
  POP HL
  JP Z,FCERR
  CALL KILLASC_6
  CALL _CLVAR
  JP READY

; This entry point is used by the routine at GET_DEVICE.
KILLASC_6:
  LD (HL),$00
  LD HL,(BASTXT)
  RST CPDEHL
  PUSH AF
  PUSH DE
  CALL UPD_PTRS_0
  POP DE
  INC HL
  CALL GETWORD_188
  PUSH BC
  CALL RESFPT_0
  POP BC
  POP AF
  RET Z
  RET C
  LD HL,(BASTXT)
  ADD HL,BC
  LD (BASTXT),HL
  RET

__NAME:
  CALL __NAME_1
  PUSH DE
  CALL SWAPNM
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'S'
  CALL __NAME_1
  LD A,D
  POP DE
  CP D
  JP NZ,FCERR
  CP $F9		; D = 'RAM' device ?
  JP Z,__NAME_0
  
  RST $38
  ADD A,B	; HNAME, Offset:

__NAME_0:
  PUSH HL
  CALL FINDFL
  JP NZ,FCERR
  CALL SWAPNM
  CALL FINDFL
  JP Z,FFERR
  PUSH HL
  LD HL,(FILNAM+6)
  EX DE,HL
  LD HL,(FILNM2+6)
  RST CPDEHL			; compare file name extensions
  JP NZ,FCERR
  POP HL
  CALL SWAPNM
  INC HL
  INC HL
  INC HL
  CALL COPY_NAME
  POP HL
  RET

__NAME_1:
  CALL FILE_PARMS
  RET NZ
  LD D,$F9		; 'RAM' device
  RET

__NAME_2:
  LD HL,(DIRPNT)
  LD DE,$F870
  RST CPDEHL
  RET


; Routine at 8329
;
; Used by the routines at CSAVEM and CLOADM.
FINDCO:
  LD BC,'C'*$100+'O'
  JP FIND_FILEXT

; This entry point is used by the routine at GET_DEVICE.
FINDCO_0:
  CALL CHGET8
  LD HL,(FILNAM+6)
  LD DE,$2020		; "  "
  RST CPDEHL
  JP Z,FINDDO
  LD DE,'D'+'O'*$100	; "DO" (as in filename string)
  RST CPDEHL
  JP NZ,NMERR			; NM error: bad file name

FINDDO:
  LD BC,'D'*$100+'O'
  JP FIND_FILEXT
  
FINDBA:
  LD BC,'B'*$100+'A'

FIND_FILEXT:
  LD HL,FILNAM+6
  LD (HL),B
  INC HL
  LD (HL),C

FINDFL:
  CALL CHGET8
  LD HL,$F844
  ;LD A,$E1
  DEFB $3E  ; "LD A,n" to Mask the next byte

; Routine at 8371
L22A2:
  POP HL
  CALL NXTDIR
  RET Z
  PUSH HL
  INC HL
  INC HL
  LD DE,$FB77
  LD B,$08
FINDFL_0:
  INC DE
  INC HL
  LD A,(DE)
  CP (HL)
  JP NZ,L22A2
  DEC B
  JP NZ,FINDFL_0
  POP HL
  LD A,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  AND A
  RET

NXTDIR:
  PUSH BC
  LD BC,$000B
  ADD HL,BC
  POP BC
  LD A,(HL)
  CP $FF
  RET Z
  AND A
  JP P,NXTDIR
  RET

NXTDIR_0:
  LD A,($F3FD)
  AND A
  LD HL,$F886
  RET NZ
  LD HL,$F886
  LD BC,$000B
NXTDIR_1:
  ADD HL,BC
  LD A,(HL)
  CP $FF
  JP Z,FLERR
  ADD A,A
  JP C,NXTDIR_1
  RET

__NEW:
  RET NZ
; This entry point is used by the routines at SCPTLP and GET_DEVICE.
CLRPTR:
  CALL __NAME_2
  CALL NZ,RESFPT
  CALL CLSALL		; Close all files
  LD HL,$F870
  LD (DIRPNT),HL
  LD HL,(SUZUKI)
  LD (BASTXT),HL
  XOR A
  LD (PTRFLG),A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  EX DE,HL
  LD HL,(DO_FILES)
  CALL GETWORD_188
  LD HL,$0000
  LD ($F9CA),HL
  CALL RESFPT_0
  JP RUN_FST
  
; This entry point is used by the routine at GET_DEVICE.
GETWORD_187:
  LD HL,(LBLIST)
  EX DE,HL
  LD HL,($F9AC)
GETWORD_188:
  LD A,L
  SUB E
  LD C,A
  LD A,H
  SBC A,D
  LD B,A
  EX DE,HL
  CALL MASDEL
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  RET
  
; This entry point is used by the routine at GET_DEVICE.
RESFPT:
  CALL GETPARM_VRFY
; This entry point is used by the routine at GET_DEVICE.
RESFPT_0:
  CALL RESFPT_3
  XOR A
  LD ($F745),A
  LD HL,(RAM)
  INC HL
RESFPT_0:
  PUSH HL
  LD HL,$F865
  LD DE,$FFFF
RESFPT_1:
  CALL NXTDIR
  JP Z,RESFPT_2
  CP $F0
  JP Z,RESFPT_1
  RRCA
  JP C,RESFPT_1
  PUSH HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RST CPDEHL
  POP HL
  JP NC,RESFPT_1
  LD B,H
  LD C,L
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  JP RESFPT_1
  
RESFPT_2:
  LD A,E
  AND D
  INC A
  POP DE
  JP Z,RESFPT_3
  LD H,B
  LD L,C
  LD A,(HL)
  OR $01
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  CALL RESFPT_5
  JP RESFPT_0
  
RESFPT_3:
  LD HL,$F844
RESFPT_4:
  CALL NXTDIR
  RET Z
  AND $FE
  LD (HL),A
  JP RESFPT_4
  
RESFPT_5:
  LD A,($F745)
  DEC A
  JP M,RESFPT_8
  JP Z,RESFPT_6
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  INC HL
  INC HL
  ADD HL,DE
  RET
  
RESFPT_6:
  LD A,$1A		; EOF
RESFPT_7:
  CP (HL)
  INC HL
  JP NZ,RESFPT_7
  EX DE,HL
  LD HL,(CO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NZ
  LD A,$02
  LD ($F745),A
  RET

RESFPT_8:
  EX DE,HL
  CALL UPD_PTRS_0
  INC HL
  EX DE,HL
  LD HL,(DO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NZ
  LD A,$01
  LD ($F745),A
  RET
  
RESFPT_9:
  LD HL,(PROGND)
  LD (VAREND),HL
  LD (ARREND),HL
  LD HL,(DO_FILES)
  DEC HL
  LD (SUZUKI),HL
  INC HL
  LD BC,$0002
  EX DE,HL
  CALL MAKHOL_0
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  JP RESFPT_0


; Count the number of characters in (HL), null terminated
;
; Used by the routines at OPENDO, TEL_UPLD and TXT_CTL_G.
COUNT_CHARS:
  PUSH HL
  LD E,$FF
COUNT_CHARS_0:
  INC E
  LD A,(HL)
  INC HL
  AND A
  JP NZ,COUNT_CHARS_0
  POP HL
  RET

; This entry point is used by the routine at GET_DEVICE.
OPENDO:
  CALL COUNT_CHARS
  CALL FNAME
  JP NZ,SNERR
  
MAKTXT:
  CALL RESFPT_0
  CALL FINDCO_0
  EX DE,HL
  SCF
  RET NZ
  CALL NXTDIR_0
  PUSH HL
  LD HL,(DO_FILES)
  PUSH HL
  LD A,$1A		; EOF
  CALL INSCHR
  JP C,OMERR
  POP DE
  POP HL
  PUSH HL
  PUSH DE
  LD A,$C0
  DEC DE
  CALL MAKTXT_0
  CALL RESFPT_0
  POP HL
  POP DE
  AND A
  RET

; This entry point is used by the routines at SAVEBA and CSAVEM.
MAKTXT_0:
  PUSH DE
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL

  DEFB $3E  ; "LD A,n" to Mask the next byte
;  LD A,$D5

; Used by the routine at __NAME.
COPY_NAME:
  PUSH DE
  LD DE,FILNAM
  LD B,$08
  CALL REV_LDIR_B
  POP DE
  RET

SWAPNM:
  PUSH HL
  LD B,$09
  LD DE,FILNAM
  LD HL,FILNM2
SWAPNM_0:
  LD C,(HL)
  LD A,(DE)
  LD (HL),A
  LD A,C
  LD (DE),A
  INC DE
  INC HL
  DEC B
  JP NZ,SWAPNM_0
  POP HL
  RET
 
CHGET8:
  PUSH HL
  LD HL,FILNAM+6
  LD B,$03
CHGET9:
  CALL UCASE_HL
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CHGET9
  POP HL
  RET

; This entry point is used by the routines at CHKSTK and GET_DEVICE.
SWAPNM_1:
  CALL RESFPT_0
  LD HL,$FFFF
  LD ($F3E2),HL
  LD B,H
  LD C,L
  LD HL,(HAYASHI)
  PUSH HL
  LD A,$1A		; EOF
SWAPNM_2:
  CP (HL)
  INC BC
  INC HL
  JP NZ,SWAPNM_2
  POP HL
  CALL MASDEL
  JP RESFPT_0

; This entry point is used by the routine at GET_DEVICE.
GETWORD_212:
  PUSH AF
  CALL CONSOLE_CRLF
  CALL ERAEOL
  POP AF
  ADD A,A
  ADD A,A
  JP C,GETWORD_218
  JP M,GETWORD_225
  RST $38
  INC A
  LD HL,(SUZUKI)
  LD (BASTXT),HL
  CALL GET_DEVICE_265
  LD A,B
  OR C
  JP Z,GETWORD_270
  LD ($FAEB),HL
  PUSH HL
  CALL GETWORD_256
  LD HL,GETWORD_217
  LD (ERRTRP),HL
  CALL GETWORD_294
  DI
  POP DE
  PUSH DE
  LD HL,(BASTXT)
GETWORD_213:
  LD B,$0A
GETWORD_214:
  CALL CASIN
  LD (HL),A
  LD C,A
  INC HL
  RST CPDEHL
  JP NC,GETWORD_217
  LD A,C
  AND A
  JP NZ,GETWORD_213
  DEC B
  JP NZ,GETWORD_214
  CALL CTOFF
  CALL UPD_PTRS
  INC HL
  POP DE
  CALL GETWORD_255
  CALL GETWORD_224
  CALL NXTDIR_0
  LD A,$80
  EX DE,HL
  LD HL,(SUZUKI)
  EX DE,HL
GETWORD_215:
  DEC DE
GETWORD_216:
  CALL MAKTXT_0
  JP __MENU
  
GETWORD_217:
  CALL CTOFF
  LD HL,(BASTXT)
  EX DE,HL
  LD HL,($FAEB)
  EX DE,HL
  CALL GETWORD_255
  JP GETWORD_270
GETWORD_218:
  LD HL,$6115
  XOR A
  LD ($F9B6),A
  LD E,$01
  CALL _OPEN
  LD HL,GETWORD_222
  LD (ERRTRP),HL
  CALL GET_DEVICE_264
  LD A,B
  OR C
  JP Z,GETWORD_223
  LD H,B
  LD L,C
  LD ($FAEB),HL
  LD HL,(DO_FILES)
  LD (TEMP),HL
GETWORD_219:
  CALL RDBYT
  JP C,GETWORD_220
  CALL GET_DEVICE_40
  JP Z,GETWORD_219
  CALL C,GETWORD_221
  CALL GETWORD_221
  JP GETWORD_219
GETWORD_220:
  LD (HL),$1A
  CALL SCPTLP_104
  CALL GETWORD_224
  CALL NXTDIR_0
  LD A,$C0
  EX DE,HL
  LD HL,(DO_FILES)
  EX DE,HL
  JP GETWORD_215
GETWORD_221:
  LD (HL),A
  INC HL
  LD A,(HL)
  AND A
  LD A,$0A
  RET Z
GETWORD_222:
  LD HL,($FAEB)
  LD B,H
  LD C,L
  LD HL,(TEMP)
  CALL MASDEL
GETWORD_223:
  CALL SCPTLP_104
  JP GETWORD_270
GETWORD_224:
  LD B,$09
  LD DE,FILNAM
  LD HL,$F99B
  JP LDIR_B
GETWORD_225:
  RST $38
  LD A,$CD
  LD (DE),A
  LD HL,($E32A)
  JP M,GETWORD_309
  JP NZ,GET_DEVICE_693
  LD BC,$0006
  ADD HL,BC
  LD ($FAEB),HL
  LD B,H
  LD C,L
  LD HL,(PROGND)
  LD (TEMP),HL
  CALL GET_DEVICE_376
  JP C,GETWORD_270
  EX DE,HL
  LD HL,$F9C0
  CALL GETWORD_267
  PUSH DE
  LD HL,GETWORD_226
  LD (ERRTRP),HL
  CALL GETWORD_303
  POP HL
  POP DE
  CALL GETWORD_251
  JP NZ,GETWORD_226
  CALL CTOFF
  POP HL
  LD (CO_FILES),HL
  CALL GETWORD_224
  CALL NXTDIR_0
  LD A,$A0
  EX DE,HL
  LD HL,(PROGND)
  EX DE,HL
  JP GETWORD_216
GETWORD_226:
  CALL CTOFF
  JP GETWORD_222
__CSAVE:
  CALL GETWORD_277
; This entry point is used by the routine at SCPTLP.
GETWORD_227:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,GETWORD_228
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  LD E,$02
  AND A
  PUSH AF
  JP __SAVE_1
GETWORD_228:
  LD HL,$FB7D
  LD B,$06
GETWORD_229:
  LD A,(HL)
  SUB $20
  JP NZ,GETWORD_230
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,GETWORD_229
GETWORD_230:
  CALL GETPARM_VRFY
  INC HL
  PUSH HL
  CALL GETWORD_50
  LD B,$0A
GETWORD_231:
  LD A,$D3
  CALL CSOUT
  DEC B
  JP NZ,GETWORD_231
  LD B,$06
  LD HL,FILNAM
GETWORD_232:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC B
  JP NZ,GETWORD_232
  LD BC,$4E20
GETWORD_233:
  DEC BC
  LD A,B
  OR C
  JP NZ,GETWORD_233
  POP DE
  LD HL,(BASTXT)
GETWORD_234:
  LD A,(HL)
  CALL CSOUT
  INC HL
  RST CPDEHL
  JP NZ,GETWORD_234
  LD B,$09
GETWORD_235:
  XOR A
  CALL CSOUT
  DEC B
  JP NZ,GETWORD_235
  LD BC,$1F40
GETWORD_236:
  DEC BC
  LD A,B
  OR C
  JP NZ,GETWORD_236
  CALL CTOFF
GETWORD_237:
  LD A,($F9BA)
  AND A
  JP NZ,GET_DEVICE_100
  JP RESTART
  
__BSAVE:
  CALL __NAME_1
  LD A,D
  CP $FD
  JP Z,GETWORD_238
  CP $F9
  JP Z,GETWORD_240
  RST $38
  ADD A,D
GETWORD_238:
  CALL GETWORD_241
  CALL $2989
  CALL GETWORD_284
  LD HL,($F9C2)
  EX DE,HL
  LD HL,($F9C0)
  LD C,$00
GETWORD_239:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,GETWORD_239
  CALL GETWORD_282
  JP GETWORD_237
GETWORD_240:
  CALL GETWORD_241
  CALL RESFPT_0
  CALL FINDCO
  CALL NZ,KILLBIN
  CALL NXTDIR_0
  PUSH HL
  LD HL,(CO_FILES)
  PUSH HL
  LD HL,($F9C2)
  LD A,H
  OR L
  JP Z,OMERR
  PUSH HL
  LD BC,$0006
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,(PROGND)
  LD (TEMP),HL
  CALL NC,GET_DEVICE_376
  JP C,OMERR
  EX DE,HL
  LD HL,$F9C0
  CALL GETWORD_267
  LD HL,($F9C0)
  POP BC
  CALL _LDIR
  POP HL
  LD (CO_FILES),HL
  POP HL
  LD A,$A0
  EX DE,HL
  LD HL,(TEMP)
  EX DE,HL
  CALL MAKTXT_0
  CALL RESFPT_0
  JP RESTART
  
GETWORD_241:
  CALL GETWORD_242
  PUSH DE
  CALL GETWORD_242
  LD A,D
  OR E
  JP Z,FCERR
  PUSH DE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD DE,$0000
  CALL NZ,GETWORD_242
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SNERR
  EX DE,HL
  LD ($F9C4),HL
  POP DE
  POP HL
  LD ($F9C0),HL
  ADD HL,DE
  JP C,FCERR
  EX DE,HL
  LD ($F9C2),HL
  RET
  
GETWORD_242:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JP GETWORD
  
__CLOAD:
  CP $91		; TK_PRINT
  JP Z,CVERIFY
  CALL GETWORD_274
  OR $FF
  PUSH AF
; This entry point is used by the routine at SCPTLP.
GETWORD_243:
  POP AF
  PUSH AF
  JP NZ,GETWORD_244
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,FCERR
GETWORD_244:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$00
  SCF
  CCF
  JP Z,GETWORD_245
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'R'
  JP NZ,SNERR
  POP AF
  SCF
  PUSH AF
  LD A,$80
GETWORD_245:
  PUSH AF
  LD (NLONLY),A
  POP BC
  POP AF
  PUSH AF
  PUSH BC
  JP Z,GETWORD_246
  CALL GETPARM_VRFY
  CALL RESFPT_0
  LD HL,(SUZUKI)
  LD (BASTXT),HL
  LD HL,$F870
  LD (DIRPNT),HL
  LD HL,(PROGND)
  LD (VAREND),HL
  LD (ARREND),HL
  CALL GET_DEVICE_264
  CALL GETWORD_256
  LD HL,$27E4
  LD (ERRTRP),HL
GETWORD_246:
  CALL GETWORD_298
  JP Z,GETWORD_248
  CP $9C
  JP Z,LOAD_RECORD_2
GETWORD_247:
  CALL GETWORD_304
  CALL CONSOLE_CRLF
  JP GETWORD_246
GETWORD_248:
  CALL GETWORD_285
  JP NZ,GETWORD_246
  CALL GETWORD_287
  JP NZ,GETWORD_247
  POP BC
  POP AF
  PUSH AF
  PUSH BC
  JP Z,GETWORD_247
  POP AF
  POP AF
  SBC A,A
  LD (FILFLG),A
  CALL CAS_OPNI_CO_12
  DI
  LD HL,(DO_FILES)
  EX DE,HL
  LD HL,(BASTXT)
GETWORD_249:
  LD B,$0A
GETWORD_250:
  CALL CASIN
  LD (HL),A
  LD C,A
  INC HL
  RST CPDEHL
  JP NC,GETWORD_253
  LD A,C
  AND A
  JP NZ,GETWORD_249
  DEC B
  JP NZ,GETWORD_250
  CALL UPD_PTRS
  INC HL
  EX DE,HL
  LD HL,(DO_FILES)
  EX DE,HL
  CALL GETWORD_255
  XOR A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL CTOFF
  CALL CONSOLE_CRLF
  CALL RUN_FST
  LD A,(FILFLG)
  AND A
  JP NZ,EXEC_EVAL
  JP READY
  
GETWORD_251:
  LD C,$00
GETWORD_252:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,GETWORD_252
  CALL CASIN
  LD A,C
  AND A
  RET
  
  CALL GETWORD_254
  LD HL,$0000
  LD (ERRTRP),HL
  JP HEADER_0
GETWORD_253:
  CALL GETWORD_254
  LD HL,$0000
  LD (ERRTRP),HL
  CALL CTOFF
  JP OMERR
GETWORD_254:
  LD HL,(DO_FILES)
  EX DE,HL
  LD HL,(BASTXT)
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
GETWORD_255:
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  CALL MASDEL
; This entry point is used by the routine at SNERR.
GETWORD_256:
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  RET
  
LOAD_RECORD_2:
  CALL CAS_OPNI_CO_12
  CALL CONSOLE_CRLF
  POP BC
  POP AF
  PUSH AF
  PUSH BC
  CALL NZ,GETWORD_254
  LD HL,$0000
  LD (ERRTRP),HL
  LD HL,(FILTAB)
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (PTRFIL),HL			; Redirect I/O
  LD (HL),$01
  INC HL
  INC HL
  INC HL
  INC HL
  LD (HL),$FD		; 'CAS' device ?
  INC HL
  INC HL
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD (CASPRV),A
  JP __MERGE_3
  
CVERIFY:
  PUSH HL
  CALL GETPARM_VRFY
  INC HL
  EX (SP),HL
  CALL CAS_OPNI_BA
  PUSH HL
  CALL GETWORD_294
  DI
  POP HL
  POP DE
  PUSH HL
  LD HL,(BASTXT)
GETWORD_259:
  CALL CASIN
  CP (HL)
  JP NZ,GETWORD_261
  INC HL
  RST CPDEHL
  JP C,GETWORD_259
GETWORD_260:
  CALL CTOFF
  POP HL
  RET

GETWORD_261:
  LD HL,$287B
  CALL GET_DEVICE_42
  JP GETWORD_260
  LD B,D
  LD H,C
  LD H,H
  DEC C
  LD A,(BC)
  NOP

__BLOAD:
  CP $91		; TK_PRINT
  JP Z,GETWORD_271
  CALL __NAME_1
  LD A,D
  CP $FD
  JP Z,GETWORD_262
  CP $F9
  JP Z,GETWORD_263
  RST $38
  ADD A,H
GETWORD_262:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SNERR
  PUSH HL
  CALL $2A12
  CALL GETWORD_265
  JP C,OMERR
  CALL GETWORD_303
  LD HL,($F9C2)
  EX DE,HL
  LD HL,($F9C0)
  CALL GETWORD_251
  JP NZ,HEADER_0
  CALL CTOFF
  JP GETWORD_264
GETWORD_263:
  PUSH HL
  CALL RESFPT_0
  CALL FINDCO
  JP Z,FFERR
  EX DE,HL
  CALL GETWORD_266
  PUSH HL
  CALL GETWORD_265
  JP C,OMERR
  LD HL,($F9C2)
  LD B,H
  LD C,L
  LD HL,($F9C0)
  EX DE,HL
  POP HL
  CALL _LDIR
GETWORD_264:
  POP HL
  RET
GETWORD_265:
  LD HL,(HIMEM)
  EX DE,HL
  LD HL,($F9C0)
  RST CPDEHL
  RET C
  EX DE,HL
  LD HL,($F9C2)
  ADD HL,DE
  EX DE,HL
  LD HL,MAXRAM
  RST $38
  LD B,H
  RST CPDEHL
  LD HL,($F9C0)
  RET
; This entry point is used by the routine at GET_DEVICE.
GETWORD_266:
  LD DE,$F9C0
GETWORD_267:
  LD B,$06
; This entry point is used by the routines at ISFLIO and GET_DEVICE.
LDIR_B:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC B
  JP NZ,LDIR_B
  RET
; This entry point is used by the routine at GET_DEVICE.
GETWORD_269:
  CALL GETWORD_266
  PUSH HL
  CALL GETWORD_265
  JP C,GETWORD_270
  EX DE,HL
  LD HL,($F9C2)
  LD B,H
  LD C,L
  POP HL
  CALL _LDIR
  LD HL,($F9C4)
  LD A,H
  OR L
  LD ($F40D),HL
  CALL NZ,GET_DEVICE_710
  JP __MENU
  
GETWORD_270:
  CALL __BEEP
  JP __MENU
  
GETWORD_271:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL __NAME_1
  CALL GETWORD_279
  PUSH HL
  CALL $2A12
  CALL GETWORD_303
  LD HL,($F9C2)
  EX DE,HL
  LD HL,($F9C0)
  CALL GETWORD_272
  JP NZ,GETWORD_261
  CALL CTOFF
  POP HL
  RET
GETWORD_272:
  LD C,$00
GETWORD_273:
  CALL CASIN
  CP (HL)
  RET NZ
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,GETWORD_273
  CALL CASIN
  LD A,C
  AND A
  RET
GETWORD_274:
  DEC HL
CAS_OPNI_BA:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,GETWORD_277
  LD B,$06
  LD DE,FILNAM
  LD A,' '
GETWORD_276:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,GETWORD_276
  JP GETWORD_278
GETWORD_277:
  CALL FILE_PARMS
  JP NZ,GETWORD_279
GETWORD_278:
  LD D,$FD
GETWORD_279:
  LD A,D
  CP $FD
  JP NZ,FCERR
  RET
GETWORD_280:
  LD A,$9C
  LD BC,$D03E
  PUSH AF
  CALL GETWORD_50
  POP AF
  CALL CSOUT
  LD C,$00
  LD HL,FILNAM
  LD DE,$0602
GETWORD_281:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC D
  JP NZ,GETWORD_281
  LD HL,$F9C0
  LD D,$0A
  DEC E
  JP NZ,GETWORD_281
GETWORD_282:
  LD A,C
  CPL
  INC A
  CALL CSOUT
  LD B,$14
GETWORD_283:
  XOR A
  CALL CSOUT
  DEC B
  JP NZ,GETWORD_283
  JP CTOFF
GETWORD_284:
  CALL GETWORD_50
  LD A,$8D
  JP CSOUT
GETWORD_285:
  LD B,$09
GETWORD_286:
  CALL CASIN
  CP $D3
  RET NZ
  DEC B
  JP NZ,GETWORD_286
  RET
GETWORD_287:
  LD B,$06
  LD HL,FILNM2
GETWORD_288:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC B
  JP NZ,GETWORD_288
GETWORD_289:
  LD HL,FILNAM
  LD B,$06
  LD A,' '
GETWORD_290:
  CP (HL)
  JP NZ,GETWORD_291
  INC HL
  DEC B
  JP NZ,GETWORD_290
  RET
GETWORD_291:
  LD HL,FILNAM
  LD DE,FILNM2
  LD B,$06
GETWORD_292:
  LD A,(DE)
  AND A
  JP NZ,GETWORD_293
  LD A,' '
GETWORD_293:
  CP (HL)
  RET NZ
  INC DE
  INC HL
  DEC B
  JP NZ,GETWORD_292
  RET
GETWORD_294:
  LD B,$D3
  LD DE,$9C06
  LD DE,$D006
  PUSH BC
GETWORD_295:
  CALL GETWORD_298
  JP NZ,GETWORD_296
  CALL GETWORD_285
  JP NZ,GETWORD_295
  CALL GETWORD_287
  JP NZ,GETWORD_297
  LD A,$D3
GETWORD_296:
  POP BC
  CP B
  JP Z,CAS_OPNI_CO_12
  PUSH BC
GETWORD_297:
  CALL GETWORD_304
  CALL CONSOLE_CRLF
  JP GETWORD_295
GETWORD_298:
  CALL HEADER
  CALL CASIN
  CP $D3
  RET Z
  CP $9C
  JP Z,GETWORD_299
  CP $D0
  JP NZ,GETWORD_298
GETWORD_299:
  PUSH AF
  LD HL,FILNM2
  LD DE,$0602
  LD C,$00
GETWORD_300:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC D
  JP NZ,GETWORD_300
  LD HL,$F9C0
  LD D,$0A
  DEC E
  JP NZ,GETWORD_300
  CALL CASIN
  LD A,C
  AND A
  JP NZ,GETWORD_302
  CALL CTOFF
  CALL GETWORD_289
  JP NZ,GETWORD_301
  POP AF
  AND A
  RET
GETWORD_301:
  CALL GETWORD_304
  CALL CONSOLE_CRLF
GETWORD_302:
  POP AF
  JP GETWORD_298
GETWORD_303:
  CALL HEADER
  CALL CASIN
  CP $8D
  JP NZ,HEADER_0
  RET
GETWORD_304:
  LD DE,$2AC6
  JP GETWORD_306
CAS_OPNI_CO_12:
  LD DE,$2ABF
GETWORD_306:
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  RET NZ
  EX DE,HL
  CALL GET_DEVICE_42
  XOR A
  LD (FILNM2+6),A
  LD HL,FILNM2
  CALL PRS
  LD A,$0D
  LD HL,CSRY
  SUB (HL)
  RET C
  RET Z
  LD B,A
  LD A,' '
GETWORD_307:
  RST OUTC
  DEC B
  JP NZ,GETWORD_307
  RET
  LD B,(HL)
  LD L,A
  LD (HL),L
  LD L,(HL)
  LD H,H
  LD A,($5300)
  LD L,E
  LD L,C
  LD (HL),B
  JR NZ,$2B06
  NOP
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
GETWORD_308:
  LD A,E
  OR D
GETWORD_309:
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
  JP Z,GETWORD_308
  CCF
  JP ISZ_RESULT

; STR BASIC function entry
__STR_S:
  CALL FOUT
  CALL CRTST
  CALL GSTRCU

; Save string in string area
SAVSTR:
  LD BC,TOPOOL
  PUSH BC
; This entry point is used by the routine at __DATA.
SAVSTR_0:
  LD A,(HL)
  INC HL
  PUSH HL
  CALL TESTR
  POP HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  CALL CRTMST			; Make temporary string
  PUSH HL
  LD L,A
  CALL TOSTRA
  POP DE
  RET
  
; This entry point is used by the routines at GSTRDE and SCPTLP.
MK_1BYTE_TMST:
  LD A,$01

; Make temporary string
;
; Used by the routines at GETWORD, CONCAT, TOPOOL and SCPTLP.
MKTMST:
  CALL TESTR

; Create temporary string entry
;
; Used by the routines at SAVSTR, DTSTR and TOPOOL.
CRTMST:
  LD HL,TMPSTR
  PUSH HL
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; Create String
;
; Used by the routines at __DATA, __STR_S and PRS.
CRTST:
  DEC HL

; Create quote terminated String
;
; Used by the routines at __DATA and OPRND.
QTSTR:
  LD B,$22
; This entry point is used by the routines at __DATA and SCPTLP.
QTSTR_0:
  LD D,B

; Create String, termination char in D
;
; Used by the routine at __DATA.
DTSTR:
  PUSH HL
  LD C,$FF
DTSTR_0:
  INC HL
  LD A,(HL)
  INC C
  OR A
  JP Z,DTSTR_1
  CP D
  JP Z,DTSTR_1
  CP B
  JP NZ,DTSTR_0
DTSTR_1:
  CP '"'
  CALL Z,_CHRGTB
  EX (SP),HL
  INC HL
  EX DE,HL
  LD A,C
  CALL CRTMST			; Make temporary string

; Temporary string to pool
;
; Used by the routines at GETWORD, CONCAT, TOPOOL and SCPTLP.
TSTOPL:
  LD DE,TMPSTR
  LD A,$D5
  LD HL,(TEMPPT)
  LD (DBL_FPREG),HL
  LD A,$03
  LD (VALTYP),A
  CALL FP2HL
  LD DE,$FABF
  RST CPDEHL
  LD (TEMPPT),HL
  POP HL
  LD A,(HL)
  RET NZ
  LD DE,CHRGTB
  JP ERROR

; Print number string
PRNUMS:
  INC HL

; Create string entry and print it
;
; Used by the routines at SNERR, __DATA, GETWORD, _DBL_ASCTFP, ISFLIO, SCPTLP and
; GET_DEVICE.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routine at __DATA.
PRS1:
  CALL GSTRCU
  CALL LOADFP_0
  INC D
PRS1_0:
  DEC D
  RET Z
  LD A,(BC)
  RST OUTC
  CP $0D
  CALL Z,SCPTLP_46
  INC BC
  JP PRS1_0

; Test if enough room for string
;
; Used by the routines at SAVSTR, MKTMST and TOPOOL.
TESTR:
  OR A
  LD C,$F1
  PUSH AF
  LD HL,(STKTOP)
  EX DE,HL
  LD HL,($FABF)
  CPL
  LD C,A
  LD B,$FF
  ADD HL,BC
  INC HL
  RST CPDEHL
  JP C,TESTR_1
  LD ($FABF),HL
  INC HL
  EX DE,HL
; This entry point is used by the routine at MAKINT.
TESTR_0:
  POP AF
  RET
TESTR_1:
  POP AF
  LD DE,$000E
  JP Z,ERROR
  CP A
  PUSH AF
  LD BC,$2B8B
  PUSH BC
; This entry point is used by the routine at MIDNUM.
TESTR_2:
  LD HL,(MEMSIZ)
TESTR_3:
  LD ($FABF),HL
  LD HL,$0000
  PUSH HL
  LD HL,(ARREND)
  PUSH HL
  LD HL,TEMPST
  EX DE,HL
  LD HL,(TEMPPT)
  EX DE,HL
  RST CPDEHL
  LD BC,$2BC3
  JP NZ,TESTR_9
  LD HL,$FB0C
  LD ($FB15),HL
  LD HL,(VAREND)
  LD ($FB12),HL
  LD HL,(PROGND)
TESTR_4:
  EX DE,HL
  LD HL,($FB12)
  EX DE,HL
  RST CPDEHL
  JP Z,TESTR_6
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  CP $03
  JP NZ,TESTR_5
  CALL TESTR_10
  XOR A
TESTR_5:
  LD E,A
  LD D,$00
  ADD HL,DE
  JP TESTR_4
TESTR_6:
  LD HL,($FB15)
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  LD HL,(VAREND)
  JP Z,TESTR_8
  EX DE,HL
  LD ($FB15),HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL
  ADD HL,DE
  LD ($FB12),HL
  EX DE,HL
  JP TESTR_4
TESTR_7:
  POP BC
TESTR_8:
  EX DE,HL
  LD HL,(ARREND)
  EX DE,HL
  RST CPDEHL
  JP Z,TESTR_11
  LD A,(HL)
  INC HL
  CALL LOADFP
  PUSH HL
  ADD HL,BC
  CP $03
  JP NZ,TESTR_7
  LD ($FAC3),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL
  EX DE,HL
  LD HL,($FAC3)
  EX DE,HL
  RST CPDEHL
  JP Z,TESTR_8
  LD BC,$2C3C
TESTR_9:
  PUSH BC
TESTR_10:
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
  LD HL,($FABF)
  RST CPDEHL
  LD H,B
  LD L,C
  RET C
  POP HL
  EX (SP),HL
  RST CPDEHL
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
TESTR_11:
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
  LD HL,($FABF)
  CALL __POS_2
  POP HL
  LD (HL),C
  INC HL
  LD (HL),B
  LD H,B
  LD L,C
  DEC HL
  JP TESTR_3

; String concatenation
;
; Used by the routine at EVAL4.
CONCAT:
  PUSH BC
  PUSH HL
  LD HL,(DBL_FPREG)
  EX (SP),HL
  CALL OPRND
  EX (SP),HL
  CALL TSTSTR
  LD A,(HL)
  PUSH HL
  LD HL,(DBL_FPREG)
  PUSH HL
  ADD A,(HL)
  LD DE,$000F			; Err $0F - "String too long"
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
; Used by the routines at SAVSTR and TOPOOL.
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
  JP TSALP

; Get string pointed by FPREG 'Type Error' if it is not
;
; Used by the routines at GETWORD, GSTRDE, MIDNUM and SCPTLP.
GETSTR:
  CALL TSTSTR

; Get string pointed by FPREG
;
; Used by the routines at __STR_S, PRS1 and MIDNUM.
GSTRCU:
  LD HL,(DBL_FPREG)

; Get string pointed by HL
;
; Used by the routines at CONCAT, MIDNUM and SCPTLP.
GSTRHL:
  EX DE,HL

; Get string pointed by DE
;
; Used by the routines at GETWORD, CONCAT and TOPOOL.
GSTRDE:
  CALL BAKTMP
  EX DE,HL
  RET NZ
  PUSH DE
  LD D,B
  LD E,C
  DEC DE
  LD C,(HL)
  LD HL,($FABF)
  RST CPDEHL
  JP NZ,GSTRDE_0
  LD B,A
  ADD HL,BC
  LD ($FABF),HL
GSTRDE_0:
  POP HL
  RET
; This entry point is used by the routine at __DATA.
BAKTMP:
  LD HL,(TEMPPT)
  DEC HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  RST CPDEHL
; This entry point is used by the routine at TOPOOL.
GSTRDE_2:
  RET NZ
  LD (TEMPPT),HL
  RET
  
__LEN:
  LD BC,UNSIGNED_RESULT_A
  PUSH BC
; This entry point is used by the routines at __ASC and __VAL.
__LEN_0:
  CALL GETSTR
  XOR A
  LD D,A
  LD A,(HL)
  OR A
  RET
  
__ASC:
  LD BC,UNSIGNED_RESULT_A
  PUSH BC
; This entry point is used by the routine at FN_STRING.
__ASC_0:
  CALL __LEN_0
  JP Z,FCERR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  RET

__CHR_S:
  CALL MK_1BYTE_TMST
  CALL MAKINT
; This entry point is used by the routine at SCPTLP.
__CHR_S_0:
  LD HL,(TMPSTR)
  LD (HL),E

; Save in string pool
TOPOOL:
  POP BC
  JP TSTOPL
; This entry point is used by the routine at OPRND.
TOPOOL_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  JR Z,GSTRDE_2
  EX (SP),HL
  INC DE
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL $1091
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  EX (SP),HL
  PUSH HL
  RST GETYPR 		; Get the number type (FAC)
  JP Z,TOPOOL_1
  CALL MAKINT
  JP TOPOOL_2
TOPOOL_1:
  CALL __ASC_0
TOPOOL_2:
  POP DE
  CALL TOPOOL_3
  
__SPACE_S
  CALL MAKINT
  LD A,' '
TOPOOL_3:
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

__LEFT_S:
  CALL LFRGNM
  XOR A
__LEFT_S_0:
  EX (SP),HL
  LD C,A
  
__LEFT_S_1:
  LD A,$E5
	;; __LEFT_S_1+1:  PUSH HL

  PUSH HL
  LD A,(HL)
  CP B
  JP C,$2D7C
  LD A,B
  LD DE,$000E
  PUSH BC
  CALL TESTR
  POP BC
  POP HL
  PUSH HL
  INC HL
  LD B,(HL)
  INC HL
  LD H,(HL)
  LD L,B
  LD B,$00
  ADD HL,BC
  LD B,H
  LD C,L
  CALL CRTMST			; Make temporary string
  LD L,A
  CALL TOSTRA
  POP DE
  CALL GSTRDE
  JP TSTOPL

__RIGHT_S:
  CALL LFRGNM
  POP DE
  PUSH DE
  LD A,(DE)
  SUB B
  JP __LEFT_S_0
__MID_S:
  EX DE,HL
  LD A,(HL)
  CALL MIDNUM
  INC B
  DEC B
  JP Z,FCERR
  PUSH BC
  LD E,$FF
  CP ')'
  JP Z,__MID_S_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
__MID_S_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  POP AF
  EX (SP),HL
  LD BC,$2D74
  PUSH BC
  DEC A
  CP (HL)
  LD B,$00
  RET NC
  LD C,A
  LD A,(HL)
  SUB C
  CP E
  LD B,A
  RET C
  LD B,E
  RET
  
__VAL:
  CALL __LEN_0
  JP Z,UNSIGNED_RESULT_A
  LD E,A
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  PUSH HL
  ADD HL,DE
  LD B,(HL)
  LD (VLZADR),HL
  LD A,B
  LD (VLZDAT),A
  LD (HL),D
  EX (SP),HL
  PUSH BC
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL DBL_DBL_ASCTFP
  LD HL,$0000
  LD (VLZADR),HL
  POP BC
  POP HL
  LD (HL),B
  RET

; number in program listing and check for ending ')'
;
; Used by the routine at TOPOOL.
LFRGNM:
  EX DE,HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL

; Get number in program listing
;
; Used by the routine at TOPOOL.
MIDNUM:
  POP BC
  POP DE
  PUSH BC
  LD B,E
  RET
  
; This entry point is used by the routine at OPRND.
FN_INSTR:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL OPNPAR
  RST GETYPR 		; Get the number type (FAC)
  LD A,$01
  PUSH AF
  JP Z,FN_INSTR_0	; JP if string type
  POP AF
  CALL MAKINT
  OR A
  JP Z,FCERR
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL $1091
  CALL TSTSTR
FN_INSTR_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  LD HL,(DBL_FPREG)
  EX (SP),HL
  CALL $1091
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  PUSH HL
  CALL GETSTR
  EX DE,HL
  POP BC
  POP HL
  POP AF
  PUSH BC
  LD BC,POPHLRT		; (POP HL / RET)
  PUSH BC
  LD BC,UNSIGNED_RESULT_A
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
FN_INSTR_2:
  PUSH HL
  PUSH DE
  PUSH BC
FN_INSTR_3:
  LD A,(DE)
  CP (HL)
  JP NZ,FN_INSTR_6
  INC DE
  DEC C
  JP Z,FN_INSTR_5
  INC HL
  DEC B
  JP NZ,FN_INSTR_3
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
  DEC B
  JP NZ,FN_INSTR_2
  JP FN_INSTR_4

__FRE:
  LD HL,(ARREND)
  EX DE,HL
  LD HL,$0000
  ADD HL,SP
  RST GETYPR 		; Get the number type (FAC)
  JP NZ,IMP
  CALL GSTRCU
  CALL TESTR_2
  EX DE,HL
  LD HL,(STKTOP)
  EX DE,HL
  LD HL,($FABF)
  JP IMP
; This entry point is used by the routine at _DBL_ASCTFP.
MIDNUM_7:
  CALL FP_ARG2HL
  LD HL,$3CE2
  CALL LOADFP_7
  CALL DECADD
  RET
; This entry point is used by the routine at _DBL_ASCTFP.
MIDNUM_8:
  LD HL,HALF
; This entry point is used by the routines at __RND and CHKSTK.
MIDNUM_9:
  CALL LOADFP
  JP FADD
  CALL LOADFP

; Subtract BCDE from FP reg
;
; Used by the routines at EXP and __RND.
FSUB:
  CALL INVSGN

; Add BCDE to FP reg
;
; Used by the routines at GETWORD, MIDNUM, __LOG, MLSP10, _DBL_ASCTFP, EXP and
; __RND.
FADD:
  LD A,B
  OR A
  RET Z
  LD A,(FACCU)
  OR A
  JP Z,FPBCDE
  SUB B
  JP NC,FADD_0
  CPL
  INC A
  EX DE,HL
  CALL STAKI
  EX DE,HL
  CALL FPBCDE
  POP BC
  POP DE
FADD_0:
  CP $19
  RET NC
  PUSH AF
  CALL LOADFP_5
  LD H,A
  POP AF
  CALL COMPL_0
  LD A,H
  OR A
  LD HL,DBL_FPREG
  JP P,FADD_1
  CALL PLUCDE
  JP NC,BNORM_8
  INC HL
  INC (HL)
  JP Z,$057D
  LD L,$01
  CALL SCALE_2
  JP BNORM_8

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
; This entry point is used by the routines at FLGREL and INT.
FADD_2:
  CALL C,COMPL

; Normalise number
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
  JP NZ,BNORM_6
  LD C,D
  LD D,H
  LD H,L
  LD L,A
  LD A,B
  SUB $08
  CP $E0
  JP NZ,BNORM_0

; This entry point is used by the routines at DIV, DECADD, DBL_DBL_ASCTFP and EXP.
CLEAR_EXPONENT:
  XOR A
; This entry point is used by the routine at POWER.
SET_EXPONENT:
  LD (FACCU),A
  RET

BNORM_3:
  LD A,H
  OR L
  OR D
  JP NZ,BNORM_5
  LD A,C
BNORM_4:
  DEC B
  RLA
  JP NC,BNORM_4
  INC B
  RRA
  LD C,A
  JP BNORM_7

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
  JP Z,BNORM_8
  LD HL,FACCU
  ADD A,(HL)
  LD (HL),A
  JP NC,CLEAR_EXPONENT
  JP Z,CLEAR_EXPONENT
  
; This entry point is used by the routines at FADD and FCOMP.
BNORM_8:
  LD A,B
; This entry point is used by the routines at DIV and GET_DEVICE.
BNORM_9:
  LD HL,FACCU
  OR A
  CALL M,CLEAR_EXPONENT0
  LD B,(HL)
  INC HL
  LD A,(HL)
  AND $80
  XOR C
  LD C,A
  JP FPBCDE

; This entry point is used by the routine at FPINT.
CLEAR_EXPONENT0:
  INC E
  RET NZ
  INC D
  RET NZ
  INC C
  RET NZ
  LD C,$80
  INC (HL)
  RET NZ
  JP $057D

; Add number pointed by HL to CDE
;
; Used by the routines at FADD and _DBL_ASCTFP.
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
; Used by the routines at FADD and FPINT.
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
; This entry point is used by the routines at FADD and FPINT.
COMPL_0:
  LD B,$00
COMPL_1:
  SUB $08
  JP C,SHRITE
  LD B,E
  LD E,D
  LD D,C
  LD C,$00
  JP COMPL_1

; Shift right number in BCDE
;
; Used by the routine at COMPL.
SHRITE:
  ADD A,$09

; Scale number in BCDE for A exponent (bits)
SCALE:
  ADD HL,BC
  LD L,A
  LD A,D
  OR E
  OR B
  JP NZ,SCALE_1
  LD A,C
SCALE_0:
  DEC L
  RET Z
  RRA
  LD C,A
  JP NC,SCALE_0
  JP SCALE_3
SCALE_1:
  XOR A
  DEC L
  RET Z
  LD A,C
; This entry point is used by the routine at FADD.
SCALE_2:
  RRA
  LD C,A
SCALE_3:
  LD A,D
  RRA
  LD D,A
  LD A,E
  RRA
  LD E,A
  LD A,B
  RRA
  LD B,A
  JP SCALE_1
  NOP
  NOP
  NOP
  ADD A,C
  INC B
  SBC A,D
  RST TSTSGN
  ADD HL,DE
  ADD A,E
  INC H
  LD H,E
  LD B,E
  ADD A,E
  LD (HL),L
  CALL GET_DEVICE_685
  XOR C
  LD A,A
  ADD A,E
  ADD A,D
  INC B
  NOP
  NOP
  NOP
  ADD A,C
  JP PO,$4DB0
  ADD A,E
  LD A,(BC)
  LD (HL),D
  LD DE,$F483
  INC B
  DEC (HL)
  LD A,A

; LOG
;
; Used by the routine at POWER.
__LOG:
  RST TSTSGN
  OR A
  JP PE,FCERR
  CALL __LOG_0
  LD BC,$8031
  LD DE,$7218
  JP FMULT_BCDE
__LOG_0:
  CALL BCDEFP
  LD A,$80
  LD (FACCU),A
  XOR B
  PUSH AF
  CALL STAKI
  LD HL,$2FDA
  CALL EXP_5
  POP BC
  POP HL
  CALL STAKI
  EX DE,HL
  CALL FPBCDE
  LD HL,$2FEB
  CALL EXP_5
  POP BC
  POP DE
  CALL FDIV
  POP AF
  CALL STAKI
  CALL FLGREL
  POP BC
  POP DE
  JP FADD

; Multiply BCDE to FP reg
;
; Used by the routines at __LOG, IMULT, EXP and __RND.
FMULT_BCDE:
  RST TSTSGN
  RET Z
  LD L,$00
  CALL DIV_5
  LD A,C
  LD ($FB5E),A
  EX DE,HL
  LD ($FB5F),HL
  LD BC,$0000
  LD D,B
  LD E,B
  LD HL,BNORM
  PUSH HL
  LD HL,$3060
  PUSH HL
  PUSH HL
  LD HL,DBL_FPREG
  LD A,(HL)
  INC HL
  OR A
  JP Z,FMULT_BCDE_4
  PUSH HL
  LD L,$08
FMULT_BCDE_0:
  RRA
  LD H,A
  LD A,C
  JP NC,FMULT_BCDE_1
  PUSH HL
  LD HL,($FB5F)
  ADD HL,DE
  EX DE,HL
  POP HL
  LD A,($FB5E)
  ADC A,C
FMULT_BCDE_1:
  RRA
  LD C,A
  LD A,D
  RRA
  LD D,A
  LD A,E
  RRA
  LD E,A
  LD A,B
  RRA
  LD B,A
  AND $10
  JP Z,FMULT_BCDE_2
  LD A,B
  OR $20
  LD B,A
FMULT_BCDE_2:
  DEC L
  LD A,H
  JP NZ,FMULT_BCDE_0

; This entry point is used by the routines at DIV and SCPTLP.
POPHLRT:
  POP HL
  RET

FMULT_BCDE_4:
  LD B,E
  LD E,D
  LD D,C
  LD C,A
  RET

; Divide FP by 10
;
; Used by the routine at _DBL_ASCTFP.
DIV10:
  CALL STAKI
  LD HL,$3681
  CALL PHLTFP

; Divide FP by number on stack
;
; Used by the routines at EVAL4 and __TAN.
DIV:
  POP BC
  POP DE
; This entry point is used by the routines at __LOG and __POS.
FDIV:
  RST TSTSGN
  JP Z,OERR
  LD L,$FF
  CALL DIV_5
  INC (HL)
  JP Z,$057D
  INC (HL)
  JP Z,$057D
  DEC HL
  LD A,(HL)
  LD ($F41F),A
  DEC HL
  LD A,(HL)
  LD ($F41B),A
  DEC HL
  LD A,(HL)
  LD ($F417),A
  LD B,C
  EX DE,HL
  XOR A
  LD C,A
  LD D,A
  LD E,A
  LD ($F422),A
DIV_1:
  PUSH HL
  PUSH BC
  LD A,L
  CALL GET_DEVICE_712
  SBC A,$00
  CCF
  JP NC,$30E1
  LD ($F422),A
  POP AF
  POP AF
  SCF
  JP NC,GET_DEVICE_692
  LD A,C
  INC A
  DEC A
  RRA
  JP P,DIV_3
  RLA
  LD A,($F422)
  RRA
  AND $C0
  PUSH AF
  LD A,B
  OR H
  OR L
  JP Z,DIV_2
  LD A,' '
DIV_2:
  POP HL
  OR H
  JP BNORM_9

DIV_3:
  RLA
  LD A,E
  RLA
  LD E,A
  LD A,D
  RLA
  LD D,A
  LD A,C
  RLA
  LD C,A
  ADD HL,HL
  LD A,B
  RLA
  LD B,A
  LD A,($F422)
  RLA
  LD ($F422),A
  LD A,C
  OR D
  OR E
  JP NZ,DIV_1
  PUSH HL
  LD HL,FACCU
  DEC (HL)
  POP HL
  JP NZ,DIV_1
  JP CLEAR_EXPONENT

; This entry point is used by the routine at DECADD.
DIV_4:
  LD A,$FF
  ;LD L,$AF
	defb $2E		; LD L,nn  (mask the next "XOR" instruction)
	
; Routine at 12585
;
; Used by the routine at DBL_ADD.
L3129:
  XOR A
  LD HL,DBL_LAST_FPREG
  LD C,(HL)
  INC HL
  XOR (HL)
  LD B,A
  LD L,$00
; This entry point is used by the routine at FMULT_BCDE.
DIV_5:
  LD A,B
  OR A
  JP Z,DIV_8
  LD A,L
  LD HL,FACCU
  XOR (HL)
  ADD A,B
  LD B,A
  RRA
  XOR B
  LD A,B
  JP P,DIV_7
  ADD A,$80
  LD (HL),A
  JP Z,POPHLRT
  CALL LOADFP_5
  LD (HL),A
; This entry point is used by the routine at _DBL_ASCTFP.
DCXH_2:
  DEC HL
  RET

  RST TSTSGN
  CPL
  POP HL
DIV_7:
  OR A
DIV_8:
  POP HL
  JP P,CLEAR_EXPONENT
  JP $057D

; Multiply number in FPREG by 10
;
; Used by the routine at _DBL_ASCTFP.
MLSP10:
  CALL BCDEFP
  LD A,B
  OR A
  RET Z
  ADD A,$02
  JP C,$057D
  LD B,A
  CALL FADD
  LD HL,FACCU
  INC (HL)
  RET NZ
  JP $057D

; Test sign of FPREG
;
; Used by the routines at GETYPR, _TSTSGN and FCOMP.
TSTSGN:
  LD A,(FACCU)
  OR A
  RET Z
  LD A,(LAST_FPREG)
	DEFB $FE		;  CP 2Fh ..hides the "CPL" instruction
SGN_RESULT_CPL:
  CPL  
  ; --- START PROC L2E78 ---
SGN_RESULT:
  RLA

; This entry point is used by the routines at GETWORD and FCOMP.
ISZ_RESULT:
  SBC A,A
  RET NZ
  INC A
  RET

; CY and A to FP, & normalise
;
; Used by the routines at __LOG and _DBL_ASCTFP.
; CY and A to FP, & normalise
FLGREL:
  LD B,$88
  LD DE,$0000
; This entry point is used by the routines at HLPASS and DBL_ABS.
FLGREL_0:
  LD HL,FACCU
  LD C,A
  LD (HL),B
  LD B,$00
  INC HL
  LD (HL),$80
  RLA
  JP FADD_2

; ABS
__ABS:
  CALL _TSTSGN
  RET P
; This entry point is used by the routines at OPRND, FIX and _DBL_ASCTFP.
INVSGN:
  RST GETYPR 		; Get the number type (FAC)
  JP M,DBL_ABS
  JP Z,TMERR

; Invert number sign
;
; Used by the routines at FSUB, FIX, IMULT, POWER, __RND and __POS.
INVSGN:
  LD HL,LAST_FPREG
  LD A,(HL)
  XOR $80
  LD (HL),A
  RET
__SGN:
  CALL _TSTSGN

; Get back from function, result in A (signed)
;
; Used by the routines at UCASE and GETWORD.
INT_RESULT_A:
  LD L,A
  RLA
  SBC A,A
  LD H,A
  JP INT_RESULT_HL

; Test sign in number
;
; Used by the routines at __DATA, __ABS, INVSGN and _DBL_ASCTFP.
_TSTSGN:
  RST GETYPR 		; Get the number type (FAC)
  JP Z,TMERR
  JP P,TSTSGN
  LD HL,(DBL_FPREG)
; This entry point is used by the routine at __FOR.
_SGN_RESULT:
  LD A,H
  OR L
  RET Z
  LD A,H
  JP SGN_RESULT

; Put FP value on stack
;
; Used by the routines at EVAL4, FADD, __LOG, DIV10, MLDEBC, IMULT, _DBL_ASCTFP,
; __SQR, EXP, __RND and __TAN.
STAKI:
  EX DE,HL
  LD HL,(DBL_FPREG)
  EX (SP),HL
  PUSH HL
  LD HL,(LAST_FPREG)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  RET

; Number at HL to BCDE
;
; Used by the routines at DIV10, _DBL_ASCTFP, __SQR, EXP, __RND and CHKSTK.
PHLTFP:
  CALL LOADFP

; Move BCDE to FPREG
;
; Used by the routines at EVAL4, FADD, BNORM, __LOG, _DBL_ASCTFP, EXP and __TAN.
FPBCDE:
  EX DE,HL
  LD (DBL_FPREG),HL
  LD H,B
  LD L,C
  LD (LAST_FPREG),HL
  EX DE,HL
  RET

; Load FP reg to BCDE
;
; Used by the routines at __FOR, EVAL4, __LOG, MLSP10, FCOMP, FPINT, INT,
; _DBL_ASCTFP, POWER, EXP and __RND.
BCDEFP:
  LD HL,DBL_FPREG

; Load FP value pointed by HL to BCDE
;
; Used by the routines at TESTR, MIDNUM, PHLTFP, EXP, __RND and CHKSTK.
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
; This entry point is used by the routines at SNERR, MAKINT and _DBL_ASCTFP.
INCHL:
  INC HL
  RET
; This entry point is used by the routines at __RND and CHKSTK.
LOADFP_2:
  LD DE,DBL_FPREG
  LD B,$04
  JP REV_LDIR_B
  EX DE,HL
; This entry point is used by the routines at __DATA, TSTOPL, FCOMP, DECADD
; and _DBL_ASCTFP.
FP2HL:
  LD A,(VALTYP)
  LD B,A
; This entry point is used by the routines at __FOR, GETWORD and GET_DEVICE.
REV_LDIR_B:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC B
  JP NZ,REV_LDIR_B
  RET
  
; This entry point is used by the routines at FADD, DIV, FCOMP, FPINT, INT
; and DECADD.
LOADFP_5:
  LD HL,LAST_FPREG
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
  
; This entry point is used by the routine at DECADD.
LOADFP_6:
  LD HL,$FB2E
; This entry point is used by the routines at __FOR, OPRND, MIDNUM and _DBL_ASCTFP.
LOADFP_7:
  LD DE,$31F2
  JP INCHL0
  
; This entry point is used by the routines at EVAL4, MIDNUM, DECADD and
; _DBL_ASCTFP.
FP_ARG2HL:
  LD HL,$FB2E
; This entry point is used by the routine at _DBL_ASCTFP.
LOADFP_9:
  LD DE,FP2HL
INCHL0:
  PUSH DE
  LD DE,DBL_FPREG
  RST GETYPR 		; Get the number type (FAC)
  RET C
  LD DE,$FB24
  RET

; Compare FP reg to BCDE
;
; Used by the routines at _DBL_ASCTFP, POWER, __RND and CHKSTK.
FCOMP:
  LD A,B
  OR A
  JP Z,TSTSGN
  LD HL,SGN_RESULT_CPL
  PUSH HL
  RST TSTSGN
  LD A,C
  RET Z
  LD HL,LAST_FPREG
  XOR (HL)
  LD A,C
  RET M
  CALL FCOMP_1
  
XDCOMP_1:
  RRA
  XOR C
  RET

FCOMP_1:
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

; This entry point is used by the routine at CHKSTK.
ICOMP:
  LD A,D
  XOR H
  LD A,H
  JP M,SGN_RESULT
  CP D
  JP NZ,FCOMP_3
  LD A,L
  SUB E
  RET Z
FCOMP_3:
  JP ISZ_RESULT

; This entry point is used by the routine at _DBL_ASCTFP.
FCOMP_4:
  LD HL,$FB2E
  CALL FP2HL
XDCOMP:
  LD DE,ARG
  LD A,(DE)
  OR A
  JP Z,TSTSGN
  LD HL,SGN_RESULT_CPL		; SGN_RESULT_CPL
  PUSH HL
  RST TSTSGN
  DEC DE
  LD A,(DE)
  LD C,A
  RET Z
  LD HL,LAST_FPREG
  XOR (HL)
  LD A,C
  RET M
  INC DE
  INC HL
  LD B,$08
XDCOMP_2:
  LD A,(DE)
  SUB (HL)
  JP NZ,XDCOMP_1
  DEC DE
  DEC HL
  DEC B
  JP NZ,XDCOMP_2
  POP BC
  RET

; Routine at 12951
DECCOMP:
  CALL XDCOMP
  JP NZ,SGN_RESULT_CPL
  RET

; This entry point is used by the routines at __FOR, EVAL4, UCASE and DEPINT.
__CINT:
  RST GETYPR 		; Get the number type (FAC)
  LD HL,(DBL_FPREG)
  RET M
  JP Z,TMERR		; If string type, "Type mismatch"
  CALL NC,FCOMP_14
  LD HL,$057D
  PUSH HL
; This entry point is used by the routine at __INT.
FCOMP_7:
  LD A,(FACCU)
  CP $90
  JP NC,FCOMP_12
  CALL FPINT
  EX DE,HL
; This entry point is used by the routine at MLDEBC.
FCOMP_8:
  POP DE
; This entry point is used by the routines at UCASE, INT_RESULT_A, INT,
; IMULT, DBL_ASCTFP and _DBL_ASCTFP.
INT_RESULT_HL:
  LD (DBL_FPREG),HL
; This entry point is used by the routine at DBL_ABS.
SETTYPE_INT:
  LD A,$02		; Integer type
; This entry point is used by the routine at HLPASS.
SETTYPE:
  LD (VALTYP),A
  RET
  
; This entry point is used by the routine at _DBL_ASCTFP.
FCOMP_12:
  LD BC,$9080
  LD DE,$0000
  CALL FCOMP
  RET NZ
  LD H,C
  LD L,D
  JP FCOMP_8
  
; This entry point is used by the routines at __FOR, EVAL4, UCASE, GETWORD,
; _DBL_ASCTFP and POWER.
__CSNG:
  RST GETYPR 		; Get the number type (FAC)
  RET PO
  JP M,INT_CSNG
  JP Z,TMERR
FCOMP_14:
  CALL BCDEFP
  CALL $3310
  LD A,B
  OR A
  RET Z
  CALL LOADFP_5
  LD HL,$FB27
  LD B,(HL)
  JP BNORM_8

; This entry point is used by the routines at HLPASS and _DBL_ASCTFP.
INT_CSNG:
  LD HL,(DBL_FPREG)
; This entry point is used by the routines at EVAL4, MLDEBC and IMULT.
HL_CSNG:
  CALL $3310

; Get back from function passing an INT value HL
HLPASS:
  LD A,H
  LD D,L
  LD E,$00
  LD B,$90
  JP FLGREL_0

; This entry point is used by the routines at EVAL4, INT and _DBL_ASCTFP.
__CDBL:
  RST GETYPR 		; Get the number type (FAC)
  RET NC
  JP Z,TMERR
  CALL M,INT_CSNG
; This entry point is used by the routine at _DBL_ASCTFP.
ZERO_FACCU:
  LD HL,$0000
  LD ($FB24),HL
  LD ($FB26),HL
; This entry point is used by the routine at DBL_DBL_ASCTFP.
SETTYPE_DBL:
  LD A,$08
  LD BC,$043E
  JP SETTYPE

; Test a string, 'Type Error' if it is not
;
; Used by the routines at __DATA, UCASE, CONCAT, GETSTR, MIDNUM and SCPTLP.
TSTSTR:
  RST GETYPR 		; Get the number type (FAC)
  RET Z
  JP TMERR

; Floating Point to Integer
;
; Used by the routines at FCOMP, INT and _DBL_ASCTFP.
FPINT:
  LD B,A
  LD C,A
  LD D,A
  LD E,A
  OR A
  RET Z
  PUSH HL
  CALL BCDEFP
  CALL LOADFP_5
  XOR (HL)
  LD H,A
  CALL M,DCBCDE
  LD A,$98
  SUB B
  CALL COMPL_0
  LD A,H
  RLA
  CALL C,CLEAR_EXPONENT0
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
  DEC BC
  RET

; Double Precision to Integer conversion
FIX:
  RST GETYPR 		; Get the number type (FAC)
  RET M
  RST TSTSGN
  JP P,__INT
  CALL INVSGN
  CALL __INT
  JP INVSGN

; INT (double precision BASIC variant)
;
; Used by the routine at FIX.
__INT:
  RST GETYPR 		; Get the number type (FAC)
  RET M
  JP NC,INT_0
  JP Z,TMERR
  CALL FCOMP_7

; INT
;
; Used by the routines at POWER, EXP and __RND.
INT:
  LD HL,FACCU
  LD A,(HL)
  CP $98
  LD A,(DBL_FPREG)
  RET NC
  LD A,(HL)
  CALL FPINT
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
  LD HL,FACCU
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
  LD HL,$8000
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
; This entry point is used by the routine at _DBL_ASCTFP.
INT_4:
  PUSH AF
  CALL BCDEFP
  CALL LOADFP_5
  XOR (HL)
  DEC HL
  LD (HL),$B8
  PUSH AF
  DEC HL
  LD (HL),C
  CALL M,INT_5
  LD A,(LAST_FPREG)
  LD C,A
  LD HL,LAST_FPREG
  LD A,$B8
  SUB B
  CALL DECADD_22
  POP AF
  CALL M,DECADD_10
  XOR A
  LD ($FB23),A
  POP AF
  RET NC
  JP DECADD_3
INT_5:
  LD HL,$FB24
INT_6:
  LD A,(HL)
  DEC (HL)
  OR A
  INC HL
  JP Z,INT_6
  RET

; Multiply DE by BC
;
; Used by the routine at SCPTLP.
MLDEBC:
  PUSH HL
  LD HL,$0000
  LD A,B
  OR C
  JP Z,MLDEBC_2
  LD A,$10
MLDEBC_0:
  ADD HL,HL
  JP C,SBSCT_ERR
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,MLDEBC_1
  ADD HL,BC
  JP C,SBSCT_ERR
MLDEBC_1:
  DEC A
  JP NZ,MLDEBC_0
MLDEBC_2:
  EX DE,HL
  POP HL
  RET


; Routine at 13303
ISUB:
  LD A,H
  RLA
  SBC A,A
  LD B,A
  CALL INT_DIV_6
  LD A,C
  SBC A,B
  JP IADD_0
  
; This entry point is used by the routine at CHKSTK.
IADD:
  LD A,H
  RLA
  SBC A,A
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
  JP P,FCOMP_8
  PUSH BC
  EX DE,HL
  CALL HL_CSNG
  POP AF
  POP HL
  CALL STAKI
  EX DE,HL
  CALL DBL_ABS_1
  JP _DBL_ASCTFP_26

; Integer MULTIPLY
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
  JP C,L345B
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,IMULT_1
  ADD HL,BC
  JP C,L345B
IMULT_1:
  DEC A
  JP NZ,IMULT_0
  POP BC
  POP DE
IMULT_2:
  LD A,H
  OR A
  JP M,IMULT_3
  POP DE
  LD A,B
  JP INT_DIV_5

IMULT_3:
  XOR $80
  OR L
  JP Z,IMULT_4
  EX DE,HL
  LD BC,GET_DEVICE_692

; Routine at 13403
;
; Used by the routine at INT_MUL.
L345B:
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP FMULT_BCDE

IMULT_4:
  LD A,B
  OR A
  POP BC
  JP M,INT_RESULT_HL
  PUSH DE
  CALL HL_CSNG
  POP DE
  JP INVSGN
  
; This entry point is used by the routines at UCASE and DBL_ABS.
INT_DIV:
  LD A,H
  OR L
  JP Z,OERR   		; "Division by zero"
  CALL INT_DIV_3
  PUSH BC
  EX DE,HL
  CALL INT_DIV_6
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$11		; const
  PUSH AF
  OR A
  JP INT_DIV_2

INT_DIV_0:
  PUSH AF
  PUSH HL
  ADD HL,BC
  JP NC,INT_DIV_1
  POP AF
  SCF
  ;LD A,$E1
  DEFB $3E  ; "LD A,n" to Mask the next byte
  
INT_DIV_1:
  POP HL
INT_DIV_2:
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
  JP NZ,INT_DIV_0
  EX DE,HL
  POP BC
  PUSH DE
  JP IMULT_2

INT_DIV_3:
  LD A,H
  XOR D
  LD B,A
  CALL INT_DIV_4
  EX DE,HL
INT_DIV_4:
  LD A,H
; This entry point is used by the routine at DBL_ABS.
INT_DIV_5:
  OR A
  JP P,INT_RESULT_HL
; This entry point is used by the routines at MLDEBC and DBL_ABS.
INT_DIV_6:
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
; Used by the routine at __ABS.
DBL_ABS:
  LD HL,(DBL_FPREG)
  CALL INT_DIV_6
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at __FOR, OPRND and UCASE.
DBL_ABS_0:
  EX DE,HL
  CALL $3310
  XOR A
; This entry point is used by the routine at MLDEBC.
DBL_ABS_1:
  LD B,$98
  JP FLGREL_0

; This entry point is used by the routine at UCASE.
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
  JP INT_DIV_5

; aka DECSUB, Double precision SUB (formerly FSUB)
DECSUB:
  LD HL,DBL_LAST_FPREG
  LD A,(HL)
  XOR $80
  LD (HL),A

; aka DECADD, Double precision ADD (formerly FADD)
;
; Used by the routines at MIDNUM and _DBL_ASCTFP.
DECADD:
  LD HL,ARG
  LD A,(HL)
  OR A
  RET Z
  LD B,A
  DEC HL
  LD C,(HL)
  LD DE,FACCU
  LD A,(DE)
  OR A
  JP Z,LOADFP_6
  SUB B
  JP NC,DECADD_1
  CPL
  INC A
  PUSH AF
  LD C,$08		; DBL number, 8 bytes
  INC HL
  PUSH HL
DECADD_0:
  LD A,(DE)
  LD B,(HL)
  LD (HL),A
  LD A,B
  LD (DE),A
  DEC DE
  DEC HL
  DEC C
  JP NZ,DECADD_0
  POP HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  POP AF
DECADD_1:
  CP $39
  RET NC
  PUSH AF
  CALL LOADFP_5
  LD HL,$FB2D
  LD B,A
  LD A,$00
  LD (HL),A
  LD ($FB23),A
  POP AF
  LD HL,DBL_LAST_FPREG
  CALL DECADD_22
  LD A,B
  OR A
  JP P,DECADD_2
  LD A,($FB2D)
  LD ($FB23),A
  CALL DECADD_12
  JP NC,DECADD_8
  EX DE,HL
  INC (HL)
  JP Z,$057D
  CALL DECADD_31
  JP DECADD_8
DECADD_2:
  CALL DECADD_16
  LD HL,SGNRES
  CALL C,DECADD_20
; This entry point is used by the routine at INT.
DECADD_3:
  XOR A
DECADD_4:
  LD B,A
  LD A,(LAST_FPREG)
  OR A
  JP NZ,DECADD_7
  LD HL,$FB23
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
  JP CLEAR_EXPONENT
  
DECADD_6:
  DEC B
  LD HL,$FB23
  CALL DECADD_32
  OR A
DECADD_7:
  JP P,DECADD_6
  LD A,B
  OR A
  JP Z,DECADD_8
  LD HL,FACCU
  ADD A,(HL)
  LD (HL),A
  JP NC,CLEAR_EXPONENT
  RET Z
DECADD_8:
  LD A,($FB23)
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
  LD HL,$FB24
  LD B,$07
DECADD_11:
  INC (HL)
  RET NZ
  INC HL
  DEC B
  JP NZ,DECADD_11
  INC (HL)
  JP Z,$057D
  DEC HL
  LD (HL),$80
  RET
DECADD_12:
  LD HL,$FB2E
; This entry point is used by the routine at _DBL_ASCTFP.
DECADD_13:
  LD DE,$FB24
DECADD_14:
  LD C,$07
  XOR A
DECADD_15:
  LD A,(DE)
  ADC A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,DECADD_15
  RET
DECADD_16:
  LD HL,$FB2E
; This entry point is used by the routine at _DBL_ASCTFP.
DECADD_17:
  LD DE,$FB24
DECADD_18:
  LD C,$07
  XOR A
DECADD_19:
  LD A,(DE)
  SBC A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,DECADD_19
  RET
DECADD_20:
  LD A,(HL)
  CPL
  LD (HL),A
  LD HL,$FB23
  LD B,$08
  XOR A
  LD C,A
DECADD_21:
  LD A,C
  SBC A,(HL)
  LD (HL),A
  INC HL
  DEC B
  JP NZ,DECADD_21
  RET
; This entry point is used by the routine at INT.
DECADD_22:
  LD (HL),C
  PUSH HL
DECADD_23:
  SUB $08
  JP C,DECADD_27
  POP HL
DECADD_24:
  PUSH HL
  LD DE,$0800
DECADD_25:
  LD C,(HL)
  LD (HL),E
  LD E,C
DECADD_26:
  DEC HL
  DEC D
  JP NZ,DECADD_25
  JP DECADD_23
DECADD_27:
  ADD A,$09
  LD D,A
DECADD_28:
  XOR A
  POP HL
  DEC D
  RET Z
DECADD_29:
  PUSH HL
  LD E,$08
DECADD_30:
  LD A,(HL)
  RRA
  LD (HL),A
  DEC HL
  DEC E
  JP NZ,DECADD_30
  JP DECADD_28
DECADD_31:
  LD HL,LAST_FPREG
  LD D,$01
  JP DECADD_29
DECADD_32:
  LD C,$08
DECADD_33:
  LD A,(HL)
  RLA
  LD (HL),A
  INC HL
  DEC C
  JP NZ,DECADD_33
  RET
  
; This entry point is used by the routine at _DBL_ASCTFP.
DECMUL:
  RST TSTSGN
  RET Z
  LD A,(ARG)
  OR A
  JP Z,CLEAR_EXPONENT
  CALL L3129
  CALL DECADD_41
  LD (HL),C
  INC DE
  LD B,$07
DECADD_35:
  LD A,(DE)
  INC DE
  OR A
  PUSH DE
  JP Z,DECADD_38
  LD C,$08
DECADD_36:
  PUSH BC
  RRA
  LD B,A
  CALL C,DECADD_12
  CALL DECADD_31
  LD A,B
  POP BC
  DEC C
  JP NZ,DECADD_36
DECADD_37:
  POP DE
  DEC B
  JP NZ,DECADD_35
  JP DECADD_3
DECADD_38:
  LD HL,LAST_FPREG
  CALL DECADD_24
  JP DECADD_37
  CALL GET_DEVICE_689
  CALL Z,GET_DEVICE_689
  LD C,H
  LD A,L
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  JR NZ,DECADD_26
; This entry point is used by the routine at _DBL_ASCTFP.





DECADD_39:
  LD DE,$3675
  LD HL,$FB2E
  CALL FP2HL
  JP DECMUL

; Routine at 13969
DECDIV:
  LD A,(ARG)
  OR A
  JP Z,OERR
  LD A,(FACCU)
  OR A
  JP Z,CLEAR_EXPONENT
  CALL DIV_4
  INC (HL)
  INC (HL)
  JP Z,$057D
  CALL DECADD_41
  LD HL,$FB58
  LD (HL),C
  LD B,C
DECADD_40:
  LD DE,$FB51
  LD HL,$FB2E
  CALL DECADD_18
  LD A,(DE)
  SBC A,C
  CCF
  JP C,$36C9
  LD DE,$FB51
  LD HL,$FB2E
  CALL DECADD_14
  XOR A
  JP C,$0412
  LD A,(LAST_FPREG)
  INC A
  DEC A
  RRA
  JP M,DECADD_9
  RLA
  LD HL,$FB24
  LD C,$07
  CALL DECADD_33
  LD HL,$FB51
  CALL DECADD_32
  LD A,B
  OR A
  JP NZ,DECADD_40
  LD HL,FACCU
  DEC (HL)
  JP NZ,DECADD_40
  JP CLEAR_EXPONENT
  
DECADD_41:
  LD A,C
  LD (DBL_LAST_FPREG),A
  DEC HL
  LD DE,$FB57
  LD BC,$0700
DECADD_42:
  LD A,(HL)
  LD (DE),A
  LD (HL),C
  DEC DE
  DEC HL
  DEC B
  JP NZ,DECADD_42
  RET

; This entry point is used by the routine at _DBL_ASCTFP.
DECADD_43:
  CALL FP_ARG2HL
  EX DE,HL
  DEC HL
  LD A,(HL)
  OR A
  RET Z
  ADD A,$02
  JP C,$057D
  LD (HL),A
  PUSH HL
  CALL DECADD
  POP HL
  INC (HL)
  RET NZ
  JP $057D

; ASCII to Double precision FP number
;
; Used by the routines at __DATA, TOPOOL and SCPTLP.
DBL_DBL_ASCTFP:
  CALL CLEAR_EXPONENT
  CALL SETTYPE_DBL
  OR $AF

; ASCII to FP number (New version)
;
; Used by the routines at DETOKEN_MORE, __DATA, OPRND and SCPTLP.
DBL_ASCTFP:
  XOR A
  EX DE,HL
  LD BC,$00FF
  LD H,B
  LD L,B
  CALL Z,INT_RESULT_HL
  EX DE,HL
  LD A,(HL)

; ASCII to FP number
_DBL_ASCTFP:
  CP '-'
  PUSH AF
  JP Z,_DBL_ASCTFP_0
  CP '+'
  JP Z,_DBL_ASCTFP_0
  DEC HL
_DBL_ASCTFP_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,_DBL_ASCTFP_18
  CP '.'
  JP Z,_DBL_ASCTFP_9
  CP $65
  JP Z,_DBL_ASCTFP_1
  CP 'E'
_DBL_ASCTFP_1:
  JP NZ,_DBL_ASCTFP_4
  PUSH HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP $6C
  JP Z,_DBL_ASCTFP_2
  CP $4C
  JP Z,_DBL_ASCTFP_2
  CP $71
  JP Z,_DBL_ASCTFP_2
  CP $51
_DBL_ASCTFP_2:
  POP HL
  JP Z,_DBL_ASCTFP_3
  LD A,(VALTYP)
  CP $08
  JP Z,_DBL_ASCTFP_5
  LD A,$00
  JP _DBL_ASCTFP_5
_DBL_ASCTFP_3:
  LD A,(HL)
_DBL_ASCTFP_4:
  CP '%'
  JP Z,_DBL_ASCTFP_10
  CP '#'
  JP Z,_DBL_ASCTFP_11
  CP '!'
  JP Z,_DBL_ASCTFP_12
  CP $64
  JP Z,_DBL_ASCTFP_5
  CP 'D'
  JP NZ,_DBL_ASCTFP_7
_DBL_ASCTFP_5:
  OR A
  CALL _DBL_ASCTFP_13
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL UCASE_5
_DBL_ASCTFP_6:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,_DBL_ASCTFP_27
  INC D
  JP NZ,_DBL_ASCTFP_7
  XOR A
  SUB E
  LD E,A
_DBL_ASCTFP_7:
  PUSH HL
  LD A,E
  SUB B
  LD E,A
_DBL_ASCTFP_8:
  CALL P,_DBL_ASCTFP_14
  CALL M,_DBL_ASCTFP_17
  JP NZ,_DBL_ASCTFP_8
  POP HL
  POP AF
  PUSH HL
  CALL Z,INVSGN
  POP HL
  RST GETYPR 		; Get the number type (FAC)
  RET PE
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  CALL FCOMP_12
  RET
_DBL_ASCTFP_9:
  RST GETYPR 		; Get the number type (FAC)
  INC C
  JP NZ,_DBL_ASCTFP_7
  CALL C,_DBL_ASCTFP_13
  JP _DBL_ASCTFP_0
_DBL_ASCTFP_10:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  PUSH AF
  JP _DBL_ASCTFP_7
_DBL_ASCTFP_11:
  OR A
_DBL_ASCTFP_12:
  CALL _DBL_ASCTFP_13
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP _DBL_ASCTFP_7
_DBL_ASCTFP_13:
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

_DBL_ASCTFP_14:
  RET Z
_DBL_ASCTFP_15:
  PUSH AF
  RST GETYPR 		; Get the number type (FAC)
  PUSH AF
  CALL PO,MLSP10
  POP AF
  CALL PE,DECADD_43
  POP AF
DCR_A:
  DEC A
  RET
  
_DBL_ASCTFP_17:
  PUSH DE
  PUSH HL
  PUSH AF
  RST GETYPR 		; Get the number type (FAC)
  PUSH AF
  CALL PO,DIV10
  POP AF
  CALL PE,DECADD_39
  POP AF
  POP HL
  POP DE
  INC A
  RET
  
_DBL_ASCTFP_18:
  PUSH DE
  LD A,B
  ADC A,C
  LD B,A
  PUSH BC
  PUSH HL
  LD A,(HL)
  SUB $30	; '0'
  PUSH AF
  RST GETYPR 		; Get the number type (FAC)
  JP P,_DBL_ASCTFP_22
  LD HL,(DBL_FPREG)
  LD DE,$0CCD		; const
  RST CPDEHL
  JP NC,_DBL_ASCTFP_21
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
  JP M,_DBL_ASCTFP_20
  LD (DBL_FPREG),HL

_DBL_ASCTFP_19:
  POP HL
  POP BC
  POP DE
  JP _DBL_ASCTFP_0

_DBL_ASCTFP_20:
  LD A,C
  PUSH AF
_DBL_ASCTFP_21:
  CALL INT_CSNG
  SCF
_DBL_ASCTFP_22:
  JP NC,_DBL_ASCTFP_24
  LD BC,$9474
  LD DE,$2400
  CALL FCOMP
  JP P,_DBL_ASCTFP_23
  CALL MLSP10
  POP AF
  CALL _DBL_ASCTFP_25
  JP _DBL_ASCTFP_19

_DBL_ASCTFP_23:
  CALL ZERO_FACCU
_DBL_ASCTFP_24:
  CALL DECADD_43
  CALL FP_ARG2HL
  POP AF
  CALL FLGREL
  CALL ZERO_FACCU
  CALL DECADD
  JP _DBL_ASCTFP_19

_DBL_ASCTFP_25:
  CALL STAKI
  CALL FLGREL
; This entry point is used by the routine at MLDEBC.
_DBL_ASCTFP_26:
  POP BC
  POP DE
  JP FADD
_DBL_ASCTFP_27:
  LD A,E
  CP $0A
  JP NC,$388B
  RLCA
  RLCA
  ADD A,E
  RLCA
  ADD A,(HL)
  SUB $30
  LD E,A
  JP M,$7F1E
  JP _DBL_ASCTFP_6
  
; This entry point is used by the routines at SNERR and GETWORD.
LNUM_MSG:
  PUSH HL
  LD HL,IN_MSG
  CALL PRS
  POP HL

; Print HL in ASCII form at the current cursor position
;
; Used by the routines at __LIST, PRPARM and FREEMEM.
NUMPRT:
  LD BC,PRNUMS
  PUSH BC
  CALL INT_RESULT_HL
  XOR A
  CALL NUMPRT_SUB
  OR (HL)
  JP PUFOUT_1
  
; This entry point is used by the routines at __DATA, MAKINT and __INP.
FOUT:
  XOR A
  
; This entry point is used by the routine at SCPTLP.
; Convert number/expression to string ("PRINT USING" format specified in 'A' register)
FOUT_0:
  CALL NUMPRT_SUB

; Convert the binary number in FAC1 to ASCII.  A - Bit configuration for PRINT
; USING options
PUFOUT:
  AND $08
  JP Z,PUFOUT_0
  LD (HL),'+'
PUFOUT_0:
  EX DE,HL
  CALL _TSTSGN
  EX DE,HL
  JP P,PUFOUT_1
  LD (HL),'-'
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H
PUFOUT_1:
  INC HL
  LD (HL),'0'
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,_DBL_ASCTFP_48
  JP Z,_DBL_ASCTFP_46
  CP $04
  JP NC,_DBL_ASCTFP_40
  LD BC,$0000
  CALL _DBL_ASCTFP_105
  
_DBL_ASCTFP_34:
  LD HL,FBUFFR+1
  LD B,(HL)
  LD C,$20
  LD A,(TEMP3)
  LD E,A
  AND $20			; bit 5 - Asterisks fill  
  JP Z,_DBL_ASCTFP_35
  LD A,B
  CP C
  LD C,'*'
  JP NZ,_DBL_ASCTFP_35
  LD A,E
  AND $04
  JP NZ,_DBL_ASCTFP_35
  LD B,C
_DBL_ASCTFP_35:
  LD (HL),C
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,_DBL_ASCTFP_36
  CP 'E'
  JP Z,_DBL_ASCTFP_36
  CP 'D'
  JP Z,_DBL_ASCTFP_36
  CP '0'
  JP Z,_DBL_ASCTFP_35
  CP ','
  JP Z,_DBL_ASCTFP_35
  CP '.'
  JP NZ,_DBL_ASCTFP_37
_DBL_ASCTFP_36:
  DEC HL
  LD (HL),'0'
_DBL_ASCTFP_37:
  LD A,E
  AND $10
  JP Z,_DBL_ASCTFP_38
  DEC HL
  LD (HL),$5C
_DBL_ASCTFP_38:
  LD A,E
  AND $04
  RET NZ
  DEC HL
  LD (HL),B
  RET
  
NUMPRT_SUB:
  LD (TEMP3),A
  LD HL,FBUFFR+1
  LD (HL),' '
  RET

_DBL_ASCTFP_40:
  CP $05
  PUSH HL
  SBC A,$00
  RLA
  LD D,A
  INC D
  CALL _DBL_ASCTFP_76
  LD BC,$0300
  ADD A,D
  JP M,_DBL_ASCTFP_41
  INC D
  CP D
  JP NC,_DBL_ASCTFP_41
  INC A
  LD B,A
  LD A,$02
_DBL_ASCTFP_41:
  SUB $02
  POP HL
  PUSH AF
  CALL _DBL_ASCTFP_95
  LD (HL),'0'
  CALL Z,INCHL
  CALL _DBL_ASCTFP_98
SUPTLZ:
  DEC HL
  LD A,(HL)
  CP '0'
  JP Z,SUPTLZ
  CP '.'
  CALL NZ,INCHL
  POP AF
  JP Z,NOENED

_DBL_ASCTFP_43:
  PUSH AF
  RST GETYPR 		; Get the number type (FAC)
  LD A,$22
  ADC A,A
  LD (HL),A
  INC HL
  POP AF
  LD (HL),'+'
  JP P,OUTEXP
  LD (HL),'-'
  CPL
  INC A
OUTEXP:
  LD B,'0'-1  ; $2F, '/'
EXPTEN:
  INC B
  SUB 10
  JP NC,EXPTEN
  ADD A,'0'+10
  INC HL
  LD (HL),B
  INC HL
  LD (HL),A
_DBL_ASCTFP_46:
  INC HL
NOENED:
  LD (HL),$00
  EX DE,HL
  LD HL,FBUFFR+1
  RET

_DBL_ASCTFP_48:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,_DBL_ASCTFP_55
  RRA
  JP C,_DBL_ASCTFP_65
  LD BC,$0603		; const
  CALL _DBL_ASCTFP_94
  POP DE
  LD A,D
  SUB $05
  CALL P,_DBL_ASCTFP_87
  CALL _DBL_ASCTFP_105
_DBL_ASCTFP_49:
  LD A,E
  OR A
  CALL Z,DCXH_2
  DEC A
  CALL P,_DBL_ASCTFP_87
_DBL_ASCTFP_50:
  PUSH HL
  CALL _DBL_ASCTFP_34
  POP HL
  JP Z,_DBL_ASCTFP_51
  LD (HL),B
  INC HL
_DBL_ASCTFP_51:
  LD (HL),$00
  LD HL,FBUFFR
_DBL_ASCTFP_52:
  INC HL
_DBL_ASCTFP_53:
  LD A,(TEMP2)
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP ' '
  JP Z,_DBL_ASCTFP_52
  CP '*'
  JP Z,_DBL_ASCTFP_52
  DEC HL
  PUSH HL
  PUSH AF
  LD BC,$39E0
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '-'
  RET Z
  CP '+'
  RET Z
  CP $5C  	;'\'
  RET Z
  POP BC
  CP '0'
  JP NZ,_DBL_ASCTFP_54
  INC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NC,_DBL_ASCTFP_54
  DEC HL
  LD BC,$772B
  POP AF
  JP Z,$39FC
  POP BC
  JP _DBL_ASCTFP_53
_DBL_ASCTFP_54:
  POP AF
  JP Z,_DBL_ASCTFP_54
  POP HL
  LD (HL),$25
  RET
_DBL_ASCTFP_55:
  PUSH HL
  RRA
  JP C,_DBL_ASCTFP_66
  JP Z,_DBL_ASCTFP_57
  LD DE,$3CEA
  CALL FCOMP_4
  LD D,$10
  JP M,_DBL_ASCTFP_58
_DBL_ASCTFP_56:
  POP HL
  POP BC
  CALL FOUT
  DEC HL
  LD (HL),$25
  RET
_DBL_ASCTFP_57:
  LD BC,$B60E
  LD DE,$1BCA
  CALL FCOMP
  JP P,_DBL_ASCTFP_56
  LD D,$06
_DBL_ASCTFP_58:
  RST TSTSGN
  CALL NZ,_DBL_ASCTFP_76
  POP HL
  POP BC
  JP M,_DBL_ASCTFP_59
  PUSH BC
  LD E,A
  LD A,B
  SUB D
  SUB E
  CALL P,_DBL_ASCTFP_87
  CALL _DBL_ASCTFP_92
  CALL _DBL_ASCTFP_98
  OR E
  CALL NZ,_DBL_ASCTFP_91
  OR E
  CALL NZ,_DBL_ASCTFP_95
  POP DE
  JP _DBL_ASCTFP_49

_DBL_ASCTFP_59:
  LD E,A
  LD A,C
  OR A
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,E
  JP M,_DBL_ASCTFP_60
  XOR A
_DBL_ASCTFP_60:
  PUSH BC
  PUSH AF
_DBL_ASCTFP_61:
  CALL M,_DBL_ASCTFP_17
  JP M,_DBL_ASCTFP_61
  POP BC
  LD A,E
  SUB B
  POP BC
  LD E,A
  ADD A,D
  LD A,B
  JP M,_DBL_ASCTFP_62
  SUB D
  SUB E
  CALL P,_DBL_ASCTFP_87
  PUSH BC
  CALL _DBL_ASCTFP_92
  JP _DBL_ASCTFP_63
_DBL_ASCTFP_62:
  CALL _DBL_ASCTFP_87
  LD A,C
  CALL _DBL_ASCTFP_96
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL _DBL_ASCTFP_87
  PUSH BC
  LD B,A
  LD C,A
_DBL_ASCTFP_63:
  CALL _DBL_ASCTFP_98
  POP BC
  OR C
  JP NZ,_DBL_ASCTFP_64
  LD HL,(TEMP2)				; NXTOPR on MSX
_DBL_ASCTFP_64:
  ADD A,E
  DEC A
  CALL P,_DBL_ASCTFP_87
  LD D,B
  JP _DBL_ASCTFP_50
  
_DBL_ASCTFP_65:
  PUSH HL
  PUSH DE
  CALL INT_CSNG
  POP DE
  XOR A
_DBL_ASCTFP_66:
  JP Z,L3AB6
  LD E,$10
  defb $01	; LD BC,NN
  ;LD BC,$061E

; Routine at 15030
;
; Used by the routine at _ASCTFP.
L3AB6:
  LD E,$06
  RST TSTSGN
  SCF
  CALL NZ,_DBL_ASCTFP_76
  POP HL
  POP BC
  PUSH AF
  LD A,C
  OR A
  PUSH AF
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,B
  LD C,A
  XOR A
  OR B
  JP Z,_DBL_ASCTFP_67
  LD A,D
  AND $04
  CP $01
  SBC A,A
_DBL_ASCTFP_67:
  LD D,A
  ADD A,C
  LD C,A
  SUB E
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  PUSH AF
_DBL_ASCTFP_68:
  CALL M,_DBL_ASCTFP_17
  JP M,_DBL_ASCTFP_68
  XOR A
  LD ($FB1A),A
  LD HL,$FB1B
  CALL LOADFP_9
  RST GETYPR 		; Get the number type (FAC)
  JP PE,_DBL_ASCTFP_69
  CALL MIDNUM_8
  LD A,$FA
  JP _DBL_ASCTFP_70
_DBL_ASCTFP_69:
  CALL MIDNUM_7
  LD A,$F0
_DBL_ASCTFP_70:
  POP DE
  SUB D
_DBL_ASCTFP_71:
  CALL M,_DBL_ASCTFP_17
  JP M,_DBL_ASCTFP_71
  LD A,(FACCU)
  SUB $81
  PUSH AF
  LD HL,$FB1B
  CALL LOADFP_7
  POP AF
  JP M,_DBL_ASCTFP_72
  LD A,$01
  LD ($FB1A),A
  CALL _DBL_ASCTFP_17
_DBL_ASCTFP_72:
  POP HL
  POP DE
  POP BC
  POP AF
  PUSH BC
  PUSH AF
  JP M,_DBL_ASCTFP_73
  XOR A
_DBL_ASCTFP_73:
  CPL
  INC A
  ADD A,B
  INC A
  ADD A,D
  LD B,A
  LD C,$00
  CALL _DBL_ASCTFP_98
  POP AF
  CALL P,_DBL_ASCTFP_89
  CALL _DBL_ASCTFP_95
  POP BC
  POP AF
  JP NZ,_DBL_ASCTFP_74
  CALL DCXH_2
  LD A,(HL)
  CP '.'
  CALL NZ,INCHL
  LD (TEMP2),HL
_DBL_ASCTFP_74:
  POP AF
  JP C,_DBL_ASCTFP_75
  ADD A,E
  SUB B
  SUB D
_DBL_ASCTFP_75:
  PUSH BC
  LD B,A
  LD A,($FB1A)
  ADD A,B
  CALL _DBL_ASCTFP_43
  EX DE,HL
  POP DE
  JP _DBL_ASCTFP_50
  
_DBL_ASCTFP_76:
  PUSH DE
  XOR A
  PUSH AF
  RST GETYPR 		; Get the number type (FAC)
  JP PO,_DBL_ASCTFP_78
_DBL_ASCTFP_77:
  LD A,(FACCU)
  CP $91		; TK_PRINT
  JP NC,_DBL_ASCTFP_78
  LD DE,$3CCA
  LD HL,$FB2E
  CALL FP2HL
  CALL DECMUL
  POP AF
  SUB $0A
  PUSH AF
  JP _DBL_ASCTFP_77
_DBL_ASCTFP_78:
  CALL _DBL_ASCTFP_84
_DBL_ASCTFP_79:
  RST GETYPR 		; Get the number type (FAC)
  JP PE,_DBL_ASCTFP_80
  LD BC,$9143
  LD DE,$4FF9
  CALL FCOMP
  JP _DBL_ASCTFP_81
_DBL_ASCTFP_80:
  LD DE,$3CD2
  CALL FCOMP_4
_DBL_ASCTFP_81:
  JP P,_DBL_ASCTFP_83
  POP AF
  CALL _DBL_ASCTFP_15
  PUSH AF
  JP _DBL_ASCTFP_79
_DBL_ASCTFP_82:
  POP AF
  CALL _DBL_ASCTFP_17
  PUSH AF
  CALL _DBL_ASCTFP_84
_DBL_ASCTFP_83:
  POP AF
  OR A
  POP DE
  RET

_DBL_ASCTFP_84:
  RST GETYPR 		; Get the number type (FAC)
  JP PE,_DBL_ASCTFP_85
  LD BC,$9474
  LD DE,$23F8
  CALL FCOMP
  JP _DBL_ASCTFP_86

_DBL_ASCTFP_85:
  LD DE,$3CDA
  CALL FCOMP_4
_DBL_ASCTFP_86:
  POP HL
  JP P,_DBL_ASCTFP_82
  JP (HL)

_DBL_ASCTFP_87:
  OR A
_DBL_ASCTFP_88:
  RET Z
  DEC A
  LD (HL),'0'
  INC HL
  JP _DBL_ASCTFP_88
_DBL_ASCTFP_89:
  JP NZ,_DBL_ASCTFP_91
_DBL_ASCTFP_90:
  RET Z
  CALL _DBL_ASCTFP_95
_DBL_ASCTFP_91:
  LD (HL),'0'
  INC HL
  DEC A
  JP _DBL_ASCTFP_90
_DBL_ASCTFP_92:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
_DBL_ASCTFP_93:
  SUB $03
  JP NC,_DBL_ASCTFP_93
  ADD A,$05
  LD C,A
_DBL_ASCTFP_94:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET
_DBL_ASCTFP_95:
  DEC B
  JP NZ,_DBL_ASCTFP_97
_DBL_ASCTFP_96:
  LD (HL),$2E
  LD (TEMP2),HL
  INC HL
  LD C,B
  RET
_DBL_ASCTFP_97:
  DEC C
  RET NZ
  LD (HL),$2C
  INC HL
  LD C,$03
  RET
_DBL_ASCTFP_98:
  PUSH DE
  PUSH BC
  PUSH HL
  RST GETYPR 		; Get the number type (FAC)
  JP PO,_DBL_ASCTFP_101
  CALL MIDNUM_7
  XOR A
  CALL INT_4
  POP HL
  POP BC
  LD DE,$3CF2
  LD A,$0A
_DBL_ASCTFP_99:
  CALL _DBL_ASCTFP_95
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  LD B,$2F
_DBL_ASCTFP_100:
  INC B
  POP HL
  PUSH HL
  CALL DECADD_17
  JP NC,_DBL_ASCTFP_100
  POP HL
  CALL DECADD_13
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,_DBL_ASCTFP_99
  PUSH BC
  PUSH HL
  LD HL,$FB24
  CALL PHLTFP
  JP _DBL_ASCTFP_102
_DBL_ASCTFP_101:
  CALL MIDNUM_8
  LD A,$01
  CALL FPINT
  CALL FPBCDE
_DBL_ASCTFP_102:
  POP HL
  POP BC
  XOR A
  LD DE,$3D38
_DBL_ASCTFP_103:
  CCF
  CALL _DBL_ASCTFP_95
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  CALL BCDEFP
  POP HL
  LD B,$2F
_DBL_ASCTFP_104:
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
  JP NC,_DBL_ASCTFP_104
  CALL PLUCDE
  INC HL
  CALL FPBCDE
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  JP C,_DBL_ASCTFP_103
  INC DE
  INC DE
  LD A,$04
  JP _DBL_ASCTFP_106

_DBL_ASCTFP_105:
  PUSH DE
  LD DE,$3D3E
  LD A,$05
_DBL_ASCTFP_106:
  CALL _DBL_ASCTFP_95
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
  LD HL,(DBL_FPREG)
  LD B,$2F
_DBL_ASCTFP_107:
  INC B
  LD A,L
  SUB E
_DBL_ASCTFP_108:
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP NC,_DBL_ASCTFP_107
  ADD HL,DE
  LD (DBL_FPREG),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,_DBL_ASCTFP_106
  CALL _DBL_ASCTFP_95
  LD (HL),A
  POP DE
  RET
  NOP
  NOP
  NOP
  NOP
  LD SP,HL
  LD (BC),A
  DEC D
  AND D
  POP HL
  RST $38
  SBC A,A
  LD SP,$5FA9
  LD H,E
  OR D
  CP $FF
  INC BC
  CP A
  RET
  DEC DE
  LD C,$B6
  NOP
  NOP
  NOP
  NOP

HALF:
  NOP
  NOP
  NOP
  ADD A,B
  NOP
  NOP
  INC B
  CP A
  RET
  DEC DE
  LD C,$B6
  NOP
  ADD A,B
  ADD A,$A4
  LD A,(HL)
  ADC A,L
  INC BC
  NOP
  LD B,B
  LD A,D
  DJNZ $3CF1
  LD E,D
  NOP
  NOP
  AND B
  LD (HL),D
  LD C,(HL)
  JR _DBL_ASCTFP_109
  NOP
  NOP
  DJNZ _DBL_ASCTFP_108
  CALL NC,FNCTAB_0
  NOP
  NOP
_DBL_ASCTFP_109:
  RET PE
  HALT
  LD C,B
  RLA
  NOP
  NOP
  NOP
  CALL PO,GET_DEVICE_15
  LD (BC),A
  NOP
  NOP
  NOP
  JP Z,_DBL_ASCTFP_81
  NOP
  NOP
  NOP
  NOP
  POP HL
  PUSH AF
  DEC B
  NOP
  NOP
  NOP
  ADD A,B
  SUB (HL)
  SBC A,B
  NOP
  NOP
  NOP
  NOP
  LD B,B
  LD B,D
  RRCA
  NOP
  NOP
  NOP
  NOP
  AND B
  ADD A,(HL)
  LD BC,$2710
  NOP
  DJNZ POWER_1
  RET PE
  INC BC
  LD H,H
  NOP
  LD A,(BC)
  NOP
  LD BC,$2100

; Negate number
;
; Used by the routines at POWER and __POS.
NEGAFT:
  LD HL,INVSGN
  EX (SP),HL
  JP (HL)

; SQR
__SQR:
  CALL STAKI
  LD HL,HALF
  CALL PHLTFP
  JP POWER_0

; POWER
POWER:
  CALL __CSNG
; This entry point is used by the routine at __SQR.
POWER_0:
  POP BC
  POP DE
  RST TSTSGN
  LD A,B
  JP Z,__EXP
  JP P,POWER_2
  OR A
; This entry point is used by the routine at _DBL_ASCTFP.
POWER_1:
  JP Z,OERR
POWER_2:
  OR A
  JP Z,SET_EXPONENT
  PUSH DE
  PUSH BC
  LD A,C
  OR $7F
  CALL BCDEFP
  JP P,POWER_4
  PUSH AF
  LD A,(FACCU)
  CP $99
  JP C,POWER_3
  POP AF
  JP POWER_4
POWER_3:
  POP AF
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
POWER_4:
  POP HL
  LD (LAST_FPREG),HL
  POP HL
  LD (DBL_FPREG),HL
  CALL C,NEGAFT
  CALL Z,INVSGN
  PUSH DE
  PUSH BC
  CALL __LOG
  POP BC
  POP DE

; EXP
EXP:
  CALL FMULT_BCDE
; This entry point is used by the routine at POWER.
__EXP:
  LD BC,$8138
  LD DE,$AA3B
  CALL FMULT_BCDE
  LD A,(FACCU)
  CP $88
  JP NC,EXP_0
  CP $68
  JP C,EXP_3
  CALL STAKI
  CALL INT
  ADD A,$81
  JP Z,EXP_1
  POP BC
  POP DE
  PUSH AF
  CALL FSUB
  LD HL,$3DFD
  CALL EXP_5
  POP BC
  LD DE,$0000
  LD C,D
  JP FMULT_BCDE

EXP_0:
  CALL STAKI
EXP_1:
  LD A,(LAST_FPREG)
  OR A
  JP P,EXP_2
  POP AF
  POP AF
  JP CLEAR_EXPONENT
  
EXP_2:
  JP $057D
EXP_3:
  LD BC,$8100
  LD DE,$0000
  JP FPBCDE
  RLCA
  LD A,H
  ADC A,B
  LD E,C
  LD (HL),H
  RET PO
  SUB A
  LD H,$77
  CALL NZ,GETWORD_121
  LD A,D
  LD E,(HL)
  LD D,B
  LD H,E
  LD A,H
  LD A,(DE)
  CP $75
  LD A,(HL)
  JR $3E86
  LD SP,$0080
  NOP
  NOP
  ADD A,C
; This entry point is used by the routines at __RND and __POS.
EXP_4:
  CALL STAKI
  LD DE,$3467
  PUSH DE
  PUSH HL
  CALL BCDEFP
  CALL FMULT_BCDE
  POP HL

; This entry point is used by the routine at __LOG.
EXP_5:
  CALL STAKI
  LD A,(HL)
  INC HL
  CALL PHLTFP
; Routine at 15922
L3E32:
  LD B,$F1		; POP	AF
  POP BC
  POP DE
  DEC A
  RET Z
  PUSH DE
  PUSH BC
  PUSH AF
  PUSH HL
  CALL FMULT_BCDE
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FADD
  POP HL
  JP L3E32

; RND
__RND:
  RST TSTSGN
  LD HL,RNDX
  JP M,__RND_3
  LD HL,HOLD
  CALL PHLTFP
  LD HL,RNDX
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
  CALL FMULT_BCDE
  LD A,(RNDX-1)
  INC A
  AND $03
  LD B,$00
  CP $01
  ADC A,B
  LD (RNDX-1),A
  LD HL,L3EAD
  ADD A,A
  ADD A,A
  LD C,A
  ADD HL,BC
  CALL MIDNUM_9
__RND_0:
  CALL BCDEFP
  LD A,E
  LD E,C
  XOR $4F
  LD C,A
__RND_1:
  LD (HL),$80
  DEC HL
  LD B,(HL)
  LD (HL),$80
  LD HL,RNDX-2
  INC (HL)
  LD A,(HL)
  SUB $AB
  JP NZ,__RND_2
  LD (HL),A
  INC C
  DEC D
  INC E
__RND_2:
  CALL BNORM
  LD HL,HOLD
  JP LOADFP_2
__RND_3:
  LD (HL),A
  DEC HL
  LD (HL),A
  DEC HL
; Routine at 16045
L3EAD:
  LD (HL),A
  JP __RND_0

  LD L,B
  OR C
  LD B,(HL)
  LD L,B
  SBC A,C
  JP (HL)

  SUB D
  LD L,C
  DJNZ __RND_1
  LD (HL),L
  LD L,B

; This entry point is used by the routine at __TAN.
__COS:
  LD HL,$3F41
  CALL MIDNUM_9
; This entry point is used by the routine at __TAN.
__SIN:
  LD A,(FACCU)
  CP $77
  RET C
  LD A,(LAST_FPREG)
  OR A
  JP P,__RND_4
  AND $7F
  LD (LAST_FPREG),A
  LD DE,INVSGN
  PUSH DE
__RND_4:
  LD BC,$7E22
  LD DE,$F983
  CALL FMULT_BCDE
  CALL STAKI
  CALL INT
  POP BC
  POP DE
  CALL FSUB
  LD BC,$7F00
  LD DE,$0000
  CALL FCOMP
  JP M,__RND_5
  LD BC,$7F80
  LD DE,$0000
  CALL FADD
  LD BC,$8080
  LD DE,$0000
  CALL FADD
  RST TSTSGN
  CALL P,INVSGN
  LD BC,$7F00
  LD DE,$0000
  CALL FADD
  CALL INVSGN
__RND_5:
  LD A,(LAST_FPREG)
  OR A
  PUSH AF
  JP P,__RND_6
  XOR $80
  LD (LAST_FPREG),A
__RND_6:
  LD HL,$3F49
  CALL EXP_4
  POP AF
  RET P
  LD A,(LAST_FPREG)
  XOR $80
  LD (LAST_FPREG),A
  RET
  NOP
  NOP
  NOP
  NOP
  ADD A,E
  LD SP,HL
  LD ($DB7E),HL
  RRCA
  LD C,C
  ADD A,C
  NOP
  NOP
  NOP
  LD A,A
  DEC B
  EI
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD E,$86
  LD H,L
  LD H,$99
  ADD A,A
  LD E,B
  INC (HL)
  INC HL
  ADD A,A
  POP HL
  LD E,L
  AND L
  ADD A,(HL)
  IN A,($0F)
  LD C,C
  ADD A,E

; TAN
__TAN:
  CALL STAKI
  CALL __SIN
  POP BC
  POP HL
  CALL STAKI
  EX DE,HL
  CALL FPBCDE
  CALL __COS
  JP DIV

; ATN
__POS:
  RST TSTSGN
  CALL M,NEGAFT
  CALL M,INVSGN
  LD A,(FACCU)
  CP $81
  JP C,__POS_0
  LD BC,$8100
  LD D,C
  LD E,C
  CALL FDIV
  LD HL,$2EC1
  PUSH HL
__POS_0:
  LD HL,$3F98
  CALL EXP_4
  LD HL,$3F41
  RET
  ADD HL,BC
  LD C,D
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  DEC SP
  LD A,B
  LD (BC),A
  LD L,(HL)
  ADD A,H
  LD A,E
  CP $C1
  CPL
  LD A,H
  LD (HL),H
  LD SP,$7D9A
  ADD A,H
  DEC A
  LD E,D
  LD A,L
  RET Z
  LD A,A
  SUB C
  LD A,(HL)
  CALL PO,$4CBB
  LD A,(HL)
  LD L,H
  XOR D
  XOR D
  LD A,A
  NOP
  NOP
  NOP
  ADD A,C
; This entry point is used by the routines at SNERR and GETVAR.
__POS_1:
  CALL $3FD5
; This entry point is used by the routine at TESTR.
__POS_2:
  PUSH BC
  EX (SP),HL
  POP BC
__POS_3:
  RST CPDEHL
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JP __POS_3

; Check for C levels of stack
;
; Used by the routines at __FOR, EVAL1 and SCPTLP.
CHKSTK:
  PUSH HL
  LD HL,(ARREND)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  LD A,$E5
  LD A,$88
  SUB L
  LD L,A
  LD A,$FF
  SBC A,H
  LD H,A
  JP C,OMERR
  ADD HL,SP
  POP HL
  RET C
; This entry point is used by the routines at GETWORD, SCPTLP and GET_DEVICE.
OMERR:
  CALL UPD_PTRS
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  LD DE,$0007
  JP ERROR
; This entry point is used by the routines at SNERR, __FOR, GETWORD, ISFLIO and
; GET_DEVICE.
RUN_FST:
  LD HL,(BASTXT)
  DEC HL
; This entry point is used by the routines at __FOR, GETWORD and GET_DEVICE.
_CLVAR:
  LD (TEMP),HL
; This entry point is used by the routine at GET_DEVICE.
_CLREG:
  CALL RUN_FST2
  LD B,$1A
  LD HL,$FAED
CHKSTK_4:
  LD (HL),$04
  INC HL
  DEC B
  JP NZ,CHKSTK_4
  XOR A
  LD (ONEFLG),A
  LD L,A
  LD H,A
  LD (ONELIN),HL
  LD (OLDTXT),HL
  LD HL,(MEMSIZ)
  LD ($FABF),HL
  CALL __RESTORE
  LD HL,(PROGND)
  LD (VAREND),HL
  LD (ARREND),HL
  CALL CLSALL		; Close all files
  LD A,(NLONLY)
  AND $01
  JP NZ,CHKSTK_5
  LD (NLONLY),A
; This entry point is used by the routine at GET_DEVICE.
CHKSTK_5:
  POP BC
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  INC HL
  INC HL
  
; This entry point is used by the routine at SNERR.
WARM_ENTRY:
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL INIT_OUTPUT
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
  LD HL,(TEMP)
  RET
  
; This entry point is used by the routine at GETWORD.
TIME_S_ON:
  DI
  LD A,(HL)
  AND $04
  OR $01
  LD (HL),A
  EI
  RET
  
; This entry point is used by the routine at GETWORD.
TIME_S_OFF:
  DI
  LD (HL),$00
  EI
  RET
  
; This entry point is used by the routine at GETWORD.
TIME_S_STOP:
  DI
  LD A,(HL)
  OR $02
  LD (HL),A
  EI
  RET
  
; This entry point is used by the routine at ULERR.
TIME_S_STOP_1:
  DI
  LD A,(HL)
  AND $05
  LD (HL),A
  EI
  RET
  
RUN_FST1:
  DI
  LD A,(HL)
  AND $03
  LD (HL),A
  EI
  RET
  
RUN_FST2:
  XOR A
  LD L,A
  LD H,A
  LD ($F84C),A
  LD ($F84D),HL
  RET
  
; This entry point is used by the routine at __FOR.
RUN_FST3:
  LD A,(ONEFLG)
  OR A
  RET NZ
  PUSH HL
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,RUN_FST4
  LD HL,$F84C
  LD A,(HL)
  DEC A
  JP Z,TIME_S_STOP_7
RUN_FST4:
  POP HL
  RET

TIME_S_STOP_7:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  LD A,D
  OR E
  JP Z,RUN_FST4
  PUSH DE
  PUSH HL
  CALL RUN_FST1
  CALL TIME_S_STOP
  LD C,$03
  CALL CHKSTK
  POP BC
  POP DE
  POP HL
  POP AF
  JP __FOR_40
  
__RESTORE:
  EX DE,HL
  LD HL,(BASTXT)
  JP Z,RUN_FST6
  EX DE,HL
  CALL LNUM_PARM_0
  PUSH HL
  CALL FIRST_LNUM
  LD H,B
  LD L,C
  POP DE
  JP NC,ULERR			; Error: "Undefined line number"
RUN_FST6:
  DEC HL
; This entry point is used by the routine at __DATA.
RUN_FST7:
  LD ($FAEB),HL
  EX DE,HL
  RET
  
; This entry point is used by the routine at GETWORD.
__STOP:
  RET NZ
  INC A
  JP RUN_FST8
  
__END:
  RET NZ
  XOR A
  LD (ONEFLG),A
  PUSH AF
  CALL Z,CLSALL		; Close all files
  POP AF
RUN_FST8:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,$FFF6
  POP BC
  LD HL,(CURLIN)
  PUSH HL
  PUSH AF
  LD A,L
  AND H
  INC A
  JP Z,RUN_FST9
  LD (OLDLIN),HL
  LD HL,(SAVTXT)
  LD (OLDTXT),HL
RUN_FST9:
  CALL INIT_OUTPUT
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG
  JP NZ,SNERR_8
  JP RESTART
  
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
  JP FCERR

; This entry point is used by the routines at __FOR and GETVAR.
IS_ALPHA:
  LD A,(HL)
; This entry point is used by the routines at SNERR, OPRND and GETVAR.
IS_ALPHA_A:
  CP $41
  RET C
  CP $5B
  CCF
  RET

__CLEAR:
  PUSH HL
  CALL GET_DEVICE_206
  CALL SWAPNM_1
  CALL GET_DEVICE_207
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,_CLVAR
  CALL __FOR_31
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,(HIMEM)
  LD B,H
  LD C,L
  LD HL,(MEMSIZ)
  JP Z,_CLVAR3
  POP HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH DE
  CALL GETWORD
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SNERR
  EX (SP),HL
  EX DE,HL
  LD A,H
  AND A
  JP P,FCERR
  PUSH DE
  LD DE,$F381
  RST $38
  NOP
  RST CPDEHL
  JP NC,FCERR
  POP DE
  PUSH HL
  LD BC,$FEF5
  LD A,(MAXFIL)
_CLVAR2:
  ADD HL,BC
  DEC A
  JP P,_CLVAR2
  POP BC
  DEC HL
_CLVAR3:
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  JP C,OMERR
  PUSH HL
  LD HL,(PROGND)
  PUSH BC
  LD BC,$00A0
  ADD HL,BC
  POP BC
  RST CPDEHL
  JP NC,OMERR
  EX DE,HL
  LD (STKTOP),HL
  LD H,B
  LD L,C
  LD (HIMEM),HL
  POP HL
  LD (MEMSIZ),HL
  POP HL
  CALL _CLVAR
  LD A,(MAXFIL)
  CALL __MAX_0
  LD HL,(TEMP)
  JP EXEC_EVAL
__NEXT:
  LD DE,$0000
_CLVAR4:
  CALL NZ,GETVAR
  LD (TEMP),HL
  CALL NEXT_UNSTACK			; search FOR block on stack (skip 2 words)
  JP NZ,$0574
  LD SP,HL
  PUSH DE
  LD A,(HL)
  PUSH AF
  INC HL
  PUSH DE
  LD A,(HL)
  INC HL
  OR A
  JP M,_CLVAR5
  CALL PHLTFP
  EX (SP),HL
  PUSH HL
  CALL MIDNUM_9
  POP HL
  CALL LOADFP_2
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FCOMP
  JP _CLVAR6
_CLVAR5:
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
  CALL IADD
  LD A,(VALTYP)
  CP $04
  JP Z,$057D
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
_CLVAR6:
  POP HL
  POP BC
  SUB B
  CALL LOADFP
  JP Z,_CLVAR7
  EX DE,HL
  LD (CURLIN),HL
  LD L,C
  LD H,B
  JP __FOR_5
_CLVAR7:
  LD SP,HL
  LD (SAVSTK),HL
  EX DE,HL
  LD HL,(TEMP)
  LD A,(HL)
  CP ','
  JP NZ,EXEC_EVAL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL _CLVAR4

; Tests if an I/O redirection to device is in place
;
; Used by the routines at SNERR, __DATA, MAKINT and SCPTLP.
ISFLIO:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  POP HL
  RET
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ISFLIO_0:
  LD A,$0D
  RST OUTC
  LD A,$0A
  RST OUTC
  RET
; This entry point is used by the routines at GETWORD and GET_DEVICE.
__BEEP:
  LD A,$07
  RST OUTC
  RET
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_1:
  LD A,$0B
  RST OUTC
  RET
; This entry point is used by the routine at GET_DEVICE.
__CLS:
  LD A,$0C
  RST OUTC
  RET
ISFLIO_2:
  LD A,$54
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_3:
  LD A,$55
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_4:
  LD A,$56
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_5:
  LD A,$57
  JP ISFLIO_17
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ISFLIO_6:
  LD A,$50
  JP ISFLIO_17
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ISFLIO_7:
  LD A,$51
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_8:
  LD A,$4D
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_9:
  LD A,$4C
  JP ISFLIO_17
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ERAEOL:
  LD A,$4B
  JP ISFLIO_17
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ISFLIO_11:
  LD A,$58
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_12:
  LD A,$33
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_13:
  LD A,$34
  JP ISFLIO_17
ISFLIO_14:
  OR (HL)
  RET Z
ISFLIO_15:
  LD A,$70
  JP ISFLIO_17
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_16:
  LD A,$71
ISFLIO_17:
  PUSH AF
  LD A,$1B
  RST OUTC
  POP AF
  RST OUTC
  RET
ISFLIO_18:
  LD HL,($F3E7)
  LD H,$01
; This entry point is used by the routines at GETWORD and GET_DEVICE.
POSIT:
  LD A,$59
  CALL ISFLIO_17
  LD A,L
  ADD A,$1F
  RST OUTC
  LD A,H
  ADD A,$1F
  RST OUTC
  RET
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ISFLIO_20:
  LD A,($F3E9)
  AND A
  RET Z
  CALL ISFLIO_3
  LD HL,(CSRX)
  PUSH HL
  CALL ISFLIO_18
  CALL ISFLIO_131
  CALL ERAEOL
  POP HL
  CALL POSIT
  CALL ISFLIO_11
  XOR A
  RET
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_21:
  CALL STFNK
; This entry point is used by the routines at GETWORD and GET_DEVICE.
ISFLIO_22:
  XOR A
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_23:
  PUSH AF
  LD ($FEAA),A
  LD HL,(CSRX)
  LD A,($F3E7)
  CP L
  JP NZ,ISFLIO_24
  PUSH HL
  CALL ISFLIO_78
  CALL ISFLIO_1
  CALL ISFLIO_8
  POP HL
  DEC L
ISFLIO_24:
  PUSH HL
  CALL ISFLIO_3
  CALL ISFLIO_18
  CALL ISFLIO_131
  LD HL,$F6A5
  LD D,$01
  POP BC
  POP AF
  PUSH BC
  JP Z,ISFLIO_25
  LD HL,$F6F5
  LD D,$06
ISFLIO_25:
  LD E,$05
  LD A,(REVERSE)
  PUSH AF
  CALL ISFLIO_16
ISFLIO_26:
  LD A,(ACTV_Y)
  CP $28
  LD BC,$0709
  JP Z,ISFLIO_27
  LD BC,$0F01
ISFLIO_27:
  PUSH HL
  LD HL,$F9B3
  LD A,D
  SUB $04
  JP Z,ISFLIO_28
  DEC A
  DEC HL
ISFLIO_28:
  CALL Z,ISFLIO_14
  POP HL
  CALL GETWORD_132
  ADD HL,BC
  CALL ISFLIO_16
  INC D
  DEC E
  CALL NZ,CPDEHL_0
  JP NZ,ISFLIO_26
  CALL ERAEOL
  CALL ISFLIO_2
  POP AF
  AND A
  CALL NZ,ISFLIO_15
  POP HL
  CALL POSIT
  CALL ISFLIO_11
  XOR A
  RET
; This entry point is used by the routine at SCPTLP.
ISFLIO_29:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  RST $38
  EX AF,AF'
  CALL OUTC_SUB_0
  JP POPALL
; This entry point is used by the routine at GETWORD.
OUTC_SUB_0:
  LD C,A
  XOR A
  LD ($F9B9),A
  RST $38
  LD A,(BC)
  CALL OUTC_SUB_1
  LD HL,(CSRX)
  LD ($F3EC),HL
  RET
  
OUTC_SUB_1:
  CALL $7426
  CALL OUTC_SUB_3
OUTC_SUB_2:
  LD HL,(CSRX)
  EX DE,HL
  CALL MOVE_CURSOR
  LD A,(CSR_STATUS)
  AND A
  RET Z
  JP GET_DEVICE_515
  
OUTC_SUB_3:
  LD HL,$F3F2
  LD A,(HL)
  AND A
  JP NZ,ISFLIO_41
  LD A,C
  CP ' '
  JP C,ISFLIO_36
ISFLIO_34:
  LD HL,(CSRX)
  CP $7F
  JP Z,ISFLIO_62
  LD C,A
  CALL ESC_J_1
  CALL ISFLIO_46
  RET NZ
  CALL ISFLIO_35
  LD H,$01
  CALL ISFLIO_49
  RET NZ
  CALL GET_DEVICE_679
  AND A
  RET NZ
  CALL UPD_COORDS
  CALL ISFLIO_78
  LD L,$01
  JP ESC_M_0
ISFLIO_35:
  CALL TTY_JP_0_1
  JP ISFLIO_133
TTY_JP_0:
  SBC A,(HL)
  LD C,C
ISFLIO_36:
  LD HL,$43ED
TTY_JP:
  LD C,$0C
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_37:
  INC HL
  INC HL
  AND A
  DEC C
  RET M
  CP (HL)
  INC HL
  JP NZ,ISFLIO_37
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  PUSH HL
  LD HL,GETWORD_32
  EX (SP),HL
  PUSH HL
  LD HL,(CSRX)
  RET
TTY_CTLCODES:
  DEFB $07                ; Control code + JP location list for TTY controls
  DEFW $76EB              ; Control code + JP location list for TTY controls
  DEFB $08                ; Control code + JP location list for TTY controls
  DEFW ISFLIO_48          ; Control code + JP location list for TTY controls
  DEFB $09                ; Control code + JP location list for TTY controls
  DEFW ISFLIO_52          ; Control code + JP location list for TTY controls
  DEFB $0A                ; Control code + JP location list for TTY controls
  DEFW $43B8              ; Control code + JP location list for TTY controls
  DEFB $0B                ; Control code + JP location list for TTY controls
  DEFW ESC_H          ; Control code + JP location list for TTY controls
  DEFB $0C                ; Control code + JP location list for TTY controls
  DEFW $45CC              ; Control code + JP location list for TTY controls
  DEFB $0D                ; Control code + JP location list for TTY controls
  DEFW _CR          ; Control code + JP location list for TTY controls
  DEFB $1B                ; Control code + JP location list for TTY controls
  DEFW $4423              ; Control code + JP location list for TTY controls
  DEFB $1C                ; Control code + JP location list for TTY controls
  DEFW $44ED              ; Control code + JP location list for TTY controls
  DEFB $1D                ; Control code + JP location list for TTY controls
  DEFW ISFLIO_48          ; Control code + JP location list for TTY controls
  DEFB $1E                ; Control code + JP location list for TTY controls
  DEFW $44E8              ; Control code + JP location list for TTY controls
  DEFB $1F                ; Control code + JP location list for TTY controls
  DEFW ISFLIO_49          ; Control code + JP location list for TTY controls
; This entry point is used by the routine at GET_DEVICE.
TTY_JP_0_1:
  LD A,($F9B9)
  AND A
  RET Z
  POP AF
  RET
TEXT_LINES:
  LD A,($F3E9)
  ADD A,$08
  RET
  LD A,$02
  LD BC,$AF3E
  LD ($F3F2),A
  RET
  LD L,D
  CALL Z,ESC_M_0
  CALL Z,SCPTLP_6
  CP E
  LD B,L
  LD C,D
  JP NC,$6C45
  CP C
  LD B,L
  LD C,H
  LD L,B
  LD B,L
  LD C,L
  JR NC,$4483
  LD E,C
  JR NZ,ISFLIO_42
  LD B,C
  RET PE
  LD B,H
ISFLIO_40:
  LD B,D
  DI
  LD B,H
  LD B,E
  JP NC,ISFLIO_40
  IN A,($44)
  LD C,B
  DEC DE
  LD B,L
  LD (HL),B
  XOR D
  LD B,H
  LD (HL),C
  XOR E
  LD B,H
  LD D,B
  LD ($5145),HL
  INC HL
  LD B,L
  LD D,H
  OR D
  LD B,H
  LD D,L
  OR B
  LD B,H
  LD D,(HL)
  CP B
  LD B,H
  LD D,A
  CP C
  LD B,H
  LD E,B
  RET
  LD B,H
  INC SP
  CP A
  LD B,H
  INC (HL)
  CP (HL)
  LD B,H
ISFLIO_41:
  RST $38
  LD B,(HL)
  LD A,C
  CP $1B
  LD A,(HL)
  JP Z,ISFLIO_45
  AND A
  JP P,ISFLIO_43
  CALL $4424
  LD A,C
  LD HL,$4427
ISFLIO_42:
  LD C,$18
  JP ISFLIO_37
ISFLIO_43:
  DEC A
  LD ($F3F2),A
  LD A,(ACTV_Y)
  LD DE,CSRY
  JP Z,ISFLIO_44
  LD A,($F3E7)
  LD HL,$F3E9
  ADD A,(HL)
  DEC DE
ISFLIO_44:
  LD B,A
  LD A,C
  SUB $20
  CP B
  INC A
  LD (DE),A
  RET C
  LD A,B
  LD (DE),A
  RET
  OR $AF
  LD (REVERSE),A
  RET
  XOR A
  JP NZ,PTRFIL_2
  LD ($F3E9),A
  RET
  OR $AF
  LD ($F3EA),A
  RET
  OR $AF
  LD ($F831),A
  RET
ISFLIO_45:
  INC HL
  LD (HL),A
  JP $4423
  LD HL,$F3F3
  LD A,(HL)
  LD (HL),$00
  DEC HL
  LD (HL),A
  RET
ISFLIO_46:
  LD A,(ACTV_Y)
  CP H
  RET Z
  INC H
  JP UPD_COORDS
ISFLIO_47:
  DEC H
  RET Z
  JP UPD_COORDS
ISFLIO_48:
  CALL ISFLIO_47
  RET NZ
  LD A,(ACTV_Y)
  LD H,A
  DEC L
  RET Z
  JP UPD_COORDS
  CALL ISFLIO_46
  RET NZ
  LD H,$01
ISFLIO_49:
  CALL GET_DEVICE_274
  CP L
  RET Z
  JP C,ISFLIO_51
  INC L
UPD_COORDS:
  LD (CSRX),HL
  RET
ISFLIO_51:
  DEC L
  XOR A
  JP UPD_COORDS
ISFLIO_52:
  LD A,(CSRY)
  PUSH AF
  LD A,' '
  CALL ISFLIO_34
  POP BC
  LD A,(CSRY)
  CP B
  RET Z
  DEC A
  AND $07
  JP NZ,ISFLIO_52
  RET
  
; Home cursor (ESC H) and vertical tab (0Bh)
;
; Used by the routine at _CLS.
; Home cursor
ESC_H:
  LD L,$01

; Move cursor to beginning
;
; Used by the routines at ESC_M and ESC_L.
_CR:
  LD H,$01
  JP UPD_COORDS
  
  LD A,$AF
  LD HL,CSR_STATUS
  LD (HL),A
  CALL TTY_JP_0_1
  LD A,(HL)
  AND A
  JP GET_DEVICE_516


; Erase current line
ESC_M:
  CALL _CR
ESC_M_0:
  CALL TTY_JP_0_1
  CALL TEXT_LINES
  SUB L
  RET C
  JP Z,ESC_LL		; ESC,"l", clear line
  PUSH HL
  PUSH AF
  LD B,A
  CALL ISFLIO_130
  LD L,E
ESC_M_0:
  LD H,D
  INC HL
  CALL LDIR_B
  LD HL,$F82F
  DEC (HL)
  POP AF
  POP HL
ESC_M_1:
  PUSH AF
  LD H,40
ESC_M_2:
  INC L
  CALL ESC_L_2
  DEC L
  CALL ESC_J_2
  DEC H
  JP NZ,ESC_M_2
  INC L
  POP AF
  DEC A
  JP NZ,ESC_M_1
  JP ESC_LL


; Insert line
ESC_L:
  CALL _CR
  CALL TTY_JP_0_1
  CALL TEXT_LINES
  LD H,A
  SUB L
  RET C
  JP Z,ESC_LL		; ESC,"l", clear line
  LD L,H
  PUSH HL
  PUSH AF
  LD C,A
  LD B,$00
  CALL ISFLIO_130
  LD L,E
  LD H,D
  DEC HL
  CALL GET_DEVICE_381
  POP AF
  POP HL
ISFLIO_59:
  PUSH AF
  LD H,40
ISFLIO_60:
  DEC L
  CALL ESC_L_2
  INC L
  CALL ESC_J_2
  DEC H
  JP NZ,ISFLIO_60
  DEC L
  POP AF
  DEC A
  JP NZ,ISFLIO_59
  JP ESC_LL
  
ESC_L_2:
  PUSH HL
  PUSH HL
  CALL ESC_J_4
  LD C,(HL)
  POP HL
  CALL ESC_J_7
  AND (HL)
  POP HL
  RET

ISFLIO_62:
  CALL ISFLIO_48
  CALL TTY_JP_0_1
ISFLIO_63:
  XOR A
  LD C,$20
  JP ESC_J_2
ESC_LL:
  LD H,$01

ESC_K:
  CALL TTY_JP_0_1
  CALL ISFLIO_132
ISFLIO_66:
  CALL ISFLIO_63
  INC H
  LD A,H
  CP ')'
  JP C,ISFLIO_66
  RET

  CALL ESC_H
  CALL CLR_ALTLCD

; Erase from the cursor to the bottom of the screen
; "erase in display"
ESC_J:
  CALL TTY_JP_0_1
  
ISFLIO_67:
  CALL ESC_K
  CALL TEXT_LINES
  CP L
  RET C
  RET Z
  LD H,$01
  INC L
  JP ISFLIO_67
  
ESC_J_1:
  CALL TTY_JP_0_1
  LD A,(REVERSE)

ESC_J_2:
  PUSH HL
  PUSH AF
  PUSH HL
  PUSH HL
  CALL ESC_J_5
  POP HL
  CALL ESC_J_4
  LD (HL),C
  POP DE
  CALL GET_DEVICE_517
  POP AF
  AND A
  POP HL
  RET Z
ESC_J_3:
  DI
  LD A,$0D
  JR NC,ESC_J_3
  CALL SET_CURSOR_SHAPE
  LD A,$09
  ;JR NC,$45D3
  JR NC,ESC_J+1		; ???

ESC_J_4:
  LD A,L
  ADD A,A
  ADD A,A
  ADD A,L
  ADD A,A
  ADD A,A
  ADD A,A
  LD E,A
  SBC A,A
  CPL
  LD D,A
  LD L,H
  LD H,$00
  ADD HL,DE
  LD DE,$FDD7
  ADD HL,DE
  RET

ESC_J_5:
  LD B,A
  CALL ESC_J_7
  INC B
  DEC B
  JP Z,$4629
  OR (HL)
  JP Z,GET_DEVICE_686
  LD (HL),A
  RET
  
ESC_J_7:
  LD A,L
  ADD A,A
  ADD A,A
  ADD A,L
  LD L,A
  LD A,H
  DEC A
  PUSH AF
  RRCA
  RRCA
  RRCA
  AND $1F
  ADD A,L
  LD L,A
  LD H,$00
  LD DE,$FA5B
  ADD HL,DE
  POP AF
  AND $07
  LD D,A
  XOR A
  SCF
ISFLIO_74:
  RRA
  DEC D
  JP P,ISFLIO_74
  RET
  
; This entry point is used by the routine at GET_DEVICE.
ESC_J_9:
  PUSH HL
  CALL ESC_J_7
  XOR (HL)
  LD (HL),A
  POP HL
  RET
  
; This entry point is used by the routine at GET_DEVICE.
CLR_ALTLCD:
  CALL TTY_JP_0_1
  LD A,(FNK_FLAG)
  ADD A,A
  RET P
  PUSH HL
  LD HL,ALT_LCD
  LD BC,$0140
ISFLIO_77:
  LD (HL),' '
  INC HL
  DEC BC
  LD A,B
  OR C
  JP NZ,ISFLIO_77
  POP HL
  RET
  
ISFLIO_78:
  CALL TTY_JP_0_1
  LD A,(FNK_FLAG)
  ADD A,A
  RET P
  LD DE,ALT_LCD
  LD HL,$FBE8
  LD BC,$0140	; 40x8
  JP _LDIR
  
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_79:
  CALL $7426
  LD L,$01
ISFLIO_80:
  LD H,$01
ISFLIO_81:
  CALL ESC_L_2
  CALL ESC_J_2
  INC H
  LD A,H
  CP ')'
  JP NZ,ISFLIO_81
  INC L
  LD A,L
  CP $09
  JP NZ,ISFLIO_80
  JP OUTC_SUB_2
  
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_82:
  LD HL,ALT_LCD
  LD E,$01
ISFLIO_83:
  LD D,$01
ISFLIO_84:
  PUSH HL
  PUSH DE
  LD C,(HL)
  CALL GET_DEVICE_517
  POP DE
  POP HL
  INC HL
  INC D
  LD A,D
  CP ')'
  JP NZ,ISFLIO_84
  INC E
  LD A,E
  CP $09
  JP NZ,ISFLIO_83
  RET
  
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_85:
  LD A,B
  DEC A
  SCF
  RET Z
  DEC B
  DEC DE
  CALL ISFLIO_89
ISFLIO_86:
  PUSH AF
  LD A,$7F
  RST OUTC
  LD HL,(CSRX)
  DEC L
  DEC H
  LD A,H
  OR L
  JP Z,ISFLIO_87
  LD HL,CSRY
  POP AF
  CP (HL)
  JP NZ,ISFLIO_86
  RET
  
ISFLIO_87:
  POP AF
  SCF
  RET
  
ISFLIO_88:
  CALL ISFLIO_85
  JP NC,ISFLIO_88
  RET
  
ISFLIO_89:
  PUSH BC
  LD A,($F9BD)
  DEC B
  JP Z,ISFLIO_93
  LD C,A
  LD HL,$F5A1
ISFLIO_90:
  INC C
  LD A,(HL)
  CP $09
  JP NZ,ISFLIO_91
  LD A,C
  DEC A
  AND $07
  JP NZ,ISFLIO_90
ISFLIO_91:
  LD A,(ACTV_Y)
  CP C
  JP NC,ISFLIO_92
  LD C,$01
ISFLIO_92:
  INC HL
  DEC B
  JP NZ,ISFLIO_90
  LD A,C
ISFLIO_93:
  POP BC
  RET
  
ISFLIO_94:
  LD HL,(PTRFIL)
  PUSH HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  SUB $F9
  JP NZ,ISFLIO_95
  LD L,A
  LD H,A
  LD (PTRFIL),HL			; Redirect I/O
  LD HL,$F9B4
  INC (HL)
  LD A,(HL)
  RRCA
  CALL NC,ISFLIO_15
  LD HL,$54BD
  CALL PRS
  CALL ISFLIO_16
ISFLIO_95:
  POP HL
  LD (PTRFIL),HL			; Redirect I/O
  LD B,$FF
  LD HL,$F5A1
ISFLIO_96:
  XOR A
  LD ($F98F),A
  LD ($F990),A
  CALL RDBYT
  JP C,ISFLIO_99
  LD (HL),A
  CP $0D         	; CR
  JP Z,ISFLIO_98
  CP $09			; TAB
  JP Z,ISFLIO_97
  CP ' '
  JP C,ISFLIO_96
ISFLIO_97:
  INC HL
  DEC B
  JP NZ,ISFLIO_96
ISFLIO_98:
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET
  
ISFLIO_99:
  INC B
  JP NZ,ISFLIO_98
  LD A,(NLONLY)
  AND $80
  LD (NLONLY),A
  CALL SCPTLP_104
  LD A,$0D		; CR
  RST OUTC
  CALL ERAEOL
  LD A,(FILFLG)
  AND A
  JP Z,ERAEOL0
  CALL RUN_FST
  JP EXEC_EVAL
  
ERAEOL0:
  LD A,($F3FD)
  AND A
  JP NZ,GET_DEVICE_202
  JP RESTART
  
; This entry point is used by the routine at SNERR.
ERAEOL1:
  CALL ISFLIO
  JP NZ,ISFLIO_94
  RST $38
  LD B,B
  LD L,A
  JP ERAEOL4
; This entry point is used by the routines at __DATA and GET_DEVICE.
ERAEOL2:
  LD A,$3F
  RST OUTC
  LD A,' '
  RST OUTC
; This entry point is used by the routines at __DATA and GET_DEVICE.
ERAEOL3:
  RST $38
  LD B,D
  LD HL,(CSRX)
  DEC L
  CALL NZ,ISFLIO_132
  INC L
ERAEOL4:
  LD ($F82F),HL
  LD A,(CSR_STATUS)
  LD ($F99A),A
  CALL ISFLIO_7
ERAEOL5:
  CALL CHGET
  JP C,ERAEOL5
  LD HL,$47FA
  LD C,$08
  CALL ISFLIO_37
  PUSH AF
  CALL NZ,ERAEOL6
  POP AF
  JP NC,ERAEOL5
  PUSH AF
  LD A,($F99A)
  AND A
  CALL NZ,ISFLIO_6
  POP AF
  LD HL,BUFMIN
  RET Z
  CCF
  RET
ERAEOL6:
  LD HL,$F3DA
  CP ' '
  JP C,ERAEOL7
  PUSH AF
  LD A,(HL)
  AND A
  CALL NZ,ISFLIO_113
  POP AF
  RST OUTC
  RET
ERAEOL7:
  LD (HL),$00
  RST OUTC
  JP ISFLIO_12
  EX AF,AF'
  ADD HL,BC
  LD C,C
  LD (DE),A
  LD L,A
  LD C,B
  LD A,(BC)
  CALL PO,WORDS_2
  LD E,B
  LD C,C
  INC BC
  LD E,L
  LD C,B
  DEC C
  INC D
  LD C,B
  DEC D
  LD D,D
  LD C,C
  LD A,A
  INC BC
  LD C,C
  CALL ISFLIO_128
  LD DE,$F5A1
  LD B,$FE
  DEC L
ERAEOL8:
  INC L
ERAEOL9:
  PUSH DE
  PUSH BC
  CALL ESC_L_2
  LD A,C
  POP BC
  POP DE
  LD (DE),A
  INC DE
  DEC B
  JP Z,ISFLIO_110
  INC H
  LD A,$28
  CP H
  JP NC,ERAEOL9
  PUSH DE
  CALL ISFLIO_130
  POP DE
  LD H,$01
  JP Z,ERAEOL8
ISFLIO_110:
  DEC DE
  LD A,(DE)
  CP ' '
  JP Z,ISFLIO_110
  INC DE
  XOR A
  LD (DE),A
  LD A,$0D
  AND A
ISFLIO_111:
  PUSH AF
  CALL ISFLIO_132
  CALL POSIT
  LD A,$0A
  RST OUTC
  XOR A
  LD ($F3DA),A
  POP AF
  SCF
  POP HL
  RET
ISFLIO_112:
  INC L
  CALL ISFLIO_130
  JP Z,ISFLIO_112
  CALL ISFLIO_12
  XOR A
  LD ($F5A1),A
  LD H,$01
  JP ISFLIO_111
  LD HL,$F3DA
  LD A,(HL)
  CPL
  LD (HL),A
  AND A
  JP Z,ISFLIO_12
  JP ISFLIO_13
ISFLIO_113:
  LD HL,(CSRX)
  LD C,$20
  LD A,(REVERSE)
ISFLIO_114:
  PUSH HL
ISFLIO_115:
  PUSH BC
  PUSH AF
  CALL ESC_L_2
  POP DE
  LD B,D
  POP DE
  PUSH BC
  PUSH AF
  LD C,E
  LD A,B
  CALL ESC_J_2
  POP DE
  POP BC
  LD A,$28
  INC A
  INC H
  CP H
  LD A,D
  JP NZ,ISFLIO_115
  POP HL
  PUSH DE
  CALL ISFLIO_130
  POP DE
  JP Z,ISFLIO_120
  LD A,C
  CP ' '
  PUSH AF
  JP NZ,ISFLIO_116
  LD A,$28
  CP H
  JP Z,ISFLIO_116
  POP AF
  RET
ISFLIO_116:
  PUSH DE
  XOR A
  CALL ISFLIO_133
  POP DE
  INC L
  PUSH BC
  PUSH DE
  PUSH HL
  CALL TEXT_LINES
  CP L
  JP C,ISFLIO_117
  EX DE,HL
  LD HL,(CSRX)
  EX DE,HL
  PUSH DE
  CALL POSIT
  CALL ISFLIO_9
  POP HL
  CALL POSIT
  JP ISFLIO_119
ISFLIO_117:
  EX DE,HL
  LD HL,(CSRX)
  EX DE,HL
  PUSH DE
  LD HL,$0101
  CALL POSIT
  CALL ISFLIO_8
  POP HL
  DEC L
  JP NZ,ISFLIO_118
  INC L
ISFLIO_118:
  CALL POSIT
  POP HL
  DEC L
  PUSH HL
ISFLIO_119:
  POP HL
  POP DE
  POP BC
  POP AF
  RET Z
  DEC L
ISFLIO_120:
  LD H,$01
  INC L
  LD A,D
  JP ISFLIO_114
  LD A,$1C
  RST OUTC
  LD HL,(CSRX)
  DEC H
  JP NZ,ISFLIO_122
  INC H
  PUSH HL
  DEC L
  JP Z,ISFLIO_121
  LD A,$28
  LD H,A
  CALL ISFLIO_130
  JP NZ,ISFLIO_121
  EX (SP),HL
ISFLIO_121:
  POP HL
ISFLIO_122:
  CALL POSIT
ISFLIO_123:
  LD A,$28
  CP H
  JP Z,ISFLIO_125
  INC H
ISFLIO_124:
  CALL ESC_L_2
  DEC H
  CALL ESC_J_2
  INC H
  INC H
  LD A,$28
  INC A
  CP H
  JP NZ,ISFLIO_124
  DEC H
ISFLIO_125:
  LD C,$20
  XOR A
  CALL ESC_J_2
  CALL ISFLIO_130
  RET NZ
  PUSH HL
  INC L
  LD H,$01
  CALL ESC_L_2
  EX (SP),HL
  CALL ESC_J_2
  POP HL
  JP ISFLIO_123
  CALL ISFLIO_128
  CALL POSIT
  CALL ISFLIO_12
  XOR A
  LD ($F3DA),A
  PUSH HL
ISFLIO_126:
  CALL ISFLIO_130
  PUSH AF
  CALL ERAEOL
  POP AF
  JP NZ,ISFLIO_127
  LD H,$01
  INC L
  CALL POSIT
  JP ISFLIO_126
ISFLIO_127:
  POP HL
  JP POSIT
ISFLIO_128:
  DEC L
  JP Z,ISFLIO_129
  CALL ISFLIO_130
  JP Z,ISFLIO_128
ISFLIO_129:
  INC L
  LD A,($F82F)
  CP L
  LD H,$01
  RET NZ
  LD HL,($F82F)
  RET
ISFLIO_130:
  PUSH HL
  LD DE,$F826
  LD H,$00
  ADD HL,DE
  LD A,(HL)
  EX DE,HL
  POP HL
  AND A
  RET
; This entry point is used by the routine at GET_DEVICE.
ISFLIO_131:
  CALL TTY_JP_0_1
ISFLIO_132:
  LD A,L
ISFLIO_133:
  PUSH AF
  CALL ISFLIO_130
  POP AF
  LD (DE),A
  RET
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','

; DIM command
__DIM:
  LD BC,$49A5
  PUSH BC
  OR $AF

; Get variable address to DE
;
; Used by the routines at __DATA, OPRND, CHKSTK and SCPTLP.
GETVAR:
  XOR A
  LD (DIMFLG),A
  LD C,(HL)
  CALL IS_ALPHA
  JP C,SNERR
  XOR A
  LD B,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,GETVAR_0
  CALL IS_ALPHA_A
  JP C,GETVAR_2
GETVAR_0:
  LD B,A
GETVAR_1:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,GETVAR_1
  CALL IS_ALPHA_A
  JP NC,GETVAR_1
GETVAR_2:
  CP '&'
  JP NC,GETVAR_3
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
GETVAR_3:
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
  LD (VALTYP),A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,(SUBFLG)
  DEC A
  JP Z,SBSCPT_1
  JP P,GETVAR_4
  LD A,(HL)
  SUB $28	; '('
  JP Z,SBSCPT
  SUB $33
  JP Z,SBSCPT
GETVAR_4:
  XOR A
  LD (SUBFLG),A
  PUSH HL
  LD HL,(PROGND)
  JP GETVAR_7
GETVAR_5:
  LD A,(DE)
  LD L,A
  INC DE
  LD A,(DE)
  INC DE
  CP C
  JP NZ,GETVAR_6
  LD A,(VALTYP)
  CP L
  JP NZ,GETVAR_6
  LD A,(DE)
  CP B
  JP Z,GETVAR_10
GETVAR_6:
  INC DE
  LD H,$00
  ADD HL,DE
GETVAR_7:
  EX DE,HL
  LD A,(VAREND)
  CP E
  JP NZ,GETVAR_5
  LD A,($FAE8)
  CP D
  JP NZ,GETVAR_5
  JP GETVAR_8
GETVAR_8:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,$12AA
  RST CPDEHL
  POP DE
  JP Z,GETVAR_11
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
  LD HL,(ARREND)
  PUSH HL
  ADD HL,BC
  POP BC
  PUSH HL
  CALL __POS_1
  POP HL
  LD (ARREND),HL
  LD H,B
  LD L,C
  LD (VAREND),HL
GETVAR_9:
  DEC HL
  LD (HL),$00
  RST CPDEHL
  JP NZ,GETVAR_9
  POP DE
  LD (HL),E
  INC HL
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
GETVAR_10:
  INC DE
  POP HL
  RET
  
GETVAR_11:
  LD (FACCU),A
  LD H,A
  LD L,A
  LD (DBL_FPREG),HL
  RST GETYPR 		; Get the number type (FAC)
  JP NZ,GETVAR_12		; JP if not string type, 
  LD HL,NULL_STRING
  LD (DBL_FPREG),HL
GETVAR_12:
  POP HL
  RET

; Sort out subscript
;
; Used by the routine at GETVAR.
SBSCPT:
  PUSH HL			; Save code string address
  LD HL,(DIMFLG)
  EX (SP),HL		; Save and get code string
  LD D,A			; Zero number of dimensions

; SBSCPT loop
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
  JP Z,SCPTLP_0
  CP ']'
  JP NZ,SNERR
SCPTLP_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD (TEMP2),HL
  POP HL
  LD (DIMFLG),HL
  LD E,$00
  PUSH DE
  
  defb $11	
;  LD DE,$F5E5

SBSCPT_1:
  PUSH HL
  PUSH AF
  LD HL,(VAREND)

  ;LD A,$19
  DEFB $3E  ; "LD A,n" to Mask the next byte

SBSCPT_2:
  ADD HL,DE
  EX DE,HL
  LD HL,(ARREND)
  EX DE,HL
  RST CPDEHL

  JP Z,BSOPRND_0
  LD E,(HL)
  INC HL
  LD A,(HL)
  INC HL
  CP C
  JP NZ,SCPTLP_1
  LD A,(VALTYP)
  CP E
  JP NZ,SCPTLP_1
  LD A,(HL)
  CP B
SCPTLP_1:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  JP NZ,SBSCPT_2
  LD A,(DIMFLG)
  OR A
  JP NZ,$0577
  POP AF
  LD B,H
  LD C,L
  JP Z,POPHLRT
  SUB (HL)
  JP Z,SCPTLP_8

; This entry point is used by the routine at MLDEBC.
; "Subscript error" / "Subscript out of range"
SBSCT_ERR:
  LD DE,$0009
  JP ERROR
  
BSOPRND_0:
  LD A,(VALTYP)
  LD (HL),A
  INC HL
  LD E,A
  LD D,$00
  POP AF
  JP Z,FCERR
  LD (HL),C
  INC HL
  LD (HL),B
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
SCPTLP_4:
  LD BC,$000B
  JP NC,SCPTLP_5
  POP BC
  INC BC
SCPTLP_5:
  LD (HL),C
  PUSH AF
  INC HL
  LD (HL),B
  INC HL
  CALL MLDEBC
  POP AF
  DEC A
  JP NZ,SCPTLP_4
  PUSH AF
  LD B,D
  LD C,E
  EX DE,HL
  ADD HL,DE
; This entry point is used by the routine at ISFLIO.
SCPTLP_6:
  JP C,OMERR
  CALL $3FD5
  LD (ARREND),HL
SCPTLP_7:
  DEC HL
  LD (HL),$00
  RST CPDEHL
  JP NZ,SCPTLP_7
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
  JP C,SCPTLP_11
SCPTLP_8:
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
  RST CPDEHL
  JP NC,SBSCT_ERR		; "Subscript error" / "Subscript out of range"
  CALL MLDEBC
  ADD HL,DE
  POP AF
  DEC A
  LD B,H
  LD C,L
  JP NZ,$4B6E
  LD A,(VALTYP)
  LD B,H
  LD C,L
  ADD HL,HL
  SUB $04
  JP C,SCPTLP_9
  ADD HL,HL
  JP Z,SCPTLP_10
  ADD HL,HL
SCPTLP_9:
  OR A
  JP PO,SCPTLP_10
  ADD HL,BC
SCPTLP_10:
  POP BC
  ADD HL,BC
  EX DE,HL
SCPTLP_11:
  LD HL,(TEMP2)
  RET
  
; This entry point is used by the routine at __DATA.
USING:
  CALL EVAL
  CALL TSTSTR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEC SP
  EX DE,HL
  LD HL,(DBL_FPREG)
  JP USING_1
USING_0:
  LD A,(FLGINP)
  OR A
  JP Z,USING_2
  POP DE
  EX DE,HL
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
  JP Z,FCERR
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP USING_7

SCPTLP_16:
  CALL BSOPRND_03
  RST OUTC
USING_7:
  XOR A
  LD E,A
  LD D,A
SCPTLP_18:
  CALL BSOPRND_03
  LD D,A
  LD A,(HL)
  INC HL
  CP '#'
  JP Z,SBSCT_ERR1
  DEC B
  JP Z,BSOPRND_00
  CP '+'
  LD A,$08
  JP Z,SCPTLP_18
  DEC HL
  LD A,(HL)
  INC HL
  CP '.'
  JP Z,SBSCT_ERR2
  CP (HL)
  JP NZ,SCPTLP_16
  CP $5C  	;'\'
  JP Z,L4C12+1
  CP '*'
  JP NZ,SCPTLP_16
  INC HL
  LD A,B
  CP $02
  JP C,SCPTLP_19
  LD A,(HL)
  CP $5C  	;'\'
SCPTLP_19:
  LD A,' '
  JP NZ,SBSCT_ERR0
  DEC B
  INC E
  
L4C12:
  CP $AF
  ; L4C12+1:  XOR A

  ADD A,$10
  INC HL
SBSCT_ERR0:
  INC E
  ADD A,D
  LD D,A
  
SBSCT_ERR1:
  INC E
  LD C,$00
  DEC B
  JP Z,SBSCT_ERR5
  LD A,(HL)
  INC HL
  CP '.'
  JP Z,SBSCT_ERR3
  CP '#'
  JP Z,SBSCT_ERR1
  CP ','
  JP NZ,SBSCT_ERR4
  LD A,D
  OR $40
  LD D,A
  JP SBSCT_ERR1
  
SBSCT_ERR2:
  LD A,(HL)
  CP '#'
  LD A,'.'
  JP NZ,SCPTLP_16
  LD C,$01
  INC HL
SBSCT_ERR3:
  INC C
  DEC B
  JP Z,SBSCT_ERR5
  LD A,(HL)
  INC HL
  CP '#'
  JP Z,SBSCT_ERR3
SBSCT_ERR4:
  PUSH DE
  LD DE,SBSCT_ERR5-2
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
;  JP Z,GET_DEVICE_691
  JP Z,$D1EB		; ??  probably 'Z' never happens (same trick on MSX)
;  EX DE,HL / POP DE

SBSCT_ERR5:
  LD A,D
  DEC HL
  INC E
  AND $08
  JP NZ,SBSCT_ERR7
  DEC E
  LD A,B
  OR A
  JP Z,SBSCT_ERR7
  LD A,(HL)
  SUB $2D		; '-'
  JP Z,SBSCT_ERR6
  CP $FE
  JP NZ,SBSCT_ERR7
  LD A,$08
SBSCT_ERR6:
  ADD A,$04
  ADD A,D
  LD D,A
  DEC B
SBSCT_ERR7:
  POP HL
  POP AF
  JP Z,BSOPRND_02
  PUSH BC
  PUSH DE
  CALL $1091
  POP DE
  POP BC
  PUSH BC
  PUSH HL
  LD B,E
  LD A,B
  ADD A,C
  CP $19
  JP NC,FCERR			; "Illegal function call" error
  
  LD A,D
  OR $80
  CALL FOUT_0		; Convert number/expression to string (format specified in 'A' register)
  CALL PRS
  
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  SCF
  JP Z,SBSCT_ERR9
  LD (FLGINP),A
  CP ';'
  JP Z,SBSCT_ERR8
  CP ','
  JP NZ,SNERR
SBSCT_ERR8:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
SBSCT_ERR9:
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
  JP BSOPRND_01
BSOPRND_00:
  CALL BSOPRND_03
  RST OUTC
BSOPRND_01:
  POP HL
  POP AF
  JP NZ,USING_0
BSOPRND_02:
  CALL C,OUTDO_CRLF
  EX (SP),HL
  CALL GSTRHL
  POP HL
  JP FINPRT

BSOPRND_03:
  PUSH AF
  LD A,D
  OR A
  LD A,'+'
  CALL NZ,_OUTC
  POP AF
  RET

; This entry point is used by the routines at OUTC and GET_DEVICE.
_OUTC:
  PUSH AF
  PUSH HL
  CALL ISFLIO
  JP NZ,OUTC_FOUT
  POP HL
  LD A,(PRTFLG)
  OR A
  JP Z,SCPTLP_43
  POP AF

; Print the character in the A register on the printer.  Expand tabs into
; spaces if nescessary
;
; Used by the routines at LPT_OUTPUT and TEL_TERM.
OUTC_TABEXP:
  PUSH AF
  CP $09
  JP NZ,OUTC_1
OUTC_TABEXP_0:
  LD A,' '
  CALL OUTC_TABEXP
  LD A,(LPT_POS)
  AND $07
  JP NZ,OUTC_TABEXP_0
  POP AF
  RET
  
OUTC_1:
  SUB $0D
  JP Z,OUTC_2
  JP C,OUTC_3
  CP $13
  JP C,OUTC_3
  LD A,(LPT_POS)
  INC A
OUTC_2:
  LD (LPT_POS),A
OUTC_3:
  POP AF
OUTC_4:
  CP $1A		; EOF
  RET Z
  JP LPT_OUT

; This entry point is used by the routines at SNERR and CHKSTK.
INIT_OUTPUT:
  XOR A
  LD (PRTFLG),A
  LD A,(LPT_POS)
  OR A
  RET Z

; This entry point is used by the routine at GET_DEVICE.
INIT_OUTPUT_0:
  LD A,$0D
  CALL OUTC_4
  LD A,$0A
  CALL OUTC_4
  XOR A
  LD (LPT_POS),A
  RET

SCPTLP_43:
  POP AF
  PUSH AF
  CALL ISFLIO_29
  LD A,(CSRY)
  DEC A
  LD (TTYPOS),A
  POP AF
  RET
  
; This entry point is used by the routines at SNERR, GETWORD, CHKSTK and
; GET_DEVICE.
CONSOLE_CRLF:
  LD A,(CSRY)
  DEC A
  RET Z
  JP OUTDO_CRLF
  LD (HL),$00
  CALL ISFLIO
  LD HL,BUFMIN
  JP NZ,SCPTLP_46
; This entry point is used by the routines at __DATA and MAKINT.
OUTDO_CRLF:
  LD A,$0D
  RST OUTC
  LD A,$0A
  RST OUTC
; This entry point is used by the routines at __DATA and PRS1.
SCPTLP_46:
  CALL ISFLIO
  JP Z,SCPTLP_47
  XOR A
  RET
SCPTLP_47:
  LD A,(PRTFLG)
  OR A
  JP Z,SCPTLP_48
  XOR A
  LD (LPT_POS),A
  RET
SCPTLP_48:
  XOR A
  LD (TTYPOS),A
  RET
; This entry point is used by the routine at OPRND.
FN_INKEY:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL CHSNS
  JP Z,INKEY_S_0
  CALL CHGET
  CP $03
  JP Z,SCPTLP_92
  PUSH AF
  CALL MK_1BYTE_TMST
  POP AF
  LD E,A
  CALL __CHR_S_0
INKEY_S_0:
  LD HL,NULL_STRING
  LD (DBL_FPREG),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET

; This entry point is used by the routines at GETWORD and GET_DEVICE.
FNAME:
  PUSH HL
  JP SCPTLP_53
; This entry point is used by the routine at GETWORD.
FILE_PARMS:
  CALL $1091
  PUSH HL
  CALL GETSTR
  LD A,(HL)
  OR A
  JP Z,SCPTLP_56
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E
  LD E,A
SCPTLP_53:
  CALL USING6
  PUSH AF
  LD BC,FILNAM
  LD D,$09
  INC E
SCPTLP_54:
  DEC E
  JP Z,SCPTLP_60
  LD A,(HL)
  CP ' '
  JP C,SCPTLP_56
  CP $7F
  JP Z,SCPTLP_56
  CP '.'
  JP Z,SCPTLP_58
  LD (BC),A
  INC BC
  INC HL
  DEC D
  JP NZ,SCPTLP_54
SCPTLP_55:
  POP AF
  PUSH AF
  LD D,A
  LD A,(FILNAM)
  INC A
  JP Z,SCPTLP_56
  POP AF
  POP HL
  RET
SCPTLP_56:
  JP NMERR
SCPTLP_57:
  INC HL
  JP SCPTLP_54
SCPTLP_58:
  LD A,D
  CP $09
  JP Z,SCPTLP_56
  CP $03
  JP C,SCPTLP_56
  JP Z,SCPTLP_57
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
SCPTLP_59:
  JP SCPTLP_58
SCPTLP_60:
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP NZ,SCPTLP_60
  JP SCPTLP_55
SCPTLP_61:
  LD A,(HL)
  INC HL
  DEC E
  RET
  CALL MAKINT
VARPTR_A:
  LD L,A
  LD A,(MAXFIL)
  CP L
  JP C,BNERR
  LD H,$00
  LD ($F98F),HL
  ADD HL,HL
  EX DE,HL
  LD HL,(FILTAB)
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD A,(HL)
  OR A
  RET Z
  PUSH HL
  LD DE,$0004
  ADD HL,DE
  LD A,(HL)
  CP $09
  JP NC,SCPTLP_63
  RST $38
  JR NZ,SCPTLP_59
  OR $51
SCPTLP_63:
  POP HL
  LD A,(HL)
  OR A
  SCF
  RET
SCPTLP_64:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '#'
  CALL Z,_CHRGTB
  CALL GETINT
  EX (SP),HL
  PUSH HL

; a.k.a. SELECT. This entry point is used by the routines at _LOAD, __MERGE and GT_CHANNEL.
SETFIL:
  CALL VARPTR_A
  JP Z,CFERR
  LD (PTRFIL),HL			; Redirect I/O
  RST $38
  DEFB $0E		; HSETF, Offset: 14
  RET
  
__OPEN:
  LD BC,FINPRT
  PUSH BC
  CALL FILE_PARMS
  JP NZ,__OPEN_0
  LD D,$F9		; D = 'RAM' device ?
  
__OPEN_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD A,D			; TK_FOR
  CP $85				; TK_INPUT, 'INPUT' TOKEN code
  LD E,$01
  JP Z,__OPEN_INPUT
  
  CP $9C
  JP Z,__OPEN_OUTPUT
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'P'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'P'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD A,C
  LD E,$08
  JP __OPEN_2
  
__OPEN_OUTPUT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'P'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'U'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'T'		; "OUTPUT"  :S
  LD E,$02
  
  DEFB $3E  ; "LD A,n" to Mask the next byte


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
  CALL Z,_CHRGTB
  CALL GETINT
  OR A
  JP Z,BNERR
  RST $38
  DEFB $1A		; HNOFO, Offset: 26
  
;  LD E,$D5
  
  DEFB $1E      ;LD E,N

; Routine at 19730
;
; Used by the routines at __MERGE, __SAVE, __EDIT, TXT_CTL_G and TXT_CTL_V.
_OPEN:
  PUSH DE
  DEC HL
  LD E,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SNERR
  EX (SP),HL
  LD A,E
  PUSH AF
  PUSH HL
  CALL VARPTR_A
  JP NZ,AOERR
  POP DE
  LD A,D
  CP $09
  RST $38
  DEFB $1E		; HNULO, Offset: 30
  ;LD E,$DA
  JP C,IEERR
  PUSH HL
  LD BC,$0004
  ADD HL,BC
  LD (HL),D
  LD A,$00
  POP HL
  JP GET_DEVICE

;
; Used by the routines at __CLOSE, INIT_PRINT_h and L4F2E.
CLOSE1:
  PUSH HL
  OR A
  JP NZ,NTFL0
  LD A,(NLONLY)
  AND $01
  JP NZ,SCPTLP_95

; NTFL0 - "NoT FiLe number 0"
NTFL0:
  CALL VARPTR_A
  JP Z,_CLOSE_0
  
  LD (PTRFIL),HL			; Redirect I/O
  PUSH HL
  LD A,$02
  JP C,GET_DEVICE
  
  RST $38
  DEFB $16			; HNTFL, Offset: 22
  ;LD D,$C3
  JP IEERR

; LCD, CRT, and LPT file close routine
;
; Used by the routines at GETWORD, RAM_CLS, CAS_CLS and COM_CLS.
_CLOSE:
  CALL SCPTLP_94
  POP HL
_CLOSE_0:
  PUSH HL
  LD DE,$0007
  ADD HL,DE
  LD (HL),A
  LD H,A
  LD L,A
  LD (PTRFIL),HL			; Redirect I/O
  POP HL
  ADD A,(HL)
  LD (HL),$00
  POP HL
  RET
  
; This entry point is used by the routine at __FOR.
_LOAD:
  SCF			; Carry flag set for autorun
  ;LD DE,GET_DEVICE_687
  LD DE,$AFF6
  ;; _LOAD+2:  OR $AF	-> __LOAD
  ;; _LOAD+3:  XOR A	-> __MERGE
  PUSH AF
  CALL FILE_PARMS
  JP Z,MERGE_SUB
  LD A,D
  CP $F9
  JP Z,MERGE_SUB
  CP $FD
  JP Z,GETWORD_243
  RST $38
  DEFB $1C		; HMERG, Offset: 28
  
; This entry point is used by the routine at GETWORD.
__MERGE_0:
  POP AF
  PUSH AF
  JP Z,_LOAD_0
  LD A,(HL)
  SUB ','
  OR A
  JP NZ,_LOAD_0
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'R'
  POP AF
  SCF
; This entry point is used by the routine at GET_DEVICE.
__MERGE_1:
  PUSH AF
_LOAD_0:
  PUSH AF
  XOR A
  LD E,$01
  CALL _OPEN
  
; This entry point is used by the routine at GETWORD.
__MERGE_3:
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
  LD (FILFLG),A
  LD A,(HL)
  OR A
  JP M,__SAVE_3
  
  POP AF
  CALL NZ,CLRPTR
  CALL CLSALL		; Close all files
  XOR A
  CALL SETFIL
  JP PROMPT
  
__SAVE:
  CALL FILE_PARMS
  JP Z,__LCOPY_6
  LD A,D
  CP $F9
  JP Z,__LCOPY_6
  CP $FD
  JP Z,GETWORD_227
  RST $38
  JR $4FB3
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD E,$80
  SCF
  JP Z,SCPTLP_78
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  OR A
  LD E,$02
SCPTLP_78:
  PUSH AF
  LD A,D
  CP $09
  JP C,__SAVE_1
  LD A,E
  AND $80
  JP Z,__SAVE_1
  LD E,$02
  POP AF
  XOR A
  PUSH AF
; This entry point is used by the routine at GETWORD.
__SAVE_1:
  XOR A
  CALL _OPEN
  POP AF
  JP C,__SAVE_2
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __LIST
__SAVE_2:
  RST $38
  INC H
  JP NMERR
  
__SAVE_3:
  RST $38
  DEFB $26		; Offset: 38
  JP NMERR


; This entry point is used by the routines at __KILL, _CLREG, __END, __MERGE
; and __MAX.
; Close all files
CLSALL:
  LD A,(NLONLY)
  OR A
  RET M

; Routine at 20007
CLOSE_FN:
  XOR A
  
__CLOSE:
  LD A,(MAXFIL)
  JP NZ,__CLOSE_1
  PUSH HL
SCPTLP_82:
  PUSH AF
  CALL CLOSE1
  POP AF
  DEC A
  JP P,SCPTLP_82
  POP HL
  RET
  
__CLOSE_1:
  LD A,(HL)
  CP '#'
  CALL Z,_CHRGTB
  CALL GETINT
  PUSH HL
  CALL CLOSE1
  POP HL
  LD A,(HL)
SCPTLP_84:
  CP ','
  RET NZ
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __CLOSE_1
  
OUTC_FOUT:
  POP HL
  POP AF
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,(PTRFIL)
  LD A,$04
  CALL __CLOSE_3
  RST $38
  LD ($E4C3),HL
  LD D,C
  
__CLOSE_3:
  PUSH AF
  PUSH DE
  EX DE,HL
  LD HL,$0004
  ADD HL,DE
  LD A,(HL)
  EX DE,HL
  POP DE
  CP $09
  JP C,INIT_PRINT_h_1
  POP AF
  EX (SP),HL
  POP HL
  JP GET_DEVICE

; This entry point is used by the routines at GETWORD and ISFLIO.
RDBYT:
  PUSH BC
  PUSH HL
  PUSH DE
  LD HL,(PTRFIL)
  LD A,$06
  CALL __CLOSE_3
  RST $38
  DEFB $0A		; Offset: 10
  JP NMERR

; Routine at 20517
;
; Used by the routines at L1A3C and RAM_IO.
RDBYT_0:
  POP DE
  POP HL
  POP BC
  RET
  
; This entry point is used by the routine at OPRND.
SCPTLP_88:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  INC H
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  JR Z,$5014
  LD HL,(PTRFIL)
  PUSH HL
  LD HL,$0000
  LD (PTRFIL),HL			; Redirect I/O
  POP HL
  EX (SP),HL
  CALL GETINT
  PUSH DE
  LD A,(HL)
  CP ','
  JP NZ,SCPTLP_89
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL SCPTLP_64
  CP $01
  JP NZ,$51F9
  POP HL
  XOR A
  LD A,(HL)
SCPTLP_89:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  ADD HL,HL
  POP AF
  EX (SP),HL
  PUSH AF
  LD A,L
  OR A
  JP Z,FCERR
  PUSH HL
  CALL MKTMST
  EX DE,HL
  POP BC
SCPTLP_90:
  POP AF
  PUSH AF
  JP Z,SCPTLP_93
  CALL CHGET
  CP $03
  JP Z,SCPTLP_92
SCPTLP_91:
  LD (HL),A
  INC HL
  DEC C
  JP NZ,SCPTLP_90
  POP AF
  POP BC
  POP HL
  RST $38
  LD (DE),A
  LD (PTRFIL),HL			; Redirect I/O
  PUSH BC
  JP TSTOPL
SCPTLP_92:
  POP AF
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  POP HL
  JP WORDS_1
SCPTLP_93:
  CALL RDBYT
  JP C,$51F9
  JP SCPTLP_91
SCPTLP_94:
  CALL SCPTLP_98
  PUSH HL
  LD B,$00
  CALL SCPTLP_96
SCPTLP_95:
  POP HL
  RET
; This entry point is used by the routine at GET_DEVICE.
SCPTLP_96:
  XOR A
SCPTLP_97:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,SCPTLP_97
  RET
SCPTLP_98:
  LD HL,(PTRFIL)
  LD DE,$0009
  ADD HL,DE
  RET
INIT_PRINT_h_1:
  POP AF
  RET
; This entry point is used by the routine at SNERR.
SCPTLP_100:
  CALL ISFLIO
  JP Z,EXEC
  XOR A
  CALL CLOSE1
  JP $51EA
; This entry point is used by the routine at __DATA.
SCPTLP_101:
  LD C,$01
; This entry point is used by the routine at __DATA.
SCPTLP_102:
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
  JP Z,SCPTLP_103
  JP BNERR

SCPTLP_103:
  LD A,(HL)
  RET

; This entry point is used by the routines at SNERR, GETWORD, ISFLIO and
; GET_DEVICE.
SCPTLP_104:
  LD BC,$4066
  PUSH BC
  XOR A
  JP CLOSE1

; This entry point is used by the routine at __DATA.
SCPTLP_105:
  RST GETYPR 		; Get the number type (FAC)
  LD BC,$1012
  LD DE,$2C20
  JP NZ,SCPTLP_107
  LD E,D
  JP SCPTLP_107

; This entry point is used by the routine at __DATA.
SCPTLP_106:
  LD BC,FINPRT
  PUSH BC
  CALL SCPTLP_101
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  LD BC,$0CB0
  XOR A
  LD D,A
  LD E,A
SCPTLP_107:
  PUSH AF
  PUSH BC
  PUSH HL
SCPTLP_108:
  CALL RDBYT
  JP C,$51F9
  CP ' '
  JP NZ,SCPTLP_109
  INC D
  DEC D
  JP NZ,SCPTLP_108
SCPTLP_109:
  CP '"'
  JP NZ,SCPTLP_110
  LD A,E
  CP ','
  LD A,$22
  JP NZ,SCPTLP_110
  LD D,A
  LD E,A
  CALL RDBYT
  JP C,SCPTLP_115
SCPTLP_110:
  LD HL,$F5A1
  LD B,$FF
SCPTLP_111:
  LD C,A
  LD A,D
  CP '"'
  LD A,C
  JP Z,SCPTLP_113
  CP $0D
  PUSH HL
  JP Z,SCPTLP_117
  POP HL
  CP $0A
  JP NZ,SCPTLP_113
SCPTLP_112:
  LD C,A
  LD A,E
  CP ','
  LD A,C
  CALL NZ,USING2
  CALL RDBYT
  JP C,SCPTLP_115
  CP $0A
  JP Z,SCPTLP_112
  CP $0D
  JP NZ,SCPTLP_113
  LD A,E
  CP ' '
  JP Z,SCPTLP_114
  CP ','
  LD A,$0D
  JP Z,SCPTLP_114
SCPTLP_113:
  OR A
  JP Z,SCPTLP_114
  CP D
  JP Z,SCPTLP_115
  CP E
  JP Z,SCPTLP_115
  CALL USING2
SCPTLP_114:
  CALL RDBYT
  JP NC,SCPTLP_111
SCPTLP_115:
  PUSH HL
  CP '"'
  JP Z,SCPTLP_116
  CP ' '
  JP NZ,SCPTLP_119
SCPTLP_116:
  CALL RDBYT
  JP C,SCPTLP_119
  CP ' '
  JP Z,SCPTLP_116
  CP ','
  JP Z,SCPTLP_119
  CP $0D
  JP NZ,SCPTLP_118
SCPTLP_117:
  CALL RDBYT
  JP C,SCPTLP_119
  CP $0A
  JP Z,SCPTLP_119
SCPTLP_118:
  LD HL,(PTRFIL)
  LD C,A
  LD A,$08
  CALL __CLOSE_3
  RST $38
  INC D
  JP NMERR
; This entry point is used by the routine at GETWORD.
SCPTLP_119:
  POP HL
USING0:
  LD (HL),$00
  LD HL,BUFMIN
  LD A,E
  SUB $20
  JP Z,USING1
  LD B,$00
  CALL QTSTR_0
  POP HL
  RET
USING1:
  RST GETYPR 		; Get the number type (FAC)
  PUSH AF
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH AF
  CALL C,DBL_ASCTFP
  POP AF
  CALL NC,DBL_DBL_ASCTFP
  POP HL
  RET
USING2:
  OR A
  RET Z
  LD (HL),A
  INC HL
  DEC B
  RET NZ
  POP AF
  JP USING0
; This entry point is used by the routine at GETWORD.
NMERR:
  LD E,$37
  LD BC,$351E
  LD BC,$381E
  LD BC,$341E
  LD BC,$3A1E
  LD BC,$331E
  LD BC,FP_ARG2HL
USING4:
  LD BC,$361E
  LD BC,_DBL_ASCTFP_37
  JP ERROR
  RST $38
  LD (HL),H
  RST $38
  HALT
__LFILES:
  RST $38
  LD A,B
__DSKO_S:
  RST $38
  LD A,H
; This entry point is used by the routine at OPRND.
USING5:
  RST $38
  LD A,D
__LOF:
  RST $38
  ADC A,(HL)
  RST $38
  SUB B
__FORMAT:
  RST $38
  SUB D
USING6:
  RST $38
  LD HL,($FE7E)
  LD A,(FCOMP_14)
  LD D,D
  PUSH HL
  LD D,E
  CALL SCPTLP_61
  JP Z,USING8
USING7:
  CP $3A
  JP Z,$5237
  CALL SCPTLP_61
  JP P,USING7
USING8:
  LD E,D
  POP HL
  XOR A
  RST $38
  INC L
  RET
  RST $38
  JR NC,USING4
  CALL PO,GET_DEVICE_608
  SUB E
  DEC A
  CP $02
  JP NC,$5244
  RST $38
  LD L,$C3
  CALL PO,PTRFIL_1
  DEC B
  JP NC,NMERR			; NM error: bad file name
  POP BC
  PUSH DE
  PUSH BC
  LD C,A
  LD B,A
  LD DE,$528D
  EX (SP),HL
  PUSH HL
USING9:
  CALL UCASE_HL
  PUSH BC
  LD B,A
  LD A,(DE)
  INC HL
  INC DE
  CP B
  POP BC
  JP NZ,USING_02
  DEC C
  JP NZ,USING9
USING_00:
  LD A,(DE)
  OR A
  JP M,USING_01
  CP $31
  JP NZ,USING_02
  INC DE
  LD A,(DE)
  JP USING_02
USING_01:
  POP HL
  POP HL
  POP DE
  OR A
  RET
USING_02:
  OR A
  JP M,USING_00
USING_03:
  LD A,(DE)
  OR A
  INC DE
  JP P,USING_03
  LD C,B
  POP HL
  PUSH HL
  LD A,(DE)
  OR A
  JP NZ,USING9
  JP NMERR
  LD C,H
  LD B,E
  LD B,H
  RST $38
  LD B,E
  LD D,D
  LD D,H
  CP $43
  LD B,C
  LD D,E
  DEFB $FD
  LD B,E
  LD C,A
  LD C,L
  CALL M,$4157
  LD C,(HL)
  LD B,H
  EI
  LD C,H
  LD D,B
  LD D,H
  JP M,$4152
  LD C,L
  LD SP,HL
  NOP

; Data block at 21163
;
; Device vector
DEVICE_VECT:
  DEFW L1942
  DEFW CRT_CTL
  DEFW L1AF7
  DEFW L1BDA
  DEFW L1CEC
  DEFW L1BCC
  DEFW RAM_CTL

; Get the device table associated to dev# in A
;
; Used by the routines at GETWORD and SCPTLP.
GET_DEVICE:
  RST $38
  LD ($D5E5),A
  PUSH AF
  LD DE,$0004
  ADD HL,DE
  LD A,$FF
  SUB (HL)
  ADD A,A
  LD E,A
  LD D,$00
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

GET_DEVICE_0:
  RST $38
  LD C,B
  CALL ISFLIO_5
  LD HL,$5334
  CALL ISFLIO_21
  JP GET_DEVICE_4
GET_DEVICE_1:
  RST $38
  LD D,(HL)
  CALL __BEEP
  LD HL,$5334
  CALL STFNK
GET_DEVICE_2:
  CALL STKINI
  LD HL,GET_DEVICE_1
  LD (ERRTRP),HL
  LD HL,$5318
  CALL GET_DEVICE_42
  CALL ERAEOL3
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  JP Z,GET_DEVICE_2
  EX DE,HL
  LD HL,($F3C0)
  EX DE,HL
  CALL GET_DEVICE_390
  JP Z,GET_DEVICE_1
  RET

  LD D,H
  LD H,L
  LD L,H
  LD H,E
  LD L,A
  LD L,L
  LD A,(OUTC)
  LD D,E
  LD D,H
  LD B,C
  LD D,H
  LD C,L
  LD D,E
  LD D,H
  LD B,L
  LD D,D
  LD C,L
  ADC A,B
  LD D,E
  LD C,L
  LD B,L
  LD C,(HL)
  LD D,L
  LD B,L
  LD D,(HL)
  RST $38
  NOP
  NOP
  NOP
  LD D,E
  LD (HL),H
  LD H,C
  LD (HL),H
  JR NZ,GET_DEVICE_3
GET_DEVICE_3:
  LD D,H
  LD H,L
  LD (HL),D
  LD L,L
  DEC C
  NOP
  NOP
  NOP
  NOP
  NOP
  LD C,L
  LD H,L
  LD L,(HL)
  LD (HL),L
  DEC C
  NOP
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  JP NZ,GET_DEVICE_6
GET_DEVICE_4:
  LD HL,$F406
  LD B,$06
GET_DEVICE_5:
  LD A,(HL)
  RST OUTC
  INC HL
  DEC B
  JP NZ,GET_DEVICE_5
  JP GET_DEVICE_2
GET_DEVICE_6:
  CALL GETWORD_91
  CALL GET_DEVICE_432
  JP GET_DEVICE_2
  
  JR NZ,GET_DEVICE_9
  LD (HL),D
  LD H,L
  HALT
  NOP
  NOP
  NOP
  JR NZ,GET_DEVICE_7
  LD D,L
  LD (HL),B
  NOP
  JR NZ,$53BE
  LD L,A
  LD (HL),A
  LD L,(HL)
  NOP
  NOP
  NOP
  NOP
  NOP
  JR NZ,$53A4
  LD B,D
  LD A,C
  LD H,L
  NOP
  RST $38
  LD C,D
  LD HL,$F406
  CALL GETWORD_91
  LD A,$40
  LD (FNK_FLAG),A
GET_DEVICE_7:
  LD ($F45C),A
  XOR A
  LD (CAPTUR),A
  LD ($F9B3),A
  CALL CLR_ALTLCD
  LD HL,$536B
  CALL STFNK
  CALL GET_DEVICE_22
  CALL GET_DEVICE_23
  CALL ISFLIO_22
  CALL ISFLIO_6
GET_DEVICE_8:
  CALL RESTAK
  LD HL,$5427
  LD (ERRTRP),HL
GET_DEVICE_9:
  CALL CHSNS
  JP Z,GET_DEVICE_10
  CALL CHGET
  LD B,A
  JP C,GET_DEVICE_18
  AND A
  CALL NZ,GET_DEVICE_415
  JP C,GET_DEVICE_16
  LD A,($F403)
  AND A
  LD A,B
  JP Z,GET_DEVICE_11
GET_DEVICE_10:
  CALL RCVX
  JP Z,GET_DEVICE_8
  CALL RV232C
GET_DEVICE_11:
  LD B,A
  JP C,GET_DEVICE_8
  JP Z,GET_DEVICE_12
  LD A,$82
GET_DEVICE_12:
  CP $7F
  JP NZ,GET_DEVICE_13
  LD A,(CSRY)
  DEC A
  LD A,B
GET_DEVICE_13:
  CALL NZ,_OUTC
  CALL GET_DEVICE_14
  CALL GET_DEVICE_37
  JP GET_DEVICE_8
GET_DEVICE_14:
  LD B,A
  LD A,($F404)
  AND A
  LD A,B
  RET Z
  LD HL,OUTC_TABEXP
; This entry point is used by the routine at _DBL_ASCTFP.
GET_DEVICE_15:
  PUSH HL
  CP ' '
  RET NC
  CP $1B
  RET Z
  POP HL
  CP $08
  RET C
  CP $0E			; Line number prefix
  RET NC
  JP (HL)
  
GET_DEVICE_16:
  XOR A
  LD ($FE40),A
GET_DEVICE_17:
  CALL GET_DEVICE_494
  JP C,GET_DEVICE_17
  JP GET_DEVICE_8
  CALL __BEEP
  XOR A
  LD ($F404),A
  CALL GET_DEVICE_23
  JP GET_DEVICE_8
GET_DEVICE_18:
  LD E,A
  LD D,$FF
  LD HL,($F3C2)
  ADD HL,DE
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD DE,GET_DEVICE_8
  PUSH DE
  JP (HL)
  LD E,C
  LD D,H
  LD (HL),H
  LD D,H
  ADD A,(HL)
  LD D,H
  PUSH BC
  LD D,H
  LD D,B
  LD D,L
  OR H
  LD D,E
  OR H
GET_DEVICE_19:
  LD D,E
  OR H
  LD D,E
  OR H
  LD D,E
  RET P
  LD D,L
  CALL TTY_JP_0_1
  CALL ISFLIO_7
GET_DEVICE_20:
  CALL ISFLIO_82
GET_DEVICE_21:
  CALL CHSNS
  JP Z,GET_DEVICE_21
  CALL CHGET
  CALL ISFLIO_79
  CALL ISFLIO_6
  JP ISFLIO_11
  LD HL,$F403
  LD A,(HL)
  CPL
  LD (HL),A
GET_DEVICE_22:
  LD A,($F403)
  LD DE,$F6B5
  LD HL,$54AD
  JP GET_DEVICE_24
  LD HL,$F404
  LD A,(HL)
  CPL
  LD (HL),A
GET_DEVICE_23:
  LD A,($F404)
  LD DE,$F6C5
  LD HL,$54B5
GET_DEVICE_24:
  AND A
  LD BC,$0004
  JP NZ,GET_DEVICE_25
  ADD HL,BC
GET_DEVICE_25:
  LD B,C
  CALL LDIR_B
  LD B,$0C
  XOR A
GET_DEVICE_26:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,GET_DEVICE_26
  JP GET_DEVICE_152
  LD B,(HL)
  LD (HL),L
  LD L,H
  LD L,H
  LD C,B
  LD H,C
  LD L,H
  LD H,(HL)
  LD B,L
  LD H,E
  LD L,B
  LD L,A
  JR NZ,$54DB
  JR NZ,GET_DEVICE_28
  DEC C
  JR NZ,GET_DEVICE_30
  LD H,C
  LD L,C
  LD (HL),H
  JR NZ,GET_DEVICE_27
GET_DEVICE_27:
  LD HL,$55C1
  LD (ERRTRP),HL
  PUSH HL
  LD A,(CAPTUR)
  AND A
  RET NZ
  CALL RESFPT_0
  LD HL,$560A
  CALL GET_DEVICE_42
  CALL ERAEOL2
GET_DEVICE_28:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  RET Z
  LD ($F9B6),A
  CALL COUNT_CHARS
  CALL FNAME
  RET NZ
  CALL FINDCO_0
  LD HL,$5635
  JP Z,GET_DEVICE_42
  EX DE,HL
  EX (SP),HL
  LD A,$01
  LD ($F9B3),A
  CALL GET_DEVICE_152
  POP HL
GET_DEVICE_29:
  LD A,(HL)
  CP $1A		; EOF
  RST $38
  LD E,D
  JP Z,GET_DEVICE_32
  CP $0A
  JP NZ,GET_DEVICE_30
  LD A,($F405)
  AND A
  JP NZ,GET_DEVICE_30
  LD A,($F9B6)
  CP $0D
GET_DEVICE_30:
  LD A,(HL)
  LD ($F9B6),A
  JP Z,GET_DEVICE_31
  CALL GET_DEVICE_415
  CALL GET_DEVICE_33
GET_DEVICE_31:
  INC HL
  CALL CHSNS
  JP Z,GET_DEVICE_29
  CALL CHGET
  CP $03
  JP Z,GET_DEVICE_32
  CP $13
  CALL Z,CHGET
  CP $03
  JP NZ,GET_DEVICE_29
GET_DEVICE_32:
  XOR A
  LD ($F9B3),A
  JP GET_DEVICE_152
GET_DEVICE_33:
  CALL RCVX
  RET Z
  CALL RV232C
  RET C
  RST OUTC
  JP GET_DEVICE_33
  CALL RESFPT_0
  LD A,(CAPTUR)
  XOR $FF
  LD (CAPTUR),A
  JP Z,GET_DEVICE_36
  LD HL,$55B4
  LD (ERRTRP),HL
  PUSH HL
  LD HL,$5619
  CALL GET_DEVICE_42
  CALL ERAEOL2
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  RET Z
  LD ($F9B6),A
  POP AF
GET_DEVICE_34:
  PUSH HL
  CALL OPENDO
  JP C,GET_DEVICE_35
  LD ($F9B4),HL
  CALL GET_DEVICE_370
  POP AF
  CALL GET_DEVICE_266
  JP GET_DEVICE_152
GET_DEVICE_35:
  EX DE,HL
  CALL KILLASC+1
  POP HL
  JP GET_DEVICE_34
GET_DEVICE_36:
  CALL GET_DEVICE_152
  JP GET_DEVICE_270
GET_DEVICE_37:
  LD C,A
  LD A,(CAPTUR)
  AND A
  LD A,C
  RET Z
  CALL GET_DEVICE_40
  RET Z
  JP NC,GET_DEVICE_38
  CALL GET_DEVICE_38
  LD A,$0A
GET_DEVICE_38:
  LD HL,($F9B4)
  CALL GET_DEVICE_272
  LD ($F9B4),HL
  RET NC
  XOR A
  LD (CAPTUR),A
  CALL GET_DEVICE_152
  LD HL,$5621
  JP GET_DEVICE_39
  LD HL,$5612
GET_DEVICE_39:
  CALL GET_DEVICE_42
  LD HL,$562A
  CALL PRS
  JP GET_DEVICE_8
; This entry point is used by the routine at GETWORD.
GET_DEVICE_40:
  LD C,A
  AND A
  RET Z
  CP $1A		; EOF
  RET Z
  CP $7F
  RET Z
  CP $0A
  JP NZ,GET_DEVICE_41
  LD A,($F9B6)
  CP $0D
GET_DEVICE_41:
  LD A,C
  LD ($F9B6),A
  RET Z
  CP $0D
  SCF
  CCF
  RET NZ
  AND A
  SCF
  RET
  CALL CONSOLE_CRLF
  RST $38
  LD C,H
  XOR A
  LD (FNK_FLAG),A
  LD L,A
  LD H,A
  LD (CAPTUR),HL
  CALL GET_DEVICE_432
  CALL ISFLIO_7
  CALL GET_DEVICE_268
  JP GET_DEVICE_0
  LD B,(HL)
  LD L,C
  LD L,H
  LD H,L
  JR NZ,$5684
  LD L,A
  JR NZ,GET_DEVICE_43
  LD (HL),B
  LD L,H
  LD L,A
  LD H,C
  LD H,H
  NOP
  LD B,(HL)
  LD L,C
  LD L,H
  LD H,L
  JR NZ,$5693
  LD L,A
  JR NZ,$5666
  LD L,A
  LD (HL),A
  LD L,(HL)
  LD L,H
  LD L,A
  LD H,C
  LD H,H
  NOP
  JR NZ,$568D
  LD H,D
  LD L,A
  LD (HL),D
  LD (HL),H
  LD H,L
  LD H,H
  DEC C
  LD A,(BC)
  NOP
  LD C,(HL)
  LD L,A
  JR NZ,GET_DEVICE_45
  LD L,C
  LD L,H
  LD H,L
  DEC C
  LD A,(BC)
  NOP
; This entry point is used by the routine at GETWORD.
GET_DEVICE_42:
  CALL CONSOLE_CRLF
  JP PRS
; This entry point is used by the routine at GETWORD.
__MENU:
  SUB A
  LD (PRTFLG),A
  CALL _CLVAR
  CALL GET_DEVICE_432
  CALL GET_DEVICE_268
  CALL RESFPT
  CALL GET_DEVICE_298
  LD A,' '
  LD (FNK_FLAG),A
  LD A,$FF
  LD ($F9BA),A
  LD A,($F3E4)
  LD ($F59C),A
GET_DEVICE_43:
  SUB A
  LD ($F3F2),A
  LD ($F590),A
  CALL GETWORD_151
  CALL ISFLIO_16
  CALL ISFLIO_7
  CALL ISFLIO_4
GET_DEVICE_44:
  CALL STKINI
  SUB A
  LD ($F9BB),A
  CALL ISFLIO_20
  LD HL,GET_DEVICE_44
  LD (ERRTRP),HL
  CALL GET_DEVICE_137
  LD HL,GETWORD_50
  CALL POSIT
  LD HL,$7FAF
  CALL GET_DEVICE_139
  LD A,$23
  RST OUTC
  IN A,($A0)
GET_DEVICE_45:
  AND $0C
  RRCA
  RRCA
  CP $01
  ADC A,$30
  RST OUTC
  LD HL,$F543
  LD ($F579),HL
  LD B,$36
GET_DEVICE_46:
  LD (HL),$FF
  INC HL
  DEC B
  JP NZ,GET_DEVICE_46
  LD L,B
  LD DE,$5E61
  LD A,$B0
GET_DEVICE_47:
  LD C,A
  PUSH DE
  CALL GET_DEVICE_129
  POP DE
  LD A,(DE)
  INC DE
  OR A
  JP NZ,GET_DEVICE_47
  LD A,L
  LD ($F591),A
GET_DEVICE_48:
  CP $18
  JP Z,GET_DEVICE_49
  CALL GET_DEVICE_135
  PUSH HL
  LD HL,$0003
  CALL GET_DEVICE_139
  POP HL
  INC L
  LD A,L
  JP GET_DEVICE_48
GET_DEVICE_49:
  LD A,($F590)
  LD L,A
  CALL GET_DEVICE_54
  CALL GET_DEVICE_146
  LD HL,$2208
  CALL POSIT
  CALL FREEMEM
  LD HL,FBUFFR+1
  LD DE,$F6E5
  LD B,$01
  CALL GET_DEVICE_148
GET_DEVICE_50:
  SUB A
  LD ($F9BB),A
  CALL SCPTLP_104
  CALL PRINT_TDATE
  CALL ISFLIO_22
  LD HL,$F999
  SUB A
  CP (HL)
  JP Z,GET_DEVICE_52
  LD (HL),A
  LD HL,$F84F
  LD B,$1B
GET_DEVICE_51:
  LD A,(HL)
  INC A
  JP Z,GET_DEVICE_52
  DEC A
  CP $C4
  JP Z,GET_DEVICE_59
  CALL GET_DEVICE_189
  JP NZ,GET_DEVICE_51
GET_DEVICE_52:
  OR $97
  CALL Z,__BEEP
  CALL STKINI
  LD HL,$572D
  LD (ERRTRP),HL
  CALL TEXT
  JP C,GET_DEVICE_69
  CP $0D
  JP Z,GET_DEVICE_66
  LD BC,$573A
  PUSH BC
  CP ' '
  JP C,GET_DEVICE_53
  RET NZ
  LD A,$1C
GET_DEVICE_53:
  LD HL,($F590)
  LD E,L
  SUB $1C
  RET M
  LD BC,$576E
  PUSH BC
  JP Z,GET_DEVICE_58
  DEC A
  JP Z,GET_DEVICE_57
  DEC A
  POP BC
  JP Z,GET_DEVICE_56
  LD A,E
  ADD A,$04
  LD D,A
  CP H
  RET P
  LD ($F590),A
  LD L,E
  PUSH DE
  CALL GET_DEVICE_54
  POP DE
  LD L,D
GET_DEVICE_54:
  CALL $7426
  CALL GET_DEVICE_135
  LD B,$0A
  PUSH HL
  LD HL,CSRY
  DEC (HL)
GET_DEVICE_55:
  PUSH BC
  PUSH DE
  LD HL,(CSRX)
  CALL ESC_J_9
  EX DE,HL
  CALL MOVE_CURSOR
  DI
  CALL SET_CURSOR_SHAPE
  EI
  POP DE
  LD HL,CSRY
  INC (HL)
  POP BC
  DEC B
  JP NZ,GET_DEVICE_55
  CALL $7426
  POP HL
  RET
GET_DEVICE_56:
  LD A,E
  SUB $04
  LD D,A
  RET M
  PUSH BC
  RET
GET_DEVICE_57:
  LD A,E
  DEC A
  LD D,A
  RET P
  LD D,H
  DEC D
  LD A,D
  RET
GET_DEVICE_58:
  LD A,E
  INC A
  LD D,A
  CP H
  RET M
  SUB A
  LD D,A
  RET
GET_DEVICE_59:
  CALL GET_DEVICE_160
  EX DE,HL
  LD HL,$F7E6
  PUSH HL
  LD B,$40
  CALL GET_DEVICE_65
  LD (HL),$00
  INC HL
  LD (HL),$00
  POP DE
  LD HL,$F57B
  LD BC,$0A00
GET_DEVICE_60:
  LD A,(DE)
  CP '.'
  JP NZ,GET_DEVICE_61
  LD C,$7F
GET_DEVICE_61:
  INC C
  CALL M,UCASE
  OR A
  JP Z,GET_DEVICE_63
  CP $0D
  JP Z,GET_DEVICE_62
  LD (HL),A
  INC DE
  INC HL
  DEC B
  JP NZ,GET_DEVICE_60
  JP $572D
GET_DEVICE_62:
  INC DE
GET_DEVICE_63:
  LD (HL),$00
  PUSH DE
  CALL GET_DEVICE_154
  JP Z,$572D
  PUSH HL
  CALL CHSNS
  JP Z,GET_DEVICE_64
  CALL CHGET
  CP $03
  JP Z,$572D
GET_DEVICE_64:
  POP DE
  POP HL
  LD ($F3E0),HL
  EX DE,HL
  JP GET_DEVICE_67
GET_DEVICE_65:
  LD A,(DE)
  CP $1A		; EOF
  RET Z
  LD (HL),A
  INC HL
  INC DE
  DEC B
  RET Z
  JP GET_DEVICE_65
GET_DEVICE_66:
  CALL GET_DEVICE_158
GET_DEVICE_67:
  PUSH HL
  CALL ISFLIO_20
  CALL __CLS
  CALL ISFLIO_5
  LD A,($F59C)
  CALL GETWORD_151
  CALL ISFLIO_3
  LD A,$0C
  RST OUTC
  CALL ISFLIO_5
  CALL ISFLIO_16
  CALL ISFLIO_12
  SUB A
  LD ($F9BA),A
  LD (FNK_FLAG),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  POP HL
  LD A,(HL)
  AND $F0
  CALL GET_DEVICE_160
  CP $A0
  JP Z,GETWORD_269
  CP $B0
  JP Z,GET_DEVICE_68
  CP $F0
  JP Z,GET_DEVICE_702
  CP $C0
  JP Z,GET_DEVICE_209
  CP $80
  JP NZ,GET_DEVICE_44
  LD (BASTXT),HL
  DEC DE
  DEC DE
  EX DE,HL
  LD (DIRPNT),HL
  CALL UPD_PTRS
  CALL GET_DEVICE_388
  CALL ISFLIO_22
  CALL RUN_FST
  JP EXEC_EVAL
GET_DEVICE_68:
  JP (HL)
GET_DEVICE_69:
  LD HL,GET_DEVICE_70
  LD (ERRTRP),HL
  PUSH AF
  LD A,$FF
  LD ($F9BB),A
  CALL ISFLIO_20
  POP AF
  SUB $F7
  JP C,GET_DEVICE_80
  CP $08
  JP Z,$7EAB
  CP $05
  JP Z,GET_DEVICE_93
  OR A
  PUSH AF
  CALL GET_DEVICE_158
  PUSH HL
  CALL GET_DEVICE_160
  EX DE,HL
  POP HL
  LD A,(HL)
  LD C,A
  POP AF
  PUSH AF
  CP $01
  LD A,C
  JP Z,GET_DEVICE_107
  AND $10
  JP NZ,GET_DEVICE_70
  LD A,(HL)
  AND $60
  RLCA
  RLCA
  RLCA
  LD C,A
  POP AF
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH HL
  JP Z,GET_DEVICE_71
  DEC A
  DEC A
  JP Z,GET_DEVICE_96
  DEC A
  DEC A
  JP Z,GET_DEVICE_93
  CP $03
  JP Z,GET_DEVICE_105
GET_DEVICE_70:
  CALL SCPTLP_104
  CALL __BEEP
  CALL RESTAK
  JP GET_DEVICE_50
GET_DEVICE_71:
  CALL GET_DEVICE_92
  POP HL
  PUSH HL
  CALL GET_DEVICE_122
  LD HL,$5EDB
  CALL GET_DEVICE_139
  LD A,$0D
  CALL GET_DEVICE_111
  POP DE
  LD A,($F58F)
  OR A
  JP Z,GET_DEVICE_72
  DEC HL
  LD A,(HL)
  INC HL
  CP $3A
  JP NZ,GET_DEVICE_73
  DEC HL
  DEC HL
  LD A,(HL)
  INC HL
  INC HL
  CALL UCASE
  CP $4D
  JP Z,GET_DEVICE_73
GET_DEVICE_72:
  INC DE
  INC DE
  INC DE
  CALL GET_DEVICE_140
GET_DEVICE_73:
  LD (HL),$00
  POP BC
  DEC C
  JP M,GET_DEVICE_75
  JP NZ,$593A
  CALL GET_DEVICE_124
  POP HL
  PUSH DE
  CALL GETWORD_266
  POP DE
  RST $38
  LD A,($60C3)
  LD H,$CD
  PUSH HL
  LD E,H
  POP HL
GET_DEVICE_74:
  LD A,(HL)
  RST OUTC
  INC HL
  CP $1A		; EOF
  JP NZ,GET_DEVICE_74
  JP GET_DEVICE_50
GET_DEVICE_75:
  CALL GET_DEVICE_89
  LD A,D
  CP $FC
  JP Z,GET_DEVICE_76
  LD HL,$5EB2
  CALL GET_DEVICE_121
  CALL SHOW_TIME
  CALL CHGET_UCASE
  CP $0D
  JP Z,GET_DEVICE_79
  CP $42
  JP Z,GET_DEVICE_78
  CP $41
  JP NZ,GET_DEVICE_50
  RST OUTC
GET_DEVICE_76:
  CALL GET_DEVICE_126
GET_DEVICE_77:
  POP HL
  LD (BASTXT),HL
  SUB A
  JP __LIST
GET_DEVICE_78:
  RST OUTC
GET_DEVICE_79:
  CALL GET_DEVICE_124
  POP HL
  LD (BASTXT),HL
  RST $38
  JR C,$5947
  PUSH HL
  DEC H
GET_DEVICE_80:
  LD HL,__MENU
  LD (ERRTRP),HL
  LD HL,$5E79
  CALL GET_DEVICE_121
  LD HL,$5ED2
  CALL GET_DEVICE_139
  LD HL,$F57B
  LD DE,GET_DEVICE_164
  PUSH DE
  PUSH DE
  CALL GET_DEVICE_143
  LD (HL),$00
  POP DE
  LD HL,FILNAM
  CALL GET_DEVICE_142
  LD HL,$F99B
  POP DE
  CALL GET_DEVICE_142
  LD A,$0D
  CALL GET_DEVICE_111
  LD A,($F58F)
  LD D,$FD
  OR A
  JP Z,GET_DEVICE_85
  LD B,$0D
  LD DE,$F57B
GET_DEVICE_81:
  LD A,(DE)
  INC DE
  CP $3A
  JP Z,GET_DEVICE_82
  DEC B
  JP NZ,GET_DEVICE_81
  LD DE,$F57B
  JP GET_DEVICE_83
GET_DEVICE_82:
  LD A,(DE)
  OR A
  JP Z,GET_DEVICE_84
GET_DEVICE_83:
  LD HL,FILNAM
  CALL GET_DEVICE_144
GET_DEVICE_84:
  CALL GET_DEVICE_89
GET_DEVICE_85:
  PUSH DE
  CALL GET_DEVICE_92
  LD HL,$5EDC
  CALL GET_DEVICE_139
  LD A,$09
  CALL GET_DEVICE_111
  LD A,($F58F)
  CP $03
  JP C,GET_DEVICE_70
  DEC HL
  CALL UCASE_HL
  LD (HL),A
  LD ($F9A2),A
  DEC HL
  CALL UCASE_HL
  LD (HL),A
  LD ($F9A1),A
  DEC HL
  LD DE,$5E66
  LD A,(HL)
  CP '.'
  JP NZ,GET_DEVICE_70
  CALL GET_DEVICE_390
  JP Z,GET_DEVICE_70
  POP AF
  POP DE
  PUSH AF
  CP $C0
  JP Z,GET_DEVICE_86
  CALL GET_DEVICE_90
  JP Z,GET_DEVICE_70
GET_DEVICE_86:
  CALL GET_DEVICE_91
  JP Z,GET_DEVICE_70
  PUSH DE
  CALL GET_DEVICE_154
  JP Z,GET_DEVICE_87
  PUSH HL
  CALL GET_DEVICE_160
  PUSH HL
  CALL __BEEP
  CALL GET_DEVICE_127
  JP NZ,GET_DEVICE_50
  POP DE
  POP HL
  POP BC
  POP AF
  PUSH AF
  PUSH BC
  CP $A0
  CALL GET_DEVICE_106
  JP GET_DEVICE_88
GET_DEVICE_87:
  LD A,($F591)
  CP $18
  JP Z,GET_DEVICE_70
  CALL GET_DEVICE_125
GET_DEVICE_88:
  LD HL,$F99B
  LD DE,$F57B
  CALL GET_DEVICE_144
  SUB A
  LD ($F590),A
  POP DE
  POP AF
  JP GETWORD_212
GET_DEVICE_89:
  LD HL,$F57B
  CALL COUNT_CHARS
  CALL FNAME
  RET NZ
  LD D,$FD
  RET
GET_DEVICE_90:
  LD A,D
  CP $FC
  RET Z
GET_DEVICE_91:
  LD A,D
  CP $F9
  RET Z
  CP $FE
  RET Z
  CP $FF
  RET Z
  CP $FA
  RET Z
  LD HL,$5EA5
  LD A,(HL)
  RET
GET_DEVICE_92:
  LD HL,GET_DEVICE_161
  JP GET_DEVICE_121
GET_DEVICE_93:
  OR A
  PUSH AF
  LD HL,$F84F
  LD B,$1B
GET_DEVICE_94:
  LD A,(HL)
  INC A
  JP Z,GET_DEVICE_95
  DEC A
  AND $FB
  LD (HL),A
  CALL GET_DEVICE_189
  JP NZ,GET_DEVICE_94
GET_DEVICE_95:
  POP AF
  JP NZ,GET_DEVICE_44
  DEC C
  DEC C
  JP NZ,GET_DEVICE_70
  POP HL
  LD A,(HL)
  OR $04
  LD (HL),A
  JP GET_DEVICE_44
GET_DEVICE_96:
  POP HL
  POP BC
  DEC C
  JP Z,GET_DEVICE_70
  INC C
  PUSH HL
  JP Z,GET_DEVICE_101
  CALL GET_DEVICE_102
  LD HL,$5EF9
  CALL GET_DEVICE_139
  LD HL,$F3F6
  CALL GET_DEVICE_139
  LD HL,GET_DEVICE_170
  CALL GET_DEVICE_139
  LD A,$03
  PUSH AF
  CALL $5C13
  LD HL,$F57B
  POP BC
  PUSH HL
GET_DEVICE_97:
  LD A,(HL)
  CP '0'
  JP C,GET_DEVICE_98
  CP $3A
  JP NC,GET_DEVICE_98
  INC HL
  DEC B
  JP NZ,GET_DEVICE_97
GET_DEVICE_98:
  LD (HL),$00
  POP HL
  LD A,(HL)
  OR A
  CALL Z,GET_DEVICE_104
  CALL GETINT
  CP $0A
  JP C,GET_DEVICE_70
  CP $85
  JP NC,GET_DEVICE_70
  PUSH AF
  LD DE,$F3F6
  LD HL,$F57B
  CALL GET_DEVICE_299
  CALL GET_DEVICE_102
  POP AF
  POP HL
  PUSH HL
  PUSH AF
  CALL GET_DEVICE_103
  POP AF
  LD ($F3F5),A
  LD ($F4F8),A
  LD (PRTFLG),A
  LD A,$01
  LD ($F4F6),A
  LD ($F4F7),A
  CALL ISFLIO_0
  POP HL
  CALL GET_DEVICE_122
  CALL ISFLIO_0
  POP DE
  POP HL
GET_DEVICE_99:
  CALL GET_DEVICE_345
  LD A,D
  AND A
  INC A
  JP NZ,GET_DEVICE_99
; This entry point is used by the routines at MAKINT and GETWORD.
GET_DEVICE_100:
  SUB A
  LD ($F4F6),A
  LD (PRTFLG),A
  LD A,(ACTV_Y)
  LD ($F4F8),A
  JP GET_DEVICE_50
GET_DEVICE_101:
  CALL GET_DEVICE_102
  POP HL
  PUSH HL
  CALL GET_DEVICE_103
  CALL INIT_OUTPUT_0
  POP HL
  LD A,$FF
  LD (PRTFLG),A
  CALL GET_DEVICE_122
  CALL INIT_OUTPUT_0
  JP GET_DEVICE_77
GET_DEVICE_102:
  LD HL,GET_DEVICE_163
  JP GET_DEVICE_121
GET_DEVICE_103:
  CALL GET_DEVICE_122
  CALL GET_DEVICE_125
  LD HL,GET_DEVICE_100
  LD (ERRTRP),HL
  RET
GET_DEVICE_104:
  LD HL,$F3F6
  LD DE,$F57B
  JP GET_DEVICE_299
GET_DEVICE_105:
  LD HL,$5EA7
  CALL GET_DEVICE_121
  POP HL
  CALL GET_DEVICE_122
  CALL GET_DEVICE_127
  JP NZ,GET_DEVICE_50
  POP BC
  POP DE
  POP HL
  DEC C
  CALL GET_DEVICE_106
  SUB A
  LD ($F590),A
  JP GET_DEVICE_44

GET_DEVICE_106:
  JP Z,KILLBIN
  JP M,KILLASC_6
  JP KILLASC+1

GET_DEVICE_107:
  PUSH HL
  PUSH AF
  PUSH HL
  PUSH HL
  LD HL,GET_DEVICE_162
  CALL GET_DEVICE_121
  POP HL
  CALL GET_DEVICE_122
  LD HL,$5EDB
  CALL GET_DEVICE_139
  POP HL
  LD DE,$0009
  ADD HL,DE
  PUSH HL
  LD A,$06
  CALL $5C13
  POP DE
  POP AF
  CALL GET_DEVICE_153
  JP NZ,GET_DEVICE_70
  LD HL,$F57B
GET_DEVICE_108:
  LD A,(HL)
  OR A
  JP Z,GET_DEVICE_109
  CP $3A
  INC HL
  JP Z,GET_DEVICE_70
  JP GET_DEVICE_108
GET_DEVICE_109:
  POP HL
  INC HL
  INC HL
  INC HL
  LD DE,GET_DEVICE_164
  PUSH HL
  CALL GET_DEVICE_140
  POP HL
  LD DE,$F57B
GET_DEVICE_110:
  LD A,(DE)
  OR A
  JP Z,GET_DEVICE_44
  CP '.'
  JP Z,GET_DEVICE_44
  LD (HL),A
  INC DE
  INC HL
  JP GET_DEVICE_110
GET_DEVICE_111:
  PUSH AF
  LD A,$FF
  LD DE,$97F5
  LD ($F5A3),A
  POP AF
  LD ($F5A2),A
  SUB A
  LD ($F58F),A
  LD HL,$F57B
GET_DEVICE_112:
  CALL TEXT
  JP C,GET_DEVICE_112
  CP $08
  JP Z,GET_DEVICE_120
  CP $7F
  JP Z,GET_DEVICE_120
  CP $1D
  JP Z,GET_DEVICE_120
  CP $03
  JP Z,GET_DEVICE_70
  CP $0D
  JP Z,GET_DEVICE_114
  CP '.'
  CALL Z,GET_DEVICE_118
  CP ' '
  JP C,GET_DEVICE_112
  LD C,A
  LD A,($F5A2)
  LD E,A
  LD A,($F58F)
  CALL Z,$5C99
  CP E
  JP Z,GET_DEVICE_119
  
  INC A
  LD ($F58F),A
  LD (HL),C
  INC HL
  PUSH HL
  LD A,C
  RST OUTC
  LD HL,$5EDF
GET_DEVICE_113:
  CALL GET_DEVICE_139
  POP HL
  JP GET_DEVICE_112

GET_DEVICE_114:
  PUSH HL
  LD HL,$F57B
  LD A,($F58F)
  OR A
  JP Z,GET_DEVICE_117
  LD E,A
  LD D,$01
GET_DEVICE_115:
  LD A,(HL)
  CP $3A
  JP NZ,GET_DEVICE_116
  DEC D
GET_DEVICE_116:
  DEC E
  INC HL
  JP NZ,GET_DEVICE_115
  LD A,D
  OR A
  JP M,GET_DEVICE_70
GET_DEVICE_117:
  POP HL
  LD (HL),$00
  RET
GET_DEVICE_118:
  LD A,($F5A3)
  OR A
  LD A,'.'
  RET NZ
  LD DE,$C0B7
  POP AF
GET_DEVICE_119:
  CALL __BEEP
  JP GET_DEVICE_112
GET_DEVICE_120:
  LD A,($F58F)
  OR A
  JP Z,GET_DEVICE_119
  DEC A
  LD ($F58F),A
  DEC HL
  PUSH HL
  LD HL,$5ECC
  JP GET_DEVICE_113
GET_DEVICE_121:
  PUSH HL
  LD HL,$0108
  CALL POSIT
  JP GET_DEVICE_123
GET_DEVICE_122:
  EX DE,HL
  LD HL,$F57B
  PUSH HL
  CALL GET_DEVICE_132
GET_DEVICE_123:
  POP HL
  JP GET_DEVICE_139
GET_DEVICE_124:
  CALL GET_DEVICE_89
  CALL GET_DEVICE_90
  JP Z,GET_DEVICE_70
GET_DEVICE_125:
  PUSH DE
  PUSH HL
  LD HL,$5EE4
  CALL GET_DEVICE_128
  POP HL
  POP DE
  RET Z
  CP $0D
  JP NZ,GET_DEVICE_50
  RET

GET_DEVICE_126:
  CALL GET_DEVICE_89
  CALL GET_DEVICE_91
  JP Z,GET_DEVICE_70
  CALL GET_DEVICE_125
  SUB A
  LD E,$02
  JP _OPEN
  
GET_DEVICE_127:
  LD HL,$5EEF
GET_DEVICE_128:
  CALL GET_DEVICE_139
  CALL SHOW_TIME
  CALL CHGET_UCASE
  CP $59
  RET NZ
  RST OUTC
  RET

GET_DEVICE_129:
  LD B,$1B
  LD DE,$F84F
GET_DEVICE_130:
  LD A,(DE)
  INC A
  RET Z
  DEC A
  AND $FB
  CP C
  JP NZ,GET_DEVICE_131
  PUSH BC
  PUSH DE
  PUSH HL
  LD HL,($F579)
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  LD ($F579),HL
  POP HL
  CALL GET_DEVICE_135
  PUSH HL
  LD HL,$F57B
  PUSH HL
  CALL GET_DEVICE_132
  POP HL
  CALL GET_DEVICE_139
  POP HL
  INC L
  POP DE
  POP BC
GET_DEVICE_131:
  CALL GET_DEVICE_190
  JP NZ,GET_DEVICE_130
  RET
GET_DEVICE_132:
  LD A,(DE)
  LD B,$2E
  CP $C4
  JP NZ,GET_DEVICE_133
  LD B,$2A
GET_DEVICE_133:
  INC DE
  INC DE
  INC DE
  CALL GET_DEVICE_140
  LD A,' '
GET_DEVICE_134:
  DEC HL
  CP (HL)
  JP Z,GET_DEVICE_134
  INC HL
  LD (HL),$00
  LD A,(DE)
  CP ' '
  RET Z
  LD (HL),B
  INC HL
  LD A,$02
  CALL GET_DEVICE_141
  LD (HL),$00
  RET
GET_DEVICE_135:
  PUSH DE
  PUSH HL
  LD A,L
  RRA
  RRA
  AND $3F
  LD E,A
  INC E
  INC E
  LD A,L
  AND $03
  ADD A,A
  LD D,A
  ADD A,A
  ADD A,A
  ADD A,D
  LD D,A
  INC D
  INC D
  EX DE,HL
  CALL POSIT
  POP HL
GET_DEVICE_136:
  POP DE
  RET
GET_DEVICE_137:
  CALL __CLS
PRINT_TDATE:
  LD HL,$0101
  CALL POSIT
  LD HL,$F52A
  PUSH HL
  LD (HL),$31
  INC HL
  LD (HL),$39
  INC HL
  CALL GET_DATE
  LD (HL),' '
  INC HL
  CALL READ_TIME
  LD (HL),$00
  POP HL
GET_DEVICE_139:
  LD A,(HL)
  OR A
  RET Z
  RST OUTC
  INC HL
  JP GET_DEVICE_139
GET_DEVICE_140:
  LD A,$06
GET_DEVICE_141:
  PUSH AF
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  POP AF
  DEC A
  JP NZ,GET_DEVICE_141
  RET
GET_DEVICE_142:
  CALL GET_DEVICE_144
  LD (HL),$00
  RET
GET_DEVICE_143:
  CALL GET_DEVICE_144
  INC DE
GET_DEVICE_144:
  LD A,(DE)
  OR A
  RET Z
  CP '.'
  RET Z
  LD (HL),A
  INC HL
  INC DE
  JP GET_DEVICE_144
GET_DEVICE_145:
  LD A,(DE)
  CP (HL)
  RET NZ
  OR A
  RET Z
  INC HL
  INC DE
  DEC C
  JP NZ,GET_DEVICE_145
  RET
GET_DEVICE_146:
  LD HL,$5E79
; This entry point is used by the routine at ISFLIO.
STFNK:
  LD DE,$F6A5
  LD B,$0A
GET_DEVICE_148:
  LD C,$0F
GET_DEVICE_149:
  LD A,(HL)
  INC HL
  OR A
  JP Z,GET_DEVICE_150
  LD (DE),A
  INC DE
  DEC C
  JP NZ,GET_DEVICE_149
  SUB A
GET_DEVICE_150:
  INC C
GET_DEVICE_151:
  LD (DE),A
  INC DE
  DEC C
  JP NZ,GET_DEVICE_151
  DEC B
  JP NZ,GET_DEVICE_148
; This entry point is used by the routine at GETWORD.
GET_DEVICE_152:
  LD A,($F3E9)
  OR A
  CALL NZ,ISFLIO_22
  RET
GET_DEVICE_153:
  PUSH AF
  LD (HL),$00
  LD A,($F58F)
  OR A
  JP Z,GET_DEVICE_70
  POP AF
  AND $10
  JP NZ,GET_DEVICE_154
  LD (HL),$2E
  INC HL
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  LD A,(DE)
  LD (HL),A
  INC HL
  LD (HL),$00
GET_DEVICE_154:
  LD B,$1B
  LD DE,$F84F
GET_DEVICE_155:
  LD HL,$F592
  LD A,(DE)
  INC A
  RET Z
  AND $80
  JP Z,GET_DEVICE_157
  PUSH DE
  PUSH HL
  CALL GET_DEVICE_132
  POP HL
  LD C,$09
  LD DE,$F57B
  CALL GET_DEVICE_145
  JP NZ,GET_DEVICE_156
  POP HL
  INC C
  RET
GET_DEVICE_156:
  POP DE
GET_DEVICE_157:
  CALL GET_DEVICE_190
  JP NZ,GET_DEVICE_155
  RET
GET_DEVICE_158:
  LD A,($F590)
  LD HL,$F541
  LD DE,$0002
  INC A
GET_DEVICE_159:
  ADD HL,DE
  DEC A
  JP NZ,GET_DEVICE_159
  DEC HL
GET_DEVICE_160:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  RET
  RET P
  RET NZ
  ADD A,B
  AND B
  NOP
  LD L,$42
  LD B,C
  NOP
  NOP
  ADD A,B
  LD L,$43
  LD C,A
  NOP
  NOP
  AND B
  LD L,$44
  LD C,A
  NOP
  NOP
  RET NZ
  RST $38
  LD C,H
  LD L,A
  LD H,C
  LD H,H
  JR NZ,GET_DEVICE_161
GET_DEVICE_161:
  LD D,E
  LD H,C
  HALT
  LD H,L
  JR NZ,GET_DEVICE_162
GET_DEVICE_162:
  LD C,(HL)
  LD H,C
  LD L,L
  LD H,L
  JR NZ,GET_DEVICE_163
GET_DEVICE_163:
  LD C,H
  LD L,C
  LD (HL),E
  LD (HL),H
  JR NZ,GET_DEVICE_164
GET_DEVICE_164:
  JR NZ,GET_DEVICE_166
  JR NZ,GET_DEVICE_167
  JR NZ,GET_DEVICE_168
  NOP
  LD D,E
  LD H,L
  LD (HL),H
  LD C,C
  LD D,B
  LD C,H
  NOP
  LD B,E
  LD L,H
  LD (HL),D
  LD C,C
  LD D,B
  LD C,H
  NOP
  NOP
  LD C,E
  LD L,C
  LD L,H
  LD L,H
  JR NZ,GET_DEVICE_165
GET_DEVICE_165:
  LD B,D
  LD H,C
  LD L,(HL)
  LD L,E
  NOP
  LD B,D
GET_DEVICE_166:
  JR Z,GET_DEVICE_171
GET_DEVICE_167:
  LD L,(HL)
  LD H,C
GET_DEVICE_168:
  LD (HL),D
  LD A,C
  ADD HL,HL
  JR NZ,$5F2B
  LD (HL),D
  JR NZ,GET_DEVICE_170
  JR Z,GET_DEVICE_176
  LD H,E
  LD L,C
  LD L,C
  ADD HL,HL
  CCF
  JR NZ,GET_DEVICE_173
  DEC DE
  LD C,E
  EX AF,AF'
  NOP
  JR NZ,GET_DEVICE_169
  EX AF,AF'
  LD E,A
  EX AF,AF'
  NOP
  JR NZ,GET_DEVICE_179
  LD (HL),D
  LD L,A
GET_DEVICE_169:
  LD L,L
  JR NZ,$5F38
  EX AF,AF'
  NOP
  JR NZ,$5F3E
  LD (HL),E
  JR NZ,GET_DEVICE_180
  DEC DE
  LD C,E
  EX AF,AF'
  NOP
  JR NZ,$5F38
  LD H,L
  LD H,C
  LD H,H
  LD A,C
  CCF
  JR NZ,GET_DEVICE_185
  EX AF,AF'
  NOP
  JR NZ,GET_DEVICE_181
  LD (HL),L
  LD (HL),D
  LD H,L
  CCF
  JR NZ,$5F56
  EX AF,AF'
  NOP
  LD D,A
  LD L,C
  LD H,H
  LD (HL),H
  LD L,B
  JR Z,GET_DEVICE_170
GET_DEVICE_170:
  ADD HL,HL
  LD A,($5F20)
  EX AF,AF'
  NOP
  
; Message at 24326 ($5F06)
FNKTAB:
  DEFM "Load \""
  DEFB $00
  DEFM "Save \""
  DEFB $00
  DEFM "Files"
  DEFB $0D
  DEFB $00
  DEFM "List "
  DEFB $00
  DEFM "Run"
  DEFB $0D
  DEFB $00
  DEFM "Edit "
FNKTAB_0:
  DEFB $00
  DEFM "Cont"
  DEFB $0D
  DEFB $00
  DEFM "Print "
FNKTAB_1:
  DEFB $00
  DEFM "List."
FNKTAB_2:
  DEFB $0D
FNKTAB_3:
  DEFB $1E
  DEFB $1E
  DEFB $00
  DEFM "Menu"
  DEFB $0D
  DEFB $00


  
GET_DEVICE_182:
  PUSH DE
GET_DEVICE_183:
  PUSH HL
  PUSH DE
GET_DEVICE_184:
  LD A,(DE)
GET_DEVICE_185:
  CALL UCASE
  LD C,A
  CALL UCASE_HL
  CP C
  JP NZ,GET_DEVICE_186
  INC DE
  INC HL
  JP GET_DEVICE_184
GET_DEVICE_186:
  CP $00
  LD A,C
  POP BC
  POP HL
  JP Z,GET_DEVICE_187
  CP $1A		; EOF
  JP Z,GET_DEVICE_136
  CALL GET_DEVICE_188
  JP NZ,GET_DEVICE_183
  POP AF
  JP GET_DEVICE_182

GET_DEVICE_187:
  POP DE
  SCF
  RET

GET_DEVICE_188:
  LD A,(DE)
  CP $0D
  INC DE
  RET NZ
  LD A,(DE)
  CP $0A
  RET NZ
  INC DE
  RET

GET_DEVICE_189:
  LD DE,$000B
  ADD HL,DE
  DEC B
  RET

GET_DEVICE_190:
  PUSH HL
  EX DE,HL
  CALL GET_DEVICE_189
  EX DE,HL
  POP HL
  RET

STKINI:
  LD HL,$FFFF
  LD (CURLIN),HL
  INC HL
  LD (CAPTUR),HL

RESTAK:
  POP BC
  LD HL,(SAVSTK)
  LD SP,HL
  PUSH BC
  RET

CHGET_UCASE:
  CALL CHGET
  JP UCASE

SHOW_TIME:
  PUSH HL
  LD HL,(CSRX)
  PUSH HL
  CALL CHSNS
  PUSH AF
  CALL Z,PRINT_TDATE
  POP AF
  POP HL
  PUSH AF
  CALL POSIT
  POP AF
  POP HL
  JP Z,SHOW_TIME
  RET
  
  CALL SHOW_TIME
  JP CHGET
  
TEXT:
  LD HL,$5FD1
  LD (ERRTRP),HL
  LD HL,$5FF7
  CALL STFNK
  XOR A
  CALL NZ,__BEEP
  CALL STKINI
  LD HL,$5FEB
  CALL PRS
  CALL ERAEOL2
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  JP Z,__MENU
  CALL OPENDO
  JP GET_DEVICE_209
  LD B,(HL)
  LD L,C
  LD L,H
  LD H,L
  JR NZ,$6065
  LD L,A
  JR NZ,$6059
  LD H,H
  LD L,C
  LD (HL),H
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  INC BC
  NOP
  LD B,(HL)
  LD L,C
  LD L,(HL)
  LD H,H
  LD C,$00
  LD C,(HL)
  LD H,L
  LD A,B
  LD (HL),H
  DEC BC
  NOP
  LD D,E
  LD H,L
  LD L,H
  JR NZ,GET_DEVICE_196
  NOP
  LD B,E
  LD (HL),L
  LD (HL),H
  JR NZ,GET_DEVICE_198
  NOP
  LD B,E
  LD L,A
  LD (HL),B
  LD A,C
  RRCA
GET_DEVICE_196:
  NOP
  LD C,E
  LD H,L
  LD A,C
  LD (HL),E
  DJNZ GET_DEVICE_197
GET_DEVICE_197:
  NOP
  NOP
  NOP
  LD C,L
  LD H,L
  LD L,(HL)
  LD (HL),L
  DEC DE
GET_DEVICE_198:
  DEC DE
  NOP
__EDIT:
  PUSH HL
  PUSH AF
  CALL GET_DEVICE_206
  CALL GETPARM_VRFY
  POP AF
  PUSH AF
  LD A,$01
  JP Z,GET_DEVICE_199
  LD A,$FF
GET_DEVICE_199:
  LD ($F3FD),A
  XOR A
  LD ($FB7A),A
  LD HL,$2020
  LD (FILNAM+6),HL
  LD HL,$60C4
  LD (ERRTRP),HL
  LD DE,$F902		; D = 'RAM' device, E = $02
  LD HL,$6115
  CALL _OPEN
  LD HL,$60BF
  LD (ERRTRP),HL
  CALL GET_DEVICE_207
  POP AF
  POP HL
  PUSH HL
  JP __LIST
; This entry point is used by the routine at MAKINT.
GET_DEVICE_200:
  CALL SCPTLP_104
  CALL GETWORD_187
  LD A,($F3E9)
  LD ($F9BF),A
  LD HL,$0000
  LD ($F501),HL
  LD ($F503),HL
GET_DEVICE_201:
  CALL RESFPT
  LD HL,($F887)
  LD A,(HL)
  CP $1A		; EOF
  JP Z,GET_DEVICE_203
  PUSH HL
  XOR A
  LD HL,$6095
  JP GET_DEVICE_210
  XOR A
  LD HL,$60D5
  LD (ERRTRP),HL
  LD HL,$6115
  LD D,$F9
  JP __MERGE_1
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_202:
  CALL __CLS
GET_DEVICE_203:
  XOR A
  LD ($F3FD),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL KILLASC_4
  CALL CHKSTK_5
  LD A,($F9BF)
  LD ($F3E9),A
  JP GET_DEVICE_386
  PUSH DE
  CALL KILLASC_4
  POP DE
  PUSH DE
  XOR A
  LD ($F3FD),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL SCPTLP_104
  POP DE
  JP ERROR
  LD A,E
  PUSH AF
  LD HL,($FB67)
  DEC HL
  LD B,(HL)
  DEC B
  DEC HL
  LD C,(HL)
  DEC HL
  LD L,(HL)
  XOR A
  LD H,A
  ADD HL,BC
  LD BC,$FFFF
  ADD HL,BC
  JP C,GET_DEVICE_204
  LD L,A
  LD H,A
GET_DEVICE_204:
  LD ($F501),HL
  CALL SCPTLP_104
  POP AF
  CP $07
  LD HL,$627F
  JP Z,GET_DEVICE_205
  LD HL,$6105
GET_DEVICE_205:
  LD ($F503),HL
  JP GET_DEVICE_201
  LD D,H
  LD H,L
  LD A,B
  LD (HL),H
  JR NZ,GET_DEVICE_212
  LD L,H
  LD L,H
  DEC L
  LD H,(HL)
  LD L,A
  LD (HL),D
  LD L,L
  LD H,L
  LD H,H
  RLCA
  NOP
; This entry point is used by the routine at CHKSTK.
GET_DEVICE_206:
  LD HL,CONTXT
  LD DE,$F99B
  JP GET_DEVICE_208
; This entry point is used by the routine at CHKSTK.
GET_DEVICE_207:
  LD HL,$F99B
  LD DE,CONTXT
GET_DEVICE_208:
  LD B,$0C
  JP LDIR_B
GET_DEVICE_209:
  PUSH HL
  LD HL,$0000
  LD ($F501),HL
  LD ($F503),HL
  LD A,$01
  LD HL,__MENU
GET_DEVICE_210:
  LD ($F4F7),A
  LD ($F581),HL
  CALL ISFLIO_16
  CALL ISFLIO_20
  CALL ISFLIO_4
  CALL ISFLIO_7
  CALL GET_DEVICE_298
  LD HL,$6002
  CALL STFNK
  LD A,($F3FD)
  AND A
  JP Z,GET_DEVICE_211
  LD HL,$7845		; H=120, L=69
  LD ($F735),HL
  LD HL,$7469		; H=116, L=105
  LD ($F737),HL
GET_DEVICE_211:
  LD A,(ACTV_Y)
  LD ($F4F8),A
  LD A,$80
  LD (FNK_FLAG),A
  XOR A
  LD L,A
GET_DEVICE_212:
  LD H,A
  LD ($F4F9),A
  LD ($F4F6),A
  LD ($F4FB),A
  LD ($F53B),A
  LD ($F4FC),HL
  POP HL
  LD ($F583),HL
  PUSH HL
  CALL GET_DEVICE_369
  CALL GET_DEVICE_266
  POP DE
  LD HL,($F501)
  ADD HL,DE
  CALL GET_DEVICE_274
  PUSH HL
  CALL GET_DEVICE_335
  POP HL
  CALL GET_DEVICE_258
  LD HL,($F503)
  LD A,H
  OR L
  JP Z,GET_DEVICE_213
  PUSH HL
  CALL GET_DEVICE_295
  EX (SP),HL
  CALL GET_DEVICE_296
  POP HL
  CALL POSIT
GET_DEVICE_213:
  CALL ISFLIO_13
GET_DEVICE_214:
  CALL STKINI
  LD HL,GET_DEVICE_214
  LD (ERRTRP),HL
  PUSH HL
  LD A,($F4F9)
  LD ($F4FA),A
  CALL GET_DEVICE_276
  LD ($F4F9),A
  PUSH AF
  CALL GET_DEVICE_301
  POP AF
  JP C,GET_DEVICE_290
  CP $7F
  JP Z,GET_DEVICE_222
  CP ' '
  JP NC,GET_DEVICE_215
  LD C,A
  LD B,$00
  LD HL,$61EF
  ADD HL,BC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  PUSH HL
  LD HL,(CSRX)
  RET
  XOR $61
  LD E,D
  LD H,E
  AND L
  LD H,E
  LD E,L
  LD H,H
  XOR H
  LD H,D
  INC HL
  LD H,E
  LD C,B
  LD H,E
  XOR $61
  EXX
  LD H,D
  LD E,B
  LD H,D
  XOR $61
  LD H,$67
  DJNZ GET_DEVICE_217
  ADC A,H
  LD H,D
  LD (HL),$67
  LD B,$66
  XOR $61
  EXX
  LD H,E
  BIT 4,E
  RRA
  LD H,E
  SUB B
  LD H,E
  LD A,(DE)
  LD H,(HL)
  XOR $61
  SBC A,$63
  OR B
  LD H,D
  XOR $61
  JP PE,BNORM_9
  LD H,D
  XOR H
  LD H,D
  RRA
  LD H,E
  INC HL
  LD H,E
  OR B
  LD H,D
  LD A,($F4FA)
  SUB $1B
  RET NZ
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  RST $38
  LD E,H
  CALL GET_DEVICE_298
  CALL ISFLIO_5
  CALL ISFLIO_12
  CALL ISFLIO_20
  CALL GET_DEVICE_275
  CALL POSIT
  CALL ISFLIO_0
  CALL GET_DEVICE_270
  LD HL,($F581)
  JP (HL)
GET_DEVICE_215:
  PUSH AF
  CALL GET_DEVICE_248
  CALL GET_DEVICE_359
  CALL GET_DEVICE_366
  POP AF
GET_DEVICE_216:
  CALL GET_DEVICE_272
  JP C,GET_DEVICE_218
  PUSH HL
  CALL GET_DEVICE_243
GET_DEVICE_217:
  POP HL
  JP GET_DEVICE_225
GET_DEVICE_218:
  CALL GET_DEVICE_295
  PUSH HL
  LD HL,$627F
  CALL GET_DEVICE_296
GET_DEVICE_219:
  POP HL
  JP POSIT
  LD C,L
  LD H,L
  LD L,L
  LD L,A
  LD (HL),D
  LD A,C
  JR NZ,GET_DEVICE_223
  LD (HL),L
  LD L,H
  LD L,H
  RLCA
  NOP
  CALL GET_DEVICE_248
  CALL GET_DEVICE_359
  LD HL,($FA88)
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  JP NZ,GET_DEVICE_218
  CALL GET_DEVICE_243
  CALL GET_DEVICE_366
  LD A,$0D
  CALL GET_DEVICE_272
  LD A,$0A
  JP GET_DEVICE_216
  CALL GET_DEVICE_220
  SCF
  CALL NC,GET_DEVICE_221
  JP GET_DEVICE_249
GET_DEVICE_220:
  LD HL,(CSRX)
  LD A,(ACTV_Y)
  INC H
  CP H
  JP NC,GET_DEVICE_228
  LD H,$01
GET_DEVICE_221:
  INC L
  LD A,L
  PUSH HL
  CALL GET_DEVICE_353
  LD A,E
  AND D
  INC A
  POP HL
  SCF
  RET Z
  CALL GET_DEVICE_274
  CP L
  CALL C,GET_DEVICE_259
  JP GET_DEVICE_228
  CALL GET_DEVICE_248
  CALL GET_DEVICE_366
  CALL GET_DEVICE_258
  CALL GET_DEVICE_226
  RET C
GET_DEVICE_222:
  CALL GET_DEVICE_248
  CALL GET_DEVICE_366
  PUSH HL
GET_DEVICE_223:
  CALL GET_DEVICE_258
  POP HL
  LD A,(HL)
  CP $1A		; EOF
  RET Z
  PUSH AF
  PUSH HL
  PUSH HL
  CALL GET_DEVICE_359
  POP HL
GET_DEVICE_224:
  CALL GET_DEVICE_273
  CALL $6424
  POP HL
  POP AF
  CP $0D
  JP NZ,GET_DEVICE_225
  LD A,(HL)
  CP $0A
  JP NZ,GET_DEVICE_225
  PUSH AF
  PUSH HL
  JP GET_DEVICE_224
GET_DEVICE_225:
  PUSH HL
  LD A,(CSRX)
  CALL GET_DEVICE_337
  POP HL
  JP GET_DEVICE_256
  CALL GET_DEVICE_226
  SCF
  CALL NC,GET_DEVICE_227
  JP GET_DEVICE_249
GET_DEVICE_226:
  LD HL,(CSRX)
  DEC H
  JP NZ,GET_DEVICE_228
  LD A,(ACTV_Y)
  LD H,A
GET_DEVICE_227:
  PUSH HL
  CALL GET_DEVICE_352
  LD HL,($F583)
  RST CPDEHL
  POP HL
  CCF
  RET C
  DEC L
  CALL Z,GET_DEVICE_261
GET_DEVICE_228:
  CALL POSIT
  AND A
  RET
  CALL GET_DEVICE_366
GET_DEVICE_229:
  CALL GET_DEVICE_234
  JP NZ,GET_DEVICE_229
GET_DEVICE_230:
  CALL GET_DEVICE_234
  JP Z,GET_DEVICE_230
  JP GET_DEVICE_233
  CALL GET_DEVICE_366
GET_DEVICE_231:
  CALL GET_DEVICE_235
  JP Z,GET_DEVICE_231
GET_DEVICE_232:
  CALL GET_DEVICE_235
  JP NZ,GET_DEVICE_232
  CALL GET_DEVICE_234
GET_DEVICE_233:
  CALL GET_DEVICE_256
  JP GET_DEVICE_249
GET_DEVICE_234:
  LD A,(HL)
  CP $1A		; EOF
  POP BC
  JP Z,GET_DEVICE_233
  INC HL
  JP GET_DEVICE_236
GET_DEVICE_235:
  EX DE,HL
  LD HL,($F583)
  EX DE,HL
  RST CPDEHL
  POP BC
  JP Z,GET_DEVICE_233
  DEC HL
GET_DEVICE_236:
  PUSH BC
  PUSH HL
  LD A,(HL)
  CALL GET_DEVICE_333
  POP HL
  RET
  DEC L
  LD L,$01
  JP NZ,GET_DEVICE_237
  PUSH HL
  CALL GET_DEVICE_352
  EX DE,HL
  CALL GET_DEVICE_240
  POP HL
GET_DEVICE_237:
  CALL POSIT
  JP GET_DEVICE_249
  PUSH HL
  INC L
  CALL GET_DEVICE_274
  INC A
  CP L
  JP NZ,GET_DEVICE_238
  PUSH AF
  CALL GET_DEVICE_352
  EX DE,HL
  LD A,$01
  CALL GET_DEVICE_241
  POP AF
GET_DEVICE_238:
  DEC A
  CALL GET_DEVICE_353
  LD B,A
  INC DE
  LD A,D
  OR E
  LD A,B
  JP Z,GET_DEVICE_238
  POP HL
  LD L,A
  JP GET_DEVICE_237
  LD A,(ACTV_Y)
  LD H,A
  CALL POSIT
  CALL GET_DEVICE_366
  CALL GET_DEVICE_360
  LD BC,$0126
  JP GET_DEVICE_237
  LD HL,($F583)
  CALL GET_DEVICE_242
  CALL ISFLIO_1
  JP GET_DEVICE_249
  LD HL,($FA88)
  PUSH HL
  CALL GET_DEVICE_351
  POP HL
  RST CPDEHL
  PUSH HL
  CALL NC,GET_DEVICE_240
GET_DEVICE_239:
  POP HL
  CALL GET_DEVICE_258
  JP GET_DEVICE_249
GET_DEVICE_240:
  CALL GET_DEVICE_274
GET_DEVICE_241:
  CALL GET_DEVICE_372
GET_DEVICE_242:
  CALL SYNCHR_1
  RET Z
  LD ($F507),HL
  LD A,$01
  JP GET_DEVICE_339
  CALL GET_DEVICE_248
  CALL GET_DEVICE_366
  LD ($F4FC),HL
  LD ($F4FE),HL
  LD E,L
  LD D,H
  JP GET_DEVICE_251
GET_DEVICE_243:
  LD C,$00
  LD HL,$800E
  CALL GET_DEVICE_274
  LD HL,CSRX
  SUB (HL)
  LD B,A
  CALL GET_DEVICE_352
  INC HL
GET_DEVICE_244:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC DE
  LD A,D
  OR E
  RET Z
  DEC C
  JP M,GET_DEVICE_245
  DEC DE
  DEC DE
GET_DEVICE_245:
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  DEC B
  JP P,GET_DEVICE_244
  RET
GET_DEVICE_246:
  CALL ISFLIO_1
  CALL ISFLIO_8
  CALL GET_DEVICE_274
GET_DEVICE_247:
  ADD A,A
  LD B,A
  LD DE,$F507
  LD HL,$F509
  JP LDIR_B
GET_DEVICE_248:
  CALL GET_DEVICE_255
  PUSH HL
  LD HL,$0000
  LD ($F4FC),HL
  CALL GET_DEVICE_366
  POP DE
  JP GET_DEVICE_250
GET_DEVICE_249:
  CALL GET_DEVICE_255
  CALL GET_DEVICE_366
  EX DE,HL
  LD HL,($F4FE)
  RST CPDEHL
  RET Z
  EX DE,HL
  LD ($F4FE),HL
GET_DEVICE_250:
  CALL GET_DEVICE_284
GET_DEVICE_251:
  PUSH HL
  PUSH DE
  CALL GET_DEVICE_351
  POP HL
  RST CPDEHL
  JP C,GET_DEVICE_252
  CALL GET_DEVICE_275
GET_DEVICE_252:
  CALL C,GET_DEVICE_360
  LD H,L
  EX (SP),HL
  CALL SYNCHR_1
  JP NC,GET_DEVICE_253
  LD L,$01
GET_DEVICE_253:
  CALL NC,GET_DEVICE_360
  POP AF
  SUB L
  LD C,A
  EX DE,HL
  LD HL,(CSRX)
  EX DE,HL
  PUSH DE
  LD H,$01
  CALL POSIT
  CALL GET_DEVICE_352
  LD A,C
GET_DEVICE_254:
  PUSH AF
  CALL GET_DEVICE_345
  POP AF
  DEC A
  JP P,GET_DEVICE_254
  JP GET_DEVICE_219
GET_DEVICE_255:
  LD HL,($F4FC)
  LD A,H
  OR L
  RET NZ
  POP HL
  RET
GET_DEVICE_256:
  CALL SYNCHR_1
  CALL C,GET_DEVICE_262
  JP C,GET_DEVICE_256
GET_DEVICE_257:
  PUSH HL
  CALL GET_DEVICE_351
  POP HL
  RST CPDEHL
  CALL NC,GET_DEVICE_260
  JP NC,GET_DEVICE_257
GET_DEVICE_258:
  CALL GET_DEVICE_360
  JP POSIT
GET_DEVICE_259:
  DEC L
GET_DEVICE_260:
  PUSH AF
  PUSH HL
  CALL GET_DEVICE_246
  CALL GET_DEVICE_274
  JP GET_DEVICE_263
GET_DEVICE_261:
  INC L
GET_DEVICE_262:
  PUSH AF
  PUSH HL
  CALL $67C4
  CALL ISFLIO_1
  CALL ISFLIO_9
  CALL GET_DEVICE_354
  PUSH DE
  CALL GET_DEVICE_351
  INC HL
  LD E,L
  LD D,H
  DEC HL
  DEC HL
  DEC A
  ADD A,A
  LD C,A
  LD B,$00
  CALL GET_DEVICE_381
  EX DE,HL
  POP DE
  LD (HL),D
  DEC HL
  LD (HL),E
  LD A,$01
GET_DEVICE_263:
  CALL GET_DEVICE_339
  POP HL
  POP AF
  RET
; This entry point is used by the routine at GETWORD.
GET_DEVICE_264:
  LD HL,(DO_FILES)
; This entry point is used by the routine at GETWORD.
GET_DEVICE_265:
  DEC HL
  LD ($FA88),HL
GET_DEVICE_266:
  LD HL,(ARREND)
  LD BC,$00C8
  ADD HL,BC
  LD BC,$0000
  XOR A
  SUB L
  LD L,A
  SBC A,A
  SUB H
  LD H,A
  ADD HL,SP
  RET NC
  LD A,H
  OR L
  RET Z
  LD B,H
  LD C,L
  LD HL,($FA88)
  EX DE,HL
  INC DE
  CALL MAKHOL_0
  PUSH BC
GET_DEVICE_267:
  LD (HL),$00
  INC HL
  DEC BC
  LD A,B
  OR C
  JP NZ,GET_DEVICE_267
  POP BC
  RET
GET_DEVICE_268:
  LD HL,(DO_FILES)
GET_DEVICE_269:
  CALL GET_DEVICE_370
  INC HL
  EX DE,HL
  LD HL,(CO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NC
  LD A,(HL)
  AND A
  JP NZ,GET_DEVICE_269
GET_DEVICE_270:
  LD HL,($FA88)
  PUSH HL
  LD BC,$FFFF
  XOR A
GET_DEVICE_271:
  INC HL
  INC BC
  CP (HL)
  JP Z,GET_DEVICE_271
  POP HL
  INC HL
  JP MASDEL
GET_DEVICE_272:
  EX DE,HL
  LD HL,($FA88)
  INC HL
  INC (HL)
  DEC (HL)
  SCF
  RET NZ
  PUSH AF
  LD ($FA88),HL
  EX DE,HL
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  LD L,E
  LD H,D
  DEC HL
  CALL GET_DEVICE_381
  INC HL
  POP AF
  LD (HL),A
  INC HL
  AND A
  RET
GET_DEVICE_273:
  EX DE,HL
  LD HL,($FA88)
  LD A,L
  SUB E
  LD C,A
  LD A,H
  SBC A,D
  LD B,A
  DEC HL
  LD ($FA88),HL
  LD L,E
  LD H,D
  INC HL
  CALL _LDIR
  XOR A
  LD (DE),A
  RET
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_274:
  PUSH HL
  PUSH AF
  LD HL,$F3E9
  LD A,($F3E7)
  ADD A,(HL)
  LD L,A
  POP AF
  LD A,L
  POP HL
  RET
GET_DEVICE_275:
  PUSH AF
  LD HL,($F3E7)
  CALL GET_DEVICE_274
  LD L,A
  POP AF
  RET
GET_DEVICE_276:
  CALL CHGET
  RET C
  PUSH AF
  CP $10
  JP Z,GET_DEVICE_277
  POP AF
  RET
GET_DEVICE_277:
  LD HL,(CSRX)
  PUSH HL
  LD A,($F3E9)
  AND A
  JP NZ,GET_DEVICE_278
  INC A
  CALL ISFLIO_23
  LD A,(CSRX)
  POP HL
  CP L
  LD A,($F3E7)
  CALL NZ,GET_DEVICE_247
  POP AF
  RET
GET_DEVICE_278:
  CALL ISFLIO_20
  LD A,($F3E7)
  DEC A
  CALL GET_DEVICE_353
  INC HL
  LD (HL),$FE
  INC HL
  INC HL
  LD (HL),$FE
  DEC A
  CALL GET_DEVICE_339
  XOR A
  LD ($F4FB),A
  POP HL
  CALL POSIT
  POP AF
  RET
  CALL GET_DEVICE_255
  CALL GET_DEVICE_270
  CALL GET_DEVICE_285
  PUSH AF
  CALL GET_DEVICE_266
  POP AF
  JP NC,GET_DEVICE_248
  JP GET_DEVICE_218
  CALL GET_DEVICE_255
  CALL GET_DEVICE_270
  CALL GET_DEVICE_285
  PUSH AF
  CALL NC,MASDEL
  POP AF
  JP NC,GET_DEVICE_281
  LD A,B
  AND A
  JP Z,GET_DEVICE_280
GET_DEVICE_279:
  CALL GETWORD_131
  PUSH BC
  LD BC,$0100
  CALL GET_DEVICE_282
  POP BC
  DEC B
  JP NZ,GET_DEVICE_279
GET_DEVICE_280:
  LD A,C
  AND A
  CALL NZ,GET_DEVICE_282
GET_DEVICE_281:
  LD DE,$0000
  EX DE,HL
  LD ($F4FC),HL
  EX DE,HL
  PUSH HL
  LD A,(CSRX)
  CALL GET_DEVICE_335
  POP HL
  CALL GET_DEVICE_258
  CALL GET_DEVICE_369
  JP GET_DEVICE_266
GET_DEVICE_282:
  PUSH HL
  PUSH BC
  EX DE,HL
  LD HL,($FB67)
  EX DE,HL
  CALL _LDIR
  POP BC
  POP HL
  PUSH HL
  PUSH BC
  CALL MASDEL
  LD HL,(HAYASHI)
  ADD HL,BC
  EX DE,HL
  POP BC
  CALL MAKHOL_0
  EX DE,HL
  LD HL,($FB67)
  CALL _LDIR
  POP HL
  RET

GET_DEVICE_283:
  LD HL,($F4FC)
  EX DE,HL
  LD HL,($F4FE)
GET_DEVICE_284:
  RST CPDEHL
  RET C
  EX DE,HL
  RET

GET_DEVICE_285:
  CALL SWAPNM_1
  LD HL,(HAYASHI)
  LD (KBUF),HL
  XOR A
  LD ($F500),A
  CALL GET_DEVICE_283
  DEC DE
GET_DEVICE_286:
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  JP C,GET_DEVICE_287
  LD A,(DE)
  CP $1A		; EOF
  JP Z,GET_DEVICE_288
  CP $0D
  JP NZ,GET_DEVICE_287
  INC DE
  LD A,(DE)
  CP $0A
  JP NZ,GET_DEVICE_287
  INC BC
GET_DEVICE_287:
  INC BC
GET_DEVICE_288:
  LD A,B
  OR C
  RET Z
  PUSH HL
  LD HL,(KBUF)
  CALL GET_DEVICE_376
  EX DE,HL
  POP HL
  RET C
  LD A,($F500)
  AND A
  JP Z,GET_DEVICE_289
  ADD HL,BC
GET_DEVICE_289:
  PUSH HL
  PUSH BC
  CALL _LDIR
  POP BC
  POP HL
  RET
GET_DEVICE_290:
  CALL GET_DEVICE_248
  CALL GET_DEVICE_270
  CALL RESFPT
  CALL GET_DEVICE_366
  LD (KBUF),HL
  LD A,H
  LD ($F500),A
  LD HL,(HAYASHI)
  LD A,(HL)
  CP $1A		; EOF
  JP Z,GET_DEVICE_266
  LD E,L
  LD D,H
  DEC DE
GET_DEVICE_291:
  INC DE
  LD A,(DE)
  CP $1A		; EOF
  JP NZ,GET_DEVICE_291
  CALL GET_DEVICE_286
  PUSH AF
  PUSH DE
  CALL GET_DEVICE_369
  CALL GET_DEVICE_266
  POP DE
  POP AF
  JP C,GET_DEVICE_218
  PUSH DE
  LD HL,(KBUF)
  LD A,(CSRX)
  CALL GET_DEVICE_335
  CALL GET_DEVICE_351
  POP HL
  RST CPDEHL
  CALL GET_DEVICE_274
  PUSH HL
  CALL NC,GET_DEVICE_335
  POP HL
  JP GET_DEVICE_258
  CALL GET_DEVICE_295
  CALL GET_DEVICE_366
  EX DE,HL
  LD HL,$F53B
  LD A,(HL)
  AND A
  RET Z
  JP GET_DEVICE_292
  CALL GET_DEVICE_295
  CALL GET_DEVICE_366
  PUSH HL
  LD HL,$67BC
  LD DE,$F53B
  PUSH DE
  CALL GET_DEVICE_303
  POP DE
  INC HL
  LD A,(HL)
  AND A
  SCF
  JP Z,GET_DEVICE_293
  CALL GET_DEVICE_299
  POP DE
GET_DEVICE_292:
  PUSH DE
  LD A,(DE)
  CP $1A		; EOF
  JP Z,GET_DEVICE_294
  INC DE
  CALL GET_DEVICE_182
  JP NC,GET_DEVICE_294
  POP DE
  PUSH BC
  PUSH BC
  CALL GET_DEVICE_351
  POP HL
  RST CPDEHL
  JP C,GET_DEVICE_293
  CALL $6A1E
  AND A
GET_DEVICE_293:
  CALL C,GET_DEVICE_302
  SCF
GET_DEVICE_294:
  LD HL,$67B3
  CALL NC,GET_DEVICE_296
  JP GET_DEVICE_239
  CALL GET_DEVICE_248
GET_DEVICE_295:
  LD HL,(CSRX)
  CALL GET_DEVICE_274
  CP L
  RET NZ
  DEC L
  PUSH HL
  CALL GET_DEVICE_246
  JP GET_DEVICE_219
  LD HL,$562A
GET_DEVICE_296:
  LD A,$01
  LD ($F4FB),A
GET_DEVICE_297:
  CALL $67C4
  CALL PRS
GET_DEVICE_298:
  CALL CHSNS
  RET Z
  CALL CHGET
  JP GET_DEVICE_298
GET_DEVICE_299:
  PUSH HL
GET_DEVICE_300:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  AND A
  JP NZ,GET_DEVICE_300
  POP HL
  RET
  LD C,(HL)
  LD L,A
  JR NZ,$6824
  LD H,C
  LD (HL),H
  LD H,E
  LD L,B
  NOP
  LD D,E
  LD (HL),H
  LD (HL),D
  LD L,C
  LD L,(HL)
  LD H,A
  LD A,($E500)
  CALL GET_DEVICE_275
  LD H,$01
  CALL POSIT
  POP HL
  JP ERAEOL
GET_DEVICE_301:
  LD HL,$F4FB
  XOR A
  CP (HL)
  RET Z
  LD (HL),A
GET_DEVICE_302:
  LD HL,(CSRX)
  PUSH HL
  CALL GET_DEVICE_274
  CALL GET_DEVICE_339
  JP GET_DEVICE_219
  LD DE,$6115
GET_DEVICE_303:
  PUSH DE
  CALL GET_DEVICE_297
  LD A,(CSRY)
  LD ($F9BD),A
  POP HL
  PUSH HL
  CALL PRS
  CALL ISFLIO_12
GET_DEVICE_304:
  CALL CHGET
  JP C,GET_DEVICE_304
  AND A
  JP Z,GET_DEVICE_304
  POP HL
  CP $0D
  JP Z,GET_DEVICE_306
  PUSH AF
  CALL GET_DEVICE_275
  LD A,($F9BD)
  LD H,A
  CALL POSIT
  CALL ERAEOL
  POP AF
  LD DE,$F5A1
  LD B,$01
  AND A
  JP GET_DEVICE_305
  CALL CHGET
GET_DEVICE_305:
  LD HL,$6822
  PUSH HL
  RET C
  CP $7F
  JP Z,ISFLIO_85
  CP ' '
  JP NC,GET_DEVICE_308
  LD HL,$6843
  LD C,$07
  JP ISFLIO_37
GET_DEVICE_306:
  LD DE,$F5A1
  CALL GET_DEVICE_299
  JP GET_DEVICE_307
  INC BC
  LD E,D
  LD L,B
  EX AF,AF'
  POP BC
  LD B,(HL)
  ADD HL,BC
  LD H,A
  LD L,B
  DEC C
  LD E,L
  LD L,B
  DEC D
  CALL PO,GETWORD_36
  CALL PO,GETWORD_102
  POP BC
  LD B,(HL)
  LD DE,$F5A1
  POP HL
  POP HL
  XOR A
  LD (DE),A
GET_DEVICE_307:
  LD HL,BUFMIN
  JP ISFLIO_13
  LD A,$09
GET_DEVICE_308:
  LD C,A
  LD A,(ACTV_Y)
  SUB $09
  LD HL,CSRY
  CP (HL)
  JP C,__BEEP
  LD A,C
  INC B
  RST OUTC
  LD (DE),A
  INC DE
  RET
GET_DEVICE_309:
  XOR A
  LD ($F466),A
  LD ($F500),A
  LD HL,$F46A
  LD ($F468),HL
GET_DEVICE_310:
  PUSH DE
  CALL GET_DEVICE_327
  POP DE
  LD A,(DE)
  INC DE
  CP $1A		; EOF
  JP Z,GET_DEVICE_317
  CP $0D
  JP Z,GET_DEVICE_318
  CP $09
  JP Z,GET_DEVICE_311
  CP ' '
  JP C,GET_DEVICE_315
GET_DEVICE_311:
  CALL GET_DEVICE_319
  JP NC,GET_DEVICE_310
  LD A,(DE)
  CALL GET_DEVICE_332
  JP NZ,GET_DEVICE_312
  CALL GET_DEVICE_314
  LD A,(DE)
  CP ' '
  RET NZ
  LD A,($F4F6)
  AND A
  RET Z
  INC DE
  LD A,(DE)
  CP ' '
  RET NZ
  DEC DE
  RET
GET_DEVICE_312:
  EX DE,HL
  LD (KBUF),HL
  EX DE,HL
  LD HL,($F468)
  LD ($F464),HL
  DEC DE
  LD A,(DE)
  INC DE
  CALL GET_DEVICE_332
  JP Z,GET_DEVICE_314
GET_DEVICE_313:
  DEC DE
  LD A,(DE)
  INC DE
  CALL GET_DEVICE_332
  JP Z,GET_DEVICE_325
  DEC DE
  CALL GET_DEVICE_323
  JP NZ,GET_DEVICE_313
  LD HL,($F464)
  LD ($F468),HL
  LD HL,(KBUF)
  EX DE,HL
GET_DEVICE_314:
  LD A,($F4F6)
  DEC A
  JP Z,GET_DEVICE_326
  RET
GET_DEVICE_315:
  PUSH AF
  LD A,$5E
  CALL GET_DEVICE_319
  JP C,GET_DEVICE_316
  POP AF
  OR $40
  CALL GET_DEVICE_319
  JP NC,GET_DEVICE_310
  LD A,($F4F6)
  AND A
  JP NZ,GET_DEVICE_326
  RET
GET_DEVICE_316:
  POP AF
  DEC DE
  LD HL,($F468)
  DEC HL
  LD ($F468),HL
  LD HL,$F466
  DEC (HL)
  JP GET_DEVICE_325
GET_DEVICE_317:
  LD A,($F4F6)
  AND A
  LD A,$80
  CALL Z,GET_DEVICE_319
  CALL GET_DEVICE_325
  LD DE,$FFFF
  RET
GET_DEVICE_318:
  LD A,(DE)
  CP $0A
  LD A,$0D
  JP NZ,GET_DEVICE_315
  PUSH DE
  CALL GET_DEVICE_327
  POP DE
  LD A,($F4F6)
  AND A
  LD A,$81
  CALL Z,GET_DEVICE_319
  CALL GET_DEVICE_325
  INC DE
  RET
GET_DEVICE_319:
  PUSH HL
  CALL GET_DEVICE_322
  LD HL,$F466
  CP $09
  JP Z,GET_DEVICE_320
  INC (HL)
  JP GET_DEVICE_321
GET_DEVICE_320:
  INC (HL)
  LD A,(HL)
  AND $07
  JP NZ,GET_DEVICE_320
GET_DEVICE_321:
  LD A,($F4F8)
  DEC A
  CP (HL)
  POP HL
  RET
GET_DEVICE_322:
  LD HL,($F468)
  LD (HL),A
  INC HL
  LD ($F468),HL
  RET
GET_DEVICE_323:
  LD HL,($F468)
  DEC HL
  DEC HL
  DEC HL
  LD A,(HL)
  CP $1B
  JP Z,GET_DEVICE_324
  INC HL
  INC HL
GET_DEVICE_324:
  LD ($F468),HL
  LD HL,$F466
  DEC (HL)
  RET
GET_DEVICE_325:
  LD A,($F466)
  LD HL,$F4F8
  CP (HL)
  RET NC
  LD A,($F4F6)
  AND A
  JP NZ,GET_DEVICE_326
  LD A,$1B
  CALL GET_DEVICE_322
  LD A,$4B
  CALL GET_DEVICE_322
GET_DEVICE_326:
  LD A,$0D
  CALL GET_DEVICE_322
  LD A,$0A
  JP GET_DEVICE_322
GET_DEVICE_327:
  CALL GET_DEVICE_255
  LD A,($F4F6)
  AND A
  RET NZ
  LD BC,$F500
  PUSH DE
  EX DE,HL
  LD HL,($F4FE)
  EX DE,HL
  RST CPDEHL
  POP DE
  JP NC,GET_DEVICE_329
  EX DE,HL
  RST CPDEHL
  JP C,GET_DEVICE_330
  EX DE,HL
  LD HL,($F4FE)
  EX DE,HL
  RST CPDEHL
  JP NC,GET_DEVICE_330
GET_DEVICE_328:
  LD A,(BC)
  AND A
  RET NZ
  INC A
  LD H,$70
  JP GET_DEVICE_331
GET_DEVICE_329:
  EX DE,HL
  RST CPDEHL
  JP NC,GET_DEVICE_330
  EX DE,HL
  LD HL,($F4FE)
  EX DE,HL
  RST CPDEHL
  JP NC,GET_DEVICE_328
GET_DEVICE_330:
  LD A,(BC)
  AND A
  RET Z
  XOR A
  LD H,$71
GET_DEVICE_331:
  PUSH HL
  LD (BC),A
  LD A,$1B
  CALL GET_DEVICE_322
  POP AF
  JP GET_DEVICE_322
GET_DEVICE_332:
  LD B,A
  LD A,($F4F7)
  AND A
  LD A,B
  RET Z
GET_DEVICE_333:
  LD HL,$6A14
  LD B,$01
GET_DEVICE_334:
  CP (HL)
  RET Z
  INC HL
  DEC B
  JP NZ,GET_DEVICE_334
  CP '!'
  INC B
  RET NC
  DEC B
  RET
  DEC L
  ADD HL,HL
  INC A
  LD A,$5B
  LD E,L
  DEC HL
  DEC L
  LD HL,($CD2F)
  AND A
  LD H,L
  AND A
  RRA
GET_DEVICE_335:
  CALL GET_DEVICE_372
  LD ($F507),HL
  CALL GET_DEVICE_274
  ADD A,A
  LD HL,$F509
GET_DEVICE_336:
  LD (HL),$FE
  INC HL
  DEC A
  JP NZ,GET_DEVICE_336
  INC A
  JP GET_DEVICE_339
GET_DEVICE_337:
  PUSH AF
  LD HL,($F505)
  LD A,H
  OR L
  JP Z,GET_DEVICE_338
  EX DE,HL
  CALL GET_DEVICE_309
  POP AF
  LD B,A
  CALL GET_DEVICE_348
  LD A,B
  PUSH AF
  JP Z,GET_DEVICE_338
  DEC A
  JP Z,GET_DEVICE_338
  LD L,A
  LD H,$01
  CALL POSIT
  CALL GET_DEVICE_346
  LD A,D
  AND E
  INC A
  POP BC
  JP Z,ERAEOL
  PUSH BC
GET_DEVICE_338:
  POP AF
GET_DEVICE_339:
  LD L,A
  LD H,$01
  CALL POSIT
  CALL GET_DEVICE_352
  LD A,E
  AND D
  INC A
  JP Z,GET_DEVICE_344
  CALL GET_DEVICE_352
GET_DEVICE_340:
  CALL GET_DEVICE_275
  CP L
  JP Z,GET_DEVICE_341
  CALL GET_DEVICE_345
  LD A,D
  AND E
  INC A
  JP Z,GET_DEVICE_343
  CALL GET_DEVICE_349
  JP NZ,GET_DEVICE_340
  RET
GET_DEVICE_341:
  CALL GET_DEVICE_345
GET_DEVICE_342:
  CALL GET_DEVICE_274
  INC A
  JP GET_DEVICE_348
GET_DEVICE_343:
  CALL GET_DEVICE_349
  JP Z,GET_DEVICE_342
GET_DEVICE_344:
  CALL ERAEOL
  CALL ISFLIO_0
  JP GET_DEVICE_343
GET_DEVICE_345:
  CALL GET_DEVICE_309
GET_DEVICE_346:
  PUSH DE
  LD HL,($F468)
  LD DE,$F46A
GET_DEVICE_347:
  LD A,(DE)
  RST OUTC
  INC DE
  RST CPDEHL
  JP NZ,GET_DEVICE_347
  LD A,($F4F6)
  AND A
  CALL Z,ISFLIO_16
  POP DE
  RET
GET_DEVICE_348:
  PUSH DE
  CALL GET_DEVICE_353
  JP GET_DEVICE_350
GET_DEVICE_349:
  PUSH DE
  CALL GET_DEVICE_352
GET_DEVICE_350:
  LD C,A
  EX (SP),HL
  RST CPDEHL
  LD A,C
  EX DE,HL
  POP HL
  RET Z
  LD (HL),E
  INC HL
  LD (HL),D
  LD A,C
  RET
GET_DEVICE_351:
  CALL GET_DEVICE_274
  INC A
  JP GET_DEVICE_353
GET_DEVICE_352:
  LD A,(CSRX)
GET_DEVICE_353:
  LD E,A
  LD D,$00
  LD HL,$F505
  ADD HL,DE
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  RET
GET_DEVICE_354:
  CALL GET_DEVICE_352
  DEC A
  JP Z,GET_DEVICE_355
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  RET
GET_DEVICE_355:
  LD HL,($F583)
  RST CPDEHL
  JP C,GET_DEVICE_356
  LD DE,$0000
  RET
GET_DEVICE_356:
  PUSH DE
  DEC DE
  RST CPDEHL
  JP NC,GET_DEVICE_358
GET_DEVICE_357:
  DEC DE
  RST CPDEHL
  JP NC,GET_DEVICE_358
  LD A,(DE)
  CP $0A
  JP NZ,GET_DEVICE_357
  DEC DE
  RST CPDEHL
  JP NC,GET_DEVICE_358
  LD A,(DE)
  INC DE
  CP $0D
  JP NZ,GET_DEVICE_357
  INC DE
GET_DEVICE_358:
  PUSH DE
  CALL GET_DEVICE_309
  POP BC
  EX DE,HL
  POP DE
  PUSH DE
  RST CPDEHL
  EX DE,HL
  JP C,GET_DEVICE_358
  POP DE
  LD E,C
  LD D,B
  RET
GET_DEVICE_359:
  CALL GET_DEVICE_354
  EX DE,HL
  LD ($F505),HL
  RET
GET_DEVICE_360:
  LD ($F501),HL
  PUSH HL
  LD HL,$F507
  CALL GET_DEVICE_274
  LD B,A
GET_DEVICE_361:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  LD HL,($F501)
  RST CPDEHL
  JP C,GET_DEVICE_362
  POP HL
  EX DE,HL
  EX (SP),HL
  EX DE,HL
  DEC B
  JP P,GET_DEVICE_361
  DI
  HALT
GET_DEVICE_362:
  EX DE,HL
  POP HL
  POP HL
GET_DEVICE_363:
  PUSH HL
  LD HL,$F46A
  LD ($F468),HL
  XOR A
  LD ($F466),A
  POP HL
  DEC HL
GET_DEVICE_364:
  INC HL
  RST CPDEHL
  JP NC,GET_DEVICE_365
  LD A,(HL)
  CALL GET_DEVICE_319
  LD A,(HL)
  CP ' '
  JP NC,GET_DEVICE_364
  CP $09
  JP Z,GET_DEVICE_364
  CALL GET_DEVICE_319
  JP GET_DEVICE_364
GET_DEVICE_365:
  LD A,($F466)
  INC A
  LD H,A
  CALL GET_DEVICE_274
  SUB B
  LD L,A
  RET
GET_DEVICE_366:
  CALL GET_DEVICE_352
  PUSH DE
  INC A
  CALL GET_DEVICE_353
  LD A,D
  AND E
  INC A
  JP NZ,GET_DEVICE_367
  LD HL,($FA88)
  EX DE,HL
  INC DE
GET_DEVICE_367:
  DEC DE
  LD A,(DE)
  CP $0A
  JP NZ,GET_DEVICE_368
  DEC DE
  LD A,(DE)
  CP $0D
  JP Z,GET_DEVICE_368
  INC DE
GET_DEVICE_368:
  POP HL
  PUSH HL
  CALL GET_DEVICE_363
  LD A,(CSRY)
  CP H
  JP C,GET_DEVICE_367
  POP HL
  EX DE,HL
  RET
GET_DEVICE_369:
  LD HL,($F583)
GET_DEVICE_370:
  LD A,$1A
GET_DEVICE_371:
  CP (HL)
  INC HL
  JP NZ,GET_DEVICE_371
  DEC HL
  LD ($FA88),HL
  RET
GET_DEVICE_372:
  PUSH AF
  EX DE,HL
  LD HL,($F583)
  EX DE,HL
GET_DEVICE_373:
  PUSH HL
  PUSH DE
  CALL GET_DEVICE_309
  POP BC
  POP HL
  RST CPDEHL
  JP NC,GET_DEVICE_373
  LD H,B
  LD L,C
  POP BC
  DEC B
  RET Z
  EX DE,HL
GET_DEVICE_374:
  PUSH BC
  CALL GET_DEVICE_355
  POP BC
  LD A,D
  OR E
  LD HL,($F583)
  RET Z
  DEC B
  JP NZ,GET_DEVICE_374
  EX DE,HL
  RET
; This entry point is used by the routine at GETWORD.
INSCHR:
  LD BC,$0001
  PUSH AF
  CALL GET_DEVICE_376
  POP BC
  RET C
  LD (HL),B
  INC HL
  RET
; This entry point is used by the routine at GETWORD.
GET_DEVICE_376:
  EX DE,HL
  LD HL,(ARREND)
  ADD HL,BC
  RET C
  LD A,$88
  SUB L
  LD L,A
  LD A,$FF
  SBC A,H
  LD H,A
  RET C
  ADD HL,SP
  CCF
  RET C
; This entry point is used by the routine at GETWORD.
MAKHOL_0:
  PUSH BC
  CALL GET_DEVICE_379
  LD HL,(ARREND)
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  PUSH DE
  LD E,L
  LD D,H
  ADD HL,BC
  LD (ARREND),HL
  EX DE,HL
  DEC DE
  DEC HL
  POP BC
  LD A,B
  OR C
  CALL NZ,GET_DEVICE_381
  INC HL
  POP BC
  RET
; This entry point is used by the routine at GETWORD.
MASDEL:
  LD A,B
  OR C
  RET Z
  PUSH HL
  PUSH BC
  PUSH HL
  ADD HL,BC
  EX DE,HL
  LD HL,(ARREND)
  EX DE,HL
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  POP DE
  LD A,B
  OR C
  CALL NZ,_LDIR
  EX DE,HL
  LD (ARREND),HL
  POP BC
  XOR A
  SUB C
  LD C,A
  SBC A,A
  SUB B
  LD B,A
  POP HL
GET_DEVICE_379:
  PUSH HL
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,(PROGND)
  ADD HL,BC
  LD (PROGND),HL
  LD HL,(VAREND)
  ADD HL,BC
  LD (VAREND),HL
  POP HL
  RET
; This entry point is used by the routines at GETWORD and ISFLIO.
_LDIR:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC BC
  LD A,B
  OR C
  JP NZ,_LDIR
  RET
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_381:
  LD A,(HL)
  LD (DE),A
  DEC HL
  DEC DE
  DEC BC
  LD A,B
  OR C
  JP NZ,GET_DEVICE_381
  RET
  OR B
  RET NC
  LD L,H
  LD B,D
  LD B,C
  LD D,E
  LD C,C
  LD B,E
  JR NZ,GET_DEVICE_384
  NOP
  OR B
  CALL NZ,GET_DEVICE_20
  LD B,L
  LD E,B
  LD D,H
  JR NZ,GET_DEVICE_385
  JR NZ,GET_DEVICE_382
GET_DEVICE_382:
  OR B
  CALL C,GET_DEVICE_19
  LD B,L
  LD C,H
  LD B,E
  LD C,A
  LD C,L
  JR NZ,GET_DEVICE_383
GET_DEVICE_383:
  ADC A,B
  NOP
  NOP
  NOP
  LD D,E
  LD (HL),L
  LD A,D
  LD (HL),L
  LD L,E
GET_DEVICE_384:
  LD L,C
  JR NZ,GET_DEVICE_381
  NOP
  NOP
  NOP
  LD C,B
  LD H,C
  LD A,C
  LD H,C
GET_DEVICE_385:
  LD (HL),E
  LD L,B
  LD L,C
  LD C,B
  NOP
  NOP
  NOP
  LD D,D
  LD L,C
  LD H,E
  LD L,E
  LD E,C
  JR NZ,$6CF0
  
  
  CALL PRINT_COPYRIGHT
  LD HL,$F870
  LD (DIRPNT),HL
  LD HL,(SUZUKI)
  LD (BASTXT),HL
  LD A,$FF
  LD ($F3E9),A
GET_DEVICE_386:
  CALL GET_DEVICE_388
  CALL GET_DEVICE_152
  XOR A
  LD (FNK_FLAG),A
  CALL UPD_PTRS
  CALL RUN_FST
  JP READY

; This entry point is used by the routine at GETWORD.
GET_DEVICE_387:
  LD HL,$F6A5
  LD DE,$F746
  JP GET_DEVICE_389
GET_DEVICE_388:
  LD HL,$F746
  LD DE,$F6A5
GET_DEVICE_389:
  LD B,$A0
  JP LDIR_B
GET_DEVICE_390:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
GET_DEVICE_391:
  LD A,(DE)
  INC A
  RET Z
  PUSH HL
  LD B,$04
GET_DEVICE_392:
  LD A,(DE)
  LD C,A
  CALL UCASE_HL
  CP C
  INC DE
  INC HL
  JP NZ,GET_DEVICE_394
  DEC B
  JP NZ,GET_DEVICE_392
  POP AF
  PUSH HL
  EX DE,HL
GET_DEVICE_393:
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  POP DE
  EX (SP),HL
  PUSH HL
  EX DE,HL
  INC H
  DEC H
  RET

GET_DEVICE_394:
  INC DE
  DEC B
  JP NZ,GET_DEVICE_394
  INC DE
  POP HL
  JP GET_DEVICE_391

GET_DEVICE_395:
  DI
  LD HL,$FE40
  LD B,$84
  CALL SCPTLP_96
  INC A
GET_DEVICE_396:
  PUSH AF
  DI
  LD A,$19
  JR NC,GET_DEVICE_393
  RET Z
  LD A,$43
  OUT ($B8),A
  LD A,$05
  CALL GET_DEVICE_507
  LD A,$ED
  OUT ($BA),A
  LD A,($FE43)
  CALL GET_DEVICE_434
  CALL GET_DEVICE_566
  CALL GET_DEVICE_543
  XOR A
  OUT ($FE),A
  CALL GET_DEVICE_543
  LD A,$3B
  OUT ($FE),A
  CALL GET_DEVICE_542
  CALL GET_DEVICE_543
  LD A,$39
  OUT ($FE),A
  EI
  POP AF
  RET Z
  CALL GET_DEVICE_433
  LD A,($FEC1)
  CP $02
  RET NC
  CALL GET_DEVICE_582
  CALL GET_DEVICE_581
  LD A,($FEC1)
  DEC A
  CALL NZ,GET_DEVICE_589
  RET

; This entry point is used by the routine at GETWORD.
GET_DEVICE_397:
  PUSH BC
  LD C,A
GET_DEVICE_398:
  CALL GET_DEVICE_494
  JP C,$6DBF
  IN A,($BB)
  AND $06
  XOR $02
  JP NZ,GET_DEVICE_398
  CALL SETINT_1D
  LD A,C
  OUT ($B9),A
  LD A,($FE44)
  LD B,A
  OR $20
  NOP
  OUT ($90),A
  LD A,B
  OUT ($90),A
  PUSH BC
  LD C,$06
  CALL GET_DEVICE_681
GET_DEVICE_399:
  POP BC
  LD A,$09
  JR NC,$6E39
  POP BC
  RET

; Check RS232 queue for characters, Z if no data, A = number of chars in queue
;
; Used by the routines at EXEC_EVAL, TEL_TERM, TEL_UPLD and RV232C.
RCVX:
  LD A,(XONXOFF_FLG)
  OR A
  JP Z,RCVX_0
  LD A,(XONXOFF)
  INC A
  RET Z
RCVX_0:
  LD A,(RS232_COUNT)
  OR A
  RET

; Get from RS232, A = char, Z if OK, CY if BREAK
;
; Used by the routines at COM_INPUT, TEL_LOGON, TEL_TERM and TEL_UPLD.
RV232C:
  PUSH HL
  PUSH DE
  PUSH BC
  LD HL,POPALL_INT+1
  PUSH HL
  LD HL,RS232_COUNT
RV232C_0:
  CALL GET_DEVICE_580
  CALL RCVX
  JP Z,RV232C_0
  CP $03
  CALL C,SENDCQ
  DI
  DEC (HL)
  CALL _UART_2
  LD A,(HL)
  EX DE,HL
  INC HL
  INC HL
  INC (HL)
  DEC (HL)
  RET Z
  DEC (HL)
  JP Z,RV232C_1
  CP A
  RET
RV232C_1:
  OR $FF
  RET

; RST 6.5 (RS232 Interrupt on received character) routine
;
; Used by the routine at RST65.
_UART:
  CALL UART
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,POPALL_INT
  PUSH HL
  IN A,($C8)
  LD HL,$FE4C
  AND (HL)
  LD C,A
  IN A,($D8)
  AND $0E
  LD B,A
  JP NZ,_UART_0
  LD A,C
  CP $11	; XON
  JP Z,$6E26
  CP $13	; XOFF
  JP NZ,_UART_0
  LD A,$AF
  LD ($FE40),A
  LD A,(XONXOFF_FLG)
  OR A
  RET NZ

_UART_0:
  LD A,($FE43)
  CP $03
  JP NZ,GET_DEVICE_408
  LD A,($F40B)
  CP $53
  JP NZ,GET_DEVICE_408
  LD HL,$F9B8
  LD A,C
  SUB $0F
  JP NZ,GET_DEVICE_407
  LD (HL),A
  RET

GET_DEVICE_407:
  INC A
  JP NZ,GET_DEVICE_408
  LD (HL),$80
  RET

GET_DEVICE_408:
  LD HL,RS232_COUNT
  LD A,(HL)
  CP $FF
  RET Z
  CP $E7
  CALL NC,SENDCS
  PUSH BC
  INC (HL)
  INC HL
  CALL _UART_2
  POP BC
  LD A,($F40B)
  CP $53
  JP NZ,GET_DEVICE_409
  LD A,C
  CP ' '
  JP C,GET_DEVICE_410
GET_DEVICE_409:
  LD A,($F9B8)
  OR C
GET_DEVICE_410:
  LD (HL),A
  LD A,B
  OR A
  RET Z
  EX DE,HL
  INC HL
  DEC (HL)
  INC (HL)
  RET NZ
  LD A,(RS232_COUNT)
  LD (HL),A
  RET
  
_UART_2:
  INC HL
  LD C,(HL)
  LD A,C
  INC A
  CP $FF
  JP C,GET_DEVICE_412
  XOR A
GET_DEVICE_412:
  LD (HL),A
  EX DE,HL
  LD HL,RS232_BUF
  LD B,$00
  ADD HL,BC
  RET

; Send CTRL-Q character (X-ON)
;
; Used by the routine at RV232C.
SENDCQ:
  LD A,(XONXOFF_FLG)
  AND A
  RET Z
  LD A,(CTRL_S_FLG)
  DEC A
  RET NZ
  LD (CTRL_S_FLG),A
  PUSH BC
  LD C,$11
  JP _SD232C_DELAYED

; Send CTRL-S character (X-OFF)
;
; Used by the routine at _UART.
SENDCS:
  LD A,(XONXOFF_FLG)
  AND A
  RET Z
  LD A,(CTRL_S_FLG)
  OR A
  RET NZ
  INC A
  LD (CTRL_S_FLG),A
  PUSH BC
  LD C,$13		; XOFF
  JP _SD232C

; This entry point is used by the routine at GETWORD.
GET_DEVICE_415:
  RST $38
  LD D,D
  PUSH BC
  LD C,A
  LD A,($F40B)
  CP $53
  JP NZ,GET_DEVICE_416
  LD A,($F9B7)
  XOR C
  LD A,C
  LD ($F9B7),A
  JP P,GET_DEVICE_416
  ADD A,A
  SBC A,A
  ADD A,$0F
  CALL GET_DEVICE_417
GET_DEVICE_416:
  LD A,C
  POP BC
GET_DEVICE_417:
  PUSH BC
  LD C,A
  CALL GET_DEVICE_421
  JP C,GET_DEVICE_420


_SD232C_DELAYED:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
_SD232C:
  IN A,($D8)
  AND $10
  JP Z,_SD232C
  LD A,C
  OUT ($C8),A
GET_DEVICE_420:
  LD A,C
  POP BC
  RET

GET_DEVICE_421:
  LD A,(XONXOFF_FLG)
  OR A
  RET Z
  LD A,C
  CP $11
  JP NZ,GET_DEVICE_422
  XOR A
  LD (CTRL_S_FLG),A
  JP GET_DEVICE_423
GET_DEVICE_422:
  SUB $13
  JP NZ,GET_DEVICE_424
  DEC A
GET_DEVICE_423:
  LD (XONXOFF),A
  RET
GET_DEVICE_424:
  CALL GET_DEVICE_494
  RET C
  LD A,($FE40)
  OR A
  JP NZ,GET_DEVICE_424
  RET


; Set baud rate, H = 0..9
;
; Used by the routine at INZCOM.
BAUDST:
  PUSH HL
  LD A,H
  RLCA
  LD HL,BAUD_TBL-2
  LD D,$00
  LD E,A
  ADD HL,DE
  LD (RS232_BAUD),HL
  POP HL
; This entry point is used by the routine at MUSIC.
BAUDST_0:
  PUSH HL
  LD HL,(RS232_BAUD)
  LD A,(HL)
  OUT ($BC),A
  INC HL
  LD A,(HL)
  OUT ($BD),A
  LD A,$C3
  OUT ($B8),A
  POP HL
  RET

; Start of 18 byte RS232 baud rate timer values (words).
BAUD_TBL:
  DEFW $4800
  DEFW $456B
  DEFW $4200
  DEFW $4100
  DEFW $4080
  DEFW $4040
  DEFW $4020
  DEFW $4010
  DEFW $4008



; Routine at 28498
;
; Used by the routine at L76E6.
L6F52:
  LD A,$01
  LD BC,$023E
  LD BC,$033E
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CP $03
  JP Z,GET_DEVICE_428
  CALL $6F8E
  LD BC,$C0FF
  LD HL,$091C
GET_DEVICE_428:
  DI
  LD A,C
  LD ($FE4C),A
  POP AF
  PUSH AF
  CALL GET_DEVICE_434
  
  CALL BAUDST
  IN A,($BA)
  AND $3F
  OR B
  OUT ($BA),A
  IN A,($D8)
  LD A,L
  AND $1F
  OUT ($D8),A
  CALL RES_RS232_FLAGS
  JP POPALL_INT

; This entry point is used by the routine at GETWORD.
_XONXOFF_FLG:
  LD A,$AF
  DI
_XONXOFF_SETFLG:
  LD (XONXOFF_FLG),A
  EI
  RET
  
RES_RS232_FLAGS:
  XOR A
  LD L,A
  LD H,A
  LD ($FE40),HL
  LD (RS232_COUNT),HL
  LD ($FE47),HL
  LD ($F9B7),HL
  LD (CTRL_S_FLG),A
  RET

; This entry point is used by the routine at GETWORD.
GET_DEVICE_432:
  IN A,($BA)
  OR $C0
  OUT ($BA),A
GET_DEVICE_433:
  XOR A
  LD ($FEC2),A
GET_DEVICE_434:
  RST $38
  LD D,H
  PUSH BC
  LD C,A
  OR A
  JP Z,GET_DEVICE_435
  LD A,($FE43)
  OR A
  JP Z,GET_DEVICE_435
  CP C
  JP NZ,$056E
GET_DEVICE_435:
  LD A,C
  LD ($FE43),A
  RRCA
  RRCA
  LD C,A
  LD A,($FE44)
  AND $3F
  OR C
  LD ($FE44),A
  OUT ($90),A
  POP BC
  RET

; This entry point is used by the routine at GETWORD.
DATAR_1:
  LD A,($FE44)
  AND $F7
  INC E
  DEC E
  JP Z,GET_DEVICE_437
  OR $08
GET_DEVICE_437:
  OUT ($90),A
  LD ($FE44),A
  RET
; This entry point is used by the routine at GETWORD.
DATAW:
  LD C,A
  LD DE,$00A5
  CALL GET_DEVICE_444
  IN A,($B9)
  ADD A,$00
  LD B,$08
GET_DEVICE_439:
  NOP
  NOP
  LD HL,($0000)
  INC DE
  LD A,C
  RRA
  LD C,A
  JP C,GET_DEVICE_442
  ADD A,$00
  LD DE,$00A5
  CALL GET_DEVICE_444
  IN A,($B9)
GET_DEVICE_440:
  DEC B
  JP NZ,GET_DEVICE_439
  LD A,$03
GET_DEVICE_441:
  DEC A
  JP NZ,GET_DEVICE_441
  LD A,($0000)
  LD DE,$00A8
  CALL GET_DEVICE_443
  NOP
  NOP
  LD DE,$00A8
  CALL GET_DEVICE_443
  JP GET_DEVICE_494
GET_DEVICE_442:
  NOP
  LD DE,$00A5
  CALL GET_DEVICE_443
  JP GET_DEVICE_440
GET_DEVICE_443:
  LD A,$D0
  JP GET_DEVICE_445
GET_DEVICE_444:
  IN A,($B9)
  LD A,$50
GET_DEVICE_445:
  JR NC,$705C
  LD A,D
  OR E
  JP NZ,$7040
  RET
  
; This entry point is used by the routine at GETWORD.
GET_DEVICE_446:
  CALL GET_DEVICE_444
  LD BC,5240
  CALL DELAY_BC
  CALL GET_DEVICE_443
  LD BC,1000
  JP DELAY_BC

; Read cassette header and sync byte only
;
; Used by the routine at HEADER.SYNCR:
SYNCR:
  LD D,$00
SYNCR_0:
  CALL GET_DEVICE_457
  RET C
  LD A,H
  RLA
  JP C,SYNCR
  INC D
  JP NZ,SYNCR_0
GET_DEVICE_449:
  LD D,$00
GET_DEVICE_450:
  CALL GET_DEVICE_457
  RET C
  LD A,H
  AND A
  JP P,GET_DEVICE_449
  INC D
  JP P,GET_DEVICE_450
  RET

GET_DEVICE_451:
  LD E,$00
GET_DEVICE_452:
  CALL GET_DEVICE_494
  RET C
  JR NZ,GET_DEVICE_454
  JP NC,GET_DEVICE_452
GET_DEVICE_453:
  INC E
  JP Z,GET_DEVICE_451
GET_DEVICE_454:
  JR NZ,$7090
  JP C,GET_DEVICE_453
  XOR A
  RET

; This entry point is used by the routine at GETWORD.
DATAR:
  CALL GET_DEVICE_451
  RET C
  LD A,$14
  CP E
  JP NC,DATAR
  CALL GET_DEVICE_451
  RET C
  LD A,$14
  CP E
  JP NC,DATAR
  LD L,$08
GET_DEVICE_456:
  CALL GET_DEVICE_457
  RET C
  DEC L
  JP NZ,GET_DEVICE_456
  LD A,H
  CP H
  RET
  
GET_DEVICE_457:
  CALL GET_DEVICE_451
  RET C
  LD B,E
  CALL GET_DEVICE_451
  RET C
  LD A,B
  ADD A,E
  CP $28
  JP NC,GET_DEVICE_458
  CALL GET_DEVICE_451
  RET C
  CALL GET_DEVICE_451
  RET C
  SCF
GET_DEVICE_458:
  LD A,H
  RRA
  LD H,A
  XOR A
  RET
  
  LD HL,GET_DEVICE_483
  PUSH HL
  LD HL,$FE4D
  DEC (HL)
  RET NZ
  LD (HL),$03
  LD HL,$FE57
  LD DE,$FE60
  ; BRK_SCAN
  LD A,$FF
  OUT ($B9),A
  IN A,($BA)
  AND $FE
  OUT ($BA),A
  IN A,($E8)
  PUSH AF
  IN A,($BA)
  INC A
  OUT ($BA),A
  POP AF
  CPL
  CP (HL)
  LD (HL),A
  JP NZ,GET_DEVICE_459
  LD A,(DE)
  LD B,A
  LD A,(HL)
  LD (DE),A
GET_DEVICE_459:
  XOR A
  OUT ($B9),A
  IN A,($E8)
  INC A
  LD A,$FF
  OUT ($B9),A
  JP Z,GET_DEVICE_484
  LD A,$7F
  LD C,$07
GET_DEVICE_460:
  LD B,A
  OUT ($B9),A
  IN A,($E8)
  CPL
  DEC HL
  DEC DE
  CP (HL)
  LD (HL),A
  LD A,$FF
  OUT ($B9),A
  JP NZ,GET_DEVICE_461
  LD A,(DE)
  CP (HL)
  CALL NZ,GET_DEVICE_462
GET_DEVICE_461:
  LD A,B
  RRCA
  DEC C
  JP P,GET_DEVICE_460
  DEC HL
  LD (HL),$02
  LD HL,$FE63
  DEC (HL)
  JP Z,GET_DEVICE_468
  INC (HL)
  RET M
  LD A,($FE65)
  LD HL,($FE66)
  AND (HL)
  RET Z
  LD A,($FE68)
  CP $02
  RET NC
  LD HL,$FE62
  DEC (HL)
  RET NZ
  LD (HL),$06
  LD A,$01
  LD ($FEB8),A
  JP GET_DEVICE_469
GET_DEVICE_462:
  PUSH BC
  PUSH HL
  PUSH DE
  LD B,A
  LD A,$80
  LD E,$07
GET_DEVICE_463:
  LD D,A
  AND (HL)
  JP Z,GET_DEVICE_464
  AND B
  JP Z,GET_DEVICE_466
GET_DEVICE_464:
  LD A,D
  RRCA
  DEC E
  JP P,GET_DEVICE_463
  POP DE
GET_DEVICE_465:
  POP HL
  LD A,(HL)
  LD (DE),A
  POP BC
  RET
GET_DEVICE_466:
  LD HL,$FE63
  INC A
  CP (HL)
  JP NZ,GET_DEVICE_467
  POP DE
  POP HL
  POP BC
  RET
GET_DEVICE_467:
  LD (HL),A
  LD A,C
  RLCA
  RLCA
  RLCA
  OR E
  INC HL
  LD (HL),A
  INC HL
  LD (HL),D
  POP DE
  EX DE,HL
  LD ($FE66),HL
  EX DE,HL
  JP GET_DEVICE_465
GET_DEVICE_468:
  DEC HL
  LD (HL),$54
  DEC HL
  LD A,($FE60)
  LD (HL),A
GET_DEVICE_469:
  LD HL,$7224
  PUSH HL
  LD HL,$FE64
  LD A,(HL)
  LD C,A
  LD DE,$002E
  LD B,D
  CP $35
  LD A,B
  SBC A,B
  INC HL
  AND (HL)
  LD (HL),A
  LD A,($FE61)
  RRCA
  PUSH AF
  LD A,C
  CP E
  JP C,GET_DEVICE_472
  POP AF
  LD E,A
  RRCA
  JP NC,GET_DEVICE_470
  LD A,C
  CP $31
  JP C,GET_DEVICE_470
  CP $35
  LD HL,$71EA
  JP C,GET_DEVICE_471
GET_DEVICE_470:
  LD HL,$7BFD
  LD A,E
  RLCA
  JP NC,GET_DEVICE_471
  LD HL,$7C0F
GET_DEVICE_471:
  ADD HL,BC
  LD A,(HL)
  RET
GET_DEVICE_472:
  POP AF
  LD E,B
  JP NC,GET_DEVICE_473
  LD E,$15
GET_DEVICE_473:
  PUSH AF
  LD HL,$7BE9
  AND $20
  JP Z,GET_DEVICE_474
  LD HL,GET_DEVICE_646
GET_DEVICE_474:
  ADD HL,BC
  POP AF
  RRCA
  JP C,GET_DEVICE_477
  RRCA
  JP C,GET_DEVICE_621
  DEC E
  JP P,GET_DEVICE_476
  AND $02
GET_DEVICE_475:
  LD A,(HL)
  RET Z
  JP GET_DEVICE_629
GET_DEVICE_476:
  LD A,C
  CP $1A		; EOF
  JP C,GET_DEVICE_475
  ADD HL,DE
  LD A,(HL)
  RET
GET_DEVICE_477:
  AND $10
  LD A,C
  LD C,$1B
  CALL NZ,GET_DEVICE_478
  CP C
  LD A,(HL)
  JP C,$721F
  XOR A
  RET
GET_DEVICE_478:
  DEC C
  CP '"'
  RET NZ
  XOR A
  RET
  RLA
  LD A,(DE)
  LD DE,$7E12
  AND $1F
  POP HL
  JP C,GET_DEVICE_688
  LD C,A
  SUB $F0
  JP C,GET_DEVICE_479
  LD C,A
  JP GET_DEVICE_481
GET_DEVICE_479:
  LD A,C
  CP $11
  JP Z,GET_DEVICE_480
  AND $EF
  CP $03
  JP NZ,GET_DEVICE_482
GET_DEVICE_480:
  LD A,(FNK_FLAG)
  AND $C0
  JP NZ,GET_DEVICE_482
  LD A,C
  LD ($FEA9),A
  CP $03
  RET NZ
  LD HL,$FE68
  LD (HL),$00
  INC B
GET_DEVICE_481:
  DEC B
GET_DEVICE_482:
  LD HL,$FE68
  LD A,(HL)
  CP ' '
  RET NC
  INC (HL)
  RLCA
  INC HL
  LD E,A
  ADD HL,DE
  LD (HL),C
  INC HL
  LD (HL),B
  POP AF
GET_DEVICE_483:
  LD A,$09
  JR NC,$7258

; POP AF, BC, DE, and HL off stack, enable interrupts and return.
;
; Used by the routines at INZCOM and MUSIC.
POPALL_INT:
  POP AF
;
  POP BC
  POP DE
  POP HL
  EI
  RET

GET_DEVICE_484:
  LD HL,$FE4E
  DEC (HL)
  RET NZ
  LD HL,$FE4F
  LD B,$11
  JP SCPTLP_96
; This entry point is used by the routine at GETWORD.
GET_DEVICE_485:
  CALL SETINT_1D
  LD A,($FE68)
  OR A
  JP Z,GET_DEVICE_488
  LD HL,$FE6A
  LD A,(HL)
  ADD A,$02
  DEC HL
  LD A,(HL)
  PUSH AF
  DEC HL
  DEC (HL)
  LD A,(HL)
  RLCA
  LD C,A
  LD DE,$FE6B
  INC HL
GET_DEVICE_486:
  DEC C
GET_DEVICE_487:
  JP M,GET_DEVICE_489
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  JP GET_DEVICE_486
GET_DEVICE_488:
  PUSH AF
GET_DEVICE_489:
  LD A,$09
  JR NC,GET_DEVICE_487
  RET
; This entry point is used by the routine at GETWORD.
GET_DEVICE_490:
  CALL GET_DEVICE_492
  JP Z,GET_DEVICE_491
  CP $03
  JP NZ,GET_DEVICE_491
  OR A
  SCF
  RET
GET_DEVICE_491:
  LD A,($FE68)
  OR A
  RET
; This entry point is used by the routine at GETWORD.
GET_DEVICE_492:
  PUSH HL
  LD A,($F3E9)
  OR A
  JP Z,GET_DEVICE_493
  LD A,($FE60)
  LD L,A
  LD A,($FEAA)
  XOR L
  AND $01
  JP Z,GET_DEVICE_493
  AND L
  PUSH DE
  PUSH BC
  CALL ISFLIO_23
  POP BC
  POP DE
GET_DEVICE_493:
  LD HL,$FEA9
  LD A,(HL)
  LD (HL),$00
  POP HL
  OR A
  RET

GET_DEVICE_494:
  PUSH BC
  IN A,($BA)
  LD B,A
  OR $01
  OUT ($BA),A
  IN A,($B9)
  LD C,A
  LD A,$7F
  OUT ($B9),A
  IN A,($E8)
  PUSH AF
  LD A,$FF
  OUT ($B9),A
  LD A,B
  AND $FE
  OUT ($BA),A
  IN A,($E8)
  RRCA
  LD A,C
  OUT ($B9),A
  LD A,B
  OUT ($BA),A
  POP BC
  LD A,B
  RRA
  AND $C0
  POP BC
  RET NZ
  INC A
  SCF
  RET
  
; This entry point is used by the routine at GETWORD.
MUSIC:
  DI
  LD A,E
  OUT ($BC),A
  LD A,D
  OR $40
  OUT ($BD),A
  LD A,$C3
  OUT ($B8),A
  IN A,($BA)
  AND $F8
  OR $20
  OUT ($BA),A
MUSIC_0:
  CALL GET_DEVICE_494
  JP NC,MUSIC_1
  LD A,$03
  LD ($FEA9),A
  JP MUSIC_3
MUSIC_1:
  PUSH BC
  LD BC,$012F
  CALL DELAY_BC
  POP BC
  DEC B
  JP NZ,MUSIC_0
MUSIC_3:
  IN A,($BA)
  OR $04
  OUT ($BA),A
  CALL BAUDST_0
  EI
  RET
  
DELAY_BC:
  LD A,C
DELAY_BC_1:
  PUSH BC
  LD C,$48
DELAY_BC_2:
  DEC C
  JP NZ,DELAY_BC_2
  POP BC
  DEC A
  JP NZ,DELAY_BC_1
  DEC B
  JP NZ,DELAY_BC
  RET

; This entry point is used by the routine at GETWORD.
GET_DEVICE_502:
  OR $AF
  PUSH AF
  CALL SETINT_1D
  LD A,$03
  CALL NZ,GET_DEVICE_507
  LD A,$01
  CALL GET_DEVICE_507
  LD C,$07
  CALL DELAY_C
  LD B,$0A
GET_DEVICE_503:
  LD C,$04
  LD D,(HL)
GET_DEVICE_504:
  POP AF
  PUSH AF
  JP Z,GET_DEVICE_505
  IN A,($BB)
  RRA
  LD A,D
  RRA
  LD D,A
  XOR A
  JP GET_DEVICE_506

GET_DEVICE_505:
  LD A,D
  RRCA
  LD D,A
  LD A,$10
  RRA
  RRA
  RRA
  RRA
  OUT ($B9),A
GET_DEVICE_506:
  OR $09
  OUT ($B9),A
  AND $F7
  OUT ($B9),A
  DEC C
  JP NZ,GET_DEVICE_504
  LD A,D
  RRCA
  RRCA
  RRCA
  RRCA
  AND $0F
  LD (HL),A
  INC HL
  DEC B
  JP NZ,GET_DEVICE_503
  POP AF
  LD A,$02
  CALL Z,GET_DEVICE_507
  XOR A
  CALL GET_DEVICE_507
  JP SET_CLOCK_HL_16
GET_DEVICE_507:
  OUT ($B9),A
  LD A,($FE44)
  OR $10
  OUT ($90),A
  AND $EF
  OUT ($90),A
  RET
; This entry point is used by the routine at GETWORD.
GET_DEVICE_508:
  CALL SETINT_1D
  LD HL,$70CD
  PUSH HL
  LD HL,$FEB8
  DEC (HL)
  RET NZ
  LD (HL),$7D
  DEC HL
  LD A,(HL)
  OR A
  JP P,GET_DEVICE_509
  RET PO
GET_DEVICE_509:
  XOR $01
  LD (HL),A
  LD A,($F831)
  OR A
  JP Z,SET_CURSOR_SHAPE
  PUSH HL
  CALL GET_DEVICE_531
  LD A,($FEB7)
  RRCA
  JP NC,GET_DEVICE_514
  PUSH DE
  LD A,($F3DC)
  LD E,A
  LD A,$06
  LD HL,$FEB1
  LD BC,CURS_SHAPE
  PUSH BC
GET_DEVICE_510:
  PUSH AF
  LD A,(HL)
  OR E
  LD (BC),A
  INC BC
  INC HL
  POP AF
  DEC A
  JP NZ,GET_DEVICE_510
  POP HL
  POP DE
  JP GET_DEVICE_513
; This entry point is used by the routine at ISFLIO.
SET_CURSOR_SHAPE:
  PUSH HL
  LD HL,CURS_SHAPE
  LD D,$00
  CALL GET_DEVICE_533
  LD B,$06
  DEC HL
GET_DEVICE_512:
  LD A,(HL)
  CPL
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,GET_DEVICE_512
  INC HL
GET_DEVICE_513:
  LD D,$01
  CALL GET_DEVICE_533
GET_DEVICE_514:
  POP HL
  RET
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_515:
  OR $AF
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_516:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL SETINT_1D
  LD HL,$FEB7
  LD A,(HL)
  RRCA
  LD (HL),$80
  CALL C,GET_DEVICE_531
  POP AF
  PUSH AF
  JP Z,GET_DEVICE_483
  LD D,$00
  CALL GET_DEVICE_532
  XOR A
  LD ($FEB7),A
  INC A
  LD ($FEB8),A
  JP GET_DEVICE_483
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_517:
  CALL SETINT_1D
  LD HL,$0000
  ADD HL,SP
  LD ($FEBD),HL
  DEC D
  DEC E
  EX DE,HL
  LD (LCD_ADDR),HL
  LD A,C
  LD DE,$78B7
  SUB $20
  JP Z,GET_DEVICE_522
  CP $60
  JP NC,GET_DEVICE_519
  LD HL,$7AFF
  LD B,$09
GET_DEVICE_518:
  CP (HL)
  JP Z,GET_DEVICE_624
  INC HL
  DEC B
  JP NZ,GET_DEVICE_518
  SCF
  JP GET_DEVICE_522
GET_DEVICE_519:
  SUB $63
  JP NC,GET_DEVICE_520
  ADD A,$53
  OR A
  JP GET_DEVICE_522

GET_DEVICE_520:
  LD B,A
  DEC DE
  LD HL,($FEBF)
SET_CLOCK_HL_12:
  LD A,L
  OR H
  JP Z,GET_DEVICE_522
  EX DE,HL
  LD A,B
GET_DEVICE_522:
  PUSH AF
  LD L,A
  LD H,$00
  LD B,H
  LD C,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,BC
  POP AF
  PUSH AF
  JP C,SET_CLOCK_HL_13
  ADD HL,BC
SET_CLOCK_HL_13:
  ADD HL,DE
  POP AF
  JP NC,SET_CLOCK_HL_14
  LD DE,CURS_SHAPE
  PUSH DE
  LD B,$05
  CALL LDIR_B
  XOR A
  LD (DE),A
  POP HL
SET_CLOCK_HL_14:
  LD D,$01
  CALL GET_DEVICE_533
SET_CLOCK_HL_15:
  XOR A
  LD ($FEBE),A
  CALL GET_DEVICE_542
SET_CLOCK_HL_16:
  LD A,$09
  JR NC,SET_CLOCK_HL_12
  
; Move cursor to specified position
;
; Used by the routines at OUTC_SUB and DOTTED_FNAME.
MOVE_CURSOR:
  CALL SETINT_1D
  DEC D
  DEC E
  EX DE,HL
  LD (LCD_ADDR),HL
  JP SET_CLOCK_HL_16

; This entry point is used by the routine at GETWORD.
PLOT:
  defb $f6		; OR $AF

; Reset point on screen  (D,E)
;
; Used by the routine at __PSET.
UNPLOT:
  XOR A
  PUSH AF		; Save flags to choose between PLOT and UNPLOT
  CALL SETINT_1D
  PUSH DE
  LD C,$FE
  LD A,D
GET_DEVICE_529:
  INC C
  INC C
  LD D,A
  SUB $32
  JP NC,GET_DEVICE_529
  LD B,$00
  LD HL,PLOT_TBL
  LD A,E
  RLA
  RLA
  RLA
  JP NC,GET_DEVICE_530
  
  LD HL,PLOT_TBL2
  
GET_DEVICE_530:
  ADD HL,BC
  LD B,A
  CALL GET_DEVICE_544
  LD A,B
  AND $C0
  OR D
  LD B,A
  LD E,$01
  LD HL,CURS_SHAPE
  CALL $757E
  POP DE
  LD D,B
  LD A,E
  AND $07
  ADD A,A
  LD C,A
  LD B,$00
  LD HL,PLOT_TBL
  ADD HL,BC
  POP AF
  LD A,(HL)
  LD HL,CURS_SHAPE
  JP NZ,$751B
  CPL
  AND (HL)

  DEFB $06	; LD B,N
L7497:

  LD B,$B6
  LD (HL),A
  LD B,D
  LD E,$01
  CALL GET_LCD
  JP SET_CLOCK_HL_16

GET_DEVICE_531:
  LD D,$01
GET_DEVICE_532:
  LD HL,$FEB1
GET_DEVICE_533:
  PUSH HL
  LD E,$06
  LD A,(LCD_ADDR+1)
  CP $08
  JP Z,UNPLOT_3
  CP $10
  JP Z,UNPLOT_4
  CP $21
  JP NZ,UNPLOT_5
UNPLOT_3:
  DEC E
  DEC E
UNPLOT_4:
  DEC E
  DEC E
UNPLOT_5:
  LD C,A
  ADD A,C
  ADD A,C
  LD C,A
  LD B,$00
  LD A,(LCD_ADDR)
  RRA
  RRA
  RRA
  LD HL,GFX_MASK2
  JP C,UNPLOT_6
  LD HL,GFX_MASK

UNPLOT_6:
  ADD HL,BC
  LD B,A
  CALL GET_DEVICE_544
  LD ($FEBB),HL
  LD A,B
  OR (HL)
  LD B,A
  POP HL
  DEC D
  CALL SEND_LCD
  INC D
  LD A,$06
  SUB E
  RET Z
  LD E,A
  PUSH HL
  LD HL,($FEBB)
  INC HL
  CALL GET_DEVICE_544
  POP HL
  LD A,B
  AND $C0
  LD B,A
  DEC D

  defb $da		; JP C,NN

	DEFB $F6	;OR $AF (masks XOR A)

; This entry point is used by the routine at UNPLOT.

; Rebuild graphics character code to finalize PLOT/UNPLOT
GET_LCD:
  XOR A
  
; This entry point is used by the routine at L7497.
SEND_LCD:
  PUSH DE
  PUSH AF
  LD A,B
  CALL WAIT_LCD
  OUT ($FE),A
  JP Z,UNPLOT_8
  CALL WAIT_LCD
  IN A,($FF)
UNPLOT_8:
  POP AF
  JP NZ,DO_GET_LCD

DO_SEND_LCD:
  IN A,($FE)
  RLA
  JP C,DO_SEND_LCD
  LD A,(HL)
  OUT ($FF),A
  INC HL
  DEC E
  JP NZ,DO_SEND_LCD
  POP DE
  RET

DO_GET_LCD:
  IN A,($FE)
  RLA
  JP C,DO_GET_LCD
  IN A,($FF)
  LD (HL),A
  INC HL
  DEC E
  JP NZ,DO_GET_LCD
  POP DE
  RET

GET_DEVICE_542:
  CALL GET_DEVICE_543
  LD A,$3E
  OUT ($FE),A
  RET

GET_DEVICE_543:
  LD C,$03
  CALL DELAY_C
  LD HL,$76CA
GET_DEVICE_544:
  LD A,(HL)
  OUT ($B9),A
  INC HL
  IN A,($BA)
  AND $FC
  OR (HL)
  OUT ($BA),A
  INC HL
  RET

WAIT_LCD:
  PUSH AF
GET_DEVICE_546:
  IN A,($FE)
  RLA
  JP C,GET_DEVICE_546
  POP AF
  RET


; Data block at 30170
GFX_MASK:
  DEFB $01, $00, $00
  DEFB $01, $00, $06
  DEFB $01, $00, $0C
  DEFB $01, $00, $12
  DEFB $01, $00, $18
  DEFB $01, $00, $1E
  DEFB $01, $00, $24
  DEFB $01, $00, $2A
  DEFB $01, $00, $30
  DEFB $02, $00, $04
  DEFB $02, $00, $0A
  DEFB $02, $00, $10
  DEFB $02, $00, $16
  DEFB $02, $00, $1C
  DEFB $02, $00, $22
  DEFB $02, $00, $28
  DEFB $02, $00, $2E
  DEFB $04, $00, $02
  DEFB $04, $00, $08
  DEFB $04, $00, $0E
  DEFB $04, $00, $14
  DEFB $04, $00, $1A
  DEFB $04, $00, $20
  DEFB $04, $00, $26
  DEFB $04, $00, $2C
  DEFB $08, $00, $00
  DEFB $08, $00, $06
  DEFB $08, $00, $0C
  DEFB $08, $00, $12
  DEFB $08, $00, $18
  DEFB $08, $00, $1E
  DEFB $08, $00, $24
  DEFB $08, $00, $2A
  DEFB $08, $00, $30
  DEFB $10, $00, $04
  DEFB $10, $00, $0A
  DEFB $10, $00, $10
  DEFB $10, $00, $16
  DEFB $10, $00, $1C
  DEFB $10, $00, $22
  
; Data block at 30290
GFX_MASK2:
  DEFB $20, $00, $00
  DEFB $20, $00, $06
  DEFB $20, $00, $0C
  DEFB $20, $00, $12
  DEFB $20, $00, $18
  DEFB $20, $00, $1E
  DEFB $20, $00, $24
  DEFB $20, $00, $2A
  DEFB $20, $00, $30
  DEFB $40, $00, $04
  DEFB $40, $00, $0A
  DEFB $40, $00, $10
  DEFB $40, $00, $16
  DEFB $40, $00, $1C
  DEFB $40, $00, $22
  DEFB $40, $00, $28
  DEFB $40, $00, $2E
  DEFB $80, $00, $02
  DEFB $80, $00, $08
  DEFB $80, $00, $0E
  DEFB $80, $00, $14
  DEFB $80, $00, $1A
  DEFB $80, $00, $20
  DEFB $80, $00, $26
  DEFB $80, $00, $2C
  DEFB $00, $01, $00
  DEFB $00, $01, $06
  DEFB $00, $01, $0C
  DEFB $00, $01, $12
  DEFB $00, $01, $18
  DEFB $00, $01, $1E
  DEFB $00, $01, $24
  DEFB $00, $01, $2A
  DEFB $00, $01, $30
  DEFB $00, $02, $04
  DEFB $00, $02, $0A
  DEFB $00, $02, $10
  DEFB $00, $02, $16
  DEFB $00, $02, $1C
  DEFB $00, $02, $22
  


; Data block at 30412
PLOT_TBL:
  DEFB $01, $00
  DEFB $02, $00
  DEFB $04, $00
  DEFB $08, $00
  DEFB $10, $00
  
; Data block at 30422 ($76D6)
PLOT_TBL2:
  DEFB $20, $00
  DEFB $40, $00
  DEFB $80, $00
  DEFB $00, $01
  DEFB $00, $02
  

DELAY_C:
  DEC C
  JP NZ,DELAY_C
  RET

; Set interrupt to 1DH
;
; Used by the routines at PRINTR, KYREAD, SET_CLOCK_HL, MOVE_CURSOR, PLOT, UNPLOT and
; _BEEP.
SETINT_1D:
  DI
  LD A,$1D
  JR NC,SETINT_1D
  RET

;_BEEP:
  CALL SETINT_1D
  LD B,$00
_BEEP_0:
  CALL _CLICK
  LD C,$50
  CALL DELAY_C
  DEC B
  JP NZ,_BEEP_0
  JP SET_CLOCK_HL_16

_CLICK:
  IN A,($BA)
  XOR $20
  OUT ($BA),A
  RET

GET_DEVICE_565:
  CALL GET_DEVICE_570
  RET Z
GET_DEVICE_566:
  LD A,$91
  OUT ($73),A
  CALL GET_DEVICE_570
  RET NZ
  LD C,$00
  LD A,$0F
  OUT ($73),A
GET_DEVICE_567:
  CALL GET_DEVICE_580
  IN A,($72)
  AND $02
  JP Z,GET_DEVICE_567
  LD A,$0E
  OUT ($73),A
  LD A,C
  OUT ($71),A
  LD A,$09
  OUT ($73),A
GET_DEVICE_568:
  CALL GET_DEVICE_580
  IN A,($72)
  AND $04
  JP Z,GET_DEVICE_568
  LD A,$08
  OUT ($73),A
GET_DEVICE_569:
  CALL GET_DEVICE_580
  IN A,($72)
  AND $04
  JP NZ,GET_DEVICE_569
  RET
GET_DEVICE_570:
  PUSH BC
  LD A,$55
  LD B,A
  OUT ($71),A
  IN A,($71)
  CP B
  POP BC
  RET
GET_DEVICE_571:
  LD A,$0B
  OUT ($73),A
GET_DEVICE_572:
  CALL GET_DEVICE_580
  IN A,($72)
  AND $01
  JP Z,GET_DEVICE_572
  LD A,$0A
  OUT ($73),A
  IN A,($70)
  LD C,A
  LD A,$0D
  OUT ($73),A
GET_DEVICE_573:
  CALL GET_DEVICE_580
  IN A,($72)
  AND $01
  JP NZ,GET_DEVICE_573
  LD A,$0C
  OUT ($73),A
  RET
GET_DEVICE_574:
  IN A,($BA)
  AND $7F
  OUT ($BA),A
  LD D,$00
  CALL GET_DEVICE_575
  PUSH AF
  IN A,($BA)
  OR $80
  OUT ($BA),A
  POP AF
  RET C
  LD D,$10
GET_DEVICE_575:
  LD A,($FEC2)
  LD E,A
GET_DEVICE_576:
  LD BC,$01F4
GET_DEVICE_577:
  CALL GET_DEVICE_580
  IN A,($BB)
  AND $10
  XOR D
  RET Z
  DEC BC
  LD A,C
  OR B
  JP NZ,GET_DEVICE_577
  DEC E
  JP NZ,GET_DEVICE_576
  SCF
  RET
GET_DEVICE_578:
  PUSH BC
  CALL GET_DEVICE_574
  POP BC
  RET C
GET_DEVICE_579:
  CALL GET_DEVICE_580
  IN A,($D8)
  AND $10
  JP Z,GET_DEVICE_579
  LD A,C
  OUT ($C8),A
  RET

GET_DEVICE_580:
  CALL GET_DEVICE_494
  RET NC
  EX (SP),HL
  POP HL
  RET

GET_DEVICE_581:
  CALL GET_DEVICE_427
  JP GET_DEVICE_583
GET_DEVICE_582:
  CALL $6F55
GET_DEVICE_583:
  LD HL,GET_DEVICE_433
  PUSH HL
  LD A,$01
  LD ($FEC2),A
  LD C,$04
  CALL GET_DEVICE_578
  RET C
  XOR A
  LD ($FEC2),A
  CALL GET_DEVICE_587
  AND $3F
  RET NZ
  CALL GET_DEVICE_588
  LD DE,$0006
  RST CPDEHL
  RET NZ
  CALL GET_DEVICE_588
  RET C
  EX DE,HL
  CALL GET_DEVICE_588
  RET C
  CALL GET_DEVICE_592
  RET C
  CALL GET_DEVICE_588
  RET C
  EX DE,HL
  POP BC
  LD A,$FF
  LD ($FEC3),A
  LD SP,HL
  PUSH DE
  LD DE,$0000
  PUSH DE
  PUSH BC
GET_DEVICE_584:
  LD C,$47
  CALL GET_DEVICE_578
  RET C
  LD C,$04
  CALL GET_DEVICE_579
  RET C
  CALL GET_DEVICE_587
  RET C
  AND $3F
  JP Z,GET_DEVICE_585
  CP $0E			; Line number prefix
  RET NZ
  POP HL
  POP HL
  RET

GET_DEVICE_585:
  EX DE,HL
  CALL GET_DEVICE_588
  RET C
  EX DE,HL
GET_DEVICE_586:
  CALL GET_DEVICE_587
  LD (HL),A
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,GET_DEVICE_586
  JP GET_DEVICE_584

GET_DEVICE_587:
  CALL RV232C
  RET Z
  POP AF
  SCF
  RET

GET_DEVICE_588:
  CALL GET_DEVICE_587
  LD H,A
  CALL GET_DEVICE_587
  LD L,A
  RET

GET_DEVICE_589:
  CALL GET_DEVICE_565
  RET NZ
  LD HL,$7712
  PUSH HL
  LD C,$1B
  CALL GET_DEVICE_567
  RET C
  LD C,'*'
  CALL GET_DEVICE_567
  RET C
  CALL GET_DEVICE_591
  RET C
  EX DE,HL
  CALL GET_DEVICE_591
  RET C
  CALL GET_DEVICE_592
  RET C
  LD B,H
  LD C,L
  CALL GET_DEVICE_591
  RET C
  LD A,$FF
  LD ($FEC3),A
  EX DE,HL
  LD SP,HL
  PUSH DE
  LD DE,$0000
  PUSH DE
  LD D,B
  LD E,C
GET_DEVICE_590:
  CALL GET_DEVICE_571
  RET C
  LD (HL),C
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,GET_DEVICE_590
  POP AF
  RET

GET_DEVICE_591:
  PUSH BC
  CALL GET_DEVICE_571
  LD H,C
  POP BC
  RET C
  PUSH BC
  CALL GET_DEVICE_571
  LD L,C
  POP BC
  RET

GET_DEVICE_592:
  PUSH HL
  LD HL,(PROGND)
  LD BC,FNCTAB
  ADD HL,BC
  RST CPDEHL
  POP HL
  CCF
  RET C
  PUSH HL
  PUSH DE
  ADD HL,DE
  EX DE,HL
  LD HL,(HIMEM)
  RST CPDEHL
  POP DE
  POP HL
  RET

  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  LD C,A
  NOP
  NOP
  NOP
  RLCA
  NOP
  RLCA
  NOP
  INC D
  LD A,A
  INC D
  LD A,A
  INC D
  INC H
  LD HL,($2A7F)
  LD (DE),A
  INC HL
  INC DE
  EX AF,AF'
  LD H,H
  LD H,D
  LD A,($4A45)
  JR NC,GET_DEVICE_593
  NOP
  INC B
  LD (BC),A
  LD BC,$0000
  INC E
  LD ($0041),HL
  NOP
  LD B,C
  LD ($001C),HL
  LD ($7F14),HL
  INC D
  LD ($0808),HL
  LD A,$08
  EX AF,AF'
  NOP
  ADD A,B
  LD H,B
  NOP
  NOP
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  NOP
  LD H,B
  LD H,B
  NOP
  NOP
GET_DEVICE_593:
  LD B,B
  JR NZ,GET_DEVICE_594
  EX AF,AF'
  INC B
  LD A,$51
  LD C,C
  LD B,L
  LD A,$44
  LD B,D
  LD A,A
  LD B,B
  LD B,B
  LD H,D
  LD D,C
  LD D,C
  LD C,C
GET_DEVICE_594:
  LD B,(HL)
  LD ($4941),HL
  LD C,C
  LD (HL),$18
  INC D
  LD (DE),A
  LD A,A
  DJNZ $7968
  LD B,L
  LD B,L
  ADD HL,HL
  LD DE,$4A3C
  LD C,C
  LD C,C
  JR NC,GET_DEVICE_595
  LD BC,$0579
GET_DEVICE_595:
  INC BC
  LD (HL),$49
  LD C,C
  LD C,C
  LD (HL),$06
  LD C,C
  LD C,C
  ADD HL,HL
  LD E,$00
  NOP
  INC H
  NOP
  NOP
  NOP
  ADD A,B
  LD H,H
  NOP
  NOP
  EX AF,AF'
  INC E
  LD (HL),$63
  LD B,C
  INC D
  INC D
  INC D
  INC D
  INC D
  LD B,C
  LD H,E
  LD (HL),$1C
  EX AF,AF'
  LD (BC),A
  LD BC,$0951
  LD B,$32
  LD C,C
  LD A,C
  LD B,C
  LD A,$7C
  LD (DE),A
  LD DE,$7C12
  LD B,C
  LD A,A
  LD C,C
  LD C,C
  LD (HL),$1C
  LD (IS_ALPHA),HL
  LD ($7F41),HL
  LD B,C
  LD (__MAX_0),HL
  LD C,C
  LD C,C
  LD C,C
  LD B,C
  LD A,A
  ADD HL,BC
  ADD HL,BC
  ADD HL,BC
  LD BC,$413E
  LD C,C
  LD C,C
  LD A,($087F)
  EX AF,AF'
  EX AF,AF'
  LD A,A
  NOP
  LD B,C
  LD A,A
  LD B,C
  NOP
  JR NC,GET_DEVICE_596
  LD B,C
  CCF
  LD BC,$087F
  INC D
  LD ($7F41),HL
  LD B,B
  LD B,B
  LD B,B
  LD B,B
  LD A,A
  LD (BC),A
  INC C
  LD (BC),A
  LD A,A
  LD A,A
  LD B,$08
  JR NC,GET_DEVICE_602
  LD A,$41
  LD B,C
  LD B,C
  LD A,$7F
  ADD HL,BC
  ADD HL,BC
  ADD HL,BC
  LD B,$3E
  LD B,C
  LD D,C
  LD HL,$7F5E
  ADD HL,BC
  ADD HL,DE
  ADD HL,HL
  LD B,(HL)
  LD H,$49
  LD C,C
  LD C,C
  LD ($0101),A
  LD A,A
  LD BC,$3F01
  LD B,B
  LD B,B
  LD B,B
  CCF
  RRCA
  JR NC,GET_DEVICE_600
  JR NC,GET_DEVICE_597
  LD A,A
GET_DEVICE_596:
  JR NZ,GET_DEVICE_598
  JR NZ,GET_DEVICE_607
  LD H,E
  INC D
  EX AF,AF'
  INC D
  LD H,E
  RLCA
  EX AF,AF'
  LD A,B
  EX AF,AF'
  RLCA
GET_DEVICE_597:
  LD H,C
  LD D,C
  LD C,C
  LD B,L
  LD B,E
  NOP
  LD A,A
  LD B,C
  LD B,C
  NOP
  INC B
  EX AF,AF'
GET_DEVICE_598:
  DJNZ GET_DEVICE_599
  LD B,B
  NOP
  LD B,C
  LD B,C
  LD A,A
  NOP
  INC B
  LD (BC),A
  LD BC,$0402
  ADD A,B
  ADD A,B
  ADD A,B
  ADD A,B
  ADD A,B
  NOP
  LD BC,$0402
  NOP
  JR NZ,GET_DEVICE_609
  LD D,H
  LD D,H
  LD A,B
  LD A,A
  JR Z,GET_DEVICE_605
  LD B,H
  JR C,GET_DEVICE_603
GET_DEVICE_599:
  LD B,H
GET_DEVICE_600:
  LD B,H
  LD B,H
  JR NZ,GET_DEVICE_604
  LD B,H
  LD B,H
  JR Z,$7A8F
  JR C,GET_DEVICE_612
  LD D,H
  LD D,H
  JR GET_DEVICE_601
  EX AF,AF'
  LD A,(HL)
  ADD HL,BC
  LD A,(BC)
  JR $79C0
  AND H
  SBC A,B
GET_DEVICE_601:
  LD A,H
  LD A,A
  INC B
GET_DEVICE_602:
  INC B
  INC B
  LD A,B
  NOP
  LD B,H
  LD A,L
  LD B,B
  NOP
  LD B,B
  ADD A,B
  ADD A,H
  LD A,L
  NOP
  NOP
  LD A,A
  DJNZ GET_DEVICE_610
  LD B,H
  NOP
  LD B,C
  LD A,A
  LD B,B
  NOP
  LD A,H
  INC B
  LD A,B
  INC B
  LD A,B
  LD A,H
  EX AF,AF'
GET_DEVICE_603:
  INC B
  INC B
  LD A,B
  JR C,GET_DEVICE_616
GET_DEVICE_604:
  LD B,H
  LD B,H
  JR C,GET_DEVICE_604
GET_DEVICE_605:
  JR GET_DEVICE_613
  INC H
  JR GET_DEVICE_611
GET_DEVICE_606:
  INC H
GET_DEVICE_607:
  INC H
  JR GET_DEVICE_606
; This entry point is used by the routine at SCPTLP.
GET_DEVICE_608:
  LD A,H
GET_DEVICE_609:
  EX AF,AF'
  INC B
  INC B
  EX AF,AF'
  LD E,B
  LD D,H
  LD D,H
  LD D,H
GET_DEVICE_610:
  INC H
  INC B
  CCF
  LD B,H
  LD B,H
  JR NZ,GET_DEVICE_617
  LD B,B
  LD B,B
  INC A
  LD B,B
GET_DEVICE_611:
  INC E
GET_DEVICE_612:
  JR NZ,GET_DEVICE_618
  JR NZ,GET_DEVICE_615
  INC A
  LD B,B
  JR C,GET_DEVICE_619
GET_DEVICE_613:
  INC A
  LD B,H
  JR Z,GET_DEVICE_614
  JR Z,$7AB8
  INC E
  AND B
  AND B
  SUB B
  LD A,H
  LD B,H
  LD H,H
  LD D,H
  LD C,H
  NOP
  NOP
  EX AF,AF'
  LD (HL),$41
GET_DEVICE_614:
  LD B,C
  NOP
  NOP
  LD A,A
GET_DEVICE_615:
  NOP
  NOP
GET_DEVICE_616:
  LD B,C
  LD B,C
  LD (HL),$08
  NOP
  LD (BC),A
  LD BC,$0402
  LD (BC),A
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  EX AF,AF'
  INC E
  LD A,$7F
  NOP
GET_DEVICE_617:
  JR NZ,GET_DEVICE_627
  RET M
  JR NZ,$7AE0
  NOP
  LD D,L
  XOR D
  LD D,L
  XOR D
  LD D,L
GET_DEVICE_618:
  XOR D
  NOP
  NOP
  LD B,H
  LD A,A
  LD B,L
GET_DEVICE_619:
  LD B,L
  JR NZ,GET_DEVICE_620
  AND A
  AND L
  PUSH HL
  JR GET_DEVICE_632
  INC H
  LD ($7924),HL
  DEC A
  LD B,D
  LD B,D
  LD B,D
  DEC A
  DEC A
  LD B,B
  LD B,B
  LD B,B
  DEC A
  JR NZ,GET_DEVICE_630
  LD D,H
  LD D,L
  LD A,B
GET_DEVICE_620:
  JR C,GET_DEVICE_628
  LD B,H
  LD B,L
  JR C,GET_DEVICE_626
  LD B,C
  LD B,B
  LD A,L
  LD B,B
  LD A,(HL)
  DEC H
  DEC H
  DEC H
  LD A,(DE)
GET_DEVICE_621:
  DEC E
  JP M,GET_DEVICE_622
  LD B,$20
GET_DEVICE_622:
  LD A,C
  CP ' '
  JP NC,GET_DEVICE_623
  ADD A,$80
  ADD A,B
  RET
GET_DEVICE_623:
  XOR A
  RET
GET_DEVICE_624:
  LD A,($FE61)
  RLCA
  JP NC,GET_DEVICE_625
  LD BC,$0009
  ADD HL,BC
  RLCA
  JP NC,GET_DEVICE_625
  ADD HL,BC
GET_DEVICE_625:
  LD A,(HL)
  SCF
  JP GET_DEVICE_522
  INC BC
  JR NZ,GET_DEVICE_633
  INC A
  DEC A
  LD E,E
  LD E,H
  LD E,L
  LD E,(HL)
  LD H,H
  JR NZ,GET_DEVICE_634
GET_DEVICE_626:
  INC A
  DEC A
  LD E,E
  LD E,H
GET_DEVICE_627:
  LD E,L
GET_DEVICE_628:
  LD E,(HL)
  INC BC
  LD H,L
  LD H,(HL)
  LD H,A
  LD L,B
  LD L,C
  LD L,D
  LD L,E
  LD L,H
GET_DEVICE_629:
  LD C,A
GET_DEVICE_630:
  CP $61
  RET C
  LD A,($FE61)
  AND $40
  LD A,C
  JP NZ,GET_DEVICE_631
  CP $7B
  RET NC
  AND $5F
  RET
GET_DEVICE_631:
  CP $7E
GET_DEVICE_632:
  RET NC
  AND $5F
  RET
  LD B,H
  JR NZ,GET_DEVICE_634
  RRCA
  EX AF,AF'
  RLCA
  LD B,L
  DEC H
  RRA
  LD A,(BC)
GET_DEVICE_633:
  LD C,D
  LD A,$09
  EX AF,AF'
  RLCA
  NOP
  LD B,A
  JR NZ,GET_DEVICE_636
GET_DEVICE_634:
  INC B
  LD B,L
  DEC A
  DEC B
  INC B
  NOP
  LD A,A
  INC B
  EX AF,AF'
  DJNZ GET_DEVICE_635
  LD B,D
  CCF
GET_DEVICE_635:
  LD (BC),A
  LD (BC),A
  LD B,B
  LD B,D
  LD B,D
  LD B,D
  LD B,B
  LD C,D
  LD HL,($2A12)
  LD B,(HL)
  LD (DE),A
  LD (DE),A
  LD A,E
  LD A,(BC)
  LD D,$40
GET_DEVICE_636:
  JR NZ,$7B77
  EX AF,AF'
  RLCA
  LD B,B
  INC A
  LD BC,$7C02
  CCF
  LD B,H
  LD B,H
  LD B,H
  LD B,H
  LD BC,$2141
  LD DE,$040F
  LD (BC),A
  LD BC,$3C02
  LD ($7F02),A
  LD (BC),A
  LD ($1202),A
  LD ($0E52),HL
  LD HL,$2525
  LD HL,$7840
  LD B,H
  LD B,D
  LD D,C
  LD H,B
  LD B,B
  JR Z,GET_DEVICE_638
  JR Z,GET_DEVICE_637
  INC B
  DEC B
  CCF
  LD B,L
  LD B,L
  LD (BC),A
  LD A,A
GET_DEVICE_637:
  LD (BC),A
  LD (DE),A
  LD C,$40
  LD B,D
  LD B,D
  LD A,(HL)
GET_DEVICE_638:
  LD B,B
  LD C,D
  LD C,D
  LD C,D
  LD C,D
  LD A,(HL)
  INC B
  DEC B
  LD B,L
  DEC H
  INC E
  NOP
  RRA
  LD B,B
  JR NZ,GET_DEVICE_640
  LD B,B
  LD A,$00
  LD A,A
  JR NZ,GET_DEVICE_639
GET_DEVICE_639:
  LD A,A
  LD B,B
  JR NZ,GET_DEVICE_641
  LD A,(HL)
  LD B,D
  LD B,D
  LD B,D
  LD A,(HL)
  RLCA
  LD BC,$2141
  RRA
  LD B,D
  LD B,D
  LD B,B
  JR NZ,GET_DEVICE_642
  LD BC,$0002
  LD BC,$0202
GET_DEVICE_640:
  DEC B
  DEC B
  LD (BC),A
GET_DEVICE_641:
  NOP
  NOP
  EX AF,AF'
  INC E
  LD A,$7F
  NOP
  JR NZ,GET_DEVICE_646
  RET M
  JR NZ,GET_DEVICE_643
  NOP
  LD D,L
  XOR D
GET_DEVICE_642:
  LD D,L
  XOR D
  LD D,L
  XOR D
  LD A,D
  LD A,B
  LD H,E
  HALT
  LD H,D
  LD L,(HL)
  LD L,L
  LD L,H
  LD H,C
  LD (HL),E
  LD H,H
  LD H,(HL)
  LD H,A
  LD L,B
  LD L,D
  LD L,E
  LD (HL),C
  LD (HL),A
  LD H,L
  LD (HL),D
  LD (HL),H
  LD A,C
  LD (HL),L
  LD L,C
  LD L,A
  LD (HL),B
  LD B,B
  LD E,H
  INC L
  LD L,$2F
  LD E,L
  LD SP,$3332
  INC (HL)
  DEC (HL)
  LD (HL),$37
  JR C,GET_DEVICE_645
  JR NC,GET_DEVICE_646
  LD A,($5B2D)
  LD E,(HL)
  LD A,H
  INC A
  LD A,$3F
  LD A,L
  LD HL,$2322
GET_DEVICE_643:
  INC H
  DEC H
  LD H,$27
  JR Z,GET_DEVICE_646
  LD E,A
  DEC HL
  LD HL,(GET_DEVICE_633)
  JR NZ,GET_DEVICE_644
  EX AF,AF'
  LD E,$1F
  DEC E
  INC E
  ADD HL,BC
  DEC DE
  DEC C
  RET P
  POP AF
  JP P,GET_DEVICE_714
  NOP
  NOP
  INC BC
  JR NZ,$7C39
GET_DEVICE_644:
  LD A,A
  INC D
  LD (BC),A
  LD BC,$0906
  DEC DE
  DEC C
  PUSH AF
  OR $F7
  RET M
GET_DEVICE_645:
  LD SP,HL
  NOP
  NOP
  INC BC
GET_DEVICE_646:
  LD A,C
  LD A,B
  LD H,E
  HALT
  LD H,D
  LD L,(HL)
  LD L,L
  LD L,H
  LD H,C
  LD (HL),E
  LD H,H
  LD H,(HL)
  LD H,A
  LD L,B
  LD L,D
  LD L,E
  LD (HL),C
  LD (HL),A
  LD H,L
  LD (HL),D
  LD (HL),H
  LD A,D
  LD (HL),L
  LD L,C
  LD L,A
  LD (HL),B
  LD A,L
  INC HL
  INC L
  LD L,$2D
  DEC HL
  LD SP,$3332
  INC (HL)
  DEC (HL)
  LD (HL),$37
  JR C,GET_DEVICE_648
  JR NC,$7CF6
  LD A,E
  LD A,(HL)
  INC A
  LD E,L
  LD E,(HL)
  DEC SP
  LD A,($2A27)
  LD HL,$4022
  INC H
  DEC H
  LD H,$2F
  JR Z,GET_DEVICE_649
  DEC A
  LD E,H
  LD E,E
  CCF
  LD A,$00
  NOP
  NOP
  
  
; Boot routine
;
; Used by the routine at $0000.
BOOT:
  DI
  LD SP,ALT_LCD
  LD HL,30000	; delay
BOOT_DELAY:
  DEC HL
  LD A,H
  OR L
  JP NZ,BOOT_DELAY
  IN A,($D8)
  AND A
  JP P,BOOT_DELAY
  LD A,$43
  OUT ($B8),A
  LD A,$EC
  OUT ($BA),A
  LD A,$FF
GET_DEVICE_648:
  OUT ($B9),A
  IN A,($E8)
GET_DEVICE_649:
  AND $03
  LD A,$ED
  OUT ($BA),A
  JP Z,BOOT_4
  LD HL,(MAXRAM)
  LD DE,$8A4D
  RST CPDEHL
  JP NZ,BOOT_4
  IN A,($A0)
  AND $0C
  JP NZ,GET_DEVICE_650
  LD A,($F3DB)
  AND A
  JP Z,GET_DEVICE_650
  LD DE,$7CDC
  JP GET_DEVICE_666
  JP Z,GET_DEVICE_650
  XOR A
  OUT ($A1),A
  LD ($F3DB),A
  
GET_DEVICE_650:
  LD A,($F9B1)
  LD D,A
  CALL TEST_FREEMEM
  CP D
  JP NZ,BOOT_4
  CALL GET_DEVICE_701
  LD A,$00
  JP NZ,BOOT_1
  DEC A
BOOT_1:
  LD HL,OPTROM
  CP (HL)
  JP NZ,BOOT_4
  LD HL,(ATIDSV)
  EX DE,HL
  LD HL,$0000
  LD (ATIDSV),HL
  LD HL,$9C0B	; POWER ON data marker
  RST CPDEHL
  JP NZ,BOOT_2
  LD HL,($F9AE)
  LD SP,HL
  CALL BOOT_VECT
  CALL L7D6F
  LD HL,($FEBD)
  PUSH HL
  LD HL,($F9BA)
  LD A,L
  AND A
  JP Z,GET_DEVICE_652
  LD A,H
  AND A
  JP Z,GET_DEVICE_654
GET_DEVICE_652:
  LD HL,$FEC3
  XOR A
  CP (HL)
  LD (HL),A
  JP NZ,GET_DEVICE_654
  LD A,($F3E4)
  AND A
  JP NZ,GET_DEVICE_655
  CALL ISFLIO_79
  POP HL
  LD A,H
  AND A
  JP Z,POPALL
  LD SP,HL
  JP SET_CLOCK_HL_15

BOOT_2:
  LD A,($F3FD)
  AND A
  JP Z,GET_DEVICE_654
  CALL $7D6F
  CALL STKINI
  CALL ISFLIO_79
  JP GET_DEVICE_214

GET_DEVICE_654:
  INC A
  LD ($F999),A
GET_DEVICE_655:
  LD HL,(STKTOP)
  LD SP,HL
  CALL BOOT_VECT
  CALL GET_DEVICE_680
  LD HL,__MENU
  PUSH HL
  OR $AF
  CALL GET_DEVICE_396
; Routine at 32111
;
; Used by the routine at L7426.
L7D6F:
  XOR A
  LD ($F401),A
  LD A,($FE43)
  CP $03
  RET NZ
  LD HL,$F406
  JP GETWORD_91
  
BOOT_4:
  LD SP,$F376
  CALL TEST_FREEMEM
  LD B,$E1
  LD DE,MAXRAM
  LD HL,SYSVARS_ROM
  CALL LDIR_B
  CALL INIT_HOOKS
  LD A,$0C
  LD (TIMCN2),A
  LD A,$64
  LD (TIMINT),A
  LD HL,FNKTAB
  CALL STFNK
  CALL GET_DEVICE_387
  LD B,$42
  LD DE,$6C8E
  LD HL,$F84F
  CALL REV_LDIR_B
  LD B,$E7
  CALL SCPTLP_96
  LD (HL),$FF
  CALL GET_DEVICE_701
  JP NZ,GET_DEVICE_657
  DEC A
  LD (OPTROM),A
  LD HL,$F891
  LD (HL),$F0
  INC HL
  INC HL
  INC HL
  LD DE,$F993
  LD B,$06
  CALL REV_LDIR_B
  LD (HL),' '
  INC HL
  LD (HL),B
GET_DEVICE_657:
  XOR A
  LD ($F6A3),A
  LD (NLONLY),A
  LD ($F841),A
  LD A,$3A
  LD (BUFFER),A
  LD HL,PRMSTK
  LD ($FB0C),HL
  LD (STKTOP),HL
  LD BC,$0100
  ADD HL,BC
  LD (MEMSIZ),HL
  LD A,$01
  LD ($FAE6),A
  CALL __MAX_0
  CALL CHKSTK_5
  LD HL,(RAM)
  XOR A
  LD (HL),A
  INC HL
  LD (BASTXT),HL
  LD (SUZUKI),HL
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (DO_FILES),HL
  LD (HAYASHI),HL
  LD (HL),$1A
  INC HL
  LD (CO_FILES),HL
  LD (PROGND),HL
  LD HL,$F870
  LD (DIRPNT),HL
  CALL CLRPTR
  CALL GET_DEVICE_395
  LD HL,$3833
  LD ($F83C),HL
  LD HL,$7EA1
  CALL $735A
  JP __MENU
  
PRINT_COPYRIGHT:
  LD HL,PROMPT_MSG
  CALL PRS
  CALL CONSOLE_CRLF
  RST $38
  LD E,B
  CALL FREEMEM
  LD HL,BYTES_MSG
  JP PRS

FREEMEM:
  LD HL,(PROGND)
  EX DE,HL
  LD HL,(STKTOP)
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD BC,$FFF2
  ADD HL,BC
  JP NUMPRT
  
INIT_HOOKS:
  LD HL,$F9CC
  LD BC,$2F02
  LD DE,$7FDB
GET_DEVICE_661:
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  DEC B
  JP NZ,GET_DEVICE_661
  LD B,$1B
  LD DE,FCERR
  DEC C
  JP NZ,GET_DEVICE_661
  RET
TEST_FREEMEM:
  LD HL,$C000
GET_DEVICE_663:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  LD A,H
  JP NZ,GET_DEVICE_664
  INC L
  JP NZ,GET_DEVICE_663
  SUB $20
  LD H,A
  JP M,GET_DEVICE_663
GET_DEVICE_664:
  LD L,$00
  ADD A,$20
  LD H,A
  LD (RAM),HL
  RET
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  LD BC,$0000
  LD BC,$DBF3
  AND B
GET_DEVICE_665:
  ADD A,$04
  AND $0C
  CP $04
  JP Z,GET_DEVICE_665
  LD DE,$7EBD
  JP GET_DEVICE_666
  JP NZ,$7EAB
  IN A,($A0)
  LD C,A
  XOR A
  OUT ($A1),A
  LD A,C
  LD ($F3DB),A
  OUT ($A1),A
  JP $0000
GET_DEVICE_666:
  OUT ($A1),A
  LD HL,$E000
GET_DEVICE_667:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  JP NZ,GET_DEVICE_668
  INC L
  JP NZ,GET_DEVICE_667
GET_DEVICE_668:
  EX DE,HL
  JP (HL)
; This entry point is used by the routine at GETWORD.
GET_DEVICE_669:
  JP NC,SNERR
  LD B,$00
  AND $0F
  LD D,A
  OR $37
  IN A,($A0)
  LD C,A
  LD A,B
  OUT ($A1),A
  JP C,GET_DEVICE_670
  LD (HL),D
GET_DEVICE_670:
  LD D,(HL)
  LD A,C
  OUT ($A1),A
  RET
__MAX:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  CALL GET_DEVICE_695
  CALL GETINT
  JP NZ,SNERR
  CP $10
  JP NC,FCERR
  LD (TEMP),HL
  PUSH AF
  CALL CLSALL		; Close all files
  POP AF
  CALL __MAX_0
  CALL _CLREG
  JP EXEC_EVAL
  
; This entry point is used by the routine at CHKSTK.
__MAX_0:
  PUSH AF
  LD HL,(HIMEM)
  LD DE,$FEF5
__MAX_1:
  ADD HL,DE
  DEC A
  JP P,__MAX_1
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
  LD BC,$008C
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,(PROGND)
  ADD HL,BC
  RST CPDEHL
  JP NC,OMERR
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
__MAX_2:
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  LD (HL),$00
  ADD HL,BC
  EX DE,HL
  DEC A
  JP P,__MAX_2
  POP HL
  LD BC,$0009
  ADD HL,BC
  LD ($FB67),HL
  RET
  

; Message at 32649
BYTES_MSG:
  DEFM " Bytes free"
  DEFB $00

; Message at 32661
PROMPT_MSG:
  DEFM "NEC PC-8201 BASIC Ver 1.0 (C) Microsoft "
  DEFB $00
  
; This entry point is used by the routine at GETYPR.
GET_DEVICE_674:
  EX (SP),HL
  PUSH AF
  LD A,(HL)
  LD ($F9BC),A
  POP AF
  INC HL
  EX (SP),HL
  PUSH HL
  PUSH BC
  PUSH AF
  LD HL,$F9CC
GET_DEVICE_675:
  LD A,($F9BC)
GET_DEVICE_676:
  LD C,A
GET_DEVICE_677:
  LD B,$00
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
GET_DEVICE_678:
  POP AF
  POP BC
  EX (SP),HL
  RET
; This entry point is used by the routine at ISFLIO.
GET_DEVICE_679:
  LD A,($F3EA)
  AND A
  RET Z
  JP ISFLIO_131
GET_DEVICE_680:
  XOR A
  LD (LPT_POS),A
  JP CHKSTK_5
GET_DEVICE_681:
  LD B,$00
GET_DEVICE_682:
  IN A,($BB)
  AND $04
  RET Z
  DEC B
  JP NZ,GET_DEVICE_682
  DEC C
GET_DEVICE_683:
  JP NZ,GET_DEVICE_681
  RET
  EX DE,HL
  LD A,A
  JP GET_DEVICE_399
  NOP
GET_DEVICE_684:
  NOP
  NOP
  NOP
