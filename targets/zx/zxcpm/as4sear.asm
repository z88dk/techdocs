;	TITLE	'ASM TABLE SEARCH MODULE'
	ORG	75A0H
	JMP	ENDMOD	;TO NEXT MODULE
	JMP	BSEAR
	JMP	BGET
;
;	COMMON EQUATES
PBMAX	EQU	120	;MAX PRINT SIZE
PBUFF	EQU	610CH	;PRINT BUFFER
PBP	EQU	PBUFF+PBMAX	;PRINT BUFFER POINTER
;
TOKEN	EQU	PBP+1	;CURRENT TOKEN UDER SCAN
VALUE	EQU	TOKEN+1	;VALUE OF NUMBER IN BINARY
ACCLEN	EQU	VALUE+2	;ACCUMULATOR LENGTH
ACMAX	EQU	64	;MAX ACCUMULATOR LENGTH
ACCUM	EQU	ACCLEN+1
;
EVALUE	EQU	ACCUM+ACMAX	;VALUE FROM EXPRESSION ANALYSIS
;
SYTOP	EQU	EVALUE+2	;CURRENT SYMBOL TOP
SYMAX	EQU	SYTOP+2		;MAX ADDRESS+1
;
PASS	EQU	SYMAX+2	;CURRENT PASS NUMBER
FPC	EQU	PASS+1	;FILL ADDRESS FOR NEXT HEX BYTE
ASPC	EQU	FPC+2	;ASSEMBLER'S PSEUDO PC
;
;	GLOBAL EQUATES
IDEN	EQU	1	;IDENTIFIER
NUMB	EQU	2	;NUMBER
STRNG	EQU	3	;STRING
SPECL	EQU	4	;SPECIAL CHARACTER
;
PLABT	EQU	0001B	;PROGRAM LABEL
DLABT	EQU	0010B	;DATA LABEL
EQUT	EQU	0100B	;EQUATE
SETT	EQU	0101B	;SET
MACT	EQU	0110B	;MACRO
;
EXTT	EQU	1000B	;EXTERNAL
REFT	EQU	1011B	;REFER
GLBT	EQU	1100B	;GLOBAL
;
;
CR	EQU	0DH	;CARRIAGE RETURN
;
;
;	TABLE DEFINITIONS
;
;	TYPES
XBASE	EQU	0	;START OF OPERATORS
;	O1 THROUGH O15 DENOTE OPERATIONS
RT	EQU	16
PT	EQU	RT+1	;RT IS REGISTER TYPE, PT IS PSEUDO OPERATION
OBASE	EQU	PT+1
O1	EQU	OBASE+1	;SIMPLE
O2	EQU	OBASE+2	;LXI
O3	EQU	OBASE+3	;DAD
O4	EQU	OBASE+4	;PUSH/POP
O5	EQU	OBASE+5	;JMP/CALL
O6	EQU	OBASE+6	;MOV
O7	EQU	OBASE+7	;MVI
O8	EQU	OBASE+8	;ACC IMMEDIATE
O9	EQU	OBASE+9	;LDAX/STAX
O10	EQU	OBASE+10	;LHLD/SHLD/LDA/STA
O11	EQU	OBASE+11	;ACCUM REGISTER
O12	EQU	OBASE+12	;INC/DEC
O13	EQU	OBASE+13	;INX/DCX
O14	EQU	OBASE+14	;RST
O15	EQU	OBASE+15	;IN/OUT
;
;	X1 THROUGH X15 DENOTE OPERATORS
X1	EQU	XBASE	;*
X2	EQU	XBASE+1	;/
X3	EQU	XBASE+2	;MOD
X4	EQU	XBASE+3	;SHL
X5	EQU	XBASE+4	;SHR
X6	EQU	XBASE+5	;+
X7	EQU	XBASE+6	;-
X8	EQU	XBASE+7	;UNARY -
X9	EQU	XBASE+8	;NOT
X10	EQU	XBASE+9	;AND
X11	EQU	XBASE+10;OR
X12	EQU	XBASE+11;XOR
X13	EQU	XBASE+12;(
X14	EQU	XBASE+13;)
X15	EQU	XBASE+14;,
X16	EQU	XBASE+15;CR
;
;
;
;
;	RESERVED WORD TABLES
;
;	BASE ADDRESS VECTOR FOR CHARACTERS
CINX:	DW	CHAR1	;LENGTH 1 BASE
	DW	CHAR2	;LENGTH 2 BASE
	DW	CHAR3	;LENGTH 3 BASE
	DW	CHAR4	;LENGTH 4 BASE
	DW	CHAR5	;LENGTH 5 BASE
	DW	CHAR6	;LENGTH 6 BASE
;
CMAX	EQU	($-CINX)/2-1	;LARGEST STRING TO MATCH
;
CLEN:	;LENGTH VECTOR GIVES THE NUMBER OF ITEMS IN EACH TABLE
	DB	CHAR2-CHAR1
	DB	(CHAR3-CHAR2)/2
	DB	(CHAR4-CHAR3)/3
	DB	(CHAR5-CHAR4)/4
	DB	(CHAR6-CHAR5)/5
;
TVINX:	;TABLE OF TYPE,VALUE PAIRS FOR EACH RESERVED SYMBOL
	DW	TV1
	DW	TV2
	DW	TV3
	DW	TV4
	DW	TV5
;
;	CHARACTER VECTORS FOR 1,2,3,4, AND 5 CHARACTER NAMES
CHAR1:	DB	CR,'()*'
	DB	'+'
	DB	',-/A'
	DB	'BCDE'
	DB	'HLM'
;
CHAR2:	DB	'DBDIDSDW'
	DB	'EIIFINOR'
	DB	'SP'
;
CHAR3:	DB	'ACIADCADDADI'
	DB	'ANAANDANICMA'
	DB	'CMCCMPCPIDAA'
	DB	'DADDCRDCXEND'
	DB	'EQUHLTINRINX'
	DB	'JMPLDALXIMOD'
	DB	'MOVMVINOPNOT'
	DB	'ORAORGORIOUT'
	DB	'POPPSWRALRAR'
	DB	'RETRLCRRCRST'
	DB	'SBBSBISETSHL'
	DB	'SHRSTASTCSUB'
	DB	'SUIXORXRAXRI'
;
CHAR4:	DB	'CALLENDMLDAXLHLDPCHL'
	DB	'PUSHSHLDSPHLSTAX'
	DB	'XCHGXTHL'
;
CHAR5:	DB	'ENDIFMACROTITLE'
;
CHAR6:	;END OF CHARACTER VECTOR
;
TV1:	;TYPE,VALUE PAIRS FOR CHAR1 VECTOR
	DB	X16,10,		X13,20		;CR (
	DB	X14,30,		X1,80		;) *
	DB	X6,70				;+
	DB	X15,10,		X7,70		;, -
	DB	X2,80,		RT,7		;/ A
	DB	RT,0,		RT,1		;B C
	DB	RT,2,		RT,3		;D E
	DB	RT,4,		RT,5		;H L
	DB	RT,6				;M
;
TV2:	;TYPE,VALUE PAIRS FOR CHAR2 VECTOR
	DB	PT,1,		O1,0F3H		;DB DI
	DB	PT,2,		PT,3		;DS DW
	DB	O1,0FBH,	PT,8		;EI IF
	DB	O15,0DBH,	X11,40		;IN OR
	DB	RT,6				;SP
;
;
TV3:	;TYPE,VALUE PAIRS FOR CHAR3 VECTOR
	DB	O8,0CEH,	O11,88H		;ACI ADC
	DB	O11,80H,	O8,0C6H		;ADD ADI
	DB	O11,0A0H,	X10,50		;ANA AND
	DB	O8,0E6H,	O1,2FH		;ANI CMA
	DB	O1,3FH,		O11,0B8H	;CMC CMP
	DB	O8,0FEH,	O1,27H		;CPI DAA
	DB	O3,09H,		O12,05H		;DAD DCR
	DB	O13,0BH,	PT,4		;DCX END
	DB	PT,7,		O1,76H		;EQU HLT
	DB	O12,04H,	O13,03H		;INR INX
	DB	O5,0C3H,	O10,3AH		;JMP LDA
	DB	O2,01H,		X3,80		;LXI MOD
	DB	O6,40H,		O7,06H		;MOV MVI
	DB	O1,00H,		X9,60		;NOP NOT
	DB	O11,0B0H,	PT,10		;ORA ORG
	DB	O8,0F6H,	O15,0D3H	;ORI OUT
	DB	O4,0C1H,	RT,6		;POP PSW
	DB	O1,17H,		O1,1FH		;RAL RAR
	DB	O1,0C9H,	O1,07H		;RET RLC
	DB	O1,0FH,		O14,0C7H	;RRC RST
	DB	O11,098H,	O8,0DEH		;SBB SBI
	DB	PT,11,		X4,80		;SET SHL
	DB	X5,80,		O10,32H		;STA STC
	DB	O1,37H,		O11,90H		;STC SUB
	DB	O8,0D6H,	X12,40		;SUI XOR
	DB	O11,0A8H,	O8,0EEH		;XRA XRI
;
;
TV4:	;TYPE,VALUE PAIRS FOR CHAR4 VECTOR
	DB	O5,0CDH				;CALL
	DB	PT,6,		O9,0AH		;ENDM LDAX
	DB	O10,02AH,	O1,0E9H		;LHLD PCHL
	DB	O4,0C5H,	O10,22H		;PUSH SHLD
	DB	O1,0F9H,	O9,02H		;SPHL STAX
	DB	O1,0EBH,	O1,0E3H		;XCHG XTHL
;
TV5:	;TYPE,VALUE PAIRS FOR CHAR5 VECTOR
	DB	PT,5,		PT,9		;ENDIF MACRO
	DB	PT,12				;TITLE
;
SUFTAB:	;TABLE OF SUFFIXES FOR J C AND R OPERATIONS
	DB	'NZZ NCC POPEP M '
;
BSEAR:	;BINARY SEARCH MNEMONIC TABLE
;	INPUT: UR = UPPER BOUND OF TABLE (I.E., TABLE LENGTH-1)
;		SR = SIZE OF EACH TABLE ELEMENT
;		H,L ADDRESS BASE OF TABLE TO SEARCH
;	OUTPUT: ZERO FLAG INDICATES MATCH WAS FOUND, IN WHICH CASE
;		THE ACCUMULATOR CONTAINS AN INDEX TO THE ELEMENT
;		NOT ZERO FLAG INDICATES NO MATCH FOUND IN TABLE
;
UR	EQU	B	;UPPER BOUND REGISTER
LR	EQU	C	;LOWER BOUND REGISTER
SR	EQU	D	;SIZE REGISTER
MR	EQU	E	;MIDDLE POINTER REGISTER
SP1	EQU	B	;SIZE PRIME, USED IN COMPUTING MIDDLE POSITON
SP1P	EQU	C	;ANOTHER COPY OF SIZE PRIME
KR	EQU	H	;K
;
	MVI	MR,255	;MARK M <> OLD M
	INR	UR	;U=U+1
	MVI	LR,0	;L = 0
;
;	COMPUTE M' = (U+L)/2
NEXT:	XRA	A
	MOV	A,UR	;CY=0, A=U
	ADD	LR	;(U+L)
	RAR	;(U+L)/2
	CMP	MR	;SAME AS LAST TIME THROUGH?
	JZ	NMATCH	;JUMP IF = TO NO MATCH
;
;	MORE ELEMENTS TO SCAN
	MOV	MR,A	;NEW MIDDLE VALUE
	PUSH	H	;SAVE A COPY OF THE BASE ADDRESS
	PUSH	D	;SAVE S,M
	PUSH	B	;SAVE U,L
	PUSH	H	;SAVE ANOTHER COPY OF THE BASE ADDRESS
	MOV	SP1,SR	;S' = S
	MOV	SP1P,SP1	;S'' = S'
	MVI	SR,0	;FOR DOUBLE ADD OPERATION BELOW (DOUBLE M)
;
	LXI	KR,0	;K=0
SUMK:	DAD	D	;K = K + M
	DCR	SP1	;S' = S' - 1
	JNZ	SUMK	;DECREMENT IF SP1 <> 0
;
;	K IS NOW RELATIVE BYTE POSITION
	POP	D	;TABLE BASE ADDRESS
	DAD	D	;H,L CONTAINS ABSOLUTE ADDRESS OF BYTE TO COMPARE
	LXI	D,ACCUM	;D,E ADDRESS CHARACTERS TO COMPARE
;
COMK:	;COMPARE NEXT CHARACTER
	LDAX	D	;ACCUM CHARACTER TO REG A
	CMP	M	;SAME AS TABLE ENTRY?
	INX	D
	INX	H	;TO NEXT POSITIONS
	JNZ	NCOM	;JUMP IF NOT THE SAME
	DCR	SP1P	;MORE CHARACTERS?
	JNZ	COMK
;
;	COMPLETE MATCH AT M
	POP	B
	POP	D	;M RESTORED
	POP	H
	MOV	A,MR	;VALUE OF M COPIED IN A
	RET		;WITH ZERO FLAG SET
;
NCOM:	;NO MATCH, DETERMINE IF LESS OR GREATER
	POP	B	;U,L
	POP	D	;S,M
	POP	H	;TABLE ADDRESS
	JC	NCOML
;	ACCUM IS HIGHER
	MOV	LR,MR	;L = M
	JMP	NEXT
;
NCOML:	;ACCUMULATOR IS LOW
	MOV	UR,MR	;U = M
	JMP	NEXT
;
NMATCH:	;NO MATCH
	XRA	A
	INR	A	;SETS NOT ZERO FLAG
	RET
;
PREFIX:	;J C OR R PREFIX?
	LDA	ACCUM
	LXI	B,(0C2H SHL 8) OR O5	;JNZ OPCODE TO B, TYPE TO C
	CPI	'J'
	RZ		;RETURN WITH ZERO FLAG SET IF J
	MVI	B,0C4H		;CNZ OPCODE TO B, TYPE IS IN C
	CPI	'C'
	RZ
	LXI	B,(0C0H SHL 8) OR O1	;RNZ OPCODE
	CPI	'R'
	RET
;
SUFFIX:	;J R OR C RECOGNIZED, LOOK FOR SUFFIX
	LDA	ACCLEN
	CPI	4	;CHECK LENGTH
	JNC	NSUFF	;CARRY IF 0,1,2,3 IN LENGTH
	CPI	3
	JZ	SUF0	;ASSUME 1 OR 2 IF NO BRANCH
	CPI	2
	JNZ	NSUFF	;RETURNS IF 0 OR 1
	LXI	H,ACCUM+2
	MVI	M,' '	;BLANK-OUT FOR MATCH ATTEMPT
SUF0:	;SEARCH 'TIL END OF TABLE
	LXI	B,8	;B=0, C=8 COUNTS TABLE DOWN TO ZERO OR MATCH
	LXI	D,SUFTAB
NEXTS:	;LOOK AT NEXT SUFFIX
	LXI	H,ACCUM+1	;SUFFIX POSITION
	LDAX	D		;CHARACTER TO ACCUM
	CMP	M
	INX	D		;READY FOR NEXT CHARACTER
	JNZ	NEXT0		;JMP IF NO MATCH
	LDAX	D		;GET NEXT CHARACTER
	INX	H		;READY FOR COMPARE WITH ACCUM
	CMP	M		;SAME?
	RZ			;RETURN WITH ZERO FLAG SET, B IS SUFIX
NEXT0:	INX	D		;MOVE TO NEXT CHARACTER
	INR	B		;COUNT SUFFIX UP
	DCR	C		;COUNT TABLE LENGTH DOWN
	JNZ	NEXTS
;	END OF TABLE, MARK WITH NON ZERO FLAG
	INR	C
	RET
;
NSUFF:	;NOT PROPER SUFFIX - SET NON ZERO FLAG
	XRA	A
	INR	A
	RET
;
BGET:	;PERFORM BINARY SEARCH, AND EXTRACT TYPE AND VAL FIELDS FOR
;	THE ITEM.  ZERO FLAG INDICATES MATCH WAS FOUND, WITH TYPE
;	IN THE ACCUMULATOR, AND VAL IN REGISTER B.  THE SEARCH IS BASED
;	UPON THE LENGTH OF THE ACCUMULATOR
	LDA	ACCLEN	;ITEM LENGTH
	MOV	C,A	;SAVE A COPY
	DCR	A	;ACCLEN-1
	MOV	E,A
	MVI	D,0	;DOUBLE ACCLEN-1 TO D,E
	PUSH	D	;SAVE A COPY FOR LATER
	CPI	CMAX	;TOO LONG?
	JNC	NGET	;NOT IN RANGE IF CARRY
	LXI	H,CLEN	;LENGTH VECTOR
	DAD	D
	MOV	UR,M	;FILL UPPER BOUND FROM MEMORY
	LXI	H,CINX
	DAD	D
	DAD	D	;BASE ADDRESS TO H,L
	MOV	D,M
	INX	H
	MOV	H,M
	MOV	L,D	;NOW IN H,L
	MOV	SR,C	;FILL THE SIZE REGISTER
	CALL	BSEAR	;PERFORM THE BINARY SEARCH
	JNZ	SCASE	;ZERO IF FOUND
	POP	D	;RESTORE INDEX
	LXI	H,TVINX
	DAD	D
	DAD	D	;ADDRESSING PROPER TV ELEMENT
	MOV	E,M
	INX	H
	MOV	D,M
;	D,E IS BASE ADDRESS OF TYPE/VALUE VECTOR, ADD DISPLACEMENT
	MOV	L,A
	MVI	H,0
	DAD	H	;DOUBLED
	DAD	D	;INDEXED
	MOV	A,M	;TYPE TO ACC
	INX	H
	MOV	B,M	;VALUE TO B
	RET		;TYPE IN ACC, VALUE IN B
;
SCASE:	;NAME NOT TOO LONG, BUT NOT FOUND IN TABLES, MAY BE J C OR R
	POP	D	;RESTORE INDEX
	CALL	PREFIX
	RNZ		;NOT FOUND AS PREFIX J C OR R IF NOT ZERO FLAG
	PUSH	B	;SAVE VALUE AND TYPE
	CALL	SUFFIX	;ZERO IF SUFFIX MATCHED
	MOV	A,B	;READY FOR MASK IF ZERO FLAG
	POP	B	;RECALL VALUE AND TYPE
	RNZ		;RETURN IF NOT ZERO FLAG SET
;	MASK IN THE PROPER BITS AND RETURN
	ORA	A	;CLEAR CARRY
	RAL
	RAL
	RAL
	ORA	B	;VALUE SET TO JNZ ...
	MOV	B,A	;REPLACE
	MOV	A,C	;RETURN WITH TYPE IN REGISTER A
	CMP	A	;CLEAR THE ZERO FLAG
	RET
;
NGET:	;CAN'T FIND THE ENTRY, RETURN WITH ZERO FLAG RESET
	POP	D	;GET THE ELEMENT BACK
	XRA	A	;CLEAR
	INR	A	;ZERO FLAG RESET
	RET
;
;
ENDMOD	EQU	($ AND 0FFE0H) + 20H	;NEXT MODULE ADDRESS
	END
