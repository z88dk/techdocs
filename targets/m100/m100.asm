oprtyp
; TANDY M100 disassembly

defc CR = 13
defc LF = 10

defc MAXRAM	 = $F5F0
defc HIMEM	 = $F5F4
defc BARCODE	 = $F5F9
defc UART	 = $F5FC
defc TIMER	 = $F5FF
defc _TRAP	 = $F602
defc EXTROM_TST	 = $F605
defc OPTROM	 = $F62A
defc DIAL_SPEED	 = $F62B
defc FNKMAC	 = $F62C
defc FNKSTAT	 = $F630
defc CSRX	 = $F639
defc CSRY	 = $F63A
defc ACTV_X	 = $F63B
defc ACTV_Y	 = $F63C
defc LABEL_LN	 = $F63D
defc NO_SCROLL	 = $F63E
defc CSR_STATUS	 = $F63F
defc CSR_ROW	 = $F640
defc CSR_COL	 = $F641
defc ESC_MODE	 = $F646
defc REVERSE	 = $F648
defc GR_X	 = $F64E
defc GR_Y	 = $F64F
defc ERRTRP	 = $F652
defc POWR_FLAG	 = $F656
defc DUPLEX	 = $F658
defc RS232LF	 = $F65A
defc STAT	 = $F65B
defc PIVOTCALL	 = $F660
defc LASTCALL	 = $F661
defc _OUT	 = $F667
defc OTPORT 	 = $F668
defc _INP	 = $F66A
defc INPORT 	 = $F66B
defc ERR_CODE	 = $F672
defc LPT_POS	 = $F674
defc PRTFLG	 = $F675
defc STRBUF	 = $F678
defc CURLIN	 = $F67A
defc BASTXT	 = $F67C
defc VLZADR	 = $F67E
defc BUFFER 	 = $F680
defc INPBFR	 = $F681
defc KBUF	 = $F685
defc TTYPOS	 = $F788
defc FNKSTR	 = $F789
defc PERM_END	 = $F88C
defc SECS	 = $F923
defc SECS_2	 = $F924
defc MINS	 = $F925
defc MINS_2	 = $F926
defc HRS	 = $F927
defc HRS_2	 = $F928
defc DATE	 = $F929
defc DATE_2	 = $F92A
defc DAY	 = $F92B
defc MONTH	 = $F92C
defc YEAR	 = $F92D
defc YEAR_2	 = $F92E
defc CSRITP	 = $F92F
defc CLOCK_SS1	 = $F933
defc CLOCK_SS2	 = $F934
defc CLOCK_MM1	 = $F935
defc CLOCK_MM2	 = $F936
defc CLOCK_HH1	 = $F937
defc CLOCK_HH2	 = $F938
defc CLOCK_DT1	 = $F939
defc CLOCK_DT2	 = $F93A
defc CLOCK_DAY	 = $F93B
defc ON_TIME_TM	 = $F93D
defc ON_COM_FLG	 = $F944
defc ON_COM	 = $F945
defc ON_TIME_FLG	 = $F947
defc ON_TIME	 = $F948
defc FNK_VECTBL	 = $F94A
defc DIRECTORY	 = $F962
defc END_DIR	 = $FA81
defc SUZUKI	 = $F99A
defc HAYASHI	 = $F9A5
defc LPRINT_CH	 = $FAAC
defc LBL_LINE	 = $FAAD
defc PORT_A8	 = $FAAE
defc IPL_FNAME	 = $FAAF
defc LBLIST	 = $FABA
defc SP_POWER	 = $FABE
defc PROGND 	 = $FAC0
defc CAPTUR	 = $FAC2
defc RST38_OFFS	 = $FAC9
defc TOP	 = $FACE
defc PRLEN	 = $FAD0
defc EXE	 = $FAD2
defc RST38_VECT	 = $FADA
defc HOUTD	 = $FAE2
defc HLPTO	 = $FAE4
defc HEOF	 = $FB00
defc TERM_F6_VECT	 = $FB0C
defc TERM_F7_VECT	 = $FB0E
defc HWIDT	 = $FB14
defc CRT_OPN_VECT	 = $FB1A
defc CRT_OUT_VECT	 = $FB1E
defc W_OPN_VECT	 = $FB20
defc W_CLS_VECT	 = $FB22
defc W_GET_VECT	 = $FB24
defc W_IO_VECT	 = $FB26
defc HLOF	 = $FB28
defc HLOC	 = $FB2A
defc HFILE	 = $FB2C
defc HDSKI	 = $FB2E
defc HDSKO	 = $FB30
defc DIMFLG 	 = $FB64
defc VALTYP	 = $FB65
defc OPRTYP	 = $FB66
defc FILE_BUFFR	 = $FB67
defc TEMPPT 	 = $FB69
defc TEMPST 	 = $FB6B
defc TMPSTR 	 = $FB89
defc FRETOP	 = $FB8C
defc DATLIN	 = $FB94
defc SUBFLG 	 = $FB96
defc FLGINP	 = $FB98
defc TEMP 	 = $FB99
defc TEMP3 	 = $FB8E
defc SAVTXT 	 = $FB9B
defc SAVSTK	 = $FB9D
defc ERRLIN	 = $FB9F
defc DOT	 = $FBA1
defc ERRTXT	 = $FBA3
defc ONELIN	 = $FBA5
defc NXTOPR 	 = $FBA8
defc OLDLIN	 = $FBAA
defc OLDTXT	 = $FBAC
defc DO_FILES	 = $FBAE
defc CO_FILES	 = $FBB0
defc VAREND 	 = $FBB4
defc ARREND 	 = $FBB6
defc DATPTR	 = $FBB8
defc DEFTBL	 = $FBBA
defc PRMSTK 	 = $FBD4
defc PRMLEN 	 = $FBD6
defc PRMLN2 	 = $FBDB
defc NOFUNS 	 = $FBE1
defc FUNACT 	 = $FBE4
defc VLZDAT	 = $FBE6
defc FBUFFR	= $FBE7
defc NUMSTR	 = $FBE8
defc FACCU	 = $FC18
defc DBL_FPREG	 = $FC1A
defc HOLD	=	$FC60
defc FAC2	 = $FC69
defc FAC2_INT	 = $FC6B

defc RNDX	 = $FC79
defc SEEDRD	 = $FC7A
defc MAXFIL	 = $FC82
defc FILTAB	 = $FC83
defc PTRFIL	 = $FC8C
defc FILNAM	 = $FC93
defc FILNM2	 = $FC9C
defc NLONLY	 = $FCA7
defc ALT_LCD	 = $FCC0
defc ALT_LCD_END	 = $FDFF
defc BEGLCD	 = $FE00
defc ENDLCD	 = $FF40
defc XONXOFF	 = $FF42
defc SOUND_FLG	 = $FF44
defc PORT_E8	 = $FF45
defc RS232_BUF	 = $FF46
defc RS232_COUNT	 = $FF86
defc CTRL_S_FLG	 = $FF8A
defc CASS_FREQ	 = $FF8B
defc CASS_HILO	 = $FF8E
defc KBSITP	 = $FF8F
defc KB_FLAGS	 = $FF97
defc KB_FNK	 = $FF98
defc PKGFF	 = $FF99
defc KB_SHIFT	 = $FFA2
defc GETPNT	 = $FFAA
defc PUTPNT	 = $FFAB
defc CURS_SHAPE	 = $FFEC



  ORG $0000

; Reset
L0000:
  JP BOOT
  LD C,L
  LD B,L
  LD C,(HL)
  LD D,L
  NOP

; Check syntax, 1 byte follows to be compared
;
; Used by the routines at UPD_PTRS, __FOR, __DEF, __LET, ON_ERROR, __IF, TAB,
; __INPUT, __READ, FDTLP, OPNPAR, VARPTR, VARPTR_VAR, UCASE, DEPINT, __POKE,
; __POWER, __DATE_S, __DAY_S, OUTS_B_CHARS, LINE_GFX, MAX_FN, __SOUND, MOTOR_ON,
; __CALL, __SCREEN, __LCOPY, __NAME, __CSAVE, CSAVEM, __CLOAD, STRING_S,
; LFRGNM, INSTR, __CLEAR, INXD, USING, __OPEN, __MERGE, __SAVE, INPUT_S, L4F2E,
; TEL_SET_STAT, KBD_MAP and __MAX.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  JP NZ,SNERR
  INC HL
  EX (SP),HL

; A=(HL), HL++, skip spaces
;
; Used by the routines at JPBC, EXEC_HL, TOKENIZE, STEP, EXEC, __DEF, DECLVAR,
; ATOH_2, ON_ERROR, __RESUME, __IF, __PRINT, TAB, __LINE, __READ, FDTLP, EVAL3,
; OPRND, ERR, ERL, VARPTR, UCASE, L1112, FNDNUM, MAKINT, __POWER, POWER_CONT,
; TIME_S_FN, DATE_S_FN, DAY_S_FN, __MDM, __KEY, LINE_GFX, CSRLIN, MAX_FN,
; L1DB9, SOUND_ON, MOTOR_OFF, __CALL, __SCREEN, __LCOPY, __KILL, __CSAVE,
; SAVEM, CSAVEM, __CLOAD, LOADM_RUNM, CLOADM, LDIR_B, PRPARM, STRING_S, __VAL,
; INSTR, _ASCTFP, PUFOUT, __CLEAR, __NEXT, INXD, GETVAR, SCPTLP, USING,
; INKEY_S, VARPTR_A, __OPEN, _OPEN, __MERGE, __SAVE, __CLOSE, INPUT_S, L4F2E,
; TELCOM_RDY, TEL_STAT, TEL_SET_STAT, TEL_LOGON, TEL_TERM, UPLDR, DWNLDR,
; TEL_BYE, TEXT, TXT_CTL_Y, TXT_CTL_G, LOAD_BA_LBL, KBD_MAP and BOOT.
CHRGTB:
  JP _CHRGTB
; This entry point is used by the routines at TXT_CTL_Z and TXT_CTL_C.
CHRGTB_0:
  EX DE,HL
  LD HL,($F6EB)
  EX DE,HL

; compare DE and HL (aka DCOMPR)
;
; Used by the routines at NEXT_UNSTACK, FIND_LINE_FHL, __FOR, ATOH_2, __GOTO,
; __LET, __LIST, PRS_M100, RAM_IO, __EOF, __LCOPY, CATALOG, KILLASC, __NAME,
; FINDCO, RESFPT, CLOADM, TSTOPL, TESTR, GSTRDE, INSTR, TSTSTR, _ASCTFP,
; INTEXP, __CLEAR, GETVAR, SCPTLP, BSERR, UPLDR, TXT_CTL_E, TXT_CTL_A,
; TXT_CTL_Z, TXT_CTL_C, MCLEAR, TXT_CTL_U, TXT_CTL_N, TXT_CTL_V, GETEND, BASIC,
; IOINIT, KBD_MAP, BOOT and __MAX.
CPDEHL:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; Print a space (screen or printer)
;
; Used by the routine at DSPFNK.
OUT_SPC:
  LD A,' '

; Output char in 'A' to console
;
; Used by the routines at JPBC, TAB, __READ, __LIST, PRS_M100, __KEY,
; OUTS_B_CHARS, CATALOG, PRS1, OUTDO_CRLF, OUTDO_LF, __BEEP, HOME, __CLS, ESCA,
; POSIT, _TAB, ESC_L, QINLIN, INLIN_BRK, INLIN_CURS, INLIN_TAB, INXD, USING,
; CONSOLE_CRLF, TEL_GET_STAT, TEL_FIND, TEL_LOGON, TEL_DIAL_DGT, TEL_TERM,
; UPLDR, __MENU, PRINT_TEXT, SHOW_TIME, MOVE_TEXT, TXT_CTL_G and TXT_CTL_V.
OUTC:
  JP _OUTC
  NOP

; 8085 TRAP interrupt vector.  This non maskable interrupt is generated if the
; CPU does not have enough power to operate.
TRAP:
  JP _TRAP
  NOP

; Test number FAC type (Precision mode, etc..)
;
; Used by the routines at TO, STEP, __PRINT, __READ, EVAL3, VAR_EVAL, UCASE,
; GETWORD, STRING_S, INSTR, __FRE, INVSGN, __TSTSGN, __CINT, __CSNG, __CDBL,
; TSTSTR, __FIX, __INT, _ASCTFP, __NEXT, GETVAR, L4F2E and KBD_MAP.
GETYPR:
  JP _GETYPR
  NOP

; 8085 RST 5.5 interrupt vector, generated if data is present on the Bar Code
; Reader port. Jumps to BARCODE
RST55:
  DI
  JP BARCODE

; Test number sign, error if string
;
; Used by the routines at STEP, GETWORD, DECMUL, __LOG, __SQR, __RND,
; BCDE_FP_CMP, CMP_HLDE, __FIX, PUFOUT and KBD_MAP.
TSTSGN:
  JP _TSTSGN
  NOP

; 8085 RST 6.5 interrupt vector (happens when UART input is present), jumps to
; UART
RST65:
  DI
  JP _RST65

; RAM vector table driver.The byte after the call determines the offset index
; for VECT_TBL
;
; Used by the routines at CHGET, CHSNS, LPT_OUT, CRT_CTL, WAND_CTL, __EOF,
; NAXRAM, __WIDTH, __SCREEN, __KILL, __NAME, SAVEM, LOADM_RUNM, HL_CSNG,
; __CLEAR, OUTC_SUB, VARPTR_A, SELECT, __OPEN, _OPEN, CLOSE1, __MERGE, __SAVE,
; __CLOSE, RDBYT, INPUT_S, L4F2E, __LOF, __LOC, __LFILES, __DSKO_S, DSKI_S,
; GET_DEVICE, TELCOM_RDY, TEL_TERM, UPLDR, TXT_ESC, FONT and KBD_MAP.
RST38H:
  JP _RST38H
  NOP

; 8085 RST 7.5 interrupt vector  (timer).
RST75:
  DI
  JP _RST75

; Extra jump table for functions
FNCTAB_FN:
  DEFW __SGN
  DEFW __INT
  DEFW __ABS
  DEFW __FRE
  DEFW __INP
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
  DEFW __EOF
  DEFW __LOC
  DEFW __LOF
  DEFW __CINT
  DEFW __CSNG
  DEFW __CDBL
  DEFW __FIX
  DEFW __LEN
  DEFW __STR_S
  DEFW __VAL
  DEFW __ASC
  DEFW __CHR_S
  DEFW __SPACE_S
  DEFW __LEFT_S
  DEFW __RIGHT_S
  DEFW __MID_S
TOKEN:
  DEFW $4EC5
  DEFW $C644
  DEFW $524F
  DEFW $45CE
  DEFW $5458
  DEFW $41C4
  DEFW $4154
  DEFW $4EC9
  DEFW TEL_ECHO
  DEFW $C454
  DEFW $4D49
  DEFW $45D2
  DEFW $4441
  DEFW $45CC
  DEFW $C754
  DEFW $544F
  DEFW $D24F
  DEFW $4E55
  DEFW $46C9
  DEFW $45D2
  DEFW $5453
  DEFW $524F
  DEFW $C745
  DEFW $534F
  DEFW $4255
  DEFW $45D2
  DEFW $5554
  DEFW __CLOSE_2
  DEFW $45D2
  DEFW $D34D
  DEFW $4F54
  DEFW $D750
  DEFW $4449
  DEFW $4854
  DEFW $4CC5
  DEFW $4553
  DEFW $49CC
  DEFW ESC_J
  DEFW $44C5
  DEFW $5449
  DEFW $52C5
  DEFW $4F52
  DEFW $D252
  DEFW $5345
  DEFW $4D55
  DEFW $CF45
  DEFW TEL_TERM
  DEFW $4ECF
  DEFW $53C4
  DEFW $4F4B
  DEFW $CF24
  DEFW $4550
  DEFW $C34E
  DEFW $4F4C
  DEFW $4553
  DEFW $4FCC
  DEFW $4441
  DEFW $45CD
  DEFW $4752
  DEFW $C645
  DEFW $4C49
  DEFW $5345
  DEFW $41D3
  DEFW $4556
  DEFW INLIN_TAB_0
  DEFW $4C49
  DEFW $5345
  DEFW $50CC
  DEFW $4952
  DEFW $544E
  DEFW $45C4
  DEFW $D046
  DEFW $4B4F
  DEFW $D045
  DEFW $4952
  DEFW $544E
  DEFW $4FC3
  DEFW $544E
  DEFW $49CC
  DEFW $5453
  DEFW $4CCC
  DEFW $5349
  DEFW $C354
  DEFW $454C
  DEFW $5241
  DEFW $4CC3
  DEFW $414F
  DEFW $C344
  DEFW $4153
  DEFW $4556
  DEFW USING_5
  DEFW $454D
  DEFW $C424
  DEFW $5441
  DEFW $2445
  DEFW $41C4
  DEFW $2459
  DEFW $4FC3
  DEFW $CD4D
  DEFW $4D44
  DEFW ESC_J_9
  DEFW $C359
  DEFW $534C
  DEFW $45C2
  DEFW $5045
  DEFW $4FD3
  DEFW $4E55
  DEFW $CC44
  DEFW L4F2E_0
  DEFW $5950
  DEFW $53D0
  DEFW $5445
  DEFW TEL_CONN
  DEFW $5345
  DEFW $5445
  DEFW $4FCD
  DEFW $4F54
  DEFW $CD52
  DEFW $5841
  DEFW $4FD0
  DEFW $4557
  DEFW $C352
  DEFW $4C41
  DEFW $CD4C
  DEFW $4E45
  DEFW $C955
  DEFW $4C50
  DEFW $41CE
  DEFW $454D
  DEFW $49CB
  DEFW $4C4C
  DEFW $43D3
  DEFW $4552
  DEFW $4E45
  DEFW $45CE
  DEFW $D457
  DEFW $4241
  DEFW $D428
  DEFW $D54F
  DEFW $4953
  DEFW INXD_9
  DEFW $41D6
  DEFW $5052
  DEFW $5254
  DEFW $52C5
  DEFW $C54C
  DEFW $5252
  DEFW $54D3
  DEFW $4952
  DEFW INXD_9
  DEFW $C924
  DEFW $534E
  DEFW $5254
  DEFW $53C4
  DEFW $494B
  DEFW $C924
  DEFW $4B4E
  DEFW $5945
  DEFW $C324
  DEFW $5253
  DEFW $494C
  DEFW $CF4E
  DEFW $4646
  DEFW $49C8
  DEFW $454D
  DEFW $D44D
  DEFW _CLS
  DEFW $CE4E
  DEFW $544F
  DEFW $54D3
  DEFW $5045
  DEFW $ADAB
  DEFW $AFAA
  DEFW $C1DE
  DEFW $444E
  DEFW $52CF
  DEFW $4FD8
  DEFW $C552
  DEFW $5651
  DEFW $4DC9
  DEFW $CD50
  DEFW $444F
  DEFW $BEDC
  DEFW $BCBD
KWDTAB:
  DEFW $47D3
  DEFW $C94E
  DEFW $544E
  DEFW $42C1
  DEFW $C653
  DEFW $4552
  DEFW $4EC9
  DEFW $CC50
  DEFW $4F50
  DEFW $D053
  DEFW $534F
  DEFW $51D3
  DEFW $D252
  DEFW $444E
  DEFW $4FCC
  DEFW $C547
  DEFW $5058
  DEFW $4FC3
  DEFW $D353
  DEFW $4E49
  DEFW $41D4
  DEFW $C14E
  DEFW $4E54
  DEFW $45D0
  DEFW $4B45
  DEFW $4FC5
  DEFW $CC46
  DEFW $434F
  DEFW $4FCC
  DEFW $C346
  DEFW $4E49
  DEFW $C354
  DEFW $4E53
  DEFW $C347
  DEFW UNLOCK
  DEFW $C64C
  DEFW $5849
  DEFW $45CC
  DEFW $D34E
  DEFW $5254
  DEFW $D624
  DEFW $4C41
  DEFW $53C1
  DEFW $C343
  DEFW $5248
  DEFW $D324
  DEFW $4150
  DEFW $4543
  DEFW $CC24
  DEFW $4645
  DEFW $2454
  DEFW $49D2
  DEFW $4847
  DEFW $2454
  DEFW $49CD
  DEFW $2444
  DEFW $80A7

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
  DEFW __ELSE
  DEFW __STOP
  DEFW __WIDTH
  DEFW __ELSE
  DEFW __LINE
  DEFW __EDIT
  DEFW __ERROR
  DEFW __RESUME
  DEFW __OUT
  DEFW __ON
  DEFW __DSKO_S
  DEFW __OPEN
  DEFW __CLOSE
  DEFW __LOAD
  DEFW __MERGE
  DEFW __FILES
  DEFW __SAVE
  DEFW __LFILES
  DEFW __LPRINT
  DEFW __DEF
  DEFW __POKE
  DEFW __PRINT
  DEFW __CONT
  DEFW __LIST
  DEFW __LLIST
  DEFW __CLEAR
  DEFW __CLOAD
  DEFW __CSAVE
  DEFW __TIME_S
  DEFW __DATE_S
  DEFW __DAY_S
  DEFW __MDM
  DEFW __MDM
  DEFW __KEY
  DEFW __CLS
  DEFW __BEEP
  DEFW __SOUND
  DEFW __LCOPY
  DEFW __PSET
  DEFW __PRESET
  DEFW __MOTOR
  DEFW __MAX
  DEFW __POWER
  DEFW __CALL
  DEFW __MENU
  DEFW __IPL
  DEFW __NAME
  DEFW __KILL
  DEFW __SCREEN
  DEFW __NEW
  DEFW $7979
  DEFW $7C7C
  DEFW $507F
  DEFW $3C46
  DEFW $2832
  DEFW $7B7A
MATH_OP:
  DEFW __CDBL
  DEFW L0000
  DEFW __CINT
  DEFW TSTSTR
  DEFW __CSNG
  DEFW DECADD
  DEFW DECSUB
  DEFW DECMUL
  DEFW DBL_DIV
  DEFW DECEXP
  DEFW CMP_FAC1FAC2
  DEFW DBL_ABS_2
  DEFW FDIV
  DEFW FMULT_BCDE
  DEFW FDIV_BCDE
  DEFW FEXP
  DEFW BCDE_FP_CMP
  DEFW IADD
  DEFW ISUB
  DEFW INT_MUL
  DEFW IDIV
  DEFW INTEXP
  DEFW CMP_HLDE
ERRMSG:
  DEFW $464E
  DEFW $4E53
  DEFW $4752
  DEFW $444F
  DEFW $4346
  DEFW $564F
  DEFW $4D4F
  DEFW FNAME_4
  DEFW $5342
  DEFW $4444
  DEFW $302F
  DEFW $4449
  DEFW $4D54
  DEFW $534F
  DEFW $534C
  DEFW $5453
  DEFW $4E43
  DEFW $4F49
  DEFW $524E
  DEFW $5752
  DEFW $4555
  DEFW L4F2E_2
  DEFW $4549
  DEFW $4E42
  DEFW $4646
  DEFW $4F41
  DEFW $4645
  DEFW $4D4E
  DEFW $5344
  DEFW $4C46
  DEFW $4643
SYSVARS_ROM:
  DEFW $8A4D
  DEFW L0000
  DEFW MAXRAM
  DEFW $00C9
  DEFW HEOF
  DEFW $00C9
  DEFW $00C9
  DEFW $C900
  DEFW L0000
  DEFW $31C3
  DEFW $3E14
  DEFW $D301
  DEFW $21E8
  DEFW FNCTAB_FN
  DEFW $A411
  DEFW $7EFA
  DEFW $2312
  DEFW $7D13
  DEFW $48D6
  DEFW $0FC2
  DEFW $D3F6
  DEFW $2AE8
  DEFW $FAA4
  DEFW $5411
  DEFW $C343
  DEFW CPDEHL
  DEFW INTEXP_17
  DEFW $D301
  DEFW $C7E8
  DEFW $0100
  DEFW L0000
  DEFW $FFFF
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW $0100
  DEFW $0801
  DEFW GETYPR
  DEFW L0000
  DEFW $0101
  DEFW $0101
  DEFW $2819
  DEFW L0000
  DEFW $5000
  DEFW $3038
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW $6400
  DEFW $00FF
  DEFW $4D00
  DEFW $4937
  DEFW $4531
  DEFW $00C3
  DEFW L0000
  DEFW $00C9
  DEFW $D3C9
  DEFW $C900
  DEFW $00DB
  DEFW $3AC9
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW L0000
  DEFW $000E
  DEFW $FD15
  DEFW $FFFE
  DEFW $FCB2
  DEFW L0000
ERR_MSG:
  DEFM " Error"           ; 'Error' text
  DEFB $00
IN_MSG:
  DEFM " in "             ; error messages related text
  DEFB $00
OK_MSG:
  DEFM "Ok"               ; 'OK' message for BASIC prompt
  DEFB $0D
  DEFB $0A
  DEFB $00
BREAK_MSG:
  DEFM "Break"            ; Text for 'Break' message
  DEFB $00

; Pop the return address for a NEXT or RETURN off the stack.
;
; Used by the routines at __RETURN and __NEXT.
NEXT_UNSTACK:
  LD HL,$0004
  ADD HL,SP
; This entry point is used by the routine at __FOR.
NEXT_UNSTACK_0:
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
  LD A,D
  OR E
  EX DE,HL
  JP Z,NEXT_UNSTACK_1
  EX DE,HL
  RST CPDEHL
NEXT_UNSTACK_1:
  LD BC,$0016
  POP HL
  RET Z
  ADD HL,BC
  JP NEXT_UNSTACK_0

; Initialize system and go to BASIC ready
;
; Used by the routine at INPUT_S.
BASIC_MAIN:
  LD BC,RESTART
  JP JPBC
; This entry point is used by the routine at EXEC_EVAL.
BASIC_MAIN_0:
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,BASIC_MAIN_1
  LD A,($FBA7)
  OR A
  LD E,$13
  JP NZ,ERROR
BASIC_MAIN_1:
  JP __END_1
  JP ERROR

; 'SN err' entry for Input STMT
;
; Used by the routine at __LINE.
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?SN ERROR'
;
; Used by the routines at SYNCHR, EXEC_HL, UPD_PTRS, EXEC_EVAL, ON_ERROR,
; EVAL3, IDERR, __POWER, __DATE_S, __DAY_S, KEY_STMTS, __KILL, OPENDO, CSAVEM,
; __CLOAD, CLOADM, __CLEAR, GETVAR, SCPTLP, USING, _OPEN and __MAX.
SNERR:
  LD E,$02
  LD BC,$0B1E

; Generate /0 error (division by zero)
;
; Used by the routines at DBL_DIV, INT_DIV and INTEXP.
OERR:
  LD E,$0B
  LD BC,$011E

; NF error: NEXT without FOR
;
; Used by the routine at __NEXT.
NFERR:
  LD E,$01
  LD BC,$0A1E

; DD error: re-DIM not allowed
;
; Used by the routine at SCPTLP.
DDERR:
  LD E,$0A
  LD BC,$141E

; RW error: RESUME without error condition
;
; Used by the routine at __RESUME.
RWERR:
  LD E,$14
  LD BC,$061E

; OV error: overflow
;
; Used by the routines at GETWORD, DECADD, DECMUL, DBL_DIV, __TAN, __EXP,
; __CINT, _ASCTFP, INTEXP and __NEXT.
OVERR:
  LD E,$06
  LD BC,$161E

; MO error: missing operand
;
; Used by the routine at OPRND.
MOERR:
  LD E,$16
  LD BC,$0D1E

; TM error: wrong variable type
;
; Used by the routines at TO, EVAL3, INVSGN, __TSTSGN, __CINT, __CSNG, __CDBL,
; TSTSTR and __INT.
TMERR:
  LD E,$0D

; Generate error, number in E
;
; Used by the routines at BASIC_MAIN, FCERR, ULERR, __RETURN, __ERROR, FDTLP,
; IDERR, IOERR, TSTOPL, TESTR, CONCAT, OMERR, __CONT, BSERR, FLERR and __EDIT.
ERROR:
  XOR A
  LD ($FCA7),A
  LD HL,($F67E)
  LD A,H
  OR L
  JP Z,ERROR_0
  LD A,($FBE6)
  LD (HL),A
  LD HL,L0000
  LD ($F67E),HL
ERROR_0:
  EI
  LD HL,(ERRTRP)
  PUSH HL
  LD A,H
  OR L
  RET NZ

; Routine at 1147
RETERR:
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  LD A,H
  AND L
  INC A
  JP Z,RETERR_0
  LD (DOT),HL
; This entry point is used by the routine at ON_ERROR.
RETERR_0:
  LD BC,$0493

; Restore old stack and runtime pointers and jump to (BC)
;
; Used by the routine at BASIC_MAIN.
JPBC:
  LD HL,($FB9D)
  JP SETMAX_2
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
  JP Z,JPBC_0
  LD (OLDLIN),HL
  EX DE,HL
  LD (OLDTXT),HL
  LD HL,(ONELIN)
  LD A,H
  OR L
  EX DE,HL
JPBC_0:
  LD HL,$FBA7
  JP Z,JPBC_1
  AND (HL)
  JP NZ,JPBC_1
  DEC (HL)
  EX DE,HL
  JP EXEC_EVAL_2
JPBC_1:
  XOR A
  LD (HL),A
  LD E,C
  CALL CONSOLE_CRLF
  LD A,E
  CP $3B
  JP NC,JPBC_2
  CP $32
  JP NC,JPBC_3
  CP $17
  JP C,JPBC_4
JPBC_2:
  LD A,$30
JPBC_3:
  SUB $1B
  LD E,A
JPBC_4:
  LD D,$00
  LD HL,$031A
  ADD HL,DE
  ADD HL,DE
  LD A,'?'
  RST OUTC
  LD A,(HL)
  RST OUTC
  RST CHRGTB
  RST OUTC
  LD HL,ERR_MSG
  PUSH HL
  LD HL,(ERRLIN)
  EX (SP),HL
; This entry point is used by the routine at __END.
JPBC_5:
  CALL PRS
  POP HL
  LD A,H
  AND L
  INC A
  CALL NZ,LNUM_MSG
  LD A,$C1

; Vector to BASIC Ready (Ok).  Pops the last address off stack.
;
; Used by the routines at __RETURN, __CSAVE, SAVE_BUFFER, __END and INXD.
RESTART:
  POP BC

; Vector to BASIC Ready (Ok). Jump
;
; Used by the routines at __LIST, __LCOPY, SAVEBA, KILLASC, CSAVEM, __CLOAD and
; BASIC.
READY:
  CALL INIT_OUTPUT
  CALL L4F2E_1
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  CALL PRS

; This is primarily used inside the BASIC ready routine f a blank or illegal
; line was entered.
;
; Used by the routines at EXEC_HL and __MERGE.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL
  LD HL,$F66D
  LD (SAVTXT),HL
  CALL INLIN
  JP C,PROMPT

; Perform operation in (HL) buffer and return to BASIC ready.
EXEC_HL:
  RST CHRGTB
  INC A
  DEC A
  JP Z,PROMPT
  PUSH AF
  CALL ATOH
  JP NC,EXEC_HL_0
  CALL RINPUT
  JP Z,SNERR
EXEC_HL_0:
  DEC HL
  LD A,(HL)
  CP $20
  JP Z,EXEC_HL_0
  CP $09
  JP Z,EXEC_HL_0
  INC HL
  LD A,(HL)
  CP $20
  CALL Z,LOADFP_1
  PUSH DE
  CALL TOKENIZE
  POP DE
  POP AF
  LD (SAVTXT),HL
  JP NC,INIT_PRINT_h_2
  PUSH DE
  PUSH BC
  XOR A
  LD ($FB97),A
  RST CHRGTB
  OR A
  PUSH AF
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL FIND_LINE
  JP C,EXEC_HL_1
  POP AF
  PUSH AF
  JP Z,ULERR
  OR A
EXEC_HL_1:
  PUSH BC
  JP NC,EXEC_HL_2
  CALL PRS_M100_15
  LD A,C
  SUB E
  LD C,A
  LD A,B
  SBC A,D
  LD B,A
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,($FAD8)
  ADD HL,BC
  LD ($FAD8),HL
EXEC_HL_2:
  POP DE
  POP AF
  PUSH DE
  JP Z,EXEC_HL_4
  POP DE
  LD HL,L0000
  LD (ONELIN),HL
  LD HL,(PROGND)
  EX (SP),HL
  POP BC
  PUSH HL
  ADD HL,BC
  PUSH HL
  CALL INTEXP_16
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
  LD DE,INPBFR
  PUSH HL
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,($FAD8)
  ADD HL,BC
  LD ($FAD8),HL
  POP HL
EXEC_HL_3:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  OR A
  JP NZ,EXEC_HL_3
EXEC_HL_4:
  POP DE
  CALL UPD_PTRS_0
  LD HL,(PTRFIL)
  LD (NXTOPR),HL
  CALL OMERR_0
  LD HL,(NXTOPR)
  LD (PTRFIL),HL
  JP PROMPT

; Update in memory line addresses  if a program has been loaded off tape or
; being edited
;
; Used by the routines at __LCOPY, __CSAVE, __CLOAD, CHKSTK, __MENU and BASIC.
UPD_PTRS:
  LD HL,(BASTXT)
  EX DE,HL
; This entry point is used by the routines at EXEC_HL, KILLASC and RESFPT.
UPD_PTRS_0:
  LD H,D
  LD L,E
  LD A,(HL)
  INC HL
  OR (HL)
  RET Z
  INC HL
  INC HL
  INC HL
  XOR A
UPD_PTRS_1:
  CP (HL)
  INC HL
  JP NZ,UPD_PTRS_1
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  JP UPD_PTRS_0
; This entry point is used by the routine at __LIST.
UPD_PTRS_2:
  LD DE,L0000
  PUSH DE
  JP Z,UPD_PTRS_3
  POP DE
  CALL EVAL_HL
  PUSH DE
  JP Z,UPD_PTRS_4
  RST SYNCHR
  POP DE
UPD_PTRS_3:
  LD DE,$FFFA
  CALL NZ,EVAL_HL
  JP NZ,SNERR
UPD_PTRS_4:
  EX DE,HL
  POP DE

; Push HL and find line # DE
;
; Used by the routine at ON_ERROR.
PHL_FIND_LINE:
  EX (SP),HL
  PUSH HL

; Find line # in DE, BC=line addr, HL=next line addr
;
; Used by the routines at EXEC_HL, __GOTO and __RESTORE.
FIND_LINE:
  LD HL,(BASTXT)

; as above but start at the address in HL instead at the start of the BASIC
; program
;
; Used by the routine at __GOTO.
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

; Token compression routine
;
; Used by the routine at EXEC_HL.
TOKENIZE:
  XOR A
  LD (OPRTYP),A
  LD C,A
  LD DE,INPBFR
TOKENIZE_0:
  LD A,(HL)
  CP $20
  JP Z,TOKENIZE_10
  LD B,A
  CP $22
  JP Z,TOKENIZE_15
  OR A
  JP Z,TOKENIZE_16
  INC HL
  OR A
  JP M,TOKENIZE_0
  DEC HL
  LD A,(OPRTYP)
  OR A
  LD A,(HL)
  JP NZ,TOKENIZE_10
  CP $3F
  LD A,$A3
  JP Z,TOKENIZE_10
  LD A,(HL)
  CP $30
  JP C,TOKENIZE_1
  CP $3C
  JP C,TOKENIZE_10
TOKENIZE_1:
  PUSH DE
  LD DE,$007F
  PUSH BC
  LD BC,$06CD
  PUSH BC
  LD B,$7F
  LD A,(HL)
  CP $61
  JP C,TOKENIZE_2
  CP $7B
  JP NC,TOKENIZE_2
  AND $5F
  LD (HL),A
TOKENIZE_2:
  LD C,(HL)
  EX DE,HL
TOKENIZE_3:
  INC HL
  OR (HL)
  JP P,TOKENIZE_3
  INC B
  LD A,(HL)
  AND $7F
  RET Z
  CP C
  JP NZ,TOKENIZE_3
  EX DE,HL
  PUSH HL
TOKENIZE_4:
  INC DE
  LD A,(DE)
  OR A
  JP M,TOKENIZE_7
  LD C,A
  LD A,B
  CP $88
  JP NZ,TOKENIZE_5
  RST CHRGTB
  DEC HL
TOKENIZE_5:
  INC HL
  LD A,(HL)
  CP $61
  JP C,TOKENIZE_6
  AND $5F
TOKENIZE_6:
  CP C
  JP Z,TOKENIZE_4
  POP HL
  JP TOKENIZE_2
TOKENIZE_7:
  LD C,B
  POP AF
  EX DE,HL
  RET
  EX DE,HL
  LD A,C
  POP BC
  POP DE
  EX DE,HL
  CP $91
  LD (HL),$3A
  JP NZ,TOKENIZE_8
  INC C
  INC HL
TOKENIZE_8:
  CP $FF
  JP NZ,TOKENIZE_9
  LD (HL),$3A
  INC HL
  LD B,$8E
  LD (HL),B
  INC HL
  INC C
  INC C
TOKENIZE_9:
  EX DE,HL
TOKENIZE_10:
  INC HL
  LD (DE),A
  INC DE
  INC C
  SUB $3A
  JP Z,TOKENIZE_11
  CP $49
  JP NZ,TOKENIZE_12
TOKENIZE_11:
  LD (OPRTYP),A
TOKENIZE_12:
  SUB $54
  JP Z,TOKENIZE_13
  SUB $71
  JP NZ,TOKENIZE_0
TOKENIZE_13:
  LD B,A
TOKENIZE_14:
  LD A,(HL)
  OR A
  JP Z,TOKENIZE_16
  CP B
  JP Z,TOKENIZE_10
TOKENIZE_15:
  INC HL
  LD (DE),A
  INC C
  INC DE
  JP TOKENIZE_14
TOKENIZE_16:
  LD HL,$0005
  LD B,H
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,BUFFER
  LD (DE),A
  INC DE
  LD (DE),A
  INC DE
  LD (DE),A
  RET

; 'FOR' BASIC instruction
__FOR:
  LD A,$64
  LD (SUBFLG),A
  CALL __LET
  POP BC
  PUSH HL
  CALL __DATA
  LD ($FB92),HL
  LD HL,$0002
  ADD HL,SP
__FOR_0:
  CALL NEXT_UNSTACK_0
  JP NZ,$0758
  ADD HL,BC
  PUSH DE
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  INC HL
  INC HL
  PUSH HL
  LD HL,($FB92)
  RST CPDEHL
  POP HL
  POP DE
  JP NZ,__FOR_0
  POP DE
  LD SP,HL
  LD ($FB9D),HL
  LD C,$D1
  EX DE,HL
  LD C,$0C
  CALL CHKSTK
  PUSH HL
  LD HL,($FB92)
  EX (SP),HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  RST SYNCHR
  POP BC

; Routine at 1899
TO:
  RST GETYPR
  JP Z,TMERR
  PUSH AF
  CALL EVAL
  POP AF
  PUSH HL
  JP NC,STEP_0
  JP P,STEP_2
  CALL __CINT
  EX (SP),HL
  LD DE,$0001
  LD A,(HL)

; Routine at 1923
STEP:
  CP $CF
  CALL Z,L1112
  PUSH DE
  PUSH HL
  EX DE,HL
  CALL __TSTSGN_0
  JP STEP_3
; This entry point is used by the routine at TO.
STEP_0:
  CALL __CDBL
  POP DE
  LD HL,$FFF8
  ADD HL,SP
  LD SP,HL
  PUSH DE
  CALL REV_LDDR_B_3
  POP HL
  LD A,(HL)
  CP $CF
  LD DE,FP_UNITY
  LD A,$01
  JP NZ,STEP_1
  RST CHRGTB
  CALL EVAL
  PUSH HL
  CALL __CDBL
  RST TSTSGN
  LD DE,FACCU
  POP HL
STEP_1:
  LD B,H
  LD C,L
  LD HL,$FFF8
  ADD HL,SP
  LD SP,HL
  PUSH AF
  PUSH BC
  CALL HL_FAC2_0
  POP HL
  POP AF
  JP STEP_5
; This entry point is used by the routine at TO.
STEP_2:
  CALL __CSNG
  CALL BCDEFP
  POP HL
  PUSH BC
  PUSH DE
  LD BC,$1041
  LD DE,L0000
  LD A,(HL)
  CP $CF
  LD A,$01
  JP NZ,STEP_4
  CALL L0DAC
  PUSH HL
  CALL __CSNG
  CALL BCDEFP
  RST TSTSGN
STEP_3:
  POP HL
STEP_4:
  PUSH DE
  PUSH BC
  PUSH BC
  PUSH BC
  PUSH BC
  PUSH BC
STEP_5:
  OR A
  JP NZ,STEP_6
  LD A,$02
STEP_6:
  LD C,A
  RST GETYPR
  LD B,A
  PUSH BC
  PUSH HL
  LD HL,(TEMP)
  EX (SP),HL
; This entry point is used by the routine at __NEXT.
STEP_7:
  LD B,$81
  PUSH BC
  INC SP

; BASIC program execution routine. HL points to code.
;
; Used by the routines at __CLOAD, CLOADM, __CLEAR, __NEXT, INXD, __MENU and
; __MAX.
EXEC_EVAL:
  CALL RCVX
  CALL NZ,CLR_ALLINT_2
  LD A,($F654)
  OR A
  CALL NZ,$402B
; This entry point is used by the routine at __MDM.
EXEC_EVAL_0:
  CALL CHSNS_0
  LD (SAVTXT),HL
; This entry point is used by the routine at FONT.
EXEC_EVAL_1:
  EX DE,HL
  LD HL,L0000
  ADD HL,SP
  LD ($FB9D),HL
  EX DE,HL
  LD A,(HL)
  CP $3A
  JP Z,EXEC
  OR A
  JP NZ,SNERR
  INC HL
; This entry point is used by the routines at JPBC and ULERR.
EXEC_EVAL_2:
  LD A,(HL)
  INC HL
  OR (HL)
  JP Z,BASIC_MAIN_0
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD (CURLIN),HL
  EX DE,HL

; Start executing a program at the address in HL.
;
; Used by the routines at EXEC_EVAL and INIT_PRINT_h.
EXEC:
  RST CHRGTB
  LD DE,EXEC_EVAL
  PUSH DE
; This entry point is used by the routine at __IF.
EXEC_0:
  RET Z

; Execute the compressed instruction token in the A register
;
; Used by the routine at ON_ERROR.
STATEMENT:
  SUB $80
  JP C,__LET
  CP $40
  JP NC,IDERR_0
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
; Used by the routines at CHRGTB, _CHRGTB2, EVAL_HL, __IF, DTSTR, VARPTR_A,
; __OPEN and __CLOSE.
_CHRGTB:
  INC HL

; Same as RST 10H but with no pre-increment of HL
_CHRGTB2:
  LD A,(HL)
  CP $3A
  RET NC
  CP $20
  JP Z,_CHRGTB
  CP $0B
  JP NC,_CHRGTB2_0
  CP $09
  JP NC,_CHRGTB
_CHRGTB2_0:
  CP $30
  CCF
  INC A
  DEC A
  RET

; __DEF
__DEF:
  CP $E0
  JP Z,DEFINT
  CP $44
  JP NZ,__DEF_0
  RST CHRGTB
  RST SYNCHR
  LD B,D
  RST SYNCHR
  LD C,H
DEFDBL:
  LD E,$08
  JP DECLVAR
DEFINT:
  RST CHRGTB
  LD E,$02
  JP DECLVAR
__DEF_0:
  RST SYNCHR
  LD D,E
  CP $4E
  JP NZ,__DEF_1
  RST CHRGTB
  RST SYNCHR
  LD B,A
DEFSNG:
  LD E,$04
  JP DECLVAR
__DEF_1:
  RST SYNCHR
  LD D,H
  RST SYNCHR
  LD D,D
DEFSTR:
  LD E,$03

; Declare the variables in the buffer pointed to by HL to the type in the E
; register
;
; Used by the routine at __DEF.
DECLVAR:
  CALL IS_ALPHA
  LD BC,SNERR
  PUSH BC
  RET C
  SUB $41
  LD C,A
  LD B,A
  RST CHRGTB
  CP $D1
  JP NZ,DECLVAR_0
  RST CHRGTB
  CALL IS_ALPHA
  RET C
  SUB $41
  LD B,A
  RST CHRGTB
DECLVAR_0:
  LD A,B
  SUB C
  RET C
  INC A
  EX (SP),HL
  LD HL,DEFTBL
  LD B,$00
  ADD HL,BC
DECLVAR_1:
  LD (HL),E
  INC HL
  DEC A
  JP NZ,DECLVAR_1
  POP HL
  LD A,(HL)
  CP $2C
  RET NZ
  RST CHRGTB
  JP DECLVAR
; This entry point is used by the routine at SCPTLP.
DECLVAR_2:
  RST CHRGTB
; This entry point is used by the routine at __CLEAR.
DECLVAR_3:
  CALL FPSINT
  RET P

; entry for '?FC ERROR'
;
; Used by the routines at __ERROR, VARPTR_VAR, MAKINT, POWER_ON, __IPL, __MDM,
; OUTS_B_CHARS, LINE_GFX, __SOUND, __LCOPY, KILLASC, __NAME, CSAVEM, __CLOAD,
; LOADM_RUNM, CLOADM, PRPARM, __ASC, __MID_S, INSTR, __LOG, __SQR, __CONT,
; __CLEAR, BSERR, USING, INPUT_S and __MAX.
FCERR:
  LD E,$05
  JP ERROR

; Evaluate line number text pointed to by HL.
;
; Used by the routine at UPD_PTRS.
EVAL_HL:
  LD A,(HL)
  CP $2E
  EX DE,HL
  LD HL,(DOT)
  EX DE,HL
  JP Z,_CHRGTB

; ASCII to Integer, result in DE
;
; Used by the routines at EXEC_HL, __GOTO, ON_ERROR, __RESUME and __RESTORE.
ATOH:
  DEC HL

; As above, but conversion starts at HL+1
;
; Used by the routine at ON_ERROR.
ATOH_2:
  LD DE,L0000
ATOH_2_0:
  RST CHRGTB
  RET NC
  PUSH HL
  PUSH AF
  LD HL,$1998
  RST CPDEHL
  JP C,ATOH_2_1
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
  JP ATOH_2_0
ATOH_2_1:
  POP AF
  POP HL
  RET

; Routine at 2319
__RUN:
  JP Z,OMERR_0
  JP NC,_RUN
; This entry point is used by the routine at FP_SINTAB.
__RUN_0:
  CALL OMERR_1
  LD BC,EXEC_EVAL
  JP __GOSUB_0

; Routine at 2334
__GOSUB:
  LD C,$03
  CALL CHKSTK
  POP BC
  PUSH HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  LD BC,L0000
  PUSH BC
  LD BC,EXEC_EVAL
  LD A,$8C
  PUSH AF
  INC SP
; This entry point is used by the routine at __RUN.
__GOSUB_0:
  PUSH BC

; Routine at 2358
;
; Used by the routine at __IF.
__GOTO:
  CALL ATOH
; This entry point is used by the routine at __RESUME.
__GOTO_0:
  CALL __ELSE
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  RST CPDEHL
  POP HL
  CALL C,FIND_LINE_FHL
  CALL NC,FIND_LINE
  LD H,B
  LD L,C
  DEC HL
  RET C

; entry for '?UL ERROR'
;
; Used by the routines at EXEC_HL, ON_ERROR and __RESTORE.
ULERR:
  LD E,$08
  JP ERROR
; This entry point is used by the routine at CLR_ALLINT.
ULERR_0:
  PUSH HL
  PUSH HL
  LD HL,(CURLIN)
  EX (SP),HL
  PUSH BC
  LD A,$8C
  PUSH AF
  INC SP
  EX DE,HL
  DEC HL
  LD (SAVTXT),HL
  INC HL
  JP EXEC_EVAL_2

; Routine at 2406
__RETURN:
  RET NZ
  LD D,$FF
  CALL NEXT_UNSTACK
  CP $8C
  JP Z,__RETURN_0
  DEC HL
__RETURN_0:
  LD SP,HL
  LD ($FB9D),HL
  LD E,$03
  JP NZ,ERROR
  POP HL
  LD A,H
  OR L
  JP Z,__RETURN_1
  LD A,(HL)
  AND $01
  CALL NZ,TIME_S_STOP_1
__RETURN_1:
  POP HL
  LD (CURLIN),HL
  INC HL
  LD A,H
  OR L
  JP NZ,__RETURN_2
  LD A,($FB97)
  OR A
  JP NZ,RESTART
__RETURN_2:
  LD HL,EXEC_EVAL
  EX (SP),HL
  LD A,$E1

; DATA statement: find next DATA program line..
;
; Used by the routines at __FOR, __RESUME, __IF and FDTLP.
__DATA:
  LD BC,$0E3A

; Routine at 2464
;
; Used by the routine at __GOTO.
__ELSE:
  LD C,$00
  LD B,$00
__ELSE_0:
  LD A,C
  LD C,B
  LD B,A
__ELSE_1:
  LD A,(HL)
  OR A
  RET Z
  CP B
  RET Z
  INC HL
  CP $22
  JP Z,__ELSE_0
  SUB $8A
  JP NZ,__ELSE_1
  CP B
  ADC A,D
  LD D,A
  JP __ELSE_1
  POP AF
  ADD A,$03
  JP __LET_0

; Perform the variable assignment in the buffer pointed to by HL.
;
; Used by the routines at __FOR and STATEMENT.
__LET:
  CALL GETVAR
  RST SYNCHR
  DEFB $DD
  EX DE,HL
  LD (TEMP),HL
  EX DE,HL
  PUSH DE
  LD A,(VALTYP)
  PUSH AF
  CALL EVAL
  POP AF
; This entry point is used by the routines at __ELSE and __LINE.
__LET_0:
  EX (SP),HL
; This entry point is used by the routine at __READ.
__LET_1:
  LD B,A
  LD A,(VALTYP)
  CP B
  LD A,B
  JP Z,__LET_2
  CALL LDA_FAC1_0
  LD A,(VALTYP)
__LET_2:
  LD DE,FACCU
  CP $02
  JP NZ,__LET_3
  LD DE,DBL_FPREG
__LET_3:
  PUSH HL
  CP $03
  JP NZ,__LET_6
  LD HL,(DBL_FPREG)
  PUSH HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,$F684
  RST CPDEHL
  JP C,$0A1D
  LD HL,(ARREND)
  RST CPDEHL
  POP DE
  JP NC,__LET_5
  LD HL,$FB88
  RST CPDEHL
  JP C,__LET_4
  LD HL,$FB6A
  RST CPDEHL
  JP C,__LET_5
__LET_4:
  LD A,$D1
  CALL GSTRDE_1
  EX DE,HL
  CALL SAVSTR_0
__LET_5:
  CALL GSTRDE_1
  EX (SP),HL
__LET_6:
  CALL HL_FAC2_0
  POP DE
  POP HL
  RET

; Routine at 2607
__ON:
  CP $94
  JP NZ,ON_ERROR_1

; Routine at 2612
ON_ERROR:
  RST CHRGTB
  RST SYNCHR
  ADC A,B
  CALL ATOH
  LD A,D
  OR E
  JP Z,ON_ERROR_0
  CALL PHL_FIND_LINE
  LD D,B
  LD E,C
  POP HL
  JP NC,ULERR
ON_ERROR_0:
  EX DE,HL
  LD (ONELIN),HL
  EX DE,HL
  RET C
  LD A,($FBA7)
  OR A
  LD A,E
  RET Z
  LD A,(ERR_CODE)
  LD E,A
  JP RETERR_0
; This entry point is used by the routine at __ON.
ON_ERROR_1:
  CALL KEY_STMTS_3
  JP C,ON_ERROR_4
  PUSH BC
  RST CHRGTB
  RST SYNCHR
  ADC A,H
  XOR A
ON_ERROR_2:
  POP BC
  PUSH BC
  CP C
  JP NC,SNERR
  PUSH AF
  CALL ATOH
  LD A,D
  OR E
  JP Z,ON_ERROR_3
  CALL PHL_FIND_LINE
  LD D,B
  LD E,C
  POP HL
  JP NC,ULERR
ON_ERROR_3:
  POP AF
  POP BC
  PUSH AF
  ADD A,B
  PUSH BC
  CALL ON_TIME_S_0
  DEC HL
  RST CHRGTB
  POP BC
  POP DE
  RET Z
  PUSH BC
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  POP AF
  INC A
  JP ON_ERROR_2
ON_ERROR_4:
  CALL GETINT
  LD A,(HL)
  LD B,A
  CP $8C
  JP Z,ON_ERROR_5
  RST SYNCHR
  ADC A,B
  DEC HL
ON_ERROR_5:
  LD C,E
ON_ERROR_6:
  DEC C
  LD A,B
  JP Z,STATEMENT
  CALL ATOH_2
  CP $2C
  RET NZ
  JP ON_ERROR_6

; Routine at 2736
__RESUME:
  LD A,($FBA7)
  OR A
  JP NZ,__RESUME_0
  LD (ONELIN),A
  LD ($FBA6),A
  JP RWERR
__RESUME_0:
  INC A
  LD (ERR_CODE),A
  LD A,(HL)
  CP $82
  JP Z,__RESUME_1
  CALL ATOH
  RET NZ
  LD A,D
  OR E
  JP Z,__RESUME_2
  CALL __GOTO_0
  XOR A
  LD ($FBA7),A
  RET
__RESUME_1:
  RST CHRGTB
  RET NZ
  JP __RESUME_3
__RESUME_2:
  XOR A
  LD ($FBA7),A
  INC A
__RESUME_3:
  LD HL,(ERRTXT)
  EX DE,HL
  LD HL,(ERRLIN)
  LD (CURLIN),HL
  EX DE,HL
  RET NZ
  LD A,(HL)
  OR A
  JP NZ,__RESUME_4
  INC HL
  INC HL
  INC HL
  INC HL
__RESUME_4:
  INC HL
  LD A,D
  AND E
  INC A
  JP NZ,__RESUME_5
  LD A,($FB97)
  DEC A
  JP Z,$40B3
__RESUME_5:
  XOR A
  LD ($FBA7),A
  JP __DATA

; Routine at 2831
__ERROR:
  CALL GETINT
  RET NZ
  OR A
  JP Z,FCERR
  JP ERROR

; Routine at 2842
__IF:
  CALL EVAL
  LD A,(HL)
  CP $2C
  CALL Z,_CHRGTB
  CP $88
  JP Z,$0B2B
  RST SYNCHR
  CALL $E52B
  CALL __TSTSGN
  POP HL
  JP Z,__IF_1
__IF_0:
  RST CHRGTB
  JP C,__GOTO
  JP EXEC_0
__IF_1:
  LD D,$01
__IF_2:
  CALL __DATA
  OR A
  RET Z
  RST CHRGTB
  CP $91
  JP NZ,__IF_2
  DEC D
  JP NZ,__IF_2
  JP __IF_0

; Routine at 2894
__LPRINT:
  LD A,$01
  LD (PRTFLG),A
  JP __PRINT_0

; Routine at 2902
__PRINT:
  LD C,$02
  CALL INIT_PRINT_h_4
  CP $40
  CALL Z,LINE_GFX_16
; This entry point is used by the routine at __LPRINT.
__PRINT_0:
  DEC HL
  RST CHRGTB
  CALL Z,CONSOLE_CRLF_0
; This entry point is used by the routine at TAB.
__PRINT_1:
  JP Z,TAB_5
  CP $C2		; USING
  JP Z,USING
  CP $C0
  JP Z,TAB
  PUSH HL
  CP $2C
  JP Z,__PRINT_6
  CP $3B
  JP Z,TAB_4
  POP BC
  CALL EVAL
  PUSH HL
  RST GETYPR
  JP Z,__PRINT_5
  CALL FOUT
  CALL CRTST
  LD (HL),$20
  LD HL,(DBL_FPREG)
  INC (HL)
  CALL RINPUT
  JP NZ,__PRINT_4
  LD HL,(DBL_FPREG)
  LD A,(PRTFLG)
  OR A
  JP Z,__PRINT_2
  LD A,(LPT_POS)
  ADD A,(HL)
  CP $FF
  JP __PRINT_3
__PRINT_2:
  LD A,(ACTV_Y)
  LD B,A
  INC A
  JP Z,__PRINT_4
  LD A,(TTYPOS)
  ADD A,(HL)
  DEC A
  CP B
__PRINT_3:
  JP C,__PRINT_4
  CALL Z,CONSOLE_CRLF_1
  CALL NZ,CONSOLE_CRLF_0
__PRINT_4:
  CALL PRS1
  OR A
__PRINT_5:
  CALL Z,PRS1
  POP HL
  JP __PRINT_0
__PRINT_6:
  LD BC,SYNCHR
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL RINPUT
  LD A,(HL)
  JP NZ,__PRINT_9
  LD A,(PRTFLG)
  OR A
  JP Z,__PRINT_7
  LD A,(LPT_POS)
  CP $EE
  JP __PRINT_8
__PRINT_7:
  LD A,($F676)
  LD B,A
  LD A,(TTYPOS)
  CP B
__PRINT_8:
  CALL NC,CONSOLE_CRLF_0
  JP NC,TAB_4
__PRINT_9:
  SUB $0E
  JP NC,__PRINT_9
  CPL
  JP TAB_2

; Routine at 3073
;
; Used by the routine at __PRINT.
TAB:
  CALL FNDNUM
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  DEC HL
  PUSH HL
  LD BC,SYNCHR
  LD HL,(PTRFIL)
  ADD HL,BC
  CALL RINPUT
  LD A,(HL)
  JP NZ,TAB_1
  LD A,(PRTFLG)
  OR A
  JP Z,TAB_0
  LD A,(LPT_POS)
  JP TAB_1
TAB_0:
  LD A,(TTYPOS)
TAB_1:
  CPL
  ADD A,E
  JP NC,TAB_4
; This entry point is used by the routine at __PRINT.
TAB_2:
  INC A
  LD B,A
  LD A,' '
TAB_3:
  RST OUTC
  DEC B
  JP NZ,TAB_3
; This entry point is used by the routine at __PRINT.
TAB_4:
  POP HL
  RST CHRGTB
  JP __PRINT_1
; This entry point is used by the routines at __PRINT, __READ, SETMAX and
; USING.
TAB_5:
  XOR A
  LD (PRTFLG),A
  PUSH HL
  LD H,A
  LD L,A
  LD (PTRFIL),HL
  POP HL
  RET

; Routine at 3141
__LINE:
  CP $84		; TK_INPUT, Token for INPUT to support the "LINE INPUT" statement
  JP NZ,LINE_GFX
  RST CHRGTB
  CP '#'
  JP Z,LINE_INPUT
  CALL CHK_RUNNING
  LD A,(HL)
  CALL __INPUT_0
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  PUSH HL
  CALL INLIN
  POP DE
  POP BC
  JP C,$40B3	; 	__END_1 - 3
  PUSH BC
  PUSH DE
  LD B,$00
  CALL QTSTR_0	; Eval quoted string
  POP HL
  LD A,$03		; cp VALTYP to String type
  JP __LET_0

; text at $0C74
REDO_MSG:
  DEFM "?Redo from start"
  DEFB CR, LF, $00
  
; This entry point is used by the routine at __READ.
__LINE_0:
  LD A,(FLGINP)
  OR A
  JP NZ,DATSNR
  POP BC
  LD HL,REDO_MSG
  CALL PRS
  LD HL,(SAVTXT)
  RET

; Routine at 3225
;
; Used by the routine at __INPUT.
INPUT_h:
  CALL INIT_PRINT_h_3
  PUSH HL
  LD HL,$F684
  JP __INPUT_1

; Routine at 3235
__INPUT:
  CALL CHK_RUNNING
  LD A,(HL)
  CP '#'
  JP Z,INPUT_h
  CALL CHK_RUNNING
  LD A,(HL)
  LD BC,$0CC4
  PUSH BC
; This entry point is used by the routine at __LINE.
__INPUT_0:
  CP $22
  LD A,$00
  RET NZ
  CALL QTSTR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ';'
  PUSH HL
  CALL PRS1
  POP HL
  RET
  PUSH HL
  CALL QINLIN
  POP BC
  JP C,$40B3
  INC HL
  LD A,(HL)
  OR A
  DEC HL
  PUSH BC
  JP Z,$099D
; This entry point is used by the routine at INPUT_h.
__INPUT_1:
  LD (HL),$2C
  JP $0CDE

; Routine at 3289
__READ:
  PUSH HL
  LD HL,(DATPTR)
  OR $AF
  LD (FLGINP),A
  EX (SP),HL
  JP __READ_1
__READ_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
__READ_1:
  CALL GETVAR
  EX (SP),HL
  PUSH DE
  LD A,(HL)
  CP $2C
  JP Z,__READ_3
; This entry point is used by the routine at __LINE.
__READ_2:
  LD A,(FLGINP)
  OR A
  JP NZ,FDTLP
  LD A,'?'
  RST OUTC
  CALL QINLIN
  POP DE
  POP BC
  JP C,$40B3
  INC HL
  LD A,(HL)
  DEC HL
  OR A
  PUSH BC
  JP Z,$099D
  PUSH DE
; This entry point is used by the routine at FDTLP.
__READ_3:
  CALL RINPUT
  JP NZ,L4F2E_2
  RST GETYPR
  PUSH AF
  JP NZ,__READ_6
  RST CHRGTB
  LD D,A
  LD B,A
  CP $22
  JP Z,__READ_5
  LD A,(FLGINP)
  OR A
  LD D,A
  JP Z,__READ_4
  LD D,$3A
__READ_4:
  LD B,$2C
  DEC HL
__READ_5:
  CALL DTSTR
  POP AF
  ADD A,$03
  EX DE,HL
  LD HL,$0D45
  EX (SP),HL
  PUSH DE
  JP __LET_1
__READ_6:
  RST CHRGTB
  LD BC,$0D31
  PUSH BC
  JP DBL_ASCTFP
  DEC HL
; This entry point is used by the routine at INLIN.
__READ_7:
  RST CHRGTB
  JP Z,__READ_8
  CP $2C
  JP NZ,__LINE_0
__READ_8:
  EX (SP),HL
  DEC HL
  RST CHRGTB
  JP NZ,__READ_0
  POP DE
  LD A,(FLGINP)
  OR A
  EX DE,HL
  JP NZ,__RESTORE_1
  PUSH DE
  CALL RINPUT
  JP NZ,__READ_9
  LD A,(HL)
  OR A
  LD HL,$0D71
  CALL NZ,PRS
__READ_9:
  POP HL
  JP TAB_5
  CCF
  LD B,L
  LD A,B
  LD (HL),H
  LD (HL),D
  LD H,C
  JR NZ,EVAL3_1
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
; Used by the routine at __READ.
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
  RST CHRGTB
  CP $83
  JP NZ,FDTLP
  JP __READ_3
; This entry point is used by the routine at INSTR.
FDTLP_1:
  RST SYNCHR
  DEFB $DD
  JP EVAL

; Chk Syntax, make sure '(' follows
;
; Used by the routines at VARPTR_VAR, UCASE and INSTR.
OPNPAR:
  RST SYNCHR
  JR Z,$0DD7

; a.k.a. GETNUM, evaluate expression
;
; Used by the routines at TO, STEP, __LET, __IF, __PRINT, FDTLP, FPSINT,
; GETINT, GETWORD, __DAY_S, OUTS_B_CHARS, STRING_S, INSTR, USING and FNAME.
EVAL:
  DEC HL

; (a.k.a. GETNUM, evaluate expression (GETNUM)
;
; Used by the routines at STEP and USING.
L0DAC:
  LD D,$00

; Save precedence and eval until precedence break
;
; Used by the routines at EVAL3, VARPTR_VAR and NOT.
L0DAE:
  PUSH DE

; Save precedence and eval until precedence break
EVAL1:
  LD C,$01
  CALL CHKSTK
  CALL OPRND

; Evaluate expression until precedence break
EVAL2:
  LD (NXTOPR),HL

; Evaluate expression until precedence break
;
; Used by the routine at NOT.
L0DBA:
  LD HL,(NXTOPR)

; Evaluate expression until precedence break
EVAL3:
  POP BC
  LD A,(HL)
  LD (TEMP3),HL
  CP $D0
  RET C				; Token for '>'
  CP $DF
  RET NC
  CP $DC
  JP NC,EVAL3_5
  SUB $D0
  LD E,A
  JP NZ,EVAL3_0
  LD A,(VALTYP)
  CP $03				; String ?
  LD A,E
  JP Z,CONCAT
EVAL3_0:
  LD HL,$02E2
  LD D,$00
  ADD HL,DE
; This entry point is used by the routine at __READ.
EVAL3_1:
  LD A,B
  LD D,(HL)
  CP D
  RET NC
  PUSH BC
  LD BC,L0DBA
  PUSH BC
  LD A,D
  CP $51
  JP C,EVAL3_7
  AND $FE
  CP $7A
  JP Z,EVAL3_7
EVAL3_2:
  LD HL,DBL_FPREG
  LD A,(VALTYP)
  SUB $03
  JP Z,TMERR
  OR A
  LD HL,(DBL_FPREG)
  PUSH HL
  JP M,EVAL3_3
  LD HL,(FACCU)
  PUSH HL
  JP PO,EVAL3_3
  LD HL,($FC1E)
  PUSH HL
  LD HL,($FC1C)
  PUSH HL
EVAL3_3:
  ADD A,$03
  LD C,E
  LD B,A
  PUSH BC
  LD BC,$0E6C
EVAL3_4:
  PUSH BC
  LD HL,(TEMP3)
  JP L0DAE
EVAL3_5:
  LD D,$00
EVAL3_6:
  SUB $DC
  JP C,EVAL3_8
  CP $03
  JP NC,EVAL3_8
  CP $01
  RLA
  XOR D
  CP D
  LD D,A
  JP C,SNERR
  LD (TEMP3),HL
  RST CHRGTB
  JP EVAL3_6
EVAL3_7:
  PUSH DE
  CALL __CINT
  POP DE
  PUSH HL
  LD BC,$1072
  JP EVAL3_4
EVAL3_8:
  LD A,B
  CP $64
  RET NC
  PUSH BC
  PUSH DE
  LD DE,$6405
  LD HL,$1047
  PUSH HL
  RST GETYPR
  JP NZ,EVAL3_2
  LD HL,(DBL_FPREG)
  PUSH HL
  LD BC,$270C
  JP EVAL3_4
  POP BC
  LD A,C
  LD (OPRTYP),A
  LD A,(VALTYP)
  CP B
  JP NZ,EVAL3_9
  CP $02
  JP Z,EVAL3_10
  CP $04
  JP Z,EVAL3_18
  JP NC,EVAL3_12
EVAL3_9:
  LD D,A
  LD A,B
  CP $08
  JP Z,EVAL3_11
  LD A,D
  CP $08
  JP Z,EVAL3_16
  LD A,B
  CP $04
  JP Z,EVAL3_17
  LD A,D
  CP $03
  JP Z,TMERR
  JP NC,EVAL3_20
EVAL3_10:
  LD HL,$0310
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
EVAL3_11:
  CALL __CDBL
EVAL3_12:
  CALL REV_LDDR_B_2
  POP HL
  LD ($FC1C),HL
  POP HL
  LD ($FC1E),HL
EVAL3_13:
  POP BC
  POP DE
  CALL FPBCDE
EVAL3_14:
  CALL __CDBL
  LD HL,$02F8
EVAL3_15:
  LD A,(OPRTYP)
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
EVAL3_16:
  LD A,B
  PUSH AF
  CALL REV_LDDR_B_2
  POP AF
  LD (VALTYP),A
  CP $04
  JP Z,EVAL3_13
  POP HL
  LD (DBL_FPREG),HL
  JP EVAL3_14
EVAL3_17:
  CALL __CSNG
EVAL3_18:
  POP BC
  POP DE
EVAL3_19:
  LD HL,$0304
  JP EVAL3_15
EVAL3_20:
  POP HL
  CALL STAKI
  CALL HL_CSNG
  CALL BCDEFP
  POP HL
  LD (FACCU),HL
  POP HL
  LD (DBL_FPREG),HL
  JP EVAL3_19

; Integer Divide (FAC1=DE/HL)
IDIV:
  PUSH HL
  EX DE,HL
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  JP FMULT_0

; Get next expression value
;
; Used by the routines at EVAL1 and CONCAT.
OPRND:
  RST CHRGTB
  JP Z,MOERR
  JP C,DBL_ASCTFP
  CALL IS_ALPHA_A
  JP NC,VAR_EVAL
  CP $D0
  JP Z,OPRND
  CP $2E
  JP Z,DBL_ASCTFP
  CP $D1
  JP Z,VARPTR_VAR_3
  CP $22
  JP Z,QTSTR
  CP $CE
  JP Z,NOT
  CP $C5
  JP NZ,ERR_0

; ERR Function
ERR:
  RST CHRGTB
  LD A,(ERR_CODE)
  PUSH HL
  CALL LDA_FAC1
  POP HL
  RET
; This entry point is used by the routine at OPRND.
ERR_0:
  CP $C4
  JP NZ,ERL_0

; ERRL Function
ERL:
  RST CHRGTB
  PUSH HL
  LD HL,(ERRLIN)
  CALL DBL_ABS_0
  POP HL
  RET
; This entry point is used by the routine at ERR.
ERL_0:
  CP $AA
  JP Z,TIME_S_FN
  CP $AB
  JP Z,DATE_S_FN
  CP $AC
  JP Z,DAY_S_FN
  CP $B7
  JP Z,MAX_FN
  CP $CC
  JP Z,L1DB9
  CP $C3
  JP NZ,VARPTR_VAR_1

; VARPTR Function
VARPTR:
  RST CHRGTB
  RST SYNCHR
VARPTR_0:
  JR Z,VARPTR_0
  INC HL
  JP NZ,VARPTR_VAR

; VARPTR(#buffer) Function
VARPTR_BUF:
  CALL FNDNUM
  PUSH HL
  CALL VARPTR_A
  EX DE,HL
  POP HL
  JP VARPTR_VAR_0

; VARPTR(variable) Function
;
; Used by the routine at VARPTR.
VARPTR_VAR:
  CALL GETVAR_8
; This entry point is used by the routine at VARPTR_BUF.
VARPTR_VAR_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  PUSH HL
  EX DE,HL
  LD A,H
  OR L
  JP Z,FCERR
  CALL HL_FAC1
  POP HL
  RET
; This entry point is used by the routine at ERL.
VARPTR_VAR_1:
  CP $C7
  JP Z,INSTR
  CP $C9
  JP Z,INKEY_S
  CP $C6
  JP Z,STRING_S
  CP $84
  JP Z,INPUT_S
  CP $CA
  JP Z,CSRLIN
  CP $C8
  JP Z,DSKI_S
  SUB $DF
  JP NC,UCASE_0
; This entry point is used by the routine at UCASE.
VARPTR_VAR_2:
  CALL OPNPAR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  RET
; This entry point is used by the routine at OPRND.
VARPTR_VAR_3:
  LD D,$7D
  CALL L0DAE
  LD HL,(NXTOPR)
  PUSH HL
  CALL INVSGN
  POP HL
  RET

; Variable evaluation routine
;
; Used by the routine at OPRND.
VAR_EVAL:
  CALL GETVAR
  PUSH HL
  EX DE,HL
  LD (DBL_FPREG),HL
  RST GETYPR
  CALL NZ,REV_LDDR_B_1
  POP HL
  RET

; Get char from (HL) and make upper case
;
; Used by the routines at SETSER, __DAY_S, FNAME, DSKI_S, FIND_TEXT and
; LOAD_BA_LBL.
UCASE_HL:
  LD A,(HL)

; Make char in 'A' upper case
;
; Used by the routines at __DAY_S, TEL_SET_STAT, TEL_BYE, FIND_TEXT, IS_CRLF and
; CHGET_UCASE.
UCASE:
  CP $61
  RET C
  CP $7B
  RET NC
  AND $5F
  RET
; This entry point is used by the routine at VARPTR_VAR.
UCASE_0:
  LD B,$00
  RLCA
  LD C,A
  PUSH BC
  RST CHRGTB
  LD A,C
  CP $39
  JP C,UCASE_1
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
UCASE_1:
  CALL VARPTR_VAR_2
  EX (SP),HL
  LD A,L
  CP $0E
  JP C,UCASE_2
  CP $1D
  JP NC,UCASE_2
  RST GETYPR
  PUSH HL
  CALL C,__CDBL
  POP HL
UCASE_2:
  LD DE,$0FD8
  PUSH DE
UCASE_3:
  LD BC,FNCTAB_FN
; This entry point is used by the routine at LDA_FAC1.
UCASE_4:
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  JP (HL)
; This entry point is used by the routine at _ASCTFP.
UCASE_5:
  DEC D
  CP $D1
  RET Z
  CP $2D
  RET Z
  INC D
  CP $2B
  RET Z
  CP $D0
  RET Z

; Routine at 4165
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

; Routine at 4180
;
; Used by the routine at OPRND.
NOT:
  LD D,$5A
  CALL L0DAE
  CALL __CINT
  LD A,L
  CPL
  LD L,A
  LD A,H
  CPL
  LD H,A
  LD (DBL_FPREG),HL
  POP BC
; This entry point is used by the routine at DCXH.
NOT_0:
  JP L0DBA

; RST 28H routine.  Return the number type (FAC)
;
; Used by the routine at GETYPR.
_GETYPR:
  LD A,(VALTYP)
  CP $08
  DEC A
  DEC A
  DEC A
  RET
  LD A,B
  PUSH AF
  CALL __CINT
  POP AF
  POP DE
  CP $7A
  JP Z,IMOD
  CP $7B
  JP Z,INT_DIV
  LD BC,$10D3
  PUSH BC
  
  CP $46
  JP NZ,OR_0

; OR Function
OR:
  LD A,E
  OR L
  LD L,A
  LD A,H
  OR D
  RET
; This entry point is used by the routine at _GETYPR.
OR_0:
  CP $50
  JP NZ,AND_0

; AND Function
AND:
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET
; This entry point is used by the routine at OR.
AND_0:
  CP $3C
  JP NZ,XOR_0

; XOR Function
XOR:
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET
; This entry point is used by the routine at AND.
XOR_0:
  CP $32
  JP NZ,IMP

; EQV Function
EQV:
  LD A,E
  XOR L
  CPL
  LD L,A
  LD A,H
  XOR D
  CPL
  RET

; IMP Function
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

; LPOS Function
__LPOS:
  LD A,(LPT_POS)
  JP LDA_FAC1

; POS Function
__POS:
  LD A,(TTYPOS)

; Load the integer in the A register into FAC1.
;
; Used by the routines at ERR, __LPOS, __INP, __PEEK and __VAL.
LDA_FAC1:
  LD L,A
  XOR A
  LD H,A
  JP HL_FAC1
; This entry point is used by the routine at __LET.
LDA_FAC1_0:
  PUSH HL
  AND $07
  LD HL,MATH_OP
  LD C,A
  LD B,$00
  ADD HL,BC
  CALL UCASE_4
  POP HL
  RET

; Check for a running program (Z if so).  If a program is not running, generate
; an Illegal Direct (ID) error.
;
; Used by the routines at __LINE and __INPUT.
CHK_RUNNING:
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  RET NZ

; ID error: illegal immediate instruction
IDERR:
  LD E,$0C
  JP ERROR
; This entry point is used by the routine at STATEMENT.
IDERR_0:
  CP $7E
  JP NZ,SNERR
  INC HL
  JP INSTR_7
  JP SNERR

; INP Function
__INP:
  CALL MAKINT
  LD (INPORT),A
  CALL _INP
  JP LDA_FAC1

; Routine at 4364
__OUT:
  CALL DEPINT_0
  JP _OUT

; Get subscript
;
; Used by the routines at STEP and LINE_GFX.
L1112:
  RST CHRGTB

; Same as 1112H except that the evalutation starts at HL-1
;
; Used by the routine at DECLVAR.
FPSINT:
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
; This entry point is used by the routine at __OUT.
DEPINT_0:
  CALL GETINT
  LD (INPORT),A
  LD (OTPORT),A
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JP GETINT

; Load 'A' with the next number in BASIC program
;
; Used by the routines at TAB, VARPTR_BUF and L4F2E.
FNDNUM:
  RST CHRGTB

; Get a number to 'A'
;
; Used by the routines at ON_ERROR, __ERROR, UCASE, DEPINT, __POKE, POWER_ON,
; __DATE_S, __MDM, OUTS_B_CHARS, LINE_GFX, __SOUND, __CALL, __SCREEN, INSTR,
; VARPTR_A, __OPEN, __CLOSE, INPUT_S, TEL_SET_STAT, UPLDR, TXT_CTL_Y and __MAX.
GETINT:
  CALL EVAL

; Convert tmp string to int in A register
;
; Used by the routines at __INP, __CHR_S, STRING_S, __SPACE_S, INSTR and FNAME.
MAKINT:
  CALL DEPINT
  JP NZ,FCERR
  DEC HL
  RST CHRGTB
  LD A,E
  RET

; Routine at 4411
__LLIST:
  LD A,$01
  LD (PRTFLG),A

; Routine at 4416
;
; Used by the routines at __SAVE and __EDIT.
__LIST:
  POP BC
  CALL UPD_PTRS_2
  PUSH BC
  LD H,B
  LD L,C
  LD (LBLIST),HL
__LIST_0:
  LD HL,$FFFF
  LD (CURLIN),HL
  POP HL
  LD ($FABC),HL
  POP DE
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,B
  OR C
  JP Z,__LIST_3
  CALL RINPUT
  CALL Z,CHSNS_0
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
  JP C,__LIST_2
  EX (SP),HL
  PUSH HL
  PUSH BC
  EX DE,HL
  LD (DOT),HL
  CALL NUMPRT
  POP HL
  LD A,(HL)
  CP $09
  JP Z,__LIST_1
  LD A,' '
  RST OUTC
__LIST_1:
  CALL PRS_M100_0
  LD HL,KBUF
  CALL PRS_M100
  CALL CONSOLE_CRLF_0
  JP __LIST_0
__LIST_2:
  POP BC
__LIST_3:
  LD A,($F651)
  AND A
  JP NZ,__EDIT_1
  LD A,$1A
  RST OUTC
  JP READY

; print zero terminated string
;
; Used by the routine at __LIST.
PRS_M100:
  LD A,(HL)
  OR A
  RET Z
  RST OUTC
  INC HL
  JP PRS_M100
; This entry point is used by the routine at __LIST.
PRS_M100_0:
  LD BC,KBUF
  LD D,$FF
  XOR A
  LD (OPRTYP),A
  JP PRS_M100_2
PRS_M100_1:
  INC BC
  DEC D
  RET Z
PRS_M100_2:
  LD A,(HL)
  INC HL
  OR A
  LD (BC),A
  RET Z
  CP $22
  JP NZ,PRS_M100_3
  LD A,(OPRTYP)
  XOR $01
  LD (OPRTYP),A
  LD A,$22
PRS_M100_3:
  CP $3A
  JP NZ,PRS_M100_5
  LD A,(OPRTYP)
  RRA
  JP C,PRS_M100_4
  RLA
  AND $FD
  LD (OPRTYP),A
PRS_M100_4:
  LD A,$3A
PRS_M100_5:
  OR A
  JP P,PRS_M100_1
  LD A,(OPRTYP)
  RRA
  JP C,PRS_M100_1
  DEC HL
  RRA
  RRA
  JP NC,PRS_M100_11
  LD A,(HL)
  CP $FF
  PUSH HL
  PUSH BC
  LD HL,$121A
  PUSH HL
  RET NZ
  DEC BC
  LD A,(BC)
  CP $4D
  RET NZ
  DEC BC
  LD A,(BC)
  CP $45
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
; This entry point is used by the routine at FONT.
PRS_M100_6:
  POP HL
  INC D
  INC D
  INC D
  INC D
  JP PRS_M100_12
  POP BC
  POP HL
  LD A,(HL)
PRS_M100_7:
  INC HL
  JP PRS_M100_1
PRS_M100_8:
  LD A,(OPRTYP)
  OR $02
PRS_M100_9:
  LD (OPRTYP),A
  XOR A
  RET
PRS_M100_10:
  LD A,(OPRTYP)
  OR $04
  JP PRS_M100_9
PRS_M100_11:
  RLA
  JP C,PRS_M100_7
  LD A,(HL)
  CP $83
  CALL Z,PRS_M100_8
  CP $8E
  CALL Z,PRS_M100_10
PRS_M100_12:
  LD A,(HL)
  INC HL
  CP $91
  CALL Z,TSTSTR_6
  SUB $7F
  PUSH HL
  LD E,A
  LD HL,TOKEN
PRS_M100_13:
  LD A,(HL)
  INC HL
  OR A
  JP P,PRS_M100_13
  DEC E
  JP NZ,PRS_M100_13
  AND $7F
PRS_M100_14:
  LD (BC),A
  INC BC
  DEC D
  JP Z,TESTR_0
  LD A,(HL)
  INC HL
  OR A
  JP P,PRS_M100_14
  POP HL
  JP PRS_M100_2
; This entry point is used by the routine at EXEC_HL.
PRS_M100_15:
  EX DE,HL
  LD HL,(PROGND)
PRS_M100_16:
  LD A,(DE)
  LD (BC),A
  INC BC
  INC DE
  RST CPDEHL
  JP NZ,PRS_M100_16
  LD H,B
  LD L,C
  LD (PROGND),HL
  LD (VAREND),HL
  LD (ARREND),HL
  RET

; Routine at 4740
__PEEK:
  CALL GETWORD_0
  LD A,(HL)
  JP LDA_FAC1

; Routine at 4747
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
; Used by the routines at __POKE, __SOUND, __CALL, CSAVEM and __CLEAR.
GETWORD:
  CALL EVAL
  PUSH HL
  CALL GETWORD_0
  EX DE,HL
  POP HL
  RET
; This entry point is used by the routine at __PEEK.
GETWORD_0:
  LD BC,__CINT
  PUSH BC
  RST GETYPR
  RET M
  RST TSTSGN
  RET M
  CALL __CSNG
  LD BC,POP_FAC2
  LD DE,$8076
  CALL BCDE_FP_CMP
  RET C
  LD BC,$6545
  LD DE,$6053
  CALL BCDE_FP_CMP
  JP NC,OVERR
  LD BC,$65C5
  LD DE,$6053
  JP DBL_ABS_2

; A = Character (wait if no char, FN keys are remapped)  CY if special keys
;
; Used by the routines at INLIN, INKEY_S, INPUT_S, TEL_TERM, TEL_PREV, UPLDR,
; IS_CRLF, CHGET_UCASE, WAIT_SPC, MCLEAR, TXT_CTL_N and MOVE_TEXT.
CHGET:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL CHGET_0
  JP POPALL_0
CHGET_0:
  RST $38
  INC B
  LD HL,(FNKMAC)
  INC H
  DEC H
  JP Z,CHGET_4
  LD B,(HL)
  LD A,B
  OR A
  JP Z,CHGET_1
  INC HL
  LD A,(HL)
  OR A
  JP NZ,CHGET_2
CHGET_1:
  LD H,A
CHGET_2:
  LD (FNKMAC),HL
  LD A,B
  RET
CHGET_3:
  LD A,($F650)
  ADD A,A
  RET C
  LD HL,L0000
  LD ($F62E),HL
  LD A,$0D
  LD ($FAA1),A
CHGET_4:
  LD HL,($F62E)
  LD A,L
  AND H
  INC A
  JP Z,CHGET_6
  PUSH HL
  LD A,($FAA1)
  CP $0D
  CALL Z,RESFPT
  LD HL,(HAYASHI)
  POP DE
  ADD HL,DE
  LD A,(HL)
  LD ($FAA1),A
  LD B,A
  CP $1A
  LD A,$00
  JP Z,CHGET_5
  CALL KEYX
  JP C,CHGET_5
  INC HL
  LD A,(HL)
  EX DE,HL
  INC HL
  LD ($F62E),HL
  CP $1A
  LD A,B
  SCF
  CCF
  RET NZ
CHGET_5:
  LD HL,$FFFF
  LD ($F62E),HL
  RET
CHGET_6:
  CALL CHSNS
  JP NZ,CHGET_8
  CALL FNBAR_TOGGLE_3
  LD A,$FF
  LD (POWR_FLAG),A
CHGET_7:
  CALL CHSNS
  JP Z,CHGET_7
  XOR A
  LD (POWR_FLAG),A
  CALL FNBAR_TOGGLE_4
CHGET_8:
  LD HL,$F932
  LD A,(HL)
  AND A
  JP NZ,FNBAR_TOGGLE_1
  CALL _RST75_6
  CALL KYREAD
  RET NC
  SUB $0B
  JP Z,CHGET_3
  JP NC,FNBAR_TOGGLE_2
  INC A
  JP Z,CHGET_10
  INC A
  JP Z,__LCOPY
  INC A
  JP Z,FNBAR_TOGGLE
  LD E,A
  LD A,($F650)
  ADD A,A
  ADD A,A
  LD A,E
  RET C
  LD D,$FF
  EX DE,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$F809
  ADD HL,DE
  LD A,($F650)
  AND A
  JP P,CHGET_9
  INC HL
  INC HL
  INC HL
  INC HL
CHGET_9:
  LD (FNKMAC),HL
  JP CHGET_0
CHGET_10:
  LD HL,($F88A)
  JP CHGET_9

; Toggle function key label line if enabled.
;
; Used by the routine at CHGET.
FNBAR_TOGGLE:
  LD A,(LBL_LINE)
  AND A
  RET Z
  LD A,(LABEL_LN)
  XOR $FF
; This entry point is used by the routine at __SCREEN.
FNBAR_TOGGLE_0:
  JP Z,ERAFNK
  JP DSPFNK
; This entry point is used by the routine at CHGET.
FNBAR_TOGGLE_1:
  DI
  LD (HL),$00
  LD A,($F657)
  DEC HL
  LD (HL),A
  CALL TURN_OFF
; This entry point is used by the routine at CHGET.
FNBAR_TOGGLE_2:
  XOR A
  RET
; This entry point is used by the routines at CHGET and CHSNS.
FNBAR_TOGGLE_3:
  LD A,(CSR_STATUS)
  LD ($FACB),A
  AND A
  RET NZ
  CALL CURSON
  JP _ESC_X
; This entry point is used by the routines at CHGET and CHSNS.
FNBAR_TOGGLE_4:
  LD A,($FACB)
  AND A
  RET NZ
  CALL CURSOFF
  JP _ESC_X

; Z if keyboard queue is empty
;
; Used by the routines at CHGET, INKEY_S, TEL_TERM, TEL_PREV, UPLDR, SHOW_TIME
; and TXT_CTL_N.
CHSNS:
  LD A,($F62D)
  AND A
  RET NZ
  LD A,($F932)
  AND A
  RET NZ
  PUSH HL
  LD HL,($F62E)
  LD A,L
  AND H
  INC A
  POP HL
  RET NZ
  RST $38
  LD B,$C3
  LD (HL),B
  LD (HL),D
; This entry point is used by the routines at EXEC_EVAL, __LIST and CATALOG.
CHSNS_0:
  CALL BRKCHK
  RET Z
  CP $03
  JP Z,CHSNS_2
  CP $13
  RET NZ
  CALL FNBAR_TOGGLE_3
CHSNS_1:
  CALL BRKCHK
  CP $13
  JP Z,FNBAR_TOGGLE_4
  CP $03
  JP NZ,CHSNS_1
  CALL FNBAR_TOGGLE_4
CHSNS_2:
  XOR A
  LD (GETPNT),A
  JP __STOP

; POWER statement
__POWER:
  SUB $A4
  JP Z,POWER_CONT
  CP $27
  JP NZ,POWER_ON
  RST CHRGTB
  JP Z,TURN_OFF_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  SUB L
  JP NZ,SNERR
  JP TURN_OFF

; Normal TRAP (low power) interrupt routine
LOW_PWR:
  PUSH AF
  LD A,(POWR_FLAG)
  AND A
  LD A,$01
  LD (POWR_FLAG),A
  JP NZ,TURN_OFF_0
  POP AF

; Turn off computer
;
; Used by the routines at FNBAR_TOGGLE and __POWER.
TURN_OFF:
  DI
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,L0000
  ADD HL,SP
  LD (SP_POWER),HL
  LD HL,$9C0B
  LD ($F5F2),HL
; This entry point is used by the routines at __POWER and LOW_PWR.
TURN_OFF_0:
  DI
  IN A,($BA)
  OR $10
  OUT ($BA),A
  HALT

; POWER CONT Statement
;
; Used by the routine at __POWER.
POWER_CONT:
  CALL POWER_ON_0
  LD ($F932),A
  RST CHRGTB
  RET

; POWER ON Statement
;
; Used by the routine at __POWER.
POWER_ON:
  CALL GETINT
  CP $0A
  JP C,FCERR
; This entry point is used by the routine at POWER_CONT.
POWER_ON_0:
  LD ($F657),A
  LD ($F931),A
  RET

; Output character to printer without tab expansions, uses LPT_VECT
;
; Used by the routines at __LCOPY and OUTC_TABEXP.
LPT_OUT:
  RST $38
  LD A,(BC)
  CALL PRINTR
  JP NC,PNOTAB_0
  XOR A
  LD ($FACD),A
  JP IOERR

; PRINTER: A = chr to print (no TAB expansion)
PNOTAB:
  SUB H
  INC D
; This entry point is used by the routine at LPT_OUT.
PNOTAB_0:
  PUSH AF
  LD A,$FF
  LD ($FACD),A
  CALL _RST75_6
  POP AF
  RET

; Start tape and load tape header.  If an error or Shift Break pressed,
; generate I/O error
;
; Used by the routine at CAS_OPNI_CO.
HEADER:
  CALL CTON
  CALL SYNCR
  RET NC
; This entry point is used by the routines at CASIN, CSOUT, CAS_INPUT,
; LOAD_RECORD, CLOADM and CAS_OPNI_CO.
HEADER_0:
  CALL CTOFF

; Generate I/O error
;
; Used by the routines at LPT_OUT, COM_OPN and COM_INPUT.
IOERR:
  LD E,$12
  JP ERROR
; This entry point is used by the routine at CAS_OPNO_CO.
IOERR_0:
  CALL CTON
  LD BC,L0000
IOERR_1:
  DEC BC
  LD A,B
  OR C
  JP NZ,IOERR_1
  JP SYNCW

; Cassette motor ON
;
; Used by the routines at HEADER and IOERR.
CTON:
  DI
  LD DE,$1EFB

; Cassette motor OFF
;
; Used by the routines at HEADER, CAS_INPUT, __CLOAD, LOAD_RECORD, CLOADM,
; LDIR_B, CAS_OPNO_CO and CAS_OPNI_CO.
CTOFF:
  EI
  LD E,$00
  JP DATAR_1

; Read char from cassette: C=current chksum (will be updated), A=char
;
; Used by the routines at CAS_INPUT, LOAD_RECORD, LDIR_B and CAS_OPNI_CO.
CASIN:
  PUSH DE
  PUSH HL
  PUSH BC
  CALL DATAR
  JP C,HEADER_0
  LD A,D
  POP BC
  ADD A,C
  LD C,A
  LD A,D
  POP HL
  POP DE
  RET

; Send char to cassette: C=current chksum (will be updated), A=char
;
; Used by the routines at CAS_INPUT, SAVE_BUFFER and CAS_OPNO_CO.
CSOUT:
  PUSH DE
  PUSH HL
  LD D,A
  ADD A,C
  LD C,A
  PUSH BC
  LD A,D
  CALL DATAW
  JP C,HEADER_0
  POP BC
  POP HL
  POP DE
  RET



; LCD Device control block
LCD_CTL:
  DEFW LCDLPT_OPN
  DEFW _CLOSE
  DEFW LCD_OUTPUT

; LCD and LPT file open routine
LCDLPT_OPN:
  LD A,$02
  CP E
  JP NZ,NMERR

; This entry point is used by the routines at RAM_OPN, CAS_OPN and COM_OPN.
LCDLPT_OPN_0:
  LD (PTRFIL),HL
  LD (HL),E
  POP AF
  POP HL
  RET

; LCD file output routine
LCD_OUTPUT:
  POP AF
  PUSH AF
  CALL OUTC_SUB_0
; This entry point is used by the routines at CAS_OUTPUT, LPT_OUTPUT and
; COM_OUTPUT.
LCD_OUTPUT_0:
  CALL _RST75_6

; POP all registers.
;
; Used by the routines at OUTC_SUB and BOOT.
POPALL:
  POP AF
; This entry point is used by the routines at CHGET, LINE_GFX and CARDET.
POPALL_0:
  POP BC
  POP DE
  POP HL
  RET


; CRT device control block
CRT_CTL:
  DEFW CRT_OPN
  DEFW _CLOSE
  DEFW CRT_OUTPUT

; Routine at 5368
CRT_OPN:
  RST $38
  LD B,B

; Routine at 5370
CRT_OUTPUT:
  RST $38
  LD B,H

; RAM Device control block
RAM_CTL:
  DEFW RAM_OPN
  DEFW RAM_CLS
  DEFW RAM_OUTPUT
  DEFW RAM_IO
  DEFW L161B


; RAM file open routine
RAM_OPN:
  PUSH HL
  PUSH DE
  INC HL
  INC HL
  PUSH HL
  LD A,E
  CP $01
  JP Z,RAM_OPN_3
  CP $08
  JP Z,RAM_OPN_4
RAM_OPN_0:
  CALL MAKTXT
  JP C,RAM_OPN_6
  PUSH DE
  CALL __EOF_3
  POP DE
RAM_OPN_1:
  LD BC,L0000
RAM_OPN_2:
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
  JP LCDLPT_OPN_0
RAM_OPN_3:
  LD A,($F651)
  AND A
  LD HL,$F9AF
  CALL Z,FINDCO_0
  JP Z,FFERR
  EX DE,HL
  CALL RAM_IO_5
  XOR A
  LD (HL),A
  LD L,A
  LD H,A
  LD ($FAD8),HL
  JP RAM_OPN_1
RAM_OPN_4:
  POP HL
  POP DE
  LD E,$02
  PUSH DE
  PUSH HL
  CALL RESFPT
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
RAM_OPN_5:
  LD A,(HL)
  INC HL
  INC BC
  CP $1A
  JP NZ,RAM_OPN_5
  JP RAM_OPN_2
RAM_OPN_6:
  LD A,(DE)
  AND $02
  JP NZ,AOERR
  EX DE,HL
  CALL KILLASC+2
  JP RAM_OPN_0

; RAM file close routine
RAM_CLS:
  PUSH HL
  CALL RAM_CLS_0
  POP HL
  CALL CAS_INPUT_4
  CALL NZ,RAM_IO_2
  CALL RAM_IO_5
  LD (HL),$00
  JP _CLOSE
; This entry point is used by the routine at RAM_IO.
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

; RAM file output routine
RAM_OUTPUT:
  POP AF
  PUSH AF
  LD BC,LCD_OUTPUT_0
  PUSH BC
  AND A
  RET Z
  CP $1A
  RET Z
  CP $7F
  RET Z
  CALL CAS_INPUT_5
  RET NZ
  LD BC,$0100
  JP RAM_IO_2

; RAM file input routine
RAM_IO:
  EX DE,HL
  CALL RAM_IO_5
  CALL __EOF_2
  EX DE,HL
  CALL CAS_INPUT_6
  JP NZ,RAM_IO_1
  EX DE,HL
  LD HL,($FC87)
  RST CPDEHL
  PUSH AF
  PUSH DE
  CALL NZ,RESFPT
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
  JP NZ,RAM_IO_0
  PUSH DE
  EX DE,HL
  LD HL,($FAD8)
  EX DE,HL
  ADD HL,DE
  POP DE
RAM_IO_0:
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
RAM_IO_1:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A
  SCF
  CCF
  JP NZ,RDBYT_0
  CALL RAM_IO_5
  LD (HL),A
  SCF
  JP RDBYT_0

; Routine at 5659
L161B:
  CALL RAM_IO_5
  JP COM_IO_0
; This entry point is used by the routines at RAM_CLS and RAM_OUTPUT.
RAM_IO_2:
  PUSH HL
  PUSH BC
  PUSH HL
  EX DE,HL
  LD HL,($FC87)
  RST CPDEHL
  CALL NZ,RESFPT
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
  LD BC,$FFFA
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
  CALL MAKHOL
  CALL NC,__EOF_4
  POP BC
  POP DE
  POP HL
  JP C,RAM_IO_4
  PUSH HL
RAM_IO_3:
  LD A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,RAM_IO_3
  POP DE
  LD HL,($FC87)
  RST CPDEHL
  RET Z
  JP RESFPT
RAM_IO_4:
  LD BC,$FFF7
  ADD HL,BC
  LD (HL),$00
  CALL RAM_CLS_0
  JP CHKSTK_0
; This entry point is used by the routines at RAM_OPN, RAM_CLS and __EOF.
RAM_IO_5:
  PUSH DE
  LD HL,($FAA2)
  LD DE,$FA91
  ADD HL,DE
  POP DE
  RET



; CAS Device control block
CAS_CTL:
  DEFW CAS_OPN
  DEFW CAS_CLS
  DEFW CAS_OUTPUT
  DEFW CAS_INPUT
  DEFW $1710

; CAS file open routine
CAS_OPN:
  PUSH HL
  PUSH DE
  LD BC,$0006
  ADD HL,BC
  XOR A
  LD (HL),A
  LD ($FA8E),A
  LD A,E
  CP $08
  JP Z,NMERR
  CP $01
  JP Z,CAS_OPN_1
  CALL CAS_OPNO_DO
CAS_OPN_0:
  POP DE
  POP HL
  JP LCDLPT_OPN_0
CAS_OPN_1:
  CALL CAS_OPNI_DO
  JP CAS_OPN_0

; CAS file close routine
CAS_CLS:
  CALL CAS_INPUT_4
  JP Z,CAS_CLS_1
  PUSH HL
  ADD HL,BC
CAS_CLS_0:
  LD (HL),$1A
  INC HL
  INC C
  JP NZ,CAS_CLS_0
  POP HL
  CALL CAS_INPUT_2
CAS_CLS_1:
  XOR A
  LD ($FA8E),A
  JP _CLOSE

; CAS file output routine
CAS_OUTPUT:
  POP AF
  PUSH AF
  CALL CAS_INPUT_5
  CALL Z,CAS_INPUT_2
  JP LCD_OUTPUT_0

; CAS file input routine
CAS_INPUT:
  EX DE,HL
  LD HL,$FA8E
  CALL __EOF_2
  EX DE,HL
  CALL CAS_INPUT_6
  JP NZ,CAS_INPUT_1
  PUSH HL
  CALL CAS_OPNI_CO_10
  POP HL
  LD BC,L0000
CAS_INPUT_0:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CAS_INPUT_0
  CALL CASIN
  LD A,C
  AND A
  JP NZ,HEADER_0
  CALL CTOFF
  DEC H
  XOR A
  LD B,A
CAS_INPUT_1:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A
  SCF
  CCF
  JP NZ,RDBYT_0
  LD ($FA8E),A
  SCF
  JP RDBYT_0
  LD HL,$FA8E
  JP COM_IO_0
; This entry point is used by the routines at CAS_CLS and CAS_OUTPUT.
CAS_INPUT_2:
  PUSH HL
  CALL CAS_OPNO_CO_3
  POP HL
  LD BC,L0000
CAS_INPUT_3:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC B
  JP NZ,CAS_INPUT_3
  JP CAS_OPNO_CO_1
; This entry point is used by the routines at RAM_CLS and CAS_CLS.
CAS_INPUT_4:
  LD A,(HL)
  CP $01
  RET Z
  LD BC,$0006
  ADD HL,BC
  LD A,(HL)
  LD C,A
  LD (HL),$00
  JP CAS_INPUT_7
; This entry point is used by the routines at RAM_OUTPUT and CAS_OUTPUT.
CAS_INPUT_5:
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
; This entry point is used by the routine at RAM_IO.
CAS_INPUT_6:
  LD BC,$0006
  ADD HL,BC
  LD A,(HL)
  INC (HL)
CAS_INPUT_7:
  INC HL
  INC HL
  INC HL
  AND A
  RET



; LPT device control block
LPT_CTL:
  DEFW LCDLPT_OPN
  DEFW _CLOSE
  DEFW LPT_OUTPUT

; LPT file output routine
LPT_OUTPUT:
  POP AF
  PUSH AF
  CALL OUTC_TABEXP
  JP LCD_OUTPUT_0


; COM device control block
COM_CTL:
  DEFW COM_OPN
  DEFW COM_CLS
  DEFW COM_OUTPUT
  DEFW COM_INPUT
  DEFW COM_IO

; MDM file open routine
MDM_OPN:
  OR $37

; COM file open routine
COM_OPN:
  SCF
  PUSH AF
  CALL C,TEL_DISC
  POP AF
  PUSH AF
  PUSH HL
  PUSH DE
  LD HL,FILNAM
  CALL SETSER
  POP DE
  LD A,E
  CP $08
  JP Z,NMERR
  SUB $01
  JP NZ,COM_OPN_0
  LD ($FA8F),A
COM_OPN_0:
  POP HL
  POP AF
  JP C,LCDLPT_OPN_0
  CALL TEL_LIFT
  JP C,IOERR
  LD A,$02
  CALL TMDELA
  JP LCDLPT_OPN_0

; COM file close routine
;
; Used by the routine at MDM_CLS.
COM_CLS:
  CALL CLSCOM
  XOR A
  LD ($FA8F),A
  JP _CLOSE

; COM and MDM file output routine
COM_OUTPUT:
  POP AF
  PUSH AF
  CALL SD232C
  JP LCD_OUTPUT_0

; COM and MDM file input routine
COM_INPUT:
  LD HL,$FA8F
  CALL __EOF_2
  CALL RV232C
  JP C,IOERR
  CP $1A
  SCF
  CCF
  JP NZ,RDBYT_0
  LD ($FA8F),A
  SCF
  JP RDBYT_0

; Special COM and MDM I/O routine
COM_IO:
  LD HL,$FA8F
; This entry point is used by the routines at RAM_IO and CAS_INPUT.
COM_IO_0:
  LD (HL),C
  JP L4F2E_15



; MDM device control block
MDM_CTL:
  DEFW MDM_OPN
  DEFW MDM_CLS_1
  DEFW COM_OUTPUT
  DEFW COM_INPUT

; MDM file close routine
MDM_CLS:
  RLA
  JP Z,$3E17

; Routine at 6107  (L17DB)
MDM_CLS_1:
  LD A,$02
  CALL TMDELA
  CALL TEL_DISC
  JP COM_CLS


; Set RS232 parameters, HL = zero terminated setup string, e.g. "78E1E"
;
; Used by the routines at COM_OPN, TEL_SET_STAT, TEL_LOGON, TEL_TERM and BOOT.
SETSER:
  PUSH AF
  LD BC,NMERR
  PUSH BC
  JP NC,SETSER_0
  LD A,(HL)
  SUB $31
  CP $09
  RET NC
  INC A
  LD D,A
  INC HL
SETSER_0:
  LD A,(HL)
  SUB $36
  CP $03
  RET NC
; This entry point is used by the routine at WAND_CTL.
SETSER_1:
  INC A
  ADD A,A
  ADD A,A
  ADD A,A
  LD E,A
  INC HL
  CALL UCASE_HL
  CP $49
  JP NZ,SETSER_2
  LD A,E
  CP $18
  RET Z
  ADD A,$0C
  LD E,A
  AND $08
  ADD A,A
  ADD A,A
  ADD A,A
  OR $3F
  JP SETSER_4
  
SETSER_2:
  CP $45
  LD B,$02
  JP Z,SETSER_3
  SUB $4E
  LD B,$04
  JP Z,SETSER_3
  DEC A
  RET NZ
  LD B,A
SETSER_3:
  LD A,B
  OR E
  LD E,A
  LD A,$FF
SETSER_4:
  LD ($FF8D),A
  INC HL
  LD A,(HL)
  SUB $31
  CP $02
  RET NC
  OR E
  LD E,A
  INC HL
  CALL UCASE_HL
  CP $44
  JP Z,SETSER_5
  CP $45
  RET NZ
  CALL XONXOFF_ON
  SCF
SETSER_5:
  CALL NC,$6F32
  POP BC
  POP AF
  PUSH AF
  PUSH DE
  DEC HL
  DEC HL
; This entry point is used by the routine at WAND_CTL.
SETSER_6:
  DEC HL
  DEC HL
  LD DE,STAT
  LD B,$05
  LD A,(HL)
  JP C,SETSER_7
  LD A,$4D
SETSER_7:
  LD (DE),A
  INC HL
  INC DE
  CALL UCASE_HL
  DEC B
  JP NZ,SETSER_7
  EX DE,HL
  POP HL
  POP AF
  PUSH DE
  CALL INZCOM
  POP HL
  RET

; WAND device control block
; Data block at 6263
WAND_CTL:
  DEFW $1881
  DEFW $1883
  DEFW FCERR
  DEFW $1885
  DEFW $1887
  DEFW $46FF
  DEFW $48FF
  DEFW $4AFF
  DEFW $4CFF

; Routine at 6281
__EOF:
  RST $38
  LD H,$CD
  ADD A,C
  LD C,H
  JP Z,CFERR
  CP $01
  JP NZ,NMERR
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
  LD HL,$FA8F
  CP $FC
  JP Z,__EOF_0
  CP $F9
  JP Z,__EOF_0
  CALL RAM_IO_5
  CP $F8
  JP Z,__EOF_0
  LD HL,$FA8E
__EOF_0:
  LD (HL),C
  RET
  
__EOF_1:
  PUSH BC
  PUSH HL
  PUSH DE
  LD A,$06
  JP GET_DEVICE

; This entry point is used by the routines at RAM_IO, CAS_INPUT and COM_INPUT.
__EOF_2:
  LD A,(HL)
  LD (HL),$00
  AND A
  RET Z
  INC SP
  INC SP
  CP $1A
  SCF
  CCF
  JP NZ,RDBYT_0
  LD (HL),A
  SCF
  JP RDBYT_0
  
; This entry point is used by the routine at RAM_OPN.
__EOF_3:
  LD BC,$0001
; This entry point is used by the routines at RAM_IO and KILLASC.
__EOF_4:
  LD HL,($FB9D)
__EOF_5:
  LD A,(HL)
  AND A
  RET Z
  EX DE,HL
  LD HL,(STRBUF)
  EX DE,HL
  RST CPDEHL
  RET NC
  LD A,(HL)
  CP $81
  LD DE,$0007
  JP NZ,__EOF_6
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
  LD DE,CPDEHL
__EOF_6:
  ADD HL,DE
  JP __EOF_5

; TIME$ function (as in Tandy docs)
;
; Used by the routine at ERL.
TIME_S_FN:
  RST CHRGTB
  PUSH HL
  CALL L1962_0
  CALL READ_TIME
  JP TSTOPL

; Read system time, HL=8 byte area: TIME(hh:mm:ss)
;
; Used by the routines at TIME_S_FN and PRINT_TDATE.
READ_TIME:
  CALL READ_CLOCK
  LD DE,HRS_2
  CALL L1962_2
  LD (HL),$3A
  INC HL
  CALL L1962_2
  LD (HL),$3A
; This entry point is used by the routine at L192F.
READ_TIME_0:
  INC HL
  JP L1962_2

; DATE$ function (as in Tandy docs)
;
; Used by the routine at ERL.
DATE_S_FN:
  RST CHRGTB
  PUSH HL
  CALL L1962_0
  CALL L192F
  JP TSTOPL

; Read system date, HL=8 byte area: DATE(mm/dd/yy)
;
; Used by the routines at DATE_S_FN and PRINT_TDATE.
L192F:
  CALL READ_CLOCK
  LD DE,MONTH
  LD A,(DE)
  CP $0A
  LD B,$30
  JP C,L192F_0
  LD B,$31
  SUB $0A
L192F_0:
  LD (HL),B
  INC HL
  CALL L1962_4
  DEC DE
  LD (HL),$2F
  INC HL
  CALL L1962_2
  LD (HL),$2F
  LD DE,YEAR_2
  JP READ_TIME_0

; DAY$ function (as in Tandy docs)
;
; Used by the routine at ERL.
DAY_S_FN:
  RST CHRGTB
  PUSH HL
  LD A,$03
  CALL L1962_1
  CALL L1962
  JP TSTOPL

; Read system date, HL=3 byte area: DAY(ddd)
;
; Used by the routines at DAY_S_FN and PRINT_TDATE.
L1962:
  CALL READ_CLOCK
  LD A,(DAY)
  LD C,A
  ADD A,A
  ADD A,C
  LD C,A
  LD B,$00
  EX DE,HL
  LD HL,$1978
  ADD HL,BC
  LD B,$03
  JP LDIR_B
  LD D,E
  LD (HL),L
  LD L,(HL)
  LD C,L
  LD L,A
  LD L,(HL)
  LD D,H
  LD (HL),L
  LD H,L
  LD D,A
  LD H,L
  LD H,H
  LD D,H
  LD L,B
  LD (HL),L
  LD B,(HL)
  LD (HL),D
  LD L,C
  LD D,E
  LD H,C
  LD (HL),H
; This entry point is used by the routines at TIME_S_FN and DATE_S_FN.
L1962_0:
  LD A,$08
; This entry point is used by the routine at DAY_S_FN.
L1962_1:
  CALL MKTMST
  LD HL,($FB8A)
  RET
; This entry point is used by the routines at READ_TIME and L192F.
L1962_2:
  CALL L1962_3
L1962_3:
  LD A,(DE)
; This entry point is used by the routine at L192F.
L1962_4:
  OR $30
  LD (HL),A
  DEC DE

; Routine at 6558
INXH:
  INC HL
  RET

; Update F923H with the time in the internal hw clock
;
; Used by the routines at READ_TIME, L192F, L1962 and __DAY_S.
READ_CLOCK:
  PUSH HL
  LD HL,SECS
  DI
  CALL READ_CLOCK_HL
  EI
  POP HL
  RET

; TIME$ function (as in BASCK)
__TIME_S:
  CP $DD
  JP NZ,__MDM_0
  CALL __DAY_S_5

; Update the internal clock chip with the values at F923H
;
; Used by the routines at __DATE_S and __DAY_S.
SET_CLOCK:
  LD HL,SECS
  DI
  CALL SET_CLOCK_HL
  EI
  POP HL
  RET

; Routine at 6589
__DATE_S:
  CALL __DAY_S_3
  JP NZ,SNERR
  CALL GETINT
  DEC A
  CP $0C
  JP NC,SNERR
  INC A
  LD DE,MONTH
  LD (DE),A
  RST SYNCHR
  CPL
  DEC DE
  CALL __DAY_S_6
  CP $04
  JP NC,SNERR
  CALL __DAY_S_6
  RST SYNCHR
  CPL
  LD DE,CSRITP
  CALL __DAY_S_6
  CALL __DAY_S_6
  XOR A
  LD ($F655),A
  JP SET_CLOCK

; Routine at 6641
__DAY_S:
  CALL __DAY_S_3
  CP $03
  JP NZ,SNERR
  LD DE,$1978
  LD C,$07
__DAY_S_0:
  PUSH HL
  LD B,$03
__DAY_S_1:
  LD A,(DE)
  PUSH DE
  CALL UCASE
  LD E,A
  CALL UCASE_HL
  CP E
  POP DE
  JP NZ,__DAY_S_2
  INC DE
  INC HL
  DEC B
  JP NZ,__DAY_S_1
  POP HL
  LD A,$07
  SUB C
  LD (DAY),A
  JP SET_CLOCK
__DAY_S_2:
  INC DE
  DEC B
  JP NZ,__DAY_S_2
  POP HL
  DEC C
  JP NZ,__DAY_S_0
  JP SNERR
; This entry point is used by the routine at __DATE_S.
__DAY_S_3:
  RST SYNCHR
  DEFB $DD
; This entry point is used by the routine at __IPL.
__DAY_S_4:
  CALL EVAL
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
; This entry point is used by the routines at __TIME_S and ON_TIME_S.
__DAY_S_5:
  CALL __DAY_S_3
  JP NZ,SNERR
  EX DE,HL
  POP HL
  EX (SP),HL
  PUSH HL
  EX DE,HL
  LD DE,DATE
  CALL __DAY_S_6
  CP $03
  JP NC,SNERR
  CALL __DAY_S_6
  RST SYNCHR
  LD A,(TXT_CTL_C_4)
  LD A,(DE)
  RST SYNCHR
  LD A,($6ACD)
  LD A,(DE)
  CP $06
  JP NC,SNERR
; This entry point is used by the routine at __DATE_S.
__DAY_S_6:
  DEC DE
  LD A,(HL)
  INC HL
  SUB $30
  CP $0A
  JP NC,SNERR
  AND $0F
  LD (DE),A
  RET

; Routine at 6776
__IPL:
  JP Z,ERASE_IPL
  CALL __DAY_S_4
  AND A
  JP Z,__IPL_0
  CP $0A
  JP NC,FCERR
  LD B,A
  EX DE,HL
  LD HL,IPL_FNAME
  CALL REV_LDIR_B
  LD (HL),$0D
  INC HL
  LD (HL),B
  POP HL
  RET
__IPL_0:
  POP HL

; Erase current IPL program (table)
;
; Used by the routines at __IPL and BOOT.
ERASE_IPL:
  XOR A
  LD (IPL_FNAME),A
  LD ($FAB0),A
  RET

; COM and MDM Statements
__MDM:
  PUSH HL
  LD HL,ON_COM_FLG
  JP __MDM_1
; This entry point is used by the routine at __TIME_S.
__MDM_0:
  PUSH HL
  LD HL,ON_TIME_FLG
__MDM_1:
  CALL KEY_STMTS_2
; This entry point is used by the routine at KEY_STMTS.
__MDM_2:
  POP HL
  POP AF
  RST CHRGTB
  JP EXEC_EVAL_0
; This entry point is used by the routine at OUTS_B_CHARS.
__MDM_3:
  CALL GETINT
  DEC A
  CP $08
  JP NC,FCERR
  LD A,(HL)
  PUSH HL
  CALL KEY_STMTS_1
  JP __MDM_2

; KEY STOP/ON/OFF Statements
;
; Used by the routine at OUTS_B_CHARS.
KEY_STMTS:
  PUSH HL
  LD E,$08
KEY_STMTS_0:
  PUSH DE
  PUSH AF
  CALL KEY_STMTS_1
  POP AF
  POP DE
  DEC E
  JP NZ,KEY_STMTS_0
  JP __MDM_2
; This entry point is used by the routine at __MDM.
KEY_STMTS_1:
  LD D,$00
  LD HL,$F62F
  ADD HL,DE
  PUSH HL
  LD HL,ON_TIME_FLG
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
  CALL KEY_STMTS_2
  LD A,(HL)
  AND $01
  POP HL
  LD (HL),A
  RET
; This entry point is used by the routine at __MDM.
KEY_STMTS_2:
  CP $97
  JP Z,TIME_S_ON
  CP $CB
  JP Z,TIME_S_OFF
  CP $8F
  JP Z,TIME_S_STOP
  JP SNERR
; This entry point is used by the routine at ON_ERROR.
KEY_STMTS_3:
  CP $AD
  LD BC,$0001
  RET Z
  CP $AE
  RET Z
  CP $AF
  LD BC,$0208
  RET Z
  CP $AA
  SCF
  RET NZ

; ON TIME$ Statement
ON_TIME_S:
  INC HL
  CALL __DAY_S_5
  LD HL,ON_TIME_TM
  LD B,$06
  CALL REV_LDIR_B
  POP HL
  DEC HL
  LD BC,$0101
  AND A
  RET
; This entry point is used by the routine at ON_ERROR.
ON_TIME_S_0:
  PUSH HL
  LD B,A
  ADD A,A
  ADD A,B
  LD L,A
  LD H,$00
  LD BC,ON_COM
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; RST 7.5 interrupt routine (see 3CH)
;
; Used by the routine at RST75.
_RST75:
  CALL TIMER
  PUSH HL
  PUSH DE
  PUSH BC
_RST75_0:
  PUSH AF
  LD A,$0D
  JR NC,_RST75_0
  LD HL,CSRITP
  DEC (HL)
  JP NZ,_RST75_5
  LD (HL),$7D
  INC HL
  DEC (HL)
  JP NZ,_RST75_1
  LD (HL),$0C
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  CALL NZ,_RST75_6
  LD A,(HL)
  AND A
  JP Z,_RST75_1
  DEC (HL)
  JP NZ,_RST75_1
  INC HL
  LD (HL),$FF
_RST75_1:
  LD HL,CLOCK_SS1
  PUSH HL
  CALL READ_CLOCK_HL
  POP DE
  LD HL,ON_TIME_TM
  LD B,$06
_RST75_2:
  LD A,(DE)
  SUB (HL)
  JP NZ,$1B88
  INC DE
  INC HL
  DEC B
  JP NZ,_RST75_2
  OR (HL)
  JP NZ,_RST75_3
  LD HL,ON_TIME_FLG
  CALL TIME_S_STOP_2
  LD A,$AF
  LD ($F943),A
_RST75_3:
  LD A,($F93C)
  LD HL,$F655
  CP (HL)
  LD (HL),A
  JP NC,_RST75_4
  LD HL,YEAR
  INC (HL)
  LD A,(HL)
  SUB $0A
  JP NZ,_RST75_4
  LD (HL),A
  INC HL
  INC (HL)
  LD A,(HL)
  SUB $0A
  JP NZ,_RST75_4
  LD (HL),A
_RST75_4:
  CALL _CLICK_1
_RST75_5:
  JP SET_CLOCK_HL_5
; This entry point is used by the routines at CHGET, PNOTAB, LCD_OUTPUT and
; TXT_CTL_U.
_RST75_6:
  LD A,($F657)
  LD ($F931),A
  RET

; Routine at 7096
__KEY:
  CP $A5
  JP NZ,OUTS_B_CHARS_2
  RST CHRGTB
  PUSH HL
  LD HL,FNKSTR
  LD C,$04
__KEY_0:
  CALL __KEY_1
  CALL __KEY_1
  CALL OUTDO_CRLF
  DEC C
  JP NZ,__KEY_0
  POP HL
  RET
__KEY_1:
  LD B,$10
  CALL OUTS_B_CHARS
  LD B,$03
__KEY_2:
  RST OUTC
  DEC B
  JP NZ,__KEY_2
  RET

; Send B number of characters from buffer pointed by HL to screen
;
; Used by the routines at __KEY and DSPFNK.
OUTS_B_CHARS:
  LD A,(HL)
  CP $7F
  JP Z,OUTS_B_CHARS_0
  CP $20
  JP NC,OUTS_B_CHARS_1
OUTS_B_CHARS_0:
  LD A,' '
OUTS_B_CHARS_1:
  RST OUTC
  INC HL
  DEC B
  JP NZ,OUTS_B_CHARS
  LD A,' '
  RET
; This entry point is used by the routine at __KEY.
OUTS_B_CHARS_2:
  CP $28
  JP Z,__MDM_3
  CP $97
  JP Z,KEY_STMTS
  CP $CB
  JP Z,KEY_STMTS
  CP $8F
  JP Z,KEY_STMTS
  CALL GETINT
  DEC A
  CP $08
  JP NC,FCERR
  EX DE,HL
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD BC,FNKSTR
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
  JP Z,OUTS_B_CHARS_4
OUTS_B_CHARS_3:
  LD A,(DE)
  AND A
  JP Z,FCERR
  LD (HL),A
  INC DE
  INC HL
  DEC C
  JP Z,OUTS_B_CHARS_5
  DEC B
  JP NZ,OUTS_B_CHARS_3
OUTS_B_CHARS_4:
  LD (HL),B
  INC HL
  DEC C
  JP NZ,OUTS_B_CHARS_4
OUTS_B_CHARS_5:
  LD (HL),C
  CALL FNKSB
  CALL BASIC_3
  POP HL
  RET

; Routine at 7255
__PSET:
  CALL LINE_GFX_13
; This entry point is used by the routine at __PRESET.
__PSET_0:
  RRCA
  PUSH HL
  PUSH AF
  CALL C,PLOT
  POP AF
  CALL NC,UNPLOT
  POP HL
  RET

; Routine at 7270
__PRESET:
  CALL LINE_GFX_13
  CPL
  JP __PSET_0

; LINE (graphics)
;
; Used by the routine at __LINE.
LINE_GFX:
  CP $D1
  EX DE,HL
  LD HL,(GR_X)
  EX DE,HL
  CALL NZ,LINE_GFX_13
  PUSH DE
  RST SYNCHR
  POP DE
  CALL LINE_GFX_13
  PUSH DE
  LD DE,PLOT
  JP Z,LINE_GFX_1
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  POP DE
  RRCA
  JP C,LINE_GFX_0
  LD DE,UNPLOT
LINE_GFX_0:
  DEC HL
  RST CHRGTB
LINE_GFX_1:
  EX DE,HL
  LD (LASTCALL),HL
  EX DE,HL
  JP Z,$1CD2
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  LD B,D
  JP Z,LINE_GFX_4
  RST SYNCHR
  LD B,(HL)
  POP DE
  EX (SP),HL
  LD A,E
  SUB L
  JP NC,LINE_GFX_2
  CPL
  INC A
  LD L,E
LINE_GFX_2:
  LD B,A
  INC B
LINE_GFX_3:
  LD E,L
  CALL LINE_GFX_5
  INC L
  DEC B
  JP NZ,LINE_GFX_3
  POP HL
  RET
LINE_GFX_4:
  POP DE
  EX (SP),HL
  PUSH DE
  LD E,L
  CALL LINE_GFX_5
  POP DE
  PUSH DE
  LD D,H
  CALL LINE_GFX_5
  POP DE
  PUSH HL
  LD H,D
  CALL LINE_GFX_5
  POP HL
  LD L,E
  LD BC,$E3D1
  CALL LINE_GFX_5
  POP HL
  RET
LINE_GFX_5:
  PUSH HL
  PUSH DE
  PUSH BC
  LD A,L
  SUB E
  JP NC,LINE_GFX_6
  EX DE,HL
  CPL
  INC A
LINE_GFX_6:
  LD B,A
  LD C,$14
  LD A,H
  SUB D
  JP NC,LINE_GFX_7
  CPL
  INC A
  INC C
LINE_GFX_7:
  CP B
  JP C,LINE_GFX_8
  LD H,A
  LD L,B
  LD A,$1C
  JP LINE_GFX_9
LINE_GFX_8:
  LD L,A
  LD H,B
  LD A,C
  LD C,$1C
LINE_GFX_9:
  LD ($F663),A
  LD A,C
  LD ($F665),A
  LD B,H
  INC B
  LD A,H
  AND A
  RRA
  LD C,A
LINE_GFX_10:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL PIVOTCALL
  POP BC
  POP DE
  POP HL
  CALL $F665
  LD A,C
  ADD A,L
  LD C,A
  JP C,LINE_GFX_11
  CP H
  JP C,LINE_GFX_12
LINE_GFX_11:
  SUB H
  LD C,A
  CALL $F663
LINE_GFX_12:
  DEC B
  JP NZ,LINE_GFX_10
  JP POPALL_0
; This entry point is used by the routines at __PSET and __PRESET.
LINE_GFX_13:
  RST SYNCHR
  JR Z,$1CFE
  LD L,$11
  CP $F0
  JP NC,FCERR
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  CP $40
  JP NC,FCERR
  POP AF
  LD D,A
  EX DE,HL
; This entry point is used by the routines at INLIN and MOVE_TEXT.
LINE_GFX_14:
  LD (GR_X),HL
  EX DE,HL
  LD A,(HL)
  CP $29
  JP NZ,LINE_GFX_15
  RST CHRGTB
  LD A,$01
  RET
LINE_GFX_15:
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  LD A,E
  POP DE
  RET
; This entry point is used by the routine at __PRINT.
LINE_GFX_16:
  CALL L1112
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  EX DE,HL
  LD A,(ACTV_Y)
  CPL
  INC A
  LD C,A
  LD B,$FF
  LD E,B
LINE_GFX_17:
  INC E
  LD D,L
  ADD HL,BC
  JP C,LINE_GFX_17
  LD A,(ACTV_Y)
  INC D
  CP D
  JP C,FCERR
  LD A,(ACTV_X)
  INC E
  CP E
  JP C,FCERR
  EX DE,HL
  CALL POSIT
  LD A,H
  DEC A
  LD (TTYPOS),A
  POP HL
  RET

; Routine at 7568
;
; Used by the routine at VARPTR_VAR.
CSRLIN:
  PUSH HL
  LD A,(CSRX)
  DEC A
; This entry point is used by the routine at MAXFILES.
CSRLIN_0:
  CALL INT_RESULT_A
  POP HL
  RST CHRGTB
  RET

; Routine at 7579
;
; Used by the routine at ERL.
MAX_FN:
  RST CHRGTB
  CP $9D
  JP Z,MAXFILES
  RST SYNCHR
  LD D,D
  RST SYNCHR
  LD B,C
  RST SYNCHR
  LD C,L

; Routine at 7591
NAXRAM:
  PUSH HL
  RST $38
  LD (BC),A
  LD HL,MAXRAM
  CALL DBL_ABS_0
  POP HL
  RET

; Routine at 7602
;
; Used by the routine at MAX_FN.
MAXFILES:
  PUSH HL
  LD A,(MAXFIL)
  JP CSRLIN_0

; Routine at 7609
;
; Used by the routine at ERL.
L1DB9:
  PUSH HL
  LD HL,(HIMEM)
  CALL DBL_ABS_0
  POP HL
  RST CHRGTB
  RET

; Routine at 7619
__WIDTH:
  RST $38
  LD A,($97FE)

; Routine at 7621
__SOUND:
  CP $97
  JP Z,SOUND_ON
  CP $CB
  JP Z,SOUND_OFF
  CALL GETWORD
  LD A,D
  AND $C0
  JP NZ,FCERR
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  AND A
  LD B,A
  POP DE
  JP NZ,MUSIC
  RET

; Routine at 7653
;
; Used by the routine at __SOUND.
SOUND_OFF:
  LD A,$AF

; Routine at 7654
;
; Used by the routine at __SOUND.
SOUND_ON:
  XOR A
  LD (SOUND_FLG),A
  RST CHRGTB
  RET

; Routine at 7660
__MOTOR:
  SUB $CB
  JP Z,MOTOR_OFF

; Routine at 7665
MOTOR_ON:
  RST SYNCHR
  SUB A
  DEC HL
  LD A,H

; Routine at 7669
;
; Used by the routine at __MOTOR.
MOTOR_OFF:
  LD E,A
  RST CHRGTB
  JP DATAR_1

; Routine at 7674
__CALL:
  CALL GETWORD
  EX DE,HL
  LD (LASTCALL),HL
  EX DE,HL
  DEC HL
  RST CHRGTB
  JP Z,__CALL_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP $2C
  JP Z,__CALL_0
  CALL GETINT
  JP Z,__CALL_1
__CALL_0:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETWORD
  POP AF
__CALL_1:
  PUSH HL
  EX DE,HL
  CALL PIVOTCALL
  POP HL
  RET

; Routine at 7714
__SCREEN:
  CP $2C
  LD A,($F638)
  CALL NZ,GETINT
  CALL __SCREEN_0
  DEC HL
  RST CHRGTB
  RET Z
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  PUSH HL
  AND A
  CALL FNBAR_TOGGLE_0
  POP HL
  RET
; This entry point is used by the routine at __MENU.
__SCREEN_0:
  PUSH HL
  LD ($F638),A
  AND A
  LD DE,$2808
  LD HL,(CSR_ROW)
  LD A,$0E
  JP Z,$1E52
  XOR A
  LD ($F638),A
  RST $38
  LD A,$22
  ADD HL,SP
  OR $EB
  LD (ACTV_X),HL
  LD ($F676),A
  POP HL
  RET

; aka PRTLCD (hardcopy to printer)
;
; Used by the routine at CHGET.
__LCOPY:
  PUSH HL
  CALL INIT_OUTPUT_0
  LD HL,BEGLCD
  LD E,$08
__LCOPY_0:
  LD D,$28
__LCOPY_1:
  LD A,(HL)
  CALL LPT_OUT
  INC HL
  DEC D
  JP NZ,__LCOPY_1
  CALL INIT_OUTPUT_0
  DEC E
  JP NZ,__LCOPY_0
  POP HL
  RET
; This entry point is used by the routine at __MERGE.
__LCOPY_2:
  PUSH HL
  CALL RESFPT
  LD HL,($FC99)
  LD DE,$2020
  RST CPDEHL
  PUSH AF
  JP Z,__LCOPY_3
  LD DE,$4142
  RST CPDEHL
  JP NZ,__LCOPY_5
__LCOPY_3:
  CALL FINDDO_0
  JP Z,__LCOPY_5
  POP AF
  POP BC
  POP AF
  JP Z,FCERR
  LD A,$00
  PUSH AF
  PUSH BC
  LD ($FA8C),HL
  EX DE,HL
  LD (BASTXT),HL
  CALL UPD_PTRS
  POP HL
  LD A,(HL)
  CP $2C
  JP NZ,__LCOPY_4
  RST CHRGTB
  RST SYNCHR
  LD D,D
  POP AF
  LD A,$80
  SCF
  PUSH AF
__LCOPY_4:
  POP AF
  LD ($FCA7),A
  JP C,OMERR_0
  CALL OMERR_0
  JP READY
__LCOPY_5:
  POP AF
  POP HL
  LD D,$F8
  JP NZ,__MERGE_0
  PUSH HL
  LD HL,$2020
  LD ($FC99),HL
  POP HL
  JP __MERGE_0
; This entry point is used by the routine at __SAVE.
__LCOPY_6:
  PUSH HL
  LD HL,($FC99)
  LD DE,$4F44
  RST CPDEHL
  LD B,$00
  JP Z,__LCOPY_7
  LD DE,$4142
  RST CPDEHL
  LD B,$01
  JP Z,__LCOPY_7
  LD DE,$2020
  RST CPDEHL
  LD B,$02
  JP NZ,NMERR
__LCOPY_7:
  POP HL
  PUSH BC
  DEC HL
  RST CHRGTB
  JP Z,__LCOPY_9
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  LD B,C
  POP BC
  DEC B
  JP Z,NMERR
__LCOPY_8:
  XOR A
  LD DE,$F802
  PUSH AF
  JP __SAVE_1
__LCOPY_9:
  POP BC
  DEC B
  JP M,__LCOPY_8
  CALL __NAME_2
  JP NZ,FCERR

; Routine at 7963
SAVEBA:
  CALL FINDDO_0
  CALL NZ,KILLASC_6
  CALL RESFPT
  CALL NXTDIR_0
  LD ($FA8C),HL
  LD A,$80
  EX DE,HL
  LD HL,(BASTXT)
  EX DE,HL
  CALL MAKTXT_0
  CALL RESFPT_9
  JP READY

; Routine at 7994
__FILES:
  PUSH HL
  CALL CATALOG
  POP HL
  JP CONSOLE_CRLF

; Display Catalog
;
; Used by the routine at __FILES.
CATALOG:
  LD HL,$F957
CATALOG_0:
  LD C,$03
  LD A,(ACTV_Y)
  CP $28
  JP Z,CATALOG_1
  LD C,$06
CATALOG_1:
  CALL NXTDIR
  RET Z
  AND $18
  JP NZ,CATALOG_1
  PUSH HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH DE
  LD B,$06
CATALOG_2:
  LD A,(HL)
  RST OUTC
  INC HL
  DEC B
  JP NZ,CATALOG_2
  LD A,$2E
  RST OUTC
  LD A,(HL)
  RST OUTC
  INC HL
  LD A,(HL)
  RST OUTC
  POP DE
  LD HL,(BASTXT)
  RST CPDEHL
  LD A,$2A
  LD B,$20
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
  CALL OUTDO_CRLF
  CALL CHSNS_0
  JP CATALOG_0

; Routine at 8081
__KILL:
  CALL __NAME_1
  DEC HL
  RST CHRGTB
  JP NZ,SNERR
  LD A,D
  CP $F8
  JP Z,__KILL_0
  RST $38
  LD E,B
__KILL_0:
  PUSH HL
  XOR A
  LD ($FCA7),A
  CALL __SAVE_4
  CALL RESFPT
  CALL FINDFL
  JP Z,FFERR
  LD B,A
  AND $20
  JP NZ,KILLASC_3
  LD A,B
  AND $40
  JP Z,KILLASC_5

; Kill a text (.DO) file, DE=TOP addr, HL=adrress of dir entry.
KILLASC:
  LD A,$E5
  LD BC,L0000
  LD (HL),C
  LD L,E
  LD H,D
KILLASC_0:
  LD A,(DE)
  INC DE
  INC BC
  CP $1A
  JP NZ,KILLASC_0
  CALL MASDEL
KILLASC_1:
  CALL __EOF_4
  CALL RESFPT
  POP HL
  RET

; This entry point is used by the routine at CSAVEM.
KILLASC_2:
  PUSH HL
; This entry point is used by the routine at __KILL.
KILLASC_3:
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

; This entry point is used by the routine at __EDIT.
KILLASC_4:
  CALL RESFPT
  LD HL,($F9B0)
  EX DE,HL
  LD HL,$F9AF
  JP KILLASC+2

; This entry point is used by the routine at __KILL.
KILLASC_5:
  PUSH HL
  LD HL,(BASTXT)
  RST CPDEHL
  POP HL
  JP Z,FCERR
  CALL KILLASC_6
  CALL OMERR_1
  JP READY
; This entry point is used by the routine at SAVEBA.
KILLASC_6:
  LD (HL),$00
  LD HL,(BASTXT)
  RST CPDEHL
  PUSH AF
  PUSH DE
  CALL UPD_PTRS_0
  POP DE
  INC HL
  CALL __NEW_3
  PUSH BC
  CALL RESFPT
  POP BC
  POP AF
  RET Z
  RET C
  LD HL,(BASTXT)
  ADD HL,BC
  LD (BASTXT),HL
  RET

; Routine at 8247
__NAME:
  CALL __NAME_1
  PUSH DE
  CALL SWAPNM
  RST SYNCHR
  LD B,C
  RST SYNCHR
  LD D,E
  CALL __NAME_1
  LD A,D
  POP DE
  CP D
  JP NZ,FCERR
  CP $F8
  JP Z,__NAME_0
  RST $38
  LD E,D
__NAME_0:
  PUSH HL
  CALL FINDFL
  JP NZ,FCERR
  CALL SWAPNM
  CALL FINDFL
  JP Z,FFERR
  PUSH HL
  LD HL,($FC99)
  EX DE,HL
  LD HL,($FCA2)
  RST CPDEHL
  JP NZ,FCERR
  POP HL
  CALL SWAPNM
  INC HL
  INC HL
  INC HL
  CALL $2241
  POP HL
  RET
; This entry point is used by the routines at __KILL, SAVEM and LOADM_RUNM.
__NAME_1:
  CALL FNAME_0
  RET NZ
  LD D,$F8
  RET
; This entry point is used by the routines at __LCOPY and __NEW.
__NAME_2:
  LD HL,($FA8C)
  LD DE,$F999
  RST CPDEHL
  RET

; Routine at 8329
;
; Used by the routines at CSAVEM and CLOADM.
FINDCO:
  LD BC,$434F
  JP FINDDO_1
; This entry point is used by the routines at RAM_OPN, MAKTXT and UPLDR.
FINDCO_0:
  LD HL,($FC99)
  LD DE,$2020
  RST CPDEHL
  JP Z,FINDDO
  LD DE,$4F44
  RST CPDEHL
  JP NZ,NMERR

; Routine at 8352
;
; Used by the routine at FINDCO.
FINDDO:
  LD BC,$444F
  JP FINDDO_1
; This entry point is used by the routines at __LCOPY and SAVEBA.
FINDDO_0:
  LD BC,$4241
; This entry point is used by the routine at FINDCO.
FINDDO_1:
  LD HL,$FC99
  LD (HL),B
  INC HL
  LD (HL),C

; Finf dall types of files, with extensions
;
; Used by the routines at __KILL and __NAME.
FINDFL:
  LD HL,$F957
  LD A,$E1
  CALL NXTDIR
  RET Z
  PUSH HL
  INC HL
  INC HL
  LD DE,$FC92
  LD B,$08
FINDFL_0:
  INC DE
  INC HL
  LD A,(DE)
  CP (HL)
  JP NZ,$20B3
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

; Routine at 8405
;
; Used by the routines at CATALOG, FINDFL and RESFPT.
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
; This entry point is used by the routines at SAVEBA, MAKTXT and CSAVEM.
NXTDIR_0:
  LD A,($F651)
  AND A
  LD HL,$F9AF
  RET NZ
  LD HL,$F9AF
  LD BC,$000B
NXTDIR_1:
  ADD HL,BC
  LD A,(HL)
  CP $FF
  JP Z,FLERR
  ADD A,A
  JP C,NXTDIR_1
  RET

; Routine at 8446
__NEW:
  RET NZ
; This entry point is used by the routines at __CLOAD, LOAD_RECORD, __MERGE and
; BOOT.
__NEW_0:
  CALL __NAME_2
  CALL NZ,RESFPT
  LD HL,$F999
  LD ($FA8C),HL
  LD HL,(SUZUKI)
  LD (BASTXT),HL
  XOR A
  LD (HL),A
; This entry point is used by the routine at FP_LOGTAB2.
__NEW_1:
  INC HL
  LD (HL),A
  INC HL
  EX DE,HL
  LD HL,(DO_FILES)
  CALL __NEW_3
  LD HL,($FAD8)
  ADD HL,BC
  LD ($FAD8),HL
  LD HL,$FFFF
  LD ($F62E),HL
  JP OMERR_0
; This entry point is used by the routine at __EDIT.
__NEW_2:
  LD HL,(LBLIST)
  EX DE,HL
  LD HL,($FABC)
; This entry point is used by the routine at KILLASC.
__NEW_3:
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

; Routine at 8518
;
; Used by the routines at CHGET, RAM_OPN, RAM_IO, __LCOPY, SAVEBA, __KILL,
; KILLASC, __NEW, MAKTXT, SWAPNM, CSAVEM, CLOADM, UPLDR, TEL_DOWN, __MENU,
; __EDIT and TXT_CTL_U.
RESFPT:
  XOR A
  LD ($F809),A
  LD HL,($FAC0)
  INC HL
RESFPT_0:
  PUSH HL
  LD HL,$F98E
  LD DE,$FFFF
RESFPT_1:
  CALL NXTDIR
  JP Z,RESFPT_2
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
  LD HL,$F957
RESFPT_4:
  CALL NXTDIR
  RET Z
  AND $FE
  LD (HL),A
  JP RESFPT_4
RESFPT_5:
  LD A,($F809)
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
  LD A,$1A
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
  LD ($F809),A
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
  LD ($F809),A
  RET
; This entry point is used by the routine at SAVEBA.
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
  JP RESFPT

; Count the number of characters in (HL), null terminated
;
; Used by the routines at OPENDO, UPLDR and TXT_CTL_G.
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

; Routine at 8710
;
; Used by the routines at DWNLDR and TEXT.
OPENDO:
  CALL COUNT_CHARS
  CALL FNAME
  JP NZ,SNERR

; Create a text file, max 8 bytes in FILNAM (no 'DO' ext). On exit: HL=TOP
; address of file, DE=file dictionary, CY if file exist.
;
; Used by the routine at RAM_OPN.
MAKTXT:
  CALL RESFPT
  CALL FINDCO_0
  EX DE,HL
  SCF
  RET NZ
  CALL NXTDIR_0
  PUSH HL
  LD HL,(DO_FILES)
  PUSH HL
  LD A,$1A
  CALL INSCHR
  JP C,CHKSTK_0
  POP DE
  POP HL
  PUSH HL
  PUSH DE
  LD A,$C0
  DEC DE
  CALL MAKTXT_0
  CALL RESFPT
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
  LD A,$D5
  LD DE,FILNAM
  LD B,$08
  CALL REV_LDIR_B
  POP DE
  RET

; Routine at 8780
;
; Used by the routine at __NAME.
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
; This entry point is used by the routines at __CLEAR and TXT_CTL_U.
SWAPNM_1:
  CALL RESFPT
  LD HL,$FFFF
  LD ($F62E),HL
  LD B,H
  LD C,L
  LD HL,(HAYASHI)
  PUSH HL
  LD A,$1A
SWAPNM_2:
  CP (HL)
  INC BC
  INC HL
  JP NZ,SWAPNM_2
  POP HL
  CALL MASDEL
  JP RESFPT

; Routine at 8832
__CSAVE:
  CP $4D
  JP Z,CSAVEM
  CALL PRPARM_4
; This entry point is used by the routine at __SAVE.
__CSAVE_0:
  DEC HL
  RST CHRGTB
  JP Z,__CSAVE_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  LD B,C
  LD E,$02
  AND A
  PUSH AF
  JP __SAVE_1
__CSAVE_1:
  CALL UPD_PTRS
  EX DE,HL
  LD HL,(BASTXT)
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  DEC HL
  LD A,H
  OR L
  JP Z,RESTART
  LD (PRLEN),HL
  PUSH HL
  CALL CAS_OPNO_BA
  CALL CAS_OPNO_CO_3
  POP DE
  LD HL,(BASTXT)

; Save the buffer pointed to by HL to tape, on exit jp to 'READY'
;
; Used by the routine at CSAVEM.
SAVE_BUFFER:
  LD C,$00
SAVE_BUFFER_0:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,SAVE_BUFFER_0
  CALL CAS_OPNO_CO_1
  JP RESTART

; SAVEM Statement
;
; Used by the routine at __SAVE.
SAVEM:
  RST CHRGTB
  CALL __NAME_1
  LD A,D
  CP $FD
  JP Z,CSAVEM_0
  CP $F8
  JP Z,CSAVEM_1
  RST $38
  LD E,H

; CSAVEM Statement
;
; Used by the routine at __CSAVE.
CSAVEM:
  RST CHRGTB
  CALL PRPARM_4
; This entry point is used by the routine at SAVEM.
CSAVEM_0:
  CALL CSAVEM_2
  CALL CAS_OPNO_CO
  CALL CAS_OPNO_CO_3
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(TOP)
  JP SAVE_BUFFER
; This entry point is used by the routine at SAVEM.
CSAVEM_1:
  CALL CSAVEM_2
  CALL RESFPT
  CALL FINDCO
  CALL NZ,KILLASC_2
  CALL NXTDIR_0
  PUSH HL
  LD HL,(CO_FILES)
  PUSH HL
  LD HL,(PRLEN)
  LD A,H
  OR L
  JP Z,CHKSTK_0
  PUSH HL
  LD BC,$0006
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,(PROGND)
  LD (TEMP),HL
  CALL NC,MAKHOL
  JP C,CHKSTK_0
  EX DE,HL
  LD HL,TOP
  CALL CLOADM_8
  LD HL,(TOP)
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
  CALL RESFPT
  JP READY
CSAVEM_2:
  CALL CSAVEM_3
  PUSH DE
  CALL CSAVEM_3
  PUSH DE
  DEC HL
  RST CHRGTB
  LD DE,L0000
  CALL NZ,CSAVEM_3
  DEC HL
  RST CHRGTB
  JP NZ,SNERR
  EX DE,HL
  LD (EXE),HL
  POP DE
  POP HL
  LD (TOP),HL
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,FCERR
  INC HL
  LD (PRLEN),HL
  RET
CSAVEM_3:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JP GETWORD

; Routine at 9079
__CLOAD:
  CP $4D
  JP Z,CLOADM
  CP $A3
  JP Z,LOAD_RECORD_3
  CALL PRPARM_1
  OR $FF
  PUSH AF
; This entry point is used by the routine at __MERGE.
__CLOAD_0:
  POP AF
  PUSH AF
  JP NZ,__CLOAD_1
  DEC HL
  RST CHRGTB
  JP NZ,FCERR
__CLOAD_1:
  DEC HL
  RST CHRGTB
  LD A,$00
  SCF
  CCF
  JP Z,__CLOAD_2
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  LD D,D
  JP NZ,SNERR
  POP AF
  SCF
  PUSH AF
  LD A,$80
__CLOAD_2:
  PUSH AF
  LD ($FCA7),A
__CLOAD_3:
  CALL CAS_OPNI_CO_1
  CP $D3
  JP Z,__CLOAD_5
  CP $9C
  JP Z,LOAD_RECORD_2
__CLOAD_4:
  CALL CAS_OPNI_CO_11
  JP __CLOAD_3
__CLOAD_5:
  POP BC
  POP AF
  PUSH AF
  PUSH BC
  JP Z,__CLOAD_4
  POP AF
  POP AF
  SBC A,A
  LD ($FC92),A
  CALL CAS_OPNI_CO_12
  CALL __NEW_0
  LD HL,(PRLEN)
  PUSH HL
  LD B,H
  LD C,L
  LD HL,(BASTXT)
  PUSH HL
  CALL MAKHOL
  JP C,CHKSTK_0
  LD HL,LOAD_RECORD_1
  LD (ERRTRP),HL
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  CALL CAS_OPNI_CO_10
  POP HL
  POP DE
  CALL LOAD_RECORD
  JP NZ,LOAD_RECORD_1
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL CTOFF
  CALL CONSOLE_CRLF
  CALL UPD_PTRS
  CALL OMERR_0
  LD A,($FC92)
  AND A
  JP NZ,EXEC_EVAL
  JP READY

; Load a record from the cassette and put it in (HL)
;
; Used by the routines at __CLOAD and CLOADM.
LOAD_RECORD:
  LD C,$00
LOAD_RECORD_0:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,LOAD_RECORD_0
  CALL CASIN
  LD A,C
  AND A
  RET
; This entry point is used by the routine at __CLOAD.
LOAD_RECORD_1:
  CALL __NEW_0
  LD HL,L0000
  LD (ERRTRP),HL
  JP HEADER_0
; This entry point is used by the routine at __CLOAD.
LOAD_RECORD_2:
  CALL CAS_OPNI_CO_12
  CALL CONSOLE_CRLF
  LD HL,(FILTAB)
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (PTRFIL),HL
  LD (HL),$01
  INC HL
  INC HL
  INC HL
  INC HL
  LD (HL),$FD
  INC HL
  INC HL
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD ($FA8E),A
  JP __MERGE_3
; This entry point is used by the routine at __CLOAD.
LOAD_RECORD_3:
  CALL PRPARM_2
  PUSH HL
  CALL CAS_OPNI_BA
  CALL CAS_OPNI_CO_10
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(BASTXT)
  CALL LDIR_B_3
  JP NZ,LOAD_RECORD_5
  LD A,(HL)
  INC HL
  OR (HL)
  JP NZ,LOAD_RECORD_5
LOAD_RECORD_4:
  CALL CTOFF
  POP HL
  RET
; This entry point is used by the routine at LDIR_B.
LOAD_RECORD_5:
  LD HL,$2481
  CALL PRINT_LINE
  JP LOAD_RECORD_4
  LD D,(HL)
  LD H,L
  LD (HL),D
  LD L,C
  LD H,(HL)
  LD A,C
  JR NZ,$24EF
  LD H,C
  LD L,C
  LD L,H
  LD H,L
  LD H,H
  DEC C
  LD A,(BC)
  NOP

; LOADM and RUNM Statement
;
; Used by the routine at __MERGE.
LOADM_RUNM:
  RST CHRGTB
  POP AF
  PUSH AF
  JP Z,FCERR
  CALL __NAME_1
  LD A,D
  CP $FD
  JP Z,CLOADM_0
  CP $F8
  JP Z,CLOADM_2
  RST $38
  LD E,(HL)

; Routine at 9383
;
; Used by the routine at __CLOAD.
CLOADM:
  RST CHRGTB
  CP $A3
  JP Z,LDIR_B_2
  CALL PRPARM_1
  OR $FF
  PUSH AF
; This entry point is used by the routine at LOADM_RUNM.
CLOADM_0:
  DEC HL
  RST CHRGTB
  JP NZ,SNERR
  PUSH HL
  CALL CAS_OPNI_CO
  LD HL,(EXE)
  LD A,H
  OR L
  JP NZ,CLOADM_1
  POP HL
  POP AF
  PUSH AF
  PUSH HL
  JP C,FCERR
CLOADM_1:
  CALL CLOADM_5
  JP C,CHKSTK_0
  CALL CAS_OPNI_CO_10
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(TOP)
  CALL LOAD_RECORD
  JP NZ,HEADER_0
  CALL CTOFF
  JP CLOADM_4
; This entry point is used by the routine at LOADM_RUNM.
CLOADM_2:
  PUSH HL
  CALL RESFPT
  CALL FINDCO
  JP Z,FFERR
  EX DE,HL
  CALL CLOADM_7
  PUSH HL
  LD HL,(EXE)
  LD A,H
  OR L
  JP NZ,CLOADM_3
  POP DE
  POP HL
  POP AF
  PUSH AF
  PUSH HL
  PUSH DE
  JP C,FCERR
CLOADM_3:
  CALL CLOADM_5
  JP C,CHKSTK_0
  LD HL,(PRLEN)
  LD B,H
  LD C,L
  LD HL,(TOP)
  EX DE,HL
  POP HL
  CALL _LDIR
CLOADM_4:
  POP HL
  POP AF
  JP NC,OMERR_1
  CALL OMERR_1
  LD HL,(EXE)
  LD (LASTCALL),HL
  CALL PIVOTCALL
  LD HL,(TEMP)
  JP EXEC_EVAL
CLOADM_5:
  CALL LDIR_B_5
; This entry point is used by the routine at LDIR_B.
CLOADM_6:
  LD HL,(HIMEM)
  EX DE,HL
  LD HL,(TOP)
  RST CPDEHL
  RET
; This entry point is used by the routine at LDIR_B.
CLOADM_7:
  LD DE,TOP
; This entry point is used by the routine at CSAVEM.
CLOADM_8:
  LD B,$06

; Move memory pointed to by HL to the memory pointed to by DE for B number of
; bytes.
;
; Used by the routines at RAM_IO, L1962, CHGDSP, TXT_CTL_L, LOAD_BA_LBL,
; SET_CLOCK_HL and BOOT.
LDIR_B:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC B
  JP NZ,LDIR_B
  RET
; This entry point is used by the routine at __MENU.
LDIR_B_0:
  CALL CLOADM_7
  PUSH HL
  CALL CLOADM_6
  JP C,LDIR_B_1
  EX DE,HL
  LD HL,(PRLEN)
  LD B,H
  LD C,L
  POP HL
  CALL _LDIR
  LD HL,(EXE)
  LD A,H
  OR L
  LD (LASTCALL),HL
  CALL NZ,PIVOTCALL
  JP __MENU
LDIR_B_1:
  CALL __BEEP
  JP __MENU
; This entry point is used by the routine at CLOADM.
LDIR_B_2:
  RST CHRGTB
  CALL PRPARM_1
  PUSH HL
  CALL CAS_OPNI_CO
  CALL CAS_OPNI_CO_10
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(TOP)
  CALL LDIR_B_3
  JP NZ,LOAD_RECORD_5
  CALL CTOFF
  POP HL
  RET
; This entry point is used by the routine at LOAD_RECORD.
LDIR_B_3:
  LD C,$00
LDIR_B_4:
  CALL CASIN
  CP (HL)
  RET NZ
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,LDIR_B_4
  CALL CASIN
  LD A,C
  AND A
  RET
; This entry point is used by the routine at CLOADM.
LDIR_B_5:
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  RET NZ

; Routine at 9643
PRPARM:
  LD HL,(TOP)
  PUSH HL
  EX DE,HL
  LD HL,$25D5
  CALL PRPARM_0
  LD HL,(PRLEN)
  DEC HL
  POP DE
  ADD HL,DE
  EX DE,HL
  LD HL,$25DB
  CALL PRPARM_0
  LD HL,(EXE)
  LD A,H
  OR L
  RET Z
  EX DE,HL
  LD HL,$25E1
PRPARM_0:
  PUSH DE
  CALL PRINT_LINE
  POP HL
  JP NUMPRT
  LD D,H
  LD L,A
  LD (HL),B
  LD A,(OUTC)
  LD B,L
  LD L,(HL)
  LD H,H
  LD A,(OUTC)
  LD B,L
  LD A,B
  LD H,L
  LD A,(OUTC)
; This entry point is used by the routines at __CLOAD, CLOADM and LDIR_B.
PRPARM_1:
  DEC HL
; This entry point is used by the routine at LOAD_RECORD.
PRPARM_2:
  RST CHRGTB
  JP NZ,PRPARM_4
  LD B,$06
  LD DE,FILNAM
  LD A,' '
PRPARM_3:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,PRPARM_3
  JP PRPARM_5
; This entry point is used by the routines at __CSAVE and CSAVEM.
PRPARM_4:
  CALL FNAME_0
  JP NZ,PRPARM_6
PRPARM_5:
  LD D,$FD
PRPARM_6:
  LD A,D
  CP $FD
  JP NZ,FCERR
  RET

; CAS open for output for BASIC files
;
; Used by the routine at __CSAVE.
CAS_OPNO_BA:
  LD A,$D3
  LD BC,$9C3E

; CAS open for output for TEXT files
;
; Used by the routine at CAS_OPN.
CAS_OPNO_DO:
  LD A,$9C
  LD BC,$D03E

; CAS open for output for Command files
;
; Used by the routine at CSAVEM.
CAS_OPNO_CO:
  LD A,$D0
  PUSH AF
  CALL IOERR_0
  POP AF
  CALL CSOUT
  LD C,$00
  LD HL,FILNAM
  LD DE,$0602
CAS_OPNO_CO_0:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC D
  JP NZ,CAS_OPNO_CO_0
  LD HL,TOP
  LD D,$0A
  DEC E
  JP NZ,CAS_OPNO_CO_0
; This entry point is used by the routines at CAS_INPUT and SAVE_BUFFER.
CAS_OPNO_CO_1:
  LD A,C
  CPL
  INC A
  CALL CSOUT
  LD B,$14
CAS_OPNO_CO_2:
  XOR A
  CALL CSOUT
  DEC B
  JP NZ,CAS_OPNO_CO_2
  JP CTOFF
; This entry point is used by the routines at CAS_INPUT, __CSAVE and CSAVEM.
CAS_OPNO_CO_3:
  CALL IOERR_0
  LD A,$8D
  JP CSOUT

; CAS open for input for BASIC files
;
; Used by the routine at LOAD_RECORD.
CAS_OPNI_BA:
  LD B,$D3
  LD DE,$9C06

; CAS open for input for text files
;
; Used by the routine at CAS_OPN.
CAS_OPNI_DO:
  LD B,$9C
  LD DE,$D006

; CAS open for input for Command files
;
; Used by the routines at CLOADM and LDIR_B.
CAS_OPNI_CO:
  LD B,$D0
CAS_OPNI_CO_0:
  PUSH BC
  CALL CAS_OPNI_CO_1
  POP BC
  CP B
  JP Z,CAS_OPNI_CO_12
  CALL CAS_OPNI_CO_11
  JP CAS_OPNI_CO_0
; This entry point is used by the routine at __CLOAD.
CAS_OPNI_CO_1:
  CALL HEADER
  CALL CASIN
  CP $D3
  JP Z,CAS_OPNI_CO_2
  CP $9C
  JP Z,CAS_OPNI_CO_2
  CP $D0
  JP NZ,CAS_OPNI_CO_1
CAS_OPNI_CO_2:
  PUSH AF
  LD HL,FILNM2
  LD DE,$0602
  LD C,$00
CAS_OPNI_CO_3:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC D
  JP NZ,CAS_OPNI_CO_3
  LD HL,TOP
  LD D,$0A
  DEC E
  JP NZ,CAS_OPNI_CO_3
  CALL CASIN
  LD A,C
  AND A
  JP NZ,CAS_OPNI_CO_9
  CALL CTOFF
  LD HL,FILNAM
  LD B,$06
  LD A,' '
CAS_OPNI_CO_4:
  CP (HL)
  JP NZ,CAS_OPNI_CO_5
  INC HL
  DEC B
  JP NZ,CAS_OPNI_CO_4
  JP CAS_OPNI_CO_7
CAS_OPNI_CO_5:
  LD DE,FILNAM
  LD HL,FILNM2
  LD B,$06
CAS_OPNI_CO_6:
  LD A,(DE)
  CP (HL)
  JP NZ,CAS_OPNI_CO_8
  INC DE
  INC HL
  DEC B
  JP NZ,CAS_OPNI_CO_6
CAS_OPNI_CO_7:
  POP AF
  RET
CAS_OPNI_CO_8:
  CALL CAS_OPNI_CO_11
CAS_OPNI_CO_9:
  POP AF
  JP CAS_OPNI_CO_1
; This entry point is used by the routines at CAS_INPUT, __CLOAD, LOAD_RECORD,
; CLOADM and LDIR_B.
CAS_OPNI_CO_10:
  CALL HEADER
  CALL CASIN
  CP $8D
  JP NZ,HEADER_0
  RET
; This entry point is used by the routine at __CLOAD.
CAS_OPNI_CO_11:
  LD DE,$2705
  JP CAS_OPNI_CO_13
; This entry point is used by the routines at __CLOAD and LOAD_RECORD.
CAS_OPNI_CO_12:
  LD DE,$26FE
CAS_OPNI_CO_13:
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  RET NZ
  EX DE,HL
  CALL PRINT_LINE
  XOR A
  LD ($FCA2),A
  LD HL,FILNM2
  CALL PRS
  JP ERAEOL
  
  LD B,(HL)
  LD L,A
  LD (HL),L
  LD L,(HL)
  LD H,H
  LD A,($5300)
  LD L,E
  LD L,C
  LD (HL),B
  JR NZ,$2745
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
CAS_OPNI_CO_14:
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
  JP Z,CAS_OPNI_CO_14
  CCF
  JP _TSTSGN_2

; STR BASIC function entry
__STR_S:
  CALL FOUT
  CALL CRTST
  CALL GSTRCU

; Save string in string area
SAVSTR:
  LD BC,TOPOOL
  PUSH BC
; This entry point is used by the routines at __LET and INSTR.
SAVSTR_0:
  LD A,(HL)
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
; This entry point is used by the routines at __CHR_S and INKEY_S.
SAVSTR_1:
  LD A,$01

; Make temporary string
;
; Used by the routines at L1962, CONCAT, __SPACE_S and INPUT_S.
MKTMST:
  CALL TESTR

; Create temporary string entry
;
; Used by the routines at SAVSTR, DTSTR and __LEFT_S.
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
; Used by the routines at __PRINT, __STR_S and PRS.
CRTST:
  DEC HL

; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,$22
; This entry point is used by the routines at __LINE and L4F2E.
; Eval quoted string
QTSTR_0:
  LD D,B

; Create String, termination char in D
;
; Used by the routine at __READ.
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
  CP $22
  CALL Z,_CHRGTB
  EX (SP),HL
  INC HL
  EX DE,HL
  LD A,C
  CALL CRTMST

; Temporary string to pool
;
; Used by the routines at TIME_S_FN, DATE_S_FN, DAY_S_FN, CONCAT, TOPOOL and
; __LEFT_S.
TSTOPL:
  LD DE,TMPSTR
  LD A,$D5
  LD HL,(TEMPPT)
  LD (DBL_FPREG),HL
  LD A,$03
  LD (VALTYP),A
  CALL HL_FAC2_0
  LD DE,FRETOP
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
; Used by the routines at JPBC, READY, __LINE, __READ, CAS_OPNI_CO, LNUM_MSG,
; INXD, USING, TEL_GET_STAT, DWNLDR, PRINT_LINE, TEXT, __EDIT, TXT_CTL_N,
; MOVE_TEXT, BOOT and FREEMEM.
PRS:
  CALL CRTST

; Print string at HL
;
; Used by the routines at __PRINT, __INPUT and USING.
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
  CALL Z,CONSOLE_CRLF_1
  INC BC
  JP PRS1_0

; Test if enough room for string
;
; Used by the routines at SAVSTR, MKTMST and __LEFT_S.
TESTR:
  OR A
  LD C,$F1
  PUSH AF
  LD HL,(STRBUF)
  EX DE,HL
  LD HL,(FRETOP)
  CPL
  LD C,A
  LD B,$FF
  ADD HL,BC
  INC HL
  RST CPDEHL
  JP C,TESTR_1
  LD (FRETOP),HL
  INC HL
  EX DE,HL
; This entry point is used by the routines at PRS_M100 and HL_CSNG.
TESTR_0:
  POP AF
  RET
TESTR_1:
  POP AF
  LD DE,$000E
  JP Z,ERROR
  CP A
  PUSH AF
  LD BC,$27CA
  PUSH BC
; This entry point is used by the routine at __FRE.
TESTR_2:
  LD HL,(FILE_BUFFR)
TESTR_3:
  LD (FRETOP),HL
  LD HL,L0000
  PUSH HL
  LD HL,(ARREND)
  PUSH HL
  LD HL,TEMPST
  EX DE,HL
  LD HL,(TEMPPT)
  EX DE,HL
  RST CPDEHL
  LD BC,$2802
  JP NZ,TESTR_9
  LD HL,$FBD9
  LD ($FBE2),HL
  LD HL,(VAREND)
  LD ($FBDF),HL
  LD HL,(PROGND)
TESTR_4:
  EX DE,HL
  LD HL,($FBDF)
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
  LD HL,($FBE2)
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,D
  OR E
  LD HL,(VAREND)
  JP Z,TESTR_8
  EX DE,HL
  LD ($FBE2),HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL
  ADD HL,DE
  LD ($FBDF),HL
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
  LD ($FB90),HL
  POP HL
  LD C,(HL)
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  INC HL
  EX DE,HL
  LD HL,($FB90)
  EX DE,HL
  RST CPDEHL
  JP Z,TESTR_8
  LD BC,$287B
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
  LD HL,(FRETOP)
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
  LD HL,(FRETOP)
  CALL INTEXP_17
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
  LD DE,$000F
  JP C,ERROR
  CALL MKTMST
  POP DE
  CALL GSTRDE
  EX (SP),HL
  CALL GSTRHL
  PUSH HL
  LD HL,($FB8A)
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
; Used by the routines at SAVSTR and __LEFT_S.
TOSTRA:
  INC L

; TOSTRA loop
;
; Used by the routine at MV_MEM.
TSALP:
  DEC L
  RET Z

; Move the memory pointed by BC to the memory pointed by DE, L times.
MV_MEM:
  LD A,(BC)
  LD (DE),A
  INC BC
  INC DE
  JP TSALP

; Get string pointed by FPREG 'Type Error' if it is not
;
; Used by the routines at __DAY_S, OUTS_B_CHARS, CAS_OPNI_CO, __LEN, INSTR and
; FNAME.
GETSTR:
  CALL TSTSTR

; Get string pointed by FPREG
;
; Used by the routines at __STR_S, PRS1 and __FRE.
GSTRCU:
  LD HL,(DBL_FPREG)

; Get string pointed by HL
;
; Used by the routines at CONCAT, INSTR and USING.
GSTRHL:
  EX DE,HL

; Get string pointed by DE
;
; Used by the routines at CAS_OPNI_CO, CONCAT and __LEFT_S.
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
  RST CPDEHL
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
  RST CPDEHL
; This entry point is used by the routine at STRING_S.
GSTRDE_2:
  RET NZ
  LD (TEMPPT),HL
  RET

; LEN
__LEN:
  LD BC,LDA_FAC1
  PUSH BC
; This entry point is used by the routines at __ASC and __VAL.
__LEN_0:
  CALL GETSTR
  XOR A
  LD D,A
  LD A,(HL)
  OR A
  RET

; ASC
__ASC:
  LD BC,LDA_FAC1
  PUSH BC
; This entry point is used by the routine at STRING_S.
__ASC_0:
  CALL __LEN_0
  JP Z,FCERR
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  RET

; CHR$
__CHR_S:
  CALL SAVSTR_1
  CALL MAKINT
; This entry point is used by the routine at INKEY_S.
__CHR_S_0:
  LD HL,($FB8A)
  LD (HL),E

; Save in string pool
;
; Used by the routine at __SPACE_S.
TOPOOL:
  POP BC
  JP TSTOPL

; STRING$
;
; Used by the routine at VARPTR_VAR.
STRING_S:
  RST CHRGTB
  RST SYNCHR
  JR Z,GSTRDE_2
  LD L,$11
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  EX (SP),HL
  PUSH HL
  RST GETYPR
  JP Z,STRING_S_0
  CALL MAKINT
  JP STRING_S_1
STRING_S_0:
  CALL __ASC_0
STRING_S_1:
  POP DE
  CALL __SPACE_S_0

; SPACE$
__SPACE_S:
  CALL MAKINT
  LD A,' '
; This entry point is used by the routine at STRING_S.
__SPACE_S_0:
  PUSH AF
  LD A,E
  CALL MKTMST
  LD B,A
  POP AF
  INC B
  DEC B
  JP Z,TOPOOL
  LD HL,($FB8A)
__SPACE_S_1:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,__SPACE_S_1
  JP TOPOOL

; LEFT$
__LEFT_S:
  CALL LFRGNM
  XOR A
; This entry point is used by the routine at __RIGHT_S.
__LEFT_S_0:
  EX (SP),HL
  LD C,A
  LD A,$E5
  PUSH HL
  LD A,(HL)
  CP B
  JP C,$29BB
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
  CALL CRTMST
  LD L,A
  CALL TOSTRA
  POP DE
  CALL GSTRDE
  JP TSTOPL

; RIGHT$
__RIGHT_S:
  CALL LFRGNM
  POP DE
  PUSH DE
  LD A,(DE)
  SUB B
  JP __LEFT_S_0

; MID$
__MID_S:
  EX DE,HL
  LD A,(HL)
  CALL MIDNUM
  INC B
  DEC B
  JP Z,FCERR
  PUSH BC
  CALL INSTR_11
  POP AF
  EX (SP),HL
  LD BC,$29B3
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

; VAL
__VAL:
  CALL __LEN_0
  JP Z,LDA_FAC1
  LD E,A
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  PUSH HL
  ADD HL,DE
  LD B,(HL)
  LD ($F67E),HL
  LD A,B
  LD ($FBE6),A
  LD (HL),D
  EX (SP),HL
  PUSH BC
  DEC HL
  RST CHRGTB
  CALL DBL_ASCTFP
  LD HL,L0000
  LD ($F67E),HL
  POP BC
  POP HL
  LD (HL),B
  RET

; number in program listing and check for ending ')'
;
; Used by the routines at __LEFT_S and __RIGHT_S.
LFRGNM:
  EX DE,HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'

; Get number in program listing
;
; Used by the routine at __MID_S.
MIDNUM:
  POP BC
  POP DE
  PUSH BC
  LD B,E
  RET

; INSTR
;
; Used by the routine at VARPTR_VAR.
INSTR:
  RST CHRGTB
  CALL OPNPAR
  RST GETYPR
  LD A,$01
  PUSH AF
  JP Z,INSTR_0
  POP AF
  CALL MAKINT
  OR A
  JP Z,FCERR
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  CALL TSTSTR
INSTR_0:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  LD HL,(DBL_FPREG)
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
  LD BC,BCDEFP_FAC2_2
  PUSH BC
  LD BC,LDA_FAC1
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
INSTR_1:
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
INSTR_2:
  PUSH HL
  PUSH DE
  PUSH BC
INSTR_3:
  LD A,(DE)
  CP (HL)
  JP NZ,INSTR_6
  INC DE
  DEC C
  JP Z,INSTR_5
  INC HL
  DEC B
  JP NZ,INSTR_3
  POP DE
  POP DE
  POP BC
INSTR_4:
  POP DE
  XOR A
  RET
INSTR_5:
  POP HL
  POP DE
  POP DE
  POP BC
  LD A,B
  SUB H
  ADD A,C
  INC A
  RET
INSTR_6:
  POP BC
  POP DE
  POP HL
  INC HL
  DEC B
  JP NZ,INSTR_2
  JP INSTR_4
; This entry point is used by the routine at IDERR.
INSTR_7:
  RST SYNCHR
  JR Z,INSTR_1
  SUB B
  LD B,A
  CALL TSTSTR
  PUSH HL
  PUSH DE
  EX DE,HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD HL,(ARREND)
  RST CPDEHL
  JP C,INSTR_8
  LD HL,(BASTXT)
  RST CPDEHL
  JP NC,INSTR_8
  POP HL
  PUSH HL
  CALL SAVSTR_0
  POP HL
  PUSH HL
  CALL HL_FAC2_0
INSTR_8:
  POP HL
  EX (SP),HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  OR A
  JP Z,FCERR
  PUSH AF
  LD A,(HL)
  CALL INSTR_11
  PUSH DE
  CALL FDTLP_1
  PUSH HL
  CALL GETSTR
  EX DE,HL
  POP HL
  POP BC
  POP AF
  LD B,A
  EX (SP),HL
  PUSH HL
  LD HL,BCDEFP_FAC2_2
  EX (SP),HL
  LD A,C
  OR A
  RET Z
  LD A,(HL)
  SUB B
  JP C,FCERR
  INC A
  CP C
  JP C,INSTR_9
  LD A,C
INSTR_9:
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
INSTR_10:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC C
  RET Z
  DEC B
  JP NZ,INSTR_10
  RET
; This entry point is used by the routine at __MID_S.
INSTR_11:
  LD E,$FF
  CP $29
  JP Z,INSTR_12
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
INSTR_12:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  RET

; FRE
__FRE:
  LD HL,(ARREND)
  EX DE,HL
  LD HL,L0000
  ADD HL,SP
  RST GETYPR
  JP NZ,IMP_0
  CALL GSTRCU
  CALL TESTR_2
  EX DE,HL
  LD HL,(STRBUF)
  EX DE,HL
  LD HL,(FRETOP)
  JP IMP_0

; Double precision subtract (FAC1=FAC1-FAC2).
;
; Used by the routines at __SIN, __ATN, __EXP and __RND.
DECSUB:
  LD HL,FAC2
  LD A,(HL)
  OR A
  RET Z
  XOR $80
  LD (HL),A
  JP DECADD_0
; This entry point is used by the routine at __NEXT.
DECSUB_0:
  CALL HL_FAC2

; Double precision addition (FAC1=FAC1+FAC2)
;
; Used by the routines at __LOG, __SQR, __EXP, __RND, NEGAFT, __INT and FADD.
DECADD:
  LD HL,FAC2
  LD A,(HL)
  OR A
  RET Z
; This entry point is used by the routine at DECSUB.
DECADD_0:
  AND $7F
  LD B,A
  LD DE,FACCU
  LD A,(DE)
  OR A
  JP Z,REV_LDDR_B_0
  AND $7F
  SUB B
  JP NC,DECADD_2
  CPL
  INC A
  PUSH AF
  PUSH HL
  LD B,$08
DECADD_1:
  LD A,(DE)
  LD C,(HL)
  LD (HL),A
  LD A,C
  LD (DE),A
  INC DE
  INC HL
  DEC B
  JP NZ,DECADD_1
  POP HL
  POP AF
DECADD_2:
  CP $10
  RET NC
  PUSH AF
  XOR A
  LD ($FC20),A
  LD ($FC71),A
  LD HL,$FC6A
  POP AF
  CALL BCDADD_8
  LD HL,FAC2
  LD A,(FACCU)
  XOR (HL)
  JP M,DECADD_3
  LD A,($FC71)
  LD ($FC20),A
  CALL DECADD_13
  JP NC,DECADD_10
  EX DE,HL
  LD A,(HL)
  INC (HL)
  XOR (HL)
  JP M,OVERR
  CALL BCDADD_13
  LD A,(HL)
  OR $10
  LD (HL),A
  JP DECADD_10
DECADD_3:
  CALL BCDADD_0
  
  
; This entry point is used by the routines at DECMUL and __RND.
; Single precision normalization
DECNRM:
  LD HL,$FC19
  LD BC,STEP_7
DECADD_5:
  LD A,(HL)
  OR A
  JP NZ,DECADD_6
  INC HL
  DEC C
  DEC C
  DEC B
  JP NZ,DECADD_5
  JP _TSTSGN_4
DECADD_6:
  AND $F0
  JP NZ,DECADD_7
  PUSH HL
  CALL BCDADD_4
  POP HL
  DEC C
DECADD_7:
  LD A,$08
  SUB B
  JP Z,DECADD_9
  PUSH AF
  PUSH BC
  LD C,B
  LD DE,$FC19
  CALL DBL_DIV_17
  POP BC
  POP AF
  LD B,A
  XOR A
DECADD_8:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,DECADD_8
DECADD_9:
  LD A,C
  OR A
  JP Z,DECADD_10
  LD HL,FACCU
  LD B,(HL)
  ADD A,(HL)
  LD (HL),A
  XOR B
  JP M,OVERR
  RET Z
; This entry point is used by the routine at _ASCTFP.
DECADD_10:
  LD HL,$FC20
  LD B,$07
; This entry point is used by the routines at __CSNG and PUFOUT.
DECADD_11:
  LD A,(HL)
  CP $50
  RET C
  DEC HL
  XOR A
  SCF
DECADD_12:
  ADC A,(HL)
  DAA
  LD (HL),A
  RET NC
  DEC HL
  DEC B
  JP NZ,DECADD_12
  LD A,(HL)
  INC (HL)
  XOR (HL)
  JP M,OVERR
  INC HL
  LD (HL),$10
  RET
DECADD_13:
  LD HL,$FC70
  LD DE,$FC1F
  LD B,$07
; This entry point is used by the routines at DECMUL and DBL_DIV.
DECADD_14:
  XOR A

; Add the BCD number in (HL) to (DE).  Result in (DE)
BCDADD:
  LD A,(DE)
  ADC A,(HL)
  DAA
  LD (DE),A
  DEC DE
  DEC HL
  DEC B
  JP NZ,BCDADD
  RET
; This entry point is used by the routine at DECADD.
BCDADD_0:
  LD HL,$FC71
  LD A,(HL)
  CP $50
  JP NZ,BCDADD_1
  INC (HL)
BCDADD_1:
  LD DE,$FC20
  LD B,$08
  SCF
BCDADD_2:
  LD A,$99
  ADC A,$00
  SUB (HL)
  LD C,A
  LD A,(DE)
  ADD A,C
  DAA
  LD (DE),A
  DEC DE
  DEC HL
  DEC B
  JP NZ,BCDADD_2
  RET C
  EX DE,HL
  LD A,(HL)
  XOR $80
  LD (HL),A
  LD HL,$FC20
  LD B,$08
  XOR A
BCDADD_3:
  LD A,$9A
  SBC A,(HL)
  ADC A,$00
  DAA
  CCF
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,BCDADD_3
  RET
; This entry point is used by the routine at DECADD.
BCDADD_4:
  LD HL,$FC20
; This entry point is used by the routine at DBL_DIV.
BCDADD_5:
  PUSH BC
  LD D,B
  LD C,$04
BCDADD_6:
  PUSH HL
  OR A
BCDADD_7:
  LD A,(HL)
  RLA
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,BCDADD_7
  LD B,D
  POP HL
  DEC C
  JP NZ,BCDADD_6
  POP BC
  RET
; This entry point is used by the routine at DECADD.
BCDADD_8:
  OR A
  RRA
  PUSH AF
  OR A
  JP Z,BCDADD_15
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
  CALL LDIR_C
  POP BC
  POP AF
  INC HL
  INC DE
  PUSH DE
  LD B,A
  XOR A
BCDADD_9:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,BCDADD_9
  POP HL
  POP AF
  RET NC
  LD A,C
BCDADD_10:
  PUSH BC
  PUSH DE
  LD D,A
  LD C,$04
BCDADD_11:
  LD B,D
  PUSH HL
  OR A
BCDADD_12:
  LD A,(HL)
  RRA
  LD (HL),A
  INC HL
  DEC B
  JP NZ,BCDADD_12
  POP HL
  DEC C
  JP NZ,BCDADD_11
  POP DE
  POP BC
  RET
; This entry point is used by the routines at DECADD and PUFOUT.
BCDADD_13:
  LD HL,$FC19
BCDADD_14:
  LD A,$08
  JP BCDADD_10
BCDADD_15:
  POP AF
  RET NC
  JP BCDADD_14

; Double precision multiply (FAC1=FAC1*FAC2)
;
; Used by the routines at __LOG, ADDPHL, NEGAFT, FMULT and DECEXP.
DECMUL:
  RST TSTSGN
  RET Z
  LD A,(FAC2)
  OR A
  JP Z,_TSTSGN_4
  LD B,A
  LD HL,FACCU
  XOR (HL)
  AND $80
  LD C,A
  LD A,B
  AND $7F
  LD B,A
  LD A,(HL)
  AND $7F
  ADD A,B
  LD B,A
  LD (HL),$00
  AND $C0
  RET Z
  CP $C0
  JP NZ,DECMUL_0
  JP OVERR
DECMUL_0:
  LD A,B
  ADD A,$40
  AND $7F
  RET Z
  OR C
  DEC HL
  LD (HL),A
  LD DE,$FC67
  LD BC,SYNCHR
  LD HL,$FC1F
  PUSH DE
  CALL LDIR_C
  INC HL
  XOR A
  LD B,$08
DECMUL_1:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,DECMUL_1
  POP DE
  LD BC,DECMUL_9
  PUSH BC
; This entry point is used by the routine at __RND.
DECMUL_2:
  CALL DECMUL_10
  PUSH HL
  LD BC,SYNCHR
  EX DE,HL
  CALL LDIR_C
  EX DE,HL
  LD HL,$FC5F
  LD B,$08
  CALL DECADD_14
  POP DE
  CALL DECMUL_10
  LD C,$07
  LD DE,$FC70
DECMUL_3:
  LD A,(DE)
  OR A
  JP NZ,DECMUL_4
  DEC DE
  DEC C
  JP DECMUL_3
DECMUL_4:
  LD A,(DE)
  DEC DE
  PUSH DE
  LD HL,$FC2F
DECMUL_5:
  ADD A,A
  JP C,DECMUL_7
  JP Z,DECMUL_8
DECMUL_6:
  LD DE,SYNCHR
  ADD HL,DE
  JP DECMUL_5
DECMUL_7:
  PUSH AF
  LD B,$08
  LD DE,$FC1F
  PUSH HL
  CALL DECADD_14
  POP HL
  POP AF
  JP DECMUL_6
DECMUL_8:
  LD B,$0F
  LD DE,$FC26
  LD HL,$FC27
  CALL REV_LDDR_B
  LD (HL),$00
  POP DE
  DEC C
  JP NZ,DECMUL_4
  RET
; This entry point is used by the routine at DBL_DIV.
DECMUL_9:
  DEC HL
  LD A,(HL)
  INC HL
  LD (HL),A
  JP DECNRM		; Single precision normalization
  
DECMUL_10:
  LD HL,$FFF8
  ADD HL,DE
  LD C,$03
DECMUL_11:
  LD B,$08
  OR A
DECMUL_12:
  LD A,(DE)
  ADC A,A
  DAA
  LD (HL),A
  DEC HL
  DEC DE
  DEC B
  JP NZ,DECMUL_12
  DEC C
  JP NZ,DECMUL_11
  RET

; Double precision DIVIDE
;
; Used by the routines at __TAN, __ATN, __LOG, __SQR, __EXP, ADDPHL, FDIV_BCDE
; and INTEXP.
DBL_DIV:
  LD A,(FAC2)
  OR A
  JP Z,OERR
  LD B,A
  LD HL,FACCU
  LD A,(HL)
  OR A
  JP Z,_TSTSGN_4
  XOR B
  AND $80
  LD C,A
  LD A,B
  AND $7F
  LD B,A
  LD A,(HL)
  AND $7F
  SUB B
  LD B,A
  RRA
  XOR B
  AND $40
  LD (HL),$00
  JP Z,DBL_DIV_1
  LD A,B
  AND $80
  RET NZ
DBL_DIV_0:
  JP OVERR
DBL_DIV_1:
  LD A,B
  ADD A,$41
  AND $7F
  LD (HL),A
  JP Z,DBL_DIV_0
  OR C
  LD (HL),$00
  DEC HL
  LD (HL),A
  LD DE,$FC1F
  LD HL,$FC70
  LD B,$07
DBL_DIV_2:
  LD A,(HL)
  OR A
  JP NZ,DBL_DIV_3
  DEC DE
  DEC HL
  DEC B
  JP NZ,DBL_DIV_2
DBL_DIV_3:
  LD ($FC14),HL
  EX DE,HL
  LD ($FC12),HL
  LD A,B
  LD ($FC16),A
  LD HL,HOLD
DBL_DIV_4:
  LD B,$0F
DBL_DIV_5:
  PUSH HL
  PUSH BC
  LD HL,($FC14)
  EX DE,HL
  LD HL,($FC12)
  LD A,($FC16)
  LD C,$FF
DBL_DIV_6:
  SCF
  INC C
  LD B,A
  PUSH HL
  PUSH DE
DBL_DIV_7:
  LD A,$99
  ADC A,$00
  EX DE,HL
  SUB (HL)
  EX DE,HL
  ADD A,(HL)
  DAA
  LD (HL),A
  DEC HL
  DEC DE
  DEC B
  JP NZ,DBL_DIV_7
  LD A,(HL)
  CCF
  SBC A,$00
  LD (HL),A
  POP DE
  POP HL
  LD A,($FC16)
  JP NC,DBL_DIV_6
  LD B,A
  EX DE,HL
  CALL DECADD_14
  JP NC,DBL_DIV_8
  EX DE,HL
  INC (HL)
DBL_DIV_8:
  LD A,C
  POP BC
  LD C,A
  PUSH BC
  LD A,B
  OR A
  RRA
  LD B,A
  INC B
  LD E,B
  LD D,$00
  LD HL,$FC17
  ADD HL,DE
  CALL BCDADD_5
  POP BC
  POP HL
  LD A,B
  INC C
  DEC C
  JP NZ,DBL_DIV_13
  CP $0F
  JP Z,DBL_DIV_12
  RRCA
  RLCA
  JP NC,DBL_DIV_13
  PUSH BC
  PUSH HL
  LD HL,FACCU
  LD B,$08
DBL_DIV_9:
  LD A,(HL)
  OR A
  JP NZ,DBL_DIV_11
  INC HL
  DEC B
  JP NZ,DBL_DIV_9
  POP HL
  POP BC
  LD A,B
  OR A
  RRA
  INC A
  LD B,A
  XOR A
DBL_DIV_10:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,DBL_DIV_10
  JP DBL_DIV_16
DBL_DIV_11:
  POP HL
  POP BC
  LD A,B
  JP DBL_DIV_13
DBL_DIV_12:
  LD A,($FC17)
  LD E,A
  DEC A
  LD ($FC17),A
  XOR E
  JP P,DBL_DIV_4
  JP _TSTSGN_4
DBL_DIV_13:
  RRA
  LD A,C
  JP C,DBL_DIV_14
  OR (HL)
  LD (HL),A
  INC HL
  JP DBL_DIV_15
DBL_DIV_14:
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD (HL),A
DBL_DIV_15:
  DEC B
  JP NZ,DBL_DIV_5
DBL_DIV_16:
  LD HL,$FC20
  LD DE,$FC67
  LD B,$08
  CALL REV_LDDR_B
  JP DECMUL_9
; This entry point is used by the routine at DECADD.
DBL_DIV_17:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC C
  JP NZ,DBL_DIV_17
  RET

; Move (HL) to (DE), C times.
;
; Used by the routines at BCDADD and DECMUL.
LDIR_C:
  LD A,(HL)
  LD (DE),A
  DEC HL
  DEC DE
  DEC C
  JP NZ,LDIR_C
  RET

; COS
;
; Used by the routine at __TAN.
__COS:
  LD HL,FP_EPSILON
  CALL ADDPHL
  LD A,(FACCU)
  AND $7F
  LD (FACCU),A
  LD HL,FP_QUARTER
  CALL __RND_3
  CALL INVSGN_0
  JP __SIN_0

; Routine at 12041
;
; Used by the routine at __TAN.
__SIN:
  LD HL,FP_EPSILON
  CALL ADDPHL
; This entry point is used by the routine at __COS.
__SIN_0:
  LD A,(FACCU)
  OR A
  CALL M,NEGAFT
  CALL PUSH_FAC2
  CALL __INT
  CALL FAC1_FAC2
  CALL POP_FAC1
  CALL DECSUB
  LD A,(FACCU)
  CP $40
  JP C,__SIN_2
  LD A,($FC19)
  CP $25
  JP C,__SIN_2
  CP $75
  JP NC,__SIN_1
  CALL FAC1_FAC2
  LD HL,FP_HALF
  CALL HL2FACCU
  CALL DECSUB
  JP __SIN_2
__SIN_1:
  LD HL,FP_UNITY
  CALL HL2ARG
  CALL DECSUB
__SIN_2:
  LD HL,FP_SINTAB
  JP SUMSER

; Routine at 12120
__TAN:
  CALL PUSH_FAC2
  CALL __COS
  CALL L31CA_1
  CALL __SIN
  CALL POP_FAC2
  LD A,(FAC2)
  OR A
  JP NZ,DBL_DIV
  JP OVERR

; ATN
__ATN:
  LD A,(FACCU)
  OR A
  RET Z
  CALL M,NEGAFT
  CP $41
  JP C,__ATN_0
  CALL FAC1_FAC2
  LD HL,FP_UNITY
  CALL HL2FACCU
  CALL DBL_DIV
  CALL __ATN_0
  CALL FAC1_FAC2
  LD HL,FP_HALFPI
  CALL HL2FACCU
  JP DECSUB
__ATN_0:
  LD HL,FP_TAN15
  CALL ADDPHL_0
  JP M,__ATN_1
  CALL PUSH_FAC2
  LD HL,FP_SQR3
  CALL __RND_2
  CALL L31CA_1
  LD HL,FP_SQR3
  CALL ADDPHL
  LD HL,FP_UNITY
  CALL __RND_3
  CALL POP_FAC2
  CALL DBL_DIV
  CALL __ATN_1
  LD HL,FP_SIXTHPI
  JP __RND_2
__ATN_1:
  LD HL,FP_ATNTAB
  JP SUMSER

; LOG
;
; Used by the routine at DECEXP.
__LOG:
  RST TSTSGN
  JP M,FCERR
  JP Z,FCERR
  LD HL,FACCU
  LD A,(HL)
  PUSH AF
  LD (HL),$41
  LD HL,FP_10EXHALF
  CALL ADDPHL_0
  JP M,__LOG_0
  POP AF
  INC A
  PUSH AF
  LD HL,FACCU
  DEC (HL)
__LOG_0:
  POP AF
  LD (TEMP3),A
  CALL PUSH_FAC2
  LD HL,FP_UNITY
  CALL __RND_2
  CALL L31CA_1
  LD HL,FP_UNITY
  CALL __RND_3
  CALL POP_FAC2
  CALL DBL_DIV
  CALL PUSH_FAC2
  CALL DBL_SQUARE
  CALL PUSH_FAC2
  CALL PUSH_FAC2
  LD HL,FP_LOGTAB2
  CALL NEGAFT_2
  CALL L31CA_1
  LD HL,FP_LOGTAB
  CALL NEGAFT_2
  CALL POP_FAC2
  CALL DBL_DIV
  CALL POP_FAC2
  CALL DECMUL
  LD HL,FP_TWODLN10
  CALL __RND_2
  CALL POP_FAC2
  CALL DECMUL
  CALL PUSH_FAC2
  LD A,(TEMP3)
  SUB $41
  LD L,A
  ADD A,A
  SBC A,A
  LD H,A
  CALL HL_CSNG
  CALL __CDBL_0
  CALL POP_FAC2
  CALL DECADD
  LD HL,FP_LN10
  JP ADDPHL

; SQR
__SQR:
  RST TSTSGN
  RET Z
  JP M,FCERR
  CALL FAC1_FAC2
  LD A,(FACCU)
  OR A
  RRA
  ADC A,$20
  LD (FAC2),A
  LD A,($FC19)
  OR A
  RRCA
  OR A
  RRCA
  AND $33
  ADD A,$10
  LD ($FC6A),A
  LD A,$07
__SQR_0:
  LD (TEMP3),A
  CALL PUSH_FAC2
  CALL PUSH_FAC1
  CALL DBL_DIV
  CALL POP_FAC2
  CALL DECADD
  LD HL,FP_HALF
  CALL ADDPHL
  CALL FAC1_FAC2
  CALL POP_FAC1
  LD A,(TEMP3)
  DEC A
  JP NZ,__SQR_0
  JP FAC2_FAC1

; Routine at 12452
;
; Used by the routine at DECEXP.
__EXP:
  LD HL,FP_LOG10E
  CALL ADDPHL
  CALL PUSH_FAC2
  CALL __CINT
  LD A,L
  RLA
  SBC A,A
  CP H
  JP Z,__EXP_1
  LD A,H
  OR A
  JP P,__EXP_0
  CALL __CDBL_1
  CALL POP_FAC1
  LD HL,FP_ZERO
  JP HL2FACCU
__EXP_0:
  JP OVERR
__EXP_1:
  LD (TEMP3),HL
  CALL __CDBL
  CALL FAC1_FAC2
  CALL POP_FAC1
  CALL DECSUB
  LD HL,FP_HALF
  CALL ADDPHL_0
  PUSH AF
  JP Z,__EXP_2
  JP C,__EXP_2
  LD HL,FP_HALF
  CALL __RND_3
__EXP_2:
  CALL PUSH_FAC2
  LD HL,FP_EXPTAB2
  CALL SUMSER
  CALL L31CA_1
  LD HL,FP_EXPTAB1
  CALL NEGAFT_0
  CALL POP_FAC2
  CALL PUSH_FAC1
  CALL PUSH_FAC2
  CALL DECSUB
  LD HL,HOLD
  CALL L31CA
  CALL POP_FAC2
  CALL POP_FAC1
  CALL DECADD
  LD HL,HOLD
  CALL HL2ARG
  CALL DBL_DIV
  POP AF
  JP C,__EXP_3
  JP Z,__EXP_3
  LD HL,FP_10EXHALF
  CALL ADDPHL
__EXP_3:
  LD A,(TEMP3)
  LD HL,FACCU
  LD C,(HL)
  ADD A,(HL)
  LD (HL),A
  XOR C
  RET P
  JP OVERR

; Routine at 12606
__RND:
  RST TSTSGN
  LD HL,RNDX
  JP Z,__RND_0
  CALL M,L31CA
  LD HL,HOLD
  LD DE,RNDX
  CALL DBL2HL
  LD HL,RNDTAB_1
  CALL HL2ARG
  LD HL,RNDTAB_2
  CALL HL2FACCU
  LD DE,$FC67
  CALL DECMUL_2
  LD DE,$FC20
  LD HL,SEEDRD
  LD B,$07
  CALL REV_LDIR_B
  LD HL,RNDX
  LD (HL),$00
__RND_0:
  CALL HL2FACCU
  LD HL,FACCU
  LD (HL),$40
  XOR A
  LD ($FC20),A
  JP DECNRM		; Single precision normalization
  
; This entry point is used by the routine at SETMAX.
__RND_1:
  LD DE,RNDX_INIT
  LD HL,RNDX
  JP DBL2HL
  CALL HL_CSNG
  LD HL,RNDX
  JP L31CA
; This entry point is used by the routines at __ATN and __LOG.
__RND_2:
  CALL HL2ARG
  JP DECADD
; This entry point is used by the routines at __COS, __ATN, __LOG and __EXP.
__RND_3:
  CALL HL2ARG
  JP DECSUB

; Double precision square of FAC1 (FAC1=FAC1 squared)
;
; Used by the routines at __LOG and NEGAFT.
DBL_SQUARE:
  LD HL,FACCU

; ADD number at HL to BCDE
;
; Used by the routines at __COS, __SIN, __ATN, __LOG, __SQR, __EXP, NEGAFT and
; INTEXP.
ADDPHL:
  CALL HL2ARG
  JP DECMUL
  CALL HL2ARG
  JP DBL_DIV
; This entry point is used by the routines at __ATN, __LOG and __EXP.
ADDPHL_0:
  CALL HL2ARG
  JP CMP_HLDE_1

; Move FAC1 to FAC2
;
; Used by the routines at __SIN, __ATN, __SQR, __EXP, INTEXP and NULSUB.
FAC1_FAC2:
  LD HL,FACCU

; Move the floating point buffer in (HL) to FAC2.
;
; Used by the routines at __SIN, __EXP, __RND, ADDPHL and NEGAFT.
HL2ARG:
  LD DE,FAC2
; This entry point is used by the routine at HL2FACCU.
HL2ARG_0:
  EX DE,HL
  CALL DBL2HL
  EX DE,HL
  RET

; Move FAC2 to FAC1
;
; Used by the routines at __SQR, L31CA, DECEXP and INTEXP.
FAC2_FAC1:
  LD HL,FAC2

; Move (HL) to FAC1
;
; Used by the routines at __SIN, __ATN, __EXP, __RND, NEGAFT, PUFOUT, DECEXP
; and INTEXP.
HL2FACCU:
  LD DE,FACCU
  JP HL2ARG_0

; Move FAC1 to (HL)
;
; Used by the routines at __EXP, __RND, NEGAFT, DECEXP and INTEXP.
L31CA:
  LD DE,FACCU
; This entry point is used by the routines at __RND and HL2ARG.
DBL2HL:
  LD B,$08
  JP REV_LDIR_B
; This entry point is used by the routines at __TAN, __ATN, __LOG, __EXP, FEXP
; and DECEXP.
L31CA_1:
  POP HL
  LD (FBUFFR),HL
  CALL POP_FAC2
  CALL PUSH_FAC2
  CALL FAC2_FAC1
  LD HL,(FBUFFR)
  JP (HL)

; Negate number
;
; Used by the routines at __SIN and __ATN.
NEGAFT:
  CALL INVSGN_0
  LD HL,INVSGN_0
  EX (SP),HL
  JP (HL)
; This entry point is used by the routine at __EXP.
NEGAFT_0:
  LD (FBUFFR),HL
  CALL DBL_SQUARE
  LD HL,(FBUFFR)
  JP NEGAFT_2

; This entry point is used by the routines at __SIN, __ATN and __EXP.
; Routine at 12791
SUMSER:
  LD (FBUFFR),HL
; Routine at 12792
  CALL PUSH_FAC2
  LD HL,(FBUFFR)
  CALL NEGAFT_0
  CALL POP_FAC2
  JP DECMUL
  
; This entry point is used by the routine at __LOG.
NEGAFT_2:
  LD A,(HL)
  PUSH AF
  INC HL
  PUSH HL
  LD HL,FBUFFR
  CALL L31CA
  POP HL
  CALL HL2FACCU
SUMLP:
  POP AF
  DEC A
  RET Z
  PUSH AF
  PUSH HL
  LD HL,FBUFFR
  CALL ADDPHL
  POP HL
  CALL HL2ARG
  PUSH HL
  CALL DECADD
  POP HL
  JP SUMLP

; Push FAC1 on stack
;
; Used by the routines at __SQR, __EXP, FEXP and INTEXP.
PUSH_FAC1:
  LD HL,$FC70
  JP PUSH_FAC2_0

; Push FAC2 on stack
;
; Used by the routines at __SIN, __TAN, __ATN, __LOG, __SQR, __EXP, L31CA,
; NEGAFT, DECEXP and INTEXP.
PUSH_FAC2:
  LD HL,$FC1F
; This entry point is used by the routine at PUSH_FAC1.
PUSH_FAC2_0:
  LD A,$04
  POP DE
PUSH_FAC2_1:
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  PUSH BC
  DEC A
  JP NZ,PUSH_FAC2_1
  EX DE,HL
  JP (HL)

; Pop FAC2 off stack
;
; Used by the routines at __TAN, __ATN, __LOG, __SQR, __EXP, L31CA, NEGAFT,
; FEXP, DECEXP and INTEXP.
POP_FAC2:
  LD HL,FAC2
  JP POP_FAC1_0

; Pop FAC1 off stack
;
; Used by the routines at __SIN, __SQR, __EXP and INTEXP.
POP_FAC1:
  LD HL,FACCU
; This entry point is used by the routine at POP_FAC2.
POP_FAC1_0:
  LD A,$04
  POP DE
POP_FAC1_1:
  POP BC
  LD (HL),C
  INC HL
  LD (HL),B
  INC HL
  DEC A
  JP NZ,POP_FAC1_1
  EX DE,HL
  JP (HL)

; $325C
RNDTAB_2:
  DEFB $00
  DEFB $14
  DEFM "8"
  DEFB $98
  DEFM " B"
  DEFB $08
  DEFM "!"

; $3264
RNDTAB_1:
  DEFB $00
  DEFM "!"
  DEFB $13
  DEFM "$"
  DEFB $86
  DEFM "T"
  DEFB $05  
  DEFB $19

; $326C
; Constant to initialize the "last random number" variable
RNDX_INIT:
  DEFB $00
  DEFM "@d"
  DEFB $96
  DEFM "Q7#X"

; Routine at 12916
;
; Constant ptr for LOG(e)
FP_LOG10E:
  LD B,B
  LD B,E
  LD B,D
  SUB H
  LD C,B
  ADD HL,DE
  INC BC
  INC H

; Routine at 12924
;
; Constant ptr for 0.5 in FP
FP_HALF:
  LD B,B
  LD D,B

; Routine at 12926
;
; Constant ptr for 'zero' in FP
FP_ZERO:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP

; Routine at 12934
;
; Constant ptr for 1 in FP
FP_UNITY:
  LD B,C
  DJNZ FP_UNITY_0
FP_UNITY_0:
  NOP
  NOP
  NOP
  NOP
  NOP

; Routine at 12942
;
; Constant ptr for 0.25 in FP
FP_QUARTER:
  LD B,B
  DEC H
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP

; Routine at 12950
;
; Constant ptr for 10^(1/2) in FP
FP_10EXHALF:
  LD B,C
  LD SP,$2762
  HALT
  LD H,B
  LD D,$84

; Routine at 12958
;
; Constant ptr for 2/LN(10) in FP
FP_TWODLN10:
  LD B,B
  ADD A,(HL)
  ADD A,L
  ADC A,B
  SUB (HL)
  JR C,FP_LN10_0
  LD D,B

; Routine at 12966
;
; Constant ptr for LN(10) in FP
FP_LN10:
  LD B,C
  INC HL
  LD (BC),A
  LD E,B
  LD D,B
; This entry point is used by the routine at FP_TWODLN10.
FP_LN10_0:
  SUB D
  SBC A,C
  LD B,B

; Routine at 12974
;
; Half PI constant ptr
FP_HALFPI:
  LD B,C
  DEC D
  LD (HL),B
  LD A,C
  LD H,E
  LD H,$79
  LD C,C

; Routine at 12982
;
; Constant ptr for TAN(15) in FP
FP_TAN15:
  DEFM "@&yI"
  DEFB $19
  DEFM "$1"
  DEFB $12

; Routine at 12990
;
; Constant ptr for SQR(3) in FP
FP_SQR3:
  DEFM "A"
  DEFB $17
  DEFM "2"
  DEFB $05
  DEFB $08
  DEFB $07
  DEFM "V"
  DEFB $89

; Routine at 12998
;
; Constant ptr for PI/6 in FP
FP_SIXTHPI:
  DEFM "@R5"
  DEFB $98
  DEFM "wU"
  DEFB $98
  DEFM "0"

; Routine at 13006
;
; Epsilon constant ptr
FP_EPSILON:
  DEFM "@"
  DEFB $15
  DEFB $91
  DEFM "T"
  DEFB $94
  DEFM "0"
  DEFB $91
  DEFB $90

; Routine at 13014
;
; Ptr to first exponent table
FP_EXPTAB1:
  INC B
  LD B,C
  DJNZ FP_EXPTAB1_0
FP_EXPTAB1_0:
  NOP
  NOP
  NOP
  NOP
  NOP
  LD B,E
  DEC D
  SUB E
  LD (HL),H
  DEC D
  INC HL
  LD H,B
  LD SP,$2744
  ADD HL,BC
  LD SP,$4069
  ADD A,L
; This entry point is used by the routine at FP_SINTAB.
FP_EXPTAB1_1:
  LD D,$44
  LD B,H
  SUB A
  LD H,E
  DEC (HL)
  LD D,A
  LD B,B
  LD E,B

; Routine at 13047
;
; Ptr to second exponent table
FP_EXPTAB2:
  INC BC
  LD B,D
  JR $332C
  INC HL
  LD H,B
  DEC D
  SUB D
  LD (HL),L
  LD B,E
  ADD A,E
  INC D
  LD B,$72
  LD (DE),A
  SUB E
  LD (HL),C
  LD B,H
  LD D,C
  LD A,B
  ADD HL,BC
  ADD HL,DE
  SUB C
  LD D,C
; This entry point is used by the routine at FP_SIXTHPI.
FP_EXPTAB2_0:
  LD H,D

; Routine at 13072
;
; First table used by LOG
FP_LOGTAB:
  INC B
  RET NZ
  LD (HL),C
  LD B,E
  INC SP
  ADD A,D
  DEC D
  LD ($4126),A
  LD H,D
  LD D,B
  LD (HL),$51
  LD (DE),A
  LD A,C
  EX AF,AF'
  JP NZ,$6813
  INC HL
  LD (HL),B
  INC H
  DEC D
  INC BC
  LD B,C
  ADD A,L
  LD D,$73
  ADD HL,DE
  ADD A,A
  INC HL
  ADC A,C

; Routine at 13105
;
; Second table used by LOG
FP_LOGTAB2:
  DEC B
  LD B,C
  DJNZ FP_LOGTAB2_0
FP_LOGTAB2_0:
  NOP
  NOP
  NOP
  NOP
  NOP
  JP NZ,__NEW_1
  INC B
  LD A,B
  DEC (HL)
  LD BC,$4256
  LD B,A
  SUB D
  LD D,D
  LD D,(HL)
  INC B
  JR C,FP_ATNTAB_0
  JP NZ,$9064
  LD H,(HL)
  ADD A,D
  LD (HL),H
  ADD HL,BC
  LD B,E
  LD B,D
  ADD HL,HL
  LD B,C
  LD D,A
  LD D,B
  RLA
  INC HL
  INC HL

; Routine at 13146
;
; Table used by SIN/COS/TAN
FP_SINTAB:
  EX AF,AF'
  RET NZ
  LD L,C
  LD HL,$9256
  ADD HL,HL
  JR $336C
  LD B,C
  JR C,$337D
  JR Z,FP_EXPTAB1_1
  JR C,FP_ATNTAB_1
  LD (HL),C
  JP NZ,__RUN_0
  LD B,H
  SBC A,C
  LD B,A
  LD C,B
  LD BC,$4242
  DEC B
  ADD A,(HL)
  ADC A,C
  LD H,(HL)
  LD (HL),E
  LD D,L
  JP NZ,$7076
  LD E,B
  LD E,C
  LD L,B
  LD ($4291),A
  ADD A,C
  LD H,B
  LD D,D
  LD C,C
  DAA
  LD D,L
  INC DE
  JP NZ,BCDEFP_0
  RLA
  LD (BC),A
  INC H
  INC BC
  SBC A,B
  LD B,C
  LD H,D
  ADD A,E
  JR _TSTSGN_3
  RLCA
  RLA
  SUB (HL)

; Routine at 13211
;
; Table used by ATN/TAN
FP_ATNTAB:
  EX AF,AF'
  CP A
  LD D,D
  EX AF,AF'
  LD L,C
  ADD HL,SP
  INC B
  NOP
  NOP
  CCF
  LD (HL),L
  JR NC,$3419
  LD C,C
  INC DE
  LD C,B
  NOP
  CP A
  SUB B
  ADD A,C
  INC (HL)
  LD ($7024),A
  LD D,B
  LD B,B
  LD DE,$0711
  SUB H
  JR $33FB
  ADD HL,HL
  RET NZ
; This entry point is used by the routine at FP_LOGTAB2.
FP_ATNTAB_0:
  INC D
  JR Z,$3416
  EX AF,AF'
; This entry point is used by the routine at FP_SINTAB.
FP_ATNTAB_1:
  LD D,L
  LD C,B
  ADD A,H
  LD B,B
  ADD HL,DE
  SBC A,C
  SBC A,C
  SBC A,C
  SUB H
  ADC A,C
  LD H,A
  RET NZ
  INC SP
  INC SP
  INC SP
  INC SP
  INC SP
  LD SP,$4160
  DJNZ FP_ATNTAB_2
FP_ATNTAB_2:
  NOP
  NOP
  NOP
  NOP
  NOP

; Test sign of FPREG
;
; Used by the routines at TSTSGN, __TSTSGN, BCDE_FP_CMP and CMP_HLDE.
_TSTSGN:
  LD A,(FACCU)
  OR A
  RET Z
  LD A,(FACCU)
  JP _TSTSGN_1
; This entry point is used by the routine at CMP_FAC1FAC2.
_TSTSGN_0:
  CPL
; This entry point is used by the routines at __TSTSGN and CMP_HLDE.
_TSTSGN_1:
  RLA
; This entry point is used by the routines at CAS_OPNI_CO and CMP_HLDE.
_TSTSGN_2:
  SBC A,A
  RET NZ
; This entry point is used by the routine at FP_SINTAB.
_TSTSGN_3:
  INC A
  RET
; This entry point is used by the routines at DECADD, DECMUL, DBL_DIV and
; __INT.
_TSTSGN_4:
  XOR A
  LD (FACCU),A
  RET

; ATN
__ABS:
  CALL __TSTSGN
  RET P

; Invert number sign
;
; Used by the routines at VARPTR_VAR, __FIX, _ASCTFP and PUFOUT.
INVSGN:
  RST GETYPR
  JP M,DBL_ABS
  JP Z,TMERR
; This entry point is used by the routines at __COS, NEGAFT, HL_CSNG, __FIX,
; INT_MUL and FDIV.
INVSGN_0:
  LD HL,FACCU
  LD A,(HL)
  OR A
  RET Z
  XOR $80
  LD (HL),A
  RET

; Routine at 13319
__SGN:
  CALL __TSTSGN

; Get back from function, result in A (signed)
;
; Used by the routines at DCXH, __EOF and CSRLIN.
INT_RESULT_A:
  LD L,A
  RLA
  SBC A,A
  LD H,A
  JP HL_FAC1

; Test sign in number
;
; Used by the routines at __IF, __ABS, __SGN and PUFOUT.
__TSTSGN:
  RST GETYPR
  JP Z,TMERR
  JP P,_TSTSGN
  LD HL,(DBL_FPREG)
; This entry point is used by the routine at STEP.
__TSTSGN_0:
  LD A,H
  OR L
  RET Z
  LD A,H
  JP _TSTSGN_1

; Put FP value on stack
;
; Used by the routines at EVAL3, IDIV, IADD and INT_MUL.
STAKI:
  EX DE,HL
  LD HL,(DBL_FPREG)
  EX (SP),HL
  PUSH HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  RET

; Number at HL to BCDE
PHLTFP:
  CALL LOADFP

; Move BCDE to FPREG
;
; Used by the routine at EVAL3.
FPBCDE:
  EX DE,HL
  LD (DBL_FPREG),HL
  LD H,B
  LD L,C
  LD (FACCU),HL
  EX DE,HL
  RET

; Load the single precision value in FAC1 into BCDE
;
; Used by the routines at STEP and EVAL3.
BCDEFP:
  LD HL,(DBL_FPREG)
  EX DE,HL
; This entry point is used by the routine at FP_SINTAB.
BCDEFP_0:
  LD HL,(FACCU)
  LD C,L
  LD B,H
  RET

; Load 4 byte single precision buffer in HL into BCDE
;
; Used by the routine at __NEXT.
HLBCDE:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  RET

; Load FP value pointed by HL to BCDE
;
; Used by the routines at TESTR, PHLTFP, DBL_ABS and __NEXT.
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
; This entry point is used by the routines at EXEC_HL, PUFOUT, TEL_TERM and
; BOOT.
LOADFP_1:
  INC HL
  RET

; Move the single precision number in FAC1 to (HL)
;
; Used by the routine at __NEXT.
FAC1_HL:
  LD DE,FACCU
  LD B,$04
  JP REV_LDIR_B

; Move the buffer pointed to by HL to FAC2
;
; Used by the routines at DECSUB and __NEXT.
HL_FAC2:
  LD DE,FAC2
  EX DE,HL
; This entry point is used by the routines at STEP, __LET, TSTOPL and INSTR.
HL_FAC2_0:
  LD A,(VALTYP)
  LD B,A

; Move the memory from (DE) to (HL) for B bytes
;
; Used by the routines at __IPL, ON_TIME_S, MAKTXT, __RND, L31CA, FAC1_HL and
; BOOT.
REV_LDIR_B:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC B
  JP NZ,REV_LDIR_B
  RET

; Move the memory from (DE) to (HL) for B bytes, pointers are decremented
;
; Used by the routines at DECMUL and DBL_DIV.
REV_LDDR_B:
  LD A,(DE)
  LD (HL),A
  DEC DE
  DEC HL
  DEC B
  JP NZ,REV_LDDR_B
  RET
; This entry point is used by the routine at DECADD.
REV_LDDR_B_0:
  LD HL,FAC2
; This entry point is used by the routines at VAR_EVAL and __NEXT.
REV_LDDR_B_1:
  LD DE,$3464
  JP REV_LDDR_B_4
; This entry point is used by the routine at EVAL3.
REV_LDDR_B_2:
  LD HL,FAC2
; This entry point is used by the routines at STEP and __NEXT.
REV_LDDR_B_3:
  LD DE,HL_FAC2_0
REV_LDDR_B_4:
  PUSH DE
  LD DE,FACCU
  LD A,(VALTYP)
  CP $02
  RET NZ
  LD DE,DBL_FPREG
  RET

; Compare the single precision number in BCDE with FAC1.
;
; Used by the routines at GETWORD, HL_FAC1 and __NEXT.
BCDE_FP_CMP:
  LD A,C
  OR A
  JP Z,_TSTSGN
  LD HL,_TSTSGN_0
  PUSH HL
  RST TSTSGN
  LD A,C
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  CALL BCDE_FP_CMP_0
  RRA
  XOR C
  RET
BCDE_FP_CMP_0:
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

; Compare the signed integer in DE to the signed integer in HL
;
; Used by the routine at __NEXT.
CMP_HLDE:
  LD A,D
  XOR H
  LD A,H
  JP M,_TSTSGN_1
  CP D
  JP NZ,CMP_HLDE_0
  LD A,L
  SUB E
  RET Z
CMP_HLDE_0:
  JP _TSTSGN_2
; This entry point is used by the routines at ADDPHL, CMP_FAC1FAC2, INTEXP and
; __NEXT.
CMP_HLDE_1:
  LD DE,FAC2
  LD A,(DE)
  OR A
  JP Z,_TSTSGN
  LD HL,_TSTSGN_0
  PUSH HL
  RST TSTSGN
  LD A,(DE)
  LD C,A
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  LD B,$08
CMP_HLDE_2:
  LD A,(DE)
  SUB (HL)
  JP NZ,CMP_HLDE_3
  INC DE
  INC HL
  DEC B
  JP NZ,CMP_HLDE_2
  POP BC
  RET
CMP_HLDE_3:
  RRA
  XOR C
  RET

; Compare the double precision numbers in FAC1 and FAC2
CMP_FAC1FAC2:
  CALL CMP_HLDE_1
  JP NZ,_TSTSGN_0
  RET

; Routine at 13569
;
; Used by the routines at TO, EVAL3, NOT, _GETYPR, DEPINT and __EXP.
__CINT:
  RST GETYPR
  LD HL,(DBL_FPREG)
  RET M
  JP Z,TMERR
  CALL TSTSTR_0
  JP C,OVERR
  EX DE,HL

; Load the signed integer in HL into FAC1
;
; Used by the routines at VARPTR_VAR, LDA_FAC1, INT_RESULT_A, __INT, INT_MUL,
; INT_DIV, DBL_ASCTFP, NUMPRT and INTEXP.
HL_FAC1:
  LD (DBL_FPREG),HL
; This entry point is used by the routine at DBL_ABS.
HL_FAC1_0:
  LD A,$02
; This entry point is used by the routine at __CDBL.
HL_FAC1_1:
  LD (VALTYP),A
  RET
; This entry point is used by the routine at _ASCTFP.
HL_FAC1_2:
  LD BC,$32C5
  LD DE,$8076
  CALL BCDE_FP_CMP
  RET NZ
  LD HL,$8000
; This entry point is used by the routine at IADD.
HL_FAC1_3:
  POP DE
  JP HL_FAC1

; Convert the number in FAC1 to single precision.
;
; Used by the routines at STEP, EVAL3, GETWORD and _ASCTFP.
__CSNG:
  RST GETYPR
  RET PO
  JP M,INT_CSNG
  JP Z,TMERR
  CALL __CDBL_2
  CALL $3D04
  INC HL
  LD A,B
  OR A
  RRA
  LD B,A
  JP DECADD_11

; Convert the signed integer in FAC1 to single precision.
;
; Used by the routines at __CSNG, __CDBL, _ASCTFP and PUFOUT.
INT_CSNG:
  LD HL,(DBL_FPREG)

; Convert the signed integer in HL to a single precision number
;
; Used by the routines at EVAL3, IDIV, __LOG, __RND, IADD, INT_MUL and
; INTEXP.
HL_CSNG:
  LD A,H
; This entry point is used by the routine at DBL_ABS.
HL_CSNG_0:
  OR A
  PUSH AF
  CALL M,INT_DIV_6
  CALL __CDBL_2
  EX DE,HL
  LD HL,L0000
  LD (FACCU),HL
  LD (DBL_FPREG),HL
  LD A,D
  OR E
  JP Z,TESTR_0
  LD BC,$0500
  LD HL,$FC19
  PUSH HL
  LD HL,HL_CSNG_8
HL_CSNG_1:
  LD A,$FF
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  PUSH BC
HL_CSNG_2:
  LD B,H
  LD C,L
  ADD HL,DE
  INC A
  JP C,HL_CSNG_2
  LD H,B
  LD L,C
  POP BC
  POP DE
  EX DE,HL
  INC C
  DEC C
  JP NZ,HL_CSNG_3
  OR A
  JP Z,HL_CSNG_6
  PUSH AF
  LD A,$40
  ADD A,B
  LD (FACCU),A
  POP AF
HL_CSNG_3:
  INC C
  EX (SP),HL
  PUSH AF
  LD A,C
  RRA
  JP NC,HL_CSNG_4
  POP AF
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD (HL),A
  JP HL_CSNG_5
HL_CSNG_4:
  POP AF
  OR (HL)
  LD (HL),A
  INC HL
HL_CSNG_5:
  EX (SP),HL
HL_CSNG_6:
  LD A,D
  OR E
  JP Z,HL_CSNG_7
  DEC B
  JP NZ,HL_CSNG_1
HL_CSNG_7:
  POP HL
  POP AF
  RET P
  JP INVSGN_0
HL_CSNG_8:
  RET P
  RET C
  JR HL_CSNG_8
  SBC A,H
  RST $38
  OR $FF
  RST $38
  RST $38

; Routine at 13754
;
; Used by the routines at STEP, EVAL3, UCASE, __EXP, _ASCTFP, PUFOUT and
; NULSUB.
__CDBL:
  RST GETYPR
  RET NC
  JP Z,TMERR
  CALL M,INT_CSNG
; This entry point is used by the routines at __LOG, FADD, FMULT, FDIV_BCDE,
; FEXP and INTEXP.
__CDBL_0:
  LD HL,L0000
  LD ($FC1C),HL
  LD ($FC1E),HL
  LD A,H
  LD ($FC20),A
; This entry point is used by the routines at __EXP and DECEXP.
__CDBL_1:
  LD A,$08
  JP __CDBL_3
; This entry point is used by the routines at __CSNG and HL_CSNG.
__CDBL_2:
  LD A,$04
__CDBL_3:
  JP HL_FAC1_1

; Test a string, 'Type Error' if it is not
;
; Used by the routines at __LINE, UCASE, CONCAT, GETSTR, INSTR, USING and
; L4F2E.
TSTSTR:
  RST GETYPR
  RET Z
  JP TMERR
; This entry point is used by the routines at __CINT and INTEXP.
TSTSTR_0:
  LD HL,$3641
  PUSH HL
  LD HL,FACCU
  LD A,(HL)
  AND $7F
  CP $46
  RET NC
  SUB $41
  JP NC,TSTSTR_1
  OR A
  POP DE
  LD DE,L0000
  RET
TSTSTR_1:
  INC A
  LD B,A
  LD DE,L0000
  LD C,D
  INC HL
TSTSTR_2:
  LD A,C
  INC C
  RRA
  LD A,(HL)
  JP C,TSTSTR_3
  RRA
  RRA
  RRA
  RRA
  JP TSTSTR_4
TSTSTR_3:
  INC HL
TSTSTR_4:
  AND $0F
  LD ($FC12),HL
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
  LD HL,($FC12)
  DEC B
  JP NZ,TSTSTR_2
  LD HL,$8000
  RST CPDEHL
  LD A,(FACCU)
  RET C
  JP Z,TSTSTR_5
  POP HL
  OR A
  RET P
  EX DE,HL
  CALL INT_DIV_6
  EX DE,HL
  OR A
  RET
TSTSTR_5:
  OR A
  RET P
  POP HL
  RET
  SCF
  RET
; This entry point is used by the routine at PRS_M100.
TSTSTR_6:
  DEC BC
  RET

; Double Precision to Integer conversion
__FIX:
  RST GETYPR
  RET M
  RST TSTSGN
  JP P,__INT
  CALL INVSGN_0
  CALL __INT
  JP INVSGN

; Routine at 13908
;
; Used by the routines at __SIN, __FIX and INTEXP.
__INT:
  RST GETYPR
  RET M
  LD HL,$FC20
  LD C,$0E
  JP NC,__INT_0
  JP Z,TMERR
  LD HL,$FC1C
  LD C,$06
__INT_0:
  LD A,(FACCU)
  OR A
  JP M,__INT_2
  AND $7F
  SUB $41
  JP C,_TSTSGN_4
  INC A
  SUB C
  RET NC
  CPL
  INC A
  LD B,A
__INT_1:
  DEC HL
  LD A,(HL)
  AND $F0
  LD (HL),A
  DEC B
  RET Z
  XOR A
  LD (HL),A
  DEC B
  JP NZ,__INT_1
  RET
__INT_2:
  AND $7F
  SUB $41
  JP NC,__INT_3
  LD HL,$FFFF
  JP HL_FAC1
__INT_3:
  INC A
  SUB C
  RET NC
  CPL
  INC A
  LD B,A
  LD E,$00
__INT_4:
  DEC HL
  LD A,(HL)
  LD D,A
  AND $F0
  LD (HL),A
  CP D
  JP Z,__INT_5
  INC E
__INT_5:
  DEC B
  JP Z,__INT_7
  XOR A
  LD (HL),A
  CP D
  JP Z,__INT_6
  INC E
__INT_6:
  DEC B
  JP NZ,__INT_4
__INT_7:
  INC E
  DEC E
  RET Z
  LD A,C
  CP $06
  LD BC,$10C1
  LD DE,L0000
  JP Z,DBL_ABS_2
  EX DE,HL
  LD ($FC6F),HL
  LD ($FC6D),HL
  LD (FAC2_INT),HL
  LD H,B
  LD L,C
  LD (FAC2),HL
  JP DECADD

; Multiply DE by BC
;
; Used by the routine at BSERR.
MLDEBC:
  PUSH HL
  LD HL,L0000
  LD A,B
  OR C
  JP Z,MLDEBC_2
  LD A,$10
MLDEBC_0:
  ADD HL,HL
  JP C,BSERR
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,MLDEBC_1
  ADD HL,BC
  JP C,BSERR
MLDEBC_1:
  DEC A
  JP NZ,MLDEBC_0
MLDEBC_2:
  EX DE,HL
  POP HL
  RET

; Subtract the signed integer in HL from the signed integer in DE.
ISUB:
  LD A,H
  RLA
  SBC A,A
  LD B,A
  CALL INT_DIV_6
  LD A,C
  SBC A,B
  JP IADD_0

; Routine at 14084
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
  JP P,HL_FAC1_3
  PUSH BC
  EX DE,HL
  CALL HL_CSNG
  POP AF
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP DBL_ABS_2

; Integer MULTIPLY
;
; Used by the routine at INTEXP.
INT_MUL:
  LD A,H
  OR L
  JP Z,HL_FAC1
  PUSH HL
  PUSH DE
  CALL INT_DIV_3
  PUSH BC
  LD B,H
  LD C,L
  LD HL,L0000
  LD A,$10
INT_MUL_0:
  ADD HL,HL
  JP C,INT_MUL_4
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,INT_MUL_1
  ADD HL,BC
  JP C,INT_MUL_4
INT_MUL_1:
  DEC A
  JP NZ,INT_MUL_0
  POP BC
  POP DE
; This entry point is used by the routine at INT_DIV.
INT_MUL_2:
  LD A,H
  OR A
  JP M,INT_MUL_3
  POP DE
  LD A,B
  JP INT_DIV_5
INT_MUL_3:
  XOR $80
  OR L
  JP Z,INT_MUL_6
  EX DE,HL
  JP INT_MUL_5
INT_MUL_4:
  POP BC
  POP HL
INT_MUL_5:
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP FMULT_BCDE
INT_MUL_6:
  LD A,B
  OR A
  POP BC
  JP M,HL_FAC1
  PUSH DE
  CALL HL_CSNG
  POP DE
  JP INVSGN_0

; Divide the signed integer in DE by the signed integer in HL.
;
; Used by the routines at _GETYPR and DBL_ABS.
INT_DIV:
  LD A,H
  OR L
  JP Z,OERR
  CALL INT_DIV_3
  PUSH BC
  EX DE,HL
  CALL INT_DIV_6
  LD B,H
  LD C,L
  LD HL,L0000
  LD A,$11
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
  JP INT_DIV_2
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
  JP INT_MUL_2
; This entry point is used by the routine at INT_MUL.
INT_DIV_3:
  LD A,H
  XOR D
  LD B,A
  CALL INT_DIV_4
  EX DE,HL
INT_DIV_4:
  LD A,H
; This entry point is used by the routines at INT_MUL and DBL_ABS.
INT_DIV_5:
  OR A
  JP P,HL_FAC1
; This entry point is used by the routines at HL_CSNG, TSTSTR, ISUB, DBL_ABS
; and INTEXP.
INT_DIV_6:
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
  JP HL_FAC1

; ABS (double precision BASIC variant)
;
; Used by the routine at INVSGN.
DBL_ABS:
  LD HL,(DBL_FPREG)
  CALL INT_DIV_6
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at ERL, IMP, NAXRAM and L1DB9.
DBL_ABS_0:
  XOR A
  JP HL_CSNG_0
; This entry point is used by the routine at _GETYPR.
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
  CALL HL_FAC1_0
  POP AF
  JP INT_DIV_5
  CALL LOADFP
; This entry point is used by the routines at GETWORD, __INT, IADD, FDIV and
; __NEXT.
DBL_ABS_2:
  CALL BCDEFP_FAC2

; Add the single precision numbers in FAC1 and FAC2
FADD:
  CALL __CDBL_0
  JP DECADD

; Subtract the single precision numbers in FAC1 and BCDE
FDIV:
  CALL INVSGN_0
  JP DBL_ABS_2

; Multiply the single precision numbers in FAC1 and BCDE
;
; Used by the routine at INT_MUL.
FMULT_BCDE:
  CALL BCDEFP_FAC2

; Multiply the single precision numbers in FAC1 and FAC2
FMULT:
  CALL __CDBL_0
  JP DECMUL
; This entry point is used by the routine at IDIV.
FMULT_0:
  POP BC
  POP DE

; Single precision divide (FAC1=BCDE/FAC1)
FDIV_BCDE:
  LD HL,(DBL_FPREG)
  EX DE,HL
  LD (DBL_FPREG),HL
  PUSH BC
  LD HL,(FACCU)
  EX (SP),HL
  LD (FACCU),HL
  POP BC
  CALL BCDEFP_FAC2
  CALL __CDBL_0
  JP DBL_DIV

; Load FAC2 with the single precision number in BCDE
;
; Used by the routines at DBL_ABS, FMULT_BCDE, FDIV_BCDE and FEXP.
BCDEFP_FAC2:
  EX DE,HL
  LD (FAC2_INT),HL
  LD H,B
  LD L,C
  LD (FAC2),HL
  LD HL,L0000
  LD ($FC6D),HL
  LD ($FC6F),HL
  RET
; This entry point is used by the routine at PUFOUT.
DCR_A:
  DEC A
  RET
; This entry point is used by the routine at PUFOUT.
BCDEFP_FAC2_1:
  DEC HL
  RET
; This entry point is used by the routine at SCPTLP.
BCDEFP_FAC2_2:
  POP HL
  RET

; ASCII to Double precision FP number
;
; Used by the routines at __READ, OPRND, __VAL and L4F2E.
DBL_ASCTFP:
  EX DE,HL
  LD BC,$00FF
  LD H,B
  LD L,B
  CALL HL_FAC1
  EX DE,HL
  LD A,(HL)

; ASCII to FP number
_ASCTFP:
  CP $2D
  PUSH AF
  JP Z,_ASCTFP_0
  CP $2B
  JP Z,_ASCTFP_0
  DEC HL
_ASCTFP_0:
  RST CHRGTB
  JP C,_ASCTFP_20
  CP $2E
  JP Z,_ASCTFP_14
  CP $65
  JP Z,_ASCTFP_1
  CP $45
_ASCTFP_1:
  JP NZ,_ASCTFP_4
  PUSH HL
  RST CHRGTB
  CP $6C
  JP Z,_ASCTFP_2
  CP $4C
  JP Z,_ASCTFP_2
  CP $71
  JP Z,_ASCTFP_2
  CP $51
_ASCTFP_2:
  POP HL
  JP Z,_ASCTFP_3
  RST GETYPR
  JP NC,_ASCTFP_5
  XOR A
  JP _ASCTFP_6
_ASCTFP_3:
  LD A,(HL)
_ASCTFP_4:
  CP $25
  JP Z,_ASCTFP_16
  CP '#'
  JP Z,_ASCTFP_17
  CP $21
  JP Z,_ASCTFP_18
  CP $64
  JP Z,_ASCTFP_5
  CP $44
  JP NZ,_ASCTFP_10
_ASCTFP_5:
  OR A
_ASCTFP_6:
  CALL _ASCTFP_19
  RST CHRGTB
  PUSH DE
  LD D,$00
  CALL UCASE_5
  LD C,D
  POP DE
_ASCTFP_7:
  RST CHRGTB
  JP NC,_ASCTFP_9
  LD A,E
  CP $0C
  JP NC,_ASCTFP_8
  RLCA
  RLCA
  ADD A,E
  RLCA
  ADD A,(HL)
  SUB $30
  LD E,A
  JP _ASCTFP_7
_ASCTFP_8:
  LD E,$80
  JP _ASCTFP_7
_ASCTFP_9:
  INC C
  JP NZ,_ASCTFP_10
  XOR A
  SUB E
  LD E,A
_ASCTFP_10:
  RST GETYPR
  JP M,_ASCTFP_11
  LD A,(FACCU)
  OR A
  JP Z,_ASCTFP_11
  LD A,D
  SUB B
  ADD A,E
  ADD A,$40
  LD (FACCU),A
  OR A
  CALL M,_ASCTFP_13
_ASCTFP_11:
  POP AF
  PUSH HL
  CALL Z,INVSGN
  RST GETYPR
  JP NC,_ASCTFP_12
  POP HL
  RET PE
  PUSH HL
  LD HL,BCDEFP_FAC2_2
  PUSH HL
  CALL HL_FAC1_2
  RET
_ASCTFP_12:
  CALL DECADD_10
  POP HL
  RET
_ASCTFP_13:
  JP OVERR
_ASCTFP_14:
  RST GETYPR
  INC C
  JP NZ,_ASCTFP_10
  JP NC,_ASCTFP_15
  CALL _ASCTFP_19
  LD A,(FACCU)
  OR A
  JP NZ,_ASCTFP_15
  LD D,A
_ASCTFP_15:
  JP _ASCTFP_0
_ASCTFP_16:
  RST CHRGTB
  POP AF
  PUSH HL
  LD HL,BCDEFP_FAC2_2
  PUSH HL
  LD HL,__CINT
  PUSH HL
  PUSH AF
  JP _ASCTFP_10
_ASCTFP_17:
  OR A
_ASCTFP_18:
  CALL _ASCTFP_19
  RST CHRGTB
  JP _ASCTFP_10
_ASCTFP_19:
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
_ASCTFP_20:
  SUB $30
  JP NZ,_ASCTFP_21
  OR C
  JP Z,_ASCTFP_21
  AND D
  JP Z,_ASCTFP_0
_ASCTFP_21:
  INC D
  LD A,D
  CP $07
  JP NZ,_ASCTFP_22
  OR A
  CALL _ASCTFP_19
_ASCTFP_22:
  PUSH DE
  LD A,B
  ADD A,C
  INC A
  LD B,A
  PUSH BC
  PUSH HL
  LD A,(HL)
  SUB $30
  PUSH AF
  RST GETYPR
  JP P,_ASCTFP_26
  LD HL,(DBL_FPREG)
  LD DE,$0CCD
  RST CPDEHL
  JP NC,_ASCTFP_25
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
  JP M,_ASCTFP_24
  LD (DBL_FPREG),HL
_ASCTFP_23:
  POP HL
  POP BC
  POP DE
  JP _ASCTFP_0
_ASCTFP_24:
  LD A,C
  PUSH AF
_ASCTFP_25:
  CALL INT_CSNG
_ASCTFP_26:
  POP AF
  POP HL
  POP BC
  POP DE
  JP NZ,_ASCTFP_27
  LD A,(FACCU)
  OR A
  LD A,$00
  JP NZ,_ASCTFP_27
  LD D,A
  JP _ASCTFP_0
_ASCTFP_27:
  PUSH DE
  PUSH BC
  PUSH HL
  PUSH AF
  LD HL,FACCU
  LD (HL),$01
  LD A,D
  CP $10
  JP C,_ASCTFP_28
  POP AF
  JP _ASCTFP_23
_ASCTFP_28:
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
  JP NC,_ASCTFP_29
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
_ASCTFP_29:
  OR (HL)
  LD (HL),A
  JP _ASCTFP_23

; 'in' <line number> message
;
; Used by the routine at JPBC.
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
  CALL HL_FAC1
  XOR A
  LD (TEMP3),A
  LD HL,NUMSTR
  LD (HL),$20
  OR (HL)
  JP PUFOUT_1

; Convert the binary number in FAC1 to ASCII
;
; Used by the routines at __PRINT, __STR_S and PUFOUT.
FOUT:
  XOR A
; This entry point is used by the routine at USING.
FOUT_0:
  CALL PUFOUT_59

; Convert the binary number in FAC1 to ASCII.  A - Bit configuration for PRINT
; USING options
PUFOUT:
  AND $08
  JP Z,PUFOUT_0
  LD (HL),$2B
PUFOUT_0:
  EX DE,HL
  CALL __TSTSGN
  EX DE,HL
  JP P,PUFOUT_1
  LD (HL),$2D
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H
; This entry point is used by the routine at NUMPRT.
PUFOUT_1:
  INC HL
  LD (HL),$30
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,PUFOUT_15
  JP Z,PUFOUT_13
  CP $04
  JP NC,PUFOUT_7
  LD BC,L0000
  CALL PUFOUT_55
PUFOUT_2:
  LD HL,NUMSTR
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
  RST CHRGTB
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
PUFOUT_7:
  PUSH HL
  CALL $3D04
  LD D,B
  INC D
  LD BC,$0300
  LD A,(FACCU)
  SUB $3F
  JP C,PUFOUT_8
  INC D
  CP D
  JP NC,PUFOUT_8
  INC A
  LD B,A
  LD A,$02
PUFOUT_8:
  SUB $02
  POP HL
  PUSH AF
  CALL PUFOUT_45
  LD (HL),$30
  CALL Z,LOADFP_1
  CALL PUFOUT_51
PUFOUT_9:
  DEC HL
  LD A,(HL)
  CP $30
  JP Z,PUFOUT_9
  CP $2E
  CALL NZ,LOADFP_1
  POP AF
  JP Z,PUFOUT_14
PUFOUT_10:
  LD (HL),$45
  INC HL
  LD (HL),$2B
  JP P,PUFOUT_11
  LD (HL),$2D
  CPL
  INC A
PUFOUT_11:
  LD B,$2F
PUFOUT_12:
  INC B
  SUB $0A
  JP NC,PUFOUT_12
  ADD A,$3A
  INC HL
  LD (HL),B
  INC HL
  LD (HL),A
PUFOUT_13:
  INC HL
PUFOUT_14:
  LD (HL),$00
  EX DE,HL
  LD HL,NUMSTR
  RET
PUFOUT_15:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,PUFOUT_24
  RRA
  JP C,PUFOUT_31
  LD BC,$0603
  CALL PUFOUT_44
  POP DE
  LD A,D
  SUB $05
  CALL P,PUFOUT_37
  CALL PUFOUT_55
PUFOUT_16:
  LD A,E
  OR A
  CALL Z,BCDEFP_FAC2_1
  DEC A
  CALL P,PUFOUT_37
PUFOUT_17:
  PUSH HL
  CALL PUFOUT_2
  POP HL
  JP Z,PUFOUT_18
  LD (HL),B
  INC HL
PUFOUT_18:
  LD (HL),$00
  LD HL,FBUFFR
PUFOUT_19:
  INC HL
PUFOUT_20:
  LD A,(NXTOPR)
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP $20
  JP Z,PUFOUT_19
  CP $2A
  JP Z,PUFOUT_19
  DEC HL
  PUSH HL
  PUSH AF
  LD BC,$3B12
  PUSH BC
  RST CHRGTB
  CP $2D
  RET Z
  CP $2B
  RET Z
  CP $24
  RET Z
  POP BC
  CP $30
  JP NZ,PUFOUT_23
  INC HL
  RST CHRGTB
  JP NC,PUFOUT_23
  DEC HL
  JP PUFOUT_22
PUFOUT_21:
  DEC HL
  LD (HL),A
PUFOUT_22:
  POP AF
  JP Z,PUFOUT_21
  POP BC
  JP PUFOUT_20
PUFOUT_23:
  POP AF
  JP Z,PUFOUT_23
  POP HL
  LD (HL),$25
  RET
PUFOUT_24:
  PUSH HL
  RRA
  JP C,PUFOUT_32
  CALL $3D04
  LD D,B
  LD A,(FACCU)
  SUB $4F
  JP C,PUFOUT_25
  POP HL
  POP BC
  CALL FOUT
  LD HL,FBUFFR
  LD (HL),$25
  RET
PUFOUT_25:
  RST TSTSGN
  CALL NZ,PUFOUT_63
  POP HL
  POP BC
  JP M,PUFOUT_26
  PUSH BC
  LD E,A
  LD A,B
  SUB D
  SUB E
  CALL P,PUFOUT_37
  CALL PUFOUT_42
  CALL PUFOUT_51
  OR E
  CALL NZ,PUFOUT_41
  OR E
  CALL NZ,PUFOUT_47
  POP DE
  JP PUFOUT_16
PUFOUT_26:
  LD E,A
  LD A,C
  OR A
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,E
  JP M,PUFOUT_27
  XOR A
PUFOUT_27:
  PUSH BC
  PUSH AF
  CALL M,PUFOUT_60
  POP BC
  LD A,E
  SUB B
  POP BC
  LD E,A
  ADD A,D
  LD A,B
  JP M,PUFOUT_28
  SUB D
  SUB E
  CALL P,PUFOUT_37
  PUSH BC
  CALL PUFOUT_42
  JP PUFOUT_29
PUFOUT_28:
  CALL PUFOUT_37
  LD A,C
  CALL PUFOUT_49
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL PUFOUT_37
  PUSH BC
  LD B,A
  LD C,A
PUFOUT_29:
  CALL PUFOUT_51
  POP BC
  OR C
  JP NZ,PUFOUT_30
  LD HL,(NXTOPR)
PUFOUT_30:
  ADD A,E
  DEC A
  CALL P,PUFOUT_37
  LD D,B
  JP PUFOUT_17
PUFOUT_31:
  PUSH HL
  PUSH DE
  CALL INT_CSNG
  POP DE
PUFOUT_32:
  CALL $3D04
  LD E,B
  RST TSTSGN
  PUSH AF
  CALL NZ,PUFOUT_63
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
  JP P,PUFOUT_33
  CALL PUFOUT_60
  JP NZ,PUFOUT_33
  PUSH HL
  CALL BCDADD_13
  LD HL,FACCU
  INC (HL)
  POP HL
PUFOUT_33:
  POP AF
  PUSH BC
  PUSH AF
  JP M,PUFOUT_34
  XOR A
PUFOUT_34:
  CPL
  INC A
  ADD A,B
  INC A
  ADD A,D
  LD B,A
  LD C,$00
  CALL Z,PUFOUT_45
  CALL PUFOUT_51
  POP AF
  CALL P,PUFOUT_39
  CALL PUFOUT_47
  POP BC
  POP AF
  JP NZ,PUFOUT_35
  CALL BCDEFP_FAC2_1
  LD A,(HL)
  CP $2E
  CALL NZ,LOADFP_1
  LD (NXTOPR),HL
PUFOUT_35:
  POP AF
  LD A,(FACCU)
  JP Z,PUFOUT_36
  ADD A,E
  SUB B
  SUB D
PUFOUT_36:
  PUSH BC
  CALL PUFOUT_10
  EX DE,HL
  POP DE
  JP PUFOUT_17
PUFOUT_37:
  OR A
PUFOUT_38:
  RET Z
  DEC A
  LD (HL),$30
  INC HL
  JP PUFOUT_38
PUFOUT_39:
  JP NZ,PUFOUT_41
PUFOUT_40:
  RET Z
  CALL PUFOUT_47
PUFOUT_41:
  LD (HL),$30
  INC HL
  DEC A
  JP PUFOUT_40
PUFOUT_42:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
PUFOUT_43:
  SUB $03
  JP NC,PUFOUT_43
  ADD A,$05
  LD C,A
PUFOUT_44:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET
PUFOUT_45:
  DEC B
  JP P,PUFOUT_48
  LD (NXTOPR),HL
  LD (HL),$2E
PUFOUT_46:
  INC HL
  LD (HL),$30
  INC B
  LD C,B
  JP NZ,PUFOUT_46
  INC HL
  RET
PUFOUT_47:
  DEC B
PUFOUT_48:
  JP NZ,PUFOUT_50
PUFOUT_49:
  LD (HL),$2E
  LD (NXTOPR),HL
  INC HL
  LD C,B
  RET
PUFOUT_50:
  DEC C
  RET NZ
  LD (HL),$2C
  INC HL
  LD C,$03
  RET
PUFOUT_51:
  PUSH DE
  PUSH HL
  PUSH BC
  CALL $3D04
  LD A,B
  POP BC
  POP HL
  LD DE,$FC19
  SCF
PUFOUT_52:
  PUSH AF
  CALL PUFOUT_47
  LD A,(DE)
  JP NC,PUFOUT_53
  RRA
  RRA
  RRA
  RRA
  JP PUFOUT_54
PUFOUT_53:
  INC DE
PUFOUT_54:
  AND $0F
  ADD A,$30
  LD (HL),A
  INC HL
  POP AF
  DEC A
  CCF
  JP NZ,PUFOUT_52
  JP PUFOUT_58
PUFOUT_55:
  PUSH DE
  LD DE,$3CFA
  LD A,$05
PUFOUT_56:
  CALL PUFOUT_47
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
PUFOUT_57:
  INC B
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP NC,PUFOUT_57
  ADD HL,DE
  LD (DBL_FPREG),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,PUFOUT_56
PUFOUT_58:
  CALL PUFOUT_47
  LD (HL),A
  POP DE
  RET
  DJNZ $3D23
  RET PE
  INC BC
  LD H,H
  NOP
  LD A,(BC)
  NOP
  LD BC,$EF00
  LD HL,$FC1F
  LD B,$0E
  RET NC
  LD HL,$FC1B
  LD B,$06
  RET
; This entry point is used by the routine at FOUT.
PUFOUT_59:
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
  LD HL,NUMSTR
  LD (HL),$20
  RET
PUFOUT_60:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CPL
  INC A
  LD E,A
  LD A,$01
  JP Z,PUFOUT_62
  CALL $3D04
  PUSH HL
PUFOUT_61:
  CALL BCDADD_13
  DEC E
  JP NZ,PUFOUT_61
  POP HL
  INC HL
  LD A,B
  RRCA
  LD B,A
  CALL DECADD_11
  CALL PUFOUT_64
PUFOUT_62:
  POP BC
  ADD A,B
  POP BC
  POP DE
  POP HL
  RET
PUFOUT_63:
  PUSH BC
  PUSH HL
  CALL $3D04
  LD A,(FACCU)
  SUB $40
  SUB B
  LD (FACCU),A
  POP HL
  POP BC
  OR A
  RET
PUFOUT_64:
  PUSH BC
  CALL $3D04
PUFOUT_65:
  LD A,(HL)
  AND $0F
  JP NZ,PUFOUT_66
  DEC B
  LD A,(HL)
  OR A
  JP NZ,PUFOUT_66
  DEC HL
  DEC B
  JP NZ,PUFOUT_65
PUFOUT_66:
  LD A,B
  POP BC
  RET

; Single precision exponential function
FEXP:
  CALL BCDEFP_FAC2
  CALL __CDBL_0
  CALL PUSH_FAC1
  CALL L31CA_1
  CALL POP_FAC2

; Double precision exponential function
DECEXP:
  LD A,(FAC2)
  OR A
  JP Z,INTEXP_0
  LD H,A
  LD A,(FACCU)
  OR A
  JP Z,INTEXP_2
  CALL PUSH_FAC2
  CALL INTEXP_15
  JP C,DECEXP_1
  EX DE,HL
  LD ($FB90),HL
  CALL __CDBL_1
  CALL POP_FAC2
  CALL INTEXP_15
  CALL __CDBL_1
  LD HL,($FB90)
  JP NC,INTEXP_5
  LD A,(FAC2)
  PUSH AF
  PUSH HL
  CALL FAC2_FAC1
  LD HL,FBUFFR
  CALL L31CA
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
  JP INTEXP_8
DECEXP_1:
  CALL __CDBL_1
  CALL FAC2_FAC1
  CALL L31CA_1
  CALL __LOG
  CALL POP_FAC2
  CALL DECMUL
  JP __EXP

; Integer exponential function
INTEXP:
  LD A,H
  OR L
  JP NZ,INTEXP_1
; This entry point is used by the routine at DECEXP.
INTEXP_0:
  LD HL,$0001
  JP INTEXP_4
INTEXP_1:
  LD A,D
  OR E
  JP NZ,INTEXP_5
; This entry point is used by the routine at DECEXP.
INTEXP_2:
  LD A,H
  RLA
  JP NC,INTEXP_3
  JP OERR
INTEXP_3:
  LD HL,L0000
INTEXP_4:
  JP HL_FAC1
; This entry point is used by the routine at DECEXP.
INTEXP_5:
  LD ($FB90),HL
  PUSH DE
  LD A,H
  OR A
  PUSH AF
  CALL M,INT_DIV_6
  LD B,H
  LD C,L
  LD HL,$0001
INTEXP_6:
  OR A
  LD A,B
  RRA
  LD B,A
  LD A,C
  RRA
  LD C,A
  JP NC,INTEXP_7
  CALL INTEXP_14
  JP NZ,INTEXP_10
INTEXP_7:
  LD A,B
  OR C
  JP Z,INTEXP_11
  PUSH HL
  LD H,D
  LD L,E
  CALL INTEXP_14
  EX DE,HL
  POP HL
  JP Z,INTEXP_6
  PUSH BC
  PUSH HL
  LD HL,FBUFFR
  CALL L31CA
  POP HL
  CALL HL_CSNG
  CALL __CDBL_0
; This entry point is used by the routine at DECEXP.
INTEXP_8:
  POP BC
  LD A,B
  OR A
  RRA
  LD B,A
  LD A,C
  RRA
  LD C,A
  JP NC,INTEXP_9
  PUSH BC
  LD HL,FBUFFR
  CALL ADDPHL
  POP BC
INTEXP_9:
  LD A,B
  OR C
  JP Z,INTEXP_11
  PUSH BC
  CALL PUSH_FAC2
  LD HL,FBUFFR
  PUSH HL
  CALL HL2FACCU
  POP HL
  PUSH HL
  CALL ADDPHL
  POP HL
  CALL L31CA
  CALL POP_FAC1
  JP INTEXP_8
INTEXP_10:
  PUSH BC
  PUSH DE
  CALL NULSUB_0
  POP HL
  CALL HL_CSNG
  CALL __CDBL_0
  LD HL,FBUFFR
  CALL L31CA
  CALL FAC2_FAC1
  POP BC
  JP INTEXP_9
INTEXP_11:
  POP AF
  POP BC
  RET P
  LD A,(VALTYP)
  CP $02
  JP NZ,INTEXP_12
  PUSH BC
  CALL HL_CSNG
  CALL __CDBL_0
  POP BC
INTEXP_12:
  LD A,(FACCU)
  OR A
  JP NZ,INTEXP_13
  LD HL,($FB90)
  OR H
  RET P
  LD A,L
  RRCA
  AND B
  JP OVERR
INTEXP_13:
  CALL FAC1_FAC2
  LD HL,FP_UNITY
  CALL HL2FACCU
  JP DBL_DIV
INTEXP_14:
  PUSH BC
  PUSH DE
  CALL INT_MUL
  LD A,(VALTYP)
  CP $02
  POP DE
  POP BC
  RET
; This entry point is used by the routine at DECEXP.
INTEXP_15:
  CALL FAC2_FAC1
  CALL PUSH_FAC1
  CALL __INT
  CALL POP_FAC2
  CALL CMP_HLDE_1
  SCF
  RET NZ
  JP TSTSTR_0
; This entry point is used by the routines at EXEC_HL and GETVAR.
INTEXP_16:
  CALL $3F08
; This entry point is used by the routine at TESTR.
INTEXP_17:
  PUSH BC
  EX (SP),HL
  POP BC
INTEXP_18:
  RST CPDEHL
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JP INTEXP_18

; Check for C levels of stack
;
; Used by the routines at __FOR, __GOSUB, EVAL1, CLR_ALLINT and BSERR.
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
  JP C,CHKSTK_0
  ADD HL,SP
  POP HL
  RET C
; This entry point is used by the routines at RAM_IO, MAKTXT, CSAVEM, __CLOAD,
; CLOADM, __CLEAR, BSERR and __MAX.
CHKSTK_0:
  CALL UPD_PTRS
  LD HL,(STRBUF)
  DEC HL
  DEC HL
  LD ($FB9D),HL

; Routine at 16162
OMERR:
  LD DE,$0007
  JP ERROR
; This entry point is used by the routines at EXEC_HL, __RUN, __LCOPY, __NEW,
; __CLOAD, INXD, __MENU and BASIC.
OMERR_0:
  LD HL,(BASTXT)
  DEC HL
; This entry point is used by the routines at __RUN, KILLASC, CLOADM, __CLEAR,
; __SAVE and __MENU.
OMERR_1:
  LD (TEMP),HL

; Routine at 16175
;
; Used by the routine at __MAX.
SETMAX:
  CALL CLR_ALLINT
  LD B,$1A
  LD HL,DEFTBL
SETMAX_0:
  LD (HL),$08
  INC HL
  DEC B
  JP NZ,SETMAX_0
  CALL __RND_1
  XOR A
  LD ($FBA7),A
  LD L,A
  LD H,A
  LD (ONELIN),HL
  LD (OLDTXT),HL
  LD HL,(FILE_BUFFR)
  LD (FRETOP),HL
  CALL __RESTORE
  LD HL,(PROGND)
  LD (VAREND),HL
  LD (ARREND),HL
  CALL __SAVE_4
  LD A,($FCA7)
  AND $01
  JP NZ,SETMAX_1
  LD ($FCA7),A
; This entry point is used by the routines at __EDIT and BOOT.
SETMAX_1:
  POP BC
  LD HL,(STRBUF)
  DEC HL
  DEC HL
  LD ($FB9D),HL
  INC HL
  INC HL
; This entry point is used by the routine at JPBC.
SETMAX_2:
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL INIT_OUTPUT
  CALL TAB_5
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

; TIME$ ON Statement
;
; Used by the routine at KEY_STMTS.
TIME_S_ON:
  DI
  LD A,(HL)
  AND $04
  OR $01
  CP (HL)
  LD (HL),A
  JP Z,TIME_S_ON_0
  AND $04
  JP NZ,TIME_S_STOP_5
TIME_S_ON_0:
  EI
  RET

; TIME$ OFF Statement
;
; Used by the routine at KEY_STMTS.
TIME_S_OFF:
  DI
  LD A,(HL)
  LD (HL),$00
  JP TIME_S_STOP_0

; TIME$ STOP Statement
;
; Used by the routines at KEY_STMTS and CLR_ALLINT.
TIME_S_STOP:
  DI
  LD A,(HL)
  PUSH AF
  OR $02
  LD (HL),A
  POP AF
; This entry point is used by the routine at TIME_S_OFF.
TIME_S_STOP_0:
  XOR $05
  JP Z,TIME_S_STOP_8
  EI
  RET
; This entry point is used by the routine at __RETURN.
TIME_S_STOP_1:
  DI
  LD A,(HL)
  AND $05
  CP (HL)
  LD (HL),A
  JP NZ,TIME_S_STOP_3
  EI
  RET
; This entry point is used by the routines at _RST75 and BRKCHK.
TIME_S_STOP_2:
  DI
  LD A,(HL)
  AND $01
  JP Z,TIME_S_STOP_4
  LD A,(HL)
  OR $04
  CP (HL)
  JP Z,TIME_S_STOP_4
  LD (HL),A
TIME_S_STOP_3:
  XOR $05
  JP Z,TIME_S_STOP_5
TIME_S_STOP_4:
  EI
  RET
; This entry point is used by the routine at TIME_S_ON.
TIME_S_STOP_5:
  LD A,($F654)
  INC A
  LD ($F654),A
  EI
  RET
; This entry point is used by the routine at CLR_ALLINT.
TIME_S_STOP_6:
  DI
  LD A,(HL)
  AND $03
  CP (HL)
  LD (HL),A
  JP NZ,TIME_S_STOP_8
TIME_S_STOP_7:
  EI
  RET
TIME_S_STOP_8:
  LD A,($F654)
  SUB $01
  JP C,TIME_S_STOP_7
  LD ($F654),A
  EI
  RET

; Clear all COM, TIME, and KEY interrupt definitions
;
; Used by the routines at SETMAX and __EDIT.
CLR_ALLINT:
  LD HL,ON_COM_FLG
  LD B,$0A
  XOR A
CLR_ALLINT_0:
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CLR_ALLINT_0
  LD HL,FNKSTAT
  LD B,$08
CLR_ALLINT_1:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CLR_ALLINT_1
  LD ($F654),A
  RET
; This entry point is used by the routine at EXEC_EVAL.
CLR_ALLINT_2:
  LD B,$02
  LD DE,$0106
  LD A,($FBA7)
  OR A
  RET NZ
  PUSH HL
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,CLR_ALLINT_5
  DEC B
  JP NZ,CLR_ALLINT_7
  LD HL,ON_TIME_FLG
  LD B,$09
CLR_ALLINT_3:
  LD A,(HL)
  CP $05
  JP Z,CLR_ALLINT_6
CLR_ALLINT_4:
  INC HL
  INC HL
  INC HL
  DEC B
  JP NZ,CLR_ALLINT_3
CLR_ALLINT_5:
  POP HL
  RET
CLR_ALLINT_6:
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
  JP Z,CLR_ALLINT_4
  PUSH DE
  PUSH HL
  CALL TIME_S_STOP_6
  CALL TIME_S_STOP
  LD C,$03
  CALL CHKSTK
  POP BC
  POP DE
  POP HL
  POP AF
  JP ULERR_0
CLR_ALLINT_7:
  LD HL,ON_COM_FLG
  LD A,(HL)
  DEC A
  JP Z,CLR_ALLINT_6
  POP HL
  RET

; Routine at 16511
;
; Used by the routine at SETMAX.
__RESTORE:
  EX DE,HL
  LD HL,(BASTXT)
  JP Z,__RESTORE_0
  EX DE,HL
  CALL ATOH
  PUSH HL
  CALL FIND_LINE
  LD H,B
  LD L,C
  POP DE
  JP NC,ULERR
__RESTORE_0:
  DEC HL
; This entry point is used by the routine at __READ.
__RESTORE_1:
  LD (DATPTR),HL
  EX DE,HL
  RET

; Routine at 16538
;
; Used by the routine at CHSNS.
__STOP:
  RET NZ
  INC A
  JP __END_0

; Routine at 16543
__END:
  RET NZ
  XOR A
  LD ($FBA7),A
  PUSH AF
  CALL Z,__SAVE_4
  POP AF
; This entry point is used by the routine at __STOP.
__END_0:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  LD HL,$FFF6
  POP BC
; This entry point is used by the routine at BASIC_MAIN.
__END_1:
  LD HL,(CURLIN)
  PUSH HL
  PUSH AF
  LD A,L
  AND H
  INC A
  JP Z,__END_2
  LD (OLDLIN),HL
  LD HL,(SAVTXT)
  LD (OLDTXT),HL
__END_2:
  CALL INIT_OUTPUT
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG
  JP NZ,JPBC_5
  JP RESTART

; Routine at 16602
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

; Check to see if the current character in (HL) is an alpha character
;
; Used by the routines at DECLVAR and GETVAR.
IS_ALPHA:
  LD A,(HL)

; Check to see if the character in A is a letter
;
; Used by the routines at OPRND and GETVAR.
IS_ALPHA_A:
  CP $41
  RET C
  CP $5B
  CCF
  RET

; Routine at 16633
__CLEAR:
  PUSH HL
  CALL SWAPNM_1
  POP HL
  DEC HL
  RST CHRGTB
  JP Z,OMERR_1
  RST $38
  NOP
  CALL DECLVAR_3
  DEC HL
  RST CHRGTB
  PUSH HL
  LD HL,(HIMEM)
  LD B,H
  LD C,L
  LD HL,(FILE_BUFFR)
  JP Z,__CLEAR_1
  POP HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH DE
  CALL GETWORD
  DEC HL
  RST CHRGTB
  JP NZ,SNERR
  EX (SP),HL
  EX DE,HL
  LD A,H
  AND A
  JP P,FCERR
  PUSH DE
  LD DE,$F5F1
  RST CPDEHL
  JP NC,FCERR
  POP DE
  PUSH HL
  LD BC,$FEF5
  LD A,(MAXFIL)
__CLEAR_0:
  ADD HL,BC
  DEC A
  JP P,__CLEAR_0
  POP BC
  DEC HL
__CLEAR_1:
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  JP C,CHKSTK_0
  PUSH HL
  LD HL,(PROGND)
  PUSH BC
  LD BC,$00A0
  ADD HL,BC
  POP BC
  RST CPDEHL
  JP NC,CHKSTK_0
; This entry point is used by the routine at DSKI_S.
__CLEAR_2:
  EX DE,HL
  LD (STRBUF),HL
  LD H,B
  LD L,C
  LD (HIMEM),HL
  POP HL
  LD (FILE_BUFFR),HL
  POP HL
  CALL OMERR_1
  LD A,(MAXFIL)
  CALL __MAX_0
  LD HL,(TEMP)
  JP EXEC_EVAL

; Routine at 16756
__NEXT:
  LD DE,L0000
__NEXT_0:
  CALL NZ,GETVAR
  LD (TEMP),HL
  CALL NEXT_UNSTACK
  JP NZ,NFERR
  LD SP,HL
  PUSH DE
  LD A,(HL)
  PUSH AF
  INC HL
  PUSH DE
  LD A,(HL)
  INC HL
  OR A
  JP M,__NEXT_2
  DEC A
  JP NZ,__NEXT_1
  LD BC,SYNCHR
  ADD HL,BC
__NEXT_1:
  ADD A,$04
  LD (VALTYP),A
  CALL REV_LDDR_B_1
  EX DE,HL
  EX (SP),HL
  PUSH HL
  RST GETYPR
  JP NC,__NEXT_4
  CALL HLBCDE
  CALL DBL_ABS_2
  POP HL
  CALL FAC1_HL
  POP HL
  CALL LOADFP
  PUSH HL
  CALL BCDE_FP_CMP
  JP __NEXT_3
__NEXT_2:
  LD BC,$000C
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
  JP NZ,OVERR
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
  CALL CMP_HLDE
__NEXT_3:
  POP HL
  POP BC
  SUB B
  CALL LOADFP
  JP Z,__NEXT_5
  EX DE,HL
  LD (CURLIN),HL
  LD L,C
  LD H,B
  JP STEP_7
__NEXT_4:
  CALL DECSUB_0
  POP HL
  CALL REV_LDDR_B_3
  POP HL
  CALL HL_FAC2
  PUSH DE
  CALL CMP_HLDE_1
  JP __NEXT_3
__NEXT_5:
  LD SP,HL
  LD ($FB9D),HL
  EX DE,HL
  LD HL,(TEMP)
  LD A,(HL)
  CP $2C
  JP NZ,EXEC_EVAL
  RST CHRGTB
  CALL __NEXT_0

; Line input
;
; Used by the routines at EXEC_HL, __PRINT, TAB, __READ, __LIST, INLIN, _OUTC,
; CONSOLE_CRLF and INIT_PRINT_h.
RINPUT:
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  POP HL
  RET

; Send CRLF to screen or printer
;
; Used by the routines at __KEY, CATALOG, INLIN_BRK, INLIN_ENTER, TEL_FIND,
; TXT_ESC, TXT_CTL_Y and TXT_CTL_V.
OUTDO_CRLF:
  LD A,$0D
  RST OUTC

; Send LF to screen or printer
OUTDO_LF:
  LD A,$0A
  RST OUTC
  RET

; Routine at 16937
;
; Used by the routines at LDIR_B, INXD, TELCOM, TEL_TERM, __MENU, SCHEDL_DE,
; TEXT and MOVE_TEXT.
__BEEP:
  LD A,$07
  RST OUTC
  RET

; Routine at 16941
;
; Used by the routines at TXT_CTL_W, TXT_CTL_L and TXT_CTL_C.
HOME:
  LD A,$0B
  RST OUTC
  RET

; Routine at 16945
;
; Used by the routines at __MENU, _PRINT_TDATE, SCHEDL_DE and __EDIT.
__CLS:
  LD A,$0C
  RST OUTC
  RET

; Protect line 8.  An ESC T is printed.
;
; Used by the routine at DSPFNK.
L4235:
  LD A,$54
  JP ESCA

; Unprotect line 8.  An ESC U is printed.
;
; Used by the routines at ERAFNK and DSPFNK.
RSTSYS:
  LD A,$55
  JP ESCA

; Stop automatic scrolling.  ( ESC V )
;
; Used by the routines at __MENU and WAIT_SPC.
LOCK:
  LD A,$56
  JP ESCA

; Resume automatic scrolling.  (ESC W)
;
; Used by the routines at TELCOM, __MENU and TXT_ESC.
UNLOCK:
  LD A,$57
  JP ESCA

; Turn the cursor on.  An ESC P is printed.
;
; Used by the routines at FNBAR_TOGGLE, TEL_TERM and TEL_PREV.
CURSON:
  LD A,$50
  JP ESCA

; Turn the cursor off.  An ESC Q is printed.
;
; Used by the routines at FNBAR_TOGGLE, TEL_PREV, TEL_BYE, __MENU and WAIT_SPC.
CURSOFF:
  LD A,$51
  JP ESCA

; Delete current line on screen.  ( ESC M )
;
; Used by the routines at DSPFNK and TXT_CTL_L.
DELLIN:
  LD A,$4D
  JP ESCA

; Insert line at current line. (ESC L)
;
; Used by the routine at TXT_CTL_C.
INSLIN:
  LD A,$4C
  JP ESCA

; Erase from cursor to end of line.  (ESC K)
;
; Used by the routines at CAS_OPNI_CO, ERAFNK, DSPFNK, INXD, MOVE_TEXT and
; TXT_CTL_V.
ERAEOL:
  LD A,$4B
  JP ESCA

; calls ESC_X  (Set cursor position ?)
;
; Used by the routines at FNBAR_TOGGLE, ERAFNK, DSPFNK and TEL_PREV.
_ESC_X:
  LD A,$58
  JP ESCA
; This entry point is used by the routine at DSPFNK.
_ESC_X_0:
  OR (HL)
  RET Z

; calls ESC__p, Reverse mode
;
; Used by the routines at DSPFNK, ESC_L and INXD.
ENTREV:
  LD A,$70
  JP ESCA

; calls ESC__q, Exit reverse mode
;
; Used by the routines at DSPFNK, ESC_L, INXD, __MENU, WAIT_SPC and TXT_CTL_V.
EXTREV:
  LD A,$71

; print escape code in A
;
; Used by the routines at L4235, RSTSYS, LOCK, UNLOCK, CURSON, CURSOFF, DELLIN,
; INSLIN, ERAEOL, _ESC_X, ENTREV and POSIT.
ESCA:
  PUSH AF
  LD A,$1B
  RST OUTC
  POP AF
  RST OUTC
  RET
; This entry point is used by the routines at ERAFNK and DSPFNK.
ESCA_0:
  LD HL,(ACTV_X)
  LD H,$01

; calls ESC_Y, set cursor position (H,L)
;
; Used by the routines at LINE_GFX, ERAFNK, DSPFNK, __MENU, DOTTED_FNAME,
; CURS_HOME, SHOW_TIME, TXT_ESC, TXT_CTL_I, TXT_CTL_E, TXT_CTL_T, TXT_CTL_R,
; TXT_CTL_C, MCLEAR, MOVE_TEXT, TXT_CTL_Y and TXT_CTL_V.
POSIT:
  LD A,$59
  CALL ESCA
  LD A,L
  ADD A,$1F
  RST OUTC
  LD A,H
  ADD A,$1F
  RST OUTC
  RET

; Erase function key display
;
; Used by the routines at FNBAR_TOGGLE, __MENU, WAIT_SPC and TXT_ESC.
ERAFNK:
  LD A,(LABEL_LN)
  AND A
  RET Z
  CALL RSTSYS
  LD HL,(CSRX)
  PUSH HL
  CALL ESCA_0
  CALL ERAEOL
  POP HL
  CALL POSIT
  CALL _ESC_X
  XOR A
  RET

; Set and display function keys
;
; Used by the routines at TELCOM and SCHEDL_DE.
STDSPF:
  CALL STFNK

; Display FN keys in bottom line
;
; Used by the routines at FNBAR_TOGGLE, TEL_TERM and FNKSB.
DSPFNK:
  LD HL,(CSRX)
  LD A,(ACTV_X)
  CP L
  JP NZ,DSPFNK_0
  PUSH HL
  CALL ESC_J_12
  LD L,$01
  CALL POSIT
  CALL DELLIN
  POP HL
  DEC L
DSPFNK_0:
  PUSH HL
  CALL RSTSYS
  CALL ESCA_0
  LD HL,FNKSTR
  LD E,$08
  LD A,(REVERSE)
  PUSH AF
  CALL EXTREV
DSPFNK_1:
  LD A,(ACTV_Y)
  CP $28
  LD BC,$040C
  JP Z,DSPFNK_2
  LD BC,$0907
DSPFNK_2:
  PUSH HL
  LD HL,$FAC3
  LD A,E
  SUB $06
  JP Z,DSPFNK_3
  DEC A
  DEC HL
DSPFNK_3:
  CALL Z,_ESC_X_0
  POP HL
  CALL OUTS_B_CHARS
  ADD HL,BC
  CALL EXTREV
  DEC E
  CALL NZ,OUT_SPC
  JP NZ,DSPFNK_1
  CALL ERAEOL
  CALL L4235
  POP AF
  AND A
  CALL NZ,ENTREV
  POP HL
  CALL POSIT
  CALL _ESC_X
  XOR A
  RET

; Print the character in the A register to the screen. Used by RST20H
;
; Used by the routine at LCD_OUT.
OUTC_SUB0:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF

; Involved by $0020, uses HOUTD
OUTC_SUB:
  RST $38
  EX AF,AF'
  CALL OUTC_SUB_0
  JP POPALL
; This entry point is used by the routine at LCD_OUTPUT.
OUTC_SUB_0:
  LD C,A
  XOR A
  LD ($FAC7),A
  LD A,($F638)
  AND A
  JP NZ,OUTC_SUB_3
  CALL OUTC_SUB_1
  LD HL,(CSRX)
  LD (CSR_ROW),HL
  RET
OUTC_SUB_1:
  CALL SET_CLOCK_HL_9
  CALL OUTC_SUB_4
; This entry point is used by the routine at ESC_J.
OUTC_SUB_2:
  LD HL,(CSRX)
  EX DE,HL
  CALL MOVE_CURSOR
  LD A,(CSR_STATUS)
  AND A
  RET Z
  JP SET_CLOCK_HL_10
OUTC_SUB_3:
  RST $38
  INC A
OUTC_SUB_4:
  LD HL,$F646
  LD A,(HL)
  AND A
  JP NZ,IN_ESC
  LD A,C
  LD HL,(CSRX)
  CP $09
  JP Z,_TAB
  CP $7F
  JP Z,ESC_L_3
  CP $20
  JP C,OUTC_SUB2
  CALL ESC_J_1
  CALL ESC_X_1
  RET NZ
  LD H,$01
  JP _LF

; Control code routine for LCD output (RST 20H)
;
; Used by the routine at OUTC_SUB.
OUTC_SUB2:
  LD HL,$4388
  LD C,$08
; This entry point is used by the routines at IN_ESC, INLIN and MOVE_TEXT.
OUTC_SUB2_0:
  INC HL
  INC HL
  DEC C
  RET M
  CP (HL)
  INC HL
  JP NZ,OUTC_SUB2_0
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  PUSH HL
  LD HL,(CSRX)
  RET
ESCTBL:
  RLCA
  LD H,D
  HALT
  EX AF,AF'
  LD H,C
  LD B,H
  ADD HL,BC
  ADD A,B
  LD B,H
  LD A,(BC)
  SUB H
  LD B,H
  DEC BC
  XOR B
  LD B,H
  INC C
  LD C,B
  LD B,L
  DEC C
  XOR D
  LD B,H
  DEC DE
  OR D
  LD B,E
; This entry point is used by the routines at ESC_P, ESC_Q, ESC_M, ESC_L,
; ESC_K, ESC_J and TEL_PREV.
OUTC_SUB2_1:
  LD A,($FAC7)
  AND A
  RET Z
  POP AF
  RET
; This entry point is used by the routines at ESC_M, ESC_L and ESC_J.
OUTC_SUB2_2:
  LD A,(LABEL_LN)
  ADD A,$08
  RET

; Set cursor position
ESC_Y:
  LD A,$02
  LD BC,$AF3E

; (27), This routine puts the LCD output routine into ESCape mode
;
; Used by the routine at ESC_W.
_ESC_MODE:
  LD A,$AF
  LD ($F646),A
  RET
ESCFN:
  LD L,D
  LD C,B
  LD B,L
  LD B,L
  LD C,B
  LD B,L
  LD C,E
  SCF
  LD B,L
  LD C,D
  LD C,(HL)
  LD B,L
  LD L,H
  DEC (HL)
  LD B,L
  LD C,H
  JP PE,$4D44
  CALL NZ,$5944
  XOR A
  LD B,E
  LD B,C
  LD L,C
  LD B,H
  LD B,D
  LD L,(HL)
  LD B,H
  LD B,E
  LD D,E
  LD B,H
  LD B,H
  LD E,H
  LD B,H
  LD C,B
  XOR B
  LD B,H
  LD (HL),B
  LD SP,$7144
  LD (L4F2E_18),A
  XOR A
  LD B,H
  LD D,C
  CP D
  LD B,H
  LD D,H
  ADD HL,SP
  LD B,H
  LD D,L
  SCF
  LD B,H
  LD D,(HL)
  CCF
  LD B,H
  LD D,A
  LD B,B
  LD B,H
  LD E,B
  LD C,D
  LD B,H

; ESCape sequence processor.
;
; Used by the routine at OUTC_SUB.
IN_ESC:
  LD A,C
  CP $1B
  LD A,(HL)
  JP Z,ESC_W_0
  AND A
  JP P,IN_ESC_0
  CALL $43B3
  LD A,C
  LD HL,$43B6
  LD C,$16
  JP OUTC_SUB2_0
IN_ESC_0:
  DEC A
  LD ($F646),A
  LD A,(ACTV_Y)
  LD DE,CSRY
  JP Z,IN_ESC_1
  LD A,(ACTV_X)
  LD HL,LABEL_LN
  ADD A,(HL)
  DEC DE
IN_ESC_1:
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

; Start inverse video mode
ESC__p:
  OR $AF

; Cancel inverse video
ESC__q:
  XOR A
  LD (REVERSE),A
  RET

; Unprotect line 8
ESC_U:
  XOR A
  JP NZ,$FF3E

; Protect line 8
ESC_T:
  LD A,$FF
  LD (LABEL_LN),A
  RET

; Stop automatic scrolling
ESC_V:
  OR $AF

; Resume automatic scrolling
ESC_W:
  XOR A
  LD (NO_SCROLL),A
  RET
; This entry point is used by the routine at IN_ESC.
ESC_W_0:
  INC HL
  LD (HL),A
  JP _ESC_MODE

; ESC X
ESC_X:
  LD HL,$F647
; This entry point is used by the routine at DSKI_S.
ESC_X_0:
  LD A,(HL)
  LD (HL),$00
  DEC HL
  LD (HL),A
  RET
; This entry point is used by the routine at OUTC_SUB.
ESC_X_1:
  LD A,(ACTV_Y)
  CP H
  RET Z
  INC H
  JP ESC_B_0

; Move cursor to the left
;
; Used by the routine at _BS.
ESC_D:
  DEC H
  RET Z

; Move cursor up one line
ESC_C:
  JP ESC_B_0

; Backspace routine
_BS:
  CALL ESC_D
  RET NZ
  LD A,(ACTV_Y)
  LD H,A

; Move cursor to the right
ESC_A:
  DEC L
  RET Z
  JP ESC_B_0

; Move cursor down one line
;
; Used by the routine at _LF.
ESC_B:
  CALL MCLEAR_6
  CP L
  RET Z
  JP C,ESC_B_1
  INC L
; This entry point is used by the routines at ESC_X, ESC_C, ESC_A, _LF and _CR.
ESC_B_0:
  LD (CSRX),HL
  RET
ESC_B_1:
  DEC L
  XOR A
  JP ESC_B_0

; Tab cursor
;
; Used by the routine at OUTC_SUB.
_TAB:
  LD A,(CSRY)
  PUSH AF
  LD A,' '
  RST OUTC
  POP BC
  LD A,(CSRY)
  CP B
  RET Z
  DEC A
  AND $07
  JP NZ,_TAB
  RET

; Move down one line
;
; Used by the routine at OUTC_SUB.
_LF:
  CALL ESC_B
  RET NZ
  LD A,(NO_SCROLL)
  AND A
  RET NZ
  CALL ESC_B_0
  CALL ESC_J_12
  LD L,$01
  JP ESC_M_0

; Home cursor (ESC H) and vertical tab (0Bh)
;
; Used by the routine at _CLS.
ESC_H:
  LD L,$01

; Move cursor to beginning
;
; Used by the routines at ESC_M and ESC_L.
_CR:
  LD H,$01
  JP ESC_B_0

; Turn cursor on
ESC_P:
  LD A,$01
  LD (CSR_STATUS),A
  CALL OUTC_SUB2_1
  JP SET_CLOCK_HL_10

; Turn cursor off
ESC_Q:
  XOR A
  LD (CSR_STATUS),A
  CALL OUTC_SUB2_1
  JP SET_CLOCK_HL_9

; Erase current line
ESC_M:
  CALL _CR
; This entry point is used by the routine at _LF.
ESC_M_0:
  CALL OUTC_SUB2_1
  CALL OUTC_SUB2_2
  SUB L
  RET C
  JP Z,ESC_LL
ESC_M_1:
  PUSH AF
  LD H,$28
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

; Erase from the cursor to the end of the line
ESC_L:
  CALL _CR
  CALL OUTC_SUB2_1
  CALL OUTC_SUB2_2
  LD H,A
  SUB L
  RET C
  JP Z,ESC_LL
  LD L,H
ESC_L_0:
  PUSH AF
  LD H,$28
ESC_L_1:
  DEC L
  CALL ESC_L_2
  INC L
  CALL ESC_J_2
  DEC H
  JP NZ,ESC_L_1
  DEC L
  POP AF
  DEC A
  JP NZ,ESC_L_0
  JP ESC_LL
; This entry point is used by the routines at ESC_M and ESC_J.
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
; This entry point is used by the routine at OUTC_SUB.
ESC_L_3:
  LD A,(REVERSE)
  PUSH AF
  CALL EXTREV
  LD A,$08
  RST OUTC
  LD A,' '
  RST OUTC
  LD A,$08
  RST OUTC
  POP AF
  AND A
  RET Z
  JP ENTREV

; (calls ESC_l) erase current cursor line
;
; Used by the routines at ESC_M and ESC_L.
ESC_LL:
  LD H,$01

; Escape K routine (erase from cursor to the end of the screen)
;
; Used by the routine at ESC_J.
ESC_K:
  CALL OUTC_SUB2_1
ESC_K_0:
  LD C,$20
  XOR A
  CALL ESC_J_2
  INC H
  LD A,H
  CP $29
  JP C,ESC_K_0
  RET

; Clear screen
_CLS:
  CALL ESC_H
  CALL ESC_J_10

; Erase from the cursor to the bottom of the screen
ESC_J:
  CALL OUTC_SUB2_1
ESC_J_0:
  CALL ESC_K
  CALL OUTC_SUB2_2
  CP L
  RET C
  RET Z
  LD H,$01
  INC L
  JP ESC_J_0
; This entry point is used by the routine at OUTC_SUB.
ESC_J_1:
  CALL OUTC_SUB2_1
  LD A,(REVERSE)
; This entry point is used by the routines at ESC_M, ESC_L and ESC_K.
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
  CALL SET_CLOCK_HL_11
  POP AF
  AND A
  POP HL
  RET Z
ESC_J_3:
  DI
  LD A,$0D
  JR NC,ESC_J_3
  CALL SET_CLOCK_HL_7
  LD A,$09
  JR NC,$454F
; This entry point is used by the routine at ESC_L.
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
  LD DE,$FED7
  ADD HL,DE
  RET
ESC_J_5:
  LD B,A
  CALL ESC_J_7
  INC B
  DEC B
  JP Z,ESC_J_6
  OR (HL)
  LD (HL),A
  RET
ESC_J_6:
  CPL
  AND (HL)
  LD (HL),A
  RET
; This entry point is used by the routine at ESC_L.
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
  LD DE,$FB35
  ADD HL,DE
  POP AF
  AND $07
  LD D,A
  XOR A
  SCF
ESC_J_8:
  RRA
  DEC D
  JP P,ESC_J_8
  RET
; This entry point is used by the routine at DOTTED_FNAME.
ESC_J_9:
  PUSH HL
  CALL ESC_J_7
  XOR (HL)
  LD (HL),A
  POP HL
  RET
; This entry point is used by the routines at _CLS and TEL_TERM.
ESC_J_10:
  CALL OUTC_SUB2_1
  LD A,($F650)
  ADD A,A
  RET P
  PUSH HL
  LD HL,ALT_LCD
  LD BC,$0140
ESC_J_11:
  LD (HL),$20
  INC HL
  DEC BC
  LD A,B
  OR C
  JP NZ,ESC_J_11
  POP HL
  RET
; This entry point is used by the routines at DSPFNK and _LF.
ESC_J_12:
  CALL OUTC_SUB2_1
  LD A,($F650)
  ADD A,A
  RET P
  LD DE,ALT_LCD
  LD HL,$FCE8
  LD BC,$0140
  JP _LDIR
; This entry point is used by the routines at TEL_PREV and BOOT.
ESC_J_13:
  CALL SET_CLOCK_HL_9
  LD L,$01
ESC_J_14:
  LD H,$01
ESC_J_15:
  CALL ESC_L_2
  CALL ESC_J_2
  INC H
  LD A,H
  CP $29
  JP NZ,ESC_J_15
  INC L
  LD A,L
  CP $09
  JP NZ,ESC_J_14
  JP OUTC_SUB_2
; This entry point is used by the routine at TEL_PREV.
ESC_J_16:
  LD HL,ALT_LCD
  LD E,$01
ESC_J_17:
  LD D,$01
ESC_J_18:
  PUSH HL
  PUSH DE
  LD C,(HL)
  CALL SET_CLOCK_HL_11
  POP DE
  POP HL
  INC HL
  INC D
  LD A,D
  CP $29
  JP NZ,ESC_J_18
  INC E
  LD A,E
  CP $09
  JP NZ,ESC_J_17
  RET

; Input line and place at F685H.  Start with "? ". Print characters as they are
; entered
;
; Used by the routines at __INPUT, __READ, UPLDR, DWNLDR, TEL_BYE and TEXT.
QINLIN:
  LD A,'?'
  RST OUTC
  LD A,' '
  RST OUTC

; Routine at 17988
;
; Used by the routines at PROMPT, __LINE, TELCOM_RDY, UPLDR and SCHEDL_DE.
INLIN:
  CALL RINPUT
  JP NZ,INXD_6
  LD A,(CSRY)
  LD ($FACA),A
  LD DE,KBUF
  LD B,$01
  CALL CHGET
  LD HL,$4655
  PUSH HL
  RET C
  CP $7F
  JP Z,INLIN_CURS
  CP $20
  JP NC,INLIN_TAB_0
  LD HL,$466D
  LD C,$07
  JP OUTC_SUB2_0
  INC BC
  ADD A,H
  LD B,(HL)
  EX AF,AF'
  AND B
  LD B,(HL)
  ADD HL,BC
  JP Z,__READ_7
  SUB (HL)
  LD B,(HL)
  DEC D
  JP $1846
  
  JP LINE_GFX_14
  AND B
  LD B,(HL)
  POP HL

; INLIN Control C handler
INLIN_BRK:
  LD A,$5E
  RST OUTC
  LD A,$43
  RST OUTC
  CALL OUTDO_CRLF
  LD HL,KBUF
  LD (HL),$00
  DEC HL
  SCF
  RET

; INLIN ENTER handler
INLIN_ENTER:
  POP HL
  CALL OUTDO_CRLF
  XOR A
  LD (DE),A
  LD HL,$F684
  RET

; INLIN  backspace, left arrow, control H handler
;
; Used by the routines at INLIN, INLIN_CTL_UX and MOVE_TEXT.
INLIN_CURS:
  LD A,B
  DEC A
  SCF
  RET Z
  DEC B
  DEC DE
  CALL INXD_1
INLIN_CURS_0:
  PUSH AF
  LD A,$7F
  RST OUTC
  LD HL,(CSRX)
  DEC L
  DEC H
  LD A,H
  OR L
  JP Z,INLIN_CURS_1
  LD HL,CSRY
  POP AF
  CP (HL)
  JP NZ,INLIN_CURS_0
  RET
INLIN_CURS_1:
  POP AF
  SCF
  RET

; INLIN CTRL-U handler
INLIN_CTL_UX:
  CALL INLIN_CURS
  JP NC,INLIN_CTL_UX
  RET

; INLIN TAB handler
INLIN_TAB:
  LD A,$09
; This entry point is used by the routine at INLIN.
INLIN_TAB_0:
  INC B
  JP Z,INXD_0
  RST OUTC
  LD (DE),A

; Routine at 18130
INXD:
  INC DE
  RET
; This entry point is used by the routine at INLIN_TAB.
INXD_0:
  DEC B
  JP __BEEP
; This entry point is used by the routine at INLIN_CURS.
INXD_1:
  PUSH BC
  LD A,($FACA)
  DEC B
  JP Z,INXD_5
  LD C,A
  LD HL,KBUF
INXD_2:
  INC C
  LD A,(HL)
  CP $09
  JP NZ,INXD_3
  LD A,C
  DEC A
  AND $07
  JP NZ,INXD_2
INXD_3:
  LD A,(ACTV_Y)
  CP C
  JP NC,INXD_4
  LD C,$01
INXD_4:
  INC HL
  DEC B
  JP NZ,INXD_2
  LD A,C
INXD_5:
  POP BC
  RET
; This entry point is used by the routine at INLIN.
INXD_6:
  LD HL,(PTRFIL)
  PUSH HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  SUB $F8
  JP NZ,INXD_7
  LD L,A
  LD H,A
  LD (PTRFIL),HL
  LD HL,$FAC4
  INC (HL)
  LD A,(HL)
  RRCA
  CALL NC,ENTREV
  LD HL,WAIT_MSG	; " Wait "
  CALL PRS
  CALL EXTREV
INXD_7:
  POP HL
  LD (PTRFIL),HL
  LD B,$00
  LD HL,KBUF
INXD_8:
  XOR A
  LD ($FAA2),A
  LD ($FAA3),A
  CALL RDBYT
  JP C,INXD_11
  LD (HL),A
  CP $0D
  JP Z,INXD_10
  CP $09
  JP Z,INXD_9
  CP $20
  JP C,INXD_8
INXD_9:
  INC HL
  DEC B
  JP NZ,INXD_8
INXD_10:
  XOR A
  LD (HL),A
  LD HL,$F684
  RET
INXD_11:
  LD A,B
  AND A
  JP NZ,INXD_10
  LD A,($FCA7)
  AND $80
  LD ($FCA7),A
  CALL L4F2E_1
  LD A,$0D
  RST OUTC
  CALL ERAEOL
  LD A,($FC92)
  AND A
  JP Z,INXD_12
  CALL OMERR_0
  JP EXEC_EVAL
INXD_12:
  LD A,($F651)
  AND A
  JP NZ,__EDIT_3
  JP RESTART
  DEC HL
  RST CHRGTB
  RET Z
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','

; DIM command
__DIM:
  LD BC,$4786
  PUSH BC
  OR $AF

; Get variable address to DE
;
; Used by the routines at __LET, __LINE, __READ, VAR_EVAL, __NEXT and L4F2E.
GETVAR:
  XOR A
  LD (DIMFLG),A
  LD C,(HL)
  CALL IS_ALPHA
  JP C,SNERR
  XOR A
  LD B,A
  RST CHRGTB
  JP C,GETVAR_0
  CALL IS_ALPHA_A
  JP C,GETVAR_2
GETVAR_0:
  LD B,A
GETVAR_1:
  RST CHRGTB
  JP C,GETVAR_1
  CALL IS_ALPHA_A
  JP NC,GETVAR_1
GETVAR_2:
  CP $26
  JP NC,GETVAR_3
  LD DE,$47DC
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
  CP '#'
  RET Z
  POP AF
GETVAR_3:
  LD A,C
  AND $7F
  LD E,A
  LD D,$00
  PUSH HL
  LD HL,$FB79
  ADD HL,DE
  LD D,(HL)
  POP HL
  DEC HL
  LD A,D
  LD (VALTYP),A
  RST CHRGTB
  LD A,(SUBFLG)
  DEC A
  JP Z,$48BC
  JP P,GETVAR_4
  LD A,(HL)
  SUB $28
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
  JP Z,GETVAR_12
GETVAR_6:
  INC DE
  LD H,$00
  ADD HL,DE
GETVAR_7:
  EX DE,HL
  LD A,(VAREND)
  CP E
  JP NZ,GETVAR_5
  LD A,($FBB5)
  CP D
  JP NZ,GETVAR_5
  JP GETVAR_10
; This entry point is used by the routine at VARPTR_VAR.
GETVAR_8:
  CALL GETVAR
  RET
GETVAR_9:
  LD D,A
  LD E,A
  POP BC
  EX (SP),HL
  RET
GETVAR_10:
  POP HL
  EX (SP),HL
  PUSH DE
  LD DE,$482F
  RST CPDEHL
  JP Z,GETVAR_9
  LD DE,$0FDD
  RST CPDEHL
  POP DE
  JP Z,GETVAR_13
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
  CALL INTEXP_16
  POP HL
  LD (ARREND),HL
  LD H,B
  LD L,C
  LD (VAREND),HL
GETVAR_11:
  DEC HL
  LD (HL),$00
  RST CPDEHL
  JP NZ,GETVAR_11
  POP DE
  LD (HL),E
  INC HL
  POP DE
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
GETVAR_12:
  INC DE
  POP HL
  RET
GETVAR_13:
  LD (FACCU),A
  LD H,A
  LD L,A
  LD (DBL_FPREG),HL
  RST GETYPR
  JP NZ,GETVAR_14
  LD HL,$03F5
  LD (DBL_FPREG),HL
GETVAR_14:
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
  CALL DECLVAR_2
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
  JP Z,SCPTLP_0
  CP $5D
  JP NZ,SNERR
SCPTLP_0:
  RST CHRGTB
  LD (NXTOPR),HL
  POP HL
  LD (DIMFLG),HL
  LD E,$00
  PUSH DE
  LD DE,$F5E5
  LD HL,(VAREND)
  LD A,$19
  EX DE,HL
  LD HL,(ARREND)
  EX DE,HL
  RST CPDEHL
  JP Z,BSERR_0
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
  JP NZ,$48C2
  LD A,(DIMFLG)
  OR A
  JP NZ,DDERR
  POP AF
  LD B,H
  LD C,L
  JP Z,BCDEFP_FAC2_2
  SUB (HL)
  JP Z,BSERR_4

; Routine at 18678
;
; Used by the routine at MLDEBC.
BSERR:
  LD DE,$0009
  JP ERROR
; This entry point is used by the routine at SCPTLP.
BSERR_0:
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
BSERR_1:
  LD BC,$000B
  JP NC,BSERR_2
  POP BC
  INC BC
BSERR_2:
  LD (HL),C
  PUSH AF
  INC HL
  LD (HL),B
  INC HL
  CALL MLDEBC
  POP AF
  DEC A
  JP NZ,BSERR_1
  PUSH AF
  LD B,D
  LD C,E
  EX DE,HL
  ADD HL,DE
  JP C,CHKSTK_0
  CALL $3F08
  LD (ARREND),HL
BSERR_3:
  DEC HL
  LD (HL),$00
  RST CPDEHL
  JP NZ,BSERR_3
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
  JP C,BSERR_7
; This entry point is used by the routine at SCPTLP.
BSERR_4:
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
  JP NC,BSERR
  CALL MLDEBC
  ADD HL,DE
  POP AF
  DEC A
  LD B,H
  LD C,L
  JP NZ,$495F
  LD A,(VALTYP)
  LD B,H
  LD C,L
  ADD HL,HL
  SUB $04
  JP C,BSERR_5
  ADD HL,HL
  JP Z,BSERR_6
  ADD HL,HL
BSERR_5:
  OR A
  JP PO,BSERR_6
  ADD HL,BC
BSERR_6:
  POP BC
  ADD HL,BC
  EX DE,HL
BSERR_7:
  LD HL,(NXTOPR)
  RET

; Routine at 18833
;
; Used by the routine at __PRINT.
USING:
  CALL L0DAC
  CALL TSTSTR
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ';'
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
USING_3:
  LD E,B
  PUSH HL
  LD C,$02
USING_4:
  LD A,(HL)
  INC HL
  CP $5C
  JP Z,$4B07
  CP $20
  JP NZ,USING_5
  INC C
  DEC B
  JP NZ,USING_4
USING_5:
  POP HL
  LD B,E
  LD A,$5C
USING_6:
  CALL USING_26
  RST OUTC
USING_7:
  XOR A
  LD E,A
  LD D,A
USING_8:
  CALL USING_26
  LD D,A
  LD A,(HL)
  INC HL
  CP $21
  JP Z,USING_24
  CP '#'
  JP Z,USING_11
  DEC B
  JP Z,USING_21
  CP $2B
  LD A,$08
  JP Z,USING_8
  DEC HL
  LD A,(HL)
  INC HL
  CP $2E
  JP Z,USING_12
  CP $5C
  JP Z,USING_3
  CP (HL)
  JP NZ,USING_6
  CP $24
  JP Z,$4A27
  CP $2A
  JP NZ,USING_6
  INC HL
  LD A,B
  CP $02
  JP C,USING_9
  LD A,(HL)
  CP $24
USING_9:
  LD A,' '
  JP NZ,USING_10
  DEC B
  INC E
  CP $AF
  ADD A,$10
  INC HL
USING_10:
  INC E
  ADD A,D
  LD D,A
USING_11:
  INC E
  LD C,$00
  DEC B
  JP Z,USING_15
  LD A,(HL)
  INC HL
  CP $2E
  JP Z,USING_13
  CP '#'
  JP Z,USING_11
  CP $2C
  JP NZ,USING_14
  LD A,D
  OR $40
  LD D,A
  JP USING_11
USING_12:
  LD A,(HL)
  CP '#'
  LD A,$2E
  JP NZ,USING_6
  LD C,$01
  INC HL
USING_13:
  INC C
  DEC B
  JP Z,USING_15
  LD A,(HL)
  INC HL
  CP '#'
  JP Z,USING_13
USING_14:
  PUSH DE
  LD DE,$4A81
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
  JP Z,$D1EB
USING_15:
  LD A,D
  DEC HL
  INC E
  AND $08
  JP NZ,USING_17
  DEC E
  LD A,B
  OR A
  JP Z,USING_17
  LD A,(HL)
  SUB $2D
  JP Z,USING_16
  CP $FE
  JP NZ,USING_17
  LD A,$08
USING_16:
  ADD A,$04
  ADD A,D
  LD D,A
  DEC B
USING_17:
  POP HL
  POP AF
  JP Z,USING_23
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
  JP NC,FCERR
  LD A,D
  OR $80
  CALL FOUT_0
  CALL PRS
USING_18:
  POP HL
  DEC HL
  RST CHRGTB
  SCF
  JP Z,USING_20
  LD (FLGINP),A
  CP $3B
  JP Z,USING_19
  CP $2C
  JP NZ,SNERR
USING_19:
  RST CHRGTB
USING_20:
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
  JP USING_22
USING_21:
  CALL USING_26
  RST OUTC
USING_22:
  POP HL
  POP AF
  JP NZ,USING_0
USING_23:
  CALL C,CONSOLE_CRLF_0
  EX (SP),HL
  CALL GSTRHL
  POP HL
  JP TAB_5
USING_24:
  LD C,$01
  LD A,$F1
  DEC B
  CALL USING_26
  POP HL
  POP AF
  JP Z,USING_23
  PUSH BC
  CALL EVAL
  CALL TSTSTR
  POP BC
  PUSH BC
  PUSH HL
  LD HL,(DBL_FPREG)
  LD B,C
  LD C,$00
  LD A,B
  PUSH AF
  CALL $29B2
  CALL PRS1
  LD HL,(DBL_FPREG)
  POP AF
  SUB (HL)
  LD B,A
  LD A,' '
  INC B
USING_25:
  DEC B
  JP Z,USING_18
  RST OUTC
  JP USING_25
USING_26:
  PUSH AF
  LD A,D
  OR A
  LD A,$2B
  CALL NZ,_OUTC
  POP AF
  RET

; Vector of RST 20H (aka RST 4), OUTC.  Send A to screen or printer
;
; Used by the routines at OUTC, USING and TEL_TERM.
_OUTC:
  PUSH AF
  PUSH HL
  CALL RINPUT
  JP NZ,__CLOSE_2
  POP HL
  LD A,(PRTFLG)
  OR A
  JP Z,INIT_OUTPUT_1
  POP AF

; Print the character in the A register on the printer.  Expand tabs into
; spaces if nescessary
;
; Used by the routines at LPT_OUTPUT and TEL_TERM.
OUTC_TABEXP:
  PUSH AF
  CP $09
  JP NZ,OUTC_TABEXP_1
OUTC_TABEXP_0:
  LD A,' '
  CALL OUTC_TABEXP
  LD A,(LPT_POS)
  AND $07
  JP NZ,OUTC_TABEXP_0
  POP AF
  RET
OUTC_TABEXP_1:
  SUB $0D
  JP Z,OUTC_TABEXP_2
  JP C,OUTC_TABEXP_3
  LD A,(LPT_POS)
  INC A
OUTC_TABEXP_2:
  LD (LPT_POS),A
OUTC_TABEXP_3:
  POP AF
; This entry point is used by the routine at INIT_OUTPUT.
OUTC_TABEXP_4:
  CP $0A
  JP NZ,OUTC_TABEXP_5
  PUSH BC
  LD B,A
  LD A,(LPRINT_CH)
  CP $0D
  LD A,B
  POP BC
OUTC_TABEXP_5:
  LD (LPRINT_CH),A
  RET Z
  CP $1A
  RET Z
  JP LPT_OUT

; Reinitialize output, LCD and/or printer.
;
; Used by the routines at READY, SETMAX and __END.
INIT_OUTPUT:
  XOR A
  LD (PRTFLG),A
  LD A,(LPT_POS)
  OR A
  RET Z
  LD A,($FACD)
  OR A
  RET Z
; This entry point is used by the routine at __LCOPY.
INIT_OUTPUT_0:
  LD A,$0D
  CALL OUTC_TABEXP_4
  XOR A
  LD (LPT_POS),A
  RET
; This entry point is used by the routine at _OUTC.
INIT_OUTPUT_1:
  POP AF

; LCD character output routine (A=char)
LCD_OUT:
  PUSH AF
  CALL OUTC_SUB0
  LD A,(CSRY)
  DEC A
  LD (TTYPOS),A
  POP AF
  RET

; Send a CRLF to screen if needed to end the current line.
;
; Used by the routines at JPBC, READY, __FILES, __CLOAD, LOAD_RECORD, __END,
; PRINT_LINE and SCHEDL_DE.
CONSOLE_CRLF:
  LD A,(CSRY)
  DEC A
  RET Z
  JP CONSOLE_CRLF_0
  LD (HL),$00
  CALL RINPUT
  LD HL,$F684
  JP NZ,CONSOLE_CRLF_1
; This entry point is used by the routines at __PRINT, __LIST and USING.
CONSOLE_CRLF_0:
  LD A,$0D
  RST OUTC
  LD A,$0A
  RST OUTC
; This entry point is used by the routines at __PRINT and PRS1.
CONSOLE_CRLF_1:
  CALL RINPUT
  JP Z,CONSOLE_CRLF_2
  XOR A
  RET
CONSOLE_CRLF_2:
  LD A,(PRTFLG)
  OR A
  JP Z,CONSOLE_CRLF_3
  XOR A
  LD (LPT_POS),A
  RET
CONSOLE_CRLF_3:
  XOR A
  LD (TTYPOS),A
  RET

; Routine at 19434
;
; Used by the routine at VARPTR_VAR.
INKEY_S:
  RST CHRGTB
  PUSH HL
  CALL CHSNS
  JP Z,INKEY_S_0
  CALL CHGET
  PUSH AF
  CALL SAVSTR_1
  POP AF
  LD E,A
  CALL __CHR_S_0
INKEY_S_0:
  LD HL,$03F5
  LD (DBL_FPREG),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET

; Routine at 19467
;
; Used by the routines at OPENDO, UPLDR and TXT_CTL_G.
FNAME:
  PUSH HL
  JP FNAME_1
; This entry point is used by the routines at __NAME, PRPARM, __OPEN, __MERGE
; and __SAVE.
FNAME_0:
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD A,(HL)
  OR A
  JP Z,FNAME_4
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E
  LD E,A
FNAME_1:
  CALL DSKI_S_0
  PUSH AF
  LD BC,FILNAM
  LD D,$09
  INC E
FNAME_2:
  DEC E
  JP Z,FNAME_7
  CALL UCASE_HL
  CP $20
  JP C,FNAME_4
  CP $7F
  JP Z,FNAME_4
  CP $2E
  JP Z,FNAME_6
  LD (BC),A
  INC BC
  INC HL
  DEC D
  JP NZ,FNAME_2
FNAME_3:
  POP AF
  PUSH AF
  LD D,A
  LD A,(FILNAM)
  INC A
  JP Z,FNAME_4
  POP AF
  POP HL
  RET
FNAME_4:
  JP NMERR
FNAME_5:
  INC HL
  JP FNAME_2
FNAME_6:
  LD A,D
  CP $09
  JP Z,FNAME_4
  CP $03
  JP C,FNAME_4
  JP Z,FNAME_5
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP FNAME_6
FNAME_7:
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP NZ,FNAME_7
  JP FNAME_3
; This entry point is used by the routine at DSKI_S.
FNAME_8:
  LD A,(HL)
  INC HL
  DEC E
  RET
  CALL MAKINT

; Get information for the file number in the A register. Equal to VARPTR(#x).
;
; Used by the routines at VARPTR_BUF, SELECT, _OPEN and CLOSE1.
VARPTR_A:
  LD L,A
  LD A,(MAXFIL)
  CP L
  JP C,BNERR
  LD H,$00
  LD ($FAA2),HL
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
  JP NC,VARPTR_A_0
  RST $38
  LD E,$C3
  LD H,B
  LD D,B
VARPTR_A_0:
  POP HL
  LD A,(HL)
  OR A
  SCF
  RET
; This entry point is used by the routine at INPUT_S.
VARPTR_A_1:
  DEC HL
  RST CHRGTB
  CP '#'
  CALL Z,_CHRGTB
  CALL GETINT
  EX (SP),HL
  PUSH HL

; Routine at 19647
;
; Used by the routines at __MERGE and L4F2E.
SELECT:
  CALL VARPTR_A
  JP Z,CFERR
  LD (PTRFIL),HL
  RST $38
  INC C
  RET

; Routine at 19659
__OPEN:
  LD BC,TAB_5
  PUSH BC
  CALL FNAME_0
  JP NZ,__OPEN_0
  LD D,$F8				; TK_FOR, 'FOR' TOKEN code
__OPEN_0:
  RST SYNCHR
  ADD A,C
  CP $84				; TK_INPUT, 'INPUT' TOKEN code
  LD E,$01
  JP Z,$4CFC		; __OPEN_INPUT (covered by SYNCHR byte)
  
  CP $96			; TK_OUT ('OUT..P.U.T' !)
  JP Z,__OPEN_OUTPUT
  
  RST SYNCHR
  DEFB 'A'
  RST SYNCHR
  DEFB 'P'
  RST SYNCHR
  DEFB 'P'
  RST SYNCHR
  ADD A,B			; DEFB TK_END
  LD E,$08			; 'APPEND'
  JP __OPEN_2
__OPEN_OUTPUT:
  RST CHRGTB
  RST SYNCHR
  DEFB 'P'
  RST SYNCHR
  DEFB 'U'
  RST SYNCHR
  DEFB 'T'		; "OUTPUT"  :S
  LD E,$02
  LD A,$D7
__OPEN_2:
  RST SYNCHR
  DEFB 'A'
  RST SYNCHR
  DEFB 'S'			; 'AS'
  PUSH DE
  LD A,(HL)
  CP '#'
  CALL Z,_CHRGTB
  CALL GETINT
  OR A
  JP Z,BNERR
  RST $38
  JR _OPEN_0

; Routine at 19730
;
; Used by the routines at __MERGE, __SAVE, __EDIT, TXT_CTL_G and TXT_CTL_V.
_OPEN:
  PUSH DE
  DEC HL
  LD E,A
  RST CHRGTB
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
  INC E
  JP C,IEERR
  PUSH HL
  LD BC,$0004
; This entry point is used by the routine at __OPEN.
_OPEN_0:
  ADD HL,BC
  LD (HL),D
  LD A,$00
  POP HL
  JP GET_DEVICE

; Routine at 19768
;
; Used by the routines at __CLOSE, INIT_PRINT_h and L4F2E.
CLOSE1:
  PUSH HL
  OR A
  JP NZ,CLOSE1_0
  LD A,($FCA7)
  AND $01
  JP NZ,INPUT_S_7
CLOSE1_0:
  CALL VARPTR_A
  JP Z,_CLOSE_0
  LD (PTRFIL),HL
  PUSH HL
  LD A,$02
  JP C,GET_DEVICE
  RST $38
  INC D
  JP IEERR

; LCD, CRT, and LPT file close routine
;
; Used by the routines at RAM_CLS, CAS_CLS and COM_CLS.
_CLOSE:
  CALL INPUT_S_6
  POP HL
; This entry point is used by the routine at CLOSE1.
_CLOSE_0:
  PUSH HL
  LD DE,$0007
  ADD HL,DE
  LD (HL),A
  LD H,A
  LD L,A
  LD (PTRFIL),HL
  POP HL
  ADD A,(HL)
  LD (HL),$00
  POP HL
  RET

; RUN statement with text following the RUN
;
; Used by the routine at __RUN.
_RUN:
  SCF
  LD DE,$AFF6

; Routine at 19824
__LOAD:
  OR $AF

; Routine at 19825
__MERGE:
  XOR A
  PUSH AF
  DEC HL
  RST CHRGTB
  CP $4D
  JP Z,LOADM_RUNM
  CALL FNAME_0
  JP Z,__LCOPY_2
  LD A,D
  CP $F8
  JP Z,__LCOPY_2
  CP $FD
  JP Z,__CLOAD_0
  RST $38
  LD A,(DE)
; This entry point is used by the routine at __LCOPY.
__MERGE_0:
  POP AF
  PUSH AF
  JP Z,__MERGE_2
  LD A,(HL)
  SUB $2C
  OR A
  JP NZ,__MERGE_2
  RST CHRGTB
  RST SYNCHR
  LD D,D
  POP AF
  SCF
; This entry point is used by the routine at __EDIT.
__MERGE_1:
  PUSH AF
__MERGE_2:
  PUSH AF
  XOR A
  LD E,$01
  CALL _OPEN
; This entry point is used by the routine at LOAD_RECORD.
__MERGE_3:
  LD HL,(PTRFIL)
  LD BC,$0007
  ADD HL,BC
  POP AF
  SBC A,A
  AND $80
  OR $01
  LD ($FCA7),A
  POP AF
  PUSH AF
  SBC A,A
  LD ($FC92),A
  LD A,(HL)
  OR A
  JP M,__SAVE_3
  POP AF
  CALL NZ,__NEW_0
  CALL __SAVE_4
  XOR A
  CALL SELECT
  JP PROMPT

; Routine at 19919
__SAVE:
  CP $4D
  JP Z,SAVEM
  CALL OMERR_1
  CALL FNAME_0
  JP Z,__LCOPY_6
  LD A,D
  CP $F8
  JP Z,__LCOPY_6
  CP $FD
  JP Z,__CSAVE_0
  RST $38
  LD D,$2B
  RST CHRGTB
  LD E,$80
  SCF
  JP Z,__SAVE_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  LD B,C
  OR A
  LD E,$02
__SAVE_0:
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
; This entry point is used by the routines at __LCOPY and __CSAVE.
__SAVE_1:
  XOR A
  CALL _OPEN
  POP AF
  JP C,__SAVE_2
  DEC HL
  RST CHRGTB
  JP __LIST
__SAVE_2:
  RST $38
  LD ($4EC3),HL
  LD D,B
; This entry point is used by the routine at __MERGE.
__SAVE_3:
  RST $38
  INC H
  JP NMERR
; This entry point is used by the routines at __KILL, SETMAX, __END, __MERGE
; and __MAX.
__SAVE_4:
  LD A,($FCA7)
  OR A
; This entry point is used by the routine at __CLOSE.
__SAVE_5:
  RET M

; Routine at 20007
CLOSE_FN:
  XOR A

; Routine at 20008
__CLOSE:
  LD A,(MAXFIL)
  JP NZ,__CLOSE_1
  PUSH HL
__CLOSE_0:
  PUSH AF
  OR A
  CALL CLOSE1
  POP AF
  DEC A
  JP P,__CLOSE_0
  POP HL
  RET
__CLOSE_1:
  LD A,(HL)
  CP '#'
  CALL Z,_CHRGTB
  CALL GETINT
  PUSH HL
  SCF
  CALL CLOSE1
  POP HL
  LD A,(HL)
  CP $2C
  RET NZ
  RST CHRGTB
  JP __CLOSE_1
; This entry point is used by the routine at _OUTC.
__CLOSE_2:
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
  JR NZ,__SAVE_5
  LD C,(HL)
  LD D,B
; This entry point is used by the routines at RDBYT and L4F2E.
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

; Routine at 20090
;
; Used by the routines at INXD, INPUT_S, L4F2E and TXT_CTL_V.
RDBYT:
  PUSH BC
  PUSH HL
  PUSH DE
  LD HL,(PTRFIL)
  LD A,$06
  CALL __CLOSE_3
  RST $38
  LD C,$C3
  LD C,(HL)
  LD D,B
; This entry point is used by the routines at RAM_IO, CAS_INPUT, COM_INPUT and
; __EOF.
RDBYT_0:
  POP DE
  POP HL
  POP BC
  RET

; INPUT$ Function
;
; Used by the routine at VARPTR_VAR.
INPUT_S:
  RST CHRGTB
  RST SYNCHR
  INC H
  RST SYNCHR
  JR Z,$4E79
  LD HL,(PTRFIL)
  PUSH HL
  LD HL,L0000
  LD (PTRFIL),HL
  POP HL
  EX (SP),HL
  CALL GETINT
  PUSH DE
  LD A,(HL)
  CP $2C
  JP NZ,INPUT_S_1
  RST CHRGTB
  CALL VARPTR_A_1
  CP $01
  JP Z,INPUT_S_0
  CP $04
  JP NZ,EFERR
INPUT_S_0:
  POP HL
  XOR A
  LD A,(HL)
INPUT_S_1:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
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
INPUT_S_2:
  POP AF
  PUSH AF
  JP Z,INPUT_S_5
  CALL CHGET
  CP $03
  JP Z,INPUT_S_4
INPUT_S_3:
  LD (HL),A
  INC HL
  DEC C
  JP NZ,INPUT_S_2
  POP AF
  POP BC
  POP HL
  RST $38
  DJNZ $4F07
  ADC A,H
  CALL M,$C3C5
  ADC A,L
  DAA
INPUT_S_4:
  POP AF
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  POP HL
  JP BASIC_MAIN
INPUT_S_5:
  CALL RDBYT
  JP C,EFERR
  JP INPUT_S_3
; This entry point is used by the routine at _CLOSE.
INPUT_S_6:
  CALL INIT_PRINT_h_0
  PUSH HL
  LD B,$00
  CALL ZERO_MEM
; This entry point is used by the routine at CLOSE1.
INPUT_S_7:
  POP HL
  RET

; Zero the memory starting at HL for B number of bytes
;
; Used by the routines at INPUT_S, INITIO and POPALL_INT.
ZERO_MEM:
  XOR A

; Fill the memory starting at HL with the byte in the A register for B number
; of bytes
INIT_PRINT_h:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,INIT_PRINT_h
  RET
; This entry point is used by the routine at INPUT_S.
INIT_PRINT_h_0:
  LD HL,(PTRFIL)
  LD DE,$0009
  ADD HL,DE
  RET
; This entry point is used by the routine at __CLOSE.
INIT_PRINT_h_1:
  POP AF
  RET
; This entry point is used by the routine at EXEC_HL.
INIT_PRINT_h_2:
  CALL RINPUT
  JP Z,EXEC
  XOR A
  CALL CLOSE1
  JP DSERR
; This entry point is used by the routines at INPUT_h and L4F2E.
INIT_PRINT_h_3:
  LD C,$01
; This entry point is used by the routine at __PRINT.
INIT_PRINT_h_4:
  CP '#'
  RET NZ

; Routine called by the PRINT statement to initialize a PRINT #: Get stream
; number (C=default #channel)
L4F2E:
  PUSH BC
  CALL FNDNUM
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  LD A,E
  PUSH HL
  CALL SELECT
  LD A,(HL)
  POP HL
  POP BC
  CP C
  JP Z,L4F2E_0
  JP BNERR
L4F2E_0:
  LD A,(HL)
  RET
; This entry point is used by the routines at READY, INXD, __EDIT, TXT_CTL_Y,
; TXT_CTL_G and TXT_CTL_V.
L4F2E_1:
  LD BC,$3F9C
  PUSH BC
  XOR A
  JP CLOSE1
; This entry point is used by the routine at __READ.
L4F2E_2:
  RST GETYPR
  LD BC,$0D31
  LD DE,$2C20
  JP NZ,L4F2E_3
  LD E,D
  JP L4F2E_3
; This entry point is used by the routine at __LINE.
LINE_INPUT:
  LD BC,TAB_5
  PUSH BC
  CALL INIT_PRINT_h_3
  CALL GETVAR
  CALL TSTSTR
  PUSH DE
  LD BC,$09BD
  XOR A
  LD D,A
  LD E,A
L4F2E_3:
  PUSH AF
  PUSH BC
  PUSH HL
L4F2E_4:
  CALL RDBYT
  JP C,EFERR
  CP $20
  JP NZ,L4F2E_5
  INC D
  DEC D
  JP NZ,L4F2E_4
L4F2E_5:
  CP $22
  JP NZ,L4F2E_6
  LD A,E
  CP $2C
  LD A,$22
  JP NZ,L4F2E_6
  LD D,A
  LD E,A
  CALL RDBYT
  JP C,L4F2E_11
L4F2E_6:
  LD HL,KBUF
  LD B,$FF
L4F2E_7:
  LD C,A
  LD A,D
  CP $22
  LD A,C
  JP Z,L4F2E_9
  CP $0D
  PUSH HL
  JP Z,L4F2E_13
  POP HL
  CP $0A
  JP NZ,L4F2E_9
L4F2E_8:
  LD C,A
  LD A,E
  CP $2C
  LD A,C
  CALL NZ,L4F2E_18
  CALL RDBYT
  JP C,L4F2E_11
  CP $0A
  JP Z,L4F2E_8
  CP $0D
  JP NZ,L4F2E_9
  LD A,E
  CP $20
  JP Z,L4F2E_10
  CP $2C
  LD A,$0D
  JP Z,L4F2E_10
L4F2E_9:
  OR A
  JP Z,L4F2E_10
  CP D
  JP Z,L4F2E_11
  CP E
  JP Z,L4F2E_11
  CALL L4F2E_18
L4F2E_10:
  CALL RDBYT
  JP NC,L4F2E_7
L4F2E_11:
  PUSH HL
  CP $22
  JP Z,L4F2E_12
  CP $20
  JP NZ,L4F2E_15
L4F2E_12:
  CALL RDBYT
  JP C,L4F2E_15
  CP $20
  JP Z,L4F2E_12
  CP $2C
  JP Z,L4F2E_15
  CP $0D
  JP NZ,L4F2E_14
L4F2E_13:
  CALL RDBYT
  JP C,L4F2E_15
  CP $0A
  JP Z,L4F2E_15
L4F2E_14:
  LD HL,(PTRFIL)
  LD C,A
  LD A,$08
  CALL __CLOSE_3
  RST $38
  LD (DE),A
  JP NMERR
; This entry point is used by the routine at COM_IO.
L4F2E_15:
  POP HL
L4F2E_16:
  LD (HL),$00
  LD HL,$F684
  LD A,E
  SUB $20
  JP Z,L4F2E_17
  LD B,$00
  CALL QTSTR_0	; Eval quoted string
  POP HL
  RET
  
L4F2E_17:
  RST GETYPR
  PUSH AF
  RST CHRGTB
  POP AF
  PUSH AF
  CALL C,DBL_ASCTFP
  POP AF
  CALL NC,DBL_ASCTFP
  POP HL
  RET
L4F2E_18:
  OR A
  RET Z
  LD (HL),A
  INC HL
  DEC B
  RET NZ
  POP AF
  JP L4F2E_16

; NM error: bad file name
;
; Used by the routines at LCDLPT_OPN, CAS_OPN, COM_OPN, __EOF, __LCOPY, FINDCO,
; FNAME, __SAVE, L4F2E and DSKI_S.
NMERR:
  LD E,$37
  LD BC,$351E

; AO error: file already open
;
; Used by the routines at RAM_OPN and _OPEN.
AOERR:
  LD E,$35
  LD BC,$381E

; DS error: direct statement in a program being loaded
;
; Used by the routine at INIT_PRINT_h.
DSERR:
  LD E,$38
  LD BC,$341E

; FF error: file not found
;
; Used by the routines at RAM_OPN, __KILL, __NAME and CLOADM.
FFERR:
  LD E,$34
  LD BC,$3A1E

; CF error: file not open
;
; Used by the routines at __EOF and SELECT.
CFERR:
  LD E,$3A
  LD BC,$331E

; BN error: bad file nuber
;
; Used by the routines at VARPTR_A, __OPEN and L4F2E.
BNERR:
  LD E,$33
  LD BC,$321E

; IE error: internal error
;
; Used by the routines at _OPEN and CLOSE1.
IEERR:
  LD E,$32
  LD BC,$361E

; EF error: end of file
;
; Used by the routines at INPUT_S and L4F2E.
EFERR:
  LD E,$36
  LD BC,$391E

; FL error: too many files
;
; Used by the routine at NXTDIR.
FLERR:
  LD E,$39
  JP ERROR

; LOF Function
__LOF:
  RST $38
  LD C,(HL)

; LOC Function
__LOC:
  RST $38
  LD D,B

; __LFILES
__LFILES:
  RST $38
  LD D,D

; DSKO$
__DSKO_S:
  RST $38
  LD D,(HL)

; DSKI$
;
; Used by the routine at VARPTR_VAR.
DSKI_S:
  RST $38
  LD D,H
; This entry point is used by the routine at FNAME.
DSKI_S_0:
  RST $38
  JR Z,DSKI_S_10
  CP $3A
  JP C,$5096
  PUSH HL
  LD D,E
  CALL FNAME_8
  JP Z,DSKI_S_2
DSKI_S_1:
  CP $3A
  JP Z,DSKI_S_3
  CALL FNAME_8
  JP P,DSKI_S_1
DSKI_S_2:
  LD E,D
  POP HL
  XOR A
  RST $38
  LD HL,($FFC9)
  LD L,$C3
  LD C,(HL)
  LD D,B
DSKI_S_3:
  LD A,D
  SUB E
  DEC A
  CP $02
  JP NC,DSKI_S_4
  RST $38
  INC L
  JP NMERR
DSKI_S_4:
  CP $05
  JP NC,NMERR
  POP BC
  PUSH DE
  PUSH BC
  LD C,A
  LD B,A
  LD DE,DEVICE_TBL
  EX (SP),HL
  PUSH HL
DSKI_S_5:
  CALL UCASE_HL
  PUSH BC
  LD B,A
  LD A,(DE)
  INC HL
  INC DE
  CP B
  POP BC
  JP NZ,DSKI_S_8
  DEC C
  JP NZ,DSKI_S_5
DSKI_S_6:
  LD A,(DE)
  OR A
  JP M,DSKI_S_7
  CP $31
  JP NZ,DSKI_S_8
  INC DE
  LD A,(DE)
  JP DSKI_S_8
DSKI_S_7:
  POP HL
  POP HL
  POP DE
  OR A
  RET
DSKI_S_8:
  OR A
  JP M,DSKI_S_6
DSKI_S_9:
  LD A,(DE)
  OR A
  INC DE
  JP P,DSKI_S_9
  LD C,B
  POP HL
  PUSH HL
  LD A,(DE)
  OR A
  JP NZ,DSKI_S_5
  JP NMERR
  
DEVICE_TBL:
  LD C,H
  LD B,E
  LD B,H
  RST $38
  LD B,E
DSKI_S_10:
  LD D,D
  LD D,H
  CP $43
  LD B,C
  LD D,E
  DEFB $FD
  LD B,E
  LD C,A
  LD C,L
  CALL M,__CLEAR_2
  LD C,(HL)
  LD B,H
  EI
  LD C,H
  LD D,B
  LD D,H
  JP M,ESC_X_0
  LD C,L
  LD SP,HL
  LD D,D
  LD B,C
  LD C,L
  RET M
  NOP

; Start of device control block vector addresses (jp table)
DEVICE_VECT:
  DEFW LCD_CTL
  DEFW CRT_CTL
  DEFW CAS_CTL
  DEFW COM_CTL
  DEFW WAND_CTL
  DEFW LPT_CTL
  DEFW MDM_CTL
  DEFW RAM_CTL

; Routine at 20771
;
; Used by the routines at __EOF, _OPEN, CLOSE1 and __CLOSE.
GET_DEVICE:
  RST $38
  JR NC,$510B
  PUSH DE
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

; Entry to TELCOM
;
; Used by the routine at TEL_BYE.
TELCOM:
  CALL UNLOCK
  LD HL,$51A4
  CALL STDSPF
  JP TEL_GET_STAT
; This entry point is used by the routines at TELCOM_RDY, TEL_SET_STAT,
; TEL_CALL and TEL_FIND.
TELCOM_0:
  CALL __BEEP
  LD HL,$51A4
  CALL STFNK

; TELCOM Ready re-entry point for TELCOM commands
;
; Used by the routines at TEL_GET_STAT, TEL_SET_STAT, TEL_CALL and TEL_FIND.
TELCOM_RDY:
  CALL STKINI
  LD HL,TELCOM_0
  LD (ERRTRP),HL
  LD HL,$517C
  CALL PRINT_LINE
  CALL INLIN
  RST CHRGTB
  AND A
  JP Z,TELCOM_RDY
  LD DE,TELCOM_TBL
  CALL LOAD_BA_LBL_1
  JP Z,TELCOM_0
  RET
  LD D,H
  LD H,L
  LD L,H
  LD H,E
  LD L,A
  LD L,L
  LD A,(OUTC)
TELCOM_TBL:
  LD D,E
  LD D,H
  LD B,C
  LD D,H
  RET NZ
  LD D,C
  LD D,H
  LD B,L
  LD D,D
  LD C,L
  LD D,L
  LD D,H
  LD B,E
  LD B,C
  LD C,H
  LD C,H
  CPL
  LD D,D
  LD B,(HL)
  LD C,C
  LD C,(HL)
  LD B,H
  LD C,L
  LD D,D
  LD C,L
  LD B,L
  LD C,(HL)
  LD D,L
  SUB A
  LD D,A
  RST $38
  LD B,(HL)
  LD L,C
  LD L,(HL)
  LD H,H
  AND B
  LD B,E
  LD H,C
  LD L,H
  LD L,H
  AND B
  LD D,E
  LD (HL),H
  LD H,C
  LD (HL),H
  AND B
  LD D,H
  LD H,L
  LD (HL),D
  LD L,L
  ADC A,L
  ADD A,B
  ADD A,B
  ADD A,B
  LD C,L
  LD H,L
  LD L,(HL)
  LD (HL),L
  ADC A,L

; TELCOM STAT instruction routine
TEL_STAT:
  DEC HL
  RST CHRGTB
  INC A
  DEC A
  JP NZ,TEL_SET_STAT

; Print current STAT (RS232 settings for TELCOM) and return to TELCOM'
;
; Used by the routine at TELCOM.
TEL_GET_STAT:
  LD HL,STAT
  LD B,$05
TEL_GET_STAT_0:
  LD A,(HL)
  RST OUTC
  INC HL
  DEC B
  JP NZ,TEL_GET_STAT_0
  LD A,$2C
  RST OUTC
  LD A,(DIAL_SPEED)
  RRCA
  LD A,$32
  SBC A,B
  RST OUTC
  LD HL,$51E7
  CALL PRS
  JP TELCOM_RDY
  JR NC,$5209
  LD (HL),B
  LD (HL),B
  LD (HL),E
  NOP

; Set STAT (RS232 settings for TELCOM) and return to TELCOM
;
; Used by the routine at TEL_STAT.
TEL_SET_STAT:
  JP C,TEL_SET_STAT_0
  CP $2C
  JP Z,TEL_SET_STAT_1
  CALL UCASE
  CP $4D
  JP NZ,TELCOM_0
  INC HL
TEL_SET_STAT_0:
  CALL SETSER
  CALL CLSCOM
  DEC HL
  RST CHRGTB
  AND A
  JP Z,TELCOM_RDY
TEL_SET_STAT_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT
  CP $14
  JP Z,TEL_SET_STAT_2
  SUB $0A
  JP NZ,TELCOM_0
  INC A
TEL_SET_STAT_2:
  LD (DIAL_SPEED),A
  JP TELCOM_RDY
; This entry point is used by the routine at TEL_FIND.
TEL_SET_STAT_3:
  LD HL,CALMSG
  CALL PRINT_TEXT
  POP DE
  CALL TEL_FIND_1
  JP Z,TELCOM_0
  EX DE,HL
  OR $37

; TELCOM CALL instruction routine
TEL_CALL:
  SCF
  PUSH HL
  LD HL,CALMSG
  CALL C,PRINT_TEXT
  POP HL
  CALL TEL_LOGON
  JP C,TELCOM_0
  JP NZ,TELCOM_RDY
  JP TEL_TERM_0

; Routine at 21060
CALMSG:
  LD B,E
  LD H,C
  LD L,H
  LD L,H
  LD L,C
  LD L,(HL)
  LD H,A
  JR NZ,TEL_FIND

; TELCOM FIND instruction routine
;
; Used by the routine at CALMSG.
TEL_FIND:
  SUB A
  CALL SHOW_TIME_3
  PUSH HL
  CALL FNDFLO
  JP Z,TELCOM_0
  CALL GTXTTB
  EX DE,HL
  POP HL
TEL_FIND_0:
  CALL FIND_TEXT
  JP NC,TELCOM_RDY
  PUSH HL
  PUSH DE
  CALL SHOW_TIME_5
  CALL TEL_FIND_1
  CALL NZ,TEL_FIND_2
  CALL OUTDO_CRLF
  CALL IS_CRLF_0
  JP Z,TELCOM_RDY
  CP $43
  JP Z,TEL_SET_STAT_3
  POP DE
  CALL NEXT_CRLF
  POP HL
  JP TEL_FIND_0
; This entry point is used by the routine at TEL_SET_STAT.
TEL_FIND_1:
  CALL TEL_FIND_4
  RET Z
  RST OUTC
  CP $3A
  INC DE
  JP NZ,TEL_FIND_1
  JP TEL_FIND_5
TEL_FIND_2:
  CALL TEL_FIND_4
  RET Z
  CP $3C
  JP Z,TEL_FIND_3
  CP $3A
  RET Z
  RST OUTC
  INC DE
  JP TEL_FIND_2
TEL_FIND_3:
  RST OUTC
  LD A,$3E
  RST OUTC
  RET
TEL_FIND_4:
  CALL IS_CRLF
  DEC DE
  LD A,(DE)
  RET Z
TEL_FIND_5:
  CP $1A
  JP Z,TELCOM_0
  RET
; This entry point is used by the routines at TEL_CONN, TEL_LIFT and
; TEL_DIAL_DGT.
TEL_FIND_6:
  IN A,($BA)
  AND $7F
  OUT ($BA),A
  RET

; Disconect phone line and disable modem carrier
;
; Used by the routines at COM_OPN, MDM_CLS, TEL_LOGON and TEL_BYE.
TEL_DISC:
  CALL TEL_CONN_0
  CALL TEL_LOGON_0
; This entry point is used by the routines at TEL_LOGON and TEL_DIAL_DGT.
TEL_DISC_0:
  IN A,($BA)
  OR $80
  OUT ($BA),A
  RET
; This entry point is used by the routines at TEL_LIFT and TEL_LOGON.
TEL_DISC_1:
  LD A,(PORT_A8)
  OR $01
  JP TEL_CONN_1

; Connect phone line and enable modem carrier
;
; Used by the routines at TEL_LIFT and TEL_LOGON.
TEL_CONN:
  CALL TEL_FIND_6
  LD A,$03
  JP TEL_CONN_1
; This entry point is used by the routines at TEL_DISC and TEL_LOGON.
TEL_CONN_0:
  LD A,(PORT_A8)
  AND $01
; This entry point is used by the routines at TEL_DISC and TEL_LOGON.
TEL_CONN_1:
  LD (PORT_A8),A
  OUT ($A8),A
  SCF
  RET

; Lift telephone and wait for a carrier.
;
; Used by the routines at COM_OPN, TEL_LOGON and TEL_TERM.
TEL_LIFT:
  IN A,($BB)
  AND $10
  JP Z,TEL_LIFT_1
  CALL TEL_CONN
TEL_LIFT_0:
  CALL BREAK
  RET C
  CALL CARDET
  JP NZ,TEL_LIFT_0
  RET
TEL_LIFT_1:
  CALL TEL_DISC_1
  CALL TEL_FIND_6
  NOP
  NOP
  NOP
  CALL TEL_LIFT_0
  RET C
  LD A,$05
  CALL TMDELA
  CALL TEL_CONN
  AND A
  RET

; Pause for about 2 seconds
;
; Used by the routine at TEL_LOGON.
TEL_PAUSE:
  XOR A
  LD A,$05
; This entry point is used by the routine at TMDELA.
TEL_PAUSE_0:
  CALL NZ,TMDELA_0

; Routine at 21270
;
; Used by the routines at COM_OPN, MDM_CLS, TEL_LIFT, TEL_LOGON and
; TEL_DIAL_DGT.
TMDELA:
  DEC A
  JP NZ,TEL_PAUSE_0
; This entry point is used by the routines at TEL_PAUSE and TEL_LOGON.
TMDELA_0:
  LD C,$C8
TMDELA_1:
  CALL TMDELA_2
  CALL TMDELA_2
  DEC C
  JP NZ,TMDELA_1
; This entry point is used by the routine at TEL_DIAL_DGT.
TMDELA_2:
  LD B,$AC
TMDELA_3:
  DEC B
  JP NZ,TMDELA_3
  RET

; Execute logon sequence pointed to by HL.(autodialer)
;
; Used by the routine at TEL_CALL.
TEL_LOGON:
  IN A,($BA)
  PUSH AF
  OR $08
  OUT ($BA),A
  CALL TEL_LOGON_1
  POP BC
  PUSH AF
  LD A,B
  AND $08
  LD B,A
  IN A,($BA)
  AND $F7
  OR B
  OUT ($BA),A
  POP AF
  RET NC
  CALL TEL_DISC
  CALL TEL_DISC_1
  LD A,$03
  CALL TMDELA
; This entry point is used by the routine at TEL_DISC.
TEL_LOGON_0:
  LD A,(PORT_A8)
  AND $02
  JP TEL_CONN_1
TEL_LOGON_1:
  XOR A
  LD (PORT_A8),A
  CALL TEL_DISC_0
  CALL TEL_DISC_1
  CALL TMDELA_0
  CALL TEL_CONN
  CALL TEL_CONN_0
  CALL TEL_PAUSE
  DEC HL
TEL_LOGON_2:
  CALL BREAK
  RET C
  PUSH HL
  EX DE,HL
  CALL IS_CRLF
  DEC DE
  LD A,(DE)
  POP HL
  JP Z,TEL_LOGON_3
  CP $1A
  JP Z,TEL_LOGON_3
  RST CHRGTB
  JP Z,TEL_LOGON_3
  PUSH AF
  CALL C,TEL_DIAL_DGT
  POP AF
  JP C,TEL_LOGON_2
  CP $3C
  SCF
  JP Z,TEL_LOGON_3
  CP $3D
  CALL Z,TEL_PAUSE
  JP TEL_LOGON_2
TEL_LOGON_3:
  PUSH AF
  LD A,(DIAL_SPEED)
  RRCA
  CALL NC,TMDELA_0
  POP AF
  JP NC,TEL_DISC
  LD A,(STAT)
  CP $4D
  SCF
  RET NZ
  PUSH HL
  LD HL,$F65C
  AND A
  CALL SETSER
  LD A,$04
  CALL TMDELA
  POP HL
  CALL TEL_LIFT
  RET C
TEL_LOGON_4:
  CALL UPLDR_7
  CALL TEL_LOGON_10
  RET Z
  CP $3E
  RET Z
  CP $3D
  JP Z,TEL_LOGON_6
  CP $5E
  JP Z,TEL_LOGON_9
  CP $3F
  JP Z,TEL_LOGON_7
  CP $21
  CALL Z,TEL_LOGON_10
  RET Z
TEL_LOGON_5:
  CALL SD232C
  XOR A
  INC A
TEL_LOGON_6:
  CALL Z,TEL_PAUSE
  JP TEL_LOGON_4
TEL_LOGON_7:
  CALL TEL_LOGON_10
  RET Z
TEL_LOGON_8:
  CALL RV232C
  RET C
  RST OUTC
  CP (HL)
  JP NZ,TEL_LOGON_8
  JP TEL_LOGON_4
TEL_LOGON_9:
  CALL TEL_LOGON_10
  RET Z
  AND $1F
  JP TEL_LOGON_5
TEL_LOGON_10:
  INC HL
  LD A,(HL)
  AND A
  RET

; Dial the digit that is present in the A register.
;
; Used by the routine at TEL_LOGON.
TEL_DIAL_DGT:
  RST OUTC
  DI
  AND $0F
  LD C,A
  JP NZ,TEL_DIAL_DGT_0
  LD C,$0A
TEL_DIAL_DGT_0:
  LD A,(DIAL_SPEED)
  RRCA
  LD DE,$161C
  JP NC,TEL_DIAL_DGT_1
  LD DE,$2440
TEL_DIAL_DGT_1:
  CALL TEL_DISC_0
TEL_DIAL_DGT_2:
  CALL TMDELA_2
  DEC E
  JP NZ,TEL_DIAL_DGT_2
  CALL TEL_FIND_6
TEL_DIAL_DGT_3:
  CALL TMDELA_2
  DEC D
  JP NZ,TEL_DIAL_DGT_3
  DEC C
  JP NZ,TEL_DIAL_DGT_0
  EI
  LD A,(DIAL_SPEED)
  AND $01
  INC A
  JP TMDELA
  LD D,B
  LD (HL),D
  LD H,L
  OR $44
  LD L,A
  LD (HL),A
  XOR $20
  LD D,L
  RET P
  ADD A,B
  ADD A,B
  ADD A,B
  ADD A,B
  LD B,D
  LD A,C
  PUSH HL

; TELCOM TERM instruction routine
TEL_TERM:
  LD HL,RS232LF
  RST CHRGTB
  CALL NC,LOADFP_1
  PUSH AF
  CALL SETSER
  POP AF
  CCF
  CALL C,TEL_LIFT
  JP C,TEL_BYE_0
; This entry point is used by the routine at TEL_CALL.
TEL_TERM_0:
  LD A,$40
  LD ($F650),A
  LD ($F67B),A
  XOR A
  LD (CAPTUR),A
  LD ($FAC3),A
  CALL ESC_J_10
  LD HL,$5443
  CALL STFNK
  CALL DUPDSP
  CALL ECHDSP
  CALL WATDSP
  CALL DSPFNK
  CALL CURSON
; This entry point is used by the routines at DWNLDR and TEL_BYE.
TEL_TERM_1:
  CALL RESTAK
  LD HL,$54EF
  LD (ERRTRP),HL
  LD A,(XONXOFF)
  AND A
  JP Z,TEL_TERM_2
  LD A,(ENDLCD)
  LD HL,$F7D9
  XOR (HL)
  RRCA
  CALL C,WATDSP
TEL_TERM_2:
  CALL CHSNS
  JP Z,TEL_TERM_3
  CALL CHGET
  JP C,TEL_TERM_6
  LD B,A
  LD A,(DUPLEX)
  AND A
  LD A,B
  CALL Z,_OUTC
  AND A
  CALL NZ,SD232C
  JP C,TEL_TERM_4
TEL_TERM_3:
  CALL RCVX
  JP Z,TEL_TERM_1
  CALL RV232C
  JP C,TEL_TERM_1
  RST OUTC
  LD B,A
  LD A,($F659)
  AND A
  LD A,B
  CALL NZ,OUTC_TABEXP
  CALL DWNLDR_3
  JP TEL_TERM_1
TEL_TERM_4:
  XOR A
  LD (ENDLCD),A
TEL_TERM_5:
  CALL BREAK
  JP C,TEL_TERM_5
  JP TEL_TERM_1
  CALL __BEEP
  XOR A
  LD ($F659),A
  CALL ECHDSP
  JP TEL_TERM_1
TEL_TERM_6:
  LD E,A
  LD D,$FF
  LD HL,$551D
  ADD HL,DE
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD DE,TEL_TERM_1
  PUSH DE
  JP (HL)
TEL_JPTAB:
  INC HL
  LD D,L
  LD A,(HL)
  LD D,(HL)
  SBC A,L
  LD D,L
  LD A,$55
  LD D,B
  LD D,L
  DEC E
  LD D,L
  JR NZ,$5570
  LD E,$57
  RST $38
  LD ($FFC9),A
  INC (HL)
  RET

; TELCOM PREV function routine
TEL_PREV:
  CALL OUTC_SUB2_1
  CALL CURSOFF
  CALL ESC_J_16
TEL_PREV_0:
  CALL CHSNS
  JP Z,TEL_PREV_0
  CALL CHGET
  CALL ESC_J_13
  CALL CURSON
  JP _ESC_X

; TELCOM FULL/HALF function routine
TEL_DUPLEX:
  LD HL,DUPLEX
  LD A,(HL)
  CPL
  LD (HL),A

; Routine at 21828
;
; Used by the routine at TEL_TERM.
DUPDSP:
  LD A,(DUPLEX)
  LD DE,$F7B9
  LD HL,FULLHALF_MSG
  JP CHGDSP

; TELCOM ECHO function routine
TEL_ECHO:
  LD HL,$F659
  LD A,(HL)
  CPL
  LD (HL),A

; Routine at 21846
;
; Used by the routine at TEL_TERM.
ECHDSP:
  LD A,($F659)
  LD DE,$F7C9
  LD HL,ECHO_MSG
  JP CHGDSP

; Routine at 21858
;
; Used by the routine at TEL_TERM.
WATDSP:
  LD A,(ENDLCD)
  LD DE,$F7D9
  LD HL,CR_WAIT_MSG

; Routine at 21867
;
; Used by the routines at DUPDSP and ECHDSP.
CHGDSP:
  AND A
  LD BC,$0004
  JP NZ,CHGDSP_0
  ADD HL,BC
CHGDSP_0:
  LD B,C
  CALL LDIR_B
  LD B,$0C
  XOR A
CHGDSP_1:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,CHGDSP_1
  JP FNKSB
 
FULLHALF_MSG:
  DEFM "FullHalf"

ECHO_MSG:
  DEFM "Echo    "
  
CR_WAIT_MSG:
  DEFB $0D
  DEFM " "

; Text at $5593
WAIT_MSG:
  DEFB $0D
  DEFM " Wait "
  DEFB $00
  DEFM "  "

; TELCOM UP function routine
TEL_UP:
  LD HL,$56EF

; Routine at 21920
UPLDR:
  LD (ERRTRP),HL
  PUSH HL
  LD A,(CAPTUR)
  AND A
  RET NZ
  CALL RESFPT
  LD HL,UPLMSG_0
  CALL PRINT_LINE
  CALL QINLIN
  RST CHRGTB
  AND A
  RET Z
  LD ($FAC6),A
  CALL COUNT_CHARS
  CALL FNAME
  RET NZ
  CALL FINDCO_0
  LD HL,FNTFND
  JP Z,PRINT_LINE
  EX DE,HL
  EX (SP),HL
  PUSH HL
  LD HL,$670C
  CALL PRINT_LINE
  CALL INLIN
  RET C
  RST CHRGTB
  AND A
  LD A,$01
  LD ($FAC3),A
  LD ($F920),A
  JP Z,$55FD
  CALL GETINT
  CP $0A
  RET C
  CP $85
; This entry point is used by the routine at CHGDSP.
UPLDR_0:
  RET NC
  LD HL,$F894
  LD ($F892),HL
  LD ($F922),A
  LD ($FAC3),A
  POP AF
  POP DE
  LD BC,$E1F1
  PUSH DE
  PUSH HL
  CALL FNKSB
  POP HL
  POP DE
UPLDR_1:
  LD A,($FAC3)
  DEC A
  JP Z,UPLDR_3
  PUSH DE
  EX DE,HL
  LD HL,($F892)
  EX DE,HL
  RST CPDEHL
  POP DE
  JP NZ,UPLDR_3
  CALL $67DF
  LD A,D
  AND E
  INC A
  JP NZ,UPLDR_2
  LD HL,($F892)
  LD (HL),$1A
  INC HL
  LD ($F892),HL
UPLDR_2:
  LD HL,$F894
UPLDR_3:
  LD A,(HL)
  CP $1A
  RST $38
  LD (HL),$CA
  LD L,H
  LD D,(HL)
  CP $0A
  JP NZ,UPLDR_4
  LD A,(RS232LF)
  AND A
  JP NZ,UPLDR_4
  LD A,($FAC6)
  CP $0D
UPLDR_4:
  LD A,(HL)
  LD ($FAC6),A
  JP Z,UPLDR_5
  CALL SD232C
  CALL UPLDR_7
UPLDR_5:
  INC HL
  CALL CHSNS
  JP Z,UPLDR_1
  CALL CHGET
  CP $03
  JP Z,UPLDR_6
  CP $13
  CALL Z,CHGET
  CP $03
  JP NZ,UPLDR_1
UPLDR_6:
  XOR A
  LD ($FAC3),A
  JP FNKSB
; This entry point is used by the routine at TEL_LOGON.
UPLDR_7:
  CALL RCVX
  RET Z
  CALL RV232C
  RST OUTC
  JP UPLDR_7

; TELCOM DOWN function routine
TEL_DOWN:
  CALL RESFPT
  LD A,(CAPTUR)
  XOR $FF
  LD (CAPTUR),A
  JP Z,DWNLDR_2
  LD HL,$56E2

; Routine at 22159
DWNLDR:
  LD (ERRTRP),HL
  PUSH HL
  LD HL,$5760
  CALL PRINT_LINE
  CALL QINLIN
  RST CHRGTB
  AND A
  RET Z
  LD ($FAC6),A
  POP AF
DWNLDR_0:
  PUSH HL
  CALL OPENDO
  JP C,DWNLDR_1
  LD ($FAC4),HL
  CALL GETEND
  POP AF
  CALL TXT_CTL_C_15
  JP FNKSB
DWNLDR_1:
  EX DE,HL
  CALL KILLASC+2
  POP HL
  JP DWNLDR_0
; This entry point is used by the routine at TEL_DOWN.
DWNLDR_2:
  CALL FNKSB
  JP MCLEAR_2
; This entry point is used by the routine at TEL_TERM.
DWNLDR_3:
  LD C,A
  LD A,(CAPTUR)
  AND A
  LD A,C
  RET Z
  CALL DWNLDR_6
  RET Z
  JP NC,DWNLDR_4
  CALL DWNLDR_4
  LD A,$0A
DWNLDR_4:
  LD HL,($FAC4)
  CALL MCLEAR_4
  LD ($FAC4),HL
  RET NC
  XOR A
  LD (CAPTUR),A
  CALL FNKSB
  LD HL,DWNMSG
  JP DWNLDR_5
  LD HL,UPLMSG
DWNLDR_5:
  CALL PRINT_LINE
  LD HL,ABTMSG
  CALL PRS
  JP TEL_TERM_1
; This entry point is used by the routine at TXT_CTL_V.
DWNLDR_6:
  LD C,A
  AND A
  RET Z
  CP $1A
  RET Z
  CP $7F
  RET Z
  CP $0A
  JP NZ,DWNLDR_7
  LD A,($FAC6)
  CP $0D
DWNLDR_7:
  LD A,C
  LD ($FAC6),A
  RET Z
  CP $0D
  SCF
  CCF
  RET NZ
  AND A
  SCF
  RET

; TELCOM BYE function routine
TEL_BYE:
  LD HL,DISMSG
  CALL PRINT_LINE
  CALL QINLIN
  RST CHRGTB
  CALL UCASE
  CP $59
  JP Z,TEL_BYE_0
  LD HL,ABTMSG
  CALL PRINT_LINE
  JP TEL_TERM_1
; This entry point is used by the routine at TEL_TERM.
TEL_BYE_0:
  XOR A
  LD ($F650),A
  LD L,A
  LD H,A
  LD (CAPTUR),HL
  CALL CLSCOM
  CALL CURSOFF
  CALL TEL_DISC
  CALL MCLEAR_0
  JP TELCOM


UPLMSG_0:
  DEFM "File to "
  
UPLMSG:
  DEFM "Upload"
  DEFB $00
  DEFM "File to "

DWNMSG:
  DEFM "Download"
  DEFB $00

ABTMSG:
  DEFM " aborted"
  DEFB $0D
  DEFB $0A
  DEFB $00

FNTFND:
  DEFM "No file"
  DEFB $0D
  DEFB $0A
  DEFB $00

DISMSG:
  DEFM "Disconnect"       ; Disconnected
  DEFB $00


; Print the buffer pointed to by HL till a null or '"' is found. CR if not at
; beginning of a line.
;
; Used by the routines at LOAD_RECORD, PRPARM, CAS_OPNI_CO, TELCOM_RDY, UPLDR,
; DWNLDR and TEL_BYE.
PRINT_LINE:
  CALL CONSOLE_CRLF
  JP PRS

; MENU Statement.  Go to main menu
;
; Used by the routines at LDIR_B, SCHEDL_DE, L5D3D, TEXT and BOOT.
__MENU:
  LD HL,(FILE_BUFFR)
  LD (STRBUF),HL
  CALL OMERR_1
  CALL CLSCOM
  CALL MCLEAR_0
  CALL RESFPT
  CALL EXTREV
  CALL CURSOFF
; This entry point is used by the routine at TEL_BYE.
__MENU_0:
  CALL ERAFNK
  CALL LOCK
  LD A,($F638)
  LD ($FDFA),A
  LD A,$FF
  LD ($FAC8),A
  INC A
  LD ($F650),A
  LD (LBL_LINE),A
  CALL __SCREEN_0
  CALL L5D40_1
  LD HL,__MENU
  LD (ERRTRP),HL
  CALL CLRFLK
  CALL _PRINT_TDATE
  LD HL,$1C01
  CALL POSIT
  LD HL,$5B0D
  CALL PRINT_TEXT
  LD HL,$FDA1
  LD ($FDD7),HL
  LD B,$36
__MENU_1:
  LD (HL),$FF
  INC HL
  DEC B
  JP NZ,__MENU_1
  LD L,B
  LD DE,$5B1E
__MENU_2:
  LD A,(DE)
  OR A
  JP Z,__MENU_3
  LD C,A
  PUSH DE
  CALL __MENU_21
  POP DE
  INC DE
  JP __MENU_2
__MENU_3:
  LD A,L
  DEC A
  LD ($FDEF),A
  CP $17
  JP Z,__MENU_5
__MENU_4:
  CALL DOTTED_FNAME_1
  PUSH HL
  LD HL,$5B1A
  CALL PRINT_TEXT
  POP HL
  INC L
  LD A,L
  CP $18
  JP NZ,__MENU_4
__MENU_5:
  SUB A
  LD ($FDD9),A
  LD ($FDEE),A
  LD L,A
  CALL DOTTED_FNAME_2
  LD HL,$1808
  CALL POSIT
  CALL FREEMEM
__MENU_6:
  CALL L5D40_1
  LD HL,$5906
  LD (ERRTRP),HL
  LD HL,$0108
  CALL POSIT
  LD HL,$5B24
  CALL PRINT_TEXT
  LD HL,$0908
  CALL POSIT
  SUB A
  LD ($FDED),A
  LD HL,$FDD9
  INC A
__MENU_7:
  CALL Z,__BEEP
__MENU_8:
  CALL SHOW_TIME
  CALL CHGET_UCASE
  CP $0D
  JP Z,__MENU_15
  CP $08
  JP Z,__MENU_9
  CP $7F
  JP Z,__MENU_9
  CP $15
  JP Z,__MENU_6
  CP $20
  JP C,__MENU_11
  LD C,A
  LD A,($FDED)
  CALL Z,__MENU_10
  CP $09
  JP Z,__MENU_7
  CALL SHOW_TIME_0
  JP __MENU_8
__MENU_9:
  CALL SHOW_TIME_2
  JP Z,__MENU_7
  JP __MENU_8
__MENU_10:
  OR A
  RET NZ
  POP AF
  LD A,$1C
__MENU_11:
  PUSH AF
  LD A,($FDEE)
  LD E,A
  POP AF
  SUB $1C
  LD BC,__MENU_8
  PUSH BC
  RET M
  LD BC,$58C3
  PUSH BC
  JP Z,__MENU_14
  DEC A
  JP Z,__MENU_13
  DEC A
  POP BC
  JP Z,__MENU_12
  LD A,E
  ADD A,$04
  LD D,A
  LD A,($FDEF)
  CP D
  RET M
  LD A,D
  LD ($FDEE),A
  PUSH HL
  LD HL,(CSRX)
  PUSH HL
  LD L,E
  PUSH DE
  CALL DOTTED_FNAME_2
  POP DE
  LD L,D
  CALL DOTTED_FNAME_2
  POP HL
  CALL POSIT
  POP HL
  RET
__MENU_12:
  LD A,E
  SUB $04
  LD D,A
  RET M
  PUSH BC
  RET
__MENU_13:
  LD A,E
  DEC A
  LD D,A
  RET P
  LD A,($FDEF)
  LD D,A
  RET
__MENU_14:
  LD A,E
  INC A
  LD D,A
  LD A,($FDEF)
  CP D
  LD A,D
  RET P
  SUB A
  LD D,A
  RET
__MENU_15:
  LD A,($FDED)
  OR A
  JP Z,__MENU_16
  LD (HL),$00
  CALL CHKF_0
  JP NZ,__MENU_19
  CALL __BEEP
  JP __MENU_6
__MENU_16:
  LD A,($FDEE)
  LD HL,$FDA1
  LD DE,$0002
__MENU_17:
  OR A
  JP Z,__MENU_18
  ADD HL,DE
  DEC A
  JP __MENU_17
__MENU_18:
  CALL GTXTTB_0
__MENU_19:
  PUSH HL
  CALL __CLS
  CALL UNLOCK
  LD A,($FDFA)
  CALL __SCREEN_0
  LD A,$0C
  RST OUTC
  SUB A
  LD ($FAC8),A
  LD L,A
  LD H,L
  LD (ERRTRP),HL
  DEC A
  LD (LBL_LINE),A
  POP HL
  LD A,(HL)
  CALL GTXTTB
  CP $A0
  JP Z,LDIR_B_0
  CP $B0
  JP Z,__MENU_20
  CP $F0
  JP Z,$F624
  CP $C0
  JP Z,WAIT_SPC_1
  LD (BASTXT),HL
  DEC DE
  DEC DE
  EX DE,HL
  LD ($FA8C),HL
  CALL UPD_PTRS
  CALL LOAD_BA_LBL
  CALL BASIC_1
  CALL OMERR_0
  JP EXEC_EVAL
__MENU_20:
  JP (HL)
__MENU_21:
  LD B,$1B
  LD DE,DIRECTORY
__MENU_22:
  LD A,(DE)
  INC A
  RET Z
  DEC A
  CP C
  JP NZ,__MENU_23
  PUSH BC
  PUSH DE
  PUSH HL
  LD HL,($FDD7)
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  INC DE
  INC DE
  INC DE
  LD ($FDD7),HL
  POP HL
  CALL DOTTED_FNAME_1
  PUSH HL
  LD HL,$FDD9
  PUSH HL
  CALL DOTTED_FNAME
  POP HL
  CALL PRINT_TEXT
  POP HL
  INC L
  POP DE
  POP BC
__MENU_23:
  PUSH HL
  LD HL,$000B
  ADD HL,DE
  EX DE,HL
  POP HL
  DEC B
  JP NZ,__MENU_22
  RET

; Convert filename from right justified extention to normal dotted format
;
; Used by the routines at __MENU and CHKF.
DOTTED_FNAME:
  LD A,$06
  CALL MOVE_MEM
  LD A,' '
DOTTED_FNAME_0:
  DEC HL
  CP (HL)
  JP Z,DOTTED_FNAME_0
  INC HL
  LD (HL),$00
  LD A,(DE)
  CP $20
  RET Z
  LD (HL),$2E
  INC HL
  CALL PRINT_TEXT_0
  LD (HL),$00
  RET
; This entry point is used by the routine at __MENU.
DOTTED_FNAME_1:
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
  POP DE
  RET
; This entry point is used by the routine at __MENU.
DOTTED_FNAME_2:
  CALL SET_CLOCK_HL_9
  CALL DOTTED_FNAME_1
  LD B,$0A
  PUSH HL
  LD HL,CSRY
  DEC (HL)
DOTTED_FNAME_3:
  PUSH BC
  PUSH DE
  LD HL,(CSRX)
  CALL ESC_J_9
  EX DE,HL
  CALL MOVE_CURSOR
  DI
  CALL SET_CLOCK_HL_7
  EI
  POP DE
  LD HL,CSRY
  INC (HL)
  POP BC
  DEC B
  JP NZ,DOTTED_FNAME_3
  CALL SET_CLOCK_HL_9
  POP HL
  RET

; Print time, day, and date on the first line of the screen
;
; Used by the routine at __MENU.
_PRINT_TDATE:
  CALL __CLS

; Same as _PRINT_TDATE but screen is not cleared.
;
; Used by the routine at SHOW_TIME.
PRINT_TDATE:
  CALL CURS_HOME
  LD HL,$FD8B
  CALL L192F
  LD (HL),$20
  INC HL
  CALL L1962
  EX DE,HL
  LD (HL),$20
  INC HL
  CALL READ_TIME
  LD (HL),$00
  LD A,(MONTH)
  LD HL,$5AE6
  LD BC,$0003
PRINT_TDATE_0:
  ADD HL,BC
  DEC A
  JP NZ,PRINT_TDATE_0
  LD DE,$FD88
  EX DE,HL
  PUSH HL
  LD A,C
  CALL MOVE_MEM
  LD D,H
  LD E,L
  LD (HL),$20
  INC DE
  INC DE
  INC DE
  INC HL
  CALL PRINT_TEXT_0
  LD (HL),$2C
  INC HL
  LD (HL),$32
  INC HL
  LD (HL),$30
  POP HL

; Print the buffer pointed to by HL, null terminated.
;
; Used by the routines at TEL_SET_STAT, TEL_CALL, __MENU, SCHEDL_DE and
; SHOW_TIME.
PRINT_TEXT:
  LD A,(HL)
  OR A
  RET Z
  RST OUTC
  INC HL
  JP PRINT_TEXT
; This entry point is used by the routines at DOTTED_FNAME and PRINT_TDATE.
PRINT_TEXT_0:
  LD A,$02

; Move A bytes from (DE) to (HL)
;
; Used by the routines at DOTTED_FNAME, PRINT_TDATE and CHKF.
MOVE_MEM:
  PUSH AF
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  POP AF
  DEC A
  JP NZ,MOVE_MEM
  RET

; Compare the buffer pointed to by DE to the buffer pointed to by HL for C
; bytes or until a null is found
;
; Used by the routine at CHKF.
COMP_MEM:
  LD A,(DE)
  CP (HL)
  RET NZ
  OR A
  RET Z
  INC HL
  INC DE
  DEC C
  JP NZ,COMP_MEM
  RET

; Clear (wipe) function key definition table
;
; Used by the routine at __MENU.
CLRFLK:
  LD HL,$5B3E

; Set new function key table, HL=address of fn table. Up to 16 chars for each
; of the 8 FN keys.
;
; Used by the routines at STDSPF, TELCOM, TEL_TERM, SCHEDL_DE, IS_CRLF, TEXT,
; WAIT_SPC and BOOT.
STFNK:
  LD DE,FNKSTR
  LD B,$08
STFNK_0:
  LD C,$10
STFNK_1:
  LD A,(HL)
  INC HL
  OR A
  PUSH AF
  AND $7F
  LD (DE),A
  POP AF
  JP M,STFNK_2
  INC DE
  DEC C
  JP NZ,STFNK_1
STFNK_2:
  SUB A
STFNK_3:
  INC DE
  DEC C
  LD (DE),A
  JP NZ,STFNK_3
  DEC B
  JP NZ,STFNK_0

; Display function keys on 8th line if enabled
;
; Used by the routines at OUTS_B_CHARS, CHGDSP, UPLDR, DWNLDR and BASIC.
FNKSB:
  LD A,(LABEL_LN)
  OR A
  CALL NZ,DSPFNK
  RET

; Routine at 23206
;
; Used by the routine at TEL_FIND.
FNDFLO:
  LD DE,$5CCE

; Search for file in directory, DE point to filename to find, zero terminated.
; HL=TOP addr, Z if not found.
;
; Used by the routine at SCHEDL_DE.
CHKDOC:
  LD A,$08

; Routine at 23211
CHKF:
  LD HL,$FDD9
  CALL MOVE_MEM
; This entry point is used by the routine at __MENU.
CHKF_0:
  LD B,$1B
  LD DE,DIRECTORY
; This entry point is used by the routine at INRC.
CHKF_1:
  LD HL,$FDF0
  LD A,(DE)
  INC A
  RET Z
  AND $80
  JP Z,INRC_1
  PUSH DE
  INC DE
  INC DE
  INC DE
  PUSH HL
  CALL DOTTED_FNAME
  POP HL
  LD C,$09
  LD DE,$FDD9
  CALL COMP_MEM
  JP NZ,INRC_0
  POP HL

; Routine at 23254
INRC:
  INC C
  RET
; This entry point is used by the routine at CHKF.
INRC_0:
  POP DE
; This entry point is used by the routine at CHKF.
INRC_1:
  LD HL,$000B
  ADD HL,DE
  EX DE,HL
  DEC B
  JP NZ,CHKF_1
  RET

; Get TOP addr of a file, HL=address of directory entry for file, exit: HL=TOP
; addr.
;
; Used by the routines at TEL_FIND, __MENU and SCHEDL_DE.
GTXTTB:
  INC HL
; This entry point is used by the routine at __MENU.
GTXTTB_0:
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  RET
  LD C,D
  LD H,C
  LD L,(HL)
  LD B,(HL)
  LD H,L
  LD H,D
  LD C,L
  LD H,C
  LD (HL),D
  LD B,C
  LD (HL),B
; This entry point is used by the routine at FNKTAB.
GTXTTB_1:
  LD (HL),D
  LD C,L
  LD H,C
  LD A,C
  LD C,D
  LD (HL),L
; This entry point is used by the routine at FNKTAB.
GTXTTB_2:
  LD L,(HL)
  LD C,D
  LD L,H
  LD A,C
  LD B,C
  LD (HL),L
  LD H,A
  LD D,E
  LD H,L
  LD (HL),B
  LD C,A
  LD H,E
  LD (HL),H
  LD C,(HL)
  LD L,A
  HALT
  LD B,H
  LD H,L
  LD H,E
  JR Z,FNKTAB_1
  ADD HL,HL
  LD C,L
  LD L,C
  LD H,E
  LD (HL),D
  LD L,A
  LD (HL),E
  LD L,A
  LD H,(HL)
  LD (HL),H
  NOP
  DEC L
  LD L,$2D
  NOP
  OR B
  RET P
  RET NZ
  ADD A,B
  AND B
  NOP
  LD D,E
  LD H,L
  LD L,H
  LD H,L
  LD H,E
  LD (HL),H
  LD A,($5F20)
  JR NZ,FNKTAB_0
  JR NZ,$5B51
  JR NZ,FNKTAB_2
  JR NZ,FNKTAB_3
  JR NZ,GTXTTB_3
GTXTTB_3:
  JR NZ,GTXTTB_4
  EX AF,AF'
  LD E,A
  EX AF,AF'
  NOP
  NOP
  ADD A,B
  ADD A,B
  ADD A,B
GTXTTB_4:
  ADD A,B
  ADD A,B
  ADD A,B
  ADD A,B
  ADD A,B

; ROM copy of the function key table
FNKTAB:
  LD B,(HL)
  LD L,C
  LD L,H
  LD H,L
  LD (HL),E
  ADC A,L
  LD C,H
  LD L,A
  LD H,C
; This entry point is used by the routine at GTXTTB.
FNKTAB_0:
  LD H,H
  JR NZ,GTXTTB_1
; This entry point is used by the routine at GTXTTB.
FNKTAB_1:
  LD D,E
; This entry point is used by the routine at GTXTTB.
FNKTAB_2:
  LD H,C
  HALT
; This entry point is used by the routine at GTXTTB.
FNKTAB_3:
  LD H,L
  JR NZ,GTXTTB_2
  LD D,D
  LD (HL),L
  LD L,(HL)
  ADC A,L
  LD C,H
  LD L,C
  LD (HL),E
  LD (HL),H
  ADC A,L
  ADD A,B
  ADD A,B
  LD C,L
  LD H,L
  LD L,(HL)
  LD (HL),L
  ADC A,L

; Entry to ADDReSS  application
ADDRSS:
  LD DE,$5CCE

; Enter ADDReSS using the filename pointed to by DE
ADDRSS_DE:
  SUB A
  JP SCHEDL_DE_0

; Entry to SCHEDuLe  application
SCHEDL:
  LD DE,$5D02

; Enter SCHEDuLe using the filename pointed to by DE
SCHEDL_DE:
  LD A,$FF
; This entry point is used by the routine at ADDRSS_DE.
SCHEDL_DE_0:
  LD ($FDED),A
  CALL L5D40_1
  PUSH DE
  CALL CHKDOC
  CALL GTXTTB
  JP NZ,SCHEDL_DE_1
  POP HL
  LD ($FDEE),HL
  LD HL,$5B88
  LD (ERRTRP),HL
  CALL __CLS
  CALL __BEEP
  LD HL,($FDEE)
  CALL PRINT_TEXT
  LD HL,$5CD6
  CALL PRINT_TEXT
  LD HL,$0003
  CALL __EDIT_7
  JP __MENU

SCHEDL_DE_1:
  LD ($FDD7),HL
  CALL __CLS
  LD HL,$5D0A
  CALL STDSPF
  LD HL,$5BE2
  LD (ERRTRP),HL
; This entry point is used by the routine at SCL_LFND.
SCHEDL_DE_2:
  CALL RESTAK
  SUB A
  LD (PRTFLG),A
  LD HL,$5CE1
  LD A,($FDED)
  OR A
  JP Z,SCHEDL_DE_3
  LD HL,$5CE8
SCHEDL_DE_3:
  CALL PRINT_TEXT
  CALL INLIN
  INC HL
  LD A,(HL)
  OR A
  JP Z,SCHEDL_DE_2
  LD DE,SCH_JPTAB
  CALL LOAD_BA_LBL_1
  RET NZ
  SUB A
  LD (PRTFLG),A
  CALL CONSOLE_CRLF
  CALL __BEEP
  LD HL,$5D0A
  CALL STFNK
  JP SCHEDL_DE_2

; FIND instruction for ADDRSS/SCHEDL
SCH_FIND:
  SUB A
  LD BC,$FF3E

; LFND instruction for ADDRSS/SCHEDL
SCL_LFND:
  LD A,$FF
  CALL SHOW_TIME_3
SCL_LFND_0:
  CALL FIND_TEXT
  JP NC,SCHEDL_DE_2
  PUSH HL
  PUSH DE
  CALL SHOW_TIME_5
SCL_LFND_1:
  CALL $67DF
  LD A,($FDEE)
  LD (PRTFLG),A
  CALL TXT_CTL_V_41
  SUB A
  LD (PRTFLG),A
  LD A,($FDEE)
  OR A
  JP NZ,SCL_LFND_2
  CALL SHOW_TIME_8
  JP Z,SCHEDL_DE_2
SCL_LFND_2:
  DEC DE
  LD A,(DE)
  INC DE
  CP $0A
  JP Z,SCL_LFND_3
  PUSH DE
  INC DE
  LD A,E
  OR D
  POP DE
  JP NZ,SCL_LFND_1
  JP SCHEDL_DE_2
SCL_LFND_3:
  POP DE
  CALL NEXT_CRLF
  POP HL
  JP SCL_LFND_0

; Find the text specified in (HL) in (DE), null terminated
;
; Used by the routines at TEL_FIND, SCL_LFND and TXT_CTL_N.
FIND_TEXT:
  PUSH DE
FIND_TEXT_0:
  PUSH HL
  PUSH DE
FIND_TEXT_1:
  LD A,(DE)
  CALL UCASE
  LD C,A
  CALL UCASE_HL
  CP C
  JP NZ,FIND_TEXT_2
  INC DE
  INC HL
  JP FIND_TEXT_1
FIND_TEXT_2:
  CP $00
  LD A,C
  POP BC
  POP HL
  JP Z,FIND_TEXT_3
  CP $1A
  JP Z,IS_CRLF_2
  CALL IS_CRLF
  JP NZ,FIND_TEXT_0
  POP AF
  JP FIND_TEXT
FIND_TEXT_3:
  POP DE
  SCF
  RET

; Incremented DE past the next CRLF in the text file
;
; Used by the routines at TEL_FIND and SCL_LFND.
NEXT_CRLF:
  CALL IS_CRLF
  JP NZ,NEXT_CRLF
  RET

; Check the next byte(s) in the buffer pointed to by DE for a CRLF
;
; Used by the routines at TEL_FIND, TEL_LOGON, FIND_TEXT and NEXT_CRLF.
IS_CRLF:
  LD A,(DE)
  CP $0D
  INC DE
  RET NZ
  LD A,(DE)
  CP $0A
  RET NZ
  INC DE
  RET
; This entry point is used by the routine at TEL_FIND.
IS_CRLF_0:
  PUSH DE
  LD HL,FNDTBL
  CALL STFNK
  CALL IS_CRLF_5
  PUSH AF
  LD HL,$51A4
IS_CRLF_1:
  CALL STFNK
  CALL SHOW_TIME_4
  POP AF
  CP $51
; This entry point is used by the routine at FIND_TEXT.
IS_CRLF_2:
  POP DE
  RET
; This entry point is used by the routine at SHOW_TIME.
IS_CRLF_3:
  PUSH DE
  LD HL,$5D1E
  CALL STFNK
IS_CRLF_4:
  CALL IS_CRLF_5
  CP $43
  JP Z,IS_CRLF_4
  PUSH AF
  LD HL,$5D0A
  JP IS_CRLF_1
IS_CRLF_5:
  CALL CHGET
  PUSH AF
  SUB A
  LD ($F62D),A
  POP AF
  CALL UCASE
  CP $51
  RET Z
  CP $20
  RET Z
  CP $4D
  RET Z
  CP $43
  RET Z
  CP $0D
  JP NZ,IS_CRLF_5
  ADD A,$36
  RET
  LD B,C
  LD B,H
  LD D,D
  LD D,E
  LD L,$44
  LD C,A
  NOP
  JR NZ,L5D40_0
  LD L,A
  LD (HL),H
  JR NZ,$5D42
  LD L,A
  LD (HL),L
  LD L,(HL)
  LD H,H
  NOP
  LD B,C
  LD H,H
  LD (HL),D
  LD (HL),E
  LD A,(OUTC)
  LD D,E
  LD H,E
  LD L,B
  LD H,H
  LD A,(OUTC)

; SCH_JPTAB
;
; Start of ADDRSS/SCHEDL instruction vector table. Each entry starts with a 4
; byte instruction name followed by routine location.
SCH_JPTAB:
  DEFW $4946
  DEFW $444E
  DEFW SCH_FIND
  DEFW $464C
  DEFW $444E
  DEFW SCL_LFND
  DEFW $454D
  DEFW $554E
  DEFW __MENU
  DEFW $FF57
  DEFW $4F4E
  DEFW $4554
  DEFW $442E
  DEFW $004F
  DEFW $6946
  DEFW $646E
  DEFW $80A0
  DEFW $8080
  DEFW $664C
  DEFW $646E
  DEFW $80A0
  DEFW $4D80
  DEFW _SD232C_3
  DEFW $8D75
  DEFW $8080
  DEFW $6F4D
  DEFW $E572
  DEFW L7551
  DEFW $F469
  DEFW $8080
  DEFW $8080

; FNDTBL
FNDTBL:
  DEFW $4380
  DEFW $6C61
  DEFW $A06C
  DEFW $6F4D
  DEFW $E572
  DEFW L7551
  DEFW $F469
  DEFW $8080
  DEFW $8080

; Routine at 23869
L5D3D:
  JP __MENU

; Routine at 23872
L5D40:
  LD DE,CHRGTB
  ADD HL,DE
  DEC C
  RET
; This entry point is used by the routines at IS_CRLF and SHOW_TIME.
L5D40_0:
  LD A,(HL)
  INC HL
  CP $20
  RET Z
  DEC HL
  RET
; This entry point is used by the routines at __MENU and SCHEDL_DE.
L5D40_1:
  LD HL,$5B3C
  LD ($F88A),HL

; Routine at 23891
;
; Used by the routines at TELCOM_RDY, TEXT, WAIT_SPC and BOOT.
STKINI:
  LD HL,$FFFF
  LD (CURLIN),HL
  INC HL
  LD (CAPTUR),HL

; Routine at 23901
;
; Used by the routines at TEL_TERM and SCHEDL_DE.
RESTAK:
  POP BC
  LD HL,($FB9D)
  LD SP,HL
  PUSH BC
  RET

; Wait for character from keyboard and convert it to uppercase if nescessary.
;
; Used by the routine at __MENU.
CHGET_UCASE:
  CALL CHGET
  JP UCASE

; Home Cursor
;
; Used by the routine at PRINT_TDATE.
CURS_HOME:
  LD HL,$0101
  JP POSIT

; Print time on top line of screen until a key is pressed.  When a key is
; pressed, the cursor position is restored.
;
; Used by the routine at __MENU.
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
; This entry point is used by the routine at __MENU.
SHOW_TIME_0:
  LD (HL),C
  INC HL
  PUSH HL
  LD HL,$FDED
  INC (HL)
  LD A,C
  RST OUTC
  LD HL,$5B3A
  CALL PRINT_TEXT
  POP HL
  RET
SHOW_TIME_1:
  LD A,($FDED)
  OR A
  RET
; This entry point is used by the routine at __MENU.
SHOW_TIME_2:
  CALL SHOW_TIME_1
  RET Z
  DEC A
  LD ($FDED),A
  DEC HL
  PUSH HL
  LD HL,GTXTTB_3
  CALL PRINT_TEXT
  POP HL
  INC A
  RET
; This entry point is used by the routines at TEL_FIND and SCL_LFND.
SHOW_TIME_3:
  LD ($FDEE),A
  CALL L5D40_0
  EX DE,HL
  LD HL,($FDD7)
  EX DE,HL
; This entry point is used by the routine at IS_CRLF.
SHOW_TIME_4:
  LD A,(ACTV_X)
  DEC A
  DEC A
  LD ($FDEF),A
  RET
; This entry point is used by the routines at TEL_FIND and SCL_LFND.
SHOW_TIME_5:
  LD HL,ACTV_Y
  LD A,$FF
  LD ($F921),A
  LD ($F920),A
  LD A,($FDEE)
  OR A
  JP Z,SHOW_TIME_7
  LD A,$01
; This entry point is used by the routine at TEXT.
SHOW_TIME_6:
  LD ($F920),A
  LD HL,$F649
SHOW_TIME_7:
  LD A,(HL)
  LD ($F922),A
  RET
; This entry point is used by the routine at SCL_LFND.
SHOW_TIME_8:
  LD HL,$FDEF
  DEC (HL)
  CALL Z,IS_CRLF_3
  CP $51
  RET

; Routine at 24046
TEXT:
  LD HL,$5DFB
  LD (ERRTRP),HL
  LD HL,TEXT_FNBAR
  CALL STFNK
  XOR A
  CALL NZ,__BEEP
  CALL STKINI
  LD HL,EDFILE_MSG
  CALL PRS
  CALL QINLIN
  RST CHRGTB
  AND A
  JP Z,__MENU
  CALL OPENDO
  JP WAIT_SPC_1
  
EDFILE_MSG:
  DEFM "File to edit"
  DEFB $00

; table at $5E22
TEXT_FNBAR:
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $83
  DEFM "Find"
  DEFB $8E
  DEFM "Load"
  DEFB $96
  DEFM "Save"
  DEFB $87
  DEFB $80
  DEFM "Copy"
  DEFB $8F
  DEFM "Cut "
  DEFB $95
  DEFM "Sel "
  DEFB $8C
  DEFM "Menu"
  DEFB $1B
  DEFB $9B
  DEFB $19
  DEFB $00

; Routine at 24145
__EDIT:
  PUSH HL
  PUSH AF
  LD A,$01
  JP Z,__EDIT_0
  LD A,$FF
__EDIT_0:
  LD ($F651),A
  XOR A
  LD ($FC95),A
  LD HL,$2020
  LD ($FC99),HL
  LD HL,$5EDA
  LD (ERRTRP),HL
  LD DE,$F802
  LD HL,BLANK_BYTE
  CALL _OPEN
  LD HL,$5ED5
  LD (ERRTRP),HL
  POP AF
  POP HL
  PUSH HL
  JP __LIST

; This entry point is used by the routine at __LIST.
__EDIT_1:
  CALL L4F2E_1
  CALL __NEW_2
  LD A,(LABEL_LN)
  LD ($FACC),A
  LD HL,L0000
  LD ($F6E7),HL		; SAVE_CSRX
__EDIT_2:
  CALL RESFPT
  CALL CLR_ALLINT
  LD HL,($F9B0)
  LD A,(HL)
  CP $1A
  JP Z,__EDIT_4
  PUSH HL
  XOR A
  LD HL,$5EAB
  JP WAIT_SPC_2
  
  XOR A
  LD HL,$5EEB
  LD (ERRTRP),HL
  LD HL,BLANK_BYTE
  LD D,$F8
  JP __MERGE_1
; This entry point is used by the routine at INXD.
__EDIT_3:
  CALL __CLS
__EDIT_4:
  XOR A
  LD ($F651),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL KILLASC_4
  CALL SETMAX_1
  LD A,($FACC)
  LD (LABEL_LN),A
  JP BASIC_0
  PUSH DE
  CALL KILLASC_4
  POP DE
  PUSH DE
  XOR A
  LD ($F651),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL L4F2E_1
  POP DE
  JP ERROR
  LD A,E
  PUSH AF
  LD HL,($FC87)
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
  JP C,__EDIT_5
  LD L,A
  LD H,A
__EDIT_5:
  LD ($F6E7),HL		; SAVE_CSRX
  CALL L4F2E_1
  POP AF
  CP $07
  LD HL,ERR_MEMORY
  JP Z,__EDIT_6
  LD HL,ILLTXT_MSG
__EDIT_6:
  CALL __CLS
  CALL PRS
  LD HL,TEXT_TXT
  CALL __EDIT_7
  JP __EDIT_2

; This entry point is used by the routine at SCHEDL_DE.
__EDIT_7:
  PUSH HL
  LD HL,PRESS_SPC_MSG
  CALL PRS
  POP HL
  CALL PRS

; Wait for a space to be entered on keyboard
WAIT_SPC:
  CALL CHGET
  CP $20
  JP NZ,WAIT_SPC
  RET

ILLTXT_MSG:
  DEFM "Text ill-formed"
  DEFB $07
  
; $5F48
BLANK_BYTE:
  DEFB $00

; $5F49
PRESS_SPC_MSG:
  DEFB $0D
  DEFB $0A
  DEFM "Press space bar for "
  DEFB $00

; at $5F60
TEXT_TXT:
  DEFM "TEXT"
  DEFB $00

; This entry point is used by the routines at __MENU and TEXT.
WAIT_SPC_1:
  PUSH HL
  LD HL,L0000
  LD ($F6E7),HL		; SAVE_CSRX
  LD A,$01
  LD HL,__MENU
; This entry point is used by the routine at __EDIT.
WAIT_SPC_2:
  LD ($F921),A
  LD ($F765),HL
  CALL EXTREV
  CALL ERAFNK
  CALL LOCK
  CALL CURSOFF
  CALL TXT_CTL_N_7
  LD HL,$5E2A
  CALL STFNK
  LD A,($F651)
  AND A
  JP Z,WAIT_SPC_3
  LD HL,$7845
  LD ($F7F9),HL
  LD HL,$7469
  LD ($F7FB),HL
WAIT_SPC_3:
  LD HL,$5E4F
  LD ($F88A),HL
  LD A,(ACTV_Y)
  LD ($F922),A
  LD A,$80
  LD ($F650),A
  XOR A
  LD L,A
  LD H,A
  LD ($F6DF),A
  LD ($F920),A
  LD ($F6E1),A
  LD ($F71F),A
  LD ($F6E2),HL
WAIT_SPC_4:
  POP HL
  LD ($F767),HL
  PUSH HL
  CALL TXT_CTL_V_64
  CALL TXT_CTL_C_15
  POP DE
  LD HL,($F6E7)		; SAVE_CSRX
  ADD HL,DE
  CALL MCLEAR_6
  PUSH HL
  CALL TXT_CTL_V_29
  POP HL
  CALL TXT_CTL_C_9
; This entry point is used by the routines at TXT_CTL_Y, TXT_CTL_V and BOOT.
WAIT_SPC_5:
  CALL STKINI
  LD HL,WAIT_SPC_5
  LD (ERRTRP),HL
  PUSH HL
  LD A,($F6DF)
  LD ($F6E0),A
  CALL MCLEAR_8
  LD ($F6DF),A
  PUSH AF
  CALL MOVE_TEXT_1
  POP AF
  JP C,TXT_CTL_U_11
  CP $7F
  JP Z,TXT_CTL_H_0
  CP $20
  JP NC,TXT_CTL_I
  LD C,A
  LD B,$00
  LD HL,$6016
  ADD HL,BC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  PUSH HL
  LD HL,(CSRX)
TXT_NUL:
  RET
  
  DEC D
  LD H,B

; Start of TEXT control character vector table (WORD ptr list starting with
; ^A).
CTL_JPTAB:
  DEFW TXT_CTL_A
  DEFW TXT_CTL_B
  DEFW TXT_CTL_C
  DEFW TXT_CTL_D
  DEFW TXT_CTL_E
  DEFW TXT_CTL_F
  DEFW TXT_CTL_G
  DEFW TXT_CTL_H
  DEFW TXT_CTL_I
  DEFW TXT_NUL
  DEFW TXT_NUL
  DEFW TXT_CTL_L
  DEFW TXT_CTL_M
  DEFW TXT_CTL_N
  DEFW TXT_CTL_O
  DEFW TXT_CTL_P
  DEFW TXT_CTL_Q
  DEFW TXT_CTL_R
  DEFW TXT_CTL_S
  DEFW TXT_CTL_T
  DEFW TXT_CTL_U
  DEFW TXT_CTL_V
  DEFW TXT_CTL_W
  DEFW TXT_CTL_X
  DEFW TXT_CTL_Y
  DEFW TXT_CTL_Z
  DEFW TXT_ESC
  DEFW TXT_CTL_D
  DEFW TXT_CTL_S
  DEFW TXT_CTL_E
  DEFW TXT_CTL_X

; TEXT ESCape routine
TXT_ESC:
  LD A,($F6E0)
  SUB $1B
  RET NZ
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  RST $38
  JR C,$6031
  CP C
  LD H,L
  CALL UNLOCK
  CALL ERAFNK
  CALL MCLEAR_7
  CALL POSIT
  CALL OUTDO_CRLF
  CALL MCLEAR_2
  LD HL,($F765)
  JP (HL)

; TEXT control P routine
TXT_CTL_P:
  CALL MCLEAR_8
  JP C,TXT_CTL_U_11
  AND A
  RET Z
  CP $1A
  RET Z
  CP $7F
  RET Z

; TEXT control I routine
;
; Used by the routine at WAIT_SPC.
TXT_CTL_I:
  PUSH AF
  CALL TXT_CTL_C
  CALL TXT_CTL_V_54
  CALL TXT_CTL_V_61
  POP AF
; This entry point is used by the routine at TXT_CTL_M.
TXT_CTL_I_0:
  CALL MCLEAR_4
  JP C,TXT_CTL_I_1
  PUSH HL
  CALL TXT_CTL_L_0
  POP HL
  JP TXT_CTL_H_3
; This entry point is used by the routines at TXT_CTL_M, TXT_CTL_O, TXT_CTL_U
; and TXT_CTL_V.
TXT_CTL_I_1:
  CALL TXT_CTL_N_3
  PUSH HL
  LD HL,ERR_MEMORY
  CALL TXT_CTL_N_5
; This entry point is used by the routines at TXT_CTL_C, TXT_CTL_N and
; MOVE_TEXT.
TXT_CTL_I_2:
  POP HL
  JP POSIT

; 'Memory Full'
ERR_MEMORY:
  LD C,L
  LD H,L
  LD L,L
  LD L,A
  LD (HL),D
  LD A,C
  JR NZ,TXT_CTL_H_1
  LD (HL),L
  LD L,H
  LD L,H
  RLCA
  NOP

; TEXT control M routine
TXT_CTL_M:
  CALL TXT_CTL_C
  CALL TXT_CTL_V_54
  LD HL,($FB62)
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  JP NZ,TXT_CTL_I_1
  CALL TXT_CTL_L_0
  CALL TXT_CTL_V_61
  LD A,$0D
  CALL MCLEAR_4
  LD A,$0A
  JP TXT_CTL_I_0

; TEXT right arrow and control D routine
TXT_CTL_D:
  CALL TXT_CTL_X_0
  SCF

; TEXT down arrow and control X routine
TXT_CTL_X:
  CALL NC,TXT_CTL_X_1
  JP TXT_CTL_C_0
; This entry point is used by the routine at TXT_CTL_D.
TXT_CTL_X_0:
  LD HL,(CSRX)
  LD A,(ACTV_Y)
  INC H
  CP H
  JP NC,TXT_CTL_E_2
  LD H,$01
TXT_CTL_X_1:
  INC L
  LD A,L
  PUSH HL
  CALL TXT_CTL_V_48
  LD A,E
  AND D
  INC A
  POP HL
  SCF
  RET Z
  CALL MCLEAR_6
  CP L
  CALL C,TXT_CTL_C_10
  JP TXT_CTL_E_2

; TEXT control H routine
TXT_CTL_H:
  CALL TXT_CTL_C
  CALL TXT_CTL_V_61
  CALL TXT_CTL_C_9
  CALL TXT_CTL_E_0
  RET C
; This entry point is used by the routine at WAIT_SPC.
TXT_CTL_H_0:
  CALL TXT_CTL_C
  CALL TXT_CTL_V_61
  PUSH HL
; This entry point is used by the routine at ERR_MEMORY.
TXT_CTL_H_1:
  CALL TXT_CTL_C_9
  POP HL
  LD A,(HL)
  CP $1A
  RET Z
  PUSH AF
  PUSH HL
  PUSH HL
  CALL TXT_CTL_V_54
  POP HL
TXT_CTL_H_2:
  CALL MCLEAR_5
  CALL $6256
  POP HL
  POP AF
  CP $0D
  JP NZ,TXT_CTL_H_3
  LD A,(HL)
  CP $0A
  JP NZ,TXT_CTL_H_3
  PUSH AF
  PUSH HL
  JP TXT_CTL_H_2
; This entry point is used by the routine at TXT_CTL_I.
TXT_CTL_H_3:
  PUSH HL
  LD A,(CSRX)
  CALL TXT_CTL_V_31
  POP HL
  JP TXT_CTL_C_7

; TEXT left arrow and control S routine
TXT_CTL_S:
  CALL TXT_CTL_E_0
  SCF

; TEXT up arrow and control E routine
TXT_CTL_E:
  CALL NC,TXT_CTL_E_1
  JP TXT_CTL_C_0
; This entry point is used by the routines at TXT_CTL_H and TXT_CTL_S.
TXT_CTL_E_0:
  LD HL,(CSRX)
  DEC H
  JP NZ,TXT_CTL_E_2
  LD A,(ACTV_Y)
  LD H,A
TXT_CTL_E_1:
  PUSH HL
  CALL TXT_CTL_V_47
  LD HL,($F767)
  RST CPDEHL
  POP HL
  CCF
  RET C
  DEC L
  CALL Z,TXT_CTL_C_12
; This entry point is used by the routine at TXT_CTL_X.
TXT_CTL_E_2:
  CALL POSIT
  AND A
  RET

; TEXT control F routine
TXT_CTL_F:
  CALL TXT_CTL_V_61
TXT_CTL_F_0:
  CALL TXT_CTL_A_3
  JP NZ,TXT_CTL_F_0
TXT_CTL_F_1:
  CALL TXT_CTL_A_3
  JP Z,TXT_CTL_F_1
  JP TXT_CTL_A_2

; TEXT control A routine
TXT_CTL_A:
  CALL TXT_CTL_V_61
TXT_CTL_A_0:
  CALL TXT_CTL_A_4
  JP Z,TXT_CTL_A_0
TXT_CTL_A_1:
  CALL TXT_CTL_A_4
  JP NZ,TXT_CTL_A_1
  CALL TXT_CTL_A_3
; This entry point is used by the routine at TXT_CTL_F.
TXT_CTL_A_2:
  CALL TXT_CTL_C_7
  JP TXT_CTL_C_0
; This entry point is used by the routine at TXT_CTL_F.
TXT_CTL_A_3:
  LD A,(HL)
  CP $1A
  POP BC
  JP Z,TXT_CTL_A_2
  INC HL
  JP TXT_CTL_A_5
TXT_CTL_A_4:
  EX DE,HL
  LD HL,($F767)
  EX DE,HL
  RST CPDEHL
  POP BC
  JP Z,TXT_CTL_A_2
  DEC HL
TXT_CTL_A_5:
  PUSH BC
  PUSH HL
  LD A,(HL)
  CALL TXT_CTL_V_27
  POP HL
  RET

; TEXT control T routine
TXT_CTL_T:
  DEC L
  LD L,$01
  JP NZ,TXT_CTL_T_0
  PUSH HL
  CALL TXT_CTL_V_47
  EX DE,HL
  CALL TXT_CTL_Z_1
  POP HL
; This entry point is used by the routines at TXT_CTL_B and TXT_CTL_Q.
TXT_CTL_T_0:
  CALL POSIT
  JP TXT_CTL_C_0

; TEXT control B routine
TXT_CTL_B:
  PUSH HL
  INC L
  CALL MCLEAR_6
  INC A
  CP L
  JP NZ,TXT_CTL_B_0
  PUSH AF
  CALL TXT_CTL_V_47
  EX DE,HL
  LD A,$01
  CALL TXT_CTL_Z_2
  POP AF
TXT_CTL_B_0:
  DEC A
  CALL TXT_CTL_V_48
  LD B,A
  INC DE
  LD A,D
  OR E
  LD A,B
  JP Z,TXT_CTL_B_0
  POP HL
  LD L,A
  JP TXT_CTL_T_0

; TEXT control R routine
TXT_CTL_R:
  LD A,(ACTV_Y)
  LD H,A
  CALL POSIT
  CALL TXT_CTL_V_61
  CALL TXT_CTL_V_55
  LD BC,$0126

; TEXT control Q routine
TXT_CTL_Q:
  LD H,$01
  JP TXT_CTL_T_0

; TEXT control W routine
TXT_CTL_W:
  LD HL,($F767)
  CALL TXT_CTL_Z_3
  CALL HOME
  JP TXT_CTL_C_0

; TEXT control Z routine
TXT_CTL_Z:
  LD HL,($FB62)
  PUSH HL
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  PUSH HL
  CALL NC,TXT_CTL_Z_1
; This entry point is used by the routine at TXT_CTL_N.
TXT_CTL_Z_0:
  POP HL
  CALL TXT_CTL_C_9
  JP TXT_CTL_C_0
; This entry point is used by the routine at TXT_CTL_T.
TXT_CTL_Z_1:
  CALL MCLEAR_6
; This entry point is used by the routine at TXT_CTL_B.
TXT_CTL_Z_2:
  CALL GETEND_1
; This entry point is used by the routine at TXT_CTL_W.
TXT_CTL_Z_3:
  CALL CHRGTB_0
  RET Z
  LD ($F6EB),HL
  LD A,$01
  JP TXT_CTL_V_34

; TEXT control L routine
TXT_CTL_L:
  CALL TXT_CTL_C
  CALL TXT_CTL_V_61
  LD ($F6E2),HL
  LD ($F6E4),HL
  LD E,L
  LD D,H
  JP TXT_CTL_C_2
; This entry point is used by the routines at TXT_CTL_I and TXT_CTL_M.
TXT_CTL_L_0:
  LD C,$00
  LD HL,$800E
  CALL MCLEAR_6
  LD HL,CSRX
  SUB (HL)
  LD B,A
  CALL TXT_CTL_V_47
  INC HL
TXT_CTL_L_1:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC DE
  LD A,D
  OR E
  RET Z
  DEC C
  JP M,TXT_CTL_L_2
  DEC DE
  DEC DE
TXT_CTL_L_2:
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  DEC B
  JP P,TXT_CTL_L_1
  RET
; This entry point is used by the routines at TXT_CTL_C and TXT_CTL_N.
TXT_CTL_L_3:
  CALL HOME
  CALL DELLIN
  CALL MCLEAR_6
; This entry point is used by the routine at MCLEAR.
TXT_CTL_L_4:
  ADD A,A
  LD B,A
  LD DE,$F6EB
  LD HL,$F6ED
  JP LDIR_B

; TEXT control C routine
;
; Used by the routines at TXT_CTL_I, TXT_CTL_M, TXT_CTL_H, TXT_CTL_L,
; TXT_CTL_O, TXT_CTL_U and TXT_CTL_N.
TXT_CTL_C:
  CALL TXT_CTL_C_6
  PUSH HL
  LD HL,L0000
  LD ($F6E2),HL
  CALL TXT_CTL_V_61
  POP DE
  JP TXT_CTL_C_1
; This entry point is used by the routines at TXT_CTL_X, TXT_CTL_E, TXT_CTL_A,
; TXT_CTL_T, TXT_CTL_W and TXT_CTL_Z.
TXT_CTL_C_0:
  CALL TXT_CTL_C_6
  CALL TXT_CTL_V_61
  EX DE,HL
  LD HL,($F6E4)
  RST CPDEHL
  RET Z
  EX DE,HL
  LD ($F6E4),HL
TXT_CTL_C_1:
  CALL TXT_CTL_U_5
; This entry point is used by the routine at TXT_CTL_L.
TXT_CTL_C_2:
  PUSH HL
  PUSH DE
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  JP C,TXT_CTL_C_3
  CALL MCLEAR_7
TXT_CTL_C_3:
  CALL C,TXT_CTL_V_55
  LD H,L
  EX (SP),HL
  CALL CHRGTB_0
  JP NC,TXT_CTL_C_4
  LD L,$01
TXT_CTL_C_4:
  CALL NC,TXT_CTL_V_55
  POP AF
  SUB L
  LD C,A
  EX DE,HL
  LD HL,(CSRX)
  EX DE,HL
  PUSH DE
  LD H,$01
  CALL POSIT
  CALL TXT_CTL_V_47
  LD A,C
TXT_CTL_C_5:
  PUSH AF
  CALL TXT_CTL_V_40
  POP AF
  DEC A
  JP P,TXT_CTL_C_5
  JP TXT_CTL_I_2
; This entry point is used by the routines at TXT_CTL_O, TXT_CTL_U and
; TXT_CTL_V.
TXT_CTL_C_6:
  LD HL,($F6E2)
  LD A,H
  OR L
  RET NZ
  POP HL
  RET
; This entry point is used by the routines at TXT_CTL_H and TXT_CTL_A.
TXT_CTL_C_7:
  CALL CHRGTB_0
  CALL C,TXT_CTL_C_13
  JP C,TXT_CTL_C_7
TXT_CTL_C_8:
  PUSH HL
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  CALL NC,TXT_CTL_C_11
  JP NC,TXT_CTL_C_8
; This entry point is used by the routines at WAIT_SPC, TXT_CTL_H, TXT_CTL_Z,
; TXT_CTL_U and TXT_CTL_V.
TXT_CTL_C_9:
  CALL TXT_CTL_V_55
  JP POSIT
; This entry point is used by the routine at TXT_CTL_X.
TXT_CTL_C_10:
  DEC L
TXT_CTL_C_11:
  PUSH AF
  PUSH HL
  CALL TXT_CTL_L_3
  CALL MCLEAR_6
  JP TXT_CTL_C_14
; This entry point is used by the routine at TXT_CTL_E.
TXT_CTL_C_12:
  INC L
TXT_CTL_C_13:
  PUSH AF
  PUSH HL
  CALL $65DF
  CALL HOME
  CALL INSLIN
  CALL TXT_CTL_V_49
  PUSH DE
  CALL TXT_CTL_V_46
  INC HL
  LD E,L
  LD D,H
  DEC HL
  DEC HL
  DEC A
  ADD A,A
  LD C,A
  LD B,$00
  CALL _LDDR
  EX DE,HL
  POP DE
  LD (HL),D
  DEC HL
  LD (HL),E
  LD A,$01
TXT_CTL_C_14:
  CALL TXT_CTL_V_34
  POP HL
  POP AF
  RET
; This entry point is used by the routines at DWNLDR, WAIT_SPC, TXT_CTL_O and
; TXT_CTL_U.
TXT_CTL_C_15:
  LD HL,(ARREND)
  LD BC,$00C8
  ADD HL,BC
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
  LD HL,($FB62)
  EX DE,HL
  INC DE
  CALL MAKHOL_0

; Routine at 25446
MCLEAR:
  LD (HL),$00
  INC HL
  DEC BC
  LD A,B
  OR C
  JP NZ,MCLEAR
  RET
; This entry point is used by the routines at TEL_BYE and __MENU.
MCLEAR_0:
  LD HL,(DO_FILES)
MCLEAR_1:
  CALL GETEND
  INC HL
  EX DE,HL
  LD HL,(CO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NC
  LD A,(HL)
  AND A
  JP NZ,MCLEAR_1
; This entry point is used by the routines at DWNLDR, TXT_ESC, TXT_CTL_O and
; TXT_CTL_U.
MCLEAR_2:
  LD HL,($FB62)
  PUSH HL
  LD BC,$FFFF
  XOR A
MCLEAR_3:
  INC HL
  INC BC
  CP (HL)
  JP Z,MCLEAR_3
  POP HL
  INC HL
  JP MASDEL
; This entry point is used by the routines at DWNLDR, TXT_CTL_I, TXT_CTL_M and
; TXT_CTL_V.
MCLEAR_4:
  EX DE,HL
  LD HL,($FB62)
  INC HL
  INC (HL)
  DEC (HL)
  SCF
  RET NZ
  PUSH AF
  LD ($FB62),HL
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
  CALL _LDDR
  INC HL
  POP AF
  LD (HL),A
  INC HL
  AND A
  RET
; This entry point is used by the routine at TXT_CTL_H.
MCLEAR_5:
  EX DE,HL
  LD HL,($FB62)
  LD A,L
  SUB E
  LD C,A
  LD A,H
  SBC A,D
  LD B,A
  DEC HL
  LD ($FB62),HL
  LD L,E
  LD H,D
  INC HL
  CALL _LDIR
  XOR A
  LD (DE),A
  RET
; This entry point is used by the routines at ESC_B, WAIT_SPC, TXT_CTL_X,
; TXT_CTL_B, TXT_CTL_Z, TXT_CTL_L, TXT_CTL_C, TXT_CTL_U, TXT_CTL_N, MOVE_TEXT
; and TXT_CTL_V.
MCLEAR_6:
  PUSH HL
  PUSH AF
  LD HL,LABEL_LN
  LD A,(ACTV_X)
  ADD A,(HL)
  LD L,A
  POP AF
  LD A,L
  POP HL
  RET
; This entry point is used by the routines at TXT_ESC, TXT_CTL_C, MOVE_TEXT and
; TXT_CTL_V.
MCLEAR_7:
  PUSH AF
  LD HL,(ACTV_X)
  CALL MCLEAR_6
  LD L,A
  POP AF
  RET
; This entry point is used by the routines at WAIT_SPC and TXT_CTL_P.
MCLEAR_8:
  LD HL,(CSRX)
  PUSH HL
  LD A,L
  LD (LBL_LINE),A
  LD A,(LABEL_LN)
  PUSH AF
  CALL CHGET
  POP BC
  POP HL
  PUSH AF
  XOR A
  LD (LBL_LINE),A
  LD A,(LABEL_LN)
  CP B
  JP NZ,MCLEAR_9
  POP AF
  RET
MCLEAR_9:
  AND A
  JP Z,MCLEAR_10
  LD A,(CSRX)
  CP L
  LD A,(ACTV_X)
  CALL NZ,TXT_CTL_L_4
  POP AF
  RET
MCLEAR_10:
  PUSH HL
  LD A,(ACTV_X)
  DEC A
  CALL TXT_CTL_V_48
  INC HL
  LD (HL),$FE
  INC HL
  INC HL
  LD (HL),$FE
  DEC A
  CALL TXT_CTL_V_34
  XOR A
  LD ($F6E1),A
  POP HL
  CALL POSIT
  POP AF
  RET

; TEXT control O routine
TXT_CTL_O:
  CALL TXT_CTL_C_6
  CALL MCLEAR_2
  CALL TXT_CTL_U_6
  PUSH AF
  CALL TXT_CTL_C_15
  POP AF
  JP NC,TXT_CTL_C
  JP TXT_CTL_I_1

; TEXT control U routine
TXT_CTL_U:
  CALL TXT_CTL_C_6
  CALL MCLEAR_2
  CALL TXT_CTL_U_6
  PUSH AF
  CALL NC,MASDEL
  POP AF
  JP NC,TXT_CTL_U_2
  LD A,B
  AND A
  JP Z,TXT_CTL_U_1
TXT_CTL_U_0:
  CALL _RST75_6
  PUSH BC
  LD BC,$0100
  CALL TXT_CTL_U_3
  POP BC
  DEC B
  JP NZ,TXT_CTL_U_0
TXT_CTL_U_1:
  LD A,C
  AND A
  CALL NZ,TXT_CTL_U_3
TXT_CTL_U_2:
  LD DE,L0000
  EX DE,HL
  LD ($F6E2),HL
  EX DE,HL
  PUSH HL
  LD A,(CSRX)
  CALL TXT_CTL_V_29
  POP HL
  CALL TXT_CTL_C_9
  CALL TXT_CTL_V_64
  JP TXT_CTL_C_15
TXT_CTL_U_3:
  PUSH HL
  PUSH BC
  EX DE,HL
  LD HL,($FC87)
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
  LD HL,($FC87)
  CALL _LDIR
  POP HL
  RET
TXT_CTL_U_4:
  LD HL,($F6E2)
  EX DE,HL
  LD HL,($F6E4)
; This entry point is used by the routine at TXT_CTL_C.
TXT_CTL_U_5:
  RST CPDEHL
  RET C
  EX DE,HL
  RET
; This entry point is used by the routine at TXT_CTL_O.
TXT_CTL_U_6:
  CALL SWAPNM_1
  LD HL,(HAYASHI)
  LD (PERM_END),HL
  XOR A
  LD ($F6E6),A
  CALL TXT_CTL_U_4
  DEC DE
TXT_CTL_U_7:
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  JP C,TXT_CTL_U_8
  LD A,(DE)
  CP $1A
  JP Z,TXT_CTL_U_9
  CP $0D
  JP NZ,TXT_CTL_U_8
  INC DE
  LD A,(DE)
  CP $0A
  JP NZ,TXT_CTL_U_8
  INC BC
TXT_CTL_U_8:
  INC BC
TXT_CTL_U_9:
  LD A,B
  OR C
  RET Z
  PUSH HL
  LD HL,(PERM_END)
  CALL MAKHOL
  EX DE,HL
  POP HL
  RET C
  LD A,($F6E6)
  AND A
  JP Z,TXT_CTL_U_10
  ADD HL,BC
TXT_CTL_U_10:
  PUSH HL
  PUSH BC
  CALL _LDIR
  POP BC
  POP HL
  RET
; This entry point is used by the routines at WAIT_SPC and TXT_CTL_P.
TXT_CTL_U_11:
  CALL TXT_CTL_C
  CALL MCLEAR_2
  CALL RESFPT
  CALL TXT_CTL_V_61
  LD (PERM_END),HL
  LD A,H
  LD ($F6E6),A
  LD HL,(HAYASHI)
  LD A,(HL)
  CP $1A
  JP Z,TXT_CTL_C_15
  LD E,L
  LD D,H
  DEC DE
TXT_CTL_U_12:
  INC DE
  LD A,(DE)
  CP $1A
  JP NZ,TXT_CTL_U_12
  CALL TXT_CTL_U_7
  PUSH AF
  PUSH DE
  CALL TXT_CTL_V_64
  CALL TXT_CTL_C_15
  POP DE
  POP AF
  JP C,TXT_CTL_I_1
  PUSH DE
  LD HL,(PERM_END)
  LD A,(CSRX)
  CALL TXT_CTL_V_29
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  CALL MCLEAR_6
  PUSH HL
  CALL NC,TXT_CTL_V_29
  POP HL
  JP TXT_CTL_C_9

; TEXT control N routine
TXT_CTL_N:
  CALL TXT_CTL_N_3
  CALL TXT_CTL_V_61
  PUSH HL
  LD HL,STRG_MSG
  LD DE,$F71F
  PUSH DE
  CALL MOVE_TEXT_4
  POP DE
  INC HL
  LD A,(HL)
  AND A
  SCF
  JP Z,TXT_CTL_N_0
  CALL MOVE_TEXT
  POP DE
  PUSH DE
  LD A,(DE)
  CP $1A
  JP Z,TXT_CTL_N_1
  INC DE
  CALL FIND_TEXT
  JP NC,TXT_CTL_N_1
  POP DE
  PUSH BC
  PUSH BC
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  JP C,TXT_CTL_N_0
  CALL $6981
  AND A
TXT_CTL_N_0:
  CALL C,MOVE_TEXT_2
  SCF
TXT_CTL_N_1:
  LD HL,$65CE
  CALL NC,TXT_CTL_N_5
  JP TXT_CTL_Z_0
; This entry point is used by the routines at TXT_CTL_Y and TXT_CTL_G.
TXT_CTL_N_2:
  CALL TXT_CTL_C
; This entry point is used by the routine at TXT_CTL_I.
TXT_CTL_N_3:
  LD HL,(CSRX)
  CALL MCLEAR_6
  CP L
  RET NZ
  DEC L
  PUSH HL
  CALL TXT_CTL_L_3
  JP TXT_CTL_I_2
; This entry point is used by the routines at TXT_CTL_Y and TXT_CTL_V.
TXT_CTL_N_4:
  LD HL,ABTMSG
; This entry point is used by the routine at TXT_CTL_I.
TXT_CTL_N_5:
  LD A,$01
  LD ($F6E1),A
; This entry point is used by the routine at MOVE_TEXT.
TXT_CTL_N_6:
  CALL $65DF
  CALL PRS
; This entry point is used by the routine at WAIT_SPC.
TXT_CTL_N_7:
  CALL CHSNS
  RET Z
  CALL CHGET
  JP TXT_CTL_N_7

; Move data from (HL) to (DE) until null is found.
;
; Used by the routines at TXT_CTL_N and TXT_CTL_Y.
MOVE_TEXT:
  PUSH HL
MOVE_TEXT_0:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  AND A
  JP NZ,MOVE_TEXT_0
  POP HL
  RET
  LD C,(HL)
  LD L,A
  JR NZ,$663F
  LD H,C
  LD (HL),H
  LD H,E
  LD L,B
  NOP

STRG_MSG:
  DEFM "String:"
  DEFB $00

; $65DF
  PUSH HL
  CALL MCLEAR_7
  LD H,$01
  CALL POSIT
  POP HL
  JP ERAEOL

; This entry point is used by the routine at WAIT_SPC.
MOVE_TEXT_1:
  LD HL,$F6E1
  XOR A
  CP (HL)
  RET Z
  LD (HL),A
; This entry point is used by the routines at TXT_CTL_N and TXT_CTL_Y.
MOVE_TEXT_2:
  LD HL,(CSRX)
  PUSH HL
  CALL MCLEAR_6
  CALL TXT_CTL_V_34
  JP TXT_CTL_I_2
; This entry point is used by the routine at TXT_CTL_G.
MOVE_TEXT_3:
  LD DE,BLANK_BYTE
; This entry point is used by the routines at TXT_CTL_N and TXT_CTL_Y.
MOVE_TEXT_4:
  PUSH DE
  CALL TXT_CTL_N_6
  LD A,(CSRY)
  LD ($FACA),A
  POP HL
  PUSH HL
  CALL PRS
MOVE_TEXT_5:
  CALL CHGET
  JP C,MOVE_TEXT_5
  AND A
  JP Z,MOVE_TEXT_5
  POP HL
  CP $0D
  JP Z,MOVE_TEXT_7
  PUSH AF
  CALL MCLEAR_7
  LD A,($FACA)
  LD H,A
  CALL POSIT
  CALL ERAEOL
  POP AF
  LD DE,KBUF
  LD B,$01
  AND A
  JP MOVE_TEXT_6
  CALL CHGET
MOVE_TEXT_6:
  LD HL,$663A
  PUSH HL
  RET C
  CP $7F
  JP Z,INLIN_CURS
  CP $20
  JP NC,MOVE_TEXT_9
  LD HL,$665B
  LD C,$07
  JP OUTC_SUB2_0
MOVE_TEXT_7:
  LD DE,KBUF
  CALL MOVE_TEXT
  JP MOVE_TEXT_8
  INC BC
  LD (HL),D
  LD H,(HL)
  EX AF,AF'
  AND B
  LD B,(HL)
  ADD HL,BC
  LD A,H
  LD H,(HL)
  DEC C
  LD (HL),L
  LD H,(HL)
  DEC D
  JP $1846
  
  JP LINE_GFX_14
  AND B
  LD B,(HL)
  LD DE,KBUF
  POP HL
  XOR A
  LD (DE),A
MOVE_TEXT_8:
  LD HL,$F684
  RET
  LD A,$09
MOVE_TEXT_9:
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

; TEXT control Y routine
TXT_CTL_Y:
  CALL TXT_CTL_N_2
  LD HL,TXT_CTL_Y_3
  LD (ERRTRP),HL
  PUSH HL
  LD HL,(CSRX)
  LD ($F6E7),HL		; SAVE_CSRX
  LD HL,$670C
  LD DE,$F64A
  CALL MOVE_TEXT_4
  RST CHRGTB
  XOR A
  CP (HL)
  JP Z,TXT_CTL_Y_1
  LD ($F688),A
  CALL GETINT
  CP $0A
  RET C
  CP $85
  RET NC
  POP DE
  LD ($F649),A
  LD ($F922),A
  LD (PRTFLG),A
  LD DE,$F64A
  LD HL,KBUF
  CALL MOVE_TEXT
  INC A
  LD ($F920),A
  CALL OUTDO_CRLF
  LD HL,($F767)
  EX DE,HL
TXT_CTL_Y_0:
  CALL TXT_CTL_V_40
  LD A,D
  AND E
  INC A
  JP NZ,TXT_CTL_Y_0
  CALL TXT_CTL_Y_4
; This entry point is used by the routines at TXT_CTL_G and TXT_CTL_V.
TXT_CTL_Y_1:
  CALL MOVE_TEXT_2
TXT_CTL_Y_2:
  LD HL,($F6E7)		; SAVE_CSRX
  CALL POSIT
  JP WAIT_SPC_5
; This entry point is used by the routines at TXT_CTL_G and TXT_CTL_V.
TXT_CTL_Y_3:
  CALL TXT_CTL_Y_4
  CALL L4F2E_1
  CALL TXT_CTL_N_4
  JP TXT_CTL_Y_2
TXT_CTL_Y_4:
  LD A,(ACTV_Y)
  LD ($F922),A
  XOR A
  LD (PRTFLG),A
  LD ($F920),A
  RET
  LD D,A
  LD L,C
  LD H,H
  LD (HL),H
  LD L,B
  LD A,(__INP)

; TEXT control G routine
TXT_CTL_G:
  LD DE,$6735
  CALL $673E
  JP C,TXT_CTL_Y_3
  JP Z,TXT_CTL_Y_1
  LD E,$02
  CALL _OPEN
  LD HL,($F767)
TXT_CTL_G_0:
  LD A,(HL)
  RST OUTC
  INC HL
  CP $1A
  JP NZ,TXT_CTL_G_0
  CALL L4F2E_1
  JP TXT_CTL_Y_1
  LD D,E
  LD H,C
  HALT
  LD H,L
  JR NZ,$67AF
  LD L,A
  LD A,($D500)
  CALL TXT_CTL_N_2
  LD HL,TXT_CTL_Y_3
  LD (ERRTRP),HL
  LD HL,(CSRX)
  LD ($F6E7),HL		; SAVE_CSRX
  POP HL
  CALL MOVE_TEXT_3
  RST CHRGTB
  AND A
  RET Z
  CALL COUNT_CHARS
  CALL FNAME
  JP NZ,TXT_CTL_G_1
  LD D,$FD
TXT_CTL_G_1:
  LD A,D
  CP $F8
  SCF
  RET Z
  CP $FE
  SCF
  RET Z
  CP $FF
  SCF
  RET Z
  LD HL,BLANK_BYTE
  CCF
  LD A,$00
  RET

; TEXT control V routine
TXT_CTL_V:
  LD DE,$67D4
  CALL $673E
  JP C,TXT_CTL_Y_3
  JP Z,TXT_CTL_Y_1
  PUSH HL
  LD HL,$67CB
  LD (ERRTRP),HL
  LD HL,($FB62)
  LD ($F6E7),HL		; SAVE_CSRX
  LD ($FAC6),A
  EX (SP),HL
  LD E,$01
  CALL _OPEN
  POP HL
TXT_CTL_V_0:
  CALL RDBYT
  JP C,TXT_CTL_V_2
  CALL DWNLDR_6
  JP Z,TXT_CTL_V_0
  JP NC,TXT_CTL_V_1
  CALL MCLEAR_4
  LD A,$0A
TXT_CTL_V_1:
  CALL NC,MCLEAR_4
  JP NC,TXT_CTL_V_0
  CALL L4F2E_1
  CALL TXT_CTL_I_1
TXT_CTL_V_2:
  CALL L4F2E_1
TXT_CTL_V_3:
  CALL TXT_CTL_V_64
  LD HL,($F6E7)		; SAVE_CSRX
  PUSH HL
  CALL $6981
  POP HL
  CALL TXT_CTL_C_9
  JP WAIT_SPC_5
  CALL L4F2E_1
  CALL TXT_CTL_N_4
  JP TXT_CTL_V_3
  LD C,H
  LD L,A
  LD H,C
  LD H,H
  JR NZ,$6840
  LD (HL),D
  LD L,A
  LD L,L
  LD A,($AF00)
  LD ($F890),A
  LD ($F6E6),A
  LD HL,$F894
  LD ($F892),HL
TXT_CTL_V_4:
  PUSH DE
  CALL TXT_CTL_V_21
  POP DE
  LD A,(DE)
  INC DE
  CP $1A
  JP Z,TXT_CTL_V_11
  CP $0D
  JP Z,TXT_CTL_V_12
  CP $09
  JP Z,TXT_CTL_V_5
  CP $20
  JP C,TXT_CTL_V_9
TXT_CTL_V_5:
  CALL TXT_CTL_V_13
  JP NC,TXT_CTL_V_4
  LD A,(DE)
  CALL TXT_CTL_V_26
  JP NZ,TXT_CTL_V_6
  CALL TXT_CTL_V_8
  LD A,(DE)
  CP $20
  RET NZ
  LD A,($F920)
  AND A
  RET Z
  INC DE
  LD A,(DE)
  CP $20
  RET NZ
  DEC DE
  RET
TXT_CTL_V_6:
  EX DE,HL
  LD (PERM_END),HL
  EX DE,HL
  LD HL,($F892)
  LD ($F88E),HL
  DEC DE
  LD A,(DE)
  INC DE
  CALL TXT_CTL_V_26
  JP Z,TXT_CTL_V_8
TXT_CTL_V_7:
  DEC DE
  LD A,(DE)
  INC DE
  CALL TXT_CTL_V_26
  JP Z,TXT_CTL_V_19
  DEC DE
  CALL TXT_CTL_V_17
  JP NZ,TXT_CTL_V_7
  LD HL,($F88E)
  LD ($F892),HL
  LD HL,(PERM_END)
  EX DE,HL
TXT_CTL_V_8:
  LD A,($F920)
  DEC A
  JP Z,TXT_CTL_V_20
  RET
TXT_CTL_V_9:
  PUSH AF
  LD A,$5E
  CALL TXT_CTL_V_13
  JP C,TXT_CTL_V_10
  POP AF
  OR $40
  CALL TXT_CTL_V_13
  JP NC,TXT_CTL_V_4
  LD A,($F920)
  AND A
  JP NZ,TXT_CTL_V_20
  RET
TXT_CTL_V_10:
  POP AF
  DEC DE
  LD HL,($F892)
  DEC HL
  LD ($F892),HL
  LD HL,$F890
  DEC (HL)
  JP TXT_CTL_V_19
TXT_CTL_V_11:
  LD A,($F920)
  AND A
  LD A,$9B
  CALL Z,TXT_CTL_V_13
  CALL TXT_CTL_V_19
  LD DE,$FFFF
  RET
TXT_CTL_V_12:
  LD A,(DE)
  CP $0A
  LD A,$0D
  JP NZ,TXT_CTL_V_9
  PUSH DE
  CALL TXT_CTL_V_21
  POP DE
  LD A,($F920)
  AND A
  LD A,$8F
  CALL Z,TXT_CTL_V_13
  CALL TXT_CTL_V_19
  INC DE
  RET
TXT_CTL_V_13:
  PUSH HL
  CALL TXT_CTL_V_16
  LD HL,$F890
  CP $09
  JP Z,TXT_CTL_V_14
  INC (HL)
  JP TXT_CTL_V_15
TXT_CTL_V_14:
  INC (HL)
  LD A,(HL)
  AND $07
  JP NZ,TXT_CTL_V_14
TXT_CTL_V_15:
  LD A,($F922)
  DEC A
  CP (HL)
  POP HL
  RET
TXT_CTL_V_16:
  LD HL,($F892)
  LD (HL),A
  INC HL
  LD ($F892),HL
  RET
TXT_CTL_V_17:
  LD HL,($F892)
  DEC HL
  DEC HL
  DEC HL
  LD A,(HL)
  CP $1B
  JP Z,TXT_CTL_V_18
  INC HL
  INC HL
TXT_CTL_V_18:
  LD ($F892),HL
  LD HL,$F890
  DEC (HL)
  RET
TXT_CTL_V_19:
  LD A,($F890)
  LD HL,$F922
  CP (HL)
  RET NC
  LD A,($F920)
  AND A
  JP NZ,TXT_CTL_V_20
  LD A,$1B
  CALL TXT_CTL_V_16
  LD A,$4B
  CALL TXT_CTL_V_16
TXT_CTL_V_20:
  LD A,$0D
  CALL TXT_CTL_V_16
  LD A,$0A
  JP TXT_CTL_V_16
TXT_CTL_V_21:
  CALL TXT_CTL_C_6
  LD A,($F920)
  AND A
  RET NZ
  LD BC,$F6E6
  PUSH DE
  EX DE,HL
  LD HL,($F6E4)
  EX DE,HL
  RST CPDEHL
  POP DE
  JP NC,TXT_CTL_V_23
  EX DE,HL
  RST CPDEHL
  JP C,TXT_CTL_V_24
  EX DE,HL
  LD HL,($F6E4)
  EX DE,HL
  RST CPDEHL
  JP NC,TXT_CTL_V_24
TXT_CTL_V_22:
  LD A,(BC)
  AND A
  RET NZ
  INC A
  LD H,$70
  JP TXT_CTL_V_25
TXT_CTL_V_23:
  EX DE,HL
  RST CPDEHL
  JP NC,TXT_CTL_V_24
  EX DE,HL
  LD HL,($F6E4)
  EX DE,HL
  RST CPDEHL
  JP NC,TXT_CTL_V_22
TXT_CTL_V_24:
  LD A,(BC)
  AND A
  RET Z
  XOR A
  LD H,$71
TXT_CTL_V_25:
  PUSH HL
  LD (BC),A
  LD A,$1B
  CALL TXT_CTL_V_16
  POP AF
  JP TXT_CTL_V_16
TXT_CTL_V_26:
  LD B,A
  LD A,($F921)
  AND A
  LD A,B
  RET Z
; This entry point is used by the routine at TXT_CTL_A.
TXT_CTL_V_27:
  LD HL,$6977
  LD B,$0A
TXT_CTL_V_28:
  CP (HL)
  RET Z
  INC HL
  DEC B
  JP NZ,TXT_CTL_V_28
  CP $21
  INC B
  RET NC
  DEC B
  RET
  JR Z,TXT_CTL_V_32
  INC A
  LD A,$5B
  LD E,L
  DEC HL
  DEC L
  LD HL,($CD2F)
  CALL $A763
  RRA
; This entry point is used by the routines at WAIT_SPC and TXT_CTL_U.
TXT_CTL_V_29:
  CALL GETEND_1
  LD ($F6EB),HL
  CALL MCLEAR_6
  ADD A,A
  LD HL,$F6ED
TXT_CTL_V_30:
  LD (HL),$FE
  INC HL
  DEC A
  JP NZ,TXT_CTL_V_30
  INC A
  JP TXT_CTL_V_34
; This entry point is used by the routine at TXT_CTL_H.
TXT_CTL_V_31:
  PUSH AF
  LD HL,($F6E9)
TXT_CTL_V_32:
  LD A,H
  OR L
  JP Z,TXT_CTL_V_33
  EX DE,HL
  CALL $67DF
  POP AF
  LD B,A
  CALL TXT_CTL_V_43
  LD A,B
  PUSH AF
  JP Z,TXT_CTL_V_33
  DEC A
  JP Z,TXT_CTL_V_33
  LD L,A
  LD H,$01
  CALL POSIT
  CALL TXT_CTL_V_41
  LD A,D
  AND E
  INC A
  POP BC
  JP Z,ERAEOL
  PUSH BC
TXT_CTL_V_33:
  POP AF
; This entry point is used by the routines at TXT_CTL_Z, TXT_CTL_C, MCLEAR and
; MOVE_TEXT.
TXT_CTL_V_34:
  LD L,A
  LD H,$01
  CALL POSIT
  CALL TXT_CTL_V_47
  LD A,E
  AND D
  INC A
  JP Z,TXT_CTL_V_39
  CALL TXT_CTL_V_47
TXT_CTL_V_35:
  CALL MCLEAR_7
  CP L
  JP Z,TXT_CTL_V_36
  CALL TXT_CTL_V_40
  LD A,D
  AND E
  INC A
  JP Z,TXT_CTL_V_38
  CALL TXT_CTL_V_44
  JP NZ,TXT_CTL_V_35
  RET
TXT_CTL_V_36:
  CALL TXT_CTL_V_40
TXT_CTL_V_37:
  CALL MCLEAR_6
  INC A
  JP TXT_CTL_V_43
TXT_CTL_V_38:
  CALL TXT_CTL_V_44
  JP Z,TXT_CTL_V_37
TXT_CTL_V_39:
  CALL ERAEOL
  CALL OUTDO_CRLF
  JP TXT_CTL_V_38
; This entry point is used by the routines at TXT_CTL_C and TXT_CTL_Y.
TXT_CTL_V_40:
  CALL $67DF
; This entry point is used by the routine at SCL_LFND.
TXT_CTL_V_41:
  PUSH DE
  LD HL,($F892)
  LD DE,$F894
TXT_CTL_V_42:
  LD A,(DE)
  RST OUTC
  INC DE
  RST CPDEHL
  JP NZ,TXT_CTL_V_42
  LD A,($F920)
  AND A
  CALL Z,EXTREV
  POP DE
  RET
TXT_CTL_V_43:
  PUSH DE
  CALL TXT_CTL_V_48
  JP TXT_CTL_V_45
TXT_CTL_V_44:
  PUSH DE
  CALL TXT_CTL_V_47
TXT_CTL_V_45:
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
; This entry point is used by the routines at TXT_CTL_Z, TXT_CTL_C, TXT_CTL_U
; and TXT_CTL_N.
TXT_CTL_V_46:
  CALL MCLEAR_6
  INC A
  JP TXT_CTL_V_48
; This entry point is used by the routines at TXT_CTL_E, TXT_CTL_T, TXT_CTL_B,
; TXT_CTL_L and TXT_CTL_C.
TXT_CTL_V_47:
  LD A,(CSRX)
; This entry point is used by the routines at TXT_CTL_X, TXT_CTL_B and MCLEAR.
TXT_CTL_V_48:
  LD E,A
  LD D,$00
  LD HL,$F6E9
  ADD HL,DE
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  RET
; This entry point is used by the routine at TXT_CTL_C.
TXT_CTL_V_49:
  CALL TXT_CTL_V_47
  DEC A
  JP Z,TXT_CTL_V_50
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  RET
; This entry point is used by the routine at GETEND.
TXT_CTL_V_50:
  LD HL,($F767)
  RST CPDEHL
  JP C,TXT_CTL_V_51
  LD DE,L0000
  RET
TXT_CTL_V_51:
  PUSH DE
  DEC DE
  RST CPDEHL
  JP NC,TXT_CTL_V_53
TXT_CTL_V_52:
  DEC DE
  RST CPDEHL
  JP NC,TXT_CTL_V_53
  LD A,(DE)
  CP $0A
  JP NZ,TXT_CTL_V_52
  DEC DE
  RST CPDEHL
  JP NC,TXT_CTL_V_53
  LD A,(DE)
  INC DE
  CP $0D
  JP NZ,TXT_CTL_V_52
  INC DE
TXT_CTL_V_53:
  PUSH DE
  CALL $67DF
  POP BC
  EX DE,HL
  POP DE
  PUSH DE
  RST CPDEHL
  EX DE,HL
  JP C,TXT_CTL_V_53
  POP DE
  LD E,C
  LD D,B
  RET
; This entry point is used by the routines at TXT_CTL_I, TXT_CTL_M and
; TXT_CTL_H.
TXT_CTL_V_54:
  CALL TXT_CTL_V_49
  EX DE,HL
  LD ($F6E9),HL
  RET
; This entry point is used by the routines at TXT_CTL_R and TXT_CTL_C.
TXT_CTL_V_55:
  LD ($F6E7),HL		; SAVE_CSRX
  PUSH HL
  LD HL,$F6EB
  CALL MCLEAR_6
  LD B,A
TXT_CTL_V_56:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  LD HL,($F6E7)		; SAVE_CSRX
  RST CPDEHL
  JP C,TXT_CTL_V_57
  POP HL
  EX DE,HL
  EX (SP),HL
  EX DE,HL
  DEC B
  JP P,TXT_CTL_V_56
  DI
  HALT
TXT_CTL_V_57:
  EX DE,HL
  POP HL
  POP HL
TXT_CTL_V_58:
  PUSH HL
  LD HL,$F894
  LD ($F892),HL
  XOR A
  LD ($F890),A
  POP HL
  DEC HL
TXT_CTL_V_59:
  INC HL
  RST CPDEHL
  JP NC,TXT_CTL_V_60
  LD A,(HL)
  CALL TXT_CTL_V_13
  LD A,(HL)
  CP $20
  JP NC,TXT_CTL_V_59
  CP $09
  JP Z,TXT_CTL_V_59
  CALL TXT_CTL_V_13
  JP TXT_CTL_V_59
TXT_CTL_V_60:
  LD A,($F890)
  INC A
  LD H,A
  CALL MCLEAR_6
  SUB B
  LD L,A
  RET
; This entry point is used by the routines at TXT_CTL_I, TXT_CTL_M, TXT_CTL_H,
; TXT_CTL_F, TXT_CTL_A, TXT_CTL_R, TXT_CTL_L, TXT_CTL_C, TXT_CTL_U and
; TXT_CTL_N.
TXT_CTL_V_61:
  CALL TXT_CTL_V_47
  PUSH DE
  INC A
  CALL TXT_CTL_V_48
  LD A,D
  AND E
  INC A
  JP NZ,TXT_CTL_V_62
  LD HL,($FB62)
  EX DE,HL
  INC DE
TXT_CTL_V_62:
  DEC DE
  LD A,(DE)
  CP $0A
  JP NZ,TXT_CTL_V_63
  DEC DE
  LD A,(DE)
  CP $0D
  JP Z,TXT_CTL_V_63
  INC DE
TXT_CTL_V_63:
  POP HL
  PUSH HL
  CALL TXT_CTL_V_58
  LD A,(CSRY)
  CP H
  JP C,TXT_CTL_V_62
  POP HL
  EX DE,HL
  RET
; This entry point is used by the routines at WAIT_SPC and TXT_CTL_U.
TXT_CTL_V_64:
  LD HL,($F767)

; Point HL to chr$(26)
;
; Used by the routines at DWNLDR and MCLEAR.
GETEND:
  LD A,$1A
GETEND_0:
  CP (HL)
  INC HL
  JP NZ,GETEND_0
  DEC HL
  LD ($FB62),HL
  RET
; This entry point is used by the routines at TXT_CTL_Z and TXT_CTL_V.
GETEND_1:
  PUSH AF
  EX DE,HL
  LD HL,($F767)
  EX DE,HL
GETEND_2:
  PUSH HL
  PUSH DE
  CALL $67DF
  POP BC
  POP HL
  RST CPDEHL
  JP NC,GETEND_2
  LD H,B
  LD L,C
  POP BC
  DEC B
  RET Z
  EX DE,HL
GETEND_3:
  PUSH BC
  CALL TXT_CTL_V_50
  POP BC
  LD A,D
  OR E
  LD HL,($F767)
  RET Z
  DEC B
  JP NZ,GETEND_3
  EX DE,HL
  RET

; Insert a character in a file. A=char to insert, HL=address at which to
; insert, exit: HL++
;
; Used by the routine at MAKTXT.
INSCHR:
  LD BC,$0001
  PUSH AF
  CALL MAKHOL
  POP BC
  RET C
  LD (HL),B
  INC HL
  RET

; Insert a specified number of spaces in a file, BC = number, HL = address at
; which to insert, exit: CY if out of memory
;
; Used by the routines at RAM_IO, CSAVEM, __CLOAD, TXT_CTL_U and INSCHR.
MAKHOL:
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
; This entry point is used by the routines at RESFPT, TXT_CTL_C and TXT_CTL_U.
MAKHOL_0:
  PUSH BC
  CALL MASDEL_0
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
  CALL NZ,_LDDR
  INC HL
  POP BC
  RET

; Delete specified no of characters, BC = number, HL = address at which to
; begin deleting.
;
; Used by the routines at KILLASC, __NEW, SWAPNM, MCLEAR and TXT_CTL_U.
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
; This entry point is used by the routine at MAKHOL.
MASDEL_0:
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

; = LDIR
;
; Used by the routines at CSAVEM, CLOADM, LDIR_B, ESC_J, MCLEAR, TXT_CTL_U and
; MASDEL.
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

; = LDDR
;
; Used by the routines at TXT_CTL_C, MCLEAR and MAKHOL.
_LDDR:
  LD A,(HL)
  LD (DE),A
  DEC HL
  DEC DE
  DEC BC
  LD A,B
  OR C
  JP NZ,_LDDR
  RET

; Start of ROM program catalog entries
;
; Start of ROM program catalog entries
ROM_PROGS:
  DEFW $49B0
  DEFW $426C
  DEFW $5341
  DEFW $4349
  DEFW $2020
  DEFW $B000
  DEFW TEXT
  DEFW $4554
  DEFW $5458
  DEFW $2020
  DEFW OUTC
  DEFW $46B0
  DEFW $5451
  DEFW $4C45
  DEFW L4F2E_0
  DEFW $204D
  DEFW $B000
  DEFW ADDRSS
  DEFW $4441
ROM_PROGS_0:
  DEFW CALMSG
  DEFW $5353
  DEFW OUTC
  DEFW $6FB0
  DEFW $535B
  DEFW $4843
  DEFW ESC_W_0
  DEFW $204C
  DEFW $8800
  DEFW L0000
  DEFW $5300
  DEFW $7A75
  DEFW $6B75
  DEFW $2069
  DEFW $00C8
  DEFW L0000
  DEFW $6148
  DEFW $6179
  DEFW $6873
  DEFW $4869
  DEFW L0000
  DEFW $5200
  DEFW $6369
  DEFW $596B
  DEFW $2020

; End of ROM programs catalog entries
L6C48:
  JR NZ,ROM_PROGS_0

; Entry to BASIC   (6c4eh?)
BASIC:
  CALL BASIC_1
  CALL BOOT_7
  LD HL,$F999
  LD ($FA8C),HL
  LD HL,(SUZUKI)
  LD (BASTXT),HL
; This entry point is used by the routine at __EDIT.
BASIC_0:
  CALL LOAD_BA_LBL
  CALL FNKSB
  XOR A
  LD ($F650),A
  INC A
  LD (LBL_LINE),A
  LD HL,$6C78
  LD ($F88A),HL
  CALL UPD_PTRS
  CALL OMERR_0
  JP READY
  LD L,H
  LD L,H
  LD L,C
  LD (HL),E
  LD (HL),H
  DEC C
  NOP
; This entry point is used by the routine at __MENU.
BASIC_1:
  LD HL,(PROGND)
  LD BC,$0178
  ADD HL,BC
  EX DE,HL
  LD HL,(FILE_BUFFR)
  RST CPDEHL
  JP C,BASIC_2
  DEC H
BASIC_2:
  LD (STRBUF),HL
  RET
; This entry point is used by the routines at OUTS_B_CHARS and BOOT.
BASIC_3:
  LD HL,FNKSTR
  LD DE,$F80A
  JP LOAD_BA_LBL_0

; LOAD BA LABEL
;
; Used by the routines at __MENU and BASIC.
LOAD_BA_LBL:
  LD HL,$F80A
  LD DE,FNKSTR
; This entry point is used by the routine at BASIC.
LOAD_BA_LBL_0:
  LD B,$80
  JP LDIR_B
; This entry point is used by the routines at TELCOM_RDY and SCHEDL_DE.
LOAD_BA_LBL_1:
  DEC HL
  RST CHRGTB
LOAD_BA_LBL_2:
  LD A,(DE)
  INC A
  RET Z
  PUSH HL
  LD B,$04
LOAD_BA_LBL_3:
  LD A,(DE)
  LD C,A
  CALL UCASE_HL
  CP C
  INC DE
  INC HL
  JP NZ,LOAD_BA_LBL_5
  DEC B
  JP NZ,LOAD_BA_LBL_3
  POP AF
  PUSH HL
  EX DE,HL
; This entry point is used by the routine at IOINIT.
LOAD_BA_LBL_4:
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
LOAD_BA_LBL_5:
  INC DE
  DEC B
  JP NZ,LOAD_BA_LBL_5
  INC DE
  POP HL
  JP LOAD_BA_LBL_2

; Cold start, Re-initialize system.  User files are not lost.
;
; Used by the routine at BOOT.
INITIO:
  DI
  LD HL,ENDLCD
  LD B,$BD
  CALL ZERO_MEM
  INC A

; Warm Start Reset
;
; Used by the routine at BOOT.
IOINIT:
  PUSH AF
  DI
  LD A,$19
  JR NC,LOAD_BA_LBL_4
  RET Z
  LD A,$43
  OUT ($B8),A
  LD A,$05
  CALL SET_CLOCK_HL_4
  LD A,$ED
  OUT ($BA),A
  XOR A
  LD (PORT_E8),A
  OUT ($E8),A
  OUT ($A8),A
  CALL _CLICK_1
  CALL UNPLOT_12
  XOR A
  OUT ($FE),A
  CALL UNPLOT_12
  LD A,$3B
  OUT ($FE),A
  CALL UNPLOT_11
  CALL UNPLOT_12
  LD A,$39
  OUT ($FE),A
  EI
  CALL _CLICK_4
  JP NC,IOINIT_1
IOINIT_0:
  XOR A
IOINIT_1:
  LD ($FC81),A
  OR A
  JP Z,IOINIT_2
  LD A,($FFFC)
  OR A
  JP NZ,IOINIT_2
  POP AF
  RET Z
  LD HL,(PROGND)
  LD DE,$E000
  RST CPDEHL
  RET NC
  CALL _CLICK_5
  PUSH AF
  JP C,IOINIT_0
IOINIT_2:
  POP AF
  RET

; PRINTER: A = chr to print, CY if BREAK
;
; Used by the routine at LPT_OUT.
PRINTR:
  PUSH BC
  LD C,A
PRINTR_0:
  CALL BREAK
  JP C,$6D6A
  IN A,($BB)
  AND $06
  XOR $02
  JP NZ,PRINTR_0
  CALL SETINT_1D
  LD A,C
  OUT ($B9),A
  LD A,(PORT_E8)
  LD B,A
  OR $02
  OUT ($E8),A
  LD A,B
  OUT ($E8),A
  LD B,$24
PRINTR_1:
  DEC B
  JP NZ,PRINTR_1
  LD A,$09
  JR NC,_RST65_1
  POP BC
  RET

; Check RS232 queue for characters, Z if no data, A = number of chars in queue
;
; Used by the routines at EXEC_EVAL, TEL_TERM, UPLDR and RV232C.
RCVX:
  LD A,(XONXOFF)
  OR A
  JP Z,RCVX_0
  LD A,($FF41)
  INC A
  RET Z
RCVX_0:
  LD A,(RS232_COUNT)
  OR A
  RET

; Get from RS232, A = char, Z if OK, CY if BREAK
;
; Used by the routines at COM_INPUT, TEL_LOGON, TEL_TERM and UPLDR.
RV232C:
  PUSH HL
  PUSH DE
  PUSH BC
  LD HL,$71F8
  PUSH HL
  LD HL,RS232_COUNT
RV232C_0:
  CALL BREAK
  RET C
  CALL RCVX
  JP Z,RV232C_0
  CP $03
  CALL C,SENDCQ
  DI
  DEC (HL)
  CALL _RST65_2
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
_RST65:
  CALL UART
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,POPALL_INT
  PUSH HL
  IN A,($C8)
  LD HL,$FF8D
  AND (HL)
  LD C,A
  IN A,($D8)
  AND $0E
  LD B,A
  JP NZ,_RST65_0
  LD A,C
  CP $11
  JP Z,$6DD2
  CP $13
  JP NZ,_RST65_0
  LD A,$AF
  LD (ENDLCD),A
  LD A,(XONXOFF)
  OR A
  RET NZ
_RST65_0:
  LD HL,RS232_COUNT
  LD A,(HL)
  CP $40
  RET Z
  CP $28
; This entry point is used by the routine at PRINTR.
_RST65_1:
  CALL NC,SENDCS
  PUSH BC
  INC (HL)
  INC HL
  CALL _RST65_2
  POP BC
  LD (HL),C
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
; This entry point is used by the routine at RV232C.
_RST65_2:
  INC HL
  LD C,(HL)
  LD A,C
  INC A
  AND $3F
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
  LD A,(XONXOFF)
  AND A
  RET Z
  LD A,(CTRL_S_FLG)
  DEC A
  RET NZ
  LD (CTRL_S_FLG),A
  PUSH BC
  LD C,$11
  JP _SD232C

; Send CTRL-S character (X-OFF)
;
; Used by the routine at _RST65.
SENDCS:
  LD A,(XONXOFF)
  AND A
  RET Z
  LD A,(CTRL_S_FLG)
  OR A
  RET NZ
  INC A
  LD (CTRL_S_FLG),A
  PUSH BC
  LD C,$13
  JP _SD232C

; Send to RS232, A = char
;
; Used by the routines at COM_OUTPUT, TEL_LOGON, TEL_TERM and UPLDR.
SD232C:
  PUSH BC
  LD C,A
  CALL _SD232C_1
  JP C,_SD232C_0

; Send to RS232, A = char, no XON/XOFF
;
; Used by the routines at SENDCQ and SENDCS.
_SD232C:
  CALL BREAK
  JP C,_SD232C_0
  IN A,($D8)
  AND $10
  JP Z,_SD232C
  LD A,C
  OUT ($C8),A
; This entry point is used by the routine at SD232C.
_SD232C_0:
  LD A,C
  POP BC
  RET
; This entry point is used by the routine at SD232C.
_SD232C_1:
  LD A,(XONXOFF)
  OR A
  RET Z
  LD A,C
  CP $11
  JP NZ,_SD232C_2
  XOR A
  LD (CTRL_S_FLG),A
  JP _SD232C_3
_SD232C_2:
  SUB $13
  JP NZ,_SD232C_4
  DEC A
_SD232C_3:
  LD ($FF41),A
  RET
_SD232C_4:
  CALL BREAK
  RET C
  LD A,(ENDLCD)
  OR A
  JP NZ,_SD232C_4
  RET

; Set baud rate, H = 0..9
;
; Used by the routine at INZCOM.
BAUDST:
  PUSH HL
  LD A,H
  RLCA
  LD HL,$6E92
  LD D,$00
  LD E,A
  ADD HL,DE
  LD (CASS_FREQ),HL
  POP HL
; This entry point is used by the routine at MUSIC.
BAUDST_0:
  PUSH HL
  LD HL,(CASS_FREQ)
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
  NOP
  LD C,B
  LD L,E
  LD B,L
  NOP
  LD B,D
  NOP
  LD B,C
  ADD A,B
  LD B,B
  LD B,B
  LD B,B
  JR NZ,$6EE2
  DJNZ CLSCOM_2
  EX AF,AF'
  LD B,B

; Init RS232 and modem, H = 0..9 (baud rate), L = UART mode, CY if RS232,
; otherwise modem
;
; Used by the routine at SETSER.
INZCOM:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD B,$25
  JP C,INZCOM_0
  LD H,$03
  LD B,$2D
INZCOM_0:
  DI
  CALL BAUDST
  LD A,B
  OUT ($BA),A
  IN A,($D8)
  LD A,L
  AND $1F
  OUT ($D8),A
  CALL XONXOFF_ON_0
  DEC A
  LD ($FF43),A
  JP POPALL_INT

; Deactivate RS232C/modem
;
; Used by the routines at COM_CLS, TEL_SET_STAT, TEL_BYE and __MENU.
CLSCOM:
  IN A,($BA)
  OR $C0
  OUT ($BA),A
  XOR A
  LD ($FF43),A
  RET
; This entry point is used by the routine at CARDET.
CLSCOM_0:
  LD E,$00
CLSCOM_1:
  IN A,($D8)
  AND $01
  XOR D
  JP NZ,CLICK
  INC E
  JP P,CLSCOM_1
; This entry point is used by the routine at BAUD_TBL.
CLSCOM_2:
  RET

; Click sound port if sound is enabled
;
; Used by the routine at CLSCOM.
CLICK:
  PUSH AF
  LD A,(SOUND_FLG)
  OR A
  CALL Z,_CLICK
  POP AF
  RET

; Detect modem carrier, Z if detected. A=0 if detected, A=FF and no Z
; otherwise.
;
; Used by the routine at TEL_LIFT.
CARDET:
  PUSH HL
  PUSH DE
  PUSH BC
  LD HL,$6F2C
  PUSH HL
  IN A,($BB)
  AND $10
  LD HL,$0249
  LD BC,$1A0E
  JP NZ,CARDET_0
  LD HL,$0427
  LD BC,$0C07
CARDET_0:
  DI
  IN A,($D8)
  AND $01
  LD D,A
  CALL CLSCOM_0
  JP M,CARDET_1
  XOR D
  LD D,A
  CALL CLSCOM_0
CARDET_1:
  EI
  RET M
  LD A,E
  CP B
  RET NC
  CP C
  RET C
  DEC HL
  LD A,H
  OR L
  JP NZ,CARDET_0
  CALL XONXOFF_ON_0
  POP HL
  JP NZ,$FFF6
  JP POPALL_0

; Enable XON/XOFFs when control Ss and Qs are sent
;
; Used by the routine at SETSER.
XONXOFF_ON:
  LD A,$AF
  DI
  LD (XONXOFF),A
  EI
  RET
; This entry point is used by the routines at INZCOM and CARDET.
XONXOFF_ON_0:
  XOR A
  LD L,A
  LD H,A
  LD (ENDLCD),HL
  LD (RS232_COUNT),HL
  LD ($FF88),HL
  RET

; Write cassette header and sync byte only
;
; Used by the routine at IOERR.
SYNCW:
  LD BC,$0200
SYNCW_0:
  LD A,$55
  PUSH BC
  CALL DATAW_0
  POP BC
  DEC BC
  LD A,B
  OR C
  JP NZ,SYNCW_0
  LD A,$7F
  JP DATAW_0

; Write char in A to cassette (no chksum)
;
; Used by the routine at CSOUT.
DATAW:
  CALL DATAW_3
; This entry point is used by the routine at SYNCW.
DATAW_0:
  LD B,$08
DATAW_1:
  CALL DATAW_2
  DEC B
  JP NZ,DATAW_1
  JP BREAK
DATAW_2:
  RLCA
  LD DE,$1F24
  JP C,DATAW_4
DATAW_3:
  LD DE,$4349
DATAW_4:
  DEC D
  JP NZ,DATAW_4
  LD D,A
  LD A,$D0
  JR NC,SYNCR_1
  JP NZ,$6F7C
  LD A,$50
  JR NC,CASS_PROBE_4
  RET

; Read cassette header and sync byte only
;
; Used by the routine at HEADER.
SYNCR:
  LD B,$80
SYNCR_0:
  CALL CASS_PROBE
  RET C
  LD A,C
  CP $08
  JP C,SYNCR
  CP $40
  JP NC,SYNCR
  DEC B
  JP NZ,SYNCR_0
; This entry point is used by the routine at DATAW.
SYNCR_1:
  CALL BREAK
  RET C
  LD HL,L0000
  LD B,$40
SYNCR_2:
  CALL CASS_PROBE_9
  RET C
  LD D,C
  CALL CASS_PROBE_9
  RET C
  LD A,D
  SUB C
  JP NC,SYNCR_3
  CPL
  INC A
SYNCR_3:
  CP $0B
  JP C,$6FBA
  INC H
  LD A,$2C
  DEC B
  JP NZ,SYNCR_2
  LD A,$40
  CP L
  JP Z,SYNCR_4
  SUB H
  JP NZ,SYNCR_1
SYNCR_4:
  LD (CASS_HILO),A
  LD D,$00
SYNCR_5:
  CALL CASS_PROBE
  RET C
  CALL CASS_PROBE_10
  CP $7F
  JP NZ,SYNCR_5
  RET

; Find the frequency of the cassette port.
;
; Used by the routines at SYNCR and DATAR.
CASS_PROBE:
  LD C,$00
  LD A,(CASS_HILO)
  AND A
  JP Z,CASS_PROBE_3
CASS_PROBE_0:
  CALL BREAK
  RET C
  JR NZ,$6FF1
  JP NC,CASS_PROBE_0
CASS_PROBE_1:
  INC C
CASS_PROBE_2:
  INC C
  JP Z,CASS_PROBE_0
  JR NZ,$6FFB
  JP C,CASS_PROBE_2
  JP CASS_PROBE_7
CASS_PROBE_3:
  CALL BREAK
  RET C
; This entry point is used by the routine at DATAW.
CASS_PROBE_4:
  JR NZ,$7007
  JP C,CASS_PROBE_3
CASS_PROBE_5:
  INC C
CASS_PROBE_6:
  INC C
  JP Z,CASS_PROBE_3
  JR NZ,CASS_PROBE_8
  JP NC,CASS_PROBE_6
CASS_PROBE_7:
  LD A,(SOUND_FLG)
  AND A
CASS_PROBE_8:
  CALL Z,_CLICK
  XOR A
  RET
; This entry point is used by the routine at SYNCR.
CASS_PROBE_9:
  CALL CASS_PROBE_5
  RET C
  LD C,$00
  CALL CASS_PROBE_1
  RET C
  JP CASS_PROBE_5
; This entry point is used by the routines at SYNCR and DATAR.
CASS_PROBE_10:
  LD A,C
  CP $15
  LD A,D
  RLA
  LD D,A
  RET

; Read char from cassette in D (no chksum)
;
; Used by the routine at CASIN.
DATAR:
  CALL CASS_PROBE
  RET C
  LD A,C
  CP $15
  JP C,DATAR
  LD B,$08
DATAR_0:
  CALL CASS_PROBE
  RET C
  CALL CASS_PROBE_10
  DEC B
  JP NZ,DATAR_0
  XOR A
  RET
; This entry point is used by the routines at CTOFF and MOTOR_OFF.
DATAR_1:
  LD A,(PORT_E8)
  AND $F1
  INC E
  DEC E
  JP Z,DATAR_2
  OR $08
DATAR_2:
  OUT ($E8),A
  LD (PORT_E8),A
  RET
  LD HL,DATAR_28
  PUSH HL
  LD HL,KBSITP
  DEC (HL)
  RET NZ
  LD (HL),$03
  LD HL,PKGFF
  LD DE,KB_SHIFT
  CALL BRK_SCAN
  CPL
  CP (HL)
  LD (HL),A
  CALL Z,DATAR_11
  XOR A
  OUT ($B9),A
  IN A,($E8)
  INC A
  LD A,$FF
  OUT ($B9),A
  JP Z,POPALL_INT_0
  LD A,$7F
  LD C,$07
DATAR_3:
  DEC HL
  DEC DE
  LD B,A
  OUT ($B9),A
  IN A,($E8)
  CPL
  CP (HL)
  LD (HL),A
  JP NZ,DATAR_4
  LD A,(DE)
  CP (HL)
  CALL NZ,DATAR_5
DATAR_4:
  LD A,$FF
  OUT ($B9),A
  LD A,B
  RRCA
  DEC C
  JP P,DATAR_3
  DEC HL
  LD (HL),$02
  LD HL,$FFA5
  DEC (HL)
  JP Z,DATAR_12
  INC (HL)
  RET M
  LD A,($FFA7)
  LD HL,($FFA8)
  AND (HL)
  RET Z
  LD A,(GETPNT)
  CP $02
  RET NC
  LD HL,$FFA4
  DEC (HL)
  RET NZ
  LD (HL),$06
  LD A,$01
  LD ($FFF3),A
  JP DATAR_13
DATAR_5:
  PUSH BC
  PUSH HL
  PUSH DE
  LD B,A
  LD A,$80
  LD E,$07
DATAR_6:
  LD D,A
  AND (HL)
  JP Z,DATAR_7
  AND B
  JP Z,DATAR_9
DATAR_7:
  LD A,D
  RRCA
  DEC E
  JP P,DATAR_6
  POP DE
DATAR_8:
  POP HL
  LD A,(HL)
  LD (DE),A
  POP BC
  RET
DATAR_9:
  LD HL,$FFA5
  INC A
  CP (HL)
  JP NZ,DATAR_10
  POP DE
  POP HL
  POP BC
  RET
DATAR_10:
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
  LD ($FFA8),HL
  EX DE,HL
  JP DATAR_8
DATAR_11:
  LD A,(DE)
  LD B,A
  LD A,(HL)
  LD (DE),A
  RLCA
  RET NC
  LD A,B
  RLCA
  RET C
  EX (SP),HL
  LD HL,$71C4
  EX (SP),HL
  LD B,$00
  LD D,B
  LD A,(HL)
  RRCA
  LD A,$03
  RET C
  LD A,$13
  RET
DATAR_12:
  DEC HL
  LD (HL),$54
  DEC HL
  LD A,(KB_SHIFT)
  LD (HL),A
DATAR_13:
  LD A,($FFA6)
  LD C,A
  LD DE,RST55
  LD B,D
  CP $33
  JP C,DATAR_14
  LD HL,$FFA7
  LD (HL),B
DATAR_14:
  LD A,($FFA3)
  RRCA
  PUSH AF
  LD A,C
  CP E
  JP C,DATAR_18
  CP $30
  JP NC,DATAR_15
  POP AF
  PUSH AF
  RRCA
  JP C,DATAR_18
DATAR_15:
  LD HL,$7CEF
  POP AF
  JP NC,DATAR_16
  LD HL,$7CDB
DATAR_16:
  ADD HL,BC
  LD A,(HL)
  RLCA
  OR A
  RRA
  LD C,A
  JP NC,DATAR_26
  CP $08
  JP NC,DATAR_17
  LD A,($F650)
  AND $E0
  JP NZ,DATAR_17
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,DATAR_17
  LD HL,FNKSTAT
  ADD HL,BC
  LD A,(HL)
  OR A
  JP Z,DATAR_17
  LD A,C
  OR $80
  JP DATAR_25
DATAR_17:
  DEC B
  JP DATAR_26
DATAR_18:
  POP AF
  JP C,DATAR_19
  LD E,B
DATAR_19:
  RRCA
  PUSH AF
  JP C,POPALL_INT_1
; This entry point is used by the routine at POPALL_INT.
DATAR_20:
  LD HL,$7C49
  RRCA
  JP C,DATAR_22
  LD HL,$7CA1
  RRCA
  JP C,DATAR_22
  RRCA
  JP NC,DATAR_21
  LD HL,KBD_MAP
  ADD HL,BC
  PUSH DE
  LD D,A
  CALL POPALL_INT_5
  LD A,D
  POP DE
  JP Z,DATAR_24
DATAR_21:
  RRCA
  CALL C,POPALL_INT_4
  LD HL,KBD_MAP
DATAR_22:
  ADD HL,DE
; This entry point is used by the routine at POPALL_INT.
DATAR_23:
  ADD HL,BC
; This entry point is used by the routine at POPALL_INT.
DATAR_24:
  POP AF
  LD A,(HL)
  JP NC,$71C2
  CP $60
  RET NC
  AND $3F
  JP C,$C8B7
  LD C,A
  AND $EF
  CP $03
  JP NZ,DATAR_26
  LD A,($F650)
  AND $C0
  JP NZ,DATAR_26
  LD A,C
DATAR_25:
  LD ($FFEB),A
  CP $03
  RET NZ
  LD HL,GETPNT
  LD (HL),$01
  INC HL
  JP DATAR_27
DATAR_26:
  LD HL,GETPNT
  LD A,(HL)
  CP $20
  RET Z
  INC (HL)
  RLCA
  INC HL
  LD E,A
  ADD HL,DE
DATAR_27:
  LD (HL),C
  INC HL
  LD (HL),B
  POP AF
; This entry point is used by the routine at SET_CLOCK_HL.
DATAR_28:
  LD A,$09
  JR NC,$71E9

; POP AF, BC, DE, and HL off stack, enable interrupts and return.
;
; Used by the routines at INZCOM and MUSIC.
POPALL_INT:
  POP AF
  POP BC
  POP DE
  POP HL
  EI
  RET
; This entry point is used by the routine at DATAR.
POPALL_INT_0:
  LD HL,$FF90
  DEC (HL)
  RET NZ
  LD HL,$FF91
  LD B,$11
  JP ZERO_MEM
; This entry point is used by the routine at DATAR.
POPALL_INT_1:
  LD A,C
  CP $1A
  LD HL,$7C1D
  JP C,DATAR_23
  CP $2C
  JP C,POPALL_INT_2
  CP $30
  JP C,POPALL_INT_3
POPALL_INT_2:
  POP AF
  PUSH AF
  JP DATAR_20
POPALL_INT_3:
  SUB $2C
  LD HL,$7D2F
  LD C,A
  ADD HL,BC
  JP DATAR_24
; This entry point is used by the routine at DATAR.
POPALL_INT_4:
  LD A,C
  CP $1A
  RET NC
  LD E,$2C
  RET
; This entry point is used by the routine at DATAR.
POPALL_INT_5:
  LD A,(HL)
  LD E,$06
  LD HL,$7CF9
POPALL_INT_6:
  CP (HL)
  INC HL
  RET Z
  INC HL
  DEC E
  JP P,POPALL_INT_6
  RET

; A = Character (if any), Z if no key.  CY if special keys
;
; Used by the routine at CHGET.
KYREAD:
  CALL SETINT_1D
  LD A,(GETPNT)
  OR A
  JP Z,EI_NORM
  LD HL,$FFAC
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
  INC HL
  LD DE,$FFAD
KYREAD_0:
  DEC C
  JP M,KYREAD_1
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  JP KYREAD_0
KYREAD_1:
  POP AF

; Enable interrupts as normal (nothing destroyed)
;
; Used by the routine at KYREAD.
EI_NORM:
  PUSH AF
  LD A,$09
  JR NC,$7260
  RET

; Z if keyboard queue is empty, CY if BREAK
;
; Used by the routine at CHGET.
KEYX:
  CALL BRKCHK
  JP Z,KEYX_0
  CP $03
  JP NZ,KEYX_0
  OR A
  SCF
  RET
KEYX_0:
  LD A,(GETPNT)
  OR A
  RET

; Test for CRTL-C or CRTL-S (pause), CY set in both the cases
;
; Used by the routines at CHSNS and KEYX.
BRKCHK:
  PUSH HL
  LD HL,$FFEB
  LD A,(HL)
  LD (HL),$00
  POP HL
  OR A
  RET P
  PUSH HL
  PUSH BC
  LD HL,$F7CA
  LD C,A
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  ADD HL,BC
  CALL TIME_S_STOP_2
  POP BC
  POP HL
  XOR A
  RET

; Routine at 29343
;
; Used by the routines at TEL_LIFT, TEL_LOGON, TEL_TERM, PRINTR, RV232C,
; _SD232C, DATAW, SYNCR, CASS_PROBE, MUSIC and _CLICK.
BREAK:
  PUSH BC
  IN A,($B9)
  LD C,A
  CALL BRK_SCAN
  PUSH AF
  LD A,C
  OUT ($B9),A
  POP AF
  POP BC
  AND $81
  RET NZ
  SCF
  RET

; Scan BREAK, CAPS, NUM, CODE, GRAPH, CONTROL, and SHIFT key column of
; keyboard.
;
; Used by the routines at DATAR and BREAK.
BRK_SCAN:
  LD A,$FF
  OUT ($B9),A
  IN A,($BA)
  AND $FE
  LD B,A
  OUT ($BA),A
  IN A,($E8)
  PUSH AF
  LD A,B
  INC A
  OUT ($BA),A
  POP AF
  RET

; Make tone, DE=freq, B=duration
;
; Used by the routine at __SOUND.
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
  CALL BREAK
  JP NC,MUSIC_1
  LD A,$03
  LD ($FFEB),A
  JP MUSIC_3
MUSIC_1:
  LD C,$64
MUSIC_2:
  PUSH BC
  LD C,$1E
  CALL UNPLOT_30
  POP BC
  DEC C
  JP NZ,MUSIC_2
  DEC B
  JP NZ,MUSIC_0
MUSIC_3:
  IN A,($BA)
  OR $04
  OUT ($BA),A
  CALL BAUDST_0
  EI
  RET
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,(HL)
  OUT ($70),A
  DI
  INC HL
  LD A,(HL)
  OUT ($71),A
  INC HL
  LD A,(HL)
  OUT ($72),A
MUSIC_4:
  LD A,B
  OR C
  JP Z,POPALL_INT
  IN A,($73)
  LD (DE),A
  INC DE
  DEC BC
  JP MUSIC_4

; Load the contents of the clock chip registers into the address pointed to by
; HL.
;
; Used by the routines at READ_CLOCK and _RST75.
READ_CLOCK_HL:
  OR $AF

; Update the clock chip internal registers with the time in the buffer pointed
; to by HL
;
; Used by the routines at SET_CLOCK and BOOT.
SET_CLOCK_HL:
  XOR A
  PUSH AF
  CALL SETINT_1D
  LD A,$03
  CALL NZ,SET_CLOCK_HL_4
  LD A,$01
  CALL SET_CLOCK_HL_4
  LD C,$07
  CALL UNPLOT_30
  LD B,$0A
SET_CLOCK_HL_0:
  LD C,$04
  LD D,(HL)
SET_CLOCK_HL_1:
  POP AF
  PUSH AF
  JP Z,SET_CLOCK_HL_2
  IN A,($BB)
  RRA
  LD A,D
  RRA
  LD D,A
  XOR A
  JP SET_CLOCK_HL_3
SET_CLOCK_HL_2:
  LD A,D
  RRCA
  LD D,A
  LD A,$10
  RRA
  RRA
  RRA
  RRA
  OUT ($B9),A
SET_CLOCK_HL_3:
  OR $09
  OUT ($B9),A
  AND $F7
  OUT ($B9),A
  DEC C
  JP NZ,SET_CLOCK_HL_1
  LD A,D
  RRCA
  RRCA
  RRCA
  RRCA
  AND $0F
  LD (HL),A
  INC HL
  DEC B
  JP NZ,SET_CLOCK_HL_0
  POP AF
  LD A,$02
  CALL Z,SET_CLOCK_HL_4
  XOR A
  CALL SET_CLOCK_HL_4
  JP SET_CLOCK_HL_16
; This entry point is used by the routine at IOINIT.
SET_CLOCK_HL_4:
  OUT ($B9),A
  LD A,(PORT_E8)
  OR $04
  OUT ($E8),A
  AND $FB
  OUT ($E8),A
  RET
; This entry point is used by the routine at _RST75.
SET_CLOCK_HL_5:
  CALL SETINT_1D
  LD HL,$7055
  PUSH HL
  LD HL,$FFF3
  DEC (HL)
  RET NZ
  LD (HL),$7D
  DEC HL
  LD A,(HL)
  OR A
  JP P,SET_CLOCK_HL_6
  RET PO
SET_CLOCK_HL_6:
  XOR $01
  LD (HL),A
; This entry point is used by the routines at ESC_J and DOTTED_FNAME.
SET_CLOCK_HL_7:
  PUSH HL
  LD HL,CURS_SHAPE
  LD D,$00
  CALL UNPLOT_2
  LD B,$06
  DEC HL
SET_CLOCK_HL_8:
  LD A,(HL)
  CPL
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,SET_CLOCK_HL_8
  INC HL
  LD D,$01
  CALL UNPLOT_2
  POP HL
  RET
; This entry point is used by the routines at OUTC_SUB, ESC_Q, ESC_J and
; DOTTED_FNAME.
SET_CLOCK_HL_9:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL SETINT_1D
  LD HL,$FFF2
  LD A,(HL)
  RRCA
  CALL C,SET_CLOCK_HL_7
  LD (HL),$80
  JP DATAR_28
; This entry point is used by the routines at OUTC_SUB and ESC_P.
SET_CLOCK_HL_10:
  PUSH AF
  PUSH HL
  CALL SETINT_1D
  LD HL,$FFF2
  LD A,(HL)
  AND $7F
  LD (HL),A
  INC HL
  LD (HL),$01
  LD A,$09
  JR NC,$73CD
  POP AF
  RET
  
; This entry point is used by the routine at ESC_J.
SET_CLOCK_HL_11:
  CALL SETINT_1D
  LD HL,L0000
  ADD HL,SP
  LD ($FFF8),HL
  DEC D
  DEC E
  EX DE,HL
  LD ($FFF4),HL
  LD A,C
  LD DE,$7710
  SUB $20
  JP Z,SET_CLOCK_HL_12
  INC DE
  CP $60
; Routine at 29705
L7409:
  LD H,B
  JP C,SET_CLOCK_HL_12
  LD DE,$76B1
; This entry point is used by the routine at SET_CLOCK_HL.
SET_CLOCK_HL_12:
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
  CALL UNPLOT_2
; This entry point is used by the routine at BOOT.
SET_CLOCK_HL_15:
  XOR A
  LD ($FFF9),A
  CALL UNPLOT_11
; This entry point is used by the routines at MOVE_CURSOR, UNPLOT and _BEEP.
SET_CLOCK_HL_16:
  LD A,$09
  JR NC,L7409

; Move cursor to specified position
;
; Used by the routines at OUTC_SUB and DOTTED_FNAME.
MOVE_CURSOR:
  CALL SETINT_1D
  DEC D
  DEC E
  EX DE,HL
  LD ($FFF4),HL
  JP SET_CLOCK_HL_16

; Plot point on screen  (D,E)
;
; Used by the routine at __PSET.
PLOT:
  OR $AF

; Reset point on screen  (D,E)
;
; Used by the routine at __PSET.
UNPLOT:
  XOR A
  PUSH AF
  CALL SETINT_1D
  PUSH DE
  LD C,$FE
  LD A,D
UNPLOT_0:
  INC C
  INC C
  LD D,A
  SUB $32
  JP NC,UNPLOT_0
  LD B,$00
  LD HL,$7643
  LD A,E
  RLA
  RLA
  RLA
  JP NC,UNPLOT_1
  LD HL,UNPLOT_28
UNPLOT_1:
  ADD HL,BC
  LD B,A
  CALL UNPLOT_13
  LD A,B
  AND $C0
  OR D
  LD B,A
  LD E,$01
  LD HL,CURS_SHAPE
  CALL $74F5
  POP DE
  LD D,B
  LD A,E
  AND $07
  ADD A,A
  LD C,A
  LD B,$00
  LD HL,$7643
  ADD HL,BC
  POP AF
  LD A,(HL)
  LD HL,CURS_SHAPE
  JP NZ,$7497
  CPL
  AND (HL)
  LD B,$B6
  LD (HL),A
  LD B,D
  LD E,$01
  CALL $74F6
  JP SET_CLOCK_HL_16
; This entry point is used by the routine at SET_CLOCK_HL.
UNPLOT_2:
  PUSH HL
  LD E,$06
  LD A,($FFF5)
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
  LD A,($FFF4)
  RRA
  RRA
  RRA
  LD HL,$75C9
  JP C,UNPLOT_6
  LD HL,L7551
UNPLOT_6:
  ADD HL,BC
  LD B,A
  CALL UNPLOT_13
  LD ($FFF6),HL
  LD A,B
  OR (HL)
  LD B,A
  POP HL
  DEC D
  CALL UNPLOT_7
  INC D
  LD A,$06
  SUB E
  RET Z
  LD E,A
  PUSH HL
  LD HL,($FFF6)
  INC HL
  CALL UNPLOT_13
  POP HL
  LD A,B
  AND $C0
  LD B,A
  DEC D
  JP C,$AFF6
UNPLOT_7:
  PUSH DE
  PUSH AF
  LD A,B
  CALL UNPLOT_14
  OUT ($FE),A
  JP Z,UNPLOT_8
  CALL UNPLOT_14
  IN A,($FF)
UNPLOT_8:
  POP AF
  JP NZ,UNPLOT_10
UNPLOT_9:
  IN A,($FE)
  RLA
  JP C,UNPLOT_9
  LD A,(HL)
  OUT ($FF),A
  INC HL
  DEC E
  JP NZ,UNPLOT_9
  POP DE
  RET
UNPLOT_10:
  IN A,($FE)
  RLA
  JP C,UNPLOT_10
  IN A,($FF)
  LD (HL),A
  INC HL
  DEC E
  JP NZ,UNPLOT_10
  POP DE
  RET
  
; This entry point is used by the routines at IOINIT and SET_CLOCK_HL.
UNPLOT_11:
  CALL UNPLOT_12
  LD A,$3E
  OUT ($FE),A
  RET
  
; This entry point is used by the routine at IOINIT.
UNPLOT_12:
  LD C,$03
  CALL UNPLOT_30
  LD HL,$7641
UNPLOT_13:
  LD A,(HL)
  OUT ($B9),A
  INC HL
  IN A,($BA)
  AND $FC
  OR (HL)
  OUT ($BA),A
  INC HL
  RET
  
UNPLOT_14:
  PUSH AF
UNPLOT_15:
  IN A,($FE)
  RLA
  JP C,UNPLOT_15
  POP AF
  RET
  
L7551:
  LD BC,L0000
  LD BC,$0600
  LD BC,$0C00
  LD BC,$1200
  LD BC,$1800
  LD BC,$1E00
  LD BC,$2400
  LD BC,$2A00
  LD BC,$3000
  LD (BC),A
  NOP
  INC B
  LD (BC),A
  NOP
  LD A,(BC)
  LD (BC),A
  NOP
  DJNZ L7578
  NOP
  LD D,$02

; Routine at 30072
L7578:
  LD (BC),A
  NOP
  INC E
  LD (BC),A
  NOP
  LD ($0002),HL
  JR Z,L7584
  NOP
  LD L,$04

; Routine at 30084
L7584:
  INC B
  NOP
  LD (BC),A
  INC B
  NOP
  EX AF,AF'
  INC B
  NOP
  LD C,$04
  NOP
L758F:
  INC D
  INC B
  NOP
  LD A,(DE)
  INC B
  NOP
  JR NZ,UNPLOT_17
  NOP
  LD H,$04
  NOP
UNPLOT_17:
  INC L
  EX AF,AF'
  NOP
  NOP
  EX AF,AF'
  NOP
  LD B,$08
  NOP
  INC C
  EX AF,AF'
  NOP
  LD (DE),A
  EX AF,AF'
  NOP
  JR L75B4
  NOP
  LD E,$08
  NOP
  INC H
  EX AF,AF'
  NOP
  LD HL,(SYNCHR)
; Routine at 30132
L75B4:
  JR NC,UNPLOT_20
  NOP
  INC B
  DJNZ UNPLOT_18
UNPLOT_18:
  LD A,(BC)
  DJNZ UNPLOT_19
UNPLOT_19:
  DJNZ UNPLOT_22
  NOP
  LD D,$10
  NOP
  INC E
  DJNZ UNPLOT_20
UNPLOT_20:
  LD (OUTC),HL
  NOP
  JR NZ,UNPLOT_21
UNPLOT_21:
  LD B,$20
  NOP
UNPLOT_22:
  INC C
  JR NZ,UNPLOT_23
UNPLOT_23:
  LD (DE),A
  JR NZ,UNPLOT_24
UNPLOT_24:
  JR L75F9
  NOP
  LD E,$20
  NOP
  INC H
  JR NZ,UNPLOT_25
UNPLOT_25:
  LD HL,(OUTC)
  JR NC,$7625
  NOP
  INC B
  LD B,B
  NOP
  LD A,(BC)
  LD B,B
  NOP
  DJNZ $762E
  NOP
  LD D,$40
  NOP
  INC E
  LD B,B
  NOP
  LD (FNCTAB_FN),HL
  JR Z,UNPLOT_27
  
; Routine at 30201
;
; Used by the routine at L75B4.
L75F9:
  LD B,B
  NOP
  LD L,$80
  NOP
  LD (BC),A
  ADD A,B
  NOP
  EX AF,AF'
  ADD A,B
  NOP
  LD C,$80
  NOP
  INC D
  ADD A,B
  NOP
  LD A,(DE)
  ADD A,B
  NOP
  JR NZ,L758F
  NOP
  LD H,$80
  NOP
  INC L
  NOP
  LD BC,L0000
  LD BC,$0006
  LD BC,$000C
  LD BC,$0012
  LD BC,CPDEHL
  LD BC,OUT_SPC
  LD BC,TRAP
  LD BC,$002A
  LD BC,TSTSGN
  LD (BC),A
  INC B
  NOP
  LD (BC),A
  LD A,(BC)
  NOP
  LD (BC),A
  DJNZ UNPLOT_26
UNPLOT_26:
  LD (BC),A
UNPLOT_27:
  LD D,$00
  LD (BC),A
  INC E
  NOP
  LD (BC),A
  LD ($03FF),HL
  LD BC,$0200
  NOP
  INC B
  NOP
  EX AF,AF'
  NOP
  DJNZ UNPLOT_28
UNPLOT_28:
  JR NZ,UNPLOT_29
UNPLOT_29:
  LD B,B
  NOP
  ADD A,B
  NOP
  NOP
  LD BC,$0200
; This entry point is used by the routines at MUSIC, SET_CLOCK_HL and _BEEP.
UNPLOT_30:
  DEC C
  JP NZ,UNPLOT_30
  RET

; Set interrupt to 1DH
;
; Used by the routines at PRINTR, KYREAD, SET_CLOCK_HL, MOVE_CURSOR, UNPLOT and
; _BEEP.
SETINT_1D:
  DI
  LD A,$1D
  JR NC,SETINT_1D
  RET

; Beep routine (07H)
_BEEP:
  CALL SETINT_1D
  LD B,$00
_BEEP_0:
  CALL _CLICK
  LD C,$50
  CALL UNPLOT_30
  DEC B
  JP NZ,_BEEP_0
  JP SET_CLOCK_HL_16

; Click sound port
;
; Used by the routines at CLICK, CASS_PROBE and _BEEP.
_CLICK:
  IN A,($BA)
  XOR $20
  OUT ($BA),A
  RET
_CLICK_0:
  LD A,($FFFB)
  INC A
  RET
; This entry point is used by the routines at _RST75 and IOINIT.
_CLICK_1:
  LD HL,$FFFB
  IN A,($82)
  AND $07
  JP Z,_CLICK_2
  LD (HL),$00
  RET
_CLICK_2:
  OR (HL)
  RET NZ
  LD (HL),$FF
_CLICK_3:
  LD A,$C1
  OUT ($83),A
  IN A,($80)
  LD A,$04
  OUT ($81),A
  OUT ($80),A
  RET
; This entry point is used by the routine at IOINIT.
_CLICK_4:
  CALL _CLICK_0
  SCF
  RET NZ
  LD A,$03
  LD ($FFFA),A
  XOR A
  CALL _CLICK_8
  CALL _CLICK_12
  RLCA
  RLCA
  AND $03
  RET
; This entry point is used by the routine at IOINIT.
_CLICK_5:
  LD A,$03
  LD ($FFFA),A
  LD HL,$770B
  LD B,$05
_CLICK_6:
  LD A,(HL)
  CALL _CLICK_8
  INC HL
  DEC B
  JP NZ,_CLICK_6
  CALL _CLICK_12
  OR A
  SCF
  RET NZ
  LD HL,$E000
_CLICK_7:
  CALL _CLICK_12
  LD (HL),A
  INC HL
  DEC B
  JP NZ,_CLICK_7
  JP $E000
_CLICK_8:
  PUSH AF
_CLICK_9:
  CALL BREAK
  JP C,_CLICK_10
  IN A,($82)
  RLCA
  JP NC,_CLICK_9
  LD A,($FFFA)
  OUT ($81),A
  POP AF
  OUT ($80),A
  RET
_CLICK_10:
  POP AF
_CLICK_11:
  POP AF
  CALL _CLICK_3
  SCF
  RET
_CLICK_12:
  CALL BREAK
  JP C,_CLICK_11
  IN A,($82)
  AND $20
  JP Z,_CLICK_12
  IN A,($80)
  RET
  LD (BC),A
  LD BC,L0000
  LD BC,L0000

; FONT: 5 bytes for 0..127, 6 bytes for 128..255
FONT:
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
  JR NC,FONT_0
  NOP
  INC B
  LD (BC),A
  LD BC,L0000
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
FONT_0:
  LD B,B
  JR NZ,FONT_1
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
FONT_1:
  LD B,(HL)
  LD ($4941),HL
  LD C,C
  LD (HL),$18
  INC D
  LD (DE),A
  LD A,A
  DJNZ $77C2
  LD B,L
  LD B,L
  ADD HL,HL
  LD DE,$4A3C
  LD C,C
  LD C,C
  JR NC,FONT_2
  LD BC,$0579
FONT_2:
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
  LD ($4141),HL
  LD ($7F41),HL
  LD B,C
  LD ($7F1C),HL
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
  JR NC,FONT_3
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
  JR NC,FONT_9
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

; Routine at 30746
L781A:
  CCF
  LD B,B
  LD B,B
  LD B,B
  CCF
  RRCA
  JR NC,FONT_7
  JR NC,FONT_4
  LD A,A
FONT_3:
  JR NZ,FONT_5
  JR NZ,FONT_14
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
FONT_4:
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
FONT_5:
  DJNZ FONT_6
  LD B,B
  NOP
  LD B,C
  LD B,C
  LD A,A
  NOP
  INC B
  LD (BC),A
  LD BC,$0402
  LD B,B
  LD B,B
  LD B,B
  LD B,B
  LD B,B
  NOP
  LD BC,$0402
  NOP
  JR NZ,FONT_15
  LD D,H
  LD D,H
  LD A,B
  LD A,A
  JR Z,FONT_12
  LD B,H
  JR C,FONT_10
FONT_6:
  LD B,H
FONT_7:
  LD B,H
  LD B,H
  JR Z,FONT_11
  LD B,H
  LD B,H
  JR Z,$78E9
  JR C,FONT_18
  LD D,H
  LD D,H
  JR FONT_8
  EX AF,AF'
  LD A,(HL)
  ADD HL,BC
  LD A,(BC)
  JR L781A
  
  AND H
  SBC A,B
FONT_8:
  LD A,H
  LD A,A
  INC B
FONT_9:
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
  DJNZ FONT_16
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
FONT_10:
  INC B
  INC B
  LD A,B
  JR C,FONT_22
FONT_11:
  LD B,H
  LD B,H
  JR C,FONT_11
FONT_12:
  JR FONT_19
  INC H
  JR FONT_17
FONT_13:
  INC H
FONT_14:
  INC H
  JR FONT_13
  LD A,H
FONT_15:
  EX AF,AF'
  INC B
  INC B
  EX AF,AF'
  LD E,B
  LD D,H
  LD D,H
  LD D,H
FONT_16:
  INC H
  INC B
  CCF
  LD B,H
  LD B,H
  JR NZ,FONT_23
  LD B,B
  LD B,B
  INC A
  LD B,B
FONT_17:
  INC E
FONT_18:
  JR NZ,FONT_24
  JR NZ,FONT_21
  INC A
  LD B,B
  JR C,$7908
FONT_19:
  INC A
  LD B,H
  JR Z,FONT_20
  JR Z,FONT_25
  INC E
  AND B
  AND B
  SUB B
  LD A,H
  LD B,H
  LD H,H
  LD D,H
  LD C,H
  LD B,H
  NOP
  EX AF,AF'
  LD (HL),$41
FONT_20:
  LD B,C
  NOP
  NOP
  LD (HL),A
FONT_21:
  NOP
  NOP
FONT_22:
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
  LD H,(HL)
  LD (HL),A
  LD C,C
  LD C,C
  LD (HL),A
  LD H,(HL)
FONT_23:
  CALL M,$D786
  XOR $FC
  NOP
  LD A,A
  LD H,E
  INC D
  EX AF,AF'
  INC D
FONT_24:
  NOP
  LD A,B
  HALT
  LD H,D
  LD C,D
  LD C,$00
  XOR $44
  RST $38
  RST $38
  LD B,H
  XOR $0C
  LD C,H
  LD A,A
FONT_25:
  LD C,H
  INC C
  NOP
  LD A,H
  LD D,(HL)
  LD A,A
  LD D,(HL)
  LD A,H
  NOP
  LD A,L
  LD (HL),A
  LD B,A
  LD (HL),A
  LD A,A
  NOP
  NOP
  NOP
  LD A,L
  NOP
  NOP
  NOP
  DJNZ FONT_26
  INC E
  LD (BC),A
  LD (BC),A
  LD (BC),A
  LD D,H
  INC (HL)
  INC E
  LD D,$15
  NOP
  LD B,C
  LD H,E
  LD D,L
  LD C,C
  LD H,E
  NOP
  INC H
  LD (DE),A
  LD (DE),A
  INC H
  LD (DE),A
  NOP
  LD B,H
  LD B,H
  LD E,A
  LD B,H
  LD B,H
  NOP
  NOP
  LD B,B
  LD A,$01
FONT_26:
  NOP
  NOP
  NOP
  EX AF,AF'
  INC E
  LD A,$00
  NOP
  SBC A,B
  CALL P,PRS_M100_6
  CALL P,$F898
  SUB H
  LD (DE),A
  LD (DE),A
  SUB H
  RET M
  INC D
  LD ($227F),HL
  INC D
  NOP
  AND B
  LD D,(HL)
  DEC A
  LD D,(HL)
  AND B
  NOP
  LD C,H
  LD HL,($2A1D)
  LD C,B
  NOP
  JR C,FONT_27
  ADD HL,SP
  DEC B
  INC BC
  RRCA
  NOP
  LD D,$3D
  LD D,$00
  NOP
  LD B,D
  DEC H
  DEC D
  JR Z,$79D4
  LD ($0204),HL
  CCF
  LD (BC),A
  INC B
  NOP
  DJNZ $79A9
  LD A,(HL)
  JR NZ,FONT_28
  NOP
  EX AF,AF'
  EX AF,AF'
  LD HL,($081C)
  NOP
  EX AF,AF'
  INC E
  LD HL,($0808)
  NOP
FONT_27:
  INC E
  LD D,A
  LD H,C
FONT_28:
  LD D,A
  INC E
  NOP
  EX AF,AF'
  INC D
  LD ($0814),HL
  NOP
  LD E,$22
  LD B,H
  LD (OUT_SPC),HL
  INC E
  LD (DE),A
  LD (HL),C
  LD (DE),A
  INC E
  NOP
  NOP
  INC B
  LD (BC),A
  LD BC,L0000
  JR NZ,FONT_33
  LD D,(HL)
  LD D,H
  LD A,B
  NOP
  LD C,$51
  LD SP,$0A11
  NOP
  LD H,H
  LD A,A
  LD B,L
  LD B,L
  JR NZ,FONT_29
FONT_29:
  NOP
  LD BC,$0402
  NOP
  NOP
  LD A,A
  DJNZ FONT_31
  RRCA
  DJNZ FONT_30
FONT_30:
  NOP
  LD (BC),A
  DEC B
  LD (BC),A
  NOP
  NOP
  INC B
  INC C
  INC E
  INC C
  INC B
  NOP
  NOP
FONT_31:
  INC B
  LD A,A
  INC B
  NOP
  NOP
  JR $7990
  AND L
  PUSH HL
  JR FONT_32
FONT_32:
  LD A,A
  LD B,C
  LD H,L
  LD D,C
  LD A,A
  NOP
  LD A,A
  LD B,C
  LD E,L
  LD C,C
  LD A,A
  NOP
  RLA
  EX AF,AF'
  INC (HL)
  LD ($0071),HL
  LD D,L
  CCF
  DJNZ FONT_38
  LD B,H
  JP PO,EXEC_EVAL_1
  INC B
  LD L,D
  LD E,C
  NOP
  LD B,$09
  LD A,A
FONT_33:
  LD BC,$017F
  ADD HL,HL
  LD HL,($2A7C)
  ADD HL,HL
  NOP
  LD (HL),B
  ADD HL,HL
  INC H
  ADD HL,HL
  LD (HL),B
  NOP
  JR C,$7A64
  LD B,H
  LD B,L
  JR C,FONT_34
FONT_34:
  INC A
  LD B,C
  LD B,B
  LD B,C
  INC A
  NOP
  INC E
  LD ($227F),HL
  INC D
  NOP
  EX AF,AF'
  INC B
  INC B
  EX AF,AF'
  INC B
  NOP
  JR NZ,FONT_42
  LD D,H
  LD D,L
  LD A,B
  NOP
  JR NC,FONT_40
  LD C,B
  LD C,D
  JR NC,FONT_35
FONT_35:
  INC A
  LD B,C
  LD B,B
  LD HL,$007C
  LD B,B
  LD A,A
  LD C,C
  LD C,C
  LD A,$00
  LD (HL),C
  LD DE,$1167
  LD (HL),C
  NOP
  JR C,FONT_44
  LD D,(HL)
  LD D,L
  JR FONT_36
FONT_36:
  INC A
  LD B,C
  LD B,D
  JR NZ,FONT_48
  NOP
  JR C,FONT_46
  LD D,(HL)
  LD D,H
  JR FONT_37
FONT_37:
  NOP
  INC B
  NOP
  INC B
  NOP
  NOP
FONT_38:
  LD C,B
  LD A,(HL)
  LD C,C
  LD BC,$0002
  LD B,B
  XOR D
  XOR C
  XOR D
  RET P
  NOP
  LD (HL),B
  XOR D
  XOR C
  XOR D
  JR NC,FONT_39
FONT_39:
  NOP
  LD (BC),A
  JP (HL)
  LD (BC),A
  NOP
  NOP
  JR NC,FONT_47
  LD C,C
  LD C,D
FONT_40:
  JR NC,FONT_41
FONT_41:
  JR C,$7ACD
  LD B,C
FONT_42:
  LD ($0078),HL
  EX AF,AF'
  INC B
  LD (BC),A
  INC B
  EX AF,AF'
  NOP
  JR C,FONT_49
  LD D,H
  LD D,L
  JR FONT_43
FONT_43:
  NOP
  LD (BC),A
  LD L,B
  LD (BC),A
  NOP
  NOP
  JR NZ,FONT_50
  LD D,(HL)
  LD D,L
  LD A,H
  NOP
  NOP
  NOP
FONT_44:
  LD L,D
  LD BC,L0000
  JR NC,FONT_50
  LD C,D
  LD C,C
  JR NC,FONT_45
FONT_45:
  INC A
  LD B,B
  LD B,D
FONT_46:
  LD HL,$007C
  INC C
  LD D,B
  LD D,D
  LD D,C
  INC A
  NOP
  LD A,D
  LD DE,$0A09
  LD (HL),C
  NOP
  LD B,D
  XOR C
  XOR C
  XOR D
  POP AF
  NOP
  LD ($4949),A
  LD C,D
FONT_47:
  LD SP,$E000
  LD D,D
  LD C,C
  LD D,D
  RET PO
  NOP
  RET M
  XOR D
  XOR C
FONT_48:
  XOR D
  ADC A,B
  NOP
  NOP
  ADC A,D
  LD SP,HL
  ADC A,D
  NOP
  NOP
  LD (HL),B
  ADC A,D
  ADC A,C
  ADC A,D
  LD (HL),B
  NOP
  LD A,B
  ADD A,D
  ADD A,C
FONT_49:
  ADD A,D
  LD A,B
  NOP
  NOP
  LD B,L
  LD A,H
  LD B,L
  NOP
  NOP
  LD A,H
  LD D,L
FONT_50:
  LD D,H
  LD D,L
  LD B,H
  NOP
  LD A,H
  LD D,H
  LD D,(HL)
  LD D,L
  LD B,H
  NOP
  RET PO
  LD D,B
  LD C,D
  LD D,C
  RET PO
  NOP
  NOP
  ADC A,B
  JP M,$0089
  NOP
  LD (HL),B
  ADC A,B
  ADC A,D
  ADC A,C
  LD (HL),B
  NOP
  INC A
  LD B,B
  LD B,D
  LD B,C
  INC A
  NOP
  INC C
  DJNZ FONT_51
  LD DE,$000C
  INC A
  LD B,C
  LD B,D
  LD B,B
  INC A
  NOP
  LD A,H
  LD D,L
  LD D,(HL)
  LD D,H
  LD B,H
  NOP
  RET PO
  LD D,C
  LD C,D
  LD D,B
  RET PO
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  RRCA
  RRCA
  RRCA
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  RRCA
  RRCA
  RRCA
  RET P
  RET P
  RET P
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  RET P
  RET P
  RET P
  RRCA
  RRCA
  RRCA
  RET P
  RET P
  RET P
  RET P
  RET P
  RET P
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RET P
  RET P
  RET P
  RET P
  RET P
  RET P
  RST $38
  RST $38
  RST $38
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RRCA
  RST $38
  RST $38
FONT_51:
  RST $38
  RST $38
  RST $38
  RST $38
  RET P
  RET P
  RET P
  RET P
  RET P
  RET P
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  RST $38
  NOP
  NOP
  RET M
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  RET M
  NOP
  NOP
  NOP
  EX AF,AF'
  EX AF,AF'
  RET M
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  NOP
  NOP
  RST $38
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  NOP
  NOP
  RST $38
  NOP
  NOP
  NOP
  NOP
  NOP
  RRCA
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  RRCA
  NOP
  NOP
  NOP
  EX AF,AF'
  EX AF,AF'
  RRCA
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  RST $38
  NOP
  NOP
  NOP
  EX AF,AF'
  EX AF,AF'
  RST $38
  EX AF,AF'
  EX AF,AF'
  EX AF,AF'
  CCF
  RRA
  RRCA
  RLCA
  INC BC
  LD BC,$C080
  RET PO
  RET P
  RET M
  CALL M,$0301
  RLCA
  RRCA
  RRA
  CCF
  CALL M,$F0F8
  RET PO
  RET NZ
  ADD A,B
  LD D,L
  XOR D
  LD D,L
  XOR D
  LD D,L

; End of LCD character generator shape table.
L7BF0:
  XOR D

; Start of keyboard conversion matrix
KBD_MAP:
  DEFM "zxcvbnmlasdfghjkqwertyuiop[;',./1234567890-=ZXCVBNMLASDFGHJKQWERTY"
  DEFM "UIOP]:\"<>?!@#$%"
  DEFB $5E
  DEFM "&*()_+"
  DEFB $00
  
  DEFB $83
  DEFB $84
  DEFB $00

  SUB L
  SUB (HL)
  ADD A,C
  SBC A,D
  ADD A,L
  ADC A,E
KBD_MAP_1:
  NOP
  ADD A,D
  NOP
  ADD A,(HL)
  NOP
  SBC A,E
  SUB E
  SUB H
  ADC A,A
  ADC A,C
  ADD A,A
  SUB B
  SUB C
  ADC A,(HL)
  SBC A,B
  ADD A,B
  LD H,B
  SUB D
  ADC A,H
  SBC A,C
  SUB A
  ADC A,D
  ADC A,B
  SBC A,H
  SBC A,L
  SBC A,(HL)
  SBC A,A
  OR H
  OR B
KBD_MAP_2:
  AND E
  LD A,E
  LD A,L
  LD E,H
  ADC A,L
  RET PO
  RST GETYPR
  RST $38
  NOP
  NOP
  NOP
  OR $F9
  EX DE,HL
  CALL PE,$EEED
  DEFB $FD
  EI
  CALL P,$E7FA
  RET PE
  JP (HL)
  JP PE,$FEFC
  RET P
  DI
  JP P,$7EF1
  PUSH AF
  NOP
  RET M
  RST TSTSGN
  NOP
  POP HL
  JP PO,$E4E3
  PUSH HL
  AND $00
  NOP
  NOP
  NOP
  LD A,H
  NOP
  ADC A,$A1
  AND D
  CP L
  NOP
  CALL $CA00
  OR (HL)
  XOR C
  CP E
  NOP
  NOP
  NOP
  SET 1,C
  RET Z
  NOP
  ADD A,$00
  NOP
  CALL Z,$C7B8
  OR A
  XOR H
  OR L
  XOR L
  AND B
  CP H
  RST SYNCHR
  XOR (HL)
  RET NZ
  NOP
  POP BC
  NOP
  NOP
  NOP
  CALL NZ,$C3C2
  XOR A
  PUSH BC
  CP (HL)
  NOP
  RST CPDEHL
  XOR E
  SBC A,$00
  NOP
  AND L
  JP C,$B9B1
  RST CHRGTB
  CP A
  NOP
  NOP
  IN A,($D9)
  RET C
  NOP
  SUB $AA
  CP D
  CALL C,$D5B3
  OR D
  NOP
  NOP
  NOP
  AND H
  DEFB $DD
  NOP
  NOP
  RET NC
  NOP
  POP DE
  NOP
  NOP
  NOP
  CALL NC,$D3D2
  AND (HL)
  AND A
  XOR B
  LD L,L
  JR NC,$7D66
  LD SP,$326B
  LD L,H
  INC SP
  LD (HL),L
  INC (HL)
  LD L,C
  DEC (HL)
  LD L,A
  LD (HL),$01
  LD B,$14
  LD (BC),A
  JR NZ,$7D8C
  ADD HL,BC
  DEC DE
  ADC A,E
  ADC A,B
  ADC A,D
  DEC C
  ADD A,B
  ADD A,C
  ADD A,D
  ADD A,E
  ADD A,H
  ADD A,L
  ADD A,(HL)
  ADD A,A
  DEC E
  INC E
  LD E,$1F
  JR NZ,KBD_MAP_3
  ADD HL,BC
  DEC DE
  ADC A,E
  ADC A,B
  ADC A,C
  DEC C
  ADD A,B
  ADD A,C
KBD_MAP_3:
  ADD A,D
  ADD A,E
  ADD A,H
  ADD A,L
  ADD A,(HL)
  ADD A,A
  LD D,C
  LD D,D
  LD D,A

; End of keyboard conversion matrix.
L7D32:
  LD E,D

; Boot routine
;
; Used by the routine at L0000.
BOOT:
  DI
  LD SP,ALT_LCD
  LD HL,$2710
BOOT_0:
  DEC HL
  LD A,H
  OR L
  JP NZ,BOOT_0
  LD A,$43
  OUT ($B8),A
  LD A,$EC
  OUT ($BA),A
  LD A,$FF
  OUT ($B9),A
  IN A,($E8)
  AND $82
  LD A,$ED
  OUT ($BA),A
  JP Z,BOOT_4
  LD HL,(MAXRAM)
  LD DE,$8A4D
  RST CPDEHL
  JP NZ,BOOT_4
  LD A,($FAC1)
  LD D,A
  CALL FREEMEM_2
  CP D
  JP NZ,BOOT_4
  CALL EXTROM_TST
  LD A,$00
  JP NZ,BOOT_1
  DEC A
BOOT_1:
  LD HL,OPTROM
  CP (HL)
  JP NZ,BOOT_4
  LD HL,($F5F2)
  EX DE,HL
  LD HL,L0000
  LD ($F5F2),HL
  LD HL,$9C0B
  RST CPDEHL
  JP NZ,BOOT_2
  LD HL,(SP_POWER)
  LD SP,HL
  CALL $F5F6
  CALL $7DD0
  LD HL,($FFF8)
  PUSH HL
  CALL ESC_J_13
  POP HL
  LD A,H
  AND A
  JP Z,POPALL
  LD SP,HL
  JP SET_CLOCK_HL_15
BOOT_2:
  LD A,($F651)
  AND A
  JP Z,BOOT_3
  CALL $7DD0
  CALL STKINI
  CALL ESC_J_13
  JP WAIT_SPC_5
BOOT_3:
  LD HL,IPL_FNAME
  LD (FNKMAC),HL
  LD HL,(STRBUF)
  LD SP,HL
  CALL $F5F6
  CALL SETMAX_1
  LD HL,__MENU
  PUSH HL
  OR $AF
  CALL IOINIT
  XOR A
  LD (POWR_FLAG),A
  LD A,($FF43)
  AND A
  RET Z
  LD HL,RS232LF
  RST CHRGTB
  CALL NC,LOADFP_1
  JP SETSER
BOOT_4:
  LD SP,$F5E6
  CALL FREEMEM_2
  LD B,$90
  LD DE,MAXRAM
  LD HL,SYSVARS_ROM
  CALL LDIR_B
  CALL FREEMEM_0
  LD A,$0C
  LD ($F930),A
  LD A,$64
  LD ($F931),A
  LD HL,FNKTAB
  CALL STFNK
  CALL BASIC_3
  LD B,$58
  LD DE,ROM_PROGS
  LD HL,DIRECTORY
  CALL REV_LDIR_B
  LD B,$D1
  XOR A
BOOT_5:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,BOOT_5
  LD (HL),$FF
  CALL EXTROM_TST
  JP NZ,BOOT_6
  DEC A
  LD (OPTROM),A
  LD HL,$F9BA
  LD (HL),$F0
  INC HL
  INC HL
  INC HL
  LD DE,$FAA6
  LD B,$06
  CALL REV_LDIR_B
  LD (HL),$20
  INC HL
  LD (HL),$00
BOOT_6:
  XOR A
  LD ($F787),A
  LD ($FCA7),A
  CALL ERASE_IPL
  LD ($F932),A
  LD A,$3A
  LD (BUFFER),A
  LD HL,PRMSTK
  LD ($FBD9),HL
  LD (STRBUF),HL
  LD (FILE_BUFFR),HL
  LD A,$01
  LD ($FBB3),A
  CALL __MAX_0
  CALL SETMAX_1
  LD HL,($FAC0)
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
  LD HL,$F999
  LD ($FA8C),HL
  CALL __NEW_0
  CALL INITIO
  LD HL,L0000
  LD (YEAR),HL
  LD HL,$7F01
  CALL SET_CLOCK_HL
  JP __MENU
; This entry point is used by the routine at BASIC.
BOOT_7:
  LD HL,$7FA4
  CALL PRS

; Display the number of free memory bytes on the screen.
;
; Used by the routine at __MENU.
FREEMEM:
  LD HL,(PROGND)
  EX DE,HL
  LD HL,(STRBUF)
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD BC,$FFF2
  ADD HL,BC
  CALL NUMPRT
  LD HL,$7F98
  JP PRS
; This entry point is used by the routine at BOOT.
FREEMEM_0:
  LD HL,RST38_VECT
  LD BC,$1D02
  LD DE,NULSUB
FREEMEM_1:
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  DEC B
  JP NZ,FREEMEM_1
  LD B,$13
  LD DE,FCERR
  DEC C
  JP NZ,FREEMEM_1
  RET
; This entry point is used by the routine at BOOT.
FREEMEM_2:
  LD HL,$C000
FREEMEM_3:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  LD A,H
  JP NZ,FREEMEM_4
  INC L
  JP NZ,FREEMEM_3
  SUB $20
  LD H,A
  JP M,FREEMEM_3
FREEMEM_4:
  LD L,$00
  ADD A,$20
  LD H,A
  LD ($FAC0),HL
  RET
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  LD BC,L0000
  LD BC,$9DCF

; Routine at 32523
__MAX:
  RST SYNCHR
  SBC A,L
  RST SYNCHR
  DEFB $DD
  CALL GETINT
  JP NZ,SNERR
  CP $10
  JP NC,FCERR
  LD (TEMP),HL
  PUSH AF
  CALL __SAVE_4
  POP AF
  CALL __MAX_0
  CALL SETMAX
  JP EXEC_EVAL
; This entry point is used by the routines at __CLEAR and BOOT.
__MAX_0:
  PUSH AF
  LD HL,(HIMEM)
  LD DE,$FEF5
__MAX_1:
  ADD HL,DE
  DEC A
  JP P,__MAX_1
  EX DE,HL
  LD HL,(STRBUF)
  LD B,H
  LD C,L
  LD HL,(FILE_BUFFR)
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
  JP NC,CHKSTK_0
  POP AF
  LD (MAXFIL),A
  LD L,E
  LD H,D
  LD (FILTAB),HL
  DEC HL
  DEC HL
  LD (FILE_BUFFR),HL
  POP BC
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A
  LD (STRBUF),HL
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
  LD BC,$0109
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
  LD ($FC87),HL
  RET
  JR NZ,_RST38H_0
  LD A,C
  LD (HL),H
  LD H,L
  LD (HL),E
  JR NZ,$8006
  LD (HL),D
  LD H,L
  LD H,L
  NOP
  LD D,H
  LD D,D
  LD D,E
  DEC L
  JR C,$7FDA
  JR NZ,$7FF9
  LD L,A
  LD H,H
  LD H,L
  LD L,H
  JR NZ,$7FE3
  JR NC,$7FE4
  JR NZ,$8009
  LD L,A
  LD H,(HL)
  LD (HL),H
  LD (HL),A
  LD H,C
  LD (HL),D
  LD H,L
  DEC C
  LD A,(BC)
  LD B,E
  LD L,A
  LD (HL),B
  LD (HL),D
  LD L,$20
  LD SP,$3839
  INC SP
  JR NZ,$8018
  LD L,C
  LD H,E
  LD (HL),D
  LD L,A
  LD (HL),E
  LD L,A
  LD H,(HL)
  LD (HL),H
  DEC C
  LD A,(BC)
  NOP

; RST 38H RAM vector driver routine (see 38H)
;
; Used by the routine at RST38H.
_RST38H:
  EX (SP),HL
  PUSH AF
  LD A,(HL)
  LD (RST38_OFFS),A
; This entry point is used by the routine at __MAX.
_RST38H_0:
  POP AF
  INC HL
  EX (SP),HL
  PUSH HL
  PUSH BC
  PUSH AF
  LD HL,RST38_VECT
  LD A,(RST38_OFFS)
  LD C,A
  LD B,$00
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  POP AF
  POP BC
  EX (SP),HL

; Routine at 32755
NULSUB:
  RET
; This entry point is used by the routine at INTEXP.
NULSUB_0:
  CALL __CDBL
  JP FAC1_FAC2
  NOP
  
