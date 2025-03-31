
;
; ZX Spectrum's Centronics and RS232 Printer driver valid for:
;
;  Morex Peripherals Ltd (a.k.a. Abbeydale Designers Ltd)
;  B&V Interface, Forlì - Italy, by Simone Majocchi
;  Indescomp - Spain, by MHT ingenieros
;  Elettronica 2000 magazine n.53, Spet. 1983, p.41 (https://win.adrirobot.it/E2000/pdf/E2000_053_Set_1983.pdf)
;

  ORG $FC05

; Serial output redirection FLAG
; set to 1 to remap the printer output to RS232
BV_REDIRECT:
  DEFB $00

; Expanded hardcopy flag
BV_ENLARGED:
  DEFB $00

; BASIC Tokenization flag
BV_TOKENIZE:
  DEFB $00

; BAUD Rate (Default: 2400 baud)
BV_BAUD:
; DEFB 125, 20 ;   50bps   16K:  150, 32
; DEFB 225, 4  ;  110bps   16K:  130, 14
; DEFB 165, 4  ;  150bps   16K:  150, 10
; DEFB 83, 4   ;  300bps   16K:  200, 4
; DEFB 41, 4   ;  600bps   16K:  60,  2
; DEFB 31, 2   ; 1200bps   16K:  210, 0
  DEFB 19, 1   ; 2400bps   16K:  25,  0  
;  DEFB 7, 1   ; 4800bps   (could require tuning, not available in conteded memory)


; PROPOSED FIXES:  some of the values look way off, these seem more reasonable.
;        defw    $057D   ;RS_BAUD_50          ; on the manual it is mentioned $147D, but looks rather big
;        defw    $0514   ;RS_BAUD_75          ; ** experimental **
;        defw    $04E1   ;RS_BAUD_110
;        defw    $04B7   ;RS_BAUD_134_5       ; ** experimental **
;        defw    $04A5   ;RS_BAUD_150
;        defw    $0423   ;RS_BAUD_300         ; on the manual it was $0453, slightly adjusted, ** experimental **
;        defw    $0329   ;RS_BAUD_600         ; on the manual it was $0429 but seemed too high, ** experimental **
;        defw    $021F   ;RS_BAUD_1200
;        defw    $0113   ;RS_BAUD_2400
;        defw    $0070   ;RS_BAUD_4800        ; on the manual it was $0107.   ** experimental **

; On an article in YourSpectrum 01-21, a test with the Tandy CGP-115 plotter was mentioned, the plotter's 
; specs mention RS-232-C Using DATA and BUSY. 600 Baud, 7-bit character, no parity, two stop bits.
; Perhaps the extra delay for 600bps was compensating the 7 bit data length ?


BV_HANDSHAKE:
  DEFB $FF

BV_RECEIVED:
  DEFB $00


; Printer flags
BV_FLAGS:

; Bit 0:
; Bit 1:
; Bit 2: NEC printers Graphics ESCape sequence  mode
; Bit 3:
; Bit 4:
; Bit 5: Expand BASIC tokens
; Bit 6: Raw data output mode
; Bit 7: BREAK disabled

  DEFB $00


; Last received character
BV_BYTE:
  DEFB $00

; Data block at 64526
CHR_COUNT:
  DEFB $00

; 
; SERIAL OUTPUT
RS232_SEND:
  DI
RS232_BUSY:
  LD A,(BV_FLAGS)           ; 
  BIT 7,A                   ; Is BREAK disabled?
  JR NZ,NO_BREAK            ; if so, jump over
  CALL $1F54                ; routine BREAK-KEY 
  JP NC,BREAK_PRESSED
NO_BREAK:
  IN A,($FB)                ; Check for RTS
  AND $02                   ; test RS232 busy signal
  JR Z,RS232_BUSY
  LD A,(BV_HANDSHAKE)
  AND $FD
  OUT ($7F),A
  LD (BV_HANDSHAKE),A
  CALL BIT_DELAY

  LD B,$08
SD_BYTE:
  LD A,C
  RR A
  LD C,A
  LD A,(BV_HANDSHAKE)
  JR C,SD_BYTE_0
  AND $FD
  JR SD_BYTE_1
SD_BYTE_0:
  OR $02                    ; enable RS232 TX data signal
SD_BYTE_1:
  LD (BV_HANDSHAKE),A
  OUT ($7F),A
  CALL BIT_DELAY
  DJNZ SD_BYTE

  LD A,(BV_HANDSHAKE)
  OR $02                    ; enable RS232 TX data signal
  LD (BV_HANDSHAKE),A
  OUT ($7F),A
  CALL BIT_DELAY
  CALL BIT_DELAY
  EI
  RET
  
; This entry point is used by the routines at RCV_BYTE and CHAN3_INPUT.
BIT_DELAY:
  CALL BAUD_DELAY
  CALL BAUD_DELAY
  RET

BAUD_DELAY:
  PUSH AF
  PUSH BC
  PUSH HL
  LD BC,(BV_BAUD)
  LD H,B
LFC0F_7:
  LD B,H
LFC0F_8:
  DJNZ LFC0F_8
  DEC C
  JR NZ,LFC0F_7
  POP HL
  POP BC
  POP AF
  RET

; This entry point is used by the routine at CHAN3_INPUT.
RS232_RECEIVE:
  LD A,(BV_HANDSHAKE)
  AND $FB
  OUT ($7F),A
  LD (BV_HANDSHAKE),A
WAIT_RS232_DATA:
  CALL $1F54                ; routine BREAK-KEY 
  JP NC,BREAK_PRESSED
  IN A,($FB)
  AND $80
  JR Z,WAIT_RS232_DATA
  LD A,(BV_HANDSHAKE)
  OR $04                    ; enable RS232 Clear To Send signal
  OUT ($7F),A
  LD (BV_HANDSHAKE),A           ; update status bits
  CALL BAUD_DELAY
; This entry point is used by the routine at CHAN3_INPUT.
RCV_BYTE:
  PUSH BC
  CALL BIT_DELAY
  LD B,$08

; Get character
RCV_BYTE_0:
  IN A,($FB)
  RL A
  RR C
  CALL BIT_DELAY
  PUSH IX
  POP IX
  PUSH HL
  POP HL
  NOP
  DJNZ RCV_BYTE_0
  LD A,C
  CPL
  AND $7F
  CALL BIT_DELAY
  POP BC
  RET

; Entry from ROM, remapped on CHANS.
CHAN3_INPUT:
  DI
CHAN3_INPUT_0:
  LD A,(BV_FLAGS)
  BIT 4,A                       ; Byte received ?
  JR Z,CHAN3_INPUT_1
  RES 4,A
  LD (BV_FLAGS),A
  LD A,(BV_RECEIVED)
  JR CHAN3_INPUT_3

CHAN3_INPUT_1:
  CALL RS232_RECEIVE
  PUSH AF
  CALL BIT_DELAY
  IN A,($FB)
  AND $80
  JR Z,RS232_NO_MORE_DATA
  CALL RCV_BYTE
  LD (BV_RECEIVED),A
  LD A,(BV_FLAGS)
  SET 4,A                       ; Byte received
  LD (BV_FLAGS),A
RS232_NO_MORE_DATA:
  POP AF
CHAN3_INPUT_3:
  CP $0A
  JR Z,CHAN3_INPUT_0
  CP $1B
  JR NZ,CHAN3_INPUT_4
  LD A,$0A
CHAN3_INPUT_4:
  AND A
  LD (BV_BYTE),A
  SCF
  EI
  RET

RS232_OUT:
  LD A,(BV_BYTE)
  LD C,A

; This entry point is used by the routines at BV_NEWLINE_0, LFDC8 and LFE17.
SEND_BYTE:
  LD A,(BV_REDIRECT)
  AND A                     ; Redirect to RS232 ?
  JP NZ,RS232_SEND               ; Yes, send via RS232 
  ; no, use CENTRONICS
  LD A,(BV_HANDSHAKE)
  OR $01                    ; enable Centronics strobe signal
  OUT ($7F),A

PRINTER_BUSY:
  LD A,(BV_FLAGS)
  BIT 7,A                   ; BREAK disabled?
  JR NZ,SKIP_BREAK
  CALL $1F54                ; routine BREAK-KEY 
  JP NC,BREAK_PRESSED
SKIP_BREAK:
  IN A,($FB)
  AND $01
  JR NZ,PRINTER_BUSY

  LD A,C
  OUT ($FB),A               ; Send data to RS232
  LD A,(BV_HANDSHAKE)
  AND $FE
  OUT ($7F),A
  OR $01                    ; enable Centronics strobe signal
  OUT ($7F),A
  LD (BV_HANDSHAKE),A
  RET

; This entry point is used by the routine at RS232_SEND.
BREAK_PRESSED:
  LD A,(BV_FLAGS)
  AND $40                ; Were we in raw data output mode ?
  JR Z,BREAK_PRESSED_0
  LD A,(BV_FLAGS)        ; yes, restore BREAK flag..
  OR $80
  LD (BV_FLAGS),A
  CALL CLEAR_BUFFER      ;..clear buffer..
  CALL SEND_BUFFER       ; ..and send it to the printer as a sequence of NULs
  LD A,$06               ; Send control codes to restore default line spacing
  CALL SEND_CTL
BREAK_PRESSED_0:
  CALL END_PRINTING
  JP $0F0A               ;  Error Report: BREAK - CONT repeats  

; This entry point is used by the routine at LFE17.
END_PRINTING:
  LD A,$FF
  LD (BV_HANDSHAKE),A
  OUT ($7F),A
  LD A,(BV_FLAGS)
  AND $3E                ; Reset bits 0,6,7: disable RAW data output mode, enable BREAK..
  LD (BV_FLAGS),A
; This entry point is used by the routine at BV_INIT.
END_PRINTING_0:
  LD A,(BV_TOKENIZE)
  AND A                  ; Expand tokens ?
  LD A,(BV_FLAGS)
  SET 5,A                ; Yes
  JR NZ,END_PRINTING_1
  RES 5,A                ; No
END_PRINTING_1:
  LD (BV_FLAGS),A
  EI
  RET
  
; This entry point is used by the routine at CHAN3_OUTPUT.
NO_TOKEN:
  LD C,A
  LD A,(BV_FLAGS)
  AND $01
  JR Z,SEND_CHR_0
  LD A,(BV_FLAGS)
  RES 0,A
  LD (BV_FLAGS),A
  LD A,C
  PUSH HL
  LD HL,CHR_COUNT
  SUB (HL)
  POP HL
  RET M
  RET Z
  LD B,A
CHAN3_INPUT_14:
  PUSH BC
  CALL SEND_CHR
  POP BC
  DJNZ CHAN3_INPUT_14
  RET

; This entry point is used by the routines at BV_NEWLINE_0 and CHAN3_OUTPUT.
SEND_CHR:
  LD C,$20
SEND_CHR_0:
  LD A,C
  CP $0D
  JR NZ,SEND_CHR_1

; This entry point is used by the routine at LFE17.
BV_NEWLINE:
  XOR A
  LD (CHR_COUNT),A
  LD C,$0D         ; CR

; Add line feed
BV_NEWLINE_0:
  CALL SEND_BYTE
  LD C,$0A         ; LF
  JR SEND_BYTE_0

; This entry point is used by the routine at CHAN3_INPUT.
SEND_CHR_1:
  CP $17           ; 23
  JR NZ,SEND_CHR_2
  LD A,(BV_FLAGS)
  SET 0,A
  LD (BV_FLAGS),A
  RET

SEND_CHR_2:
  CP $06
  JR NZ,SEND_CHR_4

SEND_CHR_3:
  CALL SEND_CHR
  LD A,(CHR_COUNT)
  AND $0F
  JR NZ,SEND_CHR_3
  RET
  
SEND_CHR_4:
  LD A,(CHR_COUNT)
  INC A
  LD (CHR_COUNT),A

; This entry point is used by the routines at BV_NEWLINE_0 and CHAN3_OUTPUT.
SEND_BYTE_0:
  JP SEND_BYTE

; Interface initialization
; This routine will redirect #3 to the new I/O routines
BV_INIT:
  LD BC,$000F
  LD HL,($5C4F)         ; CHANS
  ADD HL,BC             ; shift to #3
  LD BC,CHAN3_OUTPUT
  CALL BV_INIT_0
  LD BC,CHAN3_INPUT
BV_INIT_0:
  LD (HL),C
  INC HL
  LD (HL),B
  INC HL
  JP END_PRINTING_0

  
; Entry from ROM, remapped on CHANS.
; Routine at 64996   (Offset: 01A1)
CHAN3_OUTPUT:
  LD C,A
  LD A,(BV_FLAGS)
  BIT 6,A                   ; Raw data output?
  JR NZ,SEND_BYTE_0
  LD A,(BV_FLAGS)
  BIT 5,A                   ; Must expand BASIC tokens?
  LD A,C
  JP NZ,NO_TOKEN            ; No, jump over
  AND A                     ; NULL ?
  JP P,NO_TOKEN
  CP $A5                    ; < RND thus not a token ?
  JP C,SEND_CHR
  PUSH AF
  LD A,(BV_FLAGS)
  SET 5,A                   ; Set BASIC tokens expansion
  LD (BV_FLAGS),A
  POP AF
  CALL $0B52                 ; to PO-T&UDG  
  LD A,(BV_FLAGS)
  RES 5,A                   ; Reset BASIC tokens expansion
  LD (BV_FLAGS),A
  RET

; Copy SCREEN$
HARDCOPY:
  XOR A
  JR HARDCOPY_0

; Expanded SCREEN$ COPY
LFE17:
  LD A,$01
; This entry point is used by the routine at HARDCOPY.
HARDCOPY_0:
  LD (BV_ENLARGED),A
  DI
  LD A,(BV_FLAGS)
  RES 5,A                   ; Reset BASIC tokens expansion
  SET 6,A                   ; Set raw data output mode
  LD (BV_FLAGS),A
  LD A,$00                  ; Send control codes for narrow line spacing (hardcopy mode)
  CALL SEND_CTL
  LD HL,$4000
  LD DE,$0020
  LD BC,$0803               ; B=8, C=3
HARDCOPY_1:
  PUSH HL
HARDCOPY_2:
  PUSH HL
  PUSH BC
  CALL COPY_ROW
  POP BC
  POP HL
  ADD HL,DE
  DJNZ HARDCOPY_2
  POP HL
  PUSH DE
  LD DE,2048
  ADD HL,DE
  LD B,$08
  POP DE
  DEC C
  JR NZ,HARDCOPY_1
  LD A,$06               ; Send control codes to restore default line spacing
  CALL SEND_CTL
  JP END_PRINTING

ADD_PIXEL:
  OR (IX+$00)
  LD (IX+$00),A
  LD A,(BV_FLAGS)
  BIT 2,A
  JR NZ,ADD_PIXEL_0
  RRC (IX+$00)
  RET

ADD_PIXEL_0:
  RLC (IX+$00)
  RET

; Printing of a screen row
COPY_ROW:
  CALL CLEAR_BUFFER
  LD BC,$0820            ; B=8, C=32
  LD A,(BV_ENLARGED)
  AND A
  JR Z,LOAD_BUFFER
  LD B,$04               ; B=4
  CALL LOAD_BUFFER
  LD BC,$0420            ; B=4, C=32

LOAD_BUFFER:
  LD IX,$5B00            ; Printer buffer
  PUSH HL
  PUSH IX
  PUSH BC
  LD A,$80
LOAD_BUFFER_0:
  LD B,$08
  LD D,(HL)
LOAD_BUFFER_1:
  PUSH AF
  AND D
  CALL ADD_PIXEL
  LD A,(BV_ENLARGED)
  AND A
  JR Z,LOAD_BUFFER_2
  POP AF
  PUSH AF
  AND D
  CALL ADD_PIXEL
LOAD_BUFFER_2:
  INC IX
  SLA D
  POP AF
  DJNZ LOAD_BUFFER_1
  INC HL
  DEC C
  JR NZ,LOAD_BUFFER_0
  POP BC
  POP IX
  POP HL
  INC H
  PUSH HL
  PUSH IX
  DEC B
  PUSH BC
  JR NZ,LOAD_BUFFER_0
  POP BC
  POP IX
  POP HL

; This entry point is used by the routine at CHAN3_INPUT.
SEND_BUFFER:
  PUSH HL
  LD HL,$5B00            ; Printer buffer
  LD B,$00
  LD A,(BV_ENLARGED)
  AND A
  JR Z,SEND_BUFFER_1
  LD A,(BV_FLAGS)
  BIT 2,A
  JR Z,SEND_BUFFER_0
  LD B,$F0
SEND_BUFFER_0:
  LD A,$02
SEND_BUFFER_1:
  ADD A,$02              ; Send control codes for narrow line spacing (hardcopy mode)
  CALL SEND_CTL
SEND_BUFFER_2:
  PUSH BC
  LD C,(HL)
  LD A,(BV_FLAGS)
  BIT 2,A
  JR NZ,SEND_BUFFER_3
  RLC C
SEND_BUFFER_3:
  INC HL
  PUSH BC
  CALL SEND_BYTE
  POP BC
  LD A,(BV_ENLARGED)
  AND A
  JR Z,SEND_BUFFER_4
  CALL SEND_BYTE
SEND_BUFFER_4:
  POP BC
  DJNZ SEND_BUFFER_2
  POP HL
  CALL BV_NEWLINE
; This entry point is used by the routine at CHAN3_INPUT.
CLEAR_BUFFER:
  LD IX,$5B00            ; Printer buffer
  XOR A
  LD B,A
CLEAR_BUFFER_0:
  LD (IX+$00),A
  INC IX
  DJNZ CLEAR_BUFFER_0
  RET

; This entry point is used by the routine at CHAN3_INPUT.
SEND_CTL:
  PUSH HL
  PUSH BC
  LD HL,CONTROL_CODES
  LD C,A
  LD A,(BV_FLAGS)
  AND $04               ; NEC printers Graphics ESCape sequence  mode ?
  JR Z,SEND_CTL_0
  LD A,$01
SEND_CTL_0:
  ADD A,C               ; A will be equal to C if NEC mode, otherwise C+1 
  INC A
  LD C,A
  LD A,$FF
SEND_CTL_1:
  CP (HL)
  INC HL
  JR NZ,SEND_CTL_1
  DEC C
  JR NZ,SEND_CTL_1
SEND_CTL_2:
  LD A,(HL)
  CP $FF                ;
  JR Z,SEND_CTL_3
  LD C,A
  CALL SEND_BYTE
  INC HL
  JR SEND_CTL_2
SEND_CTL_3:
  POP BC
  POP HL
  RET

CONTROL_CODES:
; 0
  DEFB $FF,$1B,'T','1','6'          ; NEC: narrow line spacing
  DEFB $FF,$1B,'A',$08              ; ESC/P: 8/60 inch line spacing
; 2
  DEFB $FF,$1B,'S','0','2','5','6'  ; NEC: graphics printing, 256 dots
  DEFB $FF,$1B,'K',$00,$01          ; ESC/P: 60-dpi graphics printing, 256 dots
; 4  
  DEFB $FF,$1B,'S','0','5','1','2'  ; NEC: graphics printing, 512 dots
  DEFB $FF,$1B,'K',$E0,$01          ; ESC/P: 60-dpi graphics printing, 480 dots
; 6
  DEFB $FF,$1B,'A'                  ; NEC:
  DEFB $FF,$1B,'2'                  ; ESC/P: set default line spacing (1/6 inch)
; 8
  DEFB $FF,$1B,'2'                  ; NEC: set default line spacing
  DEFB $FF                          ; ESC/P: (NUL)
; DEFB $00
