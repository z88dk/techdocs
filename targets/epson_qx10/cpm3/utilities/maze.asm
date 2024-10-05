
.title	[Maze --Test program for the EPSON QX+]
.ident	Maze



;*** Absolute addresses ***
bdos	=	0005H
BOOT	=	0000H

;*** Logical constants ***
False	=	0000H
True	=	0FFH


;*** Ascii codes ***
CR	=	0DH
LF	=	0AH
NUL	=	0FFH
FF	=	0CH

;*** Graphic chars ***
plnoleft	=	84H
plnotop		=	82H
plnobottom	=	81H
plnoright	=	83H
topleft		=	87H
topright	=	88H
botleft		=	89H
botright	=	8AH
bar		=	86H
Hoz.line	=	85H

begin:
;*** Program Start ***
	lxi	sp,stack	;set local stack
	jmp	maze

	.ASCII	"COPYRIGHT MML Ltd (C) 1983"
;*** ALL PATCHES AS IN WORDSTAR ***
CLEAR:	.BYTE	01,1ah,00,00,00,00
CLEAD1:	.BYTE	02,27,61
	.BYTE	00,00,00,00,00,00
CLEAD2:	.BYTE	00,00,00,00,00,00
CTRAIL:	.BYTE	00,00,00,00,00,00
CB4LFG:	.BYTE	false
LINOFF:	.BYTE	20H
COLOFF:	.BYTE	20H
;*** OTHER VDU PATCHES IN ADDITION ***

IVONº	.BYTÅ	02,27,'J',00,00,00,00
IVOFF:	.BYTE	02,27,'K',00,00,00,00
IVON2:	.BYTE   02,27,'(',00,00,00,00
HOME:	.BYTE	01,1EH,00,00,00,00,00 
on.cursor:	.byte	02,1bh,'3',00
off.cursor:	.byte	02,1bh,'2',00
Upper.screen:	.byte	2,1bH,"U",00
Lower.screen:	.byte	2,1BH,"V",00
GRFiKS:		.byte	2,1BH,'G',00
no.grfix:	.byte	2,1bh,'H',00
prininit:	.byte	6,1bH,1bh,"D",1Bh,1BH,"F",00

titl.message:
	.byte	7			;Byte count
	.byte	1bH,"\"
	.byte	1bH,44,"G"		;first screen is graphic
	.byte	3			;line of split is line 3
	.byte	"C"			;second screen is character
	.byte 	0


INITIº	.BYTE	22
 	.BYTE	27,59
	.BYTE	27,56,26,19,00
	.BYTE	27,56,27,04,00
	.BYTE	27,56,24,05,00
	.BYTE	27,56,25,24,00


.REMARK	"  These are the fundemental BIOS interaction
routines"

	.DEFINE	BIOS	[A$,OFFSET]=[
A$:	LHLD	0001H
	LXI	D,OFFSET
	DAD	D
	PCHL	]

BIOS	CONST,3
BIOS	CONIN,6
BIOS	CONOUT,9
bios	list,12

;*** BASIC CONSOLE I/O ROUTINES ***

TYO:	MOV	C,A
	JMP	CONOUT

lyo:	mov	c,a
	jmp	list

TYI:	JMP	CONIN


pbyte:	;print byte in E on device selected
	mov	a,e
	lhld	output
	pchl

output:	.word	tyo


pstring:	;until we get a $ sign
;string in DE

..LOOP:	ldax	d
	cpi	"$"
	rz
	PUSH	d
	mov	e,a
	call	pbyte
	pop	d
	inx	d
	JMP	..LOOP




MSG:	MOV	A,M
	MOV	B,A
	ORA	A
	RZ
..LOOP:	INX	H
	MOV	A,M
	PUSH	H
	PUSH	B
	CALL	TYO
	POP	B
	POP	H
	DCR	B
	RZ
	JMP	..LOOP

;--------------------------------------------------
LMSG:	;print string on the printer
	MOV	A,M
	MOV	B,A
	ORA	A
	RZ
..LOOP:	INX	H
	MOV	A,M
	PUSH	H
	PUSH	B
	CALL	lYO
	POP	B
	POP	H
	DCR	B
	RZ
	JMP	..LOOP



.REMARK " *** PRINT IN LINE MACRO ***"
;This has the syntax PRINT "STRING."
SAY:	POP	H
..LOOP:	MOV	A,M
	INX	H
	ANA	A
	JZ	..EXIT
	PUSH	H
	call	tyo
	POP	H
	JMP	..LOOP
..EXIT:	PCHL
	.DEFINE PRINT [A$]=[
	CALL	SAY
	.ASCIZ	A$]



;*** HILTON TURNS THE TERMINAL HIGHLIGHT ***
;*** SPECIFIED BY IVON, ON; HILTOF OFF   ***
HILTON:	PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,IVON
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

HILTOFF:PUSH	H
	PUSH	D
	PUSH	B
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

;--------------------------------------------------
Tellprinter:	;that we want graphics mode
;and small line spacing
	push	h
	push	d
	push	b
	lxi	h,prininit
	call	lmsg
	pop	b
	pop	d
	pop	h
	ret

gra.off:

	PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,no.grfix
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET
	
curon:
	  PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,on.cursor
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

into.graphics:
	
	  PUSH	H
	PUSH	D
	PUSH	B
	lxi	h,GRFiKS
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET
	
curoff:
	  PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,off.cursor
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

screen.clear:
	PUSH	H
 	PUSH	D
	PUSH	B
	LXI	H,clear
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET


	xhere:	.word	00
	yhere:	.word	00,00

;*** YXPOS SENDS THE CURSOR TO THE SCREEN ***
;*** REF. CONTAINED IN XHERE AND YHERE.   ***

YXPOS:	PUSH	H
	PUSH	D
	PUSH	B
	LXI	H,CLEAD1
	CALL	MSG
	LDA	CB4LFG
	ANA	A
	JNZ	..REV
	LDA	YHERE
	MOV	B,A
	LDA	LINOFF
	ADD	B
	CALL	TYO
	LXI	H,CLEAD2
	CALL	MSG
	LDA	XHERE
	MOV	C,A
	LDA	COLOFF
	ADD	C
	CALL	TYO
..END:	LXI	H,CTRAIL
	CALL	MSG
	POP	B
	POP	D
	POP	H
	RET

..REV:	LDA	XHERE
	MOV	C,A
	LDA	COLOFF
	ADD	C
	CALL	TYO
	LXI	H,CLEAD2
	CALL	MSG
	LDA	YHERE
	MOV	B,A
	LDA	LINOFF
	ADD	B
	CALL	TYO
	JMP	..END


 


line.msg:	.byte	13
	.byte	1bH,'.',2
	.word	10
y.strt:	.word	10
	.word	630
Y.end:	.word	398
	.word	0FFFFH
	.byte	00

draw.a.line:	;draws a graphics line
	lxi	h,line.msg
	call	msg
	ret	

drawdown:	;the whole screen a double line
	mvi	b,23
..downloop:
	push	b
	lxi	h,Yhere
	inr	m
	call	yxpos
	mvi	a,086H		;down line
	call	tyo
	pop	b
	djnz	..downloop
	ret

;-------------------------------------------------
nice.box:	;around the screen
	xra	a
	sta	yhere
	sta	xhere
	call	yxpos
;draw the top border	
	mvi	a,087H		;a top left border
	call	tyo
	mvi	b,77
..toploop:
	mvi	a,085H		;do a top line
	push	b
	call	tyo
	pop	b
	djnz	..toploop
	mvi	a,088H		;a top right border
	call	tyo

;go to bottom line	
	mvi	a,24
	sta	Yhere
	xra	a
	sta	Xhere
	call	yxpos

;draw the bottom border	
	mvi	a,089H		;a bottom left border
	call	tyo
	mvi	b,77
..botloop:
	mvi	a,085H		;do a bottom line
	push	b
	call	tyo
	pop	b
	djnz	..botloop
	mvi	a,08AH		;a bottom right border
	call	tyo

	xra	a
	sta	xhere
	sta	Yhere
	call	drawdown
	mvi	a, 78
	sta	xhere
	xra	a
	sta	yhere
	call	drawdown
	call	hiltoff
	ret

;--------------------------------------------------
YesorNo:	;returns 0 in A if no, 0FFH if yes
	call	curon
	call	tyi
	push	psw
	call	curoff
	POP	PSW
	CPI	'Y'
	JZ	..yes
	cpi	"y"
	jz	..yes
	CPI	079H
	JZ	..yes
	cpi	"N"
	jz	..no
	cpi	"n"
	jz	..no
	cpi	0dH
	jz	..no
	cpi	0aH
	jz	..no
	jmp	yesorno

..no:	print	" No thank you!"
	xra	a
	ret
..yes:	print	" Yes please!"
	xra	a
	dcr	a
	stc
	ret

;--------------------------------------------------
MAZE:	;we start at this point in this program


	mvi	c,12		;get version no.
	call	bdos
	mov	a,l
	cpi	31H
	jc	bad
	mov	a,h
	ana	a
	jz	good
bad:
	print	"   Sorry, but it must be Epson QX+ to run the program

"
	jmp	0000h 

good:	call	into.graphics
	xra	a
	sta	to.printer
	mvi	a,25		;set default vals
	sta	xmax
	mvi	a,10
	sta	ymax
	lxi	h,tyo
	shld	output
	call	screen.clear	;clear the screen
	call	curoff
	print	"




                 The EPSON QX+ Maze Program         MML: 1983
"
	call	nice.box
	call	hiltoff
	mvi	a,8
	sta	yhere
	mvi	a,0
	sta	xhere
	call	yxpos
	print	"
	You can either print a Maze on the printer or explore a maze on
	the screen using the cursor control keys.


	Do you wish to print your maze?--> "
	call	YesorNo
	jz	..on
;he does want to!!
	xra	a
	dcr	a
	sta	to.printer
	mvi	a,34
	sta	xmax
	mvi	a,39
	sta	ymax
	call	tellprinter
	lxi	h,lyo
	shld	output

..on:;

maze1:	call	screen.clear	;clear the screen
	call	curoff
	print	"




                 The EPSON QX+ Maze Program         MML: 1983
"
	call	nice.box
	call	hiltoff
	;this is the start of the maze repeat loop
;Zero the flags
	MVI	A,0
	STA	PFLAG
	STA	MFLAG
;zero the maze matrix
	LXI	H,MTX
	LXI	B,MTXE
M3:	MVI	M,0
	INX	H
	MOV	A,L
	CMP	C
	JNZ	M3
	MOV	A,H
	CMP	B
	JNZ	M3

	CALL	SIZE	;set the maze size
	LXI	D,PAGE	;clean page on the printer
	call	pstring
	call	screen.clear
	CALL	START	;
M1:	CALL	TEST
	MOV	A,E
	ORA	A
	JZ	M2
	CALL	MOVE
	JMP	M1

M2:	CALL	SCAN
	JC	M1
	lda	to.printer
	ana	a
	jz	..on
	print	"


    Printing!      This may take quite a long while if its a big maze
"
..on:	CALL	PMAZE
	lda	to.printer
	ana	a
	cz	play
	mvi	a,24
	sta	Yhere
	sta	xhere
	call	yxpos
	LXI	D,AGAIN
	MVI	C,09
	CALL	bdos
	call	curon
	call	YesorNo
	jnz	maze1
exit:	call	gra.off
	JMP	BOOT

SIZE:
	mvi	a,8
	sta	yhere
	mvi	a,0
	sta	xhere
	call	yxpos
	print	"
	Mazes can be up to "
	lda	to.printer
	ana	a
	jz	..on
	print	"34 wide and 39 high
"
	jmp	..on1
..on:	print	"25 wide and 10 high
"
..on1:	call	curon
sizea:	LXI	D,CRLF
	MVI	C,9
	CALL	bdos
	LXI	D,WIDE
	MVI	C,09
	CALL	bdos	;ask how wide
SIZE1:	CALL	RND
	MVI	C,11
	CALL	bdos
	ORA	A
	JZ	SIZE1	;throw the dice
	CALL	BIN	;get the size
	PUSH	PSW
	LXI	D,CRLF
	MVI	C,9
	CALL	bdos
	lda	xmax
	inr	a
	mov	c,a
	POP	PSW
	cmp	c	;silly size
	JNC	SIZEA
	ana	a
	jz	sizeA
	STA	CMAX
SIZE2:	LXI	D,HIGH
	MVI	C,09	;ask how high
	CALL	bdos
	CALL	BIN
	PUSH	PSW
	LXI	D,CRLF
	MVI	C,09
	CALL	bdos
	lda	ymax
	inr	a
	mov	c,a
	POP	PSW
	cmp	c
	JNC	SIZE2
	ana	a
	jz	size2
	STA	BMAX
	call	curoff
	RET

START:	LDA	CMAX
	MOV	E,A
	CALL	RNDR
	STA	Start.position
	MOV	C,A
	MVI	B,0
	CALL	MATRIX
	MVI	M,1
	RET

TEST:	MVI	D,0
	MOV	A,B
	CPI	0
	JZ	T1
	DCR	B
	CALL	MATRIX
	INR	B
	MOV	A,M
	RRC
	JC	T1
	MOV	A,D
	ORI	01H
	MOV	D,A
T1:	LDA	BMAX
	DCR	A
	CMP	B
	JNZ	T8
	LDA	PFLAG
	ORA	A
	JZ	T2
	JMP	T3

T8:	INR	B
	CALL	MATRIX
	DCR	B
	MOV	A,M
	RRC
	JC	T3

T2:	MOV	A,D
	ORI	02
	MOV	D,A
T3:	MOV	A,C
	CPI	0
	JZ	T4
	DCR	C
	CALL	MATRIX
	INR	C
	MOV	A,M
	RRC
	JC	T4
	MOV	A,D
	ORI	04H
	MOV	D,A
T4:	LDA	CMAX
	DCR	A
	CMP	C
	JZ	T5
	INR	C
	CALL	MATRIX
	DCR	C
	MOV	A,M
	RRC
	JC	T5
	MOV	A,D
	ORI	08H
	MOV	D,A
T5:	MVI	E,0
	MOV	A,D
	ORA	A
T6:	RAR
	JNC	T7
	INR	E
T7:	ORA	A
	JNZ	T6
	RET

MOVE:	MVI	A,1
	STA	MFLAG
	CALL	RNDR
	MOV	E,A
	MOV	A,D
	INR	E
	DCR	E	;test E
	RRC
	JNC	MV1
	JZ	MOVEUP
	DCR	E
MV1:	RRC
	JNC	MV2
	JZ	MOVEDOWN
	DCR	E
MV2:	RRC
	JNC	MOVERIGHT
	JZ	MOVELEFT
	JMP	MOVERIGHT

MOVEUP:	DCR	B
	CALL	MATRIX
	MOV	A,M
	ORI	05H
	MOV	M,A
	RET

MOVEDOWN:
	CALL	MATRIX
	MOV	A,M
	ORI	04H
	MOV	M,A
	LDA	BMAX
	DCR	A
	CMP	B	;is it line fore last?
	JZ	MD1
	INR	B
	CALL	MATRIX
	MOV	A,M
	ORI	01H
	MOV	M,A
	RET
;almost done
MD1:	MVI	A,1
	STA	PFLAG
	MVI	B,0
	LDA	Start.position
	MOV	C,A
	RET

MOVELEFT:
	DCR	C
	CALL	MATRIX
	MOV	A,M
	ORI	03H
	MOV	M,A
	RET

MOVERIGHT:
	CALL	MATRIX
	MOV	A,M
	ORI	02H
	MOV	M,A
	INR	C
	CALL	MATRIX
	MOV	A,M
	ORI	01H
	MOV	M,A
	RET

SCAN:	INR	C
	LDA	CMAX
	CMP	C
	JZ	S1
S2:	CALL	MATRIX
	MOV	A,M
	RRC
	JNC	SCAN
	RET

S1:	MVI	C,0
	INR	B
	LDA	BMAX
	CMP	B
	JNZ	S2
	MVI	B,0
	LDA	MFLAG
	ORA	A
	RZ
	MVI	A,0
	STA	MFLAG
	JMP	S2

;--------------------------------------------------
PMAZE:	;print out the maze matrix
;do a carriage-return/line feed
	LXI	D,CRLF
	call	pstring

;do the top line of the maze
	LXI	D,.2.spaces	;
	call	pstring		;print left border
	mvi	e,topleft	;print top left
	call	pbyte
	lxi	b,0	;column and row count
;print the top line loop
PM1:	LDA	Start.position		;
	lxi	d,t.2.spaces
	CMP	C
	JZ	..on
	lxi	d,.2.lines
..on:
;print horizontal wall or opening (2 char positions)
	PUSH	B
	call	pstring
	POP	B

;print the final char, 
;-i-  space, --- or -i
;g, either end, +(no top) ,or plain
	PUSH	B
	call	matrix
	mov	a,m
	ani	02H		;plain or fancy
	mvi	e,plnotop
	jz	..on1
	mvi	e,Hoz.line
..on1:	;should it be blank anyway?
	LDA	Start.position		;
	CMP	C
	jnz	..on2	;no it shouldnt
	mvi	e," "
	mov	a,m
	ani	02H
	jnz	..on2
	mvi	e,topleft

..on2:	
	lda	start.position
	dcr	a
	cmp	c
	jnz	..on6	;next isnt opening
	mov	a,m
	ani	02H
	jnz	..on6
	mvi	e,topright
..on6:
;is it the top right after all?
	LDA	CMAX
	dcr	a
	CMP	C
	jnz	..on3	;no it isnt
	mvi	e,topright
..on3:	
	call	pbyte
	POP	B
;check to see if done
PM3:	INR	C
	LDA	CMAX
	CMP	C
	JNZ	PM1		;have we done the line?

;print a line on the screen
PM4:	PUSH	B
	LXI	D,CRLF
	call	pstring
	LXI	D,V.WALL	;vertical wall
	call	pstring
	POP	B
	MVI	C,0		;zero the column count
PM5:	CALL	MATRIX		;index into the matrix
	MOV	A,M
	ANI	02H		;if bit set, then in passage
	lxi	d,.3.spaces
	JnZ	..on
	lxi	d,V.Wall
..on:
;we print a passage or vertical wall
	PUSH	B
	call	pstring
	POP	B
	INR	C
	LDA	CMAX	;have we done the line
	CMP	C
	JNZ	PM5
;so we have done the passage line

;print the wall line
;This is rather harder, folks
	LDA	BMAX	;is it the last wall line
	dcr	a
	CMP	B
	jz	last
	PUSH	B
	LXI	D,CRLF
	call	pstring
	lxi	d,.2.spaces
	call	pstring
	pop	b
	mvi	c,0	;zero the column count
	call	matrix
	mvi	e,Bar	;could be!
	mov	a,m
	ani	04H	;examine bit 2
	push	b	;save column/row
	jnz	..on1
	mvi	e,plnoleft
..on1:	call	pbyte
	pop	b

pm8:
;we print an opening in the wall
	call	matrix
	mov	a,m
	ani	04H	;examine bit 2
	push	psw	;save truth
	LXI	D,.2.spaces	;print an opening
	jnz	..on2
;or a section of wall
	lxi	d,.2.lines
..on2:	push	b
	push	h
	call	pstring
	pop	h
	POP	B
	pop	psw
;Now we must print a plus with one or more 
;bits missing
	push	b
	sta	wallleft	;zero if wall to left
	mov	a,m
	ani	02h		;was there wall above?
	sta	wallabove
	INR	C
	call	MATRIX
	mov	a,m
	ani	04H
	sta	wallright	;zero if wall right
	dcr	c
	inr	b
	call	MATRIX
	mov	a,m
	ani	02H
	sta	wallbelow
	lxi	h,wallright
	inr	c
	lda	cmax		;is it the maximum?
	sub	c
;a=0 if last icon
	jnz	..on5
	mvi	m,0ffH		;no wall to the right
..on5:	call	selectit	;get the right char.
	call	pbyte
	pop	b
	inr	c
	LDA	CMAX
	CMP	C
	JNZ	PM8	;if not done, then loop
	INR	B	;increment line count
	Jmp	PM4
;now we have to print the boddom line
last:
	PUSH	B
	LXI	D,CRLF
	call	pstring
	LXI	D,.2.spaces	;print an opening
	call	pstring
	mvi	e,botleft
	call	pbyte
	POP	B
	MVI	C,0	;zero the column count	

PM11:	CALL	MATRIX	;index into the matrix
	MOV	A,M
	ANI	04H	;examine bit 2
	lxi	d,b.2.spaces
	JnZ	..on
;we print a wall
	lxi	d,.2.lines
..on:	PUSH	B
	push	b
	push	h
	call	pstring
	pop	h
	pop	b
	mov	a,m
	mvi	e,plnobottom
	ani	02H	;was there a line
	jz	..on1	;jump if a line above
	mvi	e,hoz.line
..on1:	mov	a,m
	ani	04H	;was it an opening?
	jz	..on4	;not an opening
	mvi	e," "
	mov	a,m
	ani	02H
	jnz	..on4
	mvi	e,botleft
..on4:	push	b
	inr	c	;look at next
	call	matrix
	pop	b
	mov	a,m
	ani	04H	;is the next an opening?
	jz	..on5	;not an opening
	mvi	e," "
	call	matrix
	mov	a,m
	ani	02H	;was there a line above
	jnz	..on5
	mvi	e,botright
..on5:
;is it the bottom right after all?
	LDA	CMAX
	dcr	a
	CMP	C
	jnz	..on3	;no it isnt
	mvi	e,botright
..on3:	call	pbyte
	POP	B
	


PM13:	INR	C
	LDA	CMAX
	CMP	C
	JNZ	PM11	;if not done, then loop

	LXI	D,CRLF
	call	pstring
	LXI	D,PAGE
	call	pstring
	RET

GC.Table:	;our graphic character selection
;table

;	char	walleft  wallright wallabove below
;	----   -------   -------   -------   -------
.byte	":"	;0	  0	    0	      0
.byte	8ah	;1	  0	    0	      0
.byte	89H	;0	  1	    0	      0
.byte	85H	;1        1         0	      0
.byte	8AH	;0	  0	    1	      0
.byte	8aH	;1	  0 	    1	      0
.byte	89H	;0	  1	    1	      0
.byte	81H	;1	  1	    1	      0
.byte	87H	;0	  0	    0	      1
.byte	88H	;1	  0	    0	      1
.byte	87H	;0	  1	    0 	      1
.byte	82H	;1	  1	    0	      1
.byte	86H	;0        0         1	      1
.byte	83H	;1	  0 	    1	      1
.byte	84H	;0	  1	    1	      1
.byte	80H	;1	  1	    1	      1

;--------------------------------------------------
selectit:
	lda	wallleft	;zero if wall to left
	call	bits		;ff if wall
	ani	01h		;put result in bit0
	mov	e,a
	lda	wallright
	call	bits			;ff if wall
	ani	02h		;put result in bit0
	ora	e
	mov	e,a
	lda	wallabove
	call	bits		;ff if wall
	ani	04h		;put result in bit0
	ora	e
	mov	e,a
	lda	wallbelow
	call	bits			;ff if wall
	ani	08h		;put result in bit0
	ora	e
	lxi	h,gc.table
	add	l
	mov	l,a
	mvi	a,0		;get approp. char
	adc	h
	mov	h,a
	mov	a,m
	mov	e,a	;character in E and A
	ret

;--------------------------------------------------
bits:	;if was 0, set all bits in A, else reset
;al the bits.
	ana	a
	mvi	a,0FFH
	rz
	xra	a
	ret

;--------------------------------------------------
DECOUT: ;types out the contents of HL on the console
;in decimal.

	PUSH	B
	PUSH	D
	PUSH	H
	LXI	B,-10
	LXI	D,-1
..LOOP:	DAD	B
	INX	D
	JC	..LOOP
	LXI	B,10
	DAD	B
	XCHG
	MOV	A,H
	ORA	L
	CNZ	DECOUT
	MOV	A,E
	ADI	'0'
	CALL	TYO
	POP	H
	POP	D
	POP	B
	RET

;--------------------------------------------------
INTEGER:	;convert a number in memory from 
;ASCII to Binary. HL points to string (null term!!)

	inx	h
	lxi	d,0
	xchg
..loop:	ldax	d
	sui	'0'
	ana	a
	rm
	cpi	10
	cmc
	rc
	inx	d
	dad	H
	push	h
	dad	h
	dad	h
	pop	b
	dAd	b
	mov	c,a
	mvi	b,0
	dad	b
	jmp	..loop

;--------------------------------------------------
BIN:	;gets a decimal figure of up to five digits
;and converts it into an integer. Integer in HL and
;the LSB in A reg.	
	push	b
	call	..on
	.byte	05	;buffer maximum
	.blkb	07	;buffer length
..on:	pop	h
	push	h
	xra	a
	mvi	b,7
..loop:	inx	h
	mov	m,a
	dcr	b
	jnz	..loop
	pop	d
	push	d
	mvi	c,10
	call	bdos
	pop	h
	inx	h
	call	integer
	mov	a,l
	POP	B
	RET


RNDR:	PUSH	B
	CALL	RND
	MOV	C,A
	MVI	B,0
RNDR1:	DCR	E
	JZ	RNDR2
	ADD	C
	JNC	RNDR1
	INR	B
	JMP	RNDR1
RNDR2:	MOV	A,B
	POP	B
	RET

RND:	PUSH	H
	PUSH	B
	LXI	H,SHIFT
	MVI	B,8
	MOV	A,M
RND1:	RLC
	RLC
	RLC
	XRA	M
	RAL
	RAL
	LXI	H,SHIFT
	MOV	A,M
	RAL
	MOV	M,A
	INX	H
	MOV	A,M
	RAL
	MOV	M,A
	INX	H
	MOV	A,M
	RAL
	MOV	M,A
	INX	H
	MOV	A,M
	RAL
	MOV	M,A
	DCR	B
	JNZ	RND1
	POP	B
	POP	H
	RET

MATRIX:	PUSH	D
	PUSH	PSW
	LDA	CMAX
	MOV	E,A
	MVI	D,0
	LXI	H,0
	MOV	A,B
MULT:	PUSH	B
	MVI	B,9
MULT1:	DCR	B
	JZ	MULT2
	DAD	H
	RAL
	JNC	MULT1
	DAD	D
	JMP	MULT1
MULT2:	POP	B
	MOV	E,C
	DAD	D
	LXI	D,MTX
	DAD	D
	POP	PSW
	POP	D
	RET

dot:	call	yxpos
	lda	dottype
	call	tyo
	ret

play::	call	settime
	lda	start.position
	mov	b,a
	add	b
	add	b	;a=spos*3
	adi	4
	sta	xhere
	sta	xwant
	mvi	a,1
	sta	yhere
	sta	ywant
	call	dot	;move to start position
loop::
	call	locate
	mvi	e,0
	lda	ywant
	ana	a
	jz	..nono
	dcr	a
	jz	..nono	;all moves on first wall bad
	dcr	a
	rar
;A=row number,carry=0 if doing passage row
;carry=1 if in wall row
	mov	d,a	;D=row E=WALL/PASSAGE
	mvi	e,2
	jnc	..hop	;2 is correct for passage
	mvi	e,4	;set up mask properly
..hop:

;calculate column
	lda	xwant
	mvi	c,0
	mvi	b,3
	sub	b	;subtract margin
	jc	..nono
..div:	inr	c
	sub	b
	jnc	..div
	dcr	c
	add	b
;A=mod,C=quotient
	sta	modulus	;save mod
	mov	b,d	;B=row,C=column
	call	matrix
	mov	a,m
;bit 1 set if in passage, bit 2 set if opening
	ana	e
	jnz	..could.be
	mov	a,e
	cpi	4
	jz	..nono	;horizontal line
	lda	modulus
	cpi	2
	jnc	..nono
	jmp	..ok
..could.be:
	mov	a,e
	cpi	4	;is this the wall line
	jnz	..ok
	lda	modulus
	cpi	2
	jnc	..nono
..ok:	lda	cmax
	cmp	c
	jz	..nono

	lda	bmax
	inr	b
	cmp	b
	jnz	..notwon
	mov	a,e
	ani	4
	jnz	..won
..notwon:
	call	..moveme
	jmp	loop

..moveme:	call	yxpos
	mvi	a,0d6H	;leave a snails trail
	call	tyo
	lda	xwant
	sta	xhere
	lda	ywant
	sta	yhere
	call	dot
	ret

..won:
	call	..moveme
	lxi	h,ywant
	inr	m
	call	..moveme
	print	"
 Well done, you won, in "
	lhld	seconds
	call	decout
	print	" seconds!"
	ret

..nono:
	mvi	a,07h
	call	tyo	;beep
	mvi	a,90H	;make hollow
	sta	dottype
	call	dot
	mvi	a,8FH
	sta	dottype
	jmp	loop

locate:
	lda	xhere
	sta	xwant
	lda	yhere
	sta	ywant	;initialise location

	call	curoff
..time.loop:
	call	gettime
	call	const
	ora	a
	jz	..time.loop
	call	tyi	;get key
	cpi	3
	jz	exit
	mvi	c,0
	mvi	b,12
	lxi	h,what.to.do
..interpret.loop:
	cmp	m
	jz	..aha
	inx	h
	inr	c
	dcr	b
	jnz	..interpret.loop	
	mvi	c,0
..aha:	
	mov	a,c	;get match no.
	ani	03h	;allow only four directions
;0=left,1=right,2=up,3=down
;0=decrement X,1=increment X,2=decrement Y, 3=increment Y.
	cpi	2
	jnc	..its.23
	lhld	xhere
	dcx	H
	ana	a
	jz	..its0
	inx	h
	inx	h
..its0:	shld	xwant
	ret
..its.23:
	lhld	yhere
	inx	h
	cpi	03
	jz	..its3
	dcx	h
	dcx	h
..its3:	shld	ywant
	ret

;left,right,up,down
what.to.do:	.byte	1dh,1ch,1eh,1fh,08h,0ch,0bh,0ah,13h,04h,05h,18h	

settime:
	lxi	h,0000
	shld	seconds
	mvi	c,105
	lxi	d,DAT	;doesnt seem to work!
	call	bdos
	sta	sec
	ret

sec:	.byte	000	;second hand

seconds:	.word	000	;elapsed time
	
gettime:
	mvi	c,105	;get the time
	lxi	d,DAT
	call	bdos
	lxi	h,sec
	cmp	m
	rz		;no need to update
	mov	m,a
	lhld	seconds
	inx	h
	shld	seconds	
	lda	Xhere
	mov	c,a
	lda	Yhere
	mov	b,a
	xra	a
	sta	yhere
	mvi	a,65
	sta	xhere
	push	b
	push	h
	call	yxpos
	pop	h
	call	decout
	print	" secs"
	pop	b
	mov	a,c
	sta	xhere
	mov	a,b
	sta	yhere
	ret



	

DAT:	.word	000
	.byte	000
	.byte	000
	.byte	000


modulus:	.byte	000
SHIFT:	.byte	0FFH
	.byte	0FFH,0FFH,0FFH
PFLAG:	.blkb	1
MFLAG:	.blkb	1
BMAX:	.blkb	1
CMAX:	.blkb	1
xmax:	.Word	1
ymax:	.Word	1
Xwant:	.word	000
Ywant:	.word	000
dottype:	.byte	08fH
to.printer:	.byte	000
Start.position:	.blkb	1

wallbelow:	.byte	000
wallleft:	.byte	000
wallabove:	.byte	000
wallright:	.byte	000


MTX:	.blkb	1600
MTXE:
PAGE:	.byte	FF,'$'
CRLF:	.byte	CR,LF,'$'

.2.spaces:	.ascii	"  $"
t.2.spaces:	.byte	" ",09ch,"$"
b.2.spaces:	.byte	" ",09ch,"$"

.3.spaces:	.ascii	"   $"
V.WALL:		.byte	" "," ",bar,"$"
.2.lines:	.byte	hoz.line,hoz.line,"$"

MAZ:	.ascii	'Maze Program for the EPSON QX+','$'
WIDE:	.byte	086h
	.ascii	'               How wide do you want the maze? --> ','$'
HIGH:	.byte	086H
	.ascii	'               How high do you want the maze? --> ','$'
AGAIN:	.ascii	'    Do you wish another one? --> ','$'
	.blkb	64
STACK:

.END	begin
