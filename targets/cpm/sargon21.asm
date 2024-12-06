
; Standard CP/M
DEFC BDOS=$0005
DEFC WBOOT=$0000
  ORG $100

;-DMYCONSOLE

;ORG $1200
;DEFC CHARTR=$1b
;DEFC OUTPUT=$12
;DEFC CLS_CHR=$C6
;DEFC CLS_CHR=12
;DEFC WBOOT=0
;DEFC BDOS=0


; Zenith H8/H89 Lifeboat CP/M
; z88dk-z80asm.exe -b -DCPM14 sargon21.asm -osargon.com
; /cpmtools/cpmcp -f h8d cpm14.h8d sargon.com 0:
;
;# Heath Zenith H8
;diskdef h8d
;   seclen 256
;   tracks 40
;   sectrk 10
;   blocksize 1024
;   maxdir 32
;   skew 4
;   boottrk 3
;   os 2.2
; end
; 
;DEFC BDOS=$4205
;DEFC WBOOT=$4200
;  ORG $4300


; TRS-80 Model I Lifeboat or FMG CP/M
; z88dk-z80asm.exe -b -DTRS80 -DCPM14 sargon21.asm -osargon.com
; z88dk-appmake +cpmdisk -f omikron --container=imd -b sargon.com
;DEFC BDOS=$4205
;DEFC WBOOT=$4200
;  ORG $4300


; ZX Spectrum 48K, org @6100h
;
; z88dk-z80asm.exe -b -DSINCLAIR sargon21.asm
; z88dk-appmake.exe +zx -b sargon21.bin --org 24832 -o sargon21.tap
;  ORG $6100


; ZX Spectrum 128 w/Betadisk, K.Karimov CP/M, TPA @6100h
; z88dk-z80asm.exe -b sargon21.asm -osargon21.cm6
; z88dk-appmake +cpmdisk -f quorum --container=raw --extension=.trd -b sargon21.cm6
;DEFC BDOS=$6005
;DEFC WBOOT=$6000
;DEFC CLS_CHR=12
;  ORG $6100




;**********************************************************
; This memory section is copied to file when saving a game
; 29 records, each one of 128 bytes = 3712 total size
; (memory range: $100-$F80, it overlaps INITBD a little)
;**********************************************************

; JP to the code section

ENTRY:
  JP START

;***********************************************************
; EQUATES
;***********************************************************
;
PAWN    EQU     1
KNIGHT  EQU     2
BISHOP  EQU     3
ROOK    EQU     4
QUEEN   EQU     5
KING    EQU     6
WHITE   EQU     0
BLACK   EQU     80H
BPAWN   EQU     BLACK+PAWN


DEFC MLPTR = 0 
DEFC MLFRP = 2 
DEFC MLTOP = 3 
DEFC MLFLG = 4 
DEFC MLVAL = 5


; Working indices used to index into the board array.
M1:
  DEFW BOARDA
M2:
  DEFW BOARDA
M3:
  DEFW BOARDA
M4:
  DEFW BOARDA

; Working indices used to index into Direction Count, Direction Value, and
; Piece Value tables.
T1:
  DEFW BOARDA
T2:
  DEFW BOARDA
INDX2:
  DEFW BOARDA

; Pointer into the ply table which tells which pair of pointers are in current
; use.
MLPTRI:
  DEFW $0000

; (=MLEND) Pointer into the move list to the move that is currently being
; processed.
MLPTRJ:
  DEFW $0000

; Score Index. Pointer to the score table for the ply being examined.
SCRIX:
  DEFW $0000

; Data block at 279
L0117:
  DEFW $0000

; Pointer into the move list for the move that is currently considered the best
; by the Alpha-Beta pruning process.
BESTM:
  DEFW $0000
MLLST:
  DEFW $0000
MLNXT:
  DEFW $0000

; Data block at 287
L011F:
  DEFW $0000

; Data block at 289
L0121:
  DEFW $0000

; Data block at 291
L0123:
  DEFW $0000

; Data block at 293
L0125:
  DEFW $0000

; Data block at 295
L0127:
  DEFW $0000

; Data block at 297
L0129:
  DEFW $0000

; Data block at 299
KOLOR:
  DEFB $00

; Data block at 300
COLOR:
  DEFB $00

; Working area to hold the contents of the board array for a given square.
P1:
  DEFB $00

; Data block at 302
P2:
  DEFB $00

; Data block at 303
P3:
  DEFB $00

; Data block at 304
PMATE:
  DEFB $00

; Data block at 305
MOVENO:
  DEFB $00

; Game level (max depth)
PLYMAX:
  DEFB $00

; Data block at 307
NPLY:
  DEFB $00

; Data block at 308
CKFLG:
  DEFB $00

; Data block at 309
MATEF_2:
  DEFB $00

; Data block at 310
MATEF:
  DEFB $00

; Data block at 311
L0137:
  DEFB $00

; Data block at 312
L0138:
  DEFB $00

; Data block at 313
VALM:
  DEFW $0000

; Data block at 315
L013B:
  DEFB $00

; Data block at 316
L013C:
  DEFB $00

; Data block at 317
L013D:
  DEFB $00

; Data block at 318
L013E:
  DEFB $00

; Data block at 319
L013F:
  DEFB $00

; ***
MTRL:
  DEFB $00

; Data block at 321
MTRL_A:
  DEFB $00

; Data block at 322
MTRL_B:
  DEFB $00

; Data block at 323
MTRL_C:
  DEFB $00

; Data block at 324
L0144:
  DEFB $00

; Data block at 325
L0145:
  DEFW $0000


; White King position
; Message at 327
POSK:
  DEFB $00

; Black King position
; Message at 328
  DEFB $00

; White Queen position
; Data block at 329
POSQ:
  DEFB $00

; Black Queen position
; Message at 330
  DEFB $00



; Message at 331
DISP_BD:
  DEFB $00

; Message at 332
MVENUM:
  DEFM "N"
; Message at 333
  DEFM "N "

; Message at 335
; Move message, e.g. "a1-a1"
MVEMSG_A:
  DEFM "      "
; Message at 341
;L0155:
  DEFM "  "

; Message at 343
; Move message, e.g. "a1-a1"
MVEMSG_B:
  DEFM "      "
; Message at 349
;L015D:
  DEFM "  "
  DEFB $08
  DEFM "$"

; Data block at 353
SPSAVE_CPM:
  DEFW $0000

; Data block at 355
L0163:
  DEFB $00

; Data block at 356
L0164:
  DEFB $00

; Data block at 357
PRINTER_FLAG:
  DEFB $00

; Data block at 358
L0166:
  DEFB $2A

; Data block at 359
L0167:
  DEFB $00

; Data block at 360
L0168:
  DEFB $00

; Data block at 361
L0169:
  DEFB $00

; Data block at 362
BELL:
  DEFB $01,$CD,$78,$20,$C1,$3E,$01,$32
  DEFB $0B,$36,$C3

; Data block at 373
L0175:
  DEFB $96,$22,$CD,$2D,$2A,$C0,$CD,$BA
  DEFB $1F,$28,$1A

;**********************************************************
; DIRECT  --  Direction Table.  Used to determine the dir-
;             ection of movement of each piece.
;***********************************************************
defc DIRECT = 080H ; -128 ; $-TBASE             ;  -128

; Data block at 384
  DEFB $09,$0B,$F5,$F7
  DEFB $0A,$F6,$01,$FF
  DEFB $EB,$F4,$08,$13
  DEFB $15,$0C,$F8,$ED
  DEFB $09,$0B,$0A,$0A
  DEFB $F7,$F5,$F6,$F6
  

;***********************************************************
; DPOINT  --  Direction Table Pointer. Used to determine
;             where to begin in the direction table for any
;             given piece.
;***********************************************************
defc DPOINT = 069H ; -105 ; $-TBASE             ; -105

  DEFB $10,$08,$00,$04,$00,$00


;***********************************************************
; DCOUNT  --  Direction Table Counter. Used to determine
;             the number of directions of movement for any
;             given piece.
;***********************************************************
defc DCOUNT = 063H ; -99 ; $-TBASE             ; -99

; Data block at 414
  DEFB $04,$08,$04,$04,$08,$08,$00


; *******************************************************
; PVALUE -- Point Value. Gives the point value of each 
; piece, or the worth of each piece.
; *******************************************************
defc PVALUE = 05CH ; -92 ; ASMPC-TBASE-1

; Data block at 421
  DEFB $01,$03,$03,$05,$09,$0A,$00

; Data block at 428
WACT:
  DEFB $A6,$1F,$E5,$11,$02,$36,$97

; Data block at 435
BACT:
  DEFB $CD,$DA,$07,$30,$0F

; Data block at 440
L01B8:
  DEFB $3A,$08,$64,$00
  DEFB $FA,$00,$B0,$04,$C4,$09,$40,$1F

; Data block at 452
L01C4:
  DEFB $00,$7D
  DEFB $FA,$00,$B0,$04,$C4,$09,$40,$1F
  DEFB $00,$7D,$E8,$FD

;
; The following 10 bytes should be cleaned up by INITBD
; ----------------------------------------
; Data block at 466
L01D2:
  DEFB $36,$CD,$4F,$1B

; Data block at 470
L01D6:
  DEFB $18,$EF

; Data block at 472
L01D8:
  DEFB $CD,$2D

; Data block at 474
L01DA:
  DEFB $2A

; Data block at 475
L01DB:
  DEFB $C0
; ----------------------------------------

; Data block at 476
MVEMSG:
  DEFB $11
; Data block at 477
;L01DD:
  DEFB $02
; Data block at 478
;L01DE:
  DEFB $36
; Data block at 479
;L01DF:
  DEFB $06

; Data block at 480
L01E0:
  DEFB $06,$CD,$8D,$1F,$CD,$A6,$1F,$E5
  DEFB $11,$02,$36,$97

; Data block at 492
L01EC:
  DEFB $CD,$DA,$07,$30,$0F

; Data block at 497
L01F1:
  DEFB $3A,$08,$36,$FE,$02,$28,$11

; Message at 504
PIECES:
  DEFB $04
  DEFB $02
  DEFB $03
  DEFB $05
  DEFB $06
  DEFB $03
  DEFB $02
  DEFB $04

; DEFS 120
; After booting this will be the the actual memory space for the chessboard
BOARDA:
  JP START

; Data block at 515
L0203:
  DEFW BOARDA
  DEFW BOARDA
  DEFW BOARDA
  DEFW BOARDA
  DEFW BOARDA
  DEFW BOARDA
  DEFW BOARDA
  DEFW $0000
  DEFW $0000

; Message at 533
; board top-left corner, in previous versions referenced as (IX+BOARD)
TOP_LEFT:
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00

; Message at 540
; board top-right corner
TOP_RIGHT:
  DEFB $00
  DEFB $00
  DEFB $00

; Message at 543
L021F:
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00

; Message at 588
L024C:
  DEFM "NN             "

; board bottom-left corner at 603
BOTTOM_LEFT:
  DEFM "    "
  DEFB $08
  DEFM "$"
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFM "*"
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $CD
  DEFM "x "
  DEFB $C1
  DEFM ">"
  DEFB $01
  DEFM "2"
  DEFB $0B
  DEFM "6"
  DEFB $C3
  DEFB $96
  DEFM "\""
  DEFB $CD

; Message at 632
TITLE:
  DEFM "               SARGON 2.1"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "         DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL RESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITA"

; Message at 1023
STACK:
  DEFM "L"

; Message at 1024
L0400:
  DEFM " RESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK "

; Message at 1151
L047F:
  DEFM "C"

; Message at 1152
L0480:
  DEFM "OMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITA"

; Message at 1279
L04FF:
  DEFM "L"

; Message at 1280
L0500:
  DEFB $00
  DEFB $00

; Message at 1282
L0502:
  DEFM "E"

; Message at 1283
SCORE:
  DEFM "S"

; Message at 1284
L0504:
  DEFM "E"

; Message at 1285
L0505:
  DEFM "ARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "        "

; Message at 1304
PLYIX:
  DEFM "    "

; Message at 1308
L051C:
  DEFM "  "

; Message at 1310
L051E:
  DEFM "     BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM "

; Message at 1346
L0542:
  DEFM "H"

; Message at 1347
L0543:
  DEFM "ENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         "

; Message at 1366
TBASE:
  DEFM "CO"

; Message at 1368
L0558:
  DEFM "PYRIGHT (C)1981 BY"

; Message at 1386
L056A:
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"

; Message at 1792
MLIST:
  DEFB $00
  DEFB $00
  DEFM "ES"

; Message at 1796
L0704:
  DEFM "EARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/"

; Message at 2573
L0A0D:
  DEFM "M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"

; Message at 2816
; MLIST+1024
MLIST2:
  DEFB $00
  DEFB $00
  DEFM "ES"

; Message at 2820
L0B04:
  DEFM "EARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDE"

; Message at 3308
PTSW2:
  DEFM "R"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFM "ESEARCH CP/M"
  DEFB $0D
  DEFB $0A
  DEFM "                   BY"
  DEFB $0D
  DEFB $0A
  DEFM "    KEVIN LEAVELLE AND JIM HENDERSON"
  DEFB $0D
  DEFB $0A
  DEFM "         COPYRIGHT (C)1981 BY"
  DEFB $0D
  DEFB $0A
  DEFM "       HAYDEN BOOK COMPANY, INC."
  DEFB $0D
  DEFB $0A
  DEFM "          ALL RIGHTS RESERVED$       DAN AND KATHY SPRACKLEN"
  DEFB $0D
  DEFB $0A
  DEFM "        MODIFIED TO OPERATE UNDER"
  DEFB $0D
  DEFB $0A
  DEFM "          DIGITAL"
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $02
  DEFB $03
  DEFB $03
  DEFB $02
  DEFB $01
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $03
  DEFB $04
  DEFB $05
  DEFB $05
  DEFB $04
  DEFB $03
  DEFB $01
  DEFB $00
  DEFB $00
  DEFB $02
  DEFB $04
  DEFB $06
  DEFB $07
  DEFB $07
  DEFB $06
  DEFB $04
  DEFB $02
  DEFB $00
  DEFB $00
  DEFB $03
  DEFB $05
  DEFB $07
  DEFB $08
  DEFB $08
  DEFB $07
  DEFB $05
  DEFB $03
  DEFB $00
  DEFB $00
  DEFB $03
  DEFB $05
  DEFB $07
  DEFB $08
  DEFB $08
  DEFB $07
  DEFB $05
  DEFB $03
  DEFB $00
  DEFB $00
  DEFB $02
  DEFB $04
  DEFB $06
  DEFB $07
  DEFB $07
  DEFB $06
  DEFB $04
  DEFB $02
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $03
  DEFB $04
  DEFB $05
  DEFB $05
  DEFB $04
  DEFB $03
  DEFB $01
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $02
  DEFB $03
  DEFB $03
  DEFB $02
  DEFB $01
  DEFB $00
  DEFB $00

; Routine at 3920
;
; *******************************************************
; PROGRAM CODE SECTION
; BOARD SETUP ROUTINE
; FUNCTION: To initialize the board array, setting the 
; pieces in their initial positions for the 
; start of the game.
; CALLED BY: DRIVER
; CALLS: None
; ARGUMENTS: None
; *******************************************************
; Used by the routine at GAME_DRIVER.
INITBD:
  LD B,120              ; Pre-fill board with -1's 
  LD HL,BOARDA
INITBD_0:
  LD (HL),-1
  INC HL
; This entry point is used by the routine at SET_FILENAME.
INITBD_1:
  DJNZ INITBD_0
  LD B,8
  LD IX,BOARDA

; Routine at 3936
IB2:
  LD A,(IX-8)           ; Fill non-border squares
  LD (IX+21),A          ; White pieces
  SET 7,A               ; Change to black
  LD (IX+91),A
  LD (IX+81),BPAWN      ; Black Pawns
  LD (IX+31),PAWN       ; White Pawns
  LD (IX+41),$00        ; Empty squares 
  LD (IX+51),$00
  LD (IX+61),$00
  LD (IX+71),$00
  INC IX
  DJNZ IB2
  RET

; This entry point is used by the routine at GAME_DRIVER.
CLEANBD:
  LD B,120
  LD HL,BOARDA
CLEANBD_0:
  LD (HL),-1
  INC HL
  DJNZ CLEANBD_0
  LD B,8
  LD IX,BOARDA
CB2:
  LD (IX+21),$00
  LD (IX+91),$00
  LD (IX+81),$00
  LD (IX+31),$00
  LD (IX+41),$00
  LD (IX+51),$00
  LD (IX+61),$00
  LD (IX+71),$00
  INC IX
  DJNZ CB2
  LD HL,L01D2
  LD B,10
  XOR A
CB3:
  LD (HL),A
  INC HL
  DJNZ CB3
  RET


; Routine at 4039
;
; Used by the routine at GENMOV.
MPIECE:
  LD IY,(T1)        ; Load index to DCOUNT/DPOINT
  LD B,(IY-DCOUNT)  ; Get direction count
  LD A,(IY-DPOINT)  ; Get direction pointer
  CP $10
  JR NZ,JR1
  BIT 7,(HL)
  JR Z,JR1
  ADD A,$04
JR1:
  LD (INDX2),A      ; Save as index to direct
  LD IY,(INDX2)     ; Load index
; This entry point is used by the routine at MP15.
MP5:
  PUSH DE
  LD C,(IY-DIRECT)  ; Get move direction
; This entry point is used by the routine at MP20.
MP10:
  LD A,C            ; Calculate next position
  ADD A,E
  LD E,A
  LD A,(DE)
  AND A             ; Test for empty square
  JR Z,MPIECE_3
  CP $FF            ; Ready for new direction ?
  JR Z,MP15         ; 
  LD HL,P1          ; Get piece moved
  XOR (HL)          ; 
  BIT 7,A           ;
  JR Z,MP15
  XOR (HL)          ; Test for empty square
MPIECE_3:
  EX AF,AF'         ; Save "empty square" result
  LD A,(T1)         ; Get piece moved
  CP PAWN           ; Is it a Pawn ?
  JR Z,MP20         ; Yes - Jump
  CALL ADMOVE       ; Add move to list (includes  EX AF,AF')
  JR NZ,MP15        ; Empty square ?  (No - Jump)
  LD A,(T1)         ; Piece type
  CP KING           ; King ?
  JR Z,MP15
  CP BISHOP         ; Bishop, Rook, or Queen ?
  JR NC,MP10        ; Yes - Jump

; Increment direction index
;
; Used by the routines at MPIECE, MP20, ENPSNT and ADJPTR.
MP15:
  INC IY            ; Increment direction index
  POP DE
  DJNZ MP5          ; Decr. count-jump if non-zerc
  RET               ; Return


; ***** PAWN LOGIC *****
;
; Used by the routine at MPIECE.
MP20:
  LD A,B               ; Counter for direction
  CP $03               ; On diagonal moves ?
  JR NC,MP36
  EX AF,AF'            ; Is forward square empty?
  JR NZ,MP20_0
  EX AF,AF'
  CALL ADMOVE
  LD A,(P1)            ; Check Pawn moved flag
  BIT 3,A              ; Has it moved before ?
  JR NZ,MP20_0
  DJNZ MP10
MP20_0:
  POP DE
  RET

MP36:
  EX AF,AF'             ; Is diagonal square empty ?
  JR Z,ENPSNT           ; Try en passant capture
  EX AF,AF'
  CALL ADMOVE
  JP MP15

; Routine at 4153
;
; Used by the routine at MP20 (MPIECE).
ENPSNT:
  LD A,(M1)            ; Set position of Pawn
  LD HL,P1             ; Check color
  BIT 7,(HL)           ; Is it white ?
  JR Z,JR2             ; Yes - skip
  ADD A,10             ; Add 10 for black

; Routine at 4165
;
; Used by the routine at ENPSNT.
JR2:
  CP 61                 ; On en passant capture rank ?
  JP C,MP15             ;   No - return
  CP 69                 ; On en passant capture rank ?
  JP NC,MP15            ;   No - return
  LD IX,(MLPTRJ)        ; Get pointer to previous move
  BIT 4,(IX+$04)        ; First move for that piece ?
  JP Z,MP15             ;   No - return
  LD A,(IX+$03)         ; Get "to" position
  LD (M4),A             ; Store as index to board
  LD IX,(M4)            ; Load board index
  LD A,(IX+$00)         ; Get piece moved
  LD (P3),A             ; Save it
  AND $07               ; Get piece type
  CP PAWN               ; Is it a Pawn ?
  JP NZ,MP15            ;   No - return
  LD A,(M4)             ; Get "to" position
  SUB E                 ; Find difference
  JP P,JP1              ; Positive ? Yes - Jump
  NEG                   ; Else take absolute value

; Routine at 4218
;
; Used by the routine at ENPSNT.
JP1:
  CP 10                 ; Is difference 10 ?
  JP NZ,MP15            ; No - return
  LD A,$40              ; Address of flags
  EX AF,AF'             ; Set double move flag
  CALL ADMOVE           ; Add Pawn move to move list
  LD A,(M1)             ; Save initial Pawn position
  LD (M3),A             ; Set "from" and "to" positions
                        ; for dummy move
  LD A,(M4)
  LD (M1),A
  LD E,A
  LD A,(P3)             ; Save captured Pawn
  EX AF,AF'
  CALL ADMOVE           ; Add Pawn capture to move list
  LD A,(M3)             ; Restore "from" position
  LD (M1),A

; ADJUST MOVE LIST POINTER FOR DOUBLE MOVE
ADJPTR:
  LD HL,(MLLST)         ; Get list pointer
  DEC HL                ; Back up list pointer
  DEC HL
  DEC HL
  DEC HL
  XOR A
  LD (HL),A             ; Zero out link, last byte
  DEC HL
  LD (HL),A             ; First byte
  LD (MLLST),HL
  JP MP15

; CASTLE ROUTINE
;
; Used by the routine at GENMOV.
CASTLE:
  CALL INCHK
  RET NZ
  LD A,E
  LD (M1),A           ; King position
  LD A,(DE)           ; Get King
  BIT 3,A             ; Has it moved ?
  RET NZ              ; Yes - return
  LD BC,$02FF         ; Initialize King-side values
  LD A,$03            ; King position
CA5:
  PUSH DE
  ADD A,E             ; Rook position
  LD E,A              ; Save
  LD (M2),A           ; Store as board index
  LD A,(DE)           ; Get contents of board
  AND $7F             ; Clear color bit
  CP ROOK             ; Has Rook ever moved ?
  JR NZ,CA20          ; Yes - Jump
CA10:
  LD A,E
  ADD A,C             ; Restore Rook position
  LD E,A
  LD A,(DE)           ; Get contents of board
  AND A               ; Empty ?
  JR NZ,CA20          ; No - Jump
  LD A,B
  CP $03
  JR Z,CA15
  CALL ATTACK
  JR NZ,CA20          ; Any attackers ?  Jump.
CA15:
  DJNZ CA10
  LD A,E
  SUB C               ; Get Rook "to" position
  LD E,A
  LD A,$40            ; Set double move flag
  EX AF,AF'           ; On previous versions P2 was used to store flags
  CALL ADMOVE         ; Put king move in list
  LD A,(M2)
  LD (M1),A           ; Addr of King "from" position
  LD A,E
  ADD A,C
  LD E,A
  XOR A               ; Zero move flags
  EX AF,AF'
  CALL ADMOVE         ; Put Rook move in list
  LD HL,(MLLST)
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  XOR A
  LD (HL),A
  DEC HL
  LD (HL),A
  LD (MLLST),HL

CA20:
  POP DE
  BIT 7,C
  RET Z
  LD A,E
  LD (M1),A
  LD BC,$0301     ; Set Queen-side..
  LD A,$FC        ;    ..initial values
  JP CA5

; *******************************************************
;   ADMOVE ROUTINE
; *******************************************************
; FUNCTION: --  To add a move to the move list
; 
; Used by the routines at MPIECE, MP20, JP1 and CASTLE.
ADMOVE:
  LD IX,(MLLST)         ; Addr of prev. list area
  LD HL,(MLNXT)         ; Addr of next loc in move list
  LD (MLLST),HL         ; Savn next as previous
  LD (IX+$00),L         ; Store link address
  LD (IX+$01),H
  XOR A
  LD (HL),A             ; Store zero in link address
  INC HL
  LD (HL),A
  INC HL
  LD A,(M1)             ; Store "from" move position
  LD (HL),A
  INC HL
  LD (HL),E             ; Store "to" move position
  INC HL
  EX AF,AF'
  LD (HL),A
  INC HL
  LD (MLNXT),HL         ; Save address for next move
  RET                   ; Return


; GENERATE MOVE ROUTINE
;
; Used by the routines at rel018, FM35_SUB and GAME_DRIVER.
GENMOV:
  LD DE,(MLNXT)         ; Addr of next avail list space
  LD HL,(MLPTRI)        ; Ply list pointer index
  INC HL                ; Increment to next ply
  INC HL
  LD (HL),E             ; Save move list pointer
  INC HL
  LD (HL),D
  INC HL
  LD (MLPTRI),HL        ; Save new index
  LD (MLLST),HL         ; Last pointer for chain init.
  CALL CASTLE
  LD DE,TOP_LEFT
GM5:
  LD A,(DE)             ; Fetch board contents
  AND A                 ; Is it empty ?
  JR Z,GM10             ; Yes - Jump
  CP -1                 ; Is it a boarder square ?
  JR Z,GM10             ; Yes - Jump
  LD HL,COLOR
  XOR (HL)              ; Test color of piece
  BIT 7,A               ; Match ?
  JR NZ,GM10            ; No, skip
  XOR (HL)              ; Restore color of piece
  LD (P1),A             ; Save piece
  AND $07
  LD (T1),A             ; Save piece type
  LD A,E
  LD (M1),A
  CALL MPIECE           ; call Move Piece
GM10:
  INC E               ; Incr to next board position
  LD A,E
  CP 99               ; End of board array ?
  JP NZ,GM5           ; No - Jump
  RET                 ; Return


; Routine at 4474
;
; Used by the routines at CASTLE, FM35 and FM35_SUB.
ATTACK:
  PUSH BC             ; Save Register B
  LD B,16             ; Initial direction count
  XOR A               ; Clear
  LD (INDX2),A        ; Initial direction index
  LD IY,(INDX2)       ; Load index
AT5:
  PUSH DE
  LD C,(IY-DIRECT)    ; Get direction
  LD L,$FE            ; Init. scan count/flags
AT10:
  INC L               ; Increment scan count
  LD A,E
  ADD A,C
  LD E,A
  LD A,(DE)
  CP $FF
  JR Z,AT12
  AND A               ; Empty position ?
  JR NZ,AT14          ; No - jump
  LD A,B              ; Fetch direction count
  CP $09              ; On knight scan ?
  JR NC,AT10          ; No - jump
AT12:
  INC IY              ; Increment direction index
  POP DE
  DJNZ AT5            ; Done ? No - jump
  POP BC
  XOR A
  RET

; ***** DETERMINE IF PIECE ENCOUNTERED ATTACKS SQUARE *****
AT14:
  LD H,A
  LD A,(P1)           ; Fetch piece including color
  XOR H               ; Test color of piece
  BIT 7,A             ; Match ?
  JR Z,AT12
  LD A,H
  AND $07
  EX AF,AF'           ; Save piece type
  LD A,B              ; Get direction-counter
  CP 9                ; Look for Knights ?
  JR C,AT25
  EX AF,AF'           ; Get piece type
  CP QUEEN            ; Is it a Queen ?
  JR Z,AT30
  BIT 7,L
  JR Z,AT16
  CP KING             ; Is it a King ?
  JR Z,AT30
AT16:
  EX AF,AF'           ; Get direction counter
  CP 13               ; Scanning files or ranks ?
  JR C,AT21
  EX AF,AF'           ; Get piece type
  CP BISHOP           ; Is it a Bishop ?
  JR Z,AT30
  BIT 7,L
  JR Z,AT12
  CP 1                ; On first position ?
  JR NZ,AT12
  LD A,(P1)           ; Fetch piece including color
  BIT 7,A             ; Is it white ?
  JR NZ,AT20          ; Yes - jump
  EX AF,AF'           ; Get direction counter
  CP 15               ; On a non-attacking diagonal ?
  JR C,AT12
  JP AT30

AT20:
  EX AF,AF'           ; Get direction counter
  CP 15               ; On a non-attacking diagonal ?
  JR NC,AT12
  JP AT30

AT21:
  EX AF,AF'           ; Get piece type
  CP ROOK             ; Is it a Rook ?
  JR NZ,AT12
  JP AT30

AT25:
  EX AF,AF'           ; Get piece type
  CP KNIGHT           ; Is it a Knight ?
  JR NZ,AT12
AT30:
  POP DE
  POP BC
  OR $01              ; Set attacker found flag
  RET

; This entry point is used by the routine at NEXTAD.
PATH:
  XOR A
  LD (POSQ+1),A
  LD A,$7F
  LD (POSQ),A
  LD DE,TOP_LEFT      ; Board pointer
PATH_00:
  LD A,(DE)           ; Get contents of board
  AND A               ; empty?
  JP Z,PA2
  CP -1               ; In boarder area ?
  JP Z,PA2            ; Yes - jump
  LD (P1),A           ; Save piece
  AND $07             ; Clear flags
  LD (T1),A           ; Save piece type
  LD IY,(T1)          ; Load index to DCOUNT/DPOINT
  LD B,(IY-DCOUNT)    ; Get direction count
  LD A,(IY-DPOINT)    ; Get direction pointer
  CP $10
  JR NZ,PA1
  DEC B
  DEC B
  LD HL,P1
  BIT 7,(HL)
  JR Z,PA1
  ADD A,$04
PA1:
  LD (INDX2),A         ; Init direction index
  LD IY,(INDX2)
PATH_01:
  PUSH DE
  LD C,(IY-DIRECT)     ; Get direction of scan
  XOR A
  LD (INDX2),A
  LD A,E
  LD (M1),A
; This entry point is used by the routine at JR12.
ATTACK_13:
  LD A,C
  ADD A,E
  LD E,A
  LD A,(DE)
  CP -1
  JR NZ,ATTACK_16
; This entry point is used by the routine at JR12.
ATTACK_14:
  INC IY
  POP DE
  DJNZ PATH_01
PA2:
  INC E
  LD A,E
  CP 99                ; End of board array ?
  JP NZ,PATH_00        ; No - Jump
  RET

ATTACK_16:
  LD HL,INDX2
  BIT 1,(HL)
  JR NZ,JR12_3
  LD HL,PTSW2
  ADD HL,DE
  LD A,(HL)
  SRA A
  LD HL,P1             ; Get piece
  BIT 7,(HL)           ; Test color
  JR Z,JR12            ; Jump if white
  NEG                  ; Negate for black

; Routine at 4724
;
; Used by the routine at ATTACK.
JR12:
  LD HL,MTRL           ; Get addrs of material total
  ADD A,(HL)           ; Add new value
  LD (HL),A            ; Store
  LD A,(DE)            ; Get current board position
  AND A
  JR Z,JR12_6
  LD H,A
  LD A,(P1)
  XOR H                ; Test color of piece
  BIT 7,A              ; Match ?
  JR Z,JR12_4
  LD A,H
  AND $07
  CP $06
  JR NZ,JR12_0
  LD A,(COLOR)
  XOR H                ; Test color of piece
  BIT 7,A              ; Match ?
  JP Z,JR12_12
  LD A,$01
  LD (L0138),A
JR12_0:
  LD HL,INDX2
  BIT 0,(HL)
  JR NZ,JR12_1
  SET 1,(HL)
JR12_1:
  SET 7,(HL)
JR12_2:
  LD HL,POSQ
  LD A,(HL)
  DEC (HL)
  JP JR12_5

; This entry point is used by the routine at ATTACK.
JR12_3:
  AND A
  JR Z,ATTACK_13
  LD H,A
  AND $07
  CP $01
  JR Z,ATTACK_14
  LD A,(P1)
  XOR H                 ; Test color of piece
  BIT 7,A               ; Match ?
  JR Z,ATTACK_14
  SET 7,E
  LD HL,INDX2
  RES 1,(HL)
  JP JR12_2
  
JR12_4:
  LD HL,INDX2
  SET 0,(HL)
  LD HL,POSQ+1
  LD A,(HL)
  INC (HL)
JR12_5:
  LD HL,L0400
  LD L,A
  LD (HL),E
  SET 7,L
  LD A,(M1)
  LD (HL),A
JR12_6:
  LD A,(T1)             ; Piece type
  CP $03
  JP C,ATTACK_14
  CP $06
  JP Z,ATTACK_14
  LD HL,INDX2
  BIT 1,(HL)
  JP NZ,ATTACK_13
  BIT 7,(HL)
  JP NZ,ATTACK_14
  EX AF,AF'
  LD A,(DE)
  AND $07
  JP Z,ATTACK_13
  EX AF,AF'
  CP $04
  JR NZ,JR12_7
  EX AF,AF'
  CP $04
  JP Z,ATTACK_13
  CP $05
  JP NZ,ATTACK_14
  LD HL,M1
  SET 7,(HL)
  JP ATTACK_13
  
JR12_7:
  CP $03
  JR NZ,JR12_8
  EX AF,AF'
  CP $01
  JR Z,JR12_11
  CP $05
  JP NZ,ATTACK_14
  LD HL,M1
  SET 7,(HL)
  JP ATTACK_13
JR12_8:
  EX AF,AF'
  CP $03
  JR NZ,JR12_9
  LD A,B
  CP $05
  JP C,ATTACK_14
  JP ATTACK_13
JR12_9:
  CP $04
  JR NZ,JR12_10
  LD A,B
  CP $05
  JP C,ATTACK_13
  JP ATTACK_14
JR12_10:
  CP $05
  JP Z,ATTACK_13
  CP $01
  JP NZ,ATTACK_14
  LD A,B
  CP $05
  JP C,ATTACK_14
JR12_11:
  LD A,(P1)
  XOR C                    ; Test color of piece
  BIT 7,A                  ; Match ?
  JP NZ,ATTACK_14
  LD HL,INDX2
  SET 7,(HL)
  JP ATTACK_13
JR12_12:
  POP DE
  POP HL
  RET

; This entry point is used by the routine at NEXTAD.
JR12_13:
  LD A,(POSQ)
  NEG
  ADD A,$7F
  RET Z
  LD HL,L047F
  LD B,A
JR12_14:
  BIT 7,(HL)
  JR NZ,JR12_16
JR12_15:
  DEC L
  DJNZ JR12_14
  RET

JR12_16:
  PUSH HL
  PUSH BC
  LD A,(HL)
  AND $7F
  LD D,A
  INC L
  LD E,(HL)
  SET 7,L
  LD C,(HL)
  EXX
  LD HL,BOARDA
  LD L,A
  LD A,(HL)
  AND $07
  LD E,A
  EXX
  CP $06
  JR Z,JR12_18
  LD A,C
  EXX
  LD L,A
  LD A,(HL)
  AND $07
  CP E
  EXX
  JR C,JR12_18
  LD HL,L0400
  LD A,(POSQ+1)
  AND A
  JR Z,JR12_25
  LD B,A
  LD A,D
JR12_17:
  CP (HL)
  JP Z,JR12_35
  INC L
  DJNZ JR12_17
JR12_18:
  LD HL,L0480
  LD A,(POSQ+1)
  AND A
  JR Z,JR12_25
  LD B,A
JR12_19:
  LD A,(HL)
  AND $7F
  CP E
  JR NZ,JR12_24
  RES 7,L
  LD A,(HL)
  AND $7F
  CP D
  JR Z,JR12_23
  EXX
  LD L,A
  LD A,E
  CP $06
  EXX
  JR Z,JR12_20
  EXX
  LD A,(HL)
  AND $07
  CP E
  EXX
  JR NC,JR12_23
JR12_20:
  PUSH DE
  PUSH BC
  PUSH HL
  LD A,(HL)
  AND $7F
  LD D,A
  LD HL,L04FF
  LD A,(POSQ)
  NEG
  ADD A,$7F
  LD B,A
JR12_21:
  LD A,(HL)
  AND $7F
  CP C
  JR NZ,JR12_22
  RES 7,L
  LD A,(HL)
  SET 7,L
  AND $7F
  CP D
  JR NZ,JR12_22
  POP HL
  POP BC
  POP DE
  JP JR12_23

JR12_22:
  DEC L
  DJNZ JR12_21
  POP HL
  POP BC
  POP DE
  LD (HL),$00
JR12_23:
  SET 7,L
JR12_24:
  INC L
  DJNZ JR12_19
JR12_25:
  LD HL,L04FF
  LD A,(POSQ)
  NEG
  ADD A,$7F
  LD B,A
JR12_26:
  LD A,(HL)
  AND $7F
  CP E
  JR NZ,JR12_34
  RES 7,L
  LD A,(HL)
  AND $7F
  CP C
  JR Z,JR12_33
  EXX
  LD L,A
  LD A,E
  CP $06
  EXX
  JR Z,JR12_29
  EXX
  LD A,(HL)
  AND $07
  CP E
  EXX
  JR NC,JR12_33
  DEC L
  DJNZ JR12_28
  INC B
JR12_27:
  INC L
  JP JR12_29
  
JR12_28:
  BIT 7,(HL)
  JR Z,JR12_27
  LD A,(HL)
  AND $7F
  EXX
  LD L,A
  LD A,(HL)
  AND $07
  CP E
  EXX
  JR NC,JR12_33
  INC L
  LD (HL),$00
  DEC L
JR12_29:
  LD A,(POSQ+1)
  AND A
  JR Z,JR12_32
  PUSH DE
  PUSH BC
  PUSH HL
  LD B,A
  LD A,(HL)
  AND $7F
  LD D,A
  LD HL,L0480
JR12_30:
  LD A,(HL)
  AND $7F
  CP C
  JR NZ,JR12_31
  RES 7,L
  LD A,(HL)
  SET 7,L
  AND $7F
  CP D
  JR NZ,JR12_31
  POP HL
  POP BC
  POP DE
  JP JR12_33

JR12_31:
  INC L
  DJNZ JR12_30
  POP HL
  POP BC
  POP DE
JR12_32:
  LD (HL),$00
JR12_33:
  SET 7,L
JR12_34:
  DEC L
  DJNZ JR12_26
JR12_35:
  POP BC
  POP HL
  JP JR12_15

; Routine at 5265
;
; Used by the routine at NEXTAD.
PINFND_SUB:
  EXX
  XOR A                ; Zero out attack list
  LD B,14
  LD HL,WACT

; Routine at 5272
LP2:
  LD (HL),A
  INC L
  DJNZ LP2
  EXX
  LD C,$00
LP2_0:
  SET 7,(HL)
  PUSH HL
  SET 7,L
  LD E,(HL)
  LD A,E
  AND $7F
  LD HL,BOARDA
  LD L,A
  LD A,(HL)
  LD HL,WACT           ; White queen attackers
  BIT 7,A              ; Test color of piece
  JR Z,LP2_1           ; Jump if white
  LD HL,BACT           ; Black queen attackers
LP2_1:
  INC (HL)
  AND $07
  LD D,A
  BIT 7,E
  JR Z,LP2_3
  LD A,$05
  ADD A,L
  LD L,A
  LD A,(HL)            ; Number of defenders
  AND $0F
  JR Z,LP2_4
  LD A,(HL)
  AND $F0
  JR Z,LP2_2
  INC L
  JP LP2_4

LP2_2:
  RLD
  LD A,D
  RRD
  JP LP2_6

LP2_3:
  ADD A,L
  LD L,A
LP2_4:
  LD A,D
LP2_5:
  RLD
  AND A
  JR Z,LP2_6
  INC L
  JP LP2_5

LP2_6:
  POP HL
  LD A,(M2)
  BIT 0,C
  JR Z,LP2_9
LP2_7:
  DJNZ LP2_8
  RET

LP2_8:
  INC L
  CP (HL)
  JR NZ,LP2_7
  JP LP2_0
  
LP2_9:
  DJNZ LP2_10
  LD HL,POSQ+1
  LD B,(HL)
  LD HL,L0400
  SET 0,C
  INC B
  DEC L
  JP LP2_7
  
LP2_10:
  DEC L
  CP (HL)
  JR NZ,LP2_9
  JP LP2_0


;
; EXCHANGE ROUTINE
;

; Used by the routine at NEXTAD.
XCHNG:
  LD IX,(M2)
  LD A,(IX+$00)      ; Piece attacked
  LD (P1),A
  
  ;setup values for "NEXT ATTACKER/DEFENDER ROUTINE"
  EXX                ; Swap regs
  LD HL,WACT         ; White queen attackers
  LD DE,BACT         ; Black queen attackers
  BIT 7,A            ; Is it a white queen ?
  JR NZ,JR8          ; Yes - jump
  EX DE,HL           ; Swap list pointers
JR8:
  LD C,(HL)          ; Init list counts
  EX DE,HL
  LD B,(HL)
  EXX                ; Restore regs.

  AND $07
  LD (T1),A
  LD IX,(T1)         ; Load piece value index (T3 was used on previous version)
  LD A,(IX-PVALUE)
  
  ADD A,$80
  LD D,A
  LD B,A             ; Init points lost count
  LD HL,$0000
XCHNG_1:
  CALL NEXTAD        ; Retrieve next attacker value
  JR Z,XCHNG_3
  NEG
  ADD A,B            ;  Total points lost
  LD B,A
  CP H
  JR C,XCHNG_2
  LD H,B
  LD E,D
XCHNG_2:
  CALL NEXTAD        ; Retrieve next defender value
  JR Z,XCHNG_4
  ADD A,B            ;  Total points lost
  LD B,A             ;  Save total
  CP D
  JR NC,XCHNG_1
  LD D,B
  LD L,H
  JP XCHNG_1
XCHNG_3:
  LD A,H
  CP E
  RET C
  LD A,E
  RET

XCHNG_4:
  LD A,D             ; Get attacked value
  CP L               ; Attacked less than attacker ?
  RET NC             ; No - ret
  LD A,L
  RET


; NEXT ATTACKER/DEFENDER ROUTINE
;
; Used by the routine at XCHNG.
NEXTAD:
  EXX                ; Swap registers
  LD A,C             ; Swap list counts
  LD C,B
  LD B,A
  EX DE,HL           ; Swap list pointers
  AND A
  JR Z,NEXTAD_0
  XOR A
  DEC B
back03:
  INC HL             ; Increment list inter
  CP (HL)            ; Check next item in list
  JR Z,back03        ; Jump if empty
  RRD                ; Get value from list
  LD (T1),A
  LD IX,(T1)
  LD A,(IX-PVALUE)
  DEC HL
NEXTAD_0:
  EXX                ; Restore regs.
  RET

; This entry point is used by the routines at FM35_SUB and GAME_DRIVER.
CK_BESTM:
  LD HL,(BESTM)
  INC HL
  LD A,H
  OR L
  JR NZ,NEXTAD_2
  DEC HL
NEXTAD_2:
  LD (BESTM),HL
  XOR A
  LD B,$09
  LD HL,L0138
NEXTAD_3:
  LD (HL),A
  INC L
  DJNZ NEXTAD_3
  CALL PATH
  CALL JR12_13
  LD A,(POSQ)
  NEG
  ADD A,$7F
  JR Z,CK_BESTM2
  LD B,A
  LD HL,L047F
NEXTAD_4:
  LD A,(HL)
  BIT 7,A
  JR NZ,CK_BESTM1
  AND A
  JR Z,CK_BESTM1
  LD (M2),A
  PUSH HL                ; Save regs.
  PUSH BC
  CALL PINFND_SUB        ; Find attackers/defenders
  CALL XCHNG             ; Evaluate exchange, if any
  SUB $80
  JP M,CK_BESTM0
  JR Z,NEXTAD_6
  LD E,A
  LD A,(P1)
  LD HL,COLOR
  XOR (HL)
  BIT 7,A
  LD A,E
  JR NZ,NEXTAD_7
  LD HL,L013B
  CP (HL)
  JR C,NEXTAD_5
  LD (HL),E
NEXTAD_5:
  LD A,(L013F)
  SUB $08
  LD (L013F),A
NEXTAD_6:
  LD IX,(MLPTRJ)
  LD A,(M2)
  CP (IX+$03)
  JR NZ,CK_BESTM0
  LD (L013E),A
  JP CK_BESTM0

NEXTAD_7:
  LD HL,L013C
  CP (HL)
  JR C,NEXTAD_8
  LD A,(HL)
  LD (HL),E
NEXTAD_8:
  LD HL,L013D
  CP (HL)
  JR C,NEXTAD_9
  LD (HL),A
NEXTAD_9:
  LD A,(L013F)
  ADD A,$04
  LD (L013F),A

CK_BESTM0:
  POP BC
  POP HL

CK_BESTM1:
  DEC L
  DJNZ NEXTAD_4
  LD A,(L013E)
  AND A
  JR Z,CK_BESTM2
  XOR A
  LD (L013D),A

CK_BESTM2:
  LD A,(CKFLG)
  AND A
  CALL NZ,MOVE_CAPTURE_21
  CALL NEXTAD_20
  LD A,(L013D)
  LD HL,L013B
  SUB (HL)
  SUB (HL)
  LD HL,COLOR
  LD C,(HL)
  BIT 7,C
  JR Z,CK_BESTM3
  NEG
CK_BESTM3:
  LD HL,MTRL_B        ; Get material points
  ADD A,(HL)          ; Multiply
  ADD A,(HL)
  LD H,A
  LD L,$00
  LD A,(L013B)
  ADD A,A
  LD B,A
  LD A,(L013C)
  SUB B
  LD B,A
  LD A,(L013F)
  ADD A,B
  BIT 7,C
  JR Z,CK_BESTM4
  NEG
CK_BESTM4:
  LD D,$00
  LD E,A
  RLA
  JR NC,CK_BESTM5
  LD D,$FF
CK_BESTM5:
  ADD HL,DE
  LD A,(MTRL)
  LD D,$00
  LD E,A
  RLA
  JR NC,CK_BESTM6
  LD D,$FF
CK_BESTM6:
  ADD HL,DE
  LD A,(MTRL_A)
  LD D,$00
  LD E,A
  RLA
  JR NC,CK_BESTM7
  LD D,$FF
CK_BESTM7:
  ADD HL,DE
  ADD HL,DE
  LD A,(L0144)
  LD D,$00
  LD E,A
  RLA
  JR NC,CK_BESTM8
  LD D,$FF
CK_BESTM8:
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
  BIT 7,C
  JR Z,CK_BESTM9
  EX DE,HL
  LD HL,$0000
  AND A
  SBC HL,DE
CK_BESTM9:
  LD DE,$8000
  ADD HL,DE
  LD (VALM),HL
  RET

NEXTAD_20:
  XOR A
  EX AF,AF'
  LD HL,$0000
  LD C,$00
  LD (L0145),HL
  LD DE,L021F
NEXTAD_21:
  LD B,$06
NEXTAD_22:
  LD A,(DE)
  AND $07
  CP $01
  JR NZ,NEXTAD_26
  LD A,(DE)
  RLA
  JR C,NEXTAD_24
  LD A,H
  AND A
  JR Z,NEXTAD_23
  LD A,$FC
  ADD A,C
  LD C,A
  LD H,B
  JP NEXTAD_26
NEXTAD_23:
  LD H,B
  JP NEXTAD_26
NEXTAD_24:
  LD A,L
  AND A
  JR Z,NEXTAD_25
  LD A,$04
  ADD A,C
  LD C,A
  JP NEXTAD_26
NEXTAD_25:
  LD L,B
NEXTAD_26:
  LD A,$0A
  ADD A,E
  LD E,A
  DJNZ NEXTAD_22
  PUSH DE
  LD DE,(L0145)
  EX AF,AF'
  LD B,A
  LD A,L
  AND A
  JR NZ,NEXTAD_34
  LD A,H
  AND A
  JR Z,NEXTAD_33
  SET 6,B
  LD A,(PMATE)
  CP $14
  JR NC,NEXTAD_27
  LD A,$04
  JP NEXTAD_29
NEXTAD_27:
  PUSH BC
  LD A,$07
  SUB H
  LD B,A
  XOR A
  SCF
NEXTAD_28:
  RLA
  DJNZ NEXTAD_28
  POP BC
NEXTAD_29:
  ADD A,C
  LD C,A
  LD A,D
  AND A
  JR Z,NEXTAD_31
  CP H
  JR Z,NEXTAD_30
  DEC A
  CP H
  JR Z,NEXTAD_30
  ADD A,$02
  CP H
  JR NZ,NEXTAD_31
NEXTAD_30:
  LD A,$02
  ADD A,C
  LD C,A
NEXTAD_31:
  LD A,E
  AND A
  JR Z,NEXTAD_32
  CP H
  JR C,NEXTAD_33
NEXTAD_32:
  SET 7,B
NEXTAD_33:
  LD A,E
  AND A
  JR Z,NEXTAD_34
  LD A,$04
  ADD A,C
  LD C,A
NEXTAD_34:
  LD A,H
  AND A
  JR NZ,NEXTAD_41
  LD A,L
  AND A
  JR Z,NEXTAD_40
  SET 4,B
  LD A,(PMATE)
  CP $14
  JR NC,NEXTAD_35
  LD A,$FC
  JP NEXTAD_37
NEXTAD_35:
  PUSH BC
  LD B,L
  XOR A
  SCF
NEXTAD_36:
  RLA
  DJNZ NEXTAD_36
  NEG
  POP BC
NEXTAD_37:
  ADD A,C
  LD C,A
  LD A,E
  AND A
  JR Z,NEXTAD_39
  CP L
  JR Z,NEXTAD_38
  INC A
  CP L
  JR Z,NEXTAD_38
  SUB $02
  CP L
  JR NZ,NEXTAD_39
NEXTAD_38:
  LD A,$FE
  ADD A,C
  LD C,A
NEXTAD_39:
  LD A,L
  CP D
  JR C,NEXTAD_40
  SET 5,B
NEXTAD_40:
  LD A,D
  AND A
  JR Z,NEXTAD_41
  LD A,$FC
  ADD A,C
  LD C,A
NEXTAD_41:
  BIT 2,B
  JR Z,NEXTAD_45
  LD A,H
  AND A
  JR Z,NEXTAD_43
  CP D
  JR Z,NEXTAD_42
  INC A
  CP D
  JR Z,NEXTAD_42
  SUB $02
  CP D
  JR NZ,NEXTAD_43
NEXTAD_42:
  LD A,$02
  ADD A,C
  LD C,A
NEXTAD_43:
  BIT 3,B
  JR Z,NEXTAD_45
  LD A,L
  AND A
  JR Z,NEXTAD_44
  CP D
  JR C,NEXTAD_45
NEXTAD_44:
  LD A,$04
  ADD A,C
  LD C,A
NEXTAD_45:
  BIT 0,B
  JR Z,NEXTAD_48
  LD A,L
  AND A
  JR Z,NEXTAD_47
  CP E
  JR Z,NEXTAD_46
  DEC A
  CP E
  JR Z,NEXTAD_46
  ADD A,$02
  CP E
  JR NZ,NEXTAD_47
NEXTAD_46:
  LD A,$FE
  ADD A,C
  LD C,A
NEXTAD_47:
  BIT 1,B
  JR Z,NEXTAD_48
  LD A,E
  CP H
  JR C,NEXTAD_48
  LD A,$FC
  ADD A,C
  LD C,A
NEXTAD_48:
  SRL B
  SRL B
  SRL B
  SRL B
  LD A,B
  EX AF,AF'
  LD (L0145),HL
  LD HL,$0000
  POP DE
  LD A,E
  SUB $3B
  LD E,A
  CP $27
  JR NZ,NEXTAD_49
  PUSH DE
  JP NEXTAD_41
NEXTAD_49:
  CP $EC
  JP NZ,NEXTAD_21
  LD A,C
  LD (L0144),A
  RET


; Routine at 6098
;
; Used by the routines at MV1 and UNMOVE.
MOVE_CAPTURE:
  LD A,$07
  AND E
  RET Z
  CP $01
  JP NZ,MOVE_CAPTURE_7
  LD A,(M1)
  LD B,A
  LD A,(M2)
  CP B
  RET Z
  LD A,(PMATE)
  CP $0A
  JR NC,MOVE_CAPTURE_2
  LD A,B
  BIT 7,E
  JR Z,MOVE_CAPTURE_0
  SUB $32
MOVE_CAPTURE_0:
  CP $22
  JR Z,MOVE_CAPTURE_1
  CP $23
  JR Z,MOVE_CAPTURE_1
  LD B,$F8
  JP MOVE_CAPTURE_18
  
MOVE_CAPTURE_1:
  LD B,$04
  LD HL,M2
  SUB (HL)
  CP $EC
  JP Z,MOVE_CAPTURE_14
  CP $E2
  JP Z,MOVE_CAPTURE_14
  RET

MOVE_CAPTURE_2:
  CP $19
  RET NC
  BIT 7,E
  JR NZ,MOVE_CAPTURE_4
  LD A,(POSK)
  CP $1A                	; White O-O ?
  JR C,MOVE_CAPTURE_3
  CP $1D
  RET NC
  LD B,$00
  JP MOVE_CAPTURE_6
  
MOVE_CAPTURE_3:
  CP $18
  RET NC
  LD B,$05
  JP MOVE_CAPTURE_6
  
MOVE_CAPTURE_4:
  LD A,(POSK+1)
  CP $60                    ; Black 0-0 ?
  JR C,MOVE_CAPTURE_5
  LD B,$CE
  JP MOVE_CAPTURE_6

MOVE_CAPTURE_5:
  CP $5E
  RET NC
  CP $5B
  RET C
  LD B,$D3
MOVE_CAPTURE_6:
  LD A,(M1)
  ADD A,B
  CP $27
  RET NC
  CP $24
  RET C
  LD B,$F4
  JP MOVE_CAPTURE_18

MOVE_CAPTURE_7:
  CP $04
  JR C,MOVE_CAPTURE_11
  CP $06
  JR Z,MOVE_CAPTURE_8
  LD A,(PMATE)
  CP $07
  JR NC,MOVE_CAPTURE_13
  LD B,$F0
  JP MOVE_CAPTURE_18
  
MOVE_CAPTURE_8:
  BIT 6,D
  JR Z,MOVE_CAPTURE_10
  LD A,(M2)
  BIT 7,E
  JR Z,MOVE_CAPTURE_9
  SUB $46
MOVE_CAPTURE_9:
  LD B,$0C
  CP $1B
  JR Z,MOVE_CAPTURE_18
  LD B,$06
  JP MOVE_CAPTURE_18

MOVE_CAPTURE_10:
  LD A,(PMATE)
  CP $1E
  RET NC
  LD B,$F4
  JP MOVE_CAPTURE_18

MOVE_CAPTURE_11:
  BIT 4,(HL)
  JR Z,MOVE_CAPTURE_12
  LD B,$08
  JP MOVE_CAPTURE_14
  
MOVE_CAPTURE_12:
  LD A,(PMATE)
  CP $09
  RET NC
  LD B,$F0
  JP MOVE_CAPTURE_14
  
MOVE_CAPTURE_13:
  BIT 5,(HL)
  RET Z
  LD A,$F9
  BIT 7,E
  CALL UNMOVE_CAPTURE_2
  RET

MOVE_CAPTURE_14:
  LD A,(PMATE)
  CP $0F
  JR NC,MOVE_CAPTURE_18
  LD A,(M2)
  BIT 7,E
  JR Z,MOVE_CAPTURE_15
  SUB $1E
MOVE_CAPTURE_15:
  CP ','
  JR Z,MOVE_CAPTURE_16
  CP '-'
  JR NZ,MOVE_CAPTURE_18
MOVE_CAPTURE_16:
  SUB $0A
  BIT 7,E
  JR Z,MOVE_CAPTURE_17
  ADD A,$32
MOVE_CAPTURE_17:
  LD HL,BOARDA
  LD L,A
  LD A,(HL)
  AND $07
  CP $01
  JR NZ,MOVE_CAPTURE_18
  LD B,$E8              ; 'h'+$80
MOVE_CAPTURE_18:
  LD A,B
  BIT 0,C
  JR Z,MOVE_CAPTURE_19
  NEG
MOVE_CAPTURE_19:
  BIT 7,E
  JR Z,MOVE_CAPTURE_20
  NEG
MOVE_CAPTURE_20:
  LD HL,MTRL_A
  ADD A,(HL)
  LD (HL),A
  RET

; This entry point is used by the routine at NEXTAD.
MOVE_CAPTURE_21:
  LD A,(POSK)
  LD D,A
  XOR A
  LD E,10
  CALL DIVIDE
  LD B,A
  LD C,D
  LD A,(POSK+1)
  LD D,A
  XOR A
  CALL DIVIDE
  SUB B
  JP P,MOVE_CAPTURE_22
  NEG
MOVE_CAPTURE_22:
  LD B,A
  LD A,C
  SUB D
  JP P,MOVE_CAPTURE_23
  NEG
MOVE_CAPTURE_23:
  ADD A,B
  NEG
  ADD A,$0E
  LD B,A
  LD A,(MTRL_B)
  LD HL,POSK
  BIT 7,A
  JR NZ,MOVE_CAPTURE_24
  INC L
MOVE_CAPTURE_24:
  LD DE,TOP_LEFT
  LD E,(HL)
  LD HL,PTSW2
  ADD HL,DE
  LD A,(HL)
  NEG
  ADD A,$08
  ADD A,A
  ADD A,B
  LD B,A
  LD A,(MTRL_B)
  BIT 7,A
  LD A,B
  JR Z,MOVE_CAPTURE_25
  NEG
MOVE_CAPTURE_25:
  ADD A,A
  ADD A,A
  LD (MTRL),A
  XOR A
  LD (L013C),A
  RET


; MOVE ROUTINE
;
; Used by the routines at SORT_SUB and GAME_DRIVER.
MOVE:
  LD HL,(MLPTRJ)        ; Load move list pointer
  INC HL                ; Increment past link bytes
  INC HL

; Routine at 6467
MV1:
  LD A,(HL)             ; "From" position
  LD (M1),A             ; Save
  INC HL                ; Increment pointer
  LD A,(HL)             ; "To" position
  LD (M2),A             ; Save
  INC HL                ; Increment pointer
  LD D,(HL)             ; Get captured piece/flags
  LD IX,(M1)            ; Load "from" pos board index
  LD E,(IX+$00)         ; Get piece moved
  BIT 3,E               ; ..possibly this part is related to castling
  JR NZ,MV1_0
  SET 4,(HL)
  SET 3,E               ; Set piece moved flag
MV1_0:
  LD A,E                ; Piece moved
  AND $07               ; Clear flag bits
  CP $01                ; Is it a pawn ?
  JR Z,MV1_2
  CP KING               ; Is it a king ?
  JR Z,MV30             ; Yes - jump
MV5:
  LD IY,(M2)            ; Load "to" pos board index
  LD (IY+$00),E         ; Insert piece at new position
  LD (IX+$00),$00       ; Empty previous position
  LD C,$00
  CALL MOVE_CAPTURE
  BIT 6,D               ; Double move ?
  JR NZ,MV40            ; Yes - jump
  LD A,D                ; Get captured piece, if any
  AND $07
  CALL NZ,UNMOVE_CAPTURE
  RET

MV1_2:
  LD A,(M2)             ; Get "to" position
  CP 91                 ; Promote white Pawn ?
  JR NC,MV15            ; Yes - Jump
  CP 29                 ; Promote black Pawn ?
  JR NC,MV5             ; No - Jump
MV15:
  SET 5,(HL)
  SET 2,E               ; Change Pawn to a Queen
  JP MV5
MV30:
  LD HL,POSK            ; Get saved King position
  BIT 7,E               ; Is King white ?
  JR Z,MV22             ; Yes - jump
  INC L                 ; Increment to black King pos
MV22:
  LD A,(M2)             ; Get new Queen position
  LD (HL),A             ; Save
  JP MV5                ; Jump
MV40:
  LD HL,(MLPTRJ)        ; Get move list pointer
  LD DE,$0007
  ADD HL,DE
  JP MV1                ; Jump (2nd part of dbl move)

; *******************************************************
; UN-MOVE ROUTINE
; *******************************************************
; FUNCTION:--	To reverse the process of the move routine,
; 		thereby restoring the board array to its
; 		previous position.
;
; Used by the routines at SORT_SUB, FM35, ASNTBI, GAME_DRIVER and PROMPT.
UNMOVE:
  LD HL,(MLPTRJ)        ; Load move list pointer
  INC HL                ; Increment past link bytes
  INC HL
UM1:
  LD A,(HL)             ; Get "from" position
  LD (M1),A             ; Save
  INC HL                ; Increment pointer
  LD A,(HL)             ; Get "to" position
  LD (M2),A             ; Save
  INC HL                ; Increment pointer
  LD D,(HL)             ; Get captured piece/flags
  LD IX,(M2)            ; Load "to" pos board index
  LD E,(IX+$00)         ; Get piece moved    (IX+BOARD)
  LD C,$01
  CALL MOVE_CAPTURE
  BIT 5,D               ; Was it a Pawn promotion ?
  JR NZ,UM15            ; Yes - jump
  LD A,E                ; Get piece moved
  AND $07               ; Clear flag bits
  CP KING               ; Was it a King ?
  JR Z,UM30             ; Yes - jump
UM5:
  BIT 4,D               ; Is this 1st move for piece ?
  JR NZ,UM16            ; Yes - jump
UM6:
  LD IY,(M1)            ; Load "from" pos board index
  LD (IY+$00),E         ; Return to previous board pos   (IY+BOARD)
  LD A,D                ; Get captured piece, if any
  AND $8F               ; Clear flags
  LD (IX+$00),A         ; Return to board    (IX+BOARD)
  BIT 6,D               ; Was it a double move ?
  JR NZ,UM40            ; Yes - jump
  AND $07               ; Clear flag bits
  CALL NZ,UNMOVE_CAPTURE
  RET

UM15:
  RES 2,E             ; Restore Queen to Pawn
  JP UM5              ; Jump

UM16:
  RES 3,E             ; Clear piece moved flag
  JP UM6              ; Jump

UM30:
  LD HL,POSK          ;	Address of saved King pos
  BIT 7,E             ;	Is it white ?
  JR Z,UM22           ;	Yes - jump
  INC L               ; Increment to black pos

UM22:
  LD A,(M1)           ; Get previous position
  LD (HL),A           ; Save
  JP UM5              ; Jump
  
UM40:
  LD HL,(MLPTRJ)      ; Load move list pointer
  LD DE,$0007         ; Increment to next move
  ADD HL,DE
  JP UM1              ; Jump (2nd part of dbl move)


; This entry point is used by the routine at MV1.
UNMOVE_CAPTURE:
  LD (T1),A
  LD IX,(T1)
  LD A,(IX-PVALUE)
  BIT 7,D
; This entry point is used by the routine at MOVE_CAPTURE.
UNMOVE_CAPTURE_2:
  JR NZ,UNMOVE_CAPTURE_3
  NEG
UNMOVE_CAPTURE_3:
  BIT 0,C
  JR Z,UNMOVE_CAPTURE_4
  NEG
UNMOVE_CAPTURE_4:
  LD HL,MTRL_B
  ADD A,(HL)
  LD (HL),A
  RET


; SORT ROUTINE
;
; Used by the routine at rel018.
SORTM:
  LD BC,(MLPTRI)       ; Move list begin pointer
  LD DE,$0000          ; Initialize working pointers
SR5:
  LD H,B
  LD L,C
  LD C,(HL)            ; Link to next move
  INC HL
  LD B,(HL)
  LD (HL),D            ; Store to link in list
  DEC HL
  LD (HL),E
  XOR A                ; End of list ?
  CP B
  RET Z                ; Yes - return
  PUSH BC
  POP IX
  CALL SORT_SUB        ; Compute new move value
  JR Z,SR15
  LD HL,(MLPTRI)
SR15:
  EX AF,AF'
  LD E,(HL)            ; Next move for compare
  INC HL
  LD D,(HL)
  XOR A                ; At end of list ?
  CP D
  JR Z,SR25
  PUSH DE              ; Transfer move pointer
  POP IX
  PUSH HL
  CALL SORT_SUB        ; Compute new move value
  LD H,A               ; Get new move value
  EX AF,AF'
  CP H                 ; Less than list value ?
  POP HL
  JR C,SR30            ; No - jump
SR25:
  LD (HL),B            ; Link new move into list
  DEC HL
  LD (HL),C
  JP SR5               ; Jump
SR30:
  EX DE,HL
  JP SR15

;
; Compute new move value
;
; Used by the routine at SORTM.
SORT_SUB:
  PUSH HL
  LD A,(L0137)
  AND A
  JR Z,SORT_SUB_1
SORT_SUB_0:
  LD A,(IX+$04)
  AND $07
  ADD A,A
  ADD A,A
  JR NZ,SORT_SUB_RET
  LD HL,(L0123)
  LD A,(IY+$02)
  CP (HL)
  LD A,$00
  JR NZ,SORT_SUB_3
  INC HL
  LD A,(IX+$03)
  CP (HL)
  LD A,$01
  JR NZ,SORT_SUB_3
  INC A
  JP SORT_SUB_RET

SORT_SUB_1:
  LD A,(NPLY)            ; Current ply counter
  LD HL,PLYMAX           ; Address of maximum ply number
  CP (HL)                ; At max ply ?
  JR NC,SORT_SUB_0       ; No
  LD HL,(L0125)
  DEC HL
  DEC HL
  ADD A,A
  ADD A,L
  JR NC,SORT_SUB_2
  INC H
SORT_SUB_2:
  LD L,A
  LD A,(IX+$02)
  CP (HL)
  JR NZ,SORT_SUB_0
  LD A,(IX+$03)
  INC HL
  CP (HL)
  JR NZ,SORT_SUB_0
  LD A,$20
SORT_SUB_3:
  AND A
SORT_SUB_RET:
  POP HL
  RET

; This entry point is used by the routine at FM35_SUB.
FNDMOV:
  LD A,$01
  LD (NPLY),A            ; Initialize ply number
  XOR A
  LD (MTRL_A),A
  LD (MATEF),A
  LD (L0137),A
  LD HL,(L0500)
  LD (L0504),HL
  LD HL,L39DD
  LD (L0125),HL
; This entry point is used by the routine at rel018.
FM15_0:
  LD HL,(MLPTRI)          ; Load ply index pointer
  LD (MLPTRJ),HL          ; Save as last move pointer

; This entry point is used by the routine at FM35.
FM15:
  CALL CONSOLE_STATUS
  AND A
  CALL NZ,PROMPT_2
  LD HL,(MLPTRJ)          ; Load current move pointer
  LD E,(HL)               ; Get next move pointer
  INC HL
  LD D,(HL)
  LD A,D
  AND A                   ; End of move list ?
  JR Z,FM25               ; Yes - jump
  LD (MLPTRJ),DE          ; Save current move pointer
  LD HL,(MLPTRI)          ; Save in ply pointer list
  LD (HL),E
  INC HL
  LD (HL),D
  CALL MOVE               ; Execute move on board array
  CALL INCHK              ; Check for legal move
  JR Z,JR19
  CALL UNMOVE             ; Restore board position
  JP FM15                 ; Jump

; Routine at 6915
;
; Used by the routine at SORT_SUB.
JR19:
  LD A,(NPLY)         ; Get ply counter
  LD HL,PLYMAX        ; Max ply number
  CP (HL)             ; Beyond max ply ?
  JP NC,FM35          ; Yes - jump

; Routine at 6925
;
; Used by the routine at FM35.
FM19:
  LD HL,COLOR        ; Toggle color
  LD A,$80           
  XOR (HL)           
  LD (HL),A          ; Save new color
  BIT 7,A            ; Is it black ?
  JR NZ,rel018       ; Yes - jump
  LD HL,PMATE
  INC (HL)

; Routine at 6940
;
; Used by the routine at FM19.
rel018:
  LD IX,(SCRIX)      ; Load score table pointer
  LD D,(IX+$00)      ; Get score two plys above
  LD E,(IX-$01)      ; Get score three plys above
  LD (IX+$04),D
  LD (IX+$03),E
  INC IX             ; Increment to current ply
  INC IX
  LD (SCRIX),IX      ; Save score as initial value
  LD HL,NPLY         ; Address of ply counter
  INC (HL)           ; Increment ply count
  XOR A              ; Initialize mate flag
  LD (MATEF),A
  LD HL,(L0129)
  LD DE,$0014
  ADD HL,DE
  LD (L0129),HL
  LD HL,(L0127)
  LD DE,$0016
  ADD HL,DE
  LD (L0127),HL
  LD HL,(L0123)
  INC HL
  INC HL
  LD (L0123),HL
  CALL GENMOV
  CALL SORTM
  JP FM15_0

; This entry point is used by the routine at SORT_SUB.
FM25:
  LD A,(MATEF)       ; Get mate flag
  AND A              ; Checkmate or stalemate ?
  JR NZ,FM30         ; No - jump
  CALL INCHK
  AND A              ; Was King in check ?
  LD DE,$8000        ; Pre-set stalemate score
  JR Z,FM36          ; No - jump (stalemate)
  LD A,(NPLY)        ; ?? Pre-set checkmate score ??
  LD E,A
  LD D,$00
  JP FM36

; This entry point is used by the routine at FM35.
FM30:
  LD A,(NPLY)        ; Get ply counter
  CP $01             ; At top of tree ?
  RET Z              ; Yes - return
  CALL ASCEND        ; Ascend one ply in tree
  LD IX,(SCRIX)      ; Load score table pointer
  LD E,(IX+$03)      ;  ...get score at current ply
  LD D,(IX+$04)
  LD HL,$0000
  AND A
  SBC HL,DE
  EX DE,HL
  JP FM37            ; Jump

; Routine at 7062
;
; Used by the routine at JR19.
FM35:
  CALL FM35_SUB
  LD A,(NPLY)        ; Current ply counter
  LD HL,MOVENO       ; Maximum ply number ?
  CP (HL)            ; Compare
  JR C,FM35_1        ; Jump if not max
  LD HL,PLYMAX       ; Max ply number
  CP (HL)            ; Beyond max ply ?
  JR Z,FM35_0
  BIT 0,A
  JR NZ,FM35_1
  LD A,(L013C)
  AND A
  JP NZ,FM19
  JP FM35_1

FM35_0:
  LD A,(L0138)
  AND A
  JP NZ,FM19
FM35_1:
  CALL UNMOVE         ; Restore board position
  LD DE,(VALM)        ; Get value of move
; This entry point is used by the routine at rel018.
FM36:
  LD HL,MATEF         ; Set mate flag
  SET 0,(HL)
  LD IX,(SCRIX)       ; Load score table pointer

; This entry point is used by the routine at rel018.
FM37:
  LD H,(IX+$02)
  LD L,(IX+$01)
  AND A
  SBC HL,DE
  JP NC,FM15
  LD (IX+$02),D
  LD (IX+$01),E
  CALL FM35_SUB_2
  LD HL,$0000
  AND A
  SBC HL,DE
  EX DE,HL
  LD H,(IX+$00)
  LD L,(IX-$01)
  AND A
  SBC HL,DE
  JR NC,FM30
  JP FM15


; *******************************************************
;   CHECK ROUTINE
; *******************************************************
; FUNCTION: --  To determine whether or not the
;       King is in check.
;
; This entry point is used by the routines at CASTLE, SORT_SUB and rel018.
INCHK:
  LD A,(COLOR)        ; Get color
  LD HL,POSK          ; Addr of white King position
  AND A               ; White ?
  JR Z,INCHK_WHITE    ; Yes - Skip
  INC HL              ; Addr of black King position
INCHK_WHITE:
  LD DE,BOARDA
  LD E,(HL)           ; Fetch King position
  LD A,(DE)           ; Get King
  LD (P1),A           ; save
  JP ATTACK           ; Look for attackers on King and return

; Routine at 7180
;
; Used by the routine at FM35.
FM35_SUB:
  LD A,(PLYMAX)
  LD (L0137),A
  LD HL,MOVENO
  CP (HL)
  JP NC,CK_BESTM
  LD A,(MTRL_B)
  ADD A,A
  LD H,A
  LD L,$00
  LD A,(COLOR)
  AND A
  JR Z,FM35_SUB_0
  EX DE,HL
  LD HL,$0000
  AND A
  SBC HL,DE
FM35_SUB_0:
  LD DE,$8100
  ADD HL,DE
  EX DE,HL
  LD IX,(SCRIX)
  LD H,(IX+$02)
  LD L,(IX+$01)
  AND A
  SBC HL,DE
  JP C,CK_BESTM
  LD (VALM),DE
  LD A,(COLOR)
  XOR $80
  LD HL,POSK
  AND A
  JR Z,FM35_SUB_1
  INC HL
FM35_SUB_1:
  LD DE,BOARDA
  LD E,(HL)
  LD A,(DE)
  LD (P1),A
  CALL ATTACK
  LD (L0138),A
  RET

; This entry point is used by the routine at FM35.
FM35_SUB_2:
  PUSH DE
  LD IY,(MLPTRJ)
  LD A,(IY+$04)
  AND $07
  JR NZ,FM35_SUB_3
  LD HL,(L0123)
  LD A,(IY+$02)
  LD (HL),A
  INC HL
  LD A,(IY+$03)
  LD (HL),A
FM35_SUB_3:
  LD HL,(L0129)
  LD DE,$0014
  ADD HL,DE
  LD DE,(L0129)
  LD BC,$0014
  LDIR
  LD HL,(L0127)
  LD A,(IY+$02)
  LD (HL),A
  INC HL
  LD A,(IY+$03)
  LD (HL),A
  LD A,(NPLY)
  CP $01
  JP NZ,FM35_SUB_8
  PUSH IX
  LD A,(COLOR)
  AND A
  JR Z,FM35_SUB_4
  LD IX,MVEMSG_B
  JR FM35_SUB_4B

FM35_SUB_4:
  LD IX,MVEMSG_A

FM35_SUB_4B:
  LD IY,TBASE
  LD D,(IY+$00)
  CALL BITASN       ; Convert to Ascii
  LD A,L
  LD (IX+$00),A
  LD A,H
  LD (IX+$01),A
  LD A,'-'
  LD (IX+$02),A
  LD D,(IY+$01)
  CALL BITASN       ; Convert to Ascii
  LD A,L
  LD (IX+$03),A     ; MVEMSG_B+3
  LD A,H
  LD (IX+$04),A
  CALL PRTBLK
  POP IX
  LD HL,(L0125)
  LD DE,L39F1
  AND A
  SBC HL,DE
  JR C,FM35_SUB_6
  JR Z,FM35_SUB_6
  LD B,H
  LD C,L
  ADD HL,DE
  LD DE,$0015
  AND A
  SBC HL,DE
  LD DE,(L0125)
  DEC DE
  LDDR
  LD HL,TBASE
  LD DE,L39DD
  LD BC,$0014
  LDIR
FM35_SUB_6:
  LD HL,(L0117)
  LD BC,(MLPTRJ)
  AND A
  SBC HL,BC
  JR Z,FM35_SUB_8
  ADD HL,BC
  PUSH HL
  LD (L0117),BC
FM35_SUB_7:
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  AND A
  SBC HL,BC
  ADD HL,BC
  JR NZ,FM35_SUB_7
  INC HL
  LD A,(HL)
  LD (DE),A
  DEC DE
  DEC HL
  LD A,(HL)
  LD (DE),A
  LD (MLPTRJ),DE
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
FM35_SUB_8:
  POP DE
  RET

; This entry point is used by the routine at GAME_DRIVER.
FM35_SUB_9:
  CALL POINTS
  LD HL,$0000
  LD (BESTM),HL
  LD (L0500),HL
  LD (L0502),HL
  LD HL,L0542
  LD (L0123),HL
  XOR A
  LD (HL),A
  LD DE,L0543
  LD BC,$0013
  LDIR
  LD HL,TBASE
  LD (L0129),HL
  LD (L0127),HL
; This entry point is used by the routine at L2B1B.
FM35_SUB_10:
  LD HL,MLIST
  LD (MLNXT),HL
  LD (L0117),HL
  LD HL,PLYIX
  LD (MLPTRI),HL
  LD HL,SCORE
  LD (SCRIX),HL
  CALL GENMOV
  LD HL,(MLNXT)
  LD (L051E),HL
  LD A,(MATEF_2)
  AND A
  CALL Z,L1FA3
  LD A,$01
FM35_SUB_11:
  LD (PLYMAX),A
  CALL PROMPT_1
  CALL FNDMOV
  LD A,(L0505)
  AND A
  RET Z
  CP $FF
  RET Z
  LD A,(PLYMAX)
  CP $01
  JR Z,FM35_SUB_12
  LD HL,(L0500)
  LD DE,(L0504)
  AND A
  SBC HL,DE
  JR NC,FM35_SUB_14
  LD HL,$0000
  AND A
  SBC HL,DE
  EX DE,HL
  LD HL,(L0502)
  AND A
  SBC HL,DE
  JR NC,FM35_SUB_14
  LD A,$20
  LD HL,(L0504)
  LD DE,$FF9C
  ADD HL,DE
  LD (L0500),HL
  EX DE,HL
  LD HL,$FF38
  AND A
  SBC HL,DE
  LD (L0502),HL
FM35_SUB_12:
  LD A,(PLYMAX)           ;	Address of ply depth variable
  CP $09                  ; <<<<--- ?  this looks like just a lame protection
  RET Z
  LD HL,MOVENO
  CP (HL)
  JR C,FM35_SUB_13
  LD A,(HL)
  ADD A,A
  LD HL,L01B8
  ADD A,L
  LD L,A
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(BESTM)
  SBC HL,DE
  RET NC
FM35_SUB_13:
  LD HL,PLYMAX
  INC (HL)               ; Increment move number  <--- ? apparently it is not incrementing the counter
  JP FM35_SUB_15

FM35_SUB_14:
  LD HL,$0000
  LD (L0502),HL
  LD (L0500),HL
FM35_SUB_15:
  LD HL,(L0117)
  LD (L051C),HL
  LD HL,(L051E)
  LD (MLNXT),HL
  LD A,(PLYMAX)
  JP FM35_SUB_11
  
POINTS:
  XOR A
  LD (CKFLG),A
  LD (MTRL_B),A
  LD (MTRL_C),A
  LD B,$4E
  LD DE,TOP_LEFT
FM35_SUB_17:
  LD A,(DE)
  AND $07               ; Save piece type, if any
  LD (T1),A
  CP KING
  JR NZ,FM35_SUB_19
  LD A,(DE)
  LD HL,POSK
  BIT 7,A
  JR Z,FM35_SUB_18
  INC L
FM35_SUB_18:
  LD (HL),E
FM35_SUB_19:
  LD IX,(T1)
  LD A,(DE)
  BIT 7,A
  LD A,(IX-PVALUE)
  LD C,A
  JR Z,FM35_SUB_20
  NEG
FM35_SUB_20:
  LD HL,MTRL_B
  ADD A,(HL)
  LD (HL),A
  LD A,C
  INC HL
  ADD A,(HL)
  LD (HL),A
  INC DE
  DJNZ FM35_SUB_17
  CP '.'
  RET NC
  LD A,(MTRL_B)
  BIT 7,A
  JR Z,FM35_SUB_21
  NEG
FM35_SUB_21:
  CP $05
  RET C
  LD (CKFLG),A
  RET

;***********************************************************
; BOARD INDEX TO ASCII SQUARE NAME
;***********************************************************
; FUNCTION:   --  To translate a hexadecimal index in the
;                 board array into an ascii description
;                 of the square in algebraic chess notation.
;
; This entry point is used by the routines at GAME_DRIVER and L2B1B.
BITASN:
  SUB A
  LD E,10
  CALL DIVIDE        ; Divide
  DEC D              ; Get rank on 1-8 basis
  ADD A,$40          ; Convert file to Ascii (a-h)
  LD L,A             ; Save
  LD A,D             ; Rank
  ADD A,$30          ; Convert rank to Ascii (1-8)
  LD H,A             ; Save
  RET                ; Return


; *******************************************************
; POSITIVE INTEGER DIVISION
; *******************************************************
; Routine at 7780
;
; Used by the routines at MOVE_CAPTURE, FM35_SUB, CKMOVE and L2AC9.
DIVIDE:
  PUSH BC
  LD B,$08
DIVIDE_0:
  SLA D
  RLA
  SUB E
  JP M,DIVIDE_1
  INC D
  JP DIVIDE_2
DIVIDE_1:
  ADD A,E
DIVIDE_2:
  DJNZ DIVIDE_0
  POP BC
  RET


; *******************************************************
; POSITIVE INTEGER MULTIPLICATION
; *******************************************************
;   inputs D, E
;   output hi=A lo=D

; Routine at 7799
;
; Used by the routines at ASNTBI and GAME_DRIVER.
MLTPLY:
  PUSH BC
  SUB A
  LD B,$08
MLTPLY_0:
  BIT 0,D
  JR Z,MLTPLY_1
  ADD A,E
MLTPLY_1:
  SRA A
  RR D
  DJNZ MLTPLY_0
  POP BC
  RET


; ASCII SQUARE NAME TO BOARD INDEX
;
; Used by the routine at GAME_DRIVER.
ASNTBI:
  LD A,(HL)             ; Ascii rank (1 - 8)
  SUB $30               ; Rank 1 - 8
  CP 1                  ; Check lower bound
  JP M,AT04             ; Jump if invalid
  CP 9                  ; Check upper bound
  JR NC,AT04            ; Jump if invalid
  INC A                 ; Rank 2 - 9
  LD D,A                ; Ready for multiplication
  LD E,10
  CALL MLTPLY           ; Multiply
  DEC HL
  LD A,(HL)             ; Ascii file letter (a - h)
  SUB $40               ; File 1 - 8
  CP 1                  ; Check lower bound
  JP M,AT04             ; Jump if invalid
  CP 9                  ; Check upper bound
  JR NC,AT04            ; Jump if invalid
  ADD A,D               ; File+Rank(20-90)=Board index
  LD (HL),A
  DEC HL
  DEC HL
  RET

AT04:
  XOR A                 ; Invalid flag
  RET

; This entry point is used by the routine at GAME_DRIVER.
ASNTBI_1:
  LD HL,L01DA
  LD DE,L01DB
  LD BC,$0009
  LDDR
  LD HL,L01DA
  LD DE,L01DB
  LD BC,$0008
  LDDR
  LD IX,(MLPTRJ)
  LD L,(IX+$02)
  LD H,(IX+$03)
  LD (L01D2),HL
  RET

; This entry point is used by the routine at GAME_DRIVER.
ASNTBI_2:
  LD A,(MTRL_B)          ; Get material points
  LD HL,KOLOR
  BIT 7,(HL)            ; Is it white ?
  JR NZ,JR18            ; No - jump
  NEG                   ; Negate for white
JR18:
  ADD A,$80             ;   Rescale score (neutral = 80H)
  CP $83
  RET NC
  LD HL,(L01D2)
  LD DE,(L01DA)
  AND A
  SBC HL,DE
  RET NZ
  LD IX,(L0117)
  LD L,(IX+$02)
  LD H,(IX+$03)
  LD DE,(L01D8)
  AND A
  SBC HL,DE
  RET NZ
  LD L,(IX+$00)
  LD H,(IX+$01)
  LD A,H
  AND A
  RET Z
  LD (L0117),HL
  RET

; This entry point is used by the routine at rel018.
ASCEND:
  LD HL,COLOR         ; Toggle color
  LD A,$80
  XOR (HL)
  LD (HL),A           ; Save new color
  BIT 7,A             ; Is it black ?
  JR Z,JR21           ; Yes - jump
  LD HL,PMATE         ; Checkmate move number
  DEC (HL)            ; Decrement
JR21:
  LD HL,(SCRIX)       ; Load score table index
  DEC HL              ; Decrement
  DEC HL
  LD (SCRIX),HL       ; Save
  LD HL,NPLY          ; Decrement ply counter
  DEC (HL)
  LD HL,(L0129)
  LD DE,$FFEC
  ADD HL,DE
  LD (L0129),HL
  LD HL,(L0127)
  LD DE,$FFEA
  ADD HL,DE
  LD (L0127),HL
  LD HL,(L0123)
  DEC HL
  DEC HL
  LD (L0123),HL
  LD HL,(MLPTRI)      ; Load ply list pointer
  DEC HL              ; Load pointer to move list to
  LD D,(HL)
  DEC HL
  LD E,(HL)
  LD (MLNXT),DE       ; Update move list avail ptr
  DEC HL              ; Get ptr to next move to undo
  LD D,(HL)
  DEC HL
  LD E,(HL)
  LD (MLPTRI),HL      ; Save new ply list pointer
  LD (MLPTRJ),DE      ; Save next move pointer
  CALL UNMOVE         ; Restore board to previous pl
  LD A,(NPLY)
  CP $01
  RET NZ
  LD HL,L056A
  LD DE,(L0125)
  LD BC,$0014
  LDIR
  LD (L0125),DE
  XOR A
  LD (L0137),A
  LD A,(L0166)
  XOR $0A
  LD (L0166),A
  CALL OUTPUT
  LD A,$08			  ; TAB
  CALL OUTPUT
  LD A,(MOVENO)
  LD HL,PLYMAX
  CP (HL)
  RET NC
  LD HL,L01C4
  ADD A,A
  ADD A,L
  LD L,A
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(BESTM)
  SBC HL,DE
  RET C
  POP HL
  POP HL
  RET                 ; Return


; Data block at 8098
FIRST_MOVE:
  DEFB $00

; Routine at 8099
;
; Used by the routine at FM35_SUB.
L1FA3:
  CALL CKMOVE
  LD HL,(L011F)
  LD A,(PMATE)
  CP $01
  JR NZ,L1FA3_1
  LD A,(KOLOR)
  AND A
  JR NZ,L1FA3_0
  LD A,(COLOR)
  AND A
  JR NZ,L1FA3_1
L1FA3_0:
  LD HL,OPENINGS-1
  LD (L011F),HL
  LD A,(KOLOR)
  AND A
  JR Z,BOOK
L1FA3_1:
  LD A,(FIRST_MOVE)
  CP $01
  JR Z,BOOK
  LD A,(HL)
  LD B,$01
L1FA3_2:
  SRL A
  JR NC,L1FA3_3
  INC B
L1FA3_3:
  AND A
  JR NZ,L1FA3_2
  LD A,(L0167)
  INC HL
L1FA3_4:
  CP (HL)
  JR Z,L1FA3_6
  DEC B
  JR Z,L1FA3_5
  CALL BOOK_6
  JR L1FA3_4
L1FA3_5:
  LD A,$80
  LD (MATEF_2),A
  RET

L1FA3_6:
  CALL BOOK_4
  JR NC,BOOK
  RET


; Routine at 8181
;
; Used by the routine at L1FA3.
BOOK:
  XOR A
  LD (FIRST_MOVE),A
  LD A,(HL)
  OR $80
  LD C,A
  INC HL
  LD E,L
  LD D,H
  LD A,R
  LD B,A
BOOK_0:
  SRL B
  JR C,BOOK_2
  LD A,C
  AND A
  JR Z,BOOK_1
  SRL C
  JR NC,BOOK_0
  CALL BOOK_6
  JR BOOK_0
BOOK_1:
  EX DE,HL
BOOK_2:
  LD C,(HL)
  LD B,$00
  CALL BOOK_4
  LD A,C
  AND A
  JR Z,BOOK_3
  LD (L0163),A
  PUSH BC
  LD B,C
  CALL L2081_2
  POP BC
  LD A,(L0163)
  LD C,A
BOOK_3:
  LD HL,MLIST
  ADD HL,BC
  LD A,C
  ADD A,A
  LD C,A
  ADD HL,BC
  ADD HL,BC
  LD (L0117),HL
  LD HL,$8000
  LD (L0504),HL
  POP HL
  RET

; This entry point is used by the routine at L1FA3.
BOOK_4:
  INC HL
  LD A,(HL)
  CP $FF
  JR Z,BOOK_5
  LD E,A
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (L011F),HL
  AND A
  RET

BOOK_5:
  LD (MATEF_2),A
  SCF
  RET

; This entry point is used by the routine at L1FA3.
BOOK_6:
  PUSH AF
  INC HL
  LD A,(HL)
  CP $FF
  JR Z,BOOK_7
  INC HL
BOOK_7:
  INC HL
  POP AF
  RET


; ADMOVE?
;
; Used by the routine at L1FA3.
CKMOVE:
  LD DE,MLIST2
  LD HL,(MLPTRJ)
  AND A
  SBC HL,DE
  LD A,H
  LD D,L
  LD E,$05
  CALL DIVIDE
  LD A,D
  AND A
  JR Z,CKMOVE_0
  LD (L0163),A
  LD B,A
  CALL L2081
  LD A,(L0163)
CKMOVE_0:
  LD (L0167),A
  RET


; Routine at 8321
;
; Used by the routine at CKMOVE.
L2081:
  LD HL,L0B04
L2081_0:
  BIT 6,(HL)
  CALL NZ,L2081_1
  LD DE,$0005
  ADD HL,DE
  DJNZ L2081_0
  RET

L2081_1:
  LD A,(L0163)
  DEC A
  LD (L0163),A
  RET

; This entry point is used by the routine at BOOK.
L2081_2:
  LD HL,L0704
L2081_3:
  BIT 6,(HL)
  CALL NZ,L2081_4
  LD DE,$0005
  ADD HL,DE
  DJNZ L2081_3
  RET

L2081_4:
  LD A,(L0163)
  INC A
  LD (L0163),A
  RET


; Message at 8367
MENU:
  DEFM "        ****** SARGON 2.1 ******"
  DEFB $0D
  DEFB $0A
  DEFB $0D
  DEFB $0A
  DEFB $0A
  DEFM "SELECT OPTIONS"
  DEFB $0D
  DEFB $0A
  DEFM "NEW GAME, CHANGE BOARD OR EXIT? (G,C,X):$"

; Message at 8461
COLOR_MENU:
  DEFB $0D
  DEFB $0A

; Message at 8463
CLRMSG:
  DEFM "YOUR COLOR? (B,W):$"

; Message at 8482
LEVEL_MSG:
  DEFM "LEVEL OF PLAY? (1-6):$"

; Message at 8504
MENU_CNEXT:
  DEFM "COLOR TO MOVE NEXT? (B,W):$"

; Message at 8531
MENU_MV_NUMBER:
  DEFM "MOVE NUMBER? (NN):$"

; Message at 8550
TXT_SARGON:
  DEFM "  SARGON$"

; Message at 8559
TXT_PLAYER:
  DEFM "  PLAYER$"

; Message at 8568
SPACE:
  DEFM "               "

; Message at 8583
MVENUM_MSG:
  DEFM "01"
; Message at 8585
;UNDERLINE_0:
  DEFM " "

; Message at 8586
UNDERLINE:
  DEFM "   ------  ------$"

; Message at 8604
CHECKMATE:
  DEFM "CHECK"

; Message at 8609
MATE:
  DEFM "MATE $"

; Message at 8615
CHECKMATE_IN:
  DEFM "IN "

; Message at 8618
MATE_IN:
  DEFM "2$"

; Message at 8620
STALEMATE:
  DEFM "STALEMATE$"

; Message at 8630
PCS:
  DEFM "KQRBNP"

; Message at 8636
O_O:
  DEFM " O-O "

; Message at 8641
O_O_O:
  DEFM "O-O-O"

; Message at 8646
P_PEP:
  DEFM "PxPep"

; Message at 8651
INVAL1:
  DEFM "INVALID MOVE$"

; Message at 8664
INVAL2:
  DEFM "TRY AGAIN$"

; Message at 8674
DISP_ALWAYS:
  DEFM "DISPLAY BOARD EVERY MOVE?(Y OR N)$"

; Message at 8708
REV_PCS:
  DEFB $00
  DEFM "PNBRQK"

; Message at 8715
COLUMNS_A_H:
  DEFM "ABCDEFGH"

; Message at 8723
ROWS_1_8:
  DEFM "12345678"

; Message at 8731
BOARD_EDIT_MSG:
  DEFM "S=START POSITION"
  DEFB $0D
  DEFB $0A
  DEFM "E=EMPTY BOARD"
  DEFB $0D
  DEFB $0A
  DEFM "N=NO CHANGE:$"

; Message at 8777
P_ON:
  DEFM "  P-ON"
  DEFB $08
  DEFB $08
  DEFB $08
  DEFB $08
  DEFB $08
  DEFB $08
  DEFM "$"

; Message at 8790
P_OFF:
  DEFM " P-OFF"
  DEFB $08
  DEFB $08
  DEFB $08
  DEFB $08
  DEFB $08
  DEFB $08
  DEFM "$"

; Message at 8803
PRINTER_MSG:
  DEFM "PRINTER?(Y,N)$"

; Message at 8817
L2271:
  DEFM "@ = AUTO PLAY"
  DEFB $0D
  DEFB $0A
  DEFM "Z = BOARD TO PRINTER"
  DEFB $0D
  DEFB $0A
  DEFM "V = BOARD TO SCREEN"
  DEFB $0D
  DEFB $0A
  DEFM "R = CHANGE SIDES"
  DEFB $0D
  DEFB $0A
  DEFM "N = HINT"
  DEFB $0D
  DEFB $0A
  DEFM "Y = PLY CHANGE"
  DEFB $0D
  DEFB $0A
  DEFM "K = PRINTER \"OFF\""
  DEFB $0D
  DEFB $0A
  DEFM "P = PRINTER \"ON\""
  DEFB $0D
  DEFB $0A

; Message at 8956
QUIT_MSG:
  DEFM "Q = QUIT AND SAVE GAME"
  DEFB $0D
  DEFB $0A
  DEFM "# = STOP SARGON DURING HIS MOVE"
  DEFB $0A
  DEFM "$"

; Message at 9013
BELL_MSG:
  DEFM "DO YOU WANT THE ERROR BELL?(Y OR N):$"

; Message at 9050
LAST_COMMAND:
  DEFM "LAST COMMAND = "

; Message at 9065
LAST_CMD_MSG:
  DEFM " "
; Message at 9066
  DEFM "  "
; Message at 9068
  DEFM "  "
; Message at 9070
  DEFM "  "
; Message at 9072
  DEFM " $"

; Routine at 9074
;
; Used by the routine at START.
GAME_DRIVER:
  LD SP,STACK

IF !TRS80
  CALL CLS
  LD DE,BELL_MSG
  CALL PROMPT
  CALL CHARTR
  CP 'Y'
  JP Z,L2372_0
ENDIF
  LD HL,BELL
  XOR A
  LD (HL),A

L2372_0:
  CALL CLS
  LD DE,TITLE           ; Output greeting
  CALL PRINT

IF TRS80
  LD B,8
ELSE
  LD B,$10
ENDIF
DELAY_1:
  LD A,$FF
DELAY_2:
  LD C,$F9
DELAY_3:
  DEC C
  JR NZ,DELAY_3
  DEC A
  JR NZ,DELAY_2
  DJNZ DELAY_1

; This entry point is used by the routines at L2B1B and NOT_FOUND_ERR.
DRIV01:
  LD SP,STACK
  XOR A
  LD (L0168),A
  CALL FIRST_MENU
  CALL DISPLAY_BOARD
IF !TRS80
  CALL CARRET
ENDIF
  LD A,(PRINTER_FLAG)
  AND A
  JR Z,L2372_5
  LD A,$01
  LD (USE_PRINTER),A
L2372_5:
  CALL LOAD_MOVE
  CALL PRINT_MOVE
  XOR A
  LD (USE_PRINTER),A
; This entry point is used by the routine at L2B1B.
L2372_6:
  CALL PRTBLK
  LD A,(COLOR)
  LD HL,KOLOR
  CP (HL)
  JR NZ,L2372_7
  CALL DELAY_37
  CALL RING_BELL
  JP L2372_8

L2372_7:
  CALL L2372_47
L2372_8:
  CALL LDSPBRD
  CALL DELAY_10
  JP L2372_6



; This entry point is used by the routine at SET_FILENAME.
LDSPBRD:
  LD A,(DISP_BD)
  OR A
  RET Z
  CALL DSPBRD
  CALL PRINT_MOVE
  RET

DELAY_10:
  LD A,(COLOR)
  XOR $80
  LD (COLOR),A
  RET NZ
  CALL PRTBLK
  CALL OUTPUT_4
  CALL CLEAN_MOVE_MSG
  LD HL,PMATE
  INC (HL)
  CALL CARRET
  CALL LOAD_MOVE
  CALL PRTBLK_1
  RET

PRINT_MOVE:
  LD (L0163),SP
  LD A,(L0164)
  CP $10
  JP M,DELAY_12
  CALL CARRET
DELAY_12:
IF !TRS80
  CALL CARRET
ENDIF
  CALL CARRET

; This entry point is used by the routines at L2B1B and SET_FILENAME.
SHOW_MV:
  LD A,(MOVENO)
  ADD A,'0'
  CALL OUTPUT
  LD DE,TXT_SARGON
  LD HL,TXT_PLAYER
  LD A,(KOLOR)
  AND A
  JR Z,SHOW_MV_0
  EX DE,HL
SHOW_MV_0:
  PUSH HL
  PUSH DE
  PUSH HL
  CALL PROMPT
  POP DE
  CALL PRINT
  LD DE,UNDERLINE
  CALL PRINT
  CALL PRTBLK_1
  LD A,(USE_PRINTER)
  AND A
  JR NZ,DELAY_15
  POP HL
  POP HL
  RET

DELAY_15:
  POP HL
  CALL OUTPUT_5
  POP HL
  CALL OUTPUT_7
  LD HL,UNDERLINE
  JP OUTPUT_7

FIRST_MENU:
  CALL CLS
  LD DE,MENU
  CALL PROMPT
  CALL CHARTR
  CALL CARRET
  CP 'G'
  JP Z,PRINTER_MENU   ; Game is about to start.  Go ahead and ask about printer.
  CP 'C'
  JR Z,CHANGE_BOARD
  CP ' '
  JR Z,CHANGE_BOARD
  CP 'X'
IF SINCLAIR
  JP Z,EXIT_GAME
ELSE
  JP Z,WBOOT
ENDIF
  JR FIRST_MENU

CHANGE_BOARD:
  CALL EDIT_BOARD     ; The main board edit routine
  CALL CLS
  LD DE,MENU_CNEXT
  CALL PROMPT
  CALL CHARTR         ; Accept input
  CP $1B              ; Is it an escape ?
  JP Z,DRIV01         ; Yes - jump
  CP '.'
  JP Z,DRIV01         ; Change completed
  CP 'W'
  JR Z,CHANGE_WHITE
  LD A,$0D
  CALL OUTPUT
  LD DE,MENU_CNEXT
  CALL PROMPT
  LD A,'B'            ; Is it black ?
  CALL OUTPUT
  LD A,$80
  JP CHANGE_BLACK

CHANGE_WHITE:
  XOR A
CHANGE_BLACK:
  LD (COLOR),A
  LD A,$FF
  LD (MATEF_2),A
DELAY_20:
  CALL CARRET
  LD DE,MENU_MV_NUMBER
  CALL PROMPT
  CALL CHARTR
  CP $0D
  JR Z,DELAY_22
  CP ' '
  JP Z,DELAY_21
  CP $1B              ; Is it an escape ?
  JP Z,DRIV01
  CP '.'
  JP Z,DRIV01
  CALL DELAY_33
  AND A
  JP Z,DELAY_20
  LD (MVEMSG+1),A
  CALL CHARTR
  CP $0D
  JR Z,DELAY_22
  CP $1B              ; Is it an escape ?
  JP Z,DRIV01
  CP '.'
  JP Z,DRIV01
  CALL DELAY_33
  AND A
  JP Z,DELAY_20
  LD (MVEMSG+2),A
  LD A,(MVEMSG+1)
  SUB '0'
  LD D,A
  LD E,10
  CALL MLTPLY
  LD A,(MVEMSG+2)
  SUB '0'
  ADD A,D
  LD (PMATE),A
  JP INTERR

DELAY_21:
  LD A,$0D           ; New line
  CALL OUTPUT
DELAY_22:
  LD DE,MENU_MV_NUMBER
  CALL PROMPT
  CALL LOAD_MOVE
  LD A,(MVENUM)
  CALL OUTPUT
  LD A,(MVENUM+1)
  CALL OUTPUT
  JP INTERR

PRINTER_MENU:
  LD DE,PRINTER_MSG
  CALL PROMPT
  CALL CHARTR
  CP $0D             ;  Is it a carriage return ?
  JR Z,PRINTER_NO_1      ;  Yes - jump
  CP 'Y'
  JP NZ,PRINTER_NO
  LD A,$01
  LD (PRINTER_FLAG),A
  JR SETUP_GAME

PRINTER_NO:
  LD A,$0D           ; New line
  CALL OUTPUT
PRINTER_NO_1:
  LD DE,PRINTER_MSG
  CALL PROMPT
  LD A,'N'
  CALL OUTPUT
  XOR A
  LD (PRINTER_FLAG),A

SETUP_GAME:
  CALL INITBD
  XOR A              ; Code of White is zero
  LD (COLOR),A       ; White always moves first
  LD (MATEF_2),A
  INC A
  LD (PMATE),A
  CALL CARRET

; **************************************************************
; INTERROGATION FOR PLY & COLOR
; **************************************************************
; FUNCTION: --  To query the player for his choice of ply
;       depth and color.
INTERR:
  LD DE,COLOR_MENU   ; Request color choice
  CALL PROMPT
  CALL CHARTR
  CP $0D
  JR Z,DELAY_28
  CP $1B
  JP Z,DRIV01
  CP '.'
  JP Z,DRIV01
  CP 'W'             ; Did player request white ?
  LD A,$80
  JP Z,DELAY_29
  LD A,$0D
  CALL OUTPUT
DELAY_28:
  LD DE,CLRMSG
  CALL PROMPT
  LD A,'B'
  CALL OUTPUT
  XOR A
DELAY_29:
  LD (KOLOR),A
  CALL CARRET
  LD DE,LEVEL_MSG
  CALL PROMPT
  CALL CHARTR
  LD HL,MOVENO
  LD (HL),$01
  CP $0D
  JP Z,DELAY_36
  CP $1B
  JP Z,DRIV01
  CP '.'
  JP Z,DRIV01
  CP '1'             ; Under minimum of 1 ?
  JP M,DELAY_35

IF ORIGINAL
  CP '9'+1           ;  Over maximum of 9 ?
ELSE
  CP '6'+1           ;  BUGFIX: Over maximum of 6 ?
ENDIF

  JP P,DELAY_35
  SUB '0'            ;  Subtract Ascii constant
  LD (HL),A
DELAY_30:
  CALL CARRET
  LD B,$0A
  LD HL,L01D2
  XOR A
DELAY_31:
  LD (HL),A
  INC HL
  DJNZ DELAY_31
  LD DE,DISP_ALWAYS
  CALL PROMPT
  CALL CHARTR
  CP $1B
  JP Z,DRIV01
  CP '.'
  JP Z,DRIV01
  CP 'Y'
  LD A,$01
  JR Z,DELAY_32
  LD A,$0D
  CALL OUTPUT
  LD DE,DISP_ALWAYS
  CALL PROMPT
  LD A,'N'
  CALL OUTPUT
  LD A,$00
DELAY_32:
  LD (DISP_BD),A
  CALL CLS
  RET

DELAY_33:
  CP $30
  JP M,DELAY_34
  CP '9'+1
  JP P,DELAY_34
  RET

DELAY_34:
  CALL CARRET
  CALL RING_BELL
  XOR A
  RET

DELAY_35:
  LD A,$0D
  CALL OUTPUT
DELAY_36:
  LD DE,LEVEL_MSG
  CALL PROMPT
  LD A,$31
  CALL OUTPUT
  JP DELAY_30

DELAY_37:
  XOR A
  LD (L0558),A
  LD A,(MATEF_2)
  CP $FF
  JP NZ,DELAY_38
  LD A,$80
  LD (MATEF_2),A
DELAY_38:
  CALL FM35_SUB_9
  CALL ASNTBI_2
  LD HL,(L0117)
  LD (MLPTRJ),HL
  CALL ASNTBI_1
  LD A,(L0505)
  AND A
  JR NZ,EVAL
  LD A,(L0504)
  CP $01
  JR Z,L2372_42

EVAL:
  CALL MOVE           ; Make move on the board array
  CALL CK_BESTM          ;  Determine if move is legal
  LD A,(VALM+1)
  AND A               ; Legal move ?
  JR Z,EV5            ; Yes - jump
  CALL DELAY_110
  LD A,(L0505)
  CP $FF
  RET NZ
  LD A,(L0504)
  CP $FE
  JR Z,L2372_43
  NEG
  SRA A
  ADD A,$2F
  LD (MATE_IN),A
  CALL CARRET
  CALL PROMPT_0
  LD DE,MATE
  CALL PRINT
  CALL PROMPT_0
  LD DE,CHECKMATE_IN
  CALL PRINT
  CALL CARRET
  CALL PRTBLK_1
  RET

EV5:
  CALL CARRET
  LD DE,STALEMATE
  CALL PRINT
  LD A,(COLOR)
  AND A
  JR Z,L2372_41
  CALL OUTPUT_4
L2372_41:
  LD A,(PRINTER_FLAG)
  AND A
  JR Z,L2372_46
  LD HL,STALEMATE
  CALL OUTPUT_7
  JR L2372_46
L2372_42:
  LD A,(COLOR)
  XOR $80
  LD (COLOR),A

L2372_43:
  CALL CARRET
  CALL CLEAN_MOVE_MSG
  LD A,(COLOR)
  AND A
  JR Z,L2372_44
  LD DE,MVEMSG_B
  JR L2372_45
L2372_44:
  LD DE,MVEMSG_A
L2372_45:
  LD BC,$0005
  LD HL,MATE
  LDIR
  CALL PRTBLK_1
  CALL OUTPUT_4
  CALL CARRET
L2372_46:
  CALL CARRET
  CALL CLEAN_MOVE_MSG
  CALL DISPLAY_BOARD
  CALL CHARTR
  JP DRIV01

; This entry point is used by the routine at L2B1B.
L2372_47:
  CALL CONSOLE_STATUS
  AND A
  JR NZ,PLAYER_MOVE
  LD A,(L0168)
  AND A
  JR Z,L2372_50
  LD A,(MATEF_2)
  AND A
  JR NZ,L2372_48
  CALL L2B1B_34
  CALL L2B1B_37
  JR L2372_51

L2372_48:
  CALL DELAY_37
  RET

PLAYER_MOVE:
  XOR A
  LD (L0168),A
L2372_50:
  CALL L2372_57
  CALL L2B1B
  CALL L2372_58
; This entry point is used by the routine at L2B1B.
L2372_51:
  LD HL,L01E0
  LD B,$02
L2372_52:
  CALL ASNTBI
  JR Z,L2372_53
  DJNZ L2372_52
  CALL VALMOV         ; Determines if a legal move
  JR Z,L2372_53
  CALL ASNTBI_1
  CALL DELAY_110
  RET

L2372_53:
  LD A,(L0168)
  AND A
  JR Z,L2372_54
  XOR A
  LD (L0168),A
  JR L2372_47

L2372_54:
  CALL CARRET
  CALL PROMPT_0
  LD DE,INVAL1
  CALL PRINT
  CALL PROMPT_0
  LD DE,INVAL2
  CALL PRINT
  CALL PRTBLK_1
  JP L2372_47

L2372_55:
  LD B,$07
L2372_56:
  PUSH BC
  LD A,$08			  ; TAB
  CALL OUTPUT
  POP BC
  DJNZ L2372_56
  RET

; This entry point is used by the routine at L2B1B.
L2372_57:
  CALL L2372_55
  LD A,(COLOR)
  AND A
  RET NZ
  CALL TAB
  CALL L2372_55
  RET

; This entry point is used by the routine at L2B1B.
L2372_58:
  LD A,(COLOR)
  AND A
  JR Z,L2372_60
  LD B,$02
; This entry point is used by the routine at L2B1B.
L2372_59:
  EXX
  LD A,' '
  CALL OUTPUT
  EXX
  DJNZ L2372_59
  RET

L2372_60:
  LD B,$0A
  JR L2372_59

VALMOV:
  LD HL,(MLPTRJ)     ; Save last move pointer
  PUSH HL            ; Save register
  LD HL,PLYIX        ; Load move list index
  LD (MLPTRI),HL
  LD HL,MLIST2       ; Next available list pointer  (MLIST+1024)
  LD (MLNXT),HL
  CALL GENMOV        ; Generate opponents moves
  LD IX,MLIST2       ; Index to start of moves  (MLIST+1024)
VA5:
  LD A,(MVEMSG)      ; "From" position
  CP (IX+MLFRP)      ; Is it in list ?
  JR NZ,VA6          ; No - jump
  LD A,(MVEMSG+3)    ; "To" position
  CP (IX+MLTOP)      ; Is it in list ?
  JR Z,VA7           ; Yes - jump
VA6:
  LD E,(IX+MLPTR)    ; Pointer to next list move
  LD D,(IX+MLPTR+1)
  XOR A              ; At end of list ?
  CP D
  JR Z,VA10          ; Yes - jump
  PUSH DE            ; Move to X register
  POP IX
  JP VA5             ; Jump

VA7:
  LD (MLPTRJ),IX     ; Save move pointer
  CALL MOVE
  CALL CK_BESTM
  LD A,(VALM+1)
  AND A
  JR Z,VA9
  POP HL
  RET

VA9:
  CALL UNMOVE
VA10:
  XOR A
  POP HL             ; Restore saved register
  LD (MLPTRJ),HL     ; Save move pointer
  RET


; ****************
;    EDIT BOARD
; ****************
EDIT_BOARD:
  LD DE,BOARD_EDIT_MSG
  CALL PRINT
  CALL CHARTR
  CP 'S'
  JR NZ,EDIT_EMPTY
  LD A,$80
  LD (KOLOR),A
  CALL INITBD
  JR EDIT_START_POS

EDIT_EMPTY:
  CP 'E'
  JR NZ,EDIT_DEFAULT
  CALL CLEANBD
  LD A,$80
  LD (KOLOR),A
  JR EDIT_START_POS

EDIT_DEFAULT:
  LD A,(PMATE)
  CP $02
  CALL M,INITBD
EDIT_START_POS:
  CALL CLEAN_LAST_CMD_MSG
  CALL DSPBRD

EDIT:
  CALL CHARTR
  CP $1B
  RET Z
  CP '.'
  RET Z
  LD BC,$0009
  LD HL,COLUMNS_A_H
  CPIR
  JP PE,EDIT_0
  CALL TWO_TABS
  CALL RING_BELL
  JR EDIT

EDIT_0:
  LD (MVEMSG),A
  LD (LAST_CMD_MSG),A
EDIT_1:
  CALL CHARTR
  CP $1B     ; ESC ?
  RET Z
  CP '.'
  RET Z
  CP $08     ; Backspace ?
  JP Z,BACKSPACE
  LD BC,$0009
  LD HL,ROWS_1_8
  CPIR
  JP PO,EDIT_ERROR
  LD (MVEMSG+1),A
  LD (LAST_CMD_MSG+1),A
  LD HL,MVEMSG+1
  CALL ASNTBI
  LD HL,BOARDA
  LD C,A
  LD B,$00
  ADD HL,BC
  LD (L0163),HL
  LD A,' '
  CALL OUTPUT
EDIT_2:
  CALL CHARTR
  CP $1B
  RET Z
  CP '.'
  RET Z
  CP $08
  JP Z,BACKSPACE_2
  CP $7F
  JP Z,L2372_75
  CP 'X'
  JP NZ,L2372_76
L2372_75:
  LD C,$00
  LD A,'X'
  LD (LAST_CMD_MSG+3),A
  JP L2372_83

L2372_76:
  LD BC,$0007
  LD HL,PCS
  CPIR
  JP PO,EDIT_ERROR_2
  LD (LAST_CMD_MSG+3),A
  LD A,' '
  CALL OUTPUT
L2372_77:
  CALL CHARTR
  CP $1B
  RET Z
  CP '.'
  RET Z
  CP $08
  JR NZ,L2372_78
  CALL TWO_TABS
  JR EDIT_2

L2372_78:
  CP 'B'
  JP NZ,L2372_79
  SET 7,C
  JP L2372_80
L2372_79:
  CP 'W'
  JP Z,L2372_80
  CALL TWO_TABS
  CALL RING_BELL
  JR L2372_77

L2372_80:
  LD (LAST_CMD_MSG+5),A
  LD A,' '
  CALL OUTPUT
L2372_81:
  CALL CHARTR
  CP $1B
  RET Z
  CP '.'
  RET Z
  CP $08
  JP Z,L2372_88
  CP '0'
  JP Z,L2372_82
  CP '1'
  JP NZ,L2372_91
  SET 3,C
L2372_82:
  LD (LAST_CMD_MSG+7),A
L2372_83:
  CALL CLS
  LD HL,(L0163)
  LD (HL),C
  LD DE,LAST_COMMAND
  CALL PRINT
  JP EDIT_START_POS

BACKSPACE:
  CALL TBPLCL        ; Tab to players column
  JP EDIT

EDIT_ERROR:
  CALL TWO_TABS
  CALL RING_BELL
  JP EDIT_1

BACKSPACE_2:
  CALL TBPLCL
  CALL TWO_TABS
  CALL TWO_TABS
  JP EDIT

EDIT_ERROR_2:
  CALL TWO_TABS
  CALL RING_BELL
  JP EDIT_2

L2372_88:
  CALL TWO_TABS
  LD A,' '
  LD (LAST_CMD_MSG+5),A
  JP L2372_77

; This entry point is used by the routines at L2B1B, PROMPT and SET_FILENAME.
TWO_TABS:
  CALL TAB

;***********************************************************
; TAB TO PLAYERS COLUMN
;***********************************************************
; This entry point is used by the routine at L2B1B.
TBPLCL:
  LD A,' '
  CALL OUTPUT
  CALL TAB
  RET

L2372_91:
  CALL TWO_TABS
  CALL RING_BELL
  JP L2372_81

DISPLAY_BOARD:
  LD A,(DISP_BD)
  OR A
  RET Z

; This entry point is used by the routine at L2B1B.
DSPBRD:
  CALL CARRET
  CALL CARRET
  LD A,(KOLOR)
  OR A
  JR Z,rotate_view
  LD IX,BOARDA+91       ; board bottom-left corner
  LD DE,$0001
  LD C,$38
  JR DB1
rotate_view:
  LD IX,BOARDA+28       ; board top-right corner
  LD DE,$FFFF
  LD C,$31
  LD B,$00
DB1:
  CALL BMARGIN          ; print board letters on border
DB2:
  LD A,C
  CALL OUTPUT
  LD A,' '
  CALL OUTPUT
DB3:
  LD A,(IX+$00)
  ADD IX,DE
  CP $FF                ; board margin ?
  JR Z,DB7
  OR A
  JR Z,DB4
  CALL PUT_PIECE    ; print piece on board
  JR DB6
DB4:
  BIT 0,B
  LD A,':'          ; black space
  JR NZ,DB5
  LD A,' '          ; white space
DB5:
  CALL OUTPUT
  CALL OUTPUT
DB6:
  LD A,' '
  CALL OUTPUT
  INC B
  JR DB3

DB7:
  LD A,C
  CALL OUTPUT
  CALL CARRET
  LD A,C
  SUB E
  CP '0'
  JR Z,DELAY_103
  CP '9'
  JR Z,DELAY_103
  LD C,A
  LD A,E
  OR A
  LD HL,19
  JP M,DB8
  LD HL,-19
DB8:
  EX DE,HL
  ADD IX,DE
  EX DE,HL
  INC B
  JR DB2
DELAY_103:
  CALL BMARGIN      ; print board letters on border
IF !TRS80
  CALL CARRET
ENDIF
  RET

BMARGIN:
  INC E
  DEC E
  LD B,'A'
  JP P,DELAY_105
  LD B,'H'
DELAY_105:
  LD A,' '
  CALL OUTPUT
  CALL OUTPUT
  LD A,B
  CALL OUTPUT
  ADD A,E
  LD B,A
  CP 'A'-1
  JR Z,DELAY_106
  CP 'H'+1
  JR Z,DELAY_106
  JR DELAY_105
DELAY_106:
  CALL CARRET
  RET

PUT_PIECE:
  PUSH AF
  LD A,'W'
  JP P,PRINT_COLOR
  LD A,'B'
PRINT_COLOR:
  CALL OUTPUT
  POP AF
  AND $07
  LD HL,REV_PCS
  ADD A,L
  LD L,A
  JR NC,DELAY_109
  INC H
DELAY_109:
  LD A,(HL)
  CALL OUTPUT
  RET

DELAY_110:
  LD IX,(MLPTRJ)
  BIT 6,(IX+$04)
  JP NZ,JR23
  LD D,(IX+$02)       ; "To" position of the move
  CALL BITASN         ; Convert to Ascii
  LD (MVEMSG),HL      ; Put in move message
  LD D,(IX+$03)       ; "From" position of the move
  CALL BITASN         ; Convert to Ascii
  LD (MVEMSG+3),HL    ; Put in move message
  LD A,(IX+$04)
  AND $07
  LD A,'-'
  JR Z,DELAY_111
  LD A,120
DELAY_111:
  LD (MVEMSG+2),A
  LD DE,MVEMSG
  JP JR22

JR23:
  LD DE,$0005
  ADD IX,DE
  LD A,(IX+$03)
  CP (IX+$02)
  LD DE,P_PEP          ; Output "PxPep" - En passant
  JR Z,JR22            
  LD DE,O_O            ; King side castle
  CP $1A               ; White O-O
  JR Z,JR22
  CP $60               ; Black 0-0
  JR Z,JR22
  LD DE,O_O_O          ; Queen side castle
JR22:
  LD A,(COLOR)
  AND A
  JR Z,DELAY_114
  LD HL,MVEMSG_B
  JR DELAY_115

DELAY_114:
  LD HL,MVEMSG_A
DELAY_115:
  EX DE,HL
  LD BC,$0005
  LDIR
  CALL PRTBLK
  LD A,(L0138)
  AND A
  RET Z
  CALL OUTPUT_4
  CALL CLEAN_MOVE_MSG
  CALL CARRET
  LD A,(COLOR)
  AND A
  JR Z,DELAY_116
  LD DE,MVEMSG_B
  JR DELAY_117
DELAY_116:
  LD DE,MVEMSG_A
DELAY_117:
  LD BC,$0005
  LD HL,CHECKMATE
  LDIR
  CALL PRTBLK_1
  RET


; Routine at 10922
;
; Used by the routines at GAME_DRIVER and L2AC9.
CLEAN_MOVE_MSG:
  LD B,$12
  LD HL,MVENUM
; This entry point is used by the routine at CLEAN_LAST_CMD_MSG.
CLEAN_MOVE_MSG_0:
  LD A,' '
CLEAN_MOVE_MSG_1:
  LD (HL),A
  INC HL
  DJNZ CLEAN_MOVE_MSG_1
  RET


; Routine at 10934
;
; Used by the routine at GAME_DRIVER.
CLEAN_LAST_CMD_MSG:
  LD HL,LAST_CMD_MSG
  LD B,$08
  JR CLEAN_MOVE_MSG_0
  LD HL,MVEMSG
  LD DE,MVEMSG_A
; This entry point is used by the routine at L2AC9.
CLEAN_LAST_CMD_MSG_0:
  LD BC,$0005
  LDIR
  RET


; Routine at 10953
L2AC9:
  LD HL,MVEMSG
  LD DE,MVEMSG_B
  JR CLEAN_LAST_CMD_MSG_0

; This entry point is used by the routine at PROMPT.
L2AC9_0:
  LD A,(PLYMAX)
  ADD A,'0'
  LD (MVEMSG_B+6),A
  RET

; This entry point is used by the routines at GAME_DRIVER and L2B1B.
LOAD_MOVE:
  LD HL,MVENUM_MSG+2      ; Addr of 3rd char of move
  LD A,(PMATE)
  LD D,A
  LD E,10             ; Divisor
  LD B,$02
L2AC9_2:
  XOR A
  CALL DIVIDE
  ADD A,'0'
  DEC HL
  LD (HL),A
  DJNZ L2AC9_2
  CP '0'
  JR NZ,L2AC9_3
  LD (HL),' '
  CALL CLEAN_MOVE_MSG
L2AC9_3:
  LD HL,MVENUM_MSG
  LD DE,MVENUM
  LD BC,$0003
  LDIR
  RET

; This entry point is used by the routines at FM35_SUB, L2372, L2B1B and
; PROMPT.
PRTBLK:
  LD A,$0D
  CALL OUTPUT
; This entry point is used by the routines at GAME_DRIVER and L2B1B.
PRTBLK_1:
  LD DE,MVENUM
  CALL PROMPT
  RET


; Routine at 11024
;
; Used by the routines at GAME_DRIVER and L2B1B.
RING_BELL:
  LD A,(BELL)
  AND A
  RET Z
  LD A,$07
  CALL OUTPUT
  RET


; Routine at 11035
;
; Used by the routine at GAME_DRIVER.
L2B1B:
  LD DE,MVEMSG
L2B1B_0:
  CALL CHARTR
  CP 'N'
  JP Z,L2B1B_31
  CALL L2B1B_3
  AND A
  JR Z,L2B1B_0
  CP $FF
  JR NZ,L2B1B_1
  CALL TBPLCL
  JR L2B1B

L2B1B_1:
  LD A,'-'
  CALL OUTPUT
  INC DE
  CALL L2B1B_2
  CP $FF
  RET NZ
  CALL TBPLCL
  CALL TWO_TABS
  CALL TWO_TABS
  JR L2B1B

L2B1B_2:
  CALL CHARTR
L2B1B_3:
  CALL L2B1B_8
  JR Z,L2B1B_2
  CP $FF
  RET Z
  PUSH DE
  CALL L2B1B_29
  POP DE
  AND A
  JR NZ,L2B1B_4
  CALL RING_BELL
  CALL TWO_TABS
  JR L2B1B_2
L2B1B_4:
  LD (DE),A
  INC DE
L2B1B_5:
  CALL CHARTR
  CALL L2B1B_8
  JR Z,L2B1B_5
  CP $FF
  JR NZ,L2B1B_6
  CALL TBPLCL
  DEC DE
  JR L2B1B_2
L2B1B_6:
  PUSH DE
  CALL L2B1B_30
  POP DE
  AND A
  JR NZ,L2B1B_7
  CALL RING_BELL
  CALL TWO_TABS
  JR L2B1B_5
L2B1B_7:
  LD (DE),A
  INC DE
  RET

L2B1B_8:
  PUSH DE
  CP $1B
  JP Z,DRIV01
  CP '.'
  JP Z,DRIV01
  CP 'K'
  JP Z,L2B1B_15
  CP 'P'
  JP Z,L2B1B_16
  CP 'Z'
  JP Z,L2B1B_23
  CP $0D
  JP Z,L2B1B_11
  CP 'Q'
  JP Z,L2B1B_26
  CP 'M'
  JP Z,L2B1B_12
  CP '@'
  JP Z,L2B1B_14
  CP 'V'
  JP Z,L2B1B_24
  CP 'R'
  JP Z,L2B1B_21
  CP 'Y'
  JP Z,L2B1B_17
  CP $08
  JR NZ,L2B1B_9
  LD A,$FF
L2B1B_9:
  CP $7F
  JR NZ,L2B1B_10
  LD A,$FF
L2B1B_10:
  POP DE
  RET

L2B1B_11:
  CALL CARRET
  CALL PRTBLK_1
  JP L2B1B_27

L2B1B_12:
  CALL TWO_TABS
  CALL CLS
  LD DE,L2271
  CALL PRINT
  JP L2B1B_25

; This entry point is used by the routine at PROMPT.
L2B1B_13:
  CALL TWO_TABS
  CALL CARRET
  LD DE,QUIT_MSG
  CALL PRINT
  CALL SHOW_MV
  RET

L2B1B_14:
  CALL TWO_TABS
  LD B,$05
  CALL L2372_59
  CALL L2372_58
  LD A,$FF
  LD (L0168),A
  POP DE
  POP HL
  POP HL
  POP HL
  JP L2372_47

L2B1B_15:
  CALL TWO_TABS
  XOR A
  LD (PRINTER_FLAG),A
  LD DE,P_OFF
  CALL PROMPT
  JP L2B1B_28
L2B1B_16:
  CALL TWO_TABS
  LD A,$01
  LD (PRINTER_FLAG),A
  LD DE,P_ON
  CALL PROMPT
  JP L2B1B_28

L2B1B_17:
  CALL TWO_TABS
  CALL CARRET
  LD DE,LEVEL_MSG
  CALL PROMPT
  CALL CHARTR
  CP $1B
  JR Z,L2B1B_19
  CP '.'
  JR Z,L2B1B_19
  LD HL,MOVENO
  CP '1'
  JP M,L2B1B_18
  CP '9'+1
  JP P,L2B1B_18
  SUB '0'
  LD (HL),A
L2B1B_18:
  CALL TWO_TABS
L2B1B_19:
  LD A,(MOVENO)
  ADD A,'0'
  CALL OUTPUT
  LD A,(PRINTER_FLAG)
  AND A
  JR Z,L2B1B_20
  LD A,$01
  LD (USE_PRINTER),A
L2B1B_20:
  CALL CARRET
  CALL SHOW_MV
  XOR A
  LD (USE_PRINTER),A
  CALL L2372_57
  JP L2B1B_28

L2B1B_21:
  CALL TWO_TABS
  LD A,(KOLOR)           ; Computers color
  XOR $80
  LD (KOLOR),A
  CALL OUTPUT_4
  LD A,(PRINTER_FLAG)
  AND A
  JR Z,L2B1B_22
  LD A,$01
  LD (USE_PRINTER),A
L2B1B_22:
  CALL LOAD_MOVE
  CALL CARRET
  CALL SHOW_MV
  XOR A
  LD (USE_PRINTER),A
  LD SP,STACK
  LD A,$01
  LD (FIRST_MOVE),A
  JP L2372_6
  
L2B1B_23:
  LD A,$01
  LD (USE_PRINTER),A
L2B1B_24:
  CALL CLS
  CALL DSPBRD
L2B1B_25:
  CALL SHOW_MV
  XOR A
  LD (USE_PRINTER),A
  JR L2B1B_27

L2B1B_26:
  CALL TWO_TABS
  CALL EXIT_GAME
L2B1B_27:
  CALL L2372_57
L2B1B_28:
  POP DE
  POP HL
  POP HL
  JP L2B1B
 
L2B1B_29:
  LD BC,$0009
  LD HL,COLUMNS_A_H
  CPIR
  RET PE
  XOR A
  RET

L2B1B_30:
  LD BC,$0009
  LD HL,ROWS_1_8
  CPIR
  RET PE
  XOR A
  RET

L2B1B_31:
  CALL TWO_TABS
  LD A,(MATEF_2)
  CP $FF
  JP Z,L2B1B_35
  CP $80
  JR NZ,L2B1B_33
  LD A,(L0558)
  AND A
  JP Z,L2B1B_35
L2B1B_32:
  CALL L2B1B_38
  CALL CHARTR
  CP $0D
  JR Z,L2B1B_36
  CALL TWO_TABS
  CALL PRTBLK
  CALL L2372_57
  JP L2B1B

L2B1B_33:
  CALL L2B1B_34
  JP L2B1B_32

; This entry point is used by the routine at GAME_DRIVER.
L2B1B_34:
  LD HL,(MLPTRJ)        ; Save last move pointer
  PUSH HL               ; Save register
  LD HL,(L011F)
  PUSH HL
  LD A,(MATEF_2)
  PUSH AF
  LD A,$01
  LD (FIRST_MOVE),A
  CALL FM35_SUB_10
  POP AF
  LD (MATEF_2),A
  POP HL
  LD (L011F),HL
  POP HL                ; Restore saved register
  LD (MLPTRJ),HL        ; Save move pointer
  LD IX,(L0117)
  LD L,(IX+$02)
  LD H,(IX+$03)
  LD (L0558),HL
  RET

L2B1B_35:
  CALL RING_BELL
  JP L2B1B
  
L2B1B_36:
  CALL PRTBLK_1
  CALL L2B1B_37
  POP HL
  JP L2372_51
  
; This entry point is used by the routine at GAME_DRIVER.
L2B1B_37:
  LD DE,MVEMSG
  PUSH DE
  LD IY,TBASE
  LD D,(IY+$02)
  CALL BITASN
  POP DE
  LD A,L
  LD (DE),A
  INC DE
  LD A,H
  LD (DE),A
  INC DE
  INC DE
  PUSH DE
  LD D,(IY+$03)
  CALL BITASN
  POP DE
  LD A,L
  LD (DE),A
  INC DE
  LD A,H
  LD (DE),A
  RET

L2B1B_38:
  LD IX,TBASE
  LD D,(IX+$02)
  CALL BITASN
  LD A,L
  CALL OUTPUT
  LD A,H
  CALL OUTPUT
  LD A,'-'
  CALL OUTPUT
  LD D,(IX+$03)
  CALL BITASN
  LD A,L
  CALL OUTPUT
  LD A,H
  CALL OUTPUT
  CALL L2372_58
  LD A,'?'
  CALL OUTPUT
  CALL TAB
  RET


; Routine at 11701
;
; Used by the routines at GAME_DRIVER and L2B1B.
TAB:
  LD A,$08			  ; TAB
  CALL OUTPUT
  RET

;---------------------------------------
IF !MYCONSOLE
IF SINCLAIR
; Routine at 11707
;
; Used by the routines at GAME_DRIVER, L2B1B, PROMPT and SET_FILENAME.
CHARTR:
  PUSH BC
  PUSH DE
  PUSH HL
  PUSH IY
  LD (SPSAVE),SP
  LD SP,ENTRY

    ld  iy,$5C3A
    ei

    set 3,(iy+$30)  ; CAPS LOCK ON

    ld  hl,$5C08
    ld  (hl),0

nokey:
    push hl
    CALL 1F54h           ; call BREAK-KEY to read keyboard immediately.
    pop hl
    ld  a,3
    jr  NC,break

    ld  a,(hl)
    and a
    jr  z,nokey

    ld  (hl),0

    cp  12
    jr  nz,noBKSP
    ld  a,8
    jr  bksp        ; BACKSPACE REMAPPED
noBKSP:
    push af
    rst 16
    pop af
bksp:
break:
    di
   

  LD SP,(SPSAVE)
  POP IY
  POP HL
  POP DE
  POP BC
  CP $03        ; BREAK ?
  JP Z,EXIT_GAME
  RET
;---------------------------------------

ELSE
; Routine at 11707
;
; Used by the routines at GAME_DRIVER, L2B1B, PROMPT and SET_FILENAME.
CHARTR:
  PUSH BC
  PUSH DE
  PUSH HL
  LD C,$01
  CALL BDOS
  CP $61
  JR C,CHARTR_0
  CP $7B
  JR NC,CHARTR_0
  SUB $20
CHARTR_0:
  POP HL
  POP DE
  POP BC
  CP $03        ; CTRL-C ?
  JP Z,WBOOT
  RET
ENDIF
ENDIF

; Data block at 11734
SPSAVE:
  DEFW $0000

; Data block at 11736
USE_PRINTER:
  DEFB $00


IF !MYCONSOLE
; Routine at 11737
;
; Used by the routines at ASNTBI, L2372, L2AC9, RING_BELL, L2B1B, TAB, PROMPT
; and FCB_FNAME.
OUTPUT:
;---------------------------------------
IF TRS80
    cp 10
    jr nz,nolf
    ld a,13         ; NEWLINE
    jr DO_OUTPUT
nolf:
    cp 13
    jr nz,DO_OUTPUT
    ld a,29         ; Carriage Return the TRS80 way (set cursor on top of row)
DO_OUTPUT:
ENDIF
;---------------------------------------
  PUSH IX
  PUSH IY
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
;---------------------------------------

IF SINCLAIR
  LD (SPSAVE),SP
  LD SP,ENTRY
;   and 7Fh
    cp 10   ; suppress LF
    jr z,nolf
    ld  iy,$5C3A
    ei
    rst 16
nolf:
    xor a
;    LD      ($5C8C),a   ; disable "scroll?" message
    di
    ; TODO:  add optional echo to printer
ELSE
;---------------------------------------
  PUSH AF
  LD (SPSAVE),SP
  LD SP,ENTRY
  LD E,A
  LD C,$02
  CALL BDOS
  LD SP,(SPSAVE)
  POP AF
  LD (SPSAVE),SP
  LD SP,ENTRY
  LD E,A
  LD A,(USE_PRINTER)
  AND A
  JR Z,OUTPUT_0
  LD C,$05
  CALL BDOS
OUTPUT_0:
;---------------------------------------
ENDIF

ENDIF

  LD SP,(SPSAVE)
  POP AF
  POP BC
  POP DE
  POP HL
  POP IY
  POP IX
  CP $0D
  JP Z,OUTPUT_1
  CP $0A
  JP Z,OUTPUT_1
  RET

OUTPUT_1:
  PUSH BC
  LD B,$02
OUTPUT_2:
  LD C,$F9
OUTPUT_3:
  DEC C
  JR NZ,OUTPUT_3
  DEC B
  JR NZ,OUTPUT_2
  POP BC
  RET

; This entry point is used by the routines at GAME_DRIVER and L2B1B.
OUTPUT_4:
  LD A,(PRINTER_FLAG)
  AND A
  RET Z
  LD IX,MVENUM
  LD A,$20
  LD (IX+$11),A
  LD HL,MVENUM
  CALL OUTPUT_5
  LD A,$01
  LD (USE_PRINTER),A
  CALL CARRET
  XOR A
  LD (USE_PRINTER),A
  RET

; This entry point is used by the routine at GAME_DRIVER.
OUTPUT_5:
  LD A,(HL)
  CP $24
  RET Z
  PUSH HL
  CALL OUTPUT_6
  POP HL
  LD A,(HL)
  CP $0D
  CALL Z,OUTPUT_8
  INC HL
  JR OUTPUT_5

OUTPUT_6:
IF !SINCLAIR
  LD C,$05          ; L_WRITE - Printer output
  LD E,A
  CALL BDOS
ENDIF
  RET

; This entry point is used by the routine at GAME_DRIVER.
OUTPUT_7:
  CALL OUTPUT_5
  LD A,$0D
  CALL OUTPUT_6
  LD A,$0A
  CALL OUTPUT_6
OUTPUT_8:
  PUSH DE
  LD D,$78
OUTPUT_9:
  LD E,$FA
OUTPUT_10:
  DEC E
  JR NZ,OUTPUT_10
  DEC D
  JR NZ,OUTPUT_9
  POP DE
  RET

; This entry point is used by the routine at PROMPT.
OUTPUT_11:
  LD A,(DE)
  CALL OUTPUT
  INC DE
  DJNZ OUTPUT_11
  RET

; This entry point is used by the routines at GAME_DRIVER, L2B1B and SET_FILENAME.
CLS:
  PUSH AF
  LD A,(USE_PRINTER)
  PUSH AF
  XOR A
  LD (USE_PRINTER),A

IF TRS80
  LD A,28
  CALL OUTPUT
  LD A,31
  CALL OUTPUT
ELSE
IF CLS_CHR
  LD A,CLS_CHR
  CALL OUTPUT
ELSE
IF SINCLAIR
    ld  iy,$5C3A
    ei
    call $0DAF
    ld  iy,$5C3A
    di          ; it also disables the interrupts for the first time
ELSE
  LD B,$18
CLS_LOOP:
  LD A,$0A
  CALL OUTPUT
  DJNZ CLS_LOOP
ENDIF
ENDIF
ENDIF

  POP AF
  LD (USE_PRINTER),A
  POP AF
; This entry point is used by the routines at GAME_DRIVER, L2B1B and PRINT.
CARRET:
  PUSH AF
  LD A,$0D
  CALL OUTPUT
  LD A,$0A
  CALL OUTPUT
  POP AF
  RET


; PRINT ANY BLOCK
;
; Used by the routines at GAME_DRIVER, L2B1B and NOT_FOUND_ERR.
PRINT:
  CALL PROMPT
  CALL CARRET
  RET


; Ask the user
;
; Used by the routines at GAME_DRIVER, L2AC9, L2B1B, PRINT, START and SET_FILENAME.
PROMPT:
  LD A,(DE)
  CP '$'
  RET Z
  CALL OUTPUT
  INC DE
  JR PROMPT
  RET

; This entry point is used by the routine at GAME_DRIVER.
PROMPT_0:
  LD DE,SPACE
  LD B,$03
  CALL OUTPUT_11
  LD A,(COLOR)
  AND A
  RET Z
  LD DE,SPACE
  LD B,$08
  CALL OUTPUT_11
  RET

; This entry point is used by the routine at FM35_SUB.
PROMPT_1:
  CALL L2AC9_0
  CALL PRTBLK
  RET

; This entry point is used by the routine at SORT_SUB.
PROMPT_2:
  CALL CHARTR
  CP 'Q'
  JP Z,EXIT_GAME
  CP 'M'
  JP Z,L2B1B_13
  CP '#'
  JR Z,PROMPT_3
  XOR A
  LD (L0168),A
  CALL TWO_TABS
  RET

PROMPT_3:
  CALL TWO_TABS
  LD A,(NPLY)
  CP $01
  JR Z,PROMPT_4
  CALL PROMPT_5
  JR PROMPT_3

PROMPT_4:
  LD HL,MVEMSG_A+6
  LD A,'#'
  LD (HL),A
  POP HL
  POP HL
  RET

PROMPT_5:
  LD HL,COLOR           ; Toggle color
  LD A,$80              
  XOR (HL)              
  LD (HL),A             ; Save new color
  BIT 7,A               ; Is it black ?
  JR Z,PROMPT_6         ; Yes - jump
  LD HL,PMATE           ; Checkmate move number
  DEC (HL)              ; Decrement
PROMPT_6:
  LD HL,(SCRIX)         ; Load score table index
  DEC HL                ; Decrement
  DEC HL
  LD (SCRIX),HL         ; Save
  LD HL,NPLY            ; Decrement ply counter
  DEC (HL)
  LD HL,(MLPTRI)        ; Load ply list pointer
  DEC HL                ; Load pointer to move list top
  LD D,(HL)
  DEC HL
  LD E,(HL)
  LD (MLNXT),DE
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  LD (MLPTRI),HL
  LD (MLPTRJ),DE
  CALL UNMOVE
  RET

; This entry point is used by the routines at SORT_SUB and L2372.
CONSOLE_STATUS:
IF SINCLAIR | SHARPMZ
;   ld  iy,$5C3A
;   ei
;  ld a,($5C08)
;    di
xor a
  
ELSE
  EXX
  LD C,$0B      ; Console status
  CALL BDOS
  EXX
ENDIF
  RET


; Routine at 12104
;
; Used by the routines at ENTRY and BOARDA.
START:


IF SINCLAIR | SHARPMZ

    LD HL,sp
    LD (ZX_STACK),HL
    JP GAME_DRIVER

EXIT_GAME:
    LD HL,(ZX_STACK)
    ld sp,hl
    ld  iy,$5C3A
    ei
    ret

ZX_STACK: DEFW 0

ELSE

  LD A,(WBOOT+$5D)
  CP ' '
  JP Z,GAME_DRIVER
  LD SP,WIPE_FCB
  CALL SET_FILENAME
  LD C,$0F
  LD DE,FCB_DRIVE
  CALL BDOS
  INC A
  LD DE,NOT_FOUND
  JP Z,NOT_FOUND_ERR

GAME_LOADER:
  LD DE,ENTRY
START_1:
  LD (FILE_PTR),DE
  LD C,$1A         ; Set DMA address
  CALL BDOS
  LD C,$14         ; read next record
  LD DE,FCB_DRIVE
  CALL BDOS
  OR A
  JP NZ,RESUME_GAME
  LD DE,(FILE_PTR)
  LD HL,$0080
  ADD HL,DE
  EX DE,HL
  JR START_1

; This entry point is used by the routine at SET_FILENAME.
LOAD_GAME:
  LD DE,MSG_LOAD
  CALL GET_FILENAME
  LD C,$0F
  LD DE,FCB_DRIVE
  CALL BDOS
  INC A
  JP NZ,GAME_LOADER
  LD DE,NOT_FOUND
  CALL PROMPT
  JP LOAD_SAVE_MENU

; Routine at 12195
;
; Used by the routine at START.
NOT_FOUND_ERR:
  CALL PRINT
  CALL RESET_DMA
  JP DRIV01

; Message at 12204
SGN_EXT:
  DEFM "SGN"

; Message at 12207
TMP_EXT:
  DEFM "$$$"

; Routine at 12210
;
; Used by the routine at FCB_FNAME.
FCB_DRIVE:
  LD A,(DE)

; Routine at 12211
FCB_FNAME:
  CP $24
  RET Z
  CALL OUTPUT
  INC DE
  JR FCB_DRIVE
  RET


; FCB_EXT at 12219
  LD DE,SPACE
  LD B,$03

; Data block at 12226  ($2FC2)
FCB2_DRIVE:
  CALL OUTPUT_11
  LD A,(COLOR)
  AND A
  RET Z
  LD DE,SPACE
  LD B,$08
  CALL OUTPUT_11

; Data block at 12242
L2FD2:
  RET

  CALL L2AC9_0

; Message at 12246
FILE_NAME:
  ADD HL,BC
; Data block at 12247
  DEFB $04
; Data block at 12248
  DEC HL
  RET

  CALL CHARTR
  CP 'Q'

; JP Z,$0D64
  DEFB $CA
  DEFB $64

; Message at 12257
NOT_FOUND:
  DEFB $0D
  DEFB $0A
  DEFM "GAME FILE NOT FOUND$"

; Message at 12279
FILE_RECORDS:
  DEFB 29

; Message at 12280
OVERWRITE_FILE_MSG:
  DEFB $0D
  DEFB $0A
  DEFM "FILE ALREADY EXISTS... USE IT ANYWAY (Y/N)?$"

; Message at 12326
SAVE_MSG:
  DEFB $0D
  DEFB $0A
  DEFM "SAVE GAME TO <FILE NAME>:$"

; Message at 12354
RESUME_MSG:
  DEFB $0D
  DEFB $0A
  DEFM "RESUME GAME (Y/N)?$"

; Message at 12375
ERR_DIRECTORY_FULL:
  DEFB $0D
  DEFB $0A
  DEFM "NO DIRECTORY SPACE$"

; Message at 12396
ERR_DISK_FULL:
  DEFB $0D
  DEFB $0A
  DEFM "OUT OF DISK SPACE$"

; Message at 12416
ERR_WRITE_PROTECT:
  DEFB $0D
  DEFB $0A
  DEFM "WRITE PROTECTED?$"

; Data block at 12435
FILE_PTR:
  DEFW ENTRY

; Message at 12437
RW_ERROR:
  DEFB $0D
  DEFB $0A
  DEFM "READ WRITE ERROR ON DISK$"

; Message at 12464
MSG_SAVELOAD:
  DEFB $0D
  DEFB $0A
  DEFM "SAVE THIS GAME OR LOAD OLD? (S OR L):$"

; Message at 12504
MSG_LOAD:
  DEFB $0D
  DEFB $0A
  DEFM "LOAD GAME FROM <FILE NAME>:$"

;------------------------------------;
; 35 bytes of foo data, but this buffer space for some reason is necessary
;------------------------------------;

; Message at 12534
  DEFM "$"
; Message at 12535
  DEFB $1D
  DEFB $0D
  DEFB $0A
  DEFM "FILE ALREADY EXISTS... USE IT A"
;------------------------------------;



WIPE_FCB:
  LD B,'$'
; Routine at 12571
  LD HL,FCB_DRIVE
  XOR A
WIPE_FCB_0:
  LD (HL),A
  INC HL
  DJNZ WIPE_FCB_0
  RET


; Routine at 12580
;
; Used by the routine at START.
SET_FILENAME:
  CALL WIPE_FCB
  LD C,$10
  LD HL,WBOOT+$5C
  LD DE,FCB_DRIVE
  LD BC,$0010
  LDIR
SET_SGN_EXT:
  LD HL,SGN_EXT
SET_FILE_EXT:
  LD DE,FCB_FNAME+8 ;FCB_EXT
  LD BC,$0003
  LDIR
  RET

SET_TMP_EXT:
  LD HL,TMP_EXT
  JP SET_FILE_EXT

; This entry point is used by the routine at START.
RESUME_GAME:
  CALL RESET_DMA
  CALL CLS
  CALL LDSPBRD
  LD A,(DISP_BD)
  AND A
  CALL Z,SHOW_MV
  LD SP,(SPSAVE_CPM)
  RET

; This entry point is used by the routine at NOT_FOUND_ERR.
RESET_DMA:
  LD DE,WBOOT+$80
  LD C,$1A      ; Set DMA address
  CALL BDOS
  RET

; This entry point is used by the routines at L2B1B and PROMPT.
EXIT_GAME:
  CALL TWO_TABS
  LD (SPSAVE_CPM),SP
; This entry point is used by the routine at START.
LOAD_SAVE_MENU:
  LD A,29
  LD (FILE_RECORDS),A
  LD SP,WIPE_FCB
  CALL WIPE_FCB
  LD A,' '
  LD B,8
  LD HL,FCB_FNAME
SET_FILENAME_7:
  LD (HL),A
  INC HL
  DJNZ SET_FILENAME_7
  LD DE,MSG_SAVELOAD
  CALL PROMPT
  CALL CHARTR
  CP 'S'
  JP Z,SAVE_GAME
  CP 'L'
  JP Z,LOAD_GAME
  CP $1B
  JP Z,RESUME_GAME
  CP '.'
  JP Z,RESUME_GAME
  JR LOAD_SAVE_MENU

; This entry point is used by the routine at START.
GET_FILENAME:
  CALL PROMPT
  LD C,$0A      ; Buffered console input (C_READSTR)
  LD DE,FILE_NAME
  CALL BDOS
  LD A,(FILE_NAME+1)
  AND A
  JP Z,SET_FILE_EXT0
  LD C,A
  XOR A
  LD B,A
  LD HL,FILE_NAME+2
  LD DE,FCB_FNAME
GET_FILENAME_1:
  LD A,(HL)
  CP '.'
  JR Z,SET_FILE_EXT1
  LD (DE),A
  XOR A
  INC HL
  INC DE
  DEC BC
  CP C
  JR NZ,GET_FILENAME_1
  JP SET_FILE_EXT1

SET_FILE_EXT0:
  CALL SET_FILE_EXT6
SET_FILE_EXT1:
  CALL SET_SGN_EXT
  RET

SAVE_GAME:
  LD DE,SAVE_MSG
  CALL GET_FILENAME
  LD C,$11           ; search for first file in directory (F_SFIRST)
  LD DE,FCB_DRIVE
  CALL BDOS
  CP $FF
  JR Z,NEW_FILE
  LD DE,OVERWRITE_FILE_MSG
  CALL PROMPT
  CALL CHARTR
  CP 'Y'
  JP NZ,LOAD_SAVE_MENU
NEW_FILE:
  CALL SET_TMP_EXT
  LD C,$16           ; create file
  LD DE,FCB_DRIVE
  CALL BDOS
  LD DE,ERR_DIRECTORY_FULL
  INC A
  JP Z,CPM_ERROR
  LD HL,ENTRY
  LD (FILE_PTR),HL
SET_FILE_EXT4:
  LD A,(FILE_RECORDS)
  DEC A
  JR Z,SET_FILE_EXT8
  LD (FILE_RECORDS),A
  LD DE,(FILE_PTR)
  LD C,$1A           ; Set DMA address
  CALL BDOS
  LD C,$15           ; write next record
  LD DE,FCB_DRIVE
  CALL BDOS
  LD DE,ERR_DISK_FULL
  OR A
  JP NZ,CPM_ERROR
  LD HL,(FILE_PTR)
  LD DE,$0080
  ADD HL,DE
  LD (FILE_PTR),HL
  JR SET_FILE_EXT4

RESUME_MENU:
  CALL RESET_DMA
  LD DE,RESUME_MSG
  CALL PROMPT
  CALL CHARTR
  CP 'Y'
  JP NZ,WBOOT
  JP RESUME_GAME

SET_FILE_EXT6:
  LD HL,WBOOT+$5D
  LD A,' '
  CP (HL)
  JP Z,LOAD_SAVE_MENU
  CALL SET_FILENAME
  RET

CPM_ERROR:
  CALL PROMPT
  JP RESUME_MENU

SET_FILE_EXT8:
  CALL RESET_DMA
  LD DE,FCB_DRIVE
  LD C,$10           ; Close file
  CALL BDOS
  LD DE,ERR_WRITE_PROTECT
  INC A
  JP Z,CPM_ERROR
  CALL SET_SGN_EXT
  XOR A
  LD (L2FD2),A
  LD C,$13           ; delete file (F_DELETE)
  LD DE,FCB_DRIVE
  CALL BDOS
  LD HL,FCB_DRIVE
  LD DE,FCB2_DRIVE
  LD BC,$0010
  LDIR
  CALL SET_TMP_EXT
  LD C,$17           ; Rename file (F_RENAME)
  LD DE,FCB_DRIVE
  CALL BDOS
IF !CPM14
  LD DE,RW_ERROR
  INC A
  JP Z,CPM_ERROR
ENDIF
  JP RESUME_MENU

IF ORIGINAL
; this code portion is just an artifact copy of LOAD_GAME
; ???
  SET 1,L                      ;this code portion is just an artifact copy of LOAD_GAME
  OR D                         ;
  LD L,$0E                     ;
  LD A,(BC)                    ;
  LD DE,FILE_NAME              ;
  CALL BDOS                    ;
  LD A,(FILE_NAME+1)           ;
  AND A                        ;
  JP Z,SET_FILE_EXT0           ;
  LD C,A                       ;this code portion is just an artifact copy of LOAD_GAME
  XOR A                        ;
  LD B,A                       ;
  LD HL,FILE_NAME+2            ;
  LD DE,FCB_FNAME              ;
GET_FOO_19:                    ;
  LD A,(HL)                    ;
  CP '.'                       ;
  JR Z,GET_FOO_20              ;
  LD (DE),A                    ;this code portion is just an artifact copy of LOAD_GAME
  XOR A                        ;
  INC HL                       ;
  INC DE                       ;
  DEC BC                       ;
  CP C                         ;
  JR NZ,GET_FOO_19             ;
  JP SET_FILE_EXT1             ;
                               ;this code portion is just an artifact copy of LOAD_GAME
  CALL SET_FILE_EXT6           ;
GET_FOO_20:                    ;
  CALL SET_SGN_EXT             ;
  RET                          ;
                               ;
  LD DE,SAVE_MSG               ;
  CALL GET_FILENAME            ;
  LD C,$11                     ;this code portion is just an artifact copy of LOAD_GAME
  LD DE,FCB_DRIVE              ;
  CALL BDOS                    ;
  CP $FF                       ;
  JR Z,GET_FOO_21              ;
  LD DE,OVERWRITE_FILE_MSG     ;
  CALL PROMPT                  ;
  CALL CHARTR                  ;
  CP 'Y'                       ;this code portion is just an artifact copy of LOAD_GAME
  JP NZ,LOAD_SAVE_MENU         ;
GET_FOO_21:                    ;
  CALL SET_TMP_EXT             ;
  LD C,$16                     ;
  LD DE,FCB_DRIVE              ;
  CALL BDOS                    ;
  LD DE,ERR_DIRECTORY_FULL     ;
  INC A                        ;this code portion is just an artifact copy of LOAD_GAME
  JP Z,INITBD_1                ;
ENDIF

ENDIF

; Data block at 13059
OPENINGS:

  DEFB $0D

; Data block at 13061
L3305:
  DEFW L3313

; Data block at 13063
L3307:
  DEFB $0B

; Data block at 13064
L3308:
  DEFW L33ED

; Data block at 13066
L330A:
  DEFB $09

; Data block at 13067
L330B:
  DEFW L347A

; Data block at 13069
L330D:
  DEFB $02

; Data block at 13070
L330E:
  DEFW L34EA

; Data block at 13072
L3310:
  DEFB $0F

; Data block at 13073
L3311:
  DEFW L3523

; Data block at 13075
L3313:
  DEFB $3F,$09

; Data block at 13077
L3315:
  DEFW L3329

; Data block at 13079
L3317:
  DEFB $05

; Data block at 13080
L3318:
  DEFW L336D

; Data block at 13082
L331A:
  DEFB $08

; Data block at 13083
L331B:
  DEFW L33A0

; Data block at 13085
L331D:
  DEFB $04

; Data block at 13086
L331E:
  DEFW L33B9

; Data block at 13088
L3320:
  DEFB $06

; Data block at 13089
L3321:
  DEFW L33DE

; Data block at 13091
L3323:
  DEFB $12

; Data block at 13092
L3324:
  DEFW L33E7

; Data block at 13094
L3326:
  DEFB $07

; Data block at 13095
L3327:
  DEFW L33EA

; Data block at 13097
L3329:
  DEFB $08

; Data block at 13098
L332A:
  DEFB $0D

; Data block at 13099
L332B:
  DEFW L3330

; Data block at 13101
L332D:
  DEFB $18

; Data block at 13102
L332E:
  DEFW L3366

; Data block at 13104
L3330:
  DEFB $78,$0F

; Data block at 13106
L3332:
  DEFW L333D

; Data block at 13108
L3334:
  DEFB $1A

; Data block at 13109
L3335:
  DEFW L3359

; Data block at 13111
L3337:
  DEFB $06,$FF,$09,$FF,$07,$FF

; Data block at 13117
L333D:
  DEFB $18,$07

; Data block at 13119
L333F:
  DEFW L3347

; Data block at 13121
L3341:
  DEFB $06

; Data block at 13122
L3342:
  DEFW L3351

; Data block at 13124
L3344:
  DEFB $01

; Data block at 13125
L3345:
  DEFW L3356

; Data block at 13127
L3347:
  DEFB $38,$05
  
  ; This does ont exist on VIC-20,
  ; It is probably a patch to extend the dictionary
  DEFW L353E
  
  DEFB $0B,$FF,$18,$FF,$1B,$FF

; Data block at 13137
L3351:
  DEFB $02,$19,$FF,$1C,$FF

; Data block at 13142
L3356:
  DEFB $00,$1C,$FF

; Data block at 13145
L3359:
  DEFB $06,$11

; Data block at 13147
L335B:
  DEFW L3361

; Data block at 13149
L335D:
  DEFB $01,$FF,$17,$FF

; Data block at 13153
L3361:
  DEFB $01,$01,$FF,$00,$FF

; Data block at 13158
L3366:
  DEFB $00,$00

; Data block at 13160
L3368:
  DEFW L336A

; Data block at 13162
L336A:
  DEFB $00,$0E,$FF

; Data block at 13165
L336D:
  DEFB $08,$0D

; Data block at 13167
L336F:
  DEFW L3374

; Data block at 13169
L3371:
  DEFB $01

; Data block at 13170
L3372:
  DEFW L339D

; Data block at 13172
L3374:
  DEFB $19,$05

; Data block at 13174
L3376:
  DEFW L3381

; Data block at 13176
L3378:
  DEFB $10

; Data block at 13177
L3379:
  DEFW L3388

; Data block at 13179
L337B:
  DEFB $07

; Data block at 13180
L337C:
  DEFW L338F

; Data block at 13182
L337E:
  DEFB $14

; Data block at 13183
L337F:
  DEFW L3396

; Data block at 13185
L3381:
  DEFB $00,$11

; Data block at 13187
L3383:
  DEFW L3385

; Data block at 13189
L3385:
  DEFB $00,$00,$FF

; Data block at 13192
L3388:
  DEFB $00,$11

; Data block at 13194
L338A:
  DEFW L338C

; Data block at 13196
L338C:
  DEFB $00,$00,$FF

; Data block at 13199
L338F:
  DEFB $00,$11

; Data block at 13201
L3391:
  DEFW L3393

; Data block at 13203
L3393:
  DEFB $00,$00,$FF

; Data block at 13206
L3396:
  DEFB $00,$1B

; Data block at 13208
L3398:
  DEFW L339A

; Data block at 13210
L339A:
  DEFB $00,$02,$FF

; Data block at 13213
L339D:
  DEFB $00,$10,$FF

; Data block at 13216
L33A0:
  DEFB $00,$16

; Data block at 13218
L33A2:
  DEFW L33A4

; Data block at 13220
L33A4:
  DEFB $00,$08

; Data block at 13222
L33A6:
  DEFW L33A8

; Data block at 13224
L33A8:
  DEFB $02,$01

; Data block at 13226
L33AA:
  DEFW L33AF

; Data block at 13228
L33AC:
  DEFB $02

; Data block at 13229
L33AD:
  DEFW L33B4

; Data block at 13231
L33AF:
  DEFB $02,$1D,$FF,$1F,$FF

; Data block at 13236
L33B4:
  DEFB $02,$1F,$FF,$07,$FF

; Data block at 13241
L33B9:
  DEFB $08,$16

; Data block at 13243
L33BB:
  DEFW L33C0

; Data block at 13245
L33BD:
  DEFB $0D

; Data block at 13246
L33BE:
  DEFW L33D7

; Data block at 13248
L33C0:
  DEFB $00,$06

; Data block at 13250
L33C2:
  DEFW L33C4

; Data block at 13252
L33C4:
  DEFB $0A,$01

; Data block at 13254
L33C6:
  DEFW L33CE

; Data block at 13256
L33C8:
  DEFB $24

; Data block at 13257
L33C9:
  DEFW L33D1

; Data block at 13259
L33CB:
  DEFB $25

; Data block at 13260
L33CC:
  DEFW L33D4

; Data block at 13262
L33CE:
  DEFB $00,$00,$FF

; Data block at 13265
L33D1:
  DEFB $00,$00,$FF

; Data block at 13268
L33D4:
  DEFB $00,$10,$FF

; Data block at 13271
L33D7:
  DEFB $00,$06

; Data block at 13273
L33D9:
  DEFW L33DB

; Data block at 13275
L33DB:
  DEFB $00,$01,$FF

; Data block at 13278
L33DE:
  DEFB $00,$16

; Data block at 13280
L33E0:
  DEFW L33E2

; Data block at 13282
L33E2:
  DEFB $02,$19,$FF,$0B,$FF

; Data block at 13287
L33E7:
  DEFB $00,$1D,$FF

; Data block at 13290
L33EA:
  DEFB $00,$1D,$FF

; Data block at 13293
L33ED:
  DEFB $09,$12

; Data block at 13295
L33EF:
  DEFW L33F7

; Data block at 13297
L33F1:
  DEFB $07

; Data block at 13298
L33F2:
  DEFW L342A

; Data block at 13300
L33F4:
  DEFB $0B

; Data block at 13301
L33F5:
  DEFW L3462

; Data block at 13303
L33F7:
  DEFB $00,$12

; Data block at 13305
L33F9:
  DEFW L33FB

; Data block at 13307
L33FB:
  DEFB $01,$0D

; Data block at 13309
L33FD:
  DEFW L3402

; Data block at 13311
L33FF:
  DEFB $0F

; Data block at 13312
L3400:
  DEFW L3415

; Data block at 13314
L3402:
  DEFB $02,$01

; Data block at 13316
L3404:
  DEFW L3409

; Data block at 13318
L3406:
  DEFB $0E

; Data block at 13319
L3407:
  DEFW L3410

; Here it gets different than VIC-20
L3409:
  DEFB $01,$19

; Data block at 13323
L340B:
  DEFW L35D7

; Data block at 13325
L340D:
  DEFB $0D

; Data block at 13326
L340E:
  DEFW L364E

; Here it is again equivalent to VIC-20
L3410:
  DEFB $08,$08,$FF,$19,$FF

; Data block at 13333
L3415:
  DEFB $18,$01

; Data block at 13335
L3417:
  DEFW L341F

; Data block at 13337
L3419:
  DEFB $18

; Data block at 13338
L341A:
  DEFW L3424

; Data block at 13340
L341C:
  DEFB $0E

; Data block at 13341
L341D:
  DEFW L3427

; Data block at 13343
L341F:
  DEFB $02,$14,$FF,$0D,$FF

; Data block at 13348
L3424:
  DEFB $00,$0D,$FF

; Data block at 13351
L3427:
  DEFB $00,$14,$FF

; Here it gets different than VIC-20
L342A:
  DEFB $0C,$12

; Data block at 13356
L342C:
  DEFW L3434

; Data block at 13358
L342E:
  DEFB $0B

; Data block at 13359
L342F:
  DEFW L36A7

; Data block at 13361
L3431:
  DEFB $13

; Data block at 13362
L3432:
  DEFW L3710

; Here it is again equivalent to VIC-20
L3434:
  DEFB $0A,$07

; Data block at 13366
L3436:
  DEFW L343E

; Data block at 13368
L3438:
  DEFB $05

; Data block at 13369
L3439:
  DEFW L344E

; Data block at 13371
L343B:
  DEFB $00

; Data block at 13372
L343C:
  DEFW L345B

; Data block at 13374
L343E:
  DEFB $08,$01

; Data block at 13376
L3440:
  DEFW L3445

; Data block at 13378
L3442:
  DEFB $18

; Data block at 13379
L3443:
  DEFW L344B

; Data block at 13381
L3445:
  DEFB $02,$1F

; Slightly different than VIC-20
L3447:
  DEFW L364E

; Data block at 13385
L3449:
  DEFB $07,$FF

; This section doesn't exist on VIC-20
L344B:
  DEFB $00,$1F,$FF

; Data block at 13390
L344E:
  DEFB $08,$0E

; Data block at 13392
L3450:
  DEFW L3455

; Data block at 13394
L3452:
  DEFB $1C

; Data block at 13395
L3453:
  DEFW L3458

; Here it is again equivalent to VIC-20
L3455:
  DEFB $00,$1B,$FF

; Data block at 13400
L3458:
  DEFB $00,$00,$FF

; Data block at 13403
L345B:
  DEFB $00,$0E

; Data block at 13405
L345D:
  DEFW L345F

; Data block at 13407
L345F:
  DEFB $00,$1C,$FF

; This section is different than VIC-20
L3462:
  DEFB $06,$12

; Data block at 13412
L3464:
  DEFW L346C

; Data block at 13414
L3466:
  DEFB $14

; Data block at 13415
L3467:
  DEFW L3473

; Data block at 13417
L3469:
  DEFB $17

; Data block at 13418
L346A:
  DEFW L3755

; Data block at 13420
L346C:
  DEFB $01,$12

; Data block at 13422
L346E:
  DEFW L377A

; Data block at 13424
L3470:
  DEFB $09

; Data block at 13425
L3471:
  DEFW L3782

; Here it is again equivalent to VIC-20
L3473:
  DEFB $00,$00

; Data block at 13429
L3475:
  DEFW L3477

; Data block at 13431
L3477:
  DEFB $00,$01,$FF

; Data block at 13434
L347A:
  DEFB $1B,$05

; Data block at 13436
L347C:
  DEFW L348A

; Data block at 13438
L347E:
  DEFB $09

; Data block at 13439
L347F:
  DEFW L34A1

; Data block at 13441
L3481:
  DEFB $08

; Data block at 13442
L3482:
  DEFW L34CA

; Data block at 13444
L3484:
  DEFB $04

; Data block at 13445
L3485:
  DEFW L34DE

; Slightly different than VIC-20
L3487:
  DEFB $12

; Data block at 13448
L3488:
  DEFW L34E5

; Data block at 13450
L348A:
  DEFB $01,$01

; Data block at 13452
L348C:
  DEFW L3491

; Data block at 13454
L348E:
  DEFB $05

; Data block at 13455
L348F:
  DEFW L3531

; Data block at 13457
L3491:
  DEFB $02,$0F

; Data block at 13459
L3493:
  DEFW L3498

; Data block at 13461
L3495:
  DEFB $13

; Data block at 13462
L3496:
  DEFW L352E

; Data block at 13464
L3498:
  DEFB $08,$10

; Data block at 13466
L349A:
  DEFW L349E

; Data block at 13468
L349C:
  DEFB $04,$FF

; Data block at 13470
L349E:
  DEFB $00,$0F,$FF

; Data block at 13473
L34A1:
  DEFB $00,$01

; Data block at 13475
L34A3:
  DEFW L34A5

; Data block at 13477
L34A5:
  DEFB $03,$10

; Data block at 13479
L34A7:
  DEFW L34AF

; Data block at 13481
L34A9:
  DEFB $1B

; Data block at 13482
L34AA:
  DEFW L34B8

; Data block at 13484
L34AC:
  DEFB $07

; Data block at 13485
L34AD:
  DEFW L34C7

; Data block at 13487
L34AF:
  DEFB $01,$10

; Data block at 13489
L34B1:
  DEFW L34B5

; Data block at 13491
L34B3:
  DEFB $04,$FF

; Data block at 13493
L34B5:
  DEFB $00,$0E,$FF

; Data block at 13496
L34B8:
  DEFB $01,$10

; Data block at 13498
L34BA:
  DEFW L34BF

; Data block at 13500
L34BC:
  DEFB $04

; Data block at 13501
L34BD:
  DEFW L34C4

; Data block at 13503
L34BF:
  DEFB $01,$0E,$FF,$0A,$FF

; Data block at 13508
L34C4:
  DEFB $00,$13,$FF

; Data block at 13511
L34C7:
  DEFB $00,$10,$FF

; Slightly different than VIC-20
L34CA:
  DEFB $01,$05

; Data block at 13516
L34CC:
  DEFW L34D1

; Not on VIC-20
L34CE:
  DEFB $0C

; Data block at 13519
L34CF:
  DEFW L36A3

; Here it is again equivalent to VIC-20
L34D1:
  DEFB $00,$1B

; Data block at 13523
L34D3:
  DEFW L34D5

; Data block at 13525
L34D5:
  DEFB $02,$0E

; Data block at 13527
L34D7:
  DEFW L34DB

; Data block at 13529
L34D9:
  DEFB $0D,$FF

; Data block at 13531
L34DB:
  DEFB $00,$0D,$FF

; Data block at 13534
L34DE:
  DEFB $00,$05

; Data block at 13536
L34E0:
  DEFW L34E2

; Data block at 13538
L34E2:
  DEFB $00,$13,$FF

; Data block at 13541
L34E5:
  DEFB $01,$05,$FF,$01,$FF

; Data block at 13546
L34EA:
  DEFB $0A,$07

; Data block at 13548
L34EC:
  DEFW L34F4

; Data block at 13550
L34EE:
  DEFB $05

; Data block at 13551
L34EF:
  DEFW L3514

; Data block at 13553
L34F1:
  DEFB $12

; Data block at 13554
L34F2:
  DEFW L351F

; Data block at 13556
L34F4:
  DEFB $02,$0D

; Data block at 13558
L34F6:
  DEFW L34FB

; Data block at 13560
L34F8:
  DEFB $08

; Data block at 13561
L34F9:
  DEFW L3511

; This section is different than VIC-20
L34FB:
  DEFB $02,$1A

; Data block at 13565
L34FD:
  DEFW L350D

; Data block at 13567
L34FF:
  DEFB $06

; Data block at 13568
L3500:
  DEFW L3502

; Data block at 13570
L3502:
  DEFB $00,$02

; Data block at 13572
L3504:
  DEFW L3506

; Data block at 13574
L3506:
  DEFB $01,$10

; Data block at 13576
L3508:
  DEFW L3940

; Data block at 13578
L350A:
  DEFB $1C

; Data block at 13579
L350B:
  DEFW L398E

; Data block at 13581
L350D:
  DEFB $00,$02

; Data block at 13583
L350F:
  DEFW L3835

; Here it is again equivalent to VIC-20
L3511:
  DEFB $00,$00,$FF

; Data block at 13588
L3514:
  DEFB $00,$0D

; Data block at 13590
L3516:
  DEFW L3518

; Data block at 13592
L3518:
  DEFB $00,$10

; Data block at 13594
L351A:
  DEFW L351C

; Data block at 13596
L351C:
  DEFB $00,$02,$FF

; Slightly different than VIC-20
L351F:
  DEFB $00,$00

; Data block at 13601
L3521:
  DEFW L39A5

; Here it is again equivalent to VIC-20
L3523:
  DEFB $00,$07

; Data block at 13605
L3525:
  DEFW L3527

; Data block at 13607
L3527:
  DEFB $00,$03

; Data block at 13609
L3529:
  DEFW L352B

; Data block at 13611
L352B:
  DEFB $00,$1A,$FF

; Data block at 13614
L352E:
  DEFB $00,$10,$FF

; Data block at 13617
L3531:
  DEFB $00,$13

; Data block at 13619
L3533:
  DEFW L3535

; Data block at 13621
L3535:
  DEFB $02,$0B

; Data block at 13623
L3537:
  DEFW L353B

; Data block at 13625
L3539:
  DEFB $0E,$FF

; Data block at 13627
L353B:
  DEFB $00,$00

; Openings table on VIC-20 ends here
L353D:
  DEFB $FF

; Data block at 13630
L353E:
  DEFB $00,$1B

; Data block at 13632
L3540:
  DEFW L3542

; Data block at 13634
L3542:
  DEFB $00,$1D

; Data block at 13636
L3544:
  DEFW L3546

; Data block at 13638
L3546:
  DEFB $00,$00

; Data block at 13640
L3548:
  DEFW L354A

; Data block at 13642
L354A:
  DEFB $04,$18

; Data block at 13644
L354C:
  DEFW L3551

; Data block at 13646
L354E:
  DEFB $0D

; Data block at 13647
L354F:
  DEFW L3564

; Data block at 13649
L3551:
  DEFB $00,$04

; Data block at 13651
L3553:
  DEFW L3555

; Data block at 13653
L3555:
  DEFB $00,$0D

; Data block at 13655
L3557:
  DEFW L3559

; Data block at 13657
L3559:
  DEFB $00,$18

; Data block at 13659
L355B:
  DEFW L355D

; Data block at 13661
L355D:
  DEFB $02,$00

; Data block at 13663
L355F:
  DEFW L3570

; Data block at 13665
L3561:
  DEFB $0D

; Data block at 13666
L3562:
  DEFW L35AE

; Data block at 13668
L3564:
  DEFB $00,$17

; Data block at 13670
L3566:
  DEFW L3568

; Data block at 13672
L3568:
  DEFB $00,$18

; Data block at 13674
L356A:
  DEFW L356C

; Data block at 13676
L356C:
  DEFB $00,$04

; Data block at 13678
L356E:
  DEFW L355D

; Data block at 13680
L3570:
  DEFB $00,$0A

; Data block at 13682
L3572:
  DEFW L3574

; Data block at 13684
L3574:
  DEFB $00,$0C

; Data block at 13686
L3576:
  DEFW L3578

; Data block at 13688
L3578:
  DEFB $00,$0E

; Data block at 13690
L357A:
  DEFW L357C

; Data block at 13692
L357C:
  DEFB $00,$03

; Data block at 13694
L357E:
  DEFW L3580

; Data block at 13696
L3580:
  DEFB $00,$14

; Data block at 13698
L3582:
  DEFW L3584

; Data block at 13700
L3584:
  DEFB $00,$0D

; Data block at 13702
L3586:
  DEFW L3588

; Data block at 13704
L3588:
  DEFB $00,$10

; Data block at 13706
L358A:
  DEFW L358C

; Data block at 13708
L358C:
  DEFB $00,$1B

; Data block at 13710
L358E:
  DEFW L3590

; Data block at 13712
L3590:
  DEFB $00,$01

; Data block at 13714
L3592:
  DEFW L3594

; Data block at 13716
L3594:
  DEFB $02,$1E

; Data block at 13718
L3596:
  DEFW L359B

; Data block at 13720
L3598:
  DEFB $23

; Data block at 13721
L3599:
  DEFW L35A6

; Data block at 13723
L359B:
  DEFB $00,$13

; Data block at 13725
L359D:
  DEFW L359F

; Data block at 13727
L359F:
  DEFB $00,$26

; Data block at 13729
L35A1:
  DEFW L35A3

; Data block at 13731
L35A3:
  DEFB $00,$0C

; Data block at 13733
L35A5:
  DEFB $FF

; Data block at 13734
L35A6:
  DEFB $00,$13

; Data block at 13736
L35A8:
  DEFW L35AA

; Data block at 13738
L35AA:
  DEFB $00,$1E

; Data block at 13740
L35AC:
  DEFW L35A3

; Data block at 13742
L35AE:
  DEFB $00,$0A

; Data block at 13744
L35B0:
  DEFW L35B2

; Data block at 13746
L35B2:
  DEFB $04,$00

; Data block at 13748
L35B4:
  DEFW L3578

; Data block at 13750
L35B6:
  DEFB $04

; Data block at 13751
L35B7:
  DEFW L35B9

; Data block at 13753
L35B9:
  DEFB $00,$15

; Data block at 13755
L35BB:
  DEFW L35BD

; Data block at 13757
L35BD:
  DEFB $00,$0E

; Data block at 13759
L35BF:
  DEFW L35C1

; Data block at 13761
L35C1:
  DEFB $00,$0F

; Data block at 13763
L35C3:
  DEFW L35C5

; Data block at 13765
L35C5:
  DEFB $00,$1D

; Data block at 13767
L35C7:
  DEFW L35C9

; Data block at 13769
L35C9:
  DEFB $00,$01

; Data block at 13771
L35CB:
  DEFW L35CD

; Data block at 13773
L35CD:
  DEFB $01,$23,$FF,$00

; Data block at 13777
L35D1:
  DEFW L35D3

; Data block at 13779
L35D3:
  DEFB $00,$14

; Data block at 13781
L35D5:
  DEFW L3594

; Data block at 13783
L35D7:
  DEFB $02,$11

; Data block at 13785
L35D9:
  DEFW L35DE

; Data block at 13787
L35DB:
  DEFB $0C

; Data block at 13788
L35DC:
  DEFW L360F

; Data block at 13790
L35DE:
  DEFB $02,$00

; Data block at 13792
L35E0:
  DEFW L35E5

; Data block at 13794
L35E2:
  DEFB $13

; Data block at 13795
L35E3:
  DEFW L3623

; Data block at 13797
L35E5:
  DEFB $01,$10

; Data block at 13799
L35E7:
  DEFW L35EC

; Data block at 13801
L35E9:
  DEFB $0E

; Data block at 13802
L35EA:
  DEFW L35FC

; Data block at 13804
L35EC:
  DEFB $00,$13

; Data block at 13806
L35EE:
  DEFW L35F0

; Data block at 13808
L35F0:
  DEFB $00,$0B

; Data block at 13810
L35F2:
  DEFW L35F4

; Data block at 13812
L35F4:
  DEFB $00,$12

; Data block at 13814
L35F6:
  DEFW L35F8

; Data block at 13816
L35F8:
  DEFB $00,$00

; Data block at 13818
L35FA:
  DEFW L3649

; Data block at 13820
L35FC:
  DEFB $02,$13

; Data block at 13822
L35FE:
  DEFW L3603

; Data block at 13824
L3600:
  DEFB $11

; Data block at 13825
L3601:
  DEFW L3607

; Data block at 13827
L3603:
  DEFB $00,$0E

; Data block at 13829
L3605:
  DEFW L35F4

; Data block at 13831
L3607:
  DEFB $00,$0E

; Data block at 13833
L3609:
  DEFW L360B

; Data block at 13835
L360B:
  DEFB $00,$0F

; Data block at 13837
L360D:
  DEFW L35F8

; Data block at 13839
L360F:
  DEFB $00,$13

; Data block at 13841
L3611:
  DEFW L3613

; Data block at 13843
L3613:
  DEFB $00,$10

; Data block at 13845
L3615:
  DEFW L3617

; Data block at 13847
L3617:
  DEFB $00,$10

; Data block at 13849
L3619:
  DEFW L361B

; Data block at 13851
L361B:
  DEFB $00,$0B

; Data block at 13853
L361D:
  DEFW L361F

; Data block at 13855
L361F:
  DEFB $00,$00

; Data block at 13857
L3621:
  DEFW L35F8

; Data block at 13859
L3623:
  DEFB $02,$0E

; Data block at 13861
L3625:
  DEFW L362A

; Data block at 13863
L3627:
  DEFB $10

; Data block at 13864
L3628:
  DEFW L3641

; Data block at 13866
L362A:
  DEFB $01,$00

; Data block at 13868
L362C:
  DEFW L3631

; Data block at 13870
L362E:
  DEFB $10

; Data block at 13871
L362F:
  DEFW L3639

; Data block at 13873
L3631:
  DEFB $00,$0E

; Data block at 13875
L3633:
  DEFW L3635

; Data block at 13877
L3635:
  DEFB $00,$0F

; Data block at 13879
L3637:
  DEFW L35F8

; Data block at 13881
L3639:
  DEFB $00,$0E

; Data block at 13883
L363B:
  DEFW L363D

; Data block at 13885
L363D:
  DEFB $00,$00

; Data block at 13887
L363F:
  DEFW L35F8

; Data block at 13889
L3641:
  DEFB $00,$00

; Data block at 13891
L3643:
  DEFW L3645

; Data block at 13893
L3645:
  DEFB $00,$0B

; Data block at 13895
L3647:
  DEFW L3635

; Data block at 13897
L3649:
  DEFB $02,$15,$FF,$04,$FF

; Data block at 13902
L364E:
  DEFB $03,$04

; Data block at 13904
L3650:
  DEFW L3658

; Data block at 13906
L3652:
  DEFB $0C

; Data block at 13907
L3653:
  DEFW L3679

; Data block at 13909
L3655:
  DEFB $1F

; Data block at 13910
L3656:
  DEFW L368C

; Data block at 13912
L3658:
  DEFB $00,$19

; Data block at 13914
L365A:
  DEFW L365C

; Data block at 13916
L365C:
  DEFB $00,$10

; Data block at 13918
L365E:
  DEFW L3660

; Data block at 13920
L3660:
  DEFB $00,$00

; Data block at 13922
L3662:
  DEFW L3664

; Data block at 13924
L3664:
  DEFB $00,$12

; Data block at 13926
L3666:
  DEFW L3668

; Data block at 13928
L3668:
  DEFB $01,$15

; Data block at 13930
L366A:
  DEFW L366F

; Data block at 13932
L366C:
  DEFB $12

; Data block at 13933
L366D:
  DEFW L3672

; Data block at 13935
L366F:
  DEFB $00,$01,$FF

; Data block at 13938
L3672:
  DEFB $00,$27

; Data block at 13940
L3674:
  DEFW L3676

; Data block at 13942
L3676:
  DEFB $00,$0B,$FF

; Data block at 13945
L3679:
  DEFB $00,$0C

; Data block at 13947
L367B:
  DEFW L367D

; Data block at 13949
L367D:
  DEFB $00,$21

; Data block at 13951
L367F:
  DEFW L3681

; Data block at 13953
L3681:
  DEFB $00,$05

; Data block at 13955
L3683:
  DEFW L3685

; Data block at 13957
L3685:
  DEFB $00,$11

; Data block at 13959
L3687:
  DEFW L3689

; Data block at 13961
L3689:
  DEFB $00,$17,$FF

; Data block at 13964
L368C:
  DEFB $00,$00

; Data block at 13966
L368E:
  DEFW L3690

; Data block at 13968
L3690:
  DEFB $00,$04

; Data block at 13970
L3692:
  DEFW L3694

; Data block at 13972
L3694:
  DEFB $00,$09

; Data block at 13974
L3696:
  DEFW L3698

; Data block at 13976
L3698:
  DEFB $00,$02

; Data block at 13978
L369A:
  DEFW L369C

; Data block at 13980
L369C:
  DEFB $00,$1C

; Data block at 13982
L369E:
  DEFW L36A0

; Data block at 13984
L36A0:
  DEFB $00,$17,$FF

; Data block at 13987
L36A3:
  DEFB $00,$08

; Data block at 13989
L36A5:
  DEFW L343E

; Data block at 13991
L36A7:
  DEFB $00,$19

; Data block at 13993
L36A9:
  DEFW L36AB

; Data block at 13995
L36AB:
  DEFB $00,$12

; Data block at 13997
L36AD:
  DEFW L36AF

; Data block at 13999
L36AF:
  DEFB $00,$0A

; Data block at 14001
L36B1:
  DEFW L36B3

; Data block at 14003
L36B3:
  DEFB $00,$02

; Data block at 14005
L36B5:
  DEFW L36B7

; Data block at 14007
L36B7:
  DEFB $01,$13

; Data block at 14009
L36B9:
  DEFW L36BE

; Data block at 14010
L36BA:
  DEFB $12

; Data block at 14012
L36BC:
  DEFW L36D5

; Data block at 14014
L36BE:
  DEFB $00,$0D

; Data block at 14016
L36C0:
  DEFW L36C2

; Data block at 14018
L36C2:
  DEFB $00,$10

; Data block at 14020
L36C4:
  DEFW L36C6

; Data block at 14022
L36C6:
  DEFB $00,$07

; Data block at 14024
L36C8:
  DEFW L36CA

; Data block at 14026
L36CA:
  DEFB $00,$21

; Data block at 14028
L36CC:
  DEFW L36CE

; Data block at 14030
L36CE:
  DEFB $00,$00

; Data block at 14032
L36D0:
  DEFW L36D2

; Data block at 14034
L36D2:
  DEFB $00,$00,$FF

; Data block at 14037
L36D5:
  DEFB $00,$0D

; Data block at 14039
L36D7:
  DEFW L36D9

; Data block at 14041
L36D9:
  DEFB $03,$0F

; Data block at 14043
L36DB:
  DEFW L36E3

; Data block at 14045
L36DD:
  DEFB $14

; Data block at 14046
L36DE:
  DEFW L36F2

; Data block at 14048
L36E0:
  DEFB $0D

; Data block at 14049
L36E1:
  DEFW L3701

; Data block at 14051
L36E3:
  DEFB $00,$07

; Data block at 14053
L36E5:
  DEFW L36E7

; Data block at 14055
L36E7:
  DEFB $00,$16

; Data block at 14057
L36E9:
  DEFW L36EB

; Data block at 14059
L36EB:
  DEFB $00,$00

; Data block at 14061
L36ED:
  DEFW L36EF

; Data block at 14063
L36EF:
  DEFB $00,$00,$FF

; Data block at 14066
L36F2:
  DEFB $00,$07

; Data block at 14068
L36F4:
  DEFW L36F6

; Data block at 14070
L36F6:
  DEFB $00,$19

; Data block at 14072
L36F8:
  DEFW L36FA

; Data block at 14074
L36FA:
  DEFB $00,$00

; Data block at 14076
L36FC:
  DEFW L36FE

; Data block at 14078
L36FE:
  DEFB $00,$1E,$FF

; Data block at 14081
L3701:
  DEFB $00,$07

; Data block at 14083
L3703:
  DEFW L3705

; Data block at 14085
L3705:
  DEFB $00,$19

; Data block at 14087
L3707:
  DEFW L3709

; Data block at 14089
L3709:
  DEFB $00,$00

; Data block at 14091
L370B:
  DEFW L370D

; Data block at 14093
L370D:
  DEFB $00,$00,$FF

; Data block at 14096
L3710:
  DEFB $00,$19

; Data block at 14098
L3712:
  DEFW L3714

; Data block at 14100
L3714:
  DEFB $00,$0D

; Data block at 14102
L3716:
  DEFW L3718

; Data block at 14104
L3718:
  DEFB $00,$0A

; Data block at 14106
L371A:
  DEFW L371C

; Data block at 14108
L371C:
  DEFB $00,$13

; Data block at 14110
L371E:
  DEFW L3720

; Data block at 14112
L3720:
  DEFB $01,$13

; Data block at 14114
L3722:
  DEFW L3727

; Data block at 14116
L3724:
  DEFB $12

; Data block at 14117
L3725:
  DEFW L373E

; Data block at 14119
L3727:
  DEFB $00,$16

; Data block at 14121
L3729:
  DEFW L372B

; Data block at 14123
L372B:
  DEFB $00,$1A

; Data block at 14125
L372D:
  DEFW L372F

; Data block at 14127
L372F:
  DEFB $00,$0F

; Data block at 14129
L3731:
  DEFW L3733

; Data block at 14131
L3733:
  DEFB $00,$16

; Data block at 14133
L3735:
  DEFW L3737

; Data block at 14135
L3737:
  DEFB $00,$00

; Data block at 14137
L3739:
  DEFW L373B

; Data block at 14139
L373B:
  DEFB $00,$26,$FF

; Data block at 14142
L373E:
  DEFB $00,$16

; Data block at 14144
L3740:
  DEFW L3742

; Data block at 14146
L3742:
  DEFB $00,$0F

; Data block at 14148
L3744:
  DEFW L3746

; Data block at 14150
L3746:
  DEFB $00,$10

; Data block at 14152
L3748:
  DEFW L374A

; Data block at 14154
L374A:
  DEFB $00,$16

; Data block at 14156
L374C:
  DEFW L374E

; Data block at 14158
L374E:
  DEFB $00,$00

; Data block at 14160
L3750:
  DEFW L3752

; Data block at 14162
L3752:
  DEFB $00,$00,$FF

; Data block at 14165
L3755:
  DEFB $00,$09

; Data block at 14167
L3757:
  DEFW L3759

; Data block at 14169
L3759:
  DEFB $00,$0B

; Data block at 14171
L375B:
  DEFW L375D

; Data block at 14173
L375D:
  DEFB $00,$1B

; Data block at 14175
L375F:
  DEFW L3761

; Data block at 14177
L3761:
  DEFB $00,$0C

; Data block at 14179
L3763:
  DEFW L3765

; Data block at 14181
L3765:
  DEFB $00,$18

; Data block at 14183
L3767:
  DEFW L3769

; Data block at 14185
L3769:
  DEFB $00,$00

; Data block at 14187
L376B:
  DEFW L376D

; Data block at 14189
L376D:
  DEFB $00,$00

; Data block at 14191
L376F:
  DEFW L3771

; Data block at 14193
L3771:
  DEFB $00,$12

; Data block at 14195
L3773:
  DEFW L3775

; Data block at 14197
L3775:
  DEFB $01,$0E,$FF,$0D,$FF

; Data block at 14202
L377A:
  DEFB $00,$18

; Data block at 14204
L377C:
  DEFW L377E

; Data block at 14206
L377E:
  DEFB $00,$0E

; Data block at 14208
L3780:
  DEFW L378D

; Data block at 14210
L3782:
  DEFB $01,$1B

; Data block at 14212
L3784:
  DEFW L3789

; Data block at 14214
L3786:
  DEFB $0E,$1A,$38

; Data block at 14217
L3789:
  DEFB $00,$1B

; Data block at 14219
L378B:
  DEFW L378D

; Data block at 14221
L378D:
  DEFB $00,$0E

; Data block at 14223
L378F:
  DEFW L3791

; Data block at 14225
L3791:
  DEFB $01,$18

; Data block at 14227
L3793:
  DEFW L3798

; Data block at 14229
L3795:
  DEFB $1B

; Data block at 14230
L3796:
  DEFW L37D5

; Data block at 14232
L3798:
  DEFB $00,$01

; Data block at 14234
L379A:
  DEFW L379C

; Data block at 14236
L379C:
  DEFB $00,$00

; Data block at 14238
L379E:
  DEFW L37A0

; Data block at 14240
L37A0:
  DEFB $03,$13

; Data block at 14242
L37A2:
  DEFW L37AA

; Data block at 14244
L37A4:
  DEFB $07

; Data block at 14245
L37A5:
  DEFW L37BF

; Data block at 14247
L37A7:
  DEFB $27

; Data block at 14248
L37A8:
  DEFW L37CA

; Data block at 14250
L37AA:
  DEFB $01,$0E

; Data block at 14252
L37AC:
  DEFW L37B1

; Data block at 14254
L37AE:
  DEFB $0D

; Data block at 14255
L37AF:
  DEFW L37B8

; Data block at 14257
L37B1:
  DEFB $00,$0E

; Data block at 14259
L37B3:
  DEFW L37B5

; Data block at 14261
L37B5:
  DEFB $00,$0C,$FF

; Data block at 14264
L37B8:
  DEFB $00,$0E

; Data block at 14266
L37BA:
  DEFW L37BC

; Data block at 14268
L37BC:
  DEFB $00,$0D,$FF

; Data block at 14271
L37BF:
  DEFB $00,$18

; Data block at 14273
L37C1:
  DEFW L37C3

; Data block at 14275
L37C3:
  DEFB $00,$29

; Data block at 14277
L37C5:
  DEFW L37C7

; Data block at 14279
L37C7:
  DEFB $00,$04,$FF

; Data block at 14282
L37CA:
  DEFB $00,$02

; Data block at 14284
L37CC:
  DEFW L37CE

; Data block at 14286
L37CE:
  DEFB $00,$15

; Data block at 14288
L37D0:
  DEFW L37D2

; Data block at 14290
L37D2:
  DEFB $00,$0D,$FF

; Data block at 14293
L37D5:
  DEFB $01,$03

; Data block at 14295
L37D7:
  DEFW L37DC

; Data block at 14297
L37D9:
  DEFB $02

; Data block at 14298
L37DA:
  DEFW L380F

; Data block at 14300
L37DC:
  DEFB $01,$1E

; Data block at 14302
L37DE:
  DEFW L37E3

; Data block at 14304
L37E0:
  DEFB $08

; Data block at 14305
L37E1:
  DEFW L3800

; Data block at 14307
L37E3:
  DEFB $01,$07

; Data block at 14309
L37E5:
  DEFW L37EA

; Data block at 14311
L37E7:
  DEFB $08

; Data block at 14312
L37E8:
  DEFW L37F5

; Data block at 14314
L37EA:
  DEFB $00,$00

; Data block at 14316
L37EC:
  DEFW L37EE

; Data block at 14318
L37EE:
  DEFB $00,$00

; Data block at 14320
L37F0:
  DEFW L37F2

; Data block at 14322
L37F2:
  DEFB $00,$05,$FF

; Data block at 14325
L37F5:
  DEFB $00,$00

; Data block at 14327
L37F7:
  DEFW L37F9

; Data block at 14329
L37F9:
  DEFB $00,$00

; Data block at 14331
L37FB:
  DEFW L37FD

; Data block at 14333
L37FD:
  DEFB $00,$05,$FF

; Data block at 14336
L3800:
  DEFB $00,$06

; Data block at 14338
L3802:
  DEFW L3804

; Data block at 14340
L3804:
  DEFB $00,$00

; Data block at 14342
L3806:
  DEFW L3808

; Data block at 14344
L3808:
  DEFB $00,$01

; Data block at 14346
L380A:
  DEFW L380C

; Data block at 14348
L380C:
  DEFB $00,$14,$FF

; Data block at 14351
L380F:
  DEFB $00,$00

; Data block at 14353
L3811:
  DEFW L3813

; Data block at 14355
L3813:
  DEFB $00,$05

; Data block at 14357
L3815:
  DEFW L3817

; Data block at 14359
L3817:
  DEFB $00,$15,$FF,$00,$09

; Data block at 14364
L381C:
  DEFW L381E

; Data block at 14366
L381E:
  DEFB $00,$13

; Data block at 14368
L3820:
  DEFW L3822

; Data block at 14370
L3822:
  DEFB $00,$07

; Data block at 14372
L3824:
  DEFW L3826

; Data block at 14374
L3826:
  DEFB $00,$0D

; Data block at 14376
L3828:
  DEFW L382A

; Data block at 14378
L382A:
  DEFB $00,$20

; Data block at 14380
L382C:
  DEFW L382E

; Data block at 14382
L382E:
  DEFB $00,$00

; Data block at 14384
L3830:
  DEFW L3832

; Data block at 14386
L3832:
  DEFB $00,$1E,$FF

; Data block at 14389
L3835:
  DEFB $07,$0A

; Data block at 14391
L3837:
  DEFW L3842

; Data block at 14393
L3839:
  DEFB $17

; Data block at 14394
L383A:
  DEFW L38C3

; Data block at 14396
L383C:
  DEFB $0E

; Data block at 14397
L383D:
  DEFW L38FA

; Data block at 14399
L383F:
  DEFB $0C

; Data block at 14400
L3840:
  DEFW L392B

; Data block at 14402
L3842:
  DEFB $03,$00

; Data block at 14404
L3844:
  DEFW L384C

; Data block at 14406
L3846:
  DEFB $0C

; Data block at 14407
L3847:
  DEFW L3887

; Data block at 14409
L3849:
  DEFB $08

; Data block at 14410
L384A:
  DEFW L38B0

; Data block at 14412
L384C:
  DEFB $01,$15

; Data block at 14414
L384E:
  DEFW L3853

; Data block at 14416
L3850:
  DEFB $16

; Data block at 14417
L3851:
  DEFW L3880

; Data block at 14419
L3853:
  DEFB $01,$07

; Data block at 14421
L3855:
  DEFW L385A

; Data block at 14423
L3857:
  DEFB $0B

; Data block at 14424
L3858:
  DEFW L386D

; Data block at 14426
L385A:
  DEFB $00,$14

; Data block at 14428
L385C:
  DEFW L385E

; Data block at 14430
L385E:
  DEFB $00,$02

; Data block at 14432
L3860:
  DEFW L3862

; Data block at 14434
L3862:
  DEFB $00,$14

; Data block at 14436
L3864:
  DEFW L3866

; Data block at 14438
L3866:
  DEFB $00,$10

; Data block at 14440
L3868:
  DEFW L386A

; Data block at 14442
L386A:
  DEFB $00,$21,$FF

; Data block at 14445
L386D:
  DEFB $00,$13

; Data block at 14447
L386F:
  DEFW L3871

; Data block at 14449
L3871:
  DEFB $00,$02

; Data block at 14451
L3873:
  DEFW L3875

; Data block at 14453
L3875:
  DEFB $00,$20

; Data block at 14455
L3877:
  DEFW L3879

; Data block at 14457
L3879:
  DEFB $00,$06

; Data block at 14459
L387B:
  DEFW L387D

; Data block at 14461
L387D:
  DEFB $00,$00,$FF

; Data block at 14464
L3880:
  DEFB $00,$07

; Data block at 14466
L3882:
  DEFW L3884

; Data block at 14468
L3884:
  DEFB $00,$18,$FF

; Data block at 14471
L3887:
  DEFB $01,$0D

; Data block at 14473
L3889:
  DEFW L388E

; Data block at 14475
L388B:
  DEFB $16

; Data block at 14476
L388C:
  DEFW L38A1

; Data block at 14478
L388E:
  DEFB $00,$10

; Data block at 14480
L3890:
  DEFW L3892

; Data block at 14482
L3892:
  DEFB $00,$1D

; Data block at 14484
L3894:
  DEFW L3896

; Data block at 14486
L3896:
  DEFB $00,$04

; Data block at 14488
L3898:
  DEFW L389A

; Data block at 14490
L389A:
  DEFB $00,$00

; Data block at 14492
L389C:
  DEFW L389E

; Data block at 14494
L389E:
  DEFB $00,$00,$FF

; Data block at 14497
L38A1:
  DEFB $00,$00

; Data block at 14499
L38A3:
  DEFW L38A5

; Data block at 14501
L38A5:
  DEFB $00,$18

; Data block at 14503
L38A7:
  DEFW L38A9

; Data block at 14505
L38A9:
  DEFB $00,$02

; Data block at 14507
L38AB:
  DEFW L38AD

; Data block at 14509
L38AD:
  DEFB $00,$12,$FF

; Data block at 14512
L38B0:
  DEFB $00,$15

; Data block at 14514
L38B2:
  DEFW L38B4

; Data block at 14516
L38B4:
  DEFB $00,$03

; Data block at 14518
L38B6:
  DEFW L38B8

; Data block at 14520
L38B8:
  DEFB $00,$14

; Data block at 14522
L38BA:
  DEFW L38BC

; Data block at 14524
L38BC:
  DEFB $00,$00

; Data block at 14526
L38BE:
  DEFW L38C0

; Data block at 14528
L38C0:
  DEFB $00,$21,$FF

; Data block at 14531
L38C3:
  DEFB $01,$08

; Data block at 14533
L38C5:
  DEFW L38CA

; Data block at 14535
L38C7:
  DEFB $00

; Data block at 14536
L38C8:
  DEFW L38D5

; Data block at 14538
L38CA:
  DEFB $00,$15

; Data block at 14540
L38CC:
  DEFW L38CE

; Data block at 14542
L38CE:
  DEFB $00,$03

; Data block at 14544
L38D0:
  DEFW L38D2

; Data block at 14546
L38D2:
  DEFB $00,$21,$FF

; Data block at 14549
L38D5:
  DEFB $01,$15

; Data block at 14551
L38D7:
  DEFW L38DC

; Data block at 14553
L38D9:
  DEFB $19

; Data block at 14554
L38DA:
  DEFW L38EB

; Data block at 14556
L38DC:
  DEFB $00,$0B

; Data block at 14558
L38DE:
  DEFW L38E0

; Data block at 14560
L38E0:
  DEFB $00,$1F

; Data block at 14562
L38E2:
  DEFW L38E4

; Data block at 14564
L38E4:
  DEFB $00,$02

; Data block at 14566
L38E6:
  DEFW L38E8

; Data block at 14568
L38E8:
  DEFB $00,$1A,$FF

; Data block at 14571
L38EB:
  DEFB $00,$0B

; Data block at 14573
L38ED:
  DEFW L38EF

; Data block at 14575
L38EF:
  DEFB $00,$17

; Data block at 14577
L38F1:
  DEFW L38F3

; Data block at 14579
L38F3:
  DEFB $00,$02

; Data block at 14581
L38F5:
  DEFW L38F7

; Data block at 14583
L38F7:
  DEFB $00,$20,$FF

; Data block at 14586
L38FA:
  DEFB $00,$00

; Data block at 14588
L38FC:
  DEFW L38FE

; Data block at 14590
L38FE:
  DEFB $00,$1C

; Data block at 14592
L3900:
  DEFW L3902

; Data block at 14594
L3902:
  DEFB $00,$0B

; Data block at 14596
L3904:
  DEFW L3906

; Data block at 14598
L3906:
  DEFB $00,$00

; Data block at 14600
L3908:
  DEFW L390A

; Data block at 14602
L390A:
  DEFB $00,$02

; Data block at 14604
L390C:
  DEFW L390E

; Data block at 14606
L390E:
  DEFB $01,$15

; Data block at 14608
L3910:
  DEFW L3915

; Data block at 14610
L3912:
  DEFB $1E

; Data block at 14611
L3913:
  DEFW L3924

; Data block at 14613
L3915:
  DEFB $03,$09

; Data block at 14615
L3917:
  DEFW L391E

; Data block at 14617
L3919:
  DEFB $0F,$FF,$08

; Data block at 14620
L391C:
  DEFW L3921

; Data block at 14622
L391E:
  DEFB $00,$01,$FF

; Data block at 14625
L3921:
  DEFB $00,$11,$FF

; Data block at 14628
L3924:
  DEFB $00,$0F

; Data block at 14630
L3926:
  DEFW L3928

; Data block at 14632
L3928:
  DEFB $00,$0E,$FF

; Data block at 14635
L392B:
  DEFB $00,$00

; Data block at 14637
L392D:
  DEFW L392F

; Data block at 14639
L392F:
  DEFB $00,$1A

; Data block at 14641
L3931:
  DEFW L3933

; Data block at 14643
L3933:
  DEFB $01,$07

; Data block at 14645
L3935:
  DEFW L393A

; Data block at 14647
L3937:
  DEFB $0A

; Data block at 14648
L3938:
  DEFW L393D

; Data block at 14650
L393A:
  DEFB $00,$00,$FF

; Data block at 14653
L393D:
  DEFB $00,$01,$FF

; Data block at 14656
L3940:
  DEFB $01,$00

; Data block at 14658
L3942:
  DEFW L3947

; Data block at 14660
L3944:
  DEFB $0D

; Data block at 14661
L3945:
  DEFW L3964

; Data block at 14663
L3947:
  DEFB $01,$0B

; Data block at 14665
L3949:
  DEFW L394D

; Data block at 14667
L394B:
  DEFB $0C,$FF

; Data block at 14669
L394D:
  DEFB $00,$0B

; Data block at 14671
L394F:
  DEFW L3951

; Data block at 14673
L3951:
  DEFB $03,$22

; Data block at 14675
L3953:
  DEFW L3959

; Data block at 14677
L3955:
  DEFB $0F,$FF,$21,$FF

; Data block at 14681
L3959:
  DEFB $00,$02

; Data block at 14683
L395B:
  DEFW L395D

; Data block at 14685
L395D:
  DEFB $00,$20

; Data block at 14687
L395F:
  DEFW L3961

; Data block at 14689
L3961:
  DEFB $00,$0F,$FF

; Data block at 14692
L3964:
  DEFB $01,$00

; Data block at 14694
L3966:
  DEFW L396B

; Data block at 14696
L3968:
  DEFB $0B

; Data block at 14697
L3969:
  DEFW L3982

; Data block at 14699
L396B:
  DEFB $00,$1D

; Data block at 14701
L396D:
  DEFW L396F

; Data block at 14703
L396F:
  DEFB $00,$09

; Data block at 14705
L3971:
  DEFW L3973

; Data block at 14707
L3973:
  DEFB $00,$00

; Data block at 14709
L3975:
  DEFW L3977

; Data block at 14711
L3977:
  DEFB $00,$20

; Data block at 14713
L3979:
  DEFW L397B

; Data block at 14715
L397B:
  DEFB $00,$13

; Data block at 14717
L397D:
  DEFW L397F

; Data block at 14719
L397F:
  DEFB $00,$27,$FF

; Data block at 14722
L3982:
  DEFB $00,$00

; Data block at 14724
L3984:
  DEFW L3986

; Data block at 14726
L3986:
  DEFB $00,$00

; Data block at 14728
L3988:
  DEFW L398A

; Data block at 14730
L398A:
  DEFB $00,$1C

; Data block at 14732
L398C:
  DEFW L3977

; Data block at 14734
L398E:
  DEFB $00,$0B

; Data block at 14736
L3990:
  DEFW L3992

; Data block at 14738
L3992:
  DEFB $00,$01

; Data block at 14740
L3994:
  DEFW L3996

; Data block at 14742
L3996:
  DEFB $00,$0D

; Data block at 14744
L3998:
  DEFW L399A

; Data block at 14746
L399A:
  DEFB $00,$12

; Data block at 14748
L399C:
  DEFW L399E

; Data block at 14750
L399E:
  DEFB $00,$00

; Data block at 14752
L39A0:
  DEFW L39A2

; Data block at 14754
L39A2:
  DEFB $00,$0F,$FF

; Data block at 14757
L39A5:
  DEFB $03

; Data block at 14758
L39A6:
  DEFW L350D

; Data block at 14760
L39A8:
  DEFB $0F

; Data block at 14761
L39A9:
  DEFW L39AE

; Data block at 14763
L39AB:
  DEFB $0A

; Data block at 14764
L39AC:
  DEFW L39C6

; Data block at 14766
L39AE:
  DEFB $00,$02

; Data block at 14768
L39B0:
  DEFW L39B2

; Data block at 14770
L39B2:
  DEFB $00,$14

; Data block at 14772
L39B4:
  DEFW L39B6

; Data block at 14774
L39B6:
  DEFB $00,$00

; Data block at 14776
L39B8:
  DEFW L39BA

; Data block at 14778
L39BA:
  DEFB $00,$00

; Data block at 14780
L39BC:
  DEFW L39BE

; Data block at 14782
L39BE:
  DEFB $00,$0B

; Data block at 14784
L39C0:
  DEFW L39C2

; Data block at 14786
L39C2:
  DEFB $00,$0D

; Data block at 14788
L39C4:
  DEFW L390A

; Data block at 14790
L39C6:
  DEFB $00,$02

; Data block at 14792
L39C8:
  DEFW L39CA

; Data block at 14794
L39CA:
  DEFB $00,$13

; Data block at 14796
L39CC:
  DEFW L39CE

; Data block at 14798
L39CE:
  DEFB $00,$00

; Data block at 14800
L39D0:
  DEFW L39D2

; Data block at 14802
L39D2:
  DEFB $00,$13

; Data block at 14804
L39D4:
  DEFW L39D6

; Data block at 14806
L39D6:
  DEFB $00,$0B

; Data block at 14808
L39D8:
  DEFW L39DA

; Data block at 14810
L39DA:
  DEFB $00,$11,$FF


; Data block at 14813
L39DD:
  DEFW L39DD

  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000

; Data block at 14833
L39F1:
  DEFW $0000

IF MYCONSOLE

extern fputc_cons_native

OUTPUT:
  PUSH IX
  PUSH IY
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF

    ld h,0
    ld l,a
    push hl
    call fputc_cons_native
    pop hl

;  LD SP,(SPSAVE)

  POP AF
  POP BC
  POP DE
  POP HL
  POP IY
  POP IX
  RET

extern getk

CHARTR:
  PUSH IX
  PUSH IY
  PUSH HL
  PUSH DE
  PUSH BC

    call getk
    ld a,l

;  LD SP,(SPSAVE)

  POP BC
  POP DE
  POP HL
  POP IY
  POP IX
  RET

ENDIF


IF ORIGINAL
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $0000
  DEFW $1A00
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFW $1A1A
  DEFB $1A
ENDIF
