; ***************************************************************************
; * Simple example NextOS driver file                                       *
; ***************************************************************************
;
; This file generates the actual mouse.drv file which can be installed or
; uninstalled using the .install/.uninstall commands.
;
; The driver itself (mouse.asm) must first be built.
;
; Assemble this file with: pasmo mouse_drv.asm mouse.drv


; ***************************************************************************
; * Definitions                                                             *
; ***************************************************************************
; Pull in the symbol file for the driver itself and calculate the number of
; relocations used.

        include "mouse.sym"

relocs  equ     (reloc_end-reloc_start)/2


; ***************************************************************************
; * .DRV file header                                                        *
; ***************************************************************************
; The driver id must be unique, so current documentation on other drivers
; should be sought before deciding upon an id. This example uses $7f as a
; fairly meaningless value. A network driver might want to identify as 'N'
; for example.

        org     $0000

        defm    "NDRV"          ; .DRV file signature

        defb    $7e+$80         ; 7-bit unique driver id in bits 0..6
                                ; bit 7=1 if to be called on IM1 interrupts

        defb    relocs          ; number of relocation entries (0..255)

        defb    0               ; number of additional 8K DivMMC RAM banks
                                ; required (0..8)

        defb    0               ; number of additional 8K Spectrum RAM banks
                                ; required (0..200)


; ***************************************************************************
; * Driver binary                                                           *
; ***************************************************************************
; The driver + relocation table should now be included.

        incbin  "mouse.bin"


; ***************************************************************************
; * Additional bank images and patches                                      *
; ***************************************************************************
; If any 8K DivMMC RAM banks or 8K Spectrum RAM banks were requested, then
; preloaded images and patch lists should be provided.
;
;       First, for each mmcbank requested:
;
;       defb    bnk_patches     ; number of driver patches for this bank id
;       defw    bnk_size        ; size of data to pre-load into bank (0..8191)
;       defs    bnk_size        ; data to pre-load into bank
;       defs    bnk_patches*2   ; for each patch, a 2-byte offset (0..511) in
;                               ; the 512-byte driver to write the bank id to
;       NOTE: The first patch for each mmcbank should never be changed, as
;             .uninstall will use the value for deallocating.
;
;       Then, for each zxbank requested:
;
;       defb    bnk_patches     ; number of driver patches for this bank id
;       defw    bnk_size        ; size of data to pre-load into bank (0..8191)
;       defs    bnk_size        ; data to pre-load into bank
;       defs    bnk_patches*2   ; for each patch, a 2-byte offset (0..511) in
;                               ; the 512-byte driver to write the bank id to
;       NOTE: The first patch for each zxbank should never be changed, as
;             .uninstall will use the value for deallocating.

