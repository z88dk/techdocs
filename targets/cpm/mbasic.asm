  ORG $0100

; BASIC-80 Rev. 5.22
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
  DEFW $0000
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
  DEFW $0000
  DEFW $0000
  DEFW __WHILE
  DEFW __WEND
  DEFW __CALL
  DEFW __WRITE
  DEFW __DATA
  DEFW __CHAIN
  DEFW __OPTION
  DEFW __RANDOMIZE
  DEFW $0000
  DEFW __SYSTEM
  DEFW $0000
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

; BASIC keyword list
WORDS:
  DEFB $04
WORDS_A:
  DEFM "UT"
  DEFB $CF
  DEFB $AB
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
  DEFB $15
  DEFB $00
WORDS_B:
  DEFB $00
WORDS_C:
  DEFM "LOS"
  DEFB $C5
  DEFB $C3
  DEFM "ON"
  DEFB $D4
  DEFB $9A
  DEFM "LEA"
  DEFB $D2
  DEFB $92
  DEFM "IN"
  DEFB $D4
  DEFB $1C
  DEFM "SN"
  DEFB $C7
  DEFB $1D
  DEFM "DB"
  DEFB $CC
  DEFB $1E
  DEFM "V"
  DEFB $C9
  DEFM "+V"
  DEFB $D3
  DEFM ",V"
  DEFB $C4
  DEFM "-O"
  DEFB $D3
  DEFB $0C
  DEFM "HR"
  DEFB $A4
  DEFB $16
  DEFM "AL"
  DEFB $CC
  DEFB $B6
  DEFM "OMMO"
  DEFB $CE
  DEFB $B8
  DEFM "HAI"
  DEFB $CE
  DEFB $B9
  DEFB $00
WORDS_D:
  DEFM "ELET"
  DEFB $C5
  DEFB $AA
  DEFM "AT"
  DEFB $C1
  DEFB $84
  DEFM "I"
  DEFB $CD
  DEFB $86
  DEFM "EFST"
  DEFB $D2
  DEFB $AD
  DEFM "EFIN"
  DEFB $D4
  DEFB $AE
  DEFM "EFSN"
  DEFB $C7
  DEFB $AF
  DEFM "EFDB"
  DEFB $CC
  DEFB $B0
  DEFM "E"
  DEFB $C6
  DEFB $98
  DEFB $00
WORDS_E:
  DEFM "LS"
  DEFB $C5
  DEFB $A2
  DEFM "N"
  DEFB $C4
  DEFB $81
  DEFM "RAS"
  DEFB $C5
  DEFB $A6
  DEFM "DI"
  DEFB $D4
  DEFB $A7
  DEFM "RRO"
  DEFB $D2
  DEFB $A8
  DEFM "R"
  DEFB $CC
  DEFB $D6
  DEFM "R"
  DEFB $D2
  DEFB $D7
  DEFM "X"
  DEFB $D0
  DEFB $0B
  DEFM "O"
  DEFB $C6
  DEFM "/Q"
  DEFB $D6
  DEFB $FA
  DEFB $00
WORDS_F:
  DEFM "O"
  DEFB $D2
  DEFB $82
  DEFM "IEL"
  DEFB $C4
  DEFB $C0
  DEFM "ILE"
  DEFB $D3
  DEFB $C6
  DEFB $CE
  DEFB $D3
  DEFM "R"
  DEFB $C5
  DEFB $0F
  DEFM "I"
  DEFB $D8
  DEFB $1F
  DEFB $00
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
  DEFB $C1
  DEFB $00
WORDS_H:
  DEFM "EX"
  DEFB $A4
  DEFB $1A
  DEFB $00
WORDS_I:
  DEFM "NPU"
  DEFB $D4
  DEFB $85
  DEFB $C6
  DEFB $8B
  DEFM "NST"
  DEFB $D2
  DEFB $DA
  DEFM "N"
  DEFB $D4
  DEFB $05
  DEFM "N"
  DEFB $D0
  DEFB $10
  DEFM "M"
  DEFB $D0
  DEFB $FB
  DEFM "NKEY"
  DEFB $A4
  DEFB $DD
  DEFB $00
WORDS_J:
  DEFB $00
WORDS_K:
  DEFM "IL"
  DEFB $CC
  DEFB $C8
  DEFB $00
WORDS_L:
  DEFM "PRIN"
  DEFB $D4
  DEFB $9E
  DEFM "LIS"
  DEFB $D4
  DEFB $9F
  DEFM "PO"
  DEFB $D3
  DEFB $1B
  DEFM "E"
  DEFB $D4
  DEFB $88
  DEFM "IN"
  DEFB $C5
  DEFB $B1
  DEFM "OA"
  DEFB $C4
  DEFB $C4
  DEFM "SE"
  DEFB $D4
  DEFB $C9
  DEFM "IS"
  DEFB $D4
  DEFB $93
  DEFM "O"
  DEFB $C7
  DEFB $0A
  DEFM "O"
  DEFB $C3
  DEFM "0E"
  DEFB $CE
  DEFB $12
  DEFM "EFT"
  DEFB $A4
  DEFB $01
  DEFM "O"
  DEFB $C6
  DEFM "1"
  DEFB $00
WORDS_M:
  DEFM "ERG"
  DEFB $C5
  DEFB $C5
  DEFM "O"
  DEFB $C4
  DEFB $FC
  DEFM "KI"
  DEFB $A4
  DEFM "2KS"
  DEFB $A4
  DEFM "3KD"
  DEFB $A4
  DEFM "4ID"
  DEFB $A4
  DEFB $03
  DEFB $00
WORDS_N:
  DEFM "EX"
  DEFB $D4
  DEFB $83
  DEFM "UL"
  DEFB $CC
  DEFB $96
  DEFM "AM"
  DEFB $C5
  DEFB $C7
  DEFM "E"
  DEFB $D7
  DEFB $94
  DEFM "O"
  DEFB $D4
  DEFB $D5
  DEFB $00
WORDS_O:
  DEFM "PE"
  DEFB $CE
  DEFB $BF
  DEFM "U"
  DEFB $D4
  DEFB $9D
  DEFB $CE
  DEFB $95
  DEFB $D2
  DEFB $F8
  DEFM "CT"
  DEFB $A4
  DEFB $19
  DEFM "PTIO"
  DEFB $CE
  DEFB $BA
  DEFB $00
WORDS_P:
  DEFM "RIN"
  DEFB $D4
  DEFB $91
  DEFM "U"
  DEFB $D4
  DEFB $C2
  DEFM "OK"
  DEFB $C5
  DEFB $99
  DEFM "O"
  DEFB $D3
  DEFB $11
  DEFM "EE"
  DEFB $CB
  DEFB $17
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
  DEFB $8A
  DEFM "ESTOR"
  DEFB $C5
  DEFB $8C
  DEFM "E"
  DEFB $CD
  DEFB $8F
  DEFM "ESUM"
  DEFB $C5
  DEFB $A9
  DEFM "SE"
  DEFB $D4
  DEFB $CA
  DEFM "IGHT"
  DEFB $A4
  DEFB $02
  DEFM "N"
  DEFB $C4
  DEFB $08
  DEFM "ENU"
  DEFB $CD
  DEFB $AC
  DEFM "ESE"
  DEFB $D4
  DEFB $CC
  DEFM "ANDOMIZ"
  DEFB $C5
  DEFB $BB
  DEFB $00
WORDS_S:
  DEFM "TO"
  DEFB $D0
  DEFB $90
  DEFM "WA"
  DEFB $D0
  DEFB $A5
  DEFM "AV"
  DEFB $C5
  DEFB $CB
  DEFM "PC"
  DEFB $A8
  DEFB $D4
  DEFM "TE"
  DEFB $D0
  DEFB $D1
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
  DEFB $D8
  DEFM "PACE"
  DEFB $A4
  DEFB $18
  DEFM "YSTE"
  DEFB $CD
  DEFB $BD
  DEFB $00
WORDS_T:
  DEFM "HE"
  DEFB $CE
  DEFB $CF
  DEFM "RO"
  DEFB $CE
  DEFB $A3
  DEFM "ROF"
  DEFB $C6
  DEFB $A4
  DEFM "AB"
  DEFB $A8
  DEFB $D0
  DEFB $CF
  DEFB $CE
  DEFM "A"
  DEFB $CE
  DEFB $0D
  DEFB $00
WORDS_U:
  DEFM "SIN"
  DEFB $C7
  DEFB $D9
  DEFM "S"
  DEFB $D2
  DEFB $D2
  DEFB $00
WORDS_V:
  DEFM "A"
  DEFB $CC
  DEFB $14
  DEFM "ARPT"
  DEFB $D2
  DEFB $DC
  DEFB $00
WORDS_W:
  DEFM "IDT"
  DEFB $C8
  DEFB $A1
  DEFM "AI"
  DEFB $D4
  DEFB $97
  DEFM "HIL"
  DEFB $C5
  DEFB $B4
  DEFM "EN"
  DEFB $C4
  DEFB $B5
  DEFM "RIT"
  DEFB $C5
  DEFB $B7
  DEFB $00
WORDS_X:
  DEFM "O"
  DEFB $D2
  DEFB $F9
  DEFB $00
WORDS_Y:
  DEFB $00
WORDS_Z:
  DEFB $00
OPR_TOKENS:
  DEFB $AB,$F2,$AD,$F3,$AA,$F4,$AF,$F5
  DEFB $DE,$F6,$DC,$FD,$A7,$DB,$BE,$EF
  DEFB $BD,$F0,$BC,$F1,$00

; Arithmetic precedence table
PRITAB:
  DEFB $79,$79,$7C,$7C,$7F,$50,$46,$3C
  DEFB $32,$28,$7A,$7B

; NUMBER TYPES
TYPE_OPR:
  DEFW __CDBL
  DEFW $0000
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
  DEFB $84
LINLEN:
  DEFB $50                ; Current column-position of the cursor
CLMLST:
  DEFB $38,$00            ; Column space. It’s uncertain what this address
                          ; actually stores
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
  DEFW OVERFLOW_MSG       ; Text PTR to current error message in math
  DEFW $0000              ; operations
  DEFW $0000
FILTAB:
  DEFW $0000              ; Pointer table for files/channels
HIMEM:
  DEFW $0000              ; ^
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
MAXFIL:
  DEFB $00                ; Maximum number of files
TYPE:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Used by BASIC to deal with variable
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; types
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00
FCB:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Byte 0, drive no.
  DEFB $00,$00,$00,$00,$00,$00,$00
FCB_FILE:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; File related infos copied from the
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; directory entry
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00
BDOSVER:
  DEFB $00                ; Current CP/M BDOS version number
RD_FN:
  DEFB $00                ; BDOS function code for 'READ' call
WR_FN:
  DEFB $00                ; BDOS function code for 'WRITE' call
BUFFER:
  DEFM ":"                ; Start of input buffer
KBUF:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Input buffer +1
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
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
BUFMIN:
  DEFB $2C
BUF:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Buffer to store characters typed( in
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; ASCII code)
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00
ENDBUF:
  DEFB $00,$00
TTYPOS:
  DEFB $00
DIMFLG:
  DEFB $00
VALTYP:
  DEFW $0000              ; (word) type indicator
DORES:
  DEFB $00                ; a.k.a. OPRTYP, indicates whether stored word can be
                          ; crunched, etc..
DONUM:
  DEFB $00                ; indicates whether we have a number
CONTXT:
  DEFW $0000              ; Text address used by CNRGET
CONSAV:
  DEFB $00                ; Store token of constant after calling CHRGET
CONTYP:
  DEFB $00
CONLO:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
MEMSIZ:
  DEFW $0000              ; Highest location in memory used by BASIC
TEMPPT:
  DEFW $0000              ; (word), start of free area of temporary descriptor
TEMPST:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; (word), temporary descriptors
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; VARIABLES: Storage area for BASIC variables
;
; String descriptor which is the result of string fun
DSCTMP:
  NOP
TMPSTR:
  NOP
  NOP
FRETOP:
  DEFW $0000              ; Starting address of unused area of string area
TEMP3:
  DEFW $0000              ; (word) used for garbage collection or by USR
                          ; function, a.k.a. CUROPR
TEMP8:
  DEFW $0000              ; Used for garbage collection
ENDFOR:
  NOP
  NOP
DATLIN:
  NOP
  NOP
SUBFLG:
  NOP
FLGINP:
  NOP
TEMP:
  DEFW $0000              ; (word) temp. reservation for st.code
PTRFLG:
  NOP
AUTFLG:
  NOP
AUTLIN:
  NOP
  NOP
AUTINC:
  NOP
  NOP
SAVTXT:
  NOP
  NOP
SAVSTK:
  NOP
  NOP
ERRLIN:
  NOP
  NOP
DOT:
  DEFW $0000              ; Current line for edit & list
ERRTXT:
  NOP
  NOP
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
  DEFW $0000              ; ; BASIC program end ptr (a.k.a. PROGND, Simple
                          ; Variables)
ARYTAB:
  DEFW $0000              ; End of variables (aka VAREND), begin of array
                          ; aariables
STREND:
  DEFW $0000              ; End of arrays (a.k.a. ARREND lowest free mem)
DATPTR:
  DEFW $0000              ; Pointer used by READ to get DATA stored in BASIC
                          ; PGM
DEFTBL:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Default valtype for each letter
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00
PRMSTK:
  DEFW $0000              ; (word), previous block definition on stack
PRMLEN:
  DEFW $0000              ; (word), number of bytes of obj table
PARM1:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Objective prameter definition table
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
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
PRMPRV:
  DEFW $0000              ; Pointer to previous parameter block
PRMLN2:
  DEFW $0000              ; (word), size of parameter block
PARM2:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; For parameter storage
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
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
PRMFLG:
  NOP
ARYTA2:
  DEFW $0000              ; End point of search
NOFUNS:
  DEFB $00                ; (byte), 0 if no function active
TEMP9:
  DEFW $0000              ; Location of temporary storage for garbage
                          ; collection
FUNACT:
  DEFW $0000              ; (word), active functions counter
  DEFW $0000
NEXTMP:
  DEFW $0000              ; Used by NEXT to save code ptr
NEXFLG:
  DEFW $0000              ; Flag used by NEXT
  DEFW $0000
  DEFW $0000
LOPLIN:
  DEFW $0000              ; (word), temp line no. storage used in FOR, WHILE,
                          ; etc..
OPTBASE:
  DEFB $00                ; Array size set with "OPTION BASE", (for 10=default
                          ; size, value is '0': 10+1 XOR 11)
OPTBASE_FLG:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Array status flag to deal with "OPTION
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; BASE"
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
INTFLG:
  DEFB $00                ; This flag is set if STOP (=4) or CTRL + STOP (=3)
                          ; is pressed
IMPFLG:
  DEFB $00,$00,$00,$00,$00 ; This flag is related to the INPUT status
FILFLG:
  NOP
NLONLY:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
ERRTRP:
  DEFB $00,$00,$00        ; Value of first  variable in SWAP st.
SWPTMP:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Value of first  variable in SWAP st.
TRCFLG:
  DEFB $00,$00,$00,$00,$00,$00 ; 'TRACE' status flag (0 MEANS NO TRACE)
FACLOW:
  NOP
  NOP
FACCU:
  NOP
FPEXP:
  DEFB $00                ; Floating Point Exponent
SGNRES:
  NOP
RESFLG:
  NOP
RESFLG_OLD:
  NOP
  NOP
  NOP
FPARG:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
DBL_LAST_FPREG:
  NOP
ARG:
  NOP
FBUFFR:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; Buffer for fout + 1
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00

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
  CP $B4                  ; Is it a "FOR" token
  JP NZ,LOKFOR_0          ; No - exit
  LD BC,$0006
  ADD HL,BC               ; BC = Address of "FOR" index
  JP LOKFOR
LOKFOR_0:
  CP $82
  RET NZ
  LD C,(HL)
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
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Disk I/O error' error entry
;
; Used by the routine at __EOF.
DISK_ERR:
  LD E,$39
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Bad file mode' error entry
;
; Used by the routines at __EOF, __OPEN, GET_CHNUM, __MERGE, __FIELD, __LSET
; and __GET.
FMODE_ERR:
  LD E,$36
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'File not found' error entry
;
; Used by the routines at __NAME, __OPEN, __KILL and __FILES.
FF_ERR:
  LD E,$35
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Bad file number' error entry
;
; Used by the routines at __EOF, __LOC, __LOF, __OPEN, GET_CHNUM and __FIELD.
BN_ERR:
  LD E,$34
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Internal error' error entry
IE_ERR:
  LD E,$33
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Input past END' (EOF) error entry
;
; Used by the routines at LINE_INPUT and __LSET.
EF_ERR:
  LD E,$3E
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'File already open' error entry
;
; Used by the routine at __OPEN.
AO_ERR:
  LD E,$37
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Bad file name' error entry
;
; Used by the routine at FNAME.
NM_ERR:
  LD E,$40
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Bad record number' error entry
;
; Used by the routine at __GET.
RECNO_ERR:
  LD E,$3F
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'FIELD overflow' error entry
;
; Used by the routines at __FIELD and __GET.
FIELD_OV_ERR:
  LD E,$32
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Too many files' error entry
;
; Used by the routines at __EOF, __LOF, __OPEN and FILE_R_W.
FL_ERR:
  LD E,$43
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

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
; INPUT_SUB, EVAL3, HEXTFP, __DEF, MAKINT, __WAIT, __RENUM, __OPTION, __LOAD,
; __MERGE, __WEND, __CHAIN, __GET, GETVAR, SBSCPT, L5256, SYNCHR, __CLEAR and
; BASIC_ENTRY.
SN_ERR:
  LD E,$02
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Division by zero' error entry
;
; Used by the routines at L2BA0 and DECDIV_SUB.
O_ERR:
  LD E,$0B
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'NEXT without FOR' error entry
;
; Used by the routine at __NEXT.
NF_ERR:
  LD E,$01
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Redimensioned array' error entry (re-dim not allowed)
;
; Used by the routines at __OPTION and SBSCPT.
DD_ERR:
  LD E,$0A
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Undefined user function' error entry
;
; Used by the routine at __DEF.
UFN_ERR:
  LD E,$12
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'RESUME without error' error entry
;
; Used by the routine at __RESUME.
RW_ERR:
  LD E,$14
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Overflow' error entry
;
; Used by the routines at HEXTFP, __CINT, DECDIV_SUB and __NEXT.
OV_ERR:
  LD E,$06
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Operand Error' error entry
;
; Used by the routine at OPRND.
OPERAND_ERR:
  LD E,$16
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'Type mismatch' error entry
;
; Used by the routines at FORFND, EVAL3, EVAL1, INVSGN, _TSTSGN, __CINT,
; __CSNG, __CDBL, TSTSTR, __INT and __TROFF.
TM_ERR:
  LD E,$0D
; This entry point is used by the routines at WARM_BT_0, FILE_EXISTS_ERR,
; DETOKEN_MORE, FC_ERR, UL_ERR, __RETURN, __ERROR, FDTLP, MAKINT, LOOK_FOR,
; __MERGE, __WEND, BS_ERR, CHKSTK, __CONT, TSTOPL_0, TESTR and CONCAT.
ERROR:
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  XOR A
  LD (NLONLY),A
  LD (ERRTRP),A
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
  JP WARM_ENTRY           ; }

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
  JP C,ERROR_REPORT_0

; if error code is bigger than $3B then force it to $28-$13=$15 -> "Unprintable
; error"
;
; Used by the routines at ERROR_REPORT and _ERROR_REPORT.
UNKNOWN_ERR:
  LD A,$28

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
  LD DE,$FFFE
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

; --- START PROC READY ---
;
; Used by the routines at PROMPT, __LIST, __LOAD, EDIT_DONE and __FRE.
READY:
  CALL STOP_LPT
  XOR A
  LD (CTLOFG),A
  CALL __LOAD_4
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
  CALL Z,L52F3_2

; Routine at 3490
;
; Used by the routines at __AUTO, __LOAD and __MERGE.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL
  LD A,(AUTFLG)
  OR A
  JP Z,PROMPT_4
  LD HL,(AUTLIN)
  PUSH HL
  CALL _PRNUM
  POP DE
  PUSH DE
  CALL SRCHLP
  LD A,$2A
  JP C,PROMPT_0
  LD A,$20
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
  LD DE,$FFF9
  CALL DCOMPR
  POP DE
  JP NC,PROMPT_1
  LD (AUTLIN),HL
PROMPT_3:
  LD A,(BUF)
  OR A
  JP Z,PROMPT
  JP EDIT_DONE_1
PROMPT_4:
  CALL PINLIN
  JP C,PROMPT
  CALL _CHRGTB
  INC A
  DEC A
  JP Z,PROMPT
  PUSH AF
  CALL ATOH
  CALL L1164_4
  LD A,(HL)
  CP $20
  CALL Z,INCHL
; This entry point is used by the routine at EDIT_DONE.
PROMPT_5:
  PUSH DE
  CALL TOKENIZE
  POP DE
  POP AF
  LD (SAVTXT),HL
  JP NC,__MERGE_2
  PUSH DE
  PUSH BC
  CALL __GET_37
  CALL _CHRGTB
  OR A
  PUSH AF
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL SRCHLP
  JP C,PROMPT_6
  POP AF
  PUSH AF
  JP Z,UL_ERR
  OR A
PROMPT_6:
  PUSH BC
  PUSH AF
  PUSH HL
  CALL LINE2PTR_7
  POP HL
  POP AF
  POP BC
  PUSH BC
  CALL C,__DELETE_0
  POP DE
  POP AF
  PUSH DE
  JP Z,PROMPT_9
  POP DE
  LD A,(ERRTRP)
  OR A
  JP NZ,PROMPT_7
  LD HL,(MEMSIZ)
  LD (FRETOP),HL
PROMPT_7:
  LD HL,(VARTAB)
  EX (SP),HL
  POP BC
  PUSH HL
  ADD HL,BC
  PUSH HL
  CALL EDIT_DONE_3
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
PROMPT_8:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
  LD A,C
  OR B
  JP NZ,PROMPT_8
PROMPT_9:
  POP DE
  CALL UPD_PTRS_0
  LD HL,$0080
  LD (HL),$00
  LD (HIMEM),HL
  LD HL,(PTRFIL)
  LD (NXTOPR),HL
  CALL RUN_FST
  LD HL,(FILTAB)
  LD (HIMEM),HL
  LD HL,(NXTOPR)
  LD (PTRFIL),HL
  JP PROMPT

; Update interpreter pointers
;
; Used by the routines at __LOAD and L45C9.
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
  CP $20
  JP NC,UPD_PTRS_1
  CP $0B
  JP C,UPD_PTRS_1
  CALL _CHRGTB_0
  CALL _CHRGTB
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
  DEFB $F3
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
; Used by the routines at PROMPT, __GO_TO, __DELETE, __RENUM, LINE2PTR,
; __CHAIN, L45C9, __EDIT and SYNCHR.
SRCHLP:
  LD HL,(TXTTAB)

; Routine at 3835
;
; Used by the routine at __GO_TO.
SRCHLN:
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
  CALL DCOMPR
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
  JP SRCHLN

; Routine at 3864
;
; Used by the routine at PROMPT.
TOKENIZE:
  XOR A
  LD (DONUM),A
  LD (DORES),A
  LD BC,$013B             ; BUF-BUFFER-5 = 315 bytes
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
  LD HL,$0140             ; BUF-BUFFER = 320 bytes
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
  CP $22                  ; Is it a quote?
  JP Z,CPYLIT             ; Yes - Copy literal string
  CP $20                  ; Is it a space?
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
  POP AF                  ; }
  SUB $3A                 ; ":", End of statement?
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
  JP CRNCLP_0             ; }
CRNCLP_2:
  CP $3F                  ; Is it "?" short for PRINT
  LD A,$91                ; TK_PRINT: "PRINT" token
  PUSH DE
  PUSH BC
  JP Z,MOVDIR             ; Yes - replace it
  LD DE,OPR_TOKENS
  CALL UCASE_HL
  CALL IS_ALPHA_A
  JP C,DETOKEN_MORE
  PUSH HL
  LD DE,FNC_GO
  CALL TK_TXT_COMPARE
  JP NZ,CRNCH_MORE
  CALL _CHRGTB
  LD DE,FNC_TO
  CALL TK_TXT_COMPARE
  LD A,$89
  JP Z,CRNCLP_3
  LD DE,FNC_SUB
  CALL TK_TXT_COMPARE
  JP NZ,CRNCH_MORE
  LD A,$8D
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
  SUB $41
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
  AND $7F                 ; Strip bit 7
  JP Z,L1164              ; JP if end of list
  INC HL
  CP C                    ; Same character as in buffer?
  JP NZ,GETNXT            ; No - get next word
  LD A,(DE)
  INC DE
  OR A
  JP P,COMPR_WD
  LD A,C
  CP $28
  JP Z,CRNCH_MORE_1
  LD A,(DE)
  CP $D3
  JP Z,CRNCH_MORE_1
  CP $D2
  JP Z,CRNCH_MORE_1
  CALL UCASE_HL
  CP $2E
  JP Z,CRNCH_MORE_0
  CALL __LIST_26
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
  LD DE,LNUM_TOKENS
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
LNUM_TOKENS:
  DEFB $8C,$AB,$AC,$AA,$A7,$A9,$D6,$A2
  DEFB $8A,$93,$9F,$89,$CF,$8D,$00

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
  CP $A2
  PUSH AF
  CALL Z,TOKENIZE_COLON
  POP AF
  CP $B4
  JP NZ,TOKEN_BUILT_1
  CALL TOKENIZE_ADD
  LD A,$F2
TOKEN_BUILT_1:
  CP $DB
  JP NZ,DETOKEN_MORE_10
  PUSH AF
  CALL TOKENIZE_COLON
  LD A,$8F
  CALL TOKENIZE_ADD
  POP AF
  PUSH AF
  JP CRNCLP_1             ; }

; Routine at 4247
;
; Used by the routine at CRNCLP.
DETOKEN_MORE:
  LD A,(HL)
  CP $2E
  JP Z,DETOKEN_MORE_0
  CP $3A
  JP NC,DETOKEN_MORE_8
  CP $30
  JP C,DETOKEN_MORE_8
DETOKEN_MORE_0:
  LD A,(DONUM)
  OR A
  LD A,(HL)
  POP BC
  POP DE
  JP M,_MOVDIR
  JP Z,DETOKEN_MORE_4
  CP $2E
  JP Z,_MOVDIR
  LD A,$0E
  CALL TOKENIZE_ADD
  PUSH DE
  CALL ATOH
  CALL L1164_4
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
  CALL L1164_4
  POP BC
  POP DE
  PUSH HL
  LD A,(VALTYP)
  CP $02
  JP NZ,DETOKEN_MORE_5
  LD HL,(FACLOW)
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
  LD HL,FACLOW
  CALL GETYPR
  JP C,DETOKEN_MORE_6
  LD HL,$0C00
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
  JP Z,SKIP_BLANKS
  INC DE
  CP (HL)
  LD A,(DE)
  JP NZ,DETOKEN_MORE_9
  JP L1164_2
; This entry point is used by the routine at TOKEN_BUILT.
DETOKEN_MORE_10:
  CP $26
  JP NZ,_MOVDIR
  PUSH HL
  CALL _CHRGTB
  POP HL
  CALL UCASE
  CP $48
  LD A,$0B
  JP NZ,DETOKEN_MORE_11
  LD A,$0C
DETOKEN_MORE_11:
  CALL TOKENIZE_ADD
  PUSH DE
  PUSH BC
  CALL HEXTFP
  POP BC
  JP DETOKEN_MORE_1
; This entry point is used by the routine at TOKEN_BUILT.
TOKENIZE_COLON:
  LD A,$3A                ; 04439: TOKENIZE_COLON
; This entry point is used by the routines at CRNCLP, CRNCH_MORE, TOKEN_BUILT
; and L1164.
TOKENIZE_ADD:
  LD (DE),A               ; 04441: TOKENIZE_ADD
  INC DE
  DEC BC
  LD A,C
  OR B
  RET NZ
; This entry point is used by the routine at PINLIN.
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
  JP NC,L1164_0
  CP $3A
  JP NC,L1164_1
  CP $30
  JP NC,L1164_0
  CP $2E
  JP Z,L1164_0
L1164_1:
  JP NXTCHR
; This entry point is used by the routine at DETOKEN_MORE.
SKIP_BLANKS:
  LD A,(HL)               ; Skip blanks
  CP $20
  JP NC,L1164_2
  CP $09
  JP Z,L1164_2
  CP $0A
  JP Z,L1164_2
  LD A,$20
; This entry point is used by the routine at DETOKEN_MORE.
L1164_2:
  PUSH AF
  LD A,(DONUM)
  INC A
  JP Z,L1164_3
  DEC A
L1164_3:
  JP TOKEN_BUILT_0
; This entry point is used by the routines at PROMPT and DETOKEN_MORE.
L1164_4:
  DEC HL
  LD A,(HL)
  CP $20
  JP Z,L1164_4
  CP $09
  JP Z,L1164_4
  CP $0A
  JP Z,L1164_4
  INC HL
  RET                     ; }

; 'FOR' BASIC command
__FOR:
  LD A,$64                ; Flag "FOR" assignment
  LD (SUBFLG),A           ; Save "FOR" flag
  CALL GETVAR
  CALL SYNCHR
  DEFB $F0
  PUSH DE
  EX DE,HL
  LD (TEMP),HL
  EX DE,HL
  LD A,(VALTYP)
  PUSH AF
  CALL EVAL
  POP AF
  PUSH HL
  CALL MAKINT_1
  LD HL,$0BC0
  CALL DEC_FACCU2HL
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
  ADC A,$CD               ; TK_TO: "TO" token
  LD A,E
  DEC E
  JP Z,TM_ERR
  JP NC,TM_ERR
  PUSH AF
  CALL EVAL
  POP AF
  PUSH HL
  JP P,FORFND_0
  CALL __CINT
  EX (SP),HL
  LD DE,$0001             ; Default value for STEP
  LD A,(HL)               ; Get next byte in code string
  CP $D1                  ; See if "STEP" is stated
  CALL Z,FPSINT           ; If so, get updated value for 'STEP'
  PUSH DE
  PUSH HL                 ; Save code string address
  EX DE,HL
  CALL _TSTSGN_0          ; Test sign for 'STEP'
  JP FORFND_1
FORFND_0:
  CALL __CSNG
  CALL BCDEFP             ; Move "TO" value to BCDE
  POP HL                  ; Restore code string address
  PUSH BC                 ; Save "TO" value in block
  PUSH DE
  LD BC,$8100             ; BCDE - 1 (default STEP)
  LD D,C                  ; C=0
  LD E,D                  ; D=0
  LD A,(HL)               ; Get next byte in code string
  CP $D1                  ; See if "STEP" is stated
  LD A,$01                ; Sign of step = 1
  JP NZ,SAVSTP            ; No STEP given - Default to 1
  CALL EVAL_0             ; Jump over "STEP" token
  PUSH HL                 ; Get step value
  CALL __CSNG             ; Save code string address
  CALL BCDEFP             ; Move STEP to BCDE
  CALL SIGN               ; Test sign of FPREG
FORFND_1:
  POP HL                  ; Restore code string address

; Save the STEP value in block
;
; Used by the routine at FORFND.
SAVSTP:
  PUSH BC
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
  CALL _CHRGTB
  JP NZ,SN_ERR
  CALL LOOK_FOR_NEXT
  CALL _CHRGTB
  PUSH HL
  PUSH HL
  LD HL,(LOPLIN)
  LD (CURLIN),HL
  LD HL,(TEMP)
  EX (SP),HL
  LD B,$82                ; "FOR" block marker
  PUSH BC                 ; Save it
  INC SP                  ; Don't save C
  PUSH AF
  PUSH AF
  JP __NEXT_0

; "FOR" block marker
;
; Used by the routine at __NEXT.
PUTFID:
  LD B,$82
  PUSH BC
  INC SP

; BASIC program execution driver (a.k.a. RUNCNT). HL points to code.
;
; Used by the routines at __LOAD, __WEND, __CALL, L45C9 and KILFOR.
EXEC_EVAL:
  PUSH HL
  DEFB $CD                ; CALL nn

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
  CP $3A
  JP Z,EXEC
  OR A
  JP NZ,SN_ERR
  INC HL
; This entry point is used by the routine at ERROR_3.
L12AA_0:
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
  JP Z,L12AA_1
  PUSH DE
  LD A,$5B
  CALL OUTDO
  CALL _PRNUM
  LD A,$5D
  CALL OUTDO
  POP DE
L12AA_1:
  EX DE,HL                ; }

; Routine at 4843
;
; Used by the routines at L12AA and __MERGE.
EXEC:
  CALL _CHRGTB
  LD DE,EXEC_EVAL
  PUSH DE
  RET Z
; This entry point is used by the routines at __ON and __IF.
IFJMP:
  SUB $81
  JP C,__LET
  CP $4C
  JP NC,MAKINT_4
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
; Used by the routines at PROMPT, UPD_PTRS, CRNCLP, DETOKEN_MORE, SAVSTP, EXEC,
; DEFVAL, GET_POSINT, FC_ERR, ATOH, __REM, __ON, __RESUME, __IF, __PRINT,
; __TAB, NEXITM, __INPUT, INPUT_SUB, __READ, __READ_DONE, LTSTND, FDTLP, EVAL3,
; OPRND, __ERR, __ERL, HEXTFP, OPRND_3, UNSIGNED_RESULT_A, __DEF, __WAIT,
; __WIDTH, FPSINT, FNDNUM, GETINT, __LIST, L23A9, LINE2PTR, __OPTION, LOOK_FOR,
; _ASCTFP, PUFOUT, L3338, L37E3, __OPEN, GET_CHNUM, LINE_INPUT, __LOAD,
; __MERGE, L41C5, __LSET, __WHILE, __CALL, __CHAIN, L45C9, __GET, PINLIN,
; STALL, DIMRET, GVAR, SBSCPT, L5256, __ERASE, __CLEAR, KILFOR, DTSTR, TOPOOL,
; __MID_S, MIDNUM and BASIC_ENTRY.
_CHRGTB:
  INC HL
; This entry point is used by the routine at UPD_PTRS.
_CHRGTB_0:
  LD A,(HL)
  CP $3A
  RET NC
; This entry point is used by the routine at SYNCHR.
_CHRGTB_1:
  CP $20
  JP Z,_CHRGTB
  JP NC,_CHRGTB_10
  OR A
  RET Z
  CP $0B
  JP C,_CHRGTB_9
  CP $1E
  JP NZ,_CHRGTB_2
  LD A,(CONSAV)
  OR A
  RET
_CHRGTB_2:
  CP $10
  JP Z,_CHRGTB_7
  PUSH AF
  INC HL
  LD (CONSAV),A
  SUB $1C
  JP NC,_CHRGTB_8
  SUB $F5
  JP NC,_CHRGTB_3
  CP $FE
  JP NZ,_CHRGTB_5
  LD A,(HL)
  INC HL
_CHRGTB_3:
  LD (CONTXT),HL
  LD H,$00
_CHRGTB_4:
  LD L,A
  LD (CONLO),HL
  LD A,$02
  LD (CONTYP),A
  LD HL,$1392
  POP AF
  OR A
  RET
_CHRGTB_5:
  LD A,(HL)
  INC HL
  INC HL
  LD (CONTXT),HL
  DEC HL
  LD H,(HL)
  JP _CHRGTB_4
; This entry point is used by the routine at OPRND.
_CHRGTB_6:
  CALL _CHRGTB_11
_CHRGTB_7:
  LD HL,(CONTXT)
  JP _CHRGTB_0
_CHRGTB_8:
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
  LD HL,$1392
  OR A
  RET
_CHRGTB_9:
  CP $09
  JP NC,_CHRGTB
_CHRGTB_10:
  CP $30
  CCF
  INC A
  DEC A
  RET
  LD E,$10
; This entry point is used by the routine at __LIST.
_CHRGTB_11:
  LD A,(CONSAV)
  CP $0F
  JP NC,_CHRGTB_13
  CP $0D
  JP C,_CHRGTB_13
  LD HL,(CONLO)
  JP NZ,_CHRGTB_12
  INC HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
_CHRGTB_12:
  JP DBL_ABS_0
_CHRGTB_13:
  LD A,(CONTYP)
  LD (VALTYP),A
  CP $08
  JP Z,_CHRGTB_14
  LD HL,(CONLO)
  LD (FACLOW),HL
  LD HL,($0A70)
  LD (FACCU),HL
  RET
_CHRGTB_14:
  LD HL,CONLO
  JP FP_HL2DE

; 'DEFSTR' BASIC function
__DEFSTR:
  LD E,$03
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'DEFINT' BASIC function
__DEFINT:
  LD E,$02
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'DEFSNG' BASIC function
__DEFSNG:
  LD E,$04
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'DEFDBL' BASIC function
__DEFDBL:
  LD E,$08

; Routine at 5082
DEFVAL:
  CALL IS_ALPHA
  LD BC,SN_ERR
  PUSH BC
  RET C
  SUB $41
  LD C,A
  LD B,A
  CALL _CHRGTB
  CP $F3
  JP NZ,DEFVAL_0
  CALL _CHRGTB
  CALL IS_ALPHA
  RET C
  SUB $41
  LD B,A
  CALL _CHRGTB
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
  CP $2C
  RET NZ
  CALL _CHRGTB
  JP DEFVAL

; Get subscript
;
; Used by the routines at L45C9, __GET and SBSCPT.
GET_POSINT:
  CALL _CHRGTB
; This entry point is used by the routine at __CLEAR.
GET_POSINT_0:
  CALL FPSINT_0
  RET P

; Err $05 - "Illegal function call"
;
; Used by the routines at __ERROR, __AUTO, __ERL, __DEF, GETINT, __DELETE,
; __RENUM, __LOG, __NAME, __CVD, __LSET, __CHAIN, L45A2, L45C9, __GET, __USING,
; L5256, __TROFF, __CLEAR, __ASC, __MID_S, MIDNUM and BASIC_ENTRY.
FC_ERR:
  LD E,$05
  JP ERROR
; This entry point is used by the routines at LNUM_RANGE, __AUTO, __RENUM and
; __EDIT.
LNUM_PARM:
  LD A,(HL)
  CP $2E
  EX DE,HL
  LD HL,(DOT)
  EX DE,HL
  JP Z,_CHRGTB

; ASCII to Integer, result in DE
;
; Used by the routines at PROMPT, DETOKEN_MORE, __GO_SUB, __GO_TO, __ON,
; __RESUME, __AUTO, UCASE, __RENUM, PINLIN and SYNCHR.
ATOH:
  DEC HL
; This entry point is used by the routine at __ON.
ATOH2:
  CALL _CHRGTB
  CP $0E
  JP Z,LNUM_PARM_2
  CP $0D
; This entry point is used by the routine at LINE2PTR.
LNUM_PARM_2:
  EX DE,HL
  LD HL,(CONLO)
  EX DE,HL
  JP Z,_CHRGTB
  XOR A
  LD (CONSAV),A
  LD DE,$0000
  DEC HL
LNUM_PARM_3:
  CALL _CHRGTB
  RET NC
  PUSH HL
  PUSH AF
  LD HL,$1998
  CALL DCOMPR
  JP C,LNUM_PARM_4
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
  JP LNUM_PARM_3
LNUM_PARM_4:
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
  LD A,$8D                ; "GOSUB" token
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
  RET Z                   ; }
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
  CALL C,SRCHLN           ; Line is after current line
  CALL NC,SRCHLP          ; Line is before current line
  JP NC,UL_ERR            ; Err $08 - "Undefined line number"
  DEC BC                  ; Incremented after
  LD A,$0D
  LD (PTRFLG),A
  POP HL
  CALL LINE2PTR_6
  LD H,B
  LD L,C
  RET

; entry for '?UL ERROR'
;
; Used by the routines at PROMPT, __GO_TO, __ON, L45C9, __EDIT and SYNCHR.
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
  CP $8D                  ; TK_GOSUB, Token for 'GOSUB'
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
; L45C9.
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
  CALL _CHRGTB            ; Get byte
  OR A                    ; End of line?
  RET Z                   ; Yes - Exit
  CP B                    ; End of statement?
  RET Z                   ; Yes - Exit
  INC HL                  ; Next byte
  CP $22                  ; Literal string?
  JP Z,NXTSTL             ; Yes - Look for another '"'
  INC A
  JP Z,__REM_1
  SUB $8C
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
  DEFB $F0
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
  CALL MAKINT_1
; This entry point is used by the routine at __DEF.
__LET_2:
  LD A,(VALTYP)
__LET_3:
  LD DE,FACLOW
  CP $05
  JP C,__LET_4
  LD DE,$0C00
__LET_4:
  PUSH HL
  CP $03
  JP NZ,__LET_6
  LD HL,(FACLOW)
  PUSH HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(TXTTAB)
  CALL DCOMPR
  JP NC,$1579
  LD HL,(STREND)
  CALL DCOMPR
  POP DE
  JP NC,__LET_5
  LD HL,DSCTMP
  CALL DCOMPR
  JP NC,__LET_5
  LD A,$D1
  CALL GSTRDE_1
  EX DE,HL
  CALL SAVSTR_0
__LET_5:
  CALL GSTRDE_1
  EX (SP),HL
__LET_6:
  CALL FP2HL
  POP DE
  POP HL
  RET

; 'ON' BASIC instruction
__ON:
  CP $A8
  JP NZ,ON_OTHER
  CALL _CHRGTB
  CALL SYNCHR
  DEFB $89
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
  CP $8D                  ; "GOSUB" token?
  JP Z,ONGO               ; Yes - Find line number
  CALL SYNCHR             ; Make sure it's "GOTO"
  DEFB $89                ; TK_GOTO: "GOTO" token
  DEC HL                  ; Cancel increment
ONGO:
  LD C,E                  ; Integer of branch value
ONGOLP:
  DEC C                   ; Count branches
  LD A,B                  ; Get "GOTO" or "GOSUB" token
  JP Z,IFJMP              ; Go to that line if right one
  CALL ATOH2              ; Get line number to DE
  CP $2C                  ; Another line number?
  RET NZ                  ; No - Drop through
  JP ONGOLP               ; Yes - loop

; 'RESUME' BASIC command
__RESUME:
  LD A,(ONEFLG)
  OR A
  JP NZ,__RESUME_0
  LD (ONELIN),A
  LD ($0ABA),A
  JP RW_ERR
__RESUME_0:
  INC A
  LD (ERRFLG),A
  LD A,(HL)
  CP $83
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
  CALL _CHRGTB
  RET NZ
  LD A,$3C
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
  CP $2C                  ; ","
  CALL Z,_CHRGTB
  CP $89                  ; "GOTO" token?
  JP Z,IFGO               ; Yes - Get line
  CALL SYNCHR             ; Make sure it's "THEN"
  DEFB $CF                ; TK_THEN: "THEN" token
  DEC HL                  ; Cancel increment
IFGO:
  PUSH HL
  CALL _TSTSGN            ; Test state of expression
  POP HL
  JP Z,FALSE_IF           ; False - Drop through
IFGO_0:
  CALL _CHRGTB            ; Get next character
  RET Z                   ; Go to RUNCNT if end of STMT
  CP $0E                  ; Line number prefix ?
  JP Z,__GO_TO            ; Yes - GOTO that line
  CP $0D
  JP NZ,IFJMP             ; Otherwise do statement
  LD HL,(CONLO)
  RET
FALSE_IF:
  LD D,$01
DROP_THROUGH:
  CALL __DATA
  OR A
  RET Z
  CALL _CHRGTB
  CP $A2                  ; TK_ELSE
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
  CALL GET_CHNUM
; This entry point is used by the routines at __LPRINT and PRNTNB.
MRPRNT:
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL _CHRGTB
  CALL Z,OUTDO_CRLF       ; CRLF if just PRINT
; This entry point is used by the routine at NEXITM.
PRNTLP:
  JP Z,FINPRT             ; End of list - Exit
  CP $D9                  ; TK_USING
  JP Z,__USING
  CP $D0                  ; "TAB(" token?
  JP Z,__TAB              ; Yes - Do TAB routine
  CP $D4                  ; "SPC(" token?
  JP Z,__TAB              ; Yes - Do SPC routine
  PUSH HL                 ; Save code string address
  CP $2C                  ; Comma?
  JP Z,DOCOM              ; Yes - Move to next zone
  CP $3B                  ; Semi-colon?
  JP Z,NEXITM             ; Do semi-colon routine
  POP BC                  ; Code string address to BC
  CALL EVAL               ; Evaluate expression
  PUSH HL                 ; Save code string address
  CALL GETYPR             ; Get the number type (FAC)
  JP Z,PRNTST             ; JP If string type
  CALL FOUT               ; Convert number to text
  CALL CRTST              ; Create temporary string
  LD (HL),$20             ; Followed by a space
  LD HL,(FACLOW)          ; Get length of output
  INC (HL)                ; Plus 1 for the space

; Output string contents
;
; Used by the routine at __PRINT.
PRNTST:
  CALL ISFLIO
  JP NZ,_PRNTST
  LD HL,(FACLOW)
  LD A,(PRTFLG)
  OR A
  JP Z,PRNTST_0
  LD A,(NTMSXP)
  LD B,A
  INC A
  JP Z,_PRNTST
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
  JP Z,PRNTNB_0           ; }
  LD A,(COMMAN)           ; Get comma width
  LD B,A                  ; Save in B
  INC A
  LD A,(LPTPOS)
  JP Z,ZONELP
  CP B
  JP PRNTNB_1
PRNTNB_0:
  LD A,(CLMLST)
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

; PRINT TAB(
;
; Used by the routine at __PRINT.
__TAB:
  PUSH AF                 ; Save token
  CALL _CHRGTB            ; Evaluate expression
  CALL FPSINT_0
  POP AF                  ; Restore token
  PUSH AF                 ; Save token
  CP $D4
  JP Z,__TAB_0
  DEC DE
__TAB_0:
  LD A,D
  OR A
  JP P,__TAB_1
  LD DE,$0000
__TAB_1:
  PUSH HL
  CALL ISFLIO
  JP NZ,DOTAB
  LD A,(PRTFLG)
  OR A
  LD A,(NTMSXP)
  JP NZ,__TAB_2
  LD A,(LINLEN)
__TAB_2:
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
  SUB $D4                 ; Was it "SPC(" ?
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
  LD A,$20                ; Space
SPCLP:
  CALL OUTDO              ; Output character in A
  DEC B                   ; Count them
  JP NZ,SPCLP             ; Repeat if more

; Move to next item in the PRINT list
;
; Used by the routines at __PRINT, PRNTNB and DOTAB.
NEXITM:
  POP HL                  ; Restore code string address
  CALL _CHRGTB            ; Get next character
  JP PRNTLP               ; More to print

; Routine at 6144
;
; Used by the routines at __PRINT, LTSTND, __LOF, __LOAD, L45C9, L5256 and
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
  CALL SYNCHR
  DEFB $85
  CP $23
  JP Z,LINE_INPUT
  CALL PINLIN_18
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
  CP $22
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
  CP $23                  ; '#'
  JP Z,SET_INPUT_CHANNEL
  CALL PINLIN_18
  LD BC,INPUT_SUB
  PUSH BC
; This entry point is used by the routine at __LINE.
__INPUT_0:
  CP $22                  ; Is there a prompt string?
  LD A,$00                ; Clear A and leave flags
  LD (CTLOFG),A           ; Enable output
  LD A,$FF
  LD (IMPFLG),A
  RET NZ
  CALL QTSTR
  LD A,(HL)
  CP $2C
  JP NZ,__INPUT_1
  XOR A
  LD (IMPFLG),A
  CALL _CHRGTB
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
  PUSH HL
  LD A,(IMPFLG)
  OR A
  JP Z,INPUT_SUB_0
  LD A,$3F
  CALL OUTDO
  LD A,$20
  CALL OUTDO
INPUT_SUB_0:
  CALL PINLIN_0
  POP BC
  JP C,INPBRK
  PUSH BC
  XOR A
  LD (FLGINP),A
  LD (HL),$2C
  EX DE,HL
  POP HL
  PUSH HL
  PUSH DE
  PUSH DE
  DEC HL
INPUT_SUB_1:
  LD A,$80
  LD (SUBFLG),A
  CALL _CHRGTB
  CALL _GETVAR
  LD A,(HL)
  DEC HL
  CP $5B
  JP Z,INPUT_SUB_2
  CP $28
  JP NZ,INPUT_SUB_6
INPUT_SUB_2:
  INC HL
  LD B,$00
INPUT_SUB_3:
  INC B
; This entry point is used by the routine at L184B.
INPUT_SUB_4:
  CALL _CHRGTB
  JP Z,SN_ERR
  CP $22
  JP Z,L184B
  CP $28
  JP Z,INPUT_SUB_3
  CP $5B
  JP Z,INPUT_SUB_4
  CP $5D
  JP Z,INPUT_SUB_5
  CP $29
  JP NZ,INPUT_SUB_4
INPUT_SUB_5:
  DEC B
  JP NZ,INPUT_SUB_4
INPUT_SUB_6:
  CALL _CHRGTB
  JP Z,INPUT_SUB_7
  CP $2C
  JP NZ,SN_ERR
INPUT_SUB_7:
  EX (SP),HL
  LD A,(HL)
  CP $2C
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
  CALL _CHRGTB
  EX (SP),HL
  LD A,(HL)
  CP $2C
  JP Z,INPUT_SUB_1
  POP HL
  DEC HL
  CALL _CHRGTB
  OR A
  POP HL
  JP NZ,L184B_2

; 'INPUT' from a stream
;
; Used by the routine at SET_INPUT_CHANNEL.
INPUT_CHANNEL:
  LD (HL),$2C
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
  CP $2C                  ; Comma?
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
  LD ($0BBC),A
  CALL ISFLIO
  JP NZ,__READ_INPUT
  CALL GETYPR             ; Check data type
  PUSH AF
  JP NZ,INPBIN            ; If numeric, convert to binary
  CALL _CHRGTB            ; Get next character
  LD D,A                  ; Save input character
  LD B,A                  ; Again
  CP $22                  ; Start of literal sting?
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
  LD A,($0BBC)
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
  CALL _CHRGTB            ; Get next character
  POP AF
  PUSH AF
  LD BC,__READ_DONE
  PUSH BC
  JP C,DBL_ASCTFP_0
  JP DBL_ASCTFP

; Where to go after LETSTR
LTSTND:
  DEC HL
  CALL _CHRGTB            ; Get next character
  JP Z,MORDT              ; End of line - More needed?
  CP $2C                  ; Another value?
  JP NZ,L184B_1           ; No - Bad input
MORDT:
  EX (SP),HL              ; Get code string address
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL _CHRGTB            ; Get next character
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
  CALL _CHRGTB            ; Get next character
  CP $84                  ; "DATA" token
  JP NZ,FDTLP             ; No "DATA" - Keep looking
  JP ANTVLU               ; Found - Convert input
; This entry point is used by the routines at __DEF, __LSET and MIDNUM.
NEXT_EQUAL:
  CALL SYNCHR             ; }
  DEFB $F0
  JP EVAL
; This entry point is used by the routines at OPRND_FINISH, OPRND_3 and MIDNUM.
NEXT_PARENTH:
  CALL SYNCHR
  DEFM "("

; Routine at 6681
;
; Used by the routines at __FOR, FORFND, __LET, __IF, __PRINT, FDTLP, __DEF,
; FPSINT, GETINT, __POKE, __RANDOMIZE, FNAME, __OPEN, GET_CHNUM, __WEND,
; __CHAIN, L45C9, L5256, L52F3, TOPOOL and MIDNUM.
EVAL:
  DEC HL
; This entry point is used by the routines at FORFND and __USING.
EVAL_0:
  LD D,$00
; This entry point is used by the routines at EVAL3, OPRND_SUB and NOT.
EVAL_1:
  PUSH DE
  LD C,$01
  CALL CHKSTK             ; Check for 1 level of stack
  CALL OPRND              ; Get next expression value
  XOR A
  LD (RESFLG),A
EVAL2:
  LD (NXTOPR),HL          ; Save address of next operator
; This entry point is used by the routine at NOT.
EVAL_2:
  LD HL,(NXTOPR)          ; Restore address of next opr

; Evaluate expression until precedence break
EVAL3:
  POP BC                  ; Precedence value and operator
  LD A,(HL)               ; Get next operator / function
  LD (TEMP3),HL
  CP $EF                  ; TK_GREATER, token code for '>'
  RET C
  CP $F2                  ; TK_PLUS, token code for '+'
  JP C,EVAL3_2
  SUB $F2                 ; TK_PLUS, token code for '+'
  LD E,A                  ; Coded operator
  JP NZ,EVAL3_0
  LD A,(VALTYP)           ; Get data type
  CP $03                  ; String ?
  LD A,E                  ; Coded operator
  JP Z,CONCAT             ; If so, string concatenation (use '+' to join
EVAL3_0:
  CP $0C                  ; strings)
  RET NC
  LD HL,PRITAB
  LD D,$00
  ADD HL,DE
  LD A,B
  LD D,(HL)
  CP D
  RET NC
  PUSH BC
  LD BC,EVAL_2
  PUSH BC
  LD A,D
  CP $7F
  JP Z,EVAL3_4
  CP $51
  JP C,EVAL_BOOL
  AND $FE
  CP $7A
  JP Z,EVAL_BOOL
EVAL_NUMERIC:
  LD HL,FACLOW
  LD A,(VALTYP)
  SUB $03
  JP Z,TM_ERR
  OR A
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  JP M,EVAL3_1
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  JP PO,EVAL3_1
  LD HL,$0C00
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
EVAL3_1:
  ADD A,$03
  LD C,E
  LD B,A
  PUSH BC
  LD BC,EVAL_VALTYP
EVAL_MORE:
  PUSH BC
  LD HL,(TEMP3)
  JP EVAL_1
EVAL3_2:
  LD D,$00
EVAL3_3:
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
  CALL _CHRGTB
  JP EVAL3_3
EVAL3_4:
  CALL __CSNG
  CALL STAKFP
  LD BC,$36E3
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
  CP $64
  RET NC
  PUSH BC
  PUSH DE
  LD DE,$6404
  LD HL,$1D59
  PUSH HL
  CALL GETYPR
  JP NZ,EVAL_NUMERIC
  LD HL,(FACLOW)
  PUSH HL
  LD BC,EVAL_STR
  JP EVAL_MORE
EVAL_VALTYP:
  POP BC
  LD A,C
  LD (DORES),A
  LD A,(VALTYP)
  CP B
  JP NZ,EVAL3_5
  CP $02
  JP Z,EVAL_INTEGER
  CP $04
  JP Z,EVAL1_6
  JP NC,EVAL1_1
EVAL3_5:
  LD D,A
  LD A,B
  CP $08
  JP Z,EVAL1_0
  LD A,D
  CP $08

; Save precedence and eval until precedence break
EVAL1:
  JP Z,EVAL1_5
  LD A,B
  CP $04
  JP Z,EVAL_SINGLE_PREC
  LD A,D
  CP $03
  JP Z,TM_ERR
  JP NC,EVAL_FP
; This entry point is used by the routine at EVAL3.
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
; This entry point is used by the routine at EVAL3.
EVAL1_0:
  CALL __CDBL
; This entry point is used by the routine at EVAL3.
EVAL1_1:
  CALL FP_ARG2HL
  POP HL
  LD ($0C02),HL
  POP HL
  LD ($0C00),HL
EVAL1_2:
  POP BC
  POP DE
  CALL FPBCDE
EVAL1_3:
  CALL __CDBL
  LD HL,DEC_OPR
EVAL1_4:
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
EVAL1_5:
  LD A,B
  PUSH AF
  CALL FP_ARG2HL
  POP AF
  LD (VALTYP),A
  CP $04
  JP Z,EVAL1_2
  POP HL
  LD (FACLOW),HL
  JP EVAL1_3
EVAL_SINGLE_PREC:
  CALL __CSNG
; This entry point is used by the routine at EVAL3.
EVAL1_6:
  POP BC
  POP DE
EVAL1_7:
  LD HL,FLT_OPR
  JP EVAL1_4
EVAL_FP:
  POP HL
  CALL STAKFP
  CALL HL_CSNG
  CALL BCDEFP
  POP HL
  LD (FACCU),HL
  POP HL
  LD (FACLOW),HL
  JP EVAL1_7

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
  CALL _CHRGTB            ; Gets next character (or token) from BASIC text.
  JP Z,OPERAND_ERR        ; No operand - "Missing Operand" Error
  JP C,DBL_ASCTFP_0
  CALL IS_ALPHA_A         ; See if a letter
  JP NC,EVAL_VARIABLE     ; Letter - Find variable
  CP $20
  JP C,_CHRGTB_6
  INC A
  JP Z,OPRND_3
  DEC A
  CP $F2
  JP Z,OPRND
  CP $F3
  JP Z,OPRND_SUB
  CP $22
  JP Z,QTSTR
  CP $D5
  JP Z,NOT
  CP $26
  JP Z,HEXTFP
  CP $D7
  JP NZ,__ERR_0

; 'ERR' BASIC function
__ERR:
  CALL _CHRGTB
  LD A,(ERRFLG)
  PUSH HL
  CALL UNSIGNED_RESULT_A
  POP HL
  RET
; This entry point is used by the routine at OPRND.
__ERR_0:
  CP $D6
  JP NZ,__ERL_0

; 'ERL' BASIC function
__ERL:
  CALL _CHRGTB
  PUSH HL
  LD HL,(ERRLIN)
  CALL DBL_ABS_0
  POP HL
  RET
; This entry point is used by the routine at __ERR.
__ERL_0:
  CP $DC
  JP NZ,OPRND_MORE
VARPTR:
  CALL _CHRGTB
  CALL SYNCHR
  DEFM "("
  CP $23
  JP NZ,VARPTR_VAR
VARPTR_BUF:
  CALL FNDNUM
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
  CP $D2
  JP Z,FN_USR
  CP $DA
  JP Z,FN_INSTR
  CP $DD
  JP Z,FN_INKEY
  CP $D8
  JP Z,FN_STRING
  CP $85
  JP Z,FN_INPUT
  CP $D3
  JP Z,FN_FN

; End of expression.  Look for ')'.
;
; Used by the routines at OPRND_3 and UNSIGNED_RESULT_A.
OPRND_FINISH:
  CALL NEXT_PARENTH
  CALL SYNCHR
  DEFM ")"
  RET

; OPRND_SUB
;
; Used by the routine at OPRND.
OPRND_SUB:
  LD D,$7D
  CALL EVAL_1
  LD HL,(NXTOPR)
  PUSH HL
  CALL INVSGN

; POP HL / RET
_POPHLRT:
  POP HL
  RET

; (a.k.a. CONVAR)
;
; Used by the routine at OPRND.
EVAL_VARIABLE:
  CALL GETVAR
VAR_EVAL_1:
  PUSH HL
  EX DE,HL
  LD (FACLOW),HL
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
; Used by the routines at DETOKEN_MORE, HEXTFP and L5383.
UCASE:
  CP $61
  RET C
  CP $7B
  RET NC
  AND $5F
  RET
; This entry point is used by the routine at BASIC_ENTRY.
UCASE_0:
  CP $26
  JP NZ,ATOH

; HEX or other specified base (ASCII) to FP number
;
; Used by the routines at DETOKEN_MORE, OPRND and H_ASCTFP.
HEXTFP:
  LD DE,$0000
  CALL _CHRGTB
  CALL UCASE
  CP $4F
  JP Z,HEXTFP_4
  CP $48
  JP NZ,HEXTFP_3
  LD B,$05
HEXTFP_0:
  INC HL
  LD A,(HL)
  CALL UCASE
  CALL IS_ALPHA_A
  EX DE,HL
  JP NC,HEXTFP_1
  CP $3A
  JP NC,HEXTFP_5
  SUB $30
  JP C,HEXTFP_5
  JP HEXTFP_2
HEXTFP_1:
  CP $47
  JP NC,HEXTFP_5
  SUB $37
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
  CALL _CHRGTB
  EX DE,HL
  JP NC,HEXTFP_5
  CP $38
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
  SUB $30
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
  SUB $81
  CP $07
  JP NZ,OPRND_3_0
  PUSH HL
  CALL _CHRGTB
  CP $28
  POP HL
  JP NZ,L37E3
  LD A,$07
OPRND_3_0:
  LD B,$00
  RLCA
  LD C,A
  PUSH BC
  CALL _CHRGTB
  LD A,C
  CP $05
  JP NC,OPRND_3_1
  CALL NEXT_PARENTH
  CALL SYNCHR
  DEFM ","
  CALL TSTSTR
  EX DE,HL
  LD HL,(FACLOW)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  CALL GETINT
  EX DE,HL
  EX (SP),HL
  JP OPRND_3_3
OPRND_3_1:
  CALL OPRND_FINISH
  EX (SP),HL
  LD A,L
  CP $0C
  JP C,OPRND_3_2
  CP $1B
  PUSH HL
  CALL C,__CSNG
  POP HL
OPRND_3_2:
  LD DE,_POPHLRT
  PUSH DE
  LD A,$01
  LD (RESFLG),A
OPRND_3_3:
  LD BC,FNCTAB_FN
; This entry point is used by the routine at MAKINT.
OPRND_3_4:
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  JP (HL)
; This entry point is used by the routine at _ASCTFP.
OPRND_3_5:
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
  LD D,$5A
  CALL EVAL_1
  CALL __CINT
  LD A,L
  CPL
  LD L,A
  LD A,H
  CPL
  LD H,A
  LD (FACLOW),HL
  POP BC
; This entry point is used by the routine at OPRND_3.
NOT_0:
  JP EVAL_2

; Test number FAC type (Precision mode, etc..)
;
; Used by the routines at DETOKEN_MORE, SAVSTP, __PRINT, INPUT_SUB, __READ,
; EVAL3, EVAL_VARIABLE, __DEF, __POKE, INVSGN, _TSTSGN, FP_DE2HL, __CINT,
; __CSNG, __CDBL, TSTSTR, __FIX, __INT, _ASCTFP, DECDIV_SUB, PUFOUT, L3356,
; __READ_INPUT, LINE_INPUT, __CALL, L45C9, L4F11, __TROFF, TOPOOL, MIDNUM and
; __FRE.
GETYPR:
  LD A,(VALTYP)
  CP $08
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
  CP $7A
  JP Z,IMOD
  CP $7B
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
__POS:
  LD A,(TTYPOS)
; This entry point is used by the routine at __LPOS.
__POS_0:
  INC A

; Get back from function, result in A
;
; Used by the routines at __ERR, MAKINT, __DELETE, __LOF and __MID_S.
UNSIGNED_RESULT_A:
  LD L,A
  XOR A
; This entry point is used by the routine at __LOC.
BOOL_RESULT:
  LD H,A
  JP INT_RESULT_HL
; This entry point is used by the routine at OPRND_MORE.
FN_USR:
  CALL GET_USR_JPTAB_ADDR
  PUSH DE
  CALL OPRND_FINISH
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
  LD HL,FACLOW
  RET
GET_USR_JPTAB_ADDR:
  CALL _CHRGTB
  LD BC,$0000
  CP $1B
  JP NC,UNSIGNED_RESULT_A_0
  CP $11
  JP C,UNSIGNED_RESULT_A_0
  CALL _CHRGTB
  LD A,(CONLO)
  OR A
  RLA
  LD C,A
UNSIGNED_RESULT_A_0:
  EX DE,HL
  LD HL,USR0
  ADD HL,BC
  EX DE,HL
  RET
; This entry point is used by the routine at __DEF.
DEF_USR:
  CALL GET_USR_JPTAB_ADDR
  PUSH DE
  CALL SYNCHR
  DEFB $F0
  CALL GETWORD
  EX (SP),HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; 'DEF' BASIC instruction
__DEF:
  CP $D2
  JP Z,DEF_USR
  CALL GETFN
  CALL NO_DIRECT
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  LD A,(HL)
  CP $28
  JP NZ,__DATA
  CALL _CHRGTB
__DEF_0:
  CALL GETVAR
  LD A,(HL)
  CP $29
  JP Z,__DATA
  CALL SYNCHR
  DEFM ","
  JP __DEF_0
; This entry point is used by the routine at OPRND_MORE.
FN_FN:
  CALL GETFN
  LD A,(VALTYP)
  OR A
  PUSH AF
  LD (NXTOPR),HL
  EX DE,HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD A,H
  OR L
  JP Z,UFN_ERR
  LD A,(HL)
  CP $28
  JP NZ,$1F35
  CALL _CHRGTB
  LD (TEMP3),HL
  EX DE,HL
  LD HL,(NXTOPR)
  CALL SYNCHR
  DEFM "("
  XOR A
  PUSH AF
  PUSH HL
  EX DE,HL
FN_FN_0:
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
  CALL MAKINT_1
  LD C,$04
  CALL CHKSTK
  LD HL,$FFF8
  ADD HL,SP
  LD SP,HL
  CALL FP_DE2HL
  LD A,(VALTYP)
  PUSH AF
  LD HL,(NXTOPR)
  LD A,(HL)
  CP $29
  JP Z,__DEF_0
  CALL SYNCHR
  DEFM ","
  PUSH HL
  LD HL,(TEMP3)
  CALL SYNCHR
  DEFM ","
  JP FN_FN_0
  POP AF
  LD (PRMLN2),A
__DEF_0:
  POP AF
  OR A
  JP Z,__DEF_2
  LD (VALTYP),A
  LD HL,$0000
  ADD HL,SP
  CALL FP_HL2DE
  LD HL,$0008
  ADD HL,SP
  LD SP,HL
  POP DE
  LD L,$03
__DEF_1:
  INC L
  DEC DE
  LD A,(DE)
  OR A
  JP M,__DEF_1
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
  CALL MAKINT_3
  LD BC,$1EDE
  PUSH BC
  PUSH BC
  JP __LET_2
__DEF_2:
  LD HL,(NXTOPR)
  CALL _CHRGTB
  PUSH HL
  LD HL,(TEMP3)
  CALL SYNCHR
  DEFM ")"
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
  CALL MAKINT_3
  POP HL
  LD (PRMSTK),HL
  LD HL,(PRMLN2)
  LD (PRMLEN),HL
  LD B,H
  LD C,L
  LD HL,PARM1
  LD DE,PARM2
  CALL MAKINT_3
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
  CALL _CHRGTB
  JP NZ,SN_ERR
  CALL GETYPR
  JP NZ,MAKINT_0
  LD DE,DSCTMP

; Convert tmp string to int in A register
MAKINT:
  LD A,(BC)
  LD HL,(FACLOW)
  CALL DCOMPR
  JP C,MAKINT_0
  CALL SAVSTR_0
  CALL TSTOPL_0
; This entry point is used by the routine at __DEF.
MAKINT_0:
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
  CALL MAKINT_3
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
; This entry point is used by the routines at __FOR, __LET, __DEF and __MKD_S.
MAKINT_1:
  PUSH HL
  AND $07
  LD HL,TYPE_OPR
  LD C,A
  LD B,$00
  ADD HL,BC
  CALL OPRND_3_4
  POP HL
  RET
MAKINT_2:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
; This entry point is used by the routine at __DEF.
MAKINT_3:
  LD A,B
  OR C
  JP NZ,MAKINT_2
  RET
; This entry point is used by the routine at __DEF.
NO_DIRECT:
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  RET NZ
  LD E,$0C
  JP ERROR
; This entry point is used by the routine at __DEF.
GETFN:
  CALL SYNCHR
  DEFB $D3
  LD A,$80
  LD (SUBFLG),A
  OR (HL)
  LD C,A
  JP GETVAR_0
; This entry point is used by the routine at EXEC.
MAKINT_4:
  CP $7E
  JP NZ,SN_ERR
  INC HL
  LD A,(HL)
  INC HL
  CP $83
  JP Z,MIDNUM_6
  JP SN_ERR
__INP:
  CALL GETINT_0
  LD (INPORT),A
  DEFB $DB                ; IN A,(n)
INPORT:
  DEFB $00                ; Current port for 'INP' function
  JP UNSIGNED_RESULT_A

; 'OUT' BASIC command
__OUT:
  CALL GTWORD_GTINT
  DEFB $D3                ; OUT (n),A
OTPORT:
  DEFB $00                ; Current port for 'OUT' statement
  RET

; 'WAIT' BASIC command
__WAIT:
  CALL GTWORD_GTINT
  PUSH AF
  LD E,$00
  DEC HL
  CALL _CHRGTB
  JP Z,__WAIT_0
  CALL SYNCHR
  DEFM ","
  CALL GETINT
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
  JP SN_ERR

; 'WIDTH' BASIC command
__WIDTH:
  CP $9E
  JP NZ,__WIDTH_0
  CALL _CHRGTB
  CALL GETINT
  LD (NTMSXP),A
  LD E,A
  CALL __WIDTH_1
  LD (COMMAN),A
  RET
__WIDTH_0:
  CALL GETINT
  LD (LINLEN),A
  LD E,A
  CALL __WIDTH_1
  LD (CLMLST),A
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
  CALL _CHRGTB
; This entry point is used by the routines at GET_POSINT and __TAB.
FPSINT_0:
  CALL EVAL

; Get integer variable to DE, error if negative
;
; Used by the routine at GETINT.
DEPINT:
  PUSH HL
  CALL __CINT
  EX DE,HL
  POP HL
  LD A,D
  OR A
  RET

; Get "WORD,BYTE" parameters
;
; Used by the routines at __OUT and __WAIT.
GTWORD_GTINT:
  CALL GETINT
  LD (WAIT_INPORT),A
  LD (OTPORT),A
  CALL SYNCHR
  DEFM ","
  JP GETINT

; Load 'A' with the next number in BASIC program
;
; Used by the routines at __ERL and __FIELD.
FNDNUM:
  CALL _CHRGTB

; Get a number to 'A'
;
; Used by the routines at __ON, __ERROR, OPRND_3, __WAIT, __WIDTH,
; GTWORD_GTINT, __POKE, __OPEN, L41C5, __LSET, __NULL, TOPOOL and MIDNUM.
GETINT:
  CALL EVAL
; This entry point is used by the routines at MAKINT, GET_CHNUM, __CHR_S,
; TOPOOL and MIDNUM.
GETINT_0:
  CALL DEPINT
  JP NZ,FC_ERR
  DEC HL
  CALL _CHRGTB
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
  CALL __GET_37
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
  LD A,$20
  CALL OUTDO
__LIST_1:
  CALL __LIST_3
  LD HL,BUF
  CALL __LIST_2
  CALL OUTDO_CRLF
  JP __LIST_0
; This entry point is used by the routines at PINLIN, L53A4 and EDIT_DONE.
__LIST_2:
  LD A,(HL)
  OR A
  RET Z
  CALL __LIST_3
  INC HL
  JP __LIST_2
; This entry point is used by the routine at __EDIT.
__LIST_3:
  LD BC,BUF
  LD D,$FF
  XOR A
  LD (INTFLG),A
  CALL __GET_37
  JP __LIST_5
__LIST_4:
  INC BC
  INC HL
  DEC D
  RET Z
; This entry point is used by the routine at L2223.
__LIST_5:
  LD A,(HL)
  OR A
  LD (BC),A
  RET Z
  CP $0B
  JP C,__LIST_6
  CP $20
  LD E,A
  JP C,__LIST_7
__LIST_6:
  OR A
  JP M,__LIST_11
  LD E,A
  CP $2E
  JP Z,__LIST_7
  CALL __LIST_26
  JP NC,__LIST_7
  XOR A
  JP __LIST_9
__LIST_7:
  LD A,(INTFLG)
  OR A
  JP Z,__LIST_8
  INC A
  JP NZ,__LIST_8
  LD A,$20
  LD (BC),A
  INC BC
  DEC D
  RET Z
__LIST_8:
  LD A,$01
__LIST_9:
  LD (INTFLG),A
  LD A,E
  CP $0B
  JP C,__LIST_10
  CP $20
  JP C,__LIST_27
__LIST_10:
  LD (BC),A
  JP __LIST_4
__LIST_11:
  INC A
  LD A,(HL)
  JP NZ,__LIST_12
  INC HL
  LD A,(HL)
  AND $7F
__LIST_12:
  INC HL
  CP $DB
  JP NZ,__LIST_13
  DEC BC
  DEC BC
  DEC BC
  DEC BC
  INC D
  INC D
  INC D
  INC D
__LIST_13:
  CP $A2
  CALL Z,DCBCDE_0
  CP $B4
  JP NZ,__LIST_14
  LD A,(HL)
  INC HL
  CP $F2
  LD A,$B4
  JP Z,__LIST_14
  DEC HL
__LIST_14:
  PUSH HL
  PUSH BC
  PUSH DE
  LD HL,WORDS
  LD B,A
  LD C,$40
__LIST_15:
  INC C
__LIST_16:
  INC HL
  LD D,H
  LD E,L
__LIST_17:
  LD A,(HL)
  OR A
  JP Z,__LIST_15
  INC HL
  JP P,__LIST_17
  LD A,(HL)
  CP B
  JP NZ,__LIST_16
  EX DE,HL
  CP $D2
  JP Z,__LIST_18
  CP $D3
__LIST_18:
  LD A,C
  POP DE
  POP BC
  LD E,A
  JP NZ,__LIST_19
  LD A,(INTFLG)
  OR A
  LD A,$00
  LD (INTFLG),A
  JP __LIST_21
__LIST_19:
  CP $5B
  JP NZ,__LIST_20
  XOR A
  LD (INTFLG),A
  JP __LIST_23
__LIST_20:
  LD A,(INTFLG)
  OR A
  LD A,$FF
  LD (INTFLG),A
__LIST_21:
  JP Z,__LIST_22
  LD A,$20
  LD (BC),A
  INC BC
  DEC D
  JP Z,TESTR_0
__LIST_22:
  LD A,E
  JP __LIST_24
__LIST_23:
  LD A,(HL)
  INC HL
  LD E,A
__LIST_24:
  AND $7F
  LD (BC),A
  INC BC
  DEC D
  JP Z,TESTR_0
  OR E
  JP P,__LIST_23
  CP $A8
  JP NZ,__LIST_25
  XOR A
  LD (INTFLG),A
__LIST_25:
  POP HL
  JP __LIST_5
; This entry point is used by the routine at CRNCH_MORE.
__LIST_26:
  CALL IS_ALPHA_A
  RET NC
  CP $30
  RET C
  CP $3A
  CCF
  RET
__LIST_27:
  DEC HL
  CALL _CHRGTB
  PUSH DE
  PUSH BC
  PUSH AF
  CALL _CHRGTB_11
  POP AF
  LD BC,L2223
  PUSH BC
  CP $0B
  JP Z,OCT_STR
  CP $0C
  JP Z,HEX_STR
  LD HL,(CONLO)
  JP FOUT

; 8739
L2223:
  POP BC
  POP DE
  LD A,(CONSAV)
  LD E,$4F
  CP $0B
  JP Z,L2223_0
  CP $0C
  LD E,$48
  JP NZ,L2223_1
L2223_0:
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
L2223_1:
  LD A,(CONTYP)
  CP $04
  LD E,$00
  JP C,L2223_2
  LD E,$21
  JP Z,L2223_2
  LD E,$23
L2223_2:
  LD A,(HL)
  CP $20
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
  CP $2E
  JP Z,L2223_5
L2223_4:
  CP $44
  JP Z,L2223_5
  CP $45
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
  JP __LIST_5

; 'DELETE' BASIC command
__DELETE:
  CALL LNUM_RANGE
  PUSH BC
  CALL LINE2PTR_7
  POP BC
  POP DE
  PUSH BC
  PUSH BC
  CALL SRCHLP
  JP NC,__DELETE_0
  LD D,H
  LD E,L
  EX (SP),HL
  PUSH HL
  CALL DCOMPR
__DELETE_0:
  JP NC,FC_ERR
  LD HL,OK_MSG
  CALL PRS
  POP BC
  LD HL,PROMPT_9
  EX (SP),HL
; This entry point is used by the routines at PROMPT and L45C9.
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
  CALL __GET_36
  LD A,(HL)
  JP UNSIGNED_RESULT_A

; 'POKE' BASIC command
__POKE:
  CALL GETWORD
  PUSH DE
  CALL __GET_36
  CALL SYNCHR
  DEFM ","
  CALL GETINT
  POP DE
  LD (DE),A
  RET
; This entry point is used by the routines at UNSIGNED_RESULT_A and __CLEAR.
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
  LD BC,$9180
  LD DE,$0000
  JP FADD

; 'RENUM' BASIC command
__RENUM:
  LD BC,$000A
  PUSH BC
  LD D,B
  LD E,B
  JP Z,__RENUM_1
  CP $2C
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
  CALL SRCHLP
  POP DE
  PUSH DE
  PUSH BC
  CALL SRCHLP
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
  JP __RENUM_3
__RENUM_2:
  ADD HL,BC
  JP C,FC_ERR
  EX DE,HL
  PUSH HL
  LD HL,$FFF9
  CALL DCOMPR
  POP HL
  JP C,FC_ERR
__RENUM_3:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  EX DE,HL
  POP DE
  JP Z,__RENUM_4
  LD A,(HL)
  INC HL
  OR (HL)
  DEC HL
  EX DE,HL
  JP NZ,__RENUM_2
__RENUM_4:
  PUSH BC
  CALL __RENUM_7
  POP BC
  POP DE
  POP HL
__RENUM_5:
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  JP Z,__RENUM_6
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
  JP __RENUM_5
__RENUM_6:
  LD BC,RESTART
  PUSH BC
  CP $F6
__RENUM_7:
  DEFB $F6                ; 'OR $AF'  masking the next instruction

; Routine at 9129
;
; Used by the routines at LINE2PTR, __MERGE and __GET.
L23A9:
  XOR A
  LD (PTRFLG),A
  LD HL,(TXTTAB)
  DEC HL
; This entry point is used by the routine at LINE2PTR.
L23A9_0:
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  RET Z
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
; This entry point is used by the routine at LINE2PTR.
L23A9_1:
  CALL _CHRGTB

; Line number to pointer
LINE2PTR:
  OR A
  JP Z,L23A9_0
  LD C,A
  LD A,(PTRFLG)
  OR A
  LD A,C
  JP Z,LINE2PTR_4
  CP $A8
  JP NZ,LINE2PTR_0
  CALL _CHRGTB
  CP $89
  JP NZ,LINE2PTR
  CALL _CHRGTB
  CP $0E                  ; Line number prefix
  JP NZ,LINE2PTR
  PUSH DE
  CALL LNUM_PARM_2
  LD A,D
  OR E
  JP NZ,LINE2PTR_1
  JP LINE2PTR_2
LINE2PTR_0:
  CP $0E
  JP NZ,L23A9_1
  PUSH DE
  CALL LNUM_PARM_2
LINE2PTR_1:
  PUSH HL
  CALL SRCHLP
  DEC BC
  LD A,$0D
  JP C,LINE2PTR_5
  CALL CONSOLE_CRLF
  LD HL,$2419
  PUSH DE
  CALL PRS
  POP HL
  CALL _PRNUM
  POP BC
  POP HL
  PUSH HL
  PUSH BC
  CALL LNUM_MSG
  POP HL
LINE2PTR_2:
  POP DE
  DEC HL
LINE2PTR_3:
  JP L23A9_1
  LD D,L
  LD L,(HL)
  LD H,H
  LD H,L
  LD H,(HL)
  LD L,C
  LD L,(HL)
  LD H,L
  LD H,H
  JR NZ,__OPTION_0
  LD L,C
  LD L,(HL)
  LD H,L
  JR NZ,LINE2PTR_4
LINE2PTR_4:
  CP $0D
  JP NZ,LINE2PTR_3
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
LINE2PTR_5:
  LD HL,$2413
  PUSH HL
  LD HL,(CONTXT)
; This entry point is used by the routine at __GO_TO.
LINE2PTR_6:
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
LINE2PTR_7:
  LD A,(PTRFLG)
  OR A
  RET Z
  JP L23A9                ; }

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
  SUB $30
  JP C,SN_ERR
  CP $02
  JP NC,SN_ERR
  LD (OPTBASE),A
  INC A
  LD (OPTBASE_FLG),A
  CALL _CHRGTB
  RET
; This entry point is used by the routines at LINE2PTR and DECDIV_SUB.
__OPTION_0:
  LD A,(HL)
  OR A
  RET Z
  CALL LPTOUT_SAFE
  INC HL
  JP __OPTION_0

; Safe printer output (i.e. to send reset commands)
;
; Used by the routines at __OPTION and DECDIV_SUB.
LPTOUT_SAFE:
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
  LD ($3881),HL
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
  CALL _CHRGTB
  JP Z,LOOK_FOR_3
  CP $A2
  JP Z,LOOK_FOR_4
  CP $CF
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
  CALL _CHRGTB
  LD A,C
  CP $1A
  LD A,(HL)
  JP Z,LOOK_FOR_5
  CP $B4
  JP Z,LOOK_FOR_0
  CP $B5
  JP NZ,LOOK_FOR_1
  DEC B
  JP NZ,LOOK_FOR_1
  RET
LOOK_FOR_5:
  CP $82
  JP Z,LOOK_FOR_0
  CP $83
  JP NZ,LOOK_FOR_1
L254F:
  DEC B                   ; $254F
  RET Z
  CALL _CHRGTB
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
  CALL _CHRGTB
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
; Used by the routines at __CINT and L3356.
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
; Used by the routines at __POKE, FADD_HLPTR, __LOG, MLSP10, _ASCTFP, SUMSER
; and __SIN.
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
  LD HL,FACLOW            ; Point to FPREG
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
  XOR A                   ; }
; This entry point is used by the routine at NEGAFT.
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
  DEC B
  RLA
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
; Used by the routines at FADD and L3356.
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
  ADD A,$09               ; Adjust count (8+1)
  LD L,A                  ; Save bits to shift
  LD A,D
  OR E
  OR B
  JP NZ,SHRLP
  LD A,C
SHRITE_0:
  DEC L
  RET Z
  RRA
  LD C,A
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
; Used by the routine at NEGAFT.
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
  LD HL,FP_LOGTAB
  CALL SUMSER_0
  POP BC
  POP HL
  CALL STAKFP
  EX DE,HL
  CALL FPBCDE
  LD HL,FP_LOGTAB2
  CALL SUMSER_0
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
; Used by the routines at __LOG, L2BA0, EXP, __EXP, SUMSER, __RND and __SIN.
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
  LD HL,FACLOW            ; Point to number

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
; Used by the routines at ADDEXP, SBSCPT and L53A4.
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
; Used by the routine at _ASCTFP.
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
  JP Z,DZERR              ; Error if division by zero
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
  LD A,L                  ; }
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

; Routine at 10179
DIVLP:
  DAA
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
  JP P,RESDIV_1
  RLA                     ; Restore carry
  LD A,(DIV4)
  RRA
  AND $C0
  PUSH AF
  LD A,B
  OR H
  OR L
  JP Z,RESDIV_0
  LD A,$20
RESDIV_0:
  POP HL
  OR H
  JP RONDUP_0
RESDIV_1:
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
  LD A,$FF                ; }
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
; Used by the routine at _ASCTFP.
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
; _TSTSGN, FCOMP, XDCOMP, __FIX, DECMUL, L3356, NEGAFT, __RND, __SIN and __ATN.
SIGN:
  LD A,(FPEXP)            ; Get sign of FPREG
  OR A
  RET Z                   ; RETurn if number is zero
  LD A,(FACCU)            ; Get MSB of FPREG
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
; Used by the routines at __LOG and _ASCTFP.
FLGREL:
  LD B,$88                ; 8 bit integer in exponent
  LD DE,$0000             ; Zero NMSB and LSB
; This entry point is used by the routines at HLPASS and DBL_ABS.
FLGREL_0:
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
; Used by the routines at OPRND_SUB, __FIX, _ASCTFP and PUFOUT.
INVSGN:
  CALL GETYPR
  JP M,DBL_ABS
  JP Z,TM_ERR

; Invert number sign
;
; Used by the routines at FSUB, __FIX, L2BA0, NEGAFT, __SIN and __ATN.
NEG:
  LD HL,FACCU
  LD A,(HL)
  XOR $80
  LD (HL),A
  RET

; 'SGN' BASIC function
__SGN:
  CALL _TSTSGN            ; Test sign of FPREG

; Get back from function, result in A (signed)
;
; Used by the routines at OPRND_3 and __EOF.
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
  LD HL,(FACLOW)
; This entry point is used by the routine at FORFND.
_TSTSGN_0:
  LD A,H
  OR L
  RET Z
  LD A,H
  JP SGN_RESULT

; Put FP value on stack
;
; Used by the routines at EVAL3, EVAL1, IDIV, FADD, __LOG, DIV10, IADD, L2BA0,
; _ASCTFP, PUFOUT, NEGAFT, __EXP, SUMSER, __SIN and __TAN.
STAKFP:
  EX DE,HL
  LD HL,(FACLOW)
  EX (SP),HL
  PUSH HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  RET

; Number at HL to BCDE
;
; Used by the routines at DIV10, L3356, NEGAFT, SUMSER, SEED_SHUFFLE, __RND and
; __NEXT.
PHLTFP:
  CALL LOADFP

; Move BCDE to FPREG
;
; Used by the routines at EVAL1, FADD, BNORM, __LOG, PUFOUT, L3356, GET_UNITY
; and __TAN.
FPBCDE:
  EX DE,HL
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACCU),HL
  EX DE,HL
  RET

; Load FP reg to BCDE
;
; Used by the routines at FORFND, EVAL1, __LOG, MLSP10, __CSNG, FPINT, INT,
; L3356, NEGAFT, SUMSER and __RND.
BCDEFP:
  LD HL,FACLOW

; Load FP value pointed by HL to BCDE
;
; Used by the routines at FADD_HLPTR, SUBPHL, PHLTFP, SUMSER, __RND and __NEXT.
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
; This entry point is used by the routines at PROMPT, L2223, PUFOUT and L3356.
INCHL:
  INC HL
  RET
; This entry point is used by the routines at __FOR, __RND and __NEXT.
DEC_FACCU2HL:
  LD DE,FACLOW
; This entry point is used by the routines at DECDIV_SUB and __NEW.
LOADFP_1:
  LD B,$04
  JP CPY2HL
VAL2DE:
  EX DE,HL
; This entry point is used by the routines at __LET, ICOMP, L2DC9, L3356,
; __TROFF, TSTOPL_0 and MIDNUM.
FP2HL:
  LD A,(VALTYP)
  LD B,A
; This entry point is used by the routines at _CHRGTB and L45C9.
CPY2HL:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC B
  JP NZ,CPY2HL
  RET
; This entry point is used by the routines at FADD, ADDEXP, __CSNG, FPINT, INT
; and DECADD.
SIGNS:
  LD HL,FACCU
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
FP_ARG2DE:
  LD HL,FPARG
; This entry point is used by the routines at _CHRGTB, EVAL_VARIABLE, __DEF,
; __CINT, L3356, __CVD and __CALL.
FP_HL2DE:
  LD DE,VAL2DE
  JP FP_DE2HL_0

; FP_ARG2HL
;
; Used by the routines at EVAL1, __CINT, DECDIV, _ASCTFP and L3356.
FP_ARG2HL:
  LD HL,FPARG

; FP_DE2HL
;
; Used by the routines at __DEF and __MKD_S.
FP_DE2HL:
  LD DE,FP2HL
; This entry point is used by the routine at LOADFP.
FP_DE2HL_0:
  PUSH DE
  LD DE,FACLOW
  CALL GETYPR
  RET C
  LD DE,$0C00
  RET

; aka FCOMP, Compare FP reg to BCDE
;
; Used by the routines at SETTYPE, _ASCTFP, L3356, NEGAFT, __SIN and __NEXT.
FCOMP:
  LD A,B
  OR A
  JP Z,SIGN
  LD HL,SGN_RESULT_CPL
  PUSH HL
  CALL SIGN
  LD A,C
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  CALL FCOMP_1
; This entry point is used by the routine at XDCOMP.
FCOMP_0:
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
; This entry point is used by the routine at L3356.
ICOMP_1:
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
  LD HL,FACCU
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
; Used by the routines at FORFND, EVAL3, NOT, EVAL_BOOL_END, DEPINT and
; __RANDOMIZE.
__CINT:
  CALL GETYPR
  LD HL,(FACLOW)
  RET M
  JP Z,TM_ERR
  JP PO,__CINT_0
  CALL FP_ARG2HL
  LD HL,FP_3620_FPZERO
  CALL FP_HL2DE
  CALL DECADD
  CALL __CSNG_0
  JP __CINT_1
__CINT_0:
  CALL ROUND
__CINT_1:
  LD A,(FACCU)
  OR A
  PUSH AF
  AND $7F
  LD (FACCU),A
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
; Used by the routines at __ERL, HEXTFP, UNSIGNED_RESULT_A, INT_RESULT_A,
; __CINT, INT, IMULT, L2BA0, L2BE1, DBL_ASCTFP_0 and LNUM_MSG.
INT_RESULT_HL:
  LD (FACLOW),HL

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
; Used by the routines at FORFND, EVAL3, EVAL1, OPRND_3, __POKE, _ASCTFP and
; NEGAFT.
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
  LD HL,$0C03
  LD B,(HL)
  JP RONDUP
; This entry point is used by the routines at __CDBL, _ASCTFP and L3356.
INT_CSNG:
  LD HL,(FACLOW)
; This entry point is used by the routines at EVAL1, IDIV, IADD and L2BA0.
HL_CSNG:
  CALL SETTYPE_SNG

; Get back from function passing an INT value HL
HLPASS:
  LD A,H
  LD D,L
  LD E,$00
  LD B,$90
  JP FLGREL_0

; 'CDBL' BASIC function
;
; Used by the routines at EVAL1, INT and _ASCTFP.
__CDBL:
  CALL GETYPR
  RET NC
  JP Z,TM_ERR
  CALL M,INT_CSNG
; This entry point is used by the routine at _ASCTFP.
ZERO_FACCU:
  LD HL,$0000
  LD ($0C00),HL
  LD ($0C02),HL

; Set type to "double precision"
;
; Used by the routine at DBL_ASCTFP.
SETTYPE_DBL:
  LD A,$08
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; Set type to "single precision"
;
; Used by the routines at __CSNG, DBL_ABS and SEED_SHUFFLE.
SETTYPE_SNG:
  LD A,$04
  JP SETTYPE

; Test a string, 'Type Error' if it is not
;
; Used by the routines at __LINE, OPRND_3, LINE_INPUT, __FIELD, __LSET,
; __USING, L52F3, CONCAT, GETSTR and MIDNUM.
TSTSTR:
  CALL GETYPR
  RET Z
  JP TM_ERR

; Floating Point to Integer
;
; Used by the routines at __CINT, INT and L3356.
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
; This entry point is used by the routine at __LIST.
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
; Used by the routines at NEGAFT, __EXP and __SIN.
INT:
  LD HL,FPEXP
  LD A,(HL)
  CP $98
  LD A,(FACLOW)
  RET NC
  LD A,(HL)
  CALL FPINT
  LD (HL),$98
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
; This entry point is used by the routine at L3356.
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
  LD A,(FACCU)
  LD C,A
  LD HL,FACCU
  LD A,$B8
  SUB B
  CALL DECADD_20
  POP AF
  CALL M,DECADD_10
  XOR A
  LD ($0BFF),A
  POP AF
  RET NC
  JP DECADD_3
INT_5:
  LD HL,$0C00
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
  JP _ASCTFP_21

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
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

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
  SCF                     ; }
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
  LD HL,(FACLOW)
  CALL L2BE1_4
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at _CHRGTB, __ERL and IMP.
DBL_ABS_0:
  EX DE,HL
  CALL SETTYPE_SNG
  XOR A
; This entry point is used by the routine at IADD.
DBL_ABS_1:
  LD B,$98
  JP FLGREL_0
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
; Used by the routines at __CINT, L2DC9, DECDIV, _ASCTFP and L3356.
DECADD:
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
  JP Z,FP_ARG2DE
  SUB B
  JP NC,DECADD_1
  CPL
  INC A
  PUSH AF
  LD C,$08
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
  CALL SIGNS
  LD HL,$0C0C
  LD B,A
  LD A,$00
  LD (HL),A
  LD ($0BFF),A
  POP AF
  LD HL,DBL_LAST_FPREG
  CALL DECADD_20
  LD A,B
  OR A
  JP P,DECADD_2
  LD A,($0C0C)
  LD ($0BFF),A
  CALL DECADD_13
  JP NC,DECADD_8
  EX DE,HL
  INC (HL)
  JP Z,OVERR_1
  CALL DECADD_28
  JP DECADD_8
DECADD_2:
  LD A,$9E
  CALL DECADD_14
  LD HL,SGNRES
  CALL C,DECADD_18
; This entry point is used by the routines at INT and DECMUL.
DECADD_3:
  XOR A
DECADD_4:
  LD B,A
  LD A,(FACCU)
  OR A
  JP NZ,DECADD_7
  LD HL,$0BFF
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
  LD HL,$0BFF
  CALL DECADD_29
  OR A
DECADD_7:
  JP P,DECADD_6
  LD A,B
  OR A
  JP Z,DECADD_8
  LD HL,FPEXP
  ADD A,(HL)
  LD (HL),A
  JP NC,ZERO_EXPONENT
  RET Z
DECADD_8:
  LD A,($0BFF)
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
  LD HL,$0C00
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
DECADD_12:
  LD DE,$0C30
  LD HL,FPARG
  JP DECADD_16
; This entry point is used by the routine at DECMUL.
DECADD_13:
  LD A,$8E
DECADD_14:
  LD HL,FPARG
; This entry point is used by the routine at L3356.
DECADD_15:
  LD DE,$0C00
DECADD_16:
  LD C,$07
  LD ($2D20),A
  XOR A
DECADD_17:
  LD A,(DE)
  ADC A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,DECADD_17
  RET
DECADD_18:
  LD A,(HL)
  CPL
  LD (HL),A
  LD HL,$0BFF
  LD B,$08
  XOR A
  LD C,A
DECADD_19:
  LD A,C
  SBC A,(HL)
  LD (HL),A
  INC HL
  DEC B
  JP NZ,DECADD_19
  RET
; This entry point is used by the routine at INT.
DECADD_20:
  LD (HL),C
  PUSH HL
DECADD_21:
  SUB $08
  JP C,DECADD_24
  POP HL
; This entry point is used by the routine at DECMUL.
DECADD_22:
  PUSH HL
  LD DE,$0800
DECADD_23:
  LD C,(HL)
  LD (HL),E
  LD E,C
  DEC HL
  DEC D
  JP NZ,DECADD_23
  JP DECADD_21
DECADD_24:
  ADD A,$09
  LD D,A
DECADD_25:
  XOR A
  POP HL
  DEC D
  RET Z
DECADD_26:
  PUSH HL
  LD E,$08
DECADD_27:
  LD A,(HL)
  RRA
  LD (HL),A
  DEC HL
  DEC E
  JP NZ,DECADD_27
  JP DECADD_25
; This entry point is used by the routine at DECMUL.
DECADD_28:
  LD HL,FACCU
  LD D,$01
  JP DECADD_26
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
  CALL DECDIV_1
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
  CALL C,DECADD_13
  CALL DECADD_28
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
  LD HL,FACCU
  CALL DECADD_22
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
; Used by the routine at _ASCTFP.
L2DC9:
  LD A,(FPEXP)
  CP $41
  JP NC,L2DC9_0
  LD DE,DECMUL_CONST
  LD HL,FPARG
  CALL FP2HL
  JP DECMUL
L2DC9_0:
  LD A,(FACCU)
  OR A
  JP P,L2DC9_1
  AND $7F
  LD (FACCU),A
  LD HL,NEG
  PUSH HL
L2DC9_1:
  CALL L2DC9_3
  LD DE,$0C00
  LD HL,FPARG
  CALL FP2HL
  CALL L2DC9_3
  CALL DECADD
  LD DE,$0C00
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
  CALL DECDIV_1
  LD HL,$0C37
  LD (HL),C
  LD B,C
DECDIV_0:
  LD A,$9E
  CALL DECADD_12
  LD A,(DE)
  SBC A,C
  CCF
  JP C,$2E8B
  LD A,$8E
  CALL DECADD_12
  XOR A
  JP C,$0412
  LD A,(FACCU)
  INC A
  DEC A
  RRA
  JP M,DECADD_9
  RLA
  LD HL,$0C00
  LD C,$07
  CALL DECADD_30
  LD HL,$0C30
  CALL DECADD_29
  LD A,B
  OR A
  JP NZ,DECDIV_0
  LD HL,FPEXP
  DEC (HL)
  JP NZ,DECDIV_0
  JP ZERO_EXPONENT
; This entry point is used by the routine at DECMUL.
DECDIV_1:
  LD A,C
  LD (DBL_LAST_FPREG),A
  DEC HL
  LD DE,$0C36
  LD BC,$0700
DECDIV_2:
  LD A,(HL)
  LD (DE),A
  LD (HL),C
  DEC DE
  DEC HL
  DEC B
  JP NZ,DECDIV_2
  RET
; This entry point is used by the routine at _ASCTFP.
DECDIV_3:
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
; Used by the routines at __READ_DONE, LINE_INPUT and __MID_S.
DBL_ASCTFP:
  CALL ZERO_EXPONENT
  CALL SETTYPE_DBL
  OR $AF

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
  CP $26
  JP Z,HEXTFP

; ASCII to FP number
_ASCTFP:
  CP $2D
  PUSH AF
  JP Z,_ASCTFP_0
  CP $2B
  JP Z,_ASCTFP_0
  DEC HL
_ASCTFP_0:
  CALL _CHRGTB
  JP C,_ASCTFP_DIGITS
  CP $2E
  JP Z,DECIMAL
  CP $65
  JP Z,EXPONENTIAL
  CP $45
EXPONENTIAL:
  JP NZ,_ASCTFP_3         ; Get number in exponential format
  PUSH HL
  CALL _CHRGTB
  CP $6C
  JP Z,_ASCTFP_1
  CP $4C
  JP Z,_ASCTFP_1
  CP $71
  JP Z,_ASCTFP_1
  CP $51
_ASCTFP_1:
  POP HL
  JP Z,_ASCTFP_2
  LD A,(VALTYP)
  CP $08
  JP Z,_ASCTFP_4
  LD A,$00
  JP _ASCTFP_4
_ASCTFP_2:
  LD A,(HL)
_ASCTFP_3:
  CP $25
  JP Z,_ASCTFP_8
  CP $23
  JP Z,_ASCTFP_9
  CP $21
  JP Z,_ASCTFP_10
  CP $64
  JP Z,_ASCTFP_4
  CP $44
  JP NZ,_ASCTFP_6
_ASCTFP_4:
  OR A
  CALL TO_DOUBLE
  CALL _CHRGTB
  CALL OPRND_3_5
_ASCTFP_5:
  CALL _CHRGTB
  JP C,_ASCTFP_22
  INC D
  JP NZ,_ASCTFP_6
  XOR A
  SUB E
  LD E,A
_ASCTFP_6:
  PUSH HL
  LD A,E
  SUB B
  LD E,A
_ASCTFP_7:
  CALL P,_ASCTFP_11
  CALL M,_ASCTFP_13
  JP NZ,_ASCTFP_7
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
DECIMAL:
  CALL GETYPR             ; Get number in decimal format
  INC C
  JP NZ,_ASCTFP_6
  CALL C,TO_DOUBLE
  JP _ASCTFP_0
_ASCTFP_8:
  CALL _CHRGTB
  POP AF
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  PUSH AF
  JP _ASCTFP_6
_ASCTFP_9:
  OR A
_ASCTFP_10:
  CALL TO_DOUBLE
  CALL _CHRGTB
  JP _ASCTFP_6
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
; This entry point is used by the routine at L3356.
_ASCTFP_12:
  PUSH AF
  CALL GETYPR
  PUSH AF
  CALL PO,MLSP10
  POP AF
  CALL PE,DECDIV_3
  POP AF
; This entry point is used by the routine at L3356.
DCR_A:
  DEC A
  RET
; This entry point is used by the routine at L3356.
_ASCTFP_13:
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
  RET                     ; }
_ASCTFP_DIGITS:
  PUSH DE                 ; Pick number digits
  LD A,B
  ADC A,C
  LD B,A
  PUSH BC
  PUSH HL
  LD A,(HL)
  SUB $30
  PUSH AF
  CALL GETYPR
  JP P,_ASCTFP_17
  LD HL,(FACLOW)
  LD DE,$0CCD
  CALL DCOMPR
  JP NC,_ASCTFP_16
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
  JP M,_ASCTFP_15
  LD (FACLOW),HL
_ASCTFP_14:
  POP HL
  POP BC
  POP DE
  JP _ASCTFP_0
_ASCTFP_15:
  LD A,C
  PUSH AF
_ASCTFP_16:
  CALL INT_CSNG
  SCF
_ASCTFP_17:
  JP NC,_ASCTFP_19
  LD BC,$9474
  LD DE,$2400
  CALL FCOMP
  JP P,_ASCTFP_18
  CALL MLSP10
  POP AF
  CALL _ASCTFP_20
  JP _ASCTFP_14
_ASCTFP_18:
  CALL ZERO_FACCU
_ASCTFP_19:
  CALL DECDIV_3
  CALL FP_ARG2HL
  POP AF
  CALL FLGREL
  CALL ZERO_FACCU
  CALL DECADD
  JP _ASCTFP_14
_ASCTFP_20:
  CALL STAKFP
  CALL FLGREL
; This entry point is used by the routine at IADD.
_ASCTFP_21:
  POP BC
  POP DE
  JP FADD
_ASCTFP_22:
  LD A,E
  CP $0A
  JP NC,_ASCTFP_23
  RLCA
  RLCA
  ADD A,E
  RLCA
  ADD A,(HL)
  SUB $30
  LD E,A                  ; }
  DEFB $FA                ; JP M,nn  to mask the next 2 bytes
_ASCTFP_23:
  LD E,$7F
  JP _ASCTFP_5
; This entry point is used by the routines at FDIV and DIV_OVTST1.
DIV_OVERR:
  PUSH HL
  LD HL,FACCU
  CALL GETYPR
  JP PO,_ASCTFP_24
  LD A,(DBL_LAST_FPREG)
  JP _ASCTFP_25
_ASCTFP_24:
  LD A,C
_ASCTFP_25:
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
  LD A,(FACCU)
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
DZERR:
  OR B
  JP Z,DECDIV_SUB_0
  LD A,C
  JP DECDIV_SUB_0

; Division (exponent is 0)
;
; Used by the routine at DECDIV.
DECDIV_SUB:
  LD A,(FACCU)
; This entry point is used by the routines at OVERR and NEGAFT.
DECDIV_SUB_0:
  RLA
  LD HL,DIV0_MSG
  LD (MATH_ERRTXT),HL
; This entry point is used by the routines at _ASCTFP and OVERR.
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
  CALL __OPTION_0
  LD (TTYPOS),A
  LD A,$0D
  CALL LPTOUT_SAFE
  LD A,$0A
  CALL LPTOUT_SAFE
DECDIV_SUB_3:
  POP AF
  LD HL,FACLOW
  LD DE,DECDIV_CONST
  JP NC,DECDIV_SUB_4
  LD DE,DECDIV_CONST2
DECDIV_SUB_4:
  CALL LOADFP_1
  CALL GETYPR
  JP C,DECDIV_SUB_5
  LD HL,$0C00
  LD DE,DECDIV_CONST2
  CALL LOADFP_1
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
; Used by the routines at _ERROR_REPORT and LINE2PTR.
LNUM_MSG:
  PUSH HL
  LD HL,IN_MSG
  CALL PRS
  POP HL
; This entry point is used by the routines at PROMPT, L12AA, __LIST, LINE2PTR,
; __EDIT and L5F1A.
_PRNUM:
  LD BC,PRNUMS
  PUSH BC
  CALL INT_RESULT_HL
  XOR A
  CALL PUFOUT_7
  OR (HL)
  JP PUFOUT_1

; Convert number/expression to string (format not specified)
;
; Used by the routines at __PRINT, __LIST, L3356, L45C9 and __STR_S.
FOUT:
  XOR A

; Convert number/expression to string ("PRINT USING" format specified in 'A'
; register)
;
; Used by the routine at L5256.
PUFOUT:
  CALL PUFOUT_7
  AND $08
  JP Z,PUFOUT_0
  LD (HL),$2B
PUFOUT_0:
  EX DE,HL
  CALL _TSTSGN
  EX DE,HL
  JP P,PUFOUT_1
  LD (HL),$2D
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H
; This entry point is used by the routine at LNUM_MSG.
PUFOUT_1:
  INC HL
  LD (HL),$30
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,PUFOUT_26
  JP Z,PUFOUT_25
  CP $04
  JP NC,PUFOUT_8
  LD BC,$0000
  CALL L3356_49
PUFOUT_2:
  LD HL,$0C16
  LD B,(HL)
  LD C,$20
  LD A,(TEMP3)
  LD E,A
  AND $20
  JP Z,PUFOUT_3
  LD A,B
  CP C
  LD C,$2A
  JP NZ,PUFOUT_3
  LD A,E
  AND $04
  JP NZ,PUFOUT_3
  LD B,C
PUFOUT_3:
  LD (HL),C
  CALL _CHRGTB
  JP Z,PUFOUT_4
  CP $45
  JP Z,PUFOUT_4
  CP $44
  JP Z,PUFOUT_4
  CP $30
  JP Z,PUFOUT_3
  CP $2C
  JP Z,PUFOUT_3
  CP $2E
  JP NZ,PUFOUT_5
PUFOUT_4:
  DEC HL
  LD (HL),$30
PUFOUT_5:
  LD A,E
  AND $10
  JP Z,PUFOUT_6
  DEC HL
  LD (HL),$24
PUFOUT_6:
  LD A,E
  AND $04
  RET NZ
  DEC HL
  LD (HL),B
  RET
; This entry point is used by the routine at LNUM_MSG.
PUFOUT_7:
  LD (TEMP3),A
  LD HL,$0C16
  LD (HL),$20
  RET
PUFOUT_8:
  CALL STAKFP
  EX DE,HL
  LD HL,($0C00)
  PUSH HL
  LD HL,($0C02)
  PUSH HL
  EX DE,HL
  PUSH AF
  XOR A
  LD ($0C0B),A
  POP AF
  PUSH AF
  CALL PUFOUT_20
  LD B,$45
  LD C,$00
PUFOUT_9:
  PUSH HL
  LD A,(HL)
PUFOUT_10:
  CP B
  JP Z,PUFOUT_13
  CP $3A
  JP NC,PUFOUT_11
  CP $30
  JP C,PUFOUT_11
  INC C
PUFOUT_11:
  INC HL
  LD A,(HL)
  OR A
  JP NZ,PUFOUT_10
  LD A,$44
  CP B
  LD B,A
  POP HL
  LD C,$00
  JP NZ,PUFOUT_9
PUFOUT_12:
  POP AF
  POP BC
  POP DE
  EX DE,HL
  LD ($0C00),HL
  LD H,B
  LD L,C
  LD ($0C02),HL
  EX DE,HL
  POP BC
  POP DE
  RET
PUFOUT_13:
  PUSH BC
  LD B,$00
  INC HL
  LD A,(HL)
PUFOUT_14:
  CP $2B
  JP Z,PUFOUT_18
  CP $2D
  JP Z,PUFOUT_15
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
  JP NC,PUFOUT_18
PUFOUT_15:
  INC HL
  LD A,(HL)
  OR A
  JP NZ,PUFOUT_14
  LD H,B
  POP BC
  LD A,B
  CP $45
  JP NZ,PUFOUT_17
  LD A,C
  ADD A,H
  CP $09
  POP HL
  JP NC,PUFOUT_12
PUFOUT_16:
  LD A,$80
  LD ($0C0B),A
  JP PUFOUT_19
PUFOUT_17:
  LD A,H
  ADD A,C
  CP $12
  POP HL
  JP NC,PUFOUT_12
  JP PUFOUT_16
PUFOUT_18:
  POP BC
  POP HL
  JP PUFOUT_12
PUFOUT_19:
  POP AF
  POP BC
  POP DE
  EX DE,HL
  LD ($0C00),HL
  LD H,B
  LD L,C
  LD ($0C02),HL
  EX DE,HL
  POP BC
  POP DE
  CALL FPBCDE
  INC HL
PUFOUT_20:
  CP $05
  PUSH HL
  SBC A,$00
  RLA
  LD D,A
  INC D
  CALL L3356_17
  LD BC,$0300
  PUSH AF
  LD A,($0C0B)
  OR A
  JP P,PUFOUT_21
  POP AF
  ADD A,D
  JP PUFOUT_22
PUFOUT_21:
  POP AF
  ADD A,D
  JP M,PUFOUT_23
  INC D
  CP D
  JP NC,PUFOUT_23
PUFOUT_22:
  INC A
  LD B,A
  LD A,$02
PUFOUT_23:
  SUB $02
  POP HL
  PUSH AF
  CALL L3356_36
  LD (HL),$30
  CALL Z,INCHL
  CALL L3356_42
SUPTLZ:
  DEC HL
  LD A,(HL)
  CP $30
  JP Z,SUPTLZ
  CP $2E
  CALL NZ,INCHL
  POP AF
  JP Z,NOENED
; This entry point is used by the routine at L3356.
PUFOUT_24:
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
OUTEXP:
  LD B,$2F
EXPTEN:
  INC B
  SUB $0A
  JP NC,EXPTEN
  ADD A,$3A
  INC HL
  LD (HL),B
  INC HL
  LD (HL),A
PUFOUT_25:
  INC HL
NOENED:
  LD (HL),$00
  EX DE,HL
  LD HL,$0C16
  RET
PUFOUT_26:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,L3356_1
  RRA
  JP C,L3356_11
  LD BC,$0603
  CALL L3356_35
  POP DE
  LD A,D
  SUB $05
  CALL P,L3356_28
  CALL L3356_49
; This entry point is used by the routine at L3356.
PUFOUT_27:
  LD A,E
  OR A
  CALL Z,DCXH
  DEC A
  CALL P,L3356_28
; This entry point is used by the routine at L3356.
PUFOUT_28:
  PUSH HL
  CALL PUFOUT_2
  POP HL
  JP Z,PUFOUT_29
  LD (HL),B
  INC HL
PUFOUT_29:
  LD (HL),$00
  LD HL,FBUFFR
PUFOUT_30:
  INC HL
; This entry point is used by the routine at L3356.
PUFOUT_31:
  LD A,(NXTOPR)
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP $20
  JP Z,PUFOUT_30
  CP $2A
  JP Z,PUFOUT_30
  DEC HL
  PUSH HL
  PUSH AF
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; Routine at 13112
L3338:
  LD (HL),$33
  PUSH BC
  CALL _CHRGTB
  CP $2D
  RET Z
  CP $2B
  RET Z
  CP $24
  RET Z
  POP BC
  CP $30
  JP NZ,L3356_0
  INC HL
  CALL _CHRGTB
  JP NC,L3356_0
  DEC HL
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; Routine at 13142
L3356:
  DEC HL
  LD (HL),A
  POP AF
  JP Z,L3356
  POP BC
  JP PUFOUT_31
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
  CALL ICOMP_1
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
  LD BC,$B60E
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
  CALL P,L3356_28
  CALL L3356_33
  CALL L3356_42
  OR E
  CALL NZ,L3356_32
  OR E
  CALL NZ,L3356_38
  POP DE
  JP PUFOUT_27
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
  CALL M,_ASCTFP_13
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
  CALL P,L3356_28
  PUSH BC
  CALL L3356_33
  JP L3356_9
L3356_8:
  CALL L3356_28
  LD A,C
  CALL L3356_40
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL L3356_28
  PUSH BC
  LD B,A
  LD C,A
L3356_9:
  CALL L3356_42
  POP BC
  OR C
  JP NZ,L3356_10
  LD HL,(NXTOPR)
L3356_10:
  ADD A,E
  DEC A
  CALL P,L3356_28
  LD D,B
  JP PUFOUT_28
; This entry point is used by the routine at PUFOUT.
L3356_11:
  PUSH HL
  PUSH DE
  CALL INT_CSNG
  POP DE
  XOR A
L3356_12:
  JP Z,$3412
  LD E,$10
  LD BC,$061E
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
  CALL M,_ASCTFP_13
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
  CALL L3356_42
  POP AF
  CALL P,L3356_30
  CALL L3356_38
  POP BC
  POP AF
  JP NZ,L3356_15
  CALL DCXH
  LD A,(HL)
  CP $2E
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
  CALL PUFOUT_24
  EX DE,HL
  POP DE
  JP PUFOUT_28
; This entry point is used by the routine at PUFOUT.
L3356_17:
  PUSH DE
  XOR A
  PUSH AF
  CALL GETYPR
  JP PO,L3356_19
L3356_18:
  LD A,(FPEXP)
  CP $91
  JP NC,L3356_19
  LD DE,TAB_3608
  LD HL,FPARG
  CALL FP2HL
  CALL DECMUL
  POP AF
  SUB $0A
  PUSH AF
  JP L3356_18
L3356_19:
  CALL L3356_25
L3356_20:
  CALL GETYPR
  JP PE,L3356_21
  LD BC,$9143
  LD DE,$4FF9
  CALL FCOMP
  JP L3356_22
L3356_21:
  LD DE,TAB_3610
  CALL ICOMP_1
L3356_22:
  JP P,L3356_24
  POP AF
  CALL _ASCTFP_12
  PUSH AF
  JP L3356_20
L3356_23:
  POP AF
  CALL _ASCTFP_13
  PUSH AF
  CALL L3356_25
L3356_24:
  POP AF
  OR A
  POP DE
  RET
L3356_25:
  CALL GETYPR
  JP PE,L3356_26
  LD BC,$9474
  LD DE,$23F8
  CALL FCOMP
  JP L3356_27
L3356_26:
  LD DE,TAB_3618
  CALL ICOMP_1
L3356_27:
  POP HL
  JP P,L3356_23
  JP (HL)
; This entry point is used by the routine at PUFOUT.
L3356_28:
  OR A
L3356_29:
  RET Z
  DEC A
  LD (HL),$30
  INC HL
  JP L3356_29
L3356_30:
  JP NZ,L3356_32
L3356_31:
  RET Z
  CALL L3356_38
L3356_32:
  LD (HL),$30
  INC HL
  DEC A
  JP L3356_31
L3356_33:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
L3356_34:
  SUB $03
  JP NC,L3356_34
  ADD A,$05
  LD C,A
; This entry point is used by the routine at PUFOUT.
L3356_35:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET
; This entry point is used by the routine at PUFOUT.
L3356_36:
  DEC B
  JP P,L3356_39
  LD (NXTOPR),HL
  LD (HL),$2E
L3356_37:
  INC HL
  LD (HL),$30
  INC B
  JP NZ,L3356_37
  INC HL
  LD C,B
  RET
L3356_38:
  DEC B
L3356_39:
  JP NZ,L3356_41
L3356_40:
  LD (HL),$2E
  LD (NXTOPR),HL
  INC HL
  LD C,B
  RET
L3356_41:
  DEC C
  RET NZ
  LD (HL),$2C
  INC HL
  LD C,$03
  RET
; This entry point is used by the routine at PUFOUT.
L3356_42:
  PUSH DE
  CALL GETYPR
  JP PO,L3356_45
  PUSH BC
  PUSH HL
  CALL FP_ARG2HL
  LD HL,FP_3620_FPZERO
  CALL FP_HL2DE
  CALL DECADD
  XOR A
  CALL INT_4
  POP HL
  POP BC
  LD DE,TAB_3630
  LD A,$0A
L3356_43:
  CALL L3356_38
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  LD B,$2F
L3356_44:
  INC B
  POP HL
  PUSH HL
  LD A,$9E
  CALL DECADD_15
  JP NC,L3356_44
  POP HL
  LD A,$8E
  CALL DECADD_15
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,L3356_43
  PUSH BC
  PUSH HL
  LD HL,$0C00
  CALL PHLTFP
  JP L3356_46
L3356_45:
  PUSH BC
  PUSH HL
  CALL ROUND
  LD A,$01
  CALL FPINT
  CALL FPBCDE
L3356_46:
  POP HL
  POP BC
  XOR A
  LD DE,POWERS_TAB
L3356_47:
  CCF
  CALL L3356_38
  PUSH BC
  PUSH AF
  PUSH HL
  PUSH DE
  CALL BCDEFP
  POP HL
  LD B,$2F
L3356_48:
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
  JP NC,L3356_48
  CALL PLUCDE
  INC HL
  CALL FPBCDE
  EX DE,HL
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  JP C,L3356_47
  INC DE
  INC DE
  LD A,$04
  JP L3356_50
; This entry point is used by the routine at PUFOUT.
L3356_49:
  PUSH DE
  LD DE,POWERS_TAB_2
  LD A,$05
L3356_50:
  CALL L3356_38
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
  LD B,$2F
L3356_51:
  INC B
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP NC,L3356_51
  ADD HL,DE
  LD (FACLOW),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,L3356_50
  CALL L3356_38
  LD (HL),A
  POP DE
  RET
TAB_3608:
  DEFB $00,$00,$00,$00,$F9,$02,$15,$A2
TAB_3610:
  DEFB $E1,$FF,$9F,$31,$A9,$5F,$63,$B2
TAB_3618:
  DEFB $FE,$FF,$03,$BF,$C9,$1B,$0E,$B6
FP_3620_FPZERO:
  DEFB $00,$00,$00,$00
FP_HALF:
  DEFB $00,$00,$00,$80
TAB_3628:
  DEFB $00,$00,$04,$BF,$C9,$1B,$0E,$B6
TAB_3630:
  DEFB $00,$80,$C6,$A4,$7E,$8D,$03,$00
  DEFB $40,$7A,$10,$F3,$5A,$00,$00,$A0
  DEFB $72,$4E,$18,$09,$00,$00,$10,$A5
  DEFB $D4,$E8,$00,$00,$00,$E8,$76,$48
  DEFB $17,$00,$00,$00,$E4,$0B,$54,$02
  DEFB $00,$00,$00,$CA,$9A,$3B,$00,$00
  DEFB $00,$00,$E1,$F5,$05,$00,$00,$00
  DEFB $80,$96,$98,$00,$00,$00,$00,$40
  DEFB $42,$0F,$00,$00,$00,$00
POWERS_TAB:
  DEFB $A0,$86,$01        ; 100000
  DEFB $10,$27,$00        ; 10000
POWERS_TAB_2:
  DEFB $10,$27,$E8        ; 100
  DEFB $03,$64,$00        ; 10
  DEFB $0A,$00,$01,$00    ; 1

; Octal string conversion
;
; Used by the routines at __LIST and __OCT_S.
OCT_STR:
  XOR A
  LD B,A
  JP NZ,$0106

; Hex string conversion
;
; Used by the routines at __LIST and __HEX_S.
HEX_STR:
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
  JP Z,HEX_STR_2
  LD C,$04
HEX_STR_0:
  ADD HL,HL
  ADC A,A
HEX_STR_1:
  ADD HL,HL
  ADC A,A
  ADD HL,HL
  ADC A,A
HEX_STR_2:
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
  ADD A,$30
  CP $3A
  JP C,HEX_STR_4
  ADD A,$07
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
; Used by the routine at __ATN.
NEGAFT:
  LD HL,NEG
  EX (SP),HL
  JP (HL)
__SQR:
  CALL STAKFP
  LD HL,FP_HALF
  CALL PHLTFP
  JP NEGAFT_0
  CALL __CSNG
NEGAFT_0:
  POP BC
  POP DE
  LD HL,DBL_ASCTFP_END_0
  PUSH HL
  LD A,$01
  LD (RESFLG),A
  CALL SIGN
  LD A,B
  JP Z,__EXP
  JP P,NEGAFT_1
  OR A
  JP Z,DECDIV_SUB_0
NEGAFT_1:
  OR A
  JP Z,SAVE_EXPONENT
  PUSH DE
  PUSH BC
  LD A,C
  OR $7F
  CALL BCDEFP
  JP P,NEGAFT_3
  PUSH AF
  LD A,(FPEXP)
  CP $99
  JP C,NEGAFT_2
  POP AF
  JP NEGAFT_3
NEGAFT_2:
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
NEGAFT_3:
  POP HL
  LD (FACCU),HL
  POP HL
  LD (FACLOW),HL
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

; label='EXP' BASIC function
;
; Used by the routine at NEGAFT.
__EXP:
  LD BC,$8138             ; BCDE = 1/Ln(2)
  LD DE,$AA3B
  CALL FMULT              ; Multiply value by 1/LN(2)
  LD A,(FPEXP)            ; Get exponent
  CP $88                  ; Is it in range?  (80H+8)
  JP NC,MUL_OVTST1
  CP $68
  JP C,GET_UNITY          ; Load '1' to FP accumulator
  CALL STAKFP             ; Put value on stack
  CALL INT                ; Get INT of FP accumulator
  ADD A,$81
  JP Z,MUL_OVTST2
  POP BC
  POP DE
  PUSH AF
  CALL FSUB               ; Subtract exponent from FP accumulator
  LD HL,FP_EXPTAB         ; Coefficient table
  CALL SUMSER_0           ; Sum the series
  POP BC                  ; Zero LSBs
  LD DE,$0000             ; Scaling factor
  LD C,D                  ; Zero MSB
  JP FMULT                ; Scale result to correct value
MUL_OVTST1:
  CALL STAKFP
MUL_OVTST2:
  LD A,(FACCU)
  OR A
  JP P,RESZER             ; Result zero
  POP AF
  POP AF
  JP ZERO_EXPONENT
RESZER:
  JP MUL_OVERR

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
; This entry point is used by the routines at __LOG and __EXP.
SUMSER_0:
  CALL STAKFP             ; Put value on stack
  LD A,(HL)               ; Get number of coefficients
  INC HL                  ; Point to start of table
  CALL PHLTFP             ; Move coefficient to FPREG
  LD B,$F1                ; Skip "POP AF"
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
  DEFB $52,$C7,$4F,$80    ; 14303

; Routine at 14307
;
; Used by the routine at OPRND_3.
L37E3:
  CALL _CHRGTB

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
  LD HL,$385F             ; Random number seed
  JP M,RESEED             ; Negative - Re-seed
  LD HL,LSTRND            ; Last random number
  CALL PHLTFP             ; Move last RND to FPREG
  LD HL,$385F             ; Random number seed
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
  LD A,($385E)            ; Get (SEED+1)
  INC A                   ; Add 1
  AND $03                 ; 0 to 3
  LD B,$00
  CP $01                  ; Is it zero?
  ADC A,B                 ; Yes - Make it 1
  LD ($385E),A            ; Re-save seed
  LD HL,LSTRND            ; (RNDTAB-4) Addition table
  ADD A,A                 ; 4 bytes
  ADD A,A                 ; per entry
  LD C,A                  ; BC = Offset into table
  ADD HL,BC               ; Point to value
  CALL FADD_HLPTR         ; Add value to FPREG
; This entry point is used by the routine at RESEED.
__RND_0:
  CALL BCDEFP             ; Move FPREG to BCDE
  LD A,E                  ; Get LSB
  LD E,C                  ; LSB = MSB
  XOR $4F                 ; Fiddle around
  LD C,A                  ; New MSB
  LD (HL),$80             ; Set exponent
  DEC HL                  ; Point to MSB
  LD B,(HL)               ; Get MSB
  LD (HL),$80             ; Make value -0.5
  LD HL,SEED              ; Random number seed
  INC (HL)                ; Count seed
  LD A,(HL)               ; Get seed
  SUB $AB                 ; Do it modulo 171
  JP NZ,__RND_1           ; Non-zero - Ok
  LD (HL),A               ; Zero seed
  INC C                   ; Fillde about
  DEC D                   ; with the
  INC E                   ; number
__RND_1:
  CALL BNORM              ; Normalise number
  LD HL,LSTRND            ; Save random number
  JP DEC_FACCU2HL         ; Move FPREG to last and return

; Re-seed random numbers
;
; Used by the routine at __RND.
RESEED:
  LD (HL),A
  DEC HL
  LD (HL),A
  DEC HL
  LD (HL),A
  JP __RND_0

; Temp storage for RND
SEED:
  DEFW $0000
  DEFW $3500

; Data block at 14433
L3861:
  DEFW $CA4A
  DEFW $3999
  DEFW $761C
  DEFW $2298
  DEFW $B395
  DEFW DSCTMP
  DEFW $47DD
  DEFW $5398

; Data block at 14448
L3870:
  DEFW $D153
  DEFW $9999
  DEFW $1A0A
  DEFW $989F
  DEFW $BC65
  DEFW $98CD
  DEFW $77D6
  DEFW $983E

; Last random number
LSTRND:
  DEFW $C752
  DEFW $804F
RNDTAB:
  DEFB $68,$B1,$46,$68,$99,$E9,$92,$69
  DEFB $10
  DEFB $D1,$75,$68

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
  LD A,(FACCU)
  OR A
  JP P,__SIN_0
  AND $7F
  LD (FACCU),A
  LD DE,NEG
  PUSH DE
__SIN_0:
  LD BC,$7E22
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
__SIN_1:
  LD A,(FACCU)
  OR A
  PUSH AF
  JP P,__SIN_2
  XOR $80
  LD (FACCU),A
__SIN_2:
  LD HL,FP_SINTAB
  CALL SUMSER
  POP AF
  RET P
  LD A,(FACCU)
  XOR $80
  LD (FACCU),A
  RET
CONST_1:
  DEFB $00,$00,$00,$00
CONST_2:
  DEFB $83,$F9,$22,$7E
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

; TAN
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
  CALL CHECK_STREAM_4
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
__EOF_3:
  LD D,B
  LD E,C
  INC DE
__EOF_4:
  LD HL,$0027
  ADD HL,BC
  PUSH BC
  XOR A
  LD (HL),A
  CALL SETDMA
  LD A,(WR_FN)
  CALL FILE_R_W
  CP $FF
  JP Z,FL_ERR
  DEC A
  JP Z,DISK_ERR
  DEC A
  JP NZ,__EOF_5
  POP DE
  XOR A
  LD (DE),A
  LD C,$10                ; BDOS function 16 - Close file
  INC DE
  CALL $0005
  JP DSK_FULL_ERR
__EOF_5:
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
; This entry point is used by the routine at __LOAD.
__EOF_6:
  CALL GET_CHNUM_4
  JP Z,__EOF_8
  PUSH BC
  LD A,(BC)
  LD D,B
  LD E,C
  INC DE
  PUSH DE
  CP $02
  JP NZ,__EOF_7
  LD HL,$3A29
  PUSH HL
  PUSH HL
  LD H,B
  LD L,C
  LD A,$1A
  JP __LOF_2
  LD HL,$0027
  ADD HL,BC
  LD A,(HL)
  OR A
  CALL NZ,__EOF_4
__EOF_7:
  POP DE
  CALL SETDMA             ; }
  LD C,$10                ; BDOS function 16 - Close file
  CALL $0005
  POP BC
__EOF_8:
  LD D,$29
  XOR A
__EOF_9:
  LD (BC),A
  INC BC
  DEC D
  JP NZ,__EOF_9
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
  JP UNSIGNED_RESULT_A
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
; This entry point is used by the routine at __EOF.
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
  LD A,($07A0)
  OR A
  JP NZ,__LOF_9
  CALL CHECK_STREAM_4
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
  CALL __EOF_3
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
  CALL CHECK_STREAM_3
  JP NZ,CHECK_STREAM_0
CHECK_STREAM_2:
  SCF
  POP HL
  POP BC
  LD A,$1A
  RET
; This entry point is used by the routine at __OPEN.
CHECK_STREAM_3:
  LD HL,(PTRFIL)
; This entry point is used by the routines at __EOF and __LOF.
CHECK_STREAM_4:
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
CHECK_STREAM_5:
  INC HL
  LD (HL),$00
  DEC C
  JP NZ,CHECK_STREAM_5
  CALL SETDMA
  LD A,(RD_FN)            ; BDOS FN code for 'READ'
  CALL FILE_R_W           ; Get next file record
  OR A
  LD A,$00
  JP NZ,CHECK_STREAM_6
  LD A,$80
CHECK_STREAM_6:
  POP HL
  LD (HL),A
  DEC HL
  LD (HL),A
  OR A
  POP DE
  RET

; Set DMA address
;
; Used by the routines at __EOF, CHECK_STREAM and __OPEN.
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
; Used by the routines at LINE_INPUT, __LOAD, __MERGE, __LSET and L4D05.
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
  LD C,(HL)
  INC HL
  LD A,(HL)
  DEC E
  CP $3A
  JP Z,FNAME_1
  DEC HL
  INC E
FNAME_0:
  DEC HL
  INC E
  LD C,$40
FNAME_1:
  DEC E
  JP Z,FNAME_10
  LD A,C
  AND $DF
  SUB $40
  JP C,FNAME_10
  CP $1B
  JP NC,FNAME_10
  LD BC,$07FE
  LD (BC),A
  INC BC
  LD D,$0B
FNAME_2:
  INC HL
FNAME_3:
  DEC E
  JP M,FNAME_8
  LD A,(HL)
  CP $2E
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
  LD HL,$080A
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
  CP $0B
  JP Z,FNAME_10
  CP $03
  JP C,FNAME_10
  RET Z
  LD A,$20
  LD (BC),A
  INC BC
  DEC D
  JP FNAME_7
FNAME_8:
  INC D
  DEC D
  JP Z,FNAME_5
FNAME_9:
  LD A,$20
  LD (BC),A
  INC BC
  DEC D
  JP NZ,FNAME_9
  JP FNAME_5
FNAME_10:
  JP NM_ERR

; 'NAME' BASIC command  (file rename)
__NAME:
  CALL FNAME
  PUSH HL
  LD DE,$0080
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  LD DE,$07FE
  LD C,$0F                ; BDOS function 15 - Open file
  CALL $0005
  INC A
  JP Z,FF_ERR
  LD HL,FCB
  LD DE,$07FE
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
  LD A,($07FE)
  LD HL,FCB
  CP (HL)
  JP NZ,FC_ERR
  LD DE,$07FE
  LD C,$0F                ; BDOS function 15 - Open file
  CALL $0005
  INC A
  JP NZ,FILE_EXISTS_ERR
  LD C,$17                ; BDOS function 23 - Rename file
  LD DE,FCB
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
  CP $4F
  JP Z,__OPEN_0
  LD D,$01
  CP $49
  JP Z,__OPEN_0
  LD D,$03
  CP $52
  JP NZ,FMODE_ERR
__OPEN_0:
  POP HL
  CALL SYNCHR
  DEFM ","
  PUSH DE
  CP $23
  CALL Z,_CHRGTB
  CALL GETINT
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
  CALL L45C9_27
  POP AF
  LD (TEMP),HL
  JP C,__OPEN_2
  LD A,E
  OR A
  JP NZ,__OPEN_2
  LD HL,$0807
  LD A,(HL)
  CP $20
  JP NZ,__OPEN_2
  LD (HL),$42
  INC HL
  LD (HL),$41
  INC HL
  LD (HL),$53
__OPEN_2:
  POP HL
  LD A,D
  PUSH AF
  LD (PTRFIL),HL
  PUSH HL
  INC HL
  LD DE,$07FE
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
  CALL CHECK_STREAM_3
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
__SYSTEM:
  RET NZ
  CALL L41C5_1
; This entry point is used by the routine at _ERROR_REPORT.
EXIT_TO_SYSTEM:
  JP $0000                ; }

; 'RESET' BASIC command
__RESET:
  RET NZ
  PUSH HL
  CALL L41C5_1
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
  LD DE,$07FE
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
  LD HL,$07FE
  LD (HL),$00
  INC HL
  LD C,$0B
  CALL FILENAME_FILL
  POP HL
__FILES_0:
  CALL NZ,FNAME
  XOR A
  LD ($080A),A
  PUSH HL
  LD HL,$07FF
  LD C,$08
  CALL FILENAME_TXT
  LD HL,$0807
  LD C,$03
  CALL FILENAME_TXT
  LD DE,$0080
  LD C,$1A                ; BDOS function 26 - Set DMA address
  CALL $0005
  LD DE,$07FE
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
  CP $20
  JP Z,__FILES_3
  LD A,$2E
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
  LD A,$20
  CALL OUTDO
  CALL OUTDO
__FILES_5:
  CALL C,OUTDO_CRLF
  LD DE,$07FE
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
  CP $2A
  RET NZ
; This entry point is used by the routine at __FILES.
FILENAME_FILL:
  LD (HL),$3F
  INC HL
  DEC C
  JP NZ,FILENAME_FILL
  RET

; File read or write operations
;
; Used by the routines at __EOF and CHECK_STREAM.
FILE_R_W:
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
  JP NZ,FILE_R_W_0
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
FILE_R_W_0:
  POP AF
  RET

; Get stream number (default #channel=1
;
; Used by the routines at SET_INPUT_CHANNEL and LINE_INPUT.
GET_CHANNEL:
  LD C,$01

; Get stream number (C=default #channel)
;
; Used by the routines at __PRINT and L45C9.
GET_CHNUM:
  CP $23
  RET NZ
  PUSH BC
  CALL GET_CHNUM_2
  POP DE
  CP E
  JP Z,GET_CHNUM_0
  CP $03
  JP NZ,FMODE_ERR
GET_CHNUM_0:
  CALL SYNCHR
  DEFM ","
; This entry point is used by the routine at __LSET.
GET_CHNUM_1:
  LD D,B
  LD E,C
  EX DE,HL
  LD (PTRFIL),HL
  EX DE,HL
  RET
; This entry point is used by the routines at __FIELD, __LSET and __GET.
GET_CHNUM_2:
  DEC HL
  CALL _CHRGTB
  CP $23
  CALL Z,_CHRGTB
  CALL EVAL
; This entry point is used by the routines at __EOF, __LOC and __LOF.
GET_CHNUM_3:
  CALL GETINT_0
; This entry point is used by the routines at __EOF and __OPEN.
GET_CHNUM_4:
  LD E,A
GET_CHNUM_5:
  LD A,(MAXFIL)
  CP E
  JP C,BN_ERR
  LD D,$00
  PUSH HL
  LD HL,HIMEM
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
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'MKS$' BASIC function
__MKS_S:
  LD A,$04
  DEFB $01                ; "LD BC,nn" to jump over the next word without
                          ; executing it

; 'MKD$' BASIC function
__MKD_S:
  LD A,$08
  PUSH AF
  CALL MAKINT_1
  POP AF
  CALL MKTMST
  LD HL,(TMPSTR)
  CALL FP_DE2HL
  JP TOPOOL

; 'CVI' BASIC function
__CVI:
  LD A,$01
  LD BC,$033E

; 'CVS' BASIC function
__CVS:
  LD A,$03
  LD BC,$073E

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
  CP $20
  JP NZ,LINE_INPUT_2
  INC D
  DEC D
  JP NZ,LINE_INPUT_1
LINE_INPUT_2:
  CP $22
  JP NZ,LINE_INPUT_3
  LD A,E
  CP $2C
  LD A,$22
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
  CP $22
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
  CP $20
  JP Z,LINE_INPUT_6
  CP $2C
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
  CP $22
  JP Z,LINE_INPUT_8
  CP $20
  JP NZ,NOSKCR
LINE_INPUT_8:
  CALL RDBYT
  JP C,NOSKCR
  CP $20
  JP Z,LINE_INPUT_8
  CP $2C
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
  CALL _CHRGTB
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
; This entry point is used by the routines at ATOH and __FRE.
_RUN_FILE:
  OR $AF

; 'LOAD' BASIC command
__LOAD:
  XOR A
  PUSH AF
  CALL FILE_OPENIN
  LD A,(MAXFIL)
  LD ($079F),A
  DEC HL
  CALL _CHRGTB
  JP Z,LOAD1
  CALL SYNCHR
  DEFM ","
  CALL SYNCHR
  DEFM "R"
  JP NZ,SN_ERR
  POP AF
; This entry point is used by the routine at L45C9.
_LOAD:
  XOR A
  LD (MAXFIL),A
  OR $F1
LOAD1:
  POP AF
  LD ($079E),A
  LD HL,$0080
  LD (HL),$00
  LD (HIMEM),HL
  CALL CLRPTR
  LD A,($079F)
  LD (MAXFIL),A
  LD HL,(FILTAB)
  LD (HIMEM),HL
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
  JP C,__LOAD_5
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
  LD ($079F),A
  LD (HL),$00
  CALL RUN_FST
  LD A,($079F)
  LD (MAXFIL),A
  LD A,(ERRTRP)
  OR A
  JP NZ,L45C9_16
  LD A,($079E)
  OR A
  JP Z,READY
  JP EXEC_EVAL
; This entry point is used by the routines at READY, __MERGE and L4D05.
__LOAD_4:
  CALL FINPRT
  CALL __EOF_6
  JP WARM_ENTRY_0
__LOAD_5:
  CALL CLRPTR
  JP OM_ERR

; 'MERGE' BASIC command
__MERGE:
  POP BC
  CALL FILE_OPENIN
  DEC HL
  CALL _CHRGTB
  JP Z,__MERGE_0
  CALL __LOAD_4
  JP SN_ERR
; This entry point is used by the routine at L45C9.
__MERGE_0:
  XOR A
  LD ($079E),A
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
  CALL _CHRGTB
  JP Z,__MERGE_3
  CALL SYNCHR
  DEFM ","
  CP $50
  JP Z,__GET_29
  CALL SYNCHR
  DEFM "A"
  JP __LIST
__MERGE_3:
  CALL L23A9
  CALL __GET_37
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
  JP Z,__LOAD_4
  LD A,(HL)
  INC HL
  PUSH DE
  CALL __LOF_1
  POP DE
  JP __MERGE_5

; 'CLOSE' BASIC command
;
; Used by the routine at L41C5.
__CLOSE:
  LD BC,__EOF_6
  LD A,(MAXFIL)
  JP NZ,L41C5_0
  PUSH HL
; This entry point is used by the routine at L41BD.
__CLOSE_0:
  PUSH BC
  PUSH AF
  LD DE,L41BD
  PUSH DE
  PUSH BC
  RET

; Routine at 16829
L41BD:
  POP AF
  POP BC
  DEC A
  JP P,__CLOSE_0
  POP HL
  RET

; Routine at 16837
L41C5:
  POP BC
  POP HL
  LD A,(HL)
  CP $2C
  RET NZ
  CALL _CHRGTB
; This entry point is used by the routine at __CLOSE.
L41C5_0:
  PUSH BC
  LD A,(HL)
  CP $23
  CALL Z,_CHRGTB
  CALL GETINT
  EX (SP),HL
  PUSH HL
  LD DE,L41C5
  PUSH DE
  JP (HL)
; This entry point is used by the routines at __OPEN, __RESET, CHKSTK, __NEW
; and __END.
L41C5_1:
  PUSH DE
  PUSH BC
  XOR A
  CALL __CLOSE
  POP BC
  POP DE
  XOR A
  RET

; 'FIELD' BASIC command
__FIELD:
  CALL GET_CHNUM_2
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
  LD (L4AC5),HL
  LD A,H
  EX DE,HL
  LD DE,$00B2
__FIELD_0:
  EX DE,HL
  ADD HL,BC
  LD B,A
  EX DE,HL
  LD A,(HL)
  CP $2C
  RET NZ
  PUSH DE
  PUSH BC
  CALL FNDNUM
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
  LD HL,(L4AC5)
  LD B,$00
  ADD HL,BC
  LD (L4AC5),HL
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
  JP __FIELD_0

; 'RSET' BASIC command
__RSET:
  OR $37

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
  LD A,$20
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
; This entry point is used by the routine at OPRND_MORE.
FN_INPUT:
  CALL _CHRGTB
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
  CALL GETINT
  PUSH DE
  LD A,(HL)
  CP $2C
  JP NZ,__LSET_10
  CALL _CHRGTB
  CALL GET_CHNUM_2
  CP $02
  JP Z,FMODE_ERR
  CALL GET_CHNUM_1
  XOR A
__LSET_10:
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
__LSET_11:
  POP AF
  PUSH AF
  JP Z,__LSET_15
  CALL L4DC7_2
  JP NZ,__LSET_12
  CALL GETINP
__LSET_12:
  CP $03
  JP Z,__LSET_14
__LSET_13:
  LD (HL),A
  INC HL
  DEC C
  JP NZ,__LSET_11
  POP AF
  POP BC
  POP HL
  LD (PTRFIL),HL
  PUSH BC
  JP TSTOPL
__LSET_14:
  LD HL,(SAVSTK)
  LD SP,HL
  JP _ENDPRG
__LSET_15:
  CALL RDBYT
  JP C,EF_ERR
  JP __LSET_13

; 'WHILE' BASIC instruction
__WHILE:
  LD (ENDFOR),HL
  CALL LOOK_FOR_WEND
  CALL _CHRGTB
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
  LD BC,$00B4
  LD B,C
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
  LD BC,$0082
  CP C
  JP NZ,__WEND_4
  LD BC,$0012
  ADD HL,BC
  JP __WEND_3
__WEND_4:
  LD BC,$00B4
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
  LD DE,$001E
  JP ERROR

; 'CALL' BASIC command
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
  LD C,$20
  CALL CHKSTK
  POP DE
  LD HL,$FFC0
  ADD HL,SP
  LD SP,HL
  EX DE,HL
  LD C,$20
  DEC HL
  CALL _CHRGTB
  LD (TEMP),HL
  JP Z,__CALL_2
  CALL SYNCHR
  DEFM "("
__CALL_0:
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
  CP $2C
  JP NZ,__CALL_1
  DEC C
  CALL _CHRGTB
  JP __CALL_0
__CALL_1:
  CALL SYNCHR
  DEFM ")"
  LD (TEMP),HL
  LD A,$21
  SUB C
  POP HL
  DEC A
  JP Z,__CALL_2
  POP DE
  DEC A
  JP Z,__CALL_2
  POP BC
  DEC A
  JP Z,__CALL_2
  PUSH BC
  PUSH HL
  LD HL,$0002
  ADD HL,SP
  LD B,H
  LD C,L
  POP HL
__CALL_2:
  PUSH HL
  LD HL,$4482
  EX (SP),HL
  PUSH HL
  LD HL,(INTFLG)
  EX (SP),HL
  RET
  LD HL,(SAVSTK)
  LD SP,HL
  LD HL,(TEMP)
  JP EXEC_EVAL

; 'CHAIN' BASIC command
__CHAIN:
  XOR A
  LD (NLONLY),A
  LD ($0BEE),A
  LD A,(HL)
  LD DE,$00C5             ; d=0, e=TK_MERGE
  CP E
  JP NZ,__CHAIN_0
  LD (NLONLY),A
  INC HL
__CHAIN_0:
  DEC HL
  CALL _CHRGTB
  CALL FILE_OPENIN
  PUSH HL
  LD HL,$0000
  LD ($0BF4),HL
  POP HL
  DEC HL
  CALL _CHRGTB
  JP Z,__CHAIN_4
  CALL SYNCHR
  DEFM ","
  CP $2C
  JP Z,__CHAIN_1
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  LD ($0BF4),HL
  POP HL
  DEC HL
  CALL _CHRGTB
  JP Z,__CHAIN_4
__CHAIN_1:
  CALL SYNCHR
  DEFM ","
  LD DE,$00AA
  CP E
  JP Z,__CHAIN_2
  CALL SYNCHR
  DEFM "A"
  CALL SYNCHR
  DEFM "L"
  CALL SYNCHR
  DEFM "L"
  JP Z,L45C9_8
  CALL SYNCHR
  DEFM ","
  CP E
  JP NZ,SN_ERR
  OR A
__CHAIN_2:
  PUSH AF
  LD ($0BEE),A
  CALL _CHRGTB
  CALL LNUM_RANGE
  PUSH BC
  CALL LINE2PTR_7
  POP BC
  POP DE
  PUSH BC
  LD H,B
  LD L,C
  LD ($0BF1),HL
  CALL SRCHLP
  JP NC,__CHAIN_3
  LD D,H
  LD E,L
  LD ($0BEF),HL
  POP HL
  CALL DCOMPR
__CHAIN_3:
  JP NC,FC_ERR
  POP AF
  JP NZ,L45C9_8
__CHAIN_4:
  LD HL,(CURLIN)
  PUSH HL
  LD HL,(TXTTAB)
  DEC HL
__CHAIN_5:
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
__CHAIN_6:
  CALL _CHRGTB
; This entry point is used by the routine at L45C9.
__CHAIN_7:
  OR A
  JP Z,__CHAIN_5
  CP $3A
  JP Z,__CHAIN_6
  LD DE,$00B8             ; d=0, e=TK_COMMON
  CP E
  JP Z,__CHAIN_8
  CALL _CHRGTB
  CALL __DATA
  DEC HL
  JP __CHAIN_6
__CHAIN_8:
  CALL _CHRGTB
  JP Z,__CHAIN_7
; This entry point is used by the routine at L45C9.
__CHAIN_9:
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
  JP NZ,__CHAIN_10
  LD A,(HL)
  CP $28
  JP NZ,__CHAIN_11
  POP AF
  JP L45C9_0
__CHAIN_10:
  LD A,(HL)
  CP $28
  JP Z,FC_ERR
; This entry point is used by the routine at L45A2.
__CHAIN_11:
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
  JP NSCFOR               ; }

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
  CP $28
  JP NZ,__CHAIN_11
  EX (SP),HL
  DEC BC
  DEC BC
  CALL L45A2_1

; Routine at 17865
L45C9:
  POP HL
  DEC HL
  CALL _CHRGTB
  JP Z,__CHAIN_7
  CP $28
  JP NZ,L45C9_1
; This entry point is used by the routine at __CHAIN.
L45C9_0:
  CALL _CHRGTB
  CALL SYNCHR
  DEFM ")"
  JP Z,__CHAIN_7
L45C9_1:
  CALL SYNCHR
  DEFM ","
  JP __CHAIN_9
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
  CALL ZERARY_3
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
  JP Z,L45C9_8
  PUSH HL
  INC HL
  INC HL
  LD A,(HL)
  OR A
  PUSH AF
  AND $7F
  LD (HL),A
  INC HL
  CALL ZERARY_3
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
; This entry point is used by the routine at __CHAIN.
L45C9_8:
  LD HL,(VARTAB)
L45C9_9:
  EX DE,HL
  LD HL,(ARYTAB)
  EX DE,HL
  CALL DCOMPR
  JP Z,L45C9_12
  CALL L45C9_18
  JP NZ,L45C9_10
  CALL L45C9_13
  XOR A
L45C9_10:
  LD E,A
  LD D,$00
  ADD HL,DE
  JP L45C9_9
L45C9_11:
  POP BC
L45C9_12:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  CALL DCOMPR
  JP Z,L45C9_14
  CALL L45C9_18
  PUSH AF
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  POP AF
  PUSH HL
  ADD HL,BC
  CP $03
  JP NZ,L45C9_11
  LD (TEMP3),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL
  EX DE,HL
  LD HL,(TEMP3)
  EX DE,HL
  CALL DCOMPR
  JP Z,L45C9_12
  LD BC,$46AB
  PUSH BC
L45C9_13:
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
L45C9_14:
  CALL TESTR_2
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
  LD ($0BE8),HL
  CALL EDIT_DONE_4
  LD H,B
  LD L,C
  DEC HL
  LD (FRETOP),HL
  LD A,($0BEE)
  OR A
  JP Z,L45C9_15
  LD HL,($0BF1)
  LD B,H
  LD C,L
  LD HL,($0BEF)
  CALL __DELETE_0
  LD (ARYTAB),HL
  LD (STREND),HL
  CALL UPD_PTRS
L45C9_15:
  LD A,$01
  LD (ERRTRP),A
  LD A,(NLONLY)
  OR A
  JP NZ,__MERGE_0
  LD A,(MAXFIL)
  LD ($079F),A
  JP _LOAD
; This entry point is used by the routines at __LOAD and L4D05.
L45C9_16:
  XOR A
  LD (ERRTRP),A
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
  LD HL,($0BE8)
  LD (FRETOP),HL
L45C9_17:
  CALL DCOMPR
  LD A,(DE)
  LD (BC),A
  INC DE
  INC BC
  JP NZ,L45C9_17
  DEC BC
  LD H,B
  LD L,C
  LD (STREND),HL
  EX DE,HL
  LD HL,($0BF4)
  EX DE,HL
  LD HL,(TXTTAB)
  DEC HL
  LD A,D
  OR E
  JP Z,EXEC_EVAL
  CALL SRCHLP
  JP NC,UL_ERR
  DEC BC
  LD H,B
  LD L,C
  JP EXEC_EVAL
L45C9_18:
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  PUSH AF
  CALL ZERARY_3
  POP AF
  CP $03
  RET
  JP __DATA
__WRITE:
  LD C,$02
  CALL GET_CHNUM
  DEC HL
  CALL _CHRGTB
  JP Z,L45C9_24
L45C9_19:
  CALL EVAL
  PUSH HL
  CALL GETYPR
  JP Z,L45C9_23
  CALL FOUT
  CALL CRTST
  LD HL,(FACLOW)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  CP $20
  JP NZ,L45C9_20
  INC DE
  LD (HL),D
  DEC HL
  LD (HL),E
  DEC HL
  DEC (HL)
L45C9_20:
  CALL PRS1
L45C9_21:
  POP HL
  DEC HL
  CALL _CHRGTB
  JP Z,L45C9_24
  CP $3B
  JP Z,L45C9_22
  CALL SYNCHR
  DEFM ","
  DEC HL
L45C9_22:
  CALL _CHRGTB
  LD A,$2C
  CALL OUTDO
  JP L45C9_19
L45C9_23:
  LD A,$22
  CALL OUTDO
  CALL PRS1
  LD A,$22
  CALL OUTDO
  JP L45C9_21
L45C9_24:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  JP Z,L45C9_26
  LD A,(HL)
  CP $03
  JP NZ,L45C9_26
  CALL __GET_27
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD DE,$FFFE
  ADD HL,DE
  JP NC,L45C9_26
L45C9_25:
  LD A,$20
  CALL OUTDO
  DEC HL
  LD A,H
  OR L
  JP NZ,L45C9_25
L45C9_26:
  POP HL
  CALL OUTDO_CRLF
  JP FINPRT
; This entry point is used by the routine at __OPEN.
L45C9_27:
  CP $03
  RET NZ
  DEC HL
  CALL _CHRGTB
  PUSH DE
  LD DE,$0080
  JP Z,L45C9_28
  PUSH BC
  CALL GET_POSINT
  POP BC
L45C9_28:
  PUSH HL
  LD HL,($0BEA)
  CALL DCOMPR
  JP C,FC_ERR
  LD HL,$00A9
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  XOR A
  LD E,$07
L45C9_29:
  INC HL
  LD (HL),A
  DEC E
  JP NZ,L45C9_29
  POP HL
  POP DE
  RET

; 'PUT' BASIC command
__PUT:
  DEFB $F6                ; OR $AF  masking the next instruction

; 'GET' BASIC command
__GET:
  XOR A
  LD (L4ACB),A
  CALL GET_CHNUM_2
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
  CP $2C
  CALL Z,GET_POSINT
  DEC HL
  CALL _CHRGTB
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
  LD HL,$00B0
  ADD HL,BC
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD HL,$00A9
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
  LD (L4AC5),HL
  POP HL
  POP BC
  PUSH HL
  LD HL,$00B2
  ADD HL,BC
  LD (L4AC7),HL
__GET_8:
  LD HL,$0029
  ADD HL,BC
  ADD HL,DE
  LD (L4AC9),HL
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
  LD A,(L4ACB)
  OR A
  JP Z,__GET_12
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
  LD HL,(L4AC9)
  EX DE,HL
  LD HL,(L4AC7)
  CALL __GET_17
  LD (L4AC7),HL
  LD D,B
  LD E,C
  POP BC
  CALL __GET_13
__GET_11:
  LD HL,(L4AC5)
  INC HL
  LD (L4AC5),HL
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
  LD HL,(L4AC7)
  EX DE,HL
  LD HL,(L4AC9)
  CALL __GET_17
  EX DE,HL
  LD (L4AC7),HL
  LD D,B
  LD E,C
  POP BC
  JP __GET_11
__GET_13:
  DEFB $F6                ; "OR n" to Mask 'XOR A'
__GET_14:
  XOR A
  LD ($07A0),A
  PUSH BC
  PUSH DE
  PUSH HL
  EX DE,HL
  LD HL,(L4AC5)
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
  LD A,($07A0)
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
  LD HL,$00B1
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
  LD HL,$00B1
  ADD HL,BC
  ADD HL,DE
  LD A,(HL)
  OR A
  POP DE
  POP HL
  POP BC
  RET
__GET_23:
  LD HL,$00A9
  JP __GET_25
__GET_24:
  LD HL,$00B0
__GET_25:
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  RET
__GET_26:
  INC DE
  LD HL,$00B0
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  RET
; This entry point is used by the routine at L45C9.
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
  CALL _CHRGTB
  LD (TEMP),HL
  CALL L23A9
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
__GET_36:
  PUSH HL
  LD HL,(CURLIN)
  LD A,H
  AND L
  POP HL
  INC A
  RET NZ
; This entry point is used by the routines at PROMPT, __LIST and __MERGE.
__GET_37:
  PUSH AF
  LD A,(FILFLG)
  OR A
  JP NZ,FC_ERR
  POP AF
  RET

; Data block at 19141
L4AC5:
  DEFW $0000

; Data block at 19143
L4AC7:
  DEFW $0000

; Data block at 19145
L4AC9:
  DEFW $0000

; Data block at 19147
L4ACB:
  DEFW $3E00

; Question (print '?' before a line input)
;
; Used by the routine at __RANDOMIZE.
QINLIN:
  LD A,$3F
  CALL OUTDO
  LD A,$20
  CALL OUTDO
  JP PINLIN
; This entry point is used by the routine at PINLIN.
QINLIN_0:
  CALL L4D05_0
  CP $01
  JP NZ,PINLIN_7
  LD (HL),$00
  JP PINLIN_1
; This entry point is used by the routine at PINLIN.
QINLIN_1:
  LD (HL),B

; Line input (aka RINPUT)
;
; Used by the routines at PROMPT and QINLIN.
PINLIN:
  XOR A
  LD (CTLCFG),A
  XOR A
  LD (INTFLG),A
; This entry point is used by the routines at __LINE and INPUT_SUB.
PINLIN_0:
  CALL L4D05_0
  CP $01
  JP NZ,PINLIN_6
; This entry point is used by the routine at QINLIN.
PINLIN_1:
  CALL OUTDO_CRLF
  LD HL,$FFFF
  JP __EDIT_3
PINLIN_2:
  LD A,($0792)
  OR A
  LD A,$5C
  LD ($0792),A
  JP NZ,PINLIN_3
  DEC B
  JP Z,QINLIN_1
  CALL OUTDO
  INC B
PINLIN_3:
  DEC HL
  DEC B
  JP Z,PINLIN_5
  LD A,(HL)
  CALL OUTDO
  JP QINLIN_0
  DEC B
PINLIN_4:
  DEC HL
  CALL OUTDO
  JP NZ,QINLIN_0
PINLIN_5:
  CALL OUTDO
  CALL OUTDO_CRLF
PINLIN_6:
  LD HL,BUF
  LD B,$01
  PUSH AF
  XOR A
  LD ($0792),A
  POP AF
; This entry point is used by the routine at QINLIN.
PINLIN_7:
  LD C,A
  CP $7F
  JP Z,PINLIN_2
  LD A,($0792)
  OR A
  JP Z,PINLIN_8
  LD A,$5C
  CALL OUTDO
  XOR A
  LD ($0792),A
PINLIN_8:
  LD A,C
  CP $07
  JP Z,PINLIN_13
  CP $03
  CALL Z,INPBRK_1
  SCF
  RET Z
  CP $0D
  JP Z,PINLIN_17
  CP $09
  JP Z,PINLIN_13
  CP $0A
  JP NZ,PINLIN_9
  DEC B
  JP Z,PINLIN
  INC B
  JP PINLIN_13
PINLIN_9:
  CP $15
  CALL Z,INPBRK_1
  JP Z,PINLIN
  CP $08
  JP NZ,PINLIN_10
  DEC B
  JP Z,PINLIN_0
  CALL OUTDO
  LD A,$20
  CALL OUTDO
  LD A,$08
  JP PINLIN_4
PINLIN_10:
  CP $18
  JP NZ,PINLIN_11
  LD A,$23
  JP PINLIN_5
PINLIN_11:
  CP $12
  JP NZ,PINLIN_12
  PUSH BC
  PUSH DE
  PUSH HL
  LD (HL),$00
  CALL OUTDO_CRLF
  LD HL,BUF
  CALL __LIST_2
  POP HL
  POP DE
  POP BC
  JP QINLIN_0
PINLIN_12:
  CP $20
  JP C,QINLIN_0
PINLIN_13:
  LD A,B
  OR A
  JP NZ,PINLIN_14
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  POP HL
  LD A,$07
  JP Z,PINLIN_15
  LD HL,BUF
  CALL ATOH
  EX DE,HL
  LD (CURLIN),HL
  JP BUFOV_ERR
PINLIN_14:
  LD A,C
  LD (HL),C
  INC HL
  INC B
PINLIN_15:
  CALL OUTDO
  SUB $0A
  JP NZ,QINLIN_0
  LD (TTYPOS),A
  LD A,$0D
  CALL OUTDO
PINLIN_16:
  CALL L4D05_0
  OR A
  JP Z,PINLIN_16
  CP $0D
  JP Z,QINLIN_0
  JP PINLIN_7
PINLIN_17:
  LD A,(INTFLG)
  OR A
  JP Z,CONSOLE_CRLF_0
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET
; This entry point is used by the routines at __LINE and __INPUT.
PINLIN_18:
  PUSH AF
  LD A,$00
  LD (INTFLG),A
  POP AF
  CP $3B
  RET NZ
  LD (INTFLG),A
  JP _CHRGTB

; Output char in 'A' to console
;
; Used by the routines at PROMPT, L12AA, DOTAB, INPUT_SUB, __LIST, __FILES,
; L45C9, QINLIN, PINLIN, TAB_LOOP, OUTDO_CRLF, TTY_FLUSH, L4DC7, __USING,
; L5256, L52F3, __EDIT, L53A4, CTL_ECHO and PRS1.
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
  JP NZ,NO_TAB
OUTC_TABEXP:
  LD A,$20
  CALL OUTDO
  LD A,(LPTPOS)
  CP $FF
  JP Z,OUTDO_2
  AND $07
  JP NZ,OUTC_TABEXP
OUTDO_2:
  POP AF
  RET

; Routine at 19542
;
; Used by the routine at OUTDO.
NO_TAB:
  POP AF
  PUSH AF
  SUB $0D
  JP Z,NO_TAB_1
  JP C,_OUTPRT
  LD A,(NTMSXP)
  INC A
  LD A,(LPTPOS)
  JP Z,NO_TAB_0
  PUSH HL
  LD HL,NTMSXP
  CP (HL)
  POP HL
  CALL Z,OUTPRT_CRLF
NO_TAB_0:
  CP $FF
  JP Z,_OUTPRT
  INC A
NO_TAB_1:
  LD (LPTPOS),A

; Output character to printer
;
; Used by the routine at NO_TAB.
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

; Routine at 19588
L4C84:
  NOP
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
; This entry point is used by the routine at NO_TAB.
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
; Used by the routines at LPTOUT_SAFE and OUTDO.
CHPUT:
  LD A,(CTLOFG)
  OR A
  JP NZ,TESTR_0
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
  LD A,$20
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
  CP $20
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
; This entry point is used by the routines at QINLIN and PINLIN.
L4D05_0:
  CALL ISFLIO
  JP Z,GETINP
  CALL RDBYT
  RET NC
  PUSH BC
  PUSH DE
  PUSH HL
  CALL __LOAD_4
  POP HL
  POP DE
  POP BC
  LD A,(ERRTRP)
  OR A
  JP NZ,L45C9_16
  LD A,($079E)
  OR A
  JP Z,L4D05_1
  LD HL,EXEC_EVAL
  PUSH HL
  JP RUN_FST
L4D05_1:
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
; Used by the routines at __LSET, L4D05, STALL, L4DC7, L5383 and L53A4.
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
; Used by the routines at ERROR_REPORT, READY, LINE2PTR and INPBRK.
CONSOLE_CRLF:
  LD A,(TTYPOS)
  OR A
  RET Z
  JP OUTDO_CRLF
; This entry point is used by the routines at PINLIN and EDIT_DONE.
CONSOLE_CRLF_0:
  LD (HL),$00
  LD HL,BUFMIN

; Print and go to new line
;
; Used by the routines at _ERROR_REPORT, __PRINT, PRNTNB, DOTAB, __LIST,
; __FILES, L45C9, PINLIN, L4CDB, CONSOLE_CRLF, L5256, L53A4, EDIT_DONE,
; CTL_ECHO and L5F1A.
OUTDO_CRLF:
  LD A,$0D
  CALL OUTDO
  LD A,$0A
  CALL OUTDO
; This entry point is used by the routines at L4DC7 and PRS1.
OUTDO_CRLF_0:
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
  XOR A
  LD (TTYPOS),A
  LD A,(NULLS)
TTY_FLUSH_0:
  DEC A
  RET Z
  PUSH AF
  XOR A
  CALL OUTDO
  POP AF
  JP TTY_FLUSH_0

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
  CALL Z,INPBRK_1
  JP __STOP
; This entry point is used by the routine at OPRND_MORE.
FN_INKEY:
  CALL _CHRGTB
  PUSH HL
  CALL L4DC7_2
  JP NZ,L4DC7_0           ; }
  DEFB $CD                ; CALL nn

; Data block at 19909
SMC_ISCNTC2:
  DEFW $0000

; Routine at 19911
L4DC7:
  OR A
  JP Z,L4DC7_1
  CALL GETINP
; This entry point is used by the routine at STALL.
L4DC7_0:
  PUSH AF
  CALL MK_1BYTE_TMST
  POP AF
  LD E,A
  CALL __CHR_S_0
L4DC7_1:
  LD HL,NULL_STRING
  LD (FACLOW),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET
; This entry point is used by the routines at __LSET and STALL.
L4DC7_2:
  LD A,(CTLCFG)
  OR A
  RET Z
  PUSH AF
  XOR A
  LD (CTLCFG),A
  POP AF
  RET
; This entry point is used by the routines at __LIST and L53A4.
__LIST_3:
  CALL OUTDO
  CP $0A
  RET NZ
  LD A,$0D
  CALL OUTDO
  CALL OUTDO_CRLF_0
  LD A,$0A
  RET

; Return from 'DIM' command
DIMRET:
  DEC HL                  ; DEC 'cos GETCHR INCs
  CALL _CHRGTB            ; Get next character
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
; LOOK_FOR, LINE_INPUT, __FIELD, __LSET, __CALL, GVAR, __TROFF, __ERASE, __NEXT
; and MIDNUM.
GETVAR:
  XOR A                   ; Find variable address,to DE
  LD (DIMFLG),A           ; Set locate / create flag
  LD C,(HL)               ; Get First byte of name
; This entry point is used by the routine at MAKINT.
GETVAR_0:
  CALL IS_ALPHA           ; See if a letter
  JP C,SN_ERR             ; ?SN Error if not a letter
  XOR A
  LD B,A                  ; Clear second byte of name
  LD (TYPE),A             ; Set type to numeric
  INC HL
  LD A,(HL)
  CP $2E
  JP C,GETVAR_4
  JP Z,SVNAM2
  CP $3A
  JP NC,GETVAR_1
  CP $30
  JP NC,SVNAM2
GETVAR_1:
  CALL IS_ALPHA_A
  JP C,GETVAR_4
SVNAM2:
  LD B,A
  PUSH BC
  LD B,$FF
  LD DE,TYPE
GETVAR_2:
  OR $80                  ; A = 80H , Flag for string
  INC B
  LD (DE),A
  INC DE
  INC HL
  LD A,(HL)
  CP $3A
  JP NC,GETVAR_3
  CP $30
  JP NC,GETVAR_2
GETVAR_3:
  CALL IS_ALPHA_A
  JP NC,GETVAR_2
  CP $2E
  JP Z,GETVAR_2
  LD A,B
  CP $27
  JP NC,SN_ERR
  POP BC
  LD (TYPE),A
  LD A,(HL)
GETVAR_4:
  CP $26
  JP NC,GETVAR_5
  LD DE,GVAR
  PUSH DE
  LD D,$02
  CP $25
  RET Z
  INC D
  CP $24
  RET Z
  INC D
  CP $21
  RET Z
  LD D,$08
  CP $23
  RET Z
  POP AF
GETVAR_5:
  LD A,C
  AND $7F
  LD E,A
  LD D,$00
  PUSH HL
  LD HL,$0A89
  ADD HL,DE
  LD D,(HL)
  POP HL
  DEC HL

; Get variable
GVAR:
  LD A,D
  LD (VALTYP),A           ; Set variable type
  CALL _CHRGTB
  LD A,(SUBFLG)           ; Array name needed ?
  DEC A
  JP Z,ARLDSV             ; Yes - Get array name
  JP P,NSCFOR             ; No array with "FOR" or "FN"
  LD A,(HL)               ; Get byte again
  SUB $28                 ; "(" ..Subscripted variable?
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
  JP NZ,GVAR_0            ; }
  LD A,($0BB6)            ; $0BB6: ARYTA2+1
  CP D
  JP NZ,GVAR_0
  LD A,(PRMFLG)
  OR A
  JP Z,L4F11_0
  XOR A
  LD (PRMFLG),A
GVAR_5:
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)
  JP GVAR_4
; This entry point is used by the routines at INPUT_SUB, __ERL and __CHAIN.
_GETVAR:
  CALL GETVAR             ; }
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
L4F11_0:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,_GETVAR_RET
  CALL DCOMPR
  JP Z,L4F11
  LD DE,VAR_EVAL_1
  CALL DCOMPR
  POP DE
  JP Z,L4F11_4
  EX (SP),HL
  PUSH HL
  PUSH BC
  LD A,(VALTYP)
  LD B,A
  LD A,(TYPE)
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
  CALL EDIT_DONE_3
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
  CALL ZERARY_5
  EX DE,HL
  INC DE
  POP HL
  RET
; This entry point is used by the routine at GVAR.
L4F11_2:
  INC DE
  LD A,(TYPE)
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
  LD (FACLOW),HL
  CALL GETYPR
  JP NZ,L4F11_5
  LD HL,NULL_STRING
  LD (FACLOW),HL
L4F11_5:
  POP HL
  RET

; SBSCPT
;
; Used by the routine at GVAR.
SBSCPT:
  PUSH HL
  LD HL,(DIMFLG)
  EX (SP),HL
  LD D,A
SCPTLP:
  PUSH DE                 ; SCPTLP
  PUSH BC
  LD DE,TYPE
  LD A,(DE)
  OR A
  JP Z,SBSCPT_2
  EX DE,HL
  ADD A,$02
  RRA
  LD C,A
  CALL CHKSTK
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
  LD A,(TYPE)
  PUSH AF
  EX DE,HL
  CALL GET_POSINT
  POP AF
  LD ($07EC),HL
  POP HL
  ADD A,$02
  RRA
SBSCPT_1:
  POP BC
  DEC HL
  LD (HL),B
  DEC HL
  LD (HL),C
  DEC A
  JP NZ,SBSCPT_1
  LD HL,($07EC)
  JP SBSCPT_3
SBSCPT_2:
  CALL GET_POSINT
  XOR A
  LD (TYPE),A
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
  EX (SP),HL
  PUSH HL
  EX DE,HL
  INC A
  LD D,A
  LD A,(HL)
  CP $2C
  JP Z,SCPTLP
  CP $29
  JP Z,SBSCPT_5
  CP $5D
  JP NZ,SN_ERR
SBSCPT_5:
  CALL _CHRGTB
  LD (NXTOPR),HL
  POP HL
  LD (DIMFLG),HL
  LD E,$00
  PUSH DE
  DEFB $11                ; "LD DE,nn" to jump over the next word without
                          ; executing it
; This entry point is used by the routines at __CHAIN and GVAR.
ARLDSV:
  PUSH HL                 ; Save code string address
  PUSH AF                 ; A = 00 , Flags set = Z,N
  LD HL,(ARYTAB)          ; Start of arrays
  DEFB $3E                ; DEFB $3E  ; "LD A,n" to Mask the next byte
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
NXTARY:
  INC HL
; This entry point is used by the routine at BSOPRND_0.
SBSCPT_6:
  LD E,(HL)
  INC E
  LD D,$00
  ADD HL,DE               ; }
; This entry point is used by the routine at BSOPRND_0.
SBSCPT_7:
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
  LD A,(TYPE)
  CP (HL)
  JP NZ,SBSCPT_6
  INC HL
  OR A
  JP Z,SBSCPT_7
  DEC HL
  CALL ZERARY_7
  JP SBSCPT_7
; This entry point is used by the routine at SBSCPT.
CREARY:
  LD A,(VALTYP)
  LD (HL),A
  INC HL
  LD E,A
  LD D,$00
  POP AF
  JP Z,ZERARY_2
  LD (HL),C               ; Save second byte of name
  INC HL
  LD (HL),B               ; Save first byte of name
  CALL ZERARY_5
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
  CALL CHKSTK_0           ; See if enough memory
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
; This entry point is used by the routine at SBSCPT.
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
  ADD HL,HL
  SUB $04
  JP C,ZERARY_0
  ADD HL,HL
  JP Z,ZERARY_1
  ADD HL,HL
ZERARY_0:
  OR A
  JP PO,ZERARY_1
  ADD HL,BC
ZERARY_1:
  POP BC                  ; Start of array
  ADD HL,BC               ; Point to element
  EX DE,HL                ; Address of element to DE
ENDDIM:
  LD HL,(NXTOPR)          ; Got code string address
  RET
; This entry point is used by the routine at BSOPRND_0.
ZERARY_2:
  SCF
  SBC A,A
  POP HL
  RET
; This entry point is used by the routines at L45C9 and L5A23.
ZERARY_3:
  LD A,(HL)
  INC HL
ZERARY_4:
  PUSH BC
  LD B,$00
  LD C,A
  ADD HL,BC
  POP BC
  RET
; This entry point is used by the routines at L4F11 and BSOPRND_0.
ZERARY_5:
  PUSH BC
  PUSH DE
  PUSH AF
  LD DE,TYPE
  LD A,(DE)
  LD B,A
  INC B
ZERARY_6:
  LD A,(DE)
  INC DE
  INC HL
  LD (HL),A
  DEC B
  JP NZ,ZERARY_6
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
  CALL NZ,ZERARY_4
  XOR A
  DEC A
ZERARY_9:
  POP BC
  POP DE
  RET                     ; }

; PRINT USING
;
; Used by the routine at __PRINT.
__USING:
  CALL EVAL_0
  CALL TSTSTR
  CALL SYNCHR
  DEFM ";"
  EX DE,HL
  LD HL,(FACLOW)
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
  CP $5C
  JP Z,L52F3
  CP $20
  JP NZ,__USING_5
  INC C
  DEC B
  JP NZ,__USING_4
__USING_5:
  POP HL
  LD B,E
  LD A,$5C
__USING_6:
  CALL BSOPRND_03
  CALL OUTDO
; This entry point is used by the routine at L5256.
__USING_7:
  XOR A
  LD E,A
  LD D,A
__USING_8:
  CALL BSOPRND_03
  LD D,A
  LD A,(HL)
  INC HL
  CP $21
  JP Z,L5256_12
  CP $23
  JP Z,__USING_11
  CP $26
  JP Z,L5256_11
  DEC B
  JP Z,L5256_7
  CP $2B
  LD A,$08
  JP Z,__USING_8
  DEC HL
  LD A,(HL)
  INC HL
  CP $2E
  JP Z,__USING_12
  CP $5F
  JP Z,L5256_10
  CP $5C
  JP Z,__USING_3
  CP (HL)
  JP NZ,__USING_6
  CP $24
  JP Z,USING_STR
  CP $2A
  JP NZ,__USING_6
  INC HL
  LD A,B
  CP $02
  JP C,__USING_9
  LD A,(HL)
  CP $24
__USING_9:
  LD A,$20
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
  CP $2E
  JP Z,__USING_13
  CP $23
  JP Z,__USING_11
  CP $2C
  JP NZ,__USING_14
  LD A,D
  OR $40
  LD D,A
  JP __USING_11
__USING_12:
  LD A,(HL)
  CP $23
  LD A,$2E
  JP NZ,__USING_6
  LD C,$01
  INC HL
__USING_13:
  INC C
  DEC B
  JP Z,L5256_0
  LD A,(HL)
  INC HL
  CP $23
  JP Z,__USING_13
__USING_14:
  PUSH DE
  LD DE,L5256
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
  SUB $2D
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
  CP $19
  JP NC,FC_ERR
  LD A,D
  OR $80
  CALL PUFOUT
  CALL PRS
; This entry point is used by the routine at L52F3.
L5256_3:
  POP HL
  DEC HL
  CALL _CHRGTB
  SCF
  JP Z,L5256_5
  LD (FLGINP),A
  CP $3B
  JP Z,L5256_4
  CP $2C
  JP NZ,SN_ERR
L5256_4:
  CALL _CHRGTB
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
  CALL BSOPRND_03
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
  CALL BSOPRND_03
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
  CALL BSOPRND_03
  POP HL
  POP AF
  JP Z,L5256_9
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
  LD A,B
  OR A
  CALL NZ,__LEFT_S_1
  CALL PRS1
  LD HL,(FACLOW)
  POP AF
  OR A
  JP Z,L5256_3
  SUB (HL)
  LD B,A
  LD A,$20
  INC B
L52F3_1:
  DEC B
  JP Z,L5256_3
  CALL OUTDO
  JP L52F3_1
; This entry point is used by the routines at __USING and L5256.
BSOPRND_03:
  PUSH AF
  LD A,D
  OR A
  LD A,$2B
  CALL NZ,OUTDO
  POP AF
  RET
; This entry point is used by the routine at READY_0.
L52F3_2:
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
; This entry point is used by the routine at L53A4.
__EDIT_1:
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL SRCHLP
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
  CALL __LIST_3
; This entry point is used by the routine at L53A4.
__EDIT_2:
  POP HL
; This entry point is used by the routine at PINLIN.
__EDIT_3:
  PUSH HL                 ; To enter Edit Mode on the line you are currently
  LD A,H                  ; typing, type Control-A. MBASIC responds with CR,
  AND L                   ; '!', and a space. The cursor will be positioned at
  INC A                   ; the first character in the line.
  LD A,$21
  CALL Z,OUTDO
  CALL NZ,_PRNUM
  LD A,$20
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
L5383:
  LD D,$00
L5383_0:
  CALL GETINP
  OR A
  JP Z,L5383_0
  CALL UCASE
  SUB $30
  JP C,L53A4
  CP $0A
  JP NC,L53A4
  LD E,A
  LD A,D
  RLCA
  RLCA
  ADD A,D
  RLCA
  ADD A,E
  LD D,A
  JP L5383_0

; Proceed by typing an Edit Mode subcommand.
;
; Used by the routine at L5383.
L53A4:
  PUSH HL
  LD HL,L5383
  EX (SP),HL
  DEC D
  INC D
  JP NZ,L53A4_0
  INC D
L53A4_0:
  CP $D8
  JP Z,L53A4_22
  CP $4F
  JP Z,L53A4_23
  CP $DD
  JP Z,EDIT_DONE
  CP $F0
  JP Z,L53A4_2
  CP $31
  JP C,L53A4_1
  SUB $20
L53A4_1:
  CP $21
  JP Z,EDIT_DONE_2
  CP $1C
  JP Z,L53A4_7
  CP $23
  JP Z,L53A4_3
  CP $19
  JP Z,L53A4_16
  CP $14
  JP Z,L53A4_8
  CP $13
  JP Z,L53A4_11
  CP $15
  JP Z,EDIT_DONE_0
  CP $28
  JP Z,L53A4_15
  CP $1B                  ; "ESC" ?
  JP Z,TXT_ESC
  CP $18
  JP Z,L53A4_14
  CP $11
  LD A,$07
  JP NZ,OUTDO
  POP BC
  POP DE
  CALL OUTDO_CRLF
  JP __EDIT_1
L53A4_2:
  LD A,(HL)
  OR A
  RET Z
  INC B
  CALL __LIST_3
  INC HL
  DEC D
  JP NZ,L53A4_2
  RET
TXT_ESC:
  PUSH HL
  LD HL,L53A4_10
  EX (SP),HL
  SCF
L53A4_3:
  PUSH AF
  CALL GETINP
  LD E,A
  POP AF
  PUSH AF
  CALL C,L53A4_10
L53A4_4:
  LD A,(HL)
  OR A
  JP Z,L53A4_6
  CALL __LIST_3
  POP AF
  PUSH AF
  CALL C,L53A4_17
  JP C,L53A4_5
  INC HL
  INC B
L53A4_5:
  LD A,(HL)
  CP E
  JP NZ,L53A4_4
  DEC D
  JP NZ,L53A4_4
L53A4_6:
  POP AF
  RET
L53A4_7:
  CALL __LIST_2
  CALL OUTDO_CRLF
  POP BC
  JP __EDIT_2
L53A4_8:
  LD A,(HL)
  OR A
  RET Z
  LD A,$5C
  CALL __LIST_3
L53A4_9:
  LD A,(HL)
  OR A
  JP Z,L53A4_10
  CALL __LIST_3
  CALL L53A4_17
  DEC D
  JP NZ,L53A4_9
L53A4_10:
  LD A,$5C
  CALL OUTDO
  RET
L53A4_11:
  LD A,(HL)
  OR A
  RET Z
L53A4_12:
  CALL GETINP
  CP $20
  JP NC,L53A4_13
  CP $0A
  JP Z,L53A4_13
  CP $07
  JP Z,L53A4_13
  CP $09
  JP Z,L53A4_13
  LD A,$07
  CALL OUTDO
  JP L53A4_12
L53A4_13:
  LD (HL),A
  CALL __LIST_3
  INC HL
  INC B
  DEC D
  JP NZ,L53A4_11
  RET
L53A4_14:
  LD (HL),$00
  LD C,B
L53A4_15:
  LD D,$FF
  CALL L53A4_2
L53A4_16:
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
  CP $20
  JP C,L53A4_16
  CP $5F
  JP NZ,OTHER_PRESSED
BS_PRESSED:
  LD A,$5F
BS_PRESSED_0:
  DEC B
  INC B
  JP Z,L53A4_19
  CALL __LIST_3
  DEC HL
  DEC B
  LD DE,L53A4_16
  PUSH DE
L53A4_17:
  PUSH HL
  DEC C
L53A4_18:
  LD A,(HL)
  OR A
  SCF
  JP Z,POPHLRT
  INC HL
  LD A,(HL)
  DEC HL
  LD (HL),A
  INC HL
  JP L53A4_18
OTHER_PRESSED:
  PUSH AF
  LD A,C
  CP $FF
  JP C,L53A4_21
  POP AF
L53A4_19:
  LD A,$07
  CALL OUTDO
L53A4_20:
  JP L53A4_16
L53A4_21:
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
  CALL EDIT_DONE_4
  POP BC
  POP AF
  LD (HL),A
  CALL __LIST_3
  INC HL
  JP L53A4_20
L53A4_22:
  LD A,B
  OR A
  RET Z
  DEC HL
  LD A,$08
  CALL __LIST_3
  DEC B
  DEC D
  JP NZ,L53A4_23
  RET
L53A4_23:
  LD A,B
  OR A
  RET Z
  DEC B
  DEC HL
  LD A,(HL)
  CALL __LIST_3
  DEC D
  JP NZ,L53A4_23
  RET

; Typing Carriage Return prints the remainder of the line, saves the changes
; you made and exits Edit Mode.
;
; Used by the routine at L53A4.
EDIT_DONE:
  CALL __LIST_2
; This entry point is used by the routine at L53A4.
EDIT_DONE_0:
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
  JP PROMPT_5
; This entry point is used by the routine at L53A4.
EDIT_DONE_2:
  POP BC
  POP DE
  LD A,D
  AND E
  INC A
  JP Z,CONSOLE_CRLF_0
  JP READY
; This entry point is used by the routines at PROMPT and L4F11.
EDIT_DONE_3:
  CALL CHKSTK_0
; This entry point is used by the routines at L45C9, L53A4 and L5AAF.
EDIT_DONE_4:
  PUSH BC
  EX (SP),HL
  POP BC
EDIT_DONE_5:
  CALL DCOMPR
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JP EDIT_DONE_5

; Check for C levels of stack
;
; Used by the routines at FORFND, __GO_SUB, EVAL, __DEF, __CALL, SBSCPT and
; BSOPRND_0.
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
  LD H,A
  JP C,OM_ERR
  ADD HL,SP
  POP HL
  RET C
; This entry point is used by the routines at __LOAD, BSOPRND_0, __CLEAR and
; L5F1A.
OM_ERR:
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
_OM_ERR:
  LD DE,$0007
  JP ERROR
; This entry point is used by the routines at BSOPRND_0, EDIT_DONE and L5F1A.
CHKSTK_0:
  CALL CHKSTK_1
  RET NC
  LD A,(ERRTRP)
  OR A
  JP NZ,_OM_ERR
  PUSH BC
  PUSH DE
  PUSH HL
  CALL TESTR_2
  POP HL
  POP DE
  POP BC
  CALL CHKSTK_1
  RET NC
  JP _OM_ERR
CHKSTK_1:
  PUSH DE
  EX DE,HL
  LD HL,(FRETOP)
  CALL DCOMPR
  EX DE,HL
  POP DE
  RET
; This entry point is used by the routine at __FRE.
CHKSTK_2:
  LD A,(MAXFIL)
  LD B,A
  LD HL,HIMEM
  XOR A
  INC B
CHKSTK_3:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD (DE),A
  DEC B
  JP NZ,CHKSTK_3
  CALL L41C5_1
  XOR A

; 'NEW' BASIC command
__NEW:
  RET NZ
; This entry point is used by the routine at __LOAD.
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
_CLREG_0:
  LD (HL),$04
  INC HL
  DEC B
  JP NZ,_CLREG_0
__NEW_0:
  LD DE,RND_CONST
  LD HL,LSTRND
  CALL LOADFP_1
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
  LD A,(ERRTRP)
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
  CALL Z,L41C5_1
; This entry point is used by the routine at BASIC_ENTRY.
__NEW_2:
  POP BC
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  INC HL
  INC HL                  ; }

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
; Used by the routines at BAKSTK, _ERROR_REPORT, PROMPT, SRCHLN, __FOR, ATOH,
; __GO_TO, __LET, MAKINT, __LIST, __DELETE, __RENUM, __OPTION, _ASCTFP,
; DECDIV_SUB, __LOAD, __MERGE, __FIELD, __LSET, __WEND, __CHAIN, L45C9, __GET,
; L4F11, SBSCPT, ZERARY, EDIT_DONE, CHKSTK, __TROFF, __ERASE, __CLEAR, __NEXT,
; TSTOPL_0, TESTR, L5A23, L5AAF, GSTRDE and MIDNUM.
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
; DOTAB, __LINE, __INPUT, __READ, FDTLP, __ERL, OPRND_FINISH, OPRND_3,
; UNSIGNED_RESULT_A, __DEF, MAKINT, __WAIT, GTWORD_GTINT, __POKE, __RENUM,
; __OPTION, LOOK_FOR, __NAME, __OPEN, GET_CHNUM, __LOAD, __MERGE, __FIELD,
; __LSET, __CALL, __CHAIN, L45C9, DIMRET, __USING, __TROFF, __CLEAR, TOPOOL,
; LFRGNM, MIDNUM and BASIC_ENTRY.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  JP NZ,SYNCHR_0
  INC HL
  EX (SP),HL
  INC HL
  LD A,(HL)
  CP $3A
  RET NC
  JP _CHRGTB_1
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
  CALL SRCHLP
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
; This entry point is used by the routine at STALL.
__STOP:
  RET NZ
  INC A
  JP __END_0

; 'END' BASIC command
__END:
  RET NZ
  PUSH AF
  CALL Z,L41C5_1
  POP AF
; This entry point is used by the routine at SYNCHR.
__END_0:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  DEFB $21                ; "LD HL,nn" to jump over the next word without
                          ; executing it

; Get here if the "INPUT" sequence was interrupted
;
; Used by the routines at __LINE, INPUT_SUB and __RANDOMIZE.
INPBRK:
  OR $FF
  POP BC
; This entry point is used by the routines at WARM_BT_0 and __LSET.
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
; This entry point is used by the routines at PINLIN and STALL.
INPBRK_1:
  PUSH AF
  SUB $03
  JP NZ,CTL_ECHO
  LD (PRTFLG),A
  LD (CTLOFG),A           ; }

; Display the pressed CTL-x sequence, e.g. ^C
;
; Used by the routine at INPBRK.
CTL_ECHO:
  LD A,$5E
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
  EX DE,HL                ; ???
  EX DE,HL                ; ???  ...useless
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
__TRON:
  DEFB $3E                ; "LD A,175" and Mask the next byte

; TRACE OFF
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
  CP $2C
  RET NZ
  CALL _CHRGTB
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
; Used by the routines at CRNCLP, L1164, OPRND, HEXTFP, __LIST and GETVAR.
IS_ALPHA_A:
  CP $41
  RET C
  CP $5B
  CCF
  RET

; Routine at 22454
;
; Used by the routine at __CLEAR.
CLVAR:
  JP _CLVAR

; 'CLEAR' BASIC command
__CLEAR:
  JP Z,CLVAR              ; Just "CLEAR" Keep parameters
  CP $2C
  JP Z,__CLEAR_0
  CALL GET_POSINT_0
  DEC HL
  CALL _CHRGTB            ; Get next character
  JP Z,CLVAR
__CLEAR_0:
  CALL SYNCHR
  DEFM ","
  JP Z,CLVAR
  EX DE,HL
  LD HL,(STKTOP)
  EX DE,HL
  CP $2C
  JP Z,__CLEAR_1
  CALL POSINT             ; Get integer to DE
__CLEAR_1:
  DEC HL                  ; Cancel increment
  CALL _CHRGTB
  PUSH DE
  JP Z,__CLEAR_3
  CALL SYNCHR             ; Check for comma
  DEFM ","
  JP Z,__CLEAR_3
  CALL POSINT             ; Get integer to DE
  DEC HL                  ; Cancel increment
  CALL _CHRGTB            ; Get next character
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
  CALL GETWORD
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
  OR $AF
; This entry point is used by the routine at SAVSTP.
__NEXT_0:
  XOR A
  LD (NEXFLG),A
  POP AF
  LD DE,$0000             ; In case no index given
; This entry point is used by the routine at KILFOR.
__NEXT_1:
  LD (NEXTMP),HL          ; }
  CALL NZ,GETVAR          ; not end of statement, locate variable (Get index
                          ; address)
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
  LD HL,$0BC0
  CALL PHLTFP
  XOR A
__NEXT_2:
  CALL NZ,FADD_HLPTR
  POP HL
  CALL DEC_FACCU2HL
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
  LD HL,($0BC0)
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
  CP $2C                  ; More NEXTs ?
  JP NZ,EXEC_EVAL         ; No - Do next statement
  CALL _CHRGTB            ; Position to index name
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

; STR BASIC function entry
__STR_S:
  CALL FOUT
; This entry point is used by the routines at __OCT_S and __HEX_S.
__STR_S_0:
  CALL CRTST
  CALL GSTRCU

; Save string in string area
SAVSTR:
  LD BC,TOPOOL            ; Save in string pool
  PUSH BC                 ; Save address on stack
; This entry point is used by the routines at __LET, MAKINT, L45C9 and MIDNUM.
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
  LD A,$01                ; }

; Make temporary string
;
; Used by the routines at __MKD_S, __LSET, CONCAT and TOPOOL.
MKTMST:
  CALL TESTR              ; See if enough string space

; Create temporary string entry
;
; Used by the routines at SAVSTR, DTSTR and __LEFT_S_3.
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
; Used by the routines at __PRINT, L45C9, __STR_S and PRS.
CRTST:
  DEC HL                  ; DEC - INCed after

; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,$22                ; Terminating quote
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
  CP $22                  ; End with '"'?
  CALL Z,_CHRGTB          ; Yes - Get next character
  PUSH HL
  LD A,B
  CP $2C
  JP NZ,DTSTR_3
  INC C
DTSTR_2:
  DEC C
  JP Z,DTSTR_3
  DEC HL
  LD A,(HL)
  CP $20
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
; Used by the routines at __LSET, CONCAT, TOPOOL and __LEFT_S_3.
TSTOPL:
  LD DE,DSCTMP            ; Temporary string
  DEFB $3E                ; "LD A,n" to Mask the next byte

; TSTOPL_0
;
; Used by the routine at MAKINT.
TSTOPL_0:
  PUSH DE
  LD HL,(TEMPPT)          ; Temporary string pool pointer
  LD (FACLOW),HL          ; Save address of string ptr
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
; Used by the routines at _ERROR_REPORT, L184B, __DELETE, LINE2PTR,
; __RANDOMIZE, LNUM_MSG, L4D05, L5256 and L5F1A.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routines at PRNTNB, __INPUT, L45C9 and L52F3.
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
  CALL Z,OUTDO_CRLF_0
  INC BC
  JP PRS1_0

; Test if enough room for string
;
; Used by the routines at __LSET, SAVSTR, MKTMST and __LEFT_S_3.
TESTR:
  OR A
  DEFB $0E                ; "LD C,n" to Mask the next byte
TESTR_00:
  POP AF                  ; TESTR_00
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
  JP C,TESTR_1
  LD (FRETOP),HL
  INC HL
  EX DE,HL
; This entry point is used by the routines at __LIST and CHPUT.
TESTR_0:
  POP AF
  RET
TESTR_1:
  POP AF                  ; }
  LD DE,$000E             ; Err $0E - "Out of string space"
  JP Z,ERROR
  CP A
  PUSH AF
  LD BC,TESTR_00
  PUSH BC
; This entry point is used by the routines at L45C9, CHKSTK and __FRE.
TESTR_2:
  LD HL,(MEMSIZ)
; This entry point is used by the routine at L5AAF.
TESTR_3:
  LD (FRETOP),HL
  LD HL,$0000
  PUSH HL
  LD HL,(STREND)
  PUSH HL
  LD HL,TEMPST            ; }

; Routine at 23075
L5A23:
  EX DE,HL
  LD HL,(TEMPPT)
  EX DE,HL
  CALL DCOMPR
  LD BC,L5A23
  JP NZ,L5AAF_0
  LD HL,PRMPRV
  LD (TEMP9),HL
  LD HL,(ARYTAB)
  LD (ARYTA2),HL
  LD HL,(VARTAB)
L5A23_0:
  EX DE,HL
  LD HL,(ARYTA2)
  EX DE,HL
  CALL DCOMPR
  JP Z,L5A23_2
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  PUSH AF
  CALL ZERARY_3
  POP AF
  CP $03
  JP NZ,L5A23_1
  CALL L5AAF_1
  XOR A
L5A23_1:
  LD E,A
  LD D,$00
  ADD HL,DE
  JP L5A23_0
L5A23_2:
  LD HL,(TEMP9)
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  LD HL,(ARYTAB)
  JP Z,L5A23_4
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
  JP L5A23_0
L5A23_3:
  POP BC
; This entry point is used by the routine at L5AAF.
L5A23_4:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  CALL DCOMPR
  JP Z,L5AAF_2
  LD A,(HL)
  INC HL
  PUSH AF
  INC HL
  INC HL
  CALL ZERARY_3
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  POP AF
  PUSH HL
  ADD HL,BC
  CP $03
  JP NZ,L5A23_3
  LD (TEMP8),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL

; Routine at 23215
L5AAF:
  EX DE,HL
  LD HL,(TEMP8)
  EX DE,HL
  CALL DCOMPR
  JP Z,L5A23_4
  LD BC,L5AAF
; This entry point is used by the routine at L5A23.
L5AAF_0:
  PUSH BC
; This entry point is used by the routine at L5A23.
L5AAF_1:
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
; This entry point is used by the routine at L5A23.
L5AAF_2:
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
  CALL EDIT_DONE_4
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
  LD DE,$000F             ; Err $0F - "String too long"
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
; Used by the routines at SAVSTR and __LEFT_S_3.
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
; Used by the routines at FNAME, __OPEN, __CVD, __LSET, EVAL_STR, __LEN and
; MIDNUM.
GETSTR:
  CALL TSTSTR

; Get string pointed by FPREG
;
; Used by the routines at INPUT_SUB, UNSIGNED_RESULT_A, __STR_S, PRS1 and
; __FRE.
GSTRCU:
  LD HL,(FACLOW)

; Get string pointed by HL
;
; Used by the routines at L5256, CONCAT and MIDNUM.
GSTRHL:
  EX DE,HL

; Get string pointed by DE
;
; Used by the routines at EVAL_STR, CONCAT and __LEFT_S_3.
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
  JP NZ,GSTRDE_0
  LD B,A
  ADD HL,BC
  LD (FRETOP),HL
GSTRDE_0:
  POP HL
  RET
; This entry point is used by the routine at __LET.
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

; 'LEN' BASIC function
__LEN:
  LD BC,UNSIGNED_RESULT_A
  PUSH BC
; This entry point is used by the routines at __ASC and __MID_S.
__LEN_0:
  CALL GETSTR
  XOR A
  LD D,A
  LD A,(HL)
  OR A
  RET

; 'ASC' BASIC function
__ASC:
  LD BC,UNSIGNED_RESULT_A
  PUSH BC
; This entry point is used by the routine at TOPOOL.
__ASC_0:
  CALL __LEN_0
  JP Z,FC_ERR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  RET

; 'CHR$' BASIC function
__CHR_S:
  CALL MK_1BYTE_TMST
  CALL GETINT_0
; This entry point is used by the routine at L4DC7.
__CHR_S_0:
  LD HL,(TMPSTR)
  LD (HL),E

; Save in string pool
;
; Used by the routine at __MKD_S.
TOPOOL:
  POP BC
  JP TSTOPL
; This entry point is used by the routine at OPRND_MORE.
FN_STRING:
  CALL _CHRGTB
  CALL SYNCHR
  DEFM "("
  CALL GETINT
  PUSH DE
  CALL SYNCHR
  DEFM ","
  CALL EVAL
  CALL SYNCHR
  DEFM ")"
  EX (SP),HL
  PUSH HL
  CALL GETYPR
  JP Z,TOPOOL_0
  CALL GETINT_0
  JP TOPOOL_1
TOPOOL_0:
  CALL __ASC_0
TOPOOL_1:
  POP DE
  CALL TOPOOL_2
__SPACE_S:
  CALL GETINT_0
  LD A,$20
TOPOOL_2:
  PUSH AF
  LD A,E
  CALL MKTMST
  LD B,A
  POP AF
  INC B
  DEC B
  JP Z,TOPOOL
  LD HL,(TMPSTR)
TOPOOL_3:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,TOPOOL_3
  JP TOPOOL

; 'LEFT$' BASIC function
__LEFT_S:
  CALL LFRGNM
  XOR A
; This entry point is used by the routine at __RIGHT_S.
__LEFT_S_0:
  EX (SP),HL
  LD C,A

; "LD A,n" to Mask the next byte
L5BF9:
  DEFB $3E

; Routine at 23546
;
; Used by the routine at L52F3.
__LEFT_S_1:
  PUSH HL

; Routine at 23547
__LEFT_S_2:
  PUSH HL
  LD A,(HL)
  CP B
  JP C,__LEFT_S_3
  LD A,B

; "LD DE,nn" to jump over the next word without executing it
L5C02:
  DEFB $11

; Routine at 23555
;
; Used by the routine at __LEFT_S_2.
__LEFT_S_3:
  LD C,$00
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
  CALL CRTMST
  LD L,A
  CALL TOSTRA
  POP DE
  CALL GSTRDE
  JP TSTOPL

; 'RIGHT$' BASIC function
__RIGHT_S:
  CALL LFRGNM
  POP DE
  PUSH DE
  LD A,(DE)
  SUB B
  JP __LEFT_S_0

; 'MID$' BASIC function
__MID_S:
  EX DE,HL
  LD A,(HL)
  CALL MIDNUM
  INC B
  DEC B
  JP Z,FC_ERR
  PUSH BC
  CALL MIDNUM_10
  POP AF
  EX (SP),HL
  LD BC,__LEFT_S_2
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
  LD (HL),D
  EX (SP),HL
  PUSH BC
  DEC HL
  CALL _CHRGTB
  CALL DBL_ASCTFP
  POP BC
  POP HL
  LD (HL),B
  RET

; number in program listing and check for ending ')'
;
; Used by the routines at __LEFT_S and __RIGHT_S.
LFRGNM:
  EX DE,HL
  CALL SYNCHR
  DEFM ")"

; Get number in program listing
;
; Used by the routine at __MID_S.
MIDNUM:
  POP BC
  POP DE
  PUSH BC
  LD B,E
  RET
; This entry point is used by the routine at OPRND_MORE.
FN_INSTR:
  CALL _CHRGTB
  CALL NEXT_PARENTH
  CALL GETYPR
  LD A,$01
  PUSH AF
  JP Z,MIDNUM_0
  POP AF
  CALL GETINT_0
  OR A
  JP Z,FC_ERR
  PUSH AF
  CALL SYNCHR
  DEFM ","
  CALL EVAL
  CALL TSTSTR
MIDNUM_0:
  CALL SYNCHR
  DEFM ","
  PUSH HL
  LD HL,(FACLOW)
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
MIDNUM_1:
  PUSH HL
  PUSH DE
  PUSH BC
MIDNUM_2:
  LD A,(DE)
  CP (HL)
  JP NZ,MIDNUM_5
  INC DE
  DEC C
  JP Z,MIDNUM_4
  INC HL
  DEC B
  JP NZ,MIDNUM_2
  POP DE
  POP DE
  POP BC
MIDNUM_3:
  POP DE
  XOR A
  RET
MIDNUM_4:
  POP HL
  POP DE
  POP DE
  POP BC
  LD A,B
  SUB H
  ADD A,C
  INC A
  RET
MIDNUM_5:
  POP BC
  POP DE
  POP HL
  INC HL
  DEC B
  JP NZ,MIDNUM_1
  JP MIDNUM_3
; This entry point is used by the routine at MAKINT.
MIDNUM_6:
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
  JP C,MIDNUM_7
  LD HL,(TXTTAB)
  CALL DCOMPR
  JP NC,MIDNUM_7
  POP HL
  PUSH HL
  CALL SAVSTR_0
  POP HL
  PUSH HL
  CALL FP2HL
MIDNUM_7:
  POP HL
  EX (SP),HL
  CALL SYNCHR
  DEFM ","
  CALL GETINT
  OR A
  JP Z,FC_ERR
  PUSH AF
  LD A,(HL)
  CALL MIDNUM_10
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
  JP C,MIDNUM_8
  LD A,C
MIDNUM_8:
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
MIDNUM_9:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC C
  RET Z
  DEC B
  JP NZ,MIDNUM_9
  RET
; This entry point is used by the routine at __MID_S.
MIDNUM_10:
  LD E,$FF
  CP $29
  JP Z,MIDNUM_11
  CALL SYNCHR
  DEFM ","
  CALL GETINT
MIDNUM_11:
  CALL SYNCHR
  DEFM ")"
  RET

; 'FRE' BASIC function
__FRE:
  CALL GETYPR
  JP NZ,__FRE_0
  CALL GSTRCU
  CALL TESTR_2
__FRE_0:
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  LD HL,(FRETOP)
  JP IMP_0
; This entry point is used by the routine at L5F1A.
__FRE_1:
  CALL CHKSTK_2
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
L5DCE:
  DEFB $05

; Data block at 24015
L5DCF:
  DEFB $01

; Main entry
;
; Used by the routine at L0100.
BASIC_ENTRY:
  LD HL,$60A8
  LD SP,HL
  XOR A
  LD (FILFLG),A
  LD (STKTOP),HL
  LD SP,HL
  LD HL,BUFFER
  LD (HL),$3A
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
  LD HL,$1514
  JP Z,BASIC_ENTRY_0
  LD HL,$2221             ; H=$22 (Write record FN), L=$21 (Read record FN)
BASIC_ENTRY_0:
  LD (RD_FN),HL
  LD HL,$FFFE
  LD (CURLIN),HL
  XOR A
  LD (CTLOFG),A
  LD ($0A64),A
  LD (ERRTRP),A
  LD (NLONLY),A
  LD (ERRFLG),A
  LD HL,$0000
  LD (LPTPOS),HL
  LD HL,$0080
  LD ($0BEA),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,PRMSTK
  LD (PRMPRV),HL
  LD HL,($0006)           ; HL=BDOS entry address
  LD (MEMSIZ),HL
  LD A,$03
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
  CALL _CHRGTB
  OR A
  JP Z,L5F1A
  CP $2F
  JP Z,BASIC_ENTRY_3
  DEC HL
  LD (HL),$22
  LD (TEMP8),HL
  INC HL
BASIC_ENTRY_2:
  CP $2F
  JP Z,BASIC_ENTRY_3
  CALL _CHRGTB
  OR A
  JP NZ,BASIC_ENTRY_2
  JP L5F1A
BASIC_ENTRY_3:
  LD (HL),$00
  CALL _CHRGTB
BASIC_ENTRY_4:
  CALL UCASE_HL
  CP $53
  JP Z,BASIC_ENTRY_8
  CP $4D
  PUSH AF
  JP Z,BASIC_ENTRY_5
  CP $46
  JP NZ,SN_ERR
BASIC_ENTRY_5:
  CALL _CHRGTB
  CALL SYNCHR
  DEFM ":"
  CALL UCASE_0
  POP AF
  JP Z,BASIC_ENTRY_6
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
  CALL _CHRGTB
  JP Z,L5F1A
  CALL SYNCHR
  DEFM "/"
  JP BASIC_ENTRY_4
BASIC_ENTRY_8:
  CALL _CHRGTB
  CALL SYNCHR
  DEFM ":"
  CALL UCASE_0
  EX DE,HL
  LD ($0BEA),HL
  EX DE,HL
  JP BASIC_ENTRY_7
WARM_0:
  DEFB $00
WARM_FLG:
  DEFB $00

; Routine at 24346
;
; Used by the routine at BASIC_ENTRY.
L5F1A:
  LD DE,RSV_SIZE
  LD A,(DE)
  OR A
  JP Z,L5F1A_3
  LD A,(L5DCF)
  LD B,A
L5F1A_0:
  LD A,(L5DCE)
  LD C,A
  LD HL,($0006)           ; HL=BDOS entry address
  LD L,$00                ; Reduce to the byte boundary to get the TPA size
L5F1A_1:
  LD A,(DE)
  CP (HL)
  JP NZ,L5F1A_2
  INC HL
  INC DE
  DEC C
  JP NZ,L5F1A_1
  JP L5F1A_3
L5F1A_2:
  INC DE
  DEC C
  JP NZ,L5F1A_2
  DEC B
  RET Z
  JP L5F1A_0
L5F1A_3:
  DEC HL
  LD HL,(MEMSIZ)
  DEC HL
  LD (MEMSIZ),HL
  DEC HL
  PUSH HL
  LD A,(MAXFIL)
  LD HL,NULL_FILE
  LD (FILTAB),HL
  LD DE,HIMEM
  LD (MAXFIL),A
  INC A
  LD BC,$00A9
L5F1A_4:
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  ADD HL,BC
  PUSH HL
  LD HL,($0BEA)
  LD BC,$00B2
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
  CP $02
  JP C,L5F1A_6
  LD HL,$0200
L5F1A_6:
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
  CALL CHKSTK_0
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
  JP __FRE_1

; Message at 24550
HIDDEN_MSG:
  DEFM "]"
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
BASIC_MSG:
  DEFM "Basic-80"

; Quantity of memory to reserve at startup
RSV_SIZE:
  DEFW $1600

; Data block at 24670
USER_MEMORY:
  DEFW $0014

; Data block at 24672
L6060:
  DEFW $0058
