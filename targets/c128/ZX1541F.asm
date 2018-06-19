;TS1500 / C1541 Disk Drive Interface
;(c) 2001 Luis C. Grosso


;ZX81 machine code program template.
;For use with AVOCET cross assembler.
;The program will auto run at address 16514 4082H
;Use SAVE1500 to transfer programs to a real ZX81

        ORG     4009H

;SAVED SYSTEM VARIABLES
VERSN:  DEFB    00H
E_PPC:  DEFW    0000H
D_FILE: DEFW    DFILE1
DF_CC:  DEFW    DFILE1+1
VARS:   DEFW    VARS1
DEST:   DEFW    0000H
E_LINE: DEFW    VARS1+1
CH_ADD: DEFW    VARS1+7
X_PTR:  DEFW    0000H
STKBOT: DEFW    VARS1+8
STKEND: DEFW    VARS1+8
BREG:   DEFB    00H
MEM:    DEFW    MEMBOT
UNUSEB: DEFB    00H
DF_SZ:  DEFB    02H
S_TOP:  DEFW    0000H
LAST_K: DEFW    0FFFFH
DB_ST:  DEFB    00H
MARGIN: DEFB    55
NXTLIN: DEFW    LINE1
OLDPPC: DEFW    0000H
FLAGX:  DEFB    00H
STRLEN: DEFW    0000H
T_ADDR: DEFW    0C6BH
SEED:   DEFW    0000H
FRAMES: DEFW    0FFFFH
COORDS: DEFB    00H
        DEFB    00H
PR_CC:  DEFB    188
S_POSN: DEFB    33
S_PSN1: DEFB    24
CDFLAG  DEFB    64
PRBUFF: DEFS    20H
PRBEND  DEFB    76H
MEMBOT: DEFS    1EH
UNUSEW: DEFW    0000H

;BASIC PROGRAM
LINE0:  DEFB    00H
        DEFB    00H
        DEFW    ENDL0-LINE0-3
        DEFB    0EAH            ;REM

;PUT YOUR ASM PROGRAM HERE  ORG 4082H
;      ...
;      ...
;      ...

;MOVE THE PROGRAM TO THE EEPROM AT 2000H
PRGEP   LD HL,PRGEP1+1          ;source address
        LD DE,2000H             ;EEPROM begining
        LD BC,ENDL0-PRGEP1      ;get the block length
BUSY:   IN A,(0BFH)             ;read the EEPROM status bit
        AND 01H                 ;leave only bit 0
        JR Z,BUSY               ;wait until the memory is not busy
        LDI                     ;copy byte inc pointer and dec counter
        JP PE,BUSY              ;loop until all bytes processed
PRGEP1: RET                     ;ret


        LOC 2000H

;MINI BIOS TO KEEP THINGS COMPATIBLE
        JP      START           ;jump to main program
OPEN:   JP      LF3D5           ;open for serial device
CLOSE:  JP      LF642           ;close for serial device
SECND:  JP      LEDB9           ;send SA after listen
TKSA:   JP      LEDC7           ;send SA after talk
ACPTR:  JP      LEE13           ;handshake serial byte in (input byte)
CIOUT:  JP      LEDDD           ;handshake serial byte out (output byte)
UNTALK: JP      LEDEF           ;command serial bus to untalk
UNLSN:  JP      LEDFE           ;command serial bus to unlisten
LISTN:  JP      LED0C           ;command serial bus to listen
TALK:   JP      LED09           ;command serial bus to talk

;SET SOME VARIABLES AND INITIALIZE THE INTERFACE PORT
START:  LD      (MYSP),SP       ;save the SP on entry in a variable
        LD      A,08H           ;device #8
        LD      (FA),A          ;set as current device
        XOR     A               ;signal 'not in menu' ...
        LD      (MYFLAG),A      ;in the flag
        CALL    INITBF          ;init port 0BFH
        CALL    PAGSYS          ;page in system ram

;CHECK IF THIS PROGRAM WAS CALLED FROM WITHIN A SAVE OR LOAD BASIC COMMAND
        LD      HL,(T_ADDR)     ;get the syntax table pointer
        LD      DE,0C8AH        ;the address of 'load' in the syntax table
        AND     A               ;clear the carry
        SBC     HL,DE           ;is the usr funcion called from a load command?
        JR      Z,FROMLD        ;jump if yes
        LD      HL,(T_ADDR)     ;get the syntax table pointer again
        LD      DE,0C8DH        ;the address of 'save' in the syntax table
        AND     A               ;clear the carry
        SBC     HL,DE           ;is the usr function called from a save comand?
        JR      NZ,FROMNW       ;if not, display the menu else...

;PROCESS THE FILENAME AND SAVE THE PROGRAM TO DISK
FROMSV: CALL    SEENAM          ;check and prepare the file name
        JP      PRSV1           ;save the file and ret to basic

;PROCESS THE FILENAME AND LOAD THE PROGRAM FROM DISK
FROMLD: CALL    SEENAM          ;check and prepare the file name
        JP      PRLD1           ;load the program and ret to basic to run it

;CHECK IF A NAME IS GIVEN AND PASS IT TO A BUFFER ENDING WITH 0FFH
SEENAM: CALL    NAME            ;check if a name is given using the ROM
        JP      C,ERRORF        ;report F if not
        EX      DE,HL           ;pass the name start to HL
        LD      DE,EDBUFF       ;buffer start to DE
FRMSV1: LD      A,(HL)          ;get a byte from the name
        BIT     7,A             ;check bit 7 for the end marker
        RES     7,A             ;reset it anyway
        LD      (DE),A          ;poke the byte in the buffer
        INC     HL              ;increment
        INC     DE              ;both pointers
        JR      Z,FRMSV1        ;loop back if it was not the last byte
        LD      A,0FFH          ;end marker byte
        LD      (DE),A          ;poke the marker
        RET                     ;ret

;DISPLAY THE MENU AN WAIT FOR AN OPTION TO BE SELECTED
FROMNW: CALL    INITVAR         ;initialize some variables
START1: CALL    EXTRA           ;expand the display file and home the cursor
        CALL    SLOW            ;put the machine in slow mode
        LD      DE,MNMENU       ;the menu text address
        CALL    PRMENU          ;display the menu
        CALL    PRTFA           ;display the current device number
MLOOP:  LD      HL,MLOOP        ;menu loop return address
        PUSH    HL              ;push it
        CALL    RDKBD           ;read the keyboard
        CP      27H             ;Sinclair 'B'
        JP      Z,ERROR0        ;ret to basic with no error condition
        CP      28H             ;Sinclair 'C'
        JR      Z,TOGLFA        ;toggle device number between 8 and 9
        CP      3DH             ;Sinclair 'X'
        JR      Z,DRVST         ;read the drive status and print it
        CP      29H             ;Sinclair 'D'
        JR      Z,DIRCM         ;show the disk directory
        CP      3FH             ;Sinclair 'Z'
        JR      Z,SNDCM         ;send a command to the drive
        CP      31H             ;Sinclair 'L'
        JP      Z,PRLOAD        ;load a program
        CP      38H             ;Sinclair 'S'
        JP      Z,PRSAVE        ;save a program
        RET                     ;back to MLOOP

;TOGGLE DEVICE NUMBER BETWEEN 8 AND 9
TOGLFA: LD      A,(FA)          ;get the current device number (8 or 9)
        XOR     01H             ;toggle bit 0
        LD      (FA),A          ;save it back in the variable

;PRINT THE CURRENT DEVICE NUMBER AT LINE 16 COL 21
PRTFA:  LD      BC,1215H        ;line 16 col 21
        LD      (CSRX),BC       ;set the cursor position
        CALL    ATCALC          ;calc the print address in HL
        LD      A,(FA)          ;get the current device number
        ADD     A,1CH           ;add Sinclair '0'
        LD      (HL),A          ;poke it in the display file
        RET                     ;ret

;SHOW DRIVE STATUS (MENU OPTION)
DRVST:  LD      BC,1600H        ;line 22 col 0
        LD      (CSRX),BC       ;set as cursor coordinates
        CALL    FAST            ;put the machine in fast mode
        CALL    CLRLIN          ;clear the crrent line
        CALL    STATUS          ;display the drive status
        JR      Z,DEVPRS        ;jump if the drive was present
        LD      DE,DEV_NP       ;message 'DEVICE NOT PRESENT'
        CALL    PRMSG           ;print ascii message
DEVPRS: CALL    SLOW            ;put the machine in slow
        RET                     ;and ret

;SHOW THE DISK DIRECTORY (MENU OPTION)
DIRCM:  CALL    EXTRA           ;expand dfile cls and home the cursor
        CALL    FAST            ;put the machine in fast
        LD      HL,EDBUFF       ;begin of filename buffer
        LD      (HL),'$'        ;set '$' as the directory filename
        INC     HL              ;point to the next character
        LD      (HL),0FFH       ;and put the end marker
        LD      DE,EDBUFF       ;filename buffer
        CALL    LOAD            ;load the 'directory' file
        CALL    SLOW            ;put the machine in slow
        CALL    SHOWDIR         ;dislay the directory
DIRCM2: CALL    DRVST           ;show the drive status
        LD      BC,1700H        ;line 23 column 0
        LD      (CSRX),BC       ;set as cursor position
        LD      DE,PRESSM       ;'PRESS ANY KEY' message
        CALL    PRMSG           ;print it
DIRCM1: CALL    RDKBD           ;read the keyboard
        JR      NC,DIRCM1       ;loop back if no key depressed
DIRCM3: LD      HL,START1       ;print the menu address
        EX      (SP),HL         ;repalce the current return address
        RET                     ;ret to menu

;SEND A COMMAND TO DRIVE
SNDCM:  CALL    LINEDIT         ;input command from keyboard
        LD      DE,EDBUFF       ;begining of buffer
        LD      A,(DE)          ;get the first byte
        CP      0FFH            ;is the buffer empty?
        JR      Z,DIRCM3        ;if yes, then ret to menu
        CALL    BUF2ASC         ;convert buffer contents to ASCII
        CALL    FAST            ;put machine in FAST
        LD      A,6FH           ;open channel 15
        LD      (SA),A          ;secondary address
        CALL    SENDCMD         ;send command to the drive
        JR      DIRCM2          ;get drive status

;PROGRAM LOAD (MENU OPTION)
PRLOAD: CALL    LINEDIT         ;ask the user for a program name
PRLD1:  LD      DE,EDBUFF       ;begining of buffer
        LD      A,(DE)          ;get the first byte from filename
        CP      0FFH            ;is the buffer empty?
        JR      Z,DIRCM3        ;if yes jump to menu
        CALL    BUF2ASC         ;convert buffer contents to ASCII
        CALL    FAST            ;put machine in FAST
        LD      DE,EDBUFF       ;point to the 0FFH terminated filename
        CALL    LOAD            ;load the program into the big buffer
        LD      A,(UNUSEB)      ;get the 'load and run' flag
        AND     A               ;load and run the program?
        PUSH    AF              ;save the flag
        LD      HL,(8014H)      ;get the new E-LINE from the big buffer
        LD      DE,4009H        ;begin of a saved basic program
        AND     A               ;clear the carry flag
        SBC     HL,DE           ;calculate the program length
        LD      B,H             ;and pass it
        LD      C,L             ;to BC
        LD      DE,4009H        ;begin of a saved basic program
        LD      HL,8009H        ;begin of the just loaded prgrm in big buffer
        LDIR                    ;move it down to the working address

;PAGE THE USER RAM AND RET TO BASIC TO RUN THE PROGRAM, OR NOT
        CALL    PAGUSR          ;page in the user ram at 8000H
        POP     AF              ;retrieve the flag
        JR      NZ,NOTRUN       ;jump if not, else..
PRLD3:  RST     08H             ;return to basic
        DEFB    0FFH            ;with no error condition
NOTRUN: RST     08H             ;return to basic
        DEFB    0BH             ;with report C (not run the program)

PRLD2:  CALL    PAGUSR          ;page in the user ram at 8000H
        JR      PRLD3           ;run the program

;PROGRAM SAVE (MENU OPTION)
PRSAVE: CALL    LINEDIT         ;ask the user for a program name
PRSV1:  LD      DE,EDBUFF       ;begining of buffer
        LD      A,(DE)          ;get the first byte from filename
        CP      0FFH            ;is the buffer empty?
        JR      Z,DIRCM3        ;if yes jump to menu
        CALL    BUF2ASC         ;convert buffer contents to ASCII
        CALL    FAST            ;put machine in FAST
        CALL    EXTRA           ;expand the display file and home the cursor
        LD      DE,EDBUFF       ;point to the 0FFH terminated filename
        CALL    SAVE            ;save the file to disk
        LD      A,(MYFLAG)      ;get the internal flags byte
        BIT     0,A             ;was this routine called from the menu?
        JP      Z,PRLD2         ;if not, ret to basic and run the program
        JP      DIRCM2          ;else show drive status and go to menu

;LOAD THE PROGRAM FILE WHICH 0FFH ENDED NAME IS POINTED BY 'DE' FROM DEVICE (FA)
LOAD:   PUSH    DE              ;save the filename address
        CALL    LENCLC          ;calculate the name length
        POP     HL              ;retrieve the name address
        LD      (FNLEN),A       ;put name length in variable
        LD      C,A             ;and also copy it to 'C'
        LD      B,0             ;high part = 0
        LD      DE,EDBUFF       ;edit buffer address
        LDIR                    ;copy filename to the edit buffer
        LD      A,0FFH          ;put the end marker
        LD      (DE),A          ;in the proper place
        LD      A,60H           ;secondary address to load
        LD      (SA),A          ;put it in the (SA) variable
        LD      HL,BIGBUF       ;buffer where the file will be loaded
        LD      (DATAPTR),HL    ;point variable to it
        CALL    SENDCMD         ;open the file
        LD      A,(ST)          ;get ST
        AND     A               ;check if any error has occurred
        JR      Z,LOAD1         ;jump if not
        JP      LF707           ;show the error message and quit
                                ;close file is missing ***
LOAD1:  LD      A,(FA)          ;get device number
        CALL    LED09           ;comand device to talk
        LD      A,(SA)          ;get secondary address
        CALL    LEDC7           ;send secondary address after talk
        EX      (SP),HL         ;little
        EX      (SP),HL         ;time delay
LOAD2:  CALL    LEE13           ;read byte from device
        LD      B,A             ;copy byte to 'B'
        LD      A,(ST)          ;get status variable
        BIT     1,A             ;check for timeout in reading
        JR      NZ,LOAD3        ;jump if timeout
        BIT     6,A             ;check for EOI
        JP      NZ,LF642        ;jump if end of information
        LD      HL,(DATAPTR)    ;get file data pointer
        LD      (HL),B          ;put loaded byte in place
        INC     HL              ;increment pointer
        LD      (DATAPTR),HL    ;and its variable
        JR      LOAD2           ;loop around till all the file is loaded
LOAD3:  LD      BC,1600H        ;line 22 col 0
        LD      (CSRX),BC       ;set as cursor position
        CALL    CLRLIN          ;clear the line
        CALL    STATUS          ;print the error channel
        JP      ERRORE          ;error report

;SAVE THE PROGRAM FILE WHICH 0FFH ENDED NAME IS POINTED BY 'DE' FROM DEVICE (FA)
SAVE:   PUSH    DE              ;save the filename address
        CALL    LENCLC          ;calculate the name langth
        POP     HL              ;retrieve the name address
        LD      (FNLEN),A       ;put name length in variable
        LD      C,A             ;and also copy it to 'C'
        LD      B,0             ;high part = 0
        LD      DE,EDBUFF       ;edit buffer address
        LDIR                    ;copy filename to the edit buffer
        LD      A,0FFH          ;put the end marker
        LD      (DE),A          ;in the proper place
        LD      A,61H           ;secondary address to save
        LD      (SA),A          ;put it in the (SA) variable
        LD      HL,4009H        ;buffer where the file will be saved from
        LD      (DATAPTR),HL    ;point variable to it
        CALL    SENDCMD         ;open the file
        LD      A,(ST)          ;get ST
        AND     A               ;check if any error has occurred
        JR      Z,SAVE1         ;jump if not
        JP      LF707           ;show the error message and quit
                                ;close file is missing ***
SAVE1:  LD      A,(FA)          ;get device number
        CALL    LED0C           ;comand device to listen
        LD      A,(SA)          ;get secondary address
        CALL    LEDB9           ;send secondary address after listen
        EX      (SP),HL         ;little
        EX      (SP),HL         ;time delay

;SEND THE PROGRAM TO BE SAVED SERIALLY TO THE DRIVE
SAVE2:  LD      HL,(DATAPTR)    ;get the data pointer
        LD      A,(HL)          ;get a byte to send
        CALL    LEDDD           ;output byte to serial bus
        LD      A,(ST)          ;get the serial status
        BIT     0,A             ;check if timeout in writing has occuurred
        JR      NZ,LOAD3        ;jump if yes, else..
        LD      HL,(DATAPTR)    ;get the data pointer
        INC     HL              ;increment it
        LD      (DATAPTR),HL    ;update the variable
        LD      DE,(E_LINE)     ;get E-LINE
        AND     A               ;check if the whole
        SBC     HL,DE           ;program was saved
        JR      C,SAVE2         ;loop back if not completed yet
        CALL    LEDFE           ;send unlisten to serial bus
        JP      LF642           ;close the serial device

;CALCULATE THE FILENAME LENGTH
LENCLC: LD      B,00H           ;initialize the counter
LENCL1: LD      A,(DE)          ;get the byte
        INC     DE              ;increment the pointer
        CP      0FFH            ;is it the end marker
        LD      A,B             ;copy the counte to 'A'
        RET     Z               ;ret if the end was reached
        INC     B               ;increment counter
        JR      LENCL1          ;process next byte

;SHOW THE DIRECTORY STORED IN THE 'BIG BUFFER'
SHOWDIR:LD      HL,BIGBUF       ;point HL to the buffer
        INC     HL              ;skip the CBM 'load addrees' low
        INC     HL              ;and high byte
        INC     HL              ;skip the supposed 'next line address' low
SHOWDI3:INC     HL              ;and high byte
        LD      C,(HL)          ;get the file length low byte
        INC     HL              ;increment pointer
        LD      B,(HL)          ;get the file length high byte
        INC     HL              ;increment pointer
        PUSH    HL              ;save the pointer into the stack
        CALL    PRDEC           ;print the file length in decimal
        LD      A,' '           ;a SPACE
        CALL    PRCHR           ;print it
        POP     HL              ;retrieve the pointer
SHOWDI2:LD      A,(HL)          ;get a filename byte
        INC     HL              ;increment pointer
        CP      12H             ;is it an RVS ON controlk chr?
        JR      Z,SHOWDI2       ;if yes then skip it
        AND     A               ;is it the line end marker?
        JR      Z,SHOWDI1       ;jump if yes
        CALL    PRCHR           ;else print the filename chr
        JR      SHOWDI2         ;loop to process next byte
SHOWDI1:LD      A,(HL)          ;get the next byte
        INC     HL              ;skip the 'next line address' high byte
        AND     A               ;was it the directory end marker?
        RET     Z               ;ret if so
        LD      A,0DH           ;else print an 'ENTER' chr
        CALL    PRCHR           ;moving to next line
        CALL    CHKCUR          ;check if it's time for 'pressing any key'
        JR      SHOWDI3         ;process next directory line

;CHECK IF THE PRINT POSITION REACHES LINE 22 AND INVITE TO PRESS A KEY
CHKCUR: PUSH    HL              ;put HL in a safe place
        LD      A,(CSRY)        ;get the line position
        CP      22              ;is in on or past line 22?
        JP      C,POPEX1        ;if not then do nothing
        LD      BC,1700H        ;else point to the begining of line 23
        LD      (CSRX),BC       ;signal it in CSRX and CSRY
        LD      DE,PRESSM       ;'PRESS ANY KEY' mesage
        CALL    PRMSG           ;print it
KLOOP   CALL    CHK_BRK         ;is the break key pressed?
        JR      NC,ERRORD       ;if yes then report D
        CALL    KEY_SCN         ;else scan the keyboard
        INC     HL              ;check if HL = 0FFH
        LD      A,H             ;meaning no
        OR      L               ;no key depressed
        JR      Z,KLOOP         ;loop until a key is pressed
        CALL    CLS             ;clear the screen
        LD      BC,0000H        ;point to the screen begining
        LD      (CSRX),BC       ;adjusting the variables
POPEX1: POP     HL              ;retrieve HL
        RET                     ;and ret

;REPORT D - BREAK KEY PRESSED
ERRORD: CALL    ERROR
        DEFB    0CH

;PRINT BC IN DECIMAL
PRDEC:  LD      D,B             ;copy the number to be
        LD      E,C             ;displayed to DE
        LD      HL,L09131       ;buffer for decimals in ascii
        LD      B,05H           ;five characters
PRDEC1: LD      (HL),00H        ;fill the buffer
        INC     HL              ;with null characters
        DJNZ    PRDEC1          ;loop until all done
        LD      (HL),'$'        ;poke the end marker
        EX      DE,HL           ;number to be displayed to HL
        LD      BC,L09131       ;buffer for decimals in ascii
        PUSH    BC              ;save the buffer pointer
        LD      DE,2710H        ;DE = 10000 dec
        CALL    L098A4          ;divide by 10000 dec, ascii result to buffer
        LD      DE,03E8H        ;DE = 1000 dec
        CALL    L098A4          ;divide by 1000 dec, ascii result to buffer
        LD      DE,0064H        ;DE = 100 dec
        CALL    L098A4          ;divide by 100 dec, ascii result to buffer
        LD      E,0AH           ;DE = 10 dec
        CALL    L098A4          ;divide by 10 dec, ascii result to buffer
        LD      A,L             ;pass L to A
        ADD     A,30H           ;add '0'
        LD      (BC),A          ;poke it into the buffer
        INC     BC              ;increment pointer
        LD      A,'$'           ;end marker
        LD      (BC),A          ;poke it
        INC     BC              ;increment pointer
        POP     HL              ;retrieve the buffer start address

;REMOVE THE LEFTHAND ZEROES (BY POINTING TO THE FIRST NONZERO CHARACTER)
        LD      B,04H           ;4 characters
L09898: LD      A,(HL)          ;get byte from buffer
        CP      30H             ;is it '0'?
        JR      NZ,L098A0       ;if not -> L098A0
        INC     HL              ;increment pointer
        DJNZ    L09898          ;if it was '0' then check next char

;PRINT THE BUFFER
L098A0: EX      DE,HL           ;buffer pointer to DE
        CALL    PRMSG           ;print the ascii message
        RET                     ;ret

;CALCULATE HL/DE, SAVE THE ASCII QUOTIENT IN THE BUFFER, REMINDER IN HL
L098A4: XOR     A               ;clear CARRY and A
L098A5: SBC     HL,DE           ;substract DE from HL as many times as possible
        INC     A               ;# of times DE could be substracted -> A (quot)
        JR      NC,L098A5       ;loop back while the substraction is possible
        ADD     A,2FH           ;add '0' minus one (the carry bit)
        ADD     HL,DE           ;add the last value (when substr not possible)
        LD      (BC),A          ;poke the character into the buffer
        INC     BC              ;increment pointer
        RET                     ;ret


;SEND A COMMAND TO DRIVE
SENDCMD:LD      A,00            ;signal 'no error'
        LD      (ST),A          ;in ST
        LD      A,0FFH          ;buffer end marker
        LD      B,00H           ;initial command length
        LD      HL,EDBUFF       ;command buffer
        LD      (FNADR),HL      ;point variable to it
SENDCM2:CP      (HL)            ;is (HL) pointing to the end marker?
        JR      Z,SENDCM1       ;jump if yes
        INC     B               ;else increment command length
        INC     HL              ;and buffer pointer
        JR      SENDCM2         ;loop to process next byte
SENDCM1:LD      A,B             ;copy length to A
        LD      (FNLEN),A       ;and also to the variable
        CALL    LF3D5           ;open for seial bus devices
        RET                     ;ret

;TRANSLATE THE COMMAND BUFFER TO ASCII
BUF2ASC:LD      A,(DE)          ;get the byte pointed by DE
        CP      0FFH            ;is it the end marker?
        RET     Z               ;if yes then ret
        CALL    ZX2ASC          ;else trenslate the byte
        LD      (DE),A          ;put it back in place
        INC     DE              ;increment pointer
        JR      BUF2ASC         ;process next byte

;TABLE ACCESS TO CONVERT ZX81 CHR TO ASCII
ZX2ASC: PUSH    HL              ;push registers
        PUSH    DE
        PUSH    AF
        LD      E,A             ;copy ZX chr to 'E'
        AND     0C0H            ;if bits 6 or 7 are set
        JP      NZ,QSTNM        ;then print a question mark
        LD      HL,CONVTAB      ;conversion table
        LD      D,0             ;index through the table
        ADD     HL,DE           ;to get the ascii code
        LD      E,(HL)          ;move ascii code to 'E'
POPEX:  POP     AF              ;pop AF
        LD      A,E             ;copy code to 'A'
        POP     DE              ;pop registers
        POP     HL
        RET                     ;ret

QSTNM:  LD      E,'?'           ;replace unprintable chrs with a '?'
        JP      POPEX           ;pop regs and exit

;ONE LINE EDITOR
LINEDIT:LD      HL,EDBUFF       ;buffer begining
        LD      (BUFPTR),HL     ;point variable to it
        LD      (HL),0FFH       ;signal 'empty buffer' by placing end marker
KEYPRS: CALL    PRTBUF          ;print the buffer
NOKEY:  CALL    PRCURS          ;print the cursor
        CALL    RDKBD           ;read the keyboard
        JR      NC,NOKEY        ;loop if no key depressed
        CP      76H             ;is it 'ENTER'
        JR      Z,NEWLIN        ;jump if yes
UPDBUF: CP      77H             ;is it 'DELETE'
        JR      Z,RUBOUT        ;jump if yes
        BIT     6,A             ;is it printable?
        JR      NZ,NOKEY        ;jump if not

;CHECK FOR THE BUFFER END
        LD      BC,EDBUFF+29    ;edit buffer end
        LD      HL,(BUFPTR)     ;buffer pointer
        AND     A               ;clear carry flag
        SBC     HL,BC           ;check if the end was reached
        JR      NC,KEYPRS       ;jump if yes

;PUT THE BYTE IN POSITION
        LD      HL,(BUFPTR)     ;else put the byte
        LD      (HL),A          ;in the proper position
        INC     HL              ;increment pointer
UPDBU1: LD      (BUFPTR),HL     ;update buffer ptr variable
        LD      (HL),0FFH       ;put the end marker
        JR      KEYPRS          ;process next chr

;CHECK FOR THE BUFFER BEGINING
RUBOUT: LD      HL,EDBUFF       ;edit buffer begining
        LD      BC,(BUFPTR)     ;buffer pointer
        AND     A               ;clear carry
        SBC     HL,BC           ;check if the ptr is at the buffer start
        JR      NC,KEYPRS       ;jump if yes
;DELETE THE LAST CHARACTER
        LD      HL,(BUFPTR)     ;else decrement
        DEC     HL              ;the buffer pointer
        JR      UPDBU1          ;and update variable

;DELETE THE CURSOR AND EXIT LINE EDITOR
NEWLIN: LD      A,00            ;'SPACE'
        CALL    PRTTY           ;print it
        RET

;PRINT THE BUFFER
PRTBUF: LD      HL,1500H        ;AT 21,00
        LD      (CSRX),HL       ;set variable
        LD      HL,EDBUFF       ;edit buffer begining
PRTBU1: LD      A,(HL)          ;get byte
        INC     HL              ;increment pointer
        CP      0FFH            ;is it the end marker?
        RET     Z               ;if yes then return
        PUSH    HL              ;push pointer
        CALL    PRTTY           ;print ZX chr
        POP     HL              ;pop pointer
        JR      PRTBU1          ;loop to print next byte

;PRINT THE CURSOR AND TOGGLE IT EVERY 4 FRAMES
PRCURS: LD      A,(FRAMES)      ;get FRAMES
        AND     04H             ;leave only bit 2
        LD      A,(CURINV)      ;use the 'inverted crsor'
        JR      Z,PRCUR1        ;if bit 2 is 0
        LD      A,(CURNRM)      ;else use the normal cursor
PRCUR1: CALL    PRTTY           ;print it
        LD      A,00H           ;and also a
        CALL    PRTTY           ;trailing space
        LD      HL,CSRX         ;get the column position
        DEC     (HL)            ;point to the
        DEC     (HL)            ;crsor character
        RET                     ;ret

;SCAN THE KEYBOARD CHR -> 'A'
RDKBD:  CALL    KEY_SCN         ;scan the keyboard
        LD      A,H             ;pass scan code high byte to A
        CP      0FEH            ;is any key pressed?
RDKBD1: JR      NC,RDKBD2       ;jump if not
        LD      B,H             ;transfer the
        LD      C,L             ;scan code to BC
        CALL    KEY_DEC         ;decode the key
        LD      A,(KYGOOD)      ;get the 'previous key state' flag
        AND     A               ;compare with 0
        RET     NZ              ;ret if a key was held down
        LD      A,01H           ;signal 'a key depressed'
        LD      (KYGOOD),A      ;in the flag
        LD      A,(HL)          ;get the byte just read from kbd
        SCF                     ;signal it in the CF, too
        RET                     ;ret

;SIGNAL 'NO KEY DEPRESSED'
RDKBD2: LD      A,00H           ;no key depressed
        LD      (KYGOOD),A      ;signal it in the flag
        RET                     ;ret

;CLEAR A WHOLE LINE
CLRLIN: LD      B,32            ;32 characters
CLRLI1: PUSH    BC              ;push the counter
        LD      A,' '           ;an ascii space
        CALL    PRCHR           ;print the ascii character
        POP     BC              ;pop the counter
        DJNZ    CLRLI1          ;loop until the whole line is cleared
        LD      HL,CSRY         ;move the cursor vertical position
        DEC     (HL)            ;back to the previous line
        RET                     ;ret

;SHOW DRIVE STATUS
;STATUS: XOR     A               ;signal 'no error'
;        LD      (ST),A          ;in ST
;        LD      A,(FA)          ;get device number
;        CALL    LED09           ;command device to talk
;        LD      A,(ST)          ;get ST
;        OR      A               ;is everything O.K.?
;        RET     NZ              ;ret if not
;        LD      A,6FH           ;open channel 15
;        LD      (SA),A          ;secondary address
;        CALL    LEDC7           ;send secondary address after talk
;        EX      (SP),HL         ;little
;        EX      (SP),HL         ;time delay
;LOOP1:  CALL    LEE13           ;read byte from device
;        CP      0DH             ;is it ENTER?
;        JR      Z,CONT1         ;jump if yes
;        CALL    PRCHR           ;else print chr
;        JR      LOOP1           ;loop to get next byte
;CONT1:  CALL    PRCHR           ;leave a blank line (print the ENTER chr)
;        CALL    LF642           ;close channel 15
;        XOR     A               ;signal 'no error'
;        RET                     ;ret


;SHOW DRIVE STATUS NEW ROUTINE, I HOPE IT WORKS :-)
STATUS: LD      DE,EDBUFF       ;buffer for the status message
        XOR     A               ;signal 'no error'
        LD      (ST),A          ;in ST
        LD      A,(FA)          ;get device number
        CALL    LED09           ;command device to talk
        LD      A,(ST)          ;get ST
        OR      A               ;is everything O.K.?
        RET     NZ              ;ret if not
        LD      A,6FH           ;open channel 15
        LD      (SA),A          ;secondary address
        CALL    LEDC7           ;send secondary address after talk
        EX      (SP),HL         ;little
        EX      (SP),HL         ;time delay
LOOP1:  CALL    LEE13           ;read byte from device
        LD      (DE),A          ;poke it into the buffer
        INC     DE              ;increment pointer
        CP      0DH             ;is it ENTER?
        JR      Z,CONT1         ;jump if yes
        JR      LOOP1           ;loop to get the next byte
CONT1:  CALL    LF642           ;close channel 15

        LD      A,(MYFLAG)      ;get the flag
        BIT     0,A             ;is runing from the menu?
        JR      NZ,PRSTAT       ;jump if yes
        LD      HL,(EDBUFF)     ;get the first two characters
        LD      DE,3030H        ;both D and E hold the 'zero' petscii code
        AND     A               ;clear the carry
        SBC     HL,DE           ;check if the error was '00'
        JR      Z,STAEND        ;jump if no error (error 00)
        CALL    PRSTAT          ;print the status from buffer
        JP      ERRORE          ;stop the basic prg with report E

PRSTAT: LD      DE,EDBUFF       ;point DE to the buffer start
PRSTA1: LD      A,(DE)          ;get a byte from the buffer
        INC     DE              ;increment pointer
        CP      0DH             ;is it 'enter'?
        JR      Z,STAEN1        ;jump if yes
        CALL    PRCHR           ;print the character
        JR      PRSTA1          ;loop back until the end marker is found
STAEN1: CALL    PRCHR           ;print the 'enter' character
STAEND: XOR     A               ;signal 'no error'
        RET                     ;ret

;PRINT 'A' IN HEX (USED FOR DEBUGGING)
;PRHEX:  PUSH    AF              ;save byte
;        RLCA                    ;exchange
;        RLCA                    ;high
;        RLCA                    ;and low
;        RLCA                    ;nibbles
;        AND     0FH             ;leave the four least sign bits
;        ADD     A,1CH           ;add sinclair code for '0'
;        CALL    PRTTY           ;print high nibble
;        POP     AF              ;retrieve byte
;        AND     0FH             ;mask off high nibble
;        ADD     A,1CH           ;add code for '0'
;        CALL    PRTTY           ;print low nibble
;        RET                     ;ret

;SERIAL INTERFACE LOW LEVEL ROUTINES
;Translated from the C64 ROM (6502), code is not optimized.
;Labels make reference to the original C64 addresses.

;SEND TALK ON SERIAL BUS
LED09:  OR      40H             ;signal to talk
        JR      LED0E           ;continue there

;SEND LISTEN ON SERIAL BUS
LED0C:  OR      20H             ;signal to listen
LED0E:  NOP
LED11:  PUSH    AF              ;save AF
        LD      HL,C3PO         ;check if a buffered byte
        BIT     7,(HL)          ;is waiting to be sent
        JR      Z,LED20         ;jump if no buffered byte (bit 7 = 0)
        LD      HL,EOI          ;signal last byte in message
        SET     7,(HL)          ;by setting bit 7
        CALL    LED40           ;send byte from (BSOUR) to serial bus
        LD      HL,C3PO         ;signal no buffered
        RES     7,(HL)          ;byte is waiting
        LD      HL,EOI          ;and not last byte
        RES     7,(HL)          ;in message
LED20:  POP     AF              ;retrieve byte
        LD      (BSOUR),A       ;store it in (BSOUR)
        CALL    LEE97           ;set serial data line inactive
        CP      3FH             ;???
        JR      NZ,LED2E        ;???
        CALL    LEE85           ;set serial clock line inactive
LED2E:  LD      A,(COPYBF)      ;get the copy of port BF
        OR      08H             ;set attention line to active
        LD      (COPYBF),A      ;save it in the variable
        OUT     (0BFH),A        ;and out it to the port
LED36:  CALL    LEE8E           ;set serial clock line active
        CALL    LEE97           ;set serial data line inactive
        CALL    LEEB3           ;900 uS delay

;SEND BYTE FROM (BSOUR) ON SERIAL BUS
LED40:  CALL    LEE97           ;set serial data line inactive
        CALL    LEEA9           ;lines to flags
        JR      C,LEDAD         ;jump if data is inactive
        CALL    LEE85           ;set serial clock line inactive
        LD      HL,EOI          ;get last byte in message flag
        BIT     7,(HL)          ;check if bit 7 is 0
        JR      Z,LED5A         ;jump if not a last byte
LED50:  CALL    LEEA9           ;lines to flags
        JR      NC,LED50        ;loop while data is active
LED55:  CALL    LEEA9           ;lines to flags
        JR      C,LED55         ;loop while data is inactive
LED5A:  CALL    LEEA9           ;lines to flags
        JR      NC,LED5A        ;loop while data is active
        CALL    LEE8E           ;set serial clock active
        LD      A,08H           ;eight bits
        LD      (BITCNT),A      ;store in variable
LED66:  IN      A,(0BFH)        ;read port
        AND     A               ;little
        AND     A               ;time delay
        LD      HL,BSOUR        ;point HL to the one byte buffer
        SLA     A               ;data to carry, clock to sign
        JR      NC,LED80        ;jump if data is active
        RRC     (HL)            ;rotate byte to the right
        JR      C,LED7A         ;jump if bit 0 is 1
        CALL    LEEA0           ;set serial data line active
        JR      LED7D           ;jump to LED&D
LED7A:  CALL    LEE97           ;set serial data line inactive
LED7D:  CALL    LEE85           ;set serial clock line inactive
LED80:  NOP                     ;time delay
        NOP
        NOP
        NOP
        LD      A,(COPYBF)      ;get last byte from port
        AND     0DFH            ;set data inactive
        OR      10H             ;set clock active
        LD      (COPYBF),A      ;put value into variable
        OUT     (0BFH),A        ;and output to the port
        LD      A,(BITCNT)      ;get bit counter
        DEC     A               ;decrement
        LD      (BITCNT),A      ;and store back
        JR      NZ,LED66        ;loop if byte not finished
        LD      B,50H           ;delay constant
LEDA6:  CALL    LEEA9           ;lines to flags
        JR      NC,LEDAB        ;jump if data is active
        DJNZ    LEDA6           ;loop around
        JR      LEDB0           ;jump if timeout reached
LEDAB:  RET                     ;ret

LEDAD:  LD      A,80H           ;device not present
        JR      LEDB2           ;continue there
LEDB0:  LD      A,03H           ;read and write timeout
LEDB2:  CALL    LFE1C           ;add A to ST
        JR      LEE03           ;end serial communication

;SEND SECONDARY ADDRESS AFTER LISTEN
LEDB9:  LD      (BSOUR),A       ;store A in buffer
        CALL    LED36           ;send byte

;SET SERIAL ATTENTION LINE INACTIVE
LEDBE:  LD      A,(COPYBF)
        AND     0F7H
        LD      (COPYBF),A
        OUT     (0BFH),A
        RET

;SEND SECONDARY ADDRESS AFTER TALK
LEDC7:  LD      (BSOUR),A
        CALL    LED36           ;send byte
        CALL    LEEA0           ;set serial data lline active
        CALL    LEDBE           ;set serial attention line inactive
        CALL    LEE85           ;set serial clock line inactive
LEDD6:  CALL    LEEA9           ;lines to flags
        JP      M,LEDD6         ;wait for clock to get active
        RET

;OUTPUT BYTE ON SERIAL BUS
LEDDD:  LD      HL,C3PO         ;check if bit 7 = 1
        BIT     7,(HL)          ;(send previous, keep current)
        JR      NZ,LEDE6        ;jumo if bit 7 = 1
        SET     7,(HL)          ;signal "there is a byte to be sent"
        JR      LEDEB           ;continue there
LEDE6:  PUSH    AF              ;save current byte
        CALL    LED40           ;send byte from (BSOUR) to serial bus
        POP     AF              ;pop current byte
LEDEB:  LD      (BSOUR),A       ;and store in (BSOUR)
        AND     A               ;clear carry
        RET                     ;ret

;SEND UNTALK ON SERIAL BUS
LEDEF:  CALL    LEE8E           ;set serial clock line active
        LD      A,(COPYBF)      ;get copy of port BF data
        AND     08H             ;set attention line to active
        LD      (COPYBF),A      ;save data in the copy variable
        OUT     (0BFH),A        ;and also out to the port
        LD      A,5FH           ;untalk command
        JR      LEE00           ;continue there

;SEND UNLISTEN ON SERIAL BUS
LEDFE:  LD      A,3FH           ;unlisten command
LEE00:  CALL    LED11           ;send the byte

;END SERIAL COMUNICATION
LEE03:  CALL    LEDBE           ;set serial attention line inactive
LEE06:  LD      B,0AH           ;constant for a little time delay
LEE09   DEC     B               ;decrement counter
        JR      NZ,LEE09        ;loop till B = 0
        CALL    LEE85           ;set serial clock line inactive
        JP      LEE97           ;setserial data line inactiv and ret

;INPUT BYTE FROM SERIAL BUS
LEE13:  NOP                     ;disable ints
        LD      A,00H           ;signal first timeout
        LD      (BITCNT),A      ;store in variable
        CALL    LEE85           ;set serial clock inactive
LEE1B:  CALL    LEEA9           ;data to carry, clock to sign
        JP      P,LEE1B         ;jump if clock is active
LEE20:  CALL    LEE97           ;set serial data inactive
        LD      B,20H           ;time delay constant
LEE37:  CALL    LEEA9           ;lines to flags
        JP      P,LEE56         ;jump if clock is active
        DJNZ    LEE37           ;loop around
LEE3E:  LD      A,(BITCNT)      ;get variable
        AND     A               ;is it the first timeout?
        JR      Z,LEE47         ;jump if yes
        LD      A,02H           ;else signal read timeout
        JP      LEDB2           ;add A TO ST and end communication

LEE47:  CALL    LEEA0           ;set serial data line active
        CALL    LEE85           ;set serial clock line inactive
        LD      A,40H           ;set bit 6 (EOI)
        CALL    LFE1C           ;add A to ST
        LD      A,(BITCNT)      ;get variable
        INC     A               ;signal 'not the first timeout'
        LD      (BITCNT),A      ;store it back
        JR      NZ,LEE20        ;jump if not the first timeout (always)
LEE56:  LD      A,08H           ;eight bits
        LD      (BITCNT),A      ;store in bit counter
LEE5A:  IN      A,(0BFH)        ;read port
        AND     A               ;time delay
        AND     A
        SLA     A               ;data to carry, clock to sign
        LD      HL,AUXA4        ;aux variable for byte creation
        JP      P,LEE5A         ;loop if clock still active
        RR      (HL)            ;insert the carry, (data line state) into byte
LEE67:  IN      A,(0BFH)        ;read port
        AND     A               ;time delay
        AND     A
        SLA     A               ;data to carry, clock to sign
        JP      M,LEE67         ;loop if clock still inactive
        LD      A,(BITCNT)      ;get bit counter
        DEC     A               ;decrement it
        LD      (BITCNT),A      ;store it back
        JR      NZ,LEE5A        ;process next bit
        CALL    LEEA0           ;set serial data line active
        LD      HL,ST           ;point HL to ST
        BIT     6,(HL)          ;check for EOI
        JR      Z,LEE80         ;jump if not EOI
        CALL    LEE06           ;end of communication
LEE80:  LD      A,(AUXA4)       ;pass the byte just inputted to A
        AND     A               ;clear carry
        RET                     ;ret

;SET SERIAL CLOCK LINE INACTIVE
LEE85:  LD      A,(COPYBF)
        AND     0EFH
        LD      (COPYBF),A
        OUT     (0BFH),A
        RET

;SET SERIAL CLOCK LINE ACTIVE
LEE8E:  LD      A,(COPYBF)
        OR      10H
        LD      (COPYBF),A
        OUT     (0BFH),A
        RET

;SET SERIAL DATA LINE INACTIVE
LEE97:  LD      A,(COPYBF)
        AND     0DFH
        LD      (COPYBF),A
        OUT     (0BFH),A
        RET

;SET SERIAL DATA LINE ACTIVE
LEEA0:  LD      A,(COPYBF)
        OR      20H
        LD      (COPYBF),A
        OUT     (0BFH),A
        RET

;MOVE DATA TO CARRY, CLOCK TO SIGN
LEEA9:  IN      A,(0BFH)
        SLA     A
        RET

;DELAY 900 uS
LEEB3:  LD      A,B             ;save the current B state
        LD      B,0B8H          ;delay constant
LEEB6:  DEC     B               ;decrement counter
        JR      NZ,LEEB6        ;loop back if not zero
        LD      B,A             ;retrieve B
        RET                     ;and ret

;CLEAR THE CARRY TO SIGNAL 'ERROR'
LF3D3:  AND     A               ;signal 'error'
        RET                     ;ret

;OPEN FOR SERIAL BUS DEVICES
LF3D5:  LD      A,(SA)          ;get the current secondary address
        AND     A               ;is it already open ?
        JP      M,LF3D3         ;jump if yes
        LD      A,(FNLEN)       ;get filename length
        AND     A               ;is it zero ?
        JR      Z,LF3D3         ;jump if yes
        LD      A,00H           ;signal 'no error'
        LD      (ST),A          ;in ST
        LD      A,(FA)          ;get the current device number
        CALL    LED0C           ;send listen
        LD      A,(SA)          ;get the current secondary address
        OR      0F0H            ;secondary for open
        CALL    LEDB9           ;send secondary address for listen
        LD      A,(ST)          ;get the serial status
        AND     A               ;has an error occurred ?
        JP      P,LF3F6         ;jump if not
        POP     AF              ;pop the return address
        JP      LF707           ;device not present error

LF3F6:  LD      A,(FNLEN)       ;get the filename length
        AND     A               ;is it 0 ?
        JR      Z,LF406         ;jump if yes
        LD      B,A             ;copy name length to B
        LD      HL,(FNADR)      ;point HL to the name buffer
LF3FC:  PUSH    HL              ;save registers
        PUSH    BC              ;in the stack
        LD      A,(HL)          ;get byte from name
        CALL    LEDDD           ;output byte
        POP     BC              ;retrieve registers
        POP     HL              ;from the stack
        INC     HL              ;inc pointer
        DJNZ    LF3FC           ;loop to process next byte
LF406:  JP      LF654           ;send unlisten and ret

;CLOSE SERIAL BUS DEVICE
LF642:  LD      A,(SA)          ;get secondary address
        AND     A               ;check for bit 7
        JP      M,LF657         ;jump if set
        LD      A,(FA)          ;current device number
        CALL    LED0C           ;send listen on serial bus
        LD      A,(SA)          ;get current sec address
        AND     0EFH            ;???
        OR      0E0H            ;secondary address to close
        CALL    LEDB9           ;send secondary address for listen
LF654:  CALL    LEDFE           ;send unlisten
LF657:  AND     A               ;clear carry
        RET                     ;ret


;DEVICE NOT PRESENT
LF707:  LD      BC,1600H        ;line 22 col 0
        LD      (CSRX),BC       ;set cursor position
        CALL    CLRLIN          ;clear the line
        LD      DE,DEV_NP       ;message 'DEVICE NOT PRESENT'
        CALL    PRMSG           ;print ascii message

;REPROT E - DISK ERROR
ERRORE: CALL    ERROR           ;error handling
        DEFB    0DH             ;report E

;REPORT F - INVALID FILE NAME
ERRORF: CALL    ERROR           ;error handling
        DEFB    0EH             ;report F

;RETURN TO BASIC WITH NO ERROR (MENU OPTION)
ERROR0: LD      HL,MYFLAG       ;internal flag
        RES     0,(HL)          ;signal 'not from the menu'
        CALL    D_BOUNC         ;update DB-ST
        CALL    ERROR           ;return to basic
        DEFB    0FFH            ;with no error

;ERROR HANDLING ROUTINE
ERROR:  LD      HL,MYFLAG       ;check if the program is
        BIT     0,(HL)          ;running from the menu
        JR      Z,BASERR        ;jump if not
        LD      SP,(MYSP)       ;restore the saved SP
        CALL    SLOW            ;put the machine in slow
        LD      BC,1700H        ;line 23 col 0
        LD      (CSRX),BC       ;set as cursor position
        LD      DE,PRESSM       ;'PRESS ANY KEY' message
        CALL    PRMSG           ;print it
ERR_1:  CALL    RDKBD           ;read the keyboard
        JR      NC,ERR_1        ;loop back if no key depressed
        JP      START1          ;else jump back to menu

;LET BASIC TO PROCESS ERRORS WHEN THE PROGRAM IS NOT RUNING FRON THE MENU
BASERR: CALL    PAGUSR          ;page in the user ram
        JP      08H             ;jump yo basic error handling routine

;PRINT THE ASCII MESSAGE POINTED BY 'DE' AND ENDED WITH '$'
PRMSG:  LD      A,(DE)          ;get byte from message
        INC     DE              ;increment pointer
        CP      '$'             ;is it a '$'?
        RET     Z               ;if yes then return
        PUSH    DE              ;else save ptr
        CALL    PRCHR           ;print the ascii chr
        POP     DE              ;rtrieve pointer
        JR      PRMSG           ;loop to process next chr

;ADD BITS IN A TO ST
LFE1C:  LD      HL,ST           ;point HL to ST
        OR      (HL)            ;add the bits in A
        LD      (HL),A          ;store in ST
        RET                     ;ret

;INITIALIZE PORT BF, RELEASING INTERFACE LINES AND PAGE SYSTEM RAM
INITBF: LD      A,02H           ;system ram and all lines inactive
        LD      (COPYBF),A      ;save in the variable
        OUT     (0BFH),A        ;out to the interface write only register
        RET                     ;ret

;INITIALIZE VARIABLES
INITVAR:LD      A,08H           ;set device 8
        LD      (FA),A          ;as current device number
        LD      A,12H           ;set '>'
        LD      (CURNRM),A      ;as normal cursor
        LD      A,92H           ;set inverted '>'
        LD      (CURINV),A      ;as inverted cursor
        LD      HL,MYFLAG       ;signal 'in menu'
        SET     0,(HL)          ;in the flag
        RET                     ;ret

;PAGE SYSTEM RAM AT 8000H
PAGSYS: LD      A,(COPYBF)      ;get the copy of the BF port
        OR      02H             ;page system ram at 8000H
        LD      (COPYBF),A      ;save it back in the variable
        OUT     (0BFH),A        ;out to the interface port
        RET                     ;ret

;PAGE USER RAM AT 8000H
PAGUSR: LD      A,(COPYBF)      ;get the copy of the BF port
        AND     0FDH            ;page user ram at 8000H
        LD      (COPYBF),A      ;save it back in the variable
        OUT     (0BFH),A        ;out to the interface port
        RET                     ;ret

;PRINT MESSAGES FROM COORDINATES READ FROM TABLE
;DE = table address

;COORDINATES AND MESSAGES TABLE
; - line (0 thru 23)
; - column (0 thru 31)
; - '$' teminated message
; - line
; - column
; - '$' terminated message
;      :
;      :
;end of table 0ffh
;
;line 0 column 0 is the top left corner
;line 23 column 31 is the bottom right corner
;

PRMENU: LD      A,(DE)          ;get byte from table
        INC     DE              ;inc pointer
        CP      0FFH            ;is it the end marker?
        RET     Z               ;if yes then ret
        LD      (CSRY),A        ;update the line
        LD      A,(DE)          ;get byte from table
        INC     DE              ;inc pointer
        LD      (CSRX),A        ;update the column
        CALL    PRMSG           ;print the message
        JR      PRMENU          ;process next one


;EXPANDS THE DISPLAY FILE IF IT WAS COLLAPSED
EXTRA:  LD      (IY+22H),00H    ;(DF-SZ)=0 -> all the screen is printable
        LD      HL,0300H        ;768 spaces
SPACES: XOR     A               ;are printed
        RST     10H             ;to expand the display file
        DEC     HL              ;dec the byte count
        LD      A,H             ;check if the counter
        OR      L               ;reached zero
        JR      NZ,SPACES       ;loop back if not

;POINT TO SCREEN BEGINING LIKE A CLS DOES
        LD      BC,0000H        ;AT 0,0
        CALL    PRNT_AT         ;call the at routine 08F5H in rom
        LD      HL,0000H        ;set col 0 line 0
        LD      (CSRX),HL       ;as cursor position
        RET                     ;ret

;ZX SPECTRUM RST 10 PARTIAL EMULATION
;CALCULATE THE PRINT ADDRESS IN HL GIVEN THE COORDINATES IN BC
ATCALC: LD      H,00H           ;make high byte = 0
        LD      L,B             ;copy line to 'L'
        ADD     HL,HL           ;line * 2
        ADD     HL,HL           ;line * 4
        ADD     HL,HL           ;line * 8
        ADD     HL,HL           ;line * 16
        ADD     HL,HL           ;line * 32
        LD      E,C             ;save column in 'E'
        LD      C,B             ;line to 'C'
        LD      B,00H           ;high byte = 0
        ADD     HL,BC           ;line * 32 + line = line * 33
        LD      C,E             ;pass column to 'C'
        ADD     HL,BC           ;line * 33 + column to HL
        LD      BC,(D_FILE)     ;get the display file address
        INC     BC              ;skip the 76H at the begining
        ADD     HL,BC           ;obtain the print address in HL
        RET                     ;ret

;PRINT THE CHR IN 'A' IN TTY MODE
PRTTY:  PUSH    AF              ;save character
        LD      HL,CSRY         ;point HL to 'current line' variable
        LD      A,24            ;line 24
        CP      (HL)            ;are we in that line?
        CALL    Z,SCROL1        ;if yes then scroll
        LD      BC,(CSRX)       ;get current coordinates
        CALL    ATCALC          ;calculate the print address
        POP     AF              ;retrieve the character
        CP      76H             ;is it ENTER?
        JR      Z,ENTER1        ;jump if yes
        CP      77H             ;is it BACKSPACE?
        JR      Z,BACKS1        ;jump if yes
        LD      (HL),A          ;print the chr
        LD      HL,CSRX         ;point HL to 'current column' variable
        INC     (HL)            ;point to the next position
        LD      A,32            ;column 32?
        CP      (HL)            ;are we in that column?
        RET     NZ              ;return if not
PRTTY1: LD      (HL),00         ;point to column 0
        INC     HL              ;point HL to 'current line position'
        INC     (HL)            ;increment line
        RET                     ;ret

ENTER1: LD      HL,CSRX         ;make column = 0
        JR      PRTTY1          ;and increment line

BACKS1: LD      A,(CSRX)        ;get current column
        AND     A               ;is it zero?
        RET     Z               ;if yes, then do nothing
        DEC     A               ;decremrnt column
        LD      (CSRX),A        ;store in variable
        RET                     ;ret

;SCROLL UP AND ADJUST THE PRINT POSITION AT THE BEGINING OF THE LAST LINE
SCROL1: LD      DE,(D_FILE)     ;get the display file address
        INC     DE              ;point dest ptr to the beginig of 1st line
        LD      HL,33           ;line length including the final ENTER
        ADD     HL,DE           ;point source ptr to the begining of 2nd line
        LD      BC,759          ;23 lines * 33 chrs = 759
        LDIR                    ;scroll up the screen
        LD      H,D             ;DE points to the begining of line 23
        LD      L,E             ;pass DE to HL
        INC     DE              ;point to the 2nd chr
        LD      (HL),00         ;delete first character
        LD      BC,31           ;31 chrs more to be deleted
        LDIR                    ;do it
        LD      BC,1700H        ;line 23 col 0
        LD      (CSRX),BC       ;set coordinates
        RET                     ;ret

;TABLE ACCESS TO PRINT ASCII CHARACTERS ON ZX81 SCREEN
PRCHR:  PUSH    HL              ;save registers
        PUSH    BC
        CP      7FH             ;any chr above 7FH will be
        JR      NC,QUESTM       ;printed as a question mark
        LD      HL,ASC2ZX       ;conversion table
        LD      C,A             ;index through
        LD      B,0             ;the table in order to
        ADD     HL,BC           ;get the ZX character
        LD      A,(HL)          ;ZX chr in 'A'
        CALL    PRTTY           ;print it
        POP     BC              ;rtrieve registers
        POP     HL
        RET                     ;ret
QUESTM: LD      A,0FH           ;Sinclair '?'
        JR      PRTTY           ;print it and ret

;NAME:   DEFB    'SOSVEGA',0FFH


DEV_NP  DEFB    'DEVICE NOT PRESENT$'
PRESSM: DEFB    'PRESS ANY KEY$'
MNMENU: DEFB    0,0,'CZ1500 / CBM1541 DISK INTERFACE$'
        DEFB    1,10,'VERSION 1.0F$'
        DEFB    3,5,'B - RETURN TO BASIC$'
        DEFB    5,5,'C - CHANGE DEVICE NUMBER$'
        DEFB    7,5,'D - DIRECTORY$'
        DEFB    9,5,'L - LOAD PROGRAM$'
        DEFB    11,5,'S - SAVE PROGRAM$'
        DEFB    13,5,'X - GET DRIVE STATUS$'
        DEFB    15,5,'Z - SEND COMMAND$'
        DEFB    18,5,'DEVICE NUMBER : $'
        DEFB    0FFH

;DATAPTR:DEFW    0000H
;KYGOOD: DEFB    00H             ;key held down flag
;BUFPTR: DEFW    0000H           ;edit buffer pointer
;CURINV: DEFB    00H             ;'inverted' cursor (space)
;CURNRM: DEFB    12H             ;'normal' cursor (>)
;EDBUFF: DEFS    20H             ;32 byte edit buffer

;AUXA4:  DEFB    00H             ;auxiliar variable for byte creation
;COPYBF: DEFB    00H             ;copy of port 0BFH data
;ST      DEFB    00H     ;$90    ;serial bus stsrus
;C3PO    DEFB    00H     ;$94    ;flag, indicates if a buffered byte is present
;BSOUR   DEFB    00H     ;$95    ;one byte buffer
;EOI     DEFB    00H     ;$A3    ;flag, (last byte in message)
;BITCNT  DEFB    00H     ;$A5    ;bit count for sending and receiving data
;FNLEN   DEFB    00H     ;$B7    ;command length
;SA      DEFB    00H     ;$B9    ;secondary address
;FA      DEFB    00H     ;$BA    ;device number
;FNADR   DEFW    0000H   ;$BB    ;command address
;CSRX:   DEFB    00H             ;column position
;CSRY:   DEFB    00H             ;line position

L09131: EQU     PRBUFF
EDBUFF: EQU     PRBUFF          ;32 byte edit buffer

AUXA4:  EQU     MEMBOT          ;auxiliar variable for byte creation
COPYBF: EQU     MEMBOT+1        ;copy of port 0BFH data
ST      EQU     MEMBOT+2 ;$90   ;serial bus status
C3PO    EQU     MEMBOT+3 ;$94   ;flag, indicates if a buffered byte is present
BSOUR   EQU     MEMBOT+4 ;$95   ;one byte buffer
EOI     EQU     MEMBOT+5 ;$A3   ;flag, (last byte in message)
BITCNT  EQU     MEMBOT+6 ;$A5   ;bit count for sending and receiving data
FNLEN   EQU     MEMBOT+7 ;$B7   ;command length
SA      EQU     MEMBOT+8 ;$B9   ;secondary address
FA      EQU     MEMBOT+9 ;$BA   ;device number
FNADR   EQU     MEMBOT+10;$BB   ;command address

DATAPTR:EQU     MEMBOT+12
BUFPTR: EQU     MEMBOT+14       ;edit buffer pointer
KYGOOD: EQU     MEMBOT+16       ;key held down flag
CURINV: EQU     MEMBOT+17       ;'inverted' cursor (space)
CURNRM: EQU     MEMBOT+18       ;'normal' cursor (>)

CSRX:   EQU     MEMBOT+19       ;column position
CSRY:   EQU     MEMBOT+20       ;line position
MYFLAG: EQU     MEMBOT+21       ;B0=1 inmenu
MYSP:   EQU     MEMBOT+22

;SYSTEM ROM EQUS
FAST    EQU     02E7H
SLOW    EQU     0F2BH
CLS     EQU     0A2AH
KEY_SCN EQU     02BBH
KEY_DEC EQU     07BDH
PRNT_AT EQU     08F5H
OUT_NUM EQU     0A98H
CHK_BRK EQU     0F46H
D_BOUNC EQU     0F4BH
NAME    EQU     03A8H

BIGBUF  EQU     8009H

;ASCII TO ZX CONVERSION TABLE
ASC2ZX: DB 0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH      ;ctrl @ to ctrl G
        DB 77H,0FH,0FH,0FH,0FH,76H,0FH,0FH      ;ctrl H to ctrl O
        DB 0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH      ;ctrl P to ctrl W
        DB 0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH      ;ctrl X to ctrl ....1FH
        DB 00H,0FH,0BH,0DH,0FH,0FH,0FH,0FH      ;space to '
        DB 10H,11H,17H,15H,1AH,16H,1BH,18H      ;( to /
        DB 1CH,1DH,1EH,1FH,20H,21H,22H,23H      ;0 to 7
        DB 24H,25H,0EH,19H,13H,14H,12H,0FH      ;8 to ?
        DB 0FH,26H,27H,28H,29H,2AH,2BH,2CH      ;@ to G
        DB 2DH,2EH,2FH,30H,31H,32H,33H,34H      ;H to O
        DB 35H,36H,37H,38H,39H,3AH,3BH,3CH      ;P to W
        DB 3DH,3EH,3FH,0FH,0FH,0FH,0FH,0FH      ;X to _
        DB 0FH,26H,27H,28H,29H,2AH,2BH,2CH      ;@ to g
        DB 2DH,2EH,2FH,30H,31H,32H,33H,34H      ;h to o
        DB 35H,36H,37H,38H,39H,3AH,3BH,3CH      ;p to w
        DB 3DH,3EH,3FH,0FH,0FH,0FH,0FH,0FH      ;x to 

;ZX TO ASCII CONVERSION TABLE
CONVTAB:DB ' ??????????"@$:?'   ;ZX to ASCII conversion table
        DB '()><=+-*/;,.0123'
        DB '456789ABCDEFGHIJ'
        DB 'KLMNOPQRSTUVWXYZ'

        ENDLOC
;END OF LINE 0, AND MACHINE CODE PROGRAM
ENDL0:  DEFB    76H

LINE1:  DEFB    00H
        DEFB    01H
        DEFW    ENDL1-LINE1-3
        DEFB    0F9H,0D4H,0C5H, 0BH     ;RAND USR VAL "
        DEFB     1DH, 22H, 21H, 1DH, 20H;16514
        DEFB    0BH                     ;"
ENDL1:  DEFB    76H

;COLLAPSED DISPLAY FILE
DFILE1: DEFB     76H, 76H, 76H, 76H, 76H, 76H, 76H, 76H
        DEFB     76H, 76H, 76H, 76H, 76H, 76H, 76H, 76H
        DEFB     76H, 76H, 76H, 76H, 76H, 76H, 76H, 76H
        DEFB    76H
VARS1:  DEFB    80H
        END
