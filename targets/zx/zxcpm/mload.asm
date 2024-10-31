;	title	'MLOAD MULTI-FILE HEX LOAD UTILITY'
;
;		*********************************
;		*	   MLOAD.ASM		*
;		*   Multi-file Hex Load Utility *
;		*	   for CP/M		*
;		*********************************
;
;
;	Replacement for the cp/m "LOAD" program: this program
;	fixes many of the problems associated with the "CP/M"
;	load program, and adds many new features.
;
; ----------------
;
;	Rev 2.5
;	03/10/88
;	Property of NightOwl Software, Inc. Fort Atkinson, WI 53538
;	Written by Ron Fowler, Nightowl Software, Inc.
;
; ----------------
; Notice: this program is NOT public domain; copyright is retained by
; NightOwl Software, Inc. of Fort Atkinson, WI ... All Rights Reserved.
;
; License is granted for free use and re-distribution this program, as
; long as such use and re-distribution is done without profit.
;
; ----------------
;
; modification history:
;
; 2.5	(WOD)	This version corrects a bug that overlayed the first six
;		bytes of the CCP.  The error did not show up unless a
;		jump to the CCP was done without a warm boot since MLOAD
;		used.  This source file has been modified here with
;		concurrence of the author of MLOAD, Ron Fowler.
;
; 2.4	(RGF)	We apologize for this relatively insubstantial update,
;		but someone has caused what we consider to be a problem,
;		by making changes to the program, and re-releasing under
;		the same version number.  The changes in this case were
;		conversion of the opcode fields (but not the comments,
;		can you believe that??) of every line to upper case! That
;		totally invalidated the CRC of the source file, since there
;		are now two different MLOAD 2.3's running around.
;
;		We DO NOT want these stupid mixed upper/lower case changes.
;		Someone somewhere has decided that this is the way assembly
;		language source should be, and we most VEHEMENTLY disagree.
;		It's a pain in the neck to make changes to and we don't
;		care to run our programs through conversion programs every
;		time we make changes.
;
;		So ... leave the case of this file AS IS.  Any changes made
;		to this program and not co-ordinated through us may very
;		well endanger availability of source code when we make
;		future updates.  'nuff said		--NightOwl Software
;
; 2.3	(RGF)	Trivial cosmetic changes
; 2.2	(RGF)	Modified copyright notice to show new owner of the
;		program.
; 2.1	(RGF)	Fixed problem on disk-full when writing output file
;		(mload previously didn't error out on a full disk)
; 2.0	(RGF)	Added the ability to pre-load a non-hex file, allowing
;		mload to be used to load hex file patches (obviating any
;		need to use DDT).  The normal mload syntax is preserved.
;		the first (and only the first) filespec (after the "=",
;		if used) may be non-hex; the filetype must be specified.
;		Examples:
;
;			1)	mload ws.com,wspatch
;			2)	mload MEXTEST=MEX112.COM,MXO-US13
;			3)	mload ws.ovr,ovrpatch
;
;		The first example loads WS.COM, overlays it with
;		wspatch.hex, and writes the output to WS.COM.  The
;		second example loads MEX112.COM, overlays it with
;		MXO-US13.HEX, and writes the output file to MEXTEST.COM.
;		(note that the second example is the recommended technique,
;		since it preserves the original file). The third example
;		loads WS.OVR and patches it with the file "OVRPATCH.HEX".
;
;		Also added this rev: ZCPR2-style du specs are now fully
;		supported, for both input and output files.  Thus, the
;		following command lines are permissable:
;
;			b3>mload a4:myfile.com=0:bigfil,b6:patch1,c9:patch2
;			a6>mload b5:=c3:mdm717.com,mdmpatch
;
;		After loading, an additional information line is now printed
;		in the statistics report, which displays the true size of the
;		saved image (the previous report was technically correct, but
;		could result in confusion for certain kinds of files with
;		imbedded "DS" and "ORG" statements in the original source code).
;
; 1.0 - 1.4	(RGF) change log removed to conserve space
;
;	originally written by ron fowler, fort atkinson, wisconsin
;
;
;
; For assembly with asm.com or mac (delete above title line if
; assembling with asm.com).
;
; This program is a replacement for the cp/m "LOAD" program.
; Why replace "LOAD"?  well... LOAD.COM has a few deficiencies.
; For example, if your hex file's origin is above 100h, LOAD.COM
; prepends blank space to the output file to insure it will work
; as a CP/M transient.	It cares not if the file is not intended
; as a CP/M transient.	it also doesn't like hex records with mixed
; load addresses  (for example, one that loads below a previous record --
; which is a perfectly legitimate happenstance).  Also, LOAD.COM
; can load only one program at a time, and has no provision for
; a load bias in the command specification. Finally, there is no
; provision for user specification of the output file name.
;
;
; Hence, this program....
;
;------------------------------------------------------------
;
; Syntax is as follows:
;
;	mload [<outnam=] <filename>[,<filename>...] [bias]
;
; where <outnam> is the (optional!;) output file name (only the drive
; spec and primary filename may be specified; the output filetype is
; derived exclusively from the 3-byte string at 103h within MLOAD),
; <filename> specifies files to load and <bias> is the offset within
; the saved image to apply when loading the file.
;
; MLOAD with no arguments prints a small help message -- this message
; is also printed whenever a command line syntax error occurs.
;
; Filenames may contain drive/user specs, and must not contain wildcards.
; Input filenames must be separated by commas, and a space is required
; between the last filename and the optional bias.
;
; A load information summary is printed at the successful conclusion
; of the load.	Any errors in loading will generally include the name
; of the file in question.
;
; If no output filename is specified, it will be derived from the first
; input filename, with filetype of 'COM', if not otherwise specified
; (this default filetype may be patched directly into mload via DDT
; (or with MLOAD itself, using a patch file) -- its location is at 103H
; in MLOAD.COM). Note that a command line of the form "C:=<FILENAME>"
; will place the output file on the "C" drive with the same primary
; filename as the input file.
;
; In its simplest form, MLOAD's syntax is identical to LOAD.COM; thus
; there should be no problem in learning to use the new program.  The
; only significant difference here is that, under LOAD.COM, all files
; are output starting at 100h, even if they originate elsewhere.  MLOAD
; outputs starting at the hex file origin (actually, the first hex rec-
; ord specifies the output load address).  The bias option may be used
; to override this.
;
; An example should clarify this.  Suppose you have a file that loads
; at 1000h.  LOAD.COM would save an output file that begins at 100h and
; loads past 1000h (to wherever the program ends).  MLOAD will save an
; output file starting from 1000h only.  If, for some reason you need the
; file to start at 100h in spite of its 1000h origin (i can think of sev-
; eral circumstances where this would be necessary), you'd have to specify
; a bias to mload.  thus, using this example, "MLOAD MYFILE 0F00" would do.
;
; Note that this program re-initializes itself each time it is run.
; Thus, if your system supports a direct branch to the tpa (via a zero-length
; .COM file, or the ZCPR "GO" command), you may safely re-execute MLOAD.
;
; Please report any bugs, bug fixes, or enhancements to
;
;		"FORT FONE FILE FOLDER" rcpm/cbbs
;		Fort Atkinson, Wisconsin
;		(414) 563-9932 (no ring back)
;
;				--Ron Fowler
;				  03/08/84   updated 1/31/85
;
;------------------------------------------------------------
;
; CP/M equates
;


BASE equ 6000h

warmbt	equ	BASE		;warm boot
system	equ	BASE+5		;system entry (also top of mem pntr)
dfcb	equ	BASE+5ch		;default file control block
ft	equ	9		;fcb offset to filetype
tbuf	equ	BASE+80h		;default buffer
tpa	equ	BASE+100h		;transient program area
eof	equ	1ah		;cp/m end-of-file mark
fcbsiz	equ	33		;size of file control block
;
; CP/M system calls
;
pcharf	equ	2		;print char
seldf	equ	14		;select disk drive
openf	equ	15		;open file
closef	equ	16		;close file
fsrchf	equ	17		;search for first
fsrchn	equ	18		;search for next
erasef	equ	19		;delete file
readf	equ	20		;read record
writef	equ	21		;write record
creatf	equ	22		;create file
getdrf	equ	25		;return dflt drive #
sdmaf	equ	26		;set dma address
gsuser	equ	32		;get/set user #
rrand	equ	33		;read random
wrand	equ	34		;write random
filszf	equ	35		;compute file size
srand	equ	36		;set random
;
; ASCII character constants
;
cr	equ	13
lf	equ	10
bel	equ	7
tab	equ	' '
;
; without further ado...
;
	org	tpa
;
	jmp	begin		;jump over default output filetype
;
; the default output filetype is located at 103h for easy patching
;
outtyp:	db	'CM6'
;
begin:	lxi	h,0		;save system stackpointer
	dad	sp
	shld	spsave
	lxi	sp,stack	;load local stack
	call	ilprnt		;sign on
	db	'MLOAD v2.5  Copyright '
	db 127
	db	' 1983,1984,1985'
	db	cr,lf
	db	'by NightOwl Software, Inc.'
	db	cr,lf,0
	call	setup		;initialize
main:	call	nxtfil		;parse and read next input file
	jc	done		;no more...
	call	lodfil		;yep, load it
	call	closfl		;close it (in case MP/M or TurboDOS)
	jmp	main		;maybe more
done:	call	wrtfil		;write the output file
;
; exit to cp/m
;
exit:
jp warmbt
;	lxi	d,tbuf		;restore dma address
;	mvi	c,sdmaf
;	call	bdos
;	lda	system+2	;get top of memory pointer
;	sui	9		;allow for ccp+slop
;	lxi	h,hiload+1	;highest load address
;	sub	m		;above ccp?
;	jc	warmbt		;then warm-boot
;	lhld	spsave		;nope, ccp still in memory
;	sphl			;restore its stack
;	ret			;return to ccp
;
; load program initialization
;
setup:	lxi	h,varset	;initialize variables
	lxi	d,vars
	mvi	b,varlen	;by moving in default values
	call	move
	lhld	cmdptr		;get first free mem pointer
	xchg			;in de
	lxi	h,tbuf		;point to command tail bufr
	mov	a,m		;get its length
	inx	h
	ora	a		;does it have any length?
	jz	help		;nope, go give usage help
	mov	b,a		;yep, get length to b
	call	move		;move cmd tail to buffer
	xchg			;end of dest to hl
	mvi	m,0		;stuff a terminator
	inx	h		;point to first free memory
	shld	filbuf		;set up file buffer
	xchg			;file bufr adrs to de
	lhld	system+1	;get top of memory pointer
	xra	a		;round system to page boundary
	sub	e
	mov	c,a		;with result in bc
	mov	a,h
	sui	9		;allow for ccp
	sbb	d
	mov	b,a
	xchg			;buffer pointer to hl
nitmem:	mvi	m,0		;clear buffer
	inx	h
	dcx	b
	mov	a,b
	ora	c
	jnz	nitmem
;
; look for a bias specification in command line
;
	lhld	cmdptr		;point to command buffer-1
	dcx	h
	call	scanbk		;scan past blanks
	ora	a		;no non-blank chars?
	jz	help		;then go print help text
fndspc:	inx	h		;point to next
	mov	a,m		;fetch it
	ora	a		;test it
	rz			;line ended, return
	cpi	' '		;nope, test for blank
	jnz	fndspc		;not blank, continue
	call	scanbk		;skip blanks
	ora	a		;end-of-line?
	rz			;return if so
;
; hl points to bias in command line
;
	lxi	d,0		;init bias
	call	hexdig		;insure a hex digit
	jc	synerr		;bad...
hexlp:	mov	a,m		;no.  get next char
	inx	h		;skip over it
	call	hexdig		;test for hex digit
	jnc	digok		;jump if good hex digit
	ora	a		;must end on null terminator
	jnz	synerr
	xchg			;good end, get bias to hl
	shld	bias		;stuff it
	ret			;done
digok:	xchg			;bias to hl
	dad	h		;skift left 4 to make room
	dad	h		;   for new hex digit
	dad	h
	dad	h
	xchg			;back to de
	add	e		;add in new digit
	mov	e,a
	jnc	hexlp		;jump if no 8-bit ovfl
	inr	d		;carry
	jmp	hexlp
;
; parse next input name, and open resultant file
;
nxtfil:	lhld	cmdptr		;get command line pointer
next2:	lxi	d,dfcb		;destination fcb
	call	fparse		;parse a filename
	cpi	'='		;stopped on output specifier?
	jnz	noteq
	lda	outnam+2	;insure no name yet specified
	cpi	' '
	jnz	synerr		;syntax error if already named
	lda	outflg		;already been here?
	ora	a
	jnz	synerr		;can't be here twice
	inr	a		;flag that we've been here
	sta	outflg
	inr	b		;insure no ambiguous output name
	dcr	b
	jnz	afnerr
	inx	h		;skip over '='
	push	h		;save cmd line pointer
	lxi	h,dfcb-1	;move the name to output name hold
	lxi	d,outnam
	mvi	b,13		;drive spec too
	call	move
	pop	h		;restore command line pointer
	jmp	next2		;go parse another
noteq:	cpi	','		;stopped on comma?
	jz	gcomma		;jump if so
	mvi	m,0		;nope, insure end of input
	jmp	nxt2		;don't advance over fake end
gcomma:	inx	h		;skip over comma
nxt2:	shld	cmdptr		;save new command line pntr
	mov	a,b		;get ambig char count
	ora	a		;test it
	jnz	afnerr		;allow no ambig characters
	sta	bufptr		;force a disk read
	lxi	d,dfcb+1	;look at parsed filename
	ldax	d
	cpi	' '		;blank? (input ended?)
	stc			;get carry ready in case so
	rz			;return cy if input gone
	dcx	d		;nope, point de to start of fcb
open2:	push	d		;try to open the file
	mvi	c,openf
	call	bdos
	pop	d
	inr	a		;return=0ffh?
	jnz	openok		;jump if not
;
; file not found: if filetype blank, set to 'hex' and try again
;
	lxi	h,dfcb+ft	;point to file type
	mov	a,m		;anything there?
	cpi	' '
	jnz	fnferr		;yes, so file not found
	mvi	m,'H'		;nope, fill in 'hex'
	inx	h
	mvi	m,'E'
	inx	h
	mvi	m,'X'
	jmp	open2		;go try again
;
; here after a good file open
;
openok:	call	hexchk		;is this a hex file?
	rz			;if so, all done
	lxi	h,comflg	;no, get pointer to flag
	mov	a,m		;loading first file?
	ora	a
	rnz			;if not, ignore type, consider hex
	inr	m		;else, set the flag
	ret
;
; load current file
;
lodfil:	lxi	h,comflg	;loading a com file?
	mov	a,m		;get flag
	ani	1
	jnz	lodcom		;jump if so
	lhld	bias		;else get bias on top of stack
	push	h
;
; load a hex record
;
loadlp:	call	gnb		;get next file byte
	sbi	':'		;look for start-record mark
	jnz	loadlp		;scan until found
	sta	cksum		;got it, init checksum to zero
	mov	d,a		;upper byte of rec cnt=0
	pop	b		;retrieve bias adrs
	push	b		;save it again
	call	ghbcks		;get hex byte w/checksum
	mov	e,a		;de now has record length
	ora	a		;test it
	jnz	notend		;jump if len<>0 (not eof rec)
	pop	h		;all done
	ret
notend:	call	ghbcks		;hi byte of rec ld adrs
	mov	h,a		;accumulate in hl
	call	ghbcks		;get lo byte
	mov	l,a		;put lo in l
	lda	lodflg		;test load flag
	ora	a
	cz	lodnit		;not first record, initialize
	push	h		;save load address
	dad	d		;add in record length
	dcx	h		;make highest, not next
	lda	hipc		;a new high?
	sub	l
	lda	hipc+1
	sbb	h
	jnc	notgt		;jump if not
	shld	hipc		;yep, update hipc
	push	d		;save reclen
	xchg			;load adrs to de
	lhld	offset		;get offset to form true memory adrs
	dad	d		;add in offset
	dad	b		;and bias
	shld	hiload		;mark highest true memory load adrs
	lda	warmbt+2	;validate against top-mem pointer
	cmp	h
	jc	memful		;jump if out of memory
	pop	d		;restore reclen
notgt:	pop	h		;restore load address
	dad	b		;add bias to load adrs
	push	d		;save record length
	push	h
	lhld	bytcnt		;add record length to byte count
	dad	d
	shld	bytcnt
	pop	h
	xchg
	lhld	offset		;calculate true memory adrs
	dad	d		;hl=true loading adrs
	pop	d		;restore record length
	call	ghbcks		;skip unused byte of intel format
;
; move the record into memory
;
reclp:	call	ghbcks		;get hex byte
	mov	m,a		;store it in buffer
	inx	h		;point to next
	dcr	e		;count down
	jnz	reclp		;until record all read
	call	ghbcks		;get checksum byte
	jnz	cserr		;final add cksum should sum 0
	jmp	loadlp		;good load, go do nxt record
;
; get next hex byte from input, and
; accumulate a checksum
;
ghbcks:	push	b		;save em all
	push	h
	push	d
	call	hexin		;get hex byte
	mov	b,a		;save in b
	lxi	h,cksum		;add to checksum
	mov	a,m
	add	b
	mov	m,a
	mov	a,b		;get byte back
	pop	d		;restore checksum
	pop	h		;restore other regs
	pop	b
	ret
;
; routine to get next byte from input...forms
; byte from two ascii hex characters
;
hexin:	call	gnb		;get next input file byte
	call	hexval		;convert to binary w/validation
	rlc			;move into ms nybble
	rlc
	rlc
	rlc
	ani	0f0h		;kill possible garbage
	push	psw		;save it
	call	gnb		;get next byte
	call	hexval		;convert it, w/validation
	pop	b		;get back first
	ora	b		;or in second
	ret			;good byte in a
;
; gnb - utility subroutine to get next
;	byte from disk file
gnb:	push	h		;save all regs
	push	d
	push	b
	lda	bufptr		;get input bufr pointer
	ani	7fh		;wound back to 0?
	jz	diskrd		;go read sector if so
gnb1:	mvi	d,0		;else form 16 bit offset
	mov	e,a
	lxi	h,tbuf		;from tbuf
	dad	d		;add in offset
	mov	a,m		;get next byte
	cpi	eof		;end of file?
	jz	eoferr		;error if so
	lxi	h,bufptr	;else bump buf ptr
	inr	m
	ora	a		;return carry clear
	pop	b		;restore and return
	pop	d
	pop	h
	ret
;
; read next sector from disk
;
diskrd:	mvi	c,readf		;bdos "READ SEC" function
	lxi	d,dfcb
	call	bdos		;read sector
	ora	a
	jnz	eoferr		;error if phys end of file
	sta	bufptr		;store 0 as new buf ptr
	jmp	gnb1		;go re-join gnb code
;
; load a com file
;
lodcom:	inr	m		;bump the comfile flag
	lxi	h,tpa		;set origin
	call	lodnit		;and initialize
	xchg			;load address in de
	lhld	bias		;add in bias
	dad	d
	xchg
	lhld	offset		;and offset
	dad	d
	xchg			;de has absolute mem adrs of load
;
comlp:	lxi	h,128		;calculate next dma
	dad	d
	lda	warmbt+2	;check for space
	cmp	h
	jc	memful		;jump if none
	push	h		;else save next dma
	push	d		;and this dma
	mvi	c,sdmaf		;set this dma
	call	bdos
	lxi	d,dfcb		;read next record
	mvi	c,readf
	call	bdos
	pop	h		;recall this dma
	pop	d		;de=next dma
	ora	a		;end of read?
	jnz	lodend		;jump if so
	lhld	comsiz		;no, advance com byte count
	lxi	b,128
	dad	b
	shld	comsiz
	jmp	comlp		;continue
;
lodend:	dcx	h		;one less byte is highest
	shld	hiload		;set a new high
	lhld	comsiz		;hi pc=bytecount+100h
	lxi	d,tpa
	dad	d
	xchg			;to de
	lhld	bias		;add in bias
	dad	d
	shld	hipc
	lxi	d,tbuf		;reset dma for hex files
	mvi	c,sdmaf
	call	bdos
	ret
;
; write output file
;
wrtfil:	lxi	d,dfcb		;point to fcb
	push	d		;save 2 copies of pointer
	push	d
	call	nitfcb		;initialize output fcb
	lxi	h,outnam	;move output name in
	dcx	d		;point to user # (prior to fcb)
	mvi	b,10		;move user, drive, primary name
	call	move
	mov	a,m		;output type blank?
	cpi	' '
	jnz	wrtnb		;jump if not
	lxi	h,outtyp	;yes, move dflt output filetype in
wrtnb:	mvi	b,3
	call	move
	pop	d		;restore fcb pointer
	mvi	c,erasef	;erase any existing file
	call	bdos
	pop	d		;restore fcb pointer
	mvi	c,creatf	;create a new file
	call	bdos
	inr	a		;good create?
	jz	dirful		;goto directory full error if not
	lhld	hiload		;yep, get top of bufr pntr
	xchg			;in de
	lhld	filbuf		;get start of bufr adrs
	mov	a,e		;calculate output file size
	sub	l
	mov	c,a		;with result in bc
	mov	a,d
	sbb	h
	mov	b,a
	mov	a,b		;test length
	ora	c
	jz	loderr		;nothing to write???
	lxi	d,dfcb		;get fcb pointer
wrlp:	push	b		;save count
	push	d		;and fcb pointer
	xchg			;get memory pointer to de
	lxi	h,128		;add in sector length for next pass
	dad	d
	xthl			;save next dma
	push	h		;above fcb
	mvi	c,sdmaf		;set transfer address
	call	bdos
	pop	d		;fetch fcb pointer
	push	d		;save it again
	mvi	c,writef	;write a sector
	call	bdos
	ora	a		;test result
	jnz	dskful		;disk full error...
	lhld	reccnt		;no,increment count of records
	inx	h
	shld	reccnt
	pop	d		;restore fcb pointer
	pop	h		;and memory write pointer
	pop	b		;and count
	mov	a,c		;subtract 128 (sec size) from count
	sui	128
	mov	c,a
	jnc	wrlp		;jump if some left
	mov	a,b		;hi-order borrow
	sui	1		;do it (can't "DCR B", doesn't affect cy)
	mov	b,a		;restore
	jnc	wrlp		;jump if more left
	call	closfl		;close output file
;
; report statistics to console
;
	call	ilprnt
	db	'Loaded ',0
	lhld	bytcnt		;print # bytes
	call	decout
	call	ilprnt
	db	' bytes (',0
	call	hexout
	call	ilprnt
	db	'H)',0
	call	ilprnt
	db	' to file %',0
	lda	comflg		;did we load a comfile too?
	ora	a
	jz	notcom		;jump if not
	call	ilprnt
	db	cr,lf,'Over a ',0
	lhld	comsiz
	call	decout
	call	ilprnt
	db	' byte binary file',0
notcom:	call	ilprnt
	db	cr,lf,'Start address: ',0
	lhld	lodadr		;print loading address
	call	hexout
	call	ilprnt
	db	'H  End address: ',0
	lhld	hipc		;print ending load address
	call	hexout
	call	ilprnt
	db	'H  Bias: ',0
	lhld	bias
	call	hexout
	call	ilprnt
	db	'H',cr,lf,0
	call	ilprnt
	db	'Saved filesize:',0
	lhld	reccnt		;get count of image records
	push	h		;save it
	mvi	b,7		;convert to bytes
xlp:	dad	h
	dcr	b
	jnz	xlp
	call	decout		;print it
	call	ilprnt
	db	' bytes'
	db cr,lf
	db	'(',0
	call	hexout		;now in hex
	call	ilprnt
	db	'H, - ',0
	pop	h		;recall record count
	call	decout		;print it
	call	ilprnt
	db	' records)',cr,lf,0
	lhld	lodadr		;fetch loading address
	mov	a,l		;test if =tpa
	ora	a
	jnz	nottpa		;tpa always on page boundary
	mov	a,h		;lo ok, test hi
	cpi	(tpa shr 8) and	0ffh
	rz			;return if tpa
nottpa:	call	ilprnt		;not, so print warning msg
	db	cr,lf,bel
	db	'++ Warning: program origin NOT at 6100H ++'
	db	cr,lf,0
	ret			;done
;
;	***********************
;	* utility subroutines *
;	***********************
;
;
; routine to close any open file
;
closfl:	lxi	d,dfcb
	mvi	c,closef
	call	bdos
	inr	a		;test close result
	jz	clserr		;jump if error
	ret
;
; print message in-line with code
;
ilprnt:	xthl			;message pntr to hl
	call	prathl		;print it
	xthl			;restore and return
	ret
;
; print msg pointed to by hl until null.  expand
; '%' char to current filename.
;
prathl:	mov	a,m		;fetch char
	inx	h		;point to next
	ora	a		;terminator?
	rz			;then done
	cpi	'%'		;want filename?
	jz	prtfn		;go do it if so
	call	type		;nope, just print char
	jmp	prathl		;continue
;
prtfn:	push	h		;save pointer
	push	b
	lda	dfcb		;fetch dr field of dfcb
	ora	a		;default drive?
	jnz	prndf		;jump if not
	call	getdsk		;get logged-in drive #
	inr	a		;make it one-relative (as in fcb)
prndf:	adi	'A'-1		;make drive name printable
	call	type		;print it
	lda	dfcb-1		;get user #
	cpi	0ffh		;null?
	cz	getusr		;iff so, get current user
	mov	l,a		;to hl
	mvi	h,0
	call	decout		;print it
	mvi	a,':'		;drive names followed by colon
	call	type
	lxi	h,dfcb+1	;setup for name
	mvi	b,8		;print up to 8
	call	prtnam
	mvi	a,'.'		;print dot
	call	type
	mvi	b,3		;print filetype field
	call	prtnam
	pop	b
	pop	h		;restore and continue
	jmp	prathl
;
; print file name .HL max length in b.	don't print spaces
;
prtnam:	mov	a,m		;fetch a char
	cpi	' '		;blank?
	jz	pwind		;go wind if so
	inx	h		;nope, move to next
	call	type		;print it
	dcr	b		;count down
	jnz	prtnam		;continue
	ret
pwind:	inx	h		;skip remainder of blank name
	dcr	b
	jnz	pwind
	ret
;
; print HL in decimal on console
;
decout:	push	h		;save everybody
	push	d
	push	b
	lxi	b,-10		;conversion radix
	lxi	d,-1
declp:	dad	b
	inx	d
	jc	declp
	lxi	b,10
	dad	b
	xchg
	mov	a,h
	ora	l
	cnz	decout		;this is recursive
	mov	a,e
	adi	'0'
	call	type
	pop	b
	pop	d
	pop	h
	ret
;
; newline on console
;
crlf:	mvi	a,cr
	call	type
	mvi	a,lf
	jmp	type
;
; print hl on console in hex
;
hexout:	mov	a,h		;get hi
	call	hexbyt		;print it
	mov	a,l		;get lo, fall into hexbyt
;
; type accumulator on console in hex
;
hexbyt:	push	psw		;save byte
	rar			;get ms nybble..
	rar			;..into lo 4 bits
	rar
	rar
	call	nybble
	pop	psw		;get back byte
nybble:	ani	0fh		;mask ms nybble
	adi	90h		;add offset
	daa			;decimal adjust a-reg
	aci	40h		;add offset
	daa			;fall into type
;
; type char in a on console
;
type:	push	h		;save all
	push	d
	push	b
	mov	e,a		;cp/m outputs from e
	mvi	c,pcharf
	call	bdos
	pop	b
	pop	d
	pop	h
	ret
;
; move: from @hl to @de, count in b
;
move:	inr	b		;up one
movlp:	dcr	b		;count down
	rz			;return if done
	mov	a,m		;not done, continue
	stax	d
	inx	h		;pointers=pointers+1
	inx	d
	jmp	movlp
;
; scan to first non-blank char in string @hl
;
scanbk:	inx	h		;next
	mov	a,m		;fetch it
	cpi	' '
	jz	scanbk
	ret
;
; get hex digit and validate
;
hexval:	call	hexdig		;get hex digit
	jc	formerr		;jump if bad
	ret
;
; get hex digit, return cy=1 if bad digit
;
hexdig:	cpi	'0'		;lo boundary test
	rc			;bad already?
	cpi	'9'+1		;no, test hi
	jc	hexcvt		;jump if numeric
	cpi	'A'		;test alpha
	rc			;bad?
	cpi	'F'+1		;no, upper alpha bound
	cmc			;pervert carry
	rc			;bad?
	sui	7		;no, adjust to 0-f
hexcvt:	ani	0fh		;make it binary
	ret
;
;	******************
;	* error handlers *
;	******************
;
synerr:	call	crlf
	call	ilprnt
	db	'      Command line syntax error',cr,lf,cr,lf,0
	jmp	help		;give help msg too
;
afnerr:	call	errxit		;exit with message
	db	'Ambiguous file name: % not allowed.',0
;
fnferr:	call	errxit
	db	'File % not found.',0
;
dskful:	call	errxit
	db	'Disk full.',0
;
dirful:	call	errxit
	db	'Directory full.',0
;
eoferr:	call	errxit
	db	'Premature end-of-file in %',0
;
cserr:	call	errxit
	db	'Checksum error in %',0
;
clserr:	call	errxit
	db	'Can''t close %',0
;
memful:	call	errxit
	db	'Memory full while loading %',0
;
formerr:call	errxit
	db	'Format error in file %',0
;
loderr:	call	errxit
	db	'Writing %, nothing loaded',0
;
help:	call	errxit		;print help text
	db	'MLOAD syntax:',cr,lf,cr,lf
	db	'MLOAD [<OUTF>=] <FIL1>[,<F2>...] [<BIAS>]',cr,lf
	db	tab,'    (brackets denote optional items)',cr,lf,cr,lf
	db	tab,'<OUTF> is the optional output filename',cr,lf
	db	tab,'<FILn> are input file(s)',cr,lf
	db	tab,'<BIAS> is a hex load offset on outp. file'
	db	cr,lf,cr,lf
	db	tab,'<FIL1> may be an optional non-HEX file to be patched '
	db	'by subsequently named HEXfiles (specifying '
	db	'the filetype enables this     function).'
	db	cr,lf,cr,lf
	db	'ZCPR2-style is allowed '
	db	'("B3:MYFILE.CM6,         "A14:MDM7.HEX").'
	db	0
;
; general error handler
;
errxit:	call	crlf		;new line
	pop	h		;fetch error msg pointer
	call	prathl		;print it
	call	crlf
	jmp	exit		;done
;
; initialize load parameters
;
lodnit:	mvi	a,1		;first record, set load flag
	sta	lodflg
	shld	lodadr		;save load address
	shld	hipc		;and hi load
	push	d		;save record length
	xchg			;de=load address
	lhld	filbuf		;get address of file buffer
	mov	a,l		;subtract load adrs from file buffer
	sub	e
	mov	l,a
	mov	a,h
	sbb	d
	mov	h,a
	shld	offset		;save as load offset
	push	d		;save load address on stack
	push	b		;save bias
	lxi	d,outnam+2	;check output filename
	ldax	d		;(first char)
	cpi	' '
	jnz	namskp		;jump if so
	lxi	h,dfcb+1	;get first name pointer
	mvi	b,8		;(don't include drive spec)
	call	move
;
; check for outflg=1 (presence of an "=").  note that the
; filename may well be blank, and yet outflg <>0, for example
; in the case of "A:=<FILENAME>" or "C4:=<FILENAME>". in
; this case, we want to remember the drive/user specified, but
; use the first input file to form the output name. otherwise,
; we use the current drive/user.
;
	lda	outflg		;was there an "="?
	ora	a
	jnz	namskp		;jump if so
	lxi	h,outnam	;get destination pointer
	call	getusr		;get current user #
	mov	m,a
	inx	h		;point to drive
	call	getdsk		;get it
	inr	a		;fcb's drive is 1-relative
	mov	m,a
namskp:	mvi	a,1		;insure "=" cannot occur anymore
	sta	outflg
	pop	b		;restore bias
	pop	h		;load address to hl
	pop	d		;restore record length
	ret
;
;	*********************************
;	* file name parsing subroutines *
;	*********************************
;
; credit where credit's due:
; --------------------------
; these routines were lifted from bob van valzah's
; "FAST" program.
;
;
;
;	*********************************
;	* file name parsing subroutines *
;	*********************************
;
;
; getfn gets a file name from text pointed to by reg hl into
; an fcb pointed to by reg de.	leading delimeters are
; ignored. allows drive spec of the form <du:> (drive/user).
; this routine formats all 33 bytes of the fcb (but not ran rec).
;
; entry de	first byte of fcb
; exit b=# of '?' in name
; fcb-1= user # parsed (if specified) or 255
;
;
fparse:	call	nitfcb		;init 1st half of fcb
	call	gstart		;scan to first character of name
	call	getdrv		;get drive/user spec. if present
	mov	a,b		;get user # or 255
	cpi	0ffh		;255?
	jz	fpars1		;jump if so
	dcx	d		;back up to byte preceeding fcb
	dcx	d
	stax	d		;stuff user #
	inx	d		;onward
	inx	d
fpars1:	call	getps		;get primary and secondary name
	ret
;
; nitfcb fills the fcb with dflt info - 0 in drive field
; all-blank in name field, and 0 in ex,s1,s2,rc, disk
; allocation map, and random record # fields
;
nitfcb:	push	h
	push	d
	call	getusr		;init user field
	pop	d
	pop	h
	push	d		;save fcb loc
	dcx	d
	stax	d		;init user # to currnt user #
	inx	d
	xchg			;move it to hl
	mvi	m,0		;drive=default
	inx	h		;bump to name field
	mvi	b,11		;zap all of name fld
nitlp:	mvi	m,' '
	inx	h
	dcr	b
	jnz	nitlp
	mvi	b,33-11		;zero others, up to nr field
zlp:	mvi	m,0
	inx	h
	dcr	b
	jnz	zlp
	xchg			;restore hl
	pop	d		;restore fcb pointer
	ret
;
; gstart advances the text pointer (reg hl) to the first
; non delimiter character (i.e. ignores blanks).  returns a
; flag if end of line (00h or ';') is found while scaning.
; exit	hl	pointing to first non delimiter
;	a	clobbered
;	zero	set if end of line was found
;
gstart:	call	getch		;see if pointing to delim?
	rnz			;nope - return
	ora	a		;physical end?
	rz			;yes - return w/flag
	inx	h		;nope - move over it
	jmp	gstart		;and try next char
;
; getdrv checks for the presence of a du: spec at the text
; pointer, and if present formats drive into fcb and returns
; user # in b.
;
; entry hl	text pointer
;	de	pointer to first byte of fcb
; exit	hl	possibly updated text pointer
;	de	pointer to second (primary name) byte of fcb
;	b	user # if specified or 0ffh
;
getdrv:	mvi	b,0ffh		;default no user #
	push	h		;save text pointer
dscan:	call	getch		;get next char
	inx	h		;skip pointer over it
	jnz	dscan		;scan until delimiter
	cpi	':'		;delimiter a colon?
	inx	d		;skip dr field in fcb in case not
	pop	h		;and restore text pointer
	rnz			;return if no du: spec
	mov	a,m		;got one, get first char
	call	cvtuc		;may be drive name, cvt to upper case
	cpi	'A'		;alpha?
	jc	isnum		;jump to get user # if not
	sui	'A'-1		;yes, convert from ascii to #
	dcx	d		;back up fcb pointer to dr field
	stax	d		;store drive # into fcb
	inx	d		;pass pointer over drv
	inx	h		;skip drive spec in text
isnum:	mov	a,m		;fetch next
	inx	h
	cpi	':'		;du delimiter?
	rz			;done then
	dcx	h		;nope, back up text pointer
	mvi	b,0		;got a digit, init user value
uloop:	mov	a,b		;get accumulated user #
	add	a		;* 10 for new digit
	add	a
	add	b
	add	a
	mov	b,a		;back to b
	mov	a,m		;get text char
	sui	'0'		;make binary
	add	b		;add to user #
	mov	b,a		;updated user #
	inx	h		;skip over it
	mov	a,m		;get next
	cpi	':'		;end of spec?
	jnz	uloop		;jump if not
	inx	h		;yep, return txt pointer past du:
	ret
;
; getps gets the primary and secondary names into the fcb.
; entry hl	text pointer
; exit	hl	character following secondary name (if present)
;
getps:	mvi	c,8		;max length of primary name
	mvi	b,0		;init count of '?'
	call	getnam		;pack primary name into fcb
	mov	a,m		;see if terminated by a period
	cpi	'.'
	rnz			;nope - secondary name not given
				;return default (blanks)
	inx	h		;yup - move text pointer over period
ftpoint:mov	a,c		;yup - update fcb pointer to secondary
	ora	a
	jz	getft
	inx	d
	dcr	c
	jmp	ftpoint
getft:	mvi	c,3		;max length of secondary name
	call	getnam		;pack secondary name into fcb
	ret
;
; getnam copies a name from the text pointer into the fcb for
; a given maximum length or until a delimiter is found, which
; ever occurs first.  if more than the maximum number of
; characters is present, character are ignored until a
; a delimiter is found.
; entry hl	first character of name to be scanned
;	de	pointer into fcb name field
;	c	maximum length
; exit	hl	pointing to terminating delimiter
;	de	next empty byte in fcb name field
;	c	max length - number of characters transfered
;
getnam:	call	getch		;are we pointing to a delimiter yet?
	rz			;if so, name is transfered
	inx	h		;if not, move over character
	cpi	'*'		;ambigious file reference?
	jz	ambig		;if so, fill the rest of field with '?'
	cpi	'?'		;afn reference?
	jnz	notqm		;skip if not
	inr	b		;else bump afn count
notqm:	call	cvtuc		;if not, convert to upper case
	stax	d		;and copy into name field
	inx	d		;increment name field pointer
	dcr	c		;if name field full?
	jnz	getnam		;nope - keep filling
	jmp	getdel		;yup - ignore until delimiter
ambig:	mvi	a,'?'		;fill character for wild card match
fillq:	stax	d		;fill until field is full
	inx	d
	inr	b		;increment count of '?'
	dcr	c
	jnz	fillq		;fall thru to ingore rest of name
getdel:	call	getch		;pointing to a delimiter?
	rz			;yup - all done
	inx	h		;nope - ignore antoher one
	jmp	getdel
;
; getch gets the character pointed to by the text pointer
; and sets the zero flag if it is a delimiter.
; entry hl	text pointer
; exit	hl	preserved
;	a	character at text pointer
;	z	set if a delimiter
;
getch:	mov	a,m		;get the character, test for delim
;
; global entry: test char in a for filename delimiter
;
fndelm:	cpi	'/'
	rz
	cpi	'.'
	rz
	cpi	','
	rz
	cpi	' '
	rz
	cpi	':'
	rz
	cpi	'='
	rz
	ora	a		;set zero flag on end of text
	ret
;
; bdos entry: preserves bc, de.  if system call is a file
;	      function, this routine logs into the drive/
;	      user area specified, then logs back after
;	      the call.
;
bdos:	call	filfck		;check for a file function
	jnz	bdos1		;jump if not a file function
	call	getdu		;get drive/user
	shld	savedu
	ldax	d		;get fcb's drive
	sta	fcbdrv		;save it
	dcr	a		;make 0-relative
	jm	bdos0		;if not default drive, jump
	mov	h,a		;copy to h
bdos0:	xra	a		;set fcb to default
	stax	d
	dcx	d		;get fcb's user #
	ldax	d
	mov	l,a
	inx	d		;restore de
	call	setdu		;set fcb's user
;
; note that unspecified user # (value=0ffh) becomes
; a getusr call, preventing ambiguity.
;
	call	bdos1		;do user's system call
	push	psw		;save result
	push	h
	lda	fcbdrv		;restore fcb's drive
	stax	d
	lhld	savedu		;restore prior drive/user
	call	setdu
	pop	h		;restore bdos result registers
	pop	psw
	ret
;
; local variables for bdos replacement routine
;
savedu:	dw	0		;saved drive,user
fcbdrv:	db	0		;fcb's drive
dmadr:	dw	80h		;current dma adrs
;
bdos1:	push	d
	push	b
	mov	a,c		;doing setdma?
	cpi	sdmaf
	jnz	bdos1a		;jump if not
	xchg			;yep, keep a record of dma addresses
	shld	dmadr
	xchg
bdos1a:	call	system
	pop	b
	pop	d
	ret
;
; get drive, user: h=drv, l=user
;
getdu:	push	b		;don't modify bc
	push	d
	mvi	c,gsuser	;get user #
	mvi	e,0ffh
	call	bdos1
	push	psw		;save it
	mvi	c,getdrf	;get drive
	call	bdos1
	mov	h,a		;drive returned in h
	pop	psw
	mov	l,a		;user in l
	pop	d
	pop	b		;restore caller's bc
	ret
;
; set drive, user: h=drv, l=user
;
setdu:	push	b		;don't modify bc
	push	d
	push	h		;save info
	mov	e,h		;drive to e
	mvi	c,seldf		;set it
	call	bdos1
	pop	h		;recall info
	push	h
	mov	e,l		;user # to e
	mvi	c,gsuser
	call	bdos1		;set it
	pop	h
	pop	d
	pop	b
	ret
;
; check for file-function: open, close, read random, write
;	random, read sequential, write sequential.
;
filfck:	mov	a,c		;get function #
	cpi	openf
	rz
	rc			;ignore lower function #'s
	cpi	closef		;(they're not file-related)
	rz
	cpi	readf
	rz
	cpi	writef
	rz
	cpi	rrand
	rz
	cpi	wrand
	rz
	cpi	fsrchf
	rz
	cpi	fsrchn
	rz
	cpi	erasef
	rz
	cpi	creatf
	rz
	cpi	filszf
	rz
	cpi	srand
	ret
;
; convert char to upper case
;
cvtuc:	cpi	'a'		;check lo bound
	rc
	cpi	'z'+1		;check hi
	rnc
	sui	20h		;convert
	ret
;
; check for hex filetype in fcb name
;
hexchk:	push	h
	push	d
	push	b
	mvi	b,3		;type is 3 chars
	lxi	d,dfcb+9	;point de to type field
	lxi	h,hextyp	;point hl to "COM"
hexlop:	ldax	d
	ani	7fh		;ignore attributes
	cmp	m
	inx	h
	inx	d
	jnz	hexit		;jump if not com
	dcr	b
	jnz	hexlop
hexit:	pop	b		;z reg has result
	pop	d
	pop	h
	ret
;
hextyp:	db	'HEX'
;
; routine to return user # without disturbing registers
;
getusr:	push	h
	push	d
	push	b
	mvi	c,gsuser
	mvi	e,0ffh
	call	bdos
	pop	b
	pop	d
	pop	h
	ret
;
; routine to return drive # without disturbing registers
;
getdsk:	push	h
	push	d
	push	b
	mvi	c,getdrf
	call	bdos
	pop	b
	pop	d
	pop	h
	ret
;
; these are the initial values of the variables, and
; are moved into the variables area by the setup routine.
; if you add variables, be sure to add their intial value
; into this table in the order corresponding to their
; occurance in the variables section.
;
varset:	dw	0			;bias
	dw	0			;hiload
	dw	0			;hipc
	db	0			;cksum
	dw	cmdbuf			;cmdptr
	db	0			;bufptr
	db	0			;lodflg
	dw	cmdbuf			;filbuf
	dw	0			;offset
	dw	0			;lodadr
	db	0,0,'           '	;outnam
	dw	0			;reccnt
	dw	0			;bytcnt
	db	0			;comflg
	dw	0			;comsiz
	db	0			;outflg
;
varlen	equ	$-varset	;define length of init table
;
; working variables
;
vars	equ	$		;define variables area start
;
bias:	ds	2		;load offset
hiload:	ds	2		;highest true load address
hipc:	ds	2		;highest pc
cksum:	ds	1		;record checksum
cmdptr:	ds	2		;command line pointer
bufptr:	ds	1		;input buffer pointer
lodflg:	ds	1		;something-loaded flag
filbuf:	ds	2		;file buffer location
offset:	ds	2		;load offset into buffer
lodadr:	ds	2		;load address
outnam:	ds	13		;output drive+name
reccnt:	ds	2		;output file record count
bytcnt:	ds	2		;output file bytes loaded  count
comflg:	ds	1		;flags com file encountered
comsiz:	ds	2		;size of a loaded com file
outflg:	ds	1		;flags an "=" present in cmd line
;
; end of working variables
;
;
;
; stack stuff
;
spsave:	ds	2		;system stack pntr save
;
;
	ds	100		;50-level stack
;
stack	equ	$
cmdbuf	equ	$		;command buffer location
;
;
	end
