.title	[Character Editing Utility for QX+]
.ident	CHEDIT
.xlist	;surpress listing

.IF1,[ .PRNTX "Assembly pass no.1" ]
     [ .PRNTX "Assembly pass no.2" ]

;A.R.M.CLARKE Feb 1984
;Copyright (C) 1984

;----------------------------------------------------------------------------
.define hi.there  =	[
	   This utility changes the character set which appears on the screen
   in graphics mode and which appears on the printer when the printer is  set 
   to graphics mode. 
	   You can make temporary changes or permanent changes. The permanent
   changes  can be put in the version of CPM3.SYS by CONFIG or can  be  saved
   by this program for invocation by the command CHAREDIT A <filename> or for
   subsequent editing sessions.
	   This program can be used to keep a second character set and allows 
   the use of an alternate font for special purposes. The standard EPSON font
   can be restored by typing CHAREDIT Default
]
;----------------------------------------------------------------------------

;*** Absolute addresses ***
bdos	=	0005H	;CP/M entry point
BIOS	=	0001H
BDOS	=	0005H
BOOT	=	0000H
DFCB	=	005CH
DBUF	=	0080H

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

;*** Screen Design Values ***
VB.X	=	50	;margin for the blob character map
VB.Y	=	100	;where array starts


;*** Cursor control codes ***


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

	xwant:	.word	00	;requested screen position across
	ywant:	.word	00	;requested screen position down
	x.Crosshairs:	.word	00
	Y.Crosshairs:	.word	00
	xhere:	.word	00	;Current screen position across
	yhere:	.word	00,00	;Current screen location down

	CharVal:	.byte	00	;Temporary for character values
	is.first:	.byte	0FFH	;crosshairs control boolean

	Radix:	.byte	10		;temporary radix
	
	changed:	.byte	00	;boolean. Has anything changed?

;*** Marker Values ***

	Blob.marker	=	6
	circle.marker	=	3



;---------------------------------------------------------------------------
YXPOS:	;sends the character cursor to the location in Yhere Xhere
	PUSH	H
	PUSH	D
	PUSH	B	;save everything
	LXI	H,CLEAD1	;print lead-in
	CALL	MSG
	LDA	CB4LFG	;Do we do X or Y first?
	ANA	A
	JNZ	..REV	;Line first
	LDA	YHERE	;get line no.
	MOV	B,A
	LDA	LINOFF
	ADD	B	;addin line offset
	CALL	TYO	;out it goes
	LXI	H,CLEAD2	;get mid lead-in
	CALL	MSG	;send it
	LDA	XHERE	;get column
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

..REV:	LDA	XHERE	;do things backwards
	MOV	C,A	;for potty terminals
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


markstring:
	.byte	19	;count byte
	.byte	1bH,".",9
	.byte	3	;complement mode
	.byte	1BH,".",11
	.byte	1	;marker zoom
	.byte	1bh,".",12
m.type:	.byte	1	;marker type
	.byte	1bh,".",3	;draw.marker
X.vertex:	;filled in by the program
	.word	000
Y.vertex:	;filled in by the program
	.word	000
	.byte	000
		;end of string

Markpos:	;positions marker at vertices
	lxi	h,markstring	;get the string address
	call	msg	;and send it to the console
	ret


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

into.graphics:	;lets enter graphics mode
	
	  PUSH	H
	PUSH	D
	PUSH	B
	lxi	h,GRFiKS	;switch into graphics
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

pbyte:	;print byte in E on device selected
	mov	a,e	;it could go to the printer or the screen
	lhld	output
	pchl

output:	.word	tyo	;switch set to console output


pstring:	;until we get a $ sign
;string in DE

..LOOP:	ldax	d	;get a byte
	cpi	"$"	;is it the end of the string
	rz
	PUSH	d	;save pointer into string
	mov	e,a
	call	pbyte	;print it out
	pop	d
	inx	d	;point to next
	JMP	..LOOP




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


;----------------------------------------------------------------------------
AddHL:	;adds A to HL and leaves the result in HL
	add	l
	mov	l,a
	rnc
	inr	h
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


;----------------------------------------------------------------------------
drawdown:	;the whole screen a double line
	mvi	b,23	;the number of lines
..downloop:
	push	b
	lxi	h,Yhere	;get where we are
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
	sta	yhere	;zap the line position
	sta	xhere	;and the column position
	call	yxpos	;home the cursor
;draw the top border	
	mvi	a,087H		;a top left border
	call	tyo	;send a top-left bracket
	mvi	b,78
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
	sta	Yhere
	xra	a
	sta	Xhere	;go to the bottom left
	call	yxpos

;draw the bottom border	
	mvi	a,089H		;a bottom left border
	call	tyo
	mvi	b,78	;and now a nice horizontal line
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
	sta	Yhere	;home again
	call	drawdown
	mvi	a, 79	;we have drawn a vertical line
	sta	xhere
	xra	a	;go to the top right
	sta	yhere
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
	.byte	..end - .	;length of the string
	.byte	1BH,",","G",5,"C"	;define split screen
	.byte	1BH,"U"			;go to the upper
	.byte	1BH,"/"			;make multifont
	.byte	1BH,"#",6		;style 4
	.ascii	"   QX+ Character redefinition Utility"
	.byte	1BH,"V"	;enter the lower screen
	.byte	1BH,')'	;half intensity
..end:	.byte	000,000

ok:	.byte	..end - .
	.byte	ESC,'=',(18+' '),(26+' ')	;bottom centre
	.byte	1bh,'('		;full intensity
	.byte	1bh,"^"		;blink
	.ascii	"<Press any key to continue>"
	.byte	1bh,"q"		;cancel blink
	.byte	1bh,')'		;half intensity
..end:	.byte	00,00


tidy.up:	;set the screen to rights
	.byte	..end - .
	.byte	1bH,"+"
	.byte	1BH,"U",1BH,"\"
	.byte	1BH,"V",1BH,"U"		;dont ask
	.byte	1BH,",","G",26,"G"
	.byte	1BH,"+"
..end:	.byte	000,000

intro:

;	lxi	sp,stack
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
	jz	bye.bye
BEGIN:
	xra	a
	sta	changed
        LXI     SP,STACK        ; SET STACK POINTER

	call	into.graphics	;and enter graphics mode
	call	screen.clear
	call	nice.box	;a nice box round the screen
	call	ptitle	;print the title
try.again:
	lxi	h,start.string	;does he want to edit a file?
	call	mesag
	call	curon
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
	cnz	fillit	;parse the filename pointed to by HL
	print	"
					I'm loading the font
	"
	call	spout.to.console
..do.again:
	call	screen.clear	;clear the screen
	call	curoff	;switch on the cursor
	call	show.character.set
	xra	a
	dcr	a
	sta	is.first	;first marker
	call	curon
	print	"
Press <CR> to continue ----------------->"
	call	tyi
	cpi	3		;did he press break
	jz	bye.bye
	call	curoff
	call	screen.clear
	call	nice.box	;a nice box round the screen
	call	ptitle	;print the title
;return pointing to 
..once.more:

	call	dumpfont
	call	which.character
	call	edit.ikon
	lxi	h,again.string
	call	mesag
	call	curon
..repeat:
	call	tyi
	push	psw
	call	curoff
	pop	psw
	cpi	cr
	jz	..once.more
	cpi	esc
	jz	exit
	cpi	tab
	jnz	..repeat
	jmp	..do.again

;----------------------------------------------------------------------------
Exit:	;from the program
	call	curon
	lda	changed
	ana	a
	jz	bye.bye
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
	jz	sure	;temporarily
	inx	h
	mov	a,m
	cpi	esc
	jz	sure		;he pressed ESC
	dcx	h
	call	emptyit		;parse the filename pointed to by HL
bye.bye:
	call	screen.clear
	print	"my pleasure
"
	call	curon
	jmp	0000

sure:
	print	"
			Are you sure you do not want to save it? "
	call	yesorno
	ana	a
	jnz	bye.bye
	jmp	exit

;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;       SUPPORTING SUBROUTINES
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
title:	.byte	..end-title	;do the nice title
	.byte	1bH,".",00	;place cursor
	.word	6		;across
	.word	380
	.byte	1bh,".",13	;set height
	.byte	0		;text height
	.byte	1bh,".",14
	.byte	0		;eastwards
	.byte	1bH,".",1
	.byte	..end-.		;count
	.ascii	"               QX+ Character Redefinition Utility"
..end:	.byte	0,0,0,0 
Ptitle:
	lxi	h,title
	call	msg
	ret

	;
PRINTMESAG:	;print a prompt message in a prompt area
        push	b
	push	d
	PUSH    H               ; SAVE ADDR OF MESAG
        mvi	a,9
	sta	Yhere
	mvi	a,50
	sta	Xhere
	call	yxpos
	POP     H
       	call	mesag
	pop	d
	pop	b
	ret

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


;**** Graphics subroutines ****

line.msg:	.byte	17	;draw a line
	.byte	1bH,".",9	;preamble
	.byte	3	;complement mode
	.byte	1bH,'.',2	;preamble
x.strt:	.word	10	;start coordinate
y.strt:	.word	10
x.end:	.word	630	;end coordinate
Y.end:	.word	398
linemask:	;and the line mask for the line
	.word	0FFFFH
	.byte	00

draw.a.line:	;draws a graphics line
	lxi	h,line.msg	;print the string
	call	msg
	ret	

do.shape:	;HL points to a integer list that is null terminated,
;being a shape that is null terminated XY,XY,XY,XY
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	mov	a,e
	ora	d
	rz		;return if null integer
	xchg
	shld	x.strt
	xchg
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	xchg
	shld	y.strt
	xchg
	push	h	;save pointer to next pair
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	xchg
	shld	x.end
	xchg
	mov	e,m
	inx	h
	mov	d,m
	mov	a,e
	ora	d
	pop	h
	rz
	push	h
	xchg
	shld	y.end
	call	draw.a.line
	pop 	h	
	jmp	do.shape

draw.screen:
	ret
	
;
;
;----------------------------------------------------------------------------
Dumpline:	;of characters from the graphics font onto the screen
	MVI	B,75	;do 76 per line
	LXI	H,CHARVAL	;our current character value

..loop:	MOV	A,M	;get current ASCII value
	cpi	0DAH	;we do not have the rest
	rz	;so return flagged Zero
	INR 	M	;and increment Character Value
	call	tyo
	djnz	..loop
	xra	a
	dcr	a	;set non zero, more to do
	ret


;----------------------------------------------------------------------------
DUMPFONT:	;dumps the current font at the base of the display

	mvi	a,32	;first printable ASCII character
	sta	charval	;start with the first printable character
	MVI	A,21	;lets start here, chaps
	STA	YHERE
	MVI	A,2	;on the third column
	STA	XHERE
..loop1:
	call	yxpos	;put the cursor there
	call	dumpline	;and print out a line of characters
	rz		;go home, job done
	lxi	h,yhere	;on to next line
	inr	m
	jmp	..loop1	;do the next line

;----------------------------------------------------------------------------
findchar:	;find the font character location on the screen whose code
;is in Current.Char

	mvi	a,32	;first printable ASCII character
	sta	charval
	MVI	A,21	;lets start here, chaps
	STA	YHERE
..loop1:
	MVI	A,2
	STA	XHERE
	call	seekline	;run our finger along the line
	rz		;go home, job done
	lxi	h,yhere	;on to next line
	inr	m
	jmp	..loop1

seekline:
	MVI	B,75	;go to first position
	LXI	H,CHARVAL

..loop:	lda	current.char
	cmp	m	;is it the one?
	rz	;yes, Xhere and Yhere are set correctly
	cpi	0dah	;are we over the top
	rz		;prevent endless loop!
	INR 	M
	lda	xhere
	inr	a	;bump Xhere
	sta	xhere
	djnz	..loop
	xra	a
	dcr	a	;set non zero, more to do
	ret

;----------------------------------------------------------------------------
disp.char:	;display the character in Current.Char in the correct place
;at the bottom of the screen
	call	findchar	;find the right screen location
	call	yxpos		;place it
	lda	current.char	;get the current Ascii value of the char.
	call	tyo		;and write it on the screen
	ret


;*** Blow Up Character Representarion procedures ***


blobstring:	;the string that defines a blob
	.byte	19	;count byte
	.byte	1bH,".",9	;preamble
	.byte	1	;replace  mode
	.byte	1BH,".",11	;preamble
	.byte	1	;marker zoom
	.byte	1bh,".",12	;preamble
blob.type:	;it could be a blob or a circle
	.byte	1	;marker type
	.byte	1bh,".",3	;draw.marker
X.blob:
	.word	000
Y.blob:
	.word	000	;the location of the blob or circle
	.byte	000
	
;----------------------------------------------------------------------------
blob.position:	;positions marker at vertices
	lxi	h,blobstring
	call	msg	;do a blob
	ret

;----------------------------------------------------------------------------
DrawBlob:	;Draws a blob marker on the screen at the location defined
;by X.Crosshairs and Y.Crosshairs
	mvi	a,blob.marker	;make it a blob
backwards:	;start of common code
	sta	blob.type	;put it in the string
	call	convert.to.verts	;get the correct location
	shld	X.Blob	;and put it in the string
	xchg
	shld	Y.Blob
	call	blob.position	;and put the blob there
	ret

;----------------------------------------------------------------------------
DrawCircle:	;Draws a circle on the screen at the location defined
;by X.Crosshairs and Y.Crosshairs
	mvi	a,Circle.marker	;define the circle marker
	jmp	backwards	;and go to common code

;----------------------------------------------------------------------------
do.blow.up:	;display a blown-up representation of the pixel character
;as an 8 by 16 representation. Character in the buffer

	lxi	h,charbuffer	;point to the character definition bytes
	mov	a,m	;get the byte
	mvi	c,0	;C is the font char row count
..1loop:
	mvi	b,8
;Draw Row loop

..loop2:
	rar	;rotate the LSB into Carry
;is the bit set?
	push	h
	push	b
	push	psw
	push	psw	;save the byte under ezamination
	mov	a,b
	dcr	a
	sta	X.Crosshairs	;position within the byte
	mov	a,c	;the byte in the character
	sta	Y.Crosshairs
	cc	drawblob	;if bit set,dray a blob
	pop	psw
	cnc	drawcircle	;or a circle
	pop	psw		;
	pop	b
	pop	h
	djnz	..loop2	;and do next bit
	inx	h	;or the next byte
	inr	c
	mov	a,c
	cpi	16
	mov	a,m	;get the next byte
	jrnz	..1loop	;
	xra	a
	dcr	a
	sta	is.first	;first marker
	ret

;----------------------------------------------------------------------------
rub.crosshairs:	;from the screen
	lxi	h,is.first	;if nothing there then nowt to do
	mov	a,m	;get the truth of it
	ana	a
	mvi	M,0ffH			;there anint going to be any
	sta	is.first	;because we are about to wipe it
	cz	markpos		;to rub out old one
	ret


;----------------------------------------------------------------------------
move:	;The crosshairs to the pixel addressed by Y.Crosshairs and X.Crosshairs

	lda	is.first	;is it the first crosshair write
	ana	a
	mvi	a,0
	sta	is.first	;no longer
 	cz	markpos		;to rub out old one
	call	convert.to.verts	;get the vertices of our position
	shld	x.Vertex
	xchg
	shld	Y.Vertex
	call	markpos	;and put the marker there
	ret

;----------------------------------------------------------------------------
Convert.to.verts:	;converts the Y.Crosshairs and X.Crosshairs to a coordinate 
;vertex pair which is retuned HL=X DE=Y
	lxi	h,Y.Crosshairs		;we are in an 8*8 cell
	mvi	a,15
	sub	m
	add	a
	add	a
	add	a
	add	a		;times sixteen
	lxi	H,VB.Y
	call	AddHL	;add to line of start of blob array
	push	h	;save this
	lda	X.Crosshairs	;get the column
	add	a
	add	a
	add	a
	add	a	;and do likewise
;times sixteen
	lxi	H,VB.X
	call	AddHL
	pop	d
	ret	;HL=X vertex, DE=Y vertex


;----------------------------------------------------------------------------
locate:	;gets the users input from cursor or wordstar keys and interprets
;this as a location request in XWant YWant or a blob.change request
	call	move	;move and display the cursor
	lda	X.Crosshairs
	sta	xwant
	lda	Y.Crosshairs
	sta	ywant	;initialise location

	call	curoff	;switch off the cursor
	call	tyi	;get key
	cpi	3	;did he request an abort?
	jz	exit	;control C to abort
	cpi	esc
	jnz	..notend
	call	rub.crosshairs
	ret
..notend:
	cpi	' '	;did he want to clear the blob
	jc	..move.request	;no, it was a crosshair move request
	jz	reset.bit	;if pressed space bar
	jmp	set.bit		;if pressed any ascii key
..move.request:
	mvi	c,0
	mvi	b,12
	lxi	h,what.to.do
..interpret.loop:	;interpret what he wanted
	cmp	m
	jz	..aha
	inx	h
	inr	c
	dcr	b	;try to match the byte
	jnz	..interpret.loop	
	mvi	c,0
..aha:	
	mov	a,c	;get match no.
	ani	03h	;allow only four directions
;0=left,1=right,2=up,3=down
;0=decrement X,1=increment X,2=decrement Y, 3=increment Y.
	cpi	2
	jnc	..its.23
	lhld	X.Crosshairs
	dcx	H
	ana	a
	jz	..its0
	inx	h
	inx	h
..its0:	shld	xwant
	stc		;signal success
	ret
..its.23:
	lhld	Y.Crosshairs
	inx	h
	cpi	03
	jz	..its3
	dcx	h
	dcx	h
..its3:	shld	ywant
	stc		;signal success
	ret

;left,right,up,down
what.to.do:	.byte	1dh,1ch,1eh,1fh,08h,0ch,0bh,0ah,13h,04h,05h,18h	


;----------------------------------------------------------------------------
set.bit:	;defined by Y.Crosshairs and X.Crosshairs
	call	rub.crosshairs
	call	DrawBlob	;show that the bit is set
	lda	X.Crosshairs
	lxi	h,bit.mask	;which bit did he want to set
	call	AddHL	;get the right mask
	mov	C,M	;stash it
	lxi	h,charbuffer
	lda	Y.Crosshairs	
	call	addhl	;point to byte in ikon
	mov	a,c	;get the mask
	ora	m	;strip off the bit
	jmp	common

;----------------------------------------------------------------------------
reset.bit:	;defined by Y.Crosshairs and X.Crosshairs
	call	rub.crosshairs
	call	drawcircle	;reset the blob
	lda	X.Crosshairs	;which bit to reset
	lxi	h,bit.mask
	call	AddHL	;get the mask
	mov	a,m	;get mask in C
	cma	;invert the mask
	mov	c,a
	lxi	h,charbuffer
	lda	Y.Crosshairs	
	call	addhl	;point to byte in ikon
	mov	a,c	;get the mask
	ana	m	;strip off the bit
common:
	mov	m,a
	call	redefine	;and blow new character to the console
	call	disp.char	;update the font display
	call	upd.char	;its representation
	xra	a
	dcr	a
	sta	is.first
	call	move
	mvi	a,0ffh
	sta	changed
	stc	;signal success
	ret


Edit.Ikon:	;move the cursor around the blown-up character
;editing the Ikon and updating the BDOS temporarily at each stage
	lxi	h,help.string
	call	mesag
	call	dumpfont
	call	Do.Blow.Up
	xra	a
	sta	X.Crosshairs
	sta	Y.Crosshairs
;make the cursor go to the corner
..loc.loop:
	call	locate
	jc	..hoppity
	lxi	h,blank.string
	call	mesag
;save the bit pattern of the character from the
;buffer and put it in NEWFONT
	lda	current.char
	sui	" "
	mov	l,a
	mvi	h,0
	dad	h
	dad	h
	dad	h
	dad	h		;*16
	lxi	d,newfont#
	dad	d
	lxi	d,charbuffer
	xchg
	lxi	b,16
	ldir
	ret		;he aborted or terminated
..hoppity:
	lda	xwant
	ana	a
	jp	..dats.ok
	mvi	a,0
..dats.OK:
	cpi	8
	jc	..legal
	mvi	a,7
..legal:
	sta	X.Crosshairs
	lda	Ywant
	ana	a
	jp	..yus.ok
	mvi	a,0
..yus.OK:
	cpi	16
	jc	..1legal
	mvi	a,15
..1legal:
	sta	Y.Crosshairs
	jmp	..loc.loop


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
	.ascii	"save onto-->     "
	.byte	08,08,08,08
		.byte	00,00

again.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"To Edit another character "
	.byte	esc,"=",4+32,50+32
	.ascii	"press <CR>;   If finished "
	.byte	esc,"=",5+32,50+32
	.ascii	"press <ESC>;  To view the "
	.byte	esc,"=",6+32,50+32
	.ascii	"entire character set then "
	.byte	esc,"=",7+32,50+32
	.ascii	"press <TAB>.-->    "
	.byte	08,08,08,08
	.byte	000,000,000

start.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Press <CR> to edit the    "
	.byte	esc,"=",4+32,50+32
	.ascii	"alternate font. If you    "
	.byte	esc,"=",5+32,50+32
	.ascii	"wish to edit a font that  "
	.byte	esc,"=",6+32,50+32
	.ascii	"is on a disk file, then   "
	.byte	esc,"=",7+32,50+32
	.ascii	"type its name >"
	.byte	000,000,000


prompt.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Which character would you"
	.byte	esc,"=",4+32,50+32
	.ascii	"like to edit? (Just press"
	.byte	esc,"=",5+32,50+32
	.ascii	"the key, press return to "
	.byte	esc,"=",6+32,50+32
	.ascii	"enter its value or ESC if"
	.byte	esc,"=",7+32,50+32
	.ascii	"finished)----->"
	.byte	000,000,000
	.byte	000,000,000

val.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Values can be given in Hex"
	.byte	esc,"=",4+32,50+32
	.ascii	"Binary Octal or Decimal. "
	.byte	esc,"=",5+32,50+32
	.ascii	"values other than Dec need"
	.byte	esc,"=",6+32,50+32
	.ascii	"to be followed by H O or B"
	.byte	esc,"=",7+32,50+32
	.ascii	"-------------->"
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
	.byte	000,000,000



bad.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Unfortunately, that is not"
	.byte	esc,"=",4+32,50+32
	.ascii	"a modifiable character.   "
	.byte	esc,"=",5+32,50+32
	.ascii	"Try again.  The Modifiable"
	.byte	esc,"=",6+32,50+32
	.ascii	"characters are between 20H"
	.byte	esc,"=",7+32,50+32
	.ascii	"and 0DAH-----> "
	.byte	000,000,000


help.string:

	.byte	esc,"=",3+32,50+32
	.ascii	"Please use the cursor keys"
	.byte	esc,"=",4+32,50+32
	.ascii	"to move the + cursor over "
	.byte	esc,"=",5+32,50+32
	.ascii	"the pixel to change. Press"
	.byte	esc,"=",6+32,50+32
	.ascii	"<space> to blank it: * to "
	.byte	esc,"=",7+32,50+32
	.ascii	"set it:  ESC when finished"
	.byte	000,000,000

sel.string:	
	.byte	esc,"=",10+32,50+32
	.asciz	"selected value of char.="

rep.string:	
	.byte	esc,"=",11+32,50+32
	.asciz	"Currently displays -->"


which.character:	;gets from the user the character to be edited
	lxi	h,prompt.string
	call	mesag
	call	curon
..again:
	call	tyi
	cpi	esc
	jz	exit
	cpi	" "
	cc	get.value
	cpi	0dBH
	jc	..over
	lxi	h,bad.string
	call	mesag
	jmp	..again
..over:
	sta	current.char
	call	curoff
	lxi	h,blank.string
	call	mesag
	lxi	h,sel.string
	call	mesag
	lda	current.char
	mov	l,a
	mvi	h,0
	call	decout
	mvi	a," "
	call	tyo 
;get the bit pattern of the character into the
;buffer
  	lda	current.char
	sui	" "
	mov	l,a
	mvi	h,0
	dad	h
	dad	h
	dad	h
	dad	h		;*16
	lxi	d,newfont#
	dad	d
	lxi	d,charbuffer
	lxi	b,16
	ldir
upd.char:

	lxi	h,rep.string
	call	mesag
	lda	current.char
	call	tyo
	ret

get.value:
	lxi	h,val.string
	call	mesag
..again:
	call	bin
	cpi	" "
	jc	..eech
	cpi	0dBH
	rc
..eech:	lxi	h,bad.string
	call	mesag
	jmp	..again


char.string:	;the current string to redefine
	.byte	16+3
	.byte	esc,"!"	;Preamble
current.char:	.byte	00
charbuffer:
	.byte	00	;test values
	.byte	01
	.byte	02
	.byte	04
	.byte	08
	.byte	10
	.byte	20
	.byte	40

	.byte	80
	.byte	81
	.byte	84
	.byte	88
	.byte	90
	.byte	91
	.byte	92
	.byte	94
ch.st.end:
	.byte	00		


redefine:	;the character at BDOS level
	lxi	h,char.string
	call	msg
	ret


bit.mask:	;dirty algorithm but what the heck
.byte	10000000B
.byte	01000000B
.byte	00100000B
.byte	00010000B
.byte	00001000B
.byte	00000100B
.byte	00000010B
.byte	00000001B

;----------------------------------------------------------------------------
show.character.set:	;on the screen with hex values for each

	mvi	a,32	;first printable ASCII character
	sta	charval	;start with the first printable character
	MVI	A,0	;lets start here, chaps
	STA	YHERE
	MVI	A,0	;at the beginning of the line
	STA	XHERE
	call	yxpos
	print	" Entire Graphics Character Set and Hex values"
	MVI	A,2	;lets start here, chaps
	STA	YHERE
	MVI	A,0	;at the beginning of the line
	STA	XHERE
..loop1:
	call	yxpos	;put the cursor there
	call	dump.a.line	;and print out a line of characters
	rz		;go home, job done
	lxi	h,yhere	;on to next line
	inr	m
	jmp	..loop1	;do the next line

;
;----------------------------------------------------------------------------
Dump.a.line:	;of characters from the graphics font onto the screen
;eg:---
;20H-	21H- !	22H- "	23H- #	24- $	25- %	26- &	27- '	29- (	3A- )
;
	MVI	B,10	;do 10 per line
	LXI	H,CHARVAL	;our current character value

..loop:	MOV	A,M	;get current ASCII value
	cpi	0DbH	;we do not have the rest
	rz	;so return flagged Zero
	INR 	M	;and increment Character Value
	push	h
	push	b
	push	psw
	call	hexout
	print	"H- "
	pop 	psw
	pop	b
	pop	h
	call	tyo
	mvi	a,tab
	call	tyo
	djnz	..loop
	xra	a
	dcr	a	;set non zero, more to do
	ret

;----------------------------------------------------------------------------
send.alternate:	;character set to the console
	call	read.font


spout.to.console:
	lxi	h,newfont#
	jmp	spit.it.out

def.preamble:
		.byte	3
		.byte	ESC,"!"
our.char:	.byte	" ",00


;----------------------------------------------------------------------------
send.default:	;font to the console
	lxi	h,defaunt#
spit.it.out:

	mvi	b,0DaH-" "	;no. to do in B
	mvi	c," "
..loop:
	mov	a,c		;get character
	sta	our.char
	push	b
	push	h
	lxi	h,def.preamble
	call	msg
	pop	h
	mvi	b,16
..inner.loop:
	mov	a,m
	call	tyo
	inx	h
	djnz	..inner.loop
	pop	b
	inr	c
	djnz	..loop	
	ret	



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
	jmp	0000	;abort

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

fnt.string:	.ascii	'FNT'

;----------------------------------------------------------------------------
fillit:	;fill the alternate font set from the filename pointed to by HL
	ifile		;make our input file the current one
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
	jmp	fillit

..ok:
get.that.one:
	ftad
	lxi	d,fnt.string
	xchg
	lxi	b,3
	ldir
	call	open
	lxi	h,newfont#
	mvi	b,0DAH-" "	;no. to do in B
..loop:
	push	b
	mvi	b,16
..inner.loop:
	push	b
	push	h
	call	getbyte
	mov	e,a	;put it in E
	EOF%
	mov	a,m
	ana	a	;have we reached the end?
	pop	h
	pop	b
	mov	m,e	;put byte in memory
	rnz
	inx	h
	djnz	..inner.loop
	pop	b
	inr	c
	djnz	..loop	
	ret	

	
;----------------------------------------------------------------------------
EmptyIt:	;empty the contents of the alternate font into a file
;with the user-supplied name

	Ofile		;make our input file the current one
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
	ftad
	lxi	d,fnt.string
	xchg
	lxi	b,3
	ldir
	call	Wopen
	lxi	h,newfont#
	mvi	b,0DAH-" "	;no. to do in B
..loop:
	push	b
	mvi	b,16
..inner.loop:
	push	b
	push	h
	mov	a,m
	call	Putbyte
	pop	h
	pop	b
	inx	h
	djnz	..inner.loop
	pop	b
	inr	c
	djnz	..loop	
	call	close
	ret	


;-----------------------------------------------------------------------------
read.font:	;from disk into the alternate font
	ifile
	fcb
	xchg
	lxi	h,dfcb+16	;get it from the second DFCb
	lxi	b,16
	ldir
	jmp	get.that.one



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


	.blkb	128		;64-WORD STACK
STACK:
.list

.end	intro
