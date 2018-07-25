; ***************************************************************************
; * Example NextZXOS keyboard driver                                        *
; ***************************************************************************
; The keyboard driver used by NextZXOS may be replaced by installing a
; special driver with id 0.

; This file is the 512-byte NextZXOS driver itself, plus relocation table.
;
; Assemble with: pasmo keyboard.asm keyboard.bin keyboard.sym
;
; After this, keyboard_drv.asm needs to be built to generate the actual
; driver file.

; Keyboard drivers are installed using the same .install dot command
; as standard drivers, and immediately replace the existing keyboard
; driver (the keyboard driver does not count towards the total number
; of standard installable NextZXOS drivers).
;
; The main differences between the keyboard driver and standard drivers
; are as follows:
;       1. The keyboard driver always has driver id 0.
;       2. The keyboard driver cannot provide an API.
;       3. The keyboard driver is always called at every IM1 interrupt.
;       4. The keyboard driver has just a single entry point, at $0000,
;          which is called during IM1 interrupts.
;
; Replacement keyboard drivers should perform the same effective
; functionality as the standard KEYBOARD routine at $02bf in the ROM of
; the original 48K Spectrum.
;
; The following driver replicates exactly the code from the original
; ROM (although slightly re-ordered). It may be used as a base for
; a replacement.
;
; Possible uses for replacement keyboard drivers might be:
;       * For use with alternative international keyboard layouts
;       * Adding a multi-byte buffer to allow faster typing
;
; Be aware that the driver is called by all ROMs, so should support
; keyword tokens (unless you don't intend to use 48K BASIC mode, or only
; intend to use 48K BASIC mode using the Gosh Wonderful ROM in standard
; single-letter entry).


; ***************************************************************************
; * System variable definitions                                             *
; ***************************************************************************

KSTATE  equ     $5c00
LAST_K  equ     $5c08
REPDEL  equ     $5c09
REPPER  equ     $5c0a


; ***************************************************************************
; * KEYBOARD routine (at $02bf in original 48K ROM)                         *
; ***************************************************************************

        org     $0000           ; this is the entry point for the driver

keyboard:
reloc_1:
        call    key_scan
        ret     nz
        ld      hl,KSTATE
keyboard_2:
        bit     7,(hl)
        jr      nz,keyboard_3
        inc     hl
        dec     (hl)
        dec     hl
        jr      nz,keyboard_3
        ld      (hl),$ff
keyboard_3:
        ld      a,l
        ld      hl,KSTATE+$04
        cp      l
        jr      nz,keyboard_2
reloc_2:
        call    k_test
        ret     nc
        ld      hl,KSTATE
        cp      (hl)
        jr      z,k_repeat
        ex      de,hl
        ld      hl,KSTATE+$04
        cp      (hl)
        jr      z,k_repeat
        bit     7,(hl)
        jr      nz,keyboard_4
        ex      de,hl
        bit     7,(hl)
        ret     z
keyboard_4:
        ld      e,a
        ld      (hl),a
        inc     hl
        ld      (hl),$05
        inc     hl
        ld      a,(REPDEL)
        ld      (hl),a
        inc     hl
        ld      c,(iy+$07)
        ld      d,(iy+$01)
        push    hl
reloc_3:
        call    k_decode
        pop     hl
        ld      (hl),a
keyboard_5:
        ld      (LAST_K),a
        set     5,(iy+$01)
        ret


; ***************************************************************************
; * K-REPEAT routine (at $0310 in original 48K ROM)                         *
; ***************************************************************************

k_repeat:
        inc     hl
        ld      (hl),$05
        inc     hl
        dec     (hl)
        ret     nz
        ld      a,(REPPER)
        ld      (hl),a
        inc     hl
        ld      a,(hl)
        jr      keyboard_5


; ***************************************************************************
; * Keytables                                                               *
; ***************************************************************************
; These are copies of the key tables from original 48K ROM

; The L-mode keytable with CAPS-SHIFT

keytable_l:
        defm    "BHY65TGV"
        defm    "NJU74RFC"
        defm    "MKI83EDX"
        defm    $0e,"LO92WSZ"
        defm    " ",$0d,"P01QA"

; The extended-mode keytable (unshifted letters)

keytable_e:
        defb    $e3,$c4,$e0,$e4
        defb    $b4,$bc,$bd,$bb
        defb    $af,$b0,$b1,$c0
        defb    $a7,$a6,$be,$ad
        defb    $b2,$ba,$e5,$a5
        defb    $c2,$e1,$b3,$b9
        defb    $c1,$b8

; The extended mode keytable (shifted letters)

keytable_e_s:
        defb    $7e,$dc,$da,$5c
        defb    $b7,$7b,$7d,$d8
        defb    $bf,$ae,$aa,$ab
        defb    $dd,$de,$df,$7f
        defb    $b5,$d6,$7c,$d5
        defb    $5d,$db,$b6,$d9
        defb    $5b,$d7

; The control code keytable (CAPS-SHIFTed digits)

keytable_cc:
        defb    $0c,$07,$06,$04
        defb    $05,$08,$0a,$0b
        defb    $09,$0f

; The symbol code keytable (letters with symbol shift)

keytable_sym:
        defb    $e2,$2a,$3f,$cd
        defb    $c8,$cc,$cb,$5e
        defb    $ac,$2d,$2b,$3d
        defb    $2e,$2c,$3b,$22
        defb    $c7,$3c,$c3,$3e
        defb    $c5,$2f,$c9,$60
        defb    $c6,$3a

; The extended mode keytable (SYM-SHIFTed digits)

keytable_e_d:
        defb    $d0,$ce,$a8,$ca
        defb    $d3,$d4,$d1,$d2
        defb    $a9,$cf


; ***************************************************************************
; * KEY-SCAN routine (at $028e in original 48K ROM)                         *
; ***************************************************************************

key_scan:
        ld      l,$2f
        ld      de,$ffff
        ld      bc,$fefe
key_scan_2:
        in      a,(c)
        cpl
        and     $1f
        jr      z,key_scan_5
        ld      h,a
        ld      a,l
key_scan_3:
        inc     d
        ret     nz
key_scan_4:
        sub     $08
        srl     h
        jr      nc,key_scan_4
        ld      d,e
        ld      e,a
        jr      nz,key_scan_3
key_scan_5:
        dec     l
        rlc     b
        jr      c,key_scan_2
        ld      a,d
        inc     a
        ret     z
        cp      $28
        ret     z
        cp      $19
        ret     z
        ld      a,e
        ld      e,d
        ld      d,a
        cp      $18
        ret


; ***************************************************************************
; * K-TEST routine (at $031e in original 48K ROM)                           *
; ***************************************************************************

k_test:
        ld      b,d
        ld      d,$00
        ld      a,e
        cp      $27
        ret     nc
        cp      $18
        jr      nz,k_test2
        bit     7,b
        ret     nz
k_test2:
reloc_4:
        ld      hl,keytable_l   ; the main keytable
        add     hl,de
        ld      a,(hl)
        scf
        ret


; ***************************************************************************
; * K-DECODE routine (at $0333 in original 48K ROM)                         *
; ***************************************************************************

k_decode:
        ld      a,e
        cp      $3a
        jr      c,k_decode_6
        dec     c
reloc_5:
        jp      m,k_decode_4
        jr      z,k_decode_2
        add     a,$4f
        ret
k_decode_2:
reloc_6:
        ld      hl,keytable_e-'A'
        inc     b
        jr      z,k_decode_3
reloc_7:
        ld      hl,keytable_e_s-'A'
k_decode_3:
        ld      d,$00
        add     hl,de
        ld      a,(hl)
        ret
k_decode_4:
reloc_8:
        ld      hl,keytable_sym-'A'
        bit     0,b
        jr      z,k_decode_3
        bit     3,d
        jr      z,k_decode_5
        bit     3,(iy+$30)
        ret     nz
        inc     b
        ret     nz
        add     a,$20
        ret
k_decode_5:
        add     a,$a5
        ret
k_decode_6:
        cp      $30
        ret     c
        dec     c
reloc_9:
        jp      m,k_decode_9
        jr      nz,k_decode_8
reloc_10:
        ld      hl,keytable_e_d-'0'
        bit     5,b
        jr      z,k_decode_3
        cp      $38
        jr      nc,k_decode_7
        sub     $20
        inc     b
        ret     z
        add     a,$08
        ret
k_decode_7:
        sub     $36
        inc     b
        ret     z
        add     a,$fe
        ret
k_decode_8:
reloc_11:
        ld      hl,keytable_cc-'0'
        cp      $39
        jr      z,k_decode_3
        cp      $30
        jr      z,k_decode_3
        and     $07
        add     a,$80
        inc     b
        ret     z
        xor     $0f
        ret
k_decode_9:
        inc     b
        ret     z
        bit     5,b
reloc_12:
        ld      hl,keytable_cc-'0'
        jr      nz,k_decode_3
        sub     $10
        cp      $22
        jr      z,k_decode_10
        cp      $20
        ret     nz
        ld      a,$5f
        ret
k_decode_10:
        ld      a,$40
        ret


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
        defw    reloc_3+2
        defw    reloc_4+2
        defw    reloc_5+2
        defw    reloc_6+2
        defw    reloc_7+2
        defw    reloc_8+2
        defw    reloc_9+2
        defw    reloc_10+2
        defw    reloc_11+2
        defw    reloc_12+2
reloc_end:

