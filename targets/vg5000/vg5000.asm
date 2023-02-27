
; z80asm -b -m -l vg5000.asm

; (Unfinished) Older version v1.0:  add -DV10


defc SCREEN            = $4000
defc SECOND_SCREEN_ROW = $4050
defc LAST_SCREEN_ROW   = $4780
defc SCREEN_END        = $47D0

defc INTHK             = $47D0
defc CALHK             = $47D3
defc SONHK             = $47D6
defc PLYHK             = $47D9
defc PRTHK             = $47DF
defc OUTHK             = $47E2
defc CRDHK             = $47E5
defc PINLIN            = $47E8
defc INPHK             = $47EB
defc NMIHK             = $47EE
defc NMIADDR           = $47EF
defc __LPEN            = $47F1
defc LPEN_ADDR         = $47F2
defc __DISK            = $47F4
defc DISK_ADDR         = $47F5
defc __MODEM           = $47F7
defc MDM_ADDR          = $47F8
defc INTDIV            = $47FA
defc INTACT            = $47FB
defc INTRAT            = $47FC
defc CURSOR            = $47FD
defc FKLOCK            = $47FE
defc CRCHAR            = $47FF
defc REPTIM            = $4800
defc REPENA            = $4801
defc ATTRCAR           = $4802
defc ATTBAK            = $4803
defc EXTENF            = $4804
defc CURPOS            = $4805
defc YCURSO            = $4806
defc PRELIN            = $4807
defc RETADR            = $480B
defc ENTSTT            = $480D
defc TMPSOUND          = $480E
defc FILETAB           = $4810
defc FILNAM            = $4811
defc FILNM2            = $4819
defc AUTORUN           = $4826
defc L482C             = $482C
defc LOWLIM            = $482E
defc WINWID            = $482F
defc RAMLOW            = $4830
defc __USR             = $4833
defc FDIVC             = $4836
defc DIV1              = $4837
defc DIV2              = $483B
defc DIV3              = $483F
defc DIV4              = $4842
defc SEED              = $4844
defc RNDX              = $4867
defc INPSUB            = $486B
defc INPORT            = $486C
defc L486D             = $486D
defc LPTPOS            = $486E
defc PRTFLG            = $486F
defc GETFLG            = $4870
defc PICFLG            = $4871
defc CASCOM            = $4872
defc RAWPRT            = $4873
defc PRTSTT            = $4874
defc PRTCOM            = $4875
defc PRTINT            = $4876
defc PRTXLT            = $4878
defc AUTFLG            = $4884
defc AUTLIN            = $4885
defc AUTINC            = $4887
defc LINLEN            = $488A
defc CLMLST            = $488B
defc CURLIN            = $488C
defc TXTTAB            = $488E
defc FRGFLG            = $4890
defc KBDTBL            = $4891
defc TMPSAV            = $4893
defc OCTSAV            = $4894
defc STKTOP            = $4895
defc BUFMIN            = $4897
defc KBUF              = $4898
defc ENDBUF            = $4919
defc DIMFLG            = $491A
defc VALTYP            = $491B
defc DORES             = $491C
defc CONTXT            = $491D
defc MEMSIZ            = $491F
defc TEMPPT            = $4921
defc TEMPST            = $4923
defc DSCTMP            = $499B
defc FRETOP            = $49C3
defc TEMP3             = $49C5
defc TEMP8             = $49C7
defc ENDFOR            = $49C9
defc DATLIN            = $49CB
defc SUBFLG            = $49CD
defc FLGINP            = $49CE
defc TEMP              = $49CF
defc PTRFLG            = $49D1
defc NXTOPR            = $49D2
defc OLDLIN            = $49D4
defc OLDTXT            = $49D6
defc VARTAB            = $49D8
defc ARYTAB            = $49DA
defc STREND            = $49DC
defc DATPTR            = $49DE
defc PRMNAM            = $49E0
defc PRMVAL            = $49E2
defc FACCU             = $49E6
defc FPEXP             = $49E9
defc RSTHK             = $47DC
defc SGNRES            = $49EA
defc FBUFFR            = $49EB
defc MULVAL            = $49F8
defc MULVAL2           = $49F9

defc SYSVAR_TOP        = $49Fb



; TOKEN table position = $209E, word list in classic encoding mode
;
; -- STATEMENTS --
;
defc TK_END      =  $80	; Token for 'END' (used also in 'APPEND')
defc TK_FOR      =  $81	; Token for 'FOR' (used also in 'OPEN' syntax)
defc TK_NEXT     =  $82	; Token for 'FOR' (used also for 'RESUME NEXT')
defc TK_DATA     =  $83	; Token for 'DATA'
defc TK_INPUT    =  $84	; Token for 'INPUT' (used for the "LINE INPUT" compound statement)
defc TK_DIM      =  $85
defc TK_READ     =  $86
defc TK_LET      =  $87
defc TK_GOTO     =  $88	; Token for 'GOTO'
defc TK_RUN      =  $89
defc TK_IF       =  $8A
defc TK_RESTORE  =  $8B	; 
defc TK_GOSUB    =  $8C	; Token for 'GOSUB'
defc TK_RETURN   =  $8D	; Token for 'RETURN'
defc TK_REM      =  $8E
defc TK_STOP     =  $8F	; Token for 'STOP'

defc TK_ON       =  $90	; Token for 'ON'
defc TK_LPRINT   =  $91	; Token for 'LPRINT'
defc TK_DEF      =  $92
defc TK_POKE     =  $93
defc TK_PRINT    =  $94
defc TK_CONT     =  $95
defc TK_LIST     =  $96
defc TK_LLIST    =  $97
defc TK_CLEAR    =  $98
defc TK_RENUM    =  $99
defc TK_AUTO     =  $9A
defc TK_LOAD     =  $9B
defc TK_SAVE     =  $9C
defc TK_CLOAD    =  $9D
defc TK_CSAVE    =  $9E
defc TK_CALL     =  $9F

defc TK_INIT     =  $A0
defc TK_SOUND    =  $A1


; [162] PLAY
; [163] TX
; [164] GR
; [165] SCREEN
; [166] DISPLAY
; [167] STORE
; [168] SCROLL
; [169] PAGE
; [170] DELIM
; [171] SETE
; [172] ET
; [173] EG
; [174] CURSOR
; [175] DISK
; [176] MODEM
; [177] NEW

; -- OPERATORS & extras --
;
;  178  TAB(
;  179  TO
;  180  FN
;  181  SPC(
;  182  THEN
;  183  NOT
;  184  STEP
;  185  +
;  186  -
;  187  *
;  188  /
;  189  ^
;  190  AND
;  191  OR
;  192  >
;  193  =
;  194  <

; JP table for functions = $2064
;
; -- FUNCTIONS --
;
; [195] SGN
; [196] INT
; [197] ABS
; [198] USR
; [199] FRE
; [200] LPOS
; [201] POS
; [202] SQR
; [203] RND
; [204] LOG
; [205] EXP
; [206] COS
; [207] SIN
; [208] TAN
; [209] ATN
; [210] PEEK
; [211] LEN
; [212] STR$
; [213] VAL
; [214] ASC
; [215] STICKX
; [216] STICKY
; [217] ACTION
; [218] KEY
; [219] LPEN
; [220] CHR$
; [221] LEFT$
; [222] RIGHT$
; [223] MID$


  ORG $0000

; Routine at 0
;
; Used by the routine at PROMPT.
L0000:
  JP _STARTUP

; Data block at 3
L0003:
  DEFB $CD

; Message at 4
VERSION:
IF V10
  DEFM "1.0"
ELSE
  DEFM "1.1"
ENDIF
  DEFB $00

; Check syntax, 1 byte follows to be compared
;
; Used by the routines at __SOUND, __SETE, L0E17, L0E2B, L0E61, L0F61,
; L0F73, L1BA2, L1C74, L1C80, L1CBE, L24BB, L2613, L2667, L2681, L271A, L2770,
; LOPDT2, FRMEQL, OPNPAR, L2910, EVAL_VARIABLE, L2A34, L2A36, CHEKFN, L2ABF, L2FAF,
; OCTCNS, L306D, L3075, L3182, L3873, L3878, L38AA, L38D3 and DOCHRT.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  INC HL
  EX (SP),HL
  JP NZ,SN_ERR

; (a.k.a. GETCHR, GETNEXT), pick next char from program
;
; Used by the routines at _ASCTFP, L1ADB, L1BA4, L1C82, L1CC0, PROMPT, FNDWRD,
; L24BD, _CHRGTB, ATOH2, GTLNLP, L2683, __LPRINT, NEXITM, SCNVAL, INPBIN,
; FDTLP, STKTHS, OPRND, EVAL_VARIABLE_1, __DEF, L2A38, FNDNUM, MAKINT, __CLEAR,
; L2FB1, __NEXT, OCTCNS, SCCPTR, __LIST, __VAL, DIMRET and GETVAR.
CHRGTB:
  INC HL
  LD A,(HL)
  CP $3A
  RET NC
  JP _CHRGTB_0
; This entry point is used by the routines at PRINT_FNAME_MSG, PROMPT, L271C,
; GTVLUS, T_EDIT, __LIST, PRS1, INLPNM, OUTDO_CRLF, SHIFT_STOP, L3DE1 and
; QINLIN.
CHRGTB_0:
  JP _OUTDO
  JP CHR_UPDATE

  DEFB $FF,$00

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at INIT, L1CC0, BAKSTK, ERROR, PROMPT, SRCHLP, FNDWRD,
; __FOR, GTLNLP, __GOTO, L2615, MOVUP, L2FB1, L3077, __LIST, TSTOPL, TESTR,
; GARBGE, ARYSTR, GSTRDE, FRETMS, GETVAR, FNDARY, BS_ERR, INLPNM and
; SHIFT_STOP.
DCOMPR:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; Message at 38
L0026:
IF V10
  DEFB $FF,$FF
ELSE
  DEFM "9"
  DEFB $FC
ENDIF

; Test sign in number  (see also SIGN)

	;PUT SIGN OF FAC IN A
	;ALTERS A ONLY
	;LEAVES FAC ALONE
	;NOTE: TO TAKE ADVANTAGE OF THE RST INSTRUCTIONS TO SAVE BYTES, FSIGN IS USUALLY DEFINED TO BE AN RST.
	;"FSIGN" IS EQUIVALENT TO "CALL SIGN"
	;THE FIRST FEW INSTRUCTIONS OF SIGN (THE ONES BEFORE SIGNC) ARE DONE IN THE 8 BYTES AT THE RST LOCATION.

;
; Used by the routines at __LOG, FMULT, FDIV, RESDIV, __SGN, __ABS, FCOMP,
; NUMASC, POWER, __RND, __SIN, __ATN, L24BD, DEPINT and L2683.
VSIGN:
  LD A,(FPEXP)            ; Get sign of FPREG
  OR A                                                       ;CHECK IF THE NUMBER IS ZERO
  JP NZ,SIGN              ; no, deal with the sign
  RET                     ; RETurn if number is zero         ;IT IS, A IS ZERO

_RST:
  JP RSTHK
_WARM_BT:
  JP WARM_BOOT

  DEFB $FF,$FF

; This entry point is used by the routines at CHRGTB and _DISPLAY.
_INT:
  CALL INTHK
  PUSH AF
  DEC (IX+$00)
  JP NZ,L00FD_8
  LD A,(IX+$02)
  LD (IX+$00),A
  BIT 0,(IX+$01)
  RES 0,(IX+$01)
  JP Z,L00FD_8
  PUSH BC
  PUSH DE
  PUSH HL

; Screen display
_DISPLAY:
  LD A,$28
  OUT ($8F),A
  LD A,$82
  OUT ($CF),A
  LD A,$29
  OUT ($8F),A
  JP DISPLAY
  
  DEFB $FF
  
NMI:
  JP NMIHK

; NMI handler at boot time
NMI_BOOT:
  LD A,$01
  LD (FRGFLG),A
  LD HL,KEYTAB
  LD (KBDTBL),HL
  RETN

; Data block at 118
L0076:
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF

; USR routine return
_PASSA:
  JP PASSA

; parameter acquisition on 2 bytes
__CONIS:
  JP CONIS

; parameter acquisition on 1 byte
__GETINT:
  JP GETINT

; acquisition parameter sign on 2 bytes
_GETNUM:
  JP GETNUM

; emitting a sound
_SOUND:
  JP SOUND

; play a melody
_MUSIC:
  JP MUSIC

; character display in X=L, Y=H
_PUTCHAR_XY:
  JP PUTCHAR_XY

; display character at cursor position
_PUTCHAR:
  JP PUTCHAR

; read character in X=L, Y=H
_GETCHAR_XY:
  JP GETCHAR_XY

; read character at cursor position
_GETCHAR:
  JP GETCHAR

; clear the screen and initialize colors
_CLR_SCR:
  JP CLR_SCR

; erase line and initialize colors
_CLR_LINE:
  JP CLR_LINE

; wait EF9345 ready
_VDP_READY:
  JP VDP_READY

; screen address calculation in X, Y
_SCRADR:
  JP SCRADR

; keyboard scanning
_KBDSCAN:
  JP KBDSCAN

; set video processor registers, sequence in (HL), first byte=length
_SET_VDP_REGS:
  JP SET_VDP_REGS

; scan joysticks (up/down)
_JOY_UP_DOWN:
  JP JOY_UP_DOWN

; scan joysticks (right/left)
_JOY_L_R:
  JP JOY_L_R

; scan joysticks (action1/action2)
_JOY_FIRE_F2:
  JP JOY_FIRE_F2

; scans SHIFT / STOP keys
_SHIFT_STOP:
  JP SHIFT_STOP

; Screen display (continued)
;
; Used by the routine at _DISPLAY.
DISPLAY:
  LD A,(IX+$03)
  AND $BF
  OUT ($CF),A
  LD C,$CF
  LD A,$26
  OUT ($8F),A
  XOR A
  OUT (C),A
  LD A,$27
  OUT ($8F),A
  XOR A
  OUT (C),A

; Send the first line of the screen
L00D3:
  LD HL,SCREEN
  LD E,$03
  LD B,$50
  LD A,$20
  OUT ($8F),A
  OUT (C),E
L00D3_0:
  LD A,$22
  OUT ($8F),A
  OUTI
  LD A,$29
  OUT ($8F),A
  OUTI
  JR NZ,L00D3_0
  LD A,$26
  OUT ($8F),A
  LD A,$08
  OUT (C),A
  LD A,$27
  OUT ($8F),A
  XOR A
  OUT (C),A

; Send the following lines
L00FD:
  LD D,$18
L00FD_0:
  LD B,$78
  LD A,$20
  OUT ($8F),A
L00FD_1:
  IN A,($CF)
  OR A
  JP M,L00FD_1
  LD A,$20
  OUT ($8F),A
  OUT (C),E
L00FD_2:
  LD A,$20
  OUT ($8F),A
L00FD_3:
  IN A,($CF)
  OR A
  JP M,L00FD_3
  LD A,$22
  OUT ($8F),A
  OUTI
  LD A,$29
  OUT ($8F),A
  OUTI
  DJNZ L00FD_2
  LD A,$20
  OUT ($8F),A
L00FD_4:
  IN A,($CF)
  OR A
  JP M,L00FD_4
  LD A,$28
  OUT ($8F),A
  LD A,$B0
  OUT (C),A
  DEC D
  JR NZ,L00FD_0
  BIT 6,(IX+$03)
  JR Z,L00FD_7
  LD HL,(CURPOS)
  LD A,H
  OR A
  JR Z,L00FD_5
  ADD A,$07
  LD H,A
L00FD_5:
  LD C,$CF
  LD A,$26
  OUT ($8F),A
  OUT (C),H
  LD A,$27
  OUT ($8F),A
  OUT (C),L
  LD A,$28
  OUT ($8F),A
  LD A,$0A
  OUT (C),A
  LD A,$20
  OUT ($8F),A
L00FD_6:
  IN A,($CF)
  OR A
  JP M,L00FD_6
  LD A,$28
  OUT ($8F),A
  LD A,$82
  OUT ($CF),A
  LD A,$29
  OUT ($8F),A
  SET 6,(IX+$03)
  LD A,(IX+$03)
  OUT ($CF),A
L00FD_7:
  POP HL
  POP DE
  POP BC
; This entry point is used by the routine at VSIGN.
L00FD_8:
  INC (IX+$06)
  POP AF
  EI
  RET

; character display in X=L, Y=H
;
; Used by the routine at _PUTCHAR_XY.
PUTCHAR_XY:
  LD C,$CF
  LD A,$26
  OUT ($8F),A
  OUT (C),H
  LD A,$27
  OUT ($8F),A
  OUT (C),L

; display character at cursor position
;
; Used by the routine at _PUTCHAR.
PUTCHAR:
  LD BC,$03CF
  LD A,$20
  OUT ($8F),A
PUTCHAR_0:
  IN A,($CF)
  OR A
  JP M,PUTCHAR_0
  LD A,$22
  OUT ($8F),A
  OUT (C),D
  LD A,$20
  OUT ($8F),A
PUTCHAR_1:
  IN A,($CF)
  OR A
  JP M,PUTCHAR_1
  LD A,$21
  OUT ($8F),A
  OUT (C),E
  LD A,$28
  OUT ($8F),A
  OUT (C),B
  RET

; read character in X=L, Y=H
;
; Used by the routine at _GETCHAR_XY.
GETCHAR_XY:
  LD C,$CF
  LD A,$26
  OUT ($8F),A
  OUT (C),H
  LD A,$27
  OUT ($8F),A
  OUT (C),L

; read character at cursor position
;
; Used by the routine at _GETCHAR.
GETCHAR:
  LD BC,$0BCF
  LD A,$28
  OUT ($8F),A
  OUT (C),B
  LD A,$20
  OUT ($8F),A
GETCHAR_0:
  IN A,($CF)
  OR A
  JP M,GETCHAR_0
  LD A,$22
  OUT ($8F),A
  IN D,(C)
  LD A,$20
  OUT ($8F),A
GETCHAR_1:
  IN A,($CF)
  OR A
  JP M,GETCHAR_1
  LD A,$21
  OUT ($8F),A
  IN E,(C)
  RET
; This entry point is used by the routines at L0F75, CONSOLE_POUND and L33CD.
GETCHAR_2:
  OR (IX+$0A)
  LD HL,(CURPOS)
  PUSH HL
  PUSH AF
  CALL SCRADR
  POP AF
  LD (HL),A
  LD A,(IX+$08)
  INC HL
  LD (HL),A
  INC HL
  EX DE,HL
  LD HL,PICFLG
  RES 2,(HL)
  POP HL
  LD A,L
  CP $27
  JR C,GETCHAR_4
  LD L,$00
  INC H
  LD A,H
  CP $19
  JR C,GETCHAR_3
  DEC H
  LD A,(PICFLG)
  SET 6,A
  LD (PICFLG),A
  BIT 7,A
  JR NZ,GETCHAR_4
  PUSH HL
  CALL L33CD_33
  LD A,$18
  CALL CLR_LINE
  POP HL
  LD (IX+$00),$01
  LD DE,LAST_SCREEN_ROW
GETCHAR_3:
  LD A,(PICFLG)
  BIT 0,A
  JR Z,GETCHAR_4
  SET 2,A
  LD (PICFLG),A
  LD A,$84
  LD (DE),A
GETCHAR_4:
  INC L
  LD (CURPOS),HL
  RET

; clear the screen and initialize colors
;
; Used by the routines at _CLR_SCR, T_EDIT and CONSOLE_CLS.
CLR_SCR:
  XOR A
  CALL CLR_LINE
  LD HL,SCREEN
  LD DE,SECOND_SCREEN_ROW
  LD BC,$0780
  LDIR
  RET

; erase line and initialize colors
;
; Used by the routines at _CLR_LINE, GETCHAR, CLR_SCR and L33CD.
CLR_LINE:
  LD L,$00
  LD H,A
  CALL SCRADR
  LD (HL),$80
  LD A,(IX+$09)
  INC HL
  LD (HL),A
  LD C,(IX+$08)
  INC HL
  LD A,$20
  BIT 7,C
  JR Z,CLR_LINE_0
  XOR A
CLR_LINE_0:
  LD B,$27
CLR_LINE_1:
  LD (HL),A
  INC HL
  LD (HL),C
  INC HL
  DJNZ CLR_LINE_1
  RET

; wait EF9345 ready
;
; Used by the routines at _VDP_READY, SET_VDP_REGS, __SETE and CHR_UPDATE.
VDP_READY:
  LD A,$20
  OUT ($8F),A
VDP_READY_0:
  IN A,($CF)
  OR A
  JP M,VDP_READY_0
  RET

; screen address calculation in X, Y
;
; Used by the routines at _SCRADR, GETCHAR, CLR_LINE, T_EDIT and L33CD.
SCRADR:
  LD C,L
  LD L,H
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD D,H
  LD E,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  ADD HL,HL
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  LD BC,SCREEN
  ADD HL,BC
  RET

; keyboard scanning
;
; Used by the routines at _KBDSCAN, __KEY, __LIST, CONSOLE_CLS and SHIFT_STOP.
KBDSCAN:
  LD BC,$0787
KBDSCAN_0:
  IN A,(C)
  CPL
  OR A
  JR NZ,KBDSCAN_1
  DEC C
  DJNZ KBDSCAN_0
  IN A,(C)
  CPL
  AND $BB
KBDSCAN_1:
  JR Z,KBDSCAN_6
  LD B,$07
KBDSCAN_2:
  ADD A,A
  JR C,KBDSCAN_3
  DJNZ KBDSCAN_2
KBDSCAN_3:
  LD A,B
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,C
  SUB $80
  LD C,$80
  IN B,(C)
  LD DE,$0040
  LD HL,(KBDTBL)
  BIT 2,B
  JR NZ,KBDSCAN_4
  ADD HL,DE
  JR KBDSCAN_5
KBDSCAN_4:
  BIT 6,B
  JR NZ,KBDSCAN_5
  ADD HL,DE
  ADD HL,DE
KBDSCAN_5:
  LD E,A
  LD D,$00
  ADD HL,DE
  LD A,(HL)
KBDSCAN_6:
  CP (IX+$05)
  SCF
  JR Z,KBDSCAN_7
  LD (IX+$05),A
  CCF
KBDSCAN_7:
  RET

; set video processor registers, sequence in (HL), first byte=length
;
; Used by the routines at _SET_VDP_REGS and INIT.
SET_VDP_REGS:
  LD B,(HL)
  INC HL
SET_VDP_REGS_0:
  CALL VDP_READY
  LD C,$8F
  OUTI
  LD C,$CF
  OUTI
  JR NZ,SET_VDP_REGS_0
  RET

; ---  FP mathematics section ---




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

;
; Used by the routine at NUMASC.
FADDH:
  LD HL,FP_HALF           ;ENTRY TO ADD 1/2


; LOADFP/FADD
; Load FP at (HL) to BCDE
;
; This entry point is used by the routines at __RND, __COS and __NEXT.
FADDS:
  CALL LOADFP             ;GET ARGUMENT INTO THE REGISTERS
  JR FADD                 ;DO THE ADDITION


;SUBTRACTION	FAC:=ARG-FAC
;ENTRY IF POINTER TO ARG IS IN (HL)

; LOADFP/FSUB
FSUBS:
  CALL LOADFP             ; FPREG = -FPREG + number at HL

  DEFB $21    ; "LD HL,nn" to jump over the next word without executing it
  POP BC
  POP DE


; Subtract the single precision numbers in FAC1 and BCDE
; aka, SUBCDE Subtract BCDE from FP reg
;
; Used by the routines at __EXP and __SIN.
FSUB:
  CALL INVSGN             ;NEGATE SECOND ARGUMENT
                          ;FALL INTO FADD

; ADDITION	FAC:=ARG+FAC
; aka FPADD, Add BCDE to FP reg
; ALTERS A,B,C,D,E,H,L
;
; Used by the routines at FADDH, __LOG, MLSP10, _ASCTFP, SUMLP and __SIN.
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
  JP Z,OV_ERR             ; Number overflowed - Error
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
; This entry point is used by the routines at FLOATR and __INT.
CONPOS:
  CALL C,COMPL            ; Overflow - Make it positive     ;ENTRY FROM FLOATR, INT: NEGATE NUMBER IF IT
                                                            ; WAS NEGATIVE, FALL INTO NORMALIZE


;NORMALIZE C,D,E,B
;ALTERS A,B,C,D,E,H,L
;HERE WE SHIFT THE MANTISSA LEFT UNTIL THE MSB IS A ONE.
;EXCEPT IN 4K, THE IDEA IS TO SHIFT LEFT BY 8 AS MANY TIMES AS POSSIBLE.

; Normalise number, a.k.a. NORMAL
;
; This entry point is used by the routine at __RND.
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

; This entry point is used by the routines at RESDIV, _ASCTFP, __EXP and __VAL.
ZERO:
  XOR A                   ; Result is zero           ;ZERO A
; This entry point is used by the routine at POWER.
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
  JP OV_ERR               ; Overflow error                 ;OVERFLOW AND CONTINUE


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


; Routine at 1076
;
; Used by the routine at POWER.
__LOG:
  RST VSIGN               ;CHECK FOR A NEGATIVE OR ZERO ARGUMENT      ; Test sign of value
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


  DEFB $21    ; (useless?) "LD HL,nn" to jump over the next word without executing it

; Used by the routine at SUMSER.
FMULTT:
  POP BC
  POP DE                ;GET FIRST ARGUMENT OFF STACK, ENTRY FROM POLYX

; MULTIPLICATION, FAC:=ARG*FAC
;
; Used by the routines at __LOG, EXP, __EXP, SUMSER, SUMLP, __RND and __SIN.
FMULT:
  RST VSIGN               ; Test sign of FPREG               ;CHECK IF FAC IS ZERO
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
  LD L,$08                ; 8 bits to multiply by            ;SET UP A COUNT

; This entry point is used by the routine at NOMADD.
MUL8LP:
  RRA                     ; Shift LSB right                ;ROTATE BYTE RIGHT
  LD H,A                  ; Save LSB                       ;SAVE IT
  LD A,C                  ; Get MSB                        ;GET HO
  JR NC,NOMADD            ; Bit was zero - Don't add       ;DON'T ADD IN NUMBER IF BIT WAS ZERO
  PUSH HL                                                  ;SAVE COUNTERS
  LD HL,(MULVAL2)
  ADD HL,DE               ; Add NMSB and LSB               ;ADD THEM IN
  EX DE,HL
  POP HL                                                   ;GET COUNTERS BACK
  LD A,(MULVAL)
  ADC A,C

; Routine at 1202
;
; Used by the routine at MULT8.
NOMADD:
  RRA                     ; Shift MSB right                ;ROTATE RESULT RIGHT ONE
  LD C,A                  ; Re-save MSB
  LD A,D                  ; Get NMSB                       ;ROTATE NEXT BYTE
  RRA                     ; Shift NMSB right
  LD D,A                  ; Re-save NMSB
  LD A,E                  ; Get LSB                        ;ROTATE NEXT LOWER ORDER
  RRA                     ; Shift LSB right
  LD E,A                  ; Re-save LSB
  LD A,B                  ; Get VLSB                       ;ROTATE LO
  RRA                     ; Shift VLSB right
  LD B,A                  ; Re-save VLSB
  AND $10                 ;SEE IF WE ROTATED THRU ST
  JR Z,NOMADD_0           ;IF NOT DON'T WORRY
  LD A,B                  ;RE FETCH LO
  OR $20                  ;"OR" IN STICKY
  LD B,A                  ;BACK TO LO
NOMADD_0:
  DEC L                   ;ARE WE DONE?
  LD A,H                  ;GET NUMBER WE ARE MULTIPLYING BY
  JR NZ,MUL8LP            ;MULTIPLY AGAIN IF WE ARE NOT DONE



; This entry point is used by the routines at RESDIV, GETVAR and FNDARY.
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
;
; Used by the routines at _ASCTFP and NUMASC.
DIV10:
  CALL PUSHF              ;SAVE NUMBER
  LD BC,$8420             ;CONSTANT '10'
  LD DE,$0000
  CALL FPBCDE

; Divide FP by number on stack
;
; Used by the routine at __TAN.
DIV:
  POP BC                  ;GET NUMBER BACK IN REGISTERS
  POP DE                  ;FALL INTO DIVIDE AND WE ARE DONE

; DIVISION, FAC:=ARG/FAC
;
; Used by the routines at __LOG and __ATN.
FDIV:
  RST VSIGN               ; Test sign of FPREG                        ;CHECK FOR DIVISION BY ZERO
  JP Z,O_ERR              ; Error if division by zero                 ;DON'T ALLOW DIVIDE BY ZERO
  LD L,$FF                ; (-1) Flag subtract exponents              ;SUBTRACT THE TWO EXPONENTS, L IS A FLAG
  CALL ADDEXP             ; Subtract exponents                        ;FIX UP THE EXPONENTS AND THINGS
  INC (HL)                ; Add 2 to exponent to adjust..
  JP Z,OV_ERR
  INC (HL)
  JP Z,OV_ERR             ; .. (jp on errors)

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

  CALL FDIVC              ; Self Modifying Code portion, moved into RAM a startup

  SBC A,$00               ; Count for overflows                             ;SUBTRACT THE CARRY FROM IT
  CCF                                                                       ;SET CARRY TO CORESPOND TO NEXT QUOTIENT BIT
  JR NC,RESDIV            ; Restore divisor if borrow                       ;GET OLD NUMBER BACK IF WE SUBTRACTED TOO MUCH
  LD (DIV4),A             ; Re-save overflow count                          ;UPDATE HIGHEST ORDER
  POP AF                  ; Scrap divisor                                   ;THE SUBTRACTION WAS GOOD
  POP AF                                                                    ;GET PREVIOUS NUMBER OFF STACK
  SCF                     ; Set carry to Skip "POP BC" and "POP HL"         ;NEXT BIT IN QUOTIENT IS A ONE

  DEFB $D2                ; "JP NC,nn"                                      ;"JNC" AROUND NEXT 2 BYTES

; Routine at 1305
;
; Used by the routine at FDIV.
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
;DCXHRT:
  DEC HL                  ;POINT TO EXPONENT
  RET                     ;ALL DONE, LEAVE HO IN A

MLDVEX:
  RST VSIGN               ; Test sign of FPREG               ;ENTRY FROM EXP, PICK UNDERFLOW IF NEGATIVE
  CPL                     ; Invert sign                      ;PICK OVERFLOW IF POSITIVE
  POP HL                  ; Clean up stack                   ;DON'T SCREW UP STACK

DIV_OVTST2:
  OR A                    ; Test if new exponent zero        ;IS ERROR OVERFLOW OR UNDEFLOW?
OVTST3:
  POP HL                  ; Clear off return address         ;GET OLD RETURN ADDRESS OFF STACK
  JP P,ZERO               ; Result zero
  JP OV_ERR               ; Overflow error

; Multiply number in FPREG by 10
;
; Used by the routine at _ASCTFP.
MLSP10:
  CALL BCDEFP             ; Move FPREG to BCDE               ;GET NUMBER IN REGISTERS
  LD A,B                  ; Get exponent                     ;GET EXPONENT
  OR A                    ; Is it zero?                      ;RESULT IS ZERO IF ARG IS ZERO
  RET Z                   ; Yes - Result is zero             ;IT IS
  ADD A,$02               ; Multiply by 4                    ;MULTIPLY BY 4 BY ADDING 2 TO EXPONENT
  JP C,OV_ERR             ; Overflow - ?OV Error
  LD B,A                  ; Re-save exponent                 ;RESTORE EXPONENT
  CALL FADD               ; Add BCDE to FPREG (Times 5)      ;ADD IN ORIGINAL NUMBER TO GET 5 TIMES IT
  LD HL,FPEXP             ; Point to exponent                ;ADD 1 TO EXPONENT TO MULTIPLY NUMBER BY
  INC (HL)                ; Double number (Times 10)         ; 2 TO GET 10 TIMES ORIGINAL NUMBER
  RET NZ                  ; Ok - Return                      ;ALL DONE IF NO OVERFLOW
  JP OV_ERR               ; Overflow error


; Test sign of FPREG

	;PUT SIGN OF FAC IN A
	;ALTERS A ONLY
	;LEAVES FAC ALONE
	;NOTE: TO TAKE ADVANTAGE OF THE RST INSTRUCTIONS TO SAVE BYTES, FSIGN IS USUALLY DEFINED TO BE AN RST.
	;"FSIGN" IS EQUIVALENT TO "CALL SIGN"
	;THE FIRST FEW INSTRUCTIONS OF SIGN (THE ONES BEFORE SIGNC) ARE DONE IN THE 8 BYTES AT THE RST LOCATION.

;
; Used by the routine at VSIGN.
SIGN:
  LD A,(FACCU+2)          ; GET SIGN OF FAC

  DEFB $FE                ; CP 2Fh ..hides the "CPL" instruction       ;"CPI" AROUND NEXT BYTE

; Routine at 1438
FCOMPS:
  CPL                     ; Invert sign         ;ENTRY FROM FCOMP, COMPLEMENT SIGN

; Routine at 1439
ICOMPS:
  RLA                     ; Sign bit to carry   ;ENTRY FROM ICOMP, PUT SIGN BIT IN CARRY

; This entry point is used by the routine at CSLOOP.
SIGNS:
  SBC A,A                 ; Carry to all bits of A      ;A=0 IF CARRY WAS 0, A=377 IF CARRY WAS 1
  RET NZ                  ; Return -1 if negative       ;RETURN IF NUMBER WAS NEGATIVE
  INC A                   ; Bump to +1                  ;PUT ONE IN A IF NUMBER WAS POSITIVE
  RET                     ; Positive - Return +1        ;ALL DONE

; Routine at 1444
__SGN:
  RST VSIGN

; a.k.a. FLGREL, Float the signed integer in A (CY and A to FP, & normalise)
;
; Used by the routines at __LOG, _ASCTFP and FINREL_0.
FLOAT:                                                          ;SET EXPONENT CORRECTLY
  LD B,$88                ; 8 bit integer in exponent           ;ZERO D,E
  LD DE,$0000             ; Zero NMSB and LSB                   ;FALL INTO FLOATR

; a.k.a. RETINT
;
; Used by the routines at PRNTHL, ABPASS and OCTCNS.
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
; Routine at 1464
__ABS:
  RST VSIGN           ;GET THE SIGN OF THE FAC IN A
  RET P               ;IF IT IS POSITIVE, WE ARE DONE

; Invert number sign,  a.k.a.  NEG (for FP values)

	;NEGATE NUMBER IN THE FAC
	;ALTERS A,H,L
	;NOTE: THE NUMBER MUST BE PACKED

;
; Used by the routines at FSUB, _ASCTFP, NUMASC, POWER, __SIN, __ATN and MINUS.
INVSGN:
  LD HL,FACCU+2        ;GET POINTER TO SIGN
  LD A,(HL)            ;GET SIGN
  XOR $80              ;COMPLEMENT SIGN BIT
  LD (HL),A            ;SAVE IT
  RET                  ;ALL DONE


; a.k.a. STAKFP, Put FP value on stack

	;FLOATING POINT MOVEMENT ROUTINES
	;PUT FAC ON STACK
	;ALTERS D,E
;
; Used by the routines at FADD, __LOG, DIV10, _ASCTFP, __SQR, __EXP, SUMSER,
; POLY, __SIN, __TAN and STKTHS.
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
;
; Used by the routines at __SQR, POLY, __RND, EVAL_VARIABLE_1 and __NEXT.
MOVFM:
  CALL LOADFP             ; Number at HL to BCDE       ;GET NUMBER IN REGISTERS
                                                       ;FALL INTO MOVFR AND PUT IT IN FAC

; Move BCDE to FPREG
; a.k.a. MOVFR
;
	;MOVE REGISTERS (B,C,D,E) TO FAC
	;ALTERS D,E
;
; Used by the routines at FADD, __LOG, DIV10, NUMASC, GET_UNITY, __TAN and EVAL_VARIABLE.
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
; Used by the routines at __LOG, MLSP10, QINT, NUMASC, POWER, SUMSER, __RND and
; L24BD.
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
; Used by the routines at FADDH, FSUBS, MOVFM, SUMLP, __RND, __PLAY, __NEXT,
; STRCMP, PRS1 and GARBGE.
LOADFP:
  LD E,(HL)               ; Get LSB of number                 ;GET LO
  INC HL                                                      ;POINT TO MO
  LD D,(HL)               ; Get NMSB of number                ;GET MO, ENTRY FOR BILL
  INC HL                                                      ;POINT TO HO
  LD C,(HL)               ; Get MSB of number                 ;GET HO
  INC HL                                                      ;POINT TO EXPONENT
  LD B,(HL)               ; Get exponent of number            ;GET EXPONENT
; This entry point is used by the routine at NUMASC.
INCHL:
  INC HL
  RET

; Copy number in FPREG to HL ptr

	;MOVE NUMBER FROM FAC TO MEMORY [(HL)]
	;ALTERS A,B,D,E,H,L
	;a.k.a. MOVMF
; Used by the routines at __RND, __LET_5, INPBIN, L2A38 and __NEXT.
FPTHL:
  LD DE,FACCU             ; Point to FPREG                    ;GET POINTER TO FAC
                                                              ;FALL INTO MOVE
	;MOVE NUMBER FROM (DE) TO (HL)
	;ALTERS A,B,D,E,H,L
	;EXITS WITH (DE):=(DE)+4, (HL):=(HL)+4

; Copy number value from DE to HL
;
; Used by the routines at __LET_5 and TSTOPL.
VMOVE:
  LD B,$04                ; 4 bytes to move    ;SET COUNTER

; Copy B bytes from DE to HL
MOVE1:
  LD A,(DE)               ; Get source            ;GET WORD, ENTRY FROM VMOVMF
  LD (HL),A               ; Save destination      ;PUT IT WHERE IT BELONGS
  INC DE                  ; Next source           ;INCREMENT POINTERS TO NEXT WORD
  INC HL                  ; Next destination
  DJNZ MOVE1              ; Count bytes, Loop if more
  RET


;UNPACK THE FAC AND THE REGISTERS
;ALTERS A,C,H,L
;WHEN THE NUMBER IN THE FAC IS UNACKED, THE ASSUMED ONE IN THE
;MANTISSA IS RESTORED, AND THE COMPLEMENT OF THE SIGN IS PLACED IN FAC+1

; This entry point is used by the routines at FADD, RESDIV and QINT.
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
; Used by the routines at NUMASC, POWER, __SIN, CONIS, FINREL_0 and __NEXT.
FCOMP:
  LD A,B                  ; Get exponent of number
  OR A                    ;CHECK IF ARG IS ZERO
  JP Z,VSIGN              ; Zero - Test sign of FPREG
  LD HL,FCOMPS            ; Return relation routine           ;WE JUMP TO FCOMPS WHEN WE ARE DONE
  PUSH HL                 ; Save for return                   ;PUT THE ADDRESS ON THE STACK
  RST VSIGN               ; Test sign of FPREG                ;CHECK IF FAC IS ZERO
  LD A,C                  ; Get MSB of number                 ;IF IT IS, RESULT IS MINUS THE SIGN OF ARG
  RET Z                   ; FPREG zero - Number's MSB         ;IT IS
  LD HL,FACCU+2           ; MSB of FPREG                      ;POINT TO SIGN OF FAC
  XOR (HL)                ; Combine signs                     ;SEE IF THE SIGNS ARE THE SAME
  LD A,C                  ; Get MSB of number                 ;IF THEY ARE DIFFERENT, RESULT IS SIGN OF ARG
  RET M                   ; Exit if signs different           ;THEY ARE DIFFERENT
  CALL CMPFP              ; Compare FP numbers                ;CHECK THE REST OF THE NUMBER
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


; Floating Point to Integer
; a.k.a. FPINT
;
	;QUICK GREATEST INTEGER FUNCTION
	;LEAVES INT(FAC) IN C,D,E (SIGNED)
	;ASSUMES FAC .LT. 2^23 = 8388608
	;ASSUMES THE EXPONENT OF FAC IS IN A
;
; Used by the routines at __INT, NUMASC and CONIS.
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

;; This entry point is used by the routine at LISPRT.
;DCXBRT:
  DEC BC
  RET


; 'INT' BASIC function
;
	;GREATEST INTEGER FUNCTION
	;ALTERS A,B,C,D,E,H,L
;
; a.k.a. VINT
; Used by the routines at POWER, __EXP and __SIN.
; Routine at 1632
__INT:
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


; Multiply DE by BC
; a.k.a. UMULT
	;INTEGER MULTIPLY FOR MULTIPLY DIMENSIONED ARRAYS
	; (DE):=(BC)*(DE)
	;OVERFLOW CAUSES A BS ERROR
	;ALTERS A,B,C,D,E
;
; Used by the routine at CREARY
MLDEBC:
  LD HL,$0000            ; Clear partial product             ;ZERO PRODUCT REGISTERS
  LD A,B                 ; Test multiplier                   ;CHECK IF (BC) IS ZERO
  OR C                                                       ;IF SO, JUST RETURN, (HL) IS ALREADY ZERO
  RET Z                  ; Return zero if zero               ;THIS IS DONE FOR SPEED
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
  RET

; ASCII to FP number (also '&' prefixes)
;
; Used by the routines at INPBIN, OPRND and __VAL.
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
_ASCTFP_0:
  CALL ZERO
  LD B,A
  LD D,A
  LD E,A
  CPL
  LD C,A

_ASCTFP_1:                                                  ;HERE TO CHECK FOR A DIGIT, A DECIMAL POINT, "E" OR "D"
  RST CHRGTB              ; Set result to zero              ;GET THE NEXT CHARACTER OF THE NUMBER
  JR C,ADDIG              ; Digit - Add to number           ;WE HAVE A DIGIT
  CP '.'                                                    ;CHECK FOR A DECIMAL POINT
  JR Z,DPOINT             ; "." - Flag point                ;WE HAVE ONE, I GUESS
  CP 'e'                                                    ;LOWER CASE "E"
  JR Z,EXPONENTIAL        
  CP 'E'                  ;CHECK FOR A SINGLE PRECISION EXPONENT
  JR NZ,FINE              ;WE DON'T HAVE ONE, THE NUMBER IS FINISHED

EXPONENTIAL:
  RST CHRGTB              ;GET THE FIRST CHARACTER OF THE EXPONENT
  CALL SGNEXP             ;EAT SIGN OF EXPONENT  ( test '+', '-'..)

	;HERE TO GET THE NEXT DIGIT OF THE EXPONENT
; This entry point is used by the routine at MULTEN.
FINEC:
  RST CHRGTB              ;GET THE NEXT CHARATER
  JR C,FINEDG             ;PACK THE NEXT DIGIT INTO THE EXPONENT
  INC D                   ;IT WAS NOT A DIGIT, PUT THE CORRECT SIGN ON
  JR NZ,FINE              ; THE EXPONENT, IT IS POSITIVE
  XOR A                   ;THE EXPONENT IS NEGATIVE
  SUB E                   ;NEGATE IT
  LD E,A                  ;SAVE IT AGAIN

  INC C                   ;SET THE FLAG

	;HERE TO CHECK IF WE HAVE SEEN 2 DECIMAL POINTS AND SET THE DECIMAL POINT FLAG
; a.k.a. FINDP
DPOINT:
  INC C                   ;SET THE FLAG
  JR Z,_ASCTFP_1          ;CONTINUE LOOKING FOR DIGITS
  
	;HERE TO FINISH UP THE NUMBER
FINE:
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD A,E                  ;FIND OUT HOW MANY TIMES WE HAVE TO MULTIPLY
  SUB B                   ; OR DIVIDE BY TEN

_ASCTFP_4:
  CALL P,_ASCTFP_6
  JP P,_ASCTFP_5
  PUSH AF
  CALL DIV10
  POP AF
  INC A
_ASCTFP_5:
  JR NZ,_ASCTFP_4
  POP DE
  POP AF
  CALL Z,INVSGN
  EX DE,HL
  RET
_ASCTFP_6:
  RET Z

; This entry point is used by the routine at NUMASC.
; Multiply FP value by ten
;
MULTEN:
  PUSH AF
  CALL MLSP10
  POP AF
  DEC A
  RET

; a.k.a. FINDIG
	;HERE TO PACK THE NEXT DIGIT OF THE NUMBER INTO THE FAC
	;WE MULTIPLY THE FAC BY TEN AND ADD IN THE NEXT DIGIT
; This entry point is used by the routine at _ASCTFP.
ADDIG:
  PUSH DE                ;SAVE EXPONENT INFORMATION                  ; Save sign of exponent/digit
  LD D,A
  LD A,B                 ;INCREMENT DECIMAL PLACE COUNT IF WE ARE    ; Get digits after point
  ADC A,C                ; PAST THE DECIMAL POINT                    ; Add one if after point
  LD B,A                                                             ; Re-save counter
  PUSH BC                ;SAVE DECIMAL POINT INFORMATION             ; Save point flags
  PUSH HL                ;SAVE TEXT POINTER                          ; Save code string address
  PUSH DE
  CALL MLSP10            ;MULTIPLY THE FAC BY 10
  POP AF                 ;GET THE NEXT DIGIT
  SUB '0'                ;CONVERT IT TO ASCII                        ; convert from ASCII
  CALL FINDG4            ;PACK IT INTO THE FAC
  POP HL                 ;ALL DONE, GET TEXT POINTER BACK
  POP BC                 ;GET DECIMAL POINT INFORMATION BACK
  POP DE                 ;GET EXPONENT INFORMATION BACK
  JR _ASCTFP_1           ;GET THE NEXT CHARACTER

FINDG4:
  CALL PUSHF
  CALL FLOAT
FADDT:
  POP BC                 ;GET PREVIOUS NUMBER OFF STACK
  POP DE
  JP FADD                ;ADD THE TWO NUMBERS

FINEDG:
  LD A,E                 ;EXPONENT DIGIT -- MULTIPLY EXPONENT BY 10
  RLCA                   ;FIRST BY 4
  RLCA
  ADD A,E                ;ADD 1 TO MAKE 5
  RLCA                   ;NOW DOUBLE TO GET 10
  ADD A,(HL)             ;ADD IT IN
  SUB '0'                ;SUBTRACT OFF ASCII CODE, THE RESULT IS
                         ;POSITIVE ON LENGTH=2 BECAUSE OF THE ABOVE CHECK
  LD E,A                 ;STORE EXPONENT
  JR FINEC               ;CONTINUE

; This entry point is used by the routines at ERROR and SCCPTR.
IN_PRT:
  PUSH HL                ;SAVE LINE NUMBER
  LD HL,IN_MSG           ;PRINT MESSAGE    (.." in "..)
  LD A,(FRGFLG)
  OR A
  JR Z,IN_PRT_EN
  LD HL,IN_MSG_FR
IN_PRT_EN:
  CALL PRS               ;FALL INTO LINPRT
  POP HL

; Print HL in ASCII form at the current cursor position
; a.k.a. NUMPRT
		;PRINT THE 2 BYTE NUMBER IN H,L
		;ALTERS ALL REGISTERS
;
; Used by the routines at INIT, T_EDIT, SCCPTR, __LIST and SHIFT_STOP.
LINPRT:
  LD DE,PRNUMS
  PUSH DE

; Print number in HL
PRNTHL:
  EX DE,HL              ;PUT SECOND ARGUMENT IN (DE) FOR FLOATR
  XOR A                 ;GET A ZERO FOR THE HIGH ORDER
  LD B,$98              ;ENTRY FROM IADD, SET EXPONENT
  CALL FLOATR           ;GO FLOAT THE NUMBER

; Number to ASCII conversion
;
; Used by the routines at __PRINT and __STR_S.
NUMASC:
  LD HL,FBUFFR          ;GET A POINTER INTO FBUFFR
  PUSH HL
  RST VSIGN
  LD (HL),' '           ;PUT IN A SPACE
  JP P,SPCFST           ;IF WE HAVE A NEGATIVE NUMBER, NEGATE IT        ; Positive - Space to start
  LD (HL),'-'           ; AND PUT A MINUS SIGN IN THE BUFFER            ; "-" sign at start
SPCFST:
  INC HL                ;POINT TO WHERE THE NEXT CHARACTER GOES  ; First byte of number
  LD (HL),'0'           ;PUT A ZERO IN THE BUFFER IN CASE THE NUMBER IS ZERO (IN FREE FORMAT)
                        ;OR TO RESERVE SPACE FOR A FLOATING DOLLAR SIGN (FIXED FORMAT)
  JP Z,SIXDIG1
  PUSH HL
  CALL M,INVSGN
  XOR A
  PUSH AF
;FOUNDB:
  CALL RNGTST
SIXDIG:
  LD BC,$9143           ;GET 99999.95 TO SEE IF THE FAC IS BIG
  LD DE,$4FF8           ; $4FF9 on later versions
  CALL FCOMP            ; ENOUGH YET
  OR A
  JP PO,FOUTCS          ;IT ISN'T ANY MORE, WE ARE DONE
  POP AF                ;IT IS, MULTIPLY BY TEN
  CALL MULTEN           
  PUSH AF               ;SAVE THE EXPONENT AGAIN
  JR SIXDIG             ;NOW SEE IF IT IS BIG ENOUGH
FOUNV2:
  CALL DIV10
  POP AF
  INC A
  PUSH AF
  CALL RNGTST

	;HERE TO CONVERT A SINGLE PRECISION NUMBER TO DECIMAL DIGITS
FOUTCS:
  CALL FADDH            ;ROUND NUMBER TO NEAREST INTEGER
  INC A                 ;MAKE A NON-ZERO, SINCE NUMBER IS POSITIVE AND NON-ZERO, ROUND WILL EXIT WITH THE HO
                        ; IN A, SO THE MSB WILL ALWAYS BE ZERO AND ADDING ONE WILL NEVER CAUSE A TO BE ZERO

  CALL QINT             ;GET INTEGER PART IN C,D,E
  CALL FPBCDE           ;SAVE NUMBER IN FAC
  LD BC,$0306
  POP AF
  ADD A,C
  INC A
  JP M,NUMASC_4
  CP $08
  JR NC,NUMASC_4
  INC A
  LD B,A
  LD A,$02
NUMASC_4:
  DEC A
  DEC A
  POP HL
  PUSH AF
  LD DE,$0806
  DEC B
  JR NZ,NUMASC_5
  LD (HL),'.'
  INC HL
  LD (HL),'0'
  INC HL
NUMASC_5:
  DEC B
  LD (HL),'.'
  CALL Z,INCHL
  PUSH BC
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
  POP BC                ;GET COMMA AND DP INFORMATION BACK
  DEC C
  JR NZ,NUMASC_5
  DEC B
  JR Z,DOEBIT

	;HERE TO SUPPRESS THE TRAILING ZEROS
SUPTLZ:
  DEC HL                ; Move back through buffer         ;MOVE BACK TO THE LAST CHARACTER
  LD A,(HL)             ; Get character                    ;GET IT AND SEE IF IT WAS ZERO
  CP '0'                ; "0" character?
  JR Z,SUPTLZ           ; Yes - Look back for more         ;IT WAS, CONTINUE SUPPRESSING
  CP '.'                ; A decimal point?                 ;HAVE WE SUPPRESSED ALL THE FRACTIONAL DIGITS?
  CALL NZ,INCHL         ; Move back over digit             ;YES, IGNORE THE DECIMAL POINT ALSO
DOEBIT:
  POP AF                ; Get "E" flag                     ;GET THE EXPONENT BACK
  JR Z,NOENED           ; No "E" needed - End buffer       ;WE ARE DONE IF WE ARE IN FIXED POINT NOTATION
                                                           ;FALL IN AND PUT THE EXPONENT IN THE BUFFER

  LD (HL),'E'           ; Put "E" in buffer                ;SAVE IT IN THE BUFFER
  INC HL                ; And move on                      ;INCREMENT THE BUFFER POINTER

	;PUT IN THE SIGN OF THE EXPONENT
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
SIXDIG1:
  INC HL                                                   ;WHEN WE JUMP TO HERE, A IS ZERO
  LD (HL),A             ; Save LSB of exponent             ;PUT ONE'S DIGIT IN BUFFER

;FOUTZR:
  INC HL                ;INCREMENT POINTER, HERE TO FINISH UP

	; PRINTING A FREE FORMAT ZERO
NOENED:
  LD (HL),C
  POP HL
  RET


;HERE TO SEE IF THE FAC IS SMALL ENOUGH YET

; Test number is in range, a.k.a. FOUNVC
; Routine at 13513
; Used by the routine at FOUNDB.
RNGTST:
  LD BC,$9474           ;GET 999999.5 TO SEE IF THE FAC IS TOO BIG
  LD DE,$23F7           ;($23F8 on recent BASIC with double precision support)
  CALL FCOMP
  OR A
  POP HL
  JP PO,FOUNV2
  JP (HL)

; Constant ptr for 0.5 in FP
FP_HALF:
  DEFB $00,$00,$00,$80

; Data block at 2051
L0803:
  DEFB $40,$42,$0F,$A0,$86,$01,$10,$27
  DEFB $00,$E8,$03,$00,$64,$00,$00,$0A
  DEFB $00,$00,$01,$00,$00

; Negate number
;
; Used by the routines at POWER and __ATN.
NEGAFT:
  LD HL,INVSGN
  EX (SP),HL
  JP (HL)

; Routine at 2077
__SQR:
  CALL PUSHF
  LD HL,FP_HALF
  CALL MOVFM

; POWER
POWER:
  POP BC                  ;GET ARG IN REGISTERS, ENTRY TO FPWR IF ARGUMENT IS ON STACK.  FALL INTO FPWR
  POP DE
  RST VSIGN
  LD A,B                  ;POSITIVE EXPONENT                    ; Get exponent of base
  JR Z,__EXP              ;IS IT ZERO TO MINUS POWER?           ; Make result 1 if zero
  JP P,POWER_0            ;GIVE DIV BY ZERO AND CONTINUE        ; Positive base - Ok
  OR A                    ; Zero to negative power?
  JP Z,O_ERR              ; Yes - ?/0 Error
POWER_0:
  OR A                    ; Base zero?
  JP Z,ZERO0              ; Yes - Return zero                   ;IT IS, RESULT IS ZERO
  PUSH DE                 ; Save base
  PUSH BC                 ;SAVE X ON STACK
  LD A,C                  ;CHECK THE SIGN OF X                  ; Get MSB of base
  OR $7F                  ;TURN THE ZERO FLAG OFF               ; Get sign status
  CALL BCDEFP             ;GET Y IN THE REGISTERS               ; Move power to BCDE
  JP P,POWER_2            ;NO PROBLEMS IF X IS POSITIVE         ; Positive base - Ok
  PUSH AF                 ; Save power
  LD A,(FPEXP)
  CP $99
  JR C,POWER_1
  POP AF
  JR POWER_2              ;NO PROBLEMS IF X IS POSITIVE

POWER_1:
  POP AF
  PUSH DE
  PUSH BC
  CALL __INT              ;SEE IF Y IS AN INTEGER                         ; Get integer of power
  POP BC                                                                  ; Restore power
  POP DE                  ;GET Y BACK
  PUSH AF                 ;SAVE LO OF INT FOR EVEN AND ODD INFORMATION    ; MSB of base
  CALL FCOMP              ;SEE IF WE HAVE AN INTEGER                      ; Power an integer?
  POP HL                  ;GET EVEN-ODD INFORMATION                       ; Restore MSB of base
  LD A,H                  ;PUT EVEN-ODD FLAG IN CARRY                     ; but don't affect flags
  RRA                                                                     ; Exponent odd or even?
POWER_2:
  POP HL                  ;GET X BACK IN FAC                              ; Restore MSB and exponent
  LD (FACCU+2),HL         ;STORE HO'S                                     ; Save base in FPREG
  POP HL                  ;GET LO'S OFF STACK                             ; LSBs of base
  LD (FACCU),HL           ;STORE THEM IN FAC                              ; Save in FPREG
  CALL C,NEGAFT           ;NEGATE NUMBER AT END IF Y WAS ODD              ; Odd power - Negate result
  CALL Z,INVSGN           ;NEGATE THE NEGATIVE NUMBER                     ; Negative base - Negate it
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


; Routine at 2164
;
; Used by the routine at POWER.
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
  CALL __INT              ;DETERMINE INTEGER POWER OF 2   ; Get INT of FP accumulator
  ADD A,$81               ;INTEGER WAS RETURNED IN A      ; 80h+1: For excess 128, Exponent = 126?
                          ;BIAS IS $81 BECAUSE BINARY POINT IS TO LEFT OF UNDERSTOOD 1
							 
  POP BC
  POP DE                  ;RECALL y
  JR Z,MUL_OVTST2
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

; Routine at 2229
;
; Used by the routine at __EXP.
RESZER:
  JP OV_ERR               ;OVERFLOW                        ; Overflow error

; Load '1' to FP accumulator
;
; Used by the routine at __EXP.
GET_UNITY:
  LD BC,$8100
  LD DE,$0000
  JP FPBCDE

; Data block at 2241

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

; Routine at 2317
__RND:
  RST VSIGN               ; Test sign of FPREG                   ;GET SIGN OF ARG
  LD HL,SEED+2            ; Random number seed
  JP M,RESEED             ; Negative - Re-seed                   ;START NEW SEQUENCE IF NEGATIVE
  LD HL,RNDX              ; Last random number                   ;GET LAST NUMBER GENERATED
  CALL MOVFM              ; Move last RND to FPREG
  LD HL,SEED+2            ; Random number seed
  RET Z                   ; Return if RND(0)                     ;RETURN LAST NUMBER GENERATED IF ZERO
  ADD A,(HL)              ; Add (SEED)+2)                        ;GET COUNTER INTO CONSTANTS
  AND $07                 ; 0 to 7                               ;AND ADD ONE
  LD B,$00
  LD (HL),A
  INC HL                  ; Move to coefficient table
  ADD A,A                 ; 4 bytes
  ADD A,A                 ; per entry
  LD C,A                  ; BC = Offset into table
  ADD HL,BC               ; Point to coefficient
  CALL LOADFP             ; Coefficient to BCDE
  CALL FMULT              ; Multiply FPREG by coefficient
  LD A,(SEED+1)           ; Get (SEED+1)
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
__RND_0:
  CALL BCDEFP             ; Return RND seed                      ;SWITCH HO AND LO BYTES,
  LD A,E                  ; Get LSB                              ;GET LO
  LD E,C                  ; LSB = MSB                            ;PUT HO IN LO BYTE
  
  DEFB $EE                ;XOR $4F     ; 01001111.. Fiddle around
RND1:  
  LD C,A                  ; New MSB                              ;PUT LO IN HO BYTE
  LD C,A                  ; (useless duplicate)  ...nice idea to save memory wasted !
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
  JR __RND_0

; Addition table used by RND
RNDTB2:
  DEFB $68,$B1,$46,$68
  DEFB $99,$E9,$92,$69
  DEFB $10,$D1,$75,$68


; Routine at 2430
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
  LD DE,INVSGN
  PUSH DE
__SIN_0:                  ;WILL CALCULATE X=FAC/(2*PI)
  LD BC,$7E22             ; BCDE = FP_EPSILON: 1/(2*PI) =~ 0.159155
  LD DE,$F983
  CALL FMULT
  CALL PUSHF              ;SAVE X
  CALL __INT              ;FAC=INT(X)
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
  RST VSIGN
  CALL P,INVSGN
  LD BC,$7F00             ; 0.25
  LD DE,$0000             ;(1/4)
  CALL FADD
  CALL INVSGN
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

; PI/2 fp CONSTANT
FP_HALFPI:
  DEFB $DB,$0F,$49,$81    ; 1.5708 (PI/2)

; (unused)
FP_QUARTER:
  DEFB $00,$00,$00,$7F    ; 0.25


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

; Routine at 2583
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

; Routine at 2604
__ATN:
  RST VSIGN               ; Test sign of value               ;SEE IF ARG IS NEGATIVE
  CALL M,NEGAFT           ; Negate result after if -ve       ;IF ARG IS NEGATIVE, USE:
  CALL M,INVSGN           ; Negate value if -ve              ;   ARCTAN(X)=-ARCTAN(-X)
  LD A,(FPEXP)            ; Get exponent                     ;SEE IF FAC .GT. 1
  CP $81                  ; Number less than 1?
  Jr C,__ATN_0            ; Yes - Get arc tangnt
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


; ATN coefficient table

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
  


; Routine at 2677
;
; Used by the routine at INIT_BEL.
__PLAY:
  CALL PLYHK
  LD (IX+$01),$00
  CALL EVAL
  PUSH HL
  CALL GSTRCU
  CALL LOADFP
  INC E

; play a melody
;
; Used by the routine at _MUSIC.
MUSIC:
  CALL ISCNTC
  LD A,(BC)
  INC BC
  DEC E
  JP Z,MUSIC_2
  CP ','
  JR Z,MUSIC
  CP $7C
  JR Z,MUSIC
  CP ' '
  JR Z,MUSIC
  CP $41
  JP C,SN_ERR
  RES 5,A
  CP $4F
  JP Z,MUSIC_3
  CP $52
  JP Z,MUSIC_6
  CP $54
  JP Z,MUSIC_4
  CP $48
  JP NC,SN_ERR
  SUB $41
  ADD A,A
  INC A
  LD D,A
  LD A,(BC)
  CP $2B
  JR NZ,MUSIC_0
  INC BC
  INC D
  DEC E
MUSIC_0:
  CP $2D
  JR NZ,MUSIC_1
  INC BC
  DEC D
  DEC E
MUSIC_1:
  LD A,(OCTSAV)
  ADD A,D
  LD D,A
  CALL MUSIC_9
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
MUSIC_2:
  POP HL
  LD (IX+$00),$03
  LD (IX+$01),$01
  RET
MUSIC_3:
  LD A,(BC)
  INC BC
  DEC E
  JP Z,MO_ERR
  CP $31
  JP C,SN_ERR
  CP $35
  JP NC,SN_ERR
  SUB $31
  ADD A,A
  LD D,A
  ADD A,A
  ADD A,A
  ADD A,A
  SUB D
  LD (OCTSAV),A
  JP MUSIC
MUSIC_4:
  LD A,(BC)
  SUB $30
  JP C,SN_ERR
  CP $0A
  JP NC,SN_ERR
  LD L,A
  INC BC
  DEC E
  JR Z,MUSIC_5
  LD A,(BC)
  SUB $30
  JR C,MUSIC_5
  CP $0A
  JR NC,MUSIC_5
  LD H,A
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
  JR Z,MUSIC_5
  LD A,(BC)
  SUB $30
  JR C,MUSIC_5
  CP $0A
  JR NC,MUSIC_5
  LD H,A
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
MUSIC_5:
  LD A,L
  OR A
  RRA
  OR A
  RRA
  INC A
  LD (TMPSAV),A
  JP MUSIC
MUSIC_6:
  CALL MUSIC_9
  PUSH HL
  EXX
  POP DE
  LD A,(TMPSAV)
  CALL DELAY
MUSIC_7:
  DEC DE
  LD B,$C0
MUSIC_8:
  NOP
  DJNZ MUSIC_8
  LD A,D
  OR E
  JR NZ,MUSIC_7
  EXX
  JP MUSIC
MUSIC_9:
  LD HL,CHRGTB
  LD A,(BC)
  SUB $30
  RET C
  CP $0A
  RET NC
  LD L,A
  LD H,$00
  INC BC
  DEC E
  RET Z
  LD A,(BC)
  SUB $30
  RET C
  CP $0A
  RET NC
  PUSH DE
  ADD HL,HL
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
  DEFB $CC,$CC,$08,$CA,$CA,$09,$BE,$BE
  DEFB $09,$B3,$B3,$0A,$B3,$B3,$0A,$A9
  DEFB $A9,$0A,$9F,$9F,$0B,$97,$97,$0C
  DEFB $8E,$8E,$0C,$86,$86,$0D,$86,$86
  DEFB $0D,$7F,$7F,$0E,$77,$77,$0F,$71
  DEFB $71,$10,$6A,$6A,$11,$64,$64,$12
  DEFB $5E,$5E,$13,$59,$59,$14,$59,$59
  DEFB $14,$54,$54,$15,$4F,$4F,$17,$4B
  DEFB $4B,$18,$46,$47,$19,$42,$43,$1B
  DEFB $42,$43,$1B,$3E,$3F,$1D,$3A,$3B
  DEFB $1E,$37,$38,$20,$34,$35,$22,$31
  DEFB $32,$24,$2E,$2F,$25,$2C,$2C,$29
  DEFB $2C,$2C,$29,$29,$2A,$2B,$27,$27
  DEFB $2E,$25,$25,$30,$23,$23,$33,$21
  DEFB $21,$36,$21,$21,$36,$1F,$1F,$3A
  DEFB $1D,$1D,$3D,$1C,$1B,$41,$1A,$1A
  DEFB $45,$19,$18,$49,$17,$17,$4D,$16
  DEFB $15,$52,$16,$15,$52,$14,$14,$57
  DEFB $13,$13,$5C,$12,$12,$61,$11,$11
  DEFB $67,$10,$10,$6D,$10,$10,$6D,$0F
  DEFB $0F,$74,$0E,$0E,$52,$0D,$0D,$82
  DEFB $0C,$0C,$8A

; Routine at 3178
__SOUND:
  CALL SONHK
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

  RST SYNCHR
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
  JR NZ,L0C7E_1
  INC HL
  CALL GETINT
L0C7E_1:
  EXX
  PUSH AF
  ADD A,C
  LD (TMPSOUND),A
  POP HL
  LD A,C
  SUB H
  LD (TMPSOUND+1),A

; emitting a sound
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
  LD A,$08
  OUT ($AF),A
  DEC DE
  CALL DELAY_3
  CALL DELAY_4
SOUND_2:
  CALL DELAY_2
  DEC H
  JP NZ,SOUND_2
  LD A,$00
  OUT ($AF),A
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

; unused
L0CEA:
  DEC B
  RETI

; Character redefinition, SETEG (graphics), SETET (text)
__SETE:
  LD A,(HL)
  INC HL
  LD B,$C0
  CP $54
  JR Z,__SETE_0
  LD B,$40
  CP $47
  JP NZ,SN_ERR
__SETE_0:
  PUSH BC
  LD (IX+$01),$00
  CALL GETINT
  CP ' '
  JP C,FC_ERR
  SET 7,A
  LD E,A
  LD D,$22
  EX AF,AF'
  CALL L0D47_3
  POP AF
  PUSH AF
  XOR $80
  LD E,A
  LD D,$21
  CALL L0D47_3
  LD D,$20
  LD E,$03
  CALL L0D47_3
  LD D,$24
  EX AF,AF'
  LD E,A
  EX AF,AF'
  LD A,E
  RRA
  RRA
  AND $1F
  LD E,A
  CALL L0D47_3
  LD D,$25
  EX AF,AF'
  AND $03
  POP BC
  OR B
  LD E,A
  CALL L0D47_3
  LD D,$20
  LD E,$34
  CALL L0D47_3

  RST SYNCHR
  DEFB ','

  RST SYNCHR
  DEFB '"'

  DEC HL
  LD B,10
__SETE_1:
  CALL __CALL_0
  PUSH BC
  LD B,$08
__SETE_2:
  RLCA
  RR C
  DJNZ __SETE_2
  LD A,C
  POP BC
  LD E,A
  LD D,$29
  CALL L0D47_3
  CALL VDP_READY
  LD A,$25
  OUT ($8F),A
  IN A,($CF)
  ADD A,$04
  LD E,A
  LD D,$25
  CALL L0D47_3
  DJNZ __SETE_1
  INC HL
  LD A,(HL)
  CP '"'
  JR NZ,__SETE_3
  INC HL
__SETE_3:
  LD (IX+$01),$01
  RET
; This entry point is used by the routines at __SETE and CHR_UPDATE.
L0D47_3:
  LD C,$8F
  OUT (C),D
  LD C,$CF
  OUT (C),E
  RET

; Redefine a character
;
; Used by the routines at CHRGTB, SCR_CO and SHIFT_STOP.
CHR_UPDATE:
  LD B,$C0
  BIT 7,A
  JR Z,CHR_UPDATE_0
  LD B,$40
CHR_UPDATE_0:
  PUSH BC
  LD (IX+$01),$00
  SET 7,A
  LD E,A
  LD D,$22
  EX AF,AF'
  CALL L0D47_3
  POP AF
  PUSH AF
  XOR $80
  LD E,A
  LD D,$21
  CALL L0D47_3
  LD D,$20
  LD E,$03
  CALL L0D47_3
  LD D,$24
  EX AF,AF'
  LD E,A
  EX AF,AF'
  LD A,E
  RRA
  RRA
  AND $1F
  LD E,A
  CALL L0D47_3
  LD D,$25
  EX AF,AF'
  AND $03
  POP BC
  OR B
  LD E,A
  CALL L0D47_3
  LD D,$20
  LD E,$34
  CALL L0D47_3
  LD B,10
CHR_UPDATE_1:
  LD A,(HL)
  INC HL
  PUSH BC
  LD B,$08
CHR_UPDATE_2:
  RLCA
  RR C
  DJNZ CHR_UPDATE_2
  LD A,C
  POP BC
  LD E,A
  LD D,$29
  CALL L0D47_3
  CALL VDP_READY
  LD A,$25
  OUT ($8F),A
  IN A,($CF)
  ADD A,$04
  LD E,A
  LD D,$25
  CALL L0D47_3
  DJNZ CHR_UPDATE_1
  LD (IX+$01),$01
  RET

; Enter in TEXT mode
__TX:
  LD A,$00
  LD (IX+$0A),A
; This entry point is used by the routines at __GR, __ET and __EG.
__TX_0:
  PUSH AF
  OR $07
  LD (IX+$08),A
  POP AF
  RET Z
  CALL GETINT
  PUSH AF
  AND $07
  LD D,A
  LD A,(IX+$08)
  AND $F8
  OR D
  LD (IX+$08),A
  POP AF
  RET Z

; Routine at 3607
L0E17:
  RST SYNCHR

; Data block at 3608
L0E18:
  DEFB ','

; Routine at 3609
L0E19:
  CALL GETINT
  PUSH AF
  AND $07
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  OR (IX+$08)
  LD (IX+$08),A
  POP AF
  RET Z

; Routine at 3627
L0E2B:
  RST SYNCHR

; Data block at 3628
L0E2C:
  DEFB ','

; Routine at 3629
L0E2D:
  CALL GETINT
  OR A
  RET Z
  SET 3,(IX+$08)
  RET

; Enter in GRAPHICS mode
__GR:
  LD (IX+$0A),$00
  LD A,$80
  JP __TX_0

; Routine at 3648
__ET:
  LD (IX+$0A),$80
  LD A,$00
  JP __TX_0

; Routine at 3657
__EG:
  LD A,$80
  LD (IX+$0A),A
  JP __TX_0

; Routine at 3665
__INIT:
  LD (IX+$08),$00
  PUSH HL
  LD A,$E6
  JR Z,L0E63_1
  POP HL
  CALL GETINT
  JR Z,L0E63_0
  PUSH AF

; Routine at 3681
L0E61:
  RST SYNCHR

; Data block at 3682
L0E62:
  DEFB ','

; Routine at 3683
L0E63:
  CALL GETINT
  AND $07
  LD B,A
  LD A,(IX+$03)
  AND $F8
  OR B
  LD (IX+$03),A
  POP AF
; This entry point is used by the routine at __INIT.
L0E63_0:
  PUSH HL
  AND $07
  LD L,A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,L
  SET 7,A
; This entry point is used by the routine at __INIT.
L0E63_1:
  CALL CONSOLE_CLS
  POP HL
  RET

; Routine at 3715
__CURSOR:
  LD A,(HL)
  INC HL
  CP $59
  JR Z,__CURSOR_1
  CP $58
  JP NZ,SN_ERR
  CALL GETINT
  CP $28
  JR C,__CURSOR_0
  LD A,$27
__CURSOR_0:
  LD (CURPOS),A
  RET
__CURSOR_1:
  CALL GETINT
  CP $19
  JR C,__CURSOR_2
  LD A,$18
__CURSOR_2:
  LD (YCURSO),A
  RET

; Routine at 3752
__SCROLL:
  LD A,(PICFLG)
  RES 7,A
  LD (PICFLG),A
  RET

; Routine at 3761
__PAGE:
  LD A,(PICFLG)
  SET 7,A
  LD (PICFLG),A
  RET

; Routine at 3770
__STICKX:
  CALL MAKINT
  CALL JOY_L_R
  JP PASSA

; scan joysticks (right/left)
;
; Used by the routines at _JOY_L_R and __STICKX.
JOY_L_R:
  LD B,$00
  AND $03
  JR Z,JOY_L_R_1
  DEC A
  JR Z,JOY_L_R_3
  IN A,($80)
  BIT 3,A
  JR NZ,JOY_L_R_0
  DEC B
JOY_L_R_0:
  BIT 4,A
  JR JOY_L_R_5
JOY_L_R_1:
  IN A,($07)
  BIT 3,A
  JR NZ,JOY_L_R_2
  DEC B
JOY_L_R_2:
  BIT 1,A
  JR JOY_L_R_5
JOY_L_R_3:
  IN A,($08)
  BIT 3,A
  JR NZ,JOY_L_R_4
  DEC B
JOY_L_R_4:
  BIT 1,A
; This entry point is used by the routines at JOY_UP_DOWN and JOY_FIRE_F2.
JOY_L_R_5:
  JR NZ,JOY_L_R_6
  INC B
JOY_L_R_6:
  LD A,B
  RET

; Routine at 3824
__STICKY:
  CALL MAKINT
  CALL JOY_UP_DOWN
  JP PASSA

; scan joysticks (up/down)
;
; Used by the routines at _JOY_UP_DOWN and __STICKY.
JOY_UP_DOWN:
  LD B,$00
  AND $03
  JR Z,JOY_UP_DOWN_1
  DEC A
  JR Z,JOY_UP_DOWN_3
  IN A,($81)
  BIT 6,A
  JR NZ,JOY_UP_DOWN_0
  DEC B
JOY_UP_DOWN_0:
  IN A,($80)
  BIT 5,A
  JR JOY_L_R_5
JOY_UP_DOWN_1:
  IN A,($07)
  BIT 0,A
  JR NZ,JOY_UP_DOWN_2
  DEC B
JOY_UP_DOWN_2:
  BIT 2,A
  JR JOY_L_R_5
JOY_UP_DOWN_3:
  IN A,($08)
  BIT 0,A
  JR NZ,JOY_UP_DOWN_4
  DEC B
JOY_UP_DOWN_4:
  BIT 2,A
  JR JOY_L_R_5

; Routine at 3877
__ACTION:
  CALL MAKINT
  CALL JOY_FIRE_F2
  JP PASSA

; scan joysticks (action1/action2)
;
; Used by the routines at _JOY_FIRE_F2 and __ACTION.
JOY_FIRE_F2:
  LD B,$00
  AND $03
  JR Z,JOY_FIRE_F2_0
  DEC A
  JP Z,L1CC0_59
  IN A,($81)
  BIT 2,A
  JR JOY_L_R_5
JOY_FIRE_F2_0:
  IN A,($07)
  CPL
  AND $30
  RRCA
  RRCA
  RRCA
  RRCA
  LD B,A
  RET

; Routine at 3913
__KEY:
  PUSH HL
  CALL KBDSCAN
  POP HL
  OR A
  JP PASSA

; Routine at 3922
__DELIM:
  LD A,(IX+$08)
  PUSH AF
  LD A,$00
  PUSH AF
  CALL GETINT
  AND $07
  POP DE
  OR D
  PUSH AF

; Routine at 3937
L0F61:
  RST SYNCHR

; Data block at 3938
L0F62:
  DEFB ','

; Routine at 3939
L0F63:
  CALL GETINT
  AND $07
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  POP DE
  OR D
  SET 7,A
  LD (IX+$08),A

; Routine at 3955
L0F73:
  RST SYNCHR

; Data block at 3956
L0F74:
  DEFB ','

; Routine at 3957
L0F75:
  CALL GETINT
  BIT 0,A
  LD A,$80
  JR Z,L0F75_0
  LD A,$84
L0F75_0:
  PUSH HL
  CALL GETCHAR_2
  POP HL
  POP AF
  LD (IX+$08),A
  LD (IX+$01),$01
  RET

; Routine at 3982
;
; Used by the routine at __DISPLAY.
__SCREEN:
  LD (IX+$01),$01
  LD (IX+$00),$01
  HALT
  RET

; Routine at 3992
__DISPLAY:
  LD A,$20
  JR Z,__DISPLAY_0
  CALL GETINT
__DISPLAY_0:
  LD (IX+$02),A
  JR __SCREEN

; unused
__STORE:
  LD (IX+$02),$00
  LD (IX+$00),$00
  RET

; Routine at 4013
__CALL:
  CALL GETNUM
  CALL CONIS
  LD A,$C3
  LD (CALHK),A
  LD ($47D4),DE
  JP CALHK
; This entry point is used by the routine at L0D47.
__CALL_0:
  CALL __CALL_1
  JP C,SN_ERR
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD C,A
  CALL __CALL_1
  JP C,SN_ERR
  OR C
  RET
; This entry point is used by the routine at OCTCNS.
__CALL_1:
  INC HL
  LD A,(HL)
  CP '0'
  JR C,__CALL_3
  CP $3A
  JR C,__CALL_2
  RES 5,A
  CP $41
  JR C,__CALL_3
  CP $47
  JP NC,__CALL_3
  ADD A,$C9
__CALL_2:
  AND $0F
  RET
__CALL_3:
  SCF
  RET

; Data block at 4078
L0FEE:
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF

; Routine at 4096
;
; Used by the routines at L0000 and ERROR.
_STARTUP:
  DI			; Previous (buggy) version 1.1 had "INC BC" in place of DI
  LD HL,$0000
  LD DE,SCREEN
  LD BC,$C000
  LDIR
  LD B,H
  LD C,L
  LD HL,SCREEN
_STARTUP_0:
  LD A,(DE)
  CPI
  INC DE
  JR NZ,INIT
  JP PE,_STARTUP_0

; "LD A,n" AROUND THE NEXT BYTE
L101A:
  DEFB $3E

; Routine at 4123
;
; Used by the routine at _STARTUP.
INIT:
  DEC HL
  LD SP,HL
  LD (STKTOP),HL
  LD A,$C9
  LD HL,INTHK
  LD B,$1E
INIT_0:
  LD (HL),A
  INC HL
  DJNZ INIT_0
  LD A,$C3
  LD (__LPEN),A
  LD (__DISK),A
  LD (__MODEM),A
  LD HL,UNDEFINED_ERR
  LD (LPEN_ADDR),HL
  LD (DISK_ADDR),HL
  LD (MDM_ADDR),HL
  LD HL,NMI_BOOT
  LD (NMIADDR),HL
  LD (NMIHK),A
  LD IX,INTDIV
  LD HL,VDP_TXT
  CALL SET_VDP_REGS
  LD (IX+$00),$05
  LD (IX+$01),$00
  LD (IX+$04),$01
  IM 1
  EI
  LD HL,$0001
  LD ($4809),HL
  LD (IX+$03),$6E
  CALL SCR_CO
  LD HL,ROM_RAMLOW
  LD BC,$0065
  LD DE,RAMLOW
  LDIR
  XOR A
  OUT ($EF),A
  OUT ($AF),A
  LD HL,NMI_HANDLER
  LD (NMIADDR),HL
  CALL CLREG
  CALL OUTDO_CRLF
  LD (ENDBUF),A
  LD (SYSVAR_TOP),A
  LD HL,$FFFE
  ADD HL,SP
  LD DE,$03E8
  RST DCOMPR
  JP C,OM_ERR
  LD DE,$FFCE
  LD (MEMSIZ),HL
  ADD HL,DE
  LD (STKTOP),HL
  CALL CLRPTR
  LD HL,(STKTOP)
  LD DE,$FFEF
  ADD HL,DE
  LD DE,SYSVAR_TOP
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  PUSH HL
  LD (IX+$08),$30
  LD HL,STARTUP_MSG
  CALL PRS
  CALL OUTDO_CRLF
  LD HL,STARTUP_MSG
  CALL PRS
  LD (IX+$08),$00
  LD HL,VER_MSG
  CALL PRS
  LD HL,VERSION
  CALL PRS
  CALL OUTDO_CRLF
  POP HL
  CALL LINPRT
  LD HL,AVAIL_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,INIT_1
  LD HL,AVAIL_MSG
INIT_1:
  CALL PRS
  LD DE,$4241
  LD HL,INIT_BEL
  PUSH HL
  LD HL,$6000
  LD BC,FNCTAB
INIT_2:
  XOR A
  ADC HL,BC
  LD A,H
  OR L
  RET Z
  PUSH HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RST DCOMPR
  POP HL
  JR NZ,INIT_2
  INC HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP (HL)

; NMI handler at runtime
NMI_HANDLER:
  PUSH AF
  IN A,($80)
  AND $40
  JR Z,WARM_BOOT
  POP AF
  RETN
; This entry point is used by the routine at VSIGN.
WARM_BOOT:
  LD SP,ENDBUF
  XOR A
  OUT ($AF),A
  LD (GETFLG),A
  INC A
  OUT ($10),A
  EI
  LD HL,$0001
  LD ($4809),HL
  LD (IX+$03),$6E
  CALL SCR_CO
  CALL CLREG

; Routine at 4415
;
; Used by the routine at ROM_RAMLOW.
INIT_BEL:
  LD HL,STARTUP_SOUND
  CALL __PLAY
  JP READY

; Message at 4424
STARTUP_MSG:
  DEFM "VVGG  55000000  BBAASSIICC"
  DEFB $00

; Message at 4451
VER_MSG:
  DEFM " version "
  DEFB $00

; Data block at 4461
STARTUP_SOUND:
  DEFB $22,$54,$38,$4F,$34,$43,$4F,$33
  DEFB $47,$45,$43,$22

; Data block at 4473
VDP_TXT:
  DEFB $1A

; Data block at 4474
L117A:
  DEFB $28,$81,$29,$00,$20,$82,$29,$6E
  DEFB $20,$83,$29,$F7,$20,$84,$29,$13
  DEFB $20,$87,$29,$08,$26,$08,$27,$00
  DEFB $28,$02

; INITAB: This ram area will be relocated to RAMLOW
ROM_RAMLOW:
  JP INIT_BEL
ROM_USR:
  JP FC_ERR

; Routine at 4506
ROM_FDIVC:
  SUB $00
  LD L,A
  LD A,H
  SBC A,$00
  LD H,A
  LD A,B
  SBC A,$00
  LD B,A
  LD A,$00
  RET

; Data block at 4520
ROM_SEED:
  DEFB $00,$00,$00

; Data block at 4523
ROM_RNDTAB:
  DEFB $35,$4A,$CA,$99,$39,$1C,$76,$98
  DEFB $22,$95,$B3,$98,$0A,$DD,$47,$98
  DEFB $53,$D1,$99,$99,$0A,$1A,$9F,$98
  DEFB $65,$BC,$CD,$98,$D6,$77,$3E,$98

; Data block at 4555
ROM_RNDX:
  DEFB $52,$C7,$4F,$80

; Routine at 4559
ROM_INPSUB:
  IN A,($00)
  RET

; Data block at 4562
ROM_LPTPOS:
  DEFB $00

; Data block at 4563
ROM_PRTFLG:
  DEFB $00

; Data block at 4564
ROM_GETFLG:
  DEFB $00

; Data block at 4565
ROM_PICFLG:
  DEFB $00

; Data block at 4566
ROM_CASCOM:
  DEFB $00

; Data block at 4567
ROM_RAWPRT:
  DEFB $00

; Data block at 4568
ROM_PRTSTT:
  DEFB $00

; Data block at 4569
ROM_PRTCOM:
  DEFB $00

; Data block at 4570
ROM_PRTINT:
  DEFW ROM_PRTFLG

; address of printer translation table
ROM_PRTXLT:
  DEFW PRT_XLT_TBL

; Data block at 4574
L11DE:
  DEFB $17,$18,$12,$1B,$14,$13,$1A,$19
  DEFB $16,$15,$00,$0A,$00,$0A,$00,$00
  DEFB $28,$1B,$FE,$FF,$FC,$49,$00,$F9
  DEFB $11,$0D,$1C,$0C,$F2,$77,$73,$2F
  DEFB $00,$2D,$3D,$00,$71,$78,$65,$2A
  DEFB $30,$2B,$02,$00,$20,$63,$33,$66
  DEFB $5D,$72,$6E,$08,$01,$76,$34,$67
  DEFB $10,$74,$6A,$07,$00,$62,$35,$75
  DEFB $2C,$79,$68,$0A,$0D,$31,$36,$69
  DEFB $37,$3C,$6B,$00,$09,$3A,$32,$6F
  DEFB $38,$D8,$6C,$05,$61,$7A,$3B,$70
  DEFB $39,$64,$6D,$1F,$FF,$57,$53,$5F
  DEFB $00,$3F,$5E,$00,$51,$58,$45,$7C
  DEFB $29,$2E,$04,$00,$20,$43,$22,$46
  DEFB $5B,$52,$4E,$08,$01,$56,$1C,$47
  DEFB $D7,$54,$4A,$07,$00,$42,$24,$55
  DEFB $2F,$59,$48,$0A,$0D,$23,$25,$49
  DEFB $26,$3E,$4B,$00,$09,$2A,$21,$4F
  DEFB $27,$D8,$4C,$06,$41,$5A,$40,$50
  DEFB $28,$44,$4D,$1F,$FF,$F7,$F3,$5F
  DEFB $00,$3F,$5E,$00,$F1,$F8,$E5,$3B
  DEFB $B0,$2E,$04,$00,$20,$E3,$B3,$E6
  DEFB $DB,$F2,$EE,$08,$01,$F6,$B4,$E7
  DEFB $DC,$F4,$EA,$07,$00,$E2,$B5,$F5
  DEFB $DE,$F9,$E8,$0A,$0D,$B1,$B6,$E9
  DEFB $B7,$DF,$EB,$00,$09,$D9,$B2,$EF
  DEFB $B8,$E0,$EC,$06,$E1,$FA,$DA,$F0
  DEFB $B9,$E4,$ED

; keyboard table
KEYTAB:
  DEFB $0C,$F2,$7A,$73,$2F,$00,$2D,$3D
  DEFB $00,$61,$78,$65,$2A,$30,$2B,$02
  DEFB $00,$20,$63,$33,$66,$5D,$72,$6E
  DEFB $08,$6D,$76,$34,$67,$10,$74,$6A
  DEFB $07,$00,$62,$35,$75,$2C,$79,$68
  DEFB $0A,$0D,$31,$36,$69,$37,$3C,$6B
  DEFB $00,$09,$3A,$32,$6F,$38,$D8,$6C
  DEFB $05,$71,$77,$3B,$70,$39,$64,$01
  DEFB $1F,$FF,$5A,$53,$5F,$00,$3F,$5E
  DEFB $00,$41,$58,$45,$7C,$29,$2E,$04
  DEFB $00,$20,$43,$22,$46,$5B,$52,$4E
  DEFB $08,$4D,$56,$1C,$47,$D7,$54,$4A
  DEFB $07,$00,$42,$24,$55,$2F,$59,$48
  DEFB $0A,$0D,$23,$25,$49,$26,$3E,$4B
  DEFB $00,$09,$2A,$21,$4F,$27,$D8,$4C
  DEFB $06,$51,$57,$40,$50,$28,$44,$01
  DEFB $1F,$FF,$FA,$F3,$5F,$00,$3F,$5E
  DEFB $00,$E1,$F8,$E5,$3B,$B0,$2E,$04
  DEFB $00,$20,$E3,$B3,$E6,$DB,$F2,$EE
  DEFB $08,$ED,$F6,$B4,$E7,$DC,$F4,$EA
  DEFB $07,$00,$E2,$B5,$F5,$DE,$F9,$E8
  DEFB $0A,$0D,$B1,$B6,$E9,$B7,$DF,$EB
  DEFB $00,$09,$D9,$B2,$EF,$B8,$E0,$EC
  DEFB $06,$F1,$F7,$DA,$F0,$B9,$E4,$01

; Error messages in French
ERRMSG_FR:
  DEFB $00
  DEFM "NEXT sans FOR"
  DEFB $00
  DEFM "Erreur de syntaxe"
  DEFB $00
  DEFM "RETURN sans GOSUB"
  DEFB $00
  DEFM "DATA "
  DEFB $12
  DEFM "puis"
  DEFB $12
  DEFM "es"
  DEFB $00
  DEFM "Appel de fonction incorrecte"
  DEFB $00
  DEFM "D"
  DEFB $12
  DEFM "passement de capacit"
  DEFB $12
  DEFB $00
OV_MSG_FR:
  DEFM "Sortie de m"
  DEFB $12
  DEFM "moire"
  DEFB $00
  DEFM "Ligne non d"
  DEFB $12
  DEFM "finie"
  DEFB $00
  DEFM "Indice hors des limites"
  DEFB $00
  DEFM "Tableau redimensionn"
  DEFB $12
  DEFB $00
  DEFM "Division par z"
  DEFB $12
  DEFM "ro"
  DEFB $00
  DEFM "Incorrect en direct"
  DEFB $00
  DEFM "Op"
  DEFB $12
  DEFM "rande mal adapt"
  DEFB $12
  DEFB $00
  DEFM "Espace-cha"
  DEFB $11
  DEFM "ne "
  DEFB $12
  DEFM "puis"
  DEFB $12
  DEFB $00
  DEFM "Cha"
  DEFB $11
  DEFM "ne trop longue"
  DEFB $00
  DEFM "Formule cha"
  DEFB $11
  DEFM "ne trop complexe"
  DEFB $00
  DEFM "Impossible de continuer"
  DEFB $00
  DEFM "Fonction utilisateur non d"
  DEFB $12
  DEFM "finie"
  DEFB $00
  DEFM "Op"
  DEFB $12
  DEFM "rande manquant"
  DEFB $00
  DEFM "FOR sans NEXT"
  DEFB $00
  DEFM "Peripherique non connect"
  DEFB $12
  DEFB $00
  DEFM "Non reconnu"
  DEFB $00

; Error messages in English
ERRMSG:
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
  DEFM "Overflow"
  DEFB $00
OV_MSG:
  DEFM "Out of memory"
  DEFB $00
  DEFM "Undefined line number"
  DEFB $00
  DEFM "Subscript out of range"
  DEFB $00
  DEFM "Duplicate definition"
  DEFB $00
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
  DEFM "Cannot continue"
  DEFB $00
  DEFM "Undefined user function"
  DEFB $00
  DEFM "Missing operand"
  DEFB $00
  DEFM "FOR without NEXT"
  DEFB $00
  DEFM "Device not supported"
  DEFB $00
  DEFM "Unrecognized"
  DEFB $00
AVAIL_MSG_FR:
  DEFM " octets disponibles"
  DEFB $03
  DEFB $00
AVAIL_MSG:
  DEFM " bytes free"
  DEFB $03
  DEFB $00
LINE_MSG_FR:
  DEFM "Ligne "
  DEFB $00
LINE_MSG:
  DEFM "Line "
  DEFB $00
LINE_ERR_MSG_FR:
  DEFM " non d"
  DEFB $12
  DEFM "finie"
  DEFB $00
LINE_ERR_MSG:
  DEFM " not defined"
  DEFB $00
EXTRA_MSG_FR:
  DEFM "Derni"
  DEFB $12
  DEFM "re information ignor"
  DEFB $12
  DEFM "e"
  DEFB $03
  DEFB $00
EXTRA_MSG:
  DEFM "Extra ignored"
  DEFB $03
  DEFB $00
REDO_MSG_FR:
  DEFM "Recommencez au d"
  DEFB $12
  DEFM "but"
  DEFB $03
  DEFB $00
REDO_MSG:
  DEFM "Redo from start"
  DEFB $03
  DEFB $00
BREAK_MSG_FR:
  DEFB $0F
  DEFM "Arr"
  DEFB $1B
  DEFM "t"
  DEFB $00
BREAK_MSG:
  DEFB $0F
  DEFM "Break"
  DEFB $00
IN_MSG:
  DEFM " en "
  DEFB $00
IN_MSG_FR:
  DEFM " in "
  DEFB $00
FOUND_MSG:
  DEFM "Found:"
  DEFB $00
SKIP_MSG:
  DEFM "Skip:"
  DEFB $00
ABORTED_MSG:
  DEFM "ABORTED - reposition tape"
  DEFB $0E
  DEFB $03
  DEFB $00
BADFILE_MSG:
  DEFM "Bad file"
  DEFB $0E
  DEFB $03
  DEFB $00
MISMATCH_MSG:
  DEFM "File mismatch"
  DEFB $03
  DEFB $00
PRINTER_MSG:
  DEFM "Printer not ready"
  DEFB $03
  DEFB $00
FOUND_MSG_FR:
  DEFM "Trouv"
  DEFB $12
  DEFM ":"
  DEFB $00
SKIP_MSG_FR:
  DEFM "Pass"
  DEFB $12
  DEFM ":"
  DEFB $00
ABORTED_MSG_FR:
  DEFM "ANNULE - repositionner la bande"
  DEFB $0E
  DEFB $03
  DEFB $00
BADFILE_MSG_FR:
  DEFM "Mauvais fichier"
  DEFB $0E
  DEFB $03
  DEFB $00
MISMATCH_MSG_FR:
  DEFM "Fichier non correspondant"
  DEFB $03
  DEFB $00
PRINTER_MSG_FR:
  DEFM "Imprimante pas pr"
  DEFB $1B
  DEFM "te"
  DEFB $03
  DEFB $00

; Translation table for printer
PRT_XLT_TBL:
  DEFB $00,$01,$02,$03,$04,$05,$06,$07
  DEFB $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
  DEFB $10,$8C,$82,$97,$8B,$87,$96,$85
  DEFB $83,$8A,$93,$88,$9C,$AB,$1E,$1F
  DEFB $20,$21,$22,$23,$24,$25,$26,$27
  DEFB $28,$29,$2A,$2B,$2C,$2D,$2E,$2F
  DEFB $30,$31,$32,$33,$34,$35,$36,$37
  DEFB $38,$39,$3A,$3B,$3C,$3D,$3E,$3F
  DEFB $40,$41,$42,$43,$44,$45,$46,$47
  DEFB $48,$49,$4A,$4B,$4C,$4D,$4E,$4F
  DEFB $50,$51,$52,$53,$54,$55,$56,$57
  DEFB $58,$59,$5A,$5B,$5C,$5D,$5E,$5F
  DEFB $60,$61,$62,$63,$64,$65,$66,$67
  DEFB $68,$69,$6A,$6B,$6C,$6D,$6E,$6F
  DEFB $70,$71,$72,$73,$74,$75,$76,$77
  DEFB $78,$79,$7A,$7B,$7C,$7D,$7E,$7F
  DEFB $80,$81,$82,$83,$84,$85,$86,$87
  DEFB $88,$89,$8A,$8B,$8C,$8D,$8E,$8F
  DEFB $90,$91,$92,$93,$94,$95,$96,$97
  DEFB $98,$99,$9A,$9B,$9C,$9D,$9E,$9F
  DEFB $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7
  DEFB $A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF
  DEFB $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7
  DEFB $B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
  DEFB $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7
  DEFB $C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF
  DEFB $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7
  DEFB $D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF
  DEFB $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7
  DEFB $E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF
  DEFB $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7
  DEFB $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF

; Routine at 6469
__SAVE:
  CALL L1ADB_15
  CALL __LIST_0
  PUSH HL
  PUSH DE
  CALL L1CC0_36
  POP DE
  LD HL,$0000
  LD (RETADR),HL
  LD A,$FF
  LD (PRTFLG),A
  LD A,$82
  LD HL,(VARTAB)
  LD (HL),A
  INC HL
  LD ($4820),HL
  LD ($4824),A
  CALL __LIST_4
  LD A,$83
  CALL L1CC0_18
  LD A,($4824)
  CALL L1CC0_21
  CALL __CSAVE_0
  POP HL
  JP CLRPTR

; Routine at 6526
__LOAD:
  CALL __LIST_0
  LD A,(CASCOM)
  AND $0F
  LD (CASCOM),A
  CALL L1CC0_57
  LD E,$05
  CALL L1CC0_58
  CALL INLPNM_19
  JR C,__LOAD_0
  CALL L1CC0_56
  JR C,__LOAD_0
  CP $82
  SCF
  JR NZ,__LOAD_0
  LD (AUTORUN),A
  CALL L1CC0_23
__LOAD_0:
  JP C,L1ADB_1
  PUSH AF
  CALL L1CC0_56
  POP AF
  CALL TAPIOF
  JR Z,__LOAD_2
  LD HL,OV_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,__LOAD_1
  LD HL,OV_MSG
__LOAD_1:
  CALL PRS
  CALL OUTDO_CRLF
__LOAD_2:
  LD A,(CASCOM)
  AND $F0
  JR Z,__LOAD_3
  CALL L1ADB_5
  CALL PRS
__LOAD_3:
  LD HL,PAUSE_MSG
  CALL PRS
  XOR A
  LD (AUTFLG),A
  DEC A
  LD (GETFLG),A
  JP P_PROMPT

; Message at 6627
PAUSE_MSG:
  DEFM "Pause..."
  DEFB $03
  DEFB $00

; Routine at 6637
__CSAVE:
  CP 'M'
  JR Z,$1A03
  CP 'S'
  JR Z,$1A03
  CP $BB
  JR Z,$1A03
  CP 'X'
  JR Z,$1A03
  CP 'L'
  JP Z,PRINT_FNAME_MSG_7
  LD A,($0123)
  LD A,$20
  LD (FILETAB),A
  CALL L1ADB_15
  CALL L1BA4_2
  CALL PRINT_FNAME_MSG_8
  PUSH HL
  CALL CSAVE_HEADER
  JR C,__CSAVE_1
  CALL L1CC0_42

  DEFB $3E  ; "LD A,n" to Mask the next byte
__CSAVE_0:
  PUSH HL
__CSAVE_1:
  CALL INLPNM_3
  JR NC,__CSAVE_2
  LD HL,CASCOM
  SET 7,(HL)
  LD HL,ABORTED_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,__CSAVE_FR
  LD HL,ABORTED_MSG
__CSAVE_FR:
  CALL PRS
__CSAVE_2:
  POP HL
  RET

; Routine at 6713
__CLOAD:
  CP $BB
  LD ($4817),A
  JR NZ,__CLOAD_0
  INC HL

; Routine at 6721
;
; Used by the routine at __CLOAD.
__CLOAD_0:
  LD (FILETAB),A
  CP $41
  JR Z,__CLOAD_1
  SUB TK_PRINT		 ; '?'=TK_PRINT  (Check if a "CLOAD?" command was issued, to just VERIFY the file )
  JR Z,_VERIFY
  
  DEFB $3E     ; "LD A,n" AROUND THE NEXT BYTE
__CLOAD_1:
  DEFB  $23
  XOR A

  DEFB $01       ; "LD BC,nn" to jump over the next word without executing it

; Routine at 6736
_VERIFY:
  CPL
  INC HL
  CP $01
  PUSH AF
  LD A,(CASCOM)
  AND $0F
  LD (CASCOM),A
  CALL L1BA4_1
  CALL L1CC0_2
  CALL L1CC0_57
L1A50_0:
  LD E,$01
  CALL L1CC0_58
  CALL INLPNM_19
  JR C,L1ADB
  CALL CLOAD_HEADER
  JR C,L1ADB
  LD HL,FILNM2
  CALL CLOAD_HEADER_2
  JR Z,L1A50_4
  LD HL,SKIP_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,L1A50_1
  LD HL,SKIP_MSG
L1A50_1:
  CALL PRINT_FNAME_MSG
  LD E,$04
  CALL L1CC0_58
  CALL INLPNM_19
  JR C,L1ADB
L1A50_2:
  LD B,10
L1A50_3:
  CALL L1CC0_56
  JR C,L1ADB
  OR A
  JR NZ,L1A50_2
  DJNZ L1A50_3
  JR L1A50_0
L1A50_4:
  LD HL,FOUND_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,L1A50_5
  LD HL,FOUND_MSG
L1A50_5:
  CALL PRINT_FNAME_MSG
  LD E,$02
  CALL L1CC0_58
  LD A,($4818)
  CP ' '
  JR NZ,L1A50_6
  LD A,(FILETAB)
  CP $41
  JR Z,L1A50_6
  POP AF
  LD (FACCU),A
  CALL C,CLRPTR
  LD A,(FACCU)
  CP $01
  PUSH AF
L1A50_6:
  CALL L1CC0_9
  POP AF
  CALL L1CC0_46

; "LD A,n" AROUND THE NEXT BYTE
L1ADA:
  DEFB $3E

; Routine at 6875
;
; Used by the routine at L1A50.
L1ADB:
  POP DE
  CALL TAPIOF
  LD HL,CASCOM
  JR C,L1ADB_1
  JR NZ,L1ADB_0
  LD A,C
  OR A
  LD A,(HL)
  JR Z,L1ADB_6
  AND $F0
  JR NZ,L1ADB_2
; This entry point is used by the routine at L1CC0.
__CLOAD_OK:
  LD HL,OK_MSG
  CALL PRS
  JP FINI
L1ADB_0:
  SET 4,(HL)
  LD E,$0C
  JP ERROR
; This entry point is used by the routine at __LOAD.
L1ADB_1:
  SET 7,(HL)
  LD HL,ABORTED_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,L1ADB_4
  LD HL,ABORTED_MSG
  JR L1ADB_4
L1ADB_2:
  CP ' '
  JR NZ,L1ADB_3
  LD HL,MISMATCH_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,L1ADB_4
  LD HL,MISMATCH_MSG
  JR L1ADB_4
L1ADB_3:
  CALL L1ADB_5
L1ADB_4:
  CALL PRS
  JP RESTART
; This entry point is used by the routine at __LOAD.
L1ADB_5:
  LD HL,BADFILE_MSG_FR
  LD A,(FRGFLG)
  OR A
  RET Z
  LD HL,BADFILE_MSG
  RET
L1ADB_6:
  BIT 3,A
  JR NZ,L1ADB_7
  AND $F0
  JR NZ,L1ADB_2
L1ADB_7:
  LD A,($4818)
  CP $4D
  JR Z,L1ADB_8
  CP ' '
  JR NZ,L1ADB_14
  LD A,(HL)
  AND $F0
  JR NZ,L1ADB_2
  CALL PRINT_FNAME_MSG_3
  LD (VARTAB),HL
L1ADB_8:
  LD A,($4889)
  OR A
  JR NZ,L1ADB_9
  LD HL,KBUF
  LD A,(HL)
  OR A
  JR Z,L1ADB_9
  CP '0'
  JR Z,L1ADB_10
  JR L1ADB_13
L1ADB_9:
  LD DE,$4820
  LD A,(DE)
  OR A
  JR NZ,L1ADB_11
L1ADB_10:
  LD A,($4818)
  CP $4D
  JR Z,L1ADB_14
  JP __CLOAD_OK
L1ADB_11:
  PUSH HL
  LD B,$05
L1ADB_12:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DJNZ L1ADB_12
  POP HL
L1ADB_13:
  DEC A
  JP __RUN
L1ADB_14:
  LD HL,(CONTXT)
  RET
; This entry point is used by the routines at __SAVE and __CSAVE.
L1ADB_15:
  DEC HL
  RST CHRGTB
  RET Z
  CP $28
  RET NZ
  RST CHRGTB
  JP Z,SN_ERR
  CP $31
  JR Z,L1ADB_16
  CP $32
  JP NZ,FC_ERR
L1ADB_16:
  LD D,A
  RST CHRGTB
  JP Z,SN_ERR

; Routine at 7074
L1BA2:
  RST SYNCHR

; Data block at 7075
L1BA3:
  DEFB $29

; Routine at 7076
L1BA4:
  PUSH HL
  LD HL,CASCOM
  RES 2,(HL)
  LD A,D
  AND $01
  JR NZ,L1BA4_0
  SET 2,(HL)
L1BA4_0:
  POP HL
  RET
; This entry point is used by the routine at L1A50.
L1BA4_1:
  XOR A
  LD (FILNAM),A
  DEC HL
  RST CHRGTB
  RET Z
; This entry point is used by the routine at __CSAVE.
L1BA4_2:
  CALL L1CC0_17
  PUSH HL
  LD B,C
  LD C,$06
  LD HL,FILNAM
L1BA4_3:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  DEC C
  JR Z,L1BA4_4
  DJNZ L1BA4_3
  LD (HL),$00
L1BA4_4:
  POP HL
  RET

; Routine at 7121
;
; Used by the routine at L1A50.
CLOAD_HEADER:
  LD B,10
CLOAD_HEADER_0:
  CALL L1CC0_56
  RET C
  SUB $D3
  JR NZ,CLOAD_HEADER
  DJNZ CLOAD_HEADER_0
  LD HL,$4818
  LD B,$16
CLOAD_HEADER_1:
  CALL L1CC0_56
  RET C
  LD (HL),A
  INC HL
  DJNZ CLOAD_HEADER_1
  RET
; This entry point is used by the routine at L1A50.
CLOAD_HEADER_2:
  LD BC,FILNAM
  LD E,$06
CLOAD_HEADER_3:
  LD A,(BC)
  OR A
  RET Z
  LD A,(BC)
  CP (HL)
  INC HL
  INC BC
  RET NZ
  DEC E
  JR NZ,CLOAD_HEADER_3
  RET

; Routine at 7164
;
; Used by the routine at L1A50.
PRINT_FNAME_MSG:
  PUSH DE
  PUSH AF
  LD A,(CASCOM)
  BIT 0,A
  JR NZ,PRINT_FNAME_MSG_2
  CALL PRS
  LD HL,FILNM2
  LD B,$06
PRINT_FNAME_MSG_0:
  LD A,(HL)
  OR A
  JR Z,PRINT_FNAME_MSG_1
  INC HL
  RST $18
  DJNZ PRINT_FNAME_MSG_0
PRINT_FNAME_MSG_1:
  CALL OUTDO_CRLF
  LD A,$01
  EI
  LD (IX+$00),A
  HALT
  DI
PRINT_FNAME_MSG_2:
  POP AF
  POP DE
  RET
; This entry point is used by the routine at L1ADB.
PRINT_FNAME_MSG_3:
  LD DE,(TXTTAB)
PRINT_FNAME_MSG_4:
  LD H,D
  LD L,E
  LD A,(HL)
  INC HL
  OR (HL)
  INC HL
  RET Z
PRINT_FNAME_MSG_5:
  INC HL
  INC HL
PRINT_FNAME_MSG_6:
  LD A,(HL)
  INC HL
  CP $0E
  JR Z,PRINT_FNAME_MSG_5
  OR A
  JR NZ,PRINT_FNAME_MSG_6
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JR PRINT_FNAME_MSG_4
; This entry point is used by the routine at __CSAVE.
PRINT_FNAME_MSG_7:
  INC HL
  LD B,$03
  JP INLPNM_0
; This entry point is used by the routine at __CSAVE.
PRINT_FNAME_MSG_8:
  PUSH HL
  LD HL,$4817
  XOR A
  LD B,$09
PRINT_FNAME_MSG_9:
  LD (HL),A
  INC HL
  DJNZ PRINT_FNAME_MSG_9
  LD A,($4889)
  LD ($481D),A
  LD A,(FILETAB)
  CP ' '
  JR NZ,PRINT_FNAME_MSG_11
  LD HL,(TXTTAB)
  LD ($4820),HL
  EX DE,HL
  LD HL,(VARTAB)
  OR A
  SBC HL,DE
; This entry point is used by the routine at L1C82.
PRINT_FNAME_MSG_10:
  LD ($4822),HL
  JR L1C82_4
PRINT_FNAME_MSG_11:
  CP $4D
  JR NZ,L1C82_0
  POP HL

; Routine at 7284
L1C74:
  RST SYNCHR

; Data block at 7285
L1C75:
  DEFB ','

; Routine at 7286
L1C76:
  CALL GETNUM
  CALL CONIS
  LD ($4820),DE

; Routine at 7296
L1C80:
  RST SYNCHR

; Data block at 7297
L1C81:
  DEFB ','

; Routine at 7298
L1C82:
  CALL GETNUM
  CALL CONIS
  PUSH HL
  EX DE,HL
  JR PRINT_FNAME_MSG_10
; This entry point is used by the routine at PRINT_FNAME_MSG.
L1C82_0:
  CP $53
  JR NZ,L1C82_2
  LD HL,SCREEN
  LD ($4820),HL
  LD HL,DOEBIT
L1C82_1:
  LD ($4822),HL
  JR L1CC0_1
L1C82_2:
  POP HL
  CP $BB
  JR NZ,L1C82_3
  CALL L1CC0_16
  PUSH HL
  LD ($4820),BC
  EX DE,HL
  JR L1C82_1
L1C82_3:
  CALL L1CC0_17
  LD ($4820),DE
  LD ($4822),BC
  RET
; This entry point is used by the routine at PRINT_FNAME_MSG.
L1C82_4:
  POP HL
  DEC HL
  RST CHRGTB
  RET Z

; Routine at 7358
L1CBE:
  RST SYNCHR

; Data block at 7359
L1CBF:
  DEFB ','

; Routine at 7360
L1CC0:
  LD DE,$4818
  LD B,$05
L1CC0_0:
  PUSH HL
; This entry point is used by the routine at L1C82.
L1CC0_1:
  POP HL
  RET Z
  JP NC,SN_ERR
  LD (DE),A
  INC DE
  RST CHRGTB
  DJNZ L1CC0_0
  RET
; This entry point is used by the routine at L1A50.
L1CC0_2:
  XOR A
  LD C,A
  DEC HL
  RST CHRGTB
  LD DE,KBUF
  LD (DE),A
  JR Z,L1CC0_4
  CP ','
  JR NZ,L1CC0_5
  LD B,$05
L1CC0_3:
  RST CHRGTB
  JR Z,L1CC0_4
  JP NC,SN_ERR
  LD (DE),A
  INC DE
  DJNZ L1CC0_3
L1CC0_4:
  LD (CONTXT),HL
  LD A,C
  LD ($4817),A
  RET
L1CC0_5:
  PUSH HL
  INC HL
  LD A,(HL)
  CP $24
  JR Z,L1CC0_6
  INC HL
  LD A,(HL)
  CP $24
L1CC0_6:
  POP HL
  PUSH HL
  PUSH BC
  JR NZ,L1CC0_8
  LD A,($4817)
  CP $BB
  JR Z,L1CC0_8
  CALL L1CC0_17
  POP BC
  DEC C
L1CC0_7:
  POP HL
  JR L1CC0_4
L1CC0_8:
  CALL L1CC0_16
  POP BC
  INC C
  JR L1CC0_7
; This entry point is used by the routine at L1A50.
L1CC0_9:
  LD A,($4818)
  CP ' '
  JR NZ,L1CC0_11
  LD A,(FILETAB)
  CP $41
  JR NZ,L1CC0_10
  LD HL,(VARTAB)
  DEC HL
  DEC HL
  RET
L1CC0_10:
  LD HL,(TXTTAB)
  RET
L1CC0_11:
  CP $4D
  JR NZ,L1CC0_12
  LD HL,($4828)
  RET
L1CC0_12:
  CP $53
  JR NZ,L1CC0_13
  LD HL,SCREEN
  RET
L1CC0_13:
  LD HL,(CONTXT)
  CP $BB
  JR NZ,L1CC0_15
  LD A,($4817)
  DEC A
  JR NZ,DIOERR
  CALL L1CC0_16
  PUSH BC
L1CC0_14:
  LD (CONTXT),HL
  LD HL,($482A)
  RST DCOMPR
  POP HL
  RET C
  RET Z
  LD HL,(CONTXT)
  CALL TAPIOF
  JP OV_ERR
L1CC0_15:
  LD A,($4817)
  INC A
  JR NZ,DIOERR
  CALL L1CC0_17
  PUSH DE
  LD D,B
  LD E,C
  JR L1CC0_14
DIOERR:
  CALL TAPIOF
  JP TM_ERR
; This entry point is used by the routine at L1C82.
L1CC0_16:
  LD A,$01
  LD (SUBFLG),A
  CALL GETVAR
  JP NZ,FC_ERR
  LD (SUBFLG),A
  RET
; This entry point is used by the routines at L1BA4 and L1C82.
L1CC0_17:
  CALL EVAL
  PUSH HL
  CALL __ASC_0
  DEC HL
  DEC HL
  DEC HL
  LD B,$00
  LD C,(HL)
  POP HL
  RET
; This entry point is used by the routines at __SAVE and INLPNM.
L1CC0_18:
  OR $80
  PUSH HL
  LD HL,($4820)
  LD (HL),A
  INC HL
  CP $83
  JR Z,L1CC0_20
  XOR A
  LD (PRTFLG),A
  CALL ENFMEM
  LD A,$FF
  LD (PRTFLG),A
  PUSH DE
  LD DE,(RETADR)
  LD A,D
  OR E
  JR Z,L1CC0_19
  XOR A
  SBC HL,DE
  PUSH HL
  LD HL,(TXTTAB)
  LD (RETADR),HL
  EX DE,HL
  POP BC
  LDIR
  PUSH DE
  SBC HL,DE
  EX DE,HL
  LD HL,(VARTAB)
  SBC HL,DE
  LD (VARTAB),HL
  POP HL
L1CC0_19:
  POP DE
L1CC0_20:
  LD ($4820),HL
  DEC HL
  LD A,(HL)
  LD HL,$4824
  XOR (HL)
  LD (HL),A
  POP HL
  RET
; This entry point is used by the routine at __SAVE.
L1CC0_21:
  LD HL,($4820)
  LD (HL),A
  INC HL
  LD DE,(VARTAB)
  XOR A
  SBC HL,DE
  PUSH HL
  DEC A
  CALL INLPNM_5
  POP BC
  RET C
L1CC0_22:
  LD A,(DE)
  INC DE
  DEC BC
  CALL CASOUT
  RET C
  LD A,B
  OR C
  JR NZ,L1CC0_22
  DEC A
  JP INLPNM_7
; This entry point is used by the routine at __LOAD.
L1CC0_23:
  LD HL,(VARTAB)
  LD BC,$0014
  ADD HL,BC
  LD ($4828),HL
  LD D,H
  LD E,L
  INC DE
  LD C,$00
L1CC0_24:
  AND $7F
  LD (HL),A
  CP $03
  JR Z,L1CC0_33
  LD A,$02
  XOR (IX+$03)
  LD (IX+$03),A
  OUT ($CF),A
  CALL L1CC0_52
  JR NC,L1CC0_32
  INC HL
  CALL L1CC0_56
  RET C
  PUSH AF
  CP $8D
  JR NZ,L1CC0_26
  PUSH HL
  PUSH DE
  EX DE,HL
  CALL ATOH
  LD B,D
  LD C,E
  LD A,$8D
  POP DE
L1CC0_25:
  LD HL,AUTORUN
  XOR (HL)
  LD (HL),A
  POP HL
  POP AF
  JR L1CC0_24
L1CC0_26:
  LD A,B
  OR C
  JR Z,L1CC0_29
  PUSH HL
  XOR A
  LD HL,(TMPSOUND)
  SBC HL,BC
  JR C,L1CC0_27
  LD HL,(TEMP)
  SBC HL,BC
  JR C,L1CC0_31
  JR Z,L1CC0_31
L1CC0_27:
  POP HL
L1CC0_28:
  LD H,D
  LD L,E
  LD BC,$0000
L1CC0_29:
  POP AF
L1CC0_30:
  PUSH AF
  PUSH HL
  JR L1CC0_25
L1CC0_31:
  POP HL
  EX DE,HL
  JR L1CC0_28
L1CC0_32:
  CALL L1CC0_56
  JR NC,L1CC0_30
  RET
L1CC0_33:
  CALL L1CC0_56
  RET C
  PUSH HL
  LD HL,AUTORUN
  SUB (HL)
  CALL L1CC0_51
  POP HL
  CALL L1CC0_52
  JR NC,L1CC0_34
  XOR A
  RET
L1CC0_34:
  EX DE,HL
  LD A,$03
  LD (HL),A
  RET
; This entry point is used by the routine at SHIFT_STOP.
L1CC0_35:
  LD DE,($4828)
  INC DE
  LD A,(DE)
  LD ($4828),DE
  CP $03
  RET NZ
  XOR A
  LD (GETFLG),A
  JP __CLOAD_OK
  LD E,A
  LD H,A
  DEC HL
  INC SP
  RRCA
  DEC HL
  INC SP
  LD DE,$1F19
; This entry point is used by the routine at __SAVE.
L1CC0_36:
  LD HL,CASCOM
  RES 7,(HL)
  LD A,(HL)
  BIT 1,A
  RET NZ
  LD HL,$1E9D
  LD DE,AUTORUN
  LD BC,$0005
  BIT 2,A
  JR Z,L1CC0_37
  ADD HL,BC
L1CC0_37:
  LDIR
  RET
; This entry point is used by the routine at __CSAVE.
CSAVE_HEADER:
  CALL L1CC0_36
  LD DE,($4820)
  LD BC,($4822)
  XOR A
  LD H,A
  LD L,A
CSAVE_HEADER_0:
  LD A,(DE)
  ADD A,L
  LD L,A
  LD A,$00
  ADC A,H
  LD H,A
  INC DE
  DEC BC
  LD A,B
  OR C
  JR NZ,CSAVE_HEADER_0
  LD ($4824),HL
  DEC A
  CALL INLPNM_5
  RET C
  LD B,10
CSAVE_HEADER_1:
  LD A,$D3			; BASIC PROGRAM header mode (TK_NAME)
  CALL CASOUT
  RET C
  DJNZ CSAVE_HEADER_1
  LD B,$16
  LD HL,FILETAB
CSAVE_HEADER_2:
  LD A,(HL)
  INC HL
  CALL CASOUT
  RET C
  DJNZ CSAVE_HEADER_2
  RET
; This entry point is used by the routine at __CSAVE.
L1CC0_42:
  XOR A
  CALL INLPNM_5
  RET C
  LD B,$0A
L1CC0_43:
  LD A,$D6
  CALL CASOUT
  RET C
  DJNZ L1CC0_43
  LD DE,($4820)
  LD BC,($4822)
L1CC0_44:
  LD A,(DE)
  INC DE
  DEC BC
  CALL CASOUT
  RET C
  LD A,B
  OR C
  JR NZ,L1CC0_44
  LD B,$0A
L1CC0_45:
  XOR A
  CALL CASOUT
  RET C
  DJNZ L1CC0_45
  RET
; This entry point is used by the routine at L1A50.
L1CC0_46:
  PUSH HL
  PUSH AF
  CALL INLPNM_19
  JP C,L1CC0_55
  LD A,($4825)
  LD HL,$4889
  OR (HL)
  LD (HL),A
  POP AF
  POP HL
  LD D,A
L1CC0_47:
  LD B,$0A
L1CC0_48:
  CALL L1CC0_56
  RET C
  SUB $D6
  JR NZ,L1CC0_47
  DJNZ L1CC0_48
  LD BC,($482A)
L1CC0_49:
  CALL L1CC0_56
  RET C
  LD E,A
  PUSH HL
  LD HL,(AUTORUN)
  OR A
  ADD A,L
  LD L,A
  LD A,$00
  ADC A,H
  LD H,A
  LD (AUTORUN),HL
  POP HL
  LD A,E
  SUB (HL)
  AND D
  JR Z,$1F6D
  LD A,(CASCOM)
  SET 5,A
  LD (CASCOM),A
  LD A,$73
  LD A,$06
  XOR (IX+$03)
  LD (IX+$03),A
  OUT ($CF),A
  LD A,($4818)
  CP ' '
  JR NZ,L1CC0_50
  CALL L1CC0_52
  RET NC
L1CC0_50:
  INC HL
  DEC BC
  LD A,B
  OR C
  JR NZ,L1CC0_49
  LD C,D
  PUSH HL
  LD HL,(AUTORUN)
  LD DE,(L482C)
  RST DCOMPR
  POP HL
L1CC0_51:
  RET Z
  LD HL,CASCOM
  SET 6,(HL)
  XOR A
  RET
L1CC0_52:
  PUSH HL
  LD A,$A0
  SUB L
  LD L,A
  LD A,$FF
  SBC A,H
  LD H,A
  JR C,L1CC0_53
  ADD HL,SP
  POP HL
  RET C
  PUSH HL
L1CC0_53:
  POP HL
  XOR A
  DEC A
  RET
CASOUT:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL INLPNM_10
  POP BC
L1CC0_55:
  POP DE
  POP HL
  RET
; This entry point is used by the routines at __LOAD, L1A50 and CLOAD_HEADER.
L1CC0_56:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL INLPNM_25
  POP BC
  POP DE
  POP HL
  RET
; This entry point is used by the routines at __LOAD and L1ADB.
TAPIOF:
  CALL _TAPIOF
  LD A,(MULVAL)
  LD (IX+$03),A
  RET
; This entry point is used by the routines at __LOAD and L1A50.
L1CC0_57:
  LD A,(IX+$03)
  LD (MULVAL),A
  RES 6,(IX+$03)
  LD A,$01
  LD (IX+$00),A
  HALT
  RET
; This entry point is used by the routines at __LOAD and L1A50.
L1CC0_58:
  LD A,$28
  OUT ($8F),A
  LD A,$82
  OUT ($CF),A
  LD A,$29
  OUT ($8F),A
  LD A,(IX+$03)
  AND $F8
  OR E
  OUT ($CF),A
  RET
; This entry point is used by the routine at JOY_FIRE_F2.
L1CC0_59:
  IN A,($08)
  CPL
  AND $30
  RRCA
  RRCA
  RRCA
  RRCA
  LD B,A
  RET

; Data block at 8190
L1FFE:
  DEFB $FF,$FF

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
  DEFW __ON
  DEFW __LPRINT
  DEFW __DEF
  DEFW __POKE
  DEFW __PRINT
  DEFW __CONT
  DEFW __LIST
  DEFW __LLIST
  DEFW __CLEAR
  DEFW __RENUM
  DEFW __AUTO
  DEFW __LOAD
  DEFW __SAVE
  DEFW __CLOAD
  DEFW __CSAVE
  DEFW __CALL
  DEFW __INIT
  DEFW __SOUND
  DEFW __PLAY
  DEFW __TX
  DEFW __GR
  DEFW __SCREEN
  DEFW __DISPLAY
  DEFW __STORE
  DEFW __SCROLL
  DEFW __PAGE
  DEFW __DELIM
  DEFW __SETE
  DEFW __ET
  DEFW __EG
  DEFW __CURSOR
  DEFW __DISK
  DEFW __MODEM
  DEFW __NEW

; Extra jump table for functions
FNCTAB_FN:
  DEFW __SGN
  DEFW __INT
  DEFW __ABS
  DEFW __USR
  DEFW __FRE
  DEFW __LPOS
  DEFW __POS
  DEFW __SQR
  DEFW __RND
  DEFW __LOG
  DEFW __EXP
  DEFW __COS
  DEFW __SIN
  DEFW __TAN
  DEFW __ATN
  DEFW __PEEK
  DEFW __LEN
  DEFW __STR_S
  DEFW __VAL
  DEFW __ASC
  DEFW __STICKX
  DEFW __STICKY
  DEFW __ACTION
  DEFW __KEY
  DEFW __LPEN
  DEFW __CHR_S
  DEFW __LEFT_S
  DEFW __RIGHT_S
  DEFW __MID_S

; BASIC keyword list
WORDS:
  DEFB $C5
  DEFM "ND"
  DEFB $C6
  DEFM "OR"
  DEFB $CE
  DEFM "EXT"
  DEFB $C4
  DEFM "ATA"
  DEFB $C9
  DEFM "NPUT"
  DEFB $C4
  DEFM "IM"
  DEFB $D2
  DEFM "EAD"
  DEFB $CC
  DEFM "ET"
  DEFB $C7
  DEFM "OTO"
  DEFB $D2
  DEFM "UN"
  DEFB $C9
  DEFM "F"
  DEFB $D2
  DEFM "ESTORE"
  DEFB $C7
  DEFM "OSUB"
  DEFB $D2
  DEFM "ETURN"
  DEFB $D2
  DEFM "EM"
  DEFB $D3
  DEFM "TOP"
  DEFB $CF
  DEFM "N"
  DEFB $CC
  DEFM "PRINT"
  DEFB $C4
  DEFM "EF"
  DEFB $D0
  DEFM "OKE"
  DEFB $D0
  DEFM "RINT"
  DEFB $C3
  DEFM "ONT"
  DEFB $CC
  DEFM "IST"
  DEFB $CC
  DEFM "LIST"
  DEFB $C3
  DEFM "LEAR"
  DEFB $D2
  DEFM "ENUM"
  DEFB $C1
  DEFM "UTO"
  DEFB $CC
  DEFM "OAD"
  DEFB $D3
  DEFM "AVE"
  DEFB $C3
  DEFM "LOAD"
  DEFB $C3
  DEFM "SAVE"
  DEFB $C3
  DEFM "ALL"
  DEFB $C9
  DEFM "NIT"
  DEFB $D3
  DEFM "OUND"
  DEFB $D0
  DEFM "LAY"
  DEFB $D4
  DEFM "X"
  DEFB $C7
  DEFM "R"
  DEFB $D3
  DEFM "CREEN"
  DEFB $C4
  DEFM "ISPLAY"
  DEFB $D3
  DEFM "TORE"
  DEFB $D3
  DEFM "CROLL"
  DEFB $D0
  DEFM "AGE"
  DEFB $C4
  DEFM "ELIM"
  DEFB $D3
  DEFM "ETE"
  DEFB $C5
  DEFM "T"
  DEFB $C5
  DEFM "G"
  DEFB $C3
  DEFM "URSOR"
  DEFB $C4
  DEFM "ISK"
  DEFB $CD
  DEFM "ODEM"
  DEFB $CE
  DEFM "EW"
  DEFB $D4
  DEFM "AB("
  DEFB $D4
  DEFM "O"
  DEFB $C6
  DEFM "N"
  DEFB $D3
  DEFM "PC("
  DEFB $D4
  DEFM "HEN"
  DEFB $CE
  DEFM "OT"
  DEFB $D3
  DEFM "TEP"
  DEFB $AB
  DEFB $AD
  DEFB $AA
  DEFB $AF
  DEFB $DE
  DEFB $C1
  DEFM "ND"
  DEFB $CF
  DEFM "R"
  DEFB $BE
  DEFB $BD
  DEFB $BC
  DEFB $D3
  DEFM "GN"
  DEFB $C9
  DEFM "NT"
  DEFB $C1
  DEFM "BS"
  DEFB $D5
  DEFM "SR"
  DEFB $C6
  DEFM "RE"
  DEFB $CC
  DEFM "POS"
  DEFB $D0
  DEFM "OS"
  DEFB $D3
  DEFM "QR"
  DEFB $D2
  DEFM "ND"
  DEFB $CC
  DEFM "OG"
  DEFB $C5
  DEFM "XP"
  DEFB $C3
  DEFM "OS"
  DEFB $D3
  DEFM "IN"
  DEFB $D4
  DEFM "AN"
  DEFB $C1
  DEFM "TN"
  DEFB $D0
  DEFM "EEK"
  DEFB $CC
  DEFM "EN"
  DEFB $D3
  DEFM "TR$"
  DEFB $D6
  DEFM "AL"
  DEFB $C1
  DEFM "SC"
  DEFB $D3
  DEFM "TICKX"
  DEFB $D3
  DEFM "TICKY"
  DEFB $C1
  DEFM "CTION"
  DEFB $CB
  DEFM "EY"
  DEFB $CC
  DEFM "PEN"
  DEFB $C3
  DEFM "HR$"
  DEFB $CC
  DEFM "EFT$"
  DEFB $D2
  DEFM "IGHT$"
  DEFB $CD
  DEFM "ID$"
  DEFB $80

; ARITHMETIC PRECEDENCE TABLE
PRITAB:
  DEFB $79,$05,$07,$79,$0B,$03,$7C,$78
  DEFB $04,$7C,$DC,$04,$7F,$26,$08,$50
  DEFB $78,$29,$46,$77,$29

; label=NULL_STRING
NULL_STRING:
  DEFB $00

; Message at 8724
OK_MSG:
  DEFM "Ok!"
  DEFB $03
  DEFB $00

; Routine at 8729
;
; Used by the routines at __RETURN and __NEXT.
BAKSTK:
  LD HL,VERSION
  ADD HL,SP
; This entry point is used by the routine at __FOR.
LOKFOR:
  LD A,(HL)
  INC HL
  CP $81
  RET NZ
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH HL
  LD H,B
  LD L,C
  RST DCOMPR
  LD BC,$000D
  POP HL
  RET Z
  ADD HL,BC
  JR LOKFOR

; 'SN err' entry for Input STMT
;
; Used by the routine at NEXITM.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?Syntax ERROR'
;
; Used by the routines at SYNCHR, MUSIC, __SETE, __CURSOR, __CALL, L1ADB,
; L1CC0, L24BD, STKTHS, L2A38, L2FB1, OCTCNS, L3077, __AUTO, L3184, __LIST and
; GETVAR.
SN_ERR:
  LD E,$02

; "LD BC,nn" to jump over the next word without executing it
L223A:
  DEFB $01

; "?Division by zero ERROR"
;
; Used by the routines at FDIV and POWER.
O_ERR:
  LD E,$14
  LD BC,$001E

; "LD BC,nn" to jump over the next word without executing it
L2240:
  DEFB $01

; '?DD ERROR', "Redimensioned array"
;
; Used by the routine at FNDARY.
DD_ERR:
  LD E,$12

; Data block at 8771
L2243:
  DEFB $01

; "?Undefined user function ERROR"
;
; Used by the routine at L2A38.
UF_ERR:
  LD E,$22

; "LD BC,nn" to jump over the next word without executing it
L2246:
  DEFB $01

; Overflow error
;
; Used by the routines at FADD, FDIV, RESDIV, MLSP10, RESZER and L1CC0.
OV_ERR:
  LD E,$0A

; "LD BC,nn" to jump over the next word without executing it
L2249:
  DEFB $01

; '?MO ERROR', "Missing Operand"
;
; Used by the routines at MUSIC, FNDWRD and OPRND.
MO_ERR:
  LD E,$24

; "LD BC,nn" to jump over the next word without executing it
L224C:
  DEFB $01

; '?TM ERROR', "Type mismatch"
;
; Used by the routines at L1CC0 and TSTSTR.
TM_ERR:
  LD E,$18

; Data block at 8783
L224F:
  DEFB $01

; '?Undefined ERROR'
UNDEFINED_ERR:
  LD E,$28

; Routine at 8786
;
; Used by the routines at L1ADB, FC_ERR, UL_ERR, __RETURN, FDTLP, L2A38,
; ENFMEM, __CONT, TSTOPL, TESTOS, CONCAT and BS_ERR.
ERROR:
  CALL CLREG
  CALL CONSOLE_CRLF
  LD HL,ERRMSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,ERROR_0
  LD HL,ERRMSG
ERROR_0:
  INC E
  INC E
  RES 0,E
  LD A,$2B
  CP E
  JR NC,ERROR_1
  LD E,$2A
ERROR_1:
  LD A,(HL)
  INC HL
  OR A
  JR NZ,ERROR_1
  DEC E
  DEC E
  JR NZ,ERROR_1
; This entry point is used by the routine at INPBRK.
_ERROR_REPORT:
  CALL PRS
  LD HL,(CURLIN)
  LD DE,$FFFE
  RST DCOMPR
  JP Z,_STARTUP
  LD A,H
  AND L
  INC A
  CALL NZ,IN_PRT

; "LD A,n" to Mask the next byte
L228B:
  DEFB $3E

; Routine at 8844
;
; Used by the routines at L1ADB and __LIST.
RESTART:
  POP BC

; Routine at 8845
;
; Used by the routines at INIT_BEL and INPBRK.
READY:
  CALL FINLPT
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  CALL PRS

; Routine at 8857
;
; Used by the routine at L3184.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL
  LD A,(AUTFLG)
  OR A
  JR Z,PROMPT_2
  LD HL,(AUTLIN)
  JP PROMPT_B
; This entry point is used by the routine at SHIFT_STOP.
PROMPT_0:
  LD A,$20
; This entry point is used by the routine at SHIFT_STOP.
PROMPT_1:
  RST $18
PROMPT_2:
  CALL SHIFT_STOP_1
  JR C,PROMPT_2
  RST CHRGTB
  INC A
  DEC A
  JR Z,PROMPT
  PUSH AF
  LD A,($4889)
  OR A
  JP NZ,$0000
  CALL ATOH
  PUSH DE
  CALL TOKENIZE
  LD B,A
  POP DE
  POP AF
  JP NC,EXEC
  PUSH DE
  PUSH BC
  PUSH HL
  LD HL,(AUTINC)
  ADD HL,DE
  JP SHIFT_STOP_21
; This entry point is used by the routine at SHIFT_STOP.
AUTSTR:
  POP HL
  RST CHRGTB
  OR A
  PUSH AF
  CALL SRCHLN
  JR C,LINFND
  POP AF
  PUSH AF
  JP Z,PROMPT
  OR A
LINFND:
  PUSH BC
  JR NC,PROMPT_4
  EX DE,HL
  LD HL,(VARTAB)
PROMPT_3:
  LD A,(DE)
  LD (BC),A
  INC BC
  INC DE
  RST DCOMPR
  JR NZ,PROMPT_3
  LD H,B
  LD L,C
  LD (VARTAB),HL
PROMPT_4:
  POP DE
  POP AF
  JR Z,FINI
  LD HL,(VARTAB)
  EX (SP),HL
  POP BC
  ADD HL,BC
  PUSH HL
  CALL MOVUP
  POP HL
  LD (VARTAB),HL
  EX DE,HL
  LD (HL),H
  POP DE
  INC HL
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  LD HL,KBUF
MOVBUF:
  LD A,(HL)
  LDI
  CP $0E
  JR NZ,PROMPT_5
  LDI
  LDI
  JR MOVBUF
PROMPT_5:
  OR A
  JR NZ,MOVBUF
; This entry point is used by the routine at L1ADB.
FINI:
  CALL RUN_FST
  INC HL
  EX DE,HL
PROMPT_6:
  LD H,D
  LD L,E
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,PROMPT
  INC HL
PROMPT_7:
  INC HL
  INC HL
PROMPT_8:
  LD A,(HL)
  INC HL
  CP $0E
  JR Z,PROMPT_7
  OR A
  JR NZ,PROMPT_8
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JR PROMPT_6
; This entry point is used by the routines at __GOTO, T_EDIT, __RESTORE, L3077,
; SCCPTR, __LIST, SHIFT_STOP and __NEW.
SRCHLN:
  LD BC,$0000
  LD HL,(TXTTAB)

; This entry point is used by the routine at RUNLIN.
;
; Used by the routine at __GOTO.
SRCHLP:
  LD (PRELIN),BC
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
  RST DCOMPR
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
  JR SRCHLP

; TOKENIZE (CRUNCH) ALL "RESERVED" WORDS ARE TRANSLATED INTO SINGLE ONE OR TWO
; (IF TWO, FIRST IS ALWAYS $FF, 377 OCTAL) BYTES WITH THE MSB ON.
;
; Used by the routine at PROMPT.
TOKENIZE:
  XOR A
  LD (DORES),A
  LD C,$05
  LD DE,KBUF
; This entry point is used by the routine at FNDWRD.
TOKENIZE_0:
  LD A,(HL)
  CP ' '
  JP Z,MOVDIR
  LD B,A
  CP '"'
  JP Z,FNDWRD_17
  OR A
  JP Z,FNDWRD_18
  LD A,(DORES)
  OR A
  LD A,(HL)
  JP NZ,MOVDIR
  CP '?'                  ;A QMARK?  (Is it "?" short for PRINT)
  LD A,TK_PRINT           ; "PRINT" token
  JP Z,MOVDIR             ;THEN USE A "PRINT" TOKEN
  LD A,(HL)
  CP $10
  LD A,$AF
  JP Z,MOVDIR
  LD A,(HL)
  CP '0'
  JR C,FNDWRD
  CP $3C
  JP C,MOVDIR

; label
;
; Used by the routine at TOKENIZE.
FNDWRD:
  PUSH DE
  LD DE,$209D
  PUSH BC
  LD BC,$244B
  PUSH BC
  LD B,$7F
  LD A,(HL)
  CP $61
  JR C,FNDWRD_0
  CP $7B
  JR NC,FNDWRD_0
  AND $5F
  LD (HL),A
FNDWRD_0:
  LD C,(HL)
  EX DE,HL
FNDWRD_1:
  INC HL
  OR (HL)
  JP P,FNDWRD_1
  INC B
  LD A,(HL)
  AND $7F
  RET Z
  CP C
  JR NZ,FNDWRD_1
  EX DE,HL
  PUSH HL
FNDWRD_2:
  INC DE
  LD A,(DE)
  OR A
  JP M,FNDWRD_6
  LD C,A
  LD A,B
  CP $8C
  JR Z,FNDWRD_3
  CP $88
  JR NZ,FNDWRD_4
FNDWRD_3:
  RST CHRGTB
  DEC HL
FNDWRD_4:
  INC HL
  LD A,(HL)
  CP $61
  JR C,FNDWRD_5
  AND $5F
FNDWRD_5:
  CP C
  JR Z,FNDWRD_2
  POP HL
  JR FNDWRD_0
FNDWRD_6:
  LD C,B
  POP AF
  POP AF
  LD A,C
  CP $88
  JR Z,FNDWRD_7
  CP $8C
  JR Z,FNDWRD_7
  CP $8B
  JR Z,FNDWRD_7
  CP $B6
  JR NZ,FNDWRD_12
FNDWRD_7:
  PUSH HL
  RST CHRGTB
  POP HL
  JR NC,FNDWRD_12
  EX DE,HL
  POP IY
  POP HL
FNDWRD_8:
  LD (HL),C
  INC DE
  PUSH DE
  EXX
  POP HL
  PUSH HL
  CALL ATOH
  LD A,E
  OR D
  JR Z,FNDWRD_10
  POP BC
  LD A,E
  DEC HL
  PUSH HL
  EXX
  POP DE
  INC HL
  LD (HL),$0E
  INC HL
  LD (HL),A
  INC HL
  EXX
  LD A,D
  EXX
  LD C,A
  INC IY
  INC IY
  INC IY
FNDWRD_9:
  RST DCOMPR
  JP NC,MO_ERR
  EX DE,HL
  PUSH HL
  RST CHRGTB
  EX DE,HL
  CP ','
  JR NZ,FNDWRD_11
  LD (HL),C
  INC HL
  INC IY
  LD C,$2C
  POP AF
  JR FNDWRD_8
FNDWRD_10:
  EXX
  POP DE
  DEC DE
  JR FNDWRD_9
FNDWRD_11:
  POP DE
  PUSH HL
  PUSH IY
  EX DE,HL
FNDWRD_12:
  LD A,C
  POP BC
  POP DE
; This entry point is used by the routine at TOKENIZE.
MOVDIR:
  INC HL
  LD (DE),A
  INC DE
  INC C
  SUB $3A
  JR Z,FNDWRD_14
  CP $49
  JR NZ,FNDWRD_15
FNDWRD_14:
  LD (DORES),A
FNDWRD_15:
  SUB $54
  JP NZ,TOKENIZE_0
  LD B,A
FNDWRD_16:
  LD A,(HL)
  OR A
  JR Z,FNDWRD_18
  CP B
  JR Z,MOVDIR
; This entry point is used by the routine at TOKENIZE.
FNDWRD_17:
  INC HL
  LD (DE),A
  INC C
  INC DE
  JR FNDWRD_16
; This entry point is used by the routine at TOKENIZE.
FNDWRD_18:
  LD HL,BUFMIN
  LD (DE),A
  INC DE
  LD (DE),A
  INC DE
  LD (DE),A
  RET

; Routine at 9338
__FOR:
  LD A,$64
  LD (SUBFLG),A
  CALL __LET
  POP BC
  PUSH HL
  CALL __DATA
  LD (ENDFOR),HL
  LD HL,$0002
  ADD HL,SP
FORSLP:
  CALL LOKFOR
  JR NZ,FORFND
  ADD HL,BC
  PUSH DE
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  INC HL
  INC HL
  PUSH HL
  LD HL,(ENDFOR)
  RST DCOMPR
  POP HL
  POP DE
  JR NZ,FORSLP
  POP DE
  LD SP,HL
  INC C
FORFND:
  POP DE
  EX DE,HL
  LD C,$08
  CALL CHKSTK
  PUSH HL
  LD HL,(ENDFOR)
  EX (SP),HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  CALL TSTNUM

; Routine at 9403
L24BB:
  RST SYNCHR

; Data block at 9404
L24BC:
  DEFB $B3

; Routine at 9405
L24BD:
  CALL GETNUM
  PUSH HL
  CALL BCDEFP
  POP HL
  PUSH BC
  PUSH DE
  LD BC,$8100
  LD D,C
  LD E,D
  LD A,(HL)
  CP $B8
  LD A,$01
  JR NZ,SAVSTP
  RST CHRGTB
  CALL GETNUM
  PUSH HL
  CALL BCDEFP
  RST VSIGN
  POP HL
SAVSTP:
  PUSH BC
  PUSH DE
  PUSH AF
  INC SP
  PUSH HL
  LD HL,(TEMP)
  EX (SP),HL
; This entry point is used by the routine at __NEXT.
PUTFID:
  LD B,$81
  PUSH BC
  INC SP
; This entry point is used by the routine at __NEXT.
NEWSTT:
  CALL ISCNTC
  LD (TEMP),HL
  LD A,(HL)
  CP $3A
  JR Z,EXEC
  OR A
  JP NZ,SN_ERR
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,ENDCON
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (CURLIN),HL
  EX DE,HL
; This entry point is used by the routine at PROMPT.
EXEC:
  RST CHRGTB
  LD DE,NEWSTT
  PUSH DE
; This entry point is used by the routine at L2683.
_ONJMP:
  RET Z
; This entry point is used by the routine at L2669.
ONJMP:
  SUB $80
  JP C,__LET
  CP $32
  JP NC,SN_ERR
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
; Used by the routine at DTSTR.
_CHRGTB:
  INC HL
  LD A,(HL)
  CP $3A
  RET NC
; This entry point is used by the routine at CHRGTB.
_CHRGTB_0:
  CP ' '
  JR Z,_CHRGTB
  JR NC,NOTLFT
  CP $0F
  JR NC,_CHRGTB_1
  CP $0D
  JR C,_CHRGTB_1
  PUSH HL
  INC HL
  INC HL
  INC HL
  LD (CONTXT),HL
  POP HL
_CHRGTB_1:
  OR A
  RET
NOTLFT:
  CP '0'
  CCF
  INC A
  DEC A
  RET
; This entry point is used by the routine at SCPTLP.
_CHRGTB_2:
  RST CHRGTB
; This entry point is used by the routine at __CLEAR.
INTIDX_0:
  CALL GETNUM

; Get integer variable to DE, error if negative
;
; Used by the routine at MAKINT.
DEPINT:
  RST VSIGN
  JP M,FC_ERR

; parameter acquisition on 2 bytes
;
; Used by the routines at __CONIS, __CALL, L1C76, L1C82, EVAL_VARIABLE, NOT, __PEEK,
; GETWORD and L2FB1.
CONIS:
  LD A,(FPEXP)
  CP $90
  JP C,QINT
  LD BC,$9080
  LD DE,$0000
  PUSH HL
  CALL FCOMP
  POP HL
  LD D,C
  RET Z

; Routine at 9575
;
; Used by the routines at __LOG, __SETE, ROM_RAMLOW, L1ADB, L1CC0, DEPINT,
; MAKINT, __CONT, L3077, __ASC, __MID_S and BS_ERR.
FC_ERR:
  LD E,$08
  JP ERROR

; ASCII to Integer, result in DE
;
; Used by the routines at L1CC0, PROMPT, FNDWRD, __GOTO, __RESTORE, __RENUM,
; L306F, L3077, __AUTO, L3184, __LIST and __NEW.
ATOH:
  DEC HL

; Routine at 9581
;
; Used by the routine at L2669.
ATOH2:
  RST CHRGTB
  CP $0E
  JR NZ,LINGT3
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  RST CHRGTB
  RET
LINGT3:
  DEC HL
  LD DE,$0000

; ASCII to Integer, result in DE
GTLNLP:
  RST CHRGTB
  RET NC
  PUSH HL
  PUSH AF
  LD HL,$1998
  RST DCOMPR
  JR C,POPHSR
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
  JR GTLNLP
POPHSR:
  POP AF
  POP HL
  RET

; Routine at 9626
;
; Used by the routine at L1ADB.
__RUN:
  RES 6,(IX+$03)
  JP Z,RUN_FST
  CALL _CLVAR
  LD BC,NEWSTT
  JR RUNLIN

; Routine at 9641
__GOSUB:
  LD C,$03
  CALL CHKSTK
  POP BC
  PUSH HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  LD A,$8C
  PUSH AF
  INC SP
; This entry point is used by the routine at __RUN.
RUNLIN:
  PUSH BC

; Routine at 9658
;
; Used by the routine at L2683.
__GOTO:
  CALL ATOH
  CALL __REM
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  RST DCOMPR
  POP HL
  CALL C,SRCHLP
  CALL NC,SRCHLN
  LD H,B
  LD L,C
  DEC HL
  RET C

; entry for '?UL ERROR'
;
; Used by the routine at __RESTORE.
UL_ERR:
  LD E,$0E
  JP ERROR

; Routine at 9686
__RETURN:
  RET NZ
  LD D,$FF
  CALL BAKSTK
  LD SP,HL
  CP $8C
  LD E,$04
  JP NZ,ERROR
  POP HL
  LD (CURLIN),HL
  INC HL
  LD A,H
  OR L
  JR NZ,__RETURN_0
__RETURN_0:
  LD HL,NEWSTT
  EX (SP),HL

; "LD A,n" to Mask the next byte
L25F1:
  DEFB $3E

; Routine at 9714
;
; Used by the routines at L2772 and GTVLUS.
NXTDTA:
  POP HL

; Data block at 9715
__DATA:
  DEFB $01,$3A

; Routine at 9717
;
; Used by the routines at __GOTO and L2683.
__REM:
  LD C,$00
  LD B,$00
__REM_0:
  LD A,C
  LD C,B
  LD B,A
__REM_1:
  LD A,(HL)
  CP $0E
  JR NZ,__REM_2
  INC HL
  INC HL
  INC HL
  LD A,(HL)
__REM_2:
  OR A
  RET Z
  CP B
  RET Z
  INC HL
  CP '"'
  JR Z,__REM_0
  JR __REM_1

; Routine at 9744
;
; Used by the routines at __FOR and L24BD.
__LET:
  CALL GETVAR

; Routine at 9747
L2613:
  RST SYNCHR

; Data block at 9748
L2614:
  DEFB $C1

; Routine at 9749
L2615:
  PUSH DE
  LD A,(VALTYP)
  PUSH AF
  CALL EVAL
  POP AF
  EX (SP),HL
  LD (TEMP),HL
  RRA
  CALL TSTSTR_0
  JR Z,LETNUM
; This entry point is used by the routine at ITMSEP.
__LET_1:
  PUSH HL
  LD HL,(FACCU)
  PUSH HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(TXTTAB)
  RST DCOMPR
  JR NC,__LET_5
  LD HL,(STREND)
  RST DCOMPR
  POP DE
  JR NC,DNTCPY
  LD HL,DSCTMP
  RST DCOMPR
  JR NC,DNTCPY

; Data block at 9797
__LET_4:
  DEFB $3E

; Routine at 9798
;
; Used by the routine at L2615.
__LET_5:
  POP DE
  CALL FRETMS
  EX DE,HL
  CALL STRCPY
; This entry point is used by the routine at L2615.
DNTCPY:
  CALL FRETMS
  POP HL
  CALL VMOVE
  POP HL
  RET
; This entry point is used by the routine at L2615.
LETNUM:
  PUSH HL
  CALL FPTHL
  POP DE
  POP HL
  RET

; Routine at 9822
__ON:
  CALL GETINT
  LD A,(HL)
  LD B,A
  CP $8C
  JR Z,ONGO

; Routine at 9831
L2667:
  RST SYNCHR

; Data block at 9832
L2668:
  DEFB $88

; Routine at 9833
L2669:
  DEC HL
; This entry point is used by the routine at __ON.
ONGO:
  LD C,E
ONGOLP:
  DEC C
  LD A,B
  JP Z,ONJMP
  CALL ATOH2
  CP ','
  RET NZ
  JP ONGOLP

; Routine at 9849
__IF:
  CALL EVAL
  LD A,(HL)
  CP $88
  JR Z,IFGO

; Routine at 9857
L2681:
  RST SYNCHR

; Data block at 9858
L2682:
  DEFB $B6

; Routine at 9859
L2683:
  DEC HL
; This entry point is used by the routine at __IF.
IFGO:
  CALL TSTNUM
  RST VSIGN
  JP Z,__REM
  RST CHRGTB
  CP $0E
  JP Z,__GOTO
  JP _ONJMP

; Routine at 9876
__LPRINT:
  LD A,$01
  LD (PRTFLG),A
; This entry point is used by the routine at __PRINT.
MRPRNT:
  DEC HL
  RST CHRGTB

; Routine at 9883
__PRINT:
  CALL PRTHK
  CALL Z,OUTDO_CRLF
; This entry point is used by the routine at NEXITM.
PRNTLP:
  JP Z,FINPRT
  CP $B2
  JR Z,__TAB
  CP $B5
  JR Z,__TAB
  PUSH HL
  CP ','
  JR Z,DOCOM
  CP $3B
  JP Z,NEXITM
  POP BC
  CALL EVAL
  PUSH HL
  LD A,(VALTYP)
  OR A
  JR NZ,PRNTST
  CALL NUMASC
  CALL CRTST
  LD (HL),' '
  LD HL,(FACCU)
  LD A,(PRTFLG)
  OR A
  JR Z,ISTTY
  LD A,(LPTPOS)
  ADD A,(HL)
  CP $84
  JR LINCH2
ISTTY:
  LD A,(LINLEN)
  LD B,A
  INC A
  JR Z,PRNTNB
  LD A,(CURPOS)
  ADD A,(HL)
  DEC A
  CP B
LINCH2:
  CALL NC,OUTDO_CRLF
PRNTNB:
  CALL PRS1
  XOR A
PRNTST:
  CALL NZ,PRS1
  POP HL
  JR MRPRNT
DOCOM:
  LD A,(PRTFLG)
  OR A
  JR Z,ISCTTY
  LD A,(LPTPOS)
  CP $75
  JR CHKCOM
ISCTTY:
  LD A,(CLMLST)
  LD B,A
  LD A,(CURPOS)
  DEC A
  CP B
CHKCOM:
  CALL NC,OUTDO_CRLF
  JR NC,NEXITM
ZONELP:
  SUB $0D
  JR NC,ZONELP
  CPL
  JR ASPCS

; __TAB(   &   __SPC(
;
; Used by the routine at __PRINT.
__TAB:
  PUSH AF
  CALL FNDNUM

; Routine at 10010
L271A:
  RST SYNCHR

; Data block at 10011
L271B:
  DEFB $29

; Routine at 10012
L271C:
  DEC HL
  POP AF
  SUB $B5
  PUSH HL
  JR Z,DOSPC
  LD A,(PRTFLG)
  OR A
  JR Z,TTYIST
  LD A,(LPTPOS)
  JR DOSPC
TTYIST:
  LD A,(CURPOS)
DOSPC:
  CPL
  ADD A,E
  JR NC,NEXITM
; This entry point is used by the routine at __PRINT.
ASPCS:
  INC A
  LD B,A
  LD A,$20
SPCLP:
  RST $18
  DJNZ SPCLP

; Routine at 10044
;
; Used by the routines at __PRINT and L271C.
NEXITM:
  POP HL
  RST CHRGTB
  JP PRNTLP
; This entry point is used by the routine at __PRINT.
FINPRT:
  XOR A
  LD (PRTFLG),A
  RET
; This entry point is used by the routine at INPBIN.
SCNSTR:
  LD A,(FLGINP)
  OR A
  JP NZ,DATSNR
  POP BC
  LD HL,REDO_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,NEXITM_0
  LD HL,REDO_MSG
NEXITM_0:
  CALL PRS
  JP GTMPRT

; Routine at 10080
__INPUT:
  CALL IDTEST
  CALL INPHK
  LD A,(HL)
  CP '"'
  LD A,$00
  JR NZ,$2777
  CALL QTSTR

; Routine at 10096
L2770:
  RST SYNCHR

; Data block at 10097
L2771:
  DEFB $3B

; Routine at 10098
L2772:
  PUSH HL
  CALL PRS1
  LD A,$E5
  CALL QINLIN
  JR NOTQTI
  NOP
  NOP
  NOP
; This entry point is used by the routine at QINLIN.
L2772_0:
  CALL SHIFT_STOP_0
  RES 6,(IX+$03)
  LD A,(PICFLG)
  RES 5,A
  RES 0,A
  LD (PICFLG),A
  RET
  NOP
NOTQTI:
  POP BC
  JP C,INPBRK
  INC HL
  LD A,(HL)
  OR A
  DEC HL
  PUSH BC
  JP Z,NXTDTA
  LD (HL),$2C
  JR INPCON

; Routine at 10147
__READ:
  PUSH HL
  LD HL,(DATPTR)

; OR AFh ..Flag "READ"
L27A7:
  DEFB $F6

; Routine at 10152
;
; Used by the routine at L2772.
INPCON:
  XOR A
  LD (FLGINP),A
  EX (SP),HL

; "LD BC,nn" to jump over the next word without executing it
L27AD:
  DEFB $01

; CHECK FOR COMMA AND GET ANOTHER VARIABLE TO FILL WITH DATA
;
; Used by the routine at INPBIN.
LOPDT2:
  RST SYNCHR

; Data block at 10159
L27AF:
  DEFB ','

; Routine at 10160
GTVLUS:
  CALL GETVAR
  EX (SP),HL
  PUSH DE
  LD A,(HL)
  CP ','
  JR Z,SCNVAL
  LD A,(FLGINP)
  OR A
  JP NZ,FDTLP
  LD A,$3F
  RST $18
  CALL QINLIN
  POP DE
  POP BC
  JP C,INPBRK
  INC HL
  LD A,(HL)
  DEC HL
  OR A
  PUSH BC
  JP Z,NXTDTA
  PUSH DE

; Routine at 10197
;
; Used by the routines at GTVLUS and FDTLP.
SCNVAL:
  LD A,(VALTYP)
  OR A
  JR Z,INPBIN
  RST CHRGTB
  LD D,A
  LD B,A
  CP '"'
  JR Z,STRENT
  LD A,(FLGINP)
  OR A
  LD D,A
  JR Z,ITMSEP
  LD D,$3A

; Item separator - ANSI USES [B]=44 AS A FLAG TO TRIGGER TRAILING SPACE
; SUPPRESSION
;
; Used by the routine at SCNVAL.
ITMSEP:
  LD B,$2C
  DEC HL
; This entry point is used by the routine at SCNVAL.
STRENT:
  CALL DTSTR
DOASIG:
  EX DE,HL
  LD HL,LTSTND
  EX (SP),HL
  PUSH DE
  JP __LET_1

; a.k.a. NUMINS
;
; Used by the routine at SCNVAL.
INPBIN:
  RST CHRGTB
  CALL H_ASCTFP
  EX (SP),HL
  CALL FPTHL
  POP HL
LTSTND:
  DEC HL
  RST CHRGTB
  JR Z,MORDT
  CP ','
  JP NZ,SCNSTR
MORDT:
  EX (SP),HL
  DEC HL
  RST CHRGTB
  JR NZ,LOPDT2
  POP DE
  LD A,(FLGINP)
  OR A
  EX DE,HL
  JP NZ,__RESTORE_1
  PUSH DE
  OR (HL)
  LD HL,EXTRA_MSG_FR
  PUSH AF
  LD A,(FRGFLG)
  OR A
  JR Z,INPBIN_0
  LD HL,EXTRA_MSG
INPBIN_0:
  POP AF
  CALL NZ,PRS
  POP HL
  RET

; Find next DATA statement
;
; Used by the routine at GTVLUS.
FDTLP:
  CALL __DATA
  OR A
  JR NZ,FANDT
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  LD E,$06
  JP Z,ERROR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD (DATLIN),DE
FANDT:
  RST CHRGTB
  CP $83
  JR NZ,FDTLP
  JR SCNVAL

; acquisition parameter sign on 2 bytes
;
; Used by the routines at _GETNUM, __CALL, L1C76, L1C82, L24BD, _CHRGTB, L2A38,
; GETINT and L2FB1.
GETNUM:
  CALL EVAL

; "OR n" to mask the next byte
TSTNUM:
  DEFB $F6

; Test a string, 'Type Error' if it is not
;
; Used by the routines at EVAL_VARIABLE, CONCAT and GETSTR.
TSTSTR:
  SCF
; This entry point is used by the routines at L2615 and FINREL_0.
TSTSTR_0:
  LD A,(VALTYP)
  ADC A,A
  OR A
  RET PE
  JP TM_ERR

; Routine at 10331
FRMEQL:
  RST SYNCHR

; Data block at 10332
L285C:
  DEFB $C1

; Routine at 10333
L285D:
  JR EVAL

; Routine at 10335
;
; Used by the routines at EVLPAR and EVAL_VARIABLE_1.
OPNPAR:
  RST SYNCHR

; Data block at 10336
L2860:
  DEFB $28

; Routine at 10337
;
; Used by the routines at __PLAY, L1CC0, L2615, __IF, __PRINT, GETNUM, L285D
; and GETWORD.
EVAL:
  DEC HL

; Routine at 10338
EVAL_0:
  LD D,$00

; Save precedence and eval until precedence break
;
; Used by the routines at STKTHS, MINUS and NOT.
EVAL_1:
  PUSH DE
  LD C,$01
  CALL CHKSTK
  CALL OPRND

; Evaluate expression until precedence break
EVAL2:
  LD (NXTOPR),HL

; Evaluate expression until precedence break
;
; Used by the routine at NOT.
EVAL3:
  LD HL,(NXTOPR)
  POP BC
  LD A,B
  CP $78
  CALL NC,TSTNUM
  LD A,(HL)
  LD (TEMP3),HL
  CP $B9
  RET C
  CP $C3
  RET NC
  CP $C0
  JR NC,DORELS
  SUB $B9
  LD E,A
  JR NZ,FOPRND
  LD A,(VALTYP)
  DEC A
  LD A,E
  JP Z,CONCAT
FOPRND:
  RLCA
  ADD A,E
  LD E,A
  LD HL,PRITAB
  LD D,$00
  ADD HL,DE
  LD A,B
  LD D,(HL)
  CP D
  RET NC
  INC HL
  CALL TSTNUM

; Stack expression item and get next one
;
; Used by the routine at EVAL_VARIABLE.
STKTHS:
  PUSH BC
  LD BC,EVAL3
  PUSH BC
  LD B,E
  LD C,D
  CALL PUSHF
  LD E,B
  LD D,C
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  LD HL,(TEMP3)
  JP EVAL_1
; This entry point is used by the routine at EVAL3.
DORELS:
  LD D,$00
LOPREL:
  SUB $C0
  JP C,FINREL
  CP $03
  JP NC,FINREL
  CP $01
  RLA
  XOR D
  CP D
  LD D,A
  JP C,SN_ERR
  LD (TEMP3),HL
  RST CHRGTB
  JR LOPREL

; Get next expression value
;
; Used by the routines at EVAL_1 and CONCAT.
OPRND:
  XOR A
  LD (VALTYP),A
  RST CHRGTB
  JP Z,MO_ERR
  JP C,H_ASCTFP
  CP '&'
  JP Z,OCTCNS
  CALL ISLETTER_A
  JR NC,EVAL_VARIABLE
  CP $B9
  JR Z,OPRND
  CP '.'
  JP Z,H_ASCTFP
  CP $BA
  JR Z,MINUS
  CP '"'
  JP Z,QTSTR
  CP $B7
  JP Z,NOT
  CP $B4
  JP Z,DOFN
  SUB $C3
  JR NC,ISFUN

; End of expression.  Look for ')'.
;
; Used by the routines at EVAL VARIABLE and L2A38.
EVLPAR:
  CALL OPNPAR

; Routine at 10512
L2910:
  RST SYNCHR

; Data block at 10513
L2911:
  DEFB $29

; Routine at 10514
L2912:
  RET

; '-', deal with minus sign
;
; Used by the routine at OPRND.
MINUS:
  LD D,$7D
  CALL EVAL_1
  LD HL,(NXTOPR)
  PUSH HL
  CALL INVSGN

; Routine at 10527
RETNUM:
  CALL TSTNUM
  POP HL
  RET

; Routine at 10532
;
; Used by the routine at OPRND.
EVAL_VARIABLE:
  CALL GETVAR

; Routine at 10535
EVAL_VARIABLE_1:
  PUSH HL
  EX DE,HL
  LD (FACCU),HL
  LD A,(VALTYP)
  OR A
  CALL Z,MOVFM
  POP HL
  RET
; This entry point is used by the routine at OPRND.
ISFUN:
  LD B,$00
  RLCA
  LD C,A
  PUSH BC
  RST CHRGTB
  LD A,C
  CP $33
  JR C,OKNORM
  CALL OPNPAR

  RST SYNCHR
  DEFB ','

  CALL TSTSTR
  EX DE,HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  CALL GETINT
  EX DE,HL
  EX (SP),HL
  JR GOFUNC
; This entry point is used by the routine at EVAL_VARIABLE_1.
OKNORM:
  CALL EVLPAR
  EX (SP),HL
  LD DE,RETNUM
  PUSH DE
GOFUNC:
  LD BC,FNCTAB_FN
DISPAT:
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  JP (HL)
; This entry point is used by the routine at _ASCTFP.
SGNEXP:
  DEC D
  CP $BA
  RET Z
  CP $2D
  RET Z
  INC D
  CP $2B
  RET Z
  CP $B9
  RET Z
  DEC HL
  RET
  OR $AF
  PUSH AF
  CALL TSTNUM
  CALL CONIS
  POP AF
  EX DE,HL
  POP BC
  EX (SP),HL
  EX DE,HL
  CALL FPBCDE
  PUSH AF
  CALL CONIS
  POP AF
  POP BC
  LD A,C
  LD HL,L29EA_0
  JR NZ,L2945_0
  AND E
  LD C,A
  LD A,B
  AND D
  JP (HL)
L2945_0:
  OR E
  LD C,A
  LD A,B
  OR D
  JP (HL)
; This entry point is used by the routine at STKTHS.
FINREL:
  LD HL,FINREL_0
  LD A,(VALTYP)
  RRA
  LD A,D
  RLA
  LD E,A
  LD D,$64
  LD A,B
  CP D
  RET NC
  JP STKTHS

; Routine at 10672
FINREL_0:
  OR D
  ADD HL,HL
  LD A,C
  OR A
  RRA
  POP BC
  POP DE
  PUSH AF
  CALL TSTSTR_0
  LD HL,DOCMP               ;ROUTINE TO TAKE COMPARE ROUTINE RESULT
                            ;AND RELATIONAL BITS AND RETURN THE ANSWER
  PUSH HL
  JP Z,FCOMP
  XOR A
  LD (VALTYP),A
  JP STRCMP

DOCMP:
  INC A                   ;SETUP BITS
  ADC A,A                 ;4=LESS 2=EQUAL 1=GREATER
  POP BC                  ;WHAT DID HE WANT?
  AND B                   ;ANY BITS MATCH?
  ADD A,$FF               ;MAP 0 TO 0
  SBC A,A                 ;AND ALL OTHERS TO 377
  JP FLOAT

; 'NOT' boolean expression
;
; Used by the routine at OPRND.
NOT:
  LD D,$5A
  CALL EVAL_1
  CALL TSTNUM
  CALL CONIS
  LD A,E
  CPL
  LD C,A
  LD A,D
  CPL
  CALL L29EA_0
  POP BC
  JP EVAL3

; Routine at 10730
;
; Used by the routine at __FRE.
L29EA:
  LD A,L
  SUB E
  LD C,A
  LD A,H
  SBC A,D
; This entry point is used by the routine at NOT.
L29EA_0:
  LD B,C

; Routine at 10736
;
; Used by the routine at PASSA.
GIVINT:
  LD D,B

; Get back from function passing an INT value in A+B registers
ABPASS:
  LD E,$00
  LD HL,VALTYP
  LD (HL),E
  LD B,$90
  JP FLOATR

; Routine at 10748
__LPOS:
  LD A,(LPTPOS)
  JR PASSA

; Routine at 10753
__POS:
  CALL MAKINT
  INC A
  JR Z,__POS_0
  LD A,(CURPOS)
  JR PASSA
__POS_0:
  LD A,(YCURSO)

; USR routine return
;
; Used by the routines at _PASSA, __STICKX, __STICKY, __ACTION, __KEY, __LPOS,
; __POS and __PEEK.
PASSA:
  LD B,A
  XOR A
  JR GIVINT

; Routine at 10771
__DEF:
  CALL CHEKFN
  CALL IDTEST
  LD BC,__DATA
  PUSH BC
  PUSH DE
  LD DE,$0000
  LD A,(HL)
  CP $28
  JR NZ,L2A36
  RST CHRGTB
  CALL GETVAR
  PUSH HL
  EX DE,HL
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  POP HL
  CALL TSTNUM

; Routine at 10804
L2A34:
  RST SYNCHR

; Data block at 10805
L2A35:
  DEFB $29

; Routine at 10806
;
; Used by the routine at __DEF.
L2A36:
  RST SYNCHR

; Data block at 10807
L2A37:
  DEFB $C1

; Routine at 10808
L2A38:
  LD B,H
  LD C,L
  EX (SP),HL
  LD (HL),C
  INC HL
  LD (HL),B
  JP PUTDEI
; This entry point is used by the routine at OPRND.
DOFN:
  CALL CHEKFN
  PUSH DE
  CALL EVLPAR
  CALL TSTNUM
  EX (SP),HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD A,D
  OR E
  JP Z,UF_ERR
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  PUSH HL
  LD HL,(PRMNAM)
  EX (SP),HL
  LD (PRMNAM),HL
  LD HL,(PRMVAL+2)
  PUSH HL
  LD HL,(PRMVAL)
  PUSH HL
  LD HL,PRMVAL
  PUSH DE
  CALL FPTHL
  POP HL
  CALL GETNUM
  DEC HL
  RST CHRGTB
  JP NZ,SN_ERR
  POP HL
  LD (PRMVAL),HL
  POP HL
  LD (PRMVAL+2),HL
  POP HL
  LD (PRMNAM),HL
  POP HL
  RET
; This entry point is used by the routines at __INPUT and __DEF.
IDTEST:
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  RET NZ
  LD E,$16
  JP ERROR

; Routine at 10901
;
; Used by the routines at __DEF and L2A38.
CHEKFN:
  RST SYNCHR

; Data block at 10902
L2A96:
  DEFB $B4

; Routine at 10903
L2A97:
  LD A,$80
  LD (SUBFLG),A
  OR (HL)
  LD C,A
  CALL GTFNAM
  JP TSTNUM

; Load 'A' with the next number in BASIC program
;
; Used by the routine at __TAB.
FNDNUM:
  RST CHRGTB

; Get a number to 'A'
;
; Used by the routines at __GETINT, __SOUND, __SOUND, __SETE, __TX, L0E19, L0E2D,
; __INIT, L0E63, __CURSOR, __DELIM, L0F63, L0F75, __DISPLAY, __ON, EVAL_VARIABLE, L2AC1
; and L3875.
GETINT:
  CALL GETNUM

; Convert tmp string to int in A register
;
; Used by the routines at __STICKX, __STICKY, __ACTION, __POS and __CHR_S.
MAKINT:
  CALL DEPINT
  LD A,D
  OR A
  JP NZ,FC_ERR
  DEC HL
  RST CHRGTB
  LD A,E
  RET

; Routine at 10932
__PEEK:
  CALL CONIS
  LD A,(DE)
  JP PASSA

; Routine at 10939
__POKE:
  CALL GETWORD
  PUSH DE

; Routine at 10943
L2ABF:
  RST SYNCHR

; Data block at 10944
L2AC0:
  DEFB ','

; Routine at 10945
L2AC1:
  CALL GETINT
  POP DE
  LD (DE),A
  RET

; Data block at 10951
L2AC7:
  DEFB $00,$00,$00,$00

; Get a number to DE (0..65535)
;
; Used by the routine at __POKE.
GETWORD:
  CALL EVAL
  PUSH HL
  CALL CONIS
  POP HL
  RET

; Text editor
;
; Used by the routine at SHIFT_STOP.
T_EDIT:
  PUSH BC
  PUSH DE
  PUSH HL
  LD A,(PICFLG)
  BIT 1,A
  JP NZ,T_EDIT_6
  HALT
  CALL CONSOLE_CLS_0
  OR A
  JR Z,T_EDIT_5
  PUSH AF
  EXX
  LD HL,$2020
  LD (TMPSOUND),HL
  LD DE,$0001
  CALL SOUND
  LD A,(PICFLG)
  NOP
  NOP
  OR $01
  LD (PICFLG),A
  POP AF
  JP M,T_EDIT_55
  CP $0D
  JP QINLIN_5
; This entry point is used by the routine at QINLIN.
T_EDIT_0:
  CP $09
  JP Z,T_EDIT_35
  CP $0A
  JP Z,T_EDIT_37
  CP $0C
  JP Z,T_EDIT_40
  JP QINLIN_0
  NOP
; This entry point is used by the routine at QINLIN.
T_EDIT_1:
  LD A,(PICFLG)
  BIT 5,A
  JR NZ,T_EDIT_4
  LD A,$1F
; This entry point is used by the routines at L33CD and QINLIN.
T_EDIT_2:
  RST $18
T_EDIT_3:
  LD (IX+$01),$01
  LD (IX+$00),$01
  HALT
; This entry point is used by the routine at L33CD.
T_EDIT_4:
  XOR A
T_EDIT_5:
  POP HL
  POP DE
  POP BC
  RET
T_EDIT_6:
  LD HL,(RETADR)
  LD A,H
  CP $18
  JR NC,T_EDIT_7
  PUSH HL
  INC H
  LD L,$00
  CALL L33CD_29
  POP HL
  JR Z,T_EDIT_8
T_EDIT_7:
  LD A,L
  CP $27
  JR NC,T_EDIT_11
T_EDIT_8:
  PUSH AF
  LD A,L
  CP $27
  JR C,T_EDIT_9
  INC H
  LD L,$00
T_EDIT_9:
  INC L
  LD (RETADR),HL
  PUSH HL
  CALL L33CD_29
  LD B,A
  POP DE
  POP AF
  LD A,B
  JR NC,T_EDIT_16
  CP ' '
  JR NZ,T_EDIT_16
T_EDIT_10:
  INC E
  LD A,E
  CP $28
  JR NC,T_EDIT_11
  INC HL
  INC HL
  LD A,(HL)
  CP ' '
  JR Z,T_EDIT_10
  LD A,$20
  JR T_EDIT_16
T_EDIT_11:
  LD A,(PICFLG)
  RES 1,A
  LD (PICFLG),A
  LD A,(ENTSTT)
  BIT 7,A
  JR NZ,T_EDIT_15
  CP ' '
  JR Z,T_EDIT_12
  CP '0'
  JR C,$2BA1
  CP $3A
  JR NC,$2BA1
T_EDIT_12:
  LD A,(CURPOS)
  CP $01
  JR Z,T_EDIT_14
; This entry point is used by the routine at QINLIN.
T_EDIT_13:
  CALL T_EDIT_23
  JR T_EDIT_15
T_EDIT_14:
  JP QINLIN_3
  NOP
  LD B,$CD
  OUT ($2B),A
  LD A,$1E
  RST $18
; This entry point is used by the routine at QINLIN.
T_EDIT_15:
  LD A,$0D
  JP T_EDIT_5
T_EDIT_16:
  CP $FF
  JR NZ,T_EDIT_17
  LD A,$10
T_EDIT_17:
  CP $0D
  JR NZ,T_EDIT_18
  LD A,$11
T_EDIT_18:
  CP $08
  JR NZ,T_EDIT_19
  LD A,$13
T_EDIT_19:
  CP $04
  JR NZ,T_EDIT_20
  LD A,$18
T_EDIT_20:
  CP $1F
  JR NZ,T_EDIT_21
  LD A,$1A
T_EDIT_21:
  CP $03
  JR NZ,T_EDIT_22
  LD A,$1C
T_EDIT_22:
  JP T_EDIT_5
T_EDIT_23:
  LD A,$03
  RST $18
  LD HL,(CURPOS)
  DEC L
  CALL L33CD_29
  JR Z,T_EDIT_23
  RET
; This entry point is used by the routine at QINLIN.
T_EDIT_24:
  LD HL,(CURPOS)
T_EDIT_25:
  DEC L
  PUSH HL
  CALL L33CD_29
  POP HL
  CP $80
  JR Z,T_EDIT_26
  XOR $30
  CP $0A
  JR NC,T_EDIT_27
  JR T_EDIT_25
T_EDIT_26:
  LD A,L
  OR A
  JR NZ,T_EDIT_25
  INC L
  LD A,(AUTFLG)
  OR A
  JR Z,T_EDIT_27
  XOR A
  LD (AUTFLG),A
  LD (CURPOS),HL
  LD A,$04
  RST $18
  JP T_EDIT_15
T_EDIT_27:
  LD L,$01
T_EDIT_28:
  LD (RETADR),HL
  PUSH HL
  DEC L
  CALL L33CD_29
  POP HL
  JR NZ,T_EDIT_29
  DEC H
  JP M,T_EDIT_34
  JR T_EDIT_28
T_EDIT_29:
  LD A,(PICFLG)
  BIT 5,A
  JR Z,T_EDIT_32
  NOP
  NOP
  NOP
  NOP
  NOP
  LD HL,(RETADR)
  PUSH HL
  CALL SCRADR
  POP DE
T_EDIT_30:
  LD A,E
  CP $28
  JR NC,T_EDIT_31
  INC E
  LD A,(HL)
  INC HL
  INC HL
  CP $3F
  JR NZ,T_EDIT_30
  LD (RETADR),DE
  JR T_EDIT_30
T_EDIT_31:
  LD A,$30
  JR T_EDIT_33
T_EDIT_32:
  CALL L33CD_29
T_EDIT_33:
  LD (ENTSTT),A
  LD A,(PICFLG)
  SET 1,A
  LD (PICFLG),A
  LD HL,(RETADR)
  DEC L
  LD (RETADR),HL
T_EDIT_34:
  JP T_EDIT_4
T_EDIT_35:
  LD A,(YCURSO)
  OR A
  JR NZ,T_EDIT_36
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,T_EDIT_4
  LD DE,($4809)
  CALL SRCHLN
  LD BC,(PRELIN)
  LD A,B
  OR C
  JP Z,T_EDIT_4
  JP T_EDIT_41
T_EDIT_36:
  LD A,$09
  JP T_EDIT_2
T_EDIT_37:
  LD A,(YCURSO)
  CP $18
  JP C,T_EDIT_39
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,T_EDIT_4
  LD DE,($4809)
  INC DE
  CALL SRCHLN
  JP C,T_EDIT_38
  JP Z,T_EDIT_4
T_EDIT_38:
  JP T_EDIT_41
T_EDIT_39:
  LD A,$0A
  JP T_EDIT_2
T_EDIT_40:
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,T_EDIT_4
  SCF
  JR T_EDIT_42
T_EDIT_41:
  INC BC
  INC BC
  LD H,B
  LD L,C
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD ($4809),DE
  OR A
  LD HL,(CURPOS)
  PUSH HL
T_EDIT_42:
  PUSH AF
  LD A,$81
  LD (PICFLG),A
  LD (IX+$00),$40
  LD (IX+$08),$00
  LD HL,$0001
  LD (CURPOS),HL
  CALL CLR_SCR
  LD DE,($4809)
  CALL SRCHLN
  LD H,B
  LD L,C
T_EDIT_43:
  CALL T_EDIT_47
  JR C,T_EDIT_44
  LD A,(YCURSO)
  CP $18
  LD A,$03
  CALL C,_CHPUT
  JR C,T_EDIT_43
T_EDIT_44:
  POP AF
  JR C,T_EDIT_45
  POP HL
  JR T_EDIT_46
T_EDIT_45:
  LD HL,$0001
T_EDIT_46:
  LD (CURPOS),HL
  JP T_EDIT_3
T_EDIT_47:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,B
  OR C
  JP Z,T_EDIT_53
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  EX DE,HL
  CALL LINPRT
  LD A,$20
  POP HL
T_EDIT_48:
  RST $18
  LD A,(PICFLG)
  BIT 6,A
  JP NZ,T_EDIT_53
T_EDIT_49:
  LD A,(HL)
  INC HL
  CP $0E
  JR NZ,T_EDIT_50
  LD A,(HL)
  INC HL
  EX AF,AF'
  LD A,(HL)
  INC HL
  PUSH HL
  LD H,A
  EX AF,AF'
  LD L,A
  CALL LINPRT
  POP HL
  JR T_EDIT_49
T_EDIT_50:
  OR A
  JP Z,T_EDIT_54
  JP P,T_EDIT_48
  SUB $7F
  LD C,A
  LD DE,WORDS
  CP $0F
  JR NZ,T_EDIT_51
  LD (IX+$08),$01
T_EDIT_51:
  LD A,(DE)
  INC DE
  OR A
  JP P,T_EDIT_51
  DEC C
  JP NZ,T_EDIT_51
T_EDIT_52:
  AND $7F
  RST $18
  LD A,(PICFLG)
  BIT 6,A
  JP NZ,T_EDIT_53
  LD A,(DE)
  INC DE
  OR A
  JP P,T_EDIT_52
  JP T_EDIT_49
T_EDIT_53:
  SCF
T_EDIT_54:
  LD (IX+$08),$00
  RET
T_EDIT_55:
  CP $BA
  JP C,T_EDIT_58
  CP $FB
  JP NC,T_EDIT_4
  LD HL,FNKSTR
T_EDIT_56:
  CP (HL)
  INC HL
  JR NZ,T_EDIT_56
T_EDIT_57:
  LD A,(HL)
  BIT 7,A
  JP NZ,T_EDIT_3
  RST $18
  INC HL
  JR T_EDIT_57
T_EDIT_58:
  SUB $B0
  LD E,A
  LD D,$00
  LD HL,$487A
  ADD HL,DE
  LD A,(HL)
  JP T_EDIT_2

; Message at 11678
FNKSTR:
  DEFB $D7
  DEFM "3.14159"
  DEFB $00
  DEFB $D8
  DEFM "PRINT "
  DEFB $00
  DEFB $D9
  DEFM "RENUM "
  DEFB $00
  DEFB $DA
  DEFM "AUTO "
  DEFB $00
  DEFB $DB
  DEFM "FRE(0)"
  DEFB $00
  DEFB $DC
  DEFM "REM "
  DEFB $00
  DEFB $DE
  DEFM "LOAD"
  DEFB $00
  DEFB $DF
  DEFM "SAVE"
  DEFB $00
  DEFB $E0
  DEFM "PLAY "
  DEFB $00
  DEFB $E1
  DEFM "CLOAD"
  DEFB $00
  DEFB $E2
  DEFM "CSAVE"
  DEFB $00
  DEFB $E3
  DEFM "CLEAR "
  DEFB $00
  DEFB $E4
  DEFM "DATA "
  DEFB $00
  DEFB $E5
  DEFM "SETEG "
  DEFB $00
  DEFB $E6
  DEFM "FOR I=1 TO "
  DEFB $00
  DEFB $E7
  DEFM "GOTO "
  DEFB $00
  DEFB $E8
  DEFM "GOSUB "
  DEFB $00
  DEFB $E9
  DEFM "INIT "
  DEFB $00
  DEFB $EA
  DEFM "RETURN"
  DEFB $00
  DEFB $EB
  DEFM "DIM "
  DEFB $00
  DEFB $EC
  DEFM "LIST "
  DEFB $00
  DEFB $ED
  DEFM "INPUT "
  DEFB $00
  DEFB $EE
  DEFM "NEXT I"
  DEFB $00
  DEFB $EF
  DEFM "READ "
  DEFB $00
  DEFB $F0
  DEFM "POKE "
  DEFB $00
  DEFB $F1
  DEFM "RESTORE "
  DEFB $00
  DEFB $F2
  DEFM "RUN "
  DEFB $00
  DEFB $F3
  DEFM "SOUND "
  DEFB $00
  DEFB $F4
  DEFM "CHR$("
  DEFB $00
  DEFB $F5
  DEFM "LEFT$("
  DEFB $00
  DEFB $F6
  DEFM "RIGHT$("
  DEFB $00
  DEFB $F7
  DEFM "MID$("
  DEFB $00
  DEFB $F8
  DEFM "CURSORX "
  DEFB $00
  DEFB $F9
  DEFM "CURSORY "
  DEFB $00
  DEFB $FA
  DEFM "SETET "
  DEFB $00

; BASIC interpreter miscellaneous
;
; Used by the routines at PROMPT and GETVAR.
MOVUP:
  CALL ENFMEM
; This entry point is used by the routine at ARYSTR.
MOVSTR:
  PUSH BC
  EX (SP),HL
  POP BC
MOVLP:
  RST DCOMPR
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JR MOVLP

; Check for C levels of stack
;
; Used by the routines at __FOR, __GOSUB, EVAL_1 and BS_ERR.
CHKSTK:
  PUSH HL
  LD HL,(STREND)
  LD B,$00
  ADD HL,BC
  ADD HL,BC

; Skip "PUSH HL"
L2EC3:
  DEFB $3E

; Routine at 11972
;
; Used by the routines at L1CC0, MOVUP and BS_ERR.
ENFMEM:
  PUSH HL
  LD A,$A0
  SUB L
  LD L,A
  LD A,$FF
  SBC A,H
  LD H,A
  JR C,OM_ERR
  ADD HL,SP
  POP HL
  RET C
; This entry point is used by the routines at INIT, L2FB1 and BS_ERR.
OM_ERR:
  LD DE,$000C
  JP ERROR
  RET NZ
; This entry point is used by the routines at INIT, __SAVE, L1A50 and __NEW.
CLRPTR:
  LD HL,(TXTTAB)
; This entry point is used by the routine at __NEW.
NEW_0:
  XOR A
  JP NEW_1
; This entry point is used by the routine at SHIFT_STOP.
RUN_FST_0:
  INC HL
  LD (VARTAB),HL
; This entry point is used by the routines at PROMPT and __RUN.
RUN_FST:
  LD HL,(TXTTAB)
  DEC HL
; This entry point is used by the routines at __RUN, __CLEAR and L2FB1.
_CLVAR:
  LD (TEMP),HL
  LD HL,(MEMSIZ)
  LD (FRETOP),HL
  XOR A
  CALL __RESTORE
  LD HL,(VARTAB)
  LD (ARYTAB),HL
  LD (STREND),HL
; This entry point is used by the routines at INIT, NMI_HANDLER and ERROR.
CLREG:
  POP BC
  LD HL,(STKTOP)
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL FINLPT
  XOR A
  LD L,A
  LD H,A
  LD (OLDTXT),HL
  LD (SUBFLG),A
  LD (PRMNAM),HL
  PUSH HL
  PUSH BC
; This entry point is used by the routine at NEXITM.
GTMPRT:
  LD HL,(TEMP)
  RET

; Routine at 12062
;
; Used by the routine at ENFMEM.
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
; This entry point is used by the routine at INPBIN.
__RESTORE_1:
  LD (DATPTR),HL
  EX DE,HL
  RET

; Routine at 12088
;
; Used by the routine at ISCNTC.
__STOP:
  RET NZ

; "OR n" to mask the next byte
L2F39:
  DEFB $F6

; Routine at 12090
__END:
  RET NZ
  LD (TEMP),HL

; "LD HL,nn" to jump over the next word without executing it
L2F3E:
  DEFB $21

; Routine at 12095
;
; Used by the routines at L2772 and GTVLUS.
INPBRK:
  OR $FF
  POP BC
; This entry point is used by the routine at L24BD.
ENDCON:
  LD HL,(CURLIN)
  PUSH AF
  LD A,L
  AND H
  INC A
  JR Z,NOLIN
  LD (OLDLIN),HL
  LD HL,(TEMP)
  LD (OLDTXT),HL
NOLIN:
  CALL FINLPT
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG_FR
  PUSH AF
  LD A,(FRGFLG)
  OR A
  JR Z,INPBRK_0
  LD HL,BREAK_MSG
INPBRK_0:
  POP AF
  JP NZ,_ERROR_REPORT
  JP READY

; Routine at 12143
__CONT:
  LD HL,(OLDTXT)
  LD A,H
  OR L
  LD DE,DCOMPR
  JP Z,ERROR
  LD DE,(OLDLIN)
  LD (CURLIN),DE
  RET
_FC_ERR_A:
  JP FC_ERR
__ERASE:
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
; This entry point is used by the routine at GETVAR.
__CONT_0:
  LD A,(HL)

; Check char in 'A' being in the 'A'..'Z' range
;
; Used by the routines at OPRND and GETVAR.
ISLETTER_A:
  CP $41
  RET C
  CP $5B
  CCF
  RET

; Routine at 12192
__CLEAR:
  JP Z,_CLVAR
  CALL INTIDX_0
  DEC HL
  RST CHRGTB
  PUSH HL
  LD HL,(MEMSIZ)
  JR Z,STORED
  POP HL

; Routine at 12207
L2FAF:
  RST SYNCHR

; Data block at 12208
L2FB0:
  DEFB ','

; Routine at 12209
L2FB1:
  PUSH DE
  CALL GETNUM
  CALL CONIS
  DEC HL
  RST CHRGTB
  JP NZ,SN_ERR
  EX (SP),HL
  EX DE,HL
; This entry point is used by the routine at __CLEAR.
STORED:
  CALL L2FB1_0
  JP C,OM_ERR
  PUSH HL
  LD HL,(VARTAB)
  LD BC,VSIGN
  ADD HL,BC
  RST DCOMPR
  JP NC,OM_ERR
  EX DE,HL
  LD (STKTOP),HL
  POP HL
  LD (MEMSIZ),HL
  POP HL
  JP _CLVAR
L2FB1_0:
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  RET

; Routine at 12260
__NEXT:
  LD DE,$0000
__NEXT_0:
  CALL NZ,GETVAR
  LD (TEMP),HL
  CALL BAKSTK
  JP NZ,$223E
  LD SP,HL
  PUSH DE
  LD A,(HL)
  PUSH AF
  INC HL
  PUSH DE
  CALL MOVFM
  EX (SP),HL
  PUSH HL
  CALL FADDS
  POP HL
  CALL FPTHL
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FCOMP
  POP HL
  POP BC
  SUB B
  CALL LOADFP
  JR Z,__NEXT_1
  EX DE,HL
  LD (CURLIN),HL
  LD L,C
  LD H,B
  JP PUTFID
__NEXT_1:
  LD SP,HL
  LD HL,(TEMP)
  LD A,(HL)
  CP ','
  JP NZ,NEWSTT
  RST CHRGTB
  CALL __NEXT_0
; This entry point is used by the routines at H_ASCTFP and OPRND.
OCTCNS:
  INC HL

  RST SYNCHR
  DEFB '"'

; Routine at 12335
L302F:
  LD DE,$0000
  LD B,$05
  DEC HL
L302F_0:
  CALL __CALL_1
  JR C,L302F_1
  EX DE,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  OR L
  LD L,A
  EX DE,HL
  DJNZ L302F_0
L302F_1:
  CP '"'
  JP NZ,SN_ERR
  RST CHRGTB
  LD B,$98
  PUSH HL
  XOR A
  CALL FLOATR
  POP HL
  RET

  NOP
  NOP
  NOP
  NOP
  NOP

; Routine at 12376
__RENUM:
  LD BC,$000A
  PUSH BC
  LD D,B
  LD E,B
  JR Z,L3077_0
  CP ','
  JR Z,L306D
  PUSH DE
  CALL ATOH
  LD B,D
  LD C,E
  POP DE
  JR Z,L3077_0

; Routine at 12397
;
; Used by the routine at __RENUM.
L306D:
  RST SYNCHR

; Data block at 12398
L306E:
  DEFB ','

; Routine at 12399
L306F:
  CALL ATOH
  JR Z,L3077_0
  POP AF

; Routine at 12405
L3075:
  RST SYNCHR

; Data block at 12406
L3076:
  DEFB ','

; Routine at 12407
L3077:
  PUSH DE
  CALL ATOH
  JP NZ,SN_ERR
  LD A,D
  OR E
  JP Z,FC_ERR
  EX DE,HL
  EX (SP),HL
  EX DE,HL
; This entry point is used by the routines at __RENUM and L306F.
L3077_0:
  PUSH BC
  CALL SRCHLN
  POP DE
  PUSH DE
  PUSH BC
  CALL SRCHLN
  LD H,B
  LD L,C
  POP DE
  RST DCOMPR
  EX DE,HL
  JP C,FC_ERR
  POP DE
  POP BC
  POP AF
  PUSH HL
  PUSH DE
  JR L3077_2
L3077_1:
  ADD HL,BC
  JP C,FC_ERR
  EX DE,HL
  PUSH HL
  LD HL,$FFF9
  RST DCOMPR
  POP HL
  JP C,FC_ERR
L3077_2:
  PUSH DE
  LD E,(HL)
  LD A,E
  INC HL
  LD D,(HL)
  OR D
  EX DE,HL
  POP DE
  JR Z,__RENUM_FIN
  LD A,(HL)
  INC HL
  OR (HL)
  DEC HL
  EX DE,HL
  JR NZ,L3077_1
__RENUM_FIN:
  PUSH BC
  CALL SCCLIN
  POP BC
  POP DE
  POP HL
__RENUM_LP:
  PUSH DE
  LD E,(HL)
  LD A,E
  INC HL
  LD D,(HL)
  OR D
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
  JR __RENUM_LP
LINE2PTR:
  LD BC,RESTART
  PUSH BC

; 'CP $F6'  masking the next byte/instr.
L30DE:
  DEFB $FE

; 'OR $AF'  masking the next instruction
SCCLIN:
  DEFB $F6

; THE SUBROUTINES SCCLIN AND SCCPTR CONVERT ALL LINE #'S TO POINTERS AND
; VICE-VERSA.
SCCPTR:
  XOR A
  LD (PTRFLG),A
  LD HL,(TXTTAB)
  DEC HL
SCNPLN:
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  RET Z
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
SCNEXT:
  RST CHRGTB
  OR A
  JR Z,SCNPLN
  LD C,A
  LD A,(PTRFLG)
  OR A
  LD A,C
  JR Z,SCNPT2
  CP $0E
  JR NZ,SCNEXT
  PUSH DE
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  CALL SRCHLN
  DEC BC
  LD A,$0D
  JR C,MAKPTR
  CALL CONSOLE_CRLF
  LD HL,LINE_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,SCCPTR_0
  LD HL,LINE_MSG
SCCPTR_0:
  PUSH DE
  CALL PRS
  POP HL
  CALL LINPRT
  LD HL,LINE_ERR_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,SCCPTR_1
  LD HL,LINE_ERR_MSG
SCCPTR_1:
  CALL PRS
  POP BC
  POP HL
  PUSH HL
  PUSH BC
  CALL IN_PRT
SCNPOP:
  POP HL
SCNEX3:
  POP DE
  DEC HL
_SCNEXT:
  JR SCNEXT
SCNPT2:
  CP $0E
  JR NZ,SCCPTR_2
  INC HL
  INC HL
  JR _SCNEXT
SCCPTR_2:
  CP $0D
  JR NZ,_SCNEXT
  PUSH DE
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  EX DE,HL
  INC HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD A,$0E
MAKPTR:
  LD HL,SCNPOP
  PUSH HL
  LD HL,(CONTXT)
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

; Routine at 12654
__AUTO:
  LD DE,$000A
  PUSH DE
  JR Z,__AUTO_0
  CALL ATOH
  EX AF,AF'
  LD A,D
  OR E
  JP Z,SN_ERR
  POP BC
  PUSH DE
  EX AF,AF'
  JR Z,__AUTO_0

; Routine at 12674
L3182:
  RST SYNCHR

; Data block at 12675
L3183:
  DEFB ','

; Routine at 12676
L3184:
  CALL ATOH
  EX AF,AF'
  LD A,D
  OR E
  JP Z,SN_ERR
  EX AF,AF'
  JP NZ,SN_ERR
  LD (AUTINC),DE
; This entry point is used by the routine at __AUTO.
__AUTO_0:
  POP DE
  LD (AUTLIN),DE
  LD A,$01
  LD (AUTFLG),A
; This entry point is used by the routine at __LOAD.
P_PROMPT:
  POP BC
  JP PROMPT

; Routine at 12707
__LLIST:
  LD A,$01
  LD (PRTFLG),A

; Routine at 12712
__LIST:
  CALL __LIST_0
  CALL __LIST_4
  JP RESTART
; This entry point is used by the routines at __SAVE and __LOAD.
__LIST_0:
  LD DE,$0000
  DEC HL
  RST CHRGTB
  JR Z,__LIST_1
  CP ','
  CALL NZ,ATOH
__LIST_1:
  LD (TEMP),DE
  PUSH HL
  CALL SRCHLN
  POP HL
  PUSH BC
  DEC HL
  RST CHRGTB
  JR Z,__LIST_2
  CP ','
  JP NZ,SN_ERR
  INC HL
  CALL ATOH
  JP NZ,SN_ERR
  LD A,D
  OR E
  JR NZ,__LIST_3
__LIST_2:
  LD DE,$FFFF
__LIST_3:
  LD (TMPSOUND),DE
  POP DE
  RET
; This entry point is used by the routine at __SAVE.
__LIST_4:
  LD A,$01
  LD (PICFLG),A
  EX DE,HL
__LIST_5:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,B
  OR C
  RET Z
  CALL ISCNTC
  CP $04
  JR NZ,__LIST_8
  PUSH HL
__LIST_6:
  CALL KBDSCAN
  OR A
  JR NZ,__LIST_6
__LIST_7:
  CALL ISCNTC
  CALL KBDSCAN
  OR A
  JR Z,__LIST_7
  POP HL
__LIST_8:
  LD E,(HL)
  INC HL
  LD D,(HL)
  PUSH HL
  LD HL,(TMPSOUND)
  RST DCOMPR
  POP HL
  CCF
  RET NC
  LD ($4809),DE
  INC HL
  PUSH HL
  EX DE,HL
  CALL LINPRT
  LD A,$20
  POP HL
  LD (RETADR),HL
  RST $18
  LD HL,(RETADR)
  LD (RETADR),BC
  LD A,$DF
__LIST_9:
  LD A,(HL)
  INC HL
  CP $0E
  JR NZ,__LIST_10
  LD A,$20
  RST $18
  LD A,(HL)
  INC HL
  EX AF,AF'
  LD A,(HL)
  INC HL
  PUSH HL
  LD H,A
  EX AF,AF'
  LD L,A
  CALL LINPRT
  POP HL
  JR __LIST_9
__LIST_10:
  OR A
  JR Z,__LIST_13
  JP P,$322D
  SUB $7F
  LD C,A
  LD DE,WORDS
  CP $0F
  JR NZ,__LIST_11
  LD (IX+$08),$01
__LIST_11:
  LD A,(DE)
  INC DE
  OR A
  JP P,__LIST_11
  DEC C
  JR NZ,__LIST_11
__LIST_12:
  AND $7F
  RST $18
  LD A,(DE)
  INC DE
  OR A
  JP P,__LIST_12
  JR __LIST_9
__LIST_13:
  LD (IX+$08),$00
  CALL OUTDO_CRLF
  JP __LIST_5

; Routine at 12920
;
; Used by the routines at INIT and NMI_HANDLER.
SCR_CO:
  SET 6,(IX+$03)
  BIT 0,(IX+$04)
  SET 4,(IX+$03)
  JR Z,SCR_CO_0
  RES 4,(IX+$03)
SCR_CO_0:
  CALL CONSOLE_RESET
  LD A,$7F
  JP SHIFT_STOP_23
; This entry point is used by the routine at SHIFT_STOP.
SCR_CO_1:
  CALL CHR_UPDATE
  LD A,$E6

; CHR$(159) - CLR-HOME
;
; Used by the routines at L0E63 and L3362.
CONSOLE_CLS:
  LD (IX+$09),A
  CALL CLR_SCR
; This entry point is used by the routine at L3362.
CONSOLE_HOME:
  LD HL,$0001
  LD (CURPOS),HL
  LD (IX+$01),$01
  LD (IX+$00),$01
  HALT
  RET
  EXX
  PUSH AF
  CALL KBDSCAN
  OR A
  POP BC
  LD A,B
  EXX
  RET
; This entry point is used by the routine at T_EDIT.
CONSOLE_CLS_0:
  EXX
  CALL KBDSCAN
  JR NC,CONSOLE_CLS_3
  LD L,A
  BIT 7,(IX+$07)
  LD A,(IX+$06)
  JP NZ,CONSOLE_CLS_1
  CP $80
  JP CONSOLE_CLS_2
CONSOLE_CLS_1:
  CP $08
CONSOLE_CLS_2:
  JP C,CONSOLE_CLS_8
  LD (IX+$07),$80
  LD A,L
  JP CONSOLE_CLS_4
CONSOLE_CLS_3:
  LD (IX+$07),$00
CONSOLE_CLS_4:
  LD (IX+$06),$00
  CP $01
  JR NZ,CONSOLE_CLS_7
  BIT 0,(IX+$04)
  JR Z,CONSOLE_CLS_5
  RES 0,(IX+$04)
  SET 4,(IX+$03)
  JR CONSOLE_CLS_6
CONSOLE_CLS_5:
  SET 0,(IX+$04)
  RES 4,(IX+$03)
CONSOLE_CLS_6:
  LD (IX+$01),$01
  JR CONSOLE_CLS_8
CONSOLE_CLS_7:
  BIT 0,(IX+$04)
  JR Z,CONSOLE_CLS_9
  CP $61
  JR C,CONSOLE_CLS_9
  CP $7B
  JR NC,CONSOLE_CLS_9
  RES 5,A
  JR CONSOLE_CLS_9
CONSOLE_CLS_8:
  XOR A
CONSOLE_CLS_9:
  OR A
  EXX
  RET

; Routine at 13082
;
; Used by the routines at T_EDIT, L33CD and FINLPT.
_CHPUT:
  EXX
  PUSH AF
  LD HL,_CHPUT1
  PUSH HL
  CP $80
  JR C,_CHPUT_0
  CP $A0
  JR NC,CONSOLE_ACC_MK
  AND $7F
  JR _CHPUT_1
_CHPUT_0:
  CP ' '
  JR NC,CONSOLE_ACC_MK
  BIT 7,(IX+$0A)
  JR NZ,_CHPUT_1
  BIT 7,(IX+$08)
  JR NZ,CONSOLE_ACC_MK
_CHPUT_1:
  LD D,$00
  PUSH AF
  LD E,A
  ADD A,A
  ADD A,E
  LD E,A
  LD HL,L3362
  ADD HL,DE
  POP AF
  JP (HL)
; This entry point is used by the routine at L3362.
CONSOLE_DOTDOT:
  LD A,$FF

; "LD HL,nn" to jump over the next word without executing it
L334B:
  DEFB $21

; Routine at 13132
;
; Used by the routine at L3362.
CONSOLE_I_MK:
  LD A,$0D

; "LD HL,nn" to jump over the next word without executing it
L334E:
  DEFB $21

; Routine at 13135
;
; Used by the routine at L3362.
CONSOLE_U_MK:
  LD A,$08

; "LD HL,nn" to jump over the next word without executing it
L3351:
  DEFB $21

; Routine at 13138
;
; Used by the routine at L3362.
CONSOLE_A_MK:
  LD A,$04

; "LD HL,nn" to jump over the next word without executing it
L3354:
  DEFB $21

; Routine at 13141
;
; Used by the routine at L3362.
CONSOLE_O_MK:
  LD A,$1F

; "LD HL,nn" to jump over the next word without executing it
L3357:
  DEFB $21

; Routine at 13144
;
; Used by the routine at L3362.
CONSOLE_POUND:
  LD A,$03
; This entry point is used by the routines at _CHPUT and L3362.
CONSOLE_ACC_MK:
  POP HL
  LD HL,L33CD
  PUSH HL
  JP GETCHAR_2

; Routine at 13154
L3362:
  JP CONSOLE_NULL
  JP CONSOLE_NULL
  JP L33CD_9
  JP L33CD_0
  JP L33CD_16
  JP L33CD_20
  JP CONSOLE_SCROLL
  JP CONSOLE_CRIGHT
  JP CONSOLE_CLEFT
  JP CONSOLE_CUP
  JP CONSOLE_CDOWN
  JP CONSOLE_NULL
  JP CONSOLE_HOME
  JP L33CD_0
  JP CONSOLE_BEL
  JP CONSOLE_RESET
  JP CONSOLE_DOTDOT
  JP CONSOLE_I_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_U_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_A_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_O_MK
  JP CONSOLE_ACC_MK
  JP CONSOLE_POUND
  JP CONSOLE_ACC_MK
  JP L33CD_31
  LD A,(IX+$09)
  JP CONSOLE_CLS
_CHPUT1:
  LD A,(PICFLG)
  RES 2,A
  LD (PICFLG),A

; Routine at 13261
L33CD:
  LD (IX+$01),$01
  POP AF
  EXX
  RET
; This entry point is used by the routine at L3362.
L33CD_0:
  LD HL,(CURPOS)
  LD A,$01
  CP L
  JR NZ,L33CD_1
  LD A,(PICFLG)
  BIT 2,A
  JR Z,L33CD_1
  CALL SCRADR
  DEC HL
  DEC HL
  LD (HL),$80
  RET
L33CD_1:
  LD L,$01
  LD (CURPOS),HL
; This entry point is used by the routine at L3362.
CONSOLE_CDOWN:
  LD HL,(CURPOS)
  LD A,H
  CP $18
  JR C,L33CD_2
  LD A,(PICFLG)
  BIT 7,A
  JR NZ,L33CD_3
  CALL L33CD_33
  LD A,$18
  CALL CLR_LINE
  JR L33CD_3
L33CD_2:
  INC H
  LD (CURPOS),HL
L33CD_3:
  RET
; This entry point is used by the routine at L3362.
CONSOLE_CUP:
  LD HL,(CURPOS)
  LD A,H
  OR A
  JR NZ,L33CD_4
  LD A,(PICFLG)
  BIT 7,A
  JR NZ,L33CD_5
  CALL L33CD_34
  LD A,$00
  CALL CLR_LINE
  JR L33CD_5
L33CD_4:
  DEC H
  LD (CURPOS),HL
L33CD_5:
  RET
; This entry point is used by the routine at L3362.
CONSOLE_CLEFT:
  LD HL,(CURPOS)
  LD A,L
  CP $02
  JR C,_CURSOR_UP
  DEC L
L33CD_6:
  LD (CURPOS),HL
  RET
_CURSOR_UP:
  LD A,H
  OR A
  RET Z
  CALL CONSOLE_CUP
  LD L,$27
  JR L33CD_6
; This entry point is used by the routine at L3362.
CONSOLE_CRIGHT:
  LD HL,(CURPOS)
  LD A,L
  CP $27
  JR NC,L33CD_8
  INC L
L33CD_7:
  LD (CURPOS),HL
  RET
L33CD_8:
  LD A,H
  CP $18
  RET NC
  CALL CONSOLE_CDOWN
  LD L,$01
  JR L33CD_7
; This entry point is used by the routine at L3362.
L33CD_9:
  LD HL,(CURPOS)
  LD A,$01
  CP L
  JP NC,L33CD_12
  PUSH HL
  CALL SCRADR
  POP BC
  LD D,H
  LD E,L
  DEC DE
  DEC DE
  LD A,$28
  SUB C
  ADD A,A
  LD C,A
  LD B,$00
L33CD_10:
  LDIR
  LD A,(HL)
  CP $84
  DEC HL
  DEC HL
  JR NZ,L33CD_14
  INC HL
  INC HL
L33CD_11:
  INC HL
  INC HL
  LD A,(HL)
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  LD (HL),A
  INC HL
  INC HL
  INC HL
  INC HL
  LD D,H
  LD E,L
  INC HL
  INC HL
  LD BC,$004C
  JR L33CD_10
L33CD_12:
  LD A,H
  OR A
  RET Z
  DEC HL
  CALL L33CD_29
  RET NZ
  JR L33CD_11
; This entry point is used by the routine at QINLIN.
L33CD_13:
  JP NZ,T_EDIT_4
  LD A,$06
  JP T_EDIT_2
L33CD_14:
  LD A,$20
  BIT 7,(IX+$08)
  JR Z,L33CD_15
  XOR A
L33CD_15:
  LD (HL),A
  CALL CONSOLE_CLEFT
  RET
; This entry point is used by the routine at L3362.
L33CD_16:
  LD HL,(CURPOS)
  PUSH HL
  LD A,$28
  SUB L
  PUSH AF
  CALL SCRADR
  POP BC
  LD E,(IX+$08)
  LD A,$20
  BIT 7,E
  JR Z,L33CD_17
  XOR A
L33CD_17:
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  DJNZ L33CD_17
L33CD_18:
  POP HL
  LD L,$00
  INC H
  PUSH HL
  CALL L33CD_29
  POP HL
  JR NZ,L33CD_19
  LD A,H
  PUSH HL
  CALL CLR_LINE
  JR L33CD_18
L33CD_19:
  RET
; This entry point is used by the routine at L3362.
L33CD_20:
  LD HL,(CURPOS)
  LD L,$00
L33CD_21:
  INC H
  PUSH HL
  CALL L33CD_29
  EX DE,HL
  POP HL
  JP Z,L33CD_21
  EX DE,HL
  DEC HL
  DEC HL
  LD A,(HL)
  DEC D
  PUSH DE
  BIT 7,(IX+$08)
  JR Z,L33CD_22
  OR A
  JP Z,L33CD_25
  JR L33CD_23
L33CD_22:
  CP ' '
  JP Z,L33CD_25
L33CD_23:
  LD HL,(CURPOS)
  DEC H
  JP QINLIN_4
; This entry point is used by the routine at QINLIN.
L33CD_24:
  PUSH HL
  LD (CURPOS),DE
  LD A,$06
  CALL _CHPUT
  LD HL,(CURPOS)
  LD L,$00
  CALL SCRADR
  LD A,$84
  LD (HL),A
  POP HL
  LD (CURPOS),HL
; This entry point is used by the routine at QINLIN.
L33CD_25:
  LD HL,(CURPOS)
  POP DE
  LD A,D
  CP H
  JP Z,L33CD_26
  LD H,D
  LD L,E
  DEC D
  PUSH DE
  CALL SCRADR
  LD BC,$004C
  ADD HL,BC
  INC HL
  LD D,H
  LD E,L
  INC DE
  INC DE
  LDDR
  DEC HL
  DEC HL
  DEC HL
  LD A,(HL)
  INC HL
  INC HL
  INC HL
  INC HL
  LD (HL),A
  JP L33CD_25
L33CD_26:
  LD HL,(CURPOS)
  PUSH HL
  LD L,$26
  CALL SCRADR
  POP BC
  LD D,H
  LD E,L
  INC DE
  INC DE
  LD A,$27
  SUB C
  JR Z,L33CD_27
  ADD A,A
  LD C,A
  LD B,$00
  LDDR
L33CD_27:
  LD A,$20
  BIT 7,(IX+$08)
  JR Z,L33CD_28
  XOR A
L33CD_28:
  CALL GETCHAR_2
  CALL CONSOLE_CLEFT
  RET
; This entry point is used by the routine at T_EDIT.
L33CD_29:
  CALL SCRADR
  LD A,(HL)
  CP $84
  RET
; This entry point is used by the routine at L3362.
CONSOLE_SCROLL:
  LD HL,(CURPOS)
  LD A,H
  OR A
  JR Z,L33CD_30
  LD L,$00
  CALL SCRADR
  LD DE,SCREEN
  OR A
  SBC HL,DE
  LD C,L
  LD B,H
  LD HL,SECOND_SCREEN_ROW
  LDIR
L33CD_30:
  LD A,(YCURSO)
  CALL CLR_LINE
  RET
; This entry point is used by the routine at L3362.
L33CD_31:
  LD A,(YCURSO)
L33CD_32:
  PUSH AF
  CALL CLR_LINE
  POP AF
  INC A
  CP $19
  JR C,L33CD_32
  RET
; This entry point is used by the routine at GETCHAR.
L33CD_33:
  LD HL,SECOND_SCREEN_ROW
  LD DE,SCREEN
  LD BC,$0780
  LDIR
  RET
L33CD_34:
  LD HL,LAST_SCREEN_ROW
  LD DE,SCREEN_END
  LD BC,$0780
  LDDR
  RET
; This entry point is used by the routines at SCR_CO, L3362 and FINLPT.
CONSOLE_RESET:
  LD A,(PICFLG)
  AND $7D
  LD (PICFLG),A
  LD (IX+$0A),$00
  LD (IX+$08),$00
  LD (IX+$01),$01
  LD (IX+$02),$0A
  RES 7,(IX+$03)
  SET 6,(IX+$03)
  RET

; CHR$(142) - BEL
;
; Used by the routine at L3362.
CONSOLE_BEL:
  LD DE,$007D
  LD HL,$2844
  LD (TMPSOUND),HL
  CALL SOUND
  EXX
; This entry point is used by the routine at L3362.
CONSOLE_NULL:
  RET

; Data block at 13812
CHR_DIAMOND:
  DEFB $00,$10,$38,$7C,$FE,$7C,$38,$10
  DEFB $00,$00

; Data block at 13822
CHR_DOTDOT:
  DEFB $00,$00,$00,$00,$00,$24,$00,$00
  DEFB $00,$00,$00

; BASIC string handler
;
; Used by the routine at FINREL_0.
STRCMP:
  PUSH DE
  CALL GSTRCU
  LD A,(HL)
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  POP DE
  PUSH BC
  PUSH AF
  CALL GSTRDE
  CALL LOADFP
  POP AF
  LD D,A
  POP HL

; Routine at 13855
CSLOOP:
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
  JR Z,CSLOOP
  CCF
  JP SIGNS

; Routine at 13878
__STR_S:
  CALL TSTNUM
  CALL NUMASC
  CALL CRTST
  CALL GSTRCU

; Save string in string area
SAVSTR:
  LD BC,TOPOOL
  PUSH BC

; Routine at 13894
;
; Used by the routine at __LET_5.
STRCPY:
  LD A,(HL)
  INC HL
  INC HL
  PUSH HL
  CALL TESTR
  POP HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  CALL CRTMST
  PUSH HL
  LD L,A
  CALL TOSTRA
  POP DE
  RET

; Routine at 13915
;
; Used by the routine at __CHR_S.
STRIN1:
  LD A,$01

; Make temporary string
;
; Used by the routine at CONCAT.
MKTMST:
  CALL TESTR

; Create temporary string entry
;
; Used by the routines at STRCPY, DTSTR and __LEFT_S.
CRTMST:
  LD HL,DSCTMP
  PUSH HL
  LD (HL),A
  INC HL
; This entry point is used by the routine at L2A38.
PUTDEI:
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; Create String
;
; Used by the routines at __PRINT, __STR_S and PRS.
CRTST:
  DEC HL

; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,$22
  LD D,B

; Create String, termination char in D
;
; Used by the routine at ITMSEP.
DTSTR:
  PUSH HL
  LD C,$FF
STRGET:
  INC HL
  LD A,(HL)
  INC C
  OR A
  JR Z,STRFIN
  CP D
  JR Z,STRFIN
  CP B
  JR NZ,STRGET
STRFIN:
  CP '"'
  CALL Z,_CHRGTB
  EX (SP),HL
  INC HL
  EX DE,HL
  LD A,C
  CALL CRTMST

; Temporary string to pool
;
; Used by the routines at CONCAT, TOPOOL and __LEFT_S.
TSTOPL:
  LD DE,DSCTMP
  LD HL,(TEMPPT)
  LD (FACCU),HL
  LD A,$01
  LD (VALTYP),A
  CALL VMOVE
  RST DCOMPR
  LD (TEMPPT),HL
  POP HL
  LD A,(HL)
  RET NZ
  LD DE,$001E
  JP ERROR
PRNUMS:
  INC HL

; Create string entry and print it
;
; Used by the routines at _ASCTFP, INIT, __LOAD, __CSAVE, L1ADB,
; PRINT_FNAME_MSG, ERROR, READY, NEXITM, INPBIN, SCCPTR and SHIFT_STOP.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routines at __PRINT and L2772.
PRS1:
  CALL GSTRCU
  CALL LOADFP
  INC E
PRS1_0:
  DEC E
  RET Z
  LD A,(BC)
  RST $18
  INC BC
  JR PRS1_0

; Test if enough room for string
;
; Used by the routines at STRCPY, MKTMST and __LEFT_S.
TESTR:
  OR A
  LD C,$F1
  PUSH AF
  LD HL,(STKTOP)
  EX DE,HL
  LD HL,(FRETOP)
  CPL
  LD C,A
  LD B,$FF
  ADD HL,BC
  INC HL
  RST DCOMPR
  JR C,TESTOS
  LD (FRETOP),HL
  INC HL
  EX DE,HL
  POP AF
  RET

; Routine at 14038
;
; Used by the routine at TESTR.
TESTOS:
  POP AF
  LD DE,$001A
  JP Z,ERROR
  CP A
  PUSH AF
  LD BC,$36BD
  PUSH BC

; Garbage collection
;
; Used by the routine at __FRE.
GARBGE:
  LD HL,(MEMSIZ)
; This entry point is used by the routine at ARYSTR.
GARBLP:
  LD (FRETOP),HL
  LD HL,$0000
  PUSH HL
  LD HL,(STREND)
  PUSH HL
  LD HL,TEMPST
TVAR:
  LD DE,(TEMPPT)
  RST DCOMPR
  LD BC,TVAR
  JP NZ,STPOOL
  LD HL,(VARTAB)
SMPVAR:
  LD DE,(ARYTAB)
  RST DCOMPR
  JR Z,ARRLP
  INC HL
  LD A,(HL)
  INC HL
  OR A
  CALL STRADD
  JR SMPVAR
GNXARY:
  POP BC
; This entry point is used by the routine at ARYSTR.
ARRLP:
  LD DE,(STREND)
  RST DCOMPR
  JP Z,SCNEND
  CALL LOADFP
  LD A,D
  PUSH HL
  ADD HL,BC
  OR A
  JP P,GNXARY
  LD (TEMP8),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL

; Routine at 14127
ARYSTR:
  EX DE,HL
  LD HL,(TEMP8)
  EX DE,HL
  RST DCOMPR
  JR Z,ARRLP
  LD BC,ARYSTR
; This entry point is used by the routine at GARBGE.
STPOOL:
  PUSH BC
  OR $80
; This entry point is used by the routine at GARBGE.
STRADD:
  LD A,(HL)
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  RET P
  OR A
  RET Z
  LD B,H
  LD C,L
  LD HL,(FRETOP)
  RST DCOMPR
  LD H,B
  LD L,C
  RET C
  POP HL
  EX (SP),HL
  RST DCOMPR
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
; This entry point is used by the routine at GARBGE.
SCNEND:
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
  LD H,B
  LD L,C
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
  LD DE,$001C
  JP C,ERROR
  CALL MKTMST
  POP DE
  CALL GSTRDE
  EX (SP),HL
  CALL GSTRHL
  PUSH HL
  LD HL,($499D)
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
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD L,A

; Move string in BC, (len in L) to string area
;
; Used by the routines at STRCPY and __LEFT_S.
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
; Used by the routine at GETLEN.
GETSTR:
  CALL TSTSTR

; Get string pointed by FPREG
;
; Used by the routines at __PLAY, STRCMP, __STR_S, PRS1 and __FRE.
GSTRCU:
  LD HL,(FACCU)

; Get string pointed by HL
;
; Used by the routine at CONCAT.
GSTRHL:
  EX DE,HL

; Get string pointed by DE
;
; Used by the routines at STRCMP, CONCAT and __LEFT_S.
GSTRDE:
  CALL FRETMS
  EX DE,HL
  RET NZ
  PUSH DE
  LD D,B
  LD E,C
  DEC DE
  LD C,(HL)
  LD HL,(FRETOP)
  RST DCOMPR
  JR NZ,POPHL
  LD B,A
  ADD HL,BC
  LD (FRETOP),HL
POPHL:
  POP HL
  RET

; a.k.a BAKTMP - Back to last tmp-str entry
;
; Used by the routines at __LET_5 and GSTRDE.
FRETMS:
  LD HL,(TEMPPT)
  DEC HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  DEC HL
  RST DCOMPR
  RET NZ
  LD (TEMPPT),HL
  RET

; Routine at 14331
__LEN:
  LD BC,PASSA
  PUSH BC

; Routine at 14335
;
; Used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR
  XOR A
  LD D,A
  LD (VALTYP),A
  LD A,(HL)
  OR A
  RET

; Routine at 14346
__ASC:
  LD BC,PASSA
  PUSH BC
; This entry point is used by the routine at L1CC0.
__ASC_0:
  CALL GETLEN
  JP Z,FC_ERR
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  RET

; Routine at 14363
__CHR_S:
  CALL STRIN1
  CALL MAKINT
  LD HL,($499D)
  LD (HL),E

; Save in string pool
TOPOOL:
  POP BC
  JP TSTOPL

; Routine at 14377
__LEFT_S:
  CALL LFRGNM
  XOR A
; This entry point is used by the routine at __RIGHT_S.
__LEFT_S_0:
  EX (SP),HL
  LD C,A
  PUSH HL
  LD A,(HL)
  CP B
  JR C,$3836
  LD A,B
  LD DE,$000E
  PUSH BC
  CALL TESTR
  POP BC
  POP HL
  PUSH HL
  INC HL
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

; Routine at 14424
__RIGHT_S:
  CALL LFRGNM
  POP DE
  PUSH DE
  LD A,(DE)
  SUB B
  JR __LEFT_S_0

; Routine at 14433
__MID_S:
  EX DE,HL
  LD A,(HL)
  CALL MIDNUM
  INC B
  DEC B
  JP Z,FC_ERR
  PUSH BC
  LD E,$FF
  CP $29
  JP Z,L3878

; Routine at 14451
L3873:
  RST SYNCHR

; Data block at 14452
L3874:
  DEFB ','

; Routine at 14453
L3875:
  CALL GETINT

; Routine at 14456
;
; Used by the routine at __MID_S.
L3878:
  RST SYNCHR

; Data block at 14457
L3879:
  DEFB $29

; Routine at 14458
L387A:
  POP AF
  EX (SP),HL
  LD BC,$382F
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

; Routine at 14477
__VAL:
  CALL GETLEN
  JP Z,ZERO
  LD E,A
  INC HL
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
  RST CHRGTB
  CALL H_ASCTFP
  POP BC
  POP HL
  LD (HL),B
  RET

; number in program listing and check for ending ')'
;
; Used by the routines at __LEFT_S and __RIGHT_S.
LFRGNM:
  EX DE,HL

; Routine at 14506
L38AA:
  RST SYNCHR

; Data block at 14507
L38AB:
  DEFB $29

; Routine at 14508
;
; Used by the routine at __MID_S.
MIDNUM:
  POP BC
  POP DE
  PUSH BC
  LD B,E
  RET

; Routine at 14513
__FRE:
  LD HL,(STREND)
  EX DE,HL
  LD HL,$0000
  ADD HL,SP
  LD A,(VALTYP)
  OR A
  JP Z,L29EA
  CALL GSTRCU
  CALL GARBGE
  LD DE,(STKTOP)
  LD HL,(FRETOP)
  JP L29EA

; a.k.a. DIMCON, Return from 'DIM' command
DIMRET:
  DEC HL
  RST CHRGTB
  RET Z

; Routine at 14547
L38D3:
  RST SYNCHR

; Data block at 14548
L38D4:
  DEFB ','



; Routine at 14549
__DIM:
  LD BC,DIMRET
  PUSH BC

; "OR n" to Mask 'XOR A' (Flag "Create" variable):   NON ZERO THING MUST TURN
; THE MSB ON
L38D9:
  DEFB $F6

; Get variable address to DE
;
; Used by the routines at L1CC0, __LET, GTVLUS, EVAL_VARIABLE, __DEF, __CONT
; and __NEXT.
GETVAR:
  XOR A
  LD (DIMFLG),A
  LD C,(HL)
; This entry point is used by the routine at L2A97.
GTFNAM:
  CALL __CONT_0
  JP C,SN_ERR
  XOR A
  LD B,A
  LD (VALTYP),A
  RST CHRGTB
  JR C,ISSEC
  CALL ISLETTER_A
  JR C,NOSEC
ISSEC:
  LD B,A
ENDNAM:
  RST CHRGTB
  JR C,ENDNAM
  CALL ISLETTER_A
  JR NC,ENDNAM
NOSEC:
  SUB $24
  JR NZ,GETVAR_0
  INC A
  LD (VALTYP),A
  RRCA
  ADD A,B
  LD B,A
  RST CHRGTB
GETVAR_0:
  LD A,(SUBFLG)
  DEC A
  JP Z,ARLDSV
  JP P,GETVAR_1
  LD A,(HL)
  SUB $28
  JP Z,SBSCPT
GETVAR_1:
  XOR A
  LD (SUBFLG),A
  PUSH HL
  LD D,B
  LD E,C
  LD HL,(PRMNAM)
  RST DCOMPR
  LD DE,PRMVAL
  JP Z,POPHLRT
  LD HL,(ARYTAB)
  EX DE,HL
  LD HL,(VARTAB)
GETVAR_2:
  RST DCOMPR
  JP Z,SMKVAR
  LD A,C
  SUB (HL)
  INC HL
  JP NZ,GETVAR_3
  LD A,B
  SUB (HL)
GETVAR_3:
  INC HL
  JP Z,NTFPRT
  INC HL
  INC HL
  INC HL
  INC HL
  JP GETVAR_2
SMKVAR:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,EVAL_VARIABLE_1
  RST DCOMPR
  POP DE
  JP Z,FINZER
  EX (SP),HL
  PUSH HL
  PUSH BC
  LD BC,$0006
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
ZEROER:
  DEC HL
  LD (HL),$00
  RST DCOMPR
  JR NZ,ZEROER
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
NTFPRT:
  EX DE,HL
  POP HL
  RET
FINZER:
  LD (FPEXP),A
  LD HL,NULL_STRING
  LD (FACCU),HL
  POP HL
  RET

; Sort out subscript
;
; Used by the routine at GETVAR.
SBSCPT:
  PUSH HL
  LD HL,(DIMFLG)
  EX (SP),HL
  LD D,A

; SBSCPT loop
SCPTLP:
  PUSH DE
  PUSH BC
  CALL _CHRGTB_2
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
  JP Z,SCPTLP

; Routine at 14748
DOCHRT:
  RST SYNCHR

; Data block at 14749
L399D:
  DEFB $29

; Routine at 14750
SUBSOK:
  LD (NXTOPR),HL
  POP HL
  LD (DIMFLG),HL
  LD E,$00
  PUSH DE

; "LD DE,nn", OVER THE NEXT TWO BYTES
L39A8:
  DEFB $11

; a.k.a. ERSFIN
;
; Used by the routine at GETVAR.
ARLDSV:
  PUSH HL
  PUSH AF
  LD HL,(ARYTAB)

; "LD A,n" AROUND THE NEXT BYTE
L39AE:
  DEFB $3E

; Routine at 14767
FNDARY:
  ADD HL,DE
  LD DE,(STREND)
  RST DCOMPR
  JR Z,CREARY
  LD A,(HL)
  INC HL
  CP C
  JR NZ,NXTARY
  LD A,(HL)
  CP B
NXTARY:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  JR NZ,FNDARY
  LD A,(DIMFLG)
  OR A
  JP NZ,DD_ERR
  POP AF
  LD B,H
  LD C,L
  JP Z,POPHLRT
  SUB (HL)
  JP Z,FINDEL

; entry for '?BS ERROR'
;
; Used by the routines at MLDEBC and INLPNM.
BS_ERR:
  LD DE,CHRGTB
  JP ERROR
; This entry point is used by the routine at FNDARY.
CREARY:
  LD DE,VERSION
  POP AF
  JP Z,FC_ERR
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
GETSIZ:
  LD BC,$000B
  JR NC,DEFSIZ
  POP BC
  INC BC
DEFSIZ:
  LD (HL),C
  PUSH AF
  INC HL
  LD (HL),B
  INC HL
  PUSH HL
  CALL MLDEBC
  EX DE,HL
  POP HL
  POP AF
  DEC A
  JR NZ,GETSIZ
  PUSH AF
  LD B,D
  LD C,E
  EX DE,HL
  ADD HL,DE
  JP C,OM_ERR
  CALL ENFMEM
  LD (STREND),HL
ZERARY:
  DEC HL
  LD (HL),$00
  RST DCOMPR
  JR NZ,ZERARY
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
  JR C,ENDDIM
; This entry point is used by the routine at FNDARY.
FINDEL:
  LD B,A
  LD C,A
  LD A,(HL)
  INC HL

; "LD D,n" to skip "POP HL"
L3A38:
  DEFB $16

; Routine at 14905
INLPNM:
  POP HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  PUSH AF
  RST DCOMPR
  JP NC,BS_ERR
  PUSH HL
  CALL MLDEBC
  POP DE
  ADD HL,DE
  POP AF
  DEC A
  LD B,H
  LD C,L
  JR NZ,INLPNM
  ADD HL,HL
  ADD HL,HL
  POP BC
  ADD HL,BC
  EX DE,HL
; This entry point is used by the routine at BS_ERR.
ENDDIM:
  LD HL,(NXTOPR)
  RET
; This entry point is used by the routine at PRINT_FNAME_MSG.
INLPNM_0:
  LD A,$02
  OUT ($AF),A
  DI
INLPNM_1:
  PUSH BC
  LD BC,$0000
INLPNM_2:
  EX (SP),HL
  EX (SP),HL
  NOP
  DEC C
  JR NZ,INLPNM_2
  DJNZ INLPNM_2
  POP BC
  DJNZ INLPNM_1
; This entry point is used by the routine at __CSAVE.
INLPNM_3:
  PUSH BC
  PUSH AF
  LD BC,$0000
INLPNM_4:
  DEC BC
  LD A,B
  OR C
  JR NZ,INLPNM_4
  POP AF
  POP BC
; This entry point is used by the routine at L1CC0.
_TAPIOF:
  PUSH AF
  LD A,$00
  OUT ($AF),A
  POP AF
  EI
  RET
; This entry point is used by the routine at L1CC0.
INLPNM_5:
  OR A
  PUSH AF
  LD A,$02
  OUT ($AF),A
  LD HL,$0000
INLPNM_6:
  DEC HL
  LD A,H
  OR L
  JR NZ,INLPNM_6
  POP AF
; This entry point is used by the routine at L1CC0.
INLPNM_7:
  LD A,($482A)
  JR Z,INLPNM_8
  ADD A,A
  ADD A,A
INLPNM_8:
  LD B,A
  LD C,$00
  DI
INLPNM_9:
  CALL INLPNM_15
  CALL INLPNM_13
  DEC BC
  LD A,B
  OR C
  JR NZ,INLPNM_9
  JP ISCNTC_0
; This entry point is used by the routine at L1CC0.
INLPNM_10:
  LD HL,(AUTORUN)
  PUSH AF
  LD A,L
  SUB $0E
  LD L,A
  CALL INLPNM_16
  POP AF
  LD B,$08
INLPNM_11:
  RRCA
  CALL C,INLPNM_14
  CALL NC,INLPNM_12
  DJNZ INLPNM_11
  CALL INLPNM_14
  CALL INLPNM_14
  JP ISCNTC_0
INLPNM_12:
  LD HL,(AUTORUN)
  CALL INLPNM_16
INLPNM_13:
  RET
INLPNM_14:
  CALL INLPNM_15
  EX (SP),HL
  EX (SP),HL
  NOP
  NOP
  NOP
  NOP
  CALL INLPNM_15
  RET
INLPNM_15:
  LD HL,($4828)
INLPNM_16:
  PUSH AF
INLPNM_17:
  DEC L
  JP NZ,INLPNM_17
  LD A,$03
  OUT ($AF),A
INLPNM_18:
  DEC H
  JP NZ,INLPNM_18
  LD A,$02
  OUT ($AF),A
  POP AF
  RET
; This entry point is used by the routines at __LOAD, L1A50 and L1CC0.
INLPNM_19:
  LD A,$02
  OUT ($AF),A
  DI
INLPNM_20:
  LD HL,$0457
INLPNM_21:
  LD D,C
  CALL INLPNM_37
  RET C
  LD A,C
  CP $DE
  JR NC,INLPNM_20
  CP $05
  JR C,INLPNM_20
  SUB D
  JR NC,INLPNM_22
  CPL
  INC A
INLPNM_22:
  CP $04
  JR NC,INLPNM_20
  DEC HL
  LD A,H
  OR L
  JR NZ,INLPNM_21
  LD HL,$0000
  LD B,L
  LD D,L
INLPNM_23:
  CALL INLPNM_37
  RET C
  ADD HL,BC
  DEC D
  JP NZ,INLPNM_23
  LD BC,$05FA
  ADD HL,BC
  LD A,H
  RRA
  AND $7F
  LD D,A
  ADD HL,HL
  LD A,H
  SUB D
  LD D,A
  SUB $05
  LD (LOWLIM),A
  LD A,D
  ADD A,A
  LD B,$00
INLPNM_24:
  SUB $03
  INC B
  JR NC,INLPNM_24
  LD A,B
  SUB $03
  LD (WINWID),A
  OR A
  RET
; This entry point is used by the routine at L1CC0.
INLPNM_25:
  LD A,(LOWLIM)
  LD D,A
INLPNM_26:
  CALL ISCNTC_0
  RET C
  IN A,($AF)
  RLCA
  JR NC,INLPNM_26
INLPNM_27:
  CALL ISCNTC_0
  RET C
  IN A,($AF)
  RLCA
  JR C,INLPNM_27
  LD E,$00
  CALL INLPNM_33
INLPNM_28:
  LD B,C
  CALL INLPNM_33
  RET C
  LD A,B
  ADD A,C
  JR C,INLPNM_28
  CP D
  JR C,INLPNM_28
  LD L,$08
INLPNM_29:
  CALL INLPNM_30
  CP $04
  CCF
  RET C
  CP $02
  CCF
  RR D
  LD A,C
  RRCA
  CALL NC,INLPNM_34
  CALL INLPNM_33
  DEC L
  JP NZ,INLPNM_29
  CALL ISCNTC_0
  LD A,D
  RET
INLPNM_30:
  LD A,(WINWID)
  LD B,A
  LD C,$00
INLPNM_31:
  IN A,($AF)
  XOR E
  JP P,INLPNM_32
  LD A,E
  CPL
  LD E,A
  INC C
  DJNZ INLPNM_31
  LD A,C
  RET
INLPNM_32:
  NOP
  NOP
  NOP
  NOP
  DJNZ INLPNM_31
  LD A,C
  RET
INLPNM_33:
  CALL ISCNTC_0
  RET C
INLPNM_34:
  LD C,$00
INLPNM_35:
  INC C
  JR Z,INLPNM_36
  IN A,($AF)
  XOR E
  JP P,INLPNM_35
  LD A,E
  CPL
  LD E,A
  RET
INLPNM_36:
  DEC C
  RET
INLPNM_37:
  CALL ISCNTC_0
  RET C
  IN A,($AF)
  RLCA
  JR C,INLPNM_37
  LD E,$00
  CALL INLPNM_34
  JP INLPNM_35
; This entry point is used by the routine at CHRGTB.
_OUTDO:
  CALL OUTHK
  PUSH AF
  LD A,(PRTFLG)
  OR A
  JR Z,_OUTCON
  DEC A
  JR Z,OUTC_TABEXP
  POP AF
  JP L1CC0_18
OUTC_TABEXP:
  LD A,(RAWPRT)
  CP $FF
  JR Z,NO_TAB_1
  POP AF
  PUSH AF
  CP $09
  JR NZ,NO_TAB
TABEXP_LOOP:
  LD A,$20
  RST $18
  LD A,(LPTPOS)
  AND $07
  JR NZ,TABEXP_LOOP
  POP AF
  RET

; Routine at 15354
;
; Used by the routine at INLPNM.
NO_TAB:
  SUB $0D
  JR Z,NO_TAB_0
  JR C,NO_TAB_1
  CP $13
  JR C,NO_TAB_1
  LD A,(LPTPOS)
  CP $84
  CALL Z,OUTDO_CRLF_0
  INC A
NO_TAB_0:
  LD (LPTPOS),A
; This entry point is used by the routine at INLPNM.
NO_TAB_1:
  POP AF
  JP OUTPRT_CHR

; Disable printer echo if enabled
;
; Used by the routines at READY, ENFMEM and INPBRK.
FINLPT:
  LD A,$01
  LD (PRTFLG),A
  LD A,(PRTSTT)
  BIT 7,A
  RES 7,A
  LD (PRTSTT),A
  JR NZ,FINLPT_0
  LD A,(LPTPOS)
  OR A
FINLPT_0:
  CALL NZ,OUTDO_CRLF_0
  LD A,(PICFLG)
  AND $40
  LD (PICFLG),A
  XOR A
  LD (PRTFLG),A
  LD (PRTSTT),A
  RET
; This entry point is used by the routine at INLPNM.
_OUTCON:
  POP AF
  JP _CHPUT
; This entry point is used by the routines at ERROR, READY, INPBRK and SCCPTR.
CONSOLE_CRLF:
  CALL CONSOLE_RESET
  LD A,(CURPOS)
  DEC A
  RET Z
  JR OUTDO_CRLF_2
; This entry point is used by the routine at SHIFT_STOP.
FINLPT_1:
  DEC HL
  LD A,(HL)
  CP ' '
  JR Z,FINLPT_1
  INC HL
; This entry point is used by the routine at SHIFT_STOP.
FINLPT_2:
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET

; a.k.a. CRDO
;
; Used by the routines at INIT, __LOAD, PRINT_FNAME_MSG, __PRINT and __LIST.
OUTDO_CRLF:
  CALL CRDHK
  LD A,(PRTFLG)
  OR A
  JR Z,OUTDO_CRLF_2
  DEC A
  JR NZ,OUTDO_CRLF_1
; This entry point is used by the routines at NO_TAB and FINLPT.
OUTDO_CRLF_0:
  LD A,$0D
  RST $18
  LD A,$0A
  RST $18
  XOR A
  LD (LPTPOS),A
  RET
OUTDO_CRLF_1:
  LD A,$0D
  RST $18
  RET
; This entry point is used by the routine at FINLPT.
OUTDO_CRLF_2:
  LD A,$03
  RST $18
  XOR A
  RET

; Check STOP key status
;
; Used by the routines at MUSIC, L24BD and __LIST.
ISCNTC:
  CALL SHIFT_STOP
  JP __STOP
; This entry point is used by the routine at INLPNM.
ISCNTC_0:
  EX (SP),HL
  EX (SP),HL

; scans SHIFT / STOP keys
;
; Used by the routines at _SHIFT_STOP and ISCNTC.
SHIFT_STOP:
  IN A,($81)
  AND $01
  RET NZ
  IN A,($80)
  AND $04
  RET NZ
  LD A,($4889)
  OR A
  RET NZ
  LD (IX+$05),$F2
  LD (IX+$07),$00
  LD (IX+$06),$00
  SCF
  RET
; This entry point is used by the routine at L2772.
SHIFT_STOP_0:
  LD A,$3F
  RST $18
  LD A,$20
  RST $18
; This entry point is used by the routine at PROMPT.
SHIFT_STOP_1:
  CALL PINLIN
  LD HL,KBUF
; This entry point is used by the routine at L3DE1.
SHIFT_STOP_2:
  LD A,(GETFLG)
  OR A
  JR Z,SHIFT_STOP_3
  CALL L1CC0_35
  JR NZ,SHIFT_STOP_4
  JR FINLPT_2
SHIFT_STOP_3:
  CALL T_EDIT
  OR A
  JR NZ,SHIFT_STOP_4
  CALL SHIFT_STOP
  JR NC,SHIFT_STOP_3
  RET
SHIFT_STOP_4:
  CP $0D
  JR Z,FINLPT_1
  RES 7,A
  LD (HL),A
  LD DE,ENDBUF-1
  RST DCOMPR
  JP L3DE1
; This entry point is used by the routine at L3DE1.
SHIFT_STOP_5:
  INC HL
  JR SHIFT_STOP_2
; This entry point is used by the routine at NO_TAB.
OUTPRT_CHR:
  PUSH BC
  PUSH DE
  PUSH HL
  PUSH AF
  CALL KBDSCAN
  CP $D8
  CALL Z,SHIFT_STOP_18
  LD A,(PRTSTT)
  BIT 6,A
  JR NZ,SHIFT_STOP_6
  CALL SHIFT_STOP_8
SHIFT_STOP_6:
  CALL SHIFT_STOP_10
  JR C,SHIFT_STOP_7
  POP AF
  PUSH AF
  CALL OUTPRT_XLATE
  DI
  CALL SHIFT_STOP_20
  EI
SHIFT_STOP_7:
  POP AF
  POP HL
  POP DE
  POP BC
  RET
SHIFT_STOP_8:
  SET 6,A
  LD (PRTSTT),A
  PUSH AF
  LD HL,(PRTINT)
SHIFT_STOP_9:
  LD A,(HL)
  OR A
  CALL NZ,OUTPRT_CHR
  INC HL
  JR NZ,SHIFT_STOP_9
  POP AF
  RET
SHIFT_STOP_10:
  RLA
  RET C
  RRA
  AND $F0
  LD (PRTSTT),A
SHIFT_STOP_11:
  LD HL,$1B58
SHIFT_STOP_12:
  IN A,($10)
  AND $02
  RET Z
  DEC HL
  XOR A
SHIFT_STOP_13:
  DEC A
  OR A
  JR NZ,SHIFT_STOP_13
  LD A,H
  OR L
  JR NZ,SHIFT_STOP_12
  XOR A
  LD (PRTFLG),A
  LD B,$05
SHIFT_STOP_14:
  LD A,$0E
  RST $18
  DJNZ SHIFT_STOP_14
  LD HL,PRTSTT
  SET 0,(HL)
  LD A,(PRTCOM)
  RRA
  JR C,SHIFT_STOP_16
  LD HL,PRINTER_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,SHIFT_STOP_15
  LD HL,PRINTER_MSG
SHIFT_STOP_15:
  CALL PRS
SHIFT_STOP_16:
  LD A,$01
  LD (PRTFLG),A
SHIFT_STOP_17:
  CALL KBDSCAN
  OR A
  JR Z,SHIFT_STOP_17
  CP $D8
  JR NZ,SHIFT_STOP_11
SHIFT_STOP_18:
  CALL KBDSCAN
  CP $D8
  JR Z,SHIFT_STOP_18
  LD HL,PRTSTT
  LD A,$80
  XOR (HL)
  LD (HL),A
  RLA
  RET
OUTPRT_XLATE:
  PUSH AF
  LD A,(RAWPRT)
  OR A
  JR NZ,SHIFT_STOP_19
  LD HL,(PRTXLT)
  LD A,H
  OR L
  JR Z,SHIFT_STOP_19
  POP AF
  ADD A,L
  LD L,A
  LD A,$00
  ADC A,H
  LD H,A
  LD A,(HL)
  PUSH AF
SHIFT_STOP_19:
  POP AF
  RET
SHIFT_STOP_20:
  OUT ($11),A
  LD A,$00
  OUT ($10),A
  LD A,$01
  OUT ($10),A
  RET
; This entry point is used by the routine at ENFMEM.
NEW_1:
  LD (AUTFLG),A
  LD (HL),A
  INC HL
  LD (HL),A
  JP RUN_FST_0
; This entry point is used by the routine at PROMPT.
PROMPT_B:
  PUSH HL
  CALL LINPRT
  POP DE
  CALL SRCHLN
  JP NC,PROMPT_0
  LD A,$A0
  JP PROMPT_1
; This entry point is used by the routine at PROMPT.
SHIFT_STOP_21:
  JR C,AUTRES
  PUSH DE
  LD DE,$FFF9
  RST DCOMPR
  POP DE
  JR NC,AUTRES
  LD (AUTLIN),HL
  JR SHIFT_STOP_22
AUTRES:
  XOR A
  LD (AUTFLG),A
SHIFT_STOP_22:
  JP AUTSTR
; This entry point is used by the routine at SCR_CO.
SHIFT_STOP_23:
  LD HL,CHR_DOTDOT
  CALL CHR_UPDATE
  LD A,$20
  LD HL,CHR_DIAMOND
  JP SCR_CO_1

; Routine at 15822
__NEW:
  JP Z,CLRPTR
  CALL ATOH
  RET NZ
  LD BC,READY
  PUSH BC
  CALL SRCHLN
  LD H,B
  LD L,C
  JP NEW_0

; Routine at 15841
;
; Used by the routine at SHIFT_STOP.
L3DE1:
  JR C,L3DE1_0
  JP NZ,SHIFT_STOP_2
  LD A,$0E
  RST $18
L3DE1_0:
  JP SHIFT_STOP_5

; Get INPUT with prompt, HL = resulting text
;
; Used by the routines at L2772 and GTVLUS.
QINLIN:
  LD A,(PICFLG)
  SET 5,A
  LD (PICFLG),A
  SET 6,(IX+$03)
  JP L2772_0
; This entry point is used by the routine at T_EDIT.
QINLIN_0:
  CP $06
  JR NZ,QINLIN_2
  LD A,(PICFLG)
  BIT 5,A
  JP L33CD_13
QINLIN_1:
  JP T_EDIT_2
QINLIN_2:
  CP $1F
  JR NZ,QINLIN_1
  JP T_EDIT_1
; This entry point is used by the routine at T_EDIT.
QINLIN_3:
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,T_EDIT_13
  LD A,$06
  RST $18
  JP T_EDIT_15
; This entry point is used by the routine at L33CD.
QINLIN_4:
  JP M,L33CD_25
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,L33CD_25
  JP L33CD_24
; This entry point is used by the routine at T_EDIT.
QINLIN_5:
  JP Z,T_EDIT_24
  PUSH AF
  LD A,($4889)
  OR A
  JR NZ,QINLIN_6
  POP AF
  JP T_EDIT_0
QINLIN_6:
  POP AF
  JP QINLIN_0

; Data block at 15935
L3E3F:
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF
