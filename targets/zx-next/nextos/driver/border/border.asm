; ***************************************************************************
; * Simple example NextZXOS driver                                          *
; ***************************************************************************
;
; This file is the 512-byte NextZXOS driver itself, plus relocation table.
;
; Assemble with: pasmo border.asm border.bin border.sym
;
; After this, border_drv.asm needs to be built to generate the actual
; driver file.


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
; If you do switch any banks, don't forget to restore the previous MMU settings
; afterwards.


; ***************************************************************************
; * Entry points                                                            *
; ***************************************************************************

        org     $0000

; At $0000 is the entry point for API calls directed to your driver.
; B,DE,HL are available as entry parameters.

; If your driver does not provide any API, just exit with A=0 and carry set.
; eg:
;       xor     a
;       scf
;       ret

api_entry:
        jr      border_api
        nop

; At $0003 is the entry point for the interrupt handler. This will only be
; called if bit 7 of the driver id byte has been set in your .DRV file, so
; need not be implemented otherwise.

im1_entry:
reloc_1:
        ld      a,(colour)
        inc     a                       ; increment stored border colour
        and     $07
reloc_2:
        ld      (colour),a
        out     ($fe),a                 ; set it
        ret


; ***************************************************************************
; * Simple example API                                                      *
; ***************************************************************************
; On entry, use B=call id with HL,DE other parameters.
; (NOTE: HL will contain the value that was either provided in HL (when called
;        from dot commands) or IX (when called from a standard program).
;
; When called from the DRIVER command, DE is the first input and HL is the second.
;
; When returning values, the DRIVER command will place the contents of BC into
; the first return variable, then DE and then HL.

border_api:
        bit     7,b                     ; check if B>=$80
        jr      nz,channel_api          ; on if so, for standard channel API

        djnz    bnot1                   ; On if B<>1

; B=1: set values.

reloc_3:
        ld      (value1),de
reloc_4:
        ld      (value2),hl
        and     a                       ; clear carry to indicate success
        ret

; B=2: get values.

bnot1:
        djnz    bnot2                   ; On if B<>2
reloc_5:
        ld      a,(colour)
        ld      b,0
        ld      c,a
reloc_6:
        ld      de,(value1)
reloc_7:
        ld      hl,(value2)
        and     a                       ; clear carry to indicate success
        ret

; Unsupported values of B.

bnot2:
api_error:
        xor     a                       ; A=0, unsupported call id
        scf                             ; Fc=1, signals error
        ret


; ***************************************************************************
; * Standard channel API                                                    *
; ***************************************************************************
; If you want your device driver to support standard channels for i/o, you
; can do so using the following API calls.
; Each call is optional - just return with carry set and A=0
; for any calls that you don't want to provide.
;
; B=$f9: open channel
; B=$fa: close channel
; B=$fb: output character
; B=$fc: input character
; B=$fd: get current stream pointer
; B=$fe: set current stream pointer
; B=$ff: get stream size/extent

channel_api:
        ld      a,b
        sub     $f9                     ; set zero flag if call $f9 (open)
        jr      c,api_error             ; exit if invalid ($80..$f8)
        ld      b,a                     ; B=0..6
        jr      nz,bnotf9               ; on if not $f9 (open)


; B=$f9: open channel
; In the documentation for your driver you should describe how it should be
; opened. The command used will determine the input parameters provided to
; this call (this example assumes your driver id is ASCII 'X', ie $58):
; OPEN #n,"D>X"         ; simple open: HL=DE=0
; OPEN #n,"D>X>string"  ; open with string: HL=address, DE=length
;                       ; NOTE: be sure to check for zero-length strings
; OPEN #n,"D>X,p1,p2"   ; open with numbers: DE=p1, HL=p2 (zeros if not provided)
;
; This call must return a unique channel handle in A. This allows your driver
; to support multiple different concurrent channels if desired.
;
; If you return with any error (carry set), "Invalid filename" will be reported
; and no stream will be opened.
;
; For this example, we will simply check that no other channels have yet been
; opened:

reloc_8:
        ld      a,(chanopen_flag)
        and     a
        jr      nz,api_error            ; exit with error if already open
        ld      a,1
reloc_9:
        ld      (chanopen_flag),a       ; signal "channel open"
        ret                             ; exit with carry reset (from AND above)
                                        ; and A=handle=1


; B=$fa: close channel
; This call is entered with D=handle, and should close the channel
; If it cannot be closed for some reason, exit with an error (this will be
; reported as "In use").

bnotf9:
        djnz    bnotfa                  ; on if not call $fa
reloc_10:
        call    validate_handle         ; check D is our handle (does not return
                                        ; if invalid)
        xor     a
reloc_11:
        ld      (chanopen_flag),a       ; signal "channel closed"
        ret                             ; exit with carry reset (from XOR)


; B=$fb: output character
; This call is entered with D=handle and E=character.
; If you return with carry set and A=$fe, the error "End of file" will be
; reported. If you return with carry set and A<$fe, the error
; "Invalid I/O device" will be reported.
; Do not return with A=$ff and carry set; this will be treated as a successful
; call.

bnotfa:
        djnz    bnotfb                  ; on if not call $fb
reloc_12:
        call    validate_handle         ; check D is our handle (does not return
                                        ; if invalid)
reloc_13:
        ld      a,(output_ptr)
reloc_14:
        call    calc_buffer_add         ; HL=address within buffer
        ld      (hl),e                  ; store character
        inc     a
        and     $1f
reloc_15:
        ld      (output_ptr),a          ; update pointer
        ret                             ; exit with carry reset (from AND)


; B=$fc: input character
; This call is entered with D=handle.
; You should return the character in A (with carry reset).
; If no character is currently available, return with A=$ff and carry set.
; This will cause INPUT # or NEXT # to continue calling until a character
; is available.
; If you return with carry set and A=$fe, the error "End of file" will be
; reported. If you return with carry set and any other value of A, the error
; "Invalid I/O device" will be reported.

bnotfb:
        djnz    bnotfc                  ; on if not call $fc
reloc_16:
        call    validate_handle         ; check D is our handle (does not return
                                        ; if invalid)
reloc_17:
        ld      a,(input_ptr)
reloc_18:
        call    calc_buffer_add         ; HL=address within buffer
        ld      e,(hl)                  ; get character
        inc     a
        and     $1f
reloc_19:
        ld      (input_ptr),a           ; update pointer
        ld      a,e                     ; A=character
        ret                             ; exit with carry reset (from AND)


; B=$fd: get current stream pointer
; This call is entered with D=handle.
; You should return the pointer in DEHL (with carry reset).

bnotfc:
        djnz    bnotfd                  ; on if not call $fd
reloc_20:
        call    validate_handle         ; check D is our handle (does not return
                                        ; if invalid)
reloc_21:
        ld      a,(input_ptr)
        ld      l,a
        ld      h,0                     ; HL=stream pointer
        ld      d,h
        ld      e,h
        and     a                       ; reset carry (successful call)
        ret


; B=$fe: set current stream pointer
; This call is entered with D=handle and IXHL=pointer.
; Exit with A=$fe and carry set if the pointer is invalid (will result in
; an "end of file" error).
; NOTE: Normally you should not use IX as an input parameter, as it cannot
;       be set differently to HL if calling via the esxDOS-compatible API.
;       This call is a special case that is only made by NextZXOS.

bnotfd:
        djnz    bnotfe                  ; on if not call $fe
reloc_22:
        call    validate_handle         ; check D is our handle (does not return
                                        ; if invalid)
        ld      a,l                     ; check if pointer >$1f
        and     $e0
        or      h
        or      ixl
        or      ixh
        scf
        ld      a,$fe
        ret     nz                      ; exit with A=$fe and carry set if so
        ld      a,l
reloc_23:
        ld      (input_ptr),a           ; set the pointer
        and     a                       ; reset carry (successful call)
        ret


; B=$ff: get stream size/extent
; This call is entered with D=handle
; You should return the size/extent in DEHL (with carry reset).

bnotfe:
reloc_24:
        call    validate_handle         ; check D is our handle (does not return
                                        ; if invalid)
        ld      hl,32                   ; our simple channel is always size 32
        ld      d,h
        ld      e,h
        and     a                       ; reset carry (successful call)
        ret


; ***************************************************************************
; * Validate handle for our simple channel                                  *
; ***************************************************************************

validate_handle:
        dec     d                       ; D should have been 1
        ret     z                       ; return if so
        pop     af                      ; otherwise discard return address
        jr      api_error               ; and exit with error


; ***************************************************************************
; * Validate handle for our simple channel                                  *
; ***************************************************************************

calc_buffer_add:
        push    af                      ; save offset into buffer
reloc_25:
        ld      hl,channel_data         ; base address
        add     a,l                     ; add on offset
        ld      l,a
        ld      a,0
        adc     a,h
        ld      h,a
        pop     af                      ; restore offset
        ret


; ***************************************************************************
; * Data                                                                    *
; ***************************************************************************

colour:
        defb    0

value1:
        defw    0

value2:
        defw    0

chanopen_flag:
        defb    0

input_ptr:
        defb    0

output_ptr:
        defb    0

channel_data:
        defs    32


; ***************************************************************************
; * Relocation table                                                        *
; ***************************************************************************
; This follows directly after the full 512 bytes of the driver.

if ($ > 512)
.ERROR Driver code exceeds 512 bytes
else
        defs    512-$
endif

; Each relocation is the offset of the high byte of an address to be relocated.

reloc_start:
        defw    reloc_1+2
        defw    reloc_2+2
        defw    reloc_3+3
        defw    reloc_4+2
        defw    reloc_5+2
        defw    reloc_6+3
        defw    reloc_7+2
        defw    reloc_8+2
        defw    reloc_9+2
        defw    reloc_10+2
        defw    reloc_11+2
        defw    reloc_12+2
        defw    reloc_13+2
        defw    reloc_14+2
        defw    reloc_15+2
        defw    reloc_16+2
        defw    reloc_17+2
        defw    reloc_18+2
        defw    reloc_19+2
        defw    reloc_20+2
        defw    reloc_21+2
        defw    reloc_22+2
        defw    reloc_23+2
        defw    reloc_24+2
        defw    reloc_25+2
reloc_end:

