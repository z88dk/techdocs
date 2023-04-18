 F200  jp   $DC00          ; BOOT                          C3 00 DC        //  Cold start routine
 F203  jp   $F2E5          ; WBOOT                         C3 E5 F2        //  Warm boot - reload command processor
 F206  jp   $F30A          ; CONST                         C3 0A F3        //  Console status
 F209  jp   $F348          ; CONIN                         C3 48 F3        //  Console input
 F20C  jp   $F4A3          ; CONOUT                        C3 A3 F4        //  Console output
 F20F  jp   $F572          ; LIST                          C3 72 F5        //  Printer output
 F212  jp   $F599          ; PUNCH                         C3 99 F5        //  Paper tape punch output
 F215  jp   $F5B0          ; JMP                           C3 B0 F5        //  Paper tape reader input
 F218  jp   $F5B9          ; HOME                          C3 B9 F5        //  Move disc head to track 0
 F21B  jp   $F5F5          ; SELDSK                        C3 F5 F5        //  Select disc drive
 F21E  jp   $F60B          ; SETTRK                        C3 0B F6        //  Set track number
 F221  jp   $F610          ; SETSEC                        C3 10 F6        //  Set sector number
 F224  jp   $F61B          ; SETDMA                        C3 1B F6        //  Set DMA address
 F227  jp   $F629          ; READ                          C3 29 F6        //  Read a sector
 F22A  jp   $F6D6          ; WRITE                         C3 D6 F6        //  Write a sector
 F22D  jp   $F534          ; LISTST                        C3 34 F5        //  Status of list device
 F230  jp   $F615          ; SECTRAN                       C3 15 F6        //  Sector translation for skewing

 F233  call pe,$00F3                                       EC F3 00
 F236  nop                                                 00
 F235  defw 0       ; point to a 128 bytes sector buffer
 F237  defw $F2A7   ; DPB
 F239  defw $001C   ; CSV (directory checksum vector)
 F23B  defw 0       ; ALV (allocation vector)


 F23C  nop                                                 00
 F23D  nop                                                 00
 F23E  nop                                                 00
 F23F  defw $FE00   ; point to a 128 bytes sector buffer
 F241  defw $F2D6   ; DPB
 F243  defw $FA17   ; CSV (directory checksum vector)
 F245  defw $F9B3   ; ALV (allocation vector)


 F247  defw $F2A7   ; DPB

 F247  and  a                                              A7
 F248  jp   p,$0000                                        F2 00 00
 F24B  nop                                                 00
 F24C  nop                                                 00
 F24D  nop                                                 00
 F24E  nop                                                 00
 F24F  nop                                                 00
 F250  cp   $D6                                            FE D6

 F251  defw $F2D6   ; DPB

 F252  jp   p,$FA37                                        F2 37 FA
 F255  rst  $00                                            C7
 F256  ld   sp,hl                                          F9
 F257  and  a                                              A7
 F258  jp   p,$0000                                        F2 00 00
 F25B  nop                                                 00
 F25C  nop                                                 00
 F25D  nop                                                 00
 F25E  nop                                                 00
 F25F  nop                                                 00
 F260  cp   $D6                                            FE D6

 F262  jp   p,$FA57                                        F2 57 FA
 F265  in   a,($F9)                                        DB F9
 F267  and  a                                              A7
 F268  jp   p,$0000                                        F2 00 00
 F26B  nop                                                 00
 F26C  nop                                                 00
 F26D  nop                                                 00
 F26E  nop                                                 00
 F26F  nop                                                 00
 F270  cp   $D6                                            FE D6

 F272  jp   p,$FA77                                        F2 77 FA
 F275  rst  $28                                            EF
 F276  ld   sp,hl                                          F9
 F277  and  a                                              A7
 F278  jp   p,$0000                                        F2 00 00
 F27B  nop                                                 00
 F27C  nop                                                 00
 F27D  nop                                                 00
 F27E  nop                                                 00
 F27F  nop                                                 00
 F280  cp   $D6                                            FE D6

 F282  jp   p,$FA97                                        F2 97 FA
 F285  inc  bc                                             03
 F286  jp   m,$F2A7                                        FA A7 F2
 F289  nop                                                 00
 F28A  nop                                                 00
 F28B  nop                                                 00
 F28C  nop                                                 00
 F28D  nop                                                 00
 F28E  nop                                                 00
 F28F  nop                                                 00
 F290  cp   $C7                                            FE C7

 F292  jp   p,$FAA7                                        F2 A7 FA
 F295  inc  bc                                             03
 F296  jp   m,$F2A7                                        FA A7 F2
 F299  nop                                                 00
 F29A  nop                                                 00
 F29B  nop                                                 00
 F29C  nop                                                 00
 F29D  nop                                                 00
 F29E  nop                                                 00
 F29F  nop                                                 00
 F2A0  cp   $C7                                            FE C7

 F2A2  jp   p,$FAB7                                        F2 B7 FA
 F2A5  inc  bc                                             03
 F2A6  jp   m,$0201                                        FA 01 02
 F2A9  rlca                                                07
 F2AA  ex   af,af'                                         08
 F2AB  dec  c                                              0D
 F2AC  ld   c,$13                                          0E 13
 F2AE  inc  d                                              14
 F2AF  add  hl,de                                          19
 F2B0  ld   a,(de)                                         1A

 F2B1  rra                                                 1F
 F2B2  jr   nz,$F2B9                                       20 05
 F2B4  ld   b,$0B                                          06 0B
 F2B6  inc  c                                              0C

     F2B8  12 17 18 1D 1E 03 04 09 0A 0F 10 15 16 1B 1C 

 F2B7  ld   de,$1712                                       11 12 17
 F2BA  jr   $F2D9                                          18 1D
 F2BC  ld   e,$03                                          1E 03
 F2BE  inc  b                                              04

 F2BF  add  hl,bc                                          09
 F2C0  ld   a,(bc)                                         0A
 F2C1  rrca                                                0F
 F2C2  djnz $F2D9                                          10 15
 F2C4  ld   d,$1B                                          16 1B
 F2C6  inc  e                                              1C




; The Disk Parameter Block ( DPB ) summarizes the attributes of identical groups of mass storage devices.

     F2C7  20 00 04 0F 01 9B 00 3F 00 80 00 10 00 02 00

     F2D6  20 00 05 1F 03 9B 00 7F 00 80 00 20 00 04 00

;
; -----  WBOOT, Warm boot - reload command processor  -----
;
 
 F2E5  ld   a,($F9B1)                                      3A B1 F9
 F2E8  or   a                                              B7
 F2E9  call nz,$F620                                       C4 20 F6
 F2EC  ld   sp,$0080                                       31 80 00
 F2EF  ld   c,$00                                          0E 00
 F2F1  call $F5F5       ; SELDSK, Select disc drive        CD F5 F5
 F2F4  call $F5B9       ; HOME, Move disc head to trk 0    CD B9 F5
 F2F7  ld   c,$01                                          0E 01
 F2F9  call $F610       ; SETSEC, Set sector number        CD 10 F6
 F2FC  ld   bc,$FF00                                       01 00 FF
 F2FF  call $F61B       ; SETDMA, Set DMA address          CD 1B F6
 F302  call $F629       ; READ, (Read a sector)            CD 29 F6
 F305  ld   d,$F2                                          16 F2
 F307  jp   $FF1D                                          C3 1D FF
 
 
;
; -----  CONST, Console status  -----
;
 
 F30A  ld   de,($F530)                                     ED 5B 30 F5
 F30E  ld   a,d                                            7A
 F30F  or   a                                              B7
 F310  call nz,$F321                                       C4 21 F3
 F313  ld   a,($F236)                                      3A 36 F2
 F316  or   a                                              B7
 F317  jr   nz,$F31E                                       20 05
 F319  in   a,($E1)                                        DB E1
 F31B  and  $02                                            E6 02
 F31D  ret  z                                              C8
 F31E  ld   a,$FF                                          3E FF
 F320  ret                                                 C9

 F321  and  $40                                            E6 40
 F323  jp   z,$F521                                        CA 21 F5
 F326  ld   hl,($F532)                                     2A 32 F5
 F329  dec  hl                                             2B
 F32A  ld   ($F532),hl                                     22 32 F5
 F32D  ld   a,h                                            7C
 F32E  or   l                                              B5
 F32F  jp   z,$F521                                        CA 21 F5
 F332  ld   b,$00                                          06 00
 F334  call $F50F                                          CD 0F F5
 F337  jp   z,$F521                                        CA 21 F5
 F33A  in   a,($E8)        ; PPI_M, port A                 DB E8
 F33C  ld   l,a                                            6F
 F33D  ld   h,$7F                                          26 7F
 F33F  ld   ($F530),hl                                     22 30 F5
 F342  ret                                                 C9


 F343  call $F39C                                          CD 9C F3
 F346  ld   a,c                                            79
 F347  ret                                                 C9


;
; ----- CONIN, Console input  -----
;
 
 F348  ld   a,($F236)                                      3A 36 F2
 F34B  or   a                                              B7
 F34C  jr   nz,$F343                                       20 F5
 F34E  in   a,($E1)                                        DB E1
 F350  ld   b,a                                            47
 F351  and  $02                                            E6 02
 F353  jr   z,$F34E                                        28 F9
 F355  in   a,($E0)                                        DB E0
 F357  ld   c,a                                            4F
 F358  cp   $E2                                            FE E2
 F35A  jr   z,$F34E                                        28 F2
 F35C  cp   $E3                                            FE E3
 F35E  jr   z,$F34E                                        28 EE
 F360  call $F38F                                          CD 8F F3
 F363  bit  3,b                                            CB 58
 F365  call nz,$F378                                       C4 78 F3
 F368  in   a,($E9)      ; PPI_M, port B                   DB E9
 F36A  or   $02          ; key click (bit1, speaker "ON")  F6 02
 F36C  out  ($E9),a      ; PPI_M, port B                   D3 E9
 F36E  ld   b,$00                                          06 00
 F370  djnz $F370                                          10 FE
 F372  and  $FD          ; key click (bit1, speaker "OFF") E6 FD
 F374  out  ($E9),a      ; PPI_M, port B                   D3 E9
 F376  ld   a,c                                            79
 F377  ret                                                 C9

 F378  ld   a,c                                            79
 F379  cp   $7F                                            FE 7F
 F37B  jr   nc,$F38A                                       30 0D
 F37D  cp   $40                                            FE 40
 F37F  jr   c,$F38A                                        38 09
 F381  cp   $60                                            FE 60
 F383  jr   c,$F387                                        38 02
 F385  sub  $20                                            D6 20
 F387  sub  $40                                            D6 40
 F389  ld   c,a                                            4F
 F38A  ld   a,$3E                                          3E 3E
 F38C  out  ($E1),a                                        D3 E1
 F38E  ret                                                 C9
 F38F  call $F3C2                                          CD C2 F3
 F392  cp   $E9                                            FE E9
 F394  ret  c                                              D8
 F395  ld   b,$00                                          06 00
 F397  sub  $E9                                            D6 E9
 F399  ld   ($F235),a                                      32 35 F2
 
 F39C  ld   a,($F235)                                      3A 35 F2
 F39F  add  a,a                                            87
 F3A0  add  a,a                                            87
 F3A1  add  a,a                                            87
 F3A2  ld   d,$00                                          16 00
 F3A4  ld   e,a                                            5F

 F3A5  ld   hl,($F233)                                     2A 33 F2
 F3A8  add  hl,de                                          19
 F3A9  ld   a,($F236)                                      3A 36 F2
 F3AC  ld   e,a                                            5F
 F3AD  add  hl,de                                          19
 F3AE  ld   c,(hl)                                         4E
 F3AF  inc  a                                              3C

 F3B0  ld   ($F236),a                                      32 36 F2
 F3B3  cp   $08                                            FE 08
 F3B5  jr   z,$F3BB                                        28 04
 F3B7  inc  hl                                             23
 F3B8  ld   a,(hl)                                         7E
 F3B9  or   a                                              B7
 F3BA  ret  nz                                             C0
 F3BB  ld   hl,$0000                                       21 00 00
 F3BE  ld   ($F235),hl                                     22 35 F2
 F3C1  ret                                                 C9

 F3C2  ld   a,c                                            79
 F3C3  cp   $20                                            FE 20
 F3C5  call c,$F3E0                                        DC E0 F3
 F3C8  cp   $80                                            FE 80
 F3CA  ret  c                                              D8
 F3CB  cp   $A0                                            FE A0
 F3CD  call c,$F3E0                                        DC E0 F3
 F3D0  cp   $E0                                            FE E0
 F3D2  ret  c                                              D8
 F3D3  cp   $E9                                            FE E9
 F3D5  ret  nc                                             D0
 F3D6  ld   hl,$F3BA                                       21 BA F3
 F3D9  ld   d,$00                                          16 00
 F3DB  ld   e,a                                            5F
 F3DC  add  hl,de                                          19
 F3DD  ld   c,(hl)                                         4E
 F3DE  ld   a,(hl)                                         7E
 F3DF  ret                                                 C9

 F3E0  and  $7F                                            E6 7F
 F3E2  add  a,$20                                          C6 20
 F3E4  ld   c,a                                            4F
 F3E5  cp   $3F                                            FE 3F
 F3E7  ret  nz                                             C0
 F3E8  ld   a,$EA                                          3E EA
 F3EA  ld   c,a                                            4F
 F3EB  ret                                                 C9


 F3EC  ld   b,$00                                          06 00
 F3EE  nop                                                 00
 F3EF  nop                                                 00
 F3F0  nop                                                 00
 F3F1  nop                                                 00
 F3F2  nop                                                 00
 F3F3  nop                                                 00
 F3F4  dec  c                                              0D
 F3F5  nop                                                 00
 F3F6  nop                                                 00
 F3F7  nop                                                 00
 F3F8  nop                                                 00
 F3F9  nop                                                 00
 F3FA  nop                                                 00
 F3FB  nop                                                 00
 F3FC  ld   b,h                                            44
 F3FD  ld   c,c                                            49
 F3FE  ld   d,d                                            52
 F3FF  jr   nz,$F401                                       20 00
 F401  nop                                                 00
 F402  nop                                                 00
 F403  nop                                                 00
 F404  ld   d,h                                            54
 F405  ld   e,c                                            59
 F406  ld   d,b                                            50
 F407  ld   b,l                                            45
 F408  jr   nz,$F40A                                       20 00
 F40A  nop                                                 00
 F40B  nop                                                 00
 F40C  ld   d,d                                            52
 F40D  ld   b,l                                            45
 F40E  ld   c,(hl)                                         4E
 F40F  jr   nz,$F411                                       20 00
 F411  nop                                                 00
 F412  nop                                                 00
 F413  nop                                                 00
 F414  ld   d,e                                            53
 F415  ld   b,c                                            41
 F416  ld   d,(hl)                                         56
 F417  ld   b,l                                            45
 F418  jr   nz,$F41A                                       20 00
 F41A  nop                                                 00
 F41B  nop                                                 00
 F41C  ld   b,l                                            45
 F41D  ld   d,d                                            52
 F41E  ld   b,c                                            41
 F41F  jr   nz,$F421                                       20 00
 F421  nop                                                 00
 F422  nop                                                 00
 F423  nop                                                 00
 F424  ld   d,e                                            53
 F425  ld   d,h                                            54
 F426  ld   b,c                                            41
 F427  ld   d,h                                            54
 F428  jr   nz,$F42A                                       20 00
 F42A  nop                                                 00
 F42B  nop                                                 00
 F42C  ld   d,e                                            53
 F42D  ld   d,l                                            55
 F42E  ld   b,d                                            42
 F42F  ld   c,l                                            4D
 F430  ld   c,c                                            49
 F431  ld   d,h                                            54
 F432  jr   nz,$F434                                       20 00
 F434  ld   d,b                                            50
 F435  ld   c,c                                            49
 F436  ld   d,b                                            50
 F437  nop                                                 00
 F438  nop                                                 00
 F439  nop                                                 00
 F43A  nop                                                 00
 F43B  nop                                                 00
 F43C  ld   b,h                                            44
 F43D  ld   b,h                                            44
 F43E  ld   d,h                                            54
 F43F  jr   nz,$F441                                       20 00
 F441  nop                                                 00
 F442  nop                                                 00
 F443  nop                                                 00
 F444  ld   b,c                                            41
 F445  ld   d,e                                            53
 F446  ld   c,l                                            4D
 F447  jr   nz,$F449                                       20 00
 F449  nop                                                 00
 F44A  nop                                                 00
 F44B  nop                                                 00
 F44C  ld   b,l                                            45
 F44D  ld   b,h                                            44
 F44E  jr   nz,$F450                                       20 00
 F450  nop                                                 00
 F451  nop                                                 00
 F452  nop                                                 00
 F453  nop                                                 00
 F454  dec  de                                             1B
 F455  ld   b,e                                            43
 F456  dec  c                                              0D
 F457  nop                                                 00
 F458  nop                                                 00
 F459  nop                                                 00
 F45A  nop                                                 00
 F45B  nop                                                 00
 F45C  dec  de                                             1B
 F45D  ld   c,e                                            4B
 F45E  dec  c                                              0D
 F45F  nop                                                 00
 F460  nop                                                 00
 F461  nop                                                 00
 F462  nop                                                 00
 F463  nop                                                 00
 F464  dec  de                                             1B
 F465  ld   b,c                                            41
 F466  dec  c                                              0D
 F467  nop                                                 00
 F468  nop                                                 00
 F469  nop                                                 00
 F46A  nop                                                 00
 F46B  nop                                                 00
 F46C  dec  de                                             1B
 F46D  ld   c,l                                            4D
 F46E  dec  c                                              0D
 F46F  nop                                                 00
 F470  nop                                                 00
 F471  nop                                                 00
 F472  nop                                                 00
 F473  nop                                                 00
 F474  ex   af,af'                                         08
 F475  nop                                                 00
 F476  nop                                                 00
 F477  nop                                                 00
 F478  nop                                                 00
 F479  nop                                                 00
 F47A  nop                                                 00
 F47B  nop                                                 00
 F47C  inc  c                                              0C
 F47D  nop                                                 00
 F47E  nop                                                 00
 F47F  nop                                                 00
 F480  nop                                                 00
 F481  nop                                                 00
 F482  nop                                                 00
 F483  nop                                                 00
 F484  dec  bc                                             0B
 F485  nop                                                 00
 F486  nop                                                 00
 F487  nop                                                 00
 F488  nop                                                 00
 F489  nop                                                 00
 F48A  nop                                                 00
 F48B  nop                                                 00
 F48C  ld   a,(bc)                                         0A
 F48D  nop                                                 00
 F48E  nop                                                 00
 F48F  nop                                                 00
 F490  nop                                                 00
 F491  nop                                                 00
 F492  nop                                                 00
 F493  nop                                                 00
 F494  inc  d                                              14
 F495  nop                                                 00
 F496  nop                                                 00
 F497  nop                                                 00
 F498  nop                                                 00
 F499  nop                                                 00
 F49A  nop                                                 00
 F49B  nop                                                 00
 F49C  ld   c,$0F                                          0E 0F
 F49E  ex   af,af'                                         08
 F49F  add  hl,bc                                          09
 F4A0  ld   a,(bc)                                         0A
 F4A1  dec  c                                              0D
 F4A2  dec  de                                             1B

;
; -----  CONOUT, Console output  -----
;
 F4A3  in   a,($EA)                                        DB EA
 F4A5  and  $80                                            E6 80
 F4A7  jr   z,$F4A3                                        28 FA
 
 F4A9  in   a,($E9)      ; PPI_M, port B                   DB E9
 F4AB  and  $FE          ; PB0 -> PA5                      E6 FE
 F4AD  out  ($E9),a                                        D3 E9

 F4AF  ld   a,c                                            79
 F4B0  out  ($E8),a      ; PPI_M, port A                   D3 E8
;-----

 F4B2  cp   27                                             FE 1B
 F4B4  jr   z,$F518      ; Go set the ESC flag             28 62
 
 F4B6  cp   ' '          ; Blank?                          FE 20
 F4B8  ret  c                                              D8
 
 F4B9  ld   a,($F52F)                                      3A 2F F5
 F4BC  or   a            ; In-ESC ?                        B7
 F4BD  ret  z            ; no? RET                         C8
 
 --- in ESC ---
 F4BE  cp   $02                                            FE 02
 F4C0  jr   z,$F4D3                                        28 11
 F4C2  jr   nc,$F521                                       30 5D
 F4C4  ld   a,c                                            79
 F4C5  cp   'Q'                                            FE 51
 F4C7  jr   z,$F4F0                                        28 27
 F4C9  cp   '0'                                            FE 48
 F4CB  jr   nz,$F521                                       20 54
 F4CD  ld   a,$02                                          3E 02
 F4CF  ld   ($F52F),a                                      32 2F F5
 F4D2  ret                                                 C9
 
 F4D3  ld   a,c                                            79
 F4D4  cp   'R'                                            FE 52
 F4D6  jr   nz,$F521                                       20 49
 F4D8  in   a,($E8)        ; PPI_M, port A                 DB E8
 F4DA  ld   b,$00                                          06 00
 F4DC  call $F50F                                          CD 0F F5
 F4DF  jr   z,$F521                                        28 40
 F4E1  in   a,($E8)        ; PPI_M, port A                 DB E8
 F4E3  ld   l,a                                            6F
 F4E4  ld   h,$7F                                          26 7F
 F4E6  ld   ($F530),hl                                     22 30 F5
 F4E9  ld   hl,$7D00                                       21 00 7D
 F4EC  ld   ($F532),hl                                     22 32 F5
 F4EF  ret                                                 C9
 
 --- ESC 'Q' ---
 F4F0  in   a,($E8)        ; PPI_M, port A                 DB E8
 F4F2  ld   b,$00                                          06 00
 F4F4  call $F50F                                          CD 0F F5
 F4F7  jr   z,$F521                                        28 28
 F4F9  in   a,($E8)        ; PPI_M, port A                 DB E8
 F4FB  or   $80                                            F6 80
 F4FD  ld   h,a                                            67
 F4FE  ld   b,$04                                          06 04
 F500  call $F50F                                          CD 0F F5
 F503  jr   z,$F521                                        28 1C
 F505  in   a,($E8)        ; PPI_M, port A                 DB E8
 F507  ld   l,a                                            6F
 F508  ld   ($F530),hl                                     22 30 F5
 F50B  call $F52A         ; reset the ESC flag             CD 2A F5
 F50E  ret                                                 C9

 F50F  in   a,($EA)                                        DB EA
 F511  bit  5,a                                            CB 6F
 F513  ret  nz                                             C0
 F514  djnz $F50F                                          10 F9
 F516  xor  a                                              AF
 F517  ret                                                 C9

-- Set the ESC flag -- 
 F518  ld   a,($F52F)                                      3A 2F F5
 F51B  or   a                                              B7
 F51C  jr   nz,$F52A                                       20 0C
 F51E  inc  a                                              3C
 F51F  jr   $F52B                                          18 0A
 F521  ld   hl,$0000                                       21 00 00
 F524  ld   ($F530),hl                                     22 30 F5
 F527  ld   ($F532),hl                                     22 32 F5
 
 F52A  xor  a                                              AF
 F52B  ld   ($F52F),a                                      32 2F F5
 F52E  ret                                                 C9

 F52F  defb 0                                              00
 F530  defw 0                                              00 00
 F532  defw 0                                              00 00



;
; -----  LISTST, Status of list device  -----
;

 F534  ld   a,($0003)                                      3A 03 00
 F537  and  $C0                                            E6 C0
 F539  cp   $00                                            FE 00
 F53B  jp   z,$F54B                                        CA 4B F5
 F53E  cp   $40                                            FE 40
 F540  jp   z,$F555                                        CA 55 F5
 F543  cp   $80                                            FE 80
 F545  jp   z,$F558                                        CA 58 F5
 F548  jp   $F560                                          C3 60 F5
 F54B  in   a,($ED)                                        DB ED
 F54D  and  $01                                            E6 01
 F54F  jp   nz,$F56C                                       C2 6C F5
 F552  jp   $F56F                                          C3 6F F5
 F555  jp   $F30A                                          C3 0A F3
 F558  in   a,($EA)                                        DB EA
 F55A  and  $80                                            E6 80
 F55C  jr   z,$F56F                                        28 11
 F55E  jr   $F56C                                          18 0C
 F560  in   a,($ED)                                        DB ED
 F562  and  $85                                            E6 85
 F564  cp   $85                                            FE 85
 F566  jp   nz,$F56F                                       C2 6F F5
 F569  jp   $F56C                                          C3 6C F5
 F56C  ld   a,$FF                                          3E FF
 F56E  ret                                                 C9

 F56F  ld   a,$00                                          3E 00
 F571  ret                                                 C9


;
; -----  LIST, Printer output  -----
;

 F572  ld   a,($0003)                                      3A 03 00
 F575  and  $C0                                            E6 C0
 F577  cp   $00                                            FE 00
 F579  jp   z,$F599                                        CA 99 F5
 F57C  cp   $40                                            FE 40
 F57E  jp   z,$F4A3    ; CONOUT, Console output            CA A3 F4
 F581  cp   $80                                            FE 80
 F583  jp   z,$F589                                        CA 89 F5
 F586  jp   $F5A3                                          C3 A3 F5
  
;--------
 F589  in   a,($EA)    <--                                 DB EA
 F58B  and  $80           |                                E6 80
 F58D  jr   z,$F589     --                                 28 FA

 F58F  in   a,($E9)      ; PPI_M, port B                   DB E9
 F591  or   $01          ; PB0 -> PA5                      F6 01
 F593  out  ($E9),a                                        D3 E9

 F595  ld   a,c                                            79
 F596  out  ($E8),a      ; PPI_M, port A                   D3 E8
 F598  ret                                                 C9

;--------
 F599  in   a,($ED)    <--                                 DB ED
 F59B  bit  0,a           |                                CB 47
 F59D  jr   z,$F599     --                                 28 FA

 F59F  ld   a,c                                            79
 F5A0  out  ($EC),a                                        D3 EC
 F5A2  ret                                                 C9

;--------
 F5A3  in   a,($ED)    <--                                 DB ED
 F5A5  and  $85           |                                E6 85
 F5A7  cp   $85           |                                FE 85
 F5A9  jp   nz,$F5A3    --                                 C2 A3 F5

 F5AC  ld   a,c                                            79
 F5AD  out  ($EC),a                                        D3 EC
 F5AF  ret                                                 C9
 
 
;
; -----  JMP, Paper tape reader input  -----
;

 F5B0  in   a,($ED)                                        DB ED
 F5B2  bit  1,a                                            CB 4F
 F5B4  jr   z,$F5B0                                        28 FA
 F5B6  in   a,($EC)                                        DB EC
 F5B8  ret                                                 C9


;
; -----  HOME, Move disc head to track 0  -----
;

 F5B9  ld   a,($F9A8)       ; Disk no.                     3A A8 F9
 F5BC  ld   c,a                                            4F
 F5BD  call $F807                                          CD 07 F8
 F5C0  ld   c,$FF                                          0E FF
 F5C2  ld   a,($F99D)                                      3A 9D F9
 F5C5  cp   $06                                            FE 06
 F5C7  jr   nz,$F5CB                                       20 02
 F5C9  ld   c,$FC                                          0E FC
 F5CB  ld   a,$F7                                          3E F7
 F5CD  and  c                                              A1
 F5CE  out  ($E4),a                                        D3 E4
 F5D0  ex   (sp),hl                                        E3
 F5D1  ex   (sp),hl                                        E3
 F5D2  ex   (sp),hl                                        E3
 F5D3  ex   (sp),hl                                        E3
 F5D4  ex   (sp),hl                                        E3
 F5D5  ex   (sp),hl                                        E3
 F5D6  ld   hl,($F99D)                                     2A 9D F9
 F5D9  ld   a,l                                            7D
 F5DA  cp   $04                                            FE 04
 F5DC  jr   nz,$F5E0                                       20 02
 F5DE  ld   l,$00                                          2E 00
 F5E0  cp   $05                                            FE 05
 F5E2  jr   nz,$F5E6                                       20 02
 F5E4  ld   l,$01                                          2E 01
 F5E6  xor  a                                              AF
 F5E7  ld   ($F9A9),a      ; Set track number to 0         32 A9 F9
 F5EA  ld   de,$F99F                                       11 9F F9
 F5ED  add  hl,de                                          19
 F5EE  ld   (hl),a                                         77
 F5EF  in   a,($E4)                                        DB E4
 F5F1  rra                                                 1F
 F5F2  jr   nc,$F5EF                                       30 FB
 F5F4  ret                                                 C9


;
; -----  SELDSK, Select disc drive  -----
;

 F5F5  ld   hl,$0000                                       21 00 00
 F5F8  ld   a,c                                            79
 F5F9  cp   $07          ; "A:" .. "H:"                    FE 07
 F5FB  ret  nc                                             D0
 F5FC  ld   ($F9A8),a    ; Disk no.                        32 A8 F9
 F5FF  ld   l,a                                            6F
 F600  ld   h,$00                                          26 00
 F602  add  hl,hl                                          29
 F603  add  hl,hl                                          29
 F604  add  hl,hl                                          29
 F605  add  hl,hl                                          29
 F606  ld   de,$F237                                       11 37 F2
 F609  add  hl,de                                          19
 F60A  ret                                                 C9


;
; -----  SETTRK, Set track number  -----
;

 F60B  ld   a,c                                            79
 F60C  ld   ($F9A9),a                                      32 A9 F9
 F60F  ret                                                 C9


;
; -----  SETSEC, Set sector number  -----
;

 F610  ld   a,c                                            79
 F611  ld   ($F9AA),a                                      32 AA F9
 F614  ret                                                 C9
 

;
; -----  SECTRAN, Sector translation for skewing  -----
;

 F615  ex   de,hl                                          EB
 F616  add  hl,bc                                          09
 F617  ld   l,(hl)                                         6E
 F618  ld   h,$00                                          26 00
 F61A  ret                                                 C9

 
;
; -----  SETDMA, Set DMA address  -----
;

 F61B  ld   ($F9A6),bc                                     ED 43 A6 F9
 F61F  ret                                                 C9


; -- Used by WBOOT --
 F620  ld   a,$01                                          3E 01
 F622  ld   ($F9B2),a                                      32 B2 F9
 F625  call $F73A                                          CD 3A F7
 F628  ret                                                 C9


;
; -----  READ, Read a sector  -----
;

 F629  ld   de,$F9A8                                       11 A8 F9
 F62C  ld   hl,$F9AB                                       21 AB F9
 F62F  ld   b,$03                                          06 03
 F631  ld   a,(de)                                         1A
 F632  cp   (hl)                                           BE
 F633  jr   nz,$F647                                       20 12
 F635  inc  de                                             13
 F636  inc  hl                                             23
 F637  djnz $F631                                          10 F8
 F639  ld   hl,$FE80                                       21 80 FE
 F63C  ld   de,($F9A6)      ;  DMA address                 ED 5B A6 F9
 F640  ld   bc,$0080                                       01 80 00
 F643  ldir                                                ED B0
 F645  xor  a                                              AF
 F646  ret                                                 C9

 F647  ld   a,($F9AA)                                      3A AA F9
 F64A  rra                                                 1F
 F64B  jr   c,$F677                                        38 2A
 F64D  ld   de,$F9A8                                       11 A8 F9
 F650  ld   hl,$F9AE                                       21 AE F9
 F653  ld   b,$02                                          06 02
 F655  ld   a,(de)                                         1A
 F656  cp   (hl)                                           BE
 F657  jr   nz,$F677                                       20 1E
 F659  inc  de                                             13
 F65A  inc  hl                                             23
 F65B  djnz $F655                                          10 F8
 F65D  ld   a,(de)                                         1A
 F65E  rra                                                 1F
 F65F  jr   c,$F665                                        38 04
 F661  rla                                                 17
 F662  dec  a                                              3D
 F663  jr   $F666                                          18 01
 F665  rla                                                 17
 F666  cp   (hl)                                           BE
 F667  jr   nz,$F677                                       20 0E
 F669  ld   a,(de)                                         1A
 F66A  rra                                                 1F
 F66B  jr   c,$F672                                        38 05
 F66D  ld   hl,$FF80                                       21 80 FF
 F670  jr   $F63C                                          18 CA
 F672  ld   hl,$FF00                                       21 00 FF
 F675  jr   $F63C                                          18 C5
 F677  ld   hl,($F9A8)                                     2A A8 F9
 F67A  ld   ($F9AE),hl                                     22 AE F9
 F67D  xor  a                                              AF
 F67E  ld   a,($F9AA)                                      3A AA F9
 F681  rra                                                 1F
 F682  jr   c,$F688                                        38 04
 F684  rla                                                 17
 F685  dec  a                                              3D
 F686  jr   $F689                                          18 01
 F688  rla                                                 17
 F689  ld   ($F9B0),a                                      32 B0 F9
 F68C  call $F858                                          CD 58 F8
 F68F  or   a                                              B7
 F690  jr   z,$F64D                                        28 BB
 F692  ld   a,$01                                          3E 01
 F694  ret                                                 C9


; Enter here if "F:" was involved in a WRITE operation
 F695  ld   hl,$F6A4                                       21 A4 F6

; Print a zero terminated text string
 F698  ld   c,(hl)                                         4E
 F699  push hl                                             E5
 F69A  call $F4A3       ; CONOUT, Console output           CD A3 F4
 F69D  pop  hl                                             E1
 F69E  inc  hl                                             23
 F69F  ld   a,(hl)                                         7E
 F6A0  or   a                                              B7
 F6A1  jr   nz,$F698                                       20 F5
 F6A3  ret                                                 C9
 
F6A4  0D 0A 20 46 3A 20 64 69 73 6B 20 69 73 20 52 45   .. F: disk is RE
F6B4  41 44 20 4F 4E 4C 59 20 2C 20 62 65 63 61 75 73   AD ONLY , becaus
F6C4  65 20 34 30 20 74 72 61 63 6B 2F 73 69 64 65 0D   e 40 track/side.
F6D4  0A 00 


;
; -----  WRITE, Write a sector  -----
;

 F6D6  push bc                                             C5
 F6D7  ld   a,($F9A8)      ; Disk no.                      3A A8 F9
 F6DA  cp   $05            ; "F:" ?                        FE 05
 F6DC  call z,$F695        ; "Read only" message           CC 95 F6
 F6DF  pop  bc                                             C1
 F6E0  ld   a,c                                            79
 F6E1  cp   $01                                            FE 01
 F6E3  jr   nz,$F6E9                                       20 04
 F6E5  inc  a                                              3C
 F6E6  ld   ($F9B2),a                                      32 B2 F9
 F6E9  ld   a,($F9B1)                                      3A B1 F9
 F6EC  or   a                                              B7
 F6ED  jr   z,$F759                                        28 6A
 F6EF  ld   hl,($F9AB)                                     2A AB F9
 F6F2  ld   de,($F9A8)                                     ED 5B A8 F9
 F6F6  sbc  hl,de                                          ED 52
 F6F8  jr   nz,$F73A                                       20 40
 F6FA  ld   a,($F9AA)                                      3A AA F9
 F6FD  rra                                                 1F
 F6FE  jr   c,$F704                                        38 04
 F700  rla                                                 17
 F701  dec  a                                              3D
 F702  jr   $F706                                          18 02
 F704  rla                                                 17
 F705  inc  a                                              3C
 F706  ld   hl,$F9AD                                       21 AD F9
 F709  cp   (hl)                                           BE
 F70A  jr   nz,$F73A                                       20 2E
 F70C  bit  0,a                                            CB 47
 F70E  jr   nz,$F711                                       20 01
 F710  dec  a                                              3D
 F711  ld   ($F9B0),a                                      32 B0 F9
 F714  ld   hl,($F9A8)                                     2A A8 F9
 F717  ld   ($F9AE),hl                                     22 AE F9
 F71A  ld   de,($F9A6)      ;  DMA address                 ED 5B A6 F9
 F71E  ld   hl,$FF00                                       21 00 FF
 F721  ld   bc,$0080                                       01 80 00
 F724  ld   a,($F9AA)                                      3A AA F9
 F727  rra                                                 1F
 F728  jr   c,$F72B                                        38 01
 F72A  add  hl,bc                                          09
 F72B  ex   de,hl                                          EB
 F72C  ldir                                                ED B0
 F72E  call $F892                                          CD 92 F8
 F731  or   a                                              B7
 F732  ret  nz                                             C0
 F733  ld   ($F9B1),a                                      32 B1 F9
 F736  ld   ($F9B2),a                                      32 B2 F9
 F739  ret                                                 C9
 
 F73A  ld   hl,($F9AB)                                     2A AB F9
 F73D  ld   ($F9AE),hl                                     22 AE F9
 F740  ld   a,($F9AD)                                      3A AD F9
 F743  bit  0,a                                            CB 47
 F745  jr   nz,$F748                                       20 01
 F747  dec  a                                              3D
 F748  ld   ($F9B0),a                                      32 B0 F9
 F74B  call $F858                                          CD 58 F8
 F74E  or   a                                              B7
 F74F  ret  nz                                             C0
 F750  call $F892                                          CD 92 F8
 F753  ld   a,($F9B2)                                      3A B2 F9
 F756  dec  a                                              3D
 F757  jr   z,$F781                                        28 28
 F759  ld   hl,($F9A6)      ;  DMA address                 2A A6 F9
 F75C  ld   de,$FE80                                       11 80 FE
 F75F  ld   bc,$0080                                       01 80 00
 F762  ldir                                                ED B0
 F764  ld   hl,($F9A8)                                     2A A8 F9
 F767  ld   ($F9AB),hl                                     22 AB F9
 F76A  ld   a,($F9AA)                                      3A AA F9
 F76D  ld   ($F9AD),a                                      32 AD F9
 F770  ld   a,$01                                          3E 01
 F772  ld   ($F9B1),a                                      32 B1 F9
 F775  ld   hl,$F9B2                                       21 B2 F9
 F778  ld   a,(hl)                                         7E
 F779  or   a                                              B7
 F77A  jr   z,$F736                                        28 BA
 F77C  ld   a,$01                                          3E 01
 F77E  ld   (hl),a                                         77
 F77F  jr   $F73A                                          18 B9
 F781  ld   a,$FF                                          3E FF
 F783  ld   ($F9AB),a                                      32 AB F9
 F786  xor  a                                              AF
 F787  jr   $F733                                          18 AA
 F789  push af                                             F5
 F78A  push hl                                             E5
 F78B  ld   hl,$05DC                                       21 DC 05
 F78E  dec  hl                                             2B
 F78F  ld   a,h                                            7C
 F790  or   l                                              B5
 F791  jr   nz,$F78E                                       20 FB
 F793  ld   a,$FF                                          3E FF
 F795  ld   ($F99C),a                                      32 9C F9
 F798  pop  hl                                             E1
 F799  pop  af                                             F1
 F79A  cp   $00                                            FE 00
 F79C  jr   nz,$F7A6                                       20 08
 F79E  ld   a,($F99A)                                      3A 9A F9
 F7A1  cp   $04                                            FE 04
 F7A3  jr   z,$F7C9      ; Ask operator to change disk     28 24
 F7A5  ret                                                 C9
 F7A6  cp   $01                                            FE 01
 F7A8  jr   nz,$F7B2                                       20 08
 F7AA  ld   a,($F99B)                                      3A 9B F9
 F7AD  cp   $05                                            FE 05
 F7AF  jr   z,$F7CF                                        28 1E
 F7B1  ret                                                 C9
 F7B2  cp   $04                                            FE 04
 F7B4  jr   nz,$F7BE                                       20 08
 F7B6  ld   a,($F99A)                                      3A 9A F9
 F7B9  cp   $00                                            FE 00
 F7BB  jr   z,$F7C9      ; Ask operator to change disk     28 0C
 F7BD  ret                                                 C9
 F7BE  cp   $05                                            FE 05
 F7C0  ret  nz                                             C0
 F7C1  ld   a,($F99B)                                      3A 9B F9
 F7C4  cp   $01                                            FE 01
 F7C6  jr   z,$F7CF                                        28 07
 F7C8  ret                                                 C9

; Ask operator to change disk

 F7C9  ld   a,c                                            79
 F7CA  ld   ($F99A),a                                      32 9A F9
 F7CD  jr   $F7D3                                          18 04
 F7CF  ld   a,c                                            79
 F7D0  ld   ($F99B),a                                      32 9B F9
 F7D3  push bc                                             C5
 F7D4  push de                                             D5
 F7D5  push hl                                             E5
 F7D6  ld   hl,$F7F6    ; "Mount "                         21 F6 F7
 F7D9  push bc                                             C5
 F7DA  call $F698       ; Print message                    CD 98 F6
 F7DD  pop  bc                                             C1
 F7DE  ld   a,$41                                          3E 41
 F7E0  add  a,c         ; + 'A'                            81
 F7E1  ld   c,a                                            4F
 F7E2  call $F4A3       ; CONOUT, Console output           CD A3 F4
 F7E5  ld   hl,$F7FF    ; "[CR]"                           21 FF F7
 F7E8  call $F698       ; Print a message                  CD 98 F6
 F7EB  call $F348                                          CD 48 F3
 F7EE  cp   $0D                                            FE 0D
 F7F0  jr   nz,$F7EB                                       20 F9
 F7F2  pop  hl                                             E1
 F7F3  pop  de                                             D1
 F7F4  pop  bc                                             C1
 F7F5  ret                                                 C9

 F7F6  defb $0D, $0A
 F7F8  defm "Mount "
 7FFE  defb 0                                              00
 
 F7FF  defm " [CR]"
 F804  defb $0D, $0A
 F806  defb 0                                              00

 F807  ld   a,c                                            79
 F808  ld   hl,$F99D                                       21 9D F9
 F80B  cp   (hl)                                           BE
 F80C  call nz,$F789                                       C4 89 F7
 F80F  ld   a,c                                            79
 F810  cp   $04                                            FE 04
 F812  jr   nz,$F815                                       20 01
 F814  xor  a                                              AF
 F815  cp   $05                                            FE 05
 F817  jr   nz,$F81B                                       20 02
 F819  ld   a,$01                                          3E 01
 F81B  ld   l,a                                            6F
 F81C  ld   h,$00                                          26 00
 F81E  ld   de,$F99F                                       11 9F F9
 F821  add  hl,de                                          19
 F822  ld   a,c                                            79
 F823  cp   $05                                            FE 05
 F825  jr   z,$F853                                        28 2C
 F827  xor  a                                              AF
 F828  ld   a,(hl)                                         7E
 F829  rra                                                 1F
 F82A  cpl                                                 2F
 F82B  out  ($E5),a                                        D3 E5
 F82D  ld   a,c                                            79
 F82E  ld   ($F99D),a                                      32 9D F9
 F831  and  $03                                            E6 03
 F833  add  a,a                                            87
 F834  add  a,a                                            87
 F835  add  a,a                                            87
 F836  add  a,a                                            87
 F837  ld   c,a                                            4F
 
 F838  in   a,($E9)      ; PPI_M, port B                   DB E9
 F83A  and  $CF                                            E6 CF
 F83C  add  a,c                                            81
 F83D  out  ($E9),a                                        D3 E9
 
 F83F  ld   a,($F99C)                                      3A 9C F9
 F842  or   a                                              B7
 F843  jr   z,$F852                                        28 0D
 F845  push hl                                             E5
 F846  ld   hl,$1770                                       21 70 17
 F849  dec  hl                                             2B
 F84A  ld   a,h                                            7C
 F84B  or   l                                              B5
 F84C  jr   nz,$F849                                       20 FB
 F84E  ld   ($F99C),a                                      32 9C F9
 F851  pop  hl                                             E1
 F852  ret                                                 C9

 F853  ld   a,(hl)                                         7E
 F854  and  $FE                                            E6 FE
 F856  jr   $F82A                                          18 D2
 F858  ld   b,$0A                                          06 0A
 F85A  call $F8F0                                          CD F0 F8
 F85D  di                                                  F3
 F85E  ld   a,$7F                                          3E 7F
 F860  out  ($E4),a                                        D3 E4
 F862  ex   (sp),hl                                        E3
 F863  ex   (sp),hl                                        E3
 F864  ex   (sp),hl                                        E3
 F865  ex   (sp),hl                                        E3
 F866  ex   (sp),hl                                        E3
 F867  ex   (sp),hl                                        E3
 F868  ex   (sp),hl                                        E3
 F869  ex   (sp),hl                                        E3
 F86A  in   a,($E4)                                        DB E4
 F86C  xor  $FE                                            EE FE
 F86E  jr   nz,$F86A                                       20 FA
 F870  in   a,($E4)                                        DB E4
 F872  rra                                                 1F
 F873  jr   c,$F87F                                        38 0A
 F875  rra                                                 1F
 F876  jr   c,$F870                                        38 F8
 F878  in   a,($E7)                                        DB E7
 F87A  cpl                                                 2F
 F87B  ld   (hl),a                                         77
 F87C  inc  hl                                             23
 F87D  jr   $F870                                          18 F1
 F87F  in   a,($E4)                                        DB E4
 F881  ei                                                  FB
 F882  xor  $FF                                            EE FF
 F884  ret  z                                              C8
 F885  call $F965                                          CD 65 F9
 F888  djnz $F85A                                          10 D0
 F88A  ld   a,$FF                                          3E FF
 F88C  ld   ($F9AE),a                                      32 AE F9
 F88F  ld   a,$01                                          3E 01
 F891  ret                                                 C9

 F892  ld   hl,$FF00                                       21 00 FF
 F895  ld   de,$FE80                                       11 80 FE
 F898  ld   bc,$0080                                       01 80 00
 F89B  xor  a                                              AF
 F89C  ld   a,($F9AD)                                      3A AD F9
 F89F  rra                                                 1F
 F8A0  jr   c,$F8A3                                        38 01
 F8A2  add  hl,bc                                          09
 F8A3  ex   de,hl                                          EB
 F8A4  ldir                                                ED B0
 F8A6  ld   a,($F9A8)        ; Disk no.                    3A A8 F9
 F8A9  cp   $05                                            FE 05
 F8AB  jr   z,$F8ED                                        28 40
 F8AD  ld   b,$0A                                          06 0A
 F8AF  call $F8F0                                          CD F0 F8
 F8B2  di                                                  F3
 F8B3  ld   a,$5F                                          3E 5F
 F8B5  out  ($E4),a                                        D3 E4
 F8B7  ex   (sp),hl                                        E3
 F8B8  ex   (sp),hl                                        E3
 F8B9  ex   (sp),hl                                        E3
 F8BA  ex   (sp),hl                                        E3
 F8BB  ex   (sp),hl                                        E3
 F8BC  ex   (sp),hl                                        E3
 F8BD  ex   (sp),hl                                        E3
 F8BE  ex   (sp),hl                                        E3
 F8BF  ld   c,$E7                                          0E E7
 F8C1  in   a,($E4)                                        DB E4
 F8C3  xor  $FE                                            EE FE
 F8C5  jr   nz,$F8C1                                       20 FA
 F8C7  jr   $F8D3                                          18 0A
 F8C9  in   a,($E4)                                        DB E4
 F8CB  rra                                                 1F
 F8CC  jr   c,$F8DA                                        38 0C
 F8CE  rra                                                 1F
 F8CF  jr   c,$F8C9                                        38 F8
 F8D1  out  (c),e                                          ED 59
 F8D3  ld   a,(hl)                                         7E
 F8D4  cpl                                                 2F
 F8D5  ld   e,a                                            5F
 F8D6  inc  hl                                             23
 F8D7  jp   $F8C9                                          C3 C9 F8
 F8DA  push bc                                             C5

 F8DB  ld   b,$00                                          06 00
 F8DD  djnz $F8DD                                          10 FE
 F8DF  djnz $F8DF                                          10 FE

 F8E1  pop  bc                                             C1
 F8E2  in   a,($E4)                                        DB E4
 F8E4  ei                                                  FB
 F8E5  xor  $FF                                            EE FF
 F8E7  ret  z                                              C8
 F8E8  call $F965                                          CD 65 F9
 F8EB  djnz $F8AF                                          10 C2
 F8ED  ld   a,$01                                          3E 01
 F8EF  ret                                                 C9

 F8F0  ld   a,($F9AE)                                      3A AE F9
 F8F3  ld   c,a                                            4F
 F8F4  call $F807                                          CD 07 F8
 F8F7  xor  a                                              AF
 F8F8  ld   a,($F9AF)                                      3A AF F9
 F8FB  ld   (hl),a                                         77
 F8FC  ld   c,a                                            4F
 F8FD  ld   a,($F99D)                                      3A 9D F9
 F900  cp   $05                                            FE 05
 F902  jr   z,$F959                                        28 55
 F904  xor  a                                              AF
 F905  ld   a,c                                            79
 F906  rra                                                 1F
 F907  cpl                                                 2F
 F908  out  ($E7),a                                        D3 E7
 F90A  in   a,($E5)                                        DB E5
 F90C  ld   e,a                                            5F
 F90D  ld   c,$FF                                          0E FF
 F90F  ld   a,($F99D)                                      3A 9D F9
 F912  cp   $06                                            FE 06
 F914  jr   nz,$F918                                       20 02
 F916  ld   c,$FC                                          0E FC
 F918  ld   a,$E7                                          3E E7
 F91A  and  c                                              A1
 F91B  out  ($E4),a                                        D3 E4
 F91D  xor  a                                              AF
 F91E  ld   a,($F9B0)                                      3A B0 F9
 F921  inc  a                                              3C
 F922  rra                                                 1F
 F923  cpl                                                 2F
 F924  out  ($E6),a                                        D3 E6
 F926  ld   a,(hl)                                         7E
 F927  and  $01                                            E6 01
 F929  push bc                                             C5
 F92A  rra                                                 1F
 F92B  rra                                                 1F

 F92C  ld   c,a                                            4F
 F92D  in   a,($E9)      ; PPI_M, port B                   DB E9
 F92F  and  $7F          ; mask out disk side bit          E6 7F
 F931  add  a,c                                            81
 F932  pop  bc                                             C1
 F933  out  ($E9),a                                        D3 E9

 F935  ex   (sp),hl                                        E3
 F936  ex   (sp),hl                                        E3
 F937  in   a,($E4)                                        DB E4
 F939  rra                                                 1F
 F93A  jr   nc,$F937                                       30 FB
 F93C  rla                                                 17
 F93D  rla                                                 17
 F93E  jr   nc,$F8F0                                       30 B0
 F940  ld   a,($F99D)                                      3A 9D F9
 F943  cp   $05                                            FE 05
 F945  call z,$F95E                                        CC 5E F9
 F948  in   a,($E5)                                        DB E5
 F94A  cp   e                                              BB
 F94B  jr   z,$F955                                        28 08
 F94D  ld   hl,$0BB8                                       21 B8 0B
 F950  dec  hl                                             2B
 F951  ld   a,h                                            7C
 F952  or   l                                              B5
 F953  jr   nz,$F950                                       20 FB
 F955  ld   hl,$FF00                                       21 00 FF
 F958  ret                                                 C9
 F959  ld   a,c                                            79
 F95A  and  $FE                                            E6 FE
 F95C  jr   $F907                                          18 A9
 F95E  scf                                                 37
 F95F  in   a,($E5)                                        DB E5
 F961  rra                                                 1F
 F962  out  ($E5),a                                        D3 E5
 F964  ret                                                 C9

 F965  push bc                                             C5
 F966  in   a,($E5)                                        DB E5
 F968  ld   c,a                                            4F
 F969  ld   a,($F99D)                                      3A 9D F9
 F96C  cp   $06                                            FE 06
 F96E  ld   a,$F7                                          3E F7
 F970  jr   nz,$F974                                       20 02
 F972  and  $FC                                            E6 FC
 F974  out  ($E4),a                                        D3 E4
 F976  ld   b,$07                                          06 07
 F978  djnz $F978                                          10 FE
 F97A  in   a,($E4)                                        DB E4
 F97C  rra                                                 1F
 F97D  jr   nc,$F97A                                       30 FB
 F97F  ld   a,c                                            79
 F980  out  ($E7),a                                        D3 E7
 F982  ld   a,($F99D)                                      3A 9D F9
 F985  cp   $06                                            FE 06
 F987  ld   a,$E7                                          3E E7
 F989  jr   nz,$F98D                                       20 02
 F98B  and  $FC                                            E6 FC
 F98D  out  ($E4),a                                        D3 E4
 F98F  ld   b,$07                                          06 07
 F991  djnz $F991                                          10 FE
 F993  in   a,($E4)                                        DB E4
 F995  rra                                                 1F
 F996  jr   nc,$F993                                       30 FB
 F998  pop  bc                                             C1
 F999  ret                                                 C9

 F99A  defb 0                                              00
 F99B  defb 1                                              01
 F99C  defb 0                                              00
 F99D  defb 0                                              00

     F99E  00 04 FF FF FF FF FF FF 80 00 00 04 1C FF FF FF   ..ÿÿÿÿÿÿ.....ÿÿÿ
     F9AE  00 04 1B 00 00 FF FF FF FF FF FF FE 00 00 00 00   .....ÿÿÿÿÿÿþ....
     F9BE  00 00 00 00 00 00 00 00 00 20 20 23 31 2E 35 0D   .........  #1.5.
     F9CE  0A 00 30 44 30 30 30 30 30 30 30 30 30 30 31 42   ..0D00000000001B

     F9CE  0A 00 30 44 30 30 30 30 30 30 30 30 30 30 31 42   ..0D00000000001B
     F9DE  34 31 30 44 30 30 30 30 30 30 30 30 30 30 31 42   410D00000000001B
     F9EE  34 44 30 44 30 30 30 30 30 30 30 30 30 30 30 38   4D0D000000000008
     F9FE  30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 43   000000000000000C
     FA0E  30 30 30 30 30 30 30 30 30


     FA17  1B A4 D7 9B 36 C1 DD 80 80 80 80 80 80 80 80 80   .¤×.6ÁÝ.........
     FA27  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80   ................

     FA37  30 30 30 41 30 30 30 30 30 30 30 30 30 30 30 30   000A000000000000
     FA47  30 30 31 34 30 30 30 30 30 30 30 30 30 30 30 30   0014000000000000

     FA57  30 30 30 45 30 46 30 38 30 39 30 41 30 44 31 42   000E0F08090A0D1B
     FA67  44 42 45 41 45 36 38 30 32 38 46 41 44 42 45 39   DBEAE68028FADBE9

     FA77  45 36 46 45 44 33 45 39 37 39 44 33 45 38 46 45   E6FED3E979D3E8FE
     FA87  31 42 32 38 36 32 46 45 32 30 44 38 33 41 32 46   1B2862FE20D83A2F

     FA97  46 35 34 38 0D 0A 3A 33 32 32 32 33 43 30 30 42   F548..:32223C00B
     FAA7  37 43 38 46 45 30 32 32 38 31 31 33 30 35 44 37   7C8FE022811305D7

     FAB7  39 46 45 35 31 32 38 32 37 46 45 34 38 32 30 35   9FE512827FE48205
     FAC7  34 33 45 30 32 33 32 32 46 46 35 43 39 37 39 46   43E02322FF5C979F

     FAD7  45 35 32 32 30 34 39 44 42 45 38 30 36 30 30 43   E522049DBE80600C
     FAE7  44 30 46 46 35 32 38 34 30 44 42 45 38 36 46 32   D0FF52840DBE86F2
     FAF7  36 37 46 32 32 33 30 46 35 EA 3A D4 F1 C3 01 E7   67F2230F5ê:ÔñÃ.ç



     FABE  32 37 46 45 34 38 32 30 35 34 33 45 30 32 33 32   27FE4820543E0232
     FACE  32 46 46 35 43 39 37 39 46 45 35 32 32 30 34 39   2FF5C979FE522049
     FADE  44 42 45 38 30 36 30 30 43 44 30 46 46 35 32 38   DBE80600CD0FF528
     FAEE  34 30 44 42 45 38 36 46 32 36 37 46 32 32 33 30   40DBE86F267F2230
     FAFE  46 35                                             F5
	 
 FB00  jp   pe,$D43A                                       EA 3A D4
 FB03  pop  af                                             F1
 FB04  jp   $E701                                          C3 01 E7
 FB07  push bc                                             C5
 FB08  push af                                             F5
 FB09  ld   a,($F1C5)                                      3A C5 F1
 FB0C  cpl                                                 2F
 FB0D  ld   b,a                                            47
 FB0E  ld   a,c                                            79
 FB0F  and  b                                              A0
 FB10  ld   c,a                                            4F
 FB11  pop  af                                             F1
 FB12  and  b                                              A0
 FB13  sub  c                                              91
 FB14  and  $1F                                            E6 1F
 FB16  pop  bc                                             C1
 FB17  ret                                                 C9

 FB18  ld   a,$FF                                          3E FF
 FB1A  ld   ($F1D4),a                                      32 D4 F1
 FB1D  ld   hl,$F1D8                                       21 D8 F1
 FB20  ld   (hl),c                                         71
 FB21  ld   hl,($E743)                                     2A 43 E7
 FB24  ld   ($F1D9),hl                                     22 D9 F1
 FB27  call $E9FE                                          CD FE E9
 FB2A  call $E7A1                                          CD A1 E7
 FB2D  ld   c,$00                                          0E 00
 FB2F  call $EA05                                          CD 05 EA
 FB32  call $E9F5                                          CD F5 E9
 FB35  jp   z,$EB94                                        CA 94 EB
 FB38  ld   hl,($F1D9)                                     2A D9 F1
 FB3B  ex   de,hl                                          EB
 FB3C  ld   a,(de)                                         1A
 FB3D  cp   $E5                                            FE E5
 FB3F  jp   z,$EB4A                                        CA 4A EB
 FB42  push de                                             D5
 FB43  call $E97F                                          CD 7F E9
 FB46  pop  de                                             D1
 FB47  jp   nc,$EB94                                       D2 94 EB
 FB4A  call $E95E                                          CD 5E E9
 FB4D  ld   a,($F1D8)                                      3A D8 F1
 FB50  ld   c,a                                            4F
 FB51  ld   b,$00                                          06 00
 FB53  ld   a,c                                            79
 FB54  or   a                                              B7
 FB55  jp   z,$EB83                                        CA 83 EB
 FB58  ld   a,(de)                                         1A
 FB59  cp   $3F                                            FE 3F
 FB5B  jp   z,$EB7C                                        CA 7C EB
 FB5E  ld   a,b                                            78
 FB5F  cp   $0D                                            FE 0D
 FB61  jp   z,$EB7C                                        CA 7C EB
 FB64  cp   $0C                                            FE 0C
 FB66  ld   a,(de)                                         1A
 FB67  jp   z,$EB73                                        CA 73 EB
 FB6A  sub  (hl)                                           96
 FB6B  and  $7F                                            E6 7F
 FB6D  jp   nz,$EB2D                                       C2 2D EB
 FB70  jp   $EB7C                                          C3 7C EB
 FB73  push bc                                             C5
 FB74  ld   c,(hl)                                         4E
 FB75  call $EB07                                          CD 07 EB
 FB78  pop  bc                                             C1
 FB79  jp   nz,$EB2D                                       C2 2D EB
 FB7C  inc  de                                             13
 FB7D  inc  hl                                             23
 FB7E  inc  b                                              04
 FB7F  dec  c                                              0D
 FB80  jp   $EB53                                          C3 53 EB
 FB83  ld   a,($F1EA)                                      3A EA F1
 FB86  and  $03                                            E6 03
 FB88  ld   ($E745),a                                      32 45 E7
 FB8B  ld   hl,$F1D4                                       21 D4 F1
 FB8E  ld   a,(hl)                                         7E
 FB8F  rla                                                 17
 FB90  ret  nc                                             D0
 FB91  xor  a                                              AF
 FB92  ld   (hl),a                                         77
 FB93  ret                                                 C9

 FB94  call $E9FE                                          CD FE E9
 FB97  ld   a,$FF                                          3E FF
 FB99  jp   $E701                                          C3 01 E7
 FB9C  call $E954                                          CD 54 E9
 FB9F  ld   c,$0C                                          0E 0C
 FBA1  call $EB18                                          CD 18 EB
 FBA4  call $E9F5                                          CD F5 E9
 FBA7  ret  z                                              C8
 FBA8  call $E944                                          CD 44 E9
 FBAB  call $E95E                                          CD 5E E9
 FBAE  ld   (hl),$E5                                       36 E5
 FBB0  ld   c,$00                                          0E 00
 FBB2  call $EA6B                                          CD 6B EA
 FBB5  call $E9C6                                          CD C6 E9
 FBB8  call $EB2D                                          CD 2D EB
 FBBB  jp   $EBA4                                          C3 A4 EB
 FBBE  ld   d,b                                            50
 FBBF  ld   e,c                                            59
 FBC0  ld   a,c                                            79
 FBC1  or   b                                              B0
 FBC2  jp   z,$EBD1                                        CA D1 EB
 FBC5  dec  bc                                             0B
 FBC6  push de                                             D5
 FBC7  push bc                                             C5
 FBC8  call $EA35                                          CD 35 EA
 FBCB  rra                                                 1F
 FBCC  jp   nc,$EBEC                                       D2 EC EB
 FBCF  pop  bc                                             C1
 FBD0  pop  de                                             D1
 FBD1  ld   hl,($F1C6)                                     2A C6 F1
 FBD4  ld   a,e                                            7B
 FBD5  sub  l                                              95
 FBD6  ld   a,d                                            7A
 FBD7  sbc  a,h                                            9C
 FBD8  jp   nc,$EBF4                                       D2 F4 EB
 FBDB  inc  de                                             13
 FBDC  push bc                                             C5
 FBDD  push de                                             D5
 FBDE  ld   b,d                                            42
 FBDF  ld   c,e                                            4B
 FBE0  call $EA35                                          CD 35 EA
 FBE3  rra                                                 1F
 FBE4  jp   nc,$EBEC                                       D2 EC EB
 FBE7  pop  de                                             D1
 FBE8  pop  bc                                             C1
 FBE9  jp   $EBC0                                          C3 C0 EB
 FBEC  rla                                                 17
 FBED  inc  a                                              3C
 FBEE  call $EA64                                          CD 64 EA
 FBF1  pop  hl                                             E1
 FBF2  pop  de                                             D1
 FBF3  ret                                                 C9

 FBF4  ld   a,c                                            79
 FBF5  or   b                                              B0
 FBF6  jp   nz,$EBC0                                       C2 C0 EB
 FBF9  ld   hl,$0000                                       21 00 00
 FBFC  ret                                                 C9

 FBFD  ld   c,$00                                          0E 00
 FBFF  ld   e,$20                                          1E 20
 FC01  push de                                             D5
 FC02  ld   b,$00                                          06 00
 FC04  ld   hl,($E743)                                     2A 43 E7
 FC07  add  hl,bc                                          09
 FC08  ex   de,hl                                          EB
 FC09  call $E95E                                          CD 5E E9
 FC0C  pop  bc                                             C1
 FC0D  call $E74F                                          CD 4F E7
 FC10  call $E7C3                                          CD C3 E7
 FC13  jp   $E9C6                                          C3 C6 E9
 FC16  call $E954                                          CD 54 E9
 FC19  ld   c,$0C                                          0E 0C
 FC1B  call $EB18                                          CD 18 EB
 FC1E  ld   hl,($E743)                                     2A 43 E7
 FC21  ld   a,(hl)                                         7E
 FC22  ld   de,$0010                                       11 10 00
 FC25  add  hl,de                                          19
 FC26  ld   (hl),a                                         77
 FC27  call $E9F5                                          CD F5 E9
 FC2A  ret  z                                              C8
 FC2B  call $E944                                          CD 44 E9
 FC2E  ld   c,$10                                          0E 10
 FC30  ld   e,$0C                                          1E 0C
 FC32  call $EC01                                          CD 01 EC
 FC35  call $EB2D                                          CD 2D EB
 FC38  jp   $EC27                                          C3 27 EC
 FC3B  ld   c,$0C                                          0E 0C
 FC3D  call $EB18                                          CD 18 EB
 FC40  call $E9F5                                          CD F5 E9
 FC43  ret  z                                              C8
 FC44  ld   c,$00                                          0E 00
 FC46  ld   e,$0C                                          1E 0C
 FC48  call $EC01                                          CD 01 EC
 FC4B  call $EB2D                                          CD 2D EB
 FC4E  jp   $EC40                                          C3 40 EC
 FC51  ld   c,$0F                                          0E 0F
 FC53  call $EB18                                          CD 18 EB
 FC56  call $E9F5                                          CD F5 E9
 FC59  ret  z                                              C8
 FC5A  call $E8A6                                          CD A6 E8
 FC5D  ld   a,(hl)                                         7E
 FC5E  push af                                             F5
 FC5F  push hl                                             E5
 FC60  call $E95E                                          CD 5E E9
 FC63  ex   de,hl                                          EB
 FC64  ld   hl,($E743)                                     2A 43 E7
 FC67  ld   c,$20                                          0E 20
 FC69  push de                                             D5
 FC6A  call $E74F                                          CD 4F E7
 FC6D  call $E978                                          CD 78 E9
 FC70  pop  de                                             D1
 FC71  ld   hl,$000C                                       21 0C 00
 FC74  add  hl,de                                          19
 FC75  ld   c,(hl)                                         4E
 FC76  ld   hl,$000F                                       21 0F 00
 FC79  add  hl,de                                          19
 FC7A  ld   b,(hl)                                         46
 FC7B  pop  hl                                             E1
 FC7C  pop  af                                             F1
 FC7D  ld   (hl),a                                         77
 FC7E  ld   a,c                                            79
 FC7F  cp   (hl)                                           BE
 FC80  ld   a,b                                            78
 FC81  jp   z,$EC8B                                        CA 8B EC
 FC84  ld   a,$00                                          3E 00
 FC86  jp   c,$EC8B                                        DA 8B EC
 FC89  ld   a,$80                                          3E 80
 FC8B  ld   hl,($E743)                                     2A 43 E7
 FC8E  ld   de,$000F                                       11 0F 00
 FC91  add  hl,de                                          19
 FC92  ld   (hl),a                                         77
 FC93  ret                                                 C9
 FC94  ld   a,(hl)                                         7E
 FC95  inc  hl                                             23
 FC96  or   (hl)                                           B6
 FC97  dec  hl                                             2B
 FC98  ret  nz                                             C0
 FC99  ld   a,(de)                                         1A
 FC9A  ld   (hl),a                                         77
 FC9B  inc  de                                             13
 FC9C  inc  hl                                             23
 FC9D  ld   a,(de)                                         1A
 FC9E  ld   (hl),a                                         77
 FC9F  dec  de                                             1B
 FCA0  dec  hl                                             2B
 FCA1  ret                                                 C9
 FCA2  xor  a                                              AF
 FCA3  ld   ($E745),a                                      32 45 E7
 FCA6  ld   ($F1EA),a                                      32 EA F1
 FCA9  ld   ($F1EB),a                                      32 EB F1
 FCAC  call $E91E                                          CD 1E E9
 FCAF  ret  nz                                             C0
 FCB0  call $E969                                          CD 69 E9
 FCB3  and  $80                                            E6 80
 FCB5  ret  nz                                             C0
 FCB6  ld   c,$0F                                          0E 0F
 FCB8  call $EB18                                          CD 18 EB
 FCBB  call $E9F5                                          CD F5 E9
 FCBE  ret  z                                              C8
 FCBF  ld   bc,$0010                                       01 10 00
 FCC2  call $E95E                                          CD 5E E9
 FCC5  add  hl,bc                                          09
 FCC6  ex   de,hl                                          EB
 FCC7  ld   hl,($E743)                                     2A 43 E7
 FCCA  add  hl,bc                                          09
 FCCB  ld   c,$10                                          0E 10
 FCCD  ld   a,($F1DD)                                      3A DD F1
 FCD0  or   a                                              B7
 FCD1  jp   z,$ECE8                                        CA E8 EC
 FCD4  ld   a,(hl)                                         7E
 FCD5  or   a                                              B7
 FCD6  ld   a,(de)                                         1A
 FCD7  jp   nz,$ECDB                                       C2 DB EC
 FCDA  ld   (hl),a                                         77
 FCDB  or   a                                              B7
 FCDC  jp   nz,$ECE1                                       C2 E1 EC
 FCDF  ld   a,(hl)                                         7E
 FCE0  ld   (de),a                                         12
 FCE1  cp   (hl)                                           BE
 FCE2  jp   nz,$ED1F                                       C2 1F ED
 FCE5  jp   $ECFD                                          C3 FD EC
 FCE8  call $EC94                                          CD 94 EC
 FCEB  ex   de,hl                                          EB
 FCEC  call $EC94                                          CD 94 EC
 FCEF  ex   de,hl                                          EB
 FCF0  ld   a,(de)                                         1A
 FCF1  cp   (hl)                                           BE
 FCF2  jp   nz,$ED1F                                       C2 1F ED
 FCF5  inc  de                                             13
 FCF6  inc  hl                                             23
 FCF7  ld   a,(de)                                         1A
 FCF8  cp   (hl)                                           BE
 FCF9  jp   nz,$ED1F                                       C2 1F ED
 FCFC  dec  c                                              0D
 FCFD  inc  de                                             13
 FCFE  inc  hl                                             23
 FCFF  dec  c                                              0D
 FD00  jp   nz,$ECCD                                       C2 CD EC
 FD03  ld   bc,$FFEC                                       01 EC FF
 FD06  add  hl,bc                                          09
 FD07  ex   de,hl                                          EB
 FD08  add  hl,bc                                          09
 FD09  ld   a,(de)                                         1A
 FD0A  cp   (hl)                                           BE
 FD0B  jp   c,$ED17                                        DA 17 ED
 FD0E  ld   (hl),a                                         77
 FD0F  ld   bc,$0003                                       01 03 00
 FD12  add  hl,bc                                          09
 FD13  ex   de,hl                                          EB
 FD14  add  hl,bc                                          09
 FD15  ld   a,(hl)                                         7E
 FD16  ld   (de),a                                         12
 FD17  ld   a,$FF                                          3E FF
 FD19  ld   ($F1D2),a                                      32 D2 F1
 FD1C  jp   $EC10                                          C3 10 EC
 FD1F  ld   hl,$E745                                       21 45 E7
 FD22  dec  (hl)                                           35
 FD23  ret                                                 C9
 FD24  call $E954                                          CD 54 E9
 FD27  ld   hl,($E743)                                     2A 43 E7
 FD2A  push hl                                             E5
 FD2B  ld   hl,$F1AC                                       21 AC F1
 FD2E  ld   ($E743),hl                                     22 43 E7
 FD31  ld   c,$01                                          0E 01
 FD33  call $EB18                                          CD 18 EB
 FD36  call $E9F5                                          CD F5 E9
 FD39  pop  hl                                             E1
 FD3A  ld   ($E743),hl                                     22 43 E7
 FD3D  ret  z                                              C8
 FD3E  ex   de,hl                                          EB
 FD3F  ld   hl,$000F                                       21 0F 00
 FD42  add  hl,de                                          19
 FD43  ld   c,$11                                          0E 11
 FD45  xor  a                                              AF
 FD46  ld   (hl),a                                         77
 FD47  inc  hl                                             23
 FD48  dec  c                                              0D
 FD49  jp   nz,$ED46                                       C2 46 ED
 FD4C  ld   hl,$000D                                       21 0D 00
 FD4F  add  hl,de                                          19
 FD50  ld   (hl),a                                         77
 FD51  call $E98C                                          CD 8C E9
 FD54  call $EBFD                                          CD FD EB
 FD57  jp   $E978                                          C3 78 E9
 FD5A  xor  a                                              AF
 FD5B  ld   ($F1D2),a                                      32 D2 F1
 FD5E  call $ECA2                                          CD A2 EC
 FD61  call $E9F5                                          CD F5 E9
 FD64  ret  z                                              C8
 FD65  ld   hl,($E743)                                     2A 43 E7
 FD68  ld   bc,$000C                                       01 0C 00
 FD6B  add  hl,bc                                          09
 FD6C  ld   a,(hl)                                         7E
 FD6D  inc  a                                              3C
 FD6E  and  $1F                                            E6 1F
 FD70  ld   (hl),a                                         77
 FD71  jp   z,$ED83                                        CA 83 ED
 FD74  ld   b,a                                            47
 FD75  ld   a,($F1C5)                                      3A C5 F1
 FD78  and  b                                              A0
 FD79  ld   hl,$F1D2                                       21 D2 F1
 FD7C  and  (hl)                                           A6
 FD7D  jp   z,$ED8E                                        CA 8E ED
 FD80  jp   $EDAC                                          C3 AC ED
 FD83  ld   bc,$0002                                       01 02 00
 FD86  add  hl,bc                                          09
 FD87  inc  (hl)                                           34
 FD88  ld   a,(hl)                                         7E
 FD89  and  $0F                                            E6 0F
 FD8B  jp   z,$EDB6                                        CA B6 ED
 FD8E  ld   c,$0F                                          0E 0F
 FD90  call $EB18                                          CD 18 EB
 FD93  call $E9F5                                          CD F5 E9
 FD96  jp   nz,$EDAC                                       C2 AC ED
 FD99  ld   a,($F1D3)                                      3A D3 F1
 FD9C  inc  a                                              3C
 FD9D  jp   z,$EDB6                                        CA B6 ED
 FDA0  call $ED24                                          CD 24 ED
 FDA3  call $E9F5                                          CD F5 E9
 FDA6  jp   z,$EDB6                                        CA B6 ED
 FDA9  jp   $EDAF                                          C3 AF ED
 FDAC  call $EC5A                                          CD 5A EC
 FDAF  call $E8BB                                          CD BB E8
 FDB2  xor  a                                              AF
 FDB3  jp   $E701                                          C3 01 E7
 FDB6  call $E705                                          CD 05 E7
 FDB9  jp   $E978                                          C3 78 E9
 FDBC  ld   a,$01                                          3E 01
 FDBE  ld   ($F1D5),a                                      32 D5 F1
 FDC1  ld   a,$FF                                          3E FF
 FDC3  ld   ($F1D3),a                                      32 D3 F1
 FDC6  call $E8BB                                          CD BB E8
 FDC9  ld   a,($F1E3)                                      3A E3 F1
 FDCC  ld   hl,$F1E1                                       21 E1 F1
 FDCF  cp   (hl)                                           BE
 FDD0  jp   c,$EDE6                                        DA E6 ED
 FDD3  cp   $80                                            FE 80
 FDD5  jp   nz,$EDFB                                       C2 FB ED
 FDD8  call $ED5A                                          CD 5A ED
 FDDB  xor  a                                              AF
 FDDC  ld   ($F1E3),a                                      32 E3 F1
 FDDF  ld   a,($E745)                                      3A 45 E7
 FDE2  or   a                                              B7
 FDE3  jp   nz,$EDFB                                       C2 FB ED
 FDE6  call $E877                                          CD 77 E8
 FDE9  call $E884                                          CD 84 E8
 FDEC  jp   z,$EDFB                                        CA FB ED
 FDEF  call $E88A                                          CD 8A E8
 FDF2  call $E7D1                                          CD D1 E7
 FDF5  call $E7B2                                          CD B2 E7
 FDF8  jp   $E8D2                                          C3 D2 E8
 FDFB  jp   $E705                                          C3 05 E7

 FDFE  ld   a,$01                                          3E 01

 FE00  push hl                                             E5
 FE01  push hl                                             E5
 FE02  push hl                                             E5
 FE03  push hl                                             E5
 FE04  push hl                                             E5
 ...
 
 
 
