	title	'MML: RELUND'
	page	45
;*************
;*  RELUND   *
;*************
;**********************************
;* Copyright: MML Systems Limited *
;* 11 Sun Street, London E.C.2.   *
;*        1981                    *
;*                                *
;* Utility to display all names   *
;* UNDEFINED in a .REL file.      *
;*                                *
;* Format:                        *
;* RELUND <filename>              *
;*                                *
;* Revisions                      *
;* =========                      *
;* JAN 83  - Original             *
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
	DB '        PROGRAM RELUND to list undefined names referencd',cr,lf
	DB '        in either a .REL or a .IRL file',cr,lf
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
	LXI	d,relund
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
relund:
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
;Send message terminated by 00h to console
;Reg in:	DE->message
constr:	ldax	d
	cpi	0		; test for end of message
	rz
	inx	d
	CALL	conout
	jmp	constr

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
;============================================================
;	Display all public and module names
;
DISPLAY:
	LXI	D,table
	call	conmsg
	sub	a
	sta	xpos
	sta	ypos
	mov	h,a
	mov	l,a
	shld	symbol	; number of entries in symbol table

	lda	irl
	ora	a
	jnz	dspIRL
	lxi	h,dataseg-1
	shld	rel$byte$ptr
	sub	a
	sta	rel$bit$ptr
	jmp	stream
;19jan83 new section
; .IRL type file
dspIRL:
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
	cpi	10000b
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
	dw	stm$entry	; 0000b
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

stm$entry	; 0000b
	call	stm$name
	lxi	d,p$name
	call	sav$name
	jmp	stream
stm$common	; 0001b
	call	stm$name
	lxi	d,c$name
	call	sav$name
	jmp	stream
stm$program	; 0010b
	call	stm$name
	call	newline
	lxi	d,m$name
	call	sav$name
	jmp	stream
stm$lib		; 0011b
	call	stm$name
	lxi	d,l$name
	call	sav$name
	jmp	stream
stm$unsd1	; 0100b
	call	stm$name
	lxi	d,u$name
	call	sav$name
	jmp	stream
stm$size	; 0101b
	call	stm$value
	call	stm$name
	lxi	d,cs$name
	call	sav$name
	jmp	stream
stm$chain	; 0110b
	call	stm$value
	call	stm$name
	lxi	d,x$name
	call	sav$name
	jmp	stream
stm$point	; 0111b
	call	stm$value
	call	stm$name
	lxi	d,s$name
	call	sav$name
	jmp	stream
stm$unsd2	; 1000b
	call	stm$value
	call	stm$name
	lxi	d,u$name
	call	sav$name
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
; named saved in TXT$NAME with trailing blanks
; length of name saved in TXT$LEN
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
	lxi	h,txt$len
	mov	m,a	; save no of characters
	inx	h	; HL -> txt$name
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
;-------
; SAV$NAME
; save name in txt$name with type defined in stm$save
; count is in txt$len
;
symbol:	dw	0	; count of number of symbols
sym$ptr:	dw	0	; position of next byte in symbol table
sav$name:
	lhld	symbol
	mov	a,h
	ora	l
	inx	h
	shld	symbol	; increment symbol count
	jnz	next$sym
	lxi	h,dataseg	; first symbol entered here	
	jmp	frst$sym
next$sym:
	lhld	sym$ptr
frst$sym:
	lxi	d,txt$name-1	; hl -> txt$len
	ldax	d
	inx	d
	mov	b,a	; copy (txt$len) characters
	lda	stm$save	; control type
	add	a	; shift 1 bit
	add	a	; shift 2 bit
	add	a	; shift 3 bit
	ora	b	; and OR count bit (maximum of 3)
	mov	m,a	; save count and control type
	inx	h
sav$chr:
	ldax	d
	mov	m,a
	inx	h
	inx	d
	dcr	b
	jnz	sav$chr
	shld	sym$ptr	; save pointer to next symbol entry
	ret

;
; data areas
;
xpos:	db	0	; cursor position
ypos:	db	0	; cursor position
rel$byte$ptr:	dw	0	; current byte position
rel$byte:	db	0	; current byte
rel$bit$ptr:	db	0	; current bit number
txt$len:	db	0	; number of bytes in txt$name
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
i$name:	db	'/I/','$'	;19jan83 index name
p$name:	db	'/e/','$'
c$name:	db	'/C/','$'
m$name:	db	'/m/','$'
l$name:	db	'/l/','$'
u$name:	db	'/u/','$'
cs$name:	db	'/c/','$'
x$name:	db	'/X/','$'
s$name:	db	'/E/','$'
und$name:	db	'/U/','$'
bck$name:	db	'/B/','$'
crlf:	db	cr,lf,'$'
table:	db	cr,lf,'MML:RELUND - list of undefined REL symbol names'
	db	cr,lf,'/m/ -> module,'
	db	' /B/ -> Backward referenced symbol,'
	db	' /U/ -> Undefined symbol'
	db	cr,lf,'--------------'
	db	'-----------------------------------'
	db	'------------------------'
	db	cr,lf,lf
	db	'$'
;***	db	cr,lf,'MML:RELUND - list of REL symbol names'
;***	db	cr,lf,'/m/ -> module,'
;***	db	' /l/ -> library,'
;***	db	' /e/ -> entry list,'
;***	db	' /c/ -> common block'
;***	db	cr,lf,'/E/ -> entry point,'
;***	db	' /C/ -> common symbol,'
;***	db	' /X/ -> external symbol'
;***	db	cr,lf,'-------------------------------'
;***	db	'--------------------------------------'
;***	db	cr,lf,lf
;***	db	'$'
;***irltable:
;***	db	cr,lf,'MML:RELUND - list of IRL index names'
;***	db	cr,lf,'-------------------------------'
;***	db	'--------------------------------------'
;***	db	cr,lf,lf
;***	db	'$'
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
;------------------------------
; found link$eof command - now display undefined names
;
prev$sym:	dw	0	; symbols processed (was reg-b)
more$sym:	dw	0	; remaining symbol entries (was reg-c)
link$eof:
	lhld	symbol
	shld	more$sym
	mov	a,h
	ora	l
	jz	return	; empty file
	lxi	h,0
	shld	prev$sym
	lxi	h,dataseg
	shld	sym$ptr	; pointer to next symbol entry
;
sym$loop:
	call	nxt$symbol	; copy name to txt$name and type into A
	cpi	0110b		; 'X' = external symbol
	jnz	not$ext
	call	frw$ref		; return 0 if not found, <> 0 if found
	jnz	nxt$sym
	call	mod$name	; find/display module name
	call	bck$ref		; return 0 if not found, <> 0 if found
	jnz	pre$ref
	lxi	d,und$name
	jmp	und$ref
pre$ref:
	lxi	d,bck$name
und$ref:
	call	dsp$name
	jmp	nxt$sym
not$ext:
	cpi	0010b		; 'm' = module name
	jnz	nxt$sym
	lhld	old$ptr	; value saved by nxt$symbol:
	shld	mod$ptr	; save address of current module name
nxt$sym:
	lhld	prev$sym
	inx	h
	shld	prev$sym	; update symbols processed
	lhld	more$sym
	dcx	h
	shld	more$sym	; decrement symbols remaining
	mov	a,h
	ora	l
	jnz	sym$loop

; end of symbol table
	call	newline
	jmp	return
;
nxt$symbol:	; copy name to txt$name and type into A
	lhld	sym$ptr
	shld	old$ptr	; save value on entry
	mov	a,m
	inx	h
	push	psw
	ani	0111b	; count
	mov	b,a
	mvi	c,8	; note b must be < 8
	cmp	c
	jnc	bad$code	; error
	lxi	d,txt$name-1
	stax	d	; save count
	inx	d
inr$symbol:
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	c
	dcr	b
	jnz	inr$symbol
	shld	sym$ptr
	mvi	a,' '	; set last character to a space
blk$symbol:
	stax	d
	inx	d
	dcr	c
	jnz	blk$symbol
	pop	psw
	ani	not 0111b	; mask out count
	rrc
	rrc
	rrc	; a set to control type
	ret
;
mod$ptr:	dw	0	; address of last module name entry
old$ptr:	dw	0	; for saving earlier address
frw$ref:		; return 0 if not found, <> 0 if found
	lhld	more$sym	; remaining symbol entries (was reg-c)
	mov	a,h
	ora	l
	rz		; at end of table
	mov	b,h
	mov	c,l	; bc -> symbol entries remaining
	lhld	sym$ptr
	shld	old$ptr	; must save pointer
mov$frw:		; move to start of next entry	
	mov	a,m
	ani	0111b
	inr	a
	mov	e,a
	mvi	d,0
	dad	d	; hl = hl + (hl) + 1
nxt$frw:
	dcx	b
	mov	a,b
	ora	c
	jz	end$frw	; at end of table - none found
	mov	a,m
	ani	not 0111b
	rrc
	rrc
	rrc		; a = control type
	cpi	0000b	; 'e'
	jz	ent$frw
	cpi	0111b	; 'E'
	jnz	mov$frw
ent$frw:
	push	h
	push	b
	call	cmp$sym
	pop	b
	pop	h
	jnz	mov$frw
	dcr	a		; ret having found symbol with a <> 0
end$frw:
	lhld	old$ptr	; must recover pointer
	shld	sym$ptr
	ret
;
bck$ref:		; return 0 if not found, <> 0 if found
	lhld	prev$sym	; symbols processed (was reg-b)
	mov	a,h
	ora	l
	rz		; at end of table
	mov	b,h
	mov	c,l	; bc -> symbol entries remaining
	lhld	sym$ptr
	shld	old$ptr	; must save pointer
	lxi	h,dataseg
	shld	sym$ptr	; start search from beginning
	jmp	nxt$frw	; and scan forwards to current entry

cmp$sym:
	mov	a,m
	ani	0111b	; length of entry
	mov	b,a
	inx	h
	lxi	d,txt$name-1
	ldax	d
	inx	d	; count of required entry
	cmp	b
	rnz		; different lengths
	ora	a
	jz	bad$code	; length must be > 0
cmp$nxt:
	ldax	d
	cmp	m
	rnz
	inx	d
	inx	h
	dcr	b
	jnz	cmp$nxt
	ret		; ret a = 0 if good compare

;--------
mod$name:		; find/display module name
	lhld	mod$ptr
	mov	a,h
	ora	l
	rz		; none yet found, or already displayed
	mov	a,m
	ani	0111b
	mov	b,a	; length of name
	mvi	c,8	; length of field
	cmp	c
	jnc	bad$code	; length must be < 8
mod$nxt:
	push	b
	push	h
	call	newline		; force newline for any module name
	mvi	a,3
	sta	xpos
	lxi	d,m$name
	call	conmsg
	pop	h
	pop	b
mod$out:
	inx	h
	mov	a,m
	call	conout
	dcr	c
	dcr	b
	jnz	mod$out
	mvi	a,' '	; trailing characters set to blank
mod$blk:
	call	conout
	dcr	c
	jnz	mod$blk

	call	tst$abort
	lda	xpos
	adi	8
	sta	xpos
	lxi	h,0
	shld	mod$ptr	; to indicate module name already printed
	ret

	page

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
BEGIN:	DS	2
FREE:	DS	2
DMA:	DS	2
stack:	DS	128
stack$top	equ	$
;
;--------------------
; data area to hold REL file
; and overwritten with symbol names
;
DATASEG	equ	$
	END
