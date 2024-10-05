.title	[Programmable Function Key Utility for QX+]
.ident	PFUN
.Xlist	;surpress listing

.IF1,[ .PRNTX "Assembly pass no.1" ]
     [ .PRNTX "Assembly pass no.2" ]

;A.R.M.CLARKE Feb 1984
;Copyright (C) 1984

;----------------------------------------------------------------------------
.define hi.there  =	[
		This utility allows you to change the strings assigned
	to  each programmable function key or cursor control key.  You
	can make temporary changes or permanent changes. The permanent
	changes can be put in the version of CPM3.SYS by CONFIG or can
	be  saved by this program for later invocation by the  command
	"PFKSET A <filename>" or for subsequent editing sessions. This
	program  can  be  used to keep several different  programmable
	function  key assignments for special purposes.  The  standard
	settings can be restored by typing "PFKSET  Default"
]


;----------------------------------------------------------------------------

;*** Absolute addresses ***
bdos	=	0005H	;CP/M entry point
BIOS	=	0001H
BDOS	=	0005H
BOOT	=	0000H
DFCB	=	005CH
DBUF	=	0080H

.IF1,[ .PRNTX "+1" ]
     [ .PRNTX "*1" ]
;file markers


;*** Macros ***

.define	string	[M$]=[
	.byte	@m$
	.asciz	m$
	]
	

;*** Logical constants ***
False	=	0000H	;not true
True	=	0FFH	;not exactly false


;*** Ascii codes ***
CR	=	0DH	;Carriage return
LF	=	0AH	;line feed
EOF	=	1AH	;end of file code
FF	=	0CH
ESC     = 	1BH	;ESCAPE CHAR FOR CURSOR CONTROL
BSPACE  =	08	;BACKSPACE
TAB     =	09H	;Tab
PRO.MAX	=	30	;max letters in prompt
rec.max	=	128-4-3


;*** Cursor control codes ***
.IF1,[ .PRNTX "+2" ]
     [ .PRNTX "*2" ]
;file markers


	.ASCII	"COPYRIGHT MML Ltd (C) 1983"
;*** ALL PATCHES AS IN WORDSTAR ***
clear:	.byte	02,27,'+',00,00,00	;Clear screen string
CLEAD1:	.BYTE	02,27,61		;YX cursor addressing lead-in
	.BYTE	00,00,00,00,00,00
CLEAD2:	.BYTE	00,00,00,00,00,00	;between params
CTRAIL:	.BYTE	00,00,00,00,00,00	;trailing string
CB4LFG:	.BYTE	false			;Y before X or X before Y?
LINOFF:	.BYTE	20H			;Offset to add
COLOFF:	.BYTE	20H

;*** OTHER VDU PATCHES IN ADDITION ***
char.starting.highlight:
	.byte	"("
;for menu selection

char.finishing.highlight:
	.byte	")"
;for menu selection
	
uscore:	.byte	'_'
IVONº	.BYTÅ	02,27,"0",00,00,00,00
IVOFF:	.BYTE	04,27,"1",27,"5",00,00
IVON2:	.BYTE   02,27,"4",00,00,00,00 
;if incapable of doing a second enhancement then it underlines
;so if first byte is zero it then assumes underline
set.high.bit:	.byte	00h	;set to true if
;enhancement 2 is by setting the high bit

.IF1,[ .PRNTX "+3" ]
     [ .PRNTX "*3" ]
;file markers


shall.we.place.the.real.cursor:
		.byte	0ffh	;to place real cursor
;at the editing position 

;cursor turn off/on strings
on.cursor:	.byte	02,1bh,'3',00	;Switch on the cursor
off.cursor:	.byte	02,1bh,'2',00	;switch off the cursor

;screen switching strings
Upper.screen:	.byte	2,1bH,"U",00	;switch to upper screen
Lower.screen:	.byte	2,1BH,"V",00	;switch to lower screen

;mode switching strings
GRFiKS:		.byte	2,1BH,'G',00	;Enter graphics
no.grfix:	.byte	2,1bh,'H',00	;Exit graphics mode


;*** Variables ***


	
COLUMN:	.BYTE	00	;column on VDU
LINE:	.BYTE	00	;line on VDU

changed:	.byte	00	;have we changed anything?

SKIPPD:	.BYTE	TRUE
OLDSP:	.WORD	00
EDTCOL:	.BYTE	00
EDTLIN:	.BYTE	00
MARGIN:	.BYTE	00
STARTLINE: .BYTE 00
STR.ARRAY: .WORD 00
OFFSET:	.WORD	00
HIGHLT:	.BYTE	00
FLIP.FLOP: .BYTE 0FFH
maximum:   .byte 00
do.we.set.the.high.bit:	.byte	00	;to get enhancement
ch.starting:	.byte	" "
ch.finishing:	.byte	" "
I.A.P:		.WORD	PFK.Array.Pointer	;input array pointr
PSEUDO.CURSOR:	.BYTE	0	;offset into str.
ACTIVE:		.BYTE	0	;active string no.		
BASE.OF.ARRAY:	.WORD	PFK.Array.Pointer	;Pointer to array
L.A.P:		.WORD	.label.array.pointer	;label array pointr
LAB.DISPLAY:	.BYTE	0	;flag for highlight label
ACT.FIELD:	.BYTE	0	;currently selected field
REC.ADDRESS:	.WORD	0	;Address of current record

.IF1,[ .PRNTX "+4" ]
     [ .PRNTX "*4" ]
;file markers

;---------------------------------------------------------------------------
YXPOS:	;sends the character cursor to the location in Line Column
	PUSH	H
	PUSH	D
	PUSH	B	;save everything
	LXI	H,CLEAD1	;print lead-in
	CALL	MSG
	LDA	CB4LFG	;Do we do X or Y first?
	ANA	A
	JNZ	..REV	;Line first
	LDA	Line	;get line no.
	MOV	B,A
	LDA	LINOFF
	ADD	B	;addin line offset
	CALL	TYO	;out it goes
	LXI	H,CLEAD2	;get mid lead-in
	CALL	MSG	;send it
	LDA	Column	;get column
	MOV	C,A
	LDA	COLOFF	;add in offset
	ADD	C
	CALL	TYO	;send it out
..END:	LXI	H,CTRAIL	;job done so send trailing string
	CALL	MSG
	POP	B	;restore the world
	POP	D
	POP	H
	RET	;and go home

..REV:	LDA	Column	;do things backwards
	MOV	C,A	;for potty terminals
	LDA	COLOFF
	ADD	C
	CALL	TYO
	LXI	H,CLEAD2
	CALL	MSG
	LDA	Line
	MOV	B,A
	LDA	LINOFF
	ADD	B
	CALL	TYO
	JMP	..END



;*** HILTON TURNS THE TERMINAL HIGHLIGHT ***
;*** SPECIFIED BY IVON, ON; HILTOF OFF   ***
HILTON:	PUSH	H
	PUSH	D
	PUSH	B
	lda	char.starting.highlight
	sta	ch.starting
	lda	char.finishing.highlight
	sta	ch.finishing
	LXI	H,IVON
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

HILTOFF:PUSH	H
	PUSH	D
	PUSH	B
	mvi	a," "
	sta	ch.starting
	sta	ch.finishing
	lda	set.high.bit
	ana	a
	LXI	H,IVOFF
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

ALTON:  PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,IVON2
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET


gra.off:	;turn into character mode

	PUSH	H	;save the world
	PUSH	D
	PUSH	B
	LXI	H,no.grfix	;the no graphics string
	CALL	MSG	;to switch into character mode
	POP	B	;restore the world
	POP	D
	POP	H
	RET
	
curon:
	PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,on.cursor	;switch cursor on 
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

	
curoff:	;switch off the cursor
	  PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,off.cursor	;string to tell the console
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

screen.clear:	;clear the whole damned screen
	PUSH	H
 	PUSH	D
	PUSH	B
	LXI	H,clear
	CALL	MSG	;send out clear-screen string
	POP	B
	POP	D
	POP	H
	RET
	
.IF1,[ .PRNTX "+5" ]
     [ .PRNTX "*5" ]
;file markers


.REMARK	"  These are the fundemental BIOS interaction
routines"

	.DEFINE	BIOS	[A$,OFFSET]=[
A$:	LHLD	0001H
	LXI	D,OFFSET
	DAD	D
	PCHL	]

BIOS	CONST,3	;define console status routine
BIOS	CONIN,6	;and the console input routine
BIOS	CONOUT,9	;and the console output routine
bios	list,12	;and the printer output call

;*** BASIC CONSOLE I/O ROUTINES ***

TYO:	push	h	;send the byte in A to the console
	push	d
	push	b
	MOV	C,A
	call	CONOUT	;out it goes
	pop	b
	pop	d
	pop	h
	ret	;we saved the registers

lyo:	mov	c,a
	jmp	list	;print the byte in A on the printer

TYI:	push	h	;get the character from the keyboard
	push	d
	push	b
	call	CONIN	;get the character from the BIOS
	pop	b
	pop	d
	pop	h
	ret


;----------------------------------------------------------------------------
MSG:	MOV	A,M	;print String preceded by a count byte
	MOV	B,A	;get count byte
	ORA	A	;is it a null string
	RZ	;if null string, then go home
..LOOP:	INX	H	;point to next ASCII byte
	MOV	A,M	;get it
	PUSH	H
	PUSH	B
	CALL	TYO	;send it to the console
	POP	B
	POP	H
	DCR	B	;any more to do
	RZ	;if not go home
	JMP	..LOOP	;otherwise do the next byte



.REMARK " *** PRINT IN LINE MACRO ***"
;This has the syntax PRINT "STRING."
SAY:	POP	H
..LOOP:	MOV	A,M	;get the byte
	INX	H	;point to string or next instruction
	ANA	A	;was it a null
	JZ	..EXIT	;if so then string is ending
	PUSH	H	;otherwise we must print it
	call	tyo	;on the console
	POP	H
	JMP	..LOOP
..EXIT:	PCHL	;lets jump to that instruction
	.DEFINE PRINT [A$]=[
	CALL	SAY	;print in-line
	.ASCIZ	A$]

.IF1,[ .PRNTX "+6" ]
     [ .PRNTX "*6" ]
;file markers

;----------------------------------------------------------------------------
AddHL:	;adds A to HL and leaves the result in HL
	add	l
	mov	l,a
	rnc
	inr	h
	ret

;----------------------------------------------------------------------------
move:	;do an intelligent move from (HL) to (DE), BC bytes
	mov	a,c
	ora	b	;nothing to do if BC=Zero
	rz
	call	 cmp16
	rz	;as there is nothing to do
	jc	..up
	ldir
	ret
..up:	dad	b
	xchg
	dad	b
	dcx	h
	dcx	d
	xchg
	lddr
	ret


;----------------------------------------------------------------------------
Cmp16:	;sixteen bit compare DE with HL
	mov	a,h
	sub	d
	rnz
	mov	a,l
	sub	e
	ret

;----------------------------------------------------------------------------
conuc:	;convert character in A to upper case if poss
	cpi	7BH
	rnc
	cpi	61H
	rc
	ani	5fh
	ret


;DSUB is the equivalent of DAD, but zero and carry
;are set and the operation is HL=HL-DE
DSUB:	MOV	A,L
	SUB	E
	MOV	L,A
	MOV	A,H
	SBB	D
	MOV	H,A
	RNZ
	INR	L
	DCR	L
	RET




;*** FINDST POINTS HL TO THE COUNT ***
;*** BYTE OF THE STRING ARRAY      ***
;*** ELEMENT SPECIFIED IN C.       ***
 
FINDST:
	INR	C
..LOOP:	DCR	C
	RZ
	PUSH	B
	MVI	B,0
	MOV	C,M
	DAD	B
	INX	H
	INX	H
	POP	B
	JMP	..LOOP

;*** TYPEST TYPES THE BC'th STRING ***
;*** IN THE ARRAY ADDRESSED BY HL  ***

TYPEST:	CALL FINDST
	CALL	MSG
	RET

;*** CURPOS PUTS THE CURSOR IN THE ***
;*** POSITION DETERMINED BY EDTCOL ***
;*** AND EDTLIN.                   ***

CURPOS:	LDA	EDTCOL
	STA	COLUMN
	LDA	EDTLIN
	STA	LINE
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	RET

.IF1,[ .PRNTX "+7" ]
     [ .PRNTX "*7" ]
;file markers


;***  draws a line across the page  ***
;***  at current line               ***
LINE.ACROSS:
	XRA	A
	STA	COLUMN
	MVI	B,79
	mvi	c,"_"
UNDER:	;does B lots of C from column and line
 	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS

UNDERL:	;does B lots of c from current cursor pos.
..LOOP:	PUSH	B
	mov	a,c
	CALL	TYO
	POP	B
	DCR	B
	JNZ	..LOOP
	RET




;*** TYPELIST TYPES, IN THE FORM    ***
;*** OF A VERTICAL LIST, AN ARRAY   ***
;*** POINTED TO BY STR.ARRAY.	    ***
;*** TOP OF LIST AT SCREEN POSITION ***
;*** DICTATED BY \INE AND COLUMN    ***
;*** ZERO SET IF LAST LIST PASSED   ***


TYPELIST:
	LDA	LINE
	STA	STARTLINE
	LDA	COLUMN
	STA	MARGIN
	LHLD	STR.ARRAY
	MOV	A,M
	ANA	A
	RZ
	MOV	B,A
	INX	H
	XRA	A
	MOV	C,A
..LOOP:	PUSH	B
	PUSH	H
	LDA	MARGIN
	ana	a
	jz	..over
	dcr	a
..over:	STA	COLUMN
	XRA	A
	DCR	A
	STA	SKIPPD
	CALL	YXPOS
	LDA	HIGHLT
	CMP	C
	PUSH	PSW
	CZ	HILTON
	lda	ch.starting
	push	b	
	push	h
	call	tyo
	pop	h
	pop	b
	CALL	TYPEST
	lda	ch.finishing
	call	tyo
	POP	PSW
	CZ	HILTOF
	POP	H
	POP	B
	LDA	LINE
	INR	A
	STA	LINE
	INR	C
	DCR	B
	JNZ	..LOOP
	LDA	MARGIN
	STA	COLUMN
	LDA	STARTLINE
	STA	LINE
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	RNZ
	INR	A
	RET



	
CHOOSE.IT:	
	CALL	TYPELIST
	RZ
	CALL	TYI
	CPI	05H
	JZ	..UP
	CPI	18H
	JZ	..DOWN
	CPI	0DH
	JZ	..EXIT
	JMP	..UPDN
..EXIT:	INR	A
	RNZ	
	INR	A
	RET


..DOWN:	MVI	A,FALSE
	STA	FLIP.FLOP
	LHLD	STR.ARRAY
	MOV	B,M
	DCR	B
	LDA	HIGHLT
	CMP	B
	JZ	CHOOSE.IT
	INR	A
	STA	HIGHLT
	MVI	A,TRUE
	STA	FLIP.FLOP
	JMP	CHOOSE.IT

..UP:	MVI	A,TRUE
	STA	FLIP.FLOP
	LDA	HIGHLT
	ANA	A
	JZ	CHOOSE.IT
	DCR	A
	STA	HIGHLT
	MVI	A,FALSE
	STA	FLIP.FLOP
	JMP	CHOOSE.IT
	
..UPDN:	LDA	FLIP.FLOP
	ANA	A
	JZ	..UP
	JMP	..DOWN



PROMPT:	;types the string pointed to by HL as a
;prompt for the command string

	MVI	A,PRO.MAX
	mov	B,M
	SUB	B
	DCR	A
	RM
	STA	COLUMN
	MVI	A,03
	STA	LINE
	STA	SKIPPD
	CALL	YXPOS
	CALL	MSG
	RET
	
.IF1,[ .PRNTX "+8" ]
     [ .PRNTX "*8" ]
;file markers



.DEFINE INPUT.FIELD [ FIELD.LENGTH,LINE,COL,STR]=[
	.BYTE	FIELD.LENGTH
	.BYTE	LINE
	.BYTE	COL
	.BYTE	@STR
	.ASCIZ	STR
	.BLKB	FIELD.LENGTH+1-@STR  ]

	.BYTE	01
;
.DEFINE LABEL.FIELD [ LINE,COL,A$ ]=[
	.BYTE	LINE
	.BYTE	COL
	.BYTE	@A$
	.ASCIZ	A$]

NO.LABELS:	.BYTE	19
.label.array.pointer:
LABEL.FIELD	02,10,"F1 Key:-"
LABEL.FIELD	03,10,"F2 Key:-"
LABEL.FIELD	04,10,"F3 Key:-"
LABEL.FIELD	05,10,"F4 Key:-"
LABEL.FIELD	06,10,"F5 Key:-"
LABEL.FIELD	07,10,"F6 Key:-"
LABEL.FIELD	08,10,"F7 Key:-"
LABEL.FIELD	09,10,"F8 Key:-"
LABEL.FIELD	10,10,"F9 Key:-"
LABEL.FIELD	11,09,"F10 Key:-"
LABEL.FIELD	13,04,"Up Arrow Key:-"
LABEL.FIELD	14,02,"Left Arrow Key:-"
LABEL.FIELD	15,01,"Right Arrow Key:-"
LABEL.FIELD	16,02,"Down Arrow Key:-"
LABEL.FIELD	18,09,"INS Key:-"
LABEL.FIELD	19,08,"HOME Key:-"
LABEL.FIELD	20,09,"CLS Key:-"
LABEL.FIELD	21,09,"000 Key:-"
LABEL.FIELD	22,08,"HELP Key:-"





COMMAND.LINE:	

INPUT.FIELD	58,03,PRO.MAX," "

NO.ELEMENTS:	.BYTE	19

PFK.Array.Pointer:

INPUT.FIELD	13,02,20,"DIR "
INPUT.FIELD	13,03,20,"TYPE "
INPUT.FIELD	13,04,20,"ERASE "
INPUT.FIELD	13,05,20,"SHOW "
INPUT.FIELD	13,06,20,"SID "
INPUT.FIELD	13,07,20,"PIP "
INPUT.FIELD	13,08,20,"DUMP "
INPUT.FIELD	13,09,20,"SETDEF "
INPUT.FIELD	13,10,20,"DEVICE "
INPUT.FIELD	13,11,20,"MBASIC "
INPUT.FIELD	06,13,20,"^^"

;	06,14,20,tricky -bracket problem
	.BYTE	06
	.BYTE	14
	.BYTE	20
	.BYTE	02
	.ASCIi	[^H5E] [^H5D] [00]
	.BLKB	06+1-02

INPUT.FIELD	06,15,20,"^\"
INPUT.FIELD	06,16,20,"^_"
INPUT.FIELD	06,18,20,"^R"
INPUT.FIELD	06,19,20,"^K"
INPUT.FIELD	06,20,20,"^L"
INPUT.FIELD	06,21,20,"000"
INPUT.FIELD	14,22,20,"HELP^M^J"
top.ia:


.IF1,[ .PRNTX "+9" ]
     [ .PRNTX "*9" ]
;file markers






IA.IN.HL:
	push	psw
	PUSH	D
	XCHG
	LHLD	I.A.P
	DAD	D
	lxi	d,top.ia
	call	cmp16
	jnc	0000
	POP	D
	pop	psw
	RET

.DEFINE I.A.REF [A$,OFFSET]=[
$'A$:	LXI	H,OFFSET
	JMP	IA.IN.HL
	.DEFINE A$ =[
	CALL	$'A$
	]]
.DEFINE	MAX =[ LHLD I.A.P ]
	I.A.REF  YLOC ,1
	I.A.REF  XLOC ,2
	I.A.REF  STRLOC,3



DO.POINT: ;places in I.A.P, an address that points
;to the array element specified by the contents 
;of ACTIVE ie makes ACTIVE active!

	LDA	ACTIVE
POINT::
	 ;makes the Ath element active
	MOV	B,A
	LHLD	BASE.OF.ARRAY
..LOOP:	SHLD	I.A.P
	MOV	A,B
	ANA	A
	RZ
	MAX
	MVI	D,0
	MOV	E,M
	DAD	D
	MVI	E,6
	DAD	D
	DCR	B
	JMP	..LOOP

PR.ELEMENT: ;prints active element at specified
;spot
	MAX
	MOV	C,M
	Lda	Pseudo.cursor	;offset
	CMP	C
	JM	..HOP
	DCR	C
	MOV	A,C
	STA	PSEUDO.CURSOR
..HOP:	INX	H
	MOV	A,M
	STA	LINE
	INX	H
	MOV	A,M
	STA	COLUMN
	INX	H
	MOV	B,M
	Lda	Pseudo.cursor	;offset
	SUB	B
	DCR	A
	DCR	A
	JM	..SKIP
	MOV	A,B
	INR	A
	STA	PSEUDO.CURSOR
..SKIP:	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	MVI	C,0
	MOV	A,B
	ANA	A
	JZ	..END
..LOOP:	INR	C
	Lda	Pseudo.cursor	;offset
	SUB	C
	PUSH	PSW
	CZ	HILTON
	INX	H
	MOV	A,M
	PUSH 	h
	PUSH	B
	CALL	TYO
	POP	B
	POP	H
	POP	PSW
	CZ	HILTOFF
	DCR	B
	JZ	..END	
	JMP	..LOOP
..END:	Lda	Pseudo.cursor	;offset
	INR	C
	SUB	C
	PUSH	PSW
	CZ	HILTON
	MVI	A,' '
	CALL	TYO
	POP	PSW
	CZ	HILTOFF
	MVI	A,' '
	CALL	TYO
	RET

	
PR.ALL: ;print all the elements
	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	B,M
	MVI	C,0
	XRA	A
	STA	PSEUDO.CURSOR
..LOOP:	MOV	A,C
	PUSH	B
	CALL	POINT
	CALL	PR.ELEMENT
	POP	B
	INR	C
	DCR	B
	JNZ	..LOOP
	RET

DO.EDIT: ; Jumps to routine according to the 
;character input

	lda	shall.we.place.the.real.cursor
	ana	a
	jnz	..position.it
	MVI	A,1
	STA	LINE
	MVI	A,1
	STA	COLUMN
..go.back:
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	CALL	TYI
	CPI	127
	JZ	DELETE
	CPI	32
	JP	INSERT
	LXI	H,TABLE
	ANA	A
..BACK:	JZ	..GETAD
	INX	H
	INX	H
	DCR	A
	JMP	..BACK	
	
..GETAD:
	MOV	E,M
	INX	H
	MOV	D,M
	XCHG
	PCHL

..position.it:
	yloc
	mov	a,m
	sta	line
	Lda	Pseudo.cursor	;offset
..HOP:	INX	H
	add	m
	dcr	a
	sta	column
	jmp	..go.back

	
TABLE:	.WORD	DO.EDIT	;null
	.WORD	CTLA	;control A
	.WORD	DO.EDIT	;control B
	.WORD	CTLC	;control C
	.WORD	CTLD	;control D
	.WORD	CTLE	;control E
	.WORD	CTLF	;control F
	.WORD	CTLG	;control G
	.WORD	CTLS	;control H
	.WORD	CTLI	;control I
	.WORD	DO.EDIT	;control J
	.WORD	DO.OUT	;control K
	.WORD	DO.EDIT	;control L
	.WORD	CTLM	;control M
	.WORD	DO.EDIT	;control N
	.WORD	DO.EDIT	;control O
	.WORD	DO.EDIT	;control P
	.WORD	DO.OUT  ;control Q
	.WORD	CTLR	;control R
	.WORD	CTLS	;control S
	.WORD	CTLT	;control T
	.WORD	CTLU	;control U
	.WORD	CTLV    ;control V
	.WORD	DO.EDIT	;control W
	.WORD	CTLX	;control X
	.WORD	CTLY	;control Y
	.WORD	DO.EDIT	;control Z 	1AH
	.WORD	do.out	;ESC		1BH
	.WORD	CtlD	;		1CH
	.WORD	CtlS	;		1DH
	.WORD	CtlE	;control ^	1EH
	.word	CtlX	;		1FH





DO.OUT:	;exit from edit function

	XRA	A
	STA	PSEUDO.CURSOR
	CALL	PR.ELEMENT
	RNZ
	INR	A
	RET

BACK:	CALL	PR.ELEMENT
	JMP	DO.EDIT

UPDATE:	STA	ACTIVE
	XRA	A
	STA	PSEUDO.CURSOR
	CALL	PR.ELEMENT
	CALL	DO.POINT
	XRA	A
	INR	A
	STA	PSEUDO.CURSOR
	JMP	BACK

INIT:	XRA	A
	STA	ACTIVE
	INR	A
	STA	PSEUDO.POINTER
	CALL	DO.POINT
	CALL	PR.ELEMENT
	xra	a
	STA	$INSERT
	JMP	CTLV

PASTE:	;Moves the string up or down one from the
;position indicated by pseudo.cursor.
;Non zero in A is delete, zero is insert

	PUSH	PSW
	Lda	Pseudo.cursor	;offset
	MOV	B,A
	MOV	E,A
	MAX
	MOV	A,M
	SUB	B
	DCR	A
	MOV	C,A
	MVI	B,0
	StrLoc	;point HL to count byte
	MVI	D,0
	DAD	D
	MOV	D,H
	MOV	E,L
	INX	D
	POP	PSW
	ANA	A
	JZ	..ON
	XCHG
..ON:	CALL	MOVE
	RET

CTLA:	Lda	Pseudo.cursor	;offset
	MOV	B,A
	DCR	B
	JZ	DO.EDIT
	MOV	E,A
	ANA	A
	JZ	DO.EDIT
	StrLoc	;point HL to count byte
	DCR	E
	MVI	D,0
	DAD	D
..BACK:	MOV	A,M
	DCR	E
	CPI	' '
	JNZ	..ON
	CPI	','
	jz	..ON
	DCX	H
	DCR	B
	JZ	..FINI
	JMP	..BACK
..ON:	DCR	B
	JZ	..FINI
	DCR	E
	DCX	H
	MOV	A,M
	CPI	" "
	JNZ	..ON	;
	INR	E
..LEAP:	INR	E	;
..FINI:	MOV	A,E
	ANA	A
	JZ	..LEAP
	STA	PSEUDO.CURSOR
	JMP	BACK

CTLC:	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	A,M
	DCR	A
	JMP	UPDATE

CTLD:	Lda	Pseudo.cursor	;offset
	INR	A
	STA	PSEUDO.CURSOR
	JMP	BACK

CTLE:	LDA	ACTIVE
	DCR	A
	JM	BACK
	JMP	UPDATE	

CTLF:	Lda	Pseudo.cursor	;offset
	MOV	E,A
	MOV	B,A
	StrLoc	;point HL to count byte
	MOV	A,M
	ANA	A
	JZ	DO.EDIT
	SUB	B
	JM	DO.EDIT
	MOV	B,A	;B=chars to search
	MVI	D,0
	DAD	D
..BACK:	MOV	A,M
	INR	E
	CPI	' '
	JZ	..ON
	CPI	','
	jz	..ON
	INX	H
	DCR	B
	JZ	..FINI
	JMP	..BACK
..ON:	DCR	B
	JZ	..FINI
	INR	E
	INX	H
	MOV	A,M
	CPI	" "
	JZ	..ON
	DCR	E	
..FINI:	MOV	A,E
	STA	PSEUDO.CURSOR
	JMP	BACK




CTLG:	mvi	a,true
	sta	changed		;we changed the edit buffer
	StrLoc	;point HL to count byte
	MOV	A,M
	ANA	A
	JZ	DO.EDIT
	MOV	B,A
	Lda	Pseudo.cursor	;offset
	DCR	A
	CMP	B
	JZ	DO.EDIT
	PUSH	H
	XRA	A
	DCR	A
	CALL	PASTE
	POP	H
	DCR	M
	JMP	BACK	

CTLI:	mvi	a,true
	sta	changed		;we changed the edit buffer
	Lda	Pseudo.cursor	;offset
	MAX	
	MOV	B,M
	CMP	B
	JP	BACK
	INX	H
	INX	H
	INX	H
	MOV	A,M
	INR	A
	CMP	B
	JP	BACK
	XRA	A	;zero is insert
	CALL	PASTE
	Lda	Pseudo.cursor	;offset
	StrLoc	;point HL to count byte
	INR	M
	MOV	E,A
	MVI	D,0
	INR	A
	STA	PSEUDO.CURSOR
	DAD	D
	MVI	M,' '
 	XLOC
	ADD	M
	ANI	07H
	JNZ	CTLI
	JMP	BACK
	
CTLM:	LDA	ACTIVE
	MOV	B,A
	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	A,M
	DCR	A
	DCR	A
	CMP	B
	JM	DO.OUT
	MOV	A,B
	INR	A
	JMP	UPDATE


CTLR:	XRA	A
	JMP	UPDATE


CTLS:	Lda	Pseudo.cursor	;offset
	DCR	A
	JZ	BACK
	STA	PSEUDO.CURSOR
	JMP	BACK

CTLT:	mvi	a,true
	sta	changed		;we changed the edit buffer
	Lda	Pseudo.cursor	;offset
	MOV	E,A
	StrLoc	;point HL to count byte
	MOV	A,M
	MOV	C,A
	ANA	A
	JZ	DO.EDIT
	SUB	E
	JM	DO.EDIT
	MOV	B,A	
	INR	B	;B= Max no. of chars to do
	MVI	D,0
	DAD	D
..BACK:	MOV	A,M
	CPI	' '
	JZ	..ON
	CPI	','
	jz	..ON
	PUSH	H
	PUSH	B
	XRA	A
	DCR	A
	CALL	PASTE	
	POP	B
	POP	H
	DCR	C
	DCR	B
	JZ	..FINI
	JMP	..BACK
..ON:	PUSH	H
	PUSH	B
	XRA	A
	DCR	A
	CALL	PASTE	
	POP	B
	POP	H
	DCR	C
	DCR	B
	JZ	..FINI
	MOV	A,M
	CPI	" "
	JZ	..ON
..FINI:	StrLoc	;point HL to count byte
	MOV	A,M
	MOV	M,C
	SUB	C
	JZ	BACK	
	PUSH	PSW
	CALL	PR.ELEMENT
	POP	PSW
	MOV	C,A
..SKIP:	DCR	C
	JZ	DO.EDIT
	PUSH	B
	MVI	A,' '
	CALL	TYO
	POP	B
	JMP	..SKIP

	
CTLU:	CALL	..ON
	.ASCII	[39] "     *** INTERRUPTED,Press ESC   ***   "
..ON:	POP	H
	CALL	..CALL	
	CALL	TYI
	CPI	27
	jz	alloff
	CALL	..HOP
	.ASCII	[39] "                                       "
..HOP:	POP	H
	CALL	..CALL
	JMP	DO.EDIT
	
..CALL:	MVI	A,1
	STA	LINE
	MVI	A,5
	STA	COLUMN
	MVI	A,TRUE
	STA	SKIPPD
	PUSH	H
	CALL	YXPOS
	POP	H
	CALL	MSG
	RET

alloff:
	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	a,m
..loop:	ana	a
	rz
	dcr	a
	push	psw	
	CALL	POINT
	CALL	WIPE.OUT
	pop	psw
	JMP	..LOOP


CTLV:	LDA	$INSERT
	CMA	
	PUSH	PSW
	STA	$INSERT
	MVI	A,1
	STA	LINE
	MVI	A,56
	STA	COLUMN
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	LXI	H,NINE.BLANKS
	POP	PSW
	ANA	A
	JZ	..ON
	LXI	H,IN.ON
..ON:	CALL	MSG
	JMP	DO.EDIT

$INSERT: .BYTE FALSE

CTLX:	LDA	ACTIVE
	MOV	B,A
	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	A,M
	DCR	A
	DCR	A
	CMP	B
	JM	BACK
	MOV	A,B
	INR	A
	JMP	UPDATE

CTLY:	mvi	a,true
	sta	changed		;we changed the edit buffer
	StrLoc	;point HL to count byte
	MOV	A,M
	ANA	A
	JZ	DO.EDIT
	DCX	H
	DCX	H
	MOV	A,M
	STA	LINE
	INX	H
	MOV	A,M
	STA	COLUMN
	INX	H
	MOV	B,M
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	INR	B
..LOOP:	MVI	A,' '
	PUSH	B
	CALL	TYO
	POP	B
	DCR	B
	JZ	..ON	
	JMP	..LOOP
..ON:	StrLoc	;point HL to count byte
	XRA	A
	MOV	M,A
	INX	H
	MOV	M,A
	XRA	A
	INR	A
	STA	PSEUDO.CURSOR
	JMP	BACK

;----------------------------------------------------------------------------
INSERT:	;an ascii character at position indicated by pseudo.cursor
	PUSH	PSW		;save the character
	mvi	a,true
	sta	changed
	MAX
	MOV	B,M		;maximum allowed in B
	StrLoc	;point HL to string location
	MOV	C,M		;B has maximum, C has the count of string
	Lda	Pseudo.cursor	;offset
	CMP	B		;at the maximum?
	JP	..BAD		;if so abort
	PUSH	PSW
	LDA	$INSERT		;are we inserting or overtyping?
	ANA	A
	JNZ	DO.INSERT	;if inserting
	POP	PSW
	INR	C
	CMP	C
	JM	..ON		;if the pseudo cursor is at the end
	INR	M
..ON:	MOV	E,A
	MVI	D,0
	INR	A
	STA	PSEUDO.CURSOR	;update pseudo cursor
	DAD	D
	POP	PSW
	MOV	M,A		;and send out the byte
 	JMP	BACK
..BAD:	POP	PSW	;we cannot put the byte into the field so ignore
	JMP	BACK

;----------------------------------------------------------------------------
DO.INSERT: ; Insert char. at top-1
;B contains max, C contains count
;Top has pseudo.cursor

	DCR	B
	DCR	B
	MOV	A,B
	CMP	C
	JM	..BAD	;room for one more?
	XRA	A	;zero is insert
	CALL	PASTE
	POP	PSW
	StrLoc	;point HL to count byte
	INR	M	;increment the count
	MOV	E,A
	MVI	D,0
	INR	A
	STA	PSEUDO.CURSOR	;and the pseudo cursor
	DAD	D
	POP	PSW		;get the character
	MOV	M,A		;and put it in the string
 	JMP	BACK
..BAD:	POP	PSW
	POP	PSW
	JMP	BACK



DELETE:	StrLoc	;point HL to count byte
	MOV	A,M
	ANA	A
	JZ	DO.EDIT
	sta	changed
	Lda	Pseudo.cursor	;offset
	DCR	A
	JZ	DO.EDIT
	STA	PSEUDO.CURSOR
	PUSH	H
	XRA	A
	DCR	A
	CALL	PASTE
	POP	H
	DCR	M
	JMP	BACK	


WIPE.OUT:
			
	StrLoc	;point HL to count byte
	MOV	A,M
	ANA	A
	RZ
	DCX	H
	DCX	H
	dcx	h
	mov	c,m
	inx	h
	MOV	A,M
	STA	LINE
	INX	H
	MOV	A,M
	STA	COLUMN
	INX	H
	MOV	B,M
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	INR	B
..LOOP:	MVI	A,' '
	PUSH	B
	CALL	TYO
	POP	B
	DCR	B
	JZ	..ON	
	dcr	c
	jp	..LOOP
..ON:	StrLoc	;point HL to count byte
	XRA	A
	MOV	M,A
	INX	H
	MOV	M,A
	RET

	
WIPE.ALL: ;Rub out everything in the input array

	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	B,M
	MVI	C,0
	XRA	A
	STA	PSEUDO.CURSOR
..LOOP:	MOV	A,C
	PUSH	B
	CALL	POINT
	CALL	WIPE.OUT
	POP	B
	INR	C
	DCR	B
	JNZ	..LOOP
	RET
	

		;*** ASCII STRING AREA ***

IN.ON:	STRING	"INSERT ON"
NINE.BLANKS:
	STRING	"         "

;
;
;

.DEFINE	STRLAB =[ LHLD L.A.P ]
LAB.AD:	.WORD	.label.array.pointer

LAB.POINT: ;places in L.A.P, an address that points
;to the array element specified by the contents 
;of ACTIVE ie makes ACT.FIELD active!

	LDA	ACT.FIELD
A.POINT: ;makes the Ath element active
	MOV	B,A
	LHLD	LAB.AD
..LOOP:	SHLD	L.A.P
	MOV	A,B
	ANA	A
	RZ
	STRLAB
	INX	H
	INX	H
	MVI	D,0
	MOV	E,M
	DAD	D
	INX	H
	INX	H
	DCR	B
	JMP	..LOOP

PR.LABEL: ;prints active LABEL at specified
;spot
	STRLAB
	MOV	A,M
	STA	LINE
	INX	H
	MOV	A,M
	STA	COLUMN
	INX	H
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	CALL	ALTON    
	LDA	LAB.DISPLAY
	ANA	A
	PUSH	PSW
	CNZ	HILTON
	CALL	MSG
	POP	PSW
	CALL	HILTOFF
	STRLAB
	MOV	A,M
	INR	A
	STA	LINE
	INX	H
	MOV	A,M
	STA	COLUMN
	INX	H
	MOV	B,M
	lda	ivon2
	ana	a
	rnz	;return if not underlining
	lda	uscore
	mov	c,a
	CALL	UNDER
	RET

	
P.A.L:  ;print all the elements
	LHLD	LAB.AD
	DCX	H
	MOV	B,M
	MVI	C,0
	XRA	A
	STA	LAB.DISPLAY
..LOOP:	MOV	A,C
	PUSH	B
	CALL	A.POINT
	CALL	PR.LABEL
	POP	B
	INR	C
	DCR	B
	JNZ	..LOOP
	RET

NEW.SEL:
	STA	ACT.FIELD
	XRA	A
	STA	LAB.DISPLAY
	CALL	PR.LABEL
	CALL	LAB.POINT
	XRA	A
	INR	A
	STA	LAB.DISPLAY
	JMP	GO.BACK

LCTLE:	LDA	ACT.FIELD
	DCR	A
	JP	NEW.SEL	
	MVI	A,TRUE
	STA	FLIP.FLOP
	JMP	GO.BACK

LCTLX:	LDA	ACT.FIELD
	MOV	B,A
	LHLD	LAB.AD
	DCX	H
	MOV	A,M
	DCR	A
	DCR	A
	CMP	B
	JM	..ON
	MOV	A,B
	INR	A
	JMP	NEW.SEL
..ON:	MVI	A,FALSE
	STA	FLIP.FLOP
	JMP	GO.BACK

	
LANY:	LDA	FLIP.FLOP
	ANA	A
	JZ	LCTLE
	JMP	LCTLX

CRRET:	XRA	A
	STA	LAB.DISPLAY
	CALL	PR.LABEL
	RET

LAB.CHOOSE:
	XRA	A
	STA	LAB.DISPLAY
	CALL	P.A.L
	XRA	A
	STA	ACT.FIELD
	DCR	A
	STA	LAB.DISPLAY
	CALL	LAB.POINT
GO.BACK:
	CALL	PR.LABEL
	MVI	A,0
	STA	LINE
	MVI	A,0
	STA	COLUMN
	MVI	A,TRUE
	STA	SKIPPD
	CALL	YXPOS
	CALL	TYI	
	CPI	24
	JZ	LCTLX
	CPI	5
	JZ	LCTLE
	CPI	13
	JZ	CRRET
	JMP	LANY




;--------------------------------------------------
; *** string manipulation words for I/O of ***
; *** records                              ***





GET.FIELD: ;HL should point to the first character
;of the string, or the delimeting comma. It puts 
;the string in location pointed to by DE, up to 
;B bytes. Zero set if no good.

	mov	a,b
	ana	a
	rz
	MVI	C,'"'
	MOV	A,M
	ANA	A
	RZ
	INX	H
	CPI	","
	JNZ	..ON
	MOV	A,M
	CPI	","
	JZ	null
	inx	h
..ON:	CMP	C
	JZ	STORE.STRING
	DCX	H
..HOP:	MVI	C,","

STORE.STRING: ;stores the string pointed by HL
;until delimeter stored in C. as a string pointed
;to by DE up to B characters. Zero set if no good
;     on exit, B= updated character count
;              HL points to the end of the delimeted
;	       DE points to the start of stored str.

	MOV	A,B
	ANA	A
	JP	..ONTO
	XRA	A
	RET	
..ONTO:	INX	D
	PUSH	D
..BACK:	MOV	A,M
	CMP	C
	JZ	..ON
	ANA	A
	JZ	..ON
	jm	..on
	push	h
	lxi	h,maximum
	dcr	m
	pop	h
	jm	..nogud
	STAX	D
	inx	d
..nogud:
	inx	h
	DCR	B
	JNZ	..BACK

..ON:	mvi	a,'"'
	cmp	c
	jnz	..hop
	inx	h
..hop:	XRA	A
	STAX	D	;top of stored string
	MOV	A,B
	MOV	C,L
	MOV	B,H
	POP	H
	PUSH	PSW	
	XCHG
	CALL	DSUB	;HL=HL-DE
	DCX	D
	MOV	A,L
	STAX	D
	MOV	L,C	;save top of string
	MOV	H,B
	POP	PSW
	MOV	B,A
	ANA	A
	RNZ		;ensure flags and A are nonz
	INR	A
	RET


null:	xra	a
	STAX	D
	INX	D
	STAX	D
	DCX	D
	INR	A
	RET


G.REC: ;gets the next record of the file from the
;buffer and stores each field as a string in the 
;input array ,

	LHLD	REC.ADDRESS
	XRA	A
	STA	..DONE.SO.FAR
	MOV	B,M
	inr	b
	INR	B
..LOOP:	INX	H
	DCR	B
	RZ
	RM
	PUSH 	H
	PUSH	B	
	LDA	..DONE.SO.FAR
	MOV	B,A
	PUSH	H
	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	A,M
	POP	H
	CMP	B
	JZ	..HOP
	MOV	A,B
	CALL	POINT
;	CALL	WIPE.OUT
	max
	mov	a,m
	sta	maximum
	inx	h
	inx	h
	inx	h
	POP	B
	POP	D
	XCHG
	CALL	GET.FIELD
	JZ	..SKIP
	dcx	h
	PUSH	H
	LXI	H,..DONE.SO.FAR
	INR	M
	POP	H
	JMP	..LOOP
..HOP:	POP	B
	POP	B
..SKIP:	INR	A
	RET

..DONE.SO.FAR:  .BYTE 00

BUFFO: ;put byte in output buffer. byte in A
;goes into the output buffer

	call	CONUC
	PUSH	PSW
	LHLD	REC.ADDRESS
	LDA	I.I.F.I.R
	ANA	A
	JZ	..ON
	MVI	M,0
..ON:	MOV	E,M
	mvi	a,rec.max
	inr	a
	cmp	e
	jm	..overflow
	INR	M
	MVI	D,0
	DAD	D
	INX	H
	POP	PSW
	MOV	M,A	
	INX	H
	XRA	A
	MOV	M,A
	XRA	A
	STA	I.I.F.I.R
	RET

..overflow:
	pop	psw
	ret

MSGBUFF: ;Put string into the output buffer
	MOV	A,M
	MOV	B,A
	ORA	A
	jnz	..loop
	sta	I.I.F.I.R
	RET
..LOOP:	INX	H
	MOV	A,M
	PUSH	H
	PUSH	B
	CALL	BUFFO
	POP	B
	POP	H
	DCR	B
	RZ
	JMP	..LOOP
	


D.I.H.A.C: ;Does it have a comma?
;zero set if the string pointed to by HL has no
; comma

	MOV	B,M
	MOV	A,B
	ANA	A
	RZ
..LOOP:	INX	H
	MOV	A,M
	CPI	','
	JZ	..ON
	DCR	B
	RZ	
	JMP	..LOOP
..ON:	DCR	A
	RET
I.I.F.I.R:	.BYTE	TRUE

OUT.STR: ;output string pointed to by HL to the
;output buffer :string is component of string array,
;and is output as ASCII CR-delimeted record field

	LDA	I.I.F.I.R	;is it first in 
	ANA	A
	JNZ	..SKIP
	MVI	A,','
	PUSH	H
	CALL	BUFFO
	POP	H
..SKIP:	PUSH	H		;record
	CALL	D.I.H.A.C
	POP	H
	PUSH	PSW
	PUSH	H
	JZ	..ON
	MVI	A,'"'
	CALL	BUFFO
..ON:	POP	H
	CALL	MSGBUFF
	POP	PSW
	RZ
	MVI	A,'"'
	CALL	BUFFO
	RET

P.REC:  ;puts the contents of the input array
;pointed to by BASE.OF.ARRAY into the output buffer
; as a proper ascii CR delimeted record

	XRA	A
	DCR	A
	STA	I.I.F.I.R
..LOOP:	INR	A
	LHLD	BASE.OF.ARRAY
	DCX	H
	CMP	M
	RP
	PUSH	PSW
	CALL	POINT
	StrLoc	;point HL to count byte
	CALL	OUT.STR
	pop	psw
	JMP	..LOOP
	

	
PFK.To.console:	;from the rec.address to the console



	LHLD	BASE.OF.ARRAY
	DCX	H
	MOV	B,M		;get the count of array elements
	MVI	C,0
..LOOP:	

	mvi	a,ESC
	call	tyo
	mvi	a,'$'
	call	tyo		;send out the preamble
	MOV	A,C
	call	tyo		;send out the function key no.
	PUSH	B
	mov	a,c
	CALL	POINT		;point to the Cth element
	StrLoc			;point HL to count byte
	MOV	c,M		;get the count byte of chars in string
;calculate no. of bytes in the real string
	mov	b,c
	inx	h
	push	h		;save pointer to string
..BACK:	MOV	A,M
	cpi	'^'		;is there a control code?
	jrnz	..hoppity
	dcr	c
	inx	h
	dcr	b
	jrz	..not.double.hat
 ..hoppity:
	INX	H
	djnz	..BACK	 
..not.double.hat:
;C has the real length
	mov	a,c
	ana	a
	jrz	..bad
	jrc	..bad
	mov	b,c
	call	tyo		;send the real count
	pop	h
..once.more:
	mov	a,m
	cpi	'^'
	jrnz	..easy
	inx	h
	mov	a,m
	ani	00011111B	;convert to control
..easy:	call	tyo
	inx	h
	djnz	..once.more
..recover:
 	POP	B
	INR	C
	djnz	..LOOP		;do another string
	RET
..bad:
	pop	h
	mvi	a,1
	call	tyo
	mvi	a,0		;fkey gives a null
	call	tyo
	jmpr	..recover

.xlist

;----------------------------------------------------------------------------
;       ***  ENTRY POINTS FOR PFK Editing Functions ***
;============================================================================



;----------------------------------------------------------------------------
Pr.Fun.Keys:	;print the contents of the function key array including labls
	LXI	H,.label.array.pointer
	SHLD	LAB.AD
	LXI	H,PFK.Array.Pointer
 	SHLD	BASE.OF.ARRAY
	CALL	P.A.L
	CALL	PR.ALL
	RET

;----------------------------------------------------------------------------
Wipe.fun.keys:	;erase the contents of the editing buffer 
	LXI	H,.label.array.pointer
	SHLD	LAB.AD
	LXI	H,PFK.Array.Pointer
 	SHLD	BASE.OF.ARRAY
	CALL	WIPE.ALL
	RET

;----------------------------------------------------------------------------
Edit.fun.keys:	;edit the contents of the PFK editing buffer
	CALL	Pr.fun.keys
	CALL	INIT
	RET

;----------------------------------------------------------------------------
Select.label:	;select one of the labels in the label array
	LXI	H,.label.array.pointer
	SHLD	LAB.AD
	LXI	H,PFK.Array.Pointer
	SHLD	BASE.OF.ARRAY
	CALL	P.A.L
	CALL	LAB.CHOOSE
	RET	

;----------------------------------------------------------------------------
Get.PFKs:	;from the buffer 
	lxi	h,our.buffer
	SHLD	REC.ADDRESS
	LXI	H,.label.array.pointer
	SHLD	LAB.AD
	LXI	H,PFK.Array.Pointer
	SHLD	BASE.OF.ARRAY
	CALL	G.REC
	RET

;----------------------------------------------------------------------------
PUT.PFKs:	;into the buffer 
	lxi	h,our.buffer
	SHLD	REC.ADDRESS
	LXI	H,.label.array.pointer
	SHLD	LAB.AD
	LXI	H,PFK.Array.Pointer
	SHLD	BASE.OF.ARRAY
	CALL	P.REC
	RET

;----------------------------------------------------------------------------
send.PFKs:	;to the console
	LXI	H,PFK.Array.Pointer
	SHLD	BASE.OF.ARRAY
	CALL	PFK.To.console
	RET	
	


;----------------------------------------------------------------------------
;		*** Machine-Specific I/O and panel functions ***
;============================================================================

 
;----------------------------------------------------------------------------
drawdown:	;the whole screen a double line
	mvi	b,23	;the number of lines
..downloop:
	push	b
	lxi	h,Line	;get where we are
	inr	m	;increment it
	call	yxpos	;and point the cursor there
	mvi	a,086H		;down line
	call	tyo	;output the byte
	pop	b
	djnz	..downloop	;and do another until B=0
	ret	;the job is all done

;----------------------------------------------------------------------------
nice.box:	;around the screen
	xra	a
	sta	Line	;zap the line position
	sta	Column	;and the column position
	call	yxpos	;home the cursor
;draw the top border	
	mvi	a,087H		;a top left border
	call	tyo	;send a top-left bracket
	mvi	b,77
..toploop:	;now do the top line across
	mvi	a,085H		;do a top line
	push	b
	call	tyo	;out goes a line character
	pop	b
	djnz	..toploop
	mvi	a,088H		;a top right border
	call	tyo	;do a top right character

;go to bottom line	
	mvi	a,24	;now do likewise for the bottom
	sta	Line
	xra	a
	sta	Column	;go to the bottom left
	call	yxpos

;draw the bottom border	
	mvi	a,089H		;a bottom left border
	call	tyo
	mvi	b,77	;and now a nice horizontal line
..botloop:
	mvi	a,085H		;do a bottom line
	push	b
	call	tyo
	pop	b
	djnz	..botloop
	mvi	a,08AH		;a bottom right border
	call	tyo

	xra	a
	sta	Column
	sta	Line	;home again
	call	drawdown
	mvi	a, 78	;we have drawn a vertical line
	sta	Column
	xra	a	;go to the top right
	sta	Line
	call	drawdown	;and do the second vertical line
	
	ret

;--------------------------------------------------
YesorNo:	;returns 0 in A if no, 0FFH if yes
	call	curon	;switch on the cursor
	call	tyi	;and get the users fumbling response
	push	psw	;remember the response
	call	curoff	;and switch off the cursor
	POP	PSW	;what did the poor slob say
	CPI	'Y'	;was it a Y?
	JZ	..yes	;he indicated the affirmative
	cpi	"y"	;was it lower case
	jz	..yes	;yup
	CPI	079H
	JZ	..yes	;silly boy
	cpi	"N"	;was it a big N
	jz	..no	;he said no
	cpi	"n"	;or perhaps a little n
	jz	..no
	cpi	0dH	;a carriage return
	jz	..no	;if so then it was a no
	cpi	0aH	;ditto line feed
	jz	..no
	jmp	yesorno	;the silly boy pressed the wrong button

..no:	print	" No thank you!"	;polite
	xra	a	;signal a NO
	ret
..yes:	print	" Yes please!"	;polite
	xra	a	;signal a Yes
	dcr	a
	stc	;might as well
	ret

;---------------------------------------------------------------------------
HexOut:	;types out the value in A in Hexadecimal
	push	psw
	rrc
	rrc
	rrc
	rrc
	call	outchr
	pop	psw
outchr:
	Ani	0fH
	adi	90H
	daa
	aci	40H
	daa
	jmp	tyo
	
;--------------------------------------------------
DECOUT: ;types out the contents of HL on the console
;in decimal.

	PUSH	B
	PUSH	D
	PUSH	H
	LXI	B,-10	;-Radix
	LXI	D,-1
..LOOP:	DAD	B	;repeated subtraction
	INX	D
	JC	..LOOP
	LXI	B,10
	DAD	B
	XCHG
	MOV	A,H
	ORA	L
	CNZ	DECOUT	;recursive call
	MOV	A,E
	ADI	'0'
	CALL	TYO
	POP	H
	POP	D
	POP	B
	RET

;----------------------------------------------------------------------------
INTEGER:	;convert a number in memory from 
;ASCII to Binary. HL points to string (null term!!)
	push	h	;save pointer
;has it got a radix qualifier?
	
	mov	c,m
	mvi	b,0
	dad	b	;point to last character
..back:	mov	a,m
	cpi	" "
	jrnz	..hop
	dcx	h
	jmp	..back
..hop:	cpi	"9"+1	;is it a letter?
	lxi	h,radix	;default radix
	mvi	m,10
	jrc	..no.radix
	call	conuc
	cpi	"H"
	mvi	M,16
	jrz	..on
	cpi	"O"
	mvi	m,8
	jrz	..on
	cpi	"B"
	mvi	m,2
	jrz	..on
	mvi	m,10
..on:	
..no.radix:
	pop	h
	inx	h	;bump over count byte
 	lxi	d,0	;initialise accumulator
	xchg
..loop:	ldax	d
	call	conuc
	sui	'0'	;make character binary
	ana	a
	rm	;illegal character
	cpi	10
	jc	..hoppity

	sui	("A"-"9")-1
..hoppity:
	push	h
	lxi	h,radix
	cmp	m
	cmc
	pop	h
	rc	;illegal character
	inx	d	;increment pointer
	mov	c,a
	mvi	b,0
	lda	radix
	dad	h
	cpi	2
	jz	..onwards
	push	b	;save current value
	push	h
	dad	h	;*4
	dad	h	;*8
	pop	b
	cpi	8
	jz	..over
	cpi	16
	jz	..over
	dad	b
..over:	pop	b
	cpi	16
	jrnz	..onwards
	dad	h
..onwards:
	dad	b
	jmp	..loop	;do the next

radix:	.byte	10


;----------------------------------------------------------------------------
BIN:	;gets a figure of up to nine digits and converts it into an integer.
;Integer in HL and the LSB in A reg. Accepts Hex, octal or binary if given
;a qualifier........eg D0H or 010110B	
	push	b
	call	..on
	.byte	09	;buffer maximum
	.blkb	11	;buffer length
..on:	pop	h	;point HL to our buffer
	push	h
	xra	a
	mvi	b,11
..loop:	inx	h	;zero out the Buffer
	mov	m,a
	dcr	b
	jnz	..loop
	pop	d	;point DE to buffer
	push	d
	mvi	c,10
	call	bdos	;and do the BDOS call
	pop	h
	inx	h
	call	integer	;now convert the result into an integer
	mov	a,l
	POP	B
	RET	;	with HL and A holding the integer



hello.string:
	.byte	..end - .		;length of the string
	.byte	1BH,",","G",5,"C"	;define split screen
	.byte	1BH,"U"			;go to the upper
	.byte	1BH,"/"			;make multifont
	.byte	1BH,"#",6,1bh,"X"	;style 3
	.ascii	"          QX+ Function Key Set Utility"
	.byte	1bh,"S",1BH,"V"		;enter the lower screen
..end:	.byte	000,000


ok:	.byte	..end - .
	.byte	ESC,'=',(18+' '),(26+' ')	;bottom centre
	.byte	1bh,'('		;full intensity
	.byte	1bh,"^"		;blink
	.ascii	"<press any key to continue>"
	.byte	1bh,"q"		;cancel blink
	.byte	1bh,')'		;half intensity
..end:	.byte	00,00

tidy.up:	;set the screen to rights
	.byte	..end - .
	.byte	1bH,"+"
	.byte	1BH,"U",1BH,"\"
	.byte	1BH,"V",1BH,"U"		;dont ask
	.byte	1BH,",","C",26,"C"
	.byte	1BH,"+"
..end:	.byte	000,000

intro:

	lxi	sp,stack
	mvi	c,12		;get version no.
	call	bdos
	mov	a,l
	cpi	31H	;is it the right version?
	jc	..bad	;no too old
	mov	a,h
	ana	a
	jz	..good	;not a fancy operating system
..bad:
	print	"   Sorry  but it must be Epson QX+ to run the program

"
	jmp	0000h 	;go back to CCP
..good:
;now check to see if we are in batch mode
	lxi	h,0000	;boot address
	push	h	;on the stack
	lda	dfcb+1		;get the default FCB
	cpi	" "
	jz	Not.Batch
	cpi	"/"		;epson delimitor
	jz	..on.a.bit
	cpi	"["		;cpm+ delimitor
	jrnz	..no.sillies	;damn delimitors
..on.a.bit:
	lda	dfcb+2
..no.sillies:
;A has the letter. we look it up and jump to the subroutine
	mvi	b,(end.subroutines-subroutines)/3

	lxi	h,subroutines
..again:
	cmp	m	;compare the code
;load the pointer to the routine just in case
	inx	h
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	jz	..yessir
	djnz	..again
	jmp	Not.Batch
..Yessir:
	xchg			;bung pointer in HL
	pchl
;----------------------------------------------------------------------------
subroutines:	;	** Batch Mode Subroutines **
	.byte	"A"
	.word	send.alternate
	.byte	"D"
	.word	send.default
end.subroutines:

Not.Batch:	
	lxi	h,hello.string	;print the title in multifonts
	call	msg
	call	screen.clear
	print	hi.there	;and the instructions
	lxi	h,ok
	call	msg	;followed by the prompt
	call	tyi
	push	psw
	lxi	h,tidy.up	;now get all to rights
	call	msg
	pop	psw
	cpi	3
	jz	fare.ye.well
BEGIN:
	xra	a
	sta	changed		;we have not changed anything
        LXI     SP,STACK        ; SET STACK POINTER

	call	gra.off
	call	screen.clear
	call	nice.box	;a nice box round the screen
	lxi	h,start.string
	call	mesag		;print the prompt
	call	curon
	call	..on		;get his response
	.byte	012		;buffer maximum
	.blkb	14		;buffer length
..on:	pop	h		;point HL to our buffer
	push	h
	xra	a
	mvi	b,12
..loop:	inx	h		;zero out the Buffer
	mov	m,a
	dcr	b
	jnz	..loop
	pop	d	;point DE to buffer
	push	d
	mvi	c,10
	call	bdos	;and do the BDOS call
	pop	h
 	inx	h	;point to count byte
	mov	a,m	;get the count
	ana	a
	jz	..do.PFNs
	push	h
	call	wipe.fun.keys
	pop	h
	call	fillit	;parse the filename pointed to by HL
	call	get.pfks	;into the editing buffer
..do.PFNs:
	lxi	h,help.string
	call	mesag
	call	edit.fun.keys
	jz	fare.ye.well






;----------------------------------------------------------------------------
Exit:	;from the program
	call	curon
	lda	changed
	ana	a
	jz	fare.ye.well
	lxi	h,exit.string
	call	mesag

	call	..on	;get his response
	.byte	012	;buffer maximum
	.blkb	14	;buffer length
..on:	pop	h	;point HL to our buffer
	push	h
	xra	a
	mvi	b,12
..loop:	inx	h	;zero out the Buffer
	mov	m,a
	dcr	b
	jnz	..loop
	pop	d	;point DE to buffer
	push	d
	mvi	c,10
	call	bdos	;and do the BDOS call
	pop	h
 	inx	h	;point to count byte
	mov	a,m	;get the count
	ana	a
	jz	fare.ye.well	;temporarily
	inx	h
	mov	a,m
	cpi	esc
	jz	fare.ye.well	;he pressed ESC
	dcx	h
	push	h
	call	put.pfks
	pop	h
	call	emptyit		;parse the filename pointed to by HL
fare.ye.well:
	call	screen.clear
and.goodnight:
	print	"Goodbye
"
	jmp	0000

;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;       SUPPORTING SUBROUTINES
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;

;
MESAG:	;print the actual message
	MOV	A,M
	INX	H
	ORA	A
	RZ
	CALL	Tyo	;output the byte
	JMP	MESAG
;
;




exit.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Press <ESC> to leave the  "
	.byte	esc,"=",4+32,50+32
	.ascii	"program without saving the"
	.byte	esc,"=",5+32,50+32
	.ascii	"alterations, or type the  "
	.byte	esc,"=",6+32,50+32
	.ascii	"filename of the file to   "
	.byte	esc,"=",7+32,50+32
	.ascii	"save onto-->"
	.ascii	"    "
	.byte	bspace,bspace,bspace,bspace
	.byte	00,00

again.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"To Edit another set of    "
	.byte	esc,"=",4+32,50+32
	.ascii	"Function key values then  "
	.byte	esc,"=",5+32,50+32
	.ascii	"press <CR>.  To finish the"
	.byte	esc,"=",6+32,50+32
	.ascii	"session, then press <ESC> "
	.byte	esc,"=",7+32,50+32
	.ascii	"-------------->"
	.byte	000,000,000

start.string:

	.byte	esc,"=",1+32,10+32
	.ascii	"Select which option you wish using the space bar or"
	.byte	esc,"=",2+32,10+32
	.ascii	"cursor control keys. Press <BREAK> to abort.  Press"
	.byte	esc,"=",3+32,10+32
	.ascii	"<CR> or <ESC> when you have made your choice. "

Choice.menu
	.byte	5
	string	"Edit the default function key settings."
	string	"Edit the current function key settings."
	string 	"Edit the settings from a file."
	string	"Load settings from a file into the function keys."
	string	"Reset the function keys to the default setting."
	.byte	000,000

file.name.string:

	.ascii	"type its name >"
	.ascii	"    "
	.byte	bspace,bspace,bspace,bspace
	.byte	000,000,000


blank.string:
	.byte	esc,"=",3+32,50+32
	.ascii	"                          "
	.byte	esc,"=",4+32,50+32
	.ascii	"                          "
	.byte	esc,"=",5+32,50+32
	.ascii	"                          "
	.byte	esc,"=",6+32,50+32
	.ascii	"                          "
	.byte	esc,"=",7+32,50+32
	.ascii	"                          "
	.byte	esc,"=",8+32,50+32
	.ascii	"                          "
	.byte	esc,"=",9+32,50+32
	.ascii	"                          "
	.byte	esc,"=",10+32,50+32
	.ascii	"                          "
	.byte	esc,"=",11+32,50+32
	.ascii	"                          "
	.byte	esc,"=",12+32,50+32
	.ascii	"                          "
	.byte	esc,"=",13+32,50+32
	.ascii	"                          "
	.byte	esc,"=",14+32,50+32
	.ascii	"                          "
	.byte	esc,"=",15+32,50+32
	.ascii	"                          "
	.byte	esc,"=",16+32,50+32
	.ascii	"                          "
	.byte	esc,"=",17+32,50+32
	.ascii	"                          "
	.byte	esc,"=",18+32,50+32
	.ascii	"                          "
	.byte	esc,"=",19+32,50+32
	.ascii	"                          "
	.byte	esc,"=",20+32,50+32
	.ascii	"                          "
	.byte	esc,"=",21+32,50+32
	.ascii	"                          "
	.byte	esc,"=",22+32,50+32
	.ascii	"                          "
	.byte	000,000,000



help.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Please use the cursor keys"
	.byte	esc,"=",4+32,50+32
	.ascii	"to move the cursor to the "
	.byte	esc,"=",5+32,50+32
	.ascii	"part you want to change.  "
	.byte	esc,"=",6+32,50+32
	.ascii	"Use the control keys to   "
	.byte	esc,"=",7+32,50+32
	.ascii	"edit the entries.         "
	.byte	esc,"=",8+32,50+32
	.ascii	"^A = Move cursor left word"
	.byte	esc,"=",9+32,50+32
	.ascii	"^F = Move cursor right wrd"
	.byte	esc,"=",10+32,50+32
	.ascii	"^S = cursor column left   "
	.byte	esc,"=",11+32,50+32
	.ascii	"^D = cursor column right  "
	.byte	esc,"=",12+32,50+32
	.ascii	"^R = cursor to top entry  "
	.byte	esc,"=",13+32,50+32
	.ascii	"^C = cursor to bottom     "
	.byte	esc,"=",14+32,50+32
	.ascii	"^E = cursor to above entry"
	.byte	esc,"=",15+32,50+32
	.ascii	"^X = cursor to next entry "
	.byte	esc,"=",16+32,50+32
	.ascii	"^T = delete word          "
	.byte	esc,"=",17+32,50+32
	.ascii	"^Y = delete line          "
	.byte	esc,"=",18+32,50+32
	.ascii	"DEL= delete preceeding chr"
	.byte	esc,"=",19+32,50+32
	.ascii	"^G = delete current chr   "
	.byte	esc,"=",20+32,50+32
	.ascii	"^V = Toggle inset mode    "
	.byte	esc,"=",21+32,50+32
	.ascii	"^K or ESC = finish editing"
	.byte	esc,"=",22+32,50+32
	.ascii	"^U = Abandon edit         "
	.byte	000,000,000


	;This is the File I/O library module for Assembler Utilities
	;Revised Dec 1983      A.R.M.C.  (C) MML:

setdma	=	26
read	=	20
write	=	21

operation:	.byte	read
fcbad:		.word	00	;fcb pointer
	;This always points to the current FCB

.REMARK "  FILE is the FCB creation routine. It is
a macro which is called by invoking 'FILE <X>' where
<X> is the string label for the file. The file is
 made current subsequently by invoking 'CALL <X>"

upstairs	=	.END.#	;past the end of the program

	.DEFINE FILE [A$]=[	;Macro definition for Workspace and
	.TEMPS	2		;subsequent invocation
![1]	=	upstairs	;why waste valuable program space?
upstairs	=	upstairs+1024		;buffer itself 
;bump the Alloc pointer
![0]:	.byte	[42]0 		;create the extended FCB
	.word	![1]		;pointer to the buffer
	.byte	[2]0		;pointer to buffer top
$'A$:	PUSH 	H		;Define subroutine to make file current
	LXI	H,![0]		;Point HL pair to the Extended FCB
	SHLD	FCBAD		;And make it current
	POP	H		;save all registers
	RET 	;and go home
		.DEFINE A$ =[	;Macro to 
	CALL	$'A$		;invoke the preceeding routine
		]
	]	

;end of macros

;eg	FILE	OFILE

.REMARK	"The following routines help to set up the
file control block reference macros. these enable
complex sequential and random file operations to
be done without fuss. The FCB reference is returned
in the HL pair"

	.DEFINE	FCB	=[	;start of the macro
	LHLD	FCBAD	;get address of current FCB
	]	;end of macro

IN.HL:	PUSH	D	;Point to offset in HL of current FCB
	XCHG
	FCB		;put address of current FCB in HL
	DAD	D	;add in offset
	POP	D	;restore contents of DE
	RET

	.DEFINE	FCBREF	[A$,OFFSET]=[	;define Macro to define offsets
$'A$::	LXI	H,OFFSET		;load HL with the offset
	JMP	IN.HL			;and calculate the offset
		.DEFINE A$=[	;define macro to define the subroutine
	CALL	$'A$		;actually do the defined subroutine
		]		;end of the macros
	]

FCBREF	FNAD,1	;address of filename
FCBREF	FTAD,9	;address of filetype
FCBREF	EX,12	;address of file extent no.
FCBREF	RCO,15	;address of record count
FCBREF	NR,32	;address of next record no.
FCBREF	R0,33	;address of random record no.
FCBREF	R2,35	;address of overflow R0
FCBREF	EOF%,36	;address of end of file flag
FCBREF	WRITE%,37 ;address of write-only flag
FCBREF	OPEN%,38;address of open? flag
FCBREF	FULL%,39;address of buffer-full? flag
FCBREF	OFFSET,40;address of the relative offset
FCBREF	FBUFF,42;address of buffer base
FCBREF	TOP,44	;address of top of buffer

	;now all of our offsets are defined



.REMARK "*** PRIMITIVE SEQUENTIAL OPERATIONS ***
These consist of various routines that use the 
FCB addressed by the variable FCBAD and allow
sequential file access for reading and writing
to sequential files. The core routines are the
PUTBYT and GETBYT ones which put or get the next
byte from the current file."

;*** TYPE THE FILENAME IN THE FCB ***
typfcb:
	fcb
SHOW.FCB:
	MOV	A,M
	INX	H
	ANA	A
	JZ	..ON
	PUSH	H
	ADI	'A'-1
	CALL	TYO
	MVI	A,':'
	CALL	TYO
	POP	H
..ON:	MVI	B,8
	CALL	..TYPE
	MVI	A,'.'
	PUSH	H
	CALL	TYO
	POP	H
	MVI	B,3

..TYPE:	MOV	A,M
	CPI	' '
	PUSH	H
	PUSH	B
	CNZ	TYO
	POP	B
	POP	H
	INX	H
	DCR	B
	JNZ	..TYPE
	RET

;*** OPEN A FILE FOR WRITING ***

WOPEN:	PUSH	H	;save contents of HL register
	FCB		;get the address of the current fcb in HL
	XCHG		;DE points to the FCB
	MVI	C,19	;delete the existing version
	PUSH	D	;save pointer to the FCB
	CALL	BDOS
	POP	D	;restore FCB pointer
	MVI	C,22	;make the new file directory entry
	CALL	BDOS
	INR	A	;was there an error?
	LXI	H,WO.ERR;point to error string in anticipation
	JZ	ERROR	;if there was an error
	EOF%		;point to the End-of-file flag
	MVI	M,FALSE	;and set it to false
	INX	H		;point to WRITE flag
	MVI	M,TRUE	;flag it as true
	INX	H	;point to OPEN flag
	MVI	M,TRUE	;flag it as true
	POP	H	;restore HL
	RET


;*** OPEN A FILE FOR READING ***

OPEN:	PUSH	H	;save HL 
	FCB		;point to the current FCB
	XCHG		;FCB pointer in DE
	MVI	C,15	;open the file
	CALL	BDOS
	INR	A	;was there an error?
	LXI	H,O.ERR	;point to error string in anticipation
	JZ	ERROR	;if zero set, jump to error
	EOF%		;point to end of file flag
	MVI	M,FALSE	;and set it to false
	INX	H	;point to WRITE flag
	MVI	M,FALSE	;not write
	INX	H	;point to open flag
	MVI	M,TRUE	;open
	POP	H	;restore HL
	RET


;----------------------------------------------------------------------------
Do.Buffer:	;read 1K from file into the buffer
;A=true if end of file, otherwise false
;DE points to the buffer top
	fbuff
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	push	h		;points to TOP
;pick up the buffer address in DE
	mvi	b,8		;sectors to do
	mvi	c,true		;assume the end of file
..loop:
	push	d		;save the DMA
	push	b		;save the count
	mvi	c,setdma
	call	bdos
	fcb
	xchg
	lda	operation	;either read or write
	mov	c,a
	call	bdos
	ana	a		;was it successful?
	pop	b		;restore the count
	pop	d		;restore DMA
	jrnz	..end
	lxi	h,128		;bump the DMA address
	dad	d
	xchg
	djnz	..loop
	mvi	c,false		;we made it, did one K!!
..end:	pop	h		;restore pointer to TOP
	mov	m,e
	inx	h
	mov	m,d
	mov	a,c		;was it end of the file
	ana	a
	ret	

;*** fill the buffer ***
;----------------------------------------------------------------------------
RDBUFF:	;fill the buffer of the current FCB
	mvi	a,read
	sta	operation
do.it:	PUSH	B	;save all registers
	PUSH	D
	PUSH	H
	FULL%		;point to the BUFFER-FULL flag
	MVI	M,true	;yes, its full
	INX	H	;point to offset
	xra	a
	mov	m,a	;zero our offset
	inx	h
	mov	m,a
	call	do.buffer
	push	psw	;save the result
	LXI	D,DBUF	;reset the DMA address
	MVI	C,26	;as a precaution
	CALL	BDOS
	POP	PSW	;Non-zero if end of file or error
	POP	H	;restore the registers
	POP	D
	POP	B
	RET


;*** WRITE RECORD FROM BUFFER ***

WTBUFF:	mvi	a,write
	sta	operation
	jmp	do.it

;*** GETBYTE GETS THE NEXT BYTE ***

GETBYTE:	;from the current FCB into A register
;EOF%,36	;address of end of file flag
;WRITE%,37 ;address of write-only flag
;OPEN%,38	;address of open? flag
;FULL%,39	;address of buffer-full? flag
;OFFSET,40	;address of the relative offset
;FBUFF,42	;address of buffer base
;TOP,44		;address of top of buffer
;returns Non-Zero if End of file
	EOF%		;point to EOF flag
	MOV	A,M	;what is in it
	ANA	A
	RNZ		;return non-zero if end of file reached
	INX	H	;are we getting from a file for writing?
	ora	m
	CNZ	..ERR	;if so, then we cannot allow this
	INX	H	;is the file open?
	MOV	A,M
	ANA	A
	CZ	OPEN	;if it is not open then open it
	INX	H	;point to FULL flag
	MOV	A,M
	ANA	A	;if not then fill it
..back:	CZ	RDBUFF
	inx	h
	push	h	;save pointer to offset
	mov	c,m	;get the offset in BC
	inx	h
	mov	b,m
	inx	h
	mov	e,m	;get the pointer in DE
	inx	h
	mov	d,m
	inx	h
	mov	a,m	;get the buffer top pointer in HL
	inx	h
	mov	h,m
	mov	l,a
	xchg
	dad	b	;point to next byte in HL
	call	cmp16
	pop	d	;restore pointer to offset in DE
	jrc	..no.sweat
	mvi	a,04	;was the last read incomplete?
	cmp	b
	jnz	..eof	;last read was incomplete
	FULL%
	jmp	..back	;with zero set, try again!
..no.sweat:

	MOV	A,M	;get the byte
	xchg
	inx	b	;bump the pointer
	mov	m,c	;and save it
	inx	h
	mov	m,b
	cmp	a	;set zero for success
	RET	;and return

..ERR:	INX	H	;the error routine
	MOV	A,M	;is it a closed file for writing
	DCX	H	;if so then
	ANA	A	;it is safe to open it
	JZ	OPEN
	LXI	H,GB.ERR	;otherwise it is an error
	JMP	ERROR

..eof:
	eof%
	mvi	a,true
	mov	m,a
	ana	a
	mvi	a,1AH		;put EOF in A
	ret

;*** PUTBYTE PUTS THE NEXT BYTE ***

PUTBYTE::	;put the byte in A into the current file
	MOV	C,A	;save it in C
	WRITE%	;point to the WRITE flag
	MOV	A,M	;get the write flag
	ANA	A	;is it for writing?
	PUSH	B
	CZ	..ERR	;if not then we do not allow it
	INX	H	;point to OPEN flag
	MOV	A,M	;get it
	ANA	A	;is the file open?
	CZ	WOPEN	;if not then open it
	INX	H	;point to FULL flag
..back:	inx	h
	push	h	;save pointer to offset
	mov	c,m	;get the offset in BC
	inx	h
	mov	b,m
	inx	h
	mov	e,m	;get the buffer pointer in DE
	inx	h
	mov	d,m
	xchg
	dad	b	;point to next byte in HL
	pop	d	;restore pointer to offset in DE
	mov	a,b
	cpi	04	;is buffer full?
	jrnz	..no.sweat
	call	wtbuff
	FULL%
	jrz	..back	; try again!
	LXI	H,WO.ERR	;announce failure in case
	JMP	ERROR
..no.sweat:
	xchg
	inx	b	;bump the pointer
	mov	m,c	;and save it
	inx	h
	mov	m,b
	xchg
	pop	b
	MOV	m,c	;put the byte
	cmp	a	;set zero
	RET	;and return


..ERR:	INX	H	;point to OPEN flag
	MOV	A,M	;is it open at all?
	DCX	H	;if closed then it is all right
	ANA	A	;to WOPEN it
	JZ	WOPEN
	LXI	H,PB.ERR	;otherwise an error
	JMP	ERROR	;jump to the error handler

..eof:
	pop	b	;jettison the byte to put
	eof%
	mvi	a,true
	mov	m,a
	ana	a
	ret


CLOSE::	WRITE%	;is this file for writing?
	MOV	B,M	;save truth in B
	INX	H	;point to OPEN flag
	MOV	A,M	;is it open
	INX	H	;point to the relative offset
	inx	h
	ana	a
	RZ		;nothing to do
	MOV	A,B	;was it for writing?
	ANA	A
	CNZ	..SUB	;we need to put in an EOF if ASCII file
	FCB	;point to the FCB
	XCHG	;put pointer in DE
	MVI	C,16	;close the file
	CALL	BDOS
	INR	A	;was there an error?
	LXI	H,O.ERR	;point to error
	RNZ			;return non-zero if successful
	JMP	ERROR	;go to error handler
..SUB:	MOV	A,M	;were we on a buffer boundary
	inx	h
	ora	m
	RZ	;nothing necessary
	MVI	A,EOF	;send an EOF marker
	CALL	PUTBYTE	;put the byte
	CALL	WTBUFF	;flush the buffer
	RET	;and go home


ERROR:	PUSH	H
	CALL	TYPFCB
	POP	H	;type the current filename
	CALL	MSG	;and follow it with the error message
	JMP	0000H	;abort

get.name:	;from the default FCB into current FCB
	lhld	fcbad	;get the FCB
	push	h	;save it
	xchg	;put it in DE
	lxi	h,dfcb
	lxi	b,12	;HL=DFCB, DE=FCBad, BC=count
	call	move
	pop	h	;restore fcbad
	lxi	d,12	;point to EX
	dad	d
	mvi	b,4	;zero out extents etc
..loop:	mvi	m,0
	inx	h
	djnz	..loop
	ret	;job done



	file 	ifile	;declare our input file
	file	ofile	;and our output file

PFCB:	.word	00
	.word	00	

;----------------------------------------------------------------------------
fillit:	;fill the editing buffer with the PFKey file from the filename
; pointed to by HL
	push	h
	ifile		;make our input file the current one
	pop	h
	inx	h
	shld	PFCB	;store pointer in the PFCB Block
	fcb		;get our current FCB
	shld	PFCB+2	;store pointer in the PFCB Block
	lxi	d,PFCB
	mvi	c,98H	;parse filename command
	call	bdos
	mov	a,h
	ana	l
	inr	a
	jrnz	..ok
	print	"
			Error in the filename!"
	jmp	boot
..ok:
get.that.one:
	ftad
	lxi	d,pfkftype
	xchg
	lxi	b,3
	ldir
	call	open
	lxi	h,Our.Buffer+1	;where the string itself starts
	mvi	c,0	;count of gotten bytes from ASCII CR del. record
..loop:
	push	b
	push	h
	call	getbyte
	pop	h
	pop	b
	cpi	eof
	rz		;was it end of file or carriage return
	cpi	cr
	rz
	cpi	lf	;was it a line feed?
	mov	m,a	;put byte in memory
	inx	h
	inr	c
	mov	a,c
	sta	our.buffer	;update the count
	djnz	..loop	
	ret	

	
;----------------------------------------------------------------------------
EmptyIt:	;empty the contents of the buffer  into a file
;with the user-supplied name

	push	h
	Ofile		;make our output file the current one

	pop	h
	inx	h
	shld	PFCB	;store pointer in the PFCB Block
	fcb		;get our current FCB
	shld	PFCB+2	;store pointer in the PFCB Block
	lxi	d,PFCB
	mvi	c,98H	;parse filename command
	call	bdos
	mov	a,h
	ana	l
	inr	a
	jrnz	..ok
	print	"
			Error in the filename!"
	jmp	exit	;recursive but what the hell
..ok:
	ftad		;set the obligatory PFK
	lxi	d,pfkftype
	xchg
	lxi	b,3
	ldir
	call	Wopen
	lxi	h,our.buffer
	mov	b,m
	mov	a,b
	ana	a
	rz		;if nothing to do
	inx	h	;point to the first entry
..loop:
	push	b
	push	h
	mov	a,m
	call	Putbyte
	pop	h
	pop	b
	inx	h
	djnz	..loop	
	mvi	a,CR
	call	putbyte
	mvi	a,LF
	call	putbyte	;send a CR/LF sequence
	call	close
	ret	

pfkftype:	.ascii	'PFK'
;-----------------------------------------------------------------------------
read.PFK.file:	;from disk into the buffer
	ifile
	fcb
	xchg
	lxi	h,dfcb+16	;get it from the second DFCb
	lxi	b,16
	ldir
	jmp	get.that.one

;----------------------------------------------------------------------------
send.alternate:
	call	read.PFK.file
	call	get.pfks
send.default:
	call	send.PFKs
	print	"PFKs now reprogrammed
"
	jmp	0000
	
;-------------------------------------------------------------------------
;*** File Handling Error Messages ***

.define an.error.msg	[A$]=[
	.byte	@a$+2
	.ascii	A$
	.byte	0dh,0ah,00
	]

WO.ERR:	AN.ERROR.MSG	" can't fit on disk"
O.ERR:	AN.ERROR.MSG	" is'nt on disk"
GB.ERR:	AN.ERROR.MSG	" is for writing only"
PB.ERR:	AN.ERROR.MSG	" is for reading only"

our.buffer:	.blkb	500
	.blkb	128		;64-WORD STACK
STACK:
.list

.end	intro
