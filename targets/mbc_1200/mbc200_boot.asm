L0000:

  LD B,$00
L0000_0:
  DJNZ L0000_0

  LD SP,$FF00
  LD A,$FE
  OUT ($E1),A        ; keyboard
  LD A,$37
  OUT ($E1),A        ; keyboard

  LD A,$6E
  OUT ($ED),A        ; uart2
  LD A,$37
  OUT ($ED),A        ; uart2

  LD A,$C1
  OUT ($EB),A        ; PPI_M: issue control word

  XOR A
  OUT ($E9),A        ; PPI, 
  LD A,$27
  OUT ($E4),A        ; FDC reset

  LD B,$00
L0000_1:
  DJNZ L0000_1

; mb8876 Floppy Disk Controller
L0000_2:
  IN A,($E4)
  RRA
  JR NC,L0000_2
  LD A,$B4
  OUT ($E4),A

  LD B,$00            ; short delay
L0000_3:
  DJNZ L0000_3

L0000_4:
  IN A,($E4)
  RRA
  JR NC,L0000_4
  LD A,$B4
  OUT ($E4),A

  LD B,$00            ; short delay
L0000_5:
  DJNZ L0000_5

L0000_6:
  IN A,($E4)
  RRA
  JR NC,L0000_6

  LD B,$04
L0000_7:
  PUSH BC

L0000_8:
  LD A,$F7
  OUT ($E4),A

  LD B,$06
L0000_9:
  DJNZ L0000_9

L0000_10:
  IN A,($E4)
  RRA
  JR NC,L0000_10
  IN A,($E4)
  RLA
  JR NC,L0000_8
  LD A,$B4
  OUT ($E4),A

  LD B,$0A
L0000_11:
  DJNZ L0000_11

L0000_12:
  IN A,($E4)
  RRA
  JR NC,L0000_12
  LD A,$F7
  OUT ($E4),A

  LD B,$0A
L0000_13:
  DJNZ L0000_13

L0000_14:
  IN A,($E4)
  RRA
  JR NC,L0000_14

  LD HL,$FF00       ; BOOT entry

  LD A,$01
  CPL
  OUT ($E6),A
  LD A,$7F
  OUT ($E4),A

  LD B,$06
L0000_15:
  DJNZ L0000_15

L0000_16:
  IN A,($E4)
  RRA
  JR C,L0000_17
  RRA
  JR C,L0000_16
  IN A,($E7)        ; get byte
  CPL
  LD (HL),A         ; store byte
  INC HL
  JR L0000_16

L0000_17:
  IN A,($E4)
  XOR $FF
  POP BC
  JP Z,$FF00		; BOOT stub ready, jump !
  DJNZ L0000_7      ; not ready, retry 4 times

  LD HL,ERR_MSG
L0000_18:
  LD C,(HL)
L0000_19:
  IN A,($EA)
  AND $80
  JR Z,L0000_19
  LD A,C
  OUT ($E8),A
  INC HL
  LD A,(HL)
  OR A             ; check for string termination
  JR NZ,L0000_18
  HALT

ERR_MSG:
  DEFB $1A			; Clear screen
; Message at 4273
  DEFM "Boot error !",0

