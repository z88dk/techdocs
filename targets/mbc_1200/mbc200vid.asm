
; Sanyo MBC-200 video firmware (2nd Z80 CPU)

; BC is preserved to hold the current text position (C = column, B=fine grained 2 px row position)


  ORG $0000

; Routine at 0
;
; Used by the routine at L04FC.
L0000:
  DI
  LD SP,$4000
  LD A,$00
  LD ($3FA0),A
  LD A,$00
  LD ($3FA3),A
  LD ($3FA5),A
  LD HL,$3000
  LD ($3FA1),HL
  LD HL,$8000
  LD ($3FA6),HL		; Screen start address
  LD ($3FA8),HL		; Screen start address for scrolling
  LD A,$00
  LD ($3FAA),A
  LD ($3FAB),A
  LD ($3FAC),A

  LD B,14
  LD HL,CRTC_TABLE-1
CRTC_LOOP:
  INC HL
  DEC B
  LD A,B
  OUT ($B0),A
  LD A,(HL)
  OUT ($B1),A
  JR NZ,CRTC_LOOP

  CALL DO_CLS
  LD A,$90
  OUT ($73),A
  IN A,($72)
  OR $40
  OUT ($72),A
  JP L0078

; Routine at 74
;
; Used by the routine at L0000.
DO_CLS:
  LD HL,0
  ADD HL,SP
  EX DE,HL
  LD HL,0
  LD SP,HL
  LD BC,$0800
DO_CLS_0:
  PUSH HL
  PUSH HL
  PUSH HL
  PUSH HL
  PUSH HL
  PUSH HL
  PUSH HL
  PUSH HL
  DEC BC
  LD A,B
  OR C
  JP NZ,DO_CLS_0
  EX DE,HL
  LD SP,HL
  LD BC,0
  RET


; Data block at 106
CRTC_TABLE:
  DEFB $00   ; Horizontal Total
  DEFB $00   ; Horizontal Displayed
  DEFB $00   ; Horizontal Sync Position
  DEFB $20   ; Horizontal and Vertical Sync Widths
  DEFB $03   ; Vertical Total
  DEFB $02   ; Vertical Total Adjust
  DEFB $64   ; Vertical Displayed
  DEFB $64   ; Vertical Sync position
  DEFB $00   ; Interlace and Skew
  DEFB $68   ; Maximum Raster Address
  DEFB $4B   ; Cursor Start Raster
  DEFB $51   ; Cursor End Raster
  DEFB $50   ; Display Start Address (High)
  DEFB $65   ; Display Start Address (Low)



; Routine at 120
;
; Used by the routine at L0000.
L0078:
  LD HL,L0078             ; Loop on myself
  PUSH HL
  CALL L0586
  CALL GET_BYTE
  CP $20
  JR C,CONTROL_CODES
  JP CONSOLE_OUT

; Routine at 137
;
; Used by the routine at L0078.
CONTROL_CODES:
  LD HL,CTL_TABLE-2
; This entry point is used by the routine at IN_ESC.
CONTROL_CODES_0:
  PUSH BC
  LD C,A
CONTROL_CODES_1:
  INC HL
  INC HL
  LD A,(HL)
  INC HL
  OR A
  JR Z,CONTROL_CODES_2
  CP C
  JR NZ,CONTROL_CODES_1
  POP BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  JP (HL)
CONTROL_CODES_2:
  POP BC
  RET

; Routine at 160
IN_ESC:
  CALL GET_BYTE
  LD HL,ESC_TABLE-2
  JR CONTROL_CODES_0


; Data block at 168
CTL_TABLE:
  DEFB $07
  DEFW BEEP

  DEFB $08
  DEFW DO_BS

  DEFB $09
  DEFW DO_TAB

  DEFB $0A
  DEFW DO_LF

  DEFB $0D
  DEFW DO_CR

  DEFB $1A
  DEFW DO_CLS

  DEFB $1B
  DEFW IN_ESC

  DEFB $00



; Message at 190
ESC_TABLE:
  DEFM "Q"
  DEFW L03A0

  DEFM "K"
  DEFW L013D

  DEFM "A"
  DEFW LINES_40

  DEFM "F"
  DEFW L016F

  DEFM "C"
  DEFW L01C1

  DEFM "="
  DEFW SET_CURSOR

  DEFM "S"
  DEFW SET_PIXEL

  DEFM "R"
  DEFW RESET_PIXEL

  DEFM "T"
  DEFW CLEAR_EOL

  DEFM "I"
  DEFW INSERT_LINE

  DEFM "B"
  DEFW DELETE_LINE

  DEFM "L"
  DEFW LD_CUSTOM

  DEFM "J"
  DEFW JP_CUSTOM

  DEFM "G"
  DEFW L03C5

  DEFM "M"
  DEFW LINES_33

  DEFM "D"
  DEFW DISABLE

  DEFM "E"
  DEFW ENABLE

  DEFM "P"
  DEFW PLOT

  DEFM "H"
  DEFW HARDCOPY

  DEFM "N"
  DEFW L04C0

  DEFM "?"
  DEFW L04FC

  DEFM "t"
  DEFW L0101

  DEFB $00



; Routine at 257
L0101:
  CALL GET_BYTE
  PUSH AF
  AND $04
  JP NZ,L0127
  LD A,$00
  LD ($3FAA),A
; This entry point is used by the routine at L0127.
L0101_0:
  POP AF
  PUSH AF
  AND $02
  JP NZ,L012F
  LD A,$00
  LD ($3FAB),A
; This entry point is used by the routine at L012F.
L0101_1:
  POP AF
  AND $08
  JP NZ,L0137
  LD A,$00
  LD ($3FAC),A
  RET

; Routine at 295
;
; Used by the routine at L0101.
L0127:
  LD A,$01
  LD ($3FAA),A
  JP L0101_0

; Routine at 303
;
; Used by the routine at L0101.
L012F:
  LD A,$01
  LD ($3FAB),A
  JP L0101_1

; Routine at 311
;
; Used by the routine at L0101.
L0137:
  LD A,$01
  LD ($3FAC),A
  RET


; ESC 'K'

; Routine at 317
L013D:
  LD A,$80
  LD ($3FA0),A
  LD L,$0A
  JP SET_LINES_0


; ESC 'A'

; Routine at 327
LINES_40:
  LD A,($3FA0)
  LD H,A
  LD A,$01
  LD ($3FA0),A
  LD L,$05
  CALL SET_LINES_0
  LD A,H
  OR A
  RET Z
  RET P
  LD A,B
  ADD A,L
  LD B,A
  RET


; ESC 'M'

; Routine at 349
LINES_33:
  LD A,$00
  LD ($3FA0),A
  LD L,$06

; This entry point is used by the routines at L013D and LINES_40.
SET_LINES_0:
  XOR A
  SUB L
SET_LINES_1:
  ADD A,L
  CP B
  JR C,SET_LINES_1
  JR Z,SET_LINES_2
  SUB L
SET_LINES_2:
  LD B,A
  RET


; ESC 'F'

; Routine at 367
L016F:
  PUSH BC
  CALL GET_BYTE
  CP $FC
  JR NC,L016F_2
  LD H,$00
  LD L,A
  CALL MULT_X32
  LD DE,$2000
  ADD HL,DE

  LD A,$04
L016F_0:
  PUSH AF
  PUSH HL
  LD DE,$0004
  ADD HL,DE
  EX DE,HL
  POP HL

  LD A,$08
L016F_1:
  PUSH AF
  CALL GET_BYTE
  LD (HL),A
  INC HL
  EX DE,HL
  POP AF
  DEC A
  JR NZ,L016F_1

  EX DE,HL
  POP AF
  DEC A
  JR NZ,L016F_0

L016F_2:
  POP BC
  RET


; ESC 'L'
; Load custom code at $2000

; Routine at 415
LD_CUSTOM:
  PUSH BC
  CALL GET_BYTE
  LD H,A
  CALL GET_BYTE
  LD L,A
  EX DE,HL
  LD HL,$0F7F
  XOR A
  SBC HL,DE
  EX DE,HL
  JR C,LD_CUSTOM_1
  LD DE,$2000
LD_CUSTOM_0:
  CALL GET_BYTE
  LD (DE),A
  INC DE
  DEC HL
  LD A,H
  OR L
  JR NZ,LD_CUSTOM_0
LD_CUSTOM_1:
  POP BC
  RET


; ESC 'C'

; Routine at 449
L01C1:
  PUSH BC
  LD BC,0
  CALL VADDR_BC
  EX DE,HL
  LD B,50
  IN A,($70)
  AND $03
  XOR $03
  LD ($3FA4),A
  JR Z,L01DC
  CP $01
  JR Z,L01E7
  POP BC
  RET

; Routine at 476
;
; Used by the routine at L01C1.
L01DC:
  LD IX,L02DE
  LD C,$01
  CALL L01F2
  POP BC
  RET

; Routine at 487
;
; Used by the routine at L01C1.
L01E7:
  LD IX,L02EB
  LD C,$02
  CALL L01F2
  POP BC
  RET

; Routine at 498
;
; Used by the routines at L01DC and L01E7.
L01F2:
  PUSH HL
  PUSH BC
  CALL L0240
  LD D,80
L01F2_0:
  PUSH DE
  CALL L02C7
  CALL L021D
  CALL L0256
  LD DE,$0004
  CALL L02D8
  POP DE
  DEC D
  JR NZ,L01F2_0
  LD A,$0A
  CALL L098D
  POP BC
  POP HL
  LD DE,$0280
  CALL L02D8
  DJNZ L01F2
  RET

; Routine at 541
;
; Used by the routine at L01F2.
L021D:
  PUSH HL
  PUSH BC
  LD IY,$3F80
  CALL L027C
  LD D,$08
  LD A,($3FA4)
  OR A
  JR NZ,L0233
  CALL L027C_0
  JR L0233_0

; Routine at 563
;
; Used by the routine at L021D.
L0233:
  PUSH BC
  LD BC,$0008
  ADD IY,BC
  POP BC
  CALL L027C
; This entry point is used by the routine at L021D.
L0233_0:
  POP BC
  POP HL
  RET

; Routine at 576
;
; Used by the routine at L01F2.
L0240:
  PUSH BC
  PUSH IX
  LD B,(IX+$00)
  INC IX
L0240_0:
  LD A,(IX+$00)
  CALL L098D
  INC IX
  DJNZ L0240_0
  POP IX
  POP BC
  RET

; Routine at 598
;
; Used by the routine at L01F2.
L0256:
  PUSH HL
  PUSH BC
  LD B,$08
  LD HL,$3F80
  LD DE,$0008
L0256_0:
  PUSH BC
  PUSH HL
L0256_1:
  LD A,(HL)
  CALL L098D
  ADD HL,DE
  DEC C
  JR NZ,L0256_1
  LD A,($3FA4)
  OR A
  JR Z,L0256_2
  XOR A
  CALL L098D
L0256_2:
  POP HL
  INC HL
  POP BC
  DJNZ L0256_0
  POP BC
  POP HL
  RET

; Routine at 636
;
; Used by the routines at L021D and L0233.
L027C:
  LD D,$80
; This entry point is used by the routine at L021D.
L027C_0:
  PUSH IY
  PUSH BC
  PUSH HL
  LD E,$04
L027C_1:
  PUSH IY
  LD C,(HL)
  LD B,$08
L027C_2:
  LD A,C
  RLCA
  LD C,A
  JR NC,L027C_3
  LD A,D
  OR (IY+$00)
  LD (IY+$00),A
  LD A,($3FA4)
  OR A
  JR Z,L027C_3
  LD A,D
  RRCA
  OR (IY+$00)
  LD (IY+$00),A
L027C_3:
  INC IY
  DJNZ L027C_2
  POP IY
  INC HL
  CALL L02D8_0
  LD A,D
  RRCA
  LD D,A
  LD A,($3FA4)
  OR A
  JR Z,L027C_4
  LD A,D
  RRCA
  LD D,A
L027C_4:
  DEC E
  JR NZ,L027C_1
  POP HL
  LD DE,80*4
  CALL L02D8
  POP BC
  POP IY
  RET

; Routine at 711
;
; Used by the routine at L01F2.
L02C7:
  PUSH BC
  LD IY,$3F80
  XOR A
  LD B,$20
L02C7_0:
  LD (IY+$00),A
  INC IY
  DJNZ L02C7_0
  POP BC
  RET

; Routine at 728
;
; Used by the routines at L01F2 and L027C.
L02D8:
  ADD HL,DE
; This entry point is used by the routine at L027C.
L02D8_0:
  LD A,H
  OR $80
  LD H,A
  RET

; Routine at 734
L02DE:
  DEFB 12
  DEFB 0x1b,0x47,0x1b,0x25,0x39,0x0e,0x1b,0x25,0x32,0x02,0x80

L02EB:
 DEFB 8
 DEFB 0x0d,0x1b,0x41,0x10,0x1b,0x4b,0x80,0x02 


; ESC 'S'

SET_PIXEL:
  PUSH BC
  CALL GET_2WORDS
  CALL PIXEL_ON
  POP BC
  RET

; Routine at 765
;
; Used by the routines at L02DE and L04AC.
PIXEL_ON:
  CALL PIXEL_ADDR
  RET C
  OR (HL)
  LD (HL),A
  RET


; ESC 'R' - Reset Pixel

; Routine at 772
RESET_PIXEL:
  PUSH BC
  CALL GET_2WORDS
  CALL PIXEL_OFF
  POP BC
; This entry point is used by the routine at L02DE.
RESET_PIXEL_0:
  RET

; Routine at 781
;
; Used by the routines at RESET_PIXEL and L04AC.
PIXEL_OFF:
  CALL PIXEL_ADDR
  RET C
  CPL
  AND (HL)
  LD (HL),A
  RET

; Routine at 789
;
; Used by the routines at L02DE and RESET_PIXEL.
GET_2WORDS:
  CALL GET_BYTE
  LD D,A
  CALL GET_BYTE
  LD E,A
  PUSH DE
  CALL GET_BYTE
  LD D,A
  CALL GET_BYTE
  LD E,A
  PUSH DE
  POP BC
  POP DE
  RET


; ESC '='
; Set cursor position

; BC holds the current text position (C = column, B=fine grained 2 px row position)

; Routine at 810
SET_CURSOR:
  PUSH BC
  CALL GET_BYTE
  SUB 32
  JR C,POPRET
  LD D,A
  CALL GET_BYTE
  SUB 32
  JR C,POPRET
  LD C,A
  LD B,D
  CP 80              ; the column range is always 80
  JR NC,POPRET

  CALL CK_LINEMODE   ; get the current text mode
  JR Z,L0356         ; 33 rows, multiply by (400/33/2)
  JP P,L035E         ; 40 rows, multiply by (400/40/2)
  LD A,B
  CP 20              ;
  JR NC,POPRET
  LD A,B
  ADD A,A            ; Multiply by 10

; This entry point is used by the routine at L0356.
SET_CURSOR_0:
  ADD A,A
  ADD A,A
  ADD A,B
  ADD A,B

; This entry point is used by the routine at L035E.
SET_CURSOR_1:
  LD B,A
  POP AF
  RET

; Routine at 854
;
; Used by the routine at SET_CURSOR.
L0356:
  LD A,B
  CP 33
  JR NC,POPRET
  LD A,B
  JR SET_CURSOR_0         ; Multiply by 6

; Routine at 862
;
; Used by the routine at SET_CURSOR.
L035E:
  LD A,B
  CP 40
  JR NC,POPRET
  LD A,B
  ADD A,A            ; Multiply by 5
  ADD A,A
  ADD A,B
  JR SET_CURSOR_1

; Routine at 873
;
; Used by the routines at SET_CURSOR, L0356 and L035E.
POPRET:
  POP BC
  RET


; ESC 'T'
; clear text up to end of the current line

; Routine at 875
CLEAR_EOL:
  PUSH BC
  CALL CK_LINEMODE
  JR Z,CLEAR_EOL_33
  JP P,CLEAR_EOL_40
  LD H,$0A
  JR CLEAR_EOL_SUB

; Routine at 888
;
; Used by the routine at CLEAR_EOL.
CLEAR_EOL_33:
  LD H,$06
  JR CLEAR_EOL_SUB

; Routine at 892
;
; Used by the routine at CLEAR_EOL.
CLEAR_EOL_40:
  LD H,$05
; This entry point is used by the routines at CLEAR_EOL, CLEAR_EOL_33 and L06B2.
CLEAR_EOL_SUB:
  CALL L0383
  POP BC
  RET

; Routine at 899
;
; Used by the routines at CLEAR_EOL_40 and L05D7.
L0383:
  PUSH BC
L0383_0:
  CALL VADDR_BC
  XOR A
  LD (DE),A
  INC DE
  LD (DE),A
  INC C
  LD A,C
  CP 80
  JR C,L0383_0
  POP BC
  INC B
  DEC H
  JR NZ,L0383
  RET


; ESC 'J'
; Jump to custom code at $2000

; Routine at 919
JP_CUSTOM:
  CALL GET_BYTE
  CP 'P'		; ESC "JP" ?
  RET NZ
  JP $2000


; ESC 'Q'

; Routine at 928
L03A0:
  LD D,$00
  CALL CK_LINEMODE
  JR Z,L03AE
  JP P,L03B2
  LD E,$0A
  JR L03B2_0

; Routine at 942
;
; Used by the routine at L03A0.
L03AE:
  LD E,$06
  JR L03B2_0

; Routine at 946
;
; Used by the routine at L03A0.
L03B2:
  LD E,$05
; This entry point is used by the routines at L03A0 and L03AE.
L03B2_0:
  LD A,B
  OR A
L03B2_1:
  JR Z,L03B2_2
  INC D
  SUB E
  JR NC,L03B2_1
L03B2_2:
  LD A,D
  CALL SEND_BYTE
  LD A,C
  CALL SEND_BYTE
  RET


; ESC 'G'

; Routine at 965
L03C5:
  CALL GET_BYTE

  CP $FC
  RET NC

  PUSH BC
  PUSH AF
  LD A,($3FA0)
  CP $80			; Are we in 'K' mode ?
  JR NZ,L03E2		; No, exit

  POP AF
  LD H,$00
  LD L,A
  CALL MULT_X32
  LD DE,$2000
  ADD HL,DE
  JP PUT_CHR_DBL


; Routine at 994
;
; Used by the routine at L03C5.
L03E2:
  POP AF
  POP BC
  RET

; Routine at 997
DISABLE:
  LD A,$00
; This entry point is used by the routine at ENABLE.
DISABLE_0:
  LD ($3FA5),A
  RET

; Routine at 1003
ENABLE:
  LD A,$FF
  JR DISABLE_0

; Routine at 1007
PLOT:
  CALL GET_BYTE
  SUB $30
  CP $01
  JR Z,PLOT_0
  CP $00
  RET NZ
PLOT_0:
  LD ($3F93),A
  PUSH BC
  LD HL,$3F81
  LD E,$04
PLOT_1:
  CALL GET_BYTE
  LD (HL),A
  CALL GET_BYTE
  DEC HL
  LD (HL),A
  INC HL
  INC HL
  INC HL
  DEC E
  JR NZ,PLOT_1
  LD DE,($3F80)
  LD HL,($3F84)
  CALL L049E
  LD ($3F88),HL
  LD ($3F8E),DE
  LD DE,($3F82)
  LD HL,($3F86)
  CALL L049E
  LD ($3F8A),HL
  LD ($3F90),DE
  LD DE,($3F88)
  LD HL,($3F8A)
  XOR A
  SBC HL,DE
  JR C,PLOT_2
  CPL
PLOT_2:
  LD ($3F92),A
  CALL L04AC
  LD HL,0
; This entry point is used by the routine at PLOT_5.
PLOT_3:
  LD ($3F8C),HL
  LD HL,($3F86)
  LD DE,($3F82)
  XOR A
  SBC HL,DE
  JR NZ,PLOT_4
  LD HL,($3F84)
  LD DE,($3F80)
  XOR A
  SBC HL,DE
  JP Z,PLOT_6
PLOT_4:
  LD HL,($3F8C)
  LD BC,($3F8A)
  LD DE,($3F88)
  XOR A
  SBC HL,BC
  LD A,($3F92)
  JR C,PLOT_5
  PUSH HL
  CALL L04AC
  LD HL,($3F8E)
  ADD HL,DE
  LD ($3F80),HL
  POP HL
  JR PLOT_3

; Routine at 1160
;
; Used by the routine at PLOT.
PLOT_5:
  ADD HL,DE
  ADD HL,BC
  PUSH HL
  CPL
  CALL L04AC
  LD HL,($3F90)
  ADD HL,BC
  LD ($3F82),HL
  POP HL
  JR PLOT_3

; Routine at 1177
;
; Used by the routine at PLOT.
PLOT_6:
  CALL L04AC
  POP BC
  RET

; Routine at 1182
;
; Used by the routine at PLOT.
L049E:
  XOR A
  SBC HL,DE
  LD DE,$0001
  RET NC
  EX DE,HL
  SBC HL,DE
  LD DE,$FFFF
  RET

; Routine at 1196
;
; Used by the routines at PLOT, PLOT_5 and PLOT_6.
L04AC:
  LD DE,($3F80)
  LD BC,($3F82)
  OR A
  RET NZ
  LD A,($3F93)
  OR A
  JP Z,PIXEL_ON
  JP PIXEL_OFF

; Routine at 1216
L04C0:
  LD DE,$7D00
  LD HL,($3FA6)      ; VIDEO MEMORY
L04C0_0:
  LD A,(HL)
  CPL
  LD (HL),A
  CALL INCHL_DECDE
  JR NZ,L04C0_0
  RET

; Routine at 1231
;
; Used by the routines at L04C0, HARDCOPY and L04F2.
INCHL_DECDE:
  INC HL
  LD A,H
  OR $80
  LD H,A
  DEC DE
  LD A,D
  OR E
  RET


; ESC 'H'

; Routine at 1240
HARDCOPY:
  CALL GET_BYTE
  LD HL,($3FA6)      ; VIDEO MEMORY
  LD DE,$7D00
  CP 'R'
  JR Z,L04F2
  CP 'T'
  RET NZ
HARDCOPY_0:
  CALL GET_BYTE
  LD (HL),A
  CALL INCHL_DECDE
  JR NZ,HARDCOPY_0
  RET

; Routine at 1266
;
; Used by the routine at HARDCOPY.
L04F2:
  LD A,(HL)
  CALL SEND_BYTE
  CALL INCHL_DECDE
  JR NZ,L04F2
  RET

; Routine at 1276
L04FC:
  JP L0000


; Routine at 1279
DO_TAB:
  LD A,C
  AND $F8            ; "square" the spacing
  ADD A,$08          ; move to the next TAB position
  LD C,A
  RET

; Routine at 1286
DO_LF:
  CALL CK_LINEMODE
  JR Z,L0513
  JP P,L0517
  LD A,$0A
; This entry point is used by the routines at L0513 and L0517.
DO_LF_0:
  ADD A,B
  LD B,A
  RET

; Routine at 1299
;
; Used by the routine at DO_LF.
L0513:
  LD A,$06
  JR DO_LF_0

; Routine at 1303
;
; Used by the routine at DO_LF.
L0517:
  LD A,$05
  JR DO_LF_0


; 

; Routine at 1307
DO_CR:
  XOR A
  LD C,A
  RET

; Routine at 1310
DO_BS:
  CALL CK_LINEMODE
  LD H,$01
  JP Z,DO_BS_33
  JP P,DO_BS_40
  LD H,$02
  LD L,$0A
  JR DO_BS_SUB

; Routine at 1327
;
; Used by the routine at DO_BS.
DO_BS_33:
  LD L,$06
  JR DO_BS_SUB

; Routine at 1331
;
; Used by the routine at DO_BS.
DO_BS_40:
  LD L,$05
; This entry point is used by the routines at DO_BS and DO_BS_33.
DO_BS_SUB:
  LD A,C
  SUB H
  JR NC,DO_BS_SUB_0
  ADD A,80
  LD D,B
  LD H,A
  LD A,B
  SUB L
  RET C
  LD B,A
  LD C,H
  RET

; Routine at 1346
;
; Used by the routine at DO_BS.
DO_BS_SUB_0:
  LD C,A
  RET


; CHR$ (7) - BEL

; Routine at 1348
BEEP:
  PUSH BC
  LD BC,L00FA
BEEP_0:
  IN A,($72)
  OR $10
  OUT ($72),A
  CALL DELAY_PERIOD
  IN A,($72)
  AND $EF
  OUT ($72),A
  CALL DELAY_PERIOD
  DEC BC
  LD A,B
  OR C
  JR NZ,BEEP_0
  POP BC
  RET

; Routine at 1377
;
; Used by the routine at BEEP.
DELAY_PERIOD:
  LD HL,$0099
DELAY_PERIOD_0:
  DEC HL
  LD A,L
  OR H
  JR NZ,DELAY_PERIOD_0
  RET

; Routine at 1386
;
; Used by the routine at L0078.
CONSOLE_OUT:
  PUSH AF
  CALL CK_LINEMODE
  JR NZ,L0574
  POP AF
  JP PRINT_33L

; Routine at 1396
;
; Used by the routine at CONSOLE_OUT.
L0574:
  JP P,L07FD
  POP AF
  CP $21
  RET C      ; Exit if not printable
  LD D,A
  CALL GET_BYTE
  CP $21      ; Exit if not printable
  RET C
  LD E,A
  JP L0700

; Routine at 1414
;
; Used by the routine at L0078.
L0586:
  CALL CK_LINEMODE
  JP Z,L0901
  JP P,L0818
  JP DO_CR


; ESC 'B'

; Routine at 1426
DELETE_LINE:
  PUSH BC
  LD C,$00
  CALL VADDR_BC
  CALL CK_LINEMODE
  JR Z,L05C1
  JP P,L05D7
  LD A,$BE           ; 190
  CP B
  JR Z,DELETE_LINE_0
  CALL L0644
  LD HL,$0640
  ADD HL,DE
  CALL L05B8
DELETE_LINE_0:
  LD A,$0A
  LD B,$BE           ; 190


; This entry point is used by the routines at L05C1, L05D7 and INSERT_LINE.
_BLANK_TXTROW:
  CALL BLANK_TXTROW         ; Put a blank text row
  POP BC
  RET

; Routine at 1464
;
; Used by the routines at DELETE_LINE and L05C1.
L05B8:
  CALL L063B
  LDI
  JP PE,L05B8
  RET

; Routine at 1473
;
; Used by the routine at DELETE_LINE.
L05C1:
  LD A,$C0           ; 192
  CP B
  JR Z,L05C1_0
  CALL L0644
  LD HL,$03C0        ; 192*5
  ADD HL,DE
  CALL L05B8
; This entry point is used by the routine at L0691.
L05C1_0:
  LD A,$08
  LD B,$C0           ; 192
  JP _BLANK_TXTROW

; Routine at 1495
;
; Used by the routines at DELETE_LINE and L0818.
L05D7:
  LD C,$00
  LD A,$C3           ; 195
  SUB B
  CALL NZ,L05EE
  LD H,$01
  LD BC,$C300        ; 195, 0
  CALL L0383
  LD A,$04
  LD B,$C4           ; 196
  JP _BLANK_TXTROW

; Routine at 1518
;
; Used by the routine at L05D7.
L05EE:
  PUSH AF
  PUSH BC
  CALL VADDR_BC
  LD A,B
  ADD A,$05
  LD B,A
  EX DE,HL
  CALL VADDR_BC
  EX DE,HL
  POP BC
  POP AF
  LD C,A
  LD A,B
  OR A
L05EE_0:
  JR Z,L0609
  SUB $0A
  JR C,L060A_0
  JR L05EE_0

; Routine at 1545
;
; Used by the routines at L05EE and L060A.
L0609:
  PUSH DE

; Routine at 1546
L060A:
  CALL L0627
  POP DE
  DEC C
  RET Z
  INC DE
  INC DE
  DEC HL
  DEC HL
  CALL L063B
; This entry point is used by the routine at L05EE.
L060A_0:
  PUSH HL
  CALL L0627
  POP HL
  DEC C
  RET Z
  INC HL
  INC HL
  DEC DE
  DEC DE
  CALL L063B
  JR L0609

; Routine at 1575
;
; Used by the routine at L060A.
L0627:
  PUSH BC
  LD BC,160
L0627_0:
  CALL L063B
  LDI
  LDI
  INC HL
  INC HL
  INC DE
  INC DE
  JP PE,L0627_0
  POP BC
  RET

; Routine at 1595
;
; Used by the routines at L05B8, L060A, L0627, L0688, L06C1 and L06EC.
L063B:
  LD A,H
  OR $80
  LD H,A
  LD A,D
  OR $80
  LD D,A
  RET

; Routine at 1604
;
; Used by the routines at DELETE_LINE, L05C1, INSERT_LINE and L0691.
L0644:
  PUSH DE
  PUSH HL
  SUB B
  LD L,A
  LD H,$00
  PUSH HL
  CALL MULT_X128
  EX (SP),HL
  CALL MULT_X32
  POP DE
  ADD HL,DE
  PUSH HL
  POP BC
  POP HL
  POP DE
  RET


; ESC 'I'

; Routine at 1625
INSERT_LINE:
  PUSH BC
  LD BC,$C800        ; 200,0
  CALL VADDR_BC
  DEC DE
  EX DE,HL
  POP BC
  PUSH BC
  CALL CK_LINEMODE
  JR Z,L0691
  JP P,L06B2
  LD A,$BE           ; 190
  CP B
  JR Z,INSERT_LINE_0
  CALL L0644
  PUSH BC
  LD BC,$BE00        ; 190,0
  CALL VADDR_BC
  DEC DE
  EX DE,HL
  POP BC
  CALL L0688
INSERT_LINE_0:
  LD A,$0A
; This entry point is used by the routine at L0691.
INSERT_LINE_1:
  POP BC
  PUSH BC
  JP _BLANK_TXTROW

; Routine at 1672
;
; Used by the routines at INSERT_LINE and L0691.
L0688:
  CALL L063B
  LDD
  JP PE,L0688
  RET

; Routine at 1681
;
; Used by the routine at INSERT_LINE.
L0691:
  LD A,$C0
  CP B
  JP Z,L05C1_0
  CALL L0644
  PUSH BC
  LD BC,$C000
  CALL VADDR_BC
  DEC DE
  EX DE,HL
  LD B,$C6
  CALL VADDR_BC
  DEC DE
  POP BC
  CALL L0688
  LD A,$06
  JP INSERT_LINE_1

; Routine at 1714
;
; Used by the routine at INSERT_LINE.
L06B2:
  LD A,$C3           ; 195
  SUB B
  CALL NZ,L06C1
  LD H,$05
  POP BC
  PUSH BC
  LD C,$00
  JP CLEAR_EOL_SUB

; Routine at 1729
;
; Used by the routine at L06B2.
L06C1:
  PUSH AF
  LD BC,$C400        ; 196, 0
  CALL VADDR_BC
  DEC DE
  DEC DE
  DEC DE
  EX DE,HL
  POP AF
  LD C,A
L06C1_0:
  CALL L063B
  PUSH DE
  CALL L06EC
  POP DE
  DEC C
  RET Z
  DEC DE
  DEC DE
  INC HL
  INC HL
  CALL L063B
  PUSH HL
  CALL L06EC
  POP HL
  DEC C
  RET Z
  DEC HL
  DEC HL
  INC DE
  INC DE
  JR L06C1_0

; Routine at 1772
;
; Used by the routine at L06C1.
L06EC:
  PUSH BC
  LD BC,160
L06EC_0:
  CALL L063B
  LDD
  LDD
  DEC HL
  DEC HL
  DEC DE
  DEC DE
  JP PE,L06EC_0
  POP BC
  RET

; Routine at 1792
;
; Used by the routine at L0574.
L0700:
  PUSH BC
  LD A,C
  CP 79           ; Got to the right margin ?
  JR NZ,L0700_0
  POP BC
  INC C           ; Move to next row
  CALL DO_CR
  PUSH BC
L0700_0:
  LD HL,L07B9
  LD B,$01
  CALL L078D_3
  JR NZ,L071F
  LD B,$08
  CALL L078D_3
  JR NZ,L071F_0
  POP BC
  RET

; Routine at 1823
;
; Used by the routine at L0700.
L071F:
  LD A,D
  ADD A,$08
  LD D,A
; This entry point is used by the routine at L0700.
L071F_0:
  LD A,D
  AND $0F
  LD D,A
  LD A,E
  AND $1F
  RLCA
  RLCA
  RLCA
  LD E,A
  SLA E
  RL D
  SLA E
  RL D
  LD HL,$4000
  ADD HL,DE
; This entry point is used by the routine at L03C5.
PUT_CHR_DBL:
  POP BC
  PUSH BC
  CALL BLANK_ROW_X4
  POP BC
  PUSH BC
  INC B

  LD A,$04
L071F_2:
  PUSH AF
  PUSH BC

  LD A,$02
L071F_3:
  PUSH AF
  PUSH BC
  LD A,$02			; 2*2 = 4 rows
  CALL PUT_CHR
  POP BC
  POP AF
  INC C
  DEC A
  JR NZ,L071F_3     ; *2 = 8 rows

  POP BC
  INC B
  INC B
  POP AF
  DEC A
  JR NZ,L071F_2     ; *2 = 16 rows

  CALL BLANK_ROW_X4      ; 4 + 4 + 16 = 24 rows total
  POP BC
  INC C
  INC C
  RET

; Routine at 1891
;
; Used by the routines at L071F and L07FD.
PUT_CHR:
  PUSH AF
  PUSH BC
  CALL VADDR_BC
  LDI
  LDI
  POP BC
  INC B
  POP AF
  DEC A
  JR NZ,PUT_CHR
  RET

; Routine at 1907
;
; Used by the routine at L071F.
BLANK_ROW_X4:
  PUSH HL
  PUSH BC
  CALL BLANK_ROW_X2
  POP BC
  INC C
  CALL BLANK_ROW_X2
  POP HL
  RET

; Routine at 1919
;
; Used by the routines at BLANK_ROW_X4 and L07FD.
BLANK_ROW_X2:
  LD L,$01
BLANK_ROW_X2_0:
  CALL VADDR_BC
  XOR A
  LD (DE),A
  INC DE
  LD (DE),A
  INC B
  DEC L
  JR NZ,BLANK_ROW_X2_0
  RET

; Routine at 1933
L078D:
  INC HL
L078D_0:
  INC HL
L078D_1:
  INC HL
L078D_2:
  INC HL
  INC HL
  DEC B
  RET Z

; This entry point is used by the routine at L0700.
L078D_3:
  LD A,D
  CP (HL)
  JR C,L078D
  INC HL
  CP (HL)
  JR NC,L078D_0
  INC HL
  LD A,E
  CP (HL)
  JR C,L078D_1
  INC HL
  CP (HL)
  JR NC,L078D_2
  INC HL
  IN A,($72)
  AND $F8
  OR (HL)
  OUT ($72),A
  XOR A
  CPL
  OR A
  RET

; Routine at 1969
;
; Used by the routine at L0644.
MULT_X128:
  ADD HL,HL

; Routine at 1970
;
; Used by the routine at BYTE_ADDR.
MULT_X64:
  ADD HL,HL

; Routine at 1971
;
; Used by the routines at L016F, L03C5 and L0644.
MULT_X32:
  ADD HL,HL

; Routine at 1972
;
; Used by the routine at BYTE_ADDR.
MULT_X16:
  ADD HL,HL

; Routine at 1973
;
; Used by the routine at CHR_MATRIX.
MULT_X8:
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  RET


; Data block at 1977
L07B9:
  DEFB $21,$28,$60,$7F, $00
  DEFB $21,$28,$21,$40, $00
  DEFB $21,$30,$40,$60, $01
  DEFB $30,$40,$21,$40, $02
  DEFB $30,$40,$40,$60, $03
  DEFB $30,$40,$60,$7F, $04
  DEFB $40,$50,$21,$40, $05
  DEFB $40,$50,$40,$60, $06
  DEFB $40,$50,$60,$7F, $07


; Routine at 2022
;
; Used by the routines at L0586 and L0700.
DO_CR:
  LD A,C
  CP 80
  JR C,DO_CR_0
  XOR A
  LD C,A
  LD A,$0A
  ADD A,B
  LD B,A
DO_CR_0:
  LD A,B
  CP $C8             ; 200
  RET C
  LD B,$BE           ; 190
  PUSH BC
  LD A,$05
  JP DO_SCROLL

; Routine at 2045
;
; Used by the routine at L0574.
L07FD:
  POP AF
  PUSH BC
  CALL CHR_MATRIX
  LD A,$04			; 4*2 = 8 rows
  CALL PUT_CHR
  CALL BLANK_ROW_X2 ; 10 rows total
  POP BC
  INC C
  RET

; Routine at 2061
;
; Used by the routines at L07FD and PRINT_33L.
CHR_MATRIX:
  LD L,A
  LD H,$00
  CALL MULT_X8
  LD DE,$1800		; FONT - ( ' ' * 8)
  ADD HL,DE
  RET

; Routine at 2072
;
; Used by the routine at L0586.
L0818:
  LD A,C
  CP 80
  JR C,L0818_0
  LD C,$00
  LD A,$05
  ADD A,B
  LD B,A
L0818_0:
  LD A,B
  CP $C8             ; 200
  RET C
  LD B,$C3           ; 195
  PUSH BC
  LD BC,0
  JP L05D7

; Output character in 33 rows mode
;
; Used by the routine at CONSOLE_OUT.
PRINT_33L:
  PUSH BC
  CALL CHR_MATRIX
  CALL VADDR_BC
  LD A,($3FAA)
  AND A
  JP Z,PRINT_33L_0
  LD A,$FF
  JP PRINT_33L_1

; Routine at 2115
;
; Used by the routine at PRINT_33L.
PRINT_33L_0:
  XOR A
; This entry point is used by the routine at PRINT_33L.
PRINT_33L_1:
  PUSH AF
  LD A,($3FAC)
  AND A
  JP Z,PRINT_33L_2
  POP AF
  CPL
  JP PRINT_33L_3

; Routine at 2129
;
; Used by the routine at PRINT_33L_0.
PRINT_33L_2:
  POP AF
; This entry point is used by the routine at PRINT_33L_0.
PRINT_33L_3:
  CALL L08FA
  LD (DE),A
  INC DE
  LD A,($3FAA)
  AND A
  JP Z,PRINT_33L_4
  LD A,$FF
PRINT_33L_4:
  CALL L08FA
  LD (DE),A
  INC DE
  CALL L08FA
  LD A,($3FAA)
  AND A
  JP Z,PRINT_33L_5
  LD A,(HL)
  CPL
  LD (DE),A
  INC DE
  INC HL
  LD A,(HL)
  CPL
  JP PRINT_33L_6

; Routine at 2169
;
; Used by the routine at PRINT_33L_2.
PRINT_33L_5:
  LD A,(HL)
  LD (DE),A
  INC DE
  INC HL
  LD A,(HL)
; This entry point is used by the routine at PRINT_33L_2.
PRINT_33L_6:
  CALL L08FA
  LD (DE),A
  INC HL
  EX DE,HL
  LD BC,L013D
  ADD HL,BC
  EX DE,HL
  LD BC,$0004
  CALL L08DA
  EX DE,HL
  LD BC,$013C
  ADD HL,BC
  EX DE,HL
  LD BC,$0002
  CALL L08DA
  LD A,($3FAA)
  AND A
  JP NZ,PRINT_33L_7
  XOR A
  JP PRINT_33L_8

; Routine at 2214
;
; Used by the routine at PRINT_33L_5.
PRINT_33L_7:
  LD A,$FF
; This entry point is used by the routine at PRINT_33L_5.
PRINT_33L_8:
  CALL L08FA
  LD (DE),A
  INC DE
  LD A,($3FAA)
  AND A
  JP NZ,PRINT_33L_10
  LD A,($3FAB)
  AND A
  JP NZ,PRINT_33L_9
  LD A,$00
  JP PRINT_33L_12

; Routine at 2240
;
; Used by the routine at PRINT_33L_7.
PRINT_33L_9:
  LD A,$FF
  JP PRINT_33L_12

; Routine at 2245
;
; Used by the routine at PRINT_33L_7.
PRINT_33L_10:
  LD A,($3FAB)
  AND A
  JP Z,PRINT_33L_11
  LD A,$00
  JP PRINT_33L_12

; Routine at 2257
;
; Used by the routine at PRINT_33L_10.
PRINT_33L_11:
  LD A,$FF
; This entry point is used by the routines at PRINT_33L_7, PRINT_33L_9 and PRINT_33L_10.
PRINT_33L_12:
  CALL L08FA
  LD (DE),A
  POP BC
  INC C
  RET

; Routine at 2266
;
; Used by the routine at PRINT_33L_5.
L08DA:
  LD A,($3FAA)
  AND A
  JP NZ,L08ED
L08DA_0:
  CALL L08FA
  LD A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,L08DA_0
  RET

; Routine at 2285
;
; Used by the routine at L08DA.
L08ED:
  CALL L08FA
  LD A,(HL)
  CPL
  LD (DE),A
  INC HL
  INC DE
  DEC C
  JP NZ,L08ED
  RET

; Routine at 2298
;
; Used by the routines at PRINT_33L_2, PRINT_33L_5, PRINT_33L_7, PRINT_33L_11, L08DA and L08ED.
L08FA:
  PUSH AF
  LD A,D
  OR $80
  LD D,A
  POP AF
  RET

; Routine at 2305
;
; Used by the routine at L0586.
L0901:
  LD A,C
  CP 80
  JR C,L0901_0
  LD C,$00
  LD A,$06
  ADD A,B
  LD B,A
L0901_0:
  LD A,B
  CP $C6             ; 198
  RET C
  LD B,$C0
  PUSH BC
  LD A,$03
  JP DO_SCROLL

; Routine at 2328
;
; Used by the routine at L0A07.
L0918:
  PUSH HL
  PUSH BC
  JR VADDR_BC_0

; Routine at 2332
;
; Used by the routines at L01C1, L0383, DELETE_LINE, L05EE, INSERT_LINE, L0691, L06C1,
; PUT_CHR, BLANK_ROW_X2, PRINT_33L and BLANK_TXTROW.
VADDR_BC:
  PUSH HL
  PUSH BC
  LD H,$00
  LD L,B
  ADD HL,HL
; This entry point is used by the routine at L0918.
VADDR_BC_0:
  EX DE,HL
  LD H,$00
  LD L,C
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  PUSH HL
  POP BC
  CALL BYTE_ADDR
  EX DE,HL
  POP BC
  POP HL
  RET

; Routine at 2354
;
; Used by the routines at PIXEL_ON and PIXEL_OFF.
PIXEL_ADDR:
  LD HL,399
  XOR A
  SBC HL,DE
  RET C
  LD HL,639
  XOR A
  SBC HL,BC
  RET C
  PUSH DE
  PUSH BC
  CALL BYTE_ADDR
  LD A,C
  AND $07
  LD B,A
  LD A,$80
  JR Z,PIXEL_ADDR_1
PIXEL_ADDR_0:
  RRCA
  DJNZ PIXEL_ADDR_0
PIXEL_ADDR_1:
  POP BC
  POP DE
  OR A
  RET

; Routine at 2388
;
; Used by the routines at VADDR_BC and PIXEL_ADDR.
BYTE_ADDR:
  LD HL,$FFFC
  LD A,L
  AND E
  LD L,A
  LD A,H
  AND D
  LD H,A
  PUSH DE
  PUSH HL
  CALL MULT_X64
  EX (SP),HL
  CALL MULT_X16   ; *400
  POP DE
  ADD HL,DE
  POP DE
  PUSH HL
  LD HL,$0003
  LD A,L
  AND E
  LD L,A
  POP DE
  ADD HL,DE
  PUSH HL
  LD HL,$FFF8
  LD A,L
  AND C
  LD L,A
  LD A,H
  AND B
  LD H,A
  SRL H
  RR L
  EX DE,HL
  POP HL
  ADD HL,DE
  LD DE,($3FA6)      ; VIDEO MEMORY
  ADD HL,DE
  LD A,H
  OR $80
  LD H,A
  RET

; Routine at 2445
;
; Used by the routines at L01F2, L0240, L0256 and L09B7.
L098D:
  PUSH AF
L098D_0:
  IN A,($70)
  AND $1C
  XOR $14
  JR NZ,L098D_0
  POP AF
  PUSH AF
  OUT ($71),A
  IN A,($72)
  OR $80
  OUT ($72),A
  AND $7F
  OUT ($72),A
  POP AF
  RET

; Routine at 2470
;
; Used by the routines at L0078, IN_ESC, L0101, L016F, LD_CUSTOM, GET_2WORDS,
; SET_CURSOR, JP_CUSTOM, L03C5, PLOT, HARDCOPY and L0574.
GET_BYTE:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL L09ED
; This entry point is used by the routine at L09B7.
GET_BYTE_0:
  IN A,($70)
  AND $80
  JR Z,L09B7
; This entry point is used by the routine at L09B7.
GET_BYTE_1:
  CALL L0A20
  JR GET_BYTE_0

; Routine at 2487
;
; Used by the routine at GET_BYTE.
L09B7:
  IN A,($70)
  AND $20
  JR Z,L09B7_0
  IN A,($70)
  AND $1C
  XOR $14
  JR NZ,GET_BYTE_1
L09B7_0:
  CALL L0A52
  JR NZ,L09B7_1
  LD (HL),C
L09B7_1:
  IN A,($70)
  AND $20
  JR Z,L09D8
  IN A,($D0)
  CALL L098D
  JR GET_BYTE_0

; Routine at 2520
;
; Used by the routine at L09B7.
L09D8:
  IN A,($D0)
  POP BC
  POP DE
  POP HL
  RET

; Routine at 2526
;
; Used by the routines at L03B2 and L04F2.
SEND_BYTE:
  PUSH BC
  PUSH AF
SEND_BYTE_0:
  IN A,($70)
  AND $C0
  XOR $80
  JR NZ,SEND_BYTE_0
  POP AF
  OUT ($D0),A
  POP BC
  RET

; Routine at 2541
;
; Used by the routine at GET_BYTE.
L09ED:
  CALL L0A52
  RET NZ
  LD L,B
  LD H,$00
  ADD HL,HL
  CALL CK_LINEMODE
  JR Z,L0A02
  JP P,L0A07
  LD DE,$0012
  JR L0A07_0

; Routine at 2562
;
; Used by the routine at L09ED.
L0A02:
  LD DE,$000C
  JR L0A07_0

; Routine at 2567
;
; Used by the routine at L09ED.
L0A07:
  LD DE,$0008
; This entry point is used by the routines at L09ED and L0A02.
L0A07_0:
  ADD HL,DE
  CALL L0918
  LD HL,($3FA1)
  EX DE,HL
  LD C,(HL)
  LD A,($3FA3)
  OR A
  JR NZ,L0A1D
  LD A,$FF
  LD (HL),A
  RET

; Routine at 2589
;
; Used by the routine at L0A07.
L0A1D:
  XOR A
  LD (HL),A
  RET

; Routine at 2592
;
; Used by the routine at GET_BYTE.
L0A20:
  CALL L0A52
  RET NZ
  EX DE,HL
  DEC HL
  LD ($3FA1),HL
  EX DE,HL
  LD A,D
  OR E
  RET NZ
  LD A,($3FA3)
  OR A
  JR Z,L0A3D
  LD A,$00
  LD ($3FA3),A
  LD A,$FF
  LD (HL),A
  JR L0A3D_0

; Routine at 2621
;
; Used by the routine at L0A20.
L0A3D:
  LD A,$FF
  LD ($3FA3),A
  XOR A
  LD (HL),A
; This entry point is used by the routine at L0A20.
L0A3D_0:
  EX DE,HL
  LD HL,$3000
  LD ($3FA1),HL
  EX DE,HL
  RET

; Flag will be Z if 33 lines mode, otherwise it is 40 lines
;
; Used by the routines at SET_CURSOR, CLEAR_EOL, L03A0, DO_LF, DO_BS, CONSOLE_OUT, L0586,
; DELETE_LINE, INSERT_LINE and L09ED.
CK_LINEMODE:
  LD A,($3FA0)
  OR A
  RET

; Routine at 2642
;
; Used by the routines at L09B7, L09ED and L0A20.
L0A52:
  LD A,($3FA5)
  CP $00
  RET

; Routine at 2648
;
; Used by the routines at DO_CR and L0901.
DO_SCROLL:
  PUSH AF
  LD B,$C8           ; 200
  ADD A,A
  CP $06
  JR NZ,DO_SCROLL_0
  ADD A,$02
DO_SCROLL_0:
  CALL BLANK_TXTROW
  LD HL,($3FA8)      ; Screen start address for scrolling
  POP AF
  PUSH AF
  LD DE,80
DO_SCROLL_1:
  ADD HL,DE
  DEC A
  JR NZ,DO_SCROLL_1
  LD ($3FA8),HL
  LD A,12            ; Display Start Address (High)
  OUT ($B0),A
  LD A,H
  OUT ($B1),A
  LD A,13            ; Display Start Address (Low)
  OUT ($B0),A
  LD A,L
  OUT ($B1),A
  POP AF
  LD DE,80*4
  LD HL,($3FA6)      ; VIDEO MEMORY
DO_SCROLL_2:
  ADD HL,DE
  DEC A
  JR NZ,DO_SCROLL_2
  LD A,H
  OR $80
  LD H,A
  LD ($3FA6),HL      ; VIDEO MEMORY
  POP BC
  RET


; Put a blank row

; Routine at 2710
;
; Used by the routines at DELETE_LINE and DO_SCROLL.
BLANK_TXTROW:
  PUSH AF
  LD C,$00
  CALL VADDR_BC
  POP AF
BLANK_TXTROW_0:
  PUSH AF

  LD B,160           ; 2 pixel rows
BLANK_TXTROW_1:
  LD A,D
  OR $80
  LD D,A
  XOR A
  LD (DE),A
  INC DE
  DJNZ BLANK_TXTROW_1

  POP AF
  DEC A
  JR NZ,BLANK_TXTROW_0
  RET

; Data block at 2734
L0AAE:
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF

; Data block at 6400
FONT:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $08,$08,$08,$08,$00,$00,$08,$00
  DEFB $24,$24,$24,$00,$00,$00,$00,$00
  DEFB $24,$24,$7E,$24,$7E,$24,$24,$00
  DEFB $08,$1E,$28,$1C,$0A,$3C,$08,$00
  DEFB $00,$62,$64,$08,$10,$26,$46,$00
  DEFB $30,$48,$48,$30,$4A,$44,$3A,$00
  DEFB $04,$08,$10,$00,$00,$00,$00,$00
  DEFB $04,$08,$10,$10,$10,$08,$04,$00
  DEFB $20,$10,$08,$08,$08,$10,$20,$00
  DEFB $08,$2A,$1C,$3E,$1C,$2A,$08,$00
  DEFB $00,$08,$08,$3E,$08,$08,$00,$00
  DEFB $00,$00,$00,$00,$00,$08,$08,$10
  DEFB $00,$00,$00,$7E,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$18,$18,$00
  DEFB $00,$02,$04,$08,$10,$20,$40,$00
  DEFB $3C,$42,$46,$5A,$62,$42,$3C,$00
  DEFB $08,$18,$28,$08,$08,$08,$3E,$00
  DEFB $3C,$42,$02,$0C,$30,$40,$7E,$00
  DEFB $3C,$42,$02,$1C,$02,$42,$3C,$00
  DEFB $04,$0C,$14,$24,$7E,$04,$04,$00
  DEFB $7E,$40,$78,$04,$02,$44,$38,$00
  DEFB $1C,$20,$40,$7C,$42,$42,$3C,$00
  DEFB $7E,$42,$04,$08,$10,$10,$10,$00
  DEFB $3C,$42,$42,$3C,$42,$42,$3C,$00
  DEFB $3C,$42,$42,$3E,$02,$04,$38,$00
  DEFB $00,$00,$08,$00,$00,$08,$00,$00
  DEFB $00,$00,$08,$00,$00,$08,$08,$10
  DEFB $0E,$18,$30,$60,$30,$18,$0E,$00
  DEFB $00,$00,$7E,$00,$7E,$00,$00,$00
  DEFB $70,$18,$0C,$06,$0C,$18,$70,$00
  DEFB $3C,$42,$02,$0C,$10,$00,$10,$00
  DEFB $1C,$22,$4A,$56,$4C,$20,$1E,$00
  DEFB $18,$24,$42,$7E,$42,$42,$42,$00
  DEFB $7C,$22,$22,$3C,$22,$22,$7C,$00
  DEFB $1C,$22,$40,$40,$40,$22,$1C,$00
  DEFB $78,$24,$22,$22,$22,$24,$78,$00
  DEFB $7E,$40,$40,$78,$40,$40,$7E,$00
  DEFB $7E,$40,$40,$78,$40,$40,$40,$00
  DEFB $1C,$22,$40,$4E,$42,$22,$1C,$00
  DEFB $42,$42,$42,$7E,$42,$42,$42,$00
  DEFB $1C,$08,$08,$08,$08,$08,$1C,$00
  DEFB $0E,$04,$04,$04,$04,$44,$38,$00
  DEFB $42,$44,$48,$70,$48,$44,$42,$00
  DEFB $40,$40,$40,$40,$40,$40,$7E,$00
  DEFB $42,$66,$5A,$5A,$42,$42,$42,$00
  DEFB $42,$62,$52,$4A,$46,$42,$42,$00
  DEFB $3C,$42,$42,$42,$42,$42,$3C,$00
  DEFB $7C,$42,$42,$7C,$40,$40,$40,$00
  DEFB $18,$24,$42,$42,$4A,$24,$1A,$00
  DEFB $7C,$42,$42,$7C,$48,$44,$42,$00
  DEFB $3C,$42,$40,$3C,$02,$42,$3C,$00
  DEFB $3E,$08,$08,$08,$08,$08,$08,$00
  DEFB $42,$42,$42,$42,$42,$42,$3C,$00
  DEFB $42,$42,$42,$24,$24,$18,$18,$00
  DEFB $42,$42,$42,$5A,$5A,$66,$42,$00
  DEFB $42,$42,$24,$18,$24,$42,$42,$00
  DEFB $22,$22,$22,$1C,$08,$08,$08,$00
  DEFB $7E,$02,$04,$18,$20,$40,$7E,$00
  DEFB $3C,$20,$20,$20,$20,$20,$3C,$00
  DEFB $00,$40,$20,$10,$08,$04,$02,$00
  DEFB $3C,$04,$04,$04,$04,$04,$3C,$00
  DEFB $08,$14,$22,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$7E,$00
  DEFB $10,$08,$04,$00,$00,$00,$00,$00
  DEFB $00,$00,$3C,$04,$3C,$44,$3A,$00
  DEFB $40,$40,$5C,$62,$42,$62,$5C,$00
  DEFB $00,$00,$3C,$42,$40,$42,$3C,$00
  DEFB $02,$02,$3A,$46,$42,$46,$3A,$00
  DEFB $00,$00,$3C,$42,$7E,$40,$3C,$00
  DEFB $0C,$12,$10,$7C,$10,$10,$10,$00
  DEFB $00,$00,$3A,$46,$46,$3A,$02,$3C
  DEFB $40,$40,$5C,$62,$42,$42,$42,$00
  DEFB $08,$00,$18,$08,$08,$08,$1C,$00
  DEFB $04,$00,$0C,$04,$04,$04,$44,$38
  DEFB $40,$40,$44,$48,$50,$68,$44,$00
  DEFB $18,$08,$08,$08,$08,$08,$1C,$00
  DEFB $00,$00,$76,$49,$49,$49,$49,$00
  DEFB $00,$00,$5C,$62,$42,$42,$42,$00
  DEFB $00,$00,$3C,$42,$42,$42,$3C,$00
  DEFB $00,$00,$5C,$62,$62,$5C,$40,$40
  DEFB $00,$00,$3A,$46,$46,$3A,$02,$02
  DEFB $00,$00,$5C,$62,$40,$40,$40,$00
  DEFB $00,$00,$3E,$40,$3C,$02,$7C,$00
  DEFB $10,$10,$7C,$10,$10,$12,$0C,$00
  DEFB $00,$00,$42,$42,$42,$46,$3A,$00
  DEFB $00,$00,$42,$42,$42,$24,$18,$00
  DEFB $00,$00,$41,$49,$49,$49,$36,$00
  DEFB $00,$00,$42,$24,$18,$24,$42,$00
  DEFB $00,$00,$42,$42,$46,$3A,$02,$3C
  DEFB $00,$00,$7E,$04,$18,$20,$7E,$00
  DEFB $0E,$10,$10,$20,$10,$10,$0E,$00
  DEFB $08,$08,$00,$00,$00,$08,$08,$00
  DEFB $70,$08,$08,$04,$08,$08,$70,$00
  DEFB $30,$49,$06,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$FF
  DEFB $00,$00,$00,$00,$00,$00,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$00,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $80,$80,$80,$80,$80,$80,$80,$80
  DEFB $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
  DEFB $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0
  DEFB $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
  DEFB $F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8
  DEFB $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
  DEFB $FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $F0,$F0,$0F,$0F,$F0,$F0,$0F,$0F
  DEFB $CC,$33,$CC,$33,$CC,$33,$CC,$33
  DEFB $00,$3C,$7E,$7E,$7E,$7E,$3C,$00
  DEFB $00,$3C,$42,$42,$42,$42,$3C,$00
  DEFB $00,$00,$00,$00,$0F,$08,$08,$08
  DEFB $08,$08,$08,$08,$F8,$00,$00,$00
  DEFB $08,$08,$08,$08,$0F,$00,$00,$00
  DEFB $00,$00,$00,$00,$F8,$08,$08,$08
  DEFB $00,$00,$00,$00,$03,$04,$08,$08
  DEFB $08,$08,$08,$10,$E0,$00,$00,$00
  DEFB $08,$08,$08,$04,$03,$00,$00,$00
  DEFB $00,$00,$00,$00,$E0,$10,$08,$08
  DEFB $00,$7C,$06,$3A,$42,$42,$3C,$00
  DEFB $00,$00,$00,$00,$1C,$14,$1C,$00
  DEFB $1C,$10,$10,$10,$00,$00,$00,$00
  DEFB $18,$24,$20,$20,$70,$22,$7C,$00
  DEFB $10,$28,$78,$04,$3C,$44,$3A,$00
  DEFB $00,$24,$78,$04,$3C,$44,$3A,$00
  DEFB $08,$10,$78,$04,$3C,$44,$3A,$00
  DEFB $32,$4C,$38,$04,$3C,$44,$3A,$00
  DEFB $08,$14,$1C,$22,$3E,$20,$1C,$00
  DEFB $14,$00,$1C,$22,$3E,$20,$1C,$00
  DEFB $08,$14,$00,$18,$08,$08,$1C,$00
  DEFB $00,$14,$00,$18,$08,$08,$1C,$00
  DEFB $10,$08,$00,$18,$08,$08,$1C,$00
  DEFB $08,$14,$1C,$22,$22,$22,$1C,$00
  DEFB $14,$00,$1C,$22,$22,$22,$1C,$00
  DEFB $08,$04,$1C,$22,$22,$22,$1C,$00
  DEFB $00,$00,$00,$3E,$00,$00,$00,$00
  DEFB $00,$00,$60,$10,$08,$06,$00,$00
  DEFB $08,$14,$00,$22,$22,$24,$1A,$00
  DEFB $00,$14,$00,$22,$22,$24,$1A,$00
  DEFB $08,$04,$00,$22,$22,$24,$1A,$00
  DEFB $24,$00,$18,$24,$42,$7E,$42,$00
  DEFB $08,$10,$7E,$40,$7C,$40,$7E,$00
  DEFB $24,$00,$3C,$42,$42,$42,$3C,$00
  DEFB $24,$00,$42,$42,$42,$42,$3C,$00
  DEFB $32,$4C,$18,$24,$42,$7E,$42,$00
  DEFB $32,$4C,$00,$5C,$62,$42,$42,$00
  DEFB $32,$4C,$22,$32,$2A,$26,$22,$00
  DEFB $18,$24,$18,$24,$42,$7E,$42,$00
  DEFB $00,$1E,$20,$7E,$20,$1E,$00,$00
  DEFB $00,$32,$4C,$00,$32,$4C,$00,$00
  DEFB $00,$00,$02,$7F,$08,$7F,$20,$00
  DEFB $20,$10,$78,$04,$3C,$44,$3A,$00
  DEFB $00,$00,$02,$02,$34,$48,$36,$00
  DEFB $00,$1C,$22,$3C,$22,$22,$3C,$60
  DEFB $00,$60,$12,$0C,$14,$14,$08,$00
  DEFB $00,$1C,$20,$18,$24,$24,$18,$00
  DEFB $00,$00,$70,$08,$14,$22,$41,$00
  DEFB $00,$0E,$10,$1E,$20,$20,$1E,$00
  DEFB $00,$00,$22,$2A,$2A,$2A,$14,$00
  DEFB $00,$3E,$12,$08,$10,$22,$7E,$00
  DEFB $00,$1C,$22,$22,$14,$14,$36,$00
  DEFB $00,$02,$06,$0A,$12,$22,$7E,$00
  DEFB $00,$38,$57,$14,$14,$14,$24,$00
  DEFB $00,$3F,$54,$14,$14,$14,$24,$00
  DEFB $00,$00,$24,$24,$24,$24,$3A,$60
  DEFB $00,$00,$1C,$22,$32,$2E,$20,$40
  DEFB $0C,$14,$20,$20,$40,$7C,$1C,$00
  DEFB $06,$04,$04,$04,$04,$04,$1C,$00
  DEFB $18,$24,$42,$7E,$42,$24,$18,$00
  DEFB $00,$3C,$42,$7E,$42,$3C,$00,$00
  DEFB $00,$1E,$10,$10,$50,$30,$10,$00
  DEFB $22,$54,$28,$10,$20,$52,$2D,$12
  DEFB $00,$00,$36,$49,$49,$36,$00,$00
  DEFB $00,$24,$4A,$4A,$3C,$08,$08,$10
  DEFB $08,$2A,$2A,$2A,$1C,$08,$1C,$00
  DEFB $06,$04,$3E,$49,$3E,$08,$38,$00
  DEFB $00,$42,$42,$7E,$42,$24,$18,$00
  DEFB $7E,$02,$02,$7E,$02,$02,$7E,$00
  DEFB $00,$18,$24,$18,$00,$00,$00,$00
  DEFB $00,$1C,$22,$20,$22,$1C,$08,$18
  DEFB $1C,$20,$18,$24,$18,$04,$38,$00
  DEFB $10,$48,$20,$00,$00,$00,$00,$00
  DEFB $70,$50,$70,$00,$00,$00,$00,$00
  DEFB $FF,$FE,$FC,$F8,$F0,$E0,$C0,$80
  DEFB $01,$03,$07,$0F,$1F,$3F,$7F,$FF
  DEFB $80,$C0,$E0,$F0,$F8,$FC,$FE,$FF
  DEFB $FF,$7F,$3F,$1F,$0F,$07,$03,$01
  DEFB $08,$1C,$3E,$7F,$7F,$1C,$3E,$00
  DEFB $36,$7F,$7F,$7F,$3E,$1C,$08,$00
  DEFB $08,$1C,$3E,$7F,$3E,$1C,$08,$00
  DEFB $1C,$1C,$7F,$7F,$6B,$08,$3E,$00
  DEFB $00,$00,$00,$00,$FF,$00,$00,$00
  DEFB $08,$08,$08,$08,$08,$08,$08,$08
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $81,$42,$24,$18,$18,$24,$42,$81
  DEFB $FF,$01,$01,$01,$01,$01,$01,$FF
  DEFB $FF,$80,$80,$80,$80,$80,$80,$FF
  DEFB $01,$02,$04,$08,$10,$20,$40,$80
  DEFB $80,$40,$20,$10,$08,$04,$02,$01
  DEFB $FF,$80,$80,$80,$80,$80,$80,$80
  DEFB $80,$80,$80,$80,$80,$80,$80,$FF
  DEFB $FF,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$FF
  DEFB $08,$08,$08,$08,$FF,$00,$00,$00
  DEFB $00,$00,$00,$00,$FF,$08,$08,$08
  DEFB $08,$08,$08,$08,$F8,$08,$08,$08
  DEFB $08,$08,$08,$08,$0F,$08,$08,$08
  DEFB $08,$08,$08,$08,$FF,$08,$08,$08
  DEFB $10,$18,$7E,$18,$3C,$24,$42,$00
  DEFB $00,$00,$3E,$1C,$08,$00,$00,$00
  DEFB $08,$08,$3E,$08,$08,$00,$3E,$00
  DEFB $10,$08,$04,$08,$10,$00,$3E,$00
  DEFB $04,$08,$10,$08,$04,$00,$3E,$00
  DEFB $00,$18,$00,$7E,$00,$18,$00,$00
  DEFB $00,$00,$08,$1C,$3E,$00,$00,$00

