; ***************************************************************************
; * Streaming file access example code for NextOS via esxDOS API            *
; ***************************************************************************
; Assemble with: pasmo stream.asm stream.bin
;
; Execute with stream.bin and test.scr (any 6912-byte headerless screen file)
; in the same directory, using:
;
; CLEAR 32767:LOAD "stream.bin" CODE 32768
; LET x=USR 32768
;
; PRINT x to show any esxDOS error code on return.
; Additionally, 255 means "out of data"
; and 65535 means "completed successfully".


; ***************************************************************************
; * esxDOS API and other definitions required                               *
; ***************************************************************************

; Calls
f_open                  equ     $9a             ; opens a file
f_close                 equ     $9b             ; closes a file
disk_filemap            equ     $85             ; obtains map of file data
disk_strmstart          equ     $86             ; begin streaming operation
disk_strmend            equ     $87             ; end streaming operation

; File access modes
esx_mode_read           equ     $01             ; read access
esx_mode_open_exist     equ     $00             ; open existing files only

; Next registers
next_register_select    equ     $243b
nxr_peripheral2         equ     $06

; Size of filemap buffer (in 6-byte entries)
; To guarantee all entries will fit in the filemap at once, allow 1 entry for
; every 2K of filesize. The example uses a 6.75K SCREEN$, so 4 entries is
; sufficient.
; (NOTE: Reducing this to 1 *may* force the example code to refill the filemap
;        multiple times, but only if your card has a cluster size of 2K or 4K
;        and the file is fragmented).
filemap_size            equ     4


; ***************************************************************************
; * Initialisation                                                          *
; ***************************************************************************

        org     $8000

; Before starting we will disable the Multiface button, since filesystem
; access will not be possible during a streaming operation, and could cause
; unexpected effects, including possibly the machine locking up until a soft
; reset is performed.

        ld      bc,next_register_select
        ld      a,nxr_peripheral2
        out     (c),a
        inc     b
        in      a,(c)                   ; get current peripheral2 value
        and     %11110111               ; clear bit 3 (multiface enable)
        out     (c),a

; First the file must be opened in the normal way

        ld      a,'*'                   ; use default drive if none specified
        ld      ix,test_filename
        ld      b,esx_mode_read+esx_mode_open_exist
        rst     $08
        defb    f_open
        jp      c,exit_with_error
        ld      (filehandle),a          ; store the returned file handle

; For this example, we are going to "stream" a standard Spectrum SCREEN$
; file to the screen. This is a convenient point to set up parameters
; for this.

        ld      hl,$4000                ; address to stream data to
        ld      de,6912                 ; size of data left to stream
        exx                             ; save in alternate registers


; ***************************************************************************
; * Filemap buffer setup                                                    *
; ***************************************************************************

; Next, obtain the map of card addresses for the file.
; Note that this call (DISK_FILEMAP) must be made directly after opening the
; file - no other file access calls should be made first.
;
; A buffer must be provided to hold the card addresses.
;
; Each entry in the buffer occupies 6 bytes and describes an area of the
; file which can be anywhere between 2K and 32MB in size (depending on the
; way the card was formatted, and how fragmented the file is).
; Therefore, it is possible to calculate the absolute maximum number of buffer
; entries required by dividing the size of the file by 2K.
;
; It is also possible to use a smaller buffer and call disk_filemap multiple
; times when a refill is required (provided the last streaming operation has
; been stopped before the next disk_filemap call is made).
;
; Often, files are unfragmented, and so will use only 1 entry. You could
; potentially write your code to assume this (which would therefore be simpler
; than this example), and cause an error if more than 1 entry is returned,
; citing "framentation" and suggesting the user run the .defrag dot command
; on the file. (Note that some CompactFlash, and other IDE, may be limited
; to a maximum section size of 64K).
;
; The byte/block addressing flag returned in bit 1 of A may be useful if you
; wish to start streaming data from a particular 512-byte block offset within
; the file, as it indicates how to adjust the 4-byte card addresses:
;   if bit 1 of A=0, then add 512 to the card address for every block
;   if bit 1 of A=1, then add 1 to the card address for every block

refill_map:
        ld      a,(filehandle)
        ld      ix,filemap_buffer       ; address of buffer
        ld      de,filemap_size         ; size of buffer (in 6-byte entries)
        rst     $08
        defb    disk_filemap
        jp      c,close_and_exit_with_error

; On exit from disk_filemap, the return values are:
;       DE=size of buffer unused (in 6-byte entries)
;       HL=address in buffer after last written entry
;       A=flags: bit 0=card id (0 or 1)
;                bit 1=0 for byte addressing, 1 for block addressing

        ld      (cardflags),a           ; store card flags for later use

; First we will check whether there were any entries returned, and exit with
; a dummy error code ($ff) not used by esxDOS to indicate "out of data" if not.

        push    hl
        ld      de,filemap_buffer       ; initialise buffer address
;       and     a                       ; not needed as no error, so carry=0
        sbc     hl,de                   ; any entries in the buffer at all?
        pop     hl
        ld      a,$ff                   ; dummy error to indicate out of data
        jr      z,close_and_exit_with_error


; ***************************************************************************
; * Main streaming loop                                                     *
; ***************************************************************************
; Now we can enter a loop to stream data from each entry in the buffer.

stream_loop:
        push    hl                      ; save buffer end address
        ex      de,hl                   ; HL=address of next entry in buffer
        ld      e,(hl)
        inc     hl
        ld      d,(hl)
        inc     hl
        ld      c,(hl)
        inc     hl
        ld      b,(hl)                  ; BCDE=card address
        inc     hl
        push    bc
        pop     ix                      ; IXDE=card address
        ld      c,(hl)
        inc     hl
        ld      b,(hl)                  ; BC=number of 512-byte blocks
        inc     hl
        push    hl                      ; save updated buffer address
        push    bc                      ; save number of blocks

; Streaming is initiated by calling DISK_STRMSTART with:
;       IXDE=card address
;       BC=number of 512-byte blocks to stream
;       A=card flags, as returned by DISK_FILEMAP
; After this call is issued it is important that no further esxDOS calls
; (or NextOS calls which might access a filesystem) are issued until the
; matching DISK_STRMEND call has been made.
; It is also important to ensure that the Multiface (which could access files)
; is disabled for the duration of the streaming operation. (Done earlier in
; this example).

        ld      a,(cardflags)           ; A=card flags
        rst     $8
        defb    disk_strmstart
        pop     ix                      ; retrieve number of blocks to IX
        jr      c,drop2_close_and_exit_with_error

; If successful, the call returns with:
;       B=protocol: 0=SD/MMC, 1=IDE
;       C=data port
; NOTE: On the Next, these values will always be:
;       B=0
;       C=$EB
; Therefore, your code code be slightly faster and simpler if writing a
; Next-only program. However, these values are provided to allow portable
; streaming code to be written (if NextOS is later ported to other platforms).

        ld      a,c
        exx                             ; switch back to "streaming set"
                                        ; HL=address, DE=bytes to stream
        ld      c,a                     ; C=data port


; ***************************************************************************
; * Block streaming loop                                                    *
; ***************************************************************************

stream_block_loop:
        ld      b,0                     ; prepare for 256-byte INIR

        ld      a,d
        cp      2                       ; at least 1 block to stream?
        jr      c,stream_partial_block

; Read an entire 512-byte block of data.
; These could be unrolled to INIs for maximum performance.

        inir                            ; read 512 bytes from the port
        inir
        dec     d                       ; update byte count
        dec     d

; Check the protocol being used.
        exx
        ld      a,b                     ; A=protocol (0=SD/MMC, 1=IDE)
        exx
        and     a                       ; The IDE protocol doesn't need
        jr      nz,protocol_ide         ; this end-of-block processing

; For SD protocol we must next skip the 2-byte CRC for the block just read.
; Note that maximum performance of the interface is 16T per byte, so nops
; must be added if not using INI/OUTI.
; The interface can run at CPU speeds of at least 21MHz (as in ZX-Badaloc).

        in      a,(c)
        nop
        in      a,(c)
        nop

; And then wait for a token of $FE, signifying the start of the next block.
; A value of $FF indicates "token not yet available". Any other value is an
; error.

wait_token:
        in      a,(c)                   ; wait for start of next block
        cp      $ff                     ; (a token is != $ff)
        jr      z,wait_token
        cp      $fe                     ; the correct data token is $fe
        jr      nz,token_error          ; anything else is an error

; IDE protocol streaming can rejoin here.
protocol_ide:
        ld      a,d                     ; check if any more bytes needed
        or      e
        jr      z,streaming_complete

        dec     ix                      ; decrement block count
        ld      a,ixl
        or      ixh
        jr      nz,stream_block_loop    ; continue until all blocks streamed

        exx                             ; switch "streaming set" to alternates


; ***************************************************************************
; * Main streaming loop end                                                 *
; ***************************************************************************
; After all the 512-byte blocks for a particular card address have been
; streamed, the DISK_STRMEND call must be made. This just requires A=cardflags.

        ld      a,(cardflags)
        rst     $08
        defb    disk_strmend
        jr      c,drop2_close_and_exit_with_error

; Following disk_strmend, the system is back in a state where any other esxdos
; calls may now be used, including (if necessary) DISK_FILEMAP to refill the
; buffer. This can be an expensive call, though, so it would be preferable to
; ensure that the buffer is large enough to be filled with the first call.
; This would also simplify the code a little.

        pop     de                      ; DE=current buffer address
        pop     hl                      ; HL=ending buffer address
;       and     a                       ; not needed; carry=0 since no error
        sbc     hl,de                   ; any more entries left in buffer?
        jr      z,refill_map            ; if not, refill
        add     hl,de                   ; re-form ending address
        jr      stream_loop             ; back for next entry in the buffer


; ***************************************************************************
; * Stream a partial block                                                  *
; ***************************************************************************
; It is entirely okay to stream a partial block, since the streaming operation
; can be terminated at any point by issuing the DISK_STRMEND call.

stream_partial_block:
        and     a                       ; at least 256 bytes left?
        jr      z,stream_final_bytes

        inir                            ; read 256 bytes from the port

stream_final_bytes:
        ld      b,e
        inc     b
        dec     b
        jr      z,streaming_complete

        inir                            ; read last few bytes from the port

streaming_complete:
        ld      a,(cardflags)
        rst     $08
        defb    disk_strmend            ; terminate the streaming operation
        jr      drop2_close_and_exit_with_error


; ***************************************************************************
; * Tidy up and exit                                                        *
; ***************************************************************************

token_error:
        ld      a,$ff                   ; dummy error to indicate out of data
        scf

drop2_close_and_exit_with_error:
        pop     hl                      ; discard buffer addresses
        pop     hl

close_and_exit_with_error:
        push    af                      ; save error status

        ld      a,(filehandle)
        rst     $08
        defb    f_close

        pop     af                      ; restore error status

exit_with_error:
        ld      hl,$2758
        exx                             ; BASIC requires H'L'=$2758 on return
        ld      b,0
        ld      c,a                     ; BC=error, for return to BASIC
        ret     c                       ; exit if there was an error
        ld      bc,$ffff                ; use 65535 to indicate "no error"
        ret


; ***************************************************************************
; * Data                                                                    *
; ***************************************************************************

test_filename:
        defm    "test.scr",0            ; filenames must be null-terminated

filehandle:
        defb    0

filemap_buffer:
        defs    filemap_size*6          ; allocate 6 bytes per entry

cardflags:
        defb    0

