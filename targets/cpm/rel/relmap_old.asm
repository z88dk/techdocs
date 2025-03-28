	title	'MML: RELMAP'
	page	45
;*************
;*  RELMAP   *
;*************
;**********************************
;* Copyright: MML Systems Limited *
;* 11 Sun Street, London E.C.2.   *
;*        1981                    *
;*                                *
;* Utility to display all names   *
;* in a .REL file.                *
;*                                *
;* Format:                        *
;* RELMAP <filename>              *
;*                                *
;* Revisions                      *
;* =========                      *
;* JUNE 81 - Original             *
;* AUG 81  - 'table' added        *
;* JAN 83  - also uses .IRL files *
;*                                *
;**********************************
;
; BDOS FUNCTIONS
COUT	EQU	2
CIN	EQU	1
CSTAT	EQU	11
CMSG	EQU	9
FWRITE	EQU	21
FREAD	EQU	20
FOPEN	EQU	15
FCREATE EQU	22
FCLOSE	EQU	16
FDMA	EQU	26
;
; CP/M SYSTEM EQUATES
BDOS	EQU	5
FCB	EQU	5CH
;
cr	EQU 0DH
lf	EQU 0AH
TAB	EQU 09H
;
	page
	aseg
	ORG	100H
	jmp	start
;
	DB cr,lf
	DB cr,lf
;
	DB cr,lf
	DB '        PROGRAM RELMAP to map the names defined in a .REL file'
	db cr,lf
	DB '        COPYRIGHT D. POWYS-LYBBE 19 JAN 1983',cr,lf
	DB '        MML, 11 SUN STREET, LONDON. E.C.2.',cr,lf
	DB cr,lf
	DB '        Program reads .REL or .IRL file',cr,lf
	DB cr,lf
;
start:
	xthl
	LXI	SP,stack$top	;SET UP OURS
	push	h	; save callers return on stack
	LXI	H,0
	push	h	; force warm boot if stack is popped
	LXI	d,relmap
	push	d
	ret
NOTFOUND:	DB	'NEW .REL FILE',cr,0AH,'$'
NOIRLFOUND:	DB	'NEW .IRL FILE',cr,0AH,'$'
outofmem:	DB	cr,0ah,'out of memory',cr,0AH,'$'
REL$TYPE	db	'REL'
IRL$TYPE	db	'IRL'
;
cmptype:
	mvi	b,3
nxt$type:
	ldax	d
	cmp	m
	rnz
	inx	d
	inx	h
	dcr	b
	jnz	nxt$type
	ret		; return 0 if match ok
;
set$type:
	mvi	b,3	; copy 3 bytes in (DE) to (HL)
nxt$set:
	ldax	d
	mov	m,a
	inx	d
	inx	h
	dcr	b
	jnz	nxt$set
	ret
;--------
relmap:
	LXI	H,DATASEG ; .REL file copied to DMA address set to program end
	SHLD	DMA
; OPEN file - if TYPE not specified as .REL or .IRL
; then test for .IRL first then .REL
; 19jan83 new section
; search for .REL or .IRL or nothing
        LXI	H,FCB+9
	lxi	d,rel$type
	call	cmptype
	jz	openrel	; .REL file specified
;
        LXI	H,FCB+9
	lxi	d,irl$type
	call	cmptype
	jz	openIRL	; .IRL file specified
; try for .IRL file
	LXI	H,FCB+9
	lxi	d,irl$type
	call	set$type; FCB set to IRL type
;
	LXI	D,FCB
	MVI	C,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	readirl	; .IRL file exists
; try .REL
;
	LXI	H,FCB+9
	lxi	d,rel$type
	call	set$type; FCB set to REL type
;
openrel:		;19jan83
	LXI	D,FCB
	MVI	C,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	mvi	a,0
	sta	irl	; set IRL flag false
	JNZ	read
	LXI	D,NOTFOUND
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND

;19jan83 new section
openirl:		;19jan83
	LXI	D,FCB
	MVI	C,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	readirl	; .IRL file exists
	LXI	D,NOIRLFOUND
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND

irl	db	0	; flag set true if IRL file

readirl:
	lxi	h,irl
	mvi	m,-1	; set true for IRL file
read:
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
mem$ok:	MVI	C,fdma
	CALL	BDOS	; Set DMA
	LXI	D,FCB
	MVI	C,fread
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
;----------------------------------------------------------------------
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
;	Display all public and module names
;
DISPLAY:
	lda	irl	;19jan83 test for IRL file type
	ora	a
	jnz	dspIRL
	LXI	D,table
	call	conmsg
	sub	a
	sta	xpos
	sta	ypos
	lxi	h,dataseg-1
	shld	rel$byte$ptr
	sub	a
	sta	rel$bit$ptr
	jmp	stream
;19jan83 new section
; display .IRL INDEX
dspIRL:
	LXI	D,IRLtable
	call	conmsg
	sub	a
	sta	xpos
	sta	ypos
	lxi	h,dataseg-1
	lxi	d,128	; index is offset 128 bytes from start
	dad	d
	shld	rel$byte$ptr
	sub	a
	sta	rel$bit$ptr
index:
	call	get$nxt$byte	; extent ofset
	call	get$nxt$byte	; record offset
	call	get$nxt$byte	; byte offset
	call	get$nxt$byte	; 1st charater of name
; according to manual index is terminated by 0FFH as first byte,
; but examples do not show this. Instead 0FEH is in first byte.
	lda	rel$byte
	cpi	0feh		; end of index marker
	jz	dsprel
	call	idx$name
	lxi	d,i$name
	call	dsp$name
	jmp	index
; - then display REL file as before
dsprel:	call	newline	; but first start a new line
	LXI	D,table
	call	conmsg
	sub	a
	sta	xpos
	sta	ypos
	lxi	d,dataseg-1
	lda	dataseg		; extent offset to start of module
	rlc		; * 2
	rlc		; * 4
	rlc		; * 8
	rlc		; * 16
	rlc		; * 32
	rlc		; * 64
	mov	h,a	; * 64 * 256 = * 16k
	mvi	l,0
	dad	d	
	xchg
	lda	dataseg+1	; record offset to start of module
	rar
	mov	h,a
	mvi	a,0
	rar
	mov	l,a
	dad	d	; HL -> start of first REL module -1
;
	shld	rel$byte$ptr
	sub	a
	sta	rel$bit$ptr
stream:
	call	get$nxt$bit
	ora	a
	jnz	stm$type
	mvi	a,8
	call	skip$bits
	jmp	stream
;-------
; type
; 00 special link
; 01 program relative
; 10 data relative
; 11 common relative
;
stm$type:
	call	get$nxt$bit
	call	add$nxt$bit
	jz	stm$link	
	mvi	a,16
	call	skip$bits
	jmp	stream
;-------
; link
; 4 bit control field
;
stm$save:	db	0
stm$link:
	call	get$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	sta	stm$save	; save control type
;
	cpi	len$tble
	jnc	bad$code		; code must be less than 4 bits
	mov	e,a
	mvi	d,0
	lxi	h,stm$tble
	dad	d
	dad	d
	mov	e,m
	inx	h
	mov	d,m
	xchg
	pchl
stm$tble:
	dw	stm$entry	;0000b
	dw	stm$common	;0001b
	dw	stm$program	;0010b
	dw	stm$lib		;0011b
	dw	stm$unsd1	;0100b
	dw	stm$size	;0101b
	dw	stm$chain	;0110b
	dw	stm$point	;0111b
	dw	stm$unsd2	;1000b
	dw	stm$external	;1001b
	dw	stm$data	;1010b
	dw	stm$locate	;1011b
	dw	stm$address	;1100b
	dw	stm$segment	;1101b
	dw	stm$end		;1110b
	dw	stm$eof		;1111b
len$tble	equ	($-stm$tble)/2
stm$entry	; 0000b
	call	stm$name
	lxi	d,p$name
	call	dsp$name
	jmp	stream
stm$common	; 0001b
	call	stm$name
	lxi	d,c$name
	call	dsp$name
	jmp	stream
stm$program	; 0010b
	call	stm$name
	call	newline
	lxi	d,m$name
	call	dsp$name
	jmp	stream
stm$lib		; 0011b
	call	stm$name
	lxi	d,l$name
	call	dsp$name
	jmp	stream
stm$unsd1	; 0100b
	call	stm$name
	lxi	d,u$name
	call	dsp$name
	jmp	stream
stm$size	; 0101b
	call	stm$value
	call	stm$name
	lxi	d,cs$name
	call	dsp$name
	jmp	stream
stm$chain	; 0110b
	call	stm$value
	call	stm$name
	lxi	d,x$name
	call	dsp$name
	jmp	stream
stm$point	; 0111b
	call	stm$value
	call	stm$name
	lxi	d,s$name
	call	dsp$name
	jmp	stream
stm$unsd2	; 1000b
	call	stm$value
	call	stm$name
	lxi	d,u$name
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
	sta	rel$bit$ptr
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
	mvi	a,18
	call	skip$bits
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
	call	add$nxt$bit
	call	add$nxt$bit
	rz
	lxi	h,txt$name
	mov	b,a
cr$name:
	push	b
	push	h
	call	get$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
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
	ret

;-------
; index name
; extra variable length index name
; terminated by 0FEH
; and save in NAME with trailing blanks
;
idx$name:
	lxi	h,txt$name
	mvi	b,8
idx$init:
	mvi	m,' '
	inx	h
	dcr	b
	jnz	idx$init
;
	lxi	h,txt$name
	mvi	b,8
idx$chr:
	lda	rel$byte
	cpi	0feh
	rz
	cpi	' '
	jc	not$asc
	cpi	07fh
	jc	asc$ok
not$asc:
	mvi	a,'.'
asc$ok:
	dcr	b
	jz	bad$idx
	mov	m,a
	inx	h
	push	h
	call	get$nxt$byte	; next charater of name
	pop	h
	jmp	idx$chr
bad$idx:
	LXI	D,idx$err
	call	conmsg
	jmp	return
idx$err:	DB cr,lf,'.IRL index error',cr,lf,'$'
;

;
; data areas
;
xpos:	db	0	; cursor position
ypos:	db	0	; cursor position
rel$byte$ptr:	dw	0	; current byte position
rel$byte:	db	0	; current byte
rel$bit$ptr:	db	0	; current bit number
txt$name:	db	'12345678'	; max of 8 byte address
	db	0
;
; routines
;
;-------
; display txt$name use prefix defined in (DE)
;
dsp$name:
	lda	xpos
	cpi	80-8-3
	cnc	newline
	adi	3
	sta	xpos
	call	conmsg
	LXI	D,txt$name
	call	constr
	call	tst$abort
	lda	xpos
	adi	8
	sta	xpos
	ret
;-------
; go to newline unless xpos = 0
;
newline:
	lda	xpos
	ora	a
	rz
	MVI	A,cr
	CALL	conout
	MVI	A,lf
	CALL	conout
	lda	ypos
	inr	a
	sta	ypos
	xra	a
	sta	xpos
	RET
;-------
;Send message terminated by 00h to console
;Reg in:	DE->message
constr:	ldax	d
	cpi	0		; test for end of message
	rz
	inx	d
	push	d
	mov	e,a
	MVI	C,cout
	CALL	BDOS
	pop	d
	jmp	constr

i$name:	db	'/I/','$'	;19jan83 index name
p$name:	db	'/e/','$'
c$name:	db	'/C/','$'
m$name:	db	'/m/','$'
l$name:	db	'/l/','$'
u$name:	db	'/u/','$'
cs$name:	db	'/c/','$'
x$name:	db	'/X/','$'
s$name:	db	'/E/','$'
crlf:	db	cr,lf,'$'
table:	db	cr,lf,'MML:RELMAP - list of REL symbol names'
	db	cr,lf,'/m/ -> module,'
	db	' /l/ -> library,'
	db	' /e/ -> entry list,'
	db	' /c/ -> common block'
	db	cr,lf,'/E/ -> entry point,'
	db	' /C/ -> common symbol,'
	db	' /X/ -> external symbol'
	db	cr,lf,'-------------------------------'
	db	'--------------------------------------'
	db	cr,lf,lf
	db	'$'
irltable:	db	cr,lf,'MML:RELMAP - list of IRL index names'
	db	cr,lf,'-------------------------------'
	db	'--------------------------------------'
	db	cr,lf,lf
	db	'$'
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
; found link$eof command
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
NOSPACE:	DB	'DIRECTORY FULL',cr,0AH,'$'
OLDFILE:	DB	'OLD .REL FILE',cr,0AH,'$'
;
FREE:	DS	2
DMA:	DS	2
stack:	DS	128
stack$top	equ	$
;
;--------------------
; data area to hold REL file
;
DATASEG	equ	$
	END

