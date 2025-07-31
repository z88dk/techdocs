
; PC8801 N88-BASIC
; main banks, 24K + 8K


NOTE  -   to call machine code from BASIC (e.g. at 32768):

	a=&h8000
	call a

	-or-

	DEF USR=&H8000:U=USR(0)



00000000:       DI
00000001:       LD SP,E1A0h
00000004:       JP 3BE5h		; START

00000007:       NOP

00000008:       LD A,(HL)
00000009:       EX HL,(SP)
0000000A:       CP (HL)
0000000B:       INC HL
0000000C:       EX HL,(SP)
0000000D:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'

00000010:       INC HL
00000011:       LD A,(HL)
00000012:       CP 3Ah		; ':'
00000014:       RET NC
00000015:       JP 0A15h

; OUTC
00000018:       PUSH AF
00000019:       CALL ED42h
0000001C:       JP 5925h

0000001F:       NOP

; CPDEHL - compare DE and HL (aka DCOMPR)
00000020:       LD A,H
00000021:       SUB D
00000022:       RET NZ
00000023:       LD A,L
00000024:       SUB E
00000025:       RET
00000026:       NOP
00000027:       NOP

; SIGN - test FP number sign
00000028:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
0000002B:       OR A
0000002C:       JP NZ,2083h
0000002F:       RET

; GETYPR -  Test number FAC type (Precision mode, etc..)
00000030:       LD A,(EABDh)		; VALTYP - type indicator
00000033:       CP 08h
00000035:       JP 1527h

; KEYINT - interrupt handler
00000038:       JP E669h

0000003B:       NOP
0000003C:       NOP
0000003D:       NOP
0000003E:       NOP
0000003F:       NOP

00000040:       AND B
00000041:       LD HL,21FDh				; INT_RESULT_HL
00000044:       LD A,(HL)
00000045:       AND A
00000046:       RET Z
00000047:       CP 20h		; ' '
00000049:       RET

0000004A:       LD HL,FFFFh
0000004D:       LD (E656h),HL			; CURLIN - line number being interpreted
00000050:       INC HL
00000051:       RET

00000052:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000055:       POP BC
00000056:       POP BC
00000057:       LD C,A
00000058:       LD A,B
00000059:       OUTA (71h)				; Extended ROM bank switching
0000005B:       LD A,C
0000005C:       POP BC
0000005D:       JP 11E9h			; EVAL3

00000060:       CALL 05BDh
00000063:       CALL 4F21h			; RUN_FST
00000066:       JP 4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'

00000069:       CALL ED9Fh
0000006C:       DI
0000006D:       LD A,(E6C2h)	; Value being sent to port 31h (bank switching)
00000070:       RET

00000071:       NOP
00000072:       LD A,(E6B9h)		; TextIsColor, Color / monochrome switch
00000075:       AND A
00000076:       SCF
00000077:       CALL NZ,4021h		; Clean bottom text row
0000007A:       JP 6F6Ah			; CRTSET - on stack: columns, rows

0000007D:       CALL 1896h				; POSINT - Get positive integer
00000080:       PUSH AF
00000081:       LD A,D
00000082:       CP 02h
00000084:       JR NZ,+01h
00000086:       DEC D
00000087:       POP AF
00000088:       RET

00000089:       NOP

; PRITAB - Arithmetic precedence table
0000008A:  DEFB $79  ; +   (Token code $F1)
0000008B:  DEFB $79  ; -
0000008C:  DEFB $7c  ; *
0000008D:  DEFB $7c  ; /
0000008E:  DEFB $7f  ; ^
0000008F:  DEFB $50  ; AND 
00000090:  DEFB $46  ; OR
00000091:  DEFB $3c  ; XOR
00000092:  DEFB $32  ; EQU
00000093:  DEFB $28  ; IMP
00000094:  DEFB $7a  ; MOD
00000095:  DEFB $7b  ; \   (Token code $FC)


; TYPE_OPR - NUMBER TYPE CONVERSION OPERATIONS TABLE  
00000096:	DEFW	223Eh	; CDBL
00000098:	DEFW	0
0000009A:	DEFW	21A0h	; CINT
0000009C:	DEFW	2256h	; TSTSTR - Test a string, 'Type Error' if it is not
0000009E:	DEFW	2214h	; CSNG - Convert number to single precision


; DEC_OPR - ARITHMETIC OPERATIONS TABLE  
000000A0: DEFW	2424h	; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
000000A2: DEFW	241Dh	; DBL_SUB Double precision SUB (formerly DECSUB, SUBCDE)
000000A4: DEFW	2553h	; DBL_MUL Double precision MUL (formerly DECMUL)
000000A6: DEFW	2629h	; DBL_DIV Double precision DIV (formerly DECDIV)
000000A8: DEFW	2199h	; DECCOMP - Double precision compare

; FLT_OPR - FP SINGLE PRECISION OPERATIONS TABLE
000000AA: DEFW	1DE9h	; FPADD - Add BCDE to FP reg (a.k.a. FADD)
000000AC: DEFW	1DE6h	; SUBCDE - Subtract BCDE from FP reg (a.k.a. FSUB)
000000AE: DEFW	1F53h	; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
000000B0: DEFW	1FB7h	; FDIV - FP reg division
000000B2: DEFW	2134h	; CMPNUM - Compare FP reg to BCDE

; INT_OPR - INTEGER ARITHMETIC OPERATIONS TABLE  
000000B4: DEFW	233Ah	; IADD - Integer ADD
000000B6: DEFW	232Fh	; ISUB - Integer SUB
000000B8: DEFW	235Ah	; INT_MUL - Integer MULTIPLY (aka IMULT)
000000BA: DEFW	1341h	; INT_DIV - Integer DIVISION (aka IDIV)
000000BC: DEFW	215Fh	; ICOMP - INTEGER COMPARE




;0000782E:       LD BC,0253h
;00007831:       LD HL,00BEh
;00007834:       LD DE,E600h
;00007837:       LD (EACCh),HL			; STREND (aka STRTOP) - string area top address
;0000783A:       LDIR

; Data to be copied on bottom of RAM (system variables, service routines, etc..)
; 
; 00BE -> E600

;E600  D6 00 6F 7C DE 00 67 78-DE 00 47 3E 00 C9 00 00   ..o|..gx..G>....
;E610  00 35 4A CA 99 39 1C 76-98 22 95 B3 98 0A DD 47   .5J..9.v.".....G
;E620  98 53 D1 99 99 0A 1A 9F-98 65 BC CD 98 D6 77 3E   .S.......e....w>
;E630  98 52 C7 4F 80 06 0B 06-0B 06 0B 06 0B 06 0B 06   .R.O............
;E640  0B 06 0B 06 0B 06 0B 06-0B 00 00 00 00 EE FF 28   ...............(
;E650  0E 00 00 00 B9 F2 FE FF-56 F2 56 60 4E 45 43 30   ........V.V`NEC0
;E660  30 30 30 30 30 30 31 0D-0A C3 00 00 C9 00 00 C9   0000001.........
;E670  00 00 C3 CE 60 C3 CE 60-C3 CE 60 C9 00 00 C9 00   ....`..`..`.....
;E680  00 C9 00 00 D3 71 E5 21-54 01 E3 7E FE 52 C0 23   .....q.!T..~.R.#
;E690  7E FE 34 C0 23 E9 3E FF-D3 71 C9 C9 1E 10 FF 00   ~.4.#.>..q......
;E6A0  FF 00 FF FF 01 00 00 01-81 00 01 FF FF 00 06 36   ...............6
;E6B0  01 13 01 19 00 20 00 00-FF 00 00 00 00 00 00 00   ..... ..........
;E6C0  22 11 00 FF C8 F3 00 00-00 00 00 CD EF 00 00 1C   "...............
;E6D0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;E6E0  00 00 00 00 00 00 00 00-00 00 00 00 FF 00 15 CB   ................
;E6F0  EE 00 6C 6F 61 64 20 22-00 00 00 00 00 00 00 00   ..load "........
;  (..; 01B0h -> E6F2h)


; Data to be copied on bottom of RAM (system variables, service routines, etc..)
; 
; 00BE -> E600
000000BE:       DEFB D6h
000000BF:       NOP
; E602
000000C0:       LD L,A
000000C1:       LD A,H
000000C2:       SBC 00h
000000C4:       LD H,A
000000C5:       LD A,B
000000C6:       SBC 00h
000000C8:       LD B,A
000000C9:       LD A,00h
000000CB:       RET

; E60E - used by FP functions
000000CC:       NOP
000000CD:       NOP

; E610 - RNDX
000000CE:       NOP
000000CF:       DEC (HL)
000000D0:       LD C,D
000000D1:       JP Z,3999h
000000D4:       INC E
000000D5:       HALT
000000D6:       SBC B
000000D7:       LD (B395h),HL
000000DA:       SBC B
000000DB:       LD A,(BC)
000000DC:       LD B,A
000000DE:       SBC B
000000DF:       LD D,E
000000E0:       POP DE
000000E1:       SBC C
000000E2:       SBC C
000000E3:       LD A,(BC)
000000E4:       LD A,(DE)
000000E5:       SBC A
000000E6:       SBC B
000000E7:       LD H,L
000000E8:       CP H
000000E9:       CALL D698h
000000EC:       LD (HL),A
000000ED:       LD A,98h
000000EF:       LD D,D
000000F0:       RST 00h
000000F1:       LD C,A
000000F2:       ADD B

; E635	-  USR0
000000F3:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
000000F5:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
000000F7:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
000000F9:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
000000FB:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
000000FD:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
000000FF:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
00000101:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
00000103:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"
; E647	-  USR9
00000105:       DEFB 0B06h			; FCERR, Err $05 - "Illegal function call"

; E649	-  ERRFLG
00000107:       NOP

00000108:       NOP

; E64B - LPTPOS (printer cursor position)
00000109:       NOP

; E64C - PRTFLG ("printer enabled" flag)
0000010A:       NOP

; E64D, E64E ..still related to printer position
0000010B:       XOR FFh

; E64F - TTYPOS2
0000010D:       DEFB 28h		; 40

; E650 - CLMLST (Column space)
0000010E:       DEFB 0Eh		; 14

; E651
0000010F:       NOP

; E652
00000110:       NOP

; E653
00000111:       NOP

; E654 - STKTOP
00000112:		DEFW $F2B9

; E656 - CURLIN (line number being interpreted)
00000114:		DEFW $FFFE

; E658 - TXTTAB (aka BASTXT) - address of BASIC program start
00000116:		DEFW $F256

; E65A
00000118:		DEFW $6056

; E65C
0000011A:       DEFB "NEC00000001", $0D, $0A

; E669 - KEYINT (interrupt handler)
00000127:       JP 0000h
0000012A:       RET

; E66D
0000012B:       NOP
0000012C:       NOP
0000012D:       RET

; E670
0000012E:       NOP
0000012F:       NOP

; E672
00000130:       JP 60CEh

; E675
00000133:       JP 60CEh

; E678
00000136:       JP 60CEh

; E67B
00000139:       RET

; E67C
0000013A:       NOP
0000013B:       NOP
0000013C:       RET

; E67F
0000013D:       NOP
0000013E:       NOP
0000013F:       RET

; E682
00000140:       NOP
00000141:       NOP

; E684
00000142:       OUTA (71h)				; Extended ROM bank switching
00000144:       PUSH HL
00000145:       LD HL,0154h
00000148:       EX HL,(SP)
00000149:       LD A,(HL)
0000014A:       CP 52h
0000014C:       RET NZ
0000014D:       INC HL
0000014E:       LD A,(HL)
0000014F:       CP 34h
00000151:       RET NZ
00000152:       INC HL
00000153:       LD PC,HL

; E696
00000154:       LD A,FFh				; back to main ROM
00000156:       OUTA (71h)				; Extended ROM bank switching
00000158:       RET

; E69B
00000159:       RET

0000015A:       LD E,10h
0000015C:       RST 38h
0000015D:       NOP
0000015E:       RST 38h
0000015F:       NOP
00000160:       RST 38h
00000161:       RST 38h
00000162:       LD BC,0000h
00000165:       LD BC,0081h
00000168:       LD BC,FFFFh
0000016B:       NOP
0000016C:       LD B,36h
0000016E:       LD BC,0113h
00000171:       ADD HL,DE
00000172:       NOP
00000173:       JR NZ,+00h
00000175:       NOP
00000176:       RST 38h
00000177:       NOP
00000178:       NOP
00000179:       NOP
0000017A:       NOP
0000017B:       NOP
0000017C:       NOP
0000017D:       NOP
0000017E:       LD (0011h),HL
00000181:       RST 38h
00000182:       RET Z
00000183:       DI
00000184:       NOP
00000185:       NOP
00000186:       NOP
00000187:       NOP
00000188:       NOP
00000189:       CALL 00EFh
0000018C:       NOP
0000018D:       INC E
0000018E:       NOP
0000018F:       NOP
00000190:       NOP
00000191:       NOP
00000192:       NOP
00000193:       NOP
00000194:       NOP
00000195:       NOP
00000196:       NOP
00000197:       NOP
00000198:       NOP
00000199:       NOP
0000019A:       NOP
0000019B:       NOP
0000019C:       NOP
0000019D:       NOP
0000019E:       NOP
0000019F:       NOP
000001A0:       NOP
000001A1:       NOP
000001A2:       NOP
000001A3:       NOP
000001A4:       NOP
000001A5:       NOP
000001A6:       NOP
000001A7:       NOP
000001A8:       NOP
000001A9:       NOP
000001AA:       RST 38h
000001AB:       NOP
000001AC:       DEC D
000001AD:       SET 5,(HL)
000001AF:       NOP


; FNKSTR - FUNCTION KEY AREA
; 01B0h -> E6F2h
;(...)
;E6F0  EE 00 6C 6F 61 64 20 22-00 00 00 00 00 00 00 00   ..load "........
;E700  00 00 61 75 74 6F 20 00-00 00 00 00 00 00 00 00   ..auto .........
;E710  00 00 67 6F 20 74 6F 20-00 00 00 00 00 00 00 00   ..go to ........
;E720  00 00 6C 69 73 74 20 00-00 00 00 00 00 00 00 00   ..list .........
;E730  00 00 72 75 6E 0D 00 00-00 00 00 00 00 00 00 00   ..run...........
;E740  00 00 73 61 76 65 20 22-00 00 00 00 00 00 00 00   ..save "........
;E750  00 00 6B 65 79 20 00 00-00 00 00 00 00 00 00 00   ..key ..........
;E760  00 00 70 72 69 6E 74 20-00 00 00 00 00 00 00 00   ..print ........
;E770  00 00 65 64 69 74 20 2E-0D 00 00 00 00 00 00 00   ..edit .........
;E780  00 00 63 6F 6E 74 0D 00-00 00 00 00 00 00 00 00   ..cont..........
;E790  00 00 6C 69 74 65 72 61-6C 00 00 00 00 00 00 00   ..literal.......
;E7A0  00 00 68 61 6C 66 2F 66-75 6C 6C 00 00 00 00 00   ..half/full.....
;E7B0  00 00 4C 50 54 20 65 6E-61 62 6C 65 00 00 00 00   ..LPT enable....
;E7C0  00 00 63 6F 70 79 20 62-75 66 66 65 72 00 00 00   ..copy buffer...
;E7D0  00 00 4C 50 54 20 66 65-65 64 00 00 00 00 00 00   ..LPT feed......
;E7E0  00 00 C3 00 00 C3 00 00-FF E5 E5 21 67 31 F5 3A   ...........!g1.:


; MINUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
; -> E7E2h
000002A0:       JP 0000h

; MAXUPD = JP nn for RIGHTC, LEFTC, UPC and DOWNC 
; -> E7E5h
000002A3:       JP 0000h

; -> E7E8h
000002A6:       RST 38h

; -> E7E9h
000002A7:       PUSH HL


; -> E7EAh
000002A8:       PUSH HL
000002A9:       LD HL,3167h		; RXRDY - RS-232C receive interrupt handler
000002AC:       PUSH AF
000002AD:       LD A,(E6C2h)	; Value being sent to port 31h (bank switching)
000002B0:       PUSH AF
000002B1:       AND FBh			; 11111011: ROM mode = N88 mode
000002B3:       OUTA (31h)		; System control port #2
000002B5:       LD (E6C2h),A	; Value being sent to port 31h (bank switching)
000002B8:       CALL 3391h		; JP (HL)
000002BB:       DI
000002BC:       POP AF
000002BD:       OUTA (31h)		; System control port #2
000002BF:       LD (E6C2h),A	; Value being sent to port 31h (bank switching)
000002C2:       POP AF
000002C3:       POP HL
000002C4:       EI
000002C5:       RET

; -> E808h
000002C6:       PUSH HL
000002C7:       LD HL,3080h		; VRTCHANDLER - screen interrupt handler
000002CA:       JR -20h

; -> E80Eh
000002CC:       PUSH HL
000002CD:       LD HL,4143h		; 1/600 second timer interrupt handler
000002D0:       JR -26h

; -> E814h
000002D2:       PUSH HL
000002D3:       LD HL,3079h		; default handler for user interrupts: (points to "exit from interrupt")
000002D6:       JR -2Ch

; -> EDC4h
000002D8:       PUSH HL
000002D9:       LD HL,3CB9h		; FDINT_1 handler
000002DC:       JR -32h

; -> E620h
000002DE:       PUSH HL
000002DF:       LD HL,3CACh		; FDINT_2 handler
000002E2:       JR -38h

; -> E826h		; MON (monitor) command entry
000002E4:       CALL 0069h
000002E7:       NOP
000002E8:       OR 04h			; ROM mode = N-BASIC mode
000002EA:       OUTA (31h)		; System control port #2
000002EC:       LD (E6C2h),A	; Value being sent to port 31h (bank switching)
000002EF:       EI
000002F0:       LD A,(6000h)
000002F3:       CP 44h			; 'D'
000002F5:       JR NZ,+08h
000002F7:       LD A,(6001h)
000002FA:       CP 42h			; 'B'
000002FC:       JP Z,6002h
000002FF:       DI
00000300:       LD A,(E6C2h)	; Value being sent to port 31h (bank switching)
00000303:       AND FBh			; 11111011: ROM mode = N88 mode
00000305:       OUTA (31h)		; System control port #2
00000307:       LD (E6C2h),A	; Value being sent to port 31h (bank switching)
0000030A:       EI
0000030B:       JP 4DC1h		; 'Feature not available' error

;---------------------------------------------------------------------------------------------------------
; End of area beind relocated at E600
;---------------------------------------------------------------------------------------------------------

0000030E:       DEFS " Error"
00000314:       NOP

00000315:       DEFS " in "
00000318:       NOP

0000031A:       DEFS "Ok"
0000031C:       DEFB FFh
0000031D:       DEFB 0Dh
0000031E:       DEFB 0Ah
0000031F:       NOP

00000320:       "Break"
00000325:       NOP


; Interrupt table to be copied to bottom of RAM
; 
; $0326 -> $F300, 32 bytes

0000326:        DEFW    $E7EA  ; Lv.0 	$F300 	RXRDY 	RS-232C receive interrupt
0000328:        DEFW    $E808  ; Lv.1 	$F302 	VRTC 	Screen end interrupt 1/60 seconds
000032A:        DEFW    $E80E  ; Lv.2 	$F304 	CLOCK 	Real time clock 1/600 sec
000032C:        DEFW    $E814  ; Lv.3 	$F306 	INT 4 	User interrupt (sound source)
000032E:        DEFW    $E814  ; Lv.4 	$F308 	INT 3 	User interrupt (sound source)
0000330:        DEFW    $E814  ; Lv.5 	$F30A 	INT 2 	User interrupt
0000332:        DEFW    $E81A  ; Lv.6 	$F30C 	FDINT 1 	Reserve for FDD
0000334:        DEFW    $E820  ; Lv.7 	$F30E 	FDINT 0 	Reserve for FDD
0000336:        DEFW    $E814  ; -> $F310
0000338:        DEFW    $E814  ; -> $F312
000033A:        DEFW    $E814  ; -> $F314
000033C:        DEFW    $E814  ; -> $F316
000033E:        DEFW    $E814  ; -> $F318
0000340:        DEFW    $E814  ; -> $F31A
0000342:        DEFW    $E814  ; -> $F31C
0000344:        DEFW    $E814  ; -> $F31E


; search 'FOR' block
00000346:       LD HL,0004h
00000349:       ADD HL,SP
0000034A:       LD A,(HL)
0000034B:       INC HL
0000034C:       CP AFh				; TK_WHILE ?
0000034E:       JR NZ,+06h
00000350:       LD BC,0006h
00000353:       ADD HL,BC
00000354:       JR -0Ch
00000356:       CP 82h				; TK_FOR - Token for FOR ?
00000358:       RET NZ				; nope, quit
00000359:       LD C,(HL)
0000035A:       INC HL
0000035B:       LD B,(HL)			; address loop variable
0000035C:       INC HL
0000035D:       PUSH HL
0000035E:       LD H,B
0000035F:       LD L,C
00000360:       LD A,D
00000361:       OR E				; variable specified ?
00000362:       EX DE,HL
00000363:       JR Z,+02h			; nope, found
00000365:       EX DE,HL
00000366:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)   ..same variable ?
00000367:       LD BC,0010h
0000036A:       POP HL
0000036B:       RET Z		; yep, quit
0000036C:       ADD HL,BC
0000036D:       JR -25h		; next block


0000036F:       LD BC,047Ah				; RESTART
00000372:       JP 03F3h				; WARM_BT_0

; PRG_END
00000375:       CALL ED45h				; ?HPRGE? - Hook for Program End event
00000378:       LD HL,(E656h)			; CURLIN - line number being interpreted
0000037B:       LD A,H
0000037C:       AND L
0000037D:       INC A
0000037E:       JR Z,+08h			; PRG_END_0
00000380:       LD A,(EB0Fh)		; ONEFLG - flag for "ON ERROR"
00000383:       OR A
00000384:       LD E,13h
00000386:       JR NZ,+2Bh			; "No RESUME" Error
; PRG_END_0
00000388:       JP 50FBh		; __END_1

0000038B:       JR +26h

; DATSNR:
0000038D:       LD HL,(EAF9h)	; DATLIN
00000390:       LD (E656h),HL			; CURLIN - line number being interpreted

; MS BASIC ERROR CODES
; SNERR - entry for '?SN ERROR'
00000393:       LD E,02h
00000395:       LD BC,1F1Eh		; 0396: - "Duplicate label" error
00000398:       LD BC,201Eh		; 0398: - "Unprintable error" error
0000039B:       LD BC,0B1Eh		; 039C: - "Division by zero" error
0000039E:       LD BC,011Eh		; 039F: - "NEXT without FOR" error
000003A1:       LD BC,0A1Eh		; 03A2: - "Duplicate definition" error
000003A4:       LD BC,121Eh		; 03A4: - "Undefined user function" error
000003A7:       LD BC,141Eh		; 03A8: - "RESUME without error on" error
000003AA:       LD BC,061Eh		; 03AB: - "Overflow" error
000003AD:       LD BC,161Eh		; 03AE: - "Missing operand" error
000003B0:       LD BC,0D1Eh		; 03B1: - "Type mismatch" error
; -ERROR-
000003B3:       LD A,FFh				; back to main ROM
000003B5:       OUTA (71h)				; Extended ROM bank switching
000003B7:       XOR A
000003B8:       LD (E6ADh),A
000003BB:       LD HL,(EFBAh)
000003BE:       CALL 44D5h				; bank switching pivot (read)
000003C1:       LD (EFBCh),HL
000003C4:       CALL EDC9h			; ?HERRO? - Hook for Error handler ?
000003C7:       XOR A
000003C8:       DEC A
000003C9:       LD (E6A0h),A
000003CC:       LD (F006h),A
000003CF:       LD (F007h),A		; FRCNEW
000003D2:       XOR A
000003D3:       LD (ECA3h),A			; NLONLY
000003D6:       LD (ECA4h),A
000003D9:       LD (EC27h),A
000003DC:       LD (E653h),A
000003DF:       LD HL,(E656h)			; CURLIN - line number being interpreted
000003E2:       LD (EB09h),HL		; ERRLIN - Line where last error
000003E5:       LD (EFBEh),HL
000003E8:       LD A,H
000003E9:       AND L
000003EA:       INC A
000003EB:       JR Z,+03h
000003ED:       LD (E6ABh),HL
; WARM_BT (warm boot):
000003F0:       LD BC,03F9h
; WARM_BT_0
000003F3:       LD HL,(EB07h)			; SAVSTK
000003F6:       JP 4FB4h				; WARM_ENTRY

;;;
000003F9:       POP BC
000003FA:       LD A,E
000003FB:       LD C,E
000003FC:       LD (E649h),A			; ERRFLG
000003FF:       LD HL,(EB05h)			; SAVTXT - prg pointer for resume
00000402:       LD (EB0Bh),HL		; ERRTXT - Error messages table
00000405:       EX DE,HL
00000406:       LD HL,(EB09h)		; ERRLIN - Line where last error
00000409:       LD A,H
0000040A:       AND L
0000040B:       INC A
0000040C:       JR Z,+07h
0000040E:       LD (EB12h),HL			; OLDLIN - old line number set up ^C ...
00000411:       EX DE,HL
00000412:       LD (EB14h),HL			; OLDTXT - prg pointer for CONT
00000415:       LD HL,(EB0Dh)		; ONELIN - LINE to go when error
00000418:       LD A,H
00000419:       OR L
0000041A:       EX DE,HL
0000041B:       LD HL,EB0Fh		; ONEFLG - flag for "ON ERROR"
0000041E:       JR Z,+0Bh
00000420:       AND (HL)
00000421:       JR NZ,+08h
00000423:       DEC (HL)
00000424:       EX DE,HL
00000425:       CALL 44A4h				; bank switching pivot (write)
00000428:       JP 09C4h			; NEWSTT_1

0000042B:       XOR A
0000042C:       LD (HL),A
0000042D:       LD E,C
0000042E:       LD (E652h),A
00000431:       CALL 5A58h			; CONSOLE_CRLF
00000434:       CALL ED66h

; Print error message, error code in E
00000437:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64AFh
				DEFB 2			; ..will jump to 65AD, bank 2

; ROM BANK select
0000043D:       PUSH BC
0000043E:       INA (31h)		; mode select DIP switches
00000440:       CPL
00000441:       RLCA			; V1/V2 mode bit
00000442:       AND 01h
00000444:       LD B,A
00000445:       INA (32h)
00000447:       AND FCh		; Integrated expansion ROM bank selection (2 bits for EROMSL mask)
00000449:       OR B
0000044A:       OUTA (32h)
0000044C:       LD A,FFh
0000044E:       JP 3AA6h

00000451:       LD A,07h
00000453:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)

00000454:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64B2h
				DEFB 2			; ..will jump to 65CE, bank 2

0000045A:       PUSH HL
0000045B:       LD HL,(EB09h)		; ERRLIN - Line where last error
0000045E:       EX HL,(SP)
0000045F:       CALL ED69h
00000462:       CALL 0451h
00000465:       NOP
00000466:       NOP
00000467:       NOP
00000468:       POP HL
00000469:       LD DE,FFFEh
0000046C:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000046D:       JP Z,77F7h	; MAIN BASIC entry
00000470:       LD A,H
00000471:       AND L
00000472:       INC A
00000473:       CALL NZ,28BAh	; LNUM_MSG - Finalize (error) message by printing the current line number
00000476:       LD A,FFh
00000478:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)

00000479:       DEFB $3E  ; "LD A,n" to Mask the next byte
; RESTART:
0000047A:		POP BC
; READY:
0000047B:       LD A,FFh				; back to main ROM
0000047D:       OUTA (71h)				; Extended ROM bank switching
0000047F:       CALL 5989h			; STOP_LPT -  Stop and reset line printer
00000482:       XOR A
00000483:       LD (E652h),A
00000486:       LD A,(E69Fh)
00000489:       OR A
0000048A:       JP NZ,75DAh
0000048D:       CALL 4CABh
00000490:       CALL ED48h			; ? HREAD ? - Hook 1 for Mainloop ("OK")
00000493:       CALL 0F8Bh			; FINPRT - finalize PRINT
00000496:       CALL 5A58h			; CONSOLE_CRLF
00000499:       LD HL,031Ah			; "Ok"
0000049C:       CALL 5550h			; PRS - Print message pointed by HL
0000049F:       LD A,(E649h)		; ERRFLG
000004A2:       SUB 02h
000004A4:       CALL Z,6568h

; PROMPT
000004A7:       CALL ED3Fh			; ? HMAIN ? - Hook 2 for Mainloop
000004AA:       CALL 043Dh			; ROM BANK select
000004AD:       NOP
000004AE:       LD HL,FFFFh
000004B1:       LD (E656h),HL			; CURLIN - line number being interpreted
000004B4:       LD A,(E6C9h)
000004B7:       OR A
000004B8:       JP NZ,7CCDh
000004BB:       LD A,(EB00h)		; AUTFLG - enable flag for AUTO editor command
000004BE:       OR A
000004BF:       JR Z,+15h
000004C1:       LD HL,(EB01h)		; AUTLIN - AUTO editor, number to begin with
000004C4:       PUSH HL
000004C5:       CALL 28C2h			; _PRNUM - PRINT number pointed by HL
000004C8:       POP DE
000004C9:       CALL 0605h			; SRCHLN  -  Get first line number
000004CC:       LD A,2Ah	; '*'
000004CE:       JR C,+02h
000004D0:       LD A,20h	; ' '
000004D2:       RST 20h				; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
000004D3:       LD (EB00h),A		; AUTFLG - enable flag for AUTO editor command
000004D6:       CALL 5F92h		; PINLIN - Accepts a line from console until a CR or STOP
000004D9:       JR NC,+07h		; INI_LIN
000004DB:       XOR A
000004DC:       LD (EB00h),A		; AUTFLG - enable flag for AUTO editor command
000004DF:       JP 04A7h			; PROMPT

; INI_LIN
000004E2:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000004E3:       INC A
000004E4:       DEC A
000004E5:       JR Z,-40h
000004E7:       PUSH AF
000004E8:       CALL 0B34h			; LNUM_PARM_0 - Get specified line number
000004EB:       CALL 08AFh
000004EE:       LD A,(EB00h)		; AUTFLG - enable flag for AUTO editor command
000004F1:       OR A
000004F2:       JR Z,+08h
000004F4:       CP 2Ah		; '*'
000004F6:       JR NZ,+04h
000004F8:       CP (HL)
000004F9:       CALL Z,20F2h			; INCHL  (INC HL, RET)
000004FC:       LD A,(HL)
000004FD:       CP 20h		; ' '
000004FF:       CALL Z,20F2h			; INCHL  (INC HL, RET)
00000502:       PUSH DE
00000503:       CALL 0632h
00000506:       POP DE
00000507:       POP AF
00000508:       PUSH HL
00000509:       PUSH AF
0000050A:       CALL 44D5h				; bank switching pivot (read)
0000050D:       LD (EB05h),HL			; SAVTXT - prg pointer for resume
00000510:       POP AF
00000511:       POP HL
00000512:       CALL ED24h			; ?HDIRD? - Hook 3 for Mainloop (direct statement)?
00000515:       JP NC,4C70h
00000518:       PUSH DE
00000519:       PUSH BC
0000051A:       CALL EDA8h
0000051D:       LD A,D
0000051E:       OR E
0000051F:       JP Z,0393h			;  SNERR - entry for '?SN ERROR'
00000522:       RST 10h				; CHRGTB - Gets next character (or token) from BASIC text.
00000523:       OR A
00000524:       PUSH AF
00000525:       EX DE,HL
00000526:       LD (E6ABh),HL
00000529:       EX DE,HL
0000052A:       LD HL,(EB03h)		; AUTINC - increment step in AUTO command
0000052D:       ADD HL,DE
0000052E:       JR C,+0Dh
00000530:       PUSH DE
00000531:       LD DE,FFF9h
00000534:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00000535:       POP DE
00000536:       JR NC,+05h
00000538:       LD (EB01h),HL		; AUTLIN - AUTO editor, number to begin with
0000053B:       JR +04h
0000053D:       XOR A
0000053E:       LD (EB00h),A		; AUTFLG - enable flag for AUTO editor command
00000541:       CALL 0605h			; SRCHLN  -  Get first line number
00000544:       JR C,+06h
00000546:       POP AF
00000547:       PUSH AF
00000548:       JP Z,0C3Ch			; ULERR - entry for '?UL ERROR'
0000054B:       OR A
0000054C:       CALL 44B3h			; use bank pivot (read)
0000054F:       PUSH BC
00000550:       PUSH AF
00000551:       CALL 44D5h			; bank switching pivot (read)
00000554:       PUSH HL
00000555:       CALL 44A4h			; bank switching pivot (write)
00000558:       CALL 1C81h
0000055B:       POP HL
0000055C:       POP AF
0000055D:       POP BC
0000055E:       PUSH BC
0000055F:       CALL C,452Ch
00000562:       POP DE
00000563:       POP AF
00000564:       PUSH DE
00000565:       JR Z,+3Ah

00000567:       POP DE
00000568:       LD HL,(EACCh)			; STREND (aka STRTOP) - string area top address
0000056B:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
0000056E:       LD HL,(EB18h)			; ARYTAB - Pointer to begin of array table
00000571:       EX HL,(SP)
00000572:       POP BC
00000573:       PUSH HL
00000574:       ADD HL,BC
00000575:       PUSH HL
00000576:       PUSH DE
00000577:       CALL 44F1h
0000057A:       POP DE
0000057B:       POP HL
0000057C:       LD (EB18h),HL			; ARYTAB - Pointer to begin of array table
0000057F:       EX DE,HL
00000580:       CALL 44A4h			; bank switching pivot (write)
00000583:       LD (HL),H
00000584:       POP BC
00000585:       POP DE
00000586:       PUSH HL
00000587:       CALL 44D5h			; bank switching pivot (read)
0000058A:       EX HL,(SP)
0000058B:       INC HL
0000058C:       INC HL
0000058D:       LD (HL),E
0000058E:       INC HL
0000058F:       LD (HL),D
00000590:       INC HL
00000591:       LD DE,E87Ah			; KBUF
00000594:       DEC BC
00000595:       DEC BC
00000596:       DEC BC
00000597:       DEC BC
00000598:       LD A,(DE)
00000599:       LD (HL),A
0000059A:       INC HL
0000059B:       INC DE
0000059C:       DEC BC
0000059D:       LD A,C
0000059E:       OR B
0000059F:       JR NZ,-09h
000005A1:       CALL ED30h			; ?HFINI?	- Hook 1 for Mainloop finished ?
000005A4:       POP DE
000005A5:       CALL 05C1h
000005A8:       LD HL,(EC88h)		; PTRFIL
000005AB:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
000005AE:       CALL 4F21h			; RUN_FST
000005B1:       CALL ED2Ah
000005B4:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
000005B7:       LD (EC88h),HL		; PTRFIL
000005BA:       JP 04A7h			; PROMPT

; Used by the CHKSTK routine
000005BD:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
000005C0:       EX DE,HL
000005C1:       LD H,D
000005C2:       LD L,E
000005C3:       CALL 44A4h			; bank switching pivot (write)
000005C6:       LD A,(HL)
000005C7:       INC HL
000005C8:       OR (HL)
000005C9:       RET Z
000005CA:       INC HL
000005CB:       INC HL
000005CC:       INC HL
000005CD:       LD A,(HL)
000005CE:       OR A
000005CF:       JR Z,+0Eh
000005D1:       CP 20h		; ' '
000005D3:       JR NC,-09h
000005D5:       CP 0Bh
000005D7:       JR C,-0Dh
000005D9:       CALL 0A0Eh		; __CHRCKB - Gets current character (or token) from BASIC text.
000005DC:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000005DD:       JR -11h
000005DF:       INC HL
000005E0:       CALL 44D5h			; bank switching pivot (read)
000005E3:       EX DE,HL
000005E4:       LD (HL),E
000005E5:       INC HL
000005E6:       LD (HL),D
000005E7:       JR -28h

; LNUM_RANGE - Read numeric range function parameters
000005E9:       LD DE,0000h
000005EC:       PUSH DE
000005ED:       JR Z,+09h
000005EF:       POP DE
000005F0:       CALL 0B0Bh					; LNUM_PARM - Read numeric function parameter
000005F3:       PUSH DE
000005F4:       JR Z,+0Bh
000005F6:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000005F7:       CALL P,FA11h
000005FA:       RST 38h
000005FB:       CALL NZ,0B0Bh				; LNUM_PARM - Read numeric function parameter
000005FE:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00000601:       EX DE,HL
00000602:       POP DE
00000603:       EX HL,(SP)
00000604:       PUSH HL

; SRCHLN  -  Get first line number
00000605:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
; CURRENT_LNUM
00000608:       LD (EFB5h),HL		; 'remote bank read' result
0000060B:       CALL 44A4h			; bank switching pivot (write)
0000060E:       PUSH HL
0000060F:       LD HL,(EFB5h)		; 'remote bank read' result
00000612:       LD (EFB7h),HL
00000615:       POP HL
00000616:       CALL 44E3h
00000619:       LD B,H
0000061A:       LD C,L
0000061B:       RET Z
0000061C:       INC HL
0000061D:       INC HL
0000061E:       LD A,(HL)
0000061F:       INC HL
00000620:       LD H,(HL)
00000621:       LD L,A
00000622:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00000623:       LD H,B
00000624:       LD L,C
00000625:       LD A,(HL)
00000626:       INC HL
00000627:       LD H,(HL)
00000628:       LD L,A
00000629:       CALL 44C2h
0000062C:       CCF
0000062D:       RET Z
0000062E:       CCF
0000062F:       RET NC
00000630:       JR -24h				; CURRENT_LNUM

00000632:       XOR A
00000633:       LD (EABFh),A		; DONUM
00000636:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00000639:       CALL ED1Eh			; ?HCRUN?  -  Hook 1 for Tokenise ?
0000063C:       LD BC,013Bh			; 315
0000063F:       LD DE,E87Ah			; KBUF
00000642:       LD A,(HL)
00000643:       OR A
00000644:       JR NZ,+13h
00000646:       LD HL,0140h
00000649:       LD A,L
0000064A:       SUB C
0000064B:       LD C,A
0000064C:       LD A,H
0000064D:       SBC B
0000064E:       LD B,A
0000064F:       LD HL,E879h		; BUFFER - start of INPUT buffer
00000652:       XOR A
00000653:       LD (DE),A
00000654:       INC DE
00000655:       LD (DE),A
00000656:       INC DE
00000657:       LD (DE),A
00000658:       RET

00000659:       CP 22h		; '"'
0000065B:       JP Z,068Eh
0000065E:       CP 20h		; ' '
00000660:       JR Z,+07h
00000662:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00000665:       OR A
00000666:       LD A,(HL)
00000667:       JR Z,+2Dh
00000669:       INC HL
0000066A:       PUSH AF
0000066B:       CALL 0861h
0000066E:       POP AF
0000066F:       SUB 3Ah
00000671:       JR Z,+06h
00000673:       CP 4Ah
00000675:       JR NZ,+08h
00000677:       LD A,01h
00000679:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
0000067C:       LD (EABFh),A		; DONUM
0000067F:       SUB 55h
00000681:       JR NZ,-41h
00000683:       PUSH AF
00000684:       LD A,(HL)
00000685:       OR A
00000686:       EX HL,(SP)
00000687:       LD A,H
00000688:       POP HL
00000689:       JR Z,-45h
0000068B:       CP (HL)
0000068C:       JR Z,-25h
0000068E:       PUSH AF
0000068F:       LD A,(HL)
00000690:       INC HL
00000691:       CALL 0861h
00000694:       JR -12h
00000696:       INC HL
00000697:       OR A
00000698:       JP M,0642h
0000069B:       DEC HL
0000069C:       CP 3Fh
0000069E:       LD A,91h		; TK_PRINT - shortcut for PRINT command
000006A0:       PUSH DE
000006A1:       PUSH BC
000006A2:       JP Z,075Eh		; TOKEN_FOUND
000006A5:       LD DE,6E81h
000006A8:       CALL 1414h			; UCASE_HL - Get char from (HL) and make upper case
000006AB:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
000006AE:       JP C,07ADh
000006B1:       PUSH HL
000006B2:       LD DE,06C9h
000006B5:       LD B,06h
000006B7:       LD A,(DE)
000006B8:       LD C,A
000006B9:       CALL 1414h				; UCASE_HL - Get char from (HL) and make upper case
000006BC:       CP C
000006BD:       JR NZ,+2Ch
000006BF:       INC HL
000006C0:       INC DE
000006C1:       DJNZ -0Ch
000006C3:       LD A,8Dh
000006C5:       POP BC
000006C6:       JP 075Eh
000006C9:       LD B,A
000006CA:       LD C,A
000006CB:       JR NZ,+53h
000006CD:       LD D,L
000006CE:       LD B,D
000006CF:       OR AFh
000006D1:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
000006D4:       LD (EB1Bh),HL	; VARTAB
000006D7:       LD (EB1Dh),HL	; VAREND - End of variables
000006DA:       LD (EB1Fh),HL	; ARREND - End of arrays
000006DD:       JP Z,0396h			;  "Duplicate label" error
000006E0:       JP 0393h			;  SNERR - entry for '?SN ERROR'

000006E3:       LD HL,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000006E6:       LD B,H
000006E7:       LD C,L
000006E8:       JP 2843h
000006EB:       POP HL
000006EC:       CALL 1414h				; UCASE_HL - Get char from (HL) and make upper case
000006EF:       PUSH HL
000006F0:       CALL ED21h			; ?HCRUS? -	Hook 2 for Tokenise?

000006F3:       LD HL,6B56h			; WORD_PTR
000006F6:       SUB 41h
000006F8:       ADD A
000006F9:       LD C,A
000006FA:       LD B,00h
000006FC:       ADD HL,BC
000006FD:       LD E,(HL)
000006FE:       INC HL
000006FF:       LD D,(HL)
00000700:       POP HL
00000701:       INC HL
00000702:       PUSH HL
00000703:       CALL 1414h				; UCASE_HL - Get char from (HL) and make upper case
00000706:       LD C,A
00000707:       LD A,(DE)
00000708:       AND 7Fh
0000070A:       JP Z,086Ch
0000070D:       INC HL
0000070E:       CP C
0000070F:       JR NZ,+41h
00000711:       LD A,(DE)
00000712:       INC DE
00000713:       OR A
00000714:       JP P,0703h
00000717:       LD A,C
00000718:       CP 28h		; '('
0000071A:       JR Z,+18h
0000071C:       LD A,(DE)
0000071D:       CP E1h		; TK_FN
0000071F:       JR Z,+13h
00000721:       CP E0h
00000723:       JR Z,+0Fh
00000725:       CALL 1414h				; UCASE_HL - Get char from (HL) and make upper case
00000728:       CP 2Eh	; '.'
0000072A:       JR Z,+03h
0000072C:       CALL 1AB4h
0000072F:       LD A,00h
00000731:       JP NC,086Ch
00000734:       POP AF
00000735:       LD A,(DE)
00000736:       CALL ED51h
00000739:       OR A
0000073A:       JP M,075Dh
0000073D:       POP BC
0000073E:       POP DE
0000073F:       OR 80h
00000741:       PUSH AF
00000742:       LD A,FFh
00000744:       CALL 0861h
00000747:       XOR A
00000748:       LD (EABFh),A		; DONUM
0000074B:       POP AF
0000074C:       CALL 0861h
0000074F:       JP 0642h
00000752:       POP HL
00000753:       LD A,(DE)
00000754:       INC DE
00000755:       OR A
00000756:       JP P,0753h
00000759:       INC DE
0000075A:       JP 0702h
0000075D:       DEC HL
0000075E:       PUSH AF
TOKEN_FOUND:
0000075F:       CALL ED57h
00000762:       LD DE,0770h		; LNUM_TOKENS
00000765:       LD C,A
00000766:       LD A,(DE)
00000767:       OR A
00000768:       JR Z,+16h
0000076A:       INC DE
0000076B:       CP C
0000076C:       JR NZ,-08h
0000076E:       JR +12h


LNUM_TOKENS:
00000770:    DEFB 8Ch	; TK_RESTORE
00000771:    DEFB A8h	; TK_AUTO
00000772:    DEFB A9h	; TK_RENUM
00000773:    DEFB A7h	; TK_DELETE
00000774:    DEFB A4h	; TK_EDIT
00000775:    DEFB A6h	; TK_RESUME
00000776:    DEFB E4h	; TK_ERL
00000777:    DEFB 9Fh	; TK_ELSE
00000778:    DEFB 8Ah	; TK_RUN
00000779:    DEFB 93h	; TK_LIST
0000077A:    DEFB 9Ch	; TK_LLIST
0000077B:    DEFB 89h	; TK_GOTO
0000077C:    DEFB 8Eh	; TK_RETURN
0000077D:    DEFB DDh	; TK_THEN
0000077E:    DEFB 8Dh	; TK_GOSUB
0000077F:    DEFB $00



00000780:       XOR A
00000781:       JP NZ,013Eh
00000784:       LD (EABFh),A		; DONUM
00000787:       POP AF
00000788:       POP BC
00000789:       POP DE
0000078A:       CP 9Fh
0000078C:       PUSH AF
0000078D:       CALL Z,085Fh
00000790:       POP AF
00000791:       CP AFh		; TK_WHILE ?
00000793:       JR NZ,+05h
00000795:       CALL 0861h
00000798:       LD A,F3h
0000079A:       CP E9h		; TK_APOSTROPHE
0000079C:       JP NZ,0840h
0000079F:       PUSH AF
000007A0:       CALL 085Fh
000007A3:       LD A,8Fh	; TK_REM
000007A5:       CALL 0861h
000007A8:       POP AF
000007A9:       PUSH AF
000007AA:       JP 0690h

000007AD:       LD A,(HL)
000007AE:       CP 2Eh	; '.'
000007B0:       JR Z,+0Ah	; '.'
000007B2:       CP 3Ah		; '9'+1
000007B4:       JP NC,082Eh
000007B7:       CP 30h		; '0'
000007B9:       JP C,082Eh
000007BC:       LD A,(EABFh)		; DONUM
000007BF:       OR A
000007C0:       LD A,(HL)
000007C1:       POP BC
000007C2:       POP DE
000007C3:       JP M,0669h
000007C6:       JR Z,+1Fh
000007C8:       CP 2Eh		; '.'
000007CA:       JP Z,0669h
000007CD:       LD A,0Eh
000007CF:       CALL 0861h
000007D2:       PUSH DE
000007D3:       CALL 0B34h			; LNUM_PARM_0 - Get specified line number
000007D6:       CALL 08AFh
000007D9:       EX HL,(SP)
000007DA:       EX DE,HL
000007DB:       LD A,L
000007DC:       CALL 0861h
000007DF:       LD A,H
000007E0:       POP HL
000007E1:       CALL 0861h
000007E4:       JP 0642h

000007E7:       PUSH DE
000007E8:       PUSH BC
000007E9:       LD A,(HL)
000007EA:       CALL 26BCh		; DBL_ASCTFP (a.k.a. FIN)
000007ED:       CALL 08AFh
000007F0:       POP BC
000007F1:       POP DE
000007F2:       PUSH HL
000007F3:       LD A,(EABDh)		; VALTYP - type indicator
000007F6:       CP 02h		; Integer ?
000007F8:       JR NZ,+15h
000007FA:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000007FD:       LD A,H
000007FE:       OR A
000007FF:       LD A,02h
00000801:       JR NZ,+0Ch
00000803:       LD A,L
00000804:       LD H,L
00000805:       LD L,0Fh
00000807:       CP 0Ah
00000809:       JR NC,-30h
0000080B:       ADD 11h
0000080D:       JR -2Fh

0000080F:       PUSH AF
00000810:       RRCA
00000811:       ADD 1Bh
00000813:       CALL 0861h
00000816:       LD HL,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000819:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000081A:       JR C,+03h
0000081C:       LD HL,EC3Dh
0000081F:       POP AF
00000820:       PUSH AF
00000821:       LD A,(HL)
00000822:       CALL 0861h
00000825:       POP AF
00000826:       INC HL
00000827:       DEC A
00000828:       JR NZ,-0Ah
0000082A:       POP HL
0000082B:       JP 0642h
0000082E:       LD DE,6E80h
00000831:       INC DE
00000832:       LD A,(DE)
00000833:       AND 7Fh
00000835:       JP Z,0895h
00000838:       INC DE
00000839:       CP (HL)
0000083A:       LD A,(DE)
0000083B:       JR NZ,-0Ch
0000083D:       JP 08A4h

00000840:       CP 26h		; '&'
00000842:       JP NZ,0669h
00000845:       PUSH HL
00000846:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000847:       POP HL
00000848:       CALL 1415h				; UCASE - Make char in 'A' upper case
0000084B:       CP 48h
0000084D:       LD A,0Bh
0000084F:       JR NZ,+02h
00000851:       LD A,0Ch
00000853:       CALL 0861h
00000856:       PUSH DE
00000857:       PUSH BC
00000858:       CALL 1423h			; convert text with radix indication to number
0000085B:       POP BC
0000085C:       JP 07D9h

0000085F:       LD A,3Ah	; ':'
00000861:       LD (DE),A
00000862:       INC DE
00000863:       DEC BC
00000864:       LD A,C
00000865:       OR B
00000866:       RET NZ
00000867:       LD E,17h
00000869:       JP 03B3h				; ERROR, code in E

0000086C:       CALL ED54h
0000086F:       POP HL
00000870:       DEC HL
00000871:       DEC A
00000872:       LD (EABFh),A		; DONUM
00000875:       POP BC
00000876:       POP DE
00000877:       CALL 1414h			; UCASE_HL - Get char from (HL) and make upper case
0000087A:       CALL 0861h
0000087D:       INC HL
0000087E:       CALL 1414h			; UCASE_HL - Get char from (HL) and make upper case
00000881:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00000884:       JR NC,-0Ch
00000886:       CP 3Ah		; ':'
00000888:       JR NC,+08h
0000088A:       CP 30h
0000088C:       JR NC,-14h
0000088E:       CP 2Eh		; '.'
00000890:       JR Z,-18h
00000892:       JP 0642h
00000895:       LD A,(HL)
00000896:       CP 20h		; ' '
00000898:       JR NC,+0Ah
0000089A:       CP 09h
0000089C:       JR Z,+06h
0000089E:       CP 0Ah
000008A0:       JR Z,+02h
000008A2:       LD A,20h
000008A4:       PUSH AF
000008A5:       LD A,(EABFh)		; DONUM
000008A8:       INC A
000008A9:       JR Z,+01h
000008AB:       DEC A
000008AC:       JP 0784h
000008AF:       DEC HL
000008B0:       LD A,(HL)
000008B1:       CP 20h		; ' '
000008B3:       JR Z,-06h
000008B5:       CP 09h
000008B7:       JR Z,-0Ah
000008B9:       CP 0Ah
000008BB:       JR Z,-0Eh
000008BD:       INC HL
000008BE:       RET

_FOR:
000008BF:       LD A,64h
000008C1:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
000008C4:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
000008C7:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000008C8:       POP AF	; DEFB TK_EQUAL..  Token for '='
000008C9:       PUSH DE
000008CA:       EX DE,HL
000008CB:       LD (EAFDh),HL		; TEMP - temp. reservation for st.code
000008CE:       EX DE,HL
000008CF:       LD A,(EABDh)		; VALTYP - type indicator
000008D2:       PUSH AF
000008D3:       CALL 11D3h			; EVAL - evaluate expression
000008D6:       POP AF
000008D7:       PUSH HL
000008D8:       CALL 1796h
000008DB:       LD HL,EC19h
000008DE:       CALL 20F4h			; DEC_FACCU2HL - copy number value from FPREG (FP accumulator) to HL
000008E1:       POP HL
000008E2:       POP DE
000008E3:       POP BC
000008E4:       PUSH HL
000008E5:       CALL 0C77h			; _DATA (nothing to be executed, skip to next line)
000008E8:       CALL 44D5h			; bank switching pivot (read)
000008EB:       LD (EAF7h),HL		; ENDFOR - Next address of FOR st.
000008EE:       LD HL,0002h
000008F1:       ADD HL,SP
;__FOR_0
000008F2:       CALL 034Ah
000008F5:       JR NZ,+17h			; __FOR_1+1
000008F7:       ADD HL,BC
000008F8:       PUSH DE
000008F9:       DEC HL
000008FA:       LD D,(HL)
000008FB:       DEC HL
000008FC:       LD E,(HL)
000008FD:       INC HL
000008FE:       INC HL
000008FF:       PUSH HL
00000900:       LD HL,(EAF7h)		; ENDFOR - Next address of FOR st.
00000903:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00000904:       POP HL
00000905:       POP DE
00000906:       JR NZ,-16h		;__FOR_0
00000908:       POP DE
00000909:       LD SP,HL
0000090A:       LD (EB07h),HL			; SAVSTK
;__FOR_1
0000090D:       LD C,D1h			; __FOR_1+1:  POP DE
0000090F:       EX DE,HL
00000910:       LD C,08h
00000912:       CALL 4EC1h			; CHKSTK
00000915:       PUSH HL
00000916:       LD HL,(EAF7h)		; ENDFOR - Next address of FOR st.
00000919:       EX HL,(SP)
0000091A:       PUSH HL
0000091B:       LD HL,(E656h)			; CURLIN - line number being interpreted
0000091E:       EX HL,(SP)
0000091F:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000920:       CALL C,CAF7h
00000923:       OR C
00000924:       INC BC
00000925:       JP NC,03B1h		; TYPE_ERR, "Type mismatch" error
00000928:       PUSH AF
00000929:       CALL 11D3h			; EVAL - evaluate expression
0000092C:       POP AF
0000092D:       PUSH HL
0000092E:       JP P,0946h			; __FOR_4
00000931:       CALL 21A0h			; CINT
00000934:       EX HL,(SP)
00000935:       LD DE,0001h
00000938:       LD A,(HL)
00000939:       CP DFh				; TK_STEP
0000093B:       CALL Z,1895h		; FPSINT - Get subscript
0000093E:       PUSH DE
0000093F:       PUSH HL
00000940:       EX DE,HL
00000941:       CALL 20C7h			; VSIGN_2
00000944:       JR +23h				; __FOR_5
;__FOR_4:
00000946:       CALL 2214h			; CSNG - Convert number to single precision
00000949:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
0000094C:       POP HL
0000094D:       PUSH BC
0000094E:       PUSH DE
0000094F:       LD BC,8100h
00000952:       LD D,C
00000953:       LD E,D
00000954:       CALL ED60h
00000957:       LD A,(HL)
00000958:       CP DFh				; TK_STEP
0000095A:       LD A,01h			; default value for STEP
0000095C:       JR NZ,+0Ch			; __FOR_6
0000095E:       CALL 11D4h			; EVAL_0 	- (a.k.a. GETNUM, evaluate expression (GETNUM)
00000961:       PUSH HL
00000962:       CALL 2214h			; CSNG - Convert number to single precision
00000965:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
00000968:       RST 28h				; SIGN - test FP number sign
; __FOR_5
00000969:       POP HL
; __FOR_6
0000096A:       PUSH BC
0000096B:       PUSH DE
0000096C:       LD C,A
0000096D:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000096E:       LD B,A
0000096F:       PUSH BC
00000970:       DEC HL
00000971:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000972:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00000975:       CALL 1D28h
00000978:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000979:       PUSH HL
0000097A:       CALL 44D5h			; bank switching pivot (read)
0000097D:       EX HL,(SP)
0000097E:       PUSH HL
0000097F:       LD HL,(EC1Dh)
00000982:       LD (E656h),HL			; CURLIN - line number being interpreted
00000985:       LD HL,(EAFDh)		; TEMP - temp. reservation for st.code
00000988:       EX HL,(SP)
; (equivalent to PUTFID)
00000989:       LD B,82h           ; "FOR" block marker   ;FINISH UP "FOR"
0000098B:       PUSH BC            ; Save it
0000098C:       INC SP             ; Don't save C         ;THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE
0000098D:       PUSH AF
0000098E:       PUSH AF
0000098F:       JP 52BFh

; PUTFID
00000992:       LD B,82h           ; "FOR" block marker   ;FINISH UP "FOR"
00000994:       PUSH BC            ; Save it
00000995:       INC SP             ; Don't save C         ;THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE

; NEWSTT
00000996:       LD A,FFh				; back to main ROM
00000998:       OUTA (71h)				; Extended ROM bank switching
0000099A:       LD A,(E6C9h)
0000099D:       OR A
0000099E:       JP NZ,7CCDh
000009A1:       CALL EDCCh
000009A4:       LD A,(E6F1h)		; ONGSBF - flag for "ON GOSUB"
000009A7:       OR A
000009A8:       CALL NZ,5059h
000009AB:       CALL 5A86h			; ISCNTC - Check the status of the STOP key.
000009AE:       PUSH HL
000009AF:       CALL 44D5h			; bank switching pivot (read)
000009B2:       LD (EB05h),HL			; SAVTXT - prg pointer for resume
000009B5:       POP HL
000009B6:       LD (EB07h),SP			; SAVSTK
000009BA:       LD A,(HL)
000009BB:       CP 3Ah		; ':'
000009BD:       JR Z,+26h			; NEXT_STMT

000009BF:       OR A
000009C0:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
000009C3:       INC HL
; NEWSTT_1
000009C4:       CALL 44E3h
000009C7:       JP Z,0375h			; PRG_END
000009CA:       INC HL
000009CB:       INC HL
000009CC:       LD E,(HL)
000009CD:       INC HL
000009CE:       LD D,(HL)
000009CF:       EX DE,HL
000009D0:       LD (E656h),HL			; CURLIN - line number being interpreted
000009D3:       LD A,(EC3Bh)			; TRCFLG - FLAG for 'TRACE' status
000009D6:       OR A					; 0 MEANS NO TRACE
000009D7:       JR Z,+0Bh		; NEWSTT_2

000009D9:       PUSH DE
000009DA:       LD A,5Bh	; '['
000009DC:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
000009DD:       CALL 28C2h			; _PRNUM - PRINT number pointed by HL
000009E0:       LD A,5Dh	;']'
000009E2:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
000009E3:       POP DE
; NEWSTT_2
000009E4:       EX DE,HL

; NEXT_STMT
000009E5:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000009E6:       LD DE,0996h		; NEWSTT
000009E9:       PUSH DE
000009EA:       RET Z
000009EB:       CP F5h
000009ED:       JR NZ,+06h
000009EF:       CALL 5480h
000009F2:       DEC HL
000009F3:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000009F4:       RET Z
000009F5:       SUB 81h				; Normal Alphanum sequence ?
000009F7:       JP C,0C9Ch			; _LET -  ...Ok, assume an implicit "LET" statement
000009FA:       CP 59h
000009FC:       JP NC,17C9h			; check function tokens
000009FF:       RLCA
00000A00:       LD C,A
00000A01:       LD B,00h
00000A03:       EX DE,HL
00000A04:       LD HL,69FEh			; JP TABLE for BASIC statements
00000A07:       ADD HL,BC
00000A08:       LD C,(HL)
00000A09:       INC HL
00000A0A:       LD B,(HL)
00000A0B:       PUSH BC
00000A0C:       EX DE,HL

; _CHRGTB - Pick next char from program
00000A0D:       INC HL
; __CHRCKB - Gets current character (or token) from BASIC text.
00000A0E:       LD A,(HL)
00000A0F:       LD (EFBAh),HL

; _CHRCKB - Gets current character (or token) from BASIC text.
00000A12:       CP 3Ah		; ':'
00000A14:       RET NC
; continued also from
00000A15:       CP 20h		; ' '
00000A17:       JR Z,-0Ch
00000A19:       JR NC,+6Ch
00000A1B:       OR A
00000A1C:       RET Z
00000A1D:       CP 0Bh				; Not a number constant prefix ?
00000A1F:       JR C,+61h			; ...then JP
00000A21:       CP 1Eh				; TK_CINT ? .. CURS_UP ?
00000A23:       JR NZ,+05h
00000A25:       LD A,(EAC2h)			; Store in CONSAV the token of constant after calling CHRGET
00000A28:       OR A
00000A29:       RET

00000A2A:       CP 10h
00000A2C:       JR Z,+34h
00000A2E:       PUSH AF
00000A2F:       INC HL
00000A30:       LD (EAC2h),A			; Store in CONSAV token of constant after calling CHRGET
00000A33:       SUB 1Ch					; Prefix $1C -> Integer between 256 and 32767
00000A35:       JR NC,+30h				; Jump if constant is bigger than 255, (prefixes 1CH, 1DH 1FH).
00000A37:       SUB F5h
00000A39:       JR NC,+06h
00000A3B:       CP FEh
00000A3D:       JR NZ,+16h
00000A3F:       LD A,(HL)
00000A40:       INC HL
00000A41:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00000A44:       LD H,00h
00000A46:       LD L,A
00000A47:       LD (EAC4h),HL		; CONLO - Value of stored constant
00000A4A:       LD A,02h
00000A4C:       LD (EAC3h),A			; CONTYP - Type of stored constant
00000A4F:       LD HL,E69Ch
00000A52:       POP AF
00000A53:       OR A
00000A54:       RET

00000A55:       LD A,(HL)
00000A56:       INC HL
00000A57:       INC HL
00000A58:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00000A5B:       DEC HL
00000A5C:       LD H,(HL)
00000A5D:       JR -19h
00000A5F:       CALL 0A8Dh
00000A62:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00000A65:       JR -59h
00000A67:       INC A
00000A68:       RLCA
00000A69:       LD (EAC3h),A			; CONTYP - Type of stored constant
00000A6C:       PUSH DE
00000A6D:       PUSH BC
00000A6E:       LD DE,EAC4h		; CONLO - Value of stored constant
00000A71:       EX DE,HL
00000A72:       LD B,A
00000A73:       CALL 2100h				; CPY2HL
00000A76:       EX DE,HL
00000A77:       POP BC
00000A78:       POP DE
00000A79:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00000A7C:       POP AF
00000A7D:       LD HL,E69Ch
00000A80:       OR A
00000A81:       RET

00000A82:       CP 09h
00000A84:       JP NC,0A0Dh				; _CHRGTB - Pick next char from program
00000A87:       CP 30h
00000A89:       CCF
00000A8A:       INC A
00000A8B:       DEC A
00000A8C:       RET
00000A8D:       LD A,(EAC2h)			; CONSAV
00000A90:       CP 0Fh
00000A92:       JR NC,+13h
00000A94:       CP 0Dh
00000A96:       JR C,+0Fh
00000A98:       LD HL,(EAC4h)		; CONLO - Value of stored constant
00000A9B:       JR NZ,+07h
00000A9D:       INC HL
00000A9E:       INC HL
00000A9F:       INC HL
00000AA0:       LD E,(HL)
00000AA1:       INC HL
00000AA2:       LD D,(HL)
00000AA3:       EX DE,HL
00000AA4:       JP 2402h		; DBL_ABS_0

00000AA7:       LD A,(EAC3h)			; CONTYP - Type of stored constant
00000AAA:       LD (EABDh),A		; VALTYP - type indicator
00000AAD:       CP 08h
00000AAF:       JR Z,+0Dh
00000AB1:       LD HL,(EAC4h)		; CONLO - Value of stored constant
00000AB4:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000AB7:       LD HL,(EAC6h)
00000ABA:       LD (EC43h),HL		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00000ABD:       RET

00000ABE:       LD HL,EAC4h		; CONLO - Value of stored constant
00000AC1:       JP 211Fh		; FP_HL2DE

_DEFSTR:
00000AC4:       LD E,03h
00000AC6:       LD BC,021Eh			; 00000AC7: _DEFINT  (LD E,02)
00000AC9:       LD BC,041Eh			; 00000ACA: _DEFSGN  (LD E,04)
00000ACC:       LD BC,081Eh			; 00000ACD: _DEFDBL  (LD E,08)
00000ACF:       CALL 5215h			; IS_ALPHA - Load A with char in (HL) and check it is a letter
00000AD2:       LD BC,0393h			;  SNERR - entry for '?SN ERROR'
00000AD5:       PUSH BC
00000AD6:       RET C
00000AD7:       SUB 41h
00000AD9:       LD C,A
00000ADA:       LD B,A
00000ADB:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000ADC:       CP F4h			; TK_MINUS, Token for '-'
00000ADE:       JR NZ,+09h
00000AE0:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000AE1:       CALL 5215h			; IS_ALPHA - Load A with char in (HL) and check it is a letter
00000AE4:       RET C
00000AE5:       SUB 41h
00000AE7:       LD B,A
00000AE8:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000AE9:       LD A,B
00000AEA:       SUB C
00000AEB:       RET C
00000AEC:       INC A
00000AED:       EX HL,(SP)
00000AEE:       LD HL,EB23h		; DEFTBL
00000AF1:       LD B,00h
00000AF3:       ADD HL,BC
00000AF4:       LD (HL),E
00000AF5:       INC HL
00000AF6:       DEC A
00000AF7:       JR NZ,-05h
00000AF9:       POP HL
00000AFA:       LD A,(HL)
00000AFB:       CP 2Ch		; ','
00000AFD:       RET NZ
00000AFE:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000AFF:       JR -32h

00000B01:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000B02:       CALL 1896h				; POSINT - Get positive integer
00000B05:       RET P

; FCERR, Err $05 - "Illegal function call"
00000B06:       LD E,05h			; Err $05 - "Illegal function call"
00000B08:       JP 03B3h				; ERROR, code in E

; LNUM_PARM - Read numeric function parameter
00000B0B:       LD A,(HL)
00000B0C:       CP 2Eh		; '.'
00000B0E:       LD DE,(E6ABh)
00000B12:       JP Z,0A0Dh				; _CHRGTB - Pick next char from program
00000B15:       CALL 0B34h				; LNUM_PARM_0 - Get specified line number
00000B18:       PUSH AF
00000B19:       LD A,(EAC2h)			; CONSAV
00000B1C:       CP 0Dh
00000B1E:       JR NZ,+12h
00000B20:       CALL 44D5h			; bank switching pivot (read)
00000B23:       PUSH HL
00000B24:       EX DE,HL
00000B25:       CALL 44A4h			; bank switching pivot (write)
00000B28:       INC HL
00000B29:       INC HL
00000B2A:       INC HL
00000B2B:       LD E,(HL)
00000B2C:       INC HL
00000B2D:       LD D,(HL)
00000B2E:       POP HL
00000B2F:       CALL 44A4h			; bank switching pivot (write)
00000B32:       POP AF
00000B33:       RET

; LNUM_PARM_0 - Get specified line number
00000B34:       DEC HL
00000B35:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000B36:       CP F5h
00000B38:       JP Z,5441h
00000B3B:       CP 0Fh
00000B3D:       JR NZ,+0Ah
00000B3F:       LD HL,(EAC4h)		; CONLO - Value of stored constant
00000B42:       EX DE,HL
00000B43:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00000B46:       DEC HL
00000B47:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000B48:       RET

00000B49:       CP 0Eh
00000B4B:       JR Z,+02h
00000B4D:       CP 0Dh

; LINGT3
00000B4F:       LD DE,(EAC4h)		; CONLO - ;GET EMBEDDED LINE #
00000B53:       JP Z,0A0Dh			; _CHRGTB ;EAT FOLLOWING CHAR
00000B56:       XOR A
00000B57:       LD (EAC2h),A			; CONSAV
00000B5A:       LD DE,0000h         ;ZERO ACCUMULATED LINE #
00000B5D:       DEC HL              ;BACK UP POINTER
;GTLNLP:
00000B5E:       RST 10h			; CHRGTB ; Gets next character (or token) from BASIC text.
00000B5F:       RET NC                       ;WAS IT A DIGIT
00000B60:       PUSH HL
00000B61:       PUSH AF
00000B62:       LD HL,1998h      ; 65529/10   Largest number 65529      ;SEE IF THE LINE # IS TOO BIG
00000B65:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00000B66:       JR C,+11h     ; POPHSR

00000B68:       LD H,D
00000B69:       LD L,E
00000B6A:       ADD HL,DE    ; *2
00000B6B:       ADD HL,HL    ; ..*4
00000B6C:       ADD HL,DE    ; ..*5
00000B6D:       ADD HL,HL    ; ..*10  ;PUTTING [D,E]*10 INTO [H,L]
00000B6E:       POP AF       ; Restore digit
00000B6F:       SUB 30h      ; Make it 0 to 9
00000B71:       LD E,A       ; DE = Value of digit
00000B72:       LD D,00h
00000B74:       ADD HL,DE     ; Add to number                   ;ADD THE NEW DIGIT
00000B75:       EX DE,HL      ; Number to DE
00000B76:       POP HL        ; Restore code string address     ;GET BACK TEXT POINTER
00000B77:       JR -1Bh       ; GTLNLP - Go to next character

;POPHSR:
00000B79:       POP AF
00000B7A:       POP HL
00000B7B:       RET

_RUN:
00000B7C:       JR NZ,+0Fh
00000B7E:       CALL 4F2Bh			; _CLVAR - Initialise RUN variables
00000B81:       CALL 53F6h
00000B84:       LD HL,0000h
00000B87:       CALL 44A4h			; bank switching pivot (write)
00000B8A:       JP 0996h			; NEWSTT

00000B8D:       CP 0Eh
00000B8F:       JR Z,+0Bh
00000B91:       CP 0Dh
00000B93:       JR Z,+07h
00000B95:       CP F5h
00000B97:       JR Z,+03h
00000B99:       JP NZ,4852h
00000B9C:       CALL 4F2Bh			; _CLVAR - Initialise RUN variables
00000B9F:       EX HL,(SP)
00000BA0:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00000BA3:       CALL 44D5h			; bank switching pivot (read)
00000BA6:       EX HL,(SP)
00000BA7:       CALL 44D5h			; bank switching pivot (read)
00000BAA:       PUSH HL
00000BAB:       CALL 53F6h
00000BAE:       POP HL
00000BAF:       CALL 44A4h			; bank switching pivot (write)
00000BB2:       EX HL,(SP)
00000BB3:       CALL 44A4h			; bank switching pivot (write)
00000BB6:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00000BB9:       POP HL
00000BBA:       LD BC,0996h			; NEWSTT
00000BBD:       JR +39h

_GOSUB:
00000BBF:       LD C,03h
00000BC1:       CALL 4EC1h			; CHKSTK
00000BC4:       CALL 0B34h			; LNUM_PARM_0 - Get specified line number
00000BC7:       POP BC
00000BC8:       PUSH HL
00000BC9:       CALL 44D5h			; bank switching pivot (read)
00000BCC:       EX HL,(SP)
00000BCD:       PUSH HL
00000BCE:       LD HL,(E656h)			; CURLIN - line number being interpreted
00000BD1:       EX HL,(SP)
00000BD2:       LD BC,0DD6h			; _AUTO +1 ?
00000BD5:       PUSH BC
00000BD6:       LD BC,0996h			; NEWSTT
00000BD9:       LD A,8Dh
00000BDB:       PUSH AF
00000BDC:       INC SP
00000BDD:       PUSH BC
00000BDE:       JR +1Ch				; __GO_TO_0

00000BE0:       CALL 44D5h			; bank switching pivot (read)
00000BE3:       PUSH HL
00000BE4:       PUSH HL
00000BE5:       LD HL,(E656h)			; CURLIN - line number being interpreted
00000BE8:       EX HL,(SP)
00000BE9:       PUSH BC
00000BEA:       LD A,8Dh
00000BEC:       PUSH AF
00000BED:       INC SP
00000BEE:       EX DE,HL
00000BEF:       LD (EB05h),HL			; SAVTXT - prg pointer for resume
00000BF2:       CALL 44A4h			; bank switching pivot (write)
00000BF5:       JP 09C4h			; NEWSTT_1

GO_TO:
00000BF8:       PUSH BC

_GOTO:
00000BF9:       CALL 0B34h			; LNUM_PARM_0 - Get specified line number
; __GO_TO_0
00000BFC:       LD A,(EAC2h)			; CONSAV
00000BFF:       CP 0Dh
00000C01:       EX DE,HL
00000C02:       JP NZ,0C09h
00000C05:       CALL 44A4h			; bank switching pivot (write)
00000C08:       RET

00000C09:       CP 0Eh
00000C0B:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00000C0E:       EX DE,HL
00000C0F:       PUSH HL
00000C10:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00000C13:       CALL 44D5h			; bank switching pivot (read)
00000C16:       EX HL,(SP)
00000C17:       CALL 0C79h			; _REM (skip current line being interpreted)
00000C1A:       INC HL
00000C1B:       PUSH HL
00000C1C:       LD HL,(E656h)			; CURLIN - line number being interpreted
00000C1F:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00000C20:       POP HL
00000C21:       CALL C,060Eh
00000C24:       CALL NC,0605h			; SRCHLN  -  Get first line number
00000C27:       JR NC,+13h
00000C29:       DEC BC
00000C2A:       CALL 44B3h			; use bank pivot (read)
00000C2D:       LD A,0Dh
00000C2F:       LD (EAFFh),A		; PTRFLG
00000C32:       POP HL
00000C33:       CALL 1C71h
00000C36:       LD H,B
00000C37:       LD L,C
00000C38:       CALL 44A4h			; bank switching pivot (write)
00000C3B:       RET

; ULERR - entry for '?UL ERROR'
00000C3C:       LD E,08h
00000C3E:       JP 03B3h				; ERROR, code in E

_RETURN:
00000C41:       CALL ED4Bh
00000C44:       LD (EAFDh),HL		; TEMP - temp. reservation for st.code
00000C47:       LD D,FFh
00000C49:       CALL 0346h			; search 'FOR' block
00000C4C:       LD SP,HL
00000C4D:       LD (EB07h),HL			; SAVSTK
00000C50:       CP 8Dh
00000C52:       LD E,03h
00000C54:       JP NZ,03B3h				; ERROR, code in E
00000C57:       POP HL
00000C58:       LD A,(HL)
00000C59:       AND 01h
00000C5B:       CALL NZ,5008h
00000C5E:       POP BC
00000C5F:       LD HL,0996h			; NEWSTT
00000C62:       EX HL,(SP)
00000C63:       EX DE,HL
00000C64:       LD HL,(EAFDh)		; TEMP - temp. reservation for st.code
00000C67:       DEC HL
00000C68:       RST 10h			 ; CHRGTB - Gets next character (or token) from BASIC text.
00000C69:       JP NZ,0BF9h      ; _GOTO
00000C6C:       LD H,B
00000C6D:       LD L,C
00000C6E:       LD (E656h),HL			; CURLIN - line number being interpreted
00000C71:       EX DE,HL
00000C72:       CALL 44A4h			; bank switching pivot (write)
00000C75:       LD A,E1h

; _DATA (nothing to be executed, skip to next line)
00000C77:       LD BC,0E3Ah		; C=0Eh

; _REM (skip current line being interpreted)
; _ELSE
;00000C79:		LD C,0

00000C7A:       NOP
00000C7B:       LD B,00h
00000C7D:       LD A,C
00000C7E:       LD C,B
00000C7F:       LD B,A
00000C80:       DEC HL
00000C81:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000C82:       OR A
00000C83:       RET Z
00000C84:       CP B
00000C85:       RET Z
00000C86:       INC HL
00000C87:       CP 22h		; '"'
00000C89:       JR Z,-0Eh
00000C8B:       INC A
00000C8C:       JR Z,-0Dh
00000C8E:       SUB 8Ch
00000C90:       JR NZ,-12h
00000C92:       CP B
00000C93:       ADC D
00000C94:       LD D,A
00000C95:       JR -17h
00000C97:       POP AF
00000C98:       ADD 03h
00000C9A:       JR +13h

_LET:
00000C9C:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00000C9F:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000CA0:       POP AF	; DEFB TK_EQUAL..  Token for '='
00000CA1:       EX DE,HL
00000CA2:       LD (EAFDh),HL		; TEMP - temp. reservation for st.code
00000CA5:       EX DE,HL
00000CA6:       PUSH DE
00000CA7:       LD A,(EABDh)		; VALTYP - type indicator
00000CAA:       PUSH AF
00000CAB:       CALL 11D3h			; EVAL - evaluate expression
00000CAE:       POP AF
00000CAF:       EX HL,(SP)
00000CB0:       LD B,A
00000CB1:       LD A,(EABDh)		; VALTYP - type indicator
00000CB4:       CP B
00000CB5:       LD A,B
00000CB6:       JR Z,+06h
00000CB8:       CALL 1796h
00000CBB:       LD A,(EABDh)		; VALTYP - type indicator
00000CBE:       LD DE,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000CC1:       CP 05h
00000CC3:       JR C,+03h
00000CC5:       LD DE,EC3Dh
00000CC8:       PUSH HL
00000CC9:       CP 03h
00000CCB:       JR NZ,+2Eh
00000CCD:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000CD0:       PUSH HL
00000CD1:       INC HL
00000CD2:       LD E,(HL)
00000CD3:       INC HL
00000CD4:       LD D,(HL)
00000CD5:       LD HL,E879h		; BUFFER - start of INPUT buffer
00000CD8:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00000CD9:       JR C,+14h
00000CDB:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00000CDE:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00000CDF:       JR NC,+0Eh
00000CE1:       POP DE
00000CE2:       LD HL,EAEDh
00000CE5:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00000CE6:       JR C,+06h
00000CE8:       LD HL,EACFh
00000CEB:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00000CEC:       JR C,+09h
00000CEE:       LD A,D1h
00000CF0:       CALL 56E7h		; BAKTMP - Back to last tmp-str entry
00000CF3:       EX DE,HL
00000CF4:       CALL 54D8h		; SAVSTR_0
00000CF7:       CALL 56E7h		; BAKTMP - Back to last tmp-str entry
00000CFA:       EX HL,(SP)
; LETNUM:
00000CFB:       CALL 20FCh		; FP2HL - copy number value from DE to HL
00000CFE:       POP DE
00000CFF:       POP HL
00000D00:       RET

_ON:
00000D01:       CP A5h			; TK_ERROR
00000D03:       JR NZ,+2Fh

; ON ERROR..
00000D05:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000D06:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000D07:       ADC C
00000D08:       CALL 0B0Bh				; LNUM_PARM - Read numeric function parameter
00000D0B:       LD A,D
00000D0C:       OR E
00000D0D:       JR Z,+12h
00000D0F:       CALL 44D5h			; bank switching pivot (read)
00000D12:       CALL 0603h 			; SRCHLN_0 - Sink HL in stack and get first line number
00000D15:       CALL 44B3h			; use bank pivot (read)
00000D18:       LD D,B
00000D19:       LD E,C
00000D1A:       POP HL
00000D1B:       JP NC,0C3Ch			; ULERR - entry for '?UL ERROR'
00000D1E:       CALL 44A4h			; bank switching pivot (write)
00000D21:       EX DE,HL
00000D22:       LD (EB0Dh),HL		; ONELIN - LINE to go when error
00000D25:       EX DE,HL
00000D26:       RET C
00000D27:       LD A,(EB0Fh)		; ONEFLG - flag for "ON ERROR"
00000D2A:       OR A
00000D2B:       LD A,E
00000D2C:       RET Z
00000D2D:       LD A,(E649h)			; ERRFLG
00000D30:       LD E,A
00000D31:       JP 03F0h			; WARM_BT (warm boot)

; ON.. other
00000D34:       CALL 6EF6h
00000D37:       JR C,+3Ah
00000D39:       PUSH BC
00000D3A:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000D3B:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000D3C:       ADC L
00000D3D:       XOR A
00000D3E:       POP BC
00000D3F:       PUSH BC
00000D40:       CP C
00000D41:       JP NC,0393h			;  SNERR - entry for '?SN ERROR'
00000D44:       PUSH AF
00000D45:       CALL 0B0Bh				; LNUM_PARM - Read numeric function parameter
00000D48:       LD A,D
00000D49:       OR E
00000D4A:       JR Z,+12h
00000D4C:       CALL 44D5h			; bank switching pivot (read)
00000D4F:       CALL 0603h 			; SRCHLN_0 - Sink HL in stack and get first line number
00000D52:       CALL 44B3h			; use bank pivot (read)
00000D55:       LD D,B
00000D56:       LD E,C
00000D57:       POP HL
00000D58:       CALL 44A4h			; bank switching pivot (write)
00000D5B:       JP NC,0C3Ch			; ULERR - entry for '?UL ERROR'
00000D5E:       POP AF
00000D5F:       POP BC
00000D60:       PUSH AF
00000D61:       ADD B
00000D62:       PUSH BC
00000D63:       CALL 6EEEh
00000D66:       DEC HL
00000D67:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000D68:       POP BC
00000D69:       POP DE
00000D6A:       RET Z
00000D6B:       PUSH BC
00000D6C:       PUSH DE
00000D6D:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000D6E:       DEFB ','
00000D6F:       POP AF
00000D70:       INC A
00000D71:       JR -35h
00000D73:       CALL 18A3h			; GETINT
00000D76:       LD A,(HL)
00000D77:       LD B,A
00000D78:       CP 8Dh
00000D7A:       JR Z,+03h
00000D7C:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000D7D:       ADC C
00000D7E:       DEC HL
00000D7F:       LD C,E
00000D80:       DEC C
00000D81:       LD A,B
00000D82:       JP Z,09EBh
00000D85:       CALL 0B35h
00000D88:       CP 2Ch		; ','
00000D8A:       RET NZ
00000D8B:       JR -0Dh

_RESUME:
00000D8D:       LD DE,EB0Fh		; ONEFLG - flag for "ON ERROR"
00000D90:       LD A,(DE)
00000D91:       OR A
00000D92:       JP Z,03A8h			; "RESUME without error on" error
00000D95:       INC A
00000D96:       LD (E649h),A			; ERRFLG
00000D99:       LD (DE),A
00000D9A:       LD A,(HL)
00000D9B:       CP 83h		; TK_NEXT
00000D9D:       JR Z,+0Ch	; __RESUME_SUB
00000D9F:       CALL 0B34h			; LNUM_PARM_0 - Get specified line number
00000DA2:       RET NZ
00000DA3:       LD A,D
00000DA4:       OR E
00000DA5:       JP NZ,0BFCh
00000DA8:       INC A
00000DA9:       JR +02h

; __RESUME_SUB
00000DAB:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000DAC:       RET NZ
00000DAD:       LD HL,(EB0Bh)		; ERRTXT - Error messages table
00000DB0:       EX DE,HL
00000DB1:       LD HL,(EB09h)		; ERRLIN - Line where last error
00000DB4:       LD (E656h),HL			; CURLIN - line number being interpreted
00000DB7:       EX DE,HL
00000DB8:       PUSH AF
00000DB9:       CALL 44A4h			; bank switching pivot (write)
00000DBC:       POP AF
00000DBD:       RET NZ
00000DBE:       LD A,(HL)
00000DBF:       OR A
00000DC0:       JR NZ,+04h
00000DC2:       INC HL
00000DC3:       INC HL
00000DC4:       INC HL
00000DC5:       INC HL
00000DC6:       INC HL
00000DC7:       JP 0C77h			; _DATA (nothing to be executed, skip to next line)

_ERROR:
00000DCA:       CALL 18A3h			; GETINT
00000DCD:       RET NZ
00000DCE:       OR A
00000DCF:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00000DD2:       JP 03B3h				; ERROR, code in E

_AUTO:
00000DD5:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64B8h
				DEFB 2			; ..will jump to 66BFh, bank 2

00000DDB:       LD A,EAh
00000DDD:       LD BC,0000h
00000DE0:       CALL 7A96h
00000DE3:       JP 7ABDh

00000DE6:       PUSH DE
00000DE7:       LD E,C
00000DE8:       XOR A
00000DE9:       CALL 464Eh
00000DEC:       POP DE
00000DED:       JP 4D77h

00000DF0:       XOR A
00000DF1:       CALL 4655h
00000DF4:       JP 21FDh				; INT_RESULT_HL

00000DF7:       POP AF
00000DF8:       PUSH AF
00000DF9:       PUSH HL
00000DFA:       LD DE,0008h
00000DFD:       ADD HL,DE
00000DFE:       CALL 6F61h
00000E01:       POP HL
00000E02:       JP 7B20h		; POPALL

_IF:
00000E05:       CALL 11D3h			; EVAL - evaluate expression
00000E08:       LD A,(HL)
00000E09:       CP 2Ch		; ','
00000E0B:       CALL Z,0A0Dh			; _CHRGTB - Pick next char from program
00000E0E:       CP 89h				; TK_GOTO (Token for GOTO)
00000E10:       JR Z,+03h
00000E12:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000E13:       DEFB DDh			; TK_THEN
00000E14:       DEC HL              ; Cancel increment
IFGO:
00000E15:       PUSH HL             ; SAVE THE TEXT POINTER
00000E16:       CALL 20BDh			; Test state of expression   ; VSIGN - Test sign in number
00000E19:       POP HL
00000E1A:       JR Z,+1Fh           ; False - Drop through, HANDLE POSSIBLE "ELSE"

00000E1C:       RST 10h			; CHRGTB - ; PICK UP THE FIRST LINE # CHARACTER
00000E1D:       RET Z           ; Go to NEWSTT (RUNCNT) if end of STMT (RETURN FOR "THEN :" OR "ELSE :")
00000E1E:       CP F5h          ; Paged GOTO ?
00000E20:       JR NZ,+08h

00000E22:       CALL 5441h
00000E25:       EX DE,HL
00000E26:       CALL 44A4h			; bank switching pivot (write)
00000E29:       RET

00000E2A:       CP 0Eh              ; LINCON - Line number prefix ?
00000E2C:       JP Z,0BF9h          _GOTO
00000E2F:       CP 0Dh
00000E31:       JP NZ,09EBh
00000E34:       LD HL,(EAC4h)		; CONLO - Value of stored constant
00000E37:       CALL 44A4h			; bank switching pivot (write)
00000E3A:       RET

;
; "ELSE" HANDLER. HERE ON FALSE "IF" CONDITION
;
FALSE_IF:
00000E3B:       LD D,01h
00000E3D:       CALL 0C77h			; _DATA (nothing to be executed, skip to next line)
00000E40:       OR A
00000E41:       RET Z
00000E42:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000E43:       CP 9Fh
00000E45:       JR NZ,-0Ah
00000E47:       DEC D
00000E48:       JR NZ,-0Dh
00000E4A:       JR -30h

_LPRINT:
00000E4C:       LD A,01h
00000E4E:       LD (E64Ch),A		; PRTFLG ("printer enabled" flag)
00000E51:       JP 0E5Ah

_PRINT_
00000E54:       CALL EDCFh
00000E57:       CALL 4C7Dh		; deal with '#' argument
00000E5A:       DEC HL
00000E5B:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.

00000E5C:       CALL Z,5A69h	; OUTDO_CRLF

PRNTLP:
00000E5F:       JP Z,0F8Bh			; FINPRT - finalize PRINT
00000E62:       CP E7h			; TK_USING
00000E64:       JP Z,6642h		; __USING
00000E67:       CP DEh			; TK_TAB
00000E69:       JP Z,0F1Bh		; __TAB(
00000E6C:       CP E2h			; TK_SPC
00000E6E:       JP Z,0F1Bh		; __TAB(
00000E71:       PUSH HL
00000E72:       CP 2Ch		; ','
00000E74:       JR Z,+5Ch
00000E76:       CP 3Bh		; ';'
00000E78:       JP Z,0F86h      ; NEXITM
00000E7B:       POP BC
00000E7C:       CALL 11D3h			; EVAL - evaluate expression
00000E7F:       PUSH HL
00000E80:       RST 30h					; GETYPR -  Test number FAC type (Precision mode, etc..)
00000E81:       JR Z,+0Ch				; JP if string type

00000E83:       CALL 28D0h				; FOUT Convert number/expression to string (format not specified)
00000E86:       CALL 54FCh				; CRTST - Create String

00000E89:       LD (HL),20h
00000E8B:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000E8E:       INC (HL)
00000E8F:       CALL ED5Dh				; ?HPRTF? - Hook 1 for "PRINT"?
00000E92:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00000E95:       JR NZ,+34h
00000E97:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00000E9A:       LD A,(E64Ch)			; PRTFLG ("printer enabled" flag)
00000E9D:       OR A
00000E9E:       JR Z,+15h
00000EA0:       LD A,(E64Eh)			; LPTPOS2
00000EA3:       LD B,A
00000EA4:       INC A
00000EA5:       JR Z,+24h
00000EA7:       LD A,(E64Bh)			; LPTPOS - printer cursor position
00000EAA:       OR A
00000EAB:       JR Z,+1Eh
00000EAD:       ADD (HL)
00000EAE:       CCF
00000EAF:       JR NC,+17h
00000EB1:       DEC A
00000EB2:       CP B
00000EB3:       JR +13h

00000EB5:       LD A,(E64Fh)		; TTYPOS2
00000EB8:       LD B,A
00000EB9:       INC A
00000EBA:       JR Z,+0Fh
00000EBC:       CALL 449Fh		; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)
00000EBF:       OR A
00000EC0:       JR Z,+09h
00000EC2:       ADD (HL)
00000EC3:       CCF
00000EC4:       JR NC,+02h
00000EC6:       DEC A
00000EC7:       CP B
00000EC8:       CALL NC,5A69h	; OUTDO_CRLF
00000ECB:       CALL 5553h				; PRS1
00000ECE:       POP HL
00000ECF:       JP 0E5Ah

00000ED2:       CALL ED6Ch
00000ED5:       LD A,(E6A9h)
00000ED8:       OR A
00000ED9:       JR Z,+06h
00000EDB:       LD A,2Ch
00000EDD:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00000EDE:       JP 0F86h        ; NEXITM

; "," found in PRINT list
; DOCOM:
00000EE1:       LD BC,0008h         ;(NMLO.C) if file output, SPECIAL PRINT POSITION SHOULD BE FETCHED FROM FILE DATA
00000EE4:       LD HL,(EC88h)		; PTRFIL
00000EE7:       ADD HL,BC
00000EE8:       CALL 5372h			; ISFLIO - Tests if I/O to device is taking place
00000EEB:       LD A,(HL)
00000EEC:       JR NZ,+26h          ; to ZONELP IF FILE IS ACTIVE
00000EEE:       LD A,(E64Ch)		; PRTFLG ("printer enabled" flag)
00000EF1:       OR A
00000EF2:       JR Z,+0Eh
00000EF4:       LD A,(E64Dh)
00000EF7:       LD B,A
00000EF8:       INC A
00000EF9:       LD A,(E64Bh)		; LPTPOS - printer cursor position
00000EFC:       JR Z,+16h
00000EFE:       CP B
00000EFF:       JP 0F0Eh

; ISCTTY
00000F02:       LD A,(E650h)	; CLMLST (Column space)
00000F05:       LD B,A
00000F06:       CALL 449Fh		; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)
00000F09:       CP FFh
00000F0B:       JR Z,+07h
00000F0D:       CP B
00000F0E:       CALL NC,5A69h	; OUTDO_CRLF
00000F11:       JP NC,0F86h     ; NEXITM

;ZONELP
; a.k.a MORCOM
00000F14:       SUB 0Eh         ; CLMWID Next zone of 14 characters
00000F16:       JR NC,-04h
00000F18:       CPL             ; Number of spaces to output
                                ; WE WANT TO  FILL THE PRINT POSITION OUT TO AN EVEN CLMWID,
                                ; SO WE PRINT CLMWID-[A] MOD CLMWID SPACES
00000F19:       JR +64h

; __TAB(   &   __SPC(
00000F1B:       PUSH AF
00000F1C:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000F1D:       CALL 1896h				; POSINT - Get positive integer
00000F20:       POP AF
00000F21:       PUSH AF
00000F22:       CP E2h			; TK_SPC
00000F24:       JR Z,+00h

00000F26:       LD A,D
00000F27:       OR A
00000F28:       JP P,0F2Eh
00000F2B:       LD DE,0000h
00000F2E:       PUSH HL
00000F2F:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00000F32:       JR NZ,+16h
00000F34:       LD A,(E64Ch)		; PRTFLG ("printer enabled" flag)
00000F37:       OR A
00000F38:       LD A,(E64Eh)		; LPTPOS2
00000F3B:       JR NZ,+03h
00000F3D:       LD A,(E64Fh)		; TTYPOS2
00000F40:       LD L,A
00000F41:       INC A
00000F42:       JR Z,+06h
00000F44:       LD H,00h
00000F46:       CALL 240Ch				; IMOD
00000F49:       EX DE,HL
00000F4A:       POP HL
00000F4B:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000F4C:       DEFB ')'
00000F4D:       DEC HL
00000F4E:       POP AF
00000F4F:       SUB E2h
00000F51:       PUSH HL
00000F52:       JR Z,+1Ch           ; Yes - Do "E" spaces  ...DOSPC 

; TAB(
00000F54:       LD BC,0008h         ;(NMLO.C) if file output, SPECIAL PRINT POSITION SHOULD BE FETCHED FROM FILE DATA
00000F57:       LD HL,(EC88h)		; PTRFIL
00000F5A:       ADD HL,BC
00000F5B:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00000F5E:       LD A,(HL)
00000F5F:       JR NZ,+0Fh
00000F61:       LD A,(E64Ch)		; PRTFLG ("printer enabled" flag)
00000F64:       OR A
00000F65:       JP Z,0F6Dh
00000F68:       LD A,(E64Bh)			; LPTPOS - printer cursor position
00000F6B:       JR +03h
00000F6D:       CALL 449Fh		; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)

; SPC(     ** DOSPC - Do "E" spaces
00000F70:       CPL              ; Number of spaces to print to    ;PRINT [E]-[A] SPACES
00000F71:       ADD E            ; Total number to print
00000F72:       JR C,+0Bh        ; TAB < Current POS(X)
00000F74:       INC A
00000F75:       JR Z,+0Fh
00000F77:       CALL 5A69h	; OUTDO_CRLF
00000F7A:       LD A,E
00000F7B:       DEC A
00000F7C:       JP M,0F86h  ; NEXITM
00000F7F:       INC A
00000F80:       LD B,A
00000F81:       LD A,20h
00000F83:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00000F84:       DJNZ -03h

; NEXITM
00000F86:       POP HL
00000F87:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00000F88:       JP 0E5Fh        ; More to print  (PRNTLP)

; FINPRT - finalize PRINT
00000F8B:       CALL ED33h          ; ??HFINP??	 Hook 3 for "PRINT"
00000F8E:       LD A,(E6A9h)        ; cassette redirection flag
00000F91:       PUSH AF
00000F92:       DEC A
00000F93:       CALL Z,7F15h        ; TAPIOF
00000F96:       POP AF
00000F97:       INC A
00000F98:       CALL Z,7F1Ah        ; TAPOOF
00000F9B:       XOR A
00000F9C:       LD (E6A9h),A
00000F9F:       LD (E64Ch),A		; PRTFLG ("printer enabled" flag)
00000FA2:       PUSH HL
00000FA3:       LD H,A
00000FA4:       LD L,A
00000FA5:       LD (EC88h),HL		; PTRFIL
00000FA8:       POP HL
00000FA9:       RET

_LINE:
00000FAA:       CP 85h				; TK_INPUT - Token for INPUT to support the "LINE INPUT" statement
00000FAC:       JP NZ,6EAEh			; No, this is a real graphics command !

00000FAF:       CALL EDD5h
00000FB2:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00000FB3:       ADD L
00000FB4:       CP 23h		;'#'
00000FB6:       JP Z,4CC1h
00000FB9:       CP 96h		; ..150
00000FBB:       CALL Z,4121h
00000FBE:       CALL 603Ch			; deal with semicolon, ';'
00000FC1:       CALL 1040h
00000FC4:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00000FC7:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
00000FCA:       PUSH DE
00000FCB:       PUSH HL
00000FCC:       CALL 5FC8h			; INLIN - Same as PINLIN,exept if AUTFLO if set.
00000FCF:       POP DE
00000FD0:       POP BC
00000FD1:       JP C,50F8h
00000FD4:       CALL 4233h
00000FD7:       PUSH BC
00000FD8:       PUSH DE
00000FD9:       LD B,00h
00000FDB:       CALL 54FFh
00000FDE:       POP HL
00000FDF:       LD A,03h
00000FE1:       JP 0CAFh

00000FE4:       DEFM "?Redo from start"
00000FE5:       DEFB 0Dh
00000FE5:       DEFB 0Ah
00000FF6:       NOP


00000FF7:       INC HL
00000FF8:       LD A,(HL)
00000FF9:       OR A
00000FFA:       JP Z,0393h			;  SNERR - entry for '?SN ERROR'
00000FFD:       CP 22h		; '"'
00000FFF:       JR NZ,-0Ah
00001001:       JP 10A5h
00001004:       POP HL
00001005:       POP HL
00001006:       JR +0Ah

; ERR_INPUT
00001008:       CALL ED63h		; ?HTRMN? - Hook for "READ/INPUT" error?
0000100B:       LD A,(EAFCh)	; FLGINP
0000100E:       OR A
0000100F:       JP NZ,038Dh		; DATSNR
00001012:       POP BC
00001013:       LD HL,0FE4h		; REDO_MSG	  "?Redo from start"
00001016:       CALL 5550h			; PRS - Print message pointed by HL
00001019:       LD HL,(EB05h)			; SAVTXT - prg pointer for resume
0000101C:       CALL 44A4h			; bank switching pivot (write)
0000101F:       RET

; jumps here if "INPUT #"
00001020:       CALL 4C7Dh		; deal with '#' argument
00001023:       CALL 44D5h			; bank switching pivot (read)
00001026:       PUSH HL
00001027:       LD HL,E9B8h
0000102A:       JP 10F5h

_INPUT:
0000102D:       CALL EDD8h
00001030:       CP 23h		;'#'
00001032:       JR Z,-14h
00001034:       CP 96h
00001036:       CALL Z,4121h
00001039:       CALL 603Ch			; deal with semicolon, ';'
0000103C:       LD BC,1064h
0000103F:       PUSH BC
00001040:       CP 22h		; '"'
00001042:       LD A,00h
00001044:       LD (E652h),A
00001047:       LD A,FFh
00001049:       LD (EC22h),A
0000104C:       RET NZ
0000104D:       CALL 54FDh				; QTSTR - Create quote terminated String
00001050:       LD A,(HL)
00001051:       CP 2Ch		; ','
00001053:       JR NZ,+07h
00001055:       XOR A
00001056:       LD (EC22h),A
00001059:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000105A:       JR +02h
0000105C:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000105D:       DEFB ';'
0000105E:       PUSH HL
0000105F:       CALL 5553h				; PRS1
00001062:       POP HL
00001063:       RET

00001064:       CALL 44D5h			; bank switching pivot (read)
00001067:       PUSH HL
00001068:       LD A,(EC22h)
0000106B:       OR A
0000106C:       JR Z,+06h
0000106E:       LD A,3Fh
00001070:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00001071:       LD A,20h
00001073:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00001074:       CALL 5FC8h			; INLIN - Same as PINLIN,exept if AUTFLO if set.
00001077:       POP BC
00001078:       JP C,50F8h
0000107B:       CALL 4200h
0000107E:       PUSH BC
0000107F:       XOR A
00001080:       LD (EAFCh),A		; FLGINP
00001083:       LD (HL),2Ch
00001085:       EX DE,HL
00001086:       POP HL
00001087:       PUSH HL
00001088:       CALL 44A4h			; bank switching pivot (write)
0000108B:       PUSH DE
0000108C:       PUSH DE
0000108D:       DEC HL
0000108E:       LD A,80h
00001090:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
00001093:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001094:       CALL 5BB8h
00001097:       LD A,(HL)
00001098:       DEC HL
00001099:       CP 5Bh		; '['
0000109B:       JR Z,+04h
0000109D:       CP 28h		; '('
0000109F:       JR NZ,+1Fh
000010A1:       INC HL
000010A2:       LD B,00h
000010A4:       INC B
000010A5:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000010A6:       JP Z,0393h			;  SNERR - entry for '?SN ERROR'
000010A9:       CP 22h		; '"'
000010AB:       JP Z,0FF7h
000010AE:       CP 28h		; '('
000010B0:       JR Z,-0Eh
000010B2:       CP 5Bh		; '['
000010B4:       JR Z,-11h
000010B6:       CP 5Dh		; ']'
000010B8:       JR Z,+04h
000010BA:       CP 29h		; ')'
000010BC:       JR NZ,-19h
000010BE:       DJNZ -1Bh
000010C0:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000010C1:       JR Z,+05h
000010C3:       CP 2Ch		; ','
000010C5:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
000010C8:       EX HL,(SP)
000010C9:       LD A,(HL)
000010CA:       CP 2Ch		; ','
000010CC:       JP NZ,1004h
000010CF:       LD A,01h
000010D1:       LD (EC47h),A
000010D4:       CALL 1133h
000010D7:       LD A,(EC47h)
000010DA:       DEC A
000010DB:       JP NZ,1004h
000010DE:       PUSH HL
000010DF:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
000010E0:       CALL Z,56CCh		; GSTRCU - Get string pointed by FPREG
000010E3:       POP HL
000010E4:       DEC HL
000010E5:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000010E6:       EX HL,(SP)
000010E7:       LD A,(HL)
000010E8:       CP 2Ch		; ','
000010EA:       JP Z,108Eh
000010ED:       POP HL
000010EE:       DEC HL
000010EF:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000010F0:       OR A
000010F1:       POP HL
000010F2:       JP NZ,1012h
000010F5:       LD (HL),2Ch
000010F7:       JR +0Bh

_READ:
000010F9:       CALL 44D5h			; bank switching pivot (read)
000010FC:       PUSH HL
000010FD:       LD HL,(EB21h)		; DATPTR
00001100:       CALL 44A4h			; bank switching pivot (write)
00001103:       OR AFh
00001105:       LD (EAFCh),A		; FLGINP
00001108:       CALL 44D5h			; bank switching pivot (read)
0000110B:       EX HL,(SP)
0000110C:       CALL 44A4h			; bank switching pivot (write)
0000110F:       DEFB $01	; "LD BC,nn" to jump over the next word without executing it
; _READ_00
00001110:		RST 08h
00001111:		DEFB 2Ch	; ','
00001112:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00001115:       CALL 44D5h			; bank switching pivot (read)
00001118:       EX HL,(SP)
00001119:       CALL 44A4h			; bank switching pivot (write)
0000111C:       PUSH DE
0000111D:       LD A,(HL)
0000111E:       CP 2Ch		; ','
00001120:       JR Z,+10h
00001122:       LD A,(EAFCh)		; FLGINP
00001125:       OR A
00001126:       JP NZ,11A6h
00001129:       LD A,(E6A3h)
0000112C:       OR A
0000112D:       LD E,04h
0000112F:       JP Z,03B3h				; ERROR, code in E
00001132:       OR AFh
00001134:       LD (EC15h),A
00001137:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
0000113A:       JP NZ,4CB3h
0000113D:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000113E:       PUSH AF
0000113F:       JR NZ,+2Eh			; JP if not string type
00001141:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001142:       LD D,A
00001143:       LD B,A
00001144:       CP 22h		; '"'
00001146:       JR Z,+0Ch	; __READ_2
00001148:       LD A,(EAFCh)		; FLGINP
0000114B:       OR A
0000114C:       LD D,A
0000114D:       JR Z,+02h	; __READ_1
0000114F:       LD D,3Ah	; ':'
; __READ_1
00001151:       LD B,2Ch	; ','
00001153:       DEC HL
; __READ_2
00001154:       CALL 5500h			; DTSTR - Create String, termination char in D
00001157:       POP AF
00001158:       ADD 03h		; TK_MID$ ?
0000115A:       LD C,A
0000115B:       LD A,(EC15h)
0000115E:       OR A
0000115F:       RET Z
00001160:       LD A,C
00001161:       PUSH AF
00001162:       CALL 44D5h			; bank switching pivot (read)
00001165:       POP AF
00001166:       EX DE,HL
00001167:       LD HL,117Ch
0000116A:       EX HL,(SP)
0000116B:       PUSH DE
0000116C:       JP 0CB0h
0000116F:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001170:       POP AF
00001171:       PUSH AF
00001172:       LD BC,1157h		; __READ_2+3
00001175:       PUSH BC
00001176:       JP C,26BCh		; DBL_ASCTFP (a.k.a. FIN)
00001179:       JP 26B5h		; DBL_ASCTFP2

0000117C:       CALL 44A4h			; bank switching pivot (write)
0000117F:       DEC HL
00001180:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001181:       JR Z,+05h
00001183:       CP 2Ch		; ','
00001185:       JP NZ,1008h		; ERR_INPUT
00001188:       CALL 44D5h			; bank switching pivot (read)
0000118B:       EX HL,(SP)
0000118C:       CALL 44A4h			; bank switching pivot (write)
0000118F:       DEC HL
00001190:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001191:       JP NZ,1110h		; _READ_00
00001194:       POP DE
00001195:       LD A,(EAFCh)		; FLGINP
00001198:       OR A
00001199:       EX DE,HL
0000119A:       JP NZ,50C5h		; __RESTORE_1
0000119D:       PUSH DE
0000119E:       CALL 44A4h			; bank switching pivot (write)
000011A1:       XOR A
000011A2:       POP HL
000011A3:       JP 0F8Bh			; FINPRT - finalize PRINT

000011A6:       CALL 0C77h			; _DATA (nothing to be executed, skip to next line)
000011A9:       OR A
000011AA:       JR NZ,+1Ah
000011AC:       INC HL
000011AD:       CALL 44E3h
000011B0:       INC HL
000011B1:       LD E,04h
000011B3:       JP Z,03B3h				; ERROR, code in E
000011B6:       INC HL
000011B7:       LD E,(HL)
000011B8:       INC HL
000011B9:       LD D,(HL)
000011BA:       EX DE,HL
000011BB:       LD (EAF9h),HL		; DATLIN
000011BE:       EX DE,HL
000011BF:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000011C0:       CP F5h
000011C2:       CALL Z,5480h
000011C5:       DEC HL
000011C6:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000011C7:       CP 84h
000011C9:       JR NZ,-25h
000011CB:       JP 1132h

; NEXT_EQUAL
000011CE:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000011CF:       POP AF	; DEFB TK_EQUAL..  Token for '='

000011D0:       DEFB 01h		; "LD BC,n" to mask the next line
; NEXT_PARENTH - pick next value after a parenthesis
000011D1:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000011D2:       DEFB '('

; EVAL - evaluate expression
000011D3:       DEC HL
; EVAL_0 	- (a.k.a. GETNUM, evaluate expression (GETNUM)
000011D4:       LD D,00h
000011D6:       PUSH DE
; EVAL1 - Save precedence and eval until precedence break
000011D7:       LD C,02h
000011D9:       CALL 4EC1h			; CHKSTK
000011DC:       CALL ED36h
000011DF:       CALL 1350h			; OPRND - Get next expression value
000011E2:       XOR A
000011E3:       LD (EC46h),A
; EVAL2
000011E6:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
; EVAL3 - Evaluate expression until precedence break
000011E9:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
000011EC:       POP BC
000011ED:       LD A,(HL)
000011EE:       LD (EAF3h),HL		; TEMP3 - used for garbage collection or by USR function
000011F1:       CP F0h		; TK_GREATER
000011F3:       RET C
000011F4:       CP F3h		; TK_PLUS
000011F6:       JR C,+68h
000011F8:       SUB F3h		; TK_PLUS, ; Shifting token offset to '+'
000011FA:       LD E,A
000011FB:       JR NZ,+09h
000011FD:       LD A,(EABDh)		; VALTYP - type indicator
00001200:       CP 03h			; String type?
00001202:       LD A,E
00001203:       JP Z,5680h			; CONCAT - String concatenation
00001206:       CP 0Ch
00001208:       RET NC
00001209:       LD HL,008Ah			; PRITAB - Arithmetic precedence table
0000120C:       LD D,00h
0000120E:       ADD HL,DE
0000120F:       LD A,B
00001210:       LD D,(HL)
00001211:       CP D
00001212:       RET NC
00001213:       PUSH BC
00001214:       LD BC,11E9h			; EVAL3
00001217:       PUSH BC
00001218:       LD A,D
00001219:       CALL ED75h		; ?HNTPL?	- Hook 2 for Expression Evaluator?
0000121C:       CP 7Fh
0000121E:       JR Z,+59h
00001220:       CP 51h		; 'Q'
00001222:       JR C,+62h
00001224:       AND FEh
00001226:       CP 7Ah		; 'z'
00001228:       JR Z,+5Ch
0000122A:       LD HL,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000122D:       LD A,(EABDh)		; VALTYP - type indicator
00001230:       SUB 03h			; String type ?
00001232:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error
00001235:       OR A
00001236:       LD C,(HL)
00001237:       INC HL
00001238:       LD B,(HL)
00001239:       PUSH BC
0000123A:       JP M,1251h
0000123D:       INC HL
0000123E:       LD C,(HL)
0000123F:       INC HL
00001240:       LD B,(HL)
00001241:       PUSH BC
00001242:       JP PO,1251h
00001245:       LD HL,EC3Dh
00001248:       LD C,(HL)
00001249:       INC HL
0000124A:       LD B,(HL)
0000124B:       INC HL
0000124C:       PUSH BC
0000124D:       LD C,(HL)
0000124E:       INC HL
0000124F:       LD B,(HL)
00001250:       PUSH BC
00001251:       ADD 03h
00001253:       LD C,E
00001254:       LD B,A
00001255:       PUSH BC
00001256:       LD BC,12ABh
00001259:       PUSH BC
0000125A:       LD HL,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
0000125D:       JP 11D6h			; EVAL + 2

00001260:       LD D,00h
00001262:       SUB F0h		; TK_GREATER
00001264:       JR C,+2Bh		; NO_COMPARE_TK
00001266:       CP 03h		; TK_MID_S
00001268:       JR NC,+27h		; NO_COMPARE_TK
0000126A:       CP 01h		; TK_LEFT_S
0000126C:       RLA
0000126D:       XOR D
0000126E:       CP D
0000126F:       LD D,A
00001270:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
00001273:       LD (EAF3h),HL		; TEMP3 - used for garbage collection or by USR function
00001276:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001277:       JR -17h

00001279:       CALL 2214h			; CSNG - Convert number to single precision
0000127C:       CALL 20CDh			; STAKFP - Put FP value on stack
0000127F:       LD BC,2E10h
00001282:       LD D,7Fh
00001284:       JR -2Dh
00001286:       PUSH DE
00001287:       CALL 21A0h			; CINT
0000128A:       POP DE
0000128B:       PUSH HL
0000128C:       LD BC,1532h
0000128F:       JR -38h

NO_COMPARE_TK:
00001291:       LD A,B
00001292:       CP 64h
00001294:       RET NC
00001295:       PUSH BC
00001296:       PUSH DE
00001297:       LD DE,6404h
0000129A:       LD HL,1506h
0000129D:       PUSH HL
0000129E:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000129F:       JP NZ,122Ah			; JP if not string type
000012A2:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000012A5:       PUSH HL
000012A6:       LD BC,5494h         ; STRCMP
000012A9:       JR -52h

000012AB:       POP BC
000012AC:       LD A,C
000012AD:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
000012B0:       LD A,(EABDh)		; VALTYP - type indicator
000012B3:       CP B
000012B4:       JR NZ,+0Bh
000012B6:       CP 02h			; Integer ?
000012B8:       JR Z,+1Fh
000012BA:       CP 04h			; single precision ?
000012BC:       JP Z,1326h
000012BF:       JR NC,+2Bh
000012C1:       LD D,A
000012C2:       LD A,B
000012C3:       CP 08h			; Double precision ?
000012C5:       JR Z,+22h
000012C7:       LD A,D
000012C8:       CP 08h			; Double precision ?
000012CA:       JR Z,+44h
000012CC:       LD A,B
000012CD:       CP 04h			; Single precision ?
000012CF:       JR Z,+52h
000012D1:       LD A,D
000012D2:       CP 03h			; String ?
000012D4:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error
000012D7:       JR NC,+54h
000012D9:       LD HL,00B4h
000012DC:       LD B,00h
000012DE:       ADD HL,BC
000012DF:       ADD HL,BC
000012E0:       LD C,(HL)
000012E1:       INC HL
000012E2:       LD B,(HL)
000012E3:       POP DE
000012E4:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000012E7:       PUSH BC
000012E8:       RET

000012E9:       CALL 223Eh			; CDBL
000012EC:       CALL 2124h			; FP_ARG2HL
000012EF:       POP HL
000012F0:       LD (EC3Fh),HL
000012F3:       POP HL
000012F4:       LD (EC3Dh),HL
000012F7:       POP BC
000012F8:       POP DE
000012F9:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
000012FC:       CALL 223Eh			; CDBL
000012FF:       LD HL,00A0h			; DEC_OPR - ARITHMETIC OPERATIONS TABLE  

00001302:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001305:       RLCA
00001306:       ADD L
00001307:       LD L,A
00001308:       ADC H
00001309:       SUB L
0000130A:       LD H,A
0000130B:       LD A,(HL)
0000130C:       INC HL
0000130D:       LD H,(HL)
0000130E:       LD L,A
0000130F:       LD PC,HL

00001310:       LD A,B
00001311:       PUSH AF
00001312:       CALL 2124h			; FP_ARG2HL
00001315:       POP AF
00001316:       LD (EABDh),A		; VALTYP - type indicator
00001319:       CP 04h			; Single precision ?
0000131B:       JR Z,-26h

0000131D:       POP HL
0000131E:       LD (EC41h),HL		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00001321:       JR -27h

00001323:       CALL 2214h			; CSNG - Convert number to single precision
00001326:       POP BC
00001327:       POP DE
00001328:       LD HL,00AAh			; FLT_OPR - FP operations table
0000132B:       JR -2Bh

0000132D:       POP HL
0000132E:       CALL 20CDh			; STAKFP - Put FP value on stack
00001331:       CALL 2232h
00001334:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
00001337:       POP HL
00001338:       LD (EC43h),HL		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
0000133B:       POP HL
0000133C:       LD (EC41h),HL		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000133F:       JR -19h

; INT_DIV - Integer DIVISION (aka IDIV)
00001341:       PUSH HL
00001342:       EX DE,HL
00001343:       CALL 2232h
00001346:       POP HL
00001347:       CALL 20CDh			; STAKFP - Put FP value on stack
0000134A:       CALL 2232h
0000134D:       JP 1FB5h			; DIV - Divide FP by number on stack

; OPRND - Get next expression value
00001350:       INA (71h)			; save Extended ROM bank status
00001352:       PUSH AF
00001353:       LD A,FFh				; back to main ROM
00001355:       OUTA (71h)				; Extended ROM bank switching
00001357:       CALL 135Eh			; + operand
0000135A:       POP AF
0000135B:       OUTA (71h)			; restore Extended ROM bank status
0000135D:       RET

; + operand
0000135E:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000135F:       JP Z,03AEh		; "Missing operand" error
00001362:       JP C,26BCh		; DBL_ASCTFP (a.k.a. FIN)
00001365:       CALL 5216h		; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00001368:       JP NC,1406h
0000136B:       CP 20h		; ' '
0000136D:       JP C,0A5Fh
00001370:       CALL ED27h		; ?HEVAL? - Hook 1 for Factor Evaluator?
00001373:       INC A
00001374:       JP Z,147Eh
00001377:       DEC A
00001378:       CP F3h
0000137A:       JR Z,-1Eh
0000137C:       CP F4h			; TK_MINUS, Token for '-'
0000137E:       JP Z,13F8h				; '-' operand
00001381:       CP 22h		; '"'
00001383:       JP Z,54FDh				; QTSTR - Create quote terminated String
00001386:       CP E3h		; TK_NOT
00001388:       JP Z,1512h				; 'NOT' operand
0000138B:       CP 26h		; '&'
0000138D:       JP Z,1423h				; '&' specifier, convert text with radix indication to number
00001390:       CP E5h		; TK_ERR, Token for ERR()
00001392:       JR NZ,+0Ah		; OPRND_0

; 'ERR'
00001394:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001395:       LD A,(E649h)	; ERRFLG
00001398:       PUSH HL
00001399:       CALL 1589h			; UNSIGNED_RESULT_A
0000139C:       POP HL
0000139D:       RET

; OPRND_0:
0000139E:       CP E4h			; TK_ERL, Token for ERL()
000013A0:       JR NZ,+0Ah		; OPRND_00

; 'ERL'
000013A2:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000013A3:       PUSH HL
000013A4:       LD HL,(EB09h)		; ERRLIN - Line where last error
000013A7:       CALL 2402h		; DBL_ABS_0
000013AA:       POP HL
000013AB:       RET

; OPRND_00:
000013AC:       CP EAh			; TK_VARPTR, Token for VARPTR()
000013AE:       JR NZ,+24h		; OPRND_1

; 'VARPTR'
000013B0:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000013B1:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000013B2:       DEFB '('
000013B3:       CP '#'
000013B5:       JR NZ,+0Ch	; VARPTR_0
000013B7:       CALL 18A2h				; FNDNUM - Load 'A' with the next number in BASIC program
000013BA:       PUSH HL
000013BB:       CALL 46F8h				; GETPTR - get i/o channel control block
000013BE:       EX DE,HL
000013BF:       POP HL
000013C0:       JP 13C6h	; VARPTR_1

000013C3:       CALL 5BB8h

; VARPTR_1
000013C6:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000013C7:       DEFB ')'
000013C8:       PUSH HL
000013C9:       EX DE,HL
000013CA:       LD A,H
000013CB:       OR L
000013CC:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
000013CF:       CALL 21FDh				; INT_RESULT_HL
000013D2:       POP HL
000013D3:       RET

; OPRND_1
000013D4:       CP E0h				; TK_USR
000013D6:       JP Z,158Fh			; 'USR'

000013D9:       CP E8h				; TK_INSTR
000013DB:       JP Z,57D7h			; 'INSTR'

000013DE:       CP EFh				; TK_INKEY$
000013E0:       JP Z,5AA3h			; 'INKEY$'

000013E3:       CP E6h				; TK_STRING
000013E5:       JP Z,5722h			; 'STRING$'

000013E8:       CP 85h				; TK_INPUT - Token for INPUT
000013EA:       JP Z,4BACh			; 'INPUT'

000013ED:       CP E1h				; TK_FN
000013EF:       JP Z,1600h			; 'FN'

; OPRND_6 - text for rightmost parenthesis
000013F2:       CALL 11D1h			; NEXT_PARENTH - pick next value after a parenthesis
000013F5:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000013F6:       DEFB ')'
000013F7:       RET

; '-' operand
000013F8:       LD D,7Dh
000013FA:       CALL 11D6h			; EVAL + 2
000013FD:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
00001400:       PUSH HL
00001401:       CALL 20A4h			; INVSGN2 - Invert number sign

; point to POP HL / RET instructions
00001404:       POP HL
00001405:       RET

00001406:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00001409:       PUSH HL
0000140A:       EX DE,HL
0000140B:       LD (EC41h),HL		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000140E:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000140F:       CALL NZ,211Fh		; call FP_HL2DE if not string type
00001412:       POP HL
00001413:       RET

; UCASE_HL - Get char from (HL) and make upper case
00001414:       LD A,(HL)
; UCASE - Make char in 'A' upper case
00001415:       CP 61h		; 'a'
00001417:       RET C
00001418:       CP 7Bh		; 'z'+1
0000141A:       RET NC
0000141B:       AND 5Fh
0000141D:       RET

0000141E:       CP 26h		; '&'
00001420:       JP NZ,0B34h			; LNUM_PARM_0 - Get specified line number

; convert text with radix indication to number
00001423:       LD DE,0000h
00001426:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001427:       CALL 1415h			; UCASE - Make char in 'A' upper case
0000142A:       CP 4Fh			; 'O', octal.
0000142C:       JR Z,+2Eh

0000142E:       CP 48h			; 'H', hex.
00001430:       JR NZ,+29h

00001432:       LD B,05h
00001434:       INC HL
00001435:       LD A,(HL)
00001436:       CALL 1415h			; UCASE - Make char in 'A' upper case
00001439:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
0000143C:       EX DE,HL
0000143D:       JR NC,+0Ah
0000143F:       CP 3Ah		; '9'+1
00001441:       JR NC,+36h
00001443:       SUB 30h		; '0'
00001445:       JR C,+32h
00001447:       JR +06h

; hex
00001449:       CP 47h		; 'F'+1
0000144B:       JR NC,+2Ch
0000144D:       SUB 37h
0000144F:       ADD HL,HL
00001450:       ADD HL,HL
00001451:       ADD HL,HL
00001452:       ADD HL,HL
00001453:       OR L
00001454:       LD L,A
00001455:       EX DE,HL
00001456:       DJNZ -24h
00001458:       JP 03ABh		; "Overflow" error

; decimal
0000145B:       DEC HL
; 'O', octal.
0000145C:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000145D:       EX DE,HL
0000145E:       JR NC,+19h

00001460:       CP 38h		; '8'
00001462:       JP NC,0393h			;  SNERR - entry for '?SN ERROR'
00001465:       LD BC,03ABh			; "Overflow" error
00001468:       PUSH BC
00001469:       ADD HL,HL
0000146A:       RET C
0000146B:       ADD HL,HL
0000146C:       RET C
0000146D:       ADD HL,HL
0000146E:       RET C
0000146F:       POP BC
00001470:       LD B,00h
00001472:       SUB 30h		; '0'
00001474:       LD C,A
00001475:       ADD HL,BC
00001476:       EX DE,HL
00001477:       JR -1Dh

; from 145e
00001479:       CALL 21FDh				; INT_RESULT_HL
0000147C:       EX DE,HL
0000147D:       RET

0000147E:       INC HL
0000147F:       LD A,(HL)
00001480:       SUB 81h
00001482:       CP 07h
00001484:       JR NZ,+0Ah
00001486:       PUSH HL
00001487:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001488:       CP 28h		; '('
0000148A:       POP HL
0000148B:       JP NZ,2F0Bh
0000148E:       LD A,07h
00001490:       CP 4Fh			; token code < 4fh-81h ?
00001492:       JR C,+19h

00001494:       LD DE,6B02h		; jump table for extra functions-2
00001497:       SUB 4Fh
; map function number in A to JP table pointed by DE
00001499:       EX DE,HL
0000149A:       ADD A
0000149B:       LD C,A
0000149C:       LD B,00h
0000149E:       ADD HL,BC
0000149F:       ADD HL,BC
000014A0:       LD C,(HL)
000014A1:       INC HL
000014A2:       LD B,(HL)
000014A3:       PUSH BC
000014A4:       LD A,B
000014A5:       OR C
000014A6:       JP Z,0393h			;  SNERR - entry for '?SN ERROR'
000014A9:       EX DE,HL
000014AA:       JP 0A0Dh			; _CHRGTB - Pick next char from program
; Eval token codes <4F
000014AD:       LD B,00h
000014AF:       RLCA
000014B0:       LD C,A
000014B1:       PUSH BC
000014B2:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000014B3:       LD A,C
000014B4:       CP 05h
000014B6:       JR NC,+16h
000014B8:       CALL 11D1h			; NEXT_PARENTH - pick next value after a parenthesis
000014BB:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000014BC:       DEFB ','
000014BD:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
000014C0:       EX DE,HL
000014C1:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000014C4:       EX HL,(SP)
000014C5:       PUSH HL
000014C6:       EX DE,HL
000014C7:       CALL 18A3h			; GETINT
000014CA:       EX DE,HL
000014CB:       EX HL,(SP)
000014CC:       JR +1Ch
000014CE:       CALL 13F2h			; OPRND_6 - text for rightmost parenthesis
000014D1:       EX HL,(SP)
000014D2:       LD A,L
000014D3:       CP 0Ch
000014D5:       JR C,+0Ah
000014D7:       CP 1Bh
000014D9:       CALL ED5Ah			; ? HOKNO ? - Hook 2 for Factor Evaluator
000014DC:       PUSH HL
000014DD:       CALL C,2214h			; CSNG - Convert number to single precision
000014E0:       POP HL
000014E1:       LD DE,1404h		; point to POP HL / RET instructions
000014E4:       PUSH DE
000014E5:       LD A,01h
000014E7:       LD (EC46h),A
000014EA:       LD BC,6AB0h
000014ED:       CALL ED2Dh 			; ? HFING ? - Hook 3 for Factor Evaluator

000014F0:       ADD HL,BC
000014F1:       LD C,(HL)
000014F2:       INC HL
000014F3:       LD H,(HL)
000014F4:       LD L,C
000014F5:       LD PC,HL

; test '+', '-'..
000014F6:       DEC D
000014F7:       CP F4h		; TK_MINUS, Token for '-'
000014F9:       RET Z
000014FA:       CP 2Dh		; '-'
000014FC:       RET Z
000014FD:       INC D
000014FE:       CP 2Bh		; '+'
00001500:       RET Z
00001501:       CP F3h		; TK_PLUS, Token for '+'
00001503:       RET Z
00001504:       DEC HL
00001505:       RET

00001506:       INC A
00001507:       ADC A
00001508:       POP BC
00001509:       AND B
0000150A:       ADD FFh
0000150C:       SBC A
0000150D:       CALL 20B6h		; INT_RESULT_A - Get back from function, result in A (signed)
00001510:       JR +12h

; 'NOT' operand
00001512:       LD D,5Ah
00001514:       CALL 11D6h			; EVAL + 2
00001517:       CALL 21A0h			; CINT
0000151A:       LD A,L
0000151B:       CPL
0000151C:       LD L,A
0000151D:       LD A,H
0000151E:       CPL
0000151F:       LD H,A
00001520:       JP 0052h		; FP operation on far memory bank

00001523:       POP BC
00001524:       JP 11E9h			; EVAL3

00001527:       JR NC,+05h
00001529:       SUB 03h
0000152B:       OR A
0000152C:       SCF
0000152D:       RET

0000152E:       SUB 03h
00001530:       OR A
00001531:       RET

00001532:       LD A,B
00001533:       PUSH AF
00001534:       CALL 21A0h			; CINT
00001537:       POP AF
00001538:       POP DE
00001539:       CP 7Ah				; 'z'
0000153B:       JP Z,240Ch			; IMOD
0000153E:       CP 7Bh				; 'z'+1
00001540:       JP Z,23ABh
00001543:       LD BC,158Bh
00001546:       PUSH BC
00001547:       CP 46h				; 70, 'F'
00001549:       JR NZ,+06h
0000154B:       LD A,E
0000154C:       OR L
0000154D:       LD L,A
0000154E:       LD A,H
0000154F:       OR D
00001550:       RET

00001551:       CP 50h		; 80,  'P'
00001553:       JR NZ,+06h
00001555:       LD A,E
00001556:       AND L
00001557:       LD L,A
00001558:       LD A,H
00001559:       AND D
0000155A:       RET

0000155B:       CP 3Ch		; 60, '<'
0000155D:       JR NZ,+06h
0000155F:       LD A,E
00001560:       XOR L
00001561:       LD L,A
00001562:       LD A,H
00001563:       XOR D
00001564:       RET

00001565:       CP 32h		; 50, '2'
00001567:       JR NZ,+08h
00001569:       LD A,E
0000156A:       XOR L
0000156B:       CPL
0000156C:       LD L,A
0000156D:       LD A,H
0000156E:       XOR D
0000156F:       CPL
00001570:       RET

00001571:       LD A,L
00001572:       CPL
00001573:       AND E
00001574:       CPL
00001575:       LD L,A
00001576:       LD A,H
00001577:       CPL
00001578:       AND D
00001579:       CPL
0000157A:       RET

0000157B:       OR A
0000157C:       SBC HL,DE
0000157E:       JP 2402h		; DBL_ABS_0

_LPOS:
00001581:       LD A,(E64Bh)			; LPTPOS - printer cursor position
00001584:       JR +03h					; UNSIGNED_RESULT_A

_POS:
00001586:       CALL 449Fh		; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)

; UNSIGNED_RESULT_A
00001589:       LD L,A
0000158A:       XOR A
0000158B:       LD H,A
0000158C:       JP 21FDh				; INT_RESULT_HL

_USR:
0000158F:       CALL 15AEh
00001592:       PUSH DE
00001593:       CALL 13F2h			; OPRND_6 - text for rightmost parenthesis
00001596:       EX HL,(SP)
00001597:       LD E,(HL)
00001598:       INC HL
00001599:       LD D,(HL)
0000159A:       LD HL,1FA5h			; POPHLRT - (POP HL / RET)
0000159D:       PUSH HL
0000159E:       PUSH DE
0000159F:       LD A,(EABDh)		; VALTYP - type indicator
000015A2:       PUSH AF
000015A3:       CP 03h
000015A5:       CALL Z,56CCh		; GSTRCU - Get string pointed by FPREG
000015A8:       POP AF
000015A9:       EX DE,HL
000015AA:       LD HL,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000015AD:       RET


000015AE:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000015AF:       LD BC,0000h
000015B2:       CP 1Bh
000015B4:       JR NC,+0Bh
000015B6:       CP 11h
000015B8:       JR C,+07h
000015BA:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000015BB:       LD A,(EAC4h)	; CONLO - Value of stored constant
000015BE:       OR A
000015BF:       RLA
000015C0:       LD C,A
000015C1:       EX DE,HL
000015C2:       LD HL,E635h		; USR0
000015C5:       ADD HL,BC
000015C6:       EX DE,HL
000015C7:       RET

DEF_USR:
000015C8:       CALL 15AEh
000015CB:       PUSH DE
000015CC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000015CD:       POP AF	; DEFB TK_EQUAL..  Token for '='
000015CE:       CALL 1B93h			; GETWORD
000015D1:       EX HL,(SP)
000015D2:       LD (HL),E
000015D3:       INC HL
000015D4:       LD (HL),D
000015D5:       POP HL
000015D6:       RET

_DEF:
000015D7:       CP E0h				; TK_USR
000015D9:       JR Z,-13h			; DEF_USR
000015DB:       CALL 17BDh			; GETFN
000015DE:       CALL 17AFh			; NO_DIRECT
000015E1:       CALL 44D5h			; bank switching pivot (read)
000015E4:       EX DE,HL
000015E5:       LD (HL),E
000015E6:       INC HL
000015E7:       LD (HL),D
000015E8:       EX DE,HL
000015E9:       CALL 44A4h			; bank switching pivot (write)
000015EC:       LD A,(HL)
000015ED:       CP 28h		; '('
000015EF:       JP NZ,0C77h			; _DATA (nothing to be executed, skip to next line)
000015F2:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000015F3:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
000015F6:       LD A,(HL)
000015F7:       CP 29h		; ')'
000015F9:       JP Z,0C77h			; _DATA (nothing to be executed, skip to next line)
000015FC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000015FD:       DEFB ','
000015FE:       JR -0Dh

_FN:
00001600:       CALL 17BDh			; GETFN
00001603:       LD A,(EABDh)		; VALTYP - type indicator
00001606:       OR A
00001607:       PUSH AF
00001608:       CALL 44D5h			; bank switching pivot (read)
0000160B:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
0000160E:       EX DE,HL
0000160F:       LD A,(HL)
00001610:       INC HL
00001611:       LD H,(HL)
00001612:       LD L,A
00001613:       LD A,H
00001614:       OR L
00001615:       JP Z,03A5h
00001618:       CALL 44A4h			; bank switching pivot (write)
0000161B:       LD A,(HL)
0000161C:       CP 28h		; '('
0000161E:       JP NZ,1707h
00001621:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001622:       CALL 44D5h			; bank switching pivot (read)
00001625:       LD (EAF3h),HL		; TEMP3 - used for garbage collection or by USR function
00001628:       EX DE,HL
00001629:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
0000162C:       CALL 44A4h			; bank switching pivot (write)
0000162F:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001630:       JR Z,-51h
00001632:       PUSH AF
00001633:       CALL 44D5h			; bank switching pivot (read)
00001636:       PUSH HL
00001637:       PUSH HL
00001638:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
0000163B:       CALL 44D5h			; bank switching pivot (read)
0000163E:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00001641:       POP HL
00001642:       EX DE,HL
00001643:       CALL 44A4h			; bank switching pivot (write)
00001646:       LD A,80h
00001648:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
0000164B:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
0000164E:       CALL 44D5h			; bank switching pivot (read)
00001651:       EX DE,HL
00001652:       EX HL,(SP)
00001653:       LD A,(EABDh)		; VALTYP - type indicator
00001656:       PUSH AF
00001657:       PUSH DE
00001658:       PUSH HL
00001659:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
0000165C:       CALL 44A4h			; bank switching pivot (write)
0000165F:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00001662:       POP HL
00001663:       CALL 44A4h			; bank switching pivot (write)
00001666:       CALL 11D3h			; EVAL - evaluate expression
00001669:       CALL 44D5h			; bank switching pivot (read)
0000166C:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
0000166F:       POP HL
00001670:       LD (EAF3h),HL		; TEMP3 - used for garbage collection or by USR function
00001673:       POP AF
00001674:       CALL 1796h
00001677:       LD C,04h
00001679:       CALL 4EC1h			; CHKSTK
0000167C:       LD HL,FFF8h
0000167F:       ADD HL,SP
00001680:       LD SP,HL
00001681:       CALL 2127h
00001684:       LD A,(EABDh)		; VALTYP - type indicator
00001687:       PUSH AF
00001688:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
0000168B:       CALL 44A4h			; bank switching pivot (write)
0000168E:       LD A,(HL)
0000168F:       CP 29h		; ')'
00001691:       JR Z,+1Dh
00001693:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001694:       DEFB ','
00001695:       CALL 44D5h			; bank switching pivot (read)
00001698:       PUSH HL
00001699:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
0000169C:       CALL 44D5h			; bank switching pivot (read)
0000169F:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
000016A2:       LD HL,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
000016A5:       CALL 44A4h			; bank switching pivot (write)
000016A8:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000016A9:       DEFB ','
000016AA:       JR -66h
000016AC:       POP AF
000016AD:       LD (EBA7h),A		; PRMLN2 - size of parameter block
000016B0:       POP AF
000016B1:       OR A
000016B2:       JR Z,+3Fh
000016B4:       LD (EABDh),A		; VALTYP - type indicator
000016B7:       LD HL,0000h
000016BA:       ADD HL,SP
000016BB:       CALL 211Fh			; FP_HL2DE
000016BE:       LD HL,0008h
000016C1:       ADD HL,SP
000016C2:       LD SP,HL
000016C3:       POP DE
000016C4:       LD L,03h
000016C6:       INC L
000016C7:       DEC DE
000016C8:       LD A,(DE)
000016C9:       OR A
000016CA:       JP M,16C6h
000016CD:       DEC DE
000016CE:       DEC DE
000016CF:       DEC DE
000016D0:       LD A,(EABDh)		; VALTYP - type indicator
000016D3:       ADD L
000016D4:       LD B,A
000016D5:       LD A,(EBA7h)		; PRMLN2 - size of parameter block
000016D8:       LD C,A
000016D9:       ADD B
000016DA:       CP 64h
000016DC:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
000016DF:       PUSH AF
000016E0:       LD A,L
000016E1:       LD B,00h
000016E3:       LD HL,EBA9h			; PARM2
000016E6:       ADD HL,BC
000016E7:       LD C,A
000016E8:       CALL 17AAh
000016EB:       LD BC,16ACh
000016EE:       PUSH BC
000016EF:       PUSH BC
000016F0:       JP 0CBBh

000016F3:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
000016F6:       CALL 44A4h			; bank switching pivot (write)
000016F9:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000016FA:       CALL 44D5h			; bank switching pivot (read)
000016FD:       PUSH HL
000016FE:       LD HL,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
00001701:       CALL 44A4h			; bank switching pivot (write)
00001704:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001705:       DEFB ')'
00001706:       LD A,D5h
00001708:       CALL 44D5h			; bank switching pivot (read)
0000170B:       LD (EAF3h),HL		; TEMP3 - used for garbage collection or by USR function
0000170E:       LD A,(EB3Fh)		; PRMLEN - number of bytes of obj table
00001711:       ADD 04h
00001713:       PUSH AF
00001714:       RRCA
00001715:       LD C,A
00001716:       CALL 4EC1h			; CHKSTK
00001719:       POP AF
0000171A:       LD C,A
0000171B:       CPL
0000171C:       INC A
0000171D:       LD L,A
0000171E:       LD H,FFh
00001720:       ADD HL,SP
00001721:       LD SP,HL
00001722:       PUSH HL
00001723:       LD DE,EB3Dh			; PRMSTK - previous block definition on stack
00001726:       CALL 17AAh
00001729:       POP HL
0000172A:       LD (EB3Dh),HL		; PRMSTK - previous block definition on stack
0000172D:       LD HL,(EBA7h)		; PRMLN2 - size of parameter block
00001730:       LD (EB3Fh),HL		; PRMLEN - number of bytes of obj table
00001733:       LD B,H
00001734:       LD C,L
00001735:       LD HL,EB41h			; PARM1
00001738:       LD DE,EBA9h			; PARM2
0000173B:       CALL 17AAh
0000173E:       LD H,A
0000173F:       LD L,A
00001740:       LD (EBA7h),HL		; PRMLN2 - size of parameter block
00001743:       LD HL,(EC13h)		; FUNACT - active functions counter
00001746:       INC HL
00001747:       LD (EC13h),HL		; FUNACT - active functions counter
0000174A:       LD A,H
0000174B:       OR L
0000174C:       LD (EC10h),A		; NOFUNS - 0 if no function active
0000174F:       LD HL,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
00001752:       CALL 44A4h			; bank switching pivot (write)
00001755:       CALL 11CEh			; NEXT_EQUAL
00001758:       DEC HL
00001759:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000175A:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
0000175D:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000175E:       JR NZ,+0Fh			; JP if not string type
00001760:       LD DE,EAEEh			; TMPSTR - Temporary string
00001763:       LD HL,(EC41h)		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00001766:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00001767:       JR C,+06h
00001769:       CALL 54D8h			; SAVSTR_0
0000176C:       CALL 5530h			; $552F+1
0000176F:       LD HL,(EB3Dh)		; PRMSTK - previous block definition on stack
00001772:       LD D,H
00001773:       LD E,L
00001774:       INC HL
00001775:       INC HL
00001776:       LD C,(HL)
00001777:       INC HL
00001778:       LD B,(HL)
00001779:       INC BC
0000177A:       INC BC
0000177B:       INC BC
0000177C:       INC BC
0000177D:       LD HL,EB3Dh			; PRMSTK - previous block definition on stack
00001780:       CALL 17AAh
00001783:       EX DE,HL
00001784:       LD SP,HL
00001785:       LD HL,(EC13h)		; FUNACT - active functions counter
00001788:       DEC HL
00001789:       LD (EC13h),HL		; FUNACT - active functions counter
0000178C:       LD A,H
0000178D:       OR L
0000178E:       LD (EC10h),A		; NOFUNS - 0 if no function active
00001791:       POP HL
00001792:       CALL 44A4h			; bank switching pivot (write)
00001795:       POP AF
00001796:       PUSH HL
00001797:       AND 07h
00001799:       LD HL,0096h			; TYPE_OPR - NUMBER TYPE CONVERSION OPERATIONS TABLE  
0000179C:       LD C,A
0000179D:       LD B,00h
0000179F:       ADD HL,BC
000017A0:       CALL 14F0h
000017A3:       POP HL
000017A4:       RET

000017A5:       LD A,(DE)
000017A6:       LD (HL),A
000017A7:       INC HL
000017A8:       INC DE
000017A9:       DEC BC

000017AA:       LD A,B
000017AB:       OR C
000017AC:       JR NZ,-09h
000017AE:       RET

; NO_DIRECT
; Error if in 'DIRECT' (immediate) mode
000017AF:       PUSH HL
000017B0:       LD HL,(E656h)			; CURLIN - line number being interpreted
000017B3:       INC HL
000017B4:       LD A,H
000017B5:       OR L
000017B6:       POP HL
000017B7:       RET NZ
000017B8:       LD E,0Ch
000017BA:       JP 03B3h				; ERROR, code in E

; GETFN
000017BD:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000017BE:       POP HL
000017BF:       LD A,80h
000017C1:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
000017C4:       OR (HL)
000017C5:       LD C,A
000017C6:       JP 5ACFh			; GETVAR_0

; check function tokens
000017C9:       CP 7Eh
000017CB:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
000017CE:       INC HL
000017CF:       LD A,(HL)
000017D0:       INC HL
000017D1:       CP 83h			; TK_POINT ?
000017D3:       JP Z,585Ah
000017D6:       DEC HL
000017D7:       SUB D0h
000017D9:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
000017DC:       LD DE,6B04h			; jump table for extra functions
000017DF:       JP 1499h			; map function number in A to JP table pointed by DE

000017E2:       JP 0393h			;  SNERR - entry for '?SN ERROR'

_INP:
000017E5:       CALL 1B9Dh			; GETWORD_HL
000017E8:       LD B,H
000017E9:       LD C,L
000017EA:       IN A,(C)
000017EC:       JP 1589h			; UNSIGNED_RESULT_A

; GTWORD_GTINT - Get "WORD,BYTE" paramenters
000017EF:       CALL 1B93h			; GETWORD
000017F2:       PUSH DE
000017F3:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000017F4:       DEFB ','
000017F5:       CALL 18A3h			; GETINT
000017F8:       POP BC
000017F9:       RET

_OUT:
000017FA:       CALL 17EFh			; GTWORD_GTINT - Get "WORD,BYTE" paramenters
000017FD:       OUT (C),A
000017FF:       RET

_WAIT:
00001800:       CALL 17EFh			; GTWORD_GTINT - Get "WORD,BYTE" paramenters
00001803:       PUSH BC
00001804:       PUSH AF
00001805:       LD E,00h
00001807:       DEC HL
00001808:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001809:       JR Z,+05h
0000180B:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000180C:       DEFB ','
0000180D:       CALL 18A3h			; GETINT
00001810:       POP AF
00001811:       LD D,A
00001812:       POP BC
00001813:       IN A,(C)
00001815:       XOR E
00001816:       AND D
00001817:       JR Z,-06h
00001819:       RET

_WIDTH:
0000181A:       CP 23h		;'#'
0000181C:       JR Z,+29h
0000181E:       CP 9Bh
00001820:       JR Z,+44h
00001822:       CALL 11D3h			; EVAL - evaluate expression
00001825:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00001826:       JR NZ,+4Dh			; JP if not string type
00001828:       CALL 468Fh
0000182B:       LD A,D
0000182C:       LD D,00h
0000182E:       CPL
0000182F:       OR A
00001830:       JP M,0B06h			; FCERR, Err $05 - "Illegal function call"
00001833:       LD E,A
00001834:       PUSH DE
00001835:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001836:       DEFB ','
00001837:       CALL 18A3h			; GETINT
0000183A:       POP DE
0000183B:       PUSH AF
0000183C:       PUSH HL
0000183D:       PUSH DE
0000183E:       LD A,E
0000183F:       ADD A
00001840:       LD E,A
00001841:       LD A,14h
00001843:       PUSH AF
00001844:       JP 4E9Eh
00001847:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001848:       CALL 18A3h			; GETINT
0000184B:       OR A
0000184C:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
0000184F:       PUSH AF
; 00001850:   RST 08h = DEFB 0CFh, also used to test the ROM ID
00001850:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001851:       DEFB ','
00001852:       CALL 18A3h			; GETINT
00001855:       POP AF
00001856:       PUSH HL
00001857:       PUSH DE
00001858:       CALL 46F8h			; GETPTR - get i/o channel control block
0000185B:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
0000185E:       LD DE,0005h
00001861:       ADD HL,DE
00001862:       POP DE
00001863:       LD (HL),E
00001864:       POP HL
00001865:       RET

00001866:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001867:       CALL 18A3h			; GETINT
0000186A:       LD (E64Eh),A		; LPTPOS2
0000186D:       LD E,A
0000186E:       CALL 188Bh
00001871:       LD (E64Dh),A
00001874:       RET

00001875:       CP 2Ch		; ','
00001877:       LD A,(E64Fh)		; TTYPOS2
0000187A:       CALL NZ,18A6h			; MAKINT
0000187D:       CALL 7112h
00001880:       LD (E64Fh),A		; TTYPOS2
00001883:       LD E,A
00001884:       CALL 188Bh
00001887:       LD (E650h),A			; CLMLST (Column space)
0000188A:       RET

0000188B:       SUB 0Eh
0000188D:       JR NC,-04h
0000188F:       ADD 1Ch
00001891:       CPL
00001892:       INC A
00001893:       ADD E
00001894:       RET

; FPSINT - Get subscript
00001895:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
; POSINT (aka GETINT)
00001896:       CALL 11D3h						; EVAL - evaluate expression

; DEPINT - Get integer variable to DE, error if negative
00001899:       PUSH HL
0000189A:       CALL 21A0h			; CINT
0000189D:       EX DE,HL
0000189E:       POP HL
0000189F:       LD A,D
000018A0:       OR A
000018A1:       RET

; FNDNUM - Load 'A' with the next number in BASIC program
000018A2:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000018A3:       CALL 11D3h			; EVAL - evaluate expression
; MAKINT
000018A6:       CALL 1899h			; DEPINT - Get integer variable to DE, error if negative
000018A9:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
000018AC:       DEC HL
000018AD:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000018AE:       LD A,E
000018AF:       RET

000018B0:       LD (EAFDh),A		; TEMP - temp. reservation for st.code
000018B3:       LD A,(E69Fh)
000018B6:       OR A
000018B7:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
000018BA:       RET

000018BB:       ADD A
000018BC:       CP FEh
000018BE:       JR NZ,+08h
000018C0:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
000018C3:       AND 20h			; mode at startup
000018C5:       JR NZ,+01h		; JP if BASIC
000018C7:       LD E,A			; terminal mode
000018C8:       LD A,(F153h)
000018CB:       RET

000018CC:       LD A,H
000018CD:       LD (E9E9h),A
000018D0:       JP 7290h
000018D3:       NOP

_LLIST:
000018D4:       LD A,01h
000018D6:       LD (E64Ch),A		; PRTFLG ("printer enabled" flag)
_LIST:
000018D9:       CALL ED3Ch
000018DC:       POP BC
000018DD:       CALL 05E9h				; LNUM_RANGE - Read numeric range function parameters
000018E0:       CALL 44B3h			; use bank pivot (read)
000018E3:       PUSH BC
000018E4:       CALL 1C81h
000018E7:       CALL EDA8h
000018EA:       LD HL,FFFFh
000018ED:       LD (E656h),HL			; CURLIN - line number being interpreted
000018F0:       POP HL
000018F1:       CALL 44A4h			; bank switching pivot (write)
000018F4:       POP DE
000018F5:       CALL 44E3h
000018F8:       JP Z,047Bh			; READY:
000018FB:       LD C,(HL)
000018FC:       INC HL
000018FD:       LD B,(HL)
000018FE:       INC HL
000018FF:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00001902:       CALL Z,5A86h			; ISCNTC - Check the status of the STOP key.
00001905:       PUSH BC
00001906:       LD C,(HL)
00001907:       INC HL
00001908:       LD B,(HL)
00001909:       INC HL
0000190A:       PUSH BC
0000190B:       EX HL,(SP)
0000190C:       EX DE,HL
0000190D:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000190E:       POP BC
0000190F:       JP C,047Ah			; RESTART
00001912:       EX HL,(SP)
00001913:       PUSH HL
00001914:       PUSH BC
00001915:       EX DE,HL
00001916:       LD (E6ABh),HL
00001919:       CALL 28C2h			; _PRNUM - PRINT number pointed by HL
0000191C:       POP HL
0000191D:       LD A,(HL)
0000191E:       CP 09h
00001920:       JR Z,+03h
00001922:       LD A,20h
00001924:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00001925:       CALL 194Ch
00001928:       LD HL,E9B9h
0000192B:       CALL 1933h
0000192E:       CALL 5A69h	; OUTDO_CRLF
00001931:       JR -49h
00001933:       EX DE,HL
00001934:       LD HL,(EFC0h)
00001937:       EX DE,HL
00001938:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00001939:       JR NZ,+08h
0000193B:       PUSH HL
0000193C:       LD HL,(EF86h)		; CSRY (CursorPos) - current text position
0000193F:       LD (EFC2h),HL
00001942:       POP HL
00001943:       LD A,(HL)
00001944:       OR A
00001945:       RET Z
00001946:       CALL 661Ch
00001949:       INC HL
0000194A:       JR -14h
0000194C:       LD BC,E9B9h
0000194F:       LD D,FFh
00001951:       XOR A
00001952:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001955:       XOR A
00001956:       LD (EC21h),A
00001959:       CALL EDA8h
0000195C:       JR +04h
0000195E:       INC BC
0000195F:       INC HL
00001960:       DEC D
00001961:       RET Z
00001962:       PUSH DE
00001963:       EX DE,HL
00001964:       LD HL,(EFBCh)
00001967:       OR A
00001968:       SBC HL,DE
0000196A:       JR NZ,+05h
0000196C:       LD H,B
0000196D:       LD L,C
0000196E:       LD (EFC0h),HL
00001971:       EX DE,HL
00001972:       POP DE
00001973:       LD A,(HL)
00001974:       OR A
00001975:       LD (BC),A
00001976:       RET Z
00001977:       CP 0Bh
00001979:       JR C,+25h
0000197B:       CP 20h		; ' '
0000197D:       LD E,A
0000197E:       JR C,+31h
00001980:       CP 22h		; '"'
00001982:       JR NZ,+0Ah
00001984:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001987:       XOR 01h
00001989:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
0000198C:       LD A,22h
0000198E:       CP 3Ah		; ':'
00001990:       JR NZ,+0Eh
00001992:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001995:       RRA
00001996:       JR C,+06h
00001998:       RLA
00001999:       AND FDh
0000199B:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
0000199E:       LD A,3Ah
000019A0:       OR A
000019A1:       JP M,19D3h
000019A4:       LD E,A
000019A5:       CP 2Eh		; '.'
000019A7:       JR Z,+08h
000019A9:       CALL 1AB4h
000019AC:       JR NC,+03h
000019AE:       XOR A
000019AF:       JR +11h
000019B1:       LD A,(EC21h)
000019B4:       OR A
000019B5:       JR Z,+09h
000019B7:       INC A
000019B8:       JR NZ,+06h
000019BA:       LD A,20h
000019BC:       LD (BC),A
000019BD:       INC BC
000019BE:       DEC D
000019BF:       RET Z
000019C0:       LD A,01h
000019C2:       LD (EC21h),A
000019C5:       LD A,E
000019C6:       CP 0Bh
000019C8:       JR C,+05h
000019CA:       CP 20h		; ' '
000019CC:       JP C,1ABFh
000019CF:       LD (BC),A
000019D0:       JP 195Eh

000019D3:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
000019D6:       RRA
000019D7:       JR C,+2Eh
000019D9:       RRA
000019DA:       RRA
000019DB:       JR NC,+3Eh
000019DD:       LD A,(HL)
000019DE:       CP E9h
000019E0:       PUSH HL
000019E1:       PUSH BC
000019E2:       LD HL,1A04h
000019E5:       PUSH HL
000019E6:       RET NZ
000019E7:       DEC BC
000019E8:       LD A,(BC)
000019E9:       CP 4Dh
000019EB:       RET NZ
000019EC:       DEC BC
000019ED:       LD A,(BC)
000019EE:       CP 45h
000019F0:       RET NZ
000019F1:       DEC BC
000019F2:       LD A,(BC)
000019F3:       CP 52h
000019F5:       RET NZ
000019F6:       DEC BC
000019F7:       LD A,(BC)
000019F8:       CP 3Ah		; ':'
000019FA:       RET NZ
000019FB:       POP AF
000019FC:       POP AF
000019FD:       POP HL
000019FE:       INC D
000019FF:       INC D
00001A00:       INC D
00001A01:       INC D
00001A02:       JR +25h
00001A04:       POP BC
00001A05:       POP HL
00001A06:       LD A,(HL)
00001A07:       JP 195Eh

00001A0A:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001A0D:       OR 02h
00001A0F:       LD (EABEh),A		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001A12:       XOR A
00001A13:       RET

00001A14:       LD A,(EABEh)		; DORES/OPRTYP - Indicates whether stored word can be crunched / temp operator type storage
00001A17:       OR 04h
00001A19:       JR -0Ch
00001A1B:       RLA
00001A1C:       JR C,-17h
00001A1E:       LD A,(HL)
00001A1F:       CP 84h
00001A21:       CALL Z,1A0Ah
00001A24:       CP 8Fh
00001A26:       CALL Z,1A14h
00001A29:       LD A,(HL)
00001A2A:       INC A
00001A2B:       LD A,(HL)
00001A2C:       JR NZ,+04h
00001A2E:       INC HL
00001A2F:       LD A,(HL)
00001A30:       AND 7Fh
00001A32:       INC HL
00001A33:       CP 9Fh
00001A35:       CALL Z,2284h
00001A38:       CP AFh				; TK_WHILE ?
00001A3A:       JR NZ,+09h
00001A3C:       LD A,(HL)
00001A3D:       INC HL
00001A3E:       CP F3h
00001A40:       LD A,AFh
00001A42:       JR Z,+01h
00001A44:       DEC HL
00001A45:       PUSH HL
00001A46:       PUSH BC
00001A47:       PUSH DE
00001A48:       CALL ED1Bh
00001A4B:       LD HL,6B89h
00001A4E:       LD B,A
00001A4F:       LD C,40h
00001A51:       INC C
00001A52:       INC HL
00001A53:       LD D,H
00001A54:       LD E,L
00001A55:       LD A,(HL)
00001A56:       OR A
00001A57:       JR Z,-08h
00001A59:       INC HL
00001A5A:       JP P,1A55h
00001A5D:       LD A,(HL)
00001A5E:       CP B
00001A5F:       JR NZ,-0Fh
00001A61:       EX DE,HL
00001A62:       CP E0h
00001A64:       JR Z,+02h
00001A66:       CP E1h		; TK_FN
00001A68:       LD A,C
00001A69:       POP DE
00001A6A:       POP BC
00001A6B:       LD E,A
00001A6C:       JR NZ,+0Bh
00001A6E:       LD A,(EC21h)
00001A71:       OR A
00001A72:       LD A,00h
00001A74:       LD (EC21h),A
00001A77:       JR +13h
00001A79:       CP 5Bh		; '['
00001A7B:       JR NZ,+06h
00001A7D:       XOR A
00001A7E:       LD (EC21h),A
00001A81:       JR +16h
00001A83:       LD A,(EC21h)
00001A86:       OR A
00001A87:       LD A,FFh
00001A89:       LD (EC21h),A
00001A8C:       JR Z,+08h
00001A8E:       LD A,20h
00001A90:       LD (BC),A
00001A91:       INC BC
00001A92:       DEC D
00001A93:       JP Z,558Bh
00001A96:       LD A,E
00001A97:       JR +03h
00001A99:       LD A,(HL)
00001A9A:       INC HL
00001A9B:       LD E,A
00001A9C:       AND 7Fh
00001A9E:       LD (BC),A
00001A9F:       INC BC
00001AA0:       DEC D
00001AA1:       JP Z,558Bh
00001AA4:       OR E
00001AA5:       JP P,1A99h
00001AA8:       CP A8h
00001AAA:       JR NZ,+04h
00001AAC:       XOR A
00001AAD:       LD (EC21h),A
00001AB0:       POP HL
00001AB1:       JP 1962h

00001AB4:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00001AB7:       RET NC
00001AB8:       CP 30h
00001ABA:       RET C
00001ABB:       CP 3Ah		; ':'
00001ABD:       CCF
00001ABE:       RET
00001ABF:       DEC HL
00001AC0:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001AC1:       PUSH DE
00001AC2:       PUSH BC
00001AC3:       PUSH AF
00001AC4:       CALL 0A8Dh
00001AC7:       POP AF
00001AC8:       LD BC,1ADCh
00001ACB:       PUSH BC
00001ACC:       CP 0Bh
00001ACE:       JP Z,2DBCh
00001AD1:       CP 0Ch
00001AD3:       JP Z,2DBFh
00001AD6:       LD HL,(EAC4h)		; CONLO - Value of stored constant
00001AD9:       JP 28D0h				; FOUT Convert number/expression to string (format not specified)

00001ADC:       POP BC
00001ADD:       POP DE
00001ADE:       LD A,(EAC2h)			; CONSAV
00001AE1:       LD E,4Fh
00001AE3:       CP 0Bh
00001AE5:       JR Z,+06h
00001AE7:       CP 0Ch
00001AE9:       LD E,48h
00001AEB:       JR NZ,+0Bh
00001AED:       LD A,26h
00001AEF:       LD (BC),A
00001AF0:       INC BC
00001AF1:       DEC D
00001AF2:       RET Z
00001AF3:       LD A,E
00001AF4:       LD (BC),A
00001AF5:       INC BC
00001AF6:       DEC D
00001AF7:       RET Z
00001AF8:       LD A,(EAC3h)			; CONTYP - Type of stored constant
00001AFB:       CP 04h
00001AFD:       LD E,00h
00001AFF:       JR C,+06h
00001B01:       LD E,21h
00001B03:       JR Z,+02h
00001B05:       LD E,23h
00001B07:       LD A,(HL)
00001B08:       CP 20h		; ' '
00001B0A:       CALL Z,20F2h			; INCHL  (INC HL, RET)
00001B0D:       LD A,(HL)
00001B0E:       INC HL
00001B0F:       OR A
00001B10:       JR Z,+20h
00001B12:       LD (BC),A
00001B13:       INC BC
00001B14:       DEC D
00001B15:       RET Z
00001B16:       LD A,(EAC3h)			; CONTYP - Type of stored constant
00001B19:       CP 04h
00001B1B:       JR C,-10h
00001B1D:       DEC BC
00001B1E:       LD A,(BC)
00001B1F:       INC BC
00001B20:       JR NZ,+04h
00001B22:       CP 2Eh		; '.'
00001B24:       JR Z,+08h
00001B26:       CP 44h
00001B28:       JR Z,+04h
00001B2A:       CP 45h
00001B2C:       JR NZ,-21h
00001B2E:       LD E,00h
00001B30:       JR -25h
00001B32:       LD A,E
00001B33:       OR A
00001B34:       JR Z,+04h
00001B36:       LD (BC),A
00001B37:       INC BC
00001B38:       DEC D
00001B39:       RET Z
00001B3A:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00001B3D:       JP 1962h

_DELETE:
00001B40:       CALL 05E9h				; LNUM_RANGE - Read numeric range function parameters
00001B43:       CALL 44B3h			; use bank pivot (read)
00001B46:       PUSH BC
00001B47:       CALL 1C81h
00001B4A:       POP BC
00001B4B:       POP DE
00001B4C:       PUSH BC
00001B4D:       PUSH BC
00001B4E:       CALL 0605h			; SRCHLN  -  Get first line number
00001B51:       JR NC,+08h
00001B53:       CALL 44D5h			; bank switching pivot (read)
00001B56:       LD D,H
00001B57:       LD E,L
00001B58:       EX HL,(SP)
00001B59:       PUSH HL
00001B5A:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00001B5B:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
00001B5E:       LD HL,031Ah			; "Ok"
00001B61:       CALL 5550h			; PRS - Print message pointed by HL
00001B64:       POP BC
00001B65:       LD HL,05A1h
00001B68:       EX HL,(SP)
00001B69:       JP 452Ch

00001B6C:       EX DE,HL
00001B6D:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00001B70:       LD A,(DE)
00001B71:       LD (BC),A
00001B72:       INC BC
00001B73:       INC DE
00001B74:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00001B75:       JR NZ,-07h
00001B77:       LD H,B
00001B78:       LD L,C
00001B79:       RET

_PEEK:
00001B7A:       CALL 1B9Dh			; GETWORD_HL
00001B7D:       CALL ED9Fh
00001B80:       LD A,(HL)
00001B81:       JP 1589h			; UNSIGNED_RESULT_A

_POKE:
00001B84:       CALL 1B93h			; GETWORD
00001B87:       PUSH DE
00001B88:       CALL ED9Fh
00001B8B:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001B8C:       DEFB ','
00001B8D:       CALL 18A3h			; GETINT
00001B90:       POP DE
00001B91:       LD (DE),A
00001B92:       RET

; GETWORD
00001B93:       CALL 11D3h			; EVAL - evaluate expression
00001B96:       PUSH HL
00001B97:       CALL 1B9Dh			; GETWORD_HL
00001B9A:       EX DE,HL
00001B9B:       POP HL
00001B9C:       RET

; GETWORD_HL
00001B9D:       LD BC,21A0h			; CINT
00001BA0:       PUSH BC
00001BA1:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00001BA2:       RET M
00001BA3:       CALL ED39h
00001BA6:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00001BA9:       CP 90h			; 
00001BAB:       RET NZ
00001BAC:       RST 28h				; SIGN - test FP number sign
00001BAD:       RET M
00001BAE:       CALL 2214h			; CSNG - Convert number to single precision
00001BB1:       LD BC,9180h
00001BB4:       LD DE,0000h
00001BB7:       JP 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)

; SCCLIN:
00001BBA:       DEFB $F6            ;  'OR $AF'  masking the next instruction

; SCCPTR:
00001BBB:       XOR A
00001BBC:       LD (EAFFh),A		; PTRFLG
00001BBF:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00001BC2:       CALL 44A4h			; bank switching pivot (write)
00001BC5:       DEC HL
00001BC6:       INC HL
00001BC7:       CALL 44D5h			; bank switching pivot (read)
00001BCA:       CALL 44A4h			; bank switching pivot (write)
00001BCD:       LD A,(HL)
00001BCE:       INC HL
00001BCF:       OR (HL)
00001BD0:       RET Z
00001BD1:       INC HL
00001BD2:       LD E,(HL)
00001BD3:       INC HL
00001BD4:       LD D,(HL)

; SCNEXT:
00001BD5:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.

; LINE2PTR
00001BD6:       OR A
00001BD7:       JR Z,-13h
00001BD9:       LD C,A
00001BDA:       LD A,(EAFFh)	; PTRFLG
00001BDD:       OR A
00001BDE:       LD A,C
00001BDF:       JR Z,+68h
00001BE1:       CALL ED81h
00001BE4:       CP A5h			; TK_ERROR
00001BE6:       JR NZ,+14h      ; no, NTERRG
00001BE8:       RST 10h			; CHRGTB - yes, SCAN NEXT CHAR
00001BE9:       CP 89h			; TK_GOTO  ;ERROR GOTO?
00001BEB:       JR NZ,-17h		; LINE2PTR ;GET NEXT ONE
00001BED:       RST 10h			; CHRGTB - ;GET NEXT CHAR
; NTERRG
00001BEE:       CP 0Eh			; Line number prefix (LINCON):  LINE # CONSTANT?
00001BF0:       JR NZ,-1Ch		; SCNEXT - NOT, KEEP SCANNING
00001BF2:       PUSH DE         ;SAVE CURRENT LINE # FOR POSSIBLE ERROR MSG
00001BF3:       CALL 0B4Fh      ; LINGT3 GET LINE # OF LINE CONSTANT INTO [D,E]
00001BF6:       LD A,D
00001BF7:       OR E
00001BF8:       JR NZ,+0Ah
00001BFA:       JR +39h
00001BFC:       CP 0Eh				; TK_ATN ?  ..end of logical line ?
00001BFE:       JR NZ,-2Bh
00001C00:       PUSH DE
00001C01:       CALL 0B4Fh      ; LINGT3
; CHGPTR
00001C04:       CALL 44D5h			; bank switching pivot (read)
00001C07:       PUSH HL
00001C08:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00001C0B:       CALL 44D5h			; bank switching pivot (read)
00001C0E:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00001C11:       CALL 0605h			; SRCHLN  -  Get first line number
00001C14:       DEC BC
00001C15:       CALL 44B3h			; use bank pivot (read)
00001C18:       LD A,0Dh
00001C1A:       JR C,+4Eh
00001C1C:       CALL 5A58h			; CONSOLE_CRLF
00001C1F:       LD HL,1C39h			; LINE_ERR_MSG, "Undefined line ..."
00001C22:       PUSH DE
00001C23:       CALL 5550h			; PRS - Print message pointed by HL
00001C26:       POP HL
00001C27:       CALL 28C2h			; _PRNUM - PRINT number pointed by HL
00001C2A:       POP BC
00001C2B:       POP HL
00001C2C:       PUSH HL
00001C2D:       PUSH BC
00001C2E:       CALL 28BAh	; LNUM_MSG - Finalize (error) message by printing the current line number
00001C31:       POP HL
00001C32:       CALL 44A4h			; bank switching pivot (write)
00001C35:       POP DE
00001C36:       DEC HL
00001C37:       JR -64h

00001C39:       DEFM "Undefined line "
				NOP

00001C49:       CP 0Dh
00001C4B:       JR NZ,-16h
00001C4D:       PUSH DE
00001C4E:       CALL 0B4Fh          ; LINGT3
00001C51:       CALL 44D5h			; bank switching pivot (read)
00001C54:       PUSH HL
00001C55:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00001C58:       CALL 44D5h			; bank switching pivot (read)
00001C5B:       LD (EAC0h),HL			; CONTXT - ptr to console buffer
00001C5E:       EX DE,HL
00001C5F:       CALL 44A4h			; bank switching pivot (write)
00001C62:       INC HL
00001C63:       INC HL
00001C64:       INC HL
00001C65:       LD C,(HL)
00001C66:       INC HL
00001C67:       LD B,(HL)
00001C68:       LD A,0Eh
00001C6A:       LD HL,1C31h
00001C6D:       PUSH HL
00001C6E:       LD HL,(EAC0h)			; CONTXT - ptr to console buffer
00001C71:       PUSH HL
00001C72:       DEC HL
00001C73:       DEC HL
00001C74:       DEC HL
00001C75:       CALL 44A4h			; bank switching pivot (write)
00001C78:       INC HL
00001C79:       INC HL
00001C7A:       LD (HL),B
00001C7B:       DEC HL
00001C7C:       LD (HL),C
00001C7D:       DEC HL
00001C7E:       LD (HL),A
00001C7F:       POP HL
00001C80:       RET

DEPTR:
00001C81:       LD A,(EAFFh)		; PTRFLG
00001C84:       OR A
00001C85:       RET Z
00001C86:       JP 1BBBh            ; SCCPTR

_OPTION:
00001C89:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001C8A:       DEFB 'B'
00001C8B:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001C8C:       DEFB 'A'
00001C8D:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001C8E:       DEFB 'S'
00001C8F:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001C90:       DEFB 'E'
00001C91:       LD A,(EC20h)
00001C94:       OR A
00001C95:       JP NZ,03A2h			;  "Duplicate definition" error
00001C98:       PUSH HL
00001C99:       LD HL,(EB1Dh)	; VAREND - End of variables
00001C9C:       EX DE,HL
00001C9D:       LD HL,(EB1Fh)	; ARREND - End of arrays
00001CA0:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00001CA1:       JP NZ,03A2h			;  "Duplicate definition" error
00001CA4:       POP HL
00001CA5:       LD A,(HL)
00001CA6:       SUB 30h
00001CA8:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
00001CAB:       CP 02h
00001CAD:       JP NC,0393h			;  SNERR - entry for '?SN ERROR'
00001CB0:       LD (EC1Fh),A
00001CB3:       INC A
00001CB4:       LD (EC20h),A
00001CB7:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001CB8:       RET

00001CB9:       INA (71h)			; save Extended ROM bank status
00001CBB:       PUSH AF
00001CBC:       LD A,FFh				; back to main ROM
00001CBE:       OUTA (71h)				; Extended ROM bank switching
00001CC0:       LD A,(HL)
00001CC1:       CALL 1CCDh			; display
00001CC4:       INC HL
00001CC5:       LD A,(HL)
00001CC6:       CALL 1CCDh			; display
00001CC9:       POP AF
00001CCA:       OUTA (71h)			; restore Extended ROM bank status
00001CCC:       RET

; display
00001CCD:       PUSH AF
00001CCE:       JP 59A5h			; display sub

_RANDOMIZE:
00001CD1:       JR Z,+09h
00001CD3:       CALL 11D3h			; EVAL - evaluate expression
00001CD6:       PUSH HL
00001CD7:       CALL 21A0h			; CINT
00001CDA:       JR +1Bh
00001CDC:       PUSH HL
00001CDD:       LD HL,1CFFh			; "Random number seed.." message
00001CE0:       CALL 5550h			; PRS - Print message pointed by HL
00001CE3:       CALL 5FC2h
00001CE6:       POP DE
00001CE7:       JP C,50F8h
00001CEA:       PUSH DE
00001CEB:       INC HL
00001CEC:       LD A,(HL)
00001CED:       CALL 26BCh		; DBL_ASCTFP (a.k.a. FIN)
00001CF0:       LD A,(HL)
00001CF1:       OR A
00001CF2:       JR NZ,-17h
00001CF4:       CALL 21A0h			; CINT
00001CF7:       LD (E632h),HL
00001CFA:       CALL 2F0Ch
00001CFD:       POP HL
00001CFE:       RET

00001CFF:		DEFS "Random number seed (-32768 to 32767)
00001D23:       NOP

00001D24:       LD C,1Eh
00001D26:       JR +02h
00001D28:       LD C,1Ah
00001D2A:       LD B,00h
00001D2C:       EX DE,HL
00001D2D:       LD HL,(E656h)			; CURLIN - line number being interpreted
00001D30:       LD (EC1Dh),HL
00001D33:       EX DE,HL
00001D34:       INC B
00001D35:       DEC HL
00001D36:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001D37:       JR Z,+14h
00001D39:       CP 22h		; '"'
00001D3B:       JR NZ,+08h
00001D3D:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001D3E:       OR A
00001D3F:       JR Z,+0Ch
00001D41:       CP 22h		; '"'
00001D43:       JR NZ,-08h
00001D45:       CP 9Fh
00001D47:       JR Z,+1Eh
00001D49:       CP DDh			; TK_THEN
00001D4B:       JR NZ,-17h
00001D4D:       OR A
00001D4E:       JR NZ,+17h
00001D50:       INC HL
00001D51:       LD A,(HL)
00001D52:       INC HL
00001D53:       OR (HL)
00001D54:       LD E,C
00001D55:       JP Z,03B3h				; ERROR, code in E
00001D58:       INC HL
00001D59:       LD E,(HL)
00001D5A:       INC HL
00001D5B:       LD D,(HL)
00001D5C:       EX DE,HL
00001D5D:       LD (EC1Dh),HL
00001D60:       EX DE,HL
00001D61:       CALL 44D5h			; bank switching pivot (read)
00001D64:       CALL 44A4h			; bank switching pivot (write)
00001D67:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001D68:       CP F5h
00001D6A:       JR NZ,+07h
00001D6C:       PUSH BC
00001D6D:       CALL 5480h
00001D70:       POP BC
00001D71:       DEC HL
00001D72:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001D73:       CP 8Fh
00001D75:       JR NZ,+07h
00001D77:       PUSH BC
00001D78:       CALL 0C79h			; _REM (skip current line being interpreted)
00001D7B:       POP BC
00001D7C:       JR -31h
00001D7E:       CP 84h
00001D80:       JR NZ,+07h
00001D82:       PUSH BC
00001D83:       CALL 0C77h			; _DATA (nothing to be executed, skip to next line)
00001D86:       POP BC
00001D87:       JR -3Ch
00001D89:       LD A,C
00001D8A:       CP 1Ah
00001D8C:       LD A,(HL)
00001D8D:       JR Z,+0Bh
00001D8F:       CP AFh				; TK_WHILE ?
00001D91:       JR Z,-5Fh
00001D93:       CP B0h
00001D95:       JR NZ,-62h
00001D97:       DJNZ -64h
00001D99:       RET

00001D9A:       CP 82h				; TK_FOR - Token for FOR
00001D9C:       JR Z,-6Ah
00001D9E:       CP 83h
00001DA0:       JR NZ,-6Dh
00001DA2:       DEC B
00001DA3:       RET Z
00001DA4:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001DA5:       JR Z,-5Ah
00001DA7:       EX DE,HL
00001DA8:       LD HL,(E656h)			; CURLIN - line number being interpreted
00001DAB:       PUSH HL
00001DAC:       LD HL,(EC1Dh)
00001DAF:       LD (E656h),HL			; CURLIN - line number being interpreted
00001DB2:       EX DE,HL
00001DB3:       PUSH BC
00001DB4:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00001DB7:       POP BC
00001DB8:       DEC HL
00001DB9:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00001DBA:       LD DE,1D4Dh
00001DBD:       JR Z,+06h
00001DBF:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00001DC0:       DEFB ','
00001DC1:       DEC HL
00001DC2:       LD DE,1DA2h
00001DC5:       EX HL,(SP)
00001DC6:       LD (E656h),HL			; CURLIN - line number being interpreted
00001DC9:       POP HL
00001DCA:       PUSH DE
00001DCB:       RET
00001DCC:       PUSH AF
00001DCD:       LD A,(EC46h)
00001DD0:       LD (EC47h),A
00001DD3:       POP AF

00001DD4:       PUSH AF
00001DD5:       XOR A
00001DD6:       LD (EC46h),A
00001DD9:       POP AF
00001DDA:       RET

00001DDB:       LD HL,2D5Ah			; number constant ..

00001DDE:       CALL 20EBh			; LOADFP - Load FP value pointed by HL to BCDE
00001DE1:       JR +06h

00001DE3:       CALL 20EBh			; LOADFP - Load FP value pointed by HL to BCDE

; SUBCDE - Subtract BCDE from FP reg (a.k.a. FSUB)
00001DE6:       CALL 20ABh			; INVSGN - Invert number sign
; FPADD - Add BCDE to FP reg (a.k.a. FADD)
00001DE9:       LD A,B
00001DEA:       OR A
00001DEB:       RET Z
00001DEC:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00001DEF:       OR A
00001DF0:       JP Z,20DDh			; FPBCDE - Move BCDE to FPREG
00001DF3:       SUB B
00001DF4:       CALL EDB4h
00001DF7:       JR NC,+0Ch
00001DF9:       CPL
00001DFA:       INC A
00001DFB:       EX DE,HL
00001DFC:       CALL 20CDh			; STAKFP - Put FP value on stack
00001DFF:       EX DE,HL
00001E00:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
00001E03:       POP BC
00001E04:       POP DE
00001E05:       CP 19h
00001E07:       RET NC
00001E08:       PUSH AF
00001E09:       CALL 2107h
00001E0C:       LD H,A
00001E0D:       POP AF
00001E0E:       CALL 1EBBh			; SCALE - Scale number in BCDE for A exponent (bits)
00001E11:       LD A,H
00001E12:       OR A
00001E13:       LD HL,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00001E16:       JP P,1E2Ah
00001E19:       CALL 1E9Bh			; PLUCDE - Add number pointed by HL to CDE
00001E1C:       JR NC,+5Eh
00001E1E:       INC HL
00001E1F:       INC (HL)
00001E20:       JP Z,283Ch
00001E23:       LD L,01h
00001E25:       CALL 1EDDh
00001E28:       JR +52h
00001E2A:       XOR A
00001E2B:       SUB B
00001E2C:       LD B,A
00001E2D:       LD A,(HL)
00001E2E:       SBC E
00001E2F:       LD E,A
00001E30:       INC HL
00001E31:       LD A,(HL)
00001E32:       SBC D
00001E33:       LD D,A
00001E34:       INC HL
00001E35:       LD A,(HL)
00001E36:       SBC C
00001E37:       LD C,A
00001E38:       CALL C,1EA7h		; COMPL - Convert a negative number to positive
00001E3B:       LD L,B
00001E3C:       LD H,E
00001E3D:       XOR A
00001E3E:       LD B,A
00001E3F:       LD A,C
00001E40:       OR A
00001E41:       JR NZ,+27h
00001E43:       LD C,D
00001E44:       LD D,H
00001E45:       LD H,L
00001E46:       LD L,A
00001E47:       LD A,B
00001E48:       SUB 08h
00001E4A:       CP E0h
00001E4C:       JR NZ,-10h
00001E4E:       XOR A
00001E4F:       LD (EC44h),A		; FPEXP - Floating Point Exponent
00001E52:       RET

00001E53:       LD A,H
00001E54:       OR L
00001E55:       OR D
00001E56:       JR NZ,+0Ah
00001E58:       LD A,C
00001E59:       DEC B
00001E5A:       RLA
00001E5B:       JR NC,-04h
00001E5D:       INC B
00001E5E:       RRA
00001E5F:       LD C,A
00001E60:       JR +0Bh
00001E62:       DEC B
00001E63:       ADD HL,HL
00001E64:       LD A,D
00001E65:       RLA
00001E66:       LD D,A
00001E67:       LD A,C
00001E68:       ADC A
00001E69:       LD C,A
00001E6A:       JP P,1E53h
00001E6D:       LD A,B
00001E6E:       LD E,H
00001E6F:       LD B,L
00001E70:       OR A
00001E71:       JR Z,+09h
00001E73:       LD HL,EC44h		; FPEXP - Floating Point Exponent
00001E76:       ADD (HL)
00001E77:       LD (HL),A
00001E78:       JR NC,-2Ch
00001E7A:       JR Z,-2Eh

; continued from CSNG - Convert number to single precision
00001E7C:       LD A,B
00001E7D:       LD HL,EC44h		; FPEXP - Floating Point Exponent
00001E80:       OR A
00001E81:       CALL M,1E8Eh
00001E84:       LD B,(HL)
00001E85:       INC HL
00001E86:       LD A,(HL)
00001E87:       AND 80h
00001E89:       XOR C
00001E8A:       LD C,A
00001E8B:       JP 20DDh			; FPBCDE - Move BCDE to FPREG

00001E8E:       INC E
00001E8F:       RET NZ
00001E90:       INC D
00001E91:       RET NZ
00001E92:       INC C
00001E93:       RET NZ
00001E94:       LD C,80h
00001E96:       INC (HL)
00001E97:       RET NZ
00001E98:       JP 283Bh

; PLUCDE - Add number pointed by HL to CDE
00001E9B:       LD A,(HL)
00001E9C:       ADD E
00001E9D:       LD E,A
00001E9E:       INC HL
00001E9F:       LD A,(HL)
00001EA0:       ADC D
00001EA1:       LD D,A
00001EA2:       INC HL
00001EA3:       LD A,(HL)
00001EA4:       ADC C
00001EA5:       LD C,A
00001EA6:       RET

; COMPL - Convert a negative number to positive
00001EA7:       LD HL,EC45h		; SGNRES - Sign of result
00001EAA:       LD A,(HL)
00001EAB:       CPL
00001EAC:       LD (HL),A
00001EAD:       XOR A
00001EAE:       LD L,A
00001EAF:       SUB B
00001EB0:       LD B,A
00001EB1:       LD A,L
00001EB2:       SBC E
00001EB3:       LD E,A
00001EB4:       LD A,L
00001EB5:       SBC D
00001EB6:       LD D,A
00001EB7:       LD A,L
00001EB8:       SBC C
00001EB9:       LD C,A
00001EBA:       RET

; SCALE - Scale number in BCDE for A exponent (bits)
00001EBB:       LD B,00h
00001EBD:       SUB 08h
00001EBF:       JR C,+07h
00001EC1:       LD B,E
00001EC2:       LD E,D
00001EC3:       LD D,C
00001EC4:       LD C,00h
00001EC6:       JR -0Bh


00001EC8:       ADD 09h
00001ECA:       LD L,A
00001ECB:       LD A,D
00001ECC:       OR E
00001ECD:       OR B
00001ECE:       JR NZ,+09h
00001ED0:       LD A,C
00001ED1:       DEC L
00001ED2:       RET Z
00001ED3:       RRA
00001ED4:       LD C,A
00001ED5:       JR NC,-06h
00001ED7:       JR +06h
00001ED9:       XOR A
00001EDA:       DEC L
00001EDB:       RET Z
00001EDC:       LD A,C
00001EDD:       RRA
00001EDE:       LD C,A
00001EDF:       LD A,D
00001EE0:       RRA
00001EE1:       LD D,A
00001EE2:       LD A,E
00001EE3:       RRA
00001EE4:       LD E,A
00001EE5:       LD A,B
00001EE6:       RRA
00001EE7:       LD B,A
00001EE8:       JR -11h
00001EEA:       NOP
00001EEB:       NOP
00001EEC:       NOP
00001EED:       ADD C
00001EEE:       INC B
00001EEF:       SBC D
00001EF0:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00001EF1:       ADD HL,DE
00001EF2:       ADD E
00001EF3:       INC H
00001EF4:       LD H,E
00001EF5:       LD B,E
00001EF6:       ADD E
00001EF7:       LD (HL),L
00001EF8:       CALL 848Dh
00001EFB:       XOR C
00001EFC:       LD A,A
00001EFD:       ADD E
00001EFE:       ADD D
00001EFF:       INC B
00001F00:       NOP
00001F01:       NOP
00001F02:       NOP
00001F03:       ADD C
00001F04:       JP PO,4DB0h
00001F07:       ADD E
00001F08:       LD A,(BC)
00001F09:       LD (HL),D
00001F0A:       LD DE,F483h
00001F0D:       INC B
00001F0E:       DEC (HL)
00001F0F:       LD A,A
00001F10:       RST 28h				; SIGN - test FP number sign
00001F11:       OR A
00001F12:       JP PE,0B06h			; FCERR, Err $05 - "Illegal function call"
00001F15:       CALL 1F20h
00001F18:       LD BC,8031h
00001F1B:       LD DE,7218h
00001F1E:       JR +33h
00001F20:       CALL 20E8h				; BCDEFP - Load FP reg to BCDE
00001F23:       LD A,80h
00001F25:       LD (EC44h),A		; FPEXP - Floating Point Exponent
00001F28:       XOR B
00001F29:       PUSH AF
00001F2A:       CALL 20CDh			; STAKFP - Put FP value on stack
00001F2D:       LD HL,1EEEh
00001F30:       CALL 2EE7h
00001F33:       POP BC
00001F34:       POP HL
00001F35:       CALL 20CDh			; STAKFP - Put FP value on stack
00001F38:       EX DE,HL
00001F39:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
00001F3C:       LD HL,1EFFh
00001F3F:       CALL 2EE7h
00001F42:       POP BC
00001F43:       POP DE
00001F44:       CALL 1FB7h			; FDIV - FP reg division
00001F47:       POP AF
00001F48:       CALL 20CDh			; STAKFP - Put FP value on stack
00001F4B:       CALL 208Dh			; FLGREL - CY and A to FP, & normalise
00001F4E:       POP BC
00001F4F:       POP DE
00001F50:       JP 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)

; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
00001F53:       RST 28h				; SIGN - test FP number sign
00001F54:       RET Z
00001F55:       CALL EDBAh
00001F58:       LD L,00h
00001F5A:       CALL 2044h
00001F5D:       LD A,C
00001F5E:       LD (EC7Ah),A
00001F61:       EX DE,HL
00001F62:       LD (EC7Bh),HL
00001F65:       LD BC,0000h
00001F68:       LD D,B
00001F69:       LD E,B
00001F6A:       LD HL,1E3Bh
00001F6D:       PUSH HL
00001F6E:       LD HL,1F76h
00001F71:       PUSH HL
00001F72:       PUSH HL
00001F73:       LD HL,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00001F76:       LD A,(HL)
00001F77:       INC HL
00001F78:       OR A
00001F79:       JR Z,+2Ch
00001F7B:       PUSH HL
00001F7C:       LD L,08h
00001F7E:       RRA
00001F7F:       LD H,A
00001F80:       LD A,C
00001F81:       JR NC,+0Bh
00001F83:       PUSH HL
00001F84:       LD HL,(EC7Bh)
00001F87:       ADD HL,DE
00001F88:       EX DE,HL
00001F89:       POP HL
00001F8A:       LD A,(EC7Ah)
00001F8D:       ADC C
00001F8E:       RRA
00001F8F:       LD C,A
00001F90:       LD A,D
00001F91:       RRA
00001F92:       LD D,A
00001F93:       LD A,E
00001F94:       RRA
00001F95:       LD E,A
00001F96:       LD A,B
00001F97:       RRA
00001F98:       LD B,A
00001F99:       AND 10h
00001F9B:       JR Z,+04h
00001F9D:       LD A,B
00001F9E:       OR 20h
00001FA0:       LD B,A
00001FA1:       DEC L
00001FA2:       LD A,H
00001FA3:       JR NZ,-27h
; POPHLRT - (POP HL / RET)
00001FA5:       POP HL
00001FA6:       RET

00001FA7:       LD B,E
00001FA8:       LD E,D
00001FA9:       LD D,C
00001FAA:       LD C,A
00001FAB:       RET

00001FAC:       CALL 20CDh			; STAKFP - Put FP value on stack
00001FAF:       LD HL,2599h
00001FB2:       CALL 20DAh			; PHLTFP - Number at HL to BCDE

; DIV - Divide FP by number on stack
00001FB5:       POP BC
00001FB6:       POP DE
; FDIV - FP reg division
00001FB7:       RST 28h				; SIGN - test FP number sign
00001FB8:       JP Z,2843h
00001FBB:       CALL EDC0h
00001FBE:       LD L,FFh
00001FC0:       CALL 2044h
00001FC3:       INC (HL)
00001FC4:       JP Z,2820h
00001FC7:       INC (HL)
00001FC8:       JP Z,2820h
00001FCB:       DEC HL
00001FCC:       LD A,(HL)
00001FCD:       LD (E609h),A
00001FD0:       DEC HL
00001FD1:       LD A,(HL)
00001FD2:       LD (E605h),A
00001FD5:       DEC HL
00001FD6:       LD A,(HL)
00001FD7:       LD (E601h),A
00001FDA:       LD B,C
00001FDB:       EX DE,HL
00001FDC:       XOR A
00001FDD:       LD C,A
00001FDE:       LD D,A
00001FDF:       LD E,A
00001FE0:       LD (E60Ch),A
00001FE3:       PUSH HL
00001FE4:       PUSH BC
00001FE5:       LD A,L
00001FE6:       CALL E600h
00001FE9:       SBC 00h
00001FEB:       CCF
00001FEC:       JR NC,+07h
00001FEE:       LD (E60Ch),A
00001FF1:       POP AF
00001FF2:       POP AF
00001FF3:       SCF
00001FF4:       JP NC,E1C1h
00001FF7:       LD A,C
00001FF8:       INC A
00001FF9:       DEC A
00001FFA:       RRA
00001FFB:       JP P,2012h
00001FFE:       RLA
00001FFF:       LD A,(E60Ch)
00002002:       RRA
00002003:       AND C0h
00002005:       PUSH AF
00002006:       LD A,B
00002007:       OR H
00002008:       OR L
00002009:       JR Z,+02h
0000200B:       LD A,20h
0000200D:       POP HL
0000200E:       OR H
0000200F:       JP 1E7Dh
00002012:       RLA
00002013:       LD A,E
00002014:       RLA
00002015:       LD E,A
00002016:       LD A,D
00002017:       RLA
00002018:       LD D,A
00002019:       LD A,C
0000201A:       RLA
0000201B:       LD C,A
0000201C:       ADD HL,HL
0000201D:       LD A,B
0000201E:       RLA
0000201F:       LD B,A
00002020:       LD A,(E60Ch)
00002023:       RLA
00002024:       LD (E60Ch),A
00002027:       LD A,C
00002028:       OR D
00002029:       OR E
0000202A:       JR NZ,-49h
0000202C:       PUSH HL
0000202D:       LD HL,EC44h		; FPEXP - Floating Point Exponent
00002030:       DEC (HL)
00002031:       POP HL
00002032:       JR NZ,-51h
00002034:       JP 1E4Eh
00002037:       LD A,FFh
00002039:       LD L,AFh
0000203B:       LD HL,EC50h		; DBL_LAST_FPREG - Last byte in Double Precision FP register (+sign bit)
0000203E:       LD C,(HL)
0000203F:       INC HL
00002040:       XOR (HL)
00002041:       LD B,A
00002042:       LD L,00h
00002044:       LD A,B
00002045:       OR A
00002046:       JR Z,+1Dh
00002048:       LD A,L
00002049:       LD HL,EC44h		; FPEXP - Floating Point Exponent
0000204C:       XOR (HL)
0000204D:       ADD B
0000204E:       LD B,A
0000204F:       RRA
00002050:       XOR B
00002051:       LD A,B
00002052:       JP P,2064h
00002055:       ADD 80h
00002057:       LD (HL),A
00002058:       JP Z,1FA5h			; POPHLRT - (POP HL / RET)
0000205B:       CALL 2107h
0000205E:       LD (HL),A
0000205F:       DEC HL
00002060:       RET

00002061:       RST 28h				; SIGN - test FP number sign
00002062:       CPL
00002063:       POP HL
00002064:       OR A
00002065:       POP HL
00002066:       JP P,1E4Eh
00002069:       JP 2820h

; MLSP10 - Multiply number in FPREG by 10
0000206C:       CALL 20E8h				; BCDEFP - Load FP reg to BCDE
0000206F:       LD A,B
00002070:       OR A
00002071:       RET Z
00002072:       ADD 02h
00002074:       JP C,2835h
00002077:       LD B,A
00002078:       CALL 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)
0000207B:       LD HL,EC44h			; FPEXP - Floating Point Exponent
0000207E:       INC (HL)
0000207F:       RET NZ
00002080:       JP 2835h

00002083:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002086:       DEFB $FE             ; CP 2Fh ..hides the "CPL" instruction      ;"CPI" AROUND NEXT BYTE

FCOMPS:
00002087:       CPL 
  
ICOMPS:
00002088:       RLA             ; Invert sign         ;ENTRY FROM FCOMP, COMPLEMENT SIGN

SIGNS:
00002089:       SBC A           ; Carry to all bits of A      ;A=0 IF CARRY WAS 0, A=377 IF CARRY WAS 1
0000208A:       RET NZ          ; Return -1 if negative       ;RETURN IF NUMBER WAS NEGATIVE
0000208B:       INC A           ; Bump to +1                  ;PUT ONE IN A IF NUMBER WAS POSITIVE
0000208C:       RET             ; Positive - Return +1        ;ALL DONE

; FLGREL - CY and A to FP, & normalise
0000208D:       LD B,88h
0000208F:       LD DE,0000h
00002092:       LD HL,EC44h			; FPEXP - Floating Point Exponent
00002095:       LD C,A
00002096:       LD (HL),B
00002097:       LD B,00h
00002099:       INC HL
0000209A:       LD (HL),80h
0000209C:       RLA
0000209D:       JP 1E38h

; ABS
000020A0:       CALL 20BDh			; VSIGN - Test sign in number
000020A3:       RET P
; INVSGN2 - Invert number sign
000020A4:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
000020A5:       JP M,23F7h			; DBL_ABS - ABS (double precision BASIC variant)
000020A8:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error if string type

; INVSGN - Invert number sign
000020AB:       LD HL,EC43h			; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000020AE:       LD A,(HL)
000020AF:       XOR 80h
000020B1:       LD (HL),A
000020B2:       RET

_SGN:
000020B3:       CALL 20BDh			; VSIGN - Test sign in number

; INT_RESULT_A - Get back from function, result in A (signed)
000020B6:       LD L,A
000020B7:       RLA
000020B8:       SBC A
000020B9:       LD H,A
000020BA:       JP 21FDh				; INT_RESULT_HL

; VSIGN - Test sign in number
000020BD:       RST 30h					; GETYPR -  Test number FAC type (Precision mode, etc..)
000020BE:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error if string type
000020C1:       JP P,0028h				; SIGN - test FP number sign
000020C4:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
; VSIGN_2
000020C7:       LD A,H
000020C8:       OR L
000020C9:       RET Z
000020CA:       LD A,H
000020CB:       JR -45h

; STAKFP - Put FP value on stack  (STAKI on MSX)
000020CD:       EX DE,HL
000020CE:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000020D1:       EX HL,(SP)
000020D2:       PUSH HL
000020D3:       LD HL,(EC43h)			; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000020D6:       EX HL,(SP)
000020D7:       PUSH HL
000020D8:       EX DE,HL
000020D9:       RET

; PHLTFP - Number at HL to BCDE
000020DA:       CALL 20EBh				; LOADFP - Load FP value pointed by HL to BCDE
; FPBCDE - Move BCDE to FPREG
000020DD:       EX DE,HL			; FPBCDE - Move BCDE to FPREG
000020DE:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000020E1:       LD H,B
000020E2:       LD L,C
000020E3:       LD (EC43h),HL			; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000020E6:       EX DE,HL
000020E7:       RET

; BCDEFP - Load FP reg to BCDE
000020E8:       LD HL,EC41h				; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
; LOADFP - Load FP value pointed by HL to BCDE
000020EB:       LD E,(HL)
000020EC:       INC HL
; LOADFP_0
000020ED:       LD D,(HL)
000020EE:       INC HL
000020EF:       LD C,(HL)
000020F0:       INC HL
000020F1:       LD B,(HL)
; INCHL
000020F2:       INC HL
000020F3:       RET

; DEC_FACCU2HL - copy number value from FPREG (FP accumulator) to HL
000020F4:       LD DE,EC41h				; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
; DEC_DE2HL -  copy 4 byte FP number from DE to HL
000020F7:       LD B,04h
000020F9:       JR +05h
; VAL2DE - Copy number value from HL to DE
000020FB:       EX DE,HL

; FP2HL - copy number value from DE to HL
000020FC:       LD A,(EABDh)			; VALTYP - type indicator
000020FF:       LD B,A
; CPY2HL
00002100:       LD A,(DE)
00002101:       LD (HL),A
00002102:       INC DE
00002103:       INC HL
00002104:       DJNZ -06h	; CPY2HL
00002106:       RET

00002107:       LD HL,EC43h				; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
0000210A:       LD A,(HL)
0000210B:       RLCA
0000210C:       SCF
0000210D:       RRA
0000210E:       LD (HL),A
0000210F:       CCF
00002110:       RRA
00002111:       INC HL
00002112:       INC HL
00002113:       LD (HL),A
00002114:       LD A,C
00002115:       RLCA
00002116:       SCF
00002117:       RRA
00002118:       LD C,A
00002119:       RRA
0000211A:       XOR (HL)
0000211B:       RET

; FP_ARG2DE
0000211C:       LD HL,EC4Ah			; ARG - ptr to FP argument
; FP_HL2DE
0000211F:       LD DE,20FBh			; VAL2DE - Copy number value from HL to DE
00002122:       JR +06h

; FP_ARG2HL
00002124:       LD HL,EC4Ah			; ARG - ptr to FP argument
00002127:       LD DE,20FCh			; FP2HL - copy number value from DE to HL
0000212A:       PUSH DE
0000212B:       LD DE,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000212E:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000212F:       RET C
00002130:       LD DE,EC3Dh
00002133:       RET

;  CMPNUM - Compare FP reg to BCDE
00002134:       LD A,B
00002135:       OR A
00002136:       JP Z,0028h		; SIGN - test FP number sign
00002139:       LD HL,2087h     ; FCOMPS
0000213C:       PUSH HL
0000213D:       RST 28h			; SIGN - test FP number sign
0000213E:       LD A,C
0000213F:       RET Z
00002140:       LD HL,EC43h		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002143:       XOR (HL)
00002144:       LD A,C
00002145:       RET M
00002146:       CALL 214Ch		; CMPFP
00002149:       RRA
0000214A:       XOR C
0000214B:       RET

CMPFP:
0000214C:       INC HL
0000214D:       LD A,B
0000214E:       CP (HL)
0000214F:       RET NZ
00002150:       DEC HL
00002151:       LD A,C
00002152:       CP (HL)
00002153:       RET NZ
00002154:       DEC HL
00002155:       LD A,D
00002156:       CP (HL)
00002157:       RET NZ
00002158:       DEC HL
00002159:       LD A,E
0000215A:       SUB (HL)
0000215B:       RET NZ
0000215C:       POP HL
0000215D:       POP HL
0000215E:       RET

; ICOMP - INTEGER COMPARE
0000215F:       LD A,D
00002160:       XOR H
00002161:       LD A,H
00002162:       JP M,2088h
00002165:       CP D
00002166:       JR NZ,+03h
00002168:       LD A,L
00002169:       SUB E
0000216A:       RET Z
0000216B:       JP 2089h        ; SIGNS

0000216E:       LD HL,EC4Ah			; ARG - ptr to FP argument
00002171:       CALL 20FCh		; FP2HL - copy number value from DE to HL

; XDCOMP (a.k.a. DECCOMP - Double precision compare)
00002174:       LD DE,EC51h		; ARG
00002177:       LD A,(DE)
00002178:       OR A
00002179:       JP Z,0028h				; SIGN - test FP number sign
0000217C:       LD HL,2087h     ; FCOMPS
0000217F:       PUSH HL
00002180:       RST 28h				; SIGN - test FP number sign
00002181:       DEC DE
00002182:       LD A,(DE)
00002183:       LD C,A
00002184:       RET Z
00002185:       LD HL,EC43h		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002188:       XOR (HL)
00002189:       LD A,C
0000218A:       RET M
0000218B:       INC DE
0000218C:       INC HL
0000218D:       LD B,08h
0000218F:       LD A,(DE)
00002190:       SUB (HL)
00002191:       JR NZ,-4Ah
00002193:       DEC DE
00002194:       DEC HL
00002195:       DJNZ -08h
00002197:       POP BC
00002198:       RET

; DECCOMP - Double precision compare
00002199:       CALL 2174h		; XDCOMP (a.k.a. DECCOMP - Double precision compare)
0000219C:       JP NZ,2087h     ; FCOMPS
0000219F:       RET

; CINT
000021A0:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
000021A1:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000021A4:       RET M
000021A5:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error if string type
000021A8:       JP PO,21BCh
000021AB:       CALL 2124h			; FP_ARG2HL
000021AE:       LD HL,2D56h			; number constant ..
000021B1:       CALL 211Fh			; FP_HL2DE
000021B4:       CALL 2424h			; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
000021B7:       CALL 221Ch
000021BA:       JR +03h
000021BC:       CALL 1DDBh
000021BF:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000021C2:       OR A				; test FP number sign
000021C3:       PUSH AF
000021C4:       AND 7Fh
000021C6:       LD (EC43h),A		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000021C9:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
000021CC:       CP 90h			; 
000021CE:       JP NC,03ABh			; "Overflow" error
000021D1:       CALL 225Bh			; FPINT - Floating Point to Integer
000021D4:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
000021D7:       OR A
000021D8:       JP NZ,21DFh
000021DB:       POP AF
000021DC:       EX DE,HL
000021DD:       JR +05h
000021DF:       POP AF
000021E0:       EX DE,HL
000021E1:       JP P,21EAh
000021E4:       LD A,H
000021E5:       CPL
000021E6:       LD H,A
000021E7:       LD A,L
000021E8:       CPL
000021E9:       LD L,A
000021EA:       JP 21FDh				; INT_RESULT_HL

000021ED:       LD HL,03ABh			; "Overflow" error
000021F0:       PUSH HL
000021F1:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
000021F4:       CP 90h			; 
000021F6:       JR NC,+0Eh
000021F8:       CALL 225Bh			; FPINT - Floating Point to Integer
000021FB:       EX DE,HL
000021FC:       POP DE

; INT_RESULT_HL
000021FD:       LD (EC41h),HL		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
; SETTYPE_INT
00002200:       LD A,02h
00002202:       LD (EABDh),A		; VALTYP - type indicator
00002205:       RET

00002206:       LD BC,9080h			; BCDE = -32768 (float)
00002209:       LD DE,0000h
0000220C:       CALL 2134h			;  CMPNUM - Compare FP reg to BCDE
0000220F:       RET NZ
00002210:       LD H,C				; HL = 32768
00002211:       LD L,D
00002212:       JR -18h				; to INT_RESULT_HL

; CSNG - Convert number to single precision
00002214:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002215:       RET PO
00002216:       JP M,222Fh
00002219:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error if string type
0000221C:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
0000221F:       CALL 2252h
00002222:       LD A,B
00002223:       OR A
00002224:       RET Z
00002225:       CALL 2107h
00002228:       LD HL,EC40h
0000222B:       LD B,(HL)
0000222C:       JP 1E7Ch

0000222F:       LD HL,(EC41h)		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00002232:       CALL 2252h
00002235:       LD A,H
00002236:       LD D,L
00002237:       LD E,00h
00002239:       LD B,90h
0000223B:       JP 2092h

; CDBL
0000223E:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000223F:       RET NC
00002240:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error if string type
00002243:       CALL M,222Fh
00002246:       LD HL,0000h
00002249:       LD (EC3Dh),HL
0000224C:       LD (EC3Fh),HL
0000224F:       LD A,08h
00002251:       LD BC,043Eh
00002254:       JR -54h

; TSTSTR - Test a string, 'Type Error' if it is not
00002256:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002257:       RET Z			; RET if string type
00002258:       JP 03B1h		; TYPE_ERR, "Type mismatch" error

; FPINT - Floating Point to Integer
0000225B:       LD B,A
0000225C:       LD C,A
0000225D:       LD D,A
0000225E:       LD E,A
0000225F:       OR A
00002260:       RET Z
00002261:       PUSH HL
00002262:       CALL 20E8h				; BCDEFP - Load FP reg to BCDE
00002265:       CALL 2107h
00002268:       XOR (HL)
00002269:       LD H,A
0000226A:       CALL M,227Fh		; DCBCDE - Decrement FP value in BCDE
0000226D:       LD A,98h
0000226F:       SUB B
00002270:       CALL 1EBBh			; SCALE - Scale number in BCDE for A exponent (bits)
00002273:       LD A,H
00002274:       RLA
00002275:       CALL C,1E8Eh
00002278:       LD B,00h
0000227A:       CALL C,1EA7h		; COMPL - Convert a negative number to positive
0000227D:       POP HL
0000227E:       RET

; DCBCDE - Decrement FP value in BCDE
0000227F:       DEC DE
00002280:       LD A,D
00002281:       AND E
00002282:       INC A
00002283:       RET NZ
00002284:       DEC BC
00002285:       RET

; FIX - Double Precision to Integer conversion
_FIX:
00002286:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002287:       RET M
00002288:       RST 28h				; SIGN - test FP number sign
00002289:       JP P,2295h			; _INT
0000228C:       CALL 20ABh			; INVSGN - Invert number sign
0000228F:       CALL 2295h			; _INT
00002292:       JP 20A4h			; INVSGN2 - Invert number sign

_INT:
00002295:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002296:       RET M
00002297:       JR NC,+1Fh
00002299:       JP Z,03B1h		; TYPE_ERR, "Type mismatch" error if string type
0000229C:       CALL 21F1h

; INT
0000229F:       LD HL,EC44h			; FPEXP - Floating Point Exponent
000022A2:       LD A,(HL)
000022A3:       CP 98h
000022A5:       LD A,(EC41h)		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000022A8:       RET NC
000022A9:       LD A,(HL)
000022AA:       CALL 225Bh			; FPINT - Floating Point to Integer
000022AD:       LD (HL),98h
000022AF:       LD A,E
000022B0:       PUSH AF
000022B1:       LD A,C
000022B2:       RLA
000022B3:       CALL 1E38h
000022B6:       POP AF
000022B7:       RET

000022B8:       LD HL,EC44h			; FPEXP - Floating Point Exponent
000022BB:       LD A,(HL)
000022BC:       CP 90h		; 
000022BE:       JR NZ,+18h
000022C0:       LD C,A
000022C1:       DEC HL
000022C2:       LD A,(HL)
000022C3:       XOR 80h
000022C5:       LD B,06h
000022C7:       DEC HL
000022C8:       OR (HL)
000022C9:       DJNZ -04h
000022CB:       OR A
000022CC:       LD HL,8000h
000022CF:       JR NZ,+06h
000022D1:       CALL 21FDh				; INT_RESULT_HL
000022D4:       JP 223Eh			; CDBL

000022D7:       LD A,C
000022D8:       OR A
000022D9:       RET Z
000022DA:       CP B8h
000022DC:       RET NC
000022DD:       PUSH AF
000022DE:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
000022E1:       CALL 2107h
000022E4:       XOR (HL)
000022E5:       DEC HL
000022E6:       LD (HL),B8h
000022E8:       PUSH AF
000022E9:       DEC HL
000022EA:       LD (HL),C
000022EB:       CALL M,2308h
000022EE:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000022F1:       LD C,A
000022F2:       LD HL,EC43h		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000022F5:       LD A,B8h
000022F7:       SUB B
000022F8:       CALL 251Bh
000022FB:       POP AF
000022FC:       CALL M,24D4h
000022FF:       XOR A
00002300:       LD (EC3Ch),A
00002303:       POP AF
00002304:       RET NC
00002305:       JP 248Ch
00002308:       LD HL,EC3Dh
0000230B:       LD A,(HL)
0000230C:       DEC (HL)
0000230D:       OR A
0000230E:       INC HL
0000230F:       JR Z,-06h
00002311:       RET

; MLDEBC - Multiply DE by BC
00002312:       PUSH HL
00002313:       LD HL,0000h
00002316:       LD A,B
00002317:       OR C
00002318:       JR Z,+12h
0000231A:       LD A,10h
0000231C:       ADD HL,HL
0000231D:       JP C,5CE8h
00002320:       EX DE,HL
00002321:       ADD HL,HL
00002322:       EX DE,HL
00002323:       JR NC,+04h
00002325:       ADD HL,BC
00002326:       JP C,5CE8h
00002329:       DEC A
0000232A:       JR NZ,-10h
0000232C:       EX DE,HL
0000232D:       POP HL
0000232E:       RET

; ISUB - Integer SUB
0000232F:       LD A,H
00002330:       RLA
00002331:       SBC A
00002332:       LD B,A
00002333:       CALL 23EDh
00002336:       LD A,C
00002337:       SBC B
00002338:       JR +03h

; IADD - Integer ADD
0000233A:       LD A,H
0000233B:       RLA
0000233C:       SBC A
0000233D:       LD B,A
0000233E:       PUSH HL
0000233F:       LD A,D
00002340:       RLA
00002341:       SBC A
00002342:       ADD HL,DE
00002343:       ADC B
00002344:       RRCA
00002345:       XOR H
00002346:       JP P,21FCh
00002349:       PUSH BC
0000234A:       EX DE,HL
0000234B:       CALL 2232h
0000234E:       POP AF
0000234F:       POP HL
00002350:       CALL 20CDh			; STAKFP - Put FP value on stack
00002353:       EX DE,HL
00002354:       CALL 2407h			; ADDPHL - ADD number at HL to BCDE
00002357:       JP 2808h			; FADD (FPADD-2)

; INT_MUL - Integer MULTIPLY (aka IMULT)
0000235A:       LD A,H
0000235B:       OR L
0000235C:       JP Z,21FDh				; INT_RESULT_HL
0000235F:       PUSH HL
00002360:       PUSH DE
00002361:       CALL 23E1h
00002364:       PUSH BC
00002365:       LD B,H
00002366:       LD C,L
00002367:       LD HL,0000h
0000236A:       LD A,10h
; IMULT_0
0000236C:       ADD HL,HL
0000236D:       JR C,+1Dh
0000236F:       EX DE,HL
00002370:       ADD HL,HL
00002371:       EX DE,HL
00002372:       JR NC,+03h
00002374:       ADD HL,BC
00002375:       JR C,+15h
; IMULT_1
00002377:       DEC A
00002378:       JR NZ,-0Eh		; IMULT_0
0000237A:       POP BC
0000237B:       POP DE
0000237C:       LD A,H
0000237D:       OR A
0000237E:       JP M,2385h		; IMULT_3
00002381:       POP DE
00002382:       LD A,B
00002383:       JR +64h
; IMULT_3
00002385:       XOR 80h
00002387:       OR L
00002388:       JR Z,+13h		; IMULT_6
0000238A:       EX DE,HL
0000238B:       LD BC,E1C1h
0000238E:       CALL 2232h
00002391:       POP HL
; 
00002392:       CALL 20CDh			; STAKFP - Put FP value on stack
00002395:       CALL 2232h
00002398:       POP BC
00002399:       POP DE
0000239A:       JP 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
; IMULT_6
0000239D:       LD A,B
0000239E:       OR A
0000239F:       POP BC
000023A0:       JP M,21FDh				; INT_RESULT_HL
000023A3:       PUSH DE
000023A4:       CALL 2232h
000023A7:       POP DE
000023A8:       JP 20ABh			; INVSGN - Invert number sign

000023AB:       LD A,H
000023AC:       OR L
000023AD:       JP Z,039Ch			;  "Division by zero" error
000023B0:       CALL 23E1h
000023B3:       PUSH BC
000023B4:       EX DE,HL
000023B5:       CALL 23EDh
000023B8:       LD B,H
000023B9:       LD C,L
000023BA:       LD HL,0000h
000023BD:       LD A,11h
000023BF:       PUSH AF
000023C0:       OR A
000023C1:       JR +09h

000023C3:       PUSH AF
000023C4:       PUSH HL
000023C5:       ADD HL,BC
000023C6:       JR NC,+03h
000023C8:       POP AF
000023C9:       SCF
000023CA:       LD A,E1h
000023CC:       LD A,E
000023CD:       RLA
000023CE:       LD E,A
000023CF:       LD A,D
000023D0:       RLA
000023D1:       LD D,A
000023D2:       LD A,L
000023D3:       RLA
000023D4:       LD L,A
000023D5:       LD A,H
000023D6:       RLA
000023D7:       LD H,A
000023D8:       POP AF
000023D9:       DEC A
000023DA:       JR NZ,-19h
000023DC:       EX DE,HL
000023DD:       POP BC
000023DE:       PUSH DE
000023DF:       JR -65h

; Used by INT_MUL (IMULT)
000023E1:       LD A,H
000023E2:       XOR D
000023E3:       LD B,A
000023E4:       CALL 23E8h
000023E7:       EX DE,HL
000023E8:       LD A,H
000023E9:       OR A
000023EA:       JP P,21FDh				; INT_RESULT_HL
000023ED:       XOR A
000023EE:       LD C,A
000023EF:       SUB L
000023F0:       LD L,A
000023F1:       LD A,C
000023F2:       SBC H
000023F3:       LD H,A
000023F4:       JP 21FDh				; INT_RESULT_HL

; DBL_ABS - ABS (double precision BASIC variant)
000023F7:       LD HL,(EC41h)		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000023FA:       CALL 23EDh
000023FD:       LD A,H
000023FE:       XOR 80h
00002400:       OR L
00002401:       RET NZ
; DBL_ABS_0
00002402:       EX DE,HL
00002403:       CALL 2252h
00002406:       XOR A
; ADDPHL - ADD number at HL to BCDE
00002407:       LD B,98h
00002409:       JP 2092h

; IMOD
0000240C:       PUSH DE
0000240D:       CALL 23ABh
00002410:       XOR A
00002411:       ADD D
00002412:       RRA
00002413:       LD H,A
00002414:       LD A,E
00002415:       RRA
00002416:       LD L,A
00002417:       CALL 2200h		; SETTYPE_INT
0000241A:       POP AF
0000241B:       JR -34h

; DBL_SUB Double precision SUB (formerly DECSUB, SUBCDE)
0000241D:       LD HL,EC50h		; DBL_LAST_FPREG - Last byte in Double Precision FP register (+sign bit)
00002420:       LD A,(HL)
00002421:       XOR 80h				; invert FP number sign
00002423:       LD (HL),A
; DBL_ADD  Double precision ADD (formerly DECADD, FPADD)
00002424:       LD HL,EC51h		; ARG
00002427:       LD A,(HL)
00002428:       OR A
00002429:       RET Z
0000242A:       CALL EDB7h
0000242D:       LD B,A
0000242E:       DEC HL
0000242F:       LD C,(HL)
00002430:       LD DE,EC44h		; FPEXP - Floating Point Exponent
00002433:       LD A,(DE)
00002434:       OR A
00002435:       JP Z,211Ch		; FP_ARG2DE
00002438:       SUB B
00002439:       JR NC,+16h
0000243B:       CPL
0000243C:       INC A
0000243D:       PUSH AF
0000243E:       LD C,08h
00002440:       INC HL
00002441:       PUSH HL
00002442:       LD A,(DE)
00002443:       LD B,(HL)
00002444:       LD (HL),A
00002445:       LD A,B
00002446:       LD (DE),A
00002447:       DEC DE
00002448:       DEC HL
00002449:       DEC C
0000244A:       JR NZ,-0Ah
0000244C:       POP HL
0000244D:       LD B,(HL)
0000244E:       DEC HL
0000244F:       LD C,(HL)
00002450:       POP AF
00002451:       CP 39h
00002453:       RET NC
00002454:       PUSH AF
00002455:       CALL 2107h
00002458:       LD HL,EC49h
0000245B:       LD B,A
0000245C:       LD A,00h
0000245E:       LD (HL),A
0000245F:       LD (EC3Ch),A
00002462:       POP AF
00002463:       LD HL,EC50h		; DBL_LAST_FPREG - Last byte in Double Precision FP register (+sign bit)
00002466:       CALL 251Bh
00002469:       LD A,B
0000246A:       OR A
0000246B:       JP P,2483h
0000246E:       LD A,(EC49h)
00002471:       LD (EC3Ch),A
00002474:       CALL 24E6h
00002477:       JR NC,+49h
00002479:       EX DE,HL
0000247A:       INC (HL)
0000247B:       JP Z,283Ch
0000247E:       CALL 2542h
00002481:       JR +3Fh
00002483:       CALL 24F8h
00002486:       LD HL,EC45h		; SGNRES - Sign of result
00002489:       CALL C,250Ah
0000248C:       XOR A
0000248D:       LD B,A
0000248E:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002491:       OR A				; test FP number sign
00002492:       JR NZ,+1Eh
00002494:       LD HL,EC3Ch
00002497:       LD C,08h
00002499:       LD D,(HL)
0000249A:       LD (HL),A
0000249B:       LD A,D
0000249C:       INC HL
0000249D:       DEC C
0000249E:       JR NZ,-07h
000024A0:       LD A,B
000024A1:       SUB 08h
000024A3:       CP C0h
000024A5:       JR NZ,-1Ah
000024A7:       JP 1E4Eh
000024AA:       DEC B
000024AB:       LD HL,EC3Ch
000024AE:       CALL 2549h
000024B1:       OR A
000024B2:       JP P,24AAh
000024B5:       LD A,B
000024B6:       OR A
000024B7:       JR Z,+09h
000024B9:       LD HL,EC44h		; FPEXP - Floating Point Exponent
000024BC:       ADD (HL)
000024BD:       LD (HL),A
000024BE:       JP NC,1E4Eh
000024C1:       RET Z
000024C2:       LD A,(EC3Ch)
000024C5:       OR A
000024C6:       CALL M,24D4h
000024C9:       LD HL,EC45h		; SGNRES - Sign of result
000024CC:       LD A,(HL)
000024CD:       AND 80h
000024CF:       DEC HL
000024D0:       DEC HL
000024D1:       XOR (HL)
000024D2:       LD (HL),A
000024D3:       RET
000024D4:       LD HL,EC3Dh
000024D7:       LD B,07h
000024D9:       INC (HL)
000024DA:       RET NZ
000024DB:       INC HL
000024DC:       DJNZ -05h
000024DE:       INC (HL)
000024DF:       JP Z,283Ch
000024E2:       DEC HL
000024E3:       LD (HL),80h
000024E5:       RET

000024E6:       LD HL,EC4Ah			; ARG - ptr to FP argument
000024E9:       LD DE,EC3Dh
000024EC:       LD C,07h
000024EE:       XOR A
000024EF:       LD A,(DE)
000024F0:       ADC (HL)
000024F1:       LD (DE),A
000024F2:       INC DE
000024F3:       INC HL
000024F4:       DEC C
000024F5:       JR NZ,-08h
000024F7:       RET

000024F8:       LD HL,EC4Ah			; ARG - ptr to FP argument
000024FB:       LD DE,EC3Dh
000024FE:       LD C,07h
00002500:       XOR A
00002501:       LD A,(DE)
00002502:       SBC (HL)
00002503:       LD (DE),A
00002504:       INC DE
00002505:       INC HL
00002506:       DEC C
00002507:       JR NZ,-08h
00002509:       RET
0000250A:       LD A,(HL)
0000250B:       CPL
0000250C:       LD (HL),A
0000250D:       LD HL,EC3Ch
00002510:       LD B,08h
00002512:       XOR A
00002513:       LD C,A
00002514:       LD A,C
00002515:       SBC (HL)
00002516:       LD (HL),A
00002517:       INC HL
00002518:       DJNZ -06h
0000251A:       RET
0000251B:       LD (HL),C
0000251C:       PUSH HL
0000251D:       SUB 08h
0000251F:       JR C,+0Eh
00002521:       POP HL
00002522:       PUSH HL
00002523:       LD DE,0800h
00002526:       LD C,(HL)
00002527:       LD (HL),E
00002528:       LD E,C
00002529:       DEC HL
0000252A:       DEC D
0000252B:       JR NZ,-07h
0000252D:       JR -12h
0000252F:       ADD 09h
00002531:       LD D,A
00002532:       XOR A
00002533:       POP HL
00002534:       DEC D
00002535:       RET Z
00002536:       PUSH HL
00002537:       LD E,08h
00002539:       LD A,(HL)
0000253A:       RRA
0000253B:       LD (HL),A
0000253C:       DEC HL
0000253D:       DEC E
0000253E:       JR NZ,-07h
00002540:       JR -10h
00002542:       LD HL,EC43h		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002545:       LD D,01h
00002547:       JR -13h
00002549:       LD C,08h
0000254B:       LD A,(HL)
0000254C:       RLA
0000254D:       LD (HL),A
0000254E:       INC HL
0000254F:       DEC C
00002550:       JR NZ,-07h
00002552:       RET

; DBL_MUL Double precision MUL (formerly DECMUL)
00002553:       RST 28h				; SIGN - test FP number sign
00002554:       RET Z
00002555:       LD A,(EC51h)		; ARG
00002558:       OR A
00002559:       JP Z,1E4Eh
0000255C:       CALL EDBDh
0000255F:       CALL 203Ah
00002562:       CALL 268Ah
00002565:       LD (HL),C
00002566:       INC DE
00002567:       LD B,07h
00002569:       LD A,(DE)
0000256A:       INC DE
0000256B:       OR A
0000256C:       PUSH DE
0000256D:       JR Z,+16h
0000256F:       LD C,08h
00002571:       PUSH BC
00002572:       RRA
00002573:       LD B,A
00002574:       CALL C,24E6h
00002577:       CALL 2542h
0000257A:       LD A,B
0000257B:       POP BC
0000257C:       DEC C
0000257D:       JR NZ,-0Eh
0000257F:       POP DE
00002580:       DJNZ -19h
00002582:       JP 248Ch
00002585:       LD HL,EC43h		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002588:       CALL 2522h
0000258B:       JR -0Eh

0000258D:       CALL CCCCh
00002590:       CALL Z,CCCCh
00002593:       LD C,H
00002594:       LD A,L
00002595:       NOP
00002596:       NOP
00002597:       NOP
00002598:       NOP
00002599:       NOP
0000259A:       NOP
0000259B:       JR NZ,-7Ch
0000259D:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
000025A0:       CP 41h		; 'A'
000025A2:       NOP
000025A3:       NOP
000025A4:       LD DE,2595h
000025A7:       LD HL,EC4Ah			; ARG - ptr to FP argument
000025AA:       CALL 20FCh			; FP2HL - copy number value from DE to HL
000025AD:       JR +7Ah
000025AF:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000025B2:       OR A				; test FP number sign
000025B3:       JP P,25BFh
000025B6:       AND 7Fh
000025B8:       LD (EC43h),A		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
000025BB:       LD HL,20ABh			; INVSGN - Invert number sign
000025BE:       PUSH HL
000025BF:       CALL 25F6h
000025C2:       LD DE,EC3Dh
000025C5:       LD HL,EC4Ah			; ARG - ptr to FP argument
000025C8:       CALL 20FCh			; FP2HL - copy number value from DE to HL
000025CB:       CALL 25F6h
000025CE:       CALL 2424h			; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
000025D1:       LD DE,EC3Dh
000025D4:       LD HL,EC4Ah			; ARG - ptr to FP argument
000025D7:       CALL 20FCh			; FP2HL - copy number value from DE to HL
000025DA:       LD A,0Fh
000025DC:       PUSH AF
000025DD:       CALL 25FEh
000025E0:       CALL 2609h
000025E3:       CALL 2424h			; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
000025E6:       LD HL,EC50h			; DBL_LAST_FPREG - Last byte in Double Precision FP register (+sign bit)
000025E9:       CALL 2619h
000025EC:       POP AF
000025ED:       DEC A
000025EE:       JR NZ,-14h
000025F0:       CALL 25F6h
000025F3:       CALL 25F6h
000025F6:       LD HL,EC44h		; FPEXP - Floating Point Exponent
000025F9:       DEC (HL)
000025FA:       RET NZ
000025FB:       JP 1E4Eh

000025FE:       LD HL,EC51h		; ARG
00002601:       LD A,04h
00002603:       DEC (HL)
00002604:       RET Z
00002605:       DEC A
00002606:       JR NZ,-05h
00002608:       RET

00002609:       POP DE
0000260A:       LD A,04h
0000260C:       LD HL,EC4Ah			; ARG - ptr to FP argument
0000260F:       LD C,(HL)
00002610:       INC HL
00002611:       LD B,(HL)
00002612:       INC HL
00002613:       PUSH BC
00002614:       DEC A
00002615:       JR NZ,-08h
00002617:       PUSH DE
00002618:       RET

00002619:       POP DE
0000261A:       LD A,04h
0000261C:       LD HL,EC51h		; ARG
0000261F:       POP BC
00002620:       LD (HL),B
00002621:       DEC HL
00002622:       LD (HL),C
00002623:       DEC HL
00002624:       DEC A
00002625:       JR NZ,-08h
00002627:       PUSH DE
00002628:       RET

; DBL_DIV Double precision DIV (formerly DECDIV)
00002629:       LD A,(EC51h)		; ARG
0000262C:       OR A
0000262D:       JP Z,2849h			; ?"Division by zero"?
00002630:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00002633:       OR A
00002634:       JP Z,1E4Eh
00002637:       CALL EDC3h
0000263A:       CALL 2037h
0000263D:       INC (HL)
0000263E:       INC (HL)
0000263F:       JP Z,283Ch
00002642:       CALL 268Ah
00002645:       LD HL,EC74h
00002648:       LD (HL),C
00002649:       LD B,C
0000264A:       LD DE,EC6Dh
0000264D:       LD HL,EC4Ah			; ARG - ptr to FP argument
00002650:       CALL 24FEh
00002653:       LD A,(DE)
00002654:       SBC C
00002655:       CCF
00002656:       JR C,+0Bh
00002658:       LD DE,EC6Dh
0000265B:       LD HL,EC4Ah			; ARG - ptr to FP argument
0000265E:       CALL 24ECh
00002661:       XOR A
00002662:       JP C,0412h
00002665:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002668:       INC A
00002669:       DEC A
0000266A:       RRA
0000266B:       JP M,24C5h
0000266E:       RLA
0000266F:       LD HL,EC3Dh
00002672:       LD C,07h
00002674:       CALL 254Bh
00002677:       LD HL,EC6Dh
0000267A:       CALL 2549h
0000267D:       LD A,B
0000267E:       OR A
0000267F:       JR NZ,-37h
00002681:       LD HL,EC44h		; FPEXP - Floating Point Exponent
00002684:       DEC (HL)
00002685:       JR NZ,-3Dh
00002687:       JP 1E4Eh
0000268A:       LD A,C
0000268B:       LD (EC50h),A		; DBL_LAST_FPREG - Last byte in Double Precision FP register (+sign bit)
0000268E:       DEC HL
0000268F:       LD DE,EC73h
00002692:       LD BC,0700h
00002695:       LD A,(HL)
00002696:       LD (DE),A
00002697:       LD (HL),C
00002698:       DEC DE
00002699:       DEC HL
0000269A:       DJNZ -07h
0000269C:       RET

0000269D:       CALL 2124h			; FP_ARG2HL
000026A0:       EX DE,HL
000026A1:       DEC HL
000026A2:       LD A,(HL)
000026A3:       OR A
000026A4:       RET Z
000026A5:       ADD 02h
000026A7:       JP C,283Ch
000026AA:       LD (HL),A
000026AB:       PUSH HL
000026AC:       CALL 2424h			; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
000026AF:       POP HL
000026B0:       INC (HL)
000026B1:       RET NZ
000026B2:       JP 283Ch

; DBL_ASCTFP2
000026B5:       CALL 1E4Eh
000026B8:       CALL 224Fh
000026BB:       OR AFh
000026BD:       LD BC,1DCCh
000026C0:       PUSH BC
000026C1:       PUSH AF
000026C2:       LD A,01h
000026C4:       LD (EC46h),A
000026C7:       POP AF

000026C8:       EX DE,HL
000026C9:       LD BC,00FFh
000026CC:       LD H,B
000026CD:       LD L,B
000026CE:       CALL Z,21FDh				; INT_RESULT_HL
000026D1:       EX DE,HL
000026D2:       LD A,(HL)

; H_ASCTFP - ASCII to FP number (also '&' prefixes)
000026D3:       CP 26h		; '&'
000026D5:       JP Z,1423h			; '&' specifier, convert text with radix indication to number

; _ASCTFP - ASCII to FP number
000026D8:       CP 2Dh
000026DA:       PUSH AF
000026DB:       JR Z,+05h
000026DD:       CP 2Bh
000026DF:       JR Z,+01h
000026E1:       DEC HL
000026E2:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000026E3:       JP C,27A2h
000026E6:       CP 2Eh		; '.'
000026E8:       JR Z,+6Bh
000026EA:       CP 65h
000026EC:       JR Z,+02h
000026EE:       CP 45h
000026F0:       JR NZ,+1Fh
000026F2:       PUSH HL
000026F3:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000026F4:       CP 6Ch
000026F6:       JR Z,+0Ah
000026F8:       CP 4Ch
000026FA:       JR Z,+06h
000026FC:       CP 71h
000026FE:       JR Z,+02h
00002700:       CP 51h
00002702:       POP HL
00002703:       JR Z,+0Bh
00002705:       LD A,(EABDh)		; VALTYP - type indicator
00002708:       CP 08h
0000270A:       JR Z,+19h
0000270C:       LD A,00h
0000270E:       JR +15h
00002710:       LD A,(HL)
00002711:       CP 25h
00002713:       JR Z,+4Ah
00002715:       CP 23h		;'#'
00002717:       JR Z,+54h
00002719:       CP 21h
0000271B:       JR Z,+51h
0000271D:       CP 64h
0000271F:       JR Z,+04h
00002721:       CP 44h
00002723:       JR NZ,+12h
00002725:       OR A
00002726:       CALL 2774h
00002729:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000272A:       CALL 14F6h		; test '+', '-'..
0000272D:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000272E:       JP C,280Dh
00002731:       INC D
00002732:       JR NZ,+03h
00002734:       XOR A
00002735:       SUB E
00002736:       LD E,A
00002737:       PUSH HL
00002738:       LD A,E
00002739:       SUB B
0000273A:       LD E,A
0000273B:       CALL P,2783h
0000273E:       CALL M,2791h
00002741:       JR NZ,-08h
00002743:       POP HL

00002744:       POP AF
00002745:       PUSH HL
00002746:       CALL Z,20A4h		; INVSGN2 - Invert number sign
00002749:       POP HL
0000274A:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000274B:       RET PE
0000274C:       PUSH HL
0000274D:       LD HL,1FA5h			; POPHLRT - (POP HL / RET)
00002750:       PUSH HL
00002751:       CALL 2206h
00002754:       RET

00002755:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002756:       INC C
00002757:       JR NZ,-22h			; JP if not string type
00002759:       CALL C,2774h
0000275C:       JP 26E2h
0000275F:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00002760:       POP AF
00002761:       PUSH HL
00002762:       LD HL,1FA5h			; POPHLRT - (POP HL / RET)
00002765:       PUSH HL
00002766:       LD HL,21A0h			; CINT
00002769:       PUSH HL
0000276A:       PUSH AF
0000276B:       JR -36h

0000276D:       OR A
0000276E:       CALL 2774h
00002771:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00002772:       JR -3Dh
00002774:       PUSH HL
00002775:       PUSH DE
00002776:       PUSH BC
00002777:       PUSH AF
00002778:       CALL Z,2214h		; CSNG - Convert number to single precision
0000277B:       POP AF
0000277C:       CALL NZ,223Eh		; CDBL
0000277F:       POP BC
00002780:       POP DE
00002781:       POP HL
00002782:       RET

00002783:       RET Z
00002784:       PUSH AF
00002785:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002786:       PUSH AF
00002787:       CALL PO,206Ch		; MLSP10 - Multiply number in FPREG by 10
0000278A:       POP AF
0000278B:       CALL PE,269Dh
0000278E:       POP AF
0000278F:       DEC A
00002790:       RET

00002791:       PUSH DE
00002792:       PUSH HL
00002793:       PUSH AF
00002794:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002795:       PUSH AF
00002796:       CALL PO,1FACh
00002799:       POP AF
0000279A:       CALL PE,259Dh
0000279D:       POP AF
0000279E:       POP HL
0000279F:       POP DE
000027A0:       INC A
000027A1:       RET

000027A2:       PUSH DE
000027A3:       LD A,B
000027A4:       ADC C
000027A5:       LD B,A
000027A6:       PUSH BC
000027A7:       PUSH HL
000027A8:       LD A,(HL)
000027A9:       SUB 30h
000027AB:       PUSH AF
000027AC:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
000027AD:       JP P,27D6h
000027B0:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000027B3:       LD DE,0CCDh
000027B6:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000027B7:       JR NC,+19h
000027B9:       LD D,H
000027BA:       LD E,L
000027BB:       ADD HL,HL
000027BC:       ADD HL,HL
000027BD:       ADD HL,DE
000027BE:       ADD HL,HL
000027BF:       POP AF
000027C0:       LD C,A
000027C1:       ADD HL,BC
000027C2:       LD A,H
000027C3:       OR A
000027C4:       JP M,27D0h
000027C7:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000027CA:       POP HL
000027CB:       POP BC
000027CC:       POP DE
000027CD:       JP 26E2h

000027D0:       LD A,C
000027D1:       PUSH AF
000027D2:       CALL 222Fh
000027D5:       SCF
000027D6:       JR NC,+18h
000027D8:       LD BC,9474h
000027DB:       LD DE,2400h
000027DE:       CALL 2134h		;  CMPNUM - Compare FP reg to BCDE
000027E1:       JP P,27EDh
000027E4:       CALL 206Ch		; MLSP10 - Multiply number in FPREG by 10
000027E7:       POP AF
000027E8:       CALL 2802h
000027EB:       JR -23h
000027ED:       CALL 2246h
000027F0:       CALL 269Dh
000027F3:       CALL 2124h			; FP_ARG2HL
000027F6:       POP AF
000027F7:       CALL 208Dh			; FLGREL - CY and A to FP, & normalise
000027FA:       CALL 2246h
000027FD:       CALL 2424h			; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
00002800:       JR -38h

00002802:       CALL 20CDh			; STAKFP - Put FP value on stack
00002805:       CALL 208Dh			; FLGREL - CY and A to FP, & normalise

; FADD
00002808:       POP BC
00002809:       POP DE
0000280A:       JP 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)

0000280D:       LD A,E
0000280E:       CP 0Ah
00002810:       JR NC,+09h

00002812:       RLCA
00002813:       RLCA
00002814:       ADD E
00002815:       RLCA
00002816:       ADD (HL)
00002817:       SUB 30h			; '0'
00002819:       LD E,A
0000281A:       JP M,321Eh
0000281D:       JP 272Dh

00002820:       PUSH HL
00002821:       LD HL,EC43h		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002824:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002825:       JP PO,282Dh
00002828:       LD A,(EC50h)		; DBL_LAST_FPREG - Last byte in Double Precision FP register (+sign bit)
0000282B:       JR +01h
0000282D:       LD A,C
0000282E:       XOR (HL)
0000282F:       RLA
00002830:       POP HL
00002831:       JR +20h

00002833:       POP AF
00002834:       POP AF
00002835:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002838:       RLA
00002839:       JR +18h

0000283B:       POP AF
0000283C:       LD A,(EC45h)		; SGNRES - Sign of result
0000283F:       CPL
00002840:       RLA
00002841:       JR +10h
00002843:       OR B
00002844:       JR Z,+06h
00002846:       LD A,C
00002847:       JR +03h
00002849:       JP 06E3h

0000284C:       RLA
0000284D:       LD HL,60AFh
00002850:       LD (E65Ah),HL
00002853:       PUSH HL
00002854:       PUSH BC
00002855:       PUSH DE
00002856:       PUSH AF
00002857:       PUSH AF
00002858:       LD HL,(EB0Dh)		; ONELIN - LINE to go when error
0000285B:       LD A,H
0000285C:       OR L
0000285D:       JR NZ,+1Bh
0000285F:       LD HL,EC46h
00002862:       LD A,(HL)
00002863:       OR A
00002864:       JR Z,+04h
00002866:       DEC A
00002867:       JR NZ,+11h
00002869:       INC (HL)
0000286A:       LD HL,(E65Ah)

0000286D:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64ACh
				DEFB 2			; ..will jump to 659Dh, bank 2

00002873:       NOP
00002874:       NOP
00002875:       NOP
00002876:       NOP
00002877:       NOP
00002878:       NOP
00002879:       NOP

0000287A:       POP AF
0000287B:       LD HL,EC41h			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000287E:       LD DE,28B2h
00002881:       JR NC,+03h
00002883:       LD DE,28B6h
00002886:       CALL 20F7h			; DEC_DE2HL -  copy 4 byte FP number from DE to HL
00002889:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000288A:       JR C,+09h
0000288C:       LD HL,EC3Dh
0000288F:       LD DE,28B6h
00002892:       CALL 20F7h			; DEC_DE2HL -  copy 4 byte FP number from DE to HL
00002895:       LD HL,(EB0Dh)		; ONELIN - LINE to go when error
00002898:       LD A,H
00002899:       OR L
0000289A:       LD HL,(E65Ah)
0000289D:       LD DE,6056h
000028A0:       EX DE,HL
000028A1:       LD (E65Ah),HL
000028A4:       JR Z,+07h
000028A6:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000028A7:       JP Z,03ABh			; "Overflow" error
000028AA:       JP 039Ch			;  "Division by zero" error

000028AD:       POP AF
000028AE:       POP DE
000028AF:       POP BC
000028B0:       POP HL
000028B1:       RET
000028B2:       RST 38h
000028B3:       RST 38h
000028B4:       LD A,A
000028B5:       RST 38h
000028B6:       RST 38h
000028B7:       RST 38h
000028B8:       RST 38h
000028B9:       RST 38h

; LNUM_MSG - Finalize (error) message by printing the current line number
000028BA:       PUSH HL
000028BB:       LD HL,0315h			; " in "
000028BE:       CALL 5550h			; PRS - Print message pointed by HL
000028C1:       POP HL
; _PRNUM - PRINT number pointed by HL
000028C2:       LD BC,554Fh			; PRNUMS
000028C5:       PUSH BC
000028C6:       CALL 21FDh				; INT_RESULT_HL
000028C9:       XOR A
000028CA:       CALL 294Bh
000028CD:       OR (HL)
000028CE:       JR +1Ch

; FOUT Convert number/expression to string (format not specified)
000028D0:       XOR A
; PUFOUT - Convert number/expression to string (format specified in 'A' register)
000028D1:       CALL 294Bh
000028D4:       AND 08h
000028D6:       JR Z,+02h
000028D8:       LD (HL),2Bh	; '+'
000028DA:       EX DE,HL
000028DB:       CALL 20BDh			; VSIGN - Test sign in number
000028DE:       EX DE,HL
000028DF:       JP P,28ECh
000028E2:       LD (HL),2Dh ; '-'
000028E4:       PUSH BC
000028E5:       PUSH HL
000028E6:       CALL 20A4h			; INVSGN2 - Invert number sign
000028E9:       POP HL
000028EA:       POP BC
000028EB:       OR H
000028EC:       INC HL
000028ED:       LD (HL),30h	; '0'
000028EF:       LD A,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
000028F2:       LD D,A
000028F3:       RLA
000028F4:       LD A,(EABDh)		; VALTYP - type indicator
000028F7:       JP C,2A5Ah
000028FA:       JP Z,2A52h
000028FD:       CP 04h
000028FF:       JR NC,+53h
00002901:       LD BC,0000h
00002904:       CALL 2D09h
00002907:       LD HL,EC53h			; FBUFFR+1 - Buffer for fout
0000290A:       LD B,(HL)
0000290B:       LD C,20h
0000290D:       LD A,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
00002910:       LD E,A
00002911:       AND 20h
00002913:       JR Z,+0Ch
00002915:       LD A,B
00002916:       CP C
00002917:       LD C,2Ah	; '*'
00002919:       JR NZ,+06h
0000291B:       LD A,E
0000291C:       AND 04h
0000291E:       JR NZ,+01h
00002920:       LD B,C
00002921:       LD (HL),C
00002922:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00002923:       JR Z,+14h
00002925:       CP 45h		; 'E'
00002927:       JR Z,+10h
00002929:       CP 44h		; 'D'
0000292B:       JR Z,+0Ch
0000292D:       CP 30h		; '0'
0000292F:       JR Z,-10h
00002931:       CP 2Ch		; ','
00002933:       JR Z,-14h
00002935:       CP 2Eh		; '.'
00002937:       JR NZ,+03h
00002939:       DEC HL
0000293A:       LD (HL),30h	; '0'
0000293C:       LD A,E
0000293D:       AND 10h
0000293F:       JR Z,+03h
00002941:       DEC HL
00002942:       LD (HL),5Ch	; '$'
00002944:       LD A,E
00002945:       AND 04h
00002947:       RET NZ
00002948:       DEC HL
00002949:       LD (HL),B
0000294A:       RET

0000294B:       LD (EAF3h),A		; TEMP3 - used for garbage collection or by USR function
0000294E:       LD HL,EC53h			; FBUFFR+1 - Buffer for fout
00002951:       LD (HL),20h	; ' '
00002953:       RET

00002954:       CALL 20CDh			; STAKFP - Put FP value on stack
00002957:       EX DE,HL
00002958:       LD HL,(EC3Dh)
0000295B:       PUSH HL
0000295C:       LD HL,(EC3Fh)
0000295F:       PUSH HL
00002960:       EX DE,HL
00002961:       PUSH AF
00002962:       XOR A
00002963:       LD (EC48h),A
00002966:       POP AF
00002967:       PUSH AF
00002968:       CALL 29F0h
0000296B:       LD B,45h
0000296D:       LD C,00h
0000296F:       PUSH HL
00002970:       LD A,(HL)
00002971:       CP B
00002972:       JR Z,+27h
00002974:       CP 3Ah		; ':'
00002976:       JR NC,+05h
00002978:       CP 30h
0000297A:       JR C,+01h
0000297C:       INC C
0000297D:       INC HL
0000297E:       LD A,(HL)
0000297F:       OR A
00002980:       JR NZ,-11h
00002982:       LD A,44h
00002984:       CP B
00002985:       LD B,A
00002986:       POP HL
00002987:       LD C,00h
00002989:       JR NZ,-1Ch
0000298B:       POP AF
0000298C:       POP BC
0000298D:       POP DE
0000298E:       EX DE,HL
0000298F:       LD (EC3Dh),HL
00002992:       LD H,B
00002993:       LD L,C
00002994:       LD (EC3Fh),HL
00002997:       EX DE,HL
00002998:       POP BC
00002999:       POP DE
0000299A:       RET
0000299B:       PUSH BC
0000299C:       LD B,00h
0000299E:       INC HL
0000299F:       LD A,(HL)
000029A0:       CP 2Bh
000029A2:       JR Z,+35h
000029A4:       CP 2Dh
000029A6:       JR Z,+0Eh
000029A8:       SUB 30h
000029AA:       LD C,A
000029AB:       LD A,B
000029AC:       ADD A
000029AD:       ADD A
000029AE:       ADD B
000029AF:       ADD A
000029B0:       ADD C
000029B1:       LD B,A
000029B2:       CP 10h
000029B4:       JR NC,+23h
000029B6:       INC HL
000029B7:       LD A,(HL)
000029B8:       OR A
000029B9:       JR NZ,-1Bh
000029BB:       LD H,B
000029BC:       POP BC
000029BD:       LD A,B
000029BE:       CP 45h
000029C0:       JR NZ,+0Eh
000029C2:       LD A,C
000029C3:       ADD H
000029C4:       CP 09h
000029C6:       POP HL
000029C7:       JR NC,-3Eh
000029C9:       LD A,80h
000029CB:       LD (EC48h),A
000029CE:       JR +0Dh
000029D0:       LD A,H
000029D1:       ADD C
000029D2:       CP 12h
000029D4:       POP HL
000029D5:       JR NC,-4Ch
000029D7:       JR -10h
000029D9:       POP BC
000029DA:       POP HL
000029DB:       JR -52h
000029DD:       POP AF
000029DE:       POP BC
000029DF:       POP DE
000029E0:       EX DE,HL
000029E1:       LD (EC3Dh),HL
000029E4:       LD H,B
000029E5:       LD L,C
000029E6:       LD (EC3Fh),HL
000029E9:       EX DE,HL
000029EA:       POP BC
000029EB:       POP DE
000029EC:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
000029EF:       INC HL
000029F0:       CP 05h
000029F2:       PUSH HL
000029F3:       SBC 00h
000029F5:       RLA
000029F6:       LD D,A
000029F7:       INC D
000029F8:       CALL 2BC8h
000029FB:       LD BC,0300h
000029FE:       PUSH AF
000029FF:       LD A,(EC48h)
00002A02:       OR A
00002A03:       JP P,2A0Ah
00002A06:       POP AF
00002A07:       ADD D
00002A08:       JR +09h
00002A0A:       POP AF
00002A0B:       ADD D
00002A0C:       JP M,2A17h
00002A0F:       INC D
00002A10:       CP D
00002A11:       JR NC,+04h
00002A13:       INC A
00002A14:       LD B,A
00002A15:       LD A,02h
00002A17:       SUB 02h
00002A19:       POP HL
00002A1A:       PUSH AF
00002A1B:       CALL 2C58h
00002A1E:       LD (HL),30h
00002A20:       CALL Z,20F2h			; INCHL  (INC HL, RET)
00002A23:       CALL 2C7Dh
00002A26:       DEC HL
00002A27:       LD A,(HL)
00002A28:       CP 30h
00002A2A:       JR Z,-06h
00002A2C:       CP 2Eh		; '.'
00002A2E:       CALL NZ,20F2h			; INCHL  (INC HL, RET)
00002A31:       POP AF
00002A32:       JR Z,+1Fh
00002A34:       PUSH AF
00002A35:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002A36:       LD A,22h
00002A38:       ADC A
00002A39:       LD (HL),A
00002A3A:       INC HL
00002A3B:       POP AF
00002A3C:       LD (HL),2Bh
00002A3E:       JP P,2A45h
00002A41:       LD (HL),2Dh
00002A43:       CPL
00002A44:       INC A
00002A45:       LD B,2Fh
00002A47:       INC B
00002A48:       SUB 0Ah
00002A4A:       JR NC,-05h
00002A4C:       ADD 3Ah
00002A4E:       INC HL
00002A4F:       LD (HL),B
00002A50:       INC HL
00002A51:       LD (HL),A
00002A52:       INC HL
00002A53:       LD (HL),00h
00002A55:       EX DE,HL
00002A56:       LD HL,EC53h			; FBUFFR+1 - Buffer for fout
00002A59:       RET

00002A5A:       INC HL
00002A5B:       PUSH BC
00002A5C:       CP 04h
00002A5E:       LD A,D
00002A5F:       JR NC,+66h
00002A61:       RRA
00002A62:       JP C,2B5Fh
00002A65:       LD BC,0603h 			; SRCHLN_0 - Sink HL in stack and get first line number
00002A68:       CALL 2C50h
00002A6B:       POP DE
00002A6C:       LD A,D
00002A6D:       SUB 05h
00002A6F:       CALL P,2C30h
00002A72:       CALL 2D09h
00002A75:       LD A,E
00002A76:       OR A
00002A77:       CALL Z,205Fh
00002A7A:       DEC A
00002A7B:       CALL P,2C30h
00002A7E:       PUSH HL
00002A7F:       CALL 2907h
00002A82:       POP HL
00002A83:       JR Z,+02h
00002A85:       LD (HL),B
00002A86:       INC HL
00002A87:       LD (HL),00h
00002A89:       LD HL,EC52h			; FBUFFR - Buffer for fout
00002A8C:       INC HL
00002A8D:       LD A,(EB10h)		; TEMP2 - temp. storage used by EVAL  (on MSX NXTOPR is used instead)
00002A90:       SUB L
00002A91:       SUB D
00002A92:       RET Z
00002A93:       LD A,(HL)
00002A94:       CP 20h		; ' '
00002A96:       JR Z,-0Ch
00002A98:       CP 2Ah
00002A9A:       JR Z,-10h
00002A9C:       DEC HL
00002A9D:       PUSH HL
00002A9E:       PUSH AF
00002A9F:       LD BC,2A9Eh
00002AA2:       PUSH BC
00002AA3:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00002AA4:       CP 2Dh
00002AA6:       RET Z
00002AA7:       CP 2Bh
00002AA9:       RET Z
00002AAA:       CP 5Ch
00002AAC:       RET Z
00002AAD:       POP BC
00002AAE:       CP 30h
00002AB0:       JR NZ,+0Eh
00002AB2:       INC HL
00002AB3:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00002AB4:       JR NC,+0Ah
00002AB6:       DEC HL
00002AB7:       LD BC,772Bh
00002ABA:       POP AF
00002ABB:       JR Z,-05h
00002ABD:       POP BC
00002ABE:       JR -33h
00002AC0:       POP AF
00002AC1:       JR Z,-03h
00002AC3:       POP HL
00002AC4:       LD (HL),25h
00002AC6:       RET
00002AC7:       PUSH HL
00002AC8:       RRA
00002AC9:       JP C,2B66h
00002ACC:       JR Z,+14h
00002ACE:       LD DE,2D5Eh			; number constant ..
00002AD1:       CALL 216Eh
00002AD4:       LD D,10h
00002AD6:       JP M,2AF0h
00002AD9:       POP HL
00002ADA:       POP BC
00002ADB:       CALL 28D0h			; FOUT Convert number/expression to string (format not specified)
00002ADE:       DEC HL
00002ADF:       LD (HL),25h
00002AE1:       RET

00002AE2:       LD BC,B60Eh
00002AE5:       LD DE,1BCAh
00002AE8:       CALL 2134h		;  CMPNUM - Compare FP reg to BCDE
00002AEB:       JP P,2AD9h
00002AEE:       LD D,06h
00002AF0:       RST 28h				; SIGN - test FP number sign
00002AF1:       CALL NZ,2BC8h
00002AF4:       POP HL
00002AF5:       POP BC
00002AF6:       JP M,2B13h
00002AF9:       PUSH BC
00002AFA:       LD E,A
00002AFB:       LD A,B
00002AFC:       SUB D
00002AFD:       SUB E
00002AFE:       CALL P,2C30h
00002B01:       CALL 2C44h
00002B04:       CALL 2C7Dh
00002B07:       OR E
00002B08:       CALL NZ,2C3Eh
00002B0B:       OR E
00002B0C:       CALL NZ,2C6Ah
00002B0F:       POP DE
00002B10:       JP 2A75h
00002B13:       LD E,A
00002B14:       LD A,C
00002B15:       OR A
00002B16:       CALL NZ,278Fh
00002B19:       ADD E
00002B1A:       JP M,2B1Eh
00002B1D:       XOR A
00002B1E:       PUSH BC
00002B1F:       PUSH AF
00002B20:       CALL M,2791h
00002B23:       JP M,2B20h
00002B26:       POP BC
00002B27:       LD A,E
00002B28:       SUB B
00002B29:       POP BC
00002B2A:       LD E,A
00002B2B:       ADD D
00002B2C:       LD A,B
00002B2D:       JP M,2B3Bh
00002B30:       SUB D
00002B31:       SUB E
00002B32:       CALL P,2C30h
00002B35:       PUSH BC
00002B36:       CALL 2C44h
00002B39:       JR +11h
00002B3B:       CALL 2C30h
00002B3E:       LD A,C
00002B3F:       CALL 2C6Dh
00002B42:       LD C,A
00002B43:       XOR A
00002B44:       SUB D
00002B45:       SUB E
00002B46:       CALL 2C30h
00002B49:       PUSH BC
00002B4A:       LD B,A
00002B4B:       LD C,A
00002B4C:       CALL 2C7Dh
00002B4F:       POP BC
00002B50:       OR C
00002B51:       JR NZ,+03h
00002B53:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
00002B56:       ADD E
00002B57:       DEC A
00002B58:       CALL P,2C30h
00002B5B:       LD D,B
00002B5C:       JP 2A7Eh
00002B5F:       PUSH HL
00002B60:       PUSH DE
00002B61:       CALL 222Fh
00002B64:       POP DE
00002B65:       XOR A
00002B66:       JR Z,+03h
00002B68:       LD E,10h
00002B6A:       LD BC,061Eh
00002B6D:       RST 28h				; SIGN - test FP number sign
00002B6E:       SCF
00002B6F:       CALL NZ,2BC8h
00002B72:       POP HL
00002B73:       POP BC
00002B74:       PUSH AF
00002B75:       LD A,C
00002B76:       OR A
00002B77:       PUSH AF
00002B78:       CALL NZ,278Fh
00002B7B:       ADD B
00002B7C:       LD C,A
00002B7D:       LD A,D
00002B7E:       AND 04h
00002B80:       CP 01h
00002B82:       SBC A
00002B83:       LD D,A
00002B84:       ADD C
00002B85:       LD C,A
00002B86:       SUB E
00002B87:       PUSH AF
00002B88:       PUSH BC
00002B89:       CALL M,2791h
00002B8C:       JP M,2B89h
00002B8F:       POP BC
00002B90:       POP AF
00002B91:       PUSH BC
00002B92:       PUSH AF
00002B93:       JP M,2B97h
00002B96:       XOR A
00002B97:       CPL
00002B98:       INC A
00002B99:       ADD B
00002B9A:       INC A
00002B9B:       ADD D
00002B9C:       LD B,A
00002B9D:       LD C,00h
00002B9F:       CALL 2C7Dh
00002BA2:       POP AF
00002BA3:       CALL P,2C38h
00002BA6:       CALL 2C6Ah
00002BA9:       POP BC
00002BAA:       POP AF
00002BAB:       JR NZ,+0Ch
00002BAD:       CALL 205Fh
00002BB0:       LD A,(HL)
00002BB1:       CP 2Eh		; '.'
00002BB3:       CALL NZ,20F2h			; INCHL  (INC HL, RET)
00002BB6:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
00002BB9:       POP AF
00002BBA:       JR C,+03h
00002BBC:       ADD E
00002BBD:       SUB B
00002BBE:       SUB D
00002BBF:       PUSH BC
00002BC0:       CALL 2A34h
00002BC3:       EX DE,HL
00002BC4:       POP DE
00002BC5:       JP 2A7Eh

00002BC8:       PUSH DE
00002BC9:       XOR A
00002BCA:       PUSH AF
00002BCB:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002BCC:       JP PO,2BE8h
00002BCF:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00002BD2:       CP 91h
00002BD4:       JR NC,+12h
00002BD6:       LD DE,2D3Eh			; number constant ..
00002BD9:       LD HL,EC4Ah			; ARG - ptr to FP argument
00002BDC:       CALL 20FCh			; FP2HL - copy number value from DE to HL
00002BDF:       CALL 2553h			; DBL_MUL Double precision MUL (formerly DECMUL)
00002BE2:       POP AF
00002BE3:       SUB 0Ah
00002BE5:       PUSH AF
00002BE6:       JR -19h

00002BE8:       CALL 2C16h
00002BEB:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002BEC:       JP PE,2BFAh
00002BEF:       LD BC,9143h
00002BF2:       LD DE,4FF9h
00002BF5:       CALL 2134h		;  CMPNUM - Compare FP reg to BCDE
00002BF8:       JR +06h

00002BFA:       LD DE,2D46h			; number constant ..
00002BFD:       CALL 216Eh
00002C00:       JP P,2C12h
00002C03:       POP AF
00002C04:       CALL 2784h
00002C07:       PUSH AF
00002C08:       JR -1Fh
00002C0A:       POP AF
00002C0B:       CALL 2791h
00002C0E:       PUSH AF
00002C0F:       CALL 2C16h
00002C12:       POP AF
00002C13:       OR A
00002C14:       POP DE
00002C15:       RET

00002C16:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002C17:       JP PE,2C25h
00002C1A:       LD BC,9474h
00002C1D:       LD DE,23F8h
00002C20:       CALL 2134h		;  CMPNUM - Compare FP reg to BCDE
00002C23:       JR +06h

00002C25:       LD DE,2D4Eh			; number constant ..
00002C28:       CALL 216Eh
00002C2B:       POP HL
00002C2C:       JP P,2C0Ah
00002C2F:       LD PC,HL

00002C30:       OR A
00002C31:       RET Z
00002C32:       DEC A
00002C33:       LD (HL),30h
00002C35:       INC HL
00002C36:       JR -07h

00002C38:       JR NZ,+04h
00002C3A:       RET Z
00002C3B:       CALL 2C6Ah
00002C3E:       LD (HL),30h
00002C40:       INC HL
00002C41:       DEC A
00002C42:       JR -0Ah
00002C44:       LD A,E
00002C45:       ADD D
00002C46:       INC A
00002C47:       LD B,A
00002C48:       INC A
00002C49:       SUB 03h
00002C4B:       JR NC,-04h
00002C4D:       ADD 05h
00002C4F:       LD C,A
00002C50:       LD A,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
00002C53:       AND 40h
00002C55:       RET NZ
00002C56:       LD C,A
00002C57:       RET

00002C58:       DEC B
00002C59:       JP P,2C6Bh
00002C5C:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
00002C5F:       LD (HL),2Eh
00002C61:       INC HL
00002C62:       LD (HL),30h
00002C64:       INC B
00002C65:       JR NZ,-06h
00002C67:       INC HL
00002C68:       LD C,B
00002C69:       RET

00002C6A:       DEC B
00002C6B:       JR NZ,+08h
00002C6D:       LD (HL),2Eh
00002C6F:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
00002C72:       INC HL
00002C73:       LD C,B
00002C74:       RET

00002C75:       DEC C
00002C76:       RET NZ
00002C77:       LD (HL),2Ch
00002C79:       INC HL
00002C7A:       LD C,03h
00002C7C:       RET

00002C7D:       PUSH DE
00002C7E:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00002C7F:       JP PO,2CC3h
00002C82:       PUSH BC
00002C83:       PUSH HL
00002C84:       CALL 2124h			; FP_ARG2HL
00002C87:       LD HL,2D56h			; number constant ..
00002C8A:       CALL 211Fh			; FP_HL2DE
00002C8D:       CALL 2424h			; DBL_ADD - Double precision ADD (formerly DECADD, FPADD)
00002C90:       XOR A
00002C91:       CALL 22DDh
00002C94:       POP HL
00002C95:       POP BC
00002C96:       LD DE,2D66h			; number constant ..
00002C99:       LD A,0Ah
00002C9B:       CALL 2C6Ah
00002C9E:       PUSH BC
00002C9F:       PUSH AF
00002CA0:       PUSH HL
00002CA1:       PUSH DE
00002CA2:       LD B,2Fh
00002CA4:       INC B
00002CA5:       POP HL
00002CA6:       PUSH HL
00002CA7:       CALL 24FBh
00002CAA:       JR NC,-08h
00002CAC:       POP HL
00002CAD:       CALL 24E9h
00002CB0:       EX DE,HL
00002CB1:       POP HL
00002CB2:       LD (HL),B
00002CB3:       INC HL
00002CB4:       POP AF
00002CB5:       POP BC
00002CB6:       DEC A
00002CB7:       JR NZ,-1Eh
00002CB9:       PUSH BC
00002CBA:       PUSH HL
00002CBB:       LD HL,EC3Dh
00002CBE:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
00002CC1:       JR +0Dh

00002CC3:       PUSH BC
00002CC4:       PUSH HL
00002CC5:       CALL 1DDBh
00002CC8:       LD A,01h
00002CCA:       CALL 225Bh			; FPINT - Floating Point to Integer
00002CCD:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
00002CD0:       POP HL
00002CD1:       POP BC
00002CD2:       XOR A
00002CD3:       LD DE,2DACh			; number constant ..
00002CD6:       CCF
00002CD7:       CALL 2C6Ah
00002CDA:       PUSH BC
00002CDB:       PUSH AF
00002CDC:       PUSH HL
00002CDD:       PUSH DE
00002CDE:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
00002CE1:       POP HL
00002CE2:       LD B,2Fh
00002CE4:       INC B
00002CE5:       LD A,E
00002CE6:       SUB (HL)
00002CE7:       LD E,A
00002CE8:       INC HL
00002CE9:       LD A,D
00002CEA:       SBC (HL)
00002CEB:       LD D,A
00002CEC:       INC HL
00002CED:       LD A,C
00002CEE:       SBC (HL)
00002CEF:       LD C,A
00002CF0:       DEC HL
00002CF1:       DEC HL
00002CF2:       JR NC,-10h
00002CF4:       CALL 1E9Bh			; PLUCDE - Add number pointed by HL to CDE
00002CF7:       INC HL
00002CF8:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
00002CFB:       EX DE,HL
00002CFC:       POP HL
00002CFD:       LD (HL),B
00002CFE:       INC HL
00002CFF:       POP AF
00002D00:       POP BC
00002D01:       JR C,-2Dh
00002D03:       INC DE
00002D04:       INC DE
00002D05:       LD A,04h
00002D07:       JR +06h

00002D09:       PUSH DE
00002D0A:       LD DE,2DB2h			; number constant ..
00002D0D:       LD A,05h
00002D0F:       CALL 2C6Ah
00002D12:       PUSH BC
00002D13:       PUSH AF
00002D14:       PUSH HL
00002D15:       EX DE,HL
00002D16:       LD C,(HL)
00002D17:       INC HL
00002D18:       LD B,(HL)
00002D19:       PUSH BC
00002D1A:       INC HL
00002D1B:       EX HL,(SP)
00002D1C:       EX DE,HL
00002D1D:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00002D20:       LD B,2Fh
00002D22:       INC B
00002D23:       LD A,L
00002D24:       SUB E
00002D25:       LD L,A
00002D26:       LD A,H
00002D27:       SBC D
00002D28:       LD H,A
00002D29:       JR NC,-09h
00002D2B:       ADD HL,DE
00002D2C:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00002D2F:       POP DE
00002D30:       POP HL
00002D31:       LD (HL),B
00002D32:       INC HL
00002D33:       POP AF
00002D34:       POP BC
00002D35:       DEC A
00002D36:       JR NZ,-29h
00002D38:       CALL 2C6Ah
00002D3B:       LD (HL),A
00002D3C:       POP DE
00002D3D:       RET

; data..
00002D3E:       NOP
00002D3F:       NOP
00002D40:       NOP
00002D41:       NOP
00002D42:       LD SP,HL	; f9
00002D43:       LD (BC),A	; 02
00002D44:       DEC D		; 
00002D45:       AND D
00002D46:       POP HL
00002D47:       RST 38h
00002D48:       SBC A
00002D49:       LD SP,5FA9h
00002D4C:       LD H,E
00002D4D:       OR D
00002D4E:       CP FFh
00002D50:       INC BC
00002D51:       CP A
00002D52:       RET

00002D53:       DEC DE
00002D54:       LD C,B6h
00002D56:       NOP
00002D57:       NOP
00002D58:       NOP
00002D59:       NOP
00002D5A:       NOP
00002D5B:       NOP
00002D5C:       NOP
00002D5D:       ADD B
00002D5E:       NOP
00002D5F:       NOP
00002D60:       INC B
00002D61:       CP A
00002D62:       RET
00002D63:       DEC DE
00002D64:       LD C,B6h
00002D66:       NOP
00002D67:       ADD B
00002D68:       ADD A4h
00002D6A:       LD A,(HL)
00002D6B:       ADC L
00002D6C:       INC BC
00002D6D:       NOP
00002D6E:       LD B,B
00002D6F:       LD A,D
00002D70:       DJNZ -0Dh
00002D72:       LD E,D
00002D73:       NOP
00002D74:       NOP
00002D75:       AND B
00002D76:       LD (HL),D
00002D77:       LD C,(HL)
00002D78:       JR +09h
00002D7A:       NOP
00002D7B:       NOP
00002D7C:       DJNZ -5Bh
00002D7E:       CALL NC,00E8h
00002D81:       NOP
00002D82:       NOP
00002D83:       RET PE
00002D84:       HALT
00002D85:       LD C,B
00002D86:       RLA
00002D87:       NOP
00002D88:       NOP
00002D89:       NOP
00002D8A:       CALL PO,540Bh
00002D8D:       LD (BC),A
00002D8E:       NOP
00002D8F:       NOP
00002D90:       NOP
00002D91:       JP Z,3B9Ah
00002D94:       NOP
00002D95:       NOP
00002D96:       NOP
00002D97:       NOP
00002D98:       POP HL
00002D99:       PUSH AF
00002D9A:       DEC B
00002D9B:       NOP
00002D9C:       NOP
00002D9D:       NOP
00002D9E:       ADD B
00002D9F:       SUB (HL)
00002DA0:       SBC B
00002DA1:       NOP
00002DA2:       NOP
00002DA3:       NOP
00002DA4:       NOP
00002DA5:       LD B,B
00002DA6:       LD B,D
00002DA7:       RRCA
00002DA8:       NOP
00002DA9:       NOP
00002DAA:       NOP
00002DAB:       NOP
00002DAC:       AND B
00002DAD:       ADD (HL)
00002DAE:       LD BC,2710h
00002DB1:       NOP
00002DB2:       DJNZ +27h
00002DB4:       RET PE
00002DB5:       INC BC
00002DB6:       LD H,H
00002DB7:       NOP
00002DB8:       LD A,(BC)
00002DB9:       NOP
00002DBA:       LD BC,AF00h
00002DBD:       LD B,A
00002DBE:       JP NZ,0106h
00002DC1:       PUSH BC
00002DC2:       CALL 1B9Dh			; GETWORD_HL
00002DC5:       POP BC
00002DC6:       LD DE,EC52h			; FBUFFR - Buffer for fout
00002DC9:       PUSH DE
00002DCA:       XOR A
00002DCB:       LD (DE),A
00002DCC:       DEC B
00002DCD:       INC B
00002DCE:       LD C,06h
00002DD0:       JR Z,+08h
00002DD2:       LD C,04h
00002DD4:       ADD HL,HL
00002DD5:       ADC A
00002DD6:       ADD HL,HL
00002DD7:       ADC A
00002DD8:       ADD HL,HL
00002DD9:       ADC A
00002DDA:       ADD HL,HL
00002DDB:       ADC A
00002DDC:       OR A
00002DDD:       JR NZ,+09h
00002DDF:       LD A,C
00002DE0:       DEC A
00002DE1:       JR Z,+05h
00002DE3:       LD A,(DE)
00002DE4:       OR A
00002DE5:       JR Z,+0Ch
00002DE7:       XOR A
00002DE8:       ADD 30h
00002DEA:       CP 3Ah		; ':'
00002DEC:       JR C,+02h
00002DEE:       ADD 07h
00002DF0:       LD (DE),A
00002DF1:       INC DE
00002DF2:       LD (DE),A
00002DF3:       XOR A
00002DF4:       DEC C
00002DF5:       JR Z,+06h
00002DF7:       DEC B
00002DF8:       INC B
00002DF9:       JR Z,-25h
00002DFB:       JR -29h
00002DFD:       LD (DE),A
00002DFE:       POP HL
00002DFF:       RET

; NEGAFT - Negate number
00002E00:       LD HL,20ABh		; INVSGN - Invert number sign
00002E03:       EX HL,(SP)
00002E04:       LD PC,HL

_SQR:
00002E05:       CALL 20CDh			; STAKFP - Put FP value on stack
00002E08:       LD HL,2D5Ah			; number constant ..
00002E0B:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
00002E0E:       JR +03h
00002E10:       CALL 2214h			; CSNG - Convert number to single precision
00002E13:       POP BC
00002E14:       POP DE
00002E15:       CALL EDC6h
00002E18:       LD HL,1DD4h
00002E1B:       PUSH HL
00002E1C:       LD A,01h
00002E1E:       LD (EC46h),A
00002E21:       RST 28h				; SIGN - test FP number sign
00002E22:       LD A,B
00002E23:       JP Z,2E6Eh			; _EXP
00002E26:       JP P,2E2Dh
00002E29:       OR A
00002E2A:       JP Z,284Ch
00002E2D:       OR A
00002E2E:       JP Z,1E4Fh
00002E31:       PUSH DE
00002E32:       PUSH BC
00002E33:       LD A,C
00002E34:       OR 7Fh
00002E36:       CALL 20E8h				; BCDEFP - Load FP reg to BCDE
00002E39:       JP P,2E56h
00002E3C:       PUSH AF
00002E3D:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00002E40:       CP 99h
00002E42:       JR C,+03h
00002E44:       POP AF
00002E45:       JR +0Fh

00002E47:       POP AF
00002E48:       PUSH DE
00002E49:       PUSH BC
00002E4A:       CALL 229Fh		; INT
00002E4D:       POP BC
00002E4E:       POP DE
00002E4F:       PUSH AF
00002E50:       CALL 2134h		;  CMPNUM - Compare FP reg to BCDE
00002E53:       POP HL
00002E54:       LD A,H
00002E55:       RRA
00002E56:       POP HL
00002E57:       LD (EC43h),HL		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002E5A:       POP HL
00002E5B:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00002E5E:       CALL C,2E00h			; NEGAFT - Negate number
00002E61:       CALL Z,20ABh			; INVSGN - Invert number sign
00002E64:       PUSH DE
00002E65:       PUSH BC
00002E66:       CALL 1F10h
00002E69:       POP BC
00002E6A:       POP DE
00002E6B:       CALL 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)

; _EXP
00002E6E:       LD BC,8138h
00002E71:       LD DE,AA3Bh
00002E74:       CALL 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
00002E77:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00002E7A:       CP 88h
00002E7C:       JR NC,+22h
00002E7E:       CP 68h
00002E80:       JR C,+30h
00002E82:       CALL 20CDh			; STAKFP - Put FP value on stack
00002E85:       CALL 229Fh			; INT
00002E88:       ADD 81h
00002E8A:       JR Z,+17h
00002E8C:       POP BC
00002E8D:       POP DE
00002E8E:       PUSH AF
00002E8F:       CALL 1DE6h		; SUBCDE - Subtract BCDE from FP reg (a.k.a. FSUB)
00002E92:       LD HL,2EBBh
00002E95:       CALL 2EE7h
00002E98:       POP BC
00002E99:       LD DE,0000h
00002E9C:       LD C,D
00002E9D:       JP 1F53h		; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)

00002EA0:       CALL 20CDh			; STAKFP - Put FP value on stack
00002EA3:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002EA6:       OR A				; test FP number sign
00002EA7:       JP P,2EAFh
00002EAA:       POP AF
00002EAB:       POP AF
00002EAC:       JP 1E4Eh

00002EAF:       JP 2833h

00002EB2:       LD BC,8100h
00002EB5:       LD DE,0000h
00002EB8:       JP 20DDh			; FPBCDE - Move BCDE to FPREG

00002EBB:       RLCA
00002EBC:       LD A,H
00002EBD:       ADC B
00002EBE:       LD E,C
00002EBF:       LD (HL),H
00002EC0:       RET PO
00002EC1:       SUB A
00002EC2:       LD H,77h
00002EC4:       CALL NZ,1E1Dh
00002EC7:       LD A,D
00002EC8:       LD E,(HL)
00002EC9:       LD D,B
00002ECA:       LD H,E
00002ECB:       LD A,H
00002ECC:       LD A,(DE)
00002ECD:       CP 75h
00002ECF:       LD A,(HL)
00002ED0:       JR +72h
00002ED2:       LD SP,0080h
00002ED5:       NOP
00002ED6:       NOP
00002ED7:       ADD C

00002ED8:       CALL 20CDh			; STAKFP - Put FP value on stack
00002EDB:       LD DE,2398h
00002EDE:       PUSH DE
00002EDF:       PUSH HL
00002EE0:       CALL 20E8h			; BCDEFP - Load FP reg to BCDE
00002EE3:       CALL 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
00002EE6:       POP HL
00002EE7:       CALL 20CDh			; STAKFP - Put FP value on stack
00002EEA:       LD A,(HL)
00002EEB:       INC HL
00002EEC:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
00002EEF:       LD B,F1h
00002EF1:       POP BC
00002EF2:       POP DE
00002EF3:       DEC A
00002EF4:       RET Z
00002EF5:       PUSH DE
00002EF6:       PUSH BC
00002EF7:       PUSH AF
00002EF8:       PUSH HL
00002EF9:       CALL 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
00002EFC:       POP HL
00002EFD:       CALL 20EBh			; LOADFP - Load FP value pointed by HL to BCDE
00002F00:       PUSH HL
00002F01:       CALL 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)
00002F04:       POP HL
00002F05:       JR -17h

00002F07:       LD D,D
00002F08:       RST 00h
00002F09:       LD C,A
00002F0A:       ADD B

00002F0B:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00002F0C:       PUSH HL
00002F0D:       LD HL,1EEAh
00002F10:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
00002F13:       CALL 2F1Ah			; RND
00002F16:       POP HL
00002F17:       JP 2252h

; RND
00002F1A:       RST 28h				; SIGN - test FP number sign
00002F1B:       LD HL,E610h			; RNDX
00002F1E:       JP M,2F78h
00002F21:       LD HL,E631h
00002F24:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
00002F27:       LD HL,E610h			; RNDX
00002F2A:       RET Z
00002F2B:       ADD (HL)
00002F2C:       AND 07h
00002F2E:       LD B,00h
00002F30:       LD (HL),A
00002F31:       INC HL
00002F32:       ADD A
00002F33:       ADD A
00002F34:       LD C,A
00002F35:       ADD HL,BC
00002F36:       CALL 20EBh			; LOADFP - Load FP value pointed by HL to BCDE
00002F39:       CALL 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
00002F3C:       LD A,(E60Fh)
00002F3F:       INC A
00002F40:       AND 03h
00002F42:       LD B,00h
00002F44:       CP 01h
00002F46:       ADC B
00002F47:       LD (E60Fh),A
00002F4A:       LD HL,2F7Bh
00002F4D:       ADD A
00002F4E:       ADD A
00002F4F:       LD C,A
00002F50:       ADD HL,BC
00002F51:       CALL 1DDEh
00002F54:       CALL 20E8h				; BCDEFP - Load FP reg to BCDE
00002F57:       LD A,E
00002F58:       LD E,C
00002F59:       XOR 4Fh
00002F5B:       LD C,A
00002F5C:       LD (HL),80h
00002F5E:       DEC HL
00002F5F:       LD B,(HL)
00002F60:       LD (HL),80h
00002F62:       LD HL,E60Eh
00002F65:       INC (HL)
00002F66:       LD A,(HL)
00002F67:       SUB ABh
00002F69:       JR NZ,+04h
00002F6B:       LD (HL),A
00002F6C:       INC C
00002F6D:       DEC D
00002F6E:       INC E
00002F6F:       CALL 1E3Bh
00002F72:       LD HL,E631h
00002F75:       JP 20F4h			; DEC_FACCU2HL - copy number value from FPREG (FP accumulator) to HL

00002F78:       LD (HL),A
00002F79:       DEC HL
00002F7A:       LD (HL),A
00002F7B:       DEC HL
00002F7C:       LD (HL),A
00002F7D:       JR -2Bh
00002F7F:       LD L,B
00002F80:       OR C
00002F81:       LD B,(HL)
00002F82:       LD L,B
00002F83:       SBC C
00002F84:       LD PC,HL

00002F85:       SUB D
00002F86:       LD L,C
00002F87:       DJNZ -2Fh
00002F89:       LD (HL),L
00002F8A:       LD L,B

_COS:
00002F8B:       LD HL,300Fh
00002F8E:       CALL 1DDEh

_SIN:
00002F91:       LD A,(EC44h)		; FPEXP - Floating Point Exponent
00002F94:       CP 77h
00002F96:       RET C
00002F97:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002F9A:       OR A				; test FP number sign
00002F9B:       JP P,2FA7h
00002F9E:       AND 7Fh
00002FA0:       LD (EC43h),A		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002FA3:       LD DE,20ABh			; INVSGN - Invert number sign
00002FA6:       PUSH DE
00002FA7:       LD BC,7E22h
00002FAA:       LD DE,F983h
00002FAD:       CALL 1F53h			; FPMULT - Multiply BCDE to FP reg (a.k.a. FMULT)
00002FB0:       CALL 20CDh			; STAKFP - Put FP value on stack
00002FB3:       CALL 229Fh			; INT
00002FB6:       POP BC
00002FB7:       POP DE
00002FB8:       CALL 1DE6h			; SUBCDE - Subtract BCDE from FP reg (a.k.a. FSUB)
00002FBB:       LD BC,7F00h
00002FBE:       LD DE,0000h
00002FC1:       CALL 2134h			;  CMPNUM - Compare FP reg to BCDE
00002FC4:       JP M,2FE9h
00002FC7:       LD BC,7F80h
00002FCA:       LD DE,0000h
00002FCD:       CALL 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)
00002FD0:       LD BC,8080h
00002FD3:       LD DE,0000h
00002FD6:       CALL 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)
00002FD9:       RST 28h				; SIGN - test FP number sign
00002FDA:       CALL P,20ABh		; INVSGN - Invert number sign
00002FDD:       LD BC,7F00h
00002FE0:       LD DE,0000h
00002FE3:       CALL 1DE9h			; FPADD - Add BCDE to FP reg (a.k.a. FADD)
00002FE6:       CALL 20ABh			; INVSGN - Invert number sign
00002FE9:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002FEC:       OR A				; test FP number sign
00002FED:       PUSH AF
00002FEE:       JP P,2FF6h
00002FF1:       XOR 80h				; invert FP number sign
00002FF3:       LD (EC43h),A		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00002FF6:       LD HL,3017h
00002FF9:       CALL 2ED8h
00002FFC:       POP AF
00002FFD:       RET P
00002FFE:       LD A,(EC43h)		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00003001:       XOR 80h				; invert FP number sign
00003003:       LD (EC43h),A		; LAST_FPREG - Last byte in Single Precision FP Register (+sign bit)
00003006:       RET

00003007:       NOP
00003008:       NOP
00003009:       NOP
0000300A:       NOP
0000300B:       ADD E
0000300C:       LD SP,HL
0000300D:       LD (DB7Eh),HL
00003010:       RRCA
00003011:       LD C,C
00003012:       ADD C
00003013:       NOP
00003014:       NOP
00003015:       NOP
00003016:       LD A,A
00003017:       DEC B
00003018:       EI
00003019:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000301A:       LD E,86h
0000301C:       LD H,L
0000301D:       LD H,99h
0000301F:       ADD A
00003020:       LD E,B
00003021:       INC (HL)
00003022:       INC HL
00003023:       ADD A
00003024:       POP HL
00003025:       LD E,L
00003026:       AND L
00003027:       ADD (HL)
00003028:       INA (0Fh)
0000302A:       LD C,C
0000302B:       ADD E

; TAN:
0000302C:       CALL 20CDh			; STAKFP - Put FP value on stack
0000302F:       CALL 2F91h			; _SIN
00003032:       POP BC
00003033:       POP HL
00003034:       CALL 20CDh			; STAKFP - Put FP value on stack
00003037:       EX DE,HL
00003038:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG
0000303B:       CALL 2F8Bh			; COS
0000303E:       JP 1FB5h			; DIV - Divide FP by number on stack

3040     2D EF F9 F8 F8 27 14-10 33 FA FB 10 DA 18 A5
3050  60 60 01 35 EF F5 F4 F4-4C 26 1A 36 F6 F7 20 BA
3060  42 A6 62 60 02 40 80 20-60 10 FF 7F 3F 1F 0F 07
3070  03 01 80 C0 E0 F0 F8 FC-FE 3A C3 E6 D3 E4 FB C9

00003041:       DEC L
00003042:       RST 28h				; SIGN - test FP number sign
00003043:       LD SP,HL
00003044:       RET M
00003045:       RET M
00003046:       DAA
00003047:       INC D
00003048:       DJNZ +33h
0000304A:       JP M,10FBh
0000304D:       JP C,A518h
00003050:       LD H,B
00003051:       LD H,B
00003052:       LD BC,EF35h
00003055:       PUSH AF
00003056:       CALL P,4CF4h
00003059:       LD H,1Ah
0000305B:       LD (HL),F6h
0000305D:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000305E:       JR NZ,-46h			; JP if not string type
00003060:       LD B,D
00003061:       AND (HL)
00003062:       LD H,D
00003063:       LD H,B
00003064:       LD (BC),A
00003065:       LD B,B
00003066:       ADD B

00003067:       DEFB $20
00003068:       DEFB $60
00003069:       DEFB $10

0000306A:       DEFB $FF
0000306B:       DEFB $7F
0000306C:       DEFB $3F
0000306D:       DEFB $1F
0000306E:       DEFB $0F
0000306F:       DEFB $07
00003070:       DEFB $03
00003071:       DEFB $01

00003072:       DEFB $80
00003073:       DEFB $C0
00003074:       DEFB $E0
00003075:       DEFB $F0
00003076:       DEFB $F8
00003077:       DEFB $FC
00003078:       DEFB $FE

; exit from interrupt
00003079:		LD A,(E6C3h)	; Value being sent to port E4h
0000307C:		OUTA (E4h)		; restore interrupt levels
0000307E:		EI
0000307F:		RET

0000307A:       JP D3E6h

0000307D:       CALL PO,C9FBh

; VRTCHANDLER - screen interrupt handler
00003080:       PUSH DE
00003081:       PUSH BC
00003082:       LD A,(E6C3h)	; Value being sent to port E4h
00003085:       PUSH AF
00003086:       LD A,01h		; set interrupt levels to disable also the "VRTC interrupt"
00003088:       OUTA (E4h)
0000308A:       LD E,7Fh
0000308C:       LD (E6C3h),A	; Value being sent to port E4h
0000308F:       LD A,(E6A8h)		; CursorCommand
00003092:       OUTA (51h)			; Output command to CRTC
00003094:       LD A,(EF89h)	; WIDTH
00003097:       CP 29h		; 40+1
00003099:       LD A,(EF87h)			; TTYPOS, (a.k.a. CSRX or CursorPos+1)
0000309C:       DEC A
0000309D:       JR NC,+01h
0000309F:       ADD A
000030A0:       OUTA (50h)			; Send parameter to CRTC
000030A2:       LD A,(EF86h)		; CSRY (CursorPos) - current text position
000030A5:       DEC A
000030A6:       OUTA (50h)			; Send parameter to CRTC
000030A8:       EI
000030A9:       CALL 3F3Fh
000030AC:       LD A,(E6CDh)
000030AF:       OR A
000030B0:       JR NZ,+3Ch
000030B2:       CALL 3242h		; ScanKey
000030B5:       JR NC,+24h
000030B7:       LD A,(E6CEh)
000030BA:       OR A
000030BB:       JR Z,+31h
000030BD:       LD A,(F00Ch)
000030C0:       CALL 4013h
000030C3:       LD A,(HL)
000030C4:       AND 01h
000030C6:       JR Z,+09h
000030C8:       CALL 5012h
000030CB:       XOR A
000030CC:       LD (E6CEh),A
000030CF:       JR +1Dh

000030D1:       CALL 34EAh
000030D4:       JR C,+18h
000030D6:       CALL 30F9h
000030D9:       JR -0Ah
000030DB:       JR NZ,+0Eh
000030DD:       LD HL,E6CFh			; KeyRepeatCount
000030E0:       DEC (HL)
000030E1:       JR NZ,+0Bh
000030E3:       LD A,(EFFEh)		; row ? in the keymap
000030E6:       OR A
000030E7:       JR Z,+05h
000030E9:       LD (HL),04h
000030EB:       CALL 30F9h
000030EE:       DI
000030EF:       POP AF
000030F0:       OUTA (E4h)		; restore interrupt levels
000030F2:       LD (E6C3h),A	; Value being sent to port E4h
000030F5:       POP BC
000030F6:       POP DE
000030F7:       EI
000030F8:       RET

000030F9:       LD E,A
000030FA:       LD HL,(EFC4h)
000030FD:       LD (EFC6h),HL
00003100:       CP 03h
00003102:       JR Z,+30h
00003104:       LD A,(E69Fh)
00003107:       OR A
00003108:       JP NZ,3126h
0000310B:       LD A,E
0000310C:       CP 7Fh
0000310E:       JR Z,+1Ah
00003110:       CP 01h
00003112:       JR Z,+45h
00003114:       CP 0Fh
00003116:       JR Z,+04h
00003118:       CP 13h
0000311A:       JR NZ,+0Ah
0000311C:       LD (E6CAh),A		; INTFLG
0000311F:       PUSH DE
00003120:       DI
00003121:       CALL 35D9h		; InitQueue - initialize keyboard buffer
00003124:       EI
00003125:       POP DE
00003126:       XOR A
00003127:       JP 45DDh
0000312A:       DI
0000312B:       XOR A
0000312C:       CALL 461Bh
0000312F:       RET NZ
00003130:       LD E,7Fh
00003132:       JR -0Eh
00003134:       LD A,(E69Fh)
00003137:       OR A
00003138:       JR Z,+12h
0000313A:       LD A,(E6E5h)
0000313D:       AND 01h
0000313F:       JP Z,3126h
00003142:       LD A,(F002h)
00003145:       OR A
00003146:       LD A,03h
00003148:       JP NZ,311Ch
0000314B:       RET

0000314C:       LD A,00h
0000314E:       CALL 4015h
00003151:       AND 01h
00003153:       LD A,03h
00003155:       JR Z,-3Bh
00003157:       JR +07h

00003159:       LD A,06h
0000315B:       CALL 4015h
0000315E:       AND 01h
00003160:       CALL NZ,5012h
00003163:       LD E,01h
00003165:       JR -4Bh

; RXRDY - RS-232C receive interrupt handler
00003167:       LD A,(E6C3h)	; Value being sent to port E4h
0000316A:       PUSH AF
0000316B:       XOR A
0000316C:       OUTA (E4h)		; disable all interrupts
0000316E:       LD (E6C3h),A	; Value being sent to port E4h
00003171:       INA (21h)		; USART (uPD8251C) Control port
00003173:       AND 02h
00003175:       JP Z,31FBh
00003178:       PUSH DE
00003179:       PUSH BC
0000317A:       INA (21h)		; USART (uPD8251C) Control port
0000317C:       PUSH AF
0000317D:       INA (20h)		; USART (uPD8251C) Data port
0000317F:       LD E,A
00003180:       CALL 18BBh
00003183:       OR A
00003184:       JR Z,+24h
00003186:       LD D,A
00003187:       LD A,E
00003188:       AND 7Fh
0000318A:       CP 0Fh
0000318C:       JR Z,+14h
0000318E:       CP 0Eh
00003190:       JR Z,+12h
00003192:       CP 20h		; ' '
00003194:       CCF
00003195:       JR NC,+13h
00003197:       INC D
00003198:       JR NZ,+04h
0000319A:       OR 01h
0000319C:       JR +0Ch
0000319E:       OR D
0000319F:       LD E,A
000031A0:       JR +08h
000031A2:       LD A,80h
000031A4:       OR 7Fh
000031A6:       LD (F153h),A
000031A9:       SCF
000031AA:       LD A,01h
000031AC:       CALL NC,45DDh
000031AF:       JR NZ,+05h
000031B1:       LD A,01h
000031B3:       LD (E6C9h),A
000031B6:       POP AF
000031B7:       AND 38h
000031B9:       JR Z,+11h
000031BB:       CALL ECBEh
000031BE:       LD A,(E6EDh)
000031C1:       OR 10h
000031C3:       OUTA (21h)		; USART (uPD8251C) Control port
000031C5:       LD A,(F006h)
000031C8:       CPL
000031C9:       LD (E6BFh),A
000031CC:       LD A,(E6A9h)
000031CF:       OR A
000031D0:       JR NZ,+27h
000031D2:       LD A,(F00Bh)
000031D5:       OR A
000031D6:       JR Z,+19h
000031D8:       CP 13h
000031DA:       JR Z,+15h
000031DC:       LD A,01h
000031DE:       CALL 4667h
000031E1:       DEC H
000031E2:       JR Z,+0Dh
000031E4:       LD A,L
000031E5:       CP 40h			; '@'
000031E7:       JR NC,+08h
000031E9:       LD A,13h
000031EB:       CALL 3203h
000031EE:       LD (F00Bh),A
000031F1:       LD A,01h
000031F3:       CALL 4015h
000031F6:       CALL 5012h
000031F9:       POP BC
000031FA:       POP DE
000031FB:       POP AF
000031FC:       LD (E6C3h),A	; Value being sent to port E4h
000031FF:       OUTA (E4h)		; restore interrupt levels
00003201:       EI
00003202:       RET

00003203:       PUSH DE
00003204:       PUSH AF
00003205:       LD E,FFh
00003207:       LD D,A
00003208:       CP 20h		; ' '
0000320A:       JR C,+17h
0000320C:       LD A,(F154h)
0000320F:       OR A
00003210:       JR Z,+11h
00003212:       CP 0Fh
00003214:       JR Z,+23h
00003216:       LD A,D
00003217:       OR A
00003218:       JP M,3223h
0000321B:       LD A,0Fh
0000321D:       CALL 3226h
00003220:       LD (F154h),A
00003223:       POP AF
00003224:       AND E
00003225:       POP DE
00003226:       PUSH AF
00003227:       EI
00003228:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
0000322B:       DI
0000322C:       JR C,+06h
0000322E:       CALL 3C08h
00003231:       NOP
00003232:       JR NZ,-0Dh
00003234:       POP AF
00003235:       OUTA (20h)		; USART (uPD8251C) Data port
00003237:       EI
00003238:       RET

00003239:       LD A,D
0000323A:       OR A
0000323B:       JP P,3223h
0000323E:       LD A,0Eh
00003240:       JR -25h

; ScanKey
00003242:       LD A,03h
00003244:       LD (EFF9h),A	; keymap row
00003247:       LD BC,000Bh		; keyboard row count
0000324A:       LD HL,E6DBh
0000324D:       LD DE,E6E7h
; RE-SCAN
00003250:       CALL 32F1h		; scan keyboard
00003253:       DEC HL
00003254:       DEC DE
00003255:       DEC C			; previous row
00003256:       JP P,3250h		; RE-SCAN
00003259:       LD A,(EFFFh)	; bottom keymap row
0000325C:       LD HL,F000h		; CTRL key status
0000325F:       CP (HL)
00003260:       JR Z,+40h
00003262:       PUSH HL
00003263:       OR A
00003264:       LD B,A
00003265:       JR Z,+2Bh
00003267:       LD HL,3069h
0000326A:       LD B,05h
0000326C:       CP (HL)
0000326D:       JR Z,+1Dh
0000326F:       DEC HL
00003270:       DJNZ -06h
00003272:       AND 80h
00003274:       JR Z,+07h
00003276:       LD A,03h
00003278:       LD (EFF9h),A	; keymap row
0000327B:       JR +0Ch
0000327D:       LD B,05h
0000327F:       LD A,(EFFFh)	; bottom keymap row
00003282:       AND 10h
00003284:       LD A,(EFFFh)	; bottom keymap row
00003287:       JR NZ,+03h
00003289:       POP HL
0000328A:       JR +16h
0000328C:       AND 40h
0000328E:       JR Z,+02h
00003290:       LD A,05h
00003292:       PUSH BC
00003293:       PUSH DE
00003294:       CALL 3F80h
00003297:       POP DE
00003298:       POP BC
00003299:       LD A,B
0000329A:       LD (F002h),A	
0000329D:       POP HL
0000329E:       LD A,(EFFFh)	; bottom keymap row
000032A1:       LD (HL),A
000032A2:       LD A,(EFF9h)	; keymap row
000032A5:       CP FFh
000032A7:       RET Z
000032A8:       CP 02h
000032AA:       SCF
000032AB:       RET NZ
000032AC:       LD HL,(EFFBh)	; keymap row
000032AF:       LD A,(EFFAh)	; keymap row
000032B2:       OR (HL)
000032B3:       LD (HL),A
000032B4:       LD A,1Ch
000032B6:       LD (E6CFh),A			; KeyRepeatCount
000032B9:       LD A,(EFFDh)	; keymap row
000032BC:       CALL ECDFh
000032BF:       CALL 335Ch
000032C2:       JR C,+27h
000032C4:       LD (EFFEh),A	; keymap row
000032C7:       CP 41h		; 'A'
000032C9:       JR C,+1Ah
000032CB:       CP 5Bh		; '['
000032CD:       JR C,+08h
000032CF:       CP 61h		; 'a'
000032D1:       JR C,+12h
000032D3:       CP 7Bh
000032D5:       JR NC,+0Eh
000032D7:       LD A,(F001h)	; CAPS-shift status
000032DA:       OR A
000032DB:       LD A,(EFFEh)	; keymap row
000032DE:       JR Z,+05h
000032E0:       XOR 20h
000032E2:       LD (EFFEh),A	; keymap row
000032E5:       AND A
000032E6:       RET NZ
000032E7:       INC A
000032E8:       LD A,00h
000032EA:       RET

000032EB:       LD A,00h
000032ED:       LD (EFFEh),A	; keymap row
000032F0:       RET

000032F1:       LD B,00h
000032F3:       IN A,(C)
000032F5:       CPL
000032F6:       CP (HL)
000032F7:       LD (HL),A
000032F8:       RET NZ
000032F9:       LD B,A
000032FA:       EX DE,HL
000032FB:       CPL
000032FC:       AND (HL)
000032FD:       XOR (HL)
000032FE:       LD (HL),A
000032FF:       LD A,C
00003300:       CP 08h
00003302:       JR NZ,+0Ah
00003304:       LD A,B
00003305:       AND F0h
00003307:       LD (EFFFh),A	; bottom keymap row
0000330A:       LD A,0Fh
0000330C:       JR +0Eh
0000330E:       CP 0Ah
00003310:       LD A,FFh
00003312:       JR NZ,+08h
00003314:       LD A,B
00003315:       AND 80h
00003317:       LD (F001h),A	; CAPS-shift status
0000331A:       LD A,7Fh
0000331C:       AND B
0000331D:       JR Z,+0Eh
0000331F:       XOR (HL)
00003320:       JR NZ,+0Dh
00003322:       LD A,(EFF9h)	; keymap row
00003325:       SUB 03h
00003327:       JR NZ,+04h
00003329:       DEC A
0000332A:       LD (EFF9h),A	; keymap row
0000332D:       EX DE,HL
0000332E:       RET
0000332F:       LD B,A
00003330:       LD A,(EFF9h)	; keymap row
00003333:       AND 03h
00003335:       CP 02h
00003337:       JR Z,-0Ch
00003339:       DEC A
0000333A:       LD (EFF9h),A	; keymap row
0000333D:       LD A,80h
0000333F:       PUSH DE
00003340:       LD D,08h
00003342:       LD E,A
00003343:       DEC D
00003344:       AND B
00003345:       JR NZ,+04h
00003347:       LD A,E
00003348:       RRCA
00003349:       JR -09h

0000334B:       LD (EFFBh),HL	; keymap row
0000334E:       LD (EFFAh),A	; keymap row
00003351:       LD A,C
00003352:       RLCA
00003353:       RLCA
00003354:       RLCA
00003355:       OR D
00003356:       POP DE
00003357:       LD (EFFDh),A	; keymap row
0000335A:       JR -2Fh

0000335C:       CP 50h
0000335E:       JR NC,+3Fh
00003360:       CP 4Fh
00003362:       JR Z,+2Eh
00003364:       CP 4Eh
00003366:       JR Z,+2Dh
00003368:       CP 48h
0000336A:       JR Z,+2Ch
0000336C:       LD HL,33F6h
0000336F:       LD DE,0013h
00003372:       LD C,00h
00003374:       CP (HL)
00003375:       JR C,+04h
00003377:       LD C,(HL)
00003378:       ADD HL,DE
00003379:       JR -07h
0000337B:       PUSH AF
0000337C:       PUSH HL
0000337D:       LD HL,F002h
00003380:       LD A,(HL)
00003381:       RLCA
00003382:       JP C,339Bh
00003385:       ADD (HL)
00003386:       POP HL
00003387:       LD E,A
00003388:       INC HL
00003389:       ADD HL,DE
0000338A:       LD E,(HL)
0000338B:       INC HL
0000338C:       LD D,(HL)
0000338D:       INC HL
0000338E:       LD B,(HL)
0000338F:       POP AF
00003390:       EX DE,HL
00003391:       LD PC,HL

00003392:       LD A,1Bh	; ESC
00003394:       RET

00003395:       LD A,20h	; ' '
00003397:       RET

00003398:       LD A,03h	; CTRL/C
0000339A:       RET

0000339B:       POP HL
0000339C:       POP AF
0000339D:       JR +54h

0000339F:       CP 5Ah		; ?TK_COM?
000033A1:       JR NC,+50h
000033A3:       CP 53h		; ?TK_POINT?
000033A5:       JR Z,+2Ch
000033A7:       CP 54h		; ?TK_CSRLIN?
000033A9:       JR Z,+2Bh
000033AB:       CP 59h		; ?TK_DATE$?
000033AD:       JR NZ,+05h
000033AF:       PUSH AF
000033B0:       LD A,12h
000033B2:       JR +0Fh

000033B4:       CP 58h		; ?TK_PEN?
000033B6:       JR Z,+08h
000033B8:       LD HL,3682h
000033BB:       SUB 50h		; sub 80: ?TK_DSKF?
000033BD:       JP 34C9h

;TK_PEN found:
000033C0:       PUSH AF
000033C1:       LD A,13h

000033C3:       CALL 4015h
000033C6:       AND 01h
000033C8:       JR NZ,+03h
000033CA:       POP AF
000033CB:       JR -15h
000033CD:       CALL 5012h
000033D0:       POP AF
000033D1:       JR +20h
;TK_POINT found:
000033D3:       LD A,01h
000033D5:       RET

000033D6:       LD A,(F002h)
000033D9:       CPL
000033DA:       LD (E6BAh),A
000033DD:       LD A,(E69Fh)
000033E0:       OR A
000033E1:       JR Z,+10h
000033E3:       LD A,13h
000033E5:       PUSH HL
000033E6:       PUSH DE
000033E7:       PUSH BC
000033E8:       CALL 30F9h
000033EB:       LD A,11h
000033ED:       CALL 3126h
000033F0:       POP BC
000033F1:       POP DE
000033F2:       POP HL
000033F3:       XOR A
000033F4:       SCF
000033F5:       RET


; key map
000033F6:

1506:33F0                    0A BA-34 30 BA 34 30 BA 34 30         ..40.40.40
1506:3400  BA 34 30 BA 34 30 BD 34-00 10 BD 34 04 BD 34 04   .40.40.4...4..4.
1506:3410  BD 34 04 BD 34 04 BD 34-04 BD 34 02 2B 01 35 60   .4..4..4..4.+.5`
1506:3420  09 35 40 BA 34 00 BD 34-06 11 35 06 BD 34 08 30   .5@.4..4..5..4.0
1506:3430  1F 35 5B BD 34 0A B2 34-00 BD 34 0C 26 35 0C BD   .5[.4..4..4.&5..
1506:3440  34 0E 3A BA 34 30 B4 34-20 B2 34 00 BD 34 10 BD   4.:.40.4 .4..4..
1506:3450  34 12 BD 34 14 40 BD 34-16 BD 34 18 B2 34 00 BD   4..4.@.4..4..4..
1506:3460  34 1A BD 34 1C BD 34 1E-49 BD 34 20 BD 34 22 B2   4..4..4.I.4 .4".
1506:3470  34 00 BD 34 20 BD 34 22-B2 34 00 4E D2 34 00 34   4..4 .4".4.N.4.4
1506:3480  35 05 B2 34 00 D2 34 00-34 35 05 B2 34 00 E3 35   5..4..4.45..4..5
1506:3490  F3 35 ED 35 F9 35 14 36-2F 36 34 36 39 36 3E 36   .5.5.5.6/64696>6
1506:34A0  48 36 52 36 5C 36 62 36-68 36 6E 36 74 36 7A 36   H6R6\6b6h6n6t6z6
1506:34B0  7E 36 37 C9 B9 20 03 3E-30 C9 91 80 C9 91 16 00   ~67.. .>0.......


000033F6:       LD A,(BC)
000033F7:       CP D
000033F8:       INC (HL)
000033F9:       JR NC,-46h
000033FB:       INC (HL)
000033FC:       JR NC,-46h
000033FE:       INC (HL)
000033FF:       JR NC,-46h
00003401:       INC (HL)
00003402:       JR NC,-46h
00003404:       INC (HL)
00003405:       JR NC,-43h
00003407:       INC (HL)
00003408:       NOP
00003409:       DJNZ -43h
0000340B:       INC (HL)
0000340C:       INC B
0000340D:       CP L
0000340E:       INC (HL)
0000340F:       INC B
00003410:       CP L
00003411:       INC (HL)
00003412:       INC B
00003413:       CP L
00003414:       INC (HL)
00003415:       INC B
00003416:       CP L
00003417:       INC (HL)
00003418:       INC B
00003419:       CP L
0000341A:       INC (HL)
0000341B:       LD (BC),A
0000341C:       DEC HL
0000341D:       LD BC,6035h
00003420:       ADD HL,BC
00003421:       DEC (HL)
00003422:       LD B,B
00003423:       CP D
00003424:       INC (HL)
00003425:       NOP
00003426:       CP L
00003427:       INC (HL)
00003428:       LD B,11h
0000342A:       DEC (HL)
0000342B:       LD B,BDh
0000342D:       INC (HL)
0000342E:       EX AF,AF'
0000342F:       JR NC,+1Fh
00003431:       DEC (HL)
00003432:       LD E,E
00003433:       CP L
00003434:       INC (HL)
00003435:       LD A,(BC)
00003436:       OR D
00003437:       INC (HL)
00003438:       NOP
00003439:       CP L
0000343A:       INC (HL)
0000343B:       INC C
0000343C:       LD H,35h
0000343E:       INC C
0000343F:       CP L
00003440:       INC (HL)
00003441:       LD C,3Ah
00003443:       CP D
00003444:       INC (HL)
00003445:       JR NC,-4Ch
00003447:       INC (HL)
00003448:       JR NZ,-4Eh
0000344A:       INC (HL)
0000344B:       NOP
0000344C:       CP L
0000344D:       INC (HL)
0000344E:       DJNZ -43h
00003450:       INC (HL)
00003451:       LD (DE),A
00003452:       CP L
00003453:       INC (HL)
00003454:       INC D
00003455:       LD B,B
00003456:       CP L
00003457:       INC (HL)
00003458:       LD D,BDh
0000345A:       INC (HL)
0000345B:       JR -4Eh
0000345D:       INC (HL)
0000345E:       NOP
0000345F:       CP L
00003460:       INC (HL)
00003461:       LD A,(DE)
00003462:       CP L
00003463:       INC (HL)
00003464:       INC E
00003465:       CP L
00003466:       INC (HL)
00003467:       LD E,49h
00003469:       CP L
0000346A:       INC (HL)
0000346B:       JR NZ,-43h
0000346D:       INC (HL)
0000346E:       LD (34B2h),HL
00003471:       NOP
00003472:       CP L
00003473:       INC (HL)
00003474:       JR NZ,-43h
00003476:       INC (HL)
00003477:       LD (34B2h),HL
0000347A:       NOP
0000347B:       LD C,(HL)
0000347C:       JP NC,0034h
0000347F:       INC (HL)
00003480:       DEC (HL)
00003481:       DEC B
00003482:       OR D
00003483:       INC (HL)
00003484:       NOP
00003485:       JP NC,0034h
00003488:       INC (HL)
00003489:       DEC (HL)
0000348A:       DEC B
0000348B:       OR D
0000348C:       INC (HL)
0000348D:       NOP
0000348E:       EX HL,(SP)
0000348F:       DEC (HL)
00003490:       DI
00003491:       DEC (HL)
00003492:       DB EDh,35h
00003494:       LD SP,HL
00003495:       DEC (HL)
00003496:       INC D
00003497:       LD (HL),2Fh
00003499:       LD (HL),34h
0000349B:       LD (HL),39h
0000349D:       LD (HL),3Eh
0000349F:       LD (HL),48h
000034A1:       LD (HL),52h
000034A3:       LD (HL),5Ch
000034A5:       LD (HL),62h
000034A7:       LD (HL),68h
000034A9:       LD (HL),6Eh
000034AB:       LD (HL),74h
000034AD:       LD (HL),7Ah
000034AF:       LD (HL),7Eh
000034B1:       LD (HL),37h
000034B3:       RET

000034B4:       CP C
000034B5:       JR NZ,+03h
000034B7:       LD A,30h
000034B9:       RET

000034BA:       SUB C
000034BB:       ADD B
000034BC:       RET

000034BD:       SUB C
000034BE:       LD D,00h
000034C0:       LD E,B
000034C1:       LD HL,348Eh
000034C4:       ADD HL,DE
000034C5:       LD E,(HL)
000034C6:       INC HL
000034C7:       LD H,(HL)
000034C8:       LD L,E

000034C9:       LD E,A
000034CA:       LD D,00h
000034CC:       ADD HL,DE
000034CD:       LD A,(HL)
000034CE:       AND A
000034CF:       RET NZ
000034D0:       SCF
000034D1:       RET

000034D2:       CALL 34BAh
000034D5:       LD (F00Ch),A
000034D8:       LD H,00h
000034DA:       LD L,A
000034DB:       ADD HL,HL
000034DC:       ADD HL,HL
000034DD:       ADD HL,HL
000034DE:       ADD HL,HL
000034DF:       LD DE,E6F2h		; FNKSTR - FUNCTION KEY AREA
000034E2:       ADD HL,DE
000034E3:       LD (F003h),HL
000034E6:       XOR A
000034E7:       DEC A
000034E8:       JR +0Dh

000034EA:       LD A,(E6CEh)
000034ED:       AND A
000034EE:       JR Z,+07h

000034F0:       LD HL,(F003h)
000034F3:       LD A,(HL)
000034F4:       AND A
000034F5:       JR NZ,+05h
000034F7:       LD (E6CEh),A
000034FA:       SCF
000034FB:       RET

000034FC:       INC HL
000034FD:       LD (F003h),HL
00003500:       RET

00003501:       CALL 34BAh
00003504:       CP B
00003505:       RET NZ
00003506:       LD A,40h
00003508:       RET

00003509:       CALL 34BAh
0000350C:       CP B
0000350D:       RET NZ
0000350E:       LD A,7Eh
00003510:       RET

00003511:       CP 15h
00003513:       JR Z,+07h
00003515:       CP 2Ah
00003517:       JR NZ,-5Ch
00003519:       LD A,AFh
0000351B:       RET

0000351C:       LD A,A8h
0000351E:       RET

0000351F:       CP 2Fh
00003521:       JR NZ,-69h
00003523:       LD A,2Dh
00003525:       RET

00003526:       CP 2Bh
00003528:       JR Z,+07h
0000352A:       CP 2Dh
0000352C:       JR NZ,-71h
0000352E:       LD A,A3h
00003530:       RET

00003531:       LD A,A2h
00003533:       RET

00003534:       LD (F0ACh),A
00003537:       LD A,(E69Fh)

0000353A:       OR A
0000353B:       LD A,(F0ACh)
0000353E:       JP Z,34D2h
00003541:       CALL 34BAh
00003544:       SUB 05h
00003546:       JR NZ,+0Ch
00003548:       LD A,(EF75h)
0000354B:       CPL
0000354C:       LD (E6B6h),A			; PrintCtrlCode
0000354F:       LD (EF75h),A
00003552:       JR +2Dh
00003554:       DEC A
00003555:       JR NZ,+09h
00003557:       LD A,(EF72h)
0000355A:       CPL
0000355B:       LD (EF72h),A
0000355E:       JR +21h

00003560:       DEC A
00003561:       JR NZ,+09h
00003563:       LD A,(E6A2h)
00003566:       CPL
00003567:       LD (E6A2h),A
0000356A:       JR +15h

0000356C:       DEC A
0000356D:       JR NZ,+07h
0000356F:       LD A,02h
00003571:       LD (E6A5h),A
00003574:       JR +0Bh

00003576:       LD A,(E6A2h)
00003579:       OR A
0000357A:       JR NZ,+05h
0000357C:       LD A,01h
0000357E:       LD (E6A5h),A
00003581:       SCF
00003582:       RET

; INICHR (aka GETCHAR)
00003583:       PUSH HL
00003584:       PUSH DE
00003585:       PUSH BC
00003586:       LD A,(E6CAh)		; INTFLG
00003589:       OR A
0000358A:       JR NZ,+07h
0000358C:       LD A,(E6A7h)	; CursorMode
0000358F:       OR A
00003590:       CALL NZ,4290h	; Cursor on
00003593:       CALL 7780h
00003596:       CALL 35A8h
00003599:       DI
0000359A:       XOR A
0000359B:       LD (E6CAh),A		; INTFLG
0000359E:       CALL 45F8h		; check keyboard input
000035A1:       EI
000035A2:       JR Z,-11h
000035A4:       POP BC
000035A5:       POP DE
000035A6:       POP HL
000035A7:       RET

000035A8:       LD HL,E6BAh
000035AB:       LD A,(HL)
000035AC:       OR A
000035AD:       RET Z
000035AE:       CPL
000035AF:       LD BC,0107h
000035B2:       CP 02h
000035B4:       JR Z,+06h
000035B6:       INC B
000035B7:       CP 05h
000035B9:       JR Z,+01h
000035BB:       INC B
000035BC:       CALL 6EAAh
000035BF:       LD (HL),00h
000035C1:       RET

; _BREAKX - Set CY if STOP is pressed
000035C2:       LD A,(E6CAh)		; INTFLG
000035C5:       OR A
000035C6:       RET Z
000035C7:       CP 05h
000035C9:       RET NC
000035CA:       CP 03h
000035CC:       CCF
000035CD:       RET

; CHSNS - Get key from keyboard buffer, don't wait for keypress.
000035CE:       PUSH HL
000035CF:       PUSH DE
000035D0:       PUSH BC
000035D1:       XOR A
000035D2:       CALL 45F8h		; check keyboard input
000035D5:       POP BC
000035D6:       POP DE
000035D7:       POP HL
000035D8:       RET

; InitQueue - initialize keyboard buffer
000035D9:       LD DE,EFD9h
000035DC:       LD B,1Fh
000035DE:       XOR A
000035DF:       CALL 463Dh
000035E2:       RET

000035E3:       SBC D
000035E4:       SUB E
000035E5:       ADC A
000035E6:       SUB D
000035E7:       POP HL
000035E8:       JP PO,98E3h
000035EB:       SUB C
000035EC:       SBC C
000035ED:       LD HL,(3D2Bh)
000035F0:       INC L
000035F1:       LD L,0Dh
000035F3:       SUB L
000035F4:       RET PO
000035F5:       SUB (HL)
000035F6:       SUB B
000035F7:       SBC E
000035F8:       DEC C
000035F9:       SBC C1h
000035FB:       CP D
000035FC:       CP A
000035FD:       CP H
000035FE:       OR D
000035FF:       JP Z,B8B7h
00003602:       ADD CFh
00003604:       RET
00003605:       RET C
00003606:       OUTA (D0h)
00003608:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00003609:       CP (HL)
0000360A:       RET NZ
0000360B:       CP L
0000360C:       CALL NZ,C5B6h
0000360F:       SET 0,E
00003611:       CP E
00003612:       JP NZ,9E8Ah
00003616:       ADD H
00003617:       ADD D
00003618:       AND E4h
0000361A:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
0000361B:       CALL PE,E8EDh
0000361E:       JP PE,8EEBh
00003621:       ADD (HL)
00003622:       ADD L
00003623:       LD PC,HL

00003624:       ADC L
00003625:       SBC H
00003626:       PUSH HL
00003627:       SBC A
00003628:       XOR F0h
0000362A:       ADD E
0000362B:       SBC L
0000362C:       ADD C
0000362D:       RST 28h				; SIGN - test FP number sign
0000362E:       ADD B
0000362F:       LD A,E
00003630:       LD A,H
00003631:       LD A,L
00003632:       LD A,(HL)
00003633:       DEC A
00003634:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00003635:       OR B
00003636:       POP DE
00003637:       CALL 00CEh
0000363A:       POP AF
0000363B:       NOP
0000363C:       ADC E
0000363D:       ADC H
0000363E:       CALL C,CCC7h
00003641:       OR C
00003642:       OR E
00003643:       OR H
00003644:       OR L
00003645:       CALL NC,D6D5h
00003648:       AND (HL)
00003649:       RST 00h
0000364A:       CALL Z,A9A7h
0000364D:       XOR D
0000364E:       XOR E
0000364F:       XOR H
00003650:       XOR L
00003651:       XOR (HL)
00003652:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00003653:       NOP
00003654:       NOP
00003655:       NOP
00003656:       NOP
00003657:       JP P,F4F3h
0000365A:       PUSH AF
0000365B:       OR 3Ah
0000365D:       DEC SP
0000365E:       INC L
0000365F:       LD L,2Fh
00003661:       NOP
00003662:       LD HL,(3C2Bh)
00003665:       LD A,3Fh
00003667:       LD E,A
00003668:       CP C
00003669:       JP C,D9C8h
0000366C:       JP NC,B9DBh
0000366F:       JP C,A1A4h
00003672:       AND L
00003673:       NOP
00003674:       SUB H
00003675:       ADC C
00003676:       ADD A
00003677:       ADC B
00003678:       SUB A
00003679:       NOP
0000367A:       INC C
0000367B:       LD E,1Ch
0000367D:       LD A,A
0000367E:       DEC BC
0000367F:       RRA
00003680:       DEC E
00003681:       LD (DE),A

00003682:       ADD HL,BC
00003683:       RRA
00003684:       DEC E
00003685:       NOP
00003686:       NOP
00003687:       DEC L
00003688:       CPL
00003689:       NOP
0000368A:       RET M
0000368B:       LD SP,HL

; CKCNTC - check CTRL/C (Break)
0000368C:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
0000368F:       RET NC
00003690:       LD A,FFh				; back to main ROM
00003692:       OUTA (71h)				; Extended ROM bank switching
00003694:       CALL 3583h			; INICHR (aka GETCHAR)
00003697:       JP 036Fh


; -----------------------------------------------------------------------------
;	PHYDIO
;	
;	in:	drive number in ($EC85)
;		HL	data addr
;		A	num sectors
;		B	track
;		C	sector
;		CY,Z	iomode (C-write, NC Z-check NC NZ-read)
; 	saves:	HLBCA

0000369A:       LD A,01h
0000369C:       EX DE,HL
0000369D:       PUSH BC
0000369E:       PUSH DE
0000369F:       PUSH AF
000036A0:       LD (EF4Ah),A
000036A3:       CALL 3DD9h
000036A6:       LD (EF5Fh),A
000036A9:       LD A,(EF5Dh)
000036AC:       CP 02h
000036AE:       JP C,3889h
000036B1:       POP AF
000036B2:       PUSH AF
000036B3:       LD A,01h
000036B5:       JR C,+02h
000036B7:       LD A,02h
000036B9:       CALL 3722h
000036BC:       POP AF
000036BD:       PUSH AF
000036BE:       LD B,A
000036BF:       JR C,+0Fh
000036C1:       JR Z,+10h
000036C3:       CALL 3790h
000036C6:       AND 40h
000036C8:       JP Z,379Eh
000036CB:       CALL 373Ah
000036CE:       JR +03h
000036D0:       CALL 3766h
000036D3:       CALL 3790h
000036D6:       POP AF
000036D7:       POP HL
000036D8:       POP BC
000036D9:       OR A
000036DA:       RET

; Test boot mode DIP switch
000036DB:       INA (40h)		; System mode sense
000036DD:       AND 08h			; Disk boot mode
000036DF:       XOR 08h			; invert bit, now non-zero to boot from disk
000036E1:       RET

000036E2:       PUSH BC
000036E3:       PUSH DE
000036E4:       PUSH AF
000036E5:       CALL 36DBh		; Test boot mode DIP switch
000036E8:       JR Z,+10h		; jump not to boot from disk

; boot from disk swith is set
000036EA:       LD A,91h
000036EC:       OUTA (FFh)
000036EE:       XOR A
000036EF:       LD (ECB4h),A
000036F2:       INC A
000036F3:       LD (EF14h),A
000036F6:       CALL 3700h
000036F9:       AND A

000036FA:       POP BC
000036FB:       PUSH AF
000036FC:       JR NZ,-2Bh

000036FE:       JR -2Ah

00003700:       LD A,00h
00003702:       CALL 37C9h
00003705:       LD A,05h
00003707:       LD (EF14h),A
0000370A:       LD A,07h
0000370C:       CALL 37C9h
0000370F:       CALL 3847h
00003712:       LD B,A
00003713:       LD A,10h
00003715:       LD C,00h
00003717:       LD D,A
00003718:       AND B
00003719:       JR Z,+01h
0000371B:       INC C
0000371C:       LD A,D
0000371D:       RLCA
0000371E:       JR NC,-09h
00003720:       LD A,C
00003721:       RET
00003722:       CALL 37C9h
00003725:       LD A,(EF4Ah)
00003728:       CALL 37D2h
0000372B:       LD A,(EF5Fh)
0000372E:       CALL 37D2h
00003731:       LD A,B
00003732:       CALL 37D2h
00003735:       LD A,C
00003736:       CALL 37D2h
00003739:       RET
0000373A:       LD A,03h
0000373C:       CALL 37C9h
0000373F:       LD A,(EF5Dh)
00003742:       CP 02h
00003744:       JR NZ,+0Eh
00003746:       LD C,00h
00003748:       CALL 3847h
0000374B:       LD (DE),A
0000374C:       INC DE
0000374D:       DEC C
0000374E:       JR NZ,-08h
00003750:       DEC B
00003751:       JR NZ,-0Dh
00003753:       RET
00003754:       LD C,00h
00003756:       CALL 3847h
00003759:       LD (DE),A
0000375A:       INC DE
0000375B:       LD A,L
0000375C:       LD (DE),A
0000375D:       INC DE
0000375E:       DEC C
0000375F:       DEC C
00003760:       JR NZ,-0Ch
00003762:       DEC B
00003763:       JR NZ,-11h
00003765:       RET

00003766:       LD C,00h
00003768:       LD A,(EF5Dh)
0000376B:       CP 02h
0000376D:       JR NZ,+0Ch
0000376F:       LD A,(DE)
00003770:       INC DE
00003771:       CALL 37D2h
00003774:       DEC C
00003775:       JR NZ,-08h
00003777:       DEC B
00003778:       JR NZ,-14h
0000377A:       RET
0000377B:       LD C,00h
0000377D:       LD A,(DE)
0000377E:       INC DE
0000377F:       LD L,A
00003780:       LD A,(DE)
00003781:       INC DE
00003782:       LD H,A
00003783:       LD A,L
00003784:       LD L,H
00003785:       CALL 37D2h
00003788:       DEC C
00003789:       DEC C
0000378A:       JR NZ,-0Fh
0000378C:       DEC B
0000378D:       JR NZ,-14h
0000378F:       RET
00003790:       LD A,06h
00003792:       CALL 37C9h
00003795:       CALL 3847h
00003798:       AND 41h
0000379A:       CP 01h
0000379C:       RET NZ
0000379D:       POP AF
0000379E:       POP AF
0000379F:       POP DE
000037A0:       POP BC
000037A1:       LD A,(ECB4h)
000037A4:       INC A
000037A5:       LD (ECB4h),A
000037A8:       CP 04h
000037AA:       RET C
000037AB:       LD A,(ECB6h)
000037AE:       OR A
000037AF:       JP Z,37C1h
000037B2:       LD A,(ECAAh)
000037B5:       CP B
000037B6:       JP NZ,EE71h
000037B9:       LD A,(ECACh)
000037BC:       DEC A
000037BD:       CP C
000037BE:       JP NC,EE71h
000037C1:       POP AF
000037C2:       POP AF
000037C3:       POP HL
000037C4:       POP HL
000037C5:       POP BC
000037C6:       POP AF
000037C7:       SCF
000037C8:       RET

000037C9:       CALL 3DE9h
000037CC:       PUSH AF
000037CD:       LD A,0Fh
000037CF:       OUTA (FFh)
000037D1:       POP AF
000037D2:       PUSH BC
000037D3:       PUSH DE
000037D4:       PUSH AF
000037D5:       LD BC,0000h
000037D8:       LD A,(EF14h)
000037DB:       LD D,A
000037DC:       INA (FEh)
000037DE:       AND 06h
000037E0:       CP 06h
000037E2:       JR Z,+04h
000037E4:       AND 02h
000037E6:       JR NZ,+06h
000037E8:       CALL 382Bh
000037EB:       JP 37DCh
000037EE:       LD A,0Eh
000037F0:       OUTA (FFh)
000037F2:       POP AF
000037F3:       PUSH AF
000037F4:       OUTA (FDh)
000037F6:       LD A,09h
000037F8:       OUTA (FFh)
000037FA:       LD BC,0000h
000037FD:       LD D,04h
000037FF:       INA (FEh)
00003801:       AND 04h
00003803:       JR NZ,+05h
00003805:       CALL 382Bh
00003808:       JR -0Bh
0000380A:       LD A,(EF15h)
0000380D:       OR A
0000380E:       JR Z,+03h
00003810:       LD A,L
00003811:       OUTA (FDh)
00003813:       LD A,08h
00003815:       OUTA (FFh)
00003817:       LD BC,0000h
0000381A:       LD D,04h
0000381C:       INA (FEh)
0000381E:       AND 04h
00003820:       JR Z,+05h
00003822:       CALL 382Bh
00003825:       JR -0Bh
00003827:       POP AF
00003828:       POP DE
00003829:       POP BC
0000382A:       RET
0000382B:       DEC C
0000382C:       RET NZ
0000382D:       DEC B
0000382E:       RET NZ
0000382F:       DEC D
00003830:       RET NZ
00003831:       LD A,(EF10h)
00003834:       OR A
00003835:       JR NZ,+07h
00003837:       XOR A
00003838:       LD (EF62h),A
0000383B:       POP AF
0000383C:       JR -17h
0000383E:       POP AF
0000383F:       POP AF
00003840:       POP DE
00003841:       POP BC
00003842:       POP AF
00003843:       POP AF
00003844:       JP 379Eh
00003847:       PUSH BC
00003848:       PUSH DE
00003849:       PUSH AF
0000384A:       LD BC,0000h
0000384D:       LD D,04h
0000384F:       LD A,0Bh
00003851:       OUTA (FFh)
00003853:       INA (FEh)
00003855:       AND 01h
00003857:       JR NZ,+05h
00003859:       CALL 382Bh
0000385C:       JR -0Bh
0000385E:       LD A,0Ah
00003860:       OUTA (FFh)
00003862:       POP AF
00003863:       INA (FCh)
00003865:       PUSH AF
00003866:       LD A,0Dh
00003868:       OUTA (FFh)
0000386A:       LD BC,0000h
0000386D:       LD D,04h
0000386F:       INA (FEh)
00003871:       AND 01h
00003873:       JR Z,+05h
00003875:       CALL 382Bh
00003878:       JR -0Bh
0000387A:       LD A,(EF15h)
0000387D:       OR A
0000387E:       JR Z,+03h
00003880:       INA (FCh)
00003882:       LD L,A
00003883:       LD A,0Ch
00003885:       OUTA (FFh)
00003887:       JR -62h

00003889:       POP AF
0000388A:       PUSH AF
0000388B:       CALL 38BDh		; 64E2h, Bank #2
0000388E:       CALL 3D67h
00003891:       CALL 3D8Dh
00003894:       LD A,01h
00003896:       LD (EF0Fh),A
00003899:       CALL 4250h
0000389C:       CALL 3975h
0000389F:       XOR A
000038A0:       LD (EF0Fh),A
000038A3:       CALL 3DB7h
000038A6:       LD A,(EF3Dh)
000038A9:       OR A
000038AA:       JP Z,36D6h
000038AD:       CP 80h
000038AF:       JP NZ,379Eh
000038B2:       LD A,(ECB4h)
000038B5:       CP 03h
000038B7:       JP Z,EE74h
000038BA:       JP 379Eh

000038BD:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64E2h
				DEFB 2			; ..will jump to 7150h, bank 2

000038C4:       CALL 39C2h		; test startup mode
000038C7:       DI
000038C8:       OUTA (E6h)		; Interrupt mask
000038CA:       RET C

000038CB:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 651Bh
				DEFB 2			; ..will jump to 778Fh, bank 2

000038D1:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 6024h
				DEFB 3			; ..will jump to 6045h, bank 3  (this one is odd, it will JP back to BASE ROM at addr 0 !)

000038D7:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6027h
				DEFB 3			; ..will jump to 604Ah, bank 3	(=RET)
000038DD:       RET

000038DE:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 602Ah
				DEFB 3			; ..will jump to 604Bh, bank 3	(=RET)
000038E4:       RET

000038E5:       NOP
000038E6:       NOP
000038E7:       NOP
000038E8:       NOP

000038E9:       CALL 3D67h
000038EC:       LD HL,(EF4Bh)
000038EF:       LD B,08h
000038F1:       LD A,10h
000038F3:       LD (HL),A
000038F4:       INC HL
000038F5:       DJNZ -04h
000038F7:       LD A,01h
000038F9:       LD (EF0Fh),A
000038FC:       XOR A
000038FD:       LD (EF11h),A
00003900:       CALL 4250h
00003903:       CALL 3AEDh
00003906:       RET NZ
00003907:       LD A,01h
00003909:       LD (EF11h),A
0000390C:       XOR A
0000390D:       LD (EF17h),A
00003910:       CALL 3975h
00003913:       LD A,(EF3Dh)
00003916:       CP 80h
00003918:       JR Z,-07h
0000391A:       XOR A
0000391B:       LD (EF0Fh),A
0000391E:       RET

0000391F:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64E5h
				DEFB 2			; ..will jump to 717Fh, bank 2
00003925:       RET

00003926:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6000h
				DEFB 3			; ..will jump to 6000h, then continue to 602Dh, bank 3
0000392C:       RET

0000392D:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 652Ah
				DEFB 2			; ..will jump to 77B1h, bank 2
00003933:       RET

00003934:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 652Dh
				DEFB 2			; ..will jump to 7647h, bank 2
0000393A:       RET

0000393B:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6530h
				DEFB 2			; ..will jump to 7683h, bank 2
00003941:       RET

00003942:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 6536h
				DEFB 2			; ..will jump to 777Fh, bank 2

00003948:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 6539h
				DEFB 2			; ..will jump to 7782h, bank 2

0000394E:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 653Ch
				DEFB 2			; ..will jump to 7785h, bank 2
00003954:       RET

00003955:       CALL 3AB4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 654Eh
				DEFB 2			; ..will jump to 7786h, bank 2
0000395B:       RET

0000395C:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 6021h
				DEFB 3			; ..will jump to 6040h, bank 3 (->  page the BASE ROM back in and return)
				
00003962:       LD BC,0854h
00003965:       LD HL,3DA4h
00003968:       LD A,(HL)
00003969:       OUT (C),A
0000396B:       INC HL
0000396C:       LD A,(HL)
0000396D:       OUT (C),A
0000396F:       INC HL
00003970:       INC C
00003971:       DJNZ -0Bh
00003973:       RET

00003974:       NOP
00003975:       LD A,FFh
00003977:       CALL EDF6h
0000397A:       LD (EF16h),A
0000397D:       LD A,(EF17h)
00003980:       CP 00h
00003982:       JP Z,3A2Dh
00003985:       LD A,(EF5Dh)
00003988:       OR A
00003989:       JR Z,+30h
0000398B:       LD HL,(EF1Eh)
0000398E:       LD A,(EF20h)
00003991:       OR L
00003992:       OR H
00003993:       JP NZ,39B6h
00003996:       LD A,F8h
00003998:       LD C,A
00003999:       LD A,05h
0000399B:       OUT (C),A
0000399D:       LD A,B4h
0000399F:       LD (EF20h),A
000039A2:       LD A,(EF20h)
000039A5:       CP B3h
000039A7:       JP NC,39A2h
000039AA:       LD A,0Fh
000039AC:       OUT (C),A
000039AE:       LD A,(EF20h)
000039B1:       CP B2h
000039B3:       JP NC,39AEh
000039B6:       LD A,0Eh
000039B8:       LD (EF20h),A

000039BB:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64E8h
				DEFB 2			; ..will jump to 71D5h, bank 2
000039C1:       RET

; test startup mode
000039C2:       PUSH BC
000039C3:       LD B,A
000039C4:       INA (31h)		; mode select DIP switches
000039C6:       RLCA			; V1/V2 mode
000039C7:       JR NC,+02h		; JP if V2 mode
000039C9:       RLCA
000039CA:       CCF
000039CB:       LD A,B
000039CC:       POP BC
000039CD:       RET

000039CE:       POP HL
000039CF:       POP HL
000039D0:       CALL 3ABEh
000039D3:       SUB 39h
000039D5:       RET

000039D6:       DI
000039D7:       PUSH HL
000039D8:       JP 4558h

000039DB:       NOP

000039DC:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64EBh
				DEFB 2			; ..will jump to 71F6h, bank 2
000039E2:       RET

000039E3:       NOP

000039E4:       DI
000039E5:       EX HL,(SP)
000039E6:       PUSH AF
000039E7:       PUSH DE
000039E8:       PUSH BC
000039E9:       LD E,(HL)		; LSB address
000039EA:       INC HL
000039EB:       LD D,(HL)		; MSB address
000039EC:       INC HL
000039ED:       LD A,(HL)		; bank number
000039EE:       AND 03h			; limit to banks 0..
000039F0:       LD B,A
000039F1:       LD A,FEh				; select ROM bank 0 (IEROM)
000039F3:       OUTA (71h)				; Extended ROM bank switching
000039F5:       INA (32h)
000039F7:       AND FCh				; Integrated expansion ROM bank selection (2 bits for EROMSL mask)
000039F9:       OR B
000039FA:       OUTA (32h)
000039FC:       EX DE,HL
000039FD:       POP BC
000039FE:       POP DE
000039FF:       POP AF
00003A00:       EX HL,(SP)
00003A01:       EI
00003A02:       RET

00003A03:       DI
00003A04:       EX HL,(SP)
00003A05:       PUSH AF
00003A06:       PUSH DE
00003A07:       PUSH BC
00003A08:       LD E,(HL)
00003A09:       INC HL
00003A0A:       LD D,(HL)
00003A0B:       LD A,FFh				; select main ROM
00003A0D:       OUTA (71h)				; Extended ROM bank switching
00003A0F:       INA (31h)		; mode select DIP switches
00003A11:       CPL
00003A12:       AND 80h				; V1/V2 mode bit
00003A14:       RLCA
00003A15:       LD B,A
00003A16:       INA (32h)
00003A18:       AND FCh				; Integrated expansion ROM bank selection (2 bits for EROMSL mask)
00003A1A:       OR B
00003A1B:       OUTA (32h)
00003A1D:       EX DE,HL
00003A1E:       POP BC
00003A1F:       POP DE
00003A20:       LD A,H
00003A21:       OR L
00003A22:       JP Z,3A29h			; if HL=0, then just return 
00003A25:       POP AF
00003A26:       EX HL,(SP)			; ..otherwise jp to the given address
00003A27:       EI
00003A28:       RET

00003A29:       POP AF
00003A2A:       POP HL
00003A2B:       EI
00003A2C:       RET

00003A2D:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64EEh
				DEFB 2			; ..will jump to 7247h, bank 2
00003A33:       RET

00003A34:       NOP

; continued from $3ab4
00003A35:       EX AF,AF'
00003A36:       INA (32h)
00003A38:       LD C,A
00003A39:       INA (71h)			; get Extended ROM bank status
00003A3B:       LD (IY+13h),H
00003A3E:       LD (IY+12h),L
00003A41:       LD (IY+11h),C
00003A44:       LD (IY+10h),A
00003A47:       LD (IY+0Dh),D
00003A4A:       LD (IY+0Ch),E
00003A4D:       LD HL,3DBEh
00003A50:       LD (IY+0Fh),H
00003A53:       LD (IY+0Eh),L
00003A56:       EX AF,AF'
00003A57:       OR A
00003A58:       JP NZ,3A69h
00003A5B:       EX AF,AF'
00003A5C:       LD A,C
00003A5D:       AND FCh				; Integrated expansion ROM bank selection (2 bits for EROMSL mask)
00003A5F:       OR B
00003A60:       OUTA (32h)
00003A62:       LD A,FEh			; select ROM bank 0 (IEROM)
00003A64:       OUTA (71h)			; Extended ROM bank switching
00003A66:       JP 3A7Bh

00003A69:       EX AF,AF'
00003A6A:       INA (31h)		; mode select DIP switches
00003A6C:       CPL
00003A6D:       AND 80h				; V1/V2 mode bit
00003A6F:       RLCA
00003A70:       LD B,A
00003A71:       LD A,C
00003A72:       AND FCh				; Integrated expansion ROM bank selection (2 bits for EROMSL mask)
00003A74:       OR B
00003A75:       OUTA (32h)
00003A77:       LD A,FFh			; select main ROM
00003A79:       OUTA (71h)			; Extended ROM bank switching

00003A7B:       POP IY
00003A7D:       POP BC
00003A7E:       POP DE
00003A7F:       POP HL
00003A80:       POP AF
00003A81:       EX AF,AF'
00003A82:       POP AF
00003A83:       EX AF,AF'
00003A84:       EI
00003A85:       RET

00003A86:       NOP
00003A87:       NOP

00003A88:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64F1h
				DEFB 2			; ..will jump to 72ABh, bank 2
00003A8E:       RET

00003A8F:       LD A,(BC)
00003A90:       PUSH BC
00003A91:       LD B,A
00003A92:       INA (71h)			; save Extended ROM bank status
00003A94:       PUSH AF
00003A95:       INA (32h)
00003A97:       PUSH AF
00003A98:       LD A,FFh			; back to main ROM
00003A9A:       OUTA (71h)			; Extended ROM bank switching
00003A9C:       LD A,B
00003A9D:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00003A9E:       CP 0Dh
00003AA0:       POP BC
00003AA1:       LD A,B
00003AA2:       OUTA (32h)
00003AA4:       POP BC
00003AA5:       LD A,B
00003AA6:       OUTA (71h)			; restore Extended ROM bank status
00003AA8:       POP BC
00003AA9:       RET

00003AAA:       NOP
00003AAB:       NOP
00003AAC:       NOP

00003AAD:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64F4h
				DEFB 2			; ..will jump to 72E1h, bank 2
00003AB3:       RET

; call remote bank. follows address (word) and bank (byte)
00003AB4:       DI
00003AB5:       PUSH AF
00003AB6:       PUSH AF
00003AB7:       PUSH AF
00003AB8:       EX AF,AF'
00003AB9:       PUSH AF
00003ABA:       XOR A
00003ABB:       JP 3AC6h

00003ABE:       DI
00003ABF:       PUSH AF
00003AC0:       PUSH AF
00003AC1:       PUSH AF
00003AC2:       EX AF,AF'
00003AC3:       PUSH AF
00003AC4:       LD A,01h

; continued from $3ab4, call remote bank. follows address (word) and bank (byte)
00003AC6:       EX AF,AF'
00003AC7:       PUSH AF
00003AC8:       PUSH HL
00003AC9:       PUSH DE
00003ACA:       PUSH BC
00003ACB:       PUSH IY
00003ACD:       LD HL,0000h
00003AD0:       ADD HL,SP
00003AD1:       PUSH HL
00003AD2:       POP IY
00003AD4:       LD H,(IY+13h)
00003AD7:       LD L,(IY+12h)
00003ADA:       LD E,(HL)
00003ADB:       INC HL
00003ADC:       LD D,(HL)
00003ADD:       INC HL
00003ADE:       EX AF,AF'
00003ADF:       OR A
00003AE0:       JP NZ,3A35h
00003AE3:       EX AF,AF'
00003AE4:       LD A,(HL)
00003AE5:       INC HL
00003AE6:       AND 03h
00003AE8:       LD B,A
00003AE9:       JP 3A36h

00003AEC:       NOP

00003AED:       CALL 391Fh
00003AF0:       RET Z
00003AF1:       LD A,00h
00003AF3:       LD (EF0Fh),A
00003AF6:       RET

00003AF7:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64F7h
				DEFB 2			; ..will jump to 732Eh, bank 2
00003AFD:       RET

00003AFE:       CALL 39C2h		; test startup mode
00003B01:       LD HL,8400h
00003B04:       RET C

; HL = word @ 7FFEh, bank 2
00003B05:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 3B0Ch
				DEFB 2			; ..will switch to bank 2, then jump to 3B0Ch (just after this position)
00003B0B:       RET

00003B0C:       PUSH DE
00003B0D:       LD HL,7FFEh
00003B10:       LD E,(HL)
00003B11:       INC HL
00003B12:       LD D,(HL)
00003B13:       EX DE,HL
00003B14:       POP DE
00003B15:       RET


00003B16:       NOP


00003B17:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64FAh
				DEFB 2			; ..will jump to 734Eh, bank 2
00003B1D:       RET

00003B1E:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64A9h
				DEFB 2			; ..will jump to 6554h, bank 2
00003B24:       RET

00003B25:       CALL 18A3h			; GETINT
00003B28:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64B5h
				DEFB 2			; ..will jump to 65D6h, bank 2

00003B2E:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64C1h
				DEFB 2			; ..will jump to 681Eh, bank 2
00003B34:       RET

00003B35:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64C4h
				DEFB 2			; ..will jump to 6830h, bank 2
00003B3B:       RET

00003B3C:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64C7h
				DEFB 2			; ..will jump to 685Dh, bank 2
00003B42:       RET

00003B43:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64CAh
				DEFB 2			; ..will jump to 68A5h, bank 2
00003B49:       RET

00003B4A:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64CDh
				DEFB 2			; ..will jump to 6977h, bank 2

00003B50:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64D0h
				DEFB 2			; ..will jump to 69A3h, bank 2

00003B56:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64D3h
				DEFB 2			; ..will jump to 6A1Eh, bank 2

00003B5C:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64D6h
				DEFB 2			; ..will jump to 6A9Ah, bank 2

00003B62:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64BBh
				DEFB 2			; ..will jump to 66F7h, bank 2
				
00003B68:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64BEh
				DEFB 2			; ..will jump to 676Eh, bank 2

00003B6E:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 6533h
				DEFB 2			; ..will jump to 7787h, bank 2

00003B74:       RET NC
00003B75:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00003B76:       RET C
00003B77:       POP AF
00003B78:       LD A,L
00003B79:       SUB 0Ch
00003B7B:       LD L,A
00003B7C:       JP 3BC6h


00003B7F:       NOP


00003B80:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64FDh
				DEFB 2			; ..will jump to 73B7h, bank 2
00003B86:       RET

00003B87:       EX HL,(SP)
00003B88:       POP HL
00003B89:       CP 7Fh
00003B8B:       JP NZ,1220h
00003B8E:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00003B8F:       JP C,1279h
00003B92:       CALL 20CDh			; STAKFP - Put FP value on stack
00003B95:       LD HL,(EC3Dh)
00003B98:       PUSH HL
00003B99:       LD HL,(EC3Fh)
00003B9C:       PUSH HL
00003B9D:       LD BC,3BA5h
00003BA0:       LD D,7Fh
00003BA2:       JP 1259h

00003BA5:       CALL 223Eh			; CDBL
00003BA8:       CALL 2124h			; FP_ARG2HL
00003BAB:       POP HL
00003BAC:       LD (EC3Fh),HL
00003BAF:       POP HL
00003BB0:       LD (EC3Dh),HL
00003BB3:       POP BC
00003BB4:       POP DE
00003BB5:       CALL 20DDh			; FPBCDE - Move BCDE to FPREG

00003BB8:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64D9h
				DEFB 2			; ..will jump to 6AFAh, bank 2
00003BBE:       RET

00003BBF:       PUSH DE
00003BC0:       CALL 2214h		; CSNG - Convert number to single precision
00003BC3:       JP 132Dh

00003BC6:       LD DE,1404h		; point to POP HL / RET instructions
00003BC9:       PUSH DE

00003BCA:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 64DCh
				DEFB 2			; ..will jump to 6AFDh, bank 2
00003BD0:       RET

; Boot in N88-BASIC mode
00003BD1:       LD A,FFh
00003BD3:       OUTA (53h)		; Screen display control: hide all
00003BD5:       JR +1Ch

00003BD7:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6500h
				DEFB 2			; ..will jump to 740Eh, bank 2
00003BDD:       RET

; FN_POINT
00003BDE:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6518h
				DEFB 2			; ..will jump to 709Ch, bank 2
00003BE4:       RET


;
; START
;

00003BE5:       INA (30h)		; Mode select (dip switch state)
00003BE7:       RRCA			; move to CY..  0: N-BASIC, 1: N88-BASIC
00003BE8:       JR NC,+09h		; Boot in N-BASIC mode
00003BEA:       JR -1Bh			; Boot in N88-BASIC mode

00003BEC:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6503h
				DEFB 2			; ..will jump to 7423h, bank 2
00003BF2:       RET

; Boot in N-BASIC mode
00003BF3:       INA (31h)		; mode select DIP switches
00003BF5:       RLCA			; V1/V2 mode bit
00003BF6:       JP NC,3D7Bh		; Reset and init memory BANK paging

00003BF9:       RLCA
00003BFA:       JP NC,3D71h		; Init memory BANK paging (A=98h)
00003BFD:       JP 3D6Eh		; Init memory BANK paging (A=88h)

00003C00:       NOP

00003C01:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6506h
				DEFB 2			; ..will jump to 7438h, bank 2
00003C07:       RET

00003C08:       INA (21h)		; USART (uPD8251C) Control port
00003C0A:       AND 05h
00003C0C:       CP 05h
00003C0E:       RET

00003C0F:       LD BC,0404h
00003C12:       RLCA
00003C13:       RLCA
00003C14:       RLCA
00003C15:       RLCA
00003C16:       RRCA
00003C17:       OUTA (10h)		; 
00003C19:       PUSH AF
00003C1A:       CALL 3C27h
00003C1D:       POP AF
00003C1E:       DJNZ -0Ah
00003C20:       LD A,07h
00003C22:       OUTA (10h)
00003C24:       LD C,02h
00003C26:       RET

00003C27:       DI
00003C28:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
00003C2B:       AND F9h				; 11111001, calendar clock
00003C2D:       OR C
00003C2E:       OUTA (40h)
00003C30:       AND F9h				; 11111001, calendar clock
00003C32:       OUTA (40h)			; strobe port
00003C34:       LD (E6C1h),A		; enable/status FLAGS for port 40h
00003C37:       EI
00003C38:       RET

00003C39:       ADD HL,DE
00003C3A:       EX DE,HL
00003C3B:       POP HL
00003C3C:       JP C,0B06h			; FCERR, Err $05 - "Illegal function call"
00003C3F:       JP 7CA8h

00003C42:       XOR A
00003C43:       LD B,03h
00003C45:       OUTA (21h)		; USART (uPD8251C) Control port
00003C47:       CALL 3C50h
00003C4A:       DJNZ -07h
00003C4C:       LD A,40h
00003C4E:       OUTA (21h)		; USART (uPD8251C) Control port
00003C50:       RET


00003C51:       NOP
00003C52:       NOP
00003C53:       NOP
00003C54:       NOP
00003C55:       NOP
00003C56:       NOP
00003C57:       NOP
00003C58:       NOP
00003C59:       NOP
00003C5A:       NOP
00003C5B:       NOP
00003C5C:       NOP
00003C5D:       NOP
00003C5E:       NOP
00003C5F:       NOP
00003C60:       NOP
00003C61:       NOP
00003C62:       NOP
00003C63:       NOP
00003C64:       NOP
00003C65:       NOP
00003C66:       NOP
00003C67:       NOP
00003C68:       NOP
00003C69:       NOP
00003C6A:       NOP
00003C6B:       NOP
00003C6C:       NOP
00003C6D:       NOP
00003C6E:       NOP
00003C6F:       NOP
00003C70:       NOP


00003C71:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6545h
				DEFB 2			; ..will jump to 74B2h, bank 2
00003C77:       RET

00003C78:       XOR A
00003C79:       JP 6FD1h		; set 25 lines High Resolution mode

00003C7C:       LDDR
00003C7E:       RET

00003C7F:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6548h
				DEFB 2			; ..will jump to 74C0h, bank 2
00003C85:       RET

00003C86:       LD HL,79BEh		; "NEC N-88 BASIC Version 1.9..Copyright (C) 1981 by Microsoft.."
00003C89:       JR +03h

00003C8B:       LD HL,79D9h		; 0Ah,"Copyright (C) 1981 by Microsoft",0Dh,0Ah (portion of the above message)
00003C8E:       CALL 5550h			; PRS - Print message pointed by HL
00003C91:       RET

00003C92:       NOP
00003C93:       NOP

00003C94:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 654Bh
				DEFB 2			; ..will jump to 74D5h, bank 2
00003C9A:       RET

00003C9B:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 3C2Ah
				DEFB 2			; ..will set bank 2 and jump to 3C2Ah.
00003CA1:       RET

00003CA2:       LD A,(HL)
00003CA3:       RET


00003CA4:       NOP
00003CA5:       NOP
00003CA6:       NOP
00003CA7:       NOP
00003CA8:       NOP
00003CA9:       NOP
00003CAA:       NOP
00003CAB:       NOP


; FDINT_2 handler
00003CAC:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 6509h
				DEFB 2			; ..will jump to 74EDh, bank 2
00003CB2:       RET


00003CB3:       LD A,11h
00003CB5:       OUTA (21h)		; USART (uPD8251C) Control port
00003CB7:       RET

00003CB8:       NOP

; FDINT_1 handler
00003CB9:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
				DEFW 650Ch
				DEFB 2			; ..will jump to 74FAh, bank 2
00003CBF:       RET

; Init JP table at HL, B entries.   Set all with the default pointer in DE
00003CC0:       LD (HL),C3h		; JP instruction
00003CC2:       INC HL
00003CC3:       LD (HL),E
00003CC4:       INC HL
00003CC5:       LD (HL),D
00003CC6:       INC HL
00003CC7:       DJNZ -09h

00003CC9:       LD HL,3CFFh
00003CCC:       LD B,0Fh
00003CCE:       LD E,(HL)
00003CCF:       INC HL
00003CD0:       LD D,(HL)
00003CD1:       INC HL
00003CD2:       PUSH DE
00003CD3:       LD E,(HL)
00003CD4:       INC HL
00003CD5:       LD D,(HL)
00003CD6:       INC HL
00003CD7:       EX HL,(SP)
00003CD8:       LD (HL),C3h		; JP instruction
00003CDA:       INC HL
00003CDB:       LD (HL),E
00003CDC:       INC HL
00003CDD:       LD (HL),D
00003CDE:       EX HL,(SP)
00003CDF:       POP DE
00003CE0:       DJNZ -14h

; Init JP table at $EE2E ($16 entries)
00003CE2:       LD HL,EE2Fh
00003CE5:       LD DE,3D3Bh
00003CE8:       LD BC,1602h
00003CEB:       INC HL
00003CEC:       LD A,(DE)
00003CED:       LD (HL),A
00003CEE:       INC HL
00003CEF:       INC DE
00003CF0:       DEC C
00003CF1:       JR NZ,-07h
00003CF3:       LD C,02h
00003CF5:       DJNZ -0Ch
00003CF7:       INA (31h)		; mode select DIP switches
00003CF9:       AND 80h			; V1/V2 mode bit
00003CFB:       JP Z,3D94h
00003CFE:       RET

00003CFF:       RET Z
00003D00:       XOR 1Eh
00003D02:       DEC SP
00003D03:       CP H
00003D04:       XOR 25h
00003D06:       DEC SP
00003D07:       LD A,L
00003D08:       XOR 43h
00003D0A:       DEC SP
00003D0B:       ADD B
00003D0C:       XOR 4Ah
00003D0E:       DEC SP
00003D0F:       ADD E
00003D10:       XOR 50h
00003D12:       DEC SP
00003D13:       ADD (HL)
00003D14:       XOR 5Ch
00003D16:       DEC SP
00003D17:       ADC C
00003D18:       XOR 56h
00003D1A:       DEC SP
00003D1B:       OUTA (ECh)
00003D1D:       DEC (HL)
00003D1E:       DEC SP
00003D1F:       SUB ECh
00003D21:       LD L,3Bh
00003D23:       JP PO,68ECh
00003D26:       DEC SP
00003D27:       PUSH HL
00003D28:       CALL PE,3B62h
00003D2B:       LD B,D
00003D2C:       DB EDh,3Ch
00003D2E:       DEC SP
00003D2F:       LD E,D
00003D30:       DB EDh,74h
00003D32:       DEC SP
00003D33:       LD (HL),L
00003D34:       DB EDh,87h
00003D36:       DEC SP
00003D37:       DI
00003D38:       DB EDh,CEh
00003D3A:       ADD HL,SP



; word jp table ($16 entries) is moved from 3D3Bh to EE2Fh (with jp prefix), 

00003D3B:       DEFW    $6F37  -> $EE2E + 1
00003D3D:       DEFW    $483D  -> $EE31 + 1		; CLOSE_0
00003D3F:       DEFW    $6F3F  -> $EE34 + 1
00003D41:       DEFW    $0DF7  -> $EE37 + 1
00003D43:       DEFW    $0B06  -> $EE3A + 1		; FCERR, Err $05 - "Illegal function call"
00003D45:       DEFW    $0B06  -> $EE3D + 1		; FCERR, Err $05 - "Illegal function call"
00003D47:       DEFW    $0B06  -> $EE40 + 1		; FCERR, Err $05 - "Illegal function call"
00003D49:       DEFW    $0B06  -> $EE43 + 1		; FCERR, Err $05 - "Illegal function call"
00003D4B:       DEFW    $0B06  -> $EE46 + 1		; FCERR, Err $05 - "Illegal function call"
00003D4D:       DEFW    $0B06  -> $EE49 + 1		; FCERR, Err $05 - "Illegal function call"
00003D4F:       DEFW    $0B06  -> $EE4C + 1		; FCERR, Err $05 - "Illegal function call"
00003D51:       DEFW    $0DDB  -> $EE4F + 1
00003D53:       DEFW    $483D  -> $EE52 + 1		; CLOSE_0
00003D55:       DEFW    $6F1E  -> $EE55 + 1
00003D57:       DEFW    $0B06  -> $EE58 + 1		; FCERR, Err $05 - "Illegal function call"
00003D59:       DEFW    $6F12  -> $EE5B + 1
00003D5B:       DEFW    $0DF0  -> $EE5E + 1
00003D5D:       DEFW    $0B06  -> $EE61 + 1		; FCERR, Err $05 - "Illegal function call"
00003D5F:       DEFW    $0B06  -> $EE64 + 1		; FCERR, Err $05 - "Illegal function call"
00003D61:       DEFW    $0B06  -> $EE67 + 1		; FCERR, Err $05 - "Illegal function call"
00003D63:       DEFW    $0DE6  -> $EE6A + 1
00003D65:       DEFW    $0B06  -> $EE6D + 1		; FCERR, Err $05 - "Illegal function call"


00003D67:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
00003D6A:       RRCA
00003D6B:       LD H,L
00003D6C:       LD (BC),A
00003D6D:       RET

; Init memory BANK paging
00003D6E:       LD A,88h
00003D70:       DEFB 21h  ;LD HL,983Eh (hide the following instruction)
00003D71:		LD A,98h

00003D73:       OUTA (32h)
00003D75:       CALL 043Dh			; ROM BANK select
00003D78:       JP 77F7h			; MAIN BASIC entry

; Reset and init memory BANK paging
00003D7B:       LD A,A8h
00003D7D:       OUTA (32h)
00003D7F:       LD A,80h
00003D81:       OUTA (54h)
00003D83:       LD A,C0h
00003D85:       OUTA (54h)
00003D87:       CALL 3962h
00003D8A:       JR -17h

00003D8C:       NOP

00003D8D:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
00003D90:       LD (DE),A
00003D91:       LD H,L
00003D92:       LD (BC),A
00003D93:       RET

00003D94:       LD HL,847Dh
00003D97:       XOR A
00003D98:       LD (HL),0Fh
00003D9A:       INC HL
00003D9B:       LD (HL),A
00003D9C:       INC HL
00003D9D:       LD (HL),C9h
00003D9F:       INC HL
00003DA0:       LD (HL),A
00003DA1:       INC HL
00003DA2:       LD (HL),A
00003DA3:       RET

00003DA4:       NOP
00003DA5:       LD B,B
00003DA6:       RLCA
00003DA7:       LD B,B
00003DA8:       SCF
00003DA9:       LD B,B
00003DAA:       CCF
00003DAB:       LD B,B
00003DAC:       NOP
00003DAD:       LD B,A
00003DAE:       RLCA
00003DAF:       LD B,A
00003DB0:       SCF
00003DB1:       LD B,A
00003DB2:       CCF
00003DB3:       LD B,A
00003DB4:       NOP
00003DB5:       NOP
00003DB6:       NOP

00003DB7:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
00003DBA:       DEC D
00003DBB:       LD H,L
00003DBC:       LD (BC),A
00003DBD:       RET

00003DBE:       DI
00003DBF:       EX HL,(SP)
00003DC0:       PUSH AF
00003DC1:       LD A,H
00003DC2:       OUTA (32h)
00003DC4:       LD A,L				; ROM bank mask ($FF or only one bit must be reset)
00003DC5:       OUTA (71h)			; Extended ROM bank switching
00003DC7:       POP AF
00003DC8:       POP HL
00003DC9:       EI
00003DCA:       RET

00003DCB:       PUSH DE
00003DCC:       LD HL,EF64h
00003DCF:       LD E,A
00003DD0:       LD D,00h
00003DD2:       ADD HL,DE
00003DD3:       LD A,(HL)
00003DD4:       LD (EF5Dh),A
00003DD7:       POP DE
00003DD8:       RET

00003DD9:       LD HL,EF60h
00003DDC:       LD A,(EC85h)		; current drive number
00003DDF:       OR A
00003DE0:       RET Z
00003DE1:       CP (HL)
00003DE2:       RET C
00003DE3:       SUB (HL)
00003DE4:       INC HL
00003DE5:       CP (HL)
00003DE6:       RET C
00003DE7:       SUB (HL)
00003DE8:       RET

00003DE9:       PUSH BC
00003DEA:       CALL EDFFh
00003DED:       LD B,A
00003DEE:       XOR A
00003DEF:       LD (EF15h),A
00003DF2:       LD A,(EF5Dh)
00003DF5:       CP 02h
00003DF7:       LD A,B
00003DF8:       JR Z,+11h
00003DFA:       CP 01h
00003DFC:       JR NZ,+04h
00003DFE:       LD A,11h
00003E00:       JR +06h
00003E02:       CP 03h
00003E04:       JR NZ,+05h
00003E06:       LD A,12h
00003E08:       LD (EF15h),A
00003E0B:       POP BC
00003E0C:       RET

; output character to console
00003E0D:       PUSH BC
00003E0E:       PUSH DE
00003E0F:       PUSH HL
00003E10:       PUSH AF
00003E11:       CALL 428Bh		; Cursor off
00003E14:       LD B,A
00003E15:       LD A,(E6B6h)			; PrintCtrlCode
00003E18:       OR A
00003E19:       JR Z,+08h
00003E1B:       XOR 19h
00003E1D:       LD (E6B6h),A			; PrintCtrlCode
00003E20:       LD A,B
00003E21:       JR +05h
00003E23:       LD A,B
00003E24:       CP 20h		; ' '
00003E26:       JR C,+27h
00003E28:       CALL 6220h
00003E2B:       CALL 447Dh
00003E2E:       POP AF
00003E2F:       PUSH AF
00003E30:       CP 0Ah
00003E32:       JR NZ,+0Ah
00003E34:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00003E37:       LD H,01h
00003E39:       LD (EF86h),HL			; CSRY (CursorPos) - current text position
00003E3C:       JR +11h

00003E3E:       POP AF
00003E3F:       LD B,A
00003E40:       LD A,(E6B6h)			; PrintCtrlCode
00003E43:       CP 19h
00003E45:       LD A,B
00003E46:       JR Z,+03h
00003E48:       LD (EF8Fh),A
00003E4B:       POP HL
00003E4C:       POP DE
00003E4D:       POP BC
00003E4E:       RET

00003E4F:       CP 19h
00003E51:       JR Z,+3Fh
00003E53:       CP 1Ch
00003E55:       JR NC,+27h
00003E57:       CP 07h			; BEL
00003E59:       JR NZ,+05h
00003E5B:       CALL 3E9Bh		; CONSOLE BEEP SOUND
00003E5E:       JR -22h

00003E60:       CP 08h
00003E62:       JR Z,+33h
00003E64:       CP 0Ah
00003E66:       JR C,-2Ah
00003E68:       JR NZ,+0Eh
00003E6A:       LD A,(EF8Fh)
00003E6D:       CP 0Dh
00003E6F:       LD A,0Ah
00003E71:       JR NZ,+05h
00003E73:       LD DE,5E17h
00003E76:       JR +11h
00003E78:       CP 0Eh
00003E7A:       JR NC,-3Eh
00003E7C:       ADD 0Eh
00003E7E:       LD HL,5DA5h
00003E81:       ADD A
00003E82:       LD C,A
00003E83:       LD B,00h
00003E85:       ADD HL,BC
00003E86:       LD E,(HL)
00003E87:       INC HL
00003E88:       LD D,(HL)
00003E89:       LD BC,3E3Eh
00003E8C:       PUSH BC
00003E8D:       PUSH DE
00003E8E:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00003E91:       RET

00003E92:       LD (E6B6h),A			; PrintCtrlCode
00003E95:       JR -59h
00003E97:       LD A,1Dh
00003E99:       JR -1Dh

; CONSOLE BEEP SOUND
00003E9B:       LD A,(E6C1h) 		; enable/status FLAGS for port 40h
00003E9E:       AND 20h
00003EA0:       XOR 20h			; turn beeper on
00003EA2:       PUSH AF
00003EA3:       CALL 3EC0h		; BEEPER control
00003EA6:       LD HL,61A8h		; loop 25000 times to delay
00003EA9:       INC HL
00003EAA:       LD A,H
00003EAB:       OR L
00003EAC:       JR NZ,-05h
00003EAE:       POP AF
00003EAF:       XOR 20h			; turn beeper off
00003EB1:       JP 3EC0h		; BEEPER control

_BEEP:
00003EB4:       JR NZ,+06h
00003EB6:       LD A,07h
00003EB8:       CALL 3E0Dh		; output character to console
00003EBB:       RET

00003EBC:       CALL 18A3h			; GETINT
00003EBF:       LD A,E

; BEEPER control
00003EC0:       AND A
00003EC1:       JR Z,+02h
00003EC3:       LD A,20h			; beeper bit
00003EC5:       LD E,A
00003EC6:       DI
00003EC7:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
00003ECA:       AND DFh				; 11011111 - beeper
00003ECC:       OR E
00003ECD:       LD (E6C1h),A		; enable/status FLAGS for port 40h
00003ED0:       OUTA (40h)			; strobe port
00003ED2:       EI
00003ED3:       RET

LPTOUT:
00003ED4:       PUSH AF
00003ED5:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00003ED8:       JR C,+17h
00003EDA:       INA (40h)
00003EDC:       AND 01h				; bit for printer strobe
00003EDE:       JR NZ,-0Bh
00003EE0:       POP AF
00003EE1:       OUTA (10h)			; Printer data output
00003EE3:       PUSH AF
00003EE4:       DI
00003EE5:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
00003EE8:       AND FEh				; 11111110  mask for printer strobe
00003EEA:       OUTA (40h)			; strobe port
00003EEC:       OR 01h				; bit for printer strobe
00003EEE:       OUTA (40h)			; strobe port
00003EF0:       EI
00003EF1:       POP AF
00003EF2:       RET

00003EF3:       PUSH AF
00003EF4:       LD A,(E6CAh)		; INTFLG
00003EF7:       PUSH AF
00003EF8:       XOR A
00003EF9:       LD (E6CAh),A		; INTFLG
00003EFC:       PUSH HL
00003EFD:       LD HL,(E6E9h)
00003F00:       LD A,H
00003F01:       OR L
00003F02:       JR Z,+1Ch
00003F04:       INC HL
00003F05:       XOR A
00003F06:       CALL 3ED4h		; LPTOUT
00003F09:       DEC HL
00003F0A:       LD A,H
00003F0B:       OR L
00003F0C:       JR NZ,-09h
00003F0E:       LD (E6E9h),HL
00003F11:       LD A,4Eh		; 'N' - Select skip over perforation (n=1..127)
00003F13:       CALL 3F27h		; Output ESC + value in A to LPT
00003F16:       LD A,41h		; 'A'?  ..65???
00003F18:       CALL 3F27h		; Output ESC + value in A to LPT ???
00003F1B:       LD A,4Dh		; 'M', 
00003F1D:       CALL 3F27h		; Output ESC + value in A to LPT
00003F20:       POP HL
00003F21:       POP AF
00003F22:       LD (E6CAh),A		; INTFLG
00003F25:       POP AF
00003F26:       RET

; Output ESC + value in A to LPT
00003F27:       PUSH AF
00003F28:       LD A,1Bh
00003F2A:       CALL 3ED4h		; LPTOUT
00003F2D:       POP AF
00003F2E:       JP 3ED4h		; LPTOUT

00003F31:       PUSH HL
00003F32:       PUSH DE
00003F33:       PUSH BC
00003F34:       LD A,(EF86h)			; CSRY (CursorPos) - current text position
00003F37:       DEC A
00003F38:       CALL 20B6h				; INT_RESULT_A - Get back from function, result in A (signed)
00003F3B:       POP BC
00003F3C:       POP DE
00003F3D:       POP HL
00003F3E:       RET

00003F3F:       LD A,04h
00003F41:       CALL 4015h
00003F44:       AND 01h
00003F46:       RET Z
00003F47:       INA (51h)		; CRTC
00003F49:       AND 01h
00003F4B:       RET Z
00003F4C:       CALL 3F62h
00003F4F:       EX DE,HL
00003F50:       LD HL,(EF81h)
00003F53:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00003F54:       RET Z
00003F55:       EX DE,HL
00003F56:       LD (EF81h),HL
00003F59:       LD A,04h
00003F5B:       CALL 4015h
00003F5E:       CALL 5012h
00003F61:       RET

00003F62:       LD A,60h		; "READ LIGHT PEN" command ?
00003F64:       DI
00003F65:       OUTA (51h)		; Output command to CRTC
00003F67:       INA (50h)		; CRTC
00003F69:       LD HL,E6AEh
00003F6C:       OR A
00003F6D:       JP P,3F71h
00003F70:       INC HL
00003F71:       SUB (HL)
00003F72:       LD H,A
00003F73:       INA (50h)		; CRTC
00003F75:       EI
00003F76:       LD L,A
00003F77:       OR A
00003F78:       RET

00003F79:       XOR A
00003F7A:       LD (EF90h),A
00003F7D:       LD B,A
00003F7E:       JR +0Ah
00003F80:       LD B,A
00003F81:       LD A,(EF90h)
00003F84:       CP B
00003F85:       RET Z
00003F86:       LD A,B
00003F87:       LD (EF90h),A
00003F8A:       LD A,(E6B8h)		; Function key bottom bar enable flag
00003F8D:       AND A
00003F8E:       RET Z
00003F8F:       LD A,FFh
00003F91:       LD (E6CDh),A
00003F94:       LD A,(E69Fh)
00003F97:       AND A
00003F98:       JR Z,+06h
00003F9A:       LD A,B
00003F9B:       OR A
00003F9C:       JR Z,+02h
00003F9E:       LD B,0Ah
00003FA0:       PUSH HL
00003FA1:       LD A,B
00003FA2:       PUSH AF
00003FA3:       SCF
00003FA4:       CALL 4021h		; Clean bottom text row
00003FA7:       LD L,A
00003FA8:       LD H,03h
00003FAA:       LD BC,0106h
00003FAD:       LD A,(EF89h)	; WIDTH
00003FB0:       CP 29h		; 40+1
00003FB2:       JR C,+05h
00003FB4:       LD H,06h
00003FB6:       LD BC,020Ch
00003FB9:       PUSH BC
00003FBA:       PUSH HL
00003FBB:       DEC H
00003FBC:       LD B,H
00003FBD:       LD H,01h
00003FBF:       CALL 4005h
00003FC2:       POP HL
00003FC3:       POP BC
00003FC4:       POP AF
00003FC5:       LD D,A
00003FC6:       LD E,05h
00003FC8:       PUSH DE
00003FC9:       PUSH BC
00003FCA:       PUSH BC
00003FCB:       PUSH HL
00003FCC:       LD A,D
00003FCD:       CALL 34D8h
00003FD0:       JR NC,+02h
00003FD2:       LD A,20h
00003FD4:       POP HL
00003FD5:       PUSH HL
00003FD6:       LD B,A
00003FD7:       LD A,04h
00003FD9:       CALL 448Ah
00003FDC:       POP HL
00003FDD:       INC H
00003FDE:       POP BC
00003FDF:       DEC C
00003FE0:       JR Z,+09h
00003FE2:       PUSH BC
00003FE3:       PUSH HL
00003FE4:       CALL 34EAh
00003FE7:       JR NC,-15h
00003FE9:       JR -19h
00003FEB:       CALL 4005h
00003FEE:       POP BC
00003FEF:       POP DE
00003FF0:       DEC E
00003FF1:       JR Z,+03h
00003FF3:       INC D
00003FF4:       JR -2Eh
00003FF6:       XOR A
00003FF7:       LD B,20h
00003FF9:       CALL 448Ah
00003FFC:       XOR A
00003FFD:       LD (E6CEh),A
00004000:       LD (E6CDh),A
00004003:       POP HL
00004004:       RET

00004005:       PUSH HL
00004006:       PUSH BC
00004007:       XOR A
00004008:       LD B,20h
0000400A:       CALL 448Ah
0000400D:       POP BC
0000400E:       POP HL
0000400F:       INC H
00004010:       DJNZ -0Dh
00004012:       RET

00004013:       ADD 07h

00004015:       LD C,A
00004016:       RLCA
00004017:       ADD C
00004018:       LD C,A
00004019:       LD B,00h
0000401B:       LD HL,(E6EFh)
0000401E:       ADD HL,BC
0000401F:       LD A,(HL)
00004020:       RET

; Clean bottom text row
00004021:       LD A,(EF88h)	; HEIGHT (TextHeight)
00004024:       PUSH HL
00004025:       PUSH AF
00004026:       LD L,A
00004027:       CALL 431Eh		; Find text row address
0000402A:       POP AF
0000402B:       PUSH AF
0000402C:       CALL C,4035h		; Save 'AttributeCode' and Init text row pointed by HL=DE
0000402F:       CALL NC,42E9h		; copy bottom text line (and attributes) to DE
00004032:       POP AF
00004033:       POP HL
00004034:       RET

; Save 'AttributeCode' and Init text row pointed by HL=DE
00004035:       LD A,(E6B4h)		; AttributeCode
00004038:       PUSH AF
00004039:       XOR A
0000403A:       LD (E6B4h),A		; AttributeCode
0000403D:       LD H,D
0000403E:       LD L,E
0000403F:       CALL 42BEh			; Init text row pointed by HL=DE
00004042:       POP AF
00004043:       LD (E6B4h),A		; AttributeCode
00004046:       RET

00004047:       LD A,03h
00004049:       CALL 408Ah
0000404C:       LD A,01h
0000404E:       CALL 408Ah
00004051:       LD HL,F00Dh
00004054:       CALL 4069h
00004057:       LD A,03h
00004059:       CALL 408Ah
0000405C:       LD A,(F011h)
0000405F:       RRCA
00004060:       RRCA
00004061:       RRCA
00004062:       RRCA
00004063:       AND 0Fh
00004065:       LD (F011h),A
00004068:       RET

00004069:       LD D,06h
0000406B:       CALL 4073h
0000406E:       INC HL
0000406F:       DEC D
00004070:       JR NZ,-07h
00004072:       RET

00004073:       LD BC,0804h		; B=8, C=4
00004076:       LD E,00h
00004078:       INA (40h)
0000407A:       RRCA
0000407B:       RRCA
0000407C:       RRCA
0000407D:       RRCA
0000407E:       AND 01h			;  	CDI - Data from the calendar clock (֐D 1990AC)
00004080:       OR E
00004081:       RRCA
00004082:       LD E,A
00004083:       CALL 408Eh
00004086:       DJNZ -10h
00004088:       LD (HL),E
00004089:       RET

0000408A:       CALL 3C0Fh
0000408D:       NOP
0000408E:       DI
0000408F:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
00004092:       AND F9h				; 11111001, calendar clock
00004094:       OR C
00004095:       OUTA (40h)			; strobe port
00004097:       PUSH AF
00004098:       LD A,2Dh
0000409A:       DEC A
0000409B:       JR NZ,-03h
0000409D:       POP AF
0000409E:       AND F9h				; 11111001, calendar clock
000040A0:       OUTA (40h)			; strobe port
000040A2:       LD (E6C1h),A		; enable/status FLAGS for port 40h
000040A5:       EI
000040A6:       RET

000040A7:       LD A,(HL)
000040A8:       INC HL
000040A9:       CP 3Ah		; ':'
000040AB:       JP NC,0393h			;  SNERR - entry for '?SN ERROR'
000040AE:       SUB 30h
000040B0:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
000040B3:       RET

000040B4:       CALL 56CCh		; GSTRCU - Get string pointed by FPREG
000040B7:       LD A,(HL)
000040B8:       CP 08h
000040BA:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
000040BD:       INC HL
000040BE:       LD E,(HL)
000040BF:       INC HL
000040C0:       LD D,(HL)
000040C1:       EX DE,HL
000040C2:       RET

000040C3:       CALL 40A7h
000040C6:       RRCA
000040C7:       RRCA
000040C8:       RRCA
000040C9:       RRCA
000040CA:       LD B,A
000040CB:       CALL 40A7h
000040CE:       OR B
000040CF:       RET

000040D0:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000040D1:       POP AF	; DEFB TK_EQUAL..  Token for '='
000040D2:       CALL 11D3h			; EVAL - evaluate expression
000040D5:       PUSH HL
000040D6:       CALL 4047h
000040D9:       CALL 40B4h
000040DC:       CALL 40C3h
000040DF:       LD (F00Fh),A
000040E2:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000040E3:       DEFB ':'
000040E4:       CALL 40C3h
000040E7:       LD (F00Eh),A
000040EA:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000040EB:       DEFB ':'
000040EC:       CALL 40C3h
000040EF:       LD (F00Dh),A
000040F2:       POP HL
000040F3:       RET

000040F4:       OR A
000040F5:       JR NZ,+04h
000040F7:       CALL 40FFh
000040FA:       RET

000040FB:       CALL 4110h
000040FE:       RET

000040FF:       LD A,12h
00004101:       CALL 4015h
00004104:       CALL 4FE5h
00004107:       LD A,13h
00004109:       CALL 4015h
0000410C:       CALL 4FE5h
0000410F:       RET

00004110:       LD A,12h
00004112:       CALL 4015h
00004115:       CALL 4FF5h		; A=(HL), (HL)=0
00004118:       LD A,13h
0000411A:       CALL 4015h
0000411D:       CALL 4FF5h		; A=(HL), (HL)=0
00004120:       RET

00004121:       DEC HL
00004122:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004123:       CALL 1895h				; FPSINT - Get subscript
00004126:       LD A,D
00004127:       OR E
00004128:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
0000412B:       EX DE,HL
0000412C:       LD (EFC6h),HL
0000412F:       LD (EFC4h),HL
00004132:       LD A,01h
00004134:       LD (E6C6h),A
00004137:       LD A,3Ch
00004139:       LD (EFC8h),A
0000413C:       EX DE,HL
0000413D:       CALL 4250h
00004140:       RST 08h
00004141:       DEFB ','
00004142:       RET

; 1/600 second timer interrupt handler
00004143:       PUSH BC
00004144:       PUSH DE
00004145:       LD A,(E6C3h)	; Value being sent to port E4h
00004148:       PUSH AF
00004149:       LD A,02h
0000414B:       OUTA (E4h)		; set interrupt levels to disable also "the 1/600 second timer interrupt"
0000414D:       LD (E6C3h),A	; Value being sent to port E4h
00004150:       EI
00004151:       LD A,(E6C6h)
00004154:       OR A
00004155:       JR Z,+24h
00004157:       LD A,(EFC8h)
0000415A:       DEC A
0000415B:       LD (EFC8h),A
0000415E:       JR NZ,+1Bh
00004160:       LD A,3Ch		; 3C0000h / 600 = 6553
00004162:       LD (EFC8h),A
00004165:       LD HL,(EFC6h)
00004168:       DEC HL
00004169:       LD (EFC6h),HL
0000416C:       LD A,H
0000416D:       OR L
0000416E:       JR NZ,+0Bh
00004170:       DEC A
00004171:       LD (E6C6h),A
00004174:       LD E,01h
00004176:       DI
00004177:       CALL 3126h
0000417A:       EI
0000417B:       LD A,(E6C7h)
0000417E:       OR A
0000417F:       JR Z,+27h
00004181:       LD HL,(EFC9h)
00004184:       DEC HL
00004185:       LD (EFC9h),HL
00004188:       LD A,H
00004189:       OR L
0000418A:       JR NZ,+1Ch
0000418C:       LD HL,04B0h		; 1200
0000418F:       LD (EFC9h),HL
00004192:       LD HL,(EFCBh)
00004195:       DEC HL
00004196:       LD (EFCBh),HL
00004199:       LD A,H
0000419A:       OR L
0000419B:       JR NZ,+0Bh		; 	..every 2 seconds ?

0000419D:       LD (E6C7h),A
000041A0:       LD A,05h
000041A2:       CALL 4015h
000041A5:       CALL 5012h
000041A8:       CALL 41BBh
000041AB:       CALL 41E3h
000041AE:       CALL Z,4242h
000041B1:       POP AF
000041B2:       LD (E6C3h),A	; Value being sent to port E4h
000041B5:       OUTA (E4h)		; restore interrupt levels
000041B7:       POP DE
000041B8:       POP BC
000041B9:       EI
000041BA:       RET

000041BB:       LD A,F8h
000041BD:       LD DE,EF1Eh
000041C0:       LD C,A
000041C1:       LD A,(DE)
000041C2:       INC DE
000041C3:       LD L,A
000041C4:       LD A,(DE)
000041C5:       LD H,A
000041C6:       OR L
000041C7:       DEC HL
000041C8:       JR NZ,+13h
000041CA:       INC DE
000041CB:       LD A,(DE)
000041CC:       OR A
000041CD:       JR NZ,+08h
000041CF:       LD A,(EF0Fh)
000041D2:       OR A
000041D3:       RET NZ
000041D4:       OUT (C),A
000041D6:       RET
000041D7:       DEC A
000041D8:       LD (DE),A
000041D9:       DEC DE
000041DA:       LD HL,0258h
000041DD:       LD A,H
000041DE:       LD (DE),A
000041DF:       DEC DE
000041E0:       LD A,L
000041E1:       LD (DE),A
000041E2:       RET
000041E3:       LD A,(EF0Fh)
000041E6:       OR A
000041E7:       RET NZ
000041E8:       LD A,(E6C7h)
000041EB:       OR A
000041EC:       RET NZ
000041ED:       LD A,(E6C6h)
000041F0:       INC A
000041F1:       JR Z,+02h
000041F3:       DEC A
000041F4:       RET NZ
000041F5:       LD B,03h
000041F7:       LD HL,EF1Eh
000041FA:       OR (HL)
000041FB:       RET NZ
000041FC:       INC HL
000041FD:       DJNZ -05h
000041FF:       RET
00004200:       CALL 4217h
00004203:       JR Z,+09h
00004205:       CALL 4225h
00004208:       JR Z,+04h
0000420A:       CALL 4221h
0000420D:       RET NZ
0000420E:       POP HL
0000420F:       LD H,B
00004210:       LD L,C
00004211:       CALL 44A4h			; bank switching pivot (write)
00004214:       JP 0C79h				; _REM (skip current line being interpreted)

00004217:       PUSH HL
00004218:       LD HL,E6C6h
0000421B:       LD A,(HL)
0000421C:       INC A
0000421D:       LD (HL),00h
0000421F:       POP HL
00004220:       RET

00004221:       LD A,00h
00004223:       JR +02h
00004225:       LD A,06h
00004227:       PUSH HL
00004228:       PUSH BC
00004229:       CALL 4015h
0000422C:       AND 05h
0000422E:       XOR 05h
00004230:       POP BC
00004231:       POP HL
00004232:       RET
00004233:       CALL 4217h
00004236:       JR Z,+04h
00004238:       CALL 4225h
0000423B:       RET NZ
0000423C:       POP HL
0000423D:       EX DE,HL
0000423E:       CALL 0C79h				; _REM (skip current line being interpreted)
00004241:       RET

00004242:       XOR A
00004243:       OUTA (F8h)
00004245:       LD A,(EF0Eh)	; value being sent to port E6h
00004248:       AND FEh			; disable timer
0000424A:       LD (EF0Eh),A	; value being sent to port E6h
0000424D:       OUTA (E6h)		; Interrupt mask
0000424F:       RET

00004250:       LD A,(EF0Eh)	; value being sent to port E6h
00004253:       OR 01h			; enable timer
00004255:       JR -0Dh


; offset table for 'mul120'
; this table is used for text row addressing (80 text columns + 40 text attribute bytes)
00004257:       DEFW $0000
00004259:       DEFW $0078		; 120
0000425B:       DEFW $00F0		; 240
0000425D:       DEFW $0168		; 360
0000425F:       DEFW $01E0		; 480
00004261:       DEFW $0258		; 600
00004263:       DEFW $02D0		; 720
00004265:       DEFW $0348		; 840
00004267:       DEFW $03C0		; 960
00004269:       DEFW $0438		; 1080
0000426B:       DEFW $04B0		; 1200
0000426D:       DEFW $0528		; 1320
0000426F:       DEFW $05A0		; 1440
00004271:       DEFW $0618		; 1560
00004273:       DEFW $0690		; 1680
00004275:       DEFW $0708		; 1800
00004277:       DEFW $0780		; 1920
00004279:       DEFW $07F8		; 2040
0000427B:       DEFW $0870		; 2160
0000427D:       DEFW $08E8		; 2280
0000427F:       DEFW $0960		; 2400
00004281:       DEFW $09D8		; 2520
00004283:       DEFW $0A50		; 2640
00004285:       DEFW $0AC8		; 2760
00004287:       DEFW $0B40		; 2880
00004289:       DEFW $0BB8		; 3000


; Cursor off
0000428B:       PUSH AF
0000428C:       LD A,80h
0000428E:       JR +08h
; Cursor on
00004290:       PUSH AF
00004291:       LD A,(E6A7h)		; CursorMode
00004294:       AND 01h
00004296:       OR 80h
00004298:       LD (E6A8h),A		; CursorCommand
0000429B:       POP AF
0000429C:       RET

; Coordinate -> TVRAM address translation
; H=column (1-80)
; L=row (1-25)
; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
0000429D:       PUSH DE
0000429E:       PUSH HL
0000429F:       CALL 431Eh		; Find text row address
000042A2:       POP HL
000042A3:       LD L,H
000042A4:       LD H,00h
000042A6:       DEC L
000042A7:       PUSH AF
000042A8:       LD A,(EF89h)	; WIDTH
000042AB:       CP 40+1
000042AD:       JR NC,+01h
000042AF:       ADD HL,HL
000042B0:       POP AF
000042B1:       ADD HL,DE
000042B2:       POP DE
000042B3:       RET

; Init bottom text row
000042B4:       LD HL,(4289h)		; HL=3000 (last value in 'mul120' table)
000042B7:       EX DE,HL
000042B8:       LD HL,(E6C4h)		; TVRAMTop
000042BB:       ADD HL,DE
000042BC:       LD D,H
000042BD:       LD E,L
; Init text row pointed by HL=DE
000042BE:       INC DE
000042BF:       LD BC,0050h		; 80
000042C2:       LD (HL),20h		; ' '
000042C4:       LDIR
000042C6:       LD (HL),80h		; 128
000042C8:       INC HL
000042C9:       LD A,(E6B4h)		; AttributeCode
000042CC:       LD (HL),A
000042CD:       DEC HL
000042CE:       LD C,26h		; 38
000042D0:       INC DE
000042D1:       LDIR
000042D3:       RET

000042D4:       LD A,L
000042D5:       SUB H
000042D6:       JR Z,+21h
000042D8:       PUSH HL
000042D9:       CALL 4333h		; mul120sub: DE=result A=input
000042DC:       LD B,D
000042DD:       LD C,E
000042DE:       POP HL
000042DF:       LD L,H
000042E0:       CALL 431Eh			; Find text row address
000042E3:       LD HL,0078h
000042E6:       ADD HL,DE
000042E7:       LDIR

; copy bottom text line (and attributes) to DE
000042E9:       LD BC,0078h		; 120
000042EC:       PUSH DE
000042ED:       LD HL,(4289h)		; HL=3000 (last value in 'mul120' table)
000042F0:       EX DE,HL
000042F1:       LD HL,(E6C4h)		; TVRAMTop
000042F4:       ADD HL,DE
000042F5:       POP DE
000042F6:       LDIR
000042F8:       RET

000042F9:       CALL 431Eh		; Find text row address
000042FC:       JR -15h

000042FE:       LD A,H
000042FF:       SUB L
00004300:       JR Z,+17h
00004302:       PUSH HL
00004303:       CALL 4333h		; mul120sub: DE=result A=input
00004306:       LD B,D
00004307:       LD C,E
00004308:       POP HL
00004309:       LD L,H
0000430A:       CALL 431Eh		; Find text row address
0000430D:       DEC DE
0000430E:       LD HL,0078h
00004311:       ADD HL,DE
00004312:       EX DE,HL
00004313:       LDDR
00004315:       INC HL
00004316:       EX DE,HL
00004317:       JR -30h

00004319:       CALL 431Eh		; Find text row address
0000431C:       JR -35h

; Find text row address
0000431E:       PUSH HL
0000431F:       LD A,L
00004320:       CP 1Ah		; 25+1
00004322:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
00004325:       DEC A
00004326:       JP M,0B06h			; FCERR, Err $05 - "Illegal function call"

00004329:       CALL 4333h			; mul120sub: DE=result A=input
0000432C:       LD HL,(E6C4h)		; TVRAMTop
0000432F:       ADD HL,DE
00004330:       EX DE,HL
00004331:       POP HL
00004332:       RET

; mul120sub: DE=result A=input
00004333:       RLCA
00004334:       LD L,A
00004335:       LD H,00h
00004337:       LD DE,4257h		; offset table for 'mul120'
0000433A:       ADD HL,DE
0000433B:       LD E,(HL)
0000433C:       INC HL
0000433D:       LD D,(HL)
0000433E:       RET

; WaitVSync
0000433F:       INA (40h)
00004341:       AND 20h				; Vertical retrace signal from CRTC (֐D3301AC)
00004343:       JR NZ,-06h
00004345:       INA (40h)
00004347:       AND 20h				; Vertical retrace signal from CRTC (֐D3301AC)
00004349:       JR Z,-06h
0000434B:       RET

; Write byte in B to VRAM
; WriteToText: VRAM (HL) <- B, with current attribute
0000434C:       LD A,(E6B4h)		; AttributeCode
0000434F:       LD C,A
00004350:       LD (HL),B
00004351:       PUSH HL
00004352:       PUSH DE
00004353:       PUSH BC
00004354:       PUSH AF
00004355:       LD A,C
00004356:       LD (EF8Ch),A
00004359:       CALL 4422h
0000435C:       CP (HL)
0000435D:       JP Z,43F2h
00004360:       LD A,B
00004361:       LD (EF8Eh),A
00004364:       LD B,(HL)
00004365:       DEC HL
00004366:       DEC HL
00004367:       DEC HL
00004368:       PUSH AF
00004369:       LD A,(EF8Dh)
0000436C:       LD C,A
0000436D:       LD A,(EF89h)	; WIDTH
00004370:       CP 29h		; 40+1
00004372:       RLA
00004373:       AND 01h
00004375:       INC A
00004376:       LD E,A
00004377:       POP AF
00004378:       CP 13h
0000437A:       JR NZ,+06h
0000437C:       LD A,E
0000437D:       CP C
0000437E:       JR C,+3Bh
00004380:       JR +2Bh
00004382:       LD A,C
00004383:       SUB (HL)
00004384:       LD D,A
00004385:       LD A,E
00004386:       CP D
00004387:       JR C,+32h
00004389:       INC HL
0000438A:       LD A,(EF8Ch)
0000438D:       CP (HL)
0000438E:       JR NZ,+1Eh
00004390:       DEC HL
00004391:       LD (HL),C
00004392:       INC HL
00004393:       INC HL
00004394:       LD A,C
00004395:       CP (HL)
00004396:       JR NZ,+37h
00004398:       LD D,H
00004399:       LD E,L
0000439A:       LD B,00h
0000439C:       LD A,(EF8Eh)
0000439F:       ADD A
000043A0:       JR Z,+06h
000043A2:       INC HL
000043A3:       INC HL
000043A4:       LD C,A
000043A5:       LDIR
000043A7:       EX DE,HL
000043A8:       LD (HL),B
000043A9:       INC HL
000043AA:       LD (HL),B
000043AB:       JR +22h
000043AD:       INC HL
000043AE:       INC HL
000043AF:       LD A,C
000043B0:       CP (HL)
000043B1:       LD A,(EF8Ch)
000043B4:       LD B,A
000043B5:       JR C,+15h
000043B7:       INC HL
000043B8:       LD (HL),B
000043B9:       JR +14h
000043BB:       INC HL
000043BC:       INC HL
000043BD:       PUSH HL
000043BE:       NOP
000043BF:       CALL 51DBh
000043C2:       POP HL
000043C3:       LD A,(EF8Eh)
000043C6:       OR A
000043C7:       JR Z,-1Ah
000043C9:       NOP
000043CA:       JR -1Fh

000043CC:       CALL 4400h
000043CF:       LD HL,(EF8Ah)
000043D2:       LD D,H
000043D3:       LD E,L
000043D4:       PUSH HL
000043D5:       INC HL
000043D6:       INC HL
000043D7:       LD B,13h
000043D9:       EX HL,(SP)
000043DA:       LD C,(HL)
000043DB:       LDI
000043DD:       INC BC
000043DE:       LD A,(HL)
000043DF:       LDI
000043E1:       INC BC
000043E2:       EX HL,(SP)
000043E3:       INC HL
000043E4:       CP (HL)
000043E5:       JR NZ,+02h
000043E7:       DEC DE
000043E8:       DEC DE
000043E9:       INC HL
000043EA:       LD A,C
000043EB:       CP 80h
000043ED:       JR Z,+02h
000043EF:       DJNZ -18h
000043F1:       POP HL
000043F2:       LD HL,(EF8Ah)
000043F5:       LD DE,0026h
000043F8:       ADD HL,DE
000043F9:       LD (HL),80h
000043FB:       POP AF
000043FC:       POP BC
000043FD:       POP DE
000043FE:       POP HL
000043FF:       RET
00004400:       PUSH HL
00004401:       LD HL,EF8Eh
00004404:       LD A,(HL)
00004405:       DEC (HL)
00004406:       POP HL
00004407:       ADD A
00004408:       JR Z,+11h
0000440A:       PUSH BC
0000440B:       LD C,A
0000440C:       LD B,00h
0000440E:       ADD HL,BC
0000440F:       LD D,H
00004410:       LD E,L
00004411:       DEC HL
00004412:       INC DE
00004413:       LDDR
00004415:       INC HL
00004416:       POP BC
00004417:       LD (HL),C
00004418:       INC HL
00004419:       LD (HL),B
0000441A:       RET

0000441B:       LD (EF8Eh),A
0000441E:       LD C,80h
00004420:       JR -0Bh
00004422:       PUSH AF
00004423:       PUSH DE
00004424:       PUSH HL
00004425:       EX DE,HL
00004426:       LD HL,(E6C4h)		; TVRAMTop
00004429:       EX DE,HL
0000442A:       OR A
0000442B:       SBC HL,DE
0000442D:       LD BC,FF88h
00004430:       LD E,L
00004431:       ADD HL,BC
00004432:       JR C,-04h
00004434:       LD A,E
00004435:       INC A
00004436:       LD (EF8Dh),A
00004439:       CPL
0000443A:       ADD 52h
0000443C:       LD C,A
0000443D:       LD B,00h
0000443F:       POP HL
00004440:       ADD HL,BC
00004441:       LD (EF8Ah),HL
00004444:       LD B,13h
00004446:       LD A,E
00004447:       CP (HL)
00004448:       JR C,+04h
0000444A:       INC HL
0000444B:       INC HL
0000444C:       DJNZ -07h
0000444E:       INC HL
0000444F:       POP DE
00004450:       POP AF
00004451:       RET

00004452:       PUSH HL
00004453:       CALL 4422h
00004456:       LD C,(HL)
00004457:       POP HL
00004458:       LD B,(HL)
00004459:       LD A,B
0000445A:       RET

0000445B:       PUSH BC
0000445C:       LD C,A
0000445D:       LD A,(E6B9h)				; TextIsColor, Color / monochrome switch
00004460:       OR A
00004461:       JR Z,+0Ah
00004463:       LD A,C
00004464:       RRCA
00004465:       RRCA
00004466:       RRCA
00004467:       AND E0h
00004469:       OR 08h
0000446B:       POP BC
0000446C:       RET

0000446D:       LD A,C
0000446E:       AND 07h
00004470:       POP BC
00004471:       RET

00004472:       PUSH HL
00004473:       PUSH DE
00004474:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
00004477:       CALL 4452h
0000447A:       POP DE
0000447B:       POP HL
0000447C:       RET

0000447D:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00004480:       LD B,A
00004481:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
00004484:       CALL 434Ch		; WriteToText: VRAM (HL) <- B, with current attribute
00004487:       JP 5DE5h

0000448A:       LD C,A
0000448B:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
0000448E:       JP 4350h

00004491:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position

; TXT_LOC
00004494:       PUSH AF
00004495:       LD (EF86h),HL			; CSRY (CursorPos) - current text position
00004498:       PUSH HL
00004499:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
0000449C:       POP HL
0000449D:       POP AF
0000449E:       RET

; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)
0000449F:       LD A,(EF87h)		; TTYPOS, (a.k.a. CSRX or CursorPos+1)
000044A2:       DEC A
000044A3:       RET

; bank switching pivot (write)
000044A4:       PUSH AF
000044A5:       CALL EDDEh
000044A8:       LD A,H
000044A9:       CP 84h
000044AB:       JR NC,+04h
000044AD:       OUTA (70h)			; set text window offset address
000044AF:       LD H,80h
000044B1:       POP AF
000044B2:       RET

; use bank pivot (read)
000044B3:       PUSH HL
000044B4:       CALL EDE1h
000044B7:       PUSH AF
000044B8:       LD H,B
000044B9:       LD L,C
000044BA:       CALL 44D5h			; bank switching pivot (read)
000044BD:       LD B,H
000044BE:       LD C,L
000044BF:       POP AF
000044C0:       POP HL
000044C1:       RET

000044C2:       PUSH DE
000044C3:       PUSH AF
000044C4:       PUSH BC
000044C5:       CALL EDE4h
000044C8:       CALL 44B3h			; use bank pivot (read)
000044CB:       LD D,B
000044CC:       LD E,C
000044CD:       OR A
000044CE:       SBC HL,DE
000044D0:       POP BC
000044D1:       ADD HL,BC
000044D2:       POP AF
000044D3:       POP DE
000044D4:       RET

; bank switching pivot (read)
000044D5:       PUSH AF
000044D6:       LD A,H
000044D7:       CP 84h
000044D9:       JR NC,+06h
000044DB:       INA (70h)			; get text window offset address
000044DD:       ADD H
000044DE:       AND 7Fh
000044E0:       LD H,A
000044E1:       POP AF
000044E2:       RET

000044E3:       CALL 44D5h			; bank switching pivot (read)
000044E6:       LD (EFB5h),HL		; 'remote bank read' result
000044E9:       CALL 44A4h			; bank switching pivot (write)
000044EC:       LD A,(HL)
000044ED:       INC HL
000044EE:       OR (HL)
000044EF:       DEC HL
000044F0:       RET

000044F1:       PUSH DE
000044F2:       EX DE,HL
000044F3:       LD HL,7FFFh
000044F6:       OR A
000044F7:       SBC HL,DE
000044F9:       EX DE,HL
000044FA:       POP DE
000044FB:       JP C,0060h
000044FE:       PUSH BC
000044FF:       EX HL,(SP)
00004500:       POP BC
00004501:       PUSH HL

00004502:       OR A
00004503:       SBC HL,DE
00004505:       EX DE,HL
00004506:       POP HL
00004507:       INC DE
00004508:       CALL 451Eh
0000450B:       LD A,(HL)
0000450C:       LD (BC),A
0000450D:       DEC BC
0000450E:       DEC HL
0000450F:       DEC DE
00004510:       LD A,E
00004511:       OR A
00004512:       JR NZ,-09h
00004514:       OR D
00004515:       RET Z
00004516:       CALL 44D5h			; bank switching pivot (read)
00004519:       CALL 451Eh
0000451C:       JR -13h

0000451E:       LD A,H
0000451F:       OR A
00004520:       JR Z,+06h
00004522:       DEC H
00004523:       CALL 44A4h			; bank switching pivot (write)
00004526:       INC H
00004527:       RET

00004528:       CALL 44A4h			; bank switching pivot (write)
0000452B:       RET

0000452C:       EX DE,HL
0000452D:       LD HL,(EB18h)			; ARYTAB - Pointer to begin of array table
00004530:       OR A
00004531:       SBC HL,DE
00004533:       EX DE,HL
00004534:       CALL 44A4h			; bank switching pivot (write)
00004537:       LD A,(HL)
00004538:       LD (BC),A
00004539:       INC BC
0000453A:       INC HL
0000453B:       DEC DE
0000453C:       LD A,E
0000453D:       OR A
0000453E:       JR NZ,-09h
00004540:       OR D
00004541:       JR Z,+08h
00004543:       CALL 44D5h			; bank switching pivot (read)
00004546:       CALL 44A4h			; bank switching pivot (write)
00004549:       JR -14h
0000454B:       LD H,B
0000454C:       LD L,C
0000454D:       LD (EB18h),HL			; ARYTAB - Pointer to begin of array table
00004550:       RET

; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00004551:       DI
00004552:       LD (EF0Bh),HL
00004555:       CALL EDF3h
00004558:       LD (EF0Ah),A		; currently selected ROM bank
0000455B:       INA (71h)			; get Extended ROM bank status
0000455D:       POP HL
0000455E:       PUSH AF
0000455F:       LD A,(EF0Ah)		; currently selected ROM bank
00004562:       PUSH HL
00004563:       LD HL,4581h			; EXEC_ROM0_RET
00004566:       EX HL,(SP)
00004567:       PUSH DE
00004568:       PUSH AF
00004569:       LD L,(HL)
0000456A:       LD H,00h
0000456C:       ADD HL,HL
0000456D:       LD A,FEh			; Select ROM bank 0 (IEROM)
0000456F:       OUTA (71h)			; Extended ROM bank switching
00004571:       LD DE,600Dh			; point to JP table in ROM0
00004574:       ADD HL,DE
00004575:       LD E,(HL)
00004576:       INC HL
00004577:       LD D,(HL)
00004578:       EX DE,HL
00004579:       POP AF
0000457A:       POP DE
0000457B:       PUSH HL
0000457C:       LD HL,(EF0Bh)
0000457F:       EI
00004580:       RET

; return position used by EXEC_ROM0
EXEC_ROM0_RET:
00004581:       DI
00004582:       LD (EF0Ah),A		; currently selected ROM bank
00004585:       EX HL,(SP)
00004586:       LD A,H				; ROM bank mask ($FF or only one bit must be reset)
00004587:       OUTA (71h)			; Extended ROM bank switching
00004589:       POP HL
0000458A:       LD A,(EF0Ah)		; currently selected ROM bank
0000458D:       EI
0000458E:       RET

0000458F:       CALL 6F0Ah
00004592:       LD A,(EC7Dh)
00004595:       OR A
00004596:       RET Z
00004597:       LD B,A
00004598:       DEC A
00004599:       LD E,00h
0000459B:       LD A,E
0000459C:       LD (EC85h),A		; current drive number
0000459F:       CALL 3DCBh
000045A2:       CALL 45AEh
000045A5:       RET NC
000045A6:       INC E
000045A7:       DJNZ -0Eh
000045A9:       XOR A
000045AA:       LD (EC7Dh),A
000045AD:       RET

000045AE:       PUSH DE
000045AF:       PUSH BC
000045B0:       LD BC,0001h
000045B3:       LD A,(EF5Dh)
000045B6:       OR A
000045B7:       JR NZ,+02h
000045B9:       LD B,02h
000045BB:       LD HL,C000h		; perhaps used by IPL

; DATA - DATA statement: find next DATA program line..
000045BE:       XOR A
000045BF:       LD (ECB4h),A
000045C2:       INC A
000045C3:       PUSH BC
000045C4:       PUSH HL
000045C5:       CALL 369Ah		; PHYDIO - HL = addr, A=sect. cnt, B=trk, C=sect, CY-write, NC Z-check NC NZ-read)
000045C8:       POP HL
000045C9:       POP BC
000045CA:       JR NC,+0Ah
000045CC:       LD A,(ECB4h)
000045CF:       CP 02h
000045D1:       CCF
000045D2:       JR Z,+06h
000045D4:       JR -13h

; perhaps used by IPL
000045D6:       CALL C000h

000045D9:       OR A
000045DA:       POP BC
000045DB:       POP DE
000045DC:       RET

000045DD:       CALL 4676h
000045E0:       LD A,B
000045E1:       INC A
000045E2:       INC HL
000045E3:       AND (HL)
000045E4:       CP C
000045E5:       RET Z
000045E6:       PUSH HL
000045E7:       DEC HL
000045E8:       DEC HL
000045E9:       DEC HL
000045EA:       EX HL,(SP)
000045EB:       INC HL
000045EC:       LD C,A
000045ED:       LD A,(HL)
000045EE:       INC HL
000045EF:       LD H,(HL)
000045F0:       LD L,A
000045F1:       LD B,00h
000045F3:       ADD HL,BC
000045F4:       LD (HL),E
000045F5:       POP HL
000045F6:       LD (HL),C
000045F7:       RET

; check keyboard input
000045F8:       CALL 4676h
000045FB:       LD (HL),00h
000045FD:       RET NZ
000045FE:       LD A,C
000045FF:       CP B
00004600:       RET Z
00004601:       INC HL
00004602:       INC A
00004603:       AND (HL)
00004604:       DEC HL
00004605:       DEC HL
00004606:       PUSH HL
00004607:       INC HL
00004608:       INC HL
00004609:       INC HL
0000460A:       LD C,A
0000460B:       LD A,(HL)
0000460C:       INC HL
0000460D:       LD H,(HL)
0000460E:       LD L,A
0000460F:       LD B,00h
00004611:       ADD HL,BC
00004612:       LD A,(HL)
00004613:       POP HL
00004614:       LD (HL),C
00004615:       OR A
00004616:       RET NZ
00004617:       INC A
00004618:       LD A,00h
0000461A:       RET

0000461B:       CALL 4676h
0000461E:       LD A,B
0000461F:       CP C
00004620:       JR NZ,+05h
00004622:       LD A,(HL)
00004623:       LD (HL),00h
00004625:       OR A
00004626:       RET

00004627:       PUSH AF
00004628:       DEC A
00004629:       INC HL
0000462A:       AND (HL)
0000462B:       DEC HL
0000462C:       DEC HL
0000462D:       DEC HL
0000462E:       LD (HL),A
0000462F:       POP AF
00004630:       LD BC,0004h
00004633:       ADD HL,BC
00004634:       LD C,A
00004635:       LD A,(HL)
00004636:       INC HL
00004637:       LD H,(HL)
00004638:       LD L,A
00004639:       ADD HL,BC
0000463A:       LD A,(HL)
0000463B:       JR -28h

0000463D:       PUSH BC
0000463E:       CALL 4680h
00004641:       LD (HL),B
00004642:       INC HL
00004643:       LD (HL),B
00004644:       INC HL
00004645:       LD (HL),B
00004646:       INC HL
00004647:       POP AF
00004648:       LD (HL),A
00004649:       INC HL
0000464A:       LD (HL),E
0000464B:       INC HL
0000464C:       LD (HL),D
0000464D:       RET

0000464E:       CALL 4680h
00004651:       INC HL
00004652:       INC HL
00004653:       LD (HL),E
00004654:       RET

00004655:       CALL 4676h
00004658:       SUB 01h
0000465A:       SBC A
0000465B:       INC A
0000465C:       LD E,A
0000465D:       LD A,B
0000465E:       SUB C
0000465F:       INC HL
00004660:       AND (HL)
00004661:       LD L,A
00004662:       LD H,00h
00004664:       LD D,H
00004665:       ADD HL,DE
00004666:       RET

00004667:       CALL 4676h
0000466A:       LD A,B
0000466B:       INC A
0000466C:       INC HL
0000466D:       AND (HL)
0000466E:       LD B,A
0000466F:       LD A,C
00004670:       SUB B
00004671:       AND (HL)
00004672:       LD L,A
00004673:       LD H,00h
00004675:       RET

00004676:       CALL 4680h
00004679:       LD B,(HL)
0000467A:       INC HL
0000467B:       LD C,(HL)
0000467C:       INC HL
0000467D:       LD A,(HL)
0000467E:       OR A
0000467F:       RET

00004680:       RLCA
00004681:       LD B,A
00004682:       RLCA
00004683:       ADD B
00004684:       LD C,A
00004685:       LD B,00h
00004687:       LD HL,(E6CBh)
0000468A:       ADD HL,BC
0000468B:       RET

; FILE_PARMS:
; AKA  NAMSCN (name scan) - evaluate file specification
0000468C:       CALL 11D3h			; EVAL - evaluate expression
0000468F:       PUSH HL
00004690:       CALL 56C9h				; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
00004693:       LD A,(HL)
00004694:       OR A			; stringsize zero ?
00004695:       JR Z,+2Eh		; yep, bad filename error
00004697:       INC HL
00004698:       LD E,(HL)
00004699:       INC HL
0000469A:       LD H,(HL)
0000469B:       LD L,E				; pointer to string
0000469C:       LD E,A				; size of string
0000469D:       CALL 4DD6h			; Parse Device Name
000046A0:       PUSH AF
000046A1:       LD BC,EC8Fh			; FILNAM
000046A4:       LD D,09h	; 9 CHARACTERS FILENAME MAX (11 on MSX)
000046A6:       INC E
000046A7:       DEC E
000046A8:       JR Z,+35h
000046AA:       LD A,(HL)
000046AB:       CP 20h		; ' ' ..control characters ?
000046AD:       JR C,+16h	; yep, bad filename error
000046AF:       CP 2Eh				; '.' - filename/extension seperator ?
000046B1:       JR Z,+18h			; yep, handle extension
000046B3:       LD (BC),A
000046B4:       INC BC
000046B5:       INC HL
000046B6:       DEC D			; FILNAM full ?
000046B7:       JR NZ,-12h		; nope, next
000046B9:       POP AF
000046BA:       PUSH AF
000046BB:       LD D,A				; devicecode
000046BC:       LD A,(EC8Fh)		; FILNAM
000046BF:       INC A			; first character FILNAME charactercode 255 ?
000046C0:       JR Z,+03h		; yep, bad filename error (because this is internally used as runflag)
000046C2:       POP AF
000046C3:       POP HL
000046C4:       RET

000046C5:       JP 4DA0h			; 'Bad file name' error

000046C8:       INC HL
000046C9:       JR -24h

000046CB:       LD A,D
000046CC:       CP 09h
000046CE:       JP Z,46C5h
000046D1:       CP 03h
000046D3:       JP C,46C5h
000046D6:       JR Z,-10h
000046D8:       LD A,20h
000046DA:       LD (BC),A
000046DB:       INC BC
000046DC:       DEC D
000046DD:       JR -14h
000046DF:       POP AF
000046E0:       PUSH AF
000046E1:       SUB FAh
000046E3:       JR Z,+05h
000046E5:       DEC A
000046E6:       JR Z,+02h
000046E8:       LD A,20h
000046EA:       LD (BC),A
000046EB:       INC BC
000046EC:       DEC D
000046ED:       JR NZ,-10h
000046EF:       JR -38h
000046F1:       LD A,(HL)
000046F2:       INC HL
000046F3:       DEC E
000046F4:       RET

; GETFLP - get i/o channel control block (DAC)
000046F5:       CALL 18A6h			; MAKINT
; GETPTR - get i/o channel control block
000046F8:       LD L,A				; GETPTR
000046F9:       LD A,(EC7Eh)		; MAXFIL
000046FC:       CP L
000046FD:       JP C,4DB2h				; 'Bad file number' error
00004700:       LD H,00h
00004702:       ADD HL,HL
00004703:       EX DE,HL
00004704:       LD HL,(EC7Fh)			; FILTAB
00004707:       ADD HL,DE
00004708:       LD A,(HL)
00004709:       INC HL
0000470A:       LD H,(HL)
0000470B:       LD L,A
0000470C:       LD A,(ECA3h)			; NLONLY
0000470F:       INC A					; NLONLY 0FFH ?
00004710:       RET Z					; yep, quit
00004711:       LD A,(HL)
00004712:       OR A					; i/o channel open ?
00004713:       RET Z					; nope, quit
00004714:       PUSH HL
00004715:       LD DE,0004h
00004718:       ADD HL,DE
00004719:       LD A,(HL)
0000471A:       CP 09h					; is device i/o channel a diskdrive ?
0000471C:       JR NC,+06h				; nope, not a diskdrive device
0000471E:       CALL EDB1h				; ?HGETP? - hook for disk
00004721:       JP 4DB5h			 ; 'Internal error' error

00004724:       POP HL
00004725:       LD A,(HL)
00004726:       OR A
00004727:       SCF
00004728:       RET
00004729:       DEC HL
0000472A:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000472B:       CP 23h		;'#'
0000472D:       CALL Z,0A0Dh			; _CHRGTB - Pick next char from program
00004730:       CALL 18A3h			; GETINT
00004733:       EX HL,(SP)
00004734:       PUSH HL

; SETFIL
00004735:       CALL 46F8h			; GETPTR - get i/o channel control block
00004738:       JP Z,4DACh			; 'File not open' error
0000473B:       LD (EC88h),HL		; PTRFIL
0000473E:       CALL EDFFh
00004741:       RET

00004742:       PUSH HL
00004743:       PUSH DE
00004744:       PUSH BC
00004745:       PUSH AF
00004746:       LD (EC85h),A		; current drive number
00004749:       LD DE,ECA5h
0000474C:       LD BC,000Ch
0000474F:       CALL ECBBh
00004752:       POP AF
00004753:       POP BC
00004754:       POP DE
00004755:       POP HL
00004756:       RET

00004757:       PUSH AF
00004758:       CALL 4761h
0000475B:       LD A,(ECAFh)
0000475E:       LD C,A
0000475F:       POP AF
00004760:       RET
00004761:       PUSH AF
00004762:       LD A,(ECAAh)
00004765:       CALL 478Ch
00004768:       LD B,A
00004769:       POP AF
0000476A:       RET
0000476B:       PUSH HL
0000476C:       PUSH BC
0000476D:       LD HL,ECABh
00004770:       LD B,(HL)
00004771:       LD HL,0000h
00004774:       LD DE,0100h
00004777:       ADD HL,DE
00004778:       DJNZ -03h
0000477A:       EX DE,HL
0000477B:       POP BC
0000477C:       POP HL
0000477D:       RET
0000477E:       PUSH AF
0000477F:       LD A,(ECA5h)
00004782:       CALL 478Ch
00004785:       LD D,A
00004786:       LD A,(ECA6h)
00004789:       LD E,A
0000478A:       POP AF
0000478B:       RET
0000478C:       PUSH BC
0000478D:       LD B,A
0000478E:       LD A,(ECA7h)
00004791:       OR A
00004792:       LD A,B
00004793:       JR Z,+01h
00004795:       ADD A
00004796:       POP BC
00004797:       RET

_OPEN:
00004798:       LD BC,0F8Bh			; FINPRT - finalize PRINT
0000479B:       PUSH BC
0000479C:       CALL 468Ch			; FILE_PARMS:
0000479F:       LD A,(HL)
000047A0:       CP 82h				; TK_FOR - Token for FOR
000047A2:       LD E,04h
000047A4:       JR NZ,+3Ah
000047A6:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000047A7:       CP 85h				; TK_INPUT - Token for INPUT
000047A9:       LD E,01h
000047AB:       JR Z,+32h

000047AD:       CP 4Fh				; 'O'
000047AF:       JR Z,+17h

000047B1:       CP 49h				; 'I'
000047B3:       JR Z,+22h

000047B5:       CALL ECC7h
000047B8:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047B9:       DEFB 'A'
000047BA:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047BB:       DEFB 'P'
000047BC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047BD:       DEFB 'P'
000047BE:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047BF:       DEFB 'E'
000047C0:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047C1:       DEFB 'N'
000047C2:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047C3:       DEFB 'D'
000047C4:       LD E,08h
000047C6:       JR +18h

000047C8:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000047C9:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047CA:       DEFB 'U'
000047CB:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047CC:       DEFB 'T'
000047CD:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047CE:       DEFB 'P'
000047CF:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047D0:       DEFB 'U'
000047D1:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047D2:       DEFB 'T'
000047D3:       LD E,02h
000047D5:       JR +09h

000047D7:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000047D8:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047D9:       DEFB 'B'
000047DA:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047DB:       DEFB 'M'
000047DC:       LD E,20h
000047DE:       DEC HL

000047DF:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000047E0:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047E1:       DEFB 'A'
000047E2:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000047E3:       DEFB 'S'
000047E4:       PUSH DE
000047E5:       LD A,(HL)
000047E6:       CP 23h		;'#'				; '#'
000047E8:       CALL Z,0A0Dh		; _CHRGTB - Pick next char from program
000047EB:       CALL 18A3h			; GETINT
000047EE:       OR A
000047EF:       JP Z,4DB2h			; 'Bad file number' error
000047F2:       CALL ED90h

; +1 -> NULOPN
000047F5:       LD E,D5h
000047F7:       DEC HL
000047F8:       LD E,A
000047F9:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000047FA:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
000047FD:       EX HL,(SP)
000047FE:       LD A,E
000047FF:       PUSH AF
00004800:       PUSH HL
00004801:       CALL 46F8h			; GETPTR - get i/o channel control block
00004804:       JP NZ,4DA3h			; 'File already open' error
00004807:       POP DE
00004808:       LD A,D
00004809:       CP 09h
0000480B:       CALL EDABh
0000480E:       JP C,4DB5h			 ; 'Internal error' error
00004811:       PUSH HL
00004812:       LD BC,0004h
00004815:       ADD HL,BC
00004816:       LD (HL),D
00004817:       LD A,00h
00004819:       POP HL
0000481A:       JP 4E8Ch

; CLOSE
0000481D:       PUSH HL
0000481E:       OR A
0000481F:       JR NZ,+08h
00004821:       LD A,(ECA3h)		; NLONLY
00004824:       AND 01h
00004826:       JP NZ,4C1Dh
00004829:       CALL 46F8h			; GETPTR - get i/o channel control block
0000482C:       JR Z,+13h 			; CLOSE_1
0000482E:       LD (EC88h),HL		; PTRFIL
00004831:       PUSH HL
00004832:       LD A,02h
00004834:       JP C,4E8Ch
00004837:       CALL ED6Fh
0000483A:       JP 4DB5h			 ; 'Internal error' error

; CLOSE_0
0000483D:       CALL 4C14h
00004840:       POP HL
; CLOSE_1
00004841:       PUSH HL
00004842:       LD DE,0007h
00004845:       ADD HL,DE
00004846:       LD (HL),A
00004847:       LD H,A
00004848:       LD L,A
00004849:       LD (EC88h),HL		; PTRFIL
0000484C:       POP HL
0000484D:       ADD (HL)
0000484E:       LD (HL),00h
00004850:       POP HL
00004851:       RET

_LOAD:
00004852:       SCF
00004853:       LD DE,AFF6h
  ;; _LOAD+2:  OR $AF	-> __LOAD
  ;; _LOAD+3:  XOR A	-> __MERGE
00004856:       PUSH AF
00004857:       LD A,(HL)
00004858:       SUB 91h
0000485A:       LD (F00Ah),A
0000485D:       JR NZ,+01h
0000485F:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004860:       CALL 468Ch			; FILE_PARMS:
00004863:       CALL ECF7h
00004866:       POP AF
00004867:       PUSH AF
00004868:       JR Z,+0Ch
0000486A:       LD A,(HL)
0000486B:       SUB 2Ch
0000486D:       OR A
0000486E:       JR NZ,+06h
00004870:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004871:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004872:       DEFB 'R'
00004873:       POP AF
00004874:       SCF
00004875:       PUSH AF
00004876:       PUSH AF
00004877:       XOR A
00004878:       LD E,01h
0000487A:       CALL 47F6h		; +1 -> NULOPN
0000487D:       LD HL,(EC88h)		; PTRFIL
00004880:       LD BC,0007h
00004883:       ADD HL,BC
00004884:       POP AF
00004885:       SBC A
00004886:       AND 80h
00004888:       OR 01h
0000488A:       LD (ECA3h),A		; NLONLY
0000488D:       POP AF
0000488E:       PUSH AF
0000488F:       SBC A
00004890:       LD (EC8Eh),A		; FILNAM
00004893:       LD A,(HL)
00004894:       OR A
00004895:       JP M,4943h			; handle "bad file name" for MERGE/LOAD

00004898:       POP AF
00004899:       CALL NZ,4F01h		; CLRPTR
0000489C:       XOR A
0000489D:       CALL 4735h			; SETFIL
000048A0:       JP 04A7h			; PROMPT

_SAVE:
000048A3:       CALL 468Ch			; FILE_PARMS:
000048A6:       CALL ECFAh		; ?HSAVE? - Hook 1 for "SAVE"?
000048A9:       DEC HL
000048AA:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000048AB:       LD E,80h
000048AD:       SCF
000048AE:       CALL Z,EDA8h	; HOOK code ?
000048B1:       JR Z,+11h
000048B3:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000048B4:       DEFB ','
000048B5:       CP 50h
000048B7:       LD E,92h
000048B9:       JR NZ,+04h
000048BB:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000048BC:       SCF
000048BD:       JR +05h
000048BF:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000048C0:       DEFB 'A'
000048C1:       OR A
000048C2:       LD E,02h
000048C4:       PUSH AF
000048C5:       LD A,E
000048C6:       AND 10h
000048C8:       LD (EC27h),A
000048CB:       POP AF
000048CC:       PUSH AF
000048CD:       INC A
000048CE:       LD (ECA4h),A
000048D1:       LD A,D
000048D2:       CP 09h
000048D4:       JR C,+0Ah
000048D6:       LD A,E
000048D7:       AND 80h
000048D9:       JR Z,+05h
000048DB:       LD E,02h
000048DD:       POP AF
000048DE:       XOR A
000048DF:       PUSH AF
000048E0:       XOR A
000048E1:       CALL 47F6h		; +1 -> NULOPN
000048E4:       POP AF
000048E5:       JP NC,18D9h		; _LIST
000048E8:       CALL 44D5h			; bank switching pivot (read)
000048EB:       PUSH HL
000048EC:       CALL 1BBBh          ; SCCPTR
000048EF:       LD A,(EC27h)
000048F2:       OR A
000048F3:       CALL NZ,EDA2h
000048F6:       LD HL,(EB18h)			; ARYTAB - Pointer to begin of array table
000048F9:       LD (ECB1h),HL
000048FC:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
000048FF:       PUSH HL
00004900:       CALL ECC4h			; ?HBINS? - Hook 2 for "SAVE"?
00004903:       JP 4DA0h			; 'Bad file name' error

00004906:       LD A,(EC27h)
00004909:       OR A
0000490A:       CALL NZ,EDA5h
0000490D:       POP HL
0000490E:       CALL 44A4h			; bank switching pivot (write)
00004911:       XOR A
00004912:       LD (EC27h),A
00004915:       JP 481Dh			; CLOSE

00004918:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00004919:       RET NC
0000491A:       CALL 44A4h			; bank switching pivot (write)
0000491D:       LD A,(HL)
0000491E:       CALL 44D5h			; bank switching pivot (read)
00004921:       INC HL
00004922:       CALL 4B54h
00004925:       JR -0Fh
00004927:       PUSH AF
00004928:       JR NC,+05h
0000492A:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
0000492B:       JR C,+0Ah
0000492D:       JR +12h

0000492F:       PUSH DE
00004930:       CALL 498Ch
00004933:       LD (EB16h),HL	; PROGND - BASIC program end ptr (aka VARTAB)
00004936:       POP DE
00004937:       CALL 4B7Bh
0000493A:       JR C,+05h
0000493C:       LD (HL),A
0000493D:       INC HL
0000493E:       POP AF
0000493F:       JR -1Ah
00004941:       POP AF
00004942:       RET

; handle "bad file name" for MERGE/LOAD
00004943:       AND 20h
00004945:       LD (EC28h),A
00004948:       POP AF
00004949:       JP Z,4DBEh
0000494C:       CALL 4F01h			; CLRPTR
0000494F:       LD A,(EC28h)
00004952:       LD (EC29h),A
00004955:       CALL 4B0Ch			; CLSALL - Close all files/streams
00004958:       XOR A
00004959:       CALL 46F8h			; GETPTR - get i/o channel control block
0000495C:       LD (HL),80h
0000495E:       LD (EC88h),HL		; PTRFIL
00004961:       CALL ECD9h
00004964:       JP 4DA0h			; 'Bad file name' error

00004967:       LD A,(EC29h)
0000496A:       OR A
0000496B:       CALL NZ,EDA5h
0000496E:       CALL 05BDh
00004971:       INC HL
00004972:       CALL 44D5h			; bank switching pivot (read)
00004975:       LD (EB18h),HL			; ARYTAB - Pointer to begin of array table
00004978:       CALL 4F21h			; RUN_FST
0000497B:       XOR A
0000497C:       LD (ECA3h),A		; NLONLY
0000497F:       CALL 481Dh			; CLOSE
00004982:       LD A,(EC8Eh)		; FILNAM
00004985:       OR A
00004986:       JP NZ,0996h			; NEWSTT
00004989:       JP 047Bh			; READY:

0000498C:       EX DE,HL
0000498D:       LD HL,7FFFh
00004990:       EX DE,HL
00004991:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00004992:       RET C
00004993:       CALL 4F01h			; CLRPTR
00004996:       XOR A
00004997:       LD (ECA3h),A		; NLONLY
0000499A:       JP 4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'

0000499D:       PUSH HL
0000499E:       PUSH DE
0000499F:       LD HL,(EC88h)		; PTRFIL
000049A2:       LD DE,0004h
000049A5:       ADD HL,DE
000049A6:       LD A,(HL)
000049A7:       POP DE
000049A8:       POP HL
000049A9:       RET

_RSET:
000049AA:       OR 37h
000049AC:       PUSH AF
000049AD:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
000049B0:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
000049B3:       PUSH DE
000049B4:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000049B5:       POP AF	; DEFB TK_EQUAL..  Token for '='
000049B6:       CALL 11D3h			; EVAL - evaluate expression
000049B9:       POP BC
000049BA:       EX HL,(SP)
000049BB:       PUSH HL
000049BC:       PUSH BC
000049BD:       CALL 56C9h				; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
000049C0:       LD B,(HL)
000049C1:       EX HL,(SP)
000049C2:       LD A,(HL)
000049C3:       LD C,A
000049C4:       PUSH BC
000049C5:       PUSH HL
000049C6:       PUSH AF
000049C7:       INC HL
000049C8:       LD E,(HL)
000049C9:       INC HL
000049CA:       LD D,(HL)
000049CB:       OR A
000049CC:       JP Z,4A32h
000049CF:       LD HL,8000h
000049D2:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000049D3:       JR NC,+12h
000049D5:       LD HL,E879h		; BUFFER - start of INPUT buffer
000049D8:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000049D9:       JR C,+0Ch
000049DB:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
000049DE:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000049DF:       JR NC,+2Ch
000049E1:       LD HL,(EB1Bh)	; VARTAB
000049E4:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000049E5:       JR C,+26h
000049E7:       LD E,C
000049E8:       LD D,00h
000049EA:       LD HL,(EB1Fh)	; ARREND - End of arrays
000049ED:       ADD HL,DE
000049EE:       EX DE,HL
000049EF:       LD HL,(EAF1h)		; FRETOP - Starting address of unused area of string area
000049F2:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000049F3:       JP C,4A45h
000049F6:       POP AF
000049F7:       LD A,C
000049F8:       CALL 5572h		; TESTR - Test if enough room for string
000049FB:       POP HL
000049FC:       POP BC
000049FD:       EX HL,(SP)
000049FE:       PUSH DE
000049FF:       PUSH BC
00004A00:       CALL 56C9h		; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
00004A03:       POP BC
00004A04:       POP DE
00004A05:       EX HL,(SP)
00004A06:       PUSH BC
00004A07:       PUSH HL
00004A08:       INC HL
00004A09:       LD (HL),E
00004A0A:       INC HL
00004A0B:       LD (HL),D
00004A0C:       PUSH AF
00004A0D:       POP AF
00004A0E:       POP HL
00004A0F:       INC HL
00004A10:       LD E,(HL)
00004A11:       INC HL
00004A12:       LD D,(HL)
00004A13:       POP BC
00004A14:       POP HL
00004A15:       PUSH DE
00004A16:       INC HL
00004A17:       LD E,(HL)
00004A18:       INC HL
00004A19:       LD D,(HL)
00004A1A:       EX DE,HL
00004A1B:       POP DE
00004A1C:       LD A,C
00004A1D:       SUB B
00004A1E:       JR NC,+01h
00004A20:       LD B,C
00004A21:       LD A,C
00004A22:       SUB B
00004A23:       LD C,A
00004A24:       POP AF
00004A25:       CALL NC,4A3Ch
00004A28:       INC B
00004A29:       DEC B
00004A2A:       JR Z,+0Bh
00004A2C:       LD A,(HL)
00004A2D:       LD (DE),A
00004A2E:       INC HL
00004A2F:       INC DE
00004A30:       JR -09h
00004A32:       POP BC
00004A33:       POP BC
00004A34:       POP BC
00004A35:       POP BC
00004A36:       POP BC
00004A37:       CALL C,4A3Ch
00004A3A:       POP HL
00004A3B:       RET
00004A3C:       LD A,20h
00004A3E:       INC C
00004A3F:       DEC C
00004A40:       RET Z
00004A41:       LD (DE),A
00004A42:       INC DE
00004A43:       JR -06h
00004A45:       POP AF
00004A46:       POP HL
00004A47:       POP BC
00004A48:       EX HL,(SP)
00004A49:       EX DE,HL
00004A4A:       JR NZ,+09h
00004A4C:       PUSH BC
00004A4D:       LD A,B
00004A4E:       CALL 54EEh			; MKTMST - Make temporary string
00004A51:       CALL 552Ch			; TSTOPL - Temporary string to pool
00004A54:       POP BC
00004A55:       EX HL,(SP)
00004A56:       PUSH BC
00004A57:       PUSH HL
00004A58:       PUSH AF
00004A59:       JP 49F6h

_FIELD:
00004A5C:       DEC HL
00004A5D:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004A5E:       CP '#'
00004A60:       CALL Z,0A0Dh		; _CHRGTB - Pick next char from program
00004A63:       CALL 18A3h			; GETINT
00004A66:       PUSH HL
00004A67:       CALL 46F8h			; GETPTR - get i/o channel control block
00004A6A:       CALL 4C28h
00004A6D:       POP DE
00004A6E:       XOR A
00004A6F:       LD B,A
00004A70:       LD C,A
00004A71:       PUSH HL
00004A72:       ADD HL,BC
00004A73:       EX DE,HL
00004A74:       LD A,(HL)
00004A75:       CP 2Ch		; ','
00004A77:       JP NZ,4C2Dh
00004A7A:       PUSH DE
00004A7B:       PUSH BC
00004A7C:       CALL 18A2h				; FNDNUM - Load 'A' with the next number in BASIC program
00004A7F:       PUSH AF
00004A80:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004A81:       DEFB 'A'
00004A82:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004A83:       DEFB 'S'
00004A84:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00004A87:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
00004A8A:       POP AF
00004A8B:       POP BC
00004A8C:       EX HL,(SP)
00004A8D:       INC B
00004A8E:       ADD C
00004A8F:       JR C,+01h
00004A91:       DEC B
00004A92:       JP NZ,4DAFh			; 'FIELD overflow' error
00004A95:       EX DE,HL
00004A96:       SUB C
00004A97:       LD (HL),A
00004A98:       ADD C
00004A99:       INC HL
00004A9A:       LD (HL),E
00004A9B:       INC HL
00004A9C:       LD (HL),D
00004A9D:       POP DE
00004A9E:       POP HL
00004A9F:       JR -31h

_MKI$:
00004AA1:       LD A,02h
00004AA3:       LD BC,043Eh		; 00004AA4:		_MKS$:
00004AA6:       LD BC,083Eh		; 00004AA7:		_MKD$:
00004AA9:       PUSH AF
00004AAA:       CALL 1796h
00004AAD:       POP AF
00004AAE:       CALL 54EEh			; MKTMST - Make temporary string
00004AB1:       LD HL,(EAEFh)			; TMPSTR+1
00004AB4:       CALL 2127h
00004AB7:       JP 571Eh				; TOPOOL - Save in string pool

; _CVI:
00004ABA:       LD A,01h
00004ABC:       LD BC,033Eh			; 4ABD: _CVS		(LD A,03)
00004ABF:       LD BC,073Eh			; 4AC0: _CVD		(LD A,07)
00004AC2:       PUSH AF
00004AC3:       CALL 56C9h				; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
00004AC6:       POP AF
00004AC7:       CP (HL)
00004AC8:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
00004ACB:       INC A
00004ACC:       INC HL
00004ACD:       LD C,(HL)
00004ACE:       INC HL
00004ACF:       LD H,(HL)
00004AD0:       LD L,C
00004AD1:       LD (EABDh),A			; VALTYP - type indicator
00004AD4:       JP 211Fh			; FP_HL2DE


00004AD7:       JR NZ,+19h

00004AD9:       PUSH HL
00004ADA:       PUSH BC
00004ADB:       PUSH AF
00004ADC:       LD DE,4AE3h
00004ADF:       PUSH DE
00004AE0:       PUSH BC
00004AE1:       OR A
00004AE2:       RET

00004AE3:       POP AF
00004AE4:       POP BC
00004AE5:       DEC A
00004AE6:       JP P,4ADAh
00004AE9:       POP HL
00004AEA:       RET

00004AEB:       POP BC
00004AEC:       POP HL
00004AED:       LD A,(HL)
00004AEE:       CP 2Ch		; ','
00004AF0:       RET NZ
00004AF1:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.

00004AF2:       PUSH BC
00004AF3:       LD A,(HL)
00004AF4:       CP 23h		;'#'
00004AF6:       CALL Z,0A0Dh			; _CHRGTB - Pick next char from program
00004AF9:       CALL 18A3h			; GETINT
00004AFC:       EX HL,(SP)
00004AFD:       PUSH HL
00004AFE:       LD DE,4AEBh
00004B01:       PUSH DE
00004B02:       SCF
00004B03:       LD PC,HL

_CLOSE:
00004B04:       LD BC,481Dh			; CLOSE
00004B07:       LD A,(EC7Eh)		; MAXFIL
00004B0A:       JR -35h

; CLSALL - Close all files/streams
00004B0C:       LD A,(ECA3h)		; NLONLY
00004B0F:       OR A
00004B10:       RET M
00004B11:       LD BC,481Dh			; CLOSE
00004B14:       XOR A
00004B15:       LD A,(EC7Eh)		; MAXFIL
00004B18:       JR -43h

; BASICH
00004B1A:       XOR A
00004B1B:       LD B,A
00004B1C:       LD A,B
00004B1D:       CALL 46F8h			; GETPTR - get i/o channel control block
00004B20:       LD (HL),00h
00004B22:       LD A,(EC7Eh)		; MAXFIL
00004B25:       INC B
00004B26:       SUB B
00004B27:       JR NC,-0Dh
00004B29:       XOR A
00004B2A:       LD (ECA3h),A		; NLONLY
00004B2D:       CALL 4F01h			; CLRPTR
00004B30:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00004B33:       DEC HL
00004B34:       LD (HL),00h
00004B36:       PUSH HL
00004B37:       CALL 779Ch
00004B3A:       POP HL
00004B3B:       CALL ECCDh
00004B3E:       JP 036Fh
00004B41:       OR AFh
00004B43:       PUSH AF
00004B44:       CALL 4729h
00004B47:       LD A,04h
00004B49:       JP C,4E8Ch
00004B4C:       CALL ECD0h
00004B4F:       JP 4DA0h			; 'Bad file name' error

00004B52:       POP HL
00004B53:       POP AF

00004B54:       PUSH HL
00004B55:       PUSH DE
00004B56:       PUSH BC
00004B57:       PUSH AF
00004B58:       LD HL,(EC88h)		; PTRFIL
00004B5B:       LD A,06h
00004B5D:       CALL 4B66h
00004B60:       CALL ECE8h
00004B63:       JP 4DA0h			; 'Bad file name' error

00004B66:       PUSH AF
00004B67:       PUSH DE
00004B68:       EX DE,HL
00004B69:       LD HL,0004h
00004B6C:       ADD HL,DE
00004B6D:       LD A,(HL)
00004B6E:       EX DE,HL
00004B6F:       POP DE
00004B70:       CP 09h
00004B72:       JP C,4C2Dh
00004B75:       POP AF
00004B76:       EX HL,(SP)
00004B77:       POP HL
00004B78:       JP 4E8Ch

00004B7B:       PUSH BC
00004B7C:       PUSH HL
00004B7D:       PUSH DE
00004B7E:       LD HL,(EC88h)		; PTRFIL
00004B81:       LD A,08h
00004B83:       CALL 4B66h
00004B86:       CALL ECEEh
00004B89:       JP 4DA0h			; 'Bad file name' error

00004B8C:       PUSH AF
00004B8D:       LD HL,(EC88h)		; PTRFIL
00004B90:       LD BC,0007h
00004B93:       ADD HL,BC
00004B94:       LD C,(HL)
00004B95:       LD A,C
00004B96:       AND 7Fh             ;IF FILE IS ACTIVE
00004B98:       LD (HL),A
00004B99:       CP C
00004B9A:       JR Z,+08h
00004B9C:       POP AF
00004B9D:       PUSH AF
00004B9E:       JR C,+04h
00004BA0:       CP 0Ah
00004BA2:       JR Z,+05h
00004BA4:       POP AF
00004BA5:       POP DE
00004BA6:       POP HL
00004BA7:       POP BC
00004BA8:       RET

00004BA9:       POP AF
00004BAA:       JR -2Eh

_INPUT function (different than INPUT command):
00004BAC:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004BAD:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004BAE:       DEFB 24h	; '$'
00004BAF:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004BAE:       DEFB 24h	; '('
00004BB1:       PUSH HL
00004BB2:       LD HL,(EC88h)		; PTRFIL
00004BB5:       PUSH HL
00004BB6:       LD HL,0000h
00004BB9:       LD (EC88h),HL		; PTRFIL
00004BBC:       POP HL
00004BBD:       EX HL,(SP)
00004BBE:       CALL 18A3h			; GETINT
00004BC1:       PUSH DE
00004BC2:       LD A,(HL)
00004BC3:       CP 2Ch		; ','
00004BC5:       JR NZ,+0Fh	; FN_INPUT_1
00004BC7:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004BC8:       CALL 4729h
00004BCB:       CALL 499Dh
00004BCE:       CP FBh
00004BD0:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00004BD3:       POP HL
00004BD4:       XOR A
00004BD5:       LD A,(HL)
; FN_INPUT_1
00004BD6:       PUSH AF
00004BD7:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004BD8:       DEFB ')'
00004BD9:       POP AF
00004BDA:       EX HL,(SP)
00004BDB:       PUSH AF
00004BDC:       LD A,L
00004BDD:       OR A
00004BDE:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00004BE1:       PUSH HL
00004BE2:       CALL 54EEh			; MKTMST - Make temporary string
00004BE5:       EX DE,HL
00004BE6:       POP BC
; FN_INPUT_2
00004BE7:       POP AF
00004BE8:       PUSH AF
00004BE9:       JR Z,+21h	; FN_INPUT_4
00004BEB:       CALL 5A41h			; CHGET - Waits for character being input and returns the character codes.
00004BEE:       CP 03h
00004BF0:       JR Z,+0Fh
00004BF2:       LD (HL),A
00004BF3:       INC HL
00004BF4:       DEC C
00004BF5:       JR NZ,-10h
00004BF7:       POP AF
00004BF8:       POP BC
00004BF9:       POP HL
00004BFA:       LD (EC88h),HL		; PTRFIL
00004BFD:       PUSH BC
00004BFE:       JP 552Ch				; TSTOPL - Temporary string to pool

00004C01:       POP AF
00004C02:       LD HL,(E656h)			; CURLIN - line number being interpreted
00004C05:       LD (EB09h),HL		; ERRLIN - Line where last error
00004C08:       POP HL
00004C09:       JP 036Fh

00004C0C:       CALL 4B7Bh
00004C0F:       JP C,4DB8h			 ; 'Input past end' error
00004C12:       JR -22h
00004C14:       CALL 4C25h
00004C17:       PUSH HL
00004C18:       LD B,00h
00004C1A:       CALL 4C1Fh
00004C1D:       POP HL
00004C1E:       RET

00004C1F:       XOR A
00004C20:       LD (HL),A
00004C21:       INC HL
00004C22:       DJNZ -04h
00004C24:       RET

00004C25:       LD HL,(EC88h)		; PTRFIL
00004C28:       LD DE,0009h
00004C2B:       ADD HL,DE
00004C2C:       RET

00004C2D:       POP AF
00004C2E:       RET

_LOC:
00004C2F:       CALL 46F5h			; GETFLP - get i/o channel control block (DAC)
00004C32:       JP Z,4DACh			; 'File not open' error
00004C35:       LD A,0Ah
00004C37:       JP C,4E8Ch
00004C3A:       CALL ECF1h
00004C3D:       JP 4DA0h			; 'Bad file name' error

_LOF:
00004C40:       CALL 46F5h			; GETFLP - get i/o channel control block (DAC)
00004C43:       JP Z,4DACh			; 'File not open' error
00004C46:       LD A,0Ch
00004C48:       JP C,4E8Ch
00004C4B:       CALL ECF4h
00004C4E:       JP 4DA0h			; 'Bad file name' error

_EOF:
00004C51:       CALL 46F5h			; GETFLP - get i/o channel control block (DAC)
00004C54:       JP Z,4DACh			; 'File not open' error
00004C57:       LD A,0Eh
00004C59:       JP C,4E8Ch
00004C5C:       CALL EDAEh
00004C5F:       JP 4DA0h			; 'Bad file name' error

_FPOS:
00004C62:       CALL 46F5h			; GETFLP - get i/o channel control block (DAC)
00004C65:       LD A,10h
00004C67:       JP C,4E8Ch
00004C6A:       CALL ECEBh
00004C6D:       JP 4DA0h			; 'Bad file name' error

00004C70:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00004C73:       JP Z,09E5h			; NEXT_STMT
00004C76:       XOR A
00004C77:       CALL 481Dh			; CLOSE
00004C7A:       JP 4DA6h			; 'Direct statement in file' error

; deal with '#' argument
00004C7D:       CP 23h		;'#'
00004C7F:       RET NZ
00004C80:       CALL 18A2h				; FNDNUM - Load 'A' with the next number in BASIC program
00004C83:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00004C84:       DEFB ','
00004C85:       LD A,E
00004C86:       PUSH HL
00004C87:       CALL 4735h			; SETFIL
00004C8A:       POP HL
00004C8B:       LD A,(HL)
00004C8C:       RET NC
00004C8D:       PUSH AF
00004C8E:       PUSH HL
00004C8F:       CALL 499Dh
00004C92:       CP FBh
00004C94:       JR NZ,+12h
00004C96:       LD A,(E6E8h)
00004C99:       LD (E6A9h),A
00004C9C:       OR A
00004C9D:       PUSH AF
00004C9E:       CALL M,690Bh
00004CA1:       POP AF
00004CA2:       JP M,4CA8h
00004CA5:       CALL P,68EBh
00004CA8:       POP HL
00004CA9:       POP AF
00004CAA:       RET

00004CAB:       LD BC,4FDEh
00004CAE:       PUSH BC
00004CAF:       XOR A
00004CB0:       JP 481Dh			; CLOSE

00004CB3:       CALL 0030h
00004CB6:       LD BC,1157h
00004CB9:       LD DE,2C20h
00004CBC:       JR NZ,+17h
00004CBE:       LD E,D
00004CBF:       JR +14h

00004CC1:       LD BC,0F8Bh			; FINPRT - finalize PRINT
00004CC4:       PUSH BC
00004CC5:       CALL 4C7Dh		; deal with '#' argument
00004CC8:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00004CCB:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
00004CCE:       PUSH DE
00004CCF:       LD BC,0C97h
00004CD2:       XOR A
00004CD3:       LD D,A
00004CD4:       LD E,A
00004CD5:       PUSH AF
00004CD6:       PUSH BC
00004CD7:       PUSH HL
00004CD8:       CALL 4B7Bh
00004CDB:       JP C,4DB8h			 ; 'Input past end' error
00004CDE:       CP 20h		; ' '
00004CE0:       JR NZ,+04h
00004CE2:       INC D
00004CE3:       DEC D
00004CE4:       JR NZ,-0Eh
00004CE6:       CP 22h		; '"'
00004CE8:       JR NZ,+0Eh
00004CEA:       LD B,A
00004CEB:       LD A,E
00004CEC:       CP 2Ch		; ','
00004CEE:       LD A,B
00004CEF:       JR NZ,+07h
00004CF1:       LD D,B
00004CF2:       LD E,B
00004CF3:       CALL 4B7Bh
00004CF6:       JR C,+47h
00004CF8:       LD HL,E9B9h
00004CFB:       LD B,FFh
00004CFD:       LD C,A
00004CFE:       LD A,D
00004CFF:       CP 22h		; '"'
00004D01:       LD A,C
00004D02:       JR Z,+28h
00004D04:       CP 0Dh
00004D06:       PUSH HL
00004D07:       JR Z,+50h
00004D09:       POP HL
00004D0A:       CP 0Ah
00004D0C:       JR NZ,+1Eh
00004D0E:       LD C,A
00004D0F:       LD A,E
00004D10:       CP 2Ch		; ','
00004D12:       LD A,C
00004D13:       CALL NZ,4D97h
00004D16:       PUSH HL
00004D17:       CALL 4B7Bh
00004D1A:       POP HL
00004D1B:       JR C,+22h
00004D1D:       CP 0Dh
00004D1F:       JR NZ,+0Bh
00004D21:       LD A,E
00004D22:       CP 20h		; ' '
00004D24:       JR Z,+12h
00004D26:       CP 2Ch		; ','
00004D28:       LD A,0Dh
00004D2A:       JR Z,+0Ch
00004D2C:       OR A
00004D2D:       JR Z,+09h
00004D2F:       CP D
00004D30:       JR Z,+0Dh
00004D32:       CP E
00004D33:       JR Z,+0Ah
00004D35:       CALL 4D97h
00004D38:       PUSH HL
00004D39:       CALL 4B7Bh
00004D3C:       POP HL
00004D3D:       JR NC,-42h
00004D3F:       PUSH HL
00004D40:       CP 22h		; '"'
00004D42:       JR Z,+04h
00004D44:       CP 20h		; ' '
00004D46:       JR NZ,+2Fh
00004D48:       CALL 4B7Bh
00004D4B:       JR C,+2Ah
00004D4D:       CP 20h		; ' '
00004D4F:       JR Z,-09h
00004D51:       CP 2Ch		; ','
00004D53:       JR Z,+22h
00004D55:       CP 0Dh
00004D57:       JR NZ,+0Fh
00004D59:       LD HL,(EC88h)		; PTRFIL
00004D5C:       LD BC,0007h
00004D5F:       ADD HL,BC
00004D60:       LD C,A
00004D61:       LD A,(HL)
00004D62:       OR 80h
00004D64:       LD (HL),A
00004D65:       LD A,C
00004D66:       JR +0Fh
00004D68:       LD HL,(EC88h)		; PTRFIL
00004D6B:       LD C,A
00004D6C:       LD A,12h
00004D6E:       CALL 4B66h
00004D71:       CALL ECDCh
00004D74:       JP 4DA0h			; 'Bad file name' error

00004D77:       POP HL
00004D78:       LD (HL),00h
00004D7A:       LD HL,E9B8h
00004D7D:       LD A,E
00004D7E:       SUB 20h
00004D80:       JR Z,+07h
00004D82:       LD B,00h
00004D84:       CALL 54FFh
00004D87:       POP HL
00004D88:       RET

00004D89:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00004D8A:       PUSH AF
00004D8B:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00004D8C:       POP AF
00004D8D:       PUSH AF
00004D8E:       CALL C,26BCh		; DBL_ASCTFP (a.k.a. FIN)
00004D91:       POP AF
00004D92:       CALL NC,26B5h		; DBL_ASCTFP2
00004D95:       POP HL
00004D96:       RET

00004D97:       OR A
00004D98:       RET Z
00004D99:       LD (HL),A
00004D9A:       INC HL
00004D9B:       DEC B
00004D9C:       RET NZ
00004D9D:       POP BC
00004D9E:       JR -28h

; File error related entries
00004DA0:       LD E,38h		; 4DA0: 'Bad file name' error
00004DA2:       LD BC,361Eh		; 4DA3: 'File already open' error
00004DA5:       LD BC,391Eh		; 4DA6: 'Direct statement in file' error
00004DA8:       LD BC,351Eh		; 4DA9: 'File not found' error
00004DAB:       LD BC,3C1Eh		; 4DAC: 'File not open' error
00004DAE:       LD BC,321Eh		; 4DAF: 'FIELD overflow' error
00004DB1:       LD BC,341Eh		; 4DB2: 'Bad file number' error
00004DB4:       LD BC,331Eh		; 4DB5: 'Internal error' error
00004DB7:       LD BC,371Eh		; 4DB8: 'Input past end' error
00004DBA:       LD BC,3A1Eh		; 4DBB: 'Sequential after PUT' error
00004DBD:       LD BC,3B1Eh		; 4DBD: 'Sequential I/O only' error
00004DC0:       LD BC,211Eh		; 4DC1: 'Feature not available' error
00004DC3:       XOR A
00004DC4:       LD (ECA3h),A		; NLONLY
00004DC7:       CALL ECC1h			; Hook for Error handler ?
00004DCA:       LD (ECA4h),A
00004DCD:       LD (E653h),A
00004DD0:       LD (EC27h),A
00004DD3:       JP 03B3h				; ERROR, code in E

; Parse Device Name
00004DD6:       CALL ED09h
00004DD9:       PUSH HL
00004DDA:       LD D,E
00004DDB:       CALL 46F1h
00004DDE:       JR Z,+0Eh
00004DE0:       CP 3Ah		; ':'
00004DE2:       JR C,+13h
00004DE4:       CP 3Ah		; ':'
00004DE6:       JR Z,+12h
00004DE8:       CALL 46F1h
00004DEB:       JP P,4DE4h
00004DEE:       LD E,D
00004DEF:       POP HL
00004DF0:       XOR A
00004DF1:       LD A,FBh
00004DF3:       CALL ED06h
00004DF6:       RET

00004DF7:       JP 4DA0h			; 'Bad file name' error

00004DFA:       LD A,D
00004DFB:       SUB E
00004DFC:       DEC A
00004DFD:       CP 02h
00004DFF:       JR NC,+06h
00004E01:       CALL ECFDh
00004E04:       JP 4DA0h			; 'Bad file name' error

00004E07:       CP 05h
00004E09:       JP NC,4DA0h			; 'Bad file name' error
00004E0C:       POP BC
00004E0D:       PUSH DE
00004E0E:       PUSH BC
00004E0F:       LD C,A
00004E10:       LD B,A
00004E11:       LD DE,4E53h
00004E14:       EX HL,(SP)
00004E15:       PUSH HL
00004E16:       LD A,(HL)
00004E17:       CP 61h		; 'a'
00004E19:       JR C,+06h
00004E1B:       CP 7Bh
00004E1D:       JR NC,+02h
00004E1F:       SUB 20h
00004E21:       PUSH BC
00004E22:       LD B,A
00004E23:       LD A,(DE)
00004E24:       INC HL
00004E25:       INC DE
00004E26:       CP B
00004E27:       POP BC
00004E28:       JR NZ,+15h
00004E2A:       DEC C
00004E2B:       JR NZ,-17h
00004E2D:       LD A,(DE)
00004E2E:       OR A
00004E2F:       JP M,4E3Ah
00004E32:       CP 31h
00004E34:       JR NZ,+09h
00004E36:       INC DE
00004E37:       LD A,(DE)
00004E38:       JR +05h
00004E3A:       POP HL
00004E3B:       POP HL
00004E3C:       POP DE
00004E3D:       OR A
00004E3E:       RET
00004E3F:       OR A
00004E40:       JP M,4E2Dh
00004E43:       LD A,(DE)
00004E44:       OR A
00004E45:       INC DE
00004E46:       JP P,4E43h
00004E49:       LD C,B
00004E4A:       POP HL
00004E4B:       PUSH HL
00004E4C:       LD A,(DE)
00004E4D:       OR A
00004E4E:       JR NZ,-3Ah
00004E50:       JP 4DA0h			; 'Bad file name' error

00004E53:       LD C,E
00004E54:       LD E,C
00004E55:       LD B,D
00004E56:       LD B,H
00004E57:       RST 38h
00004E58:       LD B,E
00004E59:       LD C,A
00004E5A:       LD C,L
00004E5B:       LD SP,43FEh
00004E5E:       LD C,A
00004E5F:       LD C,L
00004E60:       LD (43FDh),A
00004E63:       LD C,A
00004E64:       LD C,L
00004E65:       INC SP
00004E66:       CALL M,4143h
00004E69:       LD D,E
00004E6A:       LD SP,43FBh
00004E6D:       LD B,C
00004E6E:       LD D,E
00004E6F:       LD (4CFAh),A
00004E72:       LD D,B
00004E73:       LD D,H
00004E74:       LD SP,53F9h
00004E77:       LD B,E
00004E78:       LD D,D
00004E79:       LD C,(HL)
00004E7A:       RET M
00004E7B:       NOP
00004E7C:       ADD B
00004E7D:       LD A,D
00004E7E:       LD (DE),A
00004E7F:       LD A,D
00004E80:       JR Z,+7Ah
00004E82:       JR Z,+7Ah
00004E84:       LD A,7Ah
00004E86:       LD D,H
00004E87:       LD A,D
00004E88:       CALL M,6A79h
00004E8B:       LD A,D
00004E8C:       CALL ED00h
00004E8F:       PUSH HL
00004E90:       PUSH DE
00004E91:       PUSH AF
00004E92:       LD DE,0004h
00004E95:       ADD HL,DE
00004E96:       LD A,FFh
00004E98:       SUB (HL)
00004E99:       ADD A
00004E9A:       LD E,A
00004E9B:       CALL ED03h
00004E9E:       LD D,00h
00004EA0:       LD HL,4E7Ch
00004EA3:       ADD HL,DE
00004EA4:       LD E,(HL)
00004EA5:       INC HL
00004EA6:       LD D,(HL)
00004EA7:       POP AF
00004EA8:       LD L,A
00004EA9:       LD H,00h
00004EAB:       ADD HL,DE
00004EAC:       LD E,(HL)
00004EAD:       INC HL
00004EAE:       LD D,(HL)
00004EAF:       EX DE,HL
00004EB0:       POP DE
00004EB1:       EX HL,(SP)
00004EB2:       RET

00004EB3:       CALL 4EE4h
00004EB6:       PUSH BC
00004EB7:       EX HL,(SP)
00004EB8:       POP BC
00004EB9:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00004EBA:       LD A,(HL)
00004EBB:       LD (BC),A
00004EBC:       RET Z
00004EBD:       DEC BC
00004EBE:       DEC HL
00004EBF:       JR -08h

; CHKSTK:
00004EC1:       PUSH HL
00004EC2:       LD HL,(EACCh)			; STREND (aka STRTOP) - string area top address
00004EC5:       LD B,00h
00004EC7:       ADD HL,BC
00004EC8:       ADD HL,BC
00004EC9:       LD A,C6h
00004ECB:       SUB L
00004ECC:       LD L,A
00004ECD:       LD A,FFh
00004ECF:       SBC H
00004ED0:       LD H,A
00004ED1:       JR C,+03h			; OMERR
00004ED3:       ADD HL,SP
00004ED4:       POP HL
00004ED5:       RET C

; OMERR - handle stack pointer before issuing an 'out of memory error'
00004ED6:       LD HL,(E654h)			; STKTOP
00004ED9:       DEC HL
00004EDA:       DEC HL
00004EDB:       LD (EB07h),HL			; SAVSTK
00004EDE:       LD DE,0007h
00004EE1:       JP 03B3h				; ERROR, code in E


00004EE4:       CALL 4EF7h
00004EE7:       RET NC
00004EE8:       PUSH BC
00004EE9:       PUSH DE
00004EEA:       PUSH HL
00004EEB:       CALL 559Ah
00004EEE:       POP HL
00004EEF:       POP DE
00004EF0:       POP BC
00004EF1:       CALL 4EF7h
00004EF4:       RET NC
00004EF5:       JR -19h

00004EF7:       PUSH DE
00004EF8:       EX DE,HL
00004EF9:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
00004EFC:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00004EFD:       EX DE,HL
00004EFE:       POP DE
00004EFF:       RET

__NEW:
00004F00:       RET NZ
; CLRPTR
00004F01:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00004F04:       CALL 44A4h			; bank switching pivot (write)
00004F07:       DEC HL
00004F08:       LD (HL),00h
00004F0A:       INC HL
00004F0B:       CALL 5159h
00004F0E:       LD (EC29h),A
00004F11:       LD (EB00h),A		; AUTFLG - enable flag for AUTO editor command
00004F14:       LD (EAFFh),A		; PTRFLG
00004F17:       LD (HL),A
00004F18:       INC HL
00004F19:       LD (HL),A
00004F1A:       INC HL
00004F1B:       CALL 44D5h			; bank switching pivot (read)
00004F1E:       LD (EB18h),HL			; ARYTAB - Pointer to begin of array table

;; RUNFST:
RUN_FST:
  ; Clear all variables
00004F21:       CALL ED96h			; ?HRUNC?   Hook 1 for RUN-Clear ?
00004F24:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00004F27:       CALL 44A4h			; bank switching pivot (write)
00004F2A:       DEC HL

;; INTVAR:
_CLVAR:
  ; Initialise RUN variables
00004F2B:       LD A,(E69Fh)
00004F2E:       OR A
00004F2F:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
00004F32:       CALL ED84h			; ?HCLEA? -  Hook 2 for RUN-Clear ?
00004F35:       CALL 44D5h			; bank switching pivot (read)
00004F38:       LD (EAFDh),HL		; TEMP - temp. reservation for st.code
00004F3B:       CALL 5045h
00004F3E:       CALL EDD2h
00004F41:       LD A,(EC2Ah)
00004F44:       OR A
00004F45:       JR NZ,+14h

00004F47:       XOR A
00004F48:       LD (EC20h),A
00004F4B:       LD (EC1Fh),A

00004F4E:       LD B,1Ah
00004F50:       LD HL,EB23h			; DEFTBL
00004F53:       CALL ED8Dh			; ?HLOPD? -  Hook 3 for RUN-Clear ?
00004F56:       LD (HL),04h
00004F58:       INC HL
00004F59:       DJNZ -05h
00004F5B:       LD DE,2F07h
00004F5E:       LD HL,E631h
00004F61:       CALL 20F7h			; DEC_DE2HL -  copy 4 byte FP number from DE to HL
00004F64:       LD HL,E60Eh
00004F67:       XOR A
00004F68:       LD (HL),A
00004F69:       INC HL
00004F6A:       LD (HL),A
00004F6B:       INC HL
00004F6C:       LD (HL),A
00004F6D:       XOR A
00004F6E:       LD (EB0Fh),A		; ONEFLG - flag for "ON ERROR"
00004F71:       LD L,A
00004F72:       LD H,A
00004F73:       LD (EB0Dh),HL		; ONELIN - LINE to go when error
00004F76:       LD (EB14h),HL			; OLDTXT - prg pointer for CONT
00004F79:       LD HL,(EACCh)			; STREND (aka STRTOP) - string area top address
00004F7C:       LD A,(EC30h)
00004F7F:       OR A
00004F80:       JR NZ,+03h
00004F82:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
00004F85:       XOR A
00004F86:       CALL 50A5h		; _RESTORE
00004F89:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00004F8C:       LD (EB1Bh),HL	; VARTAB
00004F8F:       LD (EB1Ah),A
00004F92:       LD (EB1Dh),HL	; VAREND - End of variables
00004F95:       LD (EB1Fh),HL	; ARREND - End of arrays
00004F98:       LD A,(EC2Ah)
00004F9B:       OR A
00004F9C:       CALL Z,4B0Ch		; CLSALL - Close all files/streams
00004F9F:       LD A,(ECA3h)		; NLONLY
00004FA2:       AND 01h
00004FA4:       JR NZ,+03h
00004FA6:       LD (ECA3h),A		; NLONLY
00004FA9:       POP BC
00004FAA:       LD HL,(E654h)		; STKTOP
00004FAD:       DEC HL
00004FAE:       DEC HL
00004FAF:       LD (EB07h),HL		; SAVSTK
00004FB2:       INC HL
00004FB3:       INC HL

; WARM_ENTRY
00004FB4:       CALL ED72h
00004FB7:       LD SP,HL
00004FB8:       LD HL,EAD0h			; TEMPST - temporary descriptors
00004FBB:       LD (EACEh),HL		; TEMPPT - start of free area of temporary descriptor
00004FBE:       CALL 1DD4h
00004FC1:       CALL 5989h			; STOP_LPT -  Stop and reset line printer
00004FC4:       CALL 0F8Bh			; FINPRT - finalize PRINT
00004FC7:       XOR A
00004FC8:       LD H,A
00004FC9:       LD L,A
00004FCA:       LD (EB3Fh),HL		; PRMLEN - number of bytes of obj table
00004FCD:       LD (EC10h),A		; NOFUNS - 0 if no function active
00004FD0:       LD (EBA7h),HL		; PRMLN2 - size of parameter block
00004FD3:       LD (EC13h),HL		; FUNACT - active functions counter
00004FD6:       LD (EB3Dh),HL		; PRMSTK - previous block definition on stack
00004FD9:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
00004FDC:       PUSH HL
00004FDD:       PUSH BC

00004FDE:       LD HL,(EAFDh)		; TEMP - temp. reservation for st.code
00004FE1:       CALL 44A4h			; bank switching pivot (write)
00004FE4:       RET

00004FE5:       DI
00004FE6:       LD A,(HL)
00004FE7:       AND 04h
00004FE9:       OR 01h
00004FEB:       CP (HL)
00004FEC:       LD (HL),A
00004FED:       JR Z,+04h
00004FEF:       AND 04h
00004FF1:       JR NZ,+33h
00004FF3:       EI
00004FF4:       RET

; A=(HL), (HL)=0
00004FF5:       DI
00004FF6:       LD A,(HL)
00004FF7:       LD (HL),00h
00004FF9:       JR +07h

; A=(HL), (HL)|=2..
00004FFB:       DI
00004FFC:       LD A,(HL)
00004FFD:       PUSH AF
00004FFE:       OR 02h
00005000:       LD (HL),A
00005001:       POP AF
00005002:       XOR 05h
00005004:       JR Z,+33h
00005006:       EI
00005007:       RET

00005008:       DI
00005009:       LD A,(HL)
0000500A:       AND 05h
0000500C:       CP (HL)
0000500D:       LD (HL),A
0000500E:       JR NZ,+0Fh
00005010:       EI
00005011:       RET

00005012:       DI
00005013:       LD A,(HL)
00005014:       AND 01h
00005016:       JR Z,+0Bh
00005018:       LD A,(HL)
00005019:       OR 04h
0000501B:       CP (HL)
0000501C:       JR Z,+05h
0000501E:       LD (HL),A
0000501F:       XOR 05h
00005021:       JR Z,+03h
00005023:       EI
00005024:       RET

00005025:       DI
00005026:       LD A,(E6F1h)		; ONGSBF - flag for "ON GOSUB"
00005029:       INC A
0000502A:       LD (E6F1h),A		; ONGSBF - flag for "ON GOSUB"
0000502D:       EI
0000502E:       RET

0000502F:       DI
00005030:       LD A,(HL)
00005031:       AND 03h
00005033:       CP (HL)
00005034:       LD (HL),A
00005035:       JR NZ,+02h
00005037:       EI
00005038:       RET

00005039:       LD A,(E6F1h)		; ONGSBF - flag for "ON GOSUB"
0000503C:       SUB 01h
0000503E:       JR C,-09h
00005040:       LD (E6F1h),A		; ONGSBF - flag for "ON GOSUB"
00005043:       EI
00005044:       RET

00005045:       LD HL,(E6EFh)
00005048:       LD A,(E6EEh)
0000504B:       LD B,A
0000504C:       XOR A
0000504D:       LD (HL),A
0000504E:       INC HL
0000504F:       LD (HL),A
00005050:       INC HL
00005051:       LD (HL),A
00005052:       INC HL
00005053:       DJNZ -08h
00005055:       LD (E6F1h),A		; ONGSBF - flag for "ON GOSUB"
00005058:       RET

00005059:       LD A,(EB0Fh)		; ONEFLG - flag for "ON ERROR"
0000505C:       OR A
0000505D:       RET NZ
0000505E:       PUSH HL
0000505F:       LD HL,(E656h)			; CURLIN - line number being interpreted
00005062:       LD A,H
00005063:       AND L
00005064:       INC A
00005065:       JR Z,+19h

00005067:       LD HL,(E6EFh)
0000506A:       LD A,(E6EEh)
0000506D:       LD B,A
0000506E:       LD DE,0003h
00005071:       LD A,(HL)
00005072:       RRCA
00005073:       JR NC,+08h
00005075:       RRCA
00005076:       JR C,+05h
00005078:       RRCA
00005079:       JR C,+07h
0000507B:       CP D1h
0000507D:       ADD HL,DE
0000507E:       DJNZ -0Fh
00005080:       POP HL
00005081:       RET

00005082:       PUSH DE
00005083:       PUSH BC
00005084:       INC HL
00005085:       LD E,(HL)
00005086:       INC HL
00005087:       LD D,(HL)
00005088:       DEC HL
00005089:       DEC HL
0000508A:       LD A,D
0000508B:       OR E
0000508C:       POP BC
0000508D:       JR Z,-13h
0000508F:       POP AF
00005090:       PUSH DE
00005091:       PUSH HL
00005092:       CALL 502Fh
00005095:       CALL 4FFBh			; A=(HL), (HL)|=2..
00005098:       LD C,03h
0000509A:       CALL 4EC1h			; CHKSTK
0000509D:       POP BC
0000509E:       POP DE
0000509F:       POP HL
000050A0:       EX HL,(SP)
000050A1:       POP HL
000050A2:       JP 0BE0h

_RESTORE:
000050A5:       EX DE,HL
000050A6:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
000050A9:       JR Z,+19h
000050AB:       EX DE,HL
000050AC:       CALL 0B0Bh				; LNUM_PARM - Read numeric function parameter
000050AF:       CALL 44D5h			; bank switching pivot (read)
000050B2:       PUSH HL
000050B3:       CALL 0605h			; SRCHLN  -  Get first line number
000050B6:       LD H,B
000050B7:       LD L,C
000050B8:       POP DE
000050B9:       JP NC,0C3Ch			; ULERR - entry for '?UL ERROR'
000050BC:       CALL 44D5h			; bank switching pivot (read)
000050BF:       EX DE,HL
000050C0:       CALL 44A4h			; bank switching pivot (write)
000050C3:       EX DE,HL
000050C4:       DEC HL
; __RESTORE_1
000050C5:       LD (EB21h),HL		; DATPTR
000050C8:       EX DE,HL
000050C9:       RET

_STOP:
000050CA:       JP NZ,72B0h			; used by _STOP
000050CD:       RET NZ
000050CE:       PUSH AF
000050CF:       LD A,FFh				; Select main ROM bank
000050D1:       OUTA (71h)				; Extended ROM bank switching
000050D3:       POP AF
000050D4:       PUSH HL
000050D5:       LD HL,(E656h)			; CURLIN - line number being interpreted
000050D8:       LD (EFBEh),HL
000050DB:       LD HL,(EFBAh)
000050DE:       LD (EFBCh),HL
000050E1:       POP HL
000050E2:       INC A
000050E3:       JR +06h			; __END_00

_END:
000050E5:       RET NZ
000050E6:       PUSH AF
000050E7:       CALL Z,4B0Ch			; CLSALL - Close all files/streams
000050EA:       POP AF
000050EB:       CALL 44D5h			; bank switching pivot (read)
; __END_00
000050EE:       LD (EB05h),HL			; SAVTXT - prg pointer for resume
000050F1:       LD HL,EAD0h				; TEMPST - temporary descriptors
000050F4:       LD (EACEh),HL			; TEMPPT - start of free area of temporary descriptor
000050F7:       DEFB 21h	; LD HL,FFF6h			;L63FD+1:  OR $FF
000050F8:       OR FFh
000050FA:       POP BC
; __END_1
000050FB:       LD HL,(E656h)			; CURLIN - line number being interpreted
000050FE:       PUSH HL
000050FF:       PUSH AF
00005100:       LD A,L
00005101:       AND H
00005102:       INC A
00005103:       JR Z,+09h
00005105:       LD (EB12h),HL			; OLDLIN - old line number set up ^C ...
00005108:       LD HL,(EB05h)			; SAVTXT - prg pointer for resume
0000510B:       LD (EB14h),HL			; OLDTXT - prg pointer for CONT
0000510E:       XOR A
0000510F:       LD (E652h),A
00005112:       LD A,(E69Fh)
00005115:       OR A
00005116:       JP NZ,75D8h
00005119:       CALL 5989h			; STOP_LPT -  Stop and reset line printer
0000511C:       CALL 5A58h			; CONSOLE_CRLF
0000511F:       POP AF
00005120:       LD HL,0320h			; "Break"
00005123:       JP NZ,045Fh
00005126:       JP 047Ah


00005129:       LD A,0Fh		; ^O
; print CTRL code (e.g. ^C)
0000512B:       PUSH AF
0000512C:       SUB 03h
0000512E:       JR NZ,+06h
00005130:       LD (E64Ch),A		; PRTFLG ("printer enabled" flag)
00005133:       LD (E652h),A
00005136:       LD A,5Eh	; '^'
00005138:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
00005139:       POP AF
0000513A:       ADD 40h		; convert to ASCII (e.g. 3=C)
0000513C:       RST 20h		; (OUTDO??)  CPDEHL - compare DE and HL (aka DCOMPR)
0000513D:       JP 5A69h	; OUTDO_CRLF

_CONT:
00005140:       LD HL,(EB14h)			; OLDTXT - prg pointer for CONT
00005143:       LD A,H
00005144:       OR L
00005145:       LD DE,0011h
00005148:       JP Z,03B3h				; ERROR, code in E
0000514B:       CALL 44A4h			; bank switching pivot (write)
0000514E:       LD DE,(EB12h)			; OLDLIN - old line number set up ^C ...
00005152:       EX DE,HL
00005153:       LD (E656h),HL			; CURLIN - line number being interpreted
00005156:       EX DE,HL
00005157:       RET

_TRON:
00005158:       LD A,AFh
_TROFF:
0000515A:       LD (EC3Bh),A			; TRCFLG - FLAG for 'TRACE' status
0000515D:       RET

_SWAP:
0000515E:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00005161:       PUSH DE
00005162:       PUSH HL
00005163:       LD HL,EC33h			; SWPTMP
00005166:       CALL 20FCh			; FP2HL - copy number value from DE to HL
00005169:       LD HL,(EB1Dh)		; VAREND - End of variables
0000516C:       EX HL,(SP)
0000516D:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
0000516E:       PUSH AF
0000516F:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00005170:       DEFB ','
00005171:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00005174:       POP AF
00005175:       LD B,A
00005176:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00005177:       CP B
00005178:       JP NZ,03B1h		; TYPE_ERR, "Type mismatch" error
0000517B:       EX HL,(SP)
0000517C:       EX DE,HL
0000517D:       PUSH HL
0000517E:       LD HL,(EB1Dh)	; VAREND - End of variables
00005181:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00005182:       JR NZ,+10h
00005184:       POP DE
00005185:       POP HL
00005186:       EX HL,(SP)
00005187:       PUSH DE
00005188:       CALL 20FCh		; FP2HL - copy number value from DE to HL
0000518B:       POP HL
0000518C:       LD DE,EC33h		; SWPTMP
0000518F:       CALL 20FCh		; FP2HL - copy number value from DE to HL
00005192:       POP HL
00005193:       RET

00005194:       JP 0B06h			; FCERR, Err $05 - "Illegal function call"
00005197:       LD B,FFh
00005199:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000519A:       LD A,B
0000519B:       CP AFh				; TK_WHILE ?
0000519D:       CALL 18B0h
000051A0:       LD A,01h
000051A2:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
000051A5:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
000051A8:       JR NZ,-16h
000051AA:       PUSH HL
000051AB:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
000051AE:       LD H,B
000051AF:       LD L,C
000051B0:       DEC BC
000051B1:       DEC BC
000051B2:       DEC BC
000051B3:       LD A,(BC)
000051B4:       DEC BC
000051B5:       OR A
000051B6:       JP M,51B3h
000051B9:       DEC BC
000051BA:       DEC BC
000051BB:       XOR A
000051BC:       NOP
000051BD:       NOP
000051BE:       OR A
000051BF:       JR NZ,+1Ah
000051C1:       ADD HL,DE
000051C2:       EX DE,HL
000051C3:       LD HL,(EB1Fh)	; ARREND - End of arrays
000051C6:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000051C7:       LD A,(DE)
000051C8:       LD (BC),A
000051C9:       INC DE
000051CA:       INC BC
000051CB:       JR NZ,-07h
000051CD:       DEC BC
000051CE:       LD H,B
000051CF:       LD L,C
000051D0:       LD (EB1Fh),HL	; ARREND - End of arrays
000051D3:       POP HL
000051D4:       LD A,(HL)
000051D5:       CP 2Ch		; ','
000051D7:       RET NZ
000051D8:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000051D9:       JR -3Fh
000051DB:       PUSH BC
000051DC:       LD A,C
000051DD:       SUB E
000051DE:       LD C,A
000051DF:       CALL 4400h
000051E2:       POP BC
000051E3:       RET

; init TTYPOS2 + CRTSET - on stack: columns, rows
000051E4:       LD A,B
000051E5:       LD (E64Fh),A		; TTYPOS2
000051E8:       JP 6F6Ah			; CRTSET - on stack: columns, rows

000051EB:       LD A,(F153h)
000051EE:       OR A
000051EF:       JR Z,+05h
000051F1:       LD A,FFh
000051F3:       LD (F153h),A
000051F6:       LD A,(F154h)
000051F9:       OR A
000051FA:       JR Z,+05h
000051FC:       LD A,0Fh
000051FE:       LD (F154h),A
00005201:       JP 750Fh

00005204:       XOR A
00005205:       OUTA (F3h)
00005207:       LD HL,0174h
0000520A:       DEC HL
0000520B:       LD A,H
0000520C:       OR L
0000520D:       JR NZ,-05h
0000520F:       RET
00005210:       JR -10h
00005212:       POP AF
00005213:       POP HL
00005214:       RET

; IS_ALPHA - Load A with char in (HL) and check it is a letter
00005215:       LD A,(HL)

; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00005216:       CP 41h		; 'A'
00005218:       RET C
00005219:       CP 5Bh		; '['
0000521B:       CCF
0000521C:       RET

; _CLEAR_0
0000521D:       CALL 4F2Bh			; _CLVAR - Initialise RUN variables
00005220:       CALL 44D5h			; bank switching pivot (read)
00005223:       PUSH HL
00005224:       CALL 53F6h
00005227:       POP HL
00005228:       CALL 44A4h			; bank switching pivot (write)
0000522B:       JP 0996h			; NEWSTT

_CLEAR:
0000522E:       PUSH AF
0000522F:       LD A,(E69Fh)
00005232:       OR A
00005233:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
00005236:       POP AF
00005237:       JR Z,-1Ch	; _CLEAR_0
00005239:       CP 2Ch		; ','
0000523B:       JR Z,+07h
0000523D:       CALL 0B02h
00005240:       DEC HL
00005241:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005242:       JR Z,-27h
00005244:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00005245:       DEFB ','
00005246:       JR Z,-2Bh
00005248:       LD DE,(E654h)		; STKTOP
0000524C:       CP 2Ch		; ','
0000524E:       JR Z,+13h
00005250:       CALL 5299h
00005253:       PUSH HL
00005254:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00005257:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00005258:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
0000525B:       LD HL,(E7E8h)
0000525E:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
0000525F:       JP C,0B06h			; FCERR, Err $05 - "Illegal function call"
00005262:       POP HL
00005263:       DEC HL
00005264:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.

00005265:       PUSH DE
00005266:       JR Z,+3Dh
00005268:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00005269:       DEFB ','
0000526A:       JR Z,+39h
0000526C:       CALL 5299h
0000526F:       DEC HL
00005270:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005271:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00005274:       EX HL,(SP)
00005275:       PUSH HL
00005276:       LD HL,004Eh
00005279:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
0000527A:       JR NC,+26h
0000527C:       POP HL
0000527D:       CALL 52B6h
00005280:       JR C,+20h
00005282:       PUSH HL
00005283:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00005286:       LD BC,0014h
00005289:       ADD HL,BC
0000528A:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
0000528B:       JR NC,+15h
0000528D:       EX DE,HL
0000528E:       LD (EACCh),HL			; STREND (aka STRTOP) - string area top address
00005291:       POP HL
00005292:       LD (E654h),HL		; STKTOP
00005295:       POP HL
00005296:       JP 521Dh

00005299:       CALL 1B93h			; GETWORD
0000529C:       LD A,D
0000529D:       OR E
0000529E:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
000052A1:       RET

000052A2:       JP 4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'

000052A5:       PUSH HL
000052A6:       LD HL,(E654h)		; STKTOP
000052A9:       EX DE,HL
000052AA:       LD HL,(EACCh)			; STREND (aka STRTOP) - string area top address
000052AD:       LD A,E
000052AE:       SUB L
000052AF:       LD E,A
000052B0:       LD A,D
000052B1:       SBC H
000052B2:       LD D,A
000052B3:       POP HL
000052B4:       JR -42h

000052B6:       LD A,L
000052B7:       SUB E
000052B8:       LD E,A
000052B9:       LD A,H
000052BA:       SBC D
000052BB:       LD D,A
000052BC:       RET

_NEXT:
000052BD:       PUSH AF
000052BE:       OR AFh
000052C0:       LD (EC18h),A
000052C3:       POP AF
000052C4:       LD DE,0000h

__NEXT_0:
000052C7:       PUSH HL
000052C8:       CALL 44D5h			; bank switching pivot (read)
000052CB:       LD (EC16h),HL
000052CE:       POP HL
000052CF:       CALL NZ,5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
000052D2:       LD (EAFDh),HL		; TEMP - temp. reservation for st.code
000052D5:       CALL 0346h			; search 'FOR' block
000052D8:       JP NZ,039Fh				; "NEXT without FOR" error
000052DB:       LD SP,HL
000052DC:       PUSH DE
000052DD:       LD E,(HL)
000052DE:       INC HL
000052DF:       LD D,(HL)
000052E0:       INC HL
000052E1:       PUSH HL
000052E2:       LD HL,(EC16h)
000052E5:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000052E6:       JP NZ,039Fh				; "NEXT without FOR" error
000052E9:       POP HL
000052EA:       POP DE
000052EB:       PUSH DE
000052EC:       LD A,(HL)
000052ED:       PUSH AF
000052EE:       INC HL
000052EF:       PUSH DE
000052F0:       LD A,(HL)
000052F1:       INC HL
000052F2:       OR A
000052F3:       JP M,5319h
000052F6:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
000052F9:       EX HL,(SP)
000052FA:       PUSH HL
000052FB:       LD A,(EC18h)
000052FE:       OR A
000052FF:       JR NZ,+07h
00005301:       LD HL,EC19h
00005304:       CALL 20DAh			; PHLTFP - Number at HL to BCDE
00005307:       XOR A
00005308:       CALL NZ,1DDEh
0000530B:       POP HL
0000530C:       CALL 20F4h			; DEC_FACCU2HL - copy number value from FPREG (FP accumulator) to HL
0000530F:       POP HL
00005310:       CALL 20EBh			; LOADFP - Load FP value pointed by HL to BCDE
00005313:       PUSH HL
00005314:       CALL 2134h			;  CMPNUM - Compare FP reg to BCDE
00005317:       JR +34h

00005319:       INC HL
0000531A:       INC HL
0000531B:       INC HL
0000531C:       INC HL
0000531D:       LD C,(HL)
0000531E:       INC HL
0000531F:       LD B,(HL)
00005320:       INC HL
00005321:       EX HL,(SP)
00005322:       LD E,(HL)
00005323:       INC HL
00005324:       LD D,(HL)
00005325:       PUSH HL
00005326:       LD L,C
00005327:       LD H,B
00005328:       LD A,(EC18h)
0000532B:       OR A
0000532C:       JR NZ,+05h
0000532E:       LD HL,(EC19h)
00005331:       JR +0Bh

00005333:       CALL 233Ah			; IADD - Integer ADD
00005336:       LD A,(EABDh)		; VALTYP - type indicator
00005339:       CP 04h
0000533B:       JP Z,03ABh			; "Overflow" error
0000533E:       EX DE,HL
0000533F:       POP HL
00005340:       LD (HL),D
00005341:       DEC HL
00005342:       LD (HL),E
00005343:       POP HL
00005344:       PUSH DE
00005345:       LD E,(HL)
00005346:       INC HL
00005347:       LD D,(HL)
00005348:       INC HL
00005349:       EX HL,(SP)
0000534A:       CALL 215Fh			; ICOMP - INTEGER COMPARE
0000534D:       POP HL
0000534E:       POP BC
0000534F:       SUB B
00005350:       CALL 20EBh			; LOADFP - Load FP value pointed by HL to BCDE
00005353:       JR Z,+0Ch           ; KILFOR - IF SIGN(FINAL-CURRENT)+SIGN(STEP)=0, then loop finished - Terminate it
00005355:       EX DE,HL            ; Loop statement line number
00005356:       LD (E656h),HL		; Set loop line number
00005359:       LD L,C              ; Set code string to loop
0000535A:       LD H,B
0000535B:       CALL 44A4h			; bank switching pivot (write)
0000535E:       JP 0992h            ; PUTFID
  
; Remove "FOR" block
KILFOR:
00005361:       LD SP,HL            ; SINCE [H,L] MOVED ALL THE WAY DOWN THE ENTRY
00005362:       LD (EB07h),HL		; SAVSTK - Code string after "NEXT"
00005365:       LD HL,(EAFDh)		; TEMP - temp. reservation for st.code
00005368:       LD A,(HL)           ; Get next byte in code string
00005369:       CP 2Ch		        ; ','  More NEXTs ?
0000536B:       JP NZ,0996h			; No - Do next statement
0000536E:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000536F:       CALL 52C7h          ; __NEXT_0
; < will not RETurn to here , Exit to NEWSTT (RUNCNT) or Loop >


; ISFLIO - Tests if I/O to device is taking place
00005372:       CALL ED99h			;  ?HISFL? - Hook for ISFLIO std routine?
00005375:       PUSH HL
00005376:       LD HL,(EC88h)		; PTRFIL
00005379:       LD A,H
0000537A:       OR L
0000537B:       POP HL
0000537C:       RET

0000537D:       PUSH HL
0000537E:       EX DE,HL
0000537F:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00005382:       PUSH DE
00005383:       LD DE,(EB1Bh)	; VARTAB
00005387:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00005388:       JR Z,+20h
0000538A:       POP DE
0000538B:       LD A,(HL)
0000538C:       LD C,A
0000538D:       INC HL
0000538E:       PUSH HL
0000538F:       INC HL
00005390:       INC HL
00005391:       CP B
00005392:       JR NZ,+0Bh
00005394:       PUSH BC
00005395:       PUSH DE
00005396:       PUSH HL
00005397:       CALL 5471h
0000539A:       POP HL
0000539B:       POP DE
0000539C:       POP BC
0000539D:       JR Z,+08h
0000539F:       POP AF
000053A0:       LD A,B
000053A1:       LD B,00h
000053A3:       ADD HL,BC
000053A4:       LD B,A
000053A5:       JR -25h
000053A7:       POP DE
000053A8:       POP HL
000053A9:       RET
000053AA:       LD A,01h
000053AC:       OR A
000053AD:       JR -08h
000053AF:       PUSH HL
000053B0:       LD B,00h
000053B2:       LD A,(HL)
000053B3:       CP 2Eh		; '.'
000053B5:       JR Z,+10h
000053B7:       CP 30h
000053B9:       JP C,53CBh
000053BC:       CP 3Ah		; ':'
000053BE:       JP C,53C7h
000053C1:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
000053C4:       JP C,53CBh
000053C7:       INC B
000053C8:       INC HL
000053C9:       JR -19h
000053CB:       POP HL
000053CC:       LD A,B
000053CD:       OR A
000053CE:       JP Z,06CFh
000053D1:       RET

000053D2:       PUSH HL
000053D3:       PUSH DE
000053D4:       CALL 53AFh
000053D7:       CALL 537Dh
000053DA:       JP Z,06D0h
000053DD:       LD DE,(EB1Bh)		; VARTAB
000053E1:       LD A,B
000053E2:       LD (DE),A
000053E3:       INC DE
000053E4:       EX HL,(SP)
000053E5:       LD A,L
000053E6:       LD (DE),A
000053E7:       INC DE
000053E8:       LD A,H
000053E9:       LD (DE),A
000053EA:       INC DE
000053EB:       POP HL
000053EC:       CALL 5479h
000053EF:       EX DE,HL
000053F0:       LD (EB1Bh),HL		; VARTAB
000053F3:       EX DE,HL
000053F4:       POP HL
000053F5:       RET

000053F6:       PUSH HL
000053F7:       CALL EDE7h
000053FA:       PUSH AF
000053FB:       LD A,(EB1Ah)
000053FE:       OR A
000053FF:       JR NZ,+38h

00005401:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00005404:       CALL 44A4h			; bank switching pivot (write)
00005407:       LD A,(HL)
00005408:       INC HL
00005409:       OR (HL)
0000540A:       JR Z,+2Dh

0000540C:       LD E,L
0000540D:       LD D,H
0000540E:       DEC HL
0000540F:       PUSH HL
00005410:       DEC DE
00005411:       DEC DE
00005412:       EX DE,HL
00005413:       CALL 44D5h			; bank switching pivot (read)
00005416:       EX DE,HL
00005417:       INC HL
00005418:       INC HL
00005419:       INC HL
0000541A:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000541B:       CP F5h
0000541D:       JR NZ,+04h
0000541F:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005420:       CALL 53D2h
00005423:       POP HL
00005424:       LD A,(HL)
00005425:       INC HL
00005426:       LD H,(HL)
00005427:       LD L,A
00005428:       CALL 44A4h			; bank switching pivot (write)
0000542B:       LD A,(HL)
0000542C:       INC HL
0000542D:       OR (HL)
0000542E:       JR NZ,-24h
00005430:       LD HL,(EB1Bh)	; VARTAB
00005433:       LD (EB1Dh),HL	; VAREND - End of variables
00005436:       LD (EB1Fh),HL	; ARREND - End of arrays
00005439:       LD A,01h
0000543B:       LD (EB1Ah),A
0000543E:       POP AF
0000543F:       POP HL
00005440:       RET


00005441:       PUSH BC
00005442:       CALL 44D5h			; bank switching pivot (read)
00005445:       PUSH HL
00005446:       CALL EDEAh
00005449:       LD A,(EB1Ah)
0000544C:       OR A
0000544D:       CALL Z,53F6h
00005450:       POP HL
00005451:       CALL 44A4h			; bank switching pivot (write)
00005454:       LD A,0Dh
00005456:       LD (EAC2h),A			; CONSAV
00005459:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000545A:       CALL 53AFh
0000545D:       CALL 537Dh
00005460:       JP NZ,0399h
00005463:       LD A,(DE)
00005464:       INC DE
00005465:       LD C,A
00005466:       LD A,(DE)
00005467:       LD D,A
00005468:       LD E,C
00005469:       LD C,B
0000546A:       LD B,00h
0000546C:       ADD HL,BC
0000546D:       DEC HL
0000546E:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000546F:       POP BC
00005470:       RET
00005471:       LD A,(DE)
00005472:       CP (HL)
00005473:       RET NZ
00005474:       INC DE
00005475:       INC HL
00005476:       DJNZ -07h
00005478:       RET
00005479:       LD A,(HL)
0000547A:       LD (DE),A
0000547B:       INC DE
0000547C:       INC HL
0000547D:       DJNZ -06h
0000547F:       RET

00005480:       INC HL
00005481:       LD A,(HL)
00005482:       CP 2Eh		; '.'
00005484:       JR Z,-06h
00005486:       LD A,(HL)
00005487:       CP 30h
00005489:       RET C
0000548A:       CP 3Ah		; ':'
0000548C:       JR C,-0Eh
0000548E:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00005491:       JR NC,-13h
00005493:       RET

;
; THE FOLLOWING ROUTINE COMPARES TWO STRINGS
; ONE WITH DESC IN [D,E] OTHER WITH DESC. IN [FACLO, FACLO+1]
; A=0 IF STRINGS EQUAL
; A=377 IF B,C,D,E .GT. FACLO
; A=1 IF B,C,D,E .LT. FACLO
;
STRCMP:
00005494:       CALL 56C9h				; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
00005497:       LD A,(HL)               ; Get length of string            ;SAVE THE LENGTH OF THE FAC STRING IN [A]
00005498:       INC HL                  
00005499:       LD C,(HL)               ; Get LSB of address              ;SAVE THE POINTER AT THE FAC STRING DATA IN [B,C]
0000549A:       INC HL
0000549B:       LD B,(HL)
0000549C:       POP DE                  ; Restore string name             ;GET THE STACK STRING POINTER
0000549D:       PUSH BC                 ; Save address of string          ;SAVE THE POINTER AT THE FAC STRING DATA
0000549E:       PUSH AF                 ; Save length of string           ;SAVE THE FAC STRING LENGTH
0000549F:       CALL 56D0h				; GSTRDE  - Get second string     ;FREE UP THE STACK STRING AND RETURN
                                                                          ;THE POINTER TO THE STACK STRING DESCRIPTOR IN [H,L]
000054A2:       POP AF
000054A3:       LD D,A
000054A4:       LD E,(HL)
000054A5:       INC HL
000054A6:       LD C,(HL)
000054A7:       INC HL
000054A8:       LD B,(HL)
000054A9:       POP HL
000054AA:       LD A,E
000054AB:       OR D
000054AC:       RET Z
000054AD:       LD A,D
000054AE:       SUB 01h
000054B0:       RET C
000054B1:       XOR A
000054B2:       CP E
000054B3:       INC A
000054B4:       RET NC
000054B5:       DEC D
000054B6:       DEC E
000054B7:       LD A,(BC)
000054B8:       INC BC
000054B9:       CP (HL)
000054BA:       INC HL
000054BB:       JR Z,-13h
000054BD:       CCF
000054BE:       JP 2089h               ; SIGNS

_OCT:
000054C1:       CALL 2DBCh
000054C4:       JR +08h

_HEX$:
000054C6:       CALL 2DBFh
000054C9:       JR +03h

_STR$:
000054CB:       CALL 28D0h			; FOUT Convert number/expression to string (format not specified)
000054CE:       CALL 54FCh			; CRTST - Create String
000054D1:       CALL 56CCh			; GSTRCU - Get string pointed by FPREG

; ?SAVSTR? - Save string in string area
000054D4:       LD BC,571Eh			; TOPOOL - Save in string pool
000054D7:       PUSH BC
; SAVSTR_0:
000054D8:       LD A,(HL)
000054D9:       INC HL
000054DA:       PUSH HL
000054DB:       CALL 5572h			; TESTR - Test if enough room for string
000054DE:       POP HL
000054DF:       LD C,(HL)
000054E0:       INC HL
000054E1:       LD B,(HL)
000054E2:       CALL 54F1h			; CRTMST - Create string entry
000054E5:       PUSH HL
000054E6:       LD L,A
000054E7:       CALL 56C0h			; TOSTRA - Move string in BC, (len in L) to string area
000054EA:       POP DE
000054EB:       RET

; MK_1BYTE_TMST - make 1 byte long temporary string
000054EC:       LD A,01h
; MKTMST - Make temporary string
000054EE:       CALL 5572h			; TESTR - Test if enough room for string
; CRTMST - Create string entry
000054F1:       LD HL,EAEEh			; TMPSTR - Temporary string
000054F4:       PUSH HL
000054F5:       LD (HL),A
000054F6:       INC HL
000054F7:       LD (HL),E
000054F8:       INC HL
000054F9:       LD (HL),D
000054FA:       POP HL
000054FB:       RET

; CRTST - Create String
000054FC:       DEC HL
; QTSTR - Create quote terminated String
000054FD:       LD B,22h
000054FF:       LD D,B
; DTSTR - Create String, termination char in D
00005500:       PUSH HL
00005501:       LD C,FFh
00005503:       INC HL
00005504:       LD A,(HL)
00005505:       INC C
00005506:       OR A
00005507:       JR Z,+06h
00005509:       CP D
0000550A:       JR Z,+03h
0000550C:       CP B
0000550D:       JR NZ,-0Ch
0000550F:       CP 22h		; '"'
00005511:       CALL Z,0A0Dh			; _CHRGTB - Pick next char from program
00005514:       PUSH HL
00005515:       LD A,B
00005516:       CP 2Ch		; ','
00005518:       JR NZ,+0Ah
0000551A:       INC C
0000551B:       DEC C
0000551C:       JR Z,+06h
0000551E:       DEC HL
0000551F:       LD A,(HL)
00005520:       CP 20h		; ' '
00005522:       JR Z,-09h
00005524:       POP HL
00005525:       EX HL,(SP)
00005526:       INC HL
00005527:       EX DE,HL
00005528:       LD A,C
00005529:       CALL 54F1h			; CRTMST - Create string entry

; TSTOPL - Temporary string to pool
0000552C:       LD DE,EAEEh			; TMPSTR - Temporary string
0000552F:		DEFB $3E		; LD A,D5h
; 
00005530:		PUSH DE
00005531:       LD HL,(EACEh)		; TEMPPT - start of free area of temporary descriptor
00005534:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00005537:       LD A,03h			; String type
00005539:       LD (EABDh),A		; VALTYP - type indicator
0000553C:       CALL 20FCh			; FP2HL - copy number value from DE to HL
0000553F:       LD DE,EAF1h			; FRETOP - Starting address of unused area of string area
00005542:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005543:       LD (EACEh),HL		; TEMPPT - start of free area of temporary descriptor
00005546:       POP HL
00005547:       LD A,(HL)
00005548:       RET NZ
00005549:       LD DE,0010h			; Err $10 - "String formula too complex"
0000554C:       JP 03B3h				; ERROR, code in E

0000554F:       INC HL

; PRS - Print message pointed by HL
00005550:       CALL 54FCh			; CRTST - Create String
; PRS1
00005553:       CALL 56CCh			; GSTRCU - Get string pointed by FPREG
00005556:       INA (71h)			; get Extended ROM bank status
00005558:       PUSH AF
00005559:       NOP
0000555A:       NOP
0000555B:       NOP
0000555C:       NOP
0000555D:       CALL 20EDh			; LOADFP_0
00005560:       INC D
00005561:       DEC D
00005562:       JR Z,+0Ah
00005564:       CALL 3A8Fh
00005567:       NOP
00005568:       CALL Z,5A72h
0000556B:       INC BC
0000556C:       JR -0Dh
0000556E:       POP AF					; ROM bank mask ($FF or only one bit must be reset)
0000556F:       OUTA (71h)				; Extended ROM bank switching
00005571:       RET

; TESTR - Test if enough room for string
00005572:       OR A
00005573:       LD C,F1h
00005575:       PUSH AF
00005576:       LD HL,(EB1Fh)	; ARREND - End of arrays
00005579:       EX DE,HL
0000557A:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
0000557D:       CPL
0000557E:       LD C,A
0000557F:       LD B,FFh
00005581:       ADD HL,BC
00005582:       INC HL
00005583:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00005584:       JR C,+07h
00005586:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
00005589:       INC HL
0000558A:       EX DE,HL
0000558B:       POP AF
0000558C:       RET

; TESTR_1
0000558D:       POP AF
0000558E:       LD DE,000Eh		; Err $0E - "Out of string space"
00005591:       JP Z,03B3h				; ERROR, code in E
00005594:       CP A
00005595:       PUSH AF
00005596:       LD BC,5574h		; $5573+1
00005599:       PUSH BC
; TESTR_2
0000559A:       LD HL,(EACCh)			; STREND (aka STRTOP) - string area top address
0000559D:       LD A,(E69Fh)
000055A0:       OR A
000055A1:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
000055A4:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
000055A7:       LD HL,0000h
000055AA:       PUSH HL
000055AB:       LD HL,(EB1Fh)	; ARREND - End of arrays
000055AE:       PUSH HL
000055AF:       LD HL,EAD0h		; TEMPST - temporary descriptors
; L55B2:
000055B2:       LD DE,(EACEh)	; TEMPPT - start of free area of temporary descriptor
000055B6:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000055B7:       LD BC,55B2h		; L55B2
000055BA:       JP NZ,563Bh
000055BD:       LD HL,EBA5h		; PRMPRV
000055C0:       LD (EC11h),HL	; TEMP9
000055C3:       LD HL,(EB1Dh)	; VAREND - End of variables
000055C6:       LD (EC0Eh),HL		; ARYTA2
000055C9:       LD HL,(EB1Bh)		; VARTAB
; TESTR_4
000055CC:       LD DE,(EC0Eh)		; ARYTA2
000055D0:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
000055D1:       JR Z,+17h		; TESTR_6
000055D3:       LD A,(HL)
000055D4:       INC HL
000055D5:       INC HL
000055D6:       INC HL
000055D7:       PUSH AF
000055D8:       CALL 5D9Dh
000055DB:       POP AF
000055DC:       CP 03h
000055DE:       JR NZ,+04h		; TESTR_5
000055E0:       CALL 563Ch
000055E3:       XOR A
; TESTR_5
000055E4:       LD E,A
000055E5:       LD D,00h
000055E7:       ADD HL,DE
000055E8:       JR -1Eh			; TESTR_4
; TESTR_6
000055EA:       LD HL,(EC11h)	; TEMP9
000055ED:       LD E,(HL)
000055EE:       INC HL
000055EF:       LD D,(HL)
000055F0:       LD A,D
000055F1:       OR E
000055F2:       LD HL,(EB1Dh)	; VAREND - End of variables
000055F5:       JP Z,560Bh
000055F8:       EX DE,HL
000055F9:       LD (EC11h),HL	; TEMP9
000055FC:       INC HL
000055FD:       INC HL
000055FE:       LD E,(HL)
000055FF:       INC HL
00005600:       LD D,(HL)
00005601:       INC HL
00005602:       EX DE,HL
00005603:       ADD HL,DE
00005604:       LD (EC0Eh),HL		; ARYTA2
00005607:       EX DE,HL
00005608:       JR -3Eh
0000560A:       POP BC
0000560B:       LD DE,(EB1Fh)	; ARREND - End of arrays
0000560F:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00005610:       JP Z,565Ch
00005613:       LD A,(HL)
00005614:       INC HL
00005615:       PUSH AF
00005616:       INC HL
00005617:       INC HL
00005618:       CALL 5D9Dh
0000561B:       LD C,(HL)
0000561C:       INC HL
0000561D:       LD B,(HL)
0000561E:       INC HL
0000561F:       POP AF
00005620:       PUSH HL
00005621:       ADD HL,BC
00005622:       CP 03h
00005624:       JR NZ,-1Ch
00005626:       LD (EAF5h),HL		; TEMP8
00005629:       POP HL
0000562A:       LD C,(HL)
0000562B:       LD B,00h
0000562D:       ADD HL,BC
0000562E:       ADD HL,BC
0000562F:       INC HL
; L5630:
00005630:       EX DE,HL
00005631:       LD HL,(EAF5h)		; TEMP8
00005634:       EX DE,HL
00005635:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00005636:       JR Z,-2Dh
00005638:       LD BC,5630h		; L5630
0000563B:       PUSH BC
0000563C:       XOR A
0000563D:       OR (HL)
0000563E:       INC HL
0000563F:       LD E,(HL)
00005640:       INC HL
00005641:       LD D,(HL)
00005642:       INC HL
00005643:       RET Z
00005644:       LD B,H
00005645:       LD C,L
00005646:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
00005649:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000564A:       LD H,B
0000564B:       LD L,C
0000564C:       RET C
0000564D:       POP HL
0000564E:       EX HL,(SP)
0000564F:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00005650:       EX HL,(SP)
00005651:       PUSH HL
00005652:       LD H,B
00005653:       LD L,C
00005654:       RET NC
00005655:       POP BC
00005656:       POP AF
00005657:       POP AF
00005658:       PUSH HL
00005659:       PUSH DE
0000565A:       PUSH BC
0000565B:       RET

0000565C:       POP DE
0000565D:       POP HL
0000565E:       LD A,H
0000565F:       OR L
00005660:       RET Z
00005661:       DEC HL
00005662:       LD B,(HL)
00005663:       DEC HL
00005664:       LD C,(HL)
00005665:       PUSH HL
00005666:       DEC HL
00005667:       LD L,(HL)
00005668:       LD H,00h
0000566A:       ADD HL,BC
0000566B:       LD D,B
0000566C:       LD E,C
0000566D:       DEC HL
0000566E:       LD B,H
0000566F:       LD C,L
00005670:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
00005673:       CALL 4EB6h
00005676:       POP HL
00005677:       LD (HL),C
00005678:       INC HL
00005679:       LD (HL),B
0000567A:       LD H,B
0000567B:       LD L,C
0000567C:       DEC HL
0000567D:       JP 55A4h

; CONCAT - String concatenation
00005680:       PUSH BC
00005681:       PUSH HL
00005682:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00005685:       EX HL,(SP)
00005686:       CALL 1350h				; OPRND - Get next expression value
00005689:       EX HL,(SP)
0000568A:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
0000568D:       LD A,(HL)
0000568E:       PUSH HL
0000568F:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00005692:       PUSH HL
00005693:       ADD (HL)
00005694:       LD DE,000Fh
00005697:       JP C,03B3h				; ERROR, code in E
0000569A:       CALL 54EEh			; MKTMST - Make temporary string
0000569D:       POP DE
0000569E:       CALL 56D0h				; GSTRDE - Get string pointed by DE
000056A1:       EX HL,(SP)
000056A2:       CALL 56CFh				; GSTRHL - Get string pointed by HL
000056A5:       PUSH HL
000056A6:       LD HL,(EAEFh)			; TMPSTR+1
000056A9:       EX DE,HL
000056AA:       CALL 56B8h				; SSTSA - Move string on stack to string area
000056AD:       CALL 56B8h				; SSTSA - Move string on stack to string area
000056B0:       LD HL,11E6h			; EVAL2
000056B3:       EX HL,(SP)
000056B4:       PUSH HL
000056B5:       JP 552Ch				; TSTOPL - Temporary string to pool

; SSTSA - Move string on stack to string area
000056B8:       POP HL
000056B9:       EX HL,(SP)
000056BA:       LD A,(HL)
000056BB:       INC HL
000056BC:       LD C,(HL)
000056BD:       INC HL
000056BE:       LD B,(HL)
000056BF:       LD L,A
; TOSTRA - Move string in BC, (len in L) to string area
000056C0:       INC L
; TSALP - TOSTRA loop
000056C1:       DEC L
000056C2:       RET Z
000056C3:       LD A,(BC)
000056C4:       LD (DE),A
000056C5:       INC BC
000056C6:       INC DE
000056C7:       JR -08h

; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
000056C9:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
; GSTRCU - Get string pointed by FPREG
000056CC:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
; GSTRHL - Get string pointed by HL
000056CF:       EX DE,HL
; GSTRDE - Get string pointed by DE
000056D0:       CALL 56E7h		; BAKTMP - Back to last tmp-str entry
000056D3:       EX DE,HL
000056D4:       RET NZ
000056D5:       PUSH DE
000056D6:       LD D,B
000056D7:       LD E,C
000056D8:       DEC DE
000056D9:       LD C,(HL)
000056DA:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
000056DD:       RST 20h					; CPDEHL - compare DE and HL (aka DCOMPR)
000056DE:       JR NZ,+05h
000056E0:       LD B,A
000056E1:       ADD HL,BC
000056E2:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
000056E5:       POP HL
000056E6:       RET

; Back to last tmp-str entry
; BAKTMP:
000056E7:       CALL ED12h				; ? HFRET ?	- Hook for 'Free descriptor' event
000056EA:       LD HL,(EACEh)			; TEMPPT - start of free area of temporary descriptor
000056ED:       DEC HL
000056EE:       LD B,(HL)
000056EF:       DEC HL
000056F0:       LD C,(HL)
000056F1:       DEC HL
000056F2:       RST 20h					; CPDEHL - compare DE and HL (aka DCOMPR)
000056F3:       RET NZ
000056F4:       LD (EACEh),HL			; TEMPPT - start of free area of temporary descriptor
000056F7:       RET

_LEN:
000056F8:       LD BC,1589h				; UNSIGNED_RESULT_A
000056FB:       PUSH BC
__LEN_0:
000056FC:       CALL 56C9h				; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
000056FF:       XOR A
00005700:       LD D,A
00005701:       LD A,(HL)
00005702:       OR A
00005703:       RET

_ASC:
00005704:       LD BC,1589h				; UNSIGNED_RESULT_A
00005707:       PUSH BC
; __ASC_0
00005708:       CALL 56FCh			; __LEN_0
0000570B:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
0000570E:       INC HL
0000570F:       LD E,(HL)
00005710:       INC HL
00005711:       LD D,(HL)
00005712:       LD A,(DE)
00005713:       RET

_CHR$:
00005714:       CALL 54ECh		; MK_1BYTE_TMST - make 1 byte long temporary string
00005717:       CALL 18A6h				; MAKINT
; _CHR$_0:
0000571A:       LD HL,(EAEFh)			; TMPSTR+1
0000571D:       LD (HL),E

; TOPOOL - Save in string pool
0000571E:       POP BC
0000571F:       JP 552Ch				; TSTOPL - Temporary string to pool

_STRING$:
00005722:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005723:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00005724:       JR Z,-33h
00005726:       AND E
00005727:       JR -2Bh

00005729:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000572A:       DEFB ','
0000572B:       CALL 11D3h			; EVAL - evaluate expression
0000572E:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000572F:       DEFB ')'
00005730:       EX HL,(SP)
00005731:       PUSH HL
00005732:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00005733:       JR Z,+05h			; JP if string type

00005735:       CALL 18A6h				; MAKINT
00005738:       JR +03h

0000573A:       CALL 5708h			; __ASC_0
0000573D:       POP DE
0000573E:       CALL 5746h			; _STRING$_2

_SPACE$:
00005741:       CALL 18A6h			; MAKINT
00005744:       LD A,20h	; ' '
; _STRING$_2
00005746:       PUSH AF
00005747:       LD A,E
00005748:       CALL 54EEh			; MKTMST - Make temporary string
0000574B:       LD B,A
0000574C:       POP AF
0000574D:       INC B
0000574E:       DEC B
0000574F:       JR Z,-33h			; TOPOOL - Save in string pool
00005751:       LD HL,(EAEFh)		; TMPSTR+1
00005754:       LD (HL),A
00005755:       INC HL
00005756:       DJNZ -04h
00005758:       JR -3Ch				; TOPOOL - Save in string pool

_LEFT$:
0000575A:       CALL 57CFh			; LFRGNM - number in program listing and check for ending ')'
0000575D:       XOR A
; __LEFT_S_0:
0000575E:       EX HL,(SP)
0000575F:       LD C,A
00005760:       LD A,E5h
; __LEFT_S_1 = $5760+1
;; $5760+1:  PUSH HL
00005762:       PUSH HL
00005763:       LD A,(HL)
00005764:       CP B
00005765:       JR C,+02h
00005767:       LD A,B
00005768:       LD DE,000Eh
0000576B:       PUSH BC
0000576C:       CALL 5572h			; TESTR - Test if enough room for string
0000576F:       POP BC
00005770:       POP HL
00005771:       PUSH HL
00005772:       INC HL
00005773:       LD B,(HL)
00005774:       INC HL
00005775:       LD H,(HL)
00005776:       LD L,B
00005777:       LD B,00h
00005779:       ADD HL,BC
0000577A:       LD B,H
0000577B:       LD C,L
0000577C:       CALL 54F1h			; CRTMST - Create string entry
0000577F:       LD L,A
00005780:       CALL 56C0h			; TOSTRA - Move string in BC, (len in L) to string area
00005783:       POP DE
00005784:       CALL 56D0h			; GSTRDE - Get string pointed by DE
00005787:       JP 552Ch			; TSTOPL - Temporary string to pool

_RIGHT$:
0000578A:       CALL 57CFh			; LFRGNM - number in program listing and check for ending ')'
0000578D:       POP DE
0000578E:       PUSH DE
0000578F:       LD A,(DE)
00005790:       SUB B
00005791:       JR -35h

_MID$:
00005793:       EX DE,HL
00005794:       LD A,(HL)
00005795:       CALL 57D2h			; MIDNUM - Get number in program listing
00005798:       INC B
00005799:       DEC B
0000579A:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
0000579D:       PUSH BC
0000579E:       CALL 58D6h			; test ',' & ')'
000057A1:       POP AF
000057A2:       EX HL,(SP)
000057A3:       LD BC,5762h			; inside LEFT$
000057A6:       PUSH BC
000057A7:       DEC A
000057A8:       CP (HL)
000057A9:       LD B,00h
000057AB:       RET NC
000057AC:       LD C,A
000057AD:       LD A,(HL)
000057AE:       SUB C
000057AF:       CP E
000057B0:       LD B,A
000057B1:       RET C
000057B2:       LD B,E
000057B3:       RET

_VAL:
000057B4:       CALL 56FCh			; __LEN_0
000057B7:       JP Z,1589h			; UNSIGNED_RESULT_A
000057BA:       LD E,A
000057BB:       INC HL
000057BC:       LD A,(HL)
000057BD:       INC HL
000057BE:       LD H,(HL)
000057BF:       LD L,A
000057C0:       PUSH HL
000057C1:       ADD HL,DE
000057C2:       LD B,(HL)
000057C3:       LD (HL),D
000057C4:       EX HL,(SP)
000057C5:       PUSH BC
000057C6:       DEC HL
000057C7:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000057C8:       CALL 26B5h		; DBL_ASCTFP2
000057CB:       POP BC
000057CC:       POP HL
000057CD:       LD (HL),B
000057CE:       RET

; LFRGNM - number in program listing and check for ending ')'
000057CF:       EX DE,HL
000057D0:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000057D1:       DEFB ')'
; MIDNUM - Get number in program listing
000057D2:       POP BC
000057D3:       POP DE
000057D4:       PUSH BC
000057D5:       LD B,E
000057D6:       RET

_INSTR:
000057D7:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000057D8:       CALL 11D1h			; NEXT_PARENTH - pick next value after a parenthesis
000057DB:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
000057DC:       LD A,01h
000057DE:       PUSH AF
000057DF:       JR Z,+11h			; JP to FN_INSTR_0  if string type
000057E1:       POP AF
000057E2:       CALL 18A6h				; MAKINT
000057E5:       OR A
000057E6:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
000057E9:       PUSH AF
000057EA:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000057EB:       DEFB ','
000057EC:       CALL 11D3h			; EVAL - evaluate expression
000057EF:       CALL 2256h			; TSTSTR - Test a string, 'Type Error' if it is not
; FN_INSTR_0
000057F2:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000057F3:       DEFB ','
000057F4:       PUSH HL
000057F5:       LD HL,(EC41h)		; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000057F8:       EX HL,(SP)
000057F9:       CALL 11D3h			; EVAL - evaluate expression
000057FC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000057FD:       DEFB ')'
000057FE:       PUSH HL
000057FF:       CALL 56C9h			; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
00005802:       EX DE,HL
00005803:       POP BC
00005804:       POP HL
00005805:       POP AF
00005806:       PUSH BC
00005807:       LD BC,1FA5h			; POPHLRT - (POP HL / RET)
0000580A:       PUSH BC
0000580B:       LD BC,1589h			; UNSIGNED_RESULT_A
0000580E:       PUSH BC
0000580F:       PUSH AF
00005810:       PUSH DE
00005811:       CALL 56CFh			; GSTRHL - Get string pointed by HL
00005814:       POP DE
00005815:       POP AF
00005816:       LD B,A
00005817:       DEC A
00005818:       LD C,A
00005819:       CP (HL)
0000581A:       LD A,00h
0000581C:       RET NC
0000581D:       LD A,(DE)
0000581E:       OR A
0000581F:       LD A,B
00005820:       RET Z
00005821:       LD A,(HL)
00005822:       INC HL
00005823:       LD B,(HL)
00005824:       INC HL
00005825:       LD H,(HL)
00005826:       LD L,B
00005827:       LD B,00h
00005829:       ADD HL,BC
; FN_INSTR_1:
0000582A:       SUB C
0000582B:       LD B,A
0000582C:       PUSH BC
0000582D:       PUSH DE
0000582E:       EX HL,(SP)
0000582F:       LD C,(HL)
00005830:       INC HL
00005831:       LD E,(HL)
00005832:       INC HL
00005833:       LD D,(HL)
00005834:       POP HL
00005835:       PUSH HL
00005836:       PUSH DE
00005837:       PUSH BC
; FN_INSTR_3:
00005838:       LD A,(DE)
00005839:       CP (HL)
0000583A:       JR NZ,+16h		; FN_INSTR_6
0000583C:       INC DE
0000583D:       DEC C
0000583E:       JR Z,+09h		; FN_INSTR_5
00005840:       INC HL
00005841:       DJNZ -0Bh		; FN_INSTR_3
00005843:       POP DE
00005844:       POP DE
00005845:       POP BC
00005846:       POP DE
; FN_INSTR_4:
00005847:       XOR A
00005848:       RET

; FN_INSTR_5
00005849:       POP HL
0000584A:       POP DE
0000584B:       POP DE
0000584C:       POP BC
0000584D:       LD A,B
0000584E:       SUB H
0000584F:       ADD C
00005850:       INC A
00005851:       RET

; FN_INSTR_6:
00005852:       POP BC
00005853:       POP DE
00005854:       POP HL
00005855:       INC HL
00005856:       DJNZ -23h		; FN_INSTR_2
00005858:       JR -14h			; FN_INSTR_4

_MID_S:
;FN_POINT ?
0000585A:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000585B:       JR Z,-33h
0000585D:       JP Z,CD5Ah
00005860:       LD D,(HL)
00005861:       LD (D5E5h),HL
00005864:       EX DE,HL
00005865:       INC HL
00005866:       LD E,(HL)
00005867:       INC HL
00005868:       LD D,(HL)
00005869:       LD HL,(EB1Fh)	; ARREND - End of arrays
0000586C:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
0000586D:       JR C,+16h		; _MID_S_0
0000586F:       LD HL,E879h		; BUFFER - start of INPUT buffer
00005872:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00005873:       JR C,+06h
00005875:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
00005878:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00005879:       JR NC,+0Ah
0000587B:       POP HL
0000587C:       PUSH HL
0000587D:       CALL 54D8h			; SAVSTR_0
00005880:       POP HL
00005881:       PUSH HL
00005882:       CALL 20FCh			; FP2HL - copy number value from DE to HL
;  _MID_S_0:
00005885:       POP HL
00005886:       EX HL,(SP)
00005887:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00005888:       DEFB ','
00005889:       CALL 18A3h			; GETINT
0000588C:       OR A
0000588D:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00005890:       PUSH AF
00005891:       LD A,(HL)
00005892:       CALL 58D6h			; test ',' & ')'
00005895:       PUSH DE
00005896:       CALL 11CEh			; NEXT_EQUAL
00005899:       PUSH HL
0000589A:       CALL 56C9h				; GETSTR - Get string pointed by FPREG 'Type Error' if it is not
0000589D:       EX DE,HL
0000589E:       POP HL
0000589F:       POP BC
000058A0:       POP AF
000058A1:       LD B,A
000058A2:       EX HL,(SP)
000058A3:       PUSH HL
000058A4:       LD HL,1FA5h			; POPHLRT - (POP HL / RET)
000058A7:       EX HL,(SP)
000058A8:       LD A,C
000058A9:       OR A
000058AA:       RET Z
000058AB:       LD A,(HL)
000058AC:       SUB B
000058AD:       JP C,0B06h			; FCERR, Err $05 - "Illegal function call"
000058B0:       INC A
000058B1:       CP C
000058B2:       JR C,+01h
000058B4:       LD A,C
000058B5:       LD C,B
000058B6:       DEC C
000058B7:       LD B,00h
000058B9:       PUSH DE
000058BA:       INC HL
000058BB:       LD E,(HL)
000058BC:       INC HL
000058BD:       LD H,(HL)
000058BE:       LD L,E
000058BF:       ADD HL,BC
000058C0:       LD B,A
000058C1:       POP DE
000058C2:       EX DE,HL
000058C3:       LD C,(HL)
000058C4:       INC HL
000058C5:       LD A,(HL)
000058C6:       INC HL
000058C7:       LD H,(HL)
000058C8:       LD L,A
000058C9:       EX DE,HL
000058CA:       LD A,C
000058CB:       OR A
000058CC:       RET Z
000058CD:       LD A,(DE)
000058CE:       LD (HL),A
000058CF:       INC DE
000058D0:       INC HL
000058D1:       DEC C
000058D2:       RET Z
000058D3:       DJNZ -08h
000058D5:       RET

; test ',' & ')'
000058D6:       LD E,FFh
000058D8:       CP 29h		; ')'
000058DA:       JR Z,+05h
000058DC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000058DD:       DEFB ','
000058DE:       CALL 18A3h			; GETINT
000058E1:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000058E2:       DEFB ')'
000058E3:       RET

_FRE:
000058E4:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
000058E5:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call" if string type
000058E8:       LD A,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000058EB:       INC A
000058EC:       CALL 58FAh
000058EF:       DEC HL
000058F0:       DEC HL
000058F1:       PUSH HL
000058F2:       CALL 5912h
000058F5:       POP DE
000058F6:       ADD HL,DE
000058F7:       JP 2402h		; DBL_ABS_0

000058FA:       LD HL,0002h
000058FD:       RRCA
000058FE:       RET NC
000058FF:       PUSH AF
00005900:       CALL 56CCh			; GSTRCU - Get string pointed by FPREG
00005903:       CALL 559Ah
00005906:       LD DE,(EB1Fh)		; ARREND - End of arrays
0000590A:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
0000590D:       OR A
0000590E:       SBC HL,DE
00005910:       POP AF
00005911:       RET
00005912:       LD HL,0000h
00005915:       RRCA
00005916:       RET NC
00005917:       LD DE,(EB18h)			; ARYTAB - Pointer to begin of array table
0000591B:       LD HL,7FFFh
0000591E:       OR A
0000591F:       SBC HL,DE
00005921:       RET

00005922:       CALL ED42h
00005925:       PUSH HL
00005926:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00005929:       JP NZ,4B52h
0000592C:       POP HL
0000592D:       LD A,(E64Ch)		; PRTFLG ("printer enabled" flag)
00005930:       OR A
00005931:       JP Z,59A5h			; display sub
00005934:       POP AF

00005935:       PUSH AF
00005936:       CP 08h
00005938:       JR NZ,+0Dh
0000593A:       LD A,(E64Bh)			; LPTPOS - printer cursor position
0000593D:       SUB 01h
0000593F:       JR C,+03h
00005941:       LD (E64Bh),A			; LPTPOS - printer cursor position
00005944:       POP AF
00005945:       JR +3Fh
00005947:       CP 09h
00005949:       JR NZ,+18h
0000594B:       LD A,(E64Eh)		; LPTPOS2
0000594E:       INC A
0000594F:       JR Z,+12h
00005951:       LD A,20h
00005953:       CALL 5935h
00005956:       LD A,(E64Bh)			; LPTPOS - printer cursor position
00005959:       CP FFh
0000595B:       JR Z,+04h
0000595D:       AND 07h
0000595F:       JR NZ,-10h
00005961:       POP AF
00005962:       RET

00005963:       POP AF
00005964:       PUSH AF
00005965:       SUB 0Dh
00005967:       JR Z,+19h
00005969:       JR C,+1Ah
0000596B:       LD A,(E64Eh)		; LPTPOS2
0000596E:       INC A
0000596F:       LD A,(E64Bh)			; LPTPOS - printer cursor position
00005972:       JR Z,+09h
00005974:       PUSH HL
00005975:       LD HL,E64Eh			; LPTPOS2
00005978:       CP (HL)
00005979:       POP HL
0000597A:       CALL Z,5995h
0000597D:       CP FFh
0000597F:       JR Z,+04h
00005981:       INC A
00005982:       LD (E64Bh),A			; LPTPOS - printer cursor position
00005985:       POP AF

; LPTOUT_SAFE
00005986:       JP 3ED4h		; LPTOUT

; STOP_LPT -  Stop and reset line printer
00005989:       XOR A
0000598A:       LD (E64Ch),A		; PRTFLG ("printer enabled" flag)
0000598D:       CALL 3EF3h
00005990:       LD A,(E64Bh)			; LPTPOS - printer cursor position
00005993:       OR A
00005994:       RET Z
00005995:       LD A,0Dh
00005997:       CALL 5986h			; LPTOUT_SAFE
0000599A:       LD A,0Ah
0000599C:       CALL 5986h			; LPTOUT_SAFE
0000599F:       XOR A
000059A0:       LD (E64Bh),A			; LPTPOS - printer cursor position
000059A3:       RET

000059A4:       PUSH AF
; display sub
000059A5:       LD A,(E652h)
000059A8:       OR A
000059A9:       JP NZ,558Bh
000059AC:       LD A,(E6A0h)
000059AF:       OR A
000059B0:       JP M,59D0h
000059B3:       OR A
000059B4:       JP Z,558Bh
000059B7:       POP AF
000059B8:       PUSH BC
000059B9:       PUSH HL
000059BA:       LD HL,(EC88h)		; PTRFIL
000059BD:       PUSH DE
000059BE:       PUSH HL
000059BF:       PUSH AF
000059C0:       XOR A
000059C1:       CALL 4735h			; SETFIL
000059C4:       POP AF
000059C5:       CALL 4B54h
000059C8:       POP HL
000059C9:       LD (EC88h),HL		; PTRFIL
000059CC:       POP DE
000059CD:       POP HL
000059CE:       POP BC
000059CF:       RET

000059D0:       LD A,(E6A2h)
000059D3:       OR A
000059D4:       JR NZ,+05h
000059D6:       POP AF
000059D7:       PUSH AF
000059D8:       CALL 5935h
000059DB:       LD A,(E6B6h)			; PrintCtrlCode
000059DE:       OR A
000059DF:       JR Z,+05h
000059E1:       POP AF
000059E2:       PUSH BC
000059E3:       PUSH AF
000059E4:       JR +1Ah

000059E6:       POP AF
000059E7:       PUSH BC
000059E8:       PUSH AF
000059E9:       CP 09h
000059EB:       JR NZ,+13h
000059ED:       LD A,20h
000059EF:       CALL 59A4h
000059F2:       CALL 449Fh		; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)
000059F5:       CP FFh
000059F7:       JR Z,+04h
000059F9:       AND 07h
000059FB:       JR NZ,-10h
000059FD:       POP AF
000059FE:       POP BC
000059FF:       RET

00005A00:       POP AF
00005A01:       POP BC
00005A02:       PUSH AF
00005A03:       POP AF
00005A04:       CALL 3E0Dh	; output character to console
00005A07:       RET

00005A08:       CALL ED0Fh
00005A0B:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00005A0E:       JR Z,+31h
00005A10:       CALL 4B7Bh
00005A13:       RET NC
00005A14:       PUSH BC
00005A15:       PUSH DE
00005A16:       PUSH HL
00005A17:       LD A,(ECA3h)		; NLONLY
00005A1A:       AND C8h
00005A1C:       LD (ECA3h),A		; NLONLY
00005A1F:       CALL 4CABh
00005A22:       POP HL
00005A23:       POP DE
00005A24:       POP BC
00005A25:       LD A,(EC8Eh)		; FILNAM
00005A28:       OR A
00005A29:       JR Z,+07h
00005A2B:       LD HL,0996h			; NEWSTT
00005A2E:       PUSH HL
00005A2F:       JP 4F21h			; RUN_FST

00005A32:       PUSH HL
00005A33:       PUSH BC
00005A34:       PUSH DE
00005A35:       LD HL,031Ah			; "Ok"
00005A38:       CALL 5550h			; PRS - Print message pointed by HL
00005A3B:       POP DE
00005A3C:       POP BC
00005A3D:       LD A,0Dh
00005A3F:       POP HL
00005A40:       RET

; CHGET - Waits for character being input and returns the character codes.
00005A41:       CALL 3583h			; INICHR (aka GETCHAR)
00005A44:       CP 0Fh
00005A46:       RET NZ
00005A47:       LD A,(E652h)
00005A4A:       OR A
00005A4B:       CALL Z,5129h		; ^O
00005A4E:       CPL
00005A4F:       LD (E652h),A
00005A52:       OR A
00005A53:       JP Z,5129h			; ^O
00005A56:       XOR A
00005A57:       RET

; CONSOLE_CRLF
00005A58:       CALL 449Fh		; DECrement TTYPOS, (a.k.a. CSRX or CursorPos+1)
00005A5B:       OR A
00005A5C:       RET Z
00005A5D:       JR +0Ah

00005A5F:       LD (HL),00h
00005A61:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
00005A64:       LD HL,E9B8h
00005A67:       JR NZ,+09h

; OUTDO_CRLF
00005A69:       CALL ED0Ch
00005A6C:       LD A,0Dh
00005A6E:       RST 20h		; (OUTDO??) CPDEHL - compare DE and HL (aka DCOMPR)
00005A6F:       LD A,0Ah
00005A71:       RST 20h		; (OUTDO??) CPDEHL - compare DE and HL (aka DCOMPR)
00005A72:       CALL 5372h	; ISFLIO - Tests if I/O to device is taking place
00005A75:       JR Z,+02h
00005A77:       XOR A
00005A78:       RET

00005A79:       LD A,(E64Ch)		; PRTFLG ("printer enabled" flag)
00005A7C:       OR A
00005A7D:       JR Z,-08h
00005A7F:       XOR A
00005A80:       LD (E64Bh),A		; LPTPOS - printer cursor position
00005A83:       RET

00005A84:       XOR A
00005A85:       RET

; ISCNTC - Check the status of the STOP key.
00005A86:       CALL ED8Ah			; hook code ?
00005A89:       LD A,(E6CAh)		; INTFLG
00005A8C:       OR A
00005A8D:       RET Z
00005A8E:       CALL 5A41h			; CHGET - Waits for character being input and returns the character codes.
00005A91:       CP 13h
00005A93:       PUSH AF
00005A94:       CALL NZ,5A44h
00005A97:       POP AF
00005A98:       CALL Z,5A41h		; CHGET - Waits for character being input and returns the character codes.
00005A9B:       CP 03h
00005A9D:       CALL Z,512Bh		; print CTRL code (e.g. ^C)
00005AA0:       JP 50CDh

_INKEY$:
00005AA3:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005AA4:       PUSH HL
00005AA5:       CALL 35CEh		; CHSNS - Get key from keyboard buffer, don't wait for keypress.
00005AA8:       JR Z,+09h		; _NO_KEY_FOUND
00005AAA:       PUSH AF
00005AAB:       CALL 54ECh		; MK_1BYTE_TMST - make 1 byte long temporary string
00005AAE:       POP AF
00005AAF:       LD E,A
00005AB0:       CALL 571Ah		; _CHR$_0:
; _NO_KEY_FOUND
00005AB3:       LD HL,0319h			; NULL value, internal constant
00005AB6:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00005AB9:       LD A,03h			; string type
00005ABB:       LD (EABDh),A		; VALTYP - type indicator
00005ABE:       POP HL
00005ABF:       RET

00005AC0:       DEC HL
00005AC1:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005AC2:       RET Z
00005AC3:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00005AC4:       DEFB ','

_DIM:
00005AC5:       LD BC,5AC0h
00005AC8:       PUSH BC
00005AC9:       DEFB $F6	;OR AFh
GETVAR:
00005ACA:       XOR A
00005ACB:       LD (EABCh),A		; DIMFLG
00005ACE:       LD C,(HL)
; GETVAR_0
00005ACF:       CALL ED93h			; ? HPTRG ? -  Hook for Variable search event
00005AD2:       CALL 5215h			; IS_ALPHA - Load A with char in (HL) and check it is a letter
00005AD5:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
00005AD8:       XOR A
00005AD9:       LD B,A
00005ADA:       LD (E850h),A			; FPSINT
00005ADD:       INC HL
00005ADE:       LD A,(HL)
00005ADF:       CP 2Eh		; '.'
00005AE1:       JR C,+39h
00005AE3:       JR Z,+0Dh
00005AE5:       CP 3Ah		; ':'
00005AE7:       JR NC,+04h
00005AE9:       CP 30h
00005AEB:       JR NC,+05h
00005AED:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00005AF0:       JR C,+2Ah
00005AF2:       LD B,A
00005AF3:       PUSH BC
00005AF4:       LD B,FFh
00005AF6:       LD DE,E850h			; FPSINT
00005AF9:       OR 80h
00005AFB:       INC B
00005AFC:       LD (DE),A
00005AFD:       INC DE
00005AFE:       INC HL
00005AFF:       LD A,(HL)
00005B00:       CP 3Ah		; ':'
00005B02:       JR NC,+04h
00005B04:       CP 30h
00005B06:       JR NC,-0Fh
00005B08:       CALL 5216h			; IS_ALPHA_A - Check it is in the 'A'..'Z' range
00005B0B:       JR NC,-14h
00005B0D:       CP 2Eh		; '.'
00005B0F:       JR Z,-18h
00005B11:       LD A,B
00005B12:       CP 27h
00005B14:       JP NC,0393h			;  SNERR - entry for '?SN ERROR'
00005B17:       POP BC
00005B18:       LD (E850h),A			; FPSINT
00005B1B:       LD A,(HL)
00005B1C:       CP 26h		; '&'
00005B1E:       JR NC,+17h	; GETVAR_4
00005B20:       LD DE,5B45h
00005B23:       PUSH DE
00005B24:       LD D,02h
00005B26:       CP 25h		; '%'
00005B28:       RET Z
00005B29:       INC D
00005B2A:       CP 24h		; '$'
00005B2C:       RET Z
00005B2D:       INC D
00005B2E:       CP 21h		; '!'
00005B30:       RET Z
00005B31:       LD D,08h
00005B33:       CP 23h		;'#'
00005B35:       RET Z
00005B36:       POP AF
; GETVAR_4
00005B37:       LD A,C
00005B38:       AND 7Fh
00005B3A:       LD E,A
00005B3B:       LD D,00h
00005B3D:       PUSH HL
00005B3E:       LD HL,EAE2h
00005B41:       ADD HL,DE
00005B42:       LD D,(HL)
00005B43:       POP HL
00005B44:       DEC HL

GVAR:
00005B45:       LD A,D
00005B46:       LD (EABDh),A		; VALTYP - type indicator
00005B49:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005B4A:       LD A,(EAFBh)		; SUBFLG - flag for USR fn. array
00005B4D:       DEC A
00005B4E:       JP Z,5CACh		; 5CABh + 1
00005B51:       JP P,5B5Fh			; GVAR_0
00005B54:       LD A,(HL)
00005B55:       SUB 28h
00005B57:       JP Z,5C38h			; SBSCPT
00005B5A:       SUB 33h
00005B5C:       JP Z,5C38h			; SBSCPT
; GVAR_0
00005B5F:       XOR A
00005B60:       LD (EAFBh),A		; SUBFLG - flag for USR fn. array
00005B63:       PUSH HL
00005B64:       LD A,(EC10h)		; NOFUNS - 0 if no function active
00005B67:       OR A
00005B68:       LD (EC0Dh),A		; PRMFLG
00005B6B:       JR Z,+40h
00005B6D:       LD HL,(EB3Fh)		; PRMLEN - number of bytes of obj table
00005B70:       LD DE,EB41h			; PARM1
00005B73:       ADD HL,DE
00005B74:       LD (EC0Eh),HL		; ARYTA2
00005B77:       EX DE,HL
00005B78:       JR +1Bh
00005B7A:       LD A,(DE)
00005B7B:       LD L,A
00005B7C:       INC DE
00005B7D:       LD A,(DE)
00005B7E:       INC DE
00005B7F:       CP C
00005B80:       JR NZ,+0Bh
00005B82:       LD A,(EABDh)		; VALTYP - type indicator
00005B85:       CP L
00005B86:       JR NZ,+05h
00005B88:       LD A,(DE)
00005B89:       CP B
00005B8A:       JP Z,5C0Bh
00005B8D:       INC DE
00005B8E:       LD A,(DE)
00005B8F:       LD H,00h
00005B91:       ADD L
00005B92:       INC A
00005B93:       LD L,A
00005B94:       ADD HL,DE
00005B95:       EX DE,HL
00005B96:       LD A,(EC0Eh)		; ARYTA2
00005B99:       CP E
00005B9A:       JP NZ,5B7Ah
00005B9D:       LD A,(EC0Fh)		; ARYTA2+1
00005BA0:       CP D
00005BA1:       JR NZ,-29h
00005BA3:       LD A,(EC0Dh)		; PRMFLG
00005BA6:       OR A
00005BA7:       JR Z,+18h
00005BA9:       XOR A
00005BAA:       LD (EC0Dh),A		; PRMFLG
00005BAD:       LD HL,(EB1Dh)		; VAREND - End of variables
00005BB0:       LD (EC0Eh),HL		; ARYTA2
00005BB3:       LD HL,(EB1Bh)		; VARTAB
00005BB6:       JR -23h

00005BB8:       CALL 5ACAh			; GETVAR - get variable address to DE (AKA PTRGET)
00005BBB:       RET

00005BBC:       LD D,A
00005BBD:       LD E,A
00005BBE:       POP BC
00005BBF:       EX HL,(SP)
00005BC0:       RET
00005BC1:       POP HL
00005BC2:       EX HL,(SP)
00005BC3:       PUSH DE
00005BC4:       LD DE,5BBBh
00005BC7:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005BC8:       JR Z,-0Eh
00005BCA:       LD DE,1409h
00005BCD:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005BCE:       POP DE
00005BCF:       JR Z,+54h
00005BD1:       EX HL,(SP)
00005BD2:       PUSH HL
00005BD3:       PUSH BC
00005BD4:       LD A,(EABDh)		; VALTYP - type indicator
00005BD7:       LD B,A
00005BD8:       LD A,(E850h)			; FPSINT
00005BDB:       ADD B
00005BDC:       INC A
00005BDD:       LD C,A
00005BDE:       PUSH BC
00005BDF:       LD B,00h
00005BE1:       INC BC
00005BE2:       INC BC
00005BE3:       INC BC
00005BE4:       LD HL,(EB1Fh)		; ARREND - End of arrays
00005BE7:       PUSH HL
00005BE8:       ADD HL,BC
00005BE9:       POP BC
00005BEA:       PUSH HL
00005BEB:       CALL 4EB3h
00005BEE:       POP HL
00005BEF:       LD (EB1Fh),HL		; ARREND - End of arrays
00005BF2:       LD H,B
00005BF3:       LD L,C
00005BF4:       LD (EB1Dh),HL		; VAREND - End of variables
00005BF7:       DEC HL
00005BF8:       LD (HL),00h
00005BFA:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005BFB:       JR NZ,-06h
00005BFD:       POP DE
00005BFE:       LD (HL),D
00005BFF:       INC HL
00005C00:       POP DE
00005C01:       LD (HL),E
00005C02:       INC HL
00005C03:       LD (HL),D
00005C04:       CALL 5DA6h
00005C07:       EX DE,HL
00005C08:       INC DE
00005C09:       POP HL
00005C0A:       RET

00005C0B:       INC DE
00005C0C:       LD A,(E850h)			; FPSINT
00005C0F:       LD H,A
00005C10:       LD A,(DE)
00005C11:       CP H
00005C12:       JP NZ,5B8Eh
00005C15:       OR A
00005C16:       JR NZ,+03h
00005C18:       INC DE
00005C19:       POP HL
00005C1A:       RET

00005C1B:       EX DE,HL
00005C1C:       CALL 5DBAh
00005C1F:       EX DE,HL
00005C20:       JP NZ,5B8Fh
00005C23:       POP HL
00005C24:       RET

00005C25:       LD (EC44h),A		; FPEXP - Floating Point Exponent
00005C28:       LD H,A
00005C29:       LD L,A
00005C2A:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00005C2D:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00005C2E:       JR NZ,+06h			; JP if not string type
00005C30:       LD HL,0319h			; NULL value, internal constant
00005C33:       LD (EC41h),HL			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00005C36:       POP HL
00005C37:       RET

; SBSCPT:
00005C38:       PUSH HL
00005C39:       LD HL,(EABCh)		; DIMFLG
00005C3C:       EX HL,(SP)
00005C3D:       LD D,A
00005C3E:       PUSH DE
00005C3F:       PUSH BC
00005C40:       LD DE,E850h			; FPSINT
00005C43:       LD A,(DE)
00005C44:       OR A
00005C45:       JR Z,+2Fh
00005C47:       EX DE,HL
00005C48:       ADD 02h
00005C4A:       RRA
00005C4B:       LD C,A
00005C4C:       CALL 4EC1h			; CHKSTK
00005C4F:       LD A,C
00005C50:       LD C,(HL)
00005C51:       INC HL
00005C52:       LD B,(HL)
00005C53:       INC HL
00005C54:       PUSH BC
00005C55:       DEC A
00005C56:       JR NZ,-08h
00005C58:       PUSH HL
00005C59:       LD A,(E850h)			; FPSINT
00005C5C:       PUSH AF
00005C5D:       EX DE,HL
00005C5E:       CALL 0B01h
00005C61:       POP AF
00005C62:       LD (E877h),HL
00005C65:       POP HL
00005C66:       ADD 02h
00005C68:       RRA
00005C69:       POP BC
00005C6A:       DEC HL
00005C6B:       LD (HL),B
00005C6C:       DEC HL
00005C6D:       LD (HL),C
00005C6E:       DEC A
00005C6F:       JR NZ,-08h
00005C71:       LD HL,(E877h)
00005C74:       JR +07h
00005C76:       CALL 0B01h
00005C79:       XOR A
00005C7A:       LD (E850h),A			; FPSINT
00005C7D:       LD A,(EC1Fh)
00005C80:       OR A
00005C81:       JR Z,+06h
00005C83:       LD A,D
00005C84:       OR E
00005C85:       JP Z,5CE8h
00005C88:       DEC DE
00005C89:       POP BC
00005C8A:       POP AF
00005C8B:       EX DE,HL
00005C8C:       EX HL,(SP)
00005C8D:       PUSH HL
00005C8E:       EX DE,HL
00005C8F:       INC A
00005C90:       LD D,A
00005C91:       LD A,(HL)
00005C92:       CP 2Ch		; ','
00005C94:       JP Z,5C3Eh
00005C97:       CP 29h		; ')'
00005C99:       JR Z,+05h
00005C9B:       CP 5Dh		; ']'
00005C9D:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00005CA0:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00005CA1:       LD (EB10h),HL		; TEMP2 - temp. storage used by EVAL
00005CA4:       POP HL
00005CA5:       LD (EABCh),HL		; DIMFLG
00005CA8:       LD E,00h
00005CAA:       PUSH DE

00005CAB:
	;; 5CABh + 1: PUSH HL / PUSH AF
00005CAB:       LD DE,F5E5h
00005CAE:       LD HL,(EB1Dh)		; VAREND - End of variables
00005CB1:       LD A,19h
00005CB3:       LD DE,(EB1Fh)		; ARREND - End of arrays
00005CB7:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005CB8:       JR Z,+45h			; to 5CFFh

00005CBA:       LD E,(HL)
00005CBB:       INC HL
00005CBC:       LD A,(HL)
00005CBD:       INC HL
00005CBE:       CP C
00005CBF:       JR NZ,+0Ah
00005CC1:       LD A,(EABDh)		; VALTYP - type indicator
00005CC4:       CP E
00005CC5:       JR NZ,+04h
00005CC7:       LD A,(HL)
00005CC8:       CP B
00005CC9:       JR Z,+23h
00005CCB:       INC HL
00005CCC:       LD E,(HL)
00005CCD:       INC E
00005CCE:       LD D,00h
00005CD0:       ADD HL,DE
00005CD1:       LD E,(HL)
00005CD2:       INC HL
00005CD3:       LD D,(HL)
00005CD4:       INC HL
00005CD5:       JR NZ,-25h
00005CD7:       LD A,(EABCh)		; DIMFLG
00005CDA:       OR A
00005CDB:       JP NZ,03A2h			;  "Duplicate definition" error
00005CDE:       POP AF
00005CDF:       LD B,H
00005CE0:       LD C,L
00005CE1:       JP Z,1FA5h			; POPHLRT - (POP HL / RET)
00005CE4:       SUB (HL)
00005CE5:       JP Z,5D65h
00005CE8:       LD DE,0009h
00005CEB:       JP 03B3h				; ERROR, code in E

00005CEE:       INC HL
00005CEF:       LD A,(E850h)			; FPSINT
00005CF2:       CP (HL)
00005CF3:       JR NZ,-29h
00005CF5:       INC HL
00005CF6:       OR A
00005CF7:       JR Z,-28h
00005CF9:       DEC HL
00005CFA:       CALL 5DBAh
00005CFD:       JR -2Eh

00005CFF:       LD A,(EABDh)		; VALTYP - type indicator
00005D02:       LD (HL),A
00005D03:       INC HL
00005D04:       LD E,A
00005D05:       LD D,00h
00005D07:       POP AF
00005D08:       JP Z,5D99h
00005D0B:       LD (HL),C
00005D0C:       INC HL
00005D0D:       LD (HL),B
00005D0E:       CALL 5DA6h
00005D11:       INC HL
00005D12:       LD C,A
00005D13:       CALL 4EC1h			; CHKSTK
00005D16:       INC HL
00005D17:       INC HL
00005D18:       LD (EAF3h),HL		; TEMP3 - used for garbage collection or by USR function
00005D1B:       LD (HL),C
00005D1C:       INC HL
00005D1D:       LD A,(EABCh)		; DIMFLG
00005D20:       RLA
00005D21:       LD A,C
00005D22:       JR C,+0Ch
00005D24:       PUSH AF
00005D25:       LD A,(EC1Fh)
00005D28:       XOR 0Bh
00005D2A:       LD C,A
00005D2B:       LD B,00h
00005D2D:       POP AF
00005D2E:       JR NC,+02h
00005D30:       POP BC
00005D31:       INC BC
00005D32:       LD (HL),C
00005D33:       PUSH AF
00005D34:       INC HL
00005D35:       LD (HL),B
00005D36:       INC HL
00005D37:       CALL 2312h			; MLDEBC - Multiply DE by BC
00005D3A:       POP AF
00005D3B:       DEC A
00005D3C:       JR NZ,-1Ch
00005D3E:       PUSH AF
00005D3F:       LD B,D
00005D40:       LD C,E
00005D41:       EX DE,HL
00005D42:       ADD HL,DE
00005D43:       JP C,4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'
00005D46:       CALL 4EE4h
00005D49:       LD (EB1Fh),HL		; ARREND - End of arrays
00005D4C:       DEC HL
00005D4D:       LD (HL),00h
00005D4F:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005D50:       JR NZ,-06h
00005D52:       INC BC
00005D53:       LD D,A
00005D54:       LD HL,(EAF3h)		; TEMP3 - used for garbage collection or by USR function
00005D57:       LD E,(HL)
00005D58:       EX DE,HL
00005D59:       ADD HL,HL
00005D5A:       ADD HL,BC
00005D5B:       EX DE,HL
00005D5C:       DEC HL
00005D5D:       DEC HL
00005D5E:       LD (HL),E
00005D5F:       INC HL
00005D60:       LD (HL),D
00005D61:       INC HL
00005D62:       POP AF
00005D63:       JR C,+30h
00005D65:       LD B,A
00005D66:       LD C,A
00005D67:       LD A,(HL)
00005D68:       INC HL
00005D69:       LD D,E1h
00005D6B:       LD E,(HL)
00005D6C:       INC HL
00005D6D:       LD D,(HL)
00005D6E:       INC HL
00005D6F:       EX HL,(SP)
00005D70:       PUSH AF
00005D71:       RST 20h				; CPDEHL - compare DE and HL (aka DCOMPR)
00005D72:       JP NC,5CE8h
00005D75:       CALL 2312h			; MLDEBC - Multiply DE by BC
00005D78:       ADD HL,DE
00005D79:       POP AF
00005D7A:       DEC A
00005D7B:       LD B,H
00005D7C:       LD C,L
00005D7D:       JR NZ,-15h
00005D7F:       LD A,(EABDh)		; VALTYP - type indicator
00005D82:       LD B,H
00005D83:       LD C,L
00005D84:       ADD HL,HL
00005D85:       SUB 04h
00005D87:       JR C,+04h
00005D89:       ADD HL,HL
00005D8A:       JR Z,+06h
00005D8C:       ADD HL,HL
00005D8D:       OR A
00005D8E:       JP PO,5D92h
00005D91:       ADD HL,BC
00005D92:       POP BC
00005D93:       ADD HL,BC
00005D94:       EX DE,HL
00005D95:       LD HL,(EB10h)		; TEMP2 - temp. storage used by EVAL
00005D98:       RET

00005D99:       SCF
00005D9A:       SBC A
00005D9B:       POP HL
00005D9C:       RET

00005D9D:       LD A,(HL)
00005D9E:       INC HL
00005D9F:       PUSH BC
00005DA0:       LD B,00h
00005DA2:       LD C,A
00005DA3:       ADD HL,BC
00005DA4:       POP BC
00005DA5:       RET

00005DA6:       PUSH BC
00005DA7:       PUSH DE
00005DA8:       PUSH AF
00005DA9:       LD DE,E850h			; FPSINT
00005DAC:       LD A,(DE)
00005DAD:       LD B,A
00005DAE:       INC B
00005DAF:       LD A,(DE)
00005DB0:       INC DE
00005DB1:       INC HL
00005DB2:       LD (HL),A
00005DB3:       DEC B
00005DB4:       JR NZ,-07h
00005DB6:       POP AF
00005DB7:       POP DE
00005DB8:       POP BC
00005DB9:       RET
00005DBA:       PUSH DE
00005DBB:       PUSH BC
00005DBC:       LD DE,E851h
00005DBF:       LD B,A
00005DC0:       INC HL
00005DC1:       INC B
00005DC2:       DEC B
00005DC3:       JR Z,+0Dh
00005DC5:       LD A,(DE)
00005DC6:       INC DE
00005DC7:       CP (HL)
00005DC8:       INC HL
00005DC9:       JR Z,-09h
00005DCB:       LD A,B
00005DCC:       DEC A
00005DCD:       CALL NZ,5D9Fh
00005DD0:       XOR A
00005DD1:       DEC A
00005DD2:       POP BC
00005DD3:       POP DE
00005DD4:       RET

00005DD5:       INC BC
00005DD6:       LD E,(HL)
00005DD7:       LD C,C
00005DD8:       LD E,(HL)
00005DD9:       LD C,5Fh
00005DDB:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00005DDC:       LD E,L
00005DDD:       PUSH HL
00005DDE:       LD E,L
00005DDF:       LD D,H
00005DE0:       LD E,(HL)
00005DE1:       INC SP
00005DE2:       LD E,(HL)
00005DE3:       INC HL
00005DE4:       LD E,(HL)
00005DE5:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00005DE8:       CALL 5E40h
00005DEB:       RET NZ
00005DEC:       LD H,01h
00005DEE:       XOR A
00005DEF:       CALL 5F86h
00005DF2:       CALL 5E17h
00005DF5:       XOR A
00005DF6:       RET

; ESC,"l", clear line
; ESC_CLINE
00005DF7:       LD H,01h
00005DF9:       PUSH HL
00005DFA:       LD A,01h
00005DFC:       CALL 5F86h
00005DFF:       POP HL
00005E00:       JP 4494h                ; TXT_LOC

00005E03:       LD A,(E6ADh)
00005E06:       OR A
00005E07:       JR Z,+07h
00005E09:       INC L
00005E0A:       CALL 64E2h
00005E0D:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00005E10:       LD A,0Ah
00005E12:       CALL 5F86h
00005E15:       LD H,01h
00005E17:       CALL 5E23h
00005E1A:       RET NZ
00005E1B:       CALL 4494h                ; TXT_LOC
00005E1E:       CALL 5E69h
00005E21:       XOR A
00005E22:       RET

00005E23:       LD A,(E6B1h)		; scroll area end
00005E26:       CP L
00005E27:       RET Z
00005E28:       JR NC,+05h
00005E2A:       LD L,A
00005E2B:       XOR A
00005E2C:       JP 4494h                ; TXT_LOC

00005E2F:       INC L
00005E30:       JP 4494h                ; TXT_LOC

00005E33:       LD A,(E6B0h)		; scroll area
00005E36:       CP L
00005E37:       RET Z
00005E38:       LD A,01h
00005E3A:       CP L
00005E3B:       RET Z
00005E3C:       DEC L
00005E3D:       JP 4494h                ; TXT_LOC

00005E40:       LD A,(EF89h)	; WIDTH
00005E43:       CP H
00005E44:       RET Z
00005E45:       INC H
00005E46:       JP 4494h                ; TXT_LOC

00005E49:       LD HL,(E6B0h)		; scroll area
00005E4C:       LD H,01h
00005E4E:       LD (EF83h),HL
00005E51:       JP 4494h                ; TXT_LOC

00005E54:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00005E57:       CALL 5E61h
00005E5A:       RET NZ
00005E5B:       LD A,(EF89h)	; WIDTH
00005E5E:       LD H,A
00005E5F:       JR -2Eh
00005E61:       LD A,01h
00005E63:       CP H
00005E64:       RET Z
00005E65:       DEC H
00005E66:       JP 4494h                ; TXT_LOC

00005E69:       LD A,(E69Fh)
00005E6C:       OR A
00005E6D:       INA (71h)			; save Extended ROM bank status
00005E6F:       PUSH AF
00005E70:       LD A,FFh
00005E72:       OUTA (71h)				; Extended ROM bank switching
00005E74:       CALL NZ,769Ah
00005E77:       POP AF				; ROM bank mask ($FF or only one bit must be reset)
00005E78:       OUTA (71h)			; restore Extended ROM bank status
00005E7A:       LD A,(E6B0h)		; scroll area
00005E7D:       LD H,A
00005E7E:       LD A,(E6B1h)		; scroll area end
00005E81:       LD L,A
00005E82:       SUB H
00005E83:       RET C
00005E84:       CALL ECD6h
00005E87:       INC A
00005E88:       CALL 5F50h
00005E8B:       LD A,(EFB9h)
00005E8E:       DEC A
00005E8F:       JR NZ,+1Eh
00005E91:       LD A,(EFC2h)
00005E94:       INC L
00005E95:       CP L
00005E96:       DEC L
00005E97:       JR NC,+16h
00005E99:       CP H
00005E9A:       JR C,+13h
00005E9C:       JR NZ,+0Dh
00005E9E:       LD HL,0000h
00005EA1:       LD (EFBCh),HL
00005EA4:       LD A,01h
00005EA6:       LD (EFC3h),A
00005EA9:       LD A,H
00005EAA:       INC H
00005EAB:       DEC A
00005EAC:       LD (EFC2h),A
00005EAF:       LD A,(EF83h)
00005EB2:       INC L
00005EB3:       CP L
00005EB4:       DEC L
00005EB5:       JR NC,+0Bh
00005EB7:       CP H
00005EB8:       JR C,+08h
00005EBA:       JR NZ,+02h
00005EBC:       LD A,01h
00005EBE:       DEC A
00005EBF:       LD (EF83h),A
00005EC2:       JP 42D4h
00005EC5:       LD A,(E6B0h)		; scroll area
00005EC8:       LD L,A
00005EC9:       LD A,(E6B1h)		; scroll area end
00005ECC:       LD H,A
00005ECD:       SUB L
00005ECE:       RET C
00005ECF:       INC A
00005ED0:       CALL ECD3h
00005ED3:       CALL 5F63h
00005ED6:       LD A,(EFB9h)
00005ED9:       DEC A
00005EDA:       JR NZ,+1Dh
00005EDC:       LD A,(EFC2h)
00005EDF:       CP L
00005EE0:       JR C,+17h
00005EE2:       CP H
00005EE3:       JP P,5EF9h
00005EE6:       JR NZ,+0Dh
00005EE8:       LD HL,0000h
00005EEB:       LD (EFBCh),HL
00005EEE:       LD A,01h
00005EF0:       LD (EFC3h),A
00005EF3:       LD A,H
00005EF4:       DEC A
00005EF5:       INC A
00005EF6:       LD (EFC2h),A
00005EF9:       LD A,(EF83h)
00005EFC:       CP L
00005EFD:       JR C,+0Ch
00005EFF:       CP H
00005F00:       JP P,5F0Bh
00005F03:       JR NZ,+02h
00005F05:       LD A,FFh
00005F07:       INC A
00005F08:       LD (EF83h),A
00005F0B:       JP 42FEh

; clear text page (text CLS)
00005F0E:       CALL 42B4h			; Init bottom text row
00005F11:       XOR A
00005F12:       LD (EFB4h),A
00005F15:       LD HL,(E6B0h)		; scroll area
00005F18:       LD A,H
00005F19:       LD H,00h
00005F1B:       SUB L
00005F1C:       INC A
00005F1D:       LD DE,EF98h
00005F20:       PUSH AF
00005F21:       EX DE,HL
00005F22:       ADD HL,DE
00005F23:       PUSH DE
00005F24:       DEC E
00005F25:       POP DE
00005F26:       JR Z,+02h

00005F28:       LD (HL),01h		; set default text attributes
00005F2A:       INC HL

00005F2B:       LD (HL),01h		; set default text attributes
00005F2D:       INC HL
00005F2E:       DEC A
00005F2F:       JR NZ,-06h

00005F31:       EX DE,HL
00005F32:       POP AF

00005F33:       PUSH AF
00005F34:       PUSH HL
00005F35:       CALL 431Eh		; Find text row address

00005F38:       CALL 42E9h		; copy bottom text line (and attributes) to DE
00005F3B:       POP HL
00005F3C:       INC L
00005F3D:       POP AF
00005F3E:       DEC A
00005F3F:       JR NZ,-0Eh

00005F41:       LD (EF83h),A
00005F44:       LD (EF84h),A
00005F47:       LD (EF85h),A
00005F4A:       CALL 3F79h
00005F4D:       JP 5E49h

00005F50:       PUSH AF
00005F51:       CALL 5F76h
00005F54:       LD B,01h
00005F56:       LD C,A
00005F57:       LD A,B
00005F58:       LD (DE),A
00005F59:       DEC DE
00005F5A:       LD A,(DE)
00005F5B:       LD B,C
00005F5C:       LD C,A
00005F5D:       POP AF
00005F5E:       DEC A
00005F5F:       RET Z
00005F60:       PUSH AF
00005F61:       JR -0Ch
00005F63:       PUSH AF
00005F64:       LD B,01h
00005F66:       CALL 5F76h
00005F69:       LD C,A
00005F6A:       LD A,B
00005F6B:       LD (DE),A
00005F6C:       INC DE
00005F6D:       LD A,(DE)
00005F6E:       LD B,C
00005F6F:       LD C,A
00005F70:       POP AF
00005F71:       DEC A
00005F72:       RET Z
00005F73:       PUSH AF
00005F74:       JR -0Ch

00005F76:       PUSH HL
00005F77:       LD DE,EF9Ah		; NXTOPR - Address ptr to next operator
00005F7A:       LD H,00h
00005F7C:       DEC L
00005F7D:       ADD HL,DE
00005F7E:       LD A,(HL)
00005F7F:       EX DE,HL
00005F80:       POP HL
00005F81:       CP 0Ah
00005F83:       RET Z
00005F84:       AND A
00005F85:       RET

00005F86:       PUSH HL
00005F87:       LD DE,EF9Ah		; NXTOPR - Address ptr to next operator
00005F8A:       LD H,00h
00005F8C:       DEC L
00005F8D:       ADD HL,DE
00005F8E:       LD (HL),A
00005F8F:       EX DE,HL
00005F90:       POP HL
00005F91:       RET

; PINLIN - Accepts a line from console until a CR or STOP
00005F92:       CALL ED18h
00005F95:       CALL 60D8h
00005F98:       XOR A
00005F99:       LD (E6C6h),A
00005F9C:       LD A,00h
00005F9E:       CALL 4015h
00005FA1:       CALL 4FF5h		; A=(HL), (HL)=0
00005FA4:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00005FA7:       LD A,(EB00h)			; AUTFLG - enable flag for AUTO editor command
00005FAA:       OR A
00005FAB:       JR Z,+02h
00005FAD:       LD H,01h
00005FAF:       LD A,(EFB9h)
00005FB2:       PUSH AF
00005FB3:       DEC A
00005FB4:       JR NZ,+02h
00005FB6:       LD H,01h
00005FB8:       SCF
00005FB9:       LD (EF83h),HL
00005FBC:       LD A,(EF89h)	; WIDTH
00005FBF:       INC A
00005FC0:       JR +16h

;_QINLIN - Output a '?' mark and a space then falls into the INLIN routine.
00005FC2:       LD A,3Fh	;'?'
00005FC4:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00005FC5:       LD A,20h
00005FC7:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)

; INLIN - Same as PINLIN,exept if AUTFLO if set.
00005FC8:       CALL ED15h
00005FCB:       CALL 60D8h
00005FCE:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00005FD1:       LD (EF83h),HL
00005FD4:       XOR A
00005FD5:       JP 6144h

00005FD8:       LD (EF85h),A
00005FDB:       SBC A
00005FDC:       LD (EFB9h),A
00005FDF:       LD A,(EB00h)			; AUTFLG - enable flag for AUTO editor command
00005FE2:       OR A
00005FE3:       CALL Z,6528h
00005FE6:       POP AF
00005FE7:       DEC A
00005FE8:       JR Z,+08h
00005FEA:       DEC L
00005FEB:       JR Z,+05h
00005FED:       LD A,01h
00005FEF:       CALL 5F86h
00005FF2:       LD A,(E69Fh)
00005FF5:       OR A
00005FF6:       JR Z,+09h
00005FF8:       LD HL,E6A1h
00005FFB:       LD A,(HL)
00005FFC:       LD (HL),00h
00005FFE:       OR A
00005FFF:       JR NZ,+03h

00006000: ; ---   bank switching will change the next 8K code block

; listing of the main ROM bank follows (1st byte is kept in the previous instruction)

00006001:       CALL 3583h				; INICHR (aka GETCHAR)
00006004:       PUSH AF
00006005:       LD HL,(EF83h)
00006008:       EX DE,HL
00006009:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
0000600C:       LD A,L
0000600D:       CP E
0000600E:       JR NZ,+11h
00006010:       LD A,H
00006011:       CP D
00006012:       JR NC,+03h
00006014:       LD (EF83h),HL
00006017:       LD A,(EF85h)
0000601A:       CP H
0000601B:       JR NC,+04h
0000601D:       LD A,H
0000601E:       LD (EF85h),A
00006021:       POP AF
00006022:       CALL 604Ah   ; TRYOUT
00006025:       JR C,+05h
00006027:       JR Z,-37h
00006029:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000602A:       JR -3Ah
0000602C:       PUSH AF
0000602D:       XOR A
0000602E:       LD (EFB9h),A
00006031:       POP AF
00006032:       CP 03h
00006034:       SCF
00006035:       JR Z,+01h
00006037:       CCF
00006038:       LD HL,E9B8h
0000603B:       RET

; deal with semicolon
0000603C:       CP 3Bh		; ';'
0000603E:       RET NZ
0000603F:       JP 0A0Dh			; _CHRGTB - Pick next char from program

; This entry point is used by the routines at IN_ESC and _QINLIN.
; Parse the jump table in HL for C entries
TTY_JP:
00006042:       DEC HL
00006043:       INC HL
00006044:       DEC C
00006045:       RET M
00006046:       CP (HL)
00006047:       JR NZ,-06h      ; to 6043
00006049:       RET

TRYOUT:
0000604A:       LD HL,609Ah      ; TTY_CTLCODES_1
0000604D:       LD C,0Eh
0000604F:       CALL 6042h       ; TTY_JP
00006052:       JP M,605Bh

00006055:       PUSH AF

00006056:       XOR A
00006057:       LD (E6ADh),A
0000605A:       POP AF

0000605B:       LD HL,60A8h      ; TTY_CTLCODES_2
0000605E:       LD C,10h         ; TTY_DEL
00006060:       CALL 6042h       ; TTY_JP
00006063:       JP M,607Ah

00006066:       PUSH AF
00006067:       LD A,C
00006068:       OR A
00006069:       RLCA
0000606A:       LD C,A
0000606B:       XOR A
0000606C:       LD B,A
0000606D:       LD HL,60B8h
00006070:       ADD HL,BC
00006071:       LD E,(HL)
00006072:       INC HL
00006073:       LD D,(HL)
00006074:       POP AF
00006075:       PUSH DE
00006076:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00006079:       RET

0000607A:       CP 20h		; ' '
0000607C:       JR C,+02h
0000607E:       AND A
0000607F:       RET

00006080:       CP 07h
00006082:       JR Z,-06h
00006084:       CP 09h
00006086:       JR Z,-0Ah
00006088:       CP 0Bh
0000608A:       JR Z,-0Eh
0000608C:       CP 0Ch
0000608E:       JR Z,-12h
00006090:       CP 1Ch
00006092:       JR C,+04h
00006094:       CP 20h		; ' '
00006096:       JR C,-1Ah
00006098:       XOR A
00006099:       RET


; TTY_CTLCODES
;;  (this is what we have on MSX)
;;  DEFB BEL		; BELL, go beep
;;  DEFW _BEEP
;;  
;;  DEFB $08		; BS, cursor left
;;  DEFW CURS_LEFT
;;  
;;  DEFB $09		; TAB, cursor to next tab position
;;  DEFW CURS_TAB
;;  
;;  DEFB LF		; LF, cursor down a row
;;  DEFW CURS_LF
;;  
;;  DEFB $0b		; HOME, cursor to home
;;  DEFW CURS_HOME
;;  
;;  DEFB FF		; FORMFEED, clear screen and home
;;  DEFW CLS_FORMFEED
;;  
;;  DEFB $0d		; CR, cursor to leftmost column
;;  DEFW CURS_CR
;;  
;;  DEFB $1b		; ESC, enter escape sequence
;;  DEFW ENTER_ESC
;;  
;;  DEFB $1c		; RIGHT, cursor right
;;  DEFW CURS_RIGHT
;;  
;;  DEFB $1d		; LEFT, cursor left
;;  DEFW CURS_LEFT
;;  
;;  DEFB $1e		; UP, cursor up
;;  DEFW CURS_UP
;;  
;;  DEFB $1f		; DOWN, cursor down.
;;  DEFW CURS_DOWN
;;

; TTY_CTLCODES_1

0000609A:   defb 0d 02 06 05 03 0b 0c 1c 1d 1e 1f 18 15 01 09 0a 08 12 02 06 05 03 0d 18 15 04 f8 f9



000060B6:
			defw $7f01
			defw $62b5    ; BS (CURS_LEFT) ?
			defw $641F
			defw $6405
			defw $63F2
			defw $6361
			defw $633F
			defw $630B
			defw $6154
			defw $61d1
			defw $6347
			defw $6375 
			defw $63a0
			defw $6215
			defw $62b5    ; CURS_LEFT
			defw $611b
			defw $61f9
; ... 3a 9f e6 = LD A,(E69Fh)





; used by 'PINLIN' and 'QINLIN'
000060D8:       LD A,(E69Fh)
000060DB:       OR A
000060DC:       JR Z,+05h
000060DE:       LD A,(E6A0h)
000060E1:       INC A
000060E2:       RET Z
000060E3:       CALL 5372h				; ISFLIO - Tests if I/O to device is taking place
000060E6:       RET Z
000060E7:       POP AF
000060E8:       LD B,FEh
000060EA:       LD D,7Fh
000060EC:       LD HL,E9B9h
000060EF:       CALL 5A08h
000060F2:       LD E,A
000060F3:       SUB 80h
000060F5:       SBC A
000060F6:       OR D
000060F7:       LD D,A
000060F8:       LD A,E
000060F9:       AND D
000060FA:       LD (HL),A
000060FB:       CP 0Dh
000060FD:       JR NZ,+09h
000060FF:       DEC HL
00006100:       LD A,(HL)
00006101:       CP 0Ah
00006103:       JR Z,+0Ch
00006105:       INC HL
00006106:       JR +0Dh
00006108:       CP 0Ah
0000610A:       JR NZ,+05h
0000610C:       LD A,B
0000610D:       CP FEh
0000610F:       JR Z,-22h
00006111:       INC HL
00006112:       DJNZ -25h
00006114:       DEC B
00006115:       XOR A
00006116:       LD (HL),A
00006117:       LD HL,E9B8h
0000611A:       RET
0000611B:       LD A,(E6ADh)
0000611E:       OR A
0000611F:       JR Z,+2Fh
00006121:       CALL 5F76h
00006124:       NOP
00006125:       LD A,(EF89h)	; WIDTH
00006128:       SUB H
00006129:       JR Z,+0Dh
0000612B:       INC A
0000612C:       PUSH AF
0000612D:       CALL 6220h
00006130:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00006133:       INC H
00006134:       POP AF
00006135:       DEC A
00006136:       JR NZ,-0Ch
00006138:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
0000613B:       CALL 5F76h
0000613E:       EX DE,HL
0000613F:       LD (HL),01h
00006141:       EX DE,HL
00006142:       JR +10h

; continues from 'INLIN'
00006144:       PUSH AF
00006145:       LD A,(E69Fh)
00006148:       AND A
00006149:       LD A,H
0000614A:       JP Z,5FD8h
0000614D:       JP 5FBCh

00006150:       LD A,0Ah
00006152:       OR A
00006153:       RET

00006154:       CALL 63E5h
00006157:       LD DE,E9B9h
0000615A:       LD B,FEh
0000615C:       LD A,(EF83h)
0000615F:       CP L
00006160:       LD H,01h
00006162:       JR NZ,+27h
00006164:       LD HL,(EF83h)
00006167:       PUSH DE
00006168:       CALL 5F76h
0000616B:       POP DE
0000616C:       JR Z,+1Dh
0000616E:       LD A,(EF85h)
00006171:       DEC A
00006172:       LD (EF85h),A
00006175:       CALL 646Eh
00006178:       LD A,B
00006179:       AND A
0000617A:       JR Z,+14h
0000617C:       PUSH DE
0000617D:       CALL 5F76h
00006180:       POP DE
00006181:       JR NZ,+0Dh
00006183:       CP 0Ah
00006185:       CALL Z,61C6h
00006188:       LD H,01h
0000618A:       INC L
0000618B:       LD A,(EF89h)	; WIDTH
0000618E:       JR -1Eh
00006190:       EX DE,HL
00006191:       CALL 61A8h
00006194:       LD (HL),00h
00006196:       EX DE,HL
00006197:       LD A,0Dh
00006199:       PUSH AF
0000619A:       LD H,01h
0000619C:       CALL 4494h                ; TXT_LOC
0000619F:       CALL 5A69h	; OUTDO_CRLF
000061A2:       LD HL,E9B8h
000061A5:       POP AF
000061A6:       SCF
000061A7:       RET

000061A8:       LD A,FEh
000061AA:       SUB B
000061AB:       LD D,A
000061AC:       DEC HL
000061AD:       LD A,(HL)
000061AE:       CP 20h		; ' '
000061B0:       JR Z,+0Eh
000061B2:       CP 0Ah
000061B4:       JR Z,+0Ah
000061B6:       LD C,A
000061B7:       LD A,(E6B5h)		; NullChar
000061BA:       CP C
000061BB:       JR NZ,+07h
000061BD:       DEC D
000061BE:       JR Z,+04h
000061C0:       DEC HL
000061C1:       INC B
000061C2:       JR -17h
000061C4:       INC HL
000061C5:       RET
000061C6:       PUSH HL
000061C7:       EX DE,HL
000061C8:       CALL 61A8h
000061CB:       LD (HL),0Ah
000061CD:       INC HL
000061CE:       EX DE,HL
000061CF:       POP HL
000061D0:       RET
000061D1:       LD A,(E69Fh)
000061D4:       OR A
000061D5:       JR Z,+0Bh
000061D7:       LD A,(E6E5h)
000061DA:       AND 01h
000061DC:       JR NZ,+04h
000061DE:       LD A,03h
000061E0:       OR A
000061E1:       RET
000061E2:       XOR A
000061E3:       LD (E9B9h),A
000061E6:       CALL 61EDh
000061E9:       LD A,03h
000061EB:       JR -54h
000061ED:       CALL 5F76h
000061F0:       RET NZ
000061F1:       INC L
000061F2:       LD A,(E6B1h)		; scroll area end
000061F5:       CP L
000061F6:       RET Z
000061F7:       JR -0Ch

000061F9:       LD A,H
000061FA:       DEC A
000061FB:       AND F8h
000061FD:       ADD 08h
000061FF:       INC A
00006200:       LD B,A
00006201:       LD A,(EF89h)	; WIDTH
00006204:       CP B
00006205:       JR NC,+01h
00006207:       LD B,A
00006208:       LD A,B
00006209:       SUB H
0000620A:       RET Z
0000620B:       PUSH AF
0000620C:       LD A,(E6B5h)		; NullChar
0000620F:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00006210:       POP AF
00006211:       DEC A
00006212:       JR NZ,-09h
00006214:       RET

00006215:       LD A,(E6ADh)
00006218:       CPL
00006219:       LD (E6ADh),A
0000621C:       XOR A
0000621D:       JP 4290h	; Cursor on

00006220:       PUSH HL
00006221:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00006224:       PUSH AF
00006225:       LD A,(E6ADh)
00006228:       OR A
00006229:       CALL NZ,622Fh
0000622C:       POP AF
0000622D:       POP HL
0000622E:       RET
0000622F:       LD A,(EF83h)
00006232:       CP L
00006233:       JR NZ,+0Dh
00006235:       PUSH HL
00006236:       LD HL,EF85h
00006239:       INC (HL)
0000623A:       LD A,(EF89h)	; WIDTH
0000623D:       CP (HL)
0000623E:       JR NC,+01h
00006240:       LD (HL),A
00006241:       POP HL
00006242:       LD A,(E6B5h)		; NullChar
00006245:       LD C,A
00006246:       CALL 6490h
00006249:       JR C,+16h
0000624B:       PUSH AF
0000624C:       JR NZ,+08h
0000624E:       LD A,(EF89h)	; WIDTH
00006251:       CP H
00006252:       JR Z,+02h
00006254:       POP AF
00006255:       RET
00006256:       XOR A
00006257:       CALL 5F86h
0000625A:       INC L
0000625B:       CALL 64E2h
0000625E:       POP AF
0000625F:       RET Z
00006260:       DEC L
00006261:       LD H,01h
00006263:       CP 20h		; ' '
00006265:       JR NZ,+0Bh
00006267:       CALL 5F76h
0000626A:       CP 0Ah
0000626C:       RET Z
0000626D:       INC L
0000626E:       LD A,20h
00006270:       JR -2Dh
00006272:       PUSH AF
00006273:       CALL 5F76h
00006276:       CP 0Ah
00006278:       JR NZ,+12h
0000627A:       LD A,(E6B1h)		; scroll area end
0000627D:       INC L
0000627E:       CP L
0000627F:       JR C,+13h
00006281:       PUSH AF
00006282:       CALL 64E2h
00006285:       POP AF
00006286:       LD A,0Ah
00006288:       CALL NZ,5F86h
0000628B:       DEC L
0000628C:       XOR A
0000628D:       CALL 5F86h
00006290:       INC L
00006291:       POP AF
00006292:       JR -4Fh
00006294:       CALL 64E2h
00006297:       JR -0Eh

00006299:       PUSH HL
0000629A:       LD A,(EF89h)	; WIDTH
0000629D:       CP H
0000629E:       JR NZ,+09h
000062A0:       LD H,00h
000062A2:       LD A,(EF88h)	; HEIGHT (TextHeight)
000062A5:       CP L
000062A6:       JR NZ,+00h
000062A8:       INC L
000062A9:       INC H
000062AA:       CALL 62B5h		; CURS_LEFT
000062AD:       POP HL
000062AE:       PUSH HL
000062AF:       CALL 4494h      ; TXT_LOC
000062B2:       XOR A
000062B3:       POP HL
000062B4:       RET

; CURS_LEFT
000062B5:       LD A,01h
000062B7:       CP H
000062B8:       JR Z,+03h

000062BA:       DEC H
000062BB:       JR +13h

000062BD:       PUSH HL
000062BE:       DEC L
000062BF:       JR Z,+0Eh
000062C1:       LD A,(EF89h)	; WIDTH
000062C4:       LD H,A
000062C5:       CALL 5F76h
000062C8:       JR NZ,+05h
000062CA:       EX DE,HL
000062CB:       LD (HL),00h
000062CD:       EX DE,HL
000062CE:       EX HL,(SP)
000062CF:       POP HL
000062D0:       CALL 4494h                ; TXT_LOC
000062D3:       LD A,(EF83h)
000062D6:       CP L
000062D7:       JR NZ,+09h
000062D9:       LD A,(EF85h)
000062DC:       DEC A
000062DD:       JR Z,+03h
000062DF:       LD (EF85h),A
000062E2:       CALL 64AAh
000062E5:       PUSH HL
000062E6:       CALL 5F76h
000062E9:       JR NZ,+0Dh
000062EB:       INC L
000062EC:       LD H,01h
000062EE:       CALL 655Dh
000062F1:       EX HL,(SP)
000062F2:       CALL 654Dh
000062F5:       POP HL
000062F6:       JR -16h

000062F8:       XOR A
000062F9:       POP HL
000062FA:       RET
000062FB:       POP HL
000062FC:       CALL 4491h
000062FF:       XOR A
00006300:       RET

00006301:       LD A,07h
00006303:       EX DE,HL
00006304:       PUSH AF
00006305:       CALL 4494h                ; TXT_LOC
00006308:       POP AF
00006309:       OR A
0000630A:       RET

0000630B:       CALL 61EDh
0000630E:       LD A,(EF89h)	; WIDTH
00006311:       LD H,A
00006312:       LD A,(E6B5h)		; NullChar
00006315:       LD C,A
00006316:       PUSH BC
00006317:       PUSH HL
00006318:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
0000631B:       CALL 4452h
0000631E:       POP HL
0000631F:       POP BC
00006320:       DEC H
00006321:       JR Z,+04h
00006323:       CP C
00006324:       JR Z,-10h
00006326:       INC H
00006327:       LD A,(EF89h)	; WIDTH
0000632A:       CP H
0000632B:       JR NZ,+05h
0000632D:       INC L
0000632E:       CALL 64E2h
00006331:       DEC L
00006332:       LD (EF86h),HL			; CSRY (CursorPos) - current text position
00006335:       CALL 5DE5h
00006338:       LD A,01h
0000633A:       LD (E6ADh),A
0000633D:       XOR A
0000633E:       RET

0000633F:       CALL 63E5h
00006342:       LD H,01h
00006344:       CALL 4494h                ; TXT_LOC
00006347:       PUSH HL
00006348:       LD A,(E6B5h)		; NullChar
0000634B:       CALL 654Dh
0000634E:       POP HL
0000634F:       INC H
00006350:       LD A,(EF89h)	; WIDTH
00006353:       INC A
00006354:       CP H
00006355:       JR NZ,-10h
00006357:       CALL 5F76h
0000635A:       JR NZ,+42h
0000635C:       LD H,01h
0000635E:       INC L
0000635F:       JR -1Ah
00006361:       PUSH HL
00006362:       CALL 4472h
00006365:       CALL 6508h
00006368:       JR C,+05h
0000636A:       CALL 6299h
0000636D:       JR -0Dh
0000636F:       POP HL
00006370:       CALL 4494h                ; TXT_LOC
00006373:       XOR A
00006374:       RET

00006375:       XOR A
00006376:       CALL 428Bh		; Cursor off
00006379:       JR +08h

0000637B:       CALL 4472h
0000637E:       CALL 6508h
00006381:       JR C,+10h
00006383:       CALL 63CBh
00006386:       JP Z,4290h		; Cursor on
00006389:       JR -10h

0000638B:       CALL 4472h
0000638E:       CALL 6508h
00006391:       JR NC,+08h
00006393:       CALL 63CBh
00006396:       JP Z,4290h		; Cursor on
00006399:       JR -10h

0000639B:       CALL 4290h		; Cursor on
0000639E:       XOR A
0000639F:       RET

000063A0:       XOR A
000063A1:       CALL 428Bh		; Cursor off
000063A4:       JR +08h

000063A6:       CALL 4472h
000063A9:       CALL 6508h
000063AC:       JR NC,+10h
000063AE:       CALL 63D7h
000063B1:       JP Z,4290h		; Cursor on
000063B4:       JR -10h
000063B6:       CALL 4472h
000063B9:       CALL 6508h
000063BC:       JR C,+08h
000063BE:       CALL 63D7h
000063C1:       JP Z,4290h		; Cursor on
000063C4:       JR -10h
000063C6:       CALL 63CBh
000063C9:       JR -30h

000063CB:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
000063CE:       CALL 5E40h
000063D1:       RET NZ
000063D2:       LD H,01h
000063D4:       JP 5E23h

000063D7:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
000063DA:       CALL 5E61h
000063DD:       RET NZ
000063DE:       LD A,(EF89h)	; WIDTH
000063E1:       LD H,A
000063E2:       JP 5E33h

000063E5:       LD A,(E6B0h)		; scroll area
000063E8:       CP L
000063E9:       RET NC
000063EA:       DEC L
000063EB:       CALL 5F76h
000063EE:       JR Z,-0Bh
000063F0:       INC L
000063F1:       RET
000063F2:       CALL ECE5h
000063F5:       LD A,(E69Fh)
000063F8:       OR A
000063F9:       JR NZ,+00h

000063FB:       PUSH AF
000063FC:       CALL 5E69h
000063FF:       POP AF
00006400:       CALL NZ,7675h
00006403:       XOR A
00006404:       RET

00006405:       CALL ECE2h
00006408:       LD A,(E69Fh)
0000640B:       OR A
0000640C:       JR NZ,+00h

0000640E:       LD A,(E69Fh)
00006411:       OR A
00006412:       PUSH AF
00006413:       CALL NZ,7672h
00006416:       CALL 5EC5h
00006419:       POP AF
0000641A:       CALL NZ,76ACh
0000641D:       XOR A
0000641E:       RET

0000641F:       LD A,(E6C6h)
00006422:       INC A
00006423:       JR Z,+1Eh
00006425:       LD A,(EFB9h)
00006428:       OR A
00006429:       JR NZ,+1Fh
0000642B:       LD A,06h
0000642D:       CALL 4015h
00006430:       AND 06h
00006432:       XOR 04h
00006434:       JR Z,+0Dh
00006436:       LD A,00h
00006438:       CALL 4015h
0000643B:       AND 06h
0000643D:       XOR 04h
0000643F:       JR Z,+02h
00006441:       XOR A
00006442:       RET

00006443:       LD (E9B9h),A
00006446:       LD A,01h
00006448:       SCF
00006449:       RET

0000644A:       POP HL
0000644B:       LD HL,(EFBEh)
0000644E:       LD A,H
0000644F:       OR L
00006450:       CALL NZ,656Eh
00006453:       LD HL,(E656h)			; CURLIN - line number being interpreted
00006456:       LD A,H
00006457:       OR L
00006458:       CALL NZ,656Eh
0000645B:       POP HL
0000645C:       CALL 5A69h	; OUTDO_CRLF
0000645F:       CALL 1C81h
00006462:       LD HL,E87Ah			; KBUF
00006465:       PUSH HL
00006466:       DEC HL
00006467:       CALL 1BD5h
0000646A:       POP HL
0000646B:       JP 65C0h

0000646E:       PUSH BC
0000646F:       LD A,(EF85h)
00006472:       CP H
00006473:       JR C,+10h
00006475:       CALL 4472h
00006478:       CALL 6487h
0000647B:       LD (DE),A
0000647C:       INC DE
0000647D:       EX HL,(SP)
0000647E:       DEC H
0000647F:       EX HL,(SP)
00006480:       JR Z,+03h
00006482:       INC H
00006483:       JR -16h
00006485:       POP BC
00006486:       RET
00006487:       CP 07h
00006489:       RET Z
0000648A:       CP 20h		; ' '
0000648C:       RET NC
0000648D:       LD A,20h
0000648F:       RET

00006490:       CALL 64CAh
00006493:       PUSH AF
00006494:       CALL 5F76h
00006497:       JR Z,+0Eh
00006499:       POP AF
0000649A:       AND A
0000649B:       RET Z
0000649C:       CP 20h		; ' '
0000649E:       RET Z
0000649F:       LD A,(E6B5h)		; NullChar
000064A2:       CP C
000064A3:       RET Z
000064A4:       LD A,C
000064A5:       AND A
000064A6:       RET

000064A7:       POP AF
000064A8:       SCF
000064A9:       RET

000064AA:       LD A,(EF89h)	; WIDTH
000064AD:       CP H
000064AE:       JR Z,+13h
000064B0:       INC H
000064B1:       CALL 655Dh
000064B4:       PUSH HL
000064B5:       DEC H
000064B6:       CALL 654Dh
000064B9:       POP HL
000064BA:       INC H
000064BB:       LD A,(EF89h)	; WIDTH
000064BE:       INC A
000064BF:       CP H
000064C0:       JR NZ,-11h
000064C2:       DEC H
000064C3:       LD A,(E6B5h)		; NullChar
000064C6:       CALL 654Dh
000064C9:       RET

000064CA:       PUSH HL
000064CB:       PUSH BC
000064CC:       CALL 655Dh
000064CF:       POP BC
000064D0:       PUSH AF
000064D1:       LD A,C
000064D2:       CALL 654Dh
000064D5:       POP AF
000064D6:       LD C,A
000064D7:       LD A,(EF89h)	; WIDTH
000064DA:       INC A
000064DB:       INC H
000064DC:       CP H
000064DD:       JR NZ,-14h
000064DF:       LD A,C
000064E0:       POP HL
000064E1:       RET

000064E2:       PUSH HL
000064E3:       LD A,(E6B1h)		; scroll area end
000064E6:       SUB L
000064E7:       JR C,+0Ah
000064E9:       LD A,L
000064EA:       CALL 5EC8h
000064ED:       POP HL
000064EE:       LD A,01h
000064F0:       JP 5F86h

000064F3:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
000064F6:       LD A,(E6B0h)		; scroll area
000064F9:       CP L
000064FA:       JR Z,+06h
000064FC:       DEC L
000064FD:       JR Z,+03h
000064FF:       CALL 4494h                ; TXT_LOC
00006502:       CALL 5E69h
00006505:       POP HL
00006506:       DEC L
00006507:       RET

00006508:       CP 30h
0000650A:       RET C
0000650B:       CP 3Ah		; ':'
0000650D:       JR C,+17h
0000650F:       CP 41h		; 'A'
00006511:       RET C
00006512:       CP 5Bh		; '['
00006514:       JR C,+10h
00006516:       CP 61h		; 'a'
00006518:       RET C
00006519:       CP 7Bh
0000651B:       JR C,+09h
0000651D:       CP A1h
0000651F:       RET C
00006520:       CP E0h
00006522:       JR C,+02h
00006524:       SCF
00006525:       RET

00006526:       AND A
00006527:       RET

00006528:       PUSH HL
00006529:       LD H,01h
0000652B:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
0000652E:       LD A,(EF89h)	; WIDTH
00006531:       LD B,A
00006532:       PUSH BC
00006533:       CALL 4452h
00006536:       POP BC
00006537:       CP FFh
00006539:       JR Z,+05h
0000653B:       INC HL
0000653C:       DJNZ -0Ch
0000653E:       POP HL
0000653F:       RET

00006540:       POP HL
00006541:       PUSH HL
00006542:       LD H,01h
00006544:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
00006547:       EX DE,HL
00006548:       CALL 42E9h		; copy bottom text line (and attributes) to DE
0000654B:       POP HL
0000654C:       RET

0000654D:       PUSH HL
0000654E:       PUSH AF
0000654F:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
00006552:       LD A,(E6B4h)		; AttributeCode
00006555:       LD C,A
00006556:       POP AF
00006557:       LD B,A
00006558:       CALL 4350h
0000655B:       POP HL
0000655C:       RET

0000655D:       PUSH HL
0000655E:       PUSH DE
0000655F:       CALL 429Dh		; LocateTVRAM - Coordinate(L,H) -> TVRAM address translation
00006562:       CALL 4452h
00006565:       POP DE
00006566:       POP HL
00006567:       RET

00006568:       LD (E649h),A			; ERRFLG
0000656B:       LD HL,(EB09h)		; ERRLIN - Line where last error
0000656E:       LD A,H
0000656F:       AND L
00006570:       INC A
00006571:       EX DE,HL
00006572:       RET Z
00006573:       LD HL,0000h
00006576:       LD (EFBEh),HL
00006579:       JR +0Bh

_EDIT:
0000657B:       CALL 0B0Bh				; LNUM_PARM - Read numeric function parameter
0000657E:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
00006581:       PUSH DE
00006582:       CALL 5F0Eh			; clear text page (text CLS)
00006585:       POP DE
00006586:       POP HL
00006587:       EX DE,HL
00006588:       LD (E6ABh),HL
0000658B:       EX DE,HL
0000658C:       CALL 0605h			; SRCHLN  -  Get first line number
0000658F:       JP NC,0C3Ch			; ULERR - entry for '?UL ERROR'
00006592:       LD H,B
00006593:       LD L,C
00006594:       EX DE,HL
00006595:       LD (E6BBh),HL
00006598:       EX DE,HL
00006599:       EX DE,HL
0000659A:       LD (E6BDh),HL
0000659D:       EX DE,HL
0000659E:       CALL 44D5h			; bank switching pivot (read)
000065A1:       PUSH HL
000065A2:       CALL 1C81h
000065A5:       POP HL
000065A6:       CALL 44A4h			; bank switching pivot (write)
000065A9:       INC HL
000065AA:       INC HL
000065AB:       LD E,(HL)
000065AC:       INC HL
000065AD:       LD D,(HL)
000065AE:       INC HL

000065AF:       PUSH HL
000065B0:       CALL 5A69h	; OUTDO_CRLF
000065B3:       EX DE,HL
000065B4:       CALL 28C2h			; _PRNUM - PRINT number pointed by HL
000065B7:       POP HL
000065B8:       LD A,(HL)
000065B9:       CP 09h
000065BB:       JR Z,+03h
000065BD:       LD A,20h
000065BF:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000065C0:       LD A,01h
000065C2:       LD (EFB9h),A
000065C5:       EX DE,HL
000065C6:       LD HL,0000h
000065C9:       LD (EFC2h),HL
000065CC:       LD (EFC0h),HL
000065CF:       EX DE,HL
000065D0:       CALL 44D5h			; bank switching pivot (read)
000065D3:       LD A,(EFBDh)
000065D6:       CP 80h
000065D8:       JR NC,+08h
000065DA:       SUB H
000065DB:       JR NZ,+05h
000065DD:       LD A,80h
000065DF:       LD (EFBDh),A
000065E2:       CALL 44A4h			; bank switching pivot (write)
000065E5:       CALL 194Ch
000065E8:       LD HL,E9B9h
000065EB:       CALL 1933h

000065EE:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
000065F1:       LD A,01h
000065F3:       CALL 5F86h
000065F6:       LD HL,(EFC2h)
000065F9:       LD A,H
000065FA:       OR L
000065FB:       JR NZ,+08h
000065FD:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00006600:       LD H,01h
00006602:       CALL 63E5h
00006605:       CALL 4494h                ; TXT_LOC
00006608:       LD HL,0000h
0000660B:       LD (EFBCh),HL
0000660E:       LD (EFC2h),HL
00006611:       XOR A
00006612:       LD (E6ADh),A
00006615:       INC A
00006616:       LD (EFB4h),A
00006619:       JP 04A7h			; PROMPT

0000661C:       CP 0Ah
0000661E:       JP NZ,0018h			; OUTC
00006621:       PUSH HL
00006622:       LD HL,(EC88h)		; PTRFIL
00006625:       LD A,H
00006626:       OR L
00006627:       POP HL
00006628:       LD A,0Ah
0000662A:       JR NZ,+0Fh
0000662C:       LD A,(E64Ch)		; PRTFLG ("printer enabled" flag)
0000662F:       OR A
00006630:       LD A,0Ah
00006632:       JR Z,+07h
00006634:       PUSH AF
00006635:       LD A,0Dh
00006637:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00006638:       POP AF
00006639:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000663A:       RET
0000663B:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000663C:       LD A,0Dh
0000663E:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000663F:       LD A,0Ah
00006641:       RET

__USING:
00006642:       CALL 11D4h				; EVAL_0 	- (a.k.a. GETNUM, evaluate expression (GETNUM)
00006645:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
00006648:       RST 08h					; SYNCHR - Check syntax, 1 byte follows to be compared
00006649:       DEFB ';'
0000664A:       EX DE,HL
0000664B:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000664E:       JR +08h
00006650:       LD A,(EAFCh)		; FLGINP
00006653:       OR A
00006654:       JR Z,+0Ch
00006656:       POP DE
00006657:       EX DE,HL
00006658:       PUSH HL
00006659:       XOR A
0000665A:       LD (EAFCh),A		; FLGINP
0000665D:       INC A
0000665E:       PUSH AF
0000665F:       PUSH DE
00006660:       LD B,(HL)
00006661:       OR B
00006662:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00006665:       INC HL
00006666:       LD A,(HL)
00006667:       INC HL
00006668:       LD H,(HL)
00006669:       LD L,A
0000666A:       JR +1Ah
0000666C:       LD E,B
0000666D:       PUSH HL
0000666E:       LD C,02h
00006670:       LD A,(HL)
00006671:       INC HL
00006672:       CP 26h		; '&'
00006674:       JP Z,67AEh
00006677:       CP 20h		; ' '
00006679:       JR NZ,+03h
0000667B:       INC C
0000667C:       DJNZ -0Eh
0000667E:       POP HL
0000667F:       LD B,E
00006680:       LD A,26h
00006682:       CALL 67E5h
00006685:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00006686:       XOR A
00006687:       LD E,A
00006688:       LD D,A
00006689:       CALL 67E5h
0000668C:       LD D,A
0000668D:       LD A,(HL)
0000668E:       INC HL
0000668F:       CP 21h
00006691:       JP Z,67ABh
00006694:       CP 23h		;'#'
00006696:       JR Z,+41h
00006698:       CP 40h		; '@'
0000669A:       JP Z,67A7h
0000669D:       DEC B
0000669E:       JP Z,678Ah
000066A1:       CP 2Bh
000066A3:       LD A,08h
000066A5:       JR Z,-1Eh
000066A7:       DEC HL
000066A8:       LD A,(HL)
000066A9:       INC HL
000066AA:       CP 2Eh		; '.'
000066AC:       JR Z,+45h
000066AE:       CP 5Fh 		; '_'
000066B0:       JP Z,679Eh
000066B3:       CP 26h		; '&'
000066B5:       JR Z,-4Bh
000066B7:       CP (HL)
000066B8:       JR NZ,-38h
000066BA:       CP 5Ch
000066BC:       JR Z,+14h
000066BE:       CP 2Ah
000066C0:       JR NZ,-40h
000066C2:       LD A,B
000066C3:       INC HL
000066C4:       CP 02h
000066C6:       JR C,+03h
000066C8:       LD A,(HL)
000066C9:       CP 5Ch
000066CB:       LD A,20h
000066CD:       JR NZ,+07h
000066CF:       DEC B
000066D0:       INC E
000066D1:       CP AFh				; TK_WHILE ?
000066D3:       ADD 10h
000066D5:       INC HL
000066D6:       INC E
000066D7:       ADD D
000066D8:       LD D,A
000066D9:       INC E
000066DA:       LD C,00h
000066DC:       DEC B
000066DD:       JR Z,+48h
000066DF:       LD A,(HL)
000066E0:       INC HL
000066E1:       CP 2Eh		; '.'
000066E3:       JR Z,+19h
000066E5:       CP 23h		;'#'
000066E7:       JR Z,-10h
000066E9:       CP 2Ch		; ','
000066EB:       JR NZ,+1Bh
000066ED:       LD A,D
000066EE:       OR 40h
000066F0:       LD D,A
000066F1:       JR -1Ah
000066F3:       LD A,(HL)
000066F4:       CP 23h		;'#'
000066F6:       LD A,2Eh
000066F8:       JP NZ,6682h
000066FB:       LD C,01h
000066FD:       INC HL
000066FE:       INC C
000066FF:       DEC B
00006700:       JR Z,+25h
00006702:       LD A,(HL)
00006703:       INC HL
00006704:       CP 23h		;'#'
00006706:       JR Z,-0Ah
00006708:       PUSH DE
00006709:       LD DE,6725h
0000670C:       PUSH DE
0000670D:       LD D,H
0000670E:       LD E,L
0000670F:       CP 5Eh		; TK_RBYTE
00006711:       RET NZ
00006712:       CP (HL)
00006713:       RET NZ
00006714:       INC HL
00006715:       CP (HL)
00006716:       RET NZ
00006717:       INC HL
00006718:       CP (HL)
00006719:       RET NZ
0000671A:       INC HL
0000671B:       LD A,B
0000671C:       SUB 04h
0000671E:       RET C
0000671F:       POP DE
00006720:       POP DE
00006721:       LD B,A
00006722:       INC D
00006723:       INC HL
00006724:       JP Z,D1EBh
00006727:       LD A,D
00006728:       DEC HL
00006729:       INC E
0000672A:       AND 08h
0000672C:       JR NZ,+15h
0000672E:       DEC E
0000672F:       LD A,B
00006730:       OR A
00006731:       JR Z,+10h
00006733:       LD A,(HL)
00006734:       SUB 2Dh
00006736:       JR Z,+06h
00006738:       CP FEh
0000673A:       JR NZ,+07h
0000673C:       LD A,08h
0000673E:       ADD 04h
00006740:       ADD D
00006741:       LD D,A
00006742:       DEC B
00006743:       POP HL
00006744:       POP AF
00006745:       JR Z,+4Ch
00006747:       PUSH BC
00006748:       PUSH DE
00006749:       CALL 11D3h			; EVAL - evaluate expression
0000674C:       POP DE
0000674D:       POP BC
0000674E:       PUSH BC
0000674F:       PUSH HL
00006750:       LD B,E
00006751:       LD A,B
00006752:       ADD C
00006753:       CP 19h
00006755:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
00006758:       LD A,D

00006759:       OR 80h
0000675B:       CALL 28D1h			; PUFOUT - Convert number/expression to string (format specified in 'A' register)
0000675E:       CALL 5550h			; PRS - Print message pointed by HL
00006761:       POP HL
00006762:       DEC HL
00006763:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00006764:       SCF
00006765:       JR Z,+0Bh
00006767:       LD (EAFCh),A		; FLGINP
0000676A:       CP 3Bh		; ';'
0000676C:       JR Z,+03h
0000676E:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000676F:       DEFB ','
00006770:       LD B,D7h
00006772:       POP BC
00006773:       EX DE,HL
00006774:       POP HL
00006775:       PUSH HL
00006776:       PUSH AF
00006777:       PUSH DE
00006778:       LD A,(HL)
00006779:       SUB B
0000677A:       INC HL
0000677B:       LD D,00h
0000677D:       LD E,A
0000677E:       LD A,(HL)
0000677F:       INC HL
00006780:       LD H,(HL)
00006781:       LD L,A
00006782:       ADD HL,DE
00006783:       LD A,B
00006784:       OR A
00006785:       JP NZ,6686h
00006788:       JR +04h
0000678A:       CALL 67E5h
0000678D:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000678E:       POP HL
0000678F:       POP AF
00006790:       JP NZ,6650h
00006793:       CALL C,5A69h	; OUTDO_CRLF
00006796:       EX HL,(SP)
00006797:       CALL 56CFh				; GSTRHL - Get string pointed by HL
0000679A:       POP HL
0000679B:       JP 0F8Bh			; FINPRT - finalize PRINT

0000679E:       CALL 67E5h
000067A1:       DEC B
000067A2:       LD A,(HL)
000067A3:       INC HL
000067A4:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000067A5:       JR -24h
000067A7:       LD C,00h
000067A9:       JR +04h
000067AB:       LD C,01h
000067AD:       LD A,F1h
000067AF:       DEC B
000067B0:       CALL 67E5h
000067B3:       POP HL
000067B4:       POP AF
000067B5:       JR Z,-24h
000067B7:       PUSH BC
000067B8:       CALL 11D3h			; EVAL - evaluate expression
000067BB:       CALL 2256h				; TSTSTR - Test a string, 'Type Error' if it is not
000067BE:       POP BC
000067BF:       PUSH BC
000067C0:       PUSH HL
000067C1:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000067C4:       LD B,C
000067C5:       LD C,00h
000067C7:       LD A,B
000067C8:       PUSH AF
000067C9:       LD A,B
000067CA:       OR A
000067CB:       CALL NZ,5761h			; __LEFT_S_1 = $5760+1
000067CE:       CALL 5553h				; PRS1
000067D1:       LD HL,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
000067D4:       POP AF
000067D5:       OR A
000067D6:       JP Z,6761h
000067D9:       SUB (HL)
000067DA:       LD B,A
000067DB:       LD A,20h
000067DD:       INC B
000067DE:       DEC B
000067DF:       JP Z,6761h
000067E2:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000067E3:       JR -07h
000067E5:       PUSH AF
000067E6:       LD A,D
000067E7:       OR A
000067E8:       LD A,2Bh
000067EA:       CALL NZ,0018h			; OUTC
000067ED:       POP AF
000067EE:       RET

000067EF:       CALL 44D5h			; bank switching pivot (read)
000067F2:       PUSH HL
000067F3:       LD A,80h
000067F5:       LD (F005h),A
000067F8:       CALL 692Bh          ; CSAVE_HEADER
000067FB:       LD HL,(EB18h)			; ARYTAB - Pointer to begin of array table
000067FE:       LD (ECB1h),HL
00006801:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00006804:       CALL 6952h
00006807:       CALL 7F1Ah          ; TAPOOF
0000680A:       POP HL
0000680B:       CALL 44A4h			; bank switching pivot (write)
0000680E:       RET

0000680F:       CP 01h
00006811:       PUSH AF
00006812:       LD A,FFh
00006814:       LD (F007h),A		; FRCNEW
00006817:       LD A,FFh
00006819:       LD (F006h),A
0000681C:       PUSH DE
0000681D:       CALL 7ED0h          ; TAPION
00006820:       POP DE
00006821:       CALL 6897h          ; CLOAD_HEADER
00006824:       LD HL,EC98h
00006827:       CALL 68B8h
0000682A:       JP NZ,687Eh
0000682D:       LD HL,68C9h			; "Found:"
00006830:       CALL 68D6h			; PRS+CR+LF
00006833:       POP AF
00006834:       LD (EC41h),A			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
00006837:       CALL C,4F01h			; CLRPTR
0000683A:       LD A,(EC41h)			; FPREG - Floating Point Register (FACCU, FACLOW on Ext. BASIC)
0000683D:       CP 01h
0000683F:       LD (F007h),A		; FRCNEW
00006842:       PUSH AF
00006843:       CALL 1C81h
00006846:       POP AF
00006847:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
0000684A:       CALL 6976h
0000684D:       JR NZ,+17h		; __CLOAD_1
0000684F:       LD (EB18h),HL			; ARYTAB - Pointer to begin of array table
; __CLOAD_0
00006852:       LD HL,031Ah			; "Ok"
00006855:       CALL 5550h			; PRS - Print message pointed by HL
00006858:       CALL 7F15h          ; TAPIOF
0000685B:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
0000685E:       PUSH HL
0000685F:       XOR A
00006860:       LD (F007h),A		; FRCNEW
00006863:       JP 05A1h

; __CLOAD_1
00006866:       CALL 44D5h			; bank switching pivot (read)
00006869:       INC HL
0000686A:       EX DE,HL
0000686B:       LD HL,(EB18h)			; ARYTAB - Pointer to begin of array table
0000686E:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000686F:       JP C,6852h	; __CLOAD_0
00006872:       LD HL,6891h			; "Bad", 0Dh, 0Ah
00006875:       CALL 5550h			; PRS - Print message pointed by HL
00006878:       CALL 7F15h        ; TAPIOF
0000687B:       JP 047Ah

0000687E:       LD HL,68D0h		; "Skip:"
00006881:       CALL 68D6h		; PRS+CR+LF

00006884:       LD B,0Ah
00006886:       CALL 7F87h		; CASIN (get byte from tape)
00006889:       OR A
0000688A:       JR NZ,-08h
0000688C:       DJNZ -08h
0000688E:       JP 6817h

00006891:       DEFM "Bad"
00006894:       DEFB 0Dh
00006895:       DEFB 0Ah
00006896:       NOP

;CLOAD_HEADER
00006897:       LD B,0Ah
00006899:       CALL 7F87h		; CASIN (get byte from tape)
0000689C:       SUB D3h         ; BASIC PROGRAM header mode (TK_NAME)
0000689E:       JR NZ,-09h
000068A0:       DJNZ -09h
000068A2:       XOR A
000068A3:       LD (F006h),A
000068A6:       LD HL,EC98h
000068A9:       LD B,06h
000068AB:       CALL 7F87h		; CASIN (get byte from tape)
000068AE:       LD (HL),A
000068AF:       INC HL
000068B0:       DJNZ -07h
000068B2:       LD A,FFh
000068B4:       LD (E6A4h),A
000068B7:       RET

000068B8:       LD BC,EC8Fh			; FILNAM
000068BB:       LD E,06h
000068BD:       LD A,(BC)
000068BE:       OR A
000068BF:       RET Z
000068C0:       LD A,(BC)
000068C1:       CP (HL)
000068C2:       INC HL
000068C3:       INC BC
000068C4:       RET NZ
000068C5:       DEC E
000068C6:       JR NZ,-08h
000068C8:       RET

000068C9:       DEFM "Found:"
000068CF:       NOP

000068D0:       DEFM "Skip:"

; PRS+CR+LF
000068D6:       PUSH DE
000068D7:       PUSH AF
000068D8:       CALL 5550h			; PRS - Print message pointed by HL
000068DB:       LD HL,EC98h
000068DE:       LD B,06h
000068E0:       LD A,(HL)
000068E1:       INC HL
000068E2:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000068E3:       DJNZ -05h
000068E5:       CALL 5A69h	; OUTDO_CRLF
000068E8:       POP AF
000068E9:       POP DE
000068EA:       RET

000068EB:       PUSH HL
000068EC:       PUSH AF
000068ED:       LD A,FFh
000068EF:       LD (F007h),A		; FRCNEW
000068F2:       LD (F006h),A
000068F5:       CALL 7ED0h      ; TAPION
000068F8:       LD B,06h
000068FA:       CALL 7F87h		; CASIN (get byte from tape)
000068FD:       CP 9Ch
000068FF:       JP NZ,68F8h
00006902:       DJNZ -0Ah
00006904:       XOR A
00006905:       LD (F006h),A
00006908:       POP AF
00006909:       POP HL
0000690A:       RET

;CSAVE_HEADER_0
0000690B:       PUSH HL
0000690C:       PUSH AF
0000690D:       CALL 7F4Dh      ; TAPOON
00006910:       LD B,06h
00006912:       LD A,9Ch
00006914:       CALL 7FD0h      ; CSAVE byte
00006917:       DJNZ -05h
00006919:       POP AF
0000691A:       POP HL
0000691B:       RET

0000691C:       PUSH DE
0000691D:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000691E:       CALL 1896h				; POSINT - Get positive integer
00006921:       INC DE
00006922:       LD A,E
00006923:       OR D
00006924:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
00006927:       POP DE
00006928:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00006929:       DEFB ','
0000692A:       RET

; CSAVE_HEADER
0000692B:       LD A,FFh
0000692D:       LD (F007h),A		; FRCNEW
00006930:       CALL 7F4Dh			; TAPOON
00006933:       LD A,D3h            ; BASIC PROGRAM header mode (TK_NAME)
00006935:       LD B,0Ah
00006937:       CALL 7FD0h          ; CSAVE byte
0000693A:       DJNZ -05h
0000693C:       LD B,06h
0000693E:       LD HL,EC8Fh			; FILNAM
00006941:       LD A,(HL)
00006942:       INC HL
00006943:       CALL 7FD0h          ; CSAVE byte
00006946:       DJNZ -07h
00006948:       LD BC,4E20h         ; 20000 (wait for a while)
0000694B:       DEC BC
0000694C:       LD A,B
0000694D:       OR C
0000694E:       JP NZ,694Bh
00006951:       RET

00006952:       PUSH HL
00006953:       CALL 1C81h
00006956:       POP HL
00006957:       EX DE,HL
00006958:       LD HL,(ECB1h)
0000695B:       EX DE,HL
0000695C:       CALL 44A4h			; bank switching pivot (write)
0000695F:       EX DE,HL
00006960:       LD A,(DE)
00006961:       INC DE
00006962:       EX DE,HL
00006963:       CALL 44D5h			; bank switching pivot (read)
00006966:       EX DE,HL
00006967:       CALL 7FD0h          ; CSAVE byte
0000696A:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000696B:       JR NZ,-12h
0000696D:       LD L,09h
0000696F:       CALL 7FD0h          ; CSAVE byte
00006972:       DEC L
00006973:       JR NZ,-06h
00006975:       RET


00006976:       SBC A
00006977:       CPL
00006978:       LD D,A
00006979:       LD B,0Ah
0000697B:       CALL 7F87h		; CASIN (get byte from tape)
0000697E:       LD E,A
0000697F:       PUSH DE
00006980:       LD DE,7FFCh
00006983:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00006984:       POP DE
00006985:       JR C,+09h
00006987:       CALL 4F01h			; CLRPTR
0000698A:       CALL 7F15h        ; TAPIOF
0000698D:       JP 4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'

00006990:       CALL 44A4h			; bank switching pivot (write)
00006993:       LD A,E
00006994:       SUB (HL)
00006995:       AND D
00006996:       RET NZ
00006997:       LD (HL),E
00006998:       LD A,(E6CAh)		; INTFLG
0000699B:       CP 03h
0000699D:       SCF
0000699E:       RET Z
0000699F:       LD A,(HL)
000069A0:       CALL 44D5h			; bank switching pivot (read)
000069A3:       OR A
000069A4:       INC HL
000069A5:       JR NZ,-2Eh
000069A7:       CALL 7FB4h
000069AA:       DJNZ -31h
000069AC:       LD BC,FFFAh
000069AF:       ADD HL,BC
000069B0:       XOR A
000069B1:       RET

; Prepare jump table at $ECBB and $EE0E
000069B2:       LD HL,ECBBh
000069B5:       LD B,71h		; 71 entries
000069B7:       LD DE,0003h
000069BA:       LD (HL),C9h		; RET instruction
000069BC:       ADD HL,DE
000069BD:       DJNZ -05h

000069BF:       LD HL,EE0Eh
000069C2:       LD B,3Fh
000069C4:       LD DE,4DC1h		; 'Feature not available' error
000069C7:       JP 3CC0h		; Init JP table at HL, B entries, default JP address in DE


000069CA:       LD (HL),E
000069CB:       INC HL
000069CC:       LD (HL),D
000069CD:       INC HL
000069CE:       DJNZ -09h
000069D0:       RET

;Interrupt table in N88-BASIC
000069D1:       LD DE,F300h
000069D4:       DI
000069D5:       LD A,D
000069D6:       LD I,A
000069D8:       LD HL,0326h
000069DB:       LD BC,0020h
000069DE:       LDIR
000069E0:       RET

; init text mode basing on DIP switches
000069E1:       LD BC,2814h		; 40, 20
000069E4:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
000069E7:       LD L,A
000069E8:       AND 04h			; text columns
000069EA:       JR Z,+02h
000069EC:       LD B,50h		; 80
000069EE:       LD A,L
000069EF:       AND 08h			; text rows
000069F1:       JR Z,+02h
000069F3:       LD C,19h		; 25
000069F5:       PUSH BC
000069F6:       LD HL,6F6Ah			; CRTSET - on stack: columns, rows
000069F9:       PUSH HL
000069FA:       PUSH BC
000069FB:       JP 51E4h			; init TTYPOS2 + CRTSET - on stack: columns, rows

; JP TABLE for BASIC statements
000069FE:       PUSH HL
000069FF:       LD D,B
00006A00:       CP A
00006A01:       EX AF,AF'
00006A02:       CP L
00006A03:       LD D,D
00006A04:       LD (HL),A
00006A05:       INC C
00006A06:       DEC L
00006A07:       DJNZ -3Bh
00006A09:       LD E,D
00006A0A:       LD SP,HL
00006A0B:       DJNZ -64h
00006A0D:       INC C
00006A0E:       LD SP,HL
00006A0F:       DEC BC
00006A10:       LD A,H
00006A11:       DEC BC
00006A12:       DEC B
00006A13:       LD C,A5h
00006A15:       LD D,B
00006A16:       CP A
00006A17:       DEC BC
00006A18:       LD B,C
00006A19:       INC C
00006A1A:       LD A,C
00006A1B:       INC C
00006A1C:       JP Z,5450h
00006A1F:       LD C,2Eh
00006A21:       LD D,D
00006A22:       EXX
00006A23:       JR -23h
00006A25:       LD (HL),A
00006A26:       LD BC,000Dh
00006A29:       JR -29h
00006A2B:       DEC D
00006A2C:       ADD H
00006A2D:       DEC DE
00006A2E:       LD B,B
00006A2F:       LD D,C
00006A30:       JP M,4C17h
00006A33:       LD C,D4h
00006A35:       JR +71h
00006A37:       LD (HL),B
00006A38:       LD A,(DE)
00006A39:       JR +79h
00006A3B:       INC C
00006A3C:       LD E,B
00006A3D:       LD D,C
00006A3E:       LD E,C
00006A3F:       LD D,C
00006A40:       LD E,(HL)
00006A41:       LD D,C
00006A42:       SBC H
00006A43:       LD D,C
00006A44:       LD A,E
00006A45:       LD H,L
00006A46:       JP Z,8D0Dh
00006A49:       DEC C
00006A4A:       LD B,B
00006A4B:       DEC DE
00006A4C:       PUSH DE
00006A4D:       DEC C
00006A4E:       LD C,6Fh
00006A50:       CALL NZ,C70Ah
00006A53:       LD A,(BC)
00006A54:       JP Z,CD0Ah
00006A57:       LD A,(BC)
00006A58:       XOR D
00006A59:       RRCA
00006A5A:       ADD B
00006A5B:       XOR 83h
00006A5D:       XOR 89h
00006A5F:       XOR 00h
00006A61:       NOP
00006A62:       NOP
00006A63:       NOP
00006A64:       NOP
00006A65:       NOP
00006A66:       ADD (HL)
00006A67:       XOR C5h
00006A69:       XOR 7Ah
00006A6B:       XOR 89h
00006A6D:       INC E
00006A6E:       POP DE
00006A6F:       INC E
00006A70:       SBC B
00006A71:       XOR 98h
00006A73:       LD B,A
00006A74:       LD E,H
00006A75:       LD C,D
00006A76:       SBC B
00006A77:       LD (HL),C
00006A78:       AND (HL)
00006A79:       LD (HL),C
00006A7A:       ADC H
00006A7B:       XOR 04h
00006A7D:       LD C,E
00006A7E:       LD D,H
00006A7F:       LD C,B
00006A80:       LD D,L
00006A81:       LD C,B
00006A82:       SBC E
00006A83:       XOR 8Fh
00006A85:       XOR 92h
00006A87:       XOR ABh
00006A89:       LD C,C
00006A8A:       XOR D
00006A8B:       LD C,C
00006A8C:       AND E
00006A8D:       LD C,B
00006A8E:       SBC (HL)
00006A8F:       XOR 26h
00006A91:       RET PE
00006A92:       ADD 6Eh
00006A94:       ADC 6Eh
00006A96:       AND (HL)
00006A97:       LD L,(HL)
00006A98:       OR L
00006A99:       LD (HL),C
00006A9A:       SBC D
00006A9B:       LD L,(HL)
00006A9C:       SUB (HL)
00006A9D:       LD L,(HL)
00006A9E:       JP C,676Eh
00006AA1:       LD (HL),E
00006AA2:       SBC 6Eh
00006AA4:       CP A
00006AA5:       XOR C2h
00006AA7:       XOR 4Eh
00006AA9:       LD (HL),C
00006AAA:       OR H
00006AAB:       LD A,CAh
00006AAD:       LD L,(HL)
00006AAE:       XOR E
00006AAF:       LD (HL),D
00006AB0:       LD E,D
00006AB1:       LD D,A
00006AB2:       ADC D
00006AB3:       LD D,A
00006AB4:       SUB E
00006AB5:       LD D,A
00006AB6:       OR E
00006AB7:       JR NZ,-6Bh
00006AB9:       LD (20A0h),HL
00006ABC:       DEC B
00006ABD:       LD L,1Ah
00006ABF:       CPL
00006AC0:       SUB C
00006AC1:       CPL
00006AC2:       DJNZ +1Fh
00006AC4:       LD L,(HL)
00006AC5:       LD L,8Bh
00006AC7:       CPL
00006AC8:       INC L
00006AC9:       JR NC,-38h
00006ACB:       XOR E4h
00006ACD:       LD E,B
00006ACE:       PUSH HL
00006ACF:       RLA
00006AD0:       ADD (HL)
00006AD1:       DEC D
00006AD2:       RET M
00006AD3:       LD D,(HL)
00006AD4:       BIT 2,H
00006AD6:       OR H
00006AD7:       LD D,A
00006AD8:       INC B
00006AD9:       LD D,A
00006ADA:       INC D
00006ADB:       LD D,A
00006ADC:       LD A,D
00006ADD:       DEC DE
00006ADE:       LD B,C
00006ADF:       LD D,A
00006AE0:       POP BC
00006AE1:       LD D,H
00006AE2:       ADD 54h
00006AE4:       ADD C
00006AE5:       DEC D
00006AE6:       AND B
00006AE7:       LD HL,2214h			; CSNG - Convert number to single precision
00006AEA:       LD A,22h
00006AEC:       ADD (HL)
00006AED:       LD (4ABAh),HL
00006AF0:       CP L
00006AF1:       LD C,D
00006AF2:       RET NZ
00006AF3:       LD C,D
00006AF4:       LD D,C
00006AF5:       LD C,H
00006AF6:       CPL
00006AF7:       LD C,H
00006AF8:       LD B,B
00006AF9:       LD C,H
00006AFA:       LD H,D
00006AFB:       LD C,H
00006AFC:       AND C
00006AFD:       LD C,D
00006AFE:       AND H
00006AFF:       LD C,D
00006B00:       AND A
00006B01:       LD C,D


; jump table for extra functions -2
00006B02:       DEFW EE77h
; jump table for extra functions
00006B04:       DEFW 0000h
00006B06:       DEFW 6EE2h
00006B08:       DEFW 6EBAh
00006B0A:       DEFW 6ED2h
00006B0C:       DEFW 6ED6h		; 
00006B0E:       DEFW 6EC2h		; 11: _CSRLIN
00006B10:       DEFW 6EB2h		; 12: get coordinate parameter
00006B12:       DEFW 3F31h
00006B14:       DEFW 0000h
00006B16:       DEFW 6E9Eh
00006B18:       DEFW 0000h
00006B1A:       DEFW EE7Dh
00006B1C:       DEFW 0000h
00006B1E:       DEFW 0393h		;  
00006B20:       DEFW 7F30h		;  
00006B22:       DEFW 6EF2h		;  
00006B24:       DEFW 72C8h		;  
00006B26:       DEFW 6F02h		;  
00006B28:       DEFW 721Ch		;  
00006B2A:       DEFW 0393h		;  
00006B2C:       DEFW 7D71h		;  
00006B2E:       DEFW 0393h		;  
00006B30:       DEFW 6EFAh		;  91: FN_KEY (sub n.25 in ROM0)
00006B32:       DEFW 6EFEh		;  
00006B34:       DEFW 7279h		;  
00006B36:       DEFW 0000h		;  
00006B38:       DEFW EE1Ah		;  
00006B3A:       DEFW 0000h		;  
00006B3C:       DEFW EE4Ah		;  
00006B3E:       DEFW 0000h		;  
00006B40:       DEFW EEA7h		;  
00006B42:       DEFW 0000h		; 
00006B44:       DEFW EEAAh
00006B46:       DEFW EEB9h
00006B48:       DEFW 0000h
00006B4A:       DEFW 0000h
00006B4C:       DEFW EEADh
00006B4E:       DEFW EEB3h
00006B50:       DEFW EEB0h
00006B52:       DEFW 0000h
00006B54:       DEFW EEB6h		; FN_POINT



; WORD_PTR
00006B56:       DEFW	6B8Ah	; WORDS_A
00006B58:       DEFW	6BA0h	; WORDS_B
00006B5A:       DEFW	6BAFh	; WORDS_C
00006B5C:       DEFW	6C0Eh	; WORDS_D
00006B5E:       DEFW	6C4Ah	; WORDS_E
00006B60:       DEFW	6C6Fh	; WORDS_F
00006B62:       DEFW	6C89h	; WORDS_G
00006B64:       DEFW	6C9Bh	; WORDS_H
00006B66:       DEFW	6CA4h	; WORDS_I
00006B68:       DEFW	6CCEh	; WORDS_J
00006B6A:       DEFW	6CCFh	; WORDS_K
00006B6C:       DEFW	6CDCh	; WORDS_L
00006B6E:       DEFW	6D1Ch	; WORDS_M
00006B70:       DEFW	6D40h	; WORDS_N
00006B72:       DEFW	6D4Fh	; WORDS_O
00006B74:       DEFW	6D68h	; WORDS_P
00006B76:       DEFW	6D97h	; WORDS_Q
00006B78:       DEFW	6D98h	; WORDS_R
00006B7A:       DEFW	6DDAh	; WORDS_S
00006B7C:       DEFW	6E21h	; WORDS_T
00006B7E:       DEFW	6E41h	; WORDS_U
00006B80:       DEFW	6E4Ah	; WORDS_V
00006B82:       DEFW	6E58h	; WORDS_W
00006B84:       DEFW	6E7Bh	; WORDS_X
00006B86:       DEFW	6E7Fh	; WORDS_Y
00006B88:       DEFW	6E80h	; WORDS_Z



6B8A:  ; WORDS_A
6B80                                55 54 CF A8 4E C4             UT..N.
6B90  F8 42 D3 06 54 CE 0E 53-C3 15 54 54 52 A4 EB 00   .B..T..S..TTR...

; WORDS_B
6BA0  53 41 56 C5 D5 4C 4F 41-C4 D4 45 45 D0 D7 00 4F   SAV..LOA..EE...O
6BB0  4E 53 4F 4C C5 9D 4F 50-D9 CD 4C 4F 53 C5 C0 4F   NSOL..OP..LOS..O
6BC0  4E D4 99 4C 45 41 D2 92-53 52 4C 49 CE 54 49 4E   N..LEA..SRLI.TIN
6BD0  D4 1C 53 4E C7 1D 44 42-CC 1E 56 C9 20 56 D3 21   ..SN..DB..V. V.!
6BE0  56 C4 22 4F D3 0C 48 52-A4 16 41 4C CC B1 4F 4D   V."O..HR..AL..OM
6BF0  4D 4F CE B6 48 41 49 CE-B7 4F CD 5A 49 52 43 4C   MO..HAI..O.ZIRCL
6C00  C5 CC 4F 4C 4F D2 CB 4C-D3 CE 4D C4 64 00 45 4C   ..OLO..L..M.d.EL
6C10  45 54 C5 A7 41 54 C1 84-49 CD 86 45 46 53 54 D2   ET..AT..I..EFST.
6C20  AA 45 46 49 4E D4 AB 45-46 53 4E C7 AC 45 46 44   .EFIN..EFSN..EFD
6C30  42 CC AD 53 4B 4F A4 BA-45 C6 97 53 4B 49 A4 EC   B..SKO..E..SKI..
6C40  53 4B C6 50 41 54 45 A4-59 00 4C 53 C5 9F 4E C4   SK.PATE.Y.LS..N.
6C50  81 52 41 53 C5 A3 44 49-D4 A4 52 52 4F D2 A5 52   .RAS..DI..RRO..R
6C60  CC E4 52 D2 E5 58 D0 0B-4F C6 23 51 D6 FB 00      ..R..X..O.#Q...

6C6F:   ; WORDS_F
6C60                                               4F                  O
6C70  D2 82 49 45 4C C4 BC 49-4C 45 D3 C3 CE E1 52 C5   ..IEL..ILE....R.
6C80  0F 49 D8 1F 50 4F D3 26-00 4F 54 CF 89 4F 20 54   .I..PO.&.OT..O T
6C90  CF 89 4F 53 55 C2 8D 45-D4 BD 00 45 58 A4 1A 45   ..OSU..E...EX..E
6CA0  4C D0 D9 00 4E 50 55 D4-85 53 45 D4 60 45 45 C5   L...NPU..SE.`EE.
6CB0  61 52 45 53 45 D4 62 C6-8B 4E 53 54 D2 E8 4E D4   aRESE.b..NST..N.
6CC0  05 4E D0 10 4D D0 FC 4E-4B 45 59 A4 EF 00 00      .N..M..NKEY....

6CCF:   ; WORDS_K
6CC0                                               45                  E 
6CD0  D9 5B 49 4C CC C5 41 4E-4A C9 DB 00 4F 43 41 54   .[IL..ANJ...OCAT
6CE0  C5 D6 50 52 49 4E D4 9B-4C 49 53 D4 9C 50 4F D3   ..PRIN..LIS..PO.
6CF0  1B 45 D4 88 49 4E C5 AE-4F 41 C4 C1 53 45 D4 C6   .E..IN..OA..SE..
6D00  49 53 D4 93 46 49 4C 45-D3 C9 4F C7 0A 4F C3 24   IS..FILE..O..O.$
6D10  45 CE 12 45 46 54 A4 01-4F C6 25 00 4F 54 4F D2   E..EFT..O.%.OTO.
6D20  57 45 52 47 C5 C2 4F C4-FD 4B 49 A4 27 4B 53 A4   WERG..O..KI.'KS.
6D30  28 4B 44 A4 29 49 44 A4-03 4F CE CA 41 D0 55 00   (KD.)ID..O..A.U.

6D40:   ; WORDS_N
6D40  45 58 D4 83 41 4D C5 C4-45 D7 94 4F D4 E3 00 50   EX..AM..E..O...P
6D50  45 CE BB 55 D4 9A CE 95-D2 F9 43 54 A4 19 50 54   E..U......CT..PT
6D60  49 4F CE B8 46 C6 EE 00-52 49 4E D4 91 55 D4 BE   IO..F...RIN..U..
6D70  4F 4B C5 98 4F 4C CC 5F-4F D3 11 45 45 CB 17 53   OK..OL._O..EE..S
6D80  45 D4 CF 52 45 53 45 D4-D0 4F 49 4E D4 53 41 49   E..RESE..OIN.SAI
6D90  4E D4 D1 45 CE 58 00 00-45 54 55 52 CE 8E 45 41   N..E.X..ETUR..EA
6DA0  C4 87 55 CE 8A 45 53 54-4F 52 C5 8C 42 59 54 C5   ..U..ESTOR..BYT.
6DB0  5E 45 CD 8F 45 53 55 4D-C5 A6 53 45 D4 C7 49 47   ^E..ESUM..SE..IG
6DC0  48 54 A4 02 4E C4 08 45-4E 55 CD A9 41 4E 44 4F   HT..N..ENU..ANDO
6DD0  4D 49 5A C5 B9 4F 4C CC-D8 00                     MIZ..OL...

6DDA:   ; WORDS_S
6DD0                                43 52 45 45 CE D3             CREE..
6DE0  45 41 52 43 C8 56 54 4F-D0 90 57 41 D0 A2 45 D4   EARC.VTO..WA..E.
6DF0  BF 52 D1 ED 54 41 54 55-D3 63 41 56 C5 C8 50 43   .R..TATU.cAV..PC
6E00  A8 E2 54 45 D0 DF 47 CE-04 51 D2 07 49 CE 09 54   ..TE..G..Q..I..T
6E10  52 A4 13 54 52 49 4E 47-A4 E6 50 41 43 45 A4 18   R..TRING..PACE..
6E20  00                                                .

6E20:   ; WORDS_T
6E20     48 45 CE DD 52 4F CE-A0 52 4F 46 C6 A1 41 42    HE..RO..ROF..AB
6E30  A8 DE CF DC 41 CE 0D 45-52 CD D2 49 4D 45 A4 5C   ....A..ER..IME.\
6E40  00                                                .

6E41:   ; WORDS_U
6E40     53 49 4E C7 E7 53 D2-E0 00 41 CC 14 49 45 D7    SIN..S...A..IE.
6E50  51 41 52 50 54 D2 EA 00-49 44 54 C8 9E 49 4E 44   QARPT...IDT..IND
6E60  4F D7 52 41 49 D4 96 48-49 4C C5 AF 45 4E C4 B0   O.RAI..HIL..EN..
6E70  52 49 54 C5 B5 42 59 54-C5 5D 00                  RIT..BYT.].

; WORDS_Y
00006E7F:       NOP

; WORDS_Z
00006E80:       NOP



00006E81:       XOR E
00006E82:       DI
00006E83:       XOR L
00006E84:       CALL P,F5AAh
00006E87:       XOR A
00006E88:       OR DEh
00006E8A:       RST 30h				; GETYPR -  Test number FAC type (Precision mode, etc..)
00006E8B:       CALL C,A7FEh
00006E8E:       LD PC,HL

00006E8F:       CP (HL)
00006E90:       RET P
00006E91:       CP L
00006E92:       POP AF
00006E93:       CP H
00006E94:       JP P,CD00h


; JUMP TABLE for FAR BASIC COMMANDS

_PRESET:
00006E96:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006E99:       DEFB 0
_PSET:
00006E9A:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006E9D:       DEFB 1

00006E9E:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EA1:       DEFB 2

00006EA2:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EA5:       DEFB 3
_COPY:
00006EA6:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EA9:       DEFB 4

00006EAA:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EAD:       DEFB 5
; 'LINE' jumps here for graphics LINE command
00006EAE:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EB1:       DEFB 6

; get coordinate parameter
00006EB2:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EB5:       DEFB 7

00006EB6:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EB9:       DEFB 8

00006EBA:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EBD:       DEFB 9

00006EBE:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EC1:       DEFB 10
_CSRLIN:
00006EC2:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EC5:       DEFB 11
_COLOR:
00006EC6:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EC9:       DEFB 12
_ROLL:
00006ECA:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006ECD:       DEFB 13
_CIRCLE:
00006ECE:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006ED1:       DEFB 14

00006ED2:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006ED5:       DEFB 15

00006ED6:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006ED9:       DEFB 16
_PAINT:
00006EDA:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EDD:       DEFB 17
_SCREEN:
00006EDE:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EE1:       DEFB 18

00006EE2:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EE5:       DEFB 19

; clear graphics page 1
00006EE6:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EE9:       DEFB 20

; clear graphics page 2
00006EEA:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EED:       DEFB 21

00006EEE:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EF1:       DEFB 22

00006EF2:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EF5:       DEFB 23

00006EF6:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EF9:       DEFB 24

FN_KEY
00006EFA:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006EFD:       DEFB 25

00006EFE:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006F01:       DEFB 26

00006F02:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006F05:       DEFB 27

00006F06:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006F09:       DEFB 28

00006F0A:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006F0D:       DEFB 29
_RENUM:
00006F0E:       CALL 4551h		; EXEC_ROM0 - run subprogram in ROM0 bank, next byte holds the subroutine number
00006F11:       DEFB 30


00006F12:       LD A,1
00006F14:       PUSH HL
00006F15:       PUSH DE
00006F16:       CALL 3583h			; INICHR (aka GETCHAR)
00006F19:       POP DE
00006F1A:       POP HL
00006F1B:       JP 4B8Ch

00006F1E:       EX DE,HL
00006F1F:       POP HL
00006F20:       POP AF
00006F21:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
00006F24:       CALL 7AC0h
00006F27:       LD B,C
00006F28:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00006F2B:       JR C,+07h
00006F2D:       CALL 3583h			; INICHR (aka GETCHAR)
00006F30:       LD (HL),A
00006F31:       INC HL
00006F32:       DJNZ -0Ch
00006F34:       JP 7E60h

; pointed by [$EE2E + 1]
00006F37:       LD A,E9h
00006F39:       CALL 7B2Fh
00006F3C:       JP 0DDDh

00006F3F:       PUSH HL
00006F40:       LD DE,0008h
00006F43:       ADD HL,DE
00006F44:       POP DE
00006F45:       EX HL,(SP)
00006F46:       POP BC
00006F47:       POP AF
00006F48:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00006F4B:       PUSH BC
00006F4C:       CALL 7AC0h
00006F4F:       EX DE,HL
00006F50:       POP HL
00006F51:       EX HL,(SP)
00006F52:       PUSH HL
00006F53:       EX DE,HL
00006F54:       LD B,C
00006F55:       LD A,(HL)
00006F56:       INC HL
00006F57:       EX HL,(SP)
00006F58:       CALL 6F61h
00006F5B:       EX HL,(SP)
00006F5C:       DJNZ -09h
00006F5E:       JP 7BA0h

00006F61:       CALL 59A4h
00006F64:       LD A,(EF87h)			; TTYPOS, (a.k.a. CSRX or CursorPos+1)
00006F67:       DEC A
00006F68:       LD (HL),A
00006F69:       RET

; CRTSET - on stack: columns, rows
00006F6A:       POP BC
; CRTSET - B=columns, C=rows
00006F6B:       PUSH HL
00006F6C:       LD HL,(E6B2h)		; scroll area ORG
00006F6F:       LD (E6B0h),HL		; scroll area
00006F72:       CALL 6FB4h
00006F75:       LD A,C
00006F76:       LD (EF88h),A		; HEIGHT (TextHeight)
00006F79:       CP 14h		; 20
00006F7B:       LD HL,705Bh
00006F7E:       JR Z,+03h
00006F80:       LD HL,7066h
00006F83:       LD A,B
00006F84:       LD (EF89h),A	; WIDTH
00006F87:       PUSH AF
00006F88:       CALL 1880h
00006F8B:       POP AF
00006F8C:       CP 29h		; 40+1

00006F8E:       DI
00006F8F:       CALL 6FD1h			; set 25 lines High Resolution mode
00006F92:       EI
00006F93:       LD HL,(E6B0h)		; scroll area
00006F96:       PUSH HL
00006F97:       LD HL,1901h			; 25, 01
00006F9A:       LD (E6B0h),HL		; scroll area
00006F9D:       CALL 5F0Eh			; clear text page (text CLS)
00006FA0:       POP HL
00006FA1:       LD (E6B0h),HL		; scroll area
00006FA4:       CALL 5E49h
00006FA7:       POP HL
00006FA8:       RET

00006FA9:       LD (E6B0h),HL		; scroll area
00006FAC:       LD A,(EF88h)		; HEIGHT (TextHeight)
00006FAF:       LD C,A
00006FB0:       LD A,(EF89h)	; WIDTH
00006FB3:       LD B,A
00006FB4:       LD A,(EF86h)			; CSRY (CursorPos) - current text position
00006FB7:       LD L,A
00006FB8:       LD A,(E6B8h)		; Function key bottom bar enable flag
00006FBB:       ADD C
00006FBC:       CP L
00006FBD:       JR NC,+03h
00006FBF:       LD (EF86h),A			; CSRY (CursorPos) - current text position
00006FC2:       LD HL,(E6B0h)		; scroll area
00006FC5:       CP H
00006FC6:       JR NC,+05h
00006FC8:       LD H,A
00006FC9:       CP L
00006FCA:       JR NC,+01h
00006FCC:       LD L,A
00006FCD:       LD (E6B0h),HL		; scroll area
00006FD0:       RET

; set 25 lines High Resolution
00006FD1:       LD C,01h
00006FD3:       JR NC,+01h
00006FD5:       DEC C
00006FD6:       INA (40h)
00006FD8:       AND 02h		;High Resolution CRT Mode, 0: High rez(24 kHz) - 1: Standard (15 kHz)
00006FDA:       LD B,(HL)
00006FDB:       LD DE,0004h
00006FDE:       JR Z,+02h
00006FE0:       LD E,D
00006FE1:       LD B,D
00006FE2:       INC HL
00006FE3:       LD A,(E6C2h)	; Value being sent to port 31h (bank switching)
00006FE6:       AND DFh			; 11011111: 25 line HR mode switch
00006FE8:       OR B			; 
00006FE9:       LD (E6C2h),A	; Value being sent to port 31h (bank switching)
00006FEC:       OUTA (31h)		; System control port #2
00006FEE:       LD A,(E6C0h)	; Value being sent to port 30h
00006FF1:       AND FCh
00006FF3:       OR C
00006FF4:       LD C,A
00006FF5:       LD A,(E6B9h)				; TextIsColor, Color / monochrome switch
00006FF8:       AND 02h
00006FFA:       XOR 02h				; Carrier control, Mark/Space (2400hz/1200hz)
00006FFC:       OR C
00006FFD:       OUTA (30h)			; System control port
00006FFF:       LD (E6C0h),A		; Value being sent to port 30h
00007002:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
00007005:       OR 08h				; CLDS:  enable CRT I/F synchronization control
00007007:       LD (E6C1h),A		; enable/status FLAGS for port 40h
0000700A:       OUTA (40h)
0000700C:       CALL 433Fh			; WaitVSync
0000700F:       XOR A				; INIT command
00007010:       OUTA (51h)			; Output command to CRTC
00007012:       LD A,A0h
00007014:       OUTA (68h)			; DMA control port
00007016:       PUSH HL
00007017:       LD HL,(E6C4h)		; TVRAMTop
0000701A:       LD A,L
0000701B:       OUTA (64h)			; DMA
0000701D:       LD A,H
0000701E:       OUTA (64h)			; DMA
00007020:       POP HL
00007021:       LD A,(HL)
00007022:       INC HL
00007023:       OUTA (65h)			; DMA
00007025:       LD A,(HL)
00007026:       INC HL
00007027:       OUTA (65h)			; DMA
00007029:       ADD HL,DE
0000702A:       LD B,04h
0000702C:       LD A,(HL)
0000702D:       OUTA (50h)		; Send parameter to CRTC
0000702F:       INC HL
00007030:       DJNZ -06h

00007032:       LD A,(E6B9h)			; TextIsColor, Color / monochrome switch
00007035:       AND 40h
00007037:       OR 13h
00007039:       OUTA (50h)		; Send parameter to CRTC
0000703B:       LD A,43h		;
0000703D:       OUTA (51h)		; Output command to CRTC
0000703F:       LD A,E4h
00007041:       OUTA (68h)			; DMA control port
00007043:       LD A,20h
00007045:       OUTA (51h)		; Output command to CRTC
00007047:       CALL 433Fh			; WaitVSync
0000704A:       INA (40h)			; Vertical retrace signal from CRTC (֐D3301AC)
0000704C:       AND 20h
0000704E:       JR NZ,-06h			; ..wait more
00007050:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
00007053:       AND F7h				; 11110111, set "boot from disk" mode
00007055:       LD (E6C1h),A		; enable/status FLAGS for port 40h
00007058:       OUTA (40h)			; strobe port
0000705A:       RET

0000705B:       NOP
0000705C:       LD E,A
0000705D:       ADC C
0000705E:       ADC 93h
00007060:       LD L,C
00007061:       CP (HL)
00007062:       ADC 93h
00007064:       LD (HL),E
00007065:       JR C,+20h
00007067:       OR A
00007068:       ADC E
00007069:       ADC 98h
0000706B:       LD H,A
0000706C:       SBC CEh
0000706E:       SBC B
0000706F:       LD L,A
00007070:       LD E,B

_CONSOLE:
00007071:       LD A,(E6B2h)		; scroll area ORG
00007074:       DEC A
00007075:       LD E,A
00007076:       LD A,(HL)
00007077:       CP 2Ch		; ','
00007079:       JR Z,+09h
0000707B:       CALL 18A3h			; GETINT
0000707E:       CP 19h
00007080:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
00007083:       LD E,A
00007084:       LD A,(E6B3h)
00007087:       LD D,A
00007088:       PUSH DE
00007089:       DEC HL
0000708A:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000708B:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000708C:       DEFB ','
0000708D:       CP 2Ch		; ','
0000708F:       POP DE
00007090:       JR Z,+10h
00007092:       PUSH DE
00007093:       CALL 18A3h			; GETINT
00007096:       OR A
00007097:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
0000709A:       CP 1Ah
0000709C:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
0000709F:       POP DE
000070A0:       ADD E
000070A1:       LD D,A
000070A2:       INC E
000070A3:       EX DE,HL
000070A4:       LD (E6B2h),HL		; scroll area ORG
000070A7:       EX DE,HL
000070A8:       DEC HL
000070A9:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000070AA:       JR Z,+1Ch
000070AC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000070AD:       DEFB ','
000070AE:       CP 2Ch		; ','
000070B0:       JR Z,+16h
000070B2:       CALL 18A3h			; GETINT
000070B5:       LD A,(E6B8h)		; Function key bottom bar enable flag
000070B8:       LD D,A
000070B9:       LD A,E
000070BA:       CP 01h
000070BC:       CCF
000070BD:       SBC A
000070BE:       LD (E6B8h),A		; Function key bottom bar enable flag
000070C1:       CP D
000070C2:       JR Z,+04h
000070C4:       OR A
000070C5:       CALL Z,4021h		; Clean bottom text row
000070C8:       DEC HL
000070C9:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000070CA:       JR Z,+3Ah
000070CC:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
000070CD:       DEFB ','
000070CE:       CALL 18A3h			; GETINT
000070D1:       CP 01h
000070D3:       CCF
000070D4:       SBC A
000070D5:       PUSH HL
000070D6:       LD HL,E6B9h					; TextIsColor, Color / monochrome switch
000070D9:       CP (HL)
000070DA:       LD (HL),A
000070DB:       POP HL
000070DC:       JR Z,+28h
000070DE:       OR A
000070DF:       JR Z,+12h
000070E1:       PUSH HL
000070E2:       XOR A
000070E3:       LD (E6B4h),A		; AttributeCode
000070E6:       CALL 5F0Eh			; clear text page (text CLS)
000070E9:       DI
000070EA:       CALL 433Fh			; WaitVSync
000070ED:       EI
000070EE:       POP HL
000070EF:       LD A,07h
000070F1:       JR +01h
000070F3:       XOR A
000070F4:       CALL 445Bh
000070F7:       LD (E6B4h),A		; AttributeCode
000070FA:       LD A,(EF88h)		; HEIGHT (TextHeight)
000070FD:       LD C,A
000070FE:       LD A,(EF89h)	; WIDTH
00007101:       LD B,A
00007102:       PUSH BC
00007103:       JP 0072h

00007106:       PUSH HL
00007107:       LD HL,(E6B2h)		; scroll area ORG
0000710A:       CALL 6FA9h
0000710D:       POP HL
0000710E:       XOR A
0000710F:       JP 3F79h
00007112:       CP 28h		; '('
00007114:       JR Z,+05h
00007116:       CP 50h
00007118:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
0000711B:       LD DE,714Ah
0000711E:       PUSH DE
0000711F:       LD B,A
00007120:       LD A,(EF88h)	; HEIGHT (TextHeight)
00007123:       LD C,A
00007124:       PUSH BC
00007125:       DEC HL
00007126:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00007127:       JR Z,+11h
00007129:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000712A:       DEFB ','
0000712B:       CALL 18A3h			; GETINT
0000712E:       POP BC
0000712F:       LD C,A
00007130:       PUSH BC
00007131:       CP 14h
00007133:       JR Z,+05h
00007135:       CP 19h
00007137:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
0000713A:       PUSH HL
0000713B:       LD HL,1901h
0000713E:       LD (E6B2h),HL		; scroll area ORG
00007141:       POP HL
00007142:       DEC HL
00007143:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00007144:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00007147:       JP 6F6Ah			; CRTSET - on stack: columns, rows

0000714A:       LD A,(EF89h)	; WIDTH
0000714D:       RET

_LOCATE:
0000714E:       EX DE,HL
0000714F:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00007152:       DEC H
00007153:       DEC L
00007154:       PUSH HL
00007155:       EX DE,HL
00007156:       CP 2Ch		; ','
00007158:       JR Z,+12h
0000715A:       CALL 18A3h			; GETINT
0000715D:       POP DE
0000715E:       LD D,A
0000715F:       LD A,(EF89h)	; WIDTH
00007162:       DEC A
00007163:       CP D
00007164:       JR NC,+01h
00007166:       LD D,A
00007167:       PUSH DE
00007168:       DEC HL
00007169:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000716A:       JR Z,+24h
0000716C:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000716D:       DEFB ','
0000716E:       CP 2Ch		; ','
00007170:       JR Z,+12h
00007172:       CALL 18A3h			; GETINT
00007175:       POP DE
00007176:       LD E,A
00007177:       LD A,(EF88h)	; HEIGHT (TextHeight)
0000717A:       DEC A
0000717B:       CP E
0000717C:       JR NC,+01h
0000717E:       LD E,A
0000717F:       PUSH DE
00007180:       DEC HL
00007181:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00007182:       JR Z,+0Ch
00007184:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00007185:       DEFB ','
00007186:       CALL 18A3h			; GETINT
00007189:       CP 01h
0000718B:       CCF
0000718C:       SBC A
0000718D:       LD (E6A7h),A	; CursorMode
00007190:       EX HL,(SP)
00007191:       INC H
00007192:       INC L
00007193:       CALL 4494h                ; TXT_LOC
00007196:       POP HL
00007197:       RET

_GET:
00007198:       CP 40h			; '@'
0000719A:       CALL Z,0A0Dh			; _CHRGTB - Pick next char from program
0000719D:       CP 28h		; '('
0000719F:       JP NZ,4B42h
000071A2:       XOR A
000071A3:       JP 6EA2h

__PUT:
000071A6:       CP 40h			; '@'
000071A8:       CALL Z,0A0Dh			; _CHRGTB - Pick next char from program
000071AB:       CP 28h		; '('
000071AD:       JP NZ,4B41h
000071B0:       LD A,80h
000071B2:       JP 6EA2h

_CLS:
000071B5:       LD B,01h		; set default argument to 'CLS 1'
000071B7:       DEC HL
000071B8:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000071B9:       JR Z,+0Bh		; to 71C6h if no arguments

000071BB:       DEC HL
000071BC:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000071BD:       CALL 18A3h			; GETINT
000071C0:       CP 04h
000071C2:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
000071C5:       LD B,A

000071C6:       PUSH HL
000071C7:       LD A,B			; get argument from B
000071C8:       RRCA
000071C9:       PUSH AF
000071CA:       CALL C,5F0Eh	; clear text page (text CLS)
000071CD:       POP AF
000071CE:       RRCA
000071CF:       PUSH AF
000071D0:       CALL C,6EE6h	; clear graphics page 1
000071D3:       POP AF
000071D4:       CALL C,6EEAh	; clear graphics page 2
000071D7:       POP HL
000071D8:       RET

000071D9:       XOR A
000071DA:       CALL 408Ah
000071DD:       LD A,01h
000071DF:       CALL 408Ah
000071E2:       LD HL,F00Dh
000071E5:       CALL 71F2h
000071E8:       LD A,02h
000071EA:       CALL 408Ah
000071ED:       LD A,03h
000071EF:       JP 408Ah
000071F2:       LD D,06h
000071F4:       CALL 71FEh
000071F7:       CALL 7209h
000071FA:       INC HL
000071FB:       DEC D
000071FC:       JR NZ,-07h
000071FE:       LD A,(F011h)
00007201:       RRCA
00007202:       RRCA
00007203:       RRCA
00007204:       RRCA
00007205:       LD (F011h),A
00007208:       RET

00007209:       LD BC,0804h		; B=8, C=4
0000720C:       LD A,(HL)
0000720D:       RRCA
0000720E:       RRCA
0000720F:       RRCA
00007210:       RRCA
00007211:       RRCA
00007212:       OUTA (10h)
00007214:       PUSH AF
00007215:       CALL 408Eh
00007218:       POP AF
00007219:       DJNZ -0Ah
0000721B:       RET

_MOTOR:
0000721C:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000721D:       POP AF	; DEFB TK_EQUAL..  Token for '='
0000721E:       CALL 11D3h			; EVAL - evaluate expression
00007221:       PUSH HL
00007222:       CALL 4047h
00007225:       CALL 725Dh
00007228:       CALL 726Ch
0000722B:       LD (F012h),A
0000722E:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
0000722F:       DEFB '/'
00007230:       CALL 18A3h			; GETINT
00007233:       AND A
00007234:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00007237:       CP 0Dh
00007239:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
0000723C:       LD (F011h),A
0000723F:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00007240:       DEFB '/'
00007241:       CALL 726Ch
00007244:       AND A
00007245:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00007248:       LD (F010h),A
0000724B:       CALL 71D9h
0000724E:       POP HL
0000724F:       RET

00007250:       LD A,(HL)
00007251:       INC HL
00007252:       CP 3Ah		; ':'
00007254:       JP NC,0393h			;  SNERR - entry for '?SN ERROR'
00007257:       SUB 30h
00007259:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
0000725C:       RET

0000725D:       CALL 56CCh					; GSTRCU - Get string pointed by FPREG
00007260:       LD A,(HL)
00007261:       CP 08h
00007263:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00007266:       INC HL
00007267:       LD E,(HL)
00007268:       INC HL
00007269:       LD D,(HL)
0000726A:       EX DE,HL
0000726B:       RET

0000726C:       CALL 7250h
0000726F:       RRCA
00007270:       RRCA
00007271:       RRCA
00007272:       RRCA
00007273:       LD B,A
00007274:       CALL 7250h
00007277:       OR B
00007278:       RET

_WBYTE:
00007279:       PUSH HL
0000727A:       LD C,05h
0000727C:       CP 95h			; TK_ON
0000727E:       JR Z,+15h
00007280:       LD DE,4FF5h		; A=(HL), (HL)=0
00007283:       CP EEh			; TK_OFF
00007285:       JR Z,+18h
00007287:       LD DE,4FFBh		; A=(HL), (HL)|=2..
0000728A:       CP 90h			; TK_STOP
0000728C:       JR Z,+11h
0000728E:       POP HL
0000728F:       CALL 40D0h
00007292:       PUSH HL
00007293:       JR -4Ah

00007295:       POP HL
00007296:       POP DE
00007297:       LD DE,09ABh
0000729A:       PUSH DE
0000729B:       PUSH HL
0000729C:       LD DE,4FE5h
0000729F:       LD HL,72A8h
000072A2:       PUSH HL
000072A3:       PUSH DE
000072A4:       LD A,C
000072A5:       JP 4015h
000072A8:       POP HL
000072A9:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000072AA:       RET

_HELP:
000072AB:       PUSH HL
000072AC:       LD C,06h
000072AE:       JR +03h

; used by _STOP
000072B0:       PUSH HL
000072B1:       LD C,00h

000072B3:       CP 95h			; TK_ON
000072B5:       JR Z,-22h		; to 7295h
000072B7:       LD DE,4FF5h		; A=(HL), (HL)=0
000072BA:       CP EEh			; TK_OFF
000072BC:       JR Z,-1Fh		; to 729Fh
000072BE:       LD DE,4FFBh		; A=(HL), (HL)|=2..
000072C1:       CP 90h			; TK_STOP
000072C3:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
000072C6:       JR -29h

_MAP:
000072C8:       PUSH HL
000072C9:       LD C,04h
000072CB:       JR -1Ah

; Init interrupts
000072CD:       DI
000072CE:       XOR A			; disable all interrupts
000072CF:       OUTA (E6h)		; Interrupt mask
000072D1:       LD A,(E6C0h)	; Value being sent to port 30h
000072D4:       OUTA (30h)		; System control port
000072D6:       LD A,(E6C1h)		; enable/status FLAGS for port 40h
000072D9:       OUTA (40h)			; strobe port
000072DB:       LD A,(E6C2h)	; Value being sent to port 31h (bank switching)
000072DE:       OUTA (31h)		; System control port #2
000072E0:       OUTA (EBh)
000072E2:       CALL 35D9h		; InitQueue - initialize keyboard buffer
000072E5:       CALL 69D1h
000072E8:       CALL 69E1h		; init text mode basing on DIP switches
000072EB:       CALL 36E2h
000072EE:       LD (EF62h),A
000072F1:       OR A
000072F2:       CALL NZ,6F06h
000072F5:       LD A,01h
000072F7:       LD (EF10h),A
000072FA:       LD A,85h
000072FC:       LD (F012h),A
000072FF:       LD HL,7342h
00007302:       LD C,06h
00007304:       LD A,(HL)
00007305:       INC HL
00007306:       OUTA (C1h)	; RS232
00007308:       OUTA (C3h)
0000730A:       DEC C
0000730B:       JP NZ,7304h
0000730E:       LD A,FFh
00007310:       OUTA (C8h)
00007312:       OUTA (CAh)
00007314:       LD A,FFh
00007316:       LD (E6C3h),A	; Value being sent to port E4h
00007319:       LD A,FFh
0000731B:       OUTA (E4h)
0000731D:       IM 2
0000731F:       LD A,FFh
00007321:       NOP
00007322:       NOP
00007323:       NOP
00007324:       CALL 6EB6h
00007327:       LD A,01h
00007329:       LD (EF5Dh),A
0000732C:       LD A,02h		; enable VRTC interrupt only
0000732E:       LD (EF0Eh),A	; value being sent to port E6h
00007331:       OUTA (E6h)		; Interrupt mask
00007333:       EI
00007334:       CALL 38E9h
00007337:       XOR A
00007338:       LD (EF5Dh),A
0000733B:       CALL 38E9h
0000733E:       CALL ED87h
00007341:       RET


00007342:       NOP
00007343:       NOP
00007344:       NOP
00007345:       LD B,B
00007346:       LD C,(HL)
00007347:       DJNZ +3Eh
00007349:       RST 38h


0000734A:       LD (E69Fh),A
0000734D:       LD (E6A0h),A
00007350:       LD (EF71h),A
00007353:       LD (E6A2h),A
00007356:       INC A
00007357:       LD (E6A1h),A
0000735A:       LD (EF75h),A
0000735D:       LD (E6B6h),A			; PrintCtrlCode
00007360:       LD (E6CDh),A
00007363:       LD (E6A5h),A
00007366:       RET

_TERM:
00007367:       CALL 468Ch			; FILE_PARMS:
0000736A:       JR NZ,+02h
0000736C:       LD D,FEh
0000736E:       LD E,04h
00007370:       LD A,D
00007371:       CP FFh
00007373:       JP NC,4DA0h			; 'Bad file name' error
00007376:       CP FCh
00007378:       JP C,4DA0h			; 'Bad file name' error
0000737B:       DEC HL
0000737C:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000737D:       LD A,00h
0000737F:       JR Z,+1Ch
00007381:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00007382:       DEFB ','
00007383:       LD A,(HL)
00007384:       CP 2Ch		; ','
00007386:       LD C,A
00007387:       LD A,00h
00007389:       JR Z,+12h
0000738B:       LD A,C
0000738C:       SUB 46h
0000738E:       JR Z,+08h
00007390:       CP 02h
00007392:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00007395:       LD A,FFh
00007397:       NOP
00007398:       PUSH AF
00007399:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
0000739A:       POP AF
0000739B:       JR +09h
0000739D:       LD A,(EF80h)
000073A0:       AND 20h
000073A2:       JR Z,+02h
000073A4:       LD A,FFh
000073A6:       LD (EF72h),A
000073A9:       LD (EF73h),HL
000073AC:       PUSH DE
000073AD:       CALL 75F4h
000073B0:       LD HL,(EF73h)
000073B3:       POP DE
000073B4:       XOR A
000073B5:       CALL 47F6h		; +1 -> NULOPN
000073B8:       POP BC
000073B9:       CALL 7626h
000073BC:       CALL 7348h
000073BF:       CALL 7705h
000073C2:       LD A,(E6A7h)	; CursorMode
000073C5:       OR A
000073C6:       CALL NZ,4290h		; Cursor on
000073C9:       CALL 7780h
000073CC:       CALL 35A8h
000073CF:       CALL 7570h
000073D2:       JP Z,740Ch
000073D5:       CALL 4B7Bh
000073D8:       CP 1Bh
000073DA:       JP Z,74CAh
000073DD:       NOP
000073DE:       NOP
000073DF:       NOP
000073E0:       NOP
000073E1:       NOP
000073E2:       NOP
000073E3:       NOP
000073E4:       NOP
000073E5:       NOP
000073E6:       NOP
000073E7:       CP 1Ah
000073E9:       JP Z,7583h
000073EC:       CP 05h
000073EE:       JP Z,7403h
000073F1:       CP 7Fh
000073F3:       JR Z,+04h
000073F5:       CP FFh
000073F7:       JR NZ,+02h
000073F9:       LD A,08h
000073FB:       LD BC,740Ch
000073FE:       PUSH BC
000073FF:       PUSH AF
00007400:       JP 59ACh

00007403:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00007406:       CALL 6347h
00007409:       JP 73C2h

0000740C:       LD A,(EF71h)
0000740F:       OR A
00007410:       JP Z,73C2h
00007413:       CALL 35CEh		; CHSNS - Get key from keyboard buffer, don't wait for keypress.
00007416:       LD B,A
00007417:       JP Z,7463h
0000741A:       LD A,(E6CAh)		; INTFLG
0000741D:       CP 03h
0000741F:       JP Z,7496h
00007422:       LD A,(EF72h)
00007425:       OR A
00007426:       LD A,B
00007427:       JR Z,+2Eh
00007429:       CP 1Bh
0000742B:       PUSH AF
0000742C:       JR Z,+03h
0000742E:       LD (E6A1h),A
00007431:       LD HL,0000h
00007434:       LD (EC88h),HL		; PTRFIL
00007437:       CALL 5FC8h			; INLIN - Same as PINLIN,exept if AUTFLO if set.
0000743A:       JP C,7497h
0000743D:       XOR A
0000743E:       LD (E6A1h),A
00007441:       CALL 4735h			; SETFIL
00007444:       POP AF
00007445:       CALL Z,4B54h
00007448:       LD HL,E9B9h
0000744B:       LD A,(HL)
0000744C:       OR A
0000744D:       JR Z,+06h
0000744F:       CALL 4B54h
00007452:       INC HL
00007453:       JR -0Ah

00007455:       LD A,0Dh
00007457:       CALL 7705h
0000745A:       JP Z,73C2h
0000745D:       CALL 4B54h
00007460:       JP 73C2h

00007463:       LD HL,(EC88h)		; PTRFIL
00007466:       LD BC,0004h
00007469:       ADD HL,BC
0000746A:       LD A,(HL)
0000746B:       CP FEh
0000746D:       JP NZ,73C2h
00007470:       LD A,(E6E5h)
00007473:       AND 01h
00007475:       JP Z,73C2h
00007478:       LD A,(E6E5h)
0000747B:       AND 01h
0000747D:       JP Z,7489h
00007480:       LD A,(E6EDh)
00007483:       OR 08h
00007485:       OUTA (21h)		; USART (uPD8251C) Control port
00007487:       JR -11h
00007489:       LD A,(E6EDh)
0000748C:       OUTA (21h)		; USART (uPD8251C) Control port
0000748E:       JP 51EBh

00007491:       CALL 3583h			; INICHR (aka GETCHAR)
00007494:       JR +01h
00007496:       PUSH BC
00007497:       XOR A
00007498:       LD (E6CAh),A		; INTFLG
0000749B:       LD (E6CDh),A
0000749E:       LD (E69Fh),A
000074A1:       LD (E6B6h),A			; PrintCtrlCode
000074A4:       DEC A
000074A5:       LD (E6A2h),A
000074A8:       LD (E6A0h),A
000074AB:       INC A
000074AC:       CALL 481Dh			; CLOSE
000074AF:       LD HL,0000h
000074B2:       LD (EC88h),HL		; PTRFIL
000074B5:       POP BC
000074B6:       CALL 766Bh
000074B9:       LD HL,(EF73h)
000074BC:       JP 0996h			; NEWSTT

000074BF:       LD A,FFh
000074C1:       LD (EF71h),A
000074C4:       JP 73C2h

000074C7:       XOR A
000074C8:       JR -09h
000074CA:       CALL 7563h
000074CD:       CP 40h		; '@'
000074CF:       JP Z,7553h
000074D2:       CP 41h		; 'A'
000074D4:       JP Z,7556h
000074D7:       CP 22h		; '"'
000074D9:       JR Z,+6Dh
000074DB:       CP 23h		; '#'
000074DD:       JR Z,+70h
000074DF:       CP 21h
000074E1:       JR Z,+31h
000074E3:       CP 2Ah
000074E5:       JR Z,+77h
000074E7:       CP 59h
000074E9:       JP Z,7583h
000074EC:       CP 20h		; ' '
000074EE:       JR Z,+1Fh
000074F0:       CP 3Dh
000074F2:       JR Z,+2Eh
000074F4:       CP 54h
000074F6:       JP Z,7403h
000074F9:       LD B,FFh
000074FB:       CP 3Eh		; '>'
000074FD:       JP Z,75AAh
00007500:       INC B
00007501:       CP 2Eh		; '.'
00007503:       JP Z,75AAh
00007506:       INC B
00007507:       CP 3Ch
00007509:       JP Z,75AAh
0000750C:       JP 73C2h
0000750F:       CALL 7348h
00007512:       JR -50h

00007514:       LD B,0Dh
00007516:       LD DE,E65Ch		; "NEC00000001", $0D, $0A
00007519:       LD A,(DE)
0000751A:       INC DE
0000751B:       CALL 4B54h
0000751E:       DJNZ -07h
00007520:       JR -5Eh
00007522:       CALL 7563h
00007525:       PUSH AF
00007526:       CALL 7563h
00007529:       SUB 20h
0000752B:       JR C,-69h
0000752D:       LD HL,EF88h		; HEIGHT (TextHeight)
00007530:       CP (HL)
00007531:       JR NC,-6Fh
00007533:       INC A
00007534:       LD L,A
00007535:       POP AF
00007536:       SUB 20h
00007538:       JR C,-76h
0000753A:       LD H,A
0000753B:       LD A,(EF89h)	; WIDTH
0000753E:       INC H
0000753F:       CP H
00007540:       JR C,-7Eh
00007542:       CALL 4494h                ; TXT_LOC
00007545:       JP 74C4h

00007548:       XOR A
00007549:       LD (E6CDh),A
0000754C:       JP 74C4h
0000754F:       LD A,FFh
00007551:       JR -0Ah
00007553:       XOR A
00007554:       JR +02h
00007556:       LD A,FFh
00007558:       LD (E6A2h),A
0000755B:       JP 74C4h
0000755E:       LD A,0Ch
00007560:       JP 73FBh
00007563:       PUSH HL
00007564:       PUSH BC
00007565:       CALL 7570h
00007568:       JR Z,-05h
0000756A:       CALL 4B7Bh
0000756D:       POP BC
0000756E:       POP HL
0000756F:       RET

00007570:       LD A,(E6CAh)		; INTFLG
00007573:       CP 03h
00007575:       JP Z,7491h
00007578:       LD HL,(EC88h)		; PTRFIL
0000757B:       LD A,01h
0000757D:       CALL 4655h
00007580:       LD A,H
00007581:       OR L
00007582:       RET

00007583:       LD HL,(EF86h)			; CSRY (CursorPos) - current text position
00007586:       PUSH HL
00007587:       CALL 6347h
0000758A:       LD A,(E6B0h)		; scroll area
0000758D:       PUSH AF
0000758E:       LD A,(EF86h)			; CSRY (CursorPos) - current text position
00007591:       INC A
00007592:       LD (E6B0h),A		; scroll area
00007595:       DEC A
00007596:       LD HL,E6B1h			; scroll area end
00007599:       CP (HL)
0000759A:       LD A,0Ch
0000759C:       CALL C,73FFh
0000759F:       POP AF
000075A0:       LD (E6B0h),A		; scroll area
000075A3:       POP HL
000075A4:       LD (EF86h),HL			; CSRY (CursorPos) - current text position
000075A7:       JP 74C4h

000075AA:       LD A,B
000075AB:       LD (E6A0h),A
000075AE:       LD B,FEh
000075B0:       LD HL,E9B9h
000075B3:       CALL 7563h
000075B6:       LD (HL),A
000075B7:       CP 0Dh
000075B9:       JR Z,+03h
000075BB:       INC HL
000075BC:       DJNZ -0Bh
000075BE:       XOR A
000075BF:       LD (HL),A
000075C0:       LD HL,0000h
000075C3:       LD (EC88h),HL		; PTRFIL
000075C6:       LD HL,E9B9h
000075C9:       CALL 0632h
000075CC:       CALL 428Bh			; Cursor off
000075CF:       LD A,01h
000075D1:       LD (ECA3h),A		; NLONLY
000075D4:       NOP
000075D5:       JP 4C70h

000075D8:       POP AF
000075D9:       POP AF
000075DA:       LD A,FFh
000075DC:       LD (E6A0h),A
000075DF:       INC A
000075E0:       LD (E69Fh),A
000075E3:       LD (ECA3h),A		; NLONLY
000075E6:       LD (E6CDh),A
000075E9:       CALL 4735h			; SETFIL
000075EC:       LD A,FFh
000075EE:       LD (E69Fh),A
000075F1:       JP 74C4h

000075F4:       CALL EDFCh
000075F7:       LD HL,0400h
000075FA:       LD (F0ACh),HL
000075FD:       LD HL,(EF73h)
00007600:       DEC HL
00007601:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00007602:       JR Z,+0Dh
00007604:       RST 08h				; SYNCHR - Check syntax, 1 byte follows to be compared
00007605:       DEFB ','
00007606:       CALL 1896h				; POSINT - Get positive integer
00007609:       EX DE,HL
0000760A:       LD (F0ACh),HL
0000760D:       EX DE,HL
0000760E:       LD (EF73h),HL
00007611:       LD HL,(EB1Fh)	; ARREND - End of arrays
00007614:       EX DE,HL
00007615:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
00007618:       OR A
00007619:       SBC HL,DE
0000761B:       DEC HL
0000761C:       DEC HL
0000761D:       LD DE,(F0ACh)
00007621:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00007622:       JP C,0B06h			; FCERR, Err $05 - "Illegal function call"
00007625:       RET

00007626:       LD HL,(EAF1h)			; FRETOP - Starting address of unused area of string area
00007629:       LD (EF76h),HL
0000762C:       DEC HL
0000762D:       LD (EF78h),HL
00007630:       EX DE,HL
00007631:       LD HL,(EB1Fh)	; ARREND - End of arrays
00007634:       PUSH DE
00007635:       LD DE,(F0ACh)
00007639:       ADD HL,DE
0000763A:       POP DE
0000763B:       EX DE,HL
0000763C:       LD BC,FFB0h
0000763F:       ADD HL,BC
00007640:       RST 20h			; CPDEHL - compare DE and HL (aka DCOMPR)
00007641:       JP NC,763Fh
00007644:       LD BC,0050h
00007647:       ADD HL,BC
00007648:       XOR A
00007649:       LD (EF7Eh),A
0000764C:       EX DE,HL
0000764D:       LD HL,(EF78h)
00007650:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00007651:       JR Z,+05h
00007653:       LD A,01h
00007655:       LD (EF7Eh),A
00007658:       EX DE,HL
00007659:       LD (EF7Ch),HL
0000765C:       LD (EF7Ah),HL
0000765F:       DEC HL
00007660:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
00007663:       LD A,(EF7Eh)
00007666:       OR A
00007667:       CALL NZ,76E7h
0000766A:       RET

0000766B:       LD HL,(EF76h)
0000766E:       LD (EAF1h),HL
00007671:       RET

00007672:       XOR A
00007673:       JR +01h
00007675:       SCF
00007676:       PUSH AF
00007677:       CALL 76FDh
0000767A:       LD HL,(EF7Ch)
0000767D:       CALL 76D3h
00007680:       LD DE,0050h
00007683:       PUSH DE
00007684:       ADD HL,DE
00007685:       CALL 76D3h
00007688:       PUSH HL
00007689:       LD A,(E6B1h)		; scroll area end
0000768C:       LD L,A
0000768D:       CALL 431Eh		; Find text row address
00007690:       POP HL
00007691:       POP BC
00007692:       POP AF
00007693:       JP C,7697h
00007696:       EX DE,HL
00007697:       LDIR
00007699:       RET

0000769A:       LD HL,(EF7Ch)
0000769D:       CALL 76D3h
000076A0:       PUSH HL
000076A1:       LD DE,0050h
000076A4:       ADD HL,DE
000076A5:       LD (EF7Ch),HL
000076A8:       POP HL
000076A9:       XOR A
000076AA:       JR +10h
000076AC:       LD HL,(EF7Ch)
000076AF:       CALL 76DDh
000076B2:       LD DE,0050h
000076B5:       OR A
000076B6:       SBC HL,DE
000076B8:       LD (EF7Ch),HL
000076BB:       SCF
000076BC:       PUSH AF
000076BD:       CALL 76FDh
000076C0:       PUSH HL
000076C1:       LD A,(E6B0h)		; scroll area
000076C4:       LD L,A
000076C5:       CALL 431Eh		; Find text row address
000076C8:       POP HL
000076C9:       POP AF
000076CA:       JR C,+01h
000076CC:       EX DE,HL
000076CD:       LD BC,0050h
000076D0:       LDIR
000076D2:       RET

000076D3:       LD DE,(EF78h)
000076D7:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000076D8:       RET NZ
000076D9:       LD HL,(EF7Ah)
000076DC:       RET
000076DD:       LD DE,(EF7Ah)
000076E1:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
000076E2:       RET NZ
000076E3:       LD HL,(EF78h)
000076E6:       RET
000076E7:       LD HL,(EF78h)
000076EA:       LD DE,(EF7Ah)
000076EE:       OR A
000076EF:       SBC HL,DE
000076F1:       DEC HL
000076F2:       LD B,H
000076F3:       LD C,L
000076F4:       EX DE,HL
000076F5:       LD (HL),20h
000076F7:       LD D,H
000076F8:       LD E,L
000076F9:       INC DE
000076FA:       LDIR
000076FC:       RET

000076FD:       LD A,(EF7Eh)
00007700:       OR A
00007701:       RET NZ
00007702:       POP AF
00007703:       POP AF
00007704:       RET
00007705:       CP F8h
00007707:       JR NZ,+05h
00007709:       CALL 63F2h
0000770C:       XOR A
0000770D:       RET

0000770E:       CP F9h
00007710:       RET NZ
00007711:       CALL 6405h
00007714:       XOR A
00007715:       RET

00007716:       LD A,(EF7Eh)
00007719:       OR B
0000771A:       RET Z
0000771B:       LD HL,(EF7Ch)
0000771E:       CALL 76D3h
00007721:       CALL 776Ch
00007724:       CALL 777Ah
00007727:       RET Z
00007728:       CALL 7739h
0000772B:       JR Z,-0Ch
0000772D:       CALL 777Ah
00007730:       RET Z
00007731:       CALL 7755h
00007734:       CALL 776Ch
00007737:       JR -0Ch
00007739:       CALL 7747h
0000773C:       PUSH HL
0000773D:       LD A,(HL)
0000773E:       CP 20h		; ' '
00007740:       JR NZ,+03h
00007742:       ADD HL,DE
00007743:       DJNZ -08h
00007745:       POP HL
00007746:       RET

00007747:       LD A,(EF89h)	; WIDTH
0000774A:       LD B,28h
0000774C:       LD DE,0002h
0000774F:       CP B
00007750:       RET Z
00007751:       LD B,50h
00007753:       DEC DE
00007754:       RET

00007755:       CALL 7747h
00007758:       PUSH HL
00007759:       LD A,(HL)
0000775A:       CALL 3ED4h		; LPTOUT
0000775D:       ADD HL,DE
0000775E:       DJNZ -07h
00007760:       LD A,0Dh
00007762:       CALL 3ED4h		; LPTOUT
00007765:       LD A,0Ah
00007767:       CALL 3ED4h		; LPTOUT
0000776A:       POP HL
0000776B:       RET

0000776C:       LD DE,0050h
0000776F:       ADD HL,DE
00007770:       LD DE,(EF78h)
00007774:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00007775:       RET NZ
00007776:       LD HL,(EF7Ah)
00007779:       RET
0000777A:       LD DE,(EF7Ch)
0000777E:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
0000777F:       RET
00007780:       LD A,(E6A5h)
00007783:       OR A
00007784:       RET Z
00007785:       DEC A
00007786:       JR NZ,+0Ch
00007788:       LD A,0Dh
0000778A:       CALL 3ED4h		; LPTOUT
0000778D:       LD A,0Ah
0000778F:       CALL 3ED4h		; LPTOUT
00007792:       JR +03h
00007794:       CALL 7716h
00007797:       XOR A
00007798:       LD (E6A5h),A
0000779B:       RET

0000779C:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
0000779F:       PUSH AF
000077A0:       AND 02h			; Mode at startup 1=terminal mode
000077A2:       JP NZ,77C6h		; jp if BASIC mode
000077A5:       POP AF
000077A6:       RRCA
000077A7:       RET NC
000077A8:       LD HL,0000h

000077AB:       XOR A
000077AC:       CALL 38C4h
000077AF:       PUSH HL
000077B0:       LD A,D3h		; 'OUT n,A'
000077B2:       LD (F0D0h),A
000077B5:       LD HL,E931h		; 'OUT (31h),a' - 'JP (HL)'
000077B8:       LD (F0D1h),HL
000077BB:       POP HL
000077BC:       LD A,(E6C2h)	; Value being sent to port 31h (bank switching)
000077BF:       AND F1h			; 11110001 - mask out GRAPH, MMODE, RMODE
000077C1:       OR 04h			; RMODE (ROM mode) = N-BASIC mode
000077C3:       JP F0D0h		; 'OUT (31h),a' - 'JP (HL)'

000077C6:       POP AF
000077C7:       LD HL,EC8Fh			; FILNAM
000077CA:       LD A,20h
000077CC:       LD B,09h
000077CE:       LD (HL),A
000077CF:       INC HL
000077D0:       DJNZ -04h
000077D2:       CALL 004Ah
000077D5:       CALL 44A4h			; bank switching pivot (write)
000077D8:       LD D,FEh
000077DA:       CALL 736Eh

; _NEW:
000077DD:       JP Z,4F00h		; __NEW

000077E0:       CALL 39E4h		; jump to remote bank. follows address (word) and bank (byte)
				DEFW 64DFh
				DEFB 2			; ..will jump to 6FA9h, bank 2

000077E6:       NOP
000077E7:       NOP
000077E8:       NOP
000077E9:       NOP
000077EA:       NOP
000077EB:       NOP
000077EC:       NOP
000077ED:       NOP
000077EE:       NOP
000077EF:       NOP
000077F0:       NOP

000077F1:       LD HL,7999h
000077F4:       CALL 5550h			; PRS - Print message pointed by HL


; MAIN BASIC entry
000077F7:       LD B,00h
000077F9:       DJNZ -02h
000077FB:       INA (30h)		; Mode select (dip switch state)
000077FD:       CPL
000077FE:       LD L,A
000077FF:       INA (31h)		; mode select DIP switches
00007801:       CPL
00007802:       LD H,A
00007803:       LD (EF7Fh),HL	; DIP switch settings, inverted values read from ports 30h and 31h
00007806:       LD D,H
00007807:       LD E,L
00007808:       NOP
00007809:       NOP
0000780A:       INA (09h)
0000780C:       RRCA			; STOP key 
0000780D:       JR C,+11h

0000780F:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
00007812:       AND 01h			; BASIC mode, 0=N-BASIC. 1=N88-BASIC
00007814:       LD HL,0066h
00007817:       JP NZ,77ABh		; JP if N88-BASIC
0000781A:       CALL 72CDh		; Init interrupts
0000781D:       JP 036Fh

00007820:       LD HL,E5FEh
00007823:       LD SP,HL
00007824:       XOR A
00007825:       CALL 7999h
00007828:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
0000782B:       CALL 77A6h
0000782E:       LD BC,0253h
00007831:       LD HL,00BEh				; Address in Main ROM
00007834:       LD DE,E600h				; DST position on bottom of RAM
00007837:       LD (EACCh),HL			; STREND (aka STRTOP) - string area top address
0000783A:       LDIR
0000783C:       CALL 69B2h				; Prepare jump table at $ECBB and $EE0E
0000783F:       CALL 72CDh				; Init interrupts
00007842:       CALL 458Fh
00007845:       LD HL,(E7E8h)
00007848:       LD D,H
00007849:       LD E,L
0000784A:       LD (E654h),HL		; STKTOP
0000784D:       LD SP,HL
0000784E:       LD HL,E879h		; BUFFER - start of INPUT buffer
00007851:       LD (HL),3Ah
00007853:       INC HL
00007854:       LD (HL),00h
00007856:       CALL 4FA9h
00007859:       XOR A
0000785A:       LD (E652h),A
0000785D:       CALL 5A69h	; OUTDO_CRLF
00007860:       LD (EABBh),A
00007863:       LD (EC30h),A
00007866:       LD (EC2Ah),A
00007869:       LD (E649h),A		; ERRFLG
0000786C:       LD HL,EAD0h			; TEMPST - temporary descriptors
0000786F:       LD (EACEh),HL		; TEMPPT - start of free area of temporary descriptor
00007872:       LD HL,EB3Dh			; PRMSTK - previous block definition on stack
00007875:       LD (EBA5h),HL		; PRMPRV
00007878:       LD HL,(E7E8h)
0000787B:       INC HL
0000787C:       LD A,FDh			; ROM bank
0000787E:       PUSH AF
0000787F:       PUSH HL
00007880:       LD HL,6000h
00007883:       CALL 0142h
00007886:       POP HL
00007887:       POP AF
00007888:       RLCA
00007889:       JR C,-0Dh
0000788B:       JP 7890h
0000788E:       DEC BC
0000788F:       EX DE,HL
00007890:       DEC HL
00007891:       EX DE,HL
00007892:       LD HL,(E7E8h)
00007895:       RST 20h		; CPDEHL - compare DE and HL (aka DCOMPR)
00007896:       EX DE,HL
00007897:       JP C,4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'
0000789A:       DEC HL
0000789B:       LD (EACCh),HL			; STREND (aka STRTOP) - string area top address
0000789E:       DEC HL
0000789F:       PUSH HL
000078A0:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
000078A3:       AND 02h
000078A5:       LD A,(EC7Dh)
000078A8:       JR NZ,+25h
000078AA:       LD HL,7984h			; "How many files(0-15)"
000078AD:       CALL 5550h			; PRS - Print message pointed by HL
000078B0:       CALL 5FC2h
000078B3:       JR C,-15h
000078B5:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
000078B6:       OR A
000078B7:       JR NZ,+06h
000078B9:       LD A,(EC7Dh)
000078BC:       OR A
000078BD:       JR NZ,+10h
000078BF:       LD A,01h
000078C1:       JR Z,+0Ch
000078C3:       CALL 141Eh
000078C6:       LD A,D
000078C7:       OR A
000078C8:       JR NZ,-2Ah
000078CA:       LD A,E
000078CB:       CP 10h
000078CD:       JR NC,-2Fh
000078CF:       LD (EC7Eh),A		; MAXFIL
000078D2:       CALL 3AFEh
000078D5:       PUSH HL
000078D6:       LD (EC7Fh),HL		; FILTAB
000078D9:       LD A,(EC7Eh)		; MAXFIL
000078DC:       INC A
000078DD:       ADD A
000078DE:       LD E,A
000078DF:       LD D,00h
000078E1:       ADD HL,DE
000078E2:       POP DE
000078E3:       EX DE,HL
000078E4:       LD HL,(EC7Fh)		; FILTAB
000078E7:       LD (HL),E
000078E8:       INC HL
000078E9:       LD (HL),D
000078EA:       INC HL
000078EB:       LD A,(EC7Eh)		; MAXFIL
000078EE:       LD BC,0109h		; 265
000078F1:       OR A
000078F2:       JR Z,+0Ah
000078F4:       EX DE,HL
000078F5:       ADD HL,BC
000078F6:       EX DE,HL
000078F7:       LD (HL),E
000078F8:       INC HL
000078F9:       LD (HL),D
000078FA:       INC HL
000078FB:       DEC A
000078FC:       JR NZ,-0Ah
000078FE:       EX DE,HL
000078FF:       ADD HL,BC
00007900:       INC HL
00007901:       PUSH HL
00007902:       DEC A
00007903:       LD (ECA3h),A		; NLONLY
00007906:       LD HL,(EC7Fh)		; FILTAB
00007909:       LD E,(HL)
0000790A:       INC HL
0000790B:       LD D,(HL)
0000790C:       LD HL,0009h
0000790F:       ADD HL,DE
00007910:       LD (EC83h),HL
00007913:       POP HL
00007914:       INC HL
00007915:       LD (EB16h),HL	; PROGND - BASIC program end ptr (aka VARTAB)
00007918:       LD (EB07h),HL			; SAVSTK
0000791B:       POP DE
0000791C:       LD A,E
0000791D:       SUB L
0000791E:       LD L,A
0000791F:       LD A,D
00007920:       SBC H
00007921:       LD H,A
00007922:       JP C,4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'
00007925:       LD B,03h
00007927:       OR A
00007928:       LD A,H
00007929:       RRA
0000792A:       LD H,A
0000792B:       LD A,L
0000792C:       RRA
0000792D:       LD L,A
0000792E:       DJNZ -09h
00007930:       LD A,H
00007931:       CP 02h
00007933:       JR C,+03h
00007935:       LD HL,0200h
00007938:       LD A,E
00007939:       SUB L
0000793A:       LD L,A
0000793B:       LD A,D
0000793C:       SBC H
0000793D:       LD H,A
0000793E:       JP C,4ED6h		; OMERR - handle stack pointer before issuing an 'out of memory error'
00007941:       LD (EACCh),HL			; STREND (aka STRTOP) - string area top address
00007944:       EX DE,HL
00007945:       LD (E654h),HL		; STKTOP
00007948:       LD (EAF1h),HL			; FRETOP - Starting address of unused area of string area
0000794B:       LD SP,HL
0000794C:       LD (EB07h),HL			; SAVSTK
0000794F:       LD HL,(E658h)		; TXTTAB (aka BASTXT) - address of BASIC program start
00007952:       LD HL,0001h
00007955:       LD (E658h),HL		; TXTTAB (aka BASTXT) - address of BASIC program start
00007958:       LD HL,(EB16h)	; PROGND - BASIC program end ptr (aka VARTAB)
0000795B:       EX DE,HL
0000795C:       CALL 4EE4h
0000795F:       OR A
00007960:       SBC HL,DE
00007962:       DEC HL
00007963:       DEC HL
00007964:       LD A,80h
00007966:       OR H
00007967:       LD H,A
00007968:       PUSH HL

00007969:       CALL 3AB4h		; call remote bank. follows address (word) and bank (byte)
0000796C:       LD E,65h
0000796E:       LD (BC),A

0000796F:       POP HL
00007970:       DEC HL
00007971:       DEC HL
00007972:       DEC HL
00007973:       DEC HL
00007974:       CALL 28C2h			; _PRNUM - PRINT number pointed by HL
00007977:       LD HL,79B2h			; " Bytes free"
0000797A:       CALL 5550h			; PRS - Print message pointed by HL
0000797D:       CALL 5A69h	; OUTDO_CRLF
00007980:       JP 4B1Ah	; BASICH

00007983:       NOP

00007984:       DEFM "How many files(0-15)"
00007998:       NOP

00007999:       LD (EC29h),A
0000799C:       LD HL,EF0Ah		; address for "currently selected ROM bank"
0000799F:       LD BC,034Bh		; 843 bytes
000079A2:       LD (HL),00h		; clean them all
000079A4:       INC HL
000079A5:       DEC BC
000079A6:       LD A,B
000079A7:       OR C
000079A8:       JR NZ,-08h


000079AA:       EX DE,HL
000079AB:       LD (EF7Fh),HL	; DIP switch settings, inverted values read from ports 30h and 31h
000079AE:       RET


000079AF:       DEFB 0Ah	; LF
000079B0:       NOP
000079B1:       NOP


000079B2:       DEFM " Bytes free"
000079BD:       NOP

000079BE:       DEFM "NEC N-88 BASIC Version 1.9"
000079D8:		DEFB 0Dh,0Ah
000079DA:		DEFM "Copyright (C) 1981 by Microsoft"
000079F9:		DEFB 0Dh,0Ah
000079FB:       NOP

000079FC:       ADD HL,SP
000079FD:       LD A,E
000079FE:       LD E,C
000079FF:       LD A,E
00007A00:       HALT
00007A01:       LD A,E
00007A02:       AND L
00007A03:       LD A,E
00007A04:       LD B,0Bh
00007A06:       LD B,0Bh
00007A08:       LD B,0Bh
00007A0A:       LD B,0Bh
00007A0C:       DEC H
00007A0D:       LD A,E
00007A0E:       LD B,0Bh
00007A10:       CP (HL)
00007A11:       LD A,E
00007A12:       JP NZ,577Bh
00007A15:       LD A,H
00007A16:       LD B,0Bh
00007A18:       LD B,E
00007A19:       LD A,H
00007A1A:       DEC SP
00007A1B:       LD A,H
00007A1C:       LD L,(HL)
00007A1D:       LD A,H
00007A1E:       HALT
00007A1F:       LD A,H
00007A20:       LD A,(HL)
00007A21:       LD A,H
00007A22:       LD H,EEh
00007A24:       ADC E
00007A25:       LD A,H
00007A26:       SUB (HL)
00007A27:       LD A,H
00007A28:       LD C,EEh
00007A2A:       LD DE,14EEh
00007A2D:       XOR 17h
00007A2F:       XOR 1Ah
00007A31:       XOR 1Dh
00007A33:       XOR 20h
00007A35:       XOR 23h
00007A37:       XOR 26h
00007A39:       XOR 29h
00007A3B:       XOR 2Ch
00007A3D:       XOR C3h
00007A3F:       LD A,L
00007A40:       LD A,(417Eh)
00007A43:       LD A,(HL)
00007A44:       ADD D
00007A45:       LD A,(HL)
00007A46:       ADC D
00007A47:       LD A,(HL)
00007A48:       LD B,0Bh
00007A4A:       LD B,0Bh
00007A4C:       LD B,0Bh
00007A4E:       LD B,0Bh
00007A50:       LD A,E
00007A51:       LD A,(HL)
00007A52:       LD B,0Bh
00007A54:       JP 3A7Dh
00007A57:       LD A,(HL)
00007A58:       LD B,C
00007A59:       LD A,(HL)
00007A5A:       ADD D
00007A5B:       LD A,(HL)
00007A5C:       ADC D
00007A5D:       LD A,(HL)
00007A5E:       LD B,0Bh
00007A60:       LD B,0Bh
00007A62:       LD B,0Bh
00007A64:       LD B,0Bh
00007A66:       LD A,E
00007A67:       LD A,(HL)
00007A68:       LD B,0Bh
00007A6A:       CPL
00007A6B:       XOR 32h
00007A6D:       XOR 35h
00007A6F:       XOR 38h
00007A71:       XOR 3Bh
00007A73:       XOR 3Eh
00007A75:       XOR 41h
00007A77:       XOR 44h
00007A79:       XOR 47h
00007A7B:       XOR 4Ah
00007A7D:       XOR 4Dh
00007A7F:       XOR 50h
00007A81:       XOR 53h
00007A83:       XOR 56h
00007A85:       XOR 59h
00007A87:       XOR 5Ch
00007A89:       XOR 5Fh 		; '_'
00007A8B:       XOR 62h
00007A8D:       XOR 65h
00007A8F:       XOR 68h
00007A91:       XOR 6Bh
00007A93:       XOR 6Eh
00007A95:       XOR A3h
00007A97:       JP NZ,4DA0h			; 'Bad file name' error

00007A9A:       LD (EC88h),HL		; PTRFIL
00007A9D:       LD (HL),E

00007A9E:       LD A,C

; CHPUT
00007A9F:       AND 80h
00007AA1:       JR Z,+02h

00007AA3:       OR (HL)
00007AA4:       LD (HL),A
00007AA5:       LD DE,0007h
00007AA8:       EX DE,HL
00007AA9:       ADD HL,DE
00007AAA:       XOR A
00007AAB:       LD (HL),A
00007AAC:       EX DE,HL
00007AAD:       LD DE,0003h
00007AB0:       ADD HL,DE
00007AB1:       LD (HL),00h
00007AB3:       INC HL
00007AB4:       INC HL
00007AB5:       LD (HL),B
00007AB6:       INC HL
00007AB7:       INC HL
00007AB8:       LD (HL),C
00007AB9:       XOR A
00007ABA:       INC HL
00007ABB:       LD (HL),A
00007ABC:       RET

00007ABD:       POP AF
00007ABE:       POP HL
00007ABF:       RET

00007AC0:       PUSH DE
00007AC1:       DEC HL
00007AC2:       CALL 0A0Dh			; _CHRGTB - Pick next char from program
00007AC5:       LD DE,0000h
00007AC8:       CALL NZ,0B01h
00007ACB:       LD A,D
00007ACC:       CP 02h
00007ACE:       JP NC,0B06h			; FCERR, Err $05 - "Illegal function call"
00007AD1:       OR A
00007AD2:       JR Z,+05h
00007AD4:       LD A,E
00007AD5:       OR A
00007AD6:       JP NZ,0B06h			; FCERR, Err $05 - "Illegal function call"
00007AD9:       LD C,E
00007ADA:       DEC HL
00007ADB:       CALL 0A0Dh			; _CHRGTB - Pick next char from program
00007ADE:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00007AE1:       POP DE
00007AE2:       EX HL,(SP)
00007AE3:       PUSH HL
00007AE4:       EX DE,HL
00007AE5:       JP 4C28h

00007AE8:       PUSH HL
00007AE9:       PUSH DE
00007AEA:       LD DE,0008h
00007AED:       ADD HL,DE
00007AEE:       PUSH AF
00007AEF:       CALL 7B14h
00007AF2:       DEC A
00007AF3:       PUSH HL
00007AF4:       DEC HL
00007AF5:       DEC HL
00007AF6:       DEC HL
00007AF7:       LD E,(HL)
00007AF8:       INC E
00007AF9:       JR Z,+14h
00007AFB:       SUB (HL)
00007AFC:       POP HL
00007AFD:       OR A
00007AFE:       JR NZ,+0Ah
00007B00:       POP AF
00007B01:       PUSH AF
00007B02:       CP 0Dh
00007B04:       LD A,01h
00007B06:       JR Z,-0Bh
00007B08:       LD (HL),A
00007B09:       SCF
00007B0A:       POP DE
00007B0B:       LD A,D
00007B0C:       POP DE
00007B0D:       POP HL
00007B0E:       RET

00007B0F:       POP HL
00007B10:       LD A,01h
00007B12:       JR -17h
00007B14:       SUB 0Dh
00007B16:       RET C
00007B17:       JR Z,+05h
00007B19:       INC (HL)
00007B1A:       CP 13h
00007B1C:       SBC A
00007B1D:       ADD (HL)
00007B1E:       LD (HL),A
00007B1F:       RET

; POPALL
00007B20:       POP AF
00007B21:       POP BC
00007B22:       POP DE
00007B23:       POP HL
00007B24:       RET

00007B25:       LD DE,0008h
00007B28:       ADD HL,DE
00007B29:       LD L,(HL)
00007B2A:       LD H,00h
00007B2C:       JP 21FDh				; INT_RESULT_HL

00007B2F:       PUSH AF
00007B30:       LD A,E
00007B31:       CP 80h
00007B33:       JR NZ,+02h
00007B35:       LD E,02h
00007B37:       POP AF
00007B38:       RET
00007B39:       LD A,(E6EBh)
00007B3C:       OR A
00007B3D:       JP NZ,4DA3h			; 'File already open' error
00007B40:       LD A,(E64Eh)		; LPTPOS2
00007B43:       LD B,A
00007B44:       LD C,00h
00007B46:       LD A,E9h
00007B48:       CALL 7B2Fh
00007B4B:       CALL 7A96h
00007B4E:       CALL 3EF3h
00007B51:       LD A,FFh
00007B53:       LD (E6EBh),A
00007B56:       JP 7ABDh

00007B59:       XOR A
00007B5A:       LD (E6EBh),A
00007B5D:       LD DE,0005h
00007B60:       ADD HL,DE
00007B61:       LD A,(HL)
00007B62:       OR A
00007B63:       JP Z,483Dh			; CLOSE_0
00007B66:       CALL 7B6Ch
00007B69:       JP 483Dh			; CLOSE_0

00007B6C:       LD A,0Dh
00007B6E:       CALL 5935h
00007B71:       LD A,0Ah
00007B73:       JP 5935h

00007B76:       EX DE,HL
00007B77:       POP HL
00007B78:       POP AF
00007B79:       PUSH DE
00007B7A:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00007B7D:       CALL 7AC0h
00007B80:       EX DE,HL
00007B81:       POP HL
00007B82:       EX HL,(SP)
00007B83:       PUSH HL
00007B84:       EX DE,HL
00007B85:       LD A,(HL)
00007B86:       INC HL
00007B87:       EX HL,(SP)
00007B88:       PUSH HL
00007B89:       LD DE,0008h
00007B8C:       ADD HL,DE
00007B8D:       LD E,(HL)
00007B8E:       POP HL
00007B8F:       CALL 7AE8h
00007B92:       EX HL,(SP)
00007B93:       JR NC,+05h
00007B95:       PUSH AF
00007B96:       CALL 7B6Ch
00007B99:       POP AF
00007B9A:       CALL 5935h
00007B9D:       DEC C
00007B9E:       JR NZ,-1Bh
00007BA0:       POP HL
00007BA1:       POP HL
00007BA2:       JP 0F8Bh			; FINPRT - finalize PRINT

00007BA5:       POP AF
00007BA6:       PUSH AF
00007BA7:       PUSH HL
00007BA8:       POP HL
00007BA9:       CALL 7AE8h
00007BAC:       JR NC,+05h
00007BAE:       CALL 7B6Ch
00007BB1:       POP AF
00007BB2:       PUSH AF
00007BB3:       CALL 5935h
00007BB6:       JP 7B20h			; POPALL

00007BB9:       POP AF
00007BBA:       LD (E64Eh),A		; LPTPOS2
00007BBD:       RET

00007BBE:       POP AF
00007BBF:       JP 186Ah

00007BC2:       PUSH DE
00007BC3:       PUSH HL
00007BC4:       LD A,(E6EDh)
00007BC7:       OR A
00007BC8:       JP NZ,4DA3h			; 'File already open' error
00007BCB:       LD A,(E6E8h)
00007BCE:       OR A
00007BCF:       JP NZ,4DA3h			; 'File already open' error
00007BD2:       LD HL,EC8Fh			; FILNAM
00007BD5:       CALL 7CD7h
00007BD8:       JP C,4DA0h			; 'Bad file name' error
00007BDB:       LD A,B
00007BDC:       LD (F00Bh),A
00007BDF:       EX DE,HL
00007BE0:       POP DE
00007BE1:       EX HL,(SP)
00007BE2:       EX DE,HL
00007BE3:       PUSH BC
00007BE4:       PUSH HL
00007BE5:       LD A,(E6ECh)
00007BE8:       LD B,A
00007BE9:       LD C,00h
00007BEB:       LD A,E8h
00007BED:       CALL 7B2Fh
00007BF0:       CALL 7A96h
00007BF3:       POP HL
00007BF4:       PUSH HL
00007BF5:       LD DE,0009h
00007BF8:       ADD HL,DE
00007BF9:       EX DE,HL
00007BFA:       LD B,FFh
00007BFC:       CALL 7D95h
00007BFF:       POP HL
00007C00:       POP BC
00007C01:       POP DE
00007C02:       PUSH BC
00007C03:       LD A,D
00007C04:       RRCA
00007C05:       RRCA
00007C06:       OR 02h
00007C08:       LD D,A
00007C09:       LD A,C
00007C0A:       ADD A
00007C0B:       ADD A
00007C0C:       ADD E
00007C0D:       ADD A
00007C0E:       ADD A
00007C0F:       OR D
00007C10:       LD E,A

00007C11:       EX HL,(SP)
00007C12:       CALL 3C42h
00007C15:       POP HL
00007C16:       LD A,(HL)
00007C17:       CP 02h
00007C19:       LD A,33h
00007C1B:       JR Z,+02h
00007C1D:       OR 04h
00007C1F:       LD D,A
00007C20:       LD B,00h
00007C22:       LD A,E
00007C23:       OUTA (21h)		; USART (uPD8251C) Control port
00007C25:       CALL 7D66h
00007C28:       LD (E6EDh),A
00007C2B:       LD A,(E6C0h)	; Value being sent to port 30h
00007C2E:       AND CFh
00007C30:       OR 20h			; first RS232 port
00007C32:       LD (E6C0h),A	; Value being sent to port 30h
00007C35:       OUTA (30h)		; System control port
00007C37:       EI
00007C38:       JP 7ABDh

00007C3B:       LD A,01h
00007C3D:       CALL 7C9Bh
00007C40:       JP 4B8Ch

00007C43:       POP AF
00007C44:       PUSH AF
00007C45:       CALL 7AE8h
00007C48:       JR NC,+07h
00007C4A:       LD A,0Dh
00007C4C:       CALL 3203h
00007C4F:       POP AF
00007C50:       PUSH AF
00007C51:       CALL 3203h
00007C54:       JP 7B20h			; POPALL


00007C57:       CALL 7DA6h
00007C5A:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00007C5D:       JR C,+06h
00007C5F:       CALL 3C08h
00007C62:       NOP
00007C63:       JR NZ,-0Bh
00007C65:       XOR A
00007C66:       OUTA (21h)		; USART (uPD8251C) Control port
00007C68:       LD (E6EDh),A
00007C6B:       JP 483Dh			; CLOSE_0

00007C6E:       LD A,01h
00007C70:       CALL 4655h
00007C73:       JP 21FDh				; INT_RESULT_HL

00007C76:       LD A,01h
00007C78:       CALL 4667h
00007C7B:       JP 21FDh				; INT_RESULT_HL

00007C7E:       LD A,01h
00007C80:       CALL 4655h
00007C83:       LD A,L
00007C84:       OR H
00007C85:       SUB 01h
00007C87:       SBC A
00007C88:       JP 20B6h					; INT_RESULT_A - Get back from function, result in A (signed)

00007C8B:       PUSH DE
00007C8C:       LD A,01h
00007C8E:       LD E,C
00007C8F:       CALL 464Eh
00007C92:       POP DE
00007C93:       JP 4D77h
00007C96:       POP AF
00007C97:       LD (E6ECh),A
00007C9A:       RET
00007C9B:       PUSH AF
00007C9C:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00007C9F:       JR C,+2Ah
00007CA1:       POP AF
00007CA2:       PUSH AF
00007CA3:       CALL 45F8h		; check keyboard input
00007CA6:       JR Z,-0Ch

00007CA8:       POP BC
00007CA9:       PUSH BC
00007CAA:       PUSH AF
00007CAB:       LD A,B
00007CAC:       CALL 4655h
00007CAF:       DEC H
00007CB0:       JR Z,+17h
00007CB2:       LD A,L
00007CB3:       CP 40h			; '@'
00007CB5:       JR NC,+12h
00007CB7:       CALL EE0Bh
00007CBA:       LD A,(F00Bh)
00007CBD:       CP 13h
00007CBF:       JR NZ,+08h
00007CC1:       LD A,11h
00007CC3:       CALL 3203h
00007CC6:       LD (F00Bh),A
00007CC9:       POP AF
00007CCA:       OR A
00007CCB:       POP BC
00007CCC:       RET
00007CCD:       XOR A
00007CCE:       LD (E6C9h),A
00007CD1:       LD E,17h
00007CD3:       JP 03B3h				; ERROR, code in E

00007CD6:       RET

; parse filename
00007CD7:       LD A,(EF7Fh)	; DIP switch settings, inverted values read from ports 30h and 31h
00007CDA:       AND 10h
00007CDC:       JR Z,+02h
00007CDE:       LD A,0Fh
00007CE0:       LD (F154h),A
00007CE3:       JR Z,+02h
00007CE5:       LD A,FFh
00007CE7:       LD (F153h),A
00007CEA:       LD A,(EF80h)
00007CED:       LD B,A
00007CEE:       AND 03h
00007CF0:       LD C,A
00007CF1:       LD A,B
00007CF2:       LD DE,0302h
00007CF5:       AND 08h
00007CF7:       JR Z,+02h
00007CF9:       LD D,01h
00007CFB:       LD A,B
00007CFC:       AND 04h
00007CFE:       JR Z,+01h
00007D00:       INC E
00007D01:       LD A,B
00007D02:       AND 10h
00007D04:       LD B,A
00007D05:       JR Z,+02h
00007D07:       LD B,FFh
00007D09:       CALL 0044h
00007D0C:       JR Z,+0Fh
00007D0E:       LD C,00h
00007D10:       CP 4Eh
00007D12:       JR Z,+09h
00007D14:       INC C
00007D15:       CP 4Fh
00007D17:       JR Z,+04h
00007D19:       INC C
00007D1A:       INC C
00007D1B:       CP 45h
00007D1D:       INC HL
00007D1E:       CALL 0044h
00007D21:       JR Z,+08h
00007D23:       SUB 35h
00007D25:       RET C
00007D26:       CP 05h
00007D28:       CCF
00007D29:       RET C
00007D2A:       LD E,A
00007D2B:       INC HL
00007D2C:       CALL 0044h
00007D2F:       JR Z,+08h
00007D31:       SUB 30h
00007D33:       RET C
00007D34:       CP 04h
00007D36:       CCF
00007D37:       RET C
00007D38:       LD D,A
00007D39:       INC HL
00007D3A:       CALL 0044h
00007D3D:       JR Z,+0Ch
00007D3F:       LD B,FFh
00007D41:       CP 58h
00007D43:       JR Z,+06h
00007D45:       LD B,00h
00007D47:       CP 4Eh
00007D49:       SCF
00007D4A:       RET NZ
00007D4B:       INC HL
00007D4C:       CALL 0044h
00007D4F:       RET Z
00007D50:       SUB 4Eh
00007D52:       JR Z,+07h
00007D54:       CP 05h
00007D56:       SCF
00007D57:       RET NZ
00007D58:       LD A,0Fh
00007D5A:       OR A
00007D5B:       LD (F154h),A
00007D5E:       JR Z,+02h
00007D60:       LD A,FFh
00007D62:       LD (F153h),A
00007D65:       RET

00007D66:       LD A,D
00007D67:       OUTA (21h)		; USART (uPD8251C) Control port
00007D69:       RET

00007D6A:       LD A,14h
00007D6C:       OUTA (21h)		; USART (uPD8251C) Control port
00007D6E:       RET

00007D6F:       NOP
00007D70:       NOP

; _DATE$
00007D71:       PUSH HL
00007D72:       LD DE,4FE5h
00007D75:       CP 95h			; TK_ON
00007D77:       JR Z,+0Fh
00007D79:       LD DE,4FF5h		; A=(HL), (HL)=0
00007D7C:       CP EEh			; TK_OFF
00007D7E:       JR Z,+08h
00007D80:       LD DE,4FFBh		; A=(HL), (HL)|=2..
00007D83:       CP 90h			; TK_STOP
00007D85:       JP NZ,0393h			;  SNERR - entry for '?SN ERROR'
00007D88:       CALL 7D8Eh
00007D8B:       POP HL
00007D8C:       RST 10h			; CHRGTB - Gets next character (or token) from BASIC text.
00007D8D:       RET

00007D8E:       LD A,01h
00007D90:       CALL 4015h
00007D93:       PUSH DE
00007D94:       RET

; BEL
00007D95:       LD A,01h
00007D97:       DI
00007D98:       CALL 463Dh
00007D9B:       LD A,(EF0Eh)	; value being sent to port E6h
00007D9E:       OR 04h			; enable VRTC interrupt
00007DA0:       LD (EF0Eh),A	; value being sent to port E6h
00007DA3:       OUTA (E6h)		; Interrupt mask
00007DA5:       RET

00007DA6:       PUSH HL
00007DA7:       PUSH DE
00007DA8:       PUSH BC
00007DA9:       LD A,(EF0Eh)	; value being sent to port E6h
00007DAC:       AND FBh			; disable RS232 interrupt
00007DAE:       LD (EF0Eh),A	; value being sent to port E6h
00007DB1:       OUTA (E6h)		; Interrupt mask
00007DB3:       XOR A
00007DB4:       LD (E6EDh),A
00007DB7:       DI
00007DB8:       INC A
00007DB9:       LD B,00h
00007DBB:       CALL 463Dh
00007DBE:       EI
00007DBF:       POP BC
00007DC0:       POP DE
00007DC1:       POP HL
00007DC2:       RET

00007DC3:       LD A,(E6E8h)
00007DC6:       OR A
00007DC7:       JP NZ,4DA3h			; 'File already open' error
00007DCA:       LD A,(E6EDh)
00007DCD:       OR A
00007DCE:       JP NZ,4DA3h			; 'File already open' error
00007DD1:       LD A,D
00007DD2:       LD (F009h),A
00007DD5:       LD D,FBh
00007DD7:       POP AF
00007DD8:       OR A
00007DD9:       PUSH AF
00007DDA:       JR NZ,+1Eh
00007DDC:       POP AF
00007DDD:       POP HL
00007DDE:       LD A,E
00007DDF:       CP 02h
00007DE1:       POP BC
00007DE2:       POP BC
00007DE3:       JP Z,67EFh

00007DE6:       POP AF
00007DE7:       JP C,0393h			;  SNERR - entry for '?SN ERROR'
00007DEA:       JP Z,0393h			;  SNERR - entry for '?SN ERROR'
00007DED:       LD A,(F00Ah)
00007DF0:       OR A
00007DF1:       LD A,00h
00007DF3:       JP NZ,680Fh
00007DF6:       CPL
00007DF7:       JP 680Fh

00007DFA:       LD A,E
00007DFB:       AND FBh
00007DFD:       JR NZ,+02h
00007DFF:       LD E,01h
00007E01:       LD A,C
00007E02:       LD (F005h),A
00007E05:       LD B,FFh
00007E07:       LD A,6Ch
00007E09:       PUSH HL
00007E0A:       CALL 7A96h
00007E0D:       POP HL
00007E0E:       LD A,(HL)
00007E0F:       AND 01h
00007E11:       LD A,FFh
00007E13:       JR Z,+02h
00007E15:       LD A,01h
00007E17:       LD (E6E8h),A
00007E1A:       XOR A
00007E1B:       LD (F008h),A
00007E1E:       INC A
00007E1F:       LD (E6A4h),A
00007E22:       LD A,(F005h)
00007E25:       LD HL,(EC88h)		; PTRFIL
00007E28:       LD DE,0004h
00007E2B:       ADD HL,DE
00007E2C:       LD (HL),FBh
00007E2E:       INC HL
00007E2F:       INC HL
00007E30:       INC HL
00007E31:       LD (HL),A
00007E32:       LD A,FFh
00007E34:       LD (F007h),A		; FRCNEW
00007E37:       JP 7ABDh

00007E3A:       XOR A
00007E3B:       LD (E6E8h),A
00007E3E:       JP 483Dh			; CLOSE_0

00007E41:       LD A,(E6E8h)
00007E44:       LD (E6A9h),A
00007E47:       EX DE,HL
00007E48:       POP HL
00007E49:       POP AF
00007E4A:       LD A,(DE)
00007E4B:       JR NZ,+17h
00007E4D:       AND 01h
00007E4F:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00007E52:       CALL 68EBh
00007E55:       CALL 7AC0h
00007E58:       LD B,C
00007E59:       CALL 7E90h
00007E5C:       LD (HL),A
00007E5D:       INC HL
00007E5E:       DJNZ -07h
00007E60:       POP HL
00007E61:       JP 0F8Bh			; FINPRT - finalize PRINT

00007E64:       AND 02h
00007E66:       JP Z,0B06h			; FCERR, Err $05 - "Illegal function call"
00007E69:       CALL 690Bh          ; CSAVE_HEADER_0
00007E6C:       CALL 7AC0h
00007E6F:       LD B,C
00007E70:       LD A,(HL)
00007E71:       INC HL
00007E72:       CALL 7FD0h          ; CSAVE byte
00007E75:       DJNZ -07h
00007E77:       POP HL
00007E78:       JP 0F8Bh			; FINPRT - finalize PRINT

00007E7B:       LD A,C
00007E7C:       LD (F008h),A
00007E7F:       JP 4D77h

00007E82:       POP AF
00007E83:       PUSH AF
00007E84:       CALL 7FD0h          ; CSAVE byte
00007E87:       JP 7B20h			; POPALL

00007E8A:       CALL 7E90h
00007E8D:       JP 4B8Ch

00007E90:       PUSH HL
00007E91:       LD HL,F008h
00007E94:       LD A,(HL)
00007E95:       LD (HL),00h
00007E97:       POP HL
00007E98:       OR A
00007E99:       RET NZ
00007E9A:       CALL 7F87h		; CASIN (get byte from tape)
00007E9D:       RET C
00007E9E:       CP 1Ah
00007EA0:       JR Z,+02h
00007EA2:       OR A
00007EA3:       RET

00007EA4:       PUSH BC
00007EA5:       LD B,A
00007EA6:       LD A,(F005h)
00007EA9:       OR A
00007EAA:       JP M,7EAFh
00007EAD:       RRCA
00007EAE:       CCF
00007EAF:       LD A,B
00007EB0:       POP BC
00007EB1:       RET NC
00007EB2:       LD A,00h
00007EB4:       LD (E6A4h),A
00007EB7:       LD A,1Ah
00007EB9:       RET

00007EBA:       LD A,(F009h)
00007EBD:       SUB FBh
00007EBF:       CP 01h
00007EC1:       SBC A
00007EC2:       AND 10h
00007EC4:       OR B
00007EC5:       LD B,A
00007EC6:       LD A,(E6C0h)	; Value being sent to port 30h
00007EC9:       AND 0Fh
00007ECB:       OR B
00007ECC:       OR 08h
00007ECE:       JR +5Ah

; TAPION
00007ED0:       LD A,(EF0Eh)	; value being sent to port E6h
00007ED3:       AND 03h			; disable all interrupts
00007ED5:       OUTA (E6h)		; Interrupt mask
00007ED7:       LD (EF0Eh),A	; value being sent to port E6h
00007EDA:       LD B,00h
00007EDC:       CALL 7EBAh
00007EDF:       INA (40h)
00007EE1:       AND 04h			; RS-232C Data Carrier Detect
00007EE3:       JR NZ,+06h
00007EE5:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00007EE8:       JP C,7FEDh
00007EEB:       INA (40h)
00007EED:       AND 04h			; RS-232C Data Carrier Detect
00007EEF:       JR Z,-12h
00007EF1:       DI
00007EF2:       CALL 3C42h
00007EF5:       LD A,4Eh
00007EF7:       OUTA (21h)		; USART (uPD8251C) Control port
00007EF9:       CALL 7D6Ah
00007EFC:       NOP
00007EFD:       LD (E6EDh),A
00007F00:       PUSH DE
; Apparently this entry is reused for console "BEEP"
00007F01:       PUSH BC
00007F02:       XOR A
00007F03:       LD (F153h),A
00007F06:       LD (F154h),A
00007F09:       LD DE,F0D3h
00007F0C:       LD B,7Fh
00007F0E:       CALL 7D95h
00007F11:       POP BC
00007F12:       POP DE
00007F13:       EI
00007F14:       RET

; TAPIOF
00007F15:       CALL 7DA6h
00007F18:       JR +09h         ; to 7F23

; TAPOOF
00007F1A:       LD A,(E6C0h)	; Value being sent to port 30h
00007F1D:       AND 08h         ; Is the tape already stopped?
00007F1F:       RET Z
00007F20:       CALL 7F81h

00007F23:       LD A,(E6C0h)	; Value being sent to port 30h
00007F26:       AND F7h
00007F28:       OR 04h			; cassette Motor off

; MOTOR
00007F2A:       LD (E6C0h),A	; Value being sent to port 30h
00007F2D:       OUTA (30h)		; System control port
00007F2F:       RET


00007F30:       JR Z,+14h
00007F32:       CALL 18A3h			; GETINT
00007F35:       OR A
00007F36:       JR Z,+07h

00007F38:       LD A,(E6C0h)	; Value being sent to port 30h
00007F3B:       OR 08h
00007F3D:       JR -15h

00007F3F:       LD A,(E6C0h)	; Value being sent to port 30h
00007F42:       AND F7h
00007F44:       JR -1Ch

00007F46:       LD A,(E6C0h)	; Value being sent to port 30h
00007F49:       XOR 08h
00007F4B:       JR -23h

; TAPOON
00007F4D:       LD B,04h
00007F4F:       CALL 7EBAh
00007F52:       CALL 3C42h
00007F55:       LD A,CEh
00007F57:       OUTA (21h)		; USART (uPD8251C) Control port
00007F59:       CALL 3CB3h
00007F5C:       NOP
00007F5D:       CALL 7F7Bh
00007F60:       LD A,(E6C0h)	; Value being sent to port 30h
00007F63:       AND FBh
00007F65:       CALL 7F2Ah      ; cassette Motor on
00007F68:       PUSH DE
00007F69:       PUSH HL

00007F6A:       LD E,01h
00007F6C:       LD HL,0000h

00007F6F:       DEC L
00007F70:       JR NZ,-03h

00007F72:       DEC H
00007F73:       JR NZ,-06h

00007F75:       DEC E
00007F76:       JR NZ,-09h

00007F78:       POP HL
00007F79:       POP DE
00007F7A:       RET

00007F7B:       PUSH DE
00007F7C:       PUSH HL
00007F7D:       LD E,06h
00007F7F:       JR -15h

00007F81:       PUSH DE
00007F82:       PUSH HL
00007F83:       LD E,03h
00007F85:       JR -1Bh

00007F87:       PUSH HL
00007F88:       PUSH DE
00007F89:       PUSH BC
00007F8A:       LD A,01h
00007F8C:       CALL 45F8h		; check keyboard input
00007F8F:       JR NZ,+08h
00007F91:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00007F94:       JP C,7FEDh
00007F97:       JR -0Fh
00007F99:       LD B,A
00007F9A:       LD A,(E6BFh)
00007F9D:       OR A
00007F9E:       LD A,B
00007F9F:       POP BC
00007FA0:       POP DE
00007FA1:       POP HL
00007FA2:       RET Z
00007FA3:       XOR A
00007FA4:       LD (E6BFh),A
00007FA7:       LD A,(F006h)
00007FAA:       OR A
00007FAB:       JP Z,7FEDh
00007FAE:       CALL 7EF1h
00007FB1:       LD A,01h
00007FB3:       RET

00007FB4:       PUSH HL
00007FB5:       PUSH DE
00007FB6:       LD HL,(E6C4h)		; TVRAMTop
00007FB9:       LD DE,004Eh
00007FBC:       ADD HL,DE
00007FBD:       LD A,(HL)
00007FBE:       CP 2Ah
00007FC0:       LD (HL),20h
00007FC2:       JR Z,+02h
00007FC4:       LD (HL),2Ah
00007FC6:       POP DE
00007FC7:       POP HL
00007FC8:       RET

00007FC9:       POP AF
00007FCA:       JP 7FD0h          ; CSAVE byte

; CSAVE 2 bytes
00007FCD:       CALL 7FD0h

; CSAVE byte
00007FD0:       PUSH AF
00007FD1:       INA (21h)		; USART (uPD8251C) Control port
00007FD3:       AND 01h
00007FD5:       JR NZ,+08h
00007FD7:       CALL 35C2h		; _BREAKX - Set CY if STOP is pressed
00007FDA:       JR NC,-0Bh
00007FDC:       JP 7FEDh

00007FDF:       POP AF
00007FE0:       OUTA (20h)		; USART (uPD8251C) Data port
00007FE2:       AND A
00007FE3:       RET

00007FE4:       XOR A
00007FE5:       DEC A
00007FE6:       LD (F006h),A
00007FE9:       LD (F007h),A		; FRCNEW
00007FEC:       RET

00007FED:       CALL 7F15h        ; TAPIOF
00007FF0:       EI
00007FF1:       LD A,(F007h)		; FRCNEW
00007FF4:       OR A
00007FF5:       CALL Z,4F01h			; CLRPTR
00007FF8:       LD E,1Bh
00007FFA:       JP 03B3h				; ERROR, code in E

00007FFD:       JR NC,+00h
00007FFF:       NOP
