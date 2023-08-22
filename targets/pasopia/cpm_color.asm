  ORG $0100

; CP/M command to change text colour
  
L0100:
  LD HL,$005C
  CALL L0100_0  ; skip spaces and commas
  CP $0D
  RET Z
  
  CP '0'
  RET C
  CP '8'
  RET NC
  SUB '0'
  LD ($FE2E),A		; foreground ?
  CALL L0100_0
  CP $0D
  RET Z
  CP '0'
  RET C
  CP '8'
  RET NC
  SUB '0'
  LD ($FE2C),A		; background ?
  RET

; skip spaces and commas
L0100_0:
  INC HL
  LD A,(HL)
  CP ' '
  JP Z,L0100_0
  CP $09	; TAB
  JP Z,L0100_0
  CP ','
  JP Z,L0100_0
  RET
