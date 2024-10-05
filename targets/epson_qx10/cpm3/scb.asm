	title 'System Control Block Definition for CP/M3 BIOS'
; Dec 82 Beta disc
; Nov26 83 @COCOL & @COROW added
; Dec12 83 @LECHO added
; Feb14 84 @CMBA added

;--------------------------------------------------------------------
; The SYSTM CONTROL BLOCK (SCB) is a 100-byte data structure
; located in the BDOS. The SCB contains flags and data used by the
; CCP, the BDOS, the BIOS and other system components.

; In this file the high order byte of the various SCB addresses is
; defnied as 0FEH. The linker (V1.3A) marks absolute external equates
; as page relocatable when it is generating a System Page Relocatable
; (SPR) format file. GENCPM changes these addresses to point to the
; actual SCB in the BDOS.
;-------------------------------------------------------------------- 

	public @civec, @covec, @aivec, @aovec, @lovec, @bnkbf
	public @crdma, @bflgs
	public @crdsk, @vinfo, @resel, @fx, @usrcd, @ermde
	public @date, @hour, @min, @sec, ?erjmp, @mxtpa
; the following PUBLIC entries were not in BETA disk but were in System Guide
	public @MLTIO, @ERDSK, @MEDIA
; the following PUBLIC entries are from programers guide
	public @COCOL, @COROW ,@LECHO, @CMBA


scb$base equ    0FE00H          ; Base of the SCB

@COCOL  equ     scb$base+1ah    ; Console Width (columns) base 0
                                ; Vector (byte, r/w) (default 79)
@COROW  equ     scb$base+1ch    ; Console Page Length
                                ; Vector (byte, r/w) (default 24)
@CIVEC  equ     scb$base+22h    ; Console Input Redirection 
                                ; Vector (word, r/w)
@COVEC  equ     scb$base+24h    ; Console Output Redirection 
                                ; Vector (word, r/w)
@AIVEC  equ     scb$base+26h    ; Auxiliary Input Redirection 
                                ; Vector (word, r/w)
@AOVEC  equ     scb$base+28h    ; Auxiliary Output Redirection 
                                ; Vector (word, r/w)
@LOVEC  equ     scb$base+2Ah    ; List Output Redirection 
                                ; Vector (word, r/w)
@BNKBF  equ     scb$base+35h    ; Address of 128 Byte Buffer 
                                ; for Banked BIOS (word, r/o)
@LECHO  equ     scb$base+38h    ; List Output Echo of Console flag
                                ; (byte, r/w)
@CRDMA  equ     scb$base+3Ch    ; Current DMA Address 
                                ; (word, r/o)
@CRDSK  equ     scb$base+3Eh    ; Current Disk (byte, r/o)
@VINFO  equ     scb$base+3Fh    ; BDOS Variable "INFO" 
                                ; (word, r/o)
@RESEL  equ     scb$base+41h    ; FCB Flag (byte, r/o)
@FX     equ     scb$base+43h    ; BDOS Function for Error 
                                ; Messages (byte, r/o)
@USRCD  equ     scb$base+44h    ; Current User Code (byte, r/o)
@MLTIO	equ	scb$base+4Ah	; Current Multi-Sector Count
				; (byte, r/w)
@ERMDE  equ     scb$base+4Bh    ; BDOS Error Mode (byte, r/o)
@ERDSK	equ	scb$base+51h	; BDOS Error Disk (byte, r/o)
@MEDIA	equ	scb$base+54h	; Set by BIOS to indicate open door
				; (byte, r/w)
@BFLGS  equ     scb$base+57h    ; BDOS Message Size Flag (byte,r/o)  
@DATE   equ     scb$base+58h    ; Date in Days Since 1 Jan 78 
                                ; (word, r/w)
@HOUR   equ     scb$base+5Ah    ; Hour in BCD (byte, r/w)
@MIN    equ     scb$base+5Bh    ; Minute in BCD (byte, r/w)
@SEC    equ     scb$base+5Ch    ; Second in BCD (byte, r/w)

@CMBA	equ	scb$base+5dh	; Common memory base address (0 for unbanked)
                                ; (word, r/0)

?ERJMP  equ     scb$base+5Fh    ; BDOS Error Message Jump
                                ; (3 bytes, r/w)
@MXTPA  equ     scb$base+62h    ; Top of User TPA 
                                ; (address at 6,7)(word, r/o)
	end
