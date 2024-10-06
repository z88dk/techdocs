	title	'MML: RELDUMP'
	page	45
;*************
;*  RELDUMP  *
;*************
;**********************************
;* Copyright: MML Systems Limited *
;* 11 Sun Street, London E.C.2.   *
;*        1981                    *
;*                                *
;* Utility to display the contents*
;* of a .REL file with each REL   *
;* statement split into separate  *
;* bit, hex and text fields. Data *
;* bytes are however shown as a   *
;* continuous stream with a '0'   *
;* as the first field.            *
;*                                *
;* Format:                        *
;* RELDUMP <filename>             *
;*                                *
;* Revisions                      *
;* =========                      *
;* JUNE 81 - Original             *
;*                                *
;*                                *
;**********************************
;
BDOS	EQU	5
COUT	EQU	2
CIN	EQU	1
CSTAT	EQU	11
CMSG	EQU	9
FWRITE	EQU	21
FOPEN	EQU	15
FCREATE EQU	22
FCLOSE	EQU	16
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
	LXI	d,reldump
	push	d
	ret
	DB cr,lf
	DB '        PROGRAM RELDUMP to dump the contents of a .REL file',cr,lf
	DB '        COPYWRITE D. POWYS-LYBBE 14 JUL 1981',cr,lf
	DB '        MML, 11 SUN STREET, LONDON. E.C.2.',cr,lf
	DB cr,lf
	DB '        Program reads a .REL file',cr,lf
	DB cr,lf
;
reldump:
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
	MVI	M,'L'	; FCB set to COM type
;
	LXI	D,FCB
	MVI	C,15
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
mem$ok:	MVI C,26
	CALL	BDOS	; Set DMA
	LXI	D,FCB
	MVI	C,20
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
NOTFOUND:	DB	'NEW .REL FILE',cr,0AH,'$'
outofmem:	DB	cr,0ah,'out of memory',cr,0AH,'$'
;
;
FREE:	DS	2
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
	mvi	c,cmsg
	call	bdos
;
tst$abort:
	mvi	c,cstat	; just check for any console input
	CALL	bdos
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
	shld	rel$byte$ptr
	sub	a
	sta	rel$bit$ptr
;
stream:
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
	call	skip$val
	call	stm$name
	call	dsp$name
	jmp	stream
stm$common	; 0001b
	call	skip$val
	call	stm$name
	call	dsp$name
	jmp	stream
stm$program	; 0010b
	call	skip$val
	call	stm$name
	call	dsp$name
	jmp	stream
stm$lib		; 0011b
	call	skip$val
	call	stm$name
	call	dsp$name
	jmp	stream
stm$unsd1	; 0100b
	call	skip$val
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
	sta	rel$bit$ptr	; align to byte boundary
	jmp	stream
stm$eof	; 1111b
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
; skip$value
; where the link command does not include a value,
; but does include a name, then blanks pad over
; the displayed value fields
;
skip$val:
	mvi	b,8
no$val:	push	b
	call	dsp$blnk
	pop	b
	dcr	b
	jnz	no$val
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
rel$byte$ptr:	dw	0	; current byte position
rel$byte:	db	0	; current byte
rel$bit$ptr:	db	0	; current bit number
last$bit:	db	0
txt$name:	db	'12345678'	; max of 8 byte address
	db	'$'
temp$digits:	ds	2
table:	db	cr,lf,'MML:RELDUMP - bit/hex dump of REL link instructions'
	db	cr,lf,'---------------------------------------------------'
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
	lda	rel$bit$ptr
	dcr	a
	cpi	0
	cm	get$nxt$byte
	sta	rel$bit$ptr
	mov	b,a
	lda	rel$byte
	inr	b
inc$bit:
	dcr	b
	jz	fnd$bit
	rrc
	jmp	inc$bit
fnd$bit:
	ani	1
	ret
;
;fetch next byte
;
get$nxt$byte:
	lhld	rel$byte$ptr
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
	shld	rel$byte$ptr
	mov	a,m
	sta	rel$byte
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
; reached link eof command
;
link$eof:
	call	newline
	jmp	return
BAD$CODE:
	LXI	D,prog$err
	call	conmsg

RETURN:			;NORMAL RETURN
	jmp	0
;
prog$err:	DB cr,lf,'program error',cr,lf,'$'
;
FCB	EQU	5CH
DMA:	DS	2
COUNT:	DS	1
DATA:	DB	010H	; Next program location can be data
DMAOUT	EQU	80H
BUFFER	EQU	DMAOUT
OLDSP:	DS	128
NOSPACE:	DB	'DIRECTORY FULL',cr,0AH,'$'
OLDFILE:	DB	'OLD .REL FILE',cr,0AH,'$'
;
;
DATASEG	equ	$
	END
