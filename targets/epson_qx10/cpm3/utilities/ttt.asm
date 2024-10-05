

.title	[Three dimensional Tic-Tack-Toe for the EPSON QX+]
.ident	TTT
.xlist	;surpress listing

.define hi.there  =	[
	This is a game of three-dimensional noughts and crosses. Unlike
	the conventional game, this involves laying four, not three, of
	your pieces in a straight line. An added complication is that,
	with four boards, a straight line can be in any dimension in any
	diagonal or plane. You play first and make your move by using
	the cursor control keys on the right of the main keyboard to the
	desired position on any of the four boards. When you want to
	place your cross, you press the X key. The computer will ponder
	your move and play its nought, leaving the marker in the position
	that it has just played. It is then your turn again. When a winning
	position has been played, the computer will tell you who has won and
	highlight the winning row. When you have inspected the board, then
	just press any key. At any time, pressing ^C aborts the program
	and ESC restarts the game. The computer plays with contemptuous
	ease, but do not worry, you can press its ^C, but it cannot do the
	same to you.		Good luck]


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
ESC     =     1BH		;ESCAPE CHAR FOR CURSOR CONTROL
BSPACE  =     08		;BACKSPACE
TAB     =     09H

;*** Cursor control codes ***

CUP	=	0bh		;CURSOR UP
CDOWN	=	0ah		;CURSOR DOWN
CRIGHT	=	0ch		;CURSOR RIGHT
CLEFT	=	08H		;CURSOR LEFT
CHOME	=	1CH		;CURSOR HOME
CLRS	=	1AH		;CLEAR SCREEN
;
WIDTH   =     14
SPACING =     3

	.ASCII	"COPYRIGHT MML Ltd (C) 1983"
;*** ALL PATCHES AS IN WORDSTAR ***
clear:	.byte	02,27,'+',00,00,00
CLEAD1:	.BYTE	02,27,61
	.BYTE	00,00,00,00,00,00
CLEAD2:	.BYTE	00,00,00,00,00,00
CTRAIL:	.BYTE	00,00,00,00,00,00
CB4LFG:	.BYTE	false
LINOFF:	.BYTE	20H
COLOFF:	.BYTE	20H
on.cursor:	.byte	02,1bh,'3',00
off.cursor:	.byte	02,1bh,'2',00
Upper.screen:	.byte	2,1bH,"U",00
Lower.screen:	.byte	2,1BH,"V",00
GRFiKS:		.byte	2,1BH,'G',00
no.grfix:	.byte	2,1bh,'H',00


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


markstring:
	.byte	19	;count byte
	.byte	1bH,".",9
	.byte	3	;complement mode
	.byte	1BH,".",11
	.byte	1	;marker zoom
	.byte	1bh,".",12
m.type:	.byte	2	;marker type
	.byte	1bh,".",3	;draw.marker
X.vertex:
	.word	000
Y.vertex:
	.word	000
	.byte	000
	

Markpos:	;positions marker at vertices
	lxi	h,markstring
	call	msg
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

TYO:	push	h
	push	d
	push	b
	MOV	C,A
	call	CONOUT
	pop	b
	pop	d
	pop	h
	ret

lyo:	mov	c,a
	jmp	list

TYI:	push	h
	push	d
	push	b
	call	CONIN
	pop	b
	pop	d
	pop	h
	ret

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
	mvi	a,4
	sta	yhere
	mvi	a,60
	sta	xhere
	push	b
	push	h
	call	yxpos
	pop	h
	LXI	B,-60
	LXI	D,-1
..LOOP:	DAD	B
	INX	D
	JC	..LOOP
	LXI	B,60		;do minutes
	DAD	B
	XCHG			;mins in HL
	mov	a,l
	ora	h
	jz	..hop
	push	d
	call	decout
	print	" mins. "
	pop	d
..hop:	xchg
	call	decout
	print	" secs."
	pop	b
	mov	a,c
	sta	xhere
	mov	a,b
	sta	yhere
	call	yxpos
	ret



	

DAT:	.word	000
	.byte	000
	.byte	000
	.byte	000

hello.string:
	.byte	..end - .
	.byte	1BH,",","G",5,"C"	;define split screen
	.byte	1BH,"U"			;go to the upper
	.byte	1BH,"/"			;make multifont
	.byte	1BH,"#",4		;style 4
	.ascii	"   Welcome to 3D noughts and Crosses."
	.byte	1BH,"V"
..end:	.byte	000,000

ok:	.byte	..end - .
	.byte	1BH,"^"
	.byte	0DH,0AH
	.ascii	"<PRESS ANY KEY TO CONTINUE>"
	.byte	1BH,"q"
..end:	.byte	00,00

tidy.up:
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
	cpi	31H
	jc	..bad
	mov	a,h
	ana	a
	jz	..good
..bad:
	print	"   Sorry, but it must be Epson QX+ to run the program

"
	jmp	0000h 
..good:

	lxi	h,hello.string
	call	msg
	print	hi.there
	lxi	h,ok
	call	msg
	call	tyi
	lxi	h,tidy.up
	call	msg

BEGIN:
        LXI     SP,STACK        ; SET STACK POINTER
        MVI     B,65            ; CLEAR THE BOARD
        LXI     H,MOVEARY
        XRA     A
CLOOP:
        MOV     M,A
        INX     H
        DCR     B               ; CLEAR ALL 64 SQUARES
        JNZ     CLOOP
	call	into.graphics
	call	screen.clear
	call	nice.box
	call	ptitle
	call	draw.screen
	call	curoff
	xra	a
	dcr	a
	sta	is.first	;first marker
	call	settime
	mvi	a,4
	sta	new.board.pointer
	mvi	a,1
	sta	new.row.pointer
	sta	new.column.pointer
	call	move		;to the first position

GETMOVE:
        LXI     H,MSG1          ; PRINT "ENTER YOUR MOVE"
GETX:	CALL	PRINTMESAG
GETNEXT:
        CALL    COPYPOSITION    ; START BY DEFAULTING TO CURRENT POSITION
..wait:
	call	gettime
	call	const
	ana	a
	jz	..wait
        CALL    tyi              ; THEN GET PLAYERS KEYBOARD INPUT
        MOV     B,A             ; RESPONSE WILL BE SAVED IN B
        LXI     D,CHARLIST-2    ; SCAN LIST OF OK CHARS & JUMP
GLOOP:
        INX     D               ; PRE-INCREMENT
        INX     D
        LDAX    D               ; GET CHAR FROM TABLE
        ORA     A               ; TEST FOR END OF LIST
GETERROR:
        LXI     H,MSG2          ; JUST IN CASE BAD CHAR
        JZ      GETX            ; BAD CHAR -> GO PRINT "TRY AGAIN"
        INX     D               ; NOW POINT TO JUMP ADDRESS
        CMP     B               ; COMPARE CHAR TO THAT KEY'D IN
        JNZ     GLOOP           ; NO LUCK ?!
        LDAX    D               ; EL-KLUGE-O INDIRECT JUMP
        MOV     L,A
        INX     D
        LDAX    D
        MOV     H,A
        LXI     D,GETNEXT       ; SET-UP FAKE 'CALL' RETURN
        PUSH    D
        PCHL                    ; WHITHER WANDEREST THOU .....
;
CHARLIST:
        .byte      1eH
        .Word         UP
        .byte      1fh
        .Word         DOWN
        .byte      1Dh
        .Word         LEFT
        .byte      1ch
        .Word         RIGHT
        .byte      'X'
        .Word         GOTMV
       	.byte	'x'
	.word		gotmv
	 .byte      esc
        .Word         BEGIN
        .byte      03H			;control C
        .Word         exit		;RETURN TO BDOS
        .byte      'O'
        .Word         YOUMOVE
        .byte      0
;
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;       JUMP TABLE HANDLERS
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;
UP::
        LXI     H,New.Row.Pointer           ; INCREMENT NEW ROW POINTER
        MOV     A,M
        INR     A
        MOV     M,A
        CPI     5               ; DO WE HAVE TO BUMP TO NEXT BOARD ?!
        JC      MOVE            ; NOPE -> SIMPLY GO MOVE
        MVI     M,1             ; GOING TO ROW 1 OF NEXT BOARD
        JMP     BDINC           ; INCREMENT BD, TESTING FOR WRAPAROUND
;
;
DOWN::
        LXI     H,New.Row.Pointer           ; DECREMENT NEW ROW POINTER
        DCR     M
        JNZ     MOVE            ; OK -> STILL ON SAME BOARD
        MVI     M,4             ; TOP ROW OF NEXT BOARD
        JMP     BDDEC           ; GO DECREMENT BD PTR, TESTING FRO WRAPAROUND
;
;
RIGHT::
        LXI     H,New.Column.Pointer           ; INCREMENT NEW COLUMN POINTER
        MOV     A,M
        INR     A
        MOV     M,A
        CPI     5               ; OFF BOARD ?!
        JC      MOVE            ; NOPE -> SIMPLY GO MOVE
        MVI     M,1             ; END UP IN COLUMN ONE
;
BDINC:
        LXI     H,New.Board.Pointer           ; INCREMENT NEW BOARD POINTER
        MOV     A,M
        INR     A
        MOV     M,A
        CPI     5               ; GOING BEYOUND BOARD #4 ?!
        JC      MOVE            ; NOPE SIMPLY GO MOVE
        MVI     M,1             ; ELSE WRAPAROUND TO BD # 1
        JMP     MOVE
;
;
LEFT::
        LXI     H,New.Column.Pointer           ; DECREMENT NEW COLUMN POINTER
        DCR     M
        JNZ     MOVE            ; OK -> NOT GOING TO BD #0
        MVI     M,4             ; ELSE WRAPAROUND
;
BDDEC:
        LXI     H,New.Board.Pointer           ; DECREMENT NEW BOARD POINTER
        DCR     M
        JNZ     MOVE            ; OK NO WRAPPING
        MVI     M,4
        JMP     MOVE            ; GO AND WRAP IT
;
;
YOUMOVE:
        POP     D               ; POP PHONNEY RETURN ADDR
        JMP     STRCALL         ; GO CALL STRAT SUBR.
;

occerror:
	lxi	h,msg7
	call	printmesag
	jmp	getnext
;
GOTMV:
        POP     D               ; POP PHONNEY RETURN ADDR
        LXI     H,Board.pointer            ; CONVERT BOARD POSITION INTO INDEX
        MOV     A,M
        DCR     A               ; 16*(Board.pointer-1)
        ADD     A
        ADD     A
        ADD     A
        ADD     A
        MOV     B,A
        INX     H
        MOV     A,M
        DCR     A               ;  + 4*(Old.Row.Pointer-1)
        ADD     A
        ADD     A
        INX     H
        ADD     M               ;   + Old.Column.Pointer
        ADD     B
        LXI     H,MOVEARY
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MOV     A,M
        ORA     A
        JNZ     occERROR        ; SQUARE ALREADY OCCUPIED !
        MVI     M,1             ; ELSE LET'M HAVE IT
	mvi	a,0FFH
	sta	isx
	call	dopiece
STRCALL:
	LXI	H,MSG3		; PRINT
	CALL	PRINTMESAG	;  "I'M THINKING"
	CALL	STRAT		; CALL STRATEGY ROUTINE
        LDA     M3
        CPI     3
        JP      L18
        CPI     1
        MVI     A,090H		;'O'
        LXI     H,MSG5
        JNZ     L15             ; JUMP IF WE'VE WON
        MVI     A,'X'
	LXI	H,MSG6		;HE WON
L15:
	STA	K8
	CALL	PRINTMESAG
L15E:
        LDA     M1
        DCR     A
        MOV     L,A
        MVI     H,0
        DAD     H
        DAD     H
        INX     H
        LXI     D,ROW
        DAD     D
        MVI     D,4
L16:
        MOV     A,M
        CALL    PLACEIT
        PUSH    H
        PUSH    D
        CALL    MOVE
        LDA     K8
	cpi	" "
	jz	..noshow
	cpi	'X'
	mvi	a,0FFH
	jz	..is.x
	mvi	a,0
..is.x:	sta	isx
	call	dopiece
..noshow:
        POP     D
        POP     H
        DCR     D
        INX     H
        JNZ     L16
        LDA     K8
        CPI     ' '
        JZ      L17A
        STA     J8
        MVI     A,' '
        JMP     L17B
L17A:
        LDA     J8
L17B:
        STA     K8
        CALL    const
	ORA	A
        JZ      L15E
	call	tyi	;clear the kbd buffer
	mvi	a,21
	sta	Yhere
	mvi	a,5
	sta	Xhere
	call	yxpos
        call	curon
	print	"I enjoyed that. Another game? (Y/N)---> "
	call	yesorno
	ana	a
	Jnz     BEGIN
exit:	call	screen.clear
	call	gra.off
	print	"thank you for playing me. I like a game occasionally"
	jmp	0000
L18:
        LDA     M1
        ORA     A
        JNZ     L13A
        LDA     old.board.pointer
        MOV     E,A
        MVI     D,0
L14:
        LXI     H,WAIT
        DAD     D
        MOV     C,M
        MVI     B,0
        LXI     H,MOVEARY               ; WE'RE GETTING A WAITING MOVE
        DAD     B
        MOV     A,M
        ORA     A
        JZ      L13
        INX     D
        MVI     A,21
        CMP     E
        JNZ     L14
	LXI	H,MSG4
        CALL    PRINTMESAG      ; PRINT "TIE GAME"
        CALL    tyi              ; WAIT FOR INPUT
        JMP     BEGIN
L13A:
        MOV     C,A
        LXI     H,MOVEARY
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
L13:
        MVI     M,5             ; CLAIM SQUARE FOR US 
        MOV     A,C
        CALL    PLACEIT
        CALL    MOVE
	xra	a
	sta	isx		;draw our O
	call	dopiece
        JMP     GETMOVE         ; GET OPPONENTS RESPONSE
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;       SUPPORTING SUBROUTINES
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
title:	.byte	..end-title
	.byte	1bH,".",00	;place cursor
	.word	6		;across
	.word	380
	.byte	1bh,".",13	;set height
	.byte	1		;text height
	.byte	1bh,".",14
	.byte	0		;eastwards
	.byte	1bH,".",1
	.byte	..end-.		;count
	.ascii	"Epson QX+ 3D Noughts-and-crosses. MML:"
..end:	.byte	0,0,0,0 
Ptitle:
	lxi	h,title
	call	msg
	ret

	;
PRINTMESAG:
        push	b
	push	d
	PUSH    H               ; SAVE ADDR OF MESAG
        mvi	a,22
	sta	Yhere
	mvi	a,5
	sta	Xhere
	call	yxpos
	POP     H
       	call	mesag
	pop	d
	pop	b
	ret

;
MESAG:
	MOV	A,M
	INX	H
	ORA	A
	RZ
	CALL	Tyo
	JMP	MESAG
;
;
move::	;revised for addressable cursor
;the screen location is calculated from the variables
;New.Board.Pointer:	
;New.Row.Pointer:	
;New.Column.Pointer:	

;We have a three dimensional array of integers (for GSX) that are gotten
;by the three variables
	lda	is.first
	ana	a
	mvi	a,0
	sta	is.first
	cz	markpos	;to rub out old one
	lxi	d,old.board.pointer
	lxi	h,new.board.pointer
	mvi	b,3
..loop:	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	..loop


	lxi	h,New.row.pointer
	lda	new.board.pointer
	dcr	a
	add	a
	add	a	;*4
	add	m	;((New.Board.pointer)*4)+(New.row.pointer)
	dcr	a
	lxi	h,New.column.pointer
	add	a
	add	a	;*4
	add	m	;((New.row.pointer)*4)+(New.column.pointer
	dcr	a
	mov	l,a
	mvi	h,0
;HL has the index into the array
	dad	h	;as they are pairs
	dad	h	;as they are integers
	xchg
	lxi	h,locarraybase	
	dad	d	;we point to pair
;now we get X
	lxi	d,X.vertex
	mvi	b,4	;four bytes to move
..doloop:	;to get the vertices
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	..doloop

	call	markpos
	ret

Locarraybase:	;X   Y   X   Y   X   Y   X   Y   

	.word	037,265,059,265,080,265,101,265
	.word	037,286,059,286,080,286,101,286
	.word	037,307,059,307,080,307,101,307
	.word	037,328,059,328,080,328,101,328

	.word	137,216,165,216,193,216,221,216
	.word	137,244,165,244,193,244,221,244
	.word	137,272,165,272,193,272,221,272
	.word	137,300,165,300,193,300,221,300

	.word	268,158,306,158,344,158,382,158
	.word	268,196,306,196,344,196,382,196
	.word	268,234,306,234,344,234,382,234
	.word	268,272,306,272,344,272,382,272

	.word	445,075,495,075,545,075,595,075
	.word	445,125,495,125,545,125,595,125
	.word	445,175,495,175,545,175,595,175
	.word	445,225,495,225,545,225,595,225

	.word	00,00,00,00
;
;
REMEMBERPOSITION:
COPYPOSITION:
        LXI     D,Board.pointer
        LXI     H,New.Board.Pointer           ; COP] BP(ETC) -> NBP(ETC)
        MVI     B,3
COPYLOOP:
        LDAX    D               ; GET BP(I)
        MOV     M,A             ; PUT NBP(I)
        INX     D
        INX     H
        DCR     B               ; LOOP FOR THREE BYTES
        JNZ     COPYLOOP
        RET
;
;
STRAT:
        MVI     B,1
L15A:
       	push	b
	push	d
	push	h
	call	gettime
	pop	h
	pop	d
	pop	b
	MOV     A,B
        LXI     H,SUM
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MVI     M,0
        PUSH    H
        MOV     L,B
        MVI     H,0
        DAD     H
        DAD     H
        DCX     H
        DCX     H
        DCX     H
        XCHG
        MVI     C,4
L15B:
        LXI     H,ROW
        DAD     D
        MOV     A,M
        LXI     H,MOVEARY
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
	MOV	A,M	; 
	POP     H
        PUSH    H
        ADD     M
        MOV     M,A
        INX     D
        DCR     C
        JNZ     L15B
        POP     H
        INR     B
        MVI     A,77
        CMP     B
        JNZ     L15A
;
        MVI     B,1             ; B = J1
;
DO21:
        MOV     A,B
        STA     M3
        LXI     H,TSTA1
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MOV     A,M
        STA     TST1
        ORA     A
        JM      END21
        MOV     A,B
        LXI     H,TSTA2
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MOV     A,M
        STA     TST2
        MOV     A,B
        LXI     H,TSTA3
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MOV     A,M
        STA     TST3
;
        MVI     C,1             ; C = J2
;
DO22:
	MOV     A,C
        LXI     H,SUM
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        LDA     TST1
	CMP	M
        JNZ     END22
        MOV     A,B
        SUI     3
        JC      S18
        MOV     L,C
        MVI     H,0
        DAD     H
        DAD     H
        DCX     H
        DCX     H
        DCX     H
        SHLD    J3
        MVI     A,4
        STA     K3
;
DO23:
        LHLD    J3
        LXI     D,ROW
        DAD     D
        MOV     A,M
        STA     M1
        LXI     H,MOVEARY
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MOV     A,M
        ORA     A
        JNZ     END23
        LDA     TST2
        ORA     A
        JM      S17
;
        MVI     A,1
        STA     J4
DO24:
        LDA     J4
        LXI     H,SUM
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        LDA     TST2
        CMP     M
        JNZ     END24
        LDA     J4
        CMP     C
        JZ      END24
;
        MOV     L,A
        MVI     H,0
        DAD     H
        DAD     H
        DCX     H
        DCX     H
        DCX     H
        SHLD    J5
        SHLD    L5
        MVI     A,4
        STA     K5
;
DO25:
        LHLD    J5
        LXI     D,ROW
        DAD     D
        LDA     M1
        CMP     M
        JNZ     END25
        LDA     TST3
        ORA     A
        JM      S17
        LHLD    L5
        SHLD    J6
        MVI     A,4
        STA     K6
;
DO26:
        LHLD    J6
        LXI     D,ROW
        DAD     D
        MOV     A,M
        STA     M2
        LXI     H,MOVEARY
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        MOV     A,M
        ORA     A
        JNZ     END26
;
        MVI     A,1
        STA     J7
;
DO27:
        LDA     J7
        MOV     D,A
        LXI     H,SUM
        ADD     L
        MOV     L,A
	mvi	a,0
	adc	h
	mov	h,a
        LDA     TST3
        CMP     M
        JNZ     END27
        MOV     A,D
        CMP     C
        JZ      END27
        LDA     J4
        CMP     D
        JZ      END27
        MOV     L,D
        MVI     H,0
        DAD     H
        DAD     H
        DCX     H
        DCX     H
        DCX     H
        SHLD    J8
        MVI     A,4
        STA     K8
;
DO28:
        LHLD    J8
        LXI     D,ROW
        DAD     D
        LDA     M2
        CMP     M
        JZ      S16
;
END28:
        LHLD    J8
        INX     H
        SHLD    J8
        LXI     H,K8
        DCR     M
        JNZ     DO28
;
END27:
        LXI     H,J7
        INR     M
        MVI     A,77
        CMP     M
        JNZ     DO27
;
END26:
        LHLD    J6
        INX     H
        SHLD    J6
        LXI     H,K6
        DCR     M
        JNZ     DO26
;
END25:
        LHLD    J5
        INX     H
        SHLD    J5
        LXI     H,K5
        DCR     M
        JNZ     DO25
;
END24:
        LXI     H,J4
        INR     M
        MVI     A,77
        CMP     M
        JNZ     DO24
;
END23:
        LHLD    J3
        INX     H
        SHLD    J3
        LXI     H,K3
        DCR     M
        JNZ     DO23
;
END22:
        INR     C
        MVI     A,77
        CMP     C
        JNZ     DO22
;
END21:
        INR     B
        MVI     A,16
        CMP     B
        JNZ     DO21
;
;
        XRA     A
        STA     M1
        JMP     S17
;
S18:
        MOV     A,C
        STA     M1
;
S17:
        XRA     A
        STA     M2
;
S16:
        RET
;
;
;
PLACEIT:
        MOV     B,A
        DCR     A
        RRC
        RRC
        RRC
        RRC
        ANI     0FH
        INR     A
        STA     New.Board.Pointer
        DCR     A
        ADD     A
        ADD     A
        ADD     A
        ADD     A
        MOV     C,A
        MOV     A,B
        SUB     C
        MOV     B,A
        DCR     A
        RRC
        RRC
        ANI     3FH
        INR     A
        STA     New.Row.Pointer
        DCR     A
        ADD     A
        ADD     A
        MOV     C,A
        MOV     A,B
        SUB     C
        STA     New.Column.Pointer
        RET
;


;**** Graphics subroutines ****

line.msg:	.byte	17
	.byte	1bH,".",9
	.byte	3	;complement mode
	.byte	1bH,'.',2
x.strt:	.word	10
y.strt:	.word	10
x.end:	.word	630
Y.end:	.word	398
linemask:
	.word	0FFFFH
	.byte	00

draw.a.line:	;draws a graphics line
	lxi	h,line.msg
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
	lxi	h,shapes
..loop:	mov	e,m	;pick up pointers
	inx	h
	mov	d,m
	inx	h
	mov	a,e
	ora	d
	jz	..done
	xchg
	push	d
	call	do.shape
	pop	h
	jmp	..loop
..done:
	mvi	a,0
	sta	m.type
	lxi	h,locarraybase
	mvi	b,4*4*4
..back:	mov	e,m
	inx	h
	mov	d,m
	inx	h
	xchg
	shld	x.circle
	xchg
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	xchg
	shld	Y.circle
	push    d
	push	b
	lhld	scale.pointer
	mov	e,m
	mvi	d,0
	xchg
	shld	radius
	mov	;*************************************************	call	markpos
	pop	b
	pop	h
	dcr	b
	jnz	..back
	mvi	a,2
	sta	m.type
	ret
	

Shapes:	;pointers to shapes
	.word	..1st.square
	.word	..2nd.square;
	.word	..3rd.square
	.word	..4th.square
	.word	00	;null termination
;the vertex pairs for the squares
..1st.square:
	.word	420,50,620,50,620,250,420,250,420,50,000,000
..2nd.square:
	.word	250,140,400,140,400,290,250,290,250,140,000,000
..3rd.square:
	.word	122,204,235,204,235,316,122,316,122,204,000,000
..4th.square:
	.word	27,255,111,255,111,339,27,339,27,255,00,00
	

dopiece::	;draw either a o or an X at the location X.vertex-Y.vertex
;in a size determined by New.board.pointer
	lxi	h,piece
	mvi	b,fig.size+4
..zero:	mvi	m,0
	inx	h
	dcr	b
	jnz	..zero
	call	markpos
	lxi	h,theX
	lda	isX
	ana	a
	jnz	..on
	lxi	h,TheO
..on:	
	lxi	d,fig.size
	lda	new.board.pointer
..loop:	dcr	a
	jz	..hop
	dad	d
	jmp	..loop
..hop:	;now we point HL to figure
	push	h
	lhld	x.vertex
	mov	c,l
	mov	b,h
	lxi	h,piece
	shld	our.fig
	pop	h
	push	h	;save figure pointer
;BC has X location, HL points to figure
..1loop:
	mov	e,m
	inx	h
	mov	d,m
	mvi	a,0ffH	;signal for end of figure
	cmp	e
	jnz	..xnotdun
	cmp	d
	jz	..Xdun
..xnotdun:
	push	h
	lhld	our.fig
	xchg
	dad	b	;add in location
	xchg
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	inx	h
	inx	h	;increment to new X
	shld	our.fig
	pop	h
	inx	h
	inx	h
	inx	h
	jmp	..1loop
..xdun:
	lhld	our.fig
	mvi	m,0
	inx	h
	mvi	m,0
	lhld	Y.vertex
	mov	c,l
	mov	b,h
	lxi	h,piece
	shld	our.fig
	pop	h
;BC has X location, HL points to figure
..2loop:
	inx	h
	inx	h
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	mvi	a,0ffh
	cmp	e
	jnz	..ynotdun
	cmp	d
	jz	..Ydun
..ynotdun:
	push	h
	xchg
	dad	b	;add in location
	xchg
	lhld	our.fig
	inx	h
	inx	h
	mov	m,e
	inx	h
	mov	m,d
	inx	h
;increment to new y
	shld	our.fig
	pop	h
	jmp	..2loop
..Ydun:
	xra	a
	lhld	our.fig
	mov	m,a
	inx	h
	mov	m,a	;null terminate
	lxi	h,piece
	call	do.shape
	call	markpos
	ret
our.fig:	.word	000

piece::	.word	00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	.word	00,00,00,00,00,00,00,00,00,00,00,00
	.word	00,00,00,00,00,00,00,00,00,00,00,00
theX:
	.word	-4,-8,0,-4,4,-8,8,-4
	.word	4,0,8,4,4,8,0,4
	.word	-4,8,-8,4,-4,0,-8,-4,-4,-8
	.word	0FFFFH,0FFFFH

fig.size	= .-TheX

	.word	-5,-11,0,-5,5,-11,11,-5
	.word	5,0,11,5,5,11,0,5
	.word	-5,11,-11,5,-5,0,-11,-5,-5,-11
	.word	0ffffh,0ffffh

	.word	-7,-15,0,-7,7,-15,15,-7
	.word	7,0,15,7,7,15,0,7
	.word	-7,15,-15,7,-7,0,-15,-7,-7,-15
	.word	0ffffH,0FFFFH

	.word	-10,-20,0,-10,10,-20,20,-10
	.word	10,0,20,10,10,20,0,10
	.word	-10,20,-20,10,-10,0,-20,-10,-10,-20
	.word	0ffffH,0FFFFH

Theo:
	.word	-4,-8,4,-8,8,-4
	.word	8,4,4,8
	.word	-4,8,-8,4,-8,-4,-4,-8
	.word	0FFFFH,0FFFFH,0,0,0,0,0,0,0,0

	.word	-5,-11,5,-11,11,-5
	.word	11,5,5,11
	.word	-5,11,-11,5,-11,-5,-5,-11
	.word	0FFFFH,0FFFFH,0,0,0,0,0,0,0,0

	.word	-7,-15,7,-15,15,-7
	.word	15,7,7,15
	.word	-7,15,-15,7,-15,-7,-7,-15
	.word	0FFFFH,0FFFFH,0,0,0,0,0,0,0,0

	.word	-10,-20,10,-20,20,-10
	.word	20,10,10,20
	.word	-10,20,-20,10,-20,-10,-10,-20
	.word	0FFFFH,0FFFFH,0,0,0,0,0,0,0,0

;
MSG1:   .asciz      'Please move the marker using cursor keys '
MSG2:   .byte		07H
	.asciz      'That was not quite correct. Try again    '
MSG3:   .asciz      'Hmm. I am trying to decide on my move.   '
MSG4:   .byte		07H
	.asciz      'It was a Tied Game. I couldnt beat you!  '
MSG5:   .byte		07H
	.asciz      'I have beaten you. You played well though'
MSG6:   .byte		07H,07H,07H
	.asciz      'This is incredible. Youve beaten me!!!!  '
MSG7:	.byte		07H
	.asciz	    '....that position is occupied. Try again '
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;       RAM BUFFER SPACE
;
;       ++++++++++++++++++++++++++++++++++++++++++++++++
;
;
;
Xwant:		.byte	000
Ywant:		.byte	000
isx:		.byte	000	;do we want an X?
is.first:	.byte	0FFH	;is it the first?
Board.pointer:
old.board.pointer:	.byte      1       ; CURRENT BOARD POINTER
Old.Row.Pointer:	.byte      1       ; CURRENT ROW POINTER
Old.Column.Pointer:	.byte      1       ; CURRENT COLUMN POINTER
;
New.Board.Pointer:	.byte      1       ; NEW BOARD POINTER
New.Row.Pointer:	.byte      1       ; NEW ROW POINTER
New.Column.Pointer:	.byte      1       ; NEW COLUMN POINTER
;
MOVEARY:        .blkb      65
SUM:            .blkb      77
TST1:           .blkb      1
TST2:           .blkb      1
TST3:           .blkb      1
M1:             .blkb      1
M2:             .blkb      1
M3:             .blkb      1
J3:             .blkb      2
K3:             .blkb      1
J4:             .blkb      1
J5:             .blkb      2
K5:             .blkb      1
L5:             .blkb      2
J6:             .blkb      2
K6:             .blkb      1
J7:             .blkb      1
J8:             .blkb      2
K8:             .blkb      1
;
WAIT:   .byte      0,22,43,23,42,26,39,27
	.byte	38,1,64,13,52,4
        .byte      61,16,49,22,43,23,42
;
TSTA1:  .byte      0, 4,15, 3,10,10, 2, 2
	.byte	 2, 2, 1, 5, 5, 5, 5,0FFH
TSTA2:  .byte      0,0FFH,0FFH,0FFH,10, 5, 2, 1
	.byte	 1, 0, 1, 5, 5, 0, 0,0FFH
TSTA3:  .byte      0,0FFH,0FFH,0FFH,0FFH,10,0FFH, 2
	.byte	 1, 2, 1,10, 5,10, 5,0FFH
;
ROW:    .byte      0
        .byte      22,43,64, 1,23,42,61, 4
        .byte      26,39,52,13,27,38,49,16
        .byte      22,42,62, 2,23,43,63, 3
        .byte      23,38,53, 8,27,42,57,12
        .byte      26,38,50,14,27,39,51,15
        .byte      22,39,56, 5,26,43,60, 9
        .byte      22,38,54, 6,23,39,55, 7
        .byte      26,42,58,10,27,43,59,11
        .byte      22,23,24,21,26,27,28,25
        .byte      22,26,30,18,23,27,31,19
        .byte      22,27,32,17,23,26,29,20
        .byte      38,39,40,37,42,43,44,41
        .byte      38,42,46,34,39,43,47,35
        .byte      38,43,48,33,39,42,45,36
        .byte      61, 1,21,41,64, 4,24,44
        .byte      49, 4,19,34,61,16,31,46
        .byte      49,13,25,37,52,16,28,40
        .byte      52, 1,18,35,64,13,30,47
        .byte      49, 1,17,33,52, 4,20,36
        .byte      61,13,29,45,64,16,32,48
        .byte       4, 1, 2, 3,16,13,14,15
        .byte      13, 1, 5, 9,16, 4, 8,12
        .byte      16, 1, 6,11,13, 4, 7,10
        .byte      52,49,50,51,64,61,62,63
        .byte      61,49,53,57,64,52,56,60
        .byte      64,49,54,59,61,52,55,58
        .byte      18,34,50, 2,19,35,51, 3
        .byte      21,37,53, 5,24,40,56, 8
        .byte      25,41,57, 9,28,44,60,12
        .byte      30,46,62,14,31,47,63,15
        .byte       6, 7, 8, 5,10,11,12, 9
        .byte       6,10,14, 2, 7,11,15, 3
        .byte      18,19,20,17,30,31,32,29
        .byte      21,25,29,17,24,28,32,20
        .byte      34,35,36,33,46,47,48,45
        .byte      37,41,45,33,40,44,48,36
        .byte      54,55,56,53,58,59,60,57
        .byte      54,58,62,50,55,59,63,51

shift:
	.byte	0ffH,0ffH,0FFH,0ffH
;
	.blkb	128		;64-WORD STACK
STACK:
;
;
.list
	.END	intro


;*** EOF ***
