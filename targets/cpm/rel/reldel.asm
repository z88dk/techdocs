	title	'MML: RELDEL'
	page	45
;*************
;*  RELDEL   *
;*************
;**********************************
;* Copyright: MML Systems Limited *
;* 11 Sun Street, London E.C.2.   *
;*        1981                    *
;*                                *
;* Utility to remove any entry    *
;* names within a .REL file which *
;* are not required. Bothe the    *
;* entry point and the entry list *
;* will require to be removed for *
;* each name to be removed. Users *
;* should first run RELMAP &/or   *
;* RELDUMP.                       *
;*                                *
;* Format:                        *
;* RELDEL <filename>              *
;*                                *
;* Revisions                      *
;* =========                      *
;* JULY 81 - Original             *
;*                                *
;*                                *
;**********************************
;
BDOS	EQU	5
COUT	EQU	2
CIN	EQU	1
CSTAT	EQU	11
CMSG	EQU	9
FOPEN	EQU	15
FCLOSE	EQU	16
FREAD	EQU	20
FWRITE	EQU	21
FCREATE EQU	22
FDMA	EQU	26
;
;
cr	EQU 0DH
lf	EQU 0AH
TAB	EQU 09H
;
	page
	ORG	100H
CPM:	EQU	$
	LXI	d,RELDEL
	push	d
	ret
	DB cr,lf
	DB '        PROGRAM RELDEL to delete entry points of a .REL file',cr,lf
	DB '        COPYWRITE D. POWYS-LYBBE 20 JUL 1981',cr,lf
	DB '        MML, 11 SUN STREET, LONDON. E.C.2.',cr,lf
	DB cr,lf
	DB '        Program updates a .REL file',cr,lf
	DB cr,lf
;
RELDEL:
	LXI	H,0
	DAD	SP
	SHLD	OLDSP	;SAVE CALLER'S STACK POINTER
	LXI	SP,OLDSP+127	;SET UP OURS
	LXI H,DATASEG ; .REL file copied to DMA address set to program end
	SHLD	DMA
;
	LXI	H,FCB+9
	MVI	M,'R'
	INX	H
	MVI	M,'E'
	INX	H
	MVI	M,'L'	; FCB set to REL type
;
	call	init$fcb
;
	LXI	D,FCB
	MVI	c,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	PR05
	LXI	D,NOTFOUND
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND
PR05:
	LHLD	DMA	; Get DMA address
;
NXTBUF:		;READ NEXT BUFFER FROM DISK
	XCHG		; Copy DMA into D,E
	lhld	6	; top of memory
	lxi	b,-128
	dad	b
	mov	a,d
	cmp	h
	jc	mem$ok
	jnz	mem$full
	mov	a,e
	cmp	l
	jc	mem$ok
mem$full:
	LXI	D,outofmem
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND
mem$ok:	MVI c,fdma
	CALL	BDOS	; Set DMA
	LXI	D,FCB
	MVI	c,fread
	CALL	BDOS	;READ RECORD
	ORA	A	; Check if read beyond last record
	JNZ	DISPLAY
	LHLD	DMA	; Get DMA address
	MVI	C,128
	MVI	B,0
	DAD	B	; & increment by 128 bytes
	SHLD	DMA
	SHLD	FREE	; Free points to location beyond .REL file 
	JMP	NXTBUF
NOTFOUND:	DB	'NEW .REL FILE',cr,lf,'$'
outofmem:	DB	cr,lf,'out of memory',cr,lf,'$'
;
init$fcb:
	LXI	H,FCB+12
	sub	a
	mvi	b,33-12
init$1:	mov	m,a
	inx	h
	dcr	b
	jnz	init$1
	ret
;
FREE:	dw	0
NEWLN:	DB	cr,lf,'$'
;
;
CONOUT:	PUSH H
	PUSH D
	push	b
	push	psw
	mov	e,a
	mvi	c,cout
	CALL Bdos
	call	tst$abort
	pop	psw
	pop	b
	POP	D
	POP	H
	ret
;-------
;Send message terminated by '$' to console
;Reg in:	DE->message
CONMSG:
	MVI	C,cmsg
	CALL	BDOS
;
tst$abort:
	mvi	c,cstat	; just check for any console input
	CALL Bdos
	ora	a
	rz
	mvi	c,cin	; YES - Abort run
	CALL Bdos
	jmp	return

;
newline:
	MVI	A,cr
	CALL	conout
	MVI	A,lf
	CALL	conout
	lda	ypos
	inr	a
	sta	ypos
	sub	a
	sta	xpos
	RET
;
;	Display each link command
;
DISPLAY:
	LXI	D,table
	call	conmsg
	sub	a
	sta	xpos
	sta	ypos
	lxi	h,dataseg-1
	shld	rd$byte$ptr
	shld	wr$byte$ptr
	sub	a
	sta	rd$bit$ptr
	sta	wr$bit$ptr
	sta	link$ptr
	sta	wr$byte
;
stream:
	lda	link$ptr
	cpi	0
	cnz	wr$link
	sub	a
	sta	link$ptr
;
	call	get$nxt$bit
	ora	a
	jnz	stm$type
	lxi	h,last$bit
	cmp	m
	sta	last$bit
	jnz	new$data
	lda	xpos
	cpi	80-3
	jc	cont$data
new$data:
	call	newline
	lda	last$bit
	call	dsp$bit
	call	dsp$blnk
	lda	xpos
	adi	2
	sta	xpos
cont$data:
	call	get$byte
	lda	xpos
	adi	2
	sta	xpos
	jmp	stream
;-------
; type
; 00 special link
; 01 program relative
; 10 data relative
; 11 common relative
;
stm$type:
	sta	last$bit
	call	newline
	lda	last$bit
	call	dsp$bit
	call	dsp$blnk
	call	get$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	dsp$blnk
	jz	stm$link	
	call	get$word
	jmp	stream
;-------
; link
; 4 bit control field
;
stm$link:
	call	get$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	dsp$blnk
	jz	stm$entry
	cpi	0001b
	jz	stm$common
	cpi	0010b
	jz	stm$program
	cpi	0011b
	jz	stm$lib
	cpi	0100b
	jz	stm$unsd1
	cpi	0101b
	jz	stm$size
	cpi	0110b
	jz	stm$chain
	cpi	0111b
	jz	stm$point
	cpi	1000b
	jz	stm$unsd2
	cpi	1001b
	jz	stm$external
	cpi	1010b
	jz	stm$data
	cpi	1011b
	jz	stm$locate
	cpi	1100b
	jz	stm$address
	cpi	1101b
	jz	stm$segment
	cpi	1110b
	jz	stm$end
	cpi	1111b
	jz	stm$eof
	jmp	bad$code
stm$entry	; 0000b
	call	stm$name
	call	dsp$name
	call	ok$del
	jmp	stream
stm$common	; 0001b
	call	stm$name
	call	dsp$name
	jmp	stream
stm$program	; 0010b
	call	stm$name
	call	dsp$name
	jmp	stream
stm$lib		; 0011b
	call	stm$name
	call	dsp$name
	jmp	stream
stm$unsd1	; 0100b
	call	stm$name
	call	dsp$name
	jmp	stream
stm$size	; 0101b
	call	stm$value
	call	dsp$blnk
	call	stm$name
	call	dsp$name
	jmp	stream
stm$chain	; 0110b
	call	stm$value
	call	dsp$blnk
	call	stm$name
	call	dsp$name
	jmp	stream
stm$point	; 0111b
	call	stm$value
	call	dsp$blnk
	call	stm$name
	call	dsp$name
	call	ok$del
	jmp	stream
stm$unsd2	; 1000b
	call	stm$value
	call	dsp$blnk
	call	stm$name
	call	dsp$name
	jmp	stream
stm$external	; 1001b
	call	stm$value
	jmp	stream
stm$data	; 1010b
	call	stm$value
	jmp	stream
stm$locate	; 1011b
	call	stm$value
	jmp	stream
stm$address	; 1100b
	call	stm$value
	jmp	stream
stm$segment	; 1101b
	call	stm$value
	jmp	stream
stm$end	; 1110b
	call	stm$value
	sub	a
	sta	rd$bit$ptr	; align to byte boundary
	call	wr$link
	call	byte$bound
	sub	a
	sta	link$ptr
	jmp	stream
stm$eof	; 1111b
	call	wr$link
	call	byte$bound
	jmp	link$eof
;-------
; value
; frst 2 bits
; 00 absolute
; 01 program relative
; 10 data relative
; 11 common relative
;
; next 16 bits
; address field
;
stm$value:
	call	get$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	dsp$blnk
	call	get$word
	ret
;-------
; name
; 3 bit name count
;  count x 8bit ascii characters
; named saved in NAME with trailing blanks
;
stm$name:
	mvi	b,8
	mvi	a,' '
	lxi	h,txt$name
name$init:
	mov	m,a
	inx	h
	dcr	b
	jnz	name$init
;
	call	get$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	dsp$blnk
	rz
	lxi	h,txt$name
	mov	b,a
	mvi	a,16
	sub	b
	sub	b
	jz	cr$name
cr$blnk:
	call	dsp$blnk
	dcr	a
	jnz	cr$blnk
cr$name:
	push	b
	push	h
	call	get$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	dsp$half
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	dsp$half
	pop	h
	cpi	' '
	jc	bad$asc
	cpi	07fh
	jc	not$bad
bad$asc:
	mvi	a,'.'
not$bad:
	mov	m,a
	inx	h
	pop	b
	dcr	b
	jnz	cr$name
	call	dsp$blnk
	ret
;
; data areas
;
xpos:	db	0	; cursor position
ypos:	db	0	; cursor position
rd$byte$ptr:	dw	0	; current byte position
rd$byte:	db	0	; current byte
rd$bit$ptr:	db	0	; current bit number
wr$byte$ptr:	dw	0	; current byte position
wr$byte:	db	0	; current byte
wr$bit$ptr:	db	0	; current bit number
last$bit:	db	0
txt$name:	db	'12345678'	; max of 8 byte address
	db	'$'
temp$digits:	ds	2
temp$bit:	db	0
link$ptr:	db	0
link:		ds	128
table:	db	cr,lf,'MML:RELDEL - deletion of symbol names in REL'
	db	cr,lf,'(Only entry point names and the entry list)'
	db	cr,lf,'--------------------------------------------'
	db	cr,lf,lf
	db	'$'
;
; routines
;
;-------
; display txt$name
;
dsp$name:
	LXI	D,txt$name
	call	conmsg
	ret
;
;get & display hex digit(s)
;
get$word:
	call	get$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	sta	temp$digits
	call	get$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	sta	temp$digits+1
	call	get$byte
	lda	temp$digits
	call	dsp$half
	lda	temp$digits+1
	call	dsp$half
	ret
get$byte:
	call	get$half
	call	get$half
	ret
get$half:
	call	get$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
dsp$half:
	push	psw
	ani	0fh
	adi	'0'
	cpi	'9'+1
	jc	nmrc
	adi	'A'-'0'-10
nmrc:	call	conout
	pop	psw
	ret
dsp$bit:
	push	psw
	ani	1
	adi	'0'
	call	conout
	pop	psw
	ret
dsp$blnk:
	push	psw
	mvi	A,' '
	call	conout
	pop	psw
	ret
;
;add next bit to current bit in a after shifting a
;
add$nxt$bit:
	rlc	
	mov	b,a
	push	b
	call	get$nxt$bit
	pop	b
	ora	b
	ret
;
; fetch next bit as bit 0 in A
;
get$nxt$bit:
	lda	rd$bit$ptr
	dcr	a
	cpi	0
	cm	get$nxt$byte
	sta	rd$bit$ptr
	mov	b,a
	lda	rd$byte
	inr	b
inc$bit:
	dcr	b
	jz	fnd$bit
	rrc
	jmp	inc$bit
fnd$bit:
	ani	1
	call	save$bit
	ret
;
;fetch next byte
;
get$nxt$byte:
	lhld	rd$byte$ptr
	inx	h
	xchg
	lhld	free
	mov	a,d
	cmp	h
	jc	in$rel
	jnz	bad$code	; error
	mov	a,e
	cmp	l
	jnc	bad$code	; error
in$rel:
	xchg
	shld	rd$byte$ptr
	mov	a,m
	sta	rd$byte
	mvi	a,7	; start with bit 7
	ret
;
; skip B bits
;
skip$bits:
	cpi	0
	rz
	push	psw
	call	get$nxt$bit
	pop	psw
	dcr	a
	jmp	skip$bits
;
; link routines
;
save$bit:
	push	psw
	lxi	h,link
	lda	link$ptr
	mov	e,a
	mvi	d,0
	dad	d
	inr	a
	sta	link$ptr
	pop	psw
	mov	m,a
	ret
;
; wr$link
;
wr$link:
	lda	link$ptr
	lxi	h,link
wr$lnk1:
	push	psw
	mov	a,m
	push	h
	call	put$nxt$bit
	pop	h
	inx	h
	pop	psw
	dcr	a
	jnz	wr$lnk1
	ret
;
;ok$del
;
ok$del:
	lxi	d,delete
	mvi	c,cmsg
	call	bdos
ok1:	mvi	c,cstat
	call	bdos
	ora	a
	jz	ok1
	mvi	c,cin
	call	bdos
	ani	07fh
	cpi	'Y'
	jz	ok$y
	cpi	'y'
	jz	ok$y
	cpi	'N'
	jz	ok$n
	cpi	'n'
	jz	ok$n
	jmp	ok$del
ok$y:	sub	a
	sta	link$ptr
ok$n:	ret
;
delete:	db	cr,lf,'Delete Y/N ?','$'
;
;
; write bit 0 in A as next bit
;
put$nxt$bit:
	push	psw
	ani	1
	rrc
	lxi	h,wr$byte
	ora	m
	rlc
	mov	m,a
	lda	wr$bit$ptr
	inr	a
	cpi	8
	cnc	put$nxt$byte
	sta	wr$bit$ptr
	pop	psw
	ret
;
;write next byte
;
put$nxt$byte:
	lhld	wr$byte$ptr
	inx	h
	xchg
	lhld	free
	mov	a,d
	cmp	h
	jc	out$rel
	jnz	bad$code	; error
	mov	a,e
	cmp	l
	jnc	bad$code	; error
out$rel:
	xchg
	shld	wr$byte$ptr
	lda	wr$byte
	mov	m,a
	sub	a
	sta	wr$byte	; set byte content to zero
	mvi	a,0	; reset bit count to zero
	ret
;
;fill bits to end of byte with zero
;
byte$bound:
	lda	wr$bit$ptr
	cpi	0
	rz
	sub	a
	call	put$nxt$bit
	jmp	byte$bound
;
;fill to end of record with ctrl-z
;
fill$rec:
	lhld	wr$byte$ptr
	inx	h
	lxi	d,dataseg
	mov	a,l
	sub	e
	ani	127
	rz
	mvi	a,01ah
	sta	wr$byte
	call	put$nxt$byte
	jmp	fill$rec
;
; reached link eof command
;
link$eof:
	call	newline
	call	fill$rec	; fill to end of record with nulls
	LXI H,DATASEG ; .REL file copied to DMA address set to program end
	SHLD	DMA
;
	call	init$fcb
;
	LXI	D,FCB
	MVI	c,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	wr1
	LXI	D,NOTFOUND
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND
wr1:
	LHLD	DMA	; Get DMA address
;
wr2:		;write NEXT BUFFER to DISK
	XCHG		; Copy DMA into D,E
	lhld	wr$byte$ptr	; end of REL
	inx	h
	mov	a,d
	cmp	h
	jc	wr3
	jnz	close$rel
	mov	a,e
	cmp	l
	jnc	close$rel
	jc	wr3
wr3:	MVI c,fdma
	CALL	BDOS	; Set DMA
	LXI	D,FCB
	MVI	c,fwrite
	CALL	BDOS	;write
	ORA	A	; Check if write error
	JNZ	wr$error
	LHLD	DMA	; Get DMA address
	MVI	C,128
	MVI	B,0
	DAD	B	; & increment by 128 bytes
	SHLD	DMA
	JMP	wr2
;
close$rel:
	lxi	d,fcb
	MVI	c,fclose
	CALL	BDOS
	JMP	RETURN	;end of deletion
;
wr$error:
	LXI	D,bad$write
	call	conmsg
	jmp	return

BAD$CODE:
	LXI	D,prog$err
	call	conmsg

RETURN:			;NORMAL RETURN
	jmp	0
;
prog$err:	DB cr,lf,'program error',cr,lf,'$'
bad$write:	DB cr,lf,'write error',cr,lf,'$'
;
FCB	EQU	5CH
DMA:	DS	2
COUNT:	DS	1
DATA:	DB	010H	; Next program location can be data
DMAOUT	EQU	80H
BUFFER	EQU	DMAOUT
OLDSP:	DS	128
NOSPACE:	DB	'DIRECTORY FULL',cr,lf,'$'
OLDFILE:	DB	'OLD .REL FILE',cr,lf,'$'
;
;
DATASEG	equ	$
	END
