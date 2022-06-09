;
;                SUPERCODE III
;                 Version 3.5
;
;                     by
;             Freddy Vachha B.Sc.
;                    1985
;
;      Adapted from the Original Supercode
;   written by F.A.Vachha B.Sc. and V.B.Rumsey
;


  ORG 55352


; CLOSE # NET CHANNEL
;
; POKE start address +2/+3, 2-byte equivalent of the  net  channel address X
;
; If PEEK (X+16) > 0 at the time of calling this routine then there is still
; send data in the net channel - this is sent before the channel area is
; deallocated.
SC_152:
  LD IX,0
  RST 8
  DEFB 46
  RET


; GET # NET PACKET
;
; POKE start address +2/+3, 2-byte equivalent of the  net  channel address X
;
; PEEK (X+13) + 256*PEEK (X+14) gives  the  block  number  of  the packet
; requested: this is auto-incremented after each receive.
SC_151:
  LD IX,0
  RST 8
  DEFB 47
  RET


; SEND # NET PACKET
;
; POKE start address +2/+3, 2-byte equivalent of the  net  channel
; POKE start address +5/+6, 2-byte equivalent of X+15
; POKE X+16, number of bytes to be sent
; POKE 23758, 0 for the packet to be a broadcast.
SC_150:
  LD IX,0
  LD A,(0)
  RST 8
  DEFB 48
  RET


; OPEN # NET CHANNEL
;
; POKE 23749, Your station number
; POKE 23766, Other station number
;
; After calling the routine the address of the net channel can  be found by
; entering PRINT PEEK 23728+256*PEEK 23729 .
SC_149:
  RST 8
  DEFB 45
  LD (23728),IX
  RET


; SCREEN$ RETRIEVE
;
; This  routine  retrieves  any  compressed  screen  created  with routine 147.
; To retrieve a screen stored  starting  at  X,  just enter RANDOMIZE X and
; then call this routine.
;
; The pre—call options are:-
;
; POKE start address + 18, Y : POKE start address + 19, Z
;
; where the values of Y and Z are as defined for routine 147.
SC_148:
  LD HL,(23670)
  DEC HL
  LD DE,16383
SC_148_0:
  INC HL
  PUSH HL
  INC DE
  LD HL,22528
  SBC HL,DE
  JR Z,SC_148_3
  LD A,0
  POP HL
  CP (HL)
  JR Z,SC_148_1
  LD A,(HL)
  EX DE,HL
  LD (HL),A
  EX DE,HL
  JR SC_148_0
SC_148_1:
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
SC_148_2:
  EX DE,HL
  LD (HL),0
  EX DE,HL
  DEC BC
  LD A,C
  OR B
  JR Z,SC_148_0
  INC DE
  JR SC_148_2
SC_148_3:
  POP HL
  RET


; SCREEN$ COMPRESS
;
; This routine compresses and stores screens without attributes.
;
; To have a compressed screen stored at X,  enter  RANDOMIZE  X  & then call
; this routine. Afterwards, 23728/9 contains the  2-byte equivalent of the
; length of the compressed screen (enabling  you to compute the memory saving).
;
; Other pre-call options available are to:-
;
; POKE start address + 21, Y : POKE start address + 47, Y
; POKE start address + 22, Z : POKE start address + 48, Z
;
; where to compress/save just the top 1/3 of the screen Y = 254  : Z = 71,
; for the top 2/3 of the screen Y = 252 : Z = 79
; and  for the whole screen but with attributes too, Y = 0 : Z = 91.
;
; Note that there is no loss of screen detail at all. To LOAD back a compressed
; screen from memory use routine 148.
SC_147:
  LD BC,(23670)
  PUSH BC
  DEC BC
  LD HL,23728
  LD (HL),0
  INC HL
  LD (HL),0
  LD HL,16383
SC_147_0:
  INC HL
  PUSH HL
  INC BC
  LD DE,22528
  SBC HL,DE
  JR Z,SC_147_4
  POP HL
  LD A,(HL)
  LD (BC),A
  LD A,0
  CP (HL)
  JR NZ,SC_147_0
SC_147_1:
  LD DE,(23728)
  INC DE
  LD (23728),DE
  INC HL
  PUSH HL
  LD DE,22528
  SBC HL,DE
  JR Z,SC_147_2
  POP HL
  CP (HL)
  JR Z,SC_147_1
  INC BC
  PUSH HL
  PUSH BC
  POP HL
  LD BC,(23728)
  LD (HL),C
  INC HL
  LD (HL),B
  PUSH HL
  POP BC
  POP HL
  LD DE,0
  LD (23728),DE
  DEC HL
  JR SC_147_0
SC_147_2:
  INC BC
  PUSH BC
  POP HL
; This entry point is used by the routine at SC_129.
SC_147_3:
  LD BC,(23728)
  LD (HL),C
  INC HL
  LD (HL),B
  PUSH HL
  POP BC
  INC BC
SC_147_4:
  POP HL
  DEC BC
  PUSH BC
  POP HL
  POP BC
  SBC HL,BC
  LD (23728),HL
  RET


; CREATE CHANNEL
;
; This routine allocates channel area.
;
; POKE 23766, Drive number (1-8)
; POKE 23770, Length of Filename (1-10 characters)
; POKE 23772/3, 2-byte equivalent of  address  of  first  byte  of Filename
;
; To find the address of this Channel Area,  PRINT  PEEK  23670  +256*PEEK
; 23671 .
SC_146:
  RST 8
  DEFB 43
  LD (23670),IX
  RET


; ERASE CHANNEL
;
; This routine deallocates channel area.
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address
SC_145:
  LD IX,0
  RST 8
  DEFB 44
  RET


; SAVE NEXT DATASECTOR
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address X
; POKE X+25, Drive number (1-8)
; POKE X+13, Sector number
;
; Note that it is necessary to first switch  the  drive  motor  on with routine  131.
SC_144:
  LD IX,0
  RST 8
  DEFB 42
  RET


; READ NEXT DATASECTOR
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address X
; POKE X+25, Drive number (1-8)
; POKE X+14 to X+23, CHR$ CODEs of filename with  trailing  CHR$0s to bring the
; length to 10
;
; Note that it is necessary to first switch  the  drive  motor  on with routine 131.
SC_143:
  LD IX,0
  RST 8
  DEFB 41
  RET


; READ RND DATA SECTOR
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address X
; POKE X+25, Drive number (1-8)
; POKE X+13, Sector number
; Note that it is necessary to first switch  the  drive  motor  on with routine 131.
SC_142:
  LD IX,0
  RST 8
  DEFB 40
  RET


; READ RND DATA RECORD
;
; POKE start address +2/+3, 2-byte eguivalent of the channel address X
; POKE X+25, Drive number (1-8)
; POKE X+14 to X+23, CHR$ CODEs of filename with trailing CHR$0s to bring the
; length to 10
;
; POKE X+13, Relative record number
;
; Note that it is necessary to first switch the  drive  motor on with routine 131.
SC_141:
  LD IX,0
  RST 8
  DEFB 39
  RET


; SAVE NEXT DATARECORD
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address X
; POKE X+25, Drive number (1-8)
; POKE X+14 to X+23, CHR$ CODEs of filename with  trailinq  CHR$0s to bring the
; length to 10
;
; X+13 contains the record number which is not incremented.
;
; POKE X+11/X+12, next data byte
;
; Note that it is necessary to first switch  the  drive  motor  on with routine 131.
SC_140:
  LD IX,0
  RST 8
  DEFB 38
  RET


; READ NEXT DATARECORD
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address X
;
; POKE X+25, Drive number (1-8)
;
; POKE X+14 to X+23, CHR$ CODEs of filename with  trailing  CHR$0s to bring the
; length to 10 X+13 contains the record number which is auto-incremented.
;
; Note that it is necessary to first switch the  drive  motor  on  with routine
; 131.
SC_139:
  LD IX,0
  RST 8
  DEFB 37
  RET


; ERASE MDRVE FILE
;
; POKE 23766, Drive number (1-8)
;
; POKE 23770, Length of Filename (1-10 characters)
;
; POKE 23772/3, 2-byte equivalent of  address  of  first  byte  of Filename
SC_138:
  RST 8
  DEFB 36
  RET


; CLOSE # DATA FILE
;
; POKE start address  +2/+3,  2-byte  equivalent  of  the  channel address X
;
; Note that if the data file had  been  opened  for  writing,  the current
; record is written  to  the  first  available  microdrive sector before the
; file is closed.
SC_137:
  LD IX,0
  RST 8
  INC HL
  RET


; OPEN # DATA FILE
;
; POKE 23766, Drive number (1-8)
;
; POKE 23770, Length of filename (1-10 characters)
;
; POKE 23772/3, 2-byte equivalent of  address  of  first  byte  of Filename
;
; To find the address of the  related  Channel  Area,  PRINT  PEEK 23670 +
; 256*PEEK 23671 .
;
; Note that if the file already exists then this routine opens  it for reading:
; if it does not already exist it is created and then opened for writing.
SC_136:
  RST 8
  DEFB 34
  LD (23670),IX
  RET


; IF1 INITIALISE
;
; This routine pages in the extra 58 Interface 1 System  Variables if they have
; not yet been created.
SC_135:
  RST 8
  DEFB 49
  RET


; PRINTER OUTPUT
;
; POKE start address + 1, CHR$ to be sent to Stream 3 attached to Channel p (ZX
; Printer).
;
; If this routine is run on a just reset Spectrum, use routine 135 first.
SC_134:
  LD A,65
  RST 8
  DEFB 31
  RET


; SCREEN$ OUTPUT
;
; POKE start address + 1, CHR$ to be sent to Stream 2 attached  to Channel s
; (Screen$)
;
; If this routine is used on a just reset  Spectrum,  use  routine 135 first.
SC_133:
  LD A,65
  RST 8
  DEFB 28
  RET


; KEYBOARD INPUT
;
; This routine waits for a key to be pressed, then puts its  ASCII CODE into
; 23681.
;
; If this routine is run on a just reset Spectrum, use routine 135 first.
SC_132:
  RST 8
  DEFB 27
  DEFB 32,129,92,201      ; First byte is wrong. This was probably intended to
                          ; be:  LD (23681),A / RET


; SELECT DRIVE
;
; POKE start address + 1, No, (1-8) of drive to be switched on.
;
; If this routine is run on a just reset Spectrum, use routine 135 first.
SC_131:
  LD A,1
  RST 8
  DEFB 33
  RET


; DESELECT DRIVE
;
; This routine switches off all drives.
;
; If this routine is run on a just reset spectrum, use routine 135 first.
SC_130:
  LD A,0
  RST 8
  DEFB 33
  RET


; RECEIVE RS232 BYTE
;
; This routine places the byte received in location 23681.  If timed out, 0 is
; inserted instead.
;
; If this routine is run on a just reset Spectrum, use routine 135 first.
SC_129:
  RST 8
  DEFB 29
  JR NZ,SC_147_3
  LD E,H
  RET


; SEND RS232 BYTE
;
; POKE start address + 1,Byte(followed by 2 stop bits) to be sent.
;
; If this routine is run on a just reset Spectrum, use routine 135 first.
SC_128:
  LD A,0
  RST 8
  DEFB 30
  RET


; SUPER—CATALOGUE
;
; Call the routine with this program:-
;
; 1 CLS #: INPUT "Enter Microdrive";A: POKE 55993,A: CLS  :  PRINT AT 0,0;:
; RANDOMIZE USR 55648: LET NO=PEEK 56072 + 256*PEEK 56073 - 6 : FOR Q=56086 TO
; NO STEP 11: IF PEEK Q<>13 THEN NEXT Q
;
; 2 FOR N=Q+1 TO NO: PRINT CHR$ PEEK N;: NEXT N
;
; Format is Name, Type (B=Bytes, P=Prog), Length in bytes, and then either
; start address (if Type B) or auto  line  number  (if Type P: 65535=> program
; has no auto line number).
SC_125:
  JR SC_125_1
  POP HL
  LD D,H
  LD E,L
  PUSH HL
  LD HL,6668
  ADD HL,DE
  LD A,(HL)
  INC HL
  OR (HL)
  JR NZ,SC_125_0
  LD A,1
SC_125_0:
  AND 15
  LD H,0
  LD L,A
  LD (L55993),HL
SC_125_1:
  LD HL,56074
  LD (L56072),HL
  LD IY,23610
  LD HL,56005
  LD B,52
  CALL SC_125_12
  LD HL,(23635)
  DEC HL
  PUSH HL
  LD BC,11
  CALL 5717
  LD HL,55953
  POP DE
  PUSH DE
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  LD HL,56061
  LD BC,9
  LDIR
  POP HL
  INC HL
  LD BC,(23631)
  OR A
  SBC HL,BC
  LD (23602),HL
  EXX
  PUSH HL
  EXX
  RST 8
  LD SP,3646
  LD (23768),A
  LD HL,(L55993)
  LD (23766),HL
  LD HL,(56070)
  LD (23789),HL
  EI
  RST 8
  LD (2593),A
  IN A,(6)
  DEC BC
  CALL SC_125_12
SC_125_2:
  LD B,15
SC_125_3:
  PUSH BC
  INC HL
  LD A,(HL)
  CP 13
  JR Z,SC_125_7
  DEC HL
  LD B,11
  PUSH HL
  CALL SC_125_12
  EX (SP),HL
  INC HL
  EX DE,HL
  LD HL,23772
  LD (HL),E
  INC HL
  LD (HL),D
  LD HL,(L55993)
  LD (23766),HL
  LD HL,10
  LD (23770),HL
  EI
  RST 8
  DEFB 34
  CALL SC_125_14
  BIT 2,(IX+67)
  JR NZ,SC_125_4
  LD A,68
  CALL SC_125_13
  JR SC_125_6
SC_125_4:
  PUSH IX
  POP DE
  LD HL,82
  ADD HL,DE
  EX DE,HL
  LD A,(DE)
  INC DE
  LD HL,56057
  LD C,A
  LD B,0
  ADD HL,BC
  LD A,(HL)
  CALL SC_125_13
  CALL SC_125_14
  EX DE,HL
  LD A,C
  OR A
  JR NZ,SC_125_5
  INC HL
  INC HL
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  CALL SC_125_8
  LD E,(HL)
  INC HL
  LD D,(HL)
  CALL SC_125_8
  JR SC_125_6
SC_125_5:
  CP 3
  JR NZ,SC_125_6
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  CALL SC_125_8
  LD E,(HL)
  INC HL
  LD D,(HL)
  CALL SC_125_8
SC_125_6:
  RST 8
  DEFB 35
  POP HL
  POP BC
  DJNZ SC_125_3
  JP SC_125_2
SC_125_7:
  POP BC
  DEC HL
  LD B,5
  CALL SC_125_12
  EXX
  POP HL
  EXX
  LD BC,0
  RET
SC_125_8:
  PUSH HL
  PUSH IX
  EX DE,HL
  LD B,5
  LD IX,55995
SC_125_9:
  LD E,(IX+0)
  LD D,(IX+1)
  LD A,255
SC_125_10:
  INC A
  OR A
  SBC HL,DE
  JR NC,SC_125_10
  ADD HL,DE
  OR 48
  CALL SC_125_13
  INC IX
  INC IX
  DJNZ SC_125_9
  CALL SC_125_14
  POP IX
  POP HL
SC_125_11:
  RET
  LD HL,(L56072)
  LD (HL),A
  INC HL
  LD (L56072),HL
  RET
SC_125_12:
  LD A,(HL)
  CALL SC_125_13
  INC HL
  DJNZ SC_125_12
  RET
  PUSH HL
  PUSH DE
  PUSH BC
  CALL 5633
  POP BC
  POP DE
  POP HL
  RET
SC_125_13:
  PUSH AF
  LD A,2
  CALL SC_125_11
  POP AF
  RST 16
  RET
SC_125_14:
  LD A,32
  JR SC_125_13


; Message at 55993
L55993:
  DEFB 1
  DEFB 0
  DEFB 16
  DEFM "'"
  DEFB 232
  DEFB 3
  DEFM "d"
  DEFB 0
  DEFB 10
  DEFB 0
  DEFB 1
  DEFB 0
  DEFB 13
  DEFM "SUPERCATALOGUE ******      "
  DEFB 13
  DEFB 127
  DEFM " F.A.VACHHA BSc 1984"
  DEFB 13
  DEFB 13
  DEFM "PNSB"
  DEFB 196
  DEFB 21
  DEFM "Z("
  DEFB 0
  DEFM "("
  DEFB 0
  DEFB 11
  DEFB 0
  DEFM "X"
  DEFB 28


; Message at 56072
L56072:
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0
  DEFB 0


; TRACE VARI-SPEED
;
; When called, this non-relocatable routine will print continuously on the
; lower left-hand corner of the screen the line and statement number currently
; being executed by BASIC.
;
; POKE 56777, Speed of execution (1=Fast through to 255=Slow)
;
; Slow speeds are useful to make the line + statement number display readable,
; and also allow a fascinating insight into the ROM routines (see the example
; for this interrupt-driven routine).
;
; Trace remains on until you enter RANDOMIZE USR 56814.
SC_120:
  DI
  LD A,222
  LD I,A
  IM 2
  EI
  RET
SC_120_0:
  CALL SC_120_11
  LD A,32
  LD B,8
SC_120_1:
  PUSH AF
  PUSH BC
  CALL SC_120_6
  POP BC
  POP AF
  DJNZ SC_120_1
  LD HL,20672
  LD (56812),HL
  LD HL,(23621)
  LD E,32
  CALL SC_120_2
  LD A,58
  CALL SC_120_6
  LD E,255
  LD HL,(23623)
  LD H,0
SC_120_2:
  LD BC,64536
  CALL SC_120_3
  LD BC,65436
  CALL SC_120_3
  LD BC,SC_122
  CALL SC_120_3
  LD A,L
  CALL SC_120_5
  RET
SC_120_3:
  XOR A
SC_120_4:
  ADD HL,BC
  INC A
  JR C,SC_120_4
  SBC HL,BC
  DEC A
  JR Z,SC_120_9
SC_120_5:
  ADD A,48
SC_120_6:
  PUSH HL
  CP 32
  JR Z,SC_120_7
  LD E,0
SC_120_7:
  PUSH DE
  LD BC,(23606)
  LD H,0
  LD L,A
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,BC
  EX DE,HL
  LD HL,(56812)
  LD B,8
SC_120_8:
  LD A,(DE)
  LD (HL),A
  INC H
  INC DE
  DJNZ SC_120_8
  LD HL,56812
  INC (HL)
  POP DE
  POP HL
  RET
SC_120_9:
  LD A,E
  AND A
  JR NZ,SC_120_10
  JR SC_120_5
SC_120_10:
  RET M
  JP SC_120_6
SC_120_11:
  LD B,0
  LD C,1
SC_120_12:
  DEC C
  RET Z
SC_120_13:
  DEC B
  JP Z,SC_120_12
  JP SC_120_13
  RST 8
  DEFB 221
  JP 56785
  NOP
  NOP
  NOP
  NOP
  NOP
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  RST 56
  DI
  CALL SC_120_0
  POP HL
  POP DE
  POP BC
  POP AF
  EI
  RET
  ADD A,80
  DI
  LD A,3
  LD I,A
  IM 1
  EI
  RET
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP


; Interrupt vector
L56832:
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221,221,221,221,221,221,221
  DEFB 221,221


; PARTIAL CLS
;
; This routine does a CLS to the lower X lines of the upper screen (also refer
; to routines 119 and 122).
;
; POKE start address + 1, X
SC_121:
  LD B,12
  CALL 3652
  RET


; ANTI-COPY PROGRAM
;
; Save all the parts of your program other than the first with the header of
; other programs  (to do this just involves manipulation of your tape recorder
; ).
;
; To make  the  system  work,  call  this routine from within part 1 of your
; program.
;
; Immediately  after call routine 115 which should contain all the relevant
; details about the part to be loaded (both this routine and no:  115  are best
; POKEd into REM statements in part  1).
;
; What  this  routine does is read the irrelevant header (and promptly forgets
; it)  - routine 115 then reads your program part as a headerless file.
;
; If it sounds like hard work, it is - but then it will be harder work for the
; person trying to copy/break in to your program, as a load other than with
; part 1 will cause a crash.
;
; Combine this method with some of the other protection routines scheduled in
; 2.11 of Chapter II,  and you will be using techniques as advanced or more
; advanced than those employed by the largest software houses !
SC_117:
  NOP                     ; Here we should have had LD IX,0
  NOP
  LD DE,25
  LD A,255
  SCF
  CALL 1366
  RET


; HEADERLESS FILES
;
; This routine will load a headerless file from tape to any specified address.
;
; It will eXecute the code once loaded, if that is required.
;
; POKE start address +2/+3, 2-byte equivalent of the number of bytes to be
; loaded
;
; POKE start address +6/+7, 2-byte equivalent of the address to which the first
; byte is to be loaded
;
; POKE start address +15, 195 if the machine code is to be executed on loading.
; If yes, POKE start address +16/+17,  2-byte equivalent of the address from
; which the machine code is  to  be executed, If no, you will be returned to
; BASIC at the end.
;
; Save this routine within the first part of your program (in a REM
; statement,say) and execute it from within the program.
SC_115:
  DI
  LD DE,65264
  LD IX,256
  LD A,255
  SCF
  CALL 1366
  DI
  RET
  NOP
  NOP


; SURE CLOSE #
;
; Due to a shadow ROM bug CLOSE # does not always succeed in closing all
; streams.
;
; This routine, however, does.
;
; Incidentally, to disable LLIST and LPRINT include the statement OPEN #3;"s"
; at the start of your program.
;
; Also, another way of performing OPEN # N (3<N<16) is to use POKE 23754 + 2*N,
; 19 + 2*N
SC_113:
  LD DE,23792
  LD HL,(23631)
  PUSH HL
  AND A
  SBC HL,DE
  POP HL
  CALL NZ,6629
  LD HL,(23631)
  LD DE,20
  ADD HL,DE
  EX DE,HL
  LD HL,(23635)
  DEC HL
  LD A,(DE)
  CP 128
  CALL NZ,6629
  RET


; ADAPT PROGRAM
;
; As was discussed in 2.10 in Chapter II, programs with machine code stored in
; REM statements written before the release of the Interface One probably will
; not work when loaded into a Spectrum with the shadow ROM paged in. This is
; because the  program, and hence the machine code in it, will load to a
; different address due to the extra system variables,channels etc. To correct,
; run this routine before loading  from  cassette.
;
; It resets system variables to pre-paging values, pages out the shadow ROM and
; ensures that programs from cassette load to 23755.
;
; Incidentally, to check whether your Spectrum is an Issue 3/3B version or not,
; PRINT IN 57342.
;
; If the result is 191, it is Issue 3/3B.
;
; If it is 255, the issue is 1 or 2. If it is neither, then Sinclair have
; produced a new issue Spectrum.
;
; To make all programs for Issue X Spectrums work on Issue Y Spectrums, precede
; all IN commands with:
;
; OUT 57342, 191 if X = 1 or 2 and Y = 3 or 3B
;
; OUT 57342, 255 if X = 3 or 3B and Y = 1 or 2
SC_112:
  LD HL,(23631)
  LD DE,41801
  ADD HL,DE
  RET NC
  LD HL,23792
  LD DE,23734
  JP 6629


; FOREIGN ACCENTS
;
; No, this routine does not speak ze French   !
;
; All it does is to provide a set of accented CHR$s for use as UDGs (suitable
; for French,German,Dutch etc).
;
; POKE 23675/6, 2-byte equivalent of start address of routine
SC_102:
  DEFB 16,8,56,4,60,68,60,0
  DEFB 0,112,80,92,68,68,92,64
  DEFB 0,0,60,64,64,60,8,16
  DEFB 40,0,56,4,60,68,60,0
  DEFB 8,16,56,68,120,64,60,0
  DEFB 36,0,60,66,66,126,66,0
  DEFB 16,40,68,68,68,68,56,0
  DEFB 40,0,68,68,68,68,56,0
  DEFB 16,40,48,16,16,16,56,0
  DEFB 16,8,48,16,16,16,56,0
  DEFB 40,0,48,16,16,16,56,0
  DEFB 40,0,56,68,68,68,56,0
  DEFB 36,0,60,66,66,66,60,0
  DEFB 36,0,66,66,66,66,60,0
  DEFB 16,40,56,68,68,68,56,0
  DEFB 32,16,56,68,68,68,56,0
  DEFB 32,16,56,68,120,64,60,0
  DEFB 16,40,56,68,120,64,60,0
  DEFB 16,40,56,4,60,68,60,0
  DEFB 40,0,56,68,120,64,60,0
  DEFB 32,16,68,68,68,68,56,0


; SCIFI CHR$ SET
;
; POKE 23606/23607, 2-byte equivalent of the start address of the set (which
; occupies 96*8=768 bytes) less 256. Since the  current address is 57344, and
; 57344-256=57088=0+256*223, the required POKEs are hence POKE 23606,0:POKE
; 23607,223 .
;
; You will be amazed at the change - POKE 23606,0:POKE 23607,60 to normalise.
SC_079:
  DEFB 0,0,0,0,0,0,0,0
  DEFB 0,16,16,16,16,0,16,0
  DEFB 0,36,36,0,0,0,0,0
  DEFB 0,36,126,36,36,126,36,0
  DEFB 0,8,62,40,62,10,62,8
  DEFB 0,98,100,8,16,38,70,0
  DEFB 0,16,40,16,42,68,58,0
  DEFB 0,8,16,0,0,0,0,0
  DEFB 0,4,8,8,8,8,4,0
  DEFB 0,32,16,16,16,16,32,0
  DEFB 0,0,20,8,62,8,20,0
  DEFB 0,0,8,8,62,8,8,0
  DEFB 0,0,0,0,0,8,8,16
  DEFB 0,0,0,0,62,0,0,0
  DEFB 0,0,0,0,0,24,24,0
  DEFB 0,0,2,4,8,16,32,0
  DEFB 0,0,126,66,70,70,126,0
  DEFB 0,0,24,8,8,28,28,0
  DEFB 0,0,126,6,126,64,126,0
  DEFB 0,0,124,4,126,6,126,0
  DEFB 0,0,96,102,126,6,6,0
  DEFB 0,0,126,64,126,6,126,0
  DEFB 0,0,124,64,126,70,126,0
  DEFB 0,0,126,6,12,24,24,0
  DEFB 0,0,60,36,126,102,126,0
  DEFB 0,0,126,66,126,6,6,0
  DEFB 0,0,24,24,0,24,24,0
  DEFB 0,0,16,0,0,16,16,32
  DEFB 0,0,4,8,16,8,4,0
  DEFB 0,0,0,62,0,62,0,0
  DEFB 0,0,16,8,4,8,16,0
  DEFB 0,60,66,4,8,0,8,0
  DEFB 0,60,2,122,106,82,60,0
  DEFB 0,0,126,70,126,70,70,0
  DEFB 0,0,124,98,124,98,124,0
  DEFB 0,0,126,70,64,70,126,0
  DEFB 0,0,126,70,70,70,126,0
  DEFB 0,0,126,96,126,96,126,0
  DEFB 0,0,126,96,126,96,96,0
  DEFB 0,0,126,64,78,70,126,0
  DEFB 0,0,98,98,126,98,98,0
  DEFB 0,0,24,24,24,24,24,0
  DEFB 0,0,12,12,12,12,60,0
  DEFB 0,0,100,100,126,70,70,0
  DEFB 0,0,96,96,96,96,126,0
  DEFB 0,0,126,86,86,86,86,0
  DEFB 0,0,126,70,70,70,70,0
  DEFB 0,0,126,98,98,98,126,0
  DEFB 0,0,126,98,126,96,96,0
  DEFB 0,0,124,100,100,100,126,0
  DEFB 0,0,126,98,124,70,70,0
  DEFB 0,0,126,96,126,6,126,0
  DEFB 0,0,126,24,24,24,24,0
  DEFB 0,0,98,98,98,98,126,0
  DEFB 0,0,98,98,98,52,24,0
  DEFB 0,0,106,106,106,106,126,0
  DEFB 0,0,98,98,60,70,70,0
  DEFB 0,0,98,98,126,24,24,0
  DEFB 0,0,126,6,24,96,126,0
  DEFB 0,14,8,8,8,8,14,0
  DEFB 0,0,64,32,16,8,4,0
  DEFB 0,112,16,16,16,16,112,0
  DEFB 0,16,56,84,16,16,16,0
  DEFB 0,0,0,0,0,0,0,255
  DEFB 0,28,34,120,32,32,126,0
  DEFB 0,0,60,6,62,70,62,0
  DEFB 0,48,48,62,34,34,62,0
  DEFB 0,0,30,48,48,48,30,0
  DEFB 0,6,6,62,70,70,62,0
  DEFB 0,0,60,70,124,96,62,0
  DEFB 0,14,24,28,24,24,24,0
  DEFB 0,0,62,70,70,62,6,60
  DEFB 0,96,96,124,70,70,70,0
  DEFB 0,24,0,56,24,24,60,0
  DEFB 0,6,0,6,6,6,38,28
  DEFB 0,48,44,56,56,44,38,0
  DEFB 0,24,24,24,24,24,14,0
  DEFB 0,0,108,86,86,86,86,0
  DEFB 0,0,124,70,70,70,70,0
  DEFB 0,0,60,70,70,70,60,0
  DEFB 0,0,124,70,70,124,96,96
  DEFB 0,0,62,70,70,62,6,6
  DEFB 0,0,30,48,48,48,48,0
  DEFB 0,0,60,96,60,6,124,0
  DEFB 0,24,60,24,24,24,14,0
  DEFB 0,0,70,70,70,70,60,0
  DEFB 0,0,70,70,44,44,24,0
  DEFB 0,0,70,86,86,86,44,0
  DEFB 0,0,70,44,24,44,70,0
  DEFB 0,0,70,70,70,62,6,60
  DEFB 0,0,126,12,24,48,126,0
  DEFB 0,14,8,48,8,8,14,0
  DEFB 0,8,8,8,8,8,8,0
  DEFB 0,112,16,12,16,16,112,0
  DEFB 0,20,40,0,0,0,0,0
  DEFB 60,66,153,161,161,153,66,60
  DEFB 0,0,0


; COMPRESS NUMBERS
;
; This routine saves memory by storing all numbers as VAL STR$ (ie 23.7 is
; stored as VAL"23.7") except 0 which is stored as NOT PI.
;
; Storage using VAL STR$ slows the program down but saves a lot of memory - 3
; bytes per number (if the number  has  x  digits,  VAL "number" will occupy
; 1+1+x+1=x+3 bytes,  while  stored  normally it would occupy x+1+5=x+6 bytes).
;
; D 58115 Supercode 3.5 uses this method to maximise space-utilisation.  It
; also  defines  all  commonly occurring numbers (identified with the help of
; routine 73) as numeric variables (see 2.9 in Chapter II) and saves these
; variables with the program - this frees a lot of memory (it is also the
; reason why trying to RUN Supercode 3.5 is  immediately fatal, as would be
; CLEARing it).
;
; Use routines 103/104 to monitor how much space has been saved.
SC_100:
  LD HL,(23635)
SC_100_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  PUSH HL
  LD (23728),DE
  INC HL
SC_100_1:
  INC HL
SC_100_2:
  LD A,(HL)
  CP 14
  JR Z,SC_100_4
  CP 13
  JR Z,SC_100_3
  JR SC_100_1
SC_100_3:
  EX (SP),HL
  LD DE,(23728)
  LD (HL),D
  DEC HL
  LD (HL),E
  POP HL
  INC HL
  JR SC_100_0
SC_100_4:
  INC HL
  CALL 13545
  JR C,SC_100_8
  LD BC,5
  CALL 6632
  PUSH HL
  DEC HL
  LD (HL),34
SC_100_5:
  DEC HL
  LD A,(HL)
  CP 46
  JR Z,SC_100_5
  CP 101
  JR Z,SC_100_5
  CP 69
  JR Z,SC_100_5
  CP 43
  JR Z,SC_100_9
  CP 45
  JR Z,SC_100_9
  CP 48
  JR C,SC_100_6
  CP 58
  JR NC,SC_100_6
  JR SC_100_5
SC_100_6:
  INC HL
  LD BC,2
  CALL 5717
  INC HL
  LD (HL),176
  INC HL
  LD (HL),34
  LD HL,(23728)
SC_100_7:
  DEC HL
  DEC HL
  DEC HL
  LD (23728),HL
  POP HL
  JR SC_100_2
SC_100_8:
  LD BC,5
  CALL 6632
  PUSH HL
  DEC HL
  LD (HL),167
  DEC HL
  LD (HL),195
  LD HL,(23728)
  DEC HL
  DEC HL
  JR SC_100_7
SC_100_9:
  DEC HL
  LD A,(HL)
  CP 69
  JR Z,SC_100_5
  CP 101
  JR Z,SC_100_5
  INC HL
  JR SC_100_6


; CONFUSE LIST
;
; This routine changes all numbers/digits in the program, other than those in
; REM statements or within  string quotes, into a random code to confuse the
; listing.
;
; The  program will work perfectly until and unless a line containing a number
; (made random) is edited, in which case irreversible corruption will occur
; which makes the program unusable.
;
; This routine relies on the Spectrum's way of storing numbers,ie both in
; visible digit form and 'invisible' floating point form. While the digit form
; is what you see, the invisible form is  what is used for all calculations.
;
; This routine alters only the visible form and hence does not affect program
; execution.
;
; However,in any edit all floating point forms are recalculated to make them
; equal to the digit forms.  Hence the routine's effectiveness.
;
; Include  a copyright REM statement as the last statement in a line containing
; many numbers important to your program.  Any  attempt to delete or change
; your copyright message using edit will hence make the program inoperable.
;
; Also see routine 99.
SC_098:
  LD HL,(23672)
  SRL H
  RRC L
  SRL H
  RRC L
  LD (23728),HL
  LD HL,(23635)
SC_098_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  INC HL
  INC HL
SC_098_1:
  INC HL
  LD A,(HL)
SC_098_2:
  CP 14
  JR Z,SC_098_4
  CP 13
  JR Z,SC_098_3
  JR SC_098_1
SC_098_3:
  INC HL
  JR SC_098_0
SC_098_4:
  NOP
SC_098_5:
  DEC HL
  LD A,(HL)
  CP 46
  JR Z,SC_098_5
  CP 101
  JR Z,SC_098_5
  CP 69
  JR Z,SC_098_5
  CP 43
  JR Z,SC_098_11
  CP 45
  JR Z,SC_098_11
  CP 48
  JR C,SC_098_6
  CP 58
  JR NC,SC_098_6
  JR SC_098_5
SC_098_6:
  INC HL
  LD A,(HL)
  CP 14
  JR Z,SC_098_10
  EX DE,HL
  LD HL,(23728)
SC_098_7:
  PUSH HL
  LD BC,49152
  ADD HL,BC
  POP HL
  JR C,SC_098_8
  LD A,(HL)
  CP 48
  JR C,SC_098_9
  CP 58
  JR NC,SC_098_9
  EX DE,HL
  LD (HL),A
  INC DE
  LD (23728),DE
  JR SC_098_6
SC_098_8:
  LD HL,0
  JR SC_098_7
SC_098_9:
  INC HL
  JR SC_098_7
SC_098_10:
  CALL 6326
  JR SC_098_2
SC_098_11:
  DEC HL
  LD A,(HL)
  CP 69
  JR Z,SC_098_5
  CP 101
  JR Z,SC_098_5
  INC HL
  JR SC_098_6


; UNCONFUSE LIST
;
; This routine undoes the effect of 98 CONFUSE LISTING, except in cases of
; lines which have been irreversibly corrupted for  which nothing can be done.
SC_099:
  LD HL,(23635)
SC_099_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  PUSH HL
  LD (23728),DE
  INC HL
SC_099_1:
  INC HL
  LD A,(HL)
SC_099_2:
  CP 14
  JR Z,SC_099_4
  CP 13
  JR Z,SC_099_3
  JR SC_099_1
SC_099_3:
  EX (SP),HL
  LD DE,(23728)
  LD (HL),D
  DEC HL
  LD (HL),E
  POP HL
  INC HL
  JR SC_099_0
SC_099_4:
  PUSH HL
  LD DE,(23653)
  LD B,5
SC_099_5:
  INC HL
  LD A,(HL)
  LD (DE),A
  INC DE
  DJNZ SC_099_5
  LD (23653),DE
  POP HL
  PUSH HL
SC_099_6:
  DEC HL
  LD A,(HL)
  CP 101
  JR Z,SC_099_6
  CP 69
  JR Z,SC_099_6
  CP 46
  JR Z,SC_099_6
  CP 43
  JR Z,SC_099_7
  CP 45
  JR Z,SC_099_7
  CP 48
  JR C,SC_099_9
  CP 58
  JR NC,SC_099_9
  JR SC_099_6
SC_099_7:
  DEC HL
  LD A,(HL)
  CP 69
  JR Z,SC_099_6
  CP 101
  JR Z,SC_099_6
  INC HL
  JR SC_099_9
SC_099_8:
  PUSH HL
  CALL 5823
  POP HL
  CALL 6326
  JR SC_099_2
SC_099_9:
  INC HL
  EX DE,HL
  POP HL
  PUSH DE
  CALL 6621
  PUSH BC
  CALL 6632
  LD HL,(23728)
  POP DE
  AND A
  SBC HL,DE
  LD (23728),HL
  POP HL
  PUSH HL
  CALL 13855
  CALL 11249
  LD HL,(23728)
  ADD HL,BC
  LD (23728),HL
  EX DE,HL
  ADD HL,BC
  EX DE,HL
  POP HL
  PUSH DE
  CALL 5717
  INC HL
  POP DE
SC_099_10:
  LD A,(DE)
  INC DE
  LD (HL),A
  INC HL
  LD A,(HL)
  CP 14
  JR Z,SC_099_8
  JR SC_099_10


; PIXEL BOXLEFT SCROLL
;
; This non-relocatable routine pixel scrolls a user-defined box on the screen.
; The box must, however, be completely within a  third of the screen i.e.
; within the first eight lines on  the  screen, or the middle eight lines, or
; the bottom eight lines.
;
; POKE start address + 108, TAB position  of  the  top  right-hand square of
; the box i.e. the no. of CHR$s from the left-hand  edge of the screen to its
; top right-hand corner.
;
; POKE start address + 109, with 64 if the box to be  scrolled  is located in
; the upper third of the display, 72 for the mid  third and 80 for the lower
; third.
;
; POKE start address + 110, width of the box in pixels (i.e.  8  * number of
; CHR$s ).
;
; POKE start address + 111, length of the box in CHR$s.
;
; To scroll attributes as well, refer to routines 37-40. Call  the attribute
; routine once for every 8 calls of tins routine. Please note that the above 4
; POKEs must be made each time  the  routine is called. An example BASIC
; program to do this would be:
;
; 10 FOR Z=1 TO 225
; 20 POKE 58679,29:POKE 58660,72:POKE 58681,32:POKE 58682,28
; 30 RANDOMIZE USR 58571
; 40 NEXT Z
;
SC_022:
  LD HL,(L58679)
  LD BC,(L58681)
SC_022_0:
  AND A
SC_022_1:
  RL (HL)
  DEC HL
  DEC B
  JP NZ,SC_022_1
  LD HL,(L58679)
  CALL SC_023_2
  LD (L58679),HL
  LD BC,(L58681)
  DEC C
  RET Z
  LD (L58681),BC
  JP SC_022_0


; PIXEL BOXRGHT SCROLL
;
; As for 22 except that the scroll is to the right. The increments to the start
; address are now 71, 72, 73 and  74  and  the  first POKE relates to the top
; left—hand corner of the  box.  Note  the routine is non-relocatable.
SC_023:
  LD HL,(L58679)
  LD BC,(L58681)
SC_023_0:
  AND A
SC_023_1:
  RR (HL)
  INC HL
  DEC B
  JP NZ,SC_023_1
  LD HL,(L58679)
  CALL SC_023_2
  LD (L58679),HL
  LD BC,(L58681)
  DEC C
  RET Z
  LD (L58681),BC
  JP SC_023_0
; This entry point is used by the routine at SC_022.
SC_023_2:
  LD A,H
  AND 7
  CP 7
  JP Z,SC_023_3
  INC H
  RET
SC_023_3:
  LD A,L
  AND 224
  CP 224
  JP Z,SC_023_4
  LD DE,1760
  AND A
  SBC HL,DE
  RET
SC_023_4:
  LD A,H
  CP 87
  RET Z
  LD DE,32
  ADD HL,DE
  RET


; Data block at 58679
L58679:
  DEFB 130,72


; Data block at 58681
L58681:
  DEFB 1,28


; BLOCK MEM COPY
;
; This routine, called by PRINT USR start address, prints out the length of the
; BASIC program (ignoring variables).
;
; Incidentally, the fastest way to distinguish 16K & 48K Spectrums is to PRINT
; PEEK 23735. Its 255 for a 48K Spectrum (or Spectrum Plus) but only 127 for a
; 16K Spectrum.
;
; This routine moves a block of memory from one location to another.
;
; Do not use it to copy BASIC ( use routine 107 for that) or your BASIC program
; will be corrupted.
;
; POKE start address +1/+2, 2-byte equivalent of address of the first byte of
; memory to be moved
;
; POKE start address +4/+5, 2-byte equivalent of no: of bytes to be moved
;
; POKE start address +7/+8, 2-byte equivalent of  the destination address
SC_106:
  LD HL,16392
  LD BC,2560
  LD DE,18432
  LD A,B
  OR C
  RET Z
  AND A
  SBC HL,DE
  RET Z
  ADD HL,DE
  JR C,SC_106_0
  LDIR
  RET
SC_106_0:
  EX DE,HL
  ADD HL,BC
  EX DE,HL
  ADD HL,BC
  DEC DE
  DEC HL
  LDDR
  RET
  NOP


; UPPER-CS PROGRAM
;
; These routines will convert all items  in  the  program  listing (other than
; those within string quotes, and keywords, which always are in upper case)
; into upper case.
;
; Note that case can be changed from within the program itself using POKE
; 23658,8 (to Upper) or 0 (to Lower).
;
; These routines will convert all items  in  the  program  listing (other than
; those within string quotes, and keywords, which always are in upper case)
; into lower case.
;
; Note that case can be changed from within the program itself using POKE
; 23658,8 (to Upper) or 0 (to Lower).
SC_096:
  LD HL,(23635)
SC_096_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  INC HL
  INC HL
  LD C,0
SC_096_1:
  INC HL
  LD A,(HL)
  CALL 6326
  CP 34
  JR NZ,SC_096_2
  DEC C
SC_096_2:
  CP 58
  JR Z,SC_096_3
  CP 203
  JR NZ,SC_096_4
SC_096_3:
  BIT 0,C
  JR Z,SC_096_1
SC_096_4:
  CP 13
  JR Z,SC_096_5
  BIT 0,C
  JR NZ,SC_096_1
  CP 97
  JR C,SC_096_1
  CP 123
  JR NC,SC_096_1
  SUB 32
  LD (HL),A
  JR SC_096_1
SC_096_5:
  INC HL
  JR SC_096_0


; LOWER-CS STR$
;
; This routine will convert all items within string quotes in the program into
; lower case.
;
; You must ensure that program logic has not changed (Different responses to A
; & a as INKEY$/INPUT/INPUT LINE input commands,for example).
SC_095:
  LD HL,(23635)
SC_095_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  INC HL
  INC HL
  LD C,0
SC_095_1:
  INC HL
  LD A,(HL)
  CALL 6326
  CP 34
  JR NZ,SC_095_2
  DEC C
SC_095_2:
  CP 58
  JR Z,SC_095_3
  CP 203
  JR NZ,SC_095_4
SC_095_3:
  BIT 0,C
  JR Z,SC_095_1
SC_095_4:
  CP 13
  JR Z,SC_095_5
  BIT 0,C
  JR Z,SC_095_1
  CP 65
  JR C,SC_095_1
  CP 91
  JR NC,SC_095_1
  ADD A,32
  LD (HL),A
  JR SC_095_1
SC_095_5:
  INC HL
  JR SC_095_0


; UPPER-CS STR$
;
; This routine will convert all items within string quotes in the program into
; upper case.
;
; You must ensure that program logic has not changed (Different responses to A
; & a as INKEY$/INPUT/INPUT LINE input commands,for example).
SC_094:
  LD HL,(23635)
SC_094_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  INC HL
  INC HL
  LD C,0
SC_094_1:
  INC HL
  LD A,(HL)
  CALL 6326
  CP 34
  JR NZ,SC_094_2
  DEC C
SC_094_2:
  CP 58
  JR Z,SC_094_3
  CP 203
  JR NZ,SC_094_4
SC_094_3:
  BIT 0,C
  JR Z,SC_094_1
SC_094_4:
  CP 13
  JR Z,SC_094_5
  BIT 0,C
  JR Z,SC_094_1
  CP 97
  JR C,SC_094_1
  CP 123
  JR NC,SC_094_1
  SUB 32
  LD (HL),A
  JR SC_094_1
SC_094_5:
  INC HL
  JR SC_094_0


; REM FILL
;
; This routine will prompt you to enter  the  line  number of an empty REM
; statement you have already created and the  number  of bytes to be filled
; into it.
;
; A REM statement of the form REM XXXX..... XXX is then created, ideal for
; storing machine code  (upto 9999 bytes) which can be loaded jointly with  a
; BASIC  program.
;
; For an example, refer to 2.10 Method 2>> in Chapter II.  Also refer to
; routine 85.
SC_084:
  CALL 3435
  LD A,2
  CALL 5633
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  PUSH HL
  LD DE,192
  ADD HL,DE
  EX DE,HL
  LD BC,21
  CALL 8252
  POP HL
  PUSH HL
  LD DE,42
  ADD HL,DE
  EX DE,HL
  POP HL
  PUSH HL
  LD BC,116
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  PUSH HL
  LD BC,150
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  JR SC_084_3
  RST 40
  DEFB 160                ; stk-zero
  DEFB 56                 ; end-calc
SC_084_0:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_084_0
SC_084_1:
  CALL 654
  JR NZ,SC_084_1
  LD D,0
  CALL 798
  JR NC,SC_084_1
  CP 13
  JR Z,SC_084_2
  CP 81
  JP Z,7088
  CP 48
  JR C,SC_084_0
  CP 58
  JR NC,SC_084_0
  PUSH AF
  RST 16
  POP AF
  CALL 11554
  RST 40
  DEFB 1                  ; exchange
  DEFB 164                ; stk-ten
  DEFB 4                  ; multiply
  DEFB 15                 ; addition
  DEFB 56                 ; end-calc
  JR SC_084_0
SC_084_2:
  CALL 11682
  LD HL,55536
  ADD HL,BC
  JP C,7839
  LD DE,55536
  SBC HL,DE
  JP Z,7839
  RET
SC_084_3:
  CALL 37053
  CALL 6510
  JP NZ,7839
  INC HL
  INC HL
  LD (23728),HL
  INC HL
  INC HL
  LD A,(HL)
  CP 234
  JP NZ,7839
  EX (SP),HL
  LD DE,213
  ADD HL,DE
  EX DE,HL
  LD BC,20
  CALL 8252
  CALL 37053
  POP HL
  INC HL
  PUSH BC
  CALL 5717
  POP BC
  PUSH BC
  LD D,B
  LD B,C
  INC D
SC_084_4:
  INC HL
  LD (HL),137
  DJNZ SC_084_4
  DEC D
  JP Z,37187
  LD B,0
  JR SC_084_4
  LD HL,(23728)
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  POP BC
  ADD HL,BC
  EX DE,HL
  LD (HL),D
  DEC HL
  LD (HL),E
  JP 7088


; Message at 59095
L59095:
  DEFM "ENLARGE REM"
  DEFB 13
  DEFB 13
  DEFM "LINE NO:"
  DEFB 13
  DEFM "No. OF EXTRA BYTES:"


; PAINT-FILL
;
; Draw a closed convex figure (the simplest example of which is  a circle) on
; the screen. Plot a point within it and POKE start address + 157, attribute
; value to be used for filling  ( ensure that the paper colour matches the
; surrounding  paper  or  there will be odd boundary conditions).
;
; The routine is non—relocatable.
SC_076:
  LD A,(23677)
  LD E,A
  LD A,(23678)
  LD D,A
  LD A,(L59293)
  LD (23695),A
  LD C,E
  LD B,D
  LD B,D
SC_076_0:
  CALL SC_076_4
  LD C,E
  INC B
  LD A,B
  CP 174
  JP NC,SC_076_1
  PUSH BC
  PUSH DE
  CALL 8910
  POP DE
  POP BC
  PUSH BC
  PUSH DE
  CALL 11733
  POP DE
  POP BC
  INC A
  DEC A
  CP 1
  JP NZ,SC_076_0
SC_076_1:
  LD B,D
SC_076_2:
  LD C,E
  CALL SC_076_4
  LD C,E
  DEC B
  LD A,B
  CP 1
  JP C,SC_076_3
  PUSH BC
  PUSH DE
  CALL 8910
  POP DE
  POP BC
  PUSH BC
  PUSH DE
  CALL 11733
  POP DE
  POP BC
  INC A
  DEC A
  CP 1
  JP NZ,SC_076_2
SC_076_3:
  RET
SC_076_4:
  LD C,E
SC_076_5:
  PUSH BC
  PUSH DE
  CALL 8933
  POP DE
  POP BC
  INC C
  LD A,C
  CP 255
  JP NC,SC_076_6
  PUSH BC
  PUSH DE
  CALL 8910
  POP DE
  POP BC
  PUSH BC
  PUSH DE
  CALL 11733
  POP DE
  POP BC
  INC A
  DEC A
  CP 1
  JP NZ,SC_076_5
SC_076_6:
  LD C,E
SC_076_7:
  PUSH BC
  PUSH DE
  CALL 8933
  POP DE
  POP BC
  DEC C
  LD A,C
  CP 1
  JP C,SC_076_8
  PUSH BC
  PUSH DE
  CALL 8910
  POP DE
  POP BC
  PUSH BC
  PUSH DE
  CALL 11733
  POP DE
  POP BC
  INC A
  DEC A
  CP 1
  JP NZ,SC_076_7
SC_076_8:
  RET


; Data block at 59293
L59293:
  DEFB 58


; SUPER-RENUMBER
;
; This routine will renumber all  GOTOs,  GOSUBs,  LISTs,  LLISTs, LIST#s,
; RESTOREs, SAVE...LINEs etc.
;
; A list is displayed of line and statement numbers of all calculated
; (ie,X*10+70) and non-integer (ie,240.6) arguments which need to be manually
; altered by inspection (structured programs will not have any of these and can
; hence be renumbered fully automatically).
;
; If  the argument <> any existing LINE no:,the next valid line no: is used.
;
; POKE start address + 286, interval between lines (default 10)
;
; POKE start address +288/+289, 2-byte equivalent  of  the  number of the first
; new line (default 10)
;
; If the renumbering would result in  line  numbers  greater  than 9999, the
; interval and first line no: are both set to 1.
SC_060:
  CALL 3435
  LD HL,(23675)
  PUSH HL
  LD HL,(23677)
  PUSH HL
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  PUSH HL
  LD BC,272
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD (23675),DE
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD (23677),DE
  JR L59375


; Data block at 59333
L59333:
  DEFW 636
  DEFW 109
  DEFW 580
  DEFW 270
  DEFW 596
  DEFW 289
  DEFW 580
  DEFW 423
  DEFW 596
  DEFW 342
  DEFW 452
  DEFW 448
  DEFW 223
  DEFW 594
  DEFW 199
  DEFW 601
  DEFW 596
  DEFW 234
  DEFW 657
  DEFW 239
  DEFW 65535


; Routine at 59375
;
; Used by the routine at SC_060.
L59375:
  POP HL
  PUSH HL
  LD BC,25
  ADD HL,BC
L59375_0:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD A,D
  CP 255
  JR Z,L59375_1
  EX DE,HL
  POP BC
  PUSH BC
  ADD HL,BC
  EX DE,HL
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL
  ADD HL,BC
  POP BC
  LD (HL),C
  INC HL
  LD (HL),B
  EX DE,HL
  JR L59375_0
L59375_1:
  POP HL
  LD HL,(23635)
  LD A,(HL)
  AND 192
  JP NZ,37650
  LD BC,65535
L59375_2:
  LD A,(HL)
  AND 192
  JR NZ,L59375_3
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  INC BC
  ADD HL,DE
  JR L59375_2
L59375_3:
  CALL 11563
  LD BC,(23675)
  CALL 11563
  CALL 13545
  JR C,L59375_4
  RST 40
  DEFB 4                  ; multiply
  DEFB 56                 ; end-calc
  LD BC,(23677)
  CALL 11563
  CALL 13545
  JR C,L59375_4
  RST 40
  DEFB 15                 ; addition
  DEFB 56                 ; end-calc
  CALL 11682
  LD HL,55536
  ADD HL,BC
  JR NC,L59375_5
L59375_4:
  CALL 5829
  LD HL,1
  LD (23675),HL
  LD (23677),HL
L59375_5:
  AND A
  LD HL,(23677)
  LD DE,(23675)
  SBC HL,DE
  LD (23621),HL
  LD HL,(23635)
  INC HL
  INC HL
  INC HL
  LD (23728),HL
  LD (23645),HL
  LD HL,(23675)
  LD DE,(23621)
  ADD HL,DE
  LD (23621),HL
  XOR A
  LD (23623),A
L59375_6:
  RST 32
  INC (IY+13)
  CP 58
  JR Z,L59375_6
  CP 13
  JP Z,37610
  CP 234
  JP Z,37671
  CP 236
  JR Z,L59375_13
  CP 237
  JR Z,L59375_13
  CP 229
  JR Z,L59375_13
  CP 240
  JR Z,L59375_8
  CP 225
  JR Z,L59375_8
  CP 247
  JR Z,L59375_13
  CP 248
  JR Z,L59375_10
L59375_7:
  JP 37594
  LD A,(BC)
  NOP
  LD A,(BC)
  NOP
L59375_8:
  CALL 119
  CP 35
  JR NZ,L59375_14
L59375_9:
  CALL 6326
  CP 13
  JP Z,37610
  CP 58
  JR Z,L59375_6
  CP 59
  JR Z,L59375_13
  CP 44
  JR Z,L59375_13
  CALL 119
  JR L59375_9
L59375_10:
  CALL 119
  CP 34
  JR Z,L59375_11
  INC HL
  JR L59375_12
L59375_11:
  CALL 119
  CP 34
  JR NZ,L59375_11
L59375_12:
  CALL 119
  CP 202
  JR Z,L59375_13
  JR L59375_7
L59375_13:
  CALL 119
L59375_14:
  LD D,H
  LD E,L
  CP 13
  JP Z,37610
  CP 58
  JR Z,L59375_6
  CP 32
  JR Z,L59375_13
L59375_15:
  CALL 6326
  JR Z,L59375_19
  CP 48
  JR C,L59375_17
  CP 58
  JR NC,L59375_17
L59375_16:
  CALL 119
  CP 32
  JR Z,L59375_16
  JR L59375_15
L59375_17:
  PUSH HL
  LD A,255
  LD (23692),A
L59375_18:
  CALL 654
  LD A,E
  CP 255
  JR NZ,L59375_18
  LD A,2
  CALL 5633
  LD BC,(23621)
  CALL 11563
  CALL 11747
  LD A,58
  RST 16
  LD BC,(23623)
  LD B,0
  CALL 11563
  CALL 11747
  LD A,13
  RST 16
  POP HL
  JP 37594
L59375_19:
  CP 13
  JR Z,L59375_20
  CP 58
  JR Z,L59375_20
  JR L59375_17
L59375_20:
  DEC HL
  DEC HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  DEC HL
  DEC HL
  LD (23645),HL
  PUSH DE
  CALL 37466
  JR L59375_25
  LD HL,(23635)
  LD DE,(23677)
L59375_21:
  LD A,(HL)
  AND 192
  JR NZ,L59375_22
  LD A,(HL)
  CP B
  JR C,L59375_23
  RET NZ
  INC HL
  LD A,(HL)
  CP C
  JR C,L59375_24
  RET
L59375_22:
  LD HL,55536
  ADD HL,DE
  RET NC
  LD DE,9999
  RET
L59375_23:
  INC HL
L59375_24:
  PUSH HL
  LD HL,(23675)
  ADD HL,DE
  EX DE,HL
  POP HL
  PUSH BC
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC
  POP BC
  JR L59375_21
L59375_25:
  POP BC
  PUSH DE
  LD HL,(23645)
  PUSH HL
  PUSH DE
  PUSH BC
  POP DE
  CALL 6629
  LD (23645),HL
  POP BC
  CALL 11563
  LD HL,(23645)
  LD (23643),HL
  LD HL,(23633)
  PUSH HL
  LD A,255
  CALL 5633
  CALL 11747
  POP HL
  CALL 5653
  LD HL,(23643)
  LD (23645),HL
  LD HL,(23728)
  LD B,(HL)
  DEC HL
  LD C,(HL)
  EX DE,HL
  LD HL,(23645)
  ADD HL,BC
  POP BC
  AND A
  SBC HL,BC
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  POP BC
  LD HL,(23645)
  INC HL
  INC HL
  INC HL
  LD (HL),C
  INC HL
  LD (HL),B
  INC HL
  INC HL
  LD (23645),HL
  LD C,0
  LD A,(HL)
  LD D,1
  CALL 6554
  CP 13
  JP NZ,37237
L59375_26:
  INC HL
  LD A,(HL)
  AND 192
  JP Z,37213
  LD HL,(23635)
  LD A,(23675)
  LD DE,(23677)
L59375_27:
  LD (HL),D
  INC HL
  LD (HL),E
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC
  EX DE,HL
  LD B,0
  LD C,A
  ADD HL,BC
  EX DE,HL
  LD A,(HL)
  AND 192
  JR NZ,L59375_28
  LD A,C
  JR L59375_27
L59375_28:
  POP HL
  LD (23677),HL
  POP HL
  LD (23675),HL
  LD HL,0
  LD (23621),HL
  LD A,1
  LD (23623),A
  RST 8
  DEFB 255
  LD HL,(23728)
  LD B,(HL)
  DEC HL
  LD C,(HL)
  ADD HL,BC
  INC HL
  JR L59375_26


; LINE ADDRESS
;
; Move the edit cursor to the desired program line and  then call this routine
; with PRINT USR start  address.  You  will get the address of the first
; character in the line. Refer to the chapter on the Memory in the Spectrum
; manual where line structure is diagrammed and explained in full.
SC_088:
  LD HL,(23625)
  CALL 6510
  INC HL
  INC HL
  INC HL
  INC HL
  LD B,H
  LD C,L
  RET


; PROGRAM LENGTH
SC_104:
  LD DE,(23635)
  LD HL,(23627)
  SBC HL,DE
  LD B,H
  LD C,L
  RET


; BORDER EFFECTS
;
; Produces a colourful and eyecatching border pattern.
;
; POKE start address + 6, duration (from 1 to 127)
;
; POKE start address + 20, colour (from 0 to 7)
;
; POKE start address + 29, line spacing (from 1 to 255)
SC_069:
  LD HL,1343
  PUSH HL
  LD HL,65408
  BIT 7,A
  JR Z,SC_069_0
  LD HL,3224
SC_069_0:
  EX AF,AF'
  INC DE
  DEC IX
  DI
  LD A,2
  LD B,A
SC_069_1:
  DJNZ SC_069_1
  OUT (254),A
  XOR 15
  LD B,10
  DEC L
  JR NZ,SC_069_1
  DEC B
  DEC H
  JR NZ,SC_069_1
  RET
  NOP


; SCREEN$ SEARCH
;
; This routine finds the CHR$ code (UDGs included) at the position last PRINTed
; at. For example, to find what was  printed  at  X,Y use PRINT AT X,Y;:LET
; L=USR start address: L  now  contains  the required value.
SC_053:
  LD HL,(23606)
  INC H
  LD DE,8320
  CALL SC_053_4
  INC D
  LD E,144
  LD HL,L60132
SC_053_0:
  PUSH DE
  LD DE,(23684)
  LD C,2
SC_053_1:
  LD B,4
SC_053_2:
  LD A,(DE)
  CP (HL)
  JR NZ,SC_053_3
  INC D
  DJNZ SC_053_2
  INC HL
  DEC C
  JR NZ,SC_053_1
  POP DE
  LD B,0
  LD C,D
  RET
SC_053_3:
  LD B,0
  ADD HL,BC
  POP DE
  INC D
  LD A,E
  CP D
  JR NZ,SC_053_0
  LD HL,(23675)
  LD E,165
  CALL SC_053_4
  LD BC,0
  RET
SC_053_4:
  LD BC,8
  PUSH DE
  LD DE,(23684)
SC_053_5:
  LD A,(DE)
  INC D
  CP (HL)
  JR NZ,SC_053_6
  INC HL
  DEC C
  JR NZ,SC_053_5
  POP DE
  LD B,0
  LD C,D
  POP DE
  RET
SC_053_6:
  ADD HL,BC
  POP DE
  INC D
  LD A,E
  CP D
  JR NZ,SC_053_4
  RET


; Message at 60132
L60132:
  DEFB 15
  DEFB 0
  DEFB 240
  DEFB 0
  DEFB 255
  DEFB 0
  DEFB 0
  DEFB 15
  DEFB 15
  DEFB 15
  DEFB 240
  DEFB 15
  DEFB 255
  DEFB 15
  DEFB 0
  DEFB 240
  DEFB 15
  DEFB 240
  DEFB 240
  DEFB 240
  DEFB 255
  DEFB 240
  DEFB 0
  DEFB 255
  DEFB 15
  DEFB 255
  DEFB 240
  DEFB 255
  DEFB 255
  DEFB 255


; FLASH SWOP
;
; This routine sets every flashing square on the screen to steady & every
; steady square to flashing.
;
; Contrast with routines 32/33.
SC_074:
  LD HL,22528
  LD C,2
  LD B,194
SC_074_0:
  BIT 7,(HL)
  JR NZ,SC_074_1
  SET 7,(HL)
  JR Z,SC_074_2
SC_074_1:
  RES 7,(HL)
SC_074_2:
  INC HL
  DJNZ SC_074_0
  LD A,C
  CP 0
  RET Z
  DEC C
  LD B,255
  JR SC_074_0
  NOP


; BRIGHT SWOP
;
; As for no: 74, but with BRIGHT. Contrast with routines 34/35.
SC_075:
  LD HL,22528
  LD C,2
  LD B,194
SC_075_0:
  BIT 6,(HL)
  JR NZ,SC_075_1
  SET 6,(HL)
  JR Z,SC_075_2
SC_075_1:
  RES 6,(HL)
SC_075_2:
  INC HL
  DJNZ SC_075_0
  LD A,C
  CP 0
  RET Z
  DEC C
  LD B,255
  JR SC_075_0
  NOP


; VARIABLES LIST
;
; To display all variables (numeric, string, numeric array, string array &
; FOR...NEXT loop control variables) used in your program, enter PRINT; :
; RANDOMIZE USR start address.
;
; Useful with routines 70,86 & 103.
;
; Note that this routine is non-relocatable.
SC_071:
  LD HL,(23627)
SC_071_0:
  LD A,(HL)
  BIT 7,A
  JP Z,SC_071_1
  BIT 6,A
  JP Z,SC_071_2
  BIT 5,A
  JP Z,SC_071_8
  JP SC_071_9
SC_071_1:
  BIT 5,A
  JP Z,SC_071_10
  JP SC_071_3
SC_071_2:
  BIT 5,A
  JP Z,SC_071_7
  JP SC_071_4
SC_071_3:
  AND 31
  LD B,A
  LD A,96
  OR B
  RST 16
  LD DE,6
  ADD HL,DE
  LD A,13
  RST 16
  JP SC_071_0
SC_071_4:
  AND 31
  LD B,A
  LD A,96
  OR B
  RST 16
SC_071_5:
  INC HL
  LD A,(HL)
  BIT 7,A
  JR NZ,SC_071_6
  RST 16
  JR SC_071_5
SC_071_6:
  AND 127
  RST 16
  LD DE,6
  ADD HL,DE
  LD A,13
  RST 16
  JP SC_071_0
SC_071_7:
  AND 31
  CP 0
  RET Z
  LD B,A
  LD A,96
  OR B
  RST 16
  LD A,40
  RST 16
  LD A,41
  RST 16
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  ADD HL,DE
  INC HL
  LD A,13
  RST 16
  JP SC_071_0
SC_071_8:
  AND 31
  LD B,A
  LD A,96
  OR B
  RST 16
  LD A,36
  RST 16
  LD A,40
  RST 16
  LD A,41
  RST 16
  INC HL
  LD E,(HL)
  INC HL
  INC H
  ADD HL,DE
  INC HL
  LD A,13
  RST 16
  JP SC_071_0
SC_071_9:
  AND 31
  LD B,A
  LD A,96
  OR B
  RST 16
  LD A,235
  RST 16
  LD A,243
  RST 16
  LD DE,19
  ADD HL,DE
  LD A,13
  RST 16
  JP SC_071_0
SC_071_10:
  AND 31
  LD B,A
  LD A,96
  OR B
  RST 16
  LD A,36
  RST 16
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  ADD HL,DE
  INC HL
  LD A,13
  RST 16
  JP SC_071_0


; APPEND STATEMENT
;
; It is very painful having to move the cursor to the end of  long program
; lines: this routine does it all for you. Just  move  the edit cursor to the
; desired line as normal,then call the routine.
;
; You will now be in edit mode, but with the cursor at the end of the program
; line, allowing swift appending of statements and editing of statements near
; the end of the line.
;
; To speed up cursor movement with long lines, enter POKE 23561,5: POKE
; 23562,2: POKE 23608,0, POKE 23609,9. D 60407 The longer  the  line, the more
; pronounced is the speed improvement.
SC_081:
  CALL 6037
  LD SP,(23613)
  LD HL,(23625)
  CALL 6510
  CALL 5781
  LD A,D
  OR E
  JP Z,4247
  PUSH HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD HL,10
  ADD HL,BC
  LD B,H
  LD C,L
  CALL 7941
  CALL 4247
  LD A,255
  CALL 5633
  POP HL
  DEC HL
  DEC (IY+15)
  CALL 6229
  INC (IY+15)
  LD HL,(23649)
  DEC HL
  DEC HL
  LD (23643),HL
  LD A,0
  CALL 5633
  LD HL,4788
  PUSH HL
  LD HL,(23613)
  PUSH HL
  LD HL,4223
  PUSH HL
  LD (23613),SP
  JP 3896
  NOP


; REM KILL CONDENSER
;
; Shortens  and  speeds  up  your  program  by  deleting  all  REM statements
; in it.  Use routine 103 to determine the memory—saving.
SC_064:
  LD HL,(23635)
SC_064_0:
  LD A,(HL)
  AND 192
  JP NZ,7088
  LD (23681),A
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD (23645),HL
  LD (23563),HL
  ADD HL,BC
  LD (23728),HL
SC_064_1:
  RST 24
  CP 58
  JR Z,SC_064_4
  CP 14
  JR C,SC_064_4
  CP 234
  JR NZ,SC_064_3
  LD A,(23681)
  CP 1
  JR C,SC_064_5
  DEC HL
  LD (HL),13
  INC HL
  PUSH HL
  LD DE,(23563)
  AND A
  SBC HL,DE
  EX DE,HL
  DEC HL
  LD (HL),D
  DEC HL
  LD (HL),E
  POP HL
SC_064_2:
  EX DE,HL
  LD HL,(23728)
  CALL 6629
  JR SC_064_0
SC_064_3:
  LD C,0
  LD D,1
  LD E,0
  CALL 6552
SC_064_4:
  INC (IY+71)
  INC HL
  LD (23645),HL
  JR NC,SC_064_1
  JR SC_064_0
SC_064_5:
  DEC HL
  DEC HL
  DEC HL
  DEC HL
  JR SC_064_2


; DEC->HEX CONVERTER
;
; These two routines auto-repeat. Enter 'Q'  to return  to  BASIC.
;
; Only integers between 0 and 65535 (HEX 0 to FFFF) are allowed.
SC_062:
  CALL 3435
  LD A,2
  CALL 5633
SC_062_0:
  LD A,68
  RST 16
  LD A,58
  RST 16
  RST 40
  DEFB 160                ; stk-zero
  DEFB 56                 ; end-calc
SC_062_1:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_062_1
SC_062_2:
  CALL 654
  JR NZ,SC_062_2
  LD D,0
  CALL 798
  JR NC,SC_062_2
  CP 13
  JR Z,SC_062_3
  CP 81
  JR Z,SC_062_7
  CP 48
  JR C,SC_062_1
  CP 58
  JR NC,SC_062_1
  PUSH AF
  RST 16
  POP AF
  CALL 11554
  RST 40
  DEFB 1                  ; exchange
  DEFB 164                ; stk-ten
  DEFB 4                  ; multiply
  DEFB 15                 ; addition
  DEFB 56                 ; end-calc
  JR SC_062_1
SC_062_3:
  CALL 11682
  JR C,SC_062_6
  LD A,32
  RST 16
  LD A,61
  RST 16
  LD A,32
  RST 16
  LD (23728),BC
  LD B,4
SC_062_4:
  XOR A
  LD HL,23728
  RLD
  INC HL
  RLD
  ADD A,48
  CP 58
  JR NC,SC_062_8
SC_062_5:
  RST 16
  DJNZ SC_062_4
  LD A,13
  RST 16
  JR SC_062_0
SC_062_6:
  RST 8
  DEFB 5
SC_062_7:
  RST 8
  DEFB 255
SC_062_8:
  ADD A,7
  JR SC_062_5


; HEX->DEC CONVERTER
SC_063:
  CALL 3435
  LD A,2
  CALL 5633
SC_063_0:
  LD A,72
  RST 16
  LD A,58
  RST 16
  LD HL,23728
  LD (HL),0
  INC HL
  LD (HL),0
SC_063_1:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_063_1
SC_063_2:
  CALL 654
  JR NZ,SC_063_2
  LD D,0
  CALL 798
  JR NC,SC_063_2
  CP 13
  JR Z,SC_063_5
  CP 81
  JR Z,SC_063_6
  CP 48
  JR C,SC_063_1
  CP 71
  JR NC,SC_063_1
  CP 58
  JR C,SC_063_3
  CP 65
  JR C,SC_063_1
SC_063_3:
  PUSH AF
  RST 16
  POP AF
  SUB 48
  CP 10
  JR C,SC_063_4
  SUB 7
SC_063_4:
  LD HL,23728
  RLD
  INC HL
  RLD
  JR SC_063_1
SC_063_5:
  LD A,32
  RST 16
  LD A,61
  RST 16
  LD A,32
  RST 16
  LD BC,(23728)
  CALL 11563
  CALL 11747
  LD A,13
  RST 16
  JR SC_063_0
SC_063_6:
  DEFB 207
  RST 56


; ON ERROR GO TO
;
; Call this at the start of your program, with say 1 RANDOMIZE USR start
; address.
;
; On running,  errors  (other  than  Interface  One errors with the shadow ROM
; paged in, which cannot be  trapped )  will not stop the program but will
; cause  a  jump  to  the  line number whose 2-byte equivalent has been POKEd
; into start address +52/+53 (default 9495).
;
; This line can contain any error  routine you fancy ( note that PEEK 23681
; gives the error number).
;
; Error codes 0,8 and 9 are not trapped by ON ERROR GOTO as they are not really
; errors but legitimate program stops. Note that after  any error the machine
; stack is reset, so RETURN will  not  function.
;
; Compare this routine with no: 66 . Note that  Supercode  3.5  is itself
; protected using OR ERROR GOTO (hence the Q option !).
SC_065:
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  LD BC,15
  ADD HL,BC
  EX DE,HL
  LD HL,(23613)
  LD (HL),E
  INC HL
  LD (HL),D
  RET
  DEC SP
  DEC SP
SC_065_0:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_065_0
  LD A,(23610)
  CP 255
  JR Z,SC_065_1
  CP 7
  JR Z,SC_065_1
  CP 8
  JR Z,SC_065_1
  INC A
  LD (23681),A
  LD (IY+0),255
  LD HL,9495
  LD (23618),HL
  XOR A
  LD (23620),A
  SET 7,(IY+1)
  JP 7037
SC_065_1:
  INC SP
  INC SP
  JP 4867


; ON BREAK GO TO
;
; Similar to no. 65, but only covering errors D (Break),  H  (Stop in Input),
; and L (Break into Program ) with the  error  code  in 23681 again. ( note
; that codes go from 0 to 9 & then A to R, where A=1O,B=11 etc ).
;
; POKE  start address +53/+54  with  the 2-byte equivalent of the line number
; to be jumped to when an error occurs. Compare also with routine 124.
SC_066:
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  LD BC,15
  ADD HL,BC
  EX DE,HL
  LD HL,(23613)
  LD (HL),E
  INC HL
  LD (HL),D
  RET
  HALT
SC_066_0:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_066_0
  LD A,(23610)
  CP 12
  JR Z,SC_066_1
  CP 16
  JR Z,SC_066_1
  CP 20
  JR Z,SC_066_1
  JR SC_066_2
SC_066_1:
  INC A
  LD (23681),A
  LD (IY+0),255
  LD HL,9495
  LD (23618),HL
  LD HL,0
  LD (23620),HL
  DEC SP
  DEC SP
  JP 7037
SC_066_2:
  JP 4867
  NOP


; AWAIT KEYPRESS
;
; Call this program with LET L=USR start address within  your  own program. It
; waits for a key to be pressed and returns  with  the CHR$ CODE of the key
; stored in L.
SC_093:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_093
SC_093_0:
  CALL 654
  JR NZ,SC_093_0
  LD D,0
  CALL 798
  JR NC,SC_093_0
  LD C,A
  XOR A
  LD B,A
  RET
  NOP
  NOP
  NOP
  NOP


; BLOCK LINE COPY
;
; Call this routine and follow the prompts (for no: of first  line to be
; copied, no: of last line to be copied and position the block is to be copied
; to, in that order ) to copy a block of lines from one part of a BASIC program
; to another.
;
; The original lines are not deleted (if they were, the routine would  be  Move
; and not Copy) but you can delete them using routine 57.
;
; The new lines will all be given line number 0 (but they will be in the right
; place) so it is necessary to  use one of the Renumber routines (60 or 61)
; immediately afterwards.
;
; Note  that  GOTOs, GOSUBs, RESTOREs, SAVE....LINEs etc within the block of
; lines will retain their original values, so they may have to be manually
; adjusted.
;
; Any attempt to copy a block to within  itself or to have overlapping blocks
; or to have a line  number  >  9999 will all result in Error B, Integer out of
; range.
SC_107:
  CALL 3435
  LD A,2
  CALL 5633
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  PUSH HL
  LD BC,36
  ADD HL,BC
SC_107_0:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD A,D
  CP 255
  JR Z,L61077
  EX DE,HL
  POP BC
  PUSH BC
  ADD HL,BC
  EX DE,HL
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL
  ADD HL,BC
  POP BC
  LD (HL),C
  INC HL
  LD (HL),B
  EX DE,HL
  JR SC_107_0


; Data block at 61047
L61047:
  DEFW 318
  DEFW 67
  DEFW 239
  DEFW 76
  DEFW 343
  DEFW 85
  DEFW 239
  DEFW 94
  DEFW 354
  DEFW 117
  DEFW 239
  DEFW 126
  DEFW 368
  DEFW 228
  DEFW 65535


; Routine at 61077
;
; Used by the routine at SC_107.
L61077:
  LD DE,37329
  LD BC,25
  CALL 8252
  CALL 37250
  CALL 6510
  LD (23728),HL
  LD DE,37354
  LD BC,11
  CALL 8252
  CALL 37250
  INC HL
  CALL 6510
  LD DE,(23728)
  PUSH HL
  DEC HL
  AND A
  SBC HL,DE
  JP C,7839
  POP HL
  LD (23563),HL
  LD DE,37365
  LD BC,14
  CALL 8252
  CALL 37250
  INC HL
  CALL 6510
  LD DE,(23563)
  PUSH HL
  AND A
  SBC HL,DE
  JR NC,L61077_0
  POP HL
  LD DE,(23728)
  PUSH HL
  INC DE
  AND A
  SBC HL,DE
  JP NC,7839
  LD HL,(23563)
  LD DE,(23728)
  CALL 6621
  ADD HL,BC
  LD (23728),HL
  EX DE,HL
  ADD HL,BC
  LD (23563),HL
L61077_0:
  LD HL,(23563)
  LD DE,(23728)
  CALL 6621
  LD HL,(23635)
  EX (SP),HL
  DEC HL
  PUSH BC
  CALL 5717
  POP BC
  INC HL
  INC HL
  POP DE
  LD (23635),DE
  PUSH HL
  LD DE,(23728)
  EX DE,HL
  LDIR
  POP HL
  XOR A
L61077_1:
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC
  PUSH HL
  AND A
  SBC HL,DE
  POP HL
  JR C,L61077_1
  LD DE,37379
  LD BC,20
  CALL 8252
  JP 7088
  RST 40
  DEFB 160                ; stk-zero
  DEFB 56                 ; end-calc
L61077_2:
  CALL 654
  LD A,E
  CP 255
  JR NZ,L61077_2
L61077_3:
  CALL 654
  JR NZ,L61077_3
  LD D,0
  CALL 798
  JR NC,L61077_3
  CP 13
  JR Z,L61077_4
  CP 81
  JP Z,7088
  CP 48
  JR C,L61077_2
  CP 58
  JR NC,L61077_2
  PUSH AF
  RST 16
  POP AF
  CALL 11554
  RST 40
  DEFB 1                  ; exchange
  DEFB 164                ; stk-ten
  DEFB 4                  ; multiply
  DEFB 15                 ; addition
  DEFB 56                 ; end-calc
  JR L61077_2
L61077_4:
  LD A,13
  RST 16
  CALL 11682
  LD HL,55536
  ADD HL,BC
  JP C,7839
  LD DE,55536
  AND A
  SBC HL,DE
  JP Z,7839
  LD H,B
  LD L,C
  RET
  LD B,D
  LD C,H
  LD C,A
  LD B,E
  LD C,E
  JR NZ,SC_082_0
  LD C,A
  LD D,B
  LD E,C
  DEC C
  DEC C
  LD B,(HL)
  LD D,D
  LD C,A
  LD C,L
  JR NZ,SC_082_1
  LD C,C
  LD C,(HL)
  LD B,L
  JR NZ,SC_082_2
  LD C,A
  LD A,(20308)
  JR NZ,SC_082_3
  LD C,C
  LD C,(HL)
  LD B,L
  JR NZ,SC_082_4
  LD C,A
  LD A,(17985)
  LD D,H
  LD B,L
  LD D,D
  JR NZ,SC_082_5
  LD C,C
  LD C,(HL)
  LD B,L
  JR NZ,SC_082_6
  LD C,A
  LD A,(20302)
  LD D,A
  JR NZ,SC_082_7
  LD B,L
  LD C,(HL)
  LD D,L
  LD C,L
  LD B,D
  LD B,L
  LD D,D
  JR NZ,SC_082_9
  LD D,D
  LD C,A
  LD B,A
  LD D,D
  LD B,C
  LD C,L
  NOP


; CONTRACT PROGRAM
;
; This routine will contract your  program  into  as  few  program lines as
; possible,by automatically combining statements wherever this was possible
; without  changing  program  logic.
;
; It  allows BASIC programs to run faster and occupy less memory, as  can  be
; checked with routines 103/104. D 61400 Contrast this with routine 83.
SC_082:
  CALL 124                ; trick for a relocatable program
; This entry point is used by the routine at L61077.
SC_082_0:
  DEC SP
  DEC SP
  LD BC,52096
  JR SC_082_8
  LD (HL),B
  LD BC,682
  LD H,B
  LD BC,166
  LD (HL),B
  LD BC,181
  LD H,B
; This entry point is used by the routine at L61077.
SC_082_1:
  LD BC,277
  LD (HL),B
  LD BC,234
; This entry point is used by the routine at L61077.
SC_082_2:
  LD H,B
  LD BC,252
; This entry point is used by the routine at L61077.
SC_082_3:
  LD H,B
  LD BC,257
  HALT
  NOP
  LD L,(HL)
; This entry point is used by the routine at L61077.
SC_082_4:
  LD BC,109
  LD (HL),L
  LD BC,368
; This entry point is used by the routine at L61077.
SC_082_5:
  LD A,(HL)
  NOP
  LD A,C
  LD (BC),A
  ADD A,E
  NOP
  LD H,B
; This entry point is used by the routine at L61077.
SC_082_6:
  LD BC,678
  INC C
  LD (BC),A
  INC L
  LD (BC),A
  INC C
  LD (BC),A
  DEC A
  LD (BC),A
; This entry point is used by the routine at L61077.
SC_082_7:
  RST 56
  RST 56
SC_082_8:
  POP HL
  PUSH HL
  LD BC,7
; This entry point is used by the routine at L61077.
SC_082_9:
  ADD HL,BC
SC_082_10:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD A,D
  CP 255
  JR Z,SC_082_11
  EX DE,HL
  POP BC
  PUSH BC
  ADD HL,BC
  EX DE,HL
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL
  ADD HL,BC
  POP BC
  LD (HL),C
  INC HL
  LD (HL),B
  EX DE,HL
  JR SC_082_10
SC_082_11:
  POP HL
  LD HL,(23635)
  LD A,(HL)
  AND 192
  JP NZ,7088
  INC HL
  INC HL
  INC HL
  LD (23728),HL
  LD (23645),HL
SC_082_12:
  RST 32
  CP 58
  JR Z,SC_082_12
  CP 13
  JP Z,37371
  CP 234
SC_082_13:
  JP Z,37636
  CP 250
  JR Z,SC_082_13
  CP 236
  JR Z,SC_082_20
  CP 237
  JR Z,SC_082_20
  CP 229
  JR Z,SC_082_20
  CP 240
  JR Z,SC_082_15
  CP 225
  JR Z,SC_082_15
  CP 247
  JR Z,SC_082_20
  CP 248
  JR Z,SC_082_17
SC_082_14:
  JP 37355
SC_082_15:
  CALL 119
  CP 35
  JR NZ,SC_082_21
SC_082_16:
  CALL 6326
  CP 13
  JP Z,37371
  CP 58
  JR Z,SC_082_12
  CP 59
  JR Z,SC_082_20
  CP 44
  JR Z,SC_082_20
  CALL 119
  JR SC_082_16
SC_082_17:
  CALL 119
  CP 34
  JR Z,SC_082_18
  INC HL
  JR SC_082_19
SC_082_18:
  CALL 119
  CP 34
  JR NZ,SC_082_18
SC_082_19:
  CALL 119
  CP 202
  JR Z,SC_082_20
  JR SC_082_14
SC_082_20:
  CALL 119
SC_082_21:
  LD D,H
  LD E,L
  CP 13
  JP Z,37371
  CP 58
  JR Z,SC_082_12
  CP 32
  JR Z,SC_082_20
SC_082_22:
  CALL 6326
  JR Z,SC_082_24
  CP 48
  JP C,37355
  CP 58
  JP NC,37355
SC_082_23:
  CALL 119
  CP 32
  JR Z,SC_082_23
  JR SC_082_22
SC_082_24:
  CP 13
  JR Z,SC_082_25
  CP 58
  JR Z,SC_082_25
  JP 37355
SC_082_25:
  DEC HL
  DEC HL
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  DEC HL
  DEC HL
  LD (23645),HL
  LD HL,(23635)
SC_082_26:
  LD A,(HL)
  AND 192
  JR NZ,SC_082_31
  LD A,(HL)
  CP B
  JR C,SC_082_27
  RET NZ
  INC HL
  LD A,(HL)
  CP C
  JR C,SC_082_28
  JR SC_082_29
SC_082_27:
  INC HL
SC_082_28:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  ADD HL,DE
  JR SC_082_26
SC_082_29:
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  CP 0
  JR Z,SC_082_31
  CP 2
  JR Z,SC_082_31
  CP 1
  JR Z,SC_082_30
  CALL 5714
  LD A,2
  LD (DE),A
  LD D,(HL)
  DEC HL
  LD E,(HL)
  INC DE
  LD (HL),E
  INC HL
  LD (HL),D
  JR SC_082_31
SC_082_30:
  LD (HL),0
SC_082_31:
  LD HL,(23645)
  LD C,0
  LD A,(HL)
  LD D,1
  CALL 6554
  CP 13
  JP NZ,37121
  INC HL
  LD A,(HL)
  AND 192
  JP Z,37112
  LD HL,(23635)
SC_082_32:
  LD A,(HL)
  AND 192
  JR NZ,SC_082_37
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  PUSH HL
  ADD HL,DE
  EX DE,HL
  POP HL
  INC HL
  LD A,(HL)
  CP 3
  JR C,SC_082_35
SC_082_33:
  EX DE,HL
  PUSH HL
  INC HL
  LD A,(HL)
  AND 192
  JR NZ,SC_082_37
  INC HL
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  CP 3
  POP HL
  JR C,SC_082_36
SC_082_34:
  LD (HL),58
  INC HL
  JR SC_082_32
SC_082_35:
  CP 2
  JR Z,SC_082_33
  EX DE,HL
  INC HL
  JR SC_082_32
SC_082_36:
  CP 1
  JR Z,SC_082_34
  INC HL
  JR SC_082_32
SC_082_37:
  LD HL,(23635)
SC_082_38:
  INC HL
  INC HL
  LD (23645),HL
  LD E,(HL)
  INC HL
  LD D,(HL)
SC_082_39:
  ADD HL,DE
  LD A,(HL)
  CP 13
  JR Z,SC_082_42
  CP 58
  JP NZ,7306
  INC HL
  LD D,H
  LD E,L
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,(HL)
  CP 3
  JR C,SC_082_41
SC_082_40:
  PUSH BC
  CALL 6629
  POP DE
  DEC DE
  JR SC_082_39
SC_082_41:
  INC HL
  DEC BC
  JR SC_082_40
SC_082_42:
  LD DE,(23645)
  AND A
  INC DE
  SBC HL,DE
  EX DE,HL
  INC HL
  LD A,(HL)
  CP 3
  JR C,SC_082_44
SC_082_43:
  DEC HL
  LD (HL),D
  DEC HL
  LD (HL),E
  ADD HL,DE
  INC HL
  INC HL
  LD A,(HL)
  AND 192
  JR NZ,SC_082_45
  JR SC_082_38
SC_082_44:
  PUSH DE
  LD BC,1
  CALL 6632
  POP DE
  DEC DE
  JR SC_082_43
  LD A,128
  SUB D
  LD D,A
  LD HL,(23563)
  CALL 6539
  RET
SC_082_45:
  LD HL,(23635)
SC_082_46:
  INC HL
  INC HL
  INC HL
SC_082_47:
  LD (23563),HL
  LD E,234
  LD D,128
  CALL 6539
  JR C,SC_082_51
  JR Z,SC_082_48
  CALL 37527
  JR SC_082_50
SC_082_48:
  LD HL,(23563)
  LD D,128
  LD E,250
  CALL 6539
  JR Z,SC_082_49
  CALL 37527
SC_082_49:
  LD BC,4
  CALL 5717
  INC HL
  LD (HL),13
  PUSH HL
  LD DE,(23563)
  AND A
  SBC HL,DE
  EX DE,HL
  LD B,(HL)
  LD (HL),D
  DEC HL
  LD C,(HL)
  LD (HL),E
  LD H,B
  LD L,C
  AND A
  SBC HL,DE
  EX DE,HL
  POP HL
  INC HL
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  JR SC_082_47
SC_082_50:
  LD HL,(23563)
  DEC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  ADD HL,DE
SC_082_51:
  INC HL
  LD A,(HL)
  AND 192
  JP NZ,7088
  JR SC_082_46
  LD HL,(23728)
  PUSH AF
  INC HL
  LD A,(HL)
  CP 0
  JR Z,SC_082_53
  CP 2
  JR Z,SC_082_52
  CP 1
  JR Z,SC_082_53
  CALL 5714
  LD A,1
  LD (DE),A
  LD D,(HL)
  DEC HL
  LD E,(HL)
  INC DE
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  JR SC_082_53
SC_082_52:
  LD (HL),0
SC_082_53:
  DEC HL
  DEC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP AF
  CP 250
  JP Z,37355
  ADD HL,DE
  JP 37371                ; }


; EXPAND PROGRAM
;
; The opposite of 82 CONTRACT PROGRAM, this  routine  prompts  you for the
; number of the line you wish to  expand into all its constituent statements,
; enabling easy  editing.
;
; All  such  lines will have line number 0, so it is necessary to use one of
; the Renumber routines (60 or 61) on the program afterwards, to expand the
; whole of your program, respond to  the  first  prompt with just Enter.
SC_083:
  CALL 3435
  LD A,2
  CALL 5633
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  PUSH HL
  LD DE,228
  ADD HL,DE
  EX DE,HL
  LD BC,58
  CALL 8252
  RST 40
  DEFB 160                ; stk-zero
  DEFB 56                 ; end-calc
SC_083_0:
  CALL 654
  LD A,E
  CP 255
  JR NZ,SC_083_0
SC_083_1:
  CALL 654
  JR NZ,SC_083_1
  LD D,0
  CALL 798
  JR NC,SC_083_1
  CP 13
  JR Z,SC_083_2
  CP 81
  JP Z,7088
  CP 48
  JR C,SC_083_0
  CP 58
  JR NC,SC_083_0
  PUSH AF
  RST 16
  POP AF
  CALL 11554
  RST 40
  DEFB 1                  ; exchange
  DEFB 164                ; stk-ten
  DEFB 4                  ; multiply
  DEFB 15                 ; addition
  DEFB 56                 ; end-calc
  JR SC_083_0
SC_083_2:
  LD A,13
  RST 16
  CALL 11682
  LD HL,55536
  ADD HL,BC
  JP C,7839
  LD DE,55536
  AND A
  SBC HL,DE
  JR Z,SC_083_3
  LD HL,1
  LD (23681),HL
  LD H,B
  LD L,C
  CALL 6510
  JR SC_083_4
SC_083_3:
  LD HL,0
  LD (23681),HL
  LD HL,(23635)
SC_083_4:
  LD A,(HL)
  AND 192
  JR NZ,SC_083_8
  INC HL
  INC HL
  INC HL
SC_083_5:
  LD (23728),HL
  LD (23645),HL
SC_083_6:
  RST 32
  CP 58
  JR Z,SC_083_6
  CP 13
  JR Z,SC_083_7
  CP 234
  JR Z,SC_083_7
  CP 250
  JR Z,SC_083_7
  LD E,0
  LD C,0
  LD D,1
  CALL 6552
  JR C,SC_083_7
  LD BC,4
  CALL 5717
  INC HL
  LD (HL),13
  PUSH HL
  LD DE,(23728)
  AND A
  SBC HL,DE
  EX DE,HL
  LD B,(HL)
  LD (HL),D
  DEC HL
  LD C,(HL)
  LD (HL),E
  LD H,B
  LD L,C
  AND A
  SBC HL,DE
  EX DE,HL
  POP HL
  INC HL
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  JR SC_083_5
SC_083_7:
  LD A,(23681)
  BIT 0,A
  JR NZ,SC_083_8
  LD HL,(23728)
  LD D,(HL)
  DEC HL
  LD E,(HL)
  INC HL
  ADD HL,DE
  INC HL
  JR SC_083_4
SC_083_8:
  POP HL
  LD DE,286
  ADD HL,DE
  EX DE,HL
  LD BC,20
  CALL 8252
  JP 7088


; Message at 62326
L62326:
  DEFM "EXPAND"
  DEFB 13
  DEFB 13
  DEFM "Press ENTER to Expand the Whole Program "
  DEFB 13
  DEFB 13
  DEFM "LINE NO:NOW RENUMBER PROGRAM"


; ANALYSE PROGRAM
;
; This routine displays the number of lines and  statements  there are in the
; program. It is useful with routines 71 & 104.
SC_086:
  CALL 3435
  RST 40
  DEFB 160                ; stk-zero
  DEFB 56                 ; end-calc
  LD HL,0
  LD (23728),HL
  LD HL,(23635)
  DEC HL
SC_086_0:
  INC HL
  LD A,(HL)
  AND 192
  JR NZ,SC_086_2
  LD BC,(23728)
  INC BC
  LD (23728),BC
  INC HL
  INC HL
  INC HL
SC_086_1:
  LD D,2
  LD E,0
  CALL 6539
  PUSH AF
  PUSH HL
  RST 40
  DEFB 161                ; stk-one
  DEFB 15                 ; addition
  DEFB 56                 ; end-calc
  POP HL
  POP AF
  JR C,SC_086_0
  JR SC_086_1
SC_086_2:
  LD A,2
  CALL 5633
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  LD DE,35
  ADD HL,DE
  EX DE,HL
  LD BC,16
  CALL 8252
  PUSH DE
  LD BC,(23728)
  CALL 6683
  POP DE
  LD BC,17
  CALL 8252
  CALL 11747
  JP 7088


; Message at 62500
L62500:
  DEFM "No. LINES      :"
  DEFB 13
  DEFM "No. STATEMENTS :"


; TAPE HEADER READER
;
; After calling this routine, start your tape as if to load a program.
;
; A full print of header information (name,type,length,address if code,
; autostart line if any) will he printed  on  the screen for you to analyse.
SC_087:
  DI
SC_087_0:
  LD DE,17
  XOR A
  SCF
  LD IX,23296
  CALL 1366
  JR NC,SC_087_0
  EI
  LD IX,23296
  CALL 3435
  LD A,2
  CALL 5633
  LD A,(23296)
  LD DE,2496
  CALL 3082
  LD B,10
  LD DE,23296
SC_087_1:
  INC DE
  LD A,(DE)
  RST 16
  DJNZ SC_087_1
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  PUSH HL
  LD DE,152
  ADD HL,DE
  EX DE,HL
  LD BC,12
  CALL 8252
  LD C,(IX+11)
  LD B,(IX+12)
  CALL 11563
  CALL 11747
  LD A,(23296)
  CP 3
  JR Z,SC_087_2
  CP 0
  JR Z,SC_087_3
  POP HL
  PUSH HL
  LD DE,164
  ADD HL,DE
  EX DE,HL
  LD BC,13
  CALL 8252
  LD A,(23310)
  RES 7,A
  RES 6,A
  RES 5,A
  LD H,96
  ADD A,H
  RST 16
  JP 7088
SC_087_2:
  POP HL
  PUSH HL
  LD DE,177
  ADD HL,DE
  EX DE,HL
  LD BC,13
  CALL 8252
  LD C,(IX+13)
  LD B,(IX+14)
  CALL 11563
  CALL 11747
  JP 7088
SC_087_3:
  LD B,(IX+14)
  LD A,B
  AND 192
  JR NZ,SC_087_4
  LD C,(IX+13)
  CALL 11563
  POP HL
  PUSH HL
  LD DE,190
  ADD HL,DE
  EX DE,HL
  LD BC,21
  CALL 8252
  CALL 11747
SC_087_4:
  POP HL
  LD DE,211
  ADD HL,DE
  EX DE,HL
  LD BC,25
  CALL 8252
  LD C,(IX+15)
  LD B,(IX+16)
  CALL 11563
  CALL 11747
  JP 7088
  DEFB 13
  DEFB 13
  DEFM "No. Bytes:"
  DEFB 13
  DEFB 13
  DEFM "Array Name:"
  DEFB 13
  DEFB 13
  DEFM "First Byte:"
  DEFB 13
  DEFB 13
  DEFM "Auto-start Line No:"
  DEFB 13
  DEFB 13
  DEFM "Length of Program Only:"


; SCREEN$ GRID
;
; This routine sets the CHR$ squares on the screen alternately bright & dark
; (ie, a checkerboard effect).
;
; This can be very useful in designing screen layout, calculating PRINT AT and
; PLOT values, etc.
SC_089:
  LD HL,22528
  LD B,11
SC_089_0:
  PUSH BC
  LD B,16
SC_089_1:
  LD A,(HL)
  SET 6,A
  LD (HL),A
  INC HL
  LD A,(HL)
  RES 6,A
  LD (HL),A
  INC HL
  DJNZ SC_089_1
  LD B,16
SC_089_2:
  LD A,(HL)
  RES 6,A
  LD (HL),A
  INC HL
  LD A,(HL)
  SET 6,A
  LD (HL),A
  INC HL
  DJNZ SC_089_2
  POP BC
  DJNZ SC_089_0
  RET


; ANALYSE MEMORY
;
; This routine prints out the address,contents in decimal,contents in
; hexadecimal and CHR$ value (where printable) of a block of memory. Press N to
; return to BASIC.
;
; POKE start address +9/+10, 2-byte equivalent of the address from which you
; wish memory to be analysed.
SC_091:
  CALL 3435
  LD A,2
  CALL 5633
  LD HL,0
SC_091_0:
  EX DE,HL
  LD HL,23729
  LD B,D
  LD C,E
  PUSH HL
  PUSH DE
  CALL 11563
  CALL 11747
  POP DE
  POP HL
  LD A,32
  RST 16
  LD A,(DE)
  LD (HL),A
  DEC HL
  LD (HL),0
  CALL 6696
  LD A,32
  RST 16
  LD A,32
  RST 16
  LD A,(DE)
  LD B,2
SC_091_1:
  XOR A
  RLD
  ADD A,48
  CP 58
  JR NC,SC_091_4
SC_091_2:
  RST 16
  DJNZ SC_091_1
  LD A,32
  RST 16
  LD A,32
  RST 16
  EX DE,HL
  LD A,(HL)
  CP 50
  JR C,SC_091_5
SC_091_3:
  RST 16
  LD A,13
  RST 16
  INC HL
  JR SC_091_0
SC_091_4:
  ADD A,7
  JR SC_091_2
SC_091_5:
  LD A,63
  JR SC_091_3


; MONOCHROME PROGRAM
;
; This routine removes hidden colour items (other  than  those within strings)
; hence saving memory.
SC_090:
  LD HL,(23635)
  DEC HL
SC_090_0:
  INC HL
  LD A,(HL)
  AND 192
  JP NZ,7088
  INC HL
  INC HL
  INC HL
  PUSH HL
SC_090_1:
  INC HL
  PUSH HL
  LD (23645),HL
  RST 24
  POP DE
  PUSH DE
  AND A
  SBC HL,DE
  LD B,H
  LD C,L
  POP HL
  JR Z,SC_090_2
  CALL 6632
SC_090_2:
  LD DE,512
  CALL 6539
  JR NC,SC_090_1
  POP DE
  PUSH HL
  AND A
  SBC HL,DE
  EX DE,HL
  LD (HL),D
  DEC HL
  LD (HL),E
  POP HL
  JR SC_090_0
  NOP
  NOP
  NOP


; UNI BEEP SIMULATOR
;
; Replaces the ROM BEEP routine.
;
; POKE start address +1/+2, 2-byte equivalent of the frequency
;
; POKE start address +4/+5, 2-byte equivalent of the  duration  in units of .02
; second
SC_045:
  LD HL,768
  LD DE,150
  CALL 949
  RET


; MULTI BEEP SIMULATOR
;
; This can give amazing bell-like effects.
;
; POKE start address + 1, pitch decrement per step
;
; POKE start address + 2. number of notes
;
; POKE start address +4/+5, 2-byte equivalent of initial frequency
;
; POKE start address  +7/+6,  2-byte  equivalent  of  duration  in milliseconds
SC_046:
  LD BC,64004
  LD HL,512
  LD DE,15
SC_046_0:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL 949
  POP BC
  POP DE
  POP HL
  LD A,L
  SUB C
  LD L,A
  DJNZ SC_046_0
  RET


; OBLIQUE SCROLL-OFF
;
; The weirdest scroll of all - call it  repeatedly to get the desired effect.
SC_047:
  LD HL,22527
  LD C,30
SC_047_0:
  LD B,200
  OR A
SC_047_1:
  RL (HL)
  DEC HL
  DJNZ SC_047_1
  DEC C
  JR NZ,SC_047_0
  RET


; CHR$ DOWN-SCROLL
;
; For each call of this routine the screen is scrolled down  by  8 pixels.
;
; To scroll attributes as well, use  routine  38  ( after defining a suitable
; box ) in conjunction with this routine.
SC_048:
  LD HL,22527
  LD DE,22495
SC_048_0:
  PUSH HL
  PUSH DE
  LD C,23
SC_048_1:
  LD B,32
SC_048_2:
  LD A,(DE)
  LD (HL),A
  LD A,C
  AND 7
  CP 1
  JR NZ,SC_048_3
  SUB A
  LD (DE),A
SC_048_3:
  DEC HL
  DEC DE
  DJNZ SC_048_2
  DEC C
  JR Z,SC_048_4
  LD A,C
  AND 7
  CP 0
  JR Z,SC_048_5
  CP 7
  JR NZ,SC_048_1
  PUSH DE
  LD DE,1792
  AND A
  SBC HL,DE
  POP DE
  JR SC_048_1
SC_048_4:
  POP DE
  POP HL
  DEC D
  DEC H
  LD A,H
  CP 79
  RET Z
  JR SC_048_0
SC_048_5:
  PUSH HL
  LD HL,1792
  EX DE,HL
  AND A
  SBC HL,DE
  EX DE,HL
  POP HL
  JR SC_048_1


; CHR$ REFLECT Y-AXIS
;
; These three routines operate on any character set stored in RAM.
;
; It could be the UDGs, the SciFi CHR$ set  described  in  routine 79, the
; original CHR$ set copied over from the ROM or any  other set devised by you
; (see the note on the system variable  CHARS in the Spectrum manual).
;
; POKE start address +3/+4  (+1/+2 for routine 51), 2-byte equivalent of the
; address of the CHR$ to be transformed
SC_050:
  LD A,8
  LD HL,57744
SC_050_0:
  LD B,8
SC_050_1:
  RR (HL)
  RL C
  DJNZ SC_050_1
  LD (HL),C
  INC HL
  DEC A
  JR NZ,SC_050_0
  RET


; CHR$ REFLECT X-AXIS
SC_051:
  LD HL,57648
  LD B,8
  LD E,L
  LD D,H
SC_051_0:
  LD A,(HL)
  INC HL
  PUSH AF
  DJNZ SC_051_0
  LD B,8
SC_051_1:
  POP AF
  LD (DE),A
  INC DE
  DJNZ SC_051_1
  RET


; CHR$ ROTATE
SC_049:
  LD E,128
  LD HL,57856
SC_049_0:
  LD B,1
  LD C,0
  PUSH HL
SC_049_1:
  LD A,E
  AND (HL)
  CP 0
  JR Z,SC_049_2
  LD A,C
  ADD A,B
  LD C,A
SC_049_2:
  SLA B
  INC HL
  JR NC,SC_049_1
  POP HL
  PUSH BC
  SRL E
  JR NC,SC_049_0
  LD DE,7
  LD B,8
  ADD HL,DE
SC_049_3:
  POP DE
  LD (HL),E
  DEC HL
  DJNZ SC_049_3
  RET


; DATA FILL
;
; This routine loads data / machine node programs stored in memory into an
; auto—created DATA statement at line 1.
;
; POKE start address +4/+5, 2-byte equivalent of address of data/program in
; memory
;
; POKE start address +1/+2, 2-byte equivalent of the number of bytes to be
; stored
;
; This routine has a purpose similar to that of routine 84 but is relatively
; very wasteful of space.
;
; For example, if  we  were  to use each routine to store 1000 bytes (all of
; which are 77), memory consumption would be as follows:-
;
; Routine 84: 2+2+1+1 (Line no:,length,Enter & REM) + 1000 = 1006
;
; Routine 85: 2+2+1+1 (Line no:,length,Enter & DATA) + 999(commas)
;
; + 1000*(2 digits + CHR$(14) + 5 floating pt) = 9005
;
; The difference is very significant, the example not being untypical.
SC_085:
  LD BC,0
  LD DE,0
  LD A,B
  OR C
  RET Z
  LD HL,(23635)
  LD A,(HL)
  CP 0
  JR NZ,SC_085_0
  INC HL
  LD A,(HL)
  CP 1
  RET Z
  DEC HL
SC_085_0:
  PUSH HL
  PUSH BC
  PUSH DE
  SUB A
  CALL 3976
  EX DE,HL
  LD A,1
  CALL 3976
  EX DE,HL
  CALL 3976
  EX DE,HL
  CALL 3976
  EX DE,HL
  LD A,228
  CALL 3976
  EX DE,HL
SC_085_1:
  POP DE
  LD A,(DE)
  PUSH DE
  LD C,47
SC_085_2:
  LD B,100
  INC C
  SUB B
  JR NC,SC_085_2
  ADD A,B
  LD B,A
  LD A,C
  PUSH BC
  CALL 3976
  EX DE,HL
  POP BC
  LD C,47
  LD A,B
SC_085_3:
  LD B,10
  INC C
  SUB B
  JR NC,SC_085_3
  ADD A,B
  LD B,A
  LD A,C
  PUSH BC
  CALL 3976
  POP BC
  EX DE,HL
  LD A,B
  ADD A,48
  CALL 3976
  EX DE,HL
  LD A,14
  LD B,6
SC_085_4:
  PUSH BC
  CALL 3976
  POP BC
  EX DE,HL
  SUB A
  DJNZ SC_085_4
  POP DE
  PUSH HL
  DEC HL
  DEC HL
  DEC HL
  LD A,(DE)
  LD (HL),A
  POP HL
  INC DE
  POP BC
  DEC BC
  LD A,B
  OR C
  JR Z,SC_085_5
  PUSH BC
  PUSH DE
  LD A,44
  CALL 3976
  EX DE,HL
  JR SC_085_1
SC_085_5:
  LD A,13
  CALL 3976
  POP HL
  LD BC,0
  INC HL
  INC HL
  LD E,L
  LD D,H
  INC HL
SC_085_6:
  INC BC
  INC HL
  LD A,(HL)
  CP 14
  JR NZ,SC_085_7
  INC BC
  INC HL
  INC BC
  INC HL
  INC BC
  INC HL
  INC BC
  INC HL
  INC BC
  INC HL
  JR SC_085_6
SC_085_7:
  CP 13
  JR NZ,SC_085_6
  LD A,C
  LD (DE),A
  INC DE
  LD A,B
  LD (DE),A
  RET


; INITIALISE
;
; Zeroes all numeric variables/arrays,  sets  all  strings  to  "" (empty) and
; fills all dimensioned string arrays with CHR$ 32s.
SC_070:
  LD HL,(23627)
SC_070_0:
  LD A,(HL)
  CP 128
  RET Z
  LD DE,1
  BIT 7,A
  JR NZ,SC_070_5
  BIT 5,A
  JR Z,SC_070_3
SC_070_1:
  LD B,5
SC_070_2:
  INC HL
  LD (HL),D
  DJNZ SC_070_2
  ADD HL,DE
  JR SC_070_0
SC_070_3:
  INC HL
  LD C,(HL)
  LD (HL),D
  INC HL
  LD B,(HL)
  LD (HL),D
  INC HL
SC_070_4:
  LD A,B
  OR C
  JR Z,SC_070_0
  PUSH BC
  CALL 4120
  POP BC
  DEC BC
  JR SC_070_4
SC_070_5:
  BIT 6,A
  JR NZ,SC_070_11
  BIT 5,A
  JR Z,SC_070_7
SC_070_6:
  INC HL
  BIT 7,(HL)
  JR Z,SC_070_6
  JR SC_070_1
SC_070_7:
  SUB A
SC_070_8:
  PUSH AF
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH HL
  LD L,(HL)
  LD H,D
  ADD HL,HL
  POP DE
SC_070_9:
  DEC BC
  DEC HL
  INC DE
  LD A,H
  OR L
  JR NZ,SC_070_9
  DEC BC
SC_070_10:
  DEC BC
  INC DE
  POP AF
  LD (DE),A
  PUSH AF
  LD A,B
  OR C
  JR NZ,SC_070_10
  POP AF
  INC DE
  EX DE,HL
  JR SC_070_0
SC_070_11:
  BIT 5,A
  JR Z,SC_070_12
  LD DE,14
  JR SC_070_1
SC_070_12:
  LD A,32
  JR SC_070_8


; STR$ LIST
;
; A powerful find routine which searches the BASIC program and lists each line
; containing a specified sequence of characters.
;
; POKE start address +12, number of characters in the string.
;
; POKE start address +9/+l0, 2-byte equivalant of the  address  of the first
; CHR$ code in the string poked by you into memory ( the default is 23296, the
; start of the printer buffer area )
;
; Any character obtainable  from  the  Spectrum  keyboard  may  be searched
; for,  including  keywords,  variables  and  arithmetic operators (+,-,/
; etc.). The following BASIC program demonstrates the routine in operation.
;
; 10 INPUT "ENTER STRING TO BE LOCATED:";N$: POKE 63502, LEN N$
; 20 FOR Z=1 TO LEN N$:POKE 23295+Z, CODE N$(Z):NEXT Z
; 30 CLS : RANDOMIZE USR 63490 : PRINT '"NO MORE OCCURRENCES"
;
; Note: To enter a keyword (ie,RUN,POKE,SAVE etc), enter THEN followed by the
; keyword. Backspace the cursor & delete THEN.
SC_072:
  RES 0,(IY+2)
  LD HL,(23635)
  LD IX,23296
SC_072_0:
  LD A,2
  LD E,A
  CP 0
  RET Z
  PUSH HL
SC_072_1:
  PUSH IX
  POP BC
  INC HL
  INC HL
  LD D,0
  INC HL
SC_072_2:
  PUSH DE
  INC HL
  LD DE,(23627)
  AND A
  SBC HL,DE
  ADD HL,DE
  POP DE
  JR C,SC_072_4
  POP HL
  RET
SC_072_3:
  JR SC_072_0
SC_072_4:
  LD A,(HL)
  CP 13
  JR NZ,SC_072_5
  INC HL
  POP BC
  PUSH HL
  JR SC_072_1
SC_072_5:
  CALL 6326
  JR NZ,SC_072_7
  DEC HL
SC_072_6:
  PUSH IX
  LD D,0
  POP BC
  JR SC_072_2
SC_072_7:
  LD A,(BC)
  CP (HL)
  JR NZ,SC_072_6
  INC D
  INC BC
  LD A,D
  CP E
  JR NZ,SC_072_2
  LD A,13
  RST 16
  POP HL
  PUSH HL
  LD B,(HL)
  INC HL
  LD L,(HL)
  LD A,47
  LD DE,1000
  LD H,B
SC_072_8:
  INC A
  AND A
  SBC HL,DE
  JR NC,SC_072_8
  ADD HL,DE
  RST 16
  LD DE,100
  LD A,47
SC_072_9:
  INC A
  AND A
  SBC HL,DE
  JR NC,SC_072_9
  ADD HL,DE
  RST 16
  LD A,47
  LD DE,10
SC_072_10:
  INC A
  AND A
  SBC HL,DE
  JR NC,SC_072_10
  ADD HL,DE
  RST 16
  LD A,L
  ADD A,48
  RST 16
  POP HL
  INC HL
  INC HL
  INC HL
SC_072_11:
  INC HL
  LD A,(HL)
SC_072_12:
  CP 13
  JR NZ,SC_072_13
  RST 16
  INC HL
  JR SC_072_3
SC_072_13:
  CALL 6326
  JR Z,SC_072_12
  CP 32
  JR C,SC_072_11
  RST 16
  JR SC_072_11


; STR$ REPLACE
;
; Similar to routine  72,  but  replaces  the  string  found  with another
; string of identical length.
;
; POKE start address + 4, number of CHR$ to be replaced
;
; POKE start address +8/+9, 2-byte equivalent of  the  address  of the string
; to be replaced.
;
; POKE start address + 69/+70, 2-byte equivalent of the address of the new
; string.
SC_073:
  LD HL,(23635)
  LD A,1
  LD E,A
  LD IX,0
  CP 0
  RET Z
  DEC HL
SC_073_0:
  INC HL
  INC HL
  INC HL
  INC HL
  JR SC_073_2
SC_073_1:
  INC HL
  PUSH DE
  LD DE,(23627)
  AND A
  SBC HL,DE
  ADD HL,DE
  POP DE
  RET NC
  LD A,(HL)
  CP 13
  JR Z,SC_073_0
  CALL 6326
  JR NZ,SC_073_3
  DEC HL
SC_073_2:
  PUSH IX
  POP BC
  LD D,0
  JR SC_073_1
SC_073_3:
  LD A,(BC)
  CP (HL)
  JR NZ,SC_073_2
  INC D
  INC BC
  LD A,D
  CP E
  JR NZ,SC_073_1
  PUSH HL
  LD D,0
  AND A
  SBC HL,DE
  LD D,E
  INC D
  LD BC,0
SC_073_4:
  DEC D
  INC HL
  JR Z,SC_073_5
  LD A,(BC)
  INC BC
  LD (HL),A
  JR SC_073_4
SC_073_5:
  POP HL
  JR SC_073_2
  NOP


; SCREEN$ PRINT
;
; This routine PRINTs a CHR$ at any position  with  any  attribute (not
; necessarily those preset globally).
SC_054:
  LD A,16
  RST 16
  LD A,1
  RST 16
  LD A,17
  RST 16
  LD A,6
  RST 16
  LD A,18
  RST 16
  LD A,1
  RST 16
  LD A,19
  RST 16
  LD A,1
  RST 16
  LD A,20
  RST 16
  LD A,0
  RST 16
  LD A,21
  RST 16
  LD A,0
  RST 16
  LD A,22
  RST 16
  LD A,12
  RST 16
  LD A,10
  RST 16
  LD A,42
  RST 16
  RET


; RND# GENERATOR
;
; Call with LET L=USR start address. The routine places  a  random number in
; the range 0-65535 in the System Variable SEED:  it  is accessed by PEEK 23670
; + 256*PEEK 23671.
SC_055:
  PUSH DE
  LD HL,(23670)
  LD D,H
  LD E,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  LD (23670),HL
  POP DE
  RET


; BLOCK MEMORY INSERT
;
; This routine inserts a given number from 0-255 into a  block  of memory.
;
; POKE start address + 1, no: of bytes to be inserted
;
; POKE start address +3/+4, 2 byte-equivalent of address of  first byte to be
; changed
;
; POKE start address + 6, value to be inserted
;
; In the program example, value 200 is inserted into a section  of SCREEN$.
SC_056:
  LD B,100
  LD HL,16384
SC_056_0:
  LD (HL),200
  INC HL
  DJNZ SC_056_0
  RET


; BLOCK LINE ERASE
;
; This routine can erase series  of  lines  from  BASIC  programs.
;
; Before calling this routine you must:
;
; POKE 23728/9, 2-byte equivalent of the number of the first  line to be
; deleted
;
; RANDOMIZE number of last line to be deleted.
SC_057:
  LD BC,(23728)
  CALL SC_057_0
  PUSH HL
  LD BC,(23670)
  CALL SC_057_0
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  ADD HL,DE
  INC HL
  POP DE
  AND A
  SBC HL,DE
  PUSH HL
  ADD HL,DE
  EX DE,HL
  PUSH HL
  LD HL,(23653)
  AND A
  SBC HL,DE
  LD B,H
  LD C,L
  POP HL
  EX DE,HL
  LDIR
  LD HL,(23627)
  POP DE
  AND A
  SBC HL,DE
  LD (23627),HL
  LD HL,(23641)
  AND A
  SBC HL,DE
  LD (23641),HL
  RET
SC_057_0:
  LD HL,(23635)
SC_057_1:
  LD D,(HL)
  INC HL
  LD E,(HL)
  EX DE,HL
  AND A
  SBC HL,BC
  ADD HL,BC
  EX DE,HL
  JR Z,SC_057_2
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  ADD HL,DE
  LD DE,(23627)
  AND A
  SBC HL,DE
  ADD HL,DE
  JR C,SC_057_1
  RST 8
  DEFB 10
SC_057_2:
  DEC HL
  RET


; CHR$ SWOP
;
; This routine exchanges all occurrences of  the  CHR$  with  code X within a
; program with the CHR$ with code Y (for a list of CHR$ codes see the chapter
; on the ASCII character set in the Spectrum manual), UDGs,graphic CHR$s and
; keywords are all coped with.
;
; POKE start address + 1, X
;
; POKE start address + 3, Y
SC_058:
  LD D,143
  LD E,69
  LD HL,(23635)
SC_058_0:
  INC HL
  INC HL
  INC HL
SC_058_1:
  INC HL
  LD A,(HL)
  LD C,14
  CP C
  JR NZ,SC_058_2
  INC HL
  JR SC_058_0
SC_058_2:
  LD C,13
  CP C
  JR NZ,SC_058_3
  INC HL
  LD BC,(23627)
  AND A
  SBC HL,BC
  ADD HL,BC
  RET NC
  JR SC_058_0
SC_058_3:
  CP D
  JR NZ,SC_058_1
  LD (HL),E
  JR SC_058_1
  NOP
  NOP
  NOP
  NOP
  NOP


; LASER ZAP
;
; This makes a futuristic laser sound.
;
; POKE start address + 1, duration.
SC_042:
  LD B,10
SC_042_0:
  PUSH BC
  LD HL,768
SC_042_1:
  LD DE,1
  PUSH HL
  CALL 949
  POP HL
  LD DE,16
  AND A
  SBC HL,DE
  JR NZ,SC_042_1
  POP BC
  DJNZ SC_042_0
  RET


; SCREEN$ MERGE
;
; A useful addition to routine 25,26,27.  These  can  be  used  to simulate
; animation effects. A screen stored  in  RAM  is  merged with the current
; display. POKE  start  address  +4/+5  with  the 2-byte equivalent of the  RAM
; screen's  first  byte.  Attribute values remain unaltered.
SC_029:
  LD BC,6144
  LD DE,16385
  LD HL,16384
SC_029_0:
  LD A,(DE)
  OR (HL)
  LD (HL),A
  INC HL
  INC DE
  DEC BC
  LD A,B
  OR C
  JR NZ,SC_029_0
  RET
  NOP
  NOP
  NOP
  NOP
  NOP


; PIXEL UP-SCROLL
;
; These two routines will scroll the screen up or down one  pixel, leaving the
; attributes unchanged.  Use  repeated  calls  to  the address specified in the
; table to the scroll as far as required.  By combining these routines with
; numbers 37-40, joint  scrolling of attributes can  be  done.  Define  a
; suitable  box,  use  an attribute value of 63 and call the attribute scroll
; routine once for every 8 calls of this routine.
SC_001:
  LD HL,16384
  LD B,3
SC_001_0:
  PUSH BC
  LD B,8
SC_001_1:
  PUSH BC
  LD B,7
SC_001_2:
  PUSH BC
  LD B,32
SC_001_3:
  PUSH HL
  LD DE,256
  ADD HL,DE
  POP DE
  LD A,(HL)
  LD (DE),A
  EX DE,HL
  INC HL
  DJNZ SC_001_3
  LD DE,224
  ADD HL,DE
  POP BC
  DJNZ SC_001_2
  POP BC
  LD A,B
  CP 1
  JR Z,SC_001_5
  PUSH BC
  LD B,32
SC_001_4:
  LD DE,1760
  PUSH HL
  AND A
  SBC HL,DE
  POP DE
  LD A,(HL)
  LD (DE),A
  EX DE,HL
  INC HL
  DJNZ SC_001_4
  LD DE,1792
  AND A
  SBC HL,DE
  POP BC
  DJNZ SC_001_1
SC_001_5:
  POP BC
  LD A,B
  CP 1
  JR Z,SC_001_7
  PUSH BC
  LD B,32
SC_001_6:
  LD DE,32
  PUSH HL
  ADD HL,DE
  POP DE
  LD A,(HL)
  LD (DE),A
  EX DE,HL
  INC HL
  DJNZ SC_001_6
  POP BC
  DJNZ SC_001_0
SC_001_7:
  LD B,32
SC_001_8:
  LD (HL),0
  INC HL
  DJNZ SC_001_8
  RET


; PIXEL DOWN-SCROLL
SC_002:
  LD HL,22527
  LD B,3
SC_002_0:
  PUSH BC
  LD B,8
SC_002_1:
  PUSH BC
  LD B,7
SC_002_2:
  PUSH BC
  LD B,32
SC_002_3:
  PUSH HL
  LD DE,256
  AND A
  SBC HL,DE
  POP DE
  LD A,(HL)
  LD (DE),A
  EX DE,HL
  DEC HL
  DJNZ SC_002_3
  LD DE,224
  AND A
  SBC HL,DE
  POP BC
  DJNZ SC_002_2
  POP BC
  LD A,B
  CP 1
  JR Z,SC_002_5
  PUSH BC
  LD B,32
SC_002_4:
  LD DE,1760
  PUSH HL
  ADD HL,DE
  POP DE
  LD A,(HL)
  LD (DE),A
  EX DE,HL
  DEC HL
  DJNZ SC_002_4
  LD DE,1792
  ADD HL,DE
  POP BC
  DJNZ SC_002_1
SC_002_5:
  POP BC
  LD A,B
  CP 1
  JR Z,64188
  PUSH BC
  LD B,32
SC_002_6:
  LD DE,32
  PUSH HL
  AND A
  SBC HL,DE
  POP DE
  LD A,(HL)
  LD (DE),A
  EX DE,HL
  DEC HL
  DJNZ SC_002_6
  POP BC
  DJNZ SC_002_0
  LD B,32
SC_002_7:
  LD (HL),0
  DEC HL
  DJNZ SC_002_7
  RET


; MEMORY AVAILABLE
;
; This routine, called by PRINT USR start address, prints out the free memory
; in bytes available to BASIC ( ie, the distance  from the top of the variables
; area to the bottom of the machine stack growing downwards from RAMTOP ).
;
; A way of saving a BASIC program as code is as follows.
;
; Find out the memory available, say M, using this routine.
;
; Find RAMTOP by calculating PEEK 23730 + 256*PEEK 23731: say it is R.
;
; Now if you enter POKE 23637, PEEK 23635: POKE 23638, PEEK 23636, SAVE Name$
; CODE 23552,R-M-23552 you have saved the program  as  code.
;
; When loaded back the program will start at its first line.
SC_103:
  LD HL,0
  ADD HL,SP
  LD DE,(23653)
  AND A
  SBC HL,DE
  PUSH HL
  POP BC
  RET


; LOWER-CS PROGRAM
SC_097:
  LD HL,(23635)
SC_097_0:
  LD A,(HL)
  AND 192
  RET NZ
  INC HL
  INC HL
  INC HL
  INC HL
  LD C,0
SC_097_1:
  INC HL
  LD A,(HL)
  CALL 6326
  CP 34
  JR NZ,SC_097_2
  DEC C
SC_097_2:
  CP 58
  JR Z,SC_097_3
  CP 203
  JR NZ,SC_097_4
SC_097_3:
  BIT 0,C
  JR Z,SC_097_1
SC_097_4:
  CP 13
  JR Z,SC_097_5
  BIT 0,C
  JR NZ,SC_097_1
  CP 65
  JR C,SC_097_1
  CP 91
  JR NC,SC_097_1
  ADD A,32
  LD (HL),A
  JR SC_097_1
SC_097_5:
  INC HL
  JR SC_097_0
  NOP
  NOP
  NOP
  NOP
  NOP


; CHR$ LEFT-SCROLL
;
; These routines will scroll the screen one CHR$  square  in each direction,
; leaving the attributes unchanged.  Use  repeated calls to the address
; specified  in  III  to  scroll  as  far  as required. To scroll attributes
; call first the routine above, and then one of routines 37-40, after defining
; an  appropriate  box and setting the attribute value to 63. For a wraparound
; scroll, first POKE start address + 16  with  119.  To  scroll-off,  POKE
; start address + 16 with 54.
SC_006:
  LD B,192
  LD DE,16384
  PUSH DE
  POP HL
  INC HL
SC_006_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDIR
  DEC HL
  LD (HL),0
  INC HL
  INC HL
  INC DE
  POP BC
  DJNZ SC_006_0
  RET


; CHR$ TOP LEFT-SCROLL
SC_007:
  LD B,64
  LD DE,16384
  PUSH DE
  POP HL
  INC HL
SC_007_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDIR
  DEC HL
  LD (HL),A
  NOP
  INC HL
  INC HL
  INC DE
  POP BC
  DJNZ SC_007_0
  RET


; CHR$ MID LEFT-SCROLL
SC_008:
  LD B,64
  LD DE,18432
  PUSH DE
  POP HL
  INC HL
SC_008_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDIR
  DEC HL
  LD (HL),A
  NOP
  INC HL
  INC HL
  INC DE
  POP BC
  DJNZ SC_008_0
  RET


; CHR$ LOW LEFT-SCROLL
SC_009:
  LD B,64
  LD DE,20480
  PUSH DE
  POP HL
  INC HL
SC_009_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDIR
  DEC HL
  LD (HL),A
  NOP
  INC HL
  INC HL
  INC DE
  POP BC
  DJNZ SC_009_0
  RET


; CHR$ TOP/MID LEFT-SC
SC_010:
  LD B,128
  LD DE,16384
  PUSH DE
  POP HL
  INC HL
SC_010_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDIR
  DEC HL
  LD (HL),0
  INC HL
  INC HL
  INC DE
  POP BC
  DJNZ SC_010_0
  RET


; CHR$ MID/LOW LEFT-SC
SC_011:
  LD B,128
  LD DE,18432
  PUSH DE
  POP HL
  INC HL
SC_011_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDIR
  DEC HL
  LD (HL),A
  NOP
  INC HL
  INC HL
  INC DE
  POP BC
  DJNZ SC_011_0
  RET


; CHR$ RIGHT-SCROLL
SC_012:
  LD B,192
  LD DE,22527
  PUSH DE
  POP HL
  DEC HL
SC_012_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDDR
  INC HL
  LD (HL),0
  DEC HL
  DEC HL
  DEC DE
  POP BC
  DJNZ SC_012_0
  RET


; CHR$ TOP RIGHT-SCROL
SC_013:
  LD B,64
  LD DE,18431
  PUSH DE
  POP HL
  DEC HL
SC_013_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDDR
  INC HL
  LD (HL),A
  NOP
  DEC HL
  DEC HL
  DEC DE
  POP BC
  DJNZ SC_013_0
  RET


; CHR$ MID RIGHT-SCROL
SC_014:
  LD B,64
  LD DE,20479
  PUSH DE
  POP HL
  DEC HL
SC_014_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDDR
  INC HL
  LD (HL),A
  NOP
  DEC HL
  DEC HL
  DEC DE
  POP BC
  DJNZ SC_014_0
  RET


; CHR$ LOW RIGHT-SCROL
SC_015:
  LD B,64
  LD DE,22527
  PUSH DE
  POP HL
  DEC HL
SC_015_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDDR
  INC HL
  LD (HL),A
  NOP
  DEC HL
  DEC HL
  DEC DE
  POP BC
  DJNZ SC_015_0
  RET


; CHR$ TOP/MID RIGHT-S
SC_016:
  LD B,128
  LD DE,20479
  PUSH DE
  POP HL
  DEC HL
SC_016_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDDR
  INC HL
  LD (HL),A
  NOP
  DEC HL
  DEC HL
  DEC DE
  POP BC
  DJNZ SC_016_0
  RET


; CHR$ MID/LOW RIGHT-S
SC_017:
  LD B,128
  LD DE,22527
  PUSH DE
  POP HL
  DEC HL
SC_017_0:
  PUSH BC
  LD BC,31
  LD A,(DE)
  LDDR
  INC HL
  LD (HL),A
  NOP
  DEC HL
  DEC HL
  DEC DE
  POP BC
  DJNZ SC_017_0
  RET


; RIPPLE LEFT-SCROLL
;
; These four routines are all pixel scrolls affecting  the  screen but not the
; attributes. Ripple rotates each CHR$ about  its  own axis while Shutter
; scrolls-off each CHR$ square.
SC_018:
  LD HL,22527
SC_018_0:
  LD C,32
  AND A
SC_018_1:
  RLC (HL)
  DEC HL
  DEC C
  JR NZ,SC_018_1
  LD A,63
  CP H
  JR NZ,SC_018_0
  RET


; SHUTTER LEFT-SCROLL
SC_019:
  LD HL,22527
SC_019_0:
  LD C,32
  AND A
SC_019_1:
  SLA (HL)
  DEC HL
  DEC C
  JR NZ,SC_019_1
  LD A,63
  CP H
  JR NZ,SC_019_0
  RET


; RIPPLE RIGHT-SCROLL
SC_020:
  LD HL,16384
SC_020_0:
  LD C,32
  AND A
SC_020_1:
  RRC (HL)
  INC HL
  DEC C
  JR NZ,SC_020_1
  LD A,88
  CP H
  JR NZ,SC_020_0
  RET


; SHUTTER RIGHT-SCROLL
SC_021:
  LD HL,16384
SC_021_0:
  LD C,32
  AND A
SC_021_1:
  SRL (HL)
  INC HL
  DEC C
  JR NZ,SC_021_1
  LD A,88
  CP H
  JR NZ,SC_021_0
  RET


; UNI-NOTE SOUND-GEN
;
; This produces a programmable whistle.
;
; POKE start address + 1, frequency
;
; POKE start address + 2, span
;
; POKE start address + 4, duration
;
; POKE start address + 23, 28 (for up) or 29 (for doom)
SC_043:
  LD DE,25698
SC_043_0:
  LD H,50
  LD A,(23624)
  RRA
  RRA
  RRA
SC_043_1:
  LD C,254
  XOR 16
  OUT (C),A
  LD B,E
SC_043_2:
  DJNZ SC_043_2
  DEC H
  JR NZ,SC_043_1
  INC E
  DEC D
  JR NZ,SC_043_0
  RET


; DUAL-NOTE SOUND-GEN
;
; This provides two sound channels.
;
; POKE start address + 7, duration
;
; POKE start address + 18, frequency of first note
;
; POKE start address + 27, frequency of second note
SC_044:
  LD A,(23624)
  RRA
  RRA
  RRA
  LD B,240
  LD C,254
SC_044_0:
  DEC H
  JR NZ,SC_044_1
  XOR 16
  OUT (C),A
  LD H,238
SC_044_1:
  DEC L
  JR NZ,SC_044_0
  XOR 16
  OUT (C),A
  LD L,254
  DJNZ SC_044_0
  RET


; LINE RENUMBER
;
; A short routine for use where available  memory  is  scarce.
;
; It will not renumber GOTOs, GOBUBs etc unlike routine 60.
;
; POKE start address +5/+6, 2-byte  equivalent ’of  line  interval
;
; POKE start address +8/+9, 2-byte equivalent of the number of the first new
; line.
SC_061:
  DEFB 237,107,83,92
  LD BC,10
  LD DE,100
SC_061_0:
  PUSH DE
  PUSH HL
  LD DE,(23627)
  XOR A
  SBC HL,DE
  POP HL
  POP DE
  RET Z
  PUSH BC
  LD (HL),D
  INC HL
  LD (HL),E
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  ADD HL,BC
  EX DE,HL
  POP BC
  ADD HL,BC
  EX DE,HL
  JR SC_061_0


; SCREEN$ STORE
;
; Saves a screen in memory.
SC_025:
  LD DE,25650
  LD HL,16384
  LD BC,6912
  LDIR
  RET


; SCREEN$ OVERPRINT
;
; Erases the existing screen and prints the stored one.
SC_026:
  LD DE,8995
  LD HL,16384
  LD B,27
SC_026_0:
  PUSH BC
  LD B,0
SC_026_1:
  NOP
  NOP
  NOP
  LD A,(DE)
  NOP
  NOP
  NOP
  LD (HL),A
  INC HL
  INC DE
  NOP
  DJNZ SC_026_1
  POP BC
  DJNZ SC_026_0
  RET


; SCREEN$ EXCHANGE
;
; Swops the existing screen with the stored one.
;
; The three related routines (25,26,27) all use  a  screen  stored above
; RAMTOP, using 6912 bytes (24*32*8 pixels+24*32 attributes)
;
; It may be necessary to CLEAR a new  lower  RAMTOP.  To  store  a screen from
; X to X + 6911, you must POKE  start  address  +1/+2,2-byte equivalent of X.
;
; Incidentally, you can do a SCREEN$ COPY  (ie  dump)  to  printer with
; RANDOMIZE USR 3756.
SC_027:
  LD DE,7196
  LD HL,16384
  LD B,27
SC_027_0:
  PUSH BC
  LD B,0
SC_027_1:
  LD A,(HL)
  PUSH AF
  LD A,(DE)
  LD (HL),A
  POP AF
  LD (DE),A
  INC HL
  INC DE
  DJNZ SC_027_1
  POP BC
  DJNZ SC_027_0
  RET


; SCREEN$ INVERT
;
; Will invert the colours over the whole  screen  (ink  and  paper colours will
; change at each PRINT  position without disturbing the screen).
SC_028:
  LD HL,16384
  LD B,24
SC_028_0:
  PUSH BC
  LD B,0
SC_028_1:
  LD A,(HL)
  XOR 255
  LD (HL),A
  INC HL
  DJNZ SC_028_1
  POP BC
  DJNZ SC_028_0
  RET


; SCREEN$ FILL
;
; Will fill a box on the screen with any CHR$ code.
;
; POKE start address + 1, CHR$ code
;
; POKE start address + 3, box height in CHR$s
;
; POKE start address + 6, box width in CHR$s
;
; POKE start address +4/+7, PRINT  AT  coordinates  for  the  top left-hand
; corner of the box.
SC_024:
  LD C,64
  LD HL,783
  LD DE,282
  LD B,L
SC_024_0:
  PUSH DE
  PUSH BC
  LD B,E
SC_024_1:
  LD A,22
  RST 16
  LD A,H
  RST 16
  LD A,D
  RST 16
  LD A,C
  RST 16
  INC D
  DJNZ SC_024_1
  INC H
  POP BC
  POP DE
  DJNZ SC_024_0
  RET


; INK CHANGE
;
; Instantly changes the ink colour over the whole screen.
;
; POKE start address + 1, overall ink colour.
SC_030:
  LD A,2
  AND 7
  LD D,A
  LD HL,22528
  LD B,3
SC_030_0:
  PUSH BC
  LD B,0
SC_030_1:
  LD A,(HL)
  AND 248
  OR D
  LD (HL),A
  INC HL
  DJNZ SC_030_1
  POP BC
  DJNZ SC_030_0
  RET


; PAPER CHANGE
;
; As for ink change, but sets paper colour instead.
SC_031:
  LD A,7
  SLA A
  SLA A
  SLA A
  AND 56
  LD D,A
  LD HL,22528
  LD B,3
SC_031_0:
  PUSH BC
  LD B,0
SC_031_1:
  LD A,(HL)
  AND 199
  OR D
  LD (HL),A
  INC HL
  DJNZ SC_031_1
  POP BC
  DJNZ SC_031_0
  RET


; FLASH ON
;
; These four routines  change  the  specified  attribute  settings instantly
; over the whole screen. Contrast  these  with  routines 74-75.
SC_032:
  LD HL,22528
  LD B,3
SC_032_0:
  PUSH BC
  LD B,0
SC_032_1:
  SET 7,(HL)
  INC HL
  DJNZ SC_032_1
  POP BC
  DJNZ SC_032_0
  RET


; FLASH OFF
SC_033:
  LD HL,22528
  LD B,3
SC_033_0:
  PUSH BC
  LD B,0
SC_033_1:
  RES 7,(HL)
  INC HL
  DJNZ SC_033_1
  POP BC
  DJNZ SC_033_0
  RET


; BRIGHT ON
SC_034:
  LD HL,22528
  LD B,3
SC_034_0:
  PUSH BC
  LD B,0
SC_034_1:
  SET 6,(HL)
  INC HL
  DJNZ SC_034_1
  POP BC
  DJNZ SC_034_0
  RET


; BRIGHT OFF
SC_035:
  LD HL,22528
  LD B,3
SC_035_0:
  PUSH BC
  LD B,0
SC_035_1:
  RES 6,(HL)
  INC HL
  DJNZ SC_035_1
  POP BC
  DJNZ SC_035_0
  RET


; ATTR FILL
;
; For each of these a box can be defined in which  the  attributes will scroll.
;
; POKE start address + 1, new attribute value
;
; POKE start address +4/+3, PRINT AT coordinates of the  top  left hand corner
; of the box.
;
; POKE start address +6, box width in CHR$s
;
; POKE start address +7, box height in CHR$s
;
; On routine 39 wraparound can be achieved by POKE start address + 36, 26. To
; cancel, POKE start address + 36, 0.
;
; On routine 40 wraparound wan be achieved by POKE start address + 43, 26. To
; cancel, POKE start address + 43, 0.
SC_036:
  LD A,70
  LD BC,773
  LD DE,3609
  LD HL,22495
  PUSH DE
  LD DE,32
  INC B
SC_036_0:
  ADD HL,DE
  DJNZ SC_036_0
  LD B,C
  INC B
SC_036_1:
  INC HL
  DJNZ SC_036_1
  POP DE
  LD B,D
SC_036_2:
  PUSH HL
  LD C,B
  LD B,E
SC_036_3:
  LD (HL),A
  INC HL
  DJNZ SC_036_3
  POP HL
  PUSH DE
  LD DE,32
  ADD HL,DE
  POP DE
  LD B,C
  DJNZ SC_036_2
  RET


; ATTR UP-SCROLL
SC_037:
  LD A,96
  LD BC,772
  LD DE,3608
  LD HL,22495
  PUSH AF
  PUSH DE
  LD DE,32
  INC B
SC_037_0:
  ADD HL,DE
  DJNZ SC_037_0
  LD B,C
  INC B
SC_037_1:
  INC HL
  DJNZ SC_037_1
  POP DE
  LD B,D
  DEC B
SC_037_2:
  PUSH BC
  LD B,0
  LD C,E
  PUSH DE
  PUSH HL
  LD DE,32
  ADD HL,DE
  POP DE
  PUSH HL
  LDIR
  POP HL
  POP DE
  POP BC
  LD A,B
  DJNZ SC_037_2
  POP AF
  LD B,E
SC_037_3:
  LD (HL),A
  INC HL
  DJNZ SC_037_3
  RET


; ATTR DOWN-SCROLL
SC_038:
  LD A,186
  LD BC,1027
  LD DE,3862
  LD HL,22495
  DEC D
  PUSH AF
  LD A,B
  ADD A,D
  LD B,A
  LD A,C
  ADD A,E
  LD C,A
  PUSH DE
  LD DE,32
  INC B
SC_038_0:
  ADD HL,DE
  DJNZ SC_038_0
  LD B,C
SC_038_1:
  INC HL
  DJNZ SC_038_1
  POP DE
  LD B,D
SC_038_2:
  PUSH BC
  LD B,0
  LD C,E
  PUSH DE
  PUSH HL
  LD DE,32
  AND A
  SBC HL,DE
  POP DE
  PUSH HL
  LDDR
  POP HL
  POP DE
  POP BC
  LD A,B
  DJNZ SC_038_2
  POP AF
  LD B,E
SC_038_3:
  LD (HL),A
  DEC HL
  DJNZ SC_038_3
  RET


; ATTR RIGHT-SCROLL
SC_040:
  LD A,1
  LD BC,2051
  LD DE,3098
  LD HL,22495
  DEC D
  PUSH AF
  LD A,B
  ADD A,D
  LD B,A
  LD A,C
  ADD A,E
  LD C,A
  PUSH DE
  LD DE,32
  INC B
SC_040_0:
  ADD HL,DE
  DJNZ SC_040_0
  LD B,C
SC_040_1:
  INC HL
  DJNZ SC_040_1
  POP DE
  LD B,D
  INC B
  POP AF
SC_040_2:
  PUSH BC
  LD B,0
  LD C,E
  DEC C
  PUSH DE
  PUSH HL
  POP DE
  LD A,(DE)
  PUSH DE
  DEC HL
  LDDR
  LD (DE),A
  POP HL
  LD DE,32
  AND A
  SBC HL,DE
  POP DE
  POP BC
  DJNZ SC_040_2
  RET


; ATTR LEFT-SCROLL
SC_039:
  LD A,112
  LD BC,513
  LD DE,1821
  LD HL,22495
  PUSH AF
  PUSH DE
  LD DE,32
  INC B
SC_039_0:
  ADD HL,DE
  DJNZ SC_039_0
  LD B,C
  INC B
SC_039_1:
  INC HL
  DJNZ SC_039_1
  POP DE
  LD B,D
  POP AF
SC_039_2:
  PUSH BC
  LD B,0
  LD C,E
  DEC C
  PUSH DE
  PUSH HL
  POP DE
  NOP
  PUSH DE
  INC HL
  LDIR
  LD (DE),A
  POP HL
  LD DE,32
  ADD HL,DE
  POP DE
  POP BC
  DJNZ SC_039_2
  RET


; ATTR SWAP
;
; This routine will search the display  area  for  all  characters with a given
; attribute X, and replace these with a new attribute Y.
;
; POKE start address + 1, X
;
; POKE start address + 2, Y
;
; Refer to ATTR in the  index  of  the  Spectrum  manual  for  the explanation
; of the numbers to use, especially the explanation of the ATTR function
; itself.
SC_041:
  LD DE,28474
  LD BC,768
  LD HL,22528
SC_041_0:
  LD A,(HL)
  CP E
  JR NZ,SC_041_1
  LD (HL),D
SC_041_1:
  DEC BC
  INC HL
  LD A,B
  OR C
  JR NZ,SC_041_0
  RET


; SURE SAVE MDRVE
;
; Before attempting a save to microdrive, the Spectrum / Interface One does not
; check that sufficient memory is free for it to be able to open the necessary
; channels/maps.
;
; If free memory is scarce because of long programs or low RAMTOPs, the
; computer would crash (with loss of all data) when a SAVE* was  attempted.
;
; Call this routine before saving long programs to check whether there is
; sufficient space for a save to microdrive to be safe.
;
; If the routine returns with any message other than 0 OK, the SAVE* must NOT
; be attempted.
;
; Instead the program should be shortened and/or RAMTOP raised using CLEAR.
;
; TIPS (SC_111):
;
; 1) To check whether or not a  functional  ZX  Interface  One  is attached,
; see if an error is produced ohen an instruction  using the shadow ROM (like
; CLS #) is executed/attempted. This could be used in conjunction with 65 ON
; ERROR GOTO to trap the  error  in the  instance  when  no  Interface  One was
; attached.  If  the Interface One is present, this will also page in its
; shadow ROM.
;
; 2) To check whether an Interface One that is connected  is also paged in,
; enter PRINT PEEK 23635 + 256*PEEK 23636. If the answer is 23755, then the
; shadow ROM has not yet been paged in; if not, it has.
;
; 3) To chect whether a program just loaded came from tape or from microdrive,
; enter PRINT PEEK 23787 + 256*PEEK 23788. If the load was from a microdrive,
; the result printed should be the same  as that obtained using routine 104.
SC_110:
  RST 8
  DEFB 49
  LD BC,659
  JP 7941
  NOP
  NOP
  NOP
  NOP
  NOP


; RECORD SOUND
;
; These two non-relocatable routines require you  to  first  CLEAR 32767. Call
; the first routine once you  are  supplying  suitable sound input (from your
; tape recorder/hifi  system)  to  the  EAR input on your Spectrum.
;
; You have 5-10 seconds of recording time.
;
; Replay is achieved by calling the  second  routine,  which  will direct
; output both to  the  Spectrum  speaker  and  to  the  MIC socket, from where
; you can amplify the signal.  Experiment  with levels, input sources and
; sound/music types  to  optimise  sound quality, but expect  no  miracles.
; Routine  77  will  overwrite all RAM from 32768 to immediately below itself.
SC_077:
  DI
  LD HL,32768
SC_077_0:
  LD B,8
SC_077_1:
  IN A,(254)
  BIT 6,A
  JR NZ,SC_077_2
  SET 7,(HL)
SC_077_2:
  SRL (HL)
  DJNZ SC_077_1
  RRC (HL)
  INC HL
  LD A,H
  CP 254
  JR NZ,SC_077_0
  EI
  RET


; REPLAY SOUND
SC_078:
  DI
  LD HL,32768
SC_078_0:
  LD B,8
SC_078_1:
  BIT 0,(HL)
  JR Z,SC_078_2
  LD A,0
  OUT (254),A
SC_078_2:
  LD A,255
  OUT (254),A
  RLC (HL)
  DJNZ SC_078_1
  RLC (HL)
  INC HL
  LD A,H
  CP 254
  JR NZ,SC_078_0
  EI
  RET


; HEX INPUT
;
; For this routine to work routine 63 HEX->DEC CONVERTER must also be in
; memory. You enter data directly in hex and it is stored in memory where
; required. To quit, press Q.
;
; Note that if you  enter >2 hex digits only the last two will be evaluated.
;
; POKE start address +10/+11, 2-byte equivalent of the start address of
; HEX->DEC CONVERTER  ( default 60713, its current location in RAM )
;
; POKE 23563/4, address of the first byte of RAM  into  which  you wish to
; input hex
SC_092:
  CALL 3435
  LD A,2
  CALL 5633
  LD IX,SC_063
  LD (IX+109),201
  LD (IX+48),200
  XOR A
  LD (IX+49),A
  LD (IX+82),A
  LD (IX+83),A
  LD (IX+84),A
SC_092_0:
  LD BC,(23563)
  PUSH BC
  CALL 11563
  CALL 11747
  LD A,32
  RST 16
  POP BC
  PUSH BC
  INC BC
  LD (23563),BC
  CALL 124                ; trick for a relocatable program
  DEC SP
  DEC SP
  POP HL
  LD DE,16
  ADD HL,DE
  PUSH HL
  PUSH IX
  POP HL
  LD DE,8
  ADD HL,DE
  JP (HL)
  CP 81
  JR Z,SC_092_1
  POP HL
  LD BC,(23728)
  LD (HL),C
  JR SC_092_0
SC_092_1:
  LD (IX+109),24
  LD (IX+48),40
  LD (IX+49),61
  LD (IX+82),35
  LD (IX+83),237
  LD (IX+84),111
  JP 7088


; PIXEL LEFT-SCROLL
;
; Used for scrolling left or right one pixel. Use  as  routines  1 and 2. POKE
; start address + 13, with 55 (scroll-off) or with  63 (wraparound) or with 0
; (inverse scroll). Also see routines 22-23.
SC_004:
  LD HL,16384
  LD B,192
SC_004_0:
  PUSH BC
  LD B,31
  LD A,(HL)
  SLA A
  LD (HL),A
SC_004_1:
  INC HL
  LD A,(HL)
  SLA A
  LD (HL),A
  JR NC,SC_004_2
  DEC HL
  LD A,(HL)
  SET 0,A
  LD (HL),A
  INC HL
SC_004_2:
  DJNZ SC_004_1
  INC HL
  POP BC
  DJNZ SC_004_0
  RET


; PIXEL RIGHT-SCROLL
SC_005:
  LD HL,22527
  LD B,192
SC_005_0:
  PUSH BC
  LD B,31
  LD A,(HL)
  SRL A
  LD (HL),A
SC_005_1:
  DEC HL
  LD A,(HL)
  SRL A
  LD (HL),A
  JR NC,SC_005_2
  INC HL
  LD A,(HL)
  SET 7,A
  LD (HL),A
  DEC HL
SC_005_2:
  DJNZ SC_005_1
  DEC HL
  POP BC
  DJNZ SC_005_0
  RET


; LOWER UP-SCROLL
;
; This routine scrolls up the bottom X lines of the screen a  CHR$ square at a
; time, together with  the  attributes.  Compare  this routine with routines 3
; & 121.
;
; POKE start address + 1, X
SC_122:
  LD B,17
  CALL 3584
  RET
  NOP
  NOP
  NOP
  NOP

