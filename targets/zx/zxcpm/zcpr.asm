
	TITLE	ZCPR Console Command Processor - Version D&J
	SUBTTL	Last Modified: 5 March 1994

; Edited to work on ZXCPM by Kamil Karimov

; cpmemu m80 zcpr=zcpr.asm
; cpmemu l80 zcpr,zcpr/n/e
; z88dk-appmake.exe +cpmdisk -f quorum --container=raw  --extension .trd  -b zcpr.com
; ..  B> ren zcpr.cm6=zcpr.com


;
;  CP/M Z80 Command Processor Replacement (CPR) Version 1.0
;	CCPZ CREATED AND CUSTOMIZED FOR ARIES-II BY RLC
;	FURTHER MODIFIED BY RGF AS V2.0
;	FURTHER MODIFIED BY RLC AS V2.1
;	FURTHER MODIFIED BY KBP AS V2.2
;	FURTHER MODIFIED BY RLC AS V2.4 (V2.3 skipped)
;	FURTHER MODIFIED BY RLC AS V2.5
;	FURTHER MODIFIED BY RLC AS V2.6
;	FURTHER MODIFIED BY SBB AS V2.7
;	FURTHER MODIFIED BY RLC AS V2.8
;	FURTHER MODIFIED BY RLC AS V2.9
;	FURTHER MODIFIED BY RLC AS V3.0
;	FURTHER MODIFIED BY RLC AS V3.1
;	FURTHER MODIFIED BY RLC AS V4.0
;	ZCPR VERSION 1.0 CREATED FROM CCPZ VERSION 4.0 BY RLC IN
;		A COORDINATED EFFORT WITH CCP-GROUP
;	FURTHER MODIFIED BY SBB (AS CCPZ-V4.1 11/27/81)
;	& MORE MODS BY ROBERT FISHER (CA. 12/1/81)
;	[RETROFITTED TO ZCPR BY BEN BRONSON (12/22/81) AS ZCPR-BB]
;
;	FURTHER MODIFIED BY DCK AS Version D&J
;
;	ZCPR is a group effort by CCP-GROUP, whose active membership involved
; in this project consists of the following:
;		RLC - Richard Conn
;		RGF - Ron Fowler
;		KBP - Keith Peterson
;		FJW - Frank Wancho
;	The following individual also provided a contribution:
;		SBB - Steve Bogolub
;
; (Note by BB: SBB's and R Fisher's changes came too late in the 
;  history of CCPZ to be included in the first release of ZCPR)
;
;	Extensive modifications to add ERAQ, DIR for all usrnum,
; LIST x.x P, and fix TYPE when FF encountered was done by Don
; Kirkpatrick, 20 September 1986.
;
;		DCK - Don Kirkpatrick
;
; Further modified for better polling during LIST/TYPE, 16 July 1987.
;
; Further modified to include boot command and to permit multiple
; commands per line. Fixed bug in jump. Modified type so character
; is not echoed, 4 July 1988.
;
; Modified to add PAGE command 31 December 1989.
;
; Added BELL and SAK (Strike Any Key) command.
;
; Added ZCPR3 style drive/user number to all FCB parsing. For Example:
;	A>c4:		Changes to drive C/user 4
;	A>c4:<program>	Runs <program> found on drive C/user 4
;	A>dir c4:	Gives directory of drive C/user 4
;	A>ren <new name>=c4:<old name> 
;			Renames file found on drive C/user 4
; Both the drive and user number are optional; 15: is a valid designation.
; S1 in the FCB is used to store the user number. If S1 contains a valid
; user number, bit 7 will be set. If no user number is specified, S1 will
; contain 0.
;
; Added POKE and changed SCL to a toggle, 12 August 1992.
;
; Added PEEK 30 August 1993.
;
;******** Structure Notes ********
;
;	This CPR is divided into a number of major sections. The following
; is an outline of these sections and the names of the major routines
; located therein.
;
; Section	Function/Routines
; -------	-----------------
;
;   --		Opening Comments, Equates, and Macro Definitions
;
;    0		JUMP Table into CPR
;
;    1		Buffers
;
;    2		CPR Starting Modules
;			CPR1	CPR	RESTRT
;
;    3		Utilities
;			CRLF	PRINTC	PRINT	PRINTS	BELL
;			CONOUT	BREAK	CHKETX	ABORT	READF
;			READ	WRITE	DEFDMA	DMASET	SEARF
;			SEARDE	SEARN	OPENF	OPEN	CLOSE
;			CREATE	BDOSFN	SUBKIL	DELETE	TLOGIN
;			DLOGIN	LOGIN	NEWUSR	RSTUSR	SETUSR
;			BDOSEA	BDOSJP	BDOSBC	BDOSDE
;
;     4 	CPR Utilities
;			PROMPT	REDBUF	CNVBUF	UCASE	SDELM
;			ADVAN	SBLANK	ADDAH	NUMBER	A2NUM
;			HEXNUM	USRNUM	ERROR	DIRPTR	ULOGIN
;			SCANER	SCANT	SCANF	CMDSER	SETUDB
;
;     5 	CPR-Resident Commands and Functions
;     5A		DIR	DIRPR	PRFN
;     5B		ERA
;     5C		ERAQ	PRNNF
;     5D		SAK	REPLY
;     5E		BELL
;     5F		LIST
;     5G		TYPE	PAGER
;     5H		EJECT	
;     5I		SAVE
;     5J	 	REN
;     5K		USER	SUSER
;     5L		DFU
;     5M		SCL
;     5N		PEEK
;     5O		POKE	
;     5P		JUMP
;     5Q		COM
;     5R		GO 	CLLPRG	ERRLOG	ERRJMP
;     5S		GET	MEMLD	PRNLE
;     BIOS		BOOT
;
;
FALSE	EQU	0
TRUE	EQU	NOT FALSE
;
;
;  CUSTOMIZATION EQUATES
;
;  The following equates may be used to customize this CPR for the user's
;    system and integration technique. The following constants are provided:
;
;  TEST   - TRUE to build at intermediate address to debug via debugger.
;
;  COMLD  - TRUE to test and execute as a .com file.
;
;  REL    - TRUE if integration is to be done via MOVCPM.
;
;  BASE   - Base Address of user's CP/M system (normally 0 for DR version).
;	    This equate eases modification by non-standard CP/M (eg. H89).
;
;  P2DOS  - Address of BDOS/P2DOS.
;
TEST	EQU	FALSE	 	;SET TO LOAD/RUN AT 8000H FOR DEBUG
COMLD	EQU	TRUE		;SET TO LOAD AND EXECUTE AS A .COM FILE
REL	EQU	FALSE		;SET TO TRUE FOR MOVCPM INTEGRATION
				;LEAVE ALL FALSE FOR SYSGEN IMAGE
;
BASE	EQU	06000h		;BASE OF CP/M SYSTEM
;P2DOS	EQU	0E400H		;BASE OF BDOS/P2DOS (original)
P2DOS	EQU	0E200H		;BASE OF BDOS/P2DOS (Retro-Brew)
ZCPRSZ	EQU	00800H		;SIZE OF ZCPR
P2DOSSZ	EQU	00E00H		;SIZE OF P2DOS	
BIOS	EQU	P2DOS+P2DOSSZ	;BASE OF BIOS
CPRLOC	EQU	P2DOS-ZCPRSZ	;STANDARD EXECUTION ADDRESS
CPRLOC	DEFL	P2DOS-ZCPRSZ	;STANDARD EXECUTION ADDRESS
;
	IF	REL
CPRLOC	DEFL	0		;MOVCPM IMAGE
	ENDIF
;
	IF	TEST
CPRLOC	DEFL	8000H
	ELSE	
BOOT	EQU	BIOS		;BIOS COLD BOOT ENTRY
LISTST	EQU	BIOS+002DH	;ENTRY POINT FOR LIST STATUS	
	ENDIF
;
;  The following is presented as an option, but is not normally user-customize-
; able. A basic design choice had to be made in the design of ZCPR concerning
; the execution of SUBMIT files. The original CCP had a problem in this sense
; in that it ALWAYS looked for the SUBMIT file from drive A: and the SUBMIT
; program itself (SUBMIT.COM) would place the $$$.SUB file on the currently
; default drive. When the user was logged into B: and he issued a SUBMIT
; command, the $$$.SUB was placed on B: and did not execute. The CPR looked
; for $$$.SUB on A: and never found it.
;
;  After much debate it was decided to have ZCPR perform the same type of
; function as CCP (look for the $$$.SUB file on A:), but the problem with
; SUBMIT.COM still exists. Hence, RGF designed SuperSUB and RLC took his
; SuperSUB and designed SUB from it; both programs are set up to allow the
; selection at assembly time of creating the $$$.SUB on the default drive
; or on drive A:.
;
;  A final definition of the Indirect Command File ($$$.SUB or SUBMIT
; File) is presented as follows:
;
;		"An Indirect Command File is one which contains
;		 a series of commands exactly as they would be
;		 entered from a CP/M Console. The SUBMIT Command
;		 (or SUB Command) reads this file and transforms
;		 it for processing by the ZCPR (the $$$.SUB File).
;		 ZCPR will then execute the commands indicated
;		 EXACTLY as if they were typed at the Console."
;
;  Hence, to permit this to happen, the $$$.SUB file must always
; be present on a specific drive, and A: is the choice for said drive.
; With this facility engaged as such, Indirect Command Files like:
;
;		DIR
;		B:
;		DIR
;
; can be executed, even though the currently default drive is changed
; during execution. If the $$$.SUB file was present on the currently
; default drive, the above series of commands would not work since the
; ZCPR would be looking for $$$.SUB on the default drive, and switching
; default drives without moving the $$$.SUB file as well would cause
; processing to abort.
;
;  Note that the same problem can occur if the user number of the
; $$$.SUB file is not predefined. It is assumed that the $$$.SUB file
; is located on user 0 of the specified drive.
;
;  The trick of using the $ flag returned by DISK RESET is used to
; to speed the search for a $*.* file on drive A. This trick will not
; work if the $$$.SUB file is located on another drive.
;
;
;  Under the ZCPR, three command levels exist:
;
;	(1) that command issued by the user from his console at the '>' prompt
;	(2) that command issued by a $$$.SUB file at the '$' prompt
;	(3) that command issued by a user program by placing the command into
;	    CIBUFF and setting the character count in CBUFF
;
;  To use CIBUFF, the user program stores the command line and character
; count; ZCPR will initialize the pointers properly, store the ending zero,
; and capitalize the command line for processing. Once the command line is
; properly stored, the user executes the command line by reentering ZCPR
; through CPRLOC [NOTE: The C register MUST contain a valid User/Disk Flag
; (see location 4) at this time.]
;
;
; Directory customization equates
;
;TCOL	EQU	TRUE		;TRUE FOR TWO-COLUMN DIRECTORY DISPLAY
WIDE	EQU	FALSE		;TRUE IF WIDE DIRECTORY DISPLAY
FENCE	EQU	'|'		;CHARACTER BETWEEN FILES
USRDLM	EQU	':'		;CHARACTER BETWEEN USER NUMBER AND FILE
USRFLG	EQU	'A'		;LIST $SYS AND $DIR FOR ALL USER NUMBERS
SYSFLG	EQU	'B'		;LIST $SYS AND $DIR
SOFLG	EQU	'S'		;LIST $SYS ONLY
;
; List and Type command customization equates
;
NLINES	EQU	20		;NUMBER OF LINES ON CRT PAGE
NLINEP	EQU	60		;NUMBER OF LINES ON LIST DEVICE
FFKILL	EQU	TRUE		;TRUE SUPPRESSES FF UNTIL FIRST CHARACTER
PGDFLG	EQU	'P'		;TYPE AND LIST COMMAND DEFAULT TOGGLE
NOSTAT	EQU	FALSE		;SET TO TRUE IF BIOS LISTST NOT IMPLEMENTED
;
; Other customization equates
;
BUFLEN	EQU	80		;SIZE OF COMMAND INPUT BUFFER 
MAXUSR	EQU	15		;MAXIMUM USER NUMBER ACCESSIBLE
DEFUSR	EQU	0		;DEFAULT USER NUMBER FOR COM FILES
SPRMPT	EQU	'$'		;CPR PROMPT INDICATING SUBMIT COMMAND
COMCHR	EQU	';'		;BEGIN COMMENT CHARACTER
CMDCHR	EQU	';'		;BEGIN NEXT COMMAND CHARACTER
NUMBASE	EQU	'H'		;CHARACTER USED TO SPECIFY HEXIDECIMAL BASE
RECFLG	EQU	'R'		;CHARACTER FOR SAVE COMMAND TO SAVE RECORDS
SUPRES	EQU	TRUE		;TRUE TO SUPPRESS USER NUMBER FOR USER 0
MULTPL	EQU	TRUE		;TRUE TO ALLOW MULTIPLE COMMANDS ON ONE LINE
REBOOT	EQU	TRUE		;TRUE TO INCLUDE BOOT COMMAND
;
	IF	TEST
CPRMPT	EQU	'<'		;CPR PROMPT INDICATING TEST MODE
	ELSE	
CPRMPT	EQU	'>'		;CPR PROMPT INDICATING USER COMMAND
	ENDIF	
;
; END OF CUSTOMIZATION SECTION
;
ETX	EQU	03H
BELL	EQU	07H
BS	EQU	08H
TAB	EQU	09H
LF	EQU	0AH
FF	EQU	0CH
CR	EQU	0DH
;
WBOOT	EQU	BASE+0000H	;CP/M WARM BOOT ADDRESS
UDFLAG	EQU	BASE+0004H	;USER NUMBER IN HIGH NIBBLE, DISK IN LOW
BDOS	EQU	BASE+0005H	;BDOS FUNCTION CALL ENTRY POINT
TFCB	EQU	BASE+005CH	;DEFAULT FCB BUFFER
TBUFF	EQU	BASE+0080H	;DEFAULT DISK I/O BUFFER
TPA	EQU	BASE+0100H	;BASE OF TPA
;
;
;**** Section 0 ****
;
	.Z80
	ASEG
	ORG	100H
;
; LOADER FOR TEST PURPOSES
;   ALLOWS ONE TO EXECUTE ZCPR AS A .COM FILE
;
	IF	COMLD OR TEST
	LD	HL,BGNXFR
	LD	DE,CPRLOC
	LD	BC,ENDLD-CPRLOC
	LDIR
	LD	BC,(UDFLAG)
	JP	CPRLOC
BGNXFR	EQU	$+6000H
	ENDIF
;
	.PHASE	CPRLOC
;
;  ENTRY POINTS INTO ZCPR
;
;    If the ZCPR is entered at location CPRLOC (at the JUMP to CPR), then
; the default command in CIBUFF will be processed. If the ZCPR is entered
; at location CPRLOC+3 (at the JUMP to CPR1), then the default command in
; CIBUFF will NOT be processed.
;
;    NOTE: Entry into ZCPR in this way is permitted under ZCPR Version 4.0,
; but in order for this to work, CIBUFF and CBUFF MUST be initialized properly
; AND the C register MUST contain a valid User/Disk Flag (see Location 4: the
; most significant nibble contains the User Number and the least significant
; nibble contains the Disk Number.)
;
;    Some user programs (such as SYNONYM3) attempt to use the default
; command facility. Under the original CPR, it was necessary to initialize
; a pointer located at the end of the command buffer to point to the first
; byte in the command buffer. Under Version 4.x of ZCPR, this is no longer
; the case. This pointer, CIBPTR (Command Input Buffer PoinTeR), has been
; moved and the former location is now reserved for the stack. ZCPR
; Version 4.x automatically initializes CIBPTR in all cases.
;
ENTRY:
	JP	CPR		; Process potential default command
	JP	CPR1		; Do NOT process potential default command
;
;**** Section 1 ****
;
; BUFFERS ET AL
;
; INPUT COMMAND LINE AND DEFAULT COMMAND
;
;   The command line to be executed is stored here. This command line
; is generated in one of three ways:
;
;	(1) by the user entering it through the BDOS READLN function at
;	    the du> prompt [user input from keyboard].
;	(2) by the SUBMIT File Facility placing it there from a $$$.SUB
;	    file.
;	(3) by an external program or user placing the required command
;	    into this buffer.
;
;   In all cases, the command line is placed into the buffer starting at
; CIBUFF. This line contains the last character but NOT the Carriage
; Return, and the count is of all characters in the command line up to and
; including the last character. This count is placed into location CBUFF
; (immediately before the command line at CIBUFF.) If ZCPR is entered via
; CPRLOC, the command line is then parsed, interpreted, and the indicated
; command is executed. ZCPR places the terminating zero after the command
; and CIBPTR is properly initialized.
;
;   WARNING: The command line must NOT exceed BUFLEN characters in length.
; For user programs which load this command, the value of BUFLEN can be
; obtained by examining the byte at CPRLOC+6.
;
; It is now possible to place multiple commands on one line. Each command
; is separated from its neighbor by a ";". This feature only works for ZCPR
; commands and programs that return to ZCPR via a RET instruction. Any
; warm boot reloads ZCPR and destroys the contents of the command buffer.
; The multiple command feature may be turned off with the SCL command.
;
MBUFF:	DEFB	BUFLEN		;MAXIMUM BUFFER LENGTH
CBUFF:	DEFB	0		;NUMBER OF CHARACTERS IN COMMAND LINE
CIBUFF:	DEFB	'             '	;DEFAULT (COLD BOOT) COMMAND
	DEFB	0		;COMMAND STRING TERMINATOR
	DEFB	'  ZCPR-D&J of 5 March 1994  '
	DEFB	0		;TERMINATOR FOR DUMP IDENTIFICATION
	DEFS	BUFLEN-($-CIBUFF)+1
	DEFW	0		;SENTINEL FOR STACK END
	DEFS	24		;STACK AREA
STACK	EQU	$		;TOP OF STACK
;
; SUBMIT FILE CONTROL BLOCK
;
SUBDN:	DEFB	1		;DISK DRIVE (A: CONTAINS $$$.SUB)
SUBFN:	DEFB	'$$$     '	;FILE NAME
SUBFT:	DEFB	'SUB'		;FILE TYPE
SUBEX:	DEFB	0		;EXTENT NUMBER
SUBS1	EQU	SUBDN+13	;S1
SUBS2	EQU	SUBDN+14	;S2
SUBRC	EQU	SUBDN+15	;RECORD COUNT
SUBDM	EQU	SUBDN+16	;DISK GROUP MAP
SUBCR	EQU	SUBDN+32	;CURRENT RECORD NUMBER
;
; COMMAND FILE CONTROL BLOCK
;
FCBDN:	DEFS	1		;DISK DRIVE
FCBFN:	DEFS	8		;FILE NAME
FCBFT:	DEFS	3		;FILE TYPE
FCBEX:	DEFS	1		;EXTENT NUMBER
FCBS1:	DEFS	1		;S1
FCBS2:	DEFS	1		;S2
FCBRC:	DEFS	1		;RECORD COUNT
FCBDM:	DEFS	16		;DISK GROUP MAP
FCBCR:	DEFS	1		;CURRENT RECORD NUMBER
;
; Type and List Variables
;
CHRCNT:	DEFS	1		;CHARACTER COUNT FOR TYPE AND LIST
LNCNT:	DEFS	1		;LINE COUNT FOR TYPE AND LIST
TYPLST:	DEFS	1		;FLAG FOR TYPE OR LIST
TABCNT:	DEFS	1		;TAB COUNT FOR TYPE AND LIST
SYSTST:	DEFB	0		;LIST SYSTEM FILES IN DIRECTORY FLAG
;
; General Variables
;
CIBPTR:	DEFW	CIBUFF		;POINTER TO COMMAND INPUT BUFFER
CIPTR:	DEFW	CIBUFF		;POINTER TO CURRENT CMD FOR ERROR REPORTING
TMPUSR:	DEFB	0		;TEMPORARY USER NUMBER
TDRIVE:	DEFB	0		;DEFAULT DRIVE
DFUSR:	DEFB	DEFUSR		;DEFAULT USER
LDADR:	DEFW	TPA		;MEMORY LOAD ADDRESS
;
; CPR BUILT-IN COMMAND TABLE
;   EACH ENTRY IS COMPOSED OF THE BIT 7 TERMINATED COMMAND AND 2-BYTE ADDRESS
;
CMDTBL:
	DC	'DIR'
	DEFW	DIR
	DC	'LIST'
	DEFW	LIST
	DC	'TYPE'
	DEFW	TYPE
	DC	'USER'
	DEFW	USER
	DC	'DFU'
	DEFW	DFU
	DC	'PAGE'
	DEFW	EJECT
	DC	'BELL'
	DEFW	RING
	DC	'SAK'
	DEFW	SAK
	DC	'GO'
	DEFW	GO
	DC	'ERA'
	DEFW	ERA
	DC	'ERAQ'
	DEFW	ERAQ
	DC	'SAVE'
	DEFW	SAVE
	DC	'REN'
	DEFW	REN
	DC	'GET'
	DEFW	GET
	DC	'JUMP'
	DEFW	JUMP
	DC	'PEEK'
	DEFW	PEEK
	DC	'POKE'
	DEFW	POKE
NCMNDS	DEFL	17		;NUMBER OF COMMANDS
;
	IF	MULTPL
	DC	'SCL'
	DEFW	SINGLE
NCMNDS	DEFL	NCMNDS+1
	ENDIF
;
	IF	REBOOT
	DC	'BOOT'
	DEFW	BOOT
NCMNDS	DEFL	NCMNDS+1
	ENDIF	
;
;
;**** Section 2 ****
; CPR STARTING POINTS
;
; START CPR AND DON'T PROCESS DEFAULT COMMAND STORED
;
CPR1:
	XOR	A		;SET NO DEFAULT COMMAND
	LD	(CBUFF),A
;
; START CPR AND POSSIBLY PROCESS DEFAULT COMMAND
;
CPR:
	LD	SP,STACK	;MAKE SURE WE HAVE A VALID STACK
	LD	A,C		;C=USER/DISK NUMBER (SEE LOC 4)
	RRA			;EXTRACT USER NUMBER
	RRA	
	RRA	
	RRA	
	AND	0FH
	LD	(TMPUSR),A	;SET USER NUMBER
	LD	A,C		;GET DISK NUMBER (SEE LOC 4)
	AND	0FH		;EXTRACT DEFAULT DISK DRIVE
	LD	(TDRIVE),A	;SAVE DEFAULT DRIVE
	LD	C,0DH		;RESET DISK SYSTEM
	CALL	BDOS
	LD	(SUBFLG),A	;SAVE SUBMIT FLAG CLUE
	DEFB	0F6H		;SET NZ FLAG (OR A,n)
;
; PROMPT USER AND PROCESS INPUT COMMAND
;
RESTRT:
	XOR	A		;SET ZERO FLAG
	LD	SP,STACK	;RESET STACK
;
; PROCESS INPUT LINE
;
	CALL	REDBUF		;CAPITALIZE, NULL TERMINATE, SKIP SPACES
RS3:
	CP	COMCHR		;COMMENT?
	JR	Z,RESTRT	;YES, SKIP REST OF LINE
	CALL	SCANER		;PARSE COMMAND NAME FROM COMMAND LINE
	JR	NZ,RS4		;ERROR IF NAME CONTAINS A "?"
	CALL	DEFDMA		;SET TBUFF TO DMA ADDRESS
	CALL	DLOGIN		;ASSURE PROPER DRIVE
	CALL	RSTUSR		;ASSURE PROPER USER NUMBER
	CALL	SETUDB		;SET UD BYTE TO MATCH USER/DRIVE
	CALL	CMDSER		;SCAN FOR CPR-RESIDENT COMMAND
;
; ENTRY POINT FOR CONTINUED SCAN OF COMMAND LINE
;
	CALL	ADVAN		;GET ANY CHARACTER
	JR	Z,RESTRT	;NONE, END OF LINE
	LD	(CIPTR),DE	;UPDATE START OF LINE IN CASE ERROR
	INC	DE		;NOT END OF LINE, MUST BE DELIMITER
	LD	(CIBPTR),DE	;SAVE POINTER
;
	IF	MULTPL
	LD	HL,NEWCMD	;COMMAND?
	CP	(HL)
RS4:
	JP	NZ,ERROR	;NO
	CALL	ADVAN		;STEP OVER DELIMITER
	JR	RS3
	ELSE
RS4:
	JP	ERROR
	ENDIF
;
;
;**** Section 3 ****
; I/O UTILITIES
;
; OUTPUT <CRLF>
;
CRLF:
	CALL	PRINT		;PRINT STRING
	DEFB	CR,LF+80H
	RET
;
; PRINT STRING POINTED TO BY RET ADR; START WITH <CRLF>
;
PRINTC:
	CALL	CRLF		;NEW LINE
;
; PRINT STRING POINTED TO BY RET ADR
;
PRINT:
	EX	(SP),HL		;GET POINTER TO STRING
	CALL	PRINTS
	EX	(SP),HL		;RESTORE HL AND RETURN ADDRESS
	RET
;
; PRINT STRING POINTED TO BY HL
;
PRINT1:
	CALL	CONOUT		;PRINT CHARACTER
PRINTS:
	LD	A,(HL)		;GET NEXT BYTE
	INC	HL		;POINT TO NEXT BYTE
	AND	A		;TEST FOR 0 OR BIT 7 SET
	RET	Z		;DONE
	JP	P,PRINT1	;NOT LAST CHARACTER
;
; OUTPUT CHARACTER IN A REG
;
CONOUT:
	PUSH	BC
	PUSH	DE
	LD	C,02H
	RES	7,A		;STRIP MSB IN CASE SET FOR EOS
	LD	E,A
	JR	BDOSDE
;
; GET CHARACTER FROM CONSOLE AND CHECK FOR ^C
;
BREAK:
	PUSH	BC
	LD	C,0BH		;CONSOLE STATUS CHECK
	CALL	BDOSJP
	LD	C,01H		;GET CHARACTER FROM CON: WITH ECHO
	CALL	NZ,BDOSJP	;GET CHARACTER
	POP	BC
	RET	Z		;NO CHARACTER
CHKETX:
	CP	ETX		;^C?
	RET	NZ	 	;NO
ABORT:
	CALL	SUBKIL		;KILL ANY SUBMIT
	JR	RESTRT		;AND RESTART
;
; BDOS FUNCTIONS
;
READF:
	LD	DE,FCBDN	;FALL THRU TO READ
READ:
	LD	C,14H
	DEFB	3AH		;SKIP NEXT TWO BYTES
WRITE:
	LD	C,15H		;FALL THRU TO BDOS CALL
	JR	BDOSJP
DEFDMA:
	LD	DE,TBUFF	;TBUFF = DEFAULT ADDRESS
DMASET:
	LD	C,1AH		;SET DMA ADDRESS
	JR	BDOSJP
SEARF:
	LD	DE,FCBDN	;SPECIFY FCB
SEARDE:
	LD	C,11H		;SEARCH FOR FILE
	DEFB	3AH		;SKIP NEXT TWO BYTES
SEARN:
	LD	C,12H		;SEARN IGNORES DE AND USES THE PREVIOUS
	JR	BDOSFN		;VALUE FROM THE LAST BDOS CALL
OPENF:
	XOR	A
	LD	(FCBCR),A
	LD	DE,FCBDN	;FALL THRU TO OPEN
OPEN:
	LD	C,0FH		;OPEN FILE
	DEFB	3AH		;SKIP NEXT TWO BYTES 
CLOSE:
	LD	C,10H		;CLOSE FILE
	DEFB	3AH		;SKIP NEXT TWO BYTES
CREATE:
	LD	C,16H		;CREATE FILE
BDOSFN:
	CALL	BDOSJP
	INC	A		;SET ERROR RETURN FLAG
	RET
SUBKIL:
	LD	HL,SUBFLG	;ABORT SUBMIT FILE
	LD	A,(HL)		;SUB FILE IN EXECUTION?
	AND	A
	RET	Z		;NO
	LD	(HL),0		;KILL SUB FILE EXECUTION FLAG
	LD	DE,SUBDN	;DELETE $$$.SUB
DELETE:
	LD	C,13H		;DELETE FILE
	JR	BDOSJP		;SAVE MORE SPACE
TLOGIN:
	LD	(TDRIVE),A	;SAVE NEW DEFAULT DRIVE
DLOGIN:
	LD	A,(TDRIVE)	;LOG IN DEFAULT DRIVE
	LD	C,0EH		;SELECT DISK
	JR	BDOSEA		;SAVE SOME CODE SPACE
NEWUSR:
	LD	(TMPUSR),A	;SET NEW USER NUMBER
RSTUSR:
	LD	A,(TMPUSR)	;RESET TEMPORARY USER
SETUSR:
	LD	C,20H		;GET/SET USER NUMBER (GET IF E=FFH)
BDOSEA:
	LD	E,A		;STUFF PARAMETER INTO REG E
BDOSJP:
	PUSH	BC
BDOSBC:
	PUSH	DE		; zcpr does not use any BDOS calls that
BDOSDE:
	PUSH	HL		; return a value in HL. Those HL calls
	CALL	BDOS		; are:
	POP	HL		;   get active drive - #24
	POP	DE		;   get allocation vector - #27
	POP	BC		;   get read-only map - #29
	AND	A		;   get disk parameters - #31
	RET
;
;
;**** Section 4 ****
; CPR UTILITIES
;
; PRINT PROMPT (DU>)
;
PROMPT:
	CALL	CRLF		;PRINT PROMPT
	LD	A,(TDRIVE)	;CURRENT DRIVE IS PART OF PROMPT
	ADD	A,'A'		;CONVERT TO ASCII A-P
	CALL	CONOUT
	LD	A,(TMPUSR)	;GET USER NUMBER
;
	IF	SUPRES		;IF SUPPRESSING USER # REPORT FOR USER 0
	AND	A
	JR	Z,PRPT1		;ZERO, SUPRESS
	ENDIF	
;
PRUSRN:
	ADD	A,0		;CONVERT HEX TO BCD
	DAA
	PUSH	AF		;SAVE UNITS DIGIT
	AND	0F0H
	LD	A,'1'
	CALL	NZ,CONOUT	;PRINT IF OVER 10
	POP	AF
	OR	'0'		;OUTPUT 1'S DIGIT (CONVERT TO ASCII)
	CALL	CONOUT
PRPT1:
	JP	PRINT		;GO PRINT PROMPT CHARACTER
;
; INPUT NEXT COMMAND TO CPR
;
;	This routine determines if a SUBMIT file is being processed
; and extracts the command line from it if so or from the user's console.
; This routine also invokes the DU> prompt.
;
REDBUF:
	JR	NZ,CNVBUF	;PROCESS DEFAULT COMMAND IF ANY
RD0:
	CALL	DEFDMA		;SELECT TBUFF FOR READ
	XOR	A		;SELECT USER 0 FOR SUBMIT SEARCH
	CALL	SETUSR
	LD	DE,SUBDN	;OPEN $$$.SUB
SUBFLG	EQU	$+1		;IN LINE SUBMIT FLAG
	LD	A,0		;SUBMIT IN PROGRESS?
	AND	A
	CALL	NZ,OPEN		;CALL OPEN IF SUBMIT IN PROGRESS
	JR	Z,RB2		;NONE FOUND SO GET COMMAND LINE
	LD	A,(SUBRC)	;GET VALUE OF LAST RECORD IN FILE
	DEC	A		;POINT TO NEXT TO LAST RECORD
	LD	(SUBCR),A	;SAVE NEW VALUE OF LAST RECORD IN $$$.SUB
	CALL	READ		;DE=SUBDN
	JR	NZ,RB1		;ABORT $$$.SUB IF ERROR IN READING LAST REC
	LD	HL,SUBS2	;POINT TO S2 OF $$$.SUB FCB
	LD	(HL),A		;SET S2 TO ZERO
	INC	HL		;POINT TO RECORD COUNT
	DEC	(HL)		;DECREMENT RECORD COUNT OF $$$.SUB
	PUSH	AF		;SAVE ZERO FLAG
	CALL	Z,SUBKIL	;KILL SUBMIT IF ZERO RECORDS LEFT
	POP	AF		;ELSE
	CALL	NZ,CLOSE	;JUST CLOSE FILE
	CALL	PROMPT		;PRINT SUBMIT PROMPT
	DEFB	SPRMPT+80H
	LD	HL,TBUFF+1	;PRINT COMMAND LINE FROM $$$.SUB
	CALL	PRINTS
	LD	HL,TBUFF	;MOVE COMMAND LINE TO COMMAND BUFFER	
	LD	DE,CBUFF
	LD	BC,BUFLEN
	LDIR
	CALL	BREAK		;CHECK FOR ABORT (ANY CHARACTER)
	JR	Z,CNVBUF	;NONE
;
; INPUT COMMAND LINE FROM USER CONSOLE
;
RB1:
	CALL	SUBKIL		;ERASE $$$.SUB
RB2:
	CALL	PROMPT		;PRINT PROMPT
	DEFB	CPRMPT+80H
	LD	C,0AH		;READ COMMAND LINE FROM USER
	LD	DE,MBUFF
	CALL	BDOS
;
; CAPITALIZE STRING (ENDING IN 0) IN CBUFF AND SET POINTER FOR PARSING
;
CNVBUF:
	LD	HL,CBUFF	;POINT TO USER'S COMMAND BUFFER
	LD	A,(HL)		;ANY CHARACTERS IN BUFFER?
	AND	A
	JR	Z,RD0	 	;NO, FILL BUFFER
	INC	HL
	LD	(CIBPTR),HL	;INITIALIZE COMMAND LINE POINTER
	LD	B,A		;INITIALIZE CHARACTER COUNTER
CB1:
	LD	A,(HL)		;CAPITALIZE COMMAND CHARACTER
	CALL	UCASE
	LD	(HL),A
	INC	HL		;POINT TO NEXT CHARACTER
	DJNZ	CB1		;CONTINUE TO END OF COMMAND LINE
	LD	(HL),B		;STORE ENDING <NULL>
;
; ADVANCE INPUT POINTER TO FIRST NON-BLANK AND FALL THROUGH TO SBLANK
;
ADVAN:
	LD	DE,(CIBPTR)
;
; SKIP STRING POINTED TO BY DE (STRING ENDS IN 0) UNTIL END OF STRING
;   OR NON-BLANK ENCOUNTERED (BEGINNING OF TOKEN)
;
SBLANK:
	LD	A,(DE)
	OR	A
	RET	Z
	CP	' '
	RET	NZ
	INC	DE
	JR	SBLANK
;
; CONVERT CHARACTER IN A TO UPPER CASE
;
UCASE:
	CP	61H		;LOWER-CASE A
	RET	C
	CP	7BH		;GREATER THAN LOWER-CASE Z?
	RET	NC
	AND	5FH		;CAPITALIZE
	RET	
;
; CHECK TO SEE IF DE POINTS TO DELIMITER; IF SO, RET W/ZERO FLAG SET
;
SDELM:
	LD	A,(DE)
	OR	A		;0=DELIMITER
	RET	Z
	CP	' '		;ERROR IF < <SP>
	JP	C,ERROR
	RET	Z		;<SP> =DELIMITER
	CP	'.'		;"." =DELIMITER
	RET	Z
	CP	'['		;"[" =DELIMITER
	RET	Z
	CP	']'		;"]" =DELIMITER
	RET	Z
	CP	'>'		;">" =DELIMITER BUT GREATER NOT
	RET	NC
	CP	':'		;":"  ";"  "<"  "=" =DELIMITERS
	RET	C		;NO DELIMITER FOUND
	CP	A		;SET ZERO FLAG
	RET	

;
; ADD A TO HL (HL=HL+A)
;
ADDAH:
	ADD	A,L
	LD	L,A
	RET	NC
	INC	H
	RET	
;
; EXTRACT DECIMAL NUMBER FROM COMMAND LINE
;   RETURN WITH 8-BIT VALUE IN REG A AND 16-BIT VALUE IN HL
;   ALL REGISTERS MAY BE AFFECTED
;
NUMBER:
	CALL	SCANER		;PARSE NUMBER AND PLACE IN FCBFN
	LD	HL,FCBFN+10	;POINT TO END OF TOKEN FOR CONVERSION
	LD	B,11		;11 CHARACTERS MAX
;
; CHECK FOR SUFFIX FOR HEXADECIMAL NUMBER
;
NUMS:
	LD	A,(HL)		;GET CHARACTERS FROM END, SEARCHING FOR SUFFIX
	DEC	HL		;BACK UP
	CP	NUMBASE		;CHECK AGAINST BASE SWITCH FLAG
	JR	Z,HNUM1
	CP	' '		;SPACE?
	JR	NZ,NUM1		;CHECK FOR LAST DIGIT
	DJNZ	NUMS		;COUNT DOWN
;
; PROCESS DECIMAL NUMBER
;
NUM1:
	LD	HL,0		;CLEAR GRAND TOTAL
	LD	DE,FCBFN	;POINT TO BEGINNING OF TOKEN
NUM2:
	LD	A,(DE)		;GET CHARACTER
	CP	' '		;DONE IF <SP>
NUM3:
	LD	A,L		;TOTAL TO A IN CASE DONE
	RET	Z		;ALL DONE
	CALL	A2NUM		;CONVERT DIGIT
	JR	NC,NUM2		;NO ERROR
	JR	ERROR
;
; ASCII TO NUMERICAL CONVERSION
;   RETURNS WITH CARRY SET IF INVALID OR OVERFLOW
;   BASE 10 ASSUMED - MAXIMUM VALUE IS 255
;
A2NUM:
	LD	A,(DE)		;GET DIGIT
	SUB	'0'		;CONVERT TO BINARY (ASCII 0-9 TO BINARY)
	CP	10		;ERROR IF >= 10
	CCF			;FLIP CARRY
	RET	C
	LD	C,A		;DIGIT IN C
	LD	A,L		;NEW VALUE = OLD VALUE * 10
	RLCA			;*2
	RET	C		;ERROR
	RLCA			;*4
	RET	C		;ERROR
	ADD	A,L		;*5
	RET	C		;ERROR
	RLCA			;*10
	RET	C		;ERROR
	ADD	A,C		;NEW VALUE = OLD VALUE * 10 + DIGIT
	RET	C		;DON'T INC DE IF ERROR
	LD	L,A		;SET NEW VALUE
	INC	DE		;GOOD DIGIT
	RET
;
; EXTRACT HEXADECIMAL NUMBER FROM COMMAND LINE
;   RETURN WITH 8-BIT VALUE IN REG A AND 16-BIT VALUE IN HL
;   ALL REGISTERS MAY BE AFFECTED
;
HEXNUM:
	CALL	SCANER		;PARSE NUMBER AND PLACE IN FCBFN
HNUM1:
	LD	HL,0		;HL=ACCUMULATED VALUE
	LD	DE,FCBFN	;POINT TO TOKEN FOR CONVERSION
HNUM2:
	LD	A,(DE)		;GET CHARACTER
	CP	' '		;DONE?
	JR	Z,NUM3		;RETURN IF SO
	CP	'H'		;DONE IF H SUFFIX
	JR	Z,NUM3
	SUB	'0'		;CONVERT TO BINARY
	CP	10		;0-9?
	JR	C,HNUM3
	SUB	17		;A-F?
	CP	6		;ERROR?
	JR	NC,ERROR
	ADD	A,10
HNUM3:
	INC	DE		;POINT TO NEXT CHARACTER
	ADD	HL,HL		;LEFT SHIFT 4
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL
	OR	L		;MASK IN NEW LOW
	LD	L,A		;NEW LOW BYTE IN L
	JR	HNUM2
;
; GET THE REQUESTED USER NUMBER FROM THE COMMAND LINE AND VALIDATE IT.
;
USRNUM:
	CALL	NUMBER
	LD	E,A
	CP	MAXUSR+1
	RET	C
;
; INVALID COMMAND -- PRINT IT
;
ERROR:
	CALL	CRLF		;NEW LINE
	LD	HL,(CIPTR)	;POINT TO BEGINNING OF COMMAND LINE
ERR1:
	LD	A,(HL)		;GET CHARACTER
	CP	' '+1		;SIMPLE '?' IF <SP> OR LESS
	CALL	NC,CONOUT	;PRINT COMMAND CHARACTER OR FALL THRU
	INC	HL		;POINT TO NEXT
	JR	NC,ERR1		;CONTINUE
	CALL	PRINT		;PRINT '?'
	DC	'?'
	JP	ABORT		;RESTART CPR
;
; POINT TO DIRECTORY ENTRY IN TBUFF WHOSE OFFSET IS SPECIFIED BY A AND C
;
DIRPTR:
	LD	HL,TBUFF	;POINT TO TEMP BUFFER
	ADD	A,C		;POINT TO 1ST BYTE OF DIR ENTRY
	CALL	ADDAH		;POINT TO DESIRED BYTE IN DIR ENTRY
	LD	A,(HL)		;GET DESIRED BYTE
	RET	
;
; CHECK FOR VALID USER AND LOG IN IF VALID
;
ULOGIN:
	LD	A,(FCBS1)	;GET USER NUMBER
ALOGIN:
	ADD	A,80H		;VALID?
	CALL	P,SETUSR	;SET IF VALID
	RET
;
; EXTRACT TOKEN FROM COMMAND LINE AND PLACE IT INTO FCBDN;
;   FORMAT FCBDN FCB IF TOKEN RESEMBLES FILE NAME AND TYPE (FILENAME.TYP);
;   ON INPUT, CIBPTR PTS TO CHARACTER AT WHICH TO START SCAN;
;   ON OUTPUT, CIBPTR PTS TO CHARACTER AT WHICH TO CONTINUE AND ZERO FLAG IS
;     RESET IF '?' IS IN TOKEN
;
SCANER:
	LD	HL,FCBDN	;POINT TO FCBDN
SCAN1:
	PUSH	HL		;SAVE POINTER TO FCB
	CALL	ADVAN		;SKIP TO NON-BLANK OR END OF LINE
	LD	(CIPTR),DE	;SET POINTER TO NON-BLANK OR END OF LINE
	JR	Z,SCAN3		;END OF COMMAND LINE
	SBC	A,'A'		;CONVERT POSSIBLE DRIVE SPEC TO NUMBER
	CP	16		;VALID DRIVE?
	INC	A		;CONVERT TO DRIVE (A=1, AND SO ON)
	JR	C,SCAN2		;YES
	XOR	A		;SELECT DEFAULT DRIVE
	DEC	DE		;DON'T MOVE TO NEXT CHARACTER
SCAN2:
	LD	H,A		;STORE NUMBER (A:=0, B:=1, ETC) IN H
	INC	DE		;POINT TO NEXT CHARACTER
	LD	L,0		;ZERO TOTAL
	CALL	A2NUM		;CONVERT FIRST DIGIT
	JR	C,SCAN3		;NOT VALID
	CALL	A2NUM		;CONVERT SECOND DIGIT
	LD	A,L
	SET	7,L		;MAKE VALID JUST IN CASE
	CP	MAXUSR+1	;TOO BIG?
	JR	C,SCAN3	 	;NO
	LD	A,(DE)		;ANY ':'?
	CP	':'
	JP	Z,NAMERR	;YES, NAME ERROR
SCAN3:
	LD	A,(DE)		;SEE IF LAST CHARACTER IS A COLON (:)
	INC	DE		;POINT TO BYTE AFTER ':'
	CP	':'
	JR	Z,SCAN4		;YES, WE HAVE A DRIVE SPEC
	LD	HL,0		;NOT VALID DRIVE SPEC, SWITCH TO DEFAULT
	LD	DE,(CIPTR)	;RESTART SCAN
;
; EXTRACT FILENAME FROM POSSIBLE FILENAME.TYP
;
SCAN4:
	LD	B,H		;MOVE DRIVE TO B
	EX	(SP),HL		;GET BACK FCB POINTER AND SAVE USER NUMBER
	LD	(HL),B		;SAVE DRIVE
	LD	B,8	 	;MAX OF 8 CHARACTERS
	XOR	A		;CLEAR '?' COUNT
	EX	AF,AF		;AND SAVE
	CALL	SCANF		;GET POSSIBLE NAME
	CALL	SCANT		;AND POSSIBLE TYPE
;
; FILL IN EX, S1, S2, AND RC
;
	XOR	A
	INC	HL		;POINT TO NEXT BYTE IN FCBDN
	LD	(HL),A		;ZERO EX
	INC	HL
	POP	BC		;GET BACK USER NUMBER
	LD	(HL),C		;STUFF AWAY USER NUMBER IN S1
	INC	HL	
	LD	(HL),A		;ZERO S2
	INC	HL
	LD	(HL),A		;ZERO RC
;
; SCAN COMPLETE -- DE POINTS TO DELIMITER BYTE AFTER TOKEN
;
	LD	(CIBPTR),DE
	EX	AF,AF		;GET NUMBER OF '?' IN FILENAME.TYP
	RET	
;
; EXTRACT FILE TYPE FROM POSSIBLE FILENAME.TYP
;
SCANT:
	LD	B,3		;PREPARE TO EXTRACT TYPE
	CP	'.'		;IF (DE) DELIMITER IS A '.', WE HAVE A TYPE
	JR	NZ,SCAN11	;FILL FILE TYPE WITH <SP>
	INC	DE		;POINT TO CHARACTER IN COMMAND LINE AFTER '.'
SCANF:
	LD	C,' '		;FILL CHARACTER
SCAN11:
	INC	HL		;STEP TO NEXT BYTE IN FCBN
	CALL	SDELM		;CHECK FOR DELIMITER
	JR	Z,SCAN12	;FILL REST WITH FILL BYTE IF A DELIMITER
	CP	'*'		;WILD?
	JR	NZ,SCAN13	;NO
	LD	C,'?'		;CHANGE FILL BYTE TO '?'
SCAN12:
	DEC	DE		;DON'T STEP OFF CURRENT SYMBOL
	LD	A,C		;GET FILL BYTE
SCAN13:
	CP	'?'		;QUESTION MARK?
	JR	NZ,SCAN14	;NO, JUST STORE CHARACTER
	EX	AF,AF		;GET QUESTION MARK COUNT
	INC	A		;COUNT IT
	EX	AF,AF		;AND SAVE COUNT
SCAN14:
	INC	DE		;POINT TO NEXT CHARACTER IN COMMAND LINE
	LD	(HL),A		;STORE CHARACTER IN FCBDN
	DJNZ	SCAN11		;COUNT DOWN CHARACTERS IN FILE TYPE (3 MAX)
SCAN15:
	CALL	SDELM		;SKIP REST OF CHARACTERS TO
	RET	Z		;DELIMITER
	INC	DE
	JR	SCAN15
;
; CMDTBL (COMMAND TABLE) SCANNER
;   JUMPS TO ADDRESS OF COMMAND IF CPR-RESIDENT
;   JUMPS TO COM IF NOT CPR-RESIDENT COMMAND
;
CMDSER:
	LD	A,(FCBFN)	;ANY COMMAND?
	CP	' '		;' ' MEANS COMMAND WAS 'D:' TO SWITCH
	LD	A,(FCBS1)	;GET USER NUMBER IF ANY
	LD	HL,FCBDN	;POINT TO DRIVE
	JR	NZ,CMS0		;NOT <SP>, SO MUST BE COMMAND
	ADD	A,80H		;CONVERT TO USER NUMBER
	CALL	P,NEWUSR	;SET IF VALID USER IN FCB
	LD	A,(HL)	 	;LOOK FOR DRIVE SPEC
	DEC	A		;ADJUST FOR LOG IN
	CALL	P,TLOGIN	;LOG IN DRIVE
SETUDB:
	LD	A,(TMPUSR)	;GET CURRENT USER NUMBER
	ADD	A,A		;PLACE IT IN HIGH NIBBLE
	ADD	A,A
	ADD	A,A
	ADD	A,A
	LD	HL,TDRIVE	;ADD DEFAULT DRIVE NUMBER (LOW NIBBLE)
	OR	(HL)
	LD	(UDFLAG),A	;UPDATE USER/DRIVE BYTE
	RET
CMS0:
	OR	(HL)		;DRIVE OR USER NUMBER
	JR	NZ,CMS5		;YES, CAN'T BE BUILT IN COMMAND
	LD	HL,CMDTBL	;POINT TO COMMAND TABLE
	LD	B,NCMNDS	;SET COMMAND COUNTER
CMS1:
	LD	DE,FCBFN	;POINT TO STORED COMMAND NAME
CMS2:
	LD	A,(DE)		;COMPARE AGAINST TABLE ENTRY
	XOR	(HL)
	ADD	A,A
	JR	NZ,CMS3		;NO MATCH
	INC	DE		;POINT TO NEXT CHARACTER
	INC	HL
	JR	NC,CMS2		;NOT END OF TABLE ENTRY
	LD	A,(DE)		;NEXT CHARACTER IN INPUT COMMAND MUST BE <SP>
	CP	' '
	JR	NZ,CMS4
	LD	A,(HL)		;FOUND COMMAND,
	INC	HL		;LOAD ADDRESS,
	LD	H,(HL)		;AND
	LD	L,A		;JUMP TO IT
	JP	(HL)		;COMMAND IS CPR-RESIDENT
CMS3:
	BIT	7,(HL)		;END OF TABLE ENTRY?
	INC	HL
	JR	Z,CMS3		;NO
CMS4:
	INC	HL		;SKIP ADDRESS
	INC	HL
	DJNZ	CMS1		;NOT TO END OF TABLE YET
CMS5:
	JP	COM		;COMMAND MAY BE DISK-RESIDENT
;
;**** Section 5 ****
; CPR-Resident Commands
;
;
;Section 5A
;Command: DIR
;Function: To display a directory of the files on disk.
;Forms:
;	DIR <afn>	Display the DIR files
;	DIR <afn> S	Display the SYS files
;	DIR <afn> B	Display both DIR and SYS files
;	DIR <afn> A	Display both DIR and SYS files for all user numbers
;
DIR:
	CALL	SCANER		;EXTRACT POSSIBLE D:FILENAME.TYP TOKEN
	CALL	ULOGIN		;LOG ANY USER
	LD	HL,FCBFN	;MAKE FCB WILD (ALL '?') IF NO FILENAME.TYP
	LD	A,(HL)		;GET FIRST CHARACTER OF FILENAME.TYP
	CP	' '		;IF <SP>, ALL WILD
	JR	NZ,DIR2
	LD	B,11		;NUMBER OF CHARACTERS IN FN & FT
DIR1:
	LD	(HL),'?'	;STORE '?'
	INC	HL
	DJNZ	DIR1
DIR2:
	CALL	ADVAN		;LOOK AT NEXT INPUT CHARACTER
	LD	B,0FFH		;LOAD ALL FILES FLAG
	CP	USRFLG		;ALL FILES ON DISK?
	JR	Z,DIR4		;YES
	LD	B,80H		;IN CASE SYS ONLY
	CP	SOFLG		;SYS ONLY?
	JR	Z,DIR4		;YES
	CP	SYSFLG		;HAVE SYSTEM SPECIFIER?
	LD	A,B		;SET SYSTEM BIT EXAMINATION
	LD	B,0		;SYSTEM TOKEN DEFAULT
	JR	NZ,DIRPR
DIR4:
	INC	DE
	LD	(CIBPTR),DE
	LD	A,B
	;DROP INTO DIRPR TO PRINT DIRECTORY
	;THEN RESTART CPR
;
; DIRECTORY PRINT ROUTINE; ON ENTRY, A IS 80H IF SYSTEM FILES EXCLUSIVELY
;
DIRPR:
	CALL	CRLF
	LD	D,A		;STORE SYSTEM FLAG IN D
	LD	A,B		;SAVE SYSTST
	LD	(SYSTST),A
	XOR	A		;SET COLUMN COUNTER TO 0
	LD	B,A		;AND USER NUMBER JUST IN CASE
DIRPR1:
	ADD	A,03H		;FORCE CRLF
	AND	0FCH
	LD	E,A
	PUSH	DE	
	INC	D		;ALL USER NUMBERS?
	PUSH	BC		;SAVE USER NUMBER
	LD	A,B		;AND
	CALL	Z,SETUSR	;SET IF ALL USER NUMBERS
	CALL	SEARF		;SEARCH FOR SPECIFIED FILE (FIRST OCCURRENCE)
DIRPR2:
	POP	BC		;GET BACK USER NUMBER
	POP	DE		;AND SYSTEM FLAG
	JR	NZ,DIRPR4	;FILE FOUND
	LD	A,B		;AT LAST USER NUMBER?
	INC	B		;STEP TO NEXT USER NUMBER
	CP	MAXUSR
	LD	A,E		;IN CASE DONE
	JR	NC,DIRPR3	;DONE
	LD	E,D		;EITHER WAY, E IS GOING TO BE CHANGED
	INC	E
	JR	Z,DIRPR1	;PRINT ALL USER NUMBERS
DIRPR3:
	AND	A		;ANY PRINTED?
	JP	CHKFND		;GO CHECK
;
; ENTRY SELECTION LOOP; ON ENTRY, A=OFFSET FROM SEARF OR SEARN
;
DIRPR4:
	DEC	A		;ADJUST TO RETURNED VALUE
	RRCA			;CONVERT NUMBER TO OFFSET INTO TBUFF
	RRCA	
	RRCA	
	LD	C,A		;OFFSET INTO TBUFF IN C (C=OFFSET TO ENTRY)
	LD	A,10		;ADD 10 TO POINT TO SYSTEM FILE ATTRIBUTE BIT
	CALL	DIRPTR
	PUSH	DE
	AND	D		;MASK FOR SYSTEM BIT
	INC	D		;ALL FILES?
	JR	Z,DIRPR5	;YES
	LD	HL,SYSTST	;SYSTEM FILE?
	CP	(HL)
	JR	NZ,DIRPR9	;NO
DIRPR5:
	LD	A,E		;WHAT TO PRINT
;
;	IF	TCOL
;	AND	01H		;OUTPUT <CR><LF> IF 2 ENTRIES PRINTED IN LINE
;	ELSE	
;
;	AND	03H		;OUTPUT <CR><LF> IF 4 ENTRIES PRINTED IN LINE
;	ENDIF	
;
;	CALL	Z,CRLF		;NEWLINE ALWAYS RETURNS ZERO TRUE
;	JR	Z,DIRPR6
	CALL	PRINT
;
	IF	WIDE
	DEFB	'  '		;2 SPACES
	DEFB	FENCE		;THEN FENCE CHARACTER
	DC	'  '	 	;THEN 2 MORE SPACES
	ELSE	
;
	DEFB	' '		;SPACE
;	DEFB	FENCE		;THEN FENCE CHARACTER
	DC	' '		;THEN SPACE
	ENDIF	
;
DIRPR6:
	POP	DE
	INC	E		;BUMP NUMBER OF FILES LISTED
	PUSH	DE
	INC	D		;PRINT WITH USER NUMBER?
	JR	NZ,DIRPR8	;NO
	LD	A,B		;GET USER NUMBER AND
	CALL	PRUSRN		;AND PRINT
	DEFB	USRDLM+80H	;USER NUMBER DELIMITER
DIRPR8:
	XOR	A		;DON'T EAT SPACES
	CALL	PRFN
DIRPR9:
	PUSH	BC
	CALL	SEARN		;GET NEXT FILENAME
	JR	DIRPR2
PRFN:
	PUSH	BC
	LD	B,A		;SAVE EAT SPACES FLAG
	LD	A,1
	CALL	DIRPTR		;HL NOW POINTS TO 1ST BYTE OF FILE NAME
	LD	C,B		;SAVE EAT SPACES FLAG
	LD	B,12		;12 CHARACTER TOTAL
PRFN1:
	LD	A,B		;CHECK FOR FILE TYPE
	CP	04H
	LD	A,(HL)
	RES	7,A
	JR	NZ,PRFN2	;NOT YET AT TYPE
	DEC	HL		;ADJUST HL FOR TYPE DELIMITER
	CP	' '		;NO FILE TYPE?
	JR	Z,PRFN2		;CONTINUE IF SO
	LD	A,'.'		;FILE TYPE EXISTS, PRINT DOT
PRFN2:
	INC	HL		;STEP TO NEXT CHARACTER
	CP	C		;EAT SPACES?
	CALL	NZ,CONOUT
	DJNZ	PRFN1
	POP	BC
	RET	
;
;Section 5B
;Command: ERA
;Function: To erase files; names of the erased files are displayed.
;Forms:
;	ERA <afn>
;
ERA:
	CALL	SCANER		;PARSE FILE SPECIFICATION
	CP	11		;ALL WILD (ALL FILES = 11 '?')?
	JR	NZ,ERA1		;IF NOT, THEN DO ERASES
	CALL	REPLY
	JP	NZ,RESTRT	;RESTART CPR IF NOT
ERA1:
	CALL	ULOGIN		;LOG ANY USER
	XOR	A		;PRINT ALL FILES (EXAMINE SYSTEM BIT)
	LD	B,A		;NO SYS-ONLY OPT TO DIRPR
	CALL	DIRPR		;PRINT DIRECTORY OF ERASED FILES
ERA2:
	LD	DE,FCBDN	;DELETE FILE SPECIFIED
	JP	DELETE		;REENTER CPR VIA DELETE
;
;Section 5C
;Command: ERAQ
;Function: To erase files with individual query.
;Forms:
;	ERAQ <afn>
;	<afn>? Y
;	  :
;	  :
;
ERAQ:
	CALL	SCANER		; parse file specification
	CALL	ULOGIN		; log any user
	LD	HL,01FFH	; load first flag
ERAQ1:
	CALL	SEARF		; find first entry
	JR	NZ,ERAQ2	; found one
	INC	L		; ever found any?
;
; Check for File Found
;
CHKFND:
	RET	NZ		; yes
;
; No File Error Message
;
PRNNF:
	CALL	PRINTC		;NO FILE MESSAGE
	DC	'No File'
	RET	
ERAQ2:
	LD	L,H		; restart found count
ERAQ3:
	DEC	H		; at file to erase?
	JR	NZ,ERAQ5	; no
	INC	H		; reset H to 1
	INC	L		; step count in case don't delete
	PUSH	HL		; save flag first
	DEC	A		; compute offset
	RRCA	
	RRCA	
	RRCA	
	LD	C,A
	CALL	CRLF
	LD	A,' '		; eat spaces
	CALL	PRFN		; print file name
	CALL	REPLY1		; prompt
	JR	NZ,ERAQ4	; reply not 'Y'
	XOR	A
	CALL	DIRPTR		; get FCB to delete
	LD	A,(FCBDN)	; get drive specification
	LD	(HL),A		; select drive
	EX	DE,HL
	CALL	DELETE		; go delete
	POP	HL		; get flags
	DEC	L		; reduce count since file deleted
	LD	H,L		; update next file to process
	JR	ERAQ1		; and restart process
ERAQ4:
	POP	HL		; get count
ERAQ5:
	CALL	SEARN		; find next file
	JR	NZ,ERAQ3	; more files, go ask
	RET			; done
;
;Section 5D
;Command: SAK
;Function: To pause until a key is struck; ^C warm boots.
;Forms:
;	SAK
;	? <any key>
;
SAK:
	CALL	CRLF		; strike any key
	JR	REPLY1
REPLY:
	CALL	PRINTC
	DC	'All'
REPLY1:
	CALL	PRINT
	DC	'? '
REPL2:
	CALL	BREAK		; get response
	JR	Z,REPL2		; none
	CALL	UCASE
	CP	'Y'
	RET	
;
;Section 5E
;Command: BELL
;Function: To ring terminal bell.
;Forms:
;	BELL
;
RING:
	LD	A,BELL		; load bell into A
	JP	CONOUT		; and output it
;
;Section 5F
;Command: LIST
;Function: To print specified file on list device.
;Forms:
;	LIST <ufn>	Print file
;	LIST <ufn> P	Print file without default paging
;
LIST:
;
	IF	FFKILL
	LD	HL,NLINEP+0580H	; lines/page, first ff and list flags
	ELSE	
	LD	HL,NLINEP+0500H	; lines/page and list flag
	ENDIF	
;
	JR	TYPE1
;
;Section 5G
;Command: TYPE
;Function: To display specified file on console.
;Forms:
;	TYPE <ufn>	Display file
;	TYPE <ufn> P	Display file without default paging
;
TYPE:
;
	IF	FFKILL
	LD	HL,NLINES+0280H	; lines/page, first ff and type flags
	ELSE	
	LD	HL,NLINES+0200H	; lines/page and type flag
	ENDIF	
;
TYPE1:
	LD	(LNCNT),HL	; save list/type flag and line cnt
	XOR	A		; initialize tab count
	LD	(TABCNT),A	; initialize line and tab count
	CALL	SCANER		; extract filename.typ token
	JP	NZ,NAMERR	; error if any question mark
	CALL	ADVAN		; get pgdflg if it's there
	JR	Z,PGDON	 	; jump if no more on cmd line
	XOR	PGDFLG		; change page flag?
	JR	NZ,PGDON	; no
	INC	DE		; step over pgdflg
	LD	(CIBPTR),DE	; and save cmd buffer pointer
	DEC	A		; no page flag is 0ffh
	LD	(LNCNT),A	; save flag
PGDON:
	CALL	ULOGIN		; log any user
	CALL	OPENF		; open selected file
	JR	Z,TYPE3		; abort if error
	CALL	CRLF		; new line
TYPE2:
	CALL	READF		; read next block
	JR	Z,TYPE4		; read ok (A register is zero)
	DEC	A		; error or eof?
	RET	Z		; eof
TYPE3:
	JP	PRNNF		; error
CHK4LF:
	LD	A,(LNCNT)	; get line count (just in case)
	DJNZ	CHK4VT		; not lf, try vertical tab
	RES	7,A		; reset first ff flag (if any)
	CP	07FH	 	; paging off?
	JR	Z,CHK4VT	; yes
	DEC	A		; time to page?
	JR	Z,CHKFF		; yes!
CHK4VT:
	DEC	B		; step over vt
CHK4FF:
	DJNZ	CHK4CR		; not ff, try vt
	BIT	7,A		; first ff?
	JR	NZ,NXTCHR	; yes, ignore
CHKFF:
	LD	A,(TYPLST)
	BIT	0,A		; type or list?
	LD	E,FF		; load ff into character reg
	LD	A,NLINEP	; reset list count
	JR	NZ,CHK4CR	; list
CHKFF1:
	LD	C,06H		; direct console i/o
	LD	E,0FFH		; conditional console input
	CALL	BDOSJP
	JR	Z,CHKFF1	; no character yet
	CALL	CHKETX		; check for ^C
	LD	A,NLINES	; type line count
	LD	E,LF
CHK4CR:
	LD	(LNCNT),A	; save line count
	CALL	PAGER		; output character
	DJNZ	NXTCHR		; not cr
	LD	(HL),B		; reset tab count
NXTCHR:
	LD	A,(CHRCNT)	; get buffer pointer
	INC	A		; step to next character
	CP	128		; end-of-buffer?
	JR	NC,TYPE2	; yes, read next buffer
TYPE4:
	LD	(CHRCNT),A	; save buffer count
	LD	HL,TBUFF	; point to buffer
	CALL	ADDAH		; compute address of next character
	LD	A,(HL)		; get character to accumulator
	AND	7FH		; mask out msb
	CP	1AH		; end-of-file (^Z)?
	RET	Z		; yes, restart zcpr
	LD	HL,TABCNT	; pointer to tab counter
	LD	E,A		; save character in e reg
	SUB	BS		; backspace?
	LD	B,A		; in case not bs
	JR	NZ,CHK4HT	; not bs
	DEC	(HL)		; step tab count and fall thru
CHK4HT:
	DJNZ	CHK4LF		; no, check for line feed
CHKHT:
	LD	E,' '		; load space into bdos character reg
	CALL	PAGER		; print space
	LD	A,(HL)		; now in col 0 mod 8?
	AND	07H
	JR	NZ,CHKHT	; go for more
	JR	NXTCHR
PAGER:
	CALL	BREAK		; check for abort
	LD	A,(TYPLST)	; get list/type flag
	LD	C,A
;
	IF	TEST OR NOT NOSTAT
	AND	00000010B	; list?
	EXX			; save registers
	CALL	Z,LISTST	; check busy
	EXX			; restore registers
	AND	A
	JR	Z,PAGER		; printer not ready
	ENDIF
;
	LD	A,E		; check for printing character
	CP	' '
	JR	C,PAGE2		; control character, don't count
	INC	(HL)		; step position
PAGE2:
	JP	BDOSJP		; return via bdos
;
;Section 5H
;Command: PAGE
;Function: To eject a page on list device via a form feed.
;Forms:
;	PAGE
;
EJECT:
	CALL	BREAK		; check for ^C
;
	IF	TEST OR NOT NOSTAT
	CALL	LISTST		; check printer ready
	AND	A
	JR	Z,EJECT	 	; not ready yet
	ENDIF
;
	LD	E,FF		; now for form feed
	LD	C,05H		; list output
	JP	BDOS		; output character and return via bdos
;
;Section 5I
;Command: SAVE
;Function: To save the contents of TPA onto disk as a file. Number of
;	     pages or records is in decimal. Saved area begins at 100H.
;Forms:
;	SAVE <Number of Pages> <ufn>
;	SAVE <Number of Records> <ufn> R
;
SAVE:
	CALL	NUMBER		;EXTRACT NUMBER FROM COMMAND LINE
	PUSH	HL		;SAVE IT
	CALL	SCANER		;EXTRACT FILENAME.TYP
	JP	NZ,NAMERR	;MUST BE NO '?' IN IT
	CALL	ULOGIN		;LOG ANY USER
	CALL	ERA2		;DELETE FILE IF POSSIBLE
	CALL	CREATE		;CREATE NEW FILE
	JR	Z,SAVE4		;UNSUCCESSFUL
	XOR	A		;SET RECORD COUNT FIELD OF NEW FILE'S FCB
	LD	(FCBCR),A
	CALL	ADVAN		;LOOK FOR RECORD OPTION
	INC	DE		;POINT TO TOKEN
	POP	HL		;GET BACK PAGE COUNT
	CP	RECFLG
	JR	Z,SAVE1
	DEC	DE		;NO TOKEN, SO BACK UP
	ADD	HL,HL		;DOUBLE IT FOR HL=RECORD (128 BYTES) COUNT
SAVE1:
	LD	(CIBPTR),DE	;SET POINTER TO BAD TOKEN OR AFTER GOOD TOKEN
	LD	DE,TPA		;POINT TO START OF SAVE AREA (TPA)
SAVE2:
	LD	A,H		;DONE WITH SAVE?
	OR	L		;HL=0 IF SO
	JR	NZ,SAVE3
	LD	DE,FCBDN	;CLOSE SAVED FILE
	JP	CLOSE		;AND RESTART CPR
SAVE3:
	DEC	HL		;COUNT DOWN ON RECORDS
	PUSH	HL		;SAVE POINTER TO BLOCK TO SAVE
	CALL	DMASET		;SET DMA ADDRESS FOR WRITE (ADDRESS IN DE)
	LD	HL,128		;128 BYTES PER RECORD
	ADD	HL,DE		;POINT TO NEXT RECORD
	LD	DE,FCBDN	;WRITE RECORD
	CALL	WRITE
	EX	DE,HL		;GET POINTER TO NEXT RECORD IN DE
	POP	HL		;GET RECORD COUNT
	JR	Z,SAVE2		;NO WRITE ERROR
SAVE4:
	JP	PRNLE		;PRINT 'NO SPACE' ERROR
;
;Section 5J
;Command: REN
;Function: To change the name of an existing file.
;Forms:
;	REN <newufn>=<oldufn>
;
REN:
	LD	HL,FCBDN+16	;PLACE FILENAME IN SECOND HALF OF FCB
	PUSH	HL		;SAVE POINTER FOR SEARCH FIRST
	CALL	SCAN1		;EXTRACT FILE NAME
	JR	NZ,NAMERR	;ERROR IF ANY '?' IN IT
	CALL	ADVAN		;ADVANCE CIBPTR
	CP	'='		;'=' OK
	JP	NZ,ERROR
	EX	DE,HL		;POINT TO CHARACTER AFTER '=' IN HL
	INC	HL
	LD	(CIBPTR),HL	;SAVE POINTER TO OLD FILE NAME
	CALL	SCANER		;EXTRACT FILENAME.TYP TOKEN
	JR	NZ,NAMERR	;ERROR IF ANY '?'
	LD	A,(FCBDN+16+13)	;GET POSSIBLE USER NUMBER
	CALL	ALOGIN		;LOG ANY USER
	POP	DE	 	;GET POINTER FOR SEARCH FIRST
	CALL	SEARDE		;CHECK FOR NONE OF THAT NAME
	JR	Z,REN1	 	;NO FILE EXISTS
	CALL	PRINTC		;DUPLICATE NAME
	DC	'Delete'
	CALL	REPLY1		;GET REPLY
	JR	NZ,REN2		;NOT A 'Y'
	CALL	DELETE		;DELETE DUPLICATE
REN1:
	LD	A,(DE)		;GET POSSIBLE DRIVE
	LD	DE,FCBDN	;POINT TO FCB
	LD	(DE),A		;SAVE POSSIBLE DRIVE
	LD	C,17H		;BDOS RENAME FCT
	CALL	BDOSFN
	JP	CHKFND		;CHECK FOR FILE FOUND
NAMERR:
	CALL	PRINTC
	DC	'Name Error'
REN2:
	JP	ABORT
;
;Section 5K
;Command: USER
;Function: To change current user number; new user number is in decimal.
;Forms:
;	USER <usrnum>
;
USER:
	CALL	USRNUM		;EXTRACT USER NUMBER FROM COMMAND LINE
	JP	NEWUSR		;SET NEW USER NUMBER
;
;Section 5L
;Command: DFU
;Function: To set the Default User Number for the command/file scanner; new
;	     default user number is in decimal.
;Forms:
;	DFU <usrnum>
;
DFU:
	CALL	USRNUM		;GET USER NUMBER
	LD	(DFUSR),A	;PUT IT AWAY
	RET
;
;Section 5M
;Command: SCL
;Function: To force ZCPR to parse only a single command per line; reset
;	     to multiple command format at the next ^C.
;Forms:
;	SCL
;
	IF	MULTPL
SINGLE:
	LD	HL,NEWCMD	; point at current command separator
	LD	A,CMDCHR	; get default command separator
	XOR	(HL)		; flip current separator
	LD	(HL),A		; save new command separator
	RET
	ENDIF
;
;
;Section 5N
;Command: PEEK
;Function: To display hex values beginning at a specified address.
;Forms:
;	PEEK <hexadr> [<hexcnt>]
;
PEEK:
	CALL	HEXNUM		; get display address
	PUSH	HL		; save it
	CALL	HEXNUM		; get optional count
	LD	C,L		; save count
	POP	HL		; get back address
PEEK1:
	CALL	CRLF		; start new line
	CALL	PRHEXW		; print address
	CALL	PRINT		; space over
	DC	' '
	LD	B,16		; 16 values per line
PEEK2:
;	CALL	PRINT		; space over
;	DC	' '
	LD	A,(HL)		; get hex value
	INC	HL		; step to next value
	CALL	PRHEXA		; display value
	DEC	C		; done?
	RET	Z		; yes
	DJNZ	PEEK2		; not end of line
	JR	PEEK1		; end of line
PRHEXW:
	LD	A,H		; print hex word in hl
	CALL	PRHEXA
	LD	A,L
PRHEXA:
	PUSH	AF		; save right nibble
	RRCA			; move left nibble to right
	RRCA
	RRCA
	RRCA
	CALL	PRHEX		; display left nibble
	POP	AF		; get back right nibble
PRHEX:
	AND	0FH		; convert to ascii
	ADD	A,90H
	DAA
	ADC	A,40H
	DAA
	JP	CONOUT		; go display value
;
;
;Section 5O
;Command: POKE
;Function: To poke a string of hex values into a set of consecutive addresses.
;Forms:
;	POKE <hexadr> <hexval> [<hexval>]
;
POKE:
	CALL	HEXNUM		; get address
POKE1:
	PUSH	HL		; save address
	CALL	HEXNUM		; get next byte
	LD	A,(FCBFN)	; done?
	CP	' '
	LD	A,L		; save byte
	POP	HL		; get back address
	RET	Z		; done
	LD	(HL),A		; save byte
	INC	HL		; step to next address
	JR	POKE1		; go for more
;
;
;Section 5P
;Command: JUMP
;Function: To call the program (subroutine) at the specified address
;	     without loading from disk.
;Forms:
;	JUMP <hexadr> <command tail>
;
JUMP:
	CALL	HEXNUM		;GET LOAD ADDRESS IN HL
	JR	CLLPRG		;PERFORM CALL
;
;Section 5Q
;Command: COM file processing
;Function: To load the specified COM file from disk and execute it.
;Forms:
;	<command> <command tail>
;
COM:
	LD	HL,FCBFT	;FILE TYPE MUST BE BLANK
	LD	A,(HL)
	CP	' '
	JP	NZ,ERROR
	LD	(HL),'C'	;PLACE DEFAULT FILE TYPE (COM) INTO FCB
	INC	HL		;COPY INTO FILE TYPE
	LD	(HL),'M'	;3 BYTES
	INC	HL
	LD	(HL),'6'
	LD	HL,TPA		;SET EXECUTION/LOAD ADDRESS
	CALL	MEMLD		;LOAD MEMORY WITH FILE SPECIFIED
			 	;(NO RETURN IF ERROR OR TOO BIG)
;
;Section 5R
;Command: GO
;Function: To call the program in the TPA without loading from disk.
;	     Same as JUMP 100H, but more convenient, especially when
;	     used with parameters for programs like STAT.
;Form:
;	GO <command tail>
;
GO:
	LD	HL,TPA		;ALWAYS TO TPA
;
;
; CLLPRG IS THE ENTRY POINT FOR THE EXECUTION OF THE LOADED PROGRAM
;   ON ENTRY TO THIS ROUTINE, HL MUST CONTAIN THE EXECUTION
;   ADDRESS OF THE PROGRAM (SUBROUTINE) TO EXECUTE
;
CLLPRG:
	PUSH	HL		;SAVE EXECUTION ADDRESS
	LD	HL,(CIBPTR)	;SAVE THE COMMAND TAIL START ADDRESS
	PUSH	HL
	LD	HL,TFCB		;MAKE FCB FOR PROGRAM
	CALL	SCAN1		;SEARCH COMMAND LINE FOR NEXT TOKEN
	LD	HL,TFCB+16	;OFFSET FOR 2ND FILE SPEC
	CALL	SCAN1		;SCAN FOR IT AND LOAD IT INTO FCBDN+16
	XOR	A
	LD	(TFCB+32),A	;ZERO RECORD COUNT
;
; LOAD COMMAND LINE INTO TBUFF
;
	POP	HL		;GET LOCATION OF COMMAND TAIL
NEWCMD	EQU	$+1		;IN-LINE COMMAND SEPARATOR
	LD	BC,CMDCHR+0FF00H;INITIALIZE COUNT AND GET COMMAND FLAG
	LD	DE,TBUFF	;DESTINATION FOR COMMAND TAIL
COM2:
	INC	DE		;POINT TO DESTINATION
	INC	B		;INCREMENT CHARACTER COUNT
	LD	A,(HL)		;COPY CHARACTER TO TBUFF
	LD	(DE),A
	INC	HL		;STEP TO NEXT SOURCE CHARACTER
	OR	A		;END OF LINE?
;
	IF	MULTPL
	JR	Z,COM3		;YES, END OF LINE
	XOR	C		;START OF NEXT COMMAND?
	JR	NZ,COM2		;NO
	LD	(DE),A		;0 TERMINATE STRING
COM3:
;
	ELSE
;
	JR	NZ,COM2		;NOT END OF LINE
	ENDIF
;
	LD	A,B		;SAVE CHARACTER COUNT
	LD	(TBUFF),A
	DEC	HL		;BACK UP ONE CHARACTER
	LD	(CIBPTR),HL	;SAVE FOR START OF NEXT COMMAND SCAN
;
; RUN LOADED TRANSIENT PROGRAM
;
	CALL	CRLF		;NEW LINE
	CALL	DEFDMA		;SET DMA TO 0080
	CALL	RSTUSR		;RESET TO PROPER USER NUMBER
;
; EXECUTION (CALL) OF PROGRAM (SUBROUTINE) OCCURS HERE
;
	RET			;CALL TRANSIENT
;
;Section 5S
;Command: GET
;Function: To load the specified file from disk to the specified address
;Forms:
;	GET <hexadr> <ufn> Load the specified file at the specified page;
;
GET:
	CALL	HEXNUM		;GET LOAD ADDRESS IN HL
	PUSH	HL		;SAVE ADDRESS
	CALL	SCANER		;GET FILE NAME
	POP	HL		;RESTORE ADDRESS
	JP	NZ,NAMERR	;MUST BE UNAMBIGUOUS
;
; LOAD MEMORY WITH COMMAND LINE FILE 
;   ON INPUT, HL CONTAINS STARTING ADDRESS TO LOAD
;   IF COM FILE TOO BIG, EXIT TO ERROR.
;
MEMLD:
	LD	(LDADR),HL	;SET LOAD ADDRESS
;
;   MLA is a reentry point for a non-standard CP/M Modification
; This is the return point when the .COM (or GET) file is not found the
; first time, the Default User is selected for the second attempt
; and Drive A is selected for the final attempt.
;
MLA:
	CALL	ULOGIN		;LOG ANY USER
	LD	HL,(FCBS1)	;SAVE ANY USER NUMBER
	CALL	OPENF		;OPEN COMMAND.COM FILE
	JR	NZ,MLA1		;FILE FOUND - LOAD IT
;
; FILE NOT FOUND - SELECT DEFAULT USER
;
	LD	A,L	 	;GET FCB USER
	AND	A		;DEFAULT USER?
	JR	NZ,MLA0		;NO
	LD	HL,TMPUSR	;CURRENT USER SAME AS DEFAULT?
	LD	A,(DFUSR)	;GET DEFAULT USER
	CP	(HL)
	SET	7,A		;MAKE INTO VALID USER NUMBER
	LD	(FCBS1),A	;PUT USER INTO FCB
	JR	NZ,MLA		;AND TRY AGAIN
;
; FILE NOT FOUND - SELECT DRIVE A IF DEFAULT WAS SOME OTHER DRIVE
;
MLA0:
	LD	A,(TDRIVE)	;DRIVE A DEFAULT?
	AND	A
	JR	Z,MLA3	 	;YES, ERROR
	XOR	A
	LD	HL,FCBDN	;POINT AT DRIVE IN FCB
	OR	(HL)		;DRIVE ALREADY SPECIFIED?
	LD	(HL),1		;SELECT DRIVE A
	JR	Z,MLA		;NO, GO GIVE IT A TRY
MLA3:
	CALL	PRNNF		;CAN'T FIND FILE
	JR	PRNLE1
;
; FILE FOUND -- PROCEED WITH LOAD
;
MLA1:
	LD	HL,(LDADR)	;GET START ADDRESS OF MEMORY LOAD
MLA2:
	LD	A,ENTRY/256-1	;GET HIGH-ORDER ADR OF JUST BELOW CPR
	CP	H		;ARE WE GOING TO OVERWRITE THE CPR?
	JR	C,PRNLE		;ERROR IF SO
	EX	DE,HL		;MOVE LOAD ADDRES FOR DMASET
	CALL	DMASET		;SET DMA ADDRESS
	LD	HL,128		;COMPUTE NEXT LOAD ADDRESS
	ADD	HL,DE		;AND SAVE ANSWER IN HL
	CALL	READF		;READ NEXT RECORD
	JR	Z,MLA2		;READ ERROR OR EOF?
	DEC	A		;LOAD COMPLETE
	JP	Z,RSTUSR	;GO RESET CORRECT USER
;
; LOAD ERROR
;
PRNLE:
	CALL	PRINTC
	DC	'Full'
PRNLE1:
	JP	ABORT
;
	IF	(($-ENTRY) GT ZCPRSZ)
	*ZCPR too large!!*
	ENDIF
;
	IF	TEST
LISTST:
	LD	A,2DH		;COMPUTE LIST STATUS ENTRY
	DEFB	0FEH		;SKIP NEXT BYTE
BOOT:
	XOR	A		;COMPUTE BOOT ENTRY
	LD	HL,(BASE+1)	;GET PAGE ADDRESS OF BIOS
	LD	L,A		;ADD ENTRY
	JP	(HL)		;GO TO BIOS ROUTINE
	ENDIF

ENDLD	EQU	$

	END	

