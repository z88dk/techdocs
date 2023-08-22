;  ORG $0100

; CP/M commands to set the Pasopia /T100 video mode.

MONITOR:
  LD HL,$5018		; 80x24
  LD ($FE2A),HL

  LD HL,($0001)
  LD DE,$004E
  ADD HL,DE
  LD (HL),$80
  RET



TV:
  LD HL,$2418		; 36x24   ...PAL ?
  LD ($FE2A),HL

  LD HL,($0001)
  LD DE,$004E
  ADD HL,DE
  LD (HL),$80
  RET



TV1:
  LD HL,$2413		;36x19   ...NTSC?
  LD ($FE2A),HL

  LD HL,($0001)
  LD DE,$004E
  ADD HL,DE
  LD (HL),$80
  RET

