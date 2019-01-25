
# -- Hand edited additions --

b $0050 data area

@ $0000 label=BOOT
c $0000 T-BASIC ORG address

@ $0018 label=OUTC
c $0018 Output char in 'A' to console

@ $1022 label=SETMODE
c $1022 Screen set: A=40h for mode 1, A=80h for mode 2..

@ $1022 label=COLD_BOOT
c $1022 Entry from power up

@ $7022 label=FACCVT
c $7022 convert FAC -> ASCII CODE

@ $6e04 label=ASCCVT
c $6e04 convert ASCII CODE -> FAC

@ $5058 label=LINE_INPUT
c $5058 Line input with '?'


@ $8000 label=INITSA
D $8000 RAM AREA in ROM BASIC mode

@ $fc84 label=DRVTAB
D $fc84 System variable DRVTAB

@ $fc82 label=FILTAB
D $fc82 System variable FILTAB

@ $eb23 label=VARTAB
D $eb23 System variable VARTAB

@ $eb25 label=ARYTAB
D $eb25 System variable ARYTAB

@ $eb27 label=STREND
D $eb27 System variable STREND

@ $fafc label=FRETOP
D $fafc System variable FRETOP

@ $fad7 label=MEMSIZ
D $fad7 System variable MEMSIZ

@ $f853 label=TOPMEM
D $f853 System variable TOPMEM

@ $fb29 label=DATPTR
D $fb29 System variable DATPTR



# File size: 32768

# Specific Z80 CPU code detected


# Microsoft 8080/Z80 BASIC found
#  Extended BASIC detected
#  Double precision maths detected
#  Microsoft signature found


@ $f857 label=BASTXT
D $f857 BASIC program start ptr (aka TXTTAB)


#    CPDEHL (compare DE and HL), code found at $4C5A

@ $f812 label=SEED
D $f812 Seed for RND numbers
@ $f833 label=LSTRND2
D $f833 Last RND number
@ $f884 label=BUFFER
D $f884 Start of input buffer
@ $fad9 label=TMSTPT
D $fad9 Temporary string pool pointer
@ $faf9 label=TMPSTR
D $faf9 Temporary string
@ $fb1d label=NXTOPR
D $fb1d Address ptr to next operator
@ $fe7d label=CURPOS
D $fe7d Character position on line (TTYPOS on Ext. Basic)
@ $f84b label=LPTPOS
D $f84b Character position on printer
@ $fb23 label=PROGND
D $fb23 BASIC program end ptr (aka VARTAB)
@ $fb25 label=VAREND
D $fb25 End of variables
@ $fb27 label=ARREND
D $fb27 End of arrays (lowest free mem)
@ $fc48 label=SGNRES
D $fc48 Sign of result
@ $fadb label=TEMPST
D $fadb (word), temporary descriptors
@ $fad9 label=TEMPPT
D $fad9 (word), start of free area of temporary descriptor
@ $fb47 label=PRMLEN
D $fb47 (word), number of bytes of obj table
@ $fc18 label=NOFUNS
D $fc18 (byte), 0 if no function active
@ $fbaf label=PRMLN2
D $fbaf (word), size of parameter block
@ $fc1b label=FUNACT
D $fc1b (word), active functions counter
@ $fb45 label=PRMSTK
D $fb45 (word), previous block definition on stack
@ $fb06 label=SUBFLG
D $fb06 (byte), flag for USR fn. array
@ $fb08 label=TEMP
D $fb08 (word) temp. reservation for st.code
@ $fac8 label=VALTYP
D $fac8 (word) type indicator
@ $1ca1 label=PRITAB
D $1ca1 Arithmetic precedence table
@ $fb1d label=TEMP2
D $fb1d (word) temp. storage used by EVAL
@ $fafe label=TEMP3
D $fafe (word) used for garbage collection or by USR function
@ $fb10 label=SAVTXT
D $fb10 (word), prg pointer for resume
@ $fadb label=TEMPST
D $fadb (word), temporary descriptors
@ $fad9 label=TEMPPT
D $fad9 (word), start of free area of temporary descriptor
@ $f855 label=CURLIN
D $f855 (word), line number being interpreted
@ $fb1f label=OLDLIN
D $fb1f (word), old line number set up ^C ...
@ $fb10 label=SAVTXT
D $fb10 (word), prg pointer for resume
@ $fb21 label=OLDTXT
D $fb21 (word), prg pointer for CONT


@ $fc44 label=FPREG
D $fc44 Floating Point Register (FACCU, FACLOW on Ext. BASIC)
@ $fc46 label=LAST_FPREG
D $fc46 Last byte in Single Precision FP Register (+sign bit)
@ $fc47 label=FPEXP
D $fc47 Floating Point Exponent
@ $fc53 label=DBL_LAST_FPREG
D $fc53 Last byte in Double Precision FP register (+sign bit)

@ $4c5b label=CPDEHL
c $4c5b compare DE and HL (aka DCOMPR)
@ $3041 label=FNDNUM
c $3041 Load 'A' with the next number in BASIC program
@ $3042 label=GETINT
c $3042 Get a number to 'A'
@ $32ef label=GETWORD
c $32ef Get a number to DE (0..65535)
@ $3038 label=DEPINT
c $3038 Get integer variable to DE, error if negative
@ $3034 label=FPSINT
c $3034 Get subscript
@ $3035 label=POSINT
c $3035 Get positive integer
@ $77e3 label=GETVAR
c $77e3 Get variable address to DE
@ $77de label=DIM
c $77de DIM command
@ $4b6c label=CHKSTK
c $4b6c Check for C levels of stack
@ $2b98 label=OPRND
c $2b98 Get next expression value
@ $0008 label=SYNCHR
c $0008 Check syntax, 1 byte follows to be compared
@ $6414 label=LFRGNM
c $6414 number in program listing and check for ending ')'
@ $698d label=HLPASS
c $698d Get back from function passing an INT value HL
@ $6417 label=MIDNUM
c $6417 Get number in program listing
@ $680e label=INT_RESULT_A
c $680e Get back from function, result in A (signed)
@ $6955 label=INT_RESULT_HL
c $6955 Get back from function, result in HL
@ $2dce label=UNSIGNED_RES_A
c $2dce Get back from function, result in A

@ $0030 label=GETYPR
c $0030 Test number FAC type (Precision mode, etc..)
@ $67d6 label=TSTSGN
c $67d6 Test sign of FPREG
@ $6815 label=_TSTSGN
c $6815 Test sign in number
@ $6803 label=INVSGN
c $6803 Invert number sign
@ $6825 label=STAKFP
c $6825 Put FP value on stack
@ $7552 label=NEGAFT
c $7552 Negate number
@ $6669 label=LOG
c $6669 LOG
@ $75ba label=EXP
c $75ba EXP
@ $777b label=TAN
c $777b TAN
@ $7790 label=ATN
c $7790 ATN
@ $67f8 label=ABS
c $67f8 ATN
@ $6b4f label=DBL_ABS
c $6b4f ABS (double precision BASIC variant)
@ $7669 label=RND
c $7669 RND
@ $6542 label=SUBCDE
c $6542 Subtract BCDE from FP reg
@ $6545 label=FPADD
c $6545 Add BCDE to FP reg
@ $6614 label=SCALE
c $6614 Scale number in BCDE for A exponent (bits)
@ $65f4 label=PLUCDE
c $65f4 Add number pointed by HL to CDE
@ $6600 label=COMPL
c $6600 Convert a negative number to positive
@ $6832 label=PHLTFP
c $6832 Number at HL to BCDE
@ $6835 label=FPBCDE
c $6835 Move BCDE to FPREG
@ $67bf label=MLSP10
c $67bf Multiply number in FPREG by 10
@ $66ac label=FPMULT
c $66ac Multiply BCDE to FP reg
@ $6702 label=DIV10
c $6702 Divide FP by 10
@ $670b label=DIV
c $670b Divide FP by number on stack
@ $69d7 label=DCBCDE
c $69d7 Decrement FP value in BCDE
@ $6840 label=BCDEFP
c $6840 Load FP reg to BCDE
@ $6843 label=LOADFP
c $6843 Load FP value pointed by HL to BCDE
@ $688c label=CMPNUM
c $688c Compare FP reg to BCDE
@ $69b3 label=FPINT
c $69b3 Floating Point to Integer
@ $67e5 label=FLGREL
c $67e5 CY and A to FP, & normalise
@ $69f7 label=INT
c $69f7 INT
@ $6b75 label=DBL_SUB
c $6b75 Double precision SUB (formerly SUBCDE)
@ $6b7c label=DBL_ADD
c $6b7c Double precision ADD (formerly FPADD)
@ $69de label=FIX
c $69de Double Precision to Integer conversion
@ $6ab2 label=INT_MUL
c $6ab2 Integer MULTIPLY
@ $6a6a label=MLDEBC
c $6a6a Multiply DE by BC
@ $6e27 label=_ASCTFP
c $6e27 ASCII to FP number
@ $6e22 label=H_ASCTFP
c $6e22 ASCII to FP number (also '&' prefixes)
@ $61ab label=PRNUMS
c $61ab Print number string
@ $61ac label=PRS
c $61ac Create string entry and print it, (HL) = zero terminated text
@ $61af label=PRS1
c $61af Print string at HL
@ $6127 label=STR
c $6127 STR BASIC function entry
@ $6130 label=SAVSTR
c $6130 Save string in string area
@ $614a label=MKTMST
c $614a Make temporary string
@ $614d label=CRTMST
c $614d Create temporary string entry
@ $6300 label=SSTSA
c $6300 Move string on stack to string area
@ $6308 label=TOSTRA
c $6308 Move string in BC, (len in L) to string area
@ $6309 label=TSALP
c $6309 TOSTRA loop
@ $29fc label=FDTLP
c $29fc Find next DATA statement
@ $257e label=DATA
c $257e DATA statement: find next DATA program line..
@ $4c73 label=RESTOR
c $4c73 'RESTORE' stmt, init ptr to DATA program line..
@ $2364 label=NEW_STMT
c $2364 Interprete next statement
@ $2529 label=GO_TO
c $2529 Go To..
@ $3045 label=MAKINT
c $3045 Convert tmp string to int in A register
@ $62c8 label=CONCAT
c $62c8 String concatenation
@ $61c2 label=TESTR
c $61c2 Test if enough room for string
@ $6363 label=TOPOOL
c $6363 Save in string pool
@ $6188 label=TSTOPL
c $6188 Temporary string to pool
@ $2a22 label=EVAL
c $2a22 (a.k.a. GETNUM, evaluate expression (GETNUM)
@ $2a25 label=EVAL1
c $2a25 Save precedence and eval until precedence break
@ $2a37 label=EVAL3
c $2a37 Evaluate expression until precedence break
@ $6158 label=CRTST
c $6158 Create String
@ $6159 label=QTSTR
c $6159 Create quote terminated String
@ $615c label=DTSTR
c $615c Create String, termination char in D
@ $6311 label=GETSTR
c $6311 Get string pointed by FPREG 'Type Error' if it is not
@ $6314 label=GSTRCU
c $6314 Get string pointed by FPREG
@ $6317 label=GSTRHL
c $6317 Get string pointed by HL
@ $6318 label=GSTRDE
c $6318 Get string pointed by DE
@ $69ae label=TSTSTR
c $69ae Test a string, 'Type Error' if it is not

@ $1fd6 label=LNUM_RANGE
c $1fd6 Read numeric range function parameters
@ $24c0 label=LNUM_PARM
D $24c0 Read numeric function parameter
@ $23c3 label=_CHRGTB
c $23c3 Pick next char from program
@ $23c4 label=_CHRCKB
c $23c4 Pick current char (or token) on program
@ $2c5a label=UCASE_HL
c $2c5a Get char from (HL) and make upper case
@ $2c5b label=UCASE
c $2c5b Make char in 'A' upper case
@ $505e label=RINPUT
c $505e Line input

@ $1df7 label=DATSNR
c $1df7 'SN err' entry for Input STMT
@ $1dfd label=SNERR
c $1dfd entry for '?SN ERROR'
@ $255e label=ULERR
c $255e entry for '?UL ERROR'



# JP table for statements = $18A2
@ $18a2 label=FNCTAB
w $18a2 Jump table for statements and functions


# TOKEN table position = $19EC, word list in 'extended BASIC' mode.
@ $19eb label=WORDS
t $19eb BASIC keyword list
#	Token range: 86

# -- STATEMENTS --

#	RESTORE		[140]	
#	AUTO		[170]	
#	RENUM		[171]	
#	DELETE		[169]	
#	RESUME		[166]	
#	ERL		[168]	
#	ELSE		[224]	
#	RUN		[161]	
#	LIST		[138]	
#	LLIST		[147]	
#	GOTO		[158]	
#	RETURN		[137]	
#	THEN		[217]	
#	GOSUB		[141]	

@ $7aeb label=__USING
c $7aeb PRINT USING

@ $27c5 label=__TAB(
c $27c5 PRINT TAB(

#	SPC(		[222]	- same as TAB(
#	= assignment		[237]	
@ $2b98 label=__OPRND
c $2b98 '+' operand evaluation

@ $2c3e label=__SUB_OPRND
c $2c3e '-' operand evaluation

@ $6159 label=__QTSTR
c $6159 quoted string evaluation

@ $2d52 label=__NOT
c $2d52 eval NOT boolean operation

@ $2c69 label=__HEXTFP
c $2c69 Convert HEX to FP

@ $2bcb label=__ERR
c $2bcb ERR function evaluation

@ $2bd9 label=__ERL
c $2bd9 ERL function evaluation

@ $2be7 label=__VARPTR
c $2be7 VARPTR function evaluation

@ $2dd4 label=__USR
c $2dd4 eval user M/C functions

@ $641c label=__INSTR
c $641c INSTR function

#	TOKEN_?		[235]	- $7E0A
#	TOKEN_?		[226]	- $6367
#	TOKEN_?		[133]	- $43A5
#	TOKEN_?		[231]	- $0F87
#	TOKEN_?		[232]	- $403A
#	TOKEN_?		[233]	- $441E
#	TOKEN_?		[221]	- $2E3F

#	ELSE		[161]

#	AUTO
@ $2695 label=__AUTO
c $2695 BASIC command: AUTO

#	AND      	[244]
#	ABS
@ $67f8 label=__ABS
c $67f8 BASIC command: ABS
#	ATN
@ $7790 label=__ATN
c $7790 BASIC command: ATN
#	ASC
@ $6349 label=__ASC
c $6349 BASIC command: ASC
#	ATTR$      	[232]
#	BSAVE
@ $4aa2 label=__BSAVE
c $4aa2 BASIC command: BSAVE
#	BLOAD
@ $4ad8 label=__BLOAD
c $4ad8 BASIC command: BLOAD
#	CLOSE
@ $4148 label=__CLOSE
c $4148 BASIC command: CLOSE
#	CONT
@ $4ce2 label=__CONT
c $4ce2 BASIC command: CONT
#	CLEAR
@ $4dbf label=__CLEAR
c $4dbf BASIC command: CLEAR
#	CLOAD
@ $562f label=__CLOAD
c $562f BASIC command: CLOAD
#	CSAVE
@ $5617 label=__CSAVE
c 5617 BASIC command: CSAVE
#	CSRLIN      	[231]
#	CINT
@ $68f8 label=__CINT
c $68f8 BASIC command: CINT
#	CSNG
@ $696c label=__CSNG
c $696c BASIC command: CSNG
#	CDBL
@ $6996 label=__CDBL
c $6996 BASIC command: CDBL
#	CVI
@ $40fe label=__CVI
c $40fe BASIC command: CVI
#	CVS
@ $4101 label=__CVS
c $4101 BASIC command: CVS
#	CVD
@ $4104 label=__CVD
c $4104 BASIC command: CVD
#	COS
@ $76da label=__COS
c $76da BASIC command: COS
#	CHR$
@ $6359 label=__CHR_S
c $6359 BASIC command: CHR$
#	CALL
@ $5d7d label=__CALL
c $5d7d BASIC command: CALL
#	COMMON
@ $257e label=__COMMON
c $257e BASIC command: COMMON
#	CHAIN
@ $5df0 label=__CHAIN
c $5df0 BASIC command: CHAIN
#	CIRCLE
@ $5aa3 label=__CIRCLE
c $5aa3 BASIC command: CIRCLE
#	COLOR
@ $106c label=__COLOR
c $106c BASIC command: COLOR
#	CLS
@ $08cb label=__CLS
c $08cb BASIC command: CLS
#	DELETE
@ $32a8 label=__DELETE
c $32a8 BASIC command: DELETE
#	DATA
@ $257e label=__DATA
c $257e BASIC command: DATA
#	DIM
@ $77de label=__DIM
c $77de BASIC command: DIM
#	DEFSTR
@ $2479 label=__DEFSTR
c $2479 BASIC command: DEFSTR
#	DEFINT
@ $247c label=__DEFINT
c $247c BASIC command: DEFINT
#	DEFSNG
@ $247f label=__DEFSNG
c $247f BASIC command: DEFSNG
#	DEFDBL
@ $2482 label=__DEFDBL
c $2482 BASIC command: DEFDBL
#	DSKO$
@ $4456 label=__DSKO_S
c $4456 BASIC command: DSKO
#	DEF
@ $2e1c label=__DEF
c $2e1c BASIC command: DEF
#	DSKI$      	[233]
#	DSKF
@ $48ae label=__DSKF
c $48ae BASIC command: DSKF
#	ELSE
@ $2580 label=__ELSE
c $2580 BASIC command: ELSE
#	END
@ $4c91 label=__END
c $4c91 BASIC command: END
#	ERASE
@ $4d3b label=__ERASE
c $4d3b BASIC command: ERASE
#	EDIT
@ $53e9 label=__EDIT
c $53e9 BASIC command: EDIT
#	ERROR
@ $268a label=__ERROR
c $268a BASIC command: ERROR
#	ERL      	[224]
#	ERR      	[225]
#	EXP
@ $75bd label=__EXP
c $75bd BASIC command: EXP
#	EOF
@ $490e label=__EOF
c $490e BASIC command: EOF
#	EQV      	[247]
#	FOR
@ $2291 label=__FOR
c $2291 BASIC command: FOR
#	FIELD
@ $3f7b label=__FIELD
c $3f7b BASIC command: FIELD
#	FILES
@ $41a0 label=__FILES
c $41a0 BASIC command: FILES
#	FN      	[221]
#	FRE
@ $6523 label=__FRE
c $6523 BASIC command: FRE
#	FIX
@ $69de label=__FIX
c $69de BASIC command: FIX
#	FPOS
@ $4934 label=__FPOS
c $4934 BASIC command: FPOS
#	GOTO
@ $252a label=__GOTO
c $252a BASIC command: GOTO
#	GOSUB
@ $2513 label=__GOSUB
c $2513 BASIC command: GOSUB
#	GET
@ $4271 label=__GET
c $4271 BASIC command: GET
#	HEX$
@ $6122 label=__HEX_S
c $6122 BASIC command: HEX$
#	INPUT
@ $28bc label=__INPUT
c $28bc BASIC command: INPUT
#	IF
@ $26c5 label=__IF
c $26c5 BASIC command: IF
#	INSTR      	[228]
#	INT
@ $69ed label=__INT
c $69ed BASIC command: INT
#	INP
@ $2fcc label=__INP
c $2fcc BASIC command: INP
#	IMP      	[248]
#	INKEY$      	[235]
#	KEY
@ $42f4 label=__KEY
c $42f4 BASIC command: KEY
#	KILL
@ $3c63 label=__KILL
c $3c63 BASIC command: KILL
#	LPRINT
@ $26fd label=__LPRINT
c $26fd BASIC command: LPRINT
#	LLIST
@ $3073 label=__LLIST
c $3073 BASIC command: LLIST
#	LPOS
@ $2dc6 label=__LPOS
c $2dc6 BASIC command: LPOS
#	LET
@ $25a3 label=__LET
c $25a3 BASIC command: LET
#	LOCATE
@ $0f9a label=__LOCATE
c $0f9a BASIC command: LOCATE
#	LINE
@ $2848 label=__LINE
c $2848 BASIC command: LINE
#	LOAD
@ $3c77 label=__LOAD
c $3c77 BASIC command: LOAD
#	LSET
@ $3ed6 label=__LSET
c $3ed6 BASIC command: LSET
#	LIST
@ $3078 label=__LIST
c $3078 BASIC command: LIST
#	LFILES
@ $419b label=__LFILES
c $419b BASIC command: LFILES
#	LOG
@ $6669 label=__LOG
c $6669 BASIC command: LOG
#	LOC
@ $48d7 label=__LOC
c $48d7 BASIC command: LOC
#	LEN
@ $633d label=__LEN
c $633d BASIC command: LEN
#	LEFT$
@ $639f label=__LEFT_S
c $639f BASIC command: LEFT$
#	LOF
@ $48f9 label=__LOF
c $48f9 BASIC command: LOF
#	MOTOR
@ $15f5 label=__MOTOR
c $15f5 BASIC command: MOTOR
#	MERGE
@ $3c78 label=__MERGE
c $3c78 BASIC command: MERGE
#	MOD      	[249]
#	MKI$
@ $40e5 label=__MKI_S
c $40e5 BASIC command: MKI$
#	MKS$
@ $40e8 label=__MKS_S
c $40e8 BASIC command: MKS$
#	MKD$
@ $40eb label=__MKD_S
c $40eb BASIC command: MKD$
#	MID$
@ $63d8 label=__MID_S
c $63d8 BASIC command: MID$
#	NEXT
@ $4e3e label=__NEXT
c $4e3e BASIC command: NEXT
#	NAME
@ $39ed label=__NAME
c $39ed BASIC command: NAME
#	NEW
@ $4bab label=__NEW
c $4bab BASIC command: NEW
#	NOT      	[223]
#	OPEN
@ $3a38 label=__OPEN
c $3a38 BASIC command: OPEN
#	OUT
@ $2fe1 label=__OUT
c $2fe1 BASIC command: OUT
#	ON
@ $260e label=__ON
c $260e BASIC command: ON
#	OR      	[245]
#	OCT$
@ $611d label=__OCT_S
c $611d BASIC command: OCT
#	OPTION
@ $3435 label=__OPTION
c $3435 BASIC command: OPTION
#	OFF      	[234]
#	PRINT
@ $2705 label=__PRINT
c $2705 BASIC command: PRINT
#	PUT
@ $4270 label=__PUT
c $4270 BASIC command: PUT
#	POKE
@ $32e3 label=__POKE
c $32e3 BASIC command: POKE
#	POS
@ $2dcb label=__POS
c $2dcb BASIC command: POS
#	PEEK
@ $32dc label=__PEEK
c $32dc BASIC command: PEEK
#	PSET
@ $57bf label=__PSET
c $57bf BASIC command: PSET
#	PRESET
@ $57ba label=__PRESET
c $57ba BASIC command: PRESET
#	POINT
@ $c44e label=__POINT
c $c44e BASIC command: POINT
#	PAINT
@ $595b label=__PAINT
c $595b BASIC command: PAINT
#	RETURN
@ $2563 label=__RETURN
c $2563 BASIC command: RETURN
#	READ
@ $297c label=__READ
c $297c BASIC command: READ
#	RUN
@ $24ff label=__RUN
c $24ff BASIC command: RUN
#	RESTORE
@ $4c73 label=__RESTORE
c $4c73 BASIC command: RESTORE
#	REM
@ $2580 label=__REM
c $2580 BASIC command: REM
#	RESUME
@ $2652 label=__RESUME
c $2652 BASIC command: RESUME
#	RSET
@ $3ed5 label=__RSET
c $3ed5 BASIC command: RSET
#	RIGHT$
@ $63cf label=__RIGHT_S
c $63cf BASIC command: RIGHT
#	RND
@ $7669 label=__RND
c $7669 BASIC command: RND
#	RENUM
@ $3313 label=__RENUM
c $3313 BASIC command: RENUM
#	RANDOMIZE
@ $3474 label=__RANDOMIZE
c $3474 BASIC command: RANDOMIZE
#	SCREEN
@ $5455 label=__SCREEN
c $5455 BASIC command: SCREEN
#	STOP
@ $4c8d label=__STOP
c $4c8d BASIC command: STOP
#	SWAP
@ $4cfd label=__SWAP
c $4cfd BASIC command: SWAP
#	SET
@ $3fc0 label=__SET
c $3fc0 BASIC command: SET
#	SAVE
@ $3cba label=__SAVE
c $3cba BASIC command: SAVE
#	SPC(      	[222]
#	STEP      	[219]
#	SGN
@ $680b label=__SGN
c $680b BASIC command: SGN
#	SQR
@ $7557 label=__SQR
c $7557 BASIC command: SQR
#	SIN
@ $76e0 label=__SIN
c $76e0 BASIC command: SIN
#	STR$
@ $6127 label=__STR_S
c $6127 BASIC command: STR
#	STRING$      	[226]
#	SPACE$
@ $6386 label=__SPACE_S
c $6386 BASIC command: SPACE
#	SOUND
@ $5458 label=__SOUND
c $5458 BASIC command: SOUND
#	THEN      	[217]
#	TRON
@ $4cf7 label=__TRON
c $4cf7 BASIC command: TRON
#	TROFF
@ $4cf8 label=__TROFF
c $4cf8 BASIC command: TROFF
#	TAB(      	[218]
#	TO      	[216]
#	TAN
@ $777b label=__TAN
c $777b BASIC command: TAN
#	TERM
@ $547e label=__TERM
c $547e BASIC command: TERM
#	TIME
@ $aacf label=__TIME
c $aacf BASIC command: TIME
#	USING      	[227]
#	USR      	[220]
#	VAL
@ $63f9 label=__VAL
c $63f9 BASIC command: VAL
#	VARPTR      	[230]
#	WIDTH
@ $3001 label=__WIDTH
c $3001 BASIC command: WIDTH
#	WAIT
@ $2fe7 label=__WAIT
c $2fe7 BASIC command: WAIT
#	WHILE
@ $5cf0 label=__WHILE
c $5cf0 BASIC command: WHILE
#	WEND
@ $5d0f label=__WEND
c $5d0f BASIC command: WEND
#	WRITE
@ $60a4 label=__WRITE
c $60a4 BASIC command: WRITE
#	XOR      	[246]
#	Z
#	[+      	[239]
#	[-      	[240]
#	[*      	[241]
#	[/      	[242]
#	[^      	[243]
#	[\      	[250]
#	['      	[229]
#	[>      	[236]
#	[=      	[237]
#	[<      	[238]
#

# hand edited extra tweaking
c 1501
b 1502
b 3999
b 4007
b 4230
b 4339
b 4352
b 4423
b 4936
b 8164
b 8858
b 8943
b 9639
b 9748
b 9794
b 9892
b 9939
b 10230
b 10318
b 10473
b 10781
b 10784
b 11241
b 11262
b 11324
b 11522
b 11794
b 11836
b 11875
b 11935
b 11941
b 12024
b 12200
b 12251
b 12275
b 13032
b 13097
b 13105
b 13366
b 13368
b 13370
b 13372
b 13650
b 14839
b 14841
b 14940
b 14942
b 14944
b 14946
b 14948
b 14950
b 14957
b 14959
b 14961
b 14963
b 14965
b 14972
b 14974
b 14980
b 14982
b 15497
b 15557
b 15559
b 16096
b 16288
b 16290
b 16391
b 16444
b 16468
b 17052
b 17319
b 17321
b 17353
b 17440
b 17447
b 17564
b 17577
b 17603
b 18774
b 19250
b 19264
b 19727
b 19917
b 19946
b 21602
b 21638
b 21705
b 21818
b 21820
b 21845
b 21850
b 21921
b 22408
b 22414
b 22419
b 22525
b 22607
b 22619
b 22621
b 22626
b 22892
b 23207
b 23298
b 23695
b 23975
b 23999
b 24088
b 24109
b 24117
b 24119
b 24121
b 24126
b 24336
b 24341
b 24791
b 25449
b 25455
b 25460
b 25622
b 25648
b 25656
b 25666
b 25760
b 25799
b 25884
b 25889
b 30685
b 31474
b 31768

c 1503
c 4000
c 4008
c 4231
c 4340
c 4353
c 4424
c 4937
c 8165
c 8859
c 8944
c 9640
c 9749
c 9795
c 9893
c 9940
c 10231
c 10319
c 10474
c 10782
c 10785
c 11242
c 11263
c 11325
c 11523
c 11795
c 11837
c 11876
c 11936
c 11942
c 12025
c 12201
c 12252
c 12276
c 13033
c 13098
c 13106
c 13367
c 13369
c 13371
c 13373
c 13651
c 14840
c 14842
c 14941
c 14943
c 14945
c 14947
c 14949
c 14951
c 14958
c 14960
c 14962
c 14964
c 14966
c 14973
c 14975
c 14981
c 14983
c 15498
c 15558
c 15560
c 16097
c 16289
c 16291
c 16392
c 16445
c 16469
c 17053
c 17320
c 17322
c 17354
c 17441
c 17448
c 17565
c 17578
c 17604
c 18775
c 19251
c 19265
c 19728
c 19918
c 19947
c 21603
c 21639
c 21706
c 21819
c 21821
c 21846
c 21851
c 21922
c 22409
c 22415
c 22420
c 22526
c 22608
c 22620
c 22622
c 22627
c 22893
c 23208
c 23299
c 23696
c 23976
c 24000
c 24089
c 24110
c 24118
c 24120
c 24122
c 24127
c 24337
c 24342
c 24792
c 25450
c 25456
c 25461
c 25623
c 25649
c 25657
c 25667
c 25761
c 25800
c 25885
c 25890
c 30686
c 31475
c 31769

