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
;* SEPT 85 - Dumps large files    *
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
	public	start
	public	asize,abase,amin,psize,pmodule,pbase,dsize,dmodule,dbase,csize,cmodule
	public	segptr,cmptype,set$type,reldump,openrel,openirl,found
	public	CONOUT,CONMSG,DISPLAY,dspIRL,dsprel,rd$rel,stream,new$data
	public	cont$data,stm$type,stm$link,stm$l$a,stm$l$p,stm$l$d,stm$l$c,stm$value
	public	type$field,value$field,skip$val,stm$name,set$min,lnk$ptr,seg$lnk,new$lnk,no$lnk
	public	com$lnk,nxt$lnk,tst$lnk,tst$cmn,tst$nme,fnd$nme,not$type,not$len
	public	not$cnt,not$nme,skip$seg,add$cmn,cmn$lnk,cmn$nme,end$cmn,no$cmn
	public	idx$name,xpos,ypos,rel$byte$ptr,rel$bit$ptr,temp$digits,dsp$name,newline
	public	constr,make$word,make$byte,get$8bt,dsp$byte,dsp$half,dsp$bit,dsp$blnk
	public	add$nxt$bit,get$bit,get$byte,get$rec,skip$bits,link$eof
	public	link$lst,lst$lnk,lnk$type,lst$cmn,lst$nme,end$nme,lst$seg
	public	a$table,alst,plst,dlst,clst,read$err,BAD$CODE,RETURN
	public	stack,stack$top,DATASEG,IXDMA,seglink

	page
	aseg
	ORG	100H
	jmp	start
	DB cr,lf
	DB '        PROGRAM RELDUMP to dump the contents of a .REL file',cr,lf
	DB '        COPYWRITE D. POWYS-LYBBE 14 JUL 1981',cr,lf
	DB '        MML, 11 SUN STREET, LONDON. E.C.2.',cr,lf
	DB cr,lf
	DB '        Program reads a .REL file',cr,lf
	DB cr,lf
	db	01ah
;
start:
	xthl
	LXI	SP,stack$top	;SET UP OURS
	push	h	; save callers return on stack
	LXI	H,0
	push	h	; force warm boot if stack is popped
	LXI	d,reldump
	push	d
	ret

NOTFOUND:	DB	'NEW .REL FILE',cr,0AH,'$'
NOIRLFOUND:	DB	'NEW .IRL FILE',cr,0AH,'$'
outofmem:	DB	cr,0ah,'out of memory',cr,0AH,'$'
REL$TYPE	db	'REL'
IRL$TYPE	db	'IRL'

asegment:
abase:		dw	0
amin:		dw	-1
asize:		dw	0
anext:		dw	0
atop:		dw	0

psegment:
pbase:		dw	0
pmodule:	dw	0
psize:		dw	0
pnext:		dw	0
ptop:		dw	0

dsegment:
dbase:		dw	0
dmodule:	dw	0
dsize:		dw	0
dnext:		dw	0
dtop:		dw	0

csegment:
cbase:		dw	0
cmodule:	dw	0
csize:		dw	0
cnext:		dw	0
ctop:		dw	0

bsegment:
bbase:		dw	0
bmodule:	dw	0
bsize:		dw	0
bnext:		dw	0
btop:		dw	0

segptr:	dw	asize

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
;--------------------------------------------------
; RELDUMP
; OPEN file - if TYPE not specified as .REL or .IRL
; then test for .IRL first then .REL
; 19jan83 new section
; search for .REL or .IRL or nothing
;--------------------------------------------------
reldump:
	lxi	h,fcb+32
	mvi	m,0

        LXI	H,FCB+9
	lxi	d,rel$type
	call	cmptype
	jz	openrel	; .REL file specified
;
        LXI	H,FCB+9
	lxi	d,irl$type
	call	cmptype
	jz	openIRL	; .IRL file specified
;------------------
; try for .IRL file
;------------------
	LXI	H,FCB+9
	lxi	d,irl$type
	call	set$type; FCB set to IRL type

	mvi	a,-1
	sta	irl	; set true for IRL file

	LXI	D,FCB
	MVI	C,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	found	; .IRL file exists
;------------------
; try for .REL file
;------------------
	LXI	H,FCB+9
	lxi	d,rel$type
	call	set$type; FCB set to REL type

openrel:		;19jan83
	mvi	a,0
	sta	irl	; set IRL flag false

	LXI	D,FCB
	MVI	C,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	found
;--------------
; no file found
;--------------
	LXI	D,NOTFOUND
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND

;19jan83 new section
openirl:		;19jan83
	mvi	a,-1
	sta	irl	; set true for IRL file
	LXI	D,FCB
	MVI	C,fopen
	CALL	BDOS	;OPEN FILE
	CPI	255
	JNZ	found	; .IRL file exists
	LXI	D,NOIRLFOUND
	call	conmsg
	JMP	RETURN	;FILE NOT FOUND

irl	db	0	; flag set true if IRL file

found:
	lxi	d,dataseg+256		; check space for DMA
	lhld	6	; top of memory
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
mem$ok:	jmp	DISPLAY
;----------------------------------------------------------------------
;
CONOUT:	PUSH H
	PUSH D
	push	b
	push	psw
	mov	e,a
	mvi	c,cout
	CALL	Bdos
	lxi	h,xpos
	inr	m
	call	tst$abort
	pop	psw
	pop	b
	POP	D
	POP	H
	ret
;-----------------------------------------
;Send message terminated by '$' to console
;Reg in:	DE->message
;-----------------------------------------
CONMSG:
	push	d
	lxi	h,xpos
cmsg1:	ldax	d
	cpi	'$'
	jz	cmsg2
	inr	m
	inx	d
	jmp	cmsg1
cmsg2:	pop	d
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
;-----------------------------------
;	Display dump of REL/IRL file
;-----------------------------------
DISPLAY:
	lxi	d,dataseg
	MVI	C,fdma
	CALL	BDOS	; Set DMA

	lda	irl	;19jan83 test for IRL file type
	ora	a
	jnz	dspIRL

	LXI	D,table
	call	conmsg
	jmp	rd$rel

; display .IRL INDEX
dspIRL:
	LXI	D,IRLtable
	call	conmsg
	xra	a
	sta	xpos
	sta	ypos

	lxi	h,80
	shld	rel$byte$ptr
	xra	a
	sta	rel$bit$ptr
	call	get$rec	; read 1st record

	lxi	h,dataseg
	lxi	d,ixdma
	mvi	b,128
cpydma:	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	cpydma

;	lxi	h,80
;	shld	rel$byte$ptr
;	xra	a
;	sta	rel$bit$ptr
;	call	get$rec	; read 2nd record

;index:
;	call	get$byte	; extent ofset
;	call	get$byte	; record offset
;	call	get$byte	; byte offset
;	call	get$byte	; 1st charater of name
; according to manual index is terminated by 0FFH as first byte of name,
; but examples do not show this. Instead 0FEH is in first byte.
;	lda	rel$byte
;	cpi	0feh		; end of index marker
;	jz	dsprel
;	call	idx$name
;	lxi	d,i$name
;	call	dsp$name
;	jmp	index
; - then display REL file as before
dsprel:	call	newline	; but first start a new line
	LXI	D,table
	call	conmsg

	lxi	h,ixdma
	mov	a,m		; extent offset to start of module
	sta	fcb+12		; offset to ex in FCB
	inx	h
	mov	a,m		; record number
	sta	fcb+32		; offset to cr in FCB
;
rd$rel:
	xra	a
	sta	xpos
	sta	ypos
	lxi	h,128
	shld	rel$byte$ptr
	xra	a
	sta	rel$bit$ptr
;
	lxi	h,psize
	shld	segptr		; assume starts with CSEG
;
stream:
	call	get$bit
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
cont$data:
	call	make$byte

	lhld	segptr
	mov	e,m
	inx	h
	mov	d,m
	inx	d		; increment location counter
	mov	m,d
	dcx	h
	mov	m,e
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
	call	get$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	dsp$blnk
	jz	stm$link	
	call	make$word
	jmp	stream
;--------------------
; link
; 4 bit control field
;--------------------
stm$link:
	call	get$bit
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
	call	put$nme
	call	block		; find common block for BSEGMENT
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
	call	put$nme
	lhld	value$field
	shld	cmn$blk+10
	call	com$lnk
	jmp	stream
put$nme:
	lxi	h,txt$cnt
	lxi	d,cmn$blk
	mvi	b,8
nxt$pn1:
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	nxt$pn1
	ret
cmn$blk:
	db	0	; 3 bit name count
	ds	7	; name
	dw	0	; 16 bit base address (from CSEGMENT)
	dw	0	; 16 bit length

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
	lhld	value$field
	shld	dtop		; size of data in current module
	jmp	stream
stm$locate	; 1011b
	call	stm$value
	lda	type$field
	mov	b,a
	cpi	00b
	jz	stm$l$a
	cpi	01b
	jz	stm$l$p
	cpi	10b
	jz	stm$l$d
	cpi	11b
	jz	stm$l$c
	jmp	stream
stm$l$a:
	lxi	h,asize
	shld	segptr

	lhld	abase
	xchg
	lhld	asize
	dad	d
	xchg
	lhld	value$field
	mov	a,h
	sub	d
	mov	c,a
	mov	a,l
	sub	e
	ora	c
	jz	stream		; no change in counter

	lhld	abase
	xchg
	lhld	asize
	mov	a,h
	ora	l
	cnz	seg$lnk

	lxi	h,asegment
	call	set$min$nxt

	lhld	value$field
	shld	abase
	lxi	h,0
	shld	asize
	jmp	stream

stm$l$p:
	lxi	h,psize
	shld	segptr

	lxi	h,psegment
	call	tst$value
	jz	stream		; no change in counter

	lxi	h,psegment
	call	add$lnk

	lxi	h,psegment
	call	set$next

	lhld	value$field
	shld	pmodule
	lxi	h,0
	shld	psize
	jmp	stream

stm$l$d:
	lxi	h,dsize
	shld	segptr

	lxi	h,dsegment
	call	tst$value
	jz	stream		; no change in counter

	lxi	h,dsegment
	call	add$lnk

	lxi	h,dsegment
	call	set$next

	lhld	value$field
	shld	dmodule
	lxi	h,0
	shld	dsize
	jmp	stream

stm$l$b:			; current selected common block
	lxi	h,bsize
	shld	segptr

	lxi	h,bsegment
	call	tst$value
	jz	stream		; no change in counter

;------	lxi	h,bsegment
;------	call	add$lnk

	lxi	h,bsegment
	call	set$next

	lhld	value$field
	shld	bmodule
	lxi	h,0
	shld	bsize
	jmp	stream

stm$l$c:
	lxi	h,csize
	shld	segptr

	lxi	h,csegment
	call	tst$value
	jz	stream		; no change in counter

	lxi	h,csegment
	call	add$lnk

	lxi	h,csegment
	call	set$next

	lhld	value$field
	shld	cmodule
	lxi	h,0
	shld	csize
	jmp	stream

stm$address	; 1100b
	call	stm$value
	jmp	stream
stm$segment	; 1101b
	call	stm$value
	lhld	value$field
	shld	ptop		; size of program in current module
	jmp	stream
stm$end	; 1110b
	call	stm$value
	call	end$module
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
	call	get$bit
	call	dsp$bit
	call	add$nxt$bit
	lxi	h,type$field
	mov	m,a		; save address type field
	call	dsp$bit
	call	dsp$blnk
	call	make$word
	lhld	temp$digits
	shld	value$field
	ret
type$field:
	db	0		; 2 bit address type field (00 01 10 11)
value$field:
	dw	0		; 16 bit value field
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
	call	get$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	add$nxt$bit
	call	dsp$bit
	call	dsp$blnk
	rz
	lxi	h,txt$cnt
	mov	m,a
	inx	h
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
	call	get$bit
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

;--------------------------------------
; Test if value continuation of segment
; On entry: HL -> segment
; comprising
;	base:	dw	0
;	module:	dw	0
;	size:	dw	0
;	next:	dw	0
; <B> preserved
;----------------------------
tst$value:
	inx	h
	inx	h

	mov	e,m
	inx	h
	mov	d,m	; <DE> = module
	inx	h

	mov	a,m
	inx	h
	mov	h,m
	mov	l,a	; <HL> = size	

	dad	d
	xchg
	lhld	value$field
	mov	a,h
	sub	d
	mov	c,a
	mov	a,l
	sub	e
	ora	c
	ret			; ZF = 1 if no change in counter

;--------------------------------
; Test and add segment to link
; On entry: HL -> segment
;           B = segment number
; comprising
;	base:	dw	0
;	module:	dw	0
;	size:	dw	0
;	next:	dw	0
;----------------------------
add$lnk:
	mov	e,m
	inx	h
	mov	d,m	; <DE> = base relative
	inx	h

	mov	a,b
	mov	c,m
	inx	h
	mov	b,m	; <BC> = module location base
	inx	h

	xchg
	dad	b
	xchg
	mov	b,a

	mov	a,m
	inx	h
	mov	h,m
	inx	h
	mov	l,a	; <HL> = size

	mov	a,h
	ora	l
	cnz	seg$lnk
	ret

;--------------------------------
; Test and set next maximum value
; On entry: HL -> segment
; comprising
;	base:	dw	0
;	module:	dw	0
;	size:	dw	0
;	next:	dw	0
;	top:	dw	0
;----------------------------
set$next:
	mov	e,m
	inx	h
	mov	d,m
	inx	h	; <DE> = base value

	push	d
	mov	c,m
	inx	h
	mov	b,m
	inx	h
	xchg
	dad	b
	xchg		; <DE> = base + module

	mov	c,m
	inx	h
	mov	b,m
	inx	h
	xchg
	dad	b
	xchg		; <DE> = base + module + size

	call	tst$next	; (HL) -> ?next

	pop	d	; <DE> = base
	inx	h
	inx	h
	mov	c,m
	inx	h
	mov	b,m	; <BC> = top size of module
	dcx	h
	dcx	h
	dcx	h
	xchg
	dad	b
	xchg		; <DE> = base + top

tst$next:		; (HL) -> current value, <DE> = new value
	mov	c,m
	inx	h
	mov	b,m	; <BC> = next value
	dcx	h
	mov	a,c
	sub	e
	mov	a,b
	sbb	d
	rnc
	mov	m,e
	inx	h
	mov	m,d
	dcx	h
	ret

;--------------------------------
; Test and set minimum value and
; test and set next maximum value
; On entry: HL -> segment
; comprising
;	base:	dw	0
;	min:	dw	0
;	size:	dw	0
;	next:	dw	0
;----------------------------
set$min$nxt:
	mov	e,m
	inx	h
	mov	d,m
	inx	h		; <DE> = base value

	inx	h
	inx	h

	mov	c,m
	inx	h
	mov	b,m
	inx	h
	mov	a,b
	ora	c
	cnz	set$min		; only set min if size > 0

	xchg
	dad	b
	xchg			; <DE> = base + size

	mov	c,m
	inx	h
	mov	b,m		; <BC> = next value
	dcx	h
	mov	a,c
	sub	e
	mov	a,b
	sbb	d
	rnc
	mov	m,e
	inx	h
	mov	m,d
	dcx	h
	ret

set$min:
	push	h
	push	b
	push	d
	lxi	b,-6
	dad	b
	mov	e,m
	inx	h
	mov	d,m	; base
	inx	h
	mov	c,m
	inx	h
	mov	b,m	; minimum
	mov	a,e
	sub	c
	mov	a,d
	sbb	b
	pop	d
	pop	b
	pop	h
	rnc

	push	h
	push	b
	lxi	b,-6
	dad	b
	mov	c,m
	inx	h
	mov	b,m
	inx	h
	mov	m,c
	inx	h
	mov	m,b	; new minimum
	pop	b
	pop	h
	ret

;------------------------------------
; Add segment details to segment link
; On entry <B> = address type field
;         <DE> = base address
;         <HL> = length
; Segment block
; Byte offset 0 - Byte = 1011B location
; Byte offset 1 - Byte - Segment (00 01 10 11)
; Byte offset 2 - Word - Base of segment
; Byte offset 4 - Word - Length of segment
;------------------------------------
lnk$ptr:	dw	seglink
seg$lnk:
	push	h
	push	d
	lhld	0006h
	lxi	d,-5
	dad	d
	xchg
	lhld	lnk$ptr
	mov	a,d
	cmp	h
	jc	no$lnk
	jnz	new$lnk
	mov	a,e
	cmp	l
	jc	no$lnk
	jz	no$lnk
new$lnk:
	mvi	m,1011b
	inx	h
	mov	m,b
	inx	h
	pop	d
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	pop	d
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	shld	lnk$ptr
	ret
no$lnk:			; no room for segment link
	pop	d
	pop	d
	ret

;------------------------------------
; Add common block to segment link
; On entry CMN$BLK contains:
;	Byte 0 - name length
;	Byte 1 - name	
; 	Byte 8 - word base address
;	Byte 10- word length
; Common blocks
; Byte offset 0 - Byte = 0101B for common
; Byte offset 1 - Byte - Common Name count
; Byte offset 2 - Bytes - Common Name  of length count bytes
; Byte offset 2+- Word - Base address of common block
; Byte offset 4+- Word - Length of common block
;------------------------------------

com$lnk:
	lxi	d,seglink
nxt$lnk:
	lhld	lnk$ptr
	mov	a,d
	cmp	h
	jnz	tst$lnk
	mov	a,e
	cmp	l
	jz	add$cmn
tst$lnk:
	ldax	d
	cpi	1011b
	jz	skip$seg
	cpi	0101b
	jz	tst$cmn
	jmp	bad$code
tst$cmn:
	inx	d
	lxi	h,cmn$blk	; common block
	ldax	d
	mov	b,a
	cmp	m	; same name count ?
	inx	d
	inx	h
	jnz	not$cnt
tst$nme:
	mov	a,b
	ora	a
	jz	fnd$nme
	ldax	d
	cmp	m	; same name ?
	jnz	not$nme
	inx	d
	inx	h
	dcr	b
	jmp	tst$nme	
fnd$nme:			; common name already in list
	ret			; and return
not$cnt:
not$nme:
	mov	a,b
	ora	a
	jz	skip$cmn
	inx	d
	dcr	b
	jmp	not$nme
skip$cmn:
	inx	d
	inx	d
	inx	d
	inx	d
	jmp	nxt$lnk
skip$seg:
	lxi	h,6
	dad	d
	xchg
	jmp	nxt$lnk

add$cmn:
	lxi	h,csegment
	mov	e,m
	inx	h
	mov	d,m		; segment base
	inx	h
	mov	c,m
	inx	h
	mov	b,m		; module base
	inx	h
	xchg
	dad	b		; base + module
	xchg
	mov	c,m
	inx	h
	mov	b,m		; size
	inx	h
	xchg
	dad	b		; base + module + size
	shld	cmn$blk+8	; common base address

	lxi	d,cmn$blk	; common block
	mov	a,m
	adi	6		; total length of common link
	lhld	lnk$ptr
	mov	e,a
	mvi	d,0
	dad	d
	xchg
	lhld	0006h
	xchg
	mov	a,d
	cmp	h
	jc	no$cmn
	jnz	cmn$lnk
	mov	a,e
	cmp	l
	jc	no$cmn
	jz	no$cmn
cmn$lnk:
	lxi	d,cmn$blk	; common block
	lhld	lnk$ptr
	mvi	m,0101b
	inx	h
;				name length
	ldax	d
	mov	m,a
	inx	h
	inx	d
;				name
	mov	b,a
	call	copyB		; copy <B> bytes from (DE) to (HL)
;				common base
	lxi	d,cmn$blk+8
	ldax	d
	mov	m,a
	inx	h
	inx	d
	ldax	d
	mov	m,a
	inx	h
	inx	d
;				common length
	lxi	d,cmn$blk+10
	ldax	d
	mov	m,a
	mov	c,a
	inx	h
	inx	d
	ldax	d
	mov	m,a
	mov	b,a		; <BC> = length
	inx	h
	inx	d

	shld	lnk$ptr

	lhld	csize
	dad	b
	shld	csize		; increase size by length

	ret

; copy <B> bytes from (DE) to (HL)
copyB:
	mov	a,b
	ora	a
	rz
	ldax	d
	mov	m,a
	inx	h
	inx	d
	dcr	b
	jmp	copyB
no$cmn:			; no room for common link
	ret

;------------------------------------
; Search for common block and
; Add to BSEGMENT - current common block
; On entry CMN$BLK contains:
;	Byte 0 - name length
;	Byte 1 - name	
; Common blocks
; Byte offset 0 - Byte = 0101B for common
; Byte offset 1 - Byte - Common Name count
; Byte offset 2 - Bytes - Common Name  of length count bytes
; Byte offset 2+- Word - Base address of common block
; Byte offset 4+- Word - Length of common block
;------------------------------------

block:		; find common block for BSEGMENT
	lxi	d,seglink
nxt$b1:
	lhld	lnk$ptr
	mov	a,d
	cmp	h
	jnz	tst$b1
	mov	a,e
	cmp	l
	jz	bad$code	; common not found
tst$b1:
	ldax	d
	cpi	1011b
	jz	skip$b1
	cpi	0101b
	jz	tst$b2
	jmp	bad$code
tst$b2:
	inx	d
	lxi	h,cmn$blk	; common block
	ldax	d
	mov	b,a
	cmp	m	; same name count ?
	inx	d
	inx	h
	jnz	not$b2
tst$b3:
	mov	a,b
	ora	a
	jz	fnd$b1
	ldax	d
	cmp	m	; same name ?
	jnz	not$b3
	inx	d
	inx	h
	dcr	b
	jmp	tst$b3	
not$b2:
not$b3:
	mov	a,b
	ora	a
	jz	skip$b2
	inx	d
	dcr	b
	jmp	not$b3
skip$b2:
	inx	d
	inx	d
	inx	d
	inx	d
	jmp	nxt$b1
skip$b1:
	lxi	h,6
	dad	d
	jmp	nxt$b1
	xchg

fnd$b1:			; common name already in list
	xchg
	mov	e,m
	inx	h
	mov	d,m	; common base
	inx	h
	mov	c,m
	inx	h
	mov	b,m	; common length

	lxi	h,0
	xchg
	shld	bbase	; set base
	xchg
	shld	bmodule	; set offset
	shld	bsize	; set size
	xchg
	dad	b	
	shld	bnext	; set next
	dcx	h
	shld	btop	; set top

	ret			; and return

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
	push	b
	call	get$byte	; next charater of name
	pop	b
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
rel$byte$ptr:	dw	0	; current byte offset position
rel$byte:	db	0	; current byte
rel$bit$ptr:	db	0	; current bit number
last$bit:	db	0
txt$cnt:	db	0	; name count (0-7)
txt$name:	db	'12345678'	; max of 8 byte address
	db	0
temp$digits:	ds	4
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
	lda	xpos
	cpi	80-8
	cnc	newline
	LXI	D,txt$name
	call	constr
	call	tst$abort
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
;-----------------------------------------
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
	lxi	h,xpos
	inr	m
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
reltab:	db	cr,lf,'MML:RELMAP - list of REL symbol names'
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
;get & display hex digit(s)
;
make$word:
	call	get$8bt
	sta	temp$digits
	call	get$8bt
	sta	temp$digits+1
	call	dsp$byte
	lda	temp$digits
	call	dsp$byte
	ret
make$byte:
	call	get$8bt
	call	dsp$byte
	ret
get$8bt:
	call	get$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	call	add$nxt$bit
	ret
dsp$byte:
	push	psw
	rrc
	rrc
	rrc
	rrc
	call	dsp$half
	pop	psw
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
;-----------------------------------------------------
;add next bit to current bit in <A> after shifting <A>
;-----------------------------------------------------
add$nxt$bit:
	rlc	
	mov	b,a
	push	b
	call	get$bit
	pop	b
	ora	b
	ret
;
; fetch next bit as bit 0 in A
;
get$bit:
	lda	rel$bit$ptr
	dcr	a
	cpi	0
	cm	get$byte
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
get$byte:
	lda	rel$byte$ptr
	ora	a
	cm	get$rec
	lhld	rel$byte$ptr
	lxi	d,dataseg
	xchg
	dad	d
	xchg
	inx	h
	shld	rel$byte$ptr
	ldax	d
	sta	rel$byte
	mvi	a,7	; start with bit 7
	ret
;
; read next record into DMA buffer
;
get$rec:
	LXI	D,FCB
	MVI	C,fread
	CALL	BDOS	;READ RECORD
	ORA	A	; Check if read beyond last record
	JNZ	read$err
	lxi	h,0
	shld	rel$byte$ptr
	ret
;
; skip B bits
;
skip$bits:
	cpi	0
	rz
	push	psw
	call	get$bit
	pop	psw
	dcr	a
	jmp	skip$bits
;
; reached link eof command
;
link$eof:
	call	end$module
;
	call	link$lst	; list segment/common list
;
	call	top$lst		; list segment top
;
	call	newline
;
	jmp	return
;-------------------------------
; Update values at end of module
;-------------------------------
end$module:
	mvi	b,00b
	lhld	abase
	xchg
	lhld	asize
	mov	a,h
	ora	l
	cnz	seg$lnk

	lxi	h,asegment
	call	set$min$nxt

	mvi	b,01b
	lxi	h,psegment
	call	add$lnk

	lxi	h,psegment
	call	set$next

	lhld	pnext
	shld	pbase
	lxi	h,0
	shld	pmodule
	shld	psize
	shld	ptop

	mvi	b,10b
	lxi	h,dsegment
	call	add$lnk

	lxi	h,dsegment
	call	set$next

	lhld	dnext
	shld	dbase
	lxi	h,0
	shld	dmodule
	shld	dsize
	shld	dtop

	mvi	b,11b
	lxi	h,csegment
	call	add$lnk

	lxi	h,csegment
	call	set$next

	lhld	cnext
	shld	cbase
	lxi	h,0
	shld	cmodule
	shld	csize
	shld	ctop

	lxi	h,0
	shld	bbase
	shld	bmodule
	shld	bsize
	shld	bnext
	shld	btop


	ret

; list segment/common list
link$lst:
	lxi	d,seglink
lst$lnk:
	lhld	lnk$ptr
	mov	a,d
	cmp	h
	jnz	lnk$type
	mov	a,e
	cmp	l
	rz			; listed all
lnk$type:
	push	d
	call	newline
	pop	d
	ldax	d
	inx	d

	cpi	1011b
	jz	lst$seg
	cpi	0101b
	jz	lst$cmn
	jmp	bad$code

lst$cmn:
	push	d
	lxi	d,s$nme
	call	conmsg
	pop	d
	ldax	d	; length of name
	inx	d
	mov	b,a
	mov	c,a	; and save
lst$nme:
	mov	a,b
	ora	a
	jz	end$nme	; end of common block
	ldax	d
	call	conout
	inx	d
	dcr	b
	jmp	lst$nme	
end$nme:
	push	b
	push	d
	lxi	d,e$nme
	call	conmsg
	pop	d
	pop	b
pad$blk:		; add blanks to extend common name to 6 characters
	mov	a,c
	cpi	6
	jnc	lst$size
	mvi	a,' '
	call	conout
	inr	c
	jmp	pad$blk
	mvi	a,' '
	call	conout
	inr	c
	jmp	pad$blk

lst$seg:
	ldax	d	; address type
	inx	d
	push	d
	mov	e,a
	mvi	d,0
	lxi	h,a$table
	dad	d
	dad	d
	mov	e,m
	inx	h
	mov	d,m
	call	CONMSG	; output address type
	pop	d
lst$size:
	xchg
	mov	e,m
	inx	h
	mov	d,m	; base address
	inx	h
	mov	c,m
	inx	h
	mov	b,m	; length
	inx	h
	mov	a,d
	call	dsp$byte
	mov	a,e
	call	dsp$byte
	xchg		; restore DE (HL = base)

	mov	a,b
	ora	c	; test for zero length
	jz	lst$lnk	; -yes-

	dad	b	; add length (HL = base) to give end address + 1
	dcx	h
	push	h
	push	d
	lxi	d,tomsg
	call	conmsg
	pop	d
	pop	h

	mov	a,h
	call	dsp$byte
	mov	a,l
	call	dsp$byte

	jmp	lst$lnk

;---------------------------------------------------
; display maximum values of each relocatable segment
;---------------------------------------------------
top$lst:
	lxi	b,00b
	lhld	amin
	xchg
	lhld	anext
	mov	a,h
	ora	l
	cnz	range$seg

	lxi	b,01b
	lhld	pnext
	mov	a,h
	ora	l
	cnz	top$seg	; list segment top

	lxi	b,10b
	lhld	dnext
	mov	a,h
	ora	l
	cnz	top$seg	; list segment top

	lxi	b,11b
	lhld	cnext
	mov	a,h
	ora	l
	cnz	top$seg	; list segment top

	ret

;---------------------------
; Reloc seg display MAX
; On entry <HL> = next value
;	   <BC>  = address type
;---------------------------
top$seg:
	push	h
	push	b
	call	newline
	pop	b
	lxi	h,a$table
	dad	b
	dad	b
	mov	e,m
	inx	h
	mov	d,m
	call	CONMSG	; output address type

	lxi	d,mxmsg
	call	conmsg

	pop	h
	dcx	h
	mov	a,h
	call	dsp$byte
	mov	a,l
	call	dsp$byte
	ret

;---------------------------
; ASEG display MIN and MAX
; On entry <DE> = min value
;          <HL> = next value
;	   <A>  = address type
;---------------------------
range$seg:
	push	h
	push	d
	push	b
	call	newline
	pop	b
	lxi	h,a$table
	dad	b
	dad	b
	mov	e,m
	inx	h
	mov	d,m
	call	CONMSG	; output address type

	lxi	d,mnmsg
	call	conmsg

	pop	h	; min value
	mov	a,h
	call	dsp$byte
	mov	a,l
	call	dsp$byte

	mvi	a,' '
	call	conout

	lxi	d,mxmsg
	call	conmsg

	pop	h	; next value
	dcx	h
	mov	a,h
	call	dsp$byte
	mov	a,l
	call	dsp$byte

	ret

a$table:
	dw	alst
	dw	plst
	dw	dlst
	dw	clst

		;/123456/ $
alst:	db	'ASEG     $'
plst:	db	'CSEG     $'
dlst:	db	'DSEG     $'
clst:	db	'COMMON   $'
tomsg:	db	'-$'
s$nme:	db	'/$'
e$nme:	db	'/ $'
mnmsg:	db	'base = $'
mxmsg:	db	'top: $'

read$err:
	LXI	D,eof$err
	call	conmsg
	jmp	RETURN
BAD$CODE:
	LXI	D,prog$err
	call	conmsg

RETURN:			;NORMAL RETURN
	jmp	0
;
prog$err:	DB cr,lf,'program error',cr,lf,'$'
;
NOSPACE:	DB	'DIRECTORY FULL',cr,0AH,'$'
OLDFILE:	DB	'OLD .REL FILE',cr,0AH,'$'
eof$err:	DB cr,lf,'Unexpected EOF',cr,lf,'$'
;
stack:	DS	128
stack$top	equ	$
;
;---------------------------
; data area to hold REL file
;---------------------------
DATASEG	equ	$
IXDMA	equ	DATASEG + 128
;-----------------------------------------------------------
; segment link list
; Common blocks
; Byte offset 0 - Byte = 0101B for common
; Byte offset 1 - Byte - Common Name count
; Byte offset 2 - Bytes - Common Name  of length count bytes
; Byte offset 2+- Word - Base address of common block
; Byte offset 4+- Word - Length of common block
; Segment block
; Byte offset 0 - Byte = 1011B location
; Byte offset 1 - Byte - Segment (00 01 10 11)
; Byte offset 2 - Word - Base of segment
; Byte offset 4 - Word - Length of segment
;-----------------------------------------------------------
seglink	equ	IXDMA + 128

	END
