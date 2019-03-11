


; NOTE: the code listed in this disassembly is not complete, nor the proper bank switching was considered !



; ___________ information collected so far about the memory banks ___________


;  FFFFh                   |----Reserved-----|
;  D400h                   |----CPM CCP------|
;                          |                 |
;                          |    User RAM     |
;                          |                 |
;                          |                 |
;  4000h                   |-----------------|-----------------|
;  3000h  |----PCG RAM-----|      ROM 2      |                 |
;  2800h  |---Colour RAM---|                 |    Lower CPM    |
;  2000h  |-- Screen RAM---|-----------------|      memory     |
;                          |      ROM 1      |                 |
;  0100h                   |                 |-----------------|
;  0000h                   |-----------------|--CPM-reserved---|
;
;              bank 2            bank 1            bank 3


; Bank 1 is what we see in LEVEL II basic when we use the peek & poke commands.
; Bank 3 is the extra ram allocated to cpm
; Bank 2 is the Screen RAM

; Turns screen ram on from ROM BASIC
;      in      a,(50h)        ; get system status
;      set     0,a
;      out     (70h),a        ; Set system status

; Turns screen ram off from ROM BASIC
;      in      a,(50h)        ; get system status
;      res     0,a
;      out     (70h),a        ; Set system status

; _____________________________________________________________________________



0000 f3        di      
0001 c30001    jp      0100h

0004 00        nop     
0005 00        nop     
0006 00        nop     
0007 00        nop     

;   SYNCHR: Check syntax: next byte holds the byte to be found
0008 c3c0fb    jp      0fbc0h

000b 1e2c      ld      e,2ch
000d c38c28    jp      288ch        ; ERROR, E=error code

; CHRGTB: Gets next character (or token) from BASIC text.
0010 c3c3fb    jp      0fbc3h

;  Memory Overflow (MO ERROR) entry
0013 1e28      ld      e,28h
0015 c38c28    jp      288ch        ; ERROR, E=error code

; DCOMPR - Compare HL with DE.
0018 c3c6fb    jp      0fbc6h

001b af        xor     a
001c d3e4      out     (0e4h),a
001e 18e0      jr      0000h

0020 c3c9fb    jp      0fbc9h        ; __CHRCKB ?

0023 00        nop     
0024 00        nop     
0025 00        nop     
0026 00        nop     
0027 00        nop     

0028 c3ccfb    jp      0fbcch

002b 00        nop     
002c 00        nop     
002d 00        nop     
002e 00        nop     
002f 00        nop     
0030 c3cffb    jp      0fbcfh

0033 00        nop     
0034 00        nop     
0035 00        nop     
0036 00        nop     
0037 00        nop     

0038 c3d2fb    jp      0fbd2h    ; Interrupt exit - initialised to a return

003b 00        nop     
003c 00        nop     
003d 00        nop     
003e 00        nop     
003f 00        nop     

0040 c30d03    jp      030dh    ; Console output routine
0043 c3ea09    jp      09eah    ; Console status routine
0046 c3ac09    jp      09ach    ; Console input routine
0049 c3fa08    jp      08fah    ; Console line input routine
004c c36504    jp      0465h    ; Cursor on routine
004f c36e04    jp      046eh    ; Cursor off routine
0052 c37606    jp      0676h    ; LO-RES Selection routine
0055 c37c06    jp      067ch    ; HI-RES Selection routine
0058 c3e304    jp      04e3h    ; Clear screen routine
005b c3c80b    jp      0bc8h    ; Print routine
005e c32d0c    jp      0c2dh    ; List routine
0061 c3450c    jp      0c45h    ; List status routine
0064 c34b02    jp      024bh    ; RS232 Output routine
0067 c35602    jp      0256h    ; RS232 Status routine
006a c35e02    jp      025eh    ; RS232 Input routine
006d c39e07    jp      079eh    ; Cassette read on routine
0070 c3c907    jp      07c9h    ; Casette read routine
0073 c32307    jp      0723h    ; Cassette write on routine
0076 c33d07    jp      073dh    ; Cassette output routine
0079 c38007    jp      0780h    ; Cassette off routine
007c c3b606    jp      06b6h    ; Turns CRTC on
007f c3ae06    jp      06aeh    ; Turns CRTC off
0082 c31005    jp      0510h    ; Fills BC bytes at HL with A
0085 c3cc06    jp      06cch    ; Loads CRTC regs with B+1 bytes dwn from HL
0088 c36806    jp      0668h    ; Turns screen ram on
008b c36f06    jp      066fh    ; Turns screen ram off
008e c3e918    jp      18e9h    ; GETWORD_HL: Floating point to Integer
0091 c31b19    jp      191bh    ; Integer to single precision
0094 c3d61c    jp      1cd6h    ; ASCII to Binary conversion
0097 c3281e    jp      1e28h    ; Floating point to ASCII
009a c38015    jp      1580h    ; Single precision add
009d c37d15    jp      157dh    ; Single precision subtract
00a0 c3b116    jp      16b1h    ; Single precision multiply
00a3 c38433    jp      3384h    ; Single precision division
00a6 c37618    jp      1876h    ; Single precision compare
00a9 c3e117    jp      17e1h    ; Absolute value
00ac c3a119    jp      19a1h    ; Return Integer
00af c32724    jp      2427h    ; Arctangent
00b2 c3ab23    jp      23abh    ; Cosine
00b5 c3b123    jp      23b1h    ; Sine
00b8 c31224    jp      2412h    ; Tangent
00bb c31e18    jp      181eh    ; Move SP value in BC/DE into WRA1
00be c31b18    jp      181bh    ; Move a SP value -> HL to WRA1
00c1 c32c18    jp      182ch    ; LOADFP: Load SP value -> into BC/DE
00c4 c32918    jp      1829h    ; Load a SP value from WRA1 into BC/DE
00c7 c30e18    jp      180eh    ; Move WRA1 to stack
00ca c3162a    jp      2a16h    ; FIND_LNUM - Search for line number
00cd c30135    jp      3501h    ; GETVAR: Find address of variable
00d0 c39c2d    jp      2d9ch    ; Gosub routine
00d3 c3ca2d    jp      2dcah    ; Return entry point
00d6 c39b37    jp      379bh    ; Output a string
00d9 c3693a    jp      3a69h    ; Print message, text ptr in (HL)

00dc d9        exx
00dd 210042    ld      hl,4200h
00e0 cdf510    call    10f5h
00e3 af        xor     a
00e4 cd5e06    call    065eh
00e7 23        inc     hl
00e8 cb5c      bit     3,h
00ea 28f7      jr      z,00e3h
00ec d9        exx     
00ed c3590c    jp      0c59h

00f0 00        nop     
00f1 00        nop     
00f2 00        nop     
00f3 00        nop     
00f4 00        nop     
00f5 00        nop     
00f6 00        nop     
00f7 00        nop     
00f8 00        nop     
00f9 00        nop     
00fa 00        nop     
00fb 00        nop     
00fc 00        nop     
00fd 00        nop     
00fe 00        nop     
00ff 00        nop     



; Start

0100 210010    ld      hl,1000h
0103 2b        dec     hl
0104 7c        ld      a,h
0105 b5        or      l
0106 20fb      jr      nz,0103h
0108 3e4e      ld      a,4eh
010a d311      out     (11h),a
010c 3e37      ld      a,37h
010e d311      out     (11h),a
0110 3e81      ld      a,81h
0112 d363      out     (63h),a
0114 3e10      ld      a,10h
0116 d362      out     (62h),a
0118 210040    ld      hl,4000h
011b 3600      ld      (hl),00h
011d 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
0120 3600      ld      (hl),00h
0122 2a16fc    ld      hl,(0fc16h)
0125 11a5a5    ld      de,0a5a5h
0128 b7        or      a
0129 ed52      sbc     hl,de
012b 2037      jr      nz,0164h
012d 2a18fc    ld      hl,(0fc18h)
0130 115a7e    ld      de,7e5ah
0133 ed52      sbc     hl,de
0135 202d      jr      nz,0164h
0137 21e3fb    ld      hl,0fbe3h        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
013a cbbe      res     7,(hl)
013c 3ae2fb    ld      a,(0fbe2h)
013f 47        ld      b,a
0140 3a89fc    ld      a,(0fc89h)
0143 b8        cp      b
0144 2006      jr      nz,014ch
0146 db50      in      a,(50h)        ; get system status
0148 f604      or      04h
014a d370      out     (70h),a        ; Set system status
014c 2190fc    ld      hl,0fc90h    ; ESCAPE FLAG REGISTER
014f cb46      bit     0,(hl)
0151 c20702    jp      nz,0207h
0154 21ce10    ld      hl,10ceh
0157 cd0d11    call    110dh		; Output a string to video device
015a af        xor     a
015b 3201fe    ld      (0fe01h),a    ; AUTFLG: Auto increment flag 0 = no auto mode, otherwise line number
015e 010229    ld      bc,2902h
0161 c39828    jp      2898h
0164 3134fc    ld      sp,0fc34h
0167 3e3a      ld      a,3ah
0169 d323      out     (23h),a
016b d320      out     (20h),a
016d d320      out     (20h),a
016f 3e76      ld      a,76h
0171 d323      out     (23h),a
0173 3ed0      ld      a,0d0h
0175 d321      out     (21h),a
0177 af        xor     a
0178 d321      out     (21h),a
017a af        xor     a
017b 329dfc    ld      (0fc9dh),a

; Buid a JP table for common subroutines on top of RAM
017e 217224    ld      hl,2472h
0181 11c0fb    ld      de,0fbc0h
0184 014e00    ld      bc,004eh
0187 edb0      ldir    

0189 060c      ld      b,0ch
018b af        xor     a
018c 12        ld      (de),a
018d 13        inc     de
018e 10fc      djnz    018ch
0190 1134fc    ld      de,0fc34h
0193 21e127    ld      hl,27e1h
0196 012600    ld      bc,0026h
0199 edb0      ldir    
019b 21e1fe    ld      hl,0fee1h
019e 363a      ld      (hl),3ah
01a0 23        inc     hl
01a1 70        ld      (hl),b
01a2 23        inc     hl
01a3 362c      ld      (hl),2ch
01a5 23        inc     hl
01a6 22c7fd    ld      (0fdc7h),hl        ; Pointer to address of keyboard buffer
01a9 110b00    ld      de,000bh
01ac 0611      ld      b,11h
01ae 2172fe    ld      hl,0fe72h
01b1 36c3      ld      (hl),0c3h
01b3 23        inc     hl
01b4 73        ld      (hl),e
01b5 23        inc     hl
01b6 72        ld      (hl),d
01b7 23        inc     hl
01b8 10f7      djnz    01b1h
01ba 110300    ld      de,0003h
01bd 0614      ld      b,14h
01bf 36c9      ld      (hl),0c9h
01c1 19        add     hl,de
01c2 10fb      djnz    01bfh
01c4 21befb    ld      hl,0fbbeh
01c7 22d1fd    ld      (0fdd1h),hl        ; Memory size
01ca 11ceff    ld      de,0ffceh
01cd 19        add     hl,de
01ce 2254fc    ld      (0fc54h),hl        ; Address of string area boundary
01d1 cd372a    call    2a37h
01d4 21dd06    ld      hl,06ddh
01d7 1166fc    ld      de,0fc66h        ; LOW SCREEN RESOLUTION CRTC DATA
01da 012900    ld      bc,0029h
01dd edb0      ldir    
01df cd8f06    call    068fh
01e2 cd4a0c    call    0c4ah
01e5 cd8f06    call    068fh
01e8 cd6504    call    0465h            ; Cursor on routine
01eb 3e70      ld      a,70h
01ed 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output
01f0 21a5a5    ld      hl,0a5a5h
01f3 2216fc    ld      (0fc16h),hl
01f6 215a7e    ld      hl,7e5ah
01f9 2218fc    ld      (0fc18h),hl
01fc 2190fc    ld      hl,0fc90h        ; ESCAPE FLAG REGISTER
01ff 3601      ld      (hl),01h
0201 cdc902    call    02c9h
0204 caf00e    jp      z,0ef0h
0207 2190fc    ld      hl,0fc90h        ; ESCAPE FLAG REGISTER
020a 3600      ld      (hl),00h
020c 3e70      ld      a,70h
020e 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output
0211 21cd10    ld      hl,10cdh
0214 cd9b37    call    379bh			; Output a string
0217 216602    ld      hl,0266h
021a cd9b37    call    379bh			; Output a string
021d cd9d2a    call    2a9dh            ; INLIN
0220 38f5      jr      c,0217h
0222 d7        rst     10h                ; CHRGTB: Gets next character (or token) from BASIC text.

0223 2820      jr      z,0245h
0225 cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
0228 b7        or      a
0229 20ec      jr      nz,0217h
022b eb        ex      de,hl
022c 2b        dec     hl
022d 111444    ld      de,4414h
0230 df        rst     18h                ; DCOMPR - Compare HL with DE.
0231 38e4      jr      c,0217h
0233 ed5bd1fd  ld      de,(0fdd1h)        ; Memory size
0237 13        inc     de
0238 df        rst     18h                ; DCOMPR - Compare HL with DE.
0239 30dc      jr      nc,0217h
023b 22d1fd    ld      (0fdd1h),hl        ; Memory size
023e 11ceff    ld      de,0ffceh
0241 19        add     hl,de
0242 2254fc    ld      (0fc54h),hl        ; Address of string area boundary
0245 cd372a    call    2a37h
0248 c30329    jp      2903h

; RS232 Output routine
024b 08        ex      af,af'
024c db11      in      a,(11h)
024e e601      and     01h
0250 28fa      jr      z,024ch
0252 08        ex      af,af'
0253 d310      out     (10h),a
0255 c9        ret     

; RS232 Status routine
0256 db11      in      a,(11h)
0258 e602      and     02h
025a c8        ret     z
025b 3eff      ld      a,0ffh
025d c9        ret

; RS232 Input routine
025e cd5602    call    0256h			; RS232 Status routine
0261 28fb      jr      z,025eh
0263 db10      in      a,(10h)
0265 c9        ret

0266 0d        dec     c
0267 4d        ld      c,l
0268 65        ld      h,l
0269 6d        ld      l,l
026a 6f        ld      l,a
026b 72        ld      (hl),d
026c 79        ld      a,c
026d 2053      jr      nz,02c2h
026f 69        ld      l,c
0270 7a        ld      a,d
0271 65        ld      h,l
0272 00        nop     
0273 db50      in      a,(50h)        ; get system status
0275 e610      and     10h
0277 28fa      jr      z,0273h        ; wait for CSYNC - Composite video sync.signal 
0279 7e        ld      a,(hl)
027a cb9c      res     3,h
027c 1f        rra     
027d 300a      jr      nc,0289h
027f db50      in      a,(50h)        ; get system status
0281 e610      and     10h
0283 28fa      jr      z,027fh        ; wait for CSYNC - Composite video sync.signal 
0285 7e        ld      a,(hl)
0286 fec0      cp      0c0h
0288 3f        ccf     
0289 f5        push    af
028a db50      in      a,(50h)        ; get system status
028c e610      and     10h
028e 28fa      jr      z,028ah        ; wait for CSYNC - Composite video sync.signal 
0290 46        ld      b,(hl)
0291 f1        pop     af
0292 c9        ret

0293 f5        push    af
0294 cbdc      set     3,h
0296 db50      in      a,(50h)        ; get system status
0298 e610      and     10h
029a 28fa      jr      z,0296h        ; wait for CSYNC - Composite video sync.signal 
029c cbc6      set     0,(hl)
029e cb9c      res     3,h
02a0 06c0      ld      b,0c0h
02a2 70        ld      (hl),b
02a3 f1        pop     af
02a4 c9        ret

02a5 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
02a6 c39e07    jp      079eh		; Cassette read on routine

02a9 cdd2fe    call    0fed2h
02ac fe23      cp      23h
02ae c8        ret     z
02af fe40      cp      40h
02b1 c0        ret     nz
02b2 23        inc     hl
02b3 cdf639    call    39f6h        ; GETINT/EVAL
02b6 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
02b7 2c        defb    ','
02b8 e5        push    hl
02b9 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
02bc b7        or      a
02bd ed52      sbc     hl,de
02bf da352d    jp      c,2d35h            ; Error: Illegal function call (FC ERROR)
02c2 ed53ddfb  ld      (0fbddh),de        ; CURSOR POSITION relative to upper L.H. corner
02c6 e1        pop     hl
02c7 7e        ld      a,(hl)
02c8 c9        ret

02c9 cd283f    call    3f28h
02cc cd5910    call    1059h
02cf c9        ret

02d0 00        nop     
02d1 00        nop     
02d2 00        nop     
02d3 00        nop     
02d4 00        nop     
02d5 00        nop     
02d6 00        nop     
02d7 00        nop     
02d8 00        nop     
02d9 00        nop     
02da 00        nop     
02db 00        nop     
02dc 00        nop     
02dd 00        nop     
02de 00        nop     
02df 00        nop     
02e0 00        nop     
02e1 00        nop     
02e2 00        nop     
02e3 00        nop     
02e4 00        nop     
02e5 00        nop     
02e6 00        nop     
02e7 00        nop     


02e8 e5        push    hl
02e9 d5        push    de
02ea c5        push    bc
02eb cdf202    call    02f2h
02ee c1        pop     bc
02ef d1        pop     de
02f0 e1        pop     hl
02f1 c9        ret

02f2 f5        push    af
02f3 3efd      ld      a,0fdh
02f5 d361      out     (61h),a
02f7 db00      in      a,(00h)
02f9 feef      cp      0efh
02fb 200f      jr      nz,030ch
02fd 3ebf      ld      a,0bfh
02ff d361      out     (61h),a
0301 db00      in      a,(00h)
0303 fedf      cp      0dfh
0305 ccac09    call    z,09ach        ; Console input routine
0308 fe13      cp      13h
030a 28f9      jr      z,0305h
030c f1        pop     af

; Console output routine
030d 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
0310 cb46      bit     0,(hl)
0312 ca6303    jp      z,0363h
0315 cb86      res     0,(hl)
0317 cb7e      bit     7,(hl)
0319 c2b705    jp      nz,05b7h
031c cb56      bit     2,(hl)
031e c20906    jp      nz,0609h
0321 fe4a      cp      4ah
0323 ca4306    jp      z,0643h
0326 fe43      cp      43h
0328 ca9705    jp      z,0597h
032b fe3d      cp      3dh
032d ca9f05    jp      z,059fh
0330 fe48      cp      48h
0332 caa705    jp      z,05a7h
0335 fe49      cp      49h
0337 caad05    jp      z,05adh
033a fe31      cp      31h
033c caf6fb    jp      z,0fbf6h            ; Function 1 key exit - initialised to a return
033f fe32      cp      32h
0341 caf9fb    jp      z,0fbf9h            ; Function 2 key exit - initialised to a return
0344 fe33      cp      33h
0346 cafcfb    jp      z,0fbfch            ; Function 3 key exit - initialised to a return
0349 fe34      cp      34h
034b cafffb    jp      z,0fbffh            ; Function 4 key exit - initialised to a return
034e fe35      cp      35h
0350 ca02fc    jp      z,0fc02h            ; Function 5 key exit - initialised to a return
0353 fe36      cp      36h
0355 ca05fc    jp      z,0fc05h            ; Function 6 key exit - initialised to a return
0358 fe37      cp      37h
035a ca08fc    jp      z,0fc08h            ; Function 7 key exit - initialised to a return
035d fe38      cp      38h
035f ca0bfc    jp      z,0fc0bh            ; Function 8 key exit - initialised to a return
0362 c9        ret     

0363 fe20      cp      20h
0365 306a      jr      nc,03d1h
0367 fe0d      cp      0dh
0369 ca2e04    jp      z,042eh
036c 211804    ld      hl,0418h
036f e5        push    hl
0370 fe08      cp      08h
0372 ca5804    jp      z,0458h
0375 fe09      cp      09h
0377 ca6f05    jp      z,056fh
037a fe08      cp      08h
037c ca7704    jp      z,0477h
037f fe0c      cp      0ch
0381 ca8404    jp      z,0484h
0384 fe0a      cp      0ah
0386 ca9404    jp      z,0494h
0389 fe0b      cp      0bh
038b cab504    jp      z,04b5h
038e fe1a      cp      1ah
0390 cae304    jp      z,04e3h        ; Clear screen routine
0393 fe0e      cp      0eh
0395 ca2e04    jp      z,042eh
0398 fe1e      cp      1eh
039a cab305    jp      z,05b3h
039d e1        pop     hl
039e fe1b      cp      1bh
03a0 ca9105    jp      z,0591h
03a3 fe07      cp      07h
03a5 ca5b05    jp      z,055bh
03a8 fe16      cp      16h
03aa ca6504    jp      z,0465h        ; Cursor on routine
03ad fe15      cp      15h
03af ca6e04    jp      z,046eh        ; Cursor off routine
03b2 fe17      cp      17h
03b4 ca8206    jp      z,0682h
03b7 fe14      cp      14h
03b9 ca7c06    jp      z,067ch        ; HI-RES Selection routine
03bc fe1c      cp      1ch
03be ca1a05    jp      z,051ah
03c1 fe1d      cp      1dh
03c3 ca2805    jp      z,0528h
03c6 fe19      cp      19h
03c8 cab606    jp      z,06b6h			; Turns CRTC on
03cb fe18      cp      18h
03cd caae06    jp      z,06aeh			; Turns CRTC off
03d0 c9        ret     

03d1 ed5bddfb  ld      de,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
03d5 2adffb    ld      hl,(0fbdfh)
03d8 19        add     hl,de
03d9 cb9c      res     3,h
03db cbec      set     5,h
03dd 08        ex      af,af'
03de cd6806    call    0668h            ; Turns screen ram on
03e1 08        ex      af,af'
03e2 cd5e06    call    065eh
03e5 cbdc      set     3,h
03e7 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
03ea cd5e06    call    065eh
03ed cd6f06    call    066fh            ; Turns screen ram off
03f0 13        inc     de
03f1 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
03f4 b7        or      a
03f5 ed52      sbc     hl,de
03f7 301f      jr      nc,0418h
03f9 cd0f07    call    070fh
03fc 2adffb    ld      hl,(0fbdfh)
03ff 09        add     hl,bc
0400 cb9c      res     3,h
0402 22dffb    ld      (0fbdfh),hl
0405 cd3405    call    0534h
0408 2adffb    ld      hl,(0fbdfh)
040b 3e0d      ld      a,0dh
040d d330      out     (30h),a            ; CRTC register select
040f 0e31      ld      c,31h            ; CRTC data
0411 ed69      out     (c),l
0413 3d        dec     a
0414 d330      out     (30h),a            ; CRTC register select
0416 ed61      out     (c),h
0418 ed53ddfb  ld      (0fbddh),de        ; CURSOR POSITION relative to upper L.H. corner
041c 2adffb    ld      hl,(0fbdfh)
041f 19        add     hl,de
0420 3e0f      ld      a,0fh
0422 d330      out     (30h),a            ; CRTC register select
0424 0e31      ld      c,31h            ; CRTC data
0426 ed69      out     (c),l
0428 3d        dec     a
0429 d330      out     (30h),a            ; CRTC register select
042b ed61      out     (c),h
042d c9        ret

042e 08        ex      af,af'
042f cd0f07    call    070fh
0432 2addfb    ld      hl,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
0435 b7        or      a
0436 ed52      sbc     hl,de
0438 3007      jr      nc,0441h
043a eb        ex      de,hl
043b b7        or      a
043c ed42      sbc     hl,bc
043e eb        ex      de,hl
043f 18f1      jr      0432h
0441 08        ex      af,af'
0442 fe0d      cp      0dh
0444 c0        ret     nz
0445 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
0448 cb6e      bit     5,(hl)
044a 2803      jr      z,044fh
044c c31804    jp      0418h
044f eb        ex      de,hl
0450 09        add     hl,bc
0451 e5        push    hl
0452 cd1f05    call    051fh
0455 d1        pop     de
0456 1899      jr      03f1h
0458 ed5bddfb  ld      de,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
045c 7b        ld      a,e
045d b2        or      d
045e c8        ret     z
045f 1b        dec     de
0460 ed53ddfb  ld      (0fbddh),de        ; CURSOR POSITION relative to upper L.H. corner
0464 c9        ret     


; Cursor on routine
0465 3e0a      ld      a,0ah
0467 d330      out     (30h),a            ; CRTC register select
0469 3e60      ld      a,60h
046b d331      out     (31h),a            ; CRTC data
046d c9        ret     

; Cursor off routine
046e 3e0a      ld      a,0ah
0470 d330      out     (30h),a            ; CRTC register select
0472 3e20      ld      a,20h
0474 d331      out     (31h),a            ; CRTC data
0476 c9        ret


0477 ed5bddfb  ld      de,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
047b 1b        dec     de
047c 7a        ld      a,d
047d 3c        inc     a
047e c0        ret     nz
047f ed5be1fb  ld      de,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
0483 c9        ret     
0484 ed5bddfb  ld      de,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
0488 13        inc     de
0489 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
048c b7        or      a
048d ed52      sbc     hl,de
048f d0        ret     nc
0490 110000    ld      de,0000h
0493 c9        ret     

0494 2addfb    ld      hl,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
0497 cd0f07    call    070fh
049a 09        add     hl,bc
049b eb        ex      de,hl
049c 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
049f cb6e      bit     5,(hl)
04a1 2804      jr      z,04a7h
04a3 e1        pop     hl
04a4 c3f103    jp      03f1h
04a7 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
04aa ed52      sbc     hl,de
04ac d0        ret     nc
04ad eb        ex      de,hl
04ae 210000    ld      hl,0000h
04b1 ed52      sbc     hl,de
04b3 eb        ex      de,hl
04b4 c9        ret     

04b5 cd0f07    call    070fh
04b8 2addfb    ld      hl,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
04bb b7        or      a
04bc ed42      sbc     hl,bc
04be 3006      jr      nc,04c6h
04c0 ed5be1fb  ld      de,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
04c4 ed5a      adc     hl,de
04c6 eb        ex      de,hl
04c7 c9        ret     
04c8 2819      jr      z,04e3h			; Clear screen routine
04ca cdf639    call    39f6h            ; GETINT/EVAL
04cd 7a        ld      a,d
04ce b7        or      a
04cf c21c16    jp      nz,161ch            ; Overflow Error (OV ERROR)
04d2 7b        ld      a,e
04d3 fe08      cp      08h
04d5 d21c16    jp      nc,161ch            ; Overflow Error (OV ERROR)
04d8 07        rlca    
04d9 47        ld      b,a
04da 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
04dd e6f0      and     0f0h
04df b0        or      b
04e0 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output

; Clear screen routine
04e3 e5        push    hl
04e4 cdae06    call    06aeh			; Turns CRTC off
04e7 cd6806    call    0668h            ; Turns screen ram on
04ea 210020    ld      hl,2000h
04ed 01ff07    ld      bc,07ffh
04f0 3e20      ld      a,20h
04f2 cd1005    call    0510h			; Fills BC bytes at HL with A
04f5 01ff07    ld      bc,07ffh
04f8 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
04fb cd1005    call    0510h			; Fills BC bytes at HL with A
04fe cd6f06    call    066fh            ; Turns screen ram off
0501 cdb606    call    06b6h			; Turns CRTC on
0504 110000    ld      de,0000h
0507 ed53dffb  ld      (0fbdfh),de
050b cd0804    call    0408h
050e e1        pop     hl
050f c9        ret

; Fills BC bytes at HL with A
0510 77        ld      (hl),a
0511 23        inc     hl
0512 0b        dec     bc
0513 08        ex      af,af'
0514 78        ld      a,b
0515 b1        or      c
0516 c8        ret     z
0517 08        ex      af,af'
0518 18f6      jr      0510h

051a cd2e04    call    042eh
051d eb        ex      de,hl
051e 09        add     hl,bc
051f ed5bddfb  ld      de,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
0523 b7        or      a
0524 ed52      sbc     hl,de
0526 180a      jr      0532h
0528 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
052b ed5bddfb  ld      de,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
052f b7        or      a
0530 ed52      sbc     hl,de
0532 44        ld      b,h
0533 4d        ld      c,l
0534 2adffb    ld      hl,(0fbdfh)
0537 19        add     hl,de
0538 cbec      set     5,h
053a d5        push    de
053b 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
053e 5f        ld      e,a
053f cd6806    call    0668h            ; Turns screen ram on
0542 cb9c      res     3,h
0544 3e20      ld      a,20h
0546 cd5e06    call    065eh
0549 cbdc      set     3,h
054b 7b        ld      a,e
054c cd5e06    call    065eh
054f 23        inc     hl
0550 cba4      res     4,h
0552 0b        dec     bc
0553 78        ld      a,b
0554 b1        or      c
0555 20eb      jr      nz,0542h
0557 d1        pop     de
0558 c36f06    jp      066fh            ; Turns screen ram off
055b 015e01    ld      bc,015eh
055e cdaf0d    call    0dafh
0561 21ff7f    ld      hl,7fffh
0564 110100    ld      de,0001h
0567 ed52      sbc     hl,de
0569 20fc      jr      nz,0567h
056b cdba0d    call    0dbah
056e c9        ret     
056f 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
0572 cb6e      bit     5,(hl)
0574 2002      jr      nz,0578h
0576 e1        pop     hl
0577 c9        ret     
0578 cd2e04    call    042eh
057b 23        inc     hl
057c 3e07      ld      a,07h
057e a5        and     l
057f fe00      cp      00h
0581 c27b05    jp      nz,057bh
0584 19        add     hl,de
0585 eb        ex      de,hl
0586 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
0589 b7        or      a
058a ed52      sbc     hl,de
058c d0        ret     nc
058d 110000    ld      de,0000h
0590 c9        ret     

0591 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
0594 cbc6      set     0,(hl)
0596 c9        ret     

0597 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
059a cbd6      set     2,(hl)
059c cbc6      set     0,(hl)
059e c9        ret     
059f 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
05a2 cbfe      set     7,(hl)
05a4 cbc6      set     0,(hl)
05a6 c9        ret     
05a7 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
05aa cbee      set     5,(hl)
05ac c9        ret     

05ad 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
05b0 cbae      res     5,(hl)
05b2 c9        ret     
05b3 110000    ld      de,0000h
05b6 c9        ret     

05b7 cb76      bit     6,(hl)
05b9 201b      jr      nz,05d6h
05bb cbf6      set     6,(hl)
05bd cbc6      set     0,(hl)
05bf b7        or      a
05c0 d620      sub     20h
05c2 d8        ret     c
05c3 fe18      cp      18h
05c5 d0        ret     nc
05c6 3c        inc     a
05c7 210000    ld      hl,0000h
05ca 115000    ld      de,0050h
05cd 22ddfb    ld      (0fbddh),hl        ; CURSOR POSITION relative to upper L.H. corner
05d0 3d        dec     a
05d1 2818      jr      z,05ebh
05d3 19        add     hl,de
05d4 18fa      jr      05d0h
05d6 cbb6      res     6,(hl)
05d8 cbbe      res     7,(hl)
05da b7        or      a
05db d620      sub     20h
05dd d8        ret     c
05de fe50      cp      50h
05e0 d0        ret     nc
05e1 2addfb    ld      hl,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
05e4 3c        inc     a
05e5 3d        dec     a
05e6 2803      jr      z,05ebh
05e8 23        inc     hl
05e9 18fa      jr      05e5h
05eb eb        ex      de,hl
05ec cd1804    call    0418h
05ef c9        ret

05f0 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
05f3 cbd6      set     2,(hl)
05f5 cbc6      set     0,(hl)
05f7 cdac09    call    09ach        ; Console input routine
05fa e65f      and     5fh
05fc cd0d03    call    030dh        ; Console output routine
05ff cdac09    call    09ach        ; Console input routine
0602 e65f      and     5fh
0604 cd0d03    call    030dh        ; Console output routine
0607 af        xor     a
0608 c9        ret     
0609 cb4e      bit     1,(hl)
060b 201e      jr      nz,062bh
060d cbce      set     1,(hl)
060f cbc6      set     0,(hl)
0611 b7        or      a
0612 d641      sub     41h
0614 d8        ret     c
0615 fe10      cp      10h
0617 d0        ret     nc
0618 cb07      rlc     a
061a cb07      rlc     a
061c cb07      rlc     a
061e cb07      rlc     a
0620 47        ld      b,a
0621 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0624 e60f      and     0fh
0626 b0        or      b
0627 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output
062a c9        ret

062b cb8e      res     1,(hl)
062d cb96      res     2,(hl)
062f b7        or      a
0630 d641      sub     41h
0632 d8        ret     c
0633 fe08      cp      08h
0635 d0        ret     nc
0636 cb07      rlc     a
0638 47        ld      b,a
0639 3ae4fb    ld      a,(0fbe4h)
063c e6f1      and     0f1h
063e b0        or      b
063f 32e4fb    ld      (0fbe4h),a
0642 c9        ret

0643 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0646 47        ld      b,a
0647 e60e      and     0eh
0649 cb07      rlc     a
064b cb07      rlc     a
064d cb07      rlc     a
064f 4f        ld      c,a
0650 3e70      ld      a,70h
0652 a0        and     b
0653 cb0f      rrc     a
0655 cb0f      rrc     a
0657 cb0f      rrc     a
0659 b1        or      c
065a 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output
065d c9        ret

065e 08        ex      af,af'
065f db50      in      a,(50h)        ; get system status
0661 e610      and     10h
0663 28fa      jr      z,065fh        ; wait for CSYNC - Composite video sync.signal 
0665 08        ex      af,af'
0666 77        ld      (hl),a
0667 c9        ret     

; Turns screen ram on
0668 db50      in      a,(50h)        ; get system status
066a cbc7      set     0,a
066c d370      out     (70h),a        ; Set system status
066e c9        ret

; Turns screen ram off
066f db50      in      a,(50h)        ; get system status
0671 cb87      res     0,a
0673 d370      out     (70h),a        ; Set system status
0675 c9        ret     

; LO-RES Selection routine
0676 db50      in      a,(50h)        ; get system status
0678 e6fb      and     0fbh
067a 180d      jr      0689h

; HI-RES Selection routine
067c db50      in      a,(50h)        ; get system status
067e f604      or      04h
0680 1807      jr      0689h

0682 cdae06    call    06aeh		; Turns CRTC off
0685 db50      in      a,(50h)        ; get system status
0687 ee04      xor     04h

0689 d370      out     (70h),a        ; Set system status
068b e604      and     04h
068d 2009      jr      nz,0698h
068f ed5b86fc  ld      de,(0fc86h)        ; MAX No. of characters displayed in low resolution
0693 2175fc    ld      hl,0fc75h
0696 1807      jr      069fh

0698 ed5b88fc  ld      de,(0fc88h)        ; MAX No. of characters displayed in high resolution
069c 2185fc    ld      hl,0fc85h

069f ed53e1fb  ld      (0fbe1h),de        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
06a3 060f      ld      b,0fh
06a5 cdcc06    call    06cch			; Loads CRTC regs with B+1 bytes dwn from HL
06a8 cdb606    call    06b6h			; Turns CRTC on
06ab c3e304    jp      04e3h              ; Clear screen routine

06ae 3e01      ld      a,01h			; Turns CRTC off
06b0 d330      out     (30h),a            ; CRTC register select
06b2 af        xor     a
06b3 d331      out     (31h),a            ; CRTC data
06b5 c9        ret

06b6 3e01      ld      a,01h
06b8 d330      out     (30h),a            ; CRTC register select
06ba db50      in      a,(50h)            ; get system status
06bc e604      and     04h
06be 2006      jr      nz,06c6h
06c0 3a67fc    ld      a,(0fc67h)        ; No. of characters displayed in a horiz scan
06c3 d331      out     (31h),a            ; CRTC data
06c5 c9        ret

06c6 3a77fc    ld      a,(0fc77h)
06c9 d331      out     (31h),a            ; CRTC data
06cb c9        ret

06cc 0e31      ld      c,31h			; Loads CRTC regs with B+1 bytes dwn from HL
06ce 0d        dec     c                ; CRTC register select
06cf ed41      out     (c),b
06d1 0c        inc     c                ; CRTC data
06d2 edab      outd    
06d4 20f8      jr      nz,06ceh
06d6 0d        dec     c            ; CRTC register select
06d7 ed41      out     (c),b
06d9 0c        inc     c            ; CRTC data
06da edab      outd    
06dc c9        ret     



        ; LOW SCREEN RESOLUTION CRTC DATA, to be copied to $FC66
    
06dd    defb    0x3f    ; -> FC66  ......Total No. of character intervals in horiz scan
06de    defb    0x28    ; -> FC67  ......No. of characters displayed in a horiz scan
06df    defb    0x31    ; -> FC68  ......Horiz sync position    (values between 0x31 and 0x2F were used to center the display depending on the video monitor, possibly older ROMs had different values)
06e0    defb    0x05    ; -> FC69  ......horiz sync pulse width
06e1    defb    0x18    ; -> FC6A  ......Total No. of character lines
06e2    defb    0x0c    ; -> FC6B  ......Adjust for vertical sync
06e3    defb    0x18    ; -> FC6C  ......No of lines displayed by CRTC
06e4    defb    0x18    ; -> FC6D  ......Vertical sync position
06e5    defb    0x00    ; -> FC6E  ......Interlace mode
06e6    defb    0x0b    ; -> FC6F  ......crtc reg.9
06e7    defb    0x20    ; -> FC70  ......crtc reg.10    -> Cursor blinking
06e8    defb    0x0b    ; -> FC71  ......crtc reg 11
06e9    defb    0x00    ; -> FC72  ......crtc reg 12
06ea    defb    0x00    ; -> FC73  ......crtc reg 13
06eb    defb    0x00    ; -> FC74  ......crtc reg 14    -> cursor position (high byte)
06ec    defb    0x00    ; -> FC75  ......crtc reg 15    -> cursor position (low byte)



        ; HIGH SCREEN RESOLUTION CRTC DATA, to be copied to $FC76
        
06ed    defb    0x7f    ; -> FC76  ......Total No. of character intervals in horiz scan
06ee    defb    0x50    ; -> FC77  ......No. of characters displayed in a horiz scan
06ef    defb    0x62    ; -> FC78  ......Horiz sync position    (see above about video display centering)
06f0    defb    0x0a    ; -> FC79  ......horiz sync pulse width
06f1    defb    0x18    ; -> FC7A  ......Total No. of character lines
06f2    defb    0x0c    ; -> FC7B  ......Adjust for vertical sync
06f3    defb    0x18    ; -> FC7C  ......No of lines displayed by CRTC
06f4    defb    0x18    ; -> FC7D  ......Vertical sync position
06f5    defb    0x00    ; -> FC7E  ......Interlace mode
06f6    defb    0x0b    ; -> FC7F  ......crtc reg.9
06f7    defb    0x20    ; -> FC80  ......crtc reg.10    -> Cursor blinking
06f8    defb    0x0b    ; -> FC81  ......crtc reg 11
06f9    defb    0x00    ; -> FC82  ......crtc reg 12
06fa    defb    0x00    ; -> FC83  ......crtc reg 13
06fb    defb    0x00    ; -> FC84  ......crtc reg 14    -> cursor position (high byte)
06fc    defb    0x00    ; -> FC85  ......crtc reg 15    -> cursor position (low byte)



        ; MAX No. of characters displayed in low resolution, word value to DATA be copied to $FC86
006fd    defw    03bfh



        ; MAX No. of characters displayed in high resolution, word value to DATA be copied to $FC88
006ff    defw    077fh



0701 98        sbc     a,b
0702 03        inc     bc
0703 3007      jr      nc,070ch
0705 181f      jr      0726h
0707 03        inc     bc
0708 3f        ccf     
0709 06f8      ld      b,0f8h
070b 02        ld      (bc),a
070c f0        ret     p
070d 05        dec     b
070e 14        inc     d
070f ed5b8afc  ld      de,(0fc8ah)
0713 012800    ld      bc,0028h
0716 db50      in      a,(50h)        ; get system status
0718 e604      and     04h
071a c8        ret     z
071b ed5b8cfc  ld      de,(0fc8ch)
071f 015000    ld      bc,0050h
0722 c9        ret

; Cassette write on routine
0723 3ae3fb    ld      a,(0fbe3h)        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
0726 cbff      set     7,a
0728 32e3fb    ld      (0fbe3h),a        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
072b cd8b07    call    078bh
072e 0600      ld      b,00h
0730 af        xor     a
0731 cd3d07    call    073dh			; Cassette output routine
0734 10fa      djnz    0730h
0736 3ea5      ld      a,0a5h
0738 1803      jr      073dh			; Cassette output routine

073a cd3d07    call    073dh			; Cassette output routine
073d c5        push    bc
073e cd5707    call    0757h
0741 0608      ld      b,08h
0743 c5        push    bc
0744 cb0f      rrc     a
0746 d45707    call    nc,0757h
0749 dc6207    call    c,0762h
074c c1        pop     bc
074d 10f4      djnz    0743h
074f cd6207    call    0762h
0752 cd6207    call    0762h
0755 c1        pop     bc
0756 c9        ret     

0757 f5        push    af
0758 067d      ld      b,7dh
075a 3ae3fb    ld      a,(0fbe3h)        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
075d cbbf      res     7,a
075f 4f        ld      c,a
0760 1809      jr      076bh

0762 f5        push    af
0763 063d      ld      b,3dh
0765 3ae3fb    ld      a,(0fbe3h)        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
0768 cb27      sla     a
076a 4f        ld      c,a
076b c5        push    bc
076c 10fe      djnz    076ch
076e c1        pop     bc
076f 3e0e      ld      a,0eh
0771 d363      out     (63h),a
0773 c5        push    bc
0774 10fe      djnz    0774h
0776 c1        pop     bc
0777 3e0f      ld      a,0fh
0779 d363      out     (63h),a
077b 0d        dec     c
077c 20ed      jr      nz,076bh
077e f1        pop     af
077f c9        ret

0780 3ae3fb    ld      a,(0fbe3h)        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
0783 cb7f      bit     7,a
0785 c8        ret     z
0786 cbbf      res     7,a
0788 32e3fb    ld      (0fbe3h),a        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
078b c5        push    bc
078c 062e      ld      b,2eh
078e c5        push    bc
078f 019907    ld      bc,0799h
0792 c5        push    bc
0793 01003d    ld      bc,3d00h
0796 f5        push    af
0797 18d2      jr      076bh
0799 c1        pop     bc
079a 10f2      djnz    078eh
079c c1        pop     bc
079d c9        ret

; Cassette read on routine
079e d9        exx     
079f af        xor     a
07a0 cdc907    call    07c9h			; Casette read routine
07a3 fea5      cp      0a5h
07a5 20f9      jr      nz,07a0h
07a7 cd0f07    call    070fh
07aa 2adffb    ld      hl,(0fbdfh)
07ad 09        add     hl,bc
07ae cb9c      res     3,h
07b0 2b        dec     hl
07b1 2b        dec     hl
07b2 cbec      set     5,h
07b4 cd6806    call    0668h            ; Turns screen ram on
07b7 362a      ld      (hl),2ah
07b9 cbdc      set     3,h
07bb 36f0      ld      (hl),0f0h
07bd 23        inc     hl
07be 36f0      ld      (hl),0f0h
07c0 cb9c      res     3,h
07c2 362a      ld      (hl),2ah
07c4 cd6f06    call    066fh            ; Turns screen ram off
07c7 d9        exx     
07c8 c9        ret

; Casette read routine
07c9 c5        push    bc
07ca cd3a08    call    083ah
07cd cd3a08    call    083ah
07d0 fe1d      cp      1dh
07d2 38f9      jr      c,07cdh
07d4 3ae3fb    ld      a,(0fbe3h)        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
07d7 47        ld      b,a
07d8 cb20      sla     b
07da 05        dec     b
07db cd3a08    call    083ah
07de 10fb      djnz    07dbh
07e0 3e80      ld      a,80h
07e2 cdeb07    call    07ebh
07e5 cb1f      rr      a
07e7 30f9      jr      nc,07e2h
07e9 c1        pop     bc
07ea c9        ret

07eb c5        push    bc
07ec f5        push    af
07ed 3ae3fb    ld      a,(0fbe3h)        ; CASSETTE SPEED 01 = 1200 baud 02 = 600 baud  04 = 300 baud
07f0 47        ld      b,a
07f1 0e00      ld      c,00h
07f3 c5        push    bc
07f4 cd3a08    call    083ah
07f7 cd3a08    call    083ah
07fa 81        add     a,c
07fb 4f        ld      c,a
07fc 10f9      djnz    07f7h
07fe c1        pop     bc
07ff 48        ld      c,b
0800 cb40      bit     0,b
0802 2006      jr      nz,080ah
0804 cb3f      srl     a
0806 cb38      srl     b
0808 18f6      jr      0800h
080a fe1d      cp      1dh
080c f5        push    af
080d 79        ld      a,c
080e 3001      jr      nc,0811h
0810 07        rlca    
0811 07        rlca    
0812 91        sub     c
0813 3d        dec     a
0814 47        ld      b,a
0815 2805      jr      z,081ch
0817 cd3a08    call    083ah
081a 10fb      djnz    0817h
081c f1        pop     af
081d c1        pop     bc
081e 78        ld      a,b
081f c1        pop     bc
0820 c9        ret

0821 d9        exx     
0822 cd0f07    call    070fh
0825 2adffb    ld      hl,(0fbdfh)
0828 09        add     hl,bc
0829 2b        dec     hl
082a cbec      set     5,h
082c cb9c      res     3,h
082e cd6806    call    0668h            ; Turns screen ram on
0831 7e        ld      a,(hl)
0832 ee0a      xor     0ah
0834 77        ld      (hl),a
0835 cd6f06    call    066fh            ; Turns screen ram off
0838 d9        exx     
0839 c9        ret

083a c5        push    bc
083b db62      in      a,(62h)
083d 4f        ld      c,a
083e 0600      ld      b,00h
0840 04        inc     b
0841 db62      in      a,(62h)
0843 a9        xor     c
0844 cb5f      bit     3,a
0846 28f8      jr      z,0840h
0848 78        ld      a,b
0849 c1        pop     bc
084a c9        ret     
084b d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
084c cdc40e    call    0ec4h
084f cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0850 2c        defb    ','
0851 7a        ld      a,d
0852 08        ex      af,af'
0853 c5        push    bc
0854 cdf639    call    39f6h        ; GETINT/EVAL
0857 d5        push    de
0858 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0859 2c        defb    ','
085a cdf639    call    39f6h        ; GETINT/EVAL
085d eb        ex      de,hl
085e c1        pop     bc
085f b7        or      a
0860 ed42      sbc     hl,bc
0862 da1c16    jp      c,161ch            ; Overflow Error (OV ERROR)
0865 e3        ex      (sp),hl
0866 c5        push    bc
0867 cd2307    call    0723h			; Cassette write on routine
086a 3e2f      ld      a,2fh
086c cd3d07    call    073dh			; Cassette output routine
086f cd3a07    call    073ah
0872 08        ex      af,af'
0873 47        ld      b,a
0874 7e        ld      a,(hl)
0875 cdd90e    call    0ed9h
0878 23        inc     hl
0879 cd3d07    call    073dh			; Cassette output routine
087c 10f6      djnz    0874h
087e 3e5c      ld      a,5ch
0880 cd3d07    call    073dh			; Cassette output routine
0883 e1        pop     hl
0884 c1        pop     bc
0885 7c        ld      a,h
0886 cd3d07    call    073dh			; Cassette output routine
0889 7d        ld      a,l
088a cd3d07    call    073dh			; Cassette output routine
088d 78        ld      a,b
088e cd3d07    call    073dh			; Cassette output routine
0891 79        ld      a,c
0892 cd3d07    call    073dh			; Cassette output routine
0895 7e        ld      a,(hl)
0896 23        inc     hl
0897 cd3d07    call    073dh			; Cassette output routine
089a 0b        dec     bc
089b 78        ld      a,b
089c b1        or      c
089d 20f6      jr      nz,0895h
089f eb        ex      de,hl
08a0 c9        ret

08a1 e1        pop     hl
08a2 2b        dec     hl
08a3 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
08a4 e5        push    hl
08a5 f5        push    af
08a6 2803      jr      z,08abh
08a8 cdc40e    call    0ec4h
08ab c5        push    bc
08ac cd9e07    call    079eh			; Cassette read on routine
08af 0603      ld      b,03h
08b1 cdc907    call    07c9h			; Casette read routine
08b4 fe2f      cp      2fh
08b6 20f7      jr      nz,08afh
08b8 10f7      djnz    08b1h
08ba c1        pop     bc
08bb f1        pop     af
08bc 3e20      ld      a,20h
08be 2811      jr      z,08d1h
08c0 cdc907    call    07c9h			; Casette read routine
08c3 5f        ld      e,a
08c4 0a        ld      a,(bc)
08c5 cdd90e    call    0ed9h
08c8 bb        cp      e
08c9 20d6      jr      nz,08a1h
08cb 03        inc     bc
08cc 15        dec     d
08cd 20f1      jr      nz,08c0h
08cf 3e01      ld      a,01h
08d1 47        ld      b,a
08d2 cdc907    call    07c9h			; Casette read routine
08d5 fe5c      cp      5ch
08d7 2804      jr      z,08ddh
08d9 10f7      djnz    08d2h
08db 18c4      jr      08a1h
08dd e3        ex      (sp),hl
08de cdc907    call    07c9h			; Casette read routine
08e1 67        ld      h,a
08e2 cdc907    call    07c9h			; Casette read routine
08e5 6f        ld      l,a
08e6 cdc907    call    07c9h			; Casette read routine
08e9 47        ld      b,a
08ea cdc907    call    07c9h			; Casette read routine
08ed 4f        ld      c,a
08ee cdc907    call    07c9h			; Casette read routine
08f1 77        ld      (hl),a
08f2 23        inc     hl
08f3 0b        dec     bc
08f4 78        ld      a,b
08f5 b1        or      c
08f6 20f6      jr      nz,08eeh
08f8 e1        pop     hl
08f9 c9        ret     

; Console line input routine
08fa af        xor     a
08fb 324dfc    ld      (0fc4dh),a    ; Holds last character typed after break
08fe 32c6fd    ld      (0fdc6h),a    ; Current cursor position (column number)
0901 cdaefe    call    0feaeh
0904 cd6504    call    0465h        ; Cursor on routine
0907 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
090a 01ffff    ld      bc,0ffffh
090d cdb309    call    09b3h
0910 fe0d      cp      0dh
0912 287c      jr      z,0990h
0914 fe03      cp      03h
0916 2877      jr      z,098fh
0918 fe18      cp      18h
091a 2840      jr      z,095ch
091c 110d09    ld      de,090dh
091f d5        push    de
0920 fe20      cp      20h
0922 3013      jr      nc,0937h
0924 fe08      cp      08h
0926 281f      jr      z,0947h
0928 fe09      cp      09h
092a ca6309    jp      z,0963h
092d fe1a      cp      1ah
092f 2810      jr      z,0941h
0931 fe17      cp      17h
0933 cce802    call    z,02e8h
0936 c9        ret     
0937 04        inc     b
0938 05        dec     b
0939 c8        ret     z
093a 77        ld      (hl),a
093b 23        inc     hl
093c cde802    call    02e8h
093f 05        dec     b
0940 c9        ret     
0941 cdf202    call    02f2h
0944 d1        pop     de
0945 18b3      jr      08fah    ; Console line input routine
0947 78        ld      a,b
0948 b9        cp      c
0949 c8        ret     z
094a 2b        dec     hl
094b 3e08      ld      a,08h
094d cde802    call    02e8h
0950 3e20      ld      a,20h
0952 cde802    call    02e8h
0955 3e08      ld      a,08h
0957 cde802    call    02e8h
095a 04        inc     b
095b c9        ret     

095c cd4709    call    0947h
095f 20fb      jr      nz,095ch
0961 1897      jr      08fah    ; Console line input routine
0963 e5        push    hl
0964 c5        push    bc
0965 cd2e04    call    042eh
0968 eb        ex      de,hl
0969 2addfb    ld      hl,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
096c b7        or      a
096d ed52      sbc     hl,de
096f 3005      jr      nc,0976h
0971 ed5be1fb  ld      de,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
0975 19        add     hl,de
0976 7d        ld      a,l
0977 c1        pop     bc
0978 e1        pop     hl
0979 e607      and     07h
097b ed44      neg     
097d c608      add     a,08h
097f 5f        ld      e,a
0980 78        ld      a,b
0981 b7        or      a
0982 c8        ret     z
0983 3e20      ld      a,20h
0985 77        ld      (hl),a
0986 23        inc     hl
0987 cde802    call    02e8h
098a 05        dec     b
098b 1d        dec     e
098c c8        ret     z
098d 18f1      jr      0980h
098f 37        scf     
0990 f5        push    af
0991 3600      ld      (hl),00h
0993 3e0d      ld      a,0dh
0995 cd2e04    call    042eh
0998 cd6e04    call    046eh        ; Cursor off routine
099b f1        pop     af
099c 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
099f 2b        dec     hl
09a0 d8        ret     c
09a1 af        xor     a
09a2 c9        ret

09a3 cdc0fe    call    0fec0h
09a6 d9        exx     
09a7 cdea09    call    09eah        ; Console status routine
09aa d9        exx     
09ab c9        ret     
09ac cda309    call    09a3h        ; Console input routine
09af b7        or      a
09b0 c0        ret     nz
09b1 18f9      jr      09ach        ; Console input routine
09b3 e5        push    hl
09b4 c5        push    bc
09b5 cdea09    call    09eah        ; Console status routine
09b8 c1        pop     bc
09b9 e1        pop     hl
09ba b7        or      a
09bb c0        ret     nz
09bc 18f5      jr      09b3h
09be d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
09bf e5        push    hl
09c0 3a4dfc    ld      a,(0fc4dh)    ; Holds last character typed after break
09c3 b7        or      a
09c4 2006      jr      nz,09cch
09c6 cda309    call    09a3h
09c9 b7        or      a
09ca 2811      jr      z,09ddh
09cc f5        push    af
09cd af        xor     a
09ce 324dfc    ld      (0fc4dh),a    ; Holds last character typed after break
09d1 3c        inc     a
09d2 cd4b37    call    374bh		; MKTMST - Make temporary string
09d5 f1        pop     af
09d6 2af4fd    ld      hl,(0fdf4h)
09d9 77        ld      (hl),a
09da c37837    jp      3778h		; TSTOPL

09dd 217202    ld      hl,0272h
09e0 2241fe    ld      (0fe41h),hl        ; FACCU
09e3 3e03      ld      a,03h
09e5 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
09e8 e1        pop     hl
09e9 c9        ret     


; Console status routine
09ea af        xor     a
09eb d361      out     (61h),a
09ed db00      in      a,(00h)
09ef eeff      xor     0ffh
09f1 280f      jr      z,0a02h
09f3 0efe      ld      c,0feh
09f5 79        ld      a,c
09f6 d361      out     (61h),a
09f8 db00      in      a,(00h)
09fa eeff      xor     0ffh
09fc 200f      jr      nz,0a0dh
09fe cb01      rlc     c
0a00 38f3      jr      c,09f5h
0a02 21ac0d    ld      hl,0dach
0a05 af        xor     a
0a06 32d8fb    ld      (0fbd8h),a
0a09 22dafb    ld      (0fbdah),hl
0a0c c9        ret     
0a0d cd890a    call    0a89h
0a10 b7        or      a
0a11 28eb      jr      z,09feh
0a13 5f        ld      e,a
0a14 06ff      ld      b,0ffh
0a16 04        inc     b
0a17 1f        rra     
0a18 30fc      jr      nc,0a16h
0a1a 2ad8fb    ld      hl,(0fbd8h)
0a1d b7        or      a
0a1e ed42      sbc     hl,bc
0a20 2013      jr      nz,0a35h
0a22 2adafb    ld      hl,(0fbdah)
0a25 2b        dec     hl
0a26 7c        ld      a,h
0a27 b5        or      l
0a28 2803      jr      z,0a2dh
0a2a af        xor     a
0a2b 18dc      jr      0a09h
0a2d 21bc02    ld      hl,02bch
0a30 22dafb    ld      (0fbdah),hl
0a33 1816      jr      0a4bh
0a35 21c805    ld      hl,05c8h
0a38 2b        dec     hl
0a39 7d        ld      a,l
0a3a b4        or      h
0a3b 20fb      jr      nz,0a38h
0a3d db00      in      a,(00h)
0a3f eeff      xor     0ffh
0a41 cd890a    call    0a89h
0a44 bb        cp      e
0a45 20b7      jr      nz,09feh
0a47 ed43d8fb  ld      (0fbd8h),bc
0a4b 3eff      ld      a,0ffh
0a4d 3c        inc     a
0a4e cb19      rr      c
0a50 38fb      jr      c,0a4dh
0a52 07        rlca    
0a53 07        rlca    
0a54 07        rlca    
0a55 b0        or      b
0a56 4f        ld      c,a
0a57 0600      ld      b,00h
0a59 21200b    ld      hl,0b20h
0a5c 3efe      ld      a,0feh
0a5e d361      out     (61h),a
0a60 db00      in      a,(00h)
0a62 cb57      bit     2,a
0a64 2002      jr      nz,0a68h
0a66 cbf1      set     6,c
0a68 09        add     hl,bc
0a69 cb6f      bit     5,a
0a6b 7e        ld      a,(hl)
0a6c 200a      jr      nz,0a78h
0a6e fe61      cp      61h
0a70 3806      jr      c,0a78h
0a72 fe7b      cp      7bh
0a74 3002      jr      nc,0a78h
0a76 cbaf      res     5,a
0a78 fe3c      cp      3ch
0a7a d8        ret     c
0a7b 47        ld      b,a
0a7c 3efd      ld      a,0fdh
0a7e d361      out     (61h),a
0a80 db00      in      a,(00h)
0a82 cb67      bit     4,a
0a84 78        ld      a,b
0a85 c0        ret     nz
0a86 e61f      and     1fh
0a88 c9        ret     
0a89 cb41      bit     0,c
0a8b 2003      jr      nz,0a90h
0a8d e6db      and     0dbh
0a8f c9        ret     
0a90 cb49      bit     1,c
0a92 200d      jr      nz,0aa1h
0a94 cb5f      bit     3,a
0a96 2803      jr      z,0a9bh
0a98 e608      and     08h
0a9a c9        ret     
0a9b cb67      bit     4,a
0a9d 2849      jr      z,0ae8h
0a9f af        xor     a
0aa0 c9        ret     
0aa1 cb61      bit     4,c
0aa3 c0        ret     nz
0aa4 cb7f      bit     7,a
0aa6 281d      jr      z,0ac5h
0aa8 f5        push    af
0aa9 3efd      ld      a,0fdh
0aab d361      out     (61h),a
0aad db00      in      a,(00h)
0aaf cb67      bit     4,a
0ab1 cae20e    jp      z,0ee2h
0ab4 3efe      ld      a,0feh
0ab6 d361      out     (61h),a
0ab8 db00      in      a,(00h)
0aba cb57      bit     2,a
0abc ca0000    jp      z,0000h
0abf 79        ld      a,c
0ac0 d361      out     (61h),a
0ac2 f1        pop     af
0ac3 cbbf      res     7,a
0ac5 cb67      bit     4,a
0ac7 c8        ret     z
0ac8 f5        push    af
0ac9 3efe      ld      a,0feh
0acb d361      out     (61h),a
0acd db00      in      a,(00h)
0acf cb57      bit     2,a
0ad1 79        ld      a,c
0ad2 2804      jr      z,0ad8h
0ad4 d361      out     (61h),a
0ad6 f1        pop     af
0ad7 c9        ret     
0ad8 d361      out     (61h),a
0ada f1        pop     af
0adb 218ffc    ld      hl,0fc8fh        ; No.of lines displayed by screen
0ade cb56      bit     2,(hl)
0ae0 21f005    ld      hl,05f0h
0ae3 282f      jr      z,0b14h
0ae5 e6ef      and     0efh
0ae7 c9        ret     

0ae8 cb77      bit     6,a
0aea 2805      jr      z,0af1h
0aec 21f6fb    ld      hl,0fbf6h            ; Function 1 key exit - initialised to a return
0aef 1815      jr      0b06h
0af1 cb4f      bit     1,a
0af3 2805      jr      z,0afah
0af5 21f9fb    ld      hl,0fbf9h            ; Function 2 key exit - initialised to a return
0af8 180c      jr      0b06h
0afa cb47      bit     0,a
0afc 2805      jr      z,0b03h
0afe 21fcfb    ld      hl,0fbfch            ; Function 3 key exit - initialised to a return
0b01 1803      jr      0b06h
0b03 21fffb    ld      hl,0fbffh            ; Function 4 key exit - initialised to a return
0b06 3efe      ld      a,0feh
0b08 d361      out     (61h),a
0b0a db00      in      a,(00h)
0b0c cb57      bit     2,a
0b0e 2004      jr      nz,0b14h
0b10 110c00    ld      de,000ch
0b13 19        add     hl,de
0b14 e3        ex      (sp),hl
0b15 211e0b    ld      hl,0b1eh
0b18 e3        ex      (sp),hl
0b19 ed43d8fb  ld      (0fbd8h),bc
0b1d e9        jp      (hl)
0b1e af        xor     a
0b1f c9        ret     
0b20 72        ld      (hl),d
0b21 77        ld      (hl),a
0b22 77        ld      (hl),a
0b23 65        ld      h,l
0b24 09        add     hl,bc
0b25 09        add     hl,bc
0b26 61        ld      h,c
0b27 71        ld      (hl),c
0b28 13        inc     de
0b29 12        ld      (de),a
0b2a 14        inc     d
0b2b 2020      jr      nz,0b4dh
0b2d 2011      jr      nz,0b40h
0b2f 112e6d    ld      de,6d2eh
0b32 2f        cpl     
0b33 2c        inc     l
0b34 62        ld      h,d
0b35 62        ld      h,d
0b36 6e        ld      l,(hl)
0b37 6e        ld      l,(hl)
0b38 27        daa     
0b39 6c        ld      l,h
0b3a 0d        dec     c
0b3b 3b        dec     sp
0b3c 6a        ld      l,d
0b3d 67        ld      h,a
0b3e 6b        ld      l,e
0b3f 68        ld      l,b
0b40 34        inc     (hl)
0b41 323533    ld      (3335h),a
0b44 7f        ld      a,a
0b45 1b        dec     de
0b46 31315b    ld      sp,5b31h
0b49 6f        ld      l,a
0b4a 5d        ld      e,l
0b4b 70        ld      (hl),b
0b4c 75        ld      (hl),l
0b4d 74        ld      (hl),h
0b4e 69        ld      l,c
0b4f 79        ld      a,c
0b50 66        ld      h,(hl)
0b51 78        ld      a,b


0b52 76        halt    
0b53 63        ld      h,e
0b54 64        ld      h,h
0b55 73        ld      (hl),e
0b56 7a        ld      a,d
0b57 7a        ld      a,d
0b58 3d        dec     a
0b59 3008      jr      nc,0b63h
0b5b 2d        dec     l
0b5c 3836      jr      c,0b94h
0b5e 39        add     hl,sp
0b5f 37        scf     
0b60 52        ld      d,d
0b61 57        ld      d,a
0b62 57        ld      d,a
0b63 45        ld      b,l
0b64 09        add     hl,bc
0b65 09        add     hl,bc
0b66 41        ld      b,c
0b67 51        ld      d,c
0b68 13        inc     de
0b69 12        ld      (de),a
0b6a 14        inc     d
0b6b 2020      jr      nz,0b8dh
0b6d 2011      jr      nz,0b80h
0b6f 113e4d    ld      de,4d3eh
0b72 3f        ccf     
0b73 3c        inc     a
0b74 42        ld      b,d
0b75 42        ld      b,d
0b76 4e        ld      c,(hl)
0b77 4e        ld      c,(hl)
0b78 224c0d    ld      (0d4ch),hl
0b7b 3a4a47    ld      a,(474ah)
0b7e 4b        ld      c,e
0b7f 48        ld      c,b
0b80 24        inc     h
0b81 40        ld      b,b
0b82 25        dec     h
0b83 23        inc     hl
0b84 7f        ld      a,a
0b85 1b        dec     de
0b86 21217b    ld      hl,7b21h
0b89 4f        ld      c,a
0b8a 7d        ld      a,l
0b8b 50        ld      d,b
0b8c 55        ld      d,l
0b8d 54        ld      d,h
0b8e 49        ld      c,c
0b8f 59        ld      e,c
0b90 46        ld      b,(hl)
0b91 58        ld      e,b
0b92 56        ld      d,(hl)
0b93 43        ld      b,e
0b94 44        ld      b,h
0b95 53        ld      d,e
0b96 5a        ld      e,d
0b97 5a        ld      e,d
0b98 2b        dec     hl
0b99 29        add     hl,hl
0b9a 08        ex      af,af'
0b9b 5f        ld      e,a
0b9c 2a5e28    ld      hl,(285eh)
0b9f 26d9      ld      h,0d9h
0ba1 4f        ld      c,a
0ba2 cdbdfe    call    0febdh
0ba5 3a50fc    ld      a,(0fc50h)        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
0ba8 b7        or      a
0ba9 79        ld      a,c
0baa d9        exx     
0bab fa3d07    jp      m,073dh			; Cassette output routine
0bae 2018      jr      nz,0bc8h          ; Print routine
0bb0 f5        push    af
0bb1 cde802    call    02e8h
0bb4 d9        exx     
0bb5 cd0f07    call    070fh
0bb8 2addfb    ld      hl,(0fbddh)        ; CURSOR POSITION relative to upper L.H. corner
0bbb b7        or      a
0bbc ed42      sbc     hl,bc
0bbe 30fc      jr      nc,0bbch
0bc0 09        add     hl,bc
0bc1 7d        ld      a,l
0bc2 32c6fd    ld      (0fdc6h),a        ; Current cursor position (column number)
0bc5 d9        exx     
0bc6 f1        pop     af
0bc7 c9        ret     

; Print routine
0bc8 d9        exx     
0bc9 4f        ld      c,a
0bca 1e00      ld      e,00h
0bcc 00        nop     
0bcd 00        nop     
0bce 00        nop     
0bcf 00        nop     
0bd0 fe0d      cp      0dh
0bd2 2805      jr      z,0bd9h
0bd4 3a4ffc    ld      a,(0fc4fh)        ; No. of characters printed on this line
0bd7 3c        inc     a
0bd8 5f        ld      e,a
0bd9 7b        ld      a,e
0bda 324ffc    ld      (0fc4fh),a        ; No. of characters printed on this line
0bdd 79        ld      a,c
0bde cde30b    call    0be3h
0be1 d9        exx     
0be2 c9        ret

0be3 dd21e5fb  ld      ix,0fbe5h
0be7 00        nop     
0be8 00        nop     
0be9 00        nop     
0bea 00        nop     
0beb 00        nop     
0bec 00        nop     
0bed 1816      jr      0c05h

0bef af        xor     a
0bf0 ddb603    or      (ix+03h)
0bf3 2810      jr      z,0c05h
0bf5 dd7e03    ld      a,(ix+03h)
0bf8 dd9604    sub     (ix+04h)
0bfb 47        ld      b,a
0bfc 3e0a      ld      a,0ah
0bfe cd2d0c    call    0c2dh             ; List routine
0c01 10f9      djnz    0bfch
0c03 1816      jr      0c1bh
0c05 cd2d0c    call    0c2dh             ; List routine
0c08 fe0d      cp      0dh
0c0a c0        ret     nz
0c0b 3e0a      ld      a,0ah
0c0d cd2d0c    call    0c2dh             ; List routine
0c10 dd3404    inc     (ix+04h)
0c13 dd7e04    ld      a,(ix+04h)
0c16 ddbe03    cp      (ix+03h)
0c19 79        ld      a,c
0c1a c0        ret     nz
0c1b dd360400  ld      (ix+04h),00h
0c1f c9        ret

0c20 af        xor     a
0c21 3250fc    ld      (0fc50h),a        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
0c24 3a4ffc    ld      a,(0fc4fh)        ; No. of characters printed on this line
0c27 b7        or      a
0c28 c8        ret     z
0c29 3e0d      ld      a,0dh
0c2b 189b      jr      0bc8h          ; Print routine

; List routine
0c2d 08        ex      af,af'
0c2e cd450c    call    0c45h			; List status routine
0c31 20fb      jr      nz,0c2eh
0c33 08        ex      af,af'
0c34 d360      out     (60h),a
0c36 08        ex      af,af'
0c37 3e08      ld      a,08h
0c39 d363      out     (63h),a
0c3b 060a      ld      b,0ah
0c3d 10fe      djnz    0c3dh
0c3f 3e09      ld      a,09h
0c41 d363      out     (63h),a
0c43 08        ex      af,af'
0c44 c9        ret

; List status routine
0c45 db62      in      a,(62h)
0c47 e603      and     03h
0c49 c9        ret     
0c4a 210048    ld      hl,4800h
0c4d cdf510    call    10f5h
0c50 af        xor     a
0c51 cd5e06    call    065eh
0c54 23        inc     hl
0c55 cb54      bit     2,h
0c57 28f7      jr      z,0c50h
0c59 f5        push    af
0c5a d9        exx     
0c5b cd6806    call    0668h            ; Turns screen ram on
0c5e 21004c    ld      hl,4c00h
0c61 0e00      ld      c,00h
0c63 59        ld      e,c
0c64 1603      ld      d,03h
0c66 af        xor     a
0c67 cb43      bit     0,e
0c69 2802      jr      z,0c6dh
0c6b f6f0      or      0f0h
0c6d cb4b      bit     1,e
0c6f 2802      jr      z,0c73h
0c71 f60f      or      0fh
0c73 0604      ld      b,04h
0c75 cd5e06    call    065eh
0c78 23        inc     hl
0c79 10fa      djnz    0c75h
0c7b cb3b      srl     e
0c7d cb3b      srl     e
0c7f 15        dec     d
0c80 20e4      jr      nz,0c66h
0c82 0604      ld      b,04h
0c84 af        xor     a
0c85 cd5e06    call    065eh
0c88 23        inc     hl
0c89 10fa      djnz    0c85h
0c8b 0c        inc     c
0c8c cb71      bit     6,c
0c8e 28d3      jr      z,0c63h
0c90 cd6f06    call    066fh            ; Turns screen ram off
0c93 d9        exx     
0c94 f1        pop     af
0c95 c9        ret

0c96 cadc00    jp      z,00dch
0c99 fea1      cp      0a1h
0c9b 2817      jr      z,0cb4h
0c9d fe4f      cp      4fh
0c9f 201e      jr      nz,0cbfh
0ca1 e5        push    hl
0ca2 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0ca3 fe46      cp      46h
0ca5 2017      jr      nz,0cbeh
0ca7 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0ca8 fe46      cp      46h
0caa 2012      jr      nz,0cbeh
0cac d1        pop     de
0cad 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0cb0 cb87      res     0,a                ; set PCGEN ON/OFF flag (blank)
0cb2 1805      jr      0cb9h

0cb4 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0cb7 cbc7      set     0,a                ; set PCGEN ON/OFF flag (noblank)
0cb9 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output
0cbc d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0cbd c9        ret

0cbe e1        pop     hl
0cbf cdf639    call    39f6h        ; GETINT/EVAL
0cc2 e5        push    hl
0cc3 eb        ex      de,hl
0cc4 3e80      ld      a,80h
0cc6 ad        xor     l
0cc7 6f        ld      l,a
0cc8 110040    ld      de,4000h
0ccb 00        nop     
0ccc 00        nop     
0ccd 00        nop     
0cce 00        nop     
0ccf 29        add     hl,hl
0cd0 29        add     hl,hl
0cd1 29        add     hl,hl
0cd2 29        add     hl,hl
0cd3 19        add     hl,de
0cd4 eb        ex      de,hl
0cd5 e1        pop     hl
0cd6 2b        dec     hl
0cd7 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0cd8 2806      jr      z,0ce0h
0cda fe2c      cp      ','
0cdc 2818      jr      z,0cf6h
0cde cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0cdf 3b        dec     sp
0ce0 060c      ld      b,0ch
0ce2 cd6806    call    0668h            ; Turns screen ram on
0ce5 af        xor     a
0ce6 eb        ex      de,hl
0ce7 cd5e06    call    065eh
0cea 23        inc     hl
0ceb 10fa      djnz    0ce7h
0ced eb        ex      de,hl
0cee cd6f06    call    066fh        ; Turns screen ram off
0cf1 2b        dec     hl
0cf2 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0cf3 c8        ret     z
0cf4 18c9      jr      0cbfh
0cf6 0610      ld      b,10h
0cf8 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0cf9 fe2c      cp      ','
0cfb 2818      jr      z,0d15h
0cfd d5        push    de
0cfe c5        push    bc
0cff cdf639    call    39f6h        ; GETINT/EVAL
0d02 7a        ld      a,d
0d03 b7        or      a
0d04 c21c16    jp      nz,161ch            ; Overflow Error (OV ERROR)
0d07 cd6806    call    0668h            ; Turns screen ram on
0d0a 7b        ld      a,e
0d0b c1        pop     bc
0d0c d1        pop     de
0d0d eb        ex      de,hl
0d0e cd5e06    call    065eh
0d11 cd6f06    call    066fh            ; Turns screen ram off
0d14 eb        ex      de,hl
0d15 13        inc     de
0d16 2b        dec     hl
0d17 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0d18 c8        ret     z
0d19 fe2c      cp      ','
0d1b 2005      jr      nz,0d22h
0d1d 10d9      djnz    0cf8h
0d1f c38128    jp      2881h        ; Syntax Error (SN ERROR)
0d22 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0d23 3b        dec     sp
0d24 c8        ret     z
0d25 1898      jr      0cbfh
0d27 ed5f      ld      a,r
0d29 32cbfd    ld      (0fdcbh),a
0d2c c9        ret

; colour commands
0d2d ca1300    jp      z,0013h        ;  Memory Overflow (MO ERROR) 
0d30 fe23      cp      23h            ; '#'
0d32 2018      jr      nz,0d4ch        ; look for extra paramenters
0d34 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0d35 fe31      cp      31h            ; test for colour #1
0d37 2006      jr      nz,0d3fh        ; not colour #1, try colour #2
0d39 db50      in      a,(50h)        ; get system status
0d3b cb9f      res     3,a            ; set colour #1
0d3d 1809      jr      0d48h        ; exit via 'set system status'

0d3f fe32      cp      32h            ; test colour #2
0d41 c28128    jp      nz,2881h        ; Syntax Error (SN ERROR) if not valid color
0d44 db50      in      a,(50h)        ; get system status
0d46 cbdf      set     3,a            ; set colour #2

0d48 d370      out     (70h),a        ; Set system status
0d4a d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0d4b c9        ret

; look for extra parameters in colour commands
0d4c fe2c      cp      ','
0d4e 2008      jr      nz,0d58h            ; no, try for other values
0d50 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0d53 e6f0      and     0f0h                ; mask background color
0d55 f5        push    af                ; save foreground color
0d56 181a      jr      0d72h            ; text next value

0d58 cdf639    call    39f6h            ; GETINT/EVAL
0d5b 201a      jr      nz,0d77h            ; > 255 ?
0d5d 7b        ld      a,e                ; store foreground color
0d5e fe10      cp      10h                ; 0..15 ?
0d60 301b      jr      nc,0d7dh            ; Overflow Error (OV ERROR)
0d62 07        rlca                    ; SHIFT foreground color..
0d63 07        rlca                    ; ..to top nibble..
0d64 07        rlca                    ; ..to conform..
0d65 07        rlca                    ; ..to colour byte format
0d66 f5        push    af                ; safe foreground colour
0d67 2b        dec     hl            ; reset symbol pointer
0d68 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0d69 2007      jr      nz,0d72h
0d6b 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0d6e e60e      and     0eh            ; mask foreground colour
0d70 180f      jr      0d81h        ; go mix colours

; text next value in colour commands
0d72 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0d73 2c        defb    ','
0d74 cdf639    call    39f6h        ; GETINT/EVAL
0d77 c21c16    jp      nz,161ch            ; Overflow Error (OV ERROR)
0d7a 7b        ld      a,e            ; get background colour
0d7b fe08      cp      08h            ; 0..7 ?
0d7d d21c16    jp      nc,161ch        ; Overflow Error (OV ERROR)
0d80 07        rlca                    ; background to colour byte format
0d81 c1        pop     bc            ; get foreground colour
0d82 b0        or      b            ; mix fore and back colours
0d83 47        ld      b,a            ; temp store in B
0d84 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0d87 e601      and     01h                ; save PCGEN ON/OFF flag (blank)
0d89 b0        or      b                ; mix it with colours
0d8a 32e4fb    ld      (0fbe4h),a        ; COLOUR BYTE  copied into colour ram with every console output
0d8d 7e        ld      a,(hl)        ; fetch next symbol
0d8e c9        ret




0d8f cd890e    call    0e89h
0d92 b0        or      b
0d93 c5        push    bc
0d94 47        ld      b,a
0d95 db50      in      a,(50h)        ; get system status
0d97 e610      and     10h
0d99 28fa      jr      z,0d95h        ; wait for CSYNC - Composite video sync.signal 
0d9b 78        ld      a,b
0d9c 77        ld      (hl),a
0d9d c1        pop     bc
0d9e c9        ret     
0d9f 2f        cpl     
0da0 a0        and     b
0da1 18f0      jr      0d93h
0da3 cbc7      set     0,a
0da5 18ec      jr      0d93h
0da7 03        inc     bc
0da8 18f9      jr      0da3h
0daa cdaf0d    call    0dafh
0dad e1        pop     hl
0dae c9        ret     
0daf 3e36      ld      a,36h
0db1 d323      out     (23h),a
0db3 79        ld      a,c
0db4 d320      out     (20h),a
0db6 78        ld      a,b
0db7 d320      out     (20h),a
0db9 c9        ret     
0dba 3e34      ld      a,34h
0dbc d323      out     (23h),a
0dbe c9        ret     
0dbf cdfe0d    call    0dfeh
0dc2 d5        push    de
0dc3 cd8f0d    call    0d8fh
0dc6 00        nop     
0dc7 00        nop     
0dc8 180a      jr      0dd4h

0dca cdfe0d    call    0dfeh
0dcd d5        push    de
0dce cd890e    call    0e89h
0dd1 cd9f0d    call    0d9fh
0dd4 cbdc      set     3,h
0dd6 3ae4fb    ld      a,(0fbe4h)        ; COLOUR BYTE  copied into colour ram with every console output
0dd9 cda30d    call    0da3h
0ddc cd6f06    call    066fh            ; Turns screen ram off
0ddf e1        pop     hl
0de0 c9        ret

0de1 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
0de2 cdfe0d    call    0dfeh
0de5 d5        push    de
0de6 300a      jr      nc,0df2h
0de8 cd890e    call    0e89h
0deb a0        and     b
0dec 2805      jr      z,0df3h
0dee 3e01      ld      a,01h
0df0 1801      jr      0df3h
0df2 78        ld      a,b
0df3 6f        ld      l,a
0df4 2600      ld      h,00h
0df6 cd0419    call    1904h
0df9 cd6f06    call    066fh            ; Turns screen ram off
0dfc e1        pop     hl
0dfd c9        ret


0dfe cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0dff 28cd      jr      z,0dceh
0e01 f639      or      39h
0e03 c21c16    jp      nz,161ch            ; Overflow Error (OV ERROR)
0e06 7b        ld      a,e
0e07 3291fc    ld      (0fc91h),a    ; First warm start flag
0e0a cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0e0b 2c        defb    ','
0e0c cdf639    call    39f6h        ; GETINT/EVAL
0e0f c21c16    jp      nz,161ch            ; Overflow Error (OV ERROR)
0e12 7b        ld      a,e
0e13 3c        inc     a
0e14 3292fc    ld      (0fc92h),a
0e17 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
0e18 29        add     hl,hl
0e19 e5        push    hl
0e1a af        xor     a
0e1b 2191fc    ld      hl,0fc91h    ; First warm start flag
0e1e db50      in      a,(50h)        ; get system status
0e20 e604      and     04h
0e22 3e28      ld      a,28h
0e24 2801      jr      z,0e27h
0e26 17        rla     
0e27 17        rla     
0e28 3d        dec     a
0e29 be        cp      (hl)
0e2a da1c16    jp      c,161ch            ; Overflow Error (OV ERROR)
0e2d 3a8efc    ld      a,(0fc8eh)
0e30 47        ld      b,a
0e31 80        add     a,b
0e32 80        add     a,b
0e33 23        inc     hl
0e34 be        cp      (hl)
0e35 da1c16    jp      c,161ch            ; Overflow Error (OV ERROR)
0e38 af        xor     a
0e39 3293fc    ld      (0fc93h),a
0e3c 0e03      ld      c,03h
0e3e 47        ld      b,a
0e3f 3a92fc    ld      a,(0fc92h)
0e42 91        sub     c
0e43 280a      jr      z,0e4fh
0e45 3803      jr      c,0e4ah
0e47 04        inc     b
0e48 18f8      jr      0e42h
0e4a 78        ld      a,b
0e4b 3c        inc     a
0e4c 3293fc    ld      (0fc93h),a
0e4f af        xor     a
0e50 db50      in      a,(50h)        ; get system status
0e52 e604      and     04h
0e54 3e28      ld      a,28h
0e56 2801      jr      z,0e59h
0e58 17        rla     
0e59 210000    ld      hl,0000h
0e5c 1600      ld      d,00h
0e5e 5f        ld      e,a
0e5f 04        inc     b
0e60 05        dec     b
0e61 2803      jr      z,0e66h
0e63 19        add     hl,de
0e64 10fd      djnz    0e63h
0e66 3a91fc    ld      a,(0fc91h)        ; First warm start flag
0e69 1f        rra     
0e6a 1600      ld      d,00h
0e6c 5f        ld      e,a
0e6d 19        add     hl,de
0e6e ed5bdffb  ld      de,(0fbdfh)
0e72 19        add     hl,de
0e73 7c        ld      a,h
0e74 e607      and     07h
0e76 f628      or      28h
0e78 67        ld      h,a
0e79 cd6806    call    0668h            ; Turns screen ram on
0e7c cd7302    call    0273h
0e7f 00        nop     
0e80 00        nop     
0e81 00        nop     
0e82 00        nop     
0e83 00        nop     
0e84 00        nop     
0e85 00        nop     
0e86 00        nop     
0e87 d1        pop     de
0e88 c9        ret     
0e89 3809      jr      c,0e94h
0e8b cd9302    call    0293h
0e8e 00        nop     
0e8f 00        nop     
0e90 00        nop     
0e91 00        nop     
0e92 00        nop     
0e93 00        nop     
0e94 eb        ex      de,hl
0e95 0e00      ld      c,00h
0e97 2191fc    ld      hl,0fc91h        ; First warm start flag
0e9a cb46      bit     0,(hl)
0e9c 2801      jr      z,0e9fh
0e9e 0c        inc     c
0e9f 0c        inc     c
0ea0 2193fc    ld      hl,0fc93h
0ea3 7e        ld      a,(hl)
0ea4 b7        or      a
0ea5 2812      jr      z,0eb9h
0ea7 cb47      bit     0,a
0ea9 2807      jr      z,0eb2h
0eab 2b        dec     hl
0eac cb46      bit     0,(hl)
0eae 2011      jr      nz,0ec1h
0eb0 180b      jr      0ebdh
0eb2 2b        dec     hl
0eb3 cb46      bit     0,(hl)
0eb5 280a      jr      z,0ec1h
0eb7 1804      jr      0ebdh
0eb9 cb01      rlc     c
0ebb cb01      rlc     c
0ebd cb01      rlc     c
0ebf cb01      rlc     c
0ec1 79        ld      a,c
0ec2 eb        ex      de,hl
0ec3 c9        ret

0ec4 cd2b32    call    322bh			; EVAL
0ec7 e7        rst     20h			; GETYPR - Get the number type (FAC)
0ec8 c28128    jp      nz,2881h            ; Syntax Error (SN ERROR)
0ecb e5        push    hl
0ecc cdce38    call    38ceh
0ecf cd2e18    call    182eh            ; LOADFP_0
0ed2 7a        ld      a,d
0ed3 b7        or      a
0ed4 ca8128    jp      z,2881h            ; Syntax Error (SN ERROR)
0ed7 e1        pop     hl
0ed8 c9        ret

0ed9 fe61      cp      61h
0edb d8        ret     c
0edc fe7b      cp      7bh
0ede d0        ret     nc
0edf e65f      and     5fh
0ee1 c9        ret     

0ee2 cdc902    call    02c9h
0ee5 2809      jr      z,0ef0h
0ee7 21a510    ld      hl,10a5h
0eea cd9b37    call    379bh			; Output a string
0eed c30000    jp      0000h

0ef0 217410    ld      hl,1074h
0ef3 cd9b37    call    379bh			; Output a string
0ef6 cda211    call    11a2h
0ef9 1e01      ld      e,01h
0efb 3ed0      ld      a,0d0h
0efd cd3e10    call    103eh
0f00 010400    ld      bc,0004h
0f03 dbf0      in      a,(0f0h)
0f05 e680      and     80h
0f07 2821      jr      z,0f2ah
0f09 cd4510    call    1045h
0f0c cd5310    call    1053h
0f0f 10f2      djnz    0f03h
0f11 0d        dec     c
0f12 20ef      jr      nz,0f03h
0f14 217a10    ld      hl,107ah
0f17 cd9b37    call    379bh			; Output a string
0f1a cdea09    call    09eah        ; Console status routine
0f1d b7        or      a
0f1e c21b00    jp      nz,001bh
0f21 1e01      ld      e,01h
0f23 cd4510    call    1045h
0f26 e680      and     80h
0f28 20f0      jr      nz,0f1ah
0f2a 3134fc    ld      sp,0fc34h
0f2d dbe8      in      a,(0e8h)
0f2f e602      and     02h
0f31 47        ld      b,a
0f32 ee02      xor     02h
0f34 d3ec      out     (0ech),a
0f36 dbe8      in      a,(0e8h)
0f38 e602      and     02h
0f3a b8        cp      b
0f3b 2008      jr      nz,0f45h
0f3d b7        or      a
0f3e 2008      jr      nz,0f48h
0f40 cd580f    call    0f58h
0f43 1806      jr      0f4bh
0f45 cd580f    call    0f58h
0f48 cd540f    call    0f54h
0f4b 218910    ld      hl,1089h
0f4e cd9b37    call    379bh			; Output a string
0f51 c30000    jp      0000h

0f54 3e02      ld      a,02h
0f56 1802      jr      0f5ah
0f58 3e00      ld      a,00h
0f5a d3ec      out     (0ech),a
0f5c 0603      ld      b,03h
0f5e 3e0c      ld      a,0ch
0f60 cd3e10    call    103eh
0f63 e618      and     18h
0f65 2803      jr      z,0f6ah
0f67 10f5      djnz    0f5eh
0f69 c9        ret     
0f6a 1605      ld      d,05h
0f6c 216610    ld      hl,1066h
0f6f 0ee0      ld      c,0e0h
0f71 060e      ld      b,0eh
0f73 edb3      otir    
0f75 3e01      ld      a,01h
0f77 d3f2      out     (0f2h),a
0f79 3e86      ld      a,86h
0f7b cd3e10    call    103eh
0f7e e61c      and     1ch
0f80 2804      jr      z,0f86h
0f82 15        dec     d
0f83 20e7      jr      nz,0f6ch
0f85 c9        ret     
0f86 2a00d4    ld      hl,(0d400h)
0f89 114c53    ld      de,534ch
0f8c b7        or      a
0f8d ed52      sbc     hl,de
0f8f 2061      jr      nz,0ff2h
0f91 2a02d4    ld      hl,(0d402h)
0f94 11432e    ld      de,2e43h
0f97 b7        or      a
0f98 ed52      sbc     hl,de
0f9a 2056      jr      nz,0ff2h
0f9c 1100ea    ld      de,0ea00h
0f9f 2a08d4    ld      hl,(0d408h)
0fa2 19        add     hl,de
0fa3 ed4b06d4  ld      bc,(0d406h)
0fa7 110105    ld      de,0501h
0faa c5        push    bc
0fab d5        push    de
0fac e5        push    hl
0fad cdfb0f    call    0ffbh
0fb0 e1        pop     hl
0fb1 d1        pop     de
0fb2 c1        pop     bc
0fb3 b7        or      a
0fb4 2804      jr      z,0fbah
0fb6 15        dec     d
0fb7 20f1      jr      nz,0faah
0fb9 c9        ret     
0fba 3a05d4    ld      a,(0d405h)
0fbd eb        ex      de,hl
0fbe 214000    ld      hl,0040h
0fc1 29        add     hl,hl
0fc2 0f        rrca    
0fc3 30fc      jr      nc,0fc1h
0fc5 19        add     hl,de
0fc6 0c        inc     c
0fc7 10de      djnz    0fa7h
0fc9 3a00ea    ld      a,(0ea00h)
0fcc fec3      cp      0c3h
0fce 2022      jr      nz,0ff2h
0fd0 3a03ea    ld      a,(0ea03h)
0fd3 fec3      cp      0c3h
0fd5 201b      jr      nz,0ff2h
0fd7 ed5bd1fd  ld      de,(0fdd1h)        ; Memory size
0fdb 2a54fc    ld      hl,(0fc54h)        ; Address of string area boundary
0fde b7        or      a
0fdf ed52      sbc     hl,de
0fe1 11fed3    ld      de,0d3feh
0fe4 ed53d1fd  ld      (0fdd1h),de        ; Memory size
0fe8 19        add     hl,de
0fe9 2254fc    ld      (0fc54h),hl        ; Address of string area boundary
0fec cd472a    call    2a47h
0fef c31611    jp      1116h
0ff2 21b710    ld      hl,10b7h
0ff5 cd9b37    call    379bh			; Output a string
0ff8 c30000    jp      0000h

0ffb 3e83      ld      a,83h
0ffd d3e0      out     (0e0h),a
0fff 3e19      ld      a,19h
1001 d3e0      out     (0e0h),a
1003 7d        ld      a,l
1004 d3e0      out     (0e0h),a
1006 7c        ld      a,h
1007 d3e0      out     (0e0h),a
1009 79        ld      a,c
100a 216a10    ld      hl,106ah
100d 0ee0      ld      c,0e0h
100f 060a      ld      b,0ah
1011 edb3      otir    
1013 cba3      res     4,e
1015 2104d4    ld      hl,0d404h
1018 be        cp      (hl)
1019 3803      jr      c,101eh
101b cbe3      set     4,e
101d 96        sub     (hl)
101e 210ad4    ld      hl,0d40ah
1021 4f        ld      c,a
1022 0600      ld      b,00h
1024 09        add     hl,bc
1025 7e        ld      a,(hl)
1026 d3f2      out     (0f2h),a
1028 7b        ld      a,e
1029 d3e4      out     (0e4h),a
102b cd5310    call    1053h
102e 0e86      ld      c,86h
1030 3e10      ld      a,10h
1032 a3        and     e
1033 2802      jr      z,1037h
1035 cbd9      set     3,c
1037 79        ld      a,c
1038 cd3e10    call    103eh
103b e61c      and     1ch
103d c9        ret     
103e d3f0      out     (0f0h),a
1040 3e0a      ld      a,0ah
1042 3d        dec     a
1043 20fd      jr      nz,1042h
1045 7b        ld      a,e
1046 d3e4      out     (0e4h),a
1048 f620      or      20h
104a d3e4      out     (0e4h),a
104c dbf0      in      a,(0f0h)
104e cb47      bit     0,a
1050 20f3      jr      nz,1045h
1052 c9        ret     
1053 af        xor     a
1054 3d        dec     a
1055 00        nop     
1056 20fc      jr      nz,1054h
1058 c9        ret     
1059 dbf1      in      a,(0f1h)
105b 2f        cpl     
105c d3f1      out     (0f1h),a
105e 4f        ld      c,a
105f cd5310    call    1053h
1062 dbf1      in      a,(0f1h)
1064 b9        cp      c
1065 c9        ret     



1066 83        add     a,e
1067 19        add     hl,de
1068 00        nop     
1069 d46100    call    nc,0061h			; List status routine
106c 04        inc     b
106d 14        inc     d
106e 2885      jr      z,0ff5h
1070 f3        di      
1071 8a        adc     a,d
1072 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
1073 87        add     a,a
1074 07        rlca    
1075 1b        dec     de
1076 48        ld      c,b
1077 161a      ld      d,1ah
1079 00        nop     
107a 17        rla     

107b 1649      ld      d,49h
107d 4e        ld      c,(hl)
107e 53        ld      d,e
107f 45        ld      b,l
1080 52        ld      d,d
1081 54        ld      d,h
1082 2044      jr      nz,10c8h
1084 49        ld      c,c
1085 53        ld      d,e
1086 4b        ld      c,e
1087 0a        ld      a,(bc)
1088 00        nop     
1089 0d        dec     c
108a 0a        ld      a,(bc)
108b 52        ld      d,d
108c 45        ld      b,l
108d 41        ld      b,c
108e 44        ld      b,h
108f 2045      jr      nz,10d6h
1091 52        ld      d,d
1092 52        ld      d,d
1093 4f        ld      c,a
1094 52        ld      d,d
1095 202e      jr      nz,10c5h
1097 2e20      ld      l,20h
1099 4e        ld      c,(hl)
109a 4f        ld      c,a
109b 2053      jr      nz,10f0h
109d 59        ld      e,c
109e 53        ld      d,e
109f 54        ld      d,h
10a0 45        ld      b,l
10a1 4d        ld      c,l
10a2 0d        dec     c
10a3 0a        ld      a,(bc)
10a4 00        nop     
10a5 0d        dec     c
10a6 0a        ld      a,(bc)
10a7 4e        ld      c,(hl)
10a8 6f        ld      l,a
10a9 2043      jr      nz,10eeh
10ab 6f        ld      l,a
10ac 6e        ld      l,(hl)
10ad 74        ld      (hl),h
10ae 72        ld      (hl),d
10af 6f        ld      l,a
10b0 6c        ld      l,h
10b1 6c        ld      l,h
10b2 65        ld      h,l
10b3 72        ld      (hl),d
10b4 0d        dec     c
10b5 0a        ld      a,(bc)
10b6 00        nop     
10b7 0d        dec     c
10b8 0a        ld      a,(bc)
10b9 4e        ld      c,(hl)
10ba 6f        ld      l,a
10bb 74        ld      (hl),h
10bc 2061      jr      nz,111fh
10be 2053      jr      nz,1113h
10c0 79        ld      a,c
10c1 73        ld      (hl),e
10c2 74        ld      (hl),h
10c3 65        ld      h,l
10c4 6d        ld      l,l
10c5 2044      jr      nz,110bh
10c7 69        ld      l,c
10c8 73        ld      (hl),e
10c9 6b        ld      l,e
10ca 0d        dec     c
10cb 0a        ld      a,(bc)
10cc 00        nop

10cd 1a        ld      a,(de)

10ce 161b      ld      d,1bh
10d0 49        ld      c,c
10d1 07        rlca    
10d2 0d        dec     c
10d3 45        ld      b,l
10d4 78        ld      a,b
10d5 63        ld      h,e
10d6 61        ld      h,c
10d7 6c        ld      l,h
10d8 69        ld      l,c
10d9 62        ld      h,d
10da 75        ld      (hl),l
10db 72        ld      (hl),d
10dc 2036      jr      nz,1114h
10de 34        inc     (hl)
10df 2045      jr      nz,1126h
10e1 78        ld      a,b
10e2 74        ld      (hl),h
10e3 65        ld      h,l
10e4 6e        ld      l,(hl)
10e5 64        ld      h,h
10e6 65        ld      h,l
10e7 64        ld      h,h
10e8 2042      jr      nz,112ch
10ea 61        ld      h,c
10eb 73        ld      (hl),e
10ec 69        ld      l,c
10ed 63        ld      h,e
10ee 2031      jr      nz,1121h
10f0 2e31      ld      l,31h
10f2 0d        dec     c
10f3 0d        dec     c
10f4 00        nop     
10f5 cd6806    call    0668h            ; Turns screen ram on
10f8 e5        push    hl
10f9 f5        push    af
10fa 210030    ld      hl,3000h            ; top of PCG RAM address

10fd db50      in      a,(50h)            ; get system status
10ff e610      and     10h
1101 28fa      jr      z,10fdh            ; wait for CSYNC - Composite video sync.signal 
1103 3604      ld      (hl),04h
1105 23        inc     hl
1106 cb5c      bit     3,h
1108 28f3      jr      z,10fdh
110a f1        pop     af
110b e1        pop     hl
110c c9        ret

; Output a string to video device
110d 3e00      ld      a,00h
110f 3250fc    ld      (0fc50h),a        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
1112 cd9b37    call    379bh			; Output a string
1115 c9        ret

1116 cd3a3f    call    3f3ah
1119 00        nop     
111a 00        nop     
111b 00        nop     
111c 00        nop     
111d c300ea    jp      0ea00h
1120 74        ld      (hl),h
1121 0d        dec     c
1122 0a        ld      a,(bc)
1123 00        nop     
1124 0d        dec     c
1125 0a        ld      a,(bc)
1126 44        ld      b,h
1127 69        ld      l,c
1128 73        ld      (hl),e
1129 6b        ld      l,e
112a 2069      jr      nz,1195h
112c 73        ld      (hl),e
112d 206e      jr      nz,119dh
112f 6f        ld      l,a
1130 74        ld      (hl),h
1131 2061      jr      nz,1194h
1133 2076      jr      nz,11abh
1135 61        ld      h,c
1136 6c        ld      l,h
1137 69        ld      l,c
1138 64        ld      h,h
1139 2073      jr      nz,11aeh
113b 79        ld      a,c
113c 73        ld      (hl),e
113d 74        ld      (hl),h
113e 65        ld      h,l
113f 6d        ld      l,l
1140 2064      jr      nz,11a6h
1142 69        ld      l,c
1143 73        ld      (hl),e
1144 6b        ld      l,e
1145 0d        dec     c
1146 0a        ld      a,(bc)
1147 00        nop     
1148 cdd011    call    11d0h
114b c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
114e d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
114f cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
1150 2c        defb    ','
1151 d5        push    de
1152 43        ld      b,e
1153 cd5612    call    1256h
1156 cd103f    call    3f10h
1159 cd6712    call    1267h
115c c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
115f 0e0f      ld      c,0fh
1161 cd4d15    call    154dh
1164 3c        inc     a
1165 2009      jr      nz,1170h
1167 0e16      ld      c,16h
1169 cd4d15    call    154dh
116c 3c        inc     a
116d ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
1170 c1        pop     bc
1171 3a9dfc    ld      a,(0fc9dh)
1174 b0        or      b
1175 329dfc    ld      (0fc9dh),a
1178 0600      ld      b,00h
117a eb        ex      de,hl
117b 21bdfd    ld      hl,0fdbdh
117e 09        add     hl,bc
117f 70        ld      (hl),b
1180 eb        ex      de,hl
1181 c9        ret     
1182 281e      jr      z,11a2h
1184 cdd011    call    11d0h
1187 d5        push    de
1188 cd0c14    call    140ch
118b 0e10      ld      c,10h
118d cd4d15    call    154dh
1190 3c        inc     a
1191 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
1194 d1        pop     de
1195 3a9dfc    ld      a,(0fc9dh)
1198 aa        xor     d
1199 329dfc    ld      (0fc9dh),a
119c d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
119d c8        ret     z
119e cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
119f 2c        defb    ','
11a0 18e2      jr      1184h
11a2 3a9dfc    ld      a,(0fc9dh)
11a5 b7        or      a
11a6 c8        ret     z
11a7 0608      ld      b,08h
11a9 0f        rrca    
11aa 3802      jr      c,11aeh
11ac 10fb      djnz    11a9h
11ae 58        ld      e,b
11af 3e00      ld      a,00h
11b1 1f        rra     
11b2 10fd      djnz    11b1h
11b4 57        ld      d,a
11b5 3e09      ld      a,09h
11b7 93        sub     e
11b8 5f        ld      e,a
11b9 d5        push    de
11ba cd0c14    call    140ch
11bd 0e10      ld      c,10h
11bf cd4d15    call    154dh
11c2 3c        inc     a
11c3 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
11c6 c1        pop     bc
11c7 3a9dfc    ld      a,(0fc9dh)
11ca a8        xor     b
11cb 329dfc    ld      (0fc9dh),a
11ce 18d2      jr      11a2h

11d0 ca1300    jp      z,0013h        ;  Memory Overflow (MO ERROR)
11d3 d28128    jp      nc,2881h            ; Syntax Error (SN ERROR)
11d6 fe39      cp      39h
11d8 d2352d    jp      nc,2d35h            ; Error: Illegal function call (FC ERROR)
11db d630      sub     30h
11dd 5f        ld      e,a
11de 43        ld      b,e
11df af        xor     a
11e0 37        scf     
11e1 17        rla     
11e2 10fd      djnz    11e1h
11e4 57        ld      d,a
11e5 3a9dfc    ld      a,(0fc9dh)
11e8 a2        and     d
11e9 c9        ret     
11ea cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
11eb 22ca81    ld      (81cah),hl
11ee 28d7      jr      z,11c7h
11f0 b7        or      a
11f1 ca8128    jp      z,2881h            ; Syntax Error (SN ERROR)
11f4 2b        dec     hl
11f5 2b        dec     hl
11f6 fe3a      cp      3ah
11f8 3e00      ld      a,00h
11fa 200f      jr      nz,120bh
11fc d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
11fd da6515    jp      c,1565h
1200 e65f      and     5fh
1202 d641      sub     41h
1204 fe0d      cp      0dh
1206 d26515    jp      nc,1565h
1209 3c        inc     a
120a 23        inc     hl
120b 12        ld      (de),a
120c d5        push    de
120d eb        ex      de,hl
120e 23        inc     hl
120f 3e20      ld      a,20h
1211 060b      ld      b,0bh
1213 77        ld      (hl),a
1214 23        inc     hl
1215 10fc      djnz    1213h
1217 af        xor     a
1218 0605      ld      b,05h
121a 77        ld      (hl),a
121b 23        inc     hl
121c 10fc      djnz    121ah
121e 010f00    ld      bc,000fh
1221 09        add     hl,bc
1222 77        ld      (hl),a
1223 eb        ex      de,hl
1224 d1        pop     de
1225 d5        push    de
1226 13        inc     de
1227 0609      ld      b,09h
1229 cd4212    call    1242h
122c 7e        ld      a,(hl)
122d fe2e      cp      2eh
122f 200d      jr      nz,123eh
1231 d1        pop     de
1232 d5        push    de
1233 eb        ex      de,hl
1234 010900    ld      bc,0009h
1237 09        add     hl,bc
1238 eb        ex      de,hl
1239 0604      ld      b,04h
123b cd4212    call    1242h
123e cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
123f 22d1c9    ld      (0c9d1h),hl
1242 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1243 3808      jr      c,124dh
1245 e65f      and     5fh
1247 fe41      cp      41h
1249 d8        ret     c
124a fe5b      cp      5bh
124c d0        ret     nc
124d 1003      djnz    1252h
124f c36515    jp      1565h
1252 12        ld      (de),a
1253 13        inc     de
1254 18ec      jr      1242h
1256 e5        push    hl
1257 210000    ld      hl,0000h
125a 112400    ld      de,0024h
125d 19        add     hl,de
125e 10fd      djnz    125dh
1260 117afc    ld      de,0fc7ah
1263 19        add     hl,de
1264 eb        ex      de,hl
1265 e1        pop     hl
1266 c9        ret     
1267 e5        push    hl
1268 0608      ld      b,08h
126a 3a9dfc    ld      a,(0fc9dh)
126d 1f        rra     
126e 3805      jr      c,1275h
1270 10fb      djnz    126dh
1272 e1        pop     hl
1273 af        xor     a
1274 c9        ret     
1275 08        ex      af,af'
1276 c5        push    bc
1277 d5        push    de
1278 3e09      ld      a,09h
127a 90        sub     b
127b 210100    ld      hl,0001h
127e 012400    ld      bc,0024h
1281 09        add     hl,bc
1282 3d        dec     a
1283 20fc      jr      nz,1281h
1285 017afc    ld      bc,0fc7ah
1288 09        add     hl,bc
1289 010b00    ld      bc,000bh
128c 13        inc     de
128d 1a        ld      a,(de)
128e eda1      cpi     
1290 200a      jr      nz,129ch
1292 ea8c12    jp      pe,128ch
1295 d1        pop     de
1296 c1        pop     bc
1297 e1        pop     hl
1298 3e01      ld      a,01h
129a b7        or      a
129b c9        ret     
129c d1        pop     de
129d c1        pop     bc
129e 08        ex      af,af'
129f 18cc      jr      126dh
12a1 fe4d      cp      4dh
12a3 2002      jr      nz,12a7h
12a5 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
12a6 af        xor     a
12a7 f5        push    af
12a8 1180d8    ld      de,0d880h
12ab cd103f    call    3f10h
12ae f1        pop     af
12af 280d      jr      z,12beh
12b1 eb        ex      de,hl
12b2 2189d8    ld      hl,0d889h
12b5 3642      ld      (hl),42h
12b7 23        inc     hl
12b8 3641      ld      (hl),41h
12ba 23        inc     hl
12bb 3653      ld      (hl),53h
12bd eb        ex      de,hl
12be f5        push    af
12bf 1180d8    ld      de,0d880h
12c2 0e13      ld      c,13h
12c4 cd4d15    call    154dh
12c7 0e16      ld      c,16h
12c9 cd4d15    call    154dh
12cc 3c        inc     a
12cd ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
12d0 f1        pop     af
12d1 2835      jr      z,1308h
12d3 e5        push    hl
12d4 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
12d7 ed5b58fc  ld      de,(0fc58h)        ; BASTXT - Address of BASIC Program
12db b7        or      a
12dc ed52      sbc     hl,de
12de d5        push    de
12df 0e1a      ld      c,1ah
12e1 cd4d15    call    154dh
12e4 1180d8    ld      de,0d880h
12e7 0e15      ld      c,15h
12e9 cd4d15    call    154dh
12ec d1        pop     de
12ed 018000    ld      bc,0080h
12f0 b7        or      a
12f1 ed42      sbc     hl,bc
12f3 3805      jr      c,12fah
12f5 eb        ex      de,hl
12f6 09        add     hl,bc
12f7 eb        ex      de,hl
12f8 18e4      jr      12deh
12fa 1180d8    ld      de,0d880h
12fd 0e10      ld      c,10h
12ff cd4d15    call    154dh
1302 3c        inc     a
1303 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
1306 e1        pop     hl
1307 c9        ret     
1308 cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
130b d5        push    de
130c cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
130d 2c        defb    ','
130e cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
1311 c28128    jp      nz,2881h            ; Syntax Error (SN ERROR)
1314 e3        ex      (sp),hl
1315 eb        ex      de,hl
1316 b7        or      a
1317 ed52      sbc     hl,de
1319 ca1c16    jp      z,161ch            ; Overflow Error (OV ERROR)
131c da1c16    jp      c,161ch            ; Overflow Error (OV ERROR)
131f ed5300d8  ld      (0d800h),de
1323 e5        push    hl
1324 eb        ex      de,hl
1325 1102d8    ld      de,0d802h
1328 017e00    ld      bc,007eh
132b edb0      ldir    
132d 1100d8    ld      de,0d800h
1330 0e1a      ld      c,1ah
1332 cd4d15    call    154dh
1335 1180d8    ld      de,0d880h
1338 0e15      ld      c,15h
133a cd4d15    call    154dh
133d eb        ex      de,hl
133e e1        pop     hl
133f 017e00    ld      bc,007eh
1342 b7        or      a
1343 ed42      sbc     hl,bc
1345 38b3      jr      c,12fah
1347 c3de12    jp      12deh
134a fe4d      cp      4dh
134c 2002      jr      nz,1350h
134e d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
134f af        xor     a
1350 f5        push    af
1351 1180d8    ld      de,0d880h
1354 cd103f    call    3f10h
1357 f1        pop     af
1358 f5        push    af
1359 281a      jr      z,1375h
135b 2b        dec     hl
135c d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
135d 2806      jr      z,1365h
135f cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
1360 2c        defb    ','
1361 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
1362 52        ld      d,d
1363 3eff      ld      a,0ffh
1365 3297fc    ld      (0fc97h),a
1368 eb        ex      de,hl
1369 2189d8    ld      hl,0d889h
136c 3642      ld      (hl),42h
136e 23        inc     hl
136f 3641      ld      (hl),41h
1371 23        inc     hl
1372 3653      ld      (hl),53h
1374 eb        ex      de,hl
1375 1180d8    ld      de,0d880h
1378 0e0f      ld      c,0fh
137a cd4d15    call    154dh
137d 3c        inc     a
137e ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
1381 f1        pop     af
1382 2849      jr      z,13cdh
1384 cd372a    call    2a37h
1387 0e03      ld      c,03h
1389 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
138c cdf513    call    13f5h
138f 0680      ld      b,80h
1391 1100d8    ld      de,0d800h
1394 1a        ld      a,(de)
1395 77        ld      (hl),a
1396 08        ex      af,af'
1397 13        inc     de
1398 23        inc     hl
1399 cd5628    call    2856h
139c 08        ex      af,af'
139d b7        or      a
139e 2806      jr      z,13a6h
13a0 0e03      ld      c,03h
13a2 10f0      djnz    1394h
13a4 18e6      jr      138ch
13a6 0d        dec     c
13a7 20f9      jr      nz,13a2h
13a9 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
13ac 3a97fc    ld      a,(0fc97h)
13af 3c        inc     a
13b0 280d      jr      z,13bfh
13b2 211328    ld      hl,2813h
13b5 cd9b37    call    379bh			; Output a string
13b8 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
13bb e5        push    hl
13bc c3d229    jp      29d2h
13bf ed5b58fc  ld      de,(0fc58h)        ; BASTXT - Address of BASIC Program
13c3 cde629    call    29e6h
13c6 21082c    ld      hl,2c08h
13c9 e5        push    hl
13ca c3472a    jp      2a47h
13cd e5        push    hl
13ce cdf513    call    13f5h
13d1 2102d8    ld      hl,0d802h
13d4 ed5b00d8  ld      de,(0d800h)
13d8 017e00    ld      bc,007eh
13db edb0      ldir    
13dd 2180d8    ld      hl,0d880h
13e0 0e1a      ld      c,1ah
13e2 cd4d15    call    154dh
13e5 eb        ex      de,hl
13e6 0e14      ld      c,14h
13e8 cd4d15    call    154dh
13eb 018000    ld      bc,0080h
13ee 09        add     hl,bc
13ef eb        ex      de,hl
13f0 b7        or      a
13f1 28ed      jr      z,13e0h
13f3 e1        pop     hl
13f4 c9        ret     
13f5 c5        push    bc
13f6 1100d8    ld      de,0d800h
13f9 0e1a      ld      c,1ah
13fb cd4d15    call    154dh
13fe 1180d8    ld      de,0d880h
1401 0e14      ld      c,14h
1403 cd4d15    call    154dh
1406 b7        or      a
1407 c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
140a c1        pop     bc
140b c9        ret     
140c cd8714    call    1487h
140f e5        push    hl
1410 2a99fc    ld      hl,(0fc99h)
1413 cb7e      bit     7,(hl)
1415 2806      jr      z,141dh
1417 af        xor     a
1418 cd5814    call    1458h
141b 18f3      jr      1410h
141d e1        pop     hl
141e c9        ret

141f ca1300    jp      z,0013h        ;  Memory Overflow (MO ERROR)
1422 cdd011    call    11d0h
1425 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
1428 cd8714    call    1487h
142b d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
142c c8        ret     z
142d cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
142e 2c        defb    ','
142f cd2b32    call    322bh			; EVAL
1432 e5        push    hl
1433 e7        rst     20h			; GETYPR - Get the number type (FAC)
1434 2806      jr      z,143ch
1436 cd271e    call    1e27h
1439 cd5937    call    3759h

143c cd4814    call    1448h
143f 3e2c      ld      a,2ch
1441 cd5814    call    1458h
1444 e1        pop     hl
1445 2b        dec     hl
1446 18e3      jr      142bh

1448 cdce38    call    38ceh
144b cd2e18    call    182eh            ; LOADFP_0
144e 14        inc     d
144f 15        dec     d
1450 c8        ret     z
1451 0a        ld      a,(bc)
1452 cd5814    call    1458h
1455 03        inc     bc
1456 18f7      jr      144fh
1458 d5        push    de
1459 c5        push    bc
145a 2a99fc    ld      hl,(0fc99h)
145d 4e        ld      c,(hl)
145e cbb9      res     7,c
1460 0600      ld      b,00h
1462 eb        ex      de,hl
1463 2a9bfc    ld      hl,(0fc9bh)
1466 09        add     hl,bc
1467 77        ld      (hl),a
1468 eb        ex      de,hl
1469 cbfe      set     7,(hl)
146b 34        inc     (hl)
146c 2016      jr      nz,1484h
146e ed5b9bfc  ld      de,(0fc9bh)
1472 0e1a      ld      c,1ah
1474 cd4d15    call    154dh
1477 ed5b97fc  ld      de,(0fc97h)
147b 0e15      ld      c,15h
147d cd4d15    call    154dh
1480 3c        inc     a
1481 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
1484 c1        pop     bc
1485 d1        pop     de
1486 c9        ret     
1487 e5        push    hl
1488 2180d3    ld      hl,0d380h
148b 018000    ld      bc,0080h
148e 7b        ld      a,e
148f 09        add     hl,bc
1490 3d        dec     a
1491 20fc      jr      nz,148fh
1493 229bfc    ld      (0fc9bh),hl
1496 4b        ld      c,e
1497 21bdfd    ld      hl,0fdbdh
149a 09        add     hl,bc
149b 2299fc    ld      (0fc99h),hl
149e 43        ld      b,e
149f cd5612    call    1256h
14a2 ed5397fc  ld      (0fc97h),de
14a6 e1        pop     hl
14a7 c9        ret     
14a8 cd1c37    call    371ch
14ab d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
14ac ca1300    jp      z,0013h        ;  Memory Overflow (MO ERROR)
14af cdd011    call    11d0h
14b2 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
14b5 cd8714    call    1487h
14b8 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
14b9 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
14ba 2c        defb    ','
14bb e5        push    hl
14bc 21e3fe    ld      hl,0fee3h
14bf 06ff      ld      b,0ffh
14c1 23        inc     hl
14c2 c5        push    bc
14c3 cd0e15    call    150eh
14c6 c1        pop     bc
14c7 77        ld      (hl),a
14c8 b7        or      a
14c9 ca6a15    jp      z,156ah
14cc fe2c      cp      ','
14ce 2804      jr      z,14d4h
14d0 10ef      djnz    14c1h
14d2 36ff      ld      (hl),0ffh
14d4 e1        pop     hl
14d5 cd0135    call    3501h        ; GETVAR: Find address of variable
14d8 e5        push    hl
14d9 d5        push    de
14da 21e3fe    ld      hl,0fee3h
14dd e7        rst     20h			; GETYPR - Get the number type (FAC)
14de f5        push    af
14df 2019      jr      nz,14fah
14e1 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
14e2 57        ld      d,a
14e3 47        ld      b,a
14e4 fe22      cp      22h
14e6 2805      jr      z,14edh
14e8 163a      ld      d,3ah
14ea 062c      ld      b,2ch
14ec 2b        dec     hl
14ed cd5d37    call    375dh
14f0 f1        pop     af
14f1 eb        ex      de,hl
14f2 210715    ld      hl,1507h
14f5 e3        ex      (sp),hl
14f6 d5        push    de
14f7 c31e2e    jp      2e1eh
14fa d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
14fb f1        pop     af
14fc f5        push    af
14fd 01f014    ld      bc,14f0h
1500 c5        push    bc
1501 dad61c    jp      c,1cd6h
1504 c3cf1c    jp      1ccfh
1507 eb        ex      de,hl
1508 e1        pop     hl
1509 2b        dec     hl
150a d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
150b c8        ret     z
150c 18ab      jr      14b9h
150e e5        push    hl
150f 2a99fc    ld      hl,(0fc99h)
1512 7e        ld      a,(hl)
1513 b7        or      a
1514 2016      jr      nz,152ch
1516 ed5b9bfc  ld      de,(0fc9bh)
151a 0e1a      ld      c,1ah
151c cd4d15    call    154dh
151f ed5b97fc  ld      de,(0fc97h)
1523 0e14      ld      c,14h
1525 cd4d15    call    154dh
1528 b7        or      a
1529 203f      jr      nz,156ah
152b af        xor     a
152c 4f        ld      c,a
152d 0600      ld      b,00h
152f cbfe      set     7,(hl)
1531 34        inc     (hl)
1532 cbbe      res     7,(hl)
1534 2a9bfc    ld      hl,(0fc9bh)
1537 09        add     hl,bc
1538 7e        ld      a,(hl)
1539 e1        pop     hl
153a c9        ret     
153b 1180d8    ld      de,0d880h
153e cd103f    call    3f10h
1541 cd6712    call    1267h
1544 c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
1547 0e13      ld      c,13h
1549 cd4d15    call    154dh
154c c9        ret     
154d e5        push    hl
154e d5        push    de
154f 3a00ea    ld      a,(0ea00h)
1552 fec3      cp      0c3h
1554 c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
1557 3a03ea    ld      a,(0ea03h)
155a fec3      cp      0c3h
155c c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
155f cd33ea    call    0ea33h
1562 d1        pop     de
1563 e1        pop     hl
1564 c9        ret

1565 1e2e      ld      e,2eh
1567 c38c28    jp      288ch        ; ERROR, E=error code

156a 1e06      ld      e,06h
156c c38c28    jp      288ch        ; ERROR, E=error code

156f 55        ld      d,l
1570 c0        ret     nz
1571 2d        dec     l



1572 21ea21    ld      hl,21eah
1575 cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE
1578 1806      jr      1580h
157a cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE
157d cdec17    call    17ech
1580 78        ld      a,b
1581 b7        or      a
1582 c8        ret     z
1583 3a44fe    ld      a,(0fe44h)
1586 b7        or      a
1587 ca1e18    jp      z,181eh            ; Move SP value in BC/DE into WRA1
158a 90        sub     b
158b 300c      jr      nc,1599h
158d 2f        cpl     
158e 3c        inc     a
158f eb        ex      de,hl
1590 cd0e18    call    180eh            ; Move WRA1 to stack
1593 eb        ex      de,hl
1594 cd1e18    call    181eh            ; Move SP value in BC/DE into WRA1
1597 c1        pop     bc
1598 d1        pop     de
1599 fe19      cp      19h
159b d0        ret     nc
159c f5        push    af
159d cd4918    call    1849h
15a0 67        ld      h,a
15a1 f1        pop     af
15a2 cd4116    call    1641h
15a5 b4        or      h
15a6 2141fe    ld      hl,0fe41h        ; FACCU
15a9 f2be15    jp      p,15beh
15ac cd2116    call    1621h
15af d20016    jp      nc,1600h
15b2 23        inc     hl
15b3 34        inc     (hl)
15b4 ca1c16    jp      z,161ch            ; Overflow Error (OV ERROR)
15b7 2e01      ld      l,01h
15b9 cd5516    call    1655h
15bc 1842      jr      1600h

15be af        xor     a
15bf 90        sub     b
15c0 47        ld      b,a
15c1 7e        ld      a,(hl)
15c2 9b        sbc     a,e
15c3 5f        ld      e,a
15c4 23        inc     hl
15c5 7e        ld      a,(hl)
15c6 9a        sbc     a,d
15c7 57        ld      d,a
15c8 23        inc     hl
15c9 7e        ld      a,(hl)
15ca 99        sbc     a,c
15cb 4f        ld      c,a
15cc dc2d16    call    c,162dh
15cf 68        ld      l,b
15d0 63        ld      h,e
15d1 af        xor     a
15d2 47        ld      b,a
15d3 79        ld      a,c
15d4 b7        or      a
15d5 2018      jr      nz,15efh
15d7 4a        ld      c,d
15d8 54        ld      d,h
15d9 65        ld      h,l
15da 6f        ld      l,a
15db 78        ld      a,b
15dc d608      sub     08h
15de fee0      cp      0e0h
15e0 20f0      jr      nz,15d2h
15e2 af        xor     a
15e3 3244fe    ld      (0fe44h),a
15e6 c9        ret

15e7 05        dec     b
15e8 29        add     hl,hl
15e9 7a        ld      a,d
15ea 17        rla     
15eb 57        ld      d,a
15ec 79        ld      a,c
15ed 8f        adc     a,a
15ee 4f        ld      c,a
15ef f2e715    jp      p,15e7h
15f2 78        ld      a,b
15f3 5c        ld      e,h
15f4 45        ld      b,l
15f5 b7        or      a
15f6 2808      jr      z,1600h
15f8 2144fe    ld      hl,0fe44h
15fb 86        add     a,(hl)
15fc 77        ld      (hl),a
15fd 30e3      jr      nc,15e2h
15ff c8        ret     z

1600 78        ld      a,b
1601 2144fe    ld      hl,0fe44h
1604 b7        or      a
1605 fc1216    call    m,1612h
1608 46        ld      b,(hl)
1609 23        inc     hl
160a 7e        ld      a,(hl)
160b e680      and     80h
160d a9        xor     c
160e 4f        ld      c,a
160f c31e18    jp      181eh            ; Move SP value in BC/DE into WRA1

1612 1c        inc     e
1613 c0        ret     nz
1614 14        inc     d
1615 c0        ret     nz
1616 0c        inc     c
1617 c0        ret     nz
1618 0e80      ld      c,80h
161a 34        inc     (hl)
161b c0        ret     nz

; Overflow Error (OV ERROR)
161c 1e0a      ld      e,0ah
161e c38c28    jp      288ch        ; ERROR, E=error code

1621 7e        ld      a,(hl)
1622 83        add     a,e
1623 5f        ld      e,a
1624 23        inc     hl
1625 7e        ld      a,(hl)
1626 8a        adc     a,d
1627 57        ld      d,a
1628 23        inc     hl
1629 7e        ld      a,(hl)
162a 89        adc     a,c
162b 4f        ld      c,a
162c c9        ret     
162d 2145fe    ld      hl,0fe45h
1630 7e        ld      a,(hl)
1631 2f        cpl     
1632 77        ld      (hl),a
1633 af        xor     a
1634 6f        ld      l,a
1635 90        sub     b
1636 47        ld      b,a
1637 7d        ld      a,l
1638 9b        sbc     a,e
1639 5f        ld      e,a
163a 7d        ld      a,l
163b 9a        sbc     a,d
163c 57        ld      d,a
163d 7d        ld      a,l
163e 99        sbc     a,c
163f 4f        ld      c,a
1640 c9        ret     
1641 0600      ld      b,00h
1643 d608      sub     08h
1645 3807      jr      c,164eh
1647 43        ld      b,e
1648 5a        ld      e,d
1649 51        ld      d,c
164a 0e00      ld      c,00h
164c 18f5      jr      1643h
164e c609      add     a,09h
1650 6f        ld      l,a
1651 af        xor     a
1652 2d        dec     l
1653 c8        ret     z
1654 79        ld      a,c
1655 1f        rra     
1656 4f        ld      c,a
1657 7a        ld      a,d
1658 1f        rra     
1659 57        ld      d,a
165a 7b        ld      a,e
165b 1f        rra     
165c 5f        ld      e,a
165d 78        ld      a,b
165e 1f        rra     
165f 47        ld      b,a
1660 18ef      jr      1651h

; UNITY - Constant ptr for number 1 in FP
1662 00        nop     
1663 00        nop     
1664 00        nop     
1665 81        add     a,c

; LOGTAB - Table used by LOG
1666 03        inc     bc
1667 aa        xor     d
1668 56        ld      d,(hl)
1669 19        add     hl,de
166a 80        add     a,b
166b f1        pop     af
166c 227680    ld      (8076h),hl
166f 45        ld      b,l
1670 aa        xor     d
1671 3882      jr      c,15f5h
1673 cdbf17    call    17bfh
1676 b7        or      a
1677 ea352d    jp      pe,2d35h            ; Error: Illegal function call (FC ERROR)
167a 2144fe    ld      hl,0fe44h
167d 7e        ld      a,(hl)
167e 013580    ld      bc,8035h
1681 11f304    ld      de,04f3h
1684 90        sub     b
1685 f5        push    af
1686 70        ld      (hl),b
1687 d5        push    de
1688 c5        push    bc
1689 cd8015    call    1580h
168c c1        pop     bc
168d d1        pop     de
168e 04        inc     b
168f cd0c17    call    170ch
1692 216216    ld      hl,1662h			; UNITY - Constant ptr for number 1 in FP
1695 cd7a15    call    157ah
1698 216616    ld      hl,1666h			; LOGTAB - Table used by LOG
169b cd0423    call    2304h
169e 018080    ld      bc,8080h
16a1 110000    ld      de,0000h
16a4 cd8015    call    1580h
16a7 f1        pop     af
16a8 cdf31d    call    1df3h
16ab 013180    ld      bc,8031h
16ae 111872    ld      de,7218h
16b1 cdbf17    call    17bfh
16b4 c8        ret     z
16b5 2e00      ld      l,00h
16b7 cd7e17    call    177eh
16ba 79        ld      a,c
16bb 326ffe    ld      (0fe6fh),a
16be eb        ex      de,hl
16bf 2270fe    ld      (0fe70h),hl
16c2 010000    ld      bc,0000h
16c5 50        ld      d,b
16c6 58        ld      e,b
16c7 21cf15    ld      hl,15cfh
16ca e5        push    hl
16cb 21d316    ld      hl,16d3h
16ce e5        push    hl
16cf e5        push    hl
16d0 2141fe    ld      hl,0fe41h        ; FACCU
16d3 7e        ld      a,(hl)
16d4 23        inc     hl
16d5 b7        or      a
16d6 2824      jr      z,16fch
16d8 e5        push    hl
16d9 2e08      ld      l,08h
16db 1f        rra     
16dc 67        ld      h,a
16dd 79        ld      a,c
16de 300b      jr      nc,16ebh
16e0 e5        push    hl
16e1 2a70fe    ld      hl,(0fe70h)
16e4 19        add     hl,de
16e5 eb        ex      de,hl
16e6 e1        pop     hl
16e7 3a6ffe    ld      a,(0fe6fh)
16ea 89        adc     a,c
16eb 1f        rra     
16ec 4f        ld      c,a
16ed 7a        ld      a,d
16ee 1f        rra     
16ef 57        ld      d,a
16f0 7b        ld      a,e
16f1 1f        rra     
16f2 5f        ld      e,a
16f3 78        ld      a,b
16f4 1f        rra     
16f5 47        ld      b,a
16f6 2d        dec     l
16f7 7c        ld      a,h
16f8 20e1      jr      nz,16dbh
16fa e1        pop     hl
16fb c9        ret

16fc 43        ld      b,e
16fd 5a        ld      e,d
16fe 51        ld      d,c
16ff 4f        ld      c,a
1700 c9        ret

1701 cd0e18    call    180eh                ; Move WRA1 to stack
1704 21421c    ld      hl,1c42h
1707 cd1b18    call    181bh                ; Move a SP value -> HL to WRA1
170a c1        pop     bc
170b d1        pop     de
170c cdbf17    call    17bfh
170f ca8428    jp      z,2884h
1712 2eff      ld      l,0ffh
1714 cd7e17    call    177eh
1717 34        inc     (hl)
1718 34        inc     (hl)
1719 2b        dec     hl
171a 7e        ld      a,(hl)
171b 323dfc    ld      (0fc3dh),a
171e 2b        dec     hl
171f 7e        ld      a,(hl)
1720 3239fc    ld      (0fc39h),a
1723 2b        dec     hl
1724 7e        ld      a,(hl)
1725 3235fc    ld      (0fc35h),a
1728 41        ld      b,c
1729 eb        ex      de,hl
172a af        xor     a
172b 4f        ld      c,a
172c 57        ld      d,a
172d 5f        ld      e,a
172e 3240fc    ld      (0fc40h),a
1731 e5        push    hl
1732 c5        push    bc
1733 7d        ld      a,l
1734 cd34fc    call    0fc34h
1737 de00      sbc     a,00h
1739 3f        ccf     
173a 3007      jr      nc,1743h
173c 3240fc    ld      (0fc40h),a
173f f1        pop     af
1740 f1        pop     af
1741 37        scf     
1742 d2c1e1    jp      nc,0e1c1h
1745 79        ld      a,c
1746 3c        inc     a
1747 3d        dec     a
1748 1f        rra     
1749 fa0116    jp      m,1601h
174c 17        rla     
174d 7b        ld      a,e
174e 17        rla     
174f 5f        ld      e,a
1750 7a        ld      a,d
1751 17        rla     
1752 57        ld      d,a
1753 79        ld      a,c
1754 17        rla     
1755 4f        ld      c,a
1756 29        add     hl,hl
1757 78        ld      a,b
1758 17        rla     
1759 47        ld      b,a
175a 3a40fc    ld      a,(0fc40h)
175d 17        rla     
175e 3240fc    ld      (0fc40h),a
1761 79        ld      a,c
1762 b2        or      d
1763 b3        or      e
1764 20cb      jr      nz,1731h
1766 e5        push    hl
1767 2144fe    ld      hl,0fe44h
176a 35        dec     (hl)
176b e1        pop     hl
176c 20c3      jr      nz,1731h
176e c31c16    jp      161ch            ; Overflow Error (OV ERROR)

1771 3eff      ld      a,0ffh
1773 2eaf      ld      l,0afh
1775 214dfe    ld      hl,0fe4dh
1778 4e        ld      c,(hl)
1779 23        inc     hl
177a ae        xor     (hl)
177b 47        ld      b,a
177c 2e00      ld      l,00h
177e 78        ld      a,b
177f b7        or      a
1780 281f      jr      z,17a1h
1782 7d        ld      a,l
1783 2144fe    ld      hl,0fe44h
1786 ae        xor     (hl)
1787 80        add     a,b
1788 47        ld      b,a
1789 1f        rra     
178a a8        xor     b
178b 78        ld      a,b
178c f2a017    jp      p,17a0h
178f c680      add     a,80h
1791 77        ld      (hl),a
1792 cafa16    jp      z,16fah
1795 cd4918    call    1849h
1798 77        ld      (hl),a
1799 2b        dec     hl
179a c9        ret     
179b cdbf17    call    17bfh
179e 2f        cpl     
179f e1        pop     hl
17a0 b7        or      a
17a1 e1        pop     hl
17a2 f2e215    jp      p,15e2h
17a5 c31c16    jp      161ch            ; Overflow Error (OV ERROR)

17a8 cd2918    call    1829h            ; Load a SP value from WRA1 into BC/DE
17ab 78        ld      a,b
17ac b7        or      a
17ad c8        ret     z
17ae c602      add     a,02h
17b0 da1c16    jp      c,161ch            ; Overflow Error (OV ERROR)
17b3 47        ld      b,a
17b4 cd8015    call    1580h
17b7 2144fe    ld      hl,0fe44h
17ba 34        inc     (hl)
17bb c0        ret     nz
17bc c31c16    jp      161ch            ; Overflow Error (OV ERROR)

17bf 3a44fe    ld      a,(0fe44h)
17c2 b7        or      a
17c3 c8        ret     z
17c4 3a43fe    ld      a,(0fe43h)
17c7 fe2f      cp      2fh
17c9 17        rla     
17ca 9f        sbc     a,a
17cb c0        ret     nz
17cc 3c        inc     a
17cd c9        ret

17ce 0688      ld      b,88h
17d0 110000    ld      de,0000h
17d3 2144fe    ld      hl,0fe44h
17d6 4f        ld      c,a
17d7 70        ld      (hl),b
17d8 0600      ld      b,00h
17da 23        inc     hl
17db 3680      ld      (hl),80h
17dd 17        rla     
17de c3cc15    jp      15cch
17e1 cdfe17    call    17feh
17e4 f0        ret     p

; INVSGN
17e5 e7        rst     20h			; GETYPR - Get the number type (FAC)
17e6 fac51a    jp      m,1ac5h
17e9 ca6019    jp      z,1960h
17ec 2143fe    ld      hl,0fe43h
17ef 7e        ld      a,(hl)
17f0 ee80      xor     80h
17f2 77        ld      (hl),a
17f3 c9        ret     
17f4 cdfe17    call    17feh
17f7 6f        ld      l,a
17f8 17        rla     
17f9 9f        sbc     a,a
17fa 67        ld      h,a
17fb c30419    jp      1904h
17fe e7        rst     20h			; GETYPR - Get the number type (FAC)
17ff ca6019    jp      z,1960h
1802 f2bf17    jp      p,17bfh
1805 2a41fe    ld      hl,(0fe41h)        ; FACCU
1808 7c        ld      a,h
1809 b5        or      l
180a c8        ret     z
180b 7c        ld      a,h
180c 18bb      jr      17c9h

; Move WRA1 to stack
180e eb        ex      de,hl
180f 2a41fe    ld      hl,(0fe41h)        ; FACCU
1812 e3        ex      (sp),hl
1813 e5        push    hl
1814 2a43fe    ld      hl,(0fe43h)
1817 e3        ex      (sp),hl
1818 e5        push    hl
1819 eb        ex      de,hl
181a c9        ret     

; Move a SP value -> HL to WRA1
181b cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE

; Move SP value in BC/DE into WRA1
181e eb        ex      de,hl
181f 2241fe    ld      (0fe41h),hl        ; FACCU
1822 60        ld      h,b
1823 69        ld      l,c
1824 2243fe    ld      (0fe43h),hl
1827 eb        ex      de,hl
1828 c9        ret

; Load a SP value from WRA1 into BC/DE
1829 2141fe    ld      hl,0fe41h        ; FACCU

; LOADFP: Load SP value -> into BC/DE
182c 5e        ld      e,(hl)
182d 23        inc     hl
; LOADFP_0
182e 56        ld      d,(hl)
182f 23        inc     hl
1830 4e        ld      c,(hl)
1831 23        inc     hl
1832 46        ld      b,(hl)
; INCHL
1833 23        inc     hl
1834 c9        ret

1835 1141fe    ld      de,0fe41h        ; FACCU
1838 0604      ld      b,04h
183a 1805      jr      1841h
183c eb        ex      de,hl
183d 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
1840 47        ld      b,a
1841 1a        ld      a,(de)
1842 77        ld      (hl),a
1843 13        inc     de
1844 23        inc     hl
1845 05        dec     b
1846 20f9      jr      nz,1841h
1848 c9        ret     
1849 2143fe    ld      hl,0fe43h
184c 7e        ld      a,(hl)
184d 07        rlca    
184e 37        scf     
184f 1f        rra     
1850 77        ld      (hl),a
1851 3f        ccf     
1852 1f        rra     
1853 23        inc     hl
1854 23        inc     hl
1855 77        ld      (hl),a
1856 79        ld      a,c
1857 07        rlca    
1858 37        scf     
1859 1f        rra     
185a 4f        ld      c,a
185b 1f        rra     
185c ae        xor     (hl)
185d c9        ret     
185e 2147fe    ld      hl,0fe47h
1861 113c18    ld      de,183ch
1864 1806      jr      186ch
1866 2147fe    ld      hl,0fe47h
1869 113d18    ld      de,183dh
186c d5        push    de
186d 1141fe    ld      de,0fe41h        ; FACCU
1870 e7        rst     20h			; GETYPR - Get the number type (FAC)
1871 d8        ret     c
1872 113dfe    ld      de,0fe3dh
1875 c9        ret     
1876 78        ld      a,b
1877 b7        or      a
1878 cabf17    jp      z,17bfh
187b 21c817    ld      hl,17c8h
187e e5        push    hl
187f cdbf17    call    17bfh
1882 79        ld      a,c
1883 c8        ret     z
1884 2143fe    ld      hl,0fe43h
1887 ae        xor     (hl)
1888 79        ld      a,c
1889 f8        ret     m
188a cd9018    call    1890h
188d 1f        rra     
188e a9        xor     c
188f c9        ret     
1890 23        inc     hl
1891 78        ld      a,b
1892 be        cp      (hl)
1893 c0        ret     nz
1894 2b        dec     hl
1895 79        ld      a,c
1896 be        cp      (hl)
1897 c0        ret     nz
1898 2b        dec     hl
1899 7a        ld      a,d
189a be        cp      (hl)
189b c0        ret     nz
189c 2b        dec     hl
189d 7b        ld      a,e
189e 96        sub     (hl)
189f c0        ret     nz
18a0 e1        pop     hl
18a1 e1        pop     hl
18a2 c9        ret     
18a3 7a        ld      a,d
18a4 ac        xor     h
18a5 7c        ld      a,h
18a6 fac917    jp      m,17c9h
18a9 ba        cp      d
18aa c2ca17    jp      nz,17cah
18ad 7d        ld      a,l
18ae 93        sub     e
18af c2ca17    jp      nz,17cah
18b2 c9        ret     
18b3 2147fe    ld      hl,0fe47h
18b6 cd3d18    call    183dh
18b9 114efe    ld      de,0fe4eh
18bc 1a        ld      a,(de)
18bd b7        or      a
18be cabf17    jp      z,17bfh
18c1 21c817    ld      hl,17c8h
18c4 e5        push    hl
18c5 cdbf17    call    17bfh
18c8 1b        dec     de
18c9 1a        ld      a,(de)
18ca 4f        ld      c,a
18cb c8        ret     z
18cc 2143fe    ld      hl,0fe43h
18cf ae        xor     (hl)
18d0 79        ld      a,c
18d1 f8        ret     m
18d2 13        inc     de
18d3 23        inc     hl
18d4 0608      ld      b,08h
18d6 1a        ld      a,(de)
18d7 96        sub     (hl)
18d8 c28d18    jp      nz,188dh
18db 1b        dec     de
18dc 2b        dec     hl
18dd 05        dec     b
18de 20f6      jr      nz,18d6h
18e0 c1        pop     bc
18e1 c9        ret

18e2 cdb918    call    18b9h
18e5 c2c817    jp      nz,17c8h
18e8 c9        ret


; GETWORD_HL: Floating point to Integer
18e9 e7        rst     20h			; GETYPR - Get the number type (FAC)
18ea 2a41fe    ld      hl,(0fe41h)        ; FACCU
18ed f8        ret     m
18ee ca6019    jp      z,1960h
18f1 d42319    call    nc,1923h
18f4 211c16    ld      hl,161ch            ; Overflow Error (OV ERROR)
18f7 e5        push    hl
18f8 3a44fe    ld      a,(0fe44h)
18fb fe90      cp      90h
18fd 300e      jr      nc,190dh
18ff cd6519    call    1965h
1902 eb        ex      de,hl
1903 d1        pop     de
1904 2241fe    ld      (0fe41h),hl        ; FACCU
1907 3e02      ld      a,02h
1909 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
190c c9        ret     
190d 018090    ld      bc,9080h
1910 110000    ld      de,0000h
1913 cd7618    call    1876h
1916 c0        ret     nz
1917 61        ld      h,c
1918 6a        ld      l,d
1919 18e8      jr      1903h

; Integer to single precision
191b e7        rst     20h			; GETYPR - Get the number type (FAC)
191c e0        ret     po
191d fa3619    jp      m,1936h
1920 ca6019    jp      z,1960h
1923 cd2918    call    1829h
1926 cd5919    call    1959h
1929 78        ld      a,b
192a b7        or      a
192b c8        ret     z
192c cd4918    call    1849h
192f 2140fe    ld      hl,0fe40h
1932 46        ld      b,(hl)
1933 c30016    jp      1600h
1936 2a41fe    ld      hl,(0fe41h)        ; FACCU
1939 cd5919    call    1959h
193c 7c        ld      a,h
193d 55        ld      d,l
193e 1e00      ld      e,00h
1940 0690      ld      b,90h
1942 c3d317    jp      17d3h
1945 e7        rst     20h			; GETYPR - Get the number type (FAC)
1946 d0        ret     nc
1947 ca6019    jp      z,1960h
194a fc3619    call    m,1936h
194d 210000    ld      hl,0000h
1950 223dfe    ld      (0fe3dh),hl
1953 223ffe    ld      (0fe3fh),hl
1956 3e08      ld      a,08h
1958 013e04    ld      bc,043eh
195b c30919    jp      1909h
195e e7        rst     20h			; GETYPR - Get the number type (FAC)
195f c8        ret     z
1960 1e18      ld      e,18h
1962 c38c28    jp      288ch        ; ERROR, E=error code

1965 47        ld      b,a
1966 4f        ld      c,a
1967 57        ld      d,a
1968 5f        ld      e,a
1969 b7        or      a
196a c8        ret     z
196b e5        push    hl
196c cd2918    call    1829h
196f cd4918    call    1849h
1972 ae        xor     (hl)
1973 67        ld      h,a
1974 fc8919    call    m,1989h
1977 3e98      ld      a,98h
1979 90        sub     b
197a cd4116    call    1641h
197d 7c        ld      a,h
197e 17        rla     
197f dc1216    call    c,1612h
1982 0600      ld      b,00h
1984 dc2d16    call    c,162dh
1987 e1        pop     hl
1988 c9        ret     
1989 1b        dec     de
198a 7a        ld      a,d
198b a3        and     e
198c 3c        inc     a
198d c0        ret     nz
198e 0b        dec     bc
198f c9        ret     
1990 e7        rst     20h			; GETYPR - Get the number type (FAC)
1991 f8        ret     m
1992 cdbf17    call    17bfh
1995 f2a119    jp      p,19a1h
1998 cdec17    call    17ech
199b cda119    call    19a1h
199e c3e517    jp      17e5h        ; INVSGN

19a1 e7        rst     20h			; GETYPR - Get the number type (FAC)
19a2 f8        ret     m
19a3 301e      jr      nc,19c3h
19a5 28b9      jr      z,1960h
19a7 cdf818    call    18f8h
19aa 2144fe    ld      hl,0fe44h
19ad 7e        ld      a,(hl)
19ae fe98      cp      98h
19b0 3a41fe    ld      a,(0fe41h)        ; FACCU
19b3 d0        ret     nc
19b4 7e        ld      a,(hl)
19b5 cd6519    call    1965h
19b8 3698      ld      (hl),98h
19ba 7b        ld      a,e
19bb f5        push    af
19bc 79        ld      a,c
19bd 17        rla     
19be cdcc15    call    15cch
19c1 f1        pop     af
19c2 c9        ret     
19c3 2144fe    ld      hl,0fe44h
19c6 7e        ld      a,(hl)
19c7 fe90      cp      90h
19c9 dae918    jp      c,18e9h            ; GETWORD_HL: Floating point to Integer
19cc 2014      jr      nz,19e2h
19ce 4f        ld      c,a
19cf 2b        dec     hl
19d0 7e        ld      a,(hl)
19d1 ee80      xor     80h
19d3 0606      ld      b,06h
19d5 2b        dec     hl
19d6 b6        or      (hl)
19d7 05        dec     b
19d8 20fb      jr      nz,19d5h
19da b7        or      a
19db 210080    ld      hl,8000h
19de ca0419    jp      z,1904h
19e1 79        ld      a,c
19e2 feb8      cp      0b8h
19e4 d0        ret     nc
19e5 f5        push    af
19e6 cd2918    call    1829h
19e9 cd4918    call    1849h
19ec ae        xor     (hl)
19ed 2b        dec     hl
19ee 36b8      ld      (hl),0b8h
19f0 f5        push    af
19f1 fc0a1a    call    m,1a0ah
19f4 2143fe    ld      hl,0fe43h
19f7 3eb8      ld      a,0b8h
19f9 90        sub     b
19fa cdd31b    call    1bd3h
19fd f1        pop     af
19fe fc8a1b    call    m,1b8ah
1a01 af        xor     a
1a02 323cfe    ld      (0fe3ch),a
1a05 f1        pop     af
1a06 d0        ret     nc
1a07 c3421b    jp      1b42h
1a0a 213dfe    ld      hl,0fe3dh
1a0d 7e        ld      a,(hl)
1a0e 35        dec     (hl)
1a0f b7        or      a
1a10 23        inc     hl
1a11 28fa      jr      z,1a0dh
1a13 c9        ret     
1a14 e5        push    hl
1a15 210000    ld      hl,0000h
1a18 78        ld      a,b
1a19 b1        or      c
1a1a 2812      jr      z,1a2eh
1a1c 3e10      ld      a,10h
1a1e 29        add     hl,hl
1a1f da3136    jp      c,3631h
1a22 eb        ex      de,hl
1a23 29        add     hl,hl
1a24 eb        ex      de,hl
1a25 3004      jr      nc,1a2bh
1a27 09        add     hl,bc
1a28 da3136    jp      c,3631h
1a2b 3d        dec     a
1a2c 20f0      jr      nz,1a1eh
1a2e eb        ex      de,hl
1a2f e1        pop     hl
1a30 c9        ret     
1a31 7c        ld      a,h
1a32 17        rla     
1a33 9f        sbc     a,a
1a34 47        ld      b,a
1a35 cdbb1a    call    1abbh
1a38 79        ld      a,c
1a39 98        sbc     a,b
1a3a 1803      jr      1a3fh
1a3c 7c        ld      a,h
1a3d 17        rla     
1a3e 9f        sbc     a,a
1a3f 47        ld      b,a
1a40 e5        push    hl
1a41 7a        ld      a,d
1a42 17        rla     
1a43 9f        sbc     a,a
1a44 19        add     hl,de
1a45 88        adc     a,b
1a46 0f        rrca    
1a47 ac        xor     h
1a48 f20319    jp      p,1903h
1a4b c5        push    bc
1a4c eb        ex      de,hl
1a4d cd3919    call    1939h
1a50 f1        pop     af
1a51 e1        pop     hl
1a52 cd0e18    call    180eh                ; Move WRA1 to stack
1a55 eb        ex      de,hl
1a56 cdd51a    call    1ad5h
1a59 c3f91d    jp      1df9h
1a5c 7c        ld      a,h
1a5d b5        or      l
1a5e ca0419    jp      z,1904h
1a61 e5        push    hl
1a62 d5        push    de
1a63 cdaf1a    call    1aafh
1a66 c5        push    bc
1a67 44        ld      b,h
1a68 4d        ld      c,l
1a69 210000    ld      hl,0000h
1a6c 3e10      ld      a,10h
1a6e 29        add     hl,hl
1a6f 381f      jr      c,1a90h
1a71 eb        ex      de,hl
1a72 29        add     hl,hl
1a73 eb        ex      de,hl
1a74 3004      jr      nc,1a7ah
1a76 09        add     hl,bc
1a77 da901a    jp      c,1a90h
1a7a 3d        dec     a
1a7b 20f1      jr      nz,1a6eh
1a7d c1        pop     bc
1a7e d1        pop     de
1a7f 7c        ld      a,h
1a80 b7        or      a
1a81 fa891a    jp      m,1a89h
1a84 d1        pop     de
1a85 78        ld      a,b
1a86 c3b71a    jp      1ab7h
1a89 ee80      xor     80h
1a8b b5        or      l
1a8c 2813      jr      z,1aa1h
1a8e eb        ex      de,hl
1a8f 01c1e1    ld      bc,0e1c1h
1a92 cd3919    call    1939h
1a95 e1        pop     hl
1a96 cd0e18    call    180eh                ; Move WRA1 to stack
1a99 cd3919    call    1939h
1a9c c1        pop     bc
1a9d d1        pop     de
1a9e c3b116    jp      16b1h
1aa1 78        ld      a,b
1aa2 b7        or      a
1aa3 c1        pop     bc
1aa4 fa0419    jp      m,1904h
1aa7 d5        push    de
1aa8 cd3919    call    1939h
1aab d1        pop     de
1aac c3ec17    jp      17ech
1aaf 7c        ld      a,h
1ab0 aa        xor     d
1ab1 47        ld      b,a
1ab2 cdb61a    call    1ab6h
1ab5 eb        ex      de,hl
1ab6 7c        ld      a,h
1ab7 b7        or      a
1ab8 f20419    jp      p,1904h
1abb af        xor     a
1abc 4f        ld      c,a
1abd 95        sub     l
1abe 6f        ld      l,a
1abf 79        ld      a,c
1ac0 9c        sbc     a,h
1ac1 67        ld      h,a
1ac2 c30419    jp      1904h
1ac5 2a41fe    ld      hl,(0fe41h)        ; FACCU
1ac8 cdbb1a    call    1abbh
1acb 7c        ld      a,h
1acc ee80      xor     80h
1ace b5        or      l
1acf c0        ret     nz
1ad0 eb        ex      de,hl
1ad1 cd5919    call    1959h
1ad4 af        xor     a
1ad5 0698      ld      b,98h
1ad7 c3d317    jp      17d3h
1ada 214dfe    ld      hl,0fe4dh
1add 7e        ld      a,(hl)
1ade ee80      xor     80h
1ae0 77        ld      (hl),a
1ae1 214efe    ld      hl,0fe4eh
1ae4 7e        ld      a,(hl)
1ae5 b7        or      a
1ae6 c8        ret     z
1ae7 47        ld      b,a
1ae8 2b        dec     hl
1ae9 4e        ld      c,(hl)
1aea 1144fe    ld      de,0fe44h
1aed 1a        ld      a,(de)
1aee b7        or      a
1aef ca5e18    jp      z,185eh
1af2 90        sub     b
1af3 3016      jr      nc,1b0bh
1af5 2f        cpl     
1af6 3c        inc     a
1af7 f5        push    af
1af8 0e08      ld      c,08h
1afa 23        inc     hl
1afb e5        push    hl
1afc 1a        ld      a,(de)
1afd 46        ld      b,(hl)
1afe 77        ld      (hl),a
1aff 78        ld      a,b
1b00 12        ld      (de),a
1b01 1b        dec     de
1b02 2b        dec     hl
1b03 0d        dec     c
1b04 20f6      jr      nz,1afch
1b06 e1        pop     hl
1b07 46        ld      b,(hl)
1b08 2b        dec     hl
1b09 4e        ld      c,(hl)
1b0a f1        pop     af
1b0b fe39      cp      39h
1b0d d0        ret     nc
1b0e f5        push    af
1b0f cd4918    call    1849h
1b12 23        inc     hl
1b13 3600      ld      (hl),00h
1b15 47        ld      b,a
1b16 f1        pop     af
1b17 214dfe    ld      hl,0fe4dh
1b1a cdd31b    call    1bd3h
1b1d 3a46fe    ld      a,(0fe46h)
1b20 323cfe    ld      (0fe3ch),a
1b23 78        ld      a,b
1b24 b7        or      a
1b25 f2391b    jp      p,1b39h
1b28 cd9d1b    call    1b9dh
1b2b d2781b    jp      nc,1b78h
1b2e eb        ex      de,hl
1b2f 34        inc     (hl)
1b30 ca1c16    jp      z,161ch            ; Overflow Error (OV ERROR)
1b33 cdfa1b    call    1bfah
1b36 c3781b    jp      1b78h
1b39 cdaf1b    call    1bafh
1b3c 2145fe    ld      hl,0fe45h
1b3f dcc11b    call    c,1bc1h
1b42 af        xor     a
1b43 47        ld      b,a
1b44 3a43fe    ld      a,(0fe43h)
1b47 b7        or      a
1b48 201e      jr      nz,1b68h
1b4a 213cfe    ld      hl,0fe3ch
1b4d 0e08      ld      c,08h
1b4f 56        ld      d,(hl)
1b50 77        ld      (hl),a
1b51 7a        ld      a,d
1b52 23        inc     hl
1b53 0d        dec     c
1b54 20f9      jr      nz,1b4fh
1b56 78        ld      a,b
1b57 d608      sub     08h
1b59 fec0      cp      0c0h
1b5b 20e6      jr      nz,1b43h
1b5d c3e215    jp      15e2h
1b60 05        dec     b
1b61 213cfe    ld      hl,0fe3ch
1b64 cd011c    call    1c01h
1b67 b7        or      a
1b68 f2601b    jp      p,1b60h
1b6b 78        ld      a,b
1b6c b7        or      a
1b6d 2809      jr      z,1b78h
1b6f 2144fe    ld      hl,0fe44h
1b72 86        add     a,(hl)
1b73 77        ld      (hl),a
1b74 d2e215    jp      nc,15e2h
1b77 c8        ret     z
1b78 3a3cfe    ld      a,(0fe3ch)
1b7b b7        or      a
1b7c fc8a1b    call    m,1b8ah
1b7f 2145fe    ld      hl,0fe45h
1b82 7e        ld      a,(hl)
1b83 e680      and     80h
1b85 2b        dec     hl
1b86 2b        dec     hl
1b87 ae        xor     (hl)
1b88 77        ld      (hl),a
1b89 c9        ret     
1b8a 213dfe    ld      hl,0fe3dh
1b8d 0607      ld      b,07h
1b8f 34        inc     (hl)
1b90 c0        ret     nz
1b91 23        inc     hl
1b92 05        dec     b
1b93 20fa      jr      nz,1b8fh
1b95 34        inc     (hl)
1b96 ca1c16    jp      z,161ch            ; Overflow Error (OV ERROR)
1b99 2b        dec     hl
1b9a 3680      ld      (hl),80h
1b9c c9        ret

1b9d 2147fe    ld      hl,0fe47h
1ba0 113dfe    ld      de,0fe3dh
1ba3 0e07      ld      c,07h
1ba5 af        xor     a
1ba6 1a        ld      a,(de)
1ba7 8e        adc     a,(hl)
1ba8 12        ld      (de),a
1ba9 13        inc     de
1baa 23        inc     hl
1bab 0d        dec     c
1bac 20f8      jr      nz,1ba6h
1bae c9        ret     
1baf 2147fe    ld      hl,0fe47h
1bb2 113dfe    ld      de,0fe3dh
1bb5 0e07      ld      c,07h
1bb7 af        xor     a
1bb8 1a        ld      a,(de)
1bb9 9e        sbc     a,(hl)
1bba 12        ld      (de),a
1bbb 13        inc     de
1bbc 23        inc     hl
1bbd 0d        dec     c
1bbe 20f8      jr      nz,1bb8h
1bc0 c9        ret     
1bc1 7e        ld      a,(hl)
1bc2 2f        cpl     
1bc3 77        ld      (hl),a
1bc4 213cfe    ld      hl,0fe3ch
1bc7 0608      ld      b,08h
1bc9 af        xor     a
1bca 4f        ld      c,a
1bcb 79        ld      a,c
1bcc 9e        sbc     a,(hl)
1bcd 77        ld      (hl),a
1bce 23        inc     hl
1bcf 05        dec     b
1bd0 20f9      jr      nz,1bcbh
1bd2 c9        ret     
1bd3 71        ld      (hl),c
1bd4 e5        push    hl
1bd5 d608      sub     08h
1bd7 380e      jr      c,1be7h
1bd9 e1        pop     hl
1bda e5        push    hl
1bdb 110008    ld      de,0800h
1bde 4e        ld      c,(hl)
1bdf 73        ld      (hl),e
1be0 59        ld      e,c
1be1 2b        dec     hl
1be2 15        dec     d
1be3 20f9      jr      nz,1bdeh
1be5 18ee      jr      1bd5h
1be7 c609      add     a,09h
1be9 57        ld      d,a
1bea af        xor     a
1beb e1        pop     hl
1bec 15        dec     d
1bed c8        ret     z
1bee e5        push    hl
1bef 1e08      ld      e,08h
1bf1 7e        ld      a,(hl)
1bf2 1f        rra     
1bf3 77        ld      (hl),a
1bf4 2b        dec     hl
1bf5 1d        dec     e
1bf6 20f9      jr      nz,1bf1h
1bf8 18f0      jr      1beah
1bfa 2143fe    ld      hl,0fe43h
1bfd 1601      ld      d,01h
1bff 18ed      jr      1beeh
1c01 0e08      ld      c,08h
1c03 7e        ld      a,(hl)
1c04 17        rla     
1c05 77        ld      (hl),a
1c06 23        inc     hl
1c07 0d        dec     c
1c08 20f9      jr      nz,1c03h
1c0a c9        ret     
1c0b cdbf17    call    17bfh
1c0e c8        ret     z
1c0f cd7417    call    1774h
1c12 cda31c    call    1ca3h
1c15 71        ld      (hl),c
1c16 13        inc     de
1c17 0607      ld      b,07h
1c19 1a        ld      a,(de)
1c1a 13        inc     de
1c1b b7        or      a
1c1c d5        push    de
1c1d 2817      jr      z,1c36h
1c1f 0e08      ld      c,08h
1c21 c5        push    bc
1c22 1f        rra     
1c23 47        ld      b,a
1c24 dc9d1b    call    c,1b9dh
1c27 cdfa1b    call    1bfah
1c2a 78        ld      a,b
1c2b c1        pop     bc
1c2c 0d        dec     c
1c2d 20f2      jr      nz,1c21h
1c2f d1        pop     de
1c30 05        dec     b
1c31 20e6      jr      nz,1c19h
1c33 c3421b    jp      1b42h
1c36 2143fe    ld      hl,0fe43h
1c39 cdda1b    call    1bdah
1c3c 18f1      jr      1c2fh
1c3e 00        nop     
1c3f 00        nop     
1c40 00        nop     
1c41 00        nop     
1c42 00        nop     
1c43 00        nop     
1c44 2084      jr      nz,1bcah
1c46 113e1c    ld      de,1c3eh
1c49 2147fe    ld      hl,0fe47h
1c4c cd3d18    call    183dh
1c4f 3a4efe    ld      a,(0fe4eh)
1c52 b7        or      a
1c53 ca8428    jp      z,2884h
1c56 cd7117    call    1771h
1c59 34        inc     (hl)
1c5a 34        inc     (hl)
1c5b cda31c    call    1ca3h
1c5e 2171fe    ld      hl,0fe71h
1c61 71        ld      (hl),c
1c62 41        ld      b,c
1c63 116afe    ld      de,0fe6ah
1c66 2147fe    ld      hl,0fe47h
1c69 cdb51b    call    1bb5h
1c6c 1a        ld      a,(de)
1c6d 99        sbc     a,c
1c6e 3f        ccf     
1c6f 380b      jr      c,1c7ch
1c71 116afe    ld      de,0fe6ah
1c74 2147fe    ld      hl,0fe47h
1c77 cda31b    call    1ba3h
1c7a af        xor     a
1c7b da1204    jp      c,0412h
1c7e 3a43fe    ld      a,(0fe43h)
1c81 3c        inc     a
1c82 3d        dec     a
1c83 1f        rra     
1c84 fa7b1b    jp      m,1b7bh
1c87 17        rla     
1c88 213dfe    ld      hl,0fe3dh
1c8b 0e07      ld      c,07h
1c8d cd031c    call    1c03h
1c90 216afe    ld      hl,0fe6ah
1c93 cd011c    call    1c01h
1c96 78        ld      a,b
1c97 b7        or      a
1c98 20c9      jr      nz,1c63h
1c9a 2144fe    ld      hl,0fe44h
1c9d 35        dec     (hl)
1c9e 20c3      jr      nz,1c63h
1ca0 c31c16    jp      161ch            ; Overflow Error (OV ERROR)

1ca3 79        ld      a,c
1ca4 324dfe    ld      (0fe4dh),a
1ca7 2b        dec     hl
1ca8 1170fe    ld      de,0fe70h
1cab 010007    ld      bc,0700h
1cae 7e        ld      a,(hl)
1caf 12        ld      (de),a
1cb0 71        ld      (hl),c
1cb1 1b        dec     de
1cb2 2b        dec     hl
1cb3 05        dec     b
1cb4 20f8      jr      nz,1caeh
1cb6 c9        ret     
1cb7 cd6618    call    1866h
1cba eb        ex      de,hl
1cbb 2b        dec     hl
1cbc 7e        ld      a,(hl)
1cbd b7        or      a
1cbe c8        ret     z
1cbf c602      add     a,02h
1cc1 da1c16    jp      c,161ch            ; Overflow Error (OV ERROR)
1cc4 77        ld      (hl),a
1cc5 e5        push    hl
1cc6 cde11a    call    1ae1h
1cc9 e1        pop     hl
1cca 34        inc     (hl)
1ccb c0        ret     nz
1ccc c31c16    jp      161ch            ; Overflow Error (OV ERROR)

1ccf cde215    call    15e2h
1cd2 cd5619    call    1956h
1cd5 f6af      or      0afh
1cd7 eb        ex      de,hl
1cd8 01ff00    ld      bc,00ffh
1cdb 60        ld      h,b
1cdc 68        ld      l,b
1cdd cc0419    call    z,1904h
1ce0 eb        ex      de,hl
1ce1 7e        ld      a,(hl)
1ce2 fe2d      cp      2dh
1ce4 f5        push    af
1ce5 caed1c    jp      z,1cedh
1ce8 fe2b      cp      2bh
1cea 2801      jr      z,1cedh
1cec 2b        dec     hl
1ced d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1cee da931d    jp      c,1d93h
1cf1 fe2e      cp      2eh
1cf3 ca4e1d    jp      z,1d4eh
1cf6 fe45      cp      45h
1cf8 2814      jr      z,1d0eh
1cfa fe25      cp      25h
1cfc ca581d    jp      z,1d58h
1cff fe23      cp      23h
1d01 ca5f1d    jp      z,1d5fh
1d04 fe21      cp      21h
1d06 ca601d    jp      z,1d60h
1d09 fe44      cp      44h
1d0b 2024      jr      nz,1d31h
1d0d b7        or      a
1d0e cd651d    call    1d65h
1d11 e5        push    hl
1d12 21271d    ld      hl,1d27h
1d15 e3        ex      (sp),hl
1d16 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1d17 15        dec     d
1d18 fece      cp      0ceh
1d1a c8        ret     z
1d1b fe2d      cp      2dh
1d1d c8        ret     z
1d1e 14        inc     d
1d1f fecd      cp      0cdh
1d21 c8        ret     z
1d22 fe2b      cp      2bh
1d24 c8        ret     z
1d25 2b        dec     hl
1d26 f1        pop     af
1d27 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1d28 dafe1d    jp      c,1dfeh
1d2b 14        inc     d
1d2c 2003      jr      nz,1d31h
1d2e af        xor     a
1d2f 93        sub     e
1d30 5f        ld      e,a
1d31 e5        push    hl
1d32 7b        ld      a,e
1d33 90        sub     b
1d34 f4741d    call    p,1d74h
1d37 fc821d    call    m,1d82h
1d3a 20f8      jr      nz,1d34h
1d3c e1        pop     hl
1d3d f1        pop     af
1d3e e5        push    hl
1d3f cce517    call    z,17e5h        ; INVSGN
1d42 e1        pop     hl
1d43 e7        rst     20h			; GETYPR - Get the number type (FAC)
1d44 e8        ret     pe
1d45 e5        push    hl
1d46 21fa16    ld      hl,16fah
1d49 e5        push    hl
1d4a cd0d19    call    190dh
1d4d c9        ret     

1d4e e7        rst     20h			; GETYPR - Get the number type (FAC)
1d4f 0c        inc     c
1d50 20df      jr      nz,1d31h
1d52 dc651d    call    c,1d65h
1d55 c3ed1c    jp      1cedh
1d58 e7        rst     20h			; GETYPR - Get the number type (FAC)
1d59 f28128    jp      p,2881h            ; Syntax Error (SN ERROR)
1d5c 23        inc     hl
1d5d 18d2      jr      1d31h
1d5f b7        or      a
1d60 cd651d    call    1d65h
1d63 18f7      jr      1d5ch

1d65 e5        push    hl
1d66 d5        push    de
1d67 c5        push    bc
1d68 f5        push    af
1d69 cc1b19    call    z,191bh			; Integer to single precision
1d6c f1        pop     af
1d6d c44519    call    nz,1945h
1d70 c1        pop     bc
1d71 d1        pop     de
1d72 e1        pop     hl
1d73 c9        ret     

1d74 c8        ret     z
1d75 f5        push    af
1d76 e7        rst     20h			; GETYPR - Get the number type (FAC)
1d77 f5        push    af
1d78 e4a817    call    po,17a8h
1d7b f1        pop     af
1d7c ecb71c    call    pe,1cb7h
1d7f f1        pop     af
1d80 3d        dec     a
1d81 c9        ret     

1d82 d5        push    de
1d83 e5        push    hl
1d84 f5        push    af
1d85 e7        rst     20h			; GETYPR - Get the number type (FAC)
1d86 f5        push    af
1d87 e40117    call    po,1701h
1d8a f1        pop     af
1d8b ec461c    call    pe,1c46h
1d8e f1        pop     af
1d8f e1        pop     hl
1d90 d1        pop     de
1d91 3c        inc     a
1d92 c9        ret     
1d93 d5        push    de
1d94 78        ld      a,b
1d95 89        adc     a,c
1d96 47        ld      b,a
1d97 c5        push    bc
1d98 e5        push    hl
1d99 7e        ld      a,(hl)

1d9a d630      sub     30h
1d9c f5        push    af
1d9d e7        rst     20h			; GETYPR - Get the number type (FAC)
1d9e f2c71d    jp      p,1dc7h
1da1 2a41fe    ld      hl,(0fe41h)        ; FACCU
1da4 11cd0c    ld      de,0ccdh
1da7 df        rst     18h            ; DCOMPR - Compare HL with DE.
1da8 3019      jr      nc,1dc3h
1daa 54        ld      d,h
1dab 5d        ld      e,l
1dac 29        add     hl,hl
1dad 29        add     hl,hl
1dae 19        add     hl,de
1daf 29        add     hl,hl
1db0 f1        pop     af
1db1 4f        ld      c,a
1db2 09        add     hl,bc
1db3 7c        ld      a,h
1db4 b7        or      a
1db5 fac11d    jp      m,1dc1h
1db8 2241fe    ld      (0fe41h),hl        ; FACCU
1dbb e1        pop     hl
1dbc c1        pop     bc
1dbd d1        pop     de
1dbe c3ed1c    jp      1cedh

1dc1 79        ld      a,c
1dc2 f5        push    af
1dc3 cd3619    call    1936h
1dc6 37        scf     
1dc7 3018      jr      nc,1de1h
1dc9 017494    ld      bc,9474h
1dcc 110024    ld      de,2400h
1dcf cd7618    call    1876h
1dd2 f2de1d    jp      p,1ddeh
1dd5 cda817    call    17a8h
1dd8 f1        pop     af
1dd9 cdf31d    call    1df3h
1ddc 18dd      jr      1dbbh
1dde cd4d19    call    194dh
1de1 cdb71c    call    1cb7h
1de4 cd6618    call    1866h
1de7 f1        pop     af
1de8 cdce17    call    17ceh
1deb cd4d19    call    194dh
1dee cde11a    call    1ae1h
1df1 18c8      jr      1dbbh
1df3 cd0e18    call    180eh                ; Move WRA1 to stack
1df6 cdce17    call    17ceh
1df9 c1        pop     bc
1dfa d1        pop     de
1dfb c38015    jp      1580h
1dfe 7b        ld      a,e
1dff fe0a      cp      0ah
1e01 3009      jr      nc,1e0ch
1e03 07        rlca    
1e04 07        rlca    
1e05 83        add     a,e
1e06 07        rlca    
1e07 86        add     a,(hl)
1e08 d630      sub     30h
1e0a 5f        ld      e,a
1e0b fa1e32    jp      m,321eh
1e0e c3271d    jp      1d27h

; LNUM_MSG
1e11 e5        push    hl
1e12 210e28    ld      hl,280eh
1e15 cd9b37    call    379bh			; Output a string
1e18 e1        pop     hl
1e19 cd0419    call    1904h
1e1c af        xor     a
1e1d cd9e1e    call    1e9eh
1e20 b6        or      (hl)
1e21 cd431e    call    1e43h
1e24 c39a37    jp      379ah
1e27 af        xor     a
1e28 cd9e1e    call    1e9eh
1e2b e608      and     08h
1e2d 2802      jr      z,1e31h
1e2f 362b      ld      (hl),2bh
1e31 eb        ex      de,hl
1e32 cdfe17    call    17feh
1e35 eb        ex      de,hl
1e36 f2431e    jp      p,1e43h
1e39 362d      ld      (hl),2dh
1e3b c5        push    bc
1e3c e5        push    hl
1e3d cde517    call    17e5h        ; INVSGN
1e40 e1        pop     hl
1e41 c1        pop     bc
1e42 b4        or      h
1e43 23        inc     hl
1e44 3630      ld      (hl),30h
1e46 3af8fd    ld      a,(0fdf8h)        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
1e49 57        ld      d,a
1e4a 17        rla     
1e4b 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
1e4e da041f    jp      c,1f04h
1e51 cafc1e    jp      z,1efch
1e54 fe04      cp      04h
1e56 d2a71e    jp      nc,1ea7h
1e59 010000    ld      bc,0000h
1e5c cd9921    call    2199h
1e5f 2150fe    ld      hl,0fe50h
1e62 46        ld      b,(hl)
1e63 0e20      ld      c,20h
1e65 3af8fd    ld      a,(0fdf8h)        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
1e68 5f        ld      e,a
1e69 e620      and     20h
1e6b 2807      jr      z,1e74h
1e6d 78        ld      a,b
1e6e b9        cp      c
1e6f 0e2a      ld      c,2ah
1e71 2001      jr      nz,1e74h
1e73 41        ld      b,c
1e74 71        ld      (hl),c
1e75 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1e76 2814      jr      z,1e8ch
1e78 fe45      cp      45h
1e7a 2810      jr      z,1e8ch
1e7c fe44      cp      44h
1e7e 280c      jr      z,1e8ch
1e80 fe30      cp      30h
1e82 28f0      jr      z,1e74h
1e84 fe2c      cp      ','
1e86 28ec      jr      z,1e74h
1e88 fe2e      cp      2eh
1e8a 2003      jr      nz,1e8fh
1e8c 2b        dec     hl
1e8d 3630      ld      (hl),30h
1e8f 7b        ld      a,e
1e90 e610      and     10h
1e92 2803      jr      z,1e97h
1e94 2b        dec     hl
1e95 3624      ld      (hl),24h
1e97 7b        ld      a,e
1e98 e604      and     04h
1e9a c0        ret     nz
1e9b 2b        dec     hl
1e9c 70        ld      (hl),b
1e9d c9        ret     
1e9e 32f8fd    ld      (0fdf8h),a        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
1ea1 2150fe    ld      hl,0fe50h
1ea4 3620      ld      (hl),20h
1ea6 c9        ret     
1ea7 fe05      cp      05h
1ea9 e5        push    hl
1eaa de00      sbc     a,00h
1eac 17        rla     
1ead 57        ld      d,a
1eae 14        inc     d
1eaf cd6b20    call    206bh
1eb2 010003    ld      bc,0300h
1eb5 82        add     a,d
1eb6 fac11e    jp      m,1ec1h
1eb9 14        inc     d
1eba ba        cp      d
1ebb 3004      jr      nc,1ec1h
1ebd 3c        inc     a
1ebe 47        ld      b,a
1ebf 3e02      ld      a,02h
1ec1 d602      sub     02h
1ec3 e1        pop     hl
1ec4 f5        push    af
1ec5 cdfb20    call    20fbh
1ec8 3630      ld      (hl),30h
1eca cc3318    call    z,1833h        ; INCHL
1ecd cd0e21    call    210eh
1ed0 2b        dec     hl
1ed1 7e        ld      a,(hl)
1ed2 fe30      cp      30h
1ed4 28fa      jr      z,1ed0h
1ed6 fe2e      cp      2eh
1ed8 c43318    call    nz,1833h        ; INCHL
1edb f1        pop     af
1edc 281f      jr      z,1efdh
1ede f5        push    af
1edf e7        rst     20h			; GETYPR - Get the number type (FAC)
1ee0 3e22      ld      a,22h
1ee2 8f        adc     a,a
1ee3 77        ld      (hl),a
1ee4 23        inc     hl
1ee5 f1        pop     af
1ee6 362b      ld      (hl),2bh
1ee8 f2ef1e    jp      p,1eefh
1eeb 362d      ld      (hl),2dh
1eed 2f        cpl     
1eee 3c        inc     a
1eef 062f      ld      b,2fh
1ef1 04        inc     b
1ef2 d60a      sub     0ah
1ef4 30fb      jr      nc,1ef1h
1ef6 c63a      add     a,3ah
1ef8 23        inc     hl
1ef9 70        ld      (hl),b
1efa 23        inc     hl
1efb 77        ld      (hl),a
1efc 23        inc     hl
1efd 3600      ld      (hl),00h
1eff eb        ex      de,hl
1f00 2150fe    ld      hl,0fe50h
1f03 c9        ret     
1f04 23        inc     hl
1f05 c5        push    bc
1f06 fe04      cp      04h
1f08 7a        ld      a,d
1f09 d2731f    jp      nc,1f73h
1f0c 1f        rra     
1f0d da0d20    jp      c,200dh
1f10 010306    ld      bc,0603h
1f13 cdf320    call    20f3h
1f16 d1        pop     de
1f17 7a        ld      a,d
1f18 d605      sub     05h
1f1a f4d320    call    p,20d3h
1f1d cd9921    call    2199h
1f20 7b        ld      a,e
1f21 b7        or      a
1f22 cc9917    call    z,1799h
1f25 3d        dec     a
1f26 f4d320    call    p,20d3h
1f29 e5        push    hl
1f2a cd5f1e    call    1e5fh
1f2d e1        pop     hl
1f2e 2802      jr      z,1f32h
1f30 70        ld      (hl),b
1f31 23        inc     hl
1f32 3600      ld      (hl),00h
1f34 214ffe    ld      hl,0fe4fh
1f37 23        inc     hl
1f38 3a13fe    ld      a,(0fe13h)    ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
1f3b 95        sub     l
1f3c 92        sub     d
1f3d c8        ret     z
1f3e 7e        ld      a,(hl)
1f3f fe20      cp      20h
1f41 28f4      jr      z,1f37h
1f43 fe2a      cp      2ah
1f45 28f0      jr      z,1f37h
1f47 2b        dec     hl
1f48 e5        push    hl
1f49 f5        push    af
1f4a 01491f    ld      bc,1f49h
1f4d c5        push    bc
1f4e d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1f4f fe2d      cp      2dh
1f51 c8        ret     z
1f52 fe2b      cp      2bh
1f54 c8        ret     z
1f55 fe24      cp      24h
1f57 c8        ret     z
1f58 c1        pop     bc
1f59 fe30      cp      30h
1f5b 200f      jr      nz,1f6ch
1f5d 23        inc     hl
1f5e d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
1f5f 300b      jr      nc,1f6ch
1f61 2b        dec     hl
1f62 012b77    ld      bc,772bh
1f65 f1        pop     af
1f66 28fb      jr      z,1f63h
1f68 c1        pop     bc
1f69 c3381f    jp      1f38h
1f6c f1        pop     af
1f6d 28fd      jr      z,1f6ch
1f6f e1        pop     hl
1f70 3625      ld      (hl),25h
1f72 c9        ret     
1f73 e5        push    hl
1f74 1f        rra     
1f75 da1420    jp      c,2014h
1f78 2814      jr      z,1f8eh
1f7a 11ee21    ld      de,21eeh
1f7d cdb318    call    18b3h
1f80 1610      ld      d,10h
1f82 fa9c1f    jp      m,1f9ch
1f85 e1        pop     hl
1f86 c1        pop     bc
1f87 cd271e    call    1e27h
1f8a 2b        dec     hl
1f8b 3625      ld      (hl),25h
1f8d c9        ret     
1f8e 010eb6    ld      bc,0b60eh
1f91 11ca1b    ld      de,1bcah
1f94 cd7618    call    1876h
1f97 f2851f    jp      p,1f85h
1f9a 1606      ld      d,06h
1f9c cdbf17    call    17bfh
1f9f c46b20    call    nz,206bh
1fa2 e1        pop     hl
1fa3 c1        pop     bc
1fa4 fac11f    jp      m,1fc1h
1fa7 c5        push    bc
1fa8 5f        ld      e,a
1fa9 78        ld      a,b
1faa 92        sub     d
1fab 93        sub     e
1fac f4d320    call    p,20d3h
1faf cde720    call    20e7h
1fb2 cd0e21    call    210eh
1fb5 b3        or      e
1fb6 c4e120    call    nz,20e1h
1fb9 b3        or      e
1fba c4fb20    call    nz,20fbh
1fbd d1        pop     de
1fbe c3201f    jp      1f20h
1fc1 5f        ld      e,a
1fc2 79        ld      a,c
1fc3 b7        or      a
1fc4 c4801d    call    nz,1d80h
1fc7 83        add     a,e
1fc8 facc1f    jp      m,1fcch
1fcb af        xor     a
1fcc c5        push    bc
1fcd f5        push    af
1fce fc821d    call    m,1d82h
1fd1 face1f    jp      m,1fceh
1fd4 c1        pop     bc
1fd5 7b        ld      a,e
1fd6 90        sub     b
1fd7 c1        pop     bc
1fd8 5f        ld      e,a
1fd9 82        add     a,d
1fda 78        ld      a,b
1fdb fae91f    jp      m,1fe9h
1fde 92        sub     d
1fdf 93        sub     e
1fe0 f4d320    call    p,20d3h
1fe3 c5        push    bc
1fe4 cde720    call    20e7h
1fe7 1811      jr      1ffah
1fe9 cdd320    call    20d3h
1fec 79        ld      a,c
1fed cdfe20    call    20feh
1ff0 4f        ld      c,a
1ff1 af        xor     a
1ff2 92        sub     d
1ff3 93        sub     e
1ff4 cdd320    call    20d3h
1ff7 c5        push    bc
1ff8 47        ld      b,a
1ff9 4f        ld      c,a
1ffa cd0e21    call    210eh
1ffd c1        pop     bc
1ffe b1        or      c
1fff 20ff      jr      nz,2000h
2001 ff        rst     38h
2002 ff        rst     38h
2003 ff        rst     38h
2004 ff        rst     38h
2005 ff        rst     38h
2006 ff        rst     38h
2007 ff        rst     38h
2008 ff        rst     38h
2009 ff        rst     38h
200a ff        rst     38h
200b ff        rst     38h
200c ff        rst     38h
200d ff        rst     38h
200e ff        rst     38h
200f ff        rst     38h
2010 ff        rst     38h
2011 ff        rst     38h
2012 ff        rst     38h
2013 ff        rst     38h
2014 ff        rst     38h
2015 ff        rst     38h
2016 ff        rst     38h
2017 ff        rst     38h
2018 ff        rst     38h
2019 ff        rst     38h
201a ff        rst     38h
201b ff        rst     38h
201c ff        rst     38h
201d ff        rst     38h
201e ff        rst     38h
201f ff        rst     38h
2020 ff        rst     38h
2021 ff        rst     38h
2022 ff        rst     38h
2023 ff        rst     38h
2024 ff        rst     38h
2025 ff        rst     38h
2026 ff        rst     38h
2027 ff        rst     38h
2028 ff        rst     38h
2029 ff        rst     38h
202a ff        rst     38h
202b ff        rst     38h
202c ff        rst     38h
202d ff        rst     38h
202e ff        rst     38h
202f ff        rst     38h
2030 ff        rst     38h
2031 ff        rst     38h
2032 ff        rst     38h
2033 ff        rst     38h
2034 ff        rst     38h
2035 ff        rst     38h
2036 ff        rst     38h
2037 ff        rst     38h
2038 c3d2fb    jp      0fbd2h    ; Interrupt exit - initialised to a return
203b ff        rst     38h
203c ff        rst     38h
203d ff        rst     38h
203e ff        rst     38h
203f ff        rst     38h
2040 ff        rst     38h
2041 ff        rst     38h
2042 ff        rst     38h
2043 ff        rst     38h
2044 ff        rst     38h
2045 ff        rst     38h
2046 ff        rst     38h
2047 ff        rst     38h
2048 ff        rst     38h
2049 ff        rst     38h
204a ff        rst     38h
204b ff        rst     38h
204c ff        rst     38h
204d ff        rst     38h
204e ff        rst     38h
204f ff        rst     38h
2050 ff        rst     38h
2051 ff        rst     38h
2052 ff        rst     38h
2053 ff        rst     38h
2054 ff        rst     38h
2055 ff        rst     38h
2056 ff        rst     38h
2057 ff        rst     38h
2058 ff        rst     38h
2059 ff        rst     38h
205a ff        rst     38h
205b ff        rst     38h
205c ff        rst     38h
205d ff        rst     38h
205e ff        rst     38h
205f ff        rst     38h
2060 ff        rst     38h
2061 ff        rst     38h
2062 ff        rst     38h
2063 ff        rst     38h
2064 ff        rst     38h
2065 ff        rst     38h
2066 ff        rst     38h
2067 ff        rst     38h
2068 ff        rst     38h
2069 ff        rst     38h
206a ff        rst     38h
206b ff        rst     38h
206c ff        rst     38h
206d ff        rst     38h
206e ff        rst     38h
206f ff        rst     38h
2070 ff        rst     38h
2071 ff        rst     38h
2072 ff        rst     38h
2073 ff        rst     38h
2074 ff        rst     38h
2075 ff        rst     38h
2076 ff        rst     38h
2077 ff        rst     38h
2078 ff        rst     38h
2079 ff        rst     38h
207a ff        rst     38h
207b ff        rst     38h
207c ff        rst     38h
207d ff        rst     38h
207e ff        rst     38h
207f ff        rst     38h
2080 ff        rst     38h
2081 ff        rst     38h
2082 ff        rst     38h
2083 ff        rst     38h
2084 ff        rst     38h
2085 ff        rst     38h
2086 ff        rst     38h
2087 ff        rst     38h
2088 ff        rst     38h
2089 ff        rst     38h
208a ff        rst     38h
208b ff        rst     38h
208c ff        rst     38h
208d ff        rst     38h
208e ff        rst     38h
208f ff        rst     38h
2090 ff        rst     38h
2091 ff        rst     38h
2092 ff        rst     38h
2093 ff        rst     38h
2094 ff        rst     38h
2095 ff        rst     38h
2096 ff        rst     38h
2097 ff        rst     38h
2098 ff        rst     38h
2099 ff        rst     38h
209a ff        rst     38h
209b ff        rst     38h
209c ff        rst     38h
209d ff        rst     38h
209e ff        rst     38h
209f ff        rst     38h
20a0 ff        rst     38h
20a1 ff        rst     38h
20a2 ff        rst     38h
20a3 ff        rst     38h
20a4 ff        rst     38h
20a5 ff        rst     38h
20a6 ff        rst     38h
20a7 ff        rst     38h
20a8 ff        rst     38h
20a9 ff        rst     38h
20aa ff        rst     38h
20ab ff        rst     38h
20ac ff        rst     38h
20ad ff        rst     38h
20ae ff        rst     38h
20af ff        rst     38h
20b0 ff        rst     38h
20b1 ff        rst     38h
20b2 ff        rst     38h
20b3 ff        rst     38h
20b4 ff        rst     38h
20b5 ff        rst     38h
20b6 ff        rst     38h
20b7 ff        rst     38h
20b8 ff        rst     38h
20b9 ff        rst     38h
20ba ff        rst     38h
20bb ff        rst     38h
20bc ff        rst     38h
20bd ff        rst     38h
20be ff        rst     38h
20bf ff        rst     38h
20c0 ff        rst     38h
20c1 ff        rst     38h
20c2 ff        rst     38h
20c3 ff        rst     38h
20c4 ff        rst     38h
20c5 ff        rst     38h
20c6 ff        rst     38h
20c7 ff        rst     38h
20c8 ff        rst     38h
20c9 ff        rst     38h
20ca ff        rst     38h
20cb ff        rst     38h
20cc ff        rst     38h
20cd ff        rst     38h
20ce ff        rst     38h
20cf ff        rst     38h
20d0 ff        rst     38h
20d1 ff        rst     38h
20d2 ff        rst     38h
20d3 ff        rst     38h
20d4 ff        rst     38h
20d5 ff        rst     38h
20d6 ff        rst     38h
20d7 ff        rst     38h
20d8 ff        rst     38h
20d9 ff        rst     38h
20da ff        rst     38h
20db ff        rst     38h
20dc ff        rst     38h
20dd ff        rst     38h
20de ff        rst     38h
20df ff        rst     38h
20e0 ff        rst     38h
20e1 ff        rst     38h
20e2 ff        rst     38h
20e3 ff        rst     38h
20e4 ff        rst     38h
20e5 ff        rst     38h
20e6 ff        rst     38h
20e7 ff        rst     38h
20e8 ff        rst     38h
20e9 ff        rst     38h
20ea ff        rst     38h
20eb ff        rst     38h
20ec ff        rst     38h
20ed ff        rst     38h
20ee ff        rst     38h
20ef ff        rst     38h
20f0 ff        rst     38h
20f1 ff        rst     38h
20f2 ff        rst     38h
20f3 ff        rst     38h
20f4 ff        rst     38h
20f5 ff        rst     38h
20f6 ff        rst     38h
20f7 ff        rst     38h
20f8 ff        rst     38h
20f9 ff        rst     38h
20fa ff        rst     38h
20fb ff        rst     38h
20fc ff        rst     38h
20fd ff        rst     38h
20fe ff        rst     38h
20ff ff        rst     38h
2100 ff        rst     38h
2101 ff        rst     38h
2102 ff        rst     38h
2103 ff        rst     38h
2104 ff        rst     38h
2105 ff        rst     38h
2106 ff        rst     38h
2107 ff        rst     38h
2108 ff        rst     38h
2109 ff        rst     38h
210a ff        rst     38h
210b ff        rst     38h
210c ff        rst     38h
210d ff        rst     38h
210e ff        rst     38h
210f ff        rst     38h
2110 ff        rst     38h
2111 ff        rst     38h
2112 ff        rst     38h
2113 ff        rst     38h
2114 ff        rst     38h
2115 ff        rst     38h
2116 ff        rst     38h
2117 ff        rst     38h
2118 ff        rst     38h
2119 ff        rst     38h
211a ff        rst     38h
211b ff        rst     38h
211c ff        rst     38h
211d ff        rst     38h
211e ff        rst     38h
211f ff        rst     38h
2120 ff        rst     38h
2121 ff        rst     38h
2122 ff        rst     38h
2123 ff        rst     38h
2124 ff        rst     38h
2125 ff        rst     38h
2126 ff        rst     38h
2127 ff        rst     38h
2128 ff        rst     38h
2129 ff        rst     38h
212a ff        rst     38h
212b ff        rst     38h
212c ff        rst     38h
212d ff        rst     38h
212e ff        rst     38h
212f ff        rst     38h
2130 ff        rst     38h
2131 ff        rst     38h
2132 ff        rst     38h
2133 ff        rst     38h
2134 ff        rst     38h
2135 ff        rst     38h
2136 ff        rst     38h
2137 ff        rst     38h
2138 ff        rst     38h
2139 ff        rst     38h
213a ff        rst     38h
213b ff        rst     38h
213c ff        rst     38h
213d ff        rst     38h
213e ff        rst     38h
213f ff        rst     38h
2140 ff        rst     38h
2141 ff        rst     38h
2142 ff        rst     38h
2143 ff        rst     38h
2144 ff        rst     38h
2145 ff        rst     38h
2146 ff        rst     38h
2147 ff        rst     38h
2148 ff        rst     38h
2149 ff        rst     38h
214a ff        rst     38h
214b ff        rst     38h
214c ff        rst     38h
214d ff        rst     38h
214e ff        rst     38h
214f ff        rst     38h
2150 ff        rst     38h
2151 ff        rst     38h
2152 ff        rst     38h
2153 ff        rst     38h
2154 ff        rst     38h
2155 ff        rst     38h
2156 ff        rst     38h
2157 ff        rst     38h
2158 ff        rst     38h
2159 ff        rst     38h
215a ff        rst     38h
215b ff        rst     38h
215c ff        rst     38h
215d ff        rst     38h
215e ff        rst     38h
215f ff        rst     38h
2160 ff        rst     38h
2161 ff        rst     38h
2162 ff        rst     38h
2163 ff        rst     38h
2164 ff        rst     38h
2165 ff        rst     38h
2166 ff        rst     38h
2167 ff        rst     38h
2168 ff        rst     38h
2169 ff        rst     38h
216a ff        rst     38h
216b ff        rst     38h
216c ff        rst     38h
216d ff        rst     38h
216e ff        rst     38h
216f ff        rst     38h
2170 ff        rst     38h
2171 ff        rst     38h
2172 ff        rst     38h
2173 ff        rst     38h
2174 ff        rst     38h
2175 ff        rst     38h
2176 ff        rst     38h
2177 ff        rst     38h
2178 ff        rst     38h
2179 ff        rst     38h
217a ff        rst     38h
217b ff        rst     38h
217c ff        rst     38h
217d ff        rst     38h
217e ff        rst     38h
217f ff        rst     38h
2180 ff        rst     38h
2181 ff        rst     38h
2182 ff        rst     38h
2183 ff        rst     38h
2184 ff        rst     38h
2185 ff        rst     38h
2186 ff        rst     38h
2187 ff        rst     38h
2188 ff        rst     38h
2189 ff        rst     38h
218a ff        rst     38h
218b ff        rst     38h
218c ff        rst     38h
218d ff        rst     38h
218e ff        rst     38h
218f ff        rst     38h
2190 ff        rst     38h
2191 ff        rst     38h
2192 ff        rst     38h
2193 ff        rst     38h
2194 ff        rst     38h
2195 ff        rst     38h
2196 ff        rst     38h
2197 ff        rst     38h
2198 ff        rst     38h
2199 ff        rst     38h
219a ff        rst     38h
219b ff        rst     38h
219c ff        rst     38h
219d ff        rst     38h
219e ff        rst     38h
219f ff        rst     38h
21a0 ff        rst     38h
21a1 ff        rst     38h
21a2 ff        rst     38h
21a3 ff        rst     38h
21a4 ff        rst     38h
21a5 ff        rst     38h
21a6 ff        rst     38h
21a7 ff        rst     38h
21a8 ff        rst     38h
21a9 ff        rst     38h
21aa ff        rst     38h
21ab ff        rst     38h
21ac ff        rst     38h
21ad ff        rst     38h
21ae ff        rst     38h
21af ff        rst     38h
21b0 ff        rst     38h
21b1 ff        rst     38h
21b2 ff        rst     38h
21b3 ff        rst     38h
21b4 ff        rst     38h
21b5 ff        rst     38h
21b6 ff        rst     38h
21b7 ff        rst     38h
21b8 ff        rst     38h
21b9 ff        rst     38h
21ba ff        rst     38h
21bb ff        rst     38h
21bc ff        rst     38h
21bd ff        rst     38h
21be ff        rst     38h
21bf ff        rst     38h
21c0 ff        rst     38h
21c1 ff        rst     38h
21c2 ff        rst     38h
21c3 ff        rst     38h
21c4 ff        rst     38h
21c5 ff        rst     38h
21c6 ff        rst     38h
21c7 ff        rst     38h
21c8 ff        rst     38h
21c9 ff        rst     38h
21ca ff        rst     38h
21cb ff        rst     38h
21cc ff        rst     38h
21cd ff        rst     38h
21ce ff        rst     38h
21cf ff        rst     38h
21d0 ff        rst     38h
21d1 ff        rst     38h
21d2 ff        rst     38h
21d3 ff        rst     38h
21d4 ff        rst     38h
21d5 ff        rst     38h
21d6 ff        rst     38h
21d7 ff        rst     38h
21d8 ff        rst     38h
21d9 ff        rst     38h
21da ff        rst     38h
21db ff        rst     38h
21dc ff        rst     38h
21dd ff        rst     38h
21de ff        rst     38h
21df ff        rst     38h
21e0 ff        rst     38h
21e1 ff        rst     38h
21e2 ff        rst     38h
21e3 ff        rst     38h
21e4 ff        rst     38h
21e5 ff        rst     38h
21e6 ff        rst     38h
21e7 ff        rst     38h
21e8 ff        rst     38h
21e9 ff        rst     38h
21ea ff        rst     38h
21eb ff        rst     38h
21ec ff        rst     38h
21ed ff        rst     38h
21ee ff        rst     38h
21ef ff        rst     38h
21f0 ff        rst     38h
21f1 ff        rst     38h
21f2 ff        rst     38h
21f3 ff        rst     38h
21f4 ff        rst     38h
21f5 ff        rst     38h
21f6 ff        rst     38h
21f7 ff        rst     38h
21f8 ff        rst     38h
21f9 ff        rst     38h
21fa ff        rst     38h
21fb ff        rst     38h
21fc ff        rst     38h
21fd ff        rst     38h
21fe ff        rst     38h
21ff ff        rst     38h
2200 ff        rst     38h
2201 ff        rst     38h
2202 ff        rst     38h
2203 ff        rst     38h
2204 ff        rst     38h
2205 ff        rst     38h
2206 ff        rst     38h
2207 ff        rst     38h
2208 ff        rst     38h
2209 ff        rst     38h
220a ff        rst     38h
220b ff        rst     38h
220c ff        rst     38h
220d ff        rst     38h
220e ff        rst     38h
220f ff        rst     38h
2210 ff        rst     38h
2211 ff        rst     38h
2212 ff        rst     38h
2213 ff        rst     38h
2214 ff        rst     38h
2215 ff        rst     38h
2216 ff        rst     38h
2217 ff        rst     38h
2218 ff        rst     38h
2219 ff        rst     38h
221a ff        rst     38h
221b ff        rst     38h
221c ff        rst     38h
221d ff        rst     38h
221e ff        rst     38h
221f ff        rst     38h
2220 ff        rst     38h
2221 ff        rst     38h
2222 ff        rst     38h
2223 ff        rst     38h
2224 ff        rst     38h
2225 ff        rst     38h
2226 ff        rst     38h
2227 ff        rst     38h
2228 ff        rst     38h
2229 ff        rst     38h
222a ff        rst     38h
222b ff        rst     38h
222c ff        rst     38h
222d ff        rst     38h
222e ff        rst     38h
222f ff        rst     38h
2230 ff        rst     38h
2231 ff        rst     38h
2232 ff        rst     38h
2233 ff        rst     38h
2234 ff        rst     38h
2235 ff        rst     38h
2236 ff        rst     38h
2237 ff        rst     38h
2238 ff        rst     38h
2239 ff        rst     38h
223a ff        rst     38h
223b ff        rst     38h
223c ff        rst     38h
223d ff        rst     38h
223e ff        rst     38h
223f ff        rst     38h
2240 ff        rst     38h
2241 ff        rst     38h
2242 ff        rst     38h
2243 ff        rst     38h
2244 ff        rst     38h
2245 ff        rst     38h
2246 ff        rst     38h
2247 ff        rst     38h
2248 ff        rst     38h
2249 ff        rst     38h
224a ff        rst     38h
224b ff        rst     38h
224c ff        rst     38h
224d ff        rst     38h
224e ff        rst     38h
224f ff        rst     38h
2250 ff        rst     38h
2251 ff        rst     38h
2252 ff        rst     38h
2253 ff        rst     38h
2254 ff        rst     38h
2255 ff        rst     38h
2256 ff        rst     38h
2257 ff        rst     38h
2258 ff        rst     38h
2259 ff        rst     38h
225a ff        rst     38h
225b ff        rst     38h
225c ff        rst     38h
225d ff        rst     38h
225e ff        rst     38h
225f ff        rst     38h
2260 ff        rst     38h
2261 ff        rst     38h
2262 ff        rst     38h
2263 ff        rst     38h
2264 ff        rst     38h
2265 ff        rst     38h
2266 ff        rst     38h
2267 ff        rst     38h
2268 ff        rst     38h
2269 ff        rst     38h
226a ff        rst     38h
226b ff        rst     38h
226c ff        rst     38h
226d ff        rst     38h
226e ff        rst     38h
226f ff        rst     38h
2270 ff        rst     38h
2271 ff        rst     38h
2272 ff        rst     38h
2273 ff        rst     38h
2274 ff        rst     38h
2275 ff        rst     38h
2276 ff        rst     38h
2277 ff        rst     38h
2278 ff        rst     38h
2279 ff        rst     38h
227a ff        rst     38h
227b ff        rst     38h
227c ff        rst     38h
227d ff        rst     38h
227e ff        rst     38h
227f ff        rst     38h
2280 ff        rst     38h
2281 ff        rst     38h
2282 ff        rst     38h
2283 ff        rst     38h
2284 ff        rst     38h
2285 ff        rst     38h
2286 ff        rst     38h
2287 ff        rst     38h
2288 ff        rst     38h
2289 ff        rst     38h
228a ff        rst     38h
228b ff        rst     38h
228c ff        rst     38h
228d ff        rst     38h
228e ff        rst     38h
228f ff        rst     38h
2290 ff        rst     38h
2291 ff        rst     38h
2292 ff        rst     38h
2293 ff        rst     38h
2294 ff        rst     38h
2295 ff        rst     38h
2296 ff        rst     38h
2297 ff        rst     38h
2298 ff        rst     38h
2299 ff        rst     38h
229a ff        rst     38h
229b ff        rst     38h
229c ff        rst     38h
229d ff        rst     38h
229e ff        rst     38h
229f ff        rst     38h
22a0 ff        rst     38h
22a1 ff        rst     38h
22a2 ff        rst     38h
22a3 ff        rst     38h
22a4 ff        rst     38h
22a5 ff        rst     38h
22a6 ff        rst     38h
22a7 ff        rst     38h
22a8 ff        rst     38h
22a9 ff        rst     38h
22aa ff        rst     38h
22ab ff        rst     38h
22ac ff        rst     38h
22ad ff        rst     38h
22ae ff        rst     38h
22af ff        rst     38h
22b0 ff        rst     38h
22b1 ff        rst     38h
22b2 ff        rst     38h
22b3 ff        rst     38h
22b4 ff        rst     38h
22b5 ff        rst     38h
22b6 ff        rst     38h
22b7 ff        rst     38h
22b8 ff        rst     38h
22b9 ff        rst     38h
22ba ff        rst     38h
22bb ff        rst     38h
22bc ff        rst     38h
22bd ff        rst     38h
22be ff        rst     38h
22bf ff        rst     38h
22c0 ff        rst     38h
22c1 ff        rst     38h
22c2 ff        rst     38h
22c3 ff        rst     38h
22c4 ff        rst     38h
22c5 ff        rst     38h
22c6 ff        rst     38h
22c7 ff        rst     38h
22c8 ff        rst     38h
22c9 ff        rst     38h
22ca ff        rst     38h
22cb ff        rst     38h
22cc ff        rst     38h
22cd ff        rst     38h
22ce ff        rst     38h
22cf ff        rst     38h
22d0 ff        rst     38h
22d1 ff        rst     38h
22d2 ff        rst     38h
22d3 ff        rst     38h
22d4 ff        rst     38h
22d5 ff        rst     38h
22d6 ff        rst     38h
22d7 ff        rst     38h
22d8 ff        rst     38h
22d9 ff        rst     38h
22da ff        rst     38h
22db ff        rst     38h
22dc ff        rst     38h
22dd ff        rst     38h
22de ff        rst     38h
22df ff        rst     38h
22e0 ff        rst     38h
22e1 ff        rst     38h
22e2 ff        rst     38h
22e3 ff        rst     38h
22e4 ff        rst     38h
22e5 ff        rst     38h
22e6 ff        rst     38h
22e7 ff        rst     38h
22e8 ff        rst     38h
22e9 ff        rst     38h
22ea ff        rst     38h
22eb ff        rst     38h
22ec ff        rst     38h
22ed ff        rst     38h
22ee ff        rst     38h
22ef ff        rst     38h
22f0 ff        rst     38h
22f1 ff        rst     38h
22f2 ff        rst     38h
22f3 ff        rst     38h
22f4 ff        rst     38h
22f5 ff        rst     38h
22f6 ff        rst     38h
22f7 ff        rst     38h
22f8 ff        rst     38h
22f9 ff        rst     38h
22fa ff        rst     38h
22fb ff        rst     38h
22fc ff        rst     38h
22fd ff        rst     38h
22fe ff        rst     38h
22ff ff        rst     38h
2300 c34803    jp      0348h
2303 7e        ld      a,(hl)
2304 fefa      cp      0fah
2306 ca7f07    jp      z,077fh
2309 2b        dec     hl
230a 7e        ld      a,(hl)
230b fe20      cp      20h
230d 28fa      jr      z,2309h
230f 23        inc     hl
2310 fea9      cp      0a9h
2312 ca740d    jp      z,0d74h
2315 feaa      cp      0aah
2317 ca770e    jp      z,0e77h
231a feab      cp      0abh
231c ca6216    jp      z,1662h			; UNITY - Constant ptr for number 1 in FP
231f feac      cp      0ach
2321 ca000b    jp      z,0b00h
2324 fead      cp      0adh
2326 ca7017    jp      z,1770h
2329 fea6      cp      0a6h
232b ca5b19    jp      z,195bh
232e fea7      cp      0a7h
2330 ca6d19    jp      z,196dh
2333 fe90      cp      90h
2335 ca7b08    jp      z,087bh
2338 fe85      cp      85h
233a ca7703    jp      z,0377h
233d feb0      cp      0b0h
233f ca1e08    jp      z,081eh
2342 c3f61c    jp      1cf6h
2345 c35f1b    jp      1b5fh
2348 3c        inc     a
2349 ca0a19    jp      z,190ah
234c 3c        inc     a
234d caa708    jp      z,08a7h
2350 3c        inc     a
2351 caef08    jp      z,08efh
2354 3c        inc     a
2355 cada08    jp      z,08dah
2358 3c        inc     a
2359 ca2209    jp      z,0922h
235c 3c        inc     a
235d ca8306    jp      z,0683h
2360 3c        inc     a
2361 ca8215    jp      z,1582h
2364 3c        inc     a
2365 ca3306    jp      z,0633h
2368 3c        inc     a
2369 ca5306    jp      z,0653h
236c 3c        inc     a
236d ca6506    jp      z,0665h
2370 3c        inc     a
2371 cab31d    jp      z,1db3h
2374 c3f61c    jp      1cf6h
2377 dd2193fe  ld      ix,0fe93h
237b cd9a1d    call    1d9ah
237e 2b        dec     hl
237f cdc51c    call    1cc5h
2382 cd5d0b    call    0b5dh
2385 23        inc     hl
2386 feb2      cp      0b2h
2388 cafb0b    jp      z,0bfbh
238b fe52      cp      52h
238d caac03    jp      z,03ach
2390 fe4d      cp      4dh
2392 ca7e1a    jp      z,1a7eh
2395 fedb      cp      0dbh
2397 ca5905    jp      z,0559h
239a fea0      cp      0a0h
239c ca9605    jp      z,0596h
239f fe53      cp      53h
23a1 cae605    jp      z,05e6h
23a4 febb      cp      0bbh
23a6 ca1906    jp      z,0619h
23a9 c3f61c    jp      1cf6h

23ac cd211d    call    1d21h
23af d5        push    de
23b0 cd520b    call    0b52h
23b3 2c        inc     l
23b4 cd211d    call    1d21h
23b7 c1        pop     bc
23b8 d5        push    de
23b9 c5        push    bc
23ba 7a        ld      a,d
23bb b3        or      e
23bc ca001d    jp      z,1d00h
23bf 2b        dec     hl
23c0 cd5d0b    call    0b5dh
23c3 fe2c      cp      ','
23c5 ed5b58fc  ld      de,(0fc58h)        ; BASTXT - Address of BASIC Program
23c9 ed5355fb  ld      (0fb55h),de
23cd 201a      jr      nz,23e9h
23cf 23        inc     hl
23d0 cd211d    call    1d21h
23d3 e1        pop     hl
23d4 e5        push    hl
23d5 cd4c0b    call    0b4ch
23d8 da001d    jp      c,1d00h
23db dd21162a  ld      ix,2a16h            ; ix = {Search for line number}
23df cd9a1d    call    1d9ah
23e2 d2001d    jp      nc,1d00h
23e5 ed4355fb  ld      (0fb55h),bc
23e9 210000    ld      hl,0000h
23ec 54        ld      d,h
23ed 5d        ld      e,l
23ee d9        exx     
23ef 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
23f2 2257fb    ld      (0fb57h),hl
23f5 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
23f8 2b        dec     hl

23f9 23        inc     hl
23fa 7e        ld      a,(hl)
23fb 23        inc     hl
23fc b6        or      (hl)
23fd 284d      jr      z,244ch
23ff 23        inc     hl
2400 23        inc     hl
2401 cd5d0b    call    0b5dh
2404 200b      jr      nz,2411h
2406 d9        exx     
2407 23        inc     hl
2408 d9        exx     
2409 a7        and     a
240a 20f5      jr      nz,2401h
240c d9        exx     
240d 13        inc     de
240e d9        exx     
240f 18e8      jr      23f9h

2411 cd1f05    call    051fh
2414 20eb      jr      nz,2401h
2416 cd5d0b    call    0b5dh
2419 dde5      push    ix
241b cd211d    call    1d21h
241e dde1      pop     ix
2420 cd2c05    call    052ch
2423 281c      jr      z,2441h
2425 7b        ld      a,e
2426 02        ld      (bc),a
2427 03        inc     bc
2428 7a        ld      a,d
2429 02        ld      (bc),a
242a 7b        ld      a,e
242b 03        inc     bc
242c 02        ld      (bc),a
242d 03        inc     bc
242e 7a        ld      a,d
242f 02        ld      (bc),a
2430 03        inc     bc
2431 ed4357fb  ld      (0fb57h),bc
2435 e5        push    hl
2436 af        xor     a
2437 c5        push    bc
2438 e1        pop     hl
2439 ed72      sbc     hl,sp
243b 3803      jr      c,2440h
243d c30a1d    jp      1d0ah

2440 e1        pop     hl
2441 2b        dec     hl
2442 cd5d0b    call    0b5dh
2445 fe2c      cp      ','
2447 28cd      jr      z,2416h
2449 2b        dec     hl
244a 18b5      jr      2401h
244c 2a55fb    ld      hl,(0fb55h)
244f 5e        ld      e,(hl)
2450 7b        ld      a,e
2451 23        inc     hl
2452 56        ld      d,(hl)
2453 b2        or      d
2454 281f      jr      z,2475h
2456 d5        push    de
2457 23        inc     hl
2458 5e        ld      e,(hl)
2459 23        inc     hl
245a 56        ld      d,(hl)
245b cd2c05    call    052ch
245e dde1      pop     ix
2460 d1        pop     de
2461 2005      jr      nz,2468h
2463 7b        ld      a,e
2464 02        ld      (bc),a
2465 03        inc     bc
2466 7a        ld      a,d
2467 02        ld      (bc),a
2468 72        ld      (hl),d
2469 2b        dec     hl
246a 73        ld      (hl),e
246b eb        ex      de,hl
246c d1        pop     de
246d 19        add     hl,de
246e d5        push    de
246f e5        push    hl
2470 dde5      push    ix


; Code to be relocated at FBC0h (004eh bytes)

2472 e1        pop     hl              ; ->FBC0h (RST 8 jumps here)
2473 18da      jr      244fh

2475 2a58fc    ld      hl,(0fc58h)     ; ->FBC3h (RST 10h jumps here)          ; BASTXT - Address of BASIC Program

2478 2b        dec     hl              ; ->FBC6h (RST 18h jumps here)
2479 23        inc     hl
247a 7e        ld      a,(hl)

247b 23        inc     hl              ; ->FBC9h (RST 20h jumps here)
247c b6        or      (hl)
247d ca0d05    jp      z,050dh
2480 23        inc     hl
2481 5e        ld      e,(hl)
2482 23        inc     hl
2483 56        ld      d,(hl)
2484 cd5d0b    call    0b5dh
2487 a7        and     a
2488 28ef      jr      z,2479h
248a cd1f05    call    051fh
248d 20f5      jr      nz,2484h
248f cd5d0b    call    0b5dh
2492 30f3      jr      nc,2487h
2494 e5        push    hl
2495 dde5      push    ix
2497 cd211d    call    1d21h
249a dde1      pop     ix
249c cd2c05    call    052ch
249f 0a        ld      a,(bc)
24a0 5f        ld      e,a
24a1 03        inc     bc
24a2 0a        ld      a,(bc)
24a3 57        ld      d,a
24a4 d5        push    de
24a5 eb        ex      de,hl
24a6 2a57fb    ld      hl,(0fb57h)
24a9 e5        push    hl
24aa af        xor     a
24ab ed52      sbc     hl,de
24ad 23        inc     hl
24ae e5        push    hl
24af c1        pop     bc
24b0 e1        pop     hl
24b1 54        ld      d,h
24b2 5d        ld      e,l
24b3 13        inc     de
24b4 13        inc     de
24b5 13        inc     de
24b6 13        inc     de
24b7 c5        push    bc
24b8 dde1      pop     ix
24ba edb8      lddr    
24bc e1        pop     hl
24bd d5        push    de
24be dde5      push    ix
24c0 cd281d    call    1d28h
24c3 af        xor     a
24c4 dd21ea3f  ld      ix,3feah
24c8 cd9a1d    call    1d9ah
24cb dde1      pop     ix
24cd c1        pop     bc
24ce d1        pop     de
24cf 23        inc     hl
24d0 c5        push    bc
24d1 eda0      ldi     
24d3 7e        ld      a,(hl)
24d4 a7        and     a
24d5 20fa      jr      nz,24d1h
24d7 c1        pop     bc
24d8 1b        dec     de
24d9 d5        push    de
24da 13        inc     de
24db c5        push    bc
24dc e1        pop     hl
24dd e5        push    hl
24de d5        push    de
24df eb        ex      de,hl
24e0 af        xor     a
24e1 ed52      sbc     hl,de
24e3 23        inc     hl
24e4 23        inc     hl
24e5 23        inc     hl
24e6 d1        pop     de
24e7 e3        ex      (sp),hl
24e8 23        inc     hl
24e9 dde5      push    ix
24eb c1        pop     bc
24ec edb0      ldir    
24ee d1        pop     de
24ef 2a57fb    ld      hl,(0fb57h)
24f2 19        add     hl,de
24f3 2257fb    ld      (0fb57h),hl
24f6 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
24f9 19        add     hl,de
24fa 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
24fd e1        pop     hl
24fe e5        push    hl
24ff cd5d0b    call    0b5dh
2502 fe2c      cp      ','
2504 d1        pop     de
2505 ca8f04    jp      z,048fh
2508 eb        ex      de,hl
2509 2b        dec     hl
250a c38404    jp      0484h
250d cd2f1d    call    1d2fh
2510 dd210329  ld      ix,2903h
2514 dde5      push    ix
2516 dd214b2a  ld      ix,2a4bh
251a dde5      push    ix
251c c38a3f    jp      3f8ah

251f e5        push    hl
2520 c5        push    bc
2521 215205    ld      hl,0552h
2524 010700    ld      bc,0007h
2527 edb1      cpir    
2529 c1        pop     bc
252a e1        pop     hl
252b c9        ret     

252c e5        push    hl
252d d5        push    de
252e d5        push    de
252f c1        pop     bc
2530 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
2533 ed5b57fb  ld      de,(0fb57h)
2537 cd4c0b    call    0b4ch
253a 280e      jr      z,254ah
253c 79        ld      a,c
253d be        cp      (hl)
253e 23        inc     hl
253f 2002      jr      nz,2543h
2541 78        ld      a,b
2542 be        cp      (hl)
2543 23        inc     hl
2544 2807      jr      z,254dh
2546 23        inc     hl
2547 23        inc     hl
2548 18ed      jr      2537h

254a 3eff      ld      a,0ffh
254c a7        and     a
254d e5        push    hl
254e c1        pop     bc
254f d1        pop     de
2550 e1        pop     hl
2551 c9        ret     
2552 8d        adc     a,l
2553 91        sub     c
2554 ca959f    jp      z,9f95h
2557 8e        adc     a,(hl)
2558 90        sub     b
2559 e5        push    hl
255a 210050    ld      hl,5000h
255d 1100bf    ld      de,0bf00h
2560 cd4c0b    call    0b4ch
2563 cac905    jp      z,05c9h
2566 23        inc     hl
2567 3a8cfb    ld      a,(0fb8ch)
256a 77        ld      (hl),a
256b 0608      ld      b,08h
256d af        xor     a
256e 328cfb    ld      (0fb8ch),a
2571 cdcb05    call    05cbh
2574 db62      in      a,(62h)
2576 cb5f      bit     3,a
2578 280e      jr      z,2588h
257a 3a8cfb    ld      a,(0fb8ch)
257d cbc7      set     0,a
257f cb17      rl      a
2581 328cfb    ld      (0fb8ch),a
2584 10eb      djnz    2571h
2586 18d8      jr      2560h
2588 3a8cfb    ld      a,(0fb8ch)
258b cb87      res     0,a
258d cb17      rl      a
258f 328cfb    ld      (0fb8ch),a
2592 10dd      djnz    2571h
2594 18ca      jr      2560h
2596 e5        push    hl
2597 210050    ld      hl,5000h
259a 1100bf    ld      de,0bf00h
259d cd4c0b    call    0b4ch
25a0 cac905    jp      z,05c9h
25a3 23        inc     hl
25a4 7e        ld      a,(hl)
25a5 328cfb    ld      (0fb8ch),a
25a8 0608      ld      b,08h
25aa cdd205    call    05d2h
25ad 3a8cfb    ld      a,(0fb8ch)
25b0 cb07      rlc     a
25b2 328cfb    ld      (0fb8ch),a
25b5 cb47      bit     0,a
25b7 2808      jr      z,25c1h
25b9 3e0e      ld      a,0eh
25bb d363      out     (63h),a
25bd 10eb      djnz    25aah
25bf 18dc      jr      259dh
25c1 3e0f      ld      a,0fh
25c3 d363      out     (63h),a
25c5 10e3      djnz    25aah
25c7 18d4      jr      259dh
25c9 e1        pop     hl
25ca c9        ret     
25cb c5        push    bc
25cc 0608      ld      b,08h
25ce 10fe      djnz    25ceh
25d0 c1        pop     bc
25d1 c9        ret     
25d2 c5        push    bc
25d3 0608      ld      b,08h
25d5 10fe      djnz    25d5h
25d7 c1        pop     bc
25d8 c9        ret     
25d9 cd520b    call    0b52h
25dc 57        ld      d,a
25dd cd520b    call    0b52h
25e0 41        ld      b,c
25e1 cd520b    call    0b52h
25e4 50        ld      d,b
25e5 c9        ret

25e6 cdd905    call    05d9h
25e9 2b        dec     hl
25ea cd5d0b    call    0b5dh
25ed cd661d    call    1d66h
25f0 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
25f3 fe03      cp      03h
25f5 c2fb1c    jp      nz,1cfbh
25f8 d5        push    de
25f9 cd520b    call    0b52h
25fc 2c        inc     l
25fd cd661d    call    1d66h
2600 c1        pop     bc
2601 e5        push    hl
2602 c5        push    bc
2603 e1        pop     hl
2604 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2607 fe03      cp      03h
2609 c2fb1c    jp      nz,1cfbh
260c 0603      ld      b,03h
260e 4e        ld      c,(hl)
260f 1a        ld      a,(de)
2610 77        ld      (hl),a
2611 79        ld      a,c
2612 12        ld      (de),a
2613 13        inc     de
2614 23        inc     hl
2615 10f7      djnz    260eh
2617 e1        pop     hl
2618 c9        ret

2619 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
261c 74        ld      (hl),h
261d dd21e529  ld      ix,29e5h
2621 cd9a1d    call    1d9ah
2624 dd210329  ld      ix,2903h
2628 dde5      push    ix
262a dd21432a  ld      ix,2a43h
262e dde5      push    ix
2630 c38a3f    jp      3f8ah

2633 e5        push    hl
2634 cdc51c    call    1cc5h
2637 cd6c1d    call    1d6ch
263a e5        push    hl
263b dde1      pop     ix
263d e1        pop     hl
263e 2b        dec     hl
263f cd5d0b    call    0b5dh
2642 fe2c      cp      ','
2644 2007      jr      nz,264dh
2646 23        inc     hl
2647 cd961d    call    1d96h
264a d5        push    de
264b 18f1      jr      263eh
264d e5        push    hl
264e cd9a1d    call    1d9ah
2651 e1        pop     hl
2652 c9        ret     
2653 e5        push    hl
2654 cdc51c    call    1cc5h
2657 cd721d    call    1d72h
265a 21fc3f    ld      hl,3ffch
265d cd481d    call    1d48h
2660 cd4e1d    call    1d4eh
2663 e1        pop     hl
2664 c9        ret     
2665 e5        push    hl
2666 cdc51c    call    1cc5h
2669 cd721d    call    1d72h
266c 21e1ff    ld      hl,0ffe1h
266f cd3c1d    call    1d3ch
2672 21fc3f    ld      hl,3ffch
2675 cd421d    call    1d42h
2678 21e1ff    ld      hl,0ffe1h
267b cd481d    call    1d48h
267e cd541d    call    1d54h
2681 e1        pop     hl
2682 c9        ret

2683 cd5d0b    call    0b5dh
2686 cdc51c    call    1cc5h
2689 cd520b    call    0b52h
268c 28e5      jr      z,2673h
268e 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
2691 224efb    ld      (0fb4eh),hl
2694 e1        pop     hl
2695 cd5a1d    call    1d5ah
2698 e5        push    hl
2699 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
269c fe03      cp      03h
269e cab506    jp      z,06b5h
26a1 cd6c1d    call    1d6ch
26a4 3eff      ld      a,0ffh
26a6 a4        and     h
26a7 c2001d    jp      nz,1d00h
26aa 7c        ld      a,h
26ab b5        or      l
26ac ca001d    jp      z,1d00h
26af 2b        dec     hl
26b0 229dfb    ld      (0fb9dh),hl
26b3 1808      jr      26bdh
26b5 210000    ld      hl,0000h
26b8 229dfb    ld      (0fb9dh),hl
26bb 182c      jr      26e9h
26bd e1        pop     hl
26be cdef06    call    06efh
26c1 329ffb    ld      (0fb9fh),a
26c4 a7        and     a
26c5 ca001d    jp      z,1d00h
26c8 ed53a3fb  ld      (0fba3h),de
26cc e1        pop     hl
26cd cdef06    call    06efh
26d0 32a1fb    ld      (0fba1h),a
26d3 a7        and     a
26d4 ca001d    jp      z,1d00h
26d7 ed53a5fb  ld      (0fba5h),de
26db e1        pop     hl
26dc cd520b    call    0b52h
26df 29        add     hl,hl
26e0 e5        push    hl
26e1 2a4efb    ld      hl,(0fb4eh)
26e4 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
26e7 181c      jr      2705h
26e9 e1        pop     hl
26ea cdf906    call    06f9h
26ed 18d2      jr      26c1h

26ef cd520b    call    0b52h
26f2 2c        inc     l
26f3 cd5a1d    call    1d5ah
26f6 cd601d    call    1d60h
26f9 d1        pop     de
26fa e5        push    hl
26fb d5        push    de
26fc 2a41fe    ld      hl,(0fe41h)        ; FACCU
26ff 7e        ld      a,(hl)
2700 23        inc     hl
2701 5e        ld      e,(hl)
2702 23        inc     hl
2703 56        ld      d,(hl)
2704 c9        ret

2705 ed4b9dfb  ld      bc,(0fb9dh)
2709 3aa1fb    ld      a,(0fba1h)
270c 81        add     a,c
270d 4f        ld      c,a
270e 3a9ffb    ld      a,(0fb9fh)
2711 b9        cp      c
2712 da001d    jp      c,1d00h
2715 cd2207    call    0722h
2718 2241fe    ld      (0fe41h),hl        ; FACCU
271b 3e02      ld      a,02h
271d 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2720 e1        pop     hl
2721 c9        ret

2722 2aa3fb    ld      hl,(0fba3h)
2725 ed5b9dfb  ld      de,(0fb9dh)
2729 19        add     hl,de
272a 22a7fb    ld      (0fba7h),hl
272d cd3a07    call    073ah
2730 2804      jr      z,2736h
2732 210000    ld      hl,0000h
2735 c9        ret     
2736 2600      ld      h,00h
2738 69        ld      l,c
2739 c9        ret     
273a 3aa1fb    ld      a,(0fba1h)
273d 3d        dec     a
273e 4f        ld      c,a
273f 3a9dfb    ld      a,(0fb9dh)
2742 47        ld      b,a
2743 3a9ffb    ld      a,(0fb9fh)
2746 90        sub     b
2747 91        sub     c
2748 47        ld      b,a
2749 3a9dfb    ld      a,(0fb9dh)
274c 4f        ld      c,a
274d 3aa1fb    ld      a,(0fba1h)
2750 1600      ld      d,00h
2752 0c        inc     c
2753 5f        ld      e,a
2754 2aa7fb    ld      hl,(0fba7h)
2757 e5        push    hl
2758 dde1      pop     ix
275a 2aa5fb    ld      hl,(0fba5h)
275d e5        push    hl
275e fde1      pop     iy
2760 dd7e00    ld      a,(ix+00h)
2763 fdbe00    cp      (iy+00h)
2766 200a      jr      nz,2772h
2768 dd23      inc     ix
276a fd23      inc     iy
276c 1d        dec     e
276d 7b        ld      a,e
276e a7        and     a
276f c8        ret     z
2770 18ee      jr      2760h
2772 2aa7fb    ld      hl,(0fba7h)
2775 23        inc     hl
2776 22a7fb    ld      (0fba7h),hl
2779 10d2      djnz    274dh
277b 3eff      ld      a,0ffh
277d a7        and     a
277e c9        ret

277f cd5d0b    call    0b5dh
2782 cdc51c    call    1cc5h
2785 fe28      cp      28h
2787 c2f61c    jp      nz,1cf6h
278a 23        inc     hl
278b cd661d    call    1d66h
278e cd601d    call    1d60h
2791 eb        ex      de,hl
2792 d5        push    de
2793 7e        ld      a,(hl)
2794 23        inc     hl
2795 5e        ld      e,(hl)
2796 23        inc     hl
2797 56        ld      d,(hl)
2798 eb        ex      de,hl
2799 3297fb    ld      (0fb97h),a
279c a7        and     a
279d ca001d    jp      z,1d00h
27a0 2295fb    ld      (0fb95h),hl
27a3 e1        pop     hl
27a4 cd520b    call    0b52h
27a7 2c        inc     l
27a8 cd961d    call    1d96h
27ab da001d    jp      c,1d00h
27ae 7a        ld      a,d
27af b3        or      e
27b0 ca001d    jp      z,1d00h
27b3 ed5399fb  ld      (0fb99h),de
27b7 cd520b    call    0b52h
27ba 2c        inc     l
27bb cd961d    call    1d96h
27be da001d    jp      c,1d00h
27c1 7b        ld      a,e
27c2 b2        or      d
27c3 ca001d    jp      z,1d00h
27c6 ed539bfb  ld      (0fb9bh),de
27ca 3a99fb    ld      a,(0fb99h)
27cd 47        ld      b,a
27ce 3a97fb    ld      a,(0fb97h)
27d1 90        sub     b
27d2 3c        inc     a
27d3 3c        inc     a
27d4 47        ld      b,a
27d5 3a9bfb    ld      a,(0fb9bh)
27d8 b8        cp      b
27d9 d2001d    jp      nc,1d00h
27dc cd520b    call    0b52h
27df 29        add     hl,hl
27e0 cd520b    call    0b52h
27e3 d5        push    de
27e4 e5        push    hl
27e5 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
27e8 224efb    ld      (0fb4eh),hl
27eb e1        pop     hl
27ec cd5a1d    call    1d5ah
27ef cd601d    call    1d60h
27f2 e5        push    hl
27f3 2a4efb    ld      hl,(0fb4eh)
27f6 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
27f9 2a41fe    ld      hl,(0fe41h)        ; FACCU
27fc 7e        ld      a,(hl)
27fd 23        inc     hl
27fe 5e        ld      e,(hl)
27ff 23        inc     hl
2800 56        ld      d,(hl)
2801 f5        push    af
2802 3a9bfb    ld      a,(0fb9bh)
2805 47        ld      b,a
2806 f1        pop     af
2807 4f        ld      c,a
2808 2a95fb    ld      hl,(0fb95h)
280b d5        push    de
280c ed5b99fb  ld      de,(0fb99h)
2810 1b        dec     de
2811 19        add     hl,de
2812 d1        pop     de
2813 1a        ld      a,(de)
2814 77        ld      (hl),a
2815 13        inc     de
2816 23        inc     hl
2817 0d        dec     c
2818 2802      jr      z,281ch
281a 10f7      djnz    2813h
281c e1        pop     hl
281d c9        ret


281e 2b        dec     hl
281f cdc51c    call    1cc5h
2822 cd5d0b    call    0b5dh
2825 7e        ld      a,(hl)
2826 febe      cp      0beh
2828 ca4008    jp      z,0840h
282b fec1      cp      0c1h
282d ca3308    jp      z,0833h
2830 c3f61c    jp      1cf6h


2833 23        inc     hl
2834 cd520b    call    0b52h
2837 d5        push    de
2838 cd961d    call    1d96h
283b ed5342fc  ld      (0fc42h),de        ; Address of USR subroutine
283f c9        ret

2840 cd5d0b    call    0b5dh
2843 cd361d    call    1d36h
2846 e5        push    hl
2847 cd6c1d    call    1d6ch
284a eb        ex      de,hl
284b e1        pop     hl
284c 3eff      ld      a,0ffh
284e a2        and     d
284f c2001d    jp      nz,1d00h
2852 3e08      ld      a,08h
2854 bb        cp      e
2855 da001d    jp      c,1d00h
2858 7b        ld      a,e
2859 a7        and     a
285a ca001d    jp      z,1d00h
285d 87        add     a,a
285e 83        add     a,e
285f f5        push    af
2860 cd520b    call    0b52h
2863 d5        push    de
2864 cd961d    call    1d96h
2867 f1        pop     af
2868 e5        push    hl
2869 d5        push    de
286a 21f3fb    ld      hl,0fbf3h
286d 1600      ld      d,00h
286f 5f        ld      e,a
2870 19        add     hl,de
2871 3ec3      ld      a,0c3h
2873 77        ld      (hl),a
2874 23        inc     hl
2875 d1        pop     de
2876 73        ld      (hl),e
2877 23        inc     hl
2878 72        ld      (hl),d
2879 e1        pop     hl
287a c9        ret

287b 2b        dec     hl
287c cd5d0b    call    0b5dh
287f 281c      jr      z,289dh

; Syntax Error (SN ERROR)
2881 cdc51c    call    1cc5h
2884 dd213a2d  ld      ix,2d3ah            ; LNUM_PARM - Get specified line number
2888 cd9a1d    call    1d9ah
288b e5        push    hl

; ERROR, E=error code
288c dd21162a  ld      ix,2a16h            ; ix = {Search for line number}
2890 cd9a1d    call    1d9ah
2893 e1        pop     hl
2894 d2051d    jp      nc,1d05h
2897 0b        dec     bc
2898 ed431ffe  ld      (0fe1fh),bc        ; Points to byte following last char
289c c9        ret

289d eb        ex      de,hl
289e 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
28a1 2b        dec     hl
28a2 221ffe    ld      (0fe1fh),hl        ; Points to byte following last char
28a5 eb        ex      de,hl
28a6 c9        ret

28a7 e5        push    hl
28a8 cdc51c    call    1cc5h
28ab cd6c1d    call    1d6ch
28ae 110020    ld      de,2000h
28b1 cd4c0b    call    0b4ch
28b4 da001d    jp      c,1d00h
28b7 11ff9f    ld      de,9fffh
28ba cd4c0b    call    0b4ch
28bd d2001d    jp      nc,1d00h
28c0 cd0f1d    call    1d0fh
28c3 db50      in      a,(50h)        ; get system status
28c5 e610      and     10h
28c7 28fa      jr      z,28c3h        ; wait for CSYNC - Composite video sync.signal 
28c9 5e        ld      e,(hl)
28ca 1600      ld      d,00h
28cc ed5341fe  ld      (0fe41h),de        ; FACCU
28d0 3e02      ld      a,02h
28d2 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
28d5 cd1b1d    call    1d1bh
28d8 e1        pop     hl
28d9 c9        ret

28da e5        push    hl
28db cdc51c    call    1cc5h
28de cd6c1d    call    1d6ch
28e1 cd781d    call    1d78h
28e4 ed5341fe  ld      (0fe41h),de        ; FACCU
28e8 3e02      ld      a,02h
28ea 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
28ed e1        pop     hl
28ee c9        ret     
28ef e5        push    hl
28f0 cdc51c    call    1cc5h
28f3 cd6c1d    call    1d6ch
28f6 e5        push    hl
28f7 3e2f      ld      a,2fh
28f9 dd214b37  ld      ix,374bh		; IX = {MKTMST - Make temporary string}
28fd cd9a1d    call    1d9ah
2900 2af4fd    ld      hl,(0fdf4h)
2903 d1        pop     de
2904 0610      ld      b,10h
2906 c5        push    bc
2907 cd841d    call    1d84h
290a cd240a    call    0a24h
290d 3e20      ld      a,20h
290f 77        ld      (hl),a
2910 23        inc     hl
2911 13        inc     de
2912 c1        pop     bc
2913 10f1      djnz    2906h
2915 21f3fd    ld      hl,0fdf3h        ; TMPSTR: 3 bytes used to hold length and addr of a string when moved to string area
2918 2241fe    ld      (0fe41h),hl        ; FACCU
291b 3e03      ld      a,03h

; PROMPT
291d 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2920 e1        pop     hl
2921 c9        ret


2922 cd5d0b    call    0b5dh
2925 cdc51c    call    1cc5h
2928 fec6      cp      0c6h
292a cad20a    jp      z,0ad2h
292d fe48      cp      48h
292f caf809    jp      z,09f8h
2932 fe42      cp      42h
2934 ca430a    jp      z,0a43h
2937 fe4f      cp      4fh
2939 ca8f0a    jp      z,0a8fh
293c e5        push    hl
293d 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
2940 224efb    ld      (0fb4eh),hl
2943 e1        pop     hl
2944 dd212b32  ld      ix,322bh            ; IX = {EVAL}
2948 cd9a1d    call    1d9ah
294b e5        push    hl
294c dd215e19  ld      ix,195eh
2950 cd9a1d    call    1d9ah
2953 ed5b41fe  ld      de,(0fe41h)        ; FACCU
2957 1a        ld      a,(de)
2958 fe12      cp      12h
295a d2001d    jp      nc,1d00h
295d 3260fb    ld      (0fb60h),a
2960 47        ld      b,a
2961 13        inc     de
2962 eb        ex      de,hl
2963 5e        ld      e,(hl)
2964 23        inc     hl
2965 56        ld      d,(hl)
2966 1a        ld      a,(de)
2967 13        inc     de
2968 e65f      and     5fh
296a fe42      cp      42h
296c cabb09    jp      z,09bbh
296f fe4f      cp      4fh
2971 cad709    jp      z,09d7h
2974 fe48      cp      48h
2976 c2001d    jp      nz,1d00h
2979 3a60fb    ld      a,(0fb60h)
297c fe06      cp      06h
297e d2001d    jp      nc,1d00h
2981 05        dec     b
2982 78        ld      a,b
2983 a7        and     a
2984 ca001d    jp      z,1d00h
2987 210000    ld      hl,0000h
298a 29        add     hl,hl
298b 29        add     hl,hl
298c 29        add     hl,hl
298d 29        add     hl,hl
298e 1a        ld      a,(de)
298f fe3a      cp      3ah
2991 3809      jr      c,299ch
2993 fe41      cp      41h        ; FACCU
2995 da001d    jp      c,1d00h
2998 e6df      and     0dfh
299a d607      sub     07h
299c d630      sub     30h
299e da001d    jp      c,1d00h
29a1 fe10      cp      10h
29a3 d2001d    jp      nc,1d00h
29a6 b5        or      l
29a7 6f        ld      l,a
29a8 13        inc     de
29a9 10df      djnz    298ah
29ab 2241fe    ld      (0fe41h),hl        ; FACCU
29ae 3e02      ld      a,02h
29b0 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
29b3 2a4efb    ld      hl,(0fb4eh)
29b6 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
29b9 e1        pop     hl
29ba c9        ret

29bb 210000    ld      hl,0000h
29be 05        dec     b
29bf 78        ld      a,b
29c0 a7        and     a
29c1 ca001d    jp      z,1d00h
29c4 29        add     hl,hl
29c5 1a        ld      a,(de)
29c6 13        inc     de
29c7 fe30      cp      30h
29c9 2807      jr      z,29d2h
29cb fe31      cp      31h
29cd c2001d    jp      nz,1d00h
29d0 cbc5      set     0,l
29d2 10f0      djnz    29c4h
29d4 c3ab09    jp      09abh
29d7 210000    ld      hl,0000h
29da 05        dec     b
29db 78        ld      a,b
29dc a7        and     a
29dd ca001d    jp      z,1d00h
29e0 29        add     hl,hl
29e1 29        add     hl,hl
29e2 29        add     hl,hl
29e3 1a        ld      a,(de)
29e4 13        inc     de
29e5 fe30      cp      30h
29e7 da001d    jp      c,1d00h
29ea fe38      cp      38h
29ec d2001d    jp      nc,1d00h
29ef d630      sub     30h
29f1 b5        or      l
29f2 6f        ld      l,a
29f3 10eb      djnz    29e0h
29f5 c3ab09    jp      09abh
29f8 23        inc     hl
29f9 cd961d    call    1d96h
29fc e5        push    hl
29fd d5        push    de
29fe 3e05      ld      a,05h
2a00 dd214b37  ld      ix,374bh		; IX = {MKTMST - Make temporary string}
2a04 cd9a1d    call    1d9ah
2a07 2af4fd    ld      hl,(0fdf4h)
2a0a 3e48      ld      a,48h
2a0c 77        ld      (hl),a
2a0d d1        pop     de
2a0e cd1e0a    call    0a1eh
2a11 21f3fd    ld      hl,0fdf3h        ; TMPSTR: 3 bytes used to hold length and addr of a string when moved to string area
2a14 3e03      ld      a,03h

; FIND_LNUM - Search for line number
2a16 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2a19 2241fe    ld      (0fe41h),hl        ; FACCU
2a1c e1        pop     hl
2a1d c9        ret

2a1e 23        inc     hl
2a1f 7a        ld      a,d
2a20 cd240a    call    0a24h
2a23 7b        ld      a,e
2a24 f5        push    af
2a25 cb3f      srl     a
2a27 cb3f      srl     a
2a29 cb3f      srl     a
2a2b cb3f      srl     a
2a2d cd3b0a    call    0a3bh
2a30 77        ld      (hl),a
2a31 23        inc     hl
2a32 f1        pop     af
2a33 e60f      and     0fh
2a35 cd3b0a    call    0a3bh
2a38 77        ld      (hl),a
2a39 23        inc     hl
2a3a c9        ret     
2a3b c630      add     a,30h
2a3d fe3a      cp      3ah
2a3f f8        ret     m
2a40 c607      add     a,07h
2a42 c9        ret

2a43 23        inc     hl
2a44 cd961d    call    1d96h
2a47 e5        push    hl
2a48 d5        push    de
2a49 3e11      ld      a,11h
2a4b dd214b37  ld      ix,374bh		; IX = {MKTMST - Make temporary string}
2a4f cd9a1d    call    1d9ah
2a52 2af4fd    ld      hl,(0fdf4h)
2a55 3e42      ld      a,42h
2a57 77        ld      (hl),a
2a58 111000    ld      de,0010h
2a5b 19        add     hl,de
2a5c d1        pop     de
2a5d cd6d0a    call    0a6dh
2a60 21f3fd    ld      hl,0fdf3h        ; TMPSTR: 3 bytes used to hold length and addr of a string when moved to string area
2a63 3e03      ld      a,03h
2a65 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2a68 2241fe    ld      (0fe41h),hl        ; FACCU
2a6b e1        pop     hl
2a6c c9        ret

2a6d 7b        ld      a,e
2a6e 0607      ld      b,07h
2a70 cd760a    call    0a76h
2a73 7a        ld      a,d
2a74 0607      ld      b,07h
2a76 d5        push    de
2a77 5f        ld      e,a
2a78 e601      and     01h
2a7a c630      add     a,30h
2a7c 77        ld      (hl),a
2a7d 2b        dec     hl
2a7e 7b        ld      a,e
2a7f cb3f      srl     a
2a81 5f        ld      e,a
2a82 e601      and     01h
2a84 c630      add     a,30h
2a86 77        ld      (hl),a
2a87 2b        dec     hl
2a88 7b        ld      a,e
2a89 cb3f      srl     a
2a8b 10f4      djnz    2a81h
2a8d d1        pop     de
2a8e c9        ret     
2a8f 23        inc     hl
2a90 cd961d    call    1d96h
2a93 e5        push    hl
2a94 d5        push    de
2a95 3e07      ld      a,07h
2a97 dd214b37  ld      ix,374bh		; IX = {MKTMST - Make temporary string}
2a9b cd9a1d    call    1d9ah
2a9e 2af4fd    ld      hl,(0fdf4h)
2aa1 3e4f      ld      a,4fh
2aa3 77        ld      (hl),a
2aa4 110600    ld      de,0006h
2aa7 19        add     hl,de
2aa8 d1        pop     de
2aa9 cdb90a    call    0ab9h
2aac 21f3fd    ld      hl,0fdf3h        ; TMPSTR: 3 bytes used to hold length and addr of a string when moved to string area
2aaf 3e03      ld      a,03h
2ab1 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2ab4 2241fe    ld      (0fe41h),hl        ; FACCU
2ab7 e1        pop     hl
2ab8 c9        ret

2ab9 eb        ex      de,hl
2aba 0606      ld      b,06h
2abc 3e07      ld      a,07h
2abe a5        and     l
2abf c630      add     a,30h
2ac1 12        ld      (de),a
2ac2 cb3c      srl     h
2ac4 cb1d      rr      l
2ac6 cb3c      srl     h
2ac8 cb1d      rr      l
2aca cb3c      srl     h
2acc cb1d      rr      l
2ace 1b        dec     de
2acf 10eb      djnz    2abch
2ad1 c9        ret     
2ad2 23        inc     hl
2ad3 cdc51c    call    1cc5h
2ad6 cd580e    call    0e58h
2ad9 e5        push    hl

2ada cdc813    call    13c8h
2add 5f        ld      e,a
2ade 3a8afb    ld      a,(0fb8ah)
2ae1 cb4f      bit     1,a
2ae3 78        ld      a,b
2ae4 2001      jr      nz,2ae7h
2ae6 7b        ld      a,e
2ae7 a0        and     b
2ae8 f5        push    af
2ae9 3a8bfb    ld      a,(0fb8bh)
2aec d370      out     (70h),a        ; Set system status
2aee f1        pop     af
2aef 2802      jr      z,2af3h
2af1 3eff      ld      a,0ffh
2af3 2141fe    ld      hl,0fe41h        ; FACCU
2af6 77        ld      (hl),a
2af7 23        inc     hl
2af8 77        ld      (hl),a
2af9 3e02      ld      a,02h
2afb 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
2afe e1        pop     hl
2aff c9        ret

2b00 2b        dec     hl
2b01 cdc51c    call    1cc5h
2b04 cd5d0b    call    0b5dh
2b07 23        inc     hl
2b08 feaa      cp      0aah
2b0a ca740b    jp      z,0b74h
2b0d fe43      cp      43h
2b0f caad0b    jp      z,0badh
2b12 fe53      cp      53h
2b14 cad30b    jp      z,0bd3h
2b17 fe4f      cp      4fh
2b19 ca7a15    jp      z,157ah
2b1c fe58      cp      58h
2b1e ca0b0e    jp      z,0e0bh
2b21 fe84      cp      84h
2b23 ca6a14    jp      z,146ah
2b26 fe90      cp      90h
2b28 ca0c16    jp      z,160ch
2b2b fe83      cp      83h
2b2d ca240e    jp      z,0e24h
2b30 fe82      cp      82h
2b32 ca430e    jp      z,0e43h
2b35 fe50      cp      50h
2b37 caca17    jp      z,17cah
2b3a fecb      cp      0cbh
2b3c cacb18    jp      z,18cbh
2b3f feb2      cp      0b2h
2b41 ca470c    jp      z,0c47h
2b44 fea1      cp      0a1h
2b46 ca3b16    jp      z,163bh
2b49 c3f61c    jp      1cf6h
2b4c 7c        ld      a,h
2b4d 92        sub     d
2b4e c0        ret     nz
2b4f 7d        ld      a,l
2b50 93        sub     e
2b51 c9        ret     
2b52 7e        ld      a,(hl)
2b53 e3        ex      (sp),hl
2b54 be        cp      (hl)
2b55 23        inc     hl
2b56 e3        ex      (sp),hl
2b57 ca5d0b    jp      z,0b5dh
2b5a c3f61c    jp      1cf6h
2b5d 23        inc     hl
2b5e 7e        ld      a,(hl)
2b5f fe3a      cp      3ah
2b61 d0        ret     nc
2b62 fe20      cp      20h
2b64 28f7      jr      z,2b5dh
2b66 fe0b      cp      0bh
2b68 3004      jr      nc,2b6eh
2b6a fe09      cp      09h
2b6c 30ef      jr      nc,2b5dh
2b6e fe30      cp      30h
2b70 3f        ccf     
2b71 3c        inc     a
2b72 3d        dec     a
2b73 c9        ret

2b74 e5        push    hl
2b75 cd0f1d    call    1d0fh
2b78 210140    ld      hl,4001h
2b7b e5        push    hl
2b7c 112001    ld      de,0120h
2b7f 0e28      ld      c,28h
2b81 3a8afb    ld      a,(0fb8ah)
2b84 cb47      bit     0,a
2b86 2002      jr      nz,2b8ah
2b88 0e50      ld      c,50h
2b8a 41        ld      b,c
2b8b db50      in      a,(50h)        ; get system status
2b8d e610      and     10h
2b8f 28fa      jr      z,2b8bh        ; wait for CSYNC - Composite video sync.signal 
2b91 7e        ld      a,(hl)
2b92 2b        dec     hl
2b93 77        ld      (hl),a
2b94 23        inc     hl
2b95 19        add     hl,de
2b96 10f3      djnz    2b8bh
2b98 e1        pop     hl
2b99 23        inc     hl
2b9a e5        push    hl
2b9b 112041    ld      de,4120h
2b9e cd4c0b    call    0b4ch
2ba1 112001    ld      de,0120h
2ba4 41        ld      b,c
2ba5 38e4      jr      c,2b8bh
2ba7 cd1b1d    call    1d1bh
2baa e1        pop     hl
2bab e1        pop     hl
2bac c9        ret     
2bad cd520b    call    0b52h
2bb0 4f        ld      c,a
2bb1 cd520b    call    0b52h
2bb4 50        ld      d,b
2bb5 cd520b    call    0b52h
2bb8 59        ld      e,c
2bb9 e5        push    hl
2bba cd4c14    call    144ch
2bbd cd0f1d    call    1d0fh
2bc0 210040    ld      hl,4000h
2bc3 11006d    ld      de,6d00h
2bc6 01002d    ld      bc,2d00h
2bc9 edb0      ldir    
2bcb cd1b1d    call    1d1bh
2bce cd5414    call    1454h
2bd1 e1        pop     hl
2bd2 c9        ret     
2bd3 cdd905    call    05d9h
2bd6 e5        push    hl
2bd7 cd4c14    call    144ch
2bda cd0f1d    call    1d0fh
2bdd 01002d    ld      bc,2d00h
2be0 210040    ld      hl,4000h
2be3 11006d    ld      de,6d00h
2be6 7e        ld      a,(hl)
2be7 f5        push    af
2be8 1a        ld      a,(de)
2be9 77        ld      (hl),a
2bea f1        pop     af
2beb 12        ld      (de),a
2bec 23        inc     hl
2bed 13        inc     de
2bee 0b        dec     bc
2bef 78        ld      a,b
2bf0 b1        or      c
2bf1 20f3      jr      nz,2be6h
2bf3 cd1b1d    call    1d1bh
2bf6 cd5414    call    1454h
2bf9 e1        pop     hl
2bfa c9        ret     
2bfb 2b        dec     hl
2bfc cd5d0b    call    0b5dh
2bff fe23      cp      23h
2c01 c2f61c    jp      nz,1cf6h
2c04 cd5d0b    call    0b5dh
2c07 fe28      cp      28h
2c09 cd361d    call    1d36h
2c0c e5        push    hl
2c0d cd6c1d    call    1d6ch
2c10 7c        ld      a,h
2c11 a7        and     a
2c12 c2001d    jp      nz,1d00h
2c15 7d        ld      a,l
2c16 a7        and     a
2c17 2822      jr      z,2c3bh
2c19 fe01      cp      01h
2c1b ca2f0c    jp      z,0c2fh
2c1e fe02      cp      02h
2c20 c2001d    jp      nz,1d00h
2c23 3a8afb    ld      a,(0fb8ah)
2c26 cbe7      set     4,a
2c28 cbaf      res     5,a
2c2a 328afb    ld      (0fb8ah),a
2c2d 1816      jr      2c45h
2c2f 3a8afb    ld      a,(0fb8ah)
2c32 cbe7      set     4,a
2c34 cbef      set     5,a
2c36 328afb    ld      (0fb8ah),a
2c39 180a      jr      2c45h
2c3b 3a8afb    ld      a,(0fb8ah)
2c3e cba7      res     4,a
2c40 cbef      set     5,a
2c42 328afb    ld      (0fb8ah),a
2c45 e1        pop     hl
2c46 c9        ret     
2c47 e5        push    hl
2c48 af        xor     a
2c49 328cfb    ld      (0fb8ch),a
2c4c 3e0d      ld      a,0dh
2c4e cd6c0d    call    0d6ch
2c51 3e0a      ld      a,0ah
2c53 cd6c0d    call    0d6ch
2c56 210000    ld      hl,0000h
2c59 22adfb    ld      (0fbadh),hl
2c5c 22affb    ld      (0fbafh),hl
2c5f 22abfb    ld      (0fbabh),hl
2c62 cdf70c    call    0cf7h
2c65 22affb    ld      (0fbafh),hl
2c68 cd580d    call    0d58h
2c6b 2805      jr      z,2c72h
2c6d 06c0      ld      b,0c0h
2c6f cd640d    call    0d64h
2c72 cd500d    call    0d50h
2c75 cd580d    call    0d58h
2c78 2805      jr      z,2c7fh
2c7a 0630      ld      b,30h
2c7c cd640d    call    0d64h
2c7f cd500d    call    0d50h
2c82 cd580d    call    0d58h
2c85 2805      jr      z,2c8ch
2c87 060c      ld      b,0ch
2c89 cd640d    call    0d64h
2c8c cd500d    call    0d50h
2c8f cd580d    call    0d58h
2c92 2805      jr      z,2c99h
2c94 0603      ld      b,03h
2c96 cd640d    call    0d64h
2c99 3a8cfb    ld      a,(0fb8ch)
2c9c cd6c0d    call    0d6ch
2c9f 3a8afb    ld      a,(0fb8ah)
2ca2 cb47      bit     0,a
2ca4 2806      jr      z,2cach
2ca6 3a8cfb    ld      a,(0fb8ch)
2ca9 cd6c0d    call    0d6ch
2cac af        xor     a
2cad 328cfb    ld      (0fb8ch),a
2cb0 2a85fb    ld      hl,(0fb85h)
2cb3 2b        dec     hl
2cb4 ed5badfb  ld      de,(0fbadh)
2cb8 ed52      sbc     hl,de
2cba 7c        ld      a,h
2cbb b5        or      l
2cbc 280d      jr      z,2ccbh
2cbe 2aadfb    ld      hl,(0fbadh)
2cc1 23        inc     hl
2cc2 22adfb    ld      (0fbadh),hl
2cc5 2aabfb    ld      hl,(0fbabh)
2cc8 c3650c    jp      0c65h
2ccb 3e0a      ld      a,0ah
2ccd cd6c0d    call    0d6ch
2cd0 cd500d    call    0d50h
2cd3 22abfb    ld      (0fbabh),hl
2cd6 112001    ld      de,0120h
2cd9 cd4c0b    call    0b4ch
2cdc d2eb0c    jp      nc,0cebh
2cdf 210000    ld      hl,0000h
2ce2 22adfb    ld      (0fbadh),hl
2ce5 2aabfb    ld      hl,(0fbabh)
2ce8 c3620c    jp      0c62h

2ceb 3e1b      ld      a,1bh
2ced cd6c0d    call    0d6ch
2cf0 3e40      ld      a,40h
2cf2 cd6c0d    call    0d6ch
2cf5 e1        pop     hl
2cf6 c9        ret

2cf7 3e1b      ld      a,1bh
2cf9 cd6c0d    call    0d6ch
2cfc 3e33      ld      a,33h
2cfe cd6c0d    call    0d6ch
2d01 3a8afb    ld      a,(0fb8ah)
2d04 cb67      bit     4,a
2d06 201a      jr      nz,2d22h
2d08 3e14      ld      a,14h
2d0a cd6c0d    call    0d6ch
2d0d 3e1b      ld      a,1bh
2d0f cd6c0d    call    0d6ch
2d12 3e4b      ld      a,4bh
2d14 cd6c0d    call    0d6ch
2d17 3e80      ld      a,80h
2d19 cd6c0d    call    0d6ch
2d1c 3e02      ld      a,02h
2d1e cd6c0d    call    0d6ch
2d21 c9        ret

2d22 3a8afb    ld      a,(0fb8ah)
2d25 cb6f      bit     5,a

2d27 2816      jr      z,2d3fh
2d29 3e16      ld      a,16h
2d2b cd6c0d    call    0d6ch
2d2e 3e1b      ld      a,1bh
2d30 cd6c0d    call    0d6ch
2d33 3e2a      ld      a,2ah
; Error: Illegal function call (FC ERROR)
2d35 cd6c0d    call    0d6ch
2d38 3e04      ld      a,04h

; LNUM_PARM - Get specified line number
2d3a cd6c0d    call    0d6ch
2d3d 18d8      jr      2d17h
2d3f 3e14      ld      a,14h
2d41 cd6c0d    call    0d6ch
2d44 3e1b      ld      a,1bh
2d46 cd6c0d    call    0d6ch
2d49 3e4c      ld      a,4ch
2d4b cd6c0d    call    0d6ch
2d4e 18c7      jr      2d17h
2d50 2aaffb    ld      hl,(0fbafh)
2d53 23        inc     hl
2d54 22affb    ld      (0fbafh),hl
2d57 c9        ret

2d58 cdc813    call    13c8h
2d5b a0        and     b
2d5c f5        push    af
2d5d 3a8bfb    ld      a,(0fb8bh)
2d60 d370      out     (70h),a        ; Set system status
2d62 f1        pop     af
2d63 c9        ret     
2d64 3a8cfb    ld      a,(0fb8ch)
2d67 b0        or      b
2d68 328cfb    ld      (0fb8ch),a
2d6b c9        ret

2d6c dd212d0c  ld      ix,0c2dh             ; IX = {List routine}
2d70 cd9a1d    call    1d9ah
2d73 c9        ret

2d74 2b        dec     hl
2d75 cdc51c    call    1cc5h
2d78 cd5d0b    call    0b5dh
2d7b cd520b    call    0b52h
2d7e 28cd      jr      z,2d4dh
2d80 96        sub     (hl)
2d81 1d        dec     e
2d82 ed535dfb  ld      (0fb5dh),de
2d86 cd520b    call    0b52h
2d89 2c        inc     l
2d8a cd961d    call    1d96h
2d8d ed5363fb  ld      (0fb63h),de
2d91 cd520b    call    0b52h
2d94 29        add     hl,hl
2d95 cd520b    call    0b52h
2d98 2c        inc     l
2d99 cd961d    call    1d96h

; ?Gosub routine?
2d9c ed5365fb  ld      (0fb65h),de
2da0 af        xor     a
2da1 3261fb    ld      (0fb61h),a
2da4 3a8afb    ld      a,(0fb8ah)
2da7 cb47      bit     0,a
2da9 2005      jr      nz,2db0h
2dab 3e01      ld      a,01h
2dad 3261fb    ld      (0fb61h),a
2db0 7e        ld      a,(hl)
2db1 fe2c      cp      ','
2db3 280c      jr      z,2dc1h
2db5 af        xor     a
2db6 3289fb    ld      (0fb89h),a
2db9 3eff      ld      a,0ffh
2dbb 325ffb    ld      (0fb5fh),a
2dbe c3050e    jp      0e05h

2dc1 23        inc     hl
2dc2 cd961d    call    1d96h
2dc5 7b        ld      a,e
2dc6 3289fb    ld      (0fb89h),a
2dc9 fe03      cp      03h
2dcb d2001d    jp      nc,1d00h
2dce 3a8afb    ld      a,(0fb8ah)
2dd1 cb47      bit     0,a
2dd3 2006      jr      nz,2ddbh
2dd5 7b        ld      a,e
2dd6 fe02      cp      02h
2dd8 ca001d    jp      z,1d00h
2ddb 7e        ld      a,(hl)
2ddc fe2c      cp      ','
2dde 3eff      ld      a,0ffh
2de0 325ffb    ld      (0fb5fh),a
2de3 2020      jr      nz,2e05h
2de5 23        inc     hl
2de6 cd961d    call    1d96h
2de9 da001d    jp      c,1d00h
2dec 7b        ld      a,e
2ded 325ffb    ld      (0fb5fh),a
2df0 7e        ld      a,(hl)
2df1 fe2c      cp      ','
2df3 2010      jr      nz,2e05h
2df5 23        inc     hl
2df6 cd961d    call    1d96h
2df9 da001d    jp      c,1d00h
2dfc 7b        ld      a,e
2dfd fe09      cp      09h
2dff d2001d    jp      nc,1d00h
2e02 3261fb    ld      (0fb61h),a
2e05 e5        push    hl
2e06 cd8710    call    1087h
2e09 e1        pop     hl
2e0a c9        ret

2e0b 7e        ld      a,(hl)

2e0c fe83      cp      83h
2e0e c2f61c    jp      nz,1cf6h
2e11 23        inc     hl
2e12 cd580e    call    0e58h
2e15 e5        push    hl
2e16 cdc813    call    13c8h
2e19 a8        xor     b
2e1a 47        ld      b,a
2e1b 3a8afb    ld      a,(0fb8ah)
2e1e cb4f      bit     1,a
2e20 201f      jr      nz,2e41h
2e22 1810      jr      2e34h
2e24 cd580e    call    0e58h
2e27 e5        push    hl
2e28 cdc813    call    13c8h
2e2b b0        or      b
2e2c 47        ld      b,a
2e2d 3a8afb    ld      a,(0fb8ah)
2e30 cb4f      bit     1,a
2e32 200d      jr      nz,2e41h
2e34 db50      in      a,(50h)        ; get system status
2e36 e610      and     10h
2e38 28fa      jr      z,2e34h        ; wait for CSYNC - Composite video sync.signal 
2e3a 78        ld      a,b
2e3b 77        ld      (hl),a
2e3c 3a8bfb    ld      a,(0fb8bh)
2e3f d370      out     (70h),a        ; Set system status
2e41 e1        pop     hl
2e42 c9        ret     
2e43 cd580e    call    0e58h
2e46 e5        push    hl
2e47 cdc813    call    13c8h
2e4a 57        ld      d,a
2e4b 3a8afb    ld      a,(0fb8ah)
2e4e cb4f      bit     1,a
2e50 20ef      jr      nz,2e41h
2e52 78        ld      a,b
2e53 2f        cpl     
2e54 a2        and     d
2e55 47        ld      b,a
2e56 18dc      jr      2e34h

2e58 2b        dec     hl
2e59 cd5d0b    call    0b5dh
2e5c cd520b    call    0b52h
2e5f 28cd      jr      z,2e2eh
2e61 96        sub     (hl)
2e62 1d        dec     e
2e63 ed53adfb  ld      (0fbadh),de
2e67 cd520b    call    0b52h
2e6a 2c        inc     l
2e6b cd961d    call    1d96h
2e6e ed53affb  ld      (0fbafh),de
2e72 cd520b    call    0b52h
2e75 29        add     hl,hl
2e76 c9        ret

2e77 2b        dec     hl
2e78 cdc51c    call    1cc5h
2e7b cd5d0b    call    0b5dh
2e7e fe89      cp      89h
2e80 c2ed0e    jp      nz,0eedh
2e83 cd5d0b    call    0b5dh
2e86 dd211c37  ld      ix,371ch
2e8a cd9a1d    call    1d9ah
2e8d 7e        ld      a,(hl)
2e8e fe22      cp      22h
2e90 2024      jr      nz,2eb6h
2e92 dd215a37  ld      ix,375ah
2e96 cd9a1d    call    1d9ah
2e99 dd21c030  ld      ix,30c0h
2e9d cd9a1d    call    1d9ah
2ea0 7e        ld      a,(hl)
2ea1 23        inc     hl
2ea2 fe2c      cp      ','
2ea4 2810      jr      z,2eb6h
2ea6 fe3b      cp      3bh
2ea8 c2f61c    jp      nz,1cf6h
2eab e5        push    hl
2eac 3e3f      ld      a,3fh
2eae dd21a00b  ld      ix,0ba0h        ; IX = {OUTC (alias OUTDO): print character}
2eb2 cd9a1d    call    1d9ah
2eb5 e1        pop     hl
2eb6 e5        push    hl
2eb7 dd21fa08  ld      ix,08fah        ; IX = {Console line input routine}
2ebb cd9a1d    call    1d9ah
2ebe c1        pop     bc
2ebf dd21a92c  ld      ix,2ca9h
2ec3 da9a1d    jp      c,1d9ah
2ec6 c5        push    bc
2ec7 e3        ex      (sp),hl
2ec8 dd210135  ld      ix,3501h        ; GETVAR: Find address of variable
2ecc cd9a1d    call    1d9ah
2ecf dd215e19  ld      ix,195eh
2ed3 cd9a1d    call    1d9ah
2ed6 eb        ex      de,hl
2ed7 e3        ex      (sp),hl
2ed8 d5        push    de
2ed9 0600      ld      b,00h
2edb dd215c37  ld      ix,375ch
2edf cd9a1d    call    1d9ah
2ee2 e1        pop     hl
2ee3 af        xor     a
2ee4 dd211d2e  ld      ix,2e1dh
2ee8 dde5      push    ix
2eea c38a3f    jp      3f8ah
2eed 2b        dec     hl
2eee cd5d0b    call    0b5dh
2ef1 7e        ld      a,(hl)
2ef2 fece      cp      0ceh
2ef4 2013      jr      nz,2f09h
2ef6 23        inc     hl
2ef7 ed5b7dfb  ld      de,(0fb7dh)
2efb ed5375fb  ld      (0fb75h),de
2eff ed5b7ffb  ld      de,(0fb7fh)
2f03 ed5377fb  ld      (0fb77h),de
2f07 181e      jr      2f27h
2f09 cd520b    call    0b52h
2f0c 28cd      jr      z,2edbh
2f0e 96        sub     (hl)
2f0f 1d        dec     e
2f10 ed5375fb  ld      (0fb75h),de
2f14 cd520b    call    0b52h
2f17 2c        inc     l
2f18 cd961d    call    1d96h
2f1b ed5377fb  ld      (0fb77h),de
2f1f cd520b    call    0b52h
2f22 29        add     hl,hl
2f23 cd520b    call    0b52h
2f26 ce2b      adc     a,2bh
2f28 cd5d0b    call    0b5dh
2f2b cd520b    call    0b52h
2f2e 28cd      jr      z,2efdh
2f30 96        sub     (hl)
2f31 1d        dec     e
2f32 ed5379fb  ld      (0fb79h),de
2f36 ed537dfb  ld      (0fb7dh),de
2f3a cd520b    call    0b52h
2f3d 2c        inc     l
2f3e cd961d    call    1d96h
2f41 ed537bfb  ld      (0fb7bh),de
2f45 ed537ffb  ld      (0fb7fh),de
2f49 cd520b    call    0b52h
2f4c 29        add     hl,hl
2f4d 7e        ld      a,(hl)
2f4e fe2c      cp      ','
2f50 2806      jr      z,2f58h
2f52 af        xor     a
2f53 3289fb    ld      (0fb89h),a
2f56 1821      jr      2f79h
2f58 23        inc     hl
2f59 cd961d    call    1d96h
2f5c 7b        ld      a,e
2f5d fe03      cp      03h
2f5f d2001d    jp      nc,1d00h
2f62 3289fb    ld      (0fb89h),a
2f65 7e        ld      a,(hl)
2f66 fe2c      cp      ','
2f68 200f      jr      nz,2f79h
2f6a cd5d0b    call    0b5dh
2f6d 7e        ld      a,(hl)
2f6e fe42      cp      42h
2f70 c2f61c    jp      nz,1cf6h
2f73 cd5d0b    call    0b5dh
2f76 c3920f    jp      0f92h
2f79 e5        push    hl
2f7a cd9312    call    1293h
2f7d e1        pop     hl
2f7e 110000    ld      de,0000h
2f81 ed5375fb  ld      (0fb75h),de
2f85 ed5377fb  ld      (0fb77h),de
2f89 ed5379fb  ld      (0fb79h),de
2f8d ed537bfb  ld      (0fb7bh),de
2f91 c9        ret     
2f92 7e        ld      a,(hl)
2f93 fe46      cp      46h
2f95 ca1d10    jp      z,101dh
2f98 2b        dec     hl
2f99 cd5d0b    call    0b5dh
2f9c caa20f    jp      z,0fa2h
2f9f c3f61c    jp      1cf6h
2fa2 ed5b75fb  ld      de,(0fb75h)
2fa6 d5        push    de
2fa7 ed5b77fb  ld      de,(0fb77h)
2fab d5        push    de
2fac ed5b79fb  ld      de,(0fb79h)
2fb0 d5        push    de
2fb1 ed5b7bfb  ld      de,(0fb7bh)
2fb5 d5        push    de
2fb6 e5        push    hl
2fb7 fde1      pop     iy
2fb9 dde1      pop     ix
2fbb c1        pop     bc
2fbc d1        pop     de
2fbd e1        pop     hl
2fbe fde5      push    iy
2fc0 2275fb    ld      (0fb75h),hl
2fc3 ed4379fb  ld      (0fb79h),bc
2fc7 ed5377fb  ld      (0fb77h),de
2fcb ed537bfb  ld      (0fb7bh),de
2fcf cd7d10    call    107dh
2fd2 ed4379fb  ld      (0fb79h),bc
2fd6 ed5377fb  ld      (0fb77h),de
2fda ed4375fb  ld      (0fb75h),bc
2fde dd227bfb  ld      (0fb7bh),ix
2fe2 cd7310    call    1073h
2fe5 ed4375fb  ld      (0fb75h),bc
2fe9 dd227bfb  ld      (0fb7bh),ix
2fed 2279fb    ld      (0fb79h),hl
2ff0 dd2277fb  ld      (0fb77h),ix
2ff4 cd7d10    call    107dh
2ff7 2279fb    ld      (0fb79h),hl
2ffa dd2277fb  ld      (0fb77h),ix
2ffe ed537bfb  ld      (0fb7bh),de
3002 2275fb    ld      (0fb75h),hl
3005 cd7310    call    1073h
3008 e1        pop     hl
3009 110000    ld      de,0000h
300c ed5375fb  ld      (0fb75h),de
3010 ed5377fb  ld      (0fb77h),de
3014 ed5379fb  ld      (0fb79h),de
3018 ed537bfb  ld      (0fb7bh),de
301c c9        ret     
301d cd5d0b    call    0b5dh
3020 e5        push    hl
3021 2a75fb    ld      hl,(0fb75h)
3024 2281fb    ld      (0fb81h),hl
3027 2a77fb    ld      hl,(0fb77h)
302a ed5b7bfb  ld      de,(0fb7bh)
302e ed52      sbc     hl,de
3030 2a77fb    ld      hl,(0fb77h)
3033 fa4610    jp      m,1046h
3036 ed5377fb  ld      (0fb77h),de
303a 227bfb    ld      (0fb7bh),hl
303d 227ffb    ld      (0fb7fh),hl
3040 ed5383fb  ld      (0fb83h),de
3044 1803      jr      3049h
3046 2283fb    ld      (0fb83h),hl
3049 2a81fb    ld      hl,(0fb81h)
304c 2275fb    ld      (0fb75h),hl
304f 2a7dfb    ld      hl,(0fb7dh)
3052 2279fb    ld      (0fb79h),hl
3055 cd7d10    call    107dh
3058 2a83fb    ld      hl,(0fb83h)
305b ed5b7ffb  ld      de,(0fb7fh)
305f e5        push    hl
3060 ed52      sbc     hl,de
3062 e1        pop     hl
3063 280c      jr      z,3071h
3065 23        inc     hl
3066 2283fb    ld      (0fb83h),hl
3069 2277fb    ld      (0fb77h),hl
306c 227bfb    ld      (0fb7bh),hl
306f 18d8      jr      3049h
3071 e1        pop     hl
3072 c9        ret

3073 e5        push    hl
3074 d5        push    de
3075 c5        push    bc
3076 cddb16    call    16dbh
3079 c1        pop     bc
307a d1        pop     de
307b e1        pop     hl
307c c9        ret     
307d e5        push    hl
307e d5        push    de
307f c5        push    bc
3080 cd0117    call    1701h
3083 c1        pop     bc
3084 d1        pop     de
3085 e1        pop     hl
3086 c9        ret     
3087 3a8afb    ld      a,(0fb8ah)
308a cbdf      set     3,a
308c 328afb    ld      (0fb8ah),a
308f 3a61fb    ld      a,(0fb61h)
3092 a7        and     a
3093 280a      jr      z,309fh
3095 47        ld      b,a
3096 2a63fb    ld      hl,(0fb63h)
3099 29        add     hl,hl
309a 10fd      djnz    3099h
309c 2263fb    ld      (0fb63h),hl
309f 210000    ld      hl,0000h
30a2 2275fb    ld      (0fb75h),hl
30a5 2a65fb    ld      hl,(0fb65h)
30a8 cb7c      bit     7,h
30aa c0        ret     nz
30ab 2277fb    ld      (0fb77h),hl
30ae eb        ex      de,hl
30af 210100    ld      hl,0001h
30b2 ed52      sbc     hl,de
30b4 29        add     hl,hl
30b5 2267fb    ld      (0fb67h),hl
30b8 cd5511    call    1155h
30bb 2a77fb    ld      hl,(0fb77h)
30be ed5b75fb  ld      de,(0fb75h)
30c2 13        inc     de
30c3 2b        dec     hl
30c4 cd4c0b    call    0b4ch
30c7 d8        ret     c
30c8 1b        dec     de
30c9 cb7c      bit     7,h
30cb c0        ret     nz
30cc 2a67fb    ld      hl,(0fb67h)
30cf cb7c      bit     7,h
30d1 2006      jr      nz,30d9h
30d3 7c        ld      a,h
30d4 b5        or      l
30d5 2014      jr      nz,30ebh
30d7 183b      jr      3114h
30d9 2a77fb    ld      hl,(0fb77h)
30dc 29        add     hl,hl
30dd eb        ex      de,hl
30de 2a67fb    ld      hl,(0fb67h)
30e1 29        add     hl,hl
30e2 19        add     hl,de
30e3 2b        dec     hl
30e4 2b        dec     hl
30e5 cb7c      bit     7,h
30e7 2017      jr      nz,3100h
30e9 1829      jr      3114h
30eb 2a75fb    ld      hl,(0fb75h)
30ee 29        add     hl,hl
30ef eb        ex      de,hl
30f0 2a67fb    ld      hl,(0fb67h)
30f3 29        add     hl,hl
30f4 ed52      sbc     hl,de
30f6 2b        dec     hl
30f7 2b        dec     hl
30f8 cb7c      bit     7,h
30fa c21411    jp      nz,1114h
30fd c33711    jp      1137h
3100 2a75fb    ld      hl,(0fb75h)
3103 23        inc     hl
3104 2275fb    ld      (0fb75h),hl
3107 29        add     hl,hl
3108 23        inc     hl
3109 ed5b67fb  ld      de,(0fb67h)
310d 19        add     hl,de
310e 2267fb    ld      (0fb67h),hl
3111 c3b810    jp      10b8h
3114 2a75fb    ld      hl,(0fb75h)
3117 23        inc     hl
3118 2275fb    ld      (0fb75h),hl
311b 29        add     hl,hl
311c ed5b77fb  ld      de,(0fb77h)
3120 1b        dec     de
3121 ed5377fb  ld      (0fb77h),de
3125 eb        ex      de,hl
3126 29        add     hl,hl
3127 eb        ex      de,hl
3128 ed52      sbc     hl,de
312a 23        inc     hl
312b 23        inc     hl
312c ed5b67fb  ld      de,(0fb67h)
3130 19        add     hl,de
3131 2267fb    ld      (0fb67h),hl
3134 c3b810    jp      10b8h
3137 2a77fb    ld      hl,(0fb77h)
313a 2b        dec     hl
313b 2277fb    ld      (0fb77h),hl
313e 29        add     hl,hl
313f ed5b67fb  ld      de,(0fb67h)
3143 eb        ex      de,hl
3144 ed52      sbc     hl,de
3146 23        inc     hl
3147 2267fb    ld      (0fb67h),hl
314a c3b810    jp      10b8h
314d 7a        ld      a,d
314e 2f        cpl     
314f 57        ld      d,a
3150 7b        ld      a,e
3151 2f        cpl     
3152 5f        ld      e,a
3153 13        inc     de
3154 c9        ret     
3155 ed5b75fb  ld      de,(0fb75h)
3159 cd4d11    call    114dh
315c ed5369fb  ld      (0fb69h),de
3160 ed5b77fb  ld      de,(0fb77h)
3164 cd4d11    call    114dh
3167 ed536bfb  ld      (0fb6bh),de
316b 2a75fb    ld      hl,(0fb75h)
316e ed5b5dfb  ld      de,(0fb5dh)
3172 19        add     hl,de
3173 22adfb    ld      (0fbadh),hl
3176 2a77fb    ld      hl,(0fb77h)
3179 ed4b63fb  ld      bc,(0fb63h)
317d 3a5ffb    ld      a,(0fb5fh)
3180 cb4f      bit     1,a
3182 2803      jr      z,3187h
3184 cd4412    call    1244h
3187 2a6bfb    ld      hl,(0fb6bh)
318a ed4b63fb  ld      bc,(0fb63h)
318e 3a5ffb    ld      a,(0fb5fh)
3191 cb77      bit     6,a
3193 280a      jr      z,319fh
3195 3a8afb    ld      a,(0fb8ah)
3198 cb5f      bit     3,a
319a 2003      jr      nz,319fh
319c cd4412    call    1244h
319f 2a69fb    ld      hl,(0fb69h)
31a2 ed5b5dfb  ld      de,(0fb5dh)
31a6 19        add     hl,de
31a7 22adfb    ld      (0fbadh),hl
31aa 2a77fb    ld      hl,(0fb77h)
31ad ed4b63fb  ld      bc,(0fb63h)
31b1 3a5ffb    ld      a,(0fb5fh)
31b4 cb57      bit     2,a
31b6 280a      jr      z,31c2h
31b8 3a8afb    ld      a,(0fb8ah)
31bb cb5f      bit     3,a
31bd 2003      jr      nz,31c2h
31bf cd4412    call    1244h
31c2 2a6bfb    ld      hl,(0fb6bh)
31c5 ed4b63fb  ld      bc,(0fb63h)
31c9 3a5ffb    ld      a,(0fb5fh)
31cc cb6f      bit     5,a
31ce 2803      jr      z,31d3h
31d0 cd4412    call    1244h
31d3 2a77fb    ld      hl,(0fb77h)
31d6 ed4b63fb  ld      bc,(0fb63h)
31da ed5b5dfb  ld      de,(0fb5dh)
31de 19        add     hl,de
31df 22adfb    ld      (0fbadh),hl
31e2 2a75fb    ld      hl,(0fb75h)
31e5 3a5ffb    ld      a,(0fb5fh)
31e8 cb47      bit     0,a
31ea 2803      jr      z,31efh
31ec cd4412    call    1244h
31ef 2a69fb    ld      hl,(0fb69h)
31f2 ed4b63fb  ld      bc,(0fb63h)
31f6 3a5ffb    ld      a,(0fb5fh)
31f9 cb7f      bit     7,a
31fb 280a      jr      z,3207h
31fd 3a8afb    ld      a,(0fb8ah)
3200 cb5f      bit     3,a
3202 2003      jr      nz,3207h
3204 cd4412    call    1244h
3207 2a6bfb    ld      hl,(0fb6bh)
320a ed5b5dfb  ld      de,(0fb5dh)
320e 19        add     hl,de
320f 22adfb    ld      (0fbadh),hl
3212 2a69fb    ld      hl,(0fb69h)
3215 ed4b63fb  ld      bc,(0fb63h)
3219 3a5ffb    ld      a,(0fb5fh)
321c cb67      bit     4,a
321e 2803      jr      z,3223h
3220 cd4412    call    1244h
3223 2a75fb    ld      hl,(0fb75h)
3226 ed4b63fb  ld      bc,(0fb63h)
322a 3a5ffb    ld      a,(0fb5fh)
322d cb5f      bit     3,a
322f 280a      jr      z,323bh
3231 3a8afb    ld      a,(0fb8ah)
3234 cb5f      bit     3,a
3236 2003      jr      nz,323bh
3238 cd4412    call    1244h
323b 3a8afb    ld      a,(0fb8ah)
323e cb9f      res     3,a
3240 328afb    ld      (0fb8ah),a
3243 c9        ret     
3244 09        add     hl,bc
3245 3a61fb    ld      a,(0fb61h)
3248 a7        and     a
3249 2807      jr      z,3252h
324b 47        ld      b,a
324c cb3c      srl     h
324e cb1d      rr      l
3250 10fa      djnz    324ch
3252 22affb    ld      (0fbafh),hl
3255 cd5912    call    1259h
3258 c9        ret     
3259 c5        push    bc
325a d5        push    de
325b cdc813    call    13c8h
325e f5        push    af
325f 3a8afb    ld      a,(0fb8ah)
3262 cb4f      bit     1,a
3264 2803      jr      z,3269h
3266 f1        pop     af
3267 1827      jr      3290h
3269 3a89fb    ld      a,(0fb89h)
326c fe00      cp      00h
326e 2810      jr      z,3280h
3270 fe01      cp      01h
3272 2804      jr      z,3278h
3274 f1        pop     af
3275 a8        xor     b
3276 180a      jr      3282h
3278 f1        pop     af
3279 57        ld      d,a
327a 78        ld      a,b
327b 2f        cpl     
327c a2        and     d
327d 47        ld      b,a
327e 1802      jr      3282h
3280 f1        pop     af
3281 b0        or      b
3282 47        ld      b,a
3283 db50      in      a,(50h)        ; get system status
3285 e610      and     10h
3287 28fa      jr      z,3283h        ; wait for CSYNC - Composite video sync.signal 
3289 78        ld      a,b
328a 77        ld      (hl),a
328b 3a8bfb    ld      a,(0fb8bh)
328e d370      out     (70h),a        ; Set system status
3290 d1        pop     de
3291 c1        pop     bc
3292 c9        ret

3293 af        xor     a
3294 3263fb    ld      (0fb63h),a
3297 325ffb    ld      (0fb5fh),a
329a 3e01      ld      a,01h
329c 2a79fb    ld      hl,(0fb79h)
329f ed5b75fb  ld      de,(0fb75h)
32a3 b7        or      a
32a4 ed52      sbc     hl,de
32a6 f2c712    jp      p,12c7h
32a9 ed5b79fb  ld      de,(0fb79h)
32ad 2a75fb    ld      hl,(0fb75h)
32b0 ed5375fb  ld      (0fb75h),de
32b4 2279fb    ld      (0fb79h),hl
32b7 2a77fb    ld      hl,(0fb77h)
32ba ed5b7bfb  ld      de,(0fb7bh)
32be ed5377fb  ld      (0fb77h),de
32c2 227bfb    ld      (0fb7bh),hl
32c5 18d3      jr      329ah
32c7 2a79fb    ld      hl,(0fb79h)
32ca ed5b75fb  ld      de,(0fb75h)
32ce ed52      sbc     hl,de
32d0 226ffb    ld      (0fb6fh),hl
32d3 2a7bfb    ld      hl,(0fb7bh)
32d6 ed5b77fb  ld      de,(0fb77h)
32da ed52      sbc     hl,de
32dc 2271fb    ld      (0fb71h),hl
32df 210100    ld      hl,0001h
32e2 2273fb    ld      (0fb73h),hl
32e5 f2fb12    jp      p,12fbh
32e8 21ffff    ld      hl,0ffffh
32eb 2273fb    ld      (0fb73h),hl
32ee ed5b7bfb  ld      de,(0fb7bh)
32f2 2a77fb    ld      hl,(0fb77h)
32f5 ed52      sbc     hl,de
32f7 23        inc     hl
32f8 2271fb    ld      (0fb71h),hl
32fb 3a63fb    ld      a,(0fb63h)
32fe a7        and     a
32ff 2033      jr      nz,3334h
3301 3e01      ld      a,01h
3303 2a6ffb    ld      hl,(0fb6fh)
3306 ed5b71fb  ld      de,(0fb71h)
330a b7        or      a
330b ed52      sbc     hl,de
330d f23413    jp      p,1334h
3310 2a75fb    ld      hl,(0fb75h)
3313 ed5b77fb  ld      de,(0fb77h)
3317 2277fb    ld      (0fb77h),hl
331a ed5375fb  ld      (0fb75h),de
331e 2a79fb    ld      hl,(0fb79h)
3321 ed5b7bfb  ld      de,(0fb7bh)
3325 227bfb    ld      (0fb7bh),hl
3328 ed5379fb  ld      (0fb79h),de
332c 3eff      ld      a,0ffh
332e 3263fb    ld      (0fb63h),a
3331 c39a12    jp      129ah
3334 2a71fb    ld      hl,(0fb71h)
3337 29        add     hl,hl
3338 2267fb    ld      (0fb67h),hl
333b ed5b6ffb  ld      de,(0fb6fh)
333f ed52      sbc     hl,de
3341 2265fb    ld      (0fb65h),hl
3344 ed52      sbc     hl,de
3346 2269fb    ld      (0fb69h),hl
3349 2a73fb    ld      hl,(0fb73h)
334c cb7c      bit     7,h
334e 280a      jr      z,335ah
3350 2a65fb    ld      hl,(0fb65h)
3353 ed5b67fb  ld      de,(0fb67h)
3357 2265fb    ld      (0fb65h),hl
335a 2a77fb    ld      hl,(0fb77h)
335d 226dfb    ld      (0fb6dh),hl
3360 2a75fb    ld      hl,(0fb75h)
3363 226bfb    ld      (0fb6bh),hl
3366 3a63fb    ld      a,(0fb63h)
3369 a7        and     a
336a 2811      jr      z,337dh
336c 2a6bfb    ld      hl,(0fb6bh)
336f 22affb    ld      (0fbafh),hl
3372 2a6dfb    ld      hl,(0fb6dh)
3375 22adfb    ld      (0fbadh),hl
3378 cd5912    call    1259h
337b 180f      jr      338ch
337d 2a6dfb    ld      hl,(0fb6dh)
3380 22affb    ld      (0fbafh),hl
3383 2a6bfb    ld      hl,(0fb6bh)
3386 22adfb    ld      (0fbadh),hl
3389 cd5912    call    1259h
338c 2a75fb    ld      hl,(0fb75h)
338f ed5b79fb  ld      de,(0fb79h)
3393 b7        or      a
3394 ed52      sbc     hl,de
3396 7c        ld      a,h
3397 b5        or      l
3398 282d      jr      z,33c7h
339a 2a75fb    ld      hl,(0fb75h)
339d 23        inc     hl
339e 2275fb    ld      (0fb75h),hl
33a1 2a65fb    ld      hl,(0fb65h)
33a4 cb7c      bit     7,h
33a6 280a      jr      z,33b2h
33a8 ed5b67fb  ld      de,(0fb67h)
33ac 19        add     hl,de
33ad 2265fb    ld      (0fb65h),hl
33b0 18ae      jr      3360h
33b2 ed5b69fb  ld      de,(0fb69h)
33b6 19        add     hl,de
33b7 2265fb    ld      (0fb65h),hl
33ba 2a6dfb    ld      hl,(0fb6dh)
33bd ed5b73fb  ld      de,(0fb73h)
33c1 19        add     hl,de
33c2 226dfb    ld      (0fb6dh),hl
33c5 1899      jr      3360h
33c7 c9        ret     
33c8 3a8afb    ld      a,(0fb8ah)
33cb cb8f      res     1,a
33cd 328afb    ld      (0fb8ah),a
33d0 2aadfb    ld      hl,(0fbadh)
33d3 ed5b85fb  ld      de,(0fb85h)
33d7 3efc      ld      a,0fch
33d9 a4        and     h
33da 2019      jr      nz,33f5h
33dc cd4c0b    call    0b4ch
33df d2f513    jp      nc,13f5h
33e2 2aaffb    ld      hl,(0fbafh)
33e5 3efe      ld      a,0feh
33e7 a4        and     h
33e8 200b      jr      nz,33f5h
33ea 112001    ld      de,0120h
33ed cd4c0b    call    0b4ch
33f0 d2f513    jp      nc,13f5h
33f3 180c      jr      3401h
33f5 3a8afb    ld      a,(0fb8ah)
33f8 cbcf      set     1,a
33fa 328afb    ld      (0fb8ah),a
33fd 210000    ld      hl,0000h
3400 c9        ret     
3401 2aadfb    ld      hl,(0fbadh)
3404 3e07      ld      a,07h
3406 a5        and     l
3407 114414    ld      de,1444h
340a 83        add     a,e
340b 3001      jr      nc,340eh
340d 14        inc     d
340e 5f        ld      e,a
340f 1a        ld      a,(de)
3410 47        ld      b,a
3411 3ef8      ld      a,0f8h
3413 a5        and     l
3414 6f        ld      l,a
3415 29        add     hl,hl
3416 29        add     hl,hl
3417 e5        push    hl
3418 29        add     hl,hl
3419 29        add     hl,hl
341a 29        add     hl,hl
341b d1        pop     de
341c 19        add     hl,de
341d ed5baffb  ld      de,(0fbafh)
3421 19        add     hl,de
3422 110040    ld      de,4000h
3425 19        add     hl,de
3426 11fe9f    ld      de,9ffeh
3429 cd4c0b    call    0b4ch
342c d2f513    jp      nc,13f5h
342f 110040    ld      de,4000h
3432 cd4c0b    call    0b4ch
3435 daf513    jp      c,13f5h
3438 cd0f1d    call    1d0fh
343b db50      in      a,(50h)        ; get system status
343d e610      and     10h
343f ca3b14    jp      z,143bh        ; wait for CSYNC - Composite video sync.signal 
3442 7e        ld      a,(hl)
3443 c9        ret

3444 80        add     a,b
3445 40        ld      b,b
3446 2010      jr      nz,3458h
3448 08        ex      af,af'
3449 04        inc     b
344a 02        ld      (bc),a
344b 013e01    ld      bc,013eh
344e d330      out     (30h),a            ; CRTC register select
3450 af        xor     a
3451 d331      out     (31h),a
3453 c9        ret

3454 3e01      ld      a,01h
3456 d330      out     (30h),a            ; CRTC register select
3458 db50      in      a,(50h)            ; get system status
345a e604      and     04h
345c 2006      jr      nz,3464h
345e 3a67fc    ld      a,(0fc67h)        ; No. of characters displayed in a horiz scan
3461 d331      out     (31h),a
3463 c9        ret

3464 3a77fc    ld      a,(0fc77h)
3467 d331      out     (31h),a
3469 c9        ret

346a 7e        ld      a,(hl)
346b fe4c      cp      4ch
346d 2004      jr      nz,3473h
346f 23        inc     hl
3470 c3f914    jp      14f9h
3473 e5        push    hl
3474 cd4315    call    1543h
3477 dd215500  ld      ix,0055h				; IX = {HI-RES Selection routine}
347b cd9a1d    call    1d9ah
347e 3a8afb    ld      a,(0fb8ah)
3481 cb87      res     0,a
3483 328afb    ld      (0fb8ah),a
3486 118002    ld      de,0280h
3489 ed5385fb  ld      (0fb85h),de
348d cd4c14    call    144ch
3490 cd0f1d    call    1d0fh
3493 210040    ld      hl,4000h
3496 110140    ld      de,4001h
3499 af        xor     a
349a 77        ld      (hl),a
349b 01fe5f    ld      bc,5ffeh
349e edb0      ldir    
34a0 210004    ld      hl,0400h
34a3 2263fb    ld      (0fb63h),hl
34a6 111204    ld      de,0412h
34a9 ed5367fb  ld      (0fb67h),de
34ad dd210020  ld      ix,2000h
34b1 fd210030  ld      iy,3000h
34b5 3e50      ld      a,50h
34b7 3265fb    ld      (0fb65h),a
34ba 3a65fb    ld      a,(0fb65h)
34bd 47        ld      b,a
34be 2a63fb    ld      hl,(0fb63h)
34c1 111200    ld      de,0012h
34c4 7d        ld      a,l
34c5 dd7700    ld      (ix+00h),a
34c8 7c        ld      a,h
34c9 fd7700    ld      (iy+00h),a
34cc dd23      inc     ix
34ce fd23      inc     iy
34d0 19        add     hl,de
34d1 10ee      djnz    34c1h
34d3 2a63fb    ld      hl,(0fb63h)
34d6 23        inc     hl
34d7 2263fb    ld      (0fb63h),hl
34da ed5b67fb  ld      de,(0fb67h)
34de cd4c0b    call    0b4ch
34e1 20d7      jr      nz,34bah
34e3 210028    ld      hl,2800h
34e6 010008    ld      bc,0800h
34e9 cbc6      set     0,(hl)
34eb 23        inc     hl
34ec 0b        dec     bc
34ed 78        ld      a,b
34ee b1        or      c
34ef 20f8      jr      nz,34e9h
34f1 cd5414    call    1454h
34f4 cd1b1d    call    1d1bh

34f7 e1        pop     hl
34f8 c9        ret   


34f9 e5        push    hl
34fa cd4b15    call    154bh
34fd dd215200  ld      ix,0052h				; IX = {LO-RES Selection routine}

; GETVAR: Find address of variable
3501 cd9a1d    call    1d9ah
3504 3a8afb    ld      a,(0fb8ah)
3507 cbc7      set     0,a
3509 328afb    ld      (0fb8ah),a
350c 114001    ld      de,0140h
350f ed5385fb  ld      (0fb85h),de
3513 cd4c14    call    144ch
3516 cd0f1d    call    1d0fh
3519 210040    ld      hl,4000h
351c 110140    ld      de,4001h
351f af        xor     a
3520 77        ld      (hl),a
3521 01002d    ld      bc,2d00h
3524 edb0      ldir    
3526 210004    ld      hl,0400h
3529 2263fb    ld      (0fb63h),hl
352c 111204    ld      de,0412h
352f ed5367fb  ld      (0fb67h),de
3533 dd210020  ld      ix,2000h
3537 fd210030  ld      iy,3000h
353b 3e28      ld      a,28h
353d 3265fb    ld      (0fb65h),a
3540 c3ba14    jp      14bah
3543 219f05    ld      hl,059fh
3546 22e1fb    ld      (0fbe1h),hl        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
3549 1806      jr      3551h
354b 21cf02    ld      hl,02cfh
354e 22e1fb    ld      (0fbe1h),hl        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
3551 21c415    ld      hl,15c4h
3554 1166fc    ld      de,0fc66h        ; LOW SCREEN RESOLUTION CRTC DATA
3557 012400    ld      bc,0024h            ; 16*2+2*2 (2CRTC tables + 2 word parameters with the respective size in characters)
355a edb0      ldir    
355c 219f05    ld      hl,059fh
355f 2288fc    ld      (0fc88h),hl        ; MAX No. of characters displayed in high resolution
3562 215005    ld      hl,0550h
3565 228cfc    ld      (0fc8ch),hl
3568 21cf02    ld      hl,02cfh
356b 2286fc    ld      (0fc86h),hl        ; MAX No. of characters displayed in low resolution
356e 21a802    ld      hl,02a8h
3571 228afc    ld      (0fc8ah),hl
3574 3e12      ld      a,12h
3576 328ffc    ld      (0fc8fh),a        ; No.of lines displayed by screen
3579 c9        ret     

357a cd520b    call    0b52h
357d 46        ld      b,(hl)
357e cd520b    call    0b52h
3581 46        ld      b,(hl)
3582 e5        push    hl
3583 21e815    ld      hl,15e8h
3586 1166fc    ld      de,0fc66h        ; LOW SCREEN RESOLUTION CRTC DATA
3589 012400    ld      bc,0024h
358c edb0      ldir    
358e 21bf03    ld      hl,03bfh
3591 2286fc    ld      (0fc86h),hl        ; MAX No. of characters displayed in low resolution
3594 219803    ld      hl,0398h
3597 228afc    ld      (0fc8ah),hl
359a 3e18      ld      a,18h            ; 24 lines
359c 328ffc    ld      (0fc8fh),a        ; No.of lines displayed by screen
359f 217f07    ld      hl,077fh
35a2 2288fc    ld      (0fc88h),hl        ; MAX No. of characters displayed in high resolution
35a5 22e1fb    ld      (0fbe1h),hl        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
35a8 213007    ld      hl,0730h
35ab 228cfc    ld      (0fc8ch),hl
35ae 3a8afb    ld      a,(0fb8ah)
35b1 cb47      bit     0,a
35b3 2006      jr      nz,35bbh

35b5 dd215500  ld      ix,0055h				; IX = {HI-RES Selection routine}
35b9 1804      jr      35bfh

35bb dd215200  ld      ix,0052h				; IX = {LO-RES Selection routine}

35bf cd9a1d    call    1d9ah
35c2 e1        pop     hl
35c3 c9        ret     
35c4 3f        ccf     
35c5 2831      jr      z,35f8h
35c7 05        dec     b
35c8 12        ld      (de),a
35c9 08        ex      af,af'
35ca 12        ld      (de),a
35cb 12        ld      (de),a
35cc 00        nop     
35cd 0f        rrca    
35ce 200b      jr      nz,35dbh
35d0 00        nop     
35d1 00        nop     
35d2 00        nop     
35d3 00        nop     
35d4 7f        ld      a,a
35d5 50        ld      d,b
35d6 62        ld      h,d
35d7 0a        ld      a,(bc)
35d8 12        ld      (de),a
35d9 08        ex      af,af'
35da 12        ld      (de),a
35db 12        ld      (de),a
35dc 00        nop     
35dd 0f        rrca    
35de 200b      jr      nz,35ebh
35e0 00        nop     
35e1 00        nop     
35e2 00        nop     
35e3 00        nop     
35e4 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
35e5 02        ld      (bc),a
35e6 9f        sbc     a,a
35e7 05        dec     b
35e8 3f        ccf     
35e9 2831      jr      z,361ch
35eb 05        dec     b
35ec 180c      jr      35fah
35ee 1818      jr      3608h
35f0 00        nop     
35f1 0b        dec     bc
35f2 200b      jr      nz,35ffh
35f4 00        nop     
35f5 00        nop     
35f6 00        nop     
35f7 00        nop     
35f8 7f        ld      a,a
35f9 50        ld      d,b
35fa 62        ld      h,d
35fb 0a        ld      a,(bc)
35fc 180c      jr      360ah
35fe 1818      jr      3618h
3600 00        nop     
3601 0b        dec     bc
3602 200b      jr      nz,360fh
3604 00        nop     
3605 00        nop     
3606 00        nop     
3607 00        nop     
3608 bf        cp      a
3609 03        inc     bc
360a 7f        ld      a,a
360b 07        rlca    
360c e5        push    hl
360d 3a8afb    ld      a,(0fb8ah)
3610 cb47      bit     0,a
3612 c22816    jp      nz,1628h

3615 cd4315    call    1543h
3618 dd215500  ld      ix,0055h				; IX = {HI-RES Selection routine}
361c cd9a1d    call    1d9ah
361f cd4c14    call    144ch
3622 cd0f1d    call    1d0fh
3625 c3a014    jp      14a0h

3628 cd4b15    call    154bh
362b dd215200  ld      ix,0052h				; IX = {LO-RES Selection routine}
362f cd9a1d    call    1d9ah
3632 cd4c14    call    144ch
3635 cd0f1d    call    1d0fh
3638 c32615    jp      1526h

363b e5        push    hl
363c 3a8afb    ld      a,(0fb8ah)
363f cb47      bit     0,a
3641 c25316    jp      nz,1653h
3644 cd4b15    call    154bh
3647 cd4315    call    1543h
364a dd215500  ld      ix,0055h				; IX = {HI-RES Selection routine}
364e cd9a1d    call    1d9ah
3651 e1        pop     hl
3652 c9        ret

3653 cd4315    call    1543h
3656 cd4b15    call    154bh
3659 dd215200  ld      ix,0052h				; IX = {LO-RES Selection routine}
365d cd9a1d    call    1d9ah
3660 e1        pop     hl
3661 c9        ret

3662 7e        ld      a,(hl)
3663 fe23      cp      23h
3665 282d      jr      z,3694h
3667 cd961d    call    1d96h
366a c2f61c    jp      nz,1cf6h
366d b3        or      e
366e 281f      jr      z,368fh
3670 e5        push    hl
3671 010000    ld      bc,0000h
3674 21ff7f    ld      hl,7fffh
3677 b7        or      a
3678 ed52      sbc     hl,de
367a 3803      jr      c,367fh
367c 03        inc     bc
367d 18f9      jr      3678h
367f cd9f16    call    169fh
3682 e1        pop     hl
3683 c9        ret     
3684 3e36      ld      a,36h
3686 d323      out     (23h),a
3688 79        ld      a,c
3689 d320      out     (20h),a
368b 78        ld      a,b
368c d320      out     (20h),a
368e c9        ret     
368f 3e34      ld      a,34h
3691 d323      out     (23h),a
3693 c9        ret     
3694 cd5d0b    call    0b5dh
3697 cd961d    call    1d96h
369a e5        push    hl
369b d5        push    de
369c c1        pop     bc
369d 18e0      jr      367fh
369f d1        pop     de
36a0 e1        pop     hl
36a1 d5        push    de
36a2 c5        push    bc
36a3 2b        dec     hl
36a4 cd5d0b    call    0b5dh
36a7 fe2c      cp      ','
36a9 2808      jr      z,36b3h
36ab c1        pop     bc
36ac cd8416    call    1684h
36af d1        pop     de
36b0 e5        push    hl
36b1 d5        push    de
36b2 c9        ret     
36b3 23        inc     hl
36b4 cd961d    call    1d96h
36b7 c1        pop     bc
36b8 e5        push    hl
36b9 cd8416    call    1684h
36bc 1804      jr      36c2h
36be 1b        dec     de
36bf cdce16    call    16ceh
36c2 7a        ld      a,d
36c3 b3        or      e
36c4 20f8      jr      nz,36beh
36c6 cd8f16    call    168fh
36c9 e1        pop     hl
36ca d1        pop     de
36cb e5        push    hl
36cc d5        push    de
36cd c9        ret     
36ce c5        push    bc
36cf f5        push    af
36d0 010020    ld      bc,2000h
36d3 0b        dec     bc
36d4 78        ld      a,b
36d5 b1        or      c
36d6 20fb      jr      nz,36d3h
36d8 f1        pop     af
36d9 c1        pop     bc
36da c9        ret     
36db 3a8afb    ld      a,(0fb8ah)
36de cbd7      set     2,a
36e0 328afb    ld      (0fb8ah),a
36e3 2a75fb    ld      hl,(0fb75h)
36e6 ed5b77fb  ld      de,(0fb77h)
36ea 2277fb    ld      (0fb77h),hl
36ed ed5375fb  ld      (0fb75h),de
36f1 2a79fb    ld      hl,(0fb79h)
36f4 ed5b7bfb  ld      de,(0fb7bh)
36f8 ed5379fb  ld      (0fb79h),de
36fc 227bfb    ld      (0fb7bh),hl
36ff 1808      jr      3709h
3701 3a8afb    ld      a,(0fb8ah)
3704 cb97      res     2,a
3706 328afb    ld      (0fb8ah),a
3709 210100    ld      hl,0001h
370c 2287fb    ld      (0fb87h),hl
370f 2a75fb    ld      hl,(0fb75h)
3712 ed5b79fb  ld      de,(0fb79h)
3716 b7        or      a
3717 ed52      sbc     hl,de
3719 fa2217    jp      m,1722h
371c 21ffff    ld      hl,0ffffh
371f 2287fb    ld      (0fb87h),hl
3722 2a75fb    ld      hl,(0fb75h)
3725 ed5b77fb  ld      de,(0fb77h)
3729 ed53affb  ld      (0fbafh),de
372d 22adfb    ld      (0fbadh),hl
3730 3a8afb    ld      a,(0fb8ah)
3733 cb57      bit     2,a
3735 280e      jr      z,3745h
3737 2aadfb    ld      hl,(0fbadh)
373a ed5baffb  ld      de,(0fbafh)
373e 22affb    ld      (0fbafh),hl
3741 ed53adfb  ld      (0fbadh),de
3745 cd5912    call    1259h
3748 3a8afb    ld      a,(0fb8ah)
374b cb57      bit     2,a
374d 280e      jr      z,375dh
374f 2aadfb    ld      hl,(0fbadh)
3752 ed5baffb  ld      de,(0fbafh)
3756 ed53adfb  ld      (0fbadh),de
375a 22affb    ld      (0fbafh),hl
375d 2aadfb    ld      hl,(0fbadh)
3760 ed5b79fb  ld      de,(0fb79h)
3764 b7        or      a
3765 cd4c0b    call    0b4ch
3768 c8        ret     z
3769 ed5b87fb  ld      de,(0fb87h)
376d 19        add     hl,de
376e 18bd      jr      372dh
3770 3a8afb    ld      a,(0fb8ah)
3773 cbcf      set     1,a
3775 328afb    ld      (0fb8ah),a
3778 cdc51c    call    1cc5h
377b 1808      jr      3785h
377d 3a8afb    ld      a,(0fb8ah)
3780 cb8f      res     1,a
3782 328afb    ld      (0fb8ah),a
3785 cd961d    call    1d96h
3788 d5        push    de
3789 cd520b    call    0b52h
378c 2c        inc     l
378d dd21103a  ld      ix,3a10h			; IX = {GETINT}
3791 cd9a1d    call    1d9ah
3794 5f        ld      e,a
3795 c1        pop     bc
3796 e5        push    hl
3797 c5        push    bc
3798 e1        pop     hl
3799 3a8afb    ld      a,(0fb8ah)
379c cb4f      bit     1,a
379e c40f1d    call    nz,1d0fh
37a1 43        ld      b,e
37a2 db50      in      a,(50h)        ; get system status
37a4 e610      and     10h
37a6 28fa      jr      z,37a2h        ; wait for CSYNC - Composite video sync.signal 
37a8 78        ld      a,b
37a9 77        ld      (hl),a
37aa 23        inc     hl
37ab 3a8afb    ld      a,(0fb8ah)
37ae cb4f      bit     1,a
37b0 c41b1d    call    nz,1d1bh
37b3 eb        ex      de,hl
37b4 e1        pop     hl
37b5 7e        ld      a,(hl)
37b6 fe20      cp      20h
37b8 2003      jr      nz,37bdh
37ba 23        inc     hl
37bb 18f8      jr      37b5h
37bd fe2c      cp      ','
37bf 2008      jr      nz,37c9h
37c1 cdc51c    call    1cc5h
37c4 d5        push    de
37c5 23        inc     hl
37c6 c38d17    jp      178dh
37c9 c9        ret     
37ca cd520b    call    0b52h
37cd 41        ld      b,c
37ce cd520b    call    0b52h
37d1 d8        ret     c
37d2 cd580e    call    0e58h
37d5 ed5badfb  ld      de,(0fbadh)
37d9 ed5363fb  ld      (0fb63h),de
37dd ed5baffb  ld      de,(0fbafh)
37e1 ed5365fb  ld      (0fb65h),de
37e5 af        xor     a
37e6 3289fb    ld      (0fb89h),a
37e9 e5        push    hl
37ea 21ffff    ld      hl,0ffffh
37ed 2267fb    ld      (0fb67h),hl
37f0 2a63fb    ld      hl,(0fb63h)
37f3 22adfb    ld      (0fbadh),hl
37f6 2a65fb    ld      hl,(0fb65h)
37f9 22affb    ld      (0fbafh),hl
37fc cd9518    call    1895h
37ff c29318    jp      nz,1893h
3802 2a63fb    ld      hl,(0fb63h)
3805 22adfb    ld      (0fbadh),hl
3808 228dfb    ld      (0fb8dh),hl
380b 2a65fb    ld      hl,(0fb65h)
380e 22affb    ld      (0fbafh),hl
3811 228ffb    ld      (0fb8fh),hl
3814 cd5912    call    1259h
3817 2aadfb    ld      hl,(0fbadh)
381a 23        inc     hl
381b 22adfb    ld      (0fbadh),hl
381e af        xor     a
381f cd9518    call    1895h
3822 28f0      jr      z,3814h
3824 2aadfb    ld      hl,(0fbadh)
3827 2293fb    ld      (0fb93h),hl
382a 2a8dfb    ld      hl,(0fb8dh)
382d 2b        dec     hl
382e 22adfb    ld      (0fbadh),hl
3831 af        xor     a
3832 cd9518    call    1895h
3835 2010      jr      nz,3847h
3837 cd5912    call    1259h
383a 2aadfb    ld      hl,(0fbadh)
383d 2b        dec     hl
383e 22adfb    ld      (0fbadh),hl
3841 af        xor     a
3842 cd9518    call    1895h
3845 28f0      jr      z,3837h
3847 2aadfb    ld      hl,(0fbadh)
384a 2291fb    ld      (0fb91h),hl
384d ed5b93fb  ld      de,(0fb93h)
3851 19        add     hl,de
3852 cb3c      srl     h
3854 cb1d      rr      l
3856 228dfb    ld      (0fb8dh),hl
3859 22adfb    ld      (0fbadh),hl
385c 2a67fb    ld      hl,(0fb67h)
385f ed5b8ffb  ld      de,(0fb8fh)
3863 19        add     hl,de
3864 228ffb    ld      (0fb8fh),hl
3867 22affb    ld      (0fbafh),hl
386a af        xor     a
386b cd9518    call    1895h
386e 28a4      jr      z,3814h
3870 2a67fb    ld      hl,(0fb67h)
3873 cb7c      bit     7,h
3875 ca9318    jp      z,1893h
3878 210100    ld      hl,0001h
387b 2267fb    ld      (0fb67h),hl
387e 2a63fb    ld      hl,(0fb63h)
3881 22adfb    ld      (0fbadh),hl
3884 228dfb    ld      (0fb8dh),hl
3887 2a65fb    ld      hl,(0fb65h)
388a 23        inc     hl
388b 228ffb    ld      (0fb8fh),hl
388e 22affb    ld      (0fbafh),hl
3891 1881      jr      3814h
3893 e1        pop     hl
3894 c9        ret     
3895 cda618    call    18a6h
3898 c0        ret     nz
3899 cdc813    call    13c8h
389c a0        and     b
389d f5        push    af
389e db50      in      a,(50h)        ; get system status
38a0 cb87      res     0,a
38a2 d370      out     (70h),a        ; Set system status
38a4 f1        pop     af
38a5 c9        ret     
38a6 2aadfb    ld      hl,(0fbadh)
38a9 cb7c      bit     7,h
38ab c0        ret     nz
38ac ed5b85fb  ld      de,(0fb85h)
38b0 b7        or      a
38b1 ed52      sbc     hl,de
38b3 f2c718    jp      p,18c7h
38b6 2aaffb    ld      hl,(0fbafh)
38b9 cb7c      bit     7,h
38bb c0        ret     nz
38bc 112001    ld      de,0120h
38bf b7        or      a
38c0 ed52      sbc     hl,de
38c2 f2c718    jp      p,18c7h
38c5 af        xor     a
38c6 c9        ret     
38c7 3eff      ld      a,0ffh
38c9 a7        and     a
38ca c9        ret

; GETSTR
38cb e5        push    hl
38cc cd4c14    call    144ch
38cf 210040    ld      hl,4000h
38d2 01ff5f    ld      bc,5fffh
38d5 cd0f1d    call    1d0fh
38d8 7e        ld      a,(hl)
38d9 eeff      xor     0ffh
38db 77        ld      (hl),a
38dc 23        inc     hl
38dd 0b        dec     bc
38de 78        ld      a,b
38df b1        or      c
38e0 20f6      jr      nz,38d8h
38e2 cd1b1d    call    1d1bh
38e5 cd5414    call    1454h
38e8 e1        pop     hl
38e9 c9        ret

38ea 1180d8    ld      de,0d880h
38ed 0e14      ld      c,14h
38ef cdf318    call    18f3h
38f2 c9        ret

38f3 d5        push    de
38f4 e5        push    hl
38f5 c5        push    bc
38f6 dd214d15  ld      ix,154dh
38fa cd9a1d    call    1d9ah
38fd c1        pop     bc
38fe e1        pop     hl
38ff d1        pop     de
3900 c9        ret

3901 0e1a      ld      c,1ah
3903 1100d8    ld      de,0d800h
3906 cdf318    call    18f3h
3909 c9        ret     
390a ed5351fb  ld      (0fb51h),de
390e e5        push    hl
390f 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
3912 224efb    ld      (0fb4eh),hl
3915 e1        pop     hl
3916 dd212b32  ld      ix,322bh            ; IX = {EVAL}
391a cd9a1d    call    1d9ah
391d e5        push    hl
391e 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
3921 fe03      cp      03h
3923 c2fb1c    jp      nz,1cfbh
3926 2141fe    ld      hl,0fe41h        ; FACCU
3929 5e        ld      e,(hl)
392a 23        inc     hl
392b 56        ld      d,(hl)
392c eb        ex      de,hl
392d 7e        ld      a,(hl)
392e a7        and     a
392f ca001d    jp      z,1d00h
3932 4f        ld      c,a
3933 23        inc     hl
3934 5e        ld      e,(hl)
3935 23        inc     hl
3936 56        ld      d,(hl)
3937 eb        ex      de,hl
3938 11e2ff    ld      de,0ffe2h
393b 0600      ld      b,00h
393d edb0      ldir    
393f 3e22      ld      a,22h
3941 32e1ff    ld      (0ffe1h),a
3944 12        ld      (de),a
3945 ed5b51fb  ld      de,(0fb51h)
3949 21e1ff    ld      hl,0ffe1h
394c dd21ea11  ld      ix,11eah
3950 cd9a1d    call    1d9ah
3953 2a4efb    ld      hl,(0fb4eh)
3956 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
3959 e1        pop     hl
395a c9        ret     
395b 7e        ld      a,(hl)
395c fe48      cp      48h
395e ca7f19    jp      z,197fh
3961 fe4d      cp      4dh
3963 dd214a13  ld      ix,134ah
3967 ca9a1d    jp      z,1d9ah
396a c38d1a    jp      1a8dh
396d 7e        ld      a,(hl)
396e fe48      cp      48h
3970 cabc19    jp      z,19bch
3973 fe41      cp      41h
3975 ca9f1b    jp      z,1b9fh
3978 dd21a112  ld      ix,12a1h
397c c39a1d    jp      1d9ah
397f 23        inc     hl
3980 cdc51c    call    1cc5h
3983 1180d8    ld      de,0d880h
3986 cd0a19    call    190ah
3989 e5        push    hl
398a cd0119    call    1901h
398d 1180d8    ld      de,0d880h
3990 0e0f      ld      c,0fh
3992 cd2d1a    call    1a2dh
3995 210040    ld      hl,4000h
3998 225bfb    ld      (0fb5bh),hl
399b 2a5bfb    ld      hl,(0fb5bh)
399e 11ff9e    ld      de,9effh
39a1 cd4c0b    call    0b4ch
39a4 d2541a    jp      nc,1a54h
39a7 cdea18    call    18eah
39aa b7        or      a
39ab c2001d    jp      nz,1d00h
39ae 2a5bfb    ld      hl,(0fb5bh)
39b1 0680      ld      b,80h
39b3 1100d8    ld      de,0d800h
39b6 cd091a    call    1a09h
39b9 c39b19    jp      199bh
39bc 23        inc     hl
39bd cdc51c    call    1cc5h
39c0 1180d8    ld      de,0d880h
39c3 cd0a19    call    190ah
39c6 e5        push    hl
39c7 cd0119    call    1901h
39ca cd1f1a    call    1a1fh
39cd cd281a    call    1a28h
39d0 210040    ld      hl,4000h
39d3 225bfb    ld      (0fb5bh),hl
39d6 2a5bfb    ld      hl,(0fb5bh)
39d9 11ff9e    ld      de,9effh
39dc cd4c0b    call    0b4ch
39df d2451a    jp      nc,1a45h
39e2 2a5bfb    ld      hl,(0fb5bh)
39e5 0680      ld      b,80h
39e7 1100d8    ld      de,0d800h
39ea cdf619    call    19f6h
39ed 225bfb    ld      (0fb5bh),hl
39f0 cd351a    call    1a35h
39f3 c3d619    jp      19d6h


; GETINT/EVAL
39f6 cd0f1d    call    1d0fh
39f9 db50      in      a,(50h)        ; get system status
39fb e610      and     10h
39fd 28fa      jr      z,39f9h        ; wait for CSYNC - Composite video sync.signal 
39ff 7e        ld      a,(hl)
3a00 23        inc     hl
3a01 12        ld      (de),a
3a02 13        inc     de
3a03 cd1b1d    call    1d1bh
3a06 10ee      djnz    39f6h        ; GETINT/EVAL
3a08 c9        ret

3a09 cd0f1d    call    1d0fh
3a0c db50      in      a,(50h)        ; get system status
3a0e e610      and     10h

; GETINT
3a10 28fa      jr      z,3a0ch        ; wait for CSYNC - Composite video sync.signal 
3a12 1a        ld      a,(de)
3a13 13        inc     de
3a14 77        ld      (hl),a
3a15 23        inc     hl
3a16 cd1b1d    call    1d1bh
3a19 10ee      djnz    3a09h
3a1b 225bfb    ld      (0fb5bh),hl
3a1e c9        ret     
3a1f 1180d8    ld      de,0d880h
3a22 0e13      ld      c,13h
3a24 cdf318    call    18f3h
3a27 c9        ret     
3a28 1180d8    ld      de,0d880h
3a2b 0e16      ld      c,16h
3a2d cdf318    call    18f3h
3a30 3c        inc     a
3a31 ca001d    jp      z,1d00h
3a34 c9        ret     
3a35 1180d8    ld      de,0d880h
3a38 0e15      ld      c,15h
3a3a cdf318    call    18f3h
3a3d 3c        inc     a
3a3e c0        ret     nz
3a3f cd451a    call    1a45h
3a42 c3001d    jp      1d00h
3a45 1180d8    ld      de,0d880h
3a48 0e10      ld      c,10h
3a4a cdf318    call    18f3h
3a4d 3c        inc     a
3a4e c2541a    jp      nz,1a54h
3a51 c3001d    jp      1d00h
3a54 e1        pop     hl
3a55 c9        ret

3a56 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
3a59 3600      ld      (hl),00h
3a5b 23        inc     hl
3a5c 3600      ld      (hl),00h
3a5e 23        inc     hl
3a5f 3600      ld      (hl),00h
3a61 23        inc     hl
3a62 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
3a65 c9        ret

3a66 2100d8    ld      hl,0d800h

    ; Print message, text ptr in (HL)
3a69 5e        ld      e,(hl)
3a6a 23        inc     hl
3a6b 56        ld      d,(hl)
3a6c 213a39    ld      hl,393ah
3a6f cd4c0b    call    0b4ch
3a72 d0        ret     nc
3a73 e1        pop     hl
3a74 2ab1fb    ld      hl,(0fbb1h)
3a77 dd214a13  ld      ix,134ah
3a7b c39a1d    jp      1d9ah
3a7e 22b1fb    ld      (0fbb1h),hl
3a81 3a8afb    ld      a,(0fb8ah)
3a84 cb9f      res     3,a
3a86 328afb    ld      (0fb8ah),a
3a89 af        xor     a
3a8a 3c        inc     a
3a8b 180c      jr      3a99h
3a8d 22b1fb    ld      (0fbb1h),hl
3a90 3a8afb    ld      a,(0fb8ah)
3a93 cb9f      res     3,a
3a95 328afb    ld      (0fb8ah),a
3a98 af        xor     a
3a99 3d        dec     a
3a9a 328cfb    ld      (0fb8ch),a
3a9d 1180d8    ld      de,0d880h
3aa0 cd0a19    call    190ah
3aa3 e5        push    hl
3aa4 cd0119    call    1901h
3aa7 cdfb1a    call    1afbh
3aaa 3c        inc     a
3aab ca741a    jp      z,1a74h
3aae 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
3ab1 226bfb    ld      (0fb6bh),hl
3ab4 cdf21a    call    1af2h
3ab7 b7        or      a
3ab8 c2001d    jp      nz,1d00h
3abb 3a8afb    ld      a,(0fb8ah)
3abe cb5f      bit     3,a
3ac0 cc661a    call    z,1a66h
3ac3 3a8afb    ld      a,(0fb8ah)
3ac6 cbdf      set     3,a
3ac8 328afb    ld      (0fb8ah),a
3acb 3a8cfb    ld      a,(0fb8ch)
3ace a7        and     a
3acf c4561a    call    nz,1a56h
3ad2 af        xor     a
3ad3 328cfb    ld      (0fb8ch),a
3ad6 cdc51c    call    1cc5h
3ad9 2100d8    ld      hl,0d800h
3adc 0680      ld      b,80h
3ade 7e        ld      a,(hl)
3adf fe1a      cp      1ah
3ae1 c2e71a    jp      nz,1ae7h
3ae4 c3bb1c    jp      1cbbh
3ae7 c3041b    jp      1b04h
3aea 23        inc     hl
3aeb 05        dec     b
3aec c2de1a    jp      nz,1adeh
3aef c3b41a    jp      1ab4h
3af2 1180d8    ld      de,0d880h
3af5 0e14      ld      c,14h
3af7 cdf318    call    18f3h
3afa c9        ret     
3afb 1180d8    ld      de,0d880h
3afe 0e0f      ld      c,0fh
3b00 cdf318    call    18f3h
3b03 c9        ret     
3b04 2267fb    ld      (0fb67h),hl
3b07 60        ld      h,b
3b08 69        ld      l,c
3b09 2269fb    ld      (0fb69h),hl
3b0c d5        push    de
3b0d 2a6bfb    ld      hl,(0fb6bh)
3b10 fe0a      cp      0ah
3b12 2814      jr      z,3b28h
3b14 fe0d      cp      0dh
3b16 200b      jr      nz,3b23h
3b18 af        xor     a
3b19 77        ld      (hl),a
3b1a 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
3b1d 2b        dec     hl
3b1e c3341b    jp      1b34h
3b21 1805      jr      3b28h
3b23 77        ld      (hl),a
3b24 23        inc     hl
3b25 226bfb    ld      (0fb6bh),hl
3b28 d1        pop     de
3b29 2a69fb    ld      hl,(0fb69h)
3b2c 44        ld      b,h
3b2d 4d        ld      c,l
3b2e 2a67fb    ld      hl,(0fb67h)
3b31 c3ea1a    jp      1aeah
3b34 2259fb    ld      (0fb59h),hl
3b37 3ec3      ld      a,0c3h
3b39 32b7fe    ld      (0feb7h),a
3b3c 219c3f    ld      hl,3f9ch
3b3f 22b8fe    ld      (0feb8h),hl
3b42 2a59fb    ld      hl,(0fb59h)
3b45 23        inc     hl
3b46 7e        ld      a,(hl)
3b47 2b        dec     hl
3b48 f5        push    af
3b49 e6f0      and     0f0h
3b4b fe30      cp      30h
3b4d c26d1b    jp      nz,1b6dh
3b50 f1        pop     af
3b51 fe3a      cp      3ah
3b53 d26d1b    jp      nc,1b6dh
3b56 dd216b29  ld      ix,296bh
3b5a dde5      push    ix
3b5c c38a3f    jp      3f8ah
3b5f 3ec9      ld      a,0c9h
3b61 32b7fe    ld      (0feb7h),a
3b64 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
3b67 226bfb    ld      (0fb6bh),hl
3b6a c3211b    jp      1b21h
3b6d 3ec9      ld      a,0c9h
3b6f 32b7fe    ld      (0feb7h),a
3b72 21a33b    ld      hl,3ba3h
3b75 dd219b37  ld      ix,379bh			; IX= {Output a string}
3b79 cd9a1d    call    1d9ah
3b7c dd210329  ld      ix,2903h
3b80 dde5      push    ix
3b82 c38a3f    jp      3f8ah
3b85 44        ld      b,h
3b86 49        ld      c,c
3b87 52        ld      d,d
3b88 45        ld      b,l
3b89 43        ld      b,e
3b8a 54        ld      d,h
3b8b 2053      jr      nz,3be0h
3b8d 54        ld      d,h
3b8e 41        ld      b,c
3b8f 54        ld      d,h
3b90 45        ld      b,l
3b91 4d        ld      c,l
3b92 45        ld      b,l
3b93 4e        ld      c,(hl)
3b94 54        ld      d,h
3b95 2049      jr      nz,3be0h
3b97 4e        ld      c,(hl)
3b98 2046      jr      nz,3be0h
3b9a 49        ld      c,c
3b9b 4c        ld      c,h
3b9c 45        ld      b,l
3b9d 0d        dec     c
3b9e 00        nop     
3b9f 23        inc     hl
3ba0 cdc51c    call    1cc5h
3ba3 1180d8    ld      de,0d880h
3ba6 cd0a19    call    190ah
3ba9 e5        push    hl
3baa 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
3bad 7e        ld      a,(hl)
3bae a7        and     a
3baf c2b81b    jp      nz,1bb8h
3bb2 23        inc     hl
3bb3 7e        ld      a,(hl)
3bb4 a7        and     a
3bb5 ca001d    jp      z,1d00h
3bb8 cd0119    call    1901h
3bbb cdc41b    call    1bc4h
3bbe 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
3bc1 c3e51b    jp      1be5h
3bc4 2100d8    ld      hl,0d800h
3bc7 2263fb    ld      (0fb63h),hl
3bca 0680      ld      b,80h
3bcc ed4365fb  ld      (0fb65h),bc
3bd0 1180d8    ld      de,0d880h
3bd3 0e13      ld      c,13h
3bd5 cdf318    call    18f3h
3bd8 1180d8    ld      de,0d880h
3bdb 0e16      ld      c,16h
3bdd cdf318    call    18f3h
3be0 3c        inc     a
3be1 ca001d    jp      z,1d00h
3be4 c9        ret     
3be5 2253fb    ld      (0fb53h),hl
3be8 2a53fb    ld      hl,(0fb53h)
3beb 7e        ld      a,(hl)
3bec 23        inc     hl
3bed 46        ld      b,(hl)
3bee b0        or      b
3bef ca5b1c    jp      z,1c5bh
3bf2 23        inc     hl
3bf3 5e        ld      e,(hl)
3bf4 23        inc     hl
3bf5 56        ld      d,(hl)
3bf6 21e1ff    ld      hl,0ffe1h
3bf9 ed5341fe  ld      (0fe41h),de        ; FACCU
3bfd 3e02      ld      a,02h
3bff 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
3c02 010000    ld      bc,0000h
3c05 dd219921  ld      ix,2199h
3c09 cd9a1d    call    1d9ah
3c0c 21e1ff    ld      hl,0ffe1h
3c0f 7e        ld      a,(hl)
3c10 fe00      cp      00h
3c12 2808      jr      z,3c1ch
3c14 e5        push    hl
3c15 cd5f1c    call    1c5fh
3c18 e1        pop     hl
3c19 23        inc     hl
3c1a 18f3      jr      3c0fh
3c1c 2a53fb    ld      hl,(0fb53h)
3c1f 3e20      ld      a,20h
3c21 cd5f1c    call    1c5fh
3c24 2a53fb    ld      hl,(0fb53h)
3c27 23        inc     hl
3c28 23        inc     hl
3c29 23        inc     hl
3c2a 23        inc     hl
3c2b dd21723a  ld      ix,3a72h
3c2f cd9a1d    call    1d9ah
3c32 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
3c35 7e        ld      a,(hl)
3c36 fe00      cp      00h
3c38 2807      jr      z,3c41h
3c3a cd5f1c    call    1c5fh
3c3d 23        inc     hl
3c3e c3351c    jp      1c35h
3c41 3e0d      ld      a,0dh
3c43 cd5f1c    call    1c5fh
3c46 3e0a      ld      a,0ah
3c48 cd5f1c    call    1c5fh
3c4b 2a53fb    ld      hl,(0fb53h)
3c4e 4e        ld      c,(hl)
3c4f 23        inc     hl
3c50 46        ld      b,(hl)
3c51 c5        push    bc
3c52 e1        pop     hl
3c53 2253fb    ld      (0fb53h),hl
3c56 7c        ld      a,h
3c57 b5        or      l
3c58 c2e81b    jp      nz,1be8h
3c5b 3e1a      ld      a,1ah
3c5d 1800      jr      3c5fh
3c5f e5        push    hl
3c60 d5        push    de
3c61 c5        push    bc
3c62 2a63fb    ld      hl,(0fb63h)
3c65 ed4b65fb  ld      bc,(0fb65h)
3c69 fe1a      cp      1ah
3c6b 200b      jr      nz,3c78h
3c6d 77        ld      (hl),a
3c6e 1180d8    ld      de,0d880h
3c71 0e15      ld      c,15h
3c73 cdf318    call    18f3h
3c76 1834      jr      3cach
3c78 77        ld      (hl),a
3c79 05        dec     b
3c7a 280a      jr      z,3c86h
3c7c ed4365fb  ld      (0fb65h),bc
3c80 23        inc     hl
3c81 2263fb    ld      (0fb63h),hl
3c84 1822      jr      3ca8h
3c86 e5        push    hl
3c87 c5        push    bc
3c88 1180d8    ld      de,0d880h
3c8b 0e15      ld      c,15h
3c8d cdf318    call    18f3h
3c90 c1        pop     bc
3c91 e1        pop     hl
3c92 b7        or      a
3c93 ca9c1c    jp      z,1c9ch
3c96 cdac1c    call    1cach
3c99 c3001d    jp      1d00h
3c9c 0680      ld      b,80h
3c9e 2100d8    ld      hl,0d800h
3ca1 ed4365fb  ld      (0fb65h),bc
3ca5 2263fb    ld      (0fb63h),hl
3ca8 c1        pop     bc
3ca9 d1        pop     de
3caa e1        pop     hl
3cab c9        ret     
3cac 1180d8    ld      de,0d880h
3caf 0e10      ld      c,10h
3cb1 cdf318    call    18f3h
3cb4 3c        inc     a
3cb5 c2bb1c    jp      nz,1cbbh
3cb8 c3bb1c    jp      1cbbh
3cbb e1        pop     hl
3cbc dd210329  ld      ix,2903h
3cc0 dde5      push    ix
3cc2 c38a3f    jp      3f8ah
3cc5 e5        push    hl
3cc6 f5        push    af
3cc7 c5        push    bc
3cc8 269f      ld      h,9fh
3cca 3ef0      ld      a,0f0h
3ccc ee0f      xor     0fh
3cce 6f        ld      l,a
3ccf e5        push    hl
3cd0 21c51c    ld      hl,1cc5h
3cd3 3ee5      ld      a,0e5h
3cd5 ae        xor     (hl)
3cd6 c2ef1c    jp      nz,1cefh
3cd9 e1        pop     hl
3cda cd0f1d    call    1d0fh
3cdd db50      in      a,(50h)        ; get system status
3cdf e610      and     10h
3ce1 28fa      jr      z,3cddh        ; wait for CSYNC - Composite video sync.signal 
3ce3 7e        ld      a,(hl)
3ce4 3c        inc     a
3ce5 3c        inc     a
3ce6 2007      jr      nz,3cefh
3ce8 cd1b1d    call    1d1bh
3ceb c1        pop     bc
3cec f1        pop     af
3ced e1        pop     hl
3cee c9        ret

3cef cd1b1d    call    1d1bh
3cf2 c3f61c    jp      1cf6h

3cf5 c9        ret     
3cf6 1e02      ld      e,02h
3cf8 c3023f    jp      3f02h
3cfb 1e18      ld      e,18h
3cfd c3023f    jp      3f02h
3d00 1e08      ld      e,08h
3d02 c3023f    jp      3f02h
3d05 1e0e      ld      e,0eh
3d07 c3023f    jp      3f02h
3d0a 1e0c      ld      e,0ch
3d0c c3023f    jp      3f02h
3d0f db50      in      a,(50h)        ; get system status
3d11 328bfb    ld      (0fb8bh),a
3d14 cbc7      set     0,a
3d16 cb8f      res     1,a
3d18 d370      out     (70h),a        ; Set system status
3d1a c9        ret     
3d1b 3a8bfb    ld      a,(0fb8bh)
3d1e d370      out     (70h),a        ; Set system status
3d20 c9        ret     
3d21 dd21452d  ld      ix,2d45h            ; IX= {LNUM_PARM_0 - Get specified line number (2nd parameter)}
3d25 c39a1d    jp      1d9ah
3d28 dd210419  ld      ix,1904h
3d2c c39a1d    jp      1d9ah
3d2f dd21e229  ld      ix,29e2h
3d33 c39a1d    jp      1d9ah
3d36 dd212034  ld      ix,3420h
3d3a 185e      jr      3d9ah
3d3c dd213518  ld      ix,1835h
3d40 1858      jr      3d9ah
3d42 dd211b18  ld      ix,181bh            ; IX = {Move a SP value -> HL to WRA1}
3d46 1852      jr      3d9ah
3d48 dd212c18  ld      ix,182ch            ; IX= {Load SP value -> into BC/DE}
3d4c 184c      jr      3d9ah
3d4e dd21b116  ld      ix,16b1h
3d52 1846      jr      3d9ah
3d54 dd210c17  ld      ix,170ch
3d58 1840      jr      3d9ah
3d5a dd212b32  ld      ix,322bh            ; IX = {EVAL}
3d5e 183a      jr      3d9ah
3d60 dd215e19  ld      ix,195eh
3d64 1834      jr      3d9ah
3d66 dd210135  ld      ix,3501h            ; IX= {GETVAR: Find address of variable}
3d6a 182e      jr      3d9ah
3d6c dd21e918  ld      ix,18e9h            ; IX= {GETWORD_HL: Floating point to Integer}
3d70 1828      jr      3d9ah
3d72 dd211b19  ld      ix,191bh            ; IX= {Integer to single precision}
3d76 1822      jr      3d9ah
3d78 dd21f43f  ld      ix,3ff4h
3d7c 181c      jr      3d9ah
3d7e dd21ea3f  ld      ix,3feah
3d82 1816      jr      3d9ah
3d84 dd21f83f  ld      ix,3ff8h
3d88 1810      jr      3d9ah
3d8a dd21f23f  ld      ix,3ff2h
3d8e 180a      jr      3d9ah
3d90 dd215910  ld      ix,1059h
3d94 1804      jr      3d9ah
3d96 dd21f639  ld      ix,39f6h        ; GETINT/EVAL

3d9a dde5      push    ix
3d9c c3803f    jp      3f80h

3d9f cd0f1d    call    1d0fh
3da2 db50      in      a,(50h)        ; get system status
3da4 e610      and     10h
3da6 28fa      jr      z,3da2h        ; wait for CSYNC - Composite video sync.signal 
3da8 3efe      ld      a,0feh
3daa 00        nop     
3dab 3c        inc     a
3dac 3c        inc     a
3dad f5        push    af
3dae cd1b1d    call    1d1bh
3db1 f1        pop     af
3db2 c9        ret     
3db3 dbf1      in      a,(0f1h)
3db5 2f        cpl     
3db6 d3f1      out     (0f1h),a
3db8 4f        ld      c,a
3db9 af        xor     a
3dba 3d        dec     a
3dbb 20fd      jr      nz,3dbah
3dbd dbf1      in      a,(0f1h)
3dbf b9        cp      c
3dc0 c24f1e    jp      nz,1e4fh
3dc3 cd9f1d    call    1d9fh
3dc6 00        nop     
3dc7 c34f1e    jp      1e4fh
3dca 50        ld      d,b
3dcb fb        ei      
3dcc cd7a1e    call    1e7ah
3dcf cd831e    call    1e83h
3dd2 cd881e    call    1e88h
3dd5 af        xor     a
3dd6 d3f0      out     (0f0h),a
3dd8 cd831e    call    1e83h
3ddb cd831e    call    1e83h
3dde cd881e    call    1e88h
3de1 110200    ld      de,0002h
3de4 cdec1d    call    1dech
3de7 1812      jr      3dfbh
3de9 110a00    ld      de,000ah
3dec 010000    ld      bc,0000h
3def 0b        dec     bc
3df0 78        ld      a,b
3df1 b1        or      c
3df2 20fb      jr      nz,3defh
3df4 1b        dec     de
3df5 7b        ld      a,e
3df6 b2        or      d
3df7 20f6      jr      nz,3defh
3df9 c9        ret     
3dfa a7        and     a
3dfb 00        nop     
3dfc 00        nop     
3dfd 3e83      ld      a,83h
3dff d3e0      out     (0e0h),a
3e01 3afa1d    ld      a,(1dfah)
3e04 eeff      xor     0ffh
3e06 d3f2      out     (0f2h),a
3e08 af        xor     a
3e09 d3f1      out     (0f1h),a
3e0b 3e8c      ld      a,8ch
3e0d d3f0      out     (0f0h),a
3e0f 0ef3      ld      c,0f3h
3e11 cd831e    call    1e83h
3e14 cd831e    call    1e83h
3e17 dbf0      in      a,(0f0h)
3e19 cb4f      bit     1,a
3e1b 2018      jr      nz,3e35h
3e1d dbf0      in      a,(0f0h)
3e1f cb4f      bit     1,a
3e21 2012      jr      nz,3e35h
3e23 dbf0      in      a,(0f0h)
3e25 cb4f      bit     1,a
3e27 200c      jr      nz,3e35h
3e29 cb47      bit     0,a
3e2b 280d      jr      z,3e3ah
3e2d dbf0      in      a,(0f0h)
3e2f cb4f      bit     1,a
3e31 2002      jr      nz,3e35h
3e33 18e2      jr      3e17h
3e35 ed78      in      a,(c)
3e37 c3171e    jp      1e17h
3e3a e61c      and     1ch
3e3c 200d      jr      nz,3e4bh
3e3e 3a50fb    ld      a,(0fb50h)
3e41 3d        dec     a
3e42 ca951e    jp      z,1e95h
3e45 3250fb    ld      (0fb50h),a
3e48 c3fd1d    jp      1dfdh
3e4b cb5f      bit     3,a
3e4d 28ef      jr      z,3e3eh
3e4f 3ec9      ld      a,0c9h
3e51 3293fe    ld      (0fe93h),a
3e54 af        xor     a
3e55 214dfb    ld      hl,0fb4dh		; force the range fb4dh..fbbdh to zero
3e58 77        ld      (hl),a
3e59 114efb    ld      de,0fb4eh
3e5c 017000    ld      bc,0070h
3e5f edb0      ldir    
3e61 3a8afb    ld      a,(0fb8ah)
3e64 cbc7      set     0,a
3e66 328afb    ld      (0fb8ah),a
3e69 cd0f1d    call    1d0fh
3e6c 3eff      ld      a,0ffh
3e6e f5        push    af
3e6f 6f        ld      l,a
3e70 d660      sub     60h
3e72 67        ld      h,a
3e73 f1        pop     af
3e74 3d        dec     a
3e75 77        ld      (hl),a
3e76 cd1b1d    call    1d1bh
3e79 c9        ret     
3e7a 3e01      ld      a,01h
3e7c d3e4      out     (0e4h),a
3e7e cbef      set     5,a
3e80 d3e4      out     (0e4h),a
3e82 c9        ret     
3e83 e3        ex      (sp),hl
3e84 e3        ex      (sp),hl
3e85 e3        ex      (sp),hl
3e86 e3        ex      (sp),hl
3e87 c9        ret     
3e88 dbf0      in      a,(0f0h)
3e8a cb47      bit     0,a
3e8c 20fa      jr      nz,3e88h
3e8e dbf0      in      a,(0f0h)
3e90 cb47      bit     0,a
3e92 20f4      jr      nz,3e88h
3e94 c9        ret     
3e95 cd0f1d    call    1d0fh
3e98 21ff0f    ld      hl,0fffh
3e9b 3e9f      ld      a,9fh
3e9d 67        ld      h,a
3e9e 18d5      jr      3e75h
3ea0 ff        rst     38h
3ea1 ff        rst     38h
3ea2 ff        rst     38h
3ea3 ff        rst     38h
3ea4 ff        rst     38h
3ea5 ff        rst     38h
3ea6 ff        rst     38h
3ea7 ff        rst     38h
3ea8 ff        rst     38h
3ea9 ff        rst     38h
3eaa ff        rst     38h
3eab ff        rst     38h
3eac ff        rst     38h
3ead ff        rst     38h
3eae ff        rst     38h
3eaf ff        rst     38h
3eb0 ff        rst     38h
3eb1 ff        rst     38h
3eb2 ff        rst     38h
3eb3 ff        rst     38h
3eb4 ff        rst     38h
3eb5 ff        rst     38h
3eb6 ff        rst     38h
3eb7 ff        rst     38h
3eb8 ff        rst     38h
3eb9 ff        rst     38h
3eba ff        rst     38h
3ebb ff        rst     38h
3ebc ff        rst     38h
3ebd ff        rst     38h
3ebe ff        rst     38h
3ebf ff        rst     38h
3ec0 ff        rst     38h
3ec1 ff        rst     38h
3ec2 ff        rst     38h
3ec3 ff        rst     38h
3ec4 ff        rst     38h
3ec5 ff        rst     38h
3ec6 ff        rst     38h
3ec7 ff        rst     38h
3ec8 ff        rst     38h
3ec9 ff        rst     38h
3eca ff        rst     38h
3ecb ff        rst     38h
3ecc ff        rst     38h
3ecd ff        rst     38h
3ece ff        rst     38h
3ecf ff        rst     38h
3ed0 ff        rst     38h
3ed1 ff        rst     38h
3ed2 ff        rst     38h
3ed3 ff        rst     38h
3ed4 ff        rst     38h
3ed5 ff        rst     38h
3ed6 ff        rst     38h
3ed7 ff        rst     38h
3ed8 ff        rst     38h
3ed9 ff        rst     38h
3eda ff        rst     38h
3edb ff        rst     38h
3edc ff        rst     38h
3edd ff        rst     38h
3ede ff        rst     38h
3edf ff        rst     38h
3ee0 ff        rst     38h
3ee1 ff        rst     38h
3ee2 ff        rst     38h
3ee3 ff        rst     38h
3ee4 ff        rst     38h
3ee5 ff        rst     38h
3ee6 ff        rst     38h
3ee7 ff        rst     38h
3ee8 ff        rst     38h
3ee9 ff        rst     38h
3eea ff        rst     38h
3eeb ff        rst     38h
3eec ff        rst     38h
3eed ff        rst     38h
3eee ff        rst     38h
3eef ff        rst     38h
3ef0 ff        rst     38h
3ef1 ff        rst     38h
3ef2 ff        rst     38h
3ef3 ff        rst     38h
3ef4 ff        rst     38h
3ef5 ff        rst     38h
3ef6 ff        rst     38h
3ef7 ff        rst     38h
3ef8 ff        rst     38h
3ef9 ff        rst     38h
3efa ff        rst     38h
3efb ff        rst     38h
3efc ff        rst     38h
3efd ff        rst     38h
3efe ff        rst     38h
3eff ff        rst     38h
3f00 ff        rst     38h
3f01 ff        rst     38h
3f02 ff        rst     38h
3f03 ff        rst     38h
3f04 ff        rst     38h
3f05 ff        rst     38h
3f06 ff        rst     38h
3f07 ff        rst     38h
3f08 ff        rst     38h
3f09 ff        rst     38h
3f0a ff        rst     38h
3f0b ff        rst     38h
3f0c ff        rst     38h
3f0d ff        rst     38h
3f0e ff        rst     38h
3f0f ff        rst     38h
3f10 ff        rst     38h
3f11 ff        rst     38h
3f12 ff        rst     38h
3f13 ff        rst     38h
3f14 ff        rst     38h
3f15 ff        rst     38h
3f16 ff        rst     38h
3f17 ff        rst     38h
3f18 ff        rst     38h
3f19 ff        rst     38h
3f1a ff        rst     38h
3f1b ff        rst     38h
3f1c ff        rst     38h
3f1d ff        rst     38h
3f1e ff        rst     38h
3f1f ff        rst     38h
3f20 ff        rst     38h
3f21 ff        rst     38h
3f22 ff        rst     38h
3f23 ff        rst     38h
3f24 ff        rst     38h
3f25 ff        rst     38h
3f26 ff        rst     38h
3f27 ff        rst     38h
3f28 ff        rst     38h
3f29 ff        rst     38h
3f2a ff        rst     38h
3f2b ff        rst     38h
3f2c ff        rst     38h
3f2d ff        rst     38h
3f2e ff        rst     38h
3f2f ff        rst     38h
3f30 ff        rst     38h
3f31 ff        rst     38h
3f32 ff        rst     38h
3f33 ff        rst     38h
3f34 ff        rst     38h
3f35 ff        rst     38h
3f36 ff        rst     38h
3f37 ff        rst     38h
3f38 ff        rst     38h
3f39 ff        rst     38h
3f3a ff        rst     38h
3f3b ff        rst     38h
3f3c ff        rst     38h
3f3d ff        rst     38h
3f3e ff        rst     38h
3f3f ff        rst     38h
3f40 ff        rst     38h
3f41 ff        rst     38h
3f42 ff        rst     38h
3f43 ff        rst     38h
3f44 ff        rst     38h
3f45 ff        rst     38h
3f46 ff        rst     38h
3f47 ff        rst     38h
3f48 ff        rst     38h
3f49 ff        rst     38h
3f4a ff        rst     38h
3f4b ff        rst     38h
3f4c ff        rst     38h
3f4d ff        rst     38h
3f4e ff        rst     38h
3f4f ff        rst     38h
3f50 ff        rst     38h
3f51 ff        rst     38h
3f52 ff        rst     38h
3f53 ff        rst     38h
3f54 ff        rst     38h
3f55 ff        rst     38h
3f56 ff        rst     38h
3f57 ff        rst     38h
3f58 ff        rst     38h
3f59 ff        rst     38h
3f5a ff        rst     38h
3f5b ff        rst     38h
3f5c ff        rst     38h
3f5d ff        rst     38h
3f5e ff        rst     38h
3f5f ff        rst     38h
3f60 ff        rst     38h
3f61 ff        rst     38h
3f62 ff        rst     38h
3f63 ff        rst     38h
3f64 ff        rst     38h
3f65 ff        rst     38h
3f66 ff        rst     38h
3f67 ff        rst     38h
3f68 ff        rst     38h
3f69 ff        rst     38h
3f6a ff        rst     38h
3f6b ff        rst     38h
3f6c ff        rst     38h
3f6d ff        rst     38h
3f6e ff        rst     38h
3f6f ff        rst     38h
3f70 ff        rst     38h
3f71 ff        rst     38h
3f72 ff        rst     38h
3f73 ff        rst     38h
3f74 ff        rst     38h
3f75 ff        rst     38h
3f76 ff        rst     38h
3f77 ff        rst     38h
3f78 ff        rst     38h
3f79 ff        rst     38h
3f7a ff        rst     38h
3f7b ff        rst     38h
3f7c ff        rst     38h
3f7d ff        rst     38h
3f7e ff        rst     38h
3f7f ff        rst     38h
3f80 ff        rst     38h
3f81 ff        rst     38h
3f82 ff        rst     38h
3f83 ff        rst     38h
3f84 ff        rst     38h
3f85 ff        rst     38h
3f86 ff        rst     38h
3f87 ff        rst     38h
3f88 ff        rst     38h
3f89 ff        rst     38h
3f8a ff        rst     38h
3f8b ff        rst     38h
3f8c ff        rst     38h
3f8d ff        rst     38h
3f8e ff        rst     38h
3f8f ff        rst     38h
3f90 ff        rst     38h
3f91 ff        rst     38h
3f92 ff        rst     38h
3f93 ff        rst     38h
3f94 ff        rst     38h
3f95 ff        rst     38h
3f96 ff        rst     38h
3f97 ff        rst     38h
3f98 ff        rst     38h
3f99 ff        rst     38h
3f9a ff        rst     38h
3f9b ff        rst     38h
3f9c ff        rst     38h
3f9d ff        rst     38h
3f9e ff        rst     38h
3f9f ff        rst     38h
3fa0 ff        rst     38h
3fa1 ff        rst     38h
3fa2 ff        rst     38h
3fa3 ff        rst     38h
3fa4 ff        rst     38h
3fa5 ff        rst     38h
3fa6 ff        rst     38h
3fa7 ff        rst     38h
3fa8 ff        rst     38h
3fa9 ff        rst     38h
3faa ff        rst     38h
3fab ff        rst     38h
3fac ff        rst     38h
3fad ff        rst     38h
3fae ff        rst     38h
3faf ff        rst     38h
3fb0 ff        rst     38h
3fb1 ff        rst     38h
3fb2 ff        rst     38h
3fb3 ff        rst     38h
3fb4 ff        rst     38h
3fb5 ff        rst     38h
3fb6 ff        rst     38h
3fb7 ff        rst     38h
3fb8 ff        rst     38h
3fb9 ff        rst     38h
3fba ff        rst     38h
3fbb ff        rst     38h
3fbc ff        rst     38h
3fbd ff        rst     38h
3fbe ff        rst     38h
3fbf ff        rst     38h
3fc0 ff        rst     38h
3fc1 ff        rst     38h
3fc2 ff        rst     38h
3fc3 ff        rst     38h
3fc4 ff        rst     38h
3fc5 ff        rst     38h
3fc6 ff        rst     38h
3fc7 ff        rst     38h
3fc8 ff        rst     38h
3fc9 ff        rst     38h
3fca ff        rst     38h
3fcb ff        rst     38h
3fcc ff        rst     38h
3fcd ff        rst     38h
3fce ff        rst     38h
3fcf ff        rst     38h
3fd0 ff        rst     38h
3fd1 ff        rst     38h
3fd2 ff        rst     38h
3fd3 ff        rst     38h
3fd4 ff        rst     38h
3fd5 ff        rst     38h
3fd6 ff        rst     38h
3fd7 ff        rst     38h
3fd8 ff        rst     38h
3fd9 ff        rst     38h
3fda ff        rst     38h
3fdb ff        rst     38h
3fdc ff        rst     38h
3fdd ff        rst     38h
3fde ff        rst     38h
3fdf ff        rst     38h
3fe0 ff        rst     38h
3fe1 ff        rst     38h
3fe2 ff        rst     38h
3fe3 ff        rst     38h
3fe4 ff        rst     38h
3fe5 ff        rst     38h
3fe6 ff        rst     38h
3fe7 ff        rst     38h
3fe8 ff        rst     38h
3fe9 ff        rst     38h
3fea ff        rst     38h
3feb ff        rst     38h
3fec ff        rst     38h
3fed ff        rst     38h
3fee ff        rst     38h
3fef ff        rst     38h
3ff0 ff        rst     38h
3ff1 ff        rst     38h
3ff2 ff        rst     38h
3ff3 ff        rst     38h
3ff4 ff        rst     38h
3ff5 ff        rst     38h
3ff6 ff        rst     38h
3ff7 ff        rst     38h
3ff8 ff        rst     38h
3ff9 ff        rst     38h
3ffa ff        rst     38h
3ffb ff        rst     38h
3ffc ff        rst     38h
3ffd ff        rst     38h
3ffe ff        rst     38h
3fff ff        rst     38h

4000 03        inc     bc
4001 2a13fe    ld      hl,(0fe13h)    ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
4004 83        add     a,e
4005 3d        dec     a
4006 f4d320    call    p,20d3h
4009 50        ld      d,b
400a c3291f    jp      1f29h
400d e5        push    hl
400e d5        push    de
400f cd3619    call    1936h
4012 d1        pop     de
4013 af        xor     a
4014 ca1a20    jp      z,201ah
4017 1e10      ld      e,10h
4019 011e06    ld      bc,061eh
401c cdbf17    call    17bfh
401f 37        scf     
4020 c46b20    call    nz,206bh
4023 e1        pop     hl
4024 c1        pop     bc
4025 f5        push    af
4026 79        ld      a,c
4027 b7        or      a
4028 f5        push    af
4029 c4801d    call    nz,1d80h
402c 80        add     a,b
402d 4f        ld      c,a
402e 7a        ld      a,d
402f e604      and     04h
4031 fe01      cp      01h
4033 9f        sbc     a,a
4034 57        ld      d,a
4035 81        add     a,c
4036 4f        ld      c,a
4037 93        sub     e
4038 f5        push    af
4039 c5        push    bc
403a fc821d    call    m,1d82h
403d fa3a20    jp      m,203ah
4040 c1        pop     bc
4041 f1        pop     af
4042 c5        push    bc
4043 f5        push    af
4044 fa4820    jp      m,2048h
4047 af        xor     a
4048 2f        cpl     
4049 3c        inc     a
404a 80        add     a,b
404b 3c        inc     a
404c 82        add     a,d
404d 47        ld      b,a
404e 0e00      ld      c,00h
4050 cd0e21    call    210eh
4053 f1        pop     af
4054 f4db20    call    p,20dbh
4057 c1        pop     bc
4058 f1        pop     af
4059 cc9917    call    z,1799h
405c f1        pop     af
405d 3803      jr      c,4062h
405f 83        add     a,e
4060 90        sub     b
4061 92        sub     d
4062 c5        push    bc
4063 cdde1e    call    1edeh
4066 eb        ex      de,hl
4067 d1        pop     de
4068 c3291f    jp      1f29h

406b d5        push    de
406c af        xor     a
406d f5        push    af
406e e7        rst     20h			; GETYPR - Get the number type (FAC)
406f e28c20    jp      po,208ch
4072 3a44fe    ld      a,(0fe44h)
4075 fe91      cp      91h
4077 d28c20    jp      nc,208ch
407a 11ce21    ld      de,21ceh
407d 2147fe    ld      hl,0fe47h
4080 cd3d18    call    183dh
4083 cd0b1c    call    1c0bh
4086 f1        pop     af
4087 d60a      sub     0ah
4089 f5        push    af
408a 18e6      jr      4072h

408c cdb920    call    20b9h
408f e7        rst     20h			; GETYPR - Get the number type (FAC)
4090 300b      jr      nc,409dh
4092 014391    ld      bc,9143h
4095 11f94f    ld      de,4ff9h
4098 cd7618    call    1876h
409b 1806      jr      40a3h

409d 11d621    ld      de,21d6h
40a0 cdb318    call    18b3h
40a3 f2b520    jp      p,20b5h
40a6 f1        pop     af
40a7 cd751d    call    1d75h
40aa f5        push    af
40ab 18e2      jr      408fh
40ad f1        pop     af
40ae cd821d    call    1d82h
40b1 f5        push    af
40b2 cdb920    call    20b9h
40b5 f1        pop     af
40b6 b7        or      a
40b7 d1        pop     de
40b8 c9        ret

40b9 e7        rst     20h			; GETYPR - Get the number type (FAC)
40ba eac820    jp      pe,20c8h
40bd 017494    ld      bc,9474h
40c0 11f823    ld      de,23f8h
40c3 cd7618    call    1876h
40c6 1806      jr      40ceh
40c8 11de21    ld      de,21deh
40cb cdb318    call    18b3h
40ce e1        pop     hl
40cf f2ad20    jp      p,20adh
40d2 e9        jp      (hl)
40d3 b7        or      a
40d4 c8        ret     z
40d5 3d        dec     a
40d6 3630      ld      (hl),30h
40d8 23        inc     hl
40d9 18f9      jr      40d4h
40db 2004      jr      nz,40e1h
40dd c8        ret     z
40de cdfb20    call    20fbh
40e1 3630      ld      (hl),30h
40e3 23        inc     hl
40e4 3d        dec     a
40e5 18f6      jr      40ddh
40e7 7b        ld      a,e
40e8 82        add     a,d
40e9 3c        inc     a
40ea 47        ld      b,a
40eb 3c        inc     a
40ec d603      sub     03h
40ee 30fc      jr      nc,40ech
40f0 c605      add     a,05h
40f2 4f        ld      c,a
40f3 3af8fd    ld      a,(0fdf8h)        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
40f6 e640      and     40h
40f8 c0        ret     nz
40f9 4f        ld      c,a
40fa c9        ret     
40fb 05        dec     b
40fc 2008      jr      nz,4106h
40fe 362e      ld      (hl),2eh
4100 2213fe    ld      (0fe13h),hl        ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
4103 23        inc     hl
4104 48        ld      c,b
4105 c9        ret

4106 0d        dec     c
4107 c0        ret     nz
4108 362c      ld      (hl),2ch
410a 23        inc     hl
410b 0e03      ld      c,03h
410d c9        ret

410e d5        push    de
410f e7        rst     20h			; GETYPR - Get the number type (FAC)
4110 e25421    jp      po,2154h
4113 c5        push    bc
4114 e5        push    hl
4115 cd6618    call    1866h
4118 21e621    ld      hl,21e6h
411b cd6118    call    1861h
411e cde11a    call    1ae1h
4121 af        xor     a
4122 cde519    call    19e5h
4125 e1        pop     hl
4126 c1        pop     bc
4127 11f621    ld      de,21f6h
412a 3e0a      ld      a,0ah
412c cdfb20    call    20fbh
412f c5        push    bc
4130 f5        push    af
4131 e5        push    hl
4132 d5        push    de
4133 062f      ld      b,2fh
4135 04        inc     b
4136 e1        pop     hl
4137 e5        push    hl
4138 cdb21b    call    1bb2h
413b 30f8      jr      nc,4135h
413d e1        pop     hl
413e cda01b    call    1ba0h
4141 eb        ex      de,hl
4142 e1        pop     hl
4143 70        ld      (hl),b
4144 23        inc     hl
4145 f1        pop     af
4146 c1        pop     bc
4147 3d        dec     a
4148 20e2      jr      nz,412ch
414a c5        push    bc
414b e5        push    hl
414c 213dfe    ld      hl,0fe3dh
414f cd1b18    call    181bh            ; Move a SP value -> HL to WRA1
4152 180c      jr      4160h
4154 c5        push    bc
4155 e5        push    hl
4156 cd7215    call    1572h
4159 3c        inc     a
415a cd6519    call    1965h
415d cd1e18    call    181eh            ; Move SP value in BC/DE into WRA1
4160 e1        pop     hl
4161 c1        pop     bc
4162 af        xor     a
4163 113c22    ld      de,223ch
4166 3f        ccf     
4167 cdfb20    call    20fbh
416a c5        push    bc
416b f5        push    af
416c e5        push    hl
416d d5        push    de
416e cd2918    call    1829h
4171 e1        pop     hl
4172 062f      ld      b,2fh
4174 04        inc     b
4175 7b        ld      a,e
4176 96        sub     (hl)
4177 5f        ld      e,a
4178 23        inc     hl
4179 7a        ld      a,d
417a 9e        sbc     a,(hl)
417b 57        ld      d,a
417c 23        inc     hl
417d 79        ld      a,c
417e 9e        sbc     a,(hl)
417f 4f        ld      c,a
4180 2b        dec     hl
4181 2b        dec     hl
4182 30f0      jr      nc,4174h
4184 cd2116    call    1621h
4187 23        inc     hl
4188 cd1e18    call    181eh            ; Move SP value in BC/DE into WRA1
418b eb        ex      de,hl
418c e1        pop     hl
418d 70        ld      (hl),b
418e 23        inc     hl
418f f1        pop     af
4190 c1        pop     bc
4191 38d3      jr      c,4166h
4193 13        inc     de
4194 13        inc     de
4195 3e04      ld      a,04h
4197 1806      jr      419fh
4199 d5        push    de
419a 114222    ld      de,2242h
419d 3e05      ld      a,05h
419f cdfb20    call    20fbh
41a2 c5        push    bc
41a3 f5        push    af
41a4 e5        push    hl
41a5 eb        ex      de,hl
41a6 4e        ld      c,(hl)
41a7 23        inc     hl
41a8 46        ld      b,(hl)
41a9 c5        push    bc
41aa 23        inc     hl
41ab e3        ex      (sp),hl
41ac eb        ex      de,hl
41ad 2a41fe    ld      hl,(0fe41h)        ; FACCU
41b0 062f      ld      b,2fh
41b2 04        inc     b
41b3 7d        ld      a,l
41b4 93        sub     e
41b5 6f        ld      l,a
41b6 7c        ld      a,h
41b7 9a        sbc     a,d
41b8 67        ld      h,a
41b9 30f7      jr      nc,41b2h
41bb 19        add     hl,de
41bc 2241fe    ld      (0fe41h),hl        ; FACCU
41bf d1        pop     de
41c0 e1        pop     hl
41c1 70        ld      (hl),b
41c2 23        inc     hl
41c3 f1        pop     af
41c4 c1        pop     bc
41c5 3d        dec     a
41c6 20d7      jr      nz,419fh
41c8 cdfb20    call    20fbh
41cb 77        ld      (hl),a
41cc d1        pop     de
41cd c9        ret     
41ce 00        nop     
41cf 00        nop     
41d0 00        nop     
41d1 00        nop     
41d2 f9        ld      sp,hl
41d3 02        ld      (bc),a
41d4 15        dec     d
41d5 a2        and     d
41d6 fdff      rst     38h
41d8 9f        sbc     a,a
41d9 31a95f    ld      sp,5fa9h
41dc 63        ld      h,e
41dd b2        or      d
41de feff      cp      0ffh
41e0 03        inc     bc
41e1 bf        cp      a
41e2 c9        ret     
41e3 1b        dec     de
41e4 0eb6      ld      c,0b6h
41e6 00        nop     
41e7 00        nop     
41e8 00        nop     
41e9 00        nop     
41ea 00        nop     
41eb 00        nop     
41ec 00        nop     
41ed 80        add     a,b
41ee 00        nop     
41ef 00        nop     
41f0 04        inc     b
41f1 bf        cp      a
41f2 c9        ret     
41f3 1b        dec     de
41f4 0eb6      ld      c,0b6h
41f6 00        nop     
41f7 80        add     a,b
41f8 c6a4      add     a,0a4h
41fa 7e        ld      a,(hl)
41fb 8d        adc     a,l
41fc 03        inc     bc
41fd 00        nop     
41fe 40        ld      b,b
41ff 7a        ld      a,d
4200 10f3      djnz    41f5h
4202 5a        ld      e,d
4203 00        nop     
4204 00        nop     
4205 a0        and     b
4206 72        ld      (hl),d
4207 4e        ld      c,(hl)
4208 1809      jr      4213h
420a 00        nop     
420b 00        nop     
420c 10a5      djnz    41b3h
420e d4e800    call    nc,00e8h
4211 00        nop     
4212 00        nop     
4213 e8        ret     pe
4214 76        halt    
4215 48        ld      c,b
4216 17        rla     
4217 00        nop     
4218 00        nop     
4219 00        nop     
421a e40b54    call    po,540bh
421d 02        ld      (bc),a
421e 00        nop     
421f 00        nop     
4220 00        nop     
4221 ca9a3b    jp      z,3b9ah
4224 00        nop     
4225 00        nop     
4226 00        nop     
4227 00        nop     
4228 e1        pop     hl
4229 f5        push    af
422a 05        dec     b
422b 00        nop     
422c 00        nop     
422d 00        nop     
422e 80        add     a,b
422f 96        sub     (hl)
4230 98        sbc     a,b
4231 00        nop     
4232 00        nop     
4233 00        nop     
4234 00        nop     
4235 40        ld      b,b
4236 42        ld      b,d
4237 0f        rrca    
4238 00        nop     
4239 00        nop     
423a 00        nop     
423b 00        nop     
423c a0        and     b
423d 86        add     a,(hl)
423e 011027    ld      bc,2710h
4241 00        nop     
4242 1027      djnz    426bh
4244 e8        ret     pe
4245 03        inc     bc
4246 64        ld      h,h
4247 00        nop     
4248 0a        ld      a,(bc)
4249 00        nop     
424a 010021    ld      bc,2100h
424d ec17e3    call    pe,0e317h
4250 e9        jp      (hl)
4251 cd0e18    call    180eh                ; Move WRA1 to stack
4254 21ea21    ld      hl,21eah
4257 cd1b18    call    181bh            ; Move a SP value -> HL to WRA1
425a 1803      jr      425fh
425c cd1b19    call    191bh
425f c1        pop     bc
4260 d1        pop     de
4261 cdbf17    call    17bfh
4264 78        ld      a,b
4265 283c      jr      z,42a3h
4267 f26e22    jp      p,226eh
426a b7        or      a
426b ca8428    jp      z,2884h
426e b7        or      a
426f cae315    jp      z,15e3h
4272 d5        push    de
4273 c5        push    bc
4274 79        ld      a,c
4275 f67f      or      7fh
4277 cd2918    call    1829h
427a f28b22    jp      p,228bh
427d d5        push    de
427e c5        push    bc
427f cdaa19    call    19aah
4282 c1        pop     bc
4283 d1        pop     de
4284 f5        push    af
4285 cd7618    call    1876h
4288 e1        pop     hl
4289 7c        ld      a,h
428a 1f        rra     
428b e1        pop     hl
428c 2243fe    ld      (0fe43h),hl
428f e1        pop     hl
4290 2241fe    ld      (0fe41h),hl        ; FACCU
4293 dc4c22    call    c,224ch
4296 ccec17    call    z,17ech
4299 d5        push    de
429a c5        push    bc
429b cd7316    call    1673h
429e c1        pop     bc
429f d1        pop     de
42a0 cdb116    call    16b1h
42a3 cd0e18    call    180eh                ; Move WRA1 to stack
42a6 013881    ld      bc,8138h
42a9 113baa    ld      de,0aa3bh
42ac cdb116    call    16b1h
42af 3a44fe    ld      a,(0fe44h)
42b2 fe88      cp      88h
42b4 d29b17    jp      nc,179bh
42b7 cdaa19    call    19aah
42ba c680      add     a,80h
42bc c602      add     a,02h
42be da9b17    jp      c,179bh
42c1 f5        push    af
42c2 216216    ld      hl,1662h			; UNITY - Constant ptr for number 1 in FP
42c5 cd7515    call    1575h
42c8 cdab16    call    16abh
42cb f1        pop     af
42cc c1        pop     bc
42cd d1        pop     de
42ce f5        push    af
42cf cd7d15    call    157dh
42d2 cdec17    call    17ech
42d5 21e322    ld      hl,22e3h
42d8 cd1323    call    2313h
42db 110000    ld      de,0000h
42de c1        pop     bc
42df 4a        ld      c,d
42e0 c3b116    jp      16b1h
42e3 08        ex      af,af'
42e4 40        ld      b,b
42e5 2e94      ld      l,94h
42e7 74        ld      (hl),h
42e8 70        ld      (hl),b
42e9 4f        ld      c,a
42ea 2e77      ld      l,77h
42ec 6e        ld      l,(hl)
42ed 02        ld      (bc),a
42ee 88        adc     a,b
42ef 7a        ld      a,d
42f0 e6a0      and     0a0h
42f2 2a7c50    ld      hl,(507ch)
42f5 aa        xor     d
42f6 aa        xor     d
42f7 7e        ld      a,(hl)
42f8 ff        rst     38h
42f9 ff        rst     38h
42fa 7f        ld      a,a
42fb 7f        ld      a,a
42fc 00        nop     
42fd 00        nop     
42fe 80        add     a,b
42ff 81        add     a,c
4300 00        nop     
4301 00        nop     
4302 00        nop     
4303 81        add     a,c
4304 cd0e18    call    180eh                ; Move WRA1 to stack
4307 119c1a    ld      de,1a9ch
430a d5        push    de
430b e5        push    hl
430c cd2918    call    1829h
430f cdb116    call    16b1h
4312 e1        pop     hl
4313 cd0e18    call    180eh                ; Move WRA1 to stack
4316 7e        ld      a,(hl)
4317 23        inc     hl
4318 cd1b18    call    181bh            ; Move a SP value -> HL to WRA1
431b 06f1      ld      b,0f1h
431d c1        pop     bc
431e d1        pop     de
431f 3d        dec     a
4320 c8        ret     z
4321 d5        push    de
4322 c5        push    bc
4323 f5        push    af
4324 e5        push    hl
4325 cdb116    call    16b1h
4328 e1        pop     hl
4329 cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE
432c e5        push    hl
432d cd8015    call    1580h
4330 e1        pop     hl
4331 18e9      jr      431ch
4333 cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
4336 7c        ld      a,h
4337 b7        or      a
4338 fa352d    jp      m,2d35h            ; Error: Illegal function call (FC ERROR)
433b b5        or      l
433c ca5a23    jp      z,235ah
433f e5        push    hl
4340 cd5a23    call    235ah
4343 cd2918    call    1829h
4346 eb        ex      de,hl
4347 e3        ex      (sp),hl
4348 c5        push    bc
4349 cd3919    call    1939h
434c c1        pop     bc
434d d1        pop     de
434e cdb116    call    16b1h
4351 216216    ld      hl,1662h			; UNITY - Constant ptr for number 1 in FP
4354 cd7515    call    1575h
4357 c3aa19    jp      19aah
435a 2144fc    ld      hl,0fc44h
435d e5        push    hl
435e 110000    ld      de,0000h
4361 4b        ld      c,e
4362 2603      ld      h,03h
4364 2e08      ld      l,08h
4366 eb        ex      de,hl
4367 29        add     hl,hl
4368 eb        ex      de,hl
4369 79        ld      a,c
436a 17        rla     
436b 4f        ld      c,a
436c e3        ex      (sp),hl
436d 7e        ld      a,(hl)
436e 07        rlca    
436f 77        ld      (hl),a
4370 e3        ex      (sp),hl
4371 d28023    jp      nc,2380h
4374 e5        push    hl
4375 2acafd    ld      hl,(0fdcah)        ; Random number seeds
4378 19        add     hl,de
4379 eb        ex      de,hl
437a 3accfd    ld      a,(0fdcch)
437d 89        adc     a,c
437e 4f        ld      c,a
437f e1        pop     hl
4380 2d        dec     l
4381 c26623    jp      nz,2366h
4384 e3        ex      (sp),hl
4385 23        inc     hl
4386 e3        ex      (sp),hl
4387 25        dec     h
4388 c26423    jp      nz,2364h
438b e1        pop     hl
438c 2165b0    ld      hl,0b065h
438f 19        add     hl,de
4390 22cafd    ld      (0fdcah),hl        ; Random number seeds
4393 cd5919    call    1959h
4396 3e05      ld      a,05h
4398 89        adc     a,c
4399 32ccfd    ld      (0fdcch),a
439c eb        ex      de,hl
439d 0680      ld      b,80h
439f 2145fe    ld      hl,0fe45h
43a2 70        ld      (hl),b
43a3 2b        dec     hl
43a4 70        ld      (hl),b
43a5 4f        ld      c,a
43a6 0600      ld      b,00h
43a8 c3cf15    jp      15cfh

43ab 21f523    ld      hl,23f5h
43ae cd7515    call    1575h
43b1 cd0e18    call    180eh                ; Move WRA1 to stack
43b4 014983    ld      bc,8349h
43b7 11db0f    ld      de,0fdbh
43ba cd1e18    call    181eh            ; Move SP value in BC/DE into WRA1
43bd c1        pop     bc
43be d1        pop     de
43bf cd0c17    call    170ch
43c2 cd0e18    call    180eh                ; Move WRA1 to stack
43c5 cdaa19    call    19aah
43c8 c1        pop     bc
43c9 d1        pop     de
43ca cd7d15    call    157dh
43cd 21f923    ld      hl,23f9h
43d0 cd7a15    call    157ah
43d3 cdbf17    call    17bfh
43d6 37        scf     
43d7 f2e123    jp      p,23e1h
43da cd7215    call    1572h
43dd cdbf17    call    17bfh
43e0 b7        or      a
43e1 f5        push    af
43e2 f4ec17    call    p,17ech
43e5 21f923    ld      hl,23f9h
43e8 cd7515    call    1575h
43eb f1        pop     af
43ec d4ec17    call    nc,17ech
43ef 21fd23    ld      hl,23fdh
43f2 c30423    jp      2304h
43f5 db0f      in      a,(0fh)
43f7 49        ld      c,c
43f8 81        add     a,c
43f9 00        nop     
43fa 00        nop     
43fb 00        nop     
43fc 7f        ld      a,a
43fd 05        dec     b
43fe ba        cp      d
43ff d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4400 1e86      ld      e,86h
4402 64        ld      h,h
4403 2699      ld      h,99h
4405 87        add     a,a
4406 58        ld      e,b
4407 34        inc     (hl)
4408 23        inc     hl
4409 87        add     a,a
440a e0        ret     po
440b 5d        ld      e,l
440c a5        and     l
440d 86        add     a,(hl)
440e da0f49    jp      c,490fh
4411 83        add     a,e
4412 cd0e18    call    180eh                ; Move WRA1 to stack
4415 cdb123    call    23b1h
4418 c1        pop     bc
4419 e1        pop     hl
441a cd0e18    call    180eh                ; Move WRA1 to stack
441d eb        ex      de,hl
441e cd1e18    call    181eh            ; Move SP value in BC/DE into WRA1
4421 cdab23    call    23abh
4424 c30a17    jp      170ah
4427 cdbf17    call    17bfh
442a fc4c22    call    m,224ch
442d fcec17    call    m,17ech
4430 3a44fe    ld      a,(0fe44h)
4433 fe81      cp      81h
4435 380c      jr      c,4443h
4437 010081    ld      bc,8100h
443a 51        ld      d,c
443b 59        ld      e,c
443c cd0c17    call    170ch
443f 217a15    ld      hl,157ah
4442 e5        push    hl
4443 214d24    ld      hl,244dh
4446 cd0423    call    2304h
4449 21f523    ld      hl,23f5h
444c c9        ret     
444d 09        add     hl,bc
444e 4a        ld      c,d
444f d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4450 3b        dec     sp
4451 78        ld      a,b
4452 02        ld      (bc),a
4453 6e        ld      l,(hl)
4454 84        add     a,h
4455 7b        ld      a,e
4456 fec1      cp      0c1h
4458 2f        cpl     
4459 7c        ld      a,h
445a 74        ld      (hl),h
445b 319a7d    ld      sp,7d9ah
445e 84        add     a,h
445f 3d        dec     a
4460 5a        ld      e,d
4461 7d        ld      a,l
4462 c8        ret     z
4463 7f        ld      a,a
4464 91        sub     c
4465 7e        ld      a,(hl)
4466 e4bb4c    call    po,4cbbh
4469 7e        ld      a,(hl)
446a 6c        ld      l,h
446b aa        xor     d
446c aa        xor     d
446d 7f        ld      a,a
446e 00        nop     
446f 00        nop     
4470 00        nop     
4471 81        add     a,c
4472 c3802b    jp      2b80h
4475 c3622c    jp      2c62h
4478 c37a2b    jp      2b7ah
447b c3cd34    jp      34cdh
447e c9        ret     
447f 00        nop     
4480 00        nop     
4481 c9        ret     
4482 00        nop     
4483 00        nop     
4484 f3        di      
4485 c9        ret     
4486 00        nop     
4487 010000    ld      bc,0000h
448a 00        nop     
448b 00        nop     
448c 34        inc     (hl)
448d 1c        inc     e
448e 00        nop     
448f 00        nop     
4490 00        nop     
4491 00        nop     
4492 00        nop     
4493 00        nop     
4494 00        nop     
4495 01f006    ld      bc,06f0h
4498 00        nop     
4499 00        nop     
449a 43        ld      b,e
449b 00        nop     
449c 00        nop     
449d 00        nop     
449e 00        nop     
449f c30000    jp      0000h
44a2 c30000    jp      0000h
44a5 3e00      ld      a,00h
44a7 c9        ret     
44a8 c9        ret     
44a9 00        nop     
44aa 00        nop     
44ab c9        ret     
44ac 00        nop     
44ad 00        nop     
44ae c9        ret     
44af 00        nop     
44b0 00        nop     
44b1 c9        ret     
44b2 00        nop     
44b3 00        nop     
44b4 c9        ret     
44b5 00        nop     
44b6 00        nop     
44b7 c9        ret     
44b8 00        nop     
44b9 00        nop     
44ba c9        ret     
44bb 00        nop     
44bc 00        nop     
44bd c9        ret     
44be 00        nop     
44bf 00        nop     
44c0 00        nop     
44c1 00        nop     
44c2 00        nop     
44c3 00        nop     
44c4 00        nop     
44c5 00        nop     
44c6 00        nop     
44c7 00        nop     
44c8 00        nop     
44c9 00        nop     
44ca 00        nop     
44cb 00        nop     
44cc 00        nop     
44cd 00        nop     
44ce 00        nop     
44cf 00        nop     
44d0 00        nop     
44d1 00        nop     
44d2 00        nop     
44d3 00        nop     
44d4 00        nop     
44d5 00        nop     
44d6 00        nop     
44d7 00        nop     
44d8 00        nop     
44d9 00        nop     
44da 00        nop     
44db 00        nop     
44dc 00        nop     
44dd 00        nop     
44de 00        nop     
44df 00        nop     
44e0 00        nop     
44e1 00        nop     
44e2 00        nop     
44e3 00        nop     
44e4 00        nop     
44e5 00        nop     
44e6 f417a1    call    p,0a117h
44e9 19        add     hl,de
44ea e1        pop     hl
44eb 17        rla     
44ec c8        ret     z
44ed 36e3      ld      (hl),0e3h
44ef 39        add     hl,sp
44f0 e9        jp      (hl)
44f1 3651      ld      (hl),51h
44f3 223323    ld      (2333h),hl
44f6 73        ld      (hl),e
44f7 16a3      ld      d,0a3h
44f9 22ab23    ld      (23abh),hl
44fc b1        or      c
44fd 23        inc     hl
44fe 12        ld      (de),a
44ff 24        inc     h
4500 27        daa     
4501 24        inc     h
4502 a8        xor     b
4503 3b        dec     sp
4504 14        inc     d
4505 3f        ccf     
4506 78        ld      a,b
4507 fe1c      cp      1ch
4509 3f        ccf     
450a 81        add     a,c
450b fe84      cp      84h
450d fe2c      cp      ','
450f 3f        ccf     
4510 323f18    ld      (183fh),a
4513 3f        ccf     
4514 363f      ld      (hl),3fh
4516 e9        jp      (hl)
4517 181b      jr      4534h
4519 19        add     hl,de
451a 45        ld      b,l
451b 19        add     hl,de
451c 90        sub     b
451d 19        add     hl,de
451e f7        rst     30h
451f 382a      jr      c,454bh
4521 37        scf     
4522 b9        cp      c
4523 39        add     hl,sp
4524 03        inc     bc
4525 39        add     hl,sp
4526 13        inc     de
4527 39        add     hl,sp
4528 55        ld      d,l
4529 39        add     hl,sp
452a 85        add     a,l
452b 39        add     hl,sp
452c 8e        adc     a,(hl)
452d 39        add     hl,sp
452e c5        push    bc
452f 4e        ld      c,(hl)
4530 44        ld      b,h
4531 c64f      add     a,4fh
4533 52        ld      d,d
4534 d24553    jp      nc,5345h
4537 45        ld      b,l
4538 54        ld      d,h
4539 d345      out     (45h),a
453b 54        ld      d,h
453c c34c53    jp      534ch
453f c34d44    jp      444dh
4542 d2414e    jp      nc,4e41h
4545 44        ld      b,h
4546 4f        ld      c,a
4547 4d        ld      c,l
4548 ce45      adc     a,45h
454a 58        ld      e,b
454b 54        ld      d,h
454c c44154    call    nz,5441h
454f 41        ld      b,c
4550 c9        ret     
4551 4e        ld      c,(hl)
4552 50        ld      d,b
4553 55        ld      d,l
4554 54        ld      d,h
4555 c4494d    call    nz,4d49h
4558 d24541    jp      nc,4145h
455b 44        ld      b,h
455c cc4554    call    z,5445h
455f c7        rst     00h
4560 4f        ld      c,a
4561 54        ld      d,h
4562 4f        ld      c,a
4563 d2554e    jp      nc,4e55h
4566 c9        ret     
4567 46        ld      b,(hl)
4568 d24553    jp      nc,5345h
456b 54        ld      d,h
456c 4f        ld      c,a
456d 52        ld      d,d
456e 45        ld      b,l
456f c7        rst     00h
4570 4f        ld      c,a
4571 53        ld      d,e
4572 55        ld      d,l
4573 42        ld      b,d
4574 d24554    jp      nc,5445h
4577 55        ld      d,l
4578 52        ld      d,d
4579 4e        ld      c,(hl)
457a d2454d    jp      nc,4d45h
457d d354      out     (54h),a
457f 4f        ld      c,a
4580 50        ld      d,b
4581 c5        push    bc
4582 4c        ld      c,h
4583 53        ld      d,e
4584 45        ld      b,l
4585 d4524f    call    nc,4f52h
4588 4e        ld      c,(hl)
4589 d4524f    call    nc,4f52h
458c 46        ld      b,(hl)
458d 46        ld      b,(hl)
458e c44546    call    nz,4645h
4591 53        ld      d,e
4592 54        ld      d,h
4593 52        ld      d,d
4594 c44546    call    nz,4645h
4597 49        ld      c,c
4598 4e        ld      c,(hl)
4599 54        ld      d,h
459a c44546    call    nz,4645h
459d 53        ld      d,e
459e 4e        ld      c,(hl)
459f 47        ld      b,a
45a0 c44546    call    nz,4645h
45a3 44        ld      b,h
45a4 42        ld      b,d
45a5 4c        ld      c,h
45a6 d0        ret     nc
45a7 43        ld      b,e
45a8 47        ld      b,a
45a9 45        ld      b,l
45aa 4e        ld      c,(hl)
45ab c5        push    bc
45ac 44        ld      b,h
45ad 49        ld      c,c
45ae 54        ld      d,h
45af c5        push    bc
45b0 52        ld      d,d
45b1 52        ld      d,d
45b2 4f        ld      c,a
45b3 52        ld      d,d
45b4 d24553    jp      nc,5345h
45b7 55        ld      d,l
45b8 4d        ld      c,l
45b9 45        ld      b,l
45ba cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
45bb 55        ld      d,l
45bc 54        ld      d,h
45bd cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
45be 4e        ld      c,(hl)
45bf cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
45c0 50        ld      d,b
45c1 45        ld      b,l
45c2 4e        ld      c,(hl)
45c3 c34f4c    jp      4c4fh
45c6 4f        ld      c,a
45c7 55        ld      d,l
45c8 52        ld      d,d
45c9 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
45ca 52        ld      d,d
45cb 49        ld      c,c
45cc 54        ld      d,h
45cd 45        ld      b,l
45ce 23        inc     hl
45cf c34c4f    jp      4f4ch
45d2 53        ld      d,e
45d3 45        ld      b,l
45d4 cc4f41    call    z,414fh
45d7 44        ld      b,h
45d8 d341      out     (41h),a
45da 56        ld      d,(hl)
45db 45        ld      b,l
45dc cb49      bit     1,c
45de 4c        ld      c,h
45df 4c        ld      c,h
45e0 c34952    jp      5249h
45e3 43        ld      b,e
45e4 4c        ld      c,h
45e5 45        ld      b,l
45e6 cc494e    call    z,4e49h
45e9 45        ld      b,l
45ea d34f      out     (4fh),a
45ec 55        ld      d,l
45ed 4e        ld      c,(hl)
45ee 44        ld      b,h
45ef c8        ret     z
45f0 47        ld      b,a
45f1 52        ld      d,d
45f2 d650      sub     50h
45f4 4f        ld      c,a
45f5 4b        ld      c,e
45f6 45        ld      b,l
45f7 d359      out     (59h),a
45f9 53        ld      d,e
45fa 54        ld      d,h
45fb 45        ld      b,l
45fc 4d        ld      c,l
45fd cc5052    call    z,5250h
4600 49        ld      c,c
4601 4e        ld      c,(hl)
4602 54        ld      d,h
4603 c44546    call    nz,4645h
4606 d0        ret     nc
4607 4f        ld      c,a
4608 4b        ld      c,e
4609 45        ld      b,l
460a d0        ret     nc
460b 52        ld      d,d
460c 49        ld      c,c
460d 4e        ld      c,(hl)
460e 54        ld      d,h
460f c34f4e    jp      4e4fh
4612 54        ld      d,h
4613 cc4953    call    z,5349h
4616 54        ld      d,h
4617 cc4c49    call    z,494ch
461a 53        ld      d,e
461b 54        ld      d,h
461c c4454c    call    nz,4c45h
461f 45        ld      b,l
4620 54        ld      d,h
4621 45        ld      b,l
4622 c1        pop     bc
4623 55        ld      d,l
4624 54        ld      d,h
4625 4f        ld      c,a
4626 c34c45    jp      454ch
4629 41        ld      b,c
462a 52        ld      d,d
462b c34c4f    jp      4f4ch
462e 41        ld      b,c
462f 44        ld      b,h
4630 c35341    jp      4153h
4633 56        ld      d,(hl)
4634 45        ld      b,l
4635 ce45      adc     a,45h
4637 57        ld      d,a
4638 d44142    call    nc,4241h
463b 28d4      jr      z,4611h
463d 4f        ld      c,a
463e c64e      add     a,4eh
4640 d5        push    de
4641 53        ld      d,e
4642 49        ld      c,c
4643 4e        ld      c,(hl)
4644 47        ld      b,a
4645 d641      sub     41h
4647 52        ld      d,d
4648 50        ld      d,b
4649 54        ld      d,h
464a 52        ld      d,d
464b d5        push    de
464c 53        ld      d,e
464d 52        ld      d,d
464e c5        push    bc
464f 52        ld      d,d
4650 4c        ld      c,h
4651 c5        push    bc
4652 52        ld      d,d
4653 52        ld      d,d
4654 d354      out     (54h),a
4656 52        ld      d,d
4657 49        ld      c,c
4658 4e        ld      c,(hl)
4659 47        ld      b,a
465a 24        inc     h
465b c9        ret     
465c 4e        ld      c,(hl)
465d 53        ld      d,e
465e 54        ld      d,h
465f 52        ld      d,d
4660 d0        ret     nc
4661 4f        ld      c,a
4662 49        ld      c,c
4663 4e        ld      c,(hl)
4664 54        ld      d,h
4665 d4494d    call    nc,4d49h
4668 45        ld      b,l
4669 24        inc     h
466a cd454d    call    4d45h
466d c9        ret     
466e 4e        ld      c,(hl)
466f 4b        ld      c,e
4670 45        ld      b,l
4671 59        ld      e,c
4672 24        inc     h
4673 d44845    call    nc,4548h
4676 4e        ld      c,(hl)
4677 ce4f      adc     a,4fh
4679 54        ld      d,h
467a d354      out     (54h),a
467c 45        ld      b,l
467d 50        ld      d,b
467e ab        xor     e
467f ad        xor     l
4680 aa        xor     d
4681 af        xor     a
4682 dec1      sbc     a,0c1h
4684 4e        ld      c,(hl)
4685 44        ld      b,h
4686 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4687 52        ld      d,d
4688 be        cp      (hl)
4689 bd        cp      l
468a bc        cp      h
468b d347      out     (47h),a
468d 4e        ld      c,(hl)
468e c9        ret     
468f 4e        ld      c,(hl)
4690 54        ld      d,h
4691 c1        pop     bc
4692 42        ld      b,d
4693 53        ld      d,e
4694 c652      add     a,52h
4696 45        ld      b,l
4697 c9        ret     
4698 4e        ld      c,(hl)
4699 50        ld      d,b
469a d0        ret     nc
469b 4f        ld      c,a
469c 53        ld      d,e
469d d351      out     (51h),a
469f 52        ld      d,d
46a0 d24e44    jp      nc,444eh
46a3 cc4f47    call    z,474fh
46a6 c5        push    bc
46a7 58        ld      e,b
46a8 50        ld      d,b
46a9 c34f53    jp      534fh
46ac d349      out     (49h),a
46ae 4e        ld      c,(hl)
46af d4414e    call    nc,4e41h
46b2 c1        pop     bc
46b3 54        ld      d,h
46b4 4e        ld      c,(hl)
46b5 d0        ret     nc
46b6 45        ld      b,l
46b7 45        ld      b,l
46b8 4b        ld      c,e
46b9 d650      sub     50h
46bb 45        ld      b,l
46bc 45        ld      b,l
46bd 4b        ld      c,e
46be d0        ret     nc
46bf 45        ld      b,l
46c0 4e        ld      c,(hl)
46c1 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
46c2 50        ld      d,b
46c3 4b        ld      c,e
46c4 c5        push    bc
46c5 4f        ld      c,a
46c6 46        ld      b,(hl)
46c7 ca534b    jp      z,4b53h
46ca ca554d    jp      z,4d55h
46cd 50        ld      d,b
46ce c44547    call    nz,4745h
46d1 cd504b    call    4b50h
46d4 24        inc     h
46d5 d24144    jp      nc,4441h
46d8 c3494e    jp      4e49h
46db 54        ld      d,h
46dc c3534e    jp      4e53h
46df 47        ld      b,a
46e0 c34442    jp      4244h
46e3 4c        ld      c,h
46e4 c649      add     a,49h
46e6 58        ld      e,b
46e7 cc454e    call    z,4e45h
46ea d354      out     (54h),a
46ec 52        ld      d,d
46ed 24        inc     h
46ee d641      sub     41h
46f0 4c        ld      c,h
46f1 c1        pop     bc
46f2 53        ld      d,e
46f3 43        ld      b,e
46f4 c34852    jp      5248h
46f7 24        inc     h
46f8 cc4546    call    z,4645h
46fb 54        ld      d,h
46fc 24        inc     h
46fd d24947    jp      nc,4749h
4700 48        ld      c,b
4701 54        ld      d,h
4702 24        inc     h
4703 cd4944    call    4449h
4706 24        inc     h
4707 a7        and     a
4708 80        add     a,b
4709 00        nop     
470a 99        sbc     a,c
470b 2c        inc     l
470c 8b        adc     a,e
470d 2b        dec     hl
470e ca0dbf    jp      z,0bf0dh
4711 0d        dec     c
4712 c8        ret     z
4713 04        inc     b
4714 42        ld      b,d
4715 3f        ccf     
4716 27        daa     
4717 0d        dec     c
4718 aa        xor     d
4719 31f02d    ld      sp,2df0h
471c 85        add     a,l
471d 30fc      jr      nc,471bh
471f 34        inc     (hl)
4720 da300c    jp      c,0c30h
4723 2ead      ld      l,0adh
4725 2d        dec     l
4726 8e        adc     a,(hl)
4727 2d        dec     l
4728 24        inc     h
4729 2f        cpl     
472a 42        ld      b,d
472b 3f        ccf     
472c 9c        sbc     a,h
472d 2d        dec     l
472e c9        ret     
472f 2d        dec     l
4730 f22d94    jp      p,942dh
4733 2c        inc     l
4734 f22de2    jp      p,0e22dh
4737 2c        inc     l
4738 e3        ex      (sp),hl
4739 2c        inc     l
473a eb        ex      de,hl
473b 2c        inc     l
473c ee2c      xor     2ch
473e f1        pop     af
473f 2c        inc     l
4740 f42c96    call    p,962ch
4743 0c        inc     c
4744 5e        ld      e,(hl)
4745 3d        dec     a
4746 df        rst     18h            ; DCOMPR - Compare HL with DE.
4747 2e9a      ld      l,9ah
4749 2eef      ld      l,0efh
474b 39        add     hl,sp
474c 57        ld      d,a
474d 2e48      ld      l,48h
474f 112d0d    ld      de,0d2dh
4752 1f        rra     
4753 14        inc     d
4754 82        add     a,d
4755 11423f    ld      de,3f42h
4758 42        ld      b,d
4759 3f        ccf     
475a 3b        dec     sp
475b 15        dec     d
475c 42        ld      b,d
475d 3f        ccf     
475e 42        ld      b,d
475f 3f        ccf     
4760 42        ld      b,d
4761 3f        ccf     
4762 42        ld      b,d
4763 3f        ccf     
4764 42        ld      b,d
4765 3f        ccf     
4766 e20e52    jp      po,520eh
4769 2f        cpl     
476a 42        ld      b,d
476b 3f        ccf     
476c af        xor     a
476d 3b        dec     sp
476e 5a        ld      e,d
476f 2f        cpl     
4770 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4771 2c        inc     l
4772 223a1d    ld      (1d3ah),hl
4775 3aba3a    ld      a,(3abah)
4778 f3        di      
4779 2e65      ld      l,65h
477b 2d        dec     l
477c 183b      jr      47b9h
477e e9        jp      (hl)
477f 3a332a    ld      a,(2a33h)
4782 79        ld      a,c
4783 79        ld      a,c
4784 7c        ld      a,h
4785 7c        ld      a,h
4786 7f        ld      a,a
4787 50        ld      d,b
4788 46        ld      b,(hl)
4789 45        ld      b,l
478a 19        add     hl,de
478b 00        nop     
478c 00        nop     
478d e9        jp      (hl)
478e 185e      jr      47eeh
4790 19        add     hl,de
4791 1b        dec     de
4792 19        add     hl,de
4793 e1        pop     hl
4794 1a        ld      a,(de)
4795 da1a0b    jp      c,0b1ah
4798 1c        inc     e
4799 4f        ld      c,a
479a 1c        inc     e
479b e21880    jp      po,8018h
479e 15        dec     d
479f 7d        ld      a,l
47a0 15        dec     d
47a1 b1        or      c
47a2 160c      ld      d,0ch
47a4 17        rla     
47a5 76        halt    
47a6 183c      jr      47e4h
47a8 1a        ld      a,(de)
47a9 311a5c    ld      sp,5c1ah
47ac 1a        ld      a,(de)
47ad 84        add     a,h
47ae 33        inc     sp
47af a3        and     e
47b0 184e      jr      4800h
47b2 46        ld      b,(hl)
47b3 53        ld      d,e
47b4 4e        ld      c,(hl)
47b5 52        ld      d,d
47b6 47        ld      b,a
47b7 4f        ld      c,a
47b8 44        ld      b,h
47b9 46        ld      b,(hl)
47ba 43        ld      b,e
47bb 4f        ld      c,a
47bc 56        ld      d,(hl)
47bd 4f        ld      c,a
47be 4d        ld      c,l
47bf 55        ld      d,l
47c0 4c        ld      c,h
47c1 42        ld      b,d
47c2 53        ld      d,e
47c3 44        ld      b,h
47c4 44        ld      b,h
47c5 2f        cpl     
47c6 3049      jr      nc,4811h
47c8 44        ld      b,h
47c9 54        ld      d,h
47ca 4d        ld      c,l
47cb 4f        ld      c,a
47cc 53        ld      d,e
47cd 4c        ld      c,h
47ce 53        ld      d,e
47cf 53        ld      d,e
47d0 54        ld      d,h
47d1 43        ld      b,e
47d2 4e        ld      c,(hl)
47d3 4e        ld      c,(hl)
47d4 52        ld      d,d
47d5 52        ld      d,d
47d6 57        ld      d,a
47d7 55        ld      d,l
47d8 45        ld      b,l
47d9 4d        ld      c,l
47da 4f        ld      c,a
47db 46        ld      b,(hl)
47dc 44        ld      b,h
47dd 4c        ld      c,h
47de 33        inc     sp
47df 46        ld      b,(hl)
47e0 4e        ld      c,(hl)
47e1 d600      sub     00h
47e3 6f        ld      l,a
47e4 7c        ld      a,h
47e5 de00      sbc     a,00h
47e7 67        ld      h,a
47e8 78        ld      a,b
47e9 de00      sbc     a,00h
47eb 47        ld      b,a
47ec 3e00      ld      a,00h
47ee c9        ret     
47ef 35        dec     (hl)
47f0 2d        dec     l
47f1 40        ld      b,b
47f2 e64d      and     4dh
47f4 db00      in      a,(00h)
47f6 c9        ret     
47f7 d300      out     (00h),a
47f9 c9        ret     
47fa 00        nop     
47fb 00        nop     
47fc 00        nop     
47fd 00        nop     
47fe 50        ld      d,b
47ff 3800      jr      c,4801h
4801 be        cp      (hl)
4802 fb        ei      
4803 feff      cp      0ffh
4805 014020    ld      bc,2040h
4808 45        ld      b,l
4809 72        ld      (hl),d
480a 72        ld      (hl),d
480b 6f        ld      l,a
480c 72        ld      (hl),d
480d 00        nop     
480e 2069      jr      nz,4879h
4810 6e        ld      l,(hl)
4811 2000      jr      nz,4813h
4813 52        ld      d,d
4814 45        ld      b,l
4815 41        ld      b,c
4816 44        ld      b,h
4817 59        ld      e,c
4818 0d        dec     c
4819 00        nop     
481a 42        ld      b,d
481b 72        ld      (hl),d
481c 65        ld      h,l
481d 61        ld      h,c
481e 6b        ld      l,e
481f 00        nop     
4820 210400    ld      hl,0004h
4823 39        add     hl,sp
4824 7e        ld      a,(hl)
4825 23        inc     hl
4826 fe81      cp      81h
4828 c0        ret     nz
4829 4e        ld      c,(hl)
482a 23        inc     hl
482b 46        ld      b,(hl)
482c 23        inc     hl
482d e5        push    hl
482e 69        ld      l,c
482f 60        ld      h,b
4830 7a        ld      a,d
4831 b3        or      e
4832 eb        ex      de,hl
4833 2802      jr      z,4837h
4835 eb        ex      de,hl
4836 df        rst     18h            ; DCOMPR - Compare HL with DE.
4837 010e00    ld      bc,000eh
483a e1        pop     hl
483b c8        ret     z
483c 09        add     hl,bc
483d 18e5      jr      4824h
483f cd5628    call    2856h
4842 c5        push    bc
4843 e3        ex      (sp),hl
4844 c1        pop     bc
4845 df        rst     18h            ; DCOMPR - Compare HL with DE.
4846 7e        ld      a,(hl)
4847 02        ld      (bc),a
4848 c8        ret     z
4849 0b        dec     bc
484a 2b        dec     hl
484b 18f8      jr      4845h
484d e5        push    hl
484e 2a1dfe    ld      hl,(0fe1dh)        ; ARREND - Starting address of free space list (FSL)
4851 0600      ld      b,00h
4853 09        add     hl,bc
4854 09        add     hl,bc
4855 3ee5      ld      a,0e5h
4857 3ec6      ld      a,0c6h
4859 95        sub     l
485a 6f        ld      l,a
485b 3eff      ld      a,0ffh
485d 9c        sbc     a,h
485e 3804      jr      c,4864h
4860 67        ld      h,a
4861 39        add     hl,sp
4862 e1        pop     hl
4863 d8        ret     c
4864 1e0c      ld      e,0ch
4866 1824      jr      488ch
4868 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
486b 7c        ld      a,h
486c a5        and     l
486d 3c        inc     a
486e 2808      jr      z,4878h
4870 3a12fe    ld      a,(0fe12h)        ; Flag. FF during on error processing cleared by resume routine
4873 b7        or      a
4874 1e22      ld      e,22h
4876 2014      jr      nz,488ch
4878 c3ac2c    jp      2cach
487b 2afafd    ld      hl,(0fdfah)        ; Line No.  of last data statement
487e 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
4881 1e02      ld      e,02h
4883 011e14    ld      bc,141eh
4886 011e00    ld      bc,001eh
4889 011e24    ld      bc,241eh
488c 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
488f 220afe    ld      (0fe0ah),hl            ; ERRLIN: Line No. in which error occured.
4892 220cfe    ld      (0fe0ch),hl            ; Line No. in which error occured.
4895 019e28    ld      bc,289eh
4898 2a08fe    ld      hl,(0fe08h)            ; During execution: stack pointer value when statement execution begins.
489b c3842a    jp      2a84h

489e c1        pop     bc
489f 7b        ld      a,e
48a0 4b        ld      c,e
48a1 324efc    ld      (0fc4eh),a            ; ERRFLG
48a4 2a06fe    ld      hl,(0fe06h)            ; SAVTXT (During input:  ADDR of code string for current statement)
48a7 220efe    ld      (0fe0eh),hl            ; ERRTXT
48aa eb        ex      de,hl
48ab 2a0afe    ld      hl,(0fe0ah)            ; ERRLIN: Line No. in which error occured.
48ae 7c        ld      a,h
48af a5        and     l
48b0 3c        inc     a
48b1 2807      jr      z,48bah
48b3 2215fe    ld      (0fe15h),hl            ; OLDLIN: Last line number executed saved by stop/end
48b6 eb        ex      de,hl
48b7 2217fe    ld      (0fe17h),hl            ; OLDTXT: Addr of last byte executed during error
48ba 2a10fe    ld      hl,(0fe10h)            ; ONELIN: LINE to go when 'on error' event happens
48bd 7c        ld      a,h
48be b5        or      l
48bf eb        ex      de,hl
48c0 2112fe    ld      hl,0fe12h            ; ONEFLG
48c3 2808      jr      z,48cdh                ; ERROR_REPORT
48c5 a6        and     (hl)
48c6 2005      jr      nz,48cdh                ; ERROR_REPORT
48c8 35        dec     (hl)
48c9 eb        ex      de,hl
48ca c3202c    jp      2c20h

; ERROR_REPORT:
48cd af        xor     a
48ce 77        ld      (hl),a
48cf 59        ld      e,c
48d0 cde42f    call    2fe4h        ; CONSOLE_CRLF
48d3 21b127    ld      hl,27b1h        ; ERROR_MESSAGES
48d6 cda5fe    call    0fea5h
48d9 57        ld      d,a
48da 3e3f      ld      a,3fh        ; '?'
48dc cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
48df 19        add     hl,de
48e0 7e        ld      a,(hl)
48e1 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
48e4 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
48e5 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
48e8 210728    ld      hl,2807h
48eb e5        push    hl
48ec 2a0afe    ld      hl,(0fe0ah)        ; ERRLIN: Line No. in which error occured.
48ef e3        ex      (sp),hl
48f0 cd9b37    call    379bh			; Output a string
48f3 e1        pop     hl
48f4 11feff    ld      de,0fffeh
48f7 df        rst     18h                ; DCOMPR - Compare HL with DE.
48f8 ca0001    jp      z,0100h
48fb 7c        ld      a,h
48fc a5        and     l
48fd 3c        inc     a
48fe c4111e    call    nz,1e11h            ; LNUM_MSG
4901 3ec1      ld      a,0c1h
4903 cd200c    call    0c20h
4906 cdabfe    call    0feabh
4909 cd8007    call    0780h			; Cassette off routine
490c cde42f    call    2fe4h            ; CONSOLE_CRLF
490f 211328    ld      hl,2813h
4912 cd9b37    call    379bh			; Output a string
4915 3a4efc    ld      a,(0fc4eh)        ; ERRFLG:  ERROR FLAG
4918 d602      sub     02h
491a cc513d    call    z,3d51h
491d 21ffff    ld      hl,0ffffh
4920 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
4923 3a01fe    ld      a,(0fe01h)        ; AUTFLG: Auto increment flag 0 = no auto mode, otherwise line number
4926 b7        or      a
4927 2837      jr      z,4960h
4929 2a02fe    ld      hl,(0fe02h)        ; AUTLIN: Current line number in binary (during input phase)
492c e5        push    hl
492d cd191e    call    1e19h
4930 d1        pop     de
4931 d5        push    de
4932 cd162a    call    2a16h            ; FIND_LNUM - Search for line number
4935 3e2a      ld      a,2ah
4937 3802      jr      c,493bh
4939 3e20      ld      a,20h
493b cda00b    call    0ba0h            ; OUTC (alias OUTDO): print character
493e cdfa08    call    08fah            ; Console line input routine
4941 d1        pop     de
4942 3006      jr      nc,494ah
4944 af        xor     a
4945 3201fe    ld      (0fe01h),a        ; AUTFLG: Auto increment flag 0 = no auto mode, otherwise line number
4948 18b9      jr      4903h

494a 2a04fe    ld      hl,(0fe04h)        ; AUTINC: Auto line increment
494d 19        add     hl,de
494e 38f4      jr      c,4944h
4950 d5        push    de
4951 11f9ff    ld      de,0fff9h
4954 df        rst     18h                ; DCOMPR - Compare HL with DE.
4955 d1        pop     de
4956 30ec      jr      nc,4944h
4958 2202fe    ld      (0fe02h),hl        ; AUTLIN: Current line number in binary (during input phase)
495b f6ff      or      0ffh
495d c3e93e    jp      3ee9h
4960 3e3e      ld      a,3eh
4962 cda00b    call    0ba0h            ; OUTC (alias OUTDO): print character
4965 cdfa08    call    08fah            ; Console line input routine
4968 da1d29    jp      c,291dh            ; PROMPT
496b d7        rst     10h                ; CHRGTB: Gets next character (or token) from BASIC text.
496c 3c        inc     a
496d 3d        dec     a
496e ca1d29    jp      z,291dh            ; PROMPT
4971 f5        push    af
4972 cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
4975 2b        dec     hl
4976 7e        ld      a,(hl)
4977 fe20      cp      20h
4979 28fa      jr      z,4975h
497b 23        inc     hl
497c 7e        ld      a,(hl)
497d fe20      cp      20h
497f cc3318    call    z,1833h        ; INCHL
4982 d5        push    de
4983 cdaa2a    call    2aaah
4986 d1        pop     de
4987 f1        pop     af
4988 2206fe    ld      (0fe06h),hl        ; SAVTXT (During input:  ADDR of code string for current statement)
498b cdb1fe    call    0feb1h
498e d2442c    jp      nc,2c44h
4991 d5        push    de
4992 c5        push    bc
4993 af        xor     a
4994 32fdfd    ld      (0fdfdh),a    ; Read flag: 0 = read statement active
4997 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4998 b7        or      a
4999 f5        push    af
499a eb        ex      de,hl
499b 220cfe    ld      (0fe0ch),hl    ; Line No. in which error occured.
499e eb        ex      de,hl
499f cd162a    call    2a16h        ; FIND_LNUM - Search for line number
49a2 c5        push    bc
49a3 dcd83a    call    c,3ad8h
49a6 d1        pop     de
49a7 f1        pop     af
49a8 d5        push    de
49a9 2827      jr      z,49d2h
49ab d1        pop     de
49ac 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
49af e3        ex      (sp),hl
49b0 c1        pop     bc
49b1 09        add     hl,bc
49b2 e5        push    hl
49b3 cd3f28    call    283fh
49b6 e1        pop     hl
49b7 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
49ba eb        ex      de,hl
49bb 74        ld      (hl),h
49bc d1        pop     de
49bd e5        push    hl
49be 23        inc     hl
49bf 23        inc     hl
49c0 73        ld      (hl),e
49c1 23        inc     hl
49c2 72        ld      (hl),d
49c3 23        inc     hl
49c4 eb        ex      de,hl
49c5 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
49c8 eb        ex      de,hl
49c9 1b        dec     de
49ca 1b        dec     de
49cb 1a        ld      a,(de)
49cc 77        ld      (hl),a
49cd 23        inc     hl
49ce 13        inc     de
49cf b7        or      a
49d0 20f9      jr      nz,49cbh
49d2 d1        pop     de
49d3 cde629    call    29e6h
49d6 cdb4fe    call    0feb4h
49d9 cd472a    call    2a47h
49dc cdb7fe    call    0feb7h
49df c31d29    jp      291dh            ; PROMPT

49e2 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
49e5 eb        ex      de,hl
49e6 62        ld      h,d
49e7 6b        ld      l,e
49e8 7e        ld      a,(hl)
49e9 23        inc     hl
49ea b6        or      (hl)
49eb c8        ret     z
49ec 23        inc     hl
49ed 23        inc     hl
49ee 23        inc     hl
49ef af        xor     a
49f0 be        cp      (hl)
49f1 23        inc     hl
49f2 20fc      jr      nz,49f0h
49f4 eb        ex      de,hl
49f5 73        ld      (hl),e
49f6 23        inc     hl
49f7 72        ld      (hl),d
49f8 18ec      jr      49e6h
49fa 110000    ld      de,0000h
49fd d5        push    de
49fe 2809      jr      z,4a09h
4a00 d1        pop     de
4a01 cd3a2d    call    2d3ah        ; LNUM_PARM - Get specified line number
4a04 d5        push    de
4a05 280b      jr      z,4a12h
4a07 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4a08 ce11      adc     a,11h
4a0a faffc4    jp      m,0c4ffh
4a0d 3a2dc2    ld      a,(0c22dh)
4a10 81        add     a,c
4a11 28eb      jr      z,49feh
4a13 d1        pop     de
4a14 e3        ex      (sp),hl
4a15 e5        push    hl
4a16 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
4a19 44        ld      b,h
4a1a 4d        ld      c,l
4a1b 7e        ld      a,(hl)
4a1c 23        inc     hl
4a1d b6        or      (hl)
4a1e 2b        dec     hl
4a1f c8        ret     z
4a20 23        inc     hl
4a21 23        inc     hl
4a22 7e        ld      a,(hl)
4a23 23        inc     hl
4a24 66        ld      h,(hl)
4a25 6f        ld      l,a
4a26 df        rst     18h            ; DCOMPR - Compare HL with DE.
4a27 60        ld      h,b
4a28 69        ld      l,c
4a29 7e        ld      a,(hl)
4a2a 23        inc     hl
4a2b 66        ld      h,(hl)
4a2c 6f        ld      l,a
4a2d 3f        ccf     
4a2e c8        ret     z
4a2f 3f        ccf     
4a30 d0        ret     nc
4a31 18e6      jr      4a19h
4a33 c0        ret     nz
4a34 cdc804    call    04c8h
4a37 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
4a3a cde32c    call    2ce3h
4a3d 3201fe    ld      (0fe01h),a    ; AUTFLG: Auto increment flag 0 = no auto mode, otherwise line number
4a40 77        ld      (hl),a
4a41 23        inc     hl
4a42 77        ld      (hl),a
4a43 23        inc     hl
4a44 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
4a47 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
4a4a 2b        dec     hl
4a4b 22fffd    ld      (0fdffh),hl
4a4e 061a      ld      b,1ah
4a50 2121fe    ld      hl,0fe21h        ; Variable declaration list. 26 entries, each containing a code inicating default mode for that initial letter
4a53 3604      ld      (hl),04h
4a55 23        inc     hl
4a56 10fb      djnz    4a53h
4a58 af        xor     a
4a59 3212fe    ld      (0fe12h),a
4a5c 6f        ld      l,a
4a5d 67        ld      h,a
4a5e 2210fe    ld      (0fe10h),hl
4a61 2217fe    ld      (0fe17h),hl        ; OLDTXT: Addr of last byte executed during error
4a64 2ad1fd    ld      hl,(0fdd1h)        ; Memory size
4a67 22f6fd    ld      (0fdf6h),hl        ; Pointer to next available loc. in string area.
4a6a cd7b2c    call    2c7bh
4a6d 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
4a70 221bfe    ld      (0fe1bh),hl        ; VAREND: Addr of dimensioned variables
4a73 221dfe    ld      (0fe1dh),hl        ; ARREND - Starting address of free space list (FSL)
4a76 cda211    call    11a2h
4a79 c1        pop     bc
4a7a 2a54fc    ld      hl,(0fc54h)        ; Address of string area boundary
4a7d 2b        dec     hl
4a7e 2b        dec     hl
4a7f 2208fe    ld      (0fe08h),hl        ; During execution: stack pointer value when statement execution begins.
4a82 23        inc     hl
4a83 23        inc     hl
4a84 f9        ld      sp,hl
4a85 21d5fd    ld      hl,0fdd5h        ; TEMPST: LSPT (literal string pool table)
4a88 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
4a8b cd200c    call    0c20h
4a8e cd5430    call    3054h
4a91 af        xor     a
4a92 67        ld      h,a
4a93 6f        ld      l,a
4a94 32fcfd    ld      (0fdfch),a        ; FOR flag (1 = 'for' in progress, 0 =  no 'for' in progress)
4a97 e5        push    hl
4a98 c5        push    bc
4a99 2afffd    ld      hl,(0fdffh)
4a9c c9        ret     
4a9d 3e3f      ld      a,3fh
4a9f cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
4aa2 3e20      ld      a,20h
4aa4 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
4aa7 c3fa08    jp      08fah    ; Console line input routine

4aaa af        xor     a
4aab 32d0fd    ld      (0fdd0h),a
4aae 4f        ld      c,a
4aaf eb        ex      de,hl
4ab0 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
4ab3 2b        dec     hl
4ab4 2b        dec     hl
4ab5 eb        ex      de,hl
4ab6 7e        ld      a,(hl)
4ab7 fe20      cp      20h
4ab9 ca452b    jp      z,2b45h
4abc 47        ld      b,a
4abd fe22      cp      22h
4abf ca612b    jp      z,2b61h
4ac2 b7        or      a
4ac3 ca672b    jp      z,2b67h
4ac6 3ad0fd    ld      a,(0fdd0h)
4ac9 b7        or      a
4aca 7e        ld      a,(hl)
4acb c2452b    jp      nz,2b45h
4ace fe3f      cp      3fh
4ad0 3eb2      ld      a,0b2h
4ad2 ca452b    jp      z,2b45h
4ad5 7e        ld      a,(hl)
4ad6 fe30      cp      30h
4ad8 3805      jr      c,4adfh
4ada fe3c      cp      3ch
4adc da452b    jp      c,2b45h
4adf d5        push    de
4ae0 112d25    ld      de,252dh
4ae3 c5        push    bc
4ae4 01272b    ld      bc,2b27h
4ae7 c5        push    bc
4ae8 067f      ld      b,7fh
4aea 7e        ld      a,(hl)
4aeb fe61      cp      61h
4aed 3807      jr      c,4af6h
4aef fe7b      cp      7bh
4af1 3003      jr      nc,4af6h
4af3 e65f      and     5fh
4af5 77        ld      (hl),a
4af6 4e        ld      c,(hl)
4af7 eb        ex      de,hl
4af8 23        inc     hl
4af9 b6        or      (hl)
4afa f2f82a    jp      p,2af8h
4afd 04        inc     b
4afe 7e        ld      a,(hl)
4aff e67f      and     7fh
4b01 c8        ret     z
4b02 b9        cp      c
4b03 20f3      jr      nz,4af8h
4b05 eb        ex      de,hl
4b06 e5        push    hl
4b07 13        inc     de
4b08 1a        ld      a,(de)
4b09 b7        or      a
4b0a fa232b    jp      m,2b23h
4b0d 4f        ld      c,a
4b0e 78        ld      a,b
4b0f fe8d      cp      8dh
4b11 2002      jr      nz,4b15h
4b13 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4b14 2b        dec     hl
4b15 23        inc     hl
4b16 7e        ld      a,(hl)
4b17 fe61      cp      61h
4b19 3802      jr      c,4b1dh
4b1b e65f      and     5fh
4b1d b9        cp      c
4b1e 28e7      jr      z,4b07h
4b20 e1        pop     hl
4b21 18d3      jr      4af6h
4b23 48        ld      c,b
4b24 f1        pop     af
4b25 eb        ex      de,hl
4b26 c9        ret     
4b27 eb        ex      de,hl
4b28 79        ld      a,c
4b29 c1        pop     bc
4b2a d1        pop     de
4b2b eb        ex      de,hl
4b2c fe95      cp      95h
4b2e 363a      ld      (hl),3ah
4b30 2002      jr      nz,4b34h
4b32 0c        inc     c
4b33 23        inc     hl
4b34 fefb      cp      0fbh
4b36 200c      jr      nz,4b44h
4b38 363a      ld      (hl),3ah
4b3a 23        inc     hl
4b3b 0693      ld      b,93h
4b3d 70        ld      (hl),b
4b3e 23        inc     hl
4b3f eb        ex      de,hl
4b40 0c        inc     c
4b41 0c        inc     c
4b42 181d      jr      4b61h
4b44 eb        ex      de,hl
4b45 23        inc     hl
4b46 12        ld      (de),a
4b47 13        inc     de
4b48 0c        inc     c
4b49 d63a      sub     3ah
4b4b 2804      jr      z,4b51h
4b4d fe4e      cp      4eh
4b4f 2003      jr      nz,4b54h
4b51 32d0fd    ld      (0fdd0h),a
4b54 d659      sub     59h
4b56 c2b62a    jp      nz,2ab6h
4b59 47        ld      b,a
4b5a 7e        ld      a,(hl)
4b5b b7        or      a
4b5c 2809      jr      z,4b67h
4b5e b8        cp      b
4b5f 28e4      jr      z,4b45h
4b61 23        inc     hl
4b62 12        ld      (de),a
4b63 0c        inc     c
4b64 13        inc     de
4b65 18f3      jr      4b5ah
4b67 210500    ld      hl,0005h
4b6a 44        ld      b,h
4b6b 09        add     hl,bc
4b6c 44        ld      b,h
4b6d 4d        ld      c,l
4b6e 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
4b71 2b        dec     hl
4b72 2b        dec     hl
4b73 2b        dec     hl
4b74 12        ld      (de),a
4b75 13        inc     de
4b76 12        ld      (de),a
4b77 13        inc     de
4b78 12        ld      (de),a
4b79 c9        ret     
4b7a 7c        ld      a,h
4b7b 92        sub     d
4b7c c0        ret     nz
4b7d 7d        ld      a,l
4b7e 93        sub     e
4b7f c9        ret     
4b80 7e        ld      a,(hl)
4b81 e3        ex      (sp),hl
4b82 be        cp      (hl)
4b83 23        inc     hl
4b84 e3        ex      (sp),hl
4b85 ca622c    jp      z,2c62h
4b88 c38128    jp      2881h            ; Syntax Error (SN ERROR)

; __FOR:
4b8b 3e64      ld      a,64h
4b8d 32fcfd    ld      (0fdfch),a        ; FOR flag (1 = 'for' in progress, 0 =  no 'for' in progress)
4b90 cd0c2e    call    2e0ch
4b93 e3        ex      (sp),hl
4b94 cd2028    call    2820h
4b97 d1        pop     de
4b98 2005      jr      nz,4b9fh
4b9a 09        add     hl,bc
4b9b f9        ld      sp,hl
4b9c 2208fe    ld      (0fe08h),hl            ; During execution: stack pointer value when statement execution begins.
4b9f eb        ex      de,hl
4ba0 0e08      ld      c,08h
4ba2 cd4d28    call    284dh
4ba5 e5        push    hl
4ba6 cdf02d    call    2df0h
4ba9 e3        ex      (sp),hl
4baa e5        push    hl
4bab 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
4bae e3        ex      (sp),hl
4baf cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4bb0 bd        cp      l
4bb1 e7        rst     20h			; GETYPR - Get the number type (FAC)
4bb2 ca6019    jp      z,1960h
4bb5 d26019    jp      nc,1960h
4bb8 f5        push    af
4bb9 cd2b32    call    322bh			; EVAL
4bbc f1        pop     af
4bbd e5        push    hl
4bbe f2d62b    jp      p,2bd6h
4bc1 cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
4bc4 e3        ex      (sp),hl
4bc5 110100    ld      de,0001h
4bc8 7e        ld      a,(hl)
4bc9 fecc      cp      0cch
4bcb ccf539    call    z,39f5h
4bce d5        push    de
4bcf e5        push    hl
4bd0 eb        ex      de,hl
4bd1 cd0818    call    1808h
4bd4 1822      jr      4bf8h
4bd6 cd1b19    call    191bh
4bd9 cd2918    call    1829h
4bdc e1        pop     hl
4bdd c5        push    bc
4bde d5        push    de
4bdf 010081    ld      bc,8100h
4be2 51        ld      d,c
4be3 5a        ld      e,d
4be4 7e        ld      a,(hl)
4be5 fecc      cp      0cch
4be7 3e01      ld      a,01h
4be9 200e      jr      nz,4bf9h
4beb cd2c32    call    322ch
4bee e5        push    hl
4bef cd1b19    call    191bh
4bf2 cd2918    call    1829h
4bf5 cdbf17    call    17bfh
4bf8 e1        pop     hl
4bf9 c5        push    bc
4bfa d5        push    de
4bfb 4f        ld      c,a
4bfc e7        rst     20h			; GETYPR - Get the number type (FAC)
4bfd 47        ld      b,a
4bfe c5        push    bc
4bff e5        push    hl
4c00 2afffd    ld      hl,(0fdffh)
4c03 e3        ex      (sp),hl
4c04 0681      ld      b,81h
4c06 c5        push    bc
4c07 33        inc     sp
4c08 cda309    call    09a3h
4c0b b7        or      a
4c0c c48a2c    call    nz,2c8ah
4c0f 2206fe    ld      (0fe06h),hl        ; SAVTXT (During input:  ADDR of code string for current statement)
4c12 ed7308fe  ld      (0fe08h),sp            ; During execution: stack pointer value when statement execution begins.
4c16 7e        ld      a,(hl)
4c17 fe3a      cp      3ah
4c19 2829      jr      z,4c44h
4c1b b7        or      a
4c1c c28128    jp      nz,2881h            ; Syntax Error (SN ERROR)
4c1f 23        inc     hl
4c20 7e        ld      a,(hl)
4c21 23        inc     hl
4c22 b6        or      (hl)
4c23 ca6828    jp      z,2868h
4c26 23        inc     hl
4c27 5e        ld      e,(hl)
4c28 23        inc     hl
4c29 56        ld      d,(hl)
4c2a eb        ex      de,hl
4c2b 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
4c2e 3a3bfe    ld      a,(0fe3bh)        ; TRCFLG - Trace flag (0 = No trace, Non-zero = trace)
4c31 b7        or      a
4c32 280f      jr      z,4c43h
4c34 d5        push    de
4c35 3e3c      ld      a,3ch
4c37 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
4c3a cd191e    call    1e19h
4c3d 3e3e      ld      a,3eh
4c3f cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
4c42 d1        pop     de
4c43 eb        ex      de,hl
4c44 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4c45 11082c    ld      de,2c08h
4c48 d5        push    de
4c49 c8        ret     z
4c4a d680      sub     80h
4c4c da0c2e    jp      c,2e0ch
4c4f fe3c      cp      3ch
4c51 d2db39    jp      nc,39dbh
4c54 07        rlca    
4c55 4f        ld      c,a
4c56 0600      ld      b,00h
4c58 eb        ex      de,hl
4c59 210a27    ld      hl,270ah
4c5c 09        add     hl,bc
4c5d 4e        ld      c,(hl)
4c5e 23        inc     hl
4c5f 46        ld      b,(hl)
4c60 c5        push    bc
4c61 eb        ex      de,hl
4c62 23        inc     hl
4c63 7e        ld      a,(hl)
4c64 fe3a      cp      3ah
4c66 d0        ret     nc
4c67 fe20      cp      20h
4c69 ca622c    jp      z,2c62h
4c6c fe0b      cp      0bh
4c6e 3005      jr      nc,4c75h
4c70 fe09      cp      09h
4c72 d2622c    jp      nc,2c62h
4c75 fe30      cp      30h
4c77 3f        ccf     
4c78 3c        inc     a
4c79 3d        dec     a
4c7a c9        ret

4c7b eb        ex      de,hl
4c7c 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
4c7f 2b        dec     hl
4c80 221ffe    ld      (0fe1fh),hl        ; Points to byte following last char
4c83 eb        ex      de,hl
4c84 c9        ret

4c85 cda309    call    09a3h
4c88 b7        or      a
4c89 c8        ret     z
4c8a fe60      cp      60h
4c8c ccac09    call    z,09ach        ; Console input routine
4c8f 324dfc    ld      (0fc4dh),a    ; Holds last character typed after break
4c92 fe03      cp      03h
4c94 c0        ret     nz
4c95 3c        inc     a
4c96 c39f2c    jp      2c9fh

4c99 c0        ret     nz
4c9a f5        push    af
4c9b cca211    call    z,11a2h
4c9e f1        pop     af
4c9f 2206fe    ld      (0fe06h),hl        ; SAVTXT (During input:  ADDR of code string for current statement)
4ca2 21d5fd    ld      hl,0fdd5h        ; TEMPST: LSPT (literal string pool table)
4ca5 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
4ca8 21f6ff    ld      hl,0fff6h
4cab c1        pop     bc
4cac 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
4caf e5        push    hl
4cb0 f5        push    af
4cb1 7d        ld      a,l
4cb2 a4        and     h
4cb3 3c        inc     a
4cb4 2809      jr      z,4cbfh
4cb6 2215fe    ld      (0fe15h),hl        ; OLDLIN: Last line number executed saved by stop/end
4cb9 2a06fe    ld      hl,(0fe06h)        ; SAVTXT (During input:  ADDR of code string for current statement)
4cbc 2217fe    ld      (0fe17h),hl        ; OLDTXT: Addr of last byte executed during error
4cbf cd200c    call    0c20h
4cc2 cde42f    call    2fe4h            ; CONSOLE_CRLF
4cc5 f1        pop     af
4cc6 211a28    ld      hl,281ah
4cc9 c2f028    jp      nz,28f0h
4ccc c30229    jp      2902h

4ccf 2a17fe    ld      hl,(0fe17h)        ; OLDTXT: Addr of last byte executed during error
4cd2 7c        ld      a,h
4cd3 b5        or      l
4cd4 1e20      ld      e,20h
4cd6 ca8c28    jp      z,288ch            ; ERROR, E=error code
4cd9 eb        ex      de,hl
4cda 2a15fe    ld      hl,(0fe15h)        ; OLDLIN: Last line number executed saved by stop/end
4cdd 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
4ce0 eb        ex      de,hl
4ce1 c9        ret

4ce2 3eaf      ld      a,0afh
4ce4 323bfe    ld      (0fe3bh),a        ; TRCFLG - Trace flag (0 = No trace, Non-zero = trace)
4ce7 c9        ret

4ce8 f1        pop     af
4ce9 e1        pop     hl
4cea c9        ret

4ceb 1e03      ld      e,03h
4ced 011e02    ld      bc,021eh
4cf0 011e04    ld      bc,041eh
4cf3 011e08    ld      bc,081eh
4cf6 cd282d    call    2d28h        ; IS_ALPHA_A
4cf9 018128    ld      bc,2881h        ; BC = {Syntax Error (SN ERROR)}
4cfc c5        push    bc
4cfd d8        ret     c
4cfe d641      sub     41h
4d00 4f        ld      c,a
4d01 47        ld      b,a
4d02 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d03 fece      cp      0ceh
4d05 2009      jr      nz,4d10h
4d07 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d08 cd282d    call    2d28h        ; IS_ALPHA_A
4d0b d8        ret     c
4d0c d641      sub     41h
4d0e 47        ld      b,a
4d0f d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d10 78        ld      a,b
4d11 91        sub     c
4d12 d8        ret     c
4d13 3c        inc     a
4d14 e3        ex      (sp),hl
4d15 2121fe    ld      hl,0fe21h    ; Variable declaration list. 26 entries, each containing a code inicating default mode for that initial letter
4d18 0600      ld      b,00h
4d1a 09        add     hl,bc
4d1b 73        ld      (hl),e
4d1c 23        inc     hl
4d1d 3d        dec     a
4d1e 20fb      jr      nz,4d1bh
4d20 e1        pop     hl
4d21 7e        ld      a,(hl)
4d22 fe2c      cp      ','
4d24 c0        ret     nz
4d25 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d26 18ce      jr      4cf6h
4d28 7e        ld      a,(hl)
4d29 fe41      cp      41h
4d2b d8        ret     c
4d2c fe5b      cp      5bh
4d2e 3f        ccf     
4d2f c9        ret

4d30 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d31 cdf639    call    39f6h        ; GETINT/EVAL
4d34 f0        ret     p
4d35 1e08      ld      e,08h
4d37 c38c28    jp      288ch        ; ERROR, E=error code

4d3a 7e        ld      a,(hl)
4d3b fe2e      cp      2eh
4d3d eb        ex      de,hl
4d3e 2a0cfe    ld      hl,(0fe0ch)    ; Line No. in which error occured.
4d41 eb        ex      de,hl
4d42 ca622c    jp      z,2c62h
4d45 2b        dec     hl
4d46 110000    ld      de,0000h
4d49 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d4a d0        ret     nc
4d4b e5        push    hl
4d4c f5        push    af
4d4d 219819    ld      hl,1998h
4d50 df        rst     18h            ; DCOMPR - Compare HL with DE.
4d51 da8128    jp      c,2881h            ; Syntax Error (SN ERROR)
4d54 62        ld      h,d
4d55 6b        ld      l,e
4d56 19        add     hl,de
4d57 29        add     hl,hl
4d58 19        add     hl,de
4d59 29        add     hl,hl
4d5a f1        pop     af
4d5b d630      sub     30h
4d5d 5f        ld      e,a
4d5e 1600      ld      d,00h
4d60 19        add     hl,de
4d61 eb        ex      de,hl
4d62 e1        pop     hl
4d63 18e4      jr      4d49h

4d65 ca4b2a    jp      z,2a4bh
4d68 cd312d    call    2d31h
4d6b 2b        dec     hl
4d6c d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4d6d c0        ret     nz
4d6e e5        push    hl
4d6f 2ad1fd    ld      hl,(0fdd1h)        ; Memory size
4d72 7d        ld      a,l
4d73 93        sub     e
4d74 5f        ld      e,a
4d75 7c        ld      a,h
4d76 9a        sbc     a,d
4d77 57        ld      d,a
4d78 da6428    jp      c,2864h
4d7b 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
4d7e 012800    ld      bc,0028h
4d81 09        add     hl,bc
4d82 df        rst     18h            ; DCOMPR - Compare HL with DE.
4d83 d26428    jp      nc,2864h
4d86 eb        ex      de,hl
4d87 2254fc    ld      (0fc54h),hl        ; Address of string area boundary
4d8a e1        pop     hl
4d8b c34b2a    jp      2a4bh
4d8e ca472a    jp      z,2a47h
4d91 cdc3fe    call    0fec3h
4d94 cd4b2a    call    2a4bh
4d97 01082c    ld      bc,2c08h
4d9a 1810      jr      4dach

4d9c 0e03      ld      c,03h
4d9e cd4d28    call    284dh
4da1 c1        pop     bc
4da2 e5        push    hl
4da3 e5        push    hl
4da4 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
4da7 e3        ex      (sp),hl
4da8 3e91      ld      a,91h
4daa f5        push    af
4dab 33        inc     sp
4dac c5        push    bc
4dad cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
4db0 cdf22d    call    2df2h
4db3 e5        push    hl
4db4 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
4db7 df        rst     18h            ; DCOMPR - Compare HL with DE.
4db8 e1        pop     hl
4db9 23        inc     hl
4dba dc192a    call    c,2a19h
4dbd d4162a    call    nc,2a16h        ; FIND_LNUM - Search for line number
4dc0 60        ld      h,b
4dc1 69        ld      l,c
4dc2 2b        dec     hl
4dc3 d8        ret     c
4dc4 1e0e      ld      e,0eh
4dc6 c38c28    jp      288ch        ; ERROR, E=error code

4dc9 c0        ret     nz
4dca 16ff      ld      d,0ffh
4dcc cd2028    call    2820h
4dcf f9        ld      sp,hl
4dd0 2208fe    ld      (0fe08h),hl            ; During execution: stack pointer value when statement execution begins.
4dd3 fe91      cp      91h
4dd5 1e04      ld      e,04h
4dd7 c28c28    jp      nz,288ch        ; ERROR, E=error code
4dda e1        pop     hl
4ddb 2256fc    ld      (0fc56h),hl    ; CURLIN: Current line number
4dde 23        inc     hl
4ddf 7c        ld      a,h
4de0 b5        or      l
4de1 2007      jr      nz,4deah
4de3 3afdfd    ld      a,(0fdfdh)    ; Read flag: 0 = read statement active
4de6 b7        or      a
4de7 c20229    jp      nz,2902h
4dea 21082c    ld      hl,2c08h
4ded e3        ex      (sp),hl
4dee 3ee1      ld      a,0e1h
4df0 013a0e    ld      bc,0e3ah
4df3 00        nop     
4df4 0600      ld      b,00h
4df6 79        ld      a,c
4df7 48        ld      c,b
4df8 47        ld      b,a
4df9 7e        ld      a,(hl)
4dfa b7        or      a
4dfb c8        ret     z
4dfc b8        cp      b
4dfd c8        ret     z
4dfe 23        inc     hl
4dff fe22      cp      22h
4e01 28f3      jr      z,4df6h
4e03 d68f      sub     8fh
4e05 20f2      jr      nz,4df9h
4e07 b8        cp      b
4e08 8a        adc     a,d
4e09 57        ld      d,a
4e0a 18ed      jr      4df9h

4e0c cd0135    call    3501h        ; GETVAR: Find address of variable
4e0f cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4e10 d5        push    de
4e11 eb        ex      de,hl
4e12 22fffd    ld      (0fdffh),hl
4e15 eb        ex      de,hl
4e16 d5        push    de
4e17 e7        rst     20h			; GETYPR - Get the number type (FAC)
4e18 f5        push    af
4e19 cd2b32    call    322bh			; EVAL
4e1c f1        pop     af
4e1d e3        ex      (sp),hl
4e1e c603      add     a,03h
4e20 cd0d37    call    370dh
4e23 cd6d18    call    186dh
4e26 e5        push    hl
4e27 2028      jr      nz,4e51h
4e29 2a41fe    ld      hl,(0fe41h)        ; FACCU
4e2c e5        push    hl
4e2d 23        inc     hl
4e2e 5e        ld      e,(hl)
4e2f 23        inc     hl
4e30 56        ld      d,(hl)
4e31 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
4e34 df        rst     18h            ; DCOMPR - Compare HL with DE.
4e35 300e      jr      nc,4e45h
4e37 2a54fc    ld      hl,(0fc54h)        ; Address of string area boundary
4e3a df        rst     18h            ; DCOMPR - Compare HL with DE.
4e3b d1        pop     de
4e3c 300f      jr      nc,4e4dh
4e3e 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
4e41 df        rst     18h            ; DCOMPR - Compare HL with DE.
4e42 3009      jr      nc,4e4dh
4e44 3ed1      ld      a,0d1h
4e46 cde938    call    38e9h
4e49 eb        ex      de,hl
4e4a cd3737    call    3737h
4e4d cde938    call    38e9h
4e50 e3        ex      (sp),hl
4e51 cd3d18    call    183dh
4e54 d1        pop     de
4e55 e1        pop     hl
4e56 c9        ret

4e57 fe9e      cp      9eh
4e59 2025      jr      nz,4e80h
4e5b d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4e5c cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4e5d 8d        adc     a,l
4e5e cd452d    call    2d45h        ; LNUM_PARM_0 - Get specified line number (2nd parameter)
4e61 7a        ld      a,d
4e62 b3        or      e
4e63 2809      jr      z,4e6eh
4e65 cd142a    call    2a14h
4e68 50        ld      d,b
4e69 59        ld      e,c
4e6a e1        pop     hl
4e6b d2c42d    jp      nc,2dc4h
4e6e eb        ex      de,hl
4e6f 2210fe    ld      (0fe10h),hl
4e72 eb        ex      de,hl
4e73 d8        ret     c
4e74 3a12fe    ld      a,(0fe12h)
4e77 b7        or      a
4e78 c8        ret     z
4e79 3a4efc    ld      a,(0fc4eh)            ; ERRFLG:  ERROR FLAG
4e7c 5f        ld      e,a
4e7d c39528    jp      2895h

4e80 cd103a    call    3a10h		; GETINT
4e83 7e        ld      a,(hl)
4e84 47        ld      b,a
4e85 fe91      cp      91h
4e87 2803      jr      z,4e8ch
4e89 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4e8a 8d        adc     a,l
4e8b 2b        dec     hl
4e8c 4b        ld      c,e
4e8d 0d        dec     c
4e8e 78        ld      a,b
4e8f ca4a2c    jp      z,2c4ah
4e92 cd462d    call    2d46h
4e95 fe2c      cp      ','
4e97 c0        ret     nz
4e98 18f3      jr      4e8dh
4e9a 1112fe    ld      de,0fe12h
4e9d 1a        ld      a,(de)
4e9e b7        or      a
4e9f ca8a28    jp      z,288ah
4ea2 3c        inc     a
4ea3 324efc    ld      (0fc4eh),a            ; ERRFLG:  ERROR FLAG
4ea6 12        ld      (de),a
4ea7 7e        ld      a,(hl)
4ea8 fe87      cp      87h
4eaa 280c      jr      z,4eb8h
4eac cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
4eaf c0        ret     nz
4eb0 7a        ld      a,d
4eb1 b3        or      e
4eb2 c2b02d    jp      nz,2db0h
4eb5 3c        inc     a
4eb6 1802      jr      4ebah
4eb8 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4eb9 c0        ret     nz
4eba 2a0efe    ld      hl,(0fe0eh)
4ebd eb        ex      de,hl
4ebe 2a0afe    ld      hl,(0fe0ah)            ; ERRLIN: Line No. in which error occured.
4ec1 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
4ec4 eb        ex      de,hl
4ec5 c0        ret     nz
4ec6 7e        ld      a,(hl)
4ec7 b7        or      a
4ec8 2004      jr      nz,4eceh
4eca 23        inc     hl
4ecb 23        inc     hl
4ecc 23        inc     hl
4ecd 23        inc     hl
4ece 23        inc     hl
4ecf 7a        ld      a,d
4ed0 a3        and     e
4ed1 3c        inc     a
4ed2 c2f02d    jp      nz,2df0h
4ed5 3afdfd    ld      a,(0fdfdh)        ; Read flag: 0 = read statement active
4ed8 3d        dec     a
4ed9 caa92c    jp      z,2ca9h
4edc c3f02d    jp      2df0h

4edf cd103a    call    3a10h		; GETINT
4ee2 c0        ret     nz
4ee3 b7        or      a
4ee4 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
4ee7 3d        dec     a
4ee8 87        add     a,a
4ee9 5f        ld      e,a
4eea fe2f      cp      2fh
4eec 3802      jr      c,4ef0h
4eee 1e26      ld      e,26h
4ef0 c38c28    jp      288ch        ; ERROR, E=error code

; __AUTO:
4ef3 110a00    ld      de,000ah
4ef6 d5        push    de
4ef7 2817      jr      z,4f10h
4ef9 cd3a2d    call    2d3ah        ; LNUM_PARM - Get specified line number
4efc eb        ex      de,hl
4efd e3        ex      (sp),hl
4efe 2811      jr      z,4f11h
4f00 eb        ex      de,hl
4f01 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4f02 2c        defb    ','
4f03 eb        ex      de,hl
4f04 2a04fe    ld      hl,(0fe04h)        ; AUTINC: Auto line increment
4f07 eb        ex      de,hl
4f08 2806      jr      z,4f10h
4f0a cd452d    call    2d45h            ; LNUM_PARM_0 - Get specified line number (2nd parameter)
4f0d c28128    jp      nz,2881h            ; Syntax Error (SN ERROR)
4f10 eb        ex      de,hl
4f11 7c        ld      a,h
4f12 b5        or      l
4f13 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
4f16 2204fe    ld      (0fe04h),hl        ; AUTINC: Auto line increment
4f19 3201fe    ld      (0fe01h),a        ; AUTFLG: Auto increment flag 0 = no auto mode, otherwise line number
4f1c e1        pop     hl
4f1d 2202fe    ld      (0fe02h),hl        ; AUTLIN: Current line number in binary (during input phase)
4f20 c1        pop     bc
4f21 c31d29    jp      291dh            ; PROMPT

4f24 cd2b32    call    322bh			; EVAL
4f27 7e        ld      a,(hl)
4f28 fe2c      cp      ','
4f2a cc622c    call    z,2c62h
4f2d feca      cp      0cah
4f2f cc622c    call    z,2c62h
4f32 2b        dec     hl
4f33 e5        push    hl
4f34 cdfe17    call    17feh
4f37 e1        pop     hl
4f38 2807      jr      z,4f41h
4f3a d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4f3b daad2d    jp      c,2dadh
4f3e c3492c    jp      2c49h

4f41 1601      ld      d,01h
4f43 cdf02d    call    2df0h
4f46 b7        or      a
4f47 c8        ret     z
4f48 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4f49 fe95      cp      95h
4f4b 20f6      jr      nz,4f43h
4f4d 15        dec     d
4f4e 20f3      jr      nz,4f43h
4f50 18e8      jr      4f3ah
4f52 3e01      ld      a,01h
4f54 3250fc    ld      (0fc50h),a        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
4f57 c3862f    jp      2f86h

4f5a cdc6fe    call    0fec6h
4f5d fe40      cp      40h
4f5f 2016      jr      nz,4f77h
4f61 cdf539    call    39f5h
4f64 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4f65 2c        defb    ','
4f66 e5        push    hl
4f67 2ae1fb    ld      hl,(0fbe1h)        ; MAXIMUM No. CHARACTERS ALLOWED ON SCREEN
4f6a b7        or      a
4f6b ed52      sbc     hl,de
4f6d da352d    jp      c,2d35h            ; Error: Illegal function call (FC ERROR)
4f70 ed53ddfb  ld      (0fbddh),de        ; CURSOR POSITION relative to upper L.H. corner
4f74 e1        pop     hl
4f75 180f      jr      4f86h
4f77 fe23      cp      23h
4f79 200b      jr      nz,4f86h
4f7b d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4f7c cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
4f7d 2c        defb    ','
4f7e cd2307    call    0723h			; Cassette write on routine
4f81 3e80      ld      a,80h
4f83 3250fc    ld      (0fc50h),a        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
4f86 2b        dec     hl
4f87 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
4f88 cce92f    call    z,2fe9h
4f8b ca5430    jp      z,3054h
4f8e febf      cp      0bfh
4f90 cabb3b    jp      z,3bbbh
4f93 febc      cp      0bch
4f95 ca2230    jp      z,3022h
4f98 e5        push    hl
4f99 fe2c      cp      ','
4f9b caf32f    jp      z,2ff3h
4f9e fe3b      cp      3bh
4fa0 ca4f30    jp      z,304fh
4fa3 c1        pop     bc
4fa4 cd2b32    call    322bh			; EVAL
4fa7 e5        push    hl
4fa8 e7        rst     20h			; GETYPR - Get the number type (FAC)
4fa9 2832      jr      z,4fddh
4fab cd271e    call    1e27h
4fae cd5937    call    3759h
4fb1 cdc9fe    call    0fec9h
4fb4 2a41fe    ld      hl,(0fe41h)        ; FACCU
4fb7 3a50fc    ld      a,(0fc50h)        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
4fba b7        or      a
4fbb fad42f    jp      m,2fd4h
4fbe 2808      jr      z,4fc8h
4fc0 3a4ffc    ld      a,(0fc4fh)        ; No. of characters printed on this line
4fc3 86        add     a,(hl)
4fc4 fe84      cp      84h
4fc6 1809      jr      4fd1h

4fc8 3a51fc    ld      a,(0fc51h)        ; Size of video display line
4fcb 47        ld      b,a
4fcc 3ac6fd    ld      a,(0fdc6h)        ; Current cursor position (column number)
4fcf 86        add     a,(hl)
4fd0 b8        cp      b
4fd1 d4e92f    call    nc,2fe9h
4fd4 cd9e37    call    379eh
4fd7 3e20      ld      a,20h
4fd9 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
4fdc b7        or      a
4fdd cc9e37    call    z,379eh
4fe0 e1        pop     hl
4fe1 c3862f    jp      2f86h

4fe4 3ac6fd    ld      a,(0fdc6h)        ; Current cursor position (column number)
4fe7 b7        or      a
4fe8 c8        ret     z
4fe9 3e0d      ld      a,0dh
4feb cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
4fee cdccfe    call    0fecch
4ff1 af        xor     a
4ff2 c9        ret

4ff3 cdcffe    call    0fecfh
4ff6 3a50fc    ld      a,(0fc50h)        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
4ff9 b7        or      a
4ffa f20430    jp      p,3004h
4ffd 3e2c      ld      a,2ch
4fff cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5002 184b      jr      504fh
5004 2808      jr      z,500eh
5006 3a4ffc    ld      a,(0fc4fh)        ; No. of characters printed on this line
5009 fe70      cp      70h
500b c31630    jp      3016h
500e 3a52fc    ld      a,(0fc52h)        ; Last comma column position
5011 47        ld      b,a
5012 3ac6fd    ld      a,(0fdc6h)        ; Current cursor position (column number)
5015 b8        cp      b
5016 d4e92f    call    nc,2fe9h
5019 3034      jr      nc,504fh
501b d60e      sub     0eh
501d 30fc      jr      nc,501bh
501f 2f        cpl     
5020 1823      jr      5045h
5022 cd0f3a    call    3a0fh
5025 e6ff      and     0ffh
5027 5f        ld      e,a
5028 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5029 29        defb    ')'
502a 2b        dec     hl
502b e5        push    hl
502c cdcffe    call    0fecfh
502f 3a50fc    ld      a,(0fc50h)        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
5032 b7        or      a
5033 fa352d    jp      m,2d35h            ; Error: Illegal function call (FC ERROR)
5036 ca3e30    jp      z,303eh
5039 3a4ffc    ld      a,(0fc4fh)        ; No. of characters printed on this line
503c 1803      jr      5041h

503e 3ac6fd    ld      a,(0fdc6h)        ; Current cursor position (column number)
5041 2f        cpl     
5042 83        add     a,e
5043 300a      jr      nc,504fh
5045 3c        inc     a
5046 47        ld      b,a
5047 3e20      ld      a,20h
5049 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
504c 05        dec     b
504d 20fa      jr      nz,5049h
504f e1        pop     hl
5050 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5051 c38b2f    jp      2f8bh

5054 3a50fc    ld      a,(0fc50h)        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
5057 b7        or      a
5058 fc8007    call    m,0780h			; Cassette off routine
505b af        xor     a
505c 3250fc    ld      (0fc50h),a        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
505f cdbafe    call    0febah
5062 c9        ret

5063 3f        ccf     
5064 52        ld      d,d
5065 45        ld      b,l
5066 44        ld      b,h
5067 4f        ld      c,a
5068 0d        dec     c
5069 00        nop     
506a 3afefd    ld      a,(0fdfeh)        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
506d b7        or      a
506e c27b28    jp      nz,287bh
5071 3ac9fd    ld      a,(0fdc9h)        ; 0 if input from cassette else non-zero
5074 b7        or      a
5075 1e2a      ld      e,2ah
5077 ca8c28    jp      z,288ch            ; ERROR, E=error code
507a c1        pop     bc
507b 216330    ld      hl,3063h
507e cd9b37    call    379bh			; Output a string
5081 2a06fe    ld      hl,(0fe06h)        ; SAVTXT (During input:  ADDR of code string for current statement)
5084 c9        ret

5085 cd1c37    call    371ch
5088 7e        ld      a,(hl)
5089 cda902    call    02a9h
508c d623      sub     23h
508e 32c9fd    ld      (0fdc9h),a        ; 0 if input from cassette else non-zero
5091 7e        ld      a,(hl)
5092 2020      jr      nz,50b4h
5094 cda502    call    02a5h
5097 e5        push    hl
5098 06fa      ld      b,0fah
509a 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
509d cdc907    call    07c9h			; Casette read routine
50a0 77        ld      (hl),a
50a1 23        inc     hl
50a2 fe0d      cp      0dh
50a4 2802      jr      z,50a8h
50a6 10f5      djnz    509dh
50a8 2b        dec     hl
50a9 3600      ld      (hl),00h
50ab cd8007    call    0780h			; Cassette off routine
50ae 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
50b1 2b        dec     hl
50b2 1822      jr      50d6h
50b4 01c630    ld      bc,30c6h
50b7 c5        push    bc
50b8 fe22      cp      22h
50ba c0        ret     nz
50bb cd5a37    call    375ah
50be cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
50bf 3b        dec     sp
50c0 e5        push    hl
50c1 cd9e37    call    379eh
50c4 e1        pop     hl
50c5 c9        ret     
50c6 e5        push    hl
50c7 cd9d2a    call    2a9dh        ; INLIN
50ca c1        pop     bc
50cb daa92c    jp      c,2ca9h
50ce 23        inc     hl
50cf 7e        ld      a,(hl)
50d0 b7        or      a
50d1 2b        dec     hl
50d2 c5        push    bc
50d3 caef2d    jp      z,2defh
50d6 362c      ld      (hl),2ch
50d8 180e      jr      50e8h
50da fe23      cp      23h
50dc caa814    jp      z,14a8h
50df 3c        inc     a
50e0 32c9fd    ld      (0fdc9h),a        ; 0 if input from cassette else non-zero

; __READ:
50e3 e5        push    hl
50e4 2a1ffe    ld      hl,(0fe1fh)        ; Points to byte following last char
50e7 f6af      or      0afh
50e9 32fefd    ld      (0fdfeh),a        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
50ec e3        ex      (sp),hl
50ed 1802      jr      50f1h
50ef cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
50f0 2c        defb    ','
50f1 cd0135    call    3501h        ; GETVAR: Find address of variable
50f4 e3        ex      (sp),hl
50f5 d5        push    de
50f6 7e        ld      a,(hl)
50f7 fe2c      cp      ','
50f9 2826      jr      z,5121h
50fb 3afefd    ld      a,(0fdfeh)        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
50fe b7        or      a
50ff c28a31    jp      nz,318ah
5102 3ac9fd    ld      a,(0fdc9h)        ; 0 if input from cassette else non-zero
5105 b7        or      a
5106 1e06      ld      e,06h
5108 ca8c28    jp      z,288ch        ; ERROR, E=error code
510b 3e3f      ld      a,3fh        ; '?'
510d cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5110 cd9d2a    call    2a9dh        ; INLIN
5113 d1        pop     de
5114 c1        pop     bc
5115 daa92c    jp      c,2ca9h
5118 23        inc     hl
5119 7e        ld      a,(hl)
511a b7        or      a
511b 2b        dec     hl
511c c5        push    bc
511d caef2d    jp      z,2defh
5120 d5        push    de
5121 cdd8fe    call    0fed8h
5124 e7        rst     20h			; GETYPR - Get the number type (FAC)
5125 f5        push    af
5126 2019      jr      nz,5141h
5128 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5129 57        ld      d,a
512a 47        ld      b,a
512b fe22      cp      22h
512d 2805      jr      z,5134h
512f 163a      ld      d,3ah
5131 062c      ld      b,2ch
5133 2b        dec     hl
5134 cd5d37    call    375dh
5137 f1        pop     af
5138 eb        ex      de,hl
5139 214e31    ld      hl,314eh
513c e3        ex      (sp),hl
513d d5        push    de
513e c31e2e    jp      2e1eh

5141 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5142 f1        pop     af
5143 f5        push    af
5144 013731    ld      bc,3137h
5147 c5        push    bc
5148 dad61c    jp      c,1cd6h
514b d2cf1c    jp      nc,1ccfh
514e 2b        dec     hl
514f d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5150 2805      jr      z,5157h
5152 fe2c      cp      ','
5154 c26a30    jp      nz,306ah
5157 e3        ex      (sp),hl
5158 2b        dec     hl
5159 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
515a c2ef30    jp      nz,30efh
515d d1        pop     de
515e 3ac9fd    ld      a,(0fdc9h)        ; 0 if input from cassette else non-zero
5161 b7        or      a
5162 c8        ret     z
5163 3afefd    ld      a,(0fdfeh)        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
5166 b7        or      a
5167 eb        ex      de,hl
5168 c2802c    jp      nz,2c80h
516b d5        push    de
516c cddbfe    call    0fedbh
516f b6        or      (hl)
5170 217a31    ld      hl,317ah
5173 c49b37    call    nz,379bh			; Output a string
5176 e1        pop     hl
5177 c35430    jp      3054h

517a 3f        ccf     
517b 45        ld      b,l
517c 78        ld      a,b
517d 74        ld      (hl),h
517e 72        ld      (hl),d
517f 61        ld      h,c
5180 2069      jr      nz,51ebh
5182 67        ld      h,a
5183 6e        ld      l,(hl)
5184 6f        ld      l,a
5185 72        ld      (hl),d
5186 65        ld      h,l
5187 64        ld      h,h
5188 0d        dec     c
5189 00        nop     
518a cdf02d    call    2df0h
518d b7        or      a
518e 2012      jr      nz,51a2h
5190 23        inc     hl
5191 7e        ld      a,(hl)
5192 23        inc     hl
5193 b6        or      (hl)
5194 1e06      ld      e,06h
5196 ca8c28    jp      z,288ch        ; ERROR, E=error code
5199 23        inc     hl
519a 5e        ld      e,(hl)
519b 23        inc     hl
519c 56        ld      d,(hl)
519d eb        ex      de,hl
519e 22fafd    ld      (0fdfah),hl        ; Line No.  of last data statement
51a1 eb        ex      de,hl
51a2 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
51a3 fe88      cp      88h
51a5 20e3      jr      nz,518ah
51a7 c32131    jp      3121h
51aa 110000    ld      de,0000h
51ad c40135    call    nz,3501h        ; GETVAR: Find address of variable
51b0 22fffd    ld      (0fdffh),hl
51b3 cd2028    call    2820h
51b6 c28728    jp      nz,2887h
51b9 f9        ld      sp,hl
51ba 2208fe    ld      (0fe08h),hl            ; During execution: stack pointer value when statement execution begins.
51bd d5        push    de
51be 7e        ld      a,(hl)
51bf 23        inc     hl
51c0 f5        push    af
51c1 d5        push    de
51c2 7e        ld      a,(hl)
51c3 23        inc     hl
51c4 b7        or      a
51c5 fade31    jp      m,31deh
51c8 cd1b18    call    181bh            ; Move a SP value -> HL to WRA1
51cb e3        ex      (sp),hl
51cc e5        push    hl
51cd cd7515    call    1575h
51d0 e1        pop     hl
51d1 cd3518    call    1835h
51d4 e1        pop     hl
51d5 cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE
51d8 e5        push    hl
51d9 cd7618    call    1876h
51dc 1829      jr      5207h
51de 23        inc     hl
51df 23        inc     hl
51e0 23        inc     hl
51e1 23        inc     hl
51e2 4e        ld      c,(hl)
51e3 23        inc     hl
51e4 46        ld      b,(hl)
51e5 23        inc     hl
51e6 e3        ex      (sp),hl
51e7 5e        ld      e,(hl)
51e8 23        inc     hl
51e9 56        ld      d,(hl)
51ea e5        push    hl
51eb 69        ld      l,c
51ec 60        ld      h,b
51ed cd3c1a    call    1a3ch
51f0 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
51f3 fe04      cp      04h
51f5 ca1c16    jp      z,161ch            ; Overflow Error (OV ERROR)
51f8 eb        ex      de,hl
51f9 e1        pop     hl
51fa 72        ld      (hl),d
51fb 2b        dec     hl
51fc 73        ld      (hl),e
51fd e1        pop     hl
51fe d5        push    de
51ff 5e        ld      e,(hl)
5200 23        inc     hl
5201 56        ld      d,(hl)
5202 23        inc     hl
5203 e3        ex      (sp),hl
5204 cda318    call    18a3h
5207 e1        pop     hl
5208 c1        pop     bc
5209 90        sub     b
520a cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE
520d 2809      jr      z,5218h
520f eb        ex      de,hl
5210 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
5213 69        ld      l,c
5214 60        ld      h,b
5215 c3042c    jp      2c04h
5218 f9        ld      sp,hl
5219 2208fe    ld      (0fe08h),hl        ; During execution: stack pointer value when statement execution begins.
521c 2afffd    ld      hl,(0fdffh)
521f 7e        ld      a,(hl)
5220 fe2c      cp      ','
5222 c2082c    jp      nz,2c08h
5225 d7        rst     10h                ; CHRGTB: Gets next character (or token) from BASIC text.
5226 cdad31    call    31adh
5229 cf        rst     08h                ;   SYNCHR: Check syntax: next byte holds the byte to be found
522a 282b      jr      z,5257h
522c 1600      ld      d,00h
522e d5        push    de
522f 0e01      ld      c,01h
5231 cd4d28    call    284dh
5234 cd9333    call    3393h
5237 2213fe    ld      (0fe13h),hl        ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
523a 2a13fe    ld      hl,(0fe13h)        ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
523d c1        pop     bc
523e 7e        ld      a,(hl)
523f 1600      ld      d,00h
5241 d6d4      sub     0d4h
5243 3813      jr      c,5258h
5245 fe03      cp      03h
5247 300f      jr      nc,5258h
5249 fe01      cp      01h
524b 17        rla     
524c aa        xor     d
524d ba        cp      d
524e 57        ld      d,a
524f da8128    jp      c,2881h            ; Syntax Error (SN ERROR)
5252 22f8fd    ld      (0fdf8h),hl        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
5255 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5256 18e9      jr      5241h
5258 7a        ld      a,d
5259 b7        or      a
525a c2e032    jp      nz,32e0h
525d 7e        ld      a,(hl)
525e 22f8fd    ld      (0fdf8h),hl        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
5261 d6cd      sub     0cdh
5263 d8        ret     c
5264 fe07      cp      07h
5266 d0        ret     nc
5267 5f        ld      e,a
5268 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
526b d603      sub     03h
526d b3        or      e
526e ca8338    jp      z,3883h
5271 218227    ld      hl,2782h
5274 19        add     hl,de
5275 78        ld      a,b
5276 56        ld      d,(hl)
5277 ba        cp      d
5278 d0        ret     nc
5279 c5        push    bc
527a 013a32    ld      bc,323ah
527d c5        push    bc
527e 7a        ld      a,d
527f fe7f      cp      7fh
5281 cac832    jp      z,32c8h
5284 fe51      cp      51h
5286 dad532    jp      c,32d5h
5289 2141fe    ld      hl,0fe41h        ; FACCU
528c b7        or      a
528d 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
5290 3d        dec     a
5291 3d        dec     a
5292 3d        dec     a
5293 ca6019    jp      z,1960h
5296 4e        ld      c,(hl)
5297 23        inc     hl
5298 46        ld      b,(hl)
5299 c5        push    bc
529a fab932    jp      m,32b9h
529d 23        inc     hl
529e 4e        ld      c,(hl)
529f 23        inc     hl
52a0 46        ld      b,(hl)
52a1 c5        push    bc
52a2 f5        push    af
52a3 b7        or      a
52a4 e2b832    jp      po,32b8h
52a7 f1        pop     af
52a8 23        inc     hl
52a9 3803      jr      c,52aeh
52ab 213dfe    ld      hl,0fe3dh
52ae 4e        ld      c,(hl)
52af 23        inc     hl
52b0 46        ld      b,(hl)
52b1 23        inc     hl
52b2 c5        push    bc
52b3 4e        ld      c,(hl)
52b4 23        inc     hl
52b5 46        ld      b,(hl)
52b6 c5        push    bc
52b7 06f1      ld      b,0f1h
52b9 c603      add     a,03h
52bb 4b        ld      c,e
52bc 47        ld      b,a
52bd c5        push    bc
52be 01fa32    ld      bc,32fah
52c1 c5        push    bc
52c2 2af8fd    ld      hl,(0fdf8h)        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
52c5 c32e32    jp      322eh        ; EVAL1

52c8 cd1b19    call    191bh
52cb cd0e18    call    180eh                ; Move WRA1 to stack
52ce 015c22    ld      bc,225ch
52d1 167f      ld      d,7fh
52d3 18ec      jr      52c1h
52d5 d5        push    de
52d6 cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
52d9 d1        pop     de
52da e5        push    hl
52db 01dd34    ld      bc,34ddh
52de 18e1      jr      52c1h
52e0 78        ld      a,b
52e1 fe64      cp      64h
52e3 d0        ret     nc
52e4 c5        push    bc
52e5 d5        push    de
52e6 110464    ld      de,6404h
52e9 21ac34    ld      hl,34ach
52ec e5        push    hl
52ed e7        rst     20h			; GETYPR - Get the number type (FAC)
52ee c28932    jp      nz,3289h
52f1 2a41fe    ld      hl,(0fe41h)        ; FACCU
52f4 e5        push    hl
52f5 018034    ld      bc,3480h
52f8 18c7      jr      52c1h

52fa c1        pop     bc
52fb 79        ld      a,c
52fc 32d0fd    ld      (0fdd0h),a
52ff 78        ld      a,b
5300 fe08      cp      08h
5302 2828      jr      z,532ch
5304 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
5307 fe08      cp      08h
5309 ca5433    jp      z,3354h
530c 57        ld      d,a
530d 78        ld      a,b
530e fe04      cp      04h
5310 ca6633    jp      z,3366h
5313 7a        ld      a,d
5314 fe03      cp      03h
5316 ca6019    jp      z,1960h
5319 d27033    jp      nc,3370h
531c 21a727    ld      hl,27a7h
531f 0600      ld      b,00h
5321 09        add     hl,bc
5322 09        add     hl,bc
5323 4e        ld      c,(hl)
5324 23        inc     hl
5325 46        ld      b,(hl)
5326 d1        pop     de
5327 2a41fe    ld      hl,(0fe41h)        ; FACCU
532a c5        push    bc
532b c9        ret     
532c cd4519    call    1945h
532f cd6618    call    1866h
5332 e1        pop     hl
5333 223ffe    ld      (0fe3fh),hl
5336 e1        pop     hl
5337 223dfe    ld      (0fe3dh),hl
533a c1        pop     bc
533b d1        pop     de
533c cd1e18    call    181eh            ; Move SP value in BC/DE into WRA1
533f cd4519    call    1945h
5342 219327    ld      hl,2793h
5345 3ad0fd    ld      a,(0fdd0h)
5348 07        rlca    
5349 c5        push    bc
534a 4f        ld      c,a
534b 0600      ld      b,00h
534d 09        add     hl,bc
534e c1        pop     bc
534f 7e        ld      a,(hl)
5350 23        inc     hl
5351 66        ld      h,(hl)
5352 6f        ld      l,a
5353 e9        jp      (hl)

5354 c5        push    bc
5355 cd6618    call    1866h
5358 f1        pop     af
5359 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
535c fe04      cp      04h
535e 28da      jr      z,533ah
5360 e1        pop     hl
5361 2241fe    ld      (0fe41h),hl        ; FACCU
5364 18d9      jr      533fh
5366 cd1b19    call    191bh
5369 c1        pop     bc
536a d1        pop     de
536b 219d27    ld      hl,279dh
536e 18d5      jr      5345h
5370 e1        pop     hl
5371 cd0e18    call    180eh                ; Move WRA1 to stack
5374 cd3919    call    1939h
5377 cd2918    call    1829h
537a e1        pop     hl
537b 2243fe    ld      (0fe43h),hl
537e e1        pop     hl
537f 2241fe    ld      (0fe41h),hl        ; FACCU
5382 18e7      jr      536bh
5384 e5        push    hl
5385 eb        ex      de,hl
5386 cd3919    call    1939h
5389 e1        pop     hl
538a cd0e18    call    180eh                ; Move WRA1 to stack
538d cd3919    call    1939h
5390 c30a17    jp      170ah

5393 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5394 1e28      ld      e,28h
5396 ca8c28    jp      z,288ch        ; ERROR, E=error code
5399 dad61c    jp      c,1cd6h
539c cd282d    call    2d28h        ; IS_ALPHA_A
539f d23434    jp      nc,3434h
53a2 fecd      cp      0cdh
53a4 28ed      jr      z,5393h
53a6 fe2e      cp      2eh
53a8 cad61c    jp      z,1cd6h
53ab fece      cp      0ceh
53ad ca2634    jp      z,3426h
53b0 fe22      cp      22h
53b2 ca5a37    jp      z,375ah
53b5 fecb      cp      0cbh
53b7 cab834    jp      z,34b8h
53ba fe26      cp      26h
53bc ca203f    jp      z,3f20h
53bf fec3      cp      0c3h
53c1 200a      jr      nz,53cdh
53c3 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
53c4 3a4efc    ld      a,(0fc4eh)            ; ERRFLG:  ERROR FLAG
53c7 e5        push    hl
53c8 cdec36    call    36ech			; UNSIGNED_RESULT_A
53cb e1        pop     hl
53cc c9        ret

53cd fec2      cp      0c2h
53cf 200a      jr      nz,53dbh
53d1 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
53d2 e5        push    hl
53d3 2a0afe    ld      hl,(0fe0ah)            ; ERRLIN: Line No. in which error occured.
53d6 cdd01a    call    1ad0h
53d9 e1        pop     hl
53da c9        ret

53db fec0      cp      0c0h
53dd 2014      jr      nz,53f3h
53df d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
53e0 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
53e1 28cd      jr      z,53b0h
53e3 0135cf    ld      bc,0cf35h
53e6 29        add     hl,hl
53e7 e5        push    hl
53e8 eb        ex      de,hl
53e9 7c        ld      a,h
53ea b5        or      l
53eb ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
53ee cd0419    call    1904h
53f1 e1        pop     hl
53f2 c9        ret

53f3 fec1      cp      0c1h
53f5 caf236    jp      z,36f2h
53f8 fec5      cp      0c5h
53fa ca243f    jp      z,3f24h
53fd fec8      cp      0c8h
53ff cabd36    jp      z,36bdh
5402 fec7      cp      0c7h
5404 ca96fe    jp      z,0fe96h
5407 fec6      cp      0c6h
5409 cae10d    jp      z,0de1h
540c fec9      cp      0c9h
540e cabe09    jp      z,09beh
5411 fec4      cp      0c4h
5413 ca2339    jp      z,3923h
5416 febe      cp      0beh
5418 ca75fe    jp      z,0fe75h
541b d6d7      sub     0d7h
541d d24234    jp      nc,3442h
5420 cd2932    call    3229h
5423 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5424 29        defb    ')'
5425 c9        ret

; OPRND_SUB:
5426 167d      ld      d,7dh
5428 cd2e32    call    322eh        ; EVAL1
542b 2a13fe    ld      hl,(0fe13h)        ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
542e e5        push    hl
542f cde517    call    17e5h        ; INVSGN
5432 e1        pop     hl
5433 c9        ret
   
5434 cd0135    call    3501h        ; GETVAR: Find address of variable
5437 e5        push    hl
5438 eb        ex      de,hl
5439 2241fe    ld      (0fe41h),hl        ; FACCU
543c e7        rst     20h			; GETYPR - Get the number type (FAC)
543d c46118    call    nz,1861h
5440 e1        pop     hl
5441 c9        ret

5442 0600      ld      b,00h
5444 07        rlca    
5445 4f        ld      c,a
5446 c5        push    bc
5447 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5448 79        ld      a,c
5449 fe41      cp      41h
544b 3816      jr      c,5463h
544d cd2932    call    3229h
5450 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5451 2c        defb    ','
5452 cd5e19    call    195eh
5455 eb        ex      de,hl
5456 2a41fe    ld      hl,(0fe41h)        ; FACCU
5459 e3        ex      (sp),hl
545a e5        push    hl
545b eb        ex      de,hl
545c cd103a    call    3a10h		; GETINT
545f eb        ex      de,hl
5460 e3        ex      (sp),hl
5461 1814      jr      5477h

5463 cd2034    call    3420h
5466 e3        ex      (sp),hl
5467 7d        ld      a,l
5468 fe0c      cp      0ch
546a 3807      jr      c,5473h
546c fe1b      cp      1bh
546e e5        push    hl
546f dc1b19    call    c,191bh
5472 e1        pop     hl
5473 113234    ld      de,3432h
5476 d5        push    de
5477 01e624    ld      bc,24e6h
547a 09        add     hl,bc
547b 4e        ld      c,(hl)
547c 23        inc     hl
547d 66        ld      h,(hl)
547e 69        ld      l,c
547f e9        jp      (hl)
5480 cdcb38    call    38cbh			; GETSTR
5483 7e        ld      a,(hl)
5484 23        inc     hl
5485 4e        ld      c,(hl)
5486 23        inc     hl
5487 46        ld      b,(hl)
5488 d1        pop     de
5489 c5        push    bc
548a f5        push    af
548b cdd238    call    38d2h
548e d1        pop     de
548f 5e        ld      e,(hl)
5490 23        inc     hl
5491 4e        ld      c,(hl)
5492 23        inc     hl
5493 46        ld      b,(hl)
5494 e1        pop     hl
5495 7b        ld      a,e
5496 b2        or      d
5497 c8        ret     z
5498 7a        ld      a,d
5499 d601      sub     01h
549b d8        ret     c
549c af        xor     a
549d bb        cp      e
549e 3c        inc     a
549f d0        ret     nc
54a0 15        dec     d
54a1 1d        dec     e
54a2 0a        ld      a,(bc)
54a3 be        cp      (hl)
54a4 23        inc     hl
54a5 03        inc     bc
54a6 28ed      jr      z,5495h
54a8 3f        ccf     
54a9 c3ca17    jp      17cah
54ac 3c        inc     a
54ad 8f        adc     a,a
54ae c1        pop     bc
54af a0        and     b
54b0 c6ff      add     a,0ffh
54b2 9f        sbc     a,a
54b3 cdf717    call    17f7h
54b6 1812      jr      54cah
54b8 165a      ld      d,5ah
54ba cd2e32    call    322eh        ; EVAL1
54bd cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
54c0 7d        ld      a,l
54c1 2f        cpl     
54c2 6f        ld      l,a
54c3 7c        ld      a,h
54c4 2f        cpl     
54c5 67        ld      h,a
54c6 2241fe    ld      (0fe41h),hl        ; FACCU
54c9 c1        pop     bc
54ca c33a32    jp      323ah
54cd 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
54d0 fe08      cp      08h
54d2 3005      jr      nc,54d9h
54d4 d603      sub     03h
54d6 b7        or      a
54d7 37        scf     
54d8 c9        ret     
54d9 d603      sub     03h
54db b7        or      a
54dc c9        ret     
54dd c5        push    bc
54de cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
54e1 f1        pop     af
54e2 d1        pop     de
54e3 01ee36    ld      bc,36eeh
54e6 c5        push    bc
54e7 fe46      cp      46h
54e9 2006      jr      nz,54f1h
54eb 7b        ld      a,e
54ec b5        or      l
54ed 6f        ld      l,a
54ee 7c        ld      a,h
54ef b2        or      d
54f0 c9        ret     
54f1 7b        ld      a,e
54f2 a5        and     l
54f3 6f        ld      l,a
54f4 7c        ld      a,h
54f5 a2        and     d
54f6 c9        ret

54f7 2b        dec     hl
54f8 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.

54f9 c8        ret     z
54fa cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
54fb 2c        defb    ','

; __DIM
54fc 01f734    ld      bc,34f7h        ; BC = {POP HL / RET}
54ff c5        push    bc
;5500 f6af      or      0afh
5500           defb    f6h        ; OR $AF
; GETVAR
5501           xor     a
5502 32cefd    ld      (0fdceh),a    ; DIMFLG
5505 46        ld      b,(hl)
5506 cd282d    call    2d28h        ; IS_ALPHA_A
5509 da8128    jp      c,2881h            ; Syntax Error (SN ERROR)
550c af        xor     a
550d 4f        ld      c,a
550e d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
550f 3805      jr      c,5516h
5511 cd282d    call    2d28h        ; IS_ALPHA_A
5514 3809      jr      c,551fh
5516 4f        ld      c,a
5517 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5518 38fd      jr      c,5517h
551a cd282d    call    2d28h        ; IS_ALPHA_A
551d 30f8      jr      nc,5517h
551f 114635    ld      de,3546h
5522 d5        push    de
5523 1602      ld      d,02h
5525 fe25      cp      25h
5527 c8        ret     z
5528 14        inc     d
5529 fe24      cp      24h
552b c8        ret     z
552c 14        inc     d
552d fe21      cp      21h
552f c8        ret     z
5530 1608      ld      d,08h
5532 fe23      cp      23h
5534 c8        ret     z
5535 78        ld      a,b
5536 d641      sub     41h
5538 e67f      and     7fh
553a 5f        ld      e,a
553b 1600      ld      d,00h
553d e5        push    hl
553e 2121fe    ld      hl,0fe21h    ; Variable declaration list. 26 entries, each containing a code inicating default mode for that initial letter
5541 19        add     hl,de
5542 56        ld      d,(hl)
5543 e1        pop     hl
5544 2b        dec     hl
5545 c9        ret     

5546 7a        ld      a,d
5547 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
554a d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
554b 3afcfd    ld      a,(0fdfch)        ; FOR flag (1 = 'for' in progress, 0 =  no 'for' in progress)
554e b7        or      a
554f c25835    jp      nz,3558h
5552 7e        ld      a,(hl)
5553 d628      sub     28h
5555 cadd35    jp      z,35ddh
5558 af        xor     a
5559 32fcfd    ld      (0fdfch),a        ; FOR flag (1 = 'for' in progress, 0 =  no 'for' in progress)
555c e5        push    hl
555d d5        push    de
555e 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
5561 eb        ex      de,hl
5562 2a1bfe    ld      hl,(0fe1bh)        ; VAREND: Addr of dimensioned variables
5565 df        rst     18h            ; DCOMPR - Compare HL with DE.
5566 e1        pop     hl
5567 2819      jr      z,5582h
5569 1a        ld      a,(de)
556a 6f        ld      l,a
556b bc        cp      h
556c 13        inc     de
556d 200b      jr      nz,557ah
556f 1a        ld      a,(de)
5570 b9        cp      c
5571 2007      jr      nz,557ah
5573 13        inc     de
5574 1a        ld      a,(de)
5575 b8        cp      b
5576 cac035    jp      z,35c0h
5579 3e13      ld      a,13h
557b 13        inc     de
557c e5        push    hl
557d 2600      ld      h,00h
557f 19        add     hl,de
5580 18df      jr      5561h
5582 7c        ld      a,h
5583 e1        pop     hl
5584 e3        ex      (sp),hl
5585 f5        push    af
5586 d5        push    de
5587 11e533    ld      de,33e5h
558a df        rst     18h            ; DCOMPR - Compare HL with DE.
558b 2836      jr      z,55c3h
558d 113734    ld      de,3437h
5590 df        rst     18h            ; DCOMPR - Compare HL with DE.
5591 d1        pop     de
5592 2835      jr      z,55c9h
5594 f1        pop     af
5595 e3        ex      (sp),hl
5596 e5        push    hl
5597 c5        push    bc
5598 4f        ld      c,a
5599 0600      ld      b,00h
559b c5        push    bc
559c 03        inc     bc
559d 03        inc     bc
559e 03        inc     bc
559f 2a1dfe    ld      hl,(0fe1dh)        ; ARREND - Starting address of free space list (FSL)
55a2 e5        push    hl
55a3 09        add     hl,bc
55a4 c1        pop     bc
55a5 e5        push    hl
55a6 cd3f28    call    283fh
55a9 e1        pop     hl
55aa 221dfe    ld      (0fe1dh),hl        ; ARREND - Starting address of free space list (FSL)
55ad 60        ld      h,b
55ae 69        ld      l,c
55af 221bfe    ld      (0fe1bh),hl        ; VAREND: Addr of dimensioned variables
55b2 2b        dec     hl
55b3 3600      ld      (hl),00h
55b5 df        rst     18h            ; DCOMPR - Compare HL with DE.
55b6 20fa      jr      nz,55b2h
55b8 d1        pop     de
55b9 73        ld      (hl),e
55ba 23        inc     hl
55bb d1        pop     de
55bc 73        ld      (hl),e
55bd 23        inc     hl
55be 72        ld      (hl),d
55bf eb        ex      de,hl
55c0 13        inc     de
55c1 e1        pop     hl
55c2 c9        ret     
55c3 57        ld      d,a
55c4 5f        ld      e,a
55c5 f1        pop     af
55c6 f1        pop     af
55c7 e3        ex      (sp),hl
55c8 c9        ret     
55c9 3244fe    ld      (0fe44h),a
55cc c1        pop     bc
55cd 67        ld      h,a
55ce 6f        ld      l,a
55cf 2241fe    ld      (0fe41h),hl        ; FACCU
55d2 e7        rst     20h			; GETYPR - Get the number type (FAC)
55d3 2006      jr      nz,55dbh
55d5 211228    ld      hl,2812h
55d8 2241fe    ld      (0fe41h),hl        ; FACCU
55db e1        pop     hl
55dc c9        ret

55dd e5        push    hl
55de 2acefd    ld      hl,(0fdceh)        ; DIMFLG
55e1 e3        ex      (sp),hl
55e2 57        ld      d,a
55e3 d5        push    de
55e4 c5        push    bc
55e5 cd302d    call    2d30h
55e8 c1        pop     bc
55e9 f1        pop     af
55ea eb        ex      de,hl
55eb e3        ex      (sp),hl
55ec e5        push    hl
55ed eb        ex      de,hl
55ee 3c        inc     a
55ef 57        ld      d,a
55f0 7e        ld      a,(hl)
55f1 fe2c      cp      ','
55f3 28ee      jr      z,55e3h
55f5 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
55f6 29        defb    ')'
55f7 2213fe    ld      (0fe13h),hl        ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
55fa e1        pop     hl
55fb 22cefd    ld      (0fdceh),hl        ; DIMFLG
55fe d5        push    de
55ff 2a1bfe    ld      hl,(0fe1bh)        ; VAREND: Addr of dimensioned variables
5602 3e19      ld      a,19h
5604 eb        ex      de,hl
5605 2a1dfe    ld      hl,(0fe1dh)        ; ARREND - Starting address of free space list (FSL)
5608 eb        ex      de,hl
5609 df        rst     18h            ; DCOMPR - Compare HL with DE.
560a 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
560d 2827      jr      z,5636h
560f be        cp      (hl)
5610 23        inc     hl
5611 2008      jr      nz,561bh
5613 7e        ld      a,(hl)
5614 b9        cp      c
5615 23        inc     hl
5616 2004      jr      nz,561ch
5618 7e        ld      a,(hl)
5619 b8        cp      b
561a 3e23      ld      a,23h
561c 23        inc     hl
561d 5e        ld      e,(hl)
561e 23        inc     hl
561f 56        ld      d,(hl)
5620 23        inc     hl
5621 20e0      jr      nz,5603h
5623 3acefd    ld      a,(0fdceh)        ; DIMFLG
5626 b7        or      a
5627 1e12      ld      e,12h
5629 c28c28    jp      nz,288ch        ; ERROR, E=error code
562c f1        pop     af
562d 96        sub     (hl)
562e ca8936    jp      z,3689h
5631 1e10      ld      e,10h
5633 c38c28    jp      288ch        ; ERROR, E=error code
5636 77        ld      (hl),a
5637 23        inc     hl
5638 5f        ld      e,a
5639 1600      ld      d,00h
563b f1        pop     af
563c 71        ld      (hl),c
563d 23        inc     hl
563e 70        ld      (hl),b
563f 23        inc     hl
5640 4f        ld      c,a
5641 cd4d28    call    284dh
5644 23        inc     hl
5645 23        inc     hl
5646 22f8fd    ld      (0fdf8h),hl        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
5649 71        ld      (hl),c
564a 23        inc     hl
564b 3acefd    ld      a,(0fdceh)        ; DIMFLG
564e 17        rla     
564f 79        ld      a,c
5650 010b00    ld      bc,000bh
5653 3002      jr      nc,5657h
5655 c1        pop     bc
5656 03        inc     bc
5657 71        ld      (hl),c
5658 23        inc     hl
5659 70        ld      (hl),b
565a 23        inc     hl
565b f5        push    af
565c cd141a    call    1a14h
565f f1        pop     af
5660 3d        dec     a
5661 20ed      jr      nz,5650h
5663 f5        push    af
5664 42        ld      b,d
5665 4b        ld      c,e
5666 eb        ex      de,hl
5667 19        add     hl,de
5668 38c7      jr      c,5631h
566a cd5628    call    2856h
566d 221dfe    ld      (0fe1dh),hl        ; ARREND - Starting address of free space list (FSL)
5670 2b        dec     hl
5671 3600      ld      (hl),00h
5673 df        rst     18h            ; DCOMPR - Compare HL with DE.
5674 20fa      jr      nz,5670h
5676 03        inc     bc
5677 57        ld      d,a
5678 2af8fd    ld      hl,(0fdf8h)        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
567b 5e        ld      e,(hl)
567c eb        ex      de,hl
567d 29        add     hl,hl
567e 09        add     hl,bc
567f eb        ex      de,hl
5680 2b        dec     hl
5681 2b        dec     hl
5682 73        ld      (hl),e
5683 23        inc     hl
5684 72        ld      (hl),d
5685 23        inc     hl
5686 f1        pop     af
5687 3830      jr      c,56b9h
5689 47        ld      b,a
568a 4f        ld      c,a
568b 7e        ld      a,(hl)
568c 23        inc     hl
568d 16e1      ld      d,0e1h
568f 5e        ld      e,(hl)
5690 23        inc     hl
5691 56        ld      d,(hl)
5692 23        inc     hl
5693 e3        ex      (sp),hl
5694 f5        push    af
5695 df        rst     18h            ; DCOMPR - Compare HL with DE.
5696 d23136    jp      nc,3631h
5699 cd141a    call    1a14h
569c 19        add     hl,de
569d f1        pop     af
569e 3d        dec     a
569f 44        ld      b,h
56a0 4d        ld      c,l
56a1 20eb      jr      nz,568eh
56a3 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
56a6 44        ld      b,h
56a7 4d        ld      c,l
56a8 29        add     hl,hl
56a9 d604      sub     04h
56ab 3804      jr      c,56b1h
56ad 29        add     hl,hl
56ae 2806      jr      z,56b6h
56b0 29        add     hl,hl
56b1 b7        or      a
56b2 e2b636    jp      po,36b6h
56b5 09        add     hl,bc
56b6 c1        pop     bc
56b7 09        add     hl,bc
56b8 eb        ex      de,hl
56b9 2a13fe    ld      hl,(0fe13h)        ; NXTOPR: Next operand, addr of decimal point in PBUF, etc..
56bc c9        ret

56bd af        xor     a
56be e5        push    hl
56bf 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
56c2 cdc836    call    36c8h
56c5 e1        pop     hl
56c6 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
56c7 c9        ret     
56c8 2a1dfe    ld      hl,(0fe1dh)        ; ARREND - Starting address of free space list (FSL)
56cb eb        ex      de,hl
56cc 210000    ld      hl,0000h
56cf 39        add     hl,sp
56d0 e7        rst     20h			; GETYPR - Get the number type (FAC)
56d1 200d      jr      nz,56e0h
56d3 cdce38    call    38ceh
56d6 cdda37    call    37dah
56d9 2a54fc    ld      hl,(0fc54h)        ; Address of string area boundary
56dc eb        ex      de,hl
56dd 2af6fd    ld      hl,(0fdf6h)        ; Pointer to next available loc. in string area.
56e0 7d        ld      a,l
56e1 93        sub     e
56e2 6f        ld      l,a
56e3 7c        ld      a,h
56e4 9a        sbc     a,d
56e5 67        ld      h,a
56e6 c3d01a    jp      1ad0h

56e9 3ac6fd    ld      a,(0fdc6h)        ; Current cursor position (column number)
56ec 6f        ld      l,a
56ed af        xor     a
56ee 67        ld      h,a
56ef c30419    jp      1904h

56f2 cda8fe    call    0fea8h
56f5 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
56f6 cd2034    call    3420h
56f9 e5        push    hl
56fa 21fa16    ld      hl,16fah
56fd e5        push    hl
56fe 3acffd    ld      a,(0fdcfh)        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
5701 f5        push    af
5702 fe03      cp      03h
5704 ccce38    call    z,38ceh
5707 f1        pop     af
5708 eb        ex      de,hl
5709 2a42fc    ld      hl,(0fc42h)        ; Address of USR subroutine
570c e9        jp      (hl)

570d e5        push    hl
570e e607      and     07h
5710 218927    ld      hl,2789h
5713 4f        ld      c,a
5714 0600      ld      b,00h
5716 09        add     hl,bc
5717 cd7a34    call    347ah
571a e1        pop     hl
571b c9        ret

571c e5        push    hl
571d 2a56fc    ld      hl,(0fc56h)        ; CURLIN: Current line number
5720 23        inc     hl
5721 7c        ld      a,h
5722 b5        or      l
5723 e1        pop     hl
5724 c0        ret     nz
5725 1e16      ld      e,16h
5727 c38c28    jp      288ch        ; ERROR, E=error code

572a cd271e    call    1e27h
572d cd5937    call    3759h
5730 cdce38    call    38ceh
5733 011f39    ld      bc,391fh
5736 c5        push    bc
5737 7e        ld      a,(hl)
5738 23        inc     hl
5739 e5        push    hl
573a cdb337    call    37b3h		; TESTR
573d e1        pop     hl
573e 4e        ld      c,(hl)
573f 23        inc     hl
5740 46        ld      b,(hl)
5741 cd4e37    call    374eh
5744 e5        push    hl
5745 6f        ld      l,a
5746 cdc238    call    38c2h
5749 d1        pop     de
574a c9        ret

574b cdb337    call    37b3h		; TESTR
574e 21f3fd    ld      hl,0fdf3h        ; TMPSTR: 3 bytes used to hold length and addr of a string when moved to string area
5751 e5        push    hl
5752 77        ld      (hl),a
5753 23        inc     hl
5754 73        ld      (hl),e
5755 23        inc     hl
5756 72        ld      (hl),d
5757 e1        pop     hl
5758 c9        ret

5759 2b        dec     hl
575a 0622      ld      b,22h
575c 50        ld      d,b
575d e5        push    hl
575e 0eff      ld      c,0ffh
5760 23        inc     hl
5761 7e        ld      a,(hl)
5762 0c        inc     c
5763 b7        or      a
5764 2806      jr      z,576ch
5766 ba        cp      d
5767 2803      jr      z,576ch
5769 b8        cp      b
576a 20f4      jr      nz,5760h
576c fe22      cp      22h
576e cc622c    call    z,2c62h
5771 e3        ex      (sp),hl
5772 23        inc     hl
5773 eb        ex      de,hl
5774 79        ld      a,c
5775 cd4e37    call    374eh
5778 11f3fd    ld      de,0fdf3h        ; TMPSTR: 3 bytes used to hold length and addr of a string when moved to string area
577b 3ed5      ld      a,0d5h
577d 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
5780 2241fe    ld      (0fe41h),hl        ; FACCU
5783 3e03      ld      a,03h
5785 32cffd    ld      (0fdcfh),a        ; Type flag for WRA1: 2 - Integer, 3 - String, 4 - Single, 5 - Double
5788 cd3d18    call    183dh
578b 11f6fd    ld      de,0fdf6h        ; Pointer to next available loc. in string area.
578e df        rst     18h            ; DCOMPR - Compare HL with DE.
578f 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
5792 e1        pop     hl
5793 7e        ld      a,(hl)
5794 c0        ret     nz
5795 1e1e      ld      e,1eh
5797 c38c28    jp      288ch        ; ERROR, E=error code

579a 23        inc     hl
579b cd5937    call    3759h
579e cdce38    call    38ceh
57a1 cd2e18    call    182eh            ; LOADFP_0
57a4 14        inc     d
57a5 15        dec     d
57a6 c8        ret     z
57a7 0a        ld      a,(bc)
57a8 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
57ab fe0d      cp      0dh
57ad ccee2f    call    z,2feeh
57b0 03        inc     bc
57b1 18f2      jr      57a5h

57b3 b7        or      a
57b4 0ef1      ld      c,0f1h
57b6 f5        push    af
57b7 2a54fc    ld      hl,(0fc54h)        ; Address of string area boundary
57ba eb        ex      de,hl
57bb 2af6fd    ld      hl,(0fdf6h)        ; Pointer to next available loc. in string area.
57be 2f        cpl     
57bf 4f        ld      c,a
57c0 06ff      ld      b,0ffh
57c2 09        add     hl,bc
57c3 23        inc     hl
57c4 df        rst     18h            ; DCOMPR - Compare HL with DE.
57c5 3807      jr      c,57ceh
57c7 22f6fd    ld      (0fdf6h),hl        ; Pointer to next available loc. in string area.
57ca 23        inc     hl
57cb eb        ex      de,hl
57cc f1        pop     af
57cd c9        ret

57ce f1        pop     af
57cf 1e1a      ld      e,1ah
57d1 ca8c28    jp      z,288ch        ; ERROR, E=error code
57d4 bf        cp      a
57d5 f5        push    af
57d6 01b537    ld      bc,37b5h
57d9 c5        push    bc
57da 2ad1fd    ld      hl,(0fdd1h)        ; Memory size
57dd 22f6fd    ld      (0fdf6h),hl        ; Pointer to next available loc. in string area.
57e0 210000    ld      hl,0000h
57e3 e5        push    hl
57e4 2a54fc    ld      hl,(0fc54h)        ; Address of string area boundary
57e7 e5        push    hl
57e8 21d5fd    ld      hl,0fdd5h        ; TEMPST: LSPT (literal string pool table)
57eb eb        ex      de,hl
57ec 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
57ef eb        ex      de,hl
57f0 df        rst     18h            ; DCOMPR - Compare HL with DE.
57f1 01eb37    ld      bc,37ebh
57f4 c23e38    jp      nz,383eh
57f7 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
57fa eb        ex      de,hl
57fb 2a1bfe    ld      hl,(0fe1bh)        ; VAREND: Addr of dimensioned variables
57fe eb        ex      de,hl
57ff df        rst     18h            ; DCOMPR - Compare HL with DE.
5800 2813      jr      z,5815h
5802 7e        ld      a,(hl)
5803 23        inc     hl
5804 23        inc     hl
5805 23        inc     hl
5806 fe03      cp      03h
5808 2004      jr      nz,580eh
580a cd3f38    call    383fh
580d af        xor     a
580e 5f        ld      e,a
580f 1600      ld      d,00h
5811 19        add     hl,de
5812 18e6      jr      57fah

5814 c1        pop     bc
5815 eb        ex      de,hl
5816 2a1dfe    ld      hl,(0fe1dh)        ; ARREND - Starting address of free space list (FSL)
5819 eb        ex      de,hl
581a df        rst     18h            ; DCOMPR - Compare HL with DE.
581b ca5f38    jp      z,385fh

581e 7e        ld      a,(hl)
581f 23        inc     hl
5820 cd2c18    call    182ch            ; LOADFP: Load SP value -> into BC/DE
5823 e5        push    hl
5824 09        add     hl,bc
5825 fe03      cp      03h
5827 20eb      jr      nz,5814h
5829 22f8fd    ld      (0fdf8h),hl        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
582c e1        pop     hl
582d 4e        ld      c,(hl)
582e 0600      ld      b,00h
5830 09        add     hl,bc
5831 09        add     hl,bc
5832 23        inc     hl
5833 eb        ex      de,hl
5834 2af8fd    ld      hl,(0fdf8h)        ; 1: Index of last byte executed in current statement- 2: Edit flag during print using
5837 eb        ex      de,hl
5838 df        rst     18h            ; DCOMPR - Compare HL with DE.
5839 28da      jr      z,5815h
583b 013338    ld      bc,3833h
583e c5        push    bc
583f af        xor     a
5840 b6        or      (hl)
5841 23        inc     hl
5842 5e        ld      e,(hl)
5843 23        inc     hl
5844 56        ld      d,(hl)
5845 23        inc     hl
5846 c8        ret     z
5847 44        ld      b,h
5848 4d        ld      c,l
5849 2af6fd    ld      hl,(0fdf6h)        ; Pointer to next available loc. in string area.
584c df        rst     18h            ; DCOMPR - Compare HL with DE.
584d 60        ld      h,b
584e 69        ld      l,c
584f d8        ret     c
5850 e1        pop     hl
5851 e3        ex      (sp),hl
5852 df        rst     18h            ; DCOMPR - Compare HL with DE.
5853 e3        ex      (sp),hl
5854 e5        push    hl
5855 60        ld      h,b
5856 69        ld      l,c
5857 d0        ret     nc
5858 c1        pop     bc
5859 f1        pop     af
585a f1        pop     af
585b e5        push    hl
585c d5        push    de
585d c5        push    bc
585e c9        ret

585f d1        pop     de
5860 e1        pop     hl
5861 7d        ld      a,l
5862 b4        or      h
5863 c8        ret     z
5864 2b        dec     hl
5865 46        ld      b,(hl)
5866 2b        dec     hl
5867 4e        ld      c,(hl)
5868 e5        push    hl
5869 2b        dec     hl
586a 6e        ld      l,(hl)
586b 2600      ld      h,00h
586d 09        add     hl,bc
586e 50        ld      d,b
586f 59        ld      e,c
5870 2b        dec     hl
5871 44        ld      b,h
5872 4d        ld      c,l
5873 2af6fd    ld      hl,(0fdf6h)        ; Pointer to next available loc. in string area.
5876 cd4228    call    2842h
5879 e1        pop     hl
587a 71        ld      (hl),c
587b 23        inc     hl
587c 70        ld      (hl),b
587d 69        ld      l,c
587e 60        ld      h,b
587f 2b        dec     hl
5880 c3dd37    jp      37ddh

5883 c5        push    bc
5884 e5        push    hl
5885 2a41fe    ld      hl,(0fe41h)        ; FACCU
5888 e3        ex      (sp),hl
5889 cd9333    call    3393h
588c e3        ex      (sp),hl
588d cd5e19    call    195eh
5890 7e        ld      a,(hl)
5891 e5        push    hl
5892 2a41fe    ld      hl,(0fe41h)        ; FACCU
5895 e5        push    hl
5896 86        add     a,(hl)
5897 1e1c      ld      e,1ch
5899 da8c28    jp      c,288ch        ; ERROR, E=error code
589c cd4b37    call    374bh		; MKTMST - Make temporary string
589f d1        pop     de
58a0 cdd238    call    38d2h
58a3 e3        ex      (sp),hl
58a4 cdd138    call    38d1h
58a7 e5        push    hl
58a8 2af4fd    ld      hl,(0fdf4h)
58ab eb        ex      de,hl
58ac cdba38    call    38bah
58af cdba38    call    38bah
58b2 213d32    ld      hl,323dh
58b5 e3        ex      (sp),hl
58b6 e5        push    hl
58b7 c37837    jp      3778h		; TSTOPL

58ba e1        pop     hl
58bb e3        ex      (sp),hl
58bc 7e        ld      a,(hl)
58bd 23        inc     hl
58be 4e        ld      c,(hl)
58bf 23        inc     hl
58c0 46        ld      b,(hl)
58c1 6f        ld      l,a
58c2 2c        inc     l
58c3 2d        dec     l
58c4 c8        ret     z
58c5 0a        ld      a,(bc)
58c6 12        ld      (de),a
58c7 03        inc     bc
58c8 13        inc     de
58c9 18f8      jr      58c3h
58cb cd5e19    call    195eh
58ce 2a41fe    ld      hl,(0fe41h)        ; FACCU
58d1 eb        ex      de,hl
58d2 cde938    call    38e9h
58d5 eb        ex      de,hl
58d6 c0        ret     nz
58d7 d5        push    de
58d8 50        ld      d,b
58d9 59        ld      e,c
58da 1b        dec     de
58db 4e        ld      c,(hl)
58dc 2af6fd    ld      hl,(0fdf6h)        ; Pointer to next available loc. in string area.
58df df        rst     18h            ; DCOMPR - Compare HL with DE.
58e0 2005      jr      nz,58e7h
58e2 47        ld      b,a
58e3 09        add     hl,bc
58e4 22f6fd    ld      (0fdf6h),hl        ; Pointer to next available loc. in string area.
58e7 e1        pop     hl
58e8 c9        ret

; BAKTMP - Back to last tmp-str entry
58e9 2ad3fd    ld      hl,(0fdd3h)        ; TMSTPT: Address of next available location in LSPT
58ec 2b        dec     hl
58ed 46        ld      b,(hl)
58ee 2b        dec     hl
58ef 4e        ld      c,(hl)
58f0 2b        dec     hl
58f1 df        rst     18h            ; DCOMPR - Compare HL with DE.
58f2 c0        ret     nz
58f3 22d3fd    ld      (0fdd3h),hl        ; TMSTPT: Address of next available location in LSPT
58f6 c9        ret

; __LEN
58f7 01ec36    ld      bc,36ech		; UNSIGNED_RESULT_A
58fa c5        push    bc
58fb cdcb38    call    38cbh		; GETSTR
58fe af        xor     a
58ff 57        ld      d,a
5900 7e        ld      a,(hl)
5901 b7        or      a
5902 c9        ret

; __ASC
5903 01ec36    ld      bc,36ech			; UNSIGNED_RESULT_A
5906 c5        push    bc
5907 cdfb38    call    38fbh
590a ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
590d 23        inc     hl
590e 5e        ld      e,(hl)
590f 23        inc     hl
5910 56        ld      d,(hl)
5911 1a        ld      a,(de)
5912 c9        ret

; __CHR_S
5913 3e01      ld      a,01h		; Make temporary string 1 byte long
5915 cd4b37    call    374bh		; MKTMST - Make temporary string
5918 cd133a    call    3a13h		; MAKINT
591b 2af4fd    ld      hl,(0fdf4h)	; TMPSTR+1
591e 73        ld      (hl),e
; TOPOOL
591f c1        pop     bc
5920 c37837    jp      3778h		; TSTOPL

; FN_STRING
5923 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5924 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5925 28        defb  '('
5926 cd103a    call    3a10h		; GETINT
5929 d5        push    de
592a cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
592b 2c        defb    ','
592c cd2b32    call    322bh			; EVAL
592f cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5930 29        defb    ')'
5931 e3        ex      (sp),hl
5932 e5        push    hl
5933 e7        rst     20h			; GETYPR - Get the number type (FAC)
5934 2805      jr      z,593bh		; FN_STRING_0
5936 cd133a    call    3a13h		; MAKINT
5939 1803      jr      593eh		; FN_STRING_1
;FN_STRING_0
593b cd0739    call    3907h		; __ASC_0
;FN_STRING_1
593e d1        pop     de
593f f5        push    af
5940 f5        push    af
5941 7b        ld      a,e
5942 cd4b37    call    374bh		; MKTMST - Make temporary string
5945 5f        ld      e,a
5946 f1        pop     af
5947 1c        inc     e
5948 1d        dec     e
5949 28d4      jr      z,591fh		; TOPOOL
594b 2af4fd    ld      hl,(0fdf4h)
594e 77        ld      (hl),a
594f 23        inc     hl
5950 1d        dec     e
5951 20fb      jr      nz,594eh
5953 18ca      jr      591fh		; TOPOOL

; __LEFT_S
5955 cdd339    call    39d3h
5958 af        xor     a
5959 e3        ex      (sp),hl
595a 4f        ld      c,a
595b 3ee5      ld      a,0e5h
595d e5        push    hl
595e 7e        ld      a,(hl)
595f b8        cp      b
5960 3802      jr      c,5964h
5962 78        ld      a,b
5963 110e00    ld      de,000eh
5966 c5        push    bc
5967 cdb337    call    37b3h		; TESTR
596a c1        pop     bc
596b e1        pop     hl
596c e5        push    hl
596d 23        inc     hl
596e 46        ld      b,(hl)
596f 23        inc     hl
5970 66        ld      h,(hl)
5971 68        ld      l,b
5972 0600      ld      b,00h
5974 09        add     hl,bc
5975 44        ld      b,h
5976 4d        ld      c,l
5977 cd4e37    call    374eh
597a 6f        ld      l,a
597b cdc238    call    38c2h
597e d1        pop     de
597f cdd238    call    38d2h
5982 c37837    jp      3778h		; TSTOPL

5985 cdd339    call    39d3h
5988 d1        pop     de
5989 d5        push    de
598a 1a        ld      a,(de)
598b 90        sub     b
598c 18cb      jr      5959h

598e eb        ex      de,hl
598f 7e        ld      a,(hl)
5990 cdd639    call    39d6h
5993 04        inc     b
5994 05        dec     b
5995 ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
5998 c5        push    bc
5999 1eff      ld      e,0ffh
599b fe29      cp      29h
599d 2805      jr      z,59a4h
599f cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
59a0 2c        defb    ','
59a1 cd103a    call    3a10h		; GETINT
59a4 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
59a5 29        defb    ')'
59a6 f1        pop     af
59a7 e3        ex      (sp),hl
59a8 015d39    ld      bc,395dh
59ab c5        push    bc
59ac 3d        dec     a
59ad be        cp      (hl)
59ae 0600      ld      b,00h
59b0 d0        ret     nc
59b1 4f        ld      c,a
59b2 7e        ld      a,(hl)
59b3 91        sub     c
59b4 bb        cp      e
59b5 47        ld      b,a
59b6 d8        ret     c
59b7 43        ld      b,e
59b8 c9        ret

59b9 cdfb38    call    38fbh
59bc caec36    jp      z,36ech			; UNSIGNED_RESULT_A
59bf 5f        ld      e,a
59c0 23        inc     hl
59c1 7e        ld      a,(hl)
59c2 23        inc     hl
59c3 66        ld      h,(hl)
59c4 6f        ld      l,a
59c5 e5        push    hl
59c6 19        add     hl,de
59c7 46        ld      b,(hl)
59c8 72        ld      (hl),d
59c9 e3        ex      (sp),hl
59ca c5        push    bc
59cb 7e        ld      a,(hl)
59cc cdcf1c    call    1ccfh
59cf c1        pop     bc
59d0 e1        pop     hl
59d1 70        ld      (hl),b
59d2 c9        ret     
59d3 eb        ex      de,hl
59d4 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
59d5 29        defb    ')'
59d6 c1        pop     bc
59d7 d1        pop     de
59d8 c5        push    bc
59d9 43        ld      b,e
59da c9        ret

; IN BASIC instruction
59db fe7a      cp      7ah
59dd c28128    jp      nz,2881h            ; Syntax Error (SN ERROR)
59e0 c3423f    jp      3f42h
59e3 cd133a    call    3a13h		; MAKINT
59e6 3248fc    ld      (0fc48h),a        ; Current port for 'INP' function
59e9 cd47fc    call    0fc47h
59ec c3ec36    jp      36ech			; UNSIGNED_RESULT_A
59ef cd023a    call    3a02h
59f2 c34afc    jp      0fc4ah

59f5 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
59f6 cd2b32    call    322bh			; EVAL
59f9 e5        push    hl
59fa cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
59fd eb        ex      de,hl
59fe e1        pop     hl
59ff 7a        ld      a,d
5a00 b7        or      a
5a01 c9        ret


; OUT BASIC instruction
5a02 cd103a    call    3a10h		; GETINT
5a05 3248fc    ld      (0fc48h),a        ; Current port for 'INP' function
5a08 324bfc    ld      (0fc4bh),a
5a0b cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5a0c 2c        defb    ','
5a0d 1801      jr      5a10h
5a0f d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5a10 cd2b32    call    322bh			; EVAL
5a13 cdf939    call    39f9h
5a16 c2352d    jp      nz,2d35h            ; Error: Illegal function call (FC ERROR)
5a19 2b        dec     hl
5a1a d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5a1b 7b        ld      a,e
5a1c c9        ret

; __LLIST:
5a1d 3e01      ld      a,01h
5a1f 3250fc    ld      (0fc50h),a        ; Output device code 0 = Video, 1 = Printer, -1 = Cassette
;__LIST:
5a22 c1        pop     bc
5a23 cdfa29    call    29fah            ; LNUM_RANGE - Get specified line number range
5a26 c5        push    bc
5a27 21ffff    ld      hl,0ffffh
5a2a 2256fc    ld      (0fc56h),hl        ; CURLIN: Current line number
5a2d e1        pop     hl
5a2e d1        pop     de
5a2f 4e        ld      c,(hl)
5a30 23        inc     hl
5a31 46        ld      b,(hl)
5a32 23        inc     hl
5a33 78        ld      a,b
5a34 b1        or      c
5a35 ca0329    jp      z,2903h
5a38 cddbfe    call    0fedbh
5a3b cd852c    call    2c85h
5a3e c5        push    bc
5a3f 4e        ld      c,(hl)
5a40 23        inc     hl
5a41 46        ld      b,(hl)
5a42 23        inc     hl
5a43 c5        push    bc
5a44 e3        ex      (sp),hl
5a45 eb        ex      de,hl
5a46 df        rst     18h            ; DCOMPR - Compare HL with DE.
5a47 c1        pop     bc
5a48 da0229    jp      c,2902h
5a4b e3        ex      (sp),hl
5a4c e5        push    hl
5a4d c5        push    bc
5a4e eb        ex      de,hl
5a4f 220cfe    ld      (0fe0ch),hl    ; Line No. in which error occured.
5a52 cd191e    call    1e19h
5a55 3e20      ld      a,20h
5a57 e1        pop     hl
5a58 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5a5b cd723a    call    3a72h
5a5e 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
5a61 cd693a    call    3a69h        ; Print message, text ptr in (HL)
5a64 cde92f    call    2fe9h
5a67 18be      jr      5a27h

5a69 7e        ld      a,(hl)
5a6a b7        or      a
5a6b c8        ret     z
5a6c cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5a6f 23        inc     hl
5a70 18f7      jr      5a69h

5a72 e5        push    hl
5a73 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
5a76 44        ld      b,h
5a77 4d        ld      c,l
5a78 e1        pop     hl
5a79 16ff      ld      d,0ffh
5a7b 1803      jr      5a80h

5a7d 03        inc     bc
5a7e 15        dec     d
5a7f c8        ret     z
5a80 7e        ld      a,(hl)
5a81 b7        or      a
5a82 23        inc     hl
5a83 02        ld      (bc),a
5a84 c8        ret     z
5a85 f27d3a    jp      p,3a7dh
5a88 fefb      cp      0fbh
5a8a 2008      jr      nz,5a94h
5a8c 0b        dec     bc
5a8d 0b        dec     bc
5a8e 0b        dec     bc
5a8f 0b        dec     bc
5a90 14        inc     d
5a91 14        inc     d
5a92 14        inc     d
5a93 14        inc     d
5a94 fe95      cp      95h
5a96 cc8e19    call    z,198eh
5a99 d67f      sub     7fh
5a9b e5        push    hl
5a9c 5f        ld      e,a
5a9d 212e25    ld      hl,252eh
5aa0 7e        ld      a,(hl)
5aa1 b7        or      a
5aa2 23        inc     hl
5aa3 f2a03a    jp      p,3aa0h
5aa6 1d        dec     e
5aa7 20f7      jr      nz,5aa0h
5aa9 e67f      and     7fh
5aab 02        ld      (bc),a
5aac 03        inc     bc
5aad 15        dec     d
5aae cacc37    jp      z,37cch
5ab1 7e        ld      a,(hl)
5ab2 23        inc     hl
5ab3 b7        or      a
5ab4 f2ab3a    jp      p,3aabh
5ab7 e1        pop     hl
5ab8 18c6      jr      5a80h


;__DELETE:
5aba cdfa29    call    29fah            ; LNUM_RANGE - Get specified line number range
5abd d1        pop     de
5abe c5        push    bc
5abf c5        push    bc
5ac0 cd162a    call    2a16h        ; FIND_LNUM - Search for line number
5ac3 3005      jr      nc,5acah
5ac5 54        ld      d,h
5ac6 5d        ld      e,l
5ac7 e3        ex      (sp),hl
5ac8 e5        push    hl
5ac9 df        rst     18h            ; DCOMPR - Compare HL with DE.
5aca d2352d    jp      nc,2d35h            ; Error: Illegal function call (FC ERROR)
5acd 211328    ld      hl,2813h
5ad0 cd9b37    call    379bh			; Output a string
5ad3 c1        pop     bc
5ad4 21d229    ld      hl,29d2h
5ad7 e3        ex      (sp),hl
5ad8 eb        ex      de,hl
5ad9 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
5adc 1a        ld      a,(de)
5add 02        ld      (bc),a
5ade 03        inc     bc
5adf 13        inc     de
5ae0 df        rst     18h            ; DCOMPR - Compare HL with DE.
5ae1 20f9      jr      nz,5adch
5ae3 60        ld      h,b
5ae4 69        ld      l,c
5ae5 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
5ae8 c9        ret     

5ae9 fe4d      cp      4dh
5aeb ca4b08    jp      z,084bh
5aee cd2b32    call    322bh			; EVAL
5af1 e5        push    hl
5af2 cd0739    call    3907h			; __ASC_0
5af5 cd2307    call    0723h			; Cassette write on routine
5af8 3ed3      ld      a,0d3h
5afa cd3d07    call    073dh			; Cassette output routine
5afd cd3a07    call    073ah
5b00 1a        ld      a,(de)
5b01 cd3d07    call    073dh			; Cassette output routine
5b04 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
5b07 eb        ex      de,hl
5b08 2a19fe    ld      hl,(0fe19h)        ; Addr of simple variables
5b0b 1a        ld      a,(de)
5b0c 13        inc     de
5b0d cd3d07    call    073dh			; Cassette output routine
5b10 df        rst     18h            ; DCOMPR - Compare HL with DE.
5b11 20f8      jr      nz,5b0bh
5b13 cd8007    call    0780h			; Cassette off routine
5b16 e1        pop     hl
5b17 c9        ret

5b18 7e        ld      a,(hl)
5b19 fe4d      cp      4dh
5b1b caa308    jp      z,08a3h
5b1e d6b2      sub     0b2h
5b20 2802      jr      z,5b24h
5b22 af        xor     a
5b23 012f23    ld      bc,232fh
5b26 f5        push    af
5b27 2b        dec     hl
5b28 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5b29 3e00      ld      a,00h
5b2b 2807      jr      z,5b34h
5b2d cd2b32    call    322bh			; EVAL
5b30 cd0739    call    3907h			; __ASC_0
5b33 1a        ld      a,(de)
5b34 6f        ld      l,a
5b35 f1        pop     af
5b36 b7        or      a
5b37 67        ld      h,a
5b38 2241fe    ld      (0fe41h),hl        ; FACCU
5b3b cc372a    call    z,2a37h
5b3e 2a41fe    ld      hl,(0fe41h)        ; FACCU
5b41 eb        ex      de,hl
5b42 cd9e07    call    079eh		; Cassette read on routine
5b45 0603      ld      b,03h
5b47 cdc907    call    07c9h			; Casette read routine
5b4a d6d3      sub     0d3h
5b4c 20f7      jr      nz,5b45h
5b4e 10f7      djnz    5b47h
5b50 cdc907    call    07c9h			; Casette read routine
5b53 1c        inc     e
5b54 1d        dec     e
5b55 2803      jr      z,5b5ah
5b57 bb        cp      e
5b58 2037      jr      nz,5b91h
5b5a 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
5b5d 0603      ld      b,03h
5b5f cdc907    call    07c9h			; Casette read routine
5b62 5f        ld      e,a
5b63 96        sub     (hl)
5b64 a2        and     d
5b65 2021      jr      nz,5b88h
5b67 73        ld      (hl),e
5b68 cd5628    call    2856h
5b6b 7e        ld      a,(hl)
5b6c b7        or      a
5b6d 23        inc     hl
5b6e 20ed      jr      nz,5b5dh
5b70 cd2108    call    0821h
5b73 10ea      djnz    5b5fh
5b75 2219fe    ld      (0fe19h),hl        ; Addr of simple variables
5b78 211328    ld      hl,2813h
5b7b cd9b37    call    379bh			; Output a string
5b7e cd8007    call    0780h			; Cassette off routine
5b81 2a58fc    ld      hl,(0fc58h)        ; BASTXT - Address of BASIC Program
5b84 e5        push    hl
5b85 c3d229    jp      29d2h

5b88 21a33b    ld      hl,3ba3h
5b8b cd9b37    call    379bh			; Output a string
5b8e c30229    jp      2902h

5b91 323e3c    ld      (3c3eh),a
5b94 0603      ld      b,03h
5b96 cdc907    call    07c9h			; Casette read routine
5b99 b7        or      a
5b9a 20f8      jr      nz,5b94h
5b9c 10f8      djnz    5b96h
5b9e cda107    call    07a1h
5ba1 18a2      jr      5b45h

5ba3 42        ld      b,d
5ba4 41        ld      b,c
5ba5 44        ld      b,h
5ba6 0d        dec     c
5ba7 00        nop     
5ba8 cde918    call    18e9h            ; GETWORD_HL: Floating point to Integer
5bab 7e        ld      a,(hl)
5bac c3ec36    jp      36ech			; UNSIGNED_RESULT_A

5baf cdf639    call    39f6h        ; GETINT/EVAL
5bb2 d5        push    de
5bb3 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5bb4 2c        defb    ','
5bb5 cd103a    call    3a10h		; GETINT
5bb8 d1        pop     de
5bb9 12        ld      (de),a
5bba c9        ret

5bbb cd2c32    call    322ch
5bbe cd5e19    call    195eh
5bc1 cf        rst     08h            ;   SYNCHR: Check syntax: next byte holds the byte to be found
5bc2 3b        dec     sp
5bc3 eb        ex      de,hl
5bc4 2a41fe    ld      hl,(0fe41h)        ; FACCU
5bc7 1808      jr      5bd1h
5bc9 3afefd    ld      a,(0fdfeh)        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
5bcc b7        or      a
5bcd 280c      jr      z,5bdbh
5bcf d1        pop     de
5bd0 eb        ex      de,hl
5bd1 e5        push    hl
5bd2 af        xor     a
5bd3 32fefd    ld      (0fdfeh),a        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
5bd6 ba        cp      d
5bd7 f5        push    af
5bd8 d5        push    de
5bd9 46        ld      b,(hl)
5bda b0        or      b
5bdb ca352d    jp      z,2d35h            ; Error: Illegal function call (FC ERROR)
5bde 23        inc     hl
5bdf 4e        ld      c,(hl)
5be0 23        inc     hl
5be1 66        ld      h,(hl)
5be2 69        ld      l,c
5be3 181c      jr      5c01h

5be5 58        ld      e,b
5be6 e5        push    hl
5be7 0e02      ld      c,02h
5be9 7e        ld      a,(hl)
5bea 23        inc     hl
5beb fe25      cp      25h
5bed ca153d    jp      z,3d15h
5bf0 fe20      cp      20h
5bf2 2003      jr      nz,5bf7h
5bf4 0c        inc     c
5bf5 10f2      djnz    5be9h
5bf7 e1        pop     hl
5bf8 43        ld      b,e
5bf9 3e25      ld      a,25h
5bfb cd473d    call    3d47h
5bfe cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5c01 af        xor     a
5c02 5f        ld      e,a
5c03 57        ld      d,a
5c04 cd473d    call    3d47h
5c07 57        ld      d,a
5c08 7e        ld      a,(hl)
5c09 23        inc     hl
5c0a fe21      cp      21h
5c0c ca123d    jp      z,3d12h
5c0f fe23      cp      23h
5c11 2837      jr      z,5c4ah
5c13 05        dec     b
5c14 cafc3c    jp      z,3cfch
5c17 fe2b      cp      2bh
5c19 3e08      ld      a,08h
5c1b 28e7      jr      z,5c04h
5c1d 2b        dec     hl
5c1e 7e        ld      a,(hl)
5c1f 23        inc     hl
5c20 fe2e      cp      2eh
5c22 2840      jr      z,5c64h
5c24 fe25      cp      25h
5c26 28bd      jr      z,5be5h
5c28 be        cp      (hl)
5c29 20d0      jr      nz,5bfbh
5c2b fe24      cp      24h
5c2d 2814      jr      z,5c43h
5c2f fe2a      cp      2ah
5c31 20c8      jr      nz,5bfbh
5c33 78        ld      a,b
5c34 fe02      cp      02h
5c36 23        inc     hl
5c37 3803      jr      c,5c3ch
5c39 7e        ld      a,(hl)
5c3a fe24      cp      24h
5c3c 3e20      ld      a,20h
5c3e 2007      jr      nz,5c47h
5c40 05        dec     b
5c41 1c        inc     e
5c42 feaf      cp      0afh
5c44 c610      add     a,10h
5c46 23        inc     hl
5c47 1c        inc     e
5c48 82        add     a,d
5c49 57        ld      d,a
5c4a 1c        inc     e
5c4b 0e00      ld      c,00h
5c4d 05        dec     b
5c4e 2847      jr      z,5c97h
5c50 7e        ld      a,(hl)
5c51 23        inc     hl
5c52 fe2e      cp      2eh
5c54 2818      jr      z,5c6eh
5c56 fe23      cp      23h
5c58 28f0      jr      z,5c4ah
5c5a fe2c      cp      ','
5c5c 201a      jr      nz,5c78h
5c5e 7a        ld      a,d
5c5f f640      or      40h
5c61 57        ld      d,a
5c62 18e6      jr      5c4ah
5c64 7e        ld      a,(hl)
5c65 fe23      cp      23h
5c67 3e2e      ld      a,2eh
5c69 2090      jr      nz,5bfbh
5c6b 0e01      ld      c,01h
5c6d 23        inc     hl
5c6e 0c        inc     c
5c6f 05        dec     b
5c70 2825      jr      z,5c97h
5c72 7e        ld      a,(hl)
5c73 23        inc     hl
5c74 fe23      cp      23h
5c76 28f6      jr      z,5c6eh
5c78 d5        push    de
5c79 11953c    ld      de,3c95h
5c7c d5        push    de
5c7d 54        ld      d,h
5c7e 5d        ld      e,l
5c7f fe5b      cp      5bh
5c81 c0        ret     nz
5c82 be        cp      (hl)
5c83 c0        ret     nz
5c84 23        inc     hl
5c85 be        cp      (hl)
5c86 c0        ret     nz
5c87 23        inc     hl
5c88 be        cp      (hl)
5c89 c0        ret     nz
5c8a 23        inc     hl
5c8b 78        ld      a,b
5c8c d604      sub     04h
5c8e d8        ret     c
5c8f d1        pop     de
5c90 d1        pop     de
5c91 47        ld      b,a
5c92 14        inc     d
5c93 23        inc     hl
5c94 caebd1    jp      z,0d1ebh
5c97 7a        ld      a,d
5c98 2b        dec     hl
5c99 1c        inc     e
5c9a e608      and     08h
5c9c 2015      jr      nz,5cb3h
5c9e 1d        dec     e
5c9f 78        ld      a,b
5ca0 b7        or      a
5ca1 2810      jr      z,5cb3h
5ca3 7e        ld      a,(hl)
5ca4 d62d      sub     2dh
5ca6 2806      jr      z,5caeh
5ca8 fefe      cp      0feh
5caa 2007      jr      nz,5cb3h
5cac 3e08      ld      a,08h
5cae c604      add     a,04h
5cb0 82        add     a,d
5cb1 57        ld      d,a
5cb2 05        dec     b
5cb3 e1        pop     hl
5cb4 f1        pop     af
5cb5 2850      jr      z,5d07h
5cb7 c5        push    bc
5cb8 d5        push    de
5cb9 cd2b32    call    322bh			; EVAL
5cbc d1        pop     de
5cbd c1        pop     bc
5cbe c5        push    bc
5cbf e5        push    hl
5cc0 43        ld      b,e
5cc1 78        ld      a,b
5cc2 81        add     a,c
5cc3 fe19      cp      19h
5cc5 d2352d    jp      nc,2d35h            ; Error: Illegal function call (FC ERROR)
5cc8 7a        ld      a,d
5cc9 f680      or      80h
5ccb cd281e    call    1e28h
5cce cd9b37    call    379bh			; Output a string
5cd1 e1        pop     hl
5cd2 2b        dec     hl
5cd3 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5cd4 37        scf     
5cd5 280d      jr      z,5ce4h
5cd7 32fefd    ld      (0fdfeh),a        ; FLGINP: 1 = input statement active.  Also used in print using to hold seperator between string and variable.
5cda fe3b      cp      3bh
5cdc 2805      jr      z,5ce3h
5cde fe2c      cp      ','
5ce0 c28128    jp      nz,2881h            ; Syntax Error (SN ERROR)
5ce3 d7        rst     10h            ; CHRGTB: Gets next character (or token) from BASIC text.
5ce4 c1        pop     bc
5ce5 eb        ex      de,hl
5ce6 e1        pop     hl
5ce7 e5        push    hl
5ce8 f5        push    af
5ce9 d5        push    de
5cea 7e        ld      a,(hl)
5ceb 90        sub     b
5cec 23        inc     hl
5ced 4e        ld      c,(hl)
5cee 23        inc     hl
5cef 66        ld      h,(hl)
5cf0 69        ld      l,c
5cf1 1600      ld      d,00h
5cf3 5f        ld      e,a
5cf4 19        add     hl,de
5cf5 78        ld      a,b
5cf6 b7        or      a
5cf7 c2013c    jp      nz,3c01h
5cfa 1806      jr      5d02h

5cfc cd473d    call    3d47h
5cff cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5d02 e1        pop     hl
5d03 f1        pop     af
5d04 c2c93b    jp      nz,3bc9h
5d07 dce92f    call    c,2fe9h
5d0a e3        ex      (sp),hl
5d0b cdd138    call    38d1h
5d0e e1        pop     hl
5d0f c35430    jp      3054h

5d12 0e01      ld      c,01h
5d14 3ef1      ld      a,0f1h
5d16 05        dec     b
5d17 cd473d    call    3d47h
5d1a e1        pop     hl
5d1b f1        pop     af
5d1c 28e9      jr      z,5d07h
5d1e c5        push    bc
5d1f cd2b32    call    322bh			; EVAL
5d22 cd5e19    call    195eh
5d25 c1        pop     bc
5d26 c5        push    bc
5d27 e5        push    hl
5d28 2a41fe    ld      hl,(0fe41h)        ; FACCU
5d2b 41        ld      b,c
5d2c 0e00      ld      c,00h
5d2e c5        push    bc
5d2f cd5c39    call    395ch
5d32 cd9e37    call    379eh
5d35 2a41fe    ld      hl,(0fe41h)        ; FACCU
5d38 f1        pop     af
5d39 96        sub     (hl)
5d3a 47        ld      b,a
5d3b 3e20      ld      a,20h
5d3d 04        inc     b
5d3e 05        dec     b
5d3f cad13c    jp      z,3cd1h
5d42 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5d45 18f7      jr      5d3eh
5d47 f5        push    af
5d48 7a        ld      a,d
5d49 b7        or      a
5d4a 3e2b      ld      a,2bh
5d4c c4a00b    call    nz,0ba0h        ; OUTC (alias OUTDO): print character
5d4f f1        pop     af
5d50 c9        ret

5d51 324efc    ld      (0fc4eh),a            ; ERRFLG:  ERROR FLAG
5d54 2a0afe    ld      hl,(0fe0ah)            ; ERRLIN: Line No. in which error occured.
5d57 b4        or      h
5d58 a5        and     l
5d59 3c        inc     a
5d5a eb        ex      de,hl
5d5b c8        ret     z
5d5c 1804      jr      5d62h
5d5e cd3a2d    call    2d3ah                ; LNUM_PARM - Get specified line number
5d61 c0        ret     nz
5d62 e1        pop     hl
5d63 eb        ex      de,hl
5d64 220cfe    ld      (0fe0ch),hl            ; Line No. in which error occured.
5d67 eb        ex      de,hl
5d68 cd162a    call    2a16h                ; FIND_LNUM - Search for line number
5d6b d2c42d    jp      nc,2dc4h

5d6e 60        ld      h,b
5d6f 69        ld      l,c
5d70 23        inc     hl
5d71 23        inc     hl
5d72 4e        ld      c,(hl)
5d73 23        inc     hl
5d74 46        ld      b,(hl)
5d75 23        inc     hl
5d76 c5        push    bc
5d77 cd723a    call    3a72h
5d7a e1        pop     hl
5d7b e5        push    hl
5d7c cd191e    call    1e19h
5d7f 3e20      ld      a,20h
5d81 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5d84 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
5d87 3e16      ld      a,16h
5d89 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5d8c e5        push    hl
5d8d 0eff      ld      c,0ffh
5d8f 0c        inc     c
5d90 7e        ld      a,(hl)
5d91 b7        or      a
5d92 23        inc     hl
5d93 20fa      jr      nz,5d8fh
5d95 e1        pop     hl
5d96 47        ld      b,a
5d97 1600      ld      d,00h
5d99 cdac09    call    09ach        ; Console input routine
5d9c d630      sub     30h
5d9e 380e      jr      c,5daeh
5da0 fe0a      cp      0ah
5da2 300a      jr      nc,5daeh
5da4 5f        ld      e,a
5da5 7a        ld      a,d
5da6 07        rlca    
5da7 07        rlca    
5da8 82        add     a,d
5da9 07        rlca    
5daa 83        add     a,e
5dab 57        ld      d,a
5dac 18eb      jr      5d99h
5dae e5        push    hl
5daf 21973d    ld      hl,3d97h
5db2 e3        ex      (sp),hl
5db3 15        dec     d
5db4 14        inc     d
5db5 c2b93d    jp      nz,3db9h
5db8 14        inc     d
5db9 fed8      cp      0d8h
5dbb cad03e    jp      z,3ed0h
5dbe fedd      cp      0ddh
5dc0 cade3e    jp      z,3edeh
5dc3 fef0      cp      0f0h
5dc5 2841      jr      z,5e08h
5dc7 fe31      cp      31h
5dc9 3802      jr      c,5dcdh
5dcb d620      sub     20h
5dcd fe21      cp      21h
5dcf caf43e    jp      z,3ef4h
5dd2 fe1c      cp      1ch
5dd4 ca3e3e    jp      z,3e3eh
5dd7 fe23      cp      23h
5dd9 283f      jr      z,5e1ah
5ddb fe19      cp      19h
5ddd ca7b3e    jp      z,3e7bh
5de0 fe14      cp      14h
5de2 ca483e    jp      z,3e48h
5de5 fe13      cp      13h
5de7 ca633e    jp      z,3e63h
5dea fe15      cp      15h
5dec cae13e    jp      z,3ee1h
5def fe28      cp      28h
5df1 ca763e    jp      z,3e76h
5df4 fe1b      cp      1bh
5df6 281c      jr      z,5e14h
5df8 fe18      cp      18h
5dfa ca733e    jp      z,3e73h
5dfd fe11      cp      11h
5dff c0        ret     nz
5e00 c1        pop     bc
5e01 d1        pop     de
5e02 cde92f    call    2fe9h
5e05 c3633d    jp      3d63h
5e08 7e        ld      a,(hl)
5e09 b7        or      a
5e0a c8        ret     z
5e0b 04        inc     b
5e0c cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e0f 23        inc     hl
5e10 15        dec     d
5e11 20f5      jr      nz,5e08h
5e13 c9        ret

5e14 e5        push    hl
5e15 215d3e    ld      hl,3e5dh
5e18 e3        ex      (sp),hl
5e19 37        scf     
5e1a f5        push    af
5e1b cdac09    call    09ach        ; Console input routine
5e1e 5f        ld      e,a
5e1f f1        pop     af
5e20 f5        push    af
5e21 dc5d3e    call    c,3e5dh
5e24 7e        ld      a,(hl)
5e25 b7        or      a
5e26 ca3c3e    jp      z,3e3ch

5e29 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e2c f1        pop     af
5e2d f5        push    af
5e2e dc9f3e    call    c,3e9fh
5e31 3802      jr      c,5e35h
5e33 23        inc     hl
5e34 04        inc     b
5e35 7e        ld      a,(hl)
5e36 bb        cp      e
5e37 20eb      jr      nz,5e24h
5e39 15        dec     d
5e3a 20e8      jr      nz,5e24h
5e3c f1        pop     af
5e3d c9        ret     

5e3e cd693a    call    3a69h        ; Print message, text ptr in (HL)
5e41 cde92f    call    2fe9h
5e44 c1        pop     bc
5e45 c37a3d    jp      3d7ah

5e48 7e        ld      a,(hl)
5e49 b7        or      a
5e4a c8        ret     z
5e4b 3e21      ld      a,21h
5e4d cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e50 7e        ld      a,(hl)
5e51 b7        or      a
5e52 2809      jr      z,5e5dh
5e54 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e57 cd9f3e    call    3e9fh
5e5a 15        dec     d
5e5b 20f3      jr      nz,5e50h
5e5d 3e21      ld      a,21h
5e5f cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e62 c9        ret

5e63 7e        ld      a,(hl)
5e64 b7        or      a
5e65 c8        ret     z
5e66 cdac09    call    09ach        ; Console input routine
5e69 77        ld      (hl),a
5e6a cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e6d 23        inc     hl
5e6e 04        inc     b
5e6f 15        dec     d
5e70 20f1      jr      nz,5e63h
5e72 c9        ret

5e73 3600      ld      (hl),00h
5e75 48        ld      c,b
5e76 16ff      ld      d,0ffh
5e78 cd083e    call    3e08h
5e7b cdac09    call    09ach        ; Console input routine
5e7e b7        or      a
5e7f ca7b3e    jp      z,3e7bh
5e82 fe08      cp      08h
5e84 280a      jr      z,5e90h
5e86 fe0d      cp      0dh
5e88 cade3e    jp      z,3edeh
5e8b fe1b      cp      1bh
5e8d c8        ret     z
5e8e 201e      jr      nz,5eaeh
5e90 3e08      ld      a,08h
5e92 05        dec     b
5e93 04        inc     b
5e94 281f      jr      z,5eb5h
5e96 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5e99 2b        dec     hl
5e9a 05        dec     b
5e9b 117b3e    ld      de,3e7bh
5e9e d5        push    de
5e9f e5        push    hl
5ea0 0d        dec     c
5ea1 7e        ld      a,(hl)
5ea2 b7        or      a
5ea3 37        scf     
5ea4 cafa16    jp      z,16fah
5ea7 23        inc     hl
5ea8 7e        ld      a,(hl)
5ea9 2b        dec     hl
5eaa 77        ld      (hl),a
5eab 23        inc     hl
5eac 18f3      jr      5ea1h
5eae f5        push    af
5eaf 79        ld      a,c
5eb0 feff      cp      0ffh
5eb2 3803      jr      c,5eb7h
5eb4 f1        pop     af
5eb5 18c4      jr      5e7bh
5eb7 90        sub     b
5eb8 0c        inc     c
5eb9 04        inc     b
5eba c5        push    bc
5ebb eb        ex      de,hl
5ebc 6f        ld      l,a
5ebd 2600      ld      h,00h
5ebf 19        add     hl,de
5ec0 44        ld      b,h
5ec1 4d        ld      c,l
5ec2 23        inc     hl
5ec3 cd4228    call    2842h
5ec6 c1        pop     bc
5ec7 f1        pop     af
5ec8 77        ld      (hl),a
5ec9 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5ecc 23        inc     hl
5ecd c37b3e    jp      3e7bh

5ed0 78        ld      a,b
5ed1 b7        or      a
5ed2 c8        ret     z
5ed3 05        dec     b
5ed4 2b        dec     hl
5ed5 3e08      ld      a,08h
5ed7 cda00b    call    0ba0h        ; OUTC (alias OUTDO): print character
5eda 15        dec     d
5edb 20f3      jr      nz,5ed0h
5edd c9        ret     

5ede cd693a    call    3a69h        ; Print message, text ptr in (HL)
5ee1 cde92f    call    2fe9h
5ee4 c1        pop     bc
5ee5 d1        pop     de
5ee6 7a        ld      a,d
5ee7 a3        and     e
5ee8 3c        inc     a
5ee9 2ac7fd    ld      hl,(0fdc7h)        ; Pointer to address of keyboard buffer
5eec 2b        dec     hl
5eed c8        ret     z
5eee 37        scf     
5eef 23        inc     hl
5ef0 f5        push    af
5ef1 c38229    jp      2982h

5ef4 c1        pop     bc
5ef5 d1        pop     de
5ef6 c30329    jp      2903h

5ef9 00        nop     
5efa c0        ret     nz
5efb 00        nop     
5efc f20b00    jp      p,000bh
5eff f20b00    jp      p,000bh
5f02 db50      in      a,(50h)        ; get system status
5f04 cbaf      res     5,a
5f06 d370      out     (70h),a        ; Set system status
5f08 c38c28    jp      288ch        ; ERROR, E=error code

5f0b ff        rst     38h
5f0c ff        rst     38h
5f0d ff        rst     38h
5f0e ff        rst     38h
5f0f ff        rst     38h

5f10 3eff      ld      a,0ffh
5f12 181c      jr      5f30h
5f14 3efe      ld      a,0feh
5f16 1818      jr      5f30h
5f18 3efd      ld      a,0fdh
5f1a 1814      jr      5f30h
5f1c 3efc      ld      a,0fch
5f1e 1810      jr      5f30h
5f20 3efb      ld      a,0fbh
5f22 180c      jr      5f30h
5f24 3efa      ld      a,0fah
5f26 1808      jr      5f30h
5f28 3ef9      ld      a,0f9h
5f2a 1804      jr      5f30h
5f2c 3ef8      ld      a,0f8h
5f2e 1800      jr      5f30h
5f30 1822      jr      5f54h
5f32 3ef7      ld      a,0f7h
5f34 181e      jr      5f54h
5f36 3ef6      ld      a,0f6h
5f38 181a      jr      5f54h
5f3a 3ef5      ld      a,0f5h
5f3c 1816      jr      5f54h
5f3e 3ef4      ld      a,0f4h
5f40 1812      jr      5f54h
5f42 1822      jr      5f66h
5f44 180e      jr      5f54h
5f46 3ef2      ld      a,0f2h
5f48 180a      jr      5f54h
5f4a 3ef1      ld      a,0f1h
5f4c 1806      jr      5f54h
5f4e 3ef0      ld      a,0f0h
5f50 1802      jr      5f54h

5f52 00        nop     
5f53 00        nop     
5f54 f5        push    af
5f55 db50      in      a,(50h)        ; get system status
5f57 cbef      set     5,a
5f59 d370      out     (70h),a        ; Set system status
5f5b f1        pop     af
5f5c cd0003    call    0300h
5f5f db50      in      a,(50h)        ; get system status
5f61 cbaf      res     5,a
5f63 d370      out     (70h),a        ; Set system status
5f65 c9        ret     
5f66 f5        push    af
5f67 db50      in      a,(50h)        ; get system status
5f69 cbef      set     5,a
5f6b d370      out     (70h),a        ; Set system status
5f6d f1        pop     af
5f6e cd0303    call    0303h
5f71 db50      in      a,(50h)        ; get system status
5f73 cbaf      res     5,a
5f75 d370      out     (70h),a        ; Set system status
5f77 c9        ret     
5f78 ff        rst     38h
5f79 ff        rst     38h
5f7a ff        rst     38h
5f7b ff        rst     38h
5f7c ff        rst     38h
5f7d ff        rst     38h
5f7e ff        rst     38h
5f7f ff        rst     38h
5f80 dd21933f  ld      ix,3f93h
5f84 fde1      pop     iy
5f86 dde5      push    ix
5f88 fde5      push    iy
5f8a f5        push    af
5f8b db50      in      a,(50h)        ; get system status
5f8d cbaf      res     5,a
5f8f d370      out     (70h),a        ; Set system status
5f91 f1        pop     af
5f92 c9        ret     
5f93 f5        push    af
5f94 db50      in      a,(50h)        ; get system status
5f96 cbef      set     5,a
5f98 d370      out     (70h),a        ; Set system status
5f9a f1        pop     af
5f9b c9        ret     
5f9c f5        push    af
5f9d db50      in      a,(50h)        ; get system status
5f9f cbef      set     5,a
5fa1 d370      out     (70h),a        ; Set system status
5fa3 f1        pop     af
5fa4 c34503    jp      0345h
5fa7 ff        rst     38h
5fa8 ff        rst     38h
5fa9 ff        rst     38h
5faa ff        rst     38h
5fab ff        rst     38h
5fac ff        rst     38h
5fad ff        rst     38h
5fae ff        rst     38h
5faf ff        rst     38h
5fb0 ff        rst     38h
5fb1 ff        rst     38h
5fb2 ff        rst     38h
5fb3 ff        rst     38h
5fb4 ff        rst     38h
5fb5 ff        rst     38h
5fb6 ff        rst     38h
5fb7 ff        rst     38h
5fb8 ff        rst     38h
5fb9 ff        rst     38h
5fba ff        rst     38h
5fbb ff        rst     38h
5fbc ff        rst     38h
5fbd ff        rst     38h
5fbe ff        rst     38h
5fbf ff        rst     38h
5fc0 ff        rst     38h
5fc1 ff        rst     38h
5fc2 ff        rst     38h
5fc3 ff        rst     38h
5fc4 ff        rst     38h
5fc5 ff        rst     38h
5fc6 ff        rst     38h
5fc7 ff        rst     38h
5fc8 ff        rst     38h
5fc9 ff        rst     38h
5fca ff        rst     38h
5fcb ff        rst     38h
5fcc ff        rst     38h
5fcd ff        rst     38h
5fce ff        rst     38h
5fcf ff        rst     38h
5fd0 ff        rst     38h
5fd1 ff        rst     38h
5fd2 ff        rst     38h
5fd3 ff        rst     38h
5fd4 ff        rst     38h
5fd5 ff        rst     38h
5fd6 ff        rst     38h
5fd7 ff        rst     38h
5fd8 ff        rst     38h
5fd9 ff        rst     38h
5fda ff        rst     38h
5fdb ff        rst     38h
5fdc ff        rst     38h
5fdd ff        rst     38h
5fde ff        rst     38h
5fdf ff        rst     38h
5fe0 ff        rst     38h
5fe1 ff        rst     38h
5fe2 ff        rst     38h
5fe3 ff        rst     38h
5fe4 ff        rst     38h
5fe5 ff        rst     38h
5fe6 ff        rst     38h
5fe7 ff        rst     38h
5fe8 ff        rst     38h
5fe9 ff        rst     38h
5fea cd9e1e    call    1e9eh
5fed b6        or      (hl)
5fee cd431e    call    1e43h
5ff1 c9        ret     
5ff2 7e        ld      a,(hl)
5ff3 c9        ret     
5ff4 5e        ld      e,(hl)
5ff5 23        inc     hl
5ff6 56        ld      d,(hl)
5ff7 c9        ret     
5ff8 1a        ld      a,(de)
5ff9 c9        ret     
5ffa dde9      jp      (ix)
5ffc e1        pop     hl
5ffd 2e65      ld      l,65h
5fff 86        add     a,(hl)

Disassembled 14180 instructions.
