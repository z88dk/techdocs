
; This ASM source can be used to create byte-identical ROM images for the
; Philips (Radiola) VG-5000 computer family
; Most of the location entries were kept in the few existing ROM versions, it is relatively safe to rely on them.

; z80asm -b -m -l vg5000.asm
; Older version v1.0:  add -DV10




; --- Prefixes, Tokens.. --- 


defc PTRCON   = 13  ; $0D - A LINE REFERENCE CONSTANT
defc LINCON   = 14  ; $0E - A LINE NUMBER UNCONVERTED TO POINTER

;------------------------------------

defc CLMWID   =   13   ; MAKE COMMA COLUMNS FOURTEEN CHARACTERS

defc LPTLEN   =  132   ; Max column size on printer
defc LPTSIZ   =  LPTLEN    ; LPTSIZ on other targets is a variable, here we use the static value


;------------------------------------
;   BASIC SYSTEM VARIABLES AREA
;------------------------------------

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

defc INTDIV            = $47FA	; <-- IX+$00
defc INTACT            = $47FB	; <-- IX+$01
defc INTRAT            = $47FC	; <-- IX+$02
defc CURSOR            = $47FD	; <-- IX+$03

;uppercase/lowercase switch flag
defc FKLOCK            = $47FE	; <-- IX+$04

defc CRCHAR            = $47FF	; <-- IX+$05
defc REPTIM            = $4800	; <-- IX+$06
defc REPENA            = $4801	; <-- IX+$07
defc ATTRCAR           = $4802	; <-- IX+$08

;Bits 0 to 2	column 0 ink color
;Bit 3	= 0
;Bits 4 to 6	background color
;Bit 7	= 1
defc ATTBAK            = $4803	; <-- IX+$09

;Character redefinition flag :
;Bits 0 to 6	= 0
;Bit 7	0 = normal / 1 = redifined
defc EXTENF            = $4804	; <-- IX+$0A

defc CURPOS            = $4805
defc YCURSO            = $4806
defc PRELIN            = $4807
defc DOT               = $4809
defc RETADR            = $480B
defc ENTSTT            = $480D
defc TMPSOUND          = $480E

defc FILETAB           = $4810
defc FILNAM            = $4811
defc FILSTAR           = $4817
defc FILTYPE           = $4818
defc FILNM2            = $4819
defc SAVADDR           = $4820
defc SAVLEN            = $4822
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
defc BUF10             = $487A

defc AUTFLG            = $4884
defc AUTLIN            = $4885
defc AUTINC            = $4887

defc LINLEN            = $488A
defc NCMPOS            = $488B
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
defc TMPSTR            = $499D
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
defc FPEXP             = FACCU+3
defc RSTHK             = $47DC
defc SGNRES            = $49EA
defc FBUFFR            = $49EB
defc MULVAL            = $49F8
defc MULVAL2           = $49F9

defc SYSVAR_TOP        = $49FB      ;  BASIC PROGRAM is positioned at SYSVAR_TOP+1 (usually held by TXTTAB)



; TOKEN table position = $209E, word list in classic encoding mode
;
; -- STATEMENTS --
;
defc TK_END      =  $80	; Token for 'END'
defc TK_FOR      =  $81	; Token for 'FOR'
defc TK_NEXT     =  $82	; Token for 'NEXT'
defc TK_DATA     =  $83	; Token for 'DATA'
defc TK_INPUT    =  $84	; Token for 'INPUT'
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
defc TK_PLAY     =  $A2
defc TK_TX       =  $A3
defc TK_GR       =  $A4
defc TK_SCREEN   =  $A5
defc TK_DISPLAY  =  $A6
defc TK_STORE    =  $A7
defc TK_SCROLL   =  $A8
defc TK_PAGE     =  $A9
defc TK_DELIM    =  $AA
defc TK_SETE     =  $AB
defc TK_ET       =  $AC
defc TK_EG       =  $AD
defc TK_CURSOR   =  $AE
defc TK_DISK     =  $AF

defc TK_MODEM    =  $B0
defc TK_NEW      =  $B1

; FUNCTIONS

defc TK_TAB      =  $B2 ; Token for 'TAB('
defc TK_TO       =  $B3	; Token for 'TO' identifier in a 'FOR' statement
defc TK_FN       =  $B4	; Token for 'FN'
defc TK_SPC      =  $B5	; Token for 'SPC('
defc TK_THEN     =  $B6	; Token for 'THEN'
defc TK_NOT      =  $B7	; Token for 'NOT'
defc TK_STEP     =  $B8 ; Token for 'STEP' identifier in a 'FOR' statement

; OPERATORS

defc TK_PLUS     =  $B9 ; Token for '+'
defc TK_MINUS    =  $BA ; Token for '-'
defc TK_STAR     =  $BB	; Token for '*'
defc TK_SLASH    =  $BC	; Token for '/'

; 8K BASIC OPERATORS

defc TK_EXPONENT =  $BD	; Token for '^'
defc TK_AND      =  $BE	; Token for 'AND'
defc TK_OR       =  $BF	; Token for 'OR'

; RELATIONAL OPERATORS

defc TK_GREATER  =  $C0 ; Token for '>'
defc TK_EQUAL    =  $C1 ; Token for '='
defc TK_MINOR    =  $C2	; Token for '<'

; FUNCTIONS

defc TK_SGN      =  $C3
defc TK_INT      =  $C4
defc TK_ABS      =  $C5
defc TK_USR      =  $C6
defc TK_FRE      =  $C7
defc TK_LPOS     =  $C8
defc TK_POS      =  $C9
defc TK_SQR      =  $CA
defc TK_RND      =  $CB
defc TK_LOG      =  $CC
defc TK_EXP      =  $CD
defc TK_COS      =  $CE
defc TK_SIN      =  $CF
defc TK_TAN      =  $D0
defc TK_ATN      =  $D1
defc TK_PEEK     =  $D2
defc TK_LEN      =  $D3
defc TK_STR_S    =  $D4
defc TK_VAL      =  $D5
defc TK_ASC      =  $D6
defc TK_STICKX   =  $D7
defc TK_STICKY   =  $D8
defc TK_ACTION   =  $D9
defc TK_KEY      =  $DA
defc LPEN        =  $DB
defc TK_CHR_S    =  $DC
defc TK_LEFT_S   =  $DD
defc TK_RIGHT_S  =  $DE
defc TK_MID_S    =  $DF



;------------------------------------
;   MACRO DEFINITIONS
;------------------------------------

MACRO M_WAIT_VDP
  LD A,$20
  OUT ($8F),A             ; $20=Status
;loop:
  IN A,($CF)
  OR A
  JP M,ASMPC-3            ; Wait for VDP ready
ENDM


; Unused, based on the Technical Bulletin 1984.11.09
; Examine the VS status bit in the video controller (VGP)
MACRO M_WAIT_VSYNC
  LD A,$20
  OUT ($8F),A             ; $20=Status
W_LOOP:
  IN A,($CF)
  BIT 2,A
  JR NZ,W_LOOP
ENDM




;------------------------------------
;               CODE
;------------------------------------


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

; (a.k.a. CHKSYN) Check syntax, 1 byte follows to be compared
;
; Used by the routines at __SOUND, __SETE, L0E17, L0E2B, __INIT, __DELIM,
; L1BA2, L1C74, L1C80, L1CBE, FORFND, __LET, __ON, __IF, __TAB, __INPUT,
; LOPDT2, FRMEQL, OPNPAR, L2910, EVAL_VARIABLE, __DEF, L2A36, GETFNM, __POKE, __CLEAR,
; HEXCNS, __RENUM, __AUTO, __MID_S, LFRGNM, DIMRET and DOCHRT.
SYNCHR:
  LD A,(HL)         ; Check syntax of character
  EX (SP),HL        ; Address of test byte
  CP (HL)           ; Same as in code string?                ;CMPC-IS CHAR THE RIGHT ONE?
  INC HL            ; Return address
  EX (SP),HL        ; Put it back
  JP NZ,SN_ERR      ; Different - ?SN Error                  ;GIVE ERROR IF CHARS DONT MATCH

; (a.k.a. GETCHR, GETNEXT), pick next char from program
;
; Used by the routines at _ASCTFP, CLOAD_END, L1BA4, L1C82, L1CC0, PROMPT, FNDWRD,
; FORFND, _CHRGTB, ATOH2, GTLNLP, __IF, __LPRINT, NEXITM, SCNVAL, INPBIN,
; FDTLP, STKTHS, OPRND, VARRET, __DEF, DOFN, FNDNUM, CONINT, __CLEAR,
; __CLEAR, __NEXT, HEXCNS, SCCPTR, __LIST, __VAL, DIMRET and GETVAR.
;
; NEWSTT FALLS INTO CHRGET. THIS FETCHES THE FIRST CHAR AFTER
; THE STATEMENT TOKEN AND THE CHRGET'S "RET" DISPATCHES TO STATEMENT
;
CHRGTB:
  INC HL                  ; Point to next character          ;DUPLICATION OF CHRGET RST FOR SPEED
  LD A,(HL)               ; Get next code string byte        ;SEE CHRGET RST FOR EXPLANATION
  CP ':'                  ; Z if ":"                         ;IS IT END OF STATMENT OR BIGGER
  RET NC                  ; NC if > "9"
  JP _CHRGTB_0

; This entry point is used by the routines at PRINT_FNAME_MSG, PROMPT, __TAB,
; GTVLUS, T_EDIT, __LIST, PRS1, INLPNM, OUTDO_CRLF, SHIFT_STOP, RINPUT_SUB and
; QINLIN.

OUTDO:
  JP _OUTDO

  JP CHR_UPDATE

  DEFB $FF,$00

; compare DE and HL (aka CPDEHL)
;
; Used by the routines at INIT, L1CC0, BAKSTK, ERROR, PROMPT, SRCHLP, FNDWRD,
; __FOR, GTLNLP, __GOTO, __LET, MOVUP, __CLEAR, __RENUM, __LIST, TSTOPL, TESTR,
; GARBGE, ARYSTR, GSTRDE, FRETMS, GETVAR, FNDARY, BS_ERR, INLPNM and
; SHIFT_STOP.
DCOMPR:
  LD A,H                  ; Get H
  SUB D                   ; Compare with D
  RET NZ                  ; Different - Exit
  LD A,L                  ; Get L
  SUB E                   ; Compare with E
  RET                     ; Return status

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
; NUMASC, POWER, __RND, __SIN, __ATN, FORFND, DEPINT and __IF.
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
  DEC (IX+$00)            ; Screen refresh counter
  JP NZ,DO_INT
  LD A,(IX+$02)           ; Reference value for Interrupt frequency
  LD (IX+$00),A           ; Screen refresh counter
  BIT 0,(IX+$01)          ;
  RES 0,(IX+$01)
  JP Z,DO_INT

  PUSH BC
  PUSH DE
  PUSH HL

; Screen display
_DISPLAY:
  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  LD A,$82
  OUT ($CF),A             ; $82=Indirect 
  LD A,$29
  OUT ($8F),A             ; $29=Data register R1 + exec request
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
  DEFS 10, $FF

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

;Prints a 16 bits character on the screen, without using the video buffer handled by the Z80.
; Character position is set in HL, 
; H sets the line: 0 -> line 0, 8-31 -> lines 1-24, 
; and L sets the colmumn : 0-39 -> columns 0-39.
;D sets the character code, and E sets its attribute.
; BC and AF registers are altered.
_PUTCHAR_XY:
  JP PUTCHAR_XY

;Prints a 16 bits character on the screen, without using the video buffer handled by the Z80.
; The character is printed at the cursor current position.
; D sets the character code, and E sets its attribute.
; BC and AF registers are altered.
_PUTCHAR:
  JP PUTCHAR

; Reads a 16 bits character directly in the screen memory, at position defined by HL (codage like $0092).
; Character code is retrieved in D, attribute in E.
; AF, BC and DE registers are altered.
_GETCHAR_XY:
  JP GETCHAR_XY

; Reads a 16 bits character directly in the screen memory, at cursor current position.
; Character code is retrieved in D, attribute in E.
; AF, BC and DE registers are altered.
_GETCHAR:
  JP GETCHAR

; Clears the screen and resets the background color defines in $4803, and ink color defined in $4802.
; All registers are altered.
_CLR_SCR:
  JP CLR_SCR

; Clears a line and resets the background and ink colors (idem $009E).
; A must be set to the line number to erase.
; All registers are altered.
_CLR_LINE:
  JP CLR_LINE

; wait EF9345 ready
; Stops the execution of the program, until the video circuit is ready for data transfer.
; AF register is altered
_VDP_READY:
  JP VDP_READY

; Calculates the physical address of a screen position, giving a column and a line numbers.
; H must be the line and L the column. The address is retrievd in HL. All registers are altered.
_SCRADR:
  JP SCRADR

; keyboard scanning
_KBDSCAN:
  JP KBDSCAN

; Loads the EF9345 registers in a table whose address is given by HL.
; The first Byte in the table is the length of the table.
; Registers are coded with 2 Bytes each, first Byte is the selection address of the register,
; the second one is the data itself. AF, BC and HL registers are altered.
;
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
  LD A,(IX+$03)          ; CURSOR
  AND $BF
  OUT ($CF),A
  LD C,$CF
  LD A,$26
  OUT ($8F),A             ; $26=Main pointer R6 (Y)
  XOR A
  OUT (C),A
  LD A,$27
  OUT ($8F),A             ; $27=Main pointer R7 (X)
  XOR A
  OUT (C),A

; Send the first line of the screen

  LD HL,SCREEN
  LD E,$03
  LD B,80                 ; send 80 bytes

IF !V10
  LD A,$20
  OUT ($8F),A             ; $20=Command register
  OUT (C),E               ; Write on VDP memory and increment
ENDIF

DISPLAY_1:
  LD A,$22
  OUT ($8F),A
  OUTI                    ; send attribute

IF V10
  LD A,$21
  OUT ($8F),A
  OUTI
  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  OUT (C),E               ; Write on VDP memory and increment
ELSE
  LD A,$29
  OUT ($8F),A             ; $29=Data register R1 + exec request
  OUTI                    ; send character
ENDIF

  JR NZ,DISPLAY_1

  LD A,$26
  OUT ($8F),A             ; $26=Main pointer R6 (Y)
  LD A,$08
  OUT (C),A
  LD A,$27
  OUT ($8F),A             ; $27=Main pointer R7 (X)
  XOR A
  OUT (C),A

; Send the following lines

  LD D,24                 ; 24 rows
DISPLAY_3:
  LD B,$78

IF V10
DISPLAY_ROWS:
ENDIF

  M_WAIT_VDP

IF V10
  LD A,$22
ELSE
  LD A,$20
ENDIF
  OUT ($8F),A             ; $20=Command register

IF V10
  OUTI
ELSE
  OUT (C),E
ENDIF

IF !V10
DISPLAY_ROWS:
ENDIF

  M_WAIT_VDP

IF V10
  LD A,$21
ELSE
  LD A,$22
ENDIF
  OUT ($8F),A             ; $22

  OUTI

IF V10
  LD A,$28
ELSE
  LD A,$29
ENDIF
  OUT ($8F),A             ; $29=Data register R1 + exec request

IF V10
  OUT (C),E
ELSE
  OUTI
ENDIF

  DJNZ DISPLAY_ROWS

  M_WAIT_VDP

  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  LD A,$B0
  OUT (C),A
  DEC D
  JR NZ,DISPLAY_3

  BIT 6,(IX+$03)          ; CURSOR - get status
  JR Z,DISPLAY_6
  LD HL,(CURPOS)
  LD A,H
  OR A
  JR Z,DISPLAY_5

  ADD A,$07
  LD H,A

DISPLAY_5:
  LD C,$CF
  LD A,$26
  OUT ($8F),A             ; $26=Main pointer R6 (Y)
  OUT (C),H
  LD A,$27
  OUT ($8F),A             ; $27=Main pointer R7 (X)
  OUT (C),L
  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  LD A,$0A
  OUT (C),A

  M_WAIT_VDP

  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  LD A,$82
  OUT ($CF),A             ; $82=Indirect 
  LD A,$29
  OUT ($8F),A             ; $29=Data register R1 + exec request
  SET 6,(IX+$03)          ; CURSOR - Show
  LD A,(IX+$03)
  OUT ($CF),A

DISPLAY_6:
  POP HL
  POP DE
  POP BC

; This entry point is used by the routine at VSIGN.
DO_INT:
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
  OUT ($8F),A             ; $26=Main pointer R6 (Y)
  OUT (C),H
  LD A,$27
  OUT ($8F),A             ; $27=Main pointer R7 (X)
  OUT (C),L

; display character at cursor position
;
; Used by the routine at _PUTCHAR.
PUTCHAR:
  LD BC,$03CF

  M_WAIT_VDP

  LD A,$22
  OUT ($8F),A
  OUT (C),D

  M_WAIT_VDP

  LD A,$21
  OUT ($8F),A             ; $21=Data register R1
  OUT (C),E
  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  OUT (C),B
  RET

; read character in X=L, Y=H
;
; Used by the routine at _GETCHAR_XY.
GETCHAR_XY:
  LD C,$CF
  LD A,$26
  OUT ($8F),A             ; $26=Main pointer R6 (Y)
  OUT (C),H
  LD A,$27
  OUT ($8F),A             ; $27=Main pointer R7 (X)
  OUT (C),L

; read character at cursor position
;
; Used by the routine at _GETCHAR.
GETCHAR:
  LD BC,$0BCF
  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  OUT (C),B

  M_WAIT_VDP

  LD A,$22
  OUT ($8F),A
  IN D,(C)

  M_WAIT_VDP

  LD A,$21
  OUT ($8F),A
  IN E,(C)
  RET

; This entry point is used by the routines at __DELIM, CONSOLE_POUND and L33CD.
GETCHAR_2:
  OR (IX+$0A)				; EXTENF - Character redefinition flag
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
  CP 39
  JR C,GETCHAR_4
  LD L,$00
  INC H
  LD A,H
  CP 25
  JR C,GETCHAR_3
  DEC H
  LD A,(PICFLG)
  SET 6,A
  LD (PICFLG),A
  BIT 7,A
  JR NZ,GETCHAR_4
  PUSH HL
  CALL SCREEN_UP
  LD A,24
  CALL CLR_LINE
  POP HL
  LD (IX+$00),$01            ; Screen refresh counter
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
  LD BC,80*24
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
  LD A,(IX+$09)				; ATTBAK - Background color
  INC HL
  LD (HL),A
  LD C,(IX+$08)
  INC HL
  LD A,$20
  BIT 7,C
  JR Z,CLR_LINE_0
  XOR A
CLR_LINE_0:
  LD B,39
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
  M_WAIT_VDP
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
  AND $BB		; '*'=TK_STAR ?
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

FSUBT:
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
FDIVT:
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
; Used by the routines at __LOG, _ASCTFP and CMPLOG.
FLOAT:                                                          ;SET EXPONENT CORRECTLY
  LD B,$88                ; 8 bit integer in exponent           ;ZERO D,E
  LD DE,$0000             ; Zero NMSB and LSB                   ;FALL INTO FLOATR

; a.k.a. RETINT
;
; Used by the routines at PRNTHL, ABPASS and HEXCNS.
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
; Used by the routines at __SQR, POLY, __RND, VARRET and __NEXT.
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
; Used by the routines at __LOG, MLSP10, QINT, NUMASC, POWER, SUMSER, __RND and FORFND.
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
; Used by the routines at __RND, CRESTR, INPBIN, DOFN and __NEXT.
FPTHL:
  LD DE,FACCU             ; Point to FPREG                    ;GET POINTER TO FAC
                                                              ;FALL INTO MOVE
	;MOVE NUMBER FROM (DE) TO (HL)
	;ALTERS A,B,D,E,H,L
	;EXITS WITH (DE):=(DE)+4, (HL):=(HL)+4

; Copy number value from DE to HL
;
; Used by the routines at CRESTR and TSTOPL.
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
; Used by the routines at NUMASC, POWER, __SIN, CONIS, CMPLOG and __NEXT.
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
  JP Z,HEXCNS


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
FPWR:
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
  JP FDIVT                ; TAN = SIN / COS

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
  CP '+'
  JR NZ,M_SHARP
  INC BC
  INC D
  DEC E
M_SHARP:
  CP '-'
  JR NZ,M_FLAT
  INC BC
  DEC D
  DEC E
M_FLAT:
  LD A,(OCTSAV)
  ADD A,D
  LD D,A
  CALL M_PAUSE_VAL
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
  LD (IX+$00),$03            ; Screen refresh counter
  LD (IX+$01),$01
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
  CALL M_PAUSE_VAL
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

M_PAUSE_VAL:
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
  DEFB $CC,$CC,$08
  DEFB $CA,$CA,$09
  DEFB $BE,$BE,$09
  DEFB $B3,$B3,$0A
  DEFB $B3,$B3,$0A
  DEFB $A9,$A9,$0A
  DEFB $9F,$9F,$0B
  DEFB $97,$97,$0C
  DEFB $8E,$8E,$0C
  DEFB $86,$86,$0D
  DEFB $86,$86,$0D
  DEFB $7F,$7F,$0E
  DEFB $77,$77,$0F
  DEFB $71,$71,$10
  DEFB $6A,$6A,$11
  DEFB $64,$64,$12
  DEFB $5E,$5E,$13
  DEFB $59,$59,$14
  DEFB $59,$59,$14
  DEFB $54,$54,$15
  DEFB $4F,$4F,$17
  DEFB $4B,$4B,$18
  DEFB $46,$47,$19
  DEFB $42,$43,$1B
  DEFB $42,$43,$1B
  DEFB $3E,$3F,$1D
  DEFB $3A,$3B,$1E
  DEFB $37,$38,$20
  DEFB $34,$35,$22
  DEFB $31,$32,$24
  DEFB $2E,$2F,$25
  DEFB $2C,$2C,$29
  DEFB $2C,$2C,$29
  DEFB $29,$2A,$2B
  DEFB $27,$27,$2E
  DEFB $25,$25,$30
  DEFB $23,$23,$33
  DEFB $21,$21,$36
  DEFB $21,$21,$36
  DEFB $1F,$1F,$3A
  DEFB $1D,$1D,$3D
  DEFB $1C,$1B,$41
  DEFB $1A,$1A,$45
  DEFB $19,$18,$49
  DEFB $17,$17,$4D
  DEFB $16,$15,$52
  DEFB $16,$15,$52
  DEFB $14,$14,$57
  DEFB $13,$13,$5C
  DEFB $12,$12,$61
  DEFB $11,$11,$67
  DEFB $10,$10,$6D
  DEFB $10,$10,$6D
  DEFB $0F,$0F,$74
  DEFB $0E,$0E,$52
  DEFB $0D,$0D,$82
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
  CP 'T'
  JR Z,__SETE_0

  LD B,$40
  CP 'G'
  JP NZ,SN_ERR

__SETE_0:
  PUSH BC
  LD (IX+$01),$00
  CALL GETINT             ; Get character code to be modified
  CP ' '                  ; Check for space
  JP C,FC_ERR

  SET 7,A
  LD E,A
  LD D,$22
  EX AF,AF'
  CALL VDP_SET            ; Set VDP register [D], value [E]

  POP AF
  PUSH AF
  XOR $80
  LD E,A
  LD D,$21
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$20                ; $20=Command register
  LD E,$03
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$24
  EX AF,AF'
  LD E,A
  EX AF,AF'
  LD A,E
  RRA
  RRA
  AND $1F
  LD E,A
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$25                ; $25=Set register R5
  EX AF,AF'
  AND $03
  POP BC
  OR B
  LD E,A
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$20                ; $20=Command register
  LD E,$34
  CALL VDP_SET            ; Set VDP register [D], value [E]

  RST SYNCHR
  DEFB ','                  ; Check for comma

  RST SYNCHR
  DEFB '"'                  ; Check for string spec

  DEC HL
  LD B,10                  ; a 10 bytes long HEX byte string follows

__SETE_1:
  CALL HEX_BYTE            ; pick 2 digits from a HEX string in (HL) and build a BYTE
  PUSH BC

  LD B,8                   ; Mirror it
__SETE_2:
  RLCA
  RR C
  DJNZ __SETE_2
  LD A,C

  POP BC
  LD E,A
  LD D,$29                ; $29=Data register R1 + exec request
  CALL VDP_SET            ; Set VDP register [D], value [E]

  CALL VDP_READY          ; wait for EF9345 to be ready

  LD A,$25
  OUT ($8F),A             ; $25=Read register R5
  IN A,($CF)
  ADD A,$04
  LD E,A
  LD D,$25                ; $25=Set register R5
  CALL VDP_SET            ; Set VDP register [D], value [E]

  DJNZ __SETE_1

  INC HL
  LD A,(HL)
  CP '"'                  ; Check for ending string spec
  JR NZ,__SETE_3
  INC HL                  ; if it was specified, skip it
__SETE_3:

  LD (IX+$01),$01
  RET

; This entry point is used by the routines at __SETE and CHR_UPDATE.
VDP_SET:
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
  CALL VDP_SET            ; Set VDP register [D], value [E]

  POP AF
  PUSH AF
  XOR $80
  LD E,A
  LD D,$21
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$20                ; $20=Command register
  LD E,$03
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$24
  EX AF,AF'
  LD E,A
  EX AF,AF'
  LD A,E
  RRA
  RRA
  AND $1F
  LD E,A
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$25                ; $25=Set register R5
  EX AF,AF'
  AND $03
  POP BC
  OR B
  LD E,A
  CALL VDP_SET            ; Set VDP register [D], value [E]

  LD D,$20                ; $20=Command register
  LD E,$34
  CALL VDP_SET            ; Set VDP register [D], value [E]

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
  LD D,$29                ; $29=Data register R1 + exec request
  CALL VDP_SET            ; Set VDP register [D], value [E]

  CALL VDP_READY

  LD A,$25
  OUT ($8F),A             ; $25=Read register R5
  IN A,($CF)

  ADD A,$04
  LD E,A
  LD D,$25                ; $25=Set register R5
  CALL VDP_SET            ; Set VDP register [D], value [E]

  DJNZ CHR_UPDATE_1
  LD (IX+$01),$01
  RET

; Enter in TEXT mode
__TX:
  LD A,$00
  LD (IX+$0A),A				; EXTENF - Character redefinition flag
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
  LD (IX+$0A),$00				; EXTENF - Character redefinition flag
  LD A,$80
  JP __TX_0

; Routine at 3648
__ET:
  LD (IX+$0A),$80				; EXTENF - Character redefinition flag
  LD A,$00
  JP __TX_0

; Routine at 3657
__EG:
  LD A,$80
  LD (IX+$0A),A				; EXTENF - Character redefinition flag
  JP __TX_0

; Routine at 3665
__INIT:
  LD (IX+$08),$00
  PUSH HL
  LD A,$E6
  JR Z,__INIT_1
  POP HL
  CALL GETINT
  JR Z,__INIT_0
  PUSH AF

  RST SYNCHR
  DEFB ','

  CALL GETINT
  AND $07
  LD B,A
  LD A,(IX+$03)          ; CURSOR
  AND $F8
  OR B
  LD (IX+$03),A          ; CURSOR
  POP AF
; This entry point is used by the routine at __INIT.
__INIT_0:
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
__INIT_1:
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
  CP 40
  JR C,__CURSOR_0
  LD A,39
__CURSOR_0:
  LD (CURPOS),A
  RET

__CURSOR_1:
  CALL GETINT
  CP 25
  JR C,__CURSOR_2
  LD A,24
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
  CALL CONINT
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
  CALL CONINT
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
  CALL CONINT
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
IF V10
  JR Z,JOY_FIRE_F2_1
ELSE
  JP Z,JOY_FIRE_F2_1_V11
ENDIF
  IN A,($81)
  BIT 2,A
  JR JOY_L_R_5

IF V10

JOY_FIRE_F2_0:
  IN A,($07)
  BIT 4,A
  JR JOY_L_R_5
JOY_FIRE_F2_1:
  IN A,($08)
  BIT 4,A
  JR JOY_L_R_5

ELSE

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

ENDIF

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

  RST SYNCHR
  DEFB ','

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

  RST SYNCHR
  DEFB ','

  CALL GETINT
  BIT 0,A
  LD A,$80
  JR Z,__DELIM_0
  LD A,$84
__DELIM_0:
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
  LD (IX+$00),$01            ; Screen refresh counter
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


__STORE:
  LD (IX+$02),$00
  LD (IX+$00),$00            ; Screen refresh counter
  RET


; Routine at 4013
__CALL:
  CALL GETNUM             ;READ A VALUE
  CALL CONIS
  LD A,$C3                ; opcode for 'JP'
  LD (CALHK),A
  LD (CALHK+1),DE
  JP CALHK

; This entry point is used by the routine at L0D47.
HEX_BYTE:
  CALL HEX_DIGIT
  JP C,SN_ERR             ;
  ADD A,A                 ;SHIFT RIGHT FOUR BITS
  ADD A,A
  ADD A,A
  ADD A,A
  LD C,A
  CALL HEX_DIGIT
  JP C,SN_ERR
  OR C
  RET

; Carry flag is set if not decimal
; This entry point is used by the routine at HEXCNS.
HEX_DIGIT:
  INC HL                  ;BUMP POINTER
  LD A,(HL)               ;GET CHAR
  CP '0'
  JR C,HEX_DIGIT_NO_DEC
  CP '9'+1                ;IS IT BIGGER THAN LARGEST DIGIT?
  JR C,HEX_DIGIT_DEC           
  RES 5,A                 ;YES, go for HEX
  CP 'A'
  JR C,HEX_DIGIT_NO_DEC
  CP 'F'+1
  JP NC,HEX_DIGIT_NO_DEC          ;BE FORGIVING IF NOT HEX DIGIT
  ADD A,$C9               ;CONVERT DIGIT, MAKE BINARY
HEX_DIGIT_DEC:
  AND $0F
  RET

HEX_DIGIT_NO_DEC:
  SCF
  RET

; Data block at 4078
L0FEE:
  DEFS 18, $FF


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
  LD (IX+$00),$05               ; Screen refresh counter
  LD (IX+$01),$00
  LD (IX+$04),$01				; FKLOCK - Uppercase/Lowercase switch
  IM 1
  EI
  LD HL,$0001
  LD (DOT),HL
  LD (IX+$03),$6E          ; CURSOR
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
  CALL STKINI
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
  LD HL,4
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
  LD (DOT),HL
  LD (IX+$03),$6E          ; CURSOR
  CALL SCR_CO
  CALL STKINI

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

;
; Data block at 4461
STARTUP_SOUND:
  DEFB '"'
  DEFM "T8"      ; set tempo
  DEFM "O4"      ; (oct+)
  DEFM "C"       ; DO
  DEFM "O3"      ; (oct-)
  DEFM "GEC"     ; SOL-MI-DO
  DEFB '"'

; Data block at 4473
VDP_TXT:
  DEFB 26		; Total number of values (reg + val)*13

  DEFB $28,$81	; $28=Command register + exec request

  DEFB $29,$00  ; $29=Data register R1 + exec request

  DEFB $20,$82  ; $20=Command register         Write IND: R1->MAT
  DEFB $29,$6E  ; $29=Data register R1 + exec request

  DEFB $20,$83  ; $20=Command register         Write IND: R1->PAT
  DEFB $29,$F7  ; $29=Data register R1 + exec request

  DEFB $20,$84  ; $20=Command register         Write IND: R1->DOR
  DEFB $29,$13  ; $29=Data register R1 + exec request

  DEFB $20,$87  ; $20=Command register         Write IND: R1->ROR
  DEFB $29,$08  ; $29=Data register R1 + exec request

  DEFB $26,$08
  DEFB $27,$00

  DEFB $28,$02  ; $28=Command register + exec request


;--------------- INIT copies this block in RAM ---------------

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
  DEFB $35,$4A,$CA,$99    ; -2.65145E+07
  DEFB $39,$1C,$76,$98    ; 1.61291E+07
  DEFB $22,$95,$B3,$98    ; -1.17691E+07
  DEFB $0A,$DD,$47,$98    ; 1.30983E+07
  DEFB $53,$D1,$99,$99    ; -2-01612E+07
  DEFB $0A,$1A,$9F,$98    ; -1.04269E+07
  DEFB $65,$BC,$CD,$98    ; -1.34831E+07
  DEFB $D6,$77,$3E,$98    ; 1.24825E+07


; Data block at 4555
ROM_RNDX:
  DEFB $52,$C7,$4F,$80    ;LAST RANDOM NUMBER GENERATED, BETWEEN 0 AND 1

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
ROM_BUF10:
  DEFB $17,$18,$12,$1B,$14,$13,$1A,$19
  DEFB $16,$15
  
ROM_AUTFLG:
  DEFB $00

ROM_AUTLIN:
  DEFW 10       ; Default line number for "AUTO"

ROM_AUTINC:
  DEFW 10       ; Default line number increment for "AUTO"

ROM_LINLEN:
  DEFB $00

ROM_NCMPOS:
  DEFB 40        ;POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS

ROM_CURLIN:
  DEFW -$1E5

ROM_TXTTAB:
  DEFW -$301

ROM_FRGFLG:
  DEFB 'I'
  
ROM_KBDTBL:
  DEFW -$700

ROM_TMPSAV:
  DEFB 17

ROM_OCTSAV:
  DEFB 13

  DEFB $1C,$0C,$F2,$77,$73,$2F
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
OM_MSG_FR:
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
  DEFM "NEXT without FOR"               ; $00
  DEFB $00
  DEFM "Syntax error"                   ; $02
  DEFB $00
  DEFM "RETURN without GOSUB"           ; $04
  DEFB $00
  DEFM "Out of DATA"                    ; $06
  DEFB $00
  DEFM "Illegal function call"          ; $08
  DEFB $00
  DEFM "Overflow"                       ; $0A
  DEFB $00
OM_MSG:
  DEFM "Out of memory"                  ; $0C
  DEFB $00
  DEFM "Undefined line number"          ; $0E
  DEFB $00
  DEFM "Subscript out of range"         ; $10
  DEFB $00
  DEFM "Duplicate definition"           ; $12
  DEFB $00
  DEFM "Division by zero"               ; $14
  DEFB $00
  DEFM "Illegal direct"                 ; $16
  DEFB $00
  DEFM "Type mismatch"                  ; $18
  DEFB $00
  DEFM "Out of string space"            ; $1A
  DEFB $00
  DEFM "String too long"                ; $1C
  DEFB $00
  DEFM "String formula too complex"     ; $1E
  DEFB $00
  DEFM "Cannot continue"                ; $20
  DEFB $00
  DEFM "Undefined user function"        ; $22
  DEFB $00
  DEFM "Missing operand"                ; $24
  DEFB $00
  DEFM "FOR without NEXT"               ; $26
  DEFB $00
  DEFM "Device not supported"           ; $28
  DEFB $00
  DEFM "Unrecognized"                   ; $30
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
IF V10
; Documented bug, using MSX printers  a special symbol wasn't converted correctly
  DEFB $F0,$F2,$F2,$F3,$F4,$F5,$F6,$F7
ELSE
  DEFB $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7
ENDIF
  DEFB $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF

; Routine at 6469
__SAVE:
  CALL L1ADB_15
  CALL LNUM_RANGE
  PUSH HL
  PUSH DE
  CALL L1E9D_0
  POP DE
  LD HL,$0000
  LD (RETADR),HL
  LD A,$FF
  LD (PRTFLG),A
  LD A,$82
  LD HL,(VARTAB)
  LD (HL),A
  INC HL
  LD (SAVADDR),HL
  LD ($4824),A
  CALL __LIST_PROC
  LD A,$83
  CALL L1CC0_18
  LD A,($4824)
  CALL L1CC0_21
  CALL __CSAVE_0
  POP HL
  JP CLRPTR

; Routine at 6526
__LOAD:
  CALL LNUM_RANGE
  LD A,(CASCOM)
  AND $0F
  LD (CASCOM),A
  CALL TAPION
  LD E,$05
  CALL L1CC0_58
  CALL INLPNM_19
  JR C,__LOAD_0
  CALL _CASIN
  JR C,__LOAD_0
  CP $82
  SCF
  JR NZ,__LOAD_0
  LD (AUTORUN),A
  CALL L1CC0_23
__LOAD_0:
  JP C,LOAD_ABORT
  PUSH AF
  CALL _CASIN
  POP AF
  CALL TAPIOF
  JR Z,__LOAD_2
  LD HL,OM_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,__LOAD_OM_FR
  LD HL,OM_MSG
__LOAD_OM_FR:
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
  JR Z,CSAVEM
  CP 'S'
  JR Z,CSAVEM
  CP TK_STAR		 ; '*'=TK_STAR
  JR Z,CSAVEM
  CP 'X'
  JR Z,CSAVEM
  CP 'L'
  JP Z,PRINT_FNAME_MSG_7
  
  DEFB $3A ; "LD A,(nn)" over the next 2 bytes
  
CSAVEM:
  INC HL

  DEFB $01 ; "LD BC,nn" over the next 2 bytes

  LD A,' '

  LD (FILETAB),A
  CALL L1ADB_15
  CALL L1BA4_2
  CALL PRINT_FNAME_MSG_8
  PUSH HL
  CALL CSAVE_HEADER
  JR C,__CSAVE_1
  CALL CSAVE_DATA_HDR

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
  CP TK_STAR		 ; '*'=TK_STAR
  LD (FILSTAR),A
  JR NZ,__CLOAD_0
  INC HL

; Routine at 6721
;
; Used by the routine at __CLOAD.
__CLOAD_0:
  LD (FILETAB),A
  CP 'A'
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
  CALL TAPION
L1A50_0:
  LD E,$01
  CALL L1CC0_58
  CALL INLPNM_19
  JR C,CLOAD_END
  CALL CLOAD_HEADER
  JR C,CLOAD_END
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
  JR C,CLOAD_END
L1A50_2:
  LD B,10
L1A50_3:
  CALL _CASIN
  JR C,CLOAD_END
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
  LD A,(FILTYPE)
  CP ' '
  JR NZ,L1A50_6
  LD A,(FILETAB)
  CP 'A'
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


  DEFB $3E       ; "LD A,n" AROUND THE NEXT BYTE

; Routine at 6875
;
; Used by the routine at L1A50.
CLOAD_END:
  POP DE
  CALL TAPIOF
  LD HL,CASCOM
  JR C,LOAD_ABORT
  JR NZ,L1ADB_0
  LD A,C
  OR A
  LD A,(HL)
  JR Z,L1ADB_6
  AND $F0
  JR NZ,FILE_ERR
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
LOAD_ABORT:
  SET 7,(HL)
  LD HL,ABORTED_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,L1ADB_4
  LD HL,ABORTED_MSG
  JR L1ADB_4

FILE_ERR:
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
  JR NZ,FILE_ERR
L1ADB_7:
  LD A,(FILTYPE)
  CP 'M'
  JR Z,L1ADB_8
  CP ' '
  JR NZ,CLOAD_CONT
  LD A,(HL)
  AND $F0
  JR NZ,FILE_ERR
  CALL PRINT_FNAME_MSG_3
  LD (VARTAB),HL

L1ADB_8:
  LD A,($4889)
  OR A
  JR NZ,L1ADB_9
  LD HL,KBUF
  LD A,(HL)             ; Get byte
  OR A                  ; Nothing ?
  JR Z,L1ADB_9

  CP '0'
  JR Z,L1ADB_10
  JR L1ADB_13

L1ADB_9:
  LD DE,SAVADDR
  LD A,(DE)
  OR A
  JR NZ,L1ADB_11
L1ADB_10:
  LD A,(FILTYPE)
  CP 'M'
  JR Z,CLOAD_CONT
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

CLOAD_CONT:
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
  DEFB ')'

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
  CALL _CASIN
  RET C
  SUB $D3
  JR NZ,CLOAD_HEADER
  DJNZ CLOAD_HEADER_0
  LD HL,FILTYPE
  LD B,$16
CLOAD_HEADER_1:
  CALL _CASIN
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
  RST OUTDO
  DJNZ PRINT_FNAME_MSG_0
PRINT_FNAME_MSG_1:
  CALL OUTDO_CRLF
  LD A,$01
  EI
  LD (IX+$00),A            ; Screen refresh counter
  HALT
  DI
PRINT_FNAME_MSG_2:
  POP AF
  POP DE
  RET

; This entry point is used by the routine at CLOAD_END.
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

  LD HL,FILSTAR
  XOR A
  LD B,$09
CLR_FNAME2:
  LD (HL),A
  INC HL
  DJNZ CLR_FNAME2

  LD A,($4889)
  LD ($481D),A
  LD A,(FILETAB)
  CP ' '
  JR NZ,PRINT_FNAME_MSG_11
  LD HL,(TXTTAB)
  LD (SAVADDR),HL
  EX DE,HL
  LD HL,(VARTAB)
  OR A
  SBC HL,DE
; This entry point is used by the routine at L1C82.
PRINT_FNAME_MSG_10:
  LD (SAVLEN),HL
  JR L1C82_4
PRINT_FNAME_MSG_11:
  CP 'M'
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
  CALL GETNUM             ;READ A VALUE
  CALL CONIS
  LD (SAVADDR),DE

; Routine at 7296
L1C80:
  RST SYNCHR

; Data block at 7297
L1C81:
  DEFB ','

; Routine at 7298
L1C82:
  CALL GETNUM             ;READ A VALUE
  CALL CONIS
  PUSH HL
  EX DE,HL
  JR PRINT_FNAME_MSG_10
  
; This entry point is used by the routine at PRINT_FNAME_MSG.
L1C82_0:
  CP $53
  JR NZ,L1C82_2
  LD HL,SCREEN
  LD (SAVADDR),HL
  LD HL,DOEBIT
L1C82_1:
  LD (SAVLEN),HL
  JR L1CC0_1
  
L1C82_2:
  POP HL
  CP TK_STAR		 ; '*'=TK_STAR
  JR NZ,L1C82_3
  CALL L1CC0_16
  PUSH HL
  LD (SAVADDR),BC
  EX DE,HL
  JR L1C82_1

L1C82_3:
  CALL L1CC0_17
  LD (SAVADDR),DE
  LD (SAVLEN),BC
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
  LD DE,FILTYPE
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
  LD (FILSTAR),A
  RET

L1CC0_5:
  PUSH HL
  INC HL
  LD A,(HL)
  CP '$'
  JR Z,L1CC0_6
  INC HL
  LD A,(HL)
  CP '$'
L1CC0_6:
  POP HL
  PUSH HL
  PUSH BC
  JR NZ,L1CC0_8
  LD A,(FILSTAR)
  CP TK_STAR		 ; '*'=TK_STAR
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
  LD A,(FILTYPE)
  CP ' '
  JR NZ,L1CC0_11
  LD A,(FILETAB)
  CP 'A'
  JR NZ,L1CC0_10
  LD HL,(VARTAB)
  DEC HL
  DEC HL
  RET

L1CC0_10:
  LD HL,(TXTTAB)
  RET

L1CC0_11:
  CP 'M'
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
  LD A,(FILSTAR)
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
  LD A,(FILSTAR)
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
  LD HL,(SAVADDR)
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
  LD (SAVADDR),HL
  DEC HL
  LD A,(HL)
  LD HL,$4824
  XOR (HL)
  LD (HL),A
  POP HL
  RET

; This entry point is used by the routine at __SAVE.
L1CC0_21:
  LD HL,(SAVADDR)
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
  LD HL,(VARTAB)          ; Get program end
  LD BC,20                ; 20 Bytes minimum working RAM (LEAVE BREATHING ROOM)
  ADD HL,BC               ; Get lowest address
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
  XOR (IX+$03)          ; CURSOR
  LD (IX+$03),A
  OUT ($CF),A
  CALL L1CC0_52
  JR NC,L1CC0_32
  INC HL
  CALL _CASIN
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
  CALL _CASIN
  JR NC,L1CC0_30
  RET

L1CC0_33:
  CALL _CASIN
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

AUTORUN_0:
;---------
  LD E,A
  LD H,A
  DEC HL
  INC SP
  RRCA
AUTORUN_1:
;---------
  DEC HL
  INC SP
  LD DE,CSAVE_DATA_HDR_2

; This entry point is used by the routine at __SAVE.
L1E9D_0:
  LD HL,CASCOM
  RES 7,(HL)
  LD A,(HL)
  BIT 1,A
  RET NZ
  LD HL,AUTORUN_0
  LD DE,AUTORUN
  LD BC,$0005
  BIT 2,A               ; test speed
  JR Z,L1E9D_1
  ADD HL,BC
L1E9D_1:
  LDIR
  RET

; This entry point is used by the routine at __CSAVE.
CSAVE_HEADER:
  CALL L1E9D_0
  LD DE,(SAVADDR)
  LD BC,(SAVLEN)
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
CSAVE_DATA_HDR:
  XOR A
  CALL INLPNM_5
  RET C
  LD B,10
CSAVE_DATA_HDR_0:
  LD A,$D6                ; data block
  CALL CASOUT
  RET C
  DJNZ CSAVE_DATA_HDR_0
  LD DE,(SAVADDR)
  LD BC,(SAVLEN)
CSAVE_DATA_HDR_1:
  LD A,(DE)
  INC DE
  DEC BC
  CALL CASOUT

CSAVE_DATA_HDR_2:
  RET C
  LD A,B
  OR C
  JR NZ,CSAVE_DATA_HDR_1
  LD B,10
CSAVE_DATA_HDR_3:
  XOR A
  CALL CASOUT
  RET C
  DJNZ CSAVE_DATA_HDR_3
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
  LD B,10
L1CC0_48:
  CALL _CASIN
  RET C
  SUB $D6                         ; Data block ?
  JR NZ,L1CC0_47
  DJNZ L1CC0_48

  LD BC,($482A)
L1CC0_49:
  CALL _CASIN
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
  JR Z,L1F6D
  LD A,(CASCOM)
  SET 5,A
  LD (CASCOM),A

  DEFB $3E  ; "LD A,n" to Mask the next byte
L1F6D:

  LD (HL),E

  LD A,$06
  XOR (IX+$03)          ; CURSOR
  LD (IX+$03),A
  OUT ($CF),A
  LD A,(FILTYPE)
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
_CASIN:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL TAPIN
  POP BC
  POP DE
  POP HL
  RET

; This entry point is used by the routines at __LOAD and CLOAD_END.
TAPIOF:
  CALL _TAPIOF
  LD A,(MULVAL)           ; Restore cursor status
  LD (IX+$03),A           ; CURSOR
  RET

; This entry point is used by the routines at __LOAD and L1A50.
TAPION:
  LD A,(IX+$03)           ; CURSOR
  LD (MULVAL),A           ; Save cursor status
  RES 6,(IX+$03)          ; CURSOR - Hide
  LD A,$01
  LD (IX+$00),A           ; Screen refresh counter
  HALT
  RET

; This entry point is used by the routines at __LOAD and L1A50.
L1CC0_58:
  LD A,$28
  OUT ($8F),A             ; $28=Command register + exec request
  LD A,$82
  OUT ($CF),A             ; $82=Indirect 
  LD A,$29
  OUT ($8F),A             ; $29=Data register R1 + exec request
  LD A,(IX+$03)
  AND $F8
  OR E
  OUT ($CF),A
  RET

IF V10
  defs 11, $FF
ELSE
; This entry point is used by the routine at JOY_FIRE_F2.
JOY_FIRE_F2_1_V11:
  IN A,($08)
  CPL
  AND $30
  RRCA
  RRCA
  RRCA
  RRCA
  LD B,A
  RET
ENDIF

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


PRITAB:
  DEFB $79
  DEFW FADDT

  DEFB $79
  DEFW FSUBT

  DEFB $7C
  DEFW FMULTT

  DEFB $7C
  DEFW FDIVT

  DEFB $7F
  DEFW POWER

  DEFB $50
  DEFW PAND

;        DB      7CH             ; Precedence value
;        DW      MULT            ; PPREG = <last> * FPREG
;
;        DB      7CH             ; Precedence value
;        DW      DIV             ; FPREG = <last> / FPREG
;
;        DB      7FH             ; Precedence value
;        DW      POWER           ; FPREG = <last> ^ FPREG
;
;        DB      50H             ; Precedence value
;        DW      PAND            ; FPREG = <last> AND FPREG
;
;        DB      46H             ; Precedence value
;        DW      POR             ; FPREG = <last> OR FPREG
;
; ARITHMETIC PRECEDENCE TABLE
;PRITAB:

  DEFB $46,$77,$29

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
  LD HL,$0004             ; Look for "FOR" block with         ; IGNORING EVERYONES "NEWSTT" AND THE RETURN..
  ADD HL,SP               ; same index as specified           ; ..ADDRESS OF THIS SUBROUTINE
; This entry point is used by the routine at __FOR.
LOKFOR:
  LD A,(HL)               ; Get block ID (SEE WHAT TYPE OF THING IS ON THE STACK)
  INC HL                  ; Point to index address
  CP TK_FOR               ; Is it a "FOR" token
  RET NZ                  ; No - exit
  LD C,(HL)               ; BC = Address of "FOR" index
  INC HL
  LD B,(HL)
  INC HL                  ; Point to sign of STEP
  PUSH HL                 ; Save pointer to sign
  LD H,B                  ; HL = address of "FOR" index
  LD L,C
  RST DCOMPR              ; Compare index with one given
  LD BC,16-3              ; FORSZC: Offset to next block
  POP HL                  ; Restore pointer to sign
  RET Z                   ; Return if block found
  ADD HL,BC               ; Point to next block
  JR LOKFOR               ; Keep on looking

; 'SN err' entry for Input STMT
;
; Used by the routine at NEXITM.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?Syntax ERROR'
;
; Used by the routines at SYNCHR, MUSIC, __SETE, __CURSOR, __CALL, CLOAD_END,
; L1CC0, FORFND, STKTHS, DOFN, __CLEAR, HEXCNS, __RENUM, __AUTO, __LIST and
; GETVAR.
SN_ERR:
  LD E,$02

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; "?Division by zero ERROR"
;
; Used by the routines at FDIV and POWER.
O_ERR:
  LD E,$14

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

NF_ERR:
  LD E,$00                ;"NEXT WITHOUT FOR" ERROR

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; '?DD ERROR', "Redimensioned array"
;
; Used by the routine at FNDARY.
DD_ERR:
  LD E,$12

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; "?Undefined user function ERROR"
;
; Used by the routine at DOFN.
UF_ERR:
  LD E,$22

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; Overflow error
;
; Used by the routines at FADD, FDIV, RESDIV, MLSP10, RESZER and L1CC0.
OV_ERR:
  LD E,$0A

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; '?MO ERROR', "Missing Operand"
;
; Used by the routines at MUSIC, FNDWRD and OPRND.
MO_ERR:
  LD E,$24

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; '?TM ERROR', "Type mismatch"
;
; Used by the routines at L1CC0 and TSTSTR.
TM_ERR:
  LD E,$18

  DEFB $01                ; "LD BC,nn" to jump over the next word without executing it

; '?Undefined ERROR'
UNDEFINED_ERR:
  LD E,$28

; Routine at 8786
;
; Used by the routines at CLOAD_END, FC_ERR, UL_ERR, __RETURN, FDTLP, DOFN,
; ENFMEM, __CONT, TSTOPL, TESTOS, CONCAT and BS_ERR.
ERROR:
  CALL STKINI
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
; Used by the routines at CLOAD_END and __LIST.
RESTART:
  POP BC

; Routine at 8845
;
; Used by the routines at INIT_BEL and INPBRK.
READY:
  CALL FINLPT             ; Disable printer echo if enabled
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  CALL PRS

; Routine at 8857
;
; Used by the routine at __AUTO.
PROMPT:
  LD HL,-1                 ;SETUP CURLIN FOR DIRECT MODE
  LD (CURLIN),HL           ; Set interpreter in 'DIRECT' (immediate) mode
  LD A,(AUTFLG)            ;IN AN AUTO COMMAND?
  OR A                     ;SET CC'S
  JR Z,GETCMD              ;NO, REUGLAR MODE
  LD HL,(AUTLIN)           ;GET CURRENT AUTO LINE

IF V10
  CALL LINPRT
ELSE
  JP PROMPT_SUB
ENDIF

; This entry point is used by the routine at SHIFT_STOP.
PROMPT_RET1:
  LD A,' '                 ;PRINT SPACE
; This entry point is used by the routine at SHIFT_STOP.
PROMPT_RET2:
  RST OUTDO                ;PRINT CHAR

; a.k.a. _INLIN
GETCMD:
  CALL RINPUT              ;READ A LINE
  JR C,GETCMD              ;Redo if STOP/CTRL-C/BREAK..
  RST CHRGTB               ; Get first character                  GET THE FIRST
  INC A                    ; Test if end of line                  SEE IF 0 SAVING THE CARRY FLAG
  DEC A                    ; Without affecting Carry
  JR Z,PROMPT              ; Nothing entered - Get another        IF SO, A BLANK LINE WAS INPUT
  PUSH AF                  ; Save Carry status                    SAVE STATUS INDICATOR FOR 1ST CHARACTER
  LD A,($4889)
  OR A
  JP NZ,$0000              ; Reset
  CALL ATOH		           ; Get line number into DE              READ IN A LINE # specified line number
  PUSH DE                  ;SAVE LINE #
  CALL TOKENIZE            ;CRUNCH THE LINE DOWN ; (CRUNCH)
  LD B,A                   ; Save current byte
  POP DE                   ;RESTORE LINE #
  POP AF                   ; Carry status                         STATUS INDICATOR FOR 1ST CHARACTER
  JP NC,EXEC
  PUSH DE
  PUSH BC                  ;SAVE LINE # AND CHARACTER COUNT
  PUSH HL
  LD HL,(AUTINC)	       ;GET INCREMENT
  ADD HL,DE                ;ADD INCREMENT TO THIS LINE

IF V10
  LD (AUTLIN),HL           ;SAVE IN NEXT LINE
ELSE
  JP AUTLIN_SUB
ENDIF

; This entry point is used by the routine at SHIFT_STOP.
AUTSTR:
  POP HL
  RST CHRGTB
  OR A                     ;IS IT NULL LINE?
  PUSH AF
  CALL SRCHLN
  JR C,LINFND
  POP AF
  PUSH AF
  JP Z,PROMPT              ;YES, LEAVE LINE ALONE
  OR A

LINFND:
  PUSH BC
  JR NC,LEVFRE
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
LEVFRE:
  POP DE
  POP AF
  JR Z,FINI
  LD HL,(VARTAB)          ; Get end of program           CURRENT END
  EX (SP),HL              ; Get length of input line     [H,L]=CHARACTER COUNT. VARTAB ONTO THE STACK
  POP BC                  ; End of program to BC         [B,C]=OLD VARTAB
  ADD HL,BC               ; Find new end
  PUSH HL                 ; Save new end                 SAVE NEW VARTAB
  CALL MOVUP              ; Make space for line
  POP HL                  ; Restore new end              POP OFF VARTAB
  LD (VARTAB),HL          ; Update end of program pointer
  EX DE,HL                ; Get line to move up in HL
  LD (HL),H               ; Save MSB                     FOOL CHEAD WITH NON-ZERO LINK
  POP DE                  ; Get new line number          GET LINE # OFF STACK
  INC HL                  ; Skip pointer
  INC HL
  LD (HL),E               ; Save LSB of line number      PUT DOWN LINE #
  INC HL
  LD (HL),D               ; Save MSB of line number
  INC HL                  ; To first byte in line
  EX DE,HL
  LD HL,KBUF              ; Copy buffer to program       ;MOVE LINE FRM KBUF TO PROGRAM AREA
MOVBUF:
  LD A,(HL)               ; Get source
  LDI                     ; Save destinations
  CP LINCON
  JR NZ,MOVBUF_0
  LDI
  LDI
  JR MOVBUF
MOVBUF_0:
  OR A                    ; Done?
  JR NZ,MOVBUF            ; No - Repeat

; This entry point is used by the routine at CLOAD_END.
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
  CP LINCON
  JR Z,PROMPT_7
  OR A
  JR NZ,PROMPT_8
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JR PROMPT_6


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

; This entry point is used by the routines at __GOTO, T_EDIT, __RESTORE, __RENUM,
; SCCPTR, __LIST, SHIFT_STOP and __NEW.
SRCHLN:
  LD BC,$0000
  LD HL,(TXTTAB)        ; Start of program text

; This entry point is used by the routine at RUNLIN.
;
; Used by the routine at __GOTO.
SRCHLP:
  LD (PRELIN),BC
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
  RST DCOMPR            ; Compare with line in DE         SEE IF IT MATCHES OR IF WE'VE GONE TOO FAR
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

; TOKENIZE (CRUNCH) ALL "RESERVED" WORDS ARE TRANSLATED INTO SINGLE ONE OR TWO
; (IF TWO, FIRST IS ALWAYS $FF, 377 OCTAL) BYTES WITH THE MSB ON.
;
; Used by the routine at PROMPT.
TOKENIZE:
  XOR A
  LD (DORES),A            ; ALLOW CRUNCHING
  LD C,2+3                ; 2 byte number and 3 nulls
  LD DE,KBUF              ; SETUP DESTINATION POINTER

; This entry point is used by the routine at FNDWRD.
NXTCHR:
  LD A,(HL)               ; Get byte            GET CHARACTER FROM BUF
  CP ' '                  ; Is it a space?
  JP Z,MOVDIR             ; Yes - Copy direct, other BASIC versions get rid of it: "THEN EAT PAST IT (ONE SPACE ALWAYS PRINTED AFTER LINE #)"
  LD B,A                  ; Save character
  CP '"'                  ; Is it a quote?
  JP Z,CPYLIT             ; Yes - Copy literal string
  OR A                    ; Is it end of buffer?
  JP Z,CRDONE             ; Yes - End buffer
  LD A,(DORES)            ; Get data type
  OR A                    ; Literal?
  LD A,(HL)               ; Get byte to copy
  JP NZ,MOVDIR            ; Literal - Copy direct
  CP '?'                  ; A QMARK?  (Is it "?" short for PRINT)
  LD A,TK_PRINT           ; "PRINT" token
  JP Z,MOVDIR             ; THEN USE A "PRINT" TOKEN
  LD A,(HL)               ; Get byte to copy
  CP $10
  LD A,$AF                ; -- Replace $10 with $AF ..? --
  JP Z,MOVDIR             ; Copy direct
  LD A,(HL)               ; Get byte again
  CP '0'                  ; Is it less than "0"
  JR C,FNDWRD             ; Yes - Look for reserved words
  CP ';'+1                ; Is it "0123456789:;" ?
  JP C,MOVDIR             ; Yes - copy it direct

; label
;
; Used by the routine at TOKENIZE.
FNDWRD:
  PUSH DE                 ; Look for reserved words
  LD DE,WORDS-1           ; Point to table
  PUSH BC                 ; Save return address
  LD BC,RETNAD            ; Where to return to
  PUSH BC                 ; Save return address
  LD B,TK_END-1           ; First token value -1
  LD A,(HL)               ; Get byte
  CP 'a'                  ; Less than "a" ?
  JR C,SEARCH             ; Yes - search for words
  CP 'z'+1                ; Greater than "z" ?
  JR NC,SEARCH            ; Yes - search for words
  AND 01011111B           ; Force upper case
  LD (HL),A               ; Replace byte

SEARCH:
  LD C,(HL)               ; Search for a word
  EX DE,HL

GETNXT:
  INC HL                  ; Get next reserved word
  OR (HL)                 ; Start of word?
  JP P,GETNXT             ; No - move on
  INC B                   ; Increment token value
  LD A,(HL)               ; Get byte from table
  AND 01111111B           ; Strip bit 7
  RET Z                   ; Return if end of list
  CP C                    ; Same character as in buffer?
  JR NZ,GETNXT            ; No - get next word
  EX DE,HL
  PUSH HL                 ; Save start of word

NXTBYT:
  INC DE                  ; Look through rest of word
  LD A,(DE)               ; Get byte from table
  OR A                    ; End of word ?
  JP M,MATCH              ; Yes - Match found
  LD C,A                  ; Save it
  LD A,B                  ; Get token value
  CP TK_GOSUB
  JR Z,ALLOW_SPC
  CP TK_GOTO              ; Is it "GOTO" token ?
  JR NZ,NOSPC             ; No - Don't allow spaces (e.g. GOTO <=> GO TO)
ALLOW_SPC:
  RST CHRGTB              ; Get next character
  DEC HL                  ; Cancel increment from GETCHR
NOSPC:
  INC HL                  ; Next byte
  LD A,(HL)               ; Get byte
  CP 'a'                  ; Less than "a" ?
  JR C,NOCHNG             ; Yes - don't change
  AND 01011111B           ; Make upper case
NOCHNG:
  CP C                    ; Same as in buffer ?
  JR Z,NXTBYT             ; Yes - keep testing
  POP HL                  ; Get back start of word
  JR SEARCH               ; Look at next word

MATCH:
  LD C,B                  ; Word found - Save token value
  POP AF                  ; Throw away return
  POP AF
  LD A,C
  CP TK_GOTO
  JR Z,LNUM_TOKENS
  CP TK_GOSUB
  JR Z,LNUM_TOKENS
  CP TK_RESTORE
  JR Z,LNUM_TOKENS
  CP TK_THEN
  JR NZ,TOKEN_BUILT

; Here we deal with commands possibly expecting a line number
LNUM_TOKENS:
  PUSH HL
  RST CHRGTB
  POP HL
  JR NC,TOKEN_BUILT
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
  LD (HL),LINCON
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
  LD C,','
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

RETNAD:
  EX DE,HL                ; Get address in string

TOKEN_BUILT:
  LD A,C                  ; Get token value
  POP BC                  ; Restore buffer length
  POP DE                  ; Get destination address

; This entry point is used by the routine at TOKENIZE.
MOVDIR:
  INC HL                  ; Next source in buffer
  LD (DE),A               ; Put byte in buffer
  INC DE                  ; Move up buffer
  INC C                   ; Increment length of buffer
  SUB ':'                 ; ":", End of statement?
  JR Z,SETLIT             ; Jump if multi-statement line        ; IF SO ALLOW CRUNCHING AGAIN
  CP TK_DATA-':'          ; Is it DATA statement ?              ; SEE IF IT IS A DATA TOKEN
  JR NZ,TSTREM            ; No - see if REM
SETLIT:
  LD (DORES),A            ; Set literal flag
TSTREM:
  SUB TK_REM-':'          ; Is it REM?
  JP NZ,NXTCHR            ; No - Leave flag                     ;KEEP LOOPING
  LD B,A                  ; Copy rest of buffer                 ;GET TERMINATOR
STR1_LP:
  LD A,(HL)               ; Get byte                            ;GET A CHAR
  OR A                    ; End of line ?                       ;SET CONDITION CODES
  JR Z,CRDONE             ; Yes - Terminate buffer              ;IF END OF LINE THEN DONE
  CP B                    ; End of statement ?                  ;COMPARE CHAR WITH THIS TERMINATOR
  JR Z,MOVDIR             ; Yes - Get next one
; This entry point is used by the routine at TOKENIZE.
CPYLIT:
  INC HL                  ; Move up source string
  LD (DE),A               ; Save in destination
  INC C                   ; Increment length
  INC DE                  ; Move up destination
  JR STR1_LP              ; Repeat

; This entry point is used by the routine at TOKENIZE.
CRDONE:
  LD HL,KBUF-1            ; Point to start of buffer            ;GET POINTER TO CHAR BEFORE KBUF, AS "GONE" DOES A CHRGET
  LD (DE),A               ; Mark end of buffer (A = 00)         ;NEED THREE 0'S ON THE END
  INC DE                                                        ;ONE FOR END-OF-LINE
  LD (DE),A                                                     ;AND 2 FOR A ZERO LINK
  INC DE                                                        ;SINCE IF THIS IS A DIRECT STATEMENT
  LD (DE),A                                                     ;ITS END MUST LOOK LIKE THE END OF A PROGRAM
  RET                                                           ;END OF CRUNCHING


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
; Routine at 9338
__FOR:
  LD A,$64                ; Flag "FOR" assignment
  LD (SUBFLG),A           ; Save "FOR" flag                      DONT RECOGNIZE SUBSCRIPTED VARIABLES
  CALL __LET              ; Set up initial index                 GET POINTER TO LOOP VARIABLE
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
  RST DCOMPR              ; Compare the FOR loops                SEE IF THEY MATCH
  POP HL                  ; Restore block address                GET BACK THE STACK POINTER
  POP DE                  ;                                      GET BACK THE TEXT POINTER
  JR NZ,FORSLP            ; Different FORs - Find another        KEEP SEARCHING IF NO MATCH
  POP DE                  ; Restore code string address          GET BACK THE TEXT POINTER
  LD SP,HL                ; Remove all nested loops              DO THE ELIMINATION
  INC C

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
  CALL TSTNUM             ; Make sure it's a number

  RST SYNCHR              ; Make sure "TO" is next
  DEFB TK_TO              ; "TO" token                           "TO" IS NECESSARY

  CALL GETNUM             ; Get value for 'TO'
  PUSH HL                 ; Save code string address             SAVE THE TEXT POINTER
  CALL BCDEFP             ; Move "TO" value to BCDE
  POP HL                  ; Restore code string address
  PUSH BC                 ; Save "TO" value in block
  PUSH DE                 ; SAVE THE SIGN OF THE INCREMENT
  LD BC,$8100             ; BCDE = 1.0 (default STEP)
  LD D,C                  ; C=0
  LD E,D                  ; D=0
  LD A,(HL)               ; Get next byte in code string
  CP TK_STEP              ; See if "STEP" is stated
  LD A,$01                ; Sign of step = 1
  JR NZ,SAVSTP            ; No STEP given - Default to 1
  RST CHRGTB              ; Jump over "STEP" token
  CALL GETNUM             ; Get step value
  PUSH HL                 ; Save code string address
  CALL BCDEFP             ; Move STEP to BCDE
  RST VSIGN               ; Test sign of FPREG
  POP HL                  ; Restore code string address
SAVSTP:
  PUSH BC                 ; Save the STEP value in block         PUT VALUE ON BACKWARDS
  PUSH DE                                                       ;OPPOSITE OF PUSHR
  PUSH AF                 ; Save sign of STEP
  INC SP                  ; Don't save flags
  PUSH HL                 ; Save code string address
  LD HL,(TEMP)            ; Get address of index variable
  EX (SP),HL              ; Save and restore code string

; This entry point is used by the routine at __NEXT.
PUTFID:
  LD B,TK_FOR             ; "FOR" block marker                   PUT A 'FOR' TOKEN ONTO THE STACK
  PUSH BC                 ; Save it                          
  INC SP                  ; Don't save C                         THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE

;
; BASIC program execution driver (a.k.a. RUNCNT).  HL points to code.
;
; BACK HERE FOR NEW STATEMENT. CHARACTER POINTED TO BY [H,L]
; ":" OR END-OF-LINE. THE ADDRESS OF THIS LOCATION IS
; LEFT ON THE STACK WHEN A STATEMENT IS EXECUTED SO
; IT CAN MERELY DO A RETURN WHEN IT IS DONE.
;
; This entry point is used by the routine at __NEXT.
NEWSTT:
  CALL ISCNTC             ; Check STOP key status
  LD (TEMP),HL            ; Save code address for break TO REMEMBER HOW TO RESTART THIS STATEMENT
  LD A,(HL)               ; GET CURRENT CHARACTER WHICH TERMINATED THE LAST STATEMENT
  CP ':'                  ; Multi statement line?
  JR Z,EXEC               ; Yes - Execute it
  OR A                    ; End of line?
  JP NZ,SN_ERR            ; No - Syntax error               ;MUST BE A ZERO
  INC HL                  ; Point to address of next line

GONE4:                    ;CHECK POINTER TO SEE IF IT IS ZERO, IF SO WE ARE AT THE END OF THE PROGRAM  
  LD A,(HL)               ; Get LSB of line pointer
  INC HL
  OR (HL)                 ; Is it zero (End of prog)?
  JP Z,ENDCON             ; Yes - Terminate execution        ;FIX SYNTAX ERROR IN UNENDED ERROR ROUTINE
  INC HL                  ; Point to line number
  LD E,(HL)               ; Get LSB of line number
  INC HL
  LD D,(HL)               ; Get MSB of line number           ;GET LINE # IN [D,E]
  EX DE,HL                ; Line number to HL                ;[H,L]=LINE #
  LD (CURLIN),HL          ; Save as current line number      ;SETUP CURLIN WITH THE CURRENT LINE #
  EX DE,HL                ;RESTORE THE TEXT POINTER, Line number back to DE

; This entry point is used by the routine at PROMPT.
EXEC:
  RST CHRGTB              ; Get key word                            ;GET THE STATEMENT TYPE
  LD DE,NEWSTT            ; Where to RETurn to                      ;PUSH ON A RETURN ADDRESS OF NEWSTT
  PUSH DE                 ; Save for RETurn                         ;STATEMENT

; This entry point is used by the routine at __IF.
_ONJMP:
  RET Z
; This entry point is used by the routine at __ON.
ONJMP:
  SUB TK_END              ; $81 = TK_END .. is it a token?
  JP C,__LET              ; No - try to assign it, MUST BE A LET

  CP TK_NEW+1-TK_END      ; END to NEW ?
  JP NC,SN_ERR            ; Not a key word - ?SN Error
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
;
; NEWSTT FALLS INTO CHRGET. THIS FETCHES THE FIRST CHAR AFTER
; THE STATEMENT TOKEN AND THE CHRGET'S "RET" DISPATCHES TO STATEMENT
;
; Used by the routine at DTSTR.
_CHRGTB:
  INC HL                  ; Point to next character        ;DUPLICATION OF CHRGET RST FOR SPEED
  LD A,(HL)               ; Get next code string byte      ;SEE CHRGET RST FOR EXPLANATION
  CP '9'+1
  RET NC                  ; NC if > "9"

;
; CHRCON IS THE CONTINUATION OF THE CHRGET RST
;
; IN EXTENDED, CHECK FOR INLINE CONSTANT AND IF ONE
; MOVE IT INTO THE FAC & SET VALTYP APPROPRIATELY
;
; This entry point is used by the routine at CHRGTB.
_CHRGTB_0:
  CP ' '                  ;                                MUST SKIP SPACES
  JR Z,_CHRGTB            ; Skip over spaces               GET ANOTHER CHARACTER
  JR NC,NOTLFT            ; NC if < "0"                    NOT SPECIAL TRY OTHER POSSIB.

  CP $0F 
  JR NC,_CHRGTB_1
  CP PTRCON
  JR C,_CHRGTB_1

  PUSH HL
  INC HL
  INC HL
  INC HL
  LD (CONTXT),HL
  POP HL
_CHRGTB_1:
  OR A                    ;SET NON-ZERO, NON CARRY CC'S
  RET

NOTLFT:
  CP '0'                ;ALL CHARACTERS GREATER THAN "9" HAVE RETURNED, SO SEE IF NUMERIC
  CCF                   ;MAKE NUMERICS HAVE CARRY ON
  INC A                 ;SET ZERO IF [A]=0
  DEC A
  RET

; This entry point is used by the routine at SCPTLP.
_CHRGTB_2:
  RST CHRGTB
; This entry point is used by the routine at __CLEAR.
INTIDX_0:
  CALL GETNUM             ;READ A VALUE


; Get integer variable to DE, error if negative
;
;CONVERT THE FAC TO AN INTEGER IN [D,E]
;AND SET THE CONDITION CODES BASED ON THE HIGH ORDER
;
; Used by the routine at CONINT.
DEPINT:
  RST VSIGN             ; Test sign of FPREG
  JP M,FC_ERR           ; Negative - ?FC Error

; parameter acquisition on 2 bytes
;
; Used by the routines at __CONIS, __CALL, L1C76, L1C82, EVAL_VARIABLE, NOT, __PEEK,
; GETWORD and __CLEAR.
CONIS:
  LD A,(FPEXP)          ;GET THE EXPONENT
  CP $80+16             ;SEE IF IT IS TOO BIG                 ; Exponent in range (16 bits)?
  JP C,QINT             ;IT ISN'T, CONVERT IT TO AN INTEGER

                        ;IT IS, BUT IT MIGHT BE -32768
  LD BC,$9080           ; BCDE = -32768
  LD DE,$0000
  PUSH HL               ; Save code string address
  CALL FCOMP            ; Compare FPREG with BCDE
  POP HL                ; Restore code string address
  LD D,C                ; MSB to D
  RET Z                 ; Return if in range

; Routine at 9575
;
; Used by the routines at __LOG, __SETE, ROM_RAMLOW, CLOAD_END, L1CC0, DEPINT,
; CONINT, __CONT, __RENUM, __ASC, __MID_S and BS_ERR.
FC_ERR:
  LD E,$08              ; ?FC Error
  JP ERROR

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
; Used by the routines at L1CC0, PROMPT, FNDWRD, __GOTO, __RESTORE, __RENUM,
; __AUTO, __LIST and __NEW.
ATOH:
  DEC HL                ;BACKSPACE PTR

; Routine at 9581
;
; Used by the routine at __ON.
ATOH2:
  RST CHRGTB            ;FETCH CHAR (GOBBLE LINE CONSTANTS)
  CP LINCON             ;$0E: EMBEDDED LINE CONSTANT?
  JR NZ,ATOH3
  INC HL                ;YES, RETURN DOUBLE BYTE VALUE
  LD E,(HL)
  INC HL
  LD D,(HL)
  RST CHRGTB            ;EAT FOLLOWING CHAR
  RET

ATOH3:
  DEC HL                ;BACK UP POINTER
  LD DE,$0000           ;ZERO ACCUMULATED LINE #

; ASCII to Integer, result in DE
GTLNLP:
  RST CHRGTB          ; Get next character
  RET NC              ; Exit if not a digit          ;WAS IT A DIGIT
  PUSH HL             ; Save code string address
  PUSH AF             ; Save digit
  LD HL,65529/10      ; Largest number 65529         ;SEE IF THE LINE # IS TOO BIG
  RST DCOMPR          ; Compare HL with DE.
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

; Routine at 9626
;
; Used by the routine at CLOAD_END.
__RUN:
  RES 6,(IX+$03)      ; CURSOR - Hide
  JP Z,RUN_FST        ; RUN from start if just RUN   ;NO LINE # ARGUMENT

;CLEAN UP,SET [H,L]=[TXTTAB]-1 AND
;RETURN TO NEWSTT
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
; Routine at 9641
__GOSUB:
  LD C,$03                ; 3 Levels of stack needed         ;"GOSUB" ENTRIES ARE 5 BYTES LONG
  CALL CHKSTK             ; Check for 3 levels of stack      ;MAKE SURE THERE IS ROOM
  POP BC                  ; Get return address               ;POP OFF RETURN ADDRESS OF "NEWSTT"
  PUSH HL                 ; Save code string for RETURN      ;REALLY PUSH THE TEXT POINTER
  PUSH HL                 ; And for GOSUB routine            ;SAVE TEXT POINTER
  LD HL,(CURLIN)          ; Get current line                 ;GET THE CURRENT LINE #
  EX (SP),HL              ; Into stack - Code string out     ;PUT CURLIN ON THE STACK AND [H,L]=TEXT PTR
  LD A,TK_GOSUB           ; "GOSUB" token
  PUSH AF                 ; Save token                       ;PUT GOSUB TOKEN ON THE STACK
  INC SP                  ; Don't save flags                 ;THE GOSUB TOKEN TAKES ONLY ONE BYTE

; This entry point is used by the routine at __RUN.
RUNLIN:
  PUSH BC                 ; Save return address    ; RESTORE RETURN ADDRESS OF "NEWSTT"
                                                   ; AND SEARCH. IN THE 8K WE START WHERE WE
                                                   ; ARE IF WE ARE GOING TO A FORWARD LOCATION.
; 'GOTO' BASIC command
;
; Routine at 9658
; Used by the routine at __IF.
__GOTO:
  CALL ATOH               ; ASCII number to DE binary    ;PICK UP THE LINE # AND PUT IT IN [D,E]
  CALL __REM              ; Get end of line                     ;SKIP TO THE END OF THIS LINE
  INC HL                  ; Start of next line                  ;POINT AT THE LINK BEYOND IT
  PUSH HL                 ; Save Start of next line             ;SAVE THE POINTER
  LD HL,(CURLIN)          ; Get current line                    ;GET THE CURRENT LINE #
  RST DCOMPR              ; Line after current?   ;[D,E] CONTAINS WHERE WE ARE GOING, [H,L] CONTAINS THE CURRENT LINE #
                                                  ;SO COMPARING THEM TELLS US WHETHER TO START SEARCHING FROM WHERE 
                                                  ;WE ARE OR TO START SEARCHING FROM THE BEGINNING OF TXTTAB
  POP HL                  ; Restore Start of next line         ; [H,L]=CURRENT POINTER
  CALL C,SRCHLP           ; Line is after current line         ; SEARCH FROM THIS POINT
  CALL NC,SRCHLN          ; Line is before current line        ; SEARCH FROM THE BEGINNING
                                                               ; -- ACTUALLY SEARCH AGAIN IF ABOVE SEARCH FAILED
  LD H,B                  ; Set up code string address: [H,L]= POINTER TO THE START OF THE MATCHED LINE
  LD L,C                  ; NOW POINTING AT THE FIRST BYTE OF THE POINTER TO THE START OF THE NEXT LINE
  DEC HL                  ; Incremented after
  RET C                   ; Line found: GO TO NEWSTT


; entry for '?UL ERROR'
;
; Used by the routine at __RESTORE.
UL_ERR:
  LD E,$0E                ; ?UL Error
  JP ERROR                ; Output error message

; Routine at 9686
__RETURN:
  RET NZ                  ; Return if not just RETURN      ;BLOW HIM UP IF THERE ISN'T A TERMINATOR
  LD D,$FF                ; Flag "GOSUB" search            ;MAKE SURE THIS VARIABLE POINTER IN [D,E] NEVER GETS MATCHED
  CALL BAKSTK             ; Look "GOSUB" block             ;GO PAST ALL THE "FOR" ENTRIES
  LD SP,HL                ; Kill all FORs in subroutine    ;UPDATE THE STACK
  CP TK_GOSUB             ; TK_GOSUB, Token for 'GOSUB'
  LD E,$04                ; Err $04 - "RETURN without GOSUB" (ERRRG)
  JP NZ,ERROR             ; Error if no "GOSUB" found          
  POP HL                  ; Get RETURN line number         ;GET LINE # "GOSUB" WAS FROM
  LD (CURLIN),HL          ; Save as current                ;PUT IT INTO CURLIN
  INC HL
;------ useless ------
  LD A,H
  OR L                    ; Return to line
  JR NZ,RETLIN            ; No - Return to line
RETLIN:
;---------------------
  LD HL,NEWSTT            ; Execution driver loop          ;PUT IT INTO CURLIN
  EX (SP),HL              ; Into stack - Code string out   ;PUT RETURN ADDRESS OF "NEWSTT" BACK ONTO THE STACK.
                                                           ;GET TEXT POINTER FROM "GOSUB" SKIP OVER SOME CHARACTERS
                                                           ;SINCE WHEN "GOSUB" STUCK THE TEXT POINTER ONTO THE STACK
                                                           ;THE LINE # ARGUMENT HADN'T BEEN READ IN YET.

  DEFB $3E                ; "LD A,n" to Mask the next byte  ("MVI A," AROUND POP H.)

; Routine at 9714
;
; Used by the routines at __INPUT and GTVLUS.
NXTDTA:
  POP HL                  ;GET TEXT POINTER OFF STACK


; "DATA" TERMINATES ON ":" AND 0. 
; ":" ONLY APPLIES IF QUOTES HAVE MATCHED UP
;
; Data block at 9715
__DATA:
  DEFB $01                ; "LD BC," TO PICK UP ":" INTO C AND SKIP
  DEFB ':'                ;"DATA" TERMINATES ON ":" AND 0.   ":" ONLY APPLIES IF QUOTES HAVE MATCHED UP

; Routine at 9717
;
; Used by the routines at __GOTO and __IF.
__REM:
  DEFB $0E          ;"LD C,"   THE ONLY TERMINATOR IS ZERO
  DEFB 0            ;0 = End of statement
  LD B,$00          ;INSIDE QUOTES THE ONLY TERMINATOR IS ZERO

NXTSTL:
  LD A,C                  ; Statement and byte           ;WHEN A QUOTE IS SEEN THE SECOND
  LD C,B                                                 ;TERMINATOR IS TRADED, SO IN "DATA"
  LD B,A                  ; Statement end byte           ;COLONS INSIDE QUOTATIONS WILL HAVE NO EFFECT
NXTSTT:
  LD A,(HL)               ; Get byte
  CP LINCON
  JR NZ,__REM_2
  INC HL                  ; skip 3 bytes of "Line number prefix"
  INC HL
  INC HL
  LD A,(HL)
__REM_2:
  OR A                    ; End of line?                 ;ZERO IS ALWAYS A TERMINATOR
  RET Z                   ; Yes - Exit
  CP B                    ; End of statement?            ;TEST FOR THE OTHER TERMINATOR
  RET Z                   ; Yes - Exit
  INC HL                  ; Next byte
  CP '"'                  ; Literal string?              ;IS IT A QUOTE?
  JR Z,NXTSTL             ; Yes - Look for another '"'   ;IF SO TIME TO TRADE
  JR NXTSTT


; 'LET' BASIC command
;
; Routine at 9744
; Used by the routines at __FOR and FORFND.
__LET:
  CALL GETVAR             ;GET THE POINTER TO THE VARIABLE NAMED IN TEXT AND PUT IT INTO [D,E]

  RST SYNCHR              ; Make sure "=" follows
  DEFB TK_EQUAL           ;CHECK FOR "="

  PUSH DE                 ; Save address of variable
  LD A,(VALTYP)           ; Get data type
  PUSH AF                 ; save type                         ;CALL REDINP, TEMP DOESN'T GET CHANGED
  CALL EVAL               ; Evaluate expression               ;GET THE VALUE OF THE FORMULA
  POP AF                  ; Restore type                      ;GET THE VALTYP OF THE VARIABLE INTO [A] INTO FAC
  EX (SP),HL              ; Save code - Get var addr          ;[H,L]=POINTER TO VARIABLE TEXT POINTER TO ON TOP OF STACK
  LD (TEMP),HL            ; Save address of variable
  RRA                     ; Adjust type
  CALL CHKTYP             ; Check types are the same
  JR Z,LETNUM             ; Numeric - Move value              ;NUMERIC, SO FORCE IT AND COPY
; This entry point is used by the routine at ITMSEP.
__LET_1:
  PUSH HL
  LD HL,(FACCU)           ; Pointer to string entry           ;GET POINTER TO THE DESCRIPTOR OF THE RESULT
  PUSH HL                 ; Save it on stack                  ;SAVE THE POINTER AT THE DESCRIPTOR
  INC HL                  ; Skip over length
  INC HL
  LD E,(HL)               ; LSB of string address
  INC HL
  LD D,(HL)               ; MSB of string address
  LD HL,(TXTTAB)          ; Point to start of program         ;IF THE DATA IS IN BUF, OR IN DISK RANDOM BUFFER, COPY.
  RST DCOMPR              ; Is string before program?         ;SINCE BUF CHANGES ALL THE TIME
  JR NC,CRESTR            ; Yes - Create string entry         ;GO COPY, IF DATA REALLY IS IN BUF
  LD HL,(STREND)          ; Point to string space             ;SEE IF IT POINTS INTO STRING SPACE
  RST DCOMPR              ; Is string literal in program?     ;IF NOT DON'T COPY
  POP DE                  ; Restore address of string         ;GET BACK THE POINTER AT THE DESCRIPTOR
  JR NC,DNTCPY            ; Yes - Set up pointer              ;DON'T COPY LITERALS
  LD HL,DSCTMP            ; Temporary string pool             ;NOW, SEE IF ITS A VARIABLE
  RST DCOMPR              ; Is string in temporary pool?      ;BY SEEING IF THE DESCRIPTOR IS IN THE TEMPORARY STORAGE AREA (BELOW DSCTMP)
  JR NC,DNTCPY            ; No - Set up pointer               ;DON'T COPY IF ITS NOT A VARIABLE

  DEFB $3E                ; "LD A,n" to Mask the next byte, skip "POP DE"

; Routine at 9798
;
; Used by the routine at __LET.
CRESTR:
  POP DE                  ; Restore address of string         ;GET THE POINTER TO THE DESCRIPTOR IN [D,E]

  CALL FRETMS             ; Back to last tmp-str entry        ;FREE UP A TEMORARY POINTING INTO BUF
  EX DE,HL                ; Address of string entry           ;STRCPY COPIES [H,L]
  CALL STRCPY             ; Save string in string area        ;COPY VARIABLES IN STRING SPACE OR STRINGS WITH DATA IN BUF

; a.k.a MVSTPT
; This entry point is used by the routine at __LET.
DNTCPY:
  CALL FRETMS             ; Back to last tmp-str entry        ;FREE UP THE TEMPORARY WITHOUT FREEING UP ANY STRING SPACE
  POP HL                  ; Get string pointer
  CALL VMOVE              ; Move string pointer to var        ;COPY A DESCRIPTOR OR A VALUE
  POP HL                  ; Restore code string address       ;GET THE TEXT POINTER BACK
  RET

; This entry point is used by the routine at __LET.
LETNUM:
  PUSH HL                 ; Save address of variable
  CALL FPTHL              ; Move value to variable
  POP DE                  ; Restore address of variable
  POP HL                  ; Restore code string address
  RET


; 'ON' BASIC instruction
; ON..GOTO, ON GOSUB GOTO CODE

; Routine at 9822
__ON:
  CALL GETINT             ; Get integer 0-255                  ;GET VALUE INTO [E]
  LD A,(HL)               ; Get "GOTO" or "GOSUB" token        ;GET THE TERMINATOR BACK
  LD B,A                  ; Save in B                          ;SAVE THIS CHARACTER FOR LATER
  CP TK_GOSUB             ; "GOSUB" token?                     ;AN "ON ... GOSUB" PERHAPS?
  JR Z,ONGO               ; Yes - Find line number             ;YES, SOME FEATURE USE

  RST SYNCHR              ; Make sure it's "GOTO"
  DEFB TK_GOTO            ; "GOTO" token                       ;OTHERWISE MUST BE "GOTO"

  DEC HL                  ; Cancel increment

; This entry point is used by the routine at __ON.
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
  JP ONGOLP               ; Yes - loop                    ;CONTINUE GOBBLING LINE #S


; 'IF'..'THEN' BASIC code
;
; Routine at 9849
__IF:
  CALL EVAL               ; Evaluate expression (FORMULA)
  LD A,(HL)               ; Get token
  CP TK_GOTO              ; "GOTO" token?
  JR Z,IFGO               ; Yes - Get line

  RST SYNCHR              ; Make sure it's "THEN"
  DEFB TK_THEN            ; "THEN" token

  DEC HL                  ; Cancel increment

; This entry point is used by the routine at __IF.
IFGO:
  CALL TSTNUM             ; Make sure it's numeric
  RST VSIGN               ; Test state of expression
  JP Z,__REM              ; False - Drop through
  RST CHRGTB              ; Get next character
  CP LINCON               ; Line number prefix ?
  JP Z,__GOTO             ; Yes - GOTO that line
  JP _ONJMP               ; Otherwise do statement (EXECUTE STATEMENT, NOT GOTO)

; Routine at 9876
__LPRINT:
  LD A,$01                ;SAY NON ZERO
  LD (PRTFLG),A           ;SAVE AWAY
; This entry point is used by the routine at __PRINT.
MRPRNT:
  DEC HL                  ; DEC 'cos GETCHR INCs
  RST CHRGTB              ; GET ANOTHER CHARACTER

; Routine at 9883
__PRINT:
  CALL PRTHK              ; hook code for "PRINT"
  CALL Z,OUTDO_CRLF       ; CRLF if just PRINT    (IF END WITHOUT PUNCTUATION)
; This entry point is used by the routine at NEXITM.
PRNTLP:
  JP Z,FINPRT             ; End of list - Exit (FINISH BY RESETTING FLAGS)
                          ; IN WHICH CASE A TERMINATOR DOES NOT MEAN WE SHOULD TYPE A CRLF BUT JUST RETURN
  CP TK_TAB               ; "TAB(" token?                 
  JR Z,__TAB              ; Yes - Do TAB routine          ;THE TAB FUNCTION?
  CP TK_SPC               ; "SPC(" token?                 
  JR Z,__TAB              ; Yes - Do SPC routine          ;THE SPC FUNCTION?
  PUSH HL                 ; Save code string address      ;SAVE THE TEXT POINTER
  CP ','                  ; Comma?                        ;IS IT A COMMA?
  JR Z,DOCOM              ; Yes - Move to next zone
  CP ';'                  ; Semi-colon?                   ;IS IT A ";"
  JP Z,NEXITM             ; Do semi-colon routine
  POP BC                  ; Code string address to BC     ;GET RID OF OLD TEXT POINTER
  CALL EVAL               ; Evaluate expression           ;EVALUATE THE FORMULA
  PUSH HL                 ; Save code string address      ;SAVE TEXT POINTER
  LD A,(VALTYP)           ; Get variable type
  OR A                    ; Is it a string variable?
  JR NZ,PRNTST            ; Yes - Output string contents
  CALL NUMASC             ; Convert number to text
  CALL CRTST              ; Create temporary string
  LD (HL),' '             ; Followed by a space
  LD HL,(FACCU)           ; Get length of output          ;AND INCREASE SIZE BY 1
  LD A,(PRTFLG)
  OR A
  JR Z,ISTTY              ;LPT OR TTY?
  LD A,(LPTPOS)           ; Get cursor position
  ADD A,(HL)              ; Add length of string
  CP LPTSIZ               ; Will output fit on this line?
  JR LINCH2               ; THEN JUST PRINT

ISTTY:
  LD A,(LINLEN)           ; Get width of line
  LD B,A                  ; To B
  INC A                   ; NO OVERFLOW LINE WIDTH?
  JR Z,PRNTNB             ; YES
  LD A,(CURPOS)           ; Get cursor position             ; SEE WHERE WE ARE
  ADD A,(HL)              ; Add length of string  			; ADD THIS LENGTH
  DEC A                   ; Adjust it ACTUALLY EQUAL TO LINE LENGTH IS OK
  CP B                    ; Will output fit on this line?

LINCH2:
  CALL NC,OUTDO_CRLF      ; CRLF if we're not at the line margin
PRNTNB:
  CALL PRS1               ; Output string at (HL)             ;PRINT THE NUMBER
  XOR A
PRNTST:
  CALL NZ,PRS1
  POP HL
  JR MRPRNT               ; See if more to PRINT              ;PRINT SOME MORE

DOCOM:
  LD A,(PRTFLG)           ;OUTPUT TO THE LINE PRINTER?
  OR A                    ;NON-ZERO MEANS YES
  JR Z,ISCTTY             ;NO, DO TELETYPE COMMA
  LD A,(LPTPOS)           ;GET LINE PRINTER POSITION
  CP $75                  ;CHECK IF MAX COMMA FIELDS
  JR CHKCOM               ;USE TELETYPE CHECK

ISCTTY:
  LD A,(NCMPOS)           ; Get comma width                 ;POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS
  LD B,A                  ; Save in B
  LD A,(CURPOS)           ; Get current position            ;GET TELETYPE POSITION
  DEC A
  ;<- extra code here with MBASIC versions with a "TERMINAL WIDTH?" QUESTION
  CP B                    ; Within the limit?
CHKCOM:
  CALL NC,OUTDO_CRLF      ; No - output CRLF                ;TYPE CRLF
  JR NC,NEXITM            ; Get next item                   ;AND QUIT IF BEYOND THE LAST COMMA FIELD

; a.k.a MORCOM
ZONELP:
  SUB CLMWID              ; Next zone of 13 characters   (14 characters on other computers)
  JR NC,ZONELP            ; Repeat if more zones
  CPL                     ; Number of spaces to output
  JR ASPCS                ; Output them

; __TAB(   &   __SPC(
;
; Used by the routine at __PRINT.
__TAB:
  PUSH AF                 ; Save token                  ;REMEMBER IF [A]=SPCTK OR TABTK
  CALL FNDNUM             ; Numeric argument (0..255)   ;EVALUATE THE ARGUMENT

  RST SYNCHR              ; Make sure ")" follows
  DEFB ')'

  DEC HL                  ; Back space on to ")"
  POP AF                  ; Restore token               ;SEE IF ITS SPC OR TAB
  SUB TK_SPC              ; Was it "SPC(" ?             ;IF SPACE LEAVE ALONE
  PUSH HL                 ; Save code string address
  JR Z,DOSPC              ; Yes - Do "E" spaces

  LD A,(PRTFLG)           ;LINE PRINTER OR TTY?         ;GOING TO PRINTER?
  OR A                    ;NON-ZERO MEANS LPT           ;SET FLAGS
  JR Z,TTYIST
  LD A,(LPTPOS)           ; Get current printer position     ;GET LINE PRINTER POSITION
  JR DOSPC

TTYIST:
  LD A,(CURPOS)           ; Get current position        ;GET TELETYPE PRINT POSITION
DOSPC:
  CPL                     ; Number of spaces to print to    ;PRINT [E]-[A] SPACES
  ADD A,E                 ; Total number to print
  JR NC,NEXITM            ; TAB < Current POS(X)

; This entry point is used by the routine at __PRINT.
ASPCS:
  INC A                   ; Output A spaces
  LD B,A                  ; Save number to print        ;[B]=NUMBER OF SPACES TO PRINT
  LD A,' '                ; Space                       ;[A]=SPACE
SPCLP:
  RST OUTDO               ; Output character in A       ;PRINT [A]
  DJNZ SPCLP              ; Repeat if more

;
; Move to next item in the PRINT list
; Routine at 10044
;
; Used by the routines at __PRINT and __TAB.
NEXITM:
  POP HL                  ; Restore code string address     ;PICK UP TEXT POINTER
  RST CHRGTB              ; Get next character              ;AND THE NEXT CHARACTER
  ;AND SINCE WE JUST PRINTED SPACES, DON'T CALL CRDO IF IT'S THE END OF THE LINE
  JP PRNTLP               ; More to print

;FINISH 'PRINT' BY RESETTING FLAGS
;(IN WHICH CASE A TERMINATOR DOES NOT MEAN WE SHOULD TYPE A CRLF BUT JUST RETURN)
; This entry point is used by the routine at __PRINT.
FINPRT:
  XOR A
  LD (PRTFLG),A
  RET

;
; a.k.a. BADINP
; HERE WHEN PASSING OVER STRING LITERAL IN SUBSCRIPT OF VARIABLE IN INPUT LIST
; ON THE FIRST PASS OF INPUT CHECKING FOR TYPE MATCH AND NUMBER
;
; This entry point is used by the routine at INPBIN.
SCNSTR:
  LD A,(FLGINP)           ; READ or INPUT?                  ;WAS IT READ OR INPUT?
  OR A                    ;                                 ;ZERO=INPUT
  JP NZ,DATSNR            ; READ - ?SN Error                ;GIVE ERROR AT DATA LINE
;RDOIN2:
  POP BC                  ; Throw away code string addr     ;GET RID OF THE POINTER INTO THE VARIABLE LIST
  LD HL,REDO_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,NEXITM_0
  LD HL,REDO_MSG          ; "Redo from start" message
NEXITM_0:
  CALL PRS                ; Output string                   ;PRINT "?REDO FROM START" TO NEWSTT POINTING AT THE START OF
  JP GTMPRT               ; Do last INPUT again             ;GO BACK TO NEWSTT 
                                                            ;OF THE "INPUT" STATEMENT

; Routine at 10080
__INPUT:
  CALL IDTEST             ; Test for illegal direct
  CALL INPHK              ;  Hook code for 'INPUT'
  LD A,(HL)

  CP '"'                  ; Is there a prompt string?    ;IS IT A QUOTE?
  LD A,$00                ; Clear A and leave flags      ;BE TALKATIVE
  JR NZ,NOPMPT            ; No prompt - get input

  CALL QTSTR              ; Get string terminated by '"' ; MAKE THE MESSAGE A STRING

  RST SYNCHR
  DEFB $3B

; Routine at 10098
L2772:
  PUSH HL                 ; Save code string address     ;REMEMBER WHERE IT ENDED
  CALL PRS1               ; Output prompt string

  DEFB $3E                ; "LD A,n" to Mask "POP HL"

NOPMPT:
  PUSH HL                 ; Save code string address

IF V10

  LD A,(PICFLG)
  SET 5,A
  LD (PICFLG),A
  SET 6,(IX+$03)
QINLIN:
  CALL QINLIN_SUB
  RES 6,(IX+$03)
  LD A,(PICFLG)
  RES 0,A
  LD (PICFLG),A

ELSE

  CALL QINLIN_V11             ; Get input with "? " prompt
  JR NOTQTI

  DEFB $00,$00,$00

; This entry point is used by the routine at QINLIN.
QINLIN:
  CALL QINLIN_SUB
  RES 6,(IX+$03)          ; CURSOR - Hide
  LD A,(PICFLG)
  RES 5,A
  RES 0,A
  LD (PICFLG),A
  RET

  DEFB $00

ENDIF

NOTQTI:
  POP BC                  ; Restore code string address
  JP C,INPBRK             ; Break pressed - Exit
  INC HL                  ; Next byte
  LD A,(HL)               ; Get it
  OR A                    ; End of line?
  DEC HL                  ; Back again
  PUSH BC                 ; Re-save code string address      ;PUT BACK SINCE DIDN'T LEAVE
  JP Z,NXTDTA             ; Yes - Find next DATA stmt
;
; THIS IS THE FIRST PASS DICTATED BY ANSI REQUIRMENT THAN NO VALUES BE ASSIGNED 
; BEFORE CHECKING TYPE AND NUMBER. THE VARIABLE LIST IS SCANNED WITHOUT EVALUATING
; SUBSCRIPTS AND THE INPUT IS SCANNED TO GET ITS TYPE. NO ASSIGNMENT IS DONE
;
  LD (HL),','             ; Store comma as separator         ;SETUP COMMA AT BUFMIN
  JR INPCON               ; Get next item


; 'READ' BASIC command
; Routine at 10147
__READ:
  PUSH HL                 ; Save code string address      ;SAVE THE TEXT POINTER
  LD HL,(DATPTR)          ; Next DATA statement           ;GET LAST DATA LOCATION
  
  DEFB $F6                ; OR AFh ..Flag "READ"          ;"ORI" TO SET [A] NON-ZERO

;
; THIS IS THE FIRST PASS DICTATED BY ANSI REQUIRMENT THAN NO VALUES BE ASSIGNED 
; BEFORE CHECKING TYPE AND NUMBER. THE VARIABLE LIST IS SCANNED WITHOUT EVALUATING
; SUBSCRIPTS AND THE INPUT IS SCANNED TO GET ITS TYPE. NO ASSIGNMENT IS DONE
;
; Routine at 10152
; Used by the routine at __INPUT.
INPCON:
  XOR A					; Flag "INPUT"                   ;SET FLAG THAT THIS IS AN INPUT
  LD (FLGINP),A			; Save "READ"/"INPUT" flag       ;STORE THE FLAG
;
; IN THE PROCESSING OF DATA AND READ STATEMENTS:
; ONE POINTER POINTS TO THE DATA (IE THE NUMBERS BEING FETCHED)
; AND ANOTHER POINTS TO THE LIST OF VARIABLES
;
; THE POINTER INTO THE DATA ALWAYS STARTS POINTING TO A
; TERMINATOR -- A , : OR END-OF-LINE
;
  EX (SP),HL			; Get code str' , Save pointer   ;[H,L]=VARIABLE LIST POINTER <> DATA POINTER GOES ON THE STACK
  
  DEFB $01	; "LD BC,nn" to jump over the next word without executing it

; CHECK FOR COMMA AND GET ANOTHER VARIABLE TO FILL WITH DATA
;
; Used by the routine at INPBIN.
LOPDT2:
  RST SYNCHR              ; Check for comma between items
  DEFM ","                ;MAKE SURE THERE IS A ","

; a.k.a. LOPDAT
; Routine at 10160
GTVLUS:
  CALL GETVAR             ; Get variable name       ;READ THE VARIABLE LIST AND GET THE POINTER TO A VARIABLE INTO [D,E]
                                                    ;PUT THE VARIABLE LIST POINTER ONTO THE STACK AND TAKE THE DATA LIST POINTER OFF
  EX (SP),HL              ; Save code str" , Get pointer
;
; NOTE AT THIS POINT WE HAVE A VARIABLE WHICH WANTS DATA
; AND SO WE MUST GET DATA OR COMPLAIN
;
  PUSH DE                 ; Save variable address   ; SAVE THE POINTER TO THE VARIABLE WE ARE ABOUT TO SET UP WITH A VALUE

  ;SINCE THE DATA LIST POINTER ALWAYS POINTS AT A TERMINATOR LETS READ THE TERMINATOR INTO [A] AND SEE WHAT IT IS
  LD A,(HL)               ; Get next "INPUT"/"DATA" byte
  CP ','                  ; Comma?
  JR Z,SCNVAL             ; Yes - Get another value       ;A COMMA SO A VALUE MUST FOLLOW
  LD A,(FLGINP)           ; Is it READ?                   ;SEE WHAT TYPE OF STATEMENT THIS WAS
  OR A
  JP NZ,FDTLP             ; Yes - Find next DATA stmt     ;SEARCH FOR ANOTHER DATA STATEMENT

  LD A,'?'                ; More INPUT needed
  RST OUTDO               ; Output character

IF V10
  CALL QINLIN_SUB
ELSE
  CALL QINLIN             ; Get INPUT with prompt, HL = resulting text 
ENDIF

  POP DE                  ; Variable address
  POP BC                  ; Code string address
  JP C,INPBRK             ; Break pressed
  INC HL                  ; Point to next DATA byte
  LD A,(HL)               ; Get byte
  DEC HL                  ; Is it zero (No input) ?
  OR A                    ; Back space INPUT pointer
  PUSH BC                 ; Save code string address
  JP Z,NXTDTA             ; Find end of buffer
  PUSH DE                 ; Save variable address

;
; a.k.a. ANTVLU
;
; Routine at 10197
; Used by the routines at GTVLUS and FDTLP.
SCNVAL:
  LD A,(VALTYP)           ; Check data type
  OR A
;
; IF NUMERIC, USE FIN TO GET IT
; ONLY THE VARAIBLE TYPE IS CHECKED SO AN UNQUOTED STRING CAN BE ALL DIGITS
;
  JR Z,INPBIN	    ; If numeric, convert to binary

  RST CHRGTB              ; Get next character
  LD D,A                  ; Save input character            ;ASSUME QUOTED STRING
  LD B,A                  ; Again                           ;SETUP TERMINATORS
  CP '"'                  ; Start of literal sting?         ;QUOTE ?
  JR Z,STRENT             ; Yes - Create string entry       ;TERMINATORS OK
  LD A,(FLGINP)           ; "READ" or "INPUT" ?             ;INPUT SHOULDN'T TERMINATE ON ":"
  OR A                                                      ;SEE IF READ OR INPUT
  LD D,A                  ; Save 00 if "INPUT"              ;SET D TO ZERO FOR INPUT
  JR Z,ITMSEP             ; "INPUT" - End with 00
  LD D,':'                ; "DATA" - End with 00 or ":"     ;UNQUOTED STRING TERMINATORS

; Item separator - ANSI USES [B]=44 AS A FLAG TO TRIGGER TRAILING SPACE
; SUPPRESSION
;
; Used by the routine at SCNVAL.
ITMSEP:
  LD B,','                ; ARE COLON AND COMMA
                          ; NOTE: ANSI USES [B]=44 AS A FLAG TO TRIGGER TRAILING SPACE SUPPRESSION

  DEC HL                  ; Back space for DTSTR
                          ; BACKUP SINCE START CHARACTER MUST BE INCLUDED
                          ; IN THE QUOTED STRING CASE WE DON'T WANT TO
                          ; INCLUDE THE STARTING OR ENDING QUOTE

; a.k.a. NOWGET
; This entry point is used by the routine at SCNVAL.
STRENT:
  ;MAKE A STRING DESCRIPTOR FOR THE VALUE AND COPY IF NECESSARY
  CALL DTSTR              ; Get string terminated by D

DOASIG:
  EX DE,HL                ;[D,E]=TEXT POINTER
  LD HL,LTSTND            ;RETURN LOC
  EX (SP),HL              ;[H,L]=PLACE TO STORE VARIABLE VALUE
  PUSH DE                 ;TEXT POINTER GOES ON
  JP __LET_1              ;DO ASSIGNMENT

; a.k.a. NUMINS
;
; Used by the routine at SCNVAL.
INPBIN:
  RST CHRGTB              ; Get next character
  CALL H_ASCTFP           ; Convert ASCII to FP number
  EX (SP),HL              ; Save input ptr, Get var addr
  CALL FPTHL              ; Move FPREG to variable
  POP HL                  ; Restore input pointer

; Where to go after LETSTR
LTSTND:
  DEC HL                  ; DEC 'cos GETCHR INCs
  RST CHRGTB              ; Get next character
  JR Z,MORDT              ; End of line - More needed?
  CP ','                  ; Another value?
  JP NZ,SCNSTR            ; No - Bad input           ;ENDED PROPERLY?

MORDT:
  EX (SP),HL              ; Get code string address
  DEC HL                  ; DEC 'cos GETCHR INCs     ;LOOK AT TERMINATOR
  RST CHRGTB              ; Get next character       ;AND SET UP CONDITION CODES
  JR NZ,LOPDT2            ; More needed - Get it     ;NOT ENDING, CHECK FOR COMMA AND GET
                                                     ;ANOTHER VARIABLE TO FILL WITH DATA
  POP DE                  ; Restore DATA pointer     ;POP OFF THE POINTER INTO DATA
  LD A,(FLGINP)           ; "READ" or "INPUT" ?      ;FETCH THE STATEMENT TYPE FLAG
  OR A
				;INPUT STATEMENT
  EX DE,HL                ; DATA pointer to HL
  JP NZ,UPDATA            ; Update DATA pointer if "READ"      ;UPDATE DATPTR
  PUSH DE                 ; Move code string address           ;SAVE THE TEXT POINTER
  OR (HL)
  LD HL,EXTRA_MSG_FR
  PUSH AF
  LD A,(FRGFLG)
  OR A
  JR Z,EXTRA_FR
  LD HL,EXTRA_MSG         ; "?Extra ignored"
EXTRA_FR:
  POP AF
  CALL NZ,PRS
  POP HL                  ; Restore code string address        ;GET BACK THE TEXT POINTER
  RET


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
; Used by the routine at GTVLUS.
FDTLP:
  CALL __DATA             ; Get next statement
  OR A                    ; End of line?
  JR NZ,FANDT             ; No - See if DATA statement
  INC HL
  LD A,(HL)               ; End of program?
  INC HL
  OR (HL)                 ; 00 00 Ends program
  LD E,$06                ; Err $06 - "Out of DATA" (?OD Error)   ;NO DATA IS ERROR ERROD
  JP Z,ERROR              ; Yes - Out of DATA                     ;IF SO COMPLAIN
  INC HL                                                          ;SKIP PAST LINE #
  LD E,(HL)               ; LSB of line number                    ;GET DATA LINE #
  INC HL
  LD D,(HL)
  LD (DATLIN),DE          ; Set line of current DATA item
FANDT:
  RST CHRGTB              ; Get next character               ;GET THE STATEMENT TYPE
  CP TK_DATA              ; "DATA" token                     ;IS IS "DATA"?
  JR NZ,FDTLP             ; No "DATA" - Keep looking         ;NOT DATA SO LOOK SOME MORE
  JR SCNVAL               ; Found - Convert input            ;CONTINUE READING


; acquisition parameter sign on 2 bytes
;
; Used by the routines at _GETNUM, __CALL, L1C76, L1C82, FORFND, _CHRGTB, DOFN,
; GETINT and __CLEAR.
GETNUM:
  CALL EVAL             ; Get a numeric expression


TSTNUM:
  DEFB $F6              ; Clear carry (numeric)  ("OR n" to mask the next byte)

; Test a string, 'Type Error' if it is not
;
; Used by the routines at EVAL_VARIABLE, CONCAT and GETSTR.
TSTSTR:
  SCF                   ; Set carry (string)

; This entry point is used by the routines at __LET and CMPLOG.
CHKTYP:
  LD A,(VALTYP)         ; Check types match
  ADC A,A               ; Expected + actual
  OR A                  ; Clear carry , set parity
  RET PE                ; Even parity - Types match
  JP TM_ERR             ; Different types - Error

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
; Routine at 10331
FRMEQL:

  RST SYNCHR
  DEFB TK_EQUAL       ; Token code for '='       ;CHECK FOR EQUAL SIGN

  JR EVAL                                            ;EVALUATE FORMULA AND RETURN

; Routine at 10335
;
; Used by the routines at EVLPAR and VARRET.
OPNPAR:
  RST SYNCHR          ; Make sure "(" follows
  DEFM "("            ;GET PAREN BEFORE FORMULA

; Routine at 10337
;
; Used by the routines at __PLAY, L1CC0, __LET, __IF, __PRINT, GETNUM, FRMEQL
; and GETWORD.
EVAL:
  DEC HL              ; Evaluate expression & save          ;BACK UP CHARACTER POINTER

; Routine at 10338
EVAL_0:
  LD D,$00            ; Precedence value                    ;INITIAL DUMMY PRECEDENCE IS 0

; Save precedence and eval until precedence break
;
; Used by the routines at STKTHS, MINUS and NOT.
EVAL_1:
  PUSH DE             ; Save precedence                     ;SAVE PRECEDENCE
  LD C,$01            ; Check for 1 level of stack          ;EXTRA SPACE NEEDED FOR RETURN ADDRESS
  CALL CHKSTK                                               ;MAKE SURE THERE IS ROOM FOR RECURSIVE CALLS
  CALL OPRND          ; Get next expression value           ;EVALUATE SOMETHING

; Evaluate expression until precedence break
EVAL2:
  LD (NXTOPR),HL      ; Save address of next operator

; Evaluate expression until precedence break
;
; Used by the routine at NOT.
EVAL3:
  LD HL,(NXTOPR)      ; Restore address of next opr

  POP BC              ; Precedence value and operator       ;POP OFF THE PRECED
  LD A,B
  CP $78 
  CALL NC,TSTNUM
  LD A,(HL)           ; Get next operator / function        ;GET NEXT CHARACTER
  LD (TEMP3),HL                                             ;SAVE UPDATED CHARACTER POINTER
  CP TK_PLUS          ; (lower opr code)                    ;IS IT AN OPERATOR?
  RET C               ; ALL DONE (THIS CAN RESULT IN OPERATOR APPLICATION OR ACTUAL RETURN)       
  CP TK_MINOR+1       ; '<' +1  (higher opr code)           ;SOME KIND OF RELATIONAL?
  RET NC              ; NO, ALL DONE (THIS CAN RESULT IN OPERATOR APPLICATION OR ACTUAL RETURN)
  CP TK_GREATER       ; Token code for '>' (lower opr code) ;IS IT AN OPERATOR?
  JR NC,DORELS                                              ;YES, DO IT
  SUB TK_PLUS         ; Token code for '+'                  ;SUBTRAXDCT OFFSET FOR FIRST ARITHMETIC
  LD E,A              ; Coded operator                      ;MUST MULTIPLY BY 3 SINCE OPTAB ENTRIES ARE 3 LONG
  JR NZ,FOPRND        ; Function - Call it                  ;NOT ADDITION OP
  LD A,(VALTYP)       ; Get data type                       ;SEE IF LEFT PART IS STRING
  DEC A               ; String ?                            ;SEE IF ITS A STRING
  LD A,E              ; Coded operator                      ;REFETCH OP-VALUE
  JP Z,CONCAT         ; If so, string concatenation (use '+' to join strings)      ;MUST BE CAT
FOPRND:
  RLCA                ; Times 2
  ADD A,E             ; Times 3
  LD E,A              ; To DE (D is 0)
  LD HL,PRITAB        ; ARITHMETIC PRECEDENCE TABLE         ;CREATE INDEX INTO OPTAB
  LD D,$00                                                  ;MAKE HIGH BYTE OF OFFSET=0
  ADD HL,DE           ; To the operator concerned           ;ADD IN CALCULATED OFFSET
  LD A,B              ; Last operator precedence            ;[A] GETS OLD PRECEDENCE
  LD D,(HL)           ; Get evaluation precedence           ;REMEMBER NEW PRECEDENCE
  CP D                ; Compare with eval precedence        ;OLD-NEW
  RET NC              ; Exit if higher precedence           ;MUST APPLY OLD OP
                                                            ;IF HAS GREATER OR = PRECEDENCE, NEW OPERATOR
  INC HL              ; Point to routine address
  CALL TSTNUM         ; Make sure it's a number

; Stack expression item and get next one
;
; Used by the routine at EVAL_VARIABLE.
STKTHS:
  PUSH BC             ; Save last precedence & token
  LD BC,EVAL3         ; Where to go on prec' break          ;PUT ON THE ADDRESS OF THE
  PUSH BC             ; Save on stack for return
  LD B,E              ; Save operator
  LD C,D              ; Save precedence
  CALL PUSHF          ; Move value to stack
  LD E,B              ; Restore operator
  LD D,C              ; Restore precedence
  LD C,(HL)           ; Get LSB of routine address
  INC HL
  LD B,(HL)           ; Get MSB of routine address
  INC HL
;a.k.a. FINTMP
EVAL_MORE:
  PUSH BC             ; Save routine address             ;SAVE PLACE TO GO
  LD HL,(TEMP3)       ; Address of current operator      ;REGET THE TEXT POINTER
  JP EVAL_1           ; Loop until prec' break           ;PUSH ON THE PRECEDENCE AND READ MORE FORMULA

; This entry point is used by the routine at EVAL3.
DORELS:
  LD D,$00       ;ASSUME NO RELATION OPS, ALSO SETUP THE HIGH ORDER OF THE INDEX INTO OPTAB
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
  RST CHRGTB                ;GET THE NEXT CANDIDATE
  JR LOPREL


; Get next expression value (a.k.a. "EVAL" !)
; Used by the routines at EVAL and CONCAT.
; a.k.a. EVAL (in that case 'EVAL' was called 'FRMEVL')
;
; Used by the routines at EVAL_1 and CONCAT.
OPRND:
  XOR A                   ; Get operand routine
  LD (VALTYP),A           ; Set numeric expected
  RST CHRGTB              ; Gets next character (or token) from BASIC text.
  JP Z,MO_ERR             ;TEST FOR MISSING OPERAND - IF NONE, Err $18 - "Missing Operand" Error
  JP C,H_ASCTFP           ; Number - Get value
  CP '&'                  ;HEX CONSTANT?
  JP Z,HEXCNS
  CALL ISLETTER_A         ;VARIABLE NAME?                              See if a letter
  JR NC,EVAL_VARIABLE     ;AN ALPHABETIC CHARACTER MEANS YES           Letter - Find variable
  CP TK_PLUS              ;IGNORE "+"
  JR Z,OPRND              ; ..skip it, we will look the digits
  CP '.'                  ; "." ?
  JP Z,H_ASCTFP           ; Yes - Create FP number
  CP TK_MINUS             ;NEGATION?
  JR Z,MINUS              ; Yes - deal with minus sign
  CP '"'                  ;STRING CONSTANT?
  JP Z,QTSTR              ;IF SO BUILD A DESCRIPTOR IN A TEMPORARY DESCRIPTOR LOCATION
                          ;AND PUT A POINTER TO THE DESCRIPTOR IN FACLO.
  CP TK_NOT               ;CHECK FOR "NOT" OPERATOR
  JP Z,NOT
  CP TK_FN                ; "FN" Token ?
  JP Z,DOFN
  SUB TK_SGN              ; Is it a function?
  JR NC,ISFUN

; End of expression.  Look for ')'.
;
; Used by the routines at EVAL VARIABLE and DOFN.
EVLPAR:
  CALL OPNPAR

; Routine at 10512
L2910:
  RST SYNCHR

; Data block at 10513
L2911:
  DEFB ')'

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
VARRET:
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
; This entry point is used by the routine at VARRET.
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

;
; THE FOLLOWING ROUTINE IS CALLED FROM FIN IN F4
; TO SCAN LEADING SIGNS FOR NUMBERS. IT WAS MOVED
; TO F3 TO ELIMINATE BYTE EXTERNALS
;
; test '+', '-'..
; a.k.a. MINPLS
;
; This entry point is used by the routine at _ASCTFP.
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


POR:
  ; "OR n" to mask the next byte
  DEFB $F6                ; Flag "OR"

PAND:
  XOR A                   ; Flag "AND"
  PUSH AF                 ; Save "AND" / "OR" flag
  CALL TSTNUM             ; Make sure it's a number
  CALL CONIS              ; Get integer -32768 to 32767
  POP AF                  ; Restore "AND" / "OR" flag
  EX DE,HL                ; <- Get last
  POP BC                  ; <-  value
  EX (SP),HL              ; <-  from
  EX DE,HL                ; <-  stack
  CALL FPBCDE             ; Move last value to FPREG
  PUSH AF                 ; Save "AND" / "OR" flag
  CALL CONIS              ; Get integer -32768 to 32767
  POP AF                  ; Restore "AND" / "OR" flag
  POP BC                  ; Get value
  LD A,C                  ; Get LSB
  LD HL,ACPASS            ; Address of save AC as current
  JR NZ,POR1              ; Jump if OR
  AND E                   ; "AND" LSBs
  LD C,A                  ; Save LSB
  LD A,B                  ; Get MBS
  AND D                   ; "AND" MSBs
  JP (HL)                 ; Save AC as current (ACPASS)

POR1:
  OR E                    ; "OR" LSBs
  LD C,A                  ; Save LSB
  LD A,B                  ; Get MSB
  OR D                    ; "OR" MSBs
  JP (HL)                 ; Save AC as current (ACPASS)

; This entry point is used by the routine at STKTHS.
FINREL:
  LD HL,CMPLOG            ; Logical compare routine
  LD A,(VALTYP)           ; Get data type
  RRA                     ; Carry set = string
  LD A,D                  ; Get last precedence value
  RLA                     ; Times 2 plus carry
  LD E,A                  ; To E
  LD D,$64                ; Relational precedence
  LD A,B                  ; Get current precedence
  CP D                    ; Compare with last
  RET NC                  ; Eval if last was rel' or log'
  JP STKTHS               ; Stack this one and get next

; Routine at 10672
CMPLOG:
  DEFW CMPLG1

CMPLG1:
  LD A,C                  ; Get data type
  OR A
  RRA
  POP BC                  ; Get last expression to BCDE
  POP DE
  PUSH AF                 ; Save status
  CALL CHKTYP             ; Check that types match
  LD HL,DOCMP             ; Result to comparison         ;ROUTINE TO TAKE COMPARE ROUTINE RESULT
                                                         ;AND RELATIONAL BITS AND RETURN THE ANSWER
  PUSH HL                 ; Save for RETurn
  JP Z,FCOMP              ; Compare values if numeric
  XOR A                   ; Compare two strings
  LD (VALTYP),A           ; Set type to numeric
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
  LD D,$5A             ; Precedence value for "NOT"         ;"NOT" HAS PRECEDENCE 90, SO FORMULA EVALUATION
  CALL EVAL_1          ; Eval until precedence break        ;IS ENTERED WITH A DUMMY ENTRY OF 90 ON THE STACK
  CALL TSTNUM          ; Make sure it's a number
  CALL CONIS           ; Get integer -32768 - 32767         ;COERCE THE ARGUMENT TO INTEGER
  LD A,E               ; Get LSB
  CPL                  ; Invert LSB
  LD C,A               ; Save "NOT" of LSB
  LD A,D               ; Get MSB
  CPL                  ; Invert MSB
  CALL ACPASS          ; Save AC as current
  POP BC               ; Clean up stack
  JP EVAL3             ; Continue evaluation

; Routine at 10730
;
; Used by the routine at __FRE.
FRENUM:
  LD A,L                  ; Get LSB of end
  SUB E                   ; Subtract LSB of beginning
  LD C,A                  ; Save difference if C
  LD A,H                  ; Get MSB of end
  SBC A,D                 ; Subtract MSB of beginning
; This entry point is used by the routine at NOT.
ACPASS:
  LD B,C                  ; Return integer AC

; Routine at 10736
;
; Used by the routine at PASSA.
GIVINT:
  LD D,B                  ; Return integer AB

; Get back from function passing an INT value in A+B registers
ABPASS:
  LD E,$00
  LD HL,VALTYP            ; Point to type
  LD (HL),E               ; Set type to numeric
  LD B,$90                ; 16 bit integer
  JP FLOATR               ; Return the integr          ;GO FLOAT THE NUMBER

; Routine at 10748
__LPOS:
  LD A,(LPTPOS)           ; Get cursor position
  JR PASSA                ; Return integer A

; Routine at 10753
__POS:
  CALL CONINT
  INC A
  JR Z,__POS_0
  LD A,(CURPOS)           ;GET TELETYPE POSITION, SEE WHERE WE ARE
  JR PASSA

__POS_0:
  LD A,(YCURSO)

; USR routine return
;
; Used by the routines at _PASSA, __STICKX, __STICKY, __ACTION, __KEY, __LPOS,
; __POS and __PEEK.
PASSA:
  LD B,A                  ; Put A into AB
  XOR A                   ; Zero A
  JR GIVINT               ; Return integer AB


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

; Routine at 10771
__DEF:
; DEF FN<name>[«parameter list>}]=<function definition>
;
  CALL GETFNM             ; Get "FN" and name              ;GET A POINTER TO THE FUNCTION NAME
  CALL IDTEST             ; Error if in 'DIRECT' (immediate) mode
  LD BC,__DATA            ; on exit, go to get next statement
  PUSH BC                 ; Save address for RETurn
  PUSH DE                 ; Save address of function ptr
  LD DE,$0000
  LD A,(HL)
  CP '('                  ; Make sure "(" follows
  JR NZ,__DEF_0
  RST CHRGTB
  CALL GETVAR
  PUSH HL                 ; Save code string address
  EX DE,HL                ; Argument address to HL
  DEC HL
  LD D,(HL)               ; Get first byte of arg name
  DEC HL
  LD E,(HL)               ; Get second byte of arg name
  POP HL                  ; Restore code string address
  CALL TSTNUM             ; Make sure numeric argument

  RST SYNCHR              ; Make sure ")" follows
  DEFB ')'

__DEF_0:
  RST SYNCHR              ; Make sure "=" follows
  DEFB TK_EQUAL           ; "=" token

  LD B,H                  ; Code string address to BC
  LD C,L
  EX (SP),HL              ; Save code str , Get FN ptr
  LD (HL),C               ; Save LSB of FN code string
  INC HL
  LD (HL),B               ; Save MSB of FN code string
  JP PUTDEI

; This entry point is used by the routine at OPRND.
DOFN:
  CALL GETFNM             ; Make sure "FN" follows and get FN name
  PUSH DE                 ; Save function pointer address
  CALL EVLPAR             ; Evaluate expression in "()"
  CALL TSTNUM             ; Make sure numeric result
  EX (SP),HL              ; Save code str , Get FN ptr
  LD E,(HL)               ; Get LSB of FN code string
  INC HL
  LD D,(HL)               ; Get MSB of FN code string
  INC HL                  
  LD A,D                  ; And function DEFined?
  OR E                    
  JP Z,UF_ERR             ; No - ?UF Error
  LD A,(HL)               ; Get LSB of argument address
  INC HL                  
  LD H,(HL)               ; Get MSB of argument address
  LD L,A                  ; HL = Arg variable address
  PUSH HL                 ; Save it
  LD HL,(PRMNAM)          ; Get old argument name
  EX (SP),HL              ; Save old , Get new
  LD (PRMNAM),HL          ; Set new argument name
  LD HL,(PRMVAL+2)        ; Get LSB,NLSB of old arg value
  PUSH HL                 ; Save it
  LD HL,(PRMVAL)          ; Get MSB,EXP of old arg value
  PUSH HL                 ; Save it
  LD HL,PRMVAL            ; HL = Value of argument
  PUSH DE                 ; Save FN code string address
  CALL FPTHL              ; Move FPREG to argument
  POP HL                  ; Get FN code string address
  CALL GETNUM             ; Get value from function
  DEC HL                  ; DEC 'cos GETCHR INCs
  RST CHRGTB              ; Get next character
  JP NZ,SN_ERR            ; Bad character in FN - Error
  POP HL                  ; Get MSB,EXP of old arg
  LD (PRMVAL),HL          ; Restore it
  POP HL                  ; Get LSB,NLSB of old arg
  LD (PRMVAL+2),HL        ; Restore it
  POP HL                  ; Get name of old arg
  LD (PRMNAM),HL          ; Restore it
  POP HL                  ; Restore code string address
  RET
  
  
; This entry point is used by the routines at __INPUT and __DEF.
IDTEST:
  PUSH HL                 ; Save code string address
  LD HL,(CURLIN)          ; Get current line number
  INC HL                  ; -1 means direct statement
  LD A,H                  
  OR L                    
  POP HL                  ; Restore code string address
  RET NZ                  ; Return if in program
  LD E,$16                ; ?ID Error
  JP ERROR

;
; SUBROUTINE TO GET A POINTER TO A FUNCTION NAME
; Make sure "FN" follows and get FN name
;
;
; Routine at 10901
; Used by the routines at __DEF and DOFN.
GETFNM:
  RST SYNCHR
  DEFB TK_FN

  LD A,$80                ;DONT ALLOW AN ARRAY,
  LD (SUBFLG),A           ;DON'T RECOGNIZE THE "(" AS THE START OF AN ARRAY REFEREENCE
  OR (HL)                 ; FN name has bit 7 set      ;PUT FUNCTION BIT ON
  LD C,A                  ; in first byte of name      ;GET FIRST CHARACTER INTO [C]
  CALL GTFNAM
  JP TSTNUM

; Load 'A' with the next number in BASIC program
;
; Used by the routines at __ERL and __FIELD.
; a.k.a. GTBYTC:  pick a numeric argument (0..255)
;
; Used by the routine at __TAB.
FNDNUM:
  RST CHRGTB

; Get a number to 'A'
; a.k.a. GETBYT, get integer in 0-255 range
;
; Used by the routines at __GETINT, __SOUND, __SOUND, __SETE, __TX, L0E19, L0E2D,
; __INIT, __CURSOR, __DELIM, __DISPLAY, __ON, EVAL_VARIABLE, __POKE and __MID_S.
GETINT:
  CALL GETNUM             ;READ A VALUE

; Convert tmp string to int in A register
;
; Used by the routines at __STICKX, __STICKY, __ACTION, __POS and __CHR_S.
CONINT:
  CALL DEPINT             ;CONVERT THE FAC TO AN INTEGER IN [D,E]
  LD A,D
  OR A
  JP NZ,FC_ERR            ;WASN'T ERROR (Err $05 - "Illegal function call")
  DEC HL                  ;ACTUALLY FUNCTIONS CAN GET HERE
                          ;WITH BAD [H,L] BUT NOT SERIOUS
                          ;SET CONDITION CODES ON TERMINATOR
  RST CHRGTB
  LD A,E                  ;RETURN THE RESULT IN [A] AND [E]
  RET

; Routine at 10932
__PEEK:
  CALL CONIS              ;GET AN INTEGER IN [D,E]
  LD A,(DE)               ;GET THE VALUE TO RETURN
  JP PASSA                ;AND FLOAT IT

; Routine at 10939
__POKE:

IF V10
  CALL GETNUM             ; Get integer 0 to 32767
  CALL CONIS
ELSE
  CALL GETWORD            ;READ A FORMULA
ENDIF

  PUSH DE

  RST SYNCHR
  DEFB ','

IF V10
  CALL INTIDX_0           ; Get integer
ELSE
  CALL GETINT             ; Get integer 0-255
ENDIF

IF V10
  LD A,E
ENDIF

  POP DE
  LD (DE),A
  RET


IF !V10
; Data block at 10951
L2AC7:
  DEFB $00,$00,$00,$00
ENDIF


; Get a number to DE
; a.k.a. FRMQNT
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
IF V10
  AND $7F
ELSE
  NOP
  NOP
ENDIF
  OR $01
  LD (PICFLG),A           ;DONT ALLOW ^C TO CHANGE
  POP AF
  JP M,T_EDIT_55
  CP $0D
IF V10
  JP Z,T_EDIT_CR
ELSE
  JP QINLIN_5
  ENDIF

; This entry point is used by the routine at QINLIN.
T_EDIT_0:
  CP $09
  JP Z,T_EDIT_TAB
  CP $0A
  JP Z,T_EDIT_LF
  CP $0C
  JP Z,T_EDIT_40

IF V10

  CP $1F
  JR NZ,T_EDIT_2

ELSE
  JP QINLIN_0
  NOP
ENDIF

; This entry point is used by the routine at QINLIN.
T_EDIT_1:
  LD A,(PICFLG)
  BIT 5,A
  JR NZ,T_EDIT_4
  LD A,$1F
; This entry point is used by the routines at L33CD and QINLIN.
T_EDIT_2:
  RST OUTDO
T_EDIT_3:
  LD (IX+$01),$01
  LD (IX+$00),$01            ; Screen refresh counter
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
  CP 24
  JR NC,T_EDIT_7
  PUSH HL
  INC H
  LD L,0
  CALL SCR_GETCHR
  POP HL
  JR Z,T_EDIT_8
T_EDIT_7:
  LD A,L
  CP 39
  JR NC,T_EDIT_11
T_EDIT_8:
  PUSH AF
  LD A,L
  CP 39
  JR C,T_EDIT_9
  INC H
  LD L,0
T_EDIT_9:
  INC L
  LD (RETADR),HL
  PUSH HL
  CALL SCR_GETCHR
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
  CP 40
  JR NC,T_EDIT_11
  INC HL
  INC HL
  LD A,(HL)
  CP ' '
  JR Z,T_EDIT_10
  LD A,' '
  JR T_EDIT_16

T_EDIT_11:
  LD A,(PICFLG)
  RES 1,A
  LD (PICFLG),A           ;ALLOW ^C TO CHANGE
  LD A,(ENTSTT)
  BIT 7,A
  JR NZ,T_EDIT_15
  CP ' '
  JR Z,T_EDIT_12
  CP '0'
  JR C,L2BA1
  CP '9'+1
  JR NC,L2BA1

T_EDIT_12:
  LD A,(CURPOS)
  CP $01
  JR Z,T_EDIT_14
; This entry point is used by the routine at QINLIN.
T_EDIT_13:
  CALL T_EDIT_23
  JR T_EDIT_15
T_EDIT_14:

IF V10

  LD A,$06
  RST $18
  jr T_EDIT_15

ELSE

  JP QINLIN_3
  NOP
  DEFB $06    ; "LD B,n" over the next 2 bytes

ENDIF

L2BA1:
  CALL T_EDIT_23

  LD A,$1E            ; blank over previous character
  RST OUTDO
 
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
  LD A,$03                      ; NEWLINE
  RST OUTDO
  LD HL,(CURPOS)
  DEC L
  CALL SCR_GETCHR
  JR Z,T_EDIT_23
  RET

; This entry point is used by the routine at QINLIN.
T_EDIT_CR:
  LD HL,(CURPOS)
T_EDIT_25:

IF V10
  LD A,L
  DEC A
  JR Z,T_EDIT_26
ENDIF

  DEC L
  PUSH HL
  CALL SCR_GETCHR
  POP HL

IF V10

  CP '9'+1
  JR NC,T_EDIT_27
  CP '0'
  JR C,T_EDIT_27

ELSE
  CP $80
  JR Z,T_EDIT_26
  XOR $30
  CP $0A
  JR NC,T_EDIT_27

ENDIF
  JR T_EDIT_25

T_EDIT_26:

IF !V10
  LD A,L
  OR A
  JR NZ,T_EDIT_25
  INC L
ENDIF

  LD A,(AUTFLG)
  OR A

  JR Z,T_EDIT_27
  XOR A
  LD (AUTFLG),A
  LD (CURPOS),HL
  LD A,$04
  RST OUTDO
  JP T_EDIT_15
T_EDIT_27:
IF V10
  LD HL,(CURPOS)
ENDIF
  LD L,$01
T_EDIT_28:
  LD (RETADR),HL
  PUSH HL
  DEC L
  CALL SCR_GETCHR
  POP HL
  JR NZ,T_EDIT_29
  DEC H
  JP M,T_EDIT_34
  JR T_EDIT_28
T_EDIT_29:
  LD A,(PICFLG)
  BIT 5,A
  JR Z,T_EDIT_32
IF V10
  RES 5,A
  LD (PICFLG),A
ELSE
  NOP
  NOP
  NOP
  NOP
  NOP
ENDIF
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
  CP '?'
  JR NZ,T_EDIT_30
  LD (RETADR),DE
  JR T_EDIT_30

T_EDIT_31:
  LD A,'0'
  JR T_EDIT_33

T_EDIT_32:
  CALL SCR_GETCHR
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

T_EDIT_TAB:
  LD A,(YCURSO)
  OR A
  JR NZ,T_EDIT_36
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,T_EDIT_4
  LD DE,(DOT)
  CALL SRCHLN
  LD BC,(PRELIN)
  LD A,B
  OR C
  JP Z,T_EDIT_4
  JP T_EDIT_41
T_EDIT_36:
  LD A,$09
  JP T_EDIT_2

T_EDIT_LF:
  LD A,(YCURSO)
  CP 24
  JP C,T_EDIT_39
  LD A,(PICFLG)
  BIT 5,A
  JP NZ,T_EDIT_4
  LD DE,(DOT)
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
  LD (DOT),DE
  OR A
  LD HL,(CURPOS)
  PUSH HL
T_EDIT_42:
  PUSH AF
  LD A,$81
  LD (PICFLG),A
  LD (IX+$00),$40            ; Screen refresh counter
  LD (IX+$08),$00
  LD HL,$0001
  LD (CURPOS),HL
  CALL CLR_SCR
  LD DE,(DOT)
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
  LD A,' '
  POP HL
T_EDIT_48:
  RST OUTDO
  LD A,(PICFLG)
  BIT 6,A
  JP NZ,T_EDIT_53
T_EDIT_49:
  LD A,(HL)
  INC HL
  CP LINCON
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

  SUB TK_END-1
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
  RST OUTDO
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
  CP $BA                       ; TK_MINUS ?
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
  RST OUTDO
  INC HL
  JR T_EDIT_57

T_EDIT_58:
  SUB $B0
  LD E,A
  LD D,$00
  LD HL,BUF10
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
  PUSH HL                 ; Save code string address
  LD A,$FF-95             ; (-95), low order byte, NASCOM keeps -48, MSX -120.
  SUB L
  LD L,A
  LD A,$FF                ; (-95), low order byte
  SBC A,H
  LD H,A
  JR C,OM_ERR             ; ?OM Error if so
  ADD HL,SP               ; Test if stack is overflowed
  POP HL                  ; Restore code string address
  RET C

; This entry point is used by the routines at INIT, __CLEAR and BS_ERR.
OM_ERR:
  LD DE,$000C
  JP ERROR

IF V10
__NEW:
ENDIF
  RET NZ
; This entry point is used by the routines at INIT, __SAVE, L1A50 and __NEW.
CLRPTR:
  LD HL,(TXTTAB)

; This entry point is used by the routine at __NEW.
CLRPTR_0:

IF V10
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
ELSE
  XOR A
  JP CLRPTR_1
ENDIF

; This entry point is used by the routine at SHIFT_STOP.
RUN_FST_0:
  INC HL                  ;BUMP POINTER
  LD (VARTAB),HL          ;NEW START OF VARIABLES

; This entry point is used by the routines at PROMPT and __RUN.
RUN_FST:
  LD HL,(TXTTAB)          ;POINT AT THE START OF TEXT
  DEC HL


;
; CLEARC IS A SUBROUTINE WHICH INITIALIZES THE VARIABLE AND
; ARRAY SPACE BY RESETING ARYTAB [THE END OF SIMPLE VARIABLE SPACE]
; AND STREND [THE END OF ARRAY STORAGE]. IT FALLS INTO STKINI
; WHICH RESETS THE STACK. [H,L] IS PRESERVED.
;
; This entry point is used by the routines at __RUN, __CLEAR and __CLEAR.
CLEARC:
  LD (TEMP),HL            ; Save code string address in TEMP                 ;SAVE [H,L] IN TEMP
  LD HL,(MEMSIZ)
  LD (FRETOP),HL          ;FREE UP STRING SPACE
  XOR A                   ;MAKE SURE [A] IS ZERO, CC'S SET
  CALL __RESTORE          ;RESTORE DATA
  LD HL,(VARTAB)          ;GET START OF VARIABLE SPACE
  LD (ARYTAB),HL          ;SAVE IN START OF ARRAY SPACE
  LD (STREND),HL          ;AND END OF VARIABLE STORAGE

; STKINI RESETS THE STACK POINTER ELIMINATING
; GOSUB & FOR CONTEXT.  STRING TEMPORARIES ARE FREED
; UP, SUBFLG IS RESET, CONTINUING IS DISALLOWED,
; AND A DUMMY ENTRY IS PUT ON THE STACK. THIS IS SO
; FNDFOR WILL ALWAYS FIND A NON-"FOR" ENTRY AT THE BOTTOM
; OF THE STACK. [A]=0 AND [D,E] IS PRESERVED.
;
; This entry point is used by the routines at INIT, NMI_HANDLER and ERROR.
STKINI:
  POP BC                  ;GET RETURN ADDRESS HERE
  LD HL,(STKTOP)
  LD SP,HL                ;INITIALIZE STACK
  LD HL,TEMPST
  LD (TEMPPT),HL          ;INITIALIZE STRING TEMPORARIES
  CALL FINLPT             ; Disable printer echo if enabled
  XOR A                   ;ZERO OUT HL and A
  LD L,A
  LD H,A
  LD (OLDTXT),HL          ;MAKE CONTINUING IMPOSSIBLE
  LD (SUBFLG),A           ;ALLOW SUBSCRIPTS
  LD (PRMNAM),HL          ;NO PARAMETERS BEING BUILT
  PUSH HL
  PUSH BC
; This entry point is used by the routine at NEXITM.
GTMPRT:
  LD HL,(TEMP)            ;Restore code string address                       ;GET SAVED [H,L]
  RET


; Routine at 12062
;
; Used by the routine at ENFMEM.
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

; This entry point is used by the routine at INPBIN.
; a.k.a. RESFIN
UPDATA:
  LD (DATPTR),HL    ; Update DATA pointer                     ;READ FINISHES COME TO RESFIN
  EX DE,HL          ; Restore code string address             ;GET THE TEXT POINTER BACK
  RET

; Routine at 12088
;
; Used by the routine at ISCNTC.
__STOP:
  RET NZ            ;RETURN IF NOT CONTROL-C AND MAKE

  DEFB $F6                ; Flag "STOP"  ("OR n" to mask the next byte)

; Routine at 12090
__END:
  RET NZ                  ; Exit if anything else
  LD (TEMP),HL            ; Save point of break

  DEFB $21                ; Skip "OR 11111111B" ("LD HL,nn" over the next word)

; Routine at 12095
;
; Used by the routines at __INPUT and GTVLUS.
INPBRK:
  OR $FF                  ; Flag "Break" wanted
  POP BC                  ; Return not needed and more

; This entry point is used by the routine at FORFND.
ENDCON:
  LD HL,(CURLIN)          ; Get current line number
  PUSH AF                 ; Save STOP / END status
  LD A,L                  ; Is it direct break?
  AND H
  INC A                   ; Line is -1 if direct break
  JR Z,NOLIN              ; Yes - No line number
  LD (OLDLIN),HL          ; Save line of break
  LD HL,(TEMP)            ; Get point of break
  LD (OLDTXT),HL          ; Save point to CONTinue
NOLIN:
  CALL FINLPT             ; Disable printer echo if enabled
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG_FR
  PUSH AF
  LD A,(FRGFLG)
  OR A
  JR Z,INPBRK_0
  LD HL,BREAK_MSG         ; "Break" message
INPBRK_0:
  POP AF
  JP NZ,_ERROR_REPORT
  JP READY                ; Go to command mode

; Routine at 12143
__CONT:
  LD HL,(OLDTXT)          ; Get CONTinue address
  LD A,H                  ; Is it zero?
  OR L
  LD DE,$0020             ; ?CN Error  ("Cannot continue")
  JP Z,ERROR
  LD DE,(OLDLIN)          ; Get line of last break
  LD (CURLIN),DE          ; Set up current line number
  RET                     ; CONTinue where left off

_FC_ERR_A:
  JP FC_ERR
  
__ERASE:
  LD A,$01
  LD (SUBFLG),A           ;THAT THIS IS "ERASE" CALLING PTRGET
  CALL GETVAR             ;GO FIND OUT WHERE TO ERASE
  PUSH HL                 ;SAVE THE TEXT POINTER
  LD (SUBFLG),A           ;ZERO OUT SUBFLG TO RESET "ERASE" FLAG
  LD H,B                  ;[B,C]=START OF ARRAY TO ERASE
  LD L,C
  DEC BC                  ;BACK UP TO THE FRONT
  DEC BC                  ;NO VALUE TYPE WITHOUT LENGTH=2
  DEC BC                  ;BACK UP ONE MORE
  DEC BC

; This entry point is used by the routine at GETVAR.
CHKLTR:
  LD A,(HL)

; Check char in 'A' being in the 'A'..'Z' range
;
; Used by the routines at OPRND and GETVAR.
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
; Routine at 12192
__CLEAR:
  JP Z,CLEARC             ; Just "CLEAR" Keep parameters             ;IF NO FORMULA JUST CLEAR
  CALL INTIDX_0           ; Get integer
  DEC HL                  ; Cancel increment
  RST CHRGTB              ; Gets next character (or token) from BASIC text.
  PUSH HL                 ; Save code string address
  LD HL,(MEMSIZ)          ; Get end of RAM
  JR Z,STORED             ; No value given - Use stored
  POP HL                  ; Restore code string address

  RST SYNCHR              ; Check for comma
  DEFB ','

  PUSH DE                 ; Save number
  CALL GETNUM             ; Get integer 0 to 32767
  CALL CONIS
  DEC HL                  ; Cancel increment
  RST CHRGTB              ; Get next character
  JP NZ,SN_ERR            ; ?SN Error if more on line
  EX (SP),HL              ; Save code string address
  EX DE,HL                ; Number to DE
; This entry point is used by the routine at __CLEAR.
STORED:
  CALL SUBDE              ; Enough memory?   ; SUBTRACT [H,L]-[D,E] INTO [D,E]
  JP C,OM_ERR             ; No - ?OM Error

  PUSH HL                 ; Save RAM top
  LD HL,(VARTAB)          ; Get program end
  LD BC,40                ; 40 Bytes minimum working RAM (LEAVE BREATHING ROOM)
  ADD HL,BC               ; Get lowest address
  RST DCOMPR              ; Enough memory?
  JP NC,OM_ERR            ; No - ?OM Error
  EX DE,HL                ; RAM top to HL
  LD (STKTOP),HL          ; Set new top of RAM
  POP HL                  ; End of memory to use
  LD (MEMSIZ),HL          ; Set new top of RAM
  POP HL                  ; Restore code string address
  JP CLEARC               ; Initialise variables

;SUBTRACT [H,L]-[D,E] INTO [D,E]
SUBDE:
  LD A,L                  ; Get LSB of new RAM top
  SUB E                   ; Subtract LSB of string space
  LD E,A                  ; Save LSB
  LD A,H                  ; Get MSB of new RAM top
  SBC A,D                 ; Subtract MSB of string space
  LD D,A                  ; Save MSB
  RET

; Routine at 12260
__NEXT:
  LD DE,$0000             ; In case no index given
__NEXT_0:
  CALL NZ,GETVAR          ; not end of statement, locate variable (Get index address)
  LD (TEMP),HL            ; save BASIC pointer
  CALL BAKSTK             ; search FOR block on stack (skip 2 words)
  JP NZ,NF_ERR            ; No "FOR" - ?NF Error
  LD SP,HL                ; Clear nested loops  (SETUP STACK POINTER BY CHOPPING AT THIS POINT)
  PUSH DE                 ; Save index address
  LD A,(HL)               ; Get sign of STEP
  PUSH AF                 ; Save sign of STEP
  INC HL
  PUSH DE                 ; Save index address
  CALL MOVFM              ; Move index value to FPREG
  EX (SP),HL              ; Save address of TO value
  PUSH HL                 ; Save address of index
  CALL FADDS              ; Add STEP to index value
  POP HL                  ; Restore address of index
  CALL FPTHL              ; Move value to index variable
  POP HL                  ; Restore address of TO value
  CALL LOADFP             ; Move TO value to BCDE
  PUSH HL                 ; Save address of line of FOR
  CALL FCOMP              ; Compare index with TO value
  POP HL                  ; Restore address of line num
  POP BC                  ; Address of sign of STEP
  SUB B                   ; Compare with expected sign
  CALL LOADFP             ; BC = Loop stmt,DE = Line num
  JR Z,KILFOR             ; Loop finished - Terminate it
  EX DE,HL                ; Loop statement line number
  LD (CURLIN),HL          ; Set loop line number
  LD L,C                  ; Set code string to loop
  LD H,B
  JP PUTFID               ; Put back "FOR" and continue

KILFOR:
  LD SP,HL                ; Remove "FOR" block
  LD HL,(TEMP)            ; Code string after "NEXT"
  LD A,(HL)               ; Get next byte in code string
  CP ','                  ; More NEXTs ?
  JP NZ,NEWSTT            ; No - Do next statement
  RST CHRGTB              ; Position to index name
  CALL __NEXT_0           ; Re-enter NEXT routine

; < will not RETurn to here , Exit to RUNCNT (NEWSTT) or Loop >
;-----------------------------------------------------------------


; HEX to FP number
; a.k.a. OCTCNS, GETNUM
;
; On the VG-5000 the 8K BASIC dialect expects hexadecimal constants in the form:
;  LET A=&"FFFF"
;
; This entry point is used by the routines at H_ASCTFP and OPRND.
HEXCNS:
  INC HL

  RST SYNCHR            ; Make sure '"' follows
  DEFB '"'

; Evaluate expression
  LD DE,$0000           ;INITIALIZE TO ZERO AND IGNORE OVERFLOW
  LD B,$05              ;INIT DIGIT COUNT
  DEC HL                ; Evaluate expression & save
HEXCNS_0:
  CALL HEX_DIGIT
  JR C,HEXCNS_1          ; JP if not decimal
  EX DE,HL
  ADD HL,HL             ;SHIFT RIGHT FOUR BITS
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  OR L
  LD L,A
  EX DE,HL
  DJNZ HEXCNS_0

HEXCNS_1:
  CP '"'                ; final '"' required now
IF V10
  INC HL
ENDIF
  JP NZ,SN_ERR
IF !V10
  RST CHRGTB
ENDIF

IF V10
  LD A,$98
  LD (FPEXP),A
  XOR A
  LD B,A
  LD C,A
  PUSH HL
  CALL CONPOS
ELSE
  LD B,$98
  PUSH HL
  XOR A
  CALL FLOATR
ENDIF

  POP HL
  RET

IF !V10
  DEFB $00, $00, $00, $00, $00
ENDIF

; 'RENUM' BASIC command
;
; THE RESEQ(UENCE) COMMAND TAKE UP TO THREE ARGUMENTS
; RESEQ [NN[,MM[,INC]]]
; WHERE NN IS THE FIRST DESTINATION LINE OF THE
; LINES BEING RESEQUENCED, LINES LESS THAN MM ARE
; NOT RESEQUENCED, AND INC IS THE INCREMENT.
;
; Routine at 12376
__RENUM:
  LD BC,10             	;ASSUME INC=10
  PUSH BC              	;SAVE ON STACK
  LD D,B                ;RESEQ ALL LINES BY SETTING [D,E]=0
  LD E,B
  JR Z,__RENUM_1        ;IF JUST 'RESEQ' RESEQ 10 BY 10
  CP ','                ;COMMA
  JR Z,__RENUM_0        ;DONT USE STARTING # OF ZERO
  PUSH DE               ;SAVE [D,E]
  CALL ATOH             ;GET NEW NN
  LD B,D                ;GET IN IN [B,C] WHERE IT BELONGS
  LD C,E
  POP DE                ;GET BACK [D,E]
  JR Z,__RENUM_1        ;IF EOS, DONE

__RENUM_0:
  RST SYNCHR
  DEFB ','              ;EXPECT COMMA

  CALL ATOH             ;GET NEW MM
  JR Z,__RENUM_1        ;IF EOS, DONE
  POP AF                ;GET RID OF OLD INC

  RST SYNCHR
  DEFB ','              ;EXPECT COMMA

  PUSH DE               ;SAVE MM
  CALL ATOH             ;GET NEW INC
  JP NZ,SN_ERR          ;SHOULD HAVE TERMINATED.
  LD A,D                ;SEE IF INC=0 (ILLEGAL)
  OR E
  JP Z,FC_ERR           ;YES, BLOW HIM UP NOW (Err $05 - "Illegal function call")
  EX DE,HL              ;FLIP NEW INC & [H,L]
  EX (SP),HL            ;NEW INC ONTO STACK
  EX DE,HL              ;GET [H,L] BACK, ORIG [D,E] BACK

; This entry point is used by the routine at __RENUM.
__RENUM_1:
  PUSH BC               ;SAVE NN ON STACK
  CALL SRCHLN           ;FIND MM LINE
  POP DE                ;GET NN OFF STACK
  PUSH DE               ;SAVE NN BACK
  PUSH BC               ;SAVE POINTER TO MM LINE
  CALL SRCHLN           ;FIND FIRST LINE TO RESEQ.
  LD H,B
  LD L,C
  POP DE                ;GET LINE PTD TO BY MM
  RST DCOMPR            ;COMPARE TO FIRST LINE RESEQED
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
  RST DCOMPR            ;COMPARE TO CURRENT #
  POP HL                ;RESTORE LINK FIELD
  JP C,FC_ERR           ;UH OH, HIS INC WAS TOO LARGE. (Err $05 - "Illegal function call")
__RENUM_NXT_0:
  PUSH DE               ;SAVE CURRENT LINE ACCUM
  LD E,(HL)             ;GET LINK FIELD INTO [D,E]
  LD A,E                ;GET LOW PART INTO K[A] FOR ZERO TEST
  INC HL                
  LD D,(HL)             ;GET HIGH PART OF LINK
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
  INC HL                ;PREPARE FOR ZERO LINK FIELD TEST
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

SCCPTR:
  XOR A                 ;SET A=0
                        
  LD (PTRFLG),A         ;SET TO SAY WHETER LINES OR PTRS EXTANT
  LD HL,(TXTTAB)        ; Start of program text                     GET PTR TO START OF PGM
  DEC HL                ;                                           NOP NEXT INX.

SCNPLN:
  INC HL                ;                                           POINT TO BYTE AFTER ZERO AT END OF LINE
  LD A,(HL)             ; Get address of next line                  GET LINK FIELD INTO [D,E]
  INC HL                ;                                           BUMP PTR
  OR (HL)               ; End of program found?                     SET CC'S
  RET Z                 ; Yes - Line not found                      RETURN IF ALL DONE.
  INC HL                ;                                           POINT PAST LINE #
  LD E,(HL)             ; Get LSB of line number                    GET LOW BYTE OF LINE #
  INC HL                
  LD D,(HL)             ; Get MSB of line number                    GET HIGH BYTE OF LINE #
SCNEXT:
  RST CHRGTB            ;GET NEXT CHAR FROM LINE
  OR A                  ;END OF LINE
  JR Z,SCNPLN           ;SCAN NEXT LINE
  LD C,A                ;SAVE [A]
  LD A,(PTRFLG)         ;CHANGE LINE TOKENS WHICH WAY?
  OR A                  ;SET CC'S
  LD A,C                ;GET BACK CURRENT CHAR
  JR Z,SCNPT2           ;CHANGING POINTERS TO #'S
  CP LINCON             ; Line number prefix:  LINE # CONSTANT?
  JR NZ,SCNEXT          ;NO, IGNORE.
  PUSH DE               ;SAVE [D,E]
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
;CHGPTR:                 
  PUSH HL               ;SAVE TEXT POINTER JUST AT END OF LINCON 3 BYTES
  CALL SRCHLN           ;TRY TO FIND LINE IN PGM.
  DEC BC                ;POINT TO ZERO AT END OF PREVIOUS LINE
  LD A,PTRCON           ;CHANGE LINE # TO PTR
  JR C,MAKPTR           ;IF LINE FOUND CHANE # TO PTR
  CALL CONSOLE_CRLF     ;PRINT CRLF IF REQUIRED
  LD HL,LINE_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,LINE_ERR_FR_1
  LD HL,LINE_MSG
LINE_ERR_FR_1:
  PUSH DE               ;SAVE LINE #
  CALL PRS              ;PRINT "Undefined line" MESSAGE
  POP HL                ;GET LINE # IN [H,L]
  CALL LINPRT           ;PRINT IT
  LD HL,LINE_ERR_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,LINE_ERR_FR_2
  LD HL,LINE_ERR_MSG
LINE_ERR_FR_2:
  CALL PRS              ;PRINT IT
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
  JR SCNEXT

SCNPT2:
  CP LINCON
  JR NZ,SCCPTR_2
  INC HL
  INC HL
  JR _SCNEXT

SCCPTR_2:
  CP PTRCON            ;POINTER
  JR NZ,_SCNEXT        ;NO, KEEP SCANNING
  PUSH DE              ;SAVE CURRENT LINE #

  INC HL               ;GET #
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL

  PUSH HL              ;SAVE TEXT POINTER
  EX DE,HL             ;FLIP CURRENT TEXT PTR & PTR
  INC HL               ;BUMP POINTER
  INC HL               ;POINT TO LINE # FIELD
  INC HL
  LD C,(HL)            ;PICK UP LINE #
  INC HL               ;POINT TO HIGH PART
  LD B,(HL)
  LD A,LINCON		   ; Line number prefix
MAKPTR:
  LD HL,SCNPOP         ;PLACE TO RETURN TO AFTER CHANGING CONSTANT
  PUSH HL              ;SAVE ON STACK
  LD HL,(CONTXT)       ;GET TXT PTR AFTER CONSTANT IN [H,L]
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



; AUTO [<line number>[,<increment>]]
;
; THE AUTO [BEGGINNING LINE[,[INCREMENT]]]
; COMMAND IS USED TO AUTOMATICALLY GENERATE LINE NUMBERS FOR LINES TO BE INSERTED.
; BEGINNING LINE IS USED TO SPECIFY THE INITAL LINE (10 IS ASSUMED IF OMMITED)
; AND THE INCREMENT IS USED TO SPECIFY THE INCREMENT USED TO GENERATE THE NEXT LINE #.
; IF ONLY A COMMA IS USED AFTER THE BEGGINING LINE, THE OLD INCREMENT IS USED.
;
; Routine at 12654
__AUTO:
  LD DE,10                ;ASSUME INITIAL LINE # OF 10
  PUSH DE                 ;SAVE IT
  JR Z,__AUTO_0           ;IF END OF COMMAND USE 10,10
  CALL ATOH
  EX AF,AF'
  LD A,D
  OR E
  JP Z,SN_ERR
  POP BC
  PUSH DE
  EX AF,AF'
  JR Z,__AUTO_0           ;USE PREVIOUS INC IF TERMINATOR

  RST SYNCHR
  DEFB ','                ;COMMA MUST FOLLOW

  CALL ATOH               ;GET INC
  EX AF,AF'
  LD A,D
  OR E                    ;SEE IF ZERO
  JP Z,SN_ERR             ;ZERO INC GIVES error
  EX AF,AF'
  JP NZ,SN_ERR            ;SHOULD HAVE FINISHED.
  LD (AUTINC),DE          ;SAVE INCREMENT

; This entry point is used by the routine at __AUTO.
__AUTO_0:
  POP DE                  ;GET INITIAL LINE #
  LD (AUTLIN),DE          ;SAVE IN INTIAL LINE
  LD A,$01
  LD (AUTFLG),A
; This entry point is used by the routine at __LOAD.
P_PROMPT:
  POP BC                  ;GET RID OF NEWSTT ADDR
  JP PROMPT               ;JUMP INTO MAIN CODE (FOR REST SEE AFTER MAIN:)

; 'LLIST' BASIC command
;
; Routine at 12707
__LLIST:                  ;PRTFLG=1 FOR REGULAR LIST
  LD A,$01                ;GET NON ZERO VALUE
  LD (PRTFLG),A           ;SAVE IN I/O FLAG (END OF LPT)

; 'LIST' BASIC command
;
; Routine at 12712
__LIST:
  CALL LNUM_RANGE         ;SCAN LINE RANGE
  CALL __LIST_PROC
  JP RESTART
; This entry point is used by the routines at __SAVE and __LOAD.
LNUM_RANGE:
  LD DE,$0000             ;ASSUME START LIST AT ZERO
  DEC HL
  RST CHRGTB
  JR Z,__LIST_1
  CP ','
  CALL NZ,ATOH
IF V10
  LD (TEMP),DE
__LIST_1:
ELSE
__LIST_1:
  LD (TEMP),DE
ENDIF
  PUSH HL
  CALL SRCHLN
  POP HL
  PUSH BC
  DEC HL
  RST CHRGTB
  JR Z,ALL_LIST           ;IF FINISHED, LIST IT ALL
  CP ','
  JP NZ,SN_ERR
  INC HL
  CALL ATOH               ;GET A LINE #. IF NONE, RETURNS ZERO
  JP NZ,SN_ERR
  LD A,D
  OR E
  JR NZ,SNGLIN            ;IF ONLY # THEN DONE.
ALL_LIST:
  LD DE,65535             ;ASSUME MAX END OF RANGE
SNGLIN:
  LD (TMPSOUND),DE
  POP DE
  RET
  
; This entry point is used by the routine at __SAVE.
__LIST_PROC:
  LD A,$01
  LD (PICFLG),A           ;DONT ALLOW ^C TO CHANGE
  EX DE,HL
__LIST_5:
  LD C,(HL)               ; Get LSB of next line       ;[B,C]=THE LINK POINTING TO THE NEXT LINE
  INC HL
  LD B,(HL)               ; Get MSB of next line
  INC HL
  LD A,B                  ;SEE IF END OF CHAIN
  OR C                    ; BC = 0 (End of program)?
  RET Z                   ;LAST LINE, STOP.

  CALL ISCNTC             ; Test for break/pause status
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
  LD E,(HL)               ; Get LSB of line number      INTO [D,E] FOR COMPARISON WITH
  INC HL                  ;                             THE LINE # BEING SEARCHED FOR
  LD D,(HL)               ; Get MSB of line number      WHICH IS IN [H,L]
  PUSH HL
  LD HL,(TMPSOUND)
  RST DCOMPR              ; Compare with line in DE         SEE IF IT MATCHES OR IF WE'VE GONE TOO FAR
  POP HL
  CCF
  RET NC
  LD (DOT),DE             ;SAVE FOR LATER EDIT OR LIST <> AND WE WANT [H,L] ON THE STACK
  INC HL
  PUSH HL                 ; Save address of line start
  EX DE,HL                ; Line number to HL
  CALL LINPRT             ; Output line number in decimal
  LD A,' '                ; Space after line number                      ;PRINT A SPACE AFTER THE LINE #
  POP HL                  ; Restore start of line address
  LD (RETADR),HL
  RST OUTDO
  LD HL,(RETADR)
  LD (RETADR),BC

  DEFB $3E                ; "LD A,n" to Mask the next byte WITH "MVI A,0"

LSTLP2:
  RST OUTDO               ; Output character in A
__LIST_9:
  LD A,(HL)               ; Get next byte in line
  INC HL                  ; To next byte in line
  CP LINCON
  JR NZ,__LIST_10
  LD A,$20
  RST OUTDO
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
  JP P,LSTLP2  ;$322D

  SUB TK_END-1
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
  RST OUTDO
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
  SET 6,(IX+$03)                ; CURSOR - Show
  BIT 0,(IX+$04)				; FKLOCK - Uppercase/Lowercase switch
  SET 4,(IX+$03)
  JR Z,SCR_CO_0
  RES 4,(IX+$03)
SCR_CO_0:
  CALL CONSOLE_RESET
  LD A,$7F

IF V10
  LD HL,CHR_DOTDOT
ELSE
  JP SCR_CO_SUB
ENDIF

; This entry point is used by the routine at SHIFT_STOP.
SCR_CO_1:
  CALL CHR_UPDATE
  LD A,$E6

; CHR$(31) - CLR-HOME
;
; Used by the routines at __INIT and L3362.
CONSOLE_CLS:
  LD (IX+$09),A				; ATTBAK - Background color
  CALL CLR_SCR
; This entry point is used by the routine at L3362.
CONSOLE_HOME:
  LD HL,$0001
  LD (CURPOS),HL
  LD (IX+$01),$01
  LD (IX+$00),$01            ; Screen refresh counter
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
  BIT 0,(IX+$04)				; FKLOCK - Uppercase/Lowercase switch
  JR Z,CONSOLE_CLS_5
  RES 0,(IX+$04)				; FKLOCK - Uppercase/Lowercase switch
  SET 4,(IX+$03)
  JR CONSOLE_CLS_6

CONSOLE_CLS_5:
  SET 0,(IX+$04)				; FKLOCK - Uppercase/Lowercase switch
  RES 4,(IX+$03)
CONSOLE_CLS_6:
  LD (IX+$01),$01
  JR CONSOLE_CLS_8
CONSOLE_CLS_7:
  BIT 0,(IX+$04)				; FKLOCK - Uppercase/Lowercase switch
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
  JR NC,CONSOLE_ACC_MRK
  AND $7F
  JR _CHPUT_1
_CHPUT_0:
  CP ' '
  JR NC,CONSOLE_ACC_MRK
  BIT 7,(IX+$0A)				; EXTENF - Character redefinition flag
  JR NZ,_CHPUT_1
  BIT 7,(IX+$08)
  JR NZ,CONSOLE_ACC_MRK
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
CONSOLE_ACC_MRK:
  POP HL
  LD HL,L33CD
  PUSH HL
  JP GETCHAR_2

; Routine at 13154
L3362:
  JP CONSOLE_NULL           ; CHR$(0)
  JP CONSOLE_NULL           ; CHR$(1)
  JP CONSOLE_BS             ; CHR$(2)
  JP CONSOLE_NEWLINE        ; CHR$(3)
  JP L33CD_16               ; CHR$(4)
  JP L33CD_20               ; CHR$(5)
  JP CONSOLE_SCROLL         ; CHR$(6)
  JP CONSOLE_CRIGHT         ; CHR$(7)
  JP CONSOLE_CLEFT          ; CHR$(8)
  JP CONSOLE_CUP            ; CHR$(9)
  JP CONSOLE_CDOWN          ; CHR$(10)
  JP CONSOLE_NULL           ; CHR$(11)
  JP CONSOLE_HOME           ; CHR$(12)
  JP CONSOLE_NEWLINE        ; CHR$(13)
  JP CONSOLE_BEL            ; CHR$(14)
  JP CONSOLE_RESET          ; CHR$(15)
  JP CONSOLE_DOTDOT         ; CHR$(16) ..
  JP CONSOLE_I_MK           ; CHR$(17) î
  JP CONSOLE_ACC_MRK        ; CHR$(18) é
  JP CONSOLE_U_MK           ; CHR$(19) ù
  JP CONSOLE_ACC_MRK        ; CHR$(20) ï
  JP CONSOLE_ACC_MRK        ; CHR$(21) ç
  JP CONSOLE_ACC_MRK        ; CHR$(22) û
  JP CONSOLE_ACC_MRK        ; CHR$(23) à
  JP CONSOLE_A_MK           ; CHR$(24) â, å
  JP CONSOLE_ACC_MRK        ; CHR$(25) è
  JP CONSOLE_O_MK           ; CHR$(26) ô
  JP CONSOLE_ACC_MRK        ; CHR$(27) ê
  JP CONSOLE_POUND          ; CHR$(28) £
  JP CONSOLE_ACC_MRK        ; CHR$(29) 1/2
  JP CONSOLE_BS_SPC         ; CHR$(30) delete previous chr
  LD A,(IX+$09)				; CHR$(31) ATTBAK - Background color
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
CONSOLE_NEWLINE:
  LD HL,(CURPOS)
  LD A,$01
  CP L
  JR NZ,CONSOLE_NEWLINE_0
  LD A,(PICFLG)
  BIT 2,A
  JR Z,CONSOLE_NEWLINE_0
  CALL SCRADR
  DEC HL
  DEC HL
  LD (HL),$80
  RET

CONSOLE_NEWLINE_0:
  LD L,$01
  LD (CURPOS),HL
; This entry point is used by the routine at L3362.
CONSOLE_CDOWN:
  LD HL,(CURPOS)
  LD A,H
  CP 24
  JR C,CONSOLE_CDOWN_0
  LD A,(PICFLG)
  BIT 7,A
  JR NZ,CONSOLE_CDOWN_1
  CALL SCREEN_UP
  LD A,$18
  CALL CLR_LINE
  JR CONSOLE_CDOWN_1

CONSOLE_CDOWN_0:
  INC H
  LD (CURPOS),HL
CONSOLE_CDOWN_1:
  RET

; This entry point is used by the routine at L3362.
CONSOLE_CUP:
  LD HL,(CURPOS)
  LD A,H
  OR A
  JR NZ,CONSOLE_CUP_0
  LD A,(PICFLG)
  BIT 7,A
  JR NZ,CONSOLE_CUP_RET
  CALL SCREEN_DOWN
  LD A,$00
  CALL CLR_LINE
  JR CONSOLE_CUP_RET

CONSOLE_CUP_0:
  DEC H
  LD (CURPOS),HL

CONSOLE_CUP_RET:
  RET

; This entry point is used by the routine at L3362.
CONSOLE_CLEFT:
  LD HL,(CURPOS)
  LD A,L
  CP $02
  JR C,_CURSOR_UP
  DEC L
CONSOLE_CLEFT_0:
  LD (CURPOS),HL
  RET

_CURSOR_UP:
  LD A,H
  OR A
  RET Z
  CALL CONSOLE_CUP
  LD L,40-1
  JR CONSOLE_CLEFT_0

; This entry point is used by the routine at L3362.
CONSOLE_CRIGHT:
  LD HL,(CURPOS)
  LD A,L
  CP $27
  JR NC,CONSOLE_CRIGHT_1
  INC L
CONSOLE_CRIGHT_0:
  LD (CURPOS),HL
  RET

CONSOLE_CRIGHT_1:
  LD A,H
  CP 24
  RET NC
  CALL CONSOLE_CDOWN
  LD L,$01
  JR CONSOLE_CRIGHT_0


; Backspace
;
; This entry point is used by the routine at L3362.
CONSOLE_BS:
  LD HL,(CURPOS)
  LD A,$01
  CP L
  JP NC,CONSOLE_BS_3
CONSOLE_BS_0:
  PUSH HL
  CALL SCRADR
  POP BC
  LD D,H
  LD E,L
  DEC DE
  DEC DE
  LD A,40
  SUB C
  ADD A,A
  LD C,A
  LD B,$00
CONSOLE_BS_1:
  LDIR
  LD A,(HL)
  CP $84
  DEC HL
  DEC HL
  JR NZ,CONSOLE_BS_5
  INC HL
  INC HL
CONSOLE_BS_2:
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
  JR CONSOLE_BS_1

CONSOLE_BS_3:
  LD A,H
  OR A
  RET Z
  DEC HL
  CALL SCR_GETCHR
  RET NZ


IF V10

  CALL CONSOLE_CUP
  LD L,39
  LD (CURPOS),HL
CONSOLE_BS_4:
  JR CONSOLE_BS_0

ELSE

  JR CONSOLE_BS_2
; This entry point is used by the routine at QINLIN.
CONSOLE_BS_4:
  JP NZ,T_EDIT_4
  LD A,$06
  JP T_EDIT_2

ENDIF

CONSOLE_BS_5:
  LD A,' '
  BIT 7,(IX+$08)
  JR Z,CONSOLE_BS_6
  XOR A
CONSOLE_BS_6:
  LD (HL),A
  CALL CONSOLE_CLEFT
  RET

; This entry point is used by the routine at L3362.
L33CD_16:
  LD HL,(CURPOS)
  PUSH HL
  LD A,40
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
  CALL SCR_GETCHR
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
  CALL SCR_GETCHR
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

IF V10
  JP M,L33CD_25
ELSE
  JP QINLIN_4
ENDIF

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
  LD L,38
  CALL SCRADR
  POP BC
  LD D,H
  LD E,L
  INC DE
  INC DE
  LD A,39
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
SCR_GETCHR:
  CALL SCRADR
  LD A,(HL)
  CP $84
  RET

; This entry point is used by the routine at L3362.
CONSOLE_SCROLL:
  LD HL,(CURPOS)
  LD A,H
  OR A
  JR Z,CONSOLE_SCROLL_0
  LD L,$00
  CALL SCRADR
  LD DE,SCREEN
  OR A
  SBC HL,DE
  LD C,L
  LD B,H
  LD HL,SECOND_SCREEN_ROW
  LDIR
CONSOLE_SCROLL_0:
  LD A,(YCURSO)
  CALL CLR_LINE
  RET

; This entry point is used by the routine at L3362.
CONSOLE_BS_SPC:
  LD A,(YCURSO)
CONSOLE_BS_SPC_0:
  PUSH AF
  CALL CLR_LINE
  POP AF
  INC A
  CP $19
  JR C,CONSOLE_BS_SPC_0
  RET

; This entry point is used by the routine at GETCHAR.
SCREEN_UP:
  LD HL,SECOND_SCREEN_ROW
  LD DE,SCREEN
  LD BC,80*24
  LDIR
  RET

SCREEN_DOWN:
  LD HL,LAST_SCREEN_ROW
  LD DE,SCREEN_END
  LD BC,80*24
  LDDR
  RET

; This entry point is used by the routines at SCR_CO, L3362 and FINLPT.
CONSOLE_RESET:
  LD A,(PICFLG)
  AND $7D
  LD (PICFLG),A
  LD (IX+$0A),$00				; EXTENF - Character redefinition flag
  LD (IX+$08),$00
  LD (IX+$01),$01
  LD (IX+$02),$0A
  RES 7,(IX+$03)
  SET 6,(IX+$03)                ; CURSOR - Show
  RET

; CHR$(14) - BEL
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
IF V10
  DEFB $00,$10,$28,$00,$00,$00,$00,$00,$00,$00
ELSE
  DEFB $00,$10,$38,$7C,$FE,$7C,$38,$10,$00,$00
ENDIF

; Data block at 13822
CHR_DOTDOT:
  DEFB $00,$00,$00,$00,$00,$24,$00,$00,$00,$00

  DEFB $00

; BASIC string handler
;
; THE FOLLOWING ROUTINE COMPARES TWO STRINGS
; ONE WITH DESC IN [D,E] OTHER WITH DESC. IN [FACLO, FACLO+1]
; A=0 IF STRINGS EQUAL
; A=377 IF B,C,D,E .GT. FACLO
; A=1 IF B,C,D,E .LT. FACLO
;
; Used by the routine at CMPLOG.
STRCMP:
  PUSH DE
  CALL GSTRCU              ;FREE UP THE FAC STRING, AND GET THE POINTER TO THE FAC DESCRIPTOR IN [H,L]
  LD A,(HL)                ;SAVE THE LENGTH OF THE FAC STRING IN [A]
  INC HL
  INC HL
  LD C,(HL)                ;SAVE THE POINTER AT THE FAC STRING DATA IN [B,C]
  INC HL
  LD B,(HL)
  POP DE                   ;GET THE STACK STRING POINTER
  PUSH BC                  ;SAVE THE POINTER AT THE FAC STRING DATA
  PUSH AF                  ;SAVE THE FAC STRING LENGTH
  CALL GSTRDE              ;FREE UP THE STACK STRING AND RETURN
                           ;THE POINTER TO THE STACK STRING DESCRIPTOR IN [H,L]
  CALL LOADFP              ;[DE]=LENGTH OF FAC STRING, [B,C]=POINTER AT STACK STRING
  POP AF
  LD D,A
  POP HL                   ;GET BACK 2ND CHARACTER POINTER

; Routine at 13855
CSLOOP:
  LD A,E                   ;BOTH STRINGS ENDED
  OR D                     ;TEST BY OR'ING THE LENGTHS TOGETHER
  RET Z                    ;IF SO, RETURN WITH A ZERO
  LD A,D                   ;GET FACLO STRING LENGTH
  SUB $01                  ;SET CARRY AND MAKE [A]=255 IF [D]=0
  RET C                    ;RETURN IF THAT STRING ENDED
  XOR A                    ;MUST NOT HAVE BEEN ZERO, TEST CASE
  CP E                     ;OF B,C,D,E STRING HAVING ENDED FIRST
  INC A                    ;RETURN WITH A=1
  RET NC                   ;TEST THE CONDITION

;HERE WHEN NEITHER STRING ENDED
  DEC D                    ;DECREMENT BOTH CHARACTER COUNTS
  DEC E
  LD A,(BC)                ;GET CHARACTER FROM B,C,D,E STRING
  INC BC
  CP (HL)                  ;COMPARE WITH FACLO STRING
  INC HL                   ;BUMP POINTERS (INX DOESNT CLOBBER CC'S)
  JR Z,CSLOOP              ;IF BOTH THE SAME, MUST BE MORE TO STRINGS
  CCF                      ;HERE WHEN STRINGS DIFFER
  JP SIGNS                 ;SET [A] ACCORDING TO CARRY

; 'STR$' BASIC function
;
; THE STR$ FUNCTION TAKES A NUMBER AND GIVES
; A STRING WITH THE CHARACTERS THE OUTPUT OF THE NUMBER
; WOULD HAVE GIVEN
;
; Routine at 13878
__STR_S:
  CALL TSTNUM                                               ;IS A NUMERIC
  CALL NUMASC             ; Turn number into text           ;DO ITS OUTPUT
; This entry point could be used by __OCT_S and __HEX_S.
;__STR_S_0:
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
; Routine at 13894
; Used by the routine at CRESTR.
STRCPY:
  LD A,(HL)               ; Get string length                    ;GET LENGTH
  INC HL                                                         ;MOVE UP TO THE POINTER
  INC HL
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
  RET

; Routine at 13915
;
; Used by the routine at __CHR_S.
STRIN1:
  LD A,$01                ;MAKE ONE CHAR STRING (CHR$, INKEY$)

; Make temporary string
;GET SOME STRING SPACE ([A] CHARS)
;
; Used by the routine at CONCAT.
MKTMST:
  CALL TESTR              ; See if enough string space

; Create temporary string entry
;
; Used by the routines at STRCPY, DTSTR and __LEFT_S.
CRTMST:
  LD HL,DSCTMP            ; Temporary string          ;GET DESC. TEMP
  PUSH HL                 ; Save it                   ;SAVE DESC. POINTER
  LD (HL),A               ; Save length of string     ;SAVE CHARACTER COUNT
  INC HL

; a.k.a. SVSTAD
; This entry point is used by the routine at DOFN.
PUTDEI:
  INC HL                                              ;STORE [D,E]=POINTER TO FREE SPACE
  LD (HL),E               ; Save LSB of address
  INC HL
  LD (HL),D               ; Save MSB of address
  POP HL                  ; Restore pointer           ;AND RESTORE [H,L] AS THE DESCRIPTOR POINTER
  RET

; Create String
;
; Used by the routines at __PRINT, __STR_S and PRS.
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
;; This entry point is used by the routine at __LINE.
;QTSTR_0:
  LD D,B                  ; Quote to D

; Create String, termination char in D
;
; Used by the routine at ITMSEP.
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
  CALL Z,_CHRGTB          ;SKIP OVER THE QUOTE              ; Yes - Get next character
;------ 
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
; Used by the routines at CONCAT, TOPOOL and __LEFT_S.
TSTOPL:
  LD DE,DSCTMP            ; Temporary string                     ;[D,E] POINT AT RESULT DESCRIPTOR
  LD HL,(TEMPPT)          ; Temporary string pool pointer        ;[H,L]=POINTER TO FIRST FREE TEMP
  LD (FACCU),HL           ; Save address of string ptr           ;POINTER AT WHERE RESULT DESCRIPTOR WILL BE
  LD A,$01
  LD (VALTYP),A           ; Set type to string                   ;FLAG THIS AS A STRING
  CALL VMOVE              ; Move string to pool                  ;AND MOVE THE VALUE INTO A TEMPORARY
  RST DCOMPR              ; Out of string pool?                  ;DSCTMP IS JUST BEYOND THE TEMPS
                                                                 ;AND IF TEMPPT POINTS AT IT THERE ARE NO FREE TEMPS
  LD (TEMPPT),HL          ; Save new pointer                     ;SAVE NEW TEMPORARY POINTER
  POP HL                  ; Restore code string address          ;GET THE TEXT POINTER
  LD A,(HL)               ; Get next code byte                   ;GET CURRENT CHARACTER INTO [A]
  RET NZ                  ; Return if pool OK
  LD DE,$001E             ; Err $1E - "String formula too complex"  ; "STRING TEMPORARY" ERROR
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
; Used by the routines at _ASCTFP, INIT, __LOAD, __CSAVE, CLOAD_END,
; PRINT_FNAME_MSG, ERROR, READY, NEXITM, INPBIN, SCCPTR and SHIFT_STOP.
PRS:
  CALL CRTST              ;GET A STRING LITERAL

; Print string at HL
;
; Used by the routines at __PRINT and __INPUT.
PRS1:
  CALL GSTRCU             ;RETURN TEMP POINTER BY FACLO
  CALL LOADFP             ;[E]=LENGTH [B,C]=POINTER AT DATA
  INC E                   ;INCREMENT AND DECREMENT EARLY TO CHECK FOR NULL STRING
PRS1_0:
  DEC E                   ;DECREMENT THE LENGTH
  RET Z                   ;ALL DONE
  LD A,(BC)               ;GET CHARACTER TO PRINT
  RST OUTDO
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
; Used by the routines at STRCPY, MKTMST and __LEFT_S.
TESTR:
  OR A                    ; MUST BE NON ZERO. SIGNAL NO GARBAG YET
  DEFB $0E                ; "LD C,n" to Mask the next byte

; GRBDON: Garbage Collection Done
GRBDON:
  POP AF                                                      ;IN CASE COLLECTED WHAT WAS LENGTH?
  PUSH AF                 ; Save status                       ;SAVE IT BACK
  LD HL,(STKTOP)          ; Bottom of string space in use
  EX DE,HL                ; To DE                             ;IN [D,E]
  LD HL,(FRETOP)          ; Bottom of string area             ;GET TOP OF FREE SPACE IN [H,L]
  CPL                     ; Negate length (Top down)          ;-# OF CHARS
  LD C,A                  ; -Length to BC                     ;IN [B,C]
  LD B,$FF                ; BC = -ve length of string
  ADD HL,BC               ; Add to bottom of space in use     ;SUBTRACT FROM TOP OF FREE
  INC HL                  ; Plus one for 2's complement
  RST DCOMPR              ; Below string RAM area?            ;COMPARE THE TWO
  JR C,TESTOS             ; Tidy up if not done else err      ;NOT ENOUGH ROOM FOR STRING, OFFAL TIME
  LD (FRETOP),HL          ; Save new bottom of area           ;SAVE NEW BOTTOM OF MEMORY
  INC HL                  ; Point to first byte of string     ;MOVE BACK TO POINT TO STRING
  EX DE,HL                ; Address to DE                     ;RETURN WITH POINTER IN [D,E]
;POPAF:
  POP AF                  ; Throw away status push            ;GET CHARACTER COUNT
  RET                                                         ;RETURN FROM GETSPA

; Garbage Collection: Tidy up if not done else err
; a.k.a. GARBAG
;
; Routine at 14038
; Used by the routine at TESTR.
TESTOS:
  POP AF                  ; Garbage collect been done?           ;HAVE WE COLLECTED BEFORE?
  LD DE,$001A             ; Err $1A - "Out of string space"      ;GET READY FOR OUT OF STRING SPACE ERROR
  JP Z,ERROR              ; Yes - Not enough string apace        ;GO TELL USER HE LOST
  CP A                    ; Flag garbage collect done            ;SET ZERO FLAG TO SAY WEVE GARBAGED
  PUSH AF                 ; Save status                          ;SAVE FLAG BACK ON STACK
  LD BC,GRBDON            ; Garbage collection done              ;PLACE FOR GARBAG TO RETURN TO.
  PUSH BC                 ; Save for RETurn                      ;SAVE ON STACK

; Garbage collection
;
; Used by the routine at __FRE.
GARBGE:
  LD HL,(MEMSIZ)          ; Get end of RAM pointer               ;START FROM TOP DOWN
; This entry point is used by the routine at ARYSTR.
GARBLP:
  LD (FRETOP),HL          ; Reset string pointer                 ;LIKE SO
  LD HL,$0000                                                    ;GET DOUBLE ZERO
  PUSH HL                 ; Flag no string found                 ;SAY DIDNT SEE VARS THIS PASS
  LD HL,(STREND)          ; Get bottom of string space           ;FORCE DVARS TO IGNORE STRINGS IN THE PROGRAM TEXT (LITERALS, DATA)
  PUSH HL                 ; Save bottom of string space          ;FORCE FIND HIGH ADDRESS
  LD HL,TEMPST            ; Temporary string pool                ;GET START OF STRING TEMPS

TVAR:
  LD DE,(TEMPPT)          ;SEE IF DONE     ; Temporary string pool pointer
  RST DCOMPR              ;TEST            ; Temporary string pool done?

  ;CANNOT RUN IN RAM SINCE IT STORES TO MESS UP BASIC
  LD BC,TVAR              ;FORCE JUMP TO TVAR                       ; Loop until string pool done
  JP NZ,STPOOL            ;DO TEMP VAR GARBAGE COLLECT              ; No - See if in string area
  LD HL,(VARTAB)          ;SETUP ITERATION FOR PARAMETER BLOCKS     ; Start of simple variables
SMPVAR:
  LD DE,(ARYTAB)          ;GET STOPPING LOCATION                    ; End of simple variables
  RST DCOMPR              ;SEE IF AT END OF SIMPS                   ; All simple strings done?
  JR Z,ARRLP                                                        ; Yes - Do string arrays
  INC HL                  ;BUMP POINTER
  LD A,(HL)               ;GET VALTYP                               ; Get type of variable
  INC HL
  OR A                    ;(useless)?
  CALL STRADD             ;COLLECT IT                               ; Add if string in string area
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

;
; HERE WHEN MADE ONE COMPLETE PASS THRU STRING VARS
;
; All string arrays done, now move string
;
; This entry point is used by the routine at GARBGE.
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
; Used by the routine at EVAL3.
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
  LD DE,$001C             ; Err $1C - "String too long"        ;SEE IF RESULT .LT. 256
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
  INC HL
  LD C,(HL)               ; Get LSB of string address          ;[B,C]=POINTER AT STRING DATA
  INC HL
  LD B,(HL)               ; Get MSB of string address
  LD L,A                  ; Length to L                        ;[L]=STRING LENGTH

; Move string in BC, (len in L) to string area
; a.k.a. MOVSTR
;
; Used by the routines at STRCPY and __LEFT_S.
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
; Used by the routine at GETLEN.
GETSTR:
  CALL TSTSTR             ; Make sure it's a string

; Get string pointed by FPREG
;
; Used by the routines at __PLAY, STRCMP, __STR_S, PRS1 and __FRE.
; a.k.a. FREFAC
GSTRCU:
  LD HL,(FACCU)           ; Get current string

; Get string pointed by HL
;
; Used by the routine at CONCAT.
GSTRHL:
  EX DE,HL                ; Save DE                            ;FREE UP THE TEMP IN THE FACLO

; Get string pointed by DE
;
; Used by the routines at STRCMP, CONCAT and __LEFT_S.
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
  RST DCOMPR              ; Last one in string area?
  JR NZ,POPHL             ; No - Return                        ;NO SO DON'T ADD
  LD B,A                  ; Clear B (A=0)                      ;MAKE [B]=0
  ADD HL,BC               ; Remove string from str' area       ;ADD
  LD (FRETOP),HL          ; Save new bottom of str' area       ;AND UPDATE FRETOP
POPHL:
  POP HL                  ; Restore string                     ;GET POINTER AT CURRENT DESCRIPTOR
  RET


; Get temporary string pool top (a.k.a BAKTMP - Back to last tmp-str entry)
;
; Used by the routines at CRESTR and GSTRDE.
FRETMS:
  LD HL,(TEMPPT)          ; Back                               ;GET TEMP POINTER
  DEC HL                  ; Get MSB of address                 ;LOOK AT WHAT IS IN THE LAST TEM
  LD B,(HL)               ; Back                               ;[B,C]=POINTER AT STRING
  DEC HL                  ; Get LSB of address                 ;DECREMENT TEMPPT BY STRSIZ
  LD C,(HL)               ; Back
  DEC HL                  ; Back
  DEC HL                  ; Back
  RST DCOMPR              ; String last in string pool?        ;SEE IF [D,E] POINT AT THE LAST 
  RET NZ                  ; Yes - Leave it                     ;RETURN NOW IF NOW FREEING DONE
  LD (TEMPPT),HL          ; Save new string pool top           ;UPDATE THE TEMP POINTER SINCE ITS BEEN DECREMENTED BY 4
  RET

; 'LEN' BASIC function
;
; THE FUNCTION LEN($) RETURNS THE LENGTH OF THE
; STRING PASSED AS AN ARGUMENT
;
; Routine at 14331
__LEN:
  LD BC,PASSA             ; To return integer A                ;CALL SNGFLT WHEN DONE
  PUSH BC                 ; Save address                       ;LIKE SO

; Routine at 14335
;
; Used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR             ; Get string and its length          ;FREE UP TEMP POINTED TO BY FACLO
  XOR A                                                        ;FORCE NUMERIC FLAG
  LD D,A                  ; Clear D                            ;SET HIGH OF [D,E] TO ZERO FOR VAL
  LD (VALTYP),A
  LD A,(HL)               ; Get length of string
  OR A                    ; Set status flags                   ;SET CONDITION CODES ON LENGTH
  RET                                                          ;RETURN


; 'ASC' BASIC function
;
; THE FOLLOWING IS THE ASC($) FUNCTION. IT RETURNS AN INTEGER
; WHICH IS THE DECIMAL ASCII EQUIVALENT
;
; Routine at 14346
__ASC:
  LD BC,PASSA             ; To return integer A                ;WHERE TO GO WHEN DONE
  PUSH BC                 ; Save address                       ;SAVE RETURN ADDR ON STACK

; This entry point is used by the routine at L1CC0.
__ASC_0:
  CALL GETLEN             ; Get length of string               ;SET UP ORIGINAL STR
  JP Z,FC_ERR             ; Null string - Error                ;NULL STR, BAD ARG.
  INC HL
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
; Routine at 14363
__CHR_S:
  CALL STRIN1             ; Make One character temporary string   ;GET STRING IN DSCTMP
  CALL CONINT             ; Make it integer A                     ;GET INTEGER IN RANGE
;SETSTR:
  LD HL,(TMPSTR)          ; Get address of string              ;GET ADDR OF STR
  LD (HL),E               ; Save character                     ;SAVE ASCII BYTE

; Save in string pool
;
; Used by the routines at __CHR_S, __STR_S and __SPACE_S.
TOPOOL:
  POP BC                  ; Clean up stack                     ;RETURN TO HIGHER LEVEL & SKIP THE CHKNUM CALL.
  JP TSTOPL               ; Temporary string to pool           ;GO CALL PUTNEW


; 'LEFT$' BASIC function
;
; THE FOLLOWING IS THE LEFT$($,#) FUNCTION.
; IT TAKES THE LEFTMOST # CHARS OF THE STR.
; IF # IS .GT. THAN THE LEN OF THE STR, IT RETURNS THE WHOLE STR.
;
; Routine at 14377
__LEFT_S:
  CALL LFRGNM             ; Get number and ending ")"            ;TEST THE PARAMETERS
  XOR A                   ; Start at first byte in string        ;LEFT NEVER CHANGES STRING POINTER

; This entry point is used by the routine at __RIGHT_S.
RIGHT1:
  EX (SP),HL              ; Save code string,Get string          ;SAVE TEXT POINTER
  LD C,A                  ; Starting position in string          ;OFFSET NOW IN [C]
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
  INC HL
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
; Routine at 14424
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
; Routine at 14433
__MID_S:
  EX DE,HL                ; Get code string address              ;PUT THE TEXT POINTER IN [H,L]
  LD A,(HL)               ; Get next byte "," or ")"             ;GET THE FIRST CHARACTER
  CALL MIDNUM             ; Get number supplied                  ;GET OFFSET OFF STACK AND MAKE
  INC B                   ; Is it character zero?
  DEC B                                                          ;SEE IF EQUAL TO ZERO
  JP Z,FC_ERR             ; Yes - Error                          ;IT MUST NOT BE 0 SURE DOES NOT = 0.
  PUSH BC                 ; Save starting position               ;PUT OFFSET ON TO THE STACK
  LD E,255                ; All of string
  CP ')'                  ; Any length given?                    ;DUPLICATE OF CODE CONDITIONED OUT BELOW
  JP Z,RSTSTR             ; No - Rest of string

  RST SYNCHR              ; Make sure "," follows
  DEFB ','

  CALL GETINT             ; Get integer 0-255

RSTSTR:
  RST SYNCHR              ; Make sure ")" follows
  DEFB ')'

  POP AF                  ; Restore starting position
  EX (SP),HL              ; Get string,save code string          ;SAVE TEXT POINTER, GET DESC.
  LD BC,MID1              ; Continuation of MID$ routine         ;WHERE TO RETURN TO.      ;$382F
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
; Routine at 14477
__VAL:
  CALL GETLEN             ; Get length of string                 ;DO SETUP, SET RESULT=REAL
  JP Z,ZERO               ; Result zero                          ;MAKE SURE TYPE SET UP OK IN EXTENDED
  LD E,A                  ; Save length                          ;GET LENGTH OF STR
  INC HL                                                         ;TO HANDLE THE FACT THE IF
  INC HL
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
  RST CHRGTB                                                    ;VAL(" -3")=-3
  CALL H_ASCTFP           ; Convert ASCII string to FP           ;IN EXTENDED, GET ALL THE PRECISION WE CAN
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
;
; Used by the routines at __LEFT_S and __RIGHT_S.
LFRGNM:
  EX DE,HL                ; Code string address to HL            ;PUT THE TEXT POINTER IN [H,L]

  RST SYNCHR              ; Make sure ")" follows                ;PARAM LIST SHOULD END
  DEFB ')'

; Get numeric argument for MID$
; USED BY MID$ FOR PARAMETER CHECKING AND SETUP
;
; Routine at 14508
; Used by the routine at __MID_S.
MIDNUM:
  POP BC                                                         ;GET RETURN ADDR OFF STACK
  POP DE                  ; Get number supplied                  ;GET LENGTH OF ARG OFF STACK
  PUSH BC                 ; Re-save return address               ;SAVE RETURN ADDR BACK ON
  LD B,E                  ; Number to B                          ;SAVE INIT LENGTH
  RET

; 'FRE' BASIC function
;
; Routine at 14513
__FRE:
  LD HL,(STREND)          ; Start of free memory
  EX DE,HL                ; To DE
  LD HL,0                 ; End of free memory
  ADD HL,SP               ; Current stack value
  LD A,(VALTYP)           ; Dummy argument type
  OR A
  JP Z,FRENUM
  CALL GSTRCU             ; Current string to pool               ;FREE UP ARGUMENT AND SETUP TO GIVE FREE STRING SPACE
  CALL GARBGE             ; Garbage collection                   ;DO GARBAGE COLLECTION
  LD DE,(STKTOP)          ; Bottom of string space in use
  LD HL,(FRETOP)          ; Current bottom of string area        ;TOP OF FREE AREA
  JP FRENUM                                                      ;RETURN [H,L]-[D,E]

; a.k.a. DIMCON, Return from 'DIM' command
DIMRET:
  DEC HL                  ; DEC 'cos GETCHR INCs        ;SEE IF COMMA ENDED THIS VARIABLE
  RST CHRGTB              ; Get next character
  RET Z                   ; End of DIM statement        ;IF TERMINATOR, GOOD BYE

  RST SYNCHR              ; Make sure "," follows       ;MUST BE COMMA
  DEFB ','


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

; Routine at 14549
__DIM:
  LD BC,DIMRET            ; Return to "DIMRET"    ;PLACE TO COME BACK TO
  PUSH BC                 ; Save on stack

  DEFB $F6                ; "OR n" to Mask 'XOR A' (Flag "Create" variable):   NON ZERO THING MUST TURN THE MSB ON

; Get variable address to DE
;
; Used by the routines at L1CC0, __LET, GTVLUS, EVAL_VARIABLE, __DEF, __CONT
; and __NEXT.
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
  LD (VALTYP),A           ;ZERO NAMCNT
  RST CHRGTB
  JR C,ISSEC              ; JP if it WAS NUMERIC              ;YES, WAS NUMERIC
  CALL ISLETTER_A         ; See if a letter
  JR C,NOSEC              ; ALLOW ALPHABETICS
ISSEC:
  LD B,A                  ; Resave second byte on name
ENDNAM:
  RST CHRGTB              ; Get next character
  JR C,ENDNAM             ; Numeric - Get another
  CALL ISLETTER_A         ; See if a letter
  JR NC,ENDNAM            ; Letter - Get another
NOSEC:
  SUB '$'                 ; String variable?                  ;CHECK FOR STRING
  JR NZ,NOTSTR            ; No - Numeric variable
  INC A                   ; A = 1 (string type)
  LD (VALTYP),A           ; Set type to string
  RRCA                    ; A = 80H , Flag for string
  ADD A,B                 ; 2nd byte of name has bit 7 on
  LD B,A                  ; Resave second byte on name
  RST CHRGTB              ; Get next character
NOTSTR:
  LD A,(SUBFLG)           ; Array name needed ?
  DEC A
  JP Z,ARLDSV             ; Yes - Get array name
  JP P,NSCFOR             ; No array with "FOR" or "FN"
  LD A,(HL)               ; Get byte again
  SUB '('                 ; Subscripted variable?
  JP Z,SBSCPT             ; Yes - Sort out subscript
NSCFOR:
  XOR A                   ; Simple variable
  LD (SUBFLG),A           ; Clear "FOR" flag
  PUSH HL                 ; Save code string address
  LD D,B                  ; DE = Variable name to find
  LD E,C
  LD HL,(PRMNAM)          ; FN argument name
  RST DCOMPR              ; Is it the FN argument?
  LD DE,PRMVAL            ; Point to argument value
  JP Z,POPHLRT            ; Yes - Return FN argument value
  LD HL,(ARYTAB)          ; End of variables
  EX DE,HL                ; Address of end of search
  LD HL,(VARTAB)          ; Start of variables address
FNDVAR:
  RST DCOMPR              ; End of variable list table?
  JP Z,SMKVAR             ; Yes - Called from EVAL?
  LD A,C                  ; Get second byte of name
  SUB (HL)                ; Compare with name in list
  INC HL                  ; Move on to first byte
  JP NZ,FNTHR             ; Different - Find another
  LD A,B                  ; Get first byte of name
  SUB (HL)                ; Compare with name in list
FNTHR:
  INC HL                  ; Move on to LSB of value
  JP Z,NTFPRT             ; Found - Return address
  INC HL                  ; <- Skip
  INC HL                  ; <- over
  INC HL                  ; <- F.P.
  INC HL                  ; <- value
  JP FNDVAR               ; Keep looking

; a.k.a. CFEVAL
SMKVAR:
  POP HL                  ;[H,L]= TEXT POINTER
  EX (SP),HL              ;[H,L]= RETURN ADDRESS
  PUSH DE                 ;SAVE CURRENT VARIABLE TABLE POSITION
  LD DE,VARRET            ;ARE WE RETURNING TO VARPTR?
  RST DCOMPR              ;COMPARE
  POP DE                  ;RESTORE THE POSITION
  JP Z,FINZER             ;MAKE FAC ZERO (ALL TYPES) AND SKIP RETURN
  EX (SP),HL              ;PUT RETURN ADDRESS BACK
  PUSH HL                 ;PUT THE TEXT POINTER BACK
  PUSH BC                 ;SAVE THE LOOKS
  LD BC,$0006                   ;GET LENGTH OF SYMBOL TABLE ENTRY
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
  RST DCOMPR              ;ZERO BACKWARDS TO [D,E] WHICH
  JR NZ,ZEROER            ;POINTS TO THE START OF THE VARIABLE
  POP DE                  ;[E]=VALTYP
  LD (HL),E               ;PUT DESCRIPTION
  INC HL
  LD (HL),D               ;OF THIS VARIABLE INTO MEMORY
  INC HL
NTFPRT:
  EX DE,HL
  POP HL                  ;RESTORE THE TEXT POINTER
  RET


;
; MAKE ALL TYPES ZERO AND SKIP RETURN
;
FINZER:
  LD (FPEXP),A            ;MAKE SINGLES (AND DOUBLES, WHERE SUPPORTED) ZERO
  LD HL,NULL_STRING       ;MAKE IT A NULL STRING BY
  LD (FACCU),HL           ;POINTING AT A ZERO
;POPHR2:
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
;
; Used by the routine at GETVAR.
SBSCPT:
  PUSH HL                 ; Save code string address          ;SAVE DIMFLG AND VALTYP FOR RECURSION
  LD HL,(DIMFLG)          ; Type
  EX (SP),HL              ; Save and get code string          ;TEXT POINTER BACK INTO [H,L]
  LD D,A                  ; Zero number of dimensions         ;SET # DIMENSIONS =0
SCPTLP:
  PUSH DE                 ; Save number of dimensions         ;SAVE NUMBER OF DIMENSIONS
  PUSH BC                 ; Save array name                   ;SAVE LOOKS
  CALL _CHRGTB_2
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
  JP Z,SCPTLP             ;IF SO, READ MORE                                       ; Yes - More subscripts

; Routine at 14748
DOCHRT:
  RST SYNCHR
  DEFB ')'

; Routine at 14750
SUBSOK:
  LD (NXTOPR),HL          ;SAVE THE TEXT POINTER
  POP HL                  ;[H,L]= VALTYP & DIMFLG
  LD (DIMFLG),HL          ;SAVE VALTYP AND DIMFLG
  LD E,$00                ;WHEN [D,E] IS POPED INTO PSW, WE DON'T WANT THE ZERO FLAG TO BE SET,
                          ;SO "ERASE" WILL HAVE A UNIQUE CONDITION
  PUSH DE                 ;SAVE NUMBER OF DIMENSIONS
  
  DEFB $11                ; "LD DE,nn", OVER THE NEXT TWO BYTES

; a.k.a. ERSFIN
;
; Used by the routine at GETVAR.
ARLDSV:
  PUSH HL                 ; Save code string address         ;SAVE THE TEXT POINTER
  PUSH AF                 ; A = 00 , Flags set = Z,N         ;SAVE A DUMMY NUMBER OF DIMENSIONS WITH THE ZERO FLAG SET
;
; AT THIS POINT [B,C]=LOOKS. THE TEXT POINTER IS IN TEMP2.
; THE INDICES ARE ALL ON THE STACK, FOLLOWED BY THE NUMBER OF DIMENSIONS.
;
  LD HL,(ARYTAB)          ; Start of arrays                  ;[H,L]=PLACE TO START THE SEARCH

  DEFB $3E                ; "LD A,n" AROUND THE NEXT BYTE

; Routine at 14767
FNDARY:
  ADD HL,DE               ; Move to next array start                    ;SKIP OVER THIS ARRAY SINCE IT'S NOT THE ONE
  LD DE,(STREND)          ; End of arrays                               ;GET THE PLACE TO STOP INTO [H,L]
  RST DCOMPR              ; End of arrays found?                        ;STOPPING TIME?
  JR Z,CREARY             ; Yes - Create array                          ;YES, COULDN'T FIND THIS ARRAY
  LD A,(HL)               ; Get byte of name                            ;GET FIRST CHARACTER
  INC HL                  ; Move on
  CP C                    ; Compare with name given (second byte)       ;SEE IF IT MATCHES
  JR NZ,NXTARY            ; Different - Find next array                 ;NO, SKIP THIS VAR
  LD A,(HL)               ; Get first byte of name                      ;GET SECOND CHARACTER
  CP B                    ; Compare with name given (first byte)        ;ANOTHER MATCH?
NXTARY:
  INC HL                  ; Move on                                     ;POINT TO SIZE ENTRY
  LD E,(HL)               ; Get LSB of next array address               ; GET VAR NAME LENGTH IN [E]
  INC HL                                                                ; ADD ONE TO GET CORRECT LENGTH
  LD D,(HL)               ; Get MSB of next array address               ; HIGH BYTE OF ZERO
  INC HL                                                                ; ADD OFFSET
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

; entry for '?BS ERROR'
; ERR $10 - "Subscript out of range"
;
; Used by the routines at MLDEBC and INLPNM.
BS_ERR:
  LD DE,16
  JP ERROR

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
; This entry point is used by the routine at FNDARY.
CREARY:
  LD DE,4                 ; 4 Bytes per entry
  POP AF                  ; Array to save or 0 dim'ns?
  JP Z,FC_ERR             ; Yes - ?FC Error
  LD (HL),C               ; Save second byte of name
  INC HL                  
  LD (HL),B               ; Save first byte of name
  INC HL                  
  LD C,A                  ; Number of dimensions to C
  CALL CHKSTK             ; Check if enough memory
  INC HL                  ; Point to number of dimensions
  INC HL                  
  LD (TEMP3),HL           ; Save address of pointer
  LD (HL),C               ; Set number of dimensions
  INC HL
  LD A,(DIMFLG)           ; Locate of Create?           ;CALLED BY DIMENSION?
  RLA                     ; Carry set = Create          ;SET CARRY IF SO
  LD A,C                  ; Get number of dimensions    ;[A]=NUMBER OF DIMENSIONS
CRARLP:
  LD BC,10+1              ; Default dimension size 10
  JR NC,DEFSIZ            ; Locate - Set default size        ;DEFAULT DIMENSIONS TO TEN
  POP BC                  ; Get specified dimension size     ;POP OFF AN INDICE INTO [B,C]
  INC BC                  ; Include zero element             ;ADD ONE TO IT FOR THE ZERO ENTRY
DEFSIZ:
  LD (HL),C               ; Save LSB of dimension size       ;PUT THE MAXIMUM DOWN
  PUSH AF                 ; Save num' of dim'ns an status    ;SAVE THE NUMBER OF DIMENSIONS AND DIMFLG (CARRY)
  INC HL
  LD (HL),B               ; Save MSB of dimension size
  INC HL
  PUSH HL
  CALL MLDEBC             ; Multiply DE by BC to find amount of mem needed   ;MULTIPLY [B,C]=NEWMAX BY CURTOL=[D,E]
  EX DE,HL
  POP HL
  POP AF                  ; Restore number of dimensions      ;GET THE NUMBER OF DIMENSIONS AND DIMFLG (CARRY) BACK
  DEC A                   ; Count them                        ;DECREMENT THE NUMBER OF DIMENSIONS LEFT
  JR NZ,CRARLP
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
  RST DCOMPR              ; All elements zeroed?             ;BACK AT THE BEGINNING?
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
; This entry point is used by the routine at FNDARY.
FINDEL:
  LD B,A                  ; Find array element              ;[B,C]=CURTOL=ZERO
  LD C,A
  LD A,(HL)               ; Number of dimensions            ;[A]=NUMBER OF DIMENSIONS
  INC HL                                                    ;POINT PAST THE NUMBER OF DIMENSIONS
  DEFB $16                ; "LD D,n" to skip "POP HL"       ;"MVI D," AROUND THE NEXT BYTE

; Routine at 14905
INLPNM:
  POP HL                  ; Address of next dim' size       ;[H,L]= POINTER INTO VARIABLE ENTRY
  LD E,(HL)               ; Get LSB of dim'n size           ;[D,E]=MAXIMUM FOR THE CURRENT INDICE
  INC HL
  LD D,(HL)               ; Get MSB of dim'n size
  INC HL
  EX (SP),HL              ; Save address - Get index        ;[H,L]=CURRENT INDICE, POINTER INTO THE VARIABLE GOES ON THE STACK
  PUSH AF                 ; Save number of dim'ns           ;SAVE THE NUMBER OF DIMENSIONS
  RST DCOMPR             ; Dimension too large?            ;SEE IF THE CURRENT INDICE IS TOO BIG
  JP NC,BS_ERR            ; Yes - ?BS Error                 ;IF SO "BAD SUBSCRIPT" ERROR
  PUSH HL
  CALL MLDEBC             ; Multiply previous by size       ;CURTOL=CURTOL*CURRENT MAXIMUM
  POP DE
  ADD HL,DE               ; Add index to pointer            ;ADD THE INDICE TO CURTOL
  POP AF                  ; Number of dimensions            ;GET THE NUMBER OF DIMENSIONS IN [A]
  DEC A                   ; Count them                      ;SEE IF ALL THE INDICES HAVE BEEN PROCESSED
  LD B,H                  ; MSB of pointer                  ;[B,C]=CURTOL IN CASE WE LOOP BACK
  LD C,L                  ; LSB of pointer
  JR NZ,INLPNM            ; More - Keep going               ;PROCESS THE REST OF THE INDICES
  ADD HL,HL               ;NOW MULTIPLIED BY FOUR
  ADD HL,HL               ;BY EIGHT FOR DOUBLES
  POP BC                  ; Start of array                  ;POP OFF THE ADDRESS OF WHERE THE VALUES BEGIN
  ADD HL,BC               ; Point to element                ;ADD IT ONTO CURTOL TO GET THE PLACE THE VALUE IS STORED
  EX DE,HL                ; Address of element to DE        ;RETURN THE POINTER IN [D,E]

; a.k.a. FINNOW
; This entry point is used by the routine at BS_ERR.
ENDDIM:
  LD HL,(NXTOPR)          ; Got code string address          ;REGET THE TEXT POINTER
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
  LD B,8
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
TAPIN:
  LD A,(LOWLIM)			; Minimal length of startbit
  LD D,A
TAPIN_0:
  CALL ISCNTC_0
  RET C
  IN A,($AF)
  RLCA
  JR NC,TAPIN_0
TAPIN_1:
  CALL ISCNTC_0
  RET C
  IN A,($AF)
  RLCA
  JR C,TAPIN_1
  LD E,$00
  CALL TAPIN_PERIOD
TAPIN_2:
  LD B,C
  CALL TAPIN_PERIOD
  RET C
  LD A,B
  ADD A,C
  JR C,TAPIN_2
  CP D
  JR C,TAPIN_2
  LD L,$08              ; 8 bits
TAPIN_3:
  CALL _TAPIN_STARTBIT
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
  JP NZ,TAPIN_3
  CALL ISCNTC_0
  LD A,D
  RET

_TAPIN_STARTBIT:
  LD A,(WINWID)
  LD B,A
  LD C,$00
_TAPIN_STARTBIT_0:
  IN A,($AF)
  XOR E
  JP P,_TAPIN_STARTBIT_1
  LD A,E
  CPL
  LD E,A
  INC C
  DJNZ _TAPIN_STARTBIT_0
  LD A,C
  RET
_TAPIN_STARTBIT_1:
  NOP
  NOP
  NOP
  NOP
  DJNZ _TAPIN_STARTBIT_0
  LD A,C
  RET

TAPIN_PERIOD:
  CALL ISCNTC_0
  RET C
TAPIN_PERIOD_0:
  LD C,$00
TAPIN_PERIOD_1:
  INC C
  JR Z,TAPIN_PERIOD_2
  IN A,($AF)
  XOR E
  JP P,TAPIN_PERIOD_1
  LD A,E
  CPL
  LD E,A
  RET

TAPIN_PERIOD_2:
  DEC C
  RET

INLPNM_37:
  CALL ISCNTC_0
  RET C
  IN A,($AF)
  RLCA
  JR C,INLPNM_37
  LD E,$00
  CALL TAPIN_PERIOD_0
  JP TAPIN_PERIOD_1

;
;	OUTDO (either CALL or RST) prints char in [A] no registers affected
;		to either terminal or disk file or printer depending
;		flags:
;			PRTFLG if non-zero print to printer
;			((( PTRFIL if non-zero print to disk file pointed to by PTRFIL )))
;

; This entry point is used by the routine at CHRGTB.
_OUTDO:
  CALL OUTHK
  PUSH AF
  LD A,(PRTFLG)         ;SEE IF WE WANT TO TALK TO LPT
  OR A                  ;TEST BITS
  JR Z,CHPUT            ;IF ZERO THEN NOT
  DEC A
  JR Z,OUTC_TABEXP
  POP AF
  JP L1CC0_18

OUTC_TABEXP:
  LD A,(RAWPRT)
  CP $FF
  JR Z,_OUTPRT
  POP AF
  PUSH AF
  CP $09                ;TAB
  JR NZ,OUTC            ;NO
TABEXP_LOOP:
  LD A,$20
  RST OUTDO
  LD A,(LPTPOS)
  AND $07               ;AT TAB STOP?
  JR NZ,TABEXP_LOOP     ;GO BACK IF MORE TO PRINT
  POP AF                ;POP OFF CHAR
  RET                   ;RETURN

; Routine at 15354
;
; Used by the routine at INLPNM.
OUTC:
  SUB $0D               ;IF FUNNY CONTROL CHAR, (LF) DO NOTHING
  JR Z,ZERLP1
  JR C,_OUTPRT          ;JUST PRINT CHAR
  CP $13
  JR C,_OUTPRT          ;JUST PRINT CHAR
  LD A,(LPTPOS)         ;GET POSIT
  CP LPTSIZ
  CALL Z,OUTDO_CRLF_0
  INC A
ZERLP1:
  LD (LPTPOS),A
; This entry point is used by the routine at INLPNM.
_OUTPRT:
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
CHPUT:
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

; This entry point is used by the routines at OUTC and FINLPT.
OUTDO_CRLF_0:
  LD A,$0D
  RST OUTDO
  LD A,$0A
  RST OUTDO
  XOR A
  LD (LPTPOS),A
  RET

OUTDO_CRLF_1:
  LD A,$0D
  RST OUTDO
  RET

; This entry point is used by the routine at FINLPT.
OUTDO_CRLF_2:
  LD A,$03
  RST OUTDO
  XOR A
  RET

; Check STOP key status
;
; Used by the routines at MUSIC, FORFND and __LIST.
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

; THIS IS THE LINE INPUT ROUTINE
; IT READS CHARACTERS INTO BUF USING _ AS THE
; CHARACTER DELETE CHARACTER AND @ AS THE LINE DELETE CHARACTER
; IF MORE THAN BUFLEN CHARACTER ARE TYPED, NO ECHOING
; IS DONE UNTIL A  _ @ OR CARRIAGE-RETURN IS TYPED.
; CONTROL-G WILL BE TYPED FOR EACH EXTRA CHARACTER.
; THE ROUTINE IS ENTERED AT INLIN, AT QINLIN TO TYPE A QUESTION MARK AND A SPACE FIRST
;
; This entry point is used by the routine at __INPUT.
QINLIN_SUB:
  LD A,'?'           ;GET A QMARK
  RST OUTDO          ;TYPE IT
  LD A,' '           ;SPACE
  RST OUTDO          ;TYPE IT TOO

; This entry point is used by the routine at PROMPT.
RINPUT:
  CALL PINLIN
  LD HL,KBUF
; This entry point is used by the routine at RINPUT_SUB.
RINPUT_0:
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

IF V10
  LD DE,ENDBUF
  RST DCOMPR
  JP Z,FINLPT_1
ELSE
  LD DE,ENDBUF-1
  RST DCOMPR
  JP RINPUT_SUB
ENDIF

; This entry point is used by the routine at RINPUT_SUB.
SHIFT_STOP_5:
  INC HL
  JR RINPUT_0

; This entry point is used by the routine at OUTC.
OUTPRT_CHR:
  PUSH BC
  PUSH DE
  PUSH HL
  PUSH AF
  CALL KBDSCAN
  CP $D8
  CALL Z,RINPUT8
  LD A,(PRTSTT)
  BIT 6,A
  JR NZ,SHIFT_STOP_6
  CALL SHIFT_STOP_8
SHIFT_STOP_6:
  CALL RINPUT0
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

RINPUT0:
  RLA
  RET C
  RRA
  AND $F0
  LD (PRTSTT),A
RINPUT1:
  LD HL,$1B58
RINPUT2:
  IN A,($10)
  AND $02
  RET Z
  DEC HL
  XOR A
RINPUT3:
  DEC A
  OR A
  JR NZ,RINPUT3
  LD A,H
  OR L
  JR NZ,RINPUT2
  XOR A
  LD (PRTFLG),A

  LD B,5
RINPUT4:
  LD A,$0E
  RST OUTDO
  DJNZ RINPUT4

  LD HL,PRTSTT
  SET 0,(HL)
  LD A,(PRTCOM)
  RRA
  JR C,RINPUT6
  LD HL,PRINTER_MSG_FR
  LD A,(FRGFLG)
  OR A
  JR Z,RINPUT5
  LD HL,PRINTER_MSG
RINPUT5:
  CALL PRS
RINPUT6:
  LD A,$01
  LD (PRTFLG),A
RINPUT7:
  CALL KBDSCAN
  OR A
  JR Z,RINPUT7
  CP $D8
  JR NZ,RINPUT1
RINPUT8:
  CALL KBDSCAN
  CP $D8
  JR Z,RINPUT8
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
  JR NZ,RINPUT9
  LD HL,(PRTXLT)
  LD A,H
  OR L
  JR Z,RINPUT9
  POP AF
  ADD A,L
  LD L,A
  LD A,$00
  ADC A,H
  LD H,A
  LD A,(HL)
  PUSH AF
RINPUT9:
  POP AF
  RET
SHIFT_STOP_20:
  OUT ($11),A
  LD A,$00
  OUT ($10),A
  LD A,$01
  OUT ($10),A
  RET

IF !V10

; This entry point is used by the routine at ENFMEM.
CLRPTR_1:
  LD (AUTFLG),A           ;CLEAR AUTO MODE
  LD (HL),A               ;SAVE AT END OFF TEXT
  INC HL                  ;BUMP POINTER
  LD (HL),A               ;SAVE ZERO
  JP RUN_FST_0

; This entry point is used by the routine at PROMPT.
PROMPT_SUB:
  PUSH HL                  ;SAVE AWAY FOR LATER USE
  CALL LINPRT              ;PRINT THE LINE #
  POP DE                   ;GET IT BACK
  CALL SRCHLN              ;SEE IF IT EXISTS
  JP NC,PROMPT_RET1           ;DOESNT EXIST
  LD A,160                 ; (DIAMOND SYMBOL) -> CHAR TO PRINT IF LINE ALREADY EXISTS
  JP PROMPT_RET2

; This entry point is used by the routine at PROMPT.
AUTLIN_SUB:
  JR C,AUTRES              ;CHECK FOR PATHETIC CASE
  PUSH DE                  ;SAVE LINE NUMBER #
  LD DE,65529              ;CHECK FOR LINE # TOO BIG
  RST DCOMPR
  POP DE                   ;GET BACK LINE #
  JR NC,AUTRES             ;IF TOO BIG, QUIT
  LD (AUTLIN),HL           ;SAVE IN NEXT LINE
  JR _AUTSTR
AUTRES:
  XOR A
  LD (AUTFLG),A            ;Clear auto flag
_AUTSTR:
  JP AUTSTR                ;And enter line

; This entry point is used by the routine at SCR_CO.
SCR_CO_SUB:
  LD HL,CHR_DOTDOT
  CALL CHR_UPDATE
  LD A,$20
  LD HL,CHR_DIAMOND
  JP  SCR_CO_1

;
; THE "NEW" COMMAND CLEARS THE PROGRAM TEXT AS WELL
; AS VARIABLE SPACE
;
; Routine at 15822
__NEW:
  JP Z,CLRPTR
  CALL ATOH
  RET NZ                  ;MAKE SURE THERE IS A TERMINATOR
  LD BC,READY
  PUSH BC
  CALL SRCHLN
  LD H,B
  LD L,C
  JP CLRPTR_0

; Routine at 15841
;
; Used by the routine at SHIFT_STOP.
RINPUT_SUB:
  JR C,RINPUT_SUB_0
  JP NZ,RINPUT_0
  LD A,$0E
  RST OUTDO
RINPUT_SUB_0:
  JP SHIFT_STOP_5


; Get INPUT with prompt, HL = resulting text
;
; Used by the routines at __INPUT and GTVLUS.
QINLIN_V11:
  LD A,(PICFLG)
  SET 5,A
  LD (PICFLG),A
  SET 6,(IX+$03)          ; CURSOR - Show
  JP QINLIN


; This entry point is used by the routine at T_EDIT.
QINLIN_0:
  CP $06
  JR NZ,QINLIN_2
  LD A,(PICFLG)
  BIT 5,A
  JP CONSOLE_BS_4

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
  RST OUTDO
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
  JP Z,T_EDIT_CR
  PUSH AF
  LD A,($4889)
  OR A
  JR NZ,QINLIN_6
  POP AF
  JP T_EDIT_0

QINLIN_6:
  POP AF
  JP QINLIN_0

ENDIF


IF V10 
  DEFS 174, $FF
ENDIF

  DEFS 449, $FF

