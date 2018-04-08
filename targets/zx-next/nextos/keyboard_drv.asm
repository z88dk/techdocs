; ***************************************************************************
; * Example NextOS keyboard driver file                                     *
; ***************************************************************************
;
; This file generates the actual keyboard.drv file which can be installed
; using the .install command, to replace the built-in keyboard driver.
;
; The driver itself (keyboard.asm) must first be built.
;
; Assemble this file with: pasmo keyboard_drv.asm keyboard.drv


; ***************************************************************************
; * Definitions                                                             *
; ***************************************************************************
; Pull in the symbol file for the driver itself and calculate the number of
; relocations used.

        include "keyboard.sym"

relocs  equ     (reloc_end-reloc_start)/2


; ***************************************************************************
; * .DRV file header                                                        *
; ***************************************************************************
; The keyboard driver id is always zero (bit 7 may be set but will always be
; treated as if it is set, since the keyboard driver is always called on
; interrupts).

        org     $0000

        defm    "NDRV"          ; .DRV file signature

        defb    $00             ; keyboard driver id

        defb    relocs          ; number of relocation entries (0..255)

        defb    0               ; number of additional 8K DivMMC RAM banks

        defb    0               ; number of additional 8K Spectrum RAM banks


; ***************************************************************************
; * Driver binary                                                           *
; ***************************************************************************
; The driver + relocation table should now be included.

        incbin  "keyboard.bin"

