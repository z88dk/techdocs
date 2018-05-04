; ***************************************************************************
; * Simple example NextOS driver                                            *
; ***************************************************************************
;
; This file is the 512-byte NextOS driver itself, plus relocation table.
;
; Assemble with: pasmo mouse.asm mouse.bin mouse.sym
;
; After this, mouse_drv.asm needs to be built to generate the actual
; driver file.

; Based on code freely made available with credit for original work:
; mouse.asm v1.0 - Chris Cowley 2003 <ccowley@grok.co.uk>
; modified to use larger XY space / cursor and sprites for ZX Next by Tim Gilberts
; v0p2 to use return values for new DRIVER command in BASIC.
; v0p2b correct bugs in Sprite and Pattern number

; ***************************************************************************
; * Entry points                                                            *
; ***************************************************************************
; Drivers are a fixed length of 512 bytes (although can have external 8K
; banks allocated to them if required).
;
; They are always assembled at origin $0000 and relocated at installation time.
;
; Your driver always runs with interrupts disabled, and may use any of the
; standard register set (AF,BC,DE,HL). Index registers and alternates must be
; preserved.
;
; No esxDOS hooks or restarts may be used. However, 3 calls are provided
; which drivers may use:
;
;       call    $2000   ; drv_drvswapmmc
;                       ; Used for switching between allocated DivMMC banks
;
;       call    $2003   ; drv_drvrtc
;                       ; Query the RTC. Returns BC=date, DE=time (as M_DATE)
;
;       call    $2006   ; drv_drvapi
;                       ; Access other drivers. Same parameters as M_DRVAPI.
;
; The stack is always located below $4000, so if ZX banks have been allocated
; they may be paged in at any location (MMU2..MMU7). However, when switching
; to other allocated DivMMC banks, the stack cannot be used unless you set
; it up/restore it yourself.


; ***************************************************************************
; * Entry points                                                            *
; ***************************************************************************

        org     $0000


; At $0000 is the entry point for API calls directed to your driver.
; B,DE,HL are available as entry parameters.

; If your driver does not provide any API, just exit with A=0 and carry set.

api_entry: 	JR 	return_mouse
		NOP
;        xor     a
;        scf
;        ret

; At $0003 is the entry point for the interrupt handler. This will only be
; called if bit 7 of the driver id byte has been set in your .DRV file, so
; need not be implemented otherwise.

im1_entry:	JR	update_mouse
		; Read the kempston mouse port and update PointerX and PointerY if the pointer has moved

; ***************************************************************************
; On entry, use B=call id with HL,DE other parameters.
; (NOTE: HL will contain the value that was either provided in HL (when called
;        from dot commands) or IX (when called from a standard program).
;
; When called from the DRIVER command, DE is the first input and HL is the second.
;
; When returning values, the DRIVER command will place the contents of BC into
; the first return variable, then DE and then HL.
;
; API services we have are: 
;
; B=1 Return current XY location of mouse in DE,HL(L only actually) with Button status in C
; B WILL BE previous status of buttons - not yet implemented - probably better to use mouse event
;
; B=2 enable Sprite mouse
; 1st Param HL = sprite number to use		;Would be IX if from a standard command
; 2nd Param DE = pattern number to use
;
; B=3 disable Sprite mouse
;
; B=4 enable cursor mouse / change attribute used
; 1st Param HL = Attribute to use
; 2nd Param DE = unused as yet
;
; B=5 disable Cursor mouse
;
; Double X resolution (used for Timex mode) obviously sprite pointer snaps to center of the two pixels.
;
;
; TODO...
;
; Option to Constrain sprite to within border - does not set clipping, if it is outside it snaps to closest edge.
;
; Get next mouse event.
; Returns BC,DE,HL as BC=[event type NONE(0),UP(1), DOWN(2), CLICK(3), DOUBLE CLICK(4)], DE=X, HL=Y


return_mouse:	
        	DJNZ    bnot1                   ; On if B<>1
reloc_api_1:
		LD	HL,PointerX+1		; MSB
		LD	D,(HL)
		DEC	HL			; PointerX-LSB
		LD	E,(HL)
		DEC	HL			; Pointer Y
		LD	B,(HL)
		DEC	HL			; Lastbutton
		LD	C,(HL)
		XOR	A			; All is well so Clear Carry ready
		LD	H,A			; No MSB for Y
		LD	L,B
		LD	B,A			; Make sure MSB for Lastbutton is also zero
		RET

;2 enable sprite mouse pointer
bnot1		DJNZ	bnot2
		LD	A,E
		AND	%00111111		; 0-63 only valid so force
reloc_api_2:	LD	(SelfMod1+1),A			
		LD	A,L
		AND	%00111111		; Same again
reloc_api_3:	LD	(SelfMod2+1),A		; We only use the bottom 4 bits anyway
		LD	A,%00000010		; Set Bit 1 of flags to say sprite enabled.

set_flags:
reloc_api_4:	LD	HL,Flags
		OR	(HL)			; Enable sprite cursor (it will appear next Interrupt)
		LD	(HL),A
		XOR	A
		RET

;3 disable sprite mouse pointer
bnot2:		DJNZ	bnot3
	
		XOR	A			; Bit 7=0
reloc_api_5:	CALL	sprite_cursor		; Get rid of it !

		LD	A,%11111101		; Make sure no sprite cursor appears

reset_flags:	
reloc_api_6:	LD	HL,Flags
		AND	(HL)
		LD	(HL),A
		XOR	A
		RET

;4 enable cursor mouse
bnot3:		DJNZ	bnot4
		LD	A,E			; Totally zero value not allowed i.e. BLACK on BLACK (if wanted set Bright)
		OR	A
		JR	Z,use_last
reloc_api_7:	LD	(Attrib),A
use_last:	LD	A,%00000001		; It will appear on next INT
		JR	set_flags

;5 disable cursor mouse		
bnot4:		DJNZ	bnot5

reloc_api_8:	CALL	remove_cursor
		INC	HL			; Old Attrib
		INC	HL			; AttribAddLSB
		INC	HL			; AttribAddMSB
		XOR	A
		LD	(HL),A			; Like never enabled

		LD	A,%11111110
		JR	reset_flags

; Unsupported values of B.
; You may wish to return an error code in A.
bnot5:
        	SCF                             ; Fc=1, signals error
        	RET



        
; ***************************************************************************        
; Main bulk of IM1 routine

update_mouse:
	
reloc_1:	CALL	remove_cursor	; Leaves HL pointing at Attrib
		
		DEC	HL		; Point at MouseX
		PUSH	HL

		LD	BC,64479	; Kempston X
		LD	A,(HL)
		LD	E,A
		IN	A,(C)
		LD	(HL),A
		SUB	E
		; Mouse Left/Right
		LD	E,A
		CP	$80
		JR	NC,moving_left

; Moving Right
reloc_2:	LD	HL,(PointerX)
		LD	D,0
		ADD	HL,DE
		EX	DE,HL		; DE is new X pos
		LD	HL,639		; Was 319	
		OR	A
		SBC	HL,DE

;		JR	Z,mouse_y	; No change do nothing

		JR	C,right_edge

reloc_4_3:	LD	(PointerX),DE
		JR	mouse_y

right_edge:
		LD	HL,639		; Was 319 
reloc_5:	LD	(PointerX),HL
		JR	mouse_y

moving_left:	
reloc_6:	LD	HL,(PointerX)
		LD	A,E
		NEG
		LD	E,A
		LD	D,0		
		OR	A
		SBC	HL,DE
		EX	DE,HL		; DE is new X pos
reloc_7:	LD	HL,(PointerX)	; HL is old X pos
		OR	A
		SBC	HL,DE
		JR	C,left_edge

reloc_8_3:	LD	(PointerX),DE
		JR	mouse_y

left_edge:
		XOR	A
		LD	L,A
		LD	H,A
reloc_9:	LD	(PointerX),HL


mouse_y:	POP	HL
		DEC	HL		; Point at Mouse Y

		LD	BC,65503	; Kempston Y
		LD	A,(HL)
		LD	D,A
		IN	A,(C)
		LD	(HL),A
		SUB	D

		CP	$80
		JR	C,going_up

;going_down
		NEG
		LD	B,A
reloc_10:	LD	A,(PointerY)
		ADD	A,B
		JR	C,set_vert_edge

reloc_11:	LD	(PointerY),A
		JR	mouse_display


;Keep the exit code in range of all JR
		
mouse_btn:		
		LD	BC,64223
		IN	A,(C)

		CP	255
		JR	NZ,end_pointer

		SCF			; probably no mouse if port floating
		RET

end_pointer:
		XOR	%00000111	; Invert bits for simplicity
		AND	%00000111	; Only keep the three buttons.
		
reloc_12:	LD	(LastButton),A	; Save in LastButton

		XOR	255		; This will set the Z flag (if no buttons) and clear the carry
		RET
		

set_vert_edge:
		LD	A,255
		JR	set_vertical
;reloc_14:	LD	(PointerY),A
;		JR	mouse_display
		
going_up:	
		LD	B,A	
reloc_13:	LD	A,(PointerY)	; old pos
		SUB	B
		JR	NC,set_vertical
		; set_bottom_edge
		XOR	A
set_vertical:
reloc_15:	LD	(PointerY),A
; Display mouse if needed

mouse_display:
		DEC	HL		; Now Flags		

		BIT	0,(HL)		
		PUSH	HL

reloc_16:	CALL	NZ, mouse_cursor

		POP	HL
		
		BIT	1,(HL)
		JR	Z,mouse_btn

		LD	A,%10000000		; Make mouse sprite appear
reloc_17:	CALL	sprite_cursor

		JR	mouse_btn
		
;--------------
;Enter A=128 to make it appear and 0 to dissappear
sprite_cursor:
		PUSH	AF

reloc_18:	LD	HL,PointerY
		LD	E,(HL)
		INC 	HL		
		LD	D,(HL)
		INC	HL
		LD	H,(HL)
		LD	L,D

		SRL	H		; Divide HL by 2 due to Timex support
		RR	L

		LD 	BC,$303B	; Sprite select port

SelfMod1:	LD	A,0		; Use sprite zero for mo unless set by API

		OUT	(C),A

		LD	BC,$0057
		OUT 	(C),L		; X
		OUT	(C),E		; Y

		XOR	A		; 7-4 Palette, 3-1 Rotation, 0 MSB of X
		SRL	H
		RLA
		OUT	(C),A

		POP	AF

SelfMod2:	OR	0		; Combine in pattern index 0-63

		OUT 	(C),A		; Display or hide sprite
	
		RET


;OK now we have a pointer location let's turn it into an Attibute location on screen.
mouse_cursor:	
	
reloc_19:	LD	HL,PointerY
		LD	A,(HL)
;Limit Y as it can be higher than bottom of screen
		CP	24*8
		JR	C,lines_ok
		LD	A,24*8-1	; Doesn't matter how far down never lower than line 23
lines_ok:
		LD	B,%00010110	; Base of attrib at 22528 / 4
		LD	C,A		; So convert 0-175 /8 then *32 = *4
		SLA	C
		RL	B
		SLA	C
		RL	B
		LD	A,C	
		AND	%11100000	; Preserve relevant bits
		LD	C,A
		INC	HL		; PointerX LSB

		LD	E,(HL)		; Get X and divide by 8 (16 now for timex)
		INC	HL
		LD	A,(HL)
		SRL	A
		RR	E
		SRL	A
		RR	E
		SRL	A		; We throw these away if there anyway
		RR	E
		SRL	A
		RR	E
		LD	A,E
		CP	32
		JR	C,cols_ok
		LD	A,31
cols_ok:
		OR	C
		LD	E,A		; DE is now location in attribute screen for X,Y
		LD	D,B

reloc_20:	LD	HL,OldAttrib
	
		LD	A,(DE)		; Get current attibute from screen
		LD	(HL),A		; Save it
		INC	HL		; OldAttribAdd LSB
				
		LD	(HL),E
		INC	HL		; OldAttribAdd MSB
		LD	(HL),D
reloc_21:	LD	A,(Attrib)
		LD	(DE),A

		RET

;--------------
remove_cursor:
reloc_22:	LD	HL,OldAttribAdd+1	; On first install there is no saved attribute so MSB = 0
		LD	D,(HL)
		DEC	HL
		LD	E,(HL)			; Probably safe to write to address 0 on first load - but better code...
		DEC	HL		; HL = OldAttrib
		DEC	HL		; HL = Attrib
		XOR	A		; =0
		CP 	D
		JR 	Z,no_old_A
		
		LD	A,(DE)
		CP	(HL)		; Best to see if attribute is still our ATTRIB (if not do not restore)
		JR	NZ,no_old_A

		INC	HL		; OldAttrib again
;Below can be swapped with LDD damages BC/DE but hell it decs HL for us back to Attrib
		LDD
;		LD	A,(HL)
;		LD	(DE),A		; Restore Attibute byte on screen
;		DEC	HL		; Keep HL consistent in case reused pointing at Attrib
no_old_A:			
		RET

; ***************************************************************************
; * Data                                                                    *
; ***************************************************************************

					
LastButton:	DEFB	255
PointerY:	DEFB	0
PointerX:	DEFW	0		;Needs two bytes for width

Flags:		DEFB	0		;Flags for Bit management
					;0 - Attribute Cursor pointer enable
					;1 - Sprite pointer enable
					;2 - TODO Constrain sprite to screen

MouseY:		DEFB	0
MouseX: 	DEFB	0
Attrib:		DEFB 	%11000111	;Bright flashing BLACK and WHITE
OldAttrib:	DEFB	0
OldAttribAdd:	DEFW	0		;Attribute location of mouse at 0,0



; ***************************************************************************
; * Relocation table                                                        *
; ***************************************************************************
; This follows directly after the full 512 bytes of the driver.

        defs    512-$

if ($ != 512)
.ERROR Driver code exceeds 512 bytes
endif

; Each relocation is the offset of the high byte of an address to be relocated.

reloc_start:
        defw    reloc_api_1+2
        defw    reloc_api_2+2      
        defw    reloc_api_3+2
        defw    reloc_api_4+2
        defw    reloc_api_5+2
        defw    reloc_api_6+2
        defw    reloc_api_7+2
        defw    reloc_api_8+2
        defw    reloc_1+2
        defw    reloc_2+2
;        defw    reloc_3+2
        defw    reloc_4_3+3		;DE load
        defw    reloc_5+2
        defw    reloc_6+2
        defw    reloc_7+2
        defw    reloc_8_3+3		;DE load
        defw    reloc_9+2
        defw    reloc_10+2
        defw    reloc_11+2
        defw    reloc_12+2
        defw    reloc_13+2
;        defw    reloc_14+2
        defw    reloc_15+2
        defw    reloc_16+2
        defw    reloc_17+2
        defw    reloc_18+2
        defw    reloc_19+2
        defw    reloc_20+2
        defw    reloc_21+2
        defw    reloc_22+2
reloc_end:

