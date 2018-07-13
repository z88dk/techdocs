;============================================================================
;	MZ-2500 IOCS (SVC call)
;============================================================================

SVC	MACRO
	RST	18h
	DB	%1
	ENDM

;----------------------------------------------------------------------------
;	Parameter passing area
;----------------------------------------------------------------------------
KEYBUF	EQU	0A01h	; 0A01h-0B0Fh
BUF2	EQU	0B10h	; 0B10h-0C1Fh
BUF3	EQU	0C20h	; 0C20h-0CBFh
BUF4	EQU	0CC0h	; 0CC0h-0DBFh
DIRARE	EQU	1000h	; 1000h-17FFh
SVCCW	EQU	0CC0h	; 0CC0h-0CECh

KCTRLS	EQU	05D2h
CURSW	EQU	05D3h
CURX	EQU	05E2h
CURY	EQU	05E3h
CURXST	EQU	05E4h
CURYST	EQU	05E5h
CURXED	EQU	05E6h
CURYED	EQU	05E7h
CURCOL	EQU	05E8h
CURLIN	EQU	05E9h
INSMOD	EQU	05EAh
CURTXT	EQU	05ECh
SCROLL	EQU	05EDh
DSPSA	EQU	05EFh	;word
COLORA	EQU	05F4h
CHRATR	EQU	05F5h
DSPMOD	EQU	05F8h
CURBGC	EQU	05F9h	;word
DSPSL	EQU	05FBh	;word
DSPEL	EQU	05FDh	;word
DSPSC	EQU	05FFh
DSPEC	EQU	0600h
TABTBL	EQU	0602h	;byte[10]
KANJI	EQU	060Ch
FKLIST	EQU	060Dh
FNTSEL	EQU	0610h
KANKAN	EQU	0613h
IE_KEY	EQU	0680h
IE_STO	EQU	0694h
IE_HEL	EQU	0694h
IE_COM	EQU	0696h
IE_MOU	EQU	0698h
IE_TIM	EQU	069Dh
IE_ITV	EQU	069Eh
IE_PLA	EQU	069Fh
I_MSTR	EQU	06A2h

;----------------------------------------------------------------------------
;	Printer ・ File ・ Key input ・ OPN
;----------------------------------------------------------------------------

;----------------------------------------------------------------------------
; MONOP
; MONITOR ・ ENTER MODE
; IN :	Nothing
; OUT:	Nothing
; DES:	(all)
;
_MONOP	EQU	00h

;----------------------------------------------------------------------------
; CR1
; Newline
; IN :	Nothing
; OUT:	Nothing
; DES:	IY
;
_CR1	EQU	01h

;----------------------------------------------------------------------------
; CR2
; Newline if it is not at the beginning of the line
; IN :	Nothing
; OUT:	Nothing
; DES:	IY
;
_CR2	EQU	02h

;----------------------------------------------------------------------------
; CRT1C
; Output 1 character to CRT
; IN :	A = Character code
; OUT:	(nothing)
; DES:	IY
;
_CRT1C	EQU	03h

;----------------------------------------------------------------------------
; CRT1X
; Do not execute control code when using CRT1C
; IN :	(nothing)
; OUT:	(nothing)
; DES:	IY
;
_CRT1X	EQU	04h

;----------------------------------------------------------------------------
; CRTMSG
; Output character string to CRT
; IN :	DE = ASCIIZ character string address
; OUT:	(nothing)
; DES:	AF, IY
;
_CRTMSG	EQU	05h

;----------------------------------------------------------------------------
; LPTOT
; Send one character to the PRINTER, no code conversion
; IN :	A = output data
; OUT:	(nothing)
; DES:	(all)
;
_LPTOT	EQU	06h

;----------------------------------------------------------------------------
; LPT1C
; Send one character to the PRINTER, perform code conversion according to the type of printer
; IN :	A = output data
; OUT:	(nothing)
; DES:	(all)
;
_LPT1C	EQU	07h

;----------------------------------------------------------------------------
; DISP
; Display characters at specified position
; Internal IOCS call, not for users
; IN :	A = data
;	H = horizontal position
;	L = vertical position
; OUT:	(nothing)
; DES:	(all)
;
_DISP	EQU	08h

_TERM	EQU	09h

;----------------------------------------------------------------------------
; GETL
; Input a whole text line from the keyboard
; IN :	DE = Buffer address
; OUT:	Cy = 1 : SHIFT+BREAK was pressed
;
; DES:	all but BC, HL
;
_GETL	EQU	0Ch

;----------------------------------------------------------------------------
; INKEY
; Get one character from the keyboard
; IN :	A[Bit0] = 0 : If the key is not pressed return with Zf = 1
;		= 1 : Wait until the key is pressed
;	A[Bit1] = 0 : Do not expand function keys
;		= 1 : Expand function keys
;	A[Bit2] = 0 : Kana-Kanji conversion is not performed
;		= 1 : Perform Kana-Kanji conversion
;	A[Bit3] = 0 : "ARGO" key ・ The COPY key sets only the flag
;		= 1 : "ARGO" key ・ Execute the function of the COPY key
; OUT:	Zf = 1 : No key pressed
;	   = 0 :
;		[In case of normal key]
;		  B         = ASCII code
;		  C[Bit7]   = 0
;		  C[Bit6-0] = key mode
;		[For special keys]
;		  B         = key code
;		  C[Bit7]   = 1
;		  C[Bit6-0] = key mode
;
; DES:	all but HL, DE
;
_INKEY	EQU	0Dh

;----------------------------------------------------------------------------
; BRKEY
; Check if SHIFT + BREAK is pressed
; IN :	(nothing)
; OUT:	If it is pressed Zf=1, Cy=1
; DES:	AF
;
_BREAK	EQU	0Eh

;----------------------------------------------------------------------------
; HALT
; When BREAK is pressed, wait until some key is pressed
; IN :	A[0] = 1
; OUT:	(nothing)
; DES:	AF
;
_HALT	EQU	0Fh

;----------------------------------------------------------------------------
; DI
; Disable interrupt
; IN :	A = 0     : Used when disabling the interrupt for a period between 1ms to 1s
;	  Other than 0 : Used when disabling the interrupt for 1s or longer (music wait)
; OUT:	(nothing)
; DES:	AF
;
_DI	EQU	10h

;----------------------------------------------------------------------------
; EI
; Allow interrupts
; IN :	(nothing)
; OUT:	(nothing)
; DES:	AF
;
_EI	EQU	11h

;----------------------------------------------------------------------------
; NEWON
; Detach function from RAM IOCS and release memory
; IN :	A = 0 : Level II (Calculator ・ color simulation etc.)
;	  = 1 : .mouse, .voice
;	  = 2 : .jisho
;	  = 3 : .term, .kkan
;	  = 4 : .cls, .posck, .possv, .pset, .line, .patter, .box,
;		.paint, .circle, .point, .ginit, .view, .scren,
;		.color, .symbl, .hview, .crep, .gput, .gget,
;		.pense, .move, .pri, .cbloc, .crti, .cocnv, .hroll
;	  = 5 : .lptra, .hcpy
; OUT:	(nothing)
; DES:	AF
;
_NEWON	EQU	12h

;----------------------------------------------------------------------------
; DEASC
; Convert ASCII strings to binary
; The corresponding value is a decimal integer(1～65535), $xxxx, &H, &O, &B, &J, &K
; IN :	HL = Address of ASCII character string
; OUT:	DE = Binary data (&J, &K in case of Shift JIS code）
;	HL = The next address of the converted character string
;	Cy = 0 : Successful completion, A = type of numeric value converted to register
;	   = 1 : overflow (A=2) / error (A=3)
;	A  = Type of converted value (in case of normal termination)
;		0Eh:&B     0Fh:&O  10h:&H  11h:$xxxx
;		12h:Decimal number 13h:&J  14h:&K
; DES:	AF, HL, DE
;
_DEASC	EQU	13h

;----------------------------------------------------------------------------
; DEHEX
; Convert ASCII string hexadecimal to binary, "$", "&H" not required
; IN :	HL = Address of ASCII character string
; OUT:	DE = Binary data
;	HL = The next address of the converted character string
;	Cy = 1 : Successful completion
;	A  = 2 : Overflow
; DES:	AF, HL, DE
;
_DEHEX	EQU	14h

;----------------------------------------------------------------------------
; CKHEX
; Check if the ASCII code is a hexadecimal character
; IN :	A  = ASCII code
; OUT:	Cy = 0 : The ASCII code is [0-9, A-F, a-f], A returns the value of (00h to 0Fh)
;	Cy = 1 : The ASCII code is not a hexadecimal character
; DES:	AF
;
_CKHEX	EQU	15h

;----------------------------------------------------------------------------
; ASCHL
; Convert an unsigned integer to a decimal ASCII string
; IN :	HL = Binary data (unsigned integer)
;	DE = Buffer address to store the result
;	B  = 0     : Zero suppression
;	   other than 0 : Make the leading '0' a space (result is 5 bytes long)
; OUT:	DE = The address following the stored ASCII character string
; DES:	AF, DE
;
_ASCHL	EQU	16h

;----------------------------------------------------------------------------
; COUNT
; Returns the length of a string
; IN :	DE = String address
; OUT:	B  = String length
; DES:	AF
;
_COUNT	EQU	17h

_KKAN	EQU	18h

;----------------------------------------------------------------------------
; JISHO
; Dictionary ROM conversion, MZ-1R28 required
; IN :	A = Function code
;		0 : Punctuation conversion  -  First candidate retrieval
;		1 : Punctuation conversion  -  Next candidate retrieval
;		2 : Punctuation conversion  -  Retrieve previous candidate
;		3 : People / place name conversion  -  First candidate retrieval
;		4 : People / place name conversion  -  Next candidate retrieval
;		5 : People / place name conversion  -  Retrieve previous candidate
;	(KEYBUF) = Conversion target SHIFT-JIS, maximum 40 bytes
; OUT:	HL       = Number of candidates
;	B        = Presence of dictionary ROM   0: none
;	(KEYBUF) = Conversion result
; DES:	AF
;
_JISHO	EQU	19h

_DIOCS	EQU	1Ah

;----------------------------------------------------------------------------
; ERRX
; Display error message
; IN :	A  = Error code
;	     Bit7 = 1    If set, the device name and file name accessed the last time are also displayed
;
; OUT:	(nothing)
; DES:	(nothing)
;
_ERRX	EQU	1Bh

;----------------------------------------------------------------------------
; KCONV
; Convert Kanji code
; IN :	A  = 0 : Shift JIS  → JIS
;	     1 : JIS        → Shift JIS
;	     2 : Shift JIS  → Zoning code
;	     3 : Zoning code → Shift JIS
;	     4 : Zoning code → JIS
;	     5 : JIS        → Zoning code
; OUT:	HL = Converted Kanji code
;	Cy = 1 : Error (HL=81A6h, return "※")
; DES:	AF
;
_KCONV	EQU	1Ch

_LPTRA	EQU	1Dh

;----------------------------------------------------------------------------
; ?PONT
; Calculate the address of the VRAM from the XY coordinates of the character screen
; IN :	L = X coordinate
;	H = Y coordinate
; OUT:	HL = VRAM address (C000h～C7FFh)
; DES:	(all)
;
_?PONT	EQU	1Eh

_KCALL	EQU	1Fh

;----------------------------------------------------------------------------
; BELL
; Ring the bell (880Hz)
; IN :	(nothing)
; OUT:	(nothing)
; DES:	AF
;
_BELL	EQU	20h

;----------------------------------------------------------------------------
; PLAY
; Play music
; IN :	A  = Channel(0-5)	(Make sure you are not playing at MCTRL)
;	   = FFh : All channels
;	DE = MML address
; OUT:	(nothing)
; DES:	(all)
;
_PLAY	EQU	21h

;----------------------------------------------------------------------------
; SOUND
; Write data to SSG registers
; IN :	B = 0 : Play sound for specified time
;		A = Note (0-95)
;		E = Tone length (0.1s units)
;	B = 1 : Write SSG register
;		A = SSG Register number
;		E = data
; OUT:	(nothing)
; DES:	AF
;
_SOUND	EQU	22h

;----------------------------------------------------------------------------
; MCTRL
; Music performance related control
; IN :	B = 0 :	Initial setting of PSG routine (music init)
;	  = 1 :	Start playing
;	  = 2 : Stop playing
;	  = 3 : Wait until the performance ends if you are playing
;	  = 4 : Check whether it is playing (OUT: playing with Zf = 0)
;	  = 5 : Retrieve sound timbre data
;		A  = Tone number (0-29)
;		DE = Buffer address (29 bytes required)
;	  = 6 : Set user-defined tone color data
;		C  = Channel (0-2)
;		HL = Tone color data address (26 bytes)
;	  = 7 : LFO set / retrieval
;		A = 0 : get
;		  = 1 : set
;		C = Channel (0 - 5)
;		HL = Buffer address (4 bytes)
; OUT:	(nothing)
; DES:	AF
;
_MCTRL	EQU	23h

;----------------------------------------------------------------------------
; PRT1C
; output 1 character to file
; IN :	A = data
; OUT:	(nothing)
; DES:	AF
;
_PRT1C	EQU	26h

;----------------------------------------------------------------------------
; INP1C
; get 1 character from file
; IN :	(nothing)
; OUT:	A = data
;	Cy = 1 (EOF detected)
; DES:	AF
;
_INP1C	EQU	27h

;----------------------------------------------------------------------------
; CLRIO
; Cancel all open files and initialize IOCS
; Kill what is being written
; IN :	(nothing)
; OUT:	(nothing)
; DES:	AF
;
_CLRIO	EQU	28h

;----------------------------------------------------------------------------
; PWD
; Get the path name of the current directory
; IN :	(nothing)
; OUT:	DE = Buffer address for reading path name
;		(Generally, a DIR Area of 1000h - 17FFh is used as a buffer)
;	B  = Length of path name
; DES:	(all)
;
_PWD	EQU	2Ah

;----------------------------------------------------------------------------
; MKDIR
; Call after using DEVNM to make the directory
; IN :	(nothing)
; OUT:	(nothing)
; DES:	AF
;
_MKDIR	EQU	2Bh

;----------------------------------------------------------------------------
; DEVNM
; Interpret device name and directory name
; Use KEYBUF as a string buffer
; IN :	DE = Buffer address storing device name and directory name
;	B  = length
; OUT:	HL = pointer(next)
;	DE = device table
;	A  = channel
; DES:	(all)
;
_DEVNM	EQU	2Ch

;----------------------------------------------------------------------------
; DEVFN
; Interpret device name, directory name and file name
; Use KEYBUF as a string buffer
; IN :	DE = Buffer address storing device name, directory name, file name
;	B  = length
; OUT:	(nothing)
; DES:	(all)
;
_DEVFN	EQU	2Dh

;----------------------------------------------------------------------------
; LUCHK
; Specify the logical-unit-number (lu) to be used next
; When using multiple lu, it is necessary to call each time lu changes
; IN :	A  = lu
; OUT:	A  = 1 : It is opened as a READ file
;	   = 2 : It is opened as a WRITE file
;	   = 4 : It is opened as a RANDOM file
;	Cy = 1 : It is not open
; DES:	AF
;
_LUCHK	EQU	2Eh

;----------------------------------------------------------------------------
; LOPEN
; Open the file for reading
; Call after calling DEVFN
; Openable files are BTX, OBJ only
; IN :	(nothing)
; OUT:	(nothing)
; DES:	(all)
;
_LOPEN	EQU	2Fh

;----------------------------------------------------------------------------
; LOADF
; Load OBJ, BTX file
; Call after calling DEVNM
; IN :	HL = Load address
; OUT:	(nothing)
; DES:	(all)
;
_LOADF	EQU	30h

;----------------------------------------------------------------------------
; SAVEF
; Save the file
; Call after calling DEVNM
; IN :	DE = Save start address
;	A  = 0    : Create files only ・ Do not save
;	   other than 0:   Create and save a file
;	MLMD20,21 = Save length
;	MLMD22,23 = Load address
;	MLMD24,25 = Execution address
; OUT:	(nothing)
; DES:	(all)
;
_SAVEF	EQU	31h

;----------------------------------------------------------------------------
; RWOPN
; Open a file
; Call after calling DEVNM
; IN :	A = Logical Unit Number
;	D = 01h : Opening the file in READ mode
;	  = 02h : Opening the file in WRITE mode
;	  = 04h : Opening the file in RANDOM ACCESS mode
;	  = 10h : Opening the file in APPEND mode
;	E = field/32-1 (Only for RANDOM file open)
; OUT:	(nothing) (Other than RANDOM file)
;	In case of RANDOM file
;	  Zf = 1 : new file
;	     = 0 : file exist
; DES:	AF
;
_RWOPN	EQU	33h

;----------------------------------------------------------------------------
; BGETL
; Get a text line at the current cursor position
; Everything else is like GETL
; IN :	(nothing)
; OUT:	DE = Buffer address
; DES:	all but BC, HL
;
_BGETL	EQU	34h

;----------------------------------------------------------------------------
; INMSG
; Enter 1 text line from file (terminating with 0Dh).  The trailing 0Dh is removed
; Call after calling DEVNM
; IN :	DE = Input buffer address
; OUT:	B  = length
;	Cy = 1 : EOF
; DES:	all but DE, HL
;
_INMSG	EQU	35h

;----------------------------------------------------------------------------
; UNPUT
; Return data read from file back to file
; Only 1 byte is possible
; IN :	A = return data
; OUT:	(nothing)
; DES:	AF
;
_UNPUT	EQU	36h

;----------------------------------------------------------------------------
; PRSTR
; Output n bytes of data to file
; IN :	DE = Data address
;	B  = Data length
; OUT:	(nothing)
; DES:	AF
;
_PRSTR	EQU	37h

;----------------------------------------------------------------------------
; CLKL
; File CLOSE / KILL
; IN :	A = 0    : Close / kill all currently open files
;	  Other than 0: Close / kill the file of Logical Unit specified by A
;	B = 0    : KILL
;	  Other than 0: CLOSE
; OUT:	(nothing)
; DES:	AF
;
_CLKL	EQU	38h

;----------------------------------------------------------------------------
; DIR
; Read contents of directory into directory buffer ・ Output to CRT / LPT
; Call after calling DEVNM
; IN :	A = 0 : Read the directory from 1000h to 17FFh and process wildcard characters and sort
;		DE = File name (may include wildcard *,?)
;		B  = File name length
;	A = Other than 0: Output directory to Logical Unit specified by A
;		88h : CRT
;		89h : LPT
; OUT:	(nothing)
; DES:	AF
;
_DIR	EQU	39h

;----------------------------------------------------------------------------
; CHDIR
; Change directory
; Call after calling DEVNM
; IN :	(nothing)
; OUT:	(nothing)
; DES:	(nothing)
;
_CHDIR	EQU	3Ah

;----------------------------------------------------------------------------
; FINIT
; Equivalent to BASIC's init command
; Call after calling DEVNM
; IN :	(nothing)
; OUT:	(nothing)
; DES:	(all)
;
_FINIT	EQU	3Ch

;----------------------------------------------------------------------------
; DELET
; Equivalent to BASIC delete / rmdir command
; Call after calling DEVNM
; IN :	Cy = 0 : detele
;	   = 1 : rmdir
; OUT:	(nothing)
; DES:	AF
;
_DELET	EQU	3Dh

;----------------------------------------------------------------------------
; RENAM
; Change the file name
; Call after calling DEVNM
; IN :	DE = Address of new file name
;	B  = New file name length
; OUT:	(nothing)
; DES:	AF
;
_RENAM	EQU	3Eh

;----------------------------------------------------------------------------
; LOCK
; Protect/Unprotect file, check file protection status
; Call after calling DEVNM
; IN :	A = 00h : Unprotect
;	  = 01h : Protect file
;	  = FFh : Check file protection status
;		Cy = 1        : file not found
;		   = 0, A = 0 : unlocked
;		   = 0, A = 1 : locked
; OUT:	(nothing)
; DES:	AF
;
_LOCK	EQU	3Fh

;----------------------------------------------------------------------------
; BRD
; Accessing random files
; IN :	A = 0 : Set the next record number to be read / written
;		Use this number for the following A = 1 to 4 calls
;		This number is autoincremented
;		DE = record number
;	A = 1, DE = other than 0:
;		Read 1 record and store it at the address indicated by DE
;		B holds the length
;		Equivalent to BASIC input#
;	A = 1, DE = 0:
;		Read one record and store it in field-buffer
;		Equivalent to BASIC get#
;	A = 2, Other than DE = 0:
;		'print' to file from DE to B
;		Equivalent to BASIC print#
;	A = 2, DE = 0:
;		Output field-buffer to file
;		Equivalent to BASIC put#
;	A = 3:
;		Extract data from field buffer
;		DE = Read address
;		B  = Offset (indicating the number of bytes in the field)
;		C  = Read length
;		L  = File number
;	A = 4:
;		Set data in field buffer
;		Equivalent to BASIC lset/rset
;		The other input registers are the same as in the case of A = 3
;	A = 5:
;		Enter data from field collectively
;		Used with gload etc.
;		HL = load address
;		D  = Read/write size / 256  Specify 1, 2, 4, 8, or 16
;		Specify E = 0
;		BC = position from the beginning of the file (in bytes) / 256
;		     This value must be a multiple of D reg.
;	A = 6:
;		Output data to file collectively
;		Used with gsave etc.
;		The other input registers are the same as in the case of A = 5
; DES:	(all)
;
_BRD	EQU	40h

;----------------------------------------------------------------------------
; FFUNC
; Equivalent to BASIC functions  LOC / LOF / FPOS
; Call after calling LUCHK
; IN :	A = 0 : BC = LOC
;	A = 1 : BC = LOF
;	A = 2 : BC = FPOS
;	A = 3 : BC = Number of characters output after outputting CR (file)
;		     Current position of the cursor (CRT)
;		     Printer head position (LPT)
; OUT:	BC
; DES:	all but DE, HL
;
_FFUNC	EQU	41h

;----------------------------------------------------------------------------
; DEFNC
; Input and output of files in record units
; Call after calling DEVNM
; IN :	A = 0 : Ask for free size
;		Cy = 0 : Free size (K bytes) is output to DE
;		   = 1 : Do not execute
;	A = 1 : Input by record units
;		HL = Read address
;		DE = Byte size
;		BC = Read start block number
;	A = 1 : Output by record units
;		HL = Address of write data
;		DE = Byte size
;		BC = Write start block number
; DES:	AF
;
_DFUNC	EQU	42h

_ERCVR	EQU	43h

;----------------------------------------------------------------------------
; SWAP
; Exchange and restore text files
; IN :	A = 0 : Text file exchange
;		DE = First address of text to save
;		HL = Save length
;	A = FFh : Restore text file
; OUT:	(nothing)
; DES:	(all)
;
_SWAP	EQU	44h

;----------------------------------------------------------------------------
; CLS
; Clear graphic screen with back color
; IN :	A = Back color
; OUT:	(nothing)
; DES:	(all)
;
_CLS	EQU	45h

;----------------------------------------------------------------------------
; POSCK
; Check if the specified coordinates are in the view port on the graphic screen
; IN :	(HL  ).w = X coordinate
;	(HL+2).w = Y coordinate
; OUT:	(nothing) (Error when out of range)
; DES:	(all)
;
_POSCK	EQU	46h

;----------------------------------------------------------------------------
; POSSV
; Coordinate set/get
; IN :	Cy = 0 : Set coordinates
;		  (HL  ).w = X coordinate
;		  (HL+2).w = Y coordinate
;	Cy = 1 : Reading coordinates
; OUT:	DE = X coordinate
;	HL = Y coordinate
; DES:	(all)
;
_POSSV	EQU	47h

;----------------------------------------------------------------------------
; PSET
; Draw a point on the graphic screen
; IN :	(HL  )   = Color code
;	(HL+1)   = Drawing function
;	(HL+2).w = X coordinate
;	(HL+4).w = Y coordinate
; OUT:	(nothing)
; DES:	(all)
;
_PSET	EQU	48h

;----------------------------------------------------------------------------
; LINE
; Draw a line on the graphic screen
; IN :	(HL  )   = Color code
;	(HL+1)   = Drawing function
;	(HL+2).w = Starting point X coordinate
;	(HL+4).w = Starting point Y coordinate
;	(HL+6).w = End point X coordinate
;	(HL+8).w = End point Y coordinate
;	(HL+10)  = Line mode
;		    Bit0 = 0 : solid line
;			 = 1 : Line style
;		    Bit1 = 0 : New line style
;			 = 1 : Previous line style
;	(HL+11).w = Line style
; OUT:	(nothing)
; DES:	(all)
;
_LINE	EQU	49h

;----------------------------------------------------------------------------
; PATTR
; Draw a pattern on the graphic screen
; IN :	(HL  )   = Color code
;	(HL+1)   = Drawing function
;	(HL+2)   = Back color
;	(HL+3)   = String length
;	(HL+4).w = String address
;	(HL+6)   = Direction 0:Up 1:Down
;	(HL+7)   = height
; OUT:	(nothing)
; DES:	(all)
;
_PATTR	EQU	4Ah

;----------------------------------------------------------------------------
; LINE
; Draw a rectangle on the graphic screen
; IN :	(HL  )   = Color code
;	(HL+1)   = Drawing function
;	(HL+2).w = Start point X coordinate
;	(HL+4).w = Start point Y coordinate
;	(HL+6).w = End point X coordinate
;	(HL+8).w = End point Y coordinate
;	(HL+10)  = Line mode
;		    0 : Draw a frame with a solid line
;		    1 : Draw a frame with line style
;		    2 : Fill rectangle with specified color
;		    3 : Fill rectangle with tile pattern
;	(HL+11).w = Line style or tile pattern address
;	(HL+13)   = Number of bytes of tile pattern
; OUT:	(nothing)
; DES:	(all)
;
_BOX	EQU	4Bh

;----------------------------------------------------------------------------
; LINE
; Fill the closed area on the graphic screen
; IN :	(HL  ).w = Start X coordinate
;	(HL+2).w = Start Y coordinate
;	(HL+4).w = Boundary color address
;	(HL+6)   = Number of boundary colors 'not' mode in case of FFh
;	(HL+7)   = 0 : Fill with specified color		(HL+9) = Color
;		 = 1 : Fill with tile pattern
;			(HL+8).w = Tile pattern address
;			(HL+10)  = Number of bytes of tile pattern
; OUT:	(nothing)
; DES:	(all)
;
_PAINT	EQU	4Ch

;----------------------------------------------------------------------------
; CIRCL
; Draw a circle on the graphic screen
; IN :	(HL  )   = Color code
;	(HL+1)   = Drawing function
;	(HL+2).w = Center X coordinate
;	(HL+4).w = Center y coordinate
;	(HL+6).w = radius
;	(HL+8)   = String drawing flag
;		    Bit0 = 0 : Do not draw a string between the starting point and the center
;			 = 1 : Draw a string between the starting point and the center
;		    Bit1 = 0 : Do not draw a string between the end point and the center
;			 = 1 : Draw a string between the end point and the center
;	(HL+ 9).f = Start angle (single precision)
;	(HL+14).f = End angle (single precision)
;	(HL+19).f = Ratio (single precision)
; OUT:	(nothing)
; DES:	(all)
;
_CIRCL	EQU	4Dh

_POINT	EQU	4Eh

_HCPY	EQU	4Fh

_DFKEY	EQU	50h

;----------------------------------------------------------------------------
; GINIT
; Perform initialization of screen mode
; IN :	A[Bit5,4] = 00 : 4 color mode
;		  = 01 : 16 color mode
;		  = 1x : 256 color mode
;	A[Bit6]   =  0 : 200 line mode
;		  =  1 : 400 line mode
;	A[Bit7]   =  0 : 320 dot mode
;		  =  1 : 640 dot mode
; OUT:	(nothing)
; DES:	(all)
;
_GINIT	EQU	51h

;----------------------------------------------------------------------------
; VIEW
; Setting the viewport
; IN :	(HL) Bit0 = 0 : Do not erase
;		  = 1 : Perform erase
;	     Bit1 = 0 : Do not draw a frame
;		  = 1 : Draw a frame
;	(HL+1)        : Color to use for erasing
;	(HL+2)	      : Color used to draw frame
;	(HL+3)	      : Function used to draw a frame
;	(HL+4).w      : Leftmost coordinate
;	(HL+6).w      : The coordinates of the upper end
;	(HL+8).w      : The coordinates of the right end
;	(HL+10).w     : The coordinates of the lower end
;	Cy        = 0 : Viewport setting
;		  = 1 : Viewport initialization
; OUT:	(nothing)
; DES:	(all)
;
_VIEW	EQU	52h

;----------------------------------------------------------------------------
; SCREN
; Screen mode setting
; IN :	A = 0 : Setting the active screen
;		L = Active screen
;	A = 1 : Setting the output graphic screen
;		L[Bit0] = 0 : standard graphics screen
;			= 1 : extended graphics screen
;		L[Bit1] = 0 : Do not output 0,2 sides
;			= 1 : Output 0,2 sides
;		L[Bit2] = 0 : Do not output 1,3 sides
;			= 1 : Output 1,3 sides
;		※Bit 1,2 are valid only in 320 x 200 ・ 16 color mode
;	A = 2 : Active plane setting
;		L = Active plane
;	A = 3 : Setting the output plane
;		L = First output plane
;		H = First output plane
;	A = FFh : Screen mode initialization
;		Active screen = 0th graphic screen
;		Output graphic screen = standard single plane
;		Active plane = all planes
;		First output plane = All planes
;		2nd output plane = 256 colors only when all planes
; OUT:	(nothing)
; DES:	(all)
;
_SCREN	EQU	53h

;----------------------------------------------------------------------------
; COLOR
; Palette setting
; IN :	A = 0 : Setting the standard palette
;		Cy = 0 : Palette setting
;		  (HL  ) = Number of data sets (n)
;		  (HL+1) = Palette number
;		  (HL+2) = Color code
;		    :
;		  (HL+2n+1) = Palette number
;		  (HL+2n+2) = Color code
;		Cy = 1 : Palette initialization
;	A = 1 : 4096 Color palette setting
;		Cy = 0 : Palette setting
;		  (HL  ) = Number of data sets (n)
;		  (HL+1) = Palette number
;		  (HL+2) = Green brightness
;		  (HL+3) = Red brightness
;		  (HL+4) = Blue brightness
;		    :
;		  (HL+4n+1) = Palette number
;		  (HL+4n+2) = Green brightnes
;		  (HL+4n+3) = Red brightness
;		  (HL+4n+4) = Blue brightness
;		Cy = 1 : Initialization
; OUT:	(nothing)
; DES:	(all)
;
_COLOR	EQU	54h

;----------------------------------------------------------------------------
; SYMBL
; Draw a character string on the graphic screen
; IN :	(HL  )   = Color code
;	(HL+1)   = Drawing function
;	(HL+2)   = word count
;	(HL+3).w = String address
;	(HL+5)   = Longitudinal magnification
;	(HL+6)   = Lateral magnification
;	(HL+7)   = Angle code
;		    0 : normal
;		    1 :  90 degree counterclockwise rotation
;		    2 : 180 degree counterclockwise rotation
;		    3 : 270 degrees counterclockwise rotation
;	(HL+8)   = Font flag
;		    0 :  8x8
;		    1 : 16x8
; OUT:	(nothing)
; DES:	(all)
;
_SYMBL	EQU	55h

_HVIEW	EQU	56h

_CREP	EQU	57h

_GPUT	EQU	58h

_GGET	EQU	59h

_PENSE	EQU	5Ah

_MOVE	EQU	5Bh

_PRI	EQU	5Ch

_CBLOC	EQU	5Dh

_CRTI	EQU	5Eh

_COCNV	EQU	5Fh

_HROLL	EQU	60h

_GRINI	EQU	63h

;----------------------------------------------------------------------------
; TINIT
; Initialize the text screen
; IN :	Cy = 0 : 
;		A[Bit0]   = 0 : 80 columns
;			  = 1 : 40 columns
;		A[Bit2-1] = 00 : 25 rows
;			  = 01 : 20 rows
;			  = 10 : 12 rows
;		A[Bit3]   = 0 : 8x8 dot font used
;			  = 1 : 16x8 dot font used
;		A[Bit4]   = 0 : Line scrolling mode
;			  = 1 : Smooth ・ scroll mode
;	Cy = 1 : 
;		A = 0 :
;		  Initialize the text screen with 8 color mode
;		  It is 80-column text scroll mode
;		  At the time of 400 raster CRT 25 lines ・ 16 x 8 dot font
;		  At the time of 200 raster CRT 12 lines ・ 8 × 8 dot font
;		A other than 0:
;		  Initialize text screen to 64 color mode
;		  It is 40-column text scroll mode
;		  At the time of 400 raster CRT 25 lines ・ 16 x 8 dot font
;		  At the time of 200 raster CRT 12 lines ・ 8 × 8 dot font
; OUT:	(nothing)
; DES:	(all)
;
_TINIT	EQU	64h

;----------------------------------------------------------------------------
; MSGX
; Do not execute control code to output text string to CRT
; IN :	DE = ASCIIZ character string address
; OUT:	(nothing)
; DES:	AF, IY
;
_MSGX	EQU	65h

;----------------------------------------------------------------------------
; TMOD
; Mode setting and change of text screen
; IN :	C = 0 : Switch between kanji mode / pseudo graphic mode
;		A = 0    : Pseudo graphic mode
;		A other than 0: Kanji mode
;	C = 1 : Display function key list (ON / OFF)
;		A = 0 : Display OFF
;		A = 1 : Display ON
;		A = 2 : Display ON + clock
;	C = 2 : Cursor blinking ON / OFF
;		A = 0 : Cursor blinking OFF
;		A = 1 : Cursor blinking ON
;		A = 2 : Cursor blinks only when waiting for key input
;	C = 3 : Scrolling mode
;		A = 0    : Lock
;		  Other than 0: Unlock
;	C = 4 :
;		A = 0: character back is transparent
;		  Other than 0: character back is black
;	C = 5 :
;		A = 0    : Monochrome - Normal display of the entire screen area
;		  Other than 0:  Monochrome - Highlight the entire screen area
;	C = 6 : Background color setting
;		Cy is set as Bit 8 and A is set as Bit 7 - 0
;	C = 7 :
;		A = 0    : Graphic screen overlaid on monochrome display
;		  Other than 0: Monochrome · Do not overlay graphic screen on display
; OUT:	(nothing)
; DES:	(all)
;
_TMOD	EQU	66h

;----------------------------------------------------------------------------
; GPCG
; PCG - select font pattern of characters corresponding to specified character code
; Store it in the buffer indicated by DE
; IN :	DE = character code
;	B  = PCG select number (0-3)
;       ┌────────────┬───────┬─────────────────────┬───────┐
;       │DE          │B      │object               │ bytes │
;       ├────────────┼───────┼─────────────────────┼───────┤
;       │   0 - FF   │ 0     │PCG0   (8x8 dots)    │    8  │
;       │            │ 1     │PCG1   (8x8 dots)    │    8  │
;       │            │ 2     │PCG2   (8x8 dots)    │    8  │
;       │            │ 3     │PCG3   (8x8 dots)    │    8  │
;       │            │ other │PCG1-3 (8x8 dots)    │   24  │
;       ├────────────┼───────┼─────────────────────┼───────┤
;       │ 100 - 1FE  │ 0     │PCG0   (16x8 dots)   │   16  │
;       │ (even only)│ 1     │PCG1   (16x8 dots)   │   16  │
;       │            │ 2     │PCG2   (16x8 dots)   │   16  │
;       │            │ 3     │PCG3   (16x8 dots)   │   16  │
;       │            │ other │PCG1-3 (16x8 dots)   │   48  │
;       ├────────────┼───────┼─────────────────────┼───────┤
;       │ 200 - 2FF  │ -     │ANK ROMCG (8x8 dots) │    8  │
;       ├────────────┼───────┼─────────────────────┼───────┤
;       │ 300 - 3FF  │ -     │ANK ROMCG (16x8 dots)│   16  │
;       ├────────────┼───────┼─────────────────────┼───────┤
;       │8140 - EA9E │ -     │Chinese char ROMCG   │   32  │
;       │(SHIFT JIS) │       │(16x16 dots)         │       │
;       ├────────────┼───────┼─────────────────────┼───────┤
;       │EC9F - ECFC │ -     │External character   │   32  │
;       │ED40 - ED7E │       │(16x16 dots)         │       │
;       │ED80 - EDA2 │       │                     │       │
;       │(SHIFT JIS) │       │                     │       │
;       └────────────┴───────┴─────────────────────┴───────┘
; OUT:	DE = Buffer address
; DES:	(all)
;
_GPCG	EQU	67h

;----------------------------------------------------------------------------
; SPCG
; Set a Pattern for external characters corresponding to the designated character code / PCG select number
; 
; IN :	DE = character code
;	B  = PCG select number (0-3)
;	DIRARE(1000h-) = pattern
; OUT:	(nothing)
; DES:	(all)
;
_SPCG	EQU	68h

;----------------------------------------------------------------------------
; TGET
; Read data from the text screen
; IN :	L = X coordinate
;	H = Y coordinate
;	C = Number of bytes
; OUT:	C  = Number of acquired bytes
;	DE = Buffer address
; DES:	(all)
;
_TGET	EQU	69h

;----------------------------------------------------------------------------
; TSCRN
; Change setting of text input / output screen
; IN :	A[Bit1,0] = 00 : Do not change active screen
;		  = 01 : Make text screen 1 the active screen
;		  = 10 : Make text screen 2 the active screen
;	A[Bit3,2] = 00 : Do not change the setting of the text display screen
;		  = 01 : Output on the first side only
;		  = 10 : Output only on the second side
;		  = 11 : First surface / second surface overlapping (first surface first)
; OUT:	(nothing)
; DES:	(all)
;
_TSCRN	EQU	6Ah

;----------------------------------------------------------------------------
; TATR
; Change the attribute of the character being displayed
; IN :	C = 0 : Change color attribute of character
;		A = --GRBGRB (Bit 5-3 are valid only in 64 color mode)
;		    non 64 color mode:
;		                0 = BLACK
;		                1 = BLUE
;		                2 = RED
;		                3 = MAGENTA
;		                4 = GREEN
;		                5 = CYAN
;		                6 = YELLOW
;		                7 = WHITE
;	C = 1 : Change blink attribute of character
;		A = 0    : normal
;		  Other than 0: Blink
;	C = 2 : Change character reverse attribute
;		A = 0    : normal
;		  Other than 0: Reverse
;	L = Start X coordinate
;	H = Start Y coordinate
;	E = Length in X direction
;	D = Length in Y direction
; OUT:	(nothing)
; DES:	(all)
;
_TATR	EQU	6Bh

;----------------------------------------------------------------------------
; TWID
; Change the number of columns and the number of lines on the text screen
; IN :	A[Bit0]   =  0 : 80 columns
;		  =  1 : 40 columns
;	A[Bit2,1] = 00 : 25 rows
;		  = 01 : 20 rows
;		  = 10 : 12 rows
; OUT:	(nothing)
; DES:	(all)
;
_TWID	EQU	6Ch

;----------------------------------------------------------------------------
; TWARE
; Set scroll area of text screen
; IN :	L = Start X coordinate (0-79/0-39)
;	H = Start Y coordinate (0-24/0-19/0-11)
;	E = Length in X direction (1-80/1-40)
;	D = Length in Y direction (1-25/1-20/1-12)
; OUT:	(nothing)
; DES:	(all)
;
_TWARE	EQU	6Dh

;----------------------------------------------------------------------------
; TDARE
; Set the physical display area of the text screen
; IN :	L = Start X coordinate (0-79/0-39)
;	H = Start Y coordinate (0-199)
;	E = Length in X direction (0-80/0-40)
;	D = Length in Y direction (0-200)
; OUT:	(nothing)
; DES:	(all)
;
_TDARE	EQU	6Eh

;----------------------------------------------------------------------------
; CMOV
; Move cursor
; IN :	L = X coordinate
;	H = Y coordinate
; OUT:	(nothing)
; DES:	(all)
;
_CMOV	EQU	6Fh

;----------------------------------------------------------------------------
; TCLR
; Clear text screen
; IN :	A[Bit1,0] = 00 : Clear the entire text screen
;		  = 01 : Clear the character scroll area of the active screen
;		  = 10 : Clear specified area in character scroll area of active screen
;		  = 11 : Clear specified area of active screen
;	A[Bit7]   =  0 : After clearing the screen, move the cursor to the upper left of the scroll area
;		  =  1 : Do not change the cursor position after clearing the screen
;	L = Start X coordinate (0-79/0-39)
;	H = Start Y coordinate (0-24/0-19)
;	E = Length in X direction (1-80/1-40)
;	D = Length in Y direction (1-25/1-20)
; OUT:	(nothing)
; DES:	(all)
;
_TCLR	EQU	70h

;----------------------------------------------------------------------------
; TSCRL
; Scroll the character scroll area on the text screen
; IN :	A = 0    : Scroll up
;	      Other than 0: Scroll down
; OUT:	(nothing)
; DES:	(all)
;
_TSCRL	EQU	71h

;----------------------------------------------------------------------------
; CRPUT
; Text data stored in memory is displayed in specified rectangular area
; IN :	HL = (range)
; OUT:	(nothing)
; DES:	(all)
;
_CRPUT	EQU	72h

;----------------------------------------------------------------------------
; CRGET
; Store text data of specified rectangular area in memory
; IN :	HL = (range)
; OUT:	(nothing)
; DES:	(all)
;
_CRGET	EQU	73h

;----------------------------------------------------------------------------
; SETCG
; Load font pattern of CGROM into PCG 0
; IN :	A = 0    : CG font for MZ-2500 (8x8 dots)
;	         Other than 0: CG font for MZ-2000 / 80B
; OUT:	(nothing)
; DES:	(all)
;
_SETCG	EQU	74h

;----------------------------------------------------------------------------
; ?TEXT
; Return character type of specified coordinates
; IN :	L = X coordinate
;	H = Y coordinate
; OUT:	Cy = 0 : ANK/PCG
;	   = 1 : Chinese characters
;		   Zf = 1 : Kanji left
;		      = 0 : Kanji right
; DES:	(all)
;
_?TEXT	EQU	75h

;----------------------------------------------------------------------------
; CURBL
; Cursor blink control by timer interrupt * User unavailable
; IN :	A = 0 : Flip character / cursor pattern at cursor position
;	  = 1 : Enable cursor blinking
;	  = 2 : Disable cursor blinking
;	  = 3 : Depending on the cursor flashing mode, cursor blinking Enable / Disable
; OUT:	(nothing)
; DES:	(all)
;
_CURBL	EQU	76h

;----------------------------------------------------------------------------
; TSUB
; Text screen control * User unavailable
; IN :  C = 0 : The bottom row control
;              B = 00h : Display function key list
;                = FEh : Update displayed clock
;                = FFh : Clear function key list
;                other  : Display function key list (SHIFT)
;       C = 1 : Delete One character at cursor position
;       C = 2 : Get character pattern at specified position
;              L = X coordinate
;              H = Y coordinate
;              DE = Buffer address
;       C = 3 : Line connection control
;              B = 00h : Logically separate the cursor line from the next line
;                = 01h : Logically connect the cursor line and the next line
;                = FFh : Returns the line connection status of the cursor line
;
; OUT:  C = 2 : C = Number of pattern bytes
;       C = 3 : A = 0    : Is separated
;                     Other than 0: Connected
; DES:	(all)
;
_TSUB	EQU	77h

_RS232	EQU	78h

_RTC	EQU	79h

_MOUSE	EQU	7Ah

_IOSUB	EQU	7Bh

_DVCAL	EQU	7Ch

_FDRES	EQU	7Dh

_CMT	EQU	7Eh

_VOICE	EQU	7Fh

