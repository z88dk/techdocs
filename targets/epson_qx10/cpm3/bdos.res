	; Resident BDOS module in banked system

	.z80

	aseg
	org	0f100h


bdos_bnk	equ	5f06h


serial:	db	00,00,00,00,01,0D2h

bdose:	JP	start

;---------------------------------------
; BANKED BDOS to RESIDENT BDOS interface
;---------------------------------------
	JP	bank1
	JP	bank2
	JP	bank3

bnk_w1:	dw	00
bnk_b2:	db	0
     	db	0
bnk_b3:	db	0
bnk_w4:	dw	00
bnk_w5:	dw	buff_2
bnk_dma:
	dw	00	; Address of DMA buffer
bnk_b7:	db	0
bnk_de:	dw	00
bnk_la:	db	0	; lookahead character

	JP	get_tpa

;=================================
; Start of RESIDENT BDOS FUNCTIONS
;=================================
start:	LD   A,C
	LD   HL,0000h
	LD   (result),HL
	ADD  HL,SP
	LD   (stack),HL
	LD   SP,stack
	LD   HL,return
	PUSH HL

	CP   0Ch
	JP   NC,tst_f

	LD   (scb43),A
	LD   HL,c_jmps
	LD   B,00h
	ADD  HL,BC
	ADD  HL,BC
	LD   A,(HL)
	INC  HL
	LD   H,(HL)
	LD   L,A
	JP   (HL)
	db	'COPYRIGHT (C) 1982, DIGITAL RESEARCH 151282'
	ds	11
	db	00,00,00,00,00,00

c_jmps:
	dw	bios_wboot	; 00
	dw	bnk_bdos	; 01
	dw	bnk_bdos	; 02
	dw	f_3		; 03
	dw	f_4		; 04
	dw	f_5		; 05
	dw	f_6		; 06
	dw	f_7		; 07
	dw	f_8		; 08
	dw	f_9		; 09
	dw	f_10		; 0a
	dw	bnk_bdos	; 0b

f_3:	CALL bios_auxin		; Aux Input
	JP   ret_a

f_4:	LD   C,E		; Aux Output
	JP   bios_auxout

f_5:	LD   C,E		; List output
	JP   bios_list

f_6:	LD   A,E		; Dir Cons I/O
	INC  A
	JP   Z,f_6_ff
	INC  A
	JP   Z,f_6_fe
	INC  A
	JP   Z,f_6_fd
	LD   C,E
	JP   bios_conout

f_6_fe:	CALL f_6_cis
	JP   ret_a

f_6_ff:	CALL f_6_cis
	OR   A
	RET  Z

f_6_fd:	CALL f_6_cin
	JP   ret_a

f_6_cis:
	LD   A,(bnk_la)	; lookahead buffer
	OR   A
	LD   A,0FFh
	RET  NZ
	JP   bios_const

f_6_cin:
	LD   HL,bnk_la		; lookahead buffer
	LD   A,(HL)
	LD   (HL),00h
	OR   A
	RET  NZ
	JP   bios_conin

f_7:	CALL bios_auxist	; Aux In Status
	JP   ret_a

f_8:	CALL bios_auxost	; Aux Out Status
	JP   ret_a

f_9:	LD   B,D	; Print string
	LD   C,E
nxt_f9:	LD   HL,scb37
	LD   A,(BC)
	CP   (HL)
	RET  Z
	INC  BC
	PUSH BC
	LD   C,A
	CALL c_out
	POP  BC
	JP   nxt_f9

f_10:	EX   DE,HL	; Read Console Buffer
	LD   A,L
	OR   H
	JP   NZ,f_10a
	LD   HL,buff_1+2
	LD   (scb1e),HL
	LD   HL,(scb3c)
f_10a:	PUSH HL
	LD   DE,buff_1
	PUSH DE
	LD   B,00h
	LD   C,(HL)
	INC  BC
	INC  BC
	INC  BC
	EX   DE,HL
	CALL bios_move
	LD   (HL),00h
	POP  DE
	PUSH DE
	LD   C,0Ah
	CALL bnk_bdos
	LD   A,(buff_1+1)
	LD   C,A
	LD   B,00h
	INC  BC
	INC  BC
	POP  DE
	POP  HL
	JP   bios_move
  f6f_70:
	LD   (save_a),A
	EX   DE,HL
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	INC  HL
	LD   C,(HL)
	INC  HL
	LD   B,(HL)
	EX   DE,HL
nxt_str:
	LD   A,B
	OR   C
	RET  Z
	PUSH BC
	PUSH HL
	LD   C,(HL)
	LD   DE,up_str
	PUSH DE
	LD   A,(save_a)
	CP   70h
	JP   Z,bios_list
c_out:	LD   A,(scb33)
	LD   B,A
	AND  00000010b	; test scroll disabled
	JP   Z,c_out1	; -no-
	LD   A,B
	AND  00010100b	; test raw console & ?
	JP   Z,c_out1	; -no-
	AND  00010000b	; test ?
	JP   NZ,bios_list ; -yes-
	JP   bios_conout
c_out1:	LD   E,C
	LD   C,02h
	JP   bnk_bdos

up_str:	POP  HL
	INC  HL
	POP  BC
	DEC  BC
	JP   nxt_str

;---------------------------------------
; On entry <HL> -> data byte in TPA bank
; Returns <A> = (HL) and selects SYS bank
;---------------------------------------
get_tpa:
	LD   A,01h		; TPA bank
	CALL bios_selmem
	LD   B,(HL)
	XOR  A			; SYSTEM bank
	CALL bios_selmem
	LD   A,B
	RET

;----------------------------------------
; On entry <HL> -> process in TPA bank
; Returns result in <A> back to SYS bank
;----------------------------------------
tpa_f:	LD   DE,ret_sys
	PUSH DE
	LD   A,01h	; TPA bank number
	CALL bios_selmem
	JP   (HL)
ret_sys:
	LD   B,A	; save <A>
	XOR  A		; SYSTEM bank number
	CALL bios_selmem
	LD   A,B	; restore <A>
	RET

;----------------------------------------
; Function > 11, Test function for groups
;----------------------------------------
tst_f:
	CP   33h
	JP   C,f0C_32
	CP   62h
	JP   C,f33_61.71
	CP   71h
	JP   NC,f33_61.71
	CP   6Fh
	JP   Z,f6f_70
	CP   70h
	JP   Z,f6f_70
	JP   f_bank

;-----------------------------------
f0C_32:		; functions 12 to 50
;-----------------------------------
	CP   11h
	JP   Z,f_11
	CP   12h
	JP   Z,f_12
	CP   1Ah
	JP   NZ,f_bank

f_1a:	EX   DE,HL
	LD   (scb3c),HL
	LD   (bnk_dma),HL
	RET

f_11:	EX   DE,HL
	LD   (scb47),HL

f_12:	LD   HL,(scb47)
	EX   DE,HL

;-------------------------------------------------------
; Banked BDOS functions 62 thru 6E, 0C thru 32 except 1A
;-------------------------------------------------------
f_bank:
	LD   HL,b0c_32 - 0Ch	; table of function types
	LD   A,C
	CP   62h
	JP   C,$+6
	LD   HL,b62_6e - 62h
	LD   B,00h
	ADD  HL,BC
	LD   A,(HL)
	LD   B,A	; Save bank function bits
	PUSH BC
	PUSH DE
	RRA
	JP   C,f_bank1	; Bit 0 = 1
	RRA
	JP   C,f_bank2	; Bit 1 = 1
	JP   f_bank3

f_bank1:
	LD   HL,(scb3c)
	EX   DE,HL
	LD   HL,buff_2
	LD   BC,0010h
	CALL bios_move	; copy 16 bytes from DMA to buff_2
	POP  DE
	PUSH DE

f_bank2:
	XOR  A
	LD   (bnk_b7),A
	LD   HL,buff_1
	LD   BC,0024h
	CALL bios_move	; copy 36 bytes from (DE) to buff_1
	LD   DE,buff_1
	POP  HL
	POP  BC
	PUSH BC
	PUSH HL
	LD   (bnk_de),HL
f_bank3:
	CALL bnk_bdos
	POP  DE
	POP  BC
	LD   A,B	; test bank return functions
	AND  not 11b
	RET  Z		; -no data block returned-
	LD   HL,buff_1
	EX   DE,HL
	LD   BC,0021h
	RLA
	JP   C,f_bank4	; bit 7 = 1
	LD   C,24h
	RLA
	JP   C,f_bank4	; bit 6 = 1
	RLA
	JP   C,f_bank6	; bit 5 = 1
	LD   C,04h
	RLA
	JP   C,bios_move; bit 4 = 1
	RLA
	JP   C,f_bank5	; bit 3 = 1
	LD   C,06h
	JP   bios_move	; bit 2 must = 1

f_bank4:
	LD   A,(bnk_b7)
	OR   A
	JP   Z,bios_move
; If bnk_b7 not zero then
; copy 2 bytes offset 14 bytes from BUFF1 to (DE+14)
; copy 1 byte offset 14+17+1 bytes from BUFF1 to (DE+32)
	LD   BC,000Eh
	ADD  HL,BC
	EX   DE,HL
	ADD  HL,BC
	LD   A,(HL)
	LD   (DE),A
	INC  HL
	INC  DE
	LD   A,(HL)
	LD   (DE),A
	INC  BC
	INC  BC
	INC  BC
	ADD  HL,BC
	EX   DE,HL
	ADD  HL,BC
	LD   A,(DE)
	LD   (HL),A
	RET

f_bank5:
	LD   HL,(scb3c)
	LD   BC,0003h
	LD   DE,buff_2
	JP   bios_move

f_bank6:
	LD   HL,(scb3c)
	LD   BC,0080h
	LD   DE,buff_2
	JP   bios_move

f_98:	; parse filename
	EX   DE,HL
	LD   E,(HL)
	INC  HL
	LD   D,(HL)	; DE = Input string
	INC  HL
	LD   C,(HL)
	INC  HL
	LD   B,(HL)	; BC = FCB
	LD   HL,buff_2a
	PUSH HL
	PUSH BC
	PUSH DE
	LD   (buff_1+2),HL	; create COMMON PFCB.FCB
	LD   HL,buff_1a
	LD   (buff_1),HL	; create COMMON PFCB.INPUT
	LD   BC,0080h
	CALL bios_move	; copy 128 bytes from INPUT to buff_1a
	LD   (HL),00h	; add NULL terminator as 129th byte
	LD   C,98h
	LD   DE,buff_1
	CALL bnk_bdos
	POP  BC		; recover DE
	LD   A,L
	OR   H
	JP   Z,f_98a	; 0000 -> reached end of input string
	LD   A,L
	AND  H
	INC  A
	JP   Z,f_98a	; FFFF -> error in input string
	LD   DE,buff_1a
	LD   A,L
	SUB  E
	LD   L,A
	LD   A,H
	SBC  A,D
	LD   H,A	; HL = HL - buff_1a
	ADD  HL,BC
	LD   (result),HL	; HL = address of delimiter
f_98a:
	POP  HL			; recover BUFF_2a
	POP  DE			; recover FCB
	LD   BC,0024h
	JP   bios_move	; copy 36 bytes to callers FCB
;-------------------------------------------------------------------
; Function 98 or Function does not exist (33 thru 61 and 71 upwards)
;-------------------------------------------------------------------
f33_61.71:
	CP   98h
	JP   Z,f_98
	RLA
	LD   A,00h
	JP   C,ret_a	; Function > 7F and not 98 returns 00h
	DEC  A		; else below 80 return FFH
;-------------------------------------------
; Finish of BDOS function - return to caller
;-------------------------------------------
ret_a:	LD   (result),A
return:	LD   HL,(stack)
	LD   SP,HL
	LD   HL,(result)
	LD   A,L
	LD   B,H
	RET

;-------------------------------------------------------------
; Switch to banked BDOS then return in TPA bank setting RESULT
;-------------------------------------------------------------
bnk_bdos:
	XOR  A
	CALL bios_selmem	; select system bank
	CALL bdos_bnk		; banked BDOS functions
	LD   (result),HL
	LD   A,01h
	JP   bios_selmem	; select TPA bank

;----------------------------------------------------------------
; Select BANK in A unless 0, copy data then return in SYSTEM bank
;----------------------------------------------------------------
bank1:	OR   A
	JP   Z,bios_move
	CALL bios_selmem
bank1a:
	CALL bios_move
	XOR  A
	JP   bios_selmem
;-----------------------------------------------------
; Select TPA BANK copy data then return in SYSTEM bank
;-----------------------------------------------------
bank2:	LD   A,01
	CALL bios_selmem
	JP   bank1a
;-----------------------------------------------------
; Save HL in save_hl
; Select BANK in A
; Set bnk_b2 to zero
; Copies (bnk_w1) to DE
; Copies (scb45) to HL
; Calculates DE -> (scb45) - (bnk_w1)
; Calculates HL -> (scb45)*4 + (save_HL)
;-----------------------------------------------------
bank3:	LD   (save_hl),HL
	CALL bios_selmem
	LD   HL,ret_bank3
	PUSH HL
	XOR  A
	LD   (bnk_b2),A
	LD   HL,(save_hl)
	LD   B,H
	LD   C,L
	LD   HL,(bnk_w1)
	EX   DE,HL
	LD   HL,(scb45)
	PUSH HL
	CALL sub.de	; HL = HL-DE, returns A = H
	POP  DE
	OR   L
	RET  Z		; HL = 0
	PUSH HL
	INC  DE		; DE = (scb45) + 1
	EX   DE,HL
	PUSH HL
	DEC  HL		; HL = (scb45)
	ADD  HL,HL
	ADD  HL,HL
	ADD  HL,BC	; HL = (scb45)*4 + (save_HL)
bank3a:
	LD   DE,0004h
	ADD  HL,DE	; HL = (scb45)*4 + (save_HL) + 4*n
	LD   DE,scb01
	LD   A,(DE)
	XOR  (HL)
	AND  1Fh	; test bits 0 thru 4
	JP   NZ,bank3d	; -not same-
	CALL bank3j	; compare SCB00 bytes of strings DE, HL
	JP   Z,bank3f	; same
bank3b:	EX   DE,HL
	POP  HL
bank3c:	INC  HL		; (SCB45) + 1 + 1*n
	EX   (SP),HL
	DEC  HL		; (SCB45) - (bnk_w1) - 1*n
	LD   A,L
	OR   H
	EX   (SP),HL
	PUSH HL
	EX   DE,HL
	JP   NZ,bank3a
	INC  A		; A = 1
	POP  HL
	POP  HL
	RET
bank3d:
	LD   A,(bnk_w4+1)
	INC  A		; test bnk_w4+1 = 0FFH
	JP   Z,bank3h	; -yes-
	INC  A		; test bnk_w4+1 = 0FEH
	JP   NZ,bank3b	; -no-
	PUSH DE
	CALL bank3j	; compare SCB00 bytes of strings DE, HL
	POP  DE
	JP   NZ,bank3b	; -not same-
	LD   A,(bnk_b3)	; -same-
	INC  A
	JP   Z,bank3g
	INC  A
	JP   Z,bank3e
	LD   A,(HL)
	AND  1Fh
	JP   NZ,bank3b
	JP   bank3f
bank3e:
	LD   A,(DE)
	XOR  (HL)
	AND  0Fh
	JP   NZ,bank3b
	LD   A,(HL)
	AND  30h
	CP   30h
	JP   Z,bank3b
bank3f:
	LD   HL,(scb45)
	EX   DE,HL
	POP  HL
	DEC  HL
	LD   (scb45),HL
	POP  BC
	LD   A,L
	AND  03h
	CP   03h
	RET  Z
	LD   A,E
	AND  0FCh
	LD   E,A
	LD   A,L
	AND  0FCh
	LD   L,A
	CALL sub.de	; HL = HL-DE, returns A = H
	OR   L
	RET  Z
	LD   A,0FFh
	LD   (bnk_b2),A
	XOR  A
	RET
bank3g:
	LD   A,(HL)
	AND  10h
	JP   Z,bank3b
	LD   A,(DE)
	XOR  (HL)
	AND  0Fh
	JP   NZ,bank3b
	JP   bank3i
bank3h:
	LD   A,(HL)
	CP   0F5h
	JP   NZ,bank3b
bank3i:	EX   DE,HL
	POP  HL
	LD   (bnk_w4),HL
	JP   bank3c
; On entry HL -> string count followed by string
;          DE -> string count followed by string
;          SCB00 = length of string to be compared
; Returns  Z if strings same
bank3j:
	LD   A,(scb00)
	OR   A
	RET  Z
	LD   C,A
	RRCA
	RRCA
	RRA		;Bits shifted to 11076543
	LD   B,A
	LD   A,(DE)
	XOR  (HL)
	AND  B		; mask
	RET  NZ
	PUSH HL
	INC  HL
	INC  DE
	CALL cp_str	; Compare C bytes of strings (DE) & (HL)
	POP  HL
	RET

ret_bank3:
	PUSH AF
	XOR  A
	CALL bios_selmem
	POP  AF
	RET

sub.de:		; HL = HL-DE, returns A = H
	LD   A,E
	SUB  L
	LD   L,A
	LD   A,D
	SBC  A,H
	LD   H,A
	RET

cp_str:		; Compare C bytes of strings (DE) & (HL)
	LD   A,(DE)
	CP   (HL)
	RET  NZ
	INC  HL
	INC  DE
	DEC  C
	RET  Z
	JP   cp_str

;-------------------------------------------------------------
; Banked BDOS functions 0C thru 32
; Pass parameter bits
; Bit 0 - Pass 16 byte parameters from DMA to buff_2 & assume Bit 1 set
; Bit 1 - Pass 36 byte parameters from (DE) to buff_1
; Return parameter bits
; Bit 7 - Return 33  bytes from buff_1 to (DE) unless bnk_b7 set
; Bit 6 - Return 36  bytes from buff_1 to (DE) unless bnk_b7 set
; Bit 5 - Return 128 bytes from buff_2 to DMA
; Bit 4 - Return  4  bytes from buff_1 to (DE)
; Bit 3 - Return  3  bytes from buff_2 to DMA
; Bit 2 - Return  6  bytes from buff_1 to (DE)
;-------------------------------------------------------------
b0c_32:	;	76543210
	db	00000000b	; 0C
	db	00000000b	; 0D
	db	00000000b	; 0E
	db	10000011b	; 0F
	db	10000010b	; 10
	db	00100010b	; 11
	db	00100010b	; 12
	db	00000011b	; 13
	db	10000010b	; 14
	db	10000010b	; 15
	db	10000011b	; 16
	db	00000011b	; 17
	db	00000000b	; 18
	db	00000000b	; 19
	db	00000000b	; 1a
	db	00000000b	; 1b
	db	00000000b	; 1c
	db	00000000b	; 1d
	db	10000011b	; 1e
	db	00000000b	; 1f
	db	00000000b	; 20
	db	10000010b	; 21
	db	10000010b	; 22
	db	01000010b	; 23
	db	01000010b	; 24
	db	00000000b	; 25
	db	00000000b	; 26
	db	00000000b	; 27
	db	10000010b	; 28
	db	10000010b	; 29
	db	00000000b	; 2a
	db	00000000b	; 2b
	db	00000000b	; 2c
	db	00000000b	; 2d
	db	00001000b	; 2e
	db	00000000b	; 2f
	db	00000000b	; 30
	db	00000010b	; 31
	db	00000010b	; 32

;-------------------------------------------------------
; Banked BDOS functions 62 thru 6E, 0C thru 32 except 1A
;-------------------------------------------------------
b62_6e:
	db	00000000b	; 62
	db	00000011b	; 63
	db	00000011b	; 64
	db	00000000b	; 65
	db	10000011b	; 66
	db	00000011b	; 67
	db	00000010b	; 68
	db	00010010b	; 69
	db	00000010b	; 6a
	db	00000110b	; 6b
	db	00000000b	; 6c
	db	00000000b	; 6d
	db	00000000b	; 6e

	db	00000000b	; 6f
	db	00000000b	; 70

save_a:	db	0
save_hl:
	dw	00

	db	0
result:	dw	0

buff_1:
	ds	4
buff_1a:	; 128 +1 bytes used by function 152
	ds	32
buff_2:         ; up to 128 bytes used
	ds	28
buff_2b	equ	buff_1 + 64	; buffer for use by BIOS
	ds	4
	ds	64
	ds	1
buff_2a	equ	buff_1a + 128 + 1	; and 36 bytes
	ds	32
	ds	2
F5D1:	ds	3

F5D4:	ds	64

F614:	ds	41 * 2			; 41 levels of stack
stack:	dw	0

;----------------------
; Jumps for banked BDOS
;----------------------
	JP	bios_wboot
	JP	tpa_f
	JP	bios_const
	JP	tpa_f
	JP	bios_conin
	JP	tpa_f
	LD	HL,bios_conout
	JP	tpa_f
	JP	bios_list
	JP	tpa_f

; Extra data block (CCP uses some of this)

	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	000h
	db	007h
	dw	0F106h	; start of BDOS
	db	000h
	db	000h

;---------------------
; System Control Block
;---------------------
scb:

scb00:	db	0
scb01:	db	0
scb02:	db	0
scb03:	db	0
scb04:	db	0
scb05:	db	031h	; BDOS version number
scb06:	db	0
scb07:	db	0
scb08:	db	0
scb09:	db	0
scb0a:	db	0
scb0b:	db	0
scb0c:	db	0
scb0d:	db	0
scb0e:	db	0
scb0f:	db	0
scb10:	db	0,0	; Program error code

scb12:	db	0
scb13:	db	0
scb14:	db	0
scb15:	db	0
scb16:	db	0
scb17:	db	0
scb18:	db	0
scb19:	db	0
scb1a:	db	80 - 1	; Last column on console
scb1b:	db	0	; Current console column position
scb1c:	db	25-1	; Console page length
scb1d:	db	0
scb1e:	db	0
scb1f:	db	0
scb20:	db	0
scb21:	db	0
scb22:	db	0,0	;@CIVEC Redirection Flag

scb24:	db	0,0	;@COVEC Redirection Flag

scb26:	db	0,0	;@AIVEC Redirection Flag

scb28:	db	0,0	;@AOVEC Redirection Flag

scb2a:	db	0,0	;@LOVEC Redirection Flag

scb2c:	db	0	; Page Mode (=0)
scb2d:	db	0
scb2e:	db	0	; CTRL-H not replaced by DEL
scb2f:	db	0FFh	; DEL replaced by CTRL-H
scb30:	db	0
scb31:	db	0
scb32:	db	0
scb33:	db	0,0	; Console Mode

scb35:	dw	buff_2b	;@BNKBF

scb37:	db	'$'	; Output Delimiter character
scb38:	db	0	; CTRL-P List Output FLag
scb39:	db	0
scb3a:	dw	scb	; Address of this SCB structure

scb3c:	dw	0080h	;@CRDMA Current DMA address

scb3e:	db	0	;@CRDSK Current Disk
scb3f:	dw	00	;@VINFO

scb41:	db	0	;@RESEL
scb42:	db	0
scb43:	db	0	;@FX
scb44:	db	0	;@USRCD Current User Number
scb45:	dw	0h

scb47:	dw	3h

scb49:	db	0
scb4a:	db	001h	;@MLTIO Disk Multi-Sector Count
scb4b:	db	0	;@ERMDE Disk Error Mode
scb4c:	db	0	; Drive Search Chain
	db	0FFh
	db	0FFh
	db	0FFh
scb50:	db	0	; Temporary File Drive
scb51:	db	0	;@ERDSK Error drive number
scb52:	db	0
scb53:	db	0
scb54:	db	0	;@MEDIA
scb55:	db	0
scb56:	db	0
scb57:	db	080h	;@BFLGS BDOS flags bit 7 - full msg, 6 - single alloc
scb58:	dw	00712h	;@DATE

scb5a:	db	0	;@HOUR
scb5b:	db	0	;@MIN
scb5c:	db	0	;@SEC
scb5d:	dw	0E000h	; Common Memory Base Address

scb5f:	jp	05F7Ch	;?ERJMP


scb62:	dw	0F106h	;@MXTPA current value for (6,7)

;		=========================
;		RESIDENT BIOS starts here
;		=========================
bios		equ	$
bios_wboot	equ	bios + 1*3
bios_const	equ	bios + 2*3
bios_conin	equ	bios + 3*3
bios_conout	equ	bios + 4*3
bios_list	equ	bios + 5*3
bios_auxout	equ	bios + 6*3
bios_auxin	equ	bios + 7*3
bios_listst	equ	bios + 15*3
bios_conost	equ	bios + 17*3
bios_auxist	equ	bios + 18*3
bios_auxost	equ	bios + 19*3
bios_devtbl	equ	bios + 20*3
bios_devini	equ	bios + 21*3
bios_move	equ	bios + 25*3
bios_time	equ	bios + 26*3
bios_selmem	equ	bios + 27*3

	end
