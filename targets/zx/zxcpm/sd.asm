
; z88dk-z80asm -b sd.asm
; ren sd.bin sd.cm6


;		    SD.ASM ver 2.2
;		   (revised 6/5/81)
;
;		SUPER DIRECTORY PROGRAM
;		  by Bruce R. Ratoff
;
;Displays the directory of a CP/M disk, sorted alphabetically,
;with the file size in K, rounded to the nearest CP/M block size.
;
;This latest variation on a common theme will automatically adjust
;itself for any block size and directory length under CP/M 1.4 or 2.x
;or MP/M (any version).  If the screen fills, program will pause until
;a key is struck (see NPL and LPS equates below).  Total space used
;and number of files are printed at end.
;
;Command: SD FILENAME.FILETYPE or just SD
;
;Allows '*' or '?' type specifications.  Drive name may also be
;specified.  Ignores "SYS" files unless SOPT is TRUE and 'S' option
;is given (i.e., SD *.* S will print all files).
;
;==============================================================
;
;Fixes/updates (in reverse order to minimize reading time):
;
;06/05/81 Added PGPAWZ (page pause) conditional for remote
;	  CP/M systems where pausing may not be wanted.
;	  Setting PGPAWZ and REPSIZ to FALSE will result in
;	  a display like DIR, but sorted and with the stat
;	  of space remaining.  Rearranged equates to allow
;	  15 lines per page when narrow display is chosen.
;	  (KBP)
;
;06/01/81 Added version number, restored CTL-C break, added
;	  CTL-C test to allow break at page pause, added
;	  routine to gobble up any waiting console character
;	  at EXIT, added conditional assembly to allow no
;	  report of file sizes, added conditional assembly
;	  for direct console I/O for remote CP/M systems
;	  where phone line noise would garbage display.  (KBP)
;
;05/06/81 Corrected double printing of drive name in CALLB.
;	  Error only occurred with narrow display when file
;	  wasn't found. (Tim Nicholas)
;
;02/06/81 Changed sort to have odd gap (K+P say its faster)
;
;01/06/80 Changed sort from bubble sort to shell sort
;	  for faster speed.
;
;12/24/80 Changed BIOS conout to BDOS conout to allow
;	  printing of directory with CTL-P.  Also added
;	  print of remaining space even if file not
;	  found. (Steve Nossen)
;
;12/15/80 Added space suppression when printing file
;	  totals.  (KBP)
;
;12/14/80 Added logic to print space remaining on disk.
;	  Changed ^C test so that interrupting character is
;	  not echoed (makes remote use cleaner).  (BRR)
;
;12/02/80 Fixed bug in print routine which compared last file
;	  against garbage before printing. (BRR)
;
;11/29/80 Changed to allow printing 4 file names. (Ben Bronson
;	  and Keith Petersen)
;
;11/22/80 Fixed bug in handling >256 files.  Changed abort test
;	  in print routine to only abort on control-c.  (BRR)
;
;Based on 'DIRS' by Keith Petersen, W8SDZ
;
;NOTE: If you add improvements or otherwise update
;this program, please modem a copy of the new file
;to "TECHNICAL CBBS" in Dearborn, Michigan - phone
;313-846-6127 (110, 300, 450 or 600 baud).  Use the
;filename SD-NEW.NEW. (KBP)
;
;Set 'RMAC' TRUE to assemble with relocating assembler
;(requires link with PAGE 0 equates in separate file).
;
;==============================================================
;
; Converted from 8080 syntax to Z80 op-codes
; by John Squires 10 Jan 2021 for the Z80 Playground.
; See https://8bitStack.co.uk
;
defc FALSE 	=	0		    ;DEFINE LOGICAL FALSE
defc TRUE 	=	! FALSE	;DEFINE LOGICAL TRUE
;
defc ALTCPM 	=	TRUE		;PUT TRUE HERE FOR H8 OR TRS-80
defc RMAC 	=	FALSE		;PUT TRUE HERE FOR ASSEMBLY BY RMAC
defc SOPT 	=	TRUE		;PUT TRUE TO ALLOW 'SD *.* S' FORM
defc WIDE 	=	FALSE		;PUT TRUE TO ALLOW 4 NAMES ACROSS
defc REPSIZ 	=	TRUE		;PUT TRUE TO REPORT FILE SIZES
defc PGPAWZ 	=	TRUE		;PUT TRUE FOR PAUSE AFTER EACH PAGE
defc DIRCON 	=	FALSE		;PUT TRUE FOR DIRECT CONSOLE OUTPUT
;
defc DELIM 	=	' '		;FENCE (DELIMITER) CHARACTER
;
	IF	WIDE
defc NPL 	=	4		;NUMBER OF NAMES PER LINE
defc LPS 	=	23		;NUMBER OF LINES PER SCREEN
	ENDIF	
;
	IF	! WIDE
defc NPL 	=	2		;NUMBER OF NAMES PER LINE
defc LPS 	=	15		;NUMBER OF LINES PER SCREEN
	ENDIF	
;
	IF	ALTCPM
defc BASE 	=	6000H
defc TPA 	=	6100H
	ENDIF	
;
	IF	RMAC
	EXTRN	BASE,FCB,BDOS	;MAKE BASE EXTERNAL
	ENDIF	
;
	IF	(! ALTCPM) && (! RMAC)
defc BASE 	=	0		;WILL DEFAULT TO 0 (OR 100H WITH MAC +R OPTION)
defc TPA 	=	100H
	ENDIF	
;
	IF	! RMAC
defc FCB 	=	BASE+5CH
defc BDOS 	=	BASE+5
	ENDIF	
;
	IF	! RMAC
	ORG	TPA
	ENDIF	
;
START:	LD	HL,0
	ADD	HL,SP		;HL=OLD STACK
	LD	(STACK),HL	;SAVE IT
	LD	SP,STACK	;GET NEW STACK
;
	IF	SOPT
	LD	A,(FCB+17)	;SAVE S OPTION FLAG
	LD	(SOPFLG),A	;(BLANK OR LETTER S)
	ENDIF	
;
	SUB	A
	LD	(USERNO),A	;DEFAULT TO USER 0
	LD	(LINCNT),A	;CLEAR COUNT OF LINES ON SCREEN
	LD	C,12
	CALL	BDOS	;CHECK CP/M VERSION
	LD	(VERFLG),HL	;LO ORD >0 IF 2.x, HI ORD>0 IF MP/M

	; push hl

	; ld de, VERFLG_message
	; ld c, PRINT
	; call BDOS
	; ld a, (VERFLG)
	; call show_a_as_hex
	; call newline

	; pop hl

	LD	A,L			;2.x?
	OR	A
	JP	Z,CHKDRV	;SKIP USER NUMBER STUFF IF 1.4
	LD	E,0FFH
	LD	C,CURUSR	;INTERROGATE USER NUMBER
	CALL	BDOS
	LD	(USERNO),A
	LD	A,(MPMFLG)	;MP/M?
	OR	A			;IF SO, TYPE HEADING LINE
	JP	Z,CHKDRV	; ELSE SKIP IT
	LD	DE,USRMSG	;DISPLAY IT
	LD	C,PRINT
	CALL	BDOS		;FIRST PART OF MESSAGE
	LD	A,(USERNO)
	CP	10		;IF USER NO. > 9 PRINT LEADING 1
	JP	C,DUX
	LD	A,'1'
	CALL	TYPE
	LD	A,(USERNO)	;PRINT LOW DIGIT OF USER NO.
	SUB	10
;
DUX:	ADD	A,'0'
	CALL	TYPE
	LD	DE,USRMS2	;PRINT TAIL OF MESSAGE
	LD	C,PRINT
	CALL	BDOS
	LD	A,1
	LD	(LINCNT),A	;WE USED A LINE
;
CHKDRV:	LD	HL,FCB
	LD	A,(HL)		;GET DRIVE NAME
	OR	A			;ANY SPECIFIED?
	JP	NZ,START2	;YES SKIP NEXT ROUTINE
	LD	C,CURDSK
	CALL	BDOS	;GET CURRENT DISK NR
	INC	A			;MAKE A:=1
	LD	(FCB),A
;
START2:	ADD	A,'A'-1	;MAKE IT PRINTABLE
	LD	(DRNAM),A	;SAVE FOR LATER
	LD	HL,FCB+1	;POINT TO NAME
	LD	A,(HL)		;ANY SPECIFIED?
	CP	' '
	JP	NZ,GOTFCB
;No FCB	- make FCB all '?'
	LD	B,11		;FN+FT COUNT
;
QLOOP:	LD	(HL),'?'	;STORE '?' IN FCB
	INC	HL
	DEC	B
	JP	NZ,QLOOP
;
GOTFCB:	LD	A,'?'	;FORCE WILD EXTENT
	LD	(FCB+12),A
	LD	A,(FCB)		;CHECK FOR EXPLICIT DRIVE
	DEC	A
	LD	E,A			;SELECT SPECIFIED DRIVE
	LD	C,SELDSK
	CALL	BDOS
	SUB	A			;ZAP DRIVE NO. IN FCB SO SELECTED DRIVE IS USED
	LD	(FCB),A
	LD	A,(VERFLG)	;CHECK VERS.
	OR	A
	JP	Z,V14		;PRE-2.x...GET PARAMS THE 1.4 WAY
;
	LD	C,CURDPB	;IT'S 2.x OR MP/M...REQUEST DPB
	CALL	BDOS

	; push hl
	; ld de, DPBLK_message
	; ld c, PRINT
	; call BDOS
	; pop hl
	; push hl
	; ld a, h
	; call show_a_as_hex
	; ld a, l
	; call show_a_as_hex
	; call newline
	; pop hl

	INC	HL
	INC	HL
	LD	A,(HL)		;GET BLOCK SHIFT
	LD	(BLKSHF),A
	INC	HL			;BUMP TO BLOCK MASK
	LD	A,(HL)
	LD	(BLKMSK),A	;GET IT
	INC	HL
	INC	HL
	LD	E,(HL)		;GET MAX BLOCK #
	INC	HL
	LD	D,(HL)
	EX	DE,HL
	LD	(BLKMAX),HL	;SAVE IT
	EX	DE,HL
	INC	HL
	LD	E,(HL)		;GET DIRECTORY SIZE
	INC	HL
	LD	D,(HL)
	EX	DE,HL
	LD	(DIRMAX),HL	;SAVE IT

	; push hl

	; ld de, BLKSHF_message
	; ld c, PRINT
	; call BDOS
	; ld a, (BLKSHF)
	; call show_a_as_hex
	; call newline

	; ld de, BLKMSK_message
	; ld c, PRINT
	; call BDOS
	; ld a, (BLKMSK)
	; call show_a_as_hex
	; call newline

	; ld de, BLKMAX_message
	; ld c, PRINT
	; call BDOS
	; ld hl, (BLKMAX)
	; ld a, h
	; call show_a_as_hex
	; ld a, l
	; call show_a_as_hex
	; call newline

	; ld de, DIRMAX_message
	; ld c, PRINT
	; call BDOS
	; ld hl, (DIRMAX)
	; ld a, h
	; call show_a_as_hex
	; ld a, l
	; call show_a_as_hex
	; call newline

	; pop hl

	JP	SETTBL		;DONE...GO SET UP ORDER TABLE

; VERFLG_message:
; 	db 'VERFLG: $'
; BLKSHF_message:
; 	db 'BLKSHF: $'
; BLKMSK_message:
; 	db 'BLKMSK: $'
; BLKMAX_message:
; 	db 'BLKMAX: $'
; DIRMAX_message:
; 	db 'DIRMAX: $'
; DPBLK_message:
; 	db 'DPBLK : $'

;
V14:	
	LD	HL,(BDOS+1)	;GET PARAMS 1.4 STYLE
	LD	L,3BH		;POINT TO DIRECTORY SIZE
	LD	E,(HL)		;GET IT
	LD	D,0		;FORCE HI ORD TO 0
	PUSH	DE		;SAVE FOR LATER
	INC	HL		;POINT TO BLOCK SHIFT
	LD	A,(HL)		;FETCH
	LD	(BLKSHF),A	;SAVE
	INC	HL		;POINT TO BLOCK MASK
	LD	A,(HL)		;FETCH IT
	LD	(BLKMSK),A	;AND SAVE IT
	INC	HL
	LD	E,(HL)		;GET MAX. BLOCK NO.
	LD	D,0
	EX	DE,HL
	LD	(BLKMAX),HL	;SAVE IT
	POP	HL		;RESTORE DIRECTORY SIZE
	LD	(DIRMAX),HL	;SAVE IT
;
SETTBL:	INC	HL		;DIRECTORY SIZE IS DIRMAX+1
	ADD	HL,HL		;DOUBLE DIRECTORY SIZE
	LD	DE,ORDER	;TO GET SIZE OF ORDER TABLE
	ADD	HL,DE		;ALLOCATE ORDER TABLE
	LD	(TBLOC),HL	;NAME TABLE BEGINS WHERE ORDER TABLE ENDS
	LD	(NEXTT),HL
	EX	DE,HL
	LD	HL,(BDOS+1)	;MAKE SURE WE HAVE ROOM TO CONTINUE
	LD	A,E
	SUB	L
	LD	A,D
	SBC	A,H
	JP	NC,OUTMEM
;
;Look up the FCB in the	directory
SFIRST:	LD	C,FSRCHF	;GET 'SEARCH FIRST' FNC
	LD	DE,FCB
	CALL	BDOS		;READ FIRST
	INC	A		        ;WERE THERE ANY?
	JP	NZ,SOME		    ;GOT SOME
;
NONE:	LD	DE,FNF		;PREPARE MP/M ERROR MESSAGE
	LD	A,(MPMFLG)
	OR	A		        ;USE IT IF REALLY MP/M
	JP	NZ,ERXIT1
	CALL	ERXIT		;ELSE USE CP/M ERROR MESSAGE
	DEFM	"NO FILE$"
FNF:	DEFM	"File not found.$"
;
USRMSG:	DEFM	"Directory for user $"
USRMS2:	DEFB	':',13,10,'$'
;
;Read more directory entries
MORDIR:	LD	C,FSRCHN	;SEARCH NEXT
	LD	DE,FCB
	CALL	BDOS		;READ DIR ENTRY
	INC	A		        ;CHECK FOR END (0FFH)
	JP	Z,SPRINT	    ;NO MORE - SORT & PRINT
;
;Point to directory entry 
SOME:	
    DEC	A		;UNDO PREV 'INR A'
	AND	3		;MAKE MODULUS 4
	ADD	A,A		;MULTIPLY...
	ADD	A,A		;..BY 32 BECAUSE
	ADD	A,A		;..EACH DIRECTORY
	ADD	A,A		;..ENTRY IS 32
	ADD	A,A		;..BYTES LONG
	LD	HL,BASE+81H	;POINT TO BUFFER
	;(SKIP TO FN/FT)
	ADD	A,L		;POINT TO ENTRY
	ADD	A,9		;POINT TO SYS BYTE
	LD	L,A		;SAVE (CAN'T CARRY TO H)
;
	IF	SOPT
	LD	A,(SOPFLG)	;DID USER REQUEST SYS FILES?
	CP	'S'
	JP	Z,SYSFOK
	ENDIF	
;
	LD	A,(HL)		;GET SYS BYTE
	AND	80H		    ;CHECK BIT 7
	JP	NZ,MORDIR	;SKIP THAT FILE
;
SYSFOK:	
    LD	A,L		    ;GO BACK NOW
	SUB	10		    ;BACK TO USER NUMBER (ALLOC FLAG)
	LD	L,A		    ;HL POINTS TO ENTRY NOW
;

    ; push hl
	; ld de, USER_message
	; ld c, PRINT
	; call BDOS
    ; ld a, (USERNO)
    ; call show_a_as_hex
    ; call newline
	; ld de, COMP_message
	; ld c, PRINT
	; call BDOS
    ; pop hl
    ; push hl
    ; ld a, (hl)
    ; call show_a_as_hex
    ; call newline
    ; pop hl


	LD	A,(USERNO)	;GET CURRENT USER
	CP	(HL)
	JP	NZ,MORDIR	;IGNORE IF DIFFERENT

	; At this point we have got a directory entry back from the disk.
	; HL is pointing to it.
	; Let's display it on screen so we can see it.
	;call show_fcb_in_hl

	INC	HL
;
;Move entry to table
	EX	DE,HL		;ENTRY TO DE
	LD	HL,(NEXTT)	;NEXT TABLE ENTRY TO HL
	LD	B,12		;ENTRY LENGTH (NAME, TYPE, EXTENT)
;
TMOVE:	LD	A,(DE)		;GET ENTRY CHAR
	AND	7FH		;REMOVE ATTRIBUTES
	LD	(HL),A		;STORE IN TABLE
	INC	DE
	INC	HL
	DEC	B		;MORE?
	JP	NZ,TMOVE
	INC	DE
	INC	DE		;POINT TO SECTOR COUNT
	LD	A,(DE)		; GET IT
	LD	(HL),A		;STORE IN TABLE
	INC	HL
	LD	(NEXTT),HL	;SAVE UPDATED TABLE ADDR
	EX	DE,HL
	LD	HL,(COUNT)	;GET PREV COUNT
	INC	HL
	LD	(COUNT),HL
	LD	HL,13		;SIZE OF NEXT ENTRY
	ADD	HL,DE
	EX	DE,HL		;FUTURE NEXTT IS IN DE
	LD	HL,(BDOS+1)	;PICK UP TPA END
	LD	A,E
	SUB	L		;COMPARE NEXTT-TPA END
	LD	A,D
	SBC	A,H
	JP	C,MORDIR	;IF TPA END>NEXTT THEN LOOP BACK FOR MORE
;
OUTMEM:	CALL	ERXIT
	DEFM	"Out of memory."
	DEFB	13,10,'$'
;
;Sort and print
SPRINT:	LD	HL,(COUNT)	;GET FILE NAME COUNT
	LD	A,L
	OR	H		;ANY FOUND?
	JP	Z,NONE		;NO, EXIT
	PUSH	HL		;SAVE FILE COUNT
;Init the order	table
	LD	HL,(TBLOC)	;GET START OF NAME TABLE
	EX	DE,HL		;INTO DE
	LD	HL,ORDER	;POINT TO ORDER TABLE
	LD	BC,13		;ENTRY LENGTH
;
BLDORD:	LD	(HL),E		;SAVE LO ORD ADDR
	INC	HL
	LD	(HL),D		;SAVE HI ORD ADDR
	INC	HL
	EX	DE,HL		;TABLE ADDR TO HL
	ADD	HL,BC		;POINT TO NEXT ENTRY
	EX	DE,HL
	EX	(SP),HL		;SAVE TBL ADDR, FETCH LOOP COUNTER
	DEC	HL		;COUNT DOWN LOOP
	LD	A,L
	OR	H		;MORE?
	EX	(SP),HL		;(RESTORE TBL ADDR, SAVE COUNTER)
	JP	NZ,BLDORD	;..YES, GO DO ANOTHER ONE
	POP	HL		;CLEAN LOOP COUNTER OFF STACK
	LD	HL,(COUNT)	;GET COUNT
	LD	(SCOUNT),HL	;SAVE AS # TO SORT
	DEC	HL		;ONLY 1 ENTRY?
	LD	A,L
	OR	H
	JP	Z,DONE		;..YES, SO SKIP SORT
;
; THIS SORT ROUTINE IS ADAPTED FROM SOFTWARE TOOLS
; BY KERNIGAN AND PLAUGHER.
;
SORT:	LD	HL,(SCOUNT)	;NUMBER OF ENTRIES
;
L0:	OR	A		;CLEAR CARRY
	LD	A,H		;GAP=GAP/2
	RRA	
	LD	H,A
	LD	A,L
	RRA	
	LD	L,A
	OR	H		;IS IT ZERO?
	JP	Z,DONE		;THEN NONE LEFT
	LD	A,L		;MAKE GAP ODD
	OR	01
	LD	L,A
	LD	(GAP),HL
	INC	HL		;I=GAP+1
;
L2:	LD	(IVAL),HL
	EX	DE,HL
	LD	HL,(GAP)
	LD	A,E		;J=I-GAP
	SUB	L
	LD	L,A
	LD	A,D
	SBC	A,H
	LD	H,A
;
L3:	LD	(JVAL),HL
	EX	DE,HL
	LD	HL,(GAP)	;JG=J+GAP
	ADD	HL,DE
	LD	(JG),HL
	LD	A,12		;COMPARE 12 CHARS
	CALL	COMPARE		;COMPARE (J) AND (JG)
	JP	P,L5		;IF A(J)<=A(JG)
	LD	HL,(JVAL)
	EX	DE,HL
	LD	HL,(JG)
	CALL	SWAP		;EXCH A(J) AND A(JG)
	LD	HL,(JVAL)		;J=J-GAP
	EX	DE,HL
	LD	HL,(GAP)
	LD	A,E
	SUB L
	LD	L,A
	LD	A,D
	SBC	A,H
	LD	H,A
	JP	M,L5		;IF J>0 GOTO L3
	OR	L		;CHECK FOR ZERO
	JP	Z,L5
	JP	L3
;
L5:	LD	HL,(SCOUNT)	;FOR LATER
	EX	DE,HL
	LD	HL,(IVAL)		;I=I+1
	INC	HL
	LD	A,E		;IF I<=N GOTO L2
	SUB L
	LD	A,D
	SBC	A,H
	JP	P,L2
	LD	HL,(GAP)
	JP	L0
;
;Sort is all done - print entries
;
DONE:	LD	HL,ORDER
	LD	(NEXTT),HL
;
	IF	! WIDE
	CALL	DRPRNT		;PRINT DRIVE NAME
	ENDIF	
;
	LD	C,NPL		;NR. OF NAMES PER LINE
	LD	HL,0		;ZERO OUT
	LD	(TOTSIZ),HL	; TOTAL K USED
	LD	(TOTFIL),HL	; AND TOTAL FILES
;
;Print an entry
ENTRY:	LD	HL,(COUNT)	;CHECK COUNT OF REMAINING FILES
	DEC	HL		;1 LEFT?
	LD	A,L		;IF ONLY 1 LEFT, SKIP COMPARE WITH NEXT
	OR	H		;  (SINCE THERE ISN'T ANY NEXT)
	JP	Z,OKPRNT
	PUSH	BC
;
	LD	HL,(BASE+1)
	LD	L,6			;CK STATUS OF KB
	CALL	GOHL		;ANY KEY PRESSED? (Duboius direct BIOS call here!)
	OR	A
	JP	Z,NOBRK		;NO, CONTINUE
	CALL	CINPUT		;GET CHARACTER
	CP	'C'-40H		;CTL-C?
	JP	Z,EXIT		;IF CTL-C THEN QUIT
	CP	'S'-40H		;CTL-S?
	JP	NZ,NOBRK	;NO, CONTINUE
	CALL	CINPUT		;YES, WAIT FOR ANOTHER CHAR.
	CP	'C'-40H		;MIGHT BE CTL-C
	JP	Z,EXIT		;EXIT IF CTL-C, ELSE FALL THRU AND CONTINUE
;
NOBRK:	LD	HL,(NEXTT)
	LD	A,11
	CALL	COMPR		;DOES THIS ENTRY MATCH NEXT ONE?
	POP	BC
	JP	NZ,OKPRNT	;NO, PRINT IT
	INC	HL
	INC	HL		;SKIP, SINCE HIGHEST EXTENT COMES LAST IN LIST
	LD	(NEXTT),HL
	LD	HL,(COUNT)
	DEC	HL
	LD	(COUNT),HL	;COUNT DOWN
	JP	ENTRY		;GO GET	NEXT
;
GOHL:	JP	(HL)		;KLUDGE TO ALLOW CALL TO ADDRESS IN HL
;
OKPRNT:	
    IF	! WIDE
	CALL	FENCE		;PRINT FENCE CHAR AND SPACE
	ENDIF	
;
	LD	HL,(NEXTT)	;GET ORDER TABLE POINTER
	LD	E,(HL)		;GET LO ADDR
	INC	HL
	LD	D,(HL)		;GET HI ADDR
	INC	HL
	LD	(NEXTT),HL	;SAVE UPDATED TABLE POINTER
	EX	DE,HL		;TABLE ENTRY TO HL
	LD	B,8		;FILE NAME LENGTH
	CALL	TYPEIT		;TYPE FILENAME
	LD	A,'.'		;PERIOD AFTER FN
	CALL	TYPE
	LD	B,3		;GET THE FILETYPE
	CALL	TYPEIT
	LD	E,(HL)		;GET EXTENT #
	LD	D,0
	INC	HL
	LD	A,(HL)		;GET SECTOR COUNT OF LAST EXTENT
	EX	DE,HL
	ADD	HL,HL		;# OF EXTENTS TIMES 16K
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL
	EX	DE,HL		;SAVE IN DE
	LD	HL,BLKMSK
	ADD	A,(HL)		;ROUND LAST EXTENT TO BLOCK SIZE
	RRCA	
	RRCA			;CONVERT FROM SECTORS TO K
	RRCA	
	AND	1FH
	LD	L,A		;ADD TO TOTAL K
	LD	H,0
	ADD	HL,DE
	LD	A,(BLKMSK)	;GET SECTORS/BLK-1
	RRCA	
	RRCA			;CONVERT TO K/BLK
	RRCA	
	AND	1FH
	CPL			;USE TO FINISH ROUNDING
	AND	L
	LD	L,A
	EX	DE,HL		;SAVE FILE SIZE IN DE
	LD	HL,(TOTSIZ)
	ADD	HL,DE		;ADD TO TOTAL USED
	LD	(TOTSIZ),HL
	LD	HL,(TOTFIL)	;INCREMENT FILE COUNT
	INC	HL
	LD	(TOTFIL),HL
	EX	DE,HL		;GET BACK FILE SIZE
;
	IF	REPSIZ		;FILE SIZE REPORT WANTED
	CALL	DECPRT		; AND PRINT IT
	LD	A,'k'		;FOLLOW WITH K
	CALL	TYPE
	ENDIF	
;
	IF	! WIDE
	CALL	SPACE
	ENDIF	
;
;See if	more entries
	LD	HL,(COUNT)	;COUNT DOWN ENTRIES
	DEC	HL
	LD	A,L
	OR	H
	JP	Z,PRTOTL	;IF OUT OF FILES, PRINT TOTALS
	LD	(COUNT),HL
	DEC	C		;ONE LESS ON THIS LINE
;
	IF	WIDE
	PUSH	AF
	CALL	NZ,FENCE	;NO CR-LF NEEDED, DO FENCE
	POP	AF
	ENDIF	
;
	CALL	Z,CRLF		;CR-LF NEEDED
	JP	ENTRY
;
;Print HL in decimal with leading zero suppression
;
DECPRT:	
    SUB	A		;CLEAR LEADING ZERO FLAG
	LD	(LZFLG),A
	LD	DE,-1000	;PRINT 1000'S DIGIT
	CALL	DIGIT
	LD	DE,-100		;ETC
	CALL	DIGIT
	LD	DE,-10
	CALL	DIGIT
	LD	A,'0'		;GET 1'S DIGIT
	ADD	A,L
	JP	TYPE
;
DIGIT:	LD	B,'0'		;START OFF WITH ASCII 0
;
DIGLP:	PUSH	HL		;SAVE CURRENT REMAINDER
	ADD	HL,DE		;SUBTRACT
	JP	NC,DIGEX	;QUIT ON OVERFLOW
	POP	AF		;THROW AWAY REMAINDER
	INC	B		;BUMP DIGIT
	JP	DIGLP		;LOOP BACK
;
DIGEX:	POP	HL		;RESTORE POINTER
	LD	A,B
	CP	'0'		;ZERO DIGIT?
	JP	NZ,DIGNZ	;NO, TYPE IT
	LD	A,(LZFLG)	;LEADING ZERO?
	OR	A
	LD	A,'0'
	JP	NZ,TYPE		;PRINT DIGIT
	LD	A,(SUPSPC)	;GET SPACE SUPPRESSION FLAG
	OR	A		;SEE IF PRINTING FILE TOTALS
	RET	Z		;YES, DON'T GIVE LEADING SPACES
	JP	SPACE		;LEADING ZERO...PRINT SPACE
;
DIGNZ:	LD	(LZFLG),A	;SET LEADING ZERO FLAG SO NEXT ZERO PRINTS
	JP	TYPE		;AND PRINT DIGIT
;
;Show total space and files used
;
PRTOTL:	XOR	A		;GET A ZERO TO...
	LD	(SUPSPC),A	;SUPPRESS LEADING SPACES IN TOTALS
	CALL	CRLF		;NEW LINE (WITH PAUSE IF NECESSARY)
;
	IF	WIDE
	LD	DE,TOTMS1	;PRINT FIRST PART OF TOTAL MESSAGE
	ENDIF	
;
	IF	! WIDE
	LD	DE,TOTMS1+1	;PRINT FIRST PART OF TOTAL MESSAGE
	ENDIF	
;
	LD	C,PRINT
	CALL	BDOS
	LD	HL,(TOTSIZ)	;PRINT TOTAL K USED
	CALL	DECPRT
	LD	DE,TOTMS2	;NEXT PART OF MESSAGE
	LD	C,PRINT
	CALL	BDOS
	LD	HL,(TOTFIL)	;PRINT COUNT OF FILES
	CALL	DECPRT
	LD	DE,TOTMS3	;TAIL OF MESSAGE
	LD	C,PRINT
	CALL	BDOS
;
PRT1:	LD	C,GALLOC	;GET ADDRESS OF ALLOCATION VECTOR
	CALL	BDOS
	EX	DE,HL
	LD	HL,(BLKMAX)	;GET ITS LENGTH
	INC	HL
	LD	BC,0		;INIT BLOCK COUNT TO 0
;
GSPBYT:	PUSH	DE		;SAVE ALLOC ADDRESS
	LD	A,(DE)
	LD	E,8		;SET TO PROCESS 8 BLOCKS
;
GSPLUP:	RLA			;TEST BIT
	JP	C,NOTFRE
	INC	BC
;
NOTFRE:	LD	D,A		;SAVE BITS
	DEC	HL		;COUNT DOWN BLOCKS
	LD	A,L
	OR	H
	JP	Z,ENDALC	;QUIT IF OUT OF BLOCKS
	LD	A,D		;RESTORE BITS
	DEC	E		;COUNT DOWN 8 BITS
	JP	NZ,GSPLUP	;DO ANOTHER BIT
	POP	DE		;BUMP TO NEXT BYTE
	INC	DE		;OF ALLOC. VECTOR
	JP	GSPBYT		;PROCESS IT
;
ENDALC:	LD	L,C		;COPY BLOCKS TO HL
	LD	H,B
	LD	A,(BLKSHF)	;GET BLOCK SHIFT FACTOR
	SUB	3		;CONVERT FROM SECTORS TO K
	JP	Z,PRTFRE	;SKIP SHIFTS IF 1K BLOCKS
;
FREKLP:	ADD	HL,HL		;MULT BLKS BY K/BLK
	DEC	A
	JP	NZ,FREKLP
;
PRTFRE:	CALL	DECPRT		;PRINT K FREE
	LD	DE,TOTMS4
	LD	C,PRINT
	CALL	BDOS
	JP	EXIT		;ALL DONE...RETURN TO CP/M
;
DRNAM:		;SAVE DRIVE NAME HERE
TOTMS1:	DEFM	" : Total of $"
TOTMS2:	DEFM	"k in $"
TOTMS3:	DEFM	" files, $"
TOTMS4:	DEFM	"k free$"
;
FENCE:	
    IF	WIDE
	CALL	SPACE
	ENDIF	
;
	IF	! REPSIZ
	CALL	SPACE		;PRINT AN EXTRA SPACE
	ENDIF	
;
	LD	A,DELIM		;FENCE CHARACTER
	CALL	TYPE		;PRINT IT, FALL INTO SPACE
;
	IF	! REPSIZ
	CALL	SPACE		;PRINT ANOTHER SPACE
	ENDIF	
;
SPACE:	LD	A,' '
;
;Type character	in A
;
	IF	DIRCON		;DIRECT CONSOLE OUTPUT
TYPE:	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	HL,(BASE+1)
	LD	L,12
	LD	C,A
	CALL	GOHL
	POP	HL
	POP	DE
	POP	BC
	RET	
	ENDIF			;DIRCON
;
	IF	! DIRCON	;USE BDOS CONSOLE OUTPUT
TYPE:	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	E,A
	LD	C,WRCHR		;CHAR TO CONSOLE
	CALL	BDOS
	POP	HL
	POP	DE
	POP	BC
	RET	
	ENDIF			;NOT DIRCON
;
TYPEIT:	LD	A,(HL)
	CALL	TYPE
	INC	HL
	DEC	B
	JP	NZ,TYPEIT
	RET	
;
;Fetch character from console (without echo)
;
CINPUT:	LD	HL,(BASE+1)
	LD	L,9
	CALL	GOHL
	AND	7FH
	RET	
;
CRLF:	LD	A,(LINCNT)	;CHECK FOR END OF SCREEN
	INC	A
;
	IF	PGPAWZ		;PAUSE AFTER EACH PAGE
	CP	LPS
	JP	C,NOTEOS	;SKIP MESSAGE IF MORE LINES LEFT ON SCREEN
	LD	DE,EOSMSG	;SAY WE'RE PAUSING FOR INPUT
	LD	C,PRINT
	CALL	BDOS
	CALL	CINPUT		;WAIT FOR CHAR.
	CP	'C'-40H		;CTL-C ?
	JP	Z,EXIT
	SUB A		;SET UP TO ZERO LINE COUNT
	ENDIF			;PGPAWZ
;
NOTEOS:	LD	(LINCNT),A	;SAVE NEW LINE COUNT
	LD	A,13		;PRINT CR
	CALL	TYPE
	LD	A,10		;LF
	CALL	TYPE
;
	IF	! WIDE
	CALL	DRPRNT		;DRIVE NAME
	ENDIF	
;
	LD	C,NPL		;RESET NUMBER OF NAMES PER LINE
	RET	
;
EOSMSG:	DEFB	13,10
		DEFM	"(Strike any key to continue)$"
;
	IF	! WIDE
DRPRNT:	LD	A,(DRNAM)
	JP	TYPE
	ENDIF	
;
;Compare routine for sort
;
COMPR:	PUSH	HL		;SAVE TABLE ADDR
	LD	E,(HL)		;LOAD LO
	INC	HL
	LD	D,(HL)		;LOAD HI
	INC	HL
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
;BC, DE now point to entries to be compared
	EX	DE,HL
	LD	E,A		;GET COUNT
;
CMPLP:	LD	A,(BC)
	CP	(HL)
	INC	HL
	INC	BC
	JP	NZ,NOTEQL	;QUIT ON MISMATCH
	DEC	E		;OR END OF COUNT
	JP	NZ,CMPLP
;
NOTEQL:	POP	HL
	RET			;COND CODE TELLS ALL
;
;Swap entries in the order table
;
SWAP:	LD	BC,ORDER-2	;TABLE BASE
	ADD	HL,HL		;*2
	ADD	HL,BC		;+ BASE
	EX	DE,HL
	ADD	HL,HL		;*2
	ADD	HL,BC		;+ BASE
	LD	C,(HL)
	LD	A,(DE)
	EX	DE,HL
	LD	(HL),C
	LD	(DE),A
	INC	HL
	INC	DE
	LD	C,(HL)
	LD	A,(DE)
	EX	DE,HL
	LD	(HL),C
	LD	(DE),A
	RET	
;
;New compare routine
;
COMPARE:	LD	BC,ORDER-2
	ADD	HL,HL
	ADD	HL,BC
	EX	DE,HL
	ADD	HL,HL
	ADD	HL,BC
	EX	DE,HL
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	EX	DE,HL
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	EX	DE,HL
	LD	E,A		;COUNT
;
CMPLPE:	LD	A,(BC)
	CP	(HL)
	INC	BC
	INC	HL
	RET	NZ
	DEC	E
	JP	NZ,CMPLPE
	RET	
;
;Error exit
;
ERXIT:	POP	DE		;GET MSG
;
ERXIT1:	LD	C,PRINT
	CALL	BDOS
	CALL	CRLF
;
	IF	WIDE
	LD	DE,TOTMS1
	ENDIF	
;
	IF	! WIDE
	LD	DE,TOTMS1+1	;SKIP PRINTING DRIVE NAME
	ENDIF	
;
	LD	C,PRINT
	CALL	BDOS
	XOR	A
	LD	(SUPSPC),A	;SUPPRESS LEADING ZEROS
	JP	PRT1		;PRINT SPACE REMAINING
;
;Exit -	all done, restore stack
;
EXIT:	LD	C,CONST		;CHECK CONSOLE STATUS
	CALL	BDOS
	OR	A		;CHAR WAITING?
	LD	C,RDCHR
	CALL	NZ,BDOS		;GOBBLE UP CHAR
	LD	HL,(STACK)	;GET OLD STACK
	LD	SP,HL		;MOVE TO STACK
	RET			;..AND RETURN


show_fcb_in_hl:
	push hl
	push de 
	push bc
	push af

	push hl
	ld b, 16		; Show first 16 bytes in ascii
show_fcb_in_hl1:
	ld a, ' '
	call show_a
	ld a, (hl)
	call show_a_safe
	ld a, ' '
	call show_a
	inc hl
	djnz show_fcb_in_hl1

	call newline
	pop hl

	ld b, 16		; Show first 16 bytes in hex
	call show_b_bytes_as_hex
	ld b, 16		; Show next 16 bytes in hex
	call show_b_bytes_as_hex
	ld b, 4		    ; Show last 4 bytes in hex
	call show_b_bytes_as_hex


	pop af
	pop bc 
	pop de 
	pop hl 
	ret

show_b_bytes_as_hex:
show_fcb_in_hl2:
	ld a, (hl)
	push bc
	push hl
	call show_a_as_hex
	ld a, ' '
	call show_a
	pop hl
	pop bc
	inc hl
	djnz show_fcb_in_hl2

	ld a, 13
	call show_a
	ld a, 10
	call show_a
	ret

newline:
	push af
	ld a, 13
	call show_a
	ld a, 10
	call show_a
	pop af
	ret

show_a_safe:
	cp 32
	jr c,show_blank			; jr c = jump if less than ( < )
	cp 127
	jr nc,show_blank		; jr nc = jump if equal to or greater than ( >= )
show_a:
	push af
	push hl
	push bc
	push de

	LD	E, a
	LD	C, WRCHR		;CHAR TO CONSOLE
	CALL BDOS

	pop de
	pop bc
	pop hl
	pop af
	ret
show_blank:
	LD	a, ' '
	jp show_a

show_a_as_hex:
    push af
    srl a
    srl a
    srl a
    srl a
    add a, '0'
	cp ':'
	jr c, show_a_as_hex1
	add a, 7
show_a_as_hex1:
    call show_a
    pop af
    and %00001111
    add a, '0'
	cp ':'
	jr c, show_a_as_hex2
	add a, 7
show_a_as_hex2:
    call show_a
    ret

USER_message:
    DEFM "USER: $"
COMP_message:
    DEFM "COMP: $"

;
;Temporary storage area
;
IVAL:	DEFW	0
JVAL:	DEFW	0
JG:	DEFW	0
GAP:	DEFW	0
;
BLKSHF:	DEFB	0		;# SHIFTS TO MULT BY SEC/BLK
BLKMSK:	DEFB	0		;SEC/BLK - 1
BLKMAX:	DEFW	0		;HIGHEST BLOCK # ON DRIVE
DIRMAX:	DEFW	0		;HIGHEST FILE # IN DIRECTORY
TOTSIZ:	DEFW	0		;TOTAL SIZE OF ALL FILES
TOTFIL:	DEFW	0		;TOTAL NUMBER OF FILES
LINCNT:	DEFB	0		;COUNT OF LINES ON SCREEN
TBLOC:	DEFW	0		;POINTER TO START OF NAME TABLE
NEXTT:	DEFW	0		;NEXT TABLE ENTRY
COUNT:	DEFW	0		;ENTRY COUNT
SCOUNT:	DEFW	0		;# TO SORT
SWITCH:	DEFB	0		;SWAP SWITCH FOR SORT
SUPSPC:	DEFB	0FFH		;LEADING SPACE FLAG FOR DECIMAL RTN.
BUFAD:	DEFW	BASE+80H	;OUTPUT ADDR
SOPFLG:	DEFS	1		;SET TO 'S' TO ALLOW SYS FILES TO PRINT
USERNO:	DEFS	1		;CONTAINS CURRENT USER NUMBER
TEMP:	DEFS	2		;SAVE DIR ENTRY
VERFLG:	DEFS	1		;VERSION FLAG
MPMFLG:	DEFS	1		;MP/M FLAG
LZFLG:	DEFS	1		;0 WHEN PRINTING LEADING ZEROS
	
	DEFS	160		;STACK AREA
STACK:	DEFS	2		;SAVE OLD STACK HERE
ORDER:	=	$		;ORDER TABLE STARTS HERE
;
;BDOS equates
;
defc RDCHR 	=	1		;READ CHAR FROM CONSOLE
defc WRCHR 	=	2		;WRITE CHR TO CONSOLE
defc PRINT 	=	9		;PRINT CONSOLE BUFF
defc CONST 	=	11		;CHECK CONS STAT
defc SELDSK 	=	14		;SELECT DISK
defc FOPEN 	=	15		;0FFH=NOT FOUND
defc FCLOSE 	=	16		;   "	"
defc FSRCHF 	=	17		;   "	"
defc FSRCHN 	=	18		;   "	"
defc CURDSK 	=	25		;GET CURRENTLY LOGGED DISK NAME
defc GALLOC 	=	27		;GET ADDRESS OF ALLOCATION VECTOR
defc CURDPB 	=	31		;GET CURRENT DISK PARAMETERS
defc CURUSR 	=	32		;GET CURRENTLY LOGGED USER NUMBER (2.x ONLY)
;
